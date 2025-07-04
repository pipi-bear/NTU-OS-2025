// File system implementation.  Five layers:
//   + Blocks: allocator for raw disk blocks.
//   + Log: crash recovery for multi-step updates.
//   + Files: inode allocator, reading, writing, metadata.
//   + Directories: inode with special contents (list of other inodes!)
//   + Names: paths like /usr/rtm/xv6/fs.c for convenient naming.
//
// This file contains the low-level file system manipulation
// routines.  The (higher-level) system call implementations
// are in sysfile.c.

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"
#include "file.h"

#define min(a, b) ((a) < (b) ? (a) : (b))
// there should be one superblock per disk device, but we run with
// only one device
struct superblock sb;

// Read the super block.
static void readsb(int dev, struct superblock *sb)
{
    struct buf *bp;

    bp = bread(dev, 1);
    memmove(sb, bp->data, sizeof(*sb));
    brelse(bp);
}

// Init fs
void fsinit(int dev)
{
    readsb(dev, &sb);
    if (sb.magic != FSMAGIC)
        panic("invalid file system");
    initlog(dev, &sb);
}

// Zero a block.
static void bzero(int dev, int bno)
{
    struct buf *bp;

    bp = bread(dev, bno);
    memset(bp->data, 0, BSIZE);
    log_write(bp);
    brelse(bp);
}

// Blocks.

// Allocate a zeroed disk block.
static uint balloc(uint dev)
{
    int b, bi, m;
    struct buf *bp;

    bp = 0;
    for (b = 0; b < sb.size; b += BPB)
    {
        bp = bread(dev, BBLOCK(b, sb));
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
        {
            m = 1 << (bi % 8);
            if ((bp->data[bi / 8] & m) == 0)
            {                          // Is block free?
                bp->data[bi / 8] |= m; // Mark block in use.
                log_write(bp);
                brelse(bp);
                bzero(dev, b + bi);
                return b + bi;
            }
        }
        brelse(bp);
    }
    panic("balloc: out of blocks");
}

// Free a disk block.
static void bfree(int dev, uint b)
{
    struct buf *bp;
    int bi, m;

    bp = bread(dev, BBLOCK(b, sb));
    bi = b % BPB;
    m = 1 << (bi % 8);
    if ((bp->data[bi / 8] & m) == 0)
        panic("freeing free block");
    bp->data[bi / 8] &= ~m;
    log_write(bp);
    brelse(bp);
}

// Inodes.
//
// An inode describes a single unnamed file.
// The inode disk structure holds metadata: the file's type,
// its size, the number of links referring to it, and the
// list of blocks holding the file's content.
//
// The inodes are laid out sequentially on disk at
// sb.startinode. Each inode has a number, indicating its
// position on the disk.
//
// The kernel keeps a cache of in-use inodes in memory
// to provide a place for synchronizing access
// to inodes used by multiple processes. The cached
// inodes include book-keeping information that is
// not stored on disk: ip->ref and ip->valid.
//
// An inode and its in-memory representation go through a
// sequence of states before they can be used by the
// rest of the file system code.
//
// * Allocation: an inode is allocated if its type (on disk)
//   is non-zero. ialloc() allocates, and iput() frees if
//   the reference and link counts have fallen to zero.
//
// * Referencing in cache: an entry in the inode cache
//   is free if ip->ref is zero. Otherwise ip->ref tracks
//   the number of in-memory pointers to the entry (open
//   files and current directories). iget() finds or
//   creates a cache entry and increments its ref; iput()
//   decrements ref.
//
// * Valid: the information (type, size, &c) in an inode
//   cache entry is only correct when ip->valid is 1.
//   ilock() reads the inode from
//   the disk and sets ip->valid, while iput() clears
//   ip->valid if ip->ref has fallen to zero.
//
// * Locked: file system code may only examine and modify
//   the information in an inode and its content if it
//   has first locked the inode.
//
// Thus a typical sequence is:
//   ip = iget(dev, inum)
//   ilock(ip)
//   ... examine and modify ip->xxx ...
//   iunlock(ip)
//   iput(ip)
//
// ilock() is separate from iget() so that system calls can
// get a long-term reference to an inode (as for an open file)
// and only lock it for short periods (e.g., in read()).
// The separation also helps avoid deadlock and races during
// pathname lookup. iget() increments ip->ref so that the inode
// stays cached and pointers to it remain valid.
//
// Many internal file system functions expect the caller to
// have locked the inodes involved; this lets callers create
// multi-step atomic operations.
//
// The icache.lock spin-lock protects the allocation of icache
// entries. Since ip->ref indicates whether an entry is free,
// and ip->dev and ip->inum indicate which i-node an entry
// holds, one must hold icache.lock while using any of those fields.
//
// An ip->lock sleep-lock protects all ip-> fields other than ref,
// dev, and inum.  One must hold ip->lock in order to
// read or write that inode's ip->valid, ip->size, ip->type, &c.

