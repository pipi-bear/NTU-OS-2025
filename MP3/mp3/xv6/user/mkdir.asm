
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcb43823          	sd	a1,-48(s0)
       e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
      12:	fdc42783          	lw	a5,-36(s0)
      16:	0007871b          	sext.w	a4,a5
      1a:	4785                	li	a5,1
      1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "Usage: mkdir files...\n");
      20:	00001597          	auipc	a1,0x1
      24:	34058593          	addi	a1,a1,832 # 1360 <schedule_edf_cbs+0x410>
      28:	4509                	li	a0,2
      2a:	00001097          	auipc	ra,0x1
      2e:	9fe080e7          	jalr	-1538(ra) # a28 <fprintf>
    exit(1);
      32:	4505                	li	a0,1
      34:	00000097          	auipc	ra,0x0
      38:	506080e7          	jalr	1286(ra) # 53a <exit>
  }

  for(i = 1; i < argc; i++){
      3c:	4785                	li	a5,1
      3e:	fef42623          	sw	a5,-20(s0)
      42:	a0b9                	j	90 <main+0x90>
    if(mkdir(argv[i]) < 0){
      44:	fec42783          	lw	a5,-20(s0)
      48:	078e                	slli	a5,a5,0x3
      4a:	fd043703          	ld	a4,-48(s0)
      4e:	97ba                	add	a5,a5,a4
      50:	639c                	ld	a5,0(a5)
      52:	853e                	mv	a0,a5
      54:	00000097          	auipc	ra,0x0
      58:	54e080e7          	jalr	1358(ra) # 5a2 <mkdir>
      5c:	87aa                	mv	a5,a0
      5e:	0207d463          	bgez	a5,86 <main+0x86>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
      62:	fec42783          	lw	a5,-20(s0)
      66:	078e                	slli	a5,a5,0x3
      68:	fd043703          	ld	a4,-48(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	639c                	ld	a5,0(a5)
      70:	863e                	mv	a2,a5
      72:	00001597          	auipc	a1,0x1
      76:	30658593          	addi	a1,a1,774 # 1378 <schedule_edf_cbs+0x428>
      7a:	4509                	li	a0,2
      7c:	00001097          	auipc	ra,0x1
      80:	9ac080e7          	jalr	-1620(ra) # a28 <fprintf>
      break;
      84:	a831                	j	a0 <main+0xa0>
  for(i = 1; i < argc; i++){
      86:	fec42783          	lw	a5,-20(s0)
      8a:	2785                	addiw	a5,a5,1
      8c:	fef42623          	sw	a5,-20(s0)
      90:	fec42703          	lw	a4,-20(s0)
      94:	fdc42783          	lw	a5,-36(s0)
      98:	2701                	sext.w	a4,a4
      9a:	2781                	sext.w	a5,a5
      9c:	faf744e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
      a0:	4501                	li	a0,0
      a2:	00000097          	auipc	ra,0x0
      a6:	498080e7          	jalr	1176(ra) # 53a <exit>

00000000000000aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f422                	sd	s0,40(sp)
      ae:	1800                	addi	s0,sp,48
      b0:	fca43c23          	sd	a0,-40(s0)
      b4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      b8:	fd843783          	ld	a5,-40(s0)
      bc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      c0:	0001                	nop
      c2:	fd043703          	ld	a4,-48(s0)
      c6:	00170793          	addi	a5,a4,1
      ca:	fcf43823          	sd	a5,-48(s0)
      ce:	fd843783          	ld	a5,-40(s0)
      d2:	00178693          	addi	a3,a5,1
      d6:	fcd43c23          	sd	a3,-40(s0)
      da:	00074703          	lbu	a4,0(a4)
      de:	00e78023          	sb	a4,0(a5)
      e2:	0007c783          	lbu	a5,0(a5)
      e6:	fff1                	bnez	a5,c2 <strcpy+0x18>
    ;
  return os;
      e8:	fe843783          	ld	a5,-24(s0)
}
      ec:	853e                	mv	a0,a5
      ee:	7422                	ld	s0,40(sp)
      f0:	6145                	addi	sp,sp,48
      f2:	8082                	ret

00000000000000f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      f4:	1101                	addi	sp,sp,-32
      f6:	ec22                	sd	s0,24(sp)
      f8:	1000                	addi	s0,sp,32
      fa:	fea43423          	sd	a0,-24(s0)
      fe:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     102:	a819                	j	118 <strcmp+0x24>
    p++, q++;
     104:	fe843783          	ld	a5,-24(s0)
     108:	0785                	addi	a5,a5,1
     10a:	fef43423          	sd	a5,-24(s0)
     10e:	fe043783          	ld	a5,-32(s0)
     112:	0785                	addi	a5,a5,1
     114:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     118:	fe843783          	ld	a5,-24(s0)
     11c:	0007c783          	lbu	a5,0(a5)
     120:	cb99                	beqz	a5,136 <strcmp+0x42>
     122:	fe843783          	ld	a5,-24(s0)
     126:	0007c703          	lbu	a4,0(a5)
     12a:	fe043783          	ld	a5,-32(s0)
     12e:	0007c783          	lbu	a5,0(a5)
     132:	fcf709e3          	beq	a4,a5,104 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     136:	fe843783          	ld	a5,-24(s0)
     13a:	0007c783          	lbu	a5,0(a5)
     13e:	0007871b          	sext.w	a4,a5
     142:	fe043783          	ld	a5,-32(s0)
     146:	0007c783          	lbu	a5,0(a5)
     14a:	2781                	sext.w	a5,a5
     14c:	40f707bb          	subw	a5,a4,a5
     150:	2781                	sext.w	a5,a5
}
     152:	853e                	mv	a0,a5
     154:	6462                	ld	s0,24(sp)
     156:	6105                	addi	sp,sp,32
     158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
     15a:	7179                	addi	sp,sp,-48
     15c:	f422                	sd	s0,40(sp)
     15e:	1800                	addi	s0,sp,48
     160:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     164:	fe042623          	sw	zero,-20(s0)
     168:	a031                	j	174 <strlen+0x1a>
     16a:	fec42783          	lw	a5,-20(s0)
     16e:	2785                	addiw	a5,a5,1
     170:	fef42623          	sw	a5,-20(s0)
     174:	fec42783          	lw	a5,-20(s0)
     178:	fd843703          	ld	a4,-40(s0)
     17c:	97ba                	add	a5,a5,a4
     17e:	0007c783          	lbu	a5,0(a5)
     182:	f7e5                	bnez	a5,16a <strlen+0x10>
    ;
  return n;
     184:	fec42783          	lw	a5,-20(s0)
}
     188:	853e                	mv	a0,a5
     18a:	7422                	ld	s0,40(sp)
     18c:	6145                	addi	sp,sp,48
     18e:	8082                	ret

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
     190:	7179                	addi	sp,sp,-48
     192:	f422                	sd	s0,40(sp)
     194:	1800                	addi	s0,sp,48
     196:	fca43c23          	sd	a0,-40(s0)
     19a:	87ae                	mv	a5,a1
     19c:	8732                	mv	a4,a2
     19e:	fcf42a23          	sw	a5,-44(s0)
     1a2:	87ba                	mv	a5,a4
     1a4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1a8:	fd843783          	ld	a5,-40(s0)
     1ac:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1b0:	fe042623          	sw	zero,-20(s0)
     1b4:	a00d                	j	1d6 <memset+0x46>
    cdst[i] = c;
     1b6:	fec42783          	lw	a5,-20(s0)
     1ba:	fe043703          	ld	a4,-32(s0)
     1be:	97ba                	add	a5,a5,a4
     1c0:	fd442703          	lw	a4,-44(s0)
     1c4:	0ff77713          	andi	a4,a4,255
     1c8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42703          	lw	a4,-20(s0)
     1da:	fd042783          	lw	a5,-48(s0)
     1de:	2781                	sext.w	a5,a5
     1e0:	fcf76be3          	bltu	a4,a5,1b6 <memset+0x26>
  }
  return dst;
     1e4:	fd843783          	ld	a5,-40(s0)
}
     1e8:	853e                	mv	a0,a5
     1ea:	7422                	ld	s0,40(sp)
     1ec:	6145                	addi	sp,sp,48
     1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
     1f0:	1101                	addi	sp,sp,-32
     1f2:	ec22                	sd	s0,24(sp)
     1f4:	1000                	addi	s0,sp,32
     1f6:	fea43423          	sd	a0,-24(s0)
     1fa:	87ae                	mv	a5,a1
     1fc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     200:	a01d                	j	226 <strchr+0x36>
    if(*s == c)
     202:	fe843783          	ld	a5,-24(s0)
     206:	0007c703          	lbu	a4,0(a5)
     20a:	fe744783          	lbu	a5,-25(s0)
     20e:	0ff7f793          	andi	a5,a5,255
     212:	00e79563          	bne	a5,a4,21c <strchr+0x2c>
      return (char*)s;
     216:	fe843783          	ld	a5,-24(s0)
     21a:	a821                	j	232 <strchr+0x42>
  for(; *s; s++)
     21c:	fe843783          	ld	a5,-24(s0)
     220:	0785                	addi	a5,a5,1
     222:	fef43423          	sd	a5,-24(s0)
     226:	fe843783          	ld	a5,-24(s0)
     22a:	0007c783          	lbu	a5,0(a5)
     22e:	fbf1                	bnez	a5,202 <strchr+0x12>
  return 0;
     230:	4781                	li	a5,0
}
     232:	853e                	mv	a0,a5
     234:	6462                	ld	s0,24(sp)
     236:	6105                	addi	sp,sp,32
     238:	8082                	ret

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
     23a:	7179                	addi	sp,sp,-48
     23c:	f406                	sd	ra,40(sp)
     23e:	f022                	sd	s0,32(sp)
     240:	1800                	addi	s0,sp,48
     242:	fca43c23          	sd	a0,-40(s0)
     246:	87ae                	mv	a5,a1
     248:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     24c:	fe042623          	sw	zero,-20(s0)
     250:	a8a1                	j	2a8 <gets+0x6e>
    cc = read(0, &c, 1);
     252:	fe740793          	addi	a5,s0,-25
     256:	4605                	li	a2,1
     258:	85be                	mv	a1,a5
     25a:	4501                	li	a0,0
     25c:	00000097          	auipc	ra,0x0
     260:	2f6080e7          	jalr	758(ra) # 552 <read>
     264:	87aa                	mv	a5,a0
     266:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     26a:	fe842783          	lw	a5,-24(s0)
     26e:	2781                	sext.w	a5,a5
     270:	04f05763          	blez	a5,2be <gets+0x84>
      break;
    buf[i++] = c;
     274:	fec42783          	lw	a5,-20(s0)
     278:	0017871b          	addiw	a4,a5,1
     27c:	fee42623          	sw	a4,-20(s0)
     280:	873e                	mv	a4,a5
     282:	fd843783          	ld	a5,-40(s0)
     286:	97ba                	add	a5,a5,a4
     288:	fe744703          	lbu	a4,-25(s0)
     28c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     290:	fe744783          	lbu	a5,-25(s0)
     294:	873e                	mv	a4,a5
     296:	47a9                	li	a5,10
     298:	02f70463          	beq	a4,a5,2c0 <gets+0x86>
     29c:	fe744783          	lbu	a5,-25(s0)
     2a0:	873e                	mv	a4,a5
     2a2:	47b5                	li	a5,13
     2a4:	00f70e63          	beq	a4,a5,2c0 <gets+0x86>
  for(i=0; i+1 < max; ){
     2a8:	fec42783          	lw	a5,-20(s0)
     2ac:	2785                	addiw	a5,a5,1
     2ae:	0007871b          	sext.w	a4,a5
     2b2:	fd442783          	lw	a5,-44(s0)
     2b6:	2781                	sext.w	a5,a5
     2b8:	f8f74de3          	blt	a4,a5,252 <gets+0x18>
     2bc:	a011                	j	2c0 <gets+0x86>
      break;
     2be:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2c0:	fec42783          	lw	a5,-20(s0)
     2c4:	fd843703          	ld	a4,-40(s0)
     2c8:	97ba                	add	a5,a5,a4
     2ca:	00078023          	sb	zero,0(a5)
  return buf;
     2ce:	fd843783          	ld	a5,-40(s0)
}
     2d2:	853e                	mv	a0,a5
     2d4:	70a2                	ld	ra,40(sp)
     2d6:	7402                	ld	s0,32(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
     2dc:	7179                	addi	sp,sp,-48
     2de:	f406                	sd	ra,40(sp)
     2e0:	f022                	sd	s0,32(sp)
     2e2:	1800                	addi	s0,sp,48
     2e4:	fca43c23          	sd	a0,-40(s0)
     2e8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2ec:	4581                	li	a1,0
     2ee:	fd843503          	ld	a0,-40(s0)
     2f2:	00000097          	auipc	ra,0x0
     2f6:	288080e7          	jalr	648(ra) # 57a <open>
     2fa:	87aa                	mv	a5,a0
     2fc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     300:	fec42783          	lw	a5,-20(s0)
     304:	2781                	sext.w	a5,a5
     306:	0007d463          	bgez	a5,30e <stat+0x32>
    return -1;
     30a:	57fd                	li	a5,-1
     30c:	a035                	j	338 <stat+0x5c>
  r = fstat(fd, st);
     30e:	fec42783          	lw	a5,-20(s0)
     312:	fd043583          	ld	a1,-48(s0)
     316:	853e                	mv	a0,a5
     318:	00000097          	auipc	ra,0x0
     31c:	27a080e7          	jalr	634(ra) # 592 <fstat>
     320:	87aa                	mv	a5,a0
     322:	fef42423          	sw	a5,-24(s0)
  close(fd);
     326:	fec42783          	lw	a5,-20(s0)
     32a:	853e                	mv	a0,a5
     32c:	00000097          	auipc	ra,0x0
     330:	236080e7          	jalr	566(ra) # 562 <close>
  return r;
     334:	fe842783          	lw	a5,-24(s0)
}
     338:	853e                	mv	a0,a5
     33a:	70a2                	ld	ra,40(sp)
     33c:	7402                	ld	s0,32(sp)
     33e:	6145                	addi	sp,sp,48
     340:	8082                	ret

