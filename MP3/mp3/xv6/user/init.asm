
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
       8:	4589                	li	a1,2
       a:	00001517          	auipc	a0,0x1
       e:	3ce50513          	addi	a0,a0,974 # 13d8 <schedule_edf_cbs+0x414>
      12:	00000097          	auipc	ra,0x0
      16:	5dc080e7          	jalr	1500(ra) # 5ee <open>
      1a:	87aa                	mv	a5,a0
      1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
      20:	4601                	li	a2,0
      22:	4585                	li	a1,1
      24:	00001517          	auipc	a0,0x1
      28:	3b450513          	addi	a0,a0,948 # 13d8 <schedule_edf_cbs+0x414>
      2c:	00000097          	auipc	ra,0x0
      30:	5ca080e7          	jalr	1482(ra) # 5f6 <mknod>
    open("console", O_RDWR);
      34:	4589                	li	a1,2
      36:	00001517          	auipc	a0,0x1
      3a:	3a250513          	addi	a0,a0,930 # 13d8 <schedule_edf_cbs+0x414>
      3e:	00000097          	auipc	ra,0x0
      42:	5b0080e7          	jalr	1456(ra) # 5ee <open>
  }
  dup(0);  // stdout
      46:	4501                	li	a0,0
      48:	00000097          	auipc	ra,0x0
      4c:	5de080e7          	jalr	1502(ra) # 626 <dup>
  dup(0);  // stderr
      50:	4501                	li	a0,0
      52:	00000097          	auipc	ra,0x0
      56:	5d4080e7          	jalr	1492(ra) # 626 <dup>

  for(;;){
    printf("init: starting sh\n");
      5a:	00001517          	auipc	a0,0x1
      5e:	38650513          	addi	a0,a0,902 # 13e0 <schedule_edf_cbs+0x41c>
      62:	00001097          	auipc	ra,0x1
      66:	a92080e7          	jalr	-1390(ra) # af4 <printf>
    pid = fork();
      6a:	00000097          	auipc	ra,0x0
      6e:	53c080e7          	jalr	1340(ra) # 5a6 <fork>
      72:	87aa                	mv	a5,a0
      74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
      78:	fec42783          	lw	a5,-20(s0)
      7c:	2781                	sext.w	a5,a5
      7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
      82:	00001517          	auipc	a0,0x1
      86:	37650513          	addi	a0,a0,886 # 13f8 <schedule_edf_cbs+0x434>
      8a:	00001097          	auipc	ra,0x1
      8e:	a6a080e7          	jalr	-1430(ra) # af4 <printf>
      exit(1);
      92:	4505                	li	a0,1
      94:	00000097          	auipc	ra,0x0
      98:	51a080e7          	jalr	1306(ra) # 5ae <exit>
    }
    if(pid == 0){
      9c:	fec42783          	lw	a5,-20(s0)
      a0:	2781                	sext.w	a5,a5
      a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
      a4:	00001597          	auipc	a1,0x1
      a8:	3ac58593          	addi	a1,a1,940 # 1450 <argv>
      ac:	00001517          	auipc	a0,0x1
      b0:	32450513          	addi	a0,a0,804 # 13d0 <schedule_edf_cbs+0x40c>
      b4:	00000097          	auipc	ra,0x0
      b8:	532080e7          	jalr	1330(ra) # 5e6 <exec>
      printf("init: exec sh failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	35450513          	addi	a0,a0,852 # 1410 <schedule_edf_cbs+0x44c>
      c4:	00001097          	auipc	ra,0x1
      c8:	a30080e7          	jalr	-1488(ra) # af4 <printf>
      exit(1);
      cc:	4505                	li	a0,1
      ce:	00000097          	auipc	ra,0x0
      d2:	4e0080e7          	jalr	1248(ra) # 5ae <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
      d6:	4501                	li	a0,0
      d8:	00000097          	auipc	ra,0x0
      dc:	4de080e7          	jalr	1246(ra) # 5b6 <wait>
      e0:	87aa                	mv	a5,a0
      e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
      e6:	fe842703          	lw	a4,-24(s0)
      ea:	fec42783          	lw	a5,-20(s0)
      ee:	2701                	sext.w	a4,a4
      f0:	2781                	sext.w	a5,a5
      f2:	02f70463          	beq	a4,a5,11a <main+0x11a>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
      f6:	fe842783          	lw	a5,-24(s0)
      fa:	2781                	sext.w	a5,a5
      fc:	fc07dde3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
     100:	00001517          	auipc	a0,0x1
     104:	32850513          	addi	a0,a0,808 # 1428 <schedule_edf_cbs+0x464>
     108:	00001097          	auipc	ra,0x1
     10c:	9ec080e7          	jalr	-1556(ra) # af4 <printf>
        exit(1);
     110:	4505                	li	a0,1
     112:	00000097          	auipc	ra,0x0
     116:	49c080e7          	jalr	1180(ra) # 5ae <exit>
        break;
     11a:	0001                	nop
    printf("init: starting sh\n");
     11c:	bf3d                	j	5a <main+0x5a>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     11e:	7179                	addi	sp,sp,-48
     120:	f422                	sd	s0,40(sp)
     122:	1800                	addi	s0,sp,48
     124:	fca43c23          	sd	a0,-40(s0)
     128:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     12c:	fd843783          	ld	a5,-40(s0)
     130:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     134:	0001                	nop
     136:	fd043703          	ld	a4,-48(s0)
     13a:	00170793          	addi	a5,a4,1
     13e:	fcf43823          	sd	a5,-48(s0)
     142:	fd843783          	ld	a5,-40(s0)
     146:	00178693          	addi	a3,a5,1
     14a:	fcd43c23          	sd	a3,-40(s0)
     14e:	00074703          	lbu	a4,0(a4)
     152:	00e78023          	sb	a4,0(a5)
     156:	0007c783          	lbu	a5,0(a5)
     15a:	fff1                	bnez	a5,136 <strcpy+0x18>
    ;
  return os;
     15c:	fe843783          	ld	a5,-24(s0)
}
     160:	853e                	mv	a0,a5
     162:	7422                	ld	s0,40(sp)
     164:	6145                	addi	sp,sp,48
     166:	8082                	ret

0000000000000168 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     168:	1101                	addi	sp,sp,-32
     16a:	ec22                	sd	s0,24(sp)
     16c:	1000                	addi	s0,sp,32
     16e:	fea43423          	sd	a0,-24(s0)
     172:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     176:	a819                	j	18c <strcmp+0x24>
    p++, q++;
     178:	fe843783          	ld	a5,-24(s0)
     17c:	0785                	addi	a5,a5,1
     17e:	fef43423          	sd	a5,-24(s0)
     182:	fe043783          	ld	a5,-32(s0)
     186:	0785                	addi	a5,a5,1
     188:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     18c:	fe843783          	ld	a5,-24(s0)
     190:	0007c783          	lbu	a5,0(a5)
     194:	cb99                	beqz	a5,1aa <strcmp+0x42>
     196:	fe843783          	ld	a5,-24(s0)
     19a:	0007c703          	lbu	a4,0(a5)
     19e:	fe043783          	ld	a5,-32(s0)
     1a2:	0007c783          	lbu	a5,0(a5)
     1a6:	fcf709e3          	beq	a4,a5,178 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     1aa:	fe843783          	ld	a5,-24(s0)
     1ae:	0007c783          	lbu	a5,0(a5)
     1b2:	0007871b          	sext.w	a4,a5
     1b6:	fe043783          	ld	a5,-32(s0)
     1ba:	0007c783          	lbu	a5,0(a5)
     1be:	2781                	sext.w	a5,a5
     1c0:	40f707bb          	subw	a5,a4,a5
     1c4:	2781                	sext.w	a5,a5
}
     1c6:	853e                	mv	a0,a5
     1c8:	6462                	ld	s0,24(sp)
     1ca:	6105                	addi	sp,sp,32
     1cc:	8082                	ret

00000000000001ce <strlen>:

uint
strlen(const char *s)
{
     1ce:	7179                	addi	sp,sp,-48
     1d0:	f422                	sd	s0,40(sp)
     1d2:	1800                	addi	s0,sp,48
     1d4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1d8:	fe042623          	sw	zero,-20(s0)
     1dc:	a031                	j	1e8 <strlen+0x1a>
     1de:	fec42783          	lw	a5,-20(s0)
     1e2:	2785                	addiw	a5,a5,1
     1e4:	fef42623          	sw	a5,-20(s0)
     1e8:	fec42783          	lw	a5,-20(s0)
     1ec:	fd843703          	ld	a4,-40(s0)
     1f0:	97ba                	add	a5,a5,a4
     1f2:	0007c783          	lbu	a5,0(a5)
     1f6:	f7e5                	bnez	a5,1de <strlen+0x10>
    ;
  return n;
     1f8:	fec42783          	lw	a5,-20(s0)
}
     1fc:	853e                	mv	a0,a5
     1fe:	7422                	ld	s0,40(sp)
     200:	6145                	addi	sp,sp,48
     202:	8082                	ret

0000000000000204 <memset>:

