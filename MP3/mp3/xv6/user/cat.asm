
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
       e:	a091                	j	52 <cat+0x52>
    if (write(1, buf, n) != n) {
      10:	fec42783          	lw	a5,-20(s0)
      14:	863e                	mv	a2,a5
      16:	00001597          	auipc	a1,0x1
      1a:	48258593          	addi	a1,a1,1154 # 1498 <buf>
      1e:	4505                	li	a0,1
      20:	00000097          	auipc	ra,0x0
      24:	60e080e7          	jalr	1550(ra) # 62e <write>
      28:	87aa                	mv	a5,a0
      2a:	873e                	mv	a4,a5
      2c:	fec42783          	lw	a5,-20(s0)
      30:	2781                	sext.w	a5,a5
      32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
      36:	00001597          	auipc	a1,0x1
      3a:	3fa58593          	addi	a1,a1,1018 # 1430 <schedule_edf_cbs+0x40c>
      3e:	4509                	li	a0,2
      40:	00001097          	auipc	ra,0x1
      44:	abc080e7          	jalr	-1348(ra) # afc <fprintf>
      exit(1);
      48:	4505                	li	a0,1
      4a:	00000097          	auipc	ra,0x0
      4e:	5c4080e7          	jalr	1476(ra) # 60e <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
      52:	fdc42783          	lw	a5,-36(s0)
      56:	20000613          	li	a2,512
      5a:	00001597          	auipc	a1,0x1
      5e:	43e58593          	addi	a1,a1,1086 # 1498 <buf>
      62:	853e                	mv	a0,a5
      64:	00000097          	auipc	ra,0x0
      68:	5c2080e7          	jalr	1474(ra) # 626 <read>
      6c:	87aa                	mv	a5,a0
      6e:	fef42623          	sw	a5,-20(s0)
      72:	fec42783          	lw	a5,-20(s0)
      76:	2781                	sext.w	a5,a5
      78:	f8f04ce3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
      7c:	fec42783          	lw	a5,-20(s0)
      80:	2781                	sext.w	a5,a5
      82:	0207d063          	bgez	a5,a2 <cat+0xa2>
    fprintf(2, "cat: read error\n");
      86:	00001597          	auipc	a1,0x1
      8a:	3c258593          	addi	a1,a1,962 # 1448 <schedule_edf_cbs+0x424>
      8e:	4509                	li	a0,2
      90:	00001097          	auipc	ra,0x1
      94:	a6c080e7          	jalr	-1428(ra) # afc <fprintf>
    exit(1);
      98:	4505                	li	a0,1
      9a:	00000097          	auipc	ra,0x0
      9e:	574080e7          	jalr	1396(ra) # 60e <exit>
  }
}
      a2:	0001                	nop
      a4:	70a2                	ld	ra,40(sp)
      a6:	7402                	ld	s0,32(sp)
      a8:	6145                	addi	sp,sp,48
      aa:	8082                	ret

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
      ac:	7179                	addi	sp,sp,-48
      ae:	f406                	sd	ra,40(sp)
      b0:	f022                	sd	s0,32(sp)
      b2:	1800                	addi	s0,sp,48
      b4:	87aa                	mv	a5,a0
      b6:	fcb43823          	sd	a1,-48(s0)
      ba:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
      be:	fdc42783          	lw	a5,-36(s0)
      c2:	0007871b          	sext.w	a4,a5
      c6:	4785                	li	a5,1
      c8:	00e7cc63          	blt	a5,a4,e0 <main+0x34>
    cat(0);
      cc:	4501                	li	a0,0
      ce:	00000097          	auipc	ra,0x0
      d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    exit(0);
      d6:	4501                	li	a0,0
      d8:	00000097          	auipc	ra,0x0
      dc:	536080e7          	jalr	1334(ra) # 60e <exit>
  }

  for(i = 1; i < argc; i++){
      e0:	4785                	li	a5,1
      e2:	fef42623          	sw	a5,-20(s0)
      e6:	a8bd                	j	164 <main+0xb8>
    if((fd = open(argv[i], 0)) < 0){
      e8:	fec42783          	lw	a5,-20(s0)
      ec:	078e                	slli	a5,a5,0x3
      ee:	fd043703          	ld	a4,-48(s0)
      f2:	97ba                	add	a5,a5,a4
      f4:	639c                	ld	a5,0(a5)
      f6:	4581                	li	a1,0
      f8:	853e                	mv	a0,a5
      fa:	00000097          	auipc	ra,0x0
      fe:	554080e7          	jalr	1364(ra) # 64e <open>
     102:	87aa                	mv	a5,a0
     104:	fef42423          	sw	a5,-24(s0)
     108:	fe842783          	lw	a5,-24(s0)
     10c:	2781                	sext.w	a5,a5
     10e:	0207d863          	bgez	a5,13e <main+0x92>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
     112:	fec42783          	lw	a5,-20(s0)
     116:	078e                	slli	a5,a5,0x3
     118:	fd043703          	ld	a4,-48(s0)
     11c:	97ba                	add	a5,a5,a4
     11e:	639c                	ld	a5,0(a5)
     120:	863e                	mv	a2,a5
     122:	00001597          	auipc	a1,0x1
     126:	33e58593          	addi	a1,a1,830 # 1460 <schedule_edf_cbs+0x43c>
     12a:	4509                	li	a0,2
     12c:	00001097          	auipc	ra,0x1
     130:	9d0080e7          	jalr	-1584(ra) # afc <fprintf>
      exit(1);
     134:	4505                	li	a0,1
     136:	00000097          	auipc	ra,0x0
     13a:	4d8080e7          	jalr	1240(ra) # 60e <exit>
    }
    cat(fd);
     13e:	fe842783          	lw	a5,-24(s0)
     142:	853e                	mv	a0,a5
     144:	00000097          	auipc	ra,0x0
     148:	ebc080e7          	jalr	-324(ra) # 0 <cat>
    close(fd);
     14c:	fe842783          	lw	a5,-24(s0)
     150:	853e                	mv	a0,a5
     152:	00000097          	auipc	ra,0x0
     156:	4e4080e7          	jalr	1252(ra) # 636 <close>
  for(i = 1; i < argc; i++){
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	2785                	addiw	a5,a5,1
     160:	fef42623          	sw	a5,-20(s0)
     164:	fec42703          	lw	a4,-20(s0)
     168:	fdc42783          	lw	a5,-36(s0)
     16c:	2701                	sext.w	a4,a4
     16e:	2781                	sext.w	a5,a5
     170:	f6f74ce3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
     174:	4501                	li	a0,0
     176:	00000097          	auipc	ra,0x0
     17a:	498080e7          	jalr	1176(ra) # 60e <exit>

000000000000017e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     17e:	7179                	addi	sp,sp,-48
     180:	f422                	sd	s0,40(sp)
     182:	1800                	addi	s0,sp,48
     184:	fca43c23          	sd	a0,-40(s0)
     188:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     18c:	fd843783          	ld	a5,-40(s0)
     190:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     194:	0001                	nop
     196:	fd043703          	ld	a4,-48(s0)
     19a:	00170793          	addi	a5,a4,1
     19e:	fcf43823          	sd	a5,-48(s0)
     1a2:	fd843783          	ld	a5,-40(s0)
     1a6:	00178693          	addi	a3,a5,1
     1aa:	fcd43c23          	sd	a3,-40(s0)
     1ae:	00074703          	lbu	a4,0(a4)
     1b2:	00e78023          	sb	a4,0(a5)
     1b6:	0007c783          	lbu	a5,0(a5)
     1ba:	fff1                	bnez	a5,196 <strcpy+0x18>
    ;
  return os;
     1bc:	fe843783          	ld	a5,-24(s0)
}
     1c0:	853e                	mv	a0,a5
     1c2:	7422                	ld	s0,40(sp)
     1c4:	6145                	addi	sp,sp,48
     1c6:	8082                	ret

00000000000001c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1c8:	1101                	addi	sp,sp,-32
     1ca:	ec22                	sd	s0,24(sp)
     1cc:	1000                	addi	s0,sp,32
     1ce:	fea43423          	sd	a0,-24(s0)
     1d2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1d6:	a819                	j	1ec <strcmp+0x24>
    p++, q++;
     1d8:	fe843783          	ld	a5,-24(s0)
     1dc:	0785                	addi	a5,a5,1
     1de:	fef43423          	sd	a5,-24(s0)
     1e2:	fe043783          	ld	a5,-32(s0)
     1e6:	0785                	addi	a5,a5,1
     1e8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1ec:	fe843783          	ld	a5,-24(s0)
     1f0:	0007c783          	lbu	a5,0(a5)
     1f4:	cb99                	beqz	a5,20a <strcmp+0x42>
     1f6:	fe843783          	ld	a5,-24(s0)
     1fa:	0007c703          	lbu	a4,0(a5)
     1fe:	fe043783          	ld	a5,-32(s0)
     202:	0007c783          	lbu	a5,0(a5)
     206:	fcf709e3          	beq	a4,a5,1d8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     20a:	fe843783          	ld	a5,-24(s0)
     20e:	0007c783          	lbu	a5,0(a5)
     212:	0007871b          	sext.w	a4,a5
     216:	fe043783          	ld	a5,-32(s0)
     21a:	0007c783          	lbu	a5,0(a5)
     21e:	2781                	sext.w	a5,a5
     220:	40f707bb          	subw	a5,a4,a5
     224:	2781                	sext.w	a5,a5
}
     226:	853e                	mv	a0,a5
     228:	6462                	ld	s0,24(sp)
     22a:	6105                	addi	sp,sp,32
     22c:	8082                	ret

000000000000022e <strlen>:

uint
strlen(const char *s)
{
     22e:	7179                	addi	sp,sp,-48
     230:	f422                	sd	s0,40(sp)
     232:	1800                	addi	s0,sp,48
     234:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     238:	fe042623          	sw	zero,-20(s0)
     23c:	a031                	j	248 <strlen+0x1a>
     23e:	fec42783          	lw	a5,-20(s0)
     242:	2785                	addiw	a5,a5,1
     244:	fef42623          	sw	a5,-20(s0)
     248:	fec42783          	lw	a5,-20(s0)
     24c:	fd843703          	ld	a4,-40(s0)
     250:	97ba                	add	a5,a5,a4
     252:	0007c783          	lbu	a5,0(a5)
     256:	f7e5                	bnez	a5,23e <strlen+0x10>
    ;
  return n;
     258:	fec42783          	lw	a5,-20(s0)
}
     25c:	853e                	mv	a0,a5
     25e:	7422                	ld	s0,40(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <memset>:

void*
memset(void *dst, int c, uint n)
{
     264:	7179                	addi	sp,sp,-48
     266:	f422                	sd	s0,40(sp)
     268:	1800                	addi	s0,sp,48
     26a:	fca43c23          	sd	a0,-40(s0)
     26e:	87ae                	mv	a5,a1
     270:	8732                	mv	a4,a2
     272:	fcf42a23          	sw	a5,-44(s0)
     276:	87ba                	mv	a5,a4
     278:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     27c:	fd843783          	ld	a5,-40(s0)
     280:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     284:	fe042623          	sw	zero,-20(s0)
     288:	a00d                	j	2aa <memset+0x46>
    cdst[i] = c;
     28a:	fec42783          	lw	a5,-20(s0)
     28e:	fe043703          	ld	a4,-32(s0)
     292:	97ba                	add	a5,a5,a4
     294:	fd442703          	lw	a4,-44(s0)
     298:	0ff77713          	andi	a4,a4,255
     29c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2a0:	fec42783          	lw	a5,-20(s0)
     2a4:	2785                	addiw	a5,a5,1
     2a6:	fef42623          	sw	a5,-20(s0)
     2aa:	fec42703          	lw	a4,-20(s0)
     2ae:	fd042783          	lw	a5,-48(s0)
     2b2:	2781                	sext.w	a5,a5
     2b4:	fcf76be3          	bltu	a4,a5,28a <memset+0x26>
  }
  return dst;
     2b8:	fd843783          	ld	a5,-40(s0)
}
     2bc:	853e                	mv	a0,a5
     2be:	7422                	ld	s0,40(sp)
     2c0:	6145                	addi	sp,sp,48
     2c2:	8082                	ret

00000000000002c4 <strchr>:

char*
strchr(const char *s, char c)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec22                	sd	s0,24(sp)
     2c8:	1000                	addi	s0,sp,32
     2ca:	fea43423          	sd	a0,-24(s0)
     2ce:	87ae                	mv	a5,a1
     2d0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2d4:	a01d                	j	2fa <strchr+0x36>
    if(*s == c)
     2d6:	fe843783          	ld	a5,-24(s0)
     2da:	0007c703          	lbu	a4,0(a5)
     2de:	fe744783          	lbu	a5,-25(s0)
     2e2:	0ff7f793          	andi	a5,a5,255
     2e6:	00e79563          	bne	a5,a4,2f0 <strchr+0x2c>
      return (char*)s;
     2ea:	fe843783          	ld	a5,-24(s0)
     2ee:	a821                	j	306 <strchr+0x42>
  for(; *s; s++)
     2f0:	fe843783          	ld	a5,-24(s0)
     2f4:	0785                	addi	a5,a5,1
     2f6:	fef43423          	sd	a5,-24(s0)
     2fa:	fe843783          	ld	a5,-24(s0)
     2fe:	0007c783          	lbu	a5,0(a5)
     302:	fbf1                	bnez	a5,2d6 <strchr+0x12>
  return 0;
     304:	4781                	li	a5,0
}
     306:	853e                	mv	a0,a5
     308:	6462                	ld	s0,24(sp)
     30a:	6105                	addi	sp,sp,32
     30c:	8082                	ret

000000000000030e <gets>:

char*
gets(char *buf, int max)
{
     30e:	7179                	addi	sp,sp,-48
     310:	f406                	sd	ra,40(sp)
     312:	f022                	sd	s0,32(sp)
     314:	1800                	addi	s0,sp,48
     316:	fca43c23          	sd	a0,-40(s0)
     31a:	87ae                	mv	a5,a1
     31c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     320:	fe042623          	sw	zero,-20(s0)
     324:	a8a1                	j	37c <gets+0x6e>
    cc = read(0, &c, 1);
     326:	fe740793          	addi	a5,s0,-25
     32a:	4605                	li	a2,1
     32c:	85be                	mv	a1,a5
     32e:	4501                	li	a0,0
     330:	00000097          	auipc	ra,0x0
     334:	2f6080e7          	jalr	758(ra) # 626 <read>
     338:	87aa                	mv	a5,a0
     33a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     33e:	fe842783          	lw	a5,-24(s0)
     342:	2781                	sext.w	a5,a5
     344:	04f05763          	blez	a5,392 <gets+0x84>
      break;
    buf[i++] = c;
     348:	fec42783          	lw	a5,-20(s0)
     34c:	0017871b          	addiw	a4,a5,1
     350:	fee42623          	sw	a4,-20(s0)
     354:	873e                	mv	a4,a5
     356:	fd843783          	ld	a5,-40(s0)
     35a:	97ba                	add	a5,a5,a4
     35c:	fe744703          	lbu	a4,-25(s0)
     360:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     364:	fe744783          	lbu	a5,-25(s0)
     368:	873e                	mv	a4,a5
     36a:	47a9                	li	a5,10
     36c:	02f70463          	beq	a4,a5,394 <gets+0x86>
     370:	fe744783          	lbu	a5,-25(s0)
     374:	873e                	mv	a4,a5
     376:	47b5                	li	a5,13
     378:	00f70e63          	beq	a4,a5,394 <gets+0x86>
  for(i=0; i+1 < max; ){
     37c:	fec42783          	lw	a5,-20(s0)
     380:	2785                	addiw	a5,a5,1
     382:	0007871b          	sext.w	a4,a5
     386:	fd442783          	lw	a5,-44(s0)
     38a:	2781                	sext.w	a5,a5
     38c:	f8f74de3          	blt	a4,a5,326 <gets+0x18>
     390:	a011                	j	394 <gets+0x86>
      break;
     392:	0001                	nop
      break;
  }
  buf[i] = '\0';
     394:	fec42783          	lw	a5,-20(s0)
     398:	fd843703          	ld	a4,-40(s0)
     39c:	97ba                	add	a5,a5,a4
     39e:	00078023          	sb	zero,0(a5)
  return buf;
     3a2:	fd843783          	ld	a5,-40(s0)
}
     3a6:	853e                	mv	a0,a5
     3a8:	70a2                	ld	ra,40(sp)
     3aa:	7402                	ld	s0,32(sp)
     3ac:	6145                	addi	sp,sp,48
     3ae:	8082                	ret

00000000000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
     3b0:	7179                	addi	sp,sp,-48
     3b2:	f406                	sd	ra,40(sp)
     3b4:	f022                	sd	s0,32(sp)
     3b6:	1800                	addi	s0,sp,48
     3b8:	fca43c23          	sd	a0,-40(s0)
     3bc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3c0:	4581                	li	a1,0
     3c2:	fd843503          	ld	a0,-40(s0)
     3c6:	00000097          	auipc	ra,0x0
     3ca:	288080e7          	jalr	648(ra) # 64e <open>
     3ce:	87aa                	mv	a5,a0
     3d0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3d4:	fec42783          	lw	a5,-20(s0)
     3d8:	2781                	sext.w	a5,a5
     3da:	0007d463          	bgez	a5,3e2 <stat+0x32>
    return -1;
     3de:	57fd                	li	a5,-1
     3e0:	a035                	j	40c <stat+0x5c>
  r = fstat(fd, st);
     3e2:	fec42783          	lw	a5,-20(s0)
     3e6:	fd043583          	ld	a1,-48(s0)
     3ea:	853e                	mv	a0,a5
     3ec:	00000097          	auipc	ra,0x0
     3f0:	27a080e7          	jalr	634(ra) # 666 <fstat>
     3f4:	87aa                	mv	a5,a0
     3f6:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3fa:	fec42783          	lw	a5,-20(s0)
     3fe:	853e                	mv	a0,a5
     400:	00000097          	auipc	ra,0x0
     404:	236080e7          	jalr	566(ra) # 636 <close>
  return r;
     408:	fe842783          	lw	a5,-24(s0)
}
     40c:	853e                	mv	a0,a5
     40e:	70a2                	ld	ra,40(sp)
     410:	7402                	ld	s0,32(sp)
     412:	6145                	addi	sp,sp,48
     414:	8082                	ret

0000000000000416 <atoi>:

int
atoi(const char *s)
{
     416:	7179                	addi	sp,sp,-48
     418:	f422                	sd	s0,40(sp)
     41a:	1800                	addi	s0,sp,48
     41c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     420:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     424:	a815                	j	458 <atoi+0x42>
    n = n*10 + *s++ - '0';
     426:	fec42703          	lw	a4,-20(s0)
     42a:	87ba                	mv	a5,a4
     42c:	0027979b          	slliw	a5,a5,0x2
     430:	9fb9                	addw	a5,a5,a4
     432:	0017979b          	slliw	a5,a5,0x1
     436:	0007871b          	sext.w	a4,a5
     43a:	fd843783          	ld	a5,-40(s0)
     43e:	00178693          	addi	a3,a5,1
     442:	fcd43c23          	sd	a3,-40(s0)
     446:	0007c783          	lbu	a5,0(a5)
     44a:	2781                	sext.w	a5,a5
     44c:	9fb9                	addw	a5,a5,a4
     44e:	2781                	sext.w	a5,a5
     450:	fd07879b          	addiw	a5,a5,-48
     454:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     458:	fd843783          	ld	a5,-40(s0)
     45c:	0007c783          	lbu	a5,0(a5)
     460:	873e                	mv	a4,a5
     462:	02f00793          	li	a5,47
     466:	00e7fb63          	bgeu	a5,a4,47c <atoi+0x66>
     46a:	fd843783          	ld	a5,-40(s0)
     46e:	0007c783          	lbu	a5,0(a5)
     472:	873e                	mv	a4,a5
     474:	03900793          	li	a5,57
     478:	fae7f7e3          	bgeu	a5,a4,426 <atoi+0x10>
  return n;
     47c:	fec42783          	lw	a5,-20(s0)
}
     480:	853e                	mv	a0,a5
     482:	7422                	ld	s0,40(sp)
     484:	6145                	addi	sp,sp,48
     486:	8082                	ret

