
user/_setjmp:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <setjmp>:
       0:	e100                	sd	s0,0(a0)
       2:	e504                	sd	s1,8(a0)
       4:	01253823          	sd	s2,16(a0)
       8:	01353c23          	sd	s3,24(a0)
       c:	03453023          	sd	s4,32(a0)
      10:	03553423          	sd	s5,40(a0)
      14:	03653823          	sd	s6,48(a0)
      18:	03753c23          	sd	s7,56(a0)
      1c:	05853023          	sd	s8,64(a0)
      20:	05953423          	sd	s9,72(a0)
      24:	05a53823          	sd	s10,80(a0)
      28:	05b53c23          	sd	s11,88(a0)
      2c:	06153023          	sd	ra,96(a0)
      30:	06253423          	sd	sp,104(a0)
      34:	4501                	li	a0,0
      36:	8082                	ret

0000000000000038 <longjmp>:
      38:	6100                	ld	s0,0(a0)
      3a:	6504                	ld	s1,8(a0)
      3c:	01053903          	ld	s2,16(a0)
      40:	01853983          	ld	s3,24(a0)
      44:	02053a03          	ld	s4,32(a0)
      48:	02853a83          	ld	s5,40(a0)
      4c:	03053b03          	ld	s6,48(a0)
      50:	03853b83          	ld	s7,56(a0)
      54:	04053c03          	ld	s8,64(a0)
      58:	04853c83          	ld	s9,72(a0)
      5c:	05053d03          	ld	s10,80(a0)
      60:	05853d83          	ld	s11,88(a0)
      64:	06053083          	ld	ra,96(a0)
      68:	06853103          	ld	sp,104(a0)
      6c:	c199                	beqz	a1,72 <longjmp_1>
      6e:	852e                	mv	a0,a1
      70:	8082                	ret

0000000000000072 <longjmp_1>:
      72:	4505                	li	a0,1
      74:	8082                	ret

0000000000000076 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      76:	7179                	addi	sp,sp,-48
      78:	f422                	sd	s0,40(sp)
      7a:	1800                	addi	s0,sp,48
      7c:	fca43c23          	sd	a0,-40(s0)
      80:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      84:	fd843783          	ld	a5,-40(s0)
      88:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      8c:	0001                	nop
      8e:	fd043703          	ld	a4,-48(s0)
      92:	00170793          	addi	a5,a4,1
      96:	fcf43823          	sd	a5,-48(s0)
      9a:	fd843783          	ld	a5,-40(s0)
      9e:	00178693          	addi	a3,a5,1
      a2:	fcd43c23          	sd	a3,-40(s0)
      a6:	00074703          	lbu	a4,0(a4)
      aa:	00e78023          	sb	a4,0(a5)
      ae:	0007c783          	lbu	a5,0(a5)
      b2:	fff1                	bnez	a5,8e <strcpy+0x18>
    ;
  return os;
      b4:	fe843783          	ld	a5,-24(s0)
}
      b8:	853e                	mv	a0,a5
      ba:	7422                	ld	s0,40(sp)
      bc:	6145                	addi	sp,sp,48
      be:	8082                	ret

00000000000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c0:	1101                	addi	sp,sp,-32
      c2:	ec22                	sd	s0,24(sp)
      c4:	1000                	addi	s0,sp,32
      c6:	fea43423          	sd	a0,-24(s0)
      ca:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      ce:	a819                	j	e4 <strcmp+0x24>
    p++, q++;
      d0:	fe843783          	ld	a5,-24(s0)
      d4:	0785                	addi	a5,a5,1
      d6:	fef43423          	sd	a5,-24(s0)
      da:	fe043783          	ld	a5,-32(s0)
      de:	0785                	addi	a5,a5,1
      e0:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      e4:	fe843783          	ld	a5,-24(s0)
      e8:	0007c783          	lbu	a5,0(a5)
      ec:	cb99                	beqz	a5,102 <strcmp+0x42>
      ee:	fe843783          	ld	a5,-24(s0)
      f2:	0007c703          	lbu	a4,0(a5)
      f6:	fe043783          	ld	a5,-32(s0)
      fa:	0007c783          	lbu	a5,0(a5)
      fe:	fcf709e3          	beq	a4,a5,d0 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     102:	fe843783          	ld	a5,-24(s0)
     106:	0007c783          	lbu	a5,0(a5)
     10a:	0007871b          	sext.w	a4,a5
     10e:	fe043783          	ld	a5,-32(s0)
     112:	0007c783          	lbu	a5,0(a5)
     116:	2781                	sext.w	a5,a5
     118:	40f707bb          	subw	a5,a4,a5
     11c:	2781                	sext.w	a5,a5
}
     11e:	853e                	mv	a0,a5
     120:	6462                	ld	s0,24(sp)
     122:	6105                	addi	sp,sp,32
     124:	8082                	ret

0000000000000126 <strlen>:

uint
strlen(const char *s)
{
     126:	7179                	addi	sp,sp,-48
     128:	f422                	sd	s0,40(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     130:	fe042623          	sw	zero,-20(s0)
     134:	a031                	j	140 <strlen+0x1a>
     136:	fec42783          	lw	a5,-20(s0)
     13a:	2785                	addiw	a5,a5,1
     13c:	fef42623          	sw	a5,-20(s0)
     140:	fec42783          	lw	a5,-20(s0)
     144:	fd843703          	ld	a4,-40(s0)
     148:	97ba                	add	a5,a5,a4
     14a:	0007c783          	lbu	a5,0(a5)
     14e:	f7e5                	bnez	a5,136 <strlen+0x10>
    ;
  return n;
     150:	fec42783          	lw	a5,-20(s0)
}
     154:	853e                	mv	a0,a5
     156:	7422                	ld	s0,40(sp)
     158:	6145                	addi	sp,sp,48
     15a:	8082                	ret

000000000000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
     15c:	7179                	addi	sp,sp,-48
     15e:	f422                	sd	s0,40(sp)
     160:	1800                	addi	s0,sp,48
     162:	fca43c23          	sd	a0,-40(s0)
     166:	87ae                	mv	a5,a1
     168:	8732                	mv	a4,a2
     16a:	fcf42a23          	sw	a5,-44(s0)
     16e:	87ba                	mv	a5,a4
     170:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     174:	fd843783          	ld	a5,-40(s0)
     178:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     17c:	fe042623          	sw	zero,-20(s0)
     180:	a00d                	j	1a2 <memset+0x46>
    cdst[i] = c;
     182:	fec42783          	lw	a5,-20(s0)
     186:	fe043703          	ld	a4,-32(s0)
     18a:	97ba                	add	a5,a5,a4
     18c:	fd442703          	lw	a4,-44(s0)
     190:	0ff77713          	andi	a4,a4,255
     194:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     198:	fec42783          	lw	a5,-20(s0)
     19c:	2785                	addiw	a5,a5,1
     19e:	fef42623          	sw	a5,-20(s0)
     1a2:	fec42703          	lw	a4,-20(s0)
     1a6:	fd042783          	lw	a5,-48(s0)
     1aa:	2781                	sext.w	a5,a5
     1ac:	fcf76be3          	bltu	a4,a5,182 <memset+0x26>
  }
  return dst;
     1b0:	fd843783          	ld	a5,-40(s0)
}
     1b4:	853e                	mv	a0,a5
     1b6:	7422                	ld	s0,40(sp)
     1b8:	6145                	addi	sp,sp,48
     1ba:	8082                	ret

00000000000001bc <strchr>:

char*
strchr(const char *s, char c)
{
     1bc:	1101                	addi	sp,sp,-32
     1be:	ec22                	sd	s0,24(sp)
     1c0:	1000                	addi	s0,sp,32
     1c2:	fea43423          	sd	a0,-24(s0)
     1c6:	87ae                	mv	a5,a1
     1c8:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     1cc:	a01d                	j	1f2 <strchr+0x36>
    if(*s == c)
     1ce:	fe843783          	ld	a5,-24(s0)
     1d2:	0007c703          	lbu	a4,0(a5)
     1d6:	fe744783          	lbu	a5,-25(s0)
     1da:	0ff7f793          	andi	a5,a5,255
     1de:	00e79563          	bne	a5,a4,1e8 <strchr+0x2c>
      return (char*)s;
     1e2:	fe843783          	ld	a5,-24(s0)
     1e6:	a821                	j	1fe <strchr+0x42>
  for(; *s; s++)
     1e8:	fe843783          	ld	a5,-24(s0)
     1ec:	0785                	addi	a5,a5,1
     1ee:	fef43423          	sd	a5,-24(s0)
     1f2:	fe843783          	ld	a5,-24(s0)
     1f6:	0007c783          	lbu	a5,0(a5)
     1fa:	fbf1                	bnez	a5,1ce <strchr+0x12>
  return 0;
     1fc:	4781                	li	a5,0
}
     1fe:	853e                	mv	a0,a5
     200:	6462                	ld	s0,24(sp)
     202:	6105                	addi	sp,sp,32
     204:	8082                	ret

0000000000000206 <gets>:

char*
gets(char *buf, int max)
{
     206:	7179                	addi	sp,sp,-48
     208:	f406                	sd	ra,40(sp)
     20a:	f022                	sd	s0,32(sp)
     20c:	1800                	addi	s0,sp,48
     20e:	fca43c23          	sd	a0,-40(s0)
     212:	87ae                	mv	a5,a1
     214:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     218:	fe042623          	sw	zero,-20(s0)
     21c:	a8a1                	j	274 <gets+0x6e>
    cc = read(0, &c, 1);
     21e:	fe740793          	addi	a5,s0,-25
     222:	4605                	li	a2,1
     224:	85be                	mv	a1,a5
     226:	4501                	li	a0,0
     228:	00000097          	auipc	ra,0x0
     22c:	2f6080e7          	jalr	758(ra) # 51e <read>
     230:	87aa                	mv	a5,a0
     232:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     236:	fe842783          	lw	a5,-24(s0)
     23a:	2781                	sext.w	a5,a5
     23c:	04f05763          	blez	a5,28a <gets+0x84>
      break;
    buf[i++] = c;
     240:	fec42783          	lw	a5,-20(s0)
     244:	0017871b          	addiw	a4,a5,1
     248:	fee42623          	sw	a4,-20(s0)
     24c:	873e                	mv	a4,a5
     24e:	fd843783          	ld	a5,-40(s0)
     252:	97ba                	add	a5,a5,a4
     254:	fe744703          	lbu	a4,-25(s0)
     258:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     25c:	fe744783          	lbu	a5,-25(s0)
     260:	873e                	mv	a4,a5
     262:	47a9                	li	a5,10
     264:	02f70463          	beq	a4,a5,28c <gets+0x86>
     268:	fe744783          	lbu	a5,-25(s0)
     26c:	873e                	mv	a4,a5
     26e:	47b5                	li	a5,13
     270:	00f70e63          	beq	a4,a5,28c <gets+0x86>
  for(i=0; i+1 < max; ){
     274:	fec42783          	lw	a5,-20(s0)
     278:	2785                	addiw	a5,a5,1
     27a:	0007871b          	sext.w	a4,a5
     27e:	fd442783          	lw	a5,-44(s0)
     282:	2781                	sext.w	a5,a5
     284:	f8f74de3          	blt	a4,a5,21e <gets+0x18>
     288:	a011                	j	28c <gets+0x86>
      break;
     28a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     28c:	fec42783          	lw	a5,-20(s0)
     290:	fd843703          	ld	a4,-40(s0)
     294:	97ba                	add	a5,a5,a4
     296:	00078023          	sb	zero,0(a5)
  return buf;
     29a:	fd843783          	ld	a5,-40(s0)
}
     29e:	853e                	mv	a0,a5
     2a0:	70a2                	ld	ra,40(sp)
     2a2:	7402                	ld	s0,32(sp)
     2a4:	6145                	addi	sp,sp,48
     2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
     2a8:	7179                	addi	sp,sp,-48
     2aa:	f406                	sd	ra,40(sp)
     2ac:	f022                	sd	s0,32(sp)
     2ae:	1800                	addi	s0,sp,48
     2b0:	fca43c23          	sd	a0,-40(s0)
     2b4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2b8:	4581                	li	a1,0
     2ba:	fd843503          	ld	a0,-40(s0)
     2be:	00000097          	auipc	ra,0x0
     2c2:	288080e7          	jalr	648(ra) # 546 <open>
     2c6:	87aa                	mv	a5,a0
     2c8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     2cc:	fec42783          	lw	a5,-20(s0)
     2d0:	2781                	sext.w	a5,a5
     2d2:	0007d463          	bgez	a5,2da <stat+0x32>
    return -1;
     2d6:	57fd                	li	a5,-1
     2d8:	a035                	j	304 <stat+0x5c>
  r = fstat(fd, st);
     2da:	fec42783          	lw	a5,-20(s0)
     2de:	fd043583          	ld	a1,-48(s0)
     2e2:	853e                	mv	a0,a5
     2e4:	00000097          	auipc	ra,0x0
     2e8:	27a080e7          	jalr	634(ra) # 55e <fstat>
     2ec:	87aa                	mv	a5,a0
     2ee:	fef42423          	sw	a5,-24(s0)
  close(fd);
     2f2:	fec42783          	lw	a5,-20(s0)
     2f6:	853e                	mv	a0,a5
     2f8:	00000097          	auipc	ra,0x0
     2fc:	236080e7          	jalr	566(ra) # 52e <close>
  return r;
     300:	fe842783          	lw	a5,-24(s0)
}
     304:	853e                	mv	a0,a5
     306:	70a2                	ld	ra,40(sp)
     308:	7402                	ld	s0,32(sp)
     30a:	6145                	addi	sp,sp,48
     30c:	8082                	ret

000000000000030e <atoi>:

int
atoi(const char *s)
{
     30e:	7179                	addi	sp,sp,-48
     310:	f422                	sd	s0,40(sp)
     312:	1800                	addi	s0,sp,48
     314:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     318:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     31c:	a815                	j	350 <atoi+0x42>
    n = n*10 + *s++ - '0';
     31e:	fec42703          	lw	a4,-20(s0)
     322:	87ba                	mv	a5,a4
     324:	0027979b          	slliw	a5,a5,0x2
     328:	9fb9                	addw	a5,a5,a4
     32a:	0017979b          	slliw	a5,a5,0x1
     32e:	0007871b          	sext.w	a4,a5
     332:	fd843783          	ld	a5,-40(s0)
     336:	00178693          	addi	a3,a5,1
     33a:	fcd43c23          	sd	a3,-40(s0)
     33e:	0007c783          	lbu	a5,0(a5)
     342:	2781                	sext.w	a5,a5
     344:	9fb9                	addw	a5,a5,a4
     346:	2781                	sext.w	a5,a5
     348:	fd07879b          	addiw	a5,a5,-48
     34c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     350:	fd843783          	ld	a5,-40(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	873e                	mv	a4,a5
     35a:	02f00793          	li	a5,47
     35e:	00e7fb63          	bgeu	a5,a4,374 <atoi+0x66>
     362:	fd843783          	ld	a5,-40(s0)
     366:	0007c783          	lbu	a5,0(a5)
     36a:	873e                	mv	a4,a5
     36c:	03900793          	li	a5,57
     370:	fae7f7e3          	bgeu	a5,a4,31e <atoi+0x10>
  return n;
     374:	fec42783          	lw	a5,-20(s0)
}
     378:	853e                	mv	a0,a5
     37a:	7422                	ld	s0,40(sp)
     37c:	6145                	addi	sp,sp,48
     37e:	8082                	ret

0000000000000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     380:	7139                	addi	sp,sp,-64
     382:	fc22                	sd	s0,56(sp)
     384:	0080                	addi	s0,sp,64
     386:	fca43c23          	sd	a0,-40(s0)
     38a:	fcb43823          	sd	a1,-48(s0)
     38e:	87b2                	mv	a5,a2
     390:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     394:	fd843783          	ld	a5,-40(s0)
     398:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     39c:	fd043783          	ld	a5,-48(s0)
     3a0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3a4:	fe043703          	ld	a4,-32(s0)
     3a8:	fe843783          	ld	a5,-24(s0)
     3ac:	02e7fc63          	bgeu	a5,a4,3e4 <memmove+0x64>
    while(n-- > 0)
     3b0:	a00d                	j	3d2 <memmove+0x52>
      *dst++ = *src++;
     3b2:	fe043703          	ld	a4,-32(s0)
     3b6:	00170793          	addi	a5,a4,1
     3ba:	fef43023          	sd	a5,-32(s0)
     3be:	fe843783          	ld	a5,-24(s0)
     3c2:	00178693          	addi	a3,a5,1
     3c6:	fed43423          	sd	a3,-24(s0)
     3ca:	00074703          	lbu	a4,0(a4)
     3ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3d2:	fcc42783          	lw	a5,-52(s0)
     3d6:	fff7871b          	addiw	a4,a5,-1
     3da:	fce42623          	sw	a4,-52(s0)
     3de:	fcf04ae3          	bgtz	a5,3b2 <memmove+0x32>
     3e2:	a891                	j	436 <memmove+0xb6>
  } else {
    dst += n;
     3e4:	fcc42783          	lw	a5,-52(s0)
     3e8:	fe843703          	ld	a4,-24(s0)
     3ec:	97ba                	add	a5,a5,a4
     3ee:	fef43423          	sd	a5,-24(s0)
    src += n;
     3f2:	fcc42783          	lw	a5,-52(s0)
     3f6:	fe043703          	ld	a4,-32(s0)
     3fa:	97ba                	add	a5,a5,a4
     3fc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     400:	a01d                	j	426 <memmove+0xa6>
      *--dst = *--src;
     402:	fe043783          	ld	a5,-32(s0)
     406:	17fd                	addi	a5,a5,-1
     408:	fef43023          	sd	a5,-32(s0)
     40c:	fe843783          	ld	a5,-24(s0)
     410:	17fd                	addi	a5,a5,-1
     412:	fef43423          	sd	a5,-24(s0)
     416:	fe043783          	ld	a5,-32(s0)
     41a:	0007c703          	lbu	a4,0(a5)
     41e:	fe843783          	ld	a5,-24(s0)
     422:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fff7871b          	addiw	a4,a5,-1
     42e:	fce42623          	sw	a4,-52(s0)
     432:	fcf048e3          	bgtz	a5,402 <memmove+0x82>
  }
  return vdst;
     436:	fd843783          	ld	a5,-40(s0)
}
     43a:	853e                	mv	a0,a5
     43c:	7462                	ld	s0,56(sp)
     43e:	6121                	addi	sp,sp,64
     440:	8082                	ret

0000000000000442 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     442:	7139                	addi	sp,sp,-64
     444:	fc22                	sd	s0,56(sp)
     446:	0080                	addi	s0,sp,64
     448:	fca43c23          	sd	a0,-40(s0)
     44c:	fcb43823          	sd	a1,-48(s0)
     450:	87b2                	mv	a5,a2
     452:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     456:	fd843783          	ld	a5,-40(s0)
     45a:	fef43423          	sd	a5,-24(s0)
     45e:	fd043783          	ld	a5,-48(s0)
     462:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     466:	a0a1                	j	4ae <memcmp+0x6c>
    if (*p1 != *p2) {
     468:	fe843783          	ld	a5,-24(s0)
     46c:	0007c703          	lbu	a4,0(a5)
     470:	fe043783          	ld	a5,-32(s0)
     474:	0007c783          	lbu	a5,0(a5)
     478:	02f70163          	beq	a4,a5,49a <memcmp+0x58>
      return *p1 - *p2;
     47c:	fe843783          	ld	a5,-24(s0)
     480:	0007c783          	lbu	a5,0(a5)
     484:	0007871b          	sext.w	a4,a5
     488:	fe043783          	ld	a5,-32(s0)
     48c:	0007c783          	lbu	a5,0(a5)
     490:	2781                	sext.w	a5,a5
     492:	40f707bb          	subw	a5,a4,a5
     496:	2781                	sext.w	a5,a5
     498:	a01d                	j	4be <memcmp+0x7c>
    }
    p1++;
     49a:	fe843783          	ld	a5,-24(s0)
     49e:	0785                	addi	a5,a5,1
     4a0:	fef43423          	sd	a5,-24(s0)
    p2++;
     4a4:	fe043783          	ld	a5,-32(s0)
     4a8:	0785                	addi	a5,a5,1
     4aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4ae:	fcc42783          	lw	a5,-52(s0)
     4b2:	fff7871b          	addiw	a4,a5,-1
     4b6:	fce42623          	sw	a4,-52(s0)
     4ba:	f7dd                	bnez	a5,468 <memcmp+0x26>
  }
  return 0;
     4bc:	4781                	li	a5,0
}
     4be:	853e                	mv	a0,a5
     4c0:	7462                	ld	s0,56(sp)
     4c2:	6121                	addi	sp,sp,64
     4c4:	8082                	ret