void*
memset(void *dst, int c, uint n)
{
     204:	7179                	addi	sp,sp,-48
     206:	f422                	sd	s0,40(sp)
     208:	1800                	addi	s0,sp,48
     20a:	fca43c23          	sd	a0,-40(s0)
     20e:	87ae                	mv	a5,a1
     210:	8732                	mv	a4,a2
     212:	fcf42a23          	sw	a5,-44(s0)
     216:	87ba                	mv	a5,a4
     218:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     21c:	fd843783          	ld	a5,-40(s0)
     220:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     224:	fe042623          	sw	zero,-20(s0)
     228:	a00d                	j	24a <memset+0x46>
    cdst[i] = c;
     22a:	fec42783          	lw	a5,-20(s0)
     22e:	fe043703          	ld	a4,-32(s0)
     232:	97ba                	add	a5,a5,a4
     234:	fd442703          	lw	a4,-44(s0)
     238:	0ff77713          	andi	a4,a4,255
     23c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     240:	fec42783          	lw	a5,-20(s0)
     244:	2785                	addiw	a5,a5,1
     246:	fef42623          	sw	a5,-20(s0)
     24a:	fec42703          	lw	a4,-20(s0)
     24e:	fd042783          	lw	a5,-48(s0)
     252:	2781                	sext.w	a5,a5
     254:	fcf76be3          	bltu	a4,a5,22a <memset+0x26>
  }
  return dst;
     258:	fd843783          	ld	a5,-40(s0)
}
     25c:	853e                	mv	a0,a5
     25e:	7422                	ld	s0,40(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <strchr>:

char*
strchr(const char *s, char c)
{
     264:	1101                	addi	sp,sp,-32
     266:	ec22                	sd	s0,24(sp)
     268:	1000                	addi	s0,sp,32
     26a:	fea43423          	sd	a0,-24(s0)
     26e:	87ae                	mv	a5,a1
     270:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     274:	a01d                	j	29a <strchr+0x36>
    if(*s == c)
     276:	fe843783          	ld	a5,-24(s0)
     27a:	0007c703          	lbu	a4,0(a5)
     27e:	fe744783          	lbu	a5,-25(s0)
     282:	0ff7f793          	andi	a5,a5,255
     286:	00e79563          	bne	a5,a4,290 <strchr+0x2c>
      return (char*)s;
     28a:	fe843783          	ld	a5,-24(s0)
     28e:	a821                	j	2a6 <strchr+0x42>
  for(; *s; s++)
     290:	fe843783          	ld	a5,-24(s0)
     294:	0785                	addi	a5,a5,1
     296:	fef43423          	sd	a5,-24(s0)
     29a:	fe843783          	ld	a5,-24(s0)
     29e:	0007c783          	lbu	a5,0(a5)
     2a2:	fbf1                	bnez	a5,276 <strchr+0x12>
  return 0;
     2a4:	4781                	li	a5,0
}
     2a6:	853e                	mv	a0,a5
     2a8:	6462                	ld	s0,24(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <gets>:

char*
gets(char *buf, int max)
{
     2ae:	7179                	addi	sp,sp,-48
     2b0:	f406                	sd	ra,40(sp)
     2b2:	f022                	sd	s0,32(sp)
     2b4:	1800                	addi	s0,sp,48
     2b6:	fca43c23          	sd	a0,-40(s0)
     2ba:	87ae                	mv	a5,a1
     2bc:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2c0:	fe042623          	sw	zero,-20(s0)
     2c4:	a8a1                	j	31c <gets+0x6e>
    cc = read(0, &c, 1);
     2c6:	fe740793          	addi	a5,s0,-25
     2ca:	4605                	li	a2,1
     2cc:	85be                	mv	a1,a5
     2ce:	4501                	li	a0,0
     2d0:	00000097          	auipc	ra,0x0
     2d4:	2f6080e7          	jalr	758(ra) # 5c6 <read>
     2d8:	87aa                	mv	a5,a0
     2da:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2de:	fe842783          	lw	a5,-24(s0)
     2e2:	2781                	sext.w	a5,a5
     2e4:	04f05763          	blez	a5,332 <gets+0x84>
      break;
    buf[i++] = c;
     2e8:	fec42783          	lw	a5,-20(s0)
     2ec:	0017871b          	addiw	a4,a5,1
     2f0:	fee42623          	sw	a4,-20(s0)
     2f4:	873e                	mv	a4,a5
     2f6:	fd843783          	ld	a5,-40(s0)
     2fa:	97ba                	add	a5,a5,a4
     2fc:	fe744703          	lbu	a4,-25(s0)
     300:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     304:	fe744783          	lbu	a5,-25(s0)
     308:	873e                	mv	a4,a5
     30a:	47a9                	li	a5,10
     30c:	02f70463          	beq	a4,a5,334 <gets+0x86>
     310:	fe744783          	lbu	a5,-25(s0)
     314:	873e                	mv	a4,a5
     316:	47b5                	li	a5,13
     318:	00f70e63          	beq	a4,a5,334 <gets+0x86>
  for(i=0; i+1 < max; ){
     31c:	fec42783          	lw	a5,-20(s0)
     320:	2785                	addiw	a5,a5,1
     322:	0007871b          	sext.w	a4,a5
     326:	fd442783          	lw	a5,-44(s0)
     32a:	2781                	sext.w	a5,a5
     32c:	f8f74de3          	blt	a4,a5,2c6 <gets+0x18>
     330:	a011                	j	334 <gets+0x86>
      break;
     332:	0001                	nop
      break;
  }
  buf[i] = '\0';
     334:	fec42783          	lw	a5,-20(s0)
     338:	fd843703          	ld	a4,-40(s0)
     33c:	97ba                	add	a5,a5,a4
     33e:	00078023          	sb	zero,0(a5)
  return buf;
     342:	fd843783          	ld	a5,-40(s0)
}
     346:	853e                	mv	a0,a5
     348:	70a2                	ld	ra,40(sp)
     34a:	7402                	ld	s0,32(sp)
     34c:	6145                	addi	sp,sp,48
     34e:	8082                	ret

0000000000000350 <stat>:

int
stat(const char *n, struct stat *st)
{
     350:	7179                	addi	sp,sp,-48
     352:	f406                	sd	ra,40(sp)
     354:	f022                	sd	s0,32(sp)
     356:	1800                	addi	s0,sp,48
     358:	fca43c23          	sd	a0,-40(s0)
     35c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     360:	4581                	li	a1,0
     362:	fd843503          	ld	a0,-40(s0)
     366:	00000097          	auipc	ra,0x0
     36a:	288080e7          	jalr	648(ra) # 5ee <open>
     36e:	87aa                	mv	a5,a0
     370:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     374:	fec42783          	lw	a5,-20(s0)
     378:	2781                	sext.w	a5,a5
     37a:	0007d463          	bgez	a5,382 <stat+0x32>
    return -1;
     37e:	57fd                	li	a5,-1
     380:	a035                	j	3ac <stat+0x5c>
  r = fstat(fd, st);
     382:	fec42783          	lw	a5,-20(s0)
     386:	fd043583          	ld	a1,-48(s0)
     38a:	853e                	mv	a0,a5
     38c:	00000097          	auipc	ra,0x0
     390:	27a080e7          	jalr	634(ra) # 606 <fstat>
     394:	87aa                	mv	a5,a0
     396:	fef42423          	sw	a5,-24(s0)
  close(fd);
     39a:	fec42783          	lw	a5,-20(s0)
     39e:	853e                	mv	a0,a5
     3a0:	00000097          	auipc	ra,0x0
     3a4:	236080e7          	jalr	566(ra) # 5d6 <close>
  return r;
     3a8:	fe842783          	lw	a5,-24(s0)
}
     3ac:	853e                	mv	a0,a5
     3ae:	70a2                	ld	ra,40(sp)
     3b0:	7402                	ld	s0,32(sp)
     3b2:	6145                	addi	sp,sp,48
     3b4:	8082                	ret

00000000000003b6 <atoi>:

int
atoi(const char *s)
{
     3b6:	7179                	addi	sp,sp,-48
     3b8:	f422                	sd	s0,40(sp)
     3ba:	1800                	addi	s0,sp,48
     3bc:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3c0:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3c4:	a815                	j	3f8 <atoi+0x42>
    n = n*10 + *s++ - '0';
     3c6:	fec42703          	lw	a4,-20(s0)
     3ca:	87ba                	mv	a5,a4
     3cc:	0027979b          	slliw	a5,a5,0x2
     3d0:	9fb9                	addw	a5,a5,a4
     3d2:	0017979b          	slliw	a5,a5,0x1
     3d6:	0007871b          	sext.w	a4,a5
     3da:	fd843783          	ld	a5,-40(s0)
     3de:	00178693          	addi	a3,a5,1
     3e2:	fcd43c23          	sd	a3,-40(s0)
     3e6:	0007c783          	lbu	a5,0(a5)
     3ea:	2781                	sext.w	a5,a5
     3ec:	9fb9                	addw	a5,a5,a4
     3ee:	2781                	sext.w	a5,a5
     3f0:	fd07879b          	addiw	a5,a5,-48
     3f4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3f8:	fd843783          	ld	a5,-40(s0)
     3fc:	0007c783          	lbu	a5,0(a5)
     400:	873e                	mv	a4,a5
     402:	02f00793          	li	a5,47
     406:	00e7fb63          	bgeu	a5,a4,41c <atoi+0x66>
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	0007c783          	lbu	a5,0(a5)
     412:	873e                	mv	a4,a5
     414:	03900793          	li	a5,57
     418:	fae7f7e3          	bgeu	a5,a4,3c6 <atoi+0x10>
  return n;
     41c:	fec42783          	lw	a5,-20(s0)
}
     420:	853e                	mv	a0,a5
     422:	7422                	ld	s0,40(sp)
     424:	6145                	addi	sp,sp,48
     426:	8082                	ret

0000000000000428 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     428:	7139                	addi	sp,sp,-64
     42a:	fc22                	sd	s0,56(sp)
     42c:	0080                	addi	s0,sp,64
     42e:	fca43c23          	sd	a0,-40(s0)
     432:	fcb43823          	sd	a1,-48(s0)
     436:	87b2                	mv	a5,a2
     438:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     43c:	fd843783          	ld	a5,-40(s0)
     440:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     444:	fd043783          	ld	a5,-48(s0)
     448:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     44c:	fe043703          	ld	a4,-32(s0)
     450:	fe843783          	ld	a5,-24(s0)
     454:	02e7fc63          	bgeu	a5,a4,48c <memmove+0x64>
    while(n-- > 0)
     458:	a00d                	j	47a <memmove+0x52>
      *dst++ = *src++;
     45a:	fe043703          	ld	a4,-32(s0)
     45e:	00170793          	addi	a5,a4,1
     462:	fef43023          	sd	a5,-32(s0)
     466:	fe843783          	ld	a5,-24(s0)
     46a:	00178693          	addi	a3,a5,1
     46e:	fed43423          	sd	a3,-24(s0)
     472:	00074703          	lbu	a4,0(a4)
     476:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     47a:	fcc42783          	lw	a5,-52(s0)
     47e:	fff7871b          	addiw	a4,a5,-1
     482:	fce42623          	sw	a4,-52(s0)
     486:	fcf04ae3          	bgtz	a5,45a <memmove+0x32>
     48a:	a891                	j	4de <memmove+0xb6>
  } else {
    dst += n;
     48c:	fcc42783          	lw	a5,-52(s0)
     490:	fe843703          	ld	a4,-24(s0)
     494:	97ba                	add	a5,a5,a4
     496:	fef43423          	sd	a5,-24(s0)
    src += n;
     49a:	fcc42783          	lw	a5,-52(s0)
     49e:	fe043703          	ld	a4,-32(s0)
     4a2:	97ba                	add	a5,a5,a4
     4a4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     4a8:	a01d                	j	4ce <memmove+0xa6>
      *--dst = *--src;
     4aa:	fe043783          	ld	a5,-32(s0)
     4ae:	17fd                	addi	a5,a5,-1
     4b0:	fef43023          	sd	a5,-32(s0)
     4b4:	fe843783          	ld	a5,-24(s0)
     4b8:	17fd                	addi	a5,a5,-1
     4ba:	fef43423          	sd	a5,-24(s0)
     4be:	fe043783          	ld	a5,-32(s0)
     4c2:	0007c703          	lbu	a4,0(a5)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4ce:	fcc42783          	lw	a5,-52(s0)
     4d2:	fff7871b          	addiw	a4,a5,-1
     4d6:	fce42623          	sw	a4,-52(s0)
     4da:	fcf048e3          	bgtz	a5,4aa <memmove+0x82>
  }
  return vdst;
     4de:	fd843783          	ld	a5,-40(s0)
}
     4e2:	853e                	mv	a0,a5
     4e4:	7462                	ld	s0,56(sp)
     4e6:	6121                	addi	sp,sp,64
     4e8:	8082                	ret