struct
{
    struct spinlock lock;
    struct inode inode[NINODE];
} icache;

void iinit()
{
    int i = 0;

    initlock(&icache.lock, "icache");
    for (i = 0; i < NINODE; i++)
    {
        initsleeplock(&icache.inode[i].lock, "inode");
    }
}

static struct inode *iget(uint dev, uint inum);

/* TODO: Access Control & Symbolic Link */
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode *ialloc(uint dev, short type)
{
    int inum;
    struct buf *bp;
    struct dinode *dip;

    for (inum = 1; inum < sb.ninodes; inum++)
    {
        bp = bread(dev, IBLOCK(inum, sb));
        dip = (struct dinode *)bp->data + inum % IPB;
        if (dip->type == 0)
        { // a free inode
            memset(dip, 0, sizeof(*dip));
            dip->type = type;
            log_write(bp); // mark it allocated on the disk
            brelse(bp);
            return iget(dev, inum);
        }
        brelse(bp);
    }
    panic("ialloc: no inodes");
}

/* TODO: Access Control & Symbolic Link */
// Copy a modified in-memory inode to disk.
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void iupdate(struct inode *ip)
{
    struct buf *bp;
    struct dinode *dip;

    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    dip->type = ip->type;
    dip->major = ip->major;
    dip->minor = ip->minor;
    dip->nlink = ip->nlink;
    dip->size = ip->size;
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    log_write(bp);
    brelse(bp);
}

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode *iget(uint dev, uint inum)
{
    struct inode *ip, *empty;

    acquire(&icache.lock);

    // Is the inode already cached?
    empty = 0;
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
    {
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
        {
            ip->ref++;
            release(&icache.lock);
            return ip;
        }
        if (empty == 0 && ip->ref == 0) // Remember empty slot.
            empty = ip;
    }

    // Recycle an inode cache entry.
    if (empty == 0)
        panic("iget: no inodes");

    ip = empty;
    ip->dev = dev;
    ip->inum = inum;
    ip->ref = 1;
    ip->valid = 0;
    release(&icache.lock);

    return ip;
}

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode *idup(struct inode *ip)
{
    acquire(&icache.lock);
    ip->ref++;
    release(&icache.lock);
    return ip;
}

/* TODO: Access Control & Symbolic Link */
// Lock the given inode.
// Reads the inode from disk if necessary.
void ilock(struct inode *ip)
{
    struct buf *bp;
    struct dinode *dip;

    if (ip == 0 || ip->ref < 1)
        panic("ilock");

    acquiresleep(&ip->lock);

    if (ip->valid == 0)
    {
        bp = bread(ip->dev, IBLOCK(ip->inum, sb));
        dip = (struct dinode *)bp->data + ip->inum % IPB;
        ip->type = dip->type;
        ip->major = dip->major;
        ip->minor = dip->minor;
        ip->nlink = dip->nlink;
        ip->size = dip->size;
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
        brelse(bp);
        ip->valid = 1;
        if (ip->type == 0)
            panic("ilock: no type");
    }
}

