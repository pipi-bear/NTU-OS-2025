#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0


static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
//static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    id++;

    // part 2
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;
    t->handler_buf_set = 0;
    t->suspended = 0; // Initialize suspended flag
    return t;
}
void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){
        // case: first thread in the system
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    }
    else{
        // case: adding thread to existing queue
        t->sig_handler[0] = current_thread->sig_handler[0];
        t->sig_handler[1] = current_thread->sig_handler[1];
        
        // Insert into circular linked list
        current_thread->previous->next = t;
        t->previous = current_thread->previous;
        t->next = current_thread;
        current_thread->previous = t;
    }
}

/*
When setjmp() is executed:
1. When a thread voluntary yields (before releasing CPU)
> This saves: registers, sp, ra, other execution states, so that we can use longjmp() to resume execution later.

2. When a new thread starts execution
> If a thread has never run before, the setjmp() in dispatch() will return 0, so we manually initialize the stack and start execution.

- setjmp() is executed:
    - when a thread yields (to save context) 
    - when a new thread starts (to check if it has been executed before)
*/

void thread_yield(void){
    // case: thread has pending signal
    if(current_thread->signo != -1){
        if(setjmp(current_thread->handler_env) == NULL){
            //printf("check\n");
            schedule();
            dispatch();
        }
    }
    else{
        // case: normal thread yield
        if(setjmp(current_thread->env) == NULL){
            schedule();
            dispatch();
            //printf("return here\n");
        }
    }
    
    
}
void dispatch(void){
    // TODO
    // Get the thread to be dispatched
    struct thread *t = current_thread;
    
    // Check if the thread's context (env) has been initialized
    if (t->buf_set == 0) {       // case: first time setting the context (buf_set == 0)
        t->buf_set = 1;
        if (setjmp(t->env) == 0) {  // case: first time calling setjmp
            // Set the stack pointer to the allocated stack pointer (stack_p)
            t->env->sp = (unsigned long) t->stack_p;
            longjmp(t->env, 1);
        } else {                    // case: already set the context (buf_set == 1)
            // Execute the thread function
            t->fp(t->arg);
            thread_exit();
        }
    }

    if (t->signo != -1) {   // case: If a signal has been set
        if (t->sig_handler[t->signo] != NULL_FUNC) {     // case: exists corresponding signal handler
            // If we are returning from longjmp(handler_env), skip handling
            if (t->handler_buf_set == 1) {      // case: already set the context (handler_buf_set == 1)
                longjmp(t->handler_env, 1);
            } else {                            // case: handler_buf_set == 0
                if (setjmp(t->handler_env) == 0) {  // case: first time calling setjmp  
                    t->handler_buf_set = 1;
                    t->handler_env->sp = (unsigned long) t->stack_p - 50*8;
                    longjmp(t->handler_env, 1);
                } else {
                    // Call the signal handler to handle the corresponding signal
                    t->sig_handler[t->signo](t->signo);
                    //printf("the signal: %d of thread %d has been handled\n",t->signo,t->ID);
                    // Reset signal (as it has been handled)
                    t->signo = -1;
                    
                    // Continue dispatching
                    dispatch();
                }
            }
        } else {
            // No signal handler is registered, so the thread should be killed
            thread_exit();
        }
    } else {
        // Continue executing the thread by jumping to the saved context
        //printf("continue executing the thread by restoring context via longjmp\n");
        longjmp(t->env, 1);
    }
    
    thread_exit();  // exit when the function is completed
}
void schedule(void){
    // TODO
    //printf("schedule\n");
    current_thread = current_thread->next;
    
    // Skip suspended threads, if the thread is suspended, we kept moving to the next thread
    while (current_thread->suspended) {
        current_thread = current_thread->next;
    }
}



void thread_exit(void){
    if(current_thread->next != current_thread){         // case: has more than one thread in the runqueue
        struct thread *curr = current_thread;
        // Remove from circular list
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        schedule();
        free(curr->stack);
        free(curr);
        dispatch();
    }
    else{
        // case: last thread in system
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st,1);    // return to main function
    }
}

/*
First, setjmp(env_st) saves the execution state of the main function, 
and as the first time setjmp(env_st) is executed, it returns 0. 
If it's the case, we need to start dispatching threads, 
after all the threads in the runqueue exit, 
thread_exit() is called by the last thread, and the else condition is satisfied, 
when longjmp(env_st, 1); is executed, we jump back to if (setjmp(env_st) == 0) in thread_start_threading(), 
but now the condition is not satisfied
*/

void thread_start_threading(void){
    if(setjmp(env_st) == 0){
        schedule();
        dispatch();
    }
    else return;
}

// part 2

/*
When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", 
then executes the sig_handler function.
If another signal handler has already been registered by the same signal, just replace it
*/
void thread_register_handler(int signo, void (*handler)(int)){
    // Register signal handler for current thread
    current_thread->sig_handler[signo] = handler;
    sleep(3);
}

/*
> xv6.pdf p.77

While a process can call thread_exit() to terminate itself, sometimes one process wants to kill another process (ex: parent kills child),
thread_kill() does not immediately terminates the victim process, but instead sets a flag (p->killed), marking it to be killed later
*/
void thread_kill(struct thread *t, int signo){
    // Set signal for specified thread
    t->signo = signo;
}


/*
If a running thread calls thread_suspend(current_thread), it means that the current running thread is suspending itself, 
then after setting the suspend status to 1, it should not continue running, 
however, since it is still executing, we need to use thread_yield() to let anothere thread to run.

ex:

Thread A  >  Thread B  >  Thread C  

current_thread = Thread A, and Thread A calls thread_suspend: thread_suspend(current_thread)
Since t == current_thread, thread_yield() is called and schedule() is executed 

current_thread is set to the next of the original current_thread (Thread B), 
if Thread B is also suspended, the while loop would then move on checking Thread C
*/

void thread_suspend(struct thread *t) {
    // Mark thread as suspended
   t->suspended = 1;
}


void thread_resume(struct thread *t) {
    t->suspended = 0;
}

struct thread* get_current_thread() {
    // Return pointer to current thread
    return current_thread;
}