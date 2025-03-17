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
    t->suspended = 0;               
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;                  
    t->handler_buf_set = 0;
    return t;                       
}


void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){                     
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    }else{                                          
        //TO DO
        t->next = current_thread;
        t->previous = current_thread->previous;
        current_thread->previous->next = t;
        current_thread->previous = t;
    }

    for (int i = 0; i < 2; i++) {
        t->sig_handler[i] = current_thread->sig_handler[i];
    }
}


void thread_yield(void){
    //TO DO
    if (current_thread->signo != -1) {              
        if (setjmp(current_thread->handler_env) == 0) {
            schedule();  
            dispatch();  
        }
    } 
    else {                                          
        if (setjmp(current_thread->env) == 0) {
            schedule();  
            dispatch();  
        } else {
            return;
        }
    }
}

void dispatch(void){
    //TO DO   
    struct thread *t = current_thread; 

    if (t->signo != -1) {
        if (t->sig_handler[t->signo] != NULL) {     
            if (setjmp(t->handler_env) == 0) {
                t->handler_buf_set = 1; 
                t->sig_handler[t->signo](t->signo);
                t->signo = -1;
                longjmp(t->env, 1);
            } 
        } else {            
            thread_exit();  
        }
    }
 
    if (setjmp(t->env) == 0) {  
        if (t->stack_p == NULL) {                       
            asm volatile("mv sp, %0" :: "r"(t->stack));
            t->fp(t->arg);
            thread_exit();
        } else {                                        
            longjmp(t->env, 1);
        }
    }  
}

void schedule(void){
    current_thread = current_thread->next;
    
    //Part 2: TO DO
    while(current_thread->suspended) {
        current_thread = current_thread->next;  
    };
    
}

void thread_exit(void){
    if(current_thread->next != current_thread){     
        //TO DO
        struct thread *t = current_thread;
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        current_thread = current_thread->next;
        free(t->stack);
        free(t);
        dispatch();
    } else{                                           
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
}

void thread_start_threading(void){
    //TO DO
    if (setjmp(env_st) == 0) {
        dispatch();  
    }
}

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
    current_thread->sig_handler[signo] = handler;
}


void thread_kill(struct thread *t, int signo){
    //TO DO
    t->signo = signo;

    if (t->sig_handler[signo] != NULL) {
        return; 
    }

    t->fp = (void (*)(void *)) thread_exit;
}

void thread_suspend(struct thread *t) {
    //TO DO
    t->suspended = 0;

    if (t == current_thread) {
        thread_yield();
    }
}
void thread_resume(struct thread *t) {
    //TO DO
    if (t->suspended) {
        t->suspended = 0;  
    }
}