// Unlock the given inode.
void iunlock(struct inode *ip)
{
    if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1){
        // if (ip == 0) {
        //     printf("iunlock panic: ip is NULL\n");
        // } else {
        //     printf("iunlock panic: ip->inum %d, type %d, dev %d, ref %d, holdingsleep %d\n",
        //         ip->inum, ip->type, ip->dev, ip->ref, holdingsleep(&ip->lock));
        // }
        panic("iunlock");
    }

    releasesleep(&ip->lock);
}

// Drop a reference to an in-memory inode.
// If that was the last reference, the inode cache entry can
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void iput(struct inode *ip)
{
    acquire(&icache.lock);

    if (ip->ref == 1 && ip->valid && ip->nlink == 0)
    {
        // inode has no links and no other references: truncate and free.

        // ip->ref == 1 means no other process can have ip locked,
        // so this acquiresleep() won't block (or deadlock).
        acquiresleep(&ip->lock);

        release(&icache.lock);

        itrunc(ip);
        ip->type = 0;
        iupdate(ip);
        ip->valid = 0;

        releasesleep(&ip->lock);

        acquire(&icache.lock);
    }

    ip->ref--;
    release(&icache.lock);
}

// Common idiom: unlock, then put.
void iunlockput(struct inode *ip)
{
    iunlock(ip);
    iput(ip);
}

// Inode content
//
// The content (data) associated with each inode is stored
// in blocks on the disk. The first NDIRECT block numbers
// are listed in ip->addrs[].  The next NINDIRECT blocks are
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.

uint bmap(struct inode *ip, uint bn)
{
    uint addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) //
    {
        if ((addr = ip->addrs[bn]) == 0)
        {
            addr = balloc(ip->dev);
            if (addr == 0)
                panic("bmap: balloc failed");
            ip->addrs[bn] = addr;
        }
        return addr;
    }
    bn -= NDIRECT;
    if (bn < NINDIRECT)
    {
        if ((addr = ip->addrs[NDIRECT]) == 0)
        {
            addr = balloc(ip->dev);
            if (addr == 0)
                panic("bmap: balloc failed for indirect block");
            ip->addrs[NDIRECT] = addr;
        }

        bp = bread(ip->dev, addr);
        a = (uint *)bp->data;

        uint target_addr = a[bn];

        if (target_addr == 0)
        {
            target_addr = balloc(ip->dev);
            if (target_addr == 0)
                panic("bmap: balloc failed for data block via indirect");
            a[bn] = target_addr;
            log_write(bp);
        }
        brelse(bp);

        return target_addr;
    }

    printf("bmap: ERROR! file_bn %d is out of range for inode %d\n",
           bn + NDIRECT, ip->inum);
    panic("bmap: out of range");
}

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void itrunc(struct inode *ip)
{
    int i, j;
    struct buf *bp;
    uint *a;

    for (i = 0; i < NDIRECT; i++)
    {
        if (ip->addrs[i])
        {
            bfree(ip->dev, ip->addrs[i]);
            ip->addrs[i] = 0;
        }
    }

    if (ip->addrs[NDIRECT])
    {
        bp = bread(ip->dev, ip->addrs[NDIRECT]);
        a = (uint *)bp->data;
        for (j = 0; j < NINDIRECT; j++)
        {
            if (a[j])
                bfree(ip->dev, a[j]);
        }
        brelse(bp);
        bfree(ip->dev, ip->addrs[NDIRECT]);
        ip->addrs[NDIRECT] = 0;
    }

    ip->size = 0;
    iupdate(ip);
}

/* TODO: Access Control & Symbolic Link */
// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st)
{
    st->dev = ip->dev;
    st->ino = ip->inum;
    st->type = ip->type;
    st->nlink = ip->nlink;
    st->minor = ip->minor;
    st->size = ip->size;
}

// Read data from inode.
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.

// return value: tot = number of bytes read
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    uint tot, m;
    struct buf *bp;

    if (off > ip->size || off + n < off)
        return 0;
    if (off + n > ip->size)
        n = ip->size - off;

    for (tot = 0; tot < n; tot += m, off += m, dst += m)
    {
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
        m = min(n - tot, BSIZE - off % BSIZE);
        if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1)
        {
            brelse(bp);
            break;
        }
        brelse(bp);
    }
    return tot;
}

