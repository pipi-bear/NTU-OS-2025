#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st; 
static jmp_buf env_tmp;  
struct thread *get_current_thread() {
    return current_thread;
}

// syntax: return_type (*pointer_name)(parameter_types);
// explain: The thread_create() function takes a funciton pointer void (*f)(void *), 
// explain: meaning that it accepts a function f that takes a void * argument and returns void
// explain: (*f) declares f as a pointer to a function
// explain: void * commonly used where function doesn't need to know what kind of data is handling
struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f; 
    t->arg = arg;

    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;               // points to the beginning of allocated stack memory for the thread.
    t->stack_p = (void*) new_stack_p;           // points to the current execution part of the thread.
    id++;   // increments ID for the next thread
    // part 2
    t->suspended = -1;               // indicating that the thread is not suspended
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;                  // no signal currently active
    t->handler_buf_set = 0;
    //printf("Thread %d created\n", t->ID);
    return t;                       // return the pointer to the newly created thread
}
void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){                     // case: if no thread currently in the runqueue
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {                                          // case: exists thread already in runqueue
        t->next = current_thread;
        t->previous = current_thread->previous;
        current_thread->previous->next = t;
        current_thread->previous = t;
        for (int i = 0; i < 2; i++) {
            if (current_thread->sig_handler[i] != NULL_FUNC) {
                // printf("Thread %d gets signal handler %d from its parent %d\n", t->ID, i, current_thread->ID);
                t->sig_handler[i] = current_thread->sig_handler[i];
            } else {
                t->sig_handler[i] = NULL_FUNC;
            }
        }
    }
}

void thread_yield(void) {
    // Check if we're in a signal handler context or normal thread context
    int in_handler = (current_thread->signo != -1 && current_thread->handler_buf_set == 1);
    
    if (in_handler) {
        printf("Thread %d yielding from signal handler (signal %d)\n", 
               current_thread->ID, current_thread->signo);
        
        // We're in a signal handler, save context in handler_env
        if (setjmp(current_thread->handler_env) == 0) {
            // Don't modify the stack pointer - setjmp already captured it
            printf("Saved handler context, scheduling next thread\n");
            
            schedule();
            printf("Schedule done, dispatching\n");
            dispatch();
            // We should never reach here
            printf("ERROR: Returned from dispatch in handler context\n");
            exit(1);
        }
        // When we return here via longjmp, just continue execution
        printf("Resumed signal handler execution via longjmp\n");
    } else {
        printf("Thread %d yielding from normal execution (buf_set=%d)\n", 
               current_thread->ID, current_thread->buf_set);
        
        // We're in normal thread execution, save context in env
        if (setjmp(current_thread->env) == 0) {
            if (current_thread->buf_set == 0) {
                current_thread->buf_set = 1;
                printf("First time saving context, set buf_set to 1\n");
            }
            
            // Don't modify the stack pointer - setjmp already captured it
            printf("Saved normal context, scheduling next thread\n");
            
            schedule();
            printf("Schedule done, dispatching\n");
            dispatch();
            // We should never reach here
            printf("ERROR: Returned from dispatch in normal context\n");
            exit(1);
        }
        // When we return here via longjmp, just continue execution
        printf("Resumed normal thread execution via longjmp\n");
    }
    // No return statement - just continue execution from where we left off
}


