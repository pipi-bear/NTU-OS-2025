#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"
#include "list.h"
#include "slab.h"
#include "debug.h"

void print_kmem_cache(struct kmem_cache *cache, void (*slab_obj_printer)(void *))
{
  acquire(&cache->lock);

  // note: in_cache_obj set to 0 since we didn't implement the internal fragmentation solution
  debug("[SLAB] kmem_cache { name: %s, object_size: %d, at: %p, in_cache_obj: %d }\n",
         cache->name, cache->object_size, cache, cache->in_cache_obj);

  struct list_head *p;
  struct slab *s;

  // Check which slab lists are non-empty
  // explain: Since [ partial slabs ] is printed only if there exists partial slabs,
  // explain: and [ cache slabs ] is printed only if full / free slabs exist
  int has_partial = !list_empty(&cache->partial);
  int has_cache = !list_empty(&cache->full) || !list_empty(&cache->free);

  // debug("[slab] DEBUG: full list empty? %d\n", list_empty(&cache->full));
  // debug("[slab] DEBUG: partial list empty? %d\n", list_empty(&cache->partial));
  // debug("[slab] DEBUG: free list empty? %d\n", list_empty(&cache->free));

  // If full or free list has slabs, print cache slabs
  // Slab List Status (<slab_list_status>)
  if (has_cache) {
    debug("[SLAB] [ cache slabs ]\n");

    // case: full list
    list_for_each(p, &cache->full) {
      s = list_entry(p, struct slab, list);
      
      // Single Slab Status (<slab_status>)
      debug("[SLAB] [ slab %p ] { freelist: %p, nxt: %p }\n", 
            s, s->freelist, s->list.next);
      
      // Collect and print all objects in original order
      char *obj_start = (char *)s + sizeof(struct slab);
      char *obj_end = (char *)s + PGSIZE;
      
      for (char *p = obj_start; p + cache->object_size <= obj_end; p += cache->object_size) {
          // Calculate index based on offset from start
          int idx = (p - obj_start) / cache->object_size;
          void *addr = (void *)p;
          void *as_ptr = *(void **)addr;
          debug("[SLAB] [ idx %d ] { addr: %p, as_ptr: %p, as_obj: {", 
                idx, addr, as_ptr);
          slab_obj_printer(addr);
          debug("} }\n");
      }
    }

    // case: free list
    list_for_each(p, &cache->free) {
      s = list_entry(p, struct slab, list);
      
      debug("[SLAB] \t[ slab %p ] { freelist: %p, nxt: %p }\n", 
            s, s->freelist, s->list.next);
      
      char *obj_start = (char *)s + sizeof(struct slab);
      char *obj_end = (char *)s + PGSIZE;
      
      for (char *p = obj_start; p + cache->object_size <= obj_end; p += cache->object_size) {
          int idx = (p - obj_start) / cache->object_size;
          void *addr = (void *)p;
          void *as_ptr = *(void **)addr;
          debug("[SLAB] [ idx %d ] { addr: %p, as_ptr: %p, as_obj: {", 
                idx, addr, as_ptr);
          slab_obj_printer(addr);
          debug("} }\n");
      }
    }
  }

  // If partial list has slabs, print partial slabs
  if (has_partial) {
    debug("[SLAB] [ partial slabs ]\n");

    list_for_each(p, &cache->partial) {
      s = list_entry(p, struct slab, list);
      
      debug("[SLAB] \t[ slab %p ] { freelist: %p, nxt: %p }\n", 
            s, s->freelist, s->list.next);

      char *obj_start = (char *)s + sizeof(struct slab);
      char *obj_end = (char *)s + PGSIZE;
      
      for (char *p = obj_start; p + cache->object_size <= obj_end; p += cache->object_size) {
          int idx = (p - obj_start) / cache->object_size;
          void *addr = (void *)p;
          void *as_ptr = *(void **)addr;
          debug("[SLAB] [ idx %d ] { addr: %p, as_ptr: %p, as_obj: {", 
                idx, addr, as_ptr);
          slab_obj_printer(addr);
          debug("} }\n");
      }
    }
  }

  // 5. Ending Mark (<print_kmem_cache_end>)
  debug("[SLAB] print_kmem_cache end\n");
  release(&cache->lock);
}

