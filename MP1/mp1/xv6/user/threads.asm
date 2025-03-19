
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <get_current_thread>:
#define NULL 0
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st; 
static jmp_buf env_tmp;  
struct thread *get_current_thread() {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    return current_thread;
}
   6:	00001517          	auipc	a0,0x1
   a:	12253503          	ld	a0,290(a0) # 1128 <current_thread>
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
  2e:	c1a080e7          	jalr	-998(ra) # c44 <malloc>
  32:	84aa                	mv	s1,a0
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  34:	6505                	lui	a0,0x1
  36:	80050513          	addi	a0,a0,-2048 # 800 <memcpy+0x12>
  3a:	00001097          	auipc	ra,0x1
  3e:	c0a080e7          	jalr	-1014(ra) # c44 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f; 
  42:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  46:	0124b423          	sd	s2,8(s1)

    t->ID  = id;
  4a:	00001717          	auipc	a4,0x1
  4e:	0da70713          	addi	a4,a4,218 # 1124 <id>
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
    if(current_thread == NULL){                     // case: if no thread currently in the runqueue
  92:	00001797          	auipc	a5,0x1
  96:	0967b783          	ld	a5,150(a5) # 1128 <current_thread>
  9a:	c39d                	beqz	a5,c0 <thread_add_runqueue+0x34>
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {                                          // case: exists thread already in runqueue
        t->next = current_thread;
  9c:	f15c                	sd	a5,160(a0)
        t->previous = current_thread->previous;
  9e:	6fd8                	ld	a4,152(a5)
  a0:	ed58                	sd	a4,152(a0)
        current_thread->previous->next = t;
  a2:	f348                	sd	a0,160(a4)
        current_thread->previous = t;
  a4:	efc8                	sd	a0,152(a5)
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
  c4:	06a7b423          	sd	a0,104(a5) # 1128 <current_thread>
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

00000000000000da <schedule>:
    t->buf_set = 0;  // Reset for next dispatch
    longjmp(t->env, 1);
}

//schedule will follow the rule of FIFO
void schedule(void){
  da:	1101                	addi	sp,sp,-32
  dc:	ec06                	sd	ra,24(sp)
  de:	e822                	sd	s0,16(sp)
  e0:	e426                	sd	s1,8(sp)
  e2:	1000                	addi	s0,sp,32
    printf("Get into schedule and current thread is %d\n", current_thread->ID);
  e4:	00001497          	auipc	s1,0x1
  e8:	04448493          	addi	s1,s1,68 # 1128 <current_thread>
  ec:	609c                	ld	a5,0(s1)
  ee:	0947a583          	lw	a1,148(a5)
  f2:	00001517          	auipc	a0,0x1
  f6:	cae50513          	addi	a0,a0,-850 # da0 <longjmp_1+0x6>
  fa:	00001097          	auipc	ra,0x1
  fe:	a8c080e7          	jalr	-1396(ra) # b86 <printf>
    current_thread = current_thread->next;
 102:	609c                	ld	a5,0(s1)
 104:	73dc                	ld	a5,160(a5)
 106:	e09c                	sd	a5,0(s1)
    
    //Part 2: TO DO
    while(current_thread->suspended == 0) {
 108:	0bc7a703          	lw	a4,188(a5)
 10c:	eb09                	bnez	a4,11e <schedule+0x44>
        // When current thread is suspended, skip this thread and move to the next one
        current_thread = current_thread->next;  
 10e:	73dc                	ld	a5,160(a5)
    while(current_thread->suspended == 0) {
 110:	0bc7a703          	lw	a4,188(a5)
 114:	df6d                	beqz	a4,10e <schedule+0x34>
 116:	00001717          	auipc	a4,0x1
 11a:	00f73923          	sd	a5,18(a4) # 1128 <current_thread>
    }
    printf("scheduled to thread %d\n", current_thread->ID);
 11e:	0947a583          	lw	a1,148(a5)
 122:	00001517          	auipc	a0,0x1
 126:	cae50513          	addi	a0,a0,-850 # dd0 <longjmp_1+0x36>
 12a:	00001097          	auipc	ra,0x1
 12e:	a5c080e7          	jalr	-1444(ra) # b86 <printf>
}
 132:	60e2                	ld	ra,24(sp)
 134:	6442                	ld	s0,16(sp)
 136:	64a2                	ld	s1,8(sp)
 138:	6105                	addi	sp,sp,32
 13a:	8082                	ret

000000000000013c <thread_exit>:
// aim: 2. free stack, struct thread
// aim: 3. update current_thread with next to-be-thread in runqueue (schedule())
// aim: 4. call dispatch
// note: when the last thread exits, return to the main function

void thread_exit(void){
 13c:	1101                	addi	sp,sp,-32
 13e:	ec06                	sd	ra,24(sp)
 140:	e822                	sd	s0,16(sp)
 142:	e426                	sd	s1,8(sp)
 144:	1000                	addi	s0,sp,32
    printf("thread_exit\n");
 146:	00001517          	auipc	a0,0x1
 14a:	ca250513          	addi	a0,a0,-862 # de8 <longjmp_1+0x4e>
 14e:	00001097          	auipc	ra,0x1
 152:	a38080e7          	jalr	-1480(ra) # b86 <printf>
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
 156:	00001497          	auipc	s1,0x1
 15a:	fd24b483          	ld	s1,-46(s1) # 1128 <current_thread>
 15e:	70dc                	ld	a5,160(s1)
 160:	02f48d63          	beq	s1,a5,19a <thread_exit+0x5e>
        //TO DO
        // Save current_thread to t since we'll need to modify current_thread in (1.), (3.), but we then need to free this original current_thread in (2.) 
        struct thread *t = current_thread;
        // (1.)
        current_thread->previous->next = current_thread->next;
 164:	6cd8                	ld	a4,152(s1)
 166:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
 168:	6cd8                	ld	a4,152(s1)
 16a:	efd8                	sd	a4,152(a5)
        
        // (3.)
        //current_thread = current_thread->next;
        schedule();  // consider the case that current_thread->next is suspended, and should move on find the next thread 
 16c:	00000097          	auipc	ra,0x0
 170:	f6e080e7          	jalr	-146(ra) # da <schedule>

        // (2.)
        free(t->stack);
 174:	6888                	ld	a0,16(s1)
 176:	00001097          	auipc	ra,0x1
 17a:	a46080e7          	jalr	-1466(ra) # bbc <free>
        free(t);
 17e:	8526                	mv	a0,s1
 180:	00001097          	auipc	ra,0x1
 184:	a3c080e7          	jalr	-1476(ra) # bbc <free>

        // (4.)
        dispatch();
 188:	00000097          	auipc	ra,0x0
 18c:	040080e7          	jalr	64(ra) # 1c8 <dispatch>
    } else {                                         // case: last thread 
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    }
}
 190:	60e2                	ld	ra,24(sp)
 192:	6442                	ld	s0,16(sp)
 194:	64a2                	ld	s1,8(sp)
 196:	6105                	addi	sp,sp,32
 198:	8082                	ret
        free(current_thread->stack);
 19a:	6888                	ld	a0,16(s1)
 19c:	00001097          	auipc	ra,0x1
 1a0:	a20080e7          	jalr	-1504(ra) # bbc <free>
        free(current_thread);
 1a4:	00001517          	auipc	a0,0x1
 1a8:	f8453503          	ld	a0,-124(a0) # 1128 <current_thread>
 1ac:	00001097          	auipc	ra,0x1
 1b0:	a10080e7          	jalr	-1520(ra) # bbc <free>
        longjmp(env_st, 1);
 1b4:	4585                	li	a1,1
 1b6:	00001517          	auipc	a0,0x1
 1ba:	f8250513          	addi	a0,a0,-126 # 1138 <env_st>
 1be:	00001097          	auipc	ra,0x1
 1c2:	ba2080e7          	jalr	-1118(ra) # d60 <longjmp>
}
 1c6:	b7e9                	j	190 <thread_exit+0x54>

