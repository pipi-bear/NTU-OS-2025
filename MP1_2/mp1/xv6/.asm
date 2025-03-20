
user/_mp1-part2-1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <s2>:
        thread_yield();
    }
}

void s2(int signo)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
   8:	85aa                	mv	a1,a0
    printf("handler 2: %d\n", signo);
   a:	00001517          	auipc	a0,0x1
   e:	e6650513          	addi	a0,a0,-410 # e70 <get_current_thread+0x14>
  12:	00001097          	auipc	ra,0x1
  16:	8c4080e7          	jalr	-1852(ra) # 8d6 <printf>
}
  1a:	60a2                	ld	ra,8(sp)
  1c:	6402                	ld	s0,0(sp)
  1e:	0141                	addi	sp,sp,16
  20:	8082                	ret

0000000000000022 <s3>:
{
  22:	7179                	addi	sp,sp,-48
  24:	f406                	sd	ra,40(sp)
  26:	f022                	sd	s0,32(sp)
  28:	ec26                	sd	s1,24(sp)
  2a:	e84a                	sd	s2,16(sp)
  2c:	e44e                	sd	s3,8(sp)
  2e:	e052                	sd	s4,0(sp)
  30:	1800                	addi	s0,sp,48
  32:	892a                	mv	s2,a0
  34:	44d1                	li	s1,20
        else printf("handler 3: %d\n", i*2+1);
  36:	00001a17          	auipc	s4,0x1
  3a:	e4aa0a13          	addi	s4,s4,-438 # e80 <get_current_thread+0x24>
        if(i == 15) {
  3e:	49f9                	li	s3,30
  40:	a831                	j	5c <s3+0x3a>
        if(signo) printf("handler 3: %d\n", i*2);
  42:	85a6                	mv	a1,s1
  44:	8552                	mv	a0,s4
  46:	00001097          	auipc	ra,0x1
  4a:	890080e7          	jalr	-1904(ra) # 8d6 <printf>
        if(i == 15) {
  4e:	2489                	addiw	s1,s1,2
  50:	03348063          	beq	s1,s3,70 <s3+0x4e>
        thread_yield();
  54:	00001097          	auipc	ra,0x1
  58:	d16080e7          	jalr	-746(ra) # d6a <thread_yield>
        if(signo) printf("handler 3: %d\n", i*2);
  5c:	fe0913e3          	bnez	s2,42 <s3+0x20>
        else printf("handler 3: %d\n", i*2+1);
  60:	0014859b          	addiw	a1,s1,1
  64:	8552                	mv	a0,s4
  66:	00001097          	auipc	ra,0x1
  6a:	870080e7          	jalr	-1936(ra) # 8d6 <printf>
  6e:	b7c5                	j	4e <s3+0x2c>
}
  70:	70a2                	ld	ra,40(sp)
  72:	7402                	ld	s0,32(sp)
  74:	64e2                	ld	s1,24(sp)
  76:	6942                	ld	s2,16(sp)
  78:	69a2                	ld	s3,8(sp)
  7a:	6a02                	ld	s4,0(sp)
  7c:	6145                	addi	sp,sp,48
  7e:	8082                	ret

0000000000000080 <f3>:

void f3(void *arg)
{
  80:	7179                	addi	sp,sp,-48
  82:	f406                	sd	ra,40(sp)
  84:	f022                	sd	s0,32(sp)
  86:	ec26                	sd	s1,24(sp)
  88:	e84a                	sd	s2,16(sp)
  8a:	e44e                	sd	s3,8(sp)
  8c:	e052                	sd	s4,0(sp)
  8e:	1800                	addi	s0,sp,48
    thread_register_handler(0, s3);
  90:	00000597          	auipc	a1,0x0
  94:	f9258593          	addi	a1,a1,-110 # 22 <s3>
  98:	4501                	li	a0,0
  9a:	00001097          	auipc	ra,0x1
  9e:	d66080e7          	jalr	-666(ra) # e00 <thread_register_handler>
    thread_register_handler(1, s3);
  a2:	00000597          	auipc	a1,0x0
  a6:	f8058593          	addi	a1,a1,-128 # 22 <s3>
  aa:	4505                	li	a0,1
  ac:	00001097          	auipc	ra,0x1
  b0:	d54080e7          	jalr	-684(ra) # e00 <thread_register_handler>

    int i = 10000;
    while (1) {
        printf("thread 3: %d\n", i++);
  b4:	6489                	lui	s1,0x2
  b6:	71048593          	addi	a1,s1,1808 # 2710 <__global_pointer$+0xfe7>
  ba:	00001517          	auipc	a0,0x1
  be:	dd650513          	addi	a0,a0,-554 # e90 <get_current_thread+0x34>
  c2:	00001097          	auipc	ra,0x1
  c6:	814080e7          	jalr	-2028(ra) # 8d6 <printf>
  ca:	71148493          	addi	s1,s1,1809
  ce:	00001a17          	auipc	s4,0x1
  d2:	dc2a0a13          	addi	s4,s4,-574 # e90 <get_current_thread+0x34>
        if(i == 10005) {
  d6:	6989                	lui	s3,0x2
  d8:	71598993          	addi	s3,s3,1813 # 2715 <__global_pointer$+0xfec>
  dc:	a011                	j	e0 <f3+0x60>
        printf("thread 3: %d\n", i++);
  de:	84ca                	mv	s1,s2
            thread_exit();
        }
        thread_yield();
  e0:	00001097          	auipc	ra,0x1
  e4:	c8a080e7          	jalr	-886(ra) # d6a <thread_yield>
        printf("thread 3: %d\n", i++);
  e8:	0014891b          	addiw	s2,s1,1
  ec:	85a6                	mv	a1,s1
  ee:	8552                	mv	a0,s4
  f0:	00000097          	auipc	ra,0x0
  f4:	7e6080e7          	jalr	2022(ra) # 8d6 <printf>
        if(i == 10005) {
  f8:	ff3913e3          	bne	s2,s3,de <f3+0x5e>
            thread_exit();
  fc:	00001097          	auipc	ra,0x1
 100:	ad0080e7          	jalr	-1328(ra) # bcc <thread_exit>
 104:	bfe9                	j	de <f3+0x5e>

0000000000000106 <f2>:
    }
}

void f2(void *arg)
{
 106:	7139                	addi	sp,sp,-64
 108:	fc06                	sd	ra,56(sp)
 10a:	f822                	sd	s0,48(sp)
 10c:	f426                	sd	s1,40(sp)
 10e:	f04a                	sd	s2,32(sp)
 110:	ec4e                	sd	s3,24(sp)
 112:	e852                	sd	s4,16(sp)
 114:	e456                	sd	s5,8(sp)
 116:	e05a                	sd	s6,0(sp)
 118:	0080                	addi	s0,sp,64
    thread_register_handler(0, s2);
 11a:	00000597          	auipc	a1,0x0
 11e:	ee658593          	addi	a1,a1,-282 # 0 <s2>
 122:	4501                	li	a0,0
 124:	00001097          	auipc	ra,0x1
 128:	cdc080e7          	jalr	-804(ra) # e00 <thread_register_handler>
    thread_register_handler(1, s2);
 12c:	00000597          	auipc	a1,0x0
 130:	ed458593          	addi	a1,a1,-300 # 0 <s2>
 134:	4505                	li	a0,1
 136:	00001097          	auipc	ra,0x1
 13a:	cca080e7          	jalr	-822(ra) # e00 <thread_register_handler>

    int i = 0;
 13e:	4581                	li	a1,0
    while(1) {
        printf("thread 2: %d\n",i++);
 140:	00001997          	auipc	s3,0x1
 144:	d6098993          	addi	s3,s3,-672 # ea0 <get_current_thread+0x44>
        if(i==5){
 148:	4915                	li	s2,5
            // Suspend this thread (g_t1) at i=103
            g_t2 = get_current_thread();
            printf("thread %d: suspending\n", g_t2->ID);             // "thread 1: suspending"
            thread_suspend(g_t2);  // g_t1 points to the same thread
        }
        if (i == 10) {
 14a:	4a29                	li	s4,10
            g_t2 = get_current_thread();
 14c:	00001a97          	auipc	s5,0x1
 150:	de4a8a93          	addi	s5,s5,-540 # f30 <g_t2>
            printf("thread %d: suspending\n", g_t2->ID);             // "thread 1: suspending"
 154:	00001b17          	auipc	s6,0x1
 158:	d5cb0b13          	addi	s6,s6,-676 # eb0 <get_current_thread+0x54>
 15c:	a80d                	j	18e <f2+0x88>
            g_t2 = get_current_thread();
 15e:	00001097          	auipc	ra,0x1
 162:	cfe080e7          	jalr	-770(ra) # e5c <get_current_thread>
 166:	00aab023          	sd	a0,0(s5)
            printf("thread %d: suspending\n", g_t2->ID);             // "thread 1: suspending"
 16a:	09452583          	lw	a1,148(a0)
 16e:	855a                	mv	a0,s6
 170:	00000097          	auipc	ra,0x0
 174:	766080e7          	jalr	1894(ra) # 8d6 <printf>
            thread_suspend(g_t2);  // g_t1 points to the same thread
 178:	000ab503          	ld	a0,0(s5)
 17c:	00001097          	auipc	ra,0x1
 180:	cbe080e7          	jalr	-834(ra) # e3a <thread_suspend>
            thread_exit();
        }
        thread_yield();
 184:	00001097          	auipc	ra,0x1
 188:	be6080e7          	jalr	-1050(ra) # d6a <thread_yield>
        printf("thread 2: %d\n",i++);
 18c:	85a6                	mv	a1,s1
 18e:	0015849b          	addiw	s1,a1,1
 192:	854e                	mv	a0,s3
 194:	00000097          	auipc	ra,0x0
 198:	742080e7          	jalr	1858(ra) # 8d6 <printf>
        if(i==5){
 19c:	fd2481e3          	beq	s1,s2,15e <f2+0x58>
        if (i == 10) {
 1a0:	ff4492e3          	bne	s1,s4,184 <f2+0x7e>
            thread_exit();
 1a4:	00001097          	auipc	ra,0x1
 1a8:	a28080e7          	jalr	-1496(ra) # bcc <thread_exit>
 1ac:	bfe1                	j	184 <f2+0x7e>

00000000000001ae <f1>:
    }
}

void f1(void *arg)
{
 1ae:	711d                	addi	sp,sp,-96
 1b0:	ec86                	sd	ra,88(sp)
 1b2:	e8a2                	sd	s0,80(sp)
 1b4:	e4a6                	sd	s1,72(sp)
 1b6:	e0ca                	sd	s2,64(sp)
 1b8:	fc4e                	sd	s3,56(sp)
 1ba:	f852                	sd	s4,48(sp)
 1bc:	f456                	sd	s5,40(sp)
 1be:	f05a                	sd	s6,32(sp)
 1c0:	ec5e                	sd	s7,24(sp)
 1c2:	e862                	sd	s8,16(sp)
 1c4:	e466                	sd	s9,8(sp)
 1c6:	1080                	addi	s0,sp,96
    int i = 100;
    struct thread *t2 = thread_create(f2, NULL);
 1c8:	4581                	li	a1,0
 1ca:	00000517          	auipc	a0,0x0
 1ce:	f3c50513          	addi	a0,a0,-196 # 106 <f2>
 1d2:	00001097          	auipc	ra,0x1
 1d6:	91c080e7          	jalr	-1764(ra) # aee <thread_create>
 1da:	8caa                	mv	s9,a0
    thread_add_runqueue(t2);
 1dc:	00001097          	auipc	ra,0x1
 1e0:	988080e7          	jalr	-1656(ra) # b64 <thread_add_runqueue>
    struct thread *t3 = thread_create(f3, NULL);
 1e4:	4581                	li	a1,0
 1e6:	00000517          	auipc	a0,0x0
 1ea:	e9a50513          	addi	a0,a0,-358 # 80 <f3>
 1ee:	00001097          	auipc	ra,0x1
 1f2:	900080e7          	jalr	-1792(ra) # aee <thread_create>
 1f6:	8c2a                	mv	s8,a0
    thread_add_runqueue(t3);
 1f8:	00001097          	auipc	ra,0x1
 1fc:	96c080e7          	jalr	-1684(ra) # b64 <thread_add_runqueue>
    int i = 100;
 200:	06400593          	li	a1,100
    
    
    while(1) {
        printf("thread 1: %d\n", i++);
 204:	00001997          	auipc	s3,0x1
 208:	cc498993          	addi	s3,s3,-828 # ec8 <get_current_thread+0x6c>
        if (i == 102) {
 20c:	06600913          	li	s2,102
            thread_kill(t2, 1);
        }
        if (i == 105) {
 210:	06900a13          	li	s4,105
            thread_kill(t3, 0);
        }
        if (i == 110) {
 214:	06e00b13          	li	s6,110
            if (g_t2) {
 218:	00001a97          	auipc	s5,0x1
 21c:	d18a8a93          	addi	s5,s5,-744 # f30 <g_t2>
                printf("thread %d: resuming\n", g_t2->ID);             // Print "thread 1: resuming"
 220:	00001b97          	auipc	s7,0x1
 224:	cb8b8b93          	addi	s7,s7,-840 # ed8 <get_current_thread+0x7c>
 228:	a805                	j	258 <f1+0xaa>
            thread_kill(t2, 1);
 22a:	4585                	li	a1,1
 22c:	8566                	mv	a0,s9
 22e:	00001097          	auipc	ra,0x1
 232:	bfc080e7          	jalr	-1028(ra) # e2a <thread_kill>
        if (i == 110) {
 236:	a821                	j	24e <f1+0xa0>
            thread_kill(t3, 0);
 238:	4581                	li	a1,0
 23a:	8562                	mv	a0,s8
 23c:	00001097          	auipc	ra,0x1
 240:	bee080e7          	jalr	-1042(ra) # e2a <thread_kill>
        if (i == 110) {
 244:	a029                	j	24e <f1+0xa0>
                thread_resume(g_t2);  // Resume thread 1
            }
            thread_exit();
 246:	00001097          	auipc	ra,0x1
 24a:	986080e7          	jalr	-1658(ra) # bcc <thread_exit>
        }
        thread_yield();
 24e:	00001097          	auipc	ra,0x1
 252:	b1c080e7          	jalr	-1252(ra) # d6a <thread_yield>
        printf("thread 1: %d\n", i++);
 256:	85a6                	mv	a1,s1
 258:	0015849b          	addiw	s1,a1,1
 25c:	854e                	mv	a0,s3
 25e:	00000097          	auipc	ra,0x0
 262:	678080e7          	jalr	1656(ra) # 8d6 <printf>
        if (i == 102) {
 266:	fd2482e3          	beq	s1,s2,22a <f1+0x7c>
        if (i == 105) {
 26a:	fd4487e3          	beq	s1,s4,238 <f1+0x8a>
        if (i == 110) {
 26e:	ff6490e3          	bne	s1,s6,24e <f1+0xa0>
            if (g_t2) {
 272:	000ab783          	ld	a5,0(s5)
 276:	dbe1                	beqz	a5,246 <f1+0x98>
                printf("thread %d: resuming\n", g_t2->ID);             // Print "thread 1: resuming"
 278:	0947a583          	lw	a1,148(a5)
 27c:	855e                	mv	a0,s7
 27e:	00000097          	auipc	ra,0x0
 282:	658080e7          	jalr	1624(ra) # 8d6 <printf>
                thread_resume(g_t2);  // Resume thread 1
 286:	000ab503          	ld	a0,0(s5)
 28a:	00001097          	auipc	ra,0x1
 28e:	bc2080e7          	jalr	-1086(ra) # e4c <thread_resume>
 292:	bf55                	j	246 <f1+0x98>

0000000000000294 <main>:
    }
}

int main(int argc, char **argv)
{
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
    printf("mp1-part2-1\n");
 29c:	00001517          	auipc	a0,0x1
 2a0:	c5450513          	addi	a0,a0,-940 # ef0 <get_current_thread+0x94>
 2a4:	00000097          	auipc	ra,0x0
 2a8:	632080e7          	jalr	1586(ra) # 8d6 <printf>
    struct thread *t1 = thread_create(f1, NULL);
 2ac:	4581                	li	a1,0
 2ae:	00000517          	auipc	a0,0x0
 2b2:	f0050513          	addi	a0,a0,-256 # 1ae <f1>
 2b6:	00001097          	auipc	ra,0x1
 2ba:	838080e7          	jalr	-1992(ra) # aee <thread_create>
    thread_add_runqueue(t1);
 2be:	00001097          	auipc	ra,0x1
 2c2:	8a6080e7          	jalr	-1882(ra) # b64 <thread_add_runqueue>
    thread_start_threading();
 2c6:	00001097          	auipc	ra,0x1
 2ca:	b06080e7          	jalr	-1274(ra) # dcc <thread_start_threading>
    printf("\nexited\n");
 2ce:	00001517          	auipc	a0,0x1
 2d2:	c3250513          	addi	a0,a0,-974 # f00 <get_current_thread+0xa4>
 2d6:	00000097          	auipc	ra,0x0
 2da:	600080e7          	jalr	1536(ra) # 8d6 <printf>
    exit(0);
 2de:	4501                	li	a0,0
 2e0:	00000097          	auipc	ra,0x0
 2e4:	27e080e7          	jalr	638(ra) # 55e <exit>

00000000000002e8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ee:	87aa                	mv	a5,a0
 2f0:	0585                	addi	a1,a1,1
 2f2:	0785                	addi	a5,a5,1
 2f4:	fff5c703          	lbu	a4,-1(a1)
 2f8:	fee78fa3          	sb	a4,-1(a5)
 2fc:	fb75                	bnez	a4,2f0 <strcpy+0x8>
    ;
  return os;
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret

0000000000000304 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 30a:	00054783          	lbu	a5,0(a0)
 30e:	cb91                	beqz	a5,322 <strcmp+0x1e>
 310:	0005c703          	lbu	a4,0(a1)
 314:	00f71763          	bne	a4,a5,322 <strcmp+0x1e>
    p++, q++;
 318:	0505                	addi	a0,a0,1
 31a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 31c:	00054783          	lbu	a5,0(a0)
 320:	fbe5                	bnez	a5,310 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 322:	0005c503          	lbu	a0,0(a1)
}
 326:	40a7853b          	subw	a0,a5,a0
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <strlen>:

uint
strlen(const char *s)
{
 330:	1141                	addi	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 336:	00054783          	lbu	a5,0(a0)
 33a:	cf91                	beqz	a5,356 <strlen+0x26>
 33c:	0505                	addi	a0,a0,1
 33e:	87aa                	mv	a5,a0
 340:	4685                	li	a3,1
 342:	9e89                	subw	a3,a3,a0
 344:	00f6853b          	addw	a0,a3,a5
 348:	0785                	addi	a5,a5,1
 34a:	fff7c703          	lbu	a4,-1(a5)
 34e:	fb7d                	bnez	a4,344 <strlen+0x14>
    ;
  return n;
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret
  for(n = 0; s[n]; n++)
 356:	4501                	li	a0,0
 358:	bfe5                	j	350 <strlen+0x20>

000000000000035a <memset>:

void*
memset(void *dst, int c, uint n)
{
 35a:	1141                	addi	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 360:	ce09                	beqz	a2,37a <memset+0x20>
 362:	87aa                	mv	a5,a0
 364:	fff6071b          	addiw	a4,a2,-1
 368:	1702                	slli	a4,a4,0x20
 36a:	9301                	srli	a4,a4,0x20
 36c:	0705                	addi	a4,a4,1
 36e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 370:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 374:	0785                	addi	a5,a5,1
 376:	fee79de3          	bne	a5,a4,370 <memset+0x16>
  }
  return dst;
}
 37a:	6422                	ld	s0,8(sp)
 37c:	0141                	addi	sp,sp,16
 37e:	8082                	ret

0000000000000380 <strchr>:

char*
strchr(const char *s, char c)
{
 380:	1141                	addi	sp,sp,-16
 382:	e422                	sd	s0,8(sp)
 384:	0800                	addi	s0,sp,16
  for(; *s; s++)
 386:	00054783          	lbu	a5,0(a0)
 38a:	cb99                	beqz	a5,3a0 <strchr+0x20>
    if(*s == c)
 38c:	00f58763          	beq	a1,a5,39a <strchr+0x1a>
  for(; *s; s++)
 390:	0505                	addi	a0,a0,1
 392:	00054783          	lbu	a5,0(a0)
 396:	fbfd                	bnez	a5,38c <strchr+0xc>
      return (char*)s;
  return 0;
 398:	4501                	li	a0,0
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <strchr+0x1a>

00000000000003a4 <gets>:

char*
gets(char *buf, int max)
{
 3a4:	711d                	addi	sp,sp,-96
 3a6:	ec86                	sd	ra,88(sp)
 3a8:	e8a2                	sd	s0,80(sp)
 3aa:	e4a6                	sd	s1,72(sp)
 3ac:	e0ca                	sd	s2,64(sp)
 3ae:	fc4e                	sd	s3,56(sp)
 3b0:	f852                	sd	s4,48(sp)
 3b2:	f456                	sd	s5,40(sp)
 3b4:	f05a                	sd	s6,32(sp)
 3b6:	ec5e                	sd	s7,24(sp)
 3b8:	1080                	addi	s0,sp,96
 3ba:	8baa                	mv	s7,a0
 3bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3be:	892a                	mv	s2,a0
 3c0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c2:	4aa9                	li	s5,10
 3c4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3c6:	89a6                	mv	s3,s1
 3c8:	2485                	addiw	s1,s1,1
 3ca:	0344d863          	bge	s1,s4,3fa <gets+0x56>
    cc = read(0, &c, 1);
 3ce:	4605                	li	a2,1
 3d0:	faf40593          	addi	a1,s0,-81
 3d4:	4501                	li	a0,0
 3d6:	00000097          	auipc	ra,0x0
 3da:	1a0080e7          	jalr	416(ra) # 576 <read>
    if(cc < 1)
 3de:	00a05e63          	blez	a0,3fa <gets+0x56>
    buf[i++] = c;
 3e2:	faf44783          	lbu	a5,-81(s0)
 3e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ea:	01578763          	beq	a5,s5,3f8 <gets+0x54>
 3ee:	0905                	addi	s2,s2,1
 3f0:	fd679be3          	bne	a5,s6,3c6 <gets+0x22>
  for(i=0; i+1 < max; ){
 3f4:	89a6                	mv	s3,s1
 3f6:	a011                	j	3fa <gets+0x56>
 3f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3fa:	99de                	add	s3,s3,s7
 3fc:	00098023          	sb	zero,0(s3)
  return buf;
}
 400:	855e                	mv	a0,s7
 402:	60e6                	ld	ra,88(sp)
 404:	6446                	ld	s0,80(sp)
 406:	64a6                	ld	s1,72(sp)
 408:	6906                	ld	s2,64(sp)
 40a:	79e2                	ld	s3,56(sp)
 40c:	7a42                	ld	s4,48(sp)
 40e:	7aa2                	ld	s5,40(sp)
 410:	7b02                	ld	s6,32(sp)
 412:	6be2                	ld	s7,24(sp)
 414:	6125                	addi	sp,sp,96
 416:	8082                	ret

0000000000000418 <stat>:

int
stat(const char *n, struct stat *st)
{
 418:	1101                	addi	sp,sp,-32
 41a:	ec06                	sd	ra,24(sp)
 41c:	e822                	sd	s0,16(sp)
 41e:	e426                	sd	s1,8(sp)
 420:	e04a                	sd	s2,0(sp)
 422:	1000                	addi	s0,sp,32
 424:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 426:	4581                	li	a1,0
 428:	00000097          	auipc	ra,0x0
 42c:	176080e7          	jalr	374(ra) # 59e <open>
  if(fd < 0)
 430:	02054563          	bltz	a0,45a <stat+0x42>
 434:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 436:	85ca                	mv	a1,s2
 438:	00000097          	auipc	ra,0x0
 43c:	17e080e7          	jalr	382(ra) # 5b6 <fstat>
 440:	892a                	mv	s2,a0
  close(fd);
 442:	8526                	mv	a0,s1
 444:	00000097          	auipc	ra,0x0
 448:	142080e7          	jalr	322(ra) # 586 <close>
  return r;
}
 44c:	854a                	mv	a0,s2
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	64a2                	ld	s1,8(sp)
 454:	6902                	ld	s2,0(sp)
 456:	6105                	addi	sp,sp,32
 458:	8082                	ret
    return -1;
 45a:	597d                	li	s2,-1
 45c:	bfc5                	j	44c <stat+0x34>

000000000000045e <atoi>:

int
atoi(const char *s)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 464:	00054603          	lbu	a2,0(a0)
 468:	fd06079b          	addiw	a5,a2,-48
 46c:	0ff7f793          	andi	a5,a5,255
 470:	4725                	li	a4,9
 472:	02f76963          	bltu	a4,a5,4a4 <atoi+0x46>
 476:	86aa                	mv	a3,a0
  n = 0;
 478:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 47a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 47c:	0685                	addi	a3,a3,1
 47e:	0025179b          	slliw	a5,a0,0x2
 482:	9fa9                	addw	a5,a5,a0
 484:	0017979b          	slliw	a5,a5,0x1
 488:	9fb1                	addw	a5,a5,a2
 48a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 48e:	0006c603          	lbu	a2,0(a3)
 492:	fd06071b          	addiw	a4,a2,-48
 496:	0ff77713          	andi	a4,a4,255
 49a:	fee5f1e3          	bgeu	a1,a4,47c <atoi+0x1e>
  return n;
}
 49e:	6422                	ld	s0,8(sp)
 4a0:	0141                	addi	sp,sp,16
 4a2:	8082                	ret
  n = 0;
 4a4:	4501                	li	a0,0
 4a6:	bfe5                	j	49e <atoi+0x40>

00000000000004a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a8:	1141                	addi	sp,sp,-16
 4aa:	e422                	sd	s0,8(sp)
 4ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4ae:	02b57663          	bgeu	a0,a1,4da <memmove+0x32>
    while(n-- > 0)
 4b2:	02c05163          	blez	a2,4d4 <memmove+0x2c>
 4b6:	fff6079b          	addiw	a5,a2,-1
 4ba:	1782                	slli	a5,a5,0x20
 4bc:	9381                	srli	a5,a5,0x20
 4be:	0785                	addi	a5,a5,1
 4c0:	97aa                	add	a5,a5,a0
  dst = vdst;
 4c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 4c4:	0585                	addi	a1,a1,1
 4c6:	0705                	addi	a4,a4,1
 4c8:	fff5c683          	lbu	a3,-1(a1)
 4cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4d0:	fee79ae3          	bne	a5,a4,4c4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
    dst += n;
 4da:	00c50733          	add	a4,a0,a2
    src += n;
 4de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4e0:	fec05ae3          	blez	a2,4d4 <memmove+0x2c>
 4e4:	fff6079b          	addiw	a5,a2,-1
 4e8:	1782                	slli	a5,a5,0x20
 4ea:	9381                	srli	a5,a5,0x20
 4ec:	fff7c793          	not	a5,a5
 4f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4f2:	15fd                	addi	a1,a1,-1
 4f4:	177d                	addi	a4,a4,-1
 4f6:	0005c683          	lbu	a3,0(a1)
 4fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4fe:	fee79ae3          	bne	a5,a4,4f2 <memmove+0x4a>
 502:	bfc9                	j	4d4 <memmove+0x2c>

0000000000000504 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 50a:	ca05                	beqz	a2,53a <memcmp+0x36>
 50c:	fff6069b          	addiw	a3,a2,-1
 510:	1682                	slli	a3,a3,0x20
 512:	9281                	srli	a3,a3,0x20
 514:	0685                	addi	a3,a3,1
 516:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 518:	00054783          	lbu	a5,0(a0)
 51c:	0005c703          	lbu	a4,0(a1)
 520:	00e79863          	bne	a5,a4,530 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 524:	0505                	addi	a0,a0,1
    p2++;
 526:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 528:	fed518e3          	bne	a0,a3,518 <memcmp+0x14>
  }
  return 0;
 52c:	4501                	li	a0,0
 52e:	a019                	j	534 <memcmp+0x30>
      return *p1 - *p2;
 530:	40e7853b          	subw	a0,a5,a4
}
 534:	6422                	ld	s0,8(sp)
 536:	0141                	addi	sp,sp,16
 538:	8082                	ret
  return 0;
 53a:	4501                	li	a0,0
 53c:	bfe5                	j	534 <memcmp+0x30>

000000000000053e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 53e:	1141                	addi	sp,sp,-16
 540:	e406                	sd	ra,8(sp)
 542:	e022                	sd	s0,0(sp)
 544:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 546:	00000097          	auipc	ra,0x0
 54a:	f62080e7          	jalr	-158(ra) # 4a8 <memmove>
}
 54e:	60a2                	ld	ra,8(sp)
 550:	6402                	ld	s0,0(sp)
 552:	0141                	addi	sp,sp,16
 554:	8082                	ret

0000000000000556 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 556:	4885                	li	a7,1
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <exit>:
.global exit
exit:
 li a7, SYS_exit
 55e:	4889                	li	a7,2
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <wait>:
.global wait
wait:
 li a7, SYS_wait
 566:	488d                	li	a7,3
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 56e:	4891                	li	a7,4
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <read>:
.global read
read:
 li a7, SYS_read
 576:	4895                	li	a7,5
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <write>:
.global write
write:
 li a7, SYS_write
 57e:	48c1                	li	a7,16
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <close>:
.global close
close:
 li a7, SYS_close
 586:	48d5                	li	a7,21
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <kill>:
.global kill
kill:
 li a7, SYS_kill
 58e:	4899                	li	a7,6
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <exec>:
.global exec
exec:
 li a7, SYS_exec
 596:	489d                	li	a7,7
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <open>:
.global open
open:
 li a7, SYS_open
 59e:	48bd                	li	a7,15
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5a6:	48c5                	li	a7,17
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5ae:	48c9                	li	a7,18
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5b6:	48a1                	li	a7,8
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <link>:
.global link
link:
 li a7, SYS_link
 5be:	48cd                	li	a7,19
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5c6:	48d1                	li	a7,20
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ce:	48a5                	li	a7,9
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5d6:	48a9                	li	a7,10
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5de:	48ad                	li	a7,11
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5e6:	48b1                	li	a7,12
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ee:	48b5                	li	a7,13
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5f6:	48b9                	li	a7,14
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5fe:	1101                	addi	sp,sp,-32
 600:	ec06                	sd	ra,24(sp)
 602:	e822                	sd	s0,16(sp)
 604:	1000                	addi	s0,sp,32
 606:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 60a:	4605                	li	a2,1
 60c:	fef40593          	addi	a1,s0,-17
 610:	00000097          	auipc	ra,0x0
 614:	f6e080e7          	jalr	-146(ra) # 57e <write>
}
 618:	60e2                	ld	ra,24(sp)
 61a:	6442                	ld	s0,16(sp)
 61c:	6105                	addi	sp,sp,32
 61e:	8082                	ret

0000000000000620 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 620:	7139                	addi	sp,sp,-64
 622:	fc06                	sd	ra,56(sp)
 624:	f822                	sd	s0,48(sp)
 626:	f426                	sd	s1,40(sp)
 628:	f04a                	sd	s2,32(sp)
 62a:	ec4e                	sd	s3,24(sp)
 62c:	0080                	addi	s0,sp,64
 62e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 630:	c299                	beqz	a3,636 <printint+0x16>
 632:	0805c863          	bltz	a1,6c2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 636:	2581                	sext.w	a1,a1
  neg = 0;
 638:	4881                	li	a7,0
 63a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 63e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 640:	2601                	sext.w	a2,a2
 642:	00001517          	auipc	a0,0x1
 646:	8d650513          	addi	a0,a0,-1834 # f18 <digits>
 64a:	883a                	mv	a6,a4
 64c:	2705                	addiw	a4,a4,1
 64e:	02c5f7bb          	remuw	a5,a1,a2
 652:	1782                	slli	a5,a5,0x20
 654:	9381                	srli	a5,a5,0x20
 656:	97aa                	add	a5,a5,a0
 658:	0007c783          	lbu	a5,0(a5)
 65c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 660:	0005879b          	sext.w	a5,a1
 664:	02c5d5bb          	divuw	a1,a1,a2
 668:	0685                	addi	a3,a3,1
 66a:	fec7f0e3          	bgeu	a5,a2,64a <printint+0x2a>
  if(neg)
 66e:	00088b63          	beqz	a7,684 <printint+0x64>
    buf[i++] = '-';
 672:	fd040793          	addi	a5,s0,-48
 676:	973e                	add	a4,a4,a5
 678:	02d00793          	li	a5,45
 67c:	fef70823          	sb	a5,-16(a4)
 680:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 684:	02e05863          	blez	a4,6b4 <printint+0x94>
 688:	fc040793          	addi	a5,s0,-64
 68c:	00e78933          	add	s2,a5,a4
 690:	fff78993          	addi	s3,a5,-1
 694:	99ba                	add	s3,s3,a4
 696:	377d                	addiw	a4,a4,-1
 698:	1702                	slli	a4,a4,0x20
 69a:	9301                	srli	a4,a4,0x20
 69c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6a0:	fff94583          	lbu	a1,-1(s2)
 6a4:	8526                	mv	a0,s1
 6a6:	00000097          	auipc	ra,0x0
 6aa:	f58080e7          	jalr	-168(ra) # 5fe <putc>
  while(--i >= 0)
 6ae:	197d                	addi	s2,s2,-1
 6b0:	ff3918e3          	bne	s2,s3,6a0 <printint+0x80>
}
 6b4:	70e2                	ld	ra,56(sp)
 6b6:	7442                	ld	s0,48(sp)
 6b8:	74a2                	ld	s1,40(sp)
 6ba:	7902                	ld	s2,32(sp)
 6bc:	69e2                	ld	s3,24(sp)
 6be:	6121                	addi	sp,sp,64
 6c0:	8082                	ret
    x = -xx;
 6c2:	40b005bb          	negw	a1,a1
    neg = 1;
 6c6:	4885                	li	a7,1
    x = -xx;
 6c8:	bf8d                	j	63a <printint+0x1a>

00000000000006ca <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ca:	7119                	addi	sp,sp,-128
 6cc:	fc86                	sd	ra,120(sp)
 6ce:	f8a2                	sd	s0,112(sp)
 6d0:	f4a6                	sd	s1,104(sp)
 6d2:	f0ca                	sd	s2,96(sp)
 6d4:	ecce                	sd	s3,88(sp)
 6d6:	e8d2                	sd	s4,80(sp)
 6d8:	e4d6                	sd	s5,72(sp)
 6da:	e0da                	sd	s6,64(sp)
 6dc:	fc5e                	sd	s7,56(sp)
 6de:	f862                	sd	s8,48(sp)
 6e0:	f466                	sd	s9,40(sp)
 6e2:	f06a                	sd	s10,32(sp)
 6e4:	ec6e                	sd	s11,24(sp)
 6e6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e8:	0005c903          	lbu	s2,0(a1)
 6ec:	18090f63          	beqz	s2,88a <vprintf+0x1c0>
 6f0:	8aaa                	mv	s5,a0
 6f2:	8b32                	mv	s6,a2
 6f4:	00158493          	addi	s1,a1,1
  state = 0;
 6f8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6fa:	02500a13          	li	s4,37
      if(c == 'd'){
 6fe:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 702:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 706:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 70a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 70e:	00001b97          	auipc	s7,0x1
 712:	80ab8b93          	addi	s7,s7,-2038 # f18 <digits>
 716:	a839                	j	734 <vprintf+0x6a>
        putc(fd, c);
 718:	85ca                	mv	a1,s2
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	ee2080e7          	jalr	-286(ra) # 5fe <putc>
 724:	a019                	j	72a <vprintf+0x60>
    } else if(state == '%'){
 726:	01498f63          	beq	s3,s4,744 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 72a:	0485                	addi	s1,s1,1
 72c:	fff4c903          	lbu	s2,-1(s1)
 730:	14090d63          	beqz	s2,88a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 734:	0009079b          	sext.w	a5,s2
    if(state == 0){
 738:	fe0997e3          	bnez	s3,726 <vprintf+0x5c>
      if(c == '%'){
 73c:	fd479ee3          	bne	a5,s4,718 <vprintf+0x4e>
        state = '%';
 740:	89be                	mv	s3,a5
 742:	b7e5                	j	72a <vprintf+0x60>
      if(c == 'd'){
 744:	05878063          	beq	a5,s8,784 <vprintf+0xba>
      } else if(c == 'l') {
 748:	05978c63          	beq	a5,s9,7a0 <vprintf+0xd6>
      } else if(c == 'x') {
 74c:	07a78863          	beq	a5,s10,7bc <vprintf+0xf2>
      } else if(c == 'p') {
 750:	09b78463          	beq	a5,s11,7d8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 754:	07300713          	li	a4,115
 758:	0ce78663          	beq	a5,a4,824 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 75c:	06300713          	li	a4,99
 760:	0ee78e63          	beq	a5,a4,85c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 764:	11478863          	beq	a5,s4,874 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 768:	85d2                	mv	a1,s4
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e92080e7          	jalr	-366(ra) # 5fe <putc>
        putc(fd, c);
 774:	85ca                	mv	a1,s2
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	e86080e7          	jalr	-378(ra) # 5fe <putc>
      }
      state = 0;
 780:	4981                	li	s3,0
 782:	b765                	j	72a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 784:	008b0913          	addi	s2,s6,8
 788:	4685                	li	a3,1
 78a:	4629                	li	a2,10
 78c:	000b2583          	lw	a1,0(s6)
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	e8e080e7          	jalr	-370(ra) # 620 <printint>
 79a:	8b4a                	mv	s6,s2
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b771                	j	72a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a0:	008b0913          	addi	s2,s6,8
 7a4:	4681                	li	a3,0
 7a6:	4629                	li	a2,10
 7a8:	000b2583          	lw	a1,0(s6)
 7ac:	8556                	mv	a0,s5
 7ae:	00000097          	auipc	ra,0x0
 7b2:	e72080e7          	jalr	-398(ra) # 620 <printint>
 7b6:	8b4a                	mv	s6,s2
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bf85                	j	72a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7bc:	008b0913          	addi	s2,s6,8
 7c0:	4681                	li	a3,0
 7c2:	4641                	li	a2,16
 7c4:	000b2583          	lw	a1,0(s6)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	e56080e7          	jalr	-426(ra) # 620 <printint>
 7d2:	8b4a                	mv	s6,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bf91                	j	72a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7d8:	008b0793          	addi	a5,s6,8
 7dc:	f8f43423          	sd	a5,-120(s0)
 7e0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7e4:	03000593          	li	a1,48
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	e14080e7          	jalr	-492(ra) # 5fe <putc>
  putc(fd, 'x');
 7f2:	85ea                	mv	a1,s10
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e08080e7          	jalr	-504(ra) # 5fe <putc>
 7fe:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 800:	03c9d793          	srli	a5,s3,0x3c
 804:	97de                	add	a5,a5,s7
 806:	0007c583          	lbu	a1,0(a5)
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	df2080e7          	jalr	-526(ra) # 5fe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 814:	0992                	slli	s3,s3,0x4
 816:	397d                	addiw	s2,s2,-1
 818:	fe0914e3          	bnez	s2,800 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 81c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 820:	4981                	li	s3,0
 822:	b721                	j	72a <vprintf+0x60>
        s = va_arg(ap, char*);
 824:	008b0993          	addi	s3,s6,8
 828:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 82c:	02090163          	beqz	s2,84e <vprintf+0x184>
        while(*s != 0){
 830:	00094583          	lbu	a1,0(s2)
 834:	c9a1                	beqz	a1,884 <vprintf+0x1ba>
          putc(fd, *s);
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	dc6080e7          	jalr	-570(ra) # 5fe <putc>
          s++;
 840:	0905                	addi	s2,s2,1
        while(*s != 0){
 842:	00094583          	lbu	a1,0(s2)
 846:	f9e5                	bnez	a1,836 <vprintf+0x16c>
        s = va_arg(ap, char*);
 848:	8b4e                	mv	s6,s3
      state = 0;
 84a:	4981                	li	s3,0
 84c:	bdf9                	j	72a <vprintf+0x60>
          s = "(null)";
 84e:	00000917          	auipc	s2,0x0
 852:	6c290913          	addi	s2,s2,1730 # f10 <get_current_thread+0xb4>
        while(*s != 0){
 856:	02800593          	li	a1,40
 85a:	bff1                	j	836 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 85c:	008b0913          	addi	s2,s6,8
 860:	000b4583          	lbu	a1,0(s6)
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	d98080e7          	jalr	-616(ra) # 5fe <putc>
 86e:	8b4a                	mv	s6,s2
      state = 0;
 870:	4981                	li	s3,0
 872:	bd65                	j	72a <vprintf+0x60>
        putc(fd, c);
 874:	85d2                	mv	a1,s4
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	d86080e7          	jalr	-634(ra) # 5fe <putc>
      state = 0;
 880:	4981                	li	s3,0
 882:	b565                	j	72a <vprintf+0x60>
        s = va_arg(ap, char*);
 884:	8b4e                	mv	s6,s3
      state = 0;
 886:	4981                	li	s3,0
 888:	b54d                	j	72a <vprintf+0x60>
    }
  }
}
 88a:	70e6                	ld	ra,120(sp)
 88c:	7446                	ld	s0,112(sp)
 88e:	74a6                	ld	s1,104(sp)
 890:	7906                	ld	s2,96(sp)
 892:	69e6                	ld	s3,88(sp)
 894:	6a46                	ld	s4,80(sp)
 896:	6aa6                	ld	s5,72(sp)
 898:	6b06                	ld	s6,64(sp)
 89a:	7be2                	ld	s7,56(sp)
 89c:	7c42                	ld	s8,48(sp)
 89e:	7ca2                	ld	s9,40(sp)
 8a0:	7d02                	ld	s10,32(sp)
 8a2:	6de2                	ld	s11,24(sp)
 8a4:	6109                	addi	sp,sp,128
 8a6:	8082                	ret

00000000000008a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8a8:	715d                	addi	sp,sp,-80
 8aa:	ec06                	sd	ra,24(sp)
 8ac:	e822                	sd	s0,16(sp)
 8ae:	1000                	addi	s0,sp,32
 8b0:	e010                	sd	a2,0(s0)
 8b2:	e414                	sd	a3,8(s0)
 8b4:	e818                	sd	a4,16(s0)
 8b6:	ec1c                	sd	a5,24(s0)
 8b8:	03043023          	sd	a6,32(s0)
 8bc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8c4:	8622                	mv	a2,s0
 8c6:	00000097          	auipc	ra,0x0
 8ca:	e04080e7          	jalr	-508(ra) # 6ca <vprintf>
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	6161                	addi	sp,sp,80
 8d4:	8082                	ret

00000000000008d6 <printf>:

void
printf(const char *fmt, ...)
{
 8d6:	711d                	addi	sp,sp,-96
 8d8:	ec06                	sd	ra,24(sp)
 8da:	e822                	sd	s0,16(sp)
 8dc:	1000                	addi	s0,sp,32
 8de:	e40c                	sd	a1,8(s0)
 8e0:	e810                	sd	a2,16(s0)
 8e2:	ec14                	sd	a3,24(s0)
 8e4:	f018                	sd	a4,32(s0)
 8e6:	f41c                	sd	a5,40(s0)
 8e8:	03043823          	sd	a6,48(s0)
 8ec:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8f0:	00840613          	addi	a2,s0,8
 8f4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8f8:	85aa                	mv	a1,a0
 8fa:	4505                	li	a0,1
 8fc:	00000097          	auipc	ra,0x0
 900:	dce080e7          	jalr	-562(ra) # 6ca <vprintf>
}
 904:	60e2                	ld	ra,24(sp)
 906:	6442                	ld	s0,16(sp)
 908:	6125                	addi	sp,sp,96
 90a:	8082                	ret

000000000000090c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90c:	1141                	addi	sp,sp,-16
 90e:	e422                	sd	s0,8(sp)
 910:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 912:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 916:	00000797          	auipc	a5,0x0
 91a:	6227b783          	ld	a5,1570(a5) # f38 <freep>
 91e:	a805                	j	94e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 920:	4618                	lw	a4,8(a2)
 922:	9db9                	addw	a1,a1,a4
 924:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 928:	6398                	ld	a4,0(a5)
 92a:	6318                	ld	a4,0(a4)
 92c:	fee53823          	sd	a4,-16(a0)
 930:	a091                	j	974 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 932:	ff852703          	lw	a4,-8(a0)
 936:	9e39                	addw	a2,a2,a4
 938:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 93a:	ff053703          	ld	a4,-16(a0)
 93e:	e398                	sd	a4,0(a5)
 940:	a099                	j	986 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 942:	6398                	ld	a4,0(a5)
 944:	00e7e463          	bltu	a5,a4,94c <free+0x40>
 948:	00e6ea63          	bltu	a3,a4,95c <free+0x50>
{
 94c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94e:	fed7fae3          	bgeu	a5,a3,942 <free+0x36>
 952:	6398                	ld	a4,0(a5)
 954:	00e6e463          	bltu	a3,a4,95c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 958:	fee7eae3          	bltu	a5,a4,94c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 95c:	ff852583          	lw	a1,-8(a0)
 960:	6390                	ld	a2,0(a5)
 962:	02059713          	slli	a4,a1,0x20
 966:	9301                	srli	a4,a4,0x20
 968:	0712                	slli	a4,a4,0x4
 96a:	9736                	add	a4,a4,a3
 96c:	fae60ae3          	beq	a2,a4,920 <free+0x14>
    bp->s.ptr = p->s.ptr;
 970:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 974:	4790                	lw	a2,8(a5)
 976:	02061713          	slli	a4,a2,0x20
 97a:	9301                	srli	a4,a4,0x20
 97c:	0712                	slli	a4,a4,0x4
 97e:	973e                	add	a4,a4,a5
 980:	fae689e3          	beq	a3,a4,932 <free+0x26>
  } else
    p->s.ptr = bp;
 984:	e394                	sd	a3,0(a5)
  freep = p;
 986:	00000717          	auipc	a4,0x0
 98a:	5af73923          	sd	a5,1458(a4) # f38 <freep>
}
 98e:	6422                	ld	s0,8(sp)
 990:	0141                	addi	sp,sp,16
 992:	8082                	ret

0000000000000994 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 994:	7139                	addi	sp,sp,-64
 996:	fc06                	sd	ra,56(sp)
 998:	f822                	sd	s0,48(sp)
 99a:	f426                	sd	s1,40(sp)
 99c:	f04a                	sd	s2,32(sp)
 99e:	ec4e                	sd	s3,24(sp)
 9a0:	e852                	sd	s4,16(sp)
 9a2:	e456                	sd	s5,8(sp)
 9a4:	e05a                	sd	s6,0(sp)
 9a6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a8:	02051493          	slli	s1,a0,0x20
 9ac:	9081                	srli	s1,s1,0x20
 9ae:	04bd                	addi	s1,s1,15
 9b0:	8091                	srli	s1,s1,0x4
 9b2:	0014899b          	addiw	s3,s1,1
 9b6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9b8:	00000517          	auipc	a0,0x0
 9bc:	58053503          	ld	a0,1408(a0) # f38 <freep>
 9c0:	c515                	beqz	a0,9ec <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c4:	4798                	lw	a4,8(a5)
 9c6:	02977f63          	bgeu	a4,s1,a04 <malloc+0x70>
 9ca:	8a4e                	mv	s4,s3
 9cc:	0009871b          	sext.w	a4,s3
 9d0:	6685                	lui	a3,0x1
 9d2:	00d77363          	bgeu	a4,a3,9d8 <malloc+0x44>
 9d6:	6a05                	lui	s4,0x1
 9d8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9dc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e0:	00000917          	auipc	s2,0x0
 9e4:	55890913          	addi	s2,s2,1368 # f38 <freep>
  if(p == (char*)-1)
 9e8:	5afd                	li	s5,-1
 9ea:	a88d                	j	a5c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9ec:	00000797          	auipc	a5,0x0
 9f0:	55c78793          	addi	a5,a5,1372 # f48 <base>
 9f4:	00000717          	auipc	a4,0x0
 9f8:	54f73223          	sd	a5,1348(a4) # f38 <freep>
 9fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a02:	b7e1                	j	9ca <malloc+0x36>
      if(p->s.size == nunits)
 a04:	02e48b63          	beq	s1,a4,a3a <malloc+0xa6>
        p->s.size -= nunits;
 a08:	4137073b          	subw	a4,a4,s3
 a0c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a0e:	1702                	slli	a4,a4,0x20
 a10:	9301                	srli	a4,a4,0x20
 a12:	0712                	slli	a4,a4,0x4
 a14:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a16:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a1a:	00000717          	auipc	a4,0x0
 a1e:	50a73f23          	sd	a0,1310(a4) # f38 <freep>
      return (void*)(p + 1);
 a22:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a26:	70e2                	ld	ra,56(sp)
 a28:	7442                	ld	s0,48(sp)
 a2a:	74a2                	ld	s1,40(sp)
 a2c:	7902                	ld	s2,32(sp)
 a2e:	69e2                	ld	s3,24(sp)
 a30:	6a42                	ld	s4,16(sp)
 a32:	6aa2                	ld	s5,8(sp)
 a34:	6b02                	ld	s6,0(sp)
 a36:	6121                	addi	sp,sp,64
 a38:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a3a:	6398                	ld	a4,0(a5)
 a3c:	e118                	sd	a4,0(a0)
 a3e:	bff1                	j	a1a <malloc+0x86>
  hp->s.size = nu;
 a40:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a44:	0541                	addi	a0,a0,16
 a46:	00000097          	auipc	ra,0x0
 a4a:	ec6080e7          	jalr	-314(ra) # 90c <free>
  return freep;
 a4e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a52:	d971                	beqz	a0,a26 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a56:	4798                	lw	a4,8(a5)
 a58:	fa9776e3          	bgeu	a4,s1,a04 <malloc+0x70>
    if(p == freep)
 a5c:	00093703          	ld	a4,0(s2)
 a60:	853e                	mv	a0,a5
 a62:	fef719e3          	bne	a4,a5,a54 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a66:	8552                	mv	a0,s4
 a68:	00000097          	auipc	ra,0x0
 a6c:	b7e080e7          	jalr	-1154(ra) # 5e6 <sbrk>
  if(p == (char*)-1)
 a70:	fd5518e3          	bne	a0,s5,a40 <malloc+0xac>
        return 0;
 a74:	4501                	li	a0,0
 a76:	bf45                	j	a26 <malloc+0x92>

0000000000000a78 <setjmp>:
 a78:	e100                	sd	s0,0(a0)
 a7a:	e504                	sd	s1,8(a0)
 a7c:	01253823          	sd	s2,16(a0)
 a80:	01353c23          	sd	s3,24(a0)
 a84:	03453023          	sd	s4,32(a0)
 a88:	03553423          	sd	s5,40(a0)
 a8c:	03653823          	sd	s6,48(a0)
 a90:	03753c23          	sd	s7,56(a0)
 a94:	05853023          	sd	s8,64(a0)
 a98:	05953423          	sd	s9,72(a0)
 a9c:	05a53823          	sd	s10,80(a0)
 aa0:	05b53c23          	sd	s11,88(a0)
 aa4:	06153023          	sd	ra,96(a0)
 aa8:	06253423          	sd	sp,104(a0)
 aac:	4501                	li	a0,0
 aae:	8082                	ret

0000000000000ab0 <longjmp>:
 ab0:	6100                	ld	s0,0(a0)
 ab2:	6504                	ld	s1,8(a0)
 ab4:	01053903          	ld	s2,16(a0)
 ab8:	01853983          	ld	s3,24(a0)
 abc:	02053a03          	ld	s4,32(a0)
 ac0:	02853a83          	ld	s5,40(a0)
 ac4:	03053b03          	ld	s6,48(a0)
 ac8:	03853b83          	ld	s7,56(a0)
 acc:	04053c03          	ld	s8,64(a0)
 ad0:	04853c83          	ld	s9,72(a0)
 ad4:	05053d03          	ld	s10,80(a0)
 ad8:	05853d83          	ld	s11,88(a0)
 adc:	06053083          	ld	ra,96(a0)
 ae0:	06853103          	ld	sp,104(a0)
 ae4:	c199                	beqz	a1,aea <longjmp_1>
 ae6:	852e                	mv	a0,a1
 ae8:	8082                	ret

0000000000000aea <longjmp_1>:
 aea:	4505                	li	a0,1
 aec:	8082                	ret

0000000000000aee <thread_create>:
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
//static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
 aee:	7179                	addi	sp,sp,-48
 af0:	f406                	sd	ra,40(sp)
 af2:	f022                	sd	s0,32(sp)
 af4:	ec26                	sd	s1,24(sp)
 af6:	e84a                	sd	s2,16(sp)
 af8:	e44e                	sd	s3,8(sp)
 afa:	1800                	addi	s0,sp,48
 afc:	89aa                	mv	s3,a0
 afe:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
 b00:	14000513          	li	a0,320
 b04:	00000097          	auipc	ra,0x0
 b08:	e90080e7          	jalr	-368(ra) # 994 <malloc>
 b0c:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
 b0e:	6505                	lui	a0,0x1
 b10:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0x136>
 b14:	00000097          	auipc	ra,0x0
 b18:	e80080e7          	jalr	-384(ra) # 994 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
 b1c:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
 b20:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
 b24:	00000717          	auipc	a4,0x0
 b28:	40870713          	addi	a4,a4,1032 # f2c <id>
 b2c:	431c                	lw	a5,0(a4)
 b2e:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
 b32:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;
 b36:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
 b38:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
 b3c:	ec88                	sd	a0,24(s1)
    id++;
 b3e:	2785                	addiw	a5,a5,1
 b40:	c31c                	sw	a5,0(a4)

    // part 2
    t->sig_handler[0] = NULL_FUNC;
 b42:	57fd                	li	a5,-1
 b44:	f8dc                	sd	a5,176(s1)
    t->sig_handler[1] = NULL_FUNC;
 b46:	fcdc                	sd	a5,184(s1)
    t->signo = -1;
 b48:	0cf4a023          	sw	a5,192(s1)
    t->handler_buf_set = 0;
 b4c:	1204ac23          	sw	zero,312(s1)
    t->suspended = 0; 
 b50:	0a04a423          	sw	zero,168(s1)
    return t;
}
 b54:	8526                	mv	a0,s1
 b56:	70a2                	ld	ra,40(sp)
 b58:	7402                	ld	s0,32(sp)
 b5a:	64e2                	ld	s1,24(sp)
 b5c:	6942                	ld	s2,16(sp)
 b5e:	69a2                	ld	s3,8(sp)
 b60:	6145                	addi	sp,sp,48
 b62:	8082                	ret

0000000000000b64 <thread_add_runqueue>:
void thread_add_runqueue(struct thread *t){
 b64:	1141                	addi	sp,sp,-16
 b66:	e422                	sd	s0,8(sp)
 b68:	0800                	addi	s0,sp,16
    if(current_thread == NULL){
 b6a:	00000797          	auipc	a5,0x0
 b6e:	3d67b783          	ld	a5,982(a5) # f40 <current_thread>
 b72:	cf91                	beqz	a5,b8e <thread_add_runqueue+0x2a>
        current_thread = t;
        current_thread->next = current_thread;
        current_thread->previous = current_thread;
    } else {
        // case: adding thread to existing queue
        t->sig_handler[0] = current_thread->sig_handler[0];
 b74:	7bd8                	ld	a4,176(a5)
 b76:	f958                	sd	a4,176(a0)
        t->sig_handler[1] = current_thread->sig_handler[1];
 b78:	7fd8                	ld	a4,184(a5)
 b7a:	fd58                	sd	a4,184(a0)
        
        // Insert into circular linked list
        current_thread->previous->next = t;
 b7c:	6fd8                	ld	a4,152(a5)
 b7e:	f348                	sd	a0,160(a4)
        t->previous = current_thread->previous;
 b80:	6fd8                	ld	a4,152(a5)
 b82:	ed58                	sd	a4,152(a0)
        t->next = current_thread;
 b84:	f15c                	sd	a5,160(a0)
        current_thread->previous = t;
 b86:	efc8                	sd	a0,152(a5)
    }
}
 b88:	6422                	ld	s0,8(sp)
 b8a:	0141                	addi	sp,sp,16
 b8c:	8082                	ret
        current_thread = t;
 b8e:	00000797          	auipc	a5,0x0
 b92:	3aa7b923          	sd	a0,946(a5) # f40 <current_thread>
        current_thread->next = current_thread;
 b96:	f148                	sd	a0,160(a0)
        current_thread->previous = current_thread;
 b98:	ed48                	sd	a0,152(a0)
 b9a:	b7fd                	j	b88 <thread_add_runqueue+0x24>

0000000000000b9c <schedule>:
        }
        thread_exit();
    }
}

void schedule(void){
 b9c:	1141                	addi	sp,sp,-16
 b9e:	e422                	sd	s0,8(sp)
 ba0:	0800                	addi	s0,sp,16
    // TODO
    // printf("schedule to the next thread\n");
    current_thread = current_thread->next;
 ba2:	00000717          	auipc	a4,0x0
 ba6:	39e70713          	addi	a4,a4,926 # f40 <current_thread>
 baa:	631c                	ld	a5,0(a4)
 bac:	73dc                	ld	a5,160(a5)
 bae:	e31c                	sd	a5,0(a4)
    
    // Skip suspended threads, if the thread is suspended, we kept moving to the next thread
    while (current_thread->suspended) {
 bb0:	0a87a703          	lw	a4,168(a5)
 bb4:	cb09                	beqz	a4,bc6 <schedule+0x2a>
        current_thread = current_thread->next;
 bb6:	73dc                	ld	a5,160(a5)
    while (current_thread->suspended) {
 bb8:	0a87a703          	lw	a4,168(a5)
 bbc:	ff6d                	bnez	a4,bb6 <schedule+0x1a>
 bbe:	00000717          	auipc	a4,0x0
 bc2:	38f73123          	sd	a5,898(a4) # f40 <current_thread>
    }
}
 bc6:	6422                	ld	s0,8(sp)
 bc8:	0141                	addi	sp,sp,16
 bca:	8082                	ret

0000000000000bcc <thread_exit>:



void thread_exit(void){
 bcc:	1101                	addi	sp,sp,-32
 bce:	ec06                	sd	ra,24(sp)
 bd0:	e822                	sd	s0,16(sp)
 bd2:	e426                	sd	s1,8(sp)
 bd4:	1000                	addi	s0,sp,32
    if(current_thread->next != current_thread){         // case: has more than one thread in the runqueue
 bd6:	00000497          	auipc	s1,0x0
 bda:	36a4b483          	ld	s1,874(s1) # f40 <current_thread>
 bde:	70dc                	ld	a5,160(s1)
 be0:	02f48d63          	beq	s1,a5,c1a <thread_exit+0x4e>
        struct thread *curr = current_thread;
        // Remove from circular list, modify the previous and next pointer 
        current_thread->previous->next = current_thread->next;
 be4:	6cd8                	ld	a4,152(s1)
 be6:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
 be8:	6cd8                	ld	a4,152(s1)
 bea:	efd8                	sd	a4,152(a5)
        schedule();
 bec:	00000097          	auipc	ra,0x0
 bf0:	fb0080e7          	jalr	-80(ra) # b9c <schedule>
        free(curr->stack);
 bf4:	6888                	ld	a0,16(s1)
 bf6:	00000097          	auipc	ra,0x0
 bfa:	d16080e7          	jalr	-746(ra) # 90c <free>
        free(curr);
 bfe:	8526                	mv	a0,s1
 c00:	00000097          	auipc	ra,0x0
 c04:	d0c080e7          	jalr	-756(ra) # 90c <free>
        dispatch();
 c08:	00000097          	auipc	ra,0x0
 c0c:	040080e7          	jalr	64(ra) # c48 <dispatch>
        // free the stack and the thread itself
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st,1);    // return to main function since the context of the main function is saved in env_st
    }
}
 c10:	60e2                	ld	ra,24(sp)
 c12:	6442                	ld	s0,16(sp)
 c14:	64a2                	ld	s1,8(sp)
 c16:	6105                	addi	sp,sp,32
 c18:	8082                	ret
        free(current_thread->stack);
 c1a:	6888                	ld	a0,16(s1)
 c1c:	00000097          	auipc	ra,0x0
 c20:	cf0080e7          	jalr	-784(ra) # 90c <free>
        free(current_thread);
 c24:	00000517          	auipc	a0,0x0
 c28:	31c53503          	ld	a0,796(a0) # f40 <current_thread>
 c2c:	00000097          	auipc	ra,0x0
 c30:	ce0080e7          	jalr	-800(ra) # 90c <free>
        longjmp(env_st,1);    // return to main function since the context of the main function is saved in env_st
 c34:	4585                	li	a1,1
 c36:	00000517          	auipc	a0,0x0
 c3a:	32250513          	addi	a0,a0,802 # f58 <env_st>
 c3e:	00000097          	auipc	ra,0x0
 c42:	e72080e7          	jalr	-398(ra) # ab0 <longjmp>
}
 c46:	b7e9                	j	c10 <thread_exit+0x44>

0000000000000c48 <dispatch>:
void dispatch(void){
 c48:	1101                	addi	sp,sp,-32
 c4a:	ec06                	sd	ra,24(sp)
 c4c:	e822                	sd	s0,16(sp)
 c4e:	e426                	sd	s1,8(sp)
 c50:	1000                	addi	s0,sp,32
    if(current_thread->signo != -1){            // case: thread has pending signal
 c52:	00000517          	auipc	a0,0x0
 c56:	2ee53503          	ld	a0,750(a0) # f40 <current_thread>
 c5a:	0c052783          	lw	a5,192(a0)
 c5e:	577d                	li	a4,-1
 c60:	08e78e63          	beq	a5,a4,cfc <dispatch+0xb4>
        if(current_thread->sig_handler[current_thread->signo] != NULL_FUNC){
 c64:	07d9                	addi	a5,a5,22
 c66:	078e                	slli	a5,a5,0x3
 c68:	97aa                	add	a5,a5,a0
 c6a:	6398                	ld	a4,0(a5)
 c6c:	57fd                	li	a5,-1
 c6e:	08f70263          	beq	a4,a5,cf2 <dispatch+0xaa>
            if(current_thread->handler_buf_set == 1){
 c72:	13852703          	lw	a4,312(a0)
 c76:	4785                	li	a5,1
 c78:	04f70163          	beq	a4,a5,cba <dispatch+0x72>
                if(setjmp(current_thread->handler_env) == 1){
 c7c:	0c850513          	addi	a0,a0,200
 c80:	00000097          	auipc	ra,0x0
 c84:	df8080e7          	jalr	-520(ra) # a78 <setjmp>
 c88:	4785                	li	a5,1
 c8a:	04f51063          	bne	a0,a5,cca <dispatch+0x82>
                    current_thread->sig_handler[current_thread->signo](current_thread->signo);      // execute the corresponding signal handler
 c8e:	00000497          	auipc	s1,0x0
 c92:	2b248493          	addi	s1,s1,690 # f40 <current_thread>
 c96:	609c                	ld	a5,0(s1)
 c98:	0c07a503          	lw	a0,192(a5)
 c9c:	01650713          	addi	a4,a0,22
 ca0:	070e                	slli	a4,a4,0x3
 ca2:	97ba                	add	a5,a5,a4
 ca4:	639c                	ld	a5,0(a5)
 ca6:	9782                	jalr	a5
                    current_thread->signo = -1;     // reset the signo to -1
 ca8:	609c                	ld	a5,0(s1)
 caa:	577d                	li	a4,-1
 cac:	0ce7a023          	sw	a4,192(a5)
                    dispatch();
 cb0:	00000097          	auipc	ra,0x0
 cb4:	f98080e7          	jalr	-104(ra) # c48 <dispatch>
 cb8:	a89d                	j	d2e <dispatch+0xe6>
                longjmp(current_thread->handler_env,1);
 cba:	4585                	li	a1,1
 cbc:	0c850513          	addi	a0,a0,200
 cc0:	00000097          	auipc	ra,0x0
 cc4:	df0080e7          	jalr	-528(ra) # ab0 <longjmp>
 cc8:	a09d                	j	d2e <dispatch+0xe6>
                    current_thread->handler_env->sp = (unsigned long) current_thread->stack_p-50*8;
 cca:	00000517          	auipc	a0,0x0
 cce:	27653503          	ld	a0,630(a0) # f40 <current_thread>
 cd2:	6d1c                	ld	a5,24(a0)
 cd4:	e7078793          	addi	a5,a5,-400
 cd8:	12f53823          	sd	a5,304(a0)
                    current_thread->handler_buf_set = 1;
 cdc:	4785                	li	a5,1
 cde:	12f52c23          	sw	a5,312(a0)
                    longjmp(current_thread->handler_env,1);
 ce2:	4585                	li	a1,1
 ce4:	0c850513          	addi	a0,a0,200
 ce8:	00000097          	auipc	ra,0x0
 cec:	dc8080e7          	jalr	-568(ra) # ab0 <longjmp>
 cf0:	a83d                	j	d2e <dispatch+0xe6>
            thread_exit();
 cf2:	00000097          	auipc	ra,0x0
 cf6:	eda080e7          	jalr	-294(ra) # bcc <thread_exit>
 cfa:	a815                	j	d2e <dispatch+0xe6>
        if(current_thread->buf_set == 1){   // case: has a saved context in env
 cfc:	09052703          	lw	a4,144(a0)
 d00:	4785                	li	a5,1
 d02:	02f70b63          	beq	a4,a5,d38 <dispatch+0xf0>
            if(setjmp(current_thread->env) == 1){ 
 d06:	02050513          	addi	a0,a0,32
 d0a:	00000097          	auipc	ra,0x0
 d0e:	d6e080e7          	jalr	-658(ra) # a78 <setjmp>
 d12:	4785                	li	a5,1
 d14:	02f51a63          	bne	a0,a5,d48 <dispatch+0x100>
                current_thread->fp(current_thread->arg);
 d18:	00000797          	auipc	a5,0x0
 d1c:	2287b783          	ld	a5,552(a5) # f40 <current_thread>
 d20:	6398                	ld	a4,0(a5)
 d22:	6788                	ld	a0,8(a5)
 d24:	9702                	jalr	a4
        thread_exit();
 d26:	00000097          	auipc	ra,0x0
 d2a:	ea6080e7          	jalr	-346(ra) # bcc <thread_exit>
}
 d2e:	60e2                	ld	ra,24(sp)
 d30:	6442                	ld	s0,16(sp)
 d32:	64a2                	ld	s1,8(sp)
 d34:	6105                	addi	sp,sp,32
 d36:	8082                	ret
            longjmp(current_thread->env,1);
 d38:	4585                	li	a1,1
 d3a:	02050513          	addi	a0,a0,32
 d3e:	00000097          	auipc	ra,0x0
 d42:	d72080e7          	jalr	-654(ra) # ab0 <longjmp>
 d46:	b7c5                	j	d26 <dispatch+0xde>
                current_thread->env->sp =(unsigned long) current_thread->stack_p;   // manually set sp of the current thread to stack_p
 d48:	00000517          	auipc	a0,0x0
 d4c:	1f853503          	ld	a0,504(a0) # f40 <current_thread>
 d50:	6d1c                	ld	a5,24(a0)
 d52:	e55c                	sd	a5,136(a0)
                current_thread->buf_set = 1;                                        // set the buf_set to 1 to indicate that the buf has been set
 d54:	4785                	li	a5,1
 d56:	08f52823          	sw	a5,144(a0)
                longjmp(current_thread->env,1);
 d5a:	4585                	li	a1,1
 d5c:	02050513          	addi	a0,a0,32
 d60:	00000097          	auipc	ra,0x0
 d64:	d50080e7          	jalr	-688(ra) # ab0 <longjmp>
 d68:	bf7d                	j	d26 <dispatch+0xde>

0000000000000d6a <thread_yield>:
void thread_yield(void){
 d6a:	1141                	addi	sp,sp,-16
 d6c:	e406                	sd	ra,8(sp)
 d6e:	e022                	sd	s0,0(sp)
 d70:	0800                	addi	s0,sp,16
    if(current_thread->signo != -1){
 d72:	00000517          	auipc	a0,0x0
 d76:	1ce53503          	ld	a0,462(a0) # f40 <current_thread>
 d7a:	0c052703          	lw	a4,192(a0)
 d7e:	57fd                	li	a5,-1
 d80:	02f70663          	beq	a4,a5,dac <thread_yield+0x42>
        if(setjmp(current_thread->handler_env) == NULL){
 d84:	0c850513          	addi	a0,a0,200
 d88:	00000097          	auipc	ra,0x0
 d8c:	cf0080e7          	jalr	-784(ra) # a78 <setjmp>
 d90:	c509                	beqz	a0,d9a <thread_yield+0x30>
}
 d92:	60a2                	ld	ra,8(sp)
 d94:	6402                	ld	s0,0(sp)
 d96:	0141                	addi	sp,sp,16
 d98:	8082                	ret
            schedule();
 d9a:	00000097          	auipc	ra,0x0
 d9e:	e02080e7          	jalr	-510(ra) # b9c <schedule>
            dispatch();
 da2:	00000097          	auipc	ra,0x0
 da6:	ea6080e7          	jalr	-346(ra) # c48 <dispatch>
 daa:	b7e5                	j	d92 <thread_yield+0x28>
        if(setjmp(current_thread->env) == NULL){
 dac:	02050513          	addi	a0,a0,32
 db0:	00000097          	auipc	ra,0x0
 db4:	cc8080e7          	jalr	-824(ra) # a78 <setjmp>
 db8:	fd69                	bnez	a0,d92 <thread_yield+0x28>
            schedule();
 dba:	00000097          	auipc	ra,0x0
 dbe:	de2080e7          	jalr	-542(ra) # b9c <schedule>
            dispatch();
 dc2:	00000097          	auipc	ra,0x0
 dc6:	e86080e7          	jalr	-378(ra) # c48 <dispatch>
}
 dca:	b7e1                	j	d92 <thread_yield+0x28>

0000000000000dcc <thread_start_threading>:
thread_exit() is called by the last thread, and the else condition is satisfied, 
when longjmp(env_st, 1); is executed, we jump back to if (setjmp(env_st) == 0) in thread_start_threading(), 
but now the condition is not satisfied
*/

void thread_start_threading(void){
 dcc:	1141                	addi	sp,sp,-16
 dce:	e406                	sd	ra,8(sp)
 dd0:	e022                	sd	s0,0(sp)
 dd2:	0800                	addi	s0,sp,16
    if(setjmp(env_st) == 0){
 dd4:	00000517          	auipc	a0,0x0
 dd8:	18450513          	addi	a0,a0,388 # f58 <env_st>
 ddc:	00000097          	auipc	ra,0x0
 de0:	c9c080e7          	jalr	-868(ra) # a78 <setjmp>
 de4:	c509                	beqz	a0,dee <thread_start_threading+0x22>
        schedule();
        dispatch();
    }
    else return;
}
 de6:	60a2                	ld	ra,8(sp)
 de8:	6402                	ld	s0,0(sp)
 dea:	0141                	addi	sp,sp,16
 dec:	8082                	ret
        schedule();
 dee:	00000097          	auipc	ra,0x0
 df2:	dae080e7          	jalr	-594(ra) # b9c <schedule>
        dispatch();
 df6:	00000097          	auipc	ra,0x0
 dfa:	e52080e7          	jalr	-430(ra) # c48 <dispatch>
 dfe:	b7e5                	j	de6 <thread_start_threading+0x1a>

0000000000000e00 <thread_register_handler>:
/*
When a signal is raised by current_thread, we look up in the sig_handler array by the index "signo", 
then executes the sig_handler function.
If another signal handler has already been registered by the same signal, just replace it
*/
void thread_register_handler(int signo, void (*handler)(int)){
 e00:	1141                	addi	sp,sp,-16
 e02:	e406                	sd	ra,8(sp)
 e04:	e022                	sd	s0,0(sp)
 e06:	0800                	addi	s0,sp,16
    // Register signal handler for current thread
    current_thread->sig_handler[signo] = handler;
 e08:	0559                	addi	a0,a0,22
 e0a:	050e                	slli	a0,a0,0x3
 e0c:	00000797          	auipc	a5,0x0
 e10:	1347b783          	ld	a5,308(a5) # f40 <current_thread>
 e14:	953e                	add	a0,a0,a5
 e16:	e10c                	sd	a1,0(a0)
    sleep(3);
 e18:	450d                	li	a0,3
 e1a:	fffff097          	auipc	ra,0xfffff
 e1e:	7d4080e7          	jalr	2004(ra) # 5ee <sleep>
}
 e22:	60a2                	ld	ra,8(sp)
 e24:	6402                	ld	s0,0(sp)
 e26:	0141                	addi	sp,sp,16
 e28:	8082                	ret

0000000000000e2a <thread_kill>:
> xv6.pdf p.77
While a process can call thread_exit() to terminate itself, 
sometimes one process wants to kill another process (ex: parent kills child),
thread_kill() does not immediately terminates the victim process, but instead sets a flag (p->killed), marking it to be killed later
*/
void thread_kill(struct thread *t, int signo){
 e2a:	1141                	addi	sp,sp,-16
 e2c:	e422                	sd	s0,8(sp)
 e2e:	0800                	addi	s0,sp,16
    // Set signal for specified thread
    t->signo = signo;
 e30:	0cb52023          	sw	a1,192(a0)
}
 e34:	6422                	ld	s0,8(sp)
 e36:	0141                	addi	sp,sp,16
 e38:	8082                	ret

0000000000000e3a <thread_suspend>:

current_thread is set to the next of the original current_thread (Thread B), 
if Thread B is also suspended, the while loop would then move on checking Thread C
*/

void thread_suspend(struct thread *t) {
 e3a:	1141                	addi	sp,sp,-16
 e3c:	e422                	sd	s0,8(sp)
 e3e:	0800                	addi	s0,sp,16
    // Mark thread as suspended
   t->suspended = 1;
 e40:	4785                	li	a5,1
 e42:	0af52423          	sw	a5,168(a0)
}
 e46:	6422                	ld	s0,8(sp)
 e48:	0141                	addi	sp,sp,16
 e4a:	8082                	ret

0000000000000e4c <thread_resume>:


void thread_resume(struct thread *t) {
 e4c:	1141                	addi	sp,sp,-16
 e4e:	e422                	sd	s0,8(sp)
 e50:	0800                	addi	s0,sp,16
    t->suspended = 0;
 e52:	0a052423          	sw	zero,168(a0)
}
 e56:	6422                	ld	s0,8(sp)
 e58:	0141                	addi	sp,sp,16
 e5a:	8082                	ret

0000000000000e5c <get_current_thread>:

struct thread* get_current_thread() {
 e5c:	1141                	addi	sp,sp,-16
 e5e:	e422                	sd	s0,8(sp)
 e60:	0800                	addi	s0,sp,16
    // Return pointer to the current thread
    return current_thread;
 e62:	00000517          	auipc	a0,0x0
 e66:	0de53503          	ld	a0,222(a0) # f40 <current_thread>
 e6a:	6422                	ld	s0,8(sp)
 e6c:	0141                	addi	sp,sp,16
 e6e:	8082                	ret