00000000000004ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4ea:	7139                	addi	sp,sp,-64
     4ec:	fc22                	sd	s0,56(sp)
     4ee:	0080                	addi	s0,sp,64
     4f0:	fca43c23          	sd	a0,-40(s0)
     4f4:	fcb43823          	sd	a1,-48(s0)
     4f8:	87b2                	mv	a5,a2
     4fa:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4fe:	fd843783          	ld	a5,-40(s0)
     502:	fef43423          	sd	a5,-24(s0)
     506:	fd043783          	ld	a5,-48(s0)
     50a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     50e:	a0a1                	j	556 <memcmp+0x6c>
    if (*p1 != *p2) {
     510:	fe843783          	ld	a5,-24(s0)
     514:	0007c703          	lbu	a4,0(a5)
     518:	fe043783          	ld	a5,-32(s0)
     51c:	0007c783          	lbu	a5,0(a5)
     520:	02f70163          	beq	a4,a5,542 <memcmp+0x58>
      return *p1 - *p2;
     524:	fe843783          	ld	a5,-24(s0)
     528:	0007c783          	lbu	a5,0(a5)
     52c:	0007871b          	sext.w	a4,a5
     530:	fe043783          	ld	a5,-32(s0)
     534:	0007c783          	lbu	a5,0(a5)
     538:	2781                	sext.w	a5,a5
     53a:	40f707bb          	subw	a5,a4,a5
     53e:	2781                	sext.w	a5,a5
     540:	a01d                	j	566 <memcmp+0x7c>
    }
    p1++;
     542:	fe843783          	ld	a5,-24(s0)
     546:	0785                	addi	a5,a5,1
     548:	fef43423          	sd	a5,-24(s0)
    p2++;
     54c:	fe043783          	ld	a5,-32(s0)
     550:	0785                	addi	a5,a5,1
     552:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     556:	fcc42783          	lw	a5,-52(s0)
     55a:	fff7871b          	addiw	a4,a5,-1
     55e:	fce42623          	sw	a4,-52(s0)
     562:	f7dd                	bnez	a5,510 <memcmp+0x26>
  }
  return 0;
     564:	4781                	li	a5,0
}
     566:	853e                	mv	a0,a5
     568:	7462                	ld	s0,56(sp)
     56a:	6121                	addi	sp,sp,64
     56c:	8082                	ret

000000000000056e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     56e:	7179                	addi	sp,sp,-48
     570:	f406                	sd	ra,40(sp)
     572:	f022                	sd	s0,32(sp)
     574:	1800                	addi	s0,sp,48
     576:	fea43423          	sd	a0,-24(s0)
     57a:	feb43023          	sd	a1,-32(s0)
     57e:	87b2                	mv	a5,a2
     580:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     584:	fdc42783          	lw	a5,-36(s0)
     588:	863e                	mv	a2,a5
     58a:	fe043583          	ld	a1,-32(s0)
     58e:	fe843503          	ld	a0,-24(s0)
     592:	00000097          	auipc	ra,0x0
     596:	e96080e7          	jalr	-362(ra) # 428 <memmove>
     59a:	87aa                	mv	a5,a0
}
     59c:	853e                	mv	a0,a5
     59e:	70a2                	ld	ra,40(sp)
     5a0:	7402                	ld	s0,32(sp)
     5a2:	6145                	addi	sp,sp,48
     5a4:	8082                	ret

00000000000005a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     5a6:	4885                	li	a7,1
 ecall
     5a8:	00000073          	ecall
 ret
     5ac:	8082                	ret

00000000000005ae <exit>:
.global exit
exit:
 li a7, SYS_exit
     5ae:	4889                	li	a7,2
 ecall
     5b0:	00000073          	ecall
 ret
     5b4:	8082                	ret

00000000000005b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
     5b6:	488d                	li	a7,3
 ecall
     5b8:	00000073          	ecall
 ret
     5bc:	8082                	ret

00000000000005be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     5be:	4891                	li	a7,4
 ecall
     5c0:	00000073          	ecall
 ret
     5c4:	8082                	ret

00000000000005c6 <read>:
.global read
read:
 li a7, SYS_read
     5c6:	4895                	li	a7,5
 ecall
     5c8:	00000073          	ecall
 ret
     5cc:	8082                	ret

00000000000005ce <write>:
.global write
write:
 li a7, SYS_write
     5ce:	48c1                	li	a7,16
 ecall
     5d0:	00000073          	ecall
 ret
     5d4:	8082                	ret

00000000000005d6 <close>:
.global close
close:
 li a7, SYS_close
     5d6:	48d5                	li	a7,21
 ecall
     5d8:	00000073          	ecall
 ret
     5dc:	8082                	ret

00000000000005de <kill>:
.global kill
kill:
 li a7, SYS_kill
     5de:	4899                	li	a7,6
 ecall
     5e0:	00000073          	ecall
 ret
     5e4:	8082                	ret

00000000000005e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     5e6:	489d                	li	a7,7
 ecall
     5e8:	00000073          	ecall
 ret
     5ec:	8082                	ret

00000000000005ee <open>:
.global open
open:
 li a7, SYS_open
     5ee:	48bd                	li	a7,15
 ecall
     5f0:	00000073          	ecall
 ret
     5f4:	8082                	ret

00000000000005f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5f6:	48c5                	li	a7,17
 ecall
     5f8:	00000073          	ecall
 ret
     5fc:	8082                	ret

00000000000005fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5fe:	48c9                	li	a7,18
 ecall
     600:	00000073          	ecall
 ret
     604:	8082                	ret

0000000000000606 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     606:	48a1                	li	a7,8
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <link>:
.global link
link:
 li a7, SYS_link
     60e:	48cd                	li	a7,19
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     616:	48d1                	li	a7,20
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     61e:	48a5                	li	a7,9
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <dup>:
.global dup
dup:
 li a7, SYS_dup
     626:	48a9                	li	a7,10
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     62e:	48ad                	li	a7,11
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     636:	48b1                	li	a7,12
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     63e:	48b5                	li	a7,13
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     646:	48b9                	li	a7,14
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     64e:	48d9                	li	a7,22
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     656:	48dd                	li	a7,23
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     65e:	48e1                	li	a7,24
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     666:	1101                	addi	sp,sp,-32
     668:	ec06                	sd	ra,24(sp)
     66a:	e822                	sd	s0,16(sp)
     66c:	1000                	addi	s0,sp,32
     66e:	87aa                	mv	a5,a0
     670:	872e                	mv	a4,a1
     672:	fef42623          	sw	a5,-20(s0)
     676:	87ba                	mv	a5,a4
     678:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     67c:	feb40713          	addi	a4,s0,-21
     680:	fec42783          	lw	a5,-20(s0)
     684:	4605                	li	a2,1
     686:	85ba                	mv	a1,a4
     688:	853e                	mv	a0,a5
     68a:	00000097          	auipc	ra,0x0
     68e:	f44080e7          	jalr	-188(ra) # 5ce <write>
}
     692:	0001                	nop
     694:	60e2                	ld	ra,24(sp)
     696:	6442                	ld	s0,16(sp)
     698:	6105                	addi	sp,sp,32
     69a:	8082                	ret

000000000000069c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     69c:	7139                	addi	sp,sp,-64
     69e:	fc06                	sd	ra,56(sp)
     6a0:	f822                	sd	s0,48(sp)
     6a2:	0080                	addi	s0,sp,64
     6a4:	87aa                	mv	a5,a0
     6a6:	8736                	mv	a4,a3
     6a8:	fcf42623          	sw	a5,-52(s0)
     6ac:	87ae                	mv	a5,a1
     6ae:	fcf42423          	sw	a5,-56(s0)
     6b2:	87b2                	mv	a5,a2
     6b4:	fcf42223          	sw	a5,-60(s0)
     6b8:	87ba                	mv	a5,a4
     6ba:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6be:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6c2:	fc042783          	lw	a5,-64(s0)
     6c6:	2781                	sext.w	a5,a5
     6c8:	c38d                	beqz	a5,6ea <printint+0x4e>
     6ca:	fc842783          	lw	a5,-56(s0)
     6ce:	2781                	sext.w	a5,a5
     6d0:	0007dd63          	bgez	a5,6ea <printint+0x4e>
    neg = 1;
     6d4:	4785                	li	a5,1
     6d6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6da:	fc842783          	lw	a5,-56(s0)
     6de:	40f007bb          	negw	a5,a5
     6e2:	2781                	sext.w	a5,a5
     6e4:	fef42223          	sw	a5,-28(s0)
     6e8:	a029                	j	6f2 <printint+0x56>
  } else {
    x = xx;
     6ea:	fc842783          	lw	a5,-56(s0)
     6ee:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6f2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6f6:	fc442783          	lw	a5,-60(s0)
     6fa:	fe442703          	lw	a4,-28(s0)
     6fe:	02f777bb          	remuw	a5,a4,a5
     702:	0007861b          	sext.w	a2,a5
     706:	fec42783          	lw	a5,-20(s0)
     70a:	0017871b          	addiw	a4,a5,1
     70e:	fee42623          	sw	a4,-20(s0)
     712:	00001697          	auipc	a3,0x1
     716:	d4e68693          	addi	a3,a3,-690 # 1460 <digits>
     71a:	02061713          	slli	a4,a2,0x20
     71e:	9301                	srli	a4,a4,0x20
     720:	9736                	add	a4,a4,a3
     722:	00074703          	lbu	a4,0(a4)
     726:	ff040693          	addi	a3,s0,-16
     72a:	97b6                	add	a5,a5,a3
     72c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     730:	fc442783          	lw	a5,-60(s0)
     734:	fe442703          	lw	a4,-28(s0)
     738:	02f757bb          	divuw	a5,a4,a5
     73c:	fef42223          	sw	a5,-28(s0)
     740:	fe442783          	lw	a5,-28(s0)
     744:	2781                	sext.w	a5,a5
     746:	fbc5                	bnez	a5,6f6 <printint+0x5a>
  if(neg)
     748:	fe842783          	lw	a5,-24(s0)
     74c:	2781                	sext.w	a5,a5
     74e:	cf95                	beqz	a5,78a <printint+0xee>
    buf[i++] = '-';
     750:	fec42783          	lw	a5,-20(s0)
     754:	0017871b          	addiw	a4,a5,1
     758:	fee42623          	sw	a4,-20(s0)
     75c:	ff040713          	addi	a4,s0,-16
     760:	97ba                	add	a5,a5,a4
     762:	02d00713          	li	a4,45
     766:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     76a:	a005                	j	78a <printint+0xee>
    putc(fd, buf[i]);
     76c:	fec42783          	lw	a5,-20(s0)
     770:	ff040713          	addi	a4,s0,-16
     774:	97ba                	add	a5,a5,a4
     776:	fe07c703          	lbu	a4,-32(a5)
     77a:	fcc42783          	lw	a5,-52(s0)
     77e:	85ba                	mv	a1,a4
     780:	853e                	mv	a0,a5
     782:	00000097          	auipc	ra,0x0
     786:	ee4080e7          	jalr	-284(ra) # 666 <putc>
  while(--i >= 0)
     78a:	fec42783          	lw	a5,-20(s0)
     78e:	37fd                	addiw	a5,a5,-1
     790:	fef42623          	sw	a5,-20(s0)
     794:	fec42783          	lw	a5,-20(s0)
     798:	2781                	sext.w	a5,a5
     79a:	fc07d9e3          	bgez	a5,76c <printint+0xd0>
}
     79e:	0001                	nop
     7a0:	0001                	nop
     7a2:	70e2                	ld	ra,56(sp)
     7a4:	7442                	ld	s0,48(sp)
     7a6:	6121                	addi	sp,sp,64
     7a8:	8082                	ret

