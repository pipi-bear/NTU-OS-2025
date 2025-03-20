/*
void dispatch(void){
    //TO DO   
    // Get the thread to be dispatched
    struct thread *t = current_thread; 
    printf("Current thread being dispatched: %d\n", t->ID);
    printf("buf_set: %d\n", t->buf_set);
    // check if the thread's context (env) has been initialized
    if (t->buf_set == 0) {       // case: first time setting the context (buf_set == 0)
        printf("Thread %d has not set the context\n", t->ID);
        t->buf_set = 1;
        if (setjmp(t->env) == 0) {  // case: first time calling setjmp
            printf("Thread %d is setting the context and would perform longjmp\n", t->ID);
            // set the stack pointer to the allocated stack pointer (stack_p)
            longjmp(t->env, 1);
        } 
    }

    if (t->signo != -1) {   // case: If a signal has been set
        printf("It has a signal %d\n", t->signo);
        if (t->sig_handler[t->signo] != NULL_FUNC) {     // case: exists corresponding signal handler
            // If we are returning from longjmp(handler_env), skip handling
            if (t->handler_buf_set == 1) {  
                printf("Thread %d resuming from signal handler\n", t->ID);
                t->signo = -1;  // Reset signal since it's already handled
                t->handler_buf_set = 0;  // Mark handler as finished
                longjmp(t->env, 1);  // Restore original context
            } 
            // First time handling the signal
            printf("Thread %d has a signal handler for signal %d\n", t->ID, t->signo);
            if (setjmp(t->handler_env) == 0) { 
                t->handler_buf_set = 1;
                // Call the signal handler
                t->sig_handler[t->signo](t->signo);
                printf("Signal handler executed\n");

                // Reset signal (as it has been handled)
                t->signo = -1;

                // Restore original context after signal handling
                longjmp(t->env, 1);
            }
        } else {                                   // case: no signal handler is registered
            printf("No signal handler is registered\n");
            // current_thread should be killed i.e. calling thread_exit() directly
            thread_exit();                         
        }
    }          

    // continue executing the thread's function
    printf("Thread %d executing its function\n", t->ID);
    t->fp(t->arg);  // resumes the execution, so execute the function t->fp with arguments t->arg
    thread_exit();  // exit when the function is completed
}   
*/