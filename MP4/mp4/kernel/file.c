//
// Support functions for system calls that involve file descriptors.
//

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "stat.h"
#include "proc.h"

struct devsw devsw[NDEV];
struct
{
    struct spinlock lock;
    struct file file[NFILE];
} ftable;

void fileinit(void) { initlock(&ftable.lock, "ftable"); }

// Allocate a file structure.
struct file *filealloc(void)
{
    struct file *f;

    acquire(&ftable.lock);
    for (f = ftable.file; f < ftable.file + NFILE; f++)
    {
        if (f->ref == 0)
        {
            f->ref = 1;
            f->type = FD_NONE;
            f->readable = 0;
            f->writable = 0;
            f->pipe = 0;
            f->ip = 0;
            f->off = 0;
            f->major = 0;
            // printf("FILEALLOC_DEBUG: Allocated file=%p\n", f);
            release(&ftable.lock);
            return f;
        }
    }
    release(&ftable.lock);
    return 0;                   // if no free slot in the file table, return 0
}

// Increment ref count for file f.
struct file *filedup(struct file *f)
{
    acquire(&ftable.lock);
    if (f->ref < 1)
        panic("filedup");
    f->ref++;
    release(&ftable.lock);
    return f;
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file *f)
{
    struct file ff;

    // printf("FILECLOSE_DEBUG: Process %d closing file=%p, ref=%d\n", 
    //        myproc()->pid, f, f->ref);
    
    acquire(&ftable.lock);
    if (f->ref < 1)
    {
        // printf("FILECLOSE_DEBUG: ref count < 1, panic\n");
        panic("fileclose");
    }
    
    // printf("FILECLOSE_DEBUG: File ref count before decrement: %d\n", f->ref);
    
    if (--f->ref > 0) {
        // printf("FILECLOSE_DEBUG: File still has references (%d), not closing\n", f->ref);
        release(&ftable.lock);
        return;
    }
    
    ff = *f;
    f->ref = 0;
    f->type = FD_NONE;
    release(&ftable.lock);

    // printf("FILECLOSE_DEBUG: File ref reached 0, proceeding with cleanup\n");
    // printf("FILECLOSE_DEBUG: File type=%d, ip=%p\n", ff.type, ff.ip);
    
    if (ff.type == FD_PIPE) {
        // printf("FILECLOSE_DEBUG: Closing pipe\n");
        pipeclose(ff.pipe, ff.writable);
    } else if (ff.type == FD_INODE || ff.type == FD_DEVICE) {
        // printf("FILECLOSE_DEBUG: Closing inode/device, calling iput on ip=%p\n", ff.ip);
        // if (ff.ip != 0) {
        //     printf("FILECLOSE_DEBUG: Before iput - ip->inum=%d, ip->ref=%d\n", 
        //            ff.ip->inum, ff.ip->ref);
        // }
        begin_op();
        iput(ff.ip);
        end_op();
        // if (ff.ip != 0) {
        //     printf("FILECLOSE_DEBUG: After iput - ip->inum=%d, ip->ref=%d\n", 
        //            ff.ip->inum, ff.ip->ref);
        // }
    } else {
        // printf("FILECLOSE_DEBUG: Unknown file type %d, no cleanup needed\n", ff.type);
    }
    
    // printf("FILECLOSE_DEBUG: fileclose completed\n");
}

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int filestat(struct file *f, uint64 addr)
{
    struct proc *p = myproc();
    struct stat st;

    if (f->type == FD_INODE || f->type == FD_DEVICE)
    {
        ilock(f->ip);
        stati(f->ip, &st);
        iunlock(f->ip);
        if (copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
            return -1;
        return 0;
    }
    return -1;
}

// Read from file f.
// addr is a user virtual address.
int fileread(struct file *f, uint64 addr, int n)
{
    int r = 0;

    // Allow reading from symlinks even if not marked as readable (O_NOACCESS case)
    if (f->readable == 0 && f->ip->type != T_SYMLINK){
        // printf("DEBUG_FILEREAD: File is not readable\n");
        return -1;
    }

    if (f->type == FD_PIPE)
    {
        r = piperead(f->pipe, addr, n);
    }
    else if (f->type == FD_DEVICE)
    {
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read){
            // printf("DEBUG_FILEREAD: Device read failed\n");
            return -1;
        }
        r = devsw[f->major].read(1, addr, n);
    }
    else if (f->type == FD_INODE)
    {
        ilock(f->ip);
        if ((r = readi(f->ip, 1, addr, f->off, n)) > 0)
            f->off += r;
        iunlock(f->ip);
    }
    else
    {
        panic("fileread");
    }

    return r;
}

// Write to file f.
// addr is a user virtual address.
int filewrite(struct file *f, uint64 addr, int n)
{
    int r, ret = 0;

    // Only debug large file writes, not console output
    // if (f->type == FD_INODE && n >= 512) {
    //     printf("FILEWRITE_DEBUG: Large file write - inum=%d, n=%d, f->off=%d\n", 
    //            f->ip->inum, n, f->off);
    //     printf("FILEWRITE_DEBUG: File permissions - f->writable=%d, f->readable=%d\n", 
    //            f->writable, f->readable);
    //     printf("FILEWRITE_DEBUG: Inode permissions - ip->minor=%d (readable=%d, writable=%d)\n", 
    //            f->ip->minor, f->ip->minor & 0x1, f->ip->minor & 0x2);
    // }

    if (f->writable == 0) {
        // if (f->type == FD_INODE && n >= 512) {
        //     printf("FILEWRITE_DEBUG: File not writable, returning -1\n");
        // }
        return -1;
    }

    if (f->type == FD_PIPE)
    {
        ret = pipewrite(f->pipe, addr, n);
    }
    else if (f->type == FD_DEVICE)
    {
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
            return -1;
        ret = devsw[f->major].write(1, addr, n);
    }
    else if (f->type == FD_INODE)
    {
        // write a few blocks at a time to avoid exceeding
        // the maximum log transaction size, including
        // i-node, indirect block, allocation blocks,
        // and 2 blocks of slop for non-aligned writes.
        // this really belongs lower down, since writei()
        // might be writing a device like the console.
        int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
        int i = 0;
        
        while (i < n)
        {
            int n1 = n - i;
            if (n1 > max)
                n1 = max;

            // if (n >= 512) {  // Only debug large writes
            //     printf("FILEWRITE_DEBUG: Writing chunk %d bytes at offset %d\n", n1, f->off);
            // }

            begin_op();
            ilock(f->ip);
            if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
                f->off += r;
            iunlock(f->ip);
            end_op();

            // if (n >= 512) {  // Only debug large writes
            //     printf("FILEWRITE_DEBUG: writei returned %d bytes\n", r);
            // }

            if (r < 0)
                break;
            if (r != n1)
                panic("short filewrite");
            i += r;
        }
        ret = (i == n ? n : -1);
        
        // if (n >= 512) {  // Only debug large writes
        //     printf("FILEWRITE_DEBUG: Total wrote %d/%d bytes\n", i, n);
        // }
    }
    else
    {
        panic("filewrite");
    }

    return ret;
}