00000000000004c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4c6:	7179                	addi	sp,sp,-48
     4c8:	f406                	sd	ra,40(sp)
     4ca:	f022                	sd	s0,32(sp)
     4cc:	1800                	addi	s0,sp,48
     4ce:	fea43423          	sd	a0,-24(s0)
     4d2:	feb43023          	sd	a1,-32(s0)
     4d6:	87b2                	mv	a5,a2
     4d8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     4dc:	fdc42783          	lw	a5,-36(s0)
     4e0:	863e                	mv	a2,a5
     4e2:	fe043583          	ld	a1,-32(s0)
     4e6:	fe843503          	ld	a0,-24(s0)
     4ea:	00000097          	auipc	ra,0x0
     4ee:	e96080e7          	jalr	-362(ra) # 380 <memmove>
     4f2:	87aa                	mv	a5,a0
}
     4f4:	853e                	mv	a0,a5
     4f6:	70a2                	ld	ra,40(sp)
     4f8:	7402                	ld	s0,32(sp)
     4fa:	6145                	addi	sp,sp,48
     4fc:	8082                	ret

00000000000004fe <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     4fe:	4885                	li	a7,1
 ecall
     500:	00000073          	ecall
 ret
     504:	8082                	ret

0000000000000506 <exit>:
.global exit
exit:
 li a7, SYS_exit
     506:	4889                	li	a7,2
 ecall
     508:	00000073          	ecall
 ret
     50c:	8082                	ret

000000000000050e <wait>:
.global wait
wait:
 li a7, SYS_wait
     50e:	488d                	li	a7,3
 ecall
     510:	00000073          	ecall
 ret
     514:	8082                	ret

0000000000000516 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     516:	4891                	li	a7,4
 ecall
     518:	00000073          	ecall
 ret
     51c:	8082                	ret

000000000000051e <read>:
.global read
read:
 li a7, SYS_read
     51e:	4895                	li	a7,5
 ecall
     520:	00000073          	ecall
 ret
     524:	8082                	ret

0000000000000526 <write>:
.global write
write:
 li a7, SYS_write
     526:	48c1                	li	a7,16
 ecall
     528:	00000073          	ecall
 ret
     52c:	8082                	ret

000000000000052e <close>:
.global close
close:
 li a7, SYS_close
     52e:	48d5                	li	a7,21
 ecall
     530:	00000073          	ecall
 ret
     534:	8082                	ret

0000000000000536 <kill>:
.global kill
kill:
 li a7, SYS_kill
     536:	4899                	li	a7,6
 ecall
     538:	00000073          	ecall
 ret
     53c:	8082                	ret

000000000000053e <exec>:
.global exec
exec:
 li a7, SYS_exec
     53e:	489d                	li	a7,7
 ecall
     540:	00000073          	ecall
 ret
     544:	8082                	ret

0000000000000546 <open>:
.global open
open:
 li a7, SYS_open
     546:	48bd                	li	a7,15
 ecall
     548:	00000073          	ecall
 ret
     54c:	8082                	ret

000000000000054e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     54e:	48c5                	li	a7,17
 ecall
     550:	00000073          	ecall
 ret
     554:	8082                	ret

0000000000000556 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     556:	48c9                	li	a7,18
 ecall
     558:	00000073          	ecall
 ret
     55c:	8082                	ret

000000000000055e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     55e:	48a1                	li	a7,8
 ecall
     560:	00000073          	ecall
 ret
     564:	8082                	ret

0000000000000566 <link>:
.global link
link:
 li a7, SYS_link
     566:	48cd                	li	a7,19
 ecall
     568:	00000073          	ecall
 ret
     56c:	8082                	ret

000000000000056e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     56e:	48d1                	li	a7,20
 ecall
     570:	00000073          	ecall
 ret
     574:	8082                	ret

0000000000000576 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     576:	48a5                	li	a7,9
 ecall
     578:	00000073          	ecall
 ret
     57c:	8082                	ret

000000000000057e <dup>:
.global dup
dup:
 li a7, SYS_dup
     57e:	48a9                	li	a7,10
 ecall
     580:	00000073          	ecall
 ret
     584:	8082                	ret

0000000000000586 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     586:	48ad                	li	a7,11
 ecall
     588:	00000073          	ecall
 ret
     58c:	8082                	ret

000000000000058e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     58e:	48b1                	li	a7,12
 ecall
     590:	00000073          	ecall
 ret
     594:	8082                	ret

0000000000000596 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     596:	48b5                	li	a7,13
 ecall
     598:	00000073          	ecall
 ret
     59c:	8082                	ret

000000000000059e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     59e:	48b9                	li	a7,14
 ecall
     5a0:	00000073          	ecall
 ret
     5a4:	8082                	ret

00000000000005a6 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5a6:	48d9                	li	a7,22
 ecall
     5a8:	00000073          	ecall
 ret
     5ac:	8082                	ret

00000000000005ae <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5ae:	48dd                	li	a7,23
 ecall
     5b0:	00000073          	ecall
 ret
     5b4:	8082                	ret

00000000000005b6 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5b6:	48e1                	li	a7,24
 ecall
     5b8:	00000073          	ecall
 ret
     5bc:	8082                	ret

00000000000005be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5be:	1101                	addi	sp,sp,-32
     5c0:	ec06                	sd	ra,24(sp)
     5c2:	e822                	sd	s0,16(sp)
     5c4:	1000                	addi	s0,sp,32
     5c6:	87aa                	mv	a5,a0
     5c8:	872e                	mv	a4,a1
     5ca:	fef42623          	sw	a5,-20(s0)
     5ce:	87ba                	mv	a5,a4
     5d0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     5d4:	feb40713          	addi	a4,s0,-21
     5d8:	fec42783          	lw	a5,-20(s0)
     5dc:	4605                	li	a2,1
     5de:	85ba                	mv	a1,a4
     5e0:	853e                	mv	a0,a5
     5e2:	00000097          	auipc	ra,0x0
     5e6:	f44080e7          	jalr	-188(ra) # 526 <write>
}
     5ea:	0001                	nop
     5ec:	60e2                	ld	ra,24(sp)
     5ee:	6442                	ld	s0,16(sp)
     5f0:	6105                	addi	sp,sp,32
     5f2:	8082                	ret

00000000000005f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5f4:	7139                	addi	sp,sp,-64
     5f6:	fc06                	sd	ra,56(sp)
     5f8:	f822                	sd	s0,48(sp)
     5fa:	0080                	addi	s0,sp,64
     5fc:	87aa                	mv	a5,a0
     5fe:	8736                	mv	a4,a3
     600:	fcf42623          	sw	a5,-52(s0)
     604:	87ae                	mv	a5,a1
     606:	fcf42423          	sw	a5,-56(s0)
     60a:	87b2                	mv	a5,a2
     60c:	fcf42223          	sw	a5,-60(s0)
     610:	87ba                	mv	a5,a4
     612:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     616:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     61a:	fc042783          	lw	a5,-64(s0)
     61e:	2781                	sext.w	a5,a5
     620:	c38d                	beqz	a5,642 <printint+0x4e>
     622:	fc842783          	lw	a5,-56(s0)
     626:	2781                	sext.w	a5,a5
     628:	0007dd63          	bgez	a5,642 <printint+0x4e>
    neg = 1;
     62c:	4785                	li	a5,1
     62e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     632:	fc842783          	lw	a5,-56(s0)
     636:	40f007bb          	negw	a5,a5
     63a:	2781                	sext.w	a5,a5
     63c:	fef42223          	sw	a5,-28(s0)
     640:	a029                	j	64a <printint+0x56>
  } else {
    x = xx;
     642:	fc842783          	lw	a5,-56(s0)
     646:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     64a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     64e:	fc442783          	lw	a5,-60(s0)
     652:	fe442703          	lw	a4,-28(s0)
     656:	02f777bb          	remuw	a5,a4,a5
     65a:	0007861b          	sext.w	a2,a5
     65e:	fec42783          	lw	a5,-20(s0)
     662:	0017871b          	addiw	a4,a5,1
     666:	fee42623          	sw	a4,-20(s0)
     66a:	00001697          	auipc	a3,0x1
     66e:	c5668693          	addi	a3,a3,-938 # 12c0 <digits>
     672:	02061713          	slli	a4,a2,0x20
     676:	9301                	srli	a4,a4,0x20
     678:	9736                	add	a4,a4,a3
     67a:	00074703          	lbu	a4,0(a4)
     67e:	ff040693          	addi	a3,s0,-16
     682:	97b6                	add	a5,a5,a3
     684:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     688:	fc442783          	lw	a5,-60(s0)
     68c:	fe442703          	lw	a4,-28(s0)
     690:	02f757bb          	divuw	a5,a4,a5
     694:	fef42223          	sw	a5,-28(s0)
     698:	fe442783          	lw	a5,-28(s0)
     69c:	2781                	sext.w	a5,a5
     69e:	fbc5                	bnez	a5,64e <printint+0x5a>
  if(neg)
     6a0:	fe842783          	lw	a5,-24(s0)
     6a4:	2781                	sext.w	a5,a5
     6a6:	cf95                	beqz	a5,6e2 <printint+0xee>
    buf[i++] = '-';
     6a8:	fec42783          	lw	a5,-20(s0)
     6ac:	0017871b          	addiw	a4,a5,1
     6b0:	fee42623          	sw	a4,-20(s0)
     6b4:	ff040713          	addi	a4,s0,-16
     6b8:	97ba                	add	a5,a5,a4
     6ba:	02d00713          	li	a4,45
     6be:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6c2:	a005                	j	6e2 <printint+0xee>
    putc(fd, buf[i]);
     6c4:	fec42783          	lw	a5,-20(s0)
     6c8:	ff040713          	addi	a4,s0,-16
     6cc:	97ba                	add	a5,a5,a4
     6ce:	fe07c703          	lbu	a4,-32(a5)
     6d2:	fcc42783          	lw	a5,-52(s0)
     6d6:	85ba                	mv	a1,a4
     6d8:	853e                	mv	a0,a5
     6da:	00000097          	auipc	ra,0x0
     6de:	ee4080e7          	jalr	-284(ra) # 5be <putc>
  while(--i >= 0)
     6e2:	fec42783          	lw	a5,-20(s0)
     6e6:	37fd                	addiw	a5,a5,-1
     6e8:	fef42623          	sw	a5,-20(s0)
     6ec:	fec42783          	lw	a5,-20(s0)
     6f0:	2781                	sext.w	a5,a5
     6f2:	fc07d9e3          	bgez	a5,6c4 <printint+0xd0>
}
     6f6:	0001                	nop
     6f8:	0001                	nop
     6fa:	70e2                	ld	ra,56(sp)
     6fc:	7442                	ld	s0,48(sp)
     6fe:	6121                	addi	sp,sp,64
     700:	8082                	ret

