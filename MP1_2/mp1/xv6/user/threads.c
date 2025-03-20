#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0


static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// note: we comment out env_tmp because it is not used in the code, and would cause notification when compiled
// static jmp_buf env_tmp;

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
    t->stack = (void*) new_stack;       // points to the beginning of allocated stack memory for the thread.
    t->stack_p = (void*) new_stack_p;   // points to the current execution part of the thread.
    id++;                               // increments ID for the next thread

    // part 2
    t->suspended = -1;                  // indicating that the thread is not suspended
    t->sig_handler[0] = NULL_FUNC;   
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;                      // no signal currently active
    t->handler_buf_set = 0;
    // printf("Thread %d created\n", t->ID);
    return t;                           // return the pointer to the newly created thread
}

void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){                                 // case: adding the first thread to the runqueue
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {                                                    // case: adding thread to runqueue with existing threads
        // child thread t should inherit the signal handlers from the parent thread (current_thread)
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

1. When a thread voluntarily yields (before releasing CPU)
> This saves: registers, sp, ra, other execution states, so that we can use longjmp() to resume execution later.

2. When a new thread starts execution
> If a thread has never run before, the setjmp() in dispatch() will return 0, so we manually initialize the stack and start execution.

- setjmp() is executed:
    - when a thread yields (to save context) 
    - when a new thread starts (to check if it has been executed before)
*/


/*
In thread_yield(), we need to consider two cases, determined by whether the thread is executing the signal handler:
- thread_yield() called when a signal exists      >> save in handler_env (to prevent from discarding the context of the thread function)
- thread_yield() called under normal condition    >> save in env
*/

void thread_yield(void){
    if(current_thread->signo != -1){                        // case: thread has pending signal
        if(setjmp(current_thread->handler_env) == NULL){
            schedule();
            dispatch();
        }
    } else {                                                // case: normal thread yield
        if(setjmp(current_thread->env) == NULL){
            schedule();
            dispatch();
        }
    }
}

/*
Consider the more complex case, where our current_thread is marked with a signal:

1. check if we have a signal 
2. check if the signal handler is not NULL (if we have a corresponding signal handler)
3. check if the we have saved the context in handler_env:
    - if so, use longjmp to restore the context
    - if not, we need to save the context in handler_env
        - first we enter the else condition, and manually set sp, and mark handler_buf_set to 1 (we have saved the context in handler_env)
        - then we jump back to the if condition and execute the signal handler, when we exit the signal handler, we reset the signo to -1 and reenter dispatch()
4. This time, we have no signal, so we first check buf_set to see if we have saved the context in env
    - if so, use longjmp to restore the context
    - if not, we need to save the context in env
        - first we enter the else condition, and manually set sp, and mark buf_set to 1 (we have saved the context in env)
        - then we jump back to the if condition and execute the function
5. After all these are done, we exit the function via thread_exit()
*/
void dispatch(void){
    if(current_thread->signo != -1){    // case: thread has pending signal
        if(current_thread->sig_handler[current_thread->signo] != NULL_FUNC){
            if(current_thread->handler_buf_set == 1){              // case: handler_buf_set == 1 indicating that the context has been saved in handler_env
                longjmp(current_thread->handler_env,1);
            } else {                                               // case: handler_buf_set == 0
                if(setjmp(current_thread->handler_env) == 1){
                    current_thread->sig_handler[current_thread->signo](current_thread->signo);      // execute the corresponding signal handler
                    current_thread->signo = -1;                                                     // reset the signo to -1
                    dispatch();                                                                     // reenter dispatch() and goto line 118 (since signal has reset)
                } else {              
                    current_thread->handler_env->sp = (unsigned long) current_thread->stack_p-50*8;
                    current_thread->handler_buf_set = 1;
                    // printf("longjmp to handler_env");
                    longjmp(current_thread->handler_env,1);
                }
            }
        } else {
            // printf("execute thread_exit");
            thread_exit();
        }
    } else {                            // case: no signal, can continue execution of thread's function
        if(current_thread->buf_set == 1){           // case: has a saved context in env
            // printf("longjmp to restore the context saved in env");
            // jump back to the saved context in env
            longjmp(current_thread->env,1);
        } else {                                    // case: buf_set == 0, indicating that the context has not been saved in env
            // explain: we enter the else condition if it is the first time saving the context in env,
            // explain: then we longjmp so that we can go back to the if condition and execute the function
            if(setjmp(current_thread->env) == 1){ 
                current_thread->fp(current_thread->arg);
            } else {
                current_thread->env->sp =(unsigned long) current_thread->stack_p;   // manually set sp of the current thread to stack_p
                current_thread->buf_set = 1;                                        // set the buf_set to 1 to indicate that the buf has been set
                longjmp(current_thread->env,1);
            }
        }
        thread_exit();
    }
}

// note: schedule will follow the rule of FIFO
void schedule(void){
    // printf("Get into schedule and current thread is %d\n", current_thread->ID);
    current_thread = current_thread->next;
    
    // Skip suspended threads, if the thread is suspended, we kept moving to the next thread
    while (current_thread->suspended) {
        current_thread = current_thread->next;
    }
    // printf("scheduled to thread %d\n", current_thread->ID);
}


// aim: 1. remove the calling thread from runqueue
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next to-be-executed thread in runqueue (schedule())
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function
void thread_exit(void){
    if(current_thread->next != current_thread){         // case: has more than one thread in the runqueue
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        
        // (1.) 
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        
        // (3.)
        schedule();
        
        // (2.)
        free(t->stack);
        free(t);
        
        // (4.)
        dispatch();
    } else {                                              // case: last thread in system
        // free the stack and the thread itself, and return to the main function
        free(current_thread->stack);
        free(current_thread);
        // we return to main function via longjmp since the context of the main function is saved in env_st
        longjmp(env_st,1);    
    }
}

/*
After the first thread is added to the runqueue, thread_start_threading() will be called in the main function.
Therefore, we would first use setjmp(env_st) to save the execution state of the main function, 
and as it is the first time setjmp(env_st) is executed, it returns 0. 

When there's only the last thread in the runqueue, and it called thread_exit(), longjmp(env_st, 1) would be executed, 
we then jump back to check the condition if (setjmp(env_st) == 0) in thread_start_threading(), 
but now the condition is not satisfied, so we would return as specified in the instruction.
*/

void thread_start_threading(void){
    if(setjmp(env_st) == 0){
        schedule();
        dispatch();
    } else {        // case: all threads have exited
        return;
    }
}


/*
When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", 
then executes the sig_handler function.

If another signal handler has already been registered by the same signal, just replace it
*/
void thread_register_handler(int signo, void (*handler)(int)){
    // Register signal handler for current thread
    current_thread->sig_handler[signo] = handler;
}

/*
> xv6.pdf p.77
While a process can call thread_exit() to terminate itself, 
sometimes one process wants to kill another process (ex: parent kills child),

thread_kill() **does not** immediately terminates the victim process, but instead sets a flag (p->killed), marking it to be killed later
---
Our thread_kill() function would mark thraed t with signo, and then when t is resumed later:
    - if t has corresponding handler for signo: execute handler first
    - else: execute thread_exit()
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
    // Return pointer to the current thread
    return current_thread;
}