00000000000007aa <printptr>:

static void
printptr(int fd, uint64 x) {
     7aa:	7179                	addi	sp,sp,-48
     7ac:	f406                	sd	ra,40(sp)
     7ae:	f022                	sd	s0,32(sp)
     7b0:	1800                	addi	s0,sp,48
     7b2:	87aa                	mv	a5,a0
     7b4:	fcb43823          	sd	a1,-48(s0)
     7b8:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7bc:	fdc42783          	lw	a5,-36(s0)
     7c0:	03000593          	li	a1,48
     7c4:	853e                	mv	a0,a5
     7c6:	00000097          	auipc	ra,0x0
     7ca:	ea0080e7          	jalr	-352(ra) # 666 <putc>
  putc(fd, 'x');
     7ce:	fdc42783          	lw	a5,-36(s0)
     7d2:	07800593          	li	a1,120
     7d6:	853e                	mv	a0,a5
     7d8:	00000097          	auipc	ra,0x0
     7dc:	e8e080e7          	jalr	-370(ra) # 666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7e0:	fe042623          	sw	zero,-20(s0)
     7e4:	a82d                	j	81e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7e6:	fd043783          	ld	a5,-48(s0)
     7ea:	93f1                	srli	a5,a5,0x3c
     7ec:	00001717          	auipc	a4,0x1
     7f0:	c7470713          	addi	a4,a4,-908 # 1460 <digits>
     7f4:	97ba                	add	a5,a5,a4
     7f6:	0007c703          	lbu	a4,0(a5)
     7fa:	fdc42783          	lw	a5,-36(s0)
     7fe:	85ba                	mv	a1,a4
     800:	853e                	mv	a0,a5
     802:	00000097          	auipc	ra,0x0
     806:	e64080e7          	jalr	-412(ra) # 666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     80a:	fec42783          	lw	a5,-20(s0)
     80e:	2785                	addiw	a5,a5,1
     810:	fef42623          	sw	a5,-20(s0)
     814:	fd043783          	ld	a5,-48(s0)
     818:	0792                	slli	a5,a5,0x4
     81a:	fcf43823          	sd	a5,-48(s0)
     81e:	fec42783          	lw	a5,-20(s0)
     822:	873e                	mv	a4,a5
     824:	47bd                	li	a5,15
     826:	fce7f0e3          	bgeu	a5,a4,7e6 <printptr+0x3c>
}
     82a:	0001                	nop
     82c:	0001                	nop
     82e:	70a2                	ld	ra,40(sp)
     830:	7402                	ld	s0,32(sp)
     832:	6145                	addi	sp,sp,48
     834:	8082                	ret

0000000000000836 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     836:	715d                	addi	sp,sp,-80
     838:	e486                	sd	ra,72(sp)
     83a:	e0a2                	sd	s0,64(sp)
     83c:	0880                	addi	s0,sp,80
     83e:	87aa                	mv	a5,a0
     840:	fcb43023          	sd	a1,-64(s0)
     844:	fac43c23          	sd	a2,-72(s0)
     848:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     84c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     850:	fe042223          	sw	zero,-28(s0)
     854:	a42d                	j	a7e <vprintf+0x248>
    c = fmt[i] & 0xff;
     856:	fe442783          	lw	a5,-28(s0)
     85a:	fc043703          	ld	a4,-64(s0)
     85e:	97ba                	add	a5,a5,a4
     860:	0007c783          	lbu	a5,0(a5)
     864:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     868:	fe042783          	lw	a5,-32(s0)
     86c:	2781                	sext.w	a5,a5
     86e:	eb9d                	bnez	a5,8a4 <vprintf+0x6e>
      if(c == '%'){
     870:	fdc42783          	lw	a5,-36(s0)
     874:	0007871b          	sext.w	a4,a5
     878:	02500793          	li	a5,37
     87c:	00f71763          	bne	a4,a5,88a <vprintf+0x54>
        state = '%';
     880:	02500793          	li	a5,37
     884:	fef42023          	sw	a5,-32(s0)
     888:	a2f5                	j	a74 <vprintf+0x23e>
      } else {
        putc(fd, c);
     88a:	fdc42783          	lw	a5,-36(s0)
     88e:	0ff7f713          	andi	a4,a5,255
     892:	fcc42783          	lw	a5,-52(s0)
     896:	85ba                	mv	a1,a4
     898:	853e                	mv	a0,a5
     89a:	00000097          	auipc	ra,0x0
     89e:	dcc080e7          	jalr	-564(ra) # 666 <putc>
     8a2:	aac9                	j	a74 <vprintf+0x23e>
      }
    } else if(state == '%'){
     8a4:	fe042783          	lw	a5,-32(s0)
     8a8:	0007871b          	sext.w	a4,a5
     8ac:	02500793          	li	a5,37
     8b0:	1cf71263          	bne	a4,a5,a74 <vprintf+0x23e>
      if(c == 'd'){
     8b4:	fdc42783          	lw	a5,-36(s0)
     8b8:	0007871b          	sext.w	a4,a5
     8bc:	06400793          	li	a5,100
     8c0:	02f71463          	bne	a4,a5,8e8 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     8c4:	fb843783          	ld	a5,-72(s0)
     8c8:	00878713          	addi	a4,a5,8
     8cc:	fae43c23          	sd	a4,-72(s0)
     8d0:	4398                	lw	a4,0(a5)
     8d2:	fcc42783          	lw	a5,-52(s0)
     8d6:	4685                	li	a3,1
     8d8:	4629                	li	a2,10
     8da:	85ba                	mv	a1,a4
     8dc:	853e                	mv	a0,a5
     8de:	00000097          	auipc	ra,0x0
     8e2:	dbe080e7          	jalr	-578(ra) # 69c <printint>
     8e6:	a269                	j	a70 <vprintf+0x23a>
      } else if(c == 'l') {
     8e8:	fdc42783          	lw	a5,-36(s0)
     8ec:	0007871b          	sext.w	a4,a5
     8f0:	06c00793          	li	a5,108
     8f4:	02f71663          	bne	a4,a5,920 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8f8:	fb843783          	ld	a5,-72(s0)
     8fc:	00878713          	addi	a4,a5,8
     900:	fae43c23          	sd	a4,-72(s0)
     904:	639c                	ld	a5,0(a5)
     906:	0007871b          	sext.w	a4,a5
     90a:	fcc42783          	lw	a5,-52(s0)
     90e:	4681                	li	a3,0
     910:	4629                	li	a2,10
     912:	85ba                	mv	a1,a4
     914:	853e                	mv	a0,a5
     916:	00000097          	auipc	ra,0x0
     91a:	d86080e7          	jalr	-634(ra) # 69c <printint>
     91e:	aa89                	j	a70 <vprintf+0x23a>
      } else if(c == 'x') {
     920:	fdc42783          	lw	a5,-36(s0)
     924:	0007871b          	sext.w	a4,a5
     928:	07800793          	li	a5,120
     92c:	02f71463          	bne	a4,a5,954 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     930:	fb843783          	ld	a5,-72(s0)
     934:	00878713          	addi	a4,a5,8
     938:	fae43c23          	sd	a4,-72(s0)
     93c:	4398                	lw	a4,0(a5)
     93e:	fcc42783          	lw	a5,-52(s0)
     942:	4681                	li	a3,0
     944:	4641                	li	a2,16
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	00000097          	auipc	ra,0x0
     94e:	d52080e7          	jalr	-686(ra) # 69c <printint>
     952:	aa39                	j	a70 <vprintf+0x23a>
      } else if(c == 'p') {
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0007871b          	sext.w	a4,a5
     95c:	07000793          	li	a5,112
     960:	02f71263          	bne	a4,a5,984 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     964:	fb843783          	ld	a5,-72(s0)
     968:	00878713          	addi	a4,a5,8
     96c:	fae43c23          	sd	a4,-72(s0)
     970:	6398                	ld	a4,0(a5)
     972:	fcc42783          	lw	a5,-52(s0)
     976:	85ba                	mv	a1,a4
     978:	853e                	mv	a0,a5
     97a:	00000097          	auipc	ra,0x0
     97e:	e30080e7          	jalr	-464(ra) # 7aa <printptr>
     982:	a0fd                	j	a70 <vprintf+0x23a>
      } else if(c == 's'){
     984:	fdc42783          	lw	a5,-36(s0)
     988:	0007871b          	sext.w	a4,a5
     98c:	07300793          	li	a5,115
     990:	04f71c63          	bne	a4,a5,9e8 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     994:	fb843783          	ld	a5,-72(s0)
     998:	00878713          	addi	a4,a5,8
     99c:	fae43c23          	sd	a4,-72(s0)
     9a0:	639c                	ld	a5,0(a5)
     9a2:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     9a6:	fe843783          	ld	a5,-24(s0)
     9aa:	eb8d                	bnez	a5,9dc <vprintf+0x1a6>
          s = "(null)";
     9ac:	00001797          	auipc	a5,0x1
     9b0:	a9c78793          	addi	a5,a5,-1380 # 1448 <schedule_edf_cbs+0x484>
     9b4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9b8:	a015                	j	9dc <vprintf+0x1a6>
          putc(fd, *s);
     9ba:	fe843783          	ld	a5,-24(s0)
     9be:	0007c703          	lbu	a4,0(a5)
     9c2:	fcc42783          	lw	a5,-52(s0)
     9c6:	85ba                	mv	a1,a4
     9c8:	853e                	mv	a0,a5
     9ca:	00000097          	auipc	ra,0x0
     9ce:	c9c080e7          	jalr	-868(ra) # 666 <putc>
          s++;
     9d2:	fe843783          	ld	a5,-24(s0)
     9d6:	0785                	addi	a5,a5,1
     9d8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9dc:	fe843783          	ld	a5,-24(s0)
     9e0:	0007c783          	lbu	a5,0(a5)
     9e4:	fbf9                	bnez	a5,9ba <vprintf+0x184>
     9e6:	a069                	j	a70 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     9e8:	fdc42783          	lw	a5,-36(s0)
     9ec:	0007871b          	sext.w	a4,a5
     9f0:	06300793          	li	a5,99
     9f4:	02f71463          	bne	a4,a5,a1c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9f8:	fb843783          	ld	a5,-72(s0)
     9fc:	00878713          	addi	a4,a5,8
     a00:	fae43c23          	sd	a4,-72(s0)
     a04:	439c                	lw	a5,0(a5)
     a06:	0ff7f713          	andi	a4,a5,255
     a0a:	fcc42783          	lw	a5,-52(s0)
     a0e:	85ba                	mv	a1,a4
     a10:	853e                	mv	a0,a5
     a12:	00000097          	auipc	ra,0x0
     a16:	c54080e7          	jalr	-940(ra) # 666 <putc>
     a1a:	a899                	j	a70 <vprintf+0x23a>
      } else if(c == '%'){
     a1c:	fdc42783          	lw	a5,-36(s0)
     a20:	0007871b          	sext.w	a4,a5
     a24:	02500793          	li	a5,37
     a28:	00f71f63          	bne	a4,a5,a46 <vprintf+0x210>
        putc(fd, c);
     a2c:	fdc42783          	lw	a5,-36(s0)
     a30:	0ff7f713          	andi	a4,a5,255
     a34:	fcc42783          	lw	a5,-52(s0)
     a38:	85ba                	mv	a1,a4
     a3a:	853e                	mv	a0,a5
     a3c:	00000097          	auipc	ra,0x0
     a40:	c2a080e7          	jalr	-982(ra) # 666 <putc>
     a44:	a035                	j	a70 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a46:	fcc42783          	lw	a5,-52(s0)
     a4a:	02500593          	li	a1,37
     a4e:	853e                	mv	a0,a5
     a50:	00000097          	auipc	ra,0x0
     a54:	c16080e7          	jalr	-1002(ra) # 666 <putc>
        putc(fd, c);
     a58:	fdc42783          	lw	a5,-36(s0)
     a5c:	0ff7f713          	andi	a4,a5,255
     a60:	fcc42783          	lw	a5,-52(s0)
     a64:	85ba                	mv	a1,a4
     a66:	853e                	mv	a0,a5
     a68:	00000097          	auipc	ra,0x0
     a6c:	bfe080e7          	jalr	-1026(ra) # 666 <putc>
      }
      state = 0;
     a70:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a74:	fe442783          	lw	a5,-28(s0)
     a78:	2785                	addiw	a5,a5,1
     a7a:	fef42223          	sw	a5,-28(s0)
     a7e:	fe442783          	lw	a5,-28(s0)
     a82:	fc043703          	ld	a4,-64(s0)
     a86:	97ba                	add	a5,a5,a4
     a88:	0007c783          	lbu	a5,0(a5)
     a8c:	dc0795e3          	bnez	a5,856 <vprintf+0x20>
    }
  }
}
     a90:	0001                	nop
     a92:	0001                	nop
     a94:	60a6                	ld	ra,72(sp)
     a96:	6406                	ld	s0,64(sp)
     a98:	6161                	addi	sp,sp,80
     a9a:	8082                	ret