0000000000000488 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     488:	7139                	addi	sp,sp,-64
     48a:	fc22                	sd	s0,56(sp)
     48c:	0080                	addi	s0,sp,64
     48e:	fca43c23          	sd	a0,-40(s0)
     492:	fcb43823          	sd	a1,-48(s0)
     496:	87b2                	mv	a5,a2
     498:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     49c:	fd843783          	ld	a5,-40(s0)
     4a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4a4:	fd043783          	ld	a5,-48(s0)
     4a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4ac:	fe043703          	ld	a4,-32(s0)
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	02e7fc63          	bgeu	a5,a4,4ec <memmove+0x64>
    while(n-- > 0)
     4b8:	a00d                	j	4da <memmove+0x52>
      *dst++ = *src++;
     4ba:	fe043703          	ld	a4,-32(s0)
     4be:	00170793          	addi	a5,a4,1
     4c2:	fef43023          	sd	a5,-32(s0)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00178693          	addi	a3,a5,1
     4ce:	fed43423          	sd	a3,-24(s0)
     4d2:	00074703          	lbu	a4,0(a4)
     4d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4da:	fcc42783          	lw	a5,-52(s0)
     4de:	fff7871b          	addiw	a4,a5,-1
     4e2:	fce42623          	sw	a4,-52(s0)
     4e6:	fcf04ae3          	bgtz	a5,4ba <memmove+0x32>
     4ea:	a891                	j	53e <memmove+0xb6>
  } else {
    dst += n;
     4ec:	fcc42783          	lw	a5,-52(s0)
     4f0:	fe843703          	ld	a4,-24(s0)
     4f4:	97ba                	add	a5,a5,a4
     4f6:	fef43423          	sd	a5,-24(s0)
    src += n;
     4fa:	fcc42783          	lw	a5,-52(s0)
     4fe:	fe043703          	ld	a4,-32(s0)
     502:	97ba                	add	a5,a5,a4
     504:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     508:	a01d                	j	52e <memmove+0xa6>
      *--dst = *--src;
     50a:	fe043783          	ld	a5,-32(s0)
     50e:	17fd                	addi	a5,a5,-1
     510:	fef43023          	sd	a5,-32(s0)
     514:	fe843783          	ld	a5,-24(s0)
     518:	17fd                	addi	a5,a5,-1
     51a:	fef43423          	sd	a5,-24(s0)
     51e:	fe043783          	ld	a5,-32(s0)
     522:	0007c703          	lbu	a4,0(a5)
     526:	fe843783          	ld	a5,-24(s0)
     52a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     52e:	fcc42783          	lw	a5,-52(s0)
     532:	fff7871b          	addiw	a4,a5,-1
     536:	fce42623          	sw	a4,-52(s0)
     53a:	fcf048e3          	bgtz	a5,50a <memmove+0x82>
  }
  return vdst;
     53e:	fd843783          	ld	a5,-40(s0)
}
     542:	853e                	mv	a0,a5
     544:	7462                	ld	s0,56(sp)
     546:	6121                	addi	sp,sp,64
     548:	8082                	ret

000000000000054a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     54a:	7139                	addi	sp,sp,-64
     54c:	fc22                	sd	s0,56(sp)
     54e:	0080                	addi	s0,sp,64
     550:	fca43c23          	sd	a0,-40(s0)
     554:	fcb43823          	sd	a1,-48(s0)
     558:	87b2                	mv	a5,a2
     55a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     55e:	fd843783          	ld	a5,-40(s0)
     562:	fef43423          	sd	a5,-24(s0)
     566:	fd043783          	ld	a5,-48(s0)
     56a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     56e:	a0a1                	j	5b6 <memcmp+0x6c>
    if (*p1 != *p2) {
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c703          	lbu	a4,0(a5)
     578:	fe043783          	ld	a5,-32(s0)
     57c:	0007c783          	lbu	a5,0(a5)
     580:	02f70163          	beq	a4,a5,5a2 <memcmp+0x58>
      return *p1 - *p2;
     584:	fe843783          	ld	a5,-24(s0)
     588:	0007c783          	lbu	a5,0(a5)
     58c:	0007871b          	sext.w	a4,a5
     590:	fe043783          	ld	a5,-32(s0)
     594:	0007c783          	lbu	a5,0(a5)
     598:	2781                	sext.w	a5,a5
     59a:	40f707bb          	subw	a5,a4,a5
     59e:	2781                	sext.w	a5,a5
     5a0:	a01d                	j	5c6 <memcmp+0x7c>
    }
    p1++;
     5a2:	fe843783          	ld	a5,-24(s0)
     5a6:	0785                	addi	a5,a5,1
     5a8:	fef43423          	sd	a5,-24(s0)
    p2++;
     5ac:	fe043783          	ld	a5,-32(s0)
     5b0:	0785                	addi	a5,a5,1
     5b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5b6:	fcc42783          	lw	a5,-52(s0)
     5ba:	fff7871b          	addiw	a4,a5,-1
     5be:	fce42623          	sw	a4,-52(s0)
     5c2:	f7dd                	bnez	a5,570 <memcmp+0x26>
  }
  return 0;
     5c4:	4781                	li	a5,0
}
     5c6:	853e                	mv	a0,a5
     5c8:	7462                	ld	s0,56(sp)
     5ca:	6121                	addi	sp,sp,64
     5cc:	8082                	ret

00000000000005ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5ce:	7179                	addi	sp,sp,-48
     5d0:	f406                	sd	ra,40(sp)
     5d2:	f022                	sd	s0,32(sp)
     5d4:	1800                	addi	s0,sp,48
     5d6:	fea43423          	sd	a0,-24(s0)
     5da:	feb43023          	sd	a1,-32(s0)
     5de:	87b2                	mv	a5,a2
     5e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5e4:	fdc42783          	lw	a5,-36(s0)
     5e8:	863e                	mv	a2,a5
     5ea:	fe043583          	ld	a1,-32(s0)
     5ee:	fe843503          	ld	a0,-24(s0)
     5f2:	00000097          	auipc	ra,0x0
     5f6:	e96080e7          	jalr	-362(ra) # 488 <memmove>
     5fa:	87aa                	mv	a5,a0
}
     5fc:	853e                	mv	a0,a5
     5fe:	70a2                	ld	ra,40(sp)
     600:	7402                	ld	s0,32(sp)
     602:	6145                	addi	sp,sp,48
     604:	8082                	ret

0000000000000606 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     606:	4885                	li	a7,1
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <exit>:
.global exit
exit:
 li a7, SYS_exit
     60e:	4889                	li	a7,2
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <wait>:
.global wait
wait:
 li a7, SYS_wait
     616:	488d                	li	a7,3
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     61e:	4891                	li	a7,4
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <read>:
.global read
read:
 li a7, SYS_read
     626:	4895                	li	a7,5
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <write>:
.global write
write:
 li a7, SYS_write
     62e:	48c1                	li	a7,16
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <close>:
.global close
close:
 li a7, SYS_close
     636:	48d5                	li	a7,21
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <kill>:
.global kill
kill:
 li a7, SYS_kill
     63e:	4899                	li	a7,6
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <exec>:
.global exec
exec:
 li a7, SYS_exec
     646:	489d                	li	a7,7
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <open>:
.global open
open:
 li a7, SYS_open
     64e:	48bd                	li	a7,15
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     656:	48c5                	li	a7,17
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     65e:	48c9                	li	a7,18
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     666:	48a1                	li	a7,8
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <link>:
.global link
link:
 li a7, SYS_link
     66e:	48cd                	li	a7,19
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     676:	48d1                	li	a7,20
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     67e:	48a5                	li	a7,9
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <dup>:
.global dup
dup:
 li a7, SYS_dup
     686:	48a9                	li	a7,10
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     68e:	48ad                	li	a7,11
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     696:	48b1                	li	a7,12
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     69e:	48b5                	li	a7,13
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6a6:	48b9                	li	a7,14
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6ae:	48d9                	li	a7,22
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6b6:	48dd                	li	a7,23
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6be:	48e1                	li	a7,24
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
     6ce:	87aa                	mv	a5,a0
     6d0:	872e                	mv	a4,a1
     6d2:	fef42623          	sw	a5,-20(s0)
     6d6:	87ba                	mv	a5,a4
     6d8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6dc:	feb40713          	addi	a4,s0,-21
     6e0:	fec42783          	lw	a5,-20(s0)
     6e4:	4605                	li	a2,1
     6e6:	85ba                	mv	a1,a4
     6e8:	853e                	mv	a0,a5
     6ea:	00000097          	auipc	ra,0x0
     6ee:	f44080e7          	jalr	-188(ra) # 62e <write>
}
     6f2:	0001                	nop
     6f4:	60e2                	ld	ra,24(sp)
     6f6:	6442                	ld	s0,16(sp)
     6f8:	6105                	addi	sp,sp,32
     6fa:	8082                	ret

00000000000006fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6fc:	7139                	addi	sp,sp,-64
     6fe:	fc06                	sd	ra,56(sp)
     700:	f822                	sd	s0,48(sp)
     702:	0080                	addi	s0,sp,64
     704:	87aa                	mv	a5,a0
     706:	8736                	mv	a4,a3
     708:	fcf42623          	sw	a5,-52(s0)
     70c:	87ae                	mv	a5,a1
     70e:	fcf42423          	sw	a5,-56(s0)
     712:	87b2                	mv	a5,a2
     714:	fcf42223          	sw	a5,-60(s0)
     718:	87ba                	mv	a5,a4
     71a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     71e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     722:	fc042783          	lw	a5,-64(s0)
     726:	2781                	sext.w	a5,a5
     728:	c38d                	beqz	a5,74a <printint+0x4e>
     72a:	fc842783          	lw	a5,-56(s0)
     72e:	2781                	sext.w	a5,a5
     730:	0007dd63          	bgez	a5,74a <printint+0x4e>
    neg = 1;
     734:	4785                	li	a5,1
     736:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     73a:	fc842783          	lw	a5,-56(s0)
     73e:	40f007bb          	negw	a5,a5
     742:	2781                	sext.w	a5,a5
     744:	fef42223          	sw	a5,-28(s0)
     748:	a029                	j	752 <printint+0x56>
  } else {
    x = xx;
     74a:	fc842783          	lw	a5,-56(s0)
     74e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     752:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     756:	fc442783          	lw	a5,-60(s0)
     75a:	fe442703          	lw	a4,-28(s0)
     75e:	02f777bb          	remuw	a5,a4,a5
     762:	0007861b          	sext.w	a2,a5
     766:	fec42783          	lw	a5,-20(s0)
     76a:	0017871b          	addiw	a4,a5,1
     76e:	fee42623          	sw	a4,-20(s0)
     772:	00001697          	auipc	a3,0x1
     776:	d0e68693          	addi	a3,a3,-754 # 1480 <digits>
     77a:	02061713          	slli	a4,a2,0x20
     77e:	9301                	srli	a4,a4,0x20
     780:	9736                	add	a4,a4,a3
     782:	00074703          	lbu	a4,0(a4)
     786:	ff040693          	addi	a3,s0,-16
     78a:	97b6                	add	a5,a5,a3
     78c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     790:	fc442783          	lw	a5,-60(s0)
     794:	fe442703          	lw	a4,-28(s0)
     798:	02f757bb          	divuw	a5,a4,a5
     79c:	fef42223          	sw	a5,-28(s0)
     7a0:	fe442783          	lw	a5,-28(s0)
     7a4:	2781                	sext.w	a5,a5
     7a6:	fbc5                	bnez	a5,756 <printint+0x5a>
  if(neg)
     7a8:	fe842783          	lw	a5,-24(s0)
     7ac:	2781                	sext.w	a5,a5
     7ae:	cf95                	beqz	a5,7ea <printint+0xee>
    buf[i++] = '-';
     7b0:	fec42783          	lw	a5,-20(s0)
     7b4:	0017871b          	addiw	a4,a5,1
     7b8:	fee42623          	sw	a4,-20(s0)
     7bc:	ff040713          	addi	a4,s0,-16
     7c0:	97ba                	add	a5,a5,a4
     7c2:	02d00713          	li	a4,45
     7c6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7ca:	a005                	j	7ea <printint+0xee>
    putc(fd, buf[i]);
     7cc:	fec42783          	lw	a5,-20(s0)
     7d0:	ff040713          	addi	a4,s0,-16
     7d4:	97ba                	add	a5,a5,a4
     7d6:	fe07c703          	lbu	a4,-32(a5)
     7da:	fcc42783          	lw	a5,-52(s0)
     7de:	85ba                	mv	a1,a4
     7e0:	853e                	mv	a0,a5
     7e2:	00000097          	auipc	ra,0x0
     7e6:	ee4080e7          	jalr	-284(ra) # 6c6 <putc>
  while(--i >= 0)
     7ea:	fec42783          	lw	a5,-20(s0)
     7ee:	37fd                	addiw	a5,a5,-1
     7f0:	fef42623          	sw	a5,-20(s0)
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	fc07d9e3          	bgez	a5,7cc <printint+0xd0>
}
     7fe:	0001                	nop
     800:	0001                	nop
     802:	70e2                	ld	ra,56(sp)
     804:	7442                	ld	s0,48(sp)
     806:	6121                	addi	sp,sp,64
     808:	8082                	ret