// Write data to inode.

// *ip: inode we're writing to 
// user_src: whether source is from user space (1) or kernel space (0)
// src: source address (user virtual or kernel address) where data comes from
// off: offset in the file where we start writing
// n: number of bytes we want to write
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    uint tot, m;
    struct buf *bp;

    // Only debug large writes to avoid console spam
    // if (n >= 512) {
    //     printf("WRITEI_DEBUG: Large write - inum=%d, off=%d, n=%d\n", 
    //            ip->inum, off, n);
    // }

    if (off > ip->size || off + n < off)
        return -1;
    if (off + n > MAXFILE * BSIZE)
        return -1;

    for (tot = 0; tot < n; tot += m, off += m, src += m)
    {
        uint bn = off / BSIZE;
        uint disk_lbn = bmap(ip, bn);
        bp = bread(ip->dev, disk_lbn);
        m = min(n - tot, BSIZE - off % BSIZE);
        if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1)
        {
            brelse(bp);
            break;
        }
        log_write(bp);
        brelse(bp);
    }

    if (tot > 0)
    {
        if (off > ip->size)
            ip->size = off;
        // write the i-node back to disk even if the size didn't change
        // because the loop above might have called bmap() and added a new
        // block to ip->addrs[].
        iupdate(ip);
    }

    // if (n >= 512) {  // Only debug large writes
    //     printf("WRITEI_DEBUG: Returning %d bytes\n", tot);
    // }

    return tot;
}

// Directories

int namecmp(const char *s, const char *t) { return strncmp(s, t, DIRSIZ); }

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *dirlookup(struct inode *dp, char *name, uint *poff)
{
    uint off, inum;
    struct dirent de;

    if (dp->type != T_DIR)
        panic("dirlookup not DIR");

    for (off = 0; off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("dirlookup read");
        if (de.inum == 0)
            continue;
        if (namecmp(name, de.name) == 0)
        {
            // entry matches path element
            if (poff)
                *poff = off;
            inum = de.inum;
            return iget(dp->dev, inum);
        }
    }

    return 0;
}

// Write a new directory entry (name, inum) into the directory dp.
int dirlink(struct inode *dp, char *name, uint inum)
{
    int off;
    struct dirent de;
    struct inode *ip;

    // Check that name is not present.
    if ((ip = dirlookup(dp, name, 0)) != 0)
    {
        iput(ip);
        return -1;
    }

    // Look for an empty dirent.
    for (off = 0; off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("dirlink read");
        if (de.inum == 0)
            break;
    }

    strncpy(de.name, name, DIRSIZ);
    de.inum = inum;
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
        panic("dirlink");

    return 0;
}

// Paths

// Copy the next path element from path into name.
// Return a pointer to the element following the copied one.
// The returned path has no leading slashes,
// so the caller can check *path=='\0' to see if the name is the last one.
// If no name to remove, return 0.
//
// Examples:
//   skipelem("a/bb/c", name) = "bb/c", setting name = "a"
//   skipelem("///a//bb", name) = "bb", setting name = "a"
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
// path: input path string
// name: output buffer where the extracted component is stored
// return value: pointer to the remaining path after the extracted component
// return value: 0 if no more components 

// explain: intuitively, skipelem parse the path string into individual file / directory names
static char *skipelem(char *path, char *name)
{
    char *s;
    int len;

    while (*path == '/')
        path++;
    if (*path == 0)
        return 0;
    s = path;
    while (*path != '/' && *path != 0)
        path++;
    len = path - s;
    if (len >= DIRSIZ)
        memmove(name, s, DIRSIZ);
    else
    {
        memmove(name, s, len);
        name[len] = 0;
    }
    while (*path == '/')
        path++;
    return path;
}

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().

// nameiparent = 0: return the inode for the final component
// nameiparent = 1: return the inode for the parent directory 
static struct inode *namex(char *path, int nameiparent, char *name)
{
    struct inode *ip, *next;
    int symlink_depth = 0;
    char target_path[MAXPATH];
    int target_len;

