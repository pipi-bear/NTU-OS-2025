
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
   a:	23253503          	ld	a0,562(a0) # 1238 <current_thread>
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
  2e:	c6e080e7          	jalr	-914(ra) # c98 <malloc>
  32:	84aa                	mv	s1,a0
    unsigned long new_stack_p;      // a ptr to keep track of the stack ptr
    unsigned long new_stack;        // base address of the allocated stack
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  34:	6505                	lui	a0,0x1
  36:	80050513          	addi	a0,a0,-2048 # 800 <memmove+0x54>
  3a:	00001097          	auipc	ra,0x1
  3e:	c5e080e7          	jalr	-930(ra) # c98 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    // stores function ptr "f" and its argument "arg" inside the thread structure
    t->fp = f; 
  42:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  46:	0124b423          	sd	s2,8(s1)

    t->ID  = id;
  4a:	00001717          	auipc	a4,0x1
  4e:	1ea70713          	addi	a4,a4,490 # 1234 <id>
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
  96:	1a67b783          	ld	a5,422(a5) # 1238 <current_thread>
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
  c4:	16a7bc23          	sd	a0,376(a5) # 1238 <current_thread>
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
  e8:	15448493          	addi	s1,s1,340 # 1238 <current_thread>
  ec:	609c                	ld	a5,0(s1)
  ee:	0947a583          	lw	a1,148(a5)
  f2:	00001517          	auipc	a0,0x1
  f6:	d0650513          	addi	a0,a0,-762 # df8 <longjmp_1+0xa>
  fa:	00001097          	auipc	ra,0x1
  fe:	ae0080e7          	jalr	-1312(ra) # bda <printf>
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
 11a:	12f73123          	sd	a5,290(a4) # 1238 <current_thread>
    }
    printf("scheduled to thread %d\n", current_thread->ID);
 11e:	0947a583          	lw	a1,148(a5)
 122:	00001517          	auipc	a0,0x1
 126:	d0650513          	addi	a0,a0,-762 # e28 <longjmp_1+0x3a>
 12a:	00001097          	auipc	ra,0x1
 12e:	ab0080e7          	jalr	-1360(ra) # bda <printf>
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
 14a:	cfa50513          	addi	a0,a0,-774 # e40 <longjmp_1+0x52>
 14e:	00001097          	auipc	ra,0x1
 152:	a8c080e7          	jalr	-1396(ra) # bda <printf>
    if(current_thread->next != current_thread){     // case: still exist other thread in the runqueue
 156:	00001497          	auipc	s1,0x1
 15a:	0e24b483          	ld	s1,226(s1) # 1238 <current_thread>
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
 17a:	a9a080e7          	jalr	-1382(ra) # c10 <free>
        free(t);
 17e:	8526                	mv	a0,s1
 180:	00001097          	auipc	ra,0x1
 184:	a90080e7          	jalr	-1392(ra) # c10 <free>

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
 1a0:	a74080e7          	jalr	-1420(ra) # c10 <free>
        free(current_thread);
 1a4:	00001517          	auipc	a0,0x1
 1a8:	09453503          	ld	a0,148(a0) # 1238 <current_thread>
 1ac:	00001097          	auipc	ra,0x1
 1b0:	a64080e7          	jalr	-1436(ra) # c10 <free>
        longjmp(env_st, 1);
 1b4:	4585                	li	a1,1
 1b6:	00001517          	auipc	a0,0x1
 1ba:	09250513          	addi	a0,a0,146 # 1248 <env_st>
 1be:	00001097          	auipc	ra,0x1
 1c2:	bf6080e7          	jalr	-1034(ra) # db4 <longjmp>
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
 1d6:	06673703          	ld	a4,102(a4) # 1238 <current_thread>
 1da:	84ba                	mv	s1,a4
 1dc:	fce43c23          	sd	a4,-40(s0)
    printf("\n---------------------------------\n");
 1e0:	00001517          	auipc	a0,0x1
 1e4:	c7050513          	addi	a0,a0,-912 # e50 <longjmp_1+0x62>
 1e8:	00001097          	auipc	ra,0x1
 1ec:	9f2080e7          	jalr	-1550(ra) # bda <printf>
    printf("Thread %d is being dispatched (buf_set=%d, handler_buf_set=%d, signo=%d)\n", 
 1f0:	0b84a703          	lw	a4,184(s1)
 1f4:	1304a683          	lw	a3,304(s1)
 1f8:	0904a603          	lw	a2,144(s1)
 1fc:	0944a583          	lw	a1,148(s1)
 200:	00001517          	auipc	a0,0x1
 204:	c7850513          	addi	a0,a0,-904 # e78 <longjmp_1+0x8a>
 208:	00001097          	auipc	ra,0x1
 20c:	9d2080e7          	jalr	-1582(ra) # bda <printf>
    if (t->signo != -1 && t->handler_buf_set == 1) {
 210:	0b84a583          	lw	a1,184(s1)
 214:	57fd                	li	a5,-1
 216:	12f58b63          	beq	a1,a5,34c <dispatch+0x184>
 21a:	1304a703          	lw	a4,304(s1)
 21e:	4785                	li	a5,1
 220:	0af70d63          	beq	a4,a5,2da <dispatch+0x112>
        printf("Thread has pending signal %d\n", t->signo);
 224:	00001517          	auipc	a0,0x1
 228:	cdc50513          	addi	a0,a0,-804 # f00 <longjmp_1+0x112>
 22c:	00001097          	auipc	ra,0x1
 230:	9ae080e7          	jalr	-1618(ra) # bda <printf>
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
 25a:	cca50513          	addi	a0,a0,-822 # f20 <longjmp_1+0x132>
 25e:	00001097          	auipc	ra,0x1
 262:	97c080e7          	jalr	-1668(ra) # bda <printf>
            if (setjmp(t->env) == 0) {
 266:	02048513          	addi	a0,s1,32
 26a:	00001097          	auipc	ra,0x1
 26e:	b12080e7          	jalr	-1262(ra) # d7c <setjmp>
 272:	14051b63          	bnez	a0,3c8 <dispatch+0x200>
                printf("Executing signal handler\n");
 276:	00001517          	auipc	a0,0x1
 27a:	cca50513          	addi	a0,a0,-822 # f40 <longjmp_1+0x152>
 27e:	00001097          	auipc	ra,0x1
 282:	95c080e7          	jalr	-1700(ra) # bda <printf>
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
 29e:	cc650513          	addi	a0,a0,-826 # f60 <longjmp_1+0x172>
 2a2:	00001097          	auipc	ra,0x1
 2a6:	938080e7          	jalr	-1736(ra) # bda <printf>
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
 2be:	cc650513          	addi	a0,a0,-826 # f80 <longjmp_1+0x192>
 2c2:	00001097          	auipc	ra,0x1
 2c6:	918080e7          	jalr	-1768(ra) # bda <printf>
                    longjmp(t->env, 1);
 2ca:	4585                	li	a1,1
 2cc:	02048513          	addi	a0,s1,32
 2d0:	00001097          	auipc	ra,0x1
 2d4:	ae4080e7          	jalr	-1308(ra) # db4 <longjmp>
 2d8:	a8c5                	j	3c8 <dispatch+0x200>
        printf("Resuming signal handler for thread %d (signal %d)\n", t->ID, t->signo);
 2da:	862e                	mv	a2,a1
 2dc:	fd843483          	ld	s1,-40(s0)
 2e0:	0944a583          	lw	a1,148(s1)
 2e4:	00001517          	auipc	a0,0x1
 2e8:	be450513          	addi	a0,a0,-1052 # ec8 <longjmp_1+0xda>
 2ec:	00001097          	auipc	ra,0x1
 2f0:	8ee080e7          	jalr	-1810(ra) # bda <printf>
        longjmp(t->handler_env, 1);
 2f4:	4585                	li	a1,1
 2f6:	0c048513          	addi	a0,s1,192
 2fa:	00001097          	auipc	ra,0x1
 2fe:	aba080e7          	jalr	-1350(ra) # db4 <longjmp>
 302:	a0d9                	j	3c8 <dispatch+0x200>
                    printf("Starting thread function after handler\n");
 304:	00001517          	auipc	a0,0x1
 308:	ca450513          	addi	a0,a0,-860 # fa8 <longjmp_1+0x1ba>
 30c:	00001097          	auipc	ra,0x1
 310:	8ce080e7          	jalr	-1842(ra) # bda <printf>
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
 336:	c9e50513          	addi	a0,a0,-866 # fd0 <longjmp_1+0x1e2>
 33a:	00001097          	auipc	ra,0x1
 33e:	8a0080e7          	jalr	-1888(ra) # bda <printf>
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
 35a:	caa50513          	addi	a0,a0,-854 # 1000 <longjmp_1+0x212>
 35e:	00001097          	auipc	ra,0x1
 362:	87c080e7          	jalr	-1924(ra) # bda <printf>
            t->buf_set = 1;
 366:	4785                	li	a5,1
 368:	08f4a823          	sw	a5,144(s1)
            if (setjmp(t->env) == 0) {
 36c:	02048513          	addi	a0,s1,32
 370:	00001097          	auipc	ra,0x1
 374:	a0c080e7          	jalr	-1524(ra) # d7c <setjmp>
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
 3a0:	a18080e7          	jalr	-1512(ra) # db4 <longjmp>
 3a4:	a015                	j	3c8 <dispatch+0x200>
            printf("Resuming normal thread execution\n");
 3a6:	00001517          	auipc	a0,0x1
 3aa:	bda50513          	addi	a0,a0,-1062 # f80 <longjmp_1+0x192>
 3ae:	00001097          	auipc	ra,0x1
 3b2:	82c080e7          	jalr	-2004(ra) # bda <printf>
            longjmp(t->env, 1);
 3b6:	4585                	li	a1,1
 3b8:	fd843783          	ld	a5,-40(s0)
 3bc:	02078513          	addi	a0,a5,32
 3c0:	00001097          	auipc	ra,0x1
 3c4:	9f4080e7          	jalr	-1548(ra) # db4 <longjmp>
}
 3c8:	70e2                	ld	ra,56(sp)
 3ca:	7442                	ld	s0,48(sp)
 3cc:	74a2                	ld	s1,40(sp)
 3ce:	6121                	addi	sp,sp,64
 3d0:	8082                	ret

00000000000003d2 <thread_yield>:
void thread_yield(void) {
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e406                	sd	ra,8(sp)
 3d6:	e022                	sd	s0,0(sp)
 3d8:	0800                	addi	s0,sp,16
    int in_handler = (current_thread->signo != -1 && current_thread->handler_buf_set == 1);
 3da:	00001797          	auipc	a5,0x1
 3de:	e5e7b783          	ld	a5,-418(a5) # 1238 <current_thread>
 3e2:	0b87a603          	lw	a2,184(a5)
 3e6:	577d                	li	a4,-1
 3e8:	00e60763          	beq	a2,a4,3f6 <thread_yield+0x24>
 3ec:	1307a683          	lw	a3,304(a5)
 3f0:	4705                	li	a4,1
 3f2:	04e68563          	beq	a3,a4,43c <thread_yield+0x6a>
        printf("Thread %d yielding from normal execution (buf_set=%d)\n", 
 3f6:	0907a603          	lw	a2,144(a5)
 3fa:	0947a583          	lw	a1,148(a5)
 3fe:	00001517          	auipc	a0,0x1
 402:	c6250513          	addi	a0,a0,-926 # 1060 <longjmp_1+0x272>
 406:	00000097          	auipc	ra,0x0
 40a:	7d4080e7          	jalr	2004(ra) # bda <printf>
        if (setjmp(current_thread->env) == 0) {
 40e:	00001517          	auipc	a0,0x1
 412:	e2a53503          	ld	a0,-470(a0) # 1238 <current_thread>
 416:	02050513          	addi	a0,a0,32
 41a:	00001097          	auipc	ra,0x1
 41e:	962080e7          	jalr	-1694(ra) # d7c <setjmp>
 422:	c145                	beqz	a0,4c2 <thread_yield+0xf0>
        printf("Resumed normal thread execution via longjmp\n");
 424:	00001517          	auipc	a0,0x1
 428:	dc450513          	addi	a0,a0,-572 # 11e8 <longjmp_1+0x3fa>
 42c:	00000097          	auipc	ra,0x0
 430:	7ae080e7          	jalr	1966(ra) # bda <printf>
}
 434:	60a2                	ld	ra,8(sp)
 436:	6402                	ld	s0,0(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret
        printf("Thread %d yielding from signal handler (signal %d)\n", 
 43c:	0947a583          	lw	a1,148(a5)
 440:	00001517          	auipc	a0,0x1
 444:	be850513          	addi	a0,a0,-1048 # 1028 <longjmp_1+0x23a>
 448:	00000097          	auipc	ra,0x0
 44c:	792080e7          	jalr	1938(ra) # bda <printf>
        if (setjmp(current_thread->handler_env) == 0) {
 450:	00001517          	auipc	a0,0x1
 454:	de853503          	ld	a0,-536(a0) # 1238 <current_thread>
 458:	0c050513          	addi	a0,a0,192
 45c:	00001097          	auipc	ra,0x1
 460:	920080e7          	jalr	-1760(ra) # d7c <setjmp>
 464:	c911                	beqz	a0,478 <thread_yield+0xa6>
        printf("Resumed signal handler execution via longjmp\n");
 466:	00001517          	auipc	a0,0x1
 46a:	cba50513          	addi	a0,a0,-838 # 1120 <longjmp_1+0x332>
 46e:	00000097          	auipc	ra,0x0
 472:	76c080e7          	jalr	1900(ra) # bda <printf>
 476:	bf7d                	j	434 <thread_yield+0x62>
            printf("Saved handler context, scheduling next thread\n");
 478:	00001517          	auipc	a0,0x1
 47c:	c2050513          	addi	a0,a0,-992 # 1098 <longjmp_1+0x2aa>
 480:	00000097          	auipc	ra,0x0
 484:	75a080e7          	jalr	1882(ra) # bda <printf>
            schedule();
 488:	00000097          	auipc	ra,0x0
 48c:	c52080e7          	jalr	-942(ra) # da <schedule>
            printf("Schedule done, dispatching\n");
 490:	00001517          	auipc	a0,0x1
 494:	c3850513          	addi	a0,a0,-968 # 10c8 <longjmp_1+0x2da>
 498:	00000097          	auipc	ra,0x0
 49c:	742080e7          	jalr	1858(ra) # bda <printf>
            dispatch();
 4a0:	00000097          	auipc	ra,0x0
 4a4:	d28080e7          	jalr	-728(ra) # 1c8 <dispatch>
            printf("ERROR: Returned from dispatch in handler context\n");
 4a8:	00001517          	auipc	a0,0x1
 4ac:	c4050513          	addi	a0,a0,-960 # 10e8 <longjmp_1+0x2fa>
 4b0:	00000097          	auipc	ra,0x0
 4b4:	72a080e7          	jalr	1834(ra) # bda <printf>
            exit(1);
 4b8:	4505                	li	a0,1
 4ba:	00000097          	auipc	ra,0x0
 4be:	3a8080e7          	jalr	936(ra) # 862 <exit>
            if (current_thread->buf_set == 0) {
 4c2:	00001797          	auipc	a5,0x1
 4c6:	d767b783          	ld	a5,-650(a5) # 1238 <current_thread>
 4ca:	0907a703          	lw	a4,144(a5)
 4ce:	ef01                	bnez	a4,4e6 <thread_yield+0x114>
                current_thread->buf_set = 1;
 4d0:	4705                	li	a4,1
 4d2:	08e7a823          	sw	a4,144(a5)
                printf("First time saving context, set buf_set to 1\n");
 4d6:	00001517          	auipc	a0,0x1
 4da:	c7a50513          	addi	a0,a0,-902 # 1150 <longjmp_1+0x362>
 4de:	00000097          	auipc	ra,0x0
 4e2:	6fc080e7          	jalr	1788(ra) # bda <printf>
            printf("Saved normal context, scheduling next thread\n");
 4e6:	00001517          	auipc	a0,0x1
 4ea:	c9a50513          	addi	a0,a0,-870 # 1180 <longjmp_1+0x392>
 4ee:	00000097          	auipc	ra,0x0
 4f2:	6ec080e7          	jalr	1772(ra) # bda <printf>
            schedule();
 4f6:	00000097          	auipc	ra,0x0
 4fa:	be4080e7          	jalr	-1052(ra) # da <schedule>
            printf("Schedule done, dispatching\n");
 4fe:	00001517          	auipc	a0,0x1
 502:	bca50513          	addi	a0,a0,-1078 # 10c8 <longjmp_1+0x2da>
 506:	00000097          	auipc	ra,0x0
 50a:	6d4080e7          	jalr	1748(ra) # bda <printf>
            dispatch();
 50e:	00000097          	auipc	ra,0x0
 512:	cba080e7          	jalr	-838(ra) # 1c8 <dispatch>
            printf("ERROR: Returned from dispatch in normal context\n");
 516:	00001517          	auipc	a0,0x1
 51a:	c9a50513          	addi	a0,a0,-870 # 11b0 <longjmp_1+0x3c2>
 51e:	00000097          	auipc	ra,0x0
 522:	6bc080e7          	jalr	1724(ra) # bda <printf>
            exit(1);
 526:	4505                	li	a0,1
 528:	00000097          	auipc	ra,0x0
 52c:	33a080e7          	jalr	826(ra) # 862 <exit>

0000000000000530 <thread_start_threading>:

void thread_start_threading(void){
 530:	1141                	addi	sp,sp,-16
 532:	e406                	sd	ra,8(sp)
 534:	e022                	sd	s0,0(sp)
 536:	0800                	addi	s0,sp,16
    //TO DO
    // Save the main function's context
    if (setjmp(env_st) == 0) {
 538:	00001517          	auipc	a0,0x1
 53c:	d1050513          	addi	a0,a0,-752 # 1248 <env_st>
 540:	00001097          	auipc	ra,0x1
 544:	83c080e7          	jalr	-1988(ra) # d7c <setjmp>
 548:	c509                	beqz	a0,552 <thread_start_threading+0x22>
        schedule();
        dispatch();  
    } else {        // When all the threads exit, setjmp(env_st) != 0
        return;
    }
}
 54a:	60a2                	ld	ra,8(sp)
 54c:	6402                	ld	s0,0(sp)
 54e:	0141                	addi	sp,sp,16
 550:	8082                	ret
        schedule();
 552:	00000097          	auipc	ra,0x0
 556:	b88080e7          	jalr	-1144(ra) # da <schedule>
        dispatch();  
 55a:	00000097          	auipc	ra,0x0
 55e:	c6e080e7          	jalr	-914(ra) # 1c8 <dispatch>
 562:	b7e5                	j	54a <thread_start_threading+0x1a>

0000000000000564 <thread_register_handler>:

//PART 2

void thread_register_handler(int signo, void (*handler)(int)){
 564:	1141                	addi	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	addi	s0,sp,16
    current_thread->sig_handler[signo] = handler;
 56a:	0551                	addi	a0,a0,20
 56c:	050e                	slli	a0,a0,0x3
 56e:	00001797          	auipc	a5,0x1
 572:	cca7b783          	ld	a5,-822(a5) # 1238 <current_thread>
 576:	953e                	add	a0,a0,a5
 578:	e50c                	sd	a1,8(a0)
    // printf("Thread %d has signal %d handler registered\n", current_thread->ID, signo);
}
 57a:	6422                	ld	s0,8(sp)
 57c:	0141                	addi	sp,sp,16
 57e:	8082                	ret

0000000000000580 <thread_kill>:

void thread_kill(struct thread *t, int signo){
 580:	1141                	addi	sp,sp,-16
 582:	e422                	sd	s0,8(sp)
 584:	0800                	addi	s0,sp,16
    //TO DO
    // printf("Thread %d is executing thread_kill for signal %d\n", t->ID, signo);
    // Mark the signal for the thread
    t->signo = signo;
 586:	0ab52c23          	sw	a1,184(a0)

    if (t->sig_handler[signo] == NULL_FUNC) {       // case: no handler for this signo
 58a:	05d1                	addi	a1,a1,20
 58c:	058e                	slli	a1,a1,0x3
 58e:	95aa                	add	a1,a1,a0
 590:	6598                	ld	a4,8(a1)
 592:	57fd                	li	a5,-1
 594:	00f70563          	beq	a4,a5,59e <thread_kill+0x1e>
        // printf("Thread %d has no handler for signal %d, it will be terminated on resume.\n", t->ID, signo);
        // Instead of calling thread_exit(), mark the function pointer to thread_exit, so that thread terminate when t resumes
        t->fp = (void (*)(void *)) thread_exit;  
    }
}
 598:	6422                	ld	s0,8(sp)
 59a:	0141                	addi	sp,sp,16
 59c:	8082                	ret
        t->fp = (void (*)(void *)) thread_exit;  
 59e:	00000797          	auipc	a5,0x0
 5a2:	b9e78793          	addi	a5,a5,-1122 # 13c <thread_exit>
 5a6:	e11c                	sd	a5,0(a0)
}
 5a8:	bfc5                	j	598 <thread_kill+0x18>

00000000000005aa <thread_suspend>:

void thread_suspend(struct thread *t) {
    //TO DO
    // Mark the thread as suspended (0)
    t->suspended = 0;
 5aa:	0a052e23          	sw	zero,188(a0)
    // If the current thread suspends itself, need to call thread_yield() as asked in the HW instructions
    if (t == current_thread) {
 5ae:	00001797          	auipc	a5,0x1
 5b2:	c8a7b783          	ld	a5,-886(a5) # 1238 <current_thread>
 5b6:	00a78363          	beq	a5,a0,5bc <thread_suspend+0x12>
 5ba:	8082                	ret
void thread_suspend(struct thread *t) {
 5bc:	1141                	addi	sp,sp,-16
 5be:	e406                	sd	ra,8(sp)
 5c0:	e022                	sd	s0,0(sp)
 5c2:	0800                	addi	s0,sp,16
        thread_yield();
 5c4:	00000097          	auipc	ra,0x0
 5c8:	e0e080e7          	jalr	-498(ra) # 3d2 <thread_yield>
    }
}
 5cc:	60a2                	ld	ra,8(sp)
 5ce:	6402                	ld	s0,0(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret

00000000000005d4 <thread_resume>:

void thread_resume(struct thread *t) {
 5d4:	1141                	addi	sp,sp,-16
 5d6:	e422                	sd	s0,8(sp)
 5d8:	0800                	addi	s0,sp,16
    //TO DO
    if (t->suspended == 0) {        // if the thread is suspended (suspended == 0)
 5da:	0bc52783          	lw	a5,188(a0)
 5de:	e781                	bnez	a5,5e6 <thread_resume+0x12>
        t->suspended = -1;          // set suspended to -1 to indicate that the thread is resumed
 5e0:	57fd                	li	a5,-1
 5e2:	0af52e23          	sw	a5,188(a0)
    }
}
 5e6:	6422                	ld	s0,8(sp)
 5e8:	0141                	addi	sp,sp,16
 5ea:	8082                	ret

00000000000005ec <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5f2:	87aa                	mv	a5,a0
 5f4:	0585                	addi	a1,a1,1
 5f6:	0785                	addi	a5,a5,1
 5f8:	fff5c703          	lbu	a4,-1(a1)
 5fc:	fee78fa3          	sb	a4,-1(a5)
 600:	fb75                	bnez	a4,5f4 <strcpy+0x8>
    ;
  return os;
}
 602:	6422                	ld	s0,8(sp)
 604:	0141                	addi	sp,sp,16
 606:	8082                	ret

0000000000000608 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 608:	1141                	addi	sp,sp,-16
 60a:	e422                	sd	s0,8(sp)
 60c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 60e:	00054783          	lbu	a5,0(a0)
 612:	cb91                	beqz	a5,626 <strcmp+0x1e>
 614:	0005c703          	lbu	a4,0(a1)
 618:	00f71763          	bne	a4,a5,626 <strcmp+0x1e>
    p++, q++;
 61c:	0505                	addi	a0,a0,1
 61e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 620:	00054783          	lbu	a5,0(a0)
 624:	fbe5                	bnez	a5,614 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 626:	0005c503          	lbu	a0,0(a1)
}
 62a:	40a7853b          	subw	a0,a5,a0
 62e:	6422                	ld	s0,8(sp)
 630:	0141                	addi	sp,sp,16
 632:	8082                	ret

0000000000000634 <strlen>:

uint
strlen(const char *s)
{
 634:	1141                	addi	sp,sp,-16
 636:	e422                	sd	s0,8(sp)
 638:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 63a:	00054783          	lbu	a5,0(a0)
 63e:	cf91                	beqz	a5,65a <strlen+0x26>
 640:	0505                	addi	a0,a0,1
 642:	87aa                	mv	a5,a0
 644:	4685                	li	a3,1
 646:	9e89                	subw	a3,a3,a0
 648:	00f6853b          	addw	a0,a3,a5
 64c:	0785                	addi	a5,a5,1
 64e:	fff7c703          	lbu	a4,-1(a5)
 652:	fb7d                	bnez	a4,648 <strlen+0x14>
    ;
  return n;
}
 654:	6422                	ld	s0,8(sp)
 656:	0141                	addi	sp,sp,16
 658:	8082                	ret
  for(n = 0; s[n]; n++)
 65a:	4501                	li	a0,0
 65c:	bfe5                	j	654 <strlen+0x20>

000000000000065e <memset>:

void*
memset(void *dst, int c, uint n)
{
 65e:	1141                	addi	sp,sp,-16
 660:	e422                	sd	s0,8(sp)
 662:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 664:	ce09                	beqz	a2,67e <memset+0x20>
 666:	87aa                	mv	a5,a0
 668:	fff6071b          	addiw	a4,a2,-1
 66c:	1702                	slli	a4,a4,0x20
 66e:	9301                	srli	a4,a4,0x20
 670:	0705                	addi	a4,a4,1
 672:	972a                	add	a4,a4,a0
    cdst[i] = c;
 674:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 678:	0785                	addi	a5,a5,1
 67a:	fee79de3          	bne	a5,a4,674 <memset+0x16>
  }
  return dst;
}
 67e:	6422                	ld	s0,8(sp)
 680:	0141                	addi	sp,sp,16
 682:	8082                	ret

0000000000000684 <strchr>:

char*
strchr(const char *s, char c)
{
 684:	1141                	addi	sp,sp,-16
 686:	e422                	sd	s0,8(sp)
 688:	0800                	addi	s0,sp,16
  for(; *s; s++)
 68a:	00054783          	lbu	a5,0(a0)
 68e:	cb99                	beqz	a5,6a4 <strchr+0x20>
    if(*s == c)
 690:	00f58763          	beq	a1,a5,69e <strchr+0x1a>
  for(; *s; s++)
 694:	0505                	addi	a0,a0,1
 696:	00054783          	lbu	a5,0(a0)
 69a:	fbfd                	bnez	a5,690 <strchr+0xc>
      return (char*)s;
  return 0;
 69c:	4501                	li	a0,0
}
 69e:	6422                	ld	s0,8(sp)
 6a0:	0141                	addi	sp,sp,16
 6a2:	8082                	ret
  return 0;
 6a4:	4501                	li	a0,0
 6a6:	bfe5                	j	69e <strchr+0x1a>

00000000000006a8 <gets>:

char*
gets(char *buf, int max)
{
 6a8:	711d                	addi	sp,sp,-96
 6aa:	ec86                	sd	ra,88(sp)
 6ac:	e8a2                	sd	s0,80(sp)
 6ae:	e4a6                	sd	s1,72(sp)
 6b0:	e0ca                	sd	s2,64(sp)
 6b2:	fc4e                	sd	s3,56(sp)
 6b4:	f852                	sd	s4,48(sp)
 6b6:	f456                	sd	s5,40(sp)
 6b8:	f05a                	sd	s6,32(sp)
 6ba:	ec5e                	sd	s7,24(sp)
 6bc:	1080                	addi	s0,sp,96
 6be:	8baa                	mv	s7,a0
 6c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6c2:	892a                	mv	s2,a0
 6c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 6c6:	4aa9                	li	s5,10
 6c8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 6ca:	89a6                	mv	s3,s1
 6cc:	2485                	addiw	s1,s1,1
 6ce:	0344d863          	bge	s1,s4,6fe <gets+0x56>
    cc = read(0, &c, 1);
 6d2:	4605                	li	a2,1
 6d4:	faf40593          	addi	a1,s0,-81
 6d8:	4501                	li	a0,0
 6da:	00000097          	auipc	ra,0x0
 6de:	1a0080e7          	jalr	416(ra) # 87a <read>
    if(cc < 1)
 6e2:	00a05e63          	blez	a0,6fe <gets+0x56>
    buf[i++] = c;
 6e6:	faf44783          	lbu	a5,-81(s0)
 6ea:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 6ee:	01578763          	beq	a5,s5,6fc <gets+0x54>
 6f2:	0905                	addi	s2,s2,1
 6f4:	fd679be3          	bne	a5,s6,6ca <gets+0x22>
  for(i=0; i+1 < max; ){
 6f8:	89a6                	mv	s3,s1
 6fa:	a011                	j	6fe <gets+0x56>
 6fc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6fe:	99de                	add	s3,s3,s7
 700:	00098023          	sb	zero,0(s3)
  return buf;
}
 704:	855e                	mv	a0,s7
 706:	60e6                	ld	ra,88(sp)
 708:	6446                	ld	s0,80(sp)
 70a:	64a6                	ld	s1,72(sp)
 70c:	6906                	ld	s2,64(sp)
 70e:	79e2                	ld	s3,56(sp)
 710:	7a42                	ld	s4,48(sp)
 712:	7aa2                	ld	s5,40(sp)
 714:	7b02                	ld	s6,32(sp)
 716:	6be2                	ld	s7,24(sp)
 718:	6125                	addi	sp,sp,96
 71a:	8082                	ret

000000000000071c <stat>:

int
stat(const char *n, struct stat *st)
{
 71c:	1101                	addi	sp,sp,-32
 71e:	ec06                	sd	ra,24(sp)
 720:	e822                	sd	s0,16(sp)
 722:	e426                	sd	s1,8(sp)
 724:	e04a                	sd	s2,0(sp)
 726:	1000                	addi	s0,sp,32
 728:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 72a:	4581                	li	a1,0
 72c:	00000097          	auipc	ra,0x0
 730:	176080e7          	jalr	374(ra) # 8a2 <open>
  if(fd < 0)
 734:	02054563          	bltz	a0,75e <stat+0x42>
 738:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 73a:	85ca                	mv	a1,s2
 73c:	00000097          	auipc	ra,0x0
 740:	17e080e7          	jalr	382(ra) # 8ba <fstat>
 744:	892a                	mv	s2,a0
  close(fd);
 746:	8526                	mv	a0,s1
 748:	00000097          	auipc	ra,0x0
 74c:	142080e7          	jalr	322(ra) # 88a <close>
  return r;
}
 750:	854a                	mv	a0,s2
 752:	60e2                	ld	ra,24(sp)
 754:	6442                	ld	s0,16(sp)
 756:	64a2                	ld	s1,8(sp)
 758:	6902                	ld	s2,0(sp)
 75a:	6105                	addi	sp,sp,32
 75c:	8082                	ret
    return -1;
 75e:	597d                	li	s2,-1
 760:	bfc5                	j	750 <stat+0x34>

0000000000000762 <atoi>:

int
atoi(const char *s)
{
 762:	1141                	addi	sp,sp,-16
 764:	e422                	sd	s0,8(sp)
 766:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 768:	00054603          	lbu	a2,0(a0)
 76c:	fd06079b          	addiw	a5,a2,-48
 770:	0ff7f793          	andi	a5,a5,255
 774:	4725                	li	a4,9
 776:	02f76963          	bltu	a4,a5,7a8 <atoi+0x46>
 77a:	86aa                	mv	a3,a0
  n = 0;
 77c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 77e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 780:	0685                	addi	a3,a3,1
 782:	0025179b          	slliw	a5,a0,0x2
 786:	9fa9                	addw	a5,a5,a0
 788:	0017979b          	slliw	a5,a5,0x1
 78c:	9fb1                	addw	a5,a5,a2
 78e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 792:	0006c603          	lbu	a2,0(a3)
 796:	fd06071b          	addiw	a4,a2,-48
 79a:	0ff77713          	andi	a4,a4,255
 79e:	fee5f1e3          	bgeu	a1,a4,780 <atoi+0x1e>
  return n;
}
 7a2:	6422                	ld	s0,8(sp)
 7a4:	0141                	addi	sp,sp,16
 7a6:	8082                	ret
  n = 0;
 7a8:	4501                	li	a0,0
 7aa:	bfe5                	j	7a2 <atoi+0x40>

00000000000007ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 7ac:	1141                	addi	sp,sp,-16
 7ae:	e422                	sd	s0,8(sp)
 7b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 7b2:	02b57663          	bgeu	a0,a1,7de <memmove+0x32>
    while(n-- > 0)
 7b6:	02c05163          	blez	a2,7d8 <memmove+0x2c>
 7ba:	fff6079b          	addiw	a5,a2,-1
 7be:	1782                	slli	a5,a5,0x20
 7c0:	9381                	srli	a5,a5,0x20
 7c2:	0785                	addi	a5,a5,1
 7c4:	97aa                	add	a5,a5,a0
  dst = vdst;
 7c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 7c8:	0585                	addi	a1,a1,1
 7ca:	0705                	addi	a4,a4,1
 7cc:	fff5c683          	lbu	a3,-1(a1)
 7d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 7d4:	fee79ae3          	bne	a5,a4,7c8 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 7d8:	6422                	ld	s0,8(sp)
 7da:	0141                	addi	sp,sp,16
 7dc:	8082                	ret
    dst += n;
 7de:	00c50733          	add	a4,a0,a2
    src += n;
 7e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 7e4:	fec05ae3          	blez	a2,7d8 <memmove+0x2c>
 7e8:	fff6079b          	addiw	a5,a2,-1
 7ec:	1782                	slli	a5,a5,0x20
 7ee:	9381                	srli	a5,a5,0x20
 7f0:	fff7c793          	not	a5,a5
 7f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7f6:	15fd                	addi	a1,a1,-1
 7f8:	177d                	addi	a4,a4,-1
 7fa:	0005c683          	lbu	a3,0(a1)
 7fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 802:	fee79ae3          	bne	a5,a4,7f6 <memmove+0x4a>
 806:	bfc9                	j	7d8 <memmove+0x2c>

0000000000000808 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 808:	1141                	addi	sp,sp,-16
 80a:	e422                	sd	s0,8(sp)
 80c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 80e:	ca05                	beqz	a2,83e <memcmp+0x36>
 810:	fff6069b          	addiw	a3,a2,-1
 814:	1682                	slli	a3,a3,0x20
 816:	9281                	srli	a3,a3,0x20
 818:	0685                	addi	a3,a3,1
 81a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 81c:	00054783          	lbu	a5,0(a0)
 820:	0005c703          	lbu	a4,0(a1)
 824:	00e79863          	bne	a5,a4,834 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 828:	0505                	addi	a0,a0,1
    p2++;
 82a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 82c:	fed518e3          	bne	a0,a3,81c <memcmp+0x14>
  }
  return 0;
 830:	4501                	li	a0,0
 832:	a019                	j	838 <memcmp+0x30>
      return *p1 - *p2;
 834:	40e7853b          	subw	a0,a5,a4
}
 838:	6422                	ld	s0,8(sp)
 83a:	0141                	addi	sp,sp,16
 83c:	8082                	ret
  return 0;
 83e:	4501                	li	a0,0
 840:	bfe5                	j	838 <memcmp+0x30>

0000000000000842 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 842:	1141                	addi	sp,sp,-16
 844:	e406                	sd	ra,8(sp)
 846:	e022                	sd	s0,0(sp)
 848:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 84a:	00000097          	auipc	ra,0x0
 84e:	f62080e7          	jalr	-158(ra) # 7ac <memmove>
}
 852:	60a2                	ld	ra,8(sp)
 854:	6402                	ld	s0,0(sp)
 856:	0141                	addi	sp,sp,16
 858:	8082                	ret

000000000000085a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 85a:	4885                	li	a7,1
 ecall
 85c:	00000073          	ecall
 ret
 860:	8082                	ret

0000000000000862 <exit>:
.global exit
exit:
 li a7, SYS_exit
 862:	4889                	li	a7,2
 ecall
 864:	00000073          	ecall
 ret
 868:	8082                	ret

000000000000086a <wait>:
.global wait
wait:
 li a7, SYS_wait
 86a:	488d                	li	a7,3
 ecall
 86c:	00000073          	ecall
 ret
 870:	8082                	ret

0000000000000872 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 872:	4891                	li	a7,4
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <read>:
.global read
read:
 li a7, SYS_read
 87a:	4895                	li	a7,5
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <write>:
.global write
write:
 li a7, SYS_write
 882:	48c1                	li	a7,16
 ecall
 884:	00000073          	ecall
 ret
 888:	8082                	ret

000000000000088a <close>:
.global close
close:
 li a7, SYS_close
 88a:	48d5                	li	a7,21
 ecall
 88c:	00000073          	ecall
 ret
 890:	8082                	ret

0000000000000892 <kill>:
.global kill
kill:
 li a7, SYS_kill
 892:	4899                	li	a7,6
 ecall
 894:	00000073          	ecall
 ret
 898:	8082                	ret

000000000000089a <exec>:
.global exec
exec:
 li a7, SYS_exec
 89a:	489d                	li	a7,7
 ecall
 89c:	00000073          	ecall
 ret
 8a0:	8082                	ret

00000000000008a2 <open>:
.global open
open:
 li a7, SYS_open
 8a2:	48bd                	li	a7,15
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 8aa:	48c5                	li	a7,17
 ecall
 8ac:	00000073          	ecall
 ret
 8b0:	8082                	ret

00000000000008b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 8b2:	48c9                	li	a7,18
 ecall
 8b4:	00000073          	ecall
 ret
 8b8:	8082                	ret

00000000000008ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 8ba:	48a1                	li	a7,8
 ecall
 8bc:	00000073          	ecall
 ret
 8c0:	8082                	ret

00000000000008c2 <link>:
.global link
link:
 li a7, SYS_link
 8c2:	48cd                	li	a7,19
 ecall
 8c4:	00000073          	ecall
 ret
 8c8:	8082                	ret

00000000000008ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 8ca:	48d1                	li	a7,20
 ecall
 8cc:	00000073          	ecall
 ret
 8d0:	8082                	ret

00000000000008d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 8d2:	48a5                	li	a7,9
 ecall
 8d4:	00000073          	ecall
 ret
 8d8:	8082                	ret

00000000000008da <dup>:
.global dup
dup:
 li a7, SYS_dup
 8da:	48a9                	li	a7,10
 ecall
 8dc:	00000073          	ecall
 ret
 8e0:	8082                	ret

00000000000008e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 8e2:	48ad                	li	a7,11
 ecall
 8e4:	00000073          	ecall
 ret
 8e8:	8082                	ret

00000000000008ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 8ea:	48b1                	li	a7,12
 ecall
 8ec:	00000073          	ecall
 ret
 8f0:	8082                	ret

00000000000008f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8f2:	48b5                	li	a7,13
 ecall
 8f4:	00000073          	ecall
 ret
 8f8:	8082                	ret

00000000000008fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8fa:	48b9                	li	a7,14
 ecall
 8fc:	00000073          	ecall
 ret
 900:	8082                	ret

0000000000000902 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 902:	1101                	addi	sp,sp,-32
 904:	ec06                	sd	ra,24(sp)
 906:	e822                	sd	s0,16(sp)
 908:	1000                	addi	s0,sp,32
 90a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 90e:	4605                	li	a2,1
 910:	fef40593          	addi	a1,s0,-17
 914:	00000097          	auipc	ra,0x0
 918:	f6e080e7          	jalr	-146(ra) # 882 <write>
}
 91c:	60e2                	ld	ra,24(sp)
 91e:	6442                	ld	s0,16(sp)
 920:	6105                	addi	sp,sp,32
 922:	8082                	ret

0000000000000924 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 924:	7139                	addi	sp,sp,-64
 926:	fc06                	sd	ra,56(sp)
 928:	f822                	sd	s0,48(sp)
 92a:	f426                	sd	s1,40(sp)
 92c:	f04a                	sd	s2,32(sp)
 92e:	ec4e                	sd	s3,24(sp)
 930:	0080                	addi	s0,sp,64
 932:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 934:	c299                	beqz	a3,93a <printint+0x16>
 936:	0805c863          	bltz	a1,9c6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 93a:	2581                	sext.w	a1,a1
  neg = 0;
 93c:	4881                	li	a7,0
 93e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 942:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 944:	2601                	sext.w	a2,a2
 946:	00001517          	auipc	a0,0x1
 94a:	8da50513          	addi	a0,a0,-1830 # 1220 <digits>
 94e:	883a                	mv	a6,a4
 950:	2705                	addiw	a4,a4,1
 952:	02c5f7bb          	remuw	a5,a1,a2
 956:	1782                	slli	a5,a5,0x20
 958:	9381                	srli	a5,a5,0x20
 95a:	97aa                	add	a5,a5,a0
 95c:	0007c783          	lbu	a5,0(a5)
 960:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 964:	0005879b          	sext.w	a5,a1
 968:	02c5d5bb          	divuw	a1,a1,a2
 96c:	0685                	addi	a3,a3,1
 96e:	fec7f0e3          	bgeu	a5,a2,94e <printint+0x2a>
  if(neg)
 972:	00088b63          	beqz	a7,988 <printint+0x64>
    buf[i++] = '-';
 976:	fd040793          	addi	a5,s0,-48
 97a:	973e                	add	a4,a4,a5
 97c:	02d00793          	li	a5,45
 980:	fef70823          	sb	a5,-16(a4)
 984:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 988:	02e05863          	blez	a4,9b8 <printint+0x94>
 98c:	fc040793          	addi	a5,s0,-64
 990:	00e78933          	add	s2,a5,a4
 994:	fff78993          	addi	s3,a5,-1
 998:	99ba                	add	s3,s3,a4
 99a:	377d                	addiw	a4,a4,-1
 99c:	1702                	slli	a4,a4,0x20
 99e:	9301                	srli	a4,a4,0x20
 9a0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 9a4:	fff94583          	lbu	a1,-1(s2)
 9a8:	8526                	mv	a0,s1
 9aa:	00000097          	auipc	ra,0x0
 9ae:	f58080e7          	jalr	-168(ra) # 902 <putc>
  while(--i >= 0)
 9b2:	197d                	addi	s2,s2,-1
 9b4:	ff3918e3          	bne	s2,s3,9a4 <printint+0x80>
}
 9b8:	70e2                	ld	ra,56(sp)
 9ba:	7442                	ld	s0,48(sp)
 9bc:	74a2                	ld	s1,40(sp)
 9be:	7902                	ld	s2,32(sp)
 9c0:	69e2                	ld	s3,24(sp)
 9c2:	6121                	addi	sp,sp,64
 9c4:	8082                	ret
    x = -xx;
 9c6:	40b005bb          	negw	a1,a1
    neg = 1;
 9ca:	4885                	li	a7,1
    x = -xx;
 9cc:	bf8d                	j	93e <printint+0x1a>

00000000000009ce <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 9ce:	7119                	addi	sp,sp,-128
 9d0:	fc86                	sd	ra,120(sp)
 9d2:	f8a2                	sd	s0,112(sp)
 9d4:	f4a6                	sd	s1,104(sp)
 9d6:	f0ca                	sd	s2,96(sp)
 9d8:	ecce                	sd	s3,88(sp)
 9da:	e8d2                	sd	s4,80(sp)
 9dc:	e4d6                	sd	s5,72(sp)
 9de:	e0da                	sd	s6,64(sp)
 9e0:	fc5e                	sd	s7,56(sp)
 9e2:	f862                	sd	s8,48(sp)
 9e4:	f466                	sd	s9,40(sp)
 9e6:	f06a                	sd	s10,32(sp)
 9e8:	ec6e                	sd	s11,24(sp)
 9ea:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 9ec:	0005c903          	lbu	s2,0(a1)
 9f0:	18090f63          	beqz	s2,b8e <vprintf+0x1c0>
 9f4:	8aaa                	mv	s5,a0
 9f6:	8b32                	mv	s6,a2
 9f8:	00158493          	addi	s1,a1,1
  state = 0;
 9fc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9fe:	02500a13          	li	s4,37
      if(c == 'd'){
 a02:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 a06:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 a0a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 a0e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a12:	00001b97          	auipc	s7,0x1
 a16:	80eb8b93          	addi	s7,s7,-2034 # 1220 <digits>
 a1a:	a839                	j	a38 <vprintf+0x6a>
        putc(fd, c);
 a1c:	85ca                	mv	a1,s2
 a1e:	8556                	mv	a0,s5
 a20:	00000097          	auipc	ra,0x0
 a24:	ee2080e7          	jalr	-286(ra) # 902 <putc>
 a28:	a019                	j	a2e <vprintf+0x60>
    } else if(state == '%'){
 a2a:	01498f63          	beq	s3,s4,a48 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 a2e:	0485                	addi	s1,s1,1
 a30:	fff4c903          	lbu	s2,-1(s1)
 a34:	14090d63          	beqz	s2,b8e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 a38:	0009079b          	sext.w	a5,s2
    if(state == 0){
 a3c:	fe0997e3          	bnez	s3,a2a <vprintf+0x5c>
      if(c == '%'){
 a40:	fd479ee3          	bne	a5,s4,a1c <vprintf+0x4e>
        state = '%';
 a44:	89be                	mv	s3,a5
 a46:	b7e5                	j	a2e <vprintf+0x60>
      if(c == 'd'){
 a48:	05878063          	beq	a5,s8,a88 <vprintf+0xba>
      } else if(c == 'l') {
 a4c:	05978c63          	beq	a5,s9,aa4 <vprintf+0xd6>
      } else if(c == 'x') {
 a50:	07a78863          	beq	a5,s10,ac0 <vprintf+0xf2>
      } else if(c == 'p') {
 a54:	09b78463          	beq	a5,s11,adc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 a58:	07300713          	li	a4,115
 a5c:	0ce78663          	beq	a5,a4,b28 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a60:	06300713          	li	a4,99
 a64:	0ee78e63          	beq	a5,a4,b60 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 a68:	11478863          	beq	a5,s4,b78 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a6c:	85d2                	mv	a1,s4
 a6e:	8556                	mv	a0,s5
 a70:	00000097          	auipc	ra,0x0
 a74:	e92080e7          	jalr	-366(ra) # 902 <putc>
        putc(fd, c);
 a78:	85ca                	mv	a1,s2
 a7a:	8556                	mv	a0,s5
 a7c:	00000097          	auipc	ra,0x0
 a80:	e86080e7          	jalr	-378(ra) # 902 <putc>
      }
      state = 0;
 a84:	4981                	li	s3,0
 a86:	b765                	j	a2e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 a88:	008b0913          	addi	s2,s6,8
 a8c:	4685                	li	a3,1
 a8e:	4629                	li	a2,10
 a90:	000b2583          	lw	a1,0(s6)
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	e8e080e7          	jalr	-370(ra) # 924 <printint>
 a9e:	8b4a                	mv	s6,s2
      state = 0;
 aa0:	4981                	li	s3,0
 aa2:	b771                	j	a2e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa4:	008b0913          	addi	s2,s6,8
 aa8:	4681                	li	a3,0
 aaa:	4629                	li	a2,10
 aac:	000b2583          	lw	a1,0(s6)
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	e72080e7          	jalr	-398(ra) # 924 <printint>
 aba:	8b4a                	mv	s6,s2
      state = 0;
 abc:	4981                	li	s3,0
 abe:	bf85                	j	a2e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 ac0:	008b0913          	addi	s2,s6,8
 ac4:	4681                	li	a3,0
 ac6:	4641                	li	a2,16
 ac8:	000b2583          	lw	a1,0(s6)
 acc:	8556                	mv	a0,s5
 ace:	00000097          	auipc	ra,0x0
 ad2:	e56080e7          	jalr	-426(ra) # 924 <printint>
 ad6:	8b4a                	mv	s6,s2
      state = 0;
 ad8:	4981                	li	s3,0
 ada:	bf91                	j	a2e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 adc:	008b0793          	addi	a5,s6,8
 ae0:	f8f43423          	sd	a5,-120(s0)
 ae4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 ae8:	03000593          	li	a1,48
 aec:	8556                	mv	a0,s5
 aee:	00000097          	auipc	ra,0x0
 af2:	e14080e7          	jalr	-492(ra) # 902 <putc>
  putc(fd, 'x');
 af6:	85ea                	mv	a1,s10
 af8:	8556                	mv	a0,s5
 afa:	00000097          	auipc	ra,0x0
 afe:	e08080e7          	jalr	-504(ra) # 902 <putc>
 b02:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b04:	03c9d793          	srli	a5,s3,0x3c
 b08:	97de                	add	a5,a5,s7
 b0a:	0007c583          	lbu	a1,0(a5)
 b0e:	8556                	mv	a0,s5
 b10:	00000097          	auipc	ra,0x0
 b14:	df2080e7          	jalr	-526(ra) # 902 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b18:	0992                	slli	s3,s3,0x4
 b1a:	397d                	addiw	s2,s2,-1
 b1c:	fe0914e3          	bnez	s2,b04 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 b20:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 b24:	4981                	li	s3,0
 b26:	b721                	j	a2e <vprintf+0x60>
        s = va_arg(ap, char*);
 b28:	008b0993          	addi	s3,s6,8
 b2c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 b30:	02090163          	beqz	s2,b52 <vprintf+0x184>
        while(*s != 0){
 b34:	00094583          	lbu	a1,0(s2)
 b38:	c9a1                	beqz	a1,b88 <vprintf+0x1ba>
          putc(fd, *s);
 b3a:	8556                	mv	a0,s5
 b3c:	00000097          	auipc	ra,0x0
 b40:	dc6080e7          	jalr	-570(ra) # 902 <putc>
          s++;
 b44:	0905                	addi	s2,s2,1
        while(*s != 0){
 b46:	00094583          	lbu	a1,0(s2)
 b4a:	f9e5                	bnez	a1,b3a <vprintf+0x16c>
        s = va_arg(ap, char*);
 b4c:	8b4e                	mv	s6,s3
      state = 0;
 b4e:	4981                	li	s3,0
 b50:	bdf9                	j	a2e <vprintf+0x60>
          s = "(null)";
 b52:	00000917          	auipc	s2,0x0
 b56:	6c690913          	addi	s2,s2,1734 # 1218 <longjmp_1+0x42a>
        while(*s != 0){
 b5a:	02800593          	li	a1,40
 b5e:	bff1                	j	b3a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 b60:	008b0913          	addi	s2,s6,8
 b64:	000b4583          	lbu	a1,0(s6)
 b68:	8556                	mv	a0,s5
 b6a:	00000097          	auipc	ra,0x0
 b6e:	d98080e7          	jalr	-616(ra) # 902 <putc>
 b72:	8b4a                	mv	s6,s2
      state = 0;
 b74:	4981                	li	s3,0
 b76:	bd65                	j	a2e <vprintf+0x60>
        putc(fd, c);
 b78:	85d2                	mv	a1,s4
 b7a:	8556                	mv	a0,s5
 b7c:	00000097          	auipc	ra,0x0
 b80:	d86080e7          	jalr	-634(ra) # 902 <putc>
      state = 0;
 b84:	4981                	li	s3,0
 b86:	b565                	j	a2e <vprintf+0x60>
        s = va_arg(ap, char*);
 b88:	8b4e                	mv	s6,s3
      state = 0;
 b8a:	4981                	li	s3,0
 b8c:	b54d                	j	a2e <vprintf+0x60>
    }
  }
}
 b8e:	70e6                	ld	ra,120(sp)
 b90:	7446                	ld	s0,112(sp)
 b92:	74a6                	ld	s1,104(sp)
 b94:	7906                	ld	s2,96(sp)
 b96:	69e6                	ld	s3,88(sp)
 b98:	6a46                	ld	s4,80(sp)
 b9a:	6aa6                	ld	s5,72(sp)
 b9c:	6b06                	ld	s6,64(sp)
 b9e:	7be2                	ld	s7,56(sp)
 ba0:	7c42                	ld	s8,48(sp)
 ba2:	7ca2                	ld	s9,40(sp)
 ba4:	7d02                	ld	s10,32(sp)
 ba6:	6de2                	ld	s11,24(sp)
 ba8:	6109                	addi	sp,sp,128
 baa:	8082                	ret

0000000000000bac <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bac:	715d                	addi	sp,sp,-80
 bae:	ec06                	sd	ra,24(sp)
 bb0:	e822                	sd	s0,16(sp)
 bb2:	1000                	addi	s0,sp,32
 bb4:	e010                	sd	a2,0(s0)
 bb6:	e414                	sd	a3,8(s0)
 bb8:	e818                	sd	a4,16(s0)
 bba:	ec1c                	sd	a5,24(s0)
 bbc:	03043023          	sd	a6,32(s0)
 bc0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 bc4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 bc8:	8622                	mv	a2,s0
 bca:	00000097          	auipc	ra,0x0
 bce:	e04080e7          	jalr	-508(ra) # 9ce <vprintf>
}
 bd2:	60e2                	ld	ra,24(sp)
 bd4:	6442                	ld	s0,16(sp)
 bd6:	6161                	addi	sp,sp,80
 bd8:	8082                	ret

0000000000000bda <printf>:

void
printf(const char *fmt, ...)
{
 bda:	711d                	addi	sp,sp,-96
 bdc:	ec06                	sd	ra,24(sp)
 bde:	e822                	sd	s0,16(sp)
 be0:	1000                	addi	s0,sp,32
 be2:	e40c                	sd	a1,8(s0)
 be4:	e810                	sd	a2,16(s0)
 be6:	ec14                	sd	a3,24(s0)
 be8:	f018                	sd	a4,32(s0)
 bea:	f41c                	sd	a5,40(s0)
 bec:	03043823          	sd	a6,48(s0)
 bf0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bf4:	00840613          	addi	a2,s0,8
 bf8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bfc:	85aa                	mv	a1,a0
 bfe:	4505                	li	a0,1
 c00:	00000097          	auipc	ra,0x0
 c04:	dce080e7          	jalr	-562(ra) # 9ce <vprintf>
}
 c08:	60e2                	ld	ra,24(sp)
 c0a:	6442                	ld	s0,16(sp)
 c0c:	6125                	addi	sp,sp,96
 c0e:	8082                	ret

0000000000000c10 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c10:	1141                	addi	sp,sp,-16
 c12:	e422                	sd	s0,8(sp)
 c14:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c16:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c1a:	00000797          	auipc	a5,0x0
 c1e:	6267b783          	ld	a5,1574(a5) # 1240 <freep>
 c22:	a805                	j	c52 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c24:	4618                	lw	a4,8(a2)
 c26:	9db9                	addw	a1,a1,a4
 c28:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c2c:	6398                	ld	a4,0(a5)
 c2e:	6318                	ld	a4,0(a4)
 c30:	fee53823          	sd	a4,-16(a0)
 c34:	a091                	j	c78 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c36:	ff852703          	lw	a4,-8(a0)
 c3a:	9e39                	addw	a2,a2,a4
 c3c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 c3e:	ff053703          	ld	a4,-16(a0)
 c42:	e398                	sd	a4,0(a5)
 c44:	a099                	j	c8a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c46:	6398                	ld	a4,0(a5)
 c48:	00e7e463          	bltu	a5,a4,c50 <free+0x40>
 c4c:	00e6ea63          	bltu	a3,a4,c60 <free+0x50>
{
 c50:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c52:	fed7fae3          	bgeu	a5,a3,c46 <free+0x36>
 c56:	6398                	ld	a4,0(a5)
 c58:	00e6e463          	bltu	a3,a4,c60 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c5c:	fee7eae3          	bltu	a5,a4,c50 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 c60:	ff852583          	lw	a1,-8(a0)
 c64:	6390                	ld	a2,0(a5)
 c66:	02059713          	slli	a4,a1,0x20
 c6a:	9301                	srli	a4,a4,0x20
 c6c:	0712                	slli	a4,a4,0x4
 c6e:	9736                	add	a4,a4,a3
 c70:	fae60ae3          	beq	a2,a4,c24 <free+0x14>
    bp->s.ptr = p->s.ptr;
 c74:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c78:	4790                	lw	a2,8(a5)
 c7a:	02061713          	slli	a4,a2,0x20
 c7e:	9301                	srli	a4,a4,0x20
 c80:	0712                	slli	a4,a4,0x4
 c82:	973e                	add	a4,a4,a5
 c84:	fae689e3          	beq	a3,a4,c36 <free+0x26>
  } else
    p->s.ptr = bp;
 c88:	e394                	sd	a3,0(a5)
  freep = p;
 c8a:	00000717          	auipc	a4,0x0
 c8e:	5af73b23          	sd	a5,1462(a4) # 1240 <freep>
}
 c92:	6422                	ld	s0,8(sp)
 c94:	0141                	addi	sp,sp,16
 c96:	8082                	ret

0000000000000c98 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c98:	7139                	addi	sp,sp,-64
 c9a:	fc06                	sd	ra,56(sp)
 c9c:	f822                	sd	s0,48(sp)
 c9e:	f426                	sd	s1,40(sp)
 ca0:	f04a                	sd	s2,32(sp)
 ca2:	ec4e                	sd	s3,24(sp)
 ca4:	e852                	sd	s4,16(sp)
 ca6:	e456                	sd	s5,8(sp)
 ca8:	e05a                	sd	s6,0(sp)
 caa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cac:	02051493          	slli	s1,a0,0x20
 cb0:	9081                	srli	s1,s1,0x20
 cb2:	04bd                	addi	s1,s1,15
 cb4:	8091                	srli	s1,s1,0x4
 cb6:	0014899b          	addiw	s3,s1,1
 cba:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 cbc:	00000517          	auipc	a0,0x0
 cc0:	58453503          	ld	a0,1412(a0) # 1240 <freep>
 cc4:	c515                	beqz	a0,cf0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cc8:	4798                	lw	a4,8(a5)
 cca:	02977f63          	bgeu	a4,s1,d08 <malloc+0x70>
 cce:	8a4e                	mv	s4,s3
 cd0:	0009871b          	sext.w	a4,s3
 cd4:	6685                	lui	a3,0x1
 cd6:	00d77363          	bgeu	a4,a3,cdc <malloc+0x44>
 cda:	6a05                	lui	s4,0x1
 cdc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ce0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ce4:	00000917          	auipc	s2,0x0
 ce8:	55c90913          	addi	s2,s2,1372 # 1240 <freep>
  if(p == (char*)-1)
 cec:	5afd                	li	s5,-1
 cee:	a88d                	j	d60 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 cf0:	00000797          	auipc	a5,0x0
 cf4:	5c878793          	addi	a5,a5,1480 # 12b8 <base>
 cf8:	00000717          	auipc	a4,0x0
 cfc:	54f73423          	sd	a5,1352(a4) # 1240 <freep>
 d00:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 d02:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 d06:	b7e1                	j	cce <malloc+0x36>
      if(p->s.size == nunits)
 d08:	02e48b63          	beq	s1,a4,d3e <malloc+0xa6>
        p->s.size -= nunits;
 d0c:	4137073b          	subw	a4,a4,s3
 d10:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d12:	1702                	slli	a4,a4,0x20
 d14:	9301                	srli	a4,a4,0x20
 d16:	0712                	slli	a4,a4,0x4
 d18:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d1a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d1e:	00000717          	auipc	a4,0x0
 d22:	52a73123          	sd	a0,1314(a4) # 1240 <freep>
      return (void*)(p + 1);
 d26:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 d2a:	70e2                	ld	ra,56(sp)
 d2c:	7442                	ld	s0,48(sp)
 d2e:	74a2                	ld	s1,40(sp)
 d30:	7902                	ld	s2,32(sp)
 d32:	69e2                	ld	s3,24(sp)
 d34:	6a42                	ld	s4,16(sp)
 d36:	6aa2                	ld	s5,8(sp)
 d38:	6b02                	ld	s6,0(sp)
 d3a:	6121                	addi	sp,sp,64
 d3c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d3e:	6398                	ld	a4,0(a5)
 d40:	e118                	sd	a4,0(a0)
 d42:	bff1                	j	d1e <malloc+0x86>
  hp->s.size = nu;
 d44:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d48:	0541                	addi	a0,a0,16
 d4a:	00000097          	auipc	ra,0x0
 d4e:	ec6080e7          	jalr	-314(ra) # c10 <free>
  return freep;
 d52:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d56:	d971                	beqz	a0,d2a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d5a:	4798                	lw	a4,8(a5)
 d5c:	fa9776e3          	bgeu	a4,s1,d08 <malloc+0x70>
    if(p == freep)
 d60:	00093703          	ld	a4,0(s2)
 d64:	853e                	mv	a0,a5
 d66:	fef719e3          	bne	a4,a5,d58 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 d6a:	8552                	mv	a0,s4
 d6c:	00000097          	auipc	ra,0x0
 d70:	b7e080e7          	jalr	-1154(ra) # 8ea <sbrk>
  if(p == (char*)-1)
 d74:	fd5518e3          	bne	a0,s5,d44 <malloc+0xac>
        return 0;
 d78:	4501                	li	a0,0
 d7a:	bf45                	j	d2a <malloc+0x92>

0000000000000d7c <setjmp>:
 d7c:	e100                	sd	s0,0(a0)
 d7e:	e504                	sd	s1,8(a0)
 d80:	01253823          	sd	s2,16(a0)
 d84:	01353c23          	sd	s3,24(a0)
 d88:	03453023          	sd	s4,32(a0)
 d8c:	03553423          	sd	s5,40(a0)
 d90:	03653823          	sd	s6,48(a0)
 d94:	03753c23          	sd	s7,56(a0)
 d98:	05853023          	sd	s8,64(a0)
 d9c:	05953423          	sd	s9,72(a0)
 da0:	05a53823          	sd	s10,80(a0)
 da4:	05b53c23          	sd	s11,88(a0)
 da8:	06153023          	sd	ra,96(a0)
 dac:	06253423          	sd	sp,104(a0)
 db0:	4501                	li	a0,0
 db2:	8082                	ret

0000000000000db4 <longjmp>:
 db4:	6100                	ld	s0,0(a0)
 db6:	6504                	ld	s1,8(a0)
 db8:	01053903          	ld	s2,16(a0)
 dbc:	01853983          	ld	s3,24(a0)
 dc0:	02053a03          	ld	s4,32(a0)
 dc4:	02853a83          	ld	s5,40(a0)
 dc8:	03053b03          	ld	s6,48(a0)
 dcc:	03853b83          	ld	s7,56(a0)
 dd0:	04053c03          	ld	s8,64(a0)
 dd4:	04853c83          	ld	s9,72(a0)
 dd8:	05053d03          	ld	s10,80(a0)
 ddc:	05853d83          	ld	s11,88(a0)
 de0:	06053083          	ld	ra,96(a0)
 de4:	06853103          	ld	sp,104(a0)
 de8:	c199                	beqz	a1,dee <longjmp_1>
 dea:	852e                	mv	a0,a1
 dec:	8082                	ret

0000000000000dee <longjmp_1>:
 dee:	4505                	li	a0,1
 df0:	8082                	ret
