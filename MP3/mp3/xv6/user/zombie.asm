
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  if(fork() > 0)
       8:	00000097          	auipc	ra,0x0
       c:	4aa080e7          	jalr	1194(ra) # 4b2 <fork>
      10:	87aa                	mv	a5,a0
      12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
      16:	4515                	li	a0,5
      18:	00000097          	auipc	ra,0x0
      1c:	532080e7          	jalr	1330(ra) # 54a <sleep>
  exit(0);
      20:	4501                	li	a0,0
      22:	00000097          	auipc	ra,0x0
      26:	498080e7          	jalr	1176(ra) # 4ba <exit>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      2a:	7179                	addi	sp,sp,-48
      2c:	f422                	sd	s0,40(sp)
      2e:	1800                	addi	s0,sp,48
      30:	fca43c23          	sd	a0,-40(s0)
      34:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      38:	fd843783          	ld	a5,-40(s0)
      3c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      40:	0001                	nop
      42:	fd043703          	ld	a4,-48(s0)
      46:	00170793          	addi	a5,a4,1
      4a:	fcf43823          	sd	a5,-48(s0)
      4e:	fd843783          	ld	a5,-40(s0)
      52:	00178693          	addi	a3,a5,1
      56:	fcd43c23          	sd	a3,-40(s0)
      5a:	00074703          	lbu	a4,0(a4)
      5e:	00e78023          	sb	a4,0(a5)
      62:	0007c783          	lbu	a5,0(a5)
      66:	fff1                	bnez	a5,42 <strcpy+0x18>
    ;
  return os;
      68:	fe843783          	ld	a5,-24(s0)
}
      6c:	853e                	mv	a0,a5
      6e:	7422                	ld	s0,40(sp)
      70:	6145                	addi	sp,sp,48
      72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      82:	a819                	j	98 <strcmp+0x24>
    p++, q++;
      84:	fe843783          	ld	a5,-24(s0)
      88:	0785                	addi	a5,a5,1
      8a:	fef43423          	sd	a5,-24(s0)
      8e:	fe043783          	ld	a5,-32(s0)
      92:	0785                	addi	a5,a5,1
      94:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      98:	fe843783          	ld	a5,-24(s0)
      9c:	0007c783          	lbu	a5,0(a5)
      a0:	cb99                	beqz	a5,b6 <strcmp+0x42>
      a2:	fe843783          	ld	a5,-24(s0)
      a6:	0007c703          	lbu	a4,0(a5)
      aa:	fe043783          	ld	a5,-32(s0)
      ae:	0007c783          	lbu	a5,0(a5)
      b2:	fcf709e3          	beq	a4,a5,84 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
      b6:	fe843783          	ld	a5,-24(s0)
      ba:	0007c783          	lbu	a5,0(a5)
      be:	0007871b          	sext.w	a4,a5
      c2:	fe043783          	ld	a5,-32(s0)
      c6:	0007c783          	lbu	a5,0(a5)
      ca:	2781                	sext.w	a5,a5
      cc:	40f707bb          	subw	a5,a4,a5
      d0:	2781                	sext.w	a5,a5
}
      d2:	853e                	mv	a0,a5
      d4:	6462                	ld	s0,24(sp)
      d6:	6105                	addi	sp,sp,32
      d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
      da:	7179                	addi	sp,sp,-48
      dc:	f422                	sd	s0,40(sp)
      de:	1800                	addi	s0,sp,48
      e0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
      e4:	fe042623          	sw	zero,-20(s0)
      e8:	a031                	j	f4 <strlen+0x1a>
      ea:	fec42783          	lw	a5,-20(s0)
      ee:	2785                	addiw	a5,a5,1
      f0:	fef42623          	sw	a5,-20(s0)
      f4:	fec42783          	lw	a5,-20(s0)
      f8:	fd843703          	ld	a4,-40(s0)
      fc:	97ba                	add	a5,a5,a4
      fe:	0007c783          	lbu	a5,0(a5)
     102:	f7e5                	bnez	a5,ea <strlen+0x10>
    ;
  return n;
     104:	fec42783          	lw	a5,-20(s0)
}
     108:	853e                	mv	a0,a5
     10a:	7422                	ld	s0,40(sp)
     10c:	6145                	addi	sp,sp,48
     10e:	8082                	ret

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
     110:	7179                	addi	sp,sp,-48
     112:	f422                	sd	s0,40(sp)
     114:	1800                	addi	s0,sp,48
     116:	fca43c23          	sd	a0,-40(s0)
     11a:	87ae                	mv	a5,a1
     11c:	8732                	mv	a4,a2
     11e:	fcf42a23          	sw	a5,-44(s0)
     122:	87ba                	mv	a5,a4
     124:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     128:	fd843783          	ld	a5,-40(s0)
     12c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     130:	fe042623          	sw	zero,-20(s0)
     134:	a00d                	j	156 <memset+0x46>
    cdst[i] = c;
     136:	fec42783          	lw	a5,-20(s0)
     13a:	fe043703          	ld	a4,-32(s0)
     13e:	97ba                	add	a5,a5,a4
     140:	fd442703          	lw	a4,-44(s0)
     144:	0ff77713          	andi	a4,a4,255
     148:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     14c:	fec42783          	lw	a5,-20(s0)
     150:	2785                	addiw	a5,a5,1
     152:	fef42623          	sw	a5,-20(s0)
     156:	fec42703          	lw	a4,-20(s0)
     15a:	fd042783          	lw	a5,-48(s0)
     15e:	2781                	sext.w	a5,a5
     160:	fcf76be3          	bltu	a4,a5,136 <memset+0x26>
  }
  return dst;
     164:	fd843783          	ld	a5,-40(s0)
}
     168:	853e                	mv	a0,a5
     16a:	7422                	ld	s0,40(sp)
     16c:	6145                	addi	sp,sp,48
     16e:	8082                	ret

0000000000000170 <strchr>:

char*
strchr(const char *s, char c)
{
     170:	1101                	addi	sp,sp,-32
     172:	ec22                	sd	s0,24(sp)
     174:	1000                	addi	s0,sp,32
     176:	fea43423          	sd	a0,-24(s0)
     17a:	87ae                	mv	a5,a1
     17c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     180:	a01d                	j	1a6 <strchr+0x36>
    if(*s == c)
     182:	fe843783          	ld	a5,-24(s0)
     186:	0007c703          	lbu	a4,0(a5)
     18a:	fe744783          	lbu	a5,-25(s0)
     18e:	0ff7f793          	andi	a5,a5,255
     192:	00e79563          	bne	a5,a4,19c <strchr+0x2c>
      return (char*)s;
     196:	fe843783          	ld	a5,-24(s0)
     19a:	a821                	j	1b2 <strchr+0x42>
  for(; *s; s++)
     19c:	fe843783          	ld	a5,-24(s0)
     1a0:	0785                	addi	a5,a5,1
     1a2:	fef43423          	sd	a5,-24(s0)
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0007c783          	lbu	a5,0(a5)
     1ae:	fbf1                	bnez	a5,182 <strchr+0x12>
  return 0;
     1b0:	4781                	li	a5,0
}
     1b2:	853e                	mv	a0,a5
     1b4:	6462                	ld	s0,24(sp)
     1b6:	6105                	addi	sp,sp,32
     1b8:	8082                	ret

00000000000001ba <gets>:

char*
gets(char *buf, int max)
{
     1ba:	7179                	addi	sp,sp,-48
     1bc:	f406                	sd	ra,40(sp)
     1be:	f022                	sd	s0,32(sp)
     1c0:	1800                	addi	s0,sp,48
     1c2:	fca43c23          	sd	a0,-40(s0)
     1c6:	87ae                	mv	a5,a1
     1c8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cc:	fe042623          	sw	zero,-20(s0)
     1d0:	a8a1                	j	228 <gets+0x6e>
    cc = read(0, &c, 1);
     1d2:	fe740793          	addi	a5,s0,-25
     1d6:	4605                	li	a2,1
     1d8:	85be                	mv	a1,a5
     1da:	4501                	li	a0,0
     1dc:	00000097          	auipc	ra,0x0
     1e0:	2f6080e7          	jalr	758(ra) # 4d2 <read>
     1e4:	87aa                	mv	a5,a0
     1e6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     1ea:	fe842783          	lw	a5,-24(s0)
     1ee:	2781                	sext.w	a5,a5
     1f0:	04f05763          	blez	a5,23e <gets+0x84>
      break;
    buf[i++] = c;
     1f4:	fec42783          	lw	a5,-20(s0)
     1f8:	0017871b          	addiw	a4,a5,1
     1fc:	fee42623          	sw	a4,-20(s0)
     200:	873e                	mv	a4,a5
     202:	fd843783          	ld	a5,-40(s0)
     206:	97ba                	add	a5,a5,a4
     208:	fe744703          	lbu	a4,-25(s0)
     20c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     210:	fe744783          	lbu	a5,-25(s0)
     214:	873e                	mv	a4,a5
     216:	47a9                	li	a5,10
     218:	02f70463          	beq	a4,a5,240 <gets+0x86>
     21c:	fe744783          	lbu	a5,-25(s0)
     220:	873e                	mv	a4,a5
     222:	47b5                	li	a5,13
     224:	00f70e63          	beq	a4,a5,240 <gets+0x86>
  for(i=0; i+1 < max; ){
     228:	fec42783          	lw	a5,-20(s0)
     22c:	2785                	addiw	a5,a5,1
     22e:	0007871b          	sext.w	a4,a5
     232:	fd442783          	lw	a5,-44(s0)
     236:	2781                	sext.w	a5,a5
     238:	f8f74de3          	blt	a4,a5,1d2 <gets+0x18>
     23c:	a011                	j	240 <gets+0x86>
      break;
     23e:	0001                	nop
      break;
  }
  buf[i] = '\0';
     240:	fec42783          	lw	a5,-20(s0)
     244:	fd843703          	ld	a4,-40(s0)
     248:	97ba                	add	a5,a5,a4
     24a:	00078023          	sb	zero,0(a5)
  return buf;
     24e:	fd843783          	ld	a5,-40(s0)
}
     252:	853e                	mv	a0,a5
     254:	70a2                	ld	ra,40(sp)
     256:	7402                	ld	s0,32(sp)
     258:	6145                	addi	sp,sp,48
     25a:	8082                	ret