0000000000000a9c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a9c:	7159                	addi	sp,sp,-112
     a9e:	fc06                	sd	ra,56(sp)
     aa0:	f822                	sd	s0,48(sp)
     aa2:	0080                	addi	s0,sp,64
     aa4:	fcb43823          	sd	a1,-48(s0)
     aa8:	e010                	sd	a2,0(s0)
     aaa:	e414                	sd	a3,8(s0)
     aac:	e818                	sd	a4,16(s0)
     aae:	ec1c                	sd	a5,24(s0)
     ab0:	03043023          	sd	a6,32(s0)
     ab4:	03143423          	sd	a7,40(s0)
     ab8:	87aa                	mv	a5,a0
     aba:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     abe:	03040793          	addi	a5,s0,48
     ac2:	fcf43423          	sd	a5,-56(s0)
     ac6:	fc843783          	ld	a5,-56(s0)
     aca:	fd078793          	addi	a5,a5,-48
     ace:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     ad2:	fe843703          	ld	a4,-24(s0)
     ad6:	fdc42783          	lw	a5,-36(s0)
     ada:	863a                	mv	a2,a4
     adc:	fd043583          	ld	a1,-48(s0)
     ae0:	853e                	mv	a0,a5
     ae2:	00000097          	auipc	ra,0x0
     ae6:	d54080e7          	jalr	-684(ra) # 836 <vprintf>
}
     aea:	0001                	nop
     aec:	70e2                	ld	ra,56(sp)
     aee:	7442                	ld	s0,48(sp)
     af0:	6165                	addi	sp,sp,112
     af2:	8082                	ret

0000000000000af4 <printf>:

void
printf(const char *fmt, ...)
{
     af4:	7159                	addi	sp,sp,-112
     af6:	f406                	sd	ra,40(sp)
     af8:	f022                	sd	s0,32(sp)
     afa:	1800                	addi	s0,sp,48
     afc:	fca43c23          	sd	a0,-40(s0)
     b00:	e40c                	sd	a1,8(s0)
     b02:	e810                	sd	a2,16(s0)
     b04:	ec14                	sd	a3,24(s0)
     b06:	f018                	sd	a4,32(s0)
     b08:	f41c                	sd	a5,40(s0)
     b0a:	03043823          	sd	a6,48(s0)
     b0e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b12:	04040793          	addi	a5,s0,64
     b16:	fcf43823          	sd	a5,-48(s0)
     b1a:	fd043783          	ld	a5,-48(s0)
     b1e:	fc878793          	addi	a5,a5,-56
     b22:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b26:	fe843783          	ld	a5,-24(s0)
     b2a:	863e                	mv	a2,a5
     b2c:	fd843583          	ld	a1,-40(s0)
     b30:	4505                	li	a0,1
     b32:	00000097          	auipc	ra,0x0
     b36:	d04080e7          	jalr	-764(ra) # 836 <vprintf>
}
     b3a:	0001                	nop
     b3c:	70a2                	ld	ra,40(sp)
     b3e:	7402                	ld	s0,32(sp)
     b40:	6165                	addi	sp,sp,112
     b42:	8082                	ret

0000000000000b44 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b44:	7179                	addi	sp,sp,-48
     b46:	f422                	sd	s0,40(sp)
     b48:	1800                	addi	s0,sp,48
     b4a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b4e:	fd843783          	ld	a5,-40(s0)
     b52:	17c1                	addi	a5,a5,-16
     b54:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b58:	00001797          	auipc	a5,0x1
     b5c:	93078793          	addi	a5,a5,-1744 # 1488 <freep>
     b60:	639c                	ld	a5,0(a5)
     b62:	fef43423          	sd	a5,-24(s0)
     b66:	a815                	j	b9a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b68:	fe843783          	ld	a5,-24(s0)
     b6c:	639c                	ld	a5,0(a5)
     b6e:	fe843703          	ld	a4,-24(s0)
     b72:	00f76f63          	bltu	a4,a5,b90 <free+0x4c>
     b76:	fe043703          	ld	a4,-32(s0)
     b7a:	fe843783          	ld	a5,-24(s0)
     b7e:	02e7eb63          	bltu	a5,a4,bb4 <free+0x70>
     b82:	fe843783          	ld	a5,-24(s0)
     b86:	639c                	ld	a5,0(a5)
     b88:	fe043703          	ld	a4,-32(s0)
     b8c:	02f76463          	bltu	a4,a5,bb4 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b90:	fe843783          	ld	a5,-24(s0)
     b94:	639c                	ld	a5,0(a5)
     b96:	fef43423          	sd	a5,-24(s0)
     b9a:	fe043703          	ld	a4,-32(s0)
     b9e:	fe843783          	ld	a5,-24(s0)
     ba2:	fce7f3e3          	bgeu	a5,a4,b68 <free+0x24>
     ba6:	fe843783          	ld	a5,-24(s0)
     baa:	639c                	ld	a5,0(a5)
     bac:	fe043703          	ld	a4,-32(s0)
     bb0:	faf77ce3          	bgeu	a4,a5,b68 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     bb4:	fe043783          	ld	a5,-32(s0)
     bb8:	479c                	lw	a5,8(a5)
     bba:	1782                	slli	a5,a5,0x20
     bbc:	9381                	srli	a5,a5,0x20
     bbe:	0792                	slli	a5,a5,0x4
     bc0:	fe043703          	ld	a4,-32(s0)
     bc4:	973e                	add	a4,a4,a5
     bc6:	fe843783          	ld	a5,-24(s0)
     bca:	639c                	ld	a5,0(a5)
     bcc:	02f71763          	bne	a4,a5,bfa <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     bd0:	fe043783          	ld	a5,-32(s0)
     bd4:	4798                	lw	a4,8(a5)
     bd6:	fe843783          	ld	a5,-24(s0)
     bda:	639c                	ld	a5,0(a5)
     bdc:	479c                	lw	a5,8(a5)
     bde:	9fb9                	addw	a5,a5,a4
     be0:	0007871b          	sext.w	a4,a5
     be4:	fe043783          	ld	a5,-32(s0)
     be8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     bea:	fe843783          	ld	a5,-24(s0)
     bee:	639c                	ld	a5,0(a5)
     bf0:	6398                	ld	a4,0(a5)
     bf2:	fe043783          	ld	a5,-32(s0)
     bf6:	e398                	sd	a4,0(a5)
     bf8:	a039                	j	c06 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     bfa:	fe843783          	ld	a5,-24(s0)
     bfe:	6398                	ld	a4,0(a5)
     c00:	fe043783          	ld	a5,-32(s0)
     c04:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c06:	fe843783          	ld	a5,-24(s0)
     c0a:	479c                	lw	a5,8(a5)
     c0c:	1782                	slli	a5,a5,0x20
     c0e:	9381                	srli	a5,a5,0x20
     c10:	0792                	slli	a5,a5,0x4
     c12:	fe843703          	ld	a4,-24(s0)
     c16:	97ba                	add	a5,a5,a4
     c18:	fe043703          	ld	a4,-32(s0)
     c1c:	02f71563          	bne	a4,a5,c46 <free+0x102>
    p->s.size += bp->s.size;
     c20:	fe843783          	ld	a5,-24(s0)
     c24:	4798                	lw	a4,8(a5)
     c26:	fe043783          	ld	a5,-32(s0)
     c2a:	479c                	lw	a5,8(a5)
     c2c:	9fb9                	addw	a5,a5,a4
     c2e:	0007871b          	sext.w	a4,a5
     c32:	fe843783          	ld	a5,-24(s0)
     c36:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c38:	fe043783          	ld	a5,-32(s0)
     c3c:	6398                	ld	a4,0(a5)
     c3e:	fe843783          	ld	a5,-24(s0)
     c42:	e398                	sd	a4,0(a5)
     c44:	a031                	j	c50 <free+0x10c>
  } else
    p->s.ptr = bp;
     c46:	fe843783          	ld	a5,-24(s0)
     c4a:	fe043703          	ld	a4,-32(s0)
     c4e:	e398                	sd	a4,0(a5)
  freep = p;
     c50:	00001797          	auipc	a5,0x1
     c54:	83878793          	addi	a5,a5,-1992 # 1488 <freep>
     c58:	fe843703          	ld	a4,-24(s0)
     c5c:	e398                	sd	a4,0(a5)
}
     c5e:	0001                	nop
     c60:	7422                	ld	s0,40(sp)
     c62:	6145                	addi	sp,sp,48
     c64:	8082                	ret

