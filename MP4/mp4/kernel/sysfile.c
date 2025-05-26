//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"
#include "buf.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int *pfd, struct file **pf)
{
    int fd;
    struct file *f;

    if (argint(n, &fd) < 0)
        return -1;
    if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
        return -1;
    if (pfd)
        *pfd = fd;
    if (pf)
        *pf = f;
    return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f)
{
    int fd;
    struct proc *p = myproc();

    for (fd = 0; fd < NOFILE; fd++)
    {
        if (p->ofile[fd] == 0)
        {
            p->ofile[fd] = f;
            return fd;
        }
    }
    return -1;
}

uint64 sys_dup(void)
{
    struct file *f;
    int fd;

    if (argfd(0, 0, &f) < 0)
        return -1;
    if ((fd = fdalloc(f)) < 0)
        return -1;
    filedup(f);
    return fd;
}

uint64 sys_read(void)
{
    struct file *f;
    int n;
    uint64 p;

    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
        return -1;
    if (!(f->ip->minor & 0x1) && f->ip->type != T_DEVICE) // no read permission, if not a device
        return -1;
    return fileread(f, p, n);
}

uint64 sys_write(void)
{
    struct file *f;
    int n;
    uint64 p;

    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
        return -1;
    if (!(f->ip->minor & 0x2) && f->ip->type != T_DEVICE) // no write permission, if not a device
        return -1;
    return filewrite(f, p, n);
}

uint64 sys_close(void)
{
    int fd;
    struct file *f;

    if (argfd(0, &fd, &f) < 0)
        return -1;
    myproc()->ofile[fd] = 0;
    fileclose(f);
    return 0;
}

uint64 sys_fstat(void)
{
    struct file *f;
    uint64 st; // user pointer to struct stat

    // Try to get file descriptor and stat buffer address from user arguments
    if (argfd(0, 0, &f) < 0) {
        // printf("DEBUG_FSTAT: argfd failed\n");
        return -1;
    }
    if (argaddr(1, &st) < 0) {
        // printf("DEBUG_FSTAT: argaddr failed\n");
        return -1;
    }

    // Allow metadata access if:
    // 1. File was opened with O_NOACCESS (neither readable nor writable)
    // 2. File has read permission
    // 3. File is a device
    if ((!f->readable && !f->writable) ||  // O_NOACCESS case
        (f->ip->minor & 0x1) ||            // Has read permission
        f->ip->type == T_DEVICE) {         // Is a device
        return filestat(f, st);
    }

    // printf("DEBUG_FSTAT: no read permission and not O_NOACCESS, type=%d, minor=%d\n", 
    //        f->ip->type, f->ip->minor);
    return -1;
}

// Create the path new as a link to the same inode as old.
uint64 sys_link(void)
{
    char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
    struct inode *dp, *ip;

    if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
        return -1;

    begin_op();
    if ((ip = namei(old)) == 0)
    {
        end_op();
        return -1;
    }

    ilock(ip);
    if (ip->type == T_DIR)
    {
        iunlockput(ip);
        end_op();
        return -1;
    }

    ip->nlink++;
    iupdate(ip);
    iunlock(ip);

    if ((dp = nameiparent(new, name)) == 0)
        goto bad;
    ilock(dp);
    if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
    {
        iunlockput(dp);
        goto bad;
    }
    iunlockput(dp);
    iput(ip);

    end_op();

    return 0;

bad:
    ilock(ip);
    ip->nlink--;
    iupdate(ip);
    iunlockput(ip);
    end_op();
    return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int isdirempty(struct inode *dp)
{
    int off;
    struct dirent de;

    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("isdirempty: readi");
        if (de.inum != 0)
            return 0;
    }
    return 1;
}

uint64 sys_unlink(void)
{
    struct inode *ip, *dp;
    struct dirent de;
    char name[DIRSIZ], path[MAXPATH];
    uint off;

    if (argstr(0, path, MAXPATH) < 0)
        return -1;

    begin_op();
    if ((dp = nameiparent(path, name)) == 0)
    {
        end_op();
        return -1;
    }

    ilock(dp);

    // Cannot unlink "." or "..".
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
        goto bad;

    if ((ip = dirlookup(dp, name, &off)) == 0)
        goto bad;
    ilock(ip);

    if (ip->nlink < 1)
        panic("unlink: nlink < 1");
    if (ip->type == T_DIR && !isdirempty(ip))
    {
        iunlockput(ip);
        goto bad;
    }

    memset(&de, 0, sizeof(de));
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
        panic("unlink: writei");
    if (ip->type == T_DIR)
    {
        dp->nlink--;
        iupdate(dp);
    }
    iunlockput(dp);

    ip->nlink--;
    iupdate(ip);
    iunlockput(ip);

    end_op();

    return 0;

bad:
    iunlockput(dp);
    end_op();
    return -1;
}

