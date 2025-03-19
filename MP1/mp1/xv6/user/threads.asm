
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
   a:	16a53503          	ld	a0,362(a0) # 1170 <current_thread>
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
  2e:	c20080e7          	jalr	-992(ra) # c4a <malloc>
  32:	84aa                	mv	s1,a0
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  34:	6505                	lui	a0,0x1
  36:	80050513          	addi	a0,a0,-2048 # 800 <memcpy+0xc>
  3a:	00001097          	auipc	ra,0x1
  3e:	c10080e7          	jalr	-1008(ra) # c4a <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f; 
  42:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  46:	0124b423          	sd	s2,8(s1)

    t->ID  = id;
  4a:	00001717          	auipc	a4,0x1
  4e:	12270713          	addi	a4,a4,290 # 116c <id>
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
  96:	0de7b783          	ld	a5,222(a5) # 1170 <current_thread>
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
  c4:	0aa7b823          	sd	a0,176(a5) # 1170 <current_thread>
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
        }
    }
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
  e8:	08c48493          	addi	s1,s1,140 # 1170 <current_thread>
  ec:	609c                	ld	a5,0(s1)
  ee:	0947a583          	lw	a1,148(a5)
  f2:	00001517          	auipc	a0,0x1
  f6:	cb650513          	addi	a0,a0,-842 # da8 <longjmp_1+0x8>
  fa:	00001097          	auipc	ra,0x1
  fe:	a92080e7          	jalr	-1390(ra) # b8c <printf>
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
 11a:	04f73d23          	sd	a5,90(a4) # 1170 <current_thread>
    }
    printf("scheduled to thread %d\n", current_thread->ID);
 11e:	0947a583          	lw	a1,148(a5)
 122:	00001517          	auipc	a0,0x1
 126:	cb650513          	addi	a0,a0,-842 # dd8 <longjmp_1+0x38>
 12a:	00001097          	auipc	ra,0x1
 12e:	a62080e7          	jalr	-1438(ra) # b8c <printf>
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
 14a:	caa50513          	addi	a0,a0,-854 # df0 <longjmp_1+0x50>
 14e:	00001097          	auipc	ra,0x1
 152:	a3e080e7          	jalr	-1474(ra) # b8c <printf>
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
 156:	00001497          	auipc	s1,0x1
 15a:	01a4b483          	ld	s1,26(s1) # 1170 <current_thread>
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
 17a:	a4c080e7          	jalr	-1460(ra) # bc2 <free>
        free(t);
 17e:	8526                	mv	a0,s1
 180:	00001097          	auipc	ra,0x1
 184:	a42080e7          	jalr	-1470(ra) # bc2 <free>

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
 1a0:	a26080e7          	jalr	-1498(ra) # bc2 <free>
        free(current_thread);
 1a4:	00001517          	auipc	a0,0x1
 1a8:	fcc53503          	ld	a0,-52(a0) # 1170 <current_thread>
 1ac:	00001097          	auipc	ra,0x1
 1b0:	a16080e7          	jalr	-1514(ra) # bc2 <free>
        longjmp(env_st, 1);
 1b4:	4585                	li	a1,1
 1b6:	00001517          	auipc	a0,0x1
 1ba:	fca50513          	addi	a0,a0,-54 # 1180 <env_st>
 1be:	00001097          	auipc	ra,0x1
 1c2:	ba8080e7          	jalr	-1112(ra) # d66 <longjmp>
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
 1d2:	00001717          	auipc	a4,0x1
 1d6:	f9e73703          	ld	a4,-98(a4) # 1170 <current_thread>
 1da:	84ba                	mv	s1,a4
 1dc:	fce43c23          	sd	a4,-40(s0)
    printf("\n---------------------------------\n");
 1e0:	00001517          	auipc	a0,0x1
 1e4:	c2050513          	addi	a0,a0,-992 # e00 <longjmp_1+0x60>
 1e8:	00001097          	auipc	ra,0x1
 1ec:	9a4080e7          	jalr	-1628(ra) # b8c <printf>
    printf("Thread %d is being dispatched (buf_set=%d, handler_buf_set=%d, signo=%d)\n", 
 1f0:	0b84a703          	lw	a4,184(s1)
 1f4:	1304a683          	lw	a3,304(s1)
 1f8:	0904a603          	lw	a2,144(s1)
 1fc:	0944a583          	lw	a1,148(s1)
 200:	00001517          	auipc	a0,0x1
 204:	c2850513          	addi	a0,a0,-984 # e28 <longjmp_1+0x88>
 208:	00001097          	auipc	ra,0x1
 20c:	984080e7          	jalr	-1660(ra) # b8c <printf>
    if (t->signo != -1 && t->handler_buf_set == 1) {
 210:	0b84a583          	lw	a1,184(s1)
 214:	57fd                	li	a5,-1
 216:	12f58b63          	beq	a1,a5,34c <dispatch+0x184>
 21a:	1304a703          	lw	a4,304(s1)
 21e:	4785                	li	a5,1
 220:	0af70d63          	beq	a4,a5,2da <dispatch+0x112>
        printf("Thread has pending signal %d\n", t->signo);
 224:	00001517          	auipc	a0,0x1
 228:	c8c50513          	addi	a0,a0,-884 # eb0 <longjmp_1+0x110>
 22c:	00001097          	auipc	ra,0x1
 230:	960080e7          	jalr	-1696(ra) # b8c <printf>
        if (t->sig_handler[t->signo] != NULL_FUNC) {
 234:	fd843483          	ld	s1,-40(s0)
 238:	0b84a583          	lw	a1,184(s1)
 23c:	fcb43823          	sd	a1,-48(s0)
 240:	01458793          	addi	a5,a1,20
 244:	078e                	slli	a5,a5,0x3
 246:	97a6                	add	a5,a5,s1
 248:	679c                	ld	a5,8(a5)
 24a:	873e                	mv	a4,a5
 24c:	fcf43423          	sd	a5,-56(s0)
 250:	57fd                	li	a5,-1
 252:	0cf70e63          	beq	a4,a5,32e <dispatch+0x166>
            printf("First time handling signal %d\n", sig);
 256:	00001517          	auipc	a0,0x1
 25a:	c7a50513          	addi	a0,a0,-902 # ed0 <longjmp_1+0x130>
 25e:	00001097          	auipc	ra,0x1
 262:	92e080e7          	jalr	-1746(ra) # b8c <printf>
            if (setjmp(t->env) == 0) {
 266:	02048513          	addi	a0,s1,32
 26a:	00001097          	auipc	ra,0x1
 26e:	ac4080e7          	jalr	-1340(ra) # d2e <setjmp>
 272:	14051b63          	bnez	a0,3c8 <dispatch+0x200>
                printf("Executing signal handler\n");
 276:	00001517          	auipc	a0,0x1
 27a:	c7a50513          	addi	a0,a0,-902 # ef0 <longjmp_1+0x150>
 27e:	00001097          	auipc	ra,0x1
 282:	90e080e7          	jalr	-1778(ra) # b8c <printf>
                t->handler_buf_set = 1;  // Mark that we're in a handler
 286:	4785                	li	a5,1
 288:	fd843483          	ld	s1,-40(s0)
 28c:	12f4a823          	sw	a5,304(s1)
                handler(sig);
 290:	fd043503          	ld	a0,-48(s0)
 294:	fc843783          	ld	a5,-56(s0)
 298:	9782                	jalr	a5
                printf("Handler returned normally\n");
 29a:	00001517          	auipc	a0,0x1
 29e:	c7650513          	addi	a0,a0,-906 # f10 <longjmp_1+0x170>
 2a2:	00001097          	auipc	ra,0x1
 2a6:	8ea080e7          	jalr	-1814(ra) # b8c <printf>
                t->signo = -1;  // Clear the signal
 2aa:	57fd                	li	a5,-1
 2ac:	0af4ac23          	sw	a5,184(s1)
                t->handler_buf_set = 0;  // Reset handler flag
 2b0:	1204a823          	sw	zero,304(s1)
                if (t->buf_set) {
 2b4:	0904a783          	lw	a5,144(s1)
 2b8:	c7b1                	beqz	a5,304 <dispatch+0x13c>
                    printf("Resuming normal thread execution\n");
 2ba:	00001517          	auipc	a0,0x1
 2be:	c7650513          	addi	a0,a0,-906 # f30 <longjmp_1+0x190>
 2c2:	00001097          	auipc	ra,0x1
 2c6:	8ca080e7          	jalr	-1846(ra) # b8c <printf>
                    longjmp(t->env, 1);
 2ca:	4585                	li	a1,1
 2cc:	02048513          	addi	a0,s1,32
 2d0:	00001097          	auipc	ra,0x1
 2d4:	a96080e7          	jalr	-1386(ra) # d66 <longjmp>
 2d8:	a8c5                	j	3c8 <dispatch+0x200>
        printf("Resuming signal handler for thread %d (signal %d)\n", t->ID, t->signo);
 2da:	862e                	mv	a2,a1
 2dc:	fd843483          	ld	s1,-40(s0)
 2e0:	0944a583          	lw	a1,148(s1)
 2e4:	00001517          	auipc	a0,0x1
 2e8:	b9450513          	addi	a0,a0,-1132 # e78 <longjmp_1+0xd8>
 2ec:	00001097          	auipc	ra,0x1
 2f0:	8a0080e7          	jalr	-1888(ra) # b8c <printf>
        longjmp(t->handler_env, 1);
 2f4:	4585                	li	a1,1
 2f6:	0c048513          	addi	a0,s1,192
 2fa:	00001097          	auipc	ra,0x1
 2fe:	a6c080e7          	jalr	-1428(ra) # d66 <longjmp>
 302:	a0d9                	j	3c8 <dispatch+0x200>
                    printf("Starting thread function after handler\n");
 304:	00001517          	auipc	a0,0x1
 308:	c5450513          	addi	a0,a0,-940 # f58 <longjmp_1+0x1b8>
 30c:	00001097          	auipc	ra,0x1
 310:	880080e7          	jalr	-1920(ra) # b8c <printf>
                    t->buf_set = 1;
 314:	4785                	li	a5,1
 316:	fd843703          	ld	a4,-40(s0)
 31a:	08f72823          	sw	a5,144(a4)
                    t->fp(t->arg);
 31e:	631c                	ld	a5,0(a4)
 320:	6708                	ld	a0,8(a4)
 322:	9782                	jalr	a5
                    thread_exit();
 324:	00000097          	auipc	ra,0x0
 328:	e18080e7          	jalr	-488(ra) # 13c <thread_exit>
 32c:	a871                	j	3c8 <dispatch+0x200>
            printf("No handler for signal %d, exiting thread\n", t->signo);
 32e:	fd043583          	ld	a1,-48(s0)
 332:	00001517          	auipc	a0,0x1
 336:	c4e50513          	addi	a0,a0,-946 # f80 <longjmp_1+0x1e0>
 33a:	00001097          	auipc	ra,0x1
 33e:	852080e7          	jalr	-1966(ra) # b8c <printf>
            thread_exit();
 342:	00000097          	auipc	ra,0x0
 346:	dfa080e7          	jalr	-518(ra) # 13c <thread_exit>
 34a:	a8bd                	j	3c8 <dispatch+0x200>
        if (t->buf_set == 0) {
 34c:	fd843483          	ld	s1,-40(s0)
 350:	0904a783          	lw	a5,144(s1)
 354:	eba9                	bnez	a5,3a6 <dispatch+0x1de>
            printf("Starting thread for the first time\n");
 356:	00001517          	auipc	a0,0x1
 35a:	c5a50513          	addi	a0,a0,-934 # fb0 <longjmp_1+0x210>
 35e:	00001097          	auipc	ra,0x1
 362:	82e080e7          	jalr	-2002(ra) # b8c <printf>
            t->buf_set = 1;
 366:	4785                	li	a5,1
 368:	08f4a823          	sw	a5,144(s1)
            if (setjmp(t->env) == 0) {
 36c:	02048513          	addi	a0,s1,32
 370:	00001097          	auipc	ra,0x1
 374:	9be080e7          	jalr	-1602(ra) # d2e <setjmp>
 378:	c919                	beqz	a0,38e <dispatch+0x1c6>
                t->fp(t->arg);
 37a:	fd843703          	ld	a4,-40(s0)
 37e:	631c                	ld	a5,0(a4)
 380:	6708                	ld	a0,8(a4)
 382:	9782                	jalr	a5
                thread_exit();
 384:	00000097          	auipc	ra,0x0
 388:	db8080e7          	jalr	-584(ra) # 13c <thread_exit>
 38c:	a835                	j	3c8 <dispatch+0x200>
                t->env->sp = (unsigned long)t->stack_p;
 38e:	fd843703          	ld	a4,-40(s0)
 392:	6f1c                	ld	a5,24(a4)
 394:	e75c                	sd	a5,136(a4)
                longjmp(t->env, 1);
 396:	4585                	li	a1,1
 398:	02070513          	addi	a0,a4,32
 39c:	00001097          	auipc	ra,0x1
 3a0:	9ca080e7          	jalr	-1590(ra) # d66 <longjmp>
 3a4:	a015                	j	3c8 <dispatch+0x200>
            printf("Resuming normal thread execution\n");
 3a6:	00001517          	auipc	a0,0x1
 3aa:	b8a50513          	addi	a0,a0,-1142 # f30 <longjmp_1+0x190>
 3ae:	00000097          	auipc	ra,0x0
 3b2:	7de080e7          	jalr	2014(ra) # b8c <printf>
            longjmp(t->env, 1);
 3b6:	4585                	li	a1,1
 3b8:	fd843783          	ld	a5,-40(s0)
 3bc:	02078513          	addi	a0,a5,32
 3c0:	00001097          	auipc	ra,0x1
 3c4:	9a6080e7          	jalr	-1626(ra) # d66 <longjmp>
}
 3c8:	70e2                	ld	ra,56(sp)
 3ca:	7442                	ld	s0,48(sp)
 3cc:	74a2                	ld	s1,40(sp)
 3ce:	6121                	addi	sp,sp,64
 3d0:	8082                	ret

00000000000003d2 <thread_yield>:
void thread_yield(void) {
 3d2:	1101                	addi	sp,sp,-32
 3d4:	ec06                	sd	ra,24(sp)
 3d6:	e822                	sd	s0,16(sp)
 3d8:	e426                	sd	s1,8(sp)
 3da:	1000                	addi	s0,sp,32
    struct thread *t = current_thread;
 3dc:	00001497          	auipc	s1,0x1
 3e0:	d944b483          	ld	s1,-620(s1) # 1170 <current_thread>
    if (t->signo != -1 && t->handler_buf_set == 1) {
 3e4:	0b84a603          	lw	a2,184(s1)
 3e8:	57fd                	li	a5,-1
 3ea:	00f60763          	beq	a2,a5,3f8 <thread_yield+0x26>
 3ee:	1304a703          	lw	a4,304(s1)
 3f2:	4785                	li	a5,1
 3f4:	04f70063          	beq	a4,a5,434 <thread_yield+0x62>
        printf("Thread %d yielding from normal execution\n", t->ID);
 3f8:	0944a583          	lw	a1,148(s1)
 3fc:	00001517          	auipc	a0,0x1
 400:	c9c50513          	addi	a0,a0,-868 # 1098 <longjmp_1+0x2f8>
 404:	00000097          	auipc	ra,0x0
 408:	788080e7          	jalr	1928(ra) # b8c <printf>
        if (setjmp(t->env) == 0) {
 40c:	02048513          	addi	a0,s1,32
 410:	00001097          	auipc	ra,0x1
 414:	91e080e7          	jalr	-1762(ra) # d2e <setjmp>
 418:	c941                	beqz	a0,4a8 <thread_yield+0xd6>
            printf("Resumed normal execution after yield\n");
 41a:	00001517          	auipc	a0,0x1
 41e:	d0e50513          	addi	a0,a0,-754 # 1128 <longjmp_1+0x388>
 422:	00000097          	auipc	ra,0x0
 426:	76a080e7          	jalr	1898(ra) # b8c <printf>
}
 42a:	60e2                	ld	ra,24(sp)
 42c:	6442                	ld	s0,16(sp)
 42e:	64a2                	ld	s1,8(sp)
 430:	6105                	addi	sp,sp,32
 432:	8082                	ret
        printf("Thread %d yielding from signal handler (signal %d)\n", t->ID, t->signo);
 434:	0944a583          	lw	a1,148(s1)
 438:	00001517          	auipc	a0,0x1
 43c:	ba050513          	addi	a0,a0,-1120 # fd8 <longjmp_1+0x238>
 440:	00000097          	auipc	ra,0x0
 444:	74c080e7          	jalr	1868(ra) # b8c <printf>
        t->handler_env->sp = (unsigned long)t->stack_p;
 448:	6c9c                	ld	a5,24(s1)
 44a:	12f4b423          	sd	a5,296(s1)
        if (setjmp(t->handler_env) == 0) {
 44e:	0c048513          	addi	a0,s1,192
 452:	00001097          	auipc	ra,0x1
 456:	8dc080e7          	jalr	-1828(ra) # d2e <setjmp>
 45a:	c911                	beqz	a0,46e <thread_yield+0x9c>
            printf("Resumed handler execution after yield\n");
 45c:	00001517          	auipc	a0,0x1
 460:	c1450513          	addi	a0,a0,-1004 # 1070 <longjmp_1+0x2d0>
 464:	00000097          	auipc	ra,0x0
 468:	728080e7          	jalr	1832(ra) # b8c <printf>
 46c:	bf7d                	j	42a <thread_yield+0x58>
            printf("Saved handler context, now scheduling\n");
 46e:	00001517          	auipc	a0,0x1
 472:	ba250513          	addi	a0,a0,-1118 # 1010 <longjmp_1+0x270>
 476:	00000097          	auipc	ra,0x0
 47a:	716080e7          	jalr	1814(ra) # b8c <printf>
            schedule();
 47e:	00000097          	auipc	ra,0x0
 482:	c5c080e7          	jalr	-932(ra) # da <schedule>
            dispatch();
 486:	00000097          	auipc	ra,0x0
 48a:	d42080e7          	jalr	-702(ra) # 1c8 <dispatch>
            printf("ERROR: Returned from dispatch in handler context\n");
 48e:	00001517          	auipc	a0,0x1
 492:	baa50513          	addi	a0,a0,-1110 # 1038 <longjmp_1+0x298>
 496:	00000097          	auipc	ra,0x0
 49a:	6f6080e7          	jalr	1782(ra) # b8c <printf>
            exit(1);
 49e:	4505                	li	a0,1
 4a0:	00000097          	auipc	ra,0x0
 4a4:	374080e7          	jalr	884(ra) # 814 <exit>
            printf("Saved normal context, now scheduling\n");
 4a8:	00001517          	auipc	a0,0x1
 4ac:	c2050513          	addi	a0,a0,-992 # 10c8 <longjmp_1+0x328>
 4b0:	00000097          	auipc	ra,0x0
 4b4:	6dc080e7          	jalr	1756(ra) # b8c <printf>
            schedule();
 4b8:	00000097          	auipc	ra,0x0
 4bc:	c22080e7          	jalr	-990(ra) # da <schedule>
            dispatch();
 4c0:	00000097          	auipc	ra,0x0
 4c4:	d08080e7          	jalr	-760(ra) # 1c8 <dispatch>
            printf("ERROR: Returned from dispatch in normal context\n");
 4c8:	00001517          	auipc	a0,0x1
 4cc:	c2850513          	addi	a0,a0,-984 # 10f0 <longjmp_1+0x350>
 4d0:	00000097          	auipc	ra,0x0
 4d4:	6bc080e7          	jalr	1724(ra) # b8c <printf>
            exit(1);
 4d8:	4505                	li	a0,1
 4da:	00000097          	auipc	ra,0x0
 4de:	33a080e7          	jalr	826(ra) # 814 <exit>

00000000000004e2 <thread_start_threading>:

void thread_start_threading(void){
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e406                	sd	ra,8(sp)
 4e6:	e022                	sd	s0,0(sp)
 4e8:	0800                	addi	s0,sp,16
    //TO DO
    // Save the main function's context
    if (setjmp(env_st) == 0) {
 4ea:	00001517          	auipc	a0,0x1
 4ee:	c9650513          	addi	a0,a0,-874 # 1180 <env_st>
 4f2:	00001097          	auipc	ra,0x1
 4f6:	83c080e7          	jalr	-1988(ra) # d2e <setjmp>
 4fa:	c509                	beqz	a0,504 <thread_start_threading+0x22>
        schedule();
        dispatch();  
    } else {        // When all the threads exit, setjmp(env_st) != 0
        return;
    }
}
 4fc:	60a2                	ld	ra,8(sp)
 4fe:	6402                	ld	s0,0(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret
        schedule();
 504:	00000097          	auipc	ra,0x0
 508:	bd6080e7          	jalr	-1066(ra) # da <schedule>
        dispatch();  
 50c:	00000097          	auipc	ra,0x0
 510:	cbc080e7          	jalr	-836(ra) # 1c8 <dispatch>
 514:	b7e5                	j	4fc <thread_start_threading+0x1a>

0000000000000516 <thread_register_handler>:

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
 516:	1141                	addi	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	addi	s0,sp,16
    current_thread->sig_handler[signo] = handler;
 51c:	0551                	addi	a0,a0,20
 51e:	050e                	slli	a0,a0,0x3
 520:	00001797          	auipc	a5,0x1
 524:	c507b783          	ld	a5,-944(a5) # 1170 <current_thread>
 528:	953e                	add	a0,a0,a5
 52a:	e50c                	sd	a1,8(a0)
    // printf("Thread %d has signal %d handler registered\n", current_thread->ID, signo);
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret

0000000000000532 <thread_kill>:

void thread_kill(struct thread *t, int signo){
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
    //TO DO
    // printf("Thread %d is executing thread_kill for signal %d\n", t->ID, signo);
    // Mark the signal for the thread
    t->signo = signo;
 538:	0ab52c23          	sw	a1,184(a0)

    if (t->sig_handler[signo] == NULL_FUNC) {       // case: no handler for this signo
 53c:	05d1                	addi	a1,a1,20
 53e:	058e                	slli	a1,a1,0x3
 540:	95aa                	add	a1,a1,a0
 542:	6598                	ld	a4,8(a1)
 544:	57fd                	li	a5,-1
 546:	00f70563          	beq	a4,a5,550 <thread_kill+0x1e>
        // printf("Thread %d has no handler for signal %d, it will be terminated on resume.\n", t->ID, signo);
        // Instead of calling thread_exit(), mark the function pointer to thread_exit, so that thread terminate when t resumes
        t->fp = (void (*)(void *)) thread_exit;  
    }
}
 54a:	6422                	ld	s0,8(sp)
 54c:	0141                	addi	sp,sp,16
 54e:	8082                	ret
        t->fp = (void (*)(void *)) thread_exit;  
 550:	00000797          	auipc	a5,0x0
 554:	bec78793          	addi	a5,a5,-1044 # 13c <thread_exit>
 558:	e11c                	sd	a5,0(a0)
}
 55a:	bfc5                	j	54a <thread_kill+0x18>

000000000000055c <thread_suspend>:

void thread_suspend(struct thread *t) {
    //TO DO
    // Mark the thread as suspended (0)
    t->suspended = 0;
 55c:	0a052e23          	sw	zero,188(a0)
    // If the current thread suspends itself, need to call thread_yield() as asked in the HW instructions
    if (t == current_thread) {
 560:	00001797          	auipc	a5,0x1
 564:	c107b783          	ld	a5,-1008(a5) # 1170 <current_thread>
 568:	00a78363          	beq	a5,a0,56e <thread_suspend+0x12>
 56c:	8082                	ret
void thread_suspend(struct thread *t) {
 56e:	1141                	addi	sp,sp,-16
 570:	e406                	sd	ra,8(sp)
 572:	e022                	sd	s0,0(sp)
 574:	0800                	addi	s0,sp,16
        thread_yield();
 576:	00000097          	auipc	ra,0x0
 57a:	e5c080e7          	jalr	-420(ra) # 3d2 <thread_yield>
    }
}
 57e:	60a2                	ld	ra,8(sp)
 580:	6402                	ld	s0,0(sp)
 582:	0141                	addi	sp,sp,16
 584:	8082                	ret

0000000000000586 <thread_resume>:

void thread_resume(struct thread *t) {
 586:	1141                	addi	sp,sp,-16
 588:	e422                	sd	s0,8(sp)
 58a:	0800                	addi	s0,sp,16
    //TO DO
    if (t->suspended == 0) {        // if the thread is suspended (suspended == 0)
 58c:	0bc52783          	lw	a5,188(a0)
 590:	e781                	bnez	a5,598 <thread_resume+0x12>
        t->suspended = -1;          // set suspended to -1 to indicate that the thread is resumed
 592:	57fd                	li	a5,-1
 594:	0af52e23          	sw	a5,188(a0)
    }
}
 598:	6422                	ld	s0,8(sp)
 59a:	0141                	addi	sp,sp,16
 59c:	8082                	ret

000000000000059e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 59e:	1141                	addi	sp,sp,-16
 5a0:	e422                	sd	s0,8(sp)
 5a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5a4:	87aa                	mv	a5,a0
 5a6:	0585                	addi	a1,a1,1
 5a8:	0785                	addi	a5,a5,1
 5aa:	fff5c703          	lbu	a4,-1(a1)
 5ae:	fee78fa3          	sb	a4,-1(a5)
 5b2:	fb75                	bnez	a4,5a6 <strcpy+0x8>
    ;
  return os;
}
 5b4:	6422                	ld	s0,8(sp)
 5b6:	0141                	addi	sp,sp,16
 5b8:	8082                	ret

00000000000005ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5ba:	1141                	addi	sp,sp,-16
 5bc:	e422                	sd	s0,8(sp)
 5be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 5c0:	00054783          	lbu	a5,0(a0)
 5c4:	cb91                	beqz	a5,5d8 <strcmp+0x1e>
 5c6:	0005c703          	lbu	a4,0(a1)
 5ca:	00f71763          	bne	a4,a5,5d8 <strcmp+0x1e>
    p++, q++;
 5ce:	0505                	addi	a0,a0,1
 5d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5d2:	00054783          	lbu	a5,0(a0)
 5d6:	fbe5                	bnez	a5,5c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5d8:	0005c503          	lbu	a0,0(a1)
}
 5dc:	40a7853b          	subw	a0,a5,a0
 5e0:	6422                	ld	s0,8(sp)
 5e2:	0141                	addi	sp,sp,16
 5e4:	8082                	ret

00000000000005e6 <strlen>:

uint
strlen(const char *s)
{
 5e6:	1141                	addi	sp,sp,-16
 5e8:	e422                	sd	s0,8(sp)
 5ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5ec:	00054783          	lbu	a5,0(a0)
 5f0:	cf91                	beqz	a5,60c <strlen+0x26>
 5f2:	0505                	addi	a0,a0,1
 5f4:	87aa                	mv	a5,a0
 5f6:	4685                	li	a3,1
 5f8:	9e89                	subw	a3,a3,a0
 5fa:	00f6853b          	addw	a0,a3,a5
 5fe:	0785                	addi	a5,a5,1
 600:	fff7c703          	lbu	a4,-1(a5)
 604:	fb7d                	bnez	a4,5fa <strlen+0x14>
    ;
  return n;
}
 606:	6422                	ld	s0,8(sp)
 608:	0141                	addi	sp,sp,16
 60a:	8082                	ret
  for(n = 0; s[n]; n++)
 60c:	4501                	li	a0,0
 60e:	bfe5                	j	606 <strlen+0x20>

0000000000000610 <memset>:

void*
memset(void *dst, int c, uint n)
{
 610:	1141                	addi	sp,sp,-16
 612:	e422                	sd	s0,8(sp)
 614:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 616:	ce09                	beqz	a2,630 <memset+0x20>
 618:	87aa                	mv	a5,a0
 61a:	fff6071b          	addiw	a4,a2,-1
 61e:	1702                	slli	a4,a4,0x20
 620:	9301                	srli	a4,a4,0x20
 622:	0705                	addi	a4,a4,1
 624:	972a                	add	a4,a4,a0
    cdst[i] = c;
 626:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 62a:	0785                	addi	a5,a5,1
 62c:	fee79de3          	bne	a5,a4,626 <memset+0x16>
  }
  return dst;
}
 630:	6422                	ld	s0,8(sp)
 632:	0141                	addi	sp,sp,16
 634:	8082                	ret

0000000000000636 <strchr>:

char*
strchr(const char *s, char c)
{
 636:	1141                	addi	sp,sp,-16
 638:	e422                	sd	s0,8(sp)
 63a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 63c:	00054783          	lbu	a5,0(a0)
 640:	cb99                	beqz	a5,656 <strchr+0x20>
    if(*s == c)
 642:	00f58763          	beq	a1,a5,650 <strchr+0x1a>
  for(; *s; s++)
 646:	0505                	addi	a0,a0,1
 648:	00054783          	lbu	a5,0(a0)
 64c:	fbfd                	bnez	a5,642 <strchr+0xc>
      return (char*)s;
  return 0;
 64e:	4501                	li	a0,0
}
 650:	6422                	ld	s0,8(sp)
 652:	0141                	addi	sp,sp,16
 654:	8082                	ret
  return 0;
 656:	4501                	li	a0,0
 658:	bfe5                	j	650 <strchr+0x1a>

000000000000065a <gets>:

char*
gets(char *buf, int max)
{
 65a:	711d                	addi	sp,sp,-96
 65c:	ec86                	sd	ra,88(sp)
 65e:	e8a2                	sd	s0,80(sp)
 660:	e4a6                	sd	s1,72(sp)
 662:	e0ca                	sd	s2,64(sp)
 664:	fc4e                	sd	s3,56(sp)
 666:	f852                	sd	s4,48(sp)
 668:	f456                	sd	s5,40(sp)
 66a:	f05a                	sd	s6,32(sp)
 66c:	ec5e                	sd	s7,24(sp)
 66e:	1080                	addi	s0,sp,96
 670:	8baa                	mv	s7,a0
 672:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 674:	892a                	mv	s2,a0
 676:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 678:	4aa9                	li	s5,10
 67a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 67c:	89a6                	mv	s3,s1
 67e:	2485                	addiw	s1,s1,1
 680:	0344d863          	bge	s1,s4,6b0 <gets+0x56>
    cc = read(0, &c, 1);
 684:	4605                	li	a2,1
 686:	faf40593          	addi	a1,s0,-81
 68a:	4501                	li	a0,0
 68c:	00000097          	auipc	ra,0x0
 690:	1a0080e7          	jalr	416(ra) # 82c <read>
    if(cc < 1)
 694:	00a05e63          	blez	a0,6b0 <gets+0x56>
    buf[i++] = c;
 698:	faf44783          	lbu	a5,-81(s0)
 69c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 6a0:	01578763          	beq	a5,s5,6ae <gets+0x54>
 6a4:	0905                	addi	s2,s2,1
 6a6:	fd679be3          	bne	a5,s6,67c <gets+0x22>
  for(i=0; i+1 < max; ){
 6aa:	89a6                	mv	s3,s1
 6ac:	a011                	j	6b0 <gets+0x56>
 6ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6b0:	99de                	add	s3,s3,s7
 6b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 6b6:	855e                	mv	a0,s7
 6b8:	60e6                	ld	ra,88(sp)
 6ba:	6446                	ld	s0,80(sp)
 6bc:	64a6                	ld	s1,72(sp)
 6be:	6906                	ld	s2,64(sp)
 6c0:	79e2                	ld	s3,56(sp)
 6c2:	7a42                	ld	s4,48(sp)
 6c4:	7aa2                	ld	s5,40(sp)
 6c6:	7b02                	ld	s6,32(sp)
 6c8:	6be2                	ld	s7,24(sp)
 6ca:	6125                	addi	sp,sp,96
 6cc:	8082                	ret

00000000000006ce <stat>:

int
stat(const char *n, struct stat *st)
{
 6ce:	1101                	addi	sp,sp,-32
 6d0:	ec06                	sd	ra,24(sp)
 6d2:	e822                	sd	s0,16(sp)
 6d4:	e426                	sd	s1,8(sp)
 6d6:	e04a                	sd	s2,0(sp)
 6d8:	1000                	addi	s0,sp,32
 6da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6dc:	4581                	li	a1,0
 6de:	00000097          	auipc	ra,0x0
 6e2:	176080e7          	jalr	374(ra) # 854 <open>
  if(fd < 0)
 6e6:	02054563          	bltz	a0,710 <stat+0x42>
 6ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6ec:	85ca                	mv	a1,s2
 6ee:	00000097          	auipc	ra,0x0
 6f2:	17e080e7          	jalr	382(ra) # 86c <fstat>
 6f6:	892a                	mv	s2,a0
  close(fd);
 6f8:	8526                	mv	a0,s1
 6fa:	00000097          	auipc	ra,0x0
 6fe:	142080e7          	jalr	322(ra) # 83c <close>
  return r;
}
 702:	854a                	mv	a0,s2
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	64a2                	ld	s1,8(sp)
 70a:	6902                	ld	s2,0(sp)
 70c:	6105                	addi	sp,sp,32
 70e:	8082                	ret
    return -1;
 710:	597d                	li	s2,-1
 712:	bfc5                	j	702 <stat+0x34>

0000000000000714 <atoi>:

int
atoi(const char *s)
{
 714:	1141                	addi	sp,sp,-16
 716:	e422                	sd	s0,8(sp)
 718:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 71a:	00054603          	lbu	a2,0(a0)
 71e:	fd06079b          	addiw	a5,a2,-48
 722:	0ff7f793          	andi	a5,a5,255
 726:	4725                	li	a4,9
 728:	02f76963          	bltu	a4,a5,75a <atoi+0x46>
 72c:	86aa                	mv	a3,a0
  n = 0;
 72e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 730:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 732:	0685                	addi	a3,a3,1
 734:	0025179b          	slliw	a5,a0,0x2
 738:	9fa9                	addw	a5,a5,a0
 73a:	0017979b          	slliw	a5,a5,0x1
 73e:	9fb1                	addw	a5,a5,a2
 740:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 744:	0006c603          	lbu	a2,0(a3)
 748:	fd06071b          	addiw	a4,a2,-48
 74c:	0ff77713          	andi	a4,a4,255
 750:	fee5f1e3          	bgeu	a1,a4,732 <atoi+0x1e>
  return n;
}
 754:	6422                	ld	s0,8(sp)
 756:	0141                	addi	sp,sp,16
 758:	8082                	ret
  n = 0;
 75a:	4501                	li	a0,0
 75c:	bfe5                	j	754 <atoi+0x40>

000000000000075e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 75e:	1141                	addi	sp,sp,-16
 760:	e422                	sd	s0,8(sp)
 762:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 764:	02b57663          	bgeu	a0,a1,790 <memmove+0x32>
    while(n-- > 0)
 768:	02c05163          	blez	a2,78a <memmove+0x2c>
 76c:	fff6079b          	addiw	a5,a2,-1
 770:	1782                	slli	a5,a5,0x20
 772:	9381                	srli	a5,a5,0x20
 774:	0785                	addi	a5,a5,1
 776:	97aa                	add	a5,a5,a0
  dst = vdst;
 778:	872a                	mv	a4,a0
      *dst++ = *src++;
 77a:	0585                	addi	a1,a1,1
 77c:	0705                	addi	a4,a4,1
 77e:	fff5c683          	lbu	a3,-1(a1)
 782:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 786:	fee79ae3          	bne	a5,a4,77a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret
    dst += n;
 790:	00c50733          	add	a4,a0,a2
    src += n;
 794:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 796:	fec05ae3          	blez	a2,78a <memmove+0x2c>
 79a:	fff6079b          	addiw	a5,a2,-1
 79e:	1782                	slli	a5,a5,0x20
 7a0:	9381                	srli	a5,a5,0x20
 7a2:	fff7c793          	not	a5,a5
 7a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7a8:	15fd                	addi	a1,a1,-1
 7aa:	177d                	addi	a4,a4,-1
 7ac:	0005c683          	lbu	a3,0(a1)
 7b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 7b4:	fee79ae3          	bne	a5,a4,7a8 <memmove+0x4a>
 7b8:	bfc9                	j	78a <memmove+0x2c>

00000000000007ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 7ba:	1141                	addi	sp,sp,-16
 7bc:	e422                	sd	s0,8(sp)
 7be:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 7c0:	ca05                	beqz	a2,7f0 <memcmp+0x36>
 7c2:	fff6069b          	addiw	a3,a2,-1
 7c6:	1682                	slli	a3,a3,0x20
 7c8:	9281                	srli	a3,a3,0x20
 7ca:	0685                	addi	a3,a3,1
 7cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7ce:	00054783          	lbu	a5,0(a0)
 7d2:	0005c703          	lbu	a4,0(a1)
 7d6:	00e79863          	bne	a5,a4,7e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7da:	0505                	addi	a0,a0,1
    p2++;
 7dc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7de:	fed518e3          	bne	a0,a3,7ce <memcmp+0x14>
  }
  return 0;
 7e2:	4501                	li	a0,0
 7e4:	a019                	j	7ea <memcmp+0x30>
      return *p1 - *p2;
 7e6:	40e7853b          	subw	a0,a5,a4
}
 7ea:	6422                	ld	s0,8(sp)
 7ec:	0141                	addi	sp,sp,16
 7ee:	8082                	ret
  return 0;
 7f0:	4501                	li	a0,0
 7f2:	bfe5                	j	7ea <memcmp+0x30>

00000000000007f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7f4:	1141                	addi	sp,sp,-16
 7f6:	e406                	sd	ra,8(sp)
 7f8:	e022                	sd	s0,0(sp)
 7fa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7fc:	00000097          	auipc	ra,0x0
 800:	f62080e7          	jalr	-158(ra) # 75e <memmove>
}
 804:	60a2                	ld	ra,8(sp)
 806:	6402                	ld	s0,0(sp)
 808:	0141                	addi	sp,sp,16
 80a:	8082                	ret

000000000000080c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 80c:	4885                	li	a7,1
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <exit>:
.global exit
exit:
 li a7, SYS_exit
 814:	4889                	li	a7,2
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <wait>:
.global wait
wait:
 li a7, SYS_wait
 81c:	488d                	li	a7,3
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 824:	4891                	li	a7,4
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <read>:
.global read
read:
 li a7, SYS_read
 82c:	4895                	li	a7,5
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <write>:
.global write
write:
 li a7, SYS_write
 834:	48c1                	li	a7,16
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <close>:
.global close
close:
 li a7, SYS_close
 83c:	48d5                	li	a7,21
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <kill>:
.global kill
kill:
 li a7, SYS_kill
 844:	4899                	li	a7,6
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <exec>:
.global exec
exec:
 li a7, SYS_exec
 84c:	489d                	li	a7,7
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <open>:
.global open
open:
 li a7, SYS_open
 854:	48bd                	li	a7,15
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 85c:	48c5                	li	a7,17
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 864:	48c9                	li	a7,18
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 86c:	48a1                	li	a7,8
 ecall
 86e:	00000073          	ecall
 ret
 872:	8082                	ret

0000000000000874 <link>:
.global link
link:
 li a7, SYS_link
 874:	48cd                	li	a7,19
 ecall
 876:	00000073          	ecall
 ret
 87a:	8082                	ret

000000000000087c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 87c:	48d1                	li	a7,20
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 884:	48a5                	li	a7,9
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <dup>:
.global dup
dup:
 li a7, SYS_dup
 88c:	48a9                	li	a7,10
 ecall
 88e:	00000073          	ecall
 ret
 892:	8082                	ret

0000000000000894 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 894:	48ad                	li	a7,11
 ecall
 896:	00000073          	ecall
 ret
 89a:	8082                	ret

000000000000089c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 89c:	48b1                	li	a7,12
 ecall
 89e:	00000073          	ecall
 ret
 8a2:	8082                	ret

00000000000008a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8a4:	48b5                	li	a7,13
 ecall
 8a6:	00000073          	ecall
 ret
 8aa:	8082                	ret

00000000000008ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8ac:	48b9                	li	a7,14
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8b4:	1101                	addi	sp,sp,-32
 8b6:	ec06                	sd	ra,24(sp)
 8b8:	e822                	sd	s0,16(sp)
 8ba:	1000                	addi	s0,sp,32
 8bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8c0:	4605                	li	a2,1
 8c2:	fef40593          	addi	a1,s0,-17
 8c6:	00000097          	auipc	ra,0x0
 8ca:	f6e080e7          	jalr	-146(ra) # 834 <write>
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	6105                	addi	sp,sp,32
 8d4:	8082                	ret

00000000000008d6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8d6:	7139                	addi	sp,sp,-64
 8d8:	fc06                	sd	ra,56(sp)
 8da:	f822                	sd	s0,48(sp)
 8dc:	f426                	sd	s1,40(sp)
 8de:	f04a                	sd	s2,32(sp)
 8e0:	ec4e                	sd	s3,24(sp)
 8e2:	0080                	addi	s0,sp,64
 8e4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8e6:	c299                	beqz	a3,8ec <printint+0x16>
 8e8:	0805c863          	bltz	a1,978 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8ec:	2581                	sext.w	a1,a1
  neg = 0;
 8ee:	4881                	li	a7,0
 8f0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8f4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8f6:	2601                	sext.w	a2,a2
 8f8:	00001517          	auipc	a0,0x1
 8fc:	86050513          	addi	a0,a0,-1952 # 1158 <digits>
 900:	883a                	mv	a6,a4
 902:	2705                	addiw	a4,a4,1
 904:	02c5f7bb          	remuw	a5,a1,a2
 908:	1782                	slli	a5,a5,0x20
 90a:	9381                	srli	a5,a5,0x20
 90c:	97aa                	add	a5,a5,a0
 90e:	0007c783          	lbu	a5,0(a5)
 912:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 916:	0005879b          	sext.w	a5,a1
 91a:	02c5d5bb          	divuw	a1,a1,a2
 91e:	0685                	addi	a3,a3,1
 920:	fec7f0e3          	bgeu	a5,a2,900 <printint+0x2a>
  if(neg)
 924:	00088b63          	beqz	a7,93a <printint+0x64>
    buf[i++] = '-';
 928:	fd040793          	addi	a5,s0,-48
 92c:	973e                	add	a4,a4,a5
 92e:	02d00793          	li	a5,45
 932:	fef70823          	sb	a5,-16(a4)
 936:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 93a:	02e05863          	blez	a4,96a <printint+0x94>
 93e:	fc040793          	addi	a5,s0,-64
 942:	00e78933          	add	s2,a5,a4
 946:	fff78993          	addi	s3,a5,-1
 94a:	99ba                	add	s3,s3,a4
 94c:	377d                	addiw	a4,a4,-1
 94e:	1702                	slli	a4,a4,0x20
 950:	9301                	srli	a4,a4,0x20
 952:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 956:	fff94583          	lbu	a1,-1(s2)
 95a:	8526                	mv	a0,s1
 95c:	00000097          	auipc	ra,0x0
 960:	f58080e7          	jalr	-168(ra) # 8b4 <putc>
  while(--i >= 0)
 964:	197d                	addi	s2,s2,-1
 966:	ff3918e3          	bne	s2,s3,956 <printint+0x80>
}
 96a:	70e2                	ld	ra,56(sp)
 96c:	7442                	ld	s0,48(sp)
 96e:	74a2                	ld	s1,40(sp)
 970:	7902                	ld	s2,32(sp)
 972:	69e2                	ld	s3,24(sp)
 974:	6121                	addi	sp,sp,64
 976:	8082                	ret
    x = -xx;
 978:	40b005bb          	negw	a1,a1
    neg = 1;
 97c:	4885                	li	a7,1
    x = -xx;
 97e:	bf8d                	j	8f0 <printint+0x1a>

0000000000000980 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 980:	7119                	addi	sp,sp,-128
 982:	fc86                	sd	ra,120(sp)
 984:	f8a2                	sd	s0,112(sp)
 986:	f4a6                	sd	s1,104(sp)
 988:	f0ca                	sd	s2,96(sp)
 98a:	ecce                	sd	s3,88(sp)
 98c:	e8d2                	sd	s4,80(sp)
 98e:	e4d6                	sd	s5,72(sp)
 990:	e0da                	sd	s6,64(sp)
 992:	fc5e                	sd	s7,56(sp)
 994:	f862                	sd	s8,48(sp)
 996:	f466                	sd	s9,40(sp)
 998:	f06a                	sd	s10,32(sp)
 99a:	ec6e                	sd	s11,24(sp)
 99c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 99e:	0005c903          	lbu	s2,0(a1)
 9a2:	18090f63          	beqz	s2,b40 <vprintf+0x1c0>
 9a6:	8aaa                	mv	s5,a0
 9a8:	8b32                	mv	s6,a2
 9aa:	00158493          	addi	s1,a1,1
  state = 0;
 9ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9b0:	02500a13          	li	s4,37
      if(c == 'd'){
 9b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 9b8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 9bc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 9c0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9c4:	00000b97          	auipc	s7,0x0
 9c8:	794b8b93          	addi	s7,s7,1940 # 1158 <digits>
 9cc:	a839                	j	9ea <vprintf+0x6a>
        putc(fd, c);
 9ce:	85ca                	mv	a1,s2
 9d0:	8556                	mv	a0,s5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	ee2080e7          	jalr	-286(ra) # 8b4 <putc>
 9da:	a019                	j	9e0 <vprintf+0x60>
    } else if(state == '%'){
 9dc:	01498f63          	beq	s3,s4,9fa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 9e0:	0485                	addi	s1,s1,1
 9e2:	fff4c903          	lbu	s2,-1(s1)
 9e6:	14090d63          	beqz	s2,b40 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 9ea:	0009079b          	sext.w	a5,s2
    if(state == 0){
 9ee:	fe0997e3          	bnez	s3,9dc <vprintf+0x5c>
      if(c == '%'){
 9f2:	fd479ee3          	bne	a5,s4,9ce <vprintf+0x4e>
        state = '%';
 9f6:	89be                	mv	s3,a5
 9f8:	b7e5                	j	9e0 <vprintf+0x60>
      if(c == 'd'){
 9fa:	05878063          	beq	a5,s8,a3a <vprintf+0xba>
      } else if(c == 'l') {
 9fe:	05978c63          	beq	a5,s9,a56 <vprintf+0xd6>
      } else if(c == 'x') {
 a02:	07a78863          	beq	a5,s10,a72 <vprintf+0xf2>
      } else if(c == 'p') {
 a06:	09b78463          	beq	a5,s11,a8e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 a0a:	07300713          	li	a4,115
 a0e:	0ce78663          	beq	a5,a4,ada <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a12:	06300713          	li	a4,99
 a16:	0ee78e63          	beq	a5,a4,b12 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 a1a:	11478863          	beq	a5,s4,b2a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a1e:	85d2                	mv	a1,s4
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	e92080e7          	jalr	-366(ra) # 8b4 <putc>
        putc(fd, c);
 a2a:	85ca                	mv	a1,s2
 a2c:	8556                	mv	a0,s5
 a2e:	00000097          	auipc	ra,0x0
 a32:	e86080e7          	jalr	-378(ra) # 8b4 <putc>
      }
      state = 0;
 a36:	4981                	li	s3,0
 a38:	b765                	j	9e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 a3a:	008b0913          	addi	s2,s6,8
 a3e:	4685                	li	a3,1
 a40:	4629                	li	a2,10
 a42:	000b2583          	lw	a1,0(s6)
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	e8e080e7          	jalr	-370(ra) # 8d6 <printint>
 a50:	8b4a                	mv	s6,s2
      state = 0;
 a52:	4981                	li	s3,0
 a54:	b771                	j	9e0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a56:	008b0913          	addi	s2,s6,8
 a5a:	4681                	li	a3,0
 a5c:	4629                	li	a2,10
 a5e:	000b2583          	lw	a1,0(s6)
 a62:	8556                	mv	a0,s5
 a64:	00000097          	auipc	ra,0x0
 a68:	e72080e7          	jalr	-398(ra) # 8d6 <printint>
 a6c:	8b4a                	mv	s6,s2
      state = 0;
 a6e:	4981                	li	s3,0
 a70:	bf85                	j	9e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 a72:	008b0913          	addi	s2,s6,8
 a76:	4681                	li	a3,0
 a78:	4641                	li	a2,16
 a7a:	000b2583          	lw	a1,0(s6)
 a7e:	8556                	mv	a0,s5
 a80:	00000097          	auipc	ra,0x0
 a84:	e56080e7          	jalr	-426(ra) # 8d6 <printint>
 a88:	8b4a                	mv	s6,s2
      state = 0;
 a8a:	4981                	li	s3,0
 a8c:	bf91                	j	9e0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a8e:	008b0793          	addi	a5,s6,8
 a92:	f8f43423          	sd	a5,-120(s0)
 a96:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a9a:	03000593          	li	a1,48
 a9e:	8556                	mv	a0,s5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	e14080e7          	jalr	-492(ra) # 8b4 <putc>
  putc(fd, 'x');
 aa8:	85ea                	mv	a1,s10
 aaa:	8556                	mv	a0,s5
 aac:	00000097          	auipc	ra,0x0
 ab0:	e08080e7          	jalr	-504(ra) # 8b4 <putc>
 ab4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 ab6:	03c9d793          	srli	a5,s3,0x3c
 aba:	97de                	add	a5,a5,s7
 abc:	0007c583          	lbu	a1,0(a5)
 ac0:	8556                	mv	a0,s5
 ac2:	00000097          	auipc	ra,0x0
 ac6:	df2080e7          	jalr	-526(ra) # 8b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aca:	0992                	slli	s3,s3,0x4
 acc:	397d                	addiw	s2,s2,-1
 ace:	fe0914e3          	bnez	s2,ab6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 ad2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 ad6:	4981                	li	s3,0
 ad8:	b721                	j	9e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 ada:	008b0993          	addi	s3,s6,8
 ade:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 ae2:	02090163          	beqz	s2,b04 <vprintf+0x184>
        while(*s != 0){
 ae6:	00094583          	lbu	a1,0(s2)
 aea:	c9a1                	beqz	a1,b3a <vprintf+0x1ba>
          putc(fd, *s);
 aec:	8556                	mv	a0,s5
 aee:	00000097          	auipc	ra,0x0
 af2:	dc6080e7          	jalr	-570(ra) # 8b4 <putc>
          s++;
 af6:	0905                	addi	s2,s2,1
        while(*s != 0){
 af8:	00094583          	lbu	a1,0(s2)
 afc:	f9e5                	bnez	a1,aec <vprintf+0x16c>
        s = va_arg(ap, char*);
 afe:	8b4e                	mv	s6,s3
      state = 0;
 b00:	4981                	li	s3,0
 b02:	bdf9                	j	9e0 <vprintf+0x60>
          s = "(null)";
 b04:	00000917          	auipc	s2,0x0
 b08:	64c90913          	addi	s2,s2,1612 # 1150 <longjmp_1+0x3b0>
        while(*s != 0){
 b0c:	02800593          	li	a1,40
 b10:	bff1                	j	aec <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 b12:	008b0913          	addi	s2,s6,8
 b16:	000b4583          	lbu	a1,0(s6)
 b1a:	8556                	mv	a0,s5
 b1c:	00000097          	auipc	ra,0x0
 b20:	d98080e7          	jalr	-616(ra) # 8b4 <putc>
 b24:	8b4a                	mv	s6,s2
      state = 0;
 b26:	4981                	li	s3,0
 b28:	bd65                	j	9e0 <vprintf+0x60>
        putc(fd, c);
 b2a:	85d2                	mv	a1,s4
 b2c:	8556                	mv	a0,s5
 b2e:	00000097          	auipc	ra,0x0
 b32:	d86080e7          	jalr	-634(ra) # 8b4 <putc>
      state = 0;
 b36:	4981                	li	s3,0
 b38:	b565                	j	9e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 b3a:	8b4e                	mv	s6,s3
      state = 0;
 b3c:	4981                	li	s3,0
 b3e:	b54d                	j	9e0 <vprintf+0x60>
    }
  }
}
 b40:	70e6                	ld	ra,120(sp)
 b42:	7446                	ld	s0,112(sp)
 b44:	74a6                	ld	s1,104(sp)
 b46:	7906                	ld	s2,96(sp)
 b48:	69e6                	ld	s3,88(sp)
 b4a:	6a46                	ld	s4,80(sp)
 b4c:	6aa6                	ld	s5,72(sp)
 b4e:	6b06                	ld	s6,64(sp)
 b50:	7be2                	ld	s7,56(sp)
 b52:	7c42                	ld	s8,48(sp)
 b54:	7ca2                	ld	s9,40(sp)
 b56:	7d02                	ld	s10,32(sp)
 b58:	6de2                	ld	s11,24(sp)
 b5a:	6109                	addi	sp,sp,128
 b5c:	8082                	ret

0000000000000b5e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b5e:	715d                	addi	sp,sp,-80
 b60:	ec06                	sd	ra,24(sp)
 b62:	e822                	sd	s0,16(sp)
 b64:	1000                	addi	s0,sp,32
 b66:	e010                	sd	a2,0(s0)
 b68:	e414                	sd	a3,8(s0)
 b6a:	e818                	sd	a4,16(s0)
 b6c:	ec1c                	sd	a5,24(s0)
 b6e:	03043023          	sd	a6,32(s0)
 b72:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b76:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b7a:	8622                	mv	a2,s0
 b7c:	00000097          	auipc	ra,0x0
 b80:	e04080e7          	jalr	-508(ra) # 980 <vprintf>
}
 b84:	60e2                	ld	ra,24(sp)
 b86:	6442                	ld	s0,16(sp)
 b88:	6161                	addi	sp,sp,80
 b8a:	8082                	ret

0000000000000b8c <printf>:

void
printf(const char *fmt, ...)
{
 b8c:	711d                	addi	sp,sp,-96
 b8e:	ec06                	sd	ra,24(sp)
 b90:	e822                	sd	s0,16(sp)
 b92:	1000                	addi	s0,sp,32
 b94:	e40c                	sd	a1,8(s0)
 b96:	e810                	sd	a2,16(s0)
 b98:	ec14                	sd	a3,24(s0)
 b9a:	f018                	sd	a4,32(s0)
 b9c:	f41c                	sd	a5,40(s0)
 b9e:	03043823          	sd	a6,48(s0)
 ba2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ba6:	00840613          	addi	a2,s0,8
 baa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bae:	85aa                	mv	a1,a0
 bb0:	4505                	li	a0,1
 bb2:	00000097          	auipc	ra,0x0
 bb6:	dce080e7          	jalr	-562(ra) # 980 <vprintf>
}
 bba:	60e2                	ld	ra,24(sp)
 bbc:	6442                	ld	s0,16(sp)
 bbe:	6125                	addi	sp,sp,96
 bc0:	8082                	ret

0000000000000bc2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bc2:	1141                	addi	sp,sp,-16
 bc4:	e422                	sd	s0,8(sp)
 bc6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bc8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bcc:	00000797          	auipc	a5,0x0
 bd0:	5ac7b783          	ld	a5,1452(a5) # 1178 <freep>
 bd4:	a805                	j	c04 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bd6:	4618                	lw	a4,8(a2)
 bd8:	9db9                	addw	a1,a1,a4
 bda:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bde:	6398                	ld	a4,0(a5)
 be0:	6318                	ld	a4,0(a4)
 be2:	fee53823          	sd	a4,-16(a0)
 be6:	a091                	j	c2a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 be8:	ff852703          	lw	a4,-8(a0)
 bec:	9e39                	addw	a2,a2,a4
 bee:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 bf0:	ff053703          	ld	a4,-16(a0)
 bf4:	e398                	sd	a4,0(a5)
 bf6:	a099                	j	c3c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bf8:	6398                	ld	a4,0(a5)
 bfa:	00e7e463          	bltu	a5,a4,c02 <free+0x40>
 bfe:	00e6ea63          	bltu	a3,a4,c12 <free+0x50>
{
 c02:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c04:	fed7fae3          	bgeu	a5,a3,bf8 <free+0x36>
 c08:	6398                	ld	a4,0(a5)
 c0a:	00e6e463          	bltu	a3,a4,c12 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c0e:	fee7eae3          	bltu	a5,a4,c02 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 c12:	ff852583          	lw	a1,-8(a0)
 c16:	6390                	ld	a2,0(a5)
 c18:	02059713          	slli	a4,a1,0x20
 c1c:	9301                	srli	a4,a4,0x20
 c1e:	0712                	slli	a4,a4,0x4
 c20:	9736                	add	a4,a4,a3
 c22:	fae60ae3          	beq	a2,a4,bd6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 c26:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c2a:	4790                	lw	a2,8(a5)
 c2c:	02061713          	slli	a4,a2,0x20
 c30:	9301                	srli	a4,a4,0x20
 c32:	0712                	slli	a4,a4,0x4
 c34:	973e                	add	a4,a4,a5
 c36:	fae689e3          	beq	a3,a4,be8 <free+0x26>
  } else
    p->s.ptr = bp;
 c3a:	e394                	sd	a3,0(a5)
  freep = p;
 c3c:	00000717          	auipc	a4,0x0
 c40:	52f73e23          	sd	a5,1340(a4) # 1178 <freep>
}
 c44:	6422                	ld	s0,8(sp)
 c46:	0141                	addi	sp,sp,16
 c48:	8082                	ret

0000000000000c4a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c4a:	7139                	addi	sp,sp,-64
 c4c:	fc06                	sd	ra,56(sp)
 c4e:	f822                	sd	s0,48(sp)
 c50:	f426                	sd	s1,40(sp)
 c52:	f04a                	sd	s2,32(sp)
 c54:	ec4e                	sd	s3,24(sp)
 c56:	e852                	sd	s4,16(sp)
 c58:	e456                	sd	s5,8(sp)
 c5a:	e05a                	sd	s6,0(sp)
 c5c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c5e:	02051493          	slli	s1,a0,0x20
 c62:	9081                	srli	s1,s1,0x20
 c64:	04bd                	addi	s1,s1,15
 c66:	8091                	srli	s1,s1,0x4
 c68:	0014899b          	addiw	s3,s1,1
 c6c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c6e:	00000517          	auipc	a0,0x0
 c72:	50a53503          	ld	a0,1290(a0) # 1178 <freep>
 c76:	c515                	beqz	a0,ca2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c78:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c7a:	4798                	lw	a4,8(a5)
 c7c:	02977f63          	bgeu	a4,s1,cba <malloc+0x70>
 c80:	8a4e                	mv	s4,s3
 c82:	0009871b          	sext.w	a4,s3
 c86:	6685                	lui	a3,0x1
 c88:	00d77363          	bgeu	a4,a3,c8e <malloc+0x44>
 c8c:	6a05                	lui	s4,0x1
 c8e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c92:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c96:	00000917          	auipc	s2,0x0
 c9a:	4e290913          	addi	s2,s2,1250 # 1178 <freep>
  if(p == (char*)-1)
 c9e:	5afd                	li	s5,-1
 ca0:	a88d                	j	d12 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 ca2:	00000797          	auipc	a5,0x0
 ca6:	54e78793          	addi	a5,a5,1358 # 11f0 <base>
 caa:	00000717          	auipc	a4,0x0
 cae:	4cf73723          	sd	a5,1230(a4) # 1178 <freep>
 cb2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cb4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cb8:	b7e1                	j	c80 <malloc+0x36>
      if(p->s.size == nunits)
 cba:	02e48b63          	beq	s1,a4,cf0 <malloc+0xa6>
        p->s.size -= nunits;
 cbe:	4137073b          	subw	a4,a4,s3
 cc2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cc4:	1702                	slli	a4,a4,0x20
 cc6:	9301                	srli	a4,a4,0x20
 cc8:	0712                	slli	a4,a4,0x4
 cca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ccc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cd0:	00000717          	auipc	a4,0x0
 cd4:	4aa73423          	sd	a0,1192(a4) # 1178 <freep>
      return (void*)(p + 1);
 cd8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cdc:	70e2                	ld	ra,56(sp)
 cde:	7442                	ld	s0,48(sp)
 ce0:	74a2                	ld	s1,40(sp)
 ce2:	7902                	ld	s2,32(sp)
 ce4:	69e2                	ld	s3,24(sp)
 ce6:	6a42                	ld	s4,16(sp)
 ce8:	6aa2                	ld	s5,8(sp)
 cea:	6b02                	ld	s6,0(sp)
 cec:	6121                	addi	sp,sp,64
 cee:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 cf0:	6398                	ld	a4,0(a5)
 cf2:	e118                	sd	a4,0(a0)
 cf4:	bff1                	j	cd0 <malloc+0x86>
  hp->s.size = nu;
 cf6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cfa:	0541                	addi	a0,a0,16
 cfc:	00000097          	auipc	ra,0x0
 d00:	ec6080e7          	jalr	-314(ra) # bc2 <free>
  return freep;
 d04:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d08:	d971                	beqz	a0,cdc <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d0c:	4798                	lw	a4,8(a5)
 d0e:	fa9776e3          	bgeu	a4,s1,cba <malloc+0x70>
    if(p == freep)
 d12:	00093703          	ld	a4,0(s2)
 d16:	853e                	mv	a0,a5
 d18:	fef719e3          	bne	a4,a5,d0a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 d1c:	8552                	mv	a0,s4
 d1e:	00000097          	auipc	ra,0x0
 d22:	b7e080e7          	jalr	-1154(ra) # 89c <sbrk>
  if(p == (char*)-1)
 d26:	fd5518e3          	bne	a0,s5,cf6 <malloc+0xac>
        return 0;
 d2a:	4501                	li	a0,0
 d2c:	bf45                	j	cdc <malloc+0x92>

0000000000000d2e <setjmp>:
 d2e:	e100                	sd	s0,0(a0)
 d30:	e504                	sd	s1,8(a0)
 d32:	01253823          	sd	s2,16(a0)
 d36:	01353c23          	sd	s3,24(a0)
 d3a:	03453023          	sd	s4,32(a0)
 d3e:	03553423          	sd	s5,40(a0)
 d42:	03653823          	sd	s6,48(a0)
 d46:	03753c23          	sd	s7,56(a0)
 d4a:	05853023          	sd	s8,64(a0)
 d4e:	05953423          	sd	s9,72(a0)
 d52:	05a53823          	sd	s10,80(a0)
 d56:	05b53c23          	sd	s11,88(a0)
 d5a:	06153023          	sd	ra,96(a0)
 d5e:	06253423          	sd	sp,104(a0)
 d62:	4501                	li	a0,0
 d64:	8082                	ret

0000000000000d66 <longjmp>:
 d66:	6100                	ld	s0,0(a0)
 d68:	6504                	ld	s1,8(a0)
 d6a:	01053903          	ld	s2,16(a0)
 d6e:	01853983          	ld	s3,24(a0)
 d72:	02053a03          	ld	s4,32(a0)
 d76:	02853a83          	ld	s5,40(a0)
 d7a:	03053b03          	ld	s6,48(a0)
 d7e:	03853b83          	ld	s7,56(a0)
 d82:	04053c03          	ld	s8,64(a0)
 d86:	04853c83          	ld	s9,72(a0)
 d8a:	05053d03          	ld	s10,80(a0)
 d8e:	05853d83          	ld	s11,88(a0)
 d92:	06053083          	ld	ra,96(a0)
 d96:	06853103          	ld	sp,104(a0)
 d9a:	c199                	beqz	a1,da0 <longjmp_1>
 d9c:	852e                	mv	a0,a1
 d9e:	8082                	ret

0000000000000da0 <longjmp_1>:
 da0:	4505                	li	a0,1
 da2:	8082                	ret
