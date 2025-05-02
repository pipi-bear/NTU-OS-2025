#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"
#include <limits.h>
#define NULL 0

/* default scheduling algorithm */
#ifdef THREAD_SCHEDULER_DEFAULT
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
            thread_with_smallest_id = th;
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}
#endif

/* MP3 Part 1 - Non-Real-Time Scheduling */

// HRRN
#ifdef THREAD_SCHEDULER_HRRN
struct threads_sched_result schedule_hrrn(struct threads_sched_args args)
{
    const int SCALE = 1000;

    struct thread *selected_thread = NULL;
    int largest_scaled_ratio = -1;

    struct thread *t;
    list_for_each_entry(t, args.run_queue, thread_list) {
        int waiting_time = args.current_time - t->arrival_time;

        if (waiting_time < 0) continue;

        int burst_time = t->processing_time;

        int current_scaled_ratio = (waiting_time + burst_time) * SCALE / burst_time;

        if (current_scaled_ratio > largest_scaled_ratio ||
           (current_scaled_ratio == largest_scaled_ratio && (selected_thread == NULL || t->ID < selected_thread->ID))) {
            largest_scaled_ratio = current_scaled_ratio;
            selected_thread = t;
        }
    }

    struct threads_sched_result r;
    if (selected_thread) {
        r.scheduled_thread_list_member = &selected_thread->thread_list;
        r.allocated_time = selected_thread->remaining_time; // nonpreemptive
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }
    return r;
}
#endif

#ifdef THREAD_SCHEDULER_PRIORITY_RR
// priority Round-Robin(RR)
struct threads_sched_result schedule_priority_rr(struct threads_sched_args args) 
{
    struct thread *t;
    struct thread *selected_thread = NULL;

    int highest_priority_value = -1;

    // First pass: Find the minimum priority among arrived, runnable threads
    list_for_each_entry(t, args.run_queue, thread_list) {
        // printf("\nCurrent time: %d\n", args.current_time);
        // printf("The current thread %d is arrived at %d and remaining time is %d\n", t->ID, t->arrival_time, t->remaining_time);
        if (t->arrival_time > args.current_time || t->remaining_time <= 0){
            // printf("The current thread is arrived at %d and remaining time is %d, so move on to next thread\n", t->arrival_time, t->remaining_time);
            continue;
        }

        if (highest_priority_value == -1 || t->priority < highest_priority_value) {
            // printf("The original highest priority is %d, updated to %d\n", highest_priority_value, t->priority);
            highest_priority_value = t->priority;
        }
    }
    // printf("highest_priority_value: %d\n", highest_priority_value);

    // Second pass: Round-robin over threads with highest_priority_value
    list_for_each_entry(t, args.run_queue, thread_list) {
        if (t->arrival_time > args.current_time || t->remaining_time <= 0)
            continue;

        if (t->priority == highest_priority_value) {
            selected_thread = t;
            break; // pick the first one (RR behavior depends on external reordering)
        }
    }
    
    struct threads_sched_result r;

    if (selected_thread) {
        r.scheduled_thread_list_member = &selected_thread->thread_list;

        // Count how many threads are runnable in the same priority group
        // Since if only one thread is runnable in the same priority group, it will run to completion
        int count_same_priority = 0;
        list_for_each_entry(t, args.run_queue, thread_list) {
            if (t->arrival_time <= args.current_time &&
                t->remaining_time > 0 &&
                t->priority == selected_thread->priority) {
                count_same_priority++;
            }
        }

        if (count_same_priority == 1) {
            r.allocated_time = selected_thread->remaining_time; 
        } else {
            r.allocated_time = (selected_thread->remaining_time >= args.time_quantum)
                                ? args.time_quantum
                                : selected_thread->remaining_time;
        }
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 0;
    }
    
    return r;
}
#endif

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
    struct thread *th = NULL;
    struct thread *thread_missing_deadline = NULL;
    list_for_each_entry(th, run_queue, thread_list) {
        if (th->current_deadline <= current_time) {
            if (thread_missing_deadline == NULL)
                thread_missing_deadline = th;
            else if (th->ID < thread_missing_deadline->ID)
                thread_missing_deadline = th;
        }
    }
    return thread_missing_deadline;
}
#endif

