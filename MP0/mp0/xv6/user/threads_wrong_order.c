#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0


static struct thread* current_thread = NULL;
static int id = 1;

//the below 2 jmp buffer will be used for main function and thread context switching
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
    // printf("Thread %d added to run queue\n", t->ID);
    if(current_thread == NULL){                     // case: if no thread currently in the runqueue
        // printf("No thread in runqueue, adding thread %d\n", t->ID);
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {                                          // case: exists thread already in runqueue
        //printf("Thread %d already in runqueue, adding thread %d\n", current_thread->ID, t->ID);
        //TO DO
        // aim: 1. Insert t before current_thread in the circular linked list 
        // aim: 2. Update next and previous pointers
        t->next = current_thread;
        t->previous = current_thread->previous;
        current_thread->previous->next = t;
        current_thread->previous = t;

        // Let the child thread (t) inherit the 2 signal handlers (0, 1) from its parent (current_thread) if they exist
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

void thread_yield(void){
    //TO DO
    // Check if the current thread has an active signal
    // printf("Thread %d is yielding\n", current_thread->ID);
    if (current_thread->signo != -1) {           
        // printf("Thread %d has a signal %d\n", current_thread->ID, current_thread->signo);
        if (current_thread->handler_buf_set == 0) { 
            if (setjmp(current_thread->handler_env) == 0) {
                current_thread->handler_buf_set = 1; 
                // printf("save context and schedule\n");
                schedule();  // Determine which thread to run next
                // printf("schedule done, dispatch\n");
                dispatch();  // Execute the new thread
            } 
        } 
        return;
    }
    // printf("Thread %d has no signal\n", current_thread->ID);
    if (current_thread->buf_set == 0) { 
        if (setjmp(current_thread->env) == 0) {   
            current_thread->buf_set = 1; 
            // printf("save context and schedule\n");
            schedule();  
            // printf("schedule done, dispatch\n");
            dispatch();  
        } 
    }
    return;
}

// aim: Switch execution to the thread chosen by schedule()
void dispatch(void) {
    struct thread *t = current_thread;
    // printf("Current thread being dispatched: %d\n", t->ID);
    
    // Ensure the thread context is initialized
    if (t->buf_set == 0) {
        t->buf_set = 1;
        if (setjmp(t->env) == 0) {
            // First time execution
            if (t->signo != -1 && t->sig_handler[t->signo] != NULL_FUNC) {
                int sig = t->signo;
                void (*handler)(int) = t->sig_handler[t->signo];

                if (setjmp(t->handler_env) == 0) {  
                    t->handler_buf_set = 1;
                    handler(sig); // Execute the signal handler
                    t->signo = -1;  // Reset signal AFTER execution
                }
            }

            // Execute thread function after handling signal
            t->fp(t->arg);
            thread_exit();  // Exit after function execution
        }
        return;
    }

    // Resume execution after handling a signal (if applicable)
    if (t->handler_buf_set == 1) {
        t->handler_buf_set = 0;  // Mark handler as done
        t->signo = -1;           // Reset signal
        longjmp(t->env, 1);
    }

    // Resume normal execution
    longjmp(t->env, 1);
}

//schedule will follow the rule of FIFO
void schedule(void){
    current_thread = current_thread->next;
    
    //Part 2: TO DO
    while(current_thread->suspended == 0) {
        // When current thread is suspended, skip this thread and move to the next one
        current_thread = current_thread->next;  
    }
}

// aim: 1. remove the calling thread from runqueue
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next thread in runqueue
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function

void thread_exit(void){
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
        //TO DO
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        // (1.)
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        
        // (3.)
        current_thread = current_thread->next;

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