0000000000000702 <printptr>:

static void
printptr(int fd, uint64 x) {
     702:	7179                	addi	sp,sp,-48
     704:	f406                	sd	ra,40(sp)
     706:	f022                	sd	s0,32(sp)
     708:	1800                	addi	s0,sp,48
     70a:	87aa                	mv	a5,a0
     70c:	fcb43823          	sd	a1,-48(s0)
     710:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     714:	fdc42783          	lw	a5,-36(s0)
     718:	03000593          	li	a1,48
     71c:	853e                	mv	a0,a5
     71e:	00000097          	auipc	ra,0x0
     722:	ea0080e7          	jalr	-352(ra) # 5be <putc>
  putc(fd, 'x');
     726:	fdc42783          	lw	a5,-36(s0)
     72a:	07800593          	li	a1,120
     72e:	853e                	mv	a0,a5
     730:	00000097          	auipc	ra,0x0
     734:	e8e080e7          	jalr	-370(ra) # 5be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     738:	fe042623          	sw	zero,-20(s0)
     73c:	a82d                	j	776 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     73e:	fd043783          	ld	a5,-48(s0)
     742:	93f1                	srli	a5,a5,0x3c
     744:	00001717          	auipc	a4,0x1
     748:	b7c70713          	addi	a4,a4,-1156 # 12c0 <digits>
     74c:	97ba                	add	a5,a5,a4
     74e:	0007c703          	lbu	a4,0(a5)
     752:	fdc42783          	lw	a5,-36(s0)
     756:	85ba                	mv	a1,a4
     758:	853e                	mv	a0,a5
     75a:	00000097          	auipc	ra,0x0
     75e:	e64080e7          	jalr	-412(ra) # 5be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     762:	fec42783          	lw	a5,-20(s0)
     766:	2785                	addiw	a5,a5,1
     768:	fef42623          	sw	a5,-20(s0)
     76c:	fd043783          	ld	a5,-48(s0)
     770:	0792                	slli	a5,a5,0x4
     772:	fcf43823          	sd	a5,-48(s0)
     776:	fec42783          	lw	a5,-20(s0)
     77a:	873e                	mv	a4,a5
     77c:	47bd                	li	a5,15
     77e:	fce7f0e3          	bgeu	a5,a4,73e <printptr+0x3c>
}
     782:	0001                	nop
     784:	0001                	nop
     786:	70a2                	ld	ra,40(sp)
     788:	7402                	ld	s0,32(sp)
     78a:	6145                	addi	sp,sp,48
     78c:	8082                	ret

000000000000078e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     78e:	715d                	addi	sp,sp,-80
     790:	e486                	sd	ra,72(sp)
     792:	e0a2                	sd	s0,64(sp)
     794:	0880                	addi	s0,sp,80
     796:	87aa                	mv	a5,a0
     798:	fcb43023          	sd	a1,-64(s0)
     79c:	fac43c23          	sd	a2,-72(s0)
     7a0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7a4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7a8:	fe042223          	sw	zero,-28(s0)
     7ac:	a42d                	j	9d6 <vprintf+0x248>
    c = fmt[i] & 0xff;
     7ae:	fe442783          	lw	a5,-28(s0)
     7b2:	fc043703          	ld	a4,-64(s0)
     7b6:	97ba                	add	a5,a5,a4
     7b8:	0007c783          	lbu	a5,0(a5)
     7bc:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7c0:	fe042783          	lw	a5,-32(s0)
     7c4:	2781                	sext.w	a5,a5
     7c6:	eb9d                	bnez	a5,7fc <vprintf+0x6e>
      if(c == '%'){
     7c8:	fdc42783          	lw	a5,-36(s0)
     7cc:	0007871b          	sext.w	a4,a5
     7d0:	02500793          	li	a5,37
     7d4:	00f71763          	bne	a4,a5,7e2 <vprintf+0x54>
        state = '%';
     7d8:	02500793          	li	a5,37
     7dc:	fef42023          	sw	a5,-32(s0)
     7e0:	a2f5                	j	9cc <vprintf+0x23e>
      } else {
        putc(fd, c);
     7e2:	fdc42783          	lw	a5,-36(s0)
     7e6:	0ff7f713          	andi	a4,a5,255
     7ea:	fcc42783          	lw	a5,-52(s0)
     7ee:	85ba                	mv	a1,a4
     7f0:	853e                	mv	a0,a5
     7f2:	00000097          	auipc	ra,0x0
     7f6:	dcc080e7          	jalr	-564(ra) # 5be <putc>
     7fa:	aac9                	j	9cc <vprintf+0x23e>
      }
    } else if(state == '%'){
     7fc:	fe042783          	lw	a5,-32(s0)
     800:	0007871b          	sext.w	a4,a5
     804:	02500793          	li	a5,37
     808:	1cf71263          	bne	a4,a5,9cc <vprintf+0x23e>
      if(c == 'd'){
     80c:	fdc42783          	lw	a5,-36(s0)
     810:	0007871b          	sext.w	a4,a5
     814:	06400793          	li	a5,100
     818:	02f71463          	bne	a4,a5,840 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     81c:	fb843783          	ld	a5,-72(s0)
     820:	00878713          	addi	a4,a5,8
     824:	fae43c23          	sd	a4,-72(s0)
     828:	4398                	lw	a4,0(a5)
     82a:	fcc42783          	lw	a5,-52(s0)
     82e:	4685                	li	a3,1
     830:	4629                	li	a2,10
     832:	85ba                	mv	a1,a4
     834:	853e                	mv	a0,a5
     836:	00000097          	auipc	ra,0x0
     83a:	dbe080e7          	jalr	-578(ra) # 5f4 <printint>
     83e:	a269                	j	9c8 <vprintf+0x23a>
      } else if(c == 'l') {
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	06c00793          	li	a5,108
     84c:	02f71663          	bne	a4,a5,878 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     850:	fb843783          	ld	a5,-72(s0)
     854:	00878713          	addi	a4,a5,8
     858:	fae43c23          	sd	a4,-72(s0)
     85c:	639c                	ld	a5,0(a5)
     85e:	0007871b          	sext.w	a4,a5
     862:	fcc42783          	lw	a5,-52(s0)
     866:	4681                	li	a3,0
     868:	4629                	li	a2,10
     86a:	85ba                	mv	a1,a4
     86c:	853e                	mv	a0,a5
     86e:	00000097          	auipc	ra,0x0
     872:	d86080e7          	jalr	-634(ra) # 5f4 <printint>
     876:	aa89                	j	9c8 <vprintf+0x23a>
      } else if(c == 'x') {
     878:	fdc42783          	lw	a5,-36(s0)
     87c:	0007871b          	sext.w	a4,a5
     880:	07800793          	li	a5,120
     884:	02f71463          	bne	a4,a5,8ac <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     888:	fb843783          	ld	a5,-72(s0)
     88c:	00878713          	addi	a4,a5,8
     890:	fae43c23          	sd	a4,-72(s0)
     894:	4398                	lw	a4,0(a5)
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	4681                	li	a3,0
     89c:	4641                	li	a2,16
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	d52080e7          	jalr	-686(ra) # 5f4 <printint>
     8aa:	aa39                	j	9c8 <vprintf+0x23a>
      } else if(c == 'p') {
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	07000793          	li	a5,112
     8b8:	02f71263          	bne	a4,a5,8dc <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8bc:	fb843783          	ld	a5,-72(s0)
     8c0:	00878713          	addi	a4,a5,8
     8c4:	fae43c23          	sd	a4,-72(s0)
     8c8:	6398                	ld	a4,0(a5)
     8ca:	fcc42783          	lw	a5,-52(s0)
     8ce:	85ba                	mv	a1,a4
     8d0:	853e                	mv	a0,a5
     8d2:	00000097          	auipc	ra,0x0
     8d6:	e30080e7          	jalr	-464(ra) # 702 <printptr>
     8da:	a0fd                	j	9c8 <vprintf+0x23a>
      } else if(c == 's'){
     8dc:	fdc42783          	lw	a5,-36(s0)
     8e0:	0007871b          	sext.w	a4,a5
     8e4:	07300793          	li	a5,115
     8e8:	04f71c63          	bne	a4,a5,940 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     8ec:	fb843783          	ld	a5,-72(s0)
     8f0:	00878713          	addi	a4,a5,8
     8f4:	fae43c23          	sd	a4,-72(s0)
     8f8:	639c                	ld	a5,0(a5)
     8fa:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     8fe:	fe843783          	ld	a5,-24(s0)
     902:	eb8d                	bnez	a5,934 <vprintf+0x1a6>
          s = "(null)";
     904:	00001797          	auipc	a5,0x1
     908:	9b478793          	addi	a5,a5,-1612 # 12b8 <schedule_edf_cbs+0x412>
     90c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     910:	a015                	j	934 <vprintf+0x1a6>
          putc(fd, *s);
     912:	fe843783          	ld	a5,-24(s0)
     916:	0007c703          	lbu	a4,0(a5)
     91a:	fcc42783          	lw	a5,-52(s0)
     91e:	85ba                	mv	a1,a4
     920:	853e                	mv	a0,a5
     922:	00000097          	auipc	ra,0x0
     926:	c9c080e7          	jalr	-868(ra) # 5be <putc>
          s++;
     92a:	fe843783          	ld	a5,-24(s0)
     92e:	0785                	addi	a5,a5,1
     930:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     934:	fe843783          	ld	a5,-24(s0)
     938:	0007c783          	lbu	a5,0(a5)
     93c:	fbf9                	bnez	a5,912 <vprintf+0x184>
     93e:	a069                	j	9c8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     940:	fdc42783          	lw	a5,-36(s0)
     944:	0007871b          	sext.w	a4,a5
     948:	06300793          	li	a5,99
     94c:	02f71463          	bne	a4,a5,974 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     950:	fb843783          	ld	a5,-72(s0)
     954:	00878713          	addi	a4,a5,8
     958:	fae43c23          	sd	a4,-72(s0)
     95c:	439c                	lw	a5,0(a5)
     95e:	0ff7f713          	andi	a4,a5,255
     962:	fcc42783          	lw	a5,-52(s0)
     966:	85ba                	mv	a1,a4
     968:	853e                	mv	a0,a5
     96a:	00000097          	auipc	ra,0x0
     96e:	c54080e7          	jalr	-940(ra) # 5be <putc>
     972:	a899                	j	9c8 <vprintf+0x23a>
      } else if(c == '%'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	02500793          	li	a5,37
     980:	00f71f63          	bne	a4,a5,99e <vprintf+0x210>
        putc(fd, c);
     984:	fdc42783          	lw	a5,-36(s0)
     988:	0ff7f713          	andi	a4,a5,255
     98c:	fcc42783          	lw	a5,-52(s0)
     990:	85ba                	mv	a1,a4
     992:	853e                	mv	a0,a5
     994:	00000097          	auipc	ra,0x0
     998:	c2a080e7          	jalr	-982(ra) # 5be <putc>
     99c:	a035                	j	9c8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	02500593          	li	a1,37
     9a6:	853e                	mv	a0,a5
     9a8:	00000097          	auipc	ra,0x0
     9ac:	c16080e7          	jalr	-1002(ra) # 5be <putc>
        putc(fd, c);
     9b0:	fdc42783          	lw	a5,-36(s0)
     9b4:	0ff7f713          	andi	a4,a5,255
     9b8:	fcc42783          	lw	a5,-52(s0)
     9bc:	85ba                	mv	a1,a4
     9be:	853e                	mv	a0,a5
     9c0:	00000097          	auipc	ra,0x0
     9c4:	bfe080e7          	jalr	-1026(ra) # 5be <putc>
      }
      state = 0;
     9c8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9cc:	fe442783          	lw	a5,-28(s0)
     9d0:	2785                	addiw	a5,a5,1
     9d2:	fef42223          	sw	a5,-28(s0)
     9d6:	fe442783          	lw	a5,-28(s0)
     9da:	fc043703          	ld	a4,-64(s0)
     9de:	97ba                	add	a5,a5,a4
     9e0:	0007c783          	lbu	a5,0(a5)
     9e4:	dc0795e3          	bnez	a5,7ae <vprintf+0x20>
    }
  }
}
     9e8:	0001                	nop
     9ea:	0001                	nop
     9ec:	60a6                	ld	ra,72(sp)
     9ee:	6406                	ld	s0,64(sp)
     9f0:	6161                	addi	sp,sp,80
     9f2:	8082                	ret