#ifdef THREAD_SCHEDULER_DM
/* Deadline-Monotonic Scheduling */
static int __dm_thread_cmp(struct thread *a, struct thread *b)
{
    if (a->period < b->period)
        return -1;  // a has higher priority
    else if (a->period > b->period)
        return 1;   // b has higher priority
    else
        return (a->ID < b->ID) ? -1 : 1;  // break ties using ID
}

struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    struct threads_sched_result r;

    // Step 1: check for any missed deadline (report violation)
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    if (missed != NULL) {
        r.scheduled_thread_list_member = &missed->thread_list;
        r.allocated_time = 0;
        return r;
    }

    // Step 2: Find the highest priority eligible thread (DM = shortest period)
    struct thread *th = NULL;
    struct thread *selected = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (th->arrival_time > args.current_time || th->remaining_time <= 0)
            continue;

        if (selected == NULL || __dm_thread_cmp(th, selected) < 0) {
            selected = th;
        }
    }

    // Step 3: If no eligible thread found, find the next release time
    if (selected == NULL) {
        int next_release = INT_MAX;
        struct release_queue_entry *rqe = NULL;
        list_for_each_entry(rqe, args.release_queue, thread_list) {
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
                next_release = rqe->release_time;
            }
        }
        
        if (next_release != INT_MAX) {
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
            r.allocated_time = next_release - args.current_time;
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
            r.allocated_time = 0;
        }
        return r;
    }

    // Step 4: determine safe allocation before next high-priority arrival
    int max_alloc = selected->remaining_time;

    struct release_queue_entry *rqe = NULL;
    list_for_each_entry(rqe, args.release_queue, thread_list) {
        struct thread *future = rqe->thrd;

        if (future->arrival_time > args.current_time &&
            future->arrival_time < args.current_time + max_alloc &&
            __dm_thread_cmp(future, selected) < 0) {

            // preemption will occur at this future release
            int safe_time = future->arrival_time - args.current_time;
            if (safe_time < max_alloc) {
                max_alloc = safe_time;
            }
        }
    }

    // Also check if we need to limit allocation to not miss deadline
    int time_to_deadline = selected->current_deadline - args.current_time;
    if (time_to_deadline < max_alloc) {
        max_alloc = time_to_deadline;
    }

    // Step 5: Schedule the selected thread for the maximum tick amount it would not be preempted
    r.scheduled_thread_list_member = &selected->thread_list;
    r.allocated_time = max_alloc;
    return r;
}
#endif


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
    if (a->current_deadline > b->current_deadline) return 1;
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
    if (a->ID > b->ID) return 1;
    
    return 0;
}

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
    r.allocated_time = 0;

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
            args.current_time == t->current_deadline) {
            // replenish
            t->current_deadline += t->period;
            t->cbs.remaining_budget = t->cbs.budget;
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    if (missed) {
        r.scheduled_thread_list_member = &missed->thread_list;
        r.allocated_time = 0;
        return r;
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
    list_for_each_entry(t, args.run_queue, thread_list) {
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
             args.current_time < t->current_deadline))
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
            selected = t;
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
        int next_release = INT_MAX;
        struct release_queue_entry *rqe = NULL;
        list_for_each_entry(rqe, args.release_queue, thread_list) {
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
                next_release = rqe->release_time;
            }
        }
        
        if (next_release != INT_MAX) {
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
            r.allocated_time = next_release - args.current_time;
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
            r.allocated_time = 0;
        }
        return r;
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
        int remaining_budget = selected->cbs.remaining_budget;
        int time_until_deadline = selected->current_deadline - args.current_time;
        int scaled_left = remaining_budget * selected->period;
        int scaled_right = selected->cbs.budget * time_until_deadline;

        if (scaled_left > scaled_right) {
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
            selected->cbs.remaining_budget = selected->cbs.budget;
            goto start_scheduling;  // Restart scheduling decision
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
            r.scheduled_thread_list_member = &selected->thread_list;
            r.allocated_time = 0;
            goto start_scheduling;  // Restart scheduling decision after throttling
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
        struct release_queue_entry *rqe = NULL;
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
            struct thread *future = rqe->thrd;
            if (future->arrival_time > args.current_time &&
                future->arrival_time < args.current_time + max_alloc &&
                __edf_thread_cmp(future, selected) < 0) {
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
                if (safe_time < max_alloc) {
                    max_alloc = safe_time;
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
        if (time_to_deadline < max_alloc) {
            max_alloc = time_to_deadline;
        }

        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = max_alloc;
    }

    return r;
}
#endif