// aim: Switch execution to the thread chosen by schedule()
void dispatch(void) {
    struct thread *t = current_thread;
    printf("\n---------------------------------\n");
    printf("Thread %d is being dispatched (buf_set=%d, handler_buf_set=%d, signo=%d)\n", 
           t->ID, t->buf_set, t->handler_buf_set, t->signo);
    
    // If a signal exists and handler_buf_set is 1, we're resuming a handler that yielded
    if (t->signo != -1 && t->handler_buf_set == 1) {
        printf("Resuming signal handler for thread %d (signal %d)\n", t->ID, t->signo);
        
        // Resume the handler - this will jump back to thread_yield
        // Don't modify the stack pointer - it was captured by setjmp
        longjmp(t->handler_env, 1);
    }
    // If a signal exists but handler_buf_set is 0, we need to start the handler
    else if (t->signo != -1) {
        printf("Thread has pending signal %d\n", t->signo);
        
        if (t->sig_handler[t->signo] != NULL_FUNC) {
            int sig = t->signo;
            void (*handler)(int) = t->sig_handler[t->signo];
            
            // First time handling this signal
            printf("First time handling signal %d\n", sig);
            
            // Save the current state so we can return to it after the handler completes
            if (setjmp(t->env) == 0) {
                // Execute the handler
                printf("Executing signal handler\n");
                t->handler_buf_set = 1;  // Mark that we're in a handler
                handler(sig);
                
                // If we get here, the handler returned normally
                printf("Handler returned normally\n");
                t->signo = -1;  // Clear the signal
                t->handler_buf_set = 0;  // Reset handler flag
                
                // Continue with normal thread execution
                if (t->buf_set) {
                    printf("Resuming normal thread execution\n");
                    longjmp(t->env, 1);
                } else {
                    // Thread hasn't started yet
                    printf("Starting thread function after handler\n");
                    t->buf_set = 1;
                    t->fp(t->arg);
                    thread_exit();
                }
            }
            // We'll never get here
        } else {
            // No handler registered for this signal
            printf("No handler for signal %d, exiting thread\n", t->signo);
            thread_exit();
        }
    } else {
        // Normal thread execution (no signal)
        if (t->buf_set == 0) {
            // Thread hasn't started yet
            printf("Starting thread for the first time\n");
            t->buf_set = 1;
            if (setjmp(t->env) == 0) {
                t->env->sp = (unsigned long)t->stack_p;
                longjmp(t->env, 1);
            } else {
                // This is where execution starts
                t->fp(t->arg);
                thread_exit();
            }
        } else {
            // Thread was already running, just resume it
            printf("Resuming normal thread execution\n");
            // Don't modify the stack pointer - it was captured by setjmp
            longjmp(t->env, 1);
        }
    }
}

//schedule will follow the rule of FIFO
void schedule(void){
    printf("Get into schedule and current thread is %d\n", current_thread->ID);
    current_thread = current_thread->next;
    
    //Part 2: TO DO
    while(current_thread->suspended == 0) {
        // When current thread is suspended, skip this thread and move to the next one
        current_thread = current_thread->next;  
    }
    printf("scheduled to thread %d\n", current_thread->ID);
}

// aim: 1. remove the calling thread from runqueue
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next to-be-thread in runqueue (schedule())
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function

void thread_exit(void){
    printf("thread_exit\n");
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
        //TO DO
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        // (1.)
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        
        // (3.)
        //current_thread = current_thread->next;
        schedule();  // consider the case that current_thread->next is suspended, and should move on find the next thread 

        // (2.)
        free(t->stack);
        free(t);

        // (4.)
        dispatch();
    } else {                                         // case: last thread 
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
}

void thread_start_threading(void){
    //TO DO
    // Save the main function's context
    if (setjmp(env_st) == 0) {
        schedule();
        dispatch();  
    } else {        // When all the threads exit, setjmp(env_st) != 0
        return;
    }
}

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
    current_thread->sig_handler[signo] = handler;
    // printf("Thread %d has signal %d handler registered\n", current_thread->ID, signo);
}

void thread_kill(struct thread *t, int signo){
    //TO DO
    // printf("Thread %d is executing thread_kill for signal %d\n", t->ID, signo);
    // Mark the signal for the thread
    t->signo = signo;

    if (t->sig_handler[signo] == NULL_FUNC) {       // case: no handler for this signo
        // printf("Thread %d has no handler for signal %d, it will be terminated on resume.\n", t->ID, signo);
        // Instead of calling thread_exit(), mark the function pointer to thread_exit, so that thread terminate when t resumes
        t->fp = (void (*)(void *)) thread_exit;  
    }
}

void thread_suspend(struct thread *t) {
    //TO DO
    // Mark the thread as suspended (0)
    t->suspended = 0;
    // If the current thread suspends itself, need to call thread_yield() as asked in the HW instructions
    if (t == current_thread) {
        thread_yield();
    }
}

void thread_resume(struct thread *t) {
    //TO DO
    if (t->suspended == 0) {        // if the thread is suspended (suspended == 0)
        t->suspended = -1;          // set suspended to -1 to indicate that the thread is resumed
    }
}