000000000000080a <printptr>:

static void
printptr(int fd, uint64 x) {
     80a:	7179                	addi	sp,sp,-48
     80c:	f406                	sd	ra,40(sp)
     80e:	f022                	sd	s0,32(sp)
     810:	1800                	addi	s0,sp,48
     812:	87aa                	mv	a5,a0
     814:	fcb43823          	sd	a1,-48(s0)
     818:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     81c:	fdc42783          	lw	a5,-36(s0)
     820:	03000593          	li	a1,48
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	ea0080e7          	jalr	-352(ra) # 6c6 <putc>
  putc(fd, 'x');
     82e:	fdc42783          	lw	a5,-36(s0)
     832:	07800593          	li	a1,120
     836:	853e                	mv	a0,a5
     838:	00000097          	auipc	ra,0x0
     83c:	e8e080e7          	jalr	-370(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     840:	fe042623          	sw	zero,-20(s0)
     844:	a82d                	j	87e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     846:	fd043783          	ld	a5,-48(s0)
     84a:	93f1                	srli	a5,a5,0x3c
     84c:	00001717          	auipc	a4,0x1
     850:	c3470713          	addi	a4,a4,-972 # 1480 <digits>
     854:	97ba                	add	a5,a5,a4
     856:	0007c703          	lbu	a4,0(a5)
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	85ba                	mv	a1,a4
     860:	853e                	mv	a0,a5
     862:	00000097          	auipc	ra,0x0
     866:	e64080e7          	jalr	-412(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     86a:	fec42783          	lw	a5,-20(s0)
     86e:	2785                	addiw	a5,a5,1
     870:	fef42623          	sw	a5,-20(s0)
     874:	fd043783          	ld	a5,-48(s0)
     878:	0792                	slli	a5,a5,0x4
     87a:	fcf43823          	sd	a5,-48(s0)
     87e:	fec42783          	lw	a5,-20(s0)
     882:	873e                	mv	a4,a5
     884:	47bd                	li	a5,15
     886:	fce7f0e3          	bgeu	a5,a4,846 <printptr+0x3c>
}
     88a:	0001                	nop
     88c:	0001                	nop
     88e:	70a2                	ld	ra,40(sp)
     890:	7402                	ld	s0,32(sp)
     892:	6145                	addi	sp,sp,48
     894:	8082                	ret

0000000000000896 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     896:	715d                	addi	sp,sp,-80
     898:	e486                	sd	ra,72(sp)
     89a:	e0a2                	sd	s0,64(sp)
     89c:	0880                	addi	s0,sp,80
     89e:	87aa                	mv	a5,a0
     8a0:	fcb43023          	sd	a1,-64(s0)
     8a4:	fac43c23          	sd	a2,-72(s0)
     8a8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8ac:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8b0:	fe042223          	sw	zero,-28(s0)
     8b4:	a42d                	j	ade <vprintf+0x248>
    c = fmt[i] & 0xff;
     8b6:	fe442783          	lw	a5,-28(s0)
     8ba:	fc043703          	ld	a4,-64(s0)
     8be:	97ba                	add	a5,a5,a4
     8c0:	0007c783          	lbu	a5,0(a5)
     8c4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8c8:	fe042783          	lw	a5,-32(s0)
     8cc:	2781                	sext.w	a5,a5
     8ce:	eb9d                	bnez	a5,904 <vprintf+0x6e>
      if(c == '%'){
     8d0:	fdc42783          	lw	a5,-36(s0)
     8d4:	0007871b          	sext.w	a4,a5
     8d8:	02500793          	li	a5,37
     8dc:	00f71763          	bne	a4,a5,8ea <vprintf+0x54>
        state = '%';
     8e0:	02500793          	li	a5,37
     8e4:	fef42023          	sw	a5,-32(s0)
     8e8:	a2f5                	j	ad4 <vprintf+0x23e>
      } else {
        putc(fd, c);
     8ea:	fdc42783          	lw	a5,-36(s0)
     8ee:	0ff7f713          	andi	a4,a5,255
     8f2:	fcc42783          	lw	a5,-52(s0)
     8f6:	85ba                	mv	a1,a4
     8f8:	853e                	mv	a0,a5
     8fa:	00000097          	auipc	ra,0x0
     8fe:	dcc080e7          	jalr	-564(ra) # 6c6 <putc>
     902:	aac9                	j	ad4 <vprintf+0x23e>
      }
    } else if(state == '%'){
     904:	fe042783          	lw	a5,-32(s0)
     908:	0007871b          	sext.w	a4,a5
     90c:	02500793          	li	a5,37
     910:	1cf71263          	bne	a4,a5,ad4 <vprintf+0x23e>
      if(c == 'd'){
     914:	fdc42783          	lw	a5,-36(s0)
     918:	0007871b          	sext.w	a4,a5
     91c:	06400793          	li	a5,100
     920:	02f71463          	bne	a4,a5,948 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     924:	fb843783          	ld	a5,-72(s0)
     928:	00878713          	addi	a4,a5,8
     92c:	fae43c23          	sd	a4,-72(s0)
     930:	4398                	lw	a4,0(a5)
     932:	fcc42783          	lw	a5,-52(s0)
     936:	4685                	li	a3,1
     938:	4629                	li	a2,10
     93a:	85ba                	mv	a1,a4
     93c:	853e                	mv	a0,a5
     93e:	00000097          	auipc	ra,0x0
     942:	dbe080e7          	jalr	-578(ra) # 6fc <printint>
     946:	a269                	j	ad0 <vprintf+0x23a>
      } else if(c == 'l') {
     948:	fdc42783          	lw	a5,-36(s0)
     94c:	0007871b          	sext.w	a4,a5
     950:	06c00793          	li	a5,108
     954:	02f71663          	bne	a4,a5,980 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     958:	fb843783          	ld	a5,-72(s0)
     95c:	00878713          	addi	a4,a5,8
     960:	fae43c23          	sd	a4,-72(s0)
     964:	639c                	ld	a5,0(a5)
     966:	0007871b          	sext.w	a4,a5
     96a:	fcc42783          	lw	a5,-52(s0)
     96e:	4681                	li	a3,0
     970:	4629                	li	a2,10
     972:	85ba                	mv	a1,a4
     974:	853e                	mv	a0,a5
     976:	00000097          	auipc	ra,0x0
     97a:	d86080e7          	jalr	-634(ra) # 6fc <printint>
     97e:	aa89                	j	ad0 <vprintf+0x23a>
      } else if(c == 'x') {
     980:	fdc42783          	lw	a5,-36(s0)
     984:	0007871b          	sext.w	a4,a5
     988:	07800793          	li	a5,120
     98c:	02f71463          	bne	a4,a5,9b4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     990:	fb843783          	ld	a5,-72(s0)
     994:	00878713          	addi	a4,a5,8
     998:	fae43c23          	sd	a4,-72(s0)
     99c:	4398                	lw	a4,0(a5)
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	4681                	li	a3,0
     9a4:	4641                	li	a2,16
     9a6:	85ba                	mv	a1,a4
     9a8:	853e                	mv	a0,a5
     9aa:	00000097          	auipc	ra,0x0
     9ae:	d52080e7          	jalr	-686(ra) # 6fc <printint>
     9b2:	aa39                	j	ad0 <vprintf+0x23a>
      } else if(c == 'p') {
     9b4:	fdc42783          	lw	a5,-36(s0)
     9b8:	0007871b          	sext.w	a4,a5
     9bc:	07000793          	li	a5,112
     9c0:	02f71263          	bne	a4,a5,9e4 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9c4:	fb843783          	ld	a5,-72(s0)
     9c8:	00878713          	addi	a4,a5,8
     9cc:	fae43c23          	sd	a4,-72(s0)
     9d0:	6398                	ld	a4,0(a5)
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	00000097          	auipc	ra,0x0
     9de:	e30080e7          	jalr	-464(ra) # 80a <printptr>
     9e2:	a0fd                	j	ad0 <vprintf+0x23a>
      } else if(c == 's'){
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0007871b          	sext.w	a4,a5
     9ec:	07300793          	li	a5,115
     9f0:	04f71c63          	bne	a4,a5,a48 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     9f4:	fb843783          	ld	a5,-72(s0)
     9f8:	00878713          	addi	a4,a5,8
     9fc:	fae43c23          	sd	a4,-72(s0)
     a00:	639c                	ld	a5,0(a5)
     a02:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a06:	fe843783          	ld	a5,-24(s0)
     a0a:	eb8d                	bnez	a5,a3c <vprintf+0x1a6>
          s = "(null)";
     a0c:	00001797          	auipc	a5,0x1
     a10:	a6c78793          	addi	a5,a5,-1428 # 1478 <schedule_edf_cbs+0x454>
     a14:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a18:	a015                	j	a3c <vprintf+0x1a6>
          putc(fd, *s);
     a1a:	fe843783          	ld	a5,-24(s0)
     a1e:	0007c703          	lbu	a4,0(a5)
     a22:	fcc42783          	lw	a5,-52(s0)
     a26:	85ba                	mv	a1,a4
     a28:	853e                	mv	a0,a5
     a2a:	00000097          	auipc	ra,0x0
     a2e:	c9c080e7          	jalr	-868(ra) # 6c6 <putc>
          s++;
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	0785                	addi	a5,a5,1
     a38:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a3c:	fe843783          	ld	a5,-24(s0)
     a40:	0007c783          	lbu	a5,0(a5)
     a44:	fbf9                	bnez	a5,a1a <vprintf+0x184>
     a46:	a069                	j	ad0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a48:	fdc42783          	lw	a5,-36(s0)
     a4c:	0007871b          	sext.w	a4,a5
     a50:	06300793          	li	a5,99
     a54:	02f71463          	bne	a4,a5,a7c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a58:	fb843783          	ld	a5,-72(s0)
     a5c:	00878713          	addi	a4,a5,8
     a60:	fae43c23          	sd	a4,-72(s0)
     a64:	439c                	lw	a5,0(a5)
     a66:	0ff7f713          	andi	a4,a5,255
     a6a:	fcc42783          	lw	a5,-52(s0)
     a6e:	85ba                	mv	a1,a4
     a70:	853e                	mv	a0,a5
     a72:	00000097          	auipc	ra,0x0
     a76:	c54080e7          	jalr	-940(ra) # 6c6 <putc>
     a7a:	a899                	j	ad0 <vprintf+0x23a>
      } else if(c == '%'){
     a7c:	fdc42783          	lw	a5,-36(s0)
     a80:	0007871b          	sext.w	a4,a5
     a84:	02500793          	li	a5,37
     a88:	00f71f63          	bne	a4,a5,aa6 <vprintf+0x210>
        putc(fd, c);
     a8c:	fdc42783          	lw	a5,-36(s0)
     a90:	0ff7f713          	andi	a4,a5,255
     a94:	fcc42783          	lw	a5,-52(s0)
     a98:	85ba                	mv	a1,a4
     a9a:	853e                	mv	a0,a5
     a9c:	00000097          	auipc	ra,0x0
     aa0:	c2a080e7          	jalr	-982(ra) # 6c6 <putc>
     aa4:	a035                	j	ad0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     aa6:	fcc42783          	lw	a5,-52(s0)
     aaa:	02500593          	li	a1,37
     aae:	853e                	mv	a0,a5
     ab0:	00000097          	auipc	ra,0x0
     ab4:	c16080e7          	jalr	-1002(ra) # 6c6 <putc>
        putc(fd, c);
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	0ff7f713          	andi	a4,a5,255
     ac0:	fcc42783          	lw	a5,-52(s0)
     ac4:	85ba                	mv	a1,a4
     ac6:	853e                	mv	a0,a5
     ac8:	00000097          	auipc	ra,0x0
     acc:	bfe080e7          	jalr	-1026(ra) # 6c6 <putc>
      }
      state = 0;
     ad0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ad4:	fe442783          	lw	a5,-28(s0)
     ad8:	2785                	addiw	a5,a5,1
     ada:	fef42223          	sw	a5,-28(s0)
     ade:	fe442783          	lw	a5,-28(s0)
     ae2:	fc043703          	ld	a4,-64(s0)
     ae6:	97ba                	add	a5,a5,a4
     ae8:	0007c783          	lbu	a5,0(a5)
     aec:	dc0795e3          	bnez	a5,8b6 <vprintf+0x20>
    }
  }
}
     af0:	0001                	nop
     af2:	0001                	nop
     af4:	60a6                	ld	ra,72(sp)
     af6:	6406                	ld	s0,64(sp)
     af8:	6161                	addi	sp,sp,80
     afa:	8082                	ret

