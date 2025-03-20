
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
//static jmp_buf env_tmp;

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
  1a:	a0e080e7          	jalr	-1522(ra) # a24 <malloc>
  1e:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  20:	6505                	lui	a0,0x1
  22:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0xa6>
  26:	00001097          	auipc	ra,0x1
  2a:	9fe080e7          	jalr	-1538(ra) # a24 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
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
    t->stack = (void*) new_stack;
  48:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
  4a:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
  4e:	ec88                	sd	a0,24(s1)
    id++;
  50:	2785                	addiw	a5,a5,1
  52:	c31c                	sw	a5,0(a4)

    // part 2
    t->sig_handler[0] = NULL_FUNC;
  54:	57fd                	li	a5,-1
  56:	f8dc                	sd	a5,176(s1)
    t->sig_handler[1] = NULL_FUNC;
  58:	fcdc                	sd	a5,184(s1)
    t->signo = -1;
  5a:	0cf4a023          	sw	a5,192(s1)
    t->handler_buf_set = 0;
  5e:	1204ac23          	sw	zero,312(s1)
    t->suspended = 0; // Initialize suspended flag
  62:	0a04a423          	sw	zero,168(s1)
    return t;
}
  66:	8526                	mv	a0,s1
  68:	70a2                	ld	ra,40(sp)
  6a:	7402                	ld	s0,32(sp)
  6c:	64e2                	ld	s1,24(sp)
  6e:	6942                	ld	s2,16(sp)
  70:	69a2                	ld	s3,8(sp)
  72:	6145                	addi	sp,sp,48
  74:	8082                	ret

0000000000000076 <thread_add_runqueue>:
void thread_add_runqueue(struct thread *t){
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
    if(current_thread == NULL){
  7c:	00001797          	auipc	a5,0x1
  80:	b247b783          	ld	a5,-1244(a5) # ba0 <current_thread>
  84:	cf91                	beqz	a5,a0 <thread_add_runqueue+0x2a>
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    }
    else{
        // case: adding thread to existing queue
        t->sig_handler[0] = current_thread->sig_handler[0];
  86:	7bd8                	ld	a4,176(a5)
  88:	f958                	sd	a4,176(a0)
        t->sig_handler[1] = current_thread->sig_handler[1];
  8a:	7fd8                	ld	a4,184(a5)
  8c:	fd58                	sd	a4,184(a0)
        
        // Insert into circular linked list
        current_thread->previous->next = t;
  8e:	6fd8                	ld	a4,152(a5)
  90:	f348                	sd	a0,160(a4)
        t->previous = current_thread->previous;
  92:	6fd8                	ld	a4,152(a5)
  94:	ed58                	sd	a4,152(a0)
        t->next = current_thread;
  96:	f15c                	sd	a5,160(a0)
        current_thread->previous = t;
  98:	efc8                	sd	a0,152(a5)
    }
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret
        current_thread = t;
  a0:	00001797          	auipc	a5,0x1
  a4:	b0a7b023          	sd	a0,-1280(a5) # ba0 <current_thread>
        current_thread->next = current_thread;
  a8:	f148                	sd	a0,160(a0)
        current_thread->previous = current_thread;
  aa:	ed48                	sd	a0,152(a0)
  ac:	b7fd                	j	9a <thread_add_runqueue+0x24>

00000000000000ae <schedule>:
        longjmp(t->env, 1);
    }
    
    thread_exit();  // exit when the function is completed
}
void schedule(void){
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
    // TODO
    //printf("schedule\n");
    current_thread = current_thread->next;
  b4:	00001717          	auipc	a4,0x1
  b8:	aec70713          	addi	a4,a4,-1300 # ba0 <current_thread>
  bc:	631c                	ld	a5,0(a4)
  be:	73dc                	ld	a5,160(a5)
  c0:	e31c                	sd	a5,0(a4)
    
    // Skip suspended threads, if the thread is suspended, we kept moving to the next thread
    while (current_thread->suspended) {
  c2:	0a87a703          	lw	a4,168(a5)
  c6:	cb09                	beqz	a4,d8 <schedule+0x2a>
        current_thread = current_thread->next;
  c8:	73dc                	ld	a5,160(a5)
    while (current_thread->suspended) {
  ca:	0a87a703          	lw	a4,168(a5)
  ce:	ff6d                	bnez	a4,c8 <schedule+0x1a>
  d0:	00001717          	auipc	a4,0x1
  d4:	acf73823          	sd	a5,-1328(a4) # ba0 <current_thread>
    }
}
  d8:	6422                	ld	s0,8(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <thread_exit>:



void thread_exit(void){
  de:	1101                	addi	sp,sp,-32
  e0:	ec06                	sd	ra,24(sp)
  e2:	e822                	sd	s0,16(sp)
  e4:	e426                	sd	s1,8(sp)
  e6:	1000                	addi	s0,sp,32
    if(current_thread->next != current_thread){         // case: has more than one thread in the runqueue
  e8:	00001497          	auipc	s1,0x1
  ec:	ab84b483          	ld	s1,-1352(s1) # ba0 <current_thread>
  f0:	70dc                	ld	a5,160(s1)
  f2:	02f48d63          	beq	s1,a5,12c <thread_exit+0x4e>
        struct thread *curr = current_thread;
        // Remove from circular list
        current_thread->previous->next = current_thread->next;
  f6:	6cd8                	ld	a4,152(s1)
  f8:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
  fa:	6cd8                	ld	a4,152(s1)
  fc:	efd8                	sd	a4,152(a5)
        schedule();
  fe:	00000097          	auipc	ra,0x0
 102:	fb0080e7          	jalr	-80(ra) # ae <schedule>
        free(curr->stack);
 106:	6888                	ld	a0,16(s1)
 108:	00001097          	auipc	ra,0x1
 10c:	894080e7          	jalr	-1900(ra) # 99c <free>
        free(curr);
 110:	8526                	mv	a0,s1
 112:	00001097          	auipc	ra,0x1
 116:	88a080e7          	jalr	-1910(ra) # 99c <free>
        dispatch();
 11a:	00000097          	auipc	ra,0x0
 11e:	040080e7          	jalr	64(ra) # 15a <dispatch>
        // case: last thread in system
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st,1);    // return to main function
    }
}
 122:	60e2                	ld	ra,24(sp)
 124:	6442                	ld	s0,16(sp)
 126:	64a2                	ld	s1,8(sp)
 128:	6105                	addi	sp,sp,32
 12a:	8082                	ret
        free(current_thread->stack);
 12c:	6888                	ld	a0,16(s1)
 12e:	00001097          	auipc	ra,0x1
 132:	86e080e7          	jalr	-1938(ra) # 99c <free>
        free(current_thread);
 136:	00001517          	auipc	a0,0x1
 13a:	a6a53503          	ld	a0,-1430(a0) # ba0 <current_thread>
 13e:	00001097          	auipc	ra,0x1
 142:	85e080e7          	jalr	-1954(ra) # 99c <free>
        longjmp(env_st,1);    // return to main function
 146:	4585                	li	a1,1
 148:	00001517          	auipc	a0,0x1
 14c:	a6850513          	addi	a0,a0,-1432 # bb0 <env_st>
 150:	00001097          	auipc	ra,0x1
 154:	9f0080e7          	jalr	-1552(ra) # b40 <longjmp>
}
 158:	b7e9                	j	122 <thread_exit+0x44>