0000000000000c66 <morecore>:

static Header*
morecore(uint nu)
{
     c66:	7179                	addi	sp,sp,-48
     c68:	f406                	sd	ra,40(sp)
     c6a:	f022                	sd	s0,32(sp)
     c6c:	1800                	addi	s0,sp,48
     c6e:	87aa                	mv	a5,a0
     c70:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c74:	fdc42783          	lw	a5,-36(s0)
     c78:	0007871b          	sext.w	a4,a5
     c7c:	6785                	lui	a5,0x1
     c7e:	00f77563          	bgeu	a4,a5,c88 <morecore+0x22>
    nu = 4096;
     c82:	6785                	lui	a5,0x1
     c84:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c88:	fdc42783          	lw	a5,-36(s0)
     c8c:	0047979b          	slliw	a5,a5,0x4
     c90:	2781                	sext.w	a5,a5
     c92:	2781                	sext.w	a5,a5
     c94:	853e                	mv	a0,a5
     c96:	00000097          	auipc	ra,0x0
     c9a:	9a0080e7          	jalr	-1632(ra) # 636 <sbrk>
     c9e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     ca2:	fe843703          	ld	a4,-24(s0)
     ca6:	57fd                	li	a5,-1
     ca8:	00f71463          	bne	a4,a5,cb0 <morecore+0x4a>
    return 0;
     cac:	4781                	li	a5,0
     cae:	a03d                	j	cdc <morecore+0x76>
  hp = (Header*)p;
     cb0:	fe843783          	ld	a5,-24(s0)
     cb4:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     cb8:	fe043783          	ld	a5,-32(s0)
     cbc:	fdc42703          	lw	a4,-36(s0)
     cc0:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     cc2:	fe043783          	ld	a5,-32(s0)
     cc6:	07c1                	addi	a5,a5,16
     cc8:	853e                	mv	a0,a5
     cca:	00000097          	auipc	ra,0x0
     cce:	e7a080e7          	jalr	-390(ra) # b44 <free>
  return freep;
     cd2:	00000797          	auipc	a5,0x0
     cd6:	7b678793          	addi	a5,a5,1974 # 1488 <freep>
     cda:	639c                	ld	a5,0(a5)
}
     cdc:	853e                	mv	a0,a5
     cde:	70a2                	ld	ra,40(sp)
     ce0:	7402                	ld	s0,32(sp)
     ce2:	6145                	addi	sp,sp,48
     ce4:	8082                	ret

0000000000000ce6 <malloc>:

void*
malloc(uint nbytes)
{
     ce6:	7139                	addi	sp,sp,-64
     ce8:	fc06                	sd	ra,56(sp)
     cea:	f822                	sd	s0,48(sp)
     cec:	0080                	addi	s0,sp,64
     cee:	87aa                	mv	a5,a0
     cf0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     cf4:	fcc46783          	lwu	a5,-52(s0)
     cf8:	07bd                	addi	a5,a5,15
     cfa:	8391                	srli	a5,a5,0x4
     cfc:	2781                	sext.w	a5,a5
     cfe:	2785                	addiw	a5,a5,1
     d00:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d04:	00000797          	auipc	a5,0x0
     d08:	78478793          	addi	a5,a5,1924 # 1488 <freep>
     d0c:	639c                	ld	a5,0(a5)
     d0e:	fef43023          	sd	a5,-32(s0)
     d12:	fe043783          	ld	a5,-32(s0)
     d16:	ef95                	bnez	a5,d52 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d18:	00000797          	auipc	a5,0x0
     d1c:	76078793          	addi	a5,a5,1888 # 1478 <base>
     d20:	fef43023          	sd	a5,-32(s0)
     d24:	00000797          	auipc	a5,0x0
     d28:	76478793          	addi	a5,a5,1892 # 1488 <freep>
     d2c:	fe043703          	ld	a4,-32(s0)
     d30:	e398                	sd	a4,0(a5)
     d32:	00000797          	auipc	a5,0x0
     d36:	75678793          	addi	a5,a5,1878 # 1488 <freep>
     d3a:	6398                	ld	a4,0(a5)
     d3c:	00000797          	auipc	a5,0x0
     d40:	73c78793          	addi	a5,a5,1852 # 1478 <base>
     d44:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d46:	00000797          	auipc	a5,0x0
     d4a:	73278793          	addi	a5,a5,1842 # 1478 <base>
     d4e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d52:	fe043783          	ld	a5,-32(s0)
     d56:	639c                	ld	a5,0(a5)
     d58:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	4798                	lw	a4,8(a5)
     d62:	fdc42783          	lw	a5,-36(s0)
     d66:	2781                	sext.w	a5,a5
     d68:	06f76863          	bltu	a4,a5,dd8 <malloc+0xf2>
      if(p->s.size == nunits)
     d6c:	fe843783          	ld	a5,-24(s0)
     d70:	4798                	lw	a4,8(a5)
     d72:	fdc42783          	lw	a5,-36(s0)
     d76:	2781                	sext.w	a5,a5
     d78:	00e79963          	bne	a5,a4,d8a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d7c:	fe843783          	ld	a5,-24(s0)
     d80:	6398                	ld	a4,0(a5)
     d82:	fe043783          	ld	a5,-32(s0)
     d86:	e398                	sd	a4,0(a5)
     d88:	a82d                	j	dc2 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d8a:	fe843783          	ld	a5,-24(s0)
     d8e:	4798                	lw	a4,8(a5)
     d90:	fdc42783          	lw	a5,-36(s0)
     d94:	40f707bb          	subw	a5,a4,a5
     d98:	0007871b          	sext.w	a4,a5
     d9c:	fe843783          	ld	a5,-24(s0)
     da0:	c798                	sw	a4,8(a5)
        p += p->s.size;
     da2:	fe843783          	ld	a5,-24(s0)
     da6:	479c                	lw	a5,8(a5)
     da8:	1782                	slli	a5,a5,0x20
     daa:	9381                	srli	a5,a5,0x20
     dac:	0792                	slli	a5,a5,0x4
     dae:	fe843703          	ld	a4,-24(s0)
     db2:	97ba                	add	a5,a5,a4
     db4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     db8:	fe843783          	ld	a5,-24(s0)
     dbc:	fdc42703          	lw	a4,-36(s0)
     dc0:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     dc2:	00000797          	auipc	a5,0x0
     dc6:	6c678793          	addi	a5,a5,1734 # 1488 <freep>
     dca:	fe043703          	ld	a4,-32(s0)
     dce:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     dd0:	fe843783          	ld	a5,-24(s0)
     dd4:	07c1                	addi	a5,a5,16
     dd6:	a091                	j	e1a <malloc+0x134>
    }
    if(p == freep)
     dd8:	00000797          	auipc	a5,0x0
     ddc:	6b078793          	addi	a5,a5,1712 # 1488 <freep>
     de0:	639c                	ld	a5,0(a5)
     de2:	fe843703          	ld	a4,-24(s0)
     de6:	02f71063          	bne	a4,a5,e06 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     dea:	fdc42783          	lw	a5,-36(s0)
     dee:	853e                	mv	a0,a5
     df0:	00000097          	auipc	ra,0x0
     df4:	e76080e7          	jalr	-394(ra) # c66 <morecore>
     df8:	fea43423          	sd	a0,-24(s0)
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	e399                	bnez	a5,e06 <malloc+0x120>
        return 0;
     e02:	4781                	li	a5,0
     e04:	a819                	j	e1a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	fef43023          	sd	a5,-32(s0)
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	639c                	ld	a5,0(a5)
     e14:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e18:	b791                	j	d5c <malloc+0x76>
  }
}
     e1a:	853e                	mv	a0,a5
     e1c:	70e2                	ld	ra,56(sp)
     e1e:	7442                	ld	s0,48(sp)
     e20:	6121                	addi	sp,sp,64
     e22:	8082                	ret

0000000000000e24 <setjmp>:
     e24:	e100                	sd	s0,0(a0)
     e26:	e504                	sd	s1,8(a0)
     e28:	01253823          	sd	s2,16(a0)
     e2c:	01353c23          	sd	s3,24(a0)
     e30:	03453023          	sd	s4,32(a0)
     e34:	03553423          	sd	s5,40(a0)
     e38:	03653823          	sd	s6,48(a0)
     e3c:	03753c23          	sd	s7,56(a0)
     e40:	05853023          	sd	s8,64(a0)
     e44:	05953423          	sd	s9,72(a0)
     e48:	05a53823          	sd	s10,80(a0)
     e4c:	05b53c23          	sd	s11,88(a0)
     e50:	06153023          	sd	ra,96(a0)
     e54:	06253423          	sd	sp,104(a0)
     e58:	4501                	li	a0,0
     e5a:	8082                	ret

0000000000000e5c <longjmp>:
     e5c:	6100                	ld	s0,0(a0)
     e5e:	6504                	ld	s1,8(a0)
     e60:	01053903          	ld	s2,16(a0)
     e64:	01853983          	ld	s3,24(a0)
     e68:	02053a03          	ld	s4,32(a0)
     e6c:	02853a83          	ld	s5,40(a0)
     e70:	03053b03          	ld	s6,48(a0)
     e74:	03853b83          	ld	s7,56(a0)
     e78:	04053c03          	ld	s8,64(a0)
     e7c:	04853c83          	ld	s9,72(a0)
     e80:	05053d03          	ld	s10,80(a0)
     e84:	05853d83          	ld	s11,88(a0)
     e88:	06053083          	ld	ra,96(a0)
     e8c:	06853103          	ld	sp,104(a0)
     e90:	c199                	beqz	a1,e96 <longjmp_1>
     e92:	852e                	mv	a0,a1
     e94:	8082                	ret

0000000000000e96 <longjmp_1>:
     e96:	4505                	li	a0,1
     e98:	8082                	ret