0000000000000342 <atoi>:

int
atoi(const char *s)
{
     342:	7179                	addi	sp,sp,-48
     344:	f422                	sd	s0,40(sp)
     346:	1800                	addi	s0,sp,48
     348:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     34c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     350:	a815                	j	384 <atoi+0x42>
    n = n*10 + *s++ - '0';
     352:	fec42703          	lw	a4,-20(s0)
     356:	87ba                	mv	a5,a4
     358:	0027979b          	slliw	a5,a5,0x2
     35c:	9fb9                	addw	a5,a5,a4
     35e:	0017979b          	slliw	a5,a5,0x1
     362:	0007871b          	sext.w	a4,a5
     366:	fd843783          	ld	a5,-40(s0)
     36a:	00178693          	addi	a3,a5,1
     36e:	fcd43c23          	sd	a3,-40(s0)
     372:	0007c783          	lbu	a5,0(a5)
     376:	2781                	sext.w	a5,a5
     378:	9fb9                	addw	a5,a5,a4
     37a:	2781                	sext.w	a5,a5
     37c:	fd07879b          	addiw	a5,a5,-48
     380:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     384:	fd843783          	ld	a5,-40(s0)
     388:	0007c783          	lbu	a5,0(a5)
     38c:	873e                	mv	a4,a5
     38e:	02f00793          	li	a5,47
     392:	00e7fb63          	bgeu	a5,a4,3a8 <atoi+0x66>
     396:	fd843783          	ld	a5,-40(s0)
     39a:	0007c783          	lbu	a5,0(a5)
     39e:	873e                	mv	a4,a5
     3a0:	03900793          	li	a5,57
     3a4:	fae7f7e3          	bgeu	a5,a4,352 <atoi+0x10>
  return n;
     3a8:	fec42783          	lw	a5,-20(s0)
}
     3ac:	853e                	mv	a0,a5
     3ae:	7422                	ld	s0,40(sp)
     3b0:	6145                	addi	sp,sp,48
     3b2:	8082                	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3b4:	7139                	addi	sp,sp,-64
     3b6:	fc22                	sd	s0,56(sp)
     3b8:	0080                	addi	s0,sp,64
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	fcb43823          	sd	a1,-48(s0)
     3c2:	87b2                	mv	a5,a2
     3c4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3c8:	fd843783          	ld	a5,-40(s0)
     3cc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3d0:	fd043783          	ld	a5,-48(s0)
     3d4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3d8:	fe043703          	ld	a4,-32(s0)
     3dc:	fe843783          	ld	a5,-24(s0)
     3e0:	02e7fc63          	bgeu	a5,a4,418 <memmove+0x64>
    while(n-- > 0)
     3e4:	a00d                	j	406 <memmove+0x52>
      *dst++ = *src++;
     3e6:	fe043703          	ld	a4,-32(s0)
     3ea:	00170793          	addi	a5,a4,1
     3ee:	fef43023          	sd	a5,-32(s0)
     3f2:	fe843783          	ld	a5,-24(s0)
     3f6:	00178693          	addi	a3,a5,1
     3fa:	fed43423          	sd	a3,-24(s0)
     3fe:	00074703          	lbu	a4,0(a4)
     402:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     406:	fcc42783          	lw	a5,-52(s0)
     40a:	fff7871b          	addiw	a4,a5,-1
     40e:	fce42623          	sw	a4,-52(s0)
     412:	fcf04ae3          	bgtz	a5,3e6 <memmove+0x32>
     416:	a891                	j	46a <memmove+0xb6>
  } else {
    dst += n;
     418:	fcc42783          	lw	a5,-52(s0)
     41c:	fe843703          	ld	a4,-24(s0)
     420:	97ba                	add	a5,a5,a4
     422:	fef43423          	sd	a5,-24(s0)
    src += n;
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fe043703          	ld	a4,-32(s0)
     42e:	97ba                	add	a5,a5,a4
     430:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     434:	a01d                	j	45a <memmove+0xa6>
      *--dst = *--src;
     436:	fe043783          	ld	a5,-32(s0)
     43a:	17fd                	addi	a5,a5,-1
     43c:	fef43023          	sd	a5,-32(s0)
     440:	fe843783          	ld	a5,-24(s0)
     444:	17fd                	addi	a5,a5,-1
     446:	fef43423          	sd	a5,-24(s0)
     44a:	fe043783          	ld	a5,-32(s0)
     44e:	0007c703          	lbu	a4,0(a5)
     452:	fe843783          	ld	a5,-24(s0)
     456:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     45a:	fcc42783          	lw	a5,-52(s0)
     45e:	fff7871b          	addiw	a4,a5,-1
     462:	fce42623          	sw	a4,-52(s0)
     466:	fcf048e3          	bgtz	a5,436 <memmove+0x82>
  }
  return vdst;
     46a:	fd843783          	ld	a5,-40(s0)
}
     46e:	853e                	mv	a0,a5
     470:	7462                	ld	s0,56(sp)
     472:	6121                	addi	sp,sp,64
     474:	8082                	ret

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     476:	7139                	addi	sp,sp,-64
     478:	fc22                	sd	s0,56(sp)
     47a:	0080                	addi	s0,sp,64
     47c:	fca43c23          	sd	a0,-40(s0)
     480:	fcb43823          	sd	a1,-48(s0)
     484:	87b2                	mv	a5,a2
     486:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     48a:	fd843783          	ld	a5,-40(s0)
     48e:	fef43423          	sd	a5,-24(s0)
     492:	fd043783          	ld	a5,-48(s0)
     496:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     49a:	a0a1                	j	4e2 <memcmp+0x6c>
    if (*p1 != *p2) {
     49c:	fe843783          	ld	a5,-24(s0)
     4a0:	0007c703          	lbu	a4,0(a5)
     4a4:	fe043783          	ld	a5,-32(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	02f70163          	beq	a4,a5,4ce <memcmp+0x58>
      return *p1 - *p2;
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	0007871b          	sext.w	a4,a5
     4bc:	fe043783          	ld	a5,-32(s0)
     4c0:	0007c783          	lbu	a5,0(a5)
     4c4:	2781                	sext.w	a5,a5
     4c6:	40f707bb          	subw	a5,a4,a5
     4ca:	2781                	sext.w	a5,a5
     4cc:	a01d                	j	4f2 <memcmp+0x7c>
    }
    p1++;
     4ce:	fe843783          	ld	a5,-24(s0)
     4d2:	0785                	addi	a5,a5,1
     4d4:	fef43423          	sd	a5,-24(s0)
    p2++;
     4d8:	fe043783          	ld	a5,-32(s0)
     4dc:	0785                	addi	a5,a5,1
     4de:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4e2:	fcc42783          	lw	a5,-52(s0)
     4e6:	fff7871b          	addiw	a4,a5,-1
     4ea:	fce42623          	sw	a4,-52(s0)
     4ee:	f7dd                	bnez	a5,49c <memcmp+0x26>
  }
  return 0;
     4f0:	4781                	li	a5,0
}
     4f2:	853e                	mv	a0,a5
     4f4:	7462                	ld	s0,56(sp)
     4f6:	6121                	addi	sp,sp,64
     4f8:	8082                	ret

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4fa:	7179                	addi	sp,sp,-48
     4fc:	f406                	sd	ra,40(sp)
     4fe:	f022                	sd	s0,32(sp)
     500:	1800                	addi	s0,sp,48
     502:	fea43423          	sd	a0,-24(s0)
     506:	feb43023          	sd	a1,-32(s0)
     50a:	87b2                	mv	a5,a2
     50c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     510:	fdc42783          	lw	a5,-36(s0)
     514:	863e                	mv	a2,a5
     516:	fe043583          	ld	a1,-32(s0)
     51a:	fe843503          	ld	a0,-24(s0)
     51e:	00000097          	auipc	ra,0x0
     522:	e96080e7          	jalr	-362(ra) # 3b4 <memmove>
     526:	87aa                	mv	a5,a0
}
     528:	853e                	mv	a0,a5
     52a:	70a2                	ld	ra,40(sp)
     52c:	7402                	ld	s0,32(sp)
     52e:	6145                	addi	sp,sp,48
     530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     532:	4885                	li	a7,1
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
     53a:	4889                	li	a7,2
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
     542:	488d                	li	a7,3
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     54a:	4891                	li	a7,4
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
     552:	4895                	li	a7,5
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
     55a:	48c1                	li	a7,16
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
     562:	48d5                	li	a7,21
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
     56a:	4899                	li	a7,6
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
     572:	489d                	li	a7,7
 ecall
     574:	00000073          	ecall
 ret
     578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
     57a:	48bd                	li	a7,15
 ecall
     57c:	00000073          	ecall
 ret
     580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     582:	48c5                	li	a7,17
 ecall
     584:	00000073          	ecall
 ret
     588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     58a:	48c9                	li	a7,18
 ecall
     58c:	00000073          	ecall
 ret
     590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     592:	48a1                	li	a7,8
 ecall
     594:	00000073          	ecall
 ret
     598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
     59a:	48cd                	li	a7,19
 ecall
     59c:	00000073          	ecall
 ret
     5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5a2:	48d1                	li	a7,20
 ecall
     5a4:	00000073          	ecall
 ret
     5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5aa:	48a5                	li	a7,9
 ecall
     5ac:	00000073          	ecall
 ret
     5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5b2:	48a9                	li	a7,10
 ecall
     5b4:	00000073          	ecall
 ret
     5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5ba:	48ad                	li	a7,11
 ecall
     5bc:	00000073          	ecall
 ret
     5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5c2:	48b1                	li	a7,12
 ecall
     5c4:	00000073          	ecall
 ret
     5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5ca:	48b5                	li	a7,13
 ecall
     5cc:	00000073          	ecall
 ret
     5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5d2:	48b9                	li	a7,14
 ecall
     5d4:	00000073          	ecall
 ret
     5d8:	8082                	ret

