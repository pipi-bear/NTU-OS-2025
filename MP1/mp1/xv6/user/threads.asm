
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
// syntax: return_type (*pointer_name)(parameter_types);
// explain: The thread_create() function takes a funciton pointer void (*f)(void *), 
// explain: meaning that it accepts a function f that takes a void * argument and returns void
// explain: (*f) declares f as a pointer to a function
// explain: void * commonly used where function doesn't need to know what kind of data is handling
struct thread *thread_create(void (*f)(void *), void *arg){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  10:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
  12:	14000513          	li	a0,320
  16:	00001097          	auipc	ra,0x1
  1a:	a0c080e7          	jalr	-1524(ra) # a22 <malloc>
  1e:	84aa                	mv	s1,a0
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  20:	6505                	lui	a0,0x1
  22:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0xa8>
  26:	00001097          	auipc	ra,0x1
  2a:	9fc080e7          	jalr	-1540(ra) # a22 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f;
  2e:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  32:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
  36:	00001717          	auipc	a4,0x1
  3a:	b6670713          	addi	a4,a4,-1178 # b9c <id>
  3e:	431c                	lw	a5,0(a4)
  40:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
  44:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;       // points to the beginning of allocated stack memory for the thread.
  48:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
  4a:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;   // points to the current execution part of the thread.
  4e:	ec88                	sd	a0,24(s1)
    id++;                               // increments ID for the next thread
  50:	2785                	addiw	a5,a5,1
  52:	c31c                	sw	a5,0(a4)

    // part 2
    t->suspended = -1;                  // indicating that the thread is not suspended
  54:	57fd                	li	a5,-1
  56:	0af4a423          	sw	a5,168(s1)
    t->sig_handler[0] = NULL_FUNC;   
  5a:	57fd                	li	a5,-1
  5c:	f8dc                	sd	a5,176(s1)
    t->sig_handler[1] = NULL_FUNC;
  5e:	fcdc                	sd	a5,184(s1)
    t->signo = -1;                      // no signal currently active
  60:	0cf4a023          	sw	a5,192(s1)
    t->handler_buf_set = 0;
  64:	1204ac23          	sw	zero,312(s1)
    // printf("Thread %d created\n", t->ID);
    return t;                           // return the pointer to the newly created thread
}
  68:	8526                	mv	a0,s1
  6a:	70a2                	ld	ra,40(sp)
  6c:	7402                	ld	s0,32(sp)
  6e:	64e2                	ld	s1,24(sp)
  70:	6942                	ld	s2,16(sp)
  72:	69a2                	ld	s3,8(sp)
  74:	6145                	addi	sp,sp,48
  76:	8082                	ret

0000000000000078 <thread_add_runqueue>:

void thread_add_runqueue(struct thread *t){
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
    if(current_thread == NULL){                                 // case: adding the first thread to the runqueue
  7e:	00001797          	auipc	a5,0x1
  82:	b227b783          	ld	a5,-1246(a5) # ba0 <current_thread>
  86:	cf91                	beqz	a5,a2 <thread_add_runqueue+0x2a>
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {                                                    // case: adding thread to runqueue with existing threads
        // child thread t should inherit the signal handlers from the parent thread (current_thread)
        t->sig_handler[0] = current_thread->sig_handler[0];
  88:	7bd8                	ld	a4,176(a5)
  8a:	f958                	sd	a4,176(a0)
        t->sig_handler[1] = current_thread->sig_handler[1];
  8c:	7fd8                	ld	a4,184(a5)
  8e:	fd58                	sd	a4,184(a0)
        
        // Insert into circular linked list
        current_thread->previous->next = t;
  90:	6fd8                	ld	a4,152(a5)
  92:	f348                	sd	a0,160(a4)
        t->previous = current_thread->previous;
  94:	6fd8                	ld	a4,152(a5)
  96:	ed58                	sd	a4,152(a0)
        t->next = current_thread;
  98:	f15c                	sd	a5,160(a0)
        current_thread->previous = t;
  9a:	efc8                	sd	a0,152(a5)
    }
}
  9c:	6422                	ld	s0,8(sp)
  9e:	0141                	addi	sp,sp,16
  a0:	8082                	ret
        current_thread = t;
  a2:	00001797          	auipc	a5,0x1
  a6:	aea7bf23          	sd	a0,-1282(a5) # ba0 <current_thread>
        current_thread->next = current_thread;
  aa:	f148                	sd	a0,160(a0)
        current_thread->previous = current_thread;
  ac:	ed48                	sd	a0,152(a0)
  ae:	b7fd                	j	9c <thread_add_runqueue+0x24>

00000000000000b0 <schedule>:
        thread_exit();
    }
}