00000000000009f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     9f4:	7159                	addi	sp,sp,-112
     9f6:	fc06                	sd	ra,56(sp)
     9f8:	f822                	sd	s0,48(sp)
     9fa:	0080                	addi	s0,sp,64
     9fc:	fcb43823          	sd	a1,-48(s0)
     a00:	e010                	sd	a2,0(s0)
     a02:	e414                	sd	a3,8(s0)
     a04:	e818                	sd	a4,16(s0)
     a06:	ec1c                	sd	a5,24(s0)
     a08:	03043023          	sd	a6,32(s0)
     a0c:	03143423          	sd	a7,40(s0)
     a10:	87aa                	mv	a5,a0
     a12:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a16:	03040793          	addi	a5,s0,48
     a1a:	fcf43423          	sd	a5,-56(s0)
     a1e:	fc843783          	ld	a5,-56(s0)
     a22:	fd078793          	addi	a5,a5,-48
     a26:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a2a:	fe843703          	ld	a4,-24(s0)
     a2e:	fdc42783          	lw	a5,-36(s0)
     a32:	863a                	mv	a2,a4
     a34:	fd043583          	ld	a1,-48(s0)
     a38:	853e                	mv	a0,a5
     a3a:	00000097          	auipc	ra,0x0
     a3e:	d54080e7          	jalr	-684(ra) # 78e <vprintf>
}
     a42:	0001                	nop
     a44:	70e2                	ld	ra,56(sp)
     a46:	7442                	ld	s0,48(sp)
     a48:	6165                	addi	sp,sp,112
     a4a:	8082                	ret

0000000000000a4c <printf>:

void
printf(const char *fmt, ...)
{
     a4c:	7159                	addi	sp,sp,-112
     a4e:	f406                	sd	ra,40(sp)
     a50:	f022                	sd	s0,32(sp)
     a52:	1800                	addi	s0,sp,48
     a54:	fca43c23          	sd	a0,-40(s0)
     a58:	e40c                	sd	a1,8(s0)
     a5a:	e810                	sd	a2,16(s0)
     a5c:	ec14                	sd	a3,24(s0)
     a5e:	f018                	sd	a4,32(s0)
     a60:	f41c                	sd	a5,40(s0)
     a62:	03043823          	sd	a6,48(s0)
     a66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a6a:	04040793          	addi	a5,s0,64
     a6e:	fcf43823          	sd	a5,-48(s0)
     a72:	fd043783          	ld	a5,-48(s0)
     a76:	fc878793          	addi	a5,a5,-56
     a7a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a7e:	fe843783          	ld	a5,-24(s0)
     a82:	863e                	mv	a2,a5
     a84:	fd843583          	ld	a1,-40(s0)
     a88:	4505                	li	a0,1
     a8a:	00000097          	auipc	ra,0x0
     a8e:	d04080e7          	jalr	-764(ra) # 78e <vprintf>
}
     a92:	0001                	nop
     a94:	70a2                	ld	ra,40(sp)
     a96:	7402                	ld	s0,32(sp)
     a98:	6165                	addi	sp,sp,112
     a9a:	8082                	ret

0000000000000a9c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a9c:	7179                	addi	sp,sp,-48
     a9e:	f422                	sd	s0,40(sp)
     aa0:	1800                	addi	s0,sp,48
     aa2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     aa6:	fd843783          	ld	a5,-40(s0)
     aaa:	17c1                	addi	a5,a5,-16
     aac:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ab0:	00001797          	auipc	a5,0x1
     ab4:	83878793          	addi	a5,a5,-1992 # 12e8 <freep>
     ab8:	639c                	ld	a5,0(a5)
     aba:	fef43423          	sd	a5,-24(s0)
     abe:	a815                	j	af2 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ac0:	fe843783          	ld	a5,-24(s0)
     ac4:	639c                	ld	a5,0(a5)
     ac6:	fe843703          	ld	a4,-24(s0)
     aca:	00f76f63          	bltu	a4,a5,ae8 <free+0x4c>
     ace:	fe043703          	ld	a4,-32(s0)
     ad2:	fe843783          	ld	a5,-24(s0)
     ad6:	02e7eb63          	bltu	a5,a4,b0c <free+0x70>
     ada:	fe843783          	ld	a5,-24(s0)
     ade:	639c                	ld	a5,0(a5)
     ae0:	fe043703          	ld	a4,-32(s0)
     ae4:	02f76463          	bltu	a4,a5,b0c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ae8:	fe843783          	ld	a5,-24(s0)
     aec:	639c                	ld	a5,0(a5)
     aee:	fef43423          	sd	a5,-24(s0)
     af2:	fe043703          	ld	a4,-32(s0)
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	fce7f3e3          	bgeu	a5,a4,ac0 <free+0x24>
     afe:	fe843783          	ld	a5,-24(s0)
     b02:	639c                	ld	a5,0(a5)
     b04:	fe043703          	ld	a4,-32(s0)
     b08:	faf77ce3          	bgeu	a4,a5,ac0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b0c:	fe043783          	ld	a5,-32(s0)
     b10:	479c                	lw	a5,8(a5)
     b12:	1782                	slli	a5,a5,0x20
     b14:	9381                	srli	a5,a5,0x20
     b16:	0792                	slli	a5,a5,0x4
     b18:	fe043703          	ld	a4,-32(s0)
     b1c:	973e                	add	a4,a4,a5
     b1e:	fe843783          	ld	a5,-24(s0)
     b22:	639c                	ld	a5,0(a5)
     b24:	02f71763          	bne	a4,a5,b52 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b28:	fe043783          	ld	a5,-32(s0)
     b2c:	4798                	lw	a4,8(a5)
     b2e:	fe843783          	ld	a5,-24(s0)
     b32:	639c                	ld	a5,0(a5)
     b34:	479c                	lw	a5,8(a5)
     b36:	9fb9                	addw	a5,a5,a4
     b38:	0007871b          	sext.w	a4,a5
     b3c:	fe043783          	ld	a5,-32(s0)
     b40:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b42:	fe843783          	ld	a5,-24(s0)
     b46:	639c                	ld	a5,0(a5)
     b48:	6398                	ld	a4,0(a5)
     b4a:	fe043783          	ld	a5,-32(s0)
     b4e:	e398                	sd	a4,0(a5)
     b50:	a039                	j	b5e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	6398                	ld	a4,0(a5)
     b58:	fe043783          	ld	a5,-32(s0)
     b5c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b5e:	fe843783          	ld	a5,-24(s0)
     b62:	479c                	lw	a5,8(a5)
     b64:	1782                	slli	a5,a5,0x20
     b66:	9381                	srli	a5,a5,0x20
     b68:	0792                	slli	a5,a5,0x4
     b6a:	fe843703          	ld	a4,-24(s0)
     b6e:	97ba                	add	a5,a5,a4
     b70:	fe043703          	ld	a4,-32(s0)
     b74:	02f71563          	bne	a4,a5,b9e <free+0x102>
    p->s.size += bp->s.size;
     b78:	fe843783          	ld	a5,-24(s0)
     b7c:	4798                	lw	a4,8(a5)
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	479c                	lw	a5,8(a5)
     b84:	9fb9                	addw	a5,a5,a4
     b86:	0007871b          	sext.w	a4,a5
     b8a:	fe843783          	ld	a5,-24(s0)
     b8e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     b90:	fe043783          	ld	a5,-32(s0)
     b94:	6398                	ld	a4,0(a5)
     b96:	fe843783          	ld	a5,-24(s0)
     b9a:	e398                	sd	a4,0(a5)
     b9c:	a031                	j	ba8 <free+0x10c>
  } else
    p->s.ptr = bp;
     b9e:	fe843783          	ld	a5,-24(s0)
     ba2:	fe043703          	ld	a4,-32(s0)
     ba6:	e398                	sd	a4,0(a5)
  freep = p;
     ba8:	00000797          	auipc	a5,0x0
     bac:	74078793          	addi	a5,a5,1856 # 12e8 <freep>
     bb0:	fe843703          	ld	a4,-24(s0)
     bb4:	e398                	sd	a4,0(a5)
}
     bb6:	0001                	nop
     bb8:	7422                	ld	s0,40(sp)
     bba:	6145                	addi	sp,sp,48
     bbc:	8082                	ret