000000000000015a <dispatch>:
void dispatch(void){
 15a:	7179                	addi	sp,sp,-48
 15c:	f406                	sd	ra,40(sp)
 15e:	f022                	sd	s0,32(sp)
 160:	ec26                	sd	s1,24(sp)
 162:	1800                	addi	s0,sp,48
    struct thread *t = current_thread;
 164:	00001717          	auipc	a4,0x1
 168:	a3c73703          	ld	a4,-1476(a4) # ba0 <current_thread>
 16c:	fce43c23          	sd	a4,-40(s0)
    if (t->buf_set == 0) {       // case: first time setting the context (buf_set == 0)
 170:	09072783          	lw	a5,144(a4)
 174:	e785                	bnez	a5,19c <dispatch+0x42>
        t->buf_set = 1;
 176:	4785                	li	a5,1
 178:	08f72823          	sw	a5,144(a4)
        if (setjmp(t->env) == 0) {  // case: first time calling setjmp
 17c:	02070513          	addi	a0,a4,32
 180:	00001097          	auipc	ra,0x1
 184:	988080e7          	jalr	-1656(ra) # b08 <setjmp>
 188:	c141                	beqz	a0,208 <dispatch+0xae>
            t->fp(t->arg);
 18a:	fd843703          	ld	a4,-40(s0)
 18e:	631c                	ld	a5,0(a4)
 190:	6708                	ld	a0,8(a4)
 192:	9782                	jalr	a5
            thread_exit();
 194:	00000097          	auipc	ra,0x0
 198:	f4a080e7          	jalr	-182(ra) # de <thread_exit>
    if (t->signo != -1) {   // case: If a signal has been set
 19c:	fd843683          	ld	a3,-40(s0)
 1a0:	0c06a783          	lw	a5,192(a3)
 1a4:	577d                	li	a4,-1
 1a6:	0ae78c63          	beq	a5,a4,25e <dispatch+0x104>
        if (t->sig_handler[t->signo] != NULL_FUNC) {     // case: exists corresponding signal handler
 1aa:	07d9                	addi	a5,a5,22
 1ac:	078e                	slli	a5,a5,0x3
 1ae:	97b6                	add	a5,a5,a3
 1b0:	6398                	ld	a4,0(a5)
 1b2:	57fd                	li	a5,-1
 1b4:	0af70063          	beq	a4,a5,254 <dispatch+0xfa>
            if (t->handler_buf_set == 1) {      // case: already set the context (handler_buf_set == 1)
 1b8:	1386a703          	lw	a4,312(a3)
 1bc:	4785                	li	a5,1
 1be:	06f70163          	beq	a4,a5,220 <dispatch+0xc6>
                if (setjmp(t->handler_env) == 0) {  // case: first time calling setjmp  
 1c2:	fd843783          	ld	a5,-40(s0)
 1c6:	0c878513          	addi	a0,a5,200
 1ca:	00001097          	auipc	ra,0x1
 1ce:	93e080e7          	jalr	-1730(ra) # b08 <setjmp>
 1d2:	cd39                	beqz	a0,230 <dispatch+0xd6>
                    t->sig_handler[t->signo](t->signo);
 1d4:	fd843483          	ld	s1,-40(s0)
 1d8:	0c04a503          	lw	a0,192(s1)
 1dc:	01650793          	addi	a5,a0,22
 1e0:	078e                	slli	a5,a5,0x3
 1e2:	97a6                	add	a5,a5,s1
 1e4:	639c                	ld	a5,0(a5)
 1e6:	9782                	jalr	a5
                    t->signo = -1;
 1e8:	57fd                	li	a5,-1
 1ea:	0cf4a023          	sw	a5,192(s1)
                    dispatch();
 1ee:	00000097          	auipc	ra,0x0
 1f2:	f6c080e7          	jalr	-148(ra) # 15a <dispatch>
    thread_exit();  // exit when the function is completed
 1f6:	00000097          	auipc	ra,0x0
 1fa:	ee8080e7          	jalr	-280(ra) # de <thread_exit>
}
 1fe:	70a2                	ld	ra,40(sp)
 200:	7402                	ld	s0,32(sp)
 202:	64e2                	ld	s1,24(sp)
 204:	6145                	addi	sp,sp,48
 206:	8082                	ret
            t->env->sp = (unsigned long) t->stack_p;
 208:	fd843703          	ld	a4,-40(s0)
 20c:	6f1c                	ld	a5,24(a4)
 20e:	e75c                	sd	a5,136(a4)
            longjmp(t->env, 1);
 210:	4585                	li	a1,1
 212:	02070513          	addi	a0,a4,32
 216:	00001097          	auipc	ra,0x1
 21a:	92a080e7          	jalr	-1750(ra) # b40 <longjmp>
 21e:	bfbd                	j	19c <dispatch+0x42>
                longjmp(t->handler_env, 1);
 220:	4585                	li	a1,1
 222:	0c868513          	addi	a0,a3,200
 226:	00001097          	auipc	ra,0x1
 22a:	91a080e7          	jalr	-1766(ra) # b40 <longjmp>
 22e:	b7e1                	j	1f6 <dispatch+0x9c>
                    t->handler_buf_set = 1;
 230:	4785                	li	a5,1
 232:	fd843703          	ld	a4,-40(s0)
 236:	12f72c23          	sw	a5,312(a4)
                    t->handler_env->sp = (unsigned long) t->stack_p - 50*8;
 23a:	6f1c                	ld	a5,24(a4)
 23c:	e7078793          	addi	a5,a5,-400
 240:	12f73823          	sd	a5,304(a4)
                    longjmp(t->handler_env, 1);
 244:	4585                	li	a1,1
 246:	0c870513          	addi	a0,a4,200
 24a:	00001097          	auipc	ra,0x1
 24e:	8f6080e7          	jalr	-1802(ra) # b40 <longjmp>
 252:	b755                	j	1f6 <dispatch+0x9c>
            thread_exit();
 254:	00000097          	auipc	ra,0x0
 258:	e8a080e7          	jalr	-374(ra) # de <thread_exit>
 25c:	bf69                	j	1f6 <dispatch+0x9c>
        longjmp(t->env, 1);
 25e:	4585                	li	a1,1
 260:	fd843783          	ld	a5,-40(s0)
 264:	02078513          	addi	a0,a5,32
 268:	00001097          	auipc	ra,0x1
 26c:	8d8080e7          	jalr	-1832(ra) # b40 <longjmp>
 270:	b759                	j	1f6 <dispatch+0x9c>

0000000000000272 <thread_yield>:
void thread_yield(void){
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
    if(current_thread->signo != -1){
 27a:	00001517          	auipc	a0,0x1
 27e:	92653503          	ld	a0,-1754(a0) # ba0 <current_thread>
 282:	0c052703          	lw	a4,192(a0)
 286:	57fd                	li	a5,-1
 288:	02f70663          	beq	a4,a5,2b4 <thread_yield+0x42>
        if(setjmp(current_thread->handler_env) == NULL){
 28c:	0c850513          	addi	a0,a0,200
 290:	00001097          	auipc	ra,0x1
 294:	878080e7          	jalr	-1928(ra) # b08 <setjmp>
 298:	c509                	beqz	a0,2a2 <thread_yield+0x30>
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
            schedule();
 2a2:	00000097          	auipc	ra,0x0
 2a6:	e0c080e7          	jalr	-500(ra) # ae <schedule>
            dispatch();
 2aa:	00000097          	auipc	ra,0x0
 2ae:	eb0080e7          	jalr	-336(ra) # 15a <dispatch>
 2b2:	b7e5                	j	29a <thread_yield+0x28>
        if(setjmp(current_thread->env) == NULL){
 2b4:	02050513          	addi	a0,a0,32
 2b8:	00001097          	auipc	ra,0x1
 2bc:	850080e7          	jalr	-1968(ra) # b08 <setjmp>
 2c0:	fd69                	bnez	a0,29a <thread_yield+0x28>
            schedule();
 2c2:	00000097          	auipc	ra,0x0
 2c6:	dec080e7          	jalr	-532(ra) # ae <schedule>
            dispatch();
 2ca:	00000097          	auipc	ra,0x0
 2ce:	e90080e7          	jalr	-368(ra) # 15a <dispatch>
}
 2d2:	b7e1                	j	29a <thread_yield+0x28>

00000000000002d4 <thread_start_threading>:
thread_exit() is called by the last thread, and the else condition is satisfied, 
when longjmp(env_st, 1); is executed, we jump back to if (setjmp(env_st) == 0) in thread_start_threading(), 
but now the condition is not satisfied
*/

void thread_start_threading(void){
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	addi	s0,sp,16
    if(setjmp(env_st) == 0){
 2dc:	00001517          	auipc	a0,0x1
 2e0:	8d450513          	addi	a0,a0,-1836 # bb0 <env_st>
 2e4:	00001097          	auipc	ra,0x1
 2e8:	824080e7          	jalr	-2012(ra) # b08 <setjmp>
 2ec:	c509                	beqz	a0,2f6 <thread_start_threading+0x22>
        schedule();
        dispatch();
    }
    else return;
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
        schedule();
 2f6:	00000097          	auipc	ra,0x0
 2fa:	db8080e7          	jalr	-584(ra) # ae <schedule>
        dispatch();
 2fe:	00000097          	auipc	ra,0x0
 302:	e5c080e7          	jalr	-420(ra) # 15a <dispatch>
 306:	b7e5                	j	2ee <thread_start_threading+0x1a>

0000000000000308 <thread_register_handler>:
/*
When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", 
then executes the sig_handler function.
If another signal handler has already been registered by the same signal, just replace it
*/
void thread_register_handler(int signo, void (*handler)(int)){
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
    // Register signal handler for current thread
    current_thread->sig_handler[signo] = handler;
 310:	0559                	addi	a0,a0,22
 312:	050e                	slli	a0,a0,0x3
 314:	00001797          	auipc	a5,0x1
 318:	88c7b783          	ld	a5,-1908(a5) # ba0 <current_thread>
 31c:	953e                	add	a0,a0,a5
 31e:	e10c                	sd	a1,0(a0)
    sleep(3);
 320:	450d                	li	a0,3
 322:	00000097          	auipc	ra,0x0
 326:	35c080e7          	jalr	860(ra) # 67e <sleep>
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret

0000000000000332 <thread_kill>:
> xv6.pdf p.77
While a process can call thread_exit() to terminate itself, 
sometimes one process wants to kill another process (ex: parent kills child),
thread_kill() does not immediately terminates the victim process, but instead sets a flag (p->killed), marking it to be killed later
*/
void thread_kill(struct thread *t, int signo){
 332:	1141                	addi	sp,sp,-16
 334:	e422                	sd	s0,8(sp)
 336:	0800                	addi	s0,sp,16
    // Set signal for specified thread
    t->signo = signo;
 338:	0cb52023          	sw	a1,192(a0)
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <thread_suspend>:

current_thread is set to the next of the original current_thread (Thread B), 
if Thread B is also suspended, the while loop would then move on checking Thread C
*/

void thread_suspend(struct thread *t) {
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
    // Mark thread as suspended
   t->suspended = 1;
 348:	4785                	li	a5,1
 34a:	0af52423          	sw	a5,168(a0)
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret

0000000000000354 <thread_resume>:


void thread_resume(struct thread *t) {
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
    t->suspended = 0;
 35a:	0a052423          	sw	zero,168(a0)
}
 35e:	6422                	ld	s0,8(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <get_current_thread>:

struct thread* get_current_thread() {
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
    // Return pointer to current thread
    return current_thread;
 36a:	00001517          	auipc	a0,0x1
 36e:	83653503          	ld	a0,-1994(a0) # ba0 <current_thread>
 372:	6422                	ld	s0,8(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret

0000000000000378 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 37e:	87aa                	mv	a5,a0
 380:	0585                	addi	a1,a1,1
 382:	0785                	addi	a5,a5,1
 384:	fff5c703          	lbu	a4,-1(a1)
 388:	fee78fa3          	sb	a4,-1(a5)
 38c:	fb75                	bnez	a4,380 <strcpy+0x8>
    ;
  return os;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	addi	sp,sp,16
 392:	8082                	ret

0000000000000394 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 39a:	00054783          	lbu	a5,0(a0)
 39e:	cb91                	beqz	a5,3b2 <strcmp+0x1e>
 3a0:	0005c703          	lbu	a4,0(a1)
 3a4:	00f71763          	bne	a4,a5,3b2 <strcmp+0x1e>
    p++, q++;
 3a8:	0505                	addi	a0,a0,1
 3aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3ac:	00054783          	lbu	a5,0(a0)
 3b0:	fbe5                	bnez	a5,3a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3b2:	0005c503          	lbu	a0,0(a1)
}
 3b6:	40a7853b          	subw	a0,a5,a0
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3c6:	00054783          	lbu	a5,0(a0)
 3ca:	cf91                	beqz	a5,3e6 <strlen+0x26>
 3cc:	0505                	addi	a0,a0,1
 3ce:	87aa                	mv	a5,a0
 3d0:	4685                	li	a3,1
 3d2:	9e89                	subw	a3,a3,a0
 3d4:	00f6853b          	addw	a0,a3,a5
 3d8:	0785                	addi	a5,a5,1
 3da:	fff7c703          	lbu	a4,-1(a5)
 3de:	fb7d                	bnez	a4,3d4 <strlen+0x14>
    ;
  return n;
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret
  for(n = 0; s[n]; n++)
 3e6:	4501                	li	a0,0
 3e8:	bfe5                	j	3e0 <strlen+0x20>

00000000000003ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3f0:	ce09                	beqz	a2,40a <memset+0x20>
 3f2:	87aa                	mv	a5,a0
 3f4:	fff6071b          	addiw	a4,a2,-1
 3f8:	1702                	slli	a4,a4,0x20
 3fa:	9301                	srli	a4,a4,0x20
 3fc:	0705                	addi	a4,a4,1
 3fe:	972a                	add	a4,a4,a0
    cdst[i] = c;
 400:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 404:	0785                	addi	a5,a5,1
 406:	fee79de3          	bne	a5,a4,400 <memset+0x16>
  }
  return dst;
}
 40a:	6422                	ld	s0,8(sp)
 40c:	0141                	addi	sp,sp,16
 40e:	8082                	ret

0000000000000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
  for(; *s; s++)
 416:	00054783          	lbu	a5,0(a0)
 41a:	cb99                	beqz	a5,430 <strchr+0x20>
    if(*s == c)
 41c:	00f58763          	beq	a1,a5,42a <strchr+0x1a>
  for(; *s; s++)
 420:	0505                	addi	a0,a0,1
 422:	00054783          	lbu	a5,0(a0)
 426:	fbfd                	bnez	a5,41c <strchr+0xc>
      return (char*)s;
  return 0;
 428:	4501                	li	a0,0
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret
  return 0;
 430:	4501                	li	a0,0
 432:	bfe5                	j	42a <strchr+0x1a>

0000000000000434 <gets>:

char*
gets(char *buf, int max)
{
 434:	711d                	addi	sp,sp,-96
 436:	ec86                	sd	ra,88(sp)
 438:	e8a2                	sd	s0,80(sp)
 43a:	e4a6                	sd	s1,72(sp)
 43c:	e0ca                	sd	s2,64(sp)
 43e:	fc4e                	sd	s3,56(sp)
 440:	f852                	sd	s4,48(sp)
 442:	f456                	sd	s5,40(sp)
 444:	f05a                	sd	s6,32(sp)
 446:	ec5e                	sd	s7,24(sp)
 448:	1080                	addi	s0,sp,96
 44a:	8baa                	mv	s7,a0
 44c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 44e:	892a                	mv	s2,a0
 450:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 452:	4aa9                	li	s5,10
 454:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 456:	89a6                	mv	s3,s1
 458:	2485                	addiw	s1,s1,1
 45a:	0344d863          	bge	s1,s4,48a <gets+0x56>
    cc = read(0, &c, 1);
 45e:	4605                	li	a2,1
 460:	faf40593          	addi	a1,s0,-81
 464:	4501                	li	a0,0
 466:	00000097          	auipc	ra,0x0
 46a:	1a0080e7          	jalr	416(ra) # 606 <read>
    if(cc < 1)
 46e:	00a05e63          	blez	a0,48a <gets+0x56>
    buf[i++] = c;
 472:	faf44783          	lbu	a5,-81(s0)
 476:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 47a:	01578763          	beq	a5,s5,488 <gets+0x54>
 47e:	0905                	addi	s2,s2,1
 480:	fd679be3          	bne	a5,s6,456 <gets+0x22>
  for(i=0; i+1 < max; ){
 484:	89a6                	mv	s3,s1
 486:	a011                	j	48a <gets+0x56>
 488:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 48a:	99de                	add	s3,s3,s7
 48c:	00098023          	sb	zero,0(s3)
  return buf;
}
 490:	855e                	mv	a0,s7
 492:	60e6                	ld	ra,88(sp)
 494:	6446                	ld	s0,80(sp)
 496:	64a6                	ld	s1,72(sp)
 498:	6906                	ld	s2,64(sp)
 49a:	79e2                	ld	s3,56(sp)
 49c:	7a42                	ld	s4,48(sp)
 49e:	7aa2                	ld	s5,40(sp)
 4a0:	7b02                	ld	s6,32(sp)
 4a2:	6be2                	ld	s7,24(sp)
 4a4:	6125                	addi	sp,sp,96
 4a6:	8082                	ret

00000000000004a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 4a8:	1101                	addi	sp,sp,-32
 4aa:	ec06                	sd	ra,24(sp)
 4ac:	e822                	sd	s0,16(sp)
 4ae:	e426                	sd	s1,8(sp)
 4b0:	e04a                	sd	s2,0(sp)
 4b2:	1000                	addi	s0,sp,32
 4b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b6:	4581                	li	a1,0
 4b8:	00000097          	auipc	ra,0x0
 4bc:	176080e7          	jalr	374(ra) # 62e <open>
  if(fd < 0)
 4c0:	02054563          	bltz	a0,4ea <stat+0x42>
 4c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4c6:	85ca                	mv	a1,s2
 4c8:	00000097          	auipc	ra,0x0
 4cc:	17e080e7          	jalr	382(ra) # 646 <fstat>
 4d0:	892a                	mv	s2,a0
  close(fd);
 4d2:	8526                	mv	a0,s1
 4d4:	00000097          	auipc	ra,0x0
 4d8:	142080e7          	jalr	322(ra) # 616 <close>
  return r;
}
 4dc:	854a                	mv	a0,s2
 4de:	60e2                	ld	ra,24(sp)
 4e0:	6442                	ld	s0,16(sp)
 4e2:	64a2                	ld	s1,8(sp)
 4e4:	6902                	ld	s2,0(sp)
 4e6:	6105                	addi	sp,sp,32
 4e8:	8082                	ret
    return -1;
 4ea:	597d                	li	s2,-1
 4ec:	bfc5                	j	4dc <stat+0x34>

00000000000004ee <atoi>:

int
atoi(const char *s)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4f4:	00054603          	lbu	a2,0(a0)
 4f8:	fd06079b          	addiw	a5,a2,-48
 4fc:	0ff7f793          	andi	a5,a5,255
 500:	4725                	li	a4,9
 502:	02f76963          	bltu	a4,a5,534 <atoi+0x46>
 506:	86aa                	mv	a3,a0
  n = 0;
 508:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 50a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 50c:	0685                	addi	a3,a3,1
 50e:	0025179b          	slliw	a5,a0,0x2
 512:	9fa9                	addw	a5,a5,a0
 514:	0017979b          	slliw	a5,a5,0x1
 518:	9fb1                	addw	a5,a5,a2
 51a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 51e:	0006c603          	lbu	a2,0(a3)
 522:	fd06071b          	addiw	a4,a2,-48
 526:	0ff77713          	andi	a4,a4,255
 52a:	fee5f1e3          	bgeu	a1,a4,50c <atoi+0x1e>
  return n;
}
 52e:	6422                	ld	s0,8(sp)
 530:	0141                	addi	sp,sp,16
 532:	8082                	ret
  n = 0;
 534:	4501                	li	a0,0
 536:	bfe5                	j	52e <atoi+0x40>

0000000000000538 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 538:	1141                	addi	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 53e:	02b57663          	bgeu	a0,a1,56a <memmove+0x32>
    while(n-- > 0)
 542:	02c05163          	blez	a2,564 <memmove+0x2c>
 546:	fff6079b          	addiw	a5,a2,-1
 54a:	1782                	slli	a5,a5,0x20
 54c:	9381                	srli	a5,a5,0x20
 54e:	0785                	addi	a5,a5,1
 550:	97aa                	add	a5,a5,a0
  dst = vdst;
 552:	872a                	mv	a4,a0
      *dst++ = *src++;
 554:	0585                	addi	a1,a1,1
 556:	0705                	addi	a4,a4,1
 558:	fff5c683          	lbu	a3,-1(a1)
 55c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 560:	fee79ae3          	bne	a5,a4,554 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 564:	6422                	ld	s0,8(sp)
 566:	0141                	addi	sp,sp,16
 568:	8082                	ret
    dst += n;
 56a:	00c50733          	add	a4,a0,a2
    src += n;
 56e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 570:	fec05ae3          	blez	a2,564 <memmove+0x2c>
 574:	fff6079b          	addiw	a5,a2,-1
 578:	1782                	slli	a5,a5,0x20
 57a:	9381                	srli	a5,a5,0x20
 57c:	fff7c793          	not	a5,a5
 580:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 582:	15fd                	addi	a1,a1,-1
 584:	177d                	addi	a4,a4,-1
 586:	0005c683          	lbu	a3,0(a1)
 58a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 58e:	fee79ae3          	bne	a5,a4,582 <memmove+0x4a>
 592:	bfc9                	j	564 <memmove+0x2c>

0000000000000594 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 594:	1141                	addi	sp,sp,-16
 596:	e422                	sd	s0,8(sp)
 598:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 59a:	ca05                	beqz	a2,5ca <memcmp+0x36>
 59c:	fff6069b          	addiw	a3,a2,-1
 5a0:	1682                	slli	a3,a3,0x20
 5a2:	9281                	srli	a3,a3,0x20
 5a4:	0685                	addi	a3,a3,1
 5a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5a8:	00054783          	lbu	a5,0(a0)
 5ac:	0005c703          	lbu	a4,0(a1)
 5b0:	00e79863          	bne	a5,a4,5c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5b4:	0505                	addi	a0,a0,1
    p2++;
 5b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5b8:	fed518e3          	bne	a0,a3,5a8 <memcmp+0x14>
  }
  return 0;
 5bc:	4501                	li	a0,0
 5be:	a019                	j	5c4 <memcmp+0x30>
      return *p1 - *p2;
 5c0:	40e7853b          	subw	a0,a5,a4
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret
  return 0;
 5ca:	4501                	li	a0,0
 5cc:	bfe5                	j	5c4 <memcmp+0x30>

00000000000005ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5ce:	1141                	addi	sp,sp,-16
 5d0:	e406                	sd	ra,8(sp)
 5d2:	e022                	sd	s0,0(sp)
 5d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5d6:	00000097          	auipc	ra,0x0
 5da:	f62080e7          	jalr	-158(ra) # 538 <memmove>
}
 5de:	60a2                	ld	ra,8(sp)
 5e0:	6402                	ld	s0,0(sp)
 5e2:	0141                	addi	sp,sp,16
 5e4:	8082                	ret

00000000000005e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5e6:	4885                	li	a7,1
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ee:	4889                	li	a7,2
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5f6:	488d                	li	a7,3
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5fe:	4891                	li	a7,4
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <read>:
.global read
read:
 li a7, SYS_read
 606:	4895                	li	a7,5
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <write>:
.global write
write:
 li a7, SYS_write
 60e:	48c1                	li	a7,16
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <close>:
.global close
close:
 li a7, SYS_close
 616:	48d5                	li	a7,21
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <kill>:
.global kill
kill:
 li a7, SYS_kill
 61e:	4899                	li	a7,6
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <exec>:
.global exec
exec:
 li a7, SYS_exec
 626:	489d                	li	a7,7
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <open>:
.global open
open:
 li a7, SYS_open
 62e:	48bd                	li	a7,15
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 636:	48c5                	li	a7,17
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 63e:	48c9                	li	a7,18
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 646:	48a1                	li	a7,8
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <link>:
.global link
link:
 li a7, SYS_link
 64e:	48cd                	li	a7,19
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 656:	48d1                	li	a7,20
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 65e:	48a5                	li	a7,9
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <dup>:
.global dup
dup:
 li a7, SYS_dup
 666:	48a9                	li	a7,10
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 66e:	48ad                	li	a7,11
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 676:	48b1                	li	a7,12
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 67e:	48b5                	li	a7,13
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 686:	48b9                	li	a7,14
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 68e:	1101                	addi	sp,sp,-32
 690:	ec06                	sd	ra,24(sp)
 692:	e822                	sd	s0,16(sp)
 694:	1000                	addi	s0,sp,32
 696:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 69a:	4605                	li	a2,1
 69c:	fef40593          	addi	a1,s0,-17
 6a0:	00000097          	auipc	ra,0x0
 6a4:	f6e080e7          	jalr	-146(ra) # 60e <write>
}
 6a8:	60e2                	ld	ra,24(sp)
 6aa:	6442                	ld	s0,16(sp)
 6ac:	6105                	addi	sp,sp,32
 6ae:	8082                	ret

00000000000006b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	7139                	addi	sp,sp,-64
 6b2:	fc06                	sd	ra,56(sp)
 6b4:	f822                	sd	s0,48(sp)
 6b6:	f426                	sd	s1,40(sp)
 6b8:	f04a                	sd	s2,32(sp)
 6ba:	ec4e                	sd	s3,24(sp)
 6bc:	0080                	addi	s0,sp,64
 6be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6c0:	c299                	beqz	a3,6c6 <printint+0x16>
 6c2:	0805c863          	bltz	a1,752 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c6:	2581                	sext.w	a1,a1
  neg = 0;
 6c8:	4881                	li	a7,0
 6ca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6d0:	2601                	sext.w	a2,a2
 6d2:	00000517          	auipc	a0,0x0
 6d6:	4b650513          	addi	a0,a0,1206 # b88 <digits>
 6da:	883a                	mv	a6,a4
 6dc:	2705                	addiw	a4,a4,1
 6de:	02c5f7bb          	remuw	a5,a1,a2
 6e2:	1782                	slli	a5,a5,0x20
 6e4:	9381                	srli	a5,a5,0x20
 6e6:	97aa                	add	a5,a5,a0
 6e8:	0007c783          	lbu	a5,0(a5)
 6ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6f0:	0005879b          	sext.w	a5,a1
 6f4:	02c5d5bb          	divuw	a1,a1,a2
 6f8:	0685                	addi	a3,a3,1
 6fa:	fec7f0e3          	bgeu	a5,a2,6da <printint+0x2a>
  if(neg)
 6fe:	00088b63          	beqz	a7,714 <printint+0x64>
    buf[i++] = '-';
 702:	fd040793          	addi	a5,s0,-48
 706:	973e                	add	a4,a4,a5
 708:	02d00793          	li	a5,45
 70c:	fef70823          	sb	a5,-16(a4)
 710:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 714:	02e05863          	blez	a4,744 <printint+0x94>
 718:	fc040793          	addi	a5,s0,-64
 71c:	00e78933          	add	s2,a5,a4
 720:	fff78993          	addi	s3,a5,-1
 724:	99ba                	add	s3,s3,a4
 726:	377d                	addiw	a4,a4,-1
 728:	1702                	slli	a4,a4,0x20
 72a:	9301                	srli	a4,a4,0x20
 72c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 730:	fff94583          	lbu	a1,-1(s2)
 734:	8526                	mv	a0,s1
 736:	00000097          	auipc	ra,0x0
 73a:	f58080e7          	jalr	-168(ra) # 68e <putc>
  while(--i >= 0)
 73e:	197d                	addi	s2,s2,-1
 740:	ff3918e3          	bne	s2,s3,730 <printint+0x80>
}
 744:	70e2                	ld	ra,56(sp)
 746:	7442                	ld	s0,48(sp)
 748:	74a2                	ld	s1,40(sp)
 74a:	7902                	ld	s2,32(sp)
 74c:	69e2                	ld	s3,24(sp)
 74e:	6121                	addi	sp,sp,64
 750:	8082                	ret
    x = -xx;
 752:	40b005bb          	negw	a1,a1
    neg = 1;
 756:	4885                	li	a7,1
    x = -xx;
 758:	bf8d                	j	6ca <printint+0x1a>

000000000000075a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 75a:	7119                	addi	sp,sp,-128
 75c:	fc86                	sd	ra,120(sp)
 75e:	f8a2                	sd	s0,112(sp)
 760:	f4a6                	sd	s1,104(sp)
 762:	f0ca                	sd	s2,96(sp)
 764:	ecce                	sd	s3,88(sp)
 766:	e8d2                	sd	s4,80(sp)
 768:	e4d6                	sd	s5,72(sp)
 76a:	e0da                	sd	s6,64(sp)
 76c:	fc5e                	sd	s7,56(sp)
 76e:	f862                	sd	s8,48(sp)
 770:	f466                	sd	s9,40(sp)
 772:	f06a                	sd	s10,32(sp)
 774:	ec6e                	sd	s11,24(sp)
 776:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 778:	0005c903          	lbu	s2,0(a1)
 77c:	18090f63          	beqz	s2,91a <vprintf+0x1c0>
 780:	8aaa                	mv	s5,a0
 782:	8b32                	mv	s6,a2
 784:	00158493          	addi	s1,a1,1
  state = 0;
 788:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 78a:	02500a13          	li	s4,37
      if(c == 'd'){
 78e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 792:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 796:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 79a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79e:	00000b97          	auipc	s7,0x0
 7a2:	3eab8b93          	addi	s7,s7,1002 # b88 <digits>
 7a6:	a839                	j	7c4 <vprintf+0x6a>
        putc(fd, c);
 7a8:	85ca                	mv	a1,s2
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	ee2080e7          	jalr	-286(ra) # 68e <putc>
 7b4:	a019                	j	7ba <vprintf+0x60>
    } else if(state == '%'){
 7b6:	01498f63          	beq	s3,s4,7d4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7ba:	0485                	addi	s1,s1,1
 7bc:	fff4c903          	lbu	s2,-1(s1)
 7c0:	14090d63          	beqz	s2,91a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7c4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7c8:	fe0997e3          	bnez	s3,7b6 <vprintf+0x5c>
      if(c == '%'){
 7cc:	fd479ee3          	bne	a5,s4,7a8 <vprintf+0x4e>
        state = '%';
 7d0:	89be                	mv	s3,a5
 7d2:	b7e5                	j	7ba <vprintf+0x60>
      if(c == 'd'){
 7d4:	05878063          	beq	a5,s8,814 <vprintf+0xba>
      } else if(c == 'l') {
 7d8:	05978c63          	beq	a5,s9,830 <vprintf+0xd6>
      } else if(c == 'x') {
 7dc:	07a78863          	beq	a5,s10,84c <vprintf+0xf2>
      } else if(c == 'p') {
 7e0:	09b78463          	beq	a5,s11,868 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7e4:	07300713          	li	a4,115
 7e8:	0ce78663          	beq	a5,a4,8b4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ec:	06300713          	li	a4,99
 7f0:	0ee78e63          	beq	a5,a4,8ec <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7f4:	11478863          	beq	a5,s4,904 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f8:	85d2                	mv	a1,s4
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	e92080e7          	jalr	-366(ra) # 68e <putc>
        putc(fd, c);
 804:	85ca                	mv	a1,s2
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	e86080e7          	jalr	-378(ra) # 68e <putc>
      }
      state = 0;
 810:	4981                	li	s3,0
 812:	b765                	j	7ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 814:	008b0913          	addi	s2,s6,8
 818:	4685                	li	a3,1
 81a:	4629                	li	a2,10
 81c:	000b2583          	lw	a1,0(s6)
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	e8e080e7          	jalr	-370(ra) # 6b0 <printint>
 82a:	8b4a                	mv	s6,s2
      state = 0;
 82c:	4981                	li	s3,0
 82e:	b771                	j	7ba <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 830:	008b0913          	addi	s2,s6,8
 834:	4681                	li	a3,0
 836:	4629                	li	a2,10
 838:	000b2583          	lw	a1,0(s6)
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	e72080e7          	jalr	-398(ra) # 6b0 <printint>
 846:	8b4a                	mv	s6,s2
      state = 0;
 848:	4981                	li	s3,0
 84a:	bf85                	j	7ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 84c:	008b0913          	addi	s2,s6,8
 850:	4681                	li	a3,0
 852:	4641                	li	a2,16
 854:	000b2583          	lw	a1,0(s6)
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	e56080e7          	jalr	-426(ra) # 6b0 <printint>
 862:	8b4a                	mv	s6,s2
      state = 0;
 864:	4981                	li	s3,0
 866:	bf91                	j	7ba <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 868:	008b0793          	addi	a5,s6,8
 86c:	f8f43423          	sd	a5,-120(s0)
 870:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 874:	03000593          	li	a1,48
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	e14080e7          	jalr	-492(ra) # 68e <putc>
  putc(fd, 'x');
 882:	85ea                	mv	a1,s10
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e08080e7          	jalr	-504(ra) # 68e <putc>
 88e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 890:	03c9d793          	srli	a5,s3,0x3c
 894:	97de                	add	a5,a5,s7
 896:	0007c583          	lbu	a1,0(a5)
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	df2080e7          	jalr	-526(ra) # 68e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a4:	0992                	slli	s3,s3,0x4
 8a6:	397d                	addiw	s2,s2,-1
 8a8:	fe0914e3          	bnez	s2,890 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8ac:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b721                	j	7ba <vprintf+0x60>
        s = va_arg(ap, char*);
 8b4:	008b0993          	addi	s3,s6,8
 8b8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8bc:	02090163          	beqz	s2,8de <vprintf+0x184>
        while(*s != 0){
 8c0:	00094583          	lbu	a1,0(s2)
 8c4:	c9a1                	beqz	a1,914 <vprintf+0x1ba>
          putc(fd, *s);
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	dc6080e7          	jalr	-570(ra) # 68e <putc>
          s++;
 8d0:	0905                	addi	s2,s2,1
        while(*s != 0){
 8d2:	00094583          	lbu	a1,0(s2)
 8d6:	f9e5                	bnez	a1,8c6 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8d8:	8b4e                	mv	s6,s3
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	bdf9                	j	7ba <vprintf+0x60>
          s = "(null)";
 8de:	00000917          	auipc	s2,0x0
 8e2:	2a290913          	addi	s2,s2,674 # b80 <longjmp_1+0x6>
        while(*s != 0){
 8e6:	02800593          	li	a1,40
 8ea:	bff1                	j	8c6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8ec:	008b0913          	addi	s2,s6,8
 8f0:	000b4583          	lbu	a1,0(s6)
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	d98080e7          	jalr	-616(ra) # 68e <putc>
 8fe:	8b4a                	mv	s6,s2
      state = 0;
 900:	4981                	li	s3,0
 902:	bd65                	j	7ba <vprintf+0x60>
        putc(fd, c);
 904:	85d2                	mv	a1,s4
 906:	8556                	mv	a0,s5
 908:	00000097          	auipc	ra,0x0
 90c:	d86080e7          	jalr	-634(ra) # 68e <putc>
      state = 0;
 910:	4981                	li	s3,0
 912:	b565                	j	7ba <vprintf+0x60>
        s = va_arg(ap, char*);
 914:	8b4e                	mv	s6,s3
      state = 0;
 916:	4981                	li	s3,0
 918:	b54d                	j	7ba <vprintf+0x60>
    }
  }
}
 91a:	70e6                	ld	ra,120(sp)
 91c:	7446                	ld	s0,112(sp)
 91e:	74a6                	ld	s1,104(sp)
 920:	7906                	ld	s2,96(sp)
 922:	69e6                	ld	s3,88(sp)
 924:	6a46                	ld	s4,80(sp)
 926:	6aa6                	ld	s5,72(sp)
 928:	6b06                	ld	s6,64(sp)
 92a:	7be2                	ld	s7,56(sp)
 92c:	7c42                	ld	s8,48(sp)
 92e:	7ca2                	ld	s9,40(sp)
 930:	7d02                	ld	s10,32(sp)
 932:	6de2                	ld	s11,24(sp)
 934:	6109                	addi	sp,sp,128
 936:	8082                	ret

0000000000000938 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 938:	715d                	addi	sp,sp,-80
 93a:	ec06                	sd	ra,24(sp)
 93c:	e822                	sd	s0,16(sp)
 93e:	1000                	addi	s0,sp,32
 940:	e010                	sd	a2,0(s0)
 942:	e414                	sd	a3,8(s0)
 944:	e818                	sd	a4,16(s0)
 946:	ec1c                	sd	a5,24(s0)
 948:	03043023          	sd	a6,32(s0)
 94c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 950:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 954:	8622                	mv	a2,s0
 956:	00000097          	auipc	ra,0x0
 95a:	e04080e7          	jalr	-508(ra) # 75a <vprintf>
}
 95e:	60e2                	ld	ra,24(sp)
 960:	6442                	ld	s0,16(sp)
 962:	6161                	addi	sp,sp,80
 964:	8082                	ret

0000000000000966 <printf>:

void
printf(const char *fmt, ...)
{
 966:	711d                	addi	sp,sp,-96
 968:	ec06                	sd	ra,24(sp)
 96a:	e822                	sd	s0,16(sp)
 96c:	1000                	addi	s0,sp,32
 96e:	e40c                	sd	a1,8(s0)
 970:	e810                	sd	a2,16(s0)
 972:	ec14                	sd	a3,24(s0)
 974:	f018                	sd	a4,32(s0)
 976:	f41c                	sd	a5,40(s0)
 978:	03043823          	sd	a6,48(s0)
 97c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 980:	00840613          	addi	a2,s0,8
 984:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 988:	85aa                	mv	a1,a0
 98a:	4505                	li	a0,1
 98c:	00000097          	auipc	ra,0x0
 990:	dce080e7          	jalr	-562(ra) # 75a <vprintf>
}
 994:	60e2                	ld	ra,24(sp)
 996:	6442                	ld	s0,16(sp)
 998:	6125                	addi	sp,sp,96
 99a:	8082                	ret

000000000000099c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 99c:	1141                	addi	sp,sp,-16
 99e:	e422                	sd	s0,8(sp)
 9a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a6:	00000797          	auipc	a5,0x0
 9aa:	2027b783          	ld	a5,514(a5) # ba8 <freep>
 9ae:	a805                	j	9de <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9b0:	4618                	lw	a4,8(a2)
 9b2:	9db9                	addw	a1,a1,a4
 9b4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b8:	6398                	ld	a4,0(a5)
 9ba:	6318                	ld	a4,0(a4)
 9bc:	fee53823          	sd	a4,-16(a0)
 9c0:	a091                	j	a04 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9c2:	ff852703          	lw	a4,-8(a0)
 9c6:	9e39                	addw	a2,a2,a4
 9c8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9ca:	ff053703          	ld	a4,-16(a0)
 9ce:	e398                	sd	a4,0(a5)
 9d0:	a099                	j	a16 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d2:	6398                	ld	a4,0(a5)
 9d4:	00e7e463          	bltu	a5,a4,9dc <free+0x40>
 9d8:	00e6ea63          	bltu	a3,a4,9ec <free+0x50>
{
 9dc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9de:	fed7fae3          	bgeu	a5,a3,9d2 <free+0x36>
 9e2:	6398                	ld	a4,0(a5)
 9e4:	00e6e463          	bltu	a3,a4,9ec <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e8:	fee7eae3          	bltu	a5,a4,9dc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9ec:	ff852583          	lw	a1,-8(a0)
 9f0:	6390                	ld	a2,0(a5)
 9f2:	02059713          	slli	a4,a1,0x20
 9f6:	9301                	srli	a4,a4,0x20
 9f8:	0712                	slli	a4,a4,0x4
 9fa:	9736                	add	a4,a4,a3
 9fc:	fae60ae3          	beq	a2,a4,9b0 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a00:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a04:	4790                	lw	a2,8(a5)
 a06:	02061713          	slli	a4,a2,0x20
 a0a:	9301                	srli	a4,a4,0x20
 a0c:	0712                	slli	a4,a4,0x4
 a0e:	973e                	add	a4,a4,a5
 a10:	fae689e3          	beq	a3,a4,9c2 <free+0x26>
  } else
    p->s.ptr = bp;
 a14:	e394                	sd	a3,0(a5)
  freep = p;
 a16:	00000717          	auipc	a4,0x0
 a1a:	18f73923          	sd	a5,402(a4) # ba8 <freep>
}
 a1e:	6422                	ld	s0,8(sp)
 a20:	0141                	addi	sp,sp,16
 a22:	8082                	ret

0000000000000a24 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a24:	7139                	addi	sp,sp,-64
 a26:	fc06                	sd	ra,56(sp)
 a28:	f822                	sd	s0,48(sp)
 a2a:	f426                	sd	s1,40(sp)
 a2c:	f04a                	sd	s2,32(sp)
 a2e:	ec4e                	sd	s3,24(sp)
 a30:	e852                	sd	s4,16(sp)
 a32:	e456                	sd	s5,8(sp)
 a34:	e05a                	sd	s6,0(sp)
 a36:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a38:	02051493          	slli	s1,a0,0x20
 a3c:	9081                	srli	s1,s1,0x20
 a3e:	04bd                	addi	s1,s1,15
 a40:	8091                	srli	s1,s1,0x4
 a42:	0014899b          	addiw	s3,s1,1
 a46:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a48:	00000517          	auipc	a0,0x0
 a4c:	16053503          	ld	a0,352(a0) # ba8 <freep>
 a50:	c515                	beqz	a0,a7c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a52:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a54:	4798                	lw	a4,8(a5)
 a56:	02977f63          	bgeu	a4,s1,a94 <malloc+0x70>
 a5a:	8a4e                	mv	s4,s3
 a5c:	0009871b          	sext.w	a4,s3
 a60:	6685                	lui	a3,0x1
 a62:	00d77363          	bgeu	a4,a3,a68 <malloc+0x44>
 a66:	6a05                	lui	s4,0x1
 a68:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a6c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a70:	00000917          	auipc	s2,0x0
 a74:	13890913          	addi	s2,s2,312 # ba8 <freep>
  if(p == (char*)-1)
 a78:	5afd                	li	s5,-1
 a7a:	a88d                	j	aec <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a7c:	00000797          	auipc	a5,0x0
 a80:	1a478793          	addi	a5,a5,420 # c20 <base>
 a84:	00000717          	auipc	a4,0x0
 a88:	12f73223          	sd	a5,292(a4) # ba8 <freep>
 a8c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a8e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a92:	b7e1                	j	a5a <malloc+0x36>
      if(p->s.size == nunits)
 a94:	02e48b63          	beq	s1,a4,aca <malloc+0xa6>
        p->s.size -= nunits;
 a98:	4137073b          	subw	a4,a4,s3
 a9c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a9e:	1702                	slli	a4,a4,0x20
 aa0:	9301                	srli	a4,a4,0x20
 aa2:	0712                	slli	a4,a4,0x4
 aa4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aa6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aaa:	00000717          	auipc	a4,0x0
 aae:	0ea73f23          	sd	a0,254(a4) # ba8 <freep>
      return (void*)(p + 1);
 ab2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ab6:	70e2                	ld	ra,56(sp)
 ab8:	7442                	ld	s0,48(sp)
 aba:	74a2                	ld	s1,40(sp)
 abc:	7902                	ld	s2,32(sp)
 abe:	69e2                	ld	s3,24(sp)
 ac0:	6a42                	ld	s4,16(sp)
 ac2:	6aa2                	ld	s5,8(sp)
 ac4:	6b02                	ld	s6,0(sp)
 ac6:	6121                	addi	sp,sp,64
 ac8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aca:	6398                	ld	a4,0(a5)
 acc:	e118                	sd	a4,0(a0)
 ace:	bff1                	j	aaa <malloc+0x86>
  hp->s.size = nu;
 ad0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad4:	0541                	addi	a0,a0,16
 ad6:	00000097          	auipc	ra,0x0
 ada:	ec6080e7          	jalr	-314(ra) # 99c <free>
  return freep;
 ade:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ae2:	d971                	beqz	a0,ab6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae6:	4798                	lw	a4,8(a5)
 ae8:	fa9776e3          	bgeu	a4,s1,a94 <malloc+0x70>
    if(p == freep)
 aec:	00093703          	ld	a4,0(s2)
 af0:	853e                	mv	a0,a5
 af2:	fef719e3          	bne	a4,a5,ae4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 af6:	8552                	mv	a0,s4
 af8:	00000097          	auipc	ra,0x0
 afc:	b7e080e7          	jalr	-1154(ra) # 676 <sbrk>
  if(p == (char*)-1)
 b00:	fd5518e3          	bne	a0,s5,ad0 <malloc+0xac>
        return 0;
 b04:	4501                	li	a0,0
 b06:	bf45                	j	ab6 <malloc+0x92>

0000000000000b08 <setjmp>:
 b08:	e100                	sd	s0,0(a0)
 b0a:	e504                	sd	s1,8(a0)
 b0c:	01253823          	sd	s2,16(a0)
 b10:	01353c23          	sd	s3,24(a0)
 b14:	03453023          	sd	s4,32(a0)
 b18:	03553423          	sd	s5,40(a0)
 b1c:	03653823          	sd	s6,48(a0)
 b20:	03753c23          	sd	s7,56(a0)
 b24:	05853023          	sd	s8,64(a0)
 b28:	05953423          	sd	s9,72(a0)
 b2c:	05a53823          	sd	s10,80(a0)
 b30:	05b53c23          	sd	s11,88(a0)
 b34:	06153023          	sd	ra,96(a0)
 b38:	06253423          	sd	sp,104(a0)
 b3c:	4501                	li	a0,0
 b3e:	8082                	ret

0000000000000b40 <longjmp>:
 b40:	6100                	ld	s0,0(a0)
 b42:	6504                	ld	s1,8(a0)
 b44:	01053903          	ld	s2,16(a0)
 b48:	01853983          	ld	s3,24(a0)
 b4c:	02053a03          	ld	s4,32(a0)
 b50:	02853a83          	ld	s5,40(a0)
 b54:	03053b03          	ld	s6,48(a0)
 b58:	03853b83          	ld	s7,56(a0)
 b5c:	04053c03          	ld	s8,64(a0)
 b60:	04853c83          	ld	s9,72(a0)
 b64:	05053d03          	ld	s10,80(a0)
 b68:	05853d83          	ld	s11,88(a0)
 b6c:	06053083          	ld	ra,96(a0)
 b70:	06853103          	ld	sp,104(a0)
 b74:	c199                	beqz	a1,b7a <longjmp_1>
 b76:	852e                	mv	a0,a1
 b78:	8082                	ret

0000000000000b7a <longjmp_1>:
 b7a:	4505                	li	a0,1
 b7c:	8082                	ret