static struct inode *create(char *path, short type, short major, short minor)
{
    struct inode *ip, *dp;
    char name[DIRSIZ];

    if ((dp = nameiparent(path, name)) == 0)
        return 0;

    ilock(dp);

    if ((ip = dirlookup(dp, name, 0)) != 0)
    {
        iunlockput(dp);
        ilock(ip);
        if (type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
            return ip;
        iunlockput(ip);
        return 0;
    }

    if ((ip = ialloc(dp->dev, type)) == 0)
        panic("create: ialloc");

    ilock(ip);
    ip->major = major;
    
    // Set minor appropriately:
    // - For device files: use the provided minor number
    // - For all other types (T_FILE, T_DIR, T_SYMLINK): use minor for permission (rw=0x3)
    if (type == T_DEVICE) {
        ip->minor = minor;  // Keep original minor for devices
    } else {
        ip->minor = 0x3;    // Default permission: rw for all non-device files
    }
    
    ip->nlink = 1;
    iupdate(ip);

    if (type == T_DIR)
    {                // Create . and .. entries.
        dp->nlink++; // for ".."
        iupdate(dp);
        // No ip->nlink++ for ".": avoid cyclic ref count.
        if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
            panic("create dots");
    }

    if (dirlink(dp, name, ip->inum) < 0)
        panic("create: dirlink");

    iunlockput(dp);

    return ip;
}

/* TODO: Access Control & Symbolic Link */
uint64 sys_open(void)
{
    char path[MAXPATH];
    int fd, omode;
    struct file *f;         // File structure pointer
    struct inode *ip;       // Inode pointer for the file/directory
    int n;

    // Get path and open mode from arguments
    if ((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
        return -1;

    begin_op();

    // If it's a file and O_CREATE flag is set, create a new file
    if (omode & O_CREATE)
    {
        ip = create(path, T_FILE, 0, 0);
        if (ip == 0)
        {
            end_op();
            return -1;
        }
    }
    else    // O_CREATE is not set, so look up the file / directory
    {
        // Look up the existing file / directory using namei(), which calls iget() internally and increments the reference count
        if ((ip = namei(path)) == 0)
        {
            // If the file / directory does not exist, end transaction and return -1
            end_op();
            return -1;
        }
        // Lock the inode to prevent it from being modified while we're using it
        ilock(ip);
        // printf("SYS_OPEN_DEBUG: After ilock, lock the inode %s, current ref count: %d\n", path, ip->ref);

        // Check if it's a directory and has flag O_WRONLY or O_RDWR, this shall not happen since we cannot write to a directory
        if (ip->type == T_DIR && omode != O_RDONLY && omode != O_NOACCESS) {
            iunlockput(ip);
            // printf("SYS_OPEN_DEBUG: Opening directory '%s', current ref count: %d\n", path, ip->ref);
            end_op();
            return -1;
        }
    }

    // Allocate a struct file from the global file table (shared by all processes)
    // note: each open() call will allocate a new struct file because we need independent:
    // note: 1. file position (f->off)
    // note: 2. file permissions (f->readable, f->writable)
    // note: 3. reference counting (f->ref)
    // * can check the struct file in file.h
    
    // fdalloc() allocates a fd from the current process's file descriptor table and assigns the file struct to it
    if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)        // case: either we cannot allocate a file struct, or we cannot allocate a fd
    {
        if (f) {
            // if f is not 0, this would imply that filealloc() succeeded, and fdalloc() failed
            // so we need to close the file and return -1
            fileclose(f);
            // printf("SYS_OPEN_DEBUG: Failed to allocate fd for '%s', after close, current ref count: %d\n", path, ip->ref);
        }
        // explain: use iunlockput() to: 
        // explain: 1. unlock the inode (which we previously locked by ilock(ip))
        // explain: 2. decrease the reference count (by iput() internally), since we previously incremented it by namei(path)
        iunlockput(ip);
        // printf("SYS_OPEN_DEBUG: After iunlockput, current ref count: %d\n", path, ip->ref);
        end_op();
        return -1;
    }

    // DON'T set f->ip = ip or f->type yet - keep them as initialized (FD_NONE, 0)

    if (omode & O_NOACCESS) {
        // For O_NOACCESS: set neither readable nor writable (spec 3.3.5 1.)
        f->readable = 0;
        f->writable = 0;
    } else {
        // For non-device files, check permissions against requested access mode
        if (ip->type != T_DEVICE) {
            // Check if read access is requested but not permitted
            if ((omode == O_RDONLY || omode == O_RDWR) && !(ip->minor & 0x1)) {
                myproc()->ofile[fd] = 0;
                fileclose(f);     // f->type = FD_NONE, f->ip = 0, no iput() called
                // printf("SYS_OPEN_DEBUG: Failed to open '%s', after fileclose, current ref count: %d\n", path, omode, ip->ref);
                iunlockput(ip);   // explain: use iunlockput() to unlock and decrease ref count
                // printf("SYS_OPEN_DEBUG: After iunlockput, current ref count: %d\n", path, ip->ref);
                end_op();
                return -1;
            }
            // Check if write access is requested but not permitted
            if ((omode == O_WRONLY || omode == O_RDWR) && !(ip->minor & 0x2)) {
                myproc()->ofile[fd] = 0;
                fileclose(f);     // f->type = FD_NONE, f->ip = 0, no iput() called
                iunlockput(ip);   // explain: use iunlockput() to unlock and decrease ref count
                end_op();
                return -1;
            }
        }

        // Set file descriptor permissions based on open mode
        f->readable = (omode == O_RDONLY || omode == O_RDWR);
        f->writable = (omode == O_WRONLY || omode == O_RDWR);
    }

    // Until now, we have successfully allocated a file struct and a fd
    // Set up file structure based on inode type
    if (ip->type == T_DEVICE)
    {
        f->type = FD_DEVICE;
        f->major = ip->major;
    }
    else
    {
        f->type = FD_INODE;
        f->off = 0;             // Initialize offset to 0
    }

    f->ip = ip;  // NOW set f->ip after all validation passes

    // If O_TRUNC is set and it's a regular file, truncate it
    if ((omode & O_TRUNC) && ip->type == T_FILE)
    {
        itrunc(ip);
    }

    iunlock(ip);  // Only unlock, f owns the reference now
    end_op();

    return fd;
}

uint64 sys_mkdir(void)
{
    char path[MAXPATH];
    struct inode *ip;

    begin_op();
    if (argstr(0, path, MAXPATH) < 0) {
        // printf("mkdir: failed to get path argument\n");  
        end_op();
        return -1;
    }
    
    // printf("Creating directory: %s\n", path);  
    if ((ip = create(path, T_DIR, 0, 0)) == 0) {
        // printf("mkdir: create failed for %s\n", path);  
        end_op();
        return -1;
    }

    // printf("Directory created with type=%d, minor=%d\n", ip->type, ip->minor);  
    iunlockput(ip);
    end_op();
    return 0;
}

uint64 sys_mknod(void)
{
    struct inode *ip;
    char path[MAXPATH];
    int major, minor;

    begin_op();
    if ((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 ||
        argint(2, &minor) < 0 ||
        (ip = create(path, T_DEVICE, major, minor)) == 0)
    {
        end_op();
        return -1;
    }
    iunlockput(ip);
    end_op();
    return 0;
}

uint64 sys_chdir(void)
{
    char path[MAXPATH];
    struct inode *ip;
    struct proc *p = myproc();

    begin_op();
    if (argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0)
    {
        end_op();
        return -1;
    }
    ilock(ip);
    if (ip->type != T_DIR)
    {
        iunlockput(ip);
        end_op();
        return -1;
    }
    iunlock(ip);
    iput(p->cwd);
    end_op();
    p->cwd = ip;
    return 0;
}

uint64 sys_exec(void)
{
    char path[MAXPATH], *argv[MAXARG];
    int i;
    uint64 uargv, uarg;

    if (argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0)
    {
        return -1;
    }
    memset(argv, 0, sizeof(argv));
    for (i = 0;; i++)
    {
        if (i >= NELEM(argv))
        {
            goto bad;
        }
        if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0)
        {
            goto bad;
        }
        if (uarg == 0)
        {
            argv[i] = 0;
            break;
        }
        argv[i] = kalloc();
        if (argv[i] == 0)
            goto bad;
        if (fetchstr(uarg, argv[i], PGSIZE) < 0)
            goto bad;
    }

    int ret = exec(path, argv);

    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
        kfree(argv[i]);

    return ret;

bad:
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
        kfree(argv[i]);
    return -1;
}

uint64 sys_pipe(void)
{
    uint64 fdarray; // user pointer to array of two integers
    struct file *rf, *wf;
    int fd0, fd1;
    struct proc *p = myproc();

    if (argaddr(0, &fdarray) < 0)
        return -1;
    if (pipealloc(&rf, &wf) < 0)
        return -1;
    fd0 = -1;
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    {
        if (fd0 >= 0)
            p->ofile[fd0] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
        copyout(p->pagetable, fdarray + sizeof(fd0), (char *)&fd1,
                sizeof(fd1)) < 0)
    {
        p->ofile[fd0] = 0;
        p->ofile[fd1] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    return 0;
}

/* TODO: Access Control & Symbolic Link */
uint64 sys_chmod(void)
{
    char path[MAXPATH];
    int mode;
    struct inode *ip;

    // Fetch arguments: path and mode
    if (argstr(0, path, MAXPATH) < 0 || argint(1, &mode) < 0)
        return -1;

    begin_op();

    // Find the inode for the path
    if ((ip = namei(path)) == 0) {
        end_op();
        return -1;
    }

    ilock(ip);

    // Follow symbolic links
    int max_links = 10; // Prevent infinite loops
    while (ip->type == T_SYMLINK && max_links-- > 0) {
        char target[MAXPATH];
        
        // Read the target path from the symlink
        if (readi(ip, 0, (uint64)target, 0, MAXPATH) < 0) {
            iunlockput(ip);
            end_op();
            return -1;
        }
        target[MAXPATH-1] = '\0'; // Ensure null-termination
        
        // Release the current inode and follow the link
        iunlockput(ip);
        
        if ((ip = namei(target)) == 0) {
            end_op();
            return -1;
        }
        ilock(ip);
    }
    
    // Check if we've followed too many links
    if (max_links < 0) {
        iunlockput(ip);
        end_op();
        return -1;
    }

    // Set the permission (only lower 2 bits: r=1, w=2, rw=3)
    // Store in minor field for non-device files
    ip->minor = mode & 0x3;
    iupdate(ip);

    iunlockput(ip);
    end_op();

    return 0;
}

/* TODO: Access Control & Symbolic Link */
uint64 sys_symlink(void)
{
    // target: store the path the symlink points to
    // path: store where the symlink will be created
    char target[MAXPATH], path[MAXPATH];
    // ip: pointer to an inode representing the new symlink
    struct inode *ip;

    // case: If failed to copy the strings into buffer
    if (argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
        return -1;

    begin_op();

    // Create a new inode for the symlink at path
    // Use T_SYMLINK (type 4, in kernel/stat.h) as the type of the inode
    ip = create(path, T_SYMLINK, 0, 0);
    // case: If the creation fails
    if (ip == 0) {
        end_op();
        return -1;
    }

    // Write the target path (kernel address) to the symlink inode (ip)
    // If the amount of bytes written is samller than the length of the target path, 
    // we should unlock the inode, decrease the reference count (these are done in iunlockput()), and return -1
    if (writei(ip, 0, (uint64)target, 0, strlen(target)) < strlen(target)) {
        iunlockput(ip);
        end_op();
        return -1;
    }

    iunlockput(ip);
    end_op();
    
    return 0;
}

uint64 sys_raw_read(void)
{
    int pbn;
    uint64 user_buf_addr;
    struct buf *b;

    if (argint(0, &pbn) < 0 || argaddr(1, &user_buf_addr) < 0)
    {
        return -1;
    }

    if (pbn < 0 || pbn >= FSSIZE)
    {
        return -1;
    }

    b = bget(ROOTDEV, pbn);
    if (b == 0)
    {
        return -1;
    }

    virtio_disk_rw(b, 0);

    struct proc *p = myproc();
    if (copyout(p->pagetable, user_buf_addr, (char *)b->data, BSIZE) < 0)
    {
        brelse(b);
        return -1;
    }

    brelse(b);
    return 0;
}

uint64 sys_get_disk_lbn(void)
{
    struct file *f;
    int fd;
    int file_lbn;
    uint disk_lbn;

    if (argfd(0, &fd, &f) < 0 || argint(1, &file_lbn) < 0)
    {
        return -1;
    }

    if (!(f->ip->minor & 0x1) && f->ip->type != T_DEVICE) // no read permission, if not a device
        return -1;

    struct inode *ip = f->ip;

    ilock(ip);

    disk_lbn = bmap(ip, file_lbn);

    iunlock(ip);

    return (uint64)disk_lbn;
}

uint64 sys_raw_write(void)
{
    int pbn;
    uint64 user_buf_addr;
    struct buf *b;

    if (argint(0, &pbn) < 0 || argaddr(1, &user_buf_addr) < 0)
    {
        return -1;
    }

    if (pbn < 0 || pbn >= FSSIZE)
    {
        return -1;
    }

    b = bget(ROOTDEV, pbn);
    if (b == 0)
    {
        printf("sys_raw_write: bget failed for PBN %d\n", pbn);
        return -1;
    }
    struct proc *p = myproc();
    if (copyin(p->pagetable, (char *)b->data, user_buf_addr, BSIZE) < 0)
    {
        brelse(b);
        return -1;
    }

    b->valid = 1;
    virtio_disk_rw(b, 1);
    brelse(b);

    return 0;
}