0000000000000bbe <morecore>:

static Header*
morecore(uint nu)
{
     bbe:	7179                	addi	sp,sp,-48
     bc0:	f406                	sd	ra,40(sp)
     bc2:	f022                	sd	s0,32(sp)
     bc4:	1800                	addi	s0,sp,48
     bc6:	87aa                	mv	a5,a0
     bc8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     bcc:	fdc42783          	lw	a5,-36(s0)
     bd0:	0007871b          	sext.w	a4,a5
     bd4:	6785                	lui	a5,0x1
     bd6:	00f77563          	bgeu	a4,a5,be0 <morecore+0x22>
    nu = 4096;
     bda:	6785                	lui	a5,0x1
     bdc:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     be0:	fdc42783          	lw	a5,-36(s0)
     be4:	0047979b          	slliw	a5,a5,0x4
     be8:	2781                	sext.w	a5,a5
     bea:	2781                	sext.w	a5,a5
     bec:	853e                	mv	a0,a5
     bee:	00000097          	auipc	ra,0x0
     bf2:	9a0080e7          	jalr	-1632(ra) # 58e <sbrk>
     bf6:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     bfa:	fe843703          	ld	a4,-24(s0)
     bfe:	57fd                	li	a5,-1
     c00:	00f71463          	bne	a4,a5,c08 <morecore+0x4a>
    return 0;
     c04:	4781                	li	a5,0
     c06:	a03d                	j	c34 <morecore+0x76>
  hp = (Header*)p;
     c08:	fe843783          	ld	a5,-24(s0)
     c0c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c10:	fe043783          	ld	a5,-32(s0)
     c14:	fdc42703          	lw	a4,-36(s0)
     c18:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c1a:	fe043783          	ld	a5,-32(s0)
     c1e:	07c1                	addi	a5,a5,16
     c20:	853e                	mv	a0,a5
     c22:	00000097          	auipc	ra,0x0
     c26:	e7a080e7          	jalr	-390(ra) # a9c <free>
  return freep;
     c2a:	00000797          	auipc	a5,0x0
     c2e:	6be78793          	addi	a5,a5,1726 # 12e8 <freep>
     c32:	639c                	ld	a5,0(a5)
}
     c34:	853e                	mv	a0,a5
     c36:	70a2                	ld	ra,40(sp)
     c38:	7402                	ld	s0,32(sp)
     c3a:	6145                	addi	sp,sp,48
     c3c:	8082                	ret

0000000000000c3e <malloc>:

void*
malloc(uint nbytes)
{
     c3e:	7139                	addi	sp,sp,-64
     c40:	fc06                	sd	ra,56(sp)
     c42:	f822                	sd	s0,48(sp)
     c44:	0080                	addi	s0,sp,64
     c46:	87aa                	mv	a5,a0
     c48:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c4c:	fcc46783          	lwu	a5,-52(s0)
     c50:	07bd                	addi	a5,a5,15
     c52:	8391                	srli	a5,a5,0x4
     c54:	2781                	sext.w	a5,a5
     c56:	2785                	addiw	a5,a5,1
     c58:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c5c:	00000797          	auipc	a5,0x0
     c60:	68c78793          	addi	a5,a5,1676 # 12e8 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43023          	sd	a5,-32(s0)
     c6a:	fe043783          	ld	a5,-32(s0)
     c6e:	ef95                	bnez	a5,caa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c70:	00000797          	auipc	a5,0x0
     c74:	66878793          	addi	a5,a5,1640 # 12d8 <base>
     c78:	fef43023          	sd	a5,-32(s0)
     c7c:	00000797          	auipc	a5,0x0
     c80:	66c78793          	addi	a5,a5,1644 # 12e8 <freep>
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	e398                	sd	a4,0(a5)
     c8a:	00000797          	auipc	a5,0x0
     c8e:	65e78793          	addi	a5,a5,1630 # 12e8 <freep>
     c92:	6398                	ld	a4,0(a5)
     c94:	00000797          	auipc	a5,0x0
     c98:	64478793          	addi	a5,a5,1604 # 12d8 <base>
     c9c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c9e:	00000797          	auipc	a5,0x0
     ca2:	63a78793          	addi	a5,a5,1594 # 12d8 <base>
     ca6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     caa:	fe043783          	ld	a5,-32(s0)
     cae:	639c                	ld	a5,0(a5)
     cb0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cb4:	fe843783          	ld	a5,-24(s0)
     cb8:	4798                	lw	a4,8(a5)
     cba:	fdc42783          	lw	a5,-36(s0)
     cbe:	2781                	sext.w	a5,a5
     cc0:	06f76863          	bltu	a4,a5,d30 <malloc+0xf2>
      if(p->s.size == nunits)
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	4798                	lw	a4,8(a5)
     cca:	fdc42783          	lw	a5,-36(s0)
     cce:	2781                	sext.w	a5,a5
     cd0:	00e79963          	bne	a5,a4,ce2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     cd4:	fe843783          	ld	a5,-24(s0)
     cd8:	6398                	ld	a4,0(a5)
     cda:	fe043783          	ld	a5,-32(s0)
     cde:	e398                	sd	a4,0(a5)
     ce0:	a82d                	j	d1a <malloc+0xdc>
      else {
        p->s.size -= nunits;
     ce2:	fe843783          	ld	a5,-24(s0)
     ce6:	4798                	lw	a4,8(a5)
     ce8:	fdc42783          	lw	a5,-36(s0)
     cec:	40f707bb          	subw	a5,a4,a5
     cf0:	0007871b          	sext.w	a4,a5
     cf4:	fe843783          	ld	a5,-24(s0)
     cf8:	c798                	sw	a4,8(a5)
        p += p->s.size;
     cfa:	fe843783          	ld	a5,-24(s0)
     cfe:	479c                	lw	a5,8(a5)
     d00:	1782                	slli	a5,a5,0x20
     d02:	9381                	srli	a5,a5,0x20
     d04:	0792                	slli	a5,a5,0x4
     d06:	fe843703          	ld	a4,-24(s0)
     d0a:	97ba                	add	a5,a5,a4
     d0c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	fdc42703          	lw	a4,-36(s0)
     d18:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d1a:	00000797          	auipc	a5,0x0
     d1e:	5ce78793          	addi	a5,a5,1486 # 12e8 <freep>
     d22:	fe043703          	ld	a4,-32(s0)
     d26:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	07c1                	addi	a5,a5,16
     d2e:	a091                	j	d72 <malloc+0x134>
    }
    if(p == freep)
     d30:	00000797          	auipc	a5,0x0
     d34:	5b878793          	addi	a5,a5,1464 # 12e8 <freep>
     d38:	639c                	ld	a5,0(a5)
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	02f71063          	bne	a4,a5,d5e <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d42:	fdc42783          	lw	a5,-36(s0)
     d46:	853e                	mv	a0,a5
     d48:	00000097          	auipc	ra,0x0
     d4c:	e76080e7          	jalr	-394(ra) # bbe <morecore>
     d50:	fea43423          	sd	a0,-24(s0)
     d54:	fe843783          	ld	a5,-24(s0)
     d58:	e399                	bnez	a5,d5e <malloc+0x120>
        return 0;
     d5a:	4781                	li	a5,0
     d5c:	a819                	j	d72 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d5e:	fe843783          	ld	a5,-24(s0)
     d62:	fef43023          	sd	a5,-32(s0)
     d66:	fe843783          	ld	a5,-24(s0)
     d6a:	639c                	ld	a5,0(a5)
     d6c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d70:	b791                	j	cb4 <malloc+0x76>
  }
}
     d72:	853e                	mv	a0,a5
     d74:	70e2                	ld	ra,56(sp)
     d76:	7442                	ld	s0,48(sp)
     d78:	6121                	addi	sp,sp,64
     d7a:	8082                	ret

0000000000000d7c <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
     d7c:	7139                	addi	sp,sp,-64
     d7e:	fc22                	sd	s0,56(sp)
     d80:	0080                	addi	s0,sp,64
     d82:	fca43423          	sd	a0,-56(s0)
     d86:	87ae                	mv	a5,a1
     d88:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
     d8c:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
     d90:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     d94:	fc843783          	ld	a5,-56(s0)
     d98:	639c                	ld	a5,0(a5)
     d9a:	fcf43c23          	sd	a5,-40(s0)
     d9e:	fd843783          	ld	a5,-40(s0)
     da2:	fd878793          	addi	a5,a5,-40
     da6:	fef43423          	sd	a5,-24(s0)
     daa:	a881                	j	dfa <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	4fb8                	lw	a4,88(a5)
     db2:	fc442783          	lw	a5,-60(s0)
     db6:	2781                	sext.w	a5,a5
     db8:	02e7c663          	blt	a5,a4,de4 <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
     dbc:	fe043783          	ld	a5,-32(s0)
     dc0:	e791                	bnez	a5,dcc <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
     dc2:	fe843783          	ld	a5,-24(s0)
     dc6:	fef43023          	sd	a5,-32(s0)
     dca:	a829                	j	de4 <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	5fd8                	lw	a4,60(a5)
     dd2:	fe043783          	ld	a5,-32(s0)
     dd6:	5fdc                	lw	a5,60(a5)
     dd8:	00f75663          	bge	a4,a5,de4 <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
     ddc:	fe843783          	ld	a5,-24(s0)
     de0:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     de4:	fe843783          	ld	a5,-24(s0)
     de8:	779c                	ld	a5,40(a5)
     dea:	fcf43823          	sd	a5,-48(s0)
     dee:	fd043783          	ld	a5,-48(s0)
     df2:	fd878793          	addi	a5,a5,-40
     df6:	fef43423          	sd	a5,-24(s0)
     dfa:	fe843783          	ld	a5,-24(s0)
     dfe:	02878793          	addi	a5,a5,40
     e02:	fc843703          	ld	a4,-56(s0)
     e06:	faf713e3          	bne	a4,a5,dac <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
     e0a:	fe043783          	ld	a5,-32(s0)
}
     e0e:	853e                	mv	a0,a5
     e10:	7462                	ld	s0,56(sp)
     e12:	6121                	addi	sp,sp,64
     e14:	8082                	ret