0000000000000afc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     afc:	7159                	addi	sp,sp,-112
     afe:	fc06                	sd	ra,56(sp)
     b00:	f822                	sd	s0,48(sp)
     b02:	0080                	addi	s0,sp,64
     b04:	fcb43823          	sd	a1,-48(s0)
     b08:	e010                	sd	a2,0(s0)
     b0a:	e414                	sd	a3,8(s0)
     b0c:	e818                	sd	a4,16(s0)
     b0e:	ec1c                	sd	a5,24(s0)
     b10:	03043023          	sd	a6,32(s0)
     b14:	03143423          	sd	a7,40(s0)
     b18:	87aa                	mv	a5,a0
     b1a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b1e:	03040793          	addi	a5,s0,48
     b22:	fcf43423          	sd	a5,-56(s0)
     b26:	fc843783          	ld	a5,-56(s0)
     b2a:	fd078793          	addi	a5,a5,-48
     b2e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b32:	fe843703          	ld	a4,-24(s0)
     b36:	fdc42783          	lw	a5,-36(s0)
     b3a:	863a                	mv	a2,a4
     b3c:	fd043583          	ld	a1,-48(s0)
     b40:	853e                	mv	a0,a5
     b42:	00000097          	auipc	ra,0x0
     b46:	d54080e7          	jalr	-684(ra) # 896 <vprintf>
}
     b4a:	0001                	nop
     b4c:	70e2                	ld	ra,56(sp)
     b4e:	7442                	ld	s0,48(sp)
     b50:	6165                	addi	sp,sp,112
     b52:	8082                	ret

0000000000000b54 <printf>:

void
printf(const char *fmt, ...)
{
     b54:	7159                	addi	sp,sp,-112
     b56:	f406                	sd	ra,40(sp)
     b58:	f022                	sd	s0,32(sp)
     b5a:	1800                	addi	s0,sp,48
     b5c:	fca43c23          	sd	a0,-40(s0)
     b60:	e40c                	sd	a1,8(s0)
     b62:	e810                	sd	a2,16(s0)
     b64:	ec14                	sd	a3,24(s0)
     b66:	f018                	sd	a4,32(s0)
     b68:	f41c                	sd	a5,40(s0)
     b6a:	03043823          	sd	a6,48(s0)
     b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b72:	04040793          	addi	a5,s0,64
     b76:	fcf43823          	sd	a5,-48(s0)
     b7a:	fd043783          	ld	a5,-48(s0)
     b7e:	fc878793          	addi	a5,a5,-56
     b82:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	863e                	mv	a2,a5
     b8c:	fd843583          	ld	a1,-40(s0)
     b90:	4505                	li	a0,1
     b92:	00000097          	auipc	ra,0x0
     b96:	d04080e7          	jalr	-764(ra) # 896 <vprintf>
}
     b9a:	0001                	nop
     b9c:	70a2                	ld	ra,40(sp)
     b9e:	7402                	ld	s0,32(sp)
     ba0:	6165                	addi	sp,sp,112
     ba2:	8082                	ret

0000000000000ba4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ba4:	7179                	addi	sp,sp,-48
     ba6:	f422                	sd	s0,40(sp)
     ba8:	1800                	addi	s0,sp,48
     baa:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bae:	fd843783          	ld	a5,-40(s0)
     bb2:	17c1                	addi	a5,a5,-16
     bb4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bb8:	00001797          	auipc	a5,0x1
     bbc:	af078793          	addi	a5,a5,-1296 # 16a8 <freep>
     bc0:	639c                	ld	a5,0(a5)
     bc2:	fef43423          	sd	a5,-24(s0)
     bc6:	a815                	j	bfa <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bc8:	fe843783          	ld	a5,-24(s0)
     bcc:	639c                	ld	a5,0(a5)
     bce:	fe843703          	ld	a4,-24(s0)
     bd2:	00f76f63          	bltu	a4,a5,bf0 <free+0x4c>
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	fe843783          	ld	a5,-24(s0)
     bde:	02e7eb63          	bltu	a5,a4,c14 <free+0x70>
     be2:	fe843783          	ld	a5,-24(s0)
     be6:	639c                	ld	a5,0(a5)
     be8:	fe043703          	ld	a4,-32(s0)
     bec:	02f76463          	bltu	a4,a5,c14 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bf0:	fe843783          	ld	a5,-24(s0)
     bf4:	639c                	ld	a5,0(a5)
     bf6:	fef43423          	sd	a5,-24(s0)
     bfa:	fe043703          	ld	a4,-32(s0)
     bfe:	fe843783          	ld	a5,-24(s0)
     c02:	fce7f3e3          	bgeu	a5,a4,bc8 <free+0x24>
     c06:	fe843783          	ld	a5,-24(s0)
     c0a:	639c                	ld	a5,0(a5)
     c0c:	fe043703          	ld	a4,-32(s0)
     c10:	faf77ce3          	bgeu	a4,a5,bc8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c14:	fe043783          	ld	a5,-32(s0)
     c18:	479c                	lw	a5,8(a5)
     c1a:	1782                	slli	a5,a5,0x20
     c1c:	9381                	srli	a5,a5,0x20
     c1e:	0792                	slli	a5,a5,0x4
     c20:	fe043703          	ld	a4,-32(s0)
     c24:	973e                	add	a4,a4,a5
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	639c                	ld	a5,0(a5)
     c2c:	02f71763          	bne	a4,a5,c5a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c30:	fe043783          	ld	a5,-32(s0)
     c34:	4798                	lw	a4,8(a5)
     c36:	fe843783          	ld	a5,-24(s0)
     c3a:	639c                	ld	a5,0(a5)
     c3c:	479c                	lw	a5,8(a5)
     c3e:	9fb9                	addw	a5,a5,a4
     c40:	0007871b          	sext.w	a4,a5
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	639c                	ld	a5,0(a5)
     c50:	6398                	ld	a4,0(a5)
     c52:	fe043783          	ld	a5,-32(s0)
     c56:	e398                	sd	a4,0(a5)
     c58:	a039                	j	c66 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c5a:	fe843783          	ld	a5,-24(s0)
     c5e:	6398                	ld	a4,0(a5)
     c60:	fe043783          	ld	a5,-32(s0)
     c64:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	479c                	lw	a5,8(a5)
     c6c:	1782                	slli	a5,a5,0x20
     c6e:	9381                	srli	a5,a5,0x20
     c70:	0792                	slli	a5,a5,0x4
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	97ba                	add	a5,a5,a4
     c78:	fe043703          	ld	a4,-32(s0)
     c7c:	02f71563          	bne	a4,a5,ca6 <free+0x102>
    p->s.size += bp->s.size;
     c80:	fe843783          	ld	a5,-24(s0)
     c84:	4798                	lw	a4,8(a5)
     c86:	fe043783          	ld	a5,-32(s0)
     c8a:	479c                	lw	a5,8(a5)
     c8c:	9fb9                	addw	a5,a5,a4
     c8e:	0007871b          	sext.w	a4,a5
     c92:	fe843783          	ld	a5,-24(s0)
     c96:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c98:	fe043783          	ld	a5,-32(s0)
     c9c:	6398                	ld	a4,0(a5)
     c9e:	fe843783          	ld	a5,-24(s0)
     ca2:	e398                	sd	a4,0(a5)
     ca4:	a031                	j	cb0 <free+0x10c>
  } else
    p->s.ptr = bp;
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	fe043703          	ld	a4,-32(s0)
     cae:	e398                	sd	a4,0(a5)
  freep = p;
     cb0:	00001797          	auipc	a5,0x1
     cb4:	9f878793          	addi	a5,a5,-1544 # 16a8 <freep>
     cb8:	fe843703          	ld	a4,-24(s0)
     cbc:	e398                	sd	a4,0(a5)
}
     cbe:	0001                	nop
     cc0:	7422                	ld	s0,40(sp)
     cc2:	6145                	addi	sp,sp,48
     cc4:	8082                	ret