struct kmem_cache *kmem_cache_create(char *name, uint object_size)
{
  // Allocate memory for the cache
  struct kmem_cache *cache = (struct kmem_cache *) kalloc();
  if (!cache) {
      // debug("[slab] Error: Failed to allocate memory for kmem_cache\n");
      return 0;
  }

  // Copy "name" to cache->name safely (ensure null termination)
  safestrcpy(cache->name, name, MP2_CACHE_MAX_NAME);

  // Initialize the lock for the cache
  initlock(&cache->lock, "cache");

  // Set the object size
  cache->object_size = object_size;

  // Initialize all slab lists using Linux-style macros
  INIT_LIST_HEAD(&cache->full);
  INIT_LIST_HEAD(&cache->partial);
  INIT_LIST_HEAD(&cache->free);

  // note: need to substract the size of the slab metadata (p.13)
  cache->max_objects_per_slab = (PGSIZE - sizeof(struct slab)) / object_size;
  
  // TODO: need to implement internal fragmentation solution, set to 0 for now
  cache->in_cache_obj = 0;

  debug("[SLAB] New kmem_cache (name: %s, object size: %d bytes, at: %p, max objects per slab: %d, support in cache obj: %d) is created\n", 
         cache->name, cache->object_size, cache, cache->max_objects_per_slab, cache->in_cache_obj);
  return cache;
}

void kmem_cache_destroy(struct kmem_cache *cache)
{
  // TODO: Implement kmem_cache_destroy (will not be tested)
  debug("[SLAB] TODO: kmem_cache_destroy is not yet implemented \n");
}

struct slab *grow_slab(struct kmem_cache *cache)
{
  // Allocate a full new page
  void *page = kalloc();
  if (!page)
      return 0;

  // Initialize slab struct at the beginning of the page 
  struct slab *slab = (struct slab *)page;
  slab->freelist = 0;
  slab->inuse = 0;

  // Before linking this slab into the free list,
  // we first initialize list_head to have its next and prev pointers point to itself
  INIT_LIST_HEAD(&slab->list); 

  // Split remaining page space into objects
  int object_size = cache->object_size;
  // The first object should start after the slab struct, 
  // so set to the starting address of the page + size of slab struct
  char *obj_start = (char *)slab + sizeof(struct slab);
  // A slab has its size fixed to one page, so the end of the object is the end of the page
  char *obj_end = (char *)page + PGSIZE;

  for (char *p = obj_start; p + object_size <= obj_end; p += object_size) {
      struct run *r = (struct run *)p;
      r->next = slab->freelist;
      slab->freelist = r;
  }

  // note: this line is commented out since we currently only use grow_slab() in kmem_cache_alloc()
  // note: so we let the slab be assigned to partial list in kmem_cache_alloc()
  // note: if some of the functions later use grow_slab(), we should recheck the assignment
  // list_add(&slab->list, &cache->free);

  debug("[SLAB] A new slab %p (%s) is allocated\n", slab, cache->name);
  return slab;
}