0000000000000e16 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
     e16:	1101                	addi	sp,sp,-32
     e18:	ec22                	sd	s0,24(sp)
     e1a:	1000                	addi	s0,sp,32
     e1c:	fea43423          	sd	a0,-24(s0)
     e20:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	57fc                	lw	a5,108(a5)
     e2a:	c799                	beqz	a5,e38 <__edf_thread_cmp+0x22>
     e2c:	fe043783          	ld	a5,-32(s0)
     e30:	57fc                	lw	a5,108(a5)
     e32:	e399                	bnez	a5,e38 <__edf_thread_cmp+0x22>
     e34:	57fd                	li	a5,-1
     e36:	a0a5                	j	e9e <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
     e38:	fe843783          	ld	a5,-24(s0)
     e3c:	57fc                	lw	a5,108(a5)
     e3e:	e799                	bnez	a5,e4c <__edf_thread_cmp+0x36>
     e40:	fe043783          	ld	a5,-32(s0)
     e44:	57fc                	lw	a5,108(a5)
     e46:	c399                	beqz	a5,e4c <__edf_thread_cmp+0x36>
     e48:	4785                	li	a5,1
     e4a:	a891                	j	e9e <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	4fb8                	lw	a4,88(a5)
     e52:	fe043783          	ld	a5,-32(s0)
     e56:	4fbc                	lw	a5,88(a5)
     e58:	00f75463          	bge	a4,a5,e60 <__edf_thread_cmp+0x4a>
     e5c:	57fd                	li	a5,-1
     e5e:	a081                	j	e9e <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	4fb8                	lw	a4,88(a5)
     e66:	fe043783          	ld	a5,-32(s0)
     e6a:	4fbc                	lw	a5,88(a5)
     e6c:	00e7d463          	bge	a5,a4,e74 <__edf_thread_cmp+0x5e>
     e70:	4785                	li	a5,1
     e72:	a035                	j	e9e <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
     e74:	fe843783          	ld	a5,-24(s0)
     e78:	5fd8                	lw	a4,60(a5)
     e7a:	fe043783          	ld	a5,-32(s0)
     e7e:	5fdc                	lw	a5,60(a5)
     e80:	00f75463          	bge	a4,a5,e88 <__edf_thread_cmp+0x72>
     e84:	57fd                	li	a5,-1
     e86:	a821                	j	e9e <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
     e88:	fe843783          	ld	a5,-24(s0)
     e8c:	5fd8                	lw	a4,60(a5)
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	5fdc                	lw	a5,60(a5)
     e94:	00e7d463          	bge	a5,a4,e9c <__edf_thread_cmp+0x86>
     e98:	4785                	li	a5,1
     e9a:	a011                	j	e9e <__edf_thread_cmp+0x88>
    
    return 0;
     e9c:	4781                	li	a5,0
}
     e9e:	853e                	mv	a0,a5
     ea0:	6462                	ld	s0,24(sp)
     ea2:	6105                	addi	sp,sp,32
     ea4:	8082                	ret

