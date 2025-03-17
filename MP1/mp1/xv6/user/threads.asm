
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <get_current_thread>:

//the below 2 jmp buffer will be used for main function and thread context switching
static jmp_buf env_st; 
static jmp_buf env_tmp;  

struct thread *get_current_thread() {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    return current_thread;
}
   6:	00001517          	auipc	a0,0x1
   a:	bd253503          	ld	a0,-1070(a0) # bd8 <current_thread>
   e:	6422                	ld	s0,8(sp)
  10:	0141                	addi	sp,sp,16
  12:	8082                	ret

0000000000000014 <thread_create>:
// syntax: return_type (*pointer_name)(parameter_types);
// explain: The thread_create() function takes a funciton pointer void (*f)(void *), 
// explain: meaning that it accepts a function f that takes a void * argument and returns void
// explain: (*f) declares f as a pointer to a function
// explain: void * commonly used where function doesn't need to know what kind of data is handling
struct thread *thread_create(void (*f)(void *), void *arg){
  14:	7179                	addi	sp,sp,-48
  16:	f406                	sd	ra,40(sp)
  18:	f022                	sd	s0,32(sp)
  1a:	ec26                	sd	s1,24(sp)
  1c:	e84a                	sd	s2,16(sp)
  1e:	e44e                	sd	s3,8(sp)
  20:	1800                	addi	s0,sp,48
  22:	89aa                	mv	s3,a0
  24:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
  26:	13800513          	li	a0,312
  2a:	00001097          	auipc	ra,0x1
  2e:	a32080e7          	jalr	-1486(ra) # a5c <malloc>
  32:	84aa                	mv	s1,a0
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  34:	6505                	lui	a0,0x1
  36:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0x6e>
  3a:	00001097          	auipc	ra,0x1
  3e:	a22080e7          	jalr	-1502(ra) # a5c <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f; 
  42:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  46:	0124b423          	sd	s2,8(s1)

    t->ID  = id;
  4a:	00001717          	auipc	a4,0x1
  4e:	b8a70713          	addi	a4,a4,-1142 # bd4 <id>
  52:	431c                	lw	a5,0(a4)
  54:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
  58:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;               // points to the beginning of allocated stack memory for the thread.
  5c:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
  5e:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;           // points to the current execution part of the thread.
  62:	ec88                	sd	a0,24(s1)
    id++;   // increments ID for the next thread
  64:	2785                	addiw	a5,a5,1
  66:	c31c                	sw	a5,0(a4)

    // part 2
    t->suspended = -1;               // indicating that the thread is not suspended
  68:	57fd                	li	a5,-1
  6a:	0af4ae23          	sw	a5,188(s1)
    t->sig_handler[0] = NULL_FUNC;
  6e:	57fd                	li	a5,-1
  70:	f4dc                	sd	a5,168(s1)
    t->sig_handler[1] = NULL_FUNC;
  72:	f8dc                	sd	a5,176(s1)
    t->signo = -1;                  // no signal currently active
  74:	0af4ac23          	sw	a5,184(s1)
    t->handler_buf_set = 0;
  78:	1204a823          	sw	zero,304(s1)
    //printf("Thread %d created\n", t->ID);
    return t;                       // return the pointer to the newly created thread
}
  7c:	8526                	mv	a0,s1
  7e:	70a2                	ld	ra,40(sp)
  80:	7402                	ld	s0,32(sp)
  82:	64e2                	ld	s1,24(sp)
  84:	6942                	ld	s2,16(sp)
  86:	69a2                	ld	s3,8(sp)
  88:	6145                	addi	sp,sp,48
  8a:	8082                	ret

000000000000008c <thread_add_runqueue>:


void thread_add_runqueue(struct thread *t){
  8c:	1141                	addi	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	addi	s0,sp,16
    // printf("Thread %d added to run queue\n", t->ID);
    if(current_thread == NULL){                     // case: if no thread currently in the runqueue
  92:	00001797          	auipc	a5,0x1
  96:	b467b783          	ld	a5,-1210(a5) # bd8 <current_thread>
  9a:	c39d                	beqz	a5,c0 <thread_add_runqueue+0x34>
    } else {                                          // case: exists thread already in runqueue
        //printf("Thread %d already in runqueue, adding thread %d\n", current_thread->ID, t->ID);
        //TO DO
        // aim: 1. Insert t before current_thread in the circular linked list 
        // aim: 2. Update next and previous pointers
        t->next = current_thread;
  9c:	f15c                	sd	a5,160(a0)
        t->previous = current_thread->previous;
  9e:	6fd8                	ld	a4,152(a5)
  a0:	ed58                	sd	a4,152(a0)
        current_thread->previous->next = t;
  a2:	f348                	sd	a0,160(a4)
        current_thread->previous = t;
  a4:	efc8                	sd	a0,152(a5)

        // Let the child thread (t) inherit the 2 signal handlers (0, 1) from its parent (current_thread) if they exist
        for (int i = 0; i < 2; i++) {
            if (current_thread->sig_handler[i] != NULL_FUNC) {
  a6:	77d8                	ld	a4,168(a5)
  a8:	56fd                	li	a3,-1
  aa:	02d70263          	beq	a4,a3,ce <thread_add_runqueue+0x42>
                // printf("Thread %d gets signal handler %d from its parent %d\n", t->ID, i, current_thread->ID);
                t->sig_handler[i] = current_thread->sig_handler[i];
  ae:	f558                	sd	a4,168(a0)
            if (current_thread->sig_handler[i] != NULL_FUNC) {
  b0:	7bdc                	ld	a5,176(a5)
  b2:	577d                	li	a4,-1
  b4:	02e78063          	beq	a5,a4,d4 <thread_add_runqueue+0x48>
                t->sig_handler[i] = current_thread->sig_handler[i];
  b8:	f95c                	sd	a5,176(a0)
            } else {
                t->sig_handler[i] = NULL_FUNC;
            }
        }
    }
}
  ba:	6422                	ld	s0,8(sp)
  bc:	0141                	addi	sp,sp,16
  be:	8082                	ret
        current_thread = t;
  c0:	00001797          	auipc	a5,0x1
  c4:	b0a7bc23          	sd	a0,-1256(a5) # bd8 <current_thread>
        current_thread->next = current_thread;
  c8:	f148                	sd	a0,160(a0)
        current_thread->previous = current_thread;
  ca:	ed48                	sd	a0,152(a0)
  cc:	b7fd                	j	ba <thread_add_runqueue+0x2e>
                t->sig_handler[i] = NULL_FUNC;
  ce:	577d                	li	a4,-1
  d0:	f558                	sd	a4,168(a0)
  d2:	bff9                	j	b0 <thread_add_runqueue+0x24>
  d4:	57fd                	li	a5,-1
  d6:	f95c                	sd	a5,176(a0)
}
  d8:	b7cd                	j	ba <thread_add_runqueue+0x2e>

00000000000000da <dispatch>:
    }
    return;
}