000000000000025c <stat>:

int
stat(const char *n, struct stat *st)
{
     25c:	7179                	addi	sp,sp,-48
     25e:	f406                	sd	ra,40(sp)
     260:	f022                	sd	s0,32(sp)
     262:	1800                	addi	s0,sp,48
     264:	fca43c23          	sd	a0,-40(s0)
     268:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     26c:	4581                	li	a1,0
     26e:	fd843503          	ld	a0,-40(s0)
     272:	00000097          	auipc	ra,0x0
     276:	288080e7          	jalr	648(ra) # 4fa <open>
     27a:	87aa                	mv	a5,a0
     27c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     280:	fec42783          	lw	a5,-20(s0)
     284:	2781                	sext.w	a5,a5
     286:	0007d463          	bgez	a5,28e <stat+0x32>
    return -1;
     28a:	57fd                	li	a5,-1
     28c:	a035                	j	2b8 <stat+0x5c>
  r = fstat(fd, st);
     28e:	fec42783          	lw	a5,-20(s0)
     292:	fd043583          	ld	a1,-48(s0)
     296:	853e                	mv	a0,a5
     298:	00000097          	auipc	ra,0x0
     29c:	27a080e7          	jalr	634(ra) # 512 <fstat>
     2a0:	87aa                	mv	a5,a0
     2a2:	fef42423          	sw	a5,-24(s0)
  close(fd);
     2a6:	fec42783          	lw	a5,-20(s0)
     2aa:	853e                	mv	a0,a5
     2ac:	00000097          	auipc	ra,0x0
     2b0:	236080e7          	jalr	566(ra) # 4e2 <close>
  return r;
     2b4:	fe842783          	lw	a5,-24(s0)
}
     2b8:	853e                	mv	a0,a5
     2ba:	70a2                	ld	ra,40(sp)
     2bc:	7402                	ld	s0,32(sp)
     2be:	6145                	addi	sp,sp,48
     2c0:	8082                	ret

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
     2c2:	7179                	addi	sp,sp,-48
     2c4:	f422                	sd	s0,40(sp)
     2c6:	1800                	addi	s0,sp,48
     2c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     2cc:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     2d0:	a815                	j	304 <atoi+0x42>
    n = n*10 + *s++ - '0';
     2d2:	fec42703          	lw	a4,-20(s0)
     2d6:	87ba                	mv	a5,a4
     2d8:	0027979b          	slliw	a5,a5,0x2
     2dc:	9fb9                	addw	a5,a5,a4
     2de:	0017979b          	slliw	a5,a5,0x1
     2e2:	0007871b          	sext.w	a4,a5
     2e6:	fd843783          	ld	a5,-40(s0)
     2ea:	00178693          	addi	a3,a5,1
     2ee:	fcd43c23          	sd	a3,-40(s0)
     2f2:	0007c783          	lbu	a5,0(a5)
     2f6:	2781                	sext.w	a5,a5
     2f8:	9fb9                	addw	a5,a5,a4
     2fa:	2781                	sext.w	a5,a5
     2fc:	fd07879b          	addiw	a5,a5,-48
     300:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     304:	fd843783          	ld	a5,-40(s0)
     308:	0007c783          	lbu	a5,0(a5)
     30c:	873e                	mv	a4,a5
     30e:	02f00793          	li	a5,47
     312:	00e7fb63          	bgeu	a5,a4,328 <atoi+0x66>
     316:	fd843783          	ld	a5,-40(s0)
     31a:	0007c783          	lbu	a5,0(a5)
     31e:	873e                	mv	a4,a5
     320:	03900793          	li	a5,57
     324:	fae7f7e3          	bgeu	a5,a4,2d2 <atoi+0x10>
  return n;
     328:	fec42783          	lw	a5,-20(s0)
}
     32c:	853e                	mv	a0,a5
     32e:	7422                	ld	s0,40(sp)
     330:	6145                	addi	sp,sp,48
     332:	8082                	ret

0000000000000334 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     334:	7139                	addi	sp,sp,-64
     336:	fc22                	sd	s0,56(sp)
     338:	0080                	addi	s0,sp,64
     33a:	fca43c23          	sd	a0,-40(s0)
     33e:	fcb43823          	sd	a1,-48(s0)
     342:	87b2                	mv	a5,a2
     344:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     348:	fd843783          	ld	a5,-40(s0)
     34c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     350:	fd043783          	ld	a5,-48(s0)
     354:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     358:	fe043703          	ld	a4,-32(s0)
     35c:	fe843783          	ld	a5,-24(s0)
     360:	02e7fc63          	bgeu	a5,a4,398 <memmove+0x64>
    while(n-- > 0)
     364:	a00d                	j	386 <memmove+0x52>
      *dst++ = *src++;
     366:	fe043703          	ld	a4,-32(s0)
     36a:	00170793          	addi	a5,a4,1
     36e:	fef43023          	sd	a5,-32(s0)
     372:	fe843783          	ld	a5,-24(s0)
     376:	00178693          	addi	a3,a5,1
     37a:	fed43423          	sd	a3,-24(s0)
     37e:	00074703          	lbu	a4,0(a4)
     382:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     386:	fcc42783          	lw	a5,-52(s0)
     38a:	fff7871b          	addiw	a4,a5,-1
     38e:	fce42623          	sw	a4,-52(s0)
     392:	fcf04ae3          	bgtz	a5,366 <memmove+0x32>
     396:	a891                	j	3ea <memmove+0xb6>
  } else {
    dst += n;
     398:	fcc42783          	lw	a5,-52(s0)
     39c:	fe843703          	ld	a4,-24(s0)
     3a0:	97ba                	add	a5,a5,a4
     3a2:	fef43423          	sd	a5,-24(s0)
    src += n;
     3a6:	fcc42783          	lw	a5,-52(s0)
     3aa:	fe043703          	ld	a4,-32(s0)
     3ae:	97ba                	add	a5,a5,a4
     3b0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     3b4:	a01d                	j	3da <memmove+0xa6>
      *--dst = *--src;
     3b6:	fe043783          	ld	a5,-32(s0)
     3ba:	17fd                	addi	a5,a5,-1
     3bc:	fef43023          	sd	a5,-32(s0)
     3c0:	fe843783          	ld	a5,-24(s0)
     3c4:	17fd                	addi	a5,a5,-1
     3c6:	fef43423          	sd	a5,-24(s0)
     3ca:	fe043783          	ld	a5,-32(s0)
     3ce:	0007c703          	lbu	a4,0(a5)
     3d2:	fe843783          	ld	a5,-24(s0)
     3d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3da:	fcc42783          	lw	a5,-52(s0)
     3de:	fff7871b          	addiw	a4,a5,-1
     3e2:	fce42623          	sw	a4,-52(s0)
     3e6:	fcf048e3          	bgtz	a5,3b6 <memmove+0x82>
  }
  return vdst;
     3ea:	fd843783          	ld	a5,-40(s0)
}
     3ee:	853e                	mv	a0,a5
     3f0:	7462                	ld	s0,56(sp)
     3f2:	6121                	addi	sp,sp,64
     3f4:	8082                	ret

00000000000003f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     3f6:	7139                	addi	sp,sp,-64
     3f8:	fc22                	sd	s0,56(sp)
     3fa:	0080                	addi	s0,sp,64
     3fc:	fca43c23          	sd	a0,-40(s0)
     400:	fcb43823          	sd	a1,-48(s0)
     404:	87b2                	mv	a5,a2
     406:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	fef43423          	sd	a5,-24(s0)
     412:	fd043783          	ld	a5,-48(s0)
     416:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     41a:	a0a1                	j	462 <memcmp+0x6c>
    if (*p1 != *p2) {
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0007c703          	lbu	a4,0(a5)
     424:	fe043783          	ld	a5,-32(s0)
     428:	0007c783          	lbu	a5,0(a5)
     42c:	02f70163          	beq	a4,a5,44e <memcmp+0x58>
      return *p1 - *p2;
     430:	fe843783          	ld	a5,-24(s0)
     434:	0007c783          	lbu	a5,0(a5)
     438:	0007871b          	sext.w	a4,a5
     43c:	fe043783          	ld	a5,-32(s0)
     440:	0007c783          	lbu	a5,0(a5)
     444:	2781                	sext.w	a5,a5
     446:	40f707bb          	subw	a5,a4,a5
     44a:	2781                	sext.w	a5,a5
     44c:	a01d                	j	472 <memcmp+0x7c>
    }
    p1++;
     44e:	fe843783          	ld	a5,-24(s0)
     452:	0785                	addi	a5,a5,1
     454:	fef43423          	sd	a5,-24(s0)
    p2++;
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     462:	fcc42783          	lw	a5,-52(s0)
     466:	fff7871b          	addiw	a4,a5,-1
     46a:	fce42623          	sw	a4,-52(s0)
     46e:	f7dd                	bnez	a5,41c <memcmp+0x26>
  }
  return 0;
     470:	4781                	li	a5,0
}
     472:	853e                	mv	a0,a5
     474:	7462                	ld	s0,56(sp)
     476:	6121                	addi	sp,sp,64
     478:	8082                	ret

000000000000047a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     47a:	7179                	addi	sp,sp,-48
     47c:	f406                	sd	ra,40(sp)
     47e:	f022                	sd	s0,32(sp)
     480:	1800                	addi	s0,sp,48
     482:	fea43423          	sd	a0,-24(s0)
     486:	feb43023          	sd	a1,-32(s0)
     48a:	87b2                	mv	a5,a2
     48c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     490:	fdc42783          	lw	a5,-36(s0)
     494:	863e                	mv	a2,a5
     496:	fe043583          	ld	a1,-32(s0)
     49a:	fe843503          	ld	a0,-24(s0)
     49e:	00000097          	auipc	ra,0x0
     4a2:	e96080e7          	jalr	-362(ra) # 334 <memmove>
     4a6:	87aa                	mv	a5,a0
}
     4a8:	853e                	mv	a0,a5
     4aa:	70a2                	ld	ra,40(sp)
     4ac:	7402                	ld	s0,32(sp)
     4ae:	6145                	addi	sp,sp,48
     4b0:	8082                	ret