0000000000000ea6 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
     ea6:	7151                	addi	sp,sp,-240
     ea8:	f586                	sd	ra,232(sp)
     eaa:	f1a2                	sd	s0,224(sp)
     eac:	eda6                	sd	s1,216(sp)
     eae:	e9ca                	sd	s2,208(sp)
     eb0:	e5ce                	sd	s3,200(sp)
     eb2:	1980                	addi	s0,sp,240
     eb4:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
     eb6:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
     eba:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
     ebe:	649c                	ld	a5,8(s1)
     ec0:	639c                	ld	a5,0(a5)
     ec2:	f8f43c23          	sd	a5,-104(s0)
     ec6:	f9843783          	ld	a5,-104(s0)
     eca:	fd878793          	addi	a5,a5,-40
     ece:	fcf43423          	sd	a5,-56(s0)
     ed2:	a8b1                	j	f2e <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     ed4:	fc843783          	ld	a5,-56(s0)
     ed8:	57bc                	lw	a5,104(a5)
     eda:	02f04f63          	bgtz	a5,f18 <schedule_edf_cbs+0x72>
     ede:	fc843783          	ld	a5,-56(s0)
     ee2:	4bfc                	lw	a5,84(a5)
     ee4:	02f05a63          	blez	a5,f18 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
     ee8:	4098                	lw	a4,0(s1)
     eea:	fc843783          	ld	a5,-56(s0)
     eee:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     ef0:	02f71463          	bne	a4,a5,f18 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
     ef4:	fc843783          	ld	a5,-56(s0)
     ef8:	4fb8                	lw	a4,88(a5)
     efa:	fc843783          	ld	a5,-56(s0)
     efe:	47fc                	lw	a5,76(a5)
     f00:	9fb9                	addw	a5,a5,a4
     f02:	0007871b          	sext.w	a4,a5
     f06:	fc843783          	ld	a5,-56(s0)
     f0a:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
     f0c:	fc843783          	ld	a5,-56(s0)
     f10:	53f8                	lw	a4,100(a5)
     f12:	fc843783          	ld	a5,-56(s0)
     f16:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
     f18:	fc843783          	ld	a5,-56(s0)
     f1c:	779c                	ld	a5,40(a5)
     f1e:	f2f43823          	sd	a5,-208(s0)
     f22:	f3043783          	ld	a5,-208(s0)
     f26:	fd878793          	addi	a5,a5,-40
     f2a:	fcf43423          	sd	a5,-56(s0)
     f2e:	fc843783          	ld	a5,-56(s0)
     f32:	02878713          	addi	a4,a5,40
     f36:	649c                	ld	a5,8(s1)
     f38:	f8f71ee3          	bne	a4,a5,ed4 <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
     f3c:	649c                	ld	a5,8(s1)
     f3e:	4098                	lw	a4,0(s1)
     f40:	85ba                	mv	a1,a4
     f42:	853e                	mv	a0,a5
     f44:	00000097          	auipc	ra,0x0
     f48:	e38080e7          	jalr	-456(ra) # d7c <__check_deadline_miss>
     f4c:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
     f50:	f9043783          	ld	a5,-112(s0)
     f54:	c395                	beqz	a5,f78 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
     f56:	f9043783          	ld	a5,-112(s0)
     f5a:	02878793          	addi	a5,a5,40
     f5e:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
     f62:	f0042c23          	sw	zero,-232(s0)
        return r;
     f66:	f1043783          	ld	a5,-240(s0)
     f6a:	f2f43023          	sd	a5,-224(s0)
     f6e:	f1843783          	ld	a5,-232(s0)
     f72:	f2f43423          	sd	a5,-216(s0)
     f76:	ae19                	j	128c <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
     f78:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
     f7c:	649c                	ld	a5,8(s1)
     f7e:	639c                	ld	a5,0(a5)
     f80:	f8f43423          	sd	a5,-120(s0)
     f84:	f8843783          	ld	a5,-120(s0)
     f88:	fd878793          	addi	a5,a5,-40
     f8c:	fcf43423          	sd	a5,-56(s0)
     f90:	a0ad                	j	ffa <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
     f92:	fc843783          	ld	a5,-56(s0)
     f96:	4bfc                	lw	a5,84(a5)
     f98:	04f05563          	blez	a5,fe2 <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     f9c:	fc843783          	ld	a5,-56(s0)
     fa0:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
     fa2:	00f04d63          	bgtz	a5,fbc <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     fa6:	fc843783          	ld	a5,-56(s0)
     faa:	4bfc                	lw	a5,84(a5)
     fac:	00f05863          	blez	a5,fbc <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
     fb0:	4098                	lw	a4,0(s1)
     fb2:	fc843783          	ld	a5,-56(s0)
     fb6:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     fb8:	02f74563          	blt	a4,a5,fe2 <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
     fbc:	fc043783          	ld	a5,-64(s0)
     fc0:	cf81                	beqz	a5,fd8 <schedule_edf_cbs+0x132>
     fc2:	fc043583          	ld	a1,-64(s0)
     fc6:	fc843503          	ld	a0,-56(s0)
     fca:	00000097          	auipc	ra,0x0
     fce:	e4c080e7          	jalr	-436(ra) # e16 <__edf_thread_cmp>
     fd2:	87aa                	mv	a5,a0
     fd4:	0007d863          	bgez	a5,fe4 <schedule_edf_cbs+0x13e>
            selected = t;
     fd8:	fc843783          	ld	a5,-56(s0)
     fdc:	fcf43023          	sd	a5,-64(s0)
     fe0:	a011                	j	fe4 <schedule_edf_cbs+0x13e>
            continue;
     fe2:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
     fe4:	fc843783          	ld	a5,-56(s0)
     fe8:	779c                	ld	a5,40(a5)
     fea:	f2f43c23          	sd	a5,-200(s0)
     fee:	f3843783          	ld	a5,-200(s0)
     ff2:	fd878793          	addi	a5,a5,-40
     ff6:	fcf43423          	sd	a5,-56(s0)
     ffa:	fc843783          	ld	a5,-56(s0)
     ffe:	02878713          	addi	a4,a5,40
    1002:	649c                	ld	a5,8(s1)
    1004:	f8f717e3          	bne	a4,a5,f92 <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    1008:	fc043783          	ld	a5,-64(s0)
    100c:	ebd5                	bnez	a5,10c0 <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    100e:	800007b7          	lui	a5,0x80000
    1012:	fff7c793          	not	a5,a5
    1016:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    101a:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    101e:	689c                	ld	a5,16(s1)
    1020:	639c                	ld	a5,0(a5)
    1022:	f4f43423          	sd	a5,-184(s0)
    1026:	f4843783          	ld	a5,-184(s0)
    102a:	17e1                	addi	a5,a5,-8
    102c:	faf43823          	sd	a5,-80(s0)
    1030:	a835                	j	106c <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    1032:	fb043783          	ld	a5,-80(s0)
    1036:	4f98                	lw	a4,24(a5)
    1038:	409c                	lw	a5,0(s1)
    103a:	00e7df63          	bge	a5,a4,1058 <schedule_edf_cbs+0x1b2>
    103e:	fb043783          	ld	a5,-80(s0)
    1042:	4f98                	lw	a4,24(a5)
    1044:	fbc42783          	lw	a5,-68(s0)
    1048:	2781                	sext.w	a5,a5
    104a:	00f75763          	bge	a4,a5,1058 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    104e:	fb043783          	ld	a5,-80(s0)
    1052:	4f9c                	lw	a5,24(a5)
    1054:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1058:	fb043783          	ld	a5,-80(s0)
    105c:	679c                	ld	a5,8(a5)
    105e:	f4f43023          	sd	a5,-192(s0)
    1062:	f4043783          	ld	a5,-192(s0)
    1066:	17e1                	addi	a5,a5,-8
    1068:	faf43823          	sd	a5,-80(s0)
    106c:	fb043783          	ld	a5,-80(s0)
    1070:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffe548>
    1074:	689c                	ld	a5,16(s1)
    1076:	faf71ee3          	bne	a4,a5,1032 <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    107a:	fbc42783          	lw	a5,-68(s0)
    107e:	0007871b          	sext.w	a4,a5
    1082:	800007b7          	lui	a5,0x80000
    1086:	fff7c793          	not	a5,a5
    108a:	00f70e63          	beq	a4,a5,10a6 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    108e:	649c                	ld	a5,8(s1)
    1090:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    1094:	409c                	lw	a5,0(s1)
    1096:	fbc42703          	lw	a4,-68(s0)
    109a:	40f707bb          	subw	a5,a4,a5
    109e:	2781                	sext.w	a5,a5
    10a0:	f0f42c23          	sw	a5,-232(s0)
    10a4:	a029                	j	10ae <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    10a6:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    10aa:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    10ae:	f1043783          	ld	a5,-240(s0)
    10b2:	f2f43023          	sd	a5,-224(s0)
    10b6:	f1843783          	ld	a5,-232(s0)
    10ba:	f2f43423          	sd	a5,-216(s0)
    10be:	a2f9                	j	128c <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    10c0:	fc043783          	ld	a5,-64(s0)
    10c4:	57fc                	lw	a5,108(a5)
    10c6:	e7f1                	bnez	a5,1192 <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    10c8:	fc043783          	ld	a5,-64(s0)
    10cc:	57bc                	lw	a5,104(a5)
    10ce:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    10d2:	fc043783          	ld	a5,-64(s0)
    10d6:	4fb8                	lw	a4,88(a5)
    10d8:	409c                	lw	a5,0(s1)
    10da:	40f707bb          	subw	a5,a4,a5
    10de:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    10e2:	fc043783          	ld	a5,-64(s0)
    10e6:	47fc                	lw	a5,76(a5)
    10e8:	f5c42703          	lw	a4,-164(s0)
    10ec:	02f707bb          	mulw	a5,a4,a5
    10f0:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    10f4:	fc043783          	ld	a5,-64(s0)
    10f8:	53fc                	lw	a5,100(a5)
    10fa:	f5842703          	lw	a4,-168(s0)
    10fe:	02f707bb          	mulw	a5,a4,a5
    1102:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    1106:	f5442703          	lw	a4,-172(s0)
    110a:	f5042783          	lw	a5,-176(s0)
    110e:	2701                	sext.w	a4,a4
    1110:	2781                	sext.w	a5,a5
    1112:	02e7d363          	bge	a5,a4,1138 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    1116:	4098                	lw	a4,0(s1)
    1118:	fc043783          	ld	a5,-64(s0)
    111c:	47fc                	lw	a5,76(a5)
    111e:	9fb9                	addw	a5,a5,a4
    1120:	0007871b          	sext.w	a4,a5
    1124:	fc043783          	ld	a5,-64(s0)
    1128:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    112a:	fc043783          	ld	a5,-64(s0)
    112e:	53f8                	lw	a4,100(a5)
    1130:	fc043783          	ld	a5,-64(s0)
    1134:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    1136:	b341                	j	eb6 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    1138:	fc043783          	ld	a5,-64(s0)
    113c:	57bc                	lw	a5,104(a5)
    113e:	02f04063          	bgtz	a5,115e <schedule_edf_cbs+0x2b8>
    1142:	fc043783          	ld	a5,-64(s0)
    1146:	4bfc                	lw	a5,84(a5)
    1148:	00f05b63          	blez	a5,115e <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    114c:	fc043783          	ld	a5,-64(s0)
    1150:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe568>
    1154:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    1158:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    115c:	bba9                	j	eb6 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    115e:	fc043783          	ld	a5,-64(s0)
    1162:	02878793          	addi	a5,a5,40
    1166:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    116a:	fc043783          	ld	a5,-64(s0)
    116e:	57b8                	lw	a4,104(a5)
    1170:	fc043783          	ld	a5,-64(s0)
    1174:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    1176:	863e                	mv	a2,a5
    1178:	86ba                	mv	a3,a4
    117a:	0006871b          	sext.w	a4,a3
    117e:	0006079b          	sext.w	a5,a2
    1182:	00e7d363          	bge	a5,a4,1188 <schedule_edf_cbs+0x2e2>
    1186:	86b2                	mv	a3,a2
    1188:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    118c:	f0f42c23          	sw	a5,-232(s0)
    1190:	a0f5                	j	127c <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    1192:	fc043783          	ld	a5,-64(s0)
    1196:	4bfc                	lw	a5,84(a5)
    1198:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    119c:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    11a0:	689c                	ld	a5,16(s1)
    11a2:	639c                	ld	a5,0(a5)
    11a4:	f8f43023          	sd	a5,-128(s0)
    11a8:	f8043783          	ld	a5,-128(s0)
    11ac:	17e1                	addi	a5,a5,-8
    11ae:	faf43023          	sd	a5,-96(s0)
    11b2:	a041                	j	1232 <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    11b4:	fa043783          	ld	a5,-96(s0)
    11b8:	639c                	ld	a5,0(a5)
    11ba:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    11be:	f7043783          	ld	a5,-144(s0)
    11c2:	53b8                	lw	a4,96(a5)
    11c4:	409c                	lw	a5,0(s1)
    11c6:	04e7dc63          	bge	a5,a4,121e <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    11ca:	f7043783          	ld	a5,-144(s0)
    11ce:	53b4                	lw	a3,96(a5)
    11d0:	409c                	lw	a5,0(s1)
    11d2:	fac42703          	lw	a4,-84(s0)
    11d6:	9fb9                	addw	a5,a5,a4
    11d8:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    11da:	8736                	mv	a4,a3
    11dc:	04f75163          	bge	a4,a5,121e <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    11e0:	fc043583          	ld	a1,-64(s0)
    11e4:	f7043503          	ld	a0,-144(s0)
    11e8:	00000097          	auipc	ra,0x0
    11ec:	c2e080e7          	jalr	-978(ra) # e16 <__edf_thread_cmp>
    11f0:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    11f2:	0207d663          	bgez	a5,121e <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    11f6:	f7043783          	ld	a5,-144(s0)
    11fa:	53b8                	lw	a4,96(a5)
    11fc:	409c                	lw	a5,0(s1)
    11fe:	40f707bb          	subw	a5,a4,a5
    1202:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    1206:	f6c42703          	lw	a4,-148(s0)
    120a:	fac42783          	lw	a5,-84(s0)
    120e:	2701                	sext.w	a4,a4
    1210:	2781                	sext.w	a5,a5
    1212:	00f75663          	bge	a4,a5,121e <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    1216:	f6c42783          	lw	a5,-148(s0)
    121a:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    121e:	fa043783          	ld	a5,-96(s0)
    1222:	679c                	ld	a5,8(a5)
    1224:	f6f43023          	sd	a5,-160(s0)
    1228:	f6043783          	ld	a5,-160(s0)
    122c:	17e1                	addi	a5,a5,-8
    122e:	faf43023          	sd	a5,-96(s0)
    1232:	fa043783          	ld	a5,-96(s0)
    1236:	00878713          	addi	a4,a5,8
    123a:	689c                	ld	a5,16(s1)
    123c:	f6f71ce3          	bne	a4,a5,11b4 <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    1240:	fc043783          	ld	a5,-64(s0)
    1244:	4fb8                	lw	a4,88(a5)
    1246:	409c                	lw	a5,0(s1)
    1248:	40f707bb          	subw	a5,a4,a5
    124c:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    1250:	f7c42703          	lw	a4,-132(s0)
    1254:	fac42783          	lw	a5,-84(s0)
    1258:	2701                	sext.w	a4,a4
    125a:	2781                	sext.w	a5,a5
    125c:	00f75663          	bge	a4,a5,1268 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    1260:	f7c42783          	lw	a5,-132(s0)
    1264:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    1268:	fc043783          	ld	a5,-64(s0)
    126c:	02878793          	addi	a5,a5,40
    1270:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    1274:	fac42783          	lw	a5,-84(s0)
    1278:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    127c:	f1043783          	ld	a5,-240(s0)
    1280:	f2f43023          	sd	a5,-224(s0)
    1284:	f1843783          	ld	a5,-232(s0)
    1288:	f2f43423          	sd	a5,-216(s0)
    128c:	4701                	li	a4,0
    128e:	f2043703          	ld	a4,-224(s0)
    1292:	4781                	li	a5,0
    1294:	f2843783          	ld	a5,-216(s0)
    1298:	893a                	mv	s2,a4
    129a:	89be                	mv	s3,a5
    129c:	874a                	mv	a4,s2
    129e:	87ce                	mv	a5,s3
}
    12a0:	853a                	mv	a0,a4
    12a2:	85be                	mv	a1,a5
    12a4:	70ae                	ld	ra,232(sp)
    12a6:	740e                	ld	s0,224(sp)
    12a8:	64ee                	ld	s1,216(sp)
    12aa:	694e                	ld	s2,208(sp)
    12ac:	69ae                	ld	s3,200(sp)
    12ae:	616d                	addi	sp,sp,240
    12b0:	8082                	ret