00000000000005da <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5da:	48d9                	li	a7,22
 ecall
     5dc:	00000073          	ecall
 ret
     5e0:	8082                	ret

00000000000005e2 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5e2:	48dd                	li	a7,23
 ecall
     5e4:	00000073          	ecall
 ret
     5e8:	8082                	ret

00000000000005ea <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5ea:	48e1                	li	a7,24
 ecall
     5ec:	00000073          	ecall
 ret
     5f0:	8082                	ret

00000000000005f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5f2:	1101                	addi	sp,sp,-32
     5f4:	ec06                	sd	ra,24(sp)
     5f6:	e822                	sd	s0,16(sp)
     5f8:	1000                	addi	s0,sp,32
     5fa:	87aa                	mv	a5,a0
     5fc:	872e                	mv	a4,a1
     5fe:	fef42623          	sw	a5,-20(s0)
     602:	87ba                	mv	a5,a4
     604:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     608:	feb40713          	addi	a4,s0,-21
     60c:	fec42783          	lw	a5,-20(s0)
     610:	4605                	li	a2,1
     612:	85ba                	mv	a1,a4
     614:	853e                	mv	a0,a5
     616:	00000097          	auipc	ra,0x0
     61a:	f44080e7          	jalr	-188(ra) # 55a <write>
}
     61e:	0001                	nop
     620:	60e2                	ld	ra,24(sp)
     622:	6442                	ld	s0,16(sp)
     624:	6105                	addi	sp,sp,32
     626:	8082                	ret