00000000000004b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     4b2:	4885                	li	a7,1
 ecall
     4b4:	00000073          	ecall
 ret
     4b8:	8082                	ret

00000000000004ba <exit>:
.global exit
exit:
 li a7, SYS_exit
     4ba:	4889                	li	a7,2
 ecall
     4bc:	00000073          	ecall
 ret
     4c0:	8082                	ret

00000000000004c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
     4c2:	488d                	li	a7,3
 ecall
     4c4:	00000073          	ecall
 ret
     4c8:	8082                	ret

00000000000004ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     4ca:	4891                	li	a7,4
 ecall
     4cc:	00000073          	ecall
 ret
     4d0:	8082                	ret

00000000000004d2 <read>:
.global read
read:
 li a7, SYS_read
     4d2:	4895                	li	a7,5
 ecall
     4d4:	00000073          	ecall
 ret
     4d8:	8082                	ret

00000000000004da <write>:
.global write
write:
 li a7, SYS_write
     4da:	48c1                	li	a7,16
 ecall
     4dc:	00000073          	ecall
 ret
     4e0:	8082                	ret

00000000000004e2 <close>:
.global close
close:
 li a7, SYS_close
     4e2:	48d5                	li	a7,21
 ecall
     4e4:	00000073          	ecall
 ret
     4e8:	8082                	ret

00000000000004ea <kill>:
.global kill
kill:
 li a7, SYS_kill
     4ea:	4899                	li	a7,6
 ecall
     4ec:	00000073          	ecall
 ret
     4f0:	8082                	ret

00000000000004f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     4f2:	489d                	li	a7,7
 ecall
     4f4:	00000073          	ecall
 ret
     4f8:	8082                	ret

00000000000004fa <open>:
.global open
open:
 li a7, SYS_open
     4fa:	48bd                	li	a7,15
 ecall
     4fc:	00000073          	ecall
 ret
     500:	8082                	ret

0000000000000502 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     502:	48c5                	li	a7,17
 ecall
     504:	00000073          	ecall
 ret
     508:	8082                	ret

000000000000050a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     50a:	48c9                	li	a7,18
 ecall
     50c:	00000073          	ecall
 ret
     510:	8082                	ret

0000000000000512 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     512:	48a1                	li	a7,8
 ecall
     514:	00000073          	ecall
 ret
     518:	8082                	ret

000000000000051a <link>:
.global link
link:
 li a7, SYS_link
     51a:	48cd                	li	a7,19
 ecall
     51c:	00000073          	ecall
 ret
     520:	8082                	ret

0000000000000522 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     522:	48d1                	li	a7,20
 ecall
     524:	00000073          	ecall
 ret
     528:	8082                	ret

000000000000052a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     52a:	48a5                	li	a7,9
 ecall
     52c:	00000073          	ecall
 ret
     530:	8082                	ret

0000000000000532 <dup>:
.global dup
dup:
 li a7, SYS_dup
     532:	48a9                	li	a7,10
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     53a:	48ad                	li	a7,11
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     542:	48b1                	li	a7,12
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     54a:	48b5                	li	a7,13
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     552:	48b9                	li	a7,14
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     55a:	48d9                	li	a7,22
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     562:	48dd                	li	a7,23
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     56a:	48e1                	li	a7,24
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     572:	1101                	addi	sp,sp,-32
     574:	ec06                	sd	ra,24(sp)
     576:	e822                	sd	s0,16(sp)
     578:	1000                	addi	s0,sp,32
     57a:	87aa                	mv	a5,a0
     57c:	872e                	mv	a4,a1
     57e:	fef42623          	sw	a5,-20(s0)
     582:	87ba                	mv	a5,a4
     584:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     588:	feb40713          	addi	a4,s0,-21
     58c:	fec42783          	lw	a5,-20(s0)
     590:	4605                	li	a2,1
     592:	85ba                	mv	a1,a4
     594:	853e                	mv	a0,a5
     596:	00000097          	auipc	ra,0x0
     59a:	f44080e7          	jalr	-188(ra) # 4da <write>
}
     59e:	0001                	nop
     5a0:	60e2                	ld	ra,24(sp)
     5a2:	6442                	ld	s0,16(sp)
     5a4:	6105                	addi	sp,sp,32
     5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5a8:	7139                	addi	sp,sp,-64
     5aa:	fc06                	sd	ra,56(sp)
     5ac:	f822                	sd	s0,48(sp)
     5ae:	0080                	addi	s0,sp,64
     5b0:	87aa                	mv	a5,a0
     5b2:	8736                	mv	a4,a3
     5b4:	fcf42623          	sw	a5,-52(s0)
     5b8:	87ae                	mv	a5,a1
     5ba:	fcf42423          	sw	a5,-56(s0)
     5be:	87b2                	mv	a5,a2
     5c0:	fcf42223          	sw	a5,-60(s0)
     5c4:	87ba                	mv	a5,a4
     5c6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5ca:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     5ce:	fc042783          	lw	a5,-64(s0)
     5d2:	2781                	sext.w	a5,a5
     5d4:	c38d                	beqz	a5,5f6 <printint+0x4e>
     5d6:	fc842783          	lw	a5,-56(s0)
     5da:	2781                	sext.w	a5,a5
     5dc:	0007dd63          	bgez	a5,5f6 <printint+0x4e>
    neg = 1;
     5e0:	4785                	li	a5,1
     5e2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     5e6:	fc842783          	lw	a5,-56(s0)
     5ea:	40f007bb          	negw	a5,a5
     5ee:	2781                	sext.w	a5,a5
     5f0:	fef42223          	sw	a5,-28(s0)
     5f4:	a029                	j	5fe <printint+0x56>
  } else {
    x = xx;
     5f6:	fc842783          	lw	a5,-56(s0)
     5fa:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     5fe:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     602:	fc442783          	lw	a5,-60(s0)
     606:	fe442703          	lw	a4,-28(s0)
     60a:	02f777bb          	remuw	a5,a4,a5
     60e:	0007861b          	sext.w	a2,a5
     612:	fec42783          	lw	a5,-20(s0)
     616:	0017871b          	addiw	a4,a5,1
     61a:	fee42623          	sw	a4,-20(s0)
     61e:	00001697          	auipc	a3,0x1
     622:	cca68693          	addi	a3,a3,-822 # 12e8 <digits>
     626:	02061713          	slli	a4,a2,0x20
     62a:	9301                	srli	a4,a4,0x20
     62c:	9736                	add	a4,a4,a3
     62e:	00074703          	lbu	a4,0(a4)
     632:	ff040693          	addi	a3,s0,-16
     636:	97b6                	add	a5,a5,a3
     638:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     63c:	fc442783          	lw	a5,-60(s0)
     640:	fe442703          	lw	a4,-28(s0)
     644:	02f757bb          	divuw	a5,a4,a5
     648:	fef42223          	sw	a5,-28(s0)
     64c:	fe442783          	lw	a5,-28(s0)
     650:	2781                	sext.w	a5,a5
     652:	fbc5                	bnez	a5,602 <printint+0x5a>
  if(neg)
     654:	fe842783          	lw	a5,-24(s0)
     658:	2781                	sext.w	a5,a5
     65a:	cf95                	beqz	a5,696 <printint+0xee>
    buf[i++] = '-';
     65c:	fec42783          	lw	a5,-20(s0)
     660:	0017871b          	addiw	a4,a5,1
     664:	fee42623          	sw	a4,-20(s0)
     668:	ff040713          	addi	a4,s0,-16
     66c:	97ba                	add	a5,a5,a4
     66e:	02d00713          	li	a4,45
     672:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     676:	a005                	j	696 <printint+0xee>
    putc(fd, buf[i]);
     678:	fec42783          	lw	a5,-20(s0)
     67c:	ff040713          	addi	a4,s0,-16
     680:	97ba                	add	a5,a5,a4
     682:	fe07c703          	lbu	a4,-32(a5)
     686:	fcc42783          	lw	a5,-52(s0)
     68a:	85ba                	mv	a1,a4
     68c:	853e                	mv	a0,a5
     68e:	00000097          	auipc	ra,0x0
     692:	ee4080e7          	jalr	-284(ra) # 572 <putc>
  while(--i >= 0)
     696:	fec42783          	lw	a5,-20(s0)
     69a:	37fd                	addiw	a5,a5,-1
     69c:	fef42623          	sw	a5,-20(s0)
     6a0:	fec42783          	lw	a5,-20(s0)
     6a4:	2781                	sext.w	a5,a5
     6a6:	fc07d9e3          	bgez	a5,678 <printint+0xd0>
}
     6aa:	0001                	nop
     6ac:	0001                	nop
     6ae:	70e2                	ld	ra,56(sp)
     6b0:	7442                	ld	s0,48(sp)
     6b2:	6121                	addi	sp,sp,64
     6b4:	8082                	ret

00000000000006b6 <printptr>:

static void
printptr(int fd, uint64 x) {
     6b6:	7179                	addi	sp,sp,-48
     6b8:	f406                	sd	ra,40(sp)
     6ba:	f022                	sd	s0,32(sp)
     6bc:	1800                	addi	s0,sp,48
     6be:	87aa                	mv	a5,a0
     6c0:	fcb43823          	sd	a1,-48(s0)
     6c4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     6c8:	fdc42783          	lw	a5,-36(s0)
     6cc:	03000593          	li	a1,48
     6d0:	853e                	mv	a0,a5
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ea0080e7          	jalr	-352(ra) # 572 <putc>
  putc(fd, 'x');
     6da:	fdc42783          	lw	a5,-36(s0)
     6de:	07800593          	li	a1,120
     6e2:	853e                	mv	a0,a5
     6e4:	00000097          	auipc	ra,0x0
     6e8:	e8e080e7          	jalr	-370(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     6ec:	fe042623          	sw	zero,-20(s0)
     6f0:	a82d                	j	72a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     6f2:	fd043783          	ld	a5,-48(s0)
     6f6:	93f1                	srli	a5,a5,0x3c
     6f8:	00001717          	auipc	a4,0x1
     6fc:	bf070713          	addi	a4,a4,-1040 # 12e8 <digits>
     700:	97ba                	add	a5,a5,a4
     702:	0007c703          	lbu	a4,0(a5)
     706:	fdc42783          	lw	a5,-36(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	e64080e7          	jalr	-412(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	2785                	addiw	a5,a5,1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fd043783          	ld	a5,-48(s0)
     724:	0792                	slli	a5,a5,0x4
     726:	fcf43823          	sd	a5,-48(s0)
     72a:	fec42783          	lw	a5,-20(s0)
     72e:	873e                	mv	a4,a5
     730:	47bd                	li	a5,15
     732:	fce7f0e3          	bgeu	a5,a4,6f2 <printptr+0x3c>
}
     736:	0001                	nop
     738:	0001                	nop
     73a:	70a2                	ld	ra,40(sp)
     73c:	7402                	ld	s0,32(sp)
     73e:	6145                	addi	sp,sp,48
     740:	8082                	ret

0000000000000742 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     742:	715d                	addi	sp,sp,-80
     744:	e486                	sd	ra,72(sp)
     746:	e0a2                	sd	s0,64(sp)
     748:	0880                	addi	s0,sp,80
     74a:	87aa                	mv	a5,a0
     74c:	fcb43023          	sd	a1,-64(s0)
     750:	fac43c23          	sd	a2,-72(s0)
     754:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     758:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     75c:	fe042223          	sw	zero,-28(s0)
     760:	a42d                	j	98a <vprintf+0x248>
    c = fmt[i] & 0xff;
     762:	fe442783          	lw	a5,-28(s0)
     766:	fc043703          	ld	a4,-64(s0)
     76a:	97ba                	add	a5,a5,a4
     76c:	0007c783          	lbu	a5,0(a5)
     770:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     774:	fe042783          	lw	a5,-32(s0)
     778:	2781                	sext.w	a5,a5
     77a:	eb9d                	bnez	a5,7b0 <vprintf+0x6e>
      if(c == '%'){
     77c:	fdc42783          	lw	a5,-36(s0)
     780:	0007871b          	sext.w	a4,a5
     784:	02500793          	li	a5,37
     788:	00f71763          	bne	a4,a5,796 <vprintf+0x54>
        state = '%';
     78c:	02500793          	li	a5,37
     790:	fef42023          	sw	a5,-32(s0)
     794:	a2f5                	j	980 <vprintf+0x23e>
      } else {
        putc(fd, c);
     796:	fdc42783          	lw	a5,-36(s0)
     79a:	0ff7f713          	andi	a4,a5,255
     79e:	fcc42783          	lw	a5,-52(s0)
     7a2:	85ba                	mv	a1,a4
     7a4:	853e                	mv	a0,a5
     7a6:	00000097          	auipc	ra,0x0
     7aa:	dcc080e7          	jalr	-564(ra) # 572 <putc>
     7ae:	aac9                	j	980 <vprintf+0x23e>
      }
    } else if(state == '%'){
     7b0:	fe042783          	lw	a5,-32(s0)
     7b4:	0007871b          	sext.w	a4,a5
     7b8:	02500793          	li	a5,37
     7bc:	1cf71263          	bne	a4,a5,980 <vprintf+0x23e>
      if(c == 'd'){
     7c0:	fdc42783          	lw	a5,-36(s0)
     7c4:	0007871b          	sext.w	a4,a5
     7c8:	06400793          	li	a5,100
     7cc:	02f71463          	bne	a4,a5,7f4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     7d0:	fb843783          	ld	a5,-72(s0)
     7d4:	00878713          	addi	a4,a5,8
     7d8:	fae43c23          	sd	a4,-72(s0)
     7dc:	4398                	lw	a4,0(a5)
     7de:	fcc42783          	lw	a5,-52(s0)
     7e2:	4685                	li	a3,1
     7e4:	4629                	li	a2,10
     7e6:	85ba                	mv	a1,a4
     7e8:	853e                	mv	a0,a5
     7ea:	00000097          	auipc	ra,0x0
     7ee:	dbe080e7          	jalr	-578(ra) # 5a8 <printint>
     7f2:	a269                	j	97c <vprintf+0x23a>
      } else if(c == 'l') {
     7f4:	fdc42783          	lw	a5,-36(s0)
     7f8:	0007871b          	sext.w	a4,a5
     7fc:	06c00793          	li	a5,108
     800:	02f71663          	bne	a4,a5,82c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     804:	fb843783          	ld	a5,-72(s0)
     808:	00878713          	addi	a4,a5,8
     80c:	fae43c23          	sd	a4,-72(s0)
     810:	639c                	ld	a5,0(a5)
     812:	0007871b          	sext.w	a4,a5
     816:	fcc42783          	lw	a5,-52(s0)
     81a:	4681                	li	a3,0
     81c:	4629                	li	a2,10
     81e:	85ba                	mv	a1,a4
     820:	853e                	mv	a0,a5
     822:	00000097          	auipc	ra,0x0
     826:	d86080e7          	jalr	-634(ra) # 5a8 <printint>
     82a:	aa89                	j	97c <vprintf+0x23a>
      } else if(c == 'x') {
     82c:	fdc42783          	lw	a5,-36(s0)
     830:	0007871b          	sext.w	a4,a5
     834:	07800793          	li	a5,120
     838:	02f71463          	bne	a4,a5,860 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     83c:	fb843783          	ld	a5,-72(s0)
     840:	00878713          	addi	a4,a5,8
     844:	fae43c23          	sd	a4,-72(s0)
     848:	4398                	lw	a4,0(a5)
     84a:	fcc42783          	lw	a5,-52(s0)
     84e:	4681                	li	a3,0
     850:	4641                	li	a2,16
     852:	85ba                	mv	a1,a4
     854:	853e                	mv	a0,a5
     856:	00000097          	auipc	ra,0x0
     85a:	d52080e7          	jalr	-686(ra) # 5a8 <printint>
     85e:	aa39                	j	97c <vprintf+0x23a>
      } else if(c == 'p') {
     860:	fdc42783          	lw	a5,-36(s0)
     864:	0007871b          	sext.w	a4,a5
     868:	07000793          	li	a5,112
     86c:	02f71263          	bne	a4,a5,890 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     870:	fb843783          	ld	a5,-72(s0)
     874:	00878713          	addi	a4,a5,8
     878:	fae43c23          	sd	a4,-72(s0)
     87c:	6398                	ld	a4,0(a5)
     87e:	fcc42783          	lw	a5,-52(s0)
     882:	85ba                	mv	a1,a4
     884:	853e                	mv	a0,a5
     886:	00000097          	auipc	ra,0x0
     88a:	e30080e7          	jalr	-464(ra) # 6b6 <printptr>
     88e:	a0fd                	j	97c <vprintf+0x23a>
      } else if(c == 's'){
     890:	fdc42783          	lw	a5,-36(s0)
     894:	0007871b          	sext.w	a4,a5
     898:	07300793          	li	a5,115
     89c:	04f71c63          	bne	a4,a5,8f4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     8a0:	fb843783          	ld	a5,-72(s0)
     8a4:	00878713          	addi	a4,a5,8
     8a8:	fae43c23          	sd	a4,-72(s0)
     8ac:	639c                	ld	a5,0(a5)
     8ae:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     8b2:	fe843783          	ld	a5,-24(s0)
     8b6:	eb8d                	bnez	a5,8e8 <vprintf+0x1a6>
          s = "(null)";
     8b8:	00001797          	auipc	a5,0x1
     8bc:	a2878793          	addi	a5,a5,-1496 # 12e0 <schedule_edf_cbs+0x410>
     8c0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8c4:	a015                	j	8e8 <vprintf+0x1a6>
          putc(fd, *s);
     8c6:	fe843783          	ld	a5,-24(s0)
     8ca:	0007c703          	lbu	a4,0(a5)
     8ce:	fcc42783          	lw	a5,-52(s0)
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	c9c080e7          	jalr	-868(ra) # 572 <putc>
          s++;
     8de:	fe843783          	ld	a5,-24(s0)
     8e2:	0785                	addi	a5,a5,1
     8e4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8e8:	fe843783          	ld	a5,-24(s0)
     8ec:	0007c783          	lbu	a5,0(a5)
     8f0:	fbf9                	bnez	a5,8c6 <vprintf+0x184>
     8f2:	a069                	j	97c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     8f4:	fdc42783          	lw	a5,-36(s0)
     8f8:	0007871b          	sext.w	a4,a5
     8fc:	06300793          	li	a5,99
     900:	02f71463          	bne	a4,a5,928 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     904:	fb843783          	ld	a5,-72(s0)
     908:	00878713          	addi	a4,a5,8
     90c:	fae43c23          	sd	a4,-72(s0)
     910:	439c                	lw	a5,0(a5)
     912:	0ff7f713          	andi	a4,a5,255
     916:	fcc42783          	lw	a5,-52(s0)
     91a:	85ba                	mv	a1,a4
     91c:	853e                	mv	a0,a5
     91e:	00000097          	auipc	ra,0x0
     922:	c54080e7          	jalr	-940(ra) # 572 <putc>
     926:	a899                	j	97c <vprintf+0x23a>
      } else if(c == '%'){
     928:	fdc42783          	lw	a5,-36(s0)
     92c:	0007871b          	sext.w	a4,a5
     930:	02500793          	li	a5,37
     934:	00f71f63          	bne	a4,a5,952 <vprintf+0x210>
        putc(fd, c);
     938:	fdc42783          	lw	a5,-36(s0)
     93c:	0ff7f713          	andi	a4,a5,255
     940:	fcc42783          	lw	a5,-52(s0)
     944:	85ba                	mv	a1,a4
     946:	853e                	mv	a0,a5
     948:	00000097          	auipc	ra,0x0
     94c:	c2a080e7          	jalr	-982(ra) # 572 <putc>
     950:	a035                	j	97c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     952:	fcc42783          	lw	a5,-52(s0)
     956:	02500593          	li	a1,37
     95a:	853e                	mv	a0,a5
     95c:	00000097          	auipc	ra,0x0
     960:	c16080e7          	jalr	-1002(ra) # 572 <putc>
        putc(fd, c);
     964:	fdc42783          	lw	a5,-36(s0)
     968:	0ff7f713          	andi	a4,a5,255
     96c:	fcc42783          	lw	a5,-52(s0)
     970:	85ba                	mv	a1,a4
     972:	853e                	mv	a0,a5
     974:	00000097          	auipc	ra,0x0
     978:	bfe080e7          	jalr	-1026(ra) # 572 <putc>
      }
      state = 0;
     97c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     980:	fe442783          	lw	a5,-28(s0)
     984:	2785                	addiw	a5,a5,1
     986:	fef42223          	sw	a5,-28(s0)
     98a:	fe442783          	lw	a5,-28(s0)
     98e:	fc043703          	ld	a4,-64(s0)
     992:	97ba                	add	a5,a5,a4
     994:	0007c783          	lbu	a5,0(a5)
     998:	dc0795e3          	bnez	a5,762 <vprintf+0x20>
    }
  }
}
     99c:	0001                	nop
     99e:	0001                	nop
     9a0:	60a6                	ld	ra,72(sp)
     9a2:	6406                	ld	s0,64(sp)
     9a4:	6161                	addi	sp,sp,80
     9a6:	8082                	ret