// aim: Switch execution to the thread chosen by schedule()
void dispatch(void) {
  da:	7139                	addi	sp,sp,-64
  dc:	fc06                	sd	ra,56(sp)
  de:	f822                	sd	s0,48(sp)
  e0:	f426                	sd	s1,40(sp)
  e2:	0080                	addi	s0,sp,64
    struct thread *t = current_thread;
  e4:	00001797          	auipc	a5,0x1
  e8:	af47b783          	ld	a5,-1292(a5) # bd8 <current_thread>
  ec:	fcf43c23          	sd	a5,-40(s0)
    // printf("Current thread being dispatched: %d\n", t->ID);
    
    // Ensure the thread context is initialized
    if (t->buf_set == 0) {
  f0:	0907a783          	lw	a5,144(a5)
  f4:	c795                	beqz	a5,120 <dispatch+0x46>
        }
        return;
    }

    // Resume execution after handling a signal (if applicable)
    if (t->handler_buf_set == 1) {
  f6:	fd843783          	ld	a5,-40(s0)
  fa:	1307a703          	lw	a4,304(a5)
  fe:	4785                	li	a5,1
 100:	08f70f63          	beq	a4,a5,19e <dispatch+0xc4>
        t->signo = -1;           // Reset signal
        longjmp(t->env, 1);
    }

    // Resume normal execution
    longjmp(t->env, 1);
 104:	4585                	li	a1,1
 106:	fd843783          	ld	a5,-40(s0)
 10a:	02078513          	addi	a0,a5,32
 10e:	00001097          	auipc	ra,0x1
 112:	a6a080e7          	jalr	-1430(ra) # b78 <longjmp>
}
 116:	70e2                	ld	ra,56(sp)
 118:	7442                	ld	s0,48(sp)
 11a:	74a2                	ld	s1,40(sp)
 11c:	6121                	addi	sp,sp,64
 11e:	8082                	ret
        t->buf_set = 1;
 120:	4785                	li	a5,1
 122:	fd843703          	ld	a4,-40(s0)
 126:	08f72823          	sw	a5,144(a4)
        if (setjmp(t->env) == 0) {
 12a:	02070513          	addi	a0,a4,32
 12e:	00001097          	auipc	ra,0x1
 132:	a12080e7          	jalr	-1518(ra) # b40 <setjmp>
 136:	f165                	bnez	a0,116 <dispatch+0x3c>
            if (t->signo != -1 && t->sig_handler[t->signo] != NULL_FUNC) {
 138:	fd843703          	ld	a4,-40(s0)
 13c:	0b872783          	lw	a5,184(a4)
 140:	86be                	mv	a3,a5
 142:	57fd                	li	a5,-1
 144:	04f68363          	beq	a3,a5,18a <dispatch+0xb0>
 148:	fcd43823          	sd	a3,-48(s0)
 14c:	01468793          	addi	a5,a3,20
 150:	078e                	slli	a5,a5,0x3
 152:	86ba                	mv	a3,a4
 154:	97ba                	add	a5,a5,a4
 156:	679c                	ld	a5,8(a5)
 158:	577d                	li	a4,-1
 15a:	02e78863          	beq	a5,a4,18a <dispatch+0xb0>
                void (*handler)(int) = t->sig_handler[t->signo];
 15e:	fcf43423          	sd	a5,-56(s0)
                if (setjmp(t->handler_env) == 0) {  
 162:	0c068513          	addi	a0,a3,192
 166:	00001097          	auipc	ra,0x1
 16a:	9da080e7          	jalr	-1574(ra) # b40 <setjmp>
 16e:	ed11                	bnez	a0,18a <dispatch+0xb0>
                    t->handler_buf_set = 1;
 170:	4785                	li	a5,1
 172:	fd843483          	ld	s1,-40(s0)
 176:	12f4a823          	sw	a5,304(s1)
                    handler(sig); // Execute the signal handler
 17a:	fd043503          	ld	a0,-48(s0)
 17e:	fc843783          	ld	a5,-56(s0)
 182:	9782                	jalr	a5
                    t->signo = -1;  // Reset signal AFTER execution
 184:	57fd                	li	a5,-1
 186:	0af4ac23          	sw	a5,184(s1)
            t->fp(t->arg);
 18a:	fd843703          	ld	a4,-40(s0)
 18e:	631c                	ld	a5,0(a4)
 190:	6708                	ld	a0,8(a4)
 192:	9782                	jalr	a5
            thread_exit();  // Exit after function execution
 194:	00000097          	auipc	ra,0x0
 198:	028080e7          	jalr	40(ra) # 1bc <thread_exit>
 19c:	bfad                	j	116 <dispatch+0x3c>
        t->handler_buf_set = 0;  // Mark handler as done
 19e:	fd843703          	ld	a4,-40(s0)
 1a2:	12072823          	sw	zero,304(a4)
        t->signo = -1;           // Reset signal
 1a6:	57fd                	li	a5,-1
 1a8:	0af72c23          	sw	a5,184(a4)
        longjmp(t->env, 1);
 1ac:	4585                	li	a1,1
 1ae:	02070513          	addi	a0,a4,32
 1b2:	00001097          	auipc	ra,0x1
 1b6:	9c6080e7          	jalr	-1594(ra) # b78 <longjmp>
 1ba:	b7a9                	j	104 <dispatch+0x2a>

00000000000001bc <thread_exit>:
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next thread in runqueue
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function

void thread_exit(void){
 1bc:	1101                	addi	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e426                	sd	s1,8(sp)
 1c4:	1000                	addi	s0,sp,32
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
 1c6:	00001497          	auipc	s1,0x1
 1ca:	a124b483          	ld	s1,-1518(s1) # bd8 <current_thread>
 1ce:	70dc                	ld	a5,160(s1)
 1d0:	02f48e63          	beq	s1,a5,20c <thread_exit+0x50>
        //TO DO
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        // (1.)
        current_thread->previous->next = current_thread->next;
 1d4:	6cd8                	ld	a4,152(s1)
 1d6:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
 1d8:	6cd8                	ld	a4,152(s1)
 1da:	efd8                	sd	a4,152(a5)
        
        // (3.)
        current_thread = current_thread->next;
 1dc:	70dc                	ld	a5,160(s1)
 1de:	00001717          	auipc	a4,0x1
 1e2:	9ef73d23          	sd	a5,-1542(a4) # bd8 <current_thread>

        // (2.)
        free(t->stack);
 1e6:	6888                	ld	a0,16(s1)
 1e8:	00000097          	auipc	ra,0x0
 1ec:	7ec080e7          	jalr	2028(ra) # 9d4 <free>
        free(t);
 1f0:	8526                	mv	a0,s1
 1f2:	00000097          	auipc	ra,0x0
 1f6:	7e2080e7          	jalr	2018(ra) # 9d4 <free>

        // (4.)
        dispatch();
 1fa:	00000097          	auipc	ra,0x0
 1fe:	ee0080e7          	jalr	-288(ra) # da <dispatch>
    } else {                                         // case: last thread 
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
}
 202:	60e2                	ld	ra,24(sp)
 204:	6442                	ld	s0,16(sp)
 206:	64a2                	ld	s1,8(sp)
 208:	6105                	addi	sp,sp,32
 20a:	8082                	ret
        free(current_thread->stack);
 20c:	6888                	ld	a0,16(s1)
 20e:	00000097          	auipc	ra,0x0
 212:	7c6080e7          	jalr	1990(ra) # 9d4 <free>
        free(current_thread);
 216:	00001517          	auipc	a0,0x1
 21a:	9c253503          	ld	a0,-1598(a0) # bd8 <current_thread>
 21e:	00000097          	auipc	ra,0x0
 222:	7b6080e7          	jalr	1974(ra) # 9d4 <free>
        longjmp(env_st, 1);
 226:	4585                	li	a1,1
 228:	00001517          	auipc	a0,0x1
 22c:	9c050513          	addi	a0,a0,-1600 # be8 <env_st>
 230:	00001097          	auipc	ra,0x1
 234:	948080e7          	jalr	-1720(ra) # b78 <longjmp>
}
 238:	b7e9                	j	202 <thread_exit+0x46>

000000000000023a <schedule>:
void schedule(void){
 23a:	1141                	addi	sp,sp,-16
 23c:	e422                	sd	s0,8(sp)
 23e:	0800                	addi	s0,sp,16
    current_thread = current_thread->next;
 240:	00001717          	auipc	a4,0x1
 244:	99870713          	addi	a4,a4,-1640 # bd8 <current_thread>
 248:	631c                	ld	a5,0(a4)
 24a:	73dc                	ld	a5,160(a5)
 24c:	e31c                	sd	a5,0(a4)
    while(current_thread->suspended == 0) {
 24e:	0bc7a703          	lw	a4,188(a5)
 252:	eb09                	bnez	a4,264 <schedule+0x2a>
        current_thread = current_thread->next;  
 254:	73dc                	ld	a5,160(a5)
    while(current_thread->suspended == 0) {
 256:	0bc7a703          	lw	a4,188(a5)
 25a:	df6d                	beqz	a4,254 <schedule+0x1a>
 25c:	00001717          	auipc	a4,0x1
 260:	96f73e23          	sd	a5,-1668(a4) # bd8 <current_thread>
}
 264:	6422                	ld	s0,8(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret

000000000000026a <thread_yield>:
void thread_yield(void){
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
    if (current_thread->signo != -1) {           
 272:	00001517          	auipc	a0,0x1
 276:	96653503          	ld	a0,-1690(a0) # bd8 <current_thread>
 27a:	0b852703          	lw	a4,184(a0)
 27e:	57fd                	li	a5,-1
 280:	04f70063          	beq	a4,a5,2c0 <thread_yield+0x56>
        if (current_thread->handler_buf_set == 0) { 
 284:	13052783          	lw	a5,304(a0)
 288:	eb81                	bnez	a5,298 <thread_yield+0x2e>
            if (setjmp(current_thread->handler_env) == 0) {
 28a:	0c050513          	addi	a0,a0,192
 28e:	00001097          	auipc	ra,0x1
 292:	8b2080e7          	jalr	-1870(ra) # b40 <setjmp>
 296:	c509                	beqz	a0,2a0 <thread_yield+0x36>
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
                current_thread->handler_buf_set = 1; 
 2a0:	00001797          	auipc	a5,0x1
 2a4:	9387b783          	ld	a5,-1736(a5) # bd8 <current_thread>
 2a8:	4705                	li	a4,1
 2aa:	12e7a823          	sw	a4,304(a5)
                schedule();  // Determine which thread to run next
 2ae:	00000097          	auipc	ra,0x0
 2b2:	f8c080e7          	jalr	-116(ra) # 23a <schedule>
                dispatch();  // Execute the new thread
 2b6:	00000097          	auipc	ra,0x0
 2ba:	e24080e7          	jalr	-476(ra) # da <dispatch>
 2be:	bfe9                	j	298 <thread_yield+0x2e>
    if (current_thread->buf_set == 0) { 
 2c0:	09052783          	lw	a5,144(a0)
 2c4:	fbf1                	bnez	a5,298 <thread_yield+0x2e>
        if (setjmp(current_thread->env) == 0) {   
 2c6:	02050513          	addi	a0,a0,32
 2ca:	00001097          	auipc	ra,0x1
 2ce:	876080e7          	jalr	-1930(ra) # b40 <setjmp>
 2d2:	f179                	bnez	a0,298 <thread_yield+0x2e>
            current_thread->buf_set = 1; 
 2d4:	00001797          	auipc	a5,0x1
 2d8:	9047b783          	ld	a5,-1788(a5) # bd8 <current_thread>
 2dc:	4705                	li	a4,1
 2de:	08e7a823          	sw	a4,144(a5)
            schedule();  
 2e2:	00000097          	auipc	ra,0x0
 2e6:	f58080e7          	jalr	-168(ra) # 23a <schedule>
            dispatch();  
 2ea:	00000097          	auipc	ra,0x0
 2ee:	df0080e7          	jalr	-528(ra) # da <dispatch>
 2f2:	b75d                	j	298 <thread_yield+0x2e>

00000000000002f4 <thread_start_threading>:

void thread_start_threading(void){
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e406                	sd	ra,8(sp)
 2f8:	e022                	sd	s0,0(sp)
 2fa:	0800                	addi	s0,sp,16
    //TO DO
    // Save the main function's context
    if (setjmp(env_st) == 0) {
 2fc:	00001517          	auipc	a0,0x1
 300:	8ec50513          	addi	a0,a0,-1812 # be8 <env_st>
 304:	00001097          	auipc	ra,0x1
 308:	83c080e7          	jalr	-1988(ra) # b40 <setjmp>
 30c:	c509                	beqz	a0,316 <thread_start_threading+0x22>
        schedule();
        dispatch();  
    } else {        // When all the threads exit, setjmp(env_st) != 0
        return;
    }
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
        schedule();
 316:	00000097          	auipc	ra,0x0
 31a:	f24080e7          	jalr	-220(ra) # 23a <schedule>
        dispatch();  
 31e:	00000097          	auipc	ra,0x0
 322:	dbc080e7          	jalr	-580(ra) # da <dispatch>
 326:	b7e5                	j	30e <thread_start_threading+0x1a>

0000000000000328 <thread_register_handler>:

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
 328:	1141                	addi	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	addi	s0,sp,16
    current_thread->sig_handler[signo] = handler;
 32e:	0551                	addi	a0,a0,20
 330:	050e                	slli	a0,a0,0x3
 332:	00001797          	auipc	a5,0x1
 336:	8a67b783          	ld	a5,-1882(a5) # bd8 <current_thread>
 33a:	953e                	add	a0,a0,a5
 33c:	e50c                	sd	a1,8(a0)
    // printf("Thread %d has signal %d handler registered\n", current_thread->ID, signo);
}
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret

0000000000000344 <thread_kill>:

void thread_kill(struct thread *t, int signo){
 344:	1141                	addi	sp,sp,-16
 346:	e422                	sd	s0,8(sp)
 348:	0800                	addi	s0,sp,16
    //TO DO
    // printf("Thread %d is executing thread_kill for signal %d\n", t->ID, signo);
    // Mark the signal for the thread
    t->signo = signo;
 34a:	0ab52c23          	sw	a1,184(a0)

    if (t->sig_handler[signo] == NULL_FUNC) {       // case: no handler for this signo
 34e:	05d1                	addi	a1,a1,20
 350:	058e                	slli	a1,a1,0x3
 352:	95aa                	add	a1,a1,a0
 354:	6598                	ld	a4,8(a1)
 356:	57fd                	li	a5,-1
 358:	00f70563          	beq	a4,a5,362 <thread_kill+0x1e>
        // printf("Thread %d has no handler for signal %d, it will be terminated on resume.\n", t->ID, signo);
        // Instead of calling thread_exit(), mark the function pointer to thread_exit, so that thread terminate when t resumes
        t->fp = (void (*)(void *)) thread_exit;  
    }
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
        t->fp = (void (*)(void *)) thread_exit;  
 362:	00000797          	auipc	a5,0x0
 366:	e5a78793          	addi	a5,a5,-422 # 1bc <thread_exit>
 36a:	e11c                	sd	a5,0(a0)
}
 36c:	bfc5                	j	35c <thread_kill+0x18>

000000000000036e <thread_suspend>:

void thread_suspend(struct thread *t) {
    //TO DO
    // Mark the thread as suspended (0)
    t->suspended = 0;
 36e:	0a052e23          	sw	zero,188(a0)
    // If the current thread suspends itself, need to call thread_yield() as asked in the HW instructions
    if (t == current_thread) {
 372:	00001797          	auipc	a5,0x1
 376:	8667b783          	ld	a5,-1946(a5) # bd8 <current_thread>
 37a:	00a78363          	beq	a5,a0,380 <thread_suspend+0x12>
 37e:	8082                	ret
void thread_suspend(struct thread *t) {
 380:	1141                	addi	sp,sp,-16
 382:	e406                	sd	ra,8(sp)
 384:	e022                	sd	s0,0(sp)
 386:	0800                	addi	s0,sp,16
        thread_yield();
 388:	00000097          	auipc	ra,0x0
 38c:	ee2080e7          	jalr	-286(ra) # 26a <thread_yield>
    }
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret

0000000000000398 <thread_resume>:

void thread_resume(struct thread *t) {
 398:	1141                	addi	sp,sp,-16
 39a:	e422                	sd	s0,8(sp)
 39c:	0800                	addi	s0,sp,16
    //TO DO
    if (t->suspended == 0) {        // if the thread is suspended (suspended == 0)
 39e:	0bc52783          	lw	a5,188(a0)
 3a2:	e781                	bnez	a5,3aa <thread_resume+0x12>
        t->suspended = -1;          // set suspended to -1 to indicate that the thread is resumed
 3a4:	57fd                	li	a5,-1
 3a6:	0af52e23          	sw	a5,188(a0)
    }
}
 3aa:	6422                	ld	s0,8(sp)
 3ac:	0141                	addi	sp,sp,16
 3ae:	8082                	ret

00000000000003b0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 3b0:	1141                	addi	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3b6:	87aa                	mv	a5,a0
 3b8:	0585                	addi	a1,a1,1
 3ba:	0785                	addi	a5,a5,1
 3bc:	fff5c703          	lbu	a4,-1(a1)
 3c0:	fee78fa3          	sb	a4,-1(a5)
 3c4:	fb75                	bnez	a4,3b8 <strcpy+0x8>
    ;
  return os;
}
 3c6:	6422                	ld	s0,8(sp)
 3c8:	0141                	addi	sp,sp,16
 3ca:	8082                	ret

00000000000003cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e422                	sd	s0,8(sp)
 3d0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3d2:	00054783          	lbu	a5,0(a0)
 3d6:	cb91                	beqz	a5,3ea <strcmp+0x1e>
 3d8:	0005c703          	lbu	a4,0(a1)
 3dc:	00f71763          	bne	a4,a5,3ea <strcmp+0x1e>
    p++, q++;
 3e0:	0505                	addi	a0,a0,1
 3e2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	fbe5                	bnez	a5,3d8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3ea:	0005c503          	lbu	a0,0(a1)
}
 3ee:	40a7853b          	subw	a0,a5,a0
 3f2:	6422                	ld	s0,8(sp)
 3f4:	0141                	addi	sp,sp,16
 3f6:	8082                	ret

00000000000003f8 <strlen>:

uint
strlen(const char *s)
{
 3f8:	1141                	addi	sp,sp,-16
 3fa:	e422                	sd	s0,8(sp)
 3fc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3fe:	00054783          	lbu	a5,0(a0)
 402:	cf91                	beqz	a5,41e <strlen+0x26>
 404:	0505                	addi	a0,a0,1
 406:	87aa                	mv	a5,a0
 408:	4685                	li	a3,1
 40a:	9e89                	subw	a3,a3,a0
 40c:	00f6853b          	addw	a0,a3,a5
 410:	0785                	addi	a5,a5,1
 412:	fff7c703          	lbu	a4,-1(a5)
 416:	fb7d                	bnez	a4,40c <strlen+0x14>
    ;
  return n;
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret
  for(n = 0; s[n]; n++)
 41e:	4501                	li	a0,0
 420:	bfe5                	j	418 <strlen+0x20>

0000000000000422 <memset>:

void*
memset(void *dst, int c, uint n)
{
 422:	1141                	addi	sp,sp,-16
 424:	e422                	sd	s0,8(sp)
 426:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 428:	ce09                	beqz	a2,442 <memset+0x20>
 42a:	87aa                	mv	a5,a0
 42c:	fff6071b          	addiw	a4,a2,-1
 430:	1702                	slli	a4,a4,0x20
 432:	9301                	srli	a4,a4,0x20
 434:	0705                	addi	a4,a4,1
 436:	972a                	add	a4,a4,a0
    cdst[i] = c;
 438:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 43c:	0785                	addi	a5,a5,1
 43e:	fee79de3          	bne	a5,a4,438 <memset+0x16>
  }
  return dst;
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	addi	sp,sp,16
 446:	8082                	ret

0000000000000448 <strchr>:

char*
strchr(const char *s, char c)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 44e:	00054783          	lbu	a5,0(a0)
 452:	cb99                	beqz	a5,468 <strchr+0x20>
    if(*s == c)
 454:	00f58763          	beq	a1,a5,462 <strchr+0x1a>
  for(; *s; s++)
 458:	0505                	addi	a0,a0,1
 45a:	00054783          	lbu	a5,0(a0)
 45e:	fbfd                	bnez	a5,454 <strchr+0xc>
      return (char*)s;
  return 0;
 460:	4501                	li	a0,0
}
 462:	6422                	ld	s0,8(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
  return 0;
 468:	4501                	li	a0,0
 46a:	bfe5                	j	462 <strchr+0x1a>

000000000000046c <gets>:

char*
gets(char *buf, int max)
{
 46c:	711d                	addi	sp,sp,-96
 46e:	ec86                	sd	ra,88(sp)
 470:	e8a2                	sd	s0,80(sp)
 472:	e4a6                	sd	s1,72(sp)
 474:	e0ca                	sd	s2,64(sp)
 476:	fc4e                	sd	s3,56(sp)
 478:	f852                	sd	s4,48(sp)
 47a:	f456                	sd	s5,40(sp)
 47c:	f05a                	sd	s6,32(sp)
 47e:	ec5e                	sd	s7,24(sp)
 480:	1080                	addi	s0,sp,96
 482:	8baa                	mv	s7,a0
 484:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 486:	892a                	mv	s2,a0
 488:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 48a:	4aa9                	li	s5,10
 48c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 48e:	89a6                	mv	s3,s1
 490:	2485                	addiw	s1,s1,1
 492:	0344d863          	bge	s1,s4,4c2 <gets+0x56>
    cc = read(0, &c, 1);
 496:	4605                	li	a2,1
 498:	faf40593          	addi	a1,s0,-81
 49c:	4501                	li	a0,0
 49e:	00000097          	auipc	ra,0x0
 4a2:	1a0080e7          	jalr	416(ra) # 63e <read>
    if(cc < 1)
 4a6:	00a05e63          	blez	a0,4c2 <gets+0x56>
    buf[i++] = c;
 4aa:	faf44783          	lbu	a5,-81(s0)
 4ae:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4b2:	01578763          	beq	a5,s5,4c0 <gets+0x54>
 4b6:	0905                	addi	s2,s2,1
 4b8:	fd679be3          	bne	a5,s6,48e <gets+0x22>
  for(i=0; i+1 < max; ){
 4bc:	89a6                	mv	s3,s1
 4be:	a011                	j	4c2 <gets+0x56>
 4c0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4c2:	99de                	add	s3,s3,s7
 4c4:	00098023          	sb	zero,0(s3)
  return buf;
}
 4c8:	855e                	mv	a0,s7
 4ca:	60e6                	ld	ra,88(sp)
 4cc:	6446                	ld	s0,80(sp)
 4ce:	64a6                	ld	s1,72(sp)
 4d0:	6906                	ld	s2,64(sp)
 4d2:	79e2                	ld	s3,56(sp)
 4d4:	7a42                	ld	s4,48(sp)
 4d6:	7aa2                	ld	s5,40(sp)
 4d8:	7b02                	ld	s6,32(sp)
 4da:	6be2                	ld	s7,24(sp)
 4dc:	6125                	addi	sp,sp,96
 4de:	8082                	ret

00000000000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	1101                	addi	sp,sp,-32
 4e2:	ec06                	sd	ra,24(sp)
 4e4:	e822                	sd	s0,16(sp)
 4e6:	e426                	sd	s1,8(sp)
 4e8:	e04a                	sd	s2,0(sp)
 4ea:	1000                	addi	s0,sp,32
 4ec:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ee:	4581                	li	a1,0
 4f0:	00000097          	auipc	ra,0x0
 4f4:	176080e7          	jalr	374(ra) # 666 <open>
  if(fd < 0)
 4f8:	02054563          	bltz	a0,522 <stat+0x42>
 4fc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4fe:	85ca                	mv	a1,s2
 500:	00000097          	auipc	ra,0x0
 504:	17e080e7          	jalr	382(ra) # 67e <fstat>
 508:	892a                	mv	s2,a0
  close(fd);
 50a:	8526                	mv	a0,s1
 50c:	00000097          	auipc	ra,0x0
 510:	142080e7          	jalr	322(ra) # 64e <close>
  return r;
}
 514:	854a                	mv	a0,s2
 516:	60e2                	ld	ra,24(sp)
 518:	6442                	ld	s0,16(sp)
 51a:	64a2                	ld	s1,8(sp)
 51c:	6902                	ld	s2,0(sp)
 51e:	6105                	addi	sp,sp,32
 520:	8082                	ret
    return -1;
 522:	597d                	li	s2,-1
 524:	bfc5                	j	514 <stat+0x34>

0000000000000526 <atoi>:

int
atoi(const char *s)
{
 526:	1141                	addi	sp,sp,-16
 528:	e422                	sd	s0,8(sp)
 52a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 52c:	00054603          	lbu	a2,0(a0)
 530:	fd06079b          	addiw	a5,a2,-48
 534:	0ff7f793          	andi	a5,a5,255
 538:	4725                	li	a4,9
 53a:	02f76963          	bltu	a4,a5,56c <atoi+0x46>
 53e:	86aa                	mv	a3,a0
  n = 0;
 540:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 542:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 544:	0685                	addi	a3,a3,1
 546:	0025179b          	slliw	a5,a0,0x2
 54a:	9fa9                	addw	a5,a5,a0
 54c:	0017979b          	slliw	a5,a5,0x1
 550:	9fb1                	addw	a5,a5,a2
 552:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 556:	0006c603          	lbu	a2,0(a3)
 55a:	fd06071b          	addiw	a4,a2,-48
 55e:	0ff77713          	andi	a4,a4,255
 562:	fee5f1e3          	bgeu	a1,a4,544 <atoi+0x1e>
  return n;
}
 566:	6422                	ld	s0,8(sp)
 568:	0141                	addi	sp,sp,16
 56a:	8082                	ret
  n = 0;
 56c:	4501                	li	a0,0
 56e:	bfe5                	j	566 <atoi+0x40>

0000000000000570 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 570:	1141                	addi	sp,sp,-16
 572:	e422                	sd	s0,8(sp)
 574:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 576:	02b57663          	bgeu	a0,a1,5a2 <memmove+0x32>
    while(n-- > 0)
 57a:	02c05163          	blez	a2,59c <memmove+0x2c>
 57e:	fff6079b          	addiw	a5,a2,-1
 582:	1782                	slli	a5,a5,0x20
 584:	9381                	srli	a5,a5,0x20
 586:	0785                	addi	a5,a5,1
 588:	97aa                	add	a5,a5,a0
  dst = vdst;
 58a:	872a                	mv	a4,a0
      *dst++ = *src++;
 58c:	0585                	addi	a1,a1,1
 58e:	0705                	addi	a4,a4,1
 590:	fff5c683          	lbu	a3,-1(a1)
 594:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 598:	fee79ae3          	bne	a5,a4,58c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 59c:	6422                	ld	s0,8(sp)
 59e:	0141                	addi	sp,sp,16
 5a0:	8082                	ret
    dst += n;
 5a2:	00c50733          	add	a4,a0,a2
    src += n;
 5a6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5a8:	fec05ae3          	blez	a2,59c <memmove+0x2c>
 5ac:	fff6079b          	addiw	a5,a2,-1
 5b0:	1782                	slli	a5,a5,0x20
 5b2:	9381                	srli	a5,a5,0x20
 5b4:	fff7c793          	not	a5,a5
 5b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5ba:	15fd                	addi	a1,a1,-1
 5bc:	177d                	addi	a4,a4,-1
 5be:	0005c683          	lbu	a3,0(a1)
 5c2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5c6:	fee79ae3          	bne	a5,a4,5ba <memmove+0x4a>
 5ca:	bfc9                	j	59c <memmove+0x2c>

00000000000005cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5cc:	1141                	addi	sp,sp,-16
 5ce:	e422                	sd	s0,8(sp)
 5d0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5d2:	ca05                	beqz	a2,602 <memcmp+0x36>
 5d4:	fff6069b          	addiw	a3,a2,-1
 5d8:	1682                	slli	a3,a3,0x20
 5da:	9281                	srli	a3,a3,0x20
 5dc:	0685                	addi	a3,a3,1
 5de:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5e0:	00054783          	lbu	a5,0(a0)
 5e4:	0005c703          	lbu	a4,0(a1)
 5e8:	00e79863          	bne	a5,a4,5f8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5ec:	0505                	addi	a0,a0,1
    p2++;
 5ee:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5f0:	fed518e3          	bne	a0,a3,5e0 <memcmp+0x14>
  }
  return 0;
 5f4:	4501                	li	a0,0
 5f6:	a019                	j	5fc <memcmp+0x30>
      return *p1 - *p2;
 5f8:	40e7853b          	subw	a0,a5,a4
}
 5fc:	6422                	ld	s0,8(sp)
 5fe:	0141                	addi	sp,sp,16
 600:	8082                	ret
  return 0;
 602:	4501                	li	a0,0
 604:	bfe5                	j	5fc <memcmp+0x30>

0000000000000606 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 606:	1141                	addi	sp,sp,-16
 608:	e406                	sd	ra,8(sp)
 60a:	e022                	sd	s0,0(sp)
 60c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 60e:	00000097          	auipc	ra,0x0
 612:	f62080e7          	jalr	-158(ra) # 570 <memmove>
}
 616:	60a2                	ld	ra,8(sp)
 618:	6402                	ld	s0,0(sp)
 61a:	0141                	addi	sp,sp,16
 61c:	8082                	ret

000000000000061e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 61e:	4885                	li	a7,1
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <exit>:
.global exit
exit:
 li a7, SYS_exit
 626:	4889                	li	a7,2
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <wait>:
.global wait
wait:
 li a7, SYS_wait
 62e:	488d                	li	a7,3
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 636:	4891                	li	a7,4
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <read>:
.global read
read:
 li a7, SYS_read
 63e:	4895                	li	a7,5
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <write>:
.global write
write:
 li a7, SYS_write
 646:	48c1                	li	a7,16
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <close>:
.global close
close:
 li a7, SYS_close
 64e:	48d5                	li	a7,21
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <kill>:
.global kill
kill:
 li a7, SYS_kill
 656:	4899                	li	a7,6
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <exec>:
.global exec
exec:
 li a7, SYS_exec
 65e:	489d                	li	a7,7
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <open>:
.global open
open:
 li a7, SYS_open
 666:	48bd                	li	a7,15
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 66e:	48c5                	li	a7,17
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 676:	48c9                	li	a7,18
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 67e:	48a1                	li	a7,8
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <link>:
.global link
link:
 li a7, SYS_link
 686:	48cd                	li	a7,19
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 68e:	48d1                	li	a7,20
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 696:	48a5                	li	a7,9
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <dup>:
.global dup
dup:
 li a7, SYS_dup
 69e:	48a9                	li	a7,10
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6a6:	48ad                	li	a7,11
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6ae:	48b1                	li	a7,12
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6b6:	48b5                	li	a7,13
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6be:	48b9                	li	a7,14
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6c6:	1101                	addi	sp,sp,-32
 6c8:	ec06                	sd	ra,24(sp)
 6ca:	e822                	sd	s0,16(sp)
 6cc:	1000                	addi	s0,sp,32
 6ce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6d2:	4605                	li	a2,1
 6d4:	fef40593          	addi	a1,s0,-17
 6d8:	00000097          	auipc	ra,0x0
 6dc:	f6e080e7          	jalr	-146(ra) # 646 <write>
}
 6e0:	60e2                	ld	ra,24(sp)
 6e2:	6442                	ld	s0,16(sp)
 6e4:	6105                	addi	sp,sp,32
 6e6:	8082                	ret

00000000000006e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6e8:	7139                	addi	sp,sp,-64
 6ea:	fc06                	sd	ra,56(sp)
 6ec:	f822                	sd	s0,48(sp)
 6ee:	f426                	sd	s1,40(sp)
 6f0:	f04a                	sd	s2,32(sp)
 6f2:	ec4e                	sd	s3,24(sp)
 6f4:	0080                	addi	s0,sp,64
 6f6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6f8:	c299                	beqz	a3,6fe <printint+0x16>
 6fa:	0805c863          	bltz	a1,78a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6fe:	2581                	sext.w	a1,a1
  neg = 0;
 700:	4881                	li	a7,0
 702:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 706:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 708:	2601                	sext.w	a2,a2
 70a:	00000517          	auipc	a0,0x0
 70e:	4b650513          	addi	a0,a0,1206 # bc0 <digits>
 712:	883a                	mv	a6,a4
 714:	2705                	addiw	a4,a4,1
 716:	02c5f7bb          	remuw	a5,a1,a2
 71a:	1782                	slli	a5,a5,0x20
 71c:	9381                	srli	a5,a5,0x20
 71e:	97aa                	add	a5,a5,a0
 720:	0007c783          	lbu	a5,0(a5)
 724:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 728:	0005879b          	sext.w	a5,a1
 72c:	02c5d5bb          	divuw	a1,a1,a2
 730:	0685                	addi	a3,a3,1
 732:	fec7f0e3          	bgeu	a5,a2,712 <printint+0x2a>
  if(neg)
 736:	00088b63          	beqz	a7,74c <printint+0x64>
    buf[i++] = '-';
 73a:	fd040793          	addi	a5,s0,-48
 73e:	973e                	add	a4,a4,a5
 740:	02d00793          	li	a5,45
 744:	fef70823          	sb	a5,-16(a4)
 748:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 74c:	02e05863          	blez	a4,77c <printint+0x94>
 750:	fc040793          	addi	a5,s0,-64
 754:	00e78933          	add	s2,a5,a4
 758:	fff78993          	addi	s3,a5,-1
 75c:	99ba                	add	s3,s3,a4
 75e:	377d                	addiw	a4,a4,-1
 760:	1702                	slli	a4,a4,0x20
 762:	9301                	srli	a4,a4,0x20
 764:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 768:	fff94583          	lbu	a1,-1(s2)
 76c:	8526                	mv	a0,s1
 76e:	00000097          	auipc	ra,0x0
 772:	f58080e7          	jalr	-168(ra) # 6c6 <putc>
  while(--i >= 0)
 776:	197d                	addi	s2,s2,-1
 778:	ff3918e3          	bne	s2,s3,768 <printint+0x80>
}
 77c:	70e2                	ld	ra,56(sp)
 77e:	7442                	ld	s0,48(sp)
 780:	74a2                	ld	s1,40(sp)
 782:	7902                	ld	s2,32(sp)
 784:	69e2                	ld	s3,24(sp)
 786:	6121                	addi	sp,sp,64
 788:	8082                	ret
    x = -xx;
 78a:	40b005bb          	negw	a1,a1
    neg = 1;
 78e:	4885                	li	a7,1
    x = -xx;
 790:	bf8d                	j	702 <printint+0x1a>

0000000000000792 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 792:	7119                	addi	sp,sp,-128
 794:	fc86                	sd	ra,120(sp)
 796:	f8a2                	sd	s0,112(sp)
 798:	f4a6                	sd	s1,104(sp)
 79a:	f0ca                	sd	s2,96(sp)
 79c:	ecce                	sd	s3,88(sp)
 79e:	e8d2                	sd	s4,80(sp)
 7a0:	e4d6                	sd	s5,72(sp)
 7a2:	e0da                	sd	s6,64(sp)
 7a4:	fc5e                	sd	s7,56(sp)
 7a6:	f862                	sd	s8,48(sp)
 7a8:	f466                	sd	s9,40(sp)
 7aa:	f06a                	sd	s10,32(sp)
 7ac:	ec6e                	sd	s11,24(sp)
 7ae:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7b0:	0005c903          	lbu	s2,0(a1)
 7b4:	18090f63          	beqz	s2,952 <vprintf+0x1c0>
 7b8:	8aaa                	mv	s5,a0
 7ba:	8b32                	mv	s6,a2
 7bc:	00158493          	addi	s1,a1,1
  state = 0;
 7c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7c2:	02500a13          	li	s4,37
      if(c == 'd'){
 7c6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 7ca:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7ce:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7d2:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d6:	00000b97          	auipc	s7,0x0
 7da:	3eab8b93          	addi	s7,s7,1002 # bc0 <digits>
 7de:	a839                	j	7fc <vprintf+0x6a>
        putc(fd, c);
 7e0:	85ca                	mv	a1,s2
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	ee2080e7          	jalr	-286(ra) # 6c6 <putc>
 7ec:	a019                	j	7f2 <vprintf+0x60>
    } else if(state == '%'){
 7ee:	01498f63          	beq	s3,s4,80c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7f2:	0485                	addi	s1,s1,1
 7f4:	fff4c903          	lbu	s2,-1(s1)
 7f8:	14090d63          	beqz	s2,952 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7fc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 800:	fe0997e3          	bnez	s3,7ee <vprintf+0x5c>
      if(c == '%'){
 804:	fd479ee3          	bne	a5,s4,7e0 <vprintf+0x4e>
        state = '%';
 808:	89be                	mv	s3,a5
 80a:	b7e5                	j	7f2 <vprintf+0x60>
      if(c == 'd'){
 80c:	05878063          	beq	a5,s8,84c <vprintf+0xba>
      } else if(c == 'l') {
 810:	05978c63          	beq	a5,s9,868 <vprintf+0xd6>
      } else if(c == 'x') {
 814:	07a78863          	beq	a5,s10,884 <vprintf+0xf2>
      } else if(c == 'p') {
 818:	09b78463          	beq	a5,s11,8a0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 81c:	07300713          	li	a4,115
 820:	0ce78663          	beq	a5,a4,8ec <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 824:	06300713          	li	a4,99
 828:	0ee78e63          	beq	a5,a4,924 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 82c:	11478863          	beq	a5,s4,93c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 830:	85d2                	mv	a1,s4
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	e92080e7          	jalr	-366(ra) # 6c6 <putc>
        putc(fd, c);
 83c:	85ca                	mv	a1,s2
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	e86080e7          	jalr	-378(ra) # 6c6 <putc>
      }
      state = 0;
 848:	4981                	li	s3,0
 84a:	b765                	j	7f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 84c:	008b0913          	addi	s2,s6,8
 850:	4685                	li	a3,1
 852:	4629                	li	a2,10
 854:	000b2583          	lw	a1,0(s6)
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	e8e080e7          	jalr	-370(ra) # 6e8 <printint>
 862:	8b4a                	mv	s6,s2
      state = 0;
 864:	4981                	li	s3,0
 866:	b771                	j	7f2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 868:	008b0913          	addi	s2,s6,8
 86c:	4681                	li	a3,0
 86e:	4629                	li	a2,10
 870:	000b2583          	lw	a1,0(s6)
 874:	8556                	mv	a0,s5
 876:	00000097          	auipc	ra,0x0
 87a:	e72080e7          	jalr	-398(ra) # 6e8 <printint>
 87e:	8b4a                	mv	s6,s2
      state = 0;
 880:	4981                	li	s3,0
 882:	bf85                	j	7f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 884:	008b0913          	addi	s2,s6,8
 888:	4681                	li	a3,0
 88a:	4641                	li	a2,16
 88c:	000b2583          	lw	a1,0(s6)
 890:	8556                	mv	a0,s5
 892:	00000097          	auipc	ra,0x0
 896:	e56080e7          	jalr	-426(ra) # 6e8 <printint>
 89a:	8b4a                	mv	s6,s2
      state = 0;
 89c:	4981                	li	s3,0
 89e:	bf91                	j	7f2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8a0:	008b0793          	addi	a5,s6,8
 8a4:	f8f43423          	sd	a5,-120(s0)
 8a8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8ac:	03000593          	li	a1,48
 8b0:	8556                	mv	a0,s5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	e14080e7          	jalr	-492(ra) # 6c6 <putc>
  putc(fd, 'x');
 8ba:	85ea                	mv	a1,s10
 8bc:	8556                	mv	a0,s5
 8be:	00000097          	auipc	ra,0x0
 8c2:	e08080e7          	jalr	-504(ra) # 6c6 <putc>
 8c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8c8:	03c9d793          	srli	a5,s3,0x3c
 8cc:	97de                	add	a5,a5,s7
 8ce:	0007c583          	lbu	a1,0(a5)
 8d2:	8556                	mv	a0,s5
 8d4:	00000097          	auipc	ra,0x0
 8d8:	df2080e7          	jalr	-526(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8dc:	0992                	slli	s3,s3,0x4
 8de:	397d                	addiw	s2,s2,-1
 8e0:	fe0914e3          	bnez	s2,8c8 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8e4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b721                	j	7f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ec:	008b0993          	addi	s3,s6,8
 8f0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8f4:	02090163          	beqz	s2,916 <vprintf+0x184>
        while(*s != 0){
 8f8:	00094583          	lbu	a1,0(s2)
 8fc:	c9a1                	beqz	a1,94c <vprintf+0x1ba>
          putc(fd, *s);
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	dc6080e7          	jalr	-570(ra) # 6c6 <putc>
          s++;
 908:	0905                	addi	s2,s2,1
        while(*s != 0){
 90a:	00094583          	lbu	a1,0(s2)
 90e:	f9e5                	bnez	a1,8fe <vprintf+0x16c>
        s = va_arg(ap, char*);
 910:	8b4e                	mv	s6,s3
      state = 0;
 912:	4981                	li	s3,0
 914:	bdf9                	j	7f2 <vprintf+0x60>
          s = "(null)";
 916:	00000917          	auipc	s2,0x0
 91a:	2a290913          	addi	s2,s2,674 # bb8 <longjmp_1+0x6>
        while(*s != 0){
 91e:	02800593          	li	a1,40
 922:	bff1                	j	8fe <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 924:	008b0913          	addi	s2,s6,8
 928:	000b4583          	lbu	a1,0(s6)
 92c:	8556                	mv	a0,s5
 92e:	00000097          	auipc	ra,0x0
 932:	d98080e7          	jalr	-616(ra) # 6c6 <putc>
 936:	8b4a                	mv	s6,s2
      state = 0;
 938:	4981                	li	s3,0
 93a:	bd65                	j	7f2 <vprintf+0x60>
        putc(fd, c);
 93c:	85d2                	mv	a1,s4
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	d86080e7          	jalr	-634(ra) # 6c6 <putc>
      state = 0;
 948:	4981                	li	s3,0
 94a:	b565                	j	7f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 94c:	8b4e                	mv	s6,s3
      state = 0;
 94e:	4981                	li	s3,0
 950:	b54d                	j	7f2 <vprintf+0x60>
    }
  }
}
 952:	70e6                	ld	ra,120(sp)
 954:	7446                	ld	s0,112(sp)
 956:	74a6                	ld	s1,104(sp)
 958:	7906                	ld	s2,96(sp)
 95a:	69e6                	ld	s3,88(sp)
 95c:	6a46                	ld	s4,80(sp)
 95e:	6aa6                	ld	s5,72(sp)
 960:	6b06                	ld	s6,64(sp)
 962:	7be2                	ld	s7,56(sp)
 964:	7c42                	ld	s8,48(sp)
 966:	7ca2                	ld	s9,40(sp)
 968:	7d02                	ld	s10,32(sp)
 96a:	6de2                	ld	s11,24(sp)
 96c:	6109                	addi	sp,sp,128
 96e:	8082                	ret

0000000000000970 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 970:	715d                	addi	sp,sp,-80
 972:	ec06                	sd	ra,24(sp)
 974:	e822                	sd	s0,16(sp)
 976:	1000                	addi	s0,sp,32
 978:	e010                	sd	a2,0(s0)
 97a:	e414                	sd	a3,8(s0)
 97c:	e818                	sd	a4,16(s0)
 97e:	ec1c                	sd	a5,24(s0)
 980:	03043023          	sd	a6,32(s0)
 984:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 988:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 98c:	8622                	mv	a2,s0
 98e:	00000097          	auipc	ra,0x0
 992:	e04080e7          	jalr	-508(ra) # 792 <vprintf>
}
 996:	60e2                	ld	ra,24(sp)
 998:	6442                	ld	s0,16(sp)
 99a:	6161                	addi	sp,sp,80
 99c:	8082                	ret

000000000000099e <printf>:

void
printf(const char *fmt, ...)
{
 99e:	711d                	addi	sp,sp,-96
 9a0:	ec06                	sd	ra,24(sp)
 9a2:	e822                	sd	s0,16(sp)
 9a4:	1000                	addi	s0,sp,32
 9a6:	e40c                	sd	a1,8(s0)
 9a8:	e810                	sd	a2,16(s0)
 9aa:	ec14                	sd	a3,24(s0)
 9ac:	f018                	sd	a4,32(s0)
 9ae:	f41c                	sd	a5,40(s0)
 9b0:	03043823          	sd	a6,48(s0)
 9b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9b8:	00840613          	addi	a2,s0,8
 9bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9c0:	85aa                	mv	a1,a0
 9c2:	4505                	li	a0,1
 9c4:	00000097          	auipc	ra,0x0
 9c8:	dce080e7          	jalr	-562(ra) # 792 <vprintf>
}
 9cc:	60e2                	ld	ra,24(sp)
 9ce:	6442                	ld	s0,16(sp)
 9d0:	6125                	addi	sp,sp,96
 9d2:	8082                	ret

00000000000009d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d4:	1141                	addi	sp,sp,-16
 9d6:	e422                	sd	s0,8(sp)
 9d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9de:	00000797          	auipc	a5,0x0
 9e2:	2027b783          	ld	a5,514(a5) # be0 <freep>
 9e6:	a805                	j	a16 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e8:	4618                	lw	a4,8(a2)
 9ea:	9db9                	addw	a1,a1,a4
 9ec:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f0:	6398                	ld	a4,0(a5)
 9f2:	6318                	ld	a4,0(a4)
 9f4:	fee53823          	sd	a4,-16(a0)
 9f8:	a091                	j	a3c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9fa:	ff852703          	lw	a4,-8(a0)
 9fe:	9e39                	addw	a2,a2,a4
 a00:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a02:	ff053703          	ld	a4,-16(a0)
 a06:	e398                	sd	a4,0(a5)
 a08:	a099                	j	a4e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0a:	6398                	ld	a4,0(a5)
 a0c:	00e7e463          	bltu	a5,a4,a14 <free+0x40>
 a10:	00e6ea63          	bltu	a3,a4,a24 <free+0x50>
{
 a14:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a16:	fed7fae3          	bgeu	a5,a3,a0a <free+0x36>
 a1a:	6398                	ld	a4,0(a5)
 a1c:	00e6e463          	bltu	a3,a4,a24 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a20:	fee7eae3          	bltu	a5,a4,a14 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a24:	ff852583          	lw	a1,-8(a0)
 a28:	6390                	ld	a2,0(a5)
 a2a:	02059713          	slli	a4,a1,0x20
 a2e:	9301                	srli	a4,a4,0x20
 a30:	0712                	slli	a4,a4,0x4
 a32:	9736                	add	a4,a4,a3
 a34:	fae60ae3          	beq	a2,a4,9e8 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a38:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a3c:	4790                	lw	a2,8(a5)
 a3e:	02061713          	slli	a4,a2,0x20
 a42:	9301                	srli	a4,a4,0x20
 a44:	0712                	slli	a4,a4,0x4
 a46:	973e                	add	a4,a4,a5
 a48:	fae689e3          	beq	a3,a4,9fa <free+0x26>
  } else
    p->s.ptr = bp;
 a4c:	e394                	sd	a3,0(a5)
  freep = p;
 a4e:	00000717          	auipc	a4,0x0
 a52:	18f73923          	sd	a5,402(a4) # be0 <freep>
}
 a56:	6422                	ld	s0,8(sp)
 a58:	0141                	addi	sp,sp,16
 a5a:	8082                	ret

0000000000000a5c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a5c:	7139                	addi	sp,sp,-64
 a5e:	fc06                	sd	ra,56(sp)
 a60:	f822                	sd	s0,48(sp)
 a62:	f426                	sd	s1,40(sp)
 a64:	f04a                	sd	s2,32(sp)
 a66:	ec4e                	sd	s3,24(sp)
 a68:	e852                	sd	s4,16(sp)
 a6a:	e456                	sd	s5,8(sp)
 a6c:	e05a                	sd	s6,0(sp)
 a6e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a70:	02051493          	slli	s1,a0,0x20
 a74:	9081                	srli	s1,s1,0x20
 a76:	04bd                	addi	s1,s1,15
 a78:	8091                	srli	s1,s1,0x4
 a7a:	0014899b          	addiw	s3,s1,1
 a7e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a80:	00000517          	auipc	a0,0x0
 a84:	16053503          	ld	a0,352(a0) # be0 <freep>
 a88:	c515                	beqz	a0,ab4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a8c:	4798                	lw	a4,8(a5)
 a8e:	02977f63          	bgeu	a4,s1,acc <malloc+0x70>
 a92:	8a4e                	mv	s4,s3
 a94:	0009871b          	sext.w	a4,s3
 a98:	6685                	lui	a3,0x1
 a9a:	00d77363          	bgeu	a4,a3,aa0 <malloc+0x44>
 a9e:	6a05                	lui	s4,0x1
 aa0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aa4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aa8:	00000917          	auipc	s2,0x0
 aac:	13890913          	addi	s2,s2,312 # be0 <freep>
  if(p == (char*)-1)
 ab0:	5afd                	li	s5,-1
 ab2:	a88d                	j	b24 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 ab4:	00000797          	auipc	a5,0x0
 ab8:	1a478793          	addi	a5,a5,420 # c58 <base>
 abc:	00000717          	auipc	a4,0x0
 ac0:	12f73223          	sd	a5,292(a4) # be0 <freep>
 ac4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ac6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 aca:	b7e1                	j	a92 <malloc+0x36>
      if(p->s.size == nunits)
 acc:	02e48b63          	beq	s1,a4,b02 <malloc+0xa6>
        p->s.size -= nunits;
 ad0:	4137073b          	subw	a4,a4,s3
 ad4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ad6:	1702                	slli	a4,a4,0x20
 ad8:	9301                	srli	a4,a4,0x20
 ada:	0712                	slli	a4,a4,0x4
 adc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ade:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ae2:	00000717          	auipc	a4,0x0
 ae6:	0ea73f23          	sd	a0,254(a4) # be0 <freep>
      return (void*)(p + 1);
 aea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aee:	70e2                	ld	ra,56(sp)
 af0:	7442                	ld	s0,48(sp)
 af2:	74a2                	ld	s1,40(sp)
 af4:	7902                	ld	s2,32(sp)
 af6:	69e2                	ld	s3,24(sp)
 af8:	6a42                	ld	s4,16(sp)
 afa:	6aa2                	ld	s5,8(sp)
 afc:	6b02                	ld	s6,0(sp)
 afe:	6121                	addi	sp,sp,64
 b00:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b02:	6398                	ld	a4,0(a5)
 b04:	e118                	sd	a4,0(a0)
 b06:	bff1                	j	ae2 <malloc+0x86>
  hp->s.size = nu;
 b08:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b0c:	0541                	addi	a0,a0,16
 b0e:	00000097          	auipc	ra,0x0
 b12:	ec6080e7          	jalr	-314(ra) # 9d4 <free>
  return freep;
 b16:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b1a:	d971                	beqz	a0,aee <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b1e:	4798                	lw	a4,8(a5)
 b20:	fa9776e3          	bgeu	a4,s1,acc <malloc+0x70>
    if(p == freep)
 b24:	00093703          	ld	a4,0(s2)
 b28:	853e                	mv	a0,a5
 b2a:	fef719e3          	bne	a4,a5,b1c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 b2e:	8552                	mv	a0,s4
 b30:	00000097          	auipc	ra,0x0
 b34:	b7e080e7          	jalr	-1154(ra) # 6ae <sbrk>
  if(p == (char*)-1)
 b38:	fd5518e3          	bne	a0,s5,b08 <malloc+0xac>
        return 0;
 b3c:	4501                	li	a0,0
 b3e:	bf45                	j	aee <malloc+0x92>

0000000000000b40 <setjmp>:
 b40:	e100                	sd	s0,0(a0)
 b42:	e504                	sd	s1,8(a0)
 b44:	01253823          	sd	s2,16(a0)
 b48:	01353c23          	sd	s3,24(a0)
 b4c:	03453023          	sd	s4,32(a0)
 b50:	03553423          	sd	s5,40(a0)
 b54:	03653823          	sd	s6,48(a0)
 b58:	03753c23          	sd	s7,56(a0)
 b5c:	05853023          	sd	s8,64(a0)
 b60:	05953423          	sd	s9,72(a0)
 b64:	05a53823          	sd	s10,80(a0)
 b68:	05b53c23          	sd	s11,88(a0)
 b6c:	06153023          	sd	ra,96(a0)
 b70:	06253423          	sd	sp,104(a0)
 b74:	4501                	li	a0,0
 b76:	8082                	ret

0000000000000b78 <longjmp>:
 b78:	6100                	ld	s0,0(a0)
 b7a:	6504                	ld	s1,8(a0)
 b7c:	01053903          	ld	s2,16(a0)
 b80:	01853983          	ld	s3,24(a0)
 b84:	02053a03          	ld	s4,32(a0)
 b88:	02853a83          	ld	s5,40(a0)
 b8c:	03053b03          	ld	s6,48(a0)
 b90:	03853b83          	ld	s7,56(a0)
 b94:	04053c03          	ld	s8,64(a0)
 b98:	04853c83          	ld	s9,72(a0)
 b9c:	05053d03          	ld	s10,80(a0)
 ba0:	05853d83          	ld	s11,88(a0)
 ba4:	06053083          	ld	ra,96(a0)
 ba8:	06853103          	ld	sp,104(a0)
 bac:	c199                	beqz	a1,bb2 <longjmp_1>
 bae:	852e                	mv	a0,a1
 bb0:	8082                	ret

0000000000000bb2 <longjmp_1>:
 bb2:	4505                	li	a0,1
 bb4:	8082                	ret