0000000000000cc6 <morecore>:

static Header*
morecore(uint nu)
{
     cc6:	7179                	addi	sp,sp,-48
     cc8:	f406                	sd	ra,40(sp)
     cca:	f022                	sd	s0,32(sp)
     ccc:	1800                	addi	s0,sp,48
     cce:	87aa                	mv	a5,a0
     cd0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     cd4:	fdc42783          	lw	a5,-36(s0)
     cd8:	0007871b          	sext.w	a4,a5
     cdc:	6785                	lui	a5,0x1
     cde:	00f77563          	bgeu	a4,a5,ce8 <morecore+0x22>
    nu = 4096;
     ce2:	6785                	lui	a5,0x1
     ce4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ce8:	fdc42783          	lw	a5,-36(s0)
     cec:	0047979b          	slliw	a5,a5,0x4
     cf0:	2781                	sext.w	a5,a5
     cf2:	2781                	sext.w	a5,a5
     cf4:	853e                	mv	a0,a5
     cf6:	00000097          	auipc	ra,0x0
     cfa:	9a0080e7          	jalr	-1632(ra) # 696 <sbrk>
     cfe:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d02:	fe843703          	ld	a4,-24(s0)
     d06:	57fd                	li	a5,-1
     d08:	00f71463          	bne	a4,a5,d10 <morecore+0x4a>
    return 0;
     d0c:	4781                	li	a5,0
     d0e:	a03d                	j	d3c <morecore+0x76>
  hp = (Header*)p;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d18:	fe043783          	ld	a5,-32(s0)
     d1c:	fdc42703          	lw	a4,-36(s0)
     d20:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d22:	fe043783          	ld	a5,-32(s0)
     d26:	07c1                	addi	a5,a5,16
     d28:	853e                	mv	a0,a5
     d2a:	00000097          	auipc	ra,0x0
     d2e:	e7a080e7          	jalr	-390(ra) # ba4 <free>
  return freep;
     d32:	00001797          	auipc	a5,0x1
     d36:	97678793          	addi	a5,a5,-1674 # 16a8 <freep>
     d3a:	639c                	ld	a5,0(a5)
}
     d3c:	853e                	mv	a0,a5
     d3e:	70a2                	ld	ra,40(sp)
     d40:	7402                	ld	s0,32(sp)
     d42:	6145                	addi	sp,sp,48
     d44:	8082                	ret

0000000000000d46 <malloc>:

void*
malloc(uint nbytes)
{
     d46:	7139                	addi	sp,sp,-64
     d48:	fc06                	sd	ra,56(sp)
     d4a:	f822                	sd	s0,48(sp)
     d4c:	0080                	addi	s0,sp,64
     d4e:	87aa                	mv	a5,a0
     d50:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d54:	fcc46783          	lwu	a5,-52(s0)
     d58:	07bd                	addi	a5,a5,15
     d5a:	8391                	srli	a5,a5,0x4
     d5c:	2781                	sext.w	a5,a5
     d5e:	2785                	addiw	a5,a5,1
     d60:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d64:	00001797          	auipc	a5,0x1
     d68:	94478793          	addi	a5,a5,-1724 # 16a8 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fef43023          	sd	a5,-32(s0)
     d72:	fe043783          	ld	a5,-32(s0)
     d76:	ef95                	bnez	a5,db2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d78:	00001797          	auipc	a5,0x1
     d7c:	92078793          	addi	a5,a5,-1760 # 1698 <base>
     d80:	fef43023          	sd	a5,-32(s0)
     d84:	00001797          	auipc	a5,0x1
     d88:	92478793          	addi	a5,a5,-1756 # 16a8 <freep>
     d8c:	fe043703          	ld	a4,-32(s0)
     d90:	e398                	sd	a4,0(a5)
     d92:	00001797          	auipc	a5,0x1
     d96:	91678793          	addi	a5,a5,-1770 # 16a8 <freep>
     d9a:	6398                	ld	a4,0(a5)
     d9c:	00001797          	auipc	a5,0x1
     da0:	8fc78793          	addi	a5,a5,-1796 # 1698 <base>
     da4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     da6:	00001797          	auipc	a5,0x1
     daa:	8f278793          	addi	a5,a5,-1806 # 1698 <base>
     dae:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     db2:	fe043783          	ld	a5,-32(s0)
     db6:	639c                	ld	a5,0(a5)
     db8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	4798                	lw	a4,8(a5)
     dc2:	fdc42783          	lw	a5,-36(s0)
     dc6:	2781                	sext.w	a5,a5
     dc8:	06f76863          	bltu	a4,a5,e38 <malloc+0xf2>
      if(p->s.size == nunits)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	4798                	lw	a4,8(a5)
     dd2:	fdc42783          	lw	a5,-36(s0)
     dd6:	2781                	sext.w	a5,a5
     dd8:	00e79963          	bne	a5,a4,dea <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     ddc:	fe843783          	ld	a5,-24(s0)
     de0:	6398                	ld	a4,0(a5)
     de2:	fe043783          	ld	a5,-32(s0)
     de6:	e398                	sd	a4,0(a5)
     de8:	a82d                	j	e22 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	4798                	lw	a4,8(a5)
     df0:	fdc42783          	lw	a5,-36(s0)
     df4:	40f707bb          	subw	a5,a4,a5
     df8:	0007871b          	sext.w	a4,a5
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	479c                	lw	a5,8(a5)
     e08:	1782                	slli	a5,a5,0x20
     e0a:	9381                	srli	a5,a5,0x20
     e0c:	0792                	slli	a5,a5,0x4
     e0e:	fe843703          	ld	a4,-24(s0)
     e12:	97ba                	add	a5,a5,a4
     e14:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e18:	fe843783          	ld	a5,-24(s0)
     e1c:	fdc42703          	lw	a4,-36(s0)
     e20:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e22:	00001797          	auipc	a5,0x1
     e26:	88678793          	addi	a5,a5,-1914 # 16a8 <freep>
     e2a:	fe043703          	ld	a4,-32(s0)
     e2e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	07c1                	addi	a5,a5,16
     e36:	a091                	j	e7a <malloc+0x134>
    }
    if(p == freep)
     e38:	00001797          	auipc	a5,0x1
     e3c:	87078793          	addi	a5,a5,-1936 # 16a8 <freep>
     e40:	639c                	ld	a5,0(a5)
     e42:	fe843703          	ld	a4,-24(s0)
     e46:	02f71063          	bne	a4,a5,e66 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e4a:	fdc42783          	lw	a5,-36(s0)
     e4e:	853e                	mv	a0,a5
     e50:	00000097          	auipc	ra,0x0
     e54:	e76080e7          	jalr	-394(ra) # cc6 <morecore>
     e58:	fea43423          	sd	a0,-24(s0)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	e399                	bnez	a5,e66 <malloc+0x120>
        return 0;
     e62:	4781                	li	a5,0
     e64:	a819                	j	e7a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e66:	fe843783          	ld	a5,-24(s0)
     e6a:	fef43023          	sd	a5,-32(s0)
     e6e:	fe843783          	ld	a5,-24(s0)
     e72:	639c                	ld	a5,0(a5)
     e74:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e78:	b791                	j	dbc <malloc+0x76>
  }
}
     e7a:	853e                	mv	a0,a5
     e7c:	70e2                	ld	ra,56(sp)
     e7e:	7442                	ld	s0,48(sp)
     e80:	6121                	addi	sp,sp,64
     e82:	8082                	ret

0000000000000e84 <setjmp>:
     e84:	e100                	sd	s0,0(a0)
     e86:	e504                	sd	s1,8(a0)
     e88:	01253823          	sd	s2,16(a0)
     e8c:	01353c23          	sd	s3,24(a0)
     e90:	03453023          	sd	s4,32(a0)
     e94:	03553423          	sd	s5,40(a0)
     e98:	03653823          	sd	s6,48(a0)
     e9c:	03753c23          	sd	s7,56(a0)
     ea0:	05853023          	sd	s8,64(a0)
     ea4:	05953423          	sd	s9,72(a0)
     ea8:	05a53823          	sd	s10,80(a0)
     eac:	05b53c23          	sd	s11,88(a0)
     eb0:	06153023          	sd	ra,96(a0)
     eb4:	06253423          	sd	sp,104(a0)
     eb8:	4501                	li	a0,0
     eba:	8082                	ret

0000000000000ebc <longjmp>:
     ebc:	6100                	ld	s0,0(a0)
     ebe:	6504                	ld	s1,8(a0)
     ec0:	01053903          	ld	s2,16(a0)
     ec4:	01853983          	ld	s3,24(a0)
     ec8:	02053a03          	ld	s4,32(a0)
     ecc:	02853a83          	ld	s5,40(a0)
     ed0:	03053b03          	ld	s6,48(a0)
     ed4:	03853b83          	ld	s7,56(a0)
     ed8:	04053c03          	ld	s8,64(a0)
     edc:	04853c83          	ld	s9,72(a0)
     ee0:	05053d03          	ld	s10,80(a0)
     ee4:	05853d83          	ld	s11,88(a0)
     ee8:	06053083          	ld	ra,96(a0)
     eec:	06853103          	ld	sp,104(a0)
     ef0:	c199                	beqz	a1,ef6 <longjmp_1>
     ef2:	852e                	mv	a0,a1
     ef4:	8082                	ret

0000000000000ef6 <longjmp_1>:
     ef6:	4505                	li	a0,1
     ef8:	8082                	ret