00000000000001c8 <dispatch>:
void dispatch(void) {
 1c8:	7139                	addi	sp,sp,-64
 1ca:	fc06                	sd	ra,56(sp)
 1cc:	f822                	sd	s0,48(sp)
 1ce:	f426                	sd	s1,40(sp)
 1d0:	0080                	addi	s0,sp,64
    struct thread *t = current_thread;
 1d2:	00001797          	auipc	a5,0x1
 1d6:	f567b783          	ld	a5,-170(a5) # 1128 <current_thread>
 1da:	84be                	mv	s1,a5
 1dc:	fcf43c23          	sd	a5,-40(s0)
    printf("\n");
 1e0:	00001517          	auipc	a0,0x1
 1e4:	c8850513          	addi	a0,a0,-888 # e68 <longjmp_1+0xce>
 1e8:	00001097          	auipc	ra,0x1
 1ec:	99e080e7          	jalr	-1634(ra) # b86 <printf>
    printf("---------------------------------\n");
 1f0:	00001517          	auipc	a0,0x1
 1f4:	c0850513          	addi	a0,a0,-1016 # df8 <longjmp_1+0x5e>
 1f8:	00001097          	auipc	ra,0x1
 1fc:	98e080e7          	jalr	-1650(ra) # b86 <printf>
    printf("Thread %d is being dispatched and has buf_set = %d, handler_buf_set = %d\n", 
 200:	1304a683          	lw	a3,304(s1)
 204:	0904a603          	lw	a2,144(s1)
 208:	0944a583          	lw	a1,148(s1)
 20c:	00001517          	auipc	a0,0x1
 210:	c1450513          	addi	a0,a0,-1004 # e20 <longjmp_1+0x86>
 214:	00001097          	auipc	ra,0x1
 218:	972080e7          	jalr	-1678(ra) # b86 <printf>
    if (t->buf_set == 0) {
 21c:	0904a783          	lw	a5,144(s1)
 220:	c3b1                	beqz	a5,264 <dispatch+0x9c>
    if (t->handler_buf_set == 1) {
 222:	fd843783          	ld	a5,-40(s0)
 226:	1307a703          	lw	a4,304(a5)
 22a:	4785                	li	a5,1
 22c:	14f70363          	beq	a4,a5,372 <dispatch+0x1aa>
    printf("Normal resumption of thread %d\n", t->ID);
 230:	fd843483          	ld	s1,-40(s0)
 234:	0944a583          	lw	a1,148(s1)
 238:	00001517          	auipc	a0,0x1
 23c:	db850513          	addi	a0,a0,-584 # ff0 <longjmp_1+0x256>
 240:	00001097          	auipc	ra,0x1
 244:	946080e7          	jalr	-1722(ra) # b86 <printf>
    t->buf_set = 0;  // Reset for next dispatch
 248:	0804a823          	sw	zero,144(s1)
    longjmp(t->env, 1);
 24c:	4585                	li	a1,1
 24e:	02048513          	addi	a0,s1,32
 252:	00001097          	auipc	ra,0x1
 256:	b0e080e7          	jalr	-1266(ra) # d60 <longjmp>
}
 25a:	70e2                	ld	ra,56(sp)
 25c:	7442                	ld	s0,48(sp)
 25e:	74a2                	ld	s1,40(sp)
 260:	6121                	addi	sp,sp,64
 262:	8082                	ret
        printf("Initializing thread %d for the first time\n", t->ID);
 264:	fd843483          	ld	s1,-40(s0)
 268:	0944a583          	lw	a1,148(s1)
 26c:	00001517          	auipc	a0,0x1
 270:	c0450513          	addi	a0,a0,-1020 # e70 <longjmp_1+0xd6>
 274:	00001097          	auipc	ra,0x1
 278:	912080e7          	jalr	-1774(ra) # b86 <printf>
        t->buf_set = 1;
 27c:	4785                	li	a5,1
 27e:	08f4a823          	sw	a5,144(s1)
        if (setjmp(t->env) == 0) {
 282:	02048513          	addi	a0,s1,32
 286:	00001097          	auipc	ra,0x1
 28a:	aa2080e7          	jalr	-1374(ra) # d28 <setjmp>
 28e:	f571                	bnez	a0,25a <dispatch+0x92>
            t->env->sp = (unsigned long)t->stack_p;
 290:	fd843483          	ld	s1,-40(s0)
 294:	6c8c                	ld	a1,24(s1)
 296:	e4cc                	sd	a1,136(s1)
            printf("Setting initial stack pointer to %p\n", t->stack_p);
 298:	00001517          	auipc	a0,0x1
 29c:	c0850513          	addi	a0,a0,-1016 # ea0 <longjmp_1+0x106>
 2a0:	00001097          	auipc	ra,0x1
 2a4:	8e6080e7          	jalr	-1818(ra) # b86 <printf>
            if (t->signo != -1 && t->sig_handler[t->signo] != NULL_FUNC) {
 2a8:	0b84a583          	lw	a1,184(s1)
 2ac:	57fd                	li	a5,-1
 2ae:	04f58363          	beq	a1,a5,2f4 <dispatch+0x12c>
 2b2:	01458793          	addi	a5,a1,20
 2b6:	078e                	slli	a5,a5,0x3
 2b8:	97a6                	add	a5,a5,s1
 2ba:	6798                	ld	a4,8(a5)
 2bc:	57fd                	li	a5,-1
 2be:	02f70b63          	beq	a4,a5,2f4 <dispatch+0x12c>
                printf("Handling signal %d before starting thread\n", t->signo);
 2c2:	00001517          	auipc	a0,0x1
 2c6:	c0650513          	addi	a0,a0,-1018 # ec8 <longjmp_1+0x12e>
 2ca:	00001097          	auipc	ra,0x1
 2ce:	8bc080e7          	jalr	-1860(ra) # b86 <printf>
                int sig = t->signo;
 2d2:	0b84a783          	lw	a5,184(s1)
 2d6:	fcf43823          	sd	a5,-48(s0)
                void (*handler)(int) = t->sig_handler[t->signo];
 2da:	07d1                	addi	a5,a5,20
 2dc:	078e                	slli	a5,a5,0x3
 2de:	97a6                	add	a5,a5,s1
 2e0:	679c                	ld	a5,8(a5)
 2e2:	fcf43423          	sd	a5,-56(s0)
                if (setjmp(t->handler_env) == 0) {
 2e6:	0c048513          	addi	a0,s1,192
 2ea:	00001097          	auipc	ra,0x1
 2ee:	a3e080e7          	jalr	-1474(ra) # d28 <setjmp>
 2f2:	c50d                	beqz	a0,31c <dispatch+0x154>
            printf("Starting thread function at %p with arg %p\n", t->fp, t->arg);
 2f4:	fd843483          	ld	s1,-40(s0)
 2f8:	6490                	ld	a2,8(s1)
 2fa:	608c                	ld	a1,0(s1)
 2fc:	00001517          	auipc	a0,0x1
 300:	c5c50513          	addi	a0,a0,-932 # f58 <longjmp_1+0x1be>
 304:	00001097          	auipc	ra,0x1
 308:	882080e7          	jalr	-1918(ra) # b86 <printf>
            t->fp(t->arg);
 30c:	609c                	ld	a5,0(s1)
 30e:	6488                	ld	a0,8(s1)
 310:	9782                	jalr	a5
            thread_exit();
 312:	00000097          	auipc	ra,0x0
 316:	e2a080e7          	jalr	-470(ra) # 13c <thread_exit>
 31a:	b781                	j	25a <dispatch+0x92>
                    t->handler_buf_set = 1;
 31c:	4785                	li	a5,1
 31e:	fd843483          	ld	s1,-40(s0)
 322:	12f4a823          	sw	a5,304(s1)
                    t->handler_env->sp = (unsigned long)t->stack_p;
 326:	6c8c                	ld	a1,24(s1)
 328:	12b4b423          	sd	a1,296(s1)
                    printf("Setting handler stack pointer to %p\n", t->stack_p);
 32c:	00001517          	auipc	a0,0x1
 330:	bcc50513          	addi	a0,a0,-1076 # ef8 <longjmp_1+0x15e>
 334:	00001097          	auipc	ra,0x1
 338:	852080e7          	jalr	-1966(ra) # b86 <printf>
                    handler(sig);  // Execute the signal handler
 33c:	fd043503          	ld	a0,-48(s0)
 340:	fc843783          	ld	a5,-56(s0)
 344:	9782                	jalr	a5
                    t->signo = -1; // Reset signal
 346:	57fd                	li	a5,-1
 348:	0af4ac23          	sw	a5,184(s1)
                    t->handler_env->sp = (unsigned long)t->stack_p;
 34c:	6c8c                	ld	a1,24(s1)
 34e:	12b4b423          	sd	a1,296(s1)
                    printf("Updated handler stack pointer to %p after execution\n", t->stack_p);
 352:	00001517          	auipc	a0,0x1
 356:	bce50513          	addi	a0,a0,-1074 # f20 <longjmp_1+0x186>
 35a:	00001097          	auipc	ra,0x1
 35e:	82c080e7          	jalr	-2004(ra) # b86 <printf>
                    longjmp(t->handler_env, 1);
 362:	4585                	li	a1,1
 364:	0c048513          	addi	a0,s1,192
 368:	00001097          	auipc	ra,0x1
 36c:	9f8080e7          	jalr	-1544(ra) # d60 <longjmp>
 370:	b751                	j	2f4 <dispatch+0x12c>
        printf("Resuming thread %d after signal handler\n", t->ID);
 372:	fd843483          	ld	s1,-40(s0)
 376:	0944a583          	lw	a1,148(s1)
 37a:	00001517          	auipc	a0,0x1
 37e:	c0e50513          	addi	a0,a0,-1010 # f88 <longjmp_1+0x1ee>
 382:	00001097          	auipc	ra,0x1
 386:	804080e7          	jalr	-2044(ra) # b86 <printf>
        t->handler_buf_set = 0;
 38a:	1204a823          	sw	zero,304(s1)
        t->signo = -1;
 38e:	57fd                	li	a5,-1
 390:	0af4ac23          	sw	a5,184(s1)
        t->env->sp = (unsigned long)t->stack_p;
 394:	6c8c                	ld	a1,24(s1)
 396:	e4cc                	sd	a1,136(s1)
        printf("Updating main env stack pointer to %p after handler\n", t->stack_p);
 398:	00001517          	auipc	a0,0x1
 39c:	c2050513          	addi	a0,a0,-992 # fb8 <longjmp_1+0x21e>
 3a0:	00000097          	auipc	ra,0x0
 3a4:	7e6080e7          	jalr	2022(ra) # b86 <printf>
        longjmp(t->env, 1);
 3a8:	4585                	li	a1,1
 3aa:	02048513          	addi	a0,s1,32
 3ae:	00001097          	auipc	ra,0x1
 3b2:	9b2080e7          	jalr	-1614(ra) # d60 <longjmp>
 3b6:	bdad                	j	230 <dispatch+0x68>

00000000000003b8 <thread_yield>:
void thread_yield(void){
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e406                	sd	ra,8(sp)
 3bc:	e022                	sd	s0,0(sp)
 3be:	0800                	addi	s0,sp,16
    if (current_thread->signo != -1) {           
 3c0:	00001797          	auipc	a5,0x1
 3c4:	d687b783          	ld	a5,-664(a5) # 1128 <current_thread>
 3c8:	0b87a603          	lw	a2,184(a5)
 3cc:	577d                	li	a4,-1
 3ce:	08e60563          	beq	a2,a4,458 <thread_yield+0xa0>
        printf("Thread %d has a signal %d\n", current_thread->ID, current_thread->signo);
 3d2:	0947a583          	lw	a1,148(a5)
 3d6:	00001517          	auipc	a0,0x1
 3da:	c3a50513          	addi	a0,a0,-966 # 1010 <longjmp_1+0x276>
 3de:	00000097          	auipc	ra,0x0
 3e2:	7a8080e7          	jalr	1960(ra) # b86 <printf>
        if(setjmp(current_thread->handler_env) == 0) {
 3e6:	00001517          	auipc	a0,0x1
 3ea:	d4253503          	ld	a0,-702(a0) # 1128 <current_thread>
 3ee:	0c050513          	addi	a0,a0,192
 3f2:	00001097          	auipc	ra,0x1
 3f6:	936080e7          	jalr	-1738(ra) # d28 <setjmp>
 3fa:	e939                	bnez	a0,450 <thread_yield+0x98>
            if (current_thread->handler_buf_set == 0) { 
 3fc:	00001797          	auipc	a5,0x1
 400:	d2c7b783          	ld	a5,-724(a5) # 1128 <current_thread>
 404:	1307a703          	lw	a4,304(a5)
 408:	ef01                	bnez	a4,420 <thread_yield+0x68>
                current_thread->handler_buf_set = 1; 
 40a:	4705                	li	a4,1
 40c:	12e7a823          	sw	a4,304(a5)
                printf("first time saving context, set handler_buf_set to 1\n");
 410:	00001517          	auipc	a0,0x1
 414:	c2050513          	addi	a0,a0,-992 # 1030 <longjmp_1+0x296>
 418:	00000097          	auipc	ra,0x0
 41c:	76e080e7          	jalr	1902(ra) # b86 <printf>
            printf("save context and schedule\n");
 420:	00001517          	auipc	a0,0x1
 424:	c4850513          	addi	a0,a0,-952 # 1068 <longjmp_1+0x2ce>
 428:	00000097          	auipc	ra,0x0
 42c:	75e080e7          	jalr	1886(ra) # b86 <printf>
            schedule();  
 430:	00000097          	auipc	ra,0x0
 434:	caa080e7          	jalr	-854(ra) # da <schedule>
            printf("schedule done, dispatch\n");
 438:	00001517          	auipc	a0,0x1
 43c:	c5050513          	addi	a0,a0,-944 # 1088 <longjmp_1+0x2ee>
 440:	00000097          	auipc	ra,0x0
 444:	746080e7          	jalr	1862(ra) # b86 <printf>
            dispatch();  
 448:	00000097          	auipc	ra,0x0
 44c:	d80080e7          	jalr	-640(ra) # 1c8 <dispatch>
}
 450:	60a2                	ld	ra,8(sp)
 452:	6402                	ld	s0,0(sp)
 454:	0141                	addi	sp,sp,16
 456:	8082                	ret
        printf("Thread %d has no signal and have buf_set = %d\n", current_thread->ID, current_thread->buf_set);
 458:	0907a603          	lw	a2,144(a5)
 45c:	0947a583          	lw	a1,148(a5)
 460:	00001517          	auipc	a0,0x1
 464:	c4850513          	addi	a0,a0,-952 # 10a8 <longjmp_1+0x30e>
 468:	00000097          	auipc	ra,0x0
 46c:	71e080e7          	jalr	1822(ra) # b86 <printf>
        if(setjmp(current_thread->env) == 0) {
 470:	00001517          	auipc	a0,0x1
 474:	cb853503          	ld	a0,-840(a0) # 1128 <current_thread>
 478:	02050513          	addi	a0,a0,32
 47c:	00001097          	auipc	ra,0x1
 480:	8ac080e7          	jalr	-1876(ra) # d28 <setjmp>
 484:	f571                	bnez	a0,450 <thread_yield+0x98>
            if (current_thread->buf_set == 0) { 
 486:	00001797          	auipc	a5,0x1
 48a:	ca27b783          	ld	a5,-862(a5) # 1128 <current_thread>
 48e:	0907a703          	lw	a4,144(a5)
 492:	ef01                	bnez	a4,4aa <thread_yield+0xf2>
                current_thread->buf_set = 1; 
 494:	4705                	li	a4,1
 496:	08e7a823          	sw	a4,144(a5)
                printf("first time saving context, set buf_set to 1\n");
 49a:	00001517          	auipc	a0,0x1
 49e:	c3e50513          	addi	a0,a0,-962 # 10d8 <longjmp_1+0x33e>
 4a2:	00000097          	auipc	ra,0x0
 4a6:	6e4080e7          	jalr	1764(ra) # b86 <printf>
            printf("save context and schedule\n");
 4aa:	00001517          	auipc	a0,0x1
 4ae:	bbe50513          	addi	a0,a0,-1090 # 1068 <longjmp_1+0x2ce>
 4b2:	00000097          	auipc	ra,0x0
 4b6:	6d4080e7          	jalr	1748(ra) # b86 <printf>
            schedule();
 4ba:	00000097          	auipc	ra,0x0
 4be:	c20080e7          	jalr	-992(ra) # da <schedule>
            printf("schedule done, dispatch\n");
 4c2:	00001517          	auipc	a0,0x1
 4c6:	bc650513          	addi	a0,a0,-1082 # 1088 <longjmp_1+0x2ee>
 4ca:	00000097          	auipc	ra,0x0
 4ce:	6bc080e7          	jalr	1724(ra) # b86 <printf>
            dispatch();
 4d2:	00000097          	auipc	ra,0x0
 4d6:	cf6080e7          	jalr	-778(ra) # 1c8 <dispatch>
 4da:	bf9d                	j	450 <thread_yield+0x98>

00000000000004dc <thread_start_threading>:

void thread_start_threading(void){
 4dc:	1141                	addi	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	addi	s0,sp,16
    //TO DO
    // Save the main function's context
    if (setjmp(env_st) == 0) {
 4e4:	00001517          	auipc	a0,0x1
 4e8:	c5450513          	addi	a0,a0,-940 # 1138 <env_st>
 4ec:	00001097          	auipc	ra,0x1
 4f0:	83c080e7          	jalr	-1988(ra) # d28 <setjmp>
 4f4:	c509                	beqz	a0,4fe <thread_start_threading+0x22>
        schedule();
        dispatch();  
    } else {        // When all the threads exit, setjmp(env_st) != 0
        return;
    }
}
 4f6:	60a2                	ld	ra,8(sp)
 4f8:	6402                	ld	s0,0(sp)
 4fa:	0141                	addi	sp,sp,16
 4fc:	8082                	ret
        schedule();
 4fe:	00000097          	auipc	ra,0x0
 502:	bdc080e7          	jalr	-1060(ra) # da <schedule>
        dispatch();  
 506:	00000097          	auipc	ra,0x0
 50a:	cc2080e7          	jalr	-830(ra) # 1c8 <dispatch>
 50e:	b7e5                	j	4f6 <thread_start_threading+0x1a>

0000000000000510 <thread_register_handler>:

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
 510:	1141                	addi	sp,sp,-16
 512:	e422                	sd	s0,8(sp)
 514:	0800                	addi	s0,sp,16
    current_thread->sig_handler[signo] = handler;
 516:	0551                	addi	a0,a0,20
 518:	050e                	slli	a0,a0,0x3
 51a:	00001797          	auipc	a5,0x1
 51e:	c0e7b783          	ld	a5,-1010(a5) # 1128 <current_thread>
 522:	953e                	add	a0,a0,a5
 524:	e50c                	sd	a1,8(a0)
    // printf("Thread %d has signal %d handler registered\n", current_thread->ID, signo);
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret

000000000000052c <thread_kill>:

void thread_kill(struct thread *t, int signo){
 52c:	1141                	addi	sp,sp,-16
 52e:	e422                	sd	s0,8(sp)
 530:	0800                	addi	s0,sp,16
    //TO DO
    // printf("Thread %d is executing thread_kill for signal %d\n", t->ID, signo);
    // Mark the signal for the thread
    t->signo = signo;
 532:	0ab52c23          	sw	a1,184(a0)

    if (t->sig_handler[signo] == NULL_FUNC) {       // case: no handler for this signo
 536:	05d1                	addi	a1,a1,20
 538:	058e                	slli	a1,a1,0x3
 53a:	95aa                	add	a1,a1,a0
 53c:	6598                	ld	a4,8(a1)
 53e:	57fd                	li	a5,-1
 540:	00f70563          	beq	a4,a5,54a <thread_kill+0x1e>
        // printf("Thread %d has no handler for signal %d, it will be terminated on resume.\n", t->ID, signo);
        // Instead of calling thread_exit(), mark the function pointer to thread_exit, so that thread terminate when t resumes
        t->fp = (void (*)(void *)) thread_exit;  
    }
}
 544:	6422                	ld	s0,8(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret
        t->fp = (void (*)(void *)) thread_exit;  
 54a:	00000797          	auipc	a5,0x0
 54e:	bf278793          	addi	a5,a5,-1038 # 13c <thread_exit>
 552:	e11c                	sd	a5,0(a0)
}
 554:	bfc5                	j	544 <thread_kill+0x18>

0000000000000556 <thread_suspend>:

void thread_suspend(struct thread *t) {
    //TO DO
    // Mark the thread as suspended (0)
    t->suspended = 0;
 556:	0a052e23          	sw	zero,188(a0)
    // If the current thread suspends itself, need to call thread_yield() as asked in the HW instructions
    if (t == current_thread) {
 55a:	00001797          	auipc	a5,0x1
 55e:	bce7b783          	ld	a5,-1074(a5) # 1128 <current_thread>
 562:	00a78363          	beq	a5,a0,568 <thread_suspend+0x12>
 566:	8082                	ret
void thread_suspend(struct thread *t) {
 568:	1141                	addi	sp,sp,-16
 56a:	e406                	sd	ra,8(sp)
 56c:	e022                	sd	s0,0(sp)
 56e:	0800                	addi	s0,sp,16
        thread_yield();
 570:	00000097          	auipc	ra,0x0
 574:	e48080e7          	jalr	-440(ra) # 3b8 <thread_yield>
    }
}
 578:	60a2                	ld	ra,8(sp)
 57a:	6402                	ld	s0,0(sp)
 57c:	0141                	addi	sp,sp,16
 57e:	8082                	ret

0000000000000580 <thread_resume>:

void thread_resume(struct thread *t) {
 580:	1141                	addi	sp,sp,-16
 582:	e422                	sd	s0,8(sp)
 584:	0800                	addi	s0,sp,16
    //TO DO
    if (t->suspended == 0) {        // if the thread is suspended (suspended == 0)
 586:	0bc52783          	lw	a5,188(a0)
 58a:	e781                	bnez	a5,592 <thread_resume+0x12>
        t->suspended = -1;          // set suspended to -1 to indicate that the thread is resumed
 58c:	57fd                	li	a5,-1
 58e:	0af52e23          	sw	a5,188(a0)
    }
}
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret

0000000000000598 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 598:	1141                	addi	sp,sp,-16
 59a:	e422                	sd	s0,8(sp)
 59c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 59e:	87aa                	mv	a5,a0
 5a0:	0585                	addi	a1,a1,1
 5a2:	0785                	addi	a5,a5,1
 5a4:	fff5c703          	lbu	a4,-1(a1)
 5a8:	fee78fa3          	sb	a4,-1(a5)
 5ac:	fb75                	bnez	a4,5a0 <strcpy+0x8>
    ;
  return os;
}
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5b4:	1141                	addi	sp,sp,-16
 5b6:	e422                	sd	s0,8(sp)
 5b8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 5ba:	00054783          	lbu	a5,0(a0)
 5be:	cb91                	beqz	a5,5d2 <strcmp+0x1e>
 5c0:	0005c703          	lbu	a4,0(a1)
 5c4:	00f71763          	bne	a4,a5,5d2 <strcmp+0x1e>
    p++, q++;
 5c8:	0505                	addi	a0,a0,1
 5ca:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5cc:	00054783          	lbu	a5,0(a0)
 5d0:	fbe5                	bnez	a5,5c0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5d2:	0005c503          	lbu	a0,0(a1)
}
 5d6:	40a7853b          	subw	a0,a5,a0
 5da:	6422                	ld	s0,8(sp)
 5dc:	0141                	addi	sp,sp,16
 5de:	8082                	ret

00000000000005e0 <strlen>:

uint
strlen(const char *s)
{
 5e0:	1141                	addi	sp,sp,-16
 5e2:	e422                	sd	s0,8(sp)
 5e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5e6:	00054783          	lbu	a5,0(a0)
 5ea:	cf91                	beqz	a5,606 <strlen+0x26>
 5ec:	0505                	addi	a0,a0,1
 5ee:	87aa                	mv	a5,a0
 5f0:	4685                	li	a3,1
 5f2:	9e89                	subw	a3,a3,a0
 5f4:	00f6853b          	addw	a0,a3,a5
 5f8:	0785                	addi	a5,a5,1
 5fa:	fff7c703          	lbu	a4,-1(a5)
 5fe:	fb7d                	bnez	a4,5f4 <strlen+0x14>
    ;
  return n;
}
 600:	6422                	ld	s0,8(sp)
 602:	0141                	addi	sp,sp,16
 604:	8082                	ret
  for(n = 0; s[n]; n++)
 606:	4501                	li	a0,0
 608:	bfe5                	j	600 <strlen+0x20>

000000000000060a <memset>:

void*
memset(void *dst, int c, uint n)
{
 60a:	1141                	addi	sp,sp,-16
 60c:	e422                	sd	s0,8(sp)
 60e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 610:	ce09                	beqz	a2,62a <memset+0x20>
 612:	87aa                	mv	a5,a0
 614:	fff6071b          	addiw	a4,a2,-1
 618:	1702                	slli	a4,a4,0x20
 61a:	9301                	srli	a4,a4,0x20
 61c:	0705                	addi	a4,a4,1
 61e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 620:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 624:	0785                	addi	a5,a5,1
 626:	fee79de3          	bne	a5,a4,620 <memset+0x16>
  }
  return dst;
}
 62a:	6422                	ld	s0,8(sp)
 62c:	0141                	addi	sp,sp,16
 62e:	8082                	ret

0000000000000630 <strchr>:

char*
strchr(const char *s, char c)
{
 630:	1141                	addi	sp,sp,-16
 632:	e422                	sd	s0,8(sp)
 634:	0800                	addi	s0,sp,16
  for(; *s; s++)
 636:	00054783          	lbu	a5,0(a0)
 63a:	cb99                	beqz	a5,650 <strchr+0x20>
    if(*s == c)
 63c:	00f58763          	beq	a1,a5,64a <strchr+0x1a>
  for(; *s; s++)
 640:	0505                	addi	a0,a0,1
 642:	00054783          	lbu	a5,0(a0)
 646:	fbfd                	bnez	a5,63c <strchr+0xc>
      return (char*)s;
  return 0;
 648:	4501                	li	a0,0
}
 64a:	6422                	ld	s0,8(sp)
 64c:	0141                	addi	sp,sp,16
 64e:	8082                	ret
  return 0;
 650:	4501                	li	a0,0
 652:	bfe5                	j	64a <strchr+0x1a>

0000000000000654 <gets>:

char*
gets(char *buf, int max)
{
 654:	711d                	addi	sp,sp,-96
 656:	ec86                	sd	ra,88(sp)
 658:	e8a2                	sd	s0,80(sp)
 65a:	e4a6                	sd	s1,72(sp)
 65c:	e0ca                	sd	s2,64(sp)
 65e:	fc4e                	sd	s3,56(sp)
 660:	f852                	sd	s4,48(sp)
 662:	f456                	sd	s5,40(sp)
 664:	f05a                	sd	s6,32(sp)
 666:	ec5e                	sd	s7,24(sp)
 668:	1080                	addi	s0,sp,96
 66a:	8baa                	mv	s7,a0
 66c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 66e:	892a                	mv	s2,a0
 670:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 672:	4aa9                	li	s5,10
 674:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 676:	89a6                	mv	s3,s1
 678:	2485                	addiw	s1,s1,1
 67a:	0344d863          	bge	s1,s4,6aa <gets+0x56>
    cc = read(0, &c, 1);
 67e:	4605                	li	a2,1
 680:	faf40593          	addi	a1,s0,-81
 684:	4501                	li	a0,0
 686:	00000097          	auipc	ra,0x0
 68a:	1a0080e7          	jalr	416(ra) # 826 <read>
    if(cc < 1)
 68e:	00a05e63          	blez	a0,6aa <gets+0x56>
    buf[i++] = c;
 692:	faf44783          	lbu	a5,-81(s0)
 696:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 69a:	01578763          	beq	a5,s5,6a8 <gets+0x54>
 69e:	0905                	addi	s2,s2,1
 6a0:	fd679be3          	bne	a5,s6,676 <gets+0x22>
  for(i=0; i+1 < max; ){
 6a4:	89a6                	mv	s3,s1
 6a6:	a011                	j	6aa <gets+0x56>
 6a8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6aa:	99de                	add	s3,s3,s7
 6ac:	00098023          	sb	zero,0(s3)
  return buf;
}
 6b0:	855e                	mv	a0,s7
 6b2:	60e6                	ld	ra,88(sp)
 6b4:	6446                	ld	s0,80(sp)
 6b6:	64a6                	ld	s1,72(sp)
 6b8:	6906                	ld	s2,64(sp)
 6ba:	79e2                	ld	s3,56(sp)
 6bc:	7a42                	ld	s4,48(sp)
 6be:	7aa2                	ld	s5,40(sp)
 6c0:	7b02                	ld	s6,32(sp)
 6c2:	6be2                	ld	s7,24(sp)
 6c4:	6125                	addi	sp,sp,96
 6c6:	8082                	ret

00000000000006c8 <stat>:

int
stat(const char *n, struct stat *st)
{
 6c8:	1101                	addi	sp,sp,-32
 6ca:	ec06                	sd	ra,24(sp)
 6cc:	e822                	sd	s0,16(sp)
 6ce:	e426                	sd	s1,8(sp)
 6d0:	e04a                	sd	s2,0(sp)
 6d2:	1000                	addi	s0,sp,32
 6d4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6d6:	4581                	li	a1,0
 6d8:	00000097          	auipc	ra,0x0
 6dc:	176080e7          	jalr	374(ra) # 84e <open>
  if(fd < 0)
 6e0:	02054563          	bltz	a0,70a <stat+0x42>
 6e4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6e6:	85ca                	mv	a1,s2
 6e8:	00000097          	auipc	ra,0x0
 6ec:	17e080e7          	jalr	382(ra) # 866 <fstat>
 6f0:	892a                	mv	s2,a0
  close(fd);
 6f2:	8526                	mv	a0,s1
 6f4:	00000097          	auipc	ra,0x0
 6f8:	142080e7          	jalr	322(ra) # 836 <close>
  return r;
}
 6fc:	854a                	mv	a0,s2
 6fe:	60e2                	ld	ra,24(sp)
 700:	6442                	ld	s0,16(sp)
 702:	64a2                	ld	s1,8(sp)
 704:	6902                	ld	s2,0(sp)
 706:	6105                	addi	sp,sp,32
 708:	8082                	ret
    return -1;
 70a:	597d                	li	s2,-1
 70c:	bfc5                	j	6fc <stat+0x34>

000000000000070e <atoi>:

int
atoi(const char *s)
{
 70e:	1141                	addi	sp,sp,-16
 710:	e422                	sd	s0,8(sp)
 712:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 714:	00054603          	lbu	a2,0(a0)
 718:	fd06079b          	addiw	a5,a2,-48
 71c:	0ff7f793          	andi	a5,a5,255
 720:	4725                	li	a4,9
 722:	02f76963          	bltu	a4,a5,754 <atoi+0x46>
 726:	86aa                	mv	a3,a0
  n = 0;
 728:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 72a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 72c:	0685                	addi	a3,a3,1
 72e:	0025179b          	slliw	a5,a0,0x2
 732:	9fa9                	addw	a5,a5,a0
 734:	0017979b          	slliw	a5,a5,0x1
 738:	9fb1                	addw	a5,a5,a2
 73a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 73e:	0006c603          	lbu	a2,0(a3)
 742:	fd06071b          	addiw	a4,a2,-48
 746:	0ff77713          	andi	a4,a4,255
 74a:	fee5f1e3          	bgeu	a1,a4,72c <atoi+0x1e>
  return n;
}
 74e:	6422                	ld	s0,8(sp)
 750:	0141                	addi	sp,sp,16
 752:	8082                	ret
  n = 0;
 754:	4501                	li	a0,0
 756:	bfe5                	j	74e <atoi+0x40>

0000000000000758 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 758:	1141                	addi	sp,sp,-16
 75a:	e422                	sd	s0,8(sp)
 75c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 75e:	02b57663          	bgeu	a0,a1,78a <memmove+0x32>
    while(n-- > 0)
 762:	02c05163          	blez	a2,784 <memmove+0x2c>
 766:	fff6079b          	addiw	a5,a2,-1
 76a:	1782                	slli	a5,a5,0x20
 76c:	9381                	srli	a5,a5,0x20
 76e:	0785                	addi	a5,a5,1
 770:	97aa                	add	a5,a5,a0
  dst = vdst;
 772:	872a                	mv	a4,a0
      *dst++ = *src++;
 774:	0585                	addi	a1,a1,1
 776:	0705                	addi	a4,a4,1
 778:	fff5c683          	lbu	a3,-1(a1)
 77c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 780:	fee79ae3          	bne	a5,a4,774 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 784:	6422                	ld	s0,8(sp)
 786:	0141                	addi	sp,sp,16
 788:	8082                	ret
    dst += n;
 78a:	00c50733          	add	a4,a0,a2
    src += n;
 78e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 790:	fec05ae3          	blez	a2,784 <memmove+0x2c>
 794:	fff6079b          	addiw	a5,a2,-1
 798:	1782                	slli	a5,a5,0x20
 79a:	9381                	srli	a5,a5,0x20
 79c:	fff7c793          	not	a5,a5
 7a0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7a2:	15fd                	addi	a1,a1,-1
 7a4:	177d                	addi	a4,a4,-1
 7a6:	0005c683          	lbu	a3,0(a1)
 7aa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 7ae:	fee79ae3          	bne	a5,a4,7a2 <memmove+0x4a>
 7b2:	bfc9                	j	784 <memmove+0x2c>

00000000000007b4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 7b4:	1141                	addi	sp,sp,-16
 7b6:	e422                	sd	s0,8(sp)
 7b8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 7ba:	ca05                	beqz	a2,7ea <memcmp+0x36>
 7bc:	fff6069b          	addiw	a3,a2,-1
 7c0:	1682                	slli	a3,a3,0x20
 7c2:	9281                	srli	a3,a3,0x20
 7c4:	0685                	addi	a3,a3,1
 7c6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7c8:	00054783          	lbu	a5,0(a0)
 7cc:	0005c703          	lbu	a4,0(a1)
 7d0:	00e79863          	bne	a5,a4,7e0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7d4:	0505                	addi	a0,a0,1
    p2++;
 7d6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7d8:	fed518e3          	bne	a0,a3,7c8 <memcmp+0x14>
  }
  return 0;
 7dc:	4501                	li	a0,0
 7de:	a019                	j	7e4 <memcmp+0x30>
      return *p1 - *p2;
 7e0:	40e7853b          	subw	a0,a5,a4
}
 7e4:	6422                	ld	s0,8(sp)
 7e6:	0141                	addi	sp,sp,16
 7e8:	8082                	ret
  return 0;
 7ea:	4501                	li	a0,0
 7ec:	bfe5                	j	7e4 <memcmp+0x30>

00000000000007ee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7ee:	1141                	addi	sp,sp,-16
 7f0:	e406                	sd	ra,8(sp)
 7f2:	e022                	sd	s0,0(sp)
 7f4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7f6:	00000097          	auipc	ra,0x0
 7fa:	f62080e7          	jalr	-158(ra) # 758 <memmove>
}
 7fe:	60a2                	ld	ra,8(sp)
 800:	6402                	ld	s0,0(sp)
 802:	0141                	addi	sp,sp,16
 804:	8082                	ret

0000000000000806 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 806:	4885                	li	a7,1
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <exit>:
.global exit
exit:
 li a7, SYS_exit
 80e:	4889                	li	a7,2
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <wait>:
.global wait
wait:
 li a7, SYS_wait
 816:	488d                	li	a7,3
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 81e:	4891                	li	a7,4
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <read>:
.global read
read:
 li a7, SYS_read
 826:	4895                	li	a7,5
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <write>:
.global write
write:
 li a7, SYS_write
 82e:	48c1                	li	a7,16
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <close>:
.global close
close:
 li a7, SYS_close
 836:	48d5                	li	a7,21
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <kill>:
.global kill
kill:
 li a7, SYS_kill
 83e:	4899                	li	a7,6
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <exec>:
.global exec
exec:
 li a7, SYS_exec
 846:	489d                	li	a7,7
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <open>:
.global open
open:
 li a7, SYS_open
 84e:	48bd                	li	a7,15
 ecall
 850:	00000073          	ecall
 ret
 854:	8082                	ret

0000000000000856 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 856:	48c5                	li	a7,17
 ecall
 858:	00000073          	ecall
 ret
 85c:	8082                	ret

000000000000085e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 85e:	48c9                	li	a7,18
 ecall
 860:	00000073          	ecall
 ret
 864:	8082                	ret

0000000000000866 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 866:	48a1                	li	a7,8
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <link>:
.global link
link:
 li a7, SYS_link
 86e:	48cd                	li	a7,19
 ecall
 870:	00000073          	ecall
 ret
 874:	8082                	ret

0000000000000876 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 876:	48d1                	li	a7,20
 ecall
 878:	00000073          	ecall
 ret
 87c:	8082                	ret

000000000000087e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 87e:	48a5                	li	a7,9
 ecall
 880:	00000073          	ecall
 ret
 884:	8082                	ret

0000000000000886 <dup>:
.global dup
dup:
 li a7, SYS_dup
 886:	48a9                	li	a7,10
 ecall
 888:	00000073          	ecall
 ret
 88c:	8082                	ret

000000000000088e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 88e:	48ad                	li	a7,11
 ecall
 890:	00000073          	ecall
 ret
 894:	8082                	ret

0000000000000896 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 896:	48b1                	li	a7,12
 ecall
 898:	00000073          	ecall
 ret
 89c:	8082                	ret

000000000000089e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 89e:	48b5                	li	a7,13
 ecall
 8a0:	00000073          	ecall
 ret
 8a4:	8082                	ret

00000000000008a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8a6:	48b9                	li	a7,14
 ecall
 8a8:	00000073          	ecall
 ret
 8ac:	8082                	ret

00000000000008ae <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8ae:	1101                	addi	sp,sp,-32
 8b0:	ec06                	sd	ra,24(sp)
 8b2:	e822                	sd	s0,16(sp)
 8b4:	1000                	addi	s0,sp,32
 8b6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8ba:	4605                	li	a2,1
 8bc:	fef40593          	addi	a1,s0,-17
 8c0:	00000097          	auipc	ra,0x0
 8c4:	f6e080e7          	jalr	-146(ra) # 82e <write>
}
 8c8:	60e2                	ld	ra,24(sp)
 8ca:	6442                	ld	s0,16(sp)
 8cc:	6105                	addi	sp,sp,32
 8ce:	8082                	ret

00000000000008d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8d0:	7139                	addi	sp,sp,-64
 8d2:	fc06                	sd	ra,56(sp)
 8d4:	f822                	sd	s0,48(sp)
 8d6:	f426                	sd	s1,40(sp)
 8d8:	f04a                	sd	s2,32(sp)
 8da:	ec4e                	sd	s3,24(sp)
 8dc:	0080                	addi	s0,sp,64
 8de:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8e0:	c299                	beqz	a3,8e6 <printint+0x16>
 8e2:	0805c863          	bltz	a1,972 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8e6:	2581                	sext.w	a1,a1
  neg = 0;
 8e8:	4881                	li	a7,0
 8ea:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8ee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8f0:	2601                	sext.w	a2,a2
 8f2:	00001517          	auipc	a0,0x1
 8f6:	81e50513          	addi	a0,a0,-2018 # 1110 <digits>
 8fa:	883a                	mv	a6,a4
 8fc:	2705                	addiw	a4,a4,1
 8fe:	02c5f7bb          	remuw	a5,a1,a2
 902:	1782                	slli	a5,a5,0x20
 904:	9381                	srli	a5,a5,0x20
 906:	97aa                	add	a5,a5,a0
 908:	0007c783          	lbu	a5,0(a5)
 90c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 910:	0005879b          	sext.w	a5,a1
 914:	02c5d5bb          	divuw	a1,a1,a2
 918:	0685                	addi	a3,a3,1
 91a:	fec7f0e3          	bgeu	a5,a2,8fa <printint+0x2a>
  if(neg)
 91e:	00088b63          	beqz	a7,934 <printint+0x64>
    buf[i++] = '-';
 922:	fd040793          	addi	a5,s0,-48
 926:	973e                	add	a4,a4,a5
 928:	02d00793          	li	a5,45
 92c:	fef70823          	sb	a5,-16(a4)
 930:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 934:	02e05863          	blez	a4,964 <printint+0x94>
 938:	fc040793          	addi	a5,s0,-64
 93c:	00e78933          	add	s2,a5,a4
 940:	fff78993          	addi	s3,a5,-1
 944:	99ba                	add	s3,s3,a4
 946:	377d                	addiw	a4,a4,-1
 948:	1702                	slli	a4,a4,0x20
 94a:	9301                	srli	a4,a4,0x20
 94c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 950:	fff94583          	lbu	a1,-1(s2)
 954:	8526                	mv	a0,s1
 956:	00000097          	auipc	ra,0x0
 95a:	f58080e7          	jalr	-168(ra) # 8ae <putc>
  while(--i >= 0)
 95e:	197d                	addi	s2,s2,-1
 960:	ff3918e3          	bne	s2,s3,950 <printint+0x80>
}
 964:	70e2                	ld	ra,56(sp)
 966:	7442                	ld	s0,48(sp)
 968:	74a2                	ld	s1,40(sp)
 96a:	7902                	ld	s2,32(sp)
 96c:	69e2                	ld	s3,24(sp)
 96e:	6121                	addi	sp,sp,64
 970:	8082                	ret
    x = -xx;
 972:	40b005bb          	negw	a1,a1
    neg = 1;
 976:	4885                	li	a7,1
    x = -xx;
 978:	bf8d                	j	8ea <printint+0x1a>

000000000000097a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 97a:	7119                	addi	sp,sp,-128
 97c:	fc86                	sd	ra,120(sp)
 97e:	f8a2                	sd	s0,112(sp)
 980:	f4a6                	sd	s1,104(sp)
 982:	f0ca                	sd	s2,96(sp)
 984:	ecce                	sd	s3,88(sp)
 986:	e8d2                	sd	s4,80(sp)
 988:	e4d6                	sd	s5,72(sp)
 98a:	e0da                	sd	s6,64(sp)
 98c:	fc5e                	sd	s7,56(sp)
 98e:	f862                	sd	s8,48(sp)
 990:	f466                	sd	s9,40(sp)
 992:	f06a                	sd	s10,32(sp)
 994:	ec6e                	sd	s11,24(sp)
 996:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 998:	0005c903          	lbu	s2,0(a1)
 99c:	18090f63          	beqz	s2,b3a <vprintf+0x1c0>
 9a0:	8aaa                	mv	s5,a0
 9a2:	8b32                	mv	s6,a2
 9a4:	00158493          	addi	s1,a1,1
  state = 0;
 9a8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9aa:	02500a13          	li	s4,37
      if(c == 'd'){
 9ae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 9b2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 9b6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 9ba:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9be:	00000b97          	auipc	s7,0x0
 9c2:	752b8b93          	addi	s7,s7,1874 # 1110 <digits>
 9c6:	a839                	j	9e4 <vprintf+0x6a>
        putc(fd, c);
 9c8:	85ca                	mv	a1,s2
 9ca:	8556                	mv	a0,s5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	ee2080e7          	jalr	-286(ra) # 8ae <putc>
 9d4:	a019                	j	9da <vprintf+0x60>
    } else if(state == '%'){
 9d6:	01498f63          	beq	s3,s4,9f4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 9da:	0485                	addi	s1,s1,1
 9dc:	fff4c903          	lbu	s2,-1(s1)
 9e0:	14090d63          	beqz	s2,b3a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 9e4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 9e8:	fe0997e3          	bnez	s3,9d6 <vprintf+0x5c>
      if(c == '%'){
 9ec:	fd479ee3          	bne	a5,s4,9c8 <vprintf+0x4e>
        state = '%';
 9f0:	89be                	mv	s3,a5
 9f2:	b7e5                	j	9da <vprintf+0x60>
      if(c == 'd'){
 9f4:	05878063          	beq	a5,s8,a34 <vprintf+0xba>
      } else if(c == 'l') {
 9f8:	05978c63          	beq	a5,s9,a50 <vprintf+0xd6>
      } else if(c == 'x') {
 9fc:	07a78863          	beq	a5,s10,a6c <vprintf+0xf2>
      } else if(c == 'p') {
 a00:	09b78463          	beq	a5,s11,a88 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 a04:	07300713          	li	a4,115
 a08:	0ce78663          	beq	a5,a4,ad4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a0c:	06300713          	li	a4,99
 a10:	0ee78e63          	beq	a5,a4,b0c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 a14:	11478863          	beq	a5,s4,b24 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a18:	85d2                	mv	a1,s4
 a1a:	8556                	mv	a0,s5
 a1c:	00000097          	auipc	ra,0x0
 a20:	e92080e7          	jalr	-366(ra) # 8ae <putc>
        putc(fd, c);
 a24:	85ca                	mv	a1,s2
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	e86080e7          	jalr	-378(ra) # 8ae <putc>
      }
      state = 0;
 a30:	4981                	li	s3,0
 a32:	b765                	j	9da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 a34:	008b0913          	addi	s2,s6,8
 a38:	4685                	li	a3,1
 a3a:	4629                	li	a2,10
 a3c:	000b2583          	lw	a1,0(s6)
 a40:	8556                	mv	a0,s5
 a42:	00000097          	auipc	ra,0x0
 a46:	e8e080e7          	jalr	-370(ra) # 8d0 <printint>
 a4a:	8b4a                	mv	s6,s2
      state = 0;
 a4c:	4981                	li	s3,0
 a4e:	b771                	j	9da <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a50:	008b0913          	addi	s2,s6,8
 a54:	4681                	li	a3,0
 a56:	4629                	li	a2,10
 a58:	000b2583          	lw	a1,0(s6)
 a5c:	8556                	mv	a0,s5
 a5e:	00000097          	auipc	ra,0x0
 a62:	e72080e7          	jalr	-398(ra) # 8d0 <printint>
 a66:	8b4a                	mv	s6,s2
      state = 0;
 a68:	4981                	li	s3,0
 a6a:	bf85                	j	9da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 a6c:	008b0913          	addi	s2,s6,8
 a70:	4681                	li	a3,0
 a72:	4641                	li	a2,16
 a74:	000b2583          	lw	a1,0(s6)
 a78:	8556                	mv	a0,s5
 a7a:	00000097          	auipc	ra,0x0
 a7e:	e56080e7          	jalr	-426(ra) # 8d0 <printint>
 a82:	8b4a                	mv	s6,s2
      state = 0;
 a84:	4981                	li	s3,0
 a86:	bf91                	j	9da <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a88:	008b0793          	addi	a5,s6,8
 a8c:	f8f43423          	sd	a5,-120(s0)
 a90:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a94:	03000593          	li	a1,48
 a98:	8556                	mv	a0,s5
 a9a:	00000097          	auipc	ra,0x0
 a9e:	e14080e7          	jalr	-492(ra) # 8ae <putc>
  putc(fd, 'x');
 aa2:	85ea                	mv	a1,s10
 aa4:	8556                	mv	a0,s5
 aa6:	00000097          	auipc	ra,0x0
 aaa:	e08080e7          	jalr	-504(ra) # 8ae <putc>
 aae:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ab0:	03c9d793          	srli	a5,s3,0x3c
 ab4:	97de                	add	a5,a5,s7
 ab6:	0007c583          	lbu	a1,0(a5)
 aba:	8556                	mv	a0,s5
 abc:	00000097          	auipc	ra,0x0
 ac0:	df2080e7          	jalr	-526(ra) # 8ae <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 ac4:	0992                	slli	s3,s3,0x4
 ac6:	397d                	addiw	s2,s2,-1
 ac8:	fe0914e3          	bnez	s2,ab0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 acc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 ad0:	4981                	li	s3,0
 ad2:	b721                	j	9da <vprintf+0x60>
        s = va_arg(ap, char*);
 ad4:	008b0993          	addi	s3,s6,8
 ad8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 adc:	02090163          	beqz	s2,afe <vprintf+0x184>
        while(*s != 0){
 ae0:	00094583          	lbu	a1,0(s2)
 ae4:	c9a1                	beqz	a1,b34 <vprintf+0x1ba>
          putc(fd, *s);
 ae6:	8556                	mv	a0,s5
 ae8:	00000097          	auipc	ra,0x0
 aec:	dc6080e7          	jalr	-570(ra) # 8ae <putc>
          s++;
 af0:	0905                	addi	s2,s2,1
        while(*s != 0){
 af2:	00094583          	lbu	a1,0(s2)
 af6:	f9e5                	bnez	a1,ae6 <vprintf+0x16c>
        s = va_arg(ap, char*);
 af8:	8b4e                	mv	s6,s3
      state = 0;
 afa:	4981                	li	s3,0
 afc:	bdf9                	j	9da <vprintf+0x60>
          s = "(null)";
 afe:	00000917          	auipc	s2,0x0
 b02:	60a90913          	addi	s2,s2,1546 # 1108 <longjmp_1+0x36e>
        while(*s != 0){
 b06:	02800593          	li	a1,40
 b0a:	bff1                	j	ae6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 b0c:	008b0913          	addi	s2,s6,8
 b10:	000b4583          	lbu	a1,0(s6)
 b14:	8556                	mv	a0,s5
 b16:	00000097          	auipc	ra,0x0
 b1a:	d98080e7          	jalr	-616(ra) # 8ae <putc>
 b1e:	8b4a                	mv	s6,s2
      state = 0;
 b20:	4981                	li	s3,0
 b22:	bd65                	j	9da <vprintf+0x60>
        putc(fd, c);
 b24:	85d2                	mv	a1,s4
 b26:	8556                	mv	a0,s5
 b28:	00000097          	auipc	ra,0x0
 b2c:	d86080e7          	jalr	-634(ra) # 8ae <putc>
      state = 0;
 b30:	4981                	li	s3,0
 b32:	b565                	j	9da <vprintf+0x60>
        s = va_arg(ap, char*);
 b34:	8b4e                	mv	s6,s3
      state = 0;
 b36:	4981                	li	s3,0
 b38:	b54d                	j	9da <vprintf+0x60>
    }
  }
}
 b3a:	70e6                	ld	ra,120(sp)
 b3c:	7446                	ld	s0,112(sp)
 b3e:	74a6                	ld	s1,104(sp)
 b40:	7906                	ld	s2,96(sp)
 b42:	69e6                	ld	s3,88(sp)
 b44:	6a46                	ld	s4,80(sp)
 b46:	6aa6                	ld	s5,72(sp)
 b48:	6b06                	ld	s6,64(sp)
 b4a:	7be2                	ld	s7,56(sp)
 b4c:	7c42                	ld	s8,48(sp)
 b4e:	7ca2                	ld	s9,40(sp)
 b50:	7d02                	ld	s10,32(sp)
 b52:	6de2                	ld	s11,24(sp)
 b54:	6109                	addi	sp,sp,128
 b56:	8082                	ret

0000000000000b58 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b58:	715d                	addi	sp,sp,-80
 b5a:	ec06                	sd	ra,24(sp)
 b5c:	e822                	sd	s0,16(sp)
 b5e:	1000                	addi	s0,sp,32
 b60:	e010                	sd	a2,0(s0)
 b62:	e414                	sd	a3,8(s0)
 b64:	e818                	sd	a4,16(s0)
 b66:	ec1c                	sd	a5,24(s0)
 b68:	03043023          	sd	a6,32(s0)
 b6c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b70:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b74:	8622                	mv	a2,s0
 b76:	00000097          	auipc	ra,0x0
 b7a:	e04080e7          	jalr	-508(ra) # 97a <vprintf>
}
 b7e:	60e2                	ld	ra,24(sp)
 b80:	6442                	ld	s0,16(sp)
 b82:	6161                	addi	sp,sp,80
 b84:	8082                	ret

0000000000000b86 <printf>:

void
printf(const char *fmt, ...)
{
 b86:	711d                	addi	sp,sp,-96
 b88:	ec06                	sd	ra,24(sp)
 b8a:	e822                	sd	s0,16(sp)
 b8c:	1000                	addi	s0,sp,32
 b8e:	e40c                	sd	a1,8(s0)
 b90:	e810                	sd	a2,16(s0)
 b92:	ec14                	sd	a3,24(s0)
 b94:	f018                	sd	a4,32(s0)
 b96:	f41c                	sd	a5,40(s0)
 b98:	03043823          	sd	a6,48(s0)
 b9c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ba0:	00840613          	addi	a2,s0,8
 ba4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ba8:	85aa                	mv	a1,a0
 baa:	4505                	li	a0,1
 bac:	00000097          	auipc	ra,0x0
 bb0:	dce080e7          	jalr	-562(ra) # 97a <vprintf>
}
 bb4:	60e2                	ld	ra,24(sp)
 bb6:	6442                	ld	s0,16(sp)
 bb8:	6125                	addi	sp,sp,96
 bba:	8082                	ret

0000000000000bbc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bbc:	1141                	addi	sp,sp,-16
 bbe:	e422                	sd	s0,8(sp)
 bc0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bc2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc6:	00000797          	auipc	a5,0x0
 bca:	56a7b783          	ld	a5,1386(a5) # 1130 <freep>
 bce:	a805                	j	bfe <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bd0:	4618                	lw	a4,8(a2)
 bd2:	9db9                	addw	a1,a1,a4
 bd4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bd8:	6398                	ld	a4,0(a5)
 bda:	6318                	ld	a4,0(a4)
 bdc:	fee53823          	sd	a4,-16(a0)
 be0:	a091                	j	c24 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 be2:	ff852703          	lw	a4,-8(a0)
 be6:	9e39                	addw	a2,a2,a4
 be8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 bea:	ff053703          	ld	a4,-16(a0)
 bee:	e398                	sd	a4,0(a5)
 bf0:	a099                	j	c36 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bf2:	6398                	ld	a4,0(a5)
 bf4:	00e7e463          	bltu	a5,a4,bfc <free+0x40>
 bf8:	00e6ea63          	bltu	a3,a4,c0c <free+0x50>
{
 bfc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bfe:	fed7fae3          	bgeu	a5,a3,bf2 <free+0x36>
 c02:	6398                	ld	a4,0(a5)
 c04:	00e6e463          	bltu	a3,a4,c0c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c08:	fee7eae3          	bltu	a5,a4,bfc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 c0c:	ff852583          	lw	a1,-8(a0)
 c10:	6390                	ld	a2,0(a5)
 c12:	02059713          	slli	a4,a1,0x20
 c16:	9301                	srli	a4,a4,0x20
 c18:	0712                	slli	a4,a4,0x4
 c1a:	9736                	add	a4,a4,a3
 c1c:	fae60ae3          	beq	a2,a4,bd0 <free+0x14>
    bp->s.ptr = p->s.ptr;
 c20:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c24:	4790                	lw	a2,8(a5)
 c26:	02061713          	slli	a4,a2,0x20
 c2a:	9301                	srli	a4,a4,0x20
 c2c:	0712                	slli	a4,a4,0x4
 c2e:	973e                	add	a4,a4,a5
 c30:	fae689e3          	beq	a3,a4,be2 <free+0x26>
  } else
    p->s.ptr = bp;
 c34:	e394                	sd	a3,0(a5)
  freep = p;
 c36:	00000717          	auipc	a4,0x0
 c3a:	4ef73d23          	sd	a5,1274(a4) # 1130 <freep>
}
 c3e:	6422                	ld	s0,8(sp)
 c40:	0141                	addi	sp,sp,16
 c42:	8082                	ret

0000000000000c44 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c44:	7139                	addi	sp,sp,-64
 c46:	fc06                	sd	ra,56(sp)
 c48:	f822                	sd	s0,48(sp)
 c4a:	f426                	sd	s1,40(sp)
 c4c:	f04a                	sd	s2,32(sp)
 c4e:	ec4e                	sd	s3,24(sp)
 c50:	e852                	sd	s4,16(sp)
 c52:	e456                	sd	s5,8(sp)
 c54:	e05a                	sd	s6,0(sp)
 c56:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c58:	02051493          	slli	s1,a0,0x20
 c5c:	9081                	srli	s1,s1,0x20
 c5e:	04bd                	addi	s1,s1,15
 c60:	8091                	srli	s1,s1,0x4
 c62:	0014899b          	addiw	s3,s1,1
 c66:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c68:	00000517          	auipc	a0,0x0
 c6c:	4c853503          	ld	a0,1224(a0) # 1130 <freep>
 c70:	c515                	beqz	a0,c9c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c72:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c74:	4798                	lw	a4,8(a5)
 c76:	02977f63          	bgeu	a4,s1,cb4 <malloc+0x70>
 c7a:	8a4e                	mv	s4,s3
 c7c:	0009871b          	sext.w	a4,s3
 c80:	6685                	lui	a3,0x1
 c82:	00d77363          	bgeu	a4,a3,c88 <malloc+0x44>
 c86:	6a05                	lui	s4,0x1
 c88:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c8c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c90:	00000917          	auipc	s2,0x0
 c94:	4a090913          	addi	s2,s2,1184 # 1130 <freep>
  if(p == (char*)-1)
 c98:	5afd                	li	s5,-1
 c9a:	a88d                	j	d0c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 c9c:	00000797          	auipc	a5,0x0
 ca0:	50c78793          	addi	a5,a5,1292 # 11a8 <base>
 ca4:	00000717          	auipc	a4,0x0
 ca8:	48f73623          	sd	a5,1164(a4) # 1130 <freep>
 cac:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cae:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cb2:	b7e1                	j	c7a <malloc+0x36>
      if(p->s.size == nunits)
 cb4:	02e48b63          	beq	s1,a4,cea <malloc+0xa6>
        p->s.size -= nunits;
 cb8:	4137073b          	subw	a4,a4,s3
 cbc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cbe:	1702                	slli	a4,a4,0x20
 cc0:	9301                	srli	a4,a4,0x20
 cc2:	0712                	slli	a4,a4,0x4
 cc4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cc6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cca:	00000717          	auipc	a4,0x0
 cce:	46a73323          	sd	a0,1126(a4) # 1130 <freep>
      return (void*)(p + 1);
 cd2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cd6:	70e2                	ld	ra,56(sp)
 cd8:	7442                	ld	s0,48(sp)
 cda:	74a2                	ld	s1,40(sp)
 cdc:	7902                	ld	s2,32(sp)
 cde:	69e2                	ld	s3,24(sp)
 ce0:	6a42                	ld	s4,16(sp)
 ce2:	6aa2                	ld	s5,8(sp)
 ce4:	6b02                	ld	s6,0(sp)
 ce6:	6121                	addi	sp,sp,64
 ce8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 cea:	6398                	ld	a4,0(a5)
 cec:	e118                	sd	a4,0(a0)
 cee:	bff1                	j	cca <malloc+0x86>
  hp->s.size = nu;
 cf0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cf4:	0541                	addi	a0,a0,16
 cf6:	00000097          	auipc	ra,0x0
 cfa:	ec6080e7          	jalr	-314(ra) # bbc <free>
  return freep;
 cfe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d02:	d971                	beqz	a0,cd6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d04:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d06:	4798                	lw	a4,8(a5)
 d08:	fa9776e3          	bgeu	a4,s1,cb4 <malloc+0x70>
    if(p == freep)
 d0c:	00093703          	ld	a4,0(s2)
 d10:	853e                	mv	a0,a5
 d12:	fef719e3          	bne	a4,a5,d04 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 d16:	8552                	mv	a0,s4
 d18:	00000097          	auipc	ra,0x0
 d1c:	b7e080e7          	jalr	-1154(ra) # 896 <sbrk>
  if(p == (char*)-1)
 d20:	fd5518e3          	bne	a0,s5,cf0 <malloc+0xac>
        return 0;
 d24:	4501                	li	a0,0
 d26:	bf45                	j	cd6 <malloc+0x92>

0000000000000d28 <setjmp>:
 d28:	e100                	sd	s0,0(a0)
 d2a:	e504                	sd	s1,8(a0)
 d2c:	01253823          	sd	s2,16(a0)
 d30:	01353c23          	sd	s3,24(a0)
 d34:	03453023          	sd	s4,32(a0)
 d38:	03553423          	sd	s5,40(a0)
 d3c:	03653823          	sd	s6,48(a0)
 d40:	03753c23          	sd	s7,56(a0)
 d44:	05853023          	sd	s8,64(a0)
 d48:	05953423          	sd	s9,72(a0)
 d4c:	05a53823          	sd	s10,80(a0)
 d50:	05b53c23          	sd	s11,88(a0)
 d54:	06153023          	sd	ra,96(a0)
 d58:	06253423          	sd	sp,104(a0)
 d5c:	4501                	li	a0,0
 d5e:	8082                	ret

0000000000000d60 <longjmp>:
 d60:	6100                	ld	s0,0(a0)
 d62:	6504                	ld	s1,8(a0)
 d64:	01053903          	ld	s2,16(a0)
 d68:	01853983          	ld	s3,24(a0)
 d6c:	02053a03          	ld	s4,32(a0)
 d70:	02853a83          	ld	s5,40(a0)
 d74:	03053b03          	ld	s6,48(a0)
 d78:	03853b83          	ld	s7,56(a0)
 d7c:	04053c03          	ld	s8,64(a0)
 d80:	04853c83          	ld	s9,72(a0)
 d84:	05053d03          	ld	s10,80(a0)
 d88:	05853d83          	ld	s11,88(a0)
 d8c:	06053083          	ld	ra,96(a0)
 d90:	06853103          	ld	sp,104(a0)
 d94:	c199                	beqz	a1,d9a <longjmp_1>
 d96:	852e                	mv	a0,a1
 d98:	8082                	ret

0000000000000d9a <longjmp_1>:
 d9a:	4505                	li	a0,1
 d9c:	8082                	ret
