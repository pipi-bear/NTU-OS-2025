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
#include "debug.h"

void fileprint_metadata(void *f) {
  struct file *file = (struct file *) f;
  debug("tp: %d, ref: %d, readable: %d, writable: %d, pipe: %p, ip: %p, off: %d, major: %d",
        file->type, file->ref, file->readable, file->writable, file->pipe, file->ip, file->off, file->major);
}

struct devsw devsw[NDEV];
struct {
  struct spinlock lock;
  struct file file[NFILE];
} ftable;

struct kmem_cache *file_cache;

// This function is called during kernel initialization to set up all file related structures
void
fileinit(void)
{
  initlock(&ftable.lock, "ftable");
  //debug("[FILE] fileinit\n");
  
  // Create a slab cache for struct file objects
  // "file" is the name of the cache
  // sizeof(struct file) is the size of the object
  file_cache = kmem_cache_create("file", sizeof(struct file));
  if (!file_cache) {
    panic("fileinit: failed to create file cache");
  }
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  //debug("[FILE] filealloc\n"); // example of using debug, you can modify this
  struct file *f;

  // Original implementation given by the TA (using ftable array)
  // acquire(&ftable.lock);
  // for(f = ftable.file; f < ftable.file + NFILE; f++){
  //   if(f->ref == 0){
  //     f->ref = 1;
  //     release(&ftable.lock);
  //     return f;
  //   }
  // }
  // release(&ftable.lock);
  // return 0;

  // use slab allocator
  f = kmem_cache_alloc(file_cache);
  if (!f) {
    return 0;
  }

  // Initialize the file structure
  f->ref = 1;
  f->type = FD_NONE;
  f->readable = 0;
  f->writable = 0;
  f->pipe = 0;
  f->ip = 0;
  f->off = 0;
  f->major = 0;

  return f;
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  // We need a lock here to protect ref count modification
  // but use ftable.lock instead of file_cache->lock
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
  release(&ftable.lock);
  return f;
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  struct file ff;

  // Use ftable.lock for ref count check and modification
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;  // Save file info before freeing
  //debug("[FILE] fileclose\n");
  release(&ftable.lock);


  // Let kmem_cache_free handle its own locking
  kmem_cache_free(file_cache, f);

  if(ff.type == FD_PIPE){
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
  struct proc *p = myproc();
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    ilock(f->ip);
    stati(f->ip, &st);
    iunlock(f->ip);
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
      return -1;
    return 0;
  }
  return -1;
}

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
  int r = 0;

  if(f->readable == 0)
    return -1;

  if(f->type == FD_PIPE){
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
  } else {
    panic("fileread");
  }

  return r;
}

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    return -1;

  if(f->type == FD_PIPE){
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    // write a few blocks at a time to avoid exceeding
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r != n1){
        // error from writei
        break;
      }
      i += r;
    }
    ret = (i == n ? n : -1);
  } else {
    panic("filewrite");
  }

  return ret;
}