0000000000000e9a <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
     e9a:	7139                	addi	sp,sp,-64
     e9c:	fc22                	sd	s0,56(sp)
     e9e:	0080                	addi	s0,sp,64
     ea0:	fca43423          	sd	a0,-56(s0)
     ea4:	87ae                	mv	a5,a1
     ea6:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
     eaa:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
     eae:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     eb2:	fc843783          	ld	a5,-56(s0)
     eb6:	639c                	ld	a5,0(a5)
     eb8:	fcf43c23          	sd	a5,-40(s0)
     ebc:	fd843783          	ld	a5,-40(s0)
     ec0:	fd878793          	addi	a5,a5,-40
     ec4:	fef43423          	sd	a5,-24(s0)
     ec8:	a881                	j	f18 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
     eca:	fe843783          	ld	a5,-24(s0)
     ece:	4fb8                	lw	a4,88(a5)
     ed0:	fc442783          	lw	a5,-60(s0)
     ed4:	2781                	sext.w	a5,a5
     ed6:	02e7c663          	blt	a5,a4,f02 <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
     eda:	fe043783          	ld	a5,-32(s0)
     ede:	e791                	bnez	a5,eea <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
     ee0:	fe843783          	ld	a5,-24(s0)
     ee4:	fef43023          	sd	a5,-32(s0)
     ee8:	a829                	j	f02 <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
     eea:	fe843783          	ld	a5,-24(s0)
     eee:	5fd8                	lw	a4,60(a5)
     ef0:	fe043783          	ld	a5,-32(s0)
     ef4:	5fdc                	lw	a5,60(a5)
     ef6:	00f75663          	bge	a4,a5,f02 <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
     efa:	fe843783          	ld	a5,-24(s0)
     efe:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
     f02:	fe843783          	ld	a5,-24(s0)
     f06:	779c                	ld	a5,40(a5)
     f08:	fcf43823          	sd	a5,-48(s0)
     f0c:	fd043783          	ld	a5,-48(s0)
     f10:	fd878793          	addi	a5,a5,-40
     f14:	fef43423          	sd	a5,-24(s0)
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	02878793          	addi	a5,a5,40
     f20:	fc843703          	ld	a4,-56(s0)
     f24:	faf713e3          	bne	a4,a5,eca <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
     f28:	fe043783          	ld	a5,-32(s0)
}
     f2c:	853e                	mv	a0,a5
     f2e:	7462                	ld	s0,56(sp)
     f30:	6121                	addi	sp,sp,64
     f32:	8082                	ret

0000000000000f34 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
     f34:	1101                	addi	sp,sp,-32
     f36:	ec22                	sd	s0,24(sp)
     f38:	1000                	addi	s0,sp,32
     f3a:	fea43423          	sd	a0,-24(s0)
     f3e:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
     f42:	fe843783          	ld	a5,-24(s0)
     f46:	57fc                	lw	a5,108(a5)
     f48:	c799                	beqz	a5,f56 <__edf_thread_cmp+0x22>
     f4a:	fe043783          	ld	a5,-32(s0)
     f4e:	57fc                	lw	a5,108(a5)
     f50:	e399                	bnez	a5,f56 <__edf_thread_cmp+0x22>
     f52:	57fd                	li	a5,-1
     f54:	a0a5                	j	fbc <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
     f56:	fe843783          	ld	a5,-24(s0)
     f5a:	57fc                	lw	a5,108(a5)
     f5c:	e799                	bnez	a5,f6a <__edf_thread_cmp+0x36>
     f5e:	fe043783          	ld	a5,-32(s0)
     f62:	57fc                	lw	a5,108(a5)
     f64:	c399                	beqz	a5,f6a <__edf_thread_cmp+0x36>
     f66:	4785                	li	a5,1
     f68:	a891                	j	fbc <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
     f6a:	fe843783          	ld	a5,-24(s0)
     f6e:	4fb8                	lw	a4,88(a5)
     f70:	fe043783          	ld	a5,-32(s0)
     f74:	4fbc                	lw	a5,88(a5)
     f76:	00f75463          	bge	a4,a5,f7e <__edf_thread_cmp+0x4a>
     f7a:	57fd                	li	a5,-1
     f7c:	a081                	j	fbc <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
     f7e:	fe843783          	ld	a5,-24(s0)
     f82:	4fb8                	lw	a4,88(a5)
     f84:	fe043783          	ld	a5,-32(s0)
     f88:	4fbc                	lw	a5,88(a5)
     f8a:	00e7d463          	bge	a5,a4,f92 <__edf_thread_cmp+0x5e>
     f8e:	4785                	li	a5,1
     f90:	a035                	j	fbc <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
     f92:	fe843783          	ld	a5,-24(s0)
     f96:	5fd8                	lw	a4,60(a5)
     f98:	fe043783          	ld	a5,-32(s0)
     f9c:	5fdc                	lw	a5,60(a5)
     f9e:	00f75463          	bge	a4,a5,fa6 <__edf_thread_cmp+0x72>
     fa2:	57fd                	li	a5,-1
     fa4:	a821                	j	fbc <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
     fa6:	fe843783          	ld	a5,-24(s0)
     faa:	5fd8                	lw	a4,60(a5)
     fac:	fe043783          	ld	a5,-32(s0)
     fb0:	5fdc                	lw	a5,60(a5)
     fb2:	00e7d463          	bge	a5,a4,fba <__edf_thread_cmp+0x86>
     fb6:	4785                	li	a5,1
     fb8:	a011                	j	fbc <__edf_thread_cmp+0x88>
    
    return 0;
     fba:	4781                	li	a5,0
}
     fbc:	853e                	mv	a0,a5
     fbe:	6462                	ld	s0,24(sp)
     fc0:	6105                	addi	sp,sp,32
     fc2:	8082                	ret