void *kmem_cache_alloc(struct kmem_cache *cache)
{
  struct slab *slab = 0;
  struct run *obj = 0;

  acquire(&cache->lock);

  debug("[SLAB] Alloc request on cache %s\n", cache->name);
  // debug("[slab] DEBUG: Before allocation - full empty? %d, partial empty? %d, free empty? %d\n",
  //       list_empty(&cache->full), list_empty(&cache->partial), list_empty(&cache->free));

  // Check if partial list
  if (!list_empty(&cache->partial)) {                             // case: exists partial slab
    // explain: we have the definition of list_entry(node, type, member) in list.h
    // explain: member should be the name of list_head in struct slab, which is "list"
    slab = list_entry(cache->partial.next, struct slab, list);
    // debug("[slab] DEBUG: Get slab %p from partial list\n", slab);
  }
  // If no partial, try free list
  else if (!list_empty(&cache->free)) {                           // case: exists free slab
    slab = list_entry(cache->free.next, struct slab, list);
    // debug("[slab] DEBUG: Get slab %p from free list\n", slab);

    // After getting the slab from free list, we need to move this slab from free -> partial
    list_del(&slab->list);                  // remove the slab from original list (free list)
    list_add(&slab->list, &cache->partial); // add the slab to partial list
    // debug("[slab] DEBUG: Move slab %p from free to partial list\n", slab);
  } 
  else {                                                          // case: no partial or free slab (create new one)
    // grow_slab() creates a new slab when all the slabs have their objects occupied (in full list)
    slab = grow_slab(cache);
    // debug("[slab] DEBUG: Create new slab %p since no partial or free slab\n", slab);
    if (!slab) {  // failed to create a new slab
      release(&cache->lock);
      return 0;  
    }

    // This new created slab should be added to partial list 
    // since we would later allocate a new object from it
    list_add(&slab->list, &cache->partial);
    // debug("[slab] DEBUG: Add the new created slab %p to partial list\n", slab);
  }

  // Allocate object from slab->freelist
  obj = slab->freelist;
  // debug("[slab] DEBUG: Get object %p from slab %p\n", obj, slab);
  // note: The following shall not happen if we have implemented the previous parts correctly
  if (!obj) {
    // debug("[slab] Error: slab %p has no free objects\n", slab);
    release(&cache->lock);
    return 0;
  }

  slab->freelist = obj->next;
  slab->inuse++;  // increase the number of objects in use for this slab

  // Check if slab becomes full after the allocation
  if (slab->inuse == cache->max_objects_per_slab) {
    // debug("[slab] DEBUG: Moving slab to full list\n");
    // Remove the slab from its original list (partial list)
    list_del(&slab->list);
    // Insert slab->list right after &cache->full (which is the head of the full list), indicating that now this slab is full
    list_add(&slab->list, &cache->full);
  }

  debug("[SLAB] Object %p in slab %p (%s) is allocated and initialized\n", obj, slab, cache->name);

  release(&cache->lock);
  return (void *)obj;
}

void kmem_cache_free(struct kmem_cache *cache, void *obj)
{
  // acquire the lock before modification
  acquire(&cache->lock); 

  // Identify which slab the object belongs to
  /*
  Given an object (obj) to free, we need to find the slab (its base address, i.e. the address of the beginning of the page) that contains it
  Since we assumed that each slab is of size PGSIZE (the size of a page)
  
  We first NOT the offset inside the page, making:
  
  PGSIZE - 1 = 4095 = 0x0FFF = 0000 1111 1111 1111 (12 bits)
  -> ~0x0FFF = 1111...1111 0000 0000 0000

  Then, we AND the result with the object address, and this would preserve only the upper bits, which is the base address of the slab.
  */
  struct slab *slab = (struct slab *) ((uint64)obj & ~(PGSIZE - 1));

  // Debug print before freeing an object
  debug("[SLAB] Free %p in slab %p (%s)\n", obj, slab, cache->name);

  // Add the freed object back to the slab's freelist
  struct run *r = (struct run *)obj;
  r->next = slab->freelist;  // insert the freed object to the head of the freelist
  slab->freelist = r;

  // The amount of objects in use for this slab decreases by 1
  slab->inuse--;

  // Check if slab becomes empty after freeing an object
  if (slab->inuse == 0) {  // case: slab has no object being used after freeing 
    // Count free + partial slabs
    int count = 0;
    struct list_head *p;

    // list_for_each iterates over the nodes in the list, so we count the number of nodes in the partial list
    // The following line can be interpreted as:
    // for (p = cache->partial.next; p != &cache->partial; p = p->next) 
    list_for_each(p, &cache->partial) {
        count++;
    }
    list_for_each(p, &cache->free) {
        count++;
    }

    // Check if the threshold MP2_MIN_AVAIL_SLAB is satisfied
    if (count >= MP2_MIN_AVAIL_SLAB) {  // case: threshold is satisfied
      list_del(&slab->list);  // remove the slab from its original list
      kfree((void *)slab);  // we're asked to release the slab to reclaim memory under this condition
      debug("[SLAB] Slab %p (%s) is freed due to save memory\n", slab, cache->name);
      debug("[SLAB] End of free\n");
      release(&cache->lock);
      return;
    } else {  // case: threshold is not satisfied
      // Move to free list
      list_del(&slab->list);
      list_add(&slab->list, &cache->free);
    }
  } else {  // case: still exists object in the slab being used after freeing
    int max_objs = cache->max_objects_per_slab;
    // If the slab is full before freeing, it should be moved to partial after freed
    if (slab->inuse == max_objs - 1) {      
      list_del(&slab->list);  // remove the slab from its original list (full list)
      list_add(&slab->list, &cache->partial);  // add the slab to partial list 
    }
  }

  debug("[SLAB] End of free\n");
  // release the lock before return
  release(&cache->lock); 
}