    // 1. INITIALIZATION: Get starting directory
    if (*path == '/')
        ip = iget(ROOTDEV, ROOTINO);  // Absolute path: start from root
    else
        ip = idup(myproc()->cwd);     // Relative path: start from current working directory

    // printf("NAMEX_DEBUG: Starting path resolution for '%s'\n", path);

    // 2. PATH TRAVERSAL LOOP: Process each path component
    while ((path = skipelem(path, name)) != 0)  // skipelem extracts next component
    {
        // printf("NAMEX_DEBUG: Processing component '%s', remaining path '%s'\n", name, path);
        
        ilock(ip);  // Lock current directory for reading
        
        // 3. DIRECTORY CHECK: Ensure current inode is a directory
        if (ip->type != T_DIR) {
            // printf("NAMEX_DEBUG: Current inode is not a directory (type=%d)\n", ip->type);
            iunlockput(ip);
            return 0;  // Fail if not a directory
        }
        
        // 4. PERMISSION CHECK: Check if we can traverse this directory
        // note: Always allow root directory access, and skip checks for device files
        if (ip->inum != ROOTINO && ip->type != T_DEVICE && !(ip->minor & 0x1)) {
            // Block traversal if no read permission
            // printf("NAMEX_DEBUG: Permission denied for directory (inum=%d, minor=%d)\n", 
            //        ip->inum, ip->minor);
            iunlockput(ip);
            return 0;
        }
        
        // 5. PARENT LOOKUP EARLY EXIT: For nameiparent calls
        // explain: If we want the inode of the parent directory, and we've just processed the last component,
        // explain: return to the current directory, which is the parent of the last component
        if (nameiparent && *path == '\0') {
            // printf("NAMEX_DEBUG: Returning parent directory\n");
            iunlock(ip);
            return ip;          // Return parent directory, not the final component
        }
        
        // 6. COMPONENT LOOKUP: Find the next component in current directory
        if ((next = dirlookup(ip, name, 0)) == 0) {
            // printf("NAMEX_DEBUG: Component '%s' not found in directory\n", name);
            iunlockput(ip);
            return 0;  // Component not found
        }
        
        iunlockput(ip);
        
        // 7. SYMLINK RESOLUTION: Check if we found a symlink
        ilock(next);
        // printf("NAMEX_DEBUG: Found component '%s' (inum=%d, type=%d)\n", 
        //        name, next->inum, next->type);
               
        if (next->type == T_SYMLINK) {
            // printf("NAMEX_DEBUG: Component '%s' is a symlink, following it...\n", name);
            
            // Prevent infinite symlink loops
            if (++symlink_depth > 10) {
                // printf("NAMEX_DEBUG: Too many symlink levels\n");
                iunlockput(next);
                return 0;
            }
            
            // Read the target path from the symlink
            target_len = readi(next, 0, (uint64)target_path, 0, MAXPATH-1);
            if (target_len < 0) {
                // printf("NAMEX_DEBUG: Failed to read symlink target\n");
                iunlockput(next);
                return 0;
            }
            target_path[target_len] = '\0';  // Null terminate
            
            // printf("NAMEX_DEBUG: Symlink target is '%s'\n", target_path);
            iunlockput(next);
            
            // Recursively resolve the symlink target
            if ((next = namei(target_path)) == 0) {
                // printf("NAMEX_DEBUG: Symlink target '%s' doesn't exist\n", target_path);
                return 0;
            }
            
            // printf("NAMEX_DEBUG: Symlink resolved to inode (type=%d)\n", next->type);
        } else {
            iunlock(next);
        }
        
        // 8. ADVANCE: Move to next component
        ip = next;
    }
    
    // printf("NAMEX_DEBUG: Path resolution completed successfully\n");
    
    // 9. FINAL HANDLING
    if (nameiparent) {
        iput(ip);
        return 0;
    }
    return ip;
}

struct inode *namei(char *path)
{
    char name[DIRSIZ];
    return namex(path, 0, name);
}

struct inode *nameiparent(char *path, char *name)
{
    return namex(path, 1, name);
}