0000000000000fc4 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
     fc4:	7151                	addi	sp,sp,-240
     fc6:	f586                	sd	ra,232(sp)
     fc8:	f1a2                	sd	s0,224(sp)
     fca:	eda6                	sd	s1,216(sp)
     fcc:	e9ca                	sd	s2,208(sp)
     fce:	e5ce                	sd	s3,200(sp)
     fd0:	1980                	addi	s0,sp,240
     fd2:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
     fd4:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
     fd8:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
     fdc:	649c                	ld	a5,8(s1)
     fde:	639c                	ld	a5,0(a5)
     fe0:	f8f43c23          	sd	a5,-104(s0)
     fe4:	f9843783          	ld	a5,-104(s0)
     fe8:	fd878793          	addi	a5,a5,-40
     fec:	fcf43423          	sd	a5,-56(s0)
     ff0:	a8b1                	j	104c <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
     ff2:	fc843783          	ld	a5,-56(s0)
     ff6:	57bc                	lw	a5,104(a5)
     ff8:	02f04f63          	bgtz	a5,1036 <schedule_edf_cbs+0x72>
     ffc:	fc843783          	ld	a5,-56(s0)
    1000:	4bfc                	lw	a5,84(a5)
    1002:	02f05a63          	blez	a5,1036 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
    1006:	4098                	lw	a4,0(s1)
    1008:	fc843783          	ld	a5,-56(s0)
    100c:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    100e:	02f71463          	bne	a4,a5,1036 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
    1012:	fc843783          	ld	a5,-56(s0)
    1016:	4fb8                	lw	a4,88(a5)
    1018:	fc843783          	ld	a5,-56(s0)
    101c:	47fc                	lw	a5,76(a5)
    101e:	9fb9                	addw	a5,a5,a4
    1020:	0007871b          	sext.w	a4,a5
    1024:	fc843783          	ld	a5,-56(s0)
    1028:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
    102a:	fc843783          	ld	a5,-56(s0)
    102e:	53f8                	lw	a4,100(a5)
    1030:	fc843783          	ld	a5,-56(s0)
    1034:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1036:	fc843783          	ld	a5,-56(s0)
    103a:	779c                	ld	a5,40(a5)
    103c:	f2f43823          	sd	a5,-208(s0)
    1040:	f3043783          	ld	a5,-208(s0)
    1044:	fd878793          	addi	a5,a5,-40
    1048:	fcf43423          	sd	a5,-56(s0)
    104c:	fc843783          	ld	a5,-56(s0)
    1050:	02878713          	addi	a4,a5,40
    1054:	649c                	ld	a5,8(s1)
    1056:	f8f71ee3          	bne	a4,a5,ff2 <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    105a:	649c                	ld	a5,8(s1)
    105c:	4098                	lw	a4,0(s1)
    105e:	85ba                	mv	a1,a4
    1060:	853e                	mv	a0,a5
    1062:	00000097          	auipc	ra,0x0
    1066:	e38080e7          	jalr	-456(ra) # e9a <__check_deadline_miss>
    106a:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
    106e:	f9043783          	ld	a5,-112(s0)
    1072:	c395                	beqz	a5,1096 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
    1074:	f9043783          	ld	a5,-112(s0)
    1078:	02878793          	addi	a5,a5,40
    107c:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
    1080:	f0042c23          	sw	zero,-232(s0)
        return r;
    1084:	f1043783          	ld	a5,-240(s0)
    1088:	f2f43023          	sd	a5,-224(s0)
    108c:	f1843783          	ld	a5,-232(s0)
    1090:	f2f43423          	sd	a5,-216(s0)
    1094:	ae19                	j	13aa <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
    1096:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    109a:	649c                	ld	a5,8(s1)
    109c:	639c                	ld	a5,0(a5)
    109e:	f8f43423          	sd	a5,-120(s0)
    10a2:	f8843783          	ld	a5,-120(s0)
    10a6:	fd878793          	addi	a5,a5,-40
    10aa:	fcf43423          	sd	a5,-56(s0)
    10ae:	a0ad                	j	1118 <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
    10b0:	fc843783          	ld	a5,-56(s0)
    10b4:	4bfc                	lw	a5,84(a5)
    10b6:	04f05563          	blez	a5,1100 <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    10ba:	fc843783          	ld	a5,-56(s0)
    10be:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
    10c0:	00f04d63          	bgtz	a5,10da <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    10c4:	fc843783          	ld	a5,-56(s0)
    10c8:	4bfc                	lw	a5,84(a5)
    10ca:	00f05863          	blez	a5,10da <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
    10ce:	4098                	lw	a4,0(s1)
    10d0:	fc843783          	ld	a5,-56(s0)
    10d4:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    10d6:	02f74563          	blt	a4,a5,1100 <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
    10da:	fc043783          	ld	a5,-64(s0)
    10de:	cf81                	beqz	a5,10f6 <schedule_edf_cbs+0x132>
    10e0:	fc043583          	ld	a1,-64(s0)
    10e4:	fc843503          	ld	a0,-56(s0)
    10e8:	00000097          	auipc	ra,0x0
    10ec:	e4c080e7          	jalr	-436(ra) # f34 <__edf_thread_cmp>
    10f0:	87aa                	mv	a5,a0
    10f2:	0007d863          	bgez	a5,1102 <schedule_edf_cbs+0x13e>
            selected = t;
    10f6:	fc843783          	ld	a5,-56(s0)
    10fa:	fcf43023          	sd	a5,-64(s0)
    10fe:	a011                	j	1102 <schedule_edf_cbs+0x13e>
            continue;
    1100:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
    1102:	fc843783          	ld	a5,-56(s0)
    1106:	779c                	ld	a5,40(a5)
    1108:	f2f43c23          	sd	a5,-200(s0)
    110c:	f3843783          	ld	a5,-200(s0)
    1110:	fd878793          	addi	a5,a5,-40
    1114:	fcf43423          	sd	a5,-56(s0)
    1118:	fc843783          	ld	a5,-56(s0)
    111c:	02878713          	addi	a4,a5,40
    1120:	649c                	ld	a5,8(s1)
    1122:	f8f717e3          	bne	a4,a5,10b0 <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    1126:	fc043783          	ld	a5,-64(s0)
    112a:	ebd5                	bnez	a5,11de <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    112c:	800007b7          	lui	a5,0x80000
    1130:	fff7c793          	not	a5,a5
    1134:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    1138:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    113c:	689c                	ld	a5,16(s1)
    113e:	639c                	ld	a5,0(a5)
    1140:	f4f43423          	sd	a5,-184(s0)
    1144:	f4843783          	ld	a5,-184(s0)
    1148:	17e1                	addi	a5,a5,-8
    114a:	faf43823          	sd	a5,-80(s0)
    114e:	a835                	j	118a <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    1150:	fb043783          	ld	a5,-80(s0)
    1154:	4f98                	lw	a4,24(a5)
    1156:	409c                	lw	a5,0(s1)
    1158:	00e7df63          	bge	a5,a4,1176 <schedule_edf_cbs+0x1b2>
    115c:	fb043783          	ld	a5,-80(s0)
    1160:	4f98                	lw	a4,24(a5)
    1162:	fbc42783          	lw	a5,-68(s0)
    1166:	2781                	sext.w	a5,a5
    1168:	00f75763          	bge	a4,a5,1176 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    116c:	fb043783          	ld	a5,-80(s0)
    1170:	4f9c                	lw	a5,24(a5)
    1172:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1176:	fb043783          	ld	a5,-80(s0)
    117a:	679c                	ld	a5,8(a5)
    117c:	f4f43023          	sd	a5,-192(s0)
    1180:	f4043783          	ld	a5,-192(s0)
    1184:	17e1                	addi	a5,a5,-8
    1186:	faf43823          	sd	a5,-80(s0)
    118a:	fb043783          	ld	a5,-80(s0)
    118e:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffe3b8>
    1192:	689c                	ld	a5,16(s1)
    1194:	faf71ee3          	bne	a4,a5,1150 <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    1198:	fbc42783          	lw	a5,-68(s0)
    119c:	0007871b          	sext.w	a4,a5
    11a0:	800007b7          	lui	a5,0x80000
    11a4:	fff7c793          	not	a5,a5
    11a8:	00f70e63          	beq	a4,a5,11c4 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    11ac:	649c                	ld	a5,8(s1)
    11ae:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    11b2:	409c                	lw	a5,0(s1)
    11b4:	fbc42703          	lw	a4,-68(s0)
    11b8:	40f707bb          	subw	a5,a4,a5
    11bc:	2781                	sext.w	a5,a5
    11be:	f0f42c23          	sw	a5,-232(s0)
    11c2:	a029                	j	11cc <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    11c4:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    11c8:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    11cc:	f1043783          	ld	a5,-240(s0)
    11d0:	f2f43023          	sd	a5,-224(s0)
    11d4:	f1843783          	ld	a5,-232(s0)
    11d8:	f2f43423          	sd	a5,-216(s0)
    11dc:	a2f9                	j	13aa <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    11de:	fc043783          	ld	a5,-64(s0)
    11e2:	57fc                	lw	a5,108(a5)
    11e4:	e7f1                	bnez	a5,12b0 <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    11e6:	fc043783          	ld	a5,-64(s0)
    11ea:	57bc                	lw	a5,104(a5)
    11ec:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    11f0:	fc043783          	ld	a5,-64(s0)
    11f4:	4fb8                	lw	a4,88(a5)
    11f6:	409c                	lw	a5,0(s1)
    11f8:	40f707bb          	subw	a5,a4,a5
    11fc:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    1200:	fc043783          	ld	a5,-64(s0)
    1204:	47fc                	lw	a5,76(a5)
    1206:	f5c42703          	lw	a4,-164(s0)
    120a:	02f707bb          	mulw	a5,a4,a5
    120e:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    1212:	fc043783          	ld	a5,-64(s0)
    1216:	53fc                	lw	a5,100(a5)
    1218:	f5842703          	lw	a4,-168(s0)
    121c:	02f707bb          	mulw	a5,a4,a5
    1220:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    1224:	f5442703          	lw	a4,-172(s0)
    1228:	f5042783          	lw	a5,-176(s0)
    122c:	2701                	sext.w	a4,a4
    122e:	2781                	sext.w	a5,a5
    1230:	02e7d363          	bge	a5,a4,1256 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    1234:	4098                	lw	a4,0(s1)
    1236:	fc043783          	ld	a5,-64(s0)
    123a:	47fc                	lw	a5,76(a5)
    123c:	9fb9                	addw	a5,a5,a4
    123e:	0007871b          	sext.w	a4,a5
    1242:	fc043783          	ld	a5,-64(s0)
    1246:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    1248:	fc043783          	ld	a5,-64(s0)
    124c:	53f8                	lw	a4,100(a5)
    124e:	fc043783          	ld	a5,-64(s0)
    1252:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    1254:	b341                	j	fd4 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    1256:	fc043783          	ld	a5,-64(s0)
    125a:	57bc                	lw	a5,104(a5)
    125c:	02f04063          	bgtz	a5,127c <schedule_edf_cbs+0x2b8>
    1260:	fc043783          	ld	a5,-64(s0)
    1264:	4bfc                	lw	a5,84(a5)
    1266:	00f05b63          	blez	a5,127c <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    126a:	fc043783          	ld	a5,-64(s0)
    126e:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe3d8>
    1272:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    1276:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    127a:	bba9                	j	fd4 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    127c:	fc043783          	ld	a5,-64(s0)
    1280:	02878793          	addi	a5,a5,40
    1284:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1288:	fc043783          	ld	a5,-64(s0)
    128c:	57b8                	lw	a4,104(a5)
    128e:	fc043783          	ld	a5,-64(s0)
    1292:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    1294:	863e                	mv	a2,a5
    1296:	86ba                	mv	a3,a4
    1298:	0006871b          	sext.w	a4,a3
    129c:	0006079b          	sext.w	a5,a2
    12a0:	00e7d363          	bge	a5,a4,12a6 <schedule_edf_cbs+0x2e2>
    12a4:	86b2                	mv	a3,a2
    12a6:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    12aa:	f0f42c23          	sw	a5,-232(s0)
    12ae:	a0f5                	j	139a <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    12b0:	fc043783          	ld	a5,-64(s0)
    12b4:	4bfc                	lw	a5,84(a5)
    12b6:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    12ba:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    12be:	689c                	ld	a5,16(s1)
    12c0:	639c                	ld	a5,0(a5)
    12c2:	f8f43023          	sd	a5,-128(s0)
    12c6:	f8043783          	ld	a5,-128(s0)
    12ca:	17e1                	addi	a5,a5,-8
    12cc:	faf43023          	sd	a5,-96(s0)
    12d0:	a041                	j	1350 <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    12d2:	fa043783          	ld	a5,-96(s0)
    12d6:	639c                	ld	a5,0(a5)
    12d8:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    12dc:	f7043783          	ld	a5,-144(s0)
    12e0:	53b8                	lw	a4,96(a5)
    12e2:	409c                	lw	a5,0(s1)
    12e4:	04e7dc63          	bge	a5,a4,133c <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    12e8:	f7043783          	ld	a5,-144(s0)
    12ec:	53b4                	lw	a3,96(a5)
    12ee:	409c                	lw	a5,0(s1)
    12f0:	fac42703          	lw	a4,-84(s0)
    12f4:	9fb9                	addw	a5,a5,a4
    12f6:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    12f8:	8736                	mv	a4,a3
    12fa:	04f75163          	bge	a4,a5,133c <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    12fe:	fc043583          	ld	a1,-64(s0)
    1302:	f7043503          	ld	a0,-144(s0)
    1306:	00000097          	auipc	ra,0x0
    130a:	c2e080e7          	jalr	-978(ra) # f34 <__edf_thread_cmp>
    130e:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    1310:	0207d663          	bgez	a5,133c <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    1314:	f7043783          	ld	a5,-144(s0)
    1318:	53b8                	lw	a4,96(a5)
    131a:	409c                	lw	a5,0(s1)
    131c:	40f707bb          	subw	a5,a4,a5
    1320:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    1324:	f6c42703          	lw	a4,-148(s0)
    1328:	fac42783          	lw	a5,-84(s0)
    132c:	2701                	sext.w	a4,a4
    132e:	2781                	sext.w	a5,a5
    1330:	00f75663          	bge	a4,a5,133c <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    1334:	f6c42783          	lw	a5,-148(s0)
    1338:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    133c:	fa043783          	ld	a5,-96(s0)
    1340:	679c                	ld	a5,8(a5)
    1342:	f6f43023          	sd	a5,-160(s0)
    1346:	f6043783          	ld	a5,-160(s0)
    134a:	17e1                	addi	a5,a5,-8
    134c:	faf43023          	sd	a5,-96(s0)
    1350:	fa043783          	ld	a5,-96(s0)
    1354:	00878713          	addi	a4,a5,8
    1358:	689c                	ld	a5,16(s1)
    135a:	f6f71ce3          	bne	a4,a5,12d2 <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    135e:	fc043783          	ld	a5,-64(s0)
    1362:	4fb8                	lw	a4,88(a5)
    1364:	409c                	lw	a5,0(s1)
    1366:	40f707bb          	subw	a5,a4,a5
    136a:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    136e:	f7c42703          	lw	a4,-132(s0)
    1372:	fac42783          	lw	a5,-84(s0)
    1376:	2701                	sext.w	a4,a4
    1378:	2781                	sext.w	a5,a5
    137a:	00f75663          	bge	a4,a5,1386 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    137e:	f7c42783          	lw	a5,-132(s0)
    1382:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    1386:	fc043783          	ld	a5,-64(s0)
    138a:	02878793          	addi	a5,a5,40
    138e:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    1392:	fac42783          	lw	a5,-84(s0)
    1396:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    139a:	f1043783          	ld	a5,-240(s0)
    139e:	f2f43023          	sd	a5,-224(s0)
    13a2:	f1843783          	ld	a5,-232(s0)
    13a6:	f2f43423          	sd	a5,-216(s0)
    13aa:	4701                	li	a4,0
    13ac:	f2043703          	ld	a4,-224(s0)
    13b0:	4781                	li	a5,0
    13b2:	f2843783          	ld	a5,-216(s0)
    13b6:	893a                	mv	s2,a4
    13b8:	89be                	mv	s3,a5
    13ba:	874a                	mv	a4,s2
    13bc:	87ce                	mv	a5,s3
}
    13be:	853a                	mv	a0,a4
    13c0:	85be                	mv	a1,a5
    13c2:	70ae                	ld	ra,232(sp)
    13c4:	740e                	ld	s0,224(sp)
    13c6:	64ee                	ld	s1,216(sp)
    13c8:	694e                	ld	s2,208(sp)
    13ca:	69ae                	ld	s3,200(sp)
    13cc:	616d                	addi	sp,sp,240
    13ce:	8082                	ret
