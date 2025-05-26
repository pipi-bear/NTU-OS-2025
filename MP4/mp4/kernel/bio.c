// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.

#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

// Added: global variable added
extern int force_read_error_pbn;
extern int force_disk_fail_id;

struct
{
    struct spinlock lock;
    struct buf buf[NBUF];

    // Linked list of all buffers, through prev/next.
    // Sorted by how recently the buffer was used.
    // head.next is most recent, head.prev is least.
    struct buf head;
} bcache;

void binit(void)
{
    struct buf *b;

    initlock(&bcache.lock, "bcache");

    // Create linked list of buffers
    bcache.head.prev = &bcache.head;
    bcache.head.next = &bcache.head;
    for (b = bcache.buf; b < bcache.buf + NBUF; b++)
    {
        b->next = bcache.head.next;
        b->prev = &bcache.head;
        initsleeplock(&b->lock, "buffer");
        bcache.head.next->prev = b;
        bcache.head.next = b;
    }
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
struct buf *bget(uint dev, uint blockno)
{
    struct buf *b;

    acquire(&bcache.lock);

    // Is the block already cached?
    for (b = bcache.head.next; b != &bcache.head; b = b->next)
    {
        if (b->dev == dev && b->blockno == blockno)
        {
            b->refcnt++;
            release(&bcache.lock);
            acquiresleep(&b->lock);
            return b;
        }
    }

    // Not cached.
    // Recycle the least recently used (LRU) unused buffer.
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev)
    {
        if (b->refcnt == 0)
        {
            b->dev = dev;
            b->blockno = blockno;
            b->valid = 0;
            b->refcnt = 1;
            release(&bcache.lock);
            acquiresleep(&b->lock);
            return b;
        }
    }
    panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;
  uint pbn0, pbn1;
  int is_forced_fail_target = 0;
  int fail_disk = -1;

  pbn0 = blockno;
  pbn1 = blockno + LOGICAL_DISK_SIZE;

  b = bget(dev, blockno);

  if (force_read_error_pbn != -1 && b->blockno == force_read_error_pbn) {
    is_forced_fail_target = 1;
    fail_disk = 0;
  } else if (force_disk_fail_id != -1) {
    is_forced_fail_target = 1;
    fail_disk = force_disk_fail_id;
  }

  if (!b->valid || is_forced_fail_target) {
    if (fail_disk == 0) {
      b->blockno = pbn1;
      virtio_disk_rw(b, 0);
      b->valid = 1;
    } else if (fail_disk == 1) {
      b->blockno = pbn0;
      virtio_disk_rw(b, 0);
      b->valid = 1;
    } else {
      b->blockno = pbn0;
      virtio_disk_rw(b, 0);
      b->valid = 1;
    }
    b->blockno = blockno;
  }
  return b;
}

// TODO: RAID 1 simulation
// Write b's contents to disk.  Must be locked.
void bwrite(struct buf *b)
{
    if (!holdingsleep(&b->lock))
        panic("bwrite");
    
    // Save the original block number, since we need to restore it after mirroring
    uint orig_blockno = b->blockno;
    
    // Check if we're writing to the mirror disk area (Disk 1)
    if (b->blockno >= DISK1_START_BLOCK) {
        panic("bwrite: attempting to write directly to mirror disk area");
    }

    // Calculate physical block numbers for both disks
    // buffer b: contains data to be written
    uint pbn0 = b->blockno;
    uint pbn1 = b->blockno + DISK1_START_BLOCK;

    // Read current simulation state
    // fail_disk: -1 if no failure, 0 if Disk 0 failed, 1 if Disk 1 failed
    int fail_disk = force_disk_fail_id;
    // force_read_error_pbn: -1 for no failure, or specific PBN that should fail
    int pbn0_fail_or_not = (force_read_error_pbn != -1 && force_read_error_pbn == pbn0);

    // Print diagnostic message
    printf("BW_DIAG: PBN0=%d, PBN1=%d, sim_disk_fail=%d, sim_pbn0_block_fail=%d\n",
           pbn0, pbn1, fail_disk, pbn0_fail_or_not);

    // Handle write to Disk 0 (Primary)
    if (fail_disk == 0) {
        // Disk 0 has failed
        printf("BW_ACTION: SKIP_PBN0 (PBN %d) due to simulated Disk 0 failure.\n", pbn0);
    } else if (pbn0_fail_or_not) {
        // Specific block failure on Disk 0
        printf("BW_ACTION: SKIP_PBN0 (PBN %d) due to simulated PBN0 block failure.\n", pbn0);
    } else {
        // PBN0 is clear for writing
        printf("BW_ACTION: ATTEMPT_PBN0 (PBN %d).\n", pbn0);
        b->blockno = pbn0;
        virtio_disk_rw(b, 1);
    }

    // Handle write to Disk 1 (Mirror) - only if writing to logical disk area
    if (orig_blockno < LOGICAL_DISK_SIZE) {
        if (fail_disk == 1) {
            // Disk 1 has failed
            printf("BW_ACTION: SKIP_PBN1 (PBN %d) due to simulated Disk 1 failure.\n", pbn1);
        } else {
            // Disk 1 is clear for writing
            // note: force_read_error_pbn only targets PBN0, and if PBN0 fails at a block level, 
            // note: should still attempt write to PBN1 (unless Disk 1 fails)
            printf("BW_ACTION: ATTEMPT_PBN1 (PBN %d).\n", pbn1);
            b->blockno = pbn1;
            virtio_disk_rw(b, 1);
        }
    }

    // Restore original block number to maintain buffer cache consistency
    b->blockno = orig_blockno;
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void brelse(struct buf *b)
{
    if (!holdingsleep(&b->lock))
        panic("brelse");

    releasesleep(&b->lock);

    acquire(&bcache.lock);
    b->refcnt--;
    if (b->refcnt == 0)
    {
        // no one is waiting for it.
        b->next->prev = b->prev;
        b->prev->next = b->next;
        b->next = bcache.head.next;
        b->prev = &bcache.head;
        bcache.head.next->prev = b;
        bcache.head.next = b;
    }

    release(&bcache.lock);
}

void bpin(struct buf *b)
{
    acquire(&bcache.lock);
    b->refcnt++;
    release(&bcache.lock);
}

void bunpin(struct buf *b)
{
    acquire(&bcache.lock);
    b->refcnt--;
    release(&bcache.lock);
}