0000000000000628 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     628:	7139                	addi	sp,sp,-64
     62a:	fc06                	sd	ra,56(sp)
     62c:	f822                	sd	s0,48(sp)
     62e:	0080                	addi	s0,sp,64
     630:	87aa                	mv	a5,a0
     632:	8736                	mv	a4,a3
     634:	fcf42623          	sw	a5,-52(s0)
     638:	87ae                	mv	a5,a1
     63a:	fcf42423          	sw	a5,-56(s0)
     63e:	87b2                	mv	a5,a2
     640:	fcf42223          	sw	a5,-60(s0)
     644:	87ba                	mv	a5,a4
     646:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     64a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     64e:	fc042783          	lw	a5,-64(s0)
     652:	2781                	sext.w	a5,a5
     654:	c38d                	beqz	a5,676 <printint+0x4e>
     656:	fc842783          	lw	a5,-56(s0)
     65a:	2781                	sext.w	a5,a5
     65c:	0007dd63          	bgez	a5,676 <printint+0x4e>
    neg = 1;
     660:	4785                	li	a5,1
     662:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     666:	fc842783          	lw	a5,-56(s0)
     66a:	40f007bb          	negw	a5,a5
     66e:	2781                	sext.w	a5,a5
     670:	fef42223          	sw	a5,-28(s0)
     674:	a029                	j	67e <printint+0x56>
  } else {
    x = xx;
     676:	fc842783          	lw	a5,-56(s0)
     67a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     67e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     682:	fc442783          	lw	a5,-60(s0)
     686:	fe442703          	lw	a4,-28(s0)
     68a:	02f777bb          	remuw	a5,a4,a5
     68e:	0007861b          	sext.w	a2,a5
     692:	fec42783          	lw	a5,-20(s0)
     696:	0017871b          	addiw	a4,a5,1
     69a:	fee42623          	sw	a4,-20(s0)
     69e:	00001697          	auipc	a3,0x1
     6a2:	d0268693          	addi	a3,a3,-766 # 13a0 <digits>
     6a6:	02061713          	slli	a4,a2,0x20
     6aa:	9301                	srli	a4,a4,0x20
     6ac:	9736                	add	a4,a4,a3
     6ae:	00074703          	lbu	a4,0(a4)
     6b2:	ff040693          	addi	a3,s0,-16
     6b6:	97b6                	add	a5,a5,a3
     6b8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6bc:	fc442783          	lw	a5,-60(s0)
     6c0:	fe442703          	lw	a4,-28(s0)
     6c4:	02f757bb          	divuw	a5,a4,a5
     6c8:	fef42223          	sw	a5,-28(s0)
     6cc:	fe442783          	lw	a5,-28(s0)
     6d0:	2781                	sext.w	a5,a5
     6d2:	fbc5                	bnez	a5,682 <printint+0x5a>
  if(neg)
     6d4:	fe842783          	lw	a5,-24(s0)
     6d8:	2781                	sext.w	a5,a5
     6da:	cf95                	beqz	a5,716 <printint+0xee>
    buf[i++] = '-';
     6dc:	fec42783          	lw	a5,-20(s0)
     6e0:	0017871b          	addiw	a4,a5,1
     6e4:	fee42623          	sw	a4,-20(s0)
     6e8:	ff040713          	addi	a4,s0,-16
     6ec:	97ba                	add	a5,a5,a4
     6ee:	02d00713          	li	a4,45
     6f2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6f6:	a005                	j	716 <printint+0xee>
    putc(fd, buf[i]);
     6f8:	fec42783          	lw	a5,-20(s0)
     6fc:	ff040713          	addi	a4,s0,-16
     700:	97ba                	add	a5,a5,a4
     702:	fe07c703          	lbu	a4,-32(a5)
     706:	fcc42783          	lw	a5,-52(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	ee4080e7          	jalr	-284(ra) # 5f2 <putc>
  while(--i >= 0)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	37fd                	addiw	a5,a5,-1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fec42783          	lw	a5,-20(s0)
     724:	2781                	sext.w	a5,a5
     726:	fc07d9e3          	bgez	a5,6f8 <printint+0xd0>
}
     72a:	0001                	nop
     72c:	0001                	nop
     72e:	70e2                	ld	ra,56(sp)
     730:	7442                	ld	s0,48(sp)
     732:	6121                	addi	sp,sp,64
     734:	8082                	ret

0000000000000736 <printptr>:

static void
printptr(int fd, uint64 x) {
     736:	7179                	addi	sp,sp,-48
     738:	f406                	sd	ra,40(sp)
     73a:	f022                	sd	s0,32(sp)
     73c:	1800                	addi	s0,sp,48
     73e:	87aa                	mv	a5,a0
     740:	fcb43823          	sd	a1,-48(s0)
     744:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     748:	fdc42783          	lw	a5,-36(s0)
     74c:	03000593          	li	a1,48
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	ea0080e7          	jalr	-352(ra) # 5f2 <putc>
  putc(fd, 'x');
     75a:	fdc42783          	lw	a5,-36(s0)
     75e:	07800593          	li	a1,120
     762:	853e                	mv	a0,a5
     764:	00000097          	auipc	ra,0x0
     768:	e8e080e7          	jalr	-370(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     76c:	fe042623          	sw	zero,-20(s0)
     770:	a82d                	j	7aa <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     772:	fd043783          	ld	a5,-48(s0)
     776:	93f1                	srli	a5,a5,0x3c
     778:	00001717          	auipc	a4,0x1
     77c:	c2870713          	addi	a4,a4,-984 # 13a0 <digits>
     780:	97ba                	add	a5,a5,a4
     782:	0007c703          	lbu	a4,0(a5)
     786:	fdc42783          	lw	a5,-36(s0)
     78a:	85ba                	mv	a1,a4
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	e64080e7          	jalr	-412(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     796:	fec42783          	lw	a5,-20(s0)
     79a:	2785                	addiw	a5,a5,1
     79c:	fef42623          	sw	a5,-20(s0)
     7a0:	fd043783          	ld	a5,-48(s0)
     7a4:	0792                	slli	a5,a5,0x4
     7a6:	fcf43823          	sd	a5,-48(s0)
     7aa:	fec42783          	lw	a5,-20(s0)
     7ae:	873e                	mv	a4,a5
     7b0:	47bd                	li	a5,15
     7b2:	fce7f0e3          	bgeu	a5,a4,772 <printptr+0x3c>
}
     7b6:	0001                	nop
     7b8:	0001                	nop
     7ba:	70a2                	ld	ra,40(sp)
     7bc:	7402                	ld	s0,32(sp)
     7be:	6145                	addi	sp,sp,48
     7c0:	8082                	ret

00000000000007c2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7c2:	715d                	addi	sp,sp,-80
     7c4:	e486                	sd	ra,72(sp)
     7c6:	e0a2                	sd	s0,64(sp)
     7c8:	0880                	addi	s0,sp,80
     7ca:	87aa                	mv	a5,a0
     7cc:	fcb43023          	sd	a1,-64(s0)
     7d0:	fac43c23          	sd	a2,-72(s0)
     7d4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7d8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7dc:	fe042223          	sw	zero,-28(s0)
     7e0:	a42d                	j	a0a <vprintf+0x248>
    c = fmt[i] & 0xff;
     7e2:	fe442783          	lw	a5,-28(s0)
     7e6:	fc043703          	ld	a4,-64(s0)
     7ea:	97ba                	add	a5,a5,a4
     7ec:	0007c783          	lbu	a5,0(a5)
     7f0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7f4:	fe042783          	lw	a5,-32(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	eb9d                	bnez	a5,830 <vprintf+0x6e>
      if(c == '%'){
     7fc:	fdc42783          	lw	a5,-36(s0)
     800:	0007871b          	sext.w	a4,a5
     804:	02500793          	li	a5,37
     808:	00f71763          	bne	a4,a5,816 <vprintf+0x54>
        state = '%';
     80c:	02500793          	li	a5,37
     810:	fef42023          	sw	a5,-32(s0)
     814:	a2f5                	j	a00 <vprintf+0x23e>
      } else {
        putc(fd, c);
     816:	fdc42783          	lw	a5,-36(s0)
     81a:	0ff7f713          	andi	a4,a5,255
     81e:	fcc42783          	lw	a5,-52(s0)
     822:	85ba                	mv	a1,a4
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	dcc080e7          	jalr	-564(ra) # 5f2 <putc>
     82e:	aac9                	j	a00 <vprintf+0x23e>
      }
    } else if(state == '%'){
     830:	fe042783          	lw	a5,-32(s0)
     834:	0007871b          	sext.w	a4,a5
     838:	02500793          	li	a5,37
     83c:	1cf71263          	bne	a4,a5,a00 <vprintf+0x23e>
      if(c == 'd'){
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	06400793          	li	a5,100
     84c:	02f71463          	bne	a4,a5,874 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     850:	fb843783          	ld	a5,-72(s0)
     854:	00878713          	addi	a4,a5,8
     858:	fae43c23          	sd	a4,-72(s0)
     85c:	4398                	lw	a4,0(a5)
     85e:	fcc42783          	lw	a5,-52(s0)
     862:	4685                	li	a3,1
     864:	4629                	li	a2,10
     866:	85ba                	mv	a1,a4
     868:	853e                	mv	a0,a5
     86a:	00000097          	auipc	ra,0x0
     86e:	dbe080e7          	jalr	-578(ra) # 628 <printint>
     872:	a269                	j	9fc <vprintf+0x23a>
      } else if(c == 'l') {
     874:	fdc42783          	lw	a5,-36(s0)
     878:	0007871b          	sext.w	a4,a5
     87c:	06c00793          	li	a5,108
     880:	02f71663          	bne	a4,a5,8ac <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     884:	fb843783          	ld	a5,-72(s0)
     888:	00878713          	addi	a4,a5,8
     88c:	fae43c23          	sd	a4,-72(s0)
     890:	639c                	ld	a5,0(a5)
     892:	0007871b          	sext.w	a4,a5
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	4681                	li	a3,0
     89c:	4629                	li	a2,10
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	d86080e7          	jalr	-634(ra) # 628 <printint>
     8aa:	aa89                	j	9fc <vprintf+0x23a>
      } else if(c == 'x') {
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	07800793          	li	a5,120
     8b8:	02f71463          	bne	a4,a5,8e0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8bc:	fb843783          	ld	a5,-72(s0)
     8c0:	00878713          	addi	a4,a5,8
     8c4:	fae43c23          	sd	a4,-72(s0)
     8c8:	4398                	lw	a4,0(a5)
     8ca:	fcc42783          	lw	a5,-52(s0)
     8ce:	4681                	li	a3,0
     8d0:	4641                	li	a2,16
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	d52080e7          	jalr	-686(ra) # 628 <printint>
     8de:	aa39                	j	9fc <vprintf+0x23a>
      } else if(c == 'p') {
     8e0:	fdc42783          	lw	a5,-36(s0)
     8e4:	0007871b          	sext.w	a4,a5
     8e8:	07000793          	li	a5,112
     8ec:	02f71263          	bne	a4,a5,910 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8f0:	fb843783          	ld	a5,-72(s0)
     8f4:	00878713          	addi	a4,a5,8
     8f8:	fae43c23          	sd	a4,-72(s0)
     8fc:	6398                	ld	a4,0(a5)
     8fe:	fcc42783          	lw	a5,-52(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	e30080e7          	jalr	-464(ra) # 736 <printptr>
     90e:	a0fd                	j	9fc <vprintf+0x23a>
      } else if(c == 's'){
     910:	fdc42783          	lw	a5,-36(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	07300793          	li	a5,115
     91c:	04f71c63          	bne	a4,a5,974 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     920:	fb843783          	ld	a5,-72(s0)
     924:	00878713          	addi	a4,a5,8
     928:	fae43c23          	sd	a4,-72(s0)
     92c:	639c                	ld	a5,0(a5)
     92e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     932:	fe843783          	ld	a5,-24(s0)
     936:	eb8d                	bnez	a5,968 <vprintf+0x1a6>
          s = "(null)";
     938:	00001797          	auipc	a5,0x1
     93c:	a6078793          	addi	a5,a5,-1440 # 1398 <schedule_edf_cbs+0x448>
     940:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     944:	a015                	j	968 <vprintf+0x1a6>
          putc(fd, *s);
     946:	fe843783          	ld	a5,-24(s0)
     94a:	0007c703          	lbu	a4,0(a5)
     94e:	fcc42783          	lw	a5,-52(s0)
     952:	85ba                	mv	a1,a4
     954:	853e                	mv	a0,a5
     956:	00000097          	auipc	ra,0x0
     95a:	c9c080e7          	jalr	-868(ra) # 5f2 <putc>
          s++;
     95e:	fe843783          	ld	a5,-24(s0)
     962:	0785                	addi	a5,a5,1
     964:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     968:	fe843783          	ld	a5,-24(s0)
     96c:	0007c783          	lbu	a5,0(a5)
     970:	fbf9                	bnez	a5,946 <vprintf+0x184>
     972:	a069                	j	9fc <vprintf+0x23a>
        }
      } else if(c == 'c'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	06300793          	li	a5,99
     980:	02f71463          	bne	a4,a5,9a8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     984:	fb843783          	ld	a5,-72(s0)
     988:	00878713          	addi	a4,a5,8
     98c:	fae43c23          	sd	a4,-72(s0)
     990:	439c                	lw	a5,0(a5)
     992:	0ff7f713          	andi	a4,a5,255
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	85ba                	mv	a1,a4
     99c:	853e                	mv	a0,a5
     99e:	00000097          	auipc	ra,0x0
     9a2:	c54080e7          	jalr	-940(ra) # 5f2 <putc>
     9a6:	a899                	j	9fc <vprintf+0x23a>
      } else if(c == '%'){
     9a8:	fdc42783          	lw	a5,-36(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	02500793          	li	a5,37
     9b4:	00f71f63          	bne	a4,a5,9d2 <vprintf+0x210>
        putc(fd, c);
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0ff7f713          	andi	a4,a5,255
     9c0:	fcc42783          	lw	a5,-52(s0)
     9c4:	85ba                	mv	a1,a4
     9c6:	853e                	mv	a0,a5
     9c8:	00000097          	auipc	ra,0x0
     9cc:	c2a080e7          	jalr	-982(ra) # 5f2 <putc>
     9d0:	a035                	j	9fc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	02500593          	li	a1,37
     9da:	853e                	mv	a0,a5
     9dc:	00000097          	auipc	ra,0x0
     9e0:	c16080e7          	jalr	-1002(ra) # 5f2 <putc>
        putc(fd, c);
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0ff7f713          	andi	a4,a5,255
     9ec:	fcc42783          	lw	a5,-52(s0)
     9f0:	85ba                	mv	a1,a4
     9f2:	853e                	mv	a0,a5
     9f4:	00000097          	auipc	ra,0x0
     9f8:	bfe080e7          	jalr	-1026(ra) # 5f2 <putc>
      }
      state = 0;
     9fc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a00:	fe442783          	lw	a5,-28(s0)
     a04:	2785                	addiw	a5,a5,1
     a06:	fef42223          	sw	a5,-28(s0)
     a0a:	fe442783          	lw	a5,-28(s0)
     a0e:	fc043703          	ld	a4,-64(s0)
     a12:	97ba                	add	a5,a5,a4
     a14:	0007c783          	lbu	a5,0(a5)
     a18:	dc0795e3          	bnez	a5,7e2 <vprintf+0x20>
    }
  }
}
     a1c:	0001                	nop
     a1e:	0001                	nop
     a20:	60a6                	ld	ra,72(sp)
     a22:	6406                	ld	s0,64(sp)
     a24:	6161                	addi	sp,sp,80
     a26:	8082                	ret

0000000000000a28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a28:	7159                	addi	sp,sp,-112
     a2a:	fc06                	sd	ra,56(sp)
     a2c:	f822                	sd	s0,48(sp)
     a2e:	0080                	addi	s0,sp,64
     a30:	fcb43823          	sd	a1,-48(s0)
     a34:	e010                	sd	a2,0(s0)
     a36:	e414                	sd	a3,8(s0)
     a38:	e818                	sd	a4,16(s0)
     a3a:	ec1c                	sd	a5,24(s0)
     a3c:	03043023          	sd	a6,32(s0)
     a40:	03143423          	sd	a7,40(s0)
     a44:	87aa                	mv	a5,a0
     a46:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a4a:	03040793          	addi	a5,s0,48
     a4e:	fcf43423          	sd	a5,-56(s0)
     a52:	fc843783          	ld	a5,-56(s0)
     a56:	fd078793          	addi	a5,a5,-48
     a5a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a5e:	fe843703          	ld	a4,-24(s0)
     a62:	fdc42783          	lw	a5,-36(s0)
     a66:	863a                	mv	a2,a4
     a68:	fd043583          	ld	a1,-48(s0)
     a6c:	853e                	mv	a0,a5
     a6e:	00000097          	auipc	ra,0x0
     a72:	d54080e7          	jalr	-684(ra) # 7c2 <vprintf>
}
     a76:	0001                	nop
     a78:	70e2                	ld	ra,56(sp)
     a7a:	7442                	ld	s0,48(sp)
     a7c:	6165                	addi	sp,sp,112
     a7e:	8082                	ret

0000000000000a80 <printf>:

void
printf(const char *fmt, ...)
{
     a80:	7159                	addi	sp,sp,-112
     a82:	f406                	sd	ra,40(sp)
     a84:	f022                	sd	s0,32(sp)
     a86:	1800                	addi	s0,sp,48
     a88:	fca43c23          	sd	a0,-40(s0)
     a8c:	e40c                	sd	a1,8(s0)
     a8e:	e810                	sd	a2,16(s0)
     a90:	ec14                	sd	a3,24(s0)
     a92:	f018                	sd	a4,32(s0)
     a94:	f41c                	sd	a5,40(s0)
     a96:	03043823          	sd	a6,48(s0)
     a9a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a9e:	04040793          	addi	a5,s0,64
     aa2:	fcf43823          	sd	a5,-48(s0)
     aa6:	fd043783          	ld	a5,-48(s0)
     aaa:	fc878793          	addi	a5,a5,-56
     aae:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	863e                	mv	a2,a5
     ab8:	fd843583          	ld	a1,-40(s0)
     abc:	4505                	li	a0,1
     abe:	00000097          	auipc	ra,0x0
     ac2:	d04080e7          	jalr	-764(ra) # 7c2 <vprintf>
}
     ac6:	0001                	nop
     ac8:	70a2                	ld	ra,40(sp)
     aca:	7402                	ld	s0,32(sp)
     acc:	6165                	addi	sp,sp,112
     ace:	8082                	ret

0000000000000ad0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ad0:	7179                	addi	sp,sp,-48
     ad2:	f422                	sd	s0,40(sp)
     ad4:	1800                	addi	s0,sp,48
     ad6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ada:	fd843783          	ld	a5,-40(s0)
     ade:	17c1                	addi	a5,a5,-16
     ae0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ae4:	00001797          	auipc	a5,0x1
     ae8:	8e478793          	addi	a5,a5,-1820 # 13c8 <freep>
     aec:	639c                	ld	a5,0(a5)
     aee:	fef43423          	sd	a5,-24(s0)
     af2:	a815                	j	b26 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     af4:	fe843783          	ld	a5,-24(s0)
     af8:	639c                	ld	a5,0(a5)
     afa:	fe843703          	ld	a4,-24(s0)
     afe:	00f76f63          	bltu	a4,a5,b1c <free+0x4c>
     b02:	fe043703          	ld	a4,-32(s0)
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	02e7eb63          	bltu	a5,a4,b40 <free+0x70>
     b0e:	fe843783          	ld	a5,-24(s0)
     b12:	639c                	ld	a5,0(a5)
     b14:	fe043703          	ld	a4,-32(s0)
     b18:	02f76463          	bltu	a4,a5,b40 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b1c:	fe843783          	ld	a5,-24(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fef43423          	sd	a5,-24(s0)
     b26:	fe043703          	ld	a4,-32(s0)
     b2a:	fe843783          	ld	a5,-24(s0)
     b2e:	fce7f3e3          	bgeu	a5,a4,af4 <free+0x24>
     b32:	fe843783          	ld	a5,-24(s0)
     b36:	639c                	ld	a5,0(a5)
     b38:	fe043703          	ld	a4,-32(s0)
     b3c:	faf77ce3          	bgeu	a4,a5,af4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b40:	fe043783          	ld	a5,-32(s0)
     b44:	479c                	lw	a5,8(a5)
     b46:	1782                	slli	a5,a5,0x20
     b48:	9381                	srli	a5,a5,0x20
     b4a:	0792                	slli	a5,a5,0x4
     b4c:	fe043703          	ld	a4,-32(s0)
     b50:	973e                	add	a4,a4,a5
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	02f71763          	bne	a4,a5,b86 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b5c:	fe043783          	ld	a5,-32(s0)
     b60:	4798                	lw	a4,8(a5)
     b62:	fe843783          	ld	a5,-24(s0)
     b66:	639c                	ld	a5,0(a5)
     b68:	479c                	lw	a5,8(a5)
     b6a:	9fb9                	addw	a5,a5,a4
     b6c:	0007871b          	sext.w	a4,a5
     b70:	fe043783          	ld	a5,-32(s0)
     b74:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	6398                	ld	a4,0(a5)
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	e398                	sd	a4,0(a5)
     b84:	a039                	j	b92 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	6398                	ld	a4,0(a5)
     b8c:	fe043783          	ld	a5,-32(s0)
     b90:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	479c                	lw	a5,8(a5)
     b98:	1782                	slli	a5,a5,0x20
     b9a:	9381                	srli	a5,a5,0x20
     b9c:	0792                	slli	a5,a5,0x4
     b9e:	fe843703          	ld	a4,-24(s0)
     ba2:	97ba                	add	a5,a5,a4
     ba4:	fe043703          	ld	a4,-32(s0)
     ba8:	02f71563          	bne	a4,a5,bd2 <free+0x102>
    p->s.size += bp->s.size;
     bac:	fe843783          	ld	a5,-24(s0)
     bb0:	4798                	lw	a4,8(a5)
     bb2:	fe043783          	ld	a5,-32(s0)
     bb6:	479c                	lw	a5,8(a5)
     bb8:	9fb9                	addw	a5,a5,a4
     bba:	0007871b          	sext.w	a4,a5
     bbe:	fe843783          	ld	a5,-24(s0)
     bc2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	6398                	ld	a4,0(a5)
     bca:	fe843783          	ld	a5,-24(s0)
     bce:	e398                	sd	a4,0(a5)
     bd0:	a031                	j	bdc <free+0x10c>
  } else
    p->s.ptr = bp;
     bd2:	fe843783          	ld	a5,-24(s0)
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	e398                	sd	a4,0(a5)
  freep = p;
     bdc:	00000797          	auipc	a5,0x0
     be0:	7ec78793          	addi	a5,a5,2028 # 13c8 <freep>
     be4:	fe843703          	ld	a4,-24(s0)
     be8:	e398                	sd	a4,0(a5)
}
     bea:	0001                	nop
     bec:	7422                	ld	s0,40(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <morecore>:

static Header*
morecore(uint nu)
{
     bf2:	7179                	addi	sp,sp,-48
     bf4:	f406                	sd	ra,40(sp)
     bf6:	f022                	sd	s0,32(sp)
     bf8:	1800                	addi	s0,sp,48
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c00:	fdc42783          	lw	a5,-36(s0)
     c04:	0007871b          	sext.w	a4,a5
     c08:	6785                	lui	a5,0x1
     c0a:	00f77563          	bgeu	a4,a5,c14 <morecore+0x22>
    nu = 4096;
     c0e:	6785                	lui	a5,0x1
     c10:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c14:	fdc42783          	lw	a5,-36(s0)
     c18:	0047979b          	slliw	a5,a5,0x4
     c1c:	2781                	sext.w	a5,a5
     c1e:	2781                	sext.w	a5,a5
     c20:	853e                	mv	a0,a5
     c22:	00000097          	auipc	ra,0x0
     c26:	9a0080e7          	jalr	-1632(ra) # 5c2 <sbrk>
     c2a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c2e:	fe843703          	ld	a4,-24(s0)
     c32:	57fd                	li	a5,-1
     c34:	00f71463          	bne	a4,a5,c3c <morecore+0x4a>
    return 0;
     c38:	4781                	li	a5,0
     c3a:	a03d                	j	c68 <morecore+0x76>
  hp = (Header*)p;
     c3c:	fe843783          	ld	a5,-24(s0)
     c40:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	fdc42703          	lw	a4,-36(s0)
     c4c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c4e:	fe043783          	ld	a5,-32(s0)
     c52:	07c1                	addi	a5,a5,16
     c54:	853e                	mv	a0,a5
     c56:	00000097          	auipc	ra,0x0
     c5a:	e7a080e7          	jalr	-390(ra) # ad0 <free>
  return freep;
     c5e:	00000797          	auipc	a5,0x0
     c62:	76a78793          	addi	a5,a5,1898 # 13c8 <freep>
     c66:	639c                	ld	a5,0(a5)
}
     c68:	853e                	mv	a0,a5
     c6a:	70a2                	ld	ra,40(sp)
     c6c:	7402                	ld	s0,32(sp)
     c6e:	6145                	addi	sp,sp,48
     c70:	8082                	ret

0000000000000c72 <malloc>:

void*
malloc(uint nbytes)
{
     c72:	7139                	addi	sp,sp,-64
     c74:	fc06                	sd	ra,56(sp)
     c76:	f822                	sd	s0,48(sp)
     c78:	0080                	addi	s0,sp,64
     c7a:	87aa                	mv	a5,a0
     c7c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c80:	fcc46783          	lwu	a5,-52(s0)
     c84:	07bd                	addi	a5,a5,15
     c86:	8391                	srli	a5,a5,0x4
     c88:	2781                	sext.w	a5,a5
     c8a:	2785                	addiw	a5,a5,1
     c8c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c90:	00000797          	auipc	a5,0x0
     c94:	73878793          	addi	a5,a5,1848 # 13c8 <freep>
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43023          	sd	a5,-32(s0)
     c9e:	fe043783          	ld	a5,-32(s0)
     ca2:	ef95                	bnez	a5,cde <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ca4:	00000797          	auipc	a5,0x0
     ca8:	71478793          	addi	a5,a5,1812 # 13b8 <base>
     cac:	fef43023          	sd	a5,-32(s0)
     cb0:	00000797          	auipc	a5,0x0
     cb4:	71878793          	addi	a5,a5,1816 # 13c8 <freep>
     cb8:	fe043703          	ld	a4,-32(s0)
     cbc:	e398                	sd	a4,0(a5)
     cbe:	00000797          	auipc	a5,0x0
     cc2:	70a78793          	addi	a5,a5,1802 # 13c8 <freep>
     cc6:	6398                	ld	a4,0(a5)
     cc8:	00000797          	auipc	a5,0x0
     ccc:	6f078793          	addi	a5,a5,1776 # 13b8 <base>
     cd0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cd2:	00000797          	auipc	a5,0x0
     cd6:	6e678793          	addi	a5,a5,1766 # 13b8 <base>
     cda:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cde:	fe043783          	ld	a5,-32(s0)
     ce2:	639c                	ld	a5,0(a5)
     ce4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ce8:	fe843783          	ld	a5,-24(s0)
     cec:	4798                	lw	a4,8(a5)
     cee:	fdc42783          	lw	a5,-36(s0)
     cf2:	2781                	sext.w	a5,a5
     cf4:	06f76863          	bltu	a4,a5,d64 <malloc+0xf2>
      if(p->s.size == nunits)
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	4798                	lw	a4,8(a5)
     cfe:	fdc42783          	lw	a5,-36(s0)
     d02:	2781                	sext.w	a5,a5
     d04:	00e79963          	bne	a5,a4,d16 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	6398                	ld	a4,0(a5)
     d0e:	fe043783          	ld	a5,-32(s0)
     d12:	e398                	sd	a4,0(a5)
     d14:	a82d                	j	d4e <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	4798                	lw	a4,8(a5)
     d1c:	fdc42783          	lw	a5,-36(s0)
     d20:	40f707bb          	subw	a5,a4,a5
     d24:	0007871b          	sext.w	a4,a5
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	479c                	lw	a5,8(a5)
     d34:	1782                	slli	a5,a5,0x20
     d36:	9381                	srli	a5,a5,0x20
     d38:	0792                	slli	a5,a5,0x4
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	97ba                	add	a5,a5,a4
     d40:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d44:	fe843783          	ld	a5,-24(s0)
     d48:	fdc42703          	lw	a4,-36(s0)
     d4c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d4e:	00000797          	auipc	a5,0x0
     d52:	67a78793          	addi	a5,a5,1658 # 13c8 <freep>
     d56:	fe043703          	ld	a4,-32(s0)
     d5a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	07c1                	addi	a5,a5,16
     d62:	a091                	j	da6 <malloc+0x134>
    }
    if(p == freep)
     d64:	00000797          	auipc	a5,0x0
     d68:	66478793          	addi	a5,a5,1636 # 13c8 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fe843703          	ld	a4,-24(s0)
     d72:	02f71063          	bne	a4,a5,d92 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d76:	fdc42783          	lw	a5,-36(s0)
     d7a:	853e                	mv	a0,a5
     d7c:	00000097          	auipc	ra,0x0
     d80:	e76080e7          	jalr	-394(ra) # bf2 <morecore>
     d84:	fea43423          	sd	a0,-24(s0)
     d88:	fe843783          	ld	a5,-24(s0)
     d8c:	e399                	bnez	a5,d92 <malloc+0x120>
        return 0;
     d8e:	4781                	li	a5,0
     d90:	a819                	j	da6 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	fef43023          	sd	a5,-32(s0)
     d9a:	fe843783          	ld	a5,-24(s0)
     d9e:	639c                	ld	a5,0(a5)
     da0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     da4:	b791                	j	ce8 <malloc+0x76>
  }
}
     da6:	853e                	mv	a0,a5
     da8:	70e2                	ld	ra,56(sp)
     daa:	7442                	ld	s0,48(sp)
     dac:	6121                	addi	sp,sp,64
     dae:	8082                	ret