0000000000000efa <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
     efa:	7139                	addi	sp,sp,-64
     efc:	fc22                	sd	s0,56(sp)
     efe:	0080                	addi	s0,sp,64
     f00:	fca43423          	sd	a0,-56(s0)
     f04:	87ae                	mv	a5,a1
     f06:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
     f0a:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
     f0e:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     f12:	fc843783          	ld	a5,-56(s0)
     f16:	639c                	ld	a5,0(a5)
     f18:	fcf43c23          	sd	a5,-40(s0)
     f1c:	fd843783          	ld	a5,-40(s0)
     f20:	fd878793          	addi	a5,a5,-40
     f24:	fef43423          	sd	a5,-24(s0)
     f28:	a881                	j	f78 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
     f2a:	fe843783          	ld	a5,-24(s0)
     f2e:	4fb8                	lw	a4,88(a5)
     f30:	fc442783          	lw	a5,-60(s0)
     f34:	2781                	sext.w	a5,a5
     f36:	02e7c663          	blt	a5,a4,f62 <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
     f3a:	fe043783          	ld	a5,-32(s0)
     f3e:	e791                	bnez	a5,f4a <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	fef43023          	sd	a5,-32(s0)
     f48:	a829                	j	f62 <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	5fd8                	lw	a4,60(a5)
     f50:	fe043783          	ld	a5,-32(s0)
     f54:	5fdc                	lw	a5,60(a5)
     f56:	00f75663          	bge	a4,a5,f62 <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
     f5a:	fe843783          	ld	a5,-24(s0)
     f5e:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     f62:	fe843783          	ld	a5,-24(s0)
     f66:	779c                	ld	a5,40(a5)
     f68:	fcf43823          	sd	a5,-48(s0)
     f6c:	fd043783          	ld	a5,-48(s0)
     f70:	fd878793          	addi	a5,a5,-40
     f74:	fef43423          	sd	a5,-24(s0)
     f78:	fe843783          	ld	a5,-24(s0)
     f7c:	02878793          	addi	a5,a5,40
     f80:	fc843703          	ld	a4,-56(s0)
     f84:	faf713e3          	bne	a4,a5,f2a <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
     f88:	fe043783          	ld	a5,-32(s0)
}
     f8c:	853e                	mv	a0,a5
     f8e:	7462                	ld	s0,56(sp)
     f90:	6121                	addi	sp,sp,64
     f92:	8082                	ret

0000000000000f94 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
     f94:	1101                	addi	sp,sp,-32
     f96:	ec22                	sd	s0,24(sp)
     f98:	1000                	addi	s0,sp,32
     f9a:	fea43423          	sd	a0,-24(s0)
     f9e:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
     fa2:	fe843783          	ld	a5,-24(s0)
     fa6:	57fc                	lw	a5,108(a5)
     fa8:	c799                	beqz	a5,fb6 <__edf_thread_cmp+0x22>
     faa:	fe043783          	ld	a5,-32(s0)
     fae:	57fc                	lw	a5,108(a5)
     fb0:	e399                	bnez	a5,fb6 <__edf_thread_cmp+0x22>
     fb2:	57fd                	li	a5,-1
     fb4:	a0a5                	j	101c <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
     fb6:	fe843783          	ld	a5,-24(s0)
     fba:	57fc                	lw	a5,108(a5)
     fbc:	e799                	bnez	a5,fca <__edf_thread_cmp+0x36>
     fbe:	fe043783          	ld	a5,-32(s0)
     fc2:	57fc                	lw	a5,108(a5)
     fc4:	c399                	beqz	a5,fca <__edf_thread_cmp+0x36>
     fc6:	4785                	li	a5,1
     fc8:	a891                	j	101c <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
     fca:	fe843783          	ld	a5,-24(s0)
     fce:	4fb8                	lw	a4,88(a5)
     fd0:	fe043783          	ld	a5,-32(s0)
     fd4:	4fbc                	lw	a5,88(a5)
     fd6:	00f75463          	bge	a4,a5,fde <__edf_thread_cmp+0x4a>
     fda:	57fd                	li	a5,-1
     fdc:	a081                	j	101c <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
     fde:	fe843783          	ld	a5,-24(s0)
     fe2:	4fb8                	lw	a4,88(a5)
     fe4:	fe043783          	ld	a5,-32(s0)
     fe8:	4fbc                	lw	a5,88(a5)
     fea:	00e7d463          	bge	a5,a4,ff2 <__edf_thread_cmp+0x5e>
     fee:	4785                	li	a5,1
     ff0:	a035                	j	101c <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	5fd8                	lw	a4,60(a5)
     ff8:	fe043783          	ld	a5,-32(s0)
     ffc:	5fdc                	lw	a5,60(a5)
     ffe:	00f75463          	bge	a4,a5,1006 <__edf_thread_cmp+0x72>
    1002:	57fd                	li	a5,-1
    1004:	a821                	j	101c <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
    1006:	fe843783          	ld	a5,-24(s0)
    100a:	5fd8                	lw	a4,60(a5)
    100c:	fe043783          	ld	a5,-32(s0)
    1010:	5fdc                	lw	a5,60(a5)
    1012:	00e7d463          	bge	a5,a4,101a <__edf_thread_cmp+0x86>
    1016:	4785                	li	a5,1
    1018:	a011                	j	101c <__edf_thread_cmp+0x88>
    
    return 0;
    101a:	4781                	li	a5,0
}
    101c:	853e                	mv	a0,a5
    101e:	6462                	ld	s0,24(sp)
    1020:	6105                	addi	sp,sp,32
    1022:	8082                	ret