00000000000009a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     9a8:	7159                	addi	sp,sp,-112
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	0080                	addi	s0,sp,64
     9b0:	fcb43823          	sd	a1,-48(s0)
     9b4:	e010                	sd	a2,0(s0)
     9b6:	e414                	sd	a3,8(s0)
     9b8:	e818                	sd	a4,16(s0)
     9ba:	ec1c                	sd	a5,24(s0)
     9bc:	03043023          	sd	a6,32(s0)
     9c0:	03143423          	sd	a7,40(s0)
     9c4:	87aa                	mv	a5,a0
     9c6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     9ca:	03040793          	addi	a5,s0,48
     9ce:	fcf43423          	sd	a5,-56(s0)
     9d2:	fc843783          	ld	a5,-56(s0)
     9d6:	fd078793          	addi	a5,a5,-48
     9da:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     9de:	fe843703          	ld	a4,-24(s0)
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	863a                	mv	a2,a4
     9e8:	fd043583          	ld	a1,-48(s0)
     9ec:	853e                	mv	a0,a5
     9ee:	00000097          	auipc	ra,0x0
     9f2:	d54080e7          	jalr	-684(ra) # 742 <vprintf>
}
     9f6:	0001                	nop
     9f8:	70e2                	ld	ra,56(sp)
     9fa:	7442                	ld	s0,48(sp)
     9fc:	6165                	addi	sp,sp,112
     9fe:	8082                	ret

0000000000000a00 <printf>:

void
printf(const char *fmt, ...)
{
     a00:	7159                	addi	sp,sp,-112
     a02:	f406                	sd	ra,40(sp)
     a04:	f022                	sd	s0,32(sp)
     a06:	1800                	addi	s0,sp,48
     a08:	fca43c23          	sd	a0,-40(s0)
     a0c:	e40c                	sd	a1,8(s0)
     a0e:	e810                	sd	a2,16(s0)
     a10:	ec14                	sd	a3,24(s0)
     a12:	f018                	sd	a4,32(s0)
     a14:	f41c                	sd	a5,40(s0)
     a16:	03043823          	sd	a6,48(s0)
     a1a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a1e:	04040793          	addi	a5,s0,64
     a22:	fcf43823          	sd	a5,-48(s0)
     a26:	fd043783          	ld	a5,-48(s0)
     a2a:	fc878793          	addi	a5,a5,-56
     a2e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	863e                	mv	a2,a5
     a38:	fd843583          	ld	a1,-40(s0)
     a3c:	4505                	li	a0,1
     a3e:	00000097          	auipc	ra,0x0
     a42:	d04080e7          	jalr	-764(ra) # 742 <vprintf>
}
     a46:	0001                	nop
     a48:	70a2                	ld	ra,40(sp)
     a4a:	7402                	ld	s0,32(sp)
     a4c:	6165                	addi	sp,sp,112
     a4e:	8082                	ret

0000000000000a50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a50:	7179                	addi	sp,sp,-48
     a52:	f422                	sd	s0,40(sp)
     a54:	1800                	addi	s0,sp,48
     a56:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     a5a:	fd843783          	ld	a5,-40(s0)
     a5e:	17c1                	addi	a5,a5,-16
     a60:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a64:	00001797          	auipc	a5,0x1
     a68:	8ac78793          	addi	a5,a5,-1876 # 1310 <freep>
     a6c:	639c                	ld	a5,0(a5)
     a6e:	fef43423          	sd	a5,-24(s0)
     a72:	a815                	j	aa6 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a74:	fe843783          	ld	a5,-24(s0)
     a78:	639c                	ld	a5,0(a5)
     a7a:	fe843703          	ld	a4,-24(s0)
     a7e:	00f76f63          	bltu	a4,a5,a9c <free+0x4c>
     a82:	fe043703          	ld	a4,-32(s0)
     a86:	fe843783          	ld	a5,-24(s0)
     a8a:	02e7eb63          	bltu	a5,a4,ac0 <free+0x70>
     a8e:	fe843783          	ld	a5,-24(s0)
     a92:	639c                	ld	a5,0(a5)
     a94:	fe043703          	ld	a4,-32(s0)
     a98:	02f76463          	bltu	a4,a5,ac0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a9c:	fe843783          	ld	a5,-24(s0)
     aa0:	639c                	ld	a5,0(a5)
     aa2:	fef43423          	sd	a5,-24(s0)
     aa6:	fe043703          	ld	a4,-32(s0)
     aaa:	fe843783          	ld	a5,-24(s0)
     aae:	fce7f3e3          	bgeu	a5,a4,a74 <free+0x24>
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	639c                	ld	a5,0(a5)
     ab8:	fe043703          	ld	a4,-32(s0)
     abc:	faf77ce3          	bgeu	a4,a5,a74 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ac0:	fe043783          	ld	a5,-32(s0)
     ac4:	479c                	lw	a5,8(a5)
     ac6:	1782                	slli	a5,a5,0x20
     ac8:	9381                	srli	a5,a5,0x20
     aca:	0792                	slli	a5,a5,0x4
     acc:	fe043703          	ld	a4,-32(s0)
     ad0:	973e                	add	a4,a4,a5
     ad2:	fe843783          	ld	a5,-24(s0)
     ad6:	639c                	ld	a5,0(a5)
     ad8:	02f71763          	bne	a4,a5,b06 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     adc:	fe043783          	ld	a5,-32(s0)
     ae0:	4798                	lw	a4,8(a5)
     ae2:	fe843783          	ld	a5,-24(s0)
     ae6:	639c                	ld	a5,0(a5)
     ae8:	479c                	lw	a5,8(a5)
     aea:	9fb9                	addw	a5,a5,a4
     aec:	0007871b          	sext.w	a4,a5
     af0:	fe043783          	ld	a5,-32(s0)
     af4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	639c                	ld	a5,0(a5)
     afc:	6398                	ld	a4,0(a5)
     afe:	fe043783          	ld	a5,-32(s0)
     b02:	e398                	sd	a4,0(a5)
     b04:	a039                	j	b12 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	6398                	ld	a4,0(a5)
     b0c:	fe043783          	ld	a5,-32(s0)
     b10:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b12:	fe843783          	ld	a5,-24(s0)
     b16:	479c                	lw	a5,8(a5)
     b18:	1782                	slli	a5,a5,0x20
     b1a:	9381                	srli	a5,a5,0x20
     b1c:	0792                	slli	a5,a5,0x4
     b1e:	fe843703          	ld	a4,-24(s0)
     b22:	97ba                	add	a5,a5,a4
     b24:	fe043703          	ld	a4,-32(s0)
     b28:	02f71563          	bne	a4,a5,b52 <free+0x102>
    p->s.size += bp->s.size;
     b2c:	fe843783          	ld	a5,-24(s0)
     b30:	4798                	lw	a4,8(a5)
     b32:	fe043783          	ld	a5,-32(s0)
     b36:	479c                	lw	a5,8(a5)
     b38:	9fb9                	addw	a5,a5,a4
     b3a:	0007871b          	sext.w	a4,a5
     b3e:	fe843783          	ld	a5,-24(s0)
     b42:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     b44:	fe043783          	ld	a5,-32(s0)
     b48:	6398                	ld	a4,0(a5)
     b4a:	fe843783          	ld	a5,-24(s0)
     b4e:	e398                	sd	a4,0(a5)
     b50:	a031                	j	b5c <free+0x10c>
  } else
    p->s.ptr = bp;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	fe043703          	ld	a4,-32(s0)
     b5a:	e398                	sd	a4,0(a5)
  freep = p;
     b5c:	00000797          	auipc	a5,0x0
     b60:	7b478793          	addi	a5,a5,1972 # 1310 <freep>
     b64:	fe843703          	ld	a4,-24(s0)
     b68:	e398                	sd	a4,0(a5)
}
     b6a:	0001                	nop
     b6c:	7422                	ld	s0,40(sp)
     b6e:	6145                	addi	sp,sp,48
     b70:	8082                	ret

0000000000000b72 <morecore>:

static Header*
morecore(uint nu)
{
     b72:	7179                	addi	sp,sp,-48
     b74:	f406                	sd	ra,40(sp)
     b76:	f022                	sd	s0,32(sp)
     b78:	1800                	addi	s0,sp,48
     b7a:	87aa                	mv	a5,a0
     b7c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     b80:	fdc42783          	lw	a5,-36(s0)
     b84:	0007871b          	sext.w	a4,a5
     b88:	6785                	lui	a5,0x1
     b8a:	00f77563          	bgeu	a4,a5,b94 <morecore+0x22>
    nu = 4096;
     b8e:	6785                	lui	a5,0x1
     b90:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     b94:	fdc42783          	lw	a5,-36(s0)
     b98:	0047979b          	slliw	a5,a5,0x4
     b9c:	2781                	sext.w	a5,a5
     b9e:	2781                	sext.w	a5,a5
     ba0:	853e                	mv	a0,a5
     ba2:	00000097          	auipc	ra,0x0
     ba6:	9a0080e7          	jalr	-1632(ra) # 542 <sbrk>
     baa:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     bae:	fe843703          	ld	a4,-24(s0)
     bb2:	57fd                	li	a5,-1
     bb4:	00f71463          	bne	a4,a5,bbc <morecore+0x4a>
    return 0;
     bb8:	4781                	li	a5,0
     bba:	a03d                	j	be8 <morecore+0x76>
  hp = (Header*)p;
     bbc:	fe843783          	ld	a5,-24(s0)
     bc0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	fdc42703          	lw	a4,-36(s0)
     bcc:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     bce:	fe043783          	ld	a5,-32(s0)
     bd2:	07c1                	addi	a5,a5,16
     bd4:	853e                	mv	a0,a5
     bd6:	00000097          	auipc	ra,0x0
     bda:	e7a080e7          	jalr	-390(ra) # a50 <free>
  return freep;
     bde:	00000797          	auipc	a5,0x0
     be2:	73278793          	addi	a5,a5,1842 # 1310 <freep>
     be6:	639c                	ld	a5,0(a5)
}
     be8:	853e                	mv	a0,a5
     bea:	70a2                	ld	ra,40(sp)
     bec:	7402                	ld	s0,32(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <malloc>:

void*
malloc(uint nbytes)
{
     bf2:	7139                	addi	sp,sp,-64
     bf4:	fc06                	sd	ra,56(sp)
     bf6:	f822                	sd	s0,48(sp)
     bf8:	0080                	addi	s0,sp,64
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c00:	fcc46783          	lwu	a5,-52(s0)
     c04:	07bd                	addi	a5,a5,15
     c06:	8391                	srli	a5,a5,0x4
     c08:	2781                	sext.w	a5,a5
     c0a:	2785                	addiw	a5,a5,1
     c0c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c10:	00000797          	auipc	a5,0x0
     c14:	70078793          	addi	a5,a5,1792 # 1310 <freep>
     c18:	639c                	ld	a5,0(a5)
     c1a:	fef43023          	sd	a5,-32(s0)
     c1e:	fe043783          	ld	a5,-32(s0)
     c22:	ef95                	bnez	a5,c5e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c24:	00000797          	auipc	a5,0x0
     c28:	6dc78793          	addi	a5,a5,1756 # 1300 <base>
     c2c:	fef43023          	sd	a5,-32(s0)
     c30:	00000797          	auipc	a5,0x0
     c34:	6e078793          	addi	a5,a5,1760 # 1310 <freep>
     c38:	fe043703          	ld	a4,-32(s0)
     c3c:	e398                	sd	a4,0(a5)
     c3e:	00000797          	auipc	a5,0x0
     c42:	6d278793          	addi	a5,a5,1746 # 1310 <freep>
     c46:	6398                	ld	a4,0(a5)
     c48:	00000797          	auipc	a5,0x0
     c4c:	6b878793          	addi	a5,a5,1720 # 1300 <base>
     c50:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c52:	00000797          	auipc	a5,0x0
     c56:	6ae78793          	addi	a5,a5,1710 # 1300 <base>
     c5a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c5e:	fe043783          	ld	a5,-32(s0)
     c62:	639c                	ld	a5,0(a5)
     c64:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     c68:	fe843783          	ld	a5,-24(s0)
     c6c:	4798                	lw	a4,8(a5)
     c6e:	fdc42783          	lw	a5,-36(s0)
     c72:	2781                	sext.w	a5,a5
     c74:	06f76863          	bltu	a4,a5,ce4 <malloc+0xf2>
      if(p->s.size == nunits)
     c78:	fe843783          	ld	a5,-24(s0)
     c7c:	4798                	lw	a4,8(a5)
     c7e:	fdc42783          	lw	a5,-36(s0)
     c82:	2781                	sext.w	a5,a5
     c84:	00e79963          	bne	a5,a4,c96 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     c88:	fe843783          	ld	a5,-24(s0)
     c8c:	6398                	ld	a4,0(a5)
     c8e:	fe043783          	ld	a5,-32(s0)
     c92:	e398                	sd	a4,0(a5)
     c94:	a82d                	j	cce <malloc+0xdc>
      else {
        p->s.size -= nunits;
     c96:	fe843783          	ld	a5,-24(s0)
     c9a:	4798                	lw	a4,8(a5)
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	40f707bb          	subw	a5,a4,a5
     ca4:	0007871b          	sext.w	a4,a5
     ca8:	fe843783          	ld	a5,-24(s0)
     cac:	c798                	sw	a4,8(a5)
        p += p->s.size;
     cae:	fe843783          	ld	a5,-24(s0)
     cb2:	479c                	lw	a5,8(a5)
     cb4:	1782                	slli	a5,a5,0x20
     cb6:	9381                	srli	a5,a5,0x20
     cb8:	0792                	slli	a5,a5,0x4
     cba:	fe843703          	ld	a4,-24(s0)
     cbe:	97ba                	add	a5,a5,a4
     cc0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	fdc42703          	lw	a4,-36(s0)
     ccc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     cce:	00000797          	auipc	a5,0x0
     cd2:	64278793          	addi	a5,a5,1602 # 1310 <freep>
     cd6:	fe043703          	ld	a4,-32(s0)
     cda:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     cdc:	fe843783          	ld	a5,-24(s0)
     ce0:	07c1                	addi	a5,a5,16
     ce2:	a091                	j	d26 <malloc+0x134>
    }
    if(p == freep)
     ce4:	00000797          	auipc	a5,0x0
     ce8:	62c78793          	addi	a5,a5,1580 # 1310 <freep>
     cec:	639c                	ld	a5,0(a5)
     cee:	fe843703          	ld	a4,-24(s0)
     cf2:	02f71063          	bne	a4,a5,d12 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     cf6:	fdc42783          	lw	a5,-36(s0)
     cfa:	853e                	mv	a0,a5
     cfc:	00000097          	auipc	ra,0x0
     d00:	e76080e7          	jalr	-394(ra) # b72 <morecore>
     d04:	fea43423          	sd	a0,-24(s0)
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	e399                	bnez	a5,d12 <malloc+0x120>
        return 0;
     d0e:	4781                	li	a5,0
     d10:	a819                	j	d26 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d12:	fe843783          	ld	a5,-24(s0)
     d16:	fef43023          	sd	a5,-32(s0)
     d1a:	fe843783          	ld	a5,-24(s0)
     d1e:	639c                	ld	a5,0(a5)
     d20:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d24:	b791                	j	c68 <malloc+0x76>
  }
}
     d26:	853e                	mv	a0,a5
     d28:	70e2                	ld	ra,56(sp)
     d2a:	7442                	ld	s0,48(sp)
     d2c:	6121                	addi	sp,sp,64
     d2e:	8082                	ret

0000000000000d30 <setjmp>:
     d30:	e100                	sd	s0,0(a0)
     d32:	e504                	sd	s1,8(a0)
     d34:	01253823          	sd	s2,16(a0)
     d38:	01353c23          	sd	s3,24(a0)
     d3c:	03453023          	sd	s4,32(a0)
     d40:	03553423          	sd	s5,40(a0)
     d44:	03653823          	sd	s6,48(a0)
     d48:	03753c23          	sd	s7,56(a0)
     d4c:	05853023          	sd	s8,64(a0)
     d50:	05953423          	sd	s9,72(a0)
     d54:	05a53823          	sd	s10,80(a0)
     d58:	05b53c23          	sd	s11,88(a0)
     d5c:	06153023          	sd	ra,96(a0)
     d60:	06253423          	sd	sp,104(a0)
     d64:	4501                	li	a0,0
     d66:	8082                	ret

0000000000000d68 <longjmp>:
     d68:	6100                	ld	s0,0(a0)
     d6a:	6504                	ld	s1,8(a0)
     d6c:	01053903          	ld	s2,16(a0)
     d70:	01853983          	ld	s3,24(a0)
     d74:	02053a03          	ld	s4,32(a0)
     d78:	02853a83          	ld	s5,40(a0)
     d7c:	03053b03          	ld	s6,48(a0)
     d80:	03853b83          	ld	s7,56(a0)
     d84:	04053c03          	ld	s8,64(a0)
     d88:	04853c83          	ld	s9,72(a0)
     d8c:	05053d03          	ld	s10,80(a0)
     d90:	05853d83          	ld	s11,88(a0)
     d94:	06053083          	ld	ra,96(a0)
     d98:	06853103          	ld	sp,104(a0)
     d9c:	c199                	beqz	a1,da2 <longjmp_1>
     d9e:	852e                	mv	a0,a1
     da0:	8082                	ret

0000000000000da2 <longjmp_1>:
     da2:	4505                	li	a0,1
     da4:	8082                	ret

0000000000000da6 <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
     da6:	7139                	addi	sp,sp,-64
     da8:	fc22                	sd	s0,56(sp)
     daa:	0080                	addi	s0,sp,64
     dac:	fca43423          	sd	a0,-56(s0)
     db0:	87ae                	mv	a5,a1
     db2:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
     db6:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
     dba:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     dbe:	fc843783          	ld	a5,-56(s0)
     dc2:	639c                	ld	a5,0(a5)
     dc4:	fcf43c23          	sd	a5,-40(s0)
     dc8:	fd843783          	ld	a5,-40(s0)
     dcc:	fd878793          	addi	a5,a5,-40
     dd0:	fef43423          	sd	a5,-24(s0)
     dd4:	a881                	j	e24 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
     dd6:	fe843783          	ld	a5,-24(s0)
     dda:	4fb8                	lw	a4,88(a5)
     ddc:	fc442783          	lw	a5,-60(s0)
     de0:	2781                	sext.w	a5,a5
     de2:	02e7c663          	blt	a5,a4,e0e <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
     de6:	fe043783          	ld	a5,-32(s0)
     dea:	e791                	bnez	a5,df6 <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	fef43023          	sd	a5,-32(s0)
     df4:	a829                	j	e0e <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
     df6:	fe843783          	ld	a5,-24(s0)
     dfa:	5fd8                	lw	a4,60(a5)
     dfc:	fe043783          	ld	a5,-32(s0)
     e00:	5fdc                	lw	a5,60(a5)
     e02:	00f75663          	bge	a4,a5,e0e <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	779c                	ld	a5,40(a5)
     e14:	fcf43823          	sd	a5,-48(s0)
     e18:	fd043783          	ld	a5,-48(s0)
     e1c:	fd878793          	addi	a5,a5,-40
     e20:	fef43423          	sd	a5,-24(s0)
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	02878793          	addi	a5,a5,40
     e2c:	fc843703          	ld	a4,-56(s0)
     e30:	faf713e3          	bne	a4,a5,dd6 <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
     e34:	fe043783          	ld	a5,-32(s0)
}
     e38:	853e                	mv	a0,a5
     e3a:	7462                	ld	s0,56(sp)
     e3c:	6121                	addi	sp,sp,64
     e3e:	8082                	ret