0000000000000db0 <setjmp>:
     db0:	e100                	sd	s0,0(a0)
     db2:	e504                	sd	s1,8(a0)
     db4:	01253823          	sd	s2,16(a0)
     db8:	01353c23          	sd	s3,24(a0)
     dbc:	03453023          	sd	s4,32(a0)
     dc0:	03553423          	sd	s5,40(a0)
     dc4:	03653823          	sd	s6,48(a0)
     dc8:	03753c23          	sd	s7,56(a0)
     dcc:	05853023          	sd	s8,64(a0)
     dd0:	05953423          	sd	s9,72(a0)
     dd4:	05a53823          	sd	s10,80(a0)
     dd8:	05b53c23          	sd	s11,88(a0)
     ddc:	06153023          	sd	ra,96(a0)
     de0:	06253423          	sd	sp,104(a0)
     de4:	4501                	li	a0,0
     de6:	8082                	ret

0000000000000de8 <longjmp>:
     de8:	6100                	ld	s0,0(a0)
     dea:	6504                	ld	s1,8(a0)
     dec:	01053903          	ld	s2,16(a0)
     df0:	01853983          	ld	s3,24(a0)
     df4:	02053a03          	ld	s4,32(a0)
     df8:	02853a83          	ld	s5,40(a0)
     dfc:	03053b03          	ld	s6,48(a0)
     e00:	03853b83          	ld	s7,56(a0)
     e04:	04053c03          	ld	s8,64(a0)
     e08:	04853c83          	ld	s9,72(a0)
     e0c:	05053d03          	ld	s10,80(a0)
     e10:	05853d83          	ld	s11,88(a0)
     e14:	06053083          	ld	ra,96(a0)
     e18:	06853103          	ld	sp,104(a0)
     e1c:	c199                	beqz	a1,e22 <longjmp_1>
     e1e:	852e                	mv	a0,a1
     e20:	8082                	ret