// note: schedule will follow the rule of FIFO
void schedule(void){
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
    // printf("Get into schedule and current thread is %d\n", current_thread->ID);
    current_thread = current_thread->next;
  b6:	00001717          	auipc	a4,0x1
  ba:	aea70713          	addi	a4,a4,-1302 # ba0 <current_thread>
  be:	631c                	ld	a5,0(a4)
  c0:	73dc                	ld	a5,160(a5)
  c2:	e31c                	sd	a5,0(a4)
    
    // Skip suspended threads, if the thread is suspended, we kept moving to the next thread
    while (current_thread->suspended) {
  c4:	0a87a703          	lw	a4,168(a5)
  c8:	cb09                	beqz	a4,da <schedule+0x2a>
        current_thread = current_thread->next;
  ca:	73dc                	ld	a5,160(a5)
    while (current_thread->suspended) {
  cc:	0a87a703          	lw	a4,168(a5)
  d0:	ff6d                	bnez	a4,ca <schedule+0x1a>
  d2:	00001717          	auipc	a4,0x1
  d6:	acf73723          	sd	a5,-1330(a4) # ba0 <current_thread>
    }
    // printf("scheduled to thread %d\n", current_thread->ID);
}
  da:	6422                	ld	s0,8(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret

00000000000000e0 <thread_exit>:
// aim: 1. remove the calling thread from runqueue
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next to-be-executed thread in runqueue (schedule())
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function
void thread_exit(void){
  e0:	1101                	addi	sp,sp,-32
  e2:	ec06                	sd	ra,24(sp)
  e4:	e822                	sd	s0,16(sp)
  e6:	e426                	sd	s1,8(sp)
  e8:	1000                	addi	s0,sp,32
    if(current_thread->next != current_thread){         // case: has more than one thread in the runqueue
  ea:	00001497          	auipc	s1,0x1
  ee:	ab64b483          	ld	s1,-1354(s1) # ba0 <current_thread>
  f2:	70dc                	ld	a5,160(s1)
  f4:	02f48d63          	beq	s1,a5,12e <thread_exit+0x4e>
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        
        // (1.) 
        current_thread->previous->next = current_thread->next;
  f8:	6cd8                	ld	a4,152(s1)
  fa:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
  fc:	6cd8                	ld	a4,152(s1)
  fe:	efd8                	sd	a4,152(a5)
        
        // (3.)
        schedule();
 100:	00000097          	auipc	ra,0x0
 104:	fb0080e7          	jalr	-80(ra) # b0 <schedule>
        
        // (2.)
        free(t->stack);
 108:	6888                	ld	a0,16(s1)
 10a:	00001097          	auipc	ra,0x1
 10e:	890080e7          	jalr	-1904(ra) # 99a <free>
        free(t);
 112:	8526                	mv	a0,s1
 114:	00001097          	auipc	ra,0x1
 118:	886080e7          	jalr	-1914(ra) # 99a <free>
        
        // (4.)
        dispatch();
 11c:	00000097          	auipc	ra,0x0
 120:	040080e7          	jalr	64(ra) # 15c <dispatch>
        free(current_thread->stack);
        free(current_thread);
        // we return to main function via longjmp since the context of the main function is saved in env_st
        longjmp(env_st,1);    
    }
}
 124:	60e2                	ld	ra,24(sp)
 126:	6442                	ld	s0,16(sp)
 128:	64a2                	ld	s1,8(sp)
 12a:	6105                	addi	sp,sp,32
 12c:	8082                	ret
        free(current_thread->stack);
 12e:	6888                	ld	a0,16(s1)
 130:	00001097          	auipc	ra,0x1
 134:	86a080e7          	jalr	-1942(ra) # 99a <free>
        free(current_thread);
 138:	00001517          	auipc	a0,0x1
 13c:	a6853503          	ld	a0,-1432(a0) # ba0 <current_thread>
 140:	00001097          	auipc	ra,0x1
 144:	85a080e7          	jalr	-1958(ra) # 99a <free>
        longjmp(env_st,1);    
 148:	4585                	li	a1,1
 14a:	00001517          	auipc	a0,0x1
 14e:	a6650513          	addi	a0,a0,-1434 # bb0 <env_st>
 152:	00001097          	auipc	ra,0x1
 156:	9ec080e7          	jalr	-1556(ra) # b3e <longjmp>
}
 15a:	b7e9                	j	124 <thread_exit+0x44>

000000000000015c <dispatch>:
void dispatch(void){
 15c:	1101                	addi	sp,sp,-32
 15e:	ec06                	sd	ra,24(sp)
 160:	e822                	sd	s0,16(sp)
 162:	e426                	sd	s1,8(sp)
 164:	1000                	addi	s0,sp,32
    if(current_thread->signo != -1){    // case: thread has pending signal
 166:	00001517          	auipc	a0,0x1
 16a:	a3a53503          	ld	a0,-1478(a0) # ba0 <current_thread>
 16e:	0c052783          	lw	a5,192(a0)
 172:	577d                	li	a4,-1
 174:	08e78e63          	beq	a5,a4,210 <dispatch+0xb4>
        if(current_thread->sig_handler[current_thread->signo] != NULL_FUNC){
 178:	07d9                	addi	a5,a5,22
 17a:	078e                	slli	a5,a5,0x3
 17c:	97aa                	add	a5,a5,a0
 17e:	6398                	ld	a4,0(a5)
 180:	57fd                	li	a5,-1
 182:	08f70263          	beq	a4,a5,206 <dispatch+0xaa>
            if(current_thread->handler_buf_set == 1){              // case: handler_buf_set == 1 indicating that the context has been saved in handler_env
 186:	13852703          	lw	a4,312(a0)
 18a:	4785                	li	a5,1
 18c:	04f70163          	beq	a4,a5,1ce <dispatch+0x72>
                if(setjmp(current_thread->handler_env) == 1){
 190:	0c850513          	addi	a0,a0,200
 194:	00001097          	auipc	ra,0x1
 198:	972080e7          	jalr	-1678(ra) # b06 <setjmp>
 19c:	4785                	li	a5,1
 19e:	04f51063          	bne	a0,a5,1de <dispatch+0x82>
                    current_thread->sig_handler[current_thread->signo](current_thread->signo);      // execute the corresponding signal handler
 1a2:	00001497          	auipc	s1,0x1
 1a6:	9fe48493          	addi	s1,s1,-1538 # ba0 <current_thread>
 1aa:	609c                	ld	a5,0(s1)
 1ac:	0c07a503          	lw	a0,192(a5)
 1b0:	01650713          	addi	a4,a0,22
 1b4:	070e                	slli	a4,a4,0x3
 1b6:	97ba                	add	a5,a5,a4
 1b8:	639c                	ld	a5,0(a5)
 1ba:	9782                	jalr	a5
                    current_thread->signo = -1;                                                     // reset the signo to -1
 1bc:	609c                	ld	a5,0(s1)
 1be:	577d                	li	a4,-1
 1c0:	0ce7a023          	sw	a4,192(a5)
                    dispatch();                                                                     // reenter dispatch() and goto line 118 (since signal has reset)
 1c4:	00000097          	auipc	ra,0x0
 1c8:	f98080e7          	jalr	-104(ra) # 15c <dispatch>
 1cc:	a89d                	j	242 <dispatch+0xe6>
                longjmp(current_thread->handler_env,1);
 1ce:	4585                	li	a1,1
 1d0:	0c850513          	addi	a0,a0,200
 1d4:	00001097          	auipc	ra,0x1
 1d8:	96a080e7          	jalr	-1686(ra) # b3e <longjmp>
 1dc:	a09d                	j	242 <dispatch+0xe6>
                    current_thread->handler_env->sp = (unsigned long) current_thread->stack_p-50*8;
 1de:	00001517          	auipc	a0,0x1
 1e2:	9c253503          	ld	a0,-1598(a0) # ba0 <current_thread>
 1e6:	6d1c                	ld	a5,24(a0)
 1e8:	e7078793          	addi	a5,a5,-400
 1ec:	12f53823          	sd	a5,304(a0)
                    current_thread->handler_buf_set = 1;
 1f0:	4785                	li	a5,1
 1f2:	12f52c23          	sw	a5,312(a0)
                    longjmp(current_thread->handler_env,1);
 1f6:	4585                	li	a1,1
 1f8:	0c850513          	addi	a0,a0,200
 1fc:	00001097          	auipc	ra,0x1
 200:	942080e7          	jalr	-1726(ra) # b3e <longjmp>
 204:	a83d                	j	242 <dispatch+0xe6>
            thread_exit();
 206:	00000097          	auipc	ra,0x0
 20a:	eda080e7          	jalr	-294(ra) # e0 <thread_exit>
 20e:	a815                	j	242 <dispatch+0xe6>
        if(current_thread->buf_set == 1){           // case: has a saved context in env
 210:	09052703          	lw	a4,144(a0)
 214:	4785                	li	a5,1
 216:	02f70b63          	beq	a4,a5,24c <dispatch+0xf0>
            if(setjmp(current_thread->env) == 1){ 
 21a:	02050513          	addi	a0,a0,32
 21e:	00001097          	auipc	ra,0x1
 222:	8e8080e7          	jalr	-1816(ra) # b06 <setjmp>
 226:	4785                	li	a5,1
 228:	02f51a63          	bne	a0,a5,25c <dispatch+0x100>
                current_thread->fp(current_thread->arg);
 22c:	00001797          	auipc	a5,0x1
 230:	9747b783          	ld	a5,-1676(a5) # ba0 <current_thread>
 234:	6398                	ld	a4,0(a5)
 236:	6788                	ld	a0,8(a5)
 238:	9702                	jalr	a4
        thread_exit();
 23a:	00000097          	auipc	ra,0x0
 23e:	ea6080e7          	jalr	-346(ra) # e0 <thread_exit>
}
 242:	60e2                	ld	ra,24(sp)
 244:	6442                	ld	s0,16(sp)
 246:	64a2                	ld	s1,8(sp)
 248:	6105                	addi	sp,sp,32
 24a:	8082                	ret
            longjmp(current_thread->env,1);
 24c:	4585                	li	a1,1
 24e:	02050513          	addi	a0,a0,32
 252:	00001097          	auipc	ra,0x1
 256:	8ec080e7          	jalr	-1812(ra) # b3e <longjmp>
 25a:	b7c5                	j	23a <dispatch+0xde>
                current_thread->env->sp =(unsigned long) current_thread->stack_p;   // manually set sp of the current thread to stack_p
 25c:	00001517          	auipc	a0,0x1
 260:	94453503          	ld	a0,-1724(a0) # ba0 <current_thread>
 264:	6d1c                	ld	a5,24(a0)
 266:	e55c                	sd	a5,136(a0)
                current_thread->buf_set = 1;                                        // set the buf_set to 1 to indicate that the buf has been set
 268:	4785                	li	a5,1
 26a:	08f52823          	sw	a5,144(a0)
                longjmp(current_thread->env,1);
 26e:	4585                	li	a1,1
 270:	02050513          	addi	a0,a0,32
 274:	00001097          	auipc	ra,0x1
 278:	8ca080e7          	jalr	-1846(ra) # b3e <longjmp>
 27c:	bf7d                	j	23a <dispatch+0xde>

000000000000027e <thread_yield>:
void thread_yield(void){
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
    if(current_thread->signo != -1){                        // case: thread has pending signal
 286:	00001517          	auipc	a0,0x1
 28a:	91a53503          	ld	a0,-1766(a0) # ba0 <current_thread>
 28e:	0c052703          	lw	a4,192(a0)
 292:	57fd                	li	a5,-1
 294:	02f70663          	beq	a4,a5,2c0 <thread_yield+0x42>
        if(setjmp(current_thread->handler_env) == NULL){
 298:	0c850513          	addi	a0,a0,200
 29c:	00001097          	auipc	ra,0x1
 2a0:	86a080e7          	jalr	-1942(ra) # b06 <setjmp>
 2a4:	c509                	beqz	a0,2ae <thread_yield+0x30>
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
            schedule();
 2ae:	00000097          	auipc	ra,0x0
 2b2:	e02080e7          	jalr	-510(ra) # b0 <schedule>
            dispatch();
 2b6:	00000097          	auipc	ra,0x0
 2ba:	ea6080e7          	jalr	-346(ra) # 15c <dispatch>
 2be:	b7e5                	j	2a6 <thread_yield+0x28>
        if(setjmp(current_thread->env) == NULL){
 2c0:	02050513          	addi	a0,a0,32
 2c4:	00001097          	auipc	ra,0x1
 2c8:	842080e7          	jalr	-1982(ra) # b06 <setjmp>
 2cc:	fd69                	bnez	a0,2a6 <thread_yield+0x28>
            schedule();
 2ce:	00000097          	auipc	ra,0x0
 2d2:	de2080e7          	jalr	-542(ra) # b0 <schedule>
            dispatch();
 2d6:	00000097          	auipc	ra,0x0
 2da:	e86080e7          	jalr	-378(ra) # 15c <dispatch>
}
 2de:	b7e1                	j	2a6 <thread_yield+0x28>

00000000000002e0 <thread_start_threading>:
When there's only the last thread in the runqueue, and it called thread_exit(), longjmp(env_st, 1) would be executed, 
we then jump back to check the condition if (setjmp(env_st) == 0) in thread_start_threading(), 
but now the condition is not satisfied, so we would return as specified in the instruction.
*/

void thread_start_threading(void){
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e406                	sd	ra,8(sp)
 2e4:	e022                	sd	s0,0(sp)
 2e6:	0800                	addi	s0,sp,16
    if(setjmp(env_st) == 0){
 2e8:	00001517          	auipc	a0,0x1
 2ec:	8c850513          	addi	a0,a0,-1848 # bb0 <env_st>
 2f0:	00001097          	auipc	ra,0x1
 2f4:	816080e7          	jalr	-2026(ra) # b06 <setjmp>
 2f8:	c509                	beqz	a0,302 <thread_start_threading+0x22>
        schedule();
        dispatch();
    } else {        // case: all threads have exited
        return;
    }
}
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret
        schedule();
 302:	00000097          	auipc	ra,0x0
 306:	dae080e7          	jalr	-594(ra) # b0 <schedule>
        dispatch();
 30a:	00000097          	auipc	ra,0x0
 30e:	e52080e7          	jalr	-430(ra) # 15c <dispatch>
 312:	b7e5                	j	2fa <thread_start_threading+0x1a>

0000000000000314 <thread_register_handler>:
When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", 
then executes the sig_handler function.

If another signal handler has already been registered by the same signal, just replace it
*/
void thread_register_handler(int signo, void (*handler)(int)){
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
    // Register signal handler for current thread
    current_thread->sig_handler[signo] = handler;
 31a:	0559                	addi	a0,a0,22
 31c:	050e                	slli	a0,a0,0x3
 31e:	00001797          	auipc	a5,0x1
 322:	8827b783          	ld	a5,-1918(a5) # ba0 <current_thread>
 326:	953e                	add	a0,a0,a5
 328:	e10c                	sd	a1,0(a0)
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <thread_kill>:
---
Our thread_kill() function would mark thraed t with signo, and then when t is resumed later:
    - if t has corresponding handler for signo: execute handler first
    - else: execute thread_exit()
*/
void thread_kill(struct thread *t, int signo){
 330:	1141                	addi	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	addi	s0,sp,16
    // Set signal for specified thread
    t->signo = signo;
 336:	0cb52023          	sw	a1,192(a0)
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret

0000000000000340 <thread_suspend>:

current_thread is set to the next of the original current_thread (Thread B), 
if Thread B is also suspended, the while loop would then move on checking Thread C
*/

void thread_suspend(struct thread *t) {
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
    // Mark thread as suspended
   t->suspended = 1;
 346:	4785                	li	a5,1
 348:	0af52423          	sw	a5,168(a0)
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <thread_resume>:


void thread_resume(struct thread *t) {
 352:	1141                	addi	sp,sp,-16
 354:	e422                	sd	s0,8(sp)
 356:	0800                	addi	s0,sp,16
    t->suspended = 0;
 358:	0a052423          	sw	zero,168(a0)
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <get_current_thread>:

struct thread* get_current_thread() {
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
    // Return pointer to the current thread
    return current_thread;
 368:	00001517          	auipc	a0,0x1
 36c:	83853503          	ld	a0,-1992(a0) # ba0 <current_thread>
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 37c:	87aa                	mv	a5,a0
 37e:	0585                	addi	a1,a1,1
 380:	0785                	addi	a5,a5,1
 382:	fff5c703          	lbu	a4,-1(a1)
 386:	fee78fa3          	sb	a4,-1(a5)
 38a:	fb75                	bnez	a4,37e <strcpy+0x8>
    ;
  return os;
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret

0000000000000392 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 392:	1141                	addi	sp,sp,-16
 394:	e422                	sd	s0,8(sp)
 396:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 398:	00054783          	lbu	a5,0(a0)
 39c:	cb91                	beqz	a5,3b0 <strcmp+0x1e>
 39e:	0005c703          	lbu	a4,0(a1)
 3a2:	00f71763          	bne	a4,a5,3b0 <strcmp+0x1e>
    p++, q++;
 3a6:	0505                	addi	a0,a0,1
 3a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3aa:	00054783          	lbu	a5,0(a0)
 3ae:	fbe5                	bnez	a5,39e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3b0:	0005c503          	lbu	a0,0(a1)
}
 3b4:	40a7853b          	subw	a0,a5,a0
 3b8:	6422                	ld	s0,8(sp)
 3ba:	0141                	addi	sp,sp,16
 3bc:	8082                	ret

00000000000003be <strlen>:

uint
strlen(const char *s)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3c4:	00054783          	lbu	a5,0(a0)
 3c8:	cf91                	beqz	a5,3e4 <strlen+0x26>
 3ca:	0505                	addi	a0,a0,1
 3cc:	87aa                	mv	a5,a0
 3ce:	4685                	li	a3,1
 3d0:	9e89                	subw	a3,a3,a0
 3d2:	00f6853b          	addw	a0,a3,a5
 3d6:	0785                	addi	a5,a5,1
 3d8:	fff7c703          	lbu	a4,-1(a5)
 3dc:	fb7d                	bnez	a4,3d2 <strlen+0x14>
    ;
  return n;
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  for(n = 0; s[n]; n++)
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <strlen+0x20>

00000000000003e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3ee:	ce09                	beqz	a2,408 <memset+0x20>
 3f0:	87aa                	mv	a5,a0
 3f2:	fff6071b          	addiw	a4,a2,-1
 3f6:	1702                	slli	a4,a4,0x20
 3f8:	9301                	srli	a4,a4,0x20
 3fa:	0705                	addi	a4,a4,1
 3fc:	972a                	add	a4,a4,a0
    cdst[i] = c;
 3fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 402:	0785                	addi	a5,a5,1
 404:	fee79de3          	bne	a5,a4,3fe <memset+0x16>
  }
  return dst;
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret

000000000000040e <strchr>:

char*
strchr(const char *s, char c)
{
 40e:	1141                	addi	sp,sp,-16
 410:	e422                	sd	s0,8(sp)
 412:	0800                	addi	s0,sp,16
  for(; *s; s++)
 414:	00054783          	lbu	a5,0(a0)
 418:	cb99                	beqz	a5,42e <strchr+0x20>
    if(*s == c)
 41a:	00f58763          	beq	a1,a5,428 <strchr+0x1a>
  for(; *s; s++)
 41e:	0505                	addi	a0,a0,1
 420:	00054783          	lbu	a5,0(a0)
 424:	fbfd                	bnez	a5,41a <strchr+0xc>
      return (char*)s;
  return 0;
 426:	4501                	li	a0,0
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  return 0;
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <strchr+0x1a>

0000000000000432 <gets>:

char*
gets(char *buf, int max)
{
 432:	711d                	addi	sp,sp,-96
 434:	ec86                	sd	ra,88(sp)
 436:	e8a2                	sd	s0,80(sp)
 438:	e4a6                	sd	s1,72(sp)
 43a:	e0ca                	sd	s2,64(sp)
 43c:	fc4e                	sd	s3,56(sp)
 43e:	f852                	sd	s4,48(sp)
 440:	f456                	sd	s5,40(sp)
 442:	f05a                	sd	s6,32(sp)
 444:	ec5e                	sd	s7,24(sp)
 446:	1080                	addi	s0,sp,96
 448:	8baa                	mv	s7,a0
 44a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 44c:	892a                	mv	s2,a0
 44e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 450:	4aa9                	li	s5,10
 452:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 454:	89a6                	mv	s3,s1
 456:	2485                	addiw	s1,s1,1
 458:	0344d863          	bge	s1,s4,488 <gets+0x56>
    cc = read(0, &c, 1);
 45c:	4605                	li	a2,1
 45e:	faf40593          	addi	a1,s0,-81
 462:	4501                	li	a0,0
 464:	00000097          	auipc	ra,0x0
 468:	1a0080e7          	jalr	416(ra) # 604 <read>
    if(cc < 1)
 46c:	00a05e63          	blez	a0,488 <gets+0x56>
    buf[i++] = c;
 470:	faf44783          	lbu	a5,-81(s0)
 474:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 478:	01578763          	beq	a5,s5,486 <gets+0x54>
 47c:	0905                	addi	s2,s2,1
 47e:	fd679be3          	bne	a5,s6,454 <gets+0x22>
  for(i=0; i+1 < max; ){
 482:	89a6                	mv	s3,s1
 484:	a011                	j	488 <gets+0x56>
 486:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 488:	99de                	add	s3,s3,s7
 48a:	00098023          	sb	zero,0(s3)
  return buf;
}
 48e:	855e                	mv	a0,s7
 490:	60e6                	ld	ra,88(sp)
 492:	6446                	ld	s0,80(sp)
 494:	64a6                	ld	s1,72(sp)
 496:	6906                	ld	s2,64(sp)
 498:	79e2                	ld	s3,56(sp)
 49a:	7a42                	ld	s4,48(sp)
 49c:	7aa2                	ld	s5,40(sp)
 49e:	7b02                	ld	s6,32(sp)
 4a0:	6be2                	ld	s7,24(sp)
 4a2:	6125                	addi	sp,sp,96
 4a4:	8082                	ret

00000000000004a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 4a6:	1101                	addi	sp,sp,-32
 4a8:	ec06                	sd	ra,24(sp)
 4aa:	e822                	sd	s0,16(sp)
 4ac:	e426                	sd	s1,8(sp)
 4ae:	e04a                	sd	s2,0(sp)
 4b0:	1000                	addi	s0,sp,32
 4b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b4:	4581                	li	a1,0
 4b6:	00000097          	auipc	ra,0x0
 4ba:	176080e7          	jalr	374(ra) # 62c <open>
  if(fd < 0)
 4be:	02054563          	bltz	a0,4e8 <stat+0x42>
 4c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4c4:	85ca                	mv	a1,s2
 4c6:	00000097          	auipc	ra,0x0
 4ca:	17e080e7          	jalr	382(ra) # 644 <fstat>
 4ce:	892a                	mv	s2,a0
  close(fd);
 4d0:	8526                	mv	a0,s1
 4d2:	00000097          	auipc	ra,0x0
 4d6:	142080e7          	jalr	322(ra) # 614 <close>
  return r;
}
 4da:	854a                	mv	a0,s2
 4dc:	60e2                	ld	ra,24(sp)
 4de:	6442                	ld	s0,16(sp)
 4e0:	64a2                	ld	s1,8(sp)
 4e2:	6902                	ld	s2,0(sp)
 4e4:	6105                	addi	sp,sp,32
 4e6:	8082                	ret
    return -1;
 4e8:	597d                	li	s2,-1
 4ea:	bfc5                	j	4da <stat+0x34>

00000000000004ec <atoi>:

int
atoi(const char *s)
{
 4ec:	1141                	addi	sp,sp,-16
 4ee:	e422                	sd	s0,8(sp)
 4f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4f2:	00054603          	lbu	a2,0(a0)
 4f6:	fd06079b          	addiw	a5,a2,-48
 4fa:	0ff7f793          	andi	a5,a5,255
 4fe:	4725                	li	a4,9
 500:	02f76963          	bltu	a4,a5,532 <atoi+0x46>
 504:	86aa                	mv	a3,a0
  n = 0;
 506:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 508:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 50a:	0685                	addi	a3,a3,1
 50c:	0025179b          	slliw	a5,a0,0x2
 510:	9fa9                	addw	a5,a5,a0
 512:	0017979b          	slliw	a5,a5,0x1
 516:	9fb1                	addw	a5,a5,a2
 518:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 51c:	0006c603          	lbu	a2,0(a3)
 520:	fd06071b          	addiw	a4,a2,-48
 524:	0ff77713          	andi	a4,a4,255
 528:	fee5f1e3          	bgeu	a1,a4,50a <atoi+0x1e>
  return n;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
  n = 0;
 532:	4501                	li	a0,0
 534:	bfe5                	j	52c <atoi+0x40>

0000000000000536 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 536:	1141                	addi	sp,sp,-16
 538:	e422                	sd	s0,8(sp)
 53a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 53c:	02b57663          	bgeu	a0,a1,568 <memmove+0x32>
    while(n-- > 0)
 540:	02c05163          	blez	a2,562 <memmove+0x2c>
 544:	fff6079b          	addiw	a5,a2,-1
 548:	1782                	slli	a5,a5,0x20
 54a:	9381                	srli	a5,a5,0x20
 54c:	0785                	addi	a5,a5,1
 54e:	97aa                	add	a5,a5,a0
  dst = vdst;
 550:	872a                	mv	a4,a0
      *dst++ = *src++;
 552:	0585                	addi	a1,a1,1
 554:	0705                	addi	a4,a4,1
 556:	fff5c683          	lbu	a3,-1(a1)
 55a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 55e:	fee79ae3          	bne	a5,a4,552 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 562:	6422                	ld	s0,8(sp)
 564:	0141                	addi	sp,sp,16
 566:	8082                	ret
    dst += n;
 568:	00c50733          	add	a4,a0,a2
    src += n;
 56c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 56e:	fec05ae3          	blez	a2,562 <memmove+0x2c>
 572:	fff6079b          	addiw	a5,a2,-1
 576:	1782                	slli	a5,a5,0x20
 578:	9381                	srli	a5,a5,0x20
 57a:	fff7c793          	not	a5,a5
 57e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 580:	15fd                	addi	a1,a1,-1
 582:	177d                	addi	a4,a4,-1
 584:	0005c683          	lbu	a3,0(a1)
 588:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 58c:	fee79ae3          	bne	a5,a4,580 <memmove+0x4a>
 590:	bfc9                	j	562 <memmove+0x2c>

0000000000000592 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 592:	1141                	addi	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 598:	ca05                	beqz	a2,5c8 <memcmp+0x36>
 59a:	fff6069b          	addiw	a3,a2,-1
 59e:	1682                	slli	a3,a3,0x20
 5a0:	9281                	srli	a3,a3,0x20
 5a2:	0685                	addi	a3,a3,1
 5a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5a6:	00054783          	lbu	a5,0(a0)
 5aa:	0005c703          	lbu	a4,0(a1)
 5ae:	00e79863          	bne	a5,a4,5be <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5b2:	0505                	addi	a0,a0,1
    p2++;
 5b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5b6:	fed518e3          	bne	a0,a3,5a6 <memcmp+0x14>
  }
  return 0;
 5ba:	4501                	li	a0,0
 5bc:	a019                	j	5c2 <memcmp+0x30>
      return *p1 - *p2;
 5be:	40e7853b          	subw	a0,a5,a4
}
 5c2:	6422                	ld	s0,8(sp)
 5c4:	0141                	addi	sp,sp,16
 5c6:	8082                	ret
  return 0;
 5c8:	4501                	li	a0,0
 5ca:	bfe5                	j	5c2 <memcmp+0x30>

00000000000005cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5cc:	1141                	addi	sp,sp,-16
 5ce:	e406                	sd	ra,8(sp)
 5d0:	e022                	sd	s0,0(sp)
 5d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5d4:	00000097          	auipc	ra,0x0
 5d8:	f62080e7          	jalr	-158(ra) # 536 <memmove>
}
 5dc:	60a2                	ld	ra,8(sp)
 5de:	6402                	ld	s0,0(sp)
 5e0:	0141                	addi	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5e4:	4885                	li	a7,1
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ec:	4889                	li	a7,2
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5f4:	488d                	li	a7,3
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5fc:	4891                	li	a7,4
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <read>:
.global read
read:
 li a7, SYS_read
 604:	4895                	li	a7,5
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <write>:
.global write
write:
 li a7, SYS_write
 60c:	48c1                	li	a7,16
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <close>:
.global close
close:
 li a7, SYS_close
 614:	48d5                	li	a7,21
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <kill>:
.global kill
kill:
 li a7, SYS_kill
 61c:	4899                	li	a7,6
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <exec>:
.global exec
exec:
 li a7, SYS_exec
 624:	489d                	li	a7,7
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <open>:
.global open
open:
 li a7, SYS_open
 62c:	48bd                	li	a7,15
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 634:	48c5                	li	a7,17
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 63c:	48c9                	li	a7,18
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 644:	48a1                	li	a7,8
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <link>:
.global link
link:
 li a7, SYS_link
 64c:	48cd                	li	a7,19
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 654:	48d1                	li	a7,20
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 65c:	48a5                	li	a7,9
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <dup>:
.global dup
dup:
 li a7, SYS_dup
 664:	48a9                	li	a7,10
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 66c:	48ad                	li	a7,11
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 674:	48b1                	li	a7,12
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 67c:	48b5                	li	a7,13
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 684:	48b9                	li	a7,14
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 68c:	1101                	addi	sp,sp,-32
 68e:	ec06                	sd	ra,24(sp)
 690:	e822                	sd	s0,16(sp)
 692:	1000                	addi	s0,sp,32
 694:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 698:	4605                	li	a2,1
 69a:	fef40593          	addi	a1,s0,-17
 69e:	00000097          	auipc	ra,0x0
 6a2:	f6e080e7          	jalr	-146(ra) # 60c <write>
}
 6a6:	60e2                	ld	ra,24(sp)
 6a8:	6442                	ld	s0,16(sp)
 6aa:	6105                	addi	sp,sp,32
 6ac:	8082                	ret

00000000000006ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6ae:	7139                	addi	sp,sp,-64
 6b0:	fc06                	sd	ra,56(sp)
 6b2:	f822                	sd	s0,48(sp)
 6b4:	f426                	sd	s1,40(sp)
 6b6:	f04a                	sd	s2,32(sp)
 6b8:	ec4e                	sd	s3,24(sp)
 6ba:	0080                	addi	s0,sp,64
 6bc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6be:	c299                	beqz	a3,6c4 <printint+0x16>
 6c0:	0805c863          	bltz	a1,750 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c4:	2581                	sext.w	a1,a1
  neg = 0;
 6c6:	4881                	li	a7,0
 6c8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6ce:	2601                	sext.w	a2,a2
 6d0:	00000517          	auipc	a0,0x0
 6d4:	4b850513          	addi	a0,a0,1208 # b88 <digits>
 6d8:	883a                	mv	a6,a4
 6da:	2705                	addiw	a4,a4,1
 6dc:	02c5f7bb          	remuw	a5,a1,a2
 6e0:	1782                	slli	a5,a5,0x20
 6e2:	9381                	srli	a5,a5,0x20
 6e4:	97aa                	add	a5,a5,a0
 6e6:	0007c783          	lbu	a5,0(a5)
 6ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ee:	0005879b          	sext.w	a5,a1
 6f2:	02c5d5bb          	divuw	a1,a1,a2
 6f6:	0685                	addi	a3,a3,1
 6f8:	fec7f0e3          	bgeu	a5,a2,6d8 <printint+0x2a>
  if(neg)
 6fc:	00088b63          	beqz	a7,712 <printint+0x64>
    buf[i++] = '-';
 700:	fd040793          	addi	a5,s0,-48
 704:	973e                	add	a4,a4,a5
 706:	02d00793          	li	a5,45
 70a:	fef70823          	sb	a5,-16(a4)
 70e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 712:	02e05863          	blez	a4,742 <printint+0x94>
 716:	fc040793          	addi	a5,s0,-64
 71a:	00e78933          	add	s2,a5,a4
 71e:	fff78993          	addi	s3,a5,-1
 722:	99ba                	add	s3,s3,a4
 724:	377d                	addiw	a4,a4,-1
 726:	1702                	slli	a4,a4,0x20
 728:	9301                	srli	a4,a4,0x20
 72a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 72e:	fff94583          	lbu	a1,-1(s2)
 732:	8526                	mv	a0,s1
 734:	00000097          	auipc	ra,0x0
 738:	f58080e7          	jalr	-168(ra) # 68c <putc>
  while(--i >= 0)
 73c:	197d                	addi	s2,s2,-1
 73e:	ff3918e3          	bne	s2,s3,72e <printint+0x80>
}
 742:	70e2                	ld	ra,56(sp)
 744:	7442                	ld	s0,48(sp)
 746:	74a2                	ld	s1,40(sp)
 748:	7902                	ld	s2,32(sp)
 74a:	69e2                	ld	s3,24(sp)
 74c:	6121                	addi	sp,sp,64
 74e:	8082                	ret
    x = -xx;
 750:	40b005bb          	negw	a1,a1
    neg = 1;
 754:	4885                	li	a7,1
    x = -xx;
 756:	bf8d                	j	6c8 <printint+0x1a>

0000000000000758 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 758:	7119                	addi	sp,sp,-128
 75a:	fc86                	sd	ra,120(sp)
 75c:	f8a2                	sd	s0,112(sp)
 75e:	f4a6                	sd	s1,104(sp)
 760:	f0ca                	sd	s2,96(sp)
 762:	ecce                	sd	s3,88(sp)
 764:	e8d2                	sd	s4,80(sp)
 766:	e4d6                	sd	s5,72(sp)
 768:	e0da                	sd	s6,64(sp)
 76a:	fc5e                	sd	s7,56(sp)
 76c:	f862                	sd	s8,48(sp)
 76e:	f466                	sd	s9,40(sp)
 770:	f06a                	sd	s10,32(sp)
 772:	ec6e                	sd	s11,24(sp)
 774:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 776:	0005c903          	lbu	s2,0(a1)
 77a:	18090f63          	beqz	s2,918 <vprintf+0x1c0>
 77e:	8aaa                	mv	s5,a0
 780:	8b32                	mv	s6,a2
 782:	00158493          	addi	s1,a1,1
  state = 0;
 786:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 788:	02500a13          	li	s4,37
      if(c == 'd'){
 78c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 790:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 794:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 798:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79c:	00000b97          	auipc	s7,0x0
 7a0:	3ecb8b93          	addi	s7,s7,1004 # b88 <digits>
 7a4:	a839                	j	7c2 <vprintf+0x6a>
        putc(fd, c);
 7a6:	85ca                	mv	a1,s2
 7a8:	8556                	mv	a0,s5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	ee2080e7          	jalr	-286(ra) # 68c <putc>
 7b2:	a019                	j	7b8 <vprintf+0x60>
    } else if(state == '%'){
 7b4:	01498f63          	beq	s3,s4,7d2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7b8:	0485                	addi	s1,s1,1
 7ba:	fff4c903          	lbu	s2,-1(s1)
 7be:	14090d63          	beqz	s2,918 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7c2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7c6:	fe0997e3          	bnez	s3,7b4 <vprintf+0x5c>
      if(c == '%'){
 7ca:	fd479ee3          	bne	a5,s4,7a6 <vprintf+0x4e>
        state = '%';
 7ce:	89be                	mv	s3,a5
 7d0:	b7e5                	j	7b8 <vprintf+0x60>
      if(c == 'd'){
 7d2:	05878063          	beq	a5,s8,812 <vprintf+0xba>
      } else if(c == 'l') {
 7d6:	05978c63          	beq	a5,s9,82e <vprintf+0xd6>
      } else if(c == 'x') {
 7da:	07a78863          	beq	a5,s10,84a <vprintf+0xf2>
      } else if(c == 'p') {
 7de:	09b78463          	beq	a5,s11,866 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7e2:	07300713          	li	a4,115
 7e6:	0ce78663          	beq	a5,a4,8b2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ea:	06300713          	li	a4,99
 7ee:	0ee78e63          	beq	a5,a4,8ea <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7f2:	11478863          	beq	a5,s4,902 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f6:	85d2                	mv	a1,s4
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e92080e7          	jalr	-366(ra) # 68c <putc>
        putc(fd, c);
 802:	85ca                	mv	a1,s2
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e86080e7          	jalr	-378(ra) # 68c <putc>
      }
      state = 0;
 80e:	4981                	li	s3,0
 810:	b765                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 812:	008b0913          	addi	s2,s6,8
 816:	4685                	li	a3,1
 818:	4629                	li	a2,10
 81a:	000b2583          	lw	a1,0(s6)
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	e8e080e7          	jalr	-370(ra) # 6ae <printint>
 828:	8b4a                	mv	s6,s2
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b771                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 82e:	008b0913          	addi	s2,s6,8
 832:	4681                	li	a3,0
 834:	4629                	li	a2,10
 836:	000b2583          	lw	a1,0(s6)
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e72080e7          	jalr	-398(ra) # 6ae <printint>
 844:	8b4a                	mv	s6,s2
      state = 0;
 846:	4981                	li	s3,0
 848:	bf85                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 84a:	008b0913          	addi	s2,s6,8
 84e:	4681                	li	a3,0
 850:	4641                	li	a2,16
 852:	000b2583          	lw	a1,0(s6)
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e56080e7          	jalr	-426(ra) # 6ae <printint>
 860:	8b4a                	mv	s6,s2
      state = 0;
 862:	4981                	li	s3,0
 864:	bf91                	j	7b8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 866:	008b0793          	addi	a5,s6,8
 86a:	f8f43423          	sd	a5,-120(s0)
 86e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 872:	03000593          	li	a1,48
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	e14080e7          	jalr	-492(ra) # 68c <putc>
  putc(fd, 'x');
 880:	85ea                	mv	a1,s10
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	e08080e7          	jalr	-504(ra) # 68c <putc>
 88c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 88e:	03c9d793          	srli	a5,s3,0x3c
 892:	97de                	add	a5,a5,s7
 894:	0007c583          	lbu	a1,0(a5)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	df2080e7          	jalr	-526(ra) # 68c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a2:	0992                	slli	s3,s3,0x4
 8a4:	397d                	addiw	s2,s2,-1
 8a6:	fe0914e3          	bnez	s2,88e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8aa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8ae:	4981                	li	s3,0
 8b0:	b721                	j	7b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 8b2:	008b0993          	addi	s3,s6,8
 8b6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8ba:	02090163          	beqz	s2,8dc <vprintf+0x184>
        while(*s != 0){
 8be:	00094583          	lbu	a1,0(s2)
 8c2:	c9a1                	beqz	a1,912 <vprintf+0x1ba>
          putc(fd, *s);
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	dc6080e7          	jalr	-570(ra) # 68c <putc>
          s++;
 8ce:	0905                	addi	s2,s2,1
        while(*s != 0){
 8d0:	00094583          	lbu	a1,0(s2)
 8d4:	f9e5                	bnez	a1,8c4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8d6:	8b4e                	mv	s6,s3
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	bdf9                	j	7b8 <vprintf+0x60>
          s = "(null)";
 8dc:	00000917          	auipc	s2,0x0
 8e0:	2a490913          	addi	s2,s2,676 # b80 <longjmp_1+0x8>
        while(*s != 0){
 8e4:	02800593          	li	a1,40
 8e8:	bff1                	j	8c4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8ea:	008b0913          	addi	s2,s6,8
 8ee:	000b4583          	lbu	a1,0(s6)
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	d98080e7          	jalr	-616(ra) # 68c <putc>
 8fc:	8b4a                	mv	s6,s2
      state = 0;
 8fe:	4981                	li	s3,0
 900:	bd65                	j	7b8 <vprintf+0x60>
        putc(fd, c);
 902:	85d2                	mv	a1,s4
 904:	8556                	mv	a0,s5
 906:	00000097          	auipc	ra,0x0
 90a:	d86080e7          	jalr	-634(ra) # 68c <putc>
      state = 0;
 90e:	4981                	li	s3,0
 910:	b565                	j	7b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 912:	8b4e                	mv	s6,s3
      state = 0;
 914:	4981                	li	s3,0
 916:	b54d                	j	7b8 <vprintf+0x60>
    }
  }
}
 918:	70e6                	ld	ra,120(sp)
 91a:	7446                	ld	s0,112(sp)
 91c:	74a6                	ld	s1,104(sp)
 91e:	7906                	ld	s2,96(sp)
 920:	69e6                	ld	s3,88(sp)
 922:	6a46                	ld	s4,80(sp)
 924:	6aa6                	ld	s5,72(sp)
 926:	6b06                	ld	s6,64(sp)
 928:	7be2                	ld	s7,56(sp)
 92a:	7c42                	ld	s8,48(sp)
 92c:	7ca2                	ld	s9,40(sp)
 92e:	7d02                	ld	s10,32(sp)
 930:	6de2                	ld	s11,24(sp)
 932:	6109                	addi	sp,sp,128
 934:	8082                	ret

0000000000000936 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 936:	715d                	addi	sp,sp,-80
 938:	ec06                	sd	ra,24(sp)
 93a:	e822                	sd	s0,16(sp)
 93c:	1000                	addi	s0,sp,32
 93e:	e010                	sd	a2,0(s0)
 940:	e414                	sd	a3,8(s0)
 942:	e818                	sd	a4,16(s0)
 944:	ec1c                	sd	a5,24(s0)
 946:	03043023          	sd	a6,32(s0)
 94a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 94e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 952:	8622                	mv	a2,s0
 954:	00000097          	auipc	ra,0x0
 958:	e04080e7          	jalr	-508(ra) # 758 <vprintf>
}
 95c:	60e2                	ld	ra,24(sp)
 95e:	6442                	ld	s0,16(sp)
 960:	6161                	addi	sp,sp,80
 962:	8082                	ret

0000000000000964 <printf>:

void
printf(const char *fmt, ...)
{
 964:	711d                	addi	sp,sp,-96
 966:	ec06                	sd	ra,24(sp)
 968:	e822                	sd	s0,16(sp)
 96a:	1000                	addi	s0,sp,32
 96c:	e40c                	sd	a1,8(s0)
 96e:	e810                	sd	a2,16(s0)
 970:	ec14                	sd	a3,24(s0)
 972:	f018                	sd	a4,32(s0)
 974:	f41c                	sd	a5,40(s0)
 976:	03043823          	sd	a6,48(s0)
 97a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 97e:	00840613          	addi	a2,s0,8
 982:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 986:	85aa                	mv	a1,a0
 988:	4505                	li	a0,1
 98a:	00000097          	auipc	ra,0x0
 98e:	dce080e7          	jalr	-562(ra) # 758 <vprintf>
}
 992:	60e2                	ld	ra,24(sp)
 994:	6442                	ld	s0,16(sp)
 996:	6125                	addi	sp,sp,96
 998:	8082                	ret

000000000000099a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 99a:	1141                	addi	sp,sp,-16
 99c:	e422                	sd	s0,8(sp)
 99e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a4:	00000797          	auipc	a5,0x0
 9a8:	2047b783          	ld	a5,516(a5) # ba8 <freep>
 9ac:	a805                	j	9dc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9ae:	4618                	lw	a4,8(a2)
 9b0:	9db9                	addw	a1,a1,a4
 9b2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b6:	6398                	ld	a4,0(a5)
 9b8:	6318                	ld	a4,0(a4)
 9ba:	fee53823          	sd	a4,-16(a0)
 9be:	a091                	j	a02 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9c0:	ff852703          	lw	a4,-8(a0)
 9c4:	9e39                	addw	a2,a2,a4
 9c6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9c8:	ff053703          	ld	a4,-16(a0)
 9cc:	e398                	sd	a4,0(a5)
 9ce:	a099                	j	a14 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d0:	6398                	ld	a4,0(a5)
 9d2:	00e7e463          	bltu	a5,a4,9da <free+0x40>
 9d6:	00e6ea63          	bltu	a3,a4,9ea <free+0x50>
{
 9da:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9dc:	fed7fae3          	bgeu	a5,a3,9d0 <free+0x36>
 9e0:	6398                	ld	a4,0(a5)
 9e2:	00e6e463          	bltu	a3,a4,9ea <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e6:	fee7eae3          	bltu	a5,a4,9da <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9ea:	ff852583          	lw	a1,-8(a0)
 9ee:	6390                	ld	a2,0(a5)
 9f0:	02059713          	slli	a4,a1,0x20
 9f4:	9301                	srli	a4,a4,0x20
 9f6:	0712                	slli	a4,a4,0x4
 9f8:	9736                	add	a4,a4,a3
 9fa:	fae60ae3          	beq	a2,a4,9ae <free+0x14>
    bp->s.ptr = p->s.ptr;
 9fe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a02:	4790                	lw	a2,8(a5)
 a04:	02061713          	slli	a4,a2,0x20
 a08:	9301                	srli	a4,a4,0x20
 a0a:	0712                	slli	a4,a4,0x4
 a0c:	973e                	add	a4,a4,a5
 a0e:	fae689e3          	beq	a3,a4,9c0 <free+0x26>
  } else
    p->s.ptr = bp;
 a12:	e394                	sd	a3,0(a5)
  freep = p;
 a14:	00000717          	auipc	a4,0x0
 a18:	18f73a23          	sd	a5,404(a4) # ba8 <freep>
}
 a1c:	6422                	ld	s0,8(sp)
 a1e:	0141                	addi	sp,sp,16
 a20:	8082                	ret

0000000000000a22 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a22:	7139                	addi	sp,sp,-64
 a24:	fc06                	sd	ra,56(sp)
 a26:	f822                	sd	s0,48(sp)
 a28:	f426                	sd	s1,40(sp)
 a2a:	f04a                	sd	s2,32(sp)
 a2c:	ec4e                	sd	s3,24(sp)
 a2e:	e852                	sd	s4,16(sp)
 a30:	e456                	sd	s5,8(sp)
 a32:	e05a                	sd	s6,0(sp)
 a34:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a36:	02051493          	slli	s1,a0,0x20
 a3a:	9081                	srli	s1,s1,0x20
 a3c:	04bd                	addi	s1,s1,15
 a3e:	8091                	srli	s1,s1,0x4
 a40:	0014899b          	addiw	s3,s1,1
 a44:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a46:	00000517          	auipc	a0,0x0
 a4a:	16253503          	ld	a0,354(a0) # ba8 <freep>
 a4e:	c515                	beqz	a0,a7a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a50:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a52:	4798                	lw	a4,8(a5)
 a54:	02977f63          	bgeu	a4,s1,a92 <malloc+0x70>
 a58:	8a4e                	mv	s4,s3
 a5a:	0009871b          	sext.w	a4,s3
 a5e:	6685                	lui	a3,0x1
 a60:	00d77363          	bgeu	a4,a3,a66 <malloc+0x44>
 a64:	6a05                	lui	s4,0x1
 a66:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a6a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a6e:	00000917          	auipc	s2,0x0
 a72:	13a90913          	addi	s2,s2,314 # ba8 <freep>
  if(p == (char*)-1)
 a76:	5afd                	li	s5,-1
 a78:	a88d                	j	aea <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a7a:	00000797          	auipc	a5,0x0
 a7e:	1a678793          	addi	a5,a5,422 # c20 <base>
 a82:	00000717          	auipc	a4,0x0
 a86:	12f73323          	sd	a5,294(a4) # ba8 <freep>
 a8a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a8c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a90:	b7e1                	j	a58 <malloc+0x36>
      if(p->s.size == nunits)
 a92:	02e48b63          	beq	s1,a4,ac8 <malloc+0xa6>
        p->s.size -= nunits;
 a96:	4137073b          	subw	a4,a4,s3
 a9a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a9c:	1702                	slli	a4,a4,0x20
 a9e:	9301                	srli	a4,a4,0x20
 aa0:	0712                	slli	a4,a4,0x4
 aa2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aa4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aa8:	00000717          	auipc	a4,0x0
 aac:	10a73023          	sd	a0,256(a4) # ba8 <freep>
      return (void*)(p + 1);
 ab0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ab4:	70e2                	ld	ra,56(sp)
 ab6:	7442                	ld	s0,48(sp)
 ab8:	74a2                	ld	s1,40(sp)
 aba:	7902                	ld	s2,32(sp)
 abc:	69e2                	ld	s3,24(sp)
 abe:	6a42                	ld	s4,16(sp)
 ac0:	6aa2                	ld	s5,8(sp)
 ac2:	6b02                	ld	s6,0(sp)
 ac4:	6121                	addi	sp,sp,64
 ac6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ac8:	6398                	ld	a4,0(a5)
 aca:	e118                	sd	a4,0(a0)
 acc:	bff1                	j	aa8 <malloc+0x86>
  hp->s.size = nu;
 ace:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad2:	0541                	addi	a0,a0,16
 ad4:	00000097          	auipc	ra,0x0
 ad8:	ec6080e7          	jalr	-314(ra) # 99a <free>
  return freep;
 adc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ae0:	d971                	beqz	a0,ab4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae4:	4798                	lw	a4,8(a5)
 ae6:	fa9776e3          	bgeu	a4,s1,a92 <malloc+0x70>
    if(p == freep)
 aea:	00093703          	ld	a4,0(s2)
 aee:	853e                	mv	a0,a5
 af0:	fef719e3          	bne	a4,a5,ae2 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 af4:	8552                	mv	a0,s4
 af6:	00000097          	auipc	ra,0x0
 afa:	b7e080e7          	jalr	-1154(ra) # 674 <sbrk>
  if(p == (char*)-1)
 afe:	fd5518e3          	bne	a0,s5,ace <malloc+0xac>
        return 0;
 b02:	4501                	li	a0,0
 b04:	bf45                	j	ab4 <malloc+0x92>

0000000000000b06 <setjmp>:
 b06:	e100                	sd	s0,0(a0)
 b08:	e504                	sd	s1,8(a0)
 b0a:	01253823          	sd	s2,16(a0)
 b0e:	01353c23          	sd	s3,24(a0)
 b12:	03453023          	sd	s4,32(a0)
 b16:	03553423          	sd	s5,40(a0)
 b1a:	03653823          	sd	s6,48(a0)
 b1e:	03753c23          	sd	s7,56(a0)
 b22:	05853023          	sd	s8,64(a0)
 b26:	05953423          	sd	s9,72(a0)
 b2a:	05a53823          	sd	s10,80(a0)
 b2e:	05b53c23          	sd	s11,88(a0)
 b32:	06153023          	sd	ra,96(a0)
 b36:	06253423          	sd	sp,104(a0)
 b3a:	4501                	li	a0,0
 b3c:	8082                	ret

0000000000000b3e <longjmp>:
 b3e:	6100                	ld	s0,0(a0)
 b40:	6504                	ld	s1,8(a0)
 b42:	01053903          	ld	s2,16(a0)
 b46:	01853983          	ld	s3,24(a0)
 b4a:	02053a03          	ld	s4,32(a0)
 b4e:	02853a83          	ld	s5,40(a0)
 b52:	03053b03          	ld	s6,48(a0)
 b56:	03853b83          	ld	s7,56(a0)
 b5a:	04053c03          	ld	s8,64(a0)
 b5e:	04853c83          	ld	s9,72(a0)
 b62:	05053d03          	ld	s10,80(a0)
 b66:	05853d83          	ld	s11,88(a0)
 b6a:	06053083          	ld	ra,96(a0)
 b6e:	06853103          	ld	sp,104(a0)
 b72:	c199                	beqz	a1,b78 <longjmp_1>
 b74:	852e                	mv	a0,a1
 b76:	8082                	ret

0000000000000b78 <longjmp_1>:
 b78:	4505                	li	a0,1
 b7a:	8082                	ret