0000000000000e40 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
     e40:	1101                	addi	sp,sp,-32
     e42:	ec22                	sd	s0,24(sp)
     e44:	1000                	addi	s0,sp,32
     e46:	fea43423          	sd	a0,-24(s0)
     e4a:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
     e4e:	fe843783          	ld	a5,-24(s0)
     e52:	57fc                	lw	a5,108(a5)
     e54:	c799                	beqz	a5,e62 <__edf_thread_cmp+0x22>
     e56:	fe043783          	ld	a5,-32(s0)
     e5a:	57fc                	lw	a5,108(a5)
     e5c:	e399                	bnez	a5,e62 <__edf_thread_cmp+0x22>
     e5e:	57fd                	li	a5,-1
     e60:	a0a5                	j	ec8 <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
     e62:	fe843783          	ld	a5,-24(s0)
     e66:	57fc                	lw	a5,108(a5)
     e68:	e799                	bnez	a5,e76 <__edf_thread_cmp+0x36>
     e6a:	fe043783          	ld	a5,-32(s0)
     e6e:	57fc                	lw	a5,108(a5)
     e70:	c399                	beqz	a5,e76 <__edf_thread_cmp+0x36>
     e72:	4785                	li	a5,1
     e74:	a891                	j	ec8 <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	4fb8                	lw	a4,88(a5)
     e7c:	fe043783          	ld	a5,-32(s0)
     e80:	4fbc                	lw	a5,88(a5)
     e82:	00f75463          	bge	a4,a5,e8a <__edf_thread_cmp+0x4a>
     e86:	57fd                	li	a5,-1
     e88:	a081                	j	ec8 <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
     e8a:	fe843783          	ld	a5,-24(s0)
     e8e:	4fb8                	lw	a4,88(a5)
     e90:	fe043783          	ld	a5,-32(s0)
     e94:	4fbc                	lw	a5,88(a5)
     e96:	00e7d463          	bge	a5,a4,e9e <__edf_thread_cmp+0x5e>
     e9a:	4785                	li	a5,1
     e9c:	a035                	j	ec8 <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
     e9e:	fe843783          	ld	a5,-24(s0)
     ea2:	5fd8                	lw	a4,60(a5)
     ea4:	fe043783          	ld	a5,-32(s0)
     ea8:	5fdc                	lw	a5,60(a5)
     eaa:	00f75463          	bge	a4,a5,eb2 <__edf_thread_cmp+0x72>
     eae:	57fd                	li	a5,-1
     eb0:	a821                	j	ec8 <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
     eb2:	fe843783          	ld	a5,-24(s0)
     eb6:	5fd8                	lw	a4,60(a5)
     eb8:	fe043783          	ld	a5,-32(s0)
     ebc:	5fdc                	lw	a5,60(a5)
     ebe:	00e7d463          	bge	a5,a4,ec6 <__edf_thread_cmp+0x86>
     ec2:	4785                	li	a5,1
     ec4:	a011                	j	ec8 <__edf_thread_cmp+0x88>
    
    return 0;
     ec6:	4781                	li	a5,0
}
     ec8:	853e                	mv	a0,a5
     eca:	6462                	ld	s0,24(sp)
     ecc:	6105                	addi	sp,sp,32
     ece:	8082                	ret