0000000000000e22 <longjmp_1>:
     e22:	4505                	li	a0,1
     e24:	8082                	ret

0000000000000e26 <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
     e26:	7139                	addi	sp,sp,-64
     e28:	fc22                	sd	s0,56(sp)
     e2a:	0080                	addi	s0,sp,64
     e2c:	fca43423          	sd	a0,-56(s0)
     e30:	87ae                	mv	a5,a1
     e32:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
     e36:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
     e3a:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     e3e:	fc843783          	ld	a5,-56(s0)
     e42:	639c                	ld	a5,0(a5)
     e44:	fcf43c23          	sd	a5,-40(s0)
     e48:	fd843783          	ld	a5,-40(s0)
     e4c:	fd878793          	addi	a5,a5,-40
     e50:	fef43423          	sd	a5,-24(s0)
     e54:	a881                	j	ea4 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
     e56:	fe843783          	ld	a5,-24(s0)
     e5a:	4fb8                	lw	a4,88(a5)
     e5c:	fc442783          	lw	a5,-60(s0)
     e60:	2781                	sext.w	a5,a5
     e62:	02e7c663          	blt	a5,a4,e8e <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
     e66:	fe043783          	ld	a5,-32(s0)
     e6a:	e791                	bnez	a5,e76 <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	fef43023          	sd	a5,-32(s0)
     e74:	a829                	j	e8e <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	5fd8                	lw	a4,60(a5)
     e7c:	fe043783          	ld	a5,-32(s0)
     e80:	5fdc                	lw	a5,60(a5)
     e82:	00f75663          	bge	a4,a5,e8e <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     e8e:	fe843783          	ld	a5,-24(s0)
     e92:	779c                	ld	a5,40(a5)
     e94:	fcf43823          	sd	a5,-48(s0)
     e98:	fd043783          	ld	a5,-48(s0)
     e9c:	fd878793          	addi	a5,a5,-40
     ea0:	fef43423          	sd	a5,-24(s0)
     ea4:	fe843783          	ld	a5,-24(s0)
     ea8:	02878793          	addi	a5,a5,40
     eac:	fc843703          	ld	a4,-56(s0)
     eb0:	faf713e3          	bne	a4,a5,e56 <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
     eb4:	fe043783          	ld	a5,-32(s0)
}
     eb8:	853e                	mv	a0,a5
     eba:	7462                	ld	s0,56(sp)
     ebc:	6121                	addi	sp,sp,64
     ebe:	8082                	ret

