
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
  1a:	a18080e7          	jalr	-1512(ra) # a2e <malloc>
  1e:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  20:	6505                	lui	a0,0x1
  22:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0x9c>
  26:	00001097          	auipc	ra,0x1
  2a:	a08080e7          	jalr	-1528(ra) # a2e <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
  2e:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  32:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
  36:	00001717          	auipc	a4,0x1
  3a:	b6e70713          	addi	a4,a4,-1170 # ba4 <id>
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
    //printf("create thread success\n");
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
  80:	b2c7b783          	ld	a5,-1236(a5) # ba8 <current_thread>
  84:	cf91                	beqz	a5,a0 <thread_add_runqueue+0x2a>
        current_thread->next = current_thread;
        current_thread->previous = current_thread;

    }
    else{
        t->sig_handler[0] = current_thread->sig_handler[0];
  86:	7bd8                	ld	a4,176(a5)
  88:	f958                	sd	a4,176(a0)
        t->sig_handler[1] = current_thread->sig_handler[1];
  8a:	7fd8                	ld	a4,184(a5)
  8c:	fd58                	sd	a4,184(a0)
        // TODO
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
  a4:	b0a7b423          	sd	a0,-1272(a5) # ba8 <current_thread>
        current_thread->next = current_thread;
  a8:	f148                	sd	a0,160(a0)
        current_thread->previous = current_thread;
  aa:	ed48                	sd	a0,152(a0)
  ac:	b7fd                	j	9a <thread_add_runqueue+0x24>

00000000000000ae <schedule>:
            }
        }
        thread_exit();
    }
}
void schedule(void){
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
    // TODO
    //printf("schedule\n");
    current_thread = current_thread->next;
  b4:	00001717          	auipc	a4,0x1
  b8:	af470713          	addi	a4,a4,-1292 # ba8 <current_thread>
  bc:	631c                	ld	a5,0(a4)
  be:	73dc                	ld	a5,160(a5)
  c0:	e31c                	sd	a5,0(a4)
    
    // Skip suspended threads
    while (current_thread->suspended) {
  c2:	0a87a703          	lw	a4,168(a5)
  c6:	cb09                	beqz	a4,d8 <schedule+0x2a>
        current_thread = current_thread->next;
  c8:	73dc                	ld	a5,160(a5)
    while (current_thread->suspended) {
  ca:	0a87a703          	lw	a4,168(a5)
  ce:	ff6d                	bnez	a4,c8 <schedule+0x1a>
  d0:	00001717          	auipc	a4,0x1
  d4:	acf73c23          	sd	a5,-1320(a4) # ba8 <current_thread>
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
    if(current_thread->next != current_thread){
  e8:	00001497          	auipc	s1,0x1
  ec:	ac04b483          	ld	s1,-1344(s1) # ba8 <current_thread>
  f0:	70dc                	ld	a5,160(s1)
  f2:	02f48d63          	beq	s1,a5,12c <thread_exit+0x4e>
        // TODO
        struct thread *curr = current_thread;
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
 10c:	89e080e7          	jalr	-1890(ra) # 9a6 <free>
        free(curr);
 110:	8526                	mv	a0,s1
 112:	00001097          	auipc	ra,0x1
 116:	894080e7          	jalr	-1900(ra) # 9a6 <free>
        dispatch();
 11a:	00000097          	auipc	ra,0x0
 11e:	040080e7          	jalr	64(ra) # 15a <dispatch>
        // Hint: No more thread to execute
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st,1); //return to main function
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
 132:	878080e7          	jalr	-1928(ra) # 9a6 <free>
        free(current_thread);
 136:	00001517          	auipc	a0,0x1
 13a:	a7253503          	ld	a0,-1422(a0) # ba8 <current_thread>
 13e:	00001097          	auipc	ra,0x1
 142:	868080e7          	jalr	-1944(ra) # 9a6 <free>
        longjmp(env_st,1); //return to main function
 146:	4585                	li	a1,1
 148:	00001517          	auipc	a0,0x1
 14c:	a7050513          	addi	a0,a0,-1424 # bb8 <env_st>
 150:	00001097          	auipc	ra,0x1
 154:	9fa080e7          	jalr	-1542(ra) # b4a <longjmp>
}
 158:	b7e9                	j	122 <thread_exit+0x44>

000000000000015a <dispatch>:
void dispatch(void){
 15a:	1101                	addi	sp,sp,-32
 15c:	ec06                	sd	ra,24(sp)
 15e:	e822                	sd	s0,16(sp)
 160:	e426                	sd	s1,8(sp)
 162:	1000                	addi	s0,sp,32
    if(current_thread->signo != -1){
 164:	00001517          	auipc	a0,0x1
 168:	a4453503          	ld	a0,-1468(a0) # ba8 <current_thread>
 16c:	0c052783          	lw	a5,192(a0)
 170:	577d                	li	a4,-1
 172:	08e78e63          	beq	a5,a4,20e <dispatch+0xb4>
        if(current_thread->sig_handler[current_thread->signo] != NULL_FUNC){
 176:	07d9                	addi	a5,a5,22
 178:	078e                	slli	a5,a5,0x3
 17a:	97aa                	add	a5,a5,a0
 17c:	6398                	ld	a4,0(a5)
 17e:	57fd                	li	a5,-1
 180:	08f70263          	beq	a4,a5,204 <dispatch+0xaa>
            if(current_thread->handler_buf_set == 1){
 184:	13852703          	lw	a4,312(a0)
 188:	4785                	li	a5,1
 18a:	04f70163          	beq	a4,a5,1cc <dispatch+0x72>
                if(setjmp(current_thread->handler_env) == 1){
 18e:	0c850513          	addi	a0,a0,200
 192:	00001097          	auipc	ra,0x1
 196:	980080e7          	jalr	-1664(ra) # b12 <setjmp>
 19a:	4785                	li	a5,1
 19c:	04f51063          	bne	a0,a5,1dc <dispatch+0x82>
                    current_thread->sig_handler[current_thread->signo](current_thread->signo);
 1a0:	00001497          	auipc	s1,0x1
 1a4:	a0848493          	addi	s1,s1,-1528 # ba8 <current_thread>
 1a8:	609c                	ld	a5,0(s1)
 1aa:	0c07a503          	lw	a0,192(a5)
 1ae:	01650713          	addi	a4,a0,22
 1b2:	070e                	slli	a4,a4,0x3
 1b4:	97ba                	add	a5,a5,a4
 1b6:	639c                	ld	a5,0(a5)
 1b8:	9782                	jalr	a5
                    current_thread->signo = -1;
 1ba:	609c                	ld	a5,0(s1)
 1bc:	577d                	li	a4,-1
 1be:	0ce7a023          	sw	a4,192(a5)
                    dispatch();
 1c2:	00000097          	auipc	ra,0x0
 1c6:	f98080e7          	jalr	-104(ra) # 15a <dispatch>
 1ca:	a89d                	j	240 <dispatch+0xe6>
                longjmp(current_thread->handler_env,1);
 1cc:	4585                	li	a1,1
 1ce:	0c850513          	addi	a0,a0,200
 1d2:	00001097          	auipc	ra,0x1
 1d6:	978080e7          	jalr	-1672(ra) # b4a <longjmp>
 1da:	a09d                	j	240 <dispatch+0xe6>
                    current_thread->handler_env->sp = (unsigned long) current_thread->stack_p-50*8;
 1dc:	00001517          	auipc	a0,0x1
 1e0:	9cc53503          	ld	a0,-1588(a0) # ba8 <current_thread>
 1e4:	6d1c                	ld	a5,24(a0)
 1e6:	e7078793          	addi	a5,a5,-400
 1ea:	12f53823          	sd	a5,304(a0)
                    current_thread->handler_buf_set = 1;
 1ee:	4785                	li	a5,1
 1f0:	12f52c23          	sw	a5,312(a0)
                    longjmp(current_thread->handler_env,1);
 1f4:	4585                	li	a1,1
 1f6:	0c850513          	addi	a0,a0,200
 1fa:	00001097          	auipc	ra,0x1
 1fe:	950080e7          	jalr	-1712(ra) # b4a <longjmp>
 202:	a83d                	j	240 <dispatch+0xe6>
            thread_exit();
 204:	00000097          	auipc	ra,0x0
 208:	eda080e7          	jalr	-294(ra) # de <thread_exit>
 20c:	a815                	j	240 <dispatch+0xe6>
        if(current_thread->buf_set == 1){ // current_thread->env != NULL
 20e:	09052703          	lw	a4,144(a0)
 212:	4785                	li	a5,1
 214:	02f70b63          	beq	a4,a5,24a <dispatch+0xf0>
            if(setjmp(current_thread->env) == 1){ //set jmpbuf success, exec func
 218:	02050513          	addi	a0,a0,32
 21c:	00001097          	auipc	ra,0x1
 220:	8f6080e7          	jalr	-1802(ra) # b12 <setjmp>
 224:	4785                	li	a5,1
 226:	02f51a63          	bne	a0,a5,25a <dispatch+0x100>
                current_thread->fp(current_thread->arg);
 22a:	00001797          	auipc	a5,0x1
 22e:	97e7b783          	ld	a5,-1666(a5) # ba8 <current_thread>
 232:	6398                	ld	a4,0(a5)
 234:	6788                	ld	a0,8(a5)
 236:	9702                	jalr	a4
        thread_exit();
 238:	00000097          	auipc	ra,0x0
 23c:	ea6080e7          	jalr	-346(ra) # de <thread_exit>
}
 240:	60e2                	ld	ra,24(sp)
 242:	6442                	ld	s0,16(sp)
 244:	64a2                	ld	s1,8(sp)
 246:	6105                	addi	sp,sp,32
 248:	8082                	ret
            longjmp(current_thread->env,1);
 24a:	4585                	li	a1,1
 24c:	02050513          	addi	a0,a0,32
 250:	00001097          	auipc	ra,0x1
 254:	8fa080e7          	jalr	-1798(ra) # b4a <longjmp>
 258:	b7c5                	j	238 <dispatch+0xde>
                current_thread->env->sp =(unsigned long) current_thread->stack_p;
 25a:	00001517          	auipc	a0,0x1
 25e:	94e53503          	ld	a0,-1714(a0) # ba8 <current_thread>
 262:	6d1c                	ld	a5,24(a0)
 264:	e55c                	sd	a5,136(a0)
                current_thread->buf_set = 1; //manual set jmpbuf finished
 266:	4785                	li	a5,1
 268:	08f52823          	sw	a5,144(a0)
                longjmp(current_thread->env,1);
 26c:	4585                	li	a1,1
 26e:	02050513          	addi	a0,a0,32
 272:	00001097          	auipc	ra,0x1
 276:	8d8080e7          	jalr	-1832(ra) # b4a <longjmp>
 27a:	bf7d                	j	238 <dispatch+0xde>

000000000000027c <thread_yield>:
void thread_yield(void){
 27c:	1141                	addi	sp,sp,-16
 27e:	e406                	sd	ra,8(sp)
 280:	e022                	sd	s0,0(sp)
 282:	0800                	addi	s0,sp,16
    if(current_thread->signo != -1){
 284:	00001517          	auipc	a0,0x1
 288:	92453503          	ld	a0,-1756(a0) # ba8 <current_thread>
 28c:	0c052703          	lw	a4,192(a0)
 290:	57fd                	li	a5,-1
 292:	02f70663          	beq	a4,a5,2be <thread_yield+0x42>
        if(setjmp(current_thread->handler_env) == NULL){
 296:	0c850513          	addi	a0,a0,200
 29a:	00001097          	auipc	ra,0x1
 29e:	878080e7          	jalr	-1928(ra) # b12 <setjmp>
 2a2:	c509                	beqz	a0,2ac <thread_yield+0x30>
}
 2a4:	60a2                	ld	ra,8(sp)
 2a6:	6402                	ld	s0,0(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
            schedule();
 2ac:	00000097          	auipc	ra,0x0
 2b0:	e02080e7          	jalr	-510(ra) # ae <schedule>
            dispatch();
 2b4:	00000097          	auipc	ra,0x0
 2b8:	ea6080e7          	jalr	-346(ra) # 15a <dispatch>
 2bc:	b7e5                	j	2a4 <thread_yield+0x28>
        if(setjmp(current_thread->env) == NULL){
 2be:	02050513          	addi	a0,a0,32
 2c2:	00001097          	auipc	ra,0x1
 2c6:	850080e7          	jalr	-1968(ra) # b12 <setjmp>
 2ca:	fd69                	bnez	a0,2a4 <thread_yield+0x28>
            schedule();
 2cc:	00000097          	auipc	ra,0x0
 2d0:	de2080e7          	jalr	-542(ra) # ae <schedule>
            dispatch();
 2d4:	00000097          	auipc	ra,0x0
 2d8:	e86080e7          	jalr	-378(ra) # 15a <dispatch>
}
 2dc:	b7e1                	j	2a4 <thread_yield+0x28>

00000000000002de <thread_start_threading>:
void thread_start_threading(void){
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
    // TODO
    if(setjmp(env_st) == 0){
 2e6:	00001517          	auipc	a0,0x1
 2ea:	8d250513          	addi	a0,a0,-1838 # bb8 <env_st>
 2ee:	00001097          	auipc	ra,0x1
 2f2:	824080e7          	jalr	-2012(ra) # b12 <setjmp>
 2f6:	c509                	beqz	a0,300 <thread_start_threading+0x22>
        schedule();
        dispatch();
    }
    else return;
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
        schedule();
 300:	00000097          	auipc	ra,0x0
 304:	dae080e7          	jalr	-594(ra) # ae <schedule>
        dispatch();
 308:	00000097          	auipc	ra,0x0
 30c:	e52080e7          	jalr	-430(ra) # 15a <dispatch>
 310:	b7e5                	j	2f8 <thread_start_threading+0x1a>

0000000000000312 <thread_register_handler>:
// part 2
void thread_register_handler(int signo, void (*handler)(int)){
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
    // TODO
    current_thread->sig_handler[signo] = handler;
 31a:	0559                	addi	a0,a0,22
 31c:	050e                	slli	a0,a0,0x3
 31e:	00001797          	auipc	a5,0x1
 322:	88a7b783          	ld	a5,-1910(a5) # ba8 <current_thread>
 326:	953e                	add	a0,a0,a5
 328:	e10c                	sd	a1,0(a0)
    //printf("set handler success\n");
    sleep(3);
 32a:	450d                	li	a0,3
 32c:	00000097          	auipc	ra,0x0
 330:	35c080e7          	jalr	860(ra) # 688 <sleep>
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <thread_kill>:
void thread_kill(struct thread *t, int signo){
 33c:	1141                	addi	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	addi	s0,sp,16
    // TODO
    t->signo = signo;
 342:	0cb52023          	sw	a1,192(a0)
    }
    else{
        //printf("thread killed\n");
        //thread_exit();
    }*/
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <thread_suspend>:


void thread_suspend(struct thread *t) {
 34c:	1141                	addi	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	addi	s0,sp,16
    //TO DOsuspended flag to prevent thread from being scheduled
   t->suspended = 1;
 352:	4785                	li	a5,1
 354:	0af52423          	sw	a5,168(a0)
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <thread_resume>:
void thread_resume(struct thread *t) {
 35e:	1141                	addi	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	addi	s0,sp,16
    //TO DO_resume(struct thread *t) {
    t->suspended = 0;
 364:	0a052423          	sw	zero,168(a0)
}
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	addi	sp,sp,16
 36c:	8082                	ret

000000000000036e <get_current_thread>:



struct thread* get_current_thread() {
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
    return current_thread;
 374:	00001517          	auipc	a0,0x1
 378:	83453503          	ld	a0,-1996(a0) # ba8 <current_thread>
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 388:	87aa                	mv	a5,a0
 38a:	0585                	addi	a1,a1,1
 38c:	0785                	addi	a5,a5,1
 38e:	fff5c703          	lbu	a4,-1(a1)
 392:	fee78fa3          	sb	a4,-1(a5)
 396:	fb75                	bnez	a4,38a <strcpy+0x8>
    ;
  return os;
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret

000000000000039e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 39e:	1141                	addi	sp,sp,-16
 3a0:	e422                	sd	s0,8(sp)
 3a2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3a4:	00054783          	lbu	a5,0(a0)
 3a8:	cb91                	beqz	a5,3bc <strcmp+0x1e>
 3aa:	0005c703          	lbu	a4,0(a1)
 3ae:	00f71763          	bne	a4,a5,3bc <strcmp+0x1e>
    p++, q++;
 3b2:	0505                	addi	a0,a0,1
 3b4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3b6:	00054783          	lbu	a5,0(a0)
 3ba:	fbe5                	bnez	a5,3aa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3bc:	0005c503          	lbu	a0,0(a1)
}
 3c0:	40a7853b          	subw	a0,a5,a0
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret

00000000000003ca <strlen>:

uint
strlen(const char *s)
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3d0:	00054783          	lbu	a5,0(a0)
 3d4:	cf91                	beqz	a5,3f0 <strlen+0x26>
 3d6:	0505                	addi	a0,a0,1
 3d8:	87aa                	mv	a5,a0
 3da:	4685                	li	a3,1
 3dc:	9e89                	subw	a3,a3,a0
 3de:	00f6853b          	addw	a0,a3,a5
 3e2:	0785                	addi	a5,a5,1
 3e4:	fff7c703          	lbu	a4,-1(a5)
 3e8:	fb7d                	bnez	a4,3de <strlen+0x14>
    ;
  return n;
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
  for(n = 0; s[n]; n++)
 3f0:	4501                	li	a0,0
 3f2:	bfe5                	j	3ea <strlen+0x20>

00000000000003f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3fa:	ce09                	beqz	a2,414 <memset+0x20>
 3fc:	87aa                	mv	a5,a0
 3fe:	fff6071b          	addiw	a4,a2,-1
 402:	1702                	slli	a4,a4,0x20
 404:	9301                	srli	a4,a4,0x20
 406:	0705                	addi	a4,a4,1
 408:	972a                	add	a4,a4,a0
    cdst[i] = c;
 40a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 40e:	0785                	addi	a5,a5,1
 410:	fee79de3          	bne	a5,a4,40a <memset+0x16>
  }
  return dst;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret

000000000000041a <strchr>:

char*
strchr(const char *s, char c)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 420:	00054783          	lbu	a5,0(a0)
 424:	cb99                	beqz	a5,43a <strchr+0x20>
    if(*s == c)
 426:	00f58763          	beq	a1,a5,434 <strchr+0x1a>
  for(; *s; s++)
 42a:	0505                	addi	a0,a0,1
 42c:	00054783          	lbu	a5,0(a0)
 430:	fbfd                	bnez	a5,426 <strchr+0xc>
      return (char*)s;
  return 0;
 432:	4501                	li	a0,0
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret
  return 0;
 43a:	4501                	li	a0,0
 43c:	bfe5                	j	434 <strchr+0x1a>

000000000000043e <gets>:

char*
gets(char *buf, int max)
{
 43e:	711d                	addi	sp,sp,-96
 440:	ec86                	sd	ra,88(sp)
 442:	e8a2                	sd	s0,80(sp)
 444:	e4a6                	sd	s1,72(sp)
 446:	e0ca                	sd	s2,64(sp)
 448:	fc4e                	sd	s3,56(sp)
 44a:	f852                	sd	s4,48(sp)
 44c:	f456                	sd	s5,40(sp)
 44e:	f05a                	sd	s6,32(sp)
 450:	ec5e                	sd	s7,24(sp)
 452:	1080                	addi	s0,sp,96
 454:	8baa                	mv	s7,a0
 456:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 458:	892a                	mv	s2,a0
 45a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 45c:	4aa9                	li	s5,10
 45e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 460:	89a6                	mv	s3,s1
 462:	2485                	addiw	s1,s1,1
 464:	0344d863          	bge	s1,s4,494 <gets+0x56>
    cc = read(0, &c, 1);
 468:	4605                	li	a2,1
 46a:	faf40593          	addi	a1,s0,-81
 46e:	4501                	li	a0,0
 470:	00000097          	auipc	ra,0x0
 474:	1a0080e7          	jalr	416(ra) # 610 <read>
    if(cc < 1)
 478:	00a05e63          	blez	a0,494 <gets+0x56>
    buf[i++] = c;
 47c:	faf44783          	lbu	a5,-81(s0)
 480:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 484:	01578763          	beq	a5,s5,492 <gets+0x54>
 488:	0905                	addi	s2,s2,1
 48a:	fd679be3          	bne	a5,s6,460 <gets+0x22>
  for(i=0; i+1 < max; ){
 48e:	89a6                	mv	s3,s1
 490:	a011                	j	494 <gets+0x56>
 492:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 494:	99de                	add	s3,s3,s7
 496:	00098023          	sb	zero,0(s3)
  return buf;
}
 49a:	855e                	mv	a0,s7
 49c:	60e6                	ld	ra,88(sp)
 49e:	6446                	ld	s0,80(sp)
 4a0:	64a6                	ld	s1,72(sp)
 4a2:	6906                	ld	s2,64(sp)
 4a4:	79e2                	ld	s3,56(sp)
 4a6:	7a42                	ld	s4,48(sp)
 4a8:	7aa2                	ld	s5,40(sp)
 4aa:	7b02                	ld	s6,32(sp)
 4ac:	6be2                	ld	s7,24(sp)
 4ae:	6125                	addi	sp,sp,96
 4b0:	8082                	ret

00000000000004b2 <stat>:

int
stat(const char *n, struct stat *st)
{
 4b2:	1101                	addi	sp,sp,-32
 4b4:	ec06                	sd	ra,24(sp)
 4b6:	e822                	sd	s0,16(sp)
 4b8:	e426                	sd	s1,8(sp)
 4ba:	e04a                	sd	s2,0(sp)
 4bc:	1000                	addi	s0,sp,32
 4be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c0:	4581                	li	a1,0
 4c2:	00000097          	auipc	ra,0x0
 4c6:	176080e7          	jalr	374(ra) # 638 <open>
  if(fd < 0)
 4ca:	02054563          	bltz	a0,4f4 <stat+0x42>
 4ce:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4d0:	85ca                	mv	a1,s2
 4d2:	00000097          	auipc	ra,0x0
 4d6:	17e080e7          	jalr	382(ra) # 650 <fstat>
 4da:	892a                	mv	s2,a0
  close(fd);
 4dc:	8526                	mv	a0,s1
 4de:	00000097          	auipc	ra,0x0
 4e2:	142080e7          	jalr	322(ra) # 620 <close>
  return r;
}
 4e6:	854a                	mv	a0,s2
 4e8:	60e2                	ld	ra,24(sp)
 4ea:	6442                	ld	s0,16(sp)
 4ec:	64a2                	ld	s1,8(sp)
 4ee:	6902                	ld	s2,0(sp)
 4f0:	6105                	addi	sp,sp,32
 4f2:	8082                	ret
    return -1;
 4f4:	597d                	li	s2,-1
 4f6:	bfc5                	j	4e6 <stat+0x34>

00000000000004f8 <atoi>:

int
atoi(const char *s)
{
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e422                	sd	s0,8(sp)
 4fc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4fe:	00054603          	lbu	a2,0(a0)
 502:	fd06079b          	addiw	a5,a2,-48
 506:	0ff7f793          	andi	a5,a5,255
 50a:	4725                	li	a4,9
 50c:	02f76963          	bltu	a4,a5,53e <atoi+0x46>
 510:	86aa                	mv	a3,a0
  n = 0;
 512:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 514:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 516:	0685                	addi	a3,a3,1
 518:	0025179b          	slliw	a5,a0,0x2
 51c:	9fa9                	addw	a5,a5,a0
 51e:	0017979b          	slliw	a5,a5,0x1
 522:	9fb1                	addw	a5,a5,a2
 524:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 528:	0006c603          	lbu	a2,0(a3)
 52c:	fd06071b          	addiw	a4,a2,-48
 530:	0ff77713          	andi	a4,a4,255
 534:	fee5f1e3          	bgeu	a1,a4,516 <atoi+0x1e>
  return n;
}
 538:	6422                	ld	s0,8(sp)
 53a:	0141                	addi	sp,sp,16
 53c:	8082                	ret
  n = 0;
 53e:	4501                	li	a0,0
 540:	bfe5                	j	538 <atoi+0x40>

0000000000000542 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 542:	1141                	addi	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 548:	02b57663          	bgeu	a0,a1,574 <memmove+0x32>
    while(n-- > 0)
 54c:	02c05163          	blez	a2,56e <memmove+0x2c>
 550:	fff6079b          	addiw	a5,a2,-1
 554:	1782                	slli	a5,a5,0x20
 556:	9381                	srli	a5,a5,0x20
 558:	0785                	addi	a5,a5,1
 55a:	97aa                	add	a5,a5,a0
  dst = vdst;
 55c:	872a                	mv	a4,a0
      *dst++ = *src++;
 55e:	0585                	addi	a1,a1,1
 560:	0705                	addi	a4,a4,1
 562:	fff5c683          	lbu	a3,-1(a1)
 566:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 56a:	fee79ae3          	bne	a5,a4,55e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 56e:	6422                	ld	s0,8(sp)
 570:	0141                	addi	sp,sp,16
 572:	8082                	ret
    dst += n;
 574:	00c50733          	add	a4,a0,a2
    src += n;
 578:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 57a:	fec05ae3          	blez	a2,56e <memmove+0x2c>
 57e:	fff6079b          	addiw	a5,a2,-1
 582:	1782                	slli	a5,a5,0x20
 584:	9381                	srli	a5,a5,0x20
 586:	fff7c793          	not	a5,a5
 58a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 58c:	15fd                	addi	a1,a1,-1
 58e:	177d                	addi	a4,a4,-1
 590:	0005c683          	lbu	a3,0(a1)
 594:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 598:	fee79ae3          	bne	a5,a4,58c <memmove+0x4a>
 59c:	bfc9                	j	56e <memmove+0x2c>

000000000000059e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 59e:	1141                	addi	sp,sp,-16
 5a0:	e422                	sd	s0,8(sp)
 5a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5a4:	ca05                	beqz	a2,5d4 <memcmp+0x36>
 5a6:	fff6069b          	addiw	a3,a2,-1
 5aa:	1682                	slli	a3,a3,0x20
 5ac:	9281                	srli	a3,a3,0x20
 5ae:	0685                	addi	a3,a3,1
 5b0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5b2:	00054783          	lbu	a5,0(a0)
 5b6:	0005c703          	lbu	a4,0(a1)
 5ba:	00e79863          	bne	a5,a4,5ca <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5be:	0505                	addi	a0,a0,1
    p2++;
 5c0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5c2:	fed518e3          	bne	a0,a3,5b2 <memcmp+0x14>
  }
  return 0;
 5c6:	4501                	li	a0,0
 5c8:	a019                	j	5ce <memcmp+0x30>
      return *p1 - *p2;
 5ca:	40e7853b          	subw	a0,a5,a4
}
 5ce:	6422                	ld	s0,8(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret
  return 0;
 5d4:	4501                	li	a0,0
 5d6:	bfe5                	j	5ce <memcmp+0x30>

00000000000005d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5d8:	1141                	addi	sp,sp,-16
 5da:	e406                	sd	ra,8(sp)
 5dc:	e022                	sd	s0,0(sp)
 5de:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5e0:	00000097          	auipc	ra,0x0
 5e4:	f62080e7          	jalr	-158(ra) # 542 <memmove>
}
 5e8:	60a2                	ld	ra,8(sp)
 5ea:	6402                	ld	s0,0(sp)
 5ec:	0141                	addi	sp,sp,16
 5ee:	8082                	ret

00000000000005f0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5f0:	4885                	li	a7,1
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5f8:	4889                	li	a7,2
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <wait>:
.global wait
wait:
 li a7, SYS_wait
 600:	488d                	li	a7,3
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 608:	4891                	li	a7,4
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <read>:
.global read
read:
 li a7, SYS_read
 610:	4895                	li	a7,5
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <write>:
.global write
write:
 li a7, SYS_write
 618:	48c1                	li	a7,16
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <close>:
.global close
close:
 li a7, SYS_close
 620:	48d5                	li	a7,21
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <kill>:
.global kill
kill:
 li a7, SYS_kill
 628:	4899                	li	a7,6
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <exec>:
.global exec
exec:
 li a7, SYS_exec
 630:	489d                	li	a7,7
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <open>:
.global open
open:
 li a7, SYS_open
 638:	48bd                	li	a7,15
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 640:	48c5                	li	a7,17
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 648:	48c9                	li	a7,18
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 650:	48a1                	li	a7,8
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <link>:
.global link
link:
 li a7, SYS_link
 658:	48cd                	li	a7,19
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 660:	48d1                	li	a7,20
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 668:	48a5                	li	a7,9
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <dup>:
.global dup
dup:
 li a7, SYS_dup
 670:	48a9                	li	a7,10
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 678:	48ad                	li	a7,11
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 680:	48b1                	li	a7,12
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 688:	48b5                	li	a7,13
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 690:	48b9                	li	a7,14
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 698:	1101                	addi	sp,sp,-32
 69a:	ec06                	sd	ra,24(sp)
 69c:	e822                	sd	s0,16(sp)
 69e:	1000                	addi	s0,sp,32
 6a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6a4:	4605                	li	a2,1
 6a6:	fef40593          	addi	a1,s0,-17
 6aa:	00000097          	auipc	ra,0x0
 6ae:	f6e080e7          	jalr	-146(ra) # 618 <write>
}
 6b2:	60e2                	ld	ra,24(sp)
 6b4:	6442                	ld	s0,16(sp)
 6b6:	6105                	addi	sp,sp,32
 6b8:	8082                	ret

00000000000006ba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6ba:	7139                	addi	sp,sp,-64
 6bc:	fc06                	sd	ra,56(sp)
 6be:	f822                	sd	s0,48(sp)
 6c0:	f426                	sd	s1,40(sp)
 6c2:	f04a                	sd	s2,32(sp)
 6c4:	ec4e                	sd	s3,24(sp)
 6c6:	0080                	addi	s0,sp,64
 6c8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6ca:	c299                	beqz	a3,6d0 <printint+0x16>
 6cc:	0805c863          	bltz	a1,75c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6d0:	2581                	sext.w	a1,a1
  neg = 0;
 6d2:	4881                	li	a7,0
 6d4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6d8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6da:	2601                	sext.w	a2,a2
 6dc:	00000517          	auipc	a0,0x0
 6e0:	4b450513          	addi	a0,a0,1204 # b90 <digits>
 6e4:	883a                	mv	a6,a4
 6e6:	2705                	addiw	a4,a4,1
 6e8:	02c5f7bb          	remuw	a5,a1,a2
 6ec:	1782                	slli	a5,a5,0x20
 6ee:	9381                	srli	a5,a5,0x20
 6f0:	97aa                	add	a5,a5,a0
 6f2:	0007c783          	lbu	a5,0(a5)
 6f6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6fa:	0005879b          	sext.w	a5,a1
 6fe:	02c5d5bb          	divuw	a1,a1,a2
 702:	0685                	addi	a3,a3,1
 704:	fec7f0e3          	bgeu	a5,a2,6e4 <printint+0x2a>
  if(neg)
 708:	00088b63          	beqz	a7,71e <printint+0x64>
    buf[i++] = '-';
 70c:	fd040793          	addi	a5,s0,-48
 710:	973e                	add	a4,a4,a5
 712:	02d00793          	li	a5,45
 716:	fef70823          	sb	a5,-16(a4)
 71a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 71e:	02e05863          	blez	a4,74e <printint+0x94>
 722:	fc040793          	addi	a5,s0,-64
 726:	00e78933          	add	s2,a5,a4
 72a:	fff78993          	addi	s3,a5,-1
 72e:	99ba                	add	s3,s3,a4
 730:	377d                	addiw	a4,a4,-1
 732:	1702                	slli	a4,a4,0x20
 734:	9301                	srli	a4,a4,0x20
 736:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 73a:	fff94583          	lbu	a1,-1(s2)
 73e:	8526                	mv	a0,s1
 740:	00000097          	auipc	ra,0x0
 744:	f58080e7          	jalr	-168(ra) # 698 <putc>
  while(--i >= 0)
 748:	197d                	addi	s2,s2,-1
 74a:	ff3918e3          	bne	s2,s3,73a <printint+0x80>
}
 74e:	70e2                	ld	ra,56(sp)
 750:	7442                	ld	s0,48(sp)
 752:	74a2                	ld	s1,40(sp)
 754:	7902                	ld	s2,32(sp)
 756:	69e2                	ld	s3,24(sp)
 758:	6121                	addi	sp,sp,64
 75a:	8082                	ret
    x = -xx;
 75c:	40b005bb          	negw	a1,a1
    neg = 1;
 760:	4885                	li	a7,1
    x = -xx;
 762:	bf8d                	j	6d4 <printint+0x1a>

0000000000000764 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 764:	7119                	addi	sp,sp,-128
 766:	fc86                	sd	ra,120(sp)
 768:	f8a2                	sd	s0,112(sp)
 76a:	f4a6                	sd	s1,104(sp)
 76c:	f0ca                	sd	s2,96(sp)
 76e:	ecce                	sd	s3,88(sp)
 770:	e8d2                	sd	s4,80(sp)
 772:	e4d6                	sd	s5,72(sp)
 774:	e0da                	sd	s6,64(sp)
 776:	fc5e                	sd	s7,56(sp)
 778:	f862                	sd	s8,48(sp)
 77a:	f466                	sd	s9,40(sp)
 77c:	f06a                	sd	s10,32(sp)
 77e:	ec6e                	sd	s11,24(sp)
 780:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 782:	0005c903          	lbu	s2,0(a1)
 786:	18090f63          	beqz	s2,924 <vprintf+0x1c0>
 78a:	8aaa                	mv	s5,a0
 78c:	8b32                	mv	s6,a2
 78e:	00158493          	addi	s1,a1,1
  state = 0;
 792:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 794:	02500a13          	li	s4,37
      if(c == 'd'){
 798:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 79c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7a0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7a4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a8:	00000b97          	auipc	s7,0x0
 7ac:	3e8b8b93          	addi	s7,s7,1000 # b90 <digits>
 7b0:	a839                	j	7ce <vprintf+0x6a>
        putc(fd, c);
 7b2:	85ca                	mv	a1,s2
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	ee2080e7          	jalr	-286(ra) # 698 <putc>
 7be:	a019                	j	7c4 <vprintf+0x60>
    } else if(state == '%'){
 7c0:	01498f63          	beq	s3,s4,7de <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7c4:	0485                	addi	s1,s1,1
 7c6:	fff4c903          	lbu	s2,-1(s1)
 7ca:	14090d63          	beqz	s2,924 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7ce:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7d2:	fe0997e3          	bnez	s3,7c0 <vprintf+0x5c>
      if(c == '%'){
 7d6:	fd479ee3          	bne	a5,s4,7b2 <vprintf+0x4e>
        state = '%';
 7da:	89be                	mv	s3,a5
 7dc:	b7e5                	j	7c4 <vprintf+0x60>
      if(c == 'd'){
 7de:	05878063          	beq	a5,s8,81e <vprintf+0xba>
      } else if(c == 'l') {
 7e2:	05978c63          	beq	a5,s9,83a <vprintf+0xd6>
      } else if(c == 'x') {
 7e6:	07a78863          	beq	a5,s10,856 <vprintf+0xf2>
      } else if(c == 'p') {
 7ea:	09b78463          	beq	a5,s11,872 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7ee:	07300713          	li	a4,115
 7f2:	0ce78663          	beq	a5,a4,8be <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7f6:	06300713          	li	a4,99
 7fa:	0ee78e63          	beq	a5,a4,8f6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7fe:	11478863          	beq	a5,s4,90e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 802:	85d2                	mv	a1,s4
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e92080e7          	jalr	-366(ra) # 698 <putc>
        putc(fd, c);
 80e:	85ca                	mv	a1,s2
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e86080e7          	jalr	-378(ra) # 698 <putc>
      }
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b765                	j	7c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 81e:	008b0913          	addi	s2,s6,8
 822:	4685                	li	a3,1
 824:	4629                	li	a2,10
 826:	000b2583          	lw	a1,0(s6)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	e8e080e7          	jalr	-370(ra) # 6ba <printint>
 834:	8b4a                	mv	s6,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	b771                	j	7c4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 83a:	008b0913          	addi	s2,s6,8
 83e:	4681                	li	a3,0
 840:	4629                	li	a2,10
 842:	000b2583          	lw	a1,0(s6)
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	e72080e7          	jalr	-398(ra) # 6ba <printint>
 850:	8b4a                	mv	s6,s2
      state = 0;
 852:	4981                	li	s3,0
 854:	bf85                	j	7c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 856:	008b0913          	addi	s2,s6,8
 85a:	4681                	li	a3,0
 85c:	4641                	li	a2,16
 85e:	000b2583          	lw	a1,0(s6)
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	e56080e7          	jalr	-426(ra) # 6ba <printint>
 86c:	8b4a                	mv	s6,s2
      state = 0;
 86e:	4981                	li	s3,0
 870:	bf91                	j	7c4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 872:	008b0793          	addi	a5,s6,8
 876:	f8f43423          	sd	a5,-120(s0)
 87a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 87e:	03000593          	li	a1,48
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	e14080e7          	jalr	-492(ra) # 698 <putc>
  putc(fd, 'x');
 88c:	85ea                	mv	a1,s10
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	e08080e7          	jalr	-504(ra) # 698 <putc>
 898:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 89a:	03c9d793          	srli	a5,s3,0x3c
 89e:	97de                	add	a5,a5,s7
 8a0:	0007c583          	lbu	a1,0(a5)
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	df2080e7          	jalr	-526(ra) # 698 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ae:	0992                	slli	s3,s3,0x4
 8b0:	397d                	addiw	s2,s2,-1
 8b2:	fe0914e3          	bnez	s2,89a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8b6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b721                	j	7c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 8be:	008b0993          	addi	s3,s6,8
 8c2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8c6:	02090163          	beqz	s2,8e8 <vprintf+0x184>
        while(*s != 0){
 8ca:	00094583          	lbu	a1,0(s2)
 8ce:	c9a1                	beqz	a1,91e <vprintf+0x1ba>
          putc(fd, *s);
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	dc6080e7          	jalr	-570(ra) # 698 <putc>
          s++;
 8da:	0905                	addi	s2,s2,1
        while(*s != 0){
 8dc:	00094583          	lbu	a1,0(s2)
 8e0:	f9e5                	bnez	a1,8d0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8e2:	8b4e                	mv	s6,s3
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	bdf9                	j	7c4 <vprintf+0x60>
          s = "(null)";
 8e8:	00000917          	auipc	s2,0x0
 8ec:	2a090913          	addi	s2,s2,672 # b88 <longjmp_1+0x4>
        while(*s != 0){
 8f0:	02800593          	li	a1,40
 8f4:	bff1                	j	8d0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8f6:	008b0913          	addi	s2,s6,8
 8fa:	000b4583          	lbu	a1,0(s6)
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	d98080e7          	jalr	-616(ra) # 698 <putc>
 908:	8b4a                	mv	s6,s2
      state = 0;
 90a:	4981                	li	s3,0
 90c:	bd65                	j	7c4 <vprintf+0x60>
        putc(fd, c);
 90e:	85d2                	mv	a1,s4
 910:	8556                	mv	a0,s5
 912:	00000097          	auipc	ra,0x0
 916:	d86080e7          	jalr	-634(ra) # 698 <putc>
      state = 0;
 91a:	4981                	li	s3,0
 91c:	b565                	j	7c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 91e:	8b4e                	mv	s6,s3
      state = 0;
 920:	4981                	li	s3,0
 922:	b54d                	j	7c4 <vprintf+0x60>
    }
  }
}
 924:	70e6                	ld	ra,120(sp)
 926:	7446                	ld	s0,112(sp)
 928:	74a6                	ld	s1,104(sp)
 92a:	7906                	ld	s2,96(sp)
 92c:	69e6                	ld	s3,88(sp)
 92e:	6a46                	ld	s4,80(sp)
 930:	6aa6                	ld	s5,72(sp)
 932:	6b06                	ld	s6,64(sp)
 934:	7be2                	ld	s7,56(sp)
 936:	7c42                	ld	s8,48(sp)
 938:	7ca2                	ld	s9,40(sp)
 93a:	7d02                	ld	s10,32(sp)
 93c:	6de2                	ld	s11,24(sp)
 93e:	6109                	addi	sp,sp,128
 940:	8082                	ret

0000000000000942 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 942:	715d                	addi	sp,sp,-80
 944:	ec06                	sd	ra,24(sp)
 946:	e822                	sd	s0,16(sp)
 948:	1000                	addi	s0,sp,32
 94a:	e010                	sd	a2,0(s0)
 94c:	e414                	sd	a3,8(s0)
 94e:	e818                	sd	a4,16(s0)
 950:	ec1c                	sd	a5,24(s0)
 952:	03043023          	sd	a6,32(s0)
 956:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 95a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 95e:	8622                	mv	a2,s0
 960:	00000097          	auipc	ra,0x0
 964:	e04080e7          	jalr	-508(ra) # 764 <vprintf>
}
 968:	60e2                	ld	ra,24(sp)
 96a:	6442                	ld	s0,16(sp)
 96c:	6161                	addi	sp,sp,80
 96e:	8082                	ret

0000000000000970 <printf>:

void
printf(const char *fmt, ...)
{
 970:	711d                	addi	sp,sp,-96
 972:	ec06                	sd	ra,24(sp)
 974:	e822                	sd	s0,16(sp)
 976:	1000                	addi	s0,sp,32
 978:	e40c                	sd	a1,8(s0)
 97a:	e810                	sd	a2,16(s0)
 97c:	ec14                	sd	a3,24(s0)
 97e:	f018                	sd	a4,32(s0)
 980:	f41c                	sd	a5,40(s0)
 982:	03043823          	sd	a6,48(s0)
 986:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 98a:	00840613          	addi	a2,s0,8
 98e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 992:	85aa                	mv	a1,a0
 994:	4505                	li	a0,1
 996:	00000097          	auipc	ra,0x0
 99a:	dce080e7          	jalr	-562(ra) # 764 <vprintf>
}
 99e:	60e2                	ld	ra,24(sp)
 9a0:	6442                	ld	s0,16(sp)
 9a2:	6125                	addi	sp,sp,96
 9a4:	8082                	ret

00000000000009a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a6:	1141                	addi	sp,sp,-16
 9a8:	e422                	sd	s0,8(sp)
 9aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b0:	00000797          	auipc	a5,0x0
 9b4:	2007b783          	ld	a5,512(a5) # bb0 <freep>
 9b8:	a805                	j	9e8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9ba:	4618                	lw	a4,8(a2)
 9bc:	9db9                	addw	a1,a1,a4
 9be:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9c2:	6398                	ld	a4,0(a5)
 9c4:	6318                	ld	a4,0(a4)
 9c6:	fee53823          	sd	a4,-16(a0)
 9ca:	a091                	j	a0e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9cc:	ff852703          	lw	a4,-8(a0)
 9d0:	9e39                	addw	a2,a2,a4
 9d2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9d4:	ff053703          	ld	a4,-16(a0)
 9d8:	e398                	sd	a4,0(a5)
 9da:	a099                	j	a20 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9dc:	6398                	ld	a4,0(a5)
 9de:	00e7e463          	bltu	a5,a4,9e6 <free+0x40>
 9e2:	00e6ea63          	bltu	a3,a4,9f6 <free+0x50>
{
 9e6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e8:	fed7fae3          	bgeu	a5,a3,9dc <free+0x36>
 9ec:	6398                	ld	a4,0(a5)
 9ee:	00e6e463          	bltu	a3,a4,9f6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f2:	fee7eae3          	bltu	a5,a4,9e6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9f6:	ff852583          	lw	a1,-8(a0)
 9fa:	6390                	ld	a2,0(a5)
 9fc:	02059713          	slli	a4,a1,0x20
 a00:	9301                	srli	a4,a4,0x20
 a02:	0712                	slli	a4,a4,0x4
 a04:	9736                	add	a4,a4,a3
 a06:	fae60ae3          	beq	a2,a4,9ba <free+0x14>
    bp->s.ptr = p->s.ptr;
 a0a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a0e:	4790                	lw	a2,8(a5)
 a10:	02061713          	slli	a4,a2,0x20
 a14:	9301                	srli	a4,a4,0x20
 a16:	0712                	slli	a4,a4,0x4
 a18:	973e                	add	a4,a4,a5
 a1a:	fae689e3          	beq	a3,a4,9cc <free+0x26>
  } else
    p->s.ptr = bp;
 a1e:	e394                	sd	a3,0(a5)
  freep = p;
 a20:	00000717          	auipc	a4,0x0
 a24:	18f73823          	sd	a5,400(a4) # bb0 <freep>
}
 a28:	6422                	ld	s0,8(sp)
 a2a:	0141                	addi	sp,sp,16
 a2c:	8082                	ret

0000000000000a2e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a2e:	7139                	addi	sp,sp,-64
 a30:	fc06                	sd	ra,56(sp)
 a32:	f822                	sd	s0,48(sp)
 a34:	f426                	sd	s1,40(sp)
 a36:	f04a                	sd	s2,32(sp)
 a38:	ec4e                	sd	s3,24(sp)
 a3a:	e852                	sd	s4,16(sp)
 a3c:	e456                	sd	s5,8(sp)
 a3e:	e05a                	sd	s6,0(sp)
 a40:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a42:	02051493          	slli	s1,a0,0x20
 a46:	9081                	srli	s1,s1,0x20
 a48:	04bd                	addi	s1,s1,15
 a4a:	8091                	srli	s1,s1,0x4
 a4c:	0014899b          	addiw	s3,s1,1
 a50:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a52:	00000517          	auipc	a0,0x0
 a56:	15e53503          	ld	a0,350(a0) # bb0 <freep>
 a5a:	c515                	beqz	a0,a86 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a5e:	4798                	lw	a4,8(a5)
 a60:	02977f63          	bgeu	a4,s1,a9e <malloc+0x70>
 a64:	8a4e                	mv	s4,s3
 a66:	0009871b          	sext.w	a4,s3
 a6a:	6685                	lui	a3,0x1
 a6c:	00d77363          	bgeu	a4,a3,a72 <malloc+0x44>
 a70:	6a05                	lui	s4,0x1
 a72:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a76:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a7a:	00000917          	auipc	s2,0x0
 a7e:	13690913          	addi	s2,s2,310 # bb0 <freep>
  if(p == (char*)-1)
 a82:	5afd                	li	s5,-1
 a84:	a88d                	j	af6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a86:	00000797          	auipc	a5,0x0
 a8a:	1a278793          	addi	a5,a5,418 # c28 <base>
 a8e:	00000717          	auipc	a4,0x0
 a92:	12f73123          	sd	a5,290(a4) # bb0 <freep>
 a96:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a98:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a9c:	b7e1                	j	a64 <malloc+0x36>
      if(p->s.size == nunits)
 a9e:	02e48b63          	beq	s1,a4,ad4 <malloc+0xa6>
        p->s.size -= nunits;
 aa2:	4137073b          	subw	a4,a4,s3
 aa6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 aa8:	1702                	slli	a4,a4,0x20
 aaa:	9301                	srli	a4,a4,0x20
 aac:	0712                	slli	a4,a4,0x4
 aae:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ab0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ab4:	00000717          	auipc	a4,0x0
 ab8:	0ea73e23          	sd	a0,252(a4) # bb0 <freep>
      return (void*)(p + 1);
 abc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ac0:	70e2                	ld	ra,56(sp)
 ac2:	7442                	ld	s0,48(sp)
 ac4:	74a2                	ld	s1,40(sp)
 ac6:	7902                	ld	s2,32(sp)
 ac8:	69e2                	ld	s3,24(sp)
 aca:	6a42                	ld	s4,16(sp)
 acc:	6aa2                	ld	s5,8(sp)
 ace:	6b02                	ld	s6,0(sp)
 ad0:	6121                	addi	sp,sp,64
 ad2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ad4:	6398                	ld	a4,0(a5)
 ad6:	e118                	sd	a4,0(a0)
 ad8:	bff1                	j	ab4 <malloc+0x86>
  hp->s.size = nu;
 ada:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ade:	0541                	addi	a0,a0,16
 ae0:	00000097          	auipc	ra,0x0
 ae4:	ec6080e7          	jalr	-314(ra) # 9a6 <free>
  return freep;
 ae8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aec:	d971                	beqz	a0,ac0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af0:	4798                	lw	a4,8(a5)
 af2:	fa9776e3          	bgeu	a4,s1,a9e <malloc+0x70>
    if(p == freep)
 af6:	00093703          	ld	a4,0(s2)
 afa:	853e                	mv	a0,a5
 afc:	fef719e3          	bne	a4,a5,aee <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 b00:	8552                	mv	a0,s4
 b02:	00000097          	auipc	ra,0x0
 b06:	b7e080e7          	jalr	-1154(ra) # 680 <sbrk>
  if(p == (char*)-1)
 b0a:	fd5518e3          	bne	a0,s5,ada <malloc+0xac>
        return 0;
 b0e:	4501                	li	a0,0
 b10:	bf45                	j	ac0 <malloc+0x92>

0000000000000b12 <setjmp>:
 b12:	e100                	sd	s0,0(a0)
 b14:	e504                	sd	s1,8(a0)
 b16:	01253823          	sd	s2,16(a0)
 b1a:	01353c23          	sd	s3,24(a0)
 b1e:	03453023          	sd	s4,32(a0)
 b22:	03553423          	sd	s5,40(a0)
 b26:	03653823          	sd	s6,48(a0)
 b2a:	03753c23          	sd	s7,56(a0)
 b2e:	05853023          	sd	s8,64(a0)
 b32:	05953423          	sd	s9,72(a0)
 b36:	05a53823          	sd	s10,80(a0)
 b3a:	05b53c23          	sd	s11,88(a0)
 b3e:	06153023          	sd	ra,96(a0)
 b42:	06253423          	sd	sp,104(a0)
 b46:	4501                	li	a0,0
 b48:	8082                	ret

0000000000000b4a <longjmp>:
 b4a:	6100                	ld	s0,0(a0)
 b4c:	6504                	ld	s1,8(a0)
 b4e:	01053903          	ld	s2,16(a0)
 b52:	01853983          	ld	s3,24(a0)
 b56:	02053a03          	ld	s4,32(a0)
 b5a:	02853a83          	ld	s5,40(a0)
 b5e:	03053b03          	ld	s6,48(a0)
 b62:	03853b83          	ld	s7,56(a0)
 b66:	04053c03          	ld	s8,64(a0)
 b6a:	04853c83          	ld	s9,72(a0)
 b6e:	05053d03          	ld	s10,80(a0)
 b72:	05853d83          	ld	s11,88(a0)
 b76:	06053083          	ld	ra,96(a0)
 b7a:	06853103          	ld	sp,104(a0)
 b7e:	c199                	beqz	a1,b84 <longjmp_1>
 b80:	852e                	mv	a0,a1
 b82:	8082                	ret

0000000000000b84 <longjmp_1>:
 b84:	4505                	li	a0,1
 b86:	8082                	ret