0000000000000ed0 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
     ed0:	7151                	addi	sp,sp,-240
     ed2:	f586                	sd	ra,232(sp)
     ed4:	f1a2                	sd	s0,224(sp)
     ed6:	eda6                	sd	s1,216(sp)
     ed8:	e9ca                	sd	s2,208(sp)
     eda:	e5ce                	sd	s3,200(sp)
     edc:	1980                	addi	s0,sp,240
     ede:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
     ee0:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
     ee4:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
     ee8:	649c                	ld	a5,8(s1)
     eea:	639c                	ld	a5,0(a5)
     eec:	f8f43c23          	sd	a5,-104(s0)
     ef0:	f9843783          	ld	a5,-104(s0)
     ef4:	fd878793          	addi	a5,a5,-40
     ef8:	fcf43423          	sd	a5,-56(s0)
     efc:	a8b1                	j	f58 <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     efe:	fc843783          	ld	a5,-56(s0)
     f02:	57bc                	lw	a5,104(a5)
     f04:	02f04f63          	bgtz	a5,f42 <schedule_edf_cbs+0x72>
     f08:	fc843783          	ld	a5,-56(s0)
     f0c:	4bfc                	lw	a5,84(a5)
     f0e:	02f05a63          	blez	a5,f42 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
     f12:	4098                	lw	a4,0(s1)
     f14:	fc843783          	ld	a5,-56(s0)
     f18:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     f1a:	02f71463          	bne	a4,a5,f42 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
     f1e:	fc843783          	ld	a5,-56(s0)
     f22:	4fb8                	lw	a4,88(a5)
     f24:	fc843783          	ld	a5,-56(s0)
     f28:	47fc                	lw	a5,76(a5)
     f2a:	9fb9                	addw	a5,a5,a4
     f2c:	0007871b          	sext.w	a4,a5
     f30:	fc843783          	ld	a5,-56(s0)
     f34:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
     f36:	fc843783          	ld	a5,-56(s0)
     f3a:	53f8                	lw	a4,100(a5)
     f3c:	fc843783          	ld	a5,-56(s0)
     f40:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
     f42:	fc843783          	ld	a5,-56(s0)
     f46:	779c                	ld	a5,40(a5)
     f48:	f2f43823          	sd	a5,-208(s0)
     f4c:	f3043783          	ld	a5,-208(s0)
     f50:	fd878793          	addi	a5,a5,-40
     f54:	fcf43423          	sd	a5,-56(s0)
     f58:	fc843783          	ld	a5,-56(s0)
     f5c:	02878713          	addi	a4,a5,40
     f60:	649c                	ld	a5,8(s1)
     f62:	f8f71ee3          	bne	a4,a5,efe <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
     f66:	649c                	ld	a5,8(s1)
     f68:	4098                	lw	a4,0(s1)
     f6a:	85ba                	mv	a1,a4
     f6c:	853e                	mv	a0,a5
     f6e:	00000097          	auipc	ra,0x0
     f72:	e38080e7          	jalr	-456(ra) # da6 <__check_deadline_miss>
     f76:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
     f7a:	f9043783          	ld	a5,-112(s0)
     f7e:	c395                	beqz	a5,fa2 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
     f80:	f9043783          	ld	a5,-112(s0)
     f84:	02878793          	addi	a5,a5,40
     f88:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
     f8c:	f0042c23          	sw	zero,-232(s0)
        return r;
     f90:	f1043783          	ld	a5,-240(s0)
     f94:	f2f43023          	sd	a5,-224(s0)
     f98:	f1843783          	ld	a5,-232(s0)
     f9c:	f2f43423          	sd	a5,-216(s0)
     fa0:	ae19                	j	12b6 <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
     fa2:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
     fa6:	649c                	ld	a5,8(s1)
     fa8:	639c                	ld	a5,0(a5)
     faa:	f8f43423          	sd	a5,-120(s0)
     fae:	f8843783          	ld	a5,-120(s0)
     fb2:	fd878793          	addi	a5,a5,-40
     fb6:	fcf43423          	sd	a5,-56(s0)
     fba:	a0ad                	j	1024 <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
     fbc:	fc843783          	ld	a5,-56(s0)
     fc0:	4bfc                	lw	a5,84(a5)
     fc2:	04f05563          	blez	a5,100c <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     fc6:	fc843783          	ld	a5,-56(s0)
     fca:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
     fcc:	00f04d63          	bgtz	a5,fe6 <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     fd0:	fc843783          	ld	a5,-56(s0)
     fd4:	4bfc                	lw	a5,84(a5)
     fd6:	00f05863          	blez	a5,fe6 <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
     fda:	4098                	lw	a4,0(s1)
     fdc:	fc843783          	ld	a5,-56(s0)
     fe0:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     fe2:	02f74563          	blt	a4,a5,100c <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
     fe6:	fc043783          	ld	a5,-64(s0)
     fea:	cf81                	beqz	a5,1002 <schedule_edf_cbs+0x132>
     fec:	fc043583          	ld	a1,-64(s0)
     ff0:	fc843503          	ld	a0,-56(s0)
     ff4:	00000097          	auipc	ra,0x0
     ff8:	e4c080e7          	jalr	-436(ra) # e40 <__edf_thread_cmp>
     ffc:	87aa                	mv	a5,a0
     ffe:	0007d863          	bgez	a5,100e <schedule_edf_cbs+0x13e>
            selected = t;
    1002:	fc843783          	ld	a5,-56(s0)
    1006:	fcf43023          	sd	a5,-64(s0)
    100a:	a011                	j	100e <schedule_edf_cbs+0x13e>
            continue;
    100c:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
    100e:	fc843783          	ld	a5,-56(s0)
    1012:	779c                	ld	a5,40(a5)
    1014:	f2f43c23          	sd	a5,-200(s0)
    1018:	f3843783          	ld	a5,-200(s0)
    101c:	fd878793          	addi	a5,a5,-40
    1020:	fcf43423          	sd	a5,-56(s0)
    1024:	fc843783          	ld	a5,-56(s0)
    1028:	02878713          	addi	a4,a5,40
    102c:	649c                	ld	a5,8(s1)
    102e:	f8f717e3          	bne	a4,a5,fbc <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    1032:	fc043783          	ld	a5,-64(s0)
    1036:	ebd5                	bnez	a5,10ea <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    1038:	800007b7          	lui	a5,0x80000
    103c:	fff7c793          	not	a5,a5
    1040:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    1044:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1048:	689c                	ld	a5,16(s1)
    104a:	639c                	ld	a5,0(a5)
    104c:	f4f43423          	sd	a5,-184(s0)
    1050:	f4843783          	ld	a5,-184(s0)
    1054:	17e1                	addi	a5,a5,-8
    1056:	faf43823          	sd	a5,-80(s0)
    105a:	a835                	j	1096 <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    105c:	fb043783          	ld	a5,-80(s0)
    1060:	4f98                	lw	a4,24(a5)
    1062:	409c                	lw	a5,0(s1)
    1064:	00e7df63          	bge	a5,a4,1082 <schedule_edf_cbs+0x1b2>
    1068:	fb043783          	ld	a5,-80(s0)
    106c:	4f98                	lw	a4,24(a5)
    106e:	fbc42783          	lw	a5,-68(s0)
    1072:	2781                	sext.w	a5,a5
    1074:	00f75763          	bge	a4,a5,1082 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    1078:	fb043783          	ld	a5,-80(s0)
    107c:	4f9c                	lw	a5,24(a5)
    107e:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1082:	fb043783          	ld	a5,-80(s0)
    1086:	679c                	ld	a5,8(a5)
    1088:	f4f43023          	sd	a5,-192(s0)
    108c:	f4043783          	ld	a5,-192(s0)
    1090:	17e1                	addi	a5,a5,-8
    1092:	faf43823          	sd	a5,-80(s0)
    1096:	fb043783          	ld	a5,-80(s0)
    109a:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffe520>
    109e:	689c                	ld	a5,16(s1)
    10a0:	faf71ee3          	bne	a4,a5,105c <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    10a4:	fbc42783          	lw	a5,-68(s0)
    10a8:	0007871b          	sext.w	a4,a5
    10ac:	800007b7          	lui	a5,0x80000
    10b0:	fff7c793          	not	a5,a5
    10b4:	00f70e63          	beq	a4,a5,10d0 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    10b8:	649c                	ld	a5,8(s1)
    10ba:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    10be:	409c                	lw	a5,0(s1)
    10c0:	fbc42703          	lw	a4,-68(s0)
    10c4:	40f707bb          	subw	a5,a4,a5
    10c8:	2781                	sext.w	a5,a5
    10ca:	f0f42c23          	sw	a5,-232(s0)
    10ce:	a029                	j	10d8 <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    10d0:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    10d4:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    10d8:	f1043783          	ld	a5,-240(s0)
    10dc:	f2f43023          	sd	a5,-224(s0)
    10e0:	f1843783          	ld	a5,-232(s0)
    10e4:	f2f43423          	sd	a5,-216(s0)
    10e8:	a2f9                	j	12b6 <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    10ea:	fc043783          	ld	a5,-64(s0)
    10ee:	57fc                	lw	a5,108(a5)
    10f0:	e7f1                	bnez	a5,11bc <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    10f2:	fc043783          	ld	a5,-64(s0)
    10f6:	57bc                	lw	a5,104(a5)
    10f8:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    10fc:	fc043783          	ld	a5,-64(s0)
    1100:	4fb8                	lw	a4,88(a5)
    1102:	409c                	lw	a5,0(s1)
    1104:	40f707bb          	subw	a5,a4,a5
    1108:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    110c:	fc043783          	ld	a5,-64(s0)
    1110:	47fc                	lw	a5,76(a5)
    1112:	f5c42703          	lw	a4,-164(s0)
    1116:	02f707bb          	mulw	a5,a4,a5
    111a:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    111e:	fc043783          	ld	a5,-64(s0)
    1122:	53fc                	lw	a5,100(a5)
    1124:	f5842703          	lw	a4,-168(s0)
    1128:	02f707bb          	mulw	a5,a4,a5
    112c:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    1130:	f5442703          	lw	a4,-172(s0)
    1134:	f5042783          	lw	a5,-176(s0)
    1138:	2701                	sext.w	a4,a4
    113a:	2781                	sext.w	a5,a5
    113c:	02e7d363          	bge	a5,a4,1162 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    1140:	4098                	lw	a4,0(s1)
    1142:	fc043783          	ld	a5,-64(s0)
    1146:	47fc                	lw	a5,76(a5)
    1148:	9fb9                	addw	a5,a5,a4
    114a:	0007871b          	sext.w	a4,a5
    114e:	fc043783          	ld	a5,-64(s0)
    1152:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    1154:	fc043783          	ld	a5,-64(s0)
    1158:	53f8                	lw	a4,100(a5)
    115a:	fc043783          	ld	a5,-64(s0)
    115e:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    1160:	b341                	j	ee0 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    1162:	fc043783          	ld	a5,-64(s0)
    1166:	57bc                	lw	a5,104(a5)
    1168:	02f04063          	bgtz	a5,1188 <schedule_edf_cbs+0x2b8>
    116c:	fc043783          	ld	a5,-64(s0)
    1170:	4bfc                	lw	a5,84(a5)
    1172:	00f05b63          	blez	a5,1188 <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    1176:	fc043783          	ld	a5,-64(s0)
    117a:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe540>
    117e:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    1182:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    1186:	bba9                	j	ee0 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    1188:	fc043783          	ld	a5,-64(s0)
    118c:	02878793          	addi	a5,a5,40
    1190:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1194:	fc043783          	ld	a5,-64(s0)
    1198:	57b8                	lw	a4,104(a5)
    119a:	fc043783          	ld	a5,-64(s0)
    119e:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    11a0:	863e                	mv	a2,a5
    11a2:	86ba                	mv	a3,a4
    11a4:	0006871b          	sext.w	a4,a3
    11a8:	0006079b          	sext.w	a5,a2
    11ac:	00e7d363          	bge	a5,a4,11b2 <schedule_edf_cbs+0x2e2>
    11b0:	86b2                	mv	a3,a2
    11b2:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    11b6:	f0f42c23          	sw	a5,-232(s0)
    11ba:	a0f5                	j	12a6 <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    11bc:	fc043783          	ld	a5,-64(s0)
    11c0:	4bfc                	lw	a5,84(a5)
    11c2:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    11c6:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    11ca:	689c                	ld	a5,16(s1)
    11cc:	639c                	ld	a5,0(a5)
    11ce:	f8f43023          	sd	a5,-128(s0)
    11d2:	f8043783          	ld	a5,-128(s0)
    11d6:	17e1                	addi	a5,a5,-8
    11d8:	faf43023          	sd	a5,-96(s0)
    11dc:	a041                	j	125c <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    11de:	fa043783          	ld	a5,-96(s0)
    11e2:	639c                	ld	a5,0(a5)
    11e4:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    11e8:	f7043783          	ld	a5,-144(s0)
    11ec:	53b8                	lw	a4,96(a5)
    11ee:	409c                	lw	a5,0(s1)
    11f0:	04e7dc63          	bge	a5,a4,1248 <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    11f4:	f7043783          	ld	a5,-144(s0)
    11f8:	53b4                	lw	a3,96(a5)
    11fa:	409c                	lw	a5,0(s1)
    11fc:	fac42703          	lw	a4,-84(s0)
    1200:	9fb9                	addw	a5,a5,a4
    1202:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    1204:	8736                	mv	a4,a3
    1206:	04f75163          	bge	a4,a5,1248 <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    120a:	fc043583          	ld	a1,-64(s0)
    120e:	f7043503          	ld	a0,-144(s0)
    1212:	00000097          	auipc	ra,0x0
    1216:	c2e080e7          	jalr	-978(ra) # e40 <__edf_thread_cmp>
    121a:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    121c:	0207d663          	bgez	a5,1248 <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    1220:	f7043783          	ld	a5,-144(s0)
    1224:	53b8                	lw	a4,96(a5)
    1226:	409c                	lw	a5,0(s1)
    1228:	40f707bb          	subw	a5,a4,a5
    122c:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    1230:	f6c42703          	lw	a4,-148(s0)
    1234:	fac42783          	lw	a5,-84(s0)
    1238:	2701                	sext.w	a4,a4
    123a:	2781                	sext.w	a5,a5
    123c:	00f75663          	bge	a4,a5,1248 <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    1240:	f6c42783          	lw	a5,-148(s0)
    1244:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1248:	fa043783          	ld	a5,-96(s0)
    124c:	679c                	ld	a5,8(a5)
    124e:	f6f43023          	sd	a5,-160(s0)
    1252:	f6043783          	ld	a5,-160(s0)
    1256:	17e1                	addi	a5,a5,-8
    1258:	faf43023          	sd	a5,-96(s0)
    125c:	fa043783          	ld	a5,-96(s0)
    1260:	00878713          	addi	a4,a5,8
    1264:	689c                	ld	a5,16(s1)
    1266:	f6f71ce3          	bne	a4,a5,11de <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    126a:	fc043783          	ld	a5,-64(s0)
    126e:	4fb8                	lw	a4,88(a5)
    1270:	409c                	lw	a5,0(s1)
    1272:	40f707bb          	subw	a5,a4,a5
    1276:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    127a:	f7c42703          	lw	a4,-132(s0)
    127e:	fac42783          	lw	a5,-84(s0)
    1282:	2701                	sext.w	a4,a4
    1284:	2781                	sext.w	a5,a5
    1286:	00f75663          	bge	a4,a5,1292 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    128a:	f7c42783          	lw	a5,-132(s0)
    128e:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    1292:	fc043783          	ld	a5,-64(s0)
    1296:	02878793          	addi	a5,a5,40
    129a:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    129e:	fac42783          	lw	a5,-84(s0)
    12a2:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    12a6:	f1043783          	ld	a5,-240(s0)
    12aa:	f2f43023          	sd	a5,-224(s0)
    12ae:	f1843783          	ld	a5,-232(s0)
    12b2:	f2f43423          	sd	a5,-216(s0)
    12b6:	4701                	li	a4,0
    12b8:	f2043703          	ld	a4,-224(s0)
    12bc:	4781                	li	a5,0
    12be:	f2843783          	ld	a5,-216(s0)
    12c2:	893a                	mv	s2,a4
    12c4:	89be                	mv	s3,a5
    12c6:	874a                	mv	a4,s2
    12c8:	87ce                	mv	a5,s3
}
    12ca:	853a                	mv	a0,a4
    12cc:	85be                	mv	a1,a5
    12ce:	70ae                	ld	ra,232(sp)
    12d0:	740e                	ld	s0,224(sp)
    12d2:	64ee                	ld	s1,216(sp)
    12d4:	694e                	ld	s2,208(sp)
    12d6:	69ae                	ld	s3,200(sp)
    12d8:	616d                	addi	sp,sp,240
    12da:	8082                	ret