0000000000000ec0 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
     ec0:	1101                	addi	sp,sp,-32
     ec2:	ec22                	sd	s0,24(sp)
     ec4:	1000                	addi	s0,sp,32
     ec6:	fea43423          	sd	a0,-24(s0)
     eca:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	57fc                	lw	a5,108(a5)
     ed4:	c799                	beqz	a5,ee2 <__edf_thread_cmp+0x22>
     ed6:	fe043783          	ld	a5,-32(s0)
     eda:	57fc                	lw	a5,108(a5)
     edc:	e399                	bnez	a5,ee2 <__edf_thread_cmp+0x22>
     ede:	57fd                	li	a5,-1
     ee0:	a0a5                	j	f48 <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
     ee2:	fe843783          	ld	a5,-24(s0)
     ee6:	57fc                	lw	a5,108(a5)
     ee8:	e799                	bnez	a5,ef6 <__edf_thread_cmp+0x36>
     eea:	fe043783          	ld	a5,-32(s0)
     eee:	57fc                	lw	a5,108(a5)
     ef0:	c399                	beqz	a5,ef6 <__edf_thread_cmp+0x36>
     ef2:	4785                	li	a5,1
     ef4:	a891                	j	f48 <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
     ef6:	fe843783          	ld	a5,-24(s0)
     efa:	4fb8                	lw	a4,88(a5)
     efc:	fe043783          	ld	a5,-32(s0)
     f00:	4fbc                	lw	a5,88(a5)
     f02:	00f75463          	bge	a4,a5,f0a <__edf_thread_cmp+0x4a>
     f06:	57fd                	li	a5,-1
     f08:	a081                	j	f48 <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	4fb8                	lw	a4,88(a5)
     f10:	fe043783          	ld	a5,-32(s0)
     f14:	4fbc                	lw	a5,88(a5)
     f16:	00e7d463          	bge	a5,a4,f1e <__edf_thread_cmp+0x5e>
     f1a:	4785                	li	a5,1
     f1c:	a035                	j	f48 <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
     f1e:	fe843783          	ld	a5,-24(s0)
     f22:	5fd8                	lw	a4,60(a5)
     f24:	fe043783          	ld	a5,-32(s0)
     f28:	5fdc                	lw	a5,60(a5)
     f2a:	00f75463          	bge	a4,a5,f32 <__edf_thread_cmp+0x72>
     f2e:	57fd                	li	a5,-1
     f30:	a821                	j	f48 <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
     f32:	fe843783          	ld	a5,-24(s0)
     f36:	5fd8                	lw	a4,60(a5)
     f38:	fe043783          	ld	a5,-32(s0)
     f3c:	5fdc                	lw	a5,60(a5)
     f3e:	00e7d463          	bge	a5,a4,f46 <__edf_thread_cmp+0x86>
     f42:	4785                	li	a5,1
     f44:	a011                	j	f48 <__edf_thread_cmp+0x88>
    
    return 0;
     f46:	4781                	li	a5,0
}
     f48:	853e                	mv	a0,a5
     f4a:	6462                	ld	s0,24(sp)
     f4c:	6105                	addi	sp,sp,32
     f4e:	8082                	ret

