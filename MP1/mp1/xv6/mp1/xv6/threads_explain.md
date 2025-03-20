# PART 1

## setjmp (Linux manual Page)
The functions described on this page are used for performing
"nonlocal gotos": transferring execution from one function to a
predetermined location in another function.  The setjmp() function
dynamically establishes the target to which control will later be
transferred, and longjmp() performs the transfer of execution.

The setjmp() function saves various information about the calling
environment (typically, the stack pointer, the instruction
pointer, possibly the values of other registers and the signal
mask) in the buffer env for later use by longjmp().  In this case,
setjmp() returns 0.

The longjmp() function uses the information saved in env to
transfer control back to the point where setjmp() was called and
to restore ("rewind") the stack to its state at the time of the
setjmp() call.  In addition, and depending on the implementation
(see NOTES and HISTORY), the values of some other registers and
the process signal mask may be restored to their state at the time
of the setjmp() call.

Following a successful longjmp(), execution continues as if
setjmp() had returned for a second time.  This "fake" return can
be distinguished from a true setjmp() call because the "fake"
return returns the value provided in val.  If the programmer
mistakenly passes the value 0 in val, the "fake" return will
instead return 1.


- For more details, visit the page: https://www.man7.org/linux/man-pages/man3/setjmp.3.html
Or check the pdf file in "MP1" directory

When setjmp() is executed:
1. When a thread voluntary yields (before releasing CPU)
> This saves: registers, sp, ra, other execution states, so that we can use longjmp() to resume execution later.

2. When a new thread starts execution
> If a thread has never run before, the setjmp() in dispatch() will return 0, so we manually initialize the stack and start execution.

- setjmp() is executed:
    - when a thread yields (to save context) 
    - when a new thread starts (to check if it has been executed before)

## thread_yield()

In thread_yield(), we need to consider two cases, determined by where thread_yield() has been called:
- thread_yield() called by a normal thread      $\rightarrow$ save in env
- thread_yield() called in the signal handler   $\rightarrow$ save in handler_env (to prevent from discarding the context of the thread function)

Consider handling the case that current_thread->signo != -1 (a signal is raised):

    for the first time entering thread_yield(), setjmp is called first time, so would return 0, 
    therefore the if condition is satisfied and we would execute schedule() and dispatch(), 
    in schedule(), we would find the thread that is not suspended to be the next current_thread
    in dispatch(), we would check if there's a corresponding signal handler, 
        - if does not exist, terminate by thread_exit();
        - if exist, handle the signal and longjmp(t->env, 1); is called
            Now setjmp returns a nonzero value, setjmp(current_thread->handler_env) == 0 is not satisfied

## thread_start_threading()

First, setjmp(env_st) saves the execution state of the main function, and as the first time setjmp(env_st) is executed, it returns 0. 
If it's the case, we need to start dispatching threads, after all the threads in the runqueue exit, thread_exit() is called by the last thread, and the else condition is satisfied, when longjmp(env_st, 1); is executed, we jump back to if (setjmp(env_st) == 0) in thread_start_threading(), but now the condition is not satisfied

# PART 2

## thread_register_handler()

When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", then executes the sig_handler function.

If another signal handler has already been registered by the same signal, just replace it

## thread_kill()

> xv6.pdf p.77

While a process can call thread_exit() to terminate itself, sometimes one process wants to kill another process (ex: parent kills child),
thread_kill() does not immediately terminates the victim process, but instead sets a flag (p->killed), marking it to be killed later

- if the victim process is sleeping: kill's call to wakeup will cause the victim to return from sleep

## thread_suspend()

If a running thread calls thread_suspend(current_thread), it means that the current running thread is suspending itself, then after setting the suspend status to 1, it should not continue running, however, since it is still executing, we need to use thread_yield() to let anothere thread to run.

### ex

Thread A  >  Thread B  >  Thread C  

current_thread = Thread A, and Thread A calls thread_suspend: thread_suspend(current_thread)
Since t == current_thread, thread_yield() is called and schedule() is executed 

$\rightarrow$ current_thread is set to the next of the original current_thread (Thread B), if Thread B is also suspended, the while loop would then move on checking Thread C

## thread_resume()

If f is suspended, the if condition is satisfied, and we then proceed to change the "suspend" attribute to 0, so that in the dispatch() function, when we move current_thread to this t, we would not enter the while loop to move on to the next thread