0000000000001024 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
    1024:	7151                	addi	sp,sp,-240
    1026:	f586                	sd	ra,232(sp)
    1028:	f1a2                	sd	s0,224(sp)
    102a:	eda6                	sd	s1,216(sp)
    102c:	e9ca                	sd	s2,208(sp)
    102e:	e5ce                	sd	s3,200(sp)
    1030:	1980                	addi	s0,sp,240
    1032:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
    1034:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
    1038:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
    103c:	649c                	ld	a5,8(s1)
    103e:	639c                	ld	a5,0(a5)
    1040:	f8f43c23          	sd	a5,-104(s0)
    1044:	f9843783          	ld	a5,-104(s0)
    1048:	fd878793          	addi	a5,a5,-40
    104c:	fcf43423          	sd	a5,-56(s0)
    1050:	a8b1                	j	10ac <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1052:	fc843783          	ld	a5,-56(s0)
    1056:	57bc                	lw	a5,104(a5)
    1058:	02f04f63          	bgtz	a5,1096 <schedule_edf_cbs+0x72>
    105c:	fc843783          	ld	a5,-56(s0)
    1060:	4bfc                	lw	a5,84(a5)
    1062:	02f05a63          	blez	a5,1096 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
    1066:	4098                	lw	a4,0(s1)
    1068:	fc843783          	ld	a5,-56(s0)
    106c:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    106e:	02f71463          	bne	a4,a5,1096 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
    1072:	fc843783          	ld	a5,-56(s0)
    1076:	4fb8                	lw	a4,88(a5)
    1078:	fc843783          	ld	a5,-56(s0)
    107c:	47fc                	lw	a5,76(a5)
    107e:	9fb9                	addw	a5,a5,a4
    1080:	0007871b          	sext.w	a4,a5
    1084:	fc843783          	ld	a5,-56(s0)
    1088:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
    108a:	fc843783          	ld	a5,-56(s0)
    108e:	53f8                	lw	a4,100(a5)
    1090:	fc843783          	ld	a5,-56(s0)
    1094:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1096:	fc843783          	ld	a5,-56(s0)
    109a:	779c                	ld	a5,40(a5)
    109c:	f2f43823          	sd	a5,-208(s0)
    10a0:	f3043783          	ld	a5,-208(s0)
    10a4:	fd878793          	addi	a5,a5,-40
    10a8:	fcf43423          	sd	a5,-56(s0)
    10ac:	fc843783          	ld	a5,-56(s0)
    10b0:	02878713          	addi	a4,a5,40
    10b4:	649c                	ld	a5,8(s1)
    10b6:	f8f71ee3          	bne	a4,a5,1052 <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    10ba:	649c                	ld	a5,8(s1)
    10bc:	4098                	lw	a4,0(s1)
    10be:	85ba                	mv	a1,a4
    10c0:	853e                	mv	a0,a5
    10c2:	00000097          	auipc	ra,0x0
    10c6:	e38080e7          	jalr	-456(ra) # efa <__check_deadline_miss>
    10ca:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
    10ce:	f9043783          	ld	a5,-112(s0)
    10d2:	c395                	beqz	a5,10f6 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
    10d4:	f9043783          	ld	a5,-112(s0)
    10d8:	02878793          	addi	a5,a5,40
    10dc:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
    10e0:	f0042c23          	sw	zero,-232(s0)
        return r;
    10e4:	f1043783          	ld	a5,-240(s0)
    10e8:	f2f43023          	sd	a5,-224(s0)
    10ec:	f1843783          	ld	a5,-232(s0)
    10f0:	f2f43423          	sd	a5,-216(s0)
    10f4:	ae19                	j	140a <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
    10f6:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    10fa:	649c                	ld	a5,8(s1)
    10fc:	639c                	ld	a5,0(a5)
    10fe:	f8f43423          	sd	a5,-120(s0)
    1102:	f8843783          	ld	a5,-120(s0)
    1106:	fd878793          	addi	a5,a5,-40
    110a:	fcf43423          	sd	a5,-56(s0)
    110e:	a0ad                	j	1178 <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
    1110:	fc843783          	ld	a5,-56(s0)
    1114:	4bfc                	lw	a5,84(a5)
    1116:	04f05563          	blez	a5,1160 <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    111a:	fc843783          	ld	a5,-56(s0)
    111e:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
    1120:	00f04d63          	bgtz	a5,113a <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1124:	fc843783          	ld	a5,-56(s0)
    1128:	4bfc                	lw	a5,84(a5)
    112a:	00f05863          	blez	a5,113a <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
    112e:	4098                	lw	a4,0(s1)
    1130:	fc843783          	ld	a5,-56(s0)
    1134:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1136:	02f74563          	blt	a4,a5,1160 <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
    113a:	fc043783          	ld	a5,-64(s0)
    113e:	cf81                	beqz	a5,1156 <schedule_edf_cbs+0x132>
    1140:	fc043583          	ld	a1,-64(s0)
    1144:	fc843503          	ld	a0,-56(s0)
    1148:	00000097          	auipc	ra,0x0
    114c:	e4c080e7          	jalr	-436(ra) # f94 <__edf_thread_cmp>
    1150:	87aa                	mv	a5,a0
    1152:	0007d863          	bgez	a5,1162 <schedule_edf_cbs+0x13e>
            selected = t;
    1156:	fc843783          	ld	a5,-56(s0)
    115a:	fcf43023          	sd	a5,-64(s0)
    115e:	a011                	j	1162 <schedule_edf_cbs+0x13e>
            continue;
    1160:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
    1162:	fc843783          	ld	a5,-56(s0)
    1166:	779c                	ld	a5,40(a5)
    1168:	f2f43c23          	sd	a5,-200(s0)
    116c:	f3843783          	ld	a5,-200(s0)
    1170:	fd878793          	addi	a5,a5,-40
    1174:	fcf43423          	sd	a5,-56(s0)
    1178:	fc843783          	ld	a5,-56(s0)
    117c:	02878713          	addi	a4,a5,40
    1180:	649c                	ld	a5,8(s1)
    1182:	f8f717e3          	bne	a4,a5,1110 <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    1186:	fc043783          	ld	a5,-64(s0)
    118a:	ebd5                	bnez	a5,123e <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    118c:	800007b7          	lui	a5,0x80000
    1190:	fff7c793          	not	a5,a5
    1194:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    1198:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    119c:	689c                	ld	a5,16(s1)
    119e:	639c                	ld	a5,0(a5)
    11a0:	f4f43423          	sd	a5,-184(s0)
    11a4:	f4843783          	ld	a5,-184(s0)
    11a8:	17e1                	addi	a5,a5,-8
    11aa:	faf43823          	sd	a5,-80(s0)
    11ae:	a835                	j	11ea <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    11b0:	fb043783          	ld	a5,-80(s0)
    11b4:	4f98                	lw	a4,24(a5)
    11b6:	409c                	lw	a5,0(s1)
    11b8:	00e7df63          	bge	a5,a4,11d6 <schedule_edf_cbs+0x1b2>
    11bc:	fb043783          	ld	a5,-80(s0)
    11c0:	4f98                	lw	a4,24(a5)
    11c2:	fbc42783          	lw	a5,-68(s0)
    11c6:	2781                	sext.w	a5,a5
    11c8:	00f75763          	bge	a4,a5,11d6 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    11cc:	fb043783          	ld	a5,-80(s0)
    11d0:	4f9c                	lw	a5,24(a5)
    11d2:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    11d6:	fb043783          	ld	a5,-80(s0)
    11da:	679c                	ld	a5,8(a5)
    11dc:	f4f43023          	sd	a5,-192(s0)
    11e0:	f4043783          	ld	a5,-192(s0)
    11e4:	17e1                	addi	a5,a5,-8
    11e6:	faf43823          	sd	a5,-80(s0)
    11ea:	fb043783          	ld	a5,-80(s0)
    11ee:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffe388>
    11f2:	689c                	ld	a5,16(s1)
    11f4:	faf71ee3          	bne	a4,a5,11b0 <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    11f8:	fbc42783          	lw	a5,-68(s0)
    11fc:	0007871b          	sext.w	a4,a5
    1200:	800007b7          	lui	a5,0x80000
    1204:	fff7c793          	not	a5,a5
    1208:	00f70e63          	beq	a4,a5,1224 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    120c:	649c                	ld	a5,8(s1)
    120e:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    1212:	409c                	lw	a5,0(s1)
    1214:	fbc42703          	lw	a4,-68(s0)
    1218:	40f707bb          	subw	a5,a4,a5
    121c:	2781                	sext.w	a5,a5
    121e:	f0f42c23          	sw	a5,-232(s0)
    1222:	a029                	j	122c <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    1224:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    1228:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    122c:	f1043783          	ld	a5,-240(s0)
    1230:	f2f43023          	sd	a5,-224(s0)
    1234:	f1843783          	ld	a5,-232(s0)
    1238:	f2f43423          	sd	a5,-216(s0)
    123c:	a2f9                	j	140a <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    123e:	fc043783          	ld	a5,-64(s0)
    1242:	57fc                	lw	a5,108(a5)
    1244:	e7f1                	bnez	a5,1310 <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    1246:	fc043783          	ld	a5,-64(s0)
    124a:	57bc                	lw	a5,104(a5)
    124c:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    1250:	fc043783          	ld	a5,-64(s0)
    1254:	4fb8                	lw	a4,88(a5)
    1256:	409c                	lw	a5,0(s1)
    1258:	40f707bb          	subw	a5,a4,a5
    125c:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    1260:	fc043783          	ld	a5,-64(s0)
    1264:	47fc                	lw	a5,76(a5)
    1266:	f5c42703          	lw	a4,-164(s0)
    126a:	02f707bb          	mulw	a5,a4,a5
    126e:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    1272:	fc043783          	ld	a5,-64(s0)
    1276:	53fc                	lw	a5,100(a5)
    1278:	f5842703          	lw	a4,-168(s0)
    127c:	02f707bb          	mulw	a5,a4,a5
    1280:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    1284:	f5442703          	lw	a4,-172(s0)
    1288:	f5042783          	lw	a5,-176(s0)
    128c:	2701                	sext.w	a4,a4
    128e:	2781                	sext.w	a5,a5
    1290:	02e7d363          	bge	a5,a4,12b6 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    1294:	4098                	lw	a4,0(s1)
    1296:	fc043783          	ld	a5,-64(s0)
    129a:	47fc                	lw	a5,76(a5)
    129c:	9fb9                	addw	a5,a5,a4
    129e:	0007871b          	sext.w	a4,a5
    12a2:	fc043783          	ld	a5,-64(s0)
    12a6:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    12a8:	fc043783          	ld	a5,-64(s0)
    12ac:	53f8                	lw	a4,100(a5)
    12ae:	fc043783          	ld	a5,-64(s0)
    12b2:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    12b4:	b341                	j	1034 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    12b6:	fc043783          	ld	a5,-64(s0)
    12ba:	57bc                	lw	a5,104(a5)
    12bc:	02f04063          	bgtz	a5,12dc <schedule_edf_cbs+0x2b8>
    12c0:	fc043783          	ld	a5,-64(s0)
    12c4:	4bfc                	lw	a5,84(a5)
    12c6:	00f05b63          	blez	a5,12dc <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    12ca:	fc043783          	ld	a5,-64(s0)
    12ce:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe3a8>
    12d2:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    12d6:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    12da:	bba9                	j	1034 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    12dc:	fc043783          	ld	a5,-64(s0)
    12e0:	02878793          	addi	a5,a5,40
    12e4:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    12e8:	fc043783          	ld	a5,-64(s0)
    12ec:	57b8                	lw	a4,104(a5)
    12ee:	fc043783          	ld	a5,-64(s0)
    12f2:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    12f4:	863e                	mv	a2,a5
    12f6:	86ba                	mv	a3,a4
    12f8:	0006871b          	sext.w	a4,a3
    12fc:	0006079b          	sext.w	a5,a2
    1300:	00e7d363          	bge	a5,a4,1306 <schedule_edf_cbs+0x2e2>
    1304:	86b2                	mv	a3,a2
    1306:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    130a:	f0f42c23          	sw	a5,-232(s0)
    130e:	a0f5                	j	13fa <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    1310:	fc043783          	ld	a5,-64(s0)
    1314:	4bfc                	lw	a5,84(a5)
    1316:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    131a:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    131e:	689c                	ld	a5,16(s1)
    1320:	639c                	ld	a5,0(a5)
    1322:	f8f43023          	sd	a5,-128(s0)
    1326:	f8043783          	ld	a5,-128(s0)
    132a:	17e1                	addi	a5,a5,-8
    132c:	faf43023          	sd	a5,-96(s0)
    1330:	a041                	j	13b0 <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    1332:	fa043783          	ld	a5,-96(s0)
    1336:	639c                	ld	a5,0(a5)
    1338:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    133c:	f7043783          	ld	a5,-144(s0)
    1340:	53b8                	lw	a4,96(a5)
    1342:	409c                	lw	a5,0(s1)
    1344:	04e7dc63          	bge	a5,a4,139c <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    1348:	f7043783          	ld	a5,-144(s0)
    134c:	53b4                	lw	a3,96(a5)
    134e:	409c                	lw	a5,0(s1)
    1350:	fac42703          	lw	a4,-84(s0)
    1354:	9fb9                	addw	a5,a5,a4
    1356:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    1358:	8736                	mv	a4,a3
    135a:	04f75163          	bge	a4,a5,139c <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    135e:	fc043583          	ld	a1,-64(s0)
    1362:	f7043503          	ld	a0,-144(s0)
    1366:	00000097          	auipc	ra,0x0
    136a:	c2e080e7          	jalr	-978(ra) # f94 <__edf_thread_cmp>
    136e:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    1370:	0207d663          	bgez	a5,139c <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    1374:	f7043783          	ld	a5,-144(s0)
    1378:	53b8                	lw	a4,96(a5)
    137a:	409c                	lw	a5,0(s1)
    137c:	40f707bb          	subw	a5,a4,a5
    1380:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    1384:	f6c42703          	lw	a4,-148(s0)
    1388:	fac42783          	lw	a5,-84(s0)
    138c:	2701                	sext.w	a4,a4
    138e:	2781                	sext.w	a5,a5
    1390:	00f75663          	bge	a4,a5,139c <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    1394:	f6c42783          	lw	a5,-148(s0)
    1398:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    139c:	fa043783          	ld	a5,-96(s0)
    13a0:	679c                	ld	a5,8(a5)
    13a2:	f6f43023          	sd	a5,-160(s0)
    13a6:	f6043783          	ld	a5,-160(s0)
    13aa:	17e1                	addi	a5,a5,-8
    13ac:	faf43023          	sd	a5,-96(s0)
    13b0:	fa043783          	ld	a5,-96(s0)
    13b4:	00878713          	addi	a4,a5,8
    13b8:	689c                	ld	a5,16(s1)
    13ba:	f6f71ce3          	bne	a4,a5,1332 <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    13be:	fc043783          	ld	a5,-64(s0)
    13c2:	4fb8                	lw	a4,88(a5)
    13c4:	409c                	lw	a5,0(s1)
    13c6:	40f707bb          	subw	a5,a4,a5
    13ca:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    13ce:	f7c42703          	lw	a4,-132(s0)
    13d2:	fac42783          	lw	a5,-84(s0)
    13d6:	2701                	sext.w	a4,a4
    13d8:	2781                	sext.w	a5,a5
    13da:	00f75663          	bge	a4,a5,13e6 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    13de:	f7c42783          	lw	a5,-132(s0)
    13e2:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    13e6:	fc043783          	ld	a5,-64(s0)
    13ea:	02878793          	addi	a5,a5,40
    13ee:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    13f2:	fac42783          	lw	a5,-84(s0)
    13f6:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    13fa:	f1043783          	ld	a5,-240(s0)
    13fe:	f2f43023          	sd	a5,-224(s0)
    1402:	f1843783          	ld	a5,-232(s0)
    1406:	f2f43423          	sd	a5,-216(s0)
    140a:	4701                	li	a4,0
    140c:	f2043703          	ld	a4,-224(s0)
    1410:	4781                	li	a5,0
    1412:	f2843783          	ld	a5,-216(s0)
    1416:	893a                	mv	s2,a4
    1418:	89be                	mv	s3,a5
    141a:	874a                	mv	a4,s2
    141c:	87ce                	mv	a5,s3
}
    141e:	853a                	mv	a0,a4
    1420:	85be                	mv	a1,a5
    1422:	70ae                	ld	ra,232(sp)
    1424:	740e                	ld	s0,224(sp)
    1426:	64ee                	ld	s1,216(sp)
    1428:	694e                	ld	s2,208(sp)
    142a:	69ae                	ld	s3,200(sp)
    142c:	616d                	addi	sp,sp,240
    142e:	8082                	ret