0000000000000f50 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
     f50:	7151                	addi	sp,sp,-240
     f52:	f586                	sd	ra,232(sp)
     f54:	f1a2                	sd	s0,224(sp)
     f56:	eda6                	sd	s1,216(sp)
     f58:	e9ca                	sd	s2,208(sp)
     f5a:	e5ce                	sd	s3,200(sp)
     f5c:	1980                	addi	s0,sp,240
     f5e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
     f60:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
     f64:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
     f68:	649c                	ld	a5,8(s1)
     f6a:	639c                	ld	a5,0(a5)
     f6c:	f8f43c23          	sd	a5,-104(s0)
     f70:	f9843783          	ld	a5,-104(s0)
     f74:	fd878793          	addi	a5,a5,-40
     f78:	fcf43423          	sd	a5,-56(s0)
     f7c:	a8b1                	j	fd8 <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     f7e:	fc843783          	ld	a5,-56(s0)
     f82:	57bc                	lw	a5,104(a5)
     f84:	02f04f63          	bgtz	a5,fc2 <schedule_edf_cbs+0x72>
     f88:	fc843783          	ld	a5,-56(s0)
     f8c:	4bfc                	lw	a5,84(a5)
     f8e:	02f05a63          	blez	a5,fc2 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
     f92:	4098                	lw	a4,0(s1)
     f94:	fc843783          	ld	a5,-56(s0)
     f98:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     f9a:	02f71463          	bne	a4,a5,fc2 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
     f9e:	fc843783          	ld	a5,-56(s0)
     fa2:	4fb8                	lw	a4,88(a5)
     fa4:	fc843783          	ld	a5,-56(s0)
     fa8:	47fc                	lw	a5,76(a5)
     faa:	9fb9                	addw	a5,a5,a4
     fac:	0007871b          	sext.w	a4,a5
     fb0:	fc843783          	ld	a5,-56(s0)
     fb4:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
     fb6:	fc843783          	ld	a5,-56(s0)
     fba:	53f8                	lw	a4,100(a5)
     fbc:	fc843783          	ld	a5,-56(s0)
     fc0:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
     fc2:	fc843783          	ld	a5,-56(s0)
     fc6:	779c                	ld	a5,40(a5)
     fc8:	f2f43823          	sd	a5,-208(s0)
     fcc:	f3043783          	ld	a5,-208(s0)
     fd0:	fd878793          	addi	a5,a5,-40
     fd4:	fcf43423          	sd	a5,-56(s0)
     fd8:	fc843783          	ld	a5,-56(s0)
     fdc:	02878713          	addi	a4,a5,40
     fe0:	649c                	ld	a5,8(s1)
     fe2:	f8f71ee3          	bne	a4,a5,f7e <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
     fe6:	649c                	ld	a5,8(s1)
     fe8:	4098                	lw	a4,0(s1)
     fea:	85ba                	mv	a1,a4
     fec:	853e                	mv	a0,a5
     fee:	00000097          	auipc	ra,0x0
     ff2:	e38080e7          	jalr	-456(ra) # e26 <__check_deadline_miss>
     ff6:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
     ffa:	f9043783          	ld	a5,-112(s0)
     ffe:	c395                	beqz	a5,1022 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
    1000:	f9043783          	ld	a5,-112(s0)
    1004:	02878793          	addi	a5,a5,40
    1008:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
    100c:	f0042c23          	sw	zero,-232(s0)
        return r;
    1010:	f1043783          	ld	a5,-240(s0)
    1014:	f2f43023          	sd	a5,-224(s0)
    1018:	f1843783          	ld	a5,-232(s0)
    101c:	f2f43423          	sd	a5,-216(s0)
    1020:	ae19                	j	1336 <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
    1022:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1026:	649c                	ld	a5,8(s1)
    1028:	639c                	ld	a5,0(a5)
    102a:	f8f43423          	sd	a5,-120(s0)
    102e:	f8843783          	ld	a5,-120(s0)
    1032:	fd878793          	addi	a5,a5,-40
    1036:	fcf43423          	sd	a5,-56(s0)
    103a:	a0ad                	j	10a4 <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
    103c:	fc843783          	ld	a5,-56(s0)
    1040:	4bfc                	lw	a5,84(a5)
    1042:	04f05563          	blez	a5,108c <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1046:	fc843783          	ld	a5,-56(s0)
    104a:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
    104c:	00f04d63          	bgtz	a5,1066 <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1050:	fc843783          	ld	a5,-56(s0)
    1054:	4bfc                	lw	a5,84(a5)
    1056:	00f05863          	blez	a5,1066 <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
    105a:	4098                	lw	a4,0(s1)
    105c:	fc843783          	ld	a5,-56(s0)
    1060:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1062:	02f74563          	blt	a4,a5,108c <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
    1066:	fc043783          	ld	a5,-64(s0)
    106a:	cf81                	beqz	a5,1082 <schedule_edf_cbs+0x132>
    106c:	fc043583          	ld	a1,-64(s0)
    1070:	fc843503          	ld	a0,-56(s0)
    1074:	00000097          	auipc	ra,0x0
    1078:	e4c080e7          	jalr	-436(ra) # ec0 <__edf_thread_cmp>
    107c:	87aa                	mv	a5,a0
    107e:	0007d863          	bgez	a5,108e <schedule_edf_cbs+0x13e>
            selected = t;
    1082:	fc843783          	ld	a5,-56(s0)
    1086:	fcf43023          	sd	a5,-64(s0)
    108a:	a011                	j	108e <schedule_edf_cbs+0x13e>
            continue;
    108c:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
    108e:	fc843783          	ld	a5,-56(s0)
    1092:	779c                	ld	a5,40(a5)
    1094:	f2f43c23          	sd	a5,-200(s0)
    1098:	f3843783          	ld	a5,-200(s0)
    109c:	fd878793          	addi	a5,a5,-40
    10a0:	fcf43423          	sd	a5,-56(s0)
    10a4:	fc843783          	ld	a5,-56(s0)
    10a8:	02878713          	addi	a4,a5,40
    10ac:	649c                	ld	a5,8(s1)
    10ae:	f8f717e3          	bne	a4,a5,103c <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    10b2:	fc043783          	ld	a5,-64(s0)
    10b6:	ebd5                	bnez	a5,116a <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    10b8:	800007b7          	lui	a5,0x80000
    10bc:	fff7c793          	not	a5,a5
    10c0:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    10c4:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    10c8:	689c                	ld	a5,16(s1)
    10ca:	639c                	ld	a5,0(a5)
    10cc:	f4f43423          	sd	a5,-184(s0)
    10d0:	f4843783          	ld	a5,-184(s0)
    10d4:	17e1                	addi	a5,a5,-8
    10d6:	faf43823          	sd	a5,-80(s0)
    10da:	a835                	j	1116 <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    10dc:	fb043783          	ld	a5,-80(s0)
    10e0:	4f98                	lw	a4,24(a5)
    10e2:	409c                	lw	a5,0(s1)
    10e4:	00e7df63          	bge	a5,a4,1102 <schedule_edf_cbs+0x1b2>
    10e8:	fb043783          	ld	a5,-80(s0)
    10ec:	4f98                	lw	a4,24(a5)
    10ee:	fbc42783          	lw	a5,-68(s0)
    10f2:	2781                	sext.w	a5,a5
    10f4:	00f75763          	bge	a4,a5,1102 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    10f8:	fb043783          	ld	a5,-80(s0)
    10fc:	4f9c                	lw	a5,24(a5)
    10fe:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1102:	fb043783          	ld	a5,-80(s0)
    1106:	679c                	ld	a5,8(a5)
    1108:	f4f43023          	sd	a5,-192(s0)
    110c:	f4043783          	ld	a5,-192(s0)
    1110:	17e1                	addi	a5,a5,-8
    1112:	faf43823          	sd	a5,-80(s0)
    1116:	fb043783          	ld	a5,-80(s0)
    111a:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffe468>
    111e:	689c                	ld	a5,16(s1)
    1120:	faf71ee3          	bne	a4,a5,10dc <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    1124:	fbc42783          	lw	a5,-68(s0)
    1128:	0007871b          	sext.w	a4,a5
    112c:	800007b7          	lui	a5,0x80000
    1130:	fff7c793          	not	a5,a5
    1134:	00f70e63          	beq	a4,a5,1150 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    1138:	649c                	ld	a5,8(s1)
    113a:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    113e:	409c                	lw	a5,0(s1)
    1140:	fbc42703          	lw	a4,-68(s0)
    1144:	40f707bb          	subw	a5,a4,a5
    1148:	2781                	sext.w	a5,a5
    114a:	f0f42c23          	sw	a5,-232(s0)
    114e:	a029                	j	1158 <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    1150:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    1154:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    1158:	f1043783          	ld	a5,-240(s0)
    115c:	f2f43023          	sd	a5,-224(s0)
    1160:	f1843783          	ld	a5,-232(s0)
    1164:	f2f43423          	sd	a5,-216(s0)
    1168:	a2f9                	j	1336 <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    116a:	fc043783          	ld	a5,-64(s0)
    116e:	57fc                	lw	a5,108(a5)
    1170:	e7f1                	bnez	a5,123c <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    1172:	fc043783          	ld	a5,-64(s0)
    1176:	57bc                	lw	a5,104(a5)
    1178:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    117c:	fc043783          	ld	a5,-64(s0)
    1180:	4fb8                	lw	a4,88(a5)
    1182:	409c                	lw	a5,0(s1)
    1184:	40f707bb          	subw	a5,a4,a5
    1188:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    118c:	fc043783          	ld	a5,-64(s0)
    1190:	47fc                	lw	a5,76(a5)
    1192:	f5c42703          	lw	a4,-164(s0)
    1196:	02f707bb          	mulw	a5,a4,a5
    119a:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    119e:	fc043783          	ld	a5,-64(s0)
    11a2:	53fc                	lw	a5,100(a5)
    11a4:	f5842703          	lw	a4,-168(s0)
    11a8:	02f707bb          	mulw	a5,a4,a5
    11ac:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    11b0:	f5442703          	lw	a4,-172(s0)
    11b4:	f5042783          	lw	a5,-176(s0)
    11b8:	2701                	sext.w	a4,a4
    11ba:	2781                	sext.w	a5,a5
    11bc:	02e7d363          	bge	a5,a4,11e2 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    11c0:	4098                	lw	a4,0(s1)
    11c2:	fc043783          	ld	a5,-64(s0)
    11c6:	47fc                	lw	a5,76(a5)
    11c8:	9fb9                	addw	a5,a5,a4
    11ca:	0007871b          	sext.w	a4,a5
    11ce:	fc043783          	ld	a5,-64(s0)
    11d2:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    11d4:	fc043783          	ld	a5,-64(s0)
    11d8:	53f8                	lw	a4,100(a5)
    11da:	fc043783          	ld	a5,-64(s0)
    11de:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    11e0:	b341                	j	f60 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    11e2:	fc043783          	ld	a5,-64(s0)
    11e6:	57bc                	lw	a5,104(a5)
    11e8:	02f04063          	bgtz	a5,1208 <schedule_edf_cbs+0x2b8>
    11ec:	fc043783          	ld	a5,-64(s0)
    11f0:	4bfc                	lw	a5,84(a5)
    11f2:	00f05b63          	blez	a5,1208 <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    11f6:	fc043783          	ld	a5,-64(s0)
    11fa:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe488>
    11fe:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    1202:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    1206:	bba9                	j	f60 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    1208:	fc043783          	ld	a5,-64(s0)
    120c:	02878793          	addi	a5,a5,40
    1210:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1214:	fc043783          	ld	a5,-64(s0)
    1218:	57b8                	lw	a4,104(a5)
    121a:	fc043783          	ld	a5,-64(s0)
    121e:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    1220:	863e                	mv	a2,a5
    1222:	86ba                	mv	a3,a4
    1224:	0006871b          	sext.w	a4,a3
    1228:	0006079b          	sext.w	a5,a2
    122c:	00e7d363          	bge	a5,a4,1232 <schedule_edf_cbs+0x2e2>
    1230:	86b2                	mv	a3,a2
    1232:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1236:	f0f42c23          	sw	a5,-232(s0)
    123a:	a0f5                	j	1326 <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    123c:	fc043783          	ld	a5,-64(s0)
    1240:	4bfc                	lw	a5,84(a5)
    1242:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    1246:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    124a:	689c                	ld	a5,16(s1)
    124c:	639c                	ld	a5,0(a5)
    124e:	f8f43023          	sd	a5,-128(s0)
    1252:	f8043783          	ld	a5,-128(s0)
    1256:	17e1                	addi	a5,a5,-8
    1258:	faf43023          	sd	a5,-96(s0)
    125c:	a041                	j	12dc <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    125e:	fa043783          	ld	a5,-96(s0)
    1262:	639c                	ld	a5,0(a5)
    1264:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    1268:	f7043783          	ld	a5,-144(s0)
    126c:	53b8                	lw	a4,96(a5)
    126e:	409c                	lw	a5,0(s1)
    1270:	04e7dc63          	bge	a5,a4,12c8 <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    1274:	f7043783          	ld	a5,-144(s0)
    1278:	53b4                	lw	a3,96(a5)
    127a:	409c                	lw	a5,0(s1)
    127c:	fac42703          	lw	a4,-84(s0)
    1280:	9fb9                	addw	a5,a5,a4
    1282:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    1284:	8736                	mv	a4,a3
    1286:	04f75163          	bge	a4,a5,12c8 <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    128a:	fc043583          	ld	a1,-64(s0)
    128e:	f7043503          	ld	a0,-144(s0)
    1292:	00000097          	auipc	ra,0x0
    1296:	c2e080e7          	jalr	-978(ra) # ec0 <__edf_thread_cmp>
    129a:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    129c:	0207d663          	bgez	a5,12c8 <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    12a0:	f7043783          	ld	a5,-144(s0)
    12a4:	53b8                	lw	a4,96(a5)
    12a6:	409c                	lw	a5,0(s1)
    12a8:	40f707bb          	subw	a5,a4,a5
    12ac:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    12b0:	f6c42703          	lw	a4,-148(s0)
    12b4:	fac42783          	lw	a5,-84(s0)
    12b8:	2701                	sext.w	a4,a4
    12ba:	2781                	sext.w	a5,a5
    12bc:	00f75663          	bge	a4,a5,12c8 <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    12c0:	f6c42783          	lw	a5,-148(s0)
    12c4:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    12c8:	fa043783          	ld	a5,-96(s0)
    12cc:	679c                	ld	a5,8(a5)
    12ce:	f6f43023          	sd	a5,-160(s0)
    12d2:	f6043783          	ld	a5,-160(s0)
    12d6:	17e1                	addi	a5,a5,-8
    12d8:	faf43023          	sd	a5,-96(s0)
    12dc:	fa043783          	ld	a5,-96(s0)
    12e0:	00878713          	addi	a4,a5,8
    12e4:	689c                	ld	a5,16(s1)
    12e6:	f6f71ce3          	bne	a4,a5,125e <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    12ea:	fc043783          	ld	a5,-64(s0)
    12ee:	4fb8                	lw	a4,88(a5)
    12f0:	409c                	lw	a5,0(s1)
    12f2:	40f707bb          	subw	a5,a4,a5
    12f6:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    12fa:	f7c42703          	lw	a4,-132(s0)
    12fe:	fac42783          	lw	a5,-84(s0)
    1302:	2701                	sext.w	a4,a4
    1304:	2781                	sext.w	a5,a5
    1306:	00f75663          	bge	a4,a5,1312 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    130a:	f7c42783          	lw	a5,-132(s0)
    130e:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    1312:	fc043783          	ld	a5,-64(s0)
    1316:	02878793          	addi	a5,a5,40
    131a:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    131e:	fac42783          	lw	a5,-84(s0)
    1322:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    1326:	f1043783          	ld	a5,-240(s0)
    132a:	f2f43023          	sd	a5,-224(s0)
    132e:	f1843783          	ld	a5,-232(s0)
    1332:	f2f43423          	sd	a5,-216(s0)
    1336:	4701                	li	a4,0
    1338:	f2043703          	ld	a4,-224(s0)
    133c:	4781                	li	a5,0
    133e:	f2843783          	ld	a5,-216(s0)
    1342:	893a                	mv	s2,a4
    1344:	89be                	mv	s3,a5
    1346:	874a                	mv	a4,s2
    1348:	87ce                	mv	a5,s3
}
    134a:	853a                	mv	a0,a4
    134c:	85be                	mv	a1,a5
    134e:	70ae                	ld	ra,232(sp)
    1350:	740e                	ld	s0,224(sp)
    1352:	64ee                	ld	s1,216(sp)
    1354:	694e                	ld	s2,208(sp)
    1356:	69ae                	ld	s3,200(sp)
    1358:	616d                	addi	sp,sp,240
    135a:	8082                	ret
