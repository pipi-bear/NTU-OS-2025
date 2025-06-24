#pragma once

#include "spinlock.h"
#include "types.h"
#include "list.h"

struct run {
  struct run *next;
};

/**
 * struct slab - Represents a slab in the slab allocator.
 * @freelist: Linked list of free objects.
 */
struct slab
{
  struct run *freelist;             // Linked list of free objects
  struct list_head list;
  int inuse;                       // Number of objects in use in this slab  
};

/**
 * struct kmem_cache - Represents a cache of slabs.
 * @name: Cache name (e.g., "file").
 * @object_size: Size of a single object.
 * @lock: Lock for cache management.
 */
struct kmem_cache
{
  char name[32];        // Cache name (e.g., "file")
  uint object_size;     // Size of a single object
  struct spinlock lock; // Lock for cache management
  uint max_objects_per_slab; // Maximum number of objects per slab
  uint in_cache_obj;         // Maximum number of objects inside kmem_cache (if internal fragmentation issue is implemented), else 0
  
  struct list_head full;     // Completely allocated slabs (Optional)
  struct list_head partial;  // Partially allocated slabs
  struct list_head free;     // Free slabs (Optional)
};

struct slab *grow_slab(struct kmem_cache *cache);

/**
 * kmem_cache_create - Create a new slab cache.
 * @name: The name of the cache.
 * @object_size: The size of each object in the cache.
 *
 * Return: A pointer to the new cache.
 */
struct kmem_cache *kmem_cache_create(char *name, uint object_size);

/**
 * kmem_cache_destroy - Destroy a slab cache.
 * @cache: The cache to be destroyed.
 */
void kmem_cache_destroy(struct kmem_cache *cache);

/**
 * kmem_cache_alloc - Allocate an object from a slab cache.
 * @cache: The cache to allocate from.
 *
 * Return: A pointer to the allocated object.
 */
void *kmem_cache_alloc(struct kmem_cache *cache);

/**
 * kmem_cache_free - Free an object back to its slab cache.
 * @cache: The cache to free to.
 * @obj: The object to free.
 */
void kmem_cache_free(struct kmem_cache *cache, void *obj);

/**
 * print_kmem_cache - Print the details of a kmem_cache.
 * @cache: The cache to print.
 * @print_fn: Function to print each object in the cache. If NULL (0) is given, will skip object printing part.
 */
void print_kmem_cache(struct kmem_cache *cache, void (*print_fn)(void *));

