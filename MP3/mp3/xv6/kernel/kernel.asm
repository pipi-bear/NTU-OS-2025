
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	8a813103          	ld	sp,-1880(sp) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	170000ef          	jal	ra,80000186 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec22                	sd	s0,24(sp)
    80000020:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002a:	fe843783          	ld	a5,-24(s0)
}
    8000002e:	853e                	mv	a0,a5
    80000030:	6462                	ld	s0,24(sp)
    80000032:	6105                	addi	sp,sp,32
    80000034:	8082                	ret

0000000080000036 <r_mstatus>:
#define MSTATUS_MPP_U (0L << 11)
#define MSTATUS_MIE (1L << 3)    // machine-mode interrupt enable.

static inline uint64
r_mstatus()
{
    80000036:	1101                	addi	sp,sp,-32
    80000038:	ec22                	sd	s0,24(sp)
    8000003a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000003c:	300027f3          	csrr	a5,mstatus
    80000040:	fef43423          	sd	a5,-24(s0)
  return x;
    80000044:	fe843783          	ld	a5,-24(s0)
}
    80000048:	853e                	mv	a0,a5
    8000004a:	6462                	ld	s0,24(sp)
    8000004c:	6105                	addi	sp,sp,32
    8000004e:	8082                	ret

0000000080000050 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000050:	1101                	addi	sp,sp,-32
    80000052:	ec22                	sd	s0,24(sp)
    80000054:	1000                	addi	s0,sp,32
    80000056:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000005a:	fe843783          	ld	a5,-24(s0)
    8000005e:	30079073          	csrw	mstatus,a5
}
    80000062:	0001                	nop
    80000064:	6462                	ld	s0,24(sp)
    80000066:	6105                	addi	sp,sp,32
    80000068:	8082                	ret

000000008000006a <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    8000006a:	1101                	addi	sp,sp,-32
    8000006c:	ec22                	sd	s0,24(sp)
    8000006e:	1000                	addi	s0,sp,32
    80000070:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000074:	fe843783          	ld	a5,-24(s0)
    80000078:	34179073          	csrw	mepc,a5
}
    8000007c:	0001                	nop
    8000007e:	6462                	ld	s0,24(sp)
    80000080:	6105                	addi	sp,sp,32
    80000082:	8082                	ret

0000000080000084 <r_sie>:
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
#define SIE_SSIE (1L << 1) // software
static inline uint64
r_sie()
{
    80000084:	1101                	addi	sp,sp,-32
    80000086:	ec22                	sd	s0,24(sp)
    80000088:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000008a:	104027f3          	csrr	a5,sie
    8000008e:	fef43423          	sd	a5,-24(s0)
  return x;
    80000092:	fe843783          	ld	a5,-24(s0)
}
    80000096:	853e                	mv	a0,a5
    80000098:	6462                	ld	s0,24(sp)
    8000009a:	6105                	addi	sp,sp,32
    8000009c:	8082                	ret

000000008000009e <w_sie>:

static inline void 
w_sie(uint64 x)
{
    8000009e:	1101                	addi	sp,sp,-32
    800000a0:	ec22                	sd	s0,24(sp)
    800000a2:	1000                	addi	s0,sp,32
    800000a4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000a8:	fe843783          	ld	a5,-24(s0)
    800000ac:	10479073          	csrw	sie,a5
}
    800000b0:	0001                	nop
    800000b2:	6462                	ld	s0,24(sp)
    800000b4:	6105                	addi	sp,sp,32
    800000b6:	8082                	ret

00000000800000b8 <r_mie>:
#define MIE_MEIE (1L << 11) // external
#define MIE_MTIE (1L << 7)  // timer
#define MIE_MSIE (1L << 3)  // software
static inline uint64
r_mie()
{
    800000b8:	1101                	addi	sp,sp,-32
    800000ba:	ec22                	sd	s0,24(sp)
    800000bc:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000be:	304027f3          	csrr	a5,mie
    800000c2:	fef43423          	sd	a5,-24(s0)
  return x;
    800000c6:	fe843783          	ld	a5,-24(s0)
}
    800000ca:	853e                	mv	a0,a5
    800000cc:	6462                	ld	s0,24(sp)
    800000ce:	6105                	addi	sp,sp,32
    800000d0:	8082                	ret

00000000800000d2 <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000d2:	1101                	addi	sp,sp,-32
    800000d4:	ec22                	sd	s0,24(sp)
    800000d6:	1000                	addi	s0,sp,32
    800000d8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000dc:	fe843783          	ld	a5,-24(s0)
    800000e0:	30479073          	csrw	mie,a5
}
    800000e4:	0001                	nop
    800000e6:	6462                	ld	s0,24(sp)
    800000e8:	6105                	addi	sp,sp,32
    800000ea:	8082                	ret

00000000800000ec <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    800000ec:	1101                	addi	sp,sp,-32
    800000ee:	ec22                	sd	s0,24(sp)
    800000f0:	1000                	addi	s0,sp,32
    800000f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000f6:	fe843783          	ld	a5,-24(s0)
    800000fa:	30279073          	csrw	medeleg,a5
}
    800000fe:	0001                	nop
    80000100:	6462                	ld	s0,24(sp)
    80000102:	6105                	addi	sp,sp,32
    80000104:	8082                	ret

0000000080000106 <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    80000106:	1101                	addi	sp,sp,-32
    80000108:	ec22                	sd	s0,24(sp)
    8000010a:	1000                	addi	s0,sp,32
    8000010c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000110:	fe843783          	ld	a5,-24(s0)
    80000114:	30379073          	csrw	mideleg,a5
}
    80000118:	0001                	nop
    8000011a:	6462                	ld	s0,24(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret

0000000080000120 <w_mtvec>:
}

// Machine-mode interrupt vector
static inline void 
w_mtvec(uint64 x)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec22                	sd	s0,24(sp)
    80000124:	1000                	addi	s0,sp,32
    80000126:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	30579073          	csrw	mtvec,a5
}
    80000132:	0001                	nop
    80000134:	6462                	ld	s0,24(sp)
    80000136:	6105                	addi	sp,sp,32
    80000138:	8082                	ret

000000008000013a <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    8000013a:	1101                	addi	sp,sp,-32
    8000013c:	ec22                	sd	s0,24(sp)
    8000013e:	1000                	addi	s0,sp,32
    80000140:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80000144:	fe843783          	ld	a5,-24(s0)
    80000148:	18079073          	csrw	satp,a5
}
    8000014c:	0001                	nop
    8000014e:	6462                	ld	s0,24(sp)
    80000150:	6105                	addi	sp,sp,32
    80000152:	8082                	ret

0000000080000154 <w_mscratch>:
  asm volatile("csrw sscratch, %0" : : "r" (x));
}

static inline void 
w_mscratch(uint64 x)
{
    80000154:	1101                	addi	sp,sp,-32
    80000156:	ec22                	sd	s0,24(sp)
    80000158:	1000                	addi	s0,sp,32
    8000015a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000015e:	fe843783          	ld	a5,-24(s0)
    80000162:	34079073          	csrw	mscratch,a5
}
    80000166:	0001                	nop
    80000168:	6462                	ld	s0,24(sp)
    8000016a:	6105                	addi	sp,sp,32
    8000016c:	8082                	ret

000000008000016e <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    8000016e:	1101                	addi	sp,sp,-32
    80000170:	ec22                	sd	s0,24(sp)
    80000172:	1000                	addi	s0,sp,32
    80000174:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    80000178:	fe843783          	ld	a5,-24(s0)
    8000017c:	823e                	mv	tp,a5
}
    8000017e:	0001                	nop
    80000180:	6462                	ld	s0,24(sp)
    80000182:	6105                	addi	sp,sp,32
    80000184:	8082                	ret

0000000080000186 <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    80000186:	1101                	addi	sp,sp,-32
    80000188:	ec06                	sd	ra,24(sp)
    8000018a:	e822                	sd	s0,16(sp)
    8000018c:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    8000018e:	00000097          	auipc	ra,0x0
    80000192:	ea8080e7          	jalr	-344(ra) # 80000036 <r_mstatus>
    80000196:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    8000019a:	fe843703          	ld	a4,-24(s0)
    8000019e:	77f9                	lui	a5,0xffffe
    800001a0:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ff8c7ff>
    800001a4:	8ff9                	and	a5,a5,a4
    800001a6:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    800001aa:	fe843703          	ld	a4,-24(s0)
    800001ae:	6785                	lui	a5,0x1
    800001b0:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    800001b4:	8fd9                	or	a5,a5,a4
    800001b6:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800001ba:	fe843503          	ld	a0,-24(s0)
    800001be:	00000097          	auipc	ra,0x0
    800001c2:	e92080e7          	jalr	-366(ra) # 80000050 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800001c6:	00001797          	auipc	a5,0x1
    800001ca:	63478793          	addi	a5,a5,1588 # 800017fa <main>
    800001ce:	853e                	mv	a0,a5
    800001d0:	00000097          	auipc	ra,0x0
    800001d4:	e9a080e7          	jalr	-358(ra) # 8000006a <w_mepc>

  // disable paging for now.
  w_satp(0);
    800001d8:	4501                	li	a0,0
    800001da:	00000097          	auipc	ra,0x0
    800001de:	f60080e7          	jalr	-160(ra) # 8000013a <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    800001e2:	67c1                	lui	a5,0x10
    800001e4:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800001e8:	00000097          	auipc	ra,0x0
    800001ec:	f04080e7          	jalr	-252(ra) # 800000ec <w_medeleg>
  w_mideleg(0xffff);
    800001f0:	67c1                	lui	a5,0x10
    800001f2:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800001f6:	00000097          	auipc	ra,0x0
    800001fa:	f10080e7          	jalr	-240(ra) # 80000106 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800001fe:	00000097          	auipc	ra,0x0
    80000202:	e86080e7          	jalr	-378(ra) # 80000084 <r_sie>
    80000206:	87aa                	mv	a5,a0
    80000208:	2227e793          	ori	a5,a5,546
    8000020c:	853e                	mv	a0,a5
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	e90080e7          	jalr	-368(ra) # 8000009e <w_sie>

  // ask for clock interrupts.
  timerinit();
    80000216:	00000097          	auipc	ra,0x0
    8000021a:	032080e7          	jalr	50(ra) # 80000248 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    8000021e:	00000097          	auipc	ra,0x0
    80000222:	dfe080e7          	jalr	-514(ra) # 8000001c <r_mhartid>
    80000226:	87aa                	mv	a5,a0
    80000228:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    8000022c:	fe442783          	lw	a5,-28(s0)
    80000230:	853e                	mv	a0,a5
    80000232:	00000097          	auipc	ra,0x0
    80000236:	f3c080e7          	jalr	-196(ra) # 8000016e <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    8000023a:	30200073          	mret
}
    8000023e:	0001                	nop
    80000240:	60e2                	ld	ra,24(sp)
    80000242:	6442                	ld	s0,16(sp)
    80000244:	6105                	addi	sp,sp,32
    80000246:	8082                	ret

0000000080000248 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000248:	1101                	addi	sp,sp,-32
    8000024a:	ec06                	sd	ra,24(sp)
    8000024c:	e822                	sd	s0,16(sp)
    8000024e:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000250:	00000097          	auipc	ra,0x0
    80000254:	dcc080e7          	jalr	-564(ra) # 8000001c <r_mhartid>
    80000258:	87aa                	mv	a5,a0
    8000025a:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
    8000025e:	000f47b7          	lui	a5,0xf4
    80000262:	2407879b          	addiw	a5,a5,576
    80000266:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000026a:	0200c7b7          	lui	a5,0x200c
    8000026e:	17e1                	addi	a5,a5,-8
    80000270:	6398                	ld	a4,0(a5)
    80000272:	fe842783          	lw	a5,-24(s0)
    80000276:	fec42683          	lw	a3,-20(s0)
    8000027a:	0036969b          	slliw	a3,a3,0x3
    8000027e:	2681                	sext.w	a3,a3
    80000280:	8636                	mv	a2,a3
    80000282:	020046b7          	lui	a3,0x2004
    80000286:	96b2                	add	a3,a3,a2
    80000288:	97ba                	add	a5,a5,a4
    8000028a:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    8000028c:	fec42703          	lw	a4,-20(s0)
    80000290:	87ba                	mv	a5,a4
    80000292:	078a                	slli	a5,a5,0x2
    80000294:	97ba                	add	a5,a5,a4
    80000296:	078e                	slli	a5,a5,0x3
    80000298:	00014717          	auipc	a4,0x14
    8000029c:	d9870713          	addi	a4,a4,-616 # 80014030 <timer_scratch>
    800002a0:	97ba                	add	a5,a5,a4
    800002a2:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    800002a6:	fec42783          	lw	a5,-20(s0)
    800002aa:	0037979b          	slliw	a5,a5,0x3
    800002ae:	2781                	sext.w	a5,a5
    800002b0:	873e                	mv	a4,a5
    800002b2:	020047b7          	lui	a5,0x2004
    800002b6:	973e                	add	a4,a4,a5
    800002b8:	fe043783          	ld	a5,-32(s0)
    800002bc:	07e1                	addi	a5,a5,24
    800002be:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    800002c0:	fe043783          	ld	a5,-32(s0)
    800002c4:	02078793          	addi	a5,a5,32 # 2004020 <_entry-0x7dffbfe0>
    800002c8:	fe842703          	lw	a4,-24(s0)
    800002cc:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    800002ce:	fe043783          	ld	a5,-32(s0)
    800002d2:	853e                	mv	a0,a5
    800002d4:	00000097          	auipc	ra,0x0
    800002d8:	e80080e7          	jalr	-384(ra) # 80000154 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    800002dc:	00009797          	auipc	a5,0x9
    800002e0:	98478793          	addi	a5,a5,-1660 # 80008c60 <timervec>
    800002e4:	853e                	mv	a0,a5
    800002e6:	00000097          	auipc	ra,0x0
    800002ea:	e3a080e7          	jalr	-454(ra) # 80000120 <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800002ee:	00000097          	auipc	ra,0x0
    800002f2:	d48080e7          	jalr	-696(ra) # 80000036 <r_mstatus>
    800002f6:	87aa                	mv	a5,a0
    800002f8:	0087e793          	ori	a5,a5,8
    800002fc:	853e                	mv	a0,a5
    800002fe:	00000097          	auipc	ra,0x0
    80000302:	d52080e7          	jalr	-686(ra) # 80000050 <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000306:	00000097          	auipc	ra,0x0
    8000030a:	db2080e7          	jalr	-590(ra) # 800000b8 <r_mie>
    8000030e:	87aa                	mv	a5,a0
    80000310:	0807e793          	ori	a5,a5,128
    80000314:	853e                	mv	a0,a5
    80000316:	00000097          	auipc	ra,0x0
    8000031a:	dbc080e7          	jalr	-580(ra) # 800000d2 <w_mie>
}
    8000031e:	0001                	nop
    80000320:	60e2                	ld	ra,24(sp)
    80000322:	6442                	ld	s0,16(sp)
    80000324:	6105                	addi	sp,sp,32
    80000326:	8082                	ret

0000000080000328 <consputc>:
// called by printf, and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80000328:	1101                	addi	sp,sp,-32
    8000032a:	ec06                	sd	ra,24(sp)
    8000032c:	e822                	sd	s0,16(sp)
    8000032e:	1000                	addi	s0,sp,32
    80000330:	87aa                	mv	a5,a0
    80000332:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000336:	fec42783          	lw	a5,-20(s0)
    8000033a:	0007871b          	sext.w	a4,a5
    8000033e:	10000793          	li	a5,256
    80000342:	02f71363          	bne	a4,a5,80000368 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000346:	4521                	li	a0,8
    80000348:	00001097          	auipc	ra,0x1
    8000034c:	af6080e7          	jalr	-1290(ra) # 80000e3e <uartputc_sync>
    80000350:	02000513          	li	a0,32
    80000354:	00001097          	auipc	ra,0x1
    80000358:	aea080e7          	jalr	-1302(ra) # 80000e3e <uartputc_sync>
    8000035c:	4521                	li	a0,8
    8000035e:	00001097          	auipc	ra,0x1
    80000362:	ae0080e7          	jalr	-1312(ra) # 80000e3e <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    80000366:	a801                	j	80000376 <consputc+0x4e>
    uartputc_sync(c);
    80000368:	fec42783          	lw	a5,-20(s0)
    8000036c:	853e                	mv	a0,a5
    8000036e:	00001097          	auipc	ra,0x1
    80000372:	ad0080e7          	jalr	-1328(ra) # 80000e3e <uartputc_sync>
}
    80000376:	0001                	nop
    80000378:	60e2                	ld	ra,24(sp)
    8000037a:	6442                	ld	s0,16(sp)
    8000037c:	6105                	addi	sp,sp,32
    8000037e:	8082                	ret

0000000080000380 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000380:	7179                	addi	sp,sp,-48
    80000382:	f406                	sd	ra,40(sp)
    80000384:	f022                	sd	s0,32(sp)
    80000386:	1800                	addi	s0,sp,48
    80000388:	87aa                	mv	a5,a0
    8000038a:	fcb43823          	sd	a1,-48(s0)
    8000038e:	8732                	mv	a4,a2
    80000390:	fcf42e23          	sw	a5,-36(s0)
    80000394:	87ba                	mv	a5,a4
    80000396:	fcf42c23          	sw	a5,-40(s0)
  int i;

  acquire(&cons.lock);
    8000039a:	00014517          	auipc	a0,0x14
    8000039e:	dd650513          	addi	a0,a0,-554 # 80014170 <cons>
    800003a2:	00001097          	auipc	ra,0x1
    800003a6:	ede080e7          	jalr	-290(ra) # 80001280 <acquire>
  for(i = 0; i < n; i++){
    800003aa:	fe042623          	sw	zero,-20(s0)
    800003ae:	a0a1                	j	800003f6 <consolewrite+0x76>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003b0:	fec42703          	lw	a4,-20(s0)
    800003b4:	fd043783          	ld	a5,-48(s0)
    800003b8:	00f70633          	add	a2,a4,a5
    800003bc:	fdc42703          	lw	a4,-36(s0)
    800003c0:	feb40793          	addi	a5,s0,-21
    800003c4:	4685                	li	a3,1
    800003c6:	85ba                	mv	a1,a4
    800003c8:	853e                	mv	a0,a5
    800003ca:	00003097          	auipc	ra,0x3
    800003ce:	40e080e7          	jalr	1038(ra) # 800037d8 <either_copyin>
    800003d2:	87aa                	mv	a5,a0
    800003d4:	873e                	mv	a4,a5
    800003d6:	57fd                	li	a5,-1
    800003d8:	02f70863          	beq	a4,a5,80000408 <consolewrite+0x88>
      break;
    uartputc(c);
    800003dc:	feb44783          	lbu	a5,-21(s0)
    800003e0:	2781                	sext.w	a5,a5
    800003e2:	853e                	mv	a0,a5
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	970080e7          	jalr	-1680(ra) # 80000d54 <uartputc>
  for(i = 0; i < n; i++){
    800003ec:	fec42783          	lw	a5,-20(s0)
    800003f0:	2785                	addiw	a5,a5,1
    800003f2:	fef42623          	sw	a5,-20(s0)
    800003f6:	fec42703          	lw	a4,-20(s0)
    800003fa:	fd842783          	lw	a5,-40(s0)
    800003fe:	2701                	sext.w	a4,a4
    80000400:	2781                	sext.w	a5,a5
    80000402:	faf747e3          	blt	a4,a5,800003b0 <consolewrite+0x30>
    80000406:	a011                	j	8000040a <consolewrite+0x8a>
      break;
    80000408:	0001                	nop
  }
  release(&cons.lock);
    8000040a:	00014517          	auipc	a0,0x14
    8000040e:	d6650513          	addi	a0,a0,-666 # 80014170 <cons>
    80000412:	00001097          	auipc	ra,0x1
    80000416:	ed2080e7          	jalr	-302(ra) # 800012e4 <release>

  return i;
    8000041a:	fec42783          	lw	a5,-20(s0)
}
    8000041e:	853e                	mv	a0,a5
    80000420:	70a2                	ld	ra,40(sp)
    80000422:	7402                	ld	s0,32(sp)
    80000424:	6145                	addi	sp,sp,48
    80000426:	8082                	ret

0000000080000428 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000428:	7179                	addi	sp,sp,-48
    8000042a:	f406                	sd	ra,40(sp)
    8000042c:	f022                	sd	s0,32(sp)
    8000042e:	1800                	addi	s0,sp,48
    80000430:	87aa                	mv	a5,a0
    80000432:	fcb43823          	sd	a1,-48(s0)
    80000436:	8732                	mv	a4,a2
    80000438:	fcf42e23          	sw	a5,-36(s0)
    8000043c:	87ba                	mv	a5,a4
    8000043e:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    80000442:	fd842783          	lw	a5,-40(s0)
    80000446:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    8000044a:	00014517          	auipc	a0,0x14
    8000044e:	d2650513          	addi	a0,a0,-730 # 80014170 <cons>
    80000452:	00001097          	auipc	ra,0x1
    80000456:	e2e080e7          	jalr	-466(ra) # 80001280 <acquire>
  while(n > 0){
    8000045a:	a215                	j	8000057e <consoleread+0x156>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(myproc()->killed){
    8000045c:	00002097          	auipc	ra,0x2
    80000460:	39c080e7          	jalr	924(ra) # 800027f8 <myproc>
    80000464:	87aa                	mv	a5,a0
    80000466:	5b9c                	lw	a5,48(a5)
    80000468:	cb99                	beqz	a5,8000047e <consoleread+0x56>
        release(&cons.lock);
    8000046a:	00014517          	auipc	a0,0x14
    8000046e:	d0650513          	addi	a0,a0,-762 # 80014170 <cons>
    80000472:	00001097          	auipc	ra,0x1
    80000476:	e72080e7          	jalr	-398(ra) # 800012e4 <release>
        return -1;
    8000047a:	57fd                	li	a5,-1
    8000047c:	aa25                	j	800005b4 <consoleread+0x18c>
      }
      sleep(&cons.r, &cons.lock);
    8000047e:	00014597          	auipc	a1,0x14
    80000482:	cf258593          	addi	a1,a1,-782 # 80014170 <cons>
    80000486:	00014517          	auipc	a0,0x14
    8000048a:	d8250513          	addi	a0,a0,-638 # 80014208 <cons+0x98>
    8000048e:	00003097          	auipc	ra,0x3
    80000492:	0b6080e7          	jalr	182(ra) # 80003544 <sleep>
    while(cons.r == cons.w){
    80000496:	00014797          	auipc	a5,0x14
    8000049a:	cda78793          	addi	a5,a5,-806 # 80014170 <cons>
    8000049e:	0987a703          	lw	a4,152(a5)
    800004a2:	00014797          	auipc	a5,0x14
    800004a6:	cce78793          	addi	a5,a5,-818 # 80014170 <cons>
    800004aa:	09c7a783          	lw	a5,156(a5)
    800004ae:	faf707e3          	beq	a4,a5,8000045c <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    800004b2:	00014797          	auipc	a5,0x14
    800004b6:	cbe78793          	addi	a5,a5,-834 # 80014170 <cons>
    800004ba:	0987a783          	lw	a5,152(a5)
    800004be:	2781                	sext.w	a5,a5
    800004c0:	0017871b          	addiw	a4,a5,1
    800004c4:	0007069b          	sext.w	a3,a4
    800004c8:	00014717          	auipc	a4,0x14
    800004cc:	ca870713          	addi	a4,a4,-856 # 80014170 <cons>
    800004d0:	08d72c23          	sw	a3,152(a4)
    800004d4:	07f7f793          	andi	a5,a5,127
    800004d8:	2781                	sext.w	a5,a5
    800004da:	00014717          	auipc	a4,0x14
    800004de:	c9670713          	addi	a4,a4,-874 # 80014170 <cons>
    800004e2:	1782                	slli	a5,a5,0x20
    800004e4:	9381                	srli	a5,a5,0x20
    800004e6:	97ba                	add	a5,a5,a4
    800004e8:	0187c783          	lbu	a5,24(a5)
    800004ec:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    800004f0:	fe842783          	lw	a5,-24(s0)
    800004f4:	0007871b          	sext.w	a4,a5
    800004f8:	4791                	li	a5,4
    800004fa:	02f71963          	bne	a4,a5,8000052c <consoleread+0x104>
      if(n < target){
    800004fe:	fd842703          	lw	a4,-40(s0)
    80000502:	fec42783          	lw	a5,-20(s0)
    80000506:	2781                	sext.w	a5,a5
    80000508:	08f77163          	bgeu	a4,a5,8000058a <consoleread+0x162>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    8000050c:	00014797          	auipc	a5,0x14
    80000510:	c6478793          	addi	a5,a5,-924 # 80014170 <cons>
    80000514:	0987a783          	lw	a5,152(a5)
    80000518:	37fd                	addiw	a5,a5,-1
    8000051a:	0007871b          	sext.w	a4,a5
    8000051e:	00014797          	auipc	a5,0x14
    80000522:	c5278793          	addi	a5,a5,-942 # 80014170 <cons>
    80000526:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    8000052a:	a085                	j	8000058a <consoleread+0x162>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    8000052c:	fe842783          	lw	a5,-24(s0)
    80000530:	0ff7f793          	andi	a5,a5,255
    80000534:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000538:	fe740713          	addi	a4,s0,-25
    8000053c:	fdc42783          	lw	a5,-36(s0)
    80000540:	4685                	li	a3,1
    80000542:	863a                	mv	a2,a4
    80000544:	fd043583          	ld	a1,-48(s0)
    80000548:	853e                	mv	a0,a5
    8000054a:	00003097          	auipc	ra,0x3
    8000054e:	214080e7          	jalr	532(ra) # 8000375e <either_copyout>
    80000552:	87aa                	mv	a5,a0
    80000554:	873e                	mv	a4,a5
    80000556:	57fd                	li	a5,-1
    80000558:	02f70b63          	beq	a4,a5,8000058e <consoleread+0x166>
      break;

    dst++;
    8000055c:	fd043783          	ld	a5,-48(s0)
    80000560:	0785                	addi	a5,a5,1
    80000562:	fcf43823          	sd	a5,-48(s0)
    --n;
    80000566:	fd842783          	lw	a5,-40(s0)
    8000056a:	37fd                	addiw	a5,a5,-1
    8000056c:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    80000570:	fe842783          	lw	a5,-24(s0)
    80000574:	0007871b          	sext.w	a4,a5
    80000578:	47a9                	li	a5,10
    8000057a:	00f70c63          	beq	a4,a5,80000592 <consoleread+0x16a>
  while(n > 0){
    8000057e:	fd842783          	lw	a5,-40(s0)
    80000582:	2781                	sext.w	a5,a5
    80000584:	f0f049e3          	bgtz	a5,80000496 <consoleread+0x6e>
    80000588:	a031                	j	80000594 <consoleread+0x16c>
      break;
    8000058a:	0001                	nop
    8000058c:	a021                	j	80000594 <consoleread+0x16c>
      break;
    8000058e:	0001                	nop
    80000590:	a011                	j	80000594 <consoleread+0x16c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    80000592:	0001                	nop
    }
  }
  release(&cons.lock);
    80000594:	00014517          	auipc	a0,0x14
    80000598:	bdc50513          	addi	a0,a0,-1060 # 80014170 <cons>
    8000059c:	00001097          	auipc	ra,0x1
    800005a0:	d48080e7          	jalr	-696(ra) # 800012e4 <release>

  return target - n;
    800005a4:	fd842783          	lw	a5,-40(s0)
    800005a8:	fec42703          	lw	a4,-20(s0)
    800005ac:	40f707bb          	subw	a5,a4,a5
    800005b0:	2781                	sext.w	a5,a5
    800005b2:	2781                	sext.w	a5,a5
}
    800005b4:	853e                	mv	a0,a5
    800005b6:	70a2                	ld	ra,40(sp)
    800005b8:	7402                	ld	s0,32(sp)
    800005ba:	6145                	addi	sp,sp,48
    800005bc:	8082                	ret

00000000800005be <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005be:	1101                	addi	sp,sp,-32
    800005c0:	ec06                	sd	ra,24(sp)
    800005c2:	e822                	sd	s0,16(sp)
    800005c4:	1000                	addi	s0,sp,32
    800005c6:	87aa                	mv	a5,a0
    800005c8:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    800005cc:	00014517          	auipc	a0,0x14
    800005d0:	ba450513          	addi	a0,a0,-1116 # 80014170 <cons>
    800005d4:	00001097          	auipc	ra,0x1
    800005d8:	cac080e7          	jalr	-852(ra) # 80001280 <acquire>

  switch(c){
    800005dc:	fec42783          	lw	a5,-20(s0)
    800005e0:	0007871b          	sext.w	a4,a5
    800005e4:	07f00793          	li	a5,127
    800005e8:	0cf70763          	beq	a4,a5,800006b6 <consoleintr+0xf8>
    800005ec:	fec42783          	lw	a5,-20(s0)
    800005f0:	0007871b          	sext.w	a4,a5
    800005f4:	07f00793          	li	a5,127
    800005f8:	10e7c363          	blt	a5,a4,800006fe <consoleintr+0x140>
    800005fc:	fec42783          	lw	a5,-20(s0)
    80000600:	0007871b          	sext.w	a4,a5
    80000604:	47d5                	li	a5,21
    80000606:	06f70163          	beq	a4,a5,80000668 <consoleintr+0xaa>
    8000060a:	fec42783          	lw	a5,-20(s0)
    8000060e:	0007871b          	sext.w	a4,a5
    80000612:	47d5                	li	a5,21
    80000614:	0ee7c563          	blt	a5,a4,800006fe <consoleintr+0x140>
    80000618:	fec42783          	lw	a5,-20(s0)
    8000061c:	0007871b          	sext.w	a4,a5
    80000620:	47a1                	li	a5,8
    80000622:	08f70a63          	beq	a4,a5,800006b6 <consoleintr+0xf8>
    80000626:	fec42783          	lw	a5,-20(s0)
    8000062a:	0007871b          	sext.w	a4,a5
    8000062e:	47c1                	li	a5,16
    80000630:	0cf71763          	bne	a4,a5,800006fe <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80000634:	00003097          	auipc	ra,0x3
    80000638:	21e080e7          	jalr	542(ra) # 80003852 <procdump>
    break;
    8000063c:	aac1                	j	8000080c <consoleintr+0x24e>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
      cons.e--;
    8000063e:	00014797          	auipc	a5,0x14
    80000642:	b3278793          	addi	a5,a5,-1230 # 80014170 <cons>
    80000646:	0a07a783          	lw	a5,160(a5)
    8000064a:	37fd                	addiw	a5,a5,-1
    8000064c:	0007871b          	sext.w	a4,a5
    80000650:	00014797          	auipc	a5,0x14
    80000654:	b2078793          	addi	a5,a5,-1248 # 80014170 <cons>
    80000658:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    8000065c:	10000513          	li	a0,256
    80000660:	00000097          	auipc	ra,0x0
    80000664:	cc8080e7          	jalr	-824(ra) # 80000328 <consputc>
    while(cons.e != cons.w &&
    80000668:	00014797          	auipc	a5,0x14
    8000066c:	b0878793          	addi	a5,a5,-1272 # 80014170 <cons>
    80000670:	0a07a703          	lw	a4,160(a5)
    80000674:	00014797          	auipc	a5,0x14
    80000678:	afc78793          	addi	a5,a5,-1284 # 80014170 <cons>
    8000067c:	09c7a783          	lw	a5,156(a5)
    80000680:	18f70163          	beq	a4,a5,80000802 <consoleintr+0x244>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80000684:	00014797          	auipc	a5,0x14
    80000688:	aec78793          	addi	a5,a5,-1300 # 80014170 <cons>
    8000068c:	0a07a783          	lw	a5,160(a5)
    80000690:	37fd                	addiw	a5,a5,-1
    80000692:	2781                	sext.w	a5,a5
    80000694:	07f7f793          	andi	a5,a5,127
    80000698:	2781                	sext.w	a5,a5
    8000069a:	00014717          	auipc	a4,0x14
    8000069e:	ad670713          	addi	a4,a4,-1322 # 80014170 <cons>
    800006a2:	1782                	slli	a5,a5,0x20
    800006a4:	9381                	srli	a5,a5,0x20
    800006a6:	97ba                	add	a5,a5,a4
    800006a8:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006ac:	873e                	mv	a4,a5
    800006ae:	47a9                	li	a5,10
    800006b0:	f8f717e3          	bne	a4,a5,8000063e <consoleintr+0x80>
    }
    break;
    800006b4:	a2b9                	j	80000802 <consoleintr+0x244>
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    800006b6:	00014797          	auipc	a5,0x14
    800006ba:	aba78793          	addi	a5,a5,-1350 # 80014170 <cons>
    800006be:	0a07a703          	lw	a4,160(a5)
    800006c2:	00014797          	auipc	a5,0x14
    800006c6:	aae78793          	addi	a5,a5,-1362 # 80014170 <cons>
    800006ca:	09c7a783          	lw	a5,156(a5)
    800006ce:	12f70c63          	beq	a4,a5,80000806 <consoleintr+0x248>
      cons.e--;
    800006d2:	00014797          	auipc	a5,0x14
    800006d6:	a9e78793          	addi	a5,a5,-1378 # 80014170 <cons>
    800006da:	0a07a783          	lw	a5,160(a5)
    800006de:	37fd                	addiw	a5,a5,-1
    800006e0:	0007871b          	sext.w	a4,a5
    800006e4:	00014797          	auipc	a5,0x14
    800006e8:	a8c78793          	addi	a5,a5,-1396 # 80014170 <cons>
    800006ec:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    800006f0:	10000513          	li	a0,256
    800006f4:	00000097          	auipc	ra,0x0
    800006f8:	c34080e7          	jalr	-972(ra) # 80000328 <consputc>
    }
    break;
    800006fc:	a229                	j	80000806 <consoleintr+0x248>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800006fe:	fec42783          	lw	a5,-20(s0)
    80000702:	2781                	sext.w	a5,a5
    80000704:	10078363          	beqz	a5,8000080a <consoleintr+0x24c>
    80000708:	00014797          	auipc	a5,0x14
    8000070c:	a6878793          	addi	a5,a5,-1432 # 80014170 <cons>
    80000710:	0a07a703          	lw	a4,160(a5)
    80000714:	00014797          	auipc	a5,0x14
    80000718:	a5c78793          	addi	a5,a5,-1444 # 80014170 <cons>
    8000071c:	0987a783          	lw	a5,152(a5)
    80000720:	40f707bb          	subw	a5,a4,a5
    80000724:	2781                	sext.w	a5,a5
    80000726:	873e                	mv	a4,a5
    80000728:	07f00793          	li	a5,127
    8000072c:	0ce7ef63          	bltu	a5,a4,8000080a <consoleintr+0x24c>
      c = (c == '\r') ? '\n' : c;
    80000730:	fec42783          	lw	a5,-20(s0)
    80000734:	0007871b          	sext.w	a4,a5
    80000738:	47b5                	li	a5,13
    8000073a:	00f70563          	beq	a4,a5,80000744 <consoleintr+0x186>
    8000073e:	fec42783          	lw	a5,-20(s0)
    80000742:	a011                	j	80000746 <consoleintr+0x188>
    80000744:	47a9                	li	a5,10
    80000746:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    8000074a:	fec42783          	lw	a5,-20(s0)
    8000074e:	853e                	mv	a0,a5
    80000750:	00000097          	auipc	ra,0x0
    80000754:	bd8080e7          	jalr	-1064(ra) # 80000328 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000758:	00014797          	auipc	a5,0x14
    8000075c:	a1878793          	addi	a5,a5,-1512 # 80014170 <cons>
    80000760:	0a07a783          	lw	a5,160(a5)
    80000764:	2781                	sext.w	a5,a5
    80000766:	0017871b          	addiw	a4,a5,1
    8000076a:	0007069b          	sext.w	a3,a4
    8000076e:	00014717          	auipc	a4,0x14
    80000772:	a0270713          	addi	a4,a4,-1534 # 80014170 <cons>
    80000776:	0ad72023          	sw	a3,160(a4)
    8000077a:	07f7f793          	andi	a5,a5,127
    8000077e:	2781                	sext.w	a5,a5
    80000780:	fec42703          	lw	a4,-20(s0)
    80000784:	0ff77713          	andi	a4,a4,255
    80000788:	00014697          	auipc	a3,0x14
    8000078c:	9e868693          	addi	a3,a3,-1560 # 80014170 <cons>
    80000790:	1782                	slli	a5,a5,0x20
    80000792:	9381                	srli	a5,a5,0x20
    80000794:	97b6                	add	a5,a5,a3
    80000796:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000079a:	fec42783          	lw	a5,-20(s0)
    8000079e:	0007871b          	sext.w	a4,a5
    800007a2:	47a9                	li	a5,10
    800007a4:	02f70a63          	beq	a4,a5,800007d8 <consoleintr+0x21a>
    800007a8:	fec42783          	lw	a5,-20(s0)
    800007ac:	0007871b          	sext.w	a4,a5
    800007b0:	4791                	li	a5,4
    800007b2:	02f70363          	beq	a4,a5,800007d8 <consoleintr+0x21a>
    800007b6:	00014797          	auipc	a5,0x14
    800007ba:	9ba78793          	addi	a5,a5,-1606 # 80014170 <cons>
    800007be:	0a07a703          	lw	a4,160(a5)
    800007c2:	00014797          	auipc	a5,0x14
    800007c6:	9ae78793          	addi	a5,a5,-1618 # 80014170 <cons>
    800007ca:	0987a783          	lw	a5,152(a5)
    800007ce:	0807879b          	addiw	a5,a5,128
    800007d2:	2781                	sext.w	a5,a5
    800007d4:	02f71b63          	bne	a4,a5,8000080a <consoleintr+0x24c>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    800007d8:	00014797          	auipc	a5,0x14
    800007dc:	99878793          	addi	a5,a5,-1640 # 80014170 <cons>
    800007e0:	0a07a703          	lw	a4,160(a5)
    800007e4:	00014797          	auipc	a5,0x14
    800007e8:	98c78793          	addi	a5,a5,-1652 # 80014170 <cons>
    800007ec:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    800007f0:	00014517          	auipc	a0,0x14
    800007f4:	a1850513          	addi	a0,a0,-1512 # 80014208 <cons+0x98>
    800007f8:	00003097          	auipc	ra,0x3
    800007fc:	de0080e7          	jalr	-544(ra) # 800035d8 <wakeup>
      }
    }
    break;
    80000800:	a029                	j	8000080a <consoleintr+0x24c>
    break;
    80000802:	0001                	nop
    80000804:	a021                	j	8000080c <consoleintr+0x24e>
    break;
    80000806:	0001                	nop
    80000808:	a011                	j	8000080c <consoleintr+0x24e>
    break;
    8000080a:	0001                	nop
  }
  
  release(&cons.lock);
    8000080c:	00014517          	auipc	a0,0x14
    80000810:	96450513          	addi	a0,a0,-1692 # 80014170 <cons>
    80000814:	00001097          	auipc	ra,0x1
    80000818:	ad0080e7          	jalr	-1328(ra) # 800012e4 <release>
}
    8000081c:	0001                	nop
    8000081e:	60e2                	ld	ra,24(sp)
    80000820:	6442                	ld	s0,16(sp)
    80000822:	6105                	addi	sp,sp,32
    80000824:	8082                	ret

0000000080000826 <consoleinit>:

void
consoleinit(void)
{
    80000826:	1141                	addi	sp,sp,-16
    80000828:	e406                	sd	ra,8(sp)
    8000082a:	e022                	sd	s0,0(sp)
    8000082c:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000082e:	0000a597          	auipc	a1,0xa
    80000832:	7d258593          	addi	a1,a1,2002 # 8000b000 <etext>
    80000836:	00014517          	auipc	a0,0x14
    8000083a:	93a50513          	addi	a0,a0,-1734 # 80014170 <cons>
    8000083e:	00001097          	auipc	ra,0x1
    80000842:	a12080e7          	jalr	-1518(ra) # 80001250 <initlock>

  uartinit();
    80000846:	00000097          	auipc	ra,0x0
    8000084a:	494080e7          	jalr	1172(ra) # 80000cda <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000084e:	0006d797          	auipc	a5,0x6d
    80000852:	4aa78793          	addi	a5,a5,1194 # 8006dcf8 <devsw>
    80000856:	00000717          	auipc	a4,0x0
    8000085a:	bd270713          	addi	a4,a4,-1070 # 80000428 <consoleread>
    8000085e:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000860:	0006d797          	auipc	a5,0x6d
    80000864:	49878793          	addi	a5,a5,1176 # 8006dcf8 <devsw>
    80000868:	00000717          	auipc	a4,0x0
    8000086c:	b1870713          	addi	a4,a4,-1256 # 80000380 <consolewrite>
    80000870:	ef98                	sd	a4,24(a5)
}
    80000872:	0001                	nop
    80000874:	60a2                	ld	ra,8(sp)
    80000876:	6402                	ld	s0,0(sp)
    80000878:	0141                	addi	sp,sp,16
    8000087a:	8082                	ret

000000008000087c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000087c:	7139                	addi	sp,sp,-64
    8000087e:	fc06                	sd	ra,56(sp)
    80000880:	f822                	sd	s0,48(sp)
    80000882:	0080                	addi	s0,sp,64
    80000884:	87aa                	mv	a5,a0
    80000886:	86ae                	mv	a3,a1
    80000888:	8732                	mv	a4,a2
    8000088a:	fcf42623          	sw	a5,-52(s0)
    8000088e:	87b6                	mv	a5,a3
    80000890:	fcf42423          	sw	a5,-56(s0)
    80000894:	87ba                	mv	a5,a4
    80000896:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8000089a:	fc442783          	lw	a5,-60(s0)
    8000089e:	2781                	sext.w	a5,a5
    800008a0:	c78d                	beqz	a5,800008ca <printint+0x4e>
    800008a2:	fcc42783          	lw	a5,-52(s0)
    800008a6:	01f7d79b          	srliw	a5,a5,0x1f
    800008aa:	0ff7f793          	andi	a5,a5,255
    800008ae:	fcf42223          	sw	a5,-60(s0)
    800008b2:	fc442783          	lw	a5,-60(s0)
    800008b6:	2781                	sext.w	a5,a5
    800008b8:	cb89                	beqz	a5,800008ca <printint+0x4e>
    x = -xx;
    800008ba:	fcc42783          	lw	a5,-52(s0)
    800008be:	40f007bb          	negw	a5,a5
    800008c2:	2781                	sext.w	a5,a5
    800008c4:	fef42423          	sw	a5,-24(s0)
    800008c8:	a029                	j	800008d2 <printint+0x56>
  else
    x = xx;
    800008ca:	fcc42783          	lw	a5,-52(s0)
    800008ce:	fef42423          	sw	a5,-24(s0)

  i = 0;
    800008d2:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    800008d6:	fc842783          	lw	a5,-56(s0)
    800008da:	fe842703          	lw	a4,-24(s0)
    800008de:	02f777bb          	remuw	a5,a4,a5
    800008e2:	0007861b          	sext.w	a2,a5
    800008e6:	fec42783          	lw	a5,-20(s0)
    800008ea:	0017871b          	addiw	a4,a5,1
    800008ee:	fee42623          	sw	a4,-20(s0)
    800008f2:	0000b697          	auipc	a3,0xb
    800008f6:	e6e68693          	addi	a3,a3,-402 # 8000b760 <digits>
    800008fa:	02061713          	slli	a4,a2,0x20
    800008fe:	9301                	srli	a4,a4,0x20
    80000900:	9736                	add	a4,a4,a3
    80000902:	00074703          	lbu	a4,0(a4)
    80000906:	ff040693          	addi	a3,s0,-16
    8000090a:	97b6                	add	a5,a5,a3
    8000090c:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    80000910:	fc842783          	lw	a5,-56(s0)
    80000914:	fe842703          	lw	a4,-24(s0)
    80000918:	02f757bb          	divuw	a5,a4,a5
    8000091c:	fef42423          	sw	a5,-24(s0)
    80000920:	fe842783          	lw	a5,-24(s0)
    80000924:	2781                	sext.w	a5,a5
    80000926:	fbc5                	bnez	a5,800008d6 <printint+0x5a>

  if(sign)
    80000928:	fc442783          	lw	a5,-60(s0)
    8000092c:	2781                	sext.w	a5,a5
    8000092e:	cf85                	beqz	a5,80000966 <printint+0xea>
    buf[i++] = '-';
    80000930:	fec42783          	lw	a5,-20(s0)
    80000934:	0017871b          	addiw	a4,a5,1
    80000938:	fee42623          	sw	a4,-20(s0)
    8000093c:	ff040713          	addi	a4,s0,-16
    80000940:	97ba                	add	a5,a5,a4
    80000942:	02d00713          	li	a4,45
    80000946:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    8000094a:	a831                	j	80000966 <printint+0xea>
    consputc(buf[i]);
    8000094c:	fec42783          	lw	a5,-20(s0)
    80000950:	ff040713          	addi	a4,s0,-16
    80000954:	97ba                	add	a5,a5,a4
    80000956:	fe87c783          	lbu	a5,-24(a5)
    8000095a:	2781                	sext.w	a5,a5
    8000095c:	853e                	mv	a0,a5
    8000095e:	00000097          	auipc	ra,0x0
    80000962:	9ca080e7          	jalr	-1590(ra) # 80000328 <consputc>
  while(--i >= 0)
    80000966:	fec42783          	lw	a5,-20(s0)
    8000096a:	37fd                	addiw	a5,a5,-1
    8000096c:	fef42623          	sw	a5,-20(s0)
    80000970:	fec42783          	lw	a5,-20(s0)
    80000974:	2781                	sext.w	a5,a5
    80000976:	fc07dbe3          	bgez	a5,8000094c <printint+0xd0>
}
    8000097a:	0001                	nop
    8000097c:	0001                	nop
    8000097e:	70e2                	ld	ra,56(sp)
    80000980:	7442                	ld	s0,48(sp)
    80000982:	6121                	addi	sp,sp,64
    80000984:	8082                	ret

0000000080000986 <printptr>:

static void
printptr(uint64 x)
{
    80000986:	7179                	addi	sp,sp,-48
    80000988:	f406                	sd	ra,40(sp)
    8000098a:	f022                	sd	s0,32(sp)
    8000098c:	1800                	addi	s0,sp,48
    8000098e:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    80000992:	03000513          	li	a0,48
    80000996:	00000097          	auipc	ra,0x0
    8000099a:	992080e7          	jalr	-1646(ra) # 80000328 <consputc>
  consputc('x');
    8000099e:	07800513          	li	a0,120
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	986080e7          	jalr	-1658(ra) # 80000328 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009aa:	fe042623          	sw	zero,-20(s0)
    800009ae:	a81d                	j	800009e4 <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009b0:	fd843783          	ld	a5,-40(s0)
    800009b4:	93f1                	srli	a5,a5,0x3c
    800009b6:	0000b717          	auipc	a4,0xb
    800009ba:	daa70713          	addi	a4,a4,-598 # 8000b760 <digits>
    800009be:	97ba                	add	a5,a5,a4
    800009c0:	0007c783          	lbu	a5,0(a5)
    800009c4:	2781                	sext.w	a5,a5
    800009c6:	853e                	mv	a0,a5
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	960080e7          	jalr	-1696(ra) # 80000328 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009d0:	fec42783          	lw	a5,-20(s0)
    800009d4:	2785                	addiw	a5,a5,1
    800009d6:	fef42623          	sw	a5,-20(s0)
    800009da:	fd843783          	ld	a5,-40(s0)
    800009de:	0792                	slli	a5,a5,0x4
    800009e0:	fcf43c23          	sd	a5,-40(s0)
    800009e4:	fec42783          	lw	a5,-20(s0)
    800009e8:	873e                	mv	a4,a5
    800009ea:	47bd                	li	a5,15
    800009ec:	fce7f2e3          	bgeu	a5,a4,800009b0 <printptr+0x2a>
}
    800009f0:	0001                	nop
    800009f2:	0001                	nop
    800009f4:	70a2                	ld	ra,40(sp)
    800009f6:	7402                	ld	s0,32(sp)
    800009f8:	6145                	addi	sp,sp,48
    800009fa:	8082                	ret

00000000800009fc <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    800009fc:	7119                	addi	sp,sp,-128
    800009fe:	fc06                	sd	ra,56(sp)
    80000a00:	f822                	sd	s0,48(sp)
    80000a02:	0080                	addi	s0,sp,64
    80000a04:	fca43423          	sd	a0,-56(s0)
    80000a08:	e40c                	sd	a1,8(s0)
    80000a0a:	e810                	sd	a2,16(s0)
    80000a0c:	ec14                	sd	a3,24(s0)
    80000a0e:	f018                	sd	a4,32(s0)
    80000a10:	f41c                	sd	a5,40(s0)
    80000a12:	03043823          	sd	a6,48(s0)
    80000a16:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a1a:	00013797          	auipc	a5,0x13
    80000a1e:	7fe78793          	addi	a5,a5,2046 # 80014218 <pr>
    80000a22:	4f9c                	lw	a5,24(a5)
    80000a24:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a28:	fdc42783          	lw	a5,-36(s0)
    80000a2c:	2781                	sext.w	a5,a5
    80000a2e:	cb89                	beqz	a5,80000a40 <printf+0x44>
    acquire(&pr.lock);
    80000a30:	00013517          	auipc	a0,0x13
    80000a34:	7e850513          	addi	a0,a0,2024 # 80014218 <pr>
    80000a38:	00001097          	auipc	ra,0x1
    80000a3c:	848080e7          	jalr	-1976(ra) # 80001280 <acquire>

  if (fmt == 0)
    80000a40:	fc843783          	ld	a5,-56(s0)
    80000a44:	eb89                	bnez	a5,80000a56 <printf+0x5a>
    panic("null fmt");
    80000a46:	0000a517          	auipc	a0,0xa
    80000a4a:	5c250513          	addi	a0,a0,1474 # 8000b008 <etext+0x8>
    80000a4e:	00000097          	auipc	ra,0x0
    80000a52:	204080e7          	jalr	516(ra) # 80000c52 <panic>

  va_start(ap, fmt);
    80000a56:	04040793          	addi	a5,s0,64
    80000a5a:	fcf43023          	sd	a5,-64(s0)
    80000a5e:	fc043783          	ld	a5,-64(s0)
    80000a62:	fc878793          	addi	a5,a5,-56
    80000a66:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000a6a:	fe042623          	sw	zero,-20(s0)
    80000a6e:	a24d                	j	80000c10 <printf+0x214>
    if(c != '%'){
    80000a70:	fd842783          	lw	a5,-40(s0)
    80000a74:	0007871b          	sext.w	a4,a5
    80000a78:	02500793          	li	a5,37
    80000a7c:	00f70a63          	beq	a4,a5,80000a90 <printf+0x94>
      consputc(c);
    80000a80:	fd842783          	lw	a5,-40(s0)
    80000a84:	853e                	mv	a0,a5
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	8a2080e7          	jalr	-1886(ra) # 80000328 <consputc>
      continue;
    80000a8e:	aaa5                	j	80000c06 <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000a90:	fec42783          	lw	a5,-20(s0)
    80000a94:	2785                	addiw	a5,a5,1
    80000a96:	fef42623          	sw	a5,-20(s0)
    80000a9a:	fec42783          	lw	a5,-20(s0)
    80000a9e:	fc843703          	ld	a4,-56(s0)
    80000aa2:	97ba                	add	a5,a5,a4
    80000aa4:	0007c783          	lbu	a5,0(a5)
    80000aa8:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000aac:	fd842783          	lw	a5,-40(s0)
    80000ab0:	2781                	sext.w	a5,a5
    80000ab2:	16078e63          	beqz	a5,80000c2e <printf+0x232>
      break;
    switch(c){
    80000ab6:	fd842783          	lw	a5,-40(s0)
    80000aba:	0007871b          	sext.w	a4,a5
    80000abe:	07800793          	li	a5,120
    80000ac2:	08f70963          	beq	a4,a5,80000b54 <printf+0x158>
    80000ac6:	fd842783          	lw	a5,-40(s0)
    80000aca:	0007871b          	sext.w	a4,a5
    80000ace:	07800793          	li	a5,120
    80000ad2:	10e7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000ad6:	fd842783          	lw	a5,-40(s0)
    80000ada:	0007871b          	sext.w	a4,a5
    80000ade:	07300793          	li	a5,115
    80000ae2:	0af70563          	beq	a4,a5,80000b8c <printf+0x190>
    80000ae6:	fd842783          	lw	a5,-40(s0)
    80000aea:	0007871b          	sext.w	a4,a5
    80000aee:	07300793          	li	a5,115
    80000af2:	0ee7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000af6:	fd842783          	lw	a5,-40(s0)
    80000afa:	0007871b          	sext.w	a4,a5
    80000afe:	07000793          	li	a5,112
    80000b02:	06f70863          	beq	a4,a5,80000b72 <printf+0x176>
    80000b06:	fd842783          	lw	a5,-40(s0)
    80000b0a:	0007871b          	sext.w	a4,a5
    80000b0e:	07000793          	li	a5,112
    80000b12:	0ce7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000b16:	fd842783          	lw	a5,-40(s0)
    80000b1a:	0007871b          	sext.w	a4,a5
    80000b1e:	02500793          	li	a5,37
    80000b22:	0af70d63          	beq	a4,a5,80000bdc <printf+0x1e0>
    80000b26:	fd842783          	lw	a5,-40(s0)
    80000b2a:	0007871b          	sext.w	a4,a5
    80000b2e:	06400793          	li	a5,100
    80000b32:	0af71c63          	bne	a4,a5,80000bea <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b36:	fd043783          	ld	a5,-48(s0)
    80000b3a:	00878713          	addi	a4,a5,8
    80000b3e:	fce43823          	sd	a4,-48(s0)
    80000b42:	439c                	lw	a5,0(a5)
    80000b44:	4605                	li	a2,1
    80000b46:	45a9                	li	a1,10
    80000b48:	853e                	mv	a0,a5
    80000b4a:	00000097          	auipc	ra,0x0
    80000b4e:	d32080e7          	jalr	-718(ra) # 8000087c <printint>
      break;
    80000b52:	a855                	j	80000c06 <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b54:	fd043783          	ld	a5,-48(s0)
    80000b58:	00878713          	addi	a4,a5,8
    80000b5c:	fce43823          	sd	a4,-48(s0)
    80000b60:	439c                	lw	a5,0(a5)
    80000b62:	4605                	li	a2,1
    80000b64:	45c1                	li	a1,16
    80000b66:	853e                	mv	a0,a5
    80000b68:	00000097          	auipc	ra,0x0
    80000b6c:	d14080e7          	jalr	-748(ra) # 8000087c <printint>
      break;
    80000b70:	a859                	j	80000c06 <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000b72:	fd043783          	ld	a5,-48(s0)
    80000b76:	00878713          	addi	a4,a5,8
    80000b7a:	fce43823          	sd	a4,-48(s0)
    80000b7e:	639c                	ld	a5,0(a5)
    80000b80:	853e                	mv	a0,a5
    80000b82:	00000097          	auipc	ra,0x0
    80000b86:	e04080e7          	jalr	-508(ra) # 80000986 <printptr>
      break;
    80000b8a:	a8b5                	j	80000c06 <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000b8c:	fd043783          	ld	a5,-48(s0)
    80000b90:	00878713          	addi	a4,a5,8
    80000b94:	fce43823          	sd	a4,-48(s0)
    80000b98:	639c                	ld	a5,0(a5)
    80000b9a:	fef43023          	sd	a5,-32(s0)
    80000b9e:	fe043783          	ld	a5,-32(s0)
    80000ba2:	e79d                	bnez	a5,80000bd0 <printf+0x1d4>
        s = "(null)";
    80000ba4:	0000a797          	auipc	a5,0xa
    80000ba8:	47478793          	addi	a5,a5,1140 # 8000b018 <etext+0x18>
    80000bac:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000bb0:	a005                	j	80000bd0 <printf+0x1d4>
        consputc(*s);
    80000bb2:	fe043783          	ld	a5,-32(s0)
    80000bb6:	0007c783          	lbu	a5,0(a5)
    80000bba:	2781                	sext.w	a5,a5
    80000bbc:	853e                	mv	a0,a5
    80000bbe:	fffff097          	auipc	ra,0xfffff
    80000bc2:	76a080e7          	jalr	1898(ra) # 80000328 <consputc>
      for(; *s; s++)
    80000bc6:	fe043783          	ld	a5,-32(s0)
    80000bca:	0785                	addi	a5,a5,1
    80000bcc:	fef43023          	sd	a5,-32(s0)
    80000bd0:	fe043783          	ld	a5,-32(s0)
    80000bd4:	0007c783          	lbu	a5,0(a5)
    80000bd8:	ffe9                	bnez	a5,80000bb2 <printf+0x1b6>
      break;
    80000bda:	a035                	j	80000c06 <printf+0x20a>
    case '%':
      consputc('%');
    80000bdc:	02500513          	li	a0,37
    80000be0:	fffff097          	auipc	ra,0xfffff
    80000be4:	748080e7          	jalr	1864(ra) # 80000328 <consputc>
      break;
    80000be8:	a839                	j	80000c06 <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000bea:	02500513          	li	a0,37
    80000bee:	fffff097          	auipc	ra,0xfffff
    80000bf2:	73a080e7          	jalr	1850(ra) # 80000328 <consputc>
      consputc(c);
    80000bf6:	fd842783          	lw	a5,-40(s0)
    80000bfa:	853e                	mv	a0,a5
    80000bfc:	fffff097          	auipc	ra,0xfffff
    80000c00:	72c080e7          	jalr	1836(ra) # 80000328 <consputc>
      break;
    80000c04:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c06:	fec42783          	lw	a5,-20(s0)
    80000c0a:	2785                	addiw	a5,a5,1
    80000c0c:	fef42623          	sw	a5,-20(s0)
    80000c10:	fec42783          	lw	a5,-20(s0)
    80000c14:	fc843703          	ld	a4,-56(s0)
    80000c18:	97ba                	add	a5,a5,a4
    80000c1a:	0007c783          	lbu	a5,0(a5)
    80000c1e:	fcf42c23          	sw	a5,-40(s0)
    80000c22:	fd842783          	lw	a5,-40(s0)
    80000c26:	2781                	sext.w	a5,a5
    80000c28:	e40794e3          	bnez	a5,80000a70 <printf+0x74>
    80000c2c:	a011                	j	80000c30 <printf+0x234>
      break;
    80000c2e:	0001                	nop
    }
  }

  if(locking)
    80000c30:	fdc42783          	lw	a5,-36(s0)
    80000c34:	2781                	sext.w	a5,a5
    80000c36:	cb89                	beqz	a5,80000c48 <printf+0x24c>
    release(&pr.lock);
    80000c38:	00013517          	auipc	a0,0x13
    80000c3c:	5e050513          	addi	a0,a0,1504 # 80014218 <pr>
    80000c40:	00000097          	auipc	ra,0x0
    80000c44:	6a4080e7          	jalr	1700(ra) # 800012e4 <release>
}
    80000c48:	0001                	nop
    80000c4a:	70e2                	ld	ra,56(sp)
    80000c4c:	7442                	ld	s0,48(sp)
    80000c4e:	6109                	addi	sp,sp,128
    80000c50:	8082                	ret

0000000080000c52 <panic>:

void
panic(char *s)
{
    80000c52:	1101                	addi	sp,sp,-32
    80000c54:	ec06                	sd	ra,24(sp)
    80000c56:	e822                	sd	s0,16(sp)
    80000c58:	1000                	addi	s0,sp,32
    80000c5a:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c5e:	00013797          	auipc	a5,0x13
    80000c62:	5ba78793          	addi	a5,a5,1466 # 80014218 <pr>
    80000c66:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000c6a:	0000a517          	auipc	a0,0xa
    80000c6e:	3b650513          	addi	a0,a0,950 # 8000b020 <etext+0x20>
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	d8a080e7          	jalr	-630(ra) # 800009fc <printf>
  printf(s);
    80000c7a:	fe843503          	ld	a0,-24(s0)
    80000c7e:	00000097          	auipc	ra,0x0
    80000c82:	d7e080e7          	jalr	-642(ra) # 800009fc <printf>
  printf("\n");
    80000c86:	0000a517          	auipc	a0,0xa
    80000c8a:	3a250513          	addi	a0,a0,930 # 8000b028 <etext+0x28>
    80000c8e:	00000097          	auipc	ra,0x0
    80000c92:	d6e080e7          	jalr	-658(ra) # 800009fc <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000c96:	0000b797          	auipc	a5,0xb
    80000c9a:	36a78793          	addi	a5,a5,874 # 8000c000 <panicked>
    80000c9e:	4705                	li	a4,1
    80000ca0:	c398                	sw	a4,0(a5)
  for(;;)
    80000ca2:	a001                	j	80000ca2 <panic+0x50>

0000000080000ca4 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000ca4:	1141                	addi	sp,sp,-16
    80000ca6:	e406                	sd	ra,8(sp)
    80000ca8:	e022                	sd	s0,0(sp)
    80000caa:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000cac:	0000a597          	auipc	a1,0xa
    80000cb0:	38458593          	addi	a1,a1,900 # 8000b030 <etext+0x30>
    80000cb4:	00013517          	auipc	a0,0x13
    80000cb8:	56450513          	addi	a0,a0,1380 # 80014218 <pr>
    80000cbc:	00000097          	auipc	ra,0x0
    80000cc0:	594080e7          	jalr	1428(ra) # 80001250 <initlock>
  pr.locking = 1;
    80000cc4:	00013797          	auipc	a5,0x13
    80000cc8:	55478793          	addi	a5,a5,1364 # 80014218 <pr>
    80000ccc:	4705                	li	a4,1
    80000cce:	cf98                	sw	a4,24(a5)
}
    80000cd0:	0001                	nop
    80000cd2:	60a2                	ld	ra,8(sp)
    80000cd4:	6402                	ld	s0,0(sp)
    80000cd6:	0141                	addi	sp,sp,16
    80000cd8:	8082                	ret

0000000080000cda <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000cda:	1141                	addi	sp,sp,-16
    80000cdc:	e406                	sd	ra,8(sp)
    80000cde:	e022                	sd	s0,0(sp)
    80000ce0:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000ce2:	100007b7          	lui	a5,0x10000
    80000ce6:	0785                	addi	a5,a5,1
    80000ce8:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000cec:	100007b7          	lui	a5,0x10000
    80000cf0:	078d                	addi	a5,a5,3
    80000cf2:	f8000713          	li	a4,-128
    80000cf6:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000cfa:	100007b7          	lui	a5,0x10000
    80000cfe:	470d                	li	a4,3
    80000d00:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000d04:	100007b7          	lui	a5,0x10000
    80000d08:	0785                	addi	a5,a5,1
    80000d0a:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000d0e:	100007b7          	lui	a5,0x10000
    80000d12:	078d                	addi	a5,a5,3
    80000d14:	470d                	li	a4,3
    80000d16:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000d1a:	100007b7          	lui	a5,0x10000
    80000d1e:	0789                	addi	a5,a5,2
    80000d20:	471d                	li	a4,7
    80000d22:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000d26:	100007b7          	lui	a5,0x10000
    80000d2a:	0785                	addi	a5,a5,1
    80000d2c:	470d                	li	a4,3
    80000d2e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  initlock(&uart_tx_lock, "uart");
    80000d32:	0000a597          	auipc	a1,0xa
    80000d36:	30658593          	addi	a1,a1,774 # 8000b038 <etext+0x38>
    80000d3a:	00013517          	auipc	a0,0x13
    80000d3e:	4fe50513          	addi	a0,a0,1278 # 80014238 <uart_tx_lock>
    80000d42:	00000097          	auipc	ra,0x0
    80000d46:	50e080e7          	jalr	1294(ra) # 80001250 <initlock>
}
    80000d4a:	0001                	nop
    80000d4c:	60a2                	ld	ra,8(sp)
    80000d4e:	6402                	ld	s0,0(sp)
    80000d50:	0141                	addi	sp,sp,16
    80000d52:	8082                	ret

0000000080000d54 <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000d54:	1101                	addi	sp,sp,-32
    80000d56:	ec06                	sd	ra,24(sp)
    80000d58:	e822                	sd	s0,16(sp)
    80000d5a:	1000                	addi	s0,sp,32
    80000d5c:	87aa                	mv	a5,a0
    80000d5e:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000d62:	00013517          	auipc	a0,0x13
    80000d66:	4d650513          	addi	a0,a0,1238 # 80014238 <uart_tx_lock>
    80000d6a:	00000097          	auipc	ra,0x0
    80000d6e:	516080e7          	jalr	1302(ra) # 80001280 <acquire>

  if(panicked){
    80000d72:	0000b797          	auipc	a5,0xb
    80000d76:	28e78793          	addi	a5,a5,654 # 8000c000 <panicked>
    80000d7a:	439c                	lw	a5,0(a5)
    80000d7c:	2781                	sext.w	a5,a5
    80000d7e:	c391                	beqz	a5,80000d82 <uartputc+0x2e>
    for(;;)
    80000d80:	a001                	j	80000d80 <uartputc+0x2c>
      ;
  }

  while(1){
    if(((uart_tx_w + 1) % UART_TX_BUF_SIZE) == uart_tx_r){
    80000d82:	0000b797          	auipc	a5,0xb
    80000d86:	28278793          	addi	a5,a5,642 # 8000c004 <uart_tx_w>
    80000d8a:	439c                	lw	a5,0(a5)
    80000d8c:	2785                	addiw	a5,a5,1
    80000d8e:	2781                	sext.w	a5,a5
    80000d90:	873e                	mv	a4,a5
    80000d92:	41f7579b          	sraiw	a5,a4,0x1f
    80000d96:	01b7d79b          	srliw	a5,a5,0x1b
    80000d9a:	9f3d                	addw	a4,a4,a5
    80000d9c:	8b7d                	andi	a4,a4,31
    80000d9e:	40f707bb          	subw	a5,a4,a5
    80000da2:	0007871b          	sext.w	a4,a5
    80000da6:	0000b797          	auipc	a5,0xb
    80000daa:	26278793          	addi	a5,a5,610 # 8000c008 <uart_tx_r>
    80000dae:	439c                	lw	a5,0(a5)
    80000db0:	00f71f63          	bne	a4,a5,80000dce <uartputc+0x7a>
      // buffer is full.
      // wait for uartstart() to open up space in the buffer.
      sleep(&uart_tx_r, &uart_tx_lock);
    80000db4:	00013597          	auipc	a1,0x13
    80000db8:	48458593          	addi	a1,a1,1156 # 80014238 <uart_tx_lock>
    80000dbc:	0000b517          	auipc	a0,0xb
    80000dc0:	24c50513          	addi	a0,a0,588 # 8000c008 <uart_tx_r>
    80000dc4:	00002097          	auipc	ra,0x2
    80000dc8:	780080e7          	jalr	1920(ra) # 80003544 <sleep>
    80000dcc:	bf5d                	j	80000d82 <uartputc+0x2e>
    } else {
      uart_tx_buf[uart_tx_w] = c;
    80000dce:	0000b797          	auipc	a5,0xb
    80000dd2:	23678793          	addi	a5,a5,566 # 8000c004 <uart_tx_w>
    80000dd6:	439c                	lw	a5,0(a5)
    80000dd8:	fec42703          	lw	a4,-20(s0)
    80000ddc:	0ff77713          	andi	a4,a4,255
    80000de0:	00013697          	auipc	a3,0x13
    80000de4:	47068693          	addi	a3,a3,1136 # 80014250 <uart_tx_buf>
    80000de8:	97b6                	add	a5,a5,a3
    80000dea:	00e78023          	sb	a4,0(a5)
      uart_tx_w = (uart_tx_w + 1) % UART_TX_BUF_SIZE;
    80000dee:	0000b797          	auipc	a5,0xb
    80000df2:	21678793          	addi	a5,a5,534 # 8000c004 <uart_tx_w>
    80000df6:	439c                	lw	a5,0(a5)
    80000df8:	2785                	addiw	a5,a5,1
    80000dfa:	2781                	sext.w	a5,a5
    80000dfc:	873e                	mv	a4,a5
    80000dfe:	41f7579b          	sraiw	a5,a4,0x1f
    80000e02:	01b7d79b          	srliw	a5,a5,0x1b
    80000e06:	9f3d                	addw	a4,a4,a5
    80000e08:	8b7d                	andi	a4,a4,31
    80000e0a:	40f707bb          	subw	a5,a4,a5
    80000e0e:	0007871b          	sext.w	a4,a5
    80000e12:	0000b797          	auipc	a5,0xb
    80000e16:	1f278793          	addi	a5,a5,498 # 8000c004 <uart_tx_w>
    80000e1a:	c398                	sw	a4,0(a5)
      uartstart();
    80000e1c:	00000097          	auipc	ra,0x0
    80000e20:	084080e7          	jalr	132(ra) # 80000ea0 <uartstart>
      release(&uart_tx_lock);
    80000e24:	00013517          	auipc	a0,0x13
    80000e28:	41450513          	addi	a0,a0,1044 # 80014238 <uart_tx_lock>
    80000e2c:	00000097          	auipc	ra,0x0
    80000e30:	4b8080e7          	jalr	1208(ra) # 800012e4 <release>
      return;
    80000e34:	0001                	nop
    }
  }
}
    80000e36:	60e2                	ld	ra,24(sp)
    80000e38:	6442                	ld	s0,16(sp)
    80000e3a:	6105                	addi	sp,sp,32
    80000e3c:	8082                	ret

0000000080000e3e <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000e3e:	1101                	addi	sp,sp,-32
    80000e40:	ec06                	sd	ra,24(sp)
    80000e42:	e822                	sd	s0,16(sp)
    80000e44:	1000                	addi	s0,sp,32
    80000e46:	87aa                	mv	a5,a0
    80000e48:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000e4c:	00000097          	auipc	ra,0x0
    80000e50:	532080e7          	jalr	1330(ra) # 8000137e <push_off>

  if(panicked){
    80000e54:	0000b797          	auipc	a5,0xb
    80000e58:	1ac78793          	addi	a5,a5,428 # 8000c000 <panicked>
    80000e5c:	439c                	lw	a5,0(a5)
    80000e5e:	2781                	sext.w	a5,a5
    80000e60:	c391                	beqz	a5,80000e64 <uartputc_sync+0x26>
    for(;;)
    80000e62:	a001                	j	80000e62 <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000e64:	0001                	nop
    80000e66:	100007b7          	lui	a5,0x10000
    80000e6a:	0795                	addi	a5,a5,5
    80000e6c:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000e70:	0ff7f793          	andi	a5,a5,255
    80000e74:	2781                	sext.w	a5,a5
    80000e76:	0207f793          	andi	a5,a5,32
    80000e7a:	2781                	sext.w	a5,a5
    80000e7c:	d7ed                	beqz	a5,80000e66 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80000e7e:	100007b7          	lui	a5,0x10000
    80000e82:	fec42703          	lw	a4,-20(s0)
    80000e86:	0ff77713          	andi	a4,a4,255
    80000e8a:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000e8e:	00000097          	auipc	ra,0x0
    80000e92:	548080e7          	jalr	1352(ra) # 800013d6 <pop_off>
}
    80000e96:	0001                	nop
    80000e98:	60e2                	ld	ra,24(sp)
    80000e9a:	6442                	ld	s0,16(sp)
    80000e9c:	6105                	addi	sp,sp,32
    80000e9e:	8082                	ret

0000000080000ea0 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000ea0:	1101                	addi	sp,sp,-32
    80000ea2:	ec06                	sd	ra,24(sp)
    80000ea4:	e822                	sd	s0,16(sp)
    80000ea6:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000ea8:	0000b797          	auipc	a5,0xb
    80000eac:	15c78793          	addi	a5,a5,348 # 8000c004 <uart_tx_w>
    80000eb0:	4398                	lw	a4,0(a5)
    80000eb2:	0000b797          	auipc	a5,0xb
    80000eb6:	15678793          	addi	a5,a5,342 # 8000c008 <uart_tx_r>
    80000eba:	439c                	lw	a5,0(a5)
    80000ebc:	08f70463          	beq	a4,a5,80000f44 <uartstart+0xa4>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000ec0:	100007b7          	lui	a5,0x10000
    80000ec4:	0795                	addi	a5,a5,5
    80000ec6:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000eca:	0ff7f793          	andi	a5,a5,255
    80000ece:	2781                	sext.w	a5,a5
    80000ed0:	0207f793          	andi	a5,a5,32
    80000ed4:	2781                	sext.w	a5,a5
    80000ed6:	cbad                	beqz	a5,80000f48 <uartstart+0xa8>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r];
    80000ed8:	0000b797          	auipc	a5,0xb
    80000edc:	13078793          	addi	a5,a5,304 # 8000c008 <uart_tx_r>
    80000ee0:	439c                	lw	a5,0(a5)
    80000ee2:	00013717          	auipc	a4,0x13
    80000ee6:	36e70713          	addi	a4,a4,878 # 80014250 <uart_tx_buf>
    80000eea:	97ba                	add	a5,a5,a4
    80000eec:	0007c783          	lbu	a5,0(a5)
    80000ef0:	fef42623          	sw	a5,-20(s0)
    uart_tx_r = (uart_tx_r + 1) % UART_TX_BUF_SIZE;
    80000ef4:	0000b797          	auipc	a5,0xb
    80000ef8:	11478793          	addi	a5,a5,276 # 8000c008 <uart_tx_r>
    80000efc:	439c                	lw	a5,0(a5)
    80000efe:	2785                	addiw	a5,a5,1
    80000f00:	2781                	sext.w	a5,a5
    80000f02:	873e                	mv	a4,a5
    80000f04:	41f7579b          	sraiw	a5,a4,0x1f
    80000f08:	01b7d79b          	srliw	a5,a5,0x1b
    80000f0c:	9f3d                	addw	a4,a4,a5
    80000f0e:	8b7d                	andi	a4,a4,31
    80000f10:	40f707bb          	subw	a5,a4,a5
    80000f14:	0007871b          	sext.w	a4,a5
    80000f18:	0000b797          	auipc	a5,0xb
    80000f1c:	0f078793          	addi	a5,a5,240 # 8000c008 <uart_tx_r>
    80000f20:	c398                	sw	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000f22:	0000b517          	auipc	a0,0xb
    80000f26:	0e650513          	addi	a0,a0,230 # 8000c008 <uart_tx_r>
    80000f2a:	00002097          	auipc	ra,0x2
    80000f2e:	6ae080e7          	jalr	1710(ra) # 800035d8 <wakeup>
    
    WriteReg(THR, c);
    80000f32:	100007b7          	lui	a5,0x10000
    80000f36:	fec42703          	lw	a4,-20(s0)
    80000f3a:	0ff77713          	andi	a4,a4,255
    80000f3e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000f42:	b79d                	j	80000ea8 <uartstart+0x8>
      return;
    80000f44:	0001                	nop
    80000f46:	a011                	j	80000f4a <uartstart+0xaa>
      return;
    80000f48:	0001                	nop
  }
}
    80000f4a:	60e2                	ld	ra,24(sp)
    80000f4c:	6442                	ld	s0,16(sp)
    80000f4e:	6105                	addi	sp,sp,32
    80000f50:	8082                	ret

0000000080000f52 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000f52:	1141                	addi	sp,sp,-16
    80000f54:	e422                	sd	s0,8(sp)
    80000f56:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000f58:	100007b7          	lui	a5,0x10000
    80000f5c:	0795                	addi	a5,a5,5
    80000f5e:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f62:	0ff7f793          	andi	a5,a5,255
    80000f66:	2781                	sext.w	a5,a5
    80000f68:	8b85                	andi	a5,a5,1
    80000f6a:	2781                	sext.w	a5,a5
    80000f6c:	cb89                	beqz	a5,80000f7e <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80000f6e:	100007b7          	lui	a5,0x10000
    80000f72:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f76:	0ff7f793          	andi	a5,a5,255
    80000f7a:	2781                	sext.w	a5,a5
    80000f7c:	a011                	j	80000f80 <uartgetc+0x2e>
  } else {
    return -1;
    80000f7e:	57fd                	li	a5,-1
  }
}
    80000f80:	853e                	mv	a0,a5
    80000f82:	6422                	ld	s0,8(sp)
    80000f84:	0141                	addi	sp,sp,16
    80000f86:	8082                	ret

0000000080000f88 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000f88:	1101                	addi	sp,sp,-32
    80000f8a:	ec06                	sd	ra,24(sp)
    80000f8c:	e822                	sd	s0,16(sp)
    80000f8e:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    80000f90:	00000097          	auipc	ra,0x0
    80000f94:	fc2080e7          	jalr	-62(ra) # 80000f52 <uartgetc>
    80000f98:	87aa                	mv	a5,a0
    80000f9a:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80000f9e:	fec42783          	lw	a5,-20(s0)
    80000fa2:	0007871b          	sext.w	a4,a5
    80000fa6:	57fd                	li	a5,-1
    80000fa8:	00f70a63          	beq	a4,a5,80000fbc <uartintr+0x34>
      break;
    consoleintr(c);
    80000fac:	fec42783          	lw	a5,-20(s0)
    80000fb0:	853e                	mv	a0,a5
    80000fb2:	fffff097          	auipc	ra,0xfffff
    80000fb6:	60c080e7          	jalr	1548(ra) # 800005be <consoleintr>
  while(1){
    80000fba:	bfd9                	j	80000f90 <uartintr+0x8>
      break;
    80000fbc:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000fbe:	00013517          	auipc	a0,0x13
    80000fc2:	27a50513          	addi	a0,a0,634 # 80014238 <uart_tx_lock>
    80000fc6:	00000097          	auipc	ra,0x0
    80000fca:	2ba080e7          	jalr	698(ra) # 80001280 <acquire>
  uartstart();
    80000fce:	00000097          	auipc	ra,0x0
    80000fd2:	ed2080e7          	jalr	-302(ra) # 80000ea0 <uartstart>
  release(&uart_tx_lock);
    80000fd6:	00013517          	auipc	a0,0x13
    80000fda:	26250513          	addi	a0,a0,610 # 80014238 <uart_tx_lock>
    80000fde:	00000097          	auipc	ra,0x0
    80000fe2:	306080e7          	jalr	774(ra) # 800012e4 <release>
}
    80000fe6:	0001                	nop
    80000fe8:	60e2                	ld	ra,24(sp)
    80000fea:	6442                	ld	s0,16(sp)
    80000fec:	6105                	addi	sp,sp,32
    80000fee:	8082                	ret

0000000080000ff0 <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    80000ff0:	1141                	addi	sp,sp,-16
    80000ff2:	e406                	sd	ra,8(sp)
    80000ff4:	e022                	sd	s0,0(sp)
    80000ff6:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000ff8:	0000a597          	auipc	a1,0xa
    80000ffc:	04858593          	addi	a1,a1,72 # 8000b040 <etext+0x40>
    80001000:	00013517          	auipc	a0,0x13
    80001004:	27050513          	addi	a0,a0,624 # 80014270 <kmem>
    80001008:	00000097          	auipc	ra,0x0
    8000100c:	248080e7          	jalr	584(ra) # 80001250 <initlock>
  freerange(end, (void*)PHYSTOP);
    80001010:	47c5                	li	a5,17
    80001012:	01b79593          	slli	a1,a5,0x1b
    80001016:	00071517          	auipc	a0,0x71
    8000101a:	fea50513          	addi	a0,a0,-22 # 80072000 <end>
    8000101e:	00000097          	auipc	ra,0x0
    80001022:	012080e7          	jalr	18(ra) # 80001030 <freerange>
}
    80001026:	0001                	nop
    80001028:	60a2                	ld	ra,8(sp)
    8000102a:	6402                	ld	s0,0(sp)
    8000102c:	0141                	addi	sp,sp,16
    8000102e:	8082                	ret

0000000080001030 <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    80001030:	7179                	addi	sp,sp,-48
    80001032:	f406                	sd	ra,40(sp)
    80001034:	f022                	sd	s0,32(sp)
    80001036:	1800                	addi	s0,sp,48
    80001038:	fca43c23          	sd	a0,-40(s0)
    8000103c:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    80001040:	fd843703          	ld	a4,-40(s0)
    80001044:	6785                	lui	a5,0x1
    80001046:	17fd                	addi	a5,a5,-1
    80001048:	973e                	add	a4,a4,a5
    8000104a:	77fd                	lui	a5,0xfffff
    8000104c:	8ff9                	and	a5,a5,a4
    8000104e:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001052:	a829                	j	8000106c <freerange+0x3c>
    kfree(p);
    80001054:	fe843503          	ld	a0,-24(s0)
    80001058:	00000097          	auipc	ra,0x0
    8000105c:	030080e7          	jalr	48(ra) # 80001088 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001060:	fe843703          	ld	a4,-24(s0)
    80001064:	6785                	lui	a5,0x1
    80001066:	97ba                	add	a5,a5,a4
    80001068:	fef43423          	sd	a5,-24(s0)
    8000106c:	fe843703          	ld	a4,-24(s0)
    80001070:	6785                	lui	a5,0x1
    80001072:	97ba                	add	a5,a5,a4
    80001074:	fd043703          	ld	a4,-48(s0)
    80001078:	fcf77ee3          	bgeu	a4,a5,80001054 <freerange+0x24>
}
    8000107c:	0001                	nop
    8000107e:	0001                	nop
    80001080:	70a2                	ld	ra,40(sp)
    80001082:	7402                	ld	s0,32(sp)
    80001084:	6145                	addi	sp,sp,48
    80001086:	8082                	ret

0000000080001088 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001088:	7179                	addi	sp,sp,-48
    8000108a:	f406                	sd	ra,40(sp)
    8000108c:	f022                	sd	s0,32(sp)
    8000108e:	1800                	addi	s0,sp,48
    80001090:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80001094:	fd843703          	ld	a4,-40(s0)
    80001098:	6785                	lui	a5,0x1
    8000109a:	17fd                	addi	a5,a5,-1
    8000109c:	8ff9                	and	a5,a5,a4
    8000109e:	ef99                	bnez	a5,800010bc <kfree+0x34>
    800010a0:	fd843703          	ld	a4,-40(s0)
    800010a4:	00071797          	auipc	a5,0x71
    800010a8:	f5c78793          	addi	a5,a5,-164 # 80072000 <end>
    800010ac:	00f76863          	bltu	a4,a5,800010bc <kfree+0x34>
    800010b0:	fd843703          	ld	a4,-40(s0)
    800010b4:	47c5                	li	a5,17
    800010b6:	07ee                	slli	a5,a5,0x1b
    800010b8:	00f76a63          	bltu	a4,a5,800010cc <kfree+0x44>
    panic("kfree");
    800010bc:	0000a517          	auipc	a0,0xa
    800010c0:	f8c50513          	addi	a0,a0,-116 # 8000b048 <etext+0x48>
    800010c4:	00000097          	auipc	ra,0x0
    800010c8:	b8e080e7          	jalr	-1138(ra) # 80000c52 <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800010cc:	6605                	lui	a2,0x1
    800010ce:	4585                	li	a1,1
    800010d0:	fd843503          	ld	a0,-40(s0)
    800010d4:	00000097          	auipc	ra,0x0
    800010d8:	380080e7          	jalr	896(ra) # 80001454 <memset>

  r = (struct run*)pa;
    800010dc:	fd843783          	ld	a5,-40(s0)
    800010e0:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    800010e4:	00013517          	auipc	a0,0x13
    800010e8:	18c50513          	addi	a0,a0,396 # 80014270 <kmem>
    800010ec:	00000097          	auipc	ra,0x0
    800010f0:	194080e7          	jalr	404(ra) # 80001280 <acquire>
  r->next = kmem.freelist;
    800010f4:	00013797          	auipc	a5,0x13
    800010f8:	17c78793          	addi	a5,a5,380 # 80014270 <kmem>
    800010fc:	6f98                	ld	a4,24(a5)
    800010fe:	fe843783          	ld	a5,-24(s0)
    80001102:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    80001104:	00013797          	auipc	a5,0x13
    80001108:	16c78793          	addi	a5,a5,364 # 80014270 <kmem>
    8000110c:	fe843703          	ld	a4,-24(s0)
    80001110:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001112:	00013517          	auipc	a0,0x13
    80001116:	15e50513          	addi	a0,a0,350 # 80014270 <kmem>
    8000111a:	00000097          	auipc	ra,0x0
    8000111e:	1ca080e7          	jalr	458(ra) # 800012e4 <release>
}
    80001122:	0001                	nop
    80001124:	70a2                	ld	ra,40(sp)
    80001126:	7402                	ld	s0,32(sp)
    80001128:	6145                	addi	sp,sp,48
    8000112a:	8082                	ret

000000008000112c <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000112c:	1101                	addi	sp,sp,-32
    8000112e:	ec06                	sd	ra,24(sp)
    80001130:	e822                	sd	s0,16(sp)
    80001132:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80001134:	00013517          	auipc	a0,0x13
    80001138:	13c50513          	addi	a0,a0,316 # 80014270 <kmem>
    8000113c:	00000097          	auipc	ra,0x0
    80001140:	144080e7          	jalr	324(ra) # 80001280 <acquire>
  r = kmem.freelist;
    80001144:	00013797          	auipc	a5,0x13
    80001148:	12c78793          	addi	a5,a5,300 # 80014270 <kmem>
    8000114c:	6f9c                	ld	a5,24(a5)
    8000114e:	fef43423          	sd	a5,-24(s0)
  if(r)
    80001152:	fe843783          	ld	a5,-24(s0)
    80001156:	cb89                	beqz	a5,80001168 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001158:	fe843783          	ld	a5,-24(s0)
    8000115c:	6398                	ld	a4,0(a5)
    8000115e:	00013797          	auipc	a5,0x13
    80001162:	11278793          	addi	a5,a5,274 # 80014270 <kmem>
    80001166:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001168:	00013517          	auipc	a0,0x13
    8000116c:	10850513          	addi	a0,a0,264 # 80014270 <kmem>
    80001170:	00000097          	auipc	ra,0x0
    80001174:	174080e7          	jalr	372(ra) # 800012e4 <release>

  if(r)
    80001178:	fe843783          	ld	a5,-24(s0)
    8000117c:	cb89                	beqz	a5,8000118e <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000117e:	6605                	lui	a2,0x1
    80001180:	4595                	li	a1,5
    80001182:	fe843503          	ld	a0,-24(s0)
    80001186:	00000097          	auipc	ra,0x0
    8000118a:	2ce080e7          	jalr	718(ra) # 80001454 <memset>
  return (void*)r;
    8000118e:	fe843783          	ld	a5,-24(s0)
}
    80001192:	853e                	mv	a0,a5
    80001194:	60e2                	ld	ra,24(sp)
    80001196:	6442                	ld	s0,16(sp)
    80001198:	6105                	addi	sp,sp,32
    8000119a:	8082                	ret

000000008000119c <r_sstatus>:
{
    8000119c:	1101                	addi	sp,sp,-32
    8000119e:	ec22                	sd	s0,24(sp)
    800011a0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800011a2:	100027f3          	csrr	a5,sstatus
    800011a6:	fef43423          	sd	a5,-24(s0)
  return x;
    800011aa:	fe843783          	ld	a5,-24(s0)
}
    800011ae:	853e                	mv	a0,a5
    800011b0:	6462                	ld	s0,24(sp)
    800011b2:	6105                	addi	sp,sp,32
    800011b4:	8082                	ret

00000000800011b6 <w_sstatus>:
{
    800011b6:	1101                	addi	sp,sp,-32
    800011b8:	ec22                	sd	s0,24(sp)
    800011ba:	1000                	addi	s0,sp,32
    800011bc:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800011c0:	fe843783          	ld	a5,-24(s0)
    800011c4:	10079073          	csrw	sstatus,a5
}
    800011c8:	0001                	nop
    800011ca:	6462                	ld	s0,24(sp)
    800011cc:	6105                	addi	sp,sp,32
    800011ce:	8082                	ret

00000000800011d0 <intr_on>:
{
    800011d0:	1141                	addi	sp,sp,-16
    800011d2:	e406                	sd	ra,8(sp)
    800011d4:	e022                	sd	s0,0(sp)
    800011d6:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800011d8:	00000097          	auipc	ra,0x0
    800011dc:	fc4080e7          	jalr	-60(ra) # 8000119c <r_sstatus>
    800011e0:	87aa                	mv	a5,a0
    800011e2:	0027e793          	ori	a5,a5,2
    800011e6:	853e                	mv	a0,a5
    800011e8:	00000097          	auipc	ra,0x0
    800011ec:	fce080e7          	jalr	-50(ra) # 800011b6 <w_sstatus>
}
    800011f0:	0001                	nop
    800011f2:	60a2                	ld	ra,8(sp)
    800011f4:	6402                	ld	s0,0(sp)
    800011f6:	0141                	addi	sp,sp,16
    800011f8:	8082                	ret

00000000800011fa <intr_off>:
{
    800011fa:	1141                	addi	sp,sp,-16
    800011fc:	e406                	sd	ra,8(sp)
    800011fe:	e022                	sd	s0,0(sp)
    80001200:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001202:	00000097          	auipc	ra,0x0
    80001206:	f9a080e7          	jalr	-102(ra) # 8000119c <r_sstatus>
    8000120a:	87aa                	mv	a5,a0
    8000120c:	9bf5                	andi	a5,a5,-3
    8000120e:	853e                	mv	a0,a5
    80001210:	00000097          	auipc	ra,0x0
    80001214:	fa6080e7          	jalr	-90(ra) # 800011b6 <w_sstatus>
}
    80001218:	0001                	nop
    8000121a:	60a2                	ld	ra,8(sp)
    8000121c:	6402                	ld	s0,0(sp)
    8000121e:	0141                	addi	sp,sp,16
    80001220:	8082                	ret

0000000080001222 <intr_get>:
{
    80001222:	1101                	addi	sp,sp,-32
    80001224:	ec06                	sd	ra,24(sp)
    80001226:	e822                	sd	s0,16(sp)
    80001228:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    8000122a:	00000097          	auipc	ra,0x0
    8000122e:	f72080e7          	jalr	-142(ra) # 8000119c <r_sstatus>
    80001232:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80001236:	fe843783          	ld	a5,-24(s0)
    8000123a:	8b89                	andi	a5,a5,2
    8000123c:	00f037b3          	snez	a5,a5
    80001240:	0ff7f793          	andi	a5,a5,255
    80001244:	2781                	sext.w	a5,a5
}
    80001246:	853e                	mv	a0,a5
    80001248:	60e2                	ld	ra,24(sp)
    8000124a:	6442                	ld	s0,16(sp)
    8000124c:	6105                	addi	sp,sp,32
    8000124e:	8082                	ret

0000000080001250 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80001250:	1101                	addi	sp,sp,-32
    80001252:	ec22                	sd	s0,24(sp)
    80001254:	1000                	addi	s0,sp,32
    80001256:	fea43423          	sd	a0,-24(s0)
    8000125a:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    8000125e:	fe843783          	ld	a5,-24(s0)
    80001262:	fe043703          	ld	a4,-32(s0)
    80001266:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001268:	fe843783          	ld	a5,-24(s0)
    8000126c:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    80001270:	fe843783          	ld	a5,-24(s0)
    80001274:	0007b823          	sd	zero,16(a5)
}
    80001278:	0001                	nop
    8000127a:	6462                	ld	s0,24(sp)
    8000127c:	6105                	addi	sp,sp,32
    8000127e:	8082                	ret

0000000080001280 <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    80001280:	1101                	addi	sp,sp,-32
    80001282:	ec06                	sd	ra,24(sp)
    80001284:	e822                	sd	s0,16(sp)
    80001286:	1000                	addi	s0,sp,32
    80001288:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    8000128c:	00000097          	auipc	ra,0x0
    80001290:	0f2080e7          	jalr	242(ra) # 8000137e <push_off>
  if(holding(lk))
    80001294:	fe843503          	ld	a0,-24(s0)
    80001298:	00000097          	auipc	ra,0x0
    8000129c:	0a2080e7          	jalr	162(ra) # 8000133a <holding>
    800012a0:	87aa                	mv	a5,a0
    800012a2:	cb89                	beqz	a5,800012b4 <acquire+0x34>
    panic("acquire");
    800012a4:	0000a517          	auipc	a0,0xa
    800012a8:	dac50513          	addi	a0,a0,-596 # 8000b050 <etext+0x50>
    800012ac:	00000097          	auipc	ra,0x0
    800012b0:	9a6080e7          	jalr	-1626(ra) # 80000c52 <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800012b4:	0001                	nop
    800012b6:	fe843783          	ld	a5,-24(s0)
    800012ba:	4705                	li	a4,1
    800012bc:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    800012c0:	0007079b          	sext.w	a5,a4
    800012c4:	fbed                	bnez	a5,800012b6 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800012c6:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    800012ca:	00001097          	auipc	ra,0x1
    800012ce:	4f4080e7          	jalr	1268(ra) # 800027be <mycpu>
    800012d2:	872a                	mv	a4,a0
    800012d4:	fe843783          	ld	a5,-24(s0)
    800012d8:	eb98                	sd	a4,16(a5)
}
    800012da:	0001                	nop
    800012dc:	60e2                	ld	ra,24(sp)
    800012de:	6442                	ld	s0,16(sp)
    800012e0:	6105                	addi	sp,sp,32
    800012e2:	8082                	ret

00000000800012e4 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    800012e4:	1101                	addi	sp,sp,-32
    800012e6:	ec06                	sd	ra,24(sp)
    800012e8:	e822                	sd	s0,16(sp)
    800012ea:	1000                	addi	s0,sp,32
    800012ec:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800012f0:	fe843503          	ld	a0,-24(s0)
    800012f4:	00000097          	auipc	ra,0x0
    800012f8:	046080e7          	jalr	70(ra) # 8000133a <holding>
    800012fc:	87aa                	mv	a5,a0
    800012fe:	eb89                	bnez	a5,80001310 <release+0x2c>
    panic("release");
    80001300:	0000a517          	auipc	a0,0xa
    80001304:	d5850513          	addi	a0,a0,-680 # 8000b058 <etext+0x58>
    80001308:	00000097          	auipc	ra,0x0
    8000130c:	94a080e7          	jalr	-1718(ra) # 80000c52 <panic>

  lk->cpu = 0;
    80001310:	fe843783          	ld	a5,-24(s0)
    80001314:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001318:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    8000131c:	fe843783          	ld	a5,-24(s0)
    80001320:	0f50000f          	fence	iorw,ow
    80001324:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    80001328:	00000097          	auipc	ra,0x0
    8000132c:	0ae080e7          	jalr	174(ra) # 800013d6 <pop_off>
}
    80001330:	0001                	nop
    80001332:	60e2                	ld	ra,24(sp)
    80001334:	6442                	ld	s0,16(sp)
    80001336:	6105                	addi	sp,sp,32
    80001338:	8082                	ret

000000008000133a <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    8000133a:	7139                	addi	sp,sp,-64
    8000133c:	fc06                	sd	ra,56(sp)
    8000133e:	f822                	sd	s0,48(sp)
    80001340:	f426                	sd	s1,40(sp)
    80001342:	0080                	addi	s0,sp,64
    80001344:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80001348:	fc843783          	ld	a5,-56(s0)
    8000134c:	439c                	lw	a5,0(a5)
    8000134e:	cf89                	beqz	a5,80001368 <holding+0x2e>
    80001350:	fc843783          	ld	a5,-56(s0)
    80001354:	6b84                	ld	s1,16(a5)
    80001356:	00001097          	auipc	ra,0x1
    8000135a:	468080e7          	jalr	1128(ra) # 800027be <mycpu>
    8000135e:	87aa                	mv	a5,a0
    80001360:	00f49463          	bne	s1,a5,80001368 <holding+0x2e>
    80001364:	4785                	li	a5,1
    80001366:	a011                	j	8000136a <holding+0x30>
    80001368:	4781                	li	a5,0
    8000136a:	fcf42e23          	sw	a5,-36(s0)
  return r;
    8000136e:	fdc42783          	lw	a5,-36(s0)
}
    80001372:	853e                	mv	a0,a5
    80001374:	70e2                	ld	ra,56(sp)
    80001376:	7442                	ld	s0,48(sp)
    80001378:	74a2                	ld	s1,40(sp)
    8000137a:	6121                	addi	sp,sp,64
    8000137c:	8082                	ret

000000008000137e <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000137e:	1101                	addi	sp,sp,-32
    80001380:	ec06                	sd	ra,24(sp)
    80001382:	e822                	sd	s0,16(sp)
    80001384:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001386:	00000097          	auipc	ra,0x0
    8000138a:	e9c080e7          	jalr	-356(ra) # 80001222 <intr_get>
    8000138e:	87aa                	mv	a5,a0
    80001390:	fef42623          	sw	a5,-20(s0)

  intr_off();
    80001394:	00000097          	auipc	ra,0x0
    80001398:	e66080e7          	jalr	-410(ra) # 800011fa <intr_off>
  if(mycpu()->noff == 0)
    8000139c:	00001097          	auipc	ra,0x1
    800013a0:	422080e7          	jalr	1058(ra) # 800027be <mycpu>
    800013a4:	87aa                	mv	a5,a0
    800013a6:	5fbc                	lw	a5,120(a5)
    800013a8:	eb89                	bnez	a5,800013ba <push_off+0x3c>
    mycpu()->intena = old;
    800013aa:	00001097          	auipc	ra,0x1
    800013ae:	414080e7          	jalr	1044(ra) # 800027be <mycpu>
    800013b2:	872a                	mv	a4,a0
    800013b4:	fec42783          	lw	a5,-20(s0)
    800013b8:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    800013ba:	00001097          	auipc	ra,0x1
    800013be:	404080e7          	jalr	1028(ra) # 800027be <mycpu>
    800013c2:	87aa                	mv	a5,a0
    800013c4:	5fb8                	lw	a4,120(a5)
    800013c6:	2705                	addiw	a4,a4,1
    800013c8:	2701                	sext.w	a4,a4
    800013ca:	dfb8                	sw	a4,120(a5)
}
    800013cc:	0001                	nop
    800013ce:	60e2                	ld	ra,24(sp)
    800013d0:	6442                	ld	s0,16(sp)
    800013d2:	6105                	addi	sp,sp,32
    800013d4:	8082                	ret

00000000800013d6 <pop_off>:

void
pop_off(void)
{
    800013d6:	1101                	addi	sp,sp,-32
    800013d8:	ec06                	sd	ra,24(sp)
    800013da:	e822                	sd	s0,16(sp)
    800013dc:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    800013de:	00001097          	auipc	ra,0x1
    800013e2:	3e0080e7          	jalr	992(ra) # 800027be <mycpu>
    800013e6:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    800013ea:	00000097          	auipc	ra,0x0
    800013ee:	e38080e7          	jalr	-456(ra) # 80001222 <intr_get>
    800013f2:	87aa                	mv	a5,a0
    800013f4:	cb89                	beqz	a5,80001406 <pop_off+0x30>
    panic("pop_off - interruptible");
    800013f6:	0000a517          	auipc	a0,0xa
    800013fa:	c6a50513          	addi	a0,a0,-918 # 8000b060 <etext+0x60>
    800013fe:	00000097          	auipc	ra,0x0
    80001402:	854080e7          	jalr	-1964(ra) # 80000c52 <panic>
  if(c->noff < 1)
    80001406:	fe843783          	ld	a5,-24(s0)
    8000140a:	5fbc                	lw	a5,120(a5)
    8000140c:	00f04a63          	bgtz	a5,80001420 <pop_off+0x4a>
    panic("pop_off");
    80001410:	0000a517          	auipc	a0,0xa
    80001414:	c6850513          	addi	a0,a0,-920 # 8000b078 <etext+0x78>
    80001418:	00000097          	auipc	ra,0x0
    8000141c:	83a080e7          	jalr	-1990(ra) # 80000c52 <panic>
  c->noff -= 1;
    80001420:	fe843783          	ld	a5,-24(s0)
    80001424:	5fbc                	lw	a5,120(a5)
    80001426:	37fd                	addiw	a5,a5,-1
    80001428:	0007871b          	sext.w	a4,a5
    8000142c:	fe843783          	ld	a5,-24(s0)
    80001430:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    80001432:	fe843783          	ld	a5,-24(s0)
    80001436:	5fbc                	lw	a5,120(a5)
    80001438:	eb89                	bnez	a5,8000144a <pop_off+0x74>
    8000143a:	fe843783          	ld	a5,-24(s0)
    8000143e:	5ffc                	lw	a5,124(a5)
    80001440:	c789                	beqz	a5,8000144a <pop_off+0x74>
    intr_on();
    80001442:	00000097          	auipc	ra,0x0
    80001446:	d8e080e7          	jalr	-626(ra) # 800011d0 <intr_on>
}
    8000144a:	0001                	nop
    8000144c:	60e2                	ld	ra,24(sp)
    8000144e:	6442                	ld	s0,16(sp)
    80001450:	6105                	addi	sp,sp,32
    80001452:	8082                	ret

0000000080001454 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80001454:	7179                	addi	sp,sp,-48
    80001456:	f422                	sd	s0,40(sp)
    80001458:	1800                	addi	s0,sp,48
    8000145a:	fca43c23          	sd	a0,-40(s0)
    8000145e:	87ae                	mv	a5,a1
    80001460:	8732                	mv	a4,a2
    80001462:	fcf42a23          	sw	a5,-44(s0)
    80001466:	87ba                	mv	a5,a4
    80001468:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    8000146c:	fd843783          	ld	a5,-40(s0)
    80001470:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    80001474:	fe042623          	sw	zero,-20(s0)
    80001478:	a00d                	j	8000149a <memset+0x46>
    cdst[i] = c;
    8000147a:	fec42783          	lw	a5,-20(s0)
    8000147e:	fe043703          	ld	a4,-32(s0)
    80001482:	97ba                	add	a5,a5,a4
    80001484:	fd442703          	lw	a4,-44(s0)
    80001488:	0ff77713          	andi	a4,a4,255
    8000148c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    80001490:	fec42783          	lw	a5,-20(s0)
    80001494:	2785                	addiw	a5,a5,1
    80001496:	fef42623          	sw	a5,-20(s0)
    8000149a:	fec42703          	lw	a4,-20(s0)
    8000149e:	fd042783          	lw	a5,-48(s0)
    800014a2:	2781                	sext.w	a5,a5
    800014a4:	fcf76be3          	bltu	a4,a5,8000147a <memset+0x26>
  }
  return dst;
    800014a8:	fd843783          	ld	a5,-40(s0)
}
    800014ac:	853e                	mv	a0,a5
    800014ae:	7422                	ld	s0,40(sp)
    800014b0:	6145                	addi	sp,sp,48
    800014b2:	8082                	ret

00000000800014b4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800014b4:	7139                	addi	sp,sp,-64
    800014b6:	fc22                	sd	s0,56(sp)
    800014b8:	0080                	addi	s0,sp,64
    800014ba:	fca43c23          	sd	a0,-40(s0)
    800014be:	fcb43823          	sd	a1,-48(s0)
    800014c2:	87b2                	mv	a5,a2
    800014c4:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    800014c8:	fd843783          	ld	a5,-40(s0)
    800014cc:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    800014d0:	fd043783          	ld	a5,-48(s0)
    800014d4:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800014d8:	a0a1                	j	80001520 <memcmp+0x6c>
    if(*s1 != *s2)
    800014da:	fe843783          	ld	a5,-24(s0)
    800014de:	0007c703          	lbu	a4,0(a5)
    800014e2:	fe043783          	ld	a5,-32(s0)
    800014e6:	0007c783          	lbu	a5,0(a5)
    800014ea:	02f70163          	beq	a4,a5,8000150c <memcmp+0x58>
      return *s1 - *s2;
    800014ee:	fe843783          	ld	a5,-24(s0)
    800014f2:	0007c783          	lbu	a5,0(a5)
    800014f6:	0007871b          	sext.w	a4,a5
    800014fa:	fe043783          	ld	a5,-32(s0)
    800014fe:	0007c783          	lbu	a5,0(a5)
    80001502:	2781                	sext.w	a5,a5
    80001504:	40f707bb          	subw	a5,a4,a5
    80001508:	2781                	sext.w	a5,a5
    8000150a:	a01d                	j	80001530 <memcmp+0x7c>
    s1++, s2++;
    8000150c:	fe843783          	ld	a5,-24(s0)
    80001510:	0785                	addi	a5,a5,1
    80001512:	fef43423          	sd	a5,-24(s0)
    80001516:	fe043783          	ld	a5,-32(s0)
    8000151a:	0785                	addi	a5,a5,1
    8000151c:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80001520:	fcc42783          	lw	a5,-52(s0)
    80001524:	fff7871b          	addiw	a4,a5,-1
    80001528:	fce42623          	sw	a4,-52(s0)
    8000152c:	f7dd                	bnez	a5,800014da <memcmp+0x26>
  }

  return 0;
    8000152e:	4781                	li	a5,0
}
    80001530:	853e                	mv	a0,a5
    80001532:	7462                	ld	s0,56(sp)
    80001534:	6121                	addi	sp,sp,64
    80001536:	8082                	ret

0000000080001538 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80001538:	7139                	addi	sp,sp,-64
    8000153a:	fc22                	sd	s0,56(sp)
    8000153c:	0080                	addi	s0,sp,64
    8000153e:	fca43c23          	sd	a0,-40(s0)
    80001542:	fcb43823          	sd	a1,-48(s0)
    80001546:	87b2                	mv	a5,a2
    80001548:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  s = src;
    8000154c:	fd043783          	ld	a5,-48(s0)
    80001550:	fef43423          	sd	a5,-24(s0)
  d = dst;
    80001554:	fd843783          	ld	a5,-40(s0)
    80001558:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    8000155c:	fe843703          	ld	a4,-24(s0)
    80001560:	fe043783          	ld	a5,-32(s0)
    80001564:	08f77463          	bgeu	a4,a5,800015ec <memmove+0xb4>
    80001568:	fcc46783          	lwu	a5,-52(s0)
    8000156c:	fe843703          	ld	a4,-24(s0)
    80001570:	97ba                	add	a5,a5,a4
    80001572:	fe043703          	ld	a4,-32(s0)
    80001576:	06f77b63          	bgeu	a4,a5,800015ec <memmove+0xb4>
    s += n;
    8000157a:	fcc46783          	lwu	a5,-52(s0)
    8000157e:	fe843703          	ld	a4,-24(s0)
    80001582:	97ba                	add	a5,a5,a4
    80001584:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001588:	fcc46783          	lwu	a5,-52(s0)
    8000158c:	fe043703          	ld	a4,-32(s0)
    80001590:	97ba                	add	a5,a5,a4
    80001592:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    80001596:	a01d                	j	800015bc <memmove+0x84>
      *--d = *--s;
    80001598:	fe843783          	ld	a5,-24(s0)
    8000159c:	17fd                	addi	a5,a5,-1
    8000159e:	fef43423          	sd	a5,-24(s0)
    800015a2:	fe043783          	ld	a5,-32(s0)
    800015a6:	17fd                	addi	a5,a5,-1
    800015a8:	fef43023          	sd	a5,-32(s0)
    800015ac:	fe843783          	ld	a5,-24(s0)
    800015b0:	0007c703          	lbu	a4,0(a5)
    800015b4:	fe043783          	ld	a5,-32(s0)
    800015b8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015bc:	fcc42783          	lw	a5,-52(s0)
    800015c0:	fff7871b          	addiw	a4,a5,-1
    800015c4:	fce42623          	sw	a4,-52(s0)
    800015c8:	fbe1                	bnez	a5,80001598 <memmove+0x60>
  if(s < d && s + n > d){
    800015ca:	a805                	j	800015fa <memmove+0xc2>
  } else
    while(n-- > 0)
      *d++ = *s++;
    800015cc:	fe843703          	ld	a4,-24(s0)
    800015d0:	00170793          	addi	a5,a4,1
    800015d4:	fef43423          	sd	a5,-24(s0)
    800015d8:	fe043783          	ld	a5,-32(s0)
    800015dc:	00178693          	addi	a3,a5,1
    800015e0:	fed43023          	sd	a3,-32(s0)
    800015e4:	00074703          	lbu	a4,0(a4)
    800015e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015ec:	fcc42783          	lw	a5,-52(s0)
    800015f0:	fff7871b          	addiw	a4,a5,-1
    800015f4:	fce42623          	sw	a4,-52(s0)
    800015f8:	fbf1                	bnez	a5,800015cc <memmove+0x94>

  return dst;
    800015fa:	fd843783          	ld	a5,-40(s0)
}
    800015fe:	853e                	mv	a0,a5
    80001600:	7462                	ld	s0,56(sp)
    80001602:	6121                	addi	sp,sp,64
    80001604:	8082                	ret

0000000080001606 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80001606:	7179                	addi	sp,sp,-48
    80001608:	f406                	sd	ra,40(sp)
    8000160a:	f022                	sd	s0,32(sp)
    8000160c:	1800                	addi	s0,sp,48
    8000160e:	fea43423          	sd	a0,-24(s0)
    80001612:	feb43023          	sd	a1,-32(s0)
    80001616:	87b2                	mv	a5,a2
    80001618:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    8000161c:	fdc42783          	lw	a5,-36(s0)
    80001620:	863e                	mv	a2,a5
    80001622:	fe043583          	ld	a1,-32(s0)
    80001626:	fe843503          	ld	a0,-24(s0)
    8000162a:	00000097          	auipc	ra,0x0
    8000162e:	f0e080e7          	jalr	-242(ra) # 80001538 <memmove>
    80001632:	87aa                	mv	a5,a0
}
    80001634:	853e                	mv	a0,a5
    80001636:	70a2                	ld	ra,40(sp)
    80001638:	7402                	ld	s0,32(sp)
    8000163a:	6145                	addi	sp,sp,48
    8000163c:	8082                	ret

000000008000163e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000163e:	7179                	addi	sp,sp,-48
    80001640:	f422                	sd	s0,40(sp)
    80001642:	1800                	addi	s0,sp,48
    80001644:	fea43423          	sd	a0,-24(s0)
    80001648:	feb43023          	sd	a1,-32(s0)
    8000164c:	87b2                	mv	a5,a2
    8000164e:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    80001652:	a005                	j	80001672 <strncmp+0x34>
    n--, p++, q++;
    80001654:	fdc42783          	lw	a5,-36(s0)
    80001658:	37fd                	addiw	a5,a5,-1
    8000165a:	fcf42e23          	sw	a5,-36(s0)
    8000165e:	fe843783          	ld	a5,-24(s0)
    80001662:	0785                	addi	a5,a5,1
    80001664:	fef43423          	sd	a5,-24(s0)
    80001668:	fe043783          	ld	a5,-32(s0)
    8000166c:	0785                	addi	a5,a5,1
    8000166e:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    80001672:	fdc42783          	lw	a5,-36(s0)
    80001676:	2781                	sext.w	a5,a5
    80001678:	c385                	beqz	a5,80001698 <strncmp+0x5a>
    8000167a:	fe843783          	ld	a5,-24(s0)
    8000167e:	0007c783          	lbu	a5,0(a5)
    80001682:	cb99                	beqz	a5,80001698 <strncmp+0x5a>
    80001684:	fe843783          	ld	a5,-24(s0)
    80001688:	0007c703          	lbu	a4,0(a5)
    8000168c:	fe043783          	ld	a5,-32(s0)
    80001690:	0007c783          	lbu	a5,0(a5)
    80001694:	fcf700e3          	beq	a4,a5,80001654 <strncmp+0x16>
  if(n == 0)
    80001698:	fdc42783          	lw	a5,-36(s0)
    8000169c:	2781                	sext.w	a5,a5
    8000169e:	e399                	bnez	a5,800016a4 <strncmp+0x66>
    return 0;
    800016a0:	4781                	li	a5,0
    800016a2:	a839                	j	800016c0 <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    800016a4:	fe843783          	ld	a5,-24(s0)
    800016a8:	0007c783          	lbu	a5,0(a5)
    800016ac:	0007871b          	sext.w	a4,a5
    800016b0:	fe043783          	ld	a5,-32(s0)
    800016b4:	0007c783          	lbu	a5,0(a5)
    800016b8:	2781                	sext.w	a5,a5
    800016ba:	40f707bb          	subw	a5,a4,a5
    800016be:	2781                	sext.w	a5,a5
}
    800016c0:	853e                	mv	a0,a5
    800016c2:	7422                	ld	s0,40(sp)
    800016c4:	6145                	addi	sp,sp,48
    800016c6:	8082                	ret

00000000800016c8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800016c8:	7139                	addi	sp,sp,-64
    800016ca:	fc22                	sd	s0,56(sp)
    800016cc:	0080                	addi	s0,sp,64
    800016ce:	fca43c23          	sd	a0,-40(s0)
    800016d2:	fcb43823          	sd	a1,-48(s0)
    800016d6:	87b2                	mv	a5,a2
    800016d8:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    800016dc:	fd843783          	ld	a5,-40(s0)
    800016e0:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800016e4:	0001                	nop
    800016e6:	fcc42783          	lw	a5,-52(s0)
    800016ea:	fff7871b          	addiw	a4,a5,-1
    800016ee:	fce42623          	sw	a4,-52(s0)
    800016f2:	02f05e63          	blez	a5,8000172e <strncpy+0x66>
    800016f6:	fd043703          	ld	a4,-48(s0)
    800016fa:	00170793          	addi	a5,a4,1
    800016fe:	fcf43823          	sd	a5,-48(s0)
    80001702:	fd843783          	ld	a5,-40(s0)
    80001706:	00178693          	addi	a3,a5,1
    8000170a:	fcd43c23          	sd	a3,-40(s0)
    8000170e:	00074703          	lbu	a4,0(a4)
    80001712:	00e78023          	sb	a4,0(a5)
    80001716:	0007c783          	lbu	a5,0(a5)
    8000171a:	f7f1                	bnez	a5,800016e6 <strncpy+0x1e>
    ;
  while(n-- > 0)
    8000171c:	a809                	j	8000172e <strncpy+0x66>
    *s++ = 0;
    8000171e:	fd843783          	ld	a5,-40(s0)
    80001722:	00178713          	addi	a4,a5,1
    80001726:	fce43c23          	sd	a4,-40(s0)
    8000172a:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    8000172e:	fcc42783          	lw	a5,-52(s0)
    80001732:	fff7871b          	addiw	a4,a5,-1
    80001736:	fce42623          	sw	a4,-52(s0)
    8000173a:	fef042e3          	bgtz	a5,8000171e <strncpy+0x56>
  return os;
    8000173e:	fe843783          	ld	a5,-24(s0)
}
    80001742:	853e                	mv	a0,a5
    80001744:	7462                	ld	s0,56(sp)
    80001746:	6121                	addi	sp,sp,64
    80001748:	8082                	ret

000000008000174a <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000174a:	7139                	addi	sp,sp,-64
    8000174c:	fc22                	sd	s0,56(sp)
    8000174e:	0080                	addi	s0,sp,64
    80001750:	fca43c23          	sd	a0,-40(s0)
    80001754:	fcb43823          	sd	a1,-48(s0)
    80001758:	87b2                	mv	a5,a2
    8000175a:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000175e:	fd843783          	ld	a5,-40(s0)
    80001762:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    80001766:	fcc42783          	lw	a5,-52(s0)
    8000176a:	2781                	sext.w	a5,a5
    8000176c:	00f04563          	bgtz	a5,80001776 <safestrcpy+0x2c>
    return os;
    80001770:	fe843783          	ld	a5,-24(s0)
    80001774:	a0a1                	j	800017bc <safestrcpy+0x72>
  while(--n > 0 && (*s++ = *t++) != 0)
    80001776:	fcc42783          	lw	a5,-52(s0)
    8000177a:	37fd                	addiw	a5,a5,-1
    8000177c:	fcf42623          	sw	a5,-52(s0)
    80001780:	fcc42783          	lw	a5,-52(s0)
    80001784:	2781                	sext.w	a5,a5
    80001786:	02f05563          	blez	a5,800017b0 <safestrcpy+0x66>
    8000178a:	fd043703          	ld	a4,-48(s0)
    8000178e:	00170793          	addi	a5,a4,1
    80001792:	fcf43823          	sd	a5,-48(s0)
    80001796:	fd843783          	ld	a5,-40(s0)
    8000179a:	00178693          	addi	a3,a5,1
    8000179e:	fcd43c23          	sd	a3,-40(s0)
    800017a2:	00074703          	lbu	a4,0(a4)
    800017a6:	00e78023          	sb	a4,0(a5)
    800017aa:	0007c783          	lbu	a5,0(a5)
    800017ae:	f7e1                	bnez	a5,80001776 <safestrcpy+0x2c>
    ;
  *s = 0;
    800017b0:	fd843783          	ld	a5,-40(s0)
    800017b4:	00078023          	sb	zero,0(a5)
  return os;
    800017b8:	fe843783          	ld	a5,-24(s0)
}
    800017bc:	853e                	mv	a0,a5
    800017be:	7462                	ld	s0,56(sp)
    800017c0:	6121                	addi	sp,sp,64
    800017c2:	8082                	ret

00000000800017c4 <strlen>:

int
strlen(const char *s)
{
    800017c4:	7179                	addi	sp,sp,-48
    800017c6:	f422                	sd	s0,40(sp)
    800017c8:	1800                	addi	s0,sp,48
    800017ca:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    800017ce:	fe042623          	sw	zero,-20(s0)
    800017d2:	a031                	j	800017de <strlen+0x1a>
    800017d4:	fec42783          	lw	a5,-20(s0)
    800017d8:	2785                	addiw	a5,a5,1
    800017da:	fef42623          	sw	a5,-20(s0)
    800017de:	fec42783          	lw	a5,-20(s0)
    800017e2:	fd843703          	ld	a4,-40(s0)
    800017e6:	97ba                	add	a5,a5,a4
    800017e8:	0007c783          	lbu	a5,0(a5)
    800017ec:	f7e5                	bnez	a5,800017d4 <strlen+0x10>
    ;
  return n;
    800017ee:	fec42783          	lw	a5,-20(s0)
}
    800017f2:	853e                	mv	a0,a5
    800017f4:	7422                	ld	s0,40(sp)
    800017f6:	6145                	addi	sp,sp,48
    800017f8:	8082                	ret

00000000800017fa <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800017fa:	1141                	addi	sp,sp,-16
    800017fc:	e406                	sd	ra,8(sp)
    800017fe:	e022                	sd	s0,0(sp)
    80001800:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80001802:	00001097          	auipc	ra,0x1
    80001806:	f98080e7          	jalr	-104(ra) # 8000279a <cpuid>
    8000180a:	87aa                	mv	a5,a0
    8000180c:	efd5                	bnez	a5,800018c8 <main+0xce>
    consoleinit();
    8000180e:	fffff097          	auipc	ra,0xfffff
    80001812:	018080e7          	jalr	24(ra) # 80000826 <consoleinit>
    printfinit();
    80001816:	fffff097          	auipc	ra,0xfffff
    8000181a:	48e080e7          	jalr	1166(ra) # 80000ca4 <printfinit>
    printf("\n");
    8000181e:	0000a517          	auipc	a0,0xa
    80001822:	86250513          	addi	a0,a0,-1950 # 8000b080 <etext+0x80>
    80001826:	fffff097          	auipc	ra,0xfffff
    8000182a:	1d6080e7          	jalr	470(ra) # 800009fc <printf>
    printf("xv6 kernel is booting\n");
    8000182e:	0000a517          	auipc	a0,0xa
    80001832:	85a50513          	addi	a0,a0,-1958 # 8000b088 <etext+0x88>
    80001836:	fffff097          	auipc	ra,0xfffff
    8000183a:	1c6080e7          	jalr	454(ra) # 800009fc <printf>
    printf("\n");
    8000183e:	0000a517          	auipc	a0,0xa
    80001842:	84250513          	addi	a0,a0,-1982 # 8000b080 <etext+0x80>
    80001846:	fffff097          	auipc	ra,0xfffff
    8000184a:	1b6080e7          	jalr	438(ra) # 800009fc <printf>
    kinit();         // physical page allocator
    8000184e:	fffff097          	auipc	ra,0xfffff
    80001852:	7a2080e7          	jalr	1954(ra) # 80000ff0 <kinit>
    kvminit();       // create kernel page table
    80001856:	00000097          	auipc	ra,0x0
    8000185a:	1f4080e7          	jalr	500(ra) # 80001a4a <kvminit>
    kvminithart();   // turn on paging
    8000185e:	00000097          	auipc	ra,0x0
    80001862:	212080e7          	jalr	530(ra) # 80001a70 <kvminithart>
    procinit();      // process table
    80001866:	00001097          	auipc	ra,0x1
    8000186a:	e7c080e7          	jalr	-388(ra) # 800026e2 <procinit>
    trapinit();      // trap vectors
    8000186e:	00002097          	auipc	ra,0x2
    80001872:	2d2080e7          	jalr	722(ra) # 80003b40 <trapinit>
    trapinithart();  // install kernel trap vector
    80001876:	00002097          	auipc	ra,0x2
    8000187a:	2f4080e7          	jalr	756(ra) # 80003b6a <trapinithart>
    plicinit();      // set up interrupt controller
    8000187e:	00007097          	auipc	ra,0x7
    80001882:	40c080e7          	jalr	1036(ra) # 80008c8a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001886:	00007097          	auipc	ra,0x7
    8000188a:	428080e7          	jalr	1064(ra) # 80008cae <plicinithart>
    binit();         // buffer cache
    8000188e:	00003097          	auipc	ra,0x3
    80001892:	f78080e7          	jalr	-136(ra) # 80004806 <binit>
    iinit();         // inode cache
    80001896:	00003097          	auipc	ra,0x3
    8000189a:	7c4080e7          	jalr	1988(ra) # 8000505a <iinit>
    fileinit();      // file table
    8000189e:	00005097          	auipc	ra,0x5
    800018a2:	178080e7          	jalr	376(ra) # 80006a16 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a6:	00007097          	auipc	ra,0x7
    800018aa:	4dc080e7          	jalr	1244(ra) # 80008d82 <virtio_disk_init>
    userinit();      // first user process
    800018ae:	00001097          	auipc	ra,0x1
    800018b2:	386080e7          	jalr	902(ra) # 80002c34 <userinit>
    __sync_synchronize();
    800018b6:	0ff0000f          	fence
    started = 1;
    800018ba:	00013797          	auipc	a5,0x13
    800018be:	9d678793          	addi	a5,a5,-1578 # 80014290 <started>
    800018c2:	4705                	li	a4,1
    800018c4:	c398                	sw	a4,0(a5)
    800018c6:	a0a9                	j	80001910 <main+0x116>
  } else {
    while(started == 0)
    800018c8:	0001                	nop
    800018ca:	00013797          	auipc	a5,0x13
    800018ce:	9c678793          	addi	a5,a5,-1594 # 80014290 <started>
    800018d2:	439c                	lw	a5,0(a5)
    800018d4:	2781                	sext.w	a5,a5
    800018d6:	dbf5                	beqz	a5,800018ca <main+0xd0>
      ;
    __sync_synchronize();
    800018d8:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800018dc:	00001097          	auipc	ra,0x1
    800018e0:	ebe080e7          	jalr	-322(ra) # 8000279a <cpuid>
    800018e4:	87aa                	mv	a5,a0
    800018e6:	85be                	mv	a1,a5
    800018e8:	00009517          	auipc	a0,0x9
    800018ec:	7b850513          	addi	a0,a0,1976 # 8000b0a0 <etext+0xa0>
    800018f0:	fffff097          	auipc	ra,0xfffff
    800018f4:	10c080e7          	jalr	268(ra) # 800009fc <printf>
    kvminithart();    // turn on paging
    800018f8:	00000097          	auipc	ra,0x0
    800018fc:	178080e7          	jalr	376(ra) # 80001a70 <kvminithart>
    trapinithart();   // install kernel trap vector
    80001900:	00002097          	auipc	ra,0x2
    80001904:	26a080e7          	jalr	618(ra) # 80003b6a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001908:	00007097          	auipc	ra,0x7
    8000190c:	3a6080e7          	jalr	934(ra) # 80008cae <plicinithart>
  }

  scheduler();        
    80001910:	00002097          	auipc	ra,0x2
    80001914:	9fa080e7          	jalr	-1542(ra) # 8000330a <scheduler>

0000000080001918 <w_satp>:
{
    80001918:	1101                	addi	sp,sp,-32
    8000191a:	ec22                	sd	s0,24(sp)
    8000191c:	1000                	addi	s0,sp,32
    8000191e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80001922:	fe843783          	ld	a5,-24(s0)
    80001926:	18079073          	csrw	satp,a5
}
    8000192a:	0001                	nop
    8000192c:	6462                	ld	s0,24(sp)
    8000192e:	6105                	addi	sp,sp,32
    80001930:	8082                	ret

0000000080001932 <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    80001932:	1141                	addi	sp,sp,-16
    80001934:	e422                	sd	s0,8(sp)
    80001936:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001938:	12000073          	sfence.vma
}
    8000193c:	0001                	nop
    8000193e:	6422                	ld	s0,8(sp)
    80001940:	0141                	addi	sp,sp,16
    80001942:	8082                	ret

0000000080001944 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001944:	1101                	addi	sp,sp,-32
    80001946:	ec06                	sd	ra,24(sp)
    80001948:	e822                	sd	s0,16(sp)
    8000194a:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    8000194c:	fffff097          	auipc	ra,0xfffff
    80001950:	7e0080e7          	jalr	2016(ra) # 8000112c <kalloc>
    80001954:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001958:	6605                	lui	a2,0x1
    8000195a:	4581                	li	a1,0
    8000195c:	fe843503          	ld	a0,-24(s0)
    80001960:	00000097          	auipc	ra,0x0
    80001964:	af4080e7          	jalr	-1292(ra) # 80001454 <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001968:	4719                	li	a4,6
    8000196a:	6685                	lui	a3,0x1
    8000196c:	10000637          	lui	a2,0x10000
    80001970:	100005b7          	lui	a1,0x10000
    80001974:	fe843503          	ld	a0,-24(s0)
    80001978:	00000097          	auipc	ra,0x0
    8000197c:	298080e7          	jalr	664(ra) # 80001c10 <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001980:	4719                	li	a4,6
    80001982:	6685                	lui	a3,0x1
    80001984:	10001637          	lui	a2,0x10001
    80001988:	100015b7          	lui	a1,0x10001
    8000198c:	fe843503          	ld	a0,-24(s0)
    80001990:	00000097          	auipc	ra,0x0
    80001994:	280080e7          	jalr	640(ra) # 80001c10 <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001998:	4719                	li	a4,6
    8000199a:	004006b7          	lui	a3,0x400
    8000199e:	0c000637          	lui	a2,0xc000
    800019a2:	0c0005b7          	lui	a1,0xc000
    800019a6:	fe843503          	ld	a0,-24(s0)
    800019aa:	00000097          	auipc	ra,0x0
    800019ae:	266080e7          	jalr	614(ra) # 80001c10 <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800019b2:	00009717          	auipc	a4,0x9
    800019b6:	64e70713          	addi	a4,a4,1614 # 8000b000 <etext>
    800019ba:	800007b7          	lui	a5,0x80000
    800019be:	97ba                	add	a5,a5,a4
    800019c0:	4729                	li	a4,10
    800019c2:	86be                	mv	a3,a5
    800019c4:	4785                	li	a5,1
    800019c6:	01f79613          	slli	a2,a5,0x1f
    800019ca:	4785                	li	a5,1
    800019cc:	01f79593          	slli	a1,a5,0x1f
    800019d0:	fe843503          	ld	a0,-24(s0)
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	23c080e7          	jalr	572(ra) # 80001c10 <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800019dc:	00009597          	auipc	a1,0x9
    800019e0:	62458593          	addi	a1,a1,1572 # 8000b000 <etext>
    800019e4:	00009617          	auipc	a2,0x9
    800019e8:	61c60613          	addi	a2,a2,1564 # 8000b000 <etext>
    800019ec:	00009797          	auipc	a5,0x9
    800019f0:	61478793          	addi	a5,a5,1556 # 8000b000 <etext>
    800019f4:	4745                	li	a4,17
    800019f6:	076e                	slli	a4,a4,0x1b
    800019f8:	40f707b3          	sub	a5,a4,a5
    800019fc:	4719                	li	a4,6
    800019fe:	86be                	mv	a3,a5
    80001a00:	fe843503          	ld	a0,-24(s0)
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	20c080e7          	jalr	524(ra) # 80001c10 <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001a0c:	00008797          	auipc	a5,0x8
    80001a10:	5f478793          	addi	a5,a5,1524 # 8000a000 <_trampoline>
    80001a14:	4729                	li	a4,10
    80001a16:	6685                	lui	a3,0x1
    80001a18:	863e                	mv	a2,a5
    80001a1a:	040007b7          	lui	a5,0x4000
    80001a1e:	17fd                	addi	a5,a5,-1
    80001a20:	00c79593          	slli	a1,a5,0xc
    80001a24:	fe843503          	ld	a0,-24(s0)
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	1e8080e7          	jalr	488(ra) # 80001c10 <kvmmap>

  // map kernel stacks
  proc_mapstacks(kpgtbl);
    80001a30:	fe843503          	ld	a0,-24(s0)
    80001a34:	00001097          	auipc	ra,0x1
    80001a38:	bee080e7          	jalr	-1042(ra) # 80002622 <proc_mapstacks>
  
  return kpgtbl;
    80001a3c:	fe843783          	ld	a5,-24(s0)
}
    80001a40:	853e                	mv	a0,a5
    80001a42:	60e2                	ld	ra,24(sp)
    80001a44:	6442                	ld	s0,16(sp)
    80001a46:	6105                	addi	sp,sp,32
    80001a48:	8082                	ret

0000000080001a4a <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001a4a:	1141                	addi	sp,sp,-16
    80001a4c:	e406                	sd	ra,8(sp)
    80001a4e:	e022                	sd	s0,0(sp)
    80001a50:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001a52:	00000097          	auipc	ra,0x0
    80001a56:	ef2080e7          	jalr	-270(ra) # 80001944 <kvmmake>
    80001a5a:	872a                	mv	a4,a0
    80001a5c:	0000a797          	auipc	a5,0xa
    80001a60:	5b478793          	addi	a5,a5,1460 # 8000c010 <kernel_pagetable>
    80001a64:	e398                	sd	a4,0(a5)
}
    80001a66:	0001                	nop
    80001a68:	60a2                	ld	ra,8(sp)
    80001a6a:	6402                	ld	s0,0(sp)
    80001a6c:	0141                	addi	sp,sp,16
    80001a6e:	8082                	ret

0000000080001a70 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001a70:	1141                	addi	sp,sp,-16
    80001a72:	e406                	sd	ra,8(sp)
    80001a74:	e022                	sd	s0,0(sp)
    80001a76:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80001a78:	0000a797          	auipc	a5,0xa
    80001a7c:	59878793          	addi	a5,a5,1432 # 8000c010 <kernel_pagetable>
    80001a80:	639c                	ld	a5,0(a5)
    80001a82:	00c7d713          	srli	a4,a5,0xc
    80001a86:	57fd                	li	a5,-1
    80001a88:	17fe                	slli	a5,a5,0x3f
    80001a8a:	8fd9                	or	a5,a5,a4
    80001a8c:	853e                	mv	a0,a5
    80001a8e:	00000097          	auipc	ra,0x0
    80001a92:	e8a080e7          	jalr	-374(ra) # 80001918 <w_satp>
  sfence_vma();
    80001a96:	00000097          	auipc	ra,0x0
    80001a9a:	e9c080e7          	jalr	-356(ra) # 80001932 <sfence_vma>
}
    80001a9e:	0001                	nop
    80001aa0:	60a2                	ld	ra,8(sp)
    80001aa2:	6402                	ld	s0,0(sp)
    80001aa4:	0141                	addi	sp,sp,16
    80001aa6:	8082                	ret

0000000080001aa8 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001aa8:	7139                	addi	sp,sp,-64
    80001aaa:	fc06                	sd	ra,56(sp)
    80001aac:	f822                	sd	s0,48(sp)
    80001aae:	0080                	addi	s0,sp,64
    80001ab0:	fca43c23          	sd	a0,-40(s0)
    80001ab4:	fcb43823          	sd	a1,-48(s0)
    80001ab8:	87b2                	mv	a5,a2
    80001aba:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001abe:	fd043703          	ld	a4,-48(s0)
    80001ac2:	57fd                	li	a5,-1
    80001ac4:	83e9                	srli	a5,a5,0x1a
    80001ac6:	00e7fa63          	bgeu	a5,a4,80001ada <walk+0x32>
    panic("walk");
    80001aca:	00009517          	auipc	a0,0x9
    80001ace:	5ee50513          	addi	a0,a0,1518 # 8000b0b8 <etext+0xb8>
    80001ad2:	fffff097          	auipc	ra,0xfffff
    80001ad6:	180080e7          	jalr	384(ra) # 80000c52 <panic>

  for(int level = 2; level > 0; level--) {
    80001ada:	4789                	li	a5,2
    80001adc:	fef42623          	sw	a5,-20(s0)
    80001ae0:	a849                	j	80001b72 <walk+0xca>
    pte_t *pte = &pagetable[PX(level, va)];
    80001ae2:	fec42703          	lw	a4,-20(s0)
    80001ae6:	87ba                	mv	a5,a4
    80001ae8:	0037979b          	slliw	a5,a5,0x3
    80001aec:	9fb9                	addw	a5,a5,a4
    80001aee:	2781                	sext.w	a5,a5
    80001af0:	27b1                	addiw	a5,a5,12
    80001af2:	2781                	sext.w	a5,a5
    80001af4:	873e                	mv	a4,a5
    80001af6:	fd043783          	ld	a5,-48(s0)
    80001afa:	00e7d7b3          	srl	a5,a5,a4
    80001afe:	1ff7f793          	andi	a5,a5,511
    80001b02:	078e                	slli	a5,a5,0x3
    80001b04:	fd843703          	ld	a4,-40(s0)
    80001b08:	97ba                	add	a5,a5,a4
    80001b0a:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001b0e:	fe043783          	ld	a5,-32(s0)
    80001b12:	639c                	ld	a5,0(a5)
    80001b14:	8b85                	andi	a5,a5,1
    80001b16:	cb89                	beqz	a5,80001b28 <walk+0x80>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001b18:	fe043783          	ld	a5,-32(s0)
    80001b1c:	639c                	ld	a5,0(a5)
    80001b1e:	83a9                	srli	a5,a5,0xa
    80001b20:	07b2                	slli	a5,a5,0xc
    80001b22:	fcf43c23          	sd	a5,-40(s0)
    80001b26:	a089                	j	80001b68 <walk+0xc0>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001b28:	fcc42783          	lw	a5,-52(s0)
    80001b2c:	2781                	sext.w	a5,a5
    80001b2e:	cb91                	beqz	a5,80001b42 <walk+0x9a>
    80001b30:	fffff097          	auipc	ra,0xfffff
    80001b34:	5fc080e7          	jalr	1532(ra) # 8000112c <kalloc>
    80001b38:	fca43c23          	sd	a0,-40(s0)
    80001b3c:	fd843783          	ld	a5,-40(s0)
    80001b40:	e399                	bnez	a5,80001b46 <walk+0x9e>
        return 0;
    80001b42:	4781                	li	a5,0
    80001b44:	a0a9                	j	80001b8e <walk+0xe6>
      memset(pagetable, 0, PGSIZE);
    80001b46:	6605                	lui	a2,0x1
    80001b48:	4581                	li	a1,0
    80001b4a:	fd843503          	ld	a0,-40(s0)
    80001b4e:	00000097          	auipc	ra,0x0
    80001b52:	906080e7          	jalr	-1786(ra) # 80001454 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001b56:	fd843783          	ld	a5,-40(s0)
    80001b5a:	83b1                	srli	a5,a5,0xc
    80001b5c:	07aa                	slli	a5,a5,0xa
    80001b5e:	0017e713          	ori	a4,a5,1
    80001b62:	fe043783          	ld	a5,-32(s0)
    80001b66:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001b68:	fec42783          	lw	a5,-20(s0)
    80001b6c:	37fd                	addiw	a5,a5,-1
    80001b6e:	fef42623          	sw	a5,-20(s0)
    80001b72:	fec42783          	lw	a5,-20(s0)
    80001b76:	2781                	sext.w	a5,a5
    80001b78:	f6f045e3          	bgtz	a5,80001ae2 <walk+0x3a>
    }
  }
  return &pagetable[PX(0, va)];
    80001b7c:	fd043783          	ld	a5,-48(s0)
    80001b80:	83b1                	srli	a5,a5,0xc
    80001b82:	1ff7f793          	andi	a5,a5,511
    80001b86:	078e                	slli	a5,a5,0x3
    80001b88:	fd843703          	ld	a4,-40(s0)
    80001b8c:	97ba                	add	a5,a5,a4
}
    80001b8e:	853e                	mv	a0,a5
    80001b90:	70e2                	ld	ra,56(sp)
    80001b92:	7442                	ld	s0,48(sp)
    80001b94:	6121                	addi	sp,sp,64
    80001b96:	8082                	ret

0000000080001b98 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001b98:	7179                	addi	sp,sp,-48
    80001b9a:	f406                	sd	ra,40(sp)
    80001b9c:	f022                	sd	s0,32(sp)
    80001b9e:	1800                	addi	s0,sp,48
    80001ba0:	fca43c23          	sd	a0,-40(s0)
    80001ba4:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001ba8:	fd043703          	ld	a4,-48(s0)
    80001bac:	57fd                	li	a5,-1
    80001bae:	83e9                	srli	a5,a5,0x1a
    80001bb0:	00e7f463          	bgeu	a5,a4,80001bb8 <walkaddr+0x20>
    return 0;
    80001bb4:	4781                	li	a5,0
    80001bb6:	a881                	j	80001c06 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    80001bb8:	4601                	li	a2,0
    80001bba:	fd043583          	ld	a1,-48(s0)
    80001bbe:	fd843503          	ld	a0,-40(s0)
    80001bc2:	00000097          	auipc	ra,0x0
    80001bc6:	ee6080e7          	jalr	-282(ra) # 80001aa8 <walk>
    80001bca:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001bce:	fe843783          	ld	a5,-24(s0)
    80001bd2:	e399                	bnez	a5,80001bd8 <walkaddr+0x40>
    return 0;
    80001bd4:	4781                	li	a5,0
    80001bd6:	a805                	j	80001c06 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    80001bd8:	fe843783          	ld	a5,-24(s0)
    80001bdc:	639c                	ld	a5,0(a5)
    80001bde:	8b85                	andi	a5,a5,1
    80001be0:	e399                	bnez	a5,80001be6 <walkaddr+0x4e>
    return 0;
    80001be2:	4781                	li	a5,0
    80001be4:	a00d                	j	80001c06 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    80001be6:	fe843783          	ld	a5,-24(s0)
    80001bea:	639c                	ld	a5,0(a5)
    80001bec:	8bc1                	andi	a5,a5,16
    80001bee:	e399                	bnez	a5,80001bf4 <walkaddr+0x5c>
    return 0;
    80001bf0:	4781                	li	a5,0
    80001bf2:	a811                	j	80001c06 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    80001bf4:	fe843783          	ld	a5,-24(s0)
    80001bf8:	639c                	ld	a5,0(a5)
    80001bfa:	83a9                	srli	a5,a5,0xa
    80001bfc:	07b2                	slli	a5,a5,0xc
    80001bfe:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001c02:	fe043783          	ld	a5,-32(s0)
}
    80001c06:	853e                	mv	a0,a5
    80001c08:	70a2                	ld	ra,40(sp)
    80001c0a:	7402                	ld	s0,32(sp)
    80001c0c:	6145                	addi	sp,sp,48
    80001c0e:	8082                	ret

0000000080001c10 <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001c10:	7139                	addi	sp,sp,-64
    80001c12:	fc06                	sd	ra,56(sp)
    80001c14:	f822                	sd	s0,48(sp)
    80001c16:	0080                	addi	s0,sp,64
    80001c18:	fea43423          	sd	a0,-24(s0)
    80001c1c:	feb43023          	sd	a1,-32(s0)
    80001c20:	fcc43c23          	sd	a2,-40(s0)
    80001c24:	fcd43823          	sd	a3,-48(s0)
    80001c28:	87ba                	mv	a5,a4
    80001c2a:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001c2e:	fcc42783          	lw	a5,-52(s0)
    80001c32:	873e                	mv	a4,a5
    80001c34:	fd843683          	ld	a3,-40(s0)
    80001c38:	fd043603          	ld	a2,-48(s0)
    80001c3c:	fe043583          	ld	a1,-32(s0)
    80001c40:	fe843503          	ld	a0,-24(s0)
    80001c44:	00000097          	auipc	ra,0x0
    80001c48:	026080e7          	jalr	38(ra) # 80001c6a <mappages>
    80001c4c:	87aa                	mv	a5,a0
    80001c4e:	cb89                	beqz	a5,80001c60 <kvmmap+0x50>
    panic("kvmmap");
    80001c50:	00009517          	auipc	a0,0x9
    80001c54:	47050513          	addi	a0,a0,1136 # 8000b0c0 <etext+0xc0>
    80001c58:	fffff097          	auipc	ra,0xfffff
    80001c5c:	ffa080e7          	jalr	-6(ra) # 80000c52 <panic>
}
    80001c60:	0001                	nop
    80001c62:	70e2                	ld	ra,56(sp)
    80001c64:	7442                	ld	s0,48(sp)
    80001c66:	6121                	addi	sp,sp,64
    80001c68:	8082                	ret

0000000080001c6a <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001c6a:	711d                	addi	sp,sp,-96
    80001c6c:	ec86                	sd	ra,88(sp)
    80001c6e:	e8a2                	sd	s0,80(sp)
    80001c70:	1080                	addi	s0,sp,96
    80001c72:	fca43423          	sd	a0,-56(s0)
    80001c76:	fcb43023          	sd	a1,-64(s0)
    80001c7a:	fac43c23          	sd	a2,-72(s0)
    80001c7e:	fad43823          	sd	a3,-80(s0)
    80001c82:	87ba                	mv	a5,a4
    80001c84:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80001c88:	fc043703          	ld	a4,-64(s0)
    80001c8c:	77fd                	lui	a5,0xfffff
    80001c8e:	8ff9                	and	a5,a5,a4
    80001c90:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001c94:	fc043703          	ld	a4,-64(s0)
    80001c98:	fb843783          	ld	a5,-72(s0)
    80001c9c:	97ba                	add	a5,a5,a4
    80001c9e:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ff8cfff>
    80001ca2:	77fd                	lui	a5,0xfffff
    80001ca4:	8ff9                	and	a5,a5,a4
    80001ca6:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001caa:	4605                	li	a2,1
    80001cac:	fe843583          	ld	a1,-24(s0)
    80001cb0:	fc843503          	ld	a0,-56(s0)
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	df4080e7          	jalr	-524(ra) # 80001aa8 <walk>
    80001cbc:	fca43c23          	sd	a0,-40(s0)
    80001cc0:	fd843783          	ld	a5,-40(s0)
    80001cc4:	e399                	bnez	a5,80001cca <mappages+0x60>
      return -1;
    80001cc6:	57fd                	li	a5,-1
    80001cc8:	a085                	j	80001d28 <mappages+0xbe>
    if(*pte & PTE_V)
    80001cca:	fd843783          	ld	a5,-40(s0)
    80001cce:	639c                	ld	a5,0(a5)
    80001cd0:	8b85                	andi	a5,a5,1
    80001cd2:	cb89                	beqz	a5,80001ce4 <mappages+0x7a>
      panic("remap");
    80001cd4:	00009517          	auipc	a0,0x9
    80001cd8:	3f450513          	addi	a0,a0,1012 # 8000b0c8 <etext+0xc8>
    80001cdc:	fffff097          	auipc	ra,0xfffff
    80001ce0:	f76080e7          	jalr	-138(ra) # 80000c52 <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001ce4:	fb043783          	ld	a5,-80(s0)
    80001ce8:	83b1                	srli	a5,a5,0xc
    80001cea:	00a79713          	slli	a4,a5,0xa
    80001cee:	fac42783          	lw	a5,-84(s0)
    80001cf2:	8fd9                	or	a5,a5,a4
    80001cf4:	0017e713          	ori	a4,a5,1
    80001cf8:	fd843783          	ld	a5,-40(s0)
    80001cfc:	e398                	sd	a4,0(a5)
    if(a == last)
    80001cfe:	fe843703          	ld	a4,-24(s0)
    80001d02:	fe043783          	ld	a5,-32(s0)
    80001d06:	00f70f63          	beq	a4,a5,80001d24 <mappages+0xba>
      break;
    a += PGSIZE;
    80001d0a:	fe843703          	ld	a4,-24(s0)
    80001d0e:	6785                	lui	a5,0x1
    80001d10:	97ba                	add	a5,a5,a4
    80001d12:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001d16:	fb043703          	ld	a4,-80(s0)
    80001d1a:	6785                	lui	a5,0x1
    80001d1c:	97ba                	add	a5,a5,a4
    80001d1e:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80001d22:	b761                	j	80001caa <mappages+0x40>
      break;
    80001d24:	0001                	nop
  }
  return 0;
    80001d26:	4781                	li	a5,0
}
    80001d28:	853e                	mv	a0,a5
    80001d2a:	60e6                	ld	ra,88(sp)
    80001d2c:	6446                	ld	s0,80(sp)
    80001d2e:	6125                	addi	sp,sp,96
    80001d30:	8082                	ret

0000000080001d32 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001d32:	715d                	addi	sp,sp,-80
    80001d34:	e486                	sd	ra,72(sp)
    80001d36:	e0a2                	sd	s0,64(sp)
    80001d38:	0880                	addi	s0,sp,80
    80001d3a:	fca43423          	sd	a0,-56(s0)
    80001d3e:	fcb43023          	sd	a1,-64(s0)
    80001d42:	fac43c23          	sd	a2,-72(s0)
    80001d46:	87b6                	mv	a5,a3
    80001d48:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001d4c:	fc043703          	ld	a4,-64(s0)
    80001d50:	6785                	lui	a5,0x1
    80001d52:	17fd                	addi	a5,a5,-1
    80001d54:	8ff9                	and	a5,a5,a4
    80001d56:	cb89                	beqz	a5,80001d68 <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    80001d58:	00009517          	auipc	a0,0x9
    80001d5c:	37850513          	addi	a0,a0,888 # 8000b0d0 <etext+0xd0>
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	ef2080e7          	jalr	-270(ra) # 80000c52 <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001d68:	fc043783          	ld	a5,-64(s0)
    80001d6c:	fef43423          	sd	a5,-24(s0)
    80001d70:	a045                	j	80001e10 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001d72:	4601                	li	a2,0
    80001d74:	fe843583          	ld	a1,-24(s0)
    80001d78:	fc843503          	ld	a0,-56(s0)
    80001d7c:	00000097          	auipc	ra,0x0
    80001d80:	d2c080e7          	jalr	-724(ra) # 80001aa8 <walk>
    80001d84:	fea43023          	sd	a0,-32(s0)
    80001d88:	fe043783          	ld	a5,-32(s0)
    80001d8c:	eb89                	bnez	a5,80001d9e <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80001d8e:	00009517          	auipc	a0,0x9
    80001d92:	35a50513          	addi	a0,a0,858 # 8000b0e8 <etext+0xe8>
    80001d96:	fffff097          	auipc	ra,0xfffff
    80001d9a:	ebc080e7          	jalr	-324(ra) # 80000c52 <panic>
    if((*pte & PTE_V) == 0)
    80001d9e:	fe043783          	ld	a5,-32(s0)
    80001da2:	639c                	ld	a5,0(a5)
    80001da4:	8b85                	andi	a5,a5,1
    80001da6:	eb89                	bnez	a5,80001db8 <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80001da8:	00009517          	auipc	a0,0x9
    80001dac:	35050513          	addi	a0,a0,848 # 8000b0f8 <etext+0xf8>
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	ea2080e7          	jalr	-350(ra) # 80000c52 <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001db8:	fe043783          	ld	a5,-32(s0)
    80001dbc:	639c                	ld	a5,0(a5)
    80001dbe:	3ff7f713          	andi	a4,a5,1023
    80001dc2:	4785                	li	a5,1
    80001dc4:	00f71a63          	bne	a4,a5,80001dd8 <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    80001dc8:	00009517          	auipc	a0,0x9
    80001dcc:	34850513          	addi	a0,a0,840 # 8000b110 <etext+0x110>
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	e82080e7          	jalr	-382(ra) # 80000c52 <panic>
    if(do_free){
    80001dd8:	fb442783          	lw	a5,-76(s0)
    80001ddc:	2781                	sext.w	a5,a5
    80001dde:	cf99                	beqz	a5,80001dfc <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    80001de0:	fe043783          	ld	a5,-32(s0)
    80001de4:	639c                	ld	a5,0(a5)
    80001de6:	83a9                	srli	a5,a5,0xa
    80001de8:	07b2                	slli	a5,a5,0xc
    80001dea:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80001dee:	fd843783          	ld	a5,-40(s0)
    80001df2:	853e                	mv	a0,a5
    80001df4:	fffff097          	auipc	ra,0xfffff
    80001df8:	294080e7          	jalr	660(ra) # 80001088 <kfree>
    }
    *pte = 0;
    80001dfc:	fe043783          	ld	a5,-32(s0)
    80001e00:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001e04:	fe843703          	ld	a4,-24(s0)
    80001e08:	6785                	lui	a5,0x1
    80001e0a:	97ba                	add	a5,a5,a4
    80001e0c:	fef43423          	sd	a5,-24(s0)
    80001e10:	fb843783          	ld	a5,-72(s0)
    80001e14:	00c79713          	slli	a4,a5,0xc
    80001e18:	fc043783          	ld	a5,-64(s0)
    80001e1c:	97ba                	add	a5,a5,a4
    80001e1e:	fe843703          	ld	a4,-24(s0)
    80001e22:	f4f768e3          	bltu	a4,a5,80001d72 <uvmunmap+0x40>
  }
}
    80001e26:	0001                	nop
    80001e28:	0001                	nop
    80001e2a:	60a6                	ld	ra,72(sp)
    80001e2c:	6406                	ld	s0,64(sp)
    80001e2e:	6161                	addi	sp,sp,80
    80001e30:	8082                	ret

0000000080001e32 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001e32:	1101                	addi	sp,sp,-32
    80001e34:	ec06                	sd	ra,24(sp)
    80001e36:	e822                	sd	s0,16(sp)
    80001e38:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001e3a:	fffff097          	auipc	ra,0xfffff
    80001e3e:	2f2080e7          	jalr	754(ra) # 8000112c <kalloc>
    80001e42:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80001e46:	fe843783          	ld	a5,-24(s0)
    80001e4a:	e399                	bnez	a5,80001e50 <uvmcreate+0x1e>
    return 0;
    80001e4c:	4781                	li	a5,0
    80001e4e:	a819                	j	80001e64 <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80001e50:	6605                	lui	a2,0x1
    80001e52:	4581                	li	a1,0
    80001e54:	fe843503          	ld	a0,-24(s0)
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	5fc080e7          	jalr	1532(ra) # 80001454 <memset>
  return pagetable;
    80001e60:	fe843783          	ld	a5,-24(s0)
}
    80001e64:	853e                	mv	a0,a5
    80001e66:	60e2                	ld	ra,24(sp)
    80001e68:	6442                	ld	s0,16(sp)
    80001e6a:	6105                	addi	sp,sp,32
    80001e6c:	8082                	ret

0000000080001e6e <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80001e6e:	7139                	addi	sp,sp,-64
    80001e70:	fc06                	sd	ra,56(sp)
    80001e72:	f822                	sd	s0,48(sp)
    80001e74:	0080                	addi	s0,sp,64
    80001e76:	fca43c23          	sd	a0,-40(s0)
    80001e7a:	fcb43823          	sd	a1,-48(s0)
    80001e7e:	87b2                	mv	a5,a2
    80001e80:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    80001e84:	fcc42783          	lw	a5,-52(s0)
    80001e88:	0007871b          	sext.w	a4,a5
    80001e8c:	6785                	lui	a5,0x1
    80001e8e:	00f76a63          	bltu	a4,a5,80001ea2 <uvminit+0x34>
    panic("inituvm: more than a page");
    80001e92:	00009517          	auipc	a0,0x9
    80001e96:	29650513          	addi	a0,a0,662 # 8000b128 <etext+0x128>
    80001e9a:	fffff097          	auipc	ra,0xfffff
    80001e9e:	db8080e7          	jalr	-584(ra) # 80000c52 <panic>
  mem = kalloc();
    80001ea2:	fffff097          	auipc	ra,0xfffff
    80001ea6:	28a080e7          	jalr	650(ra) # 8000112c <kalloc>
    80001eaa:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80001eae:	6605                	lui	a2,0x1
    80001eb0:	4581                	li	a1,0
    80001eb2:	fe843503          	ld	a0,-24(s0)
    80001eb6:	fffff097          	auipc	ra,0xfffff
    80001eba:	59e080e7          	jalr	1438(ra) # 80001454 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001ebe:	fe843783          	ld	a5,-24(s0)
    80001ec2:	4779                	li	a4,30
    80001ec4:	86be                	mv	a3,a5
    80001ec6:	6605                	lui	a2,0x1
    80001ec8:	4581                	li	a1,0
    80001eca:	fd843503          	ld	a0,-40(s0)
    80001ece:	00000097          	auipc	ra,0x0
    80001ed2:	d9c080e7          	jalr	-612(ra) # 80001c6a <mappages>
  memmove(mem, src, sz);
    80001ed6:	fcc42783          	lw	a5,-52(s0)
    80001eda:	863e                	mv	a2,a5
    80001edc:	fd043583          	ld	a1,-48(s0)
    80001ee0:	fe843503          	ld	a0,-24(s0)
    80001ee4:	fffff097          	auipc	ra,0xfffff
    80001ee8:	654080e7          	jalr	1620(ra) # 80001538 <memmove>
}
    80001eec:	0001                	nop
    80001eee:	70e2                	ld	ra,56(sp)
    80001ef0:	7442                	ld	s0,48(sp)
    80001ef2:	6121                	addi	sp,sp,64
    80001ef4:	8082                	ret

0000000080001ef6 <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001ef6:	7139                	addi	sp,sp,-64
    80001ef8:	fc06                	sd	ra,56(sp)
    80001efa:	f822                	sd	s0,48(sp)
    80001efc:	0080                	addi	s0,sp,64
    80001efe:	fca43c23          	sd	a0,-40(s0)
    80001f02:	fcb43823          	sd	a1,-48(s0)
    80001f06:	fcc43423          	sd	a2,-56(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80001f0a:	fc843703          	ld	a4,-56(s0)
    80001f0e:	fd043783          	ld	a5,-48(s0)
    80001f12:	00f77563          	bgeu	a4,a5,80001f1c <uvmalloc+0x26>
    return oldsz;
    80001f16:	fd043783          	ld	a5,-48(s0)
    80001f1a:	a85d                	j	80001fd0 <uvmalloc+0xda>

  oldsz = PGROUNDUP(oldsz);
    80001f1c:	fd043703          	ld	a4,-48(s0)
    80001f20:	6785                	lui	a5,0x1
    80001f22:	17fd                	addi	a5,a5,-1
    80001f24:	973e                	add	a4,a4,a5
    80001f26:	77fd                	lui	a5,0xfffff
    80001f28:	8ff9                	and	a5,a5,a4
    80001f2a:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001f2e:	fd043783          	ld	a5,-48(s0)
    80001f32:	fef43423          	sd	a5,-24(s0)
    80001f36:	a069                	j	80001fc0 <uvmalloc+0xca>
    mem = kalloc();
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	1f4080e7          	jalr	500(ra) # 8000112c <kalloc>
    80001f40:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80001f44:	fe043783          	ld	a5,-32(s0)
    80001f48:	ef89                	bnez	a5,80001f62 <uvmalloc+0x6c>
      uvmdealloc(pagetable, a, oldsz);
    80001f4a:	fd043603          	ld	a2,-48(s0)
    80001f4e:	fe843583          	ld	a1,-24(s0)
    80001f52:	fd843503          	ld	a0,-40(s0)
    80001f56:	00000097          	auipc	ra,0x0
    80001f5a:	084080e7          	jalr	132(ra) # 80001fda <uvmdealloc>
      return 0;
    80001f5e:	4781                	li	a5,0
    80001f60:	a885                	j	80001fd0 <uvmalloc+0xda>
    }
    memset(mem, 0, PGSIZE);
    80001f62:	6605                	lui	a2,0x1
    80001f64:	4581                	li	a1,0
    80001f66:	fe043503          	ld	a0,-32(s0)
    80001f6a:	fffff097          	auipc	ra,0xfffff
    80001f6e:	4ea080e7          	jalr	1258(ra) # 80001454 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001f72:	fe043783          	ld	a5,-32(s0)
    80001f76:	4779                	li	a4,30
    80001f78:	86be                	mv	a3,a5
    80001f7a:	6605                	lui	a2,0x1
    80001f7c:	fe843583          	ld	a1,-24(s0)
    80001f80:	fd843503          	ld	a0,-40(s0)
    80001f84:	00000097          	auipc	ra,0x0
    80001f88:	ce6080e7          	jalr	-794(ra) # 80001c6a <mappages>
    80001f8c:	87aa                	mv	a5,a0
    80001f8e:	c39d                	beqz	a5,80001fb4 <uvmalloc+0xbe>
      kfree(mem);
    80001f90:	fe043503          	ld	a0,-32(s0)
    80001f94:	fffff097          	auipc	ra,0xfffff
    80001f98:	0f4080e7          	jalr	244(ra) # 80001088 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001f9c:	fd043603          	ld	a2,-48(s0)
    80001fa0:	fe843583          	ld	a1,-24(s0)
    80001fa4:	fd843503          	ld	a0,-40(s0)
    80001fa8:	00000097          	auipc	ra,0x0
    80001fac:	032080e7          	jalr	50(ra) # 80001fda <uvmdealloc>
      return 0;
    80001fb0:	4781                	li	a5,0
    80001fb2:	a839                	j	80001fd0 <uvmalloc+0xda>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001fb4:	fe843703          	ld	a4,-24(s0)
    80001fb8:	6785                	lui	a5,0x1
    80001fba:	97ba                	add	a5,a5,a4
    80001fbc:	fef43423          	sd	a5,-24(s0)
    80001fc0:	fe843703          	ld	a4,-24(s0)
    80001fc4:	fc843783          	ld	a5,-56(s0)
    80001fc8:	f6f768e3          	bltu	a4,a5,80001f38 <uvmalloc+0x42>
    }
  }
  return newsz;
    80001fcc:	fc843783          	ld	a5,-56(s0)
}
    80001fd0:	853e                	mv	a0,a5
    80001fd2:	70e2                	ld	ra,56(sp)
    80001fd4:	7442                	ld	s0,48(sp)
    80001fd6:	6121                	addi	sp,sp,64
    80001fd8:	8082                	ret

0000000080001fda <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001fda:	7139                	addi	sp,sp,-64
    80001fdc:	fc06                	sd	ra,56(sp)
    80001fde:	f822                	sd	s0,48(sp)
    80001fe0:	0080                	addi	s0,sp,64
    80001fe2:	fca43c23          	sd	a0,-40(s0)
    80001fe6:	fcb43823          	sd	a1,-48(s0)
    80001fea:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    80001fee:	fc843703          	ld	a4,-56(s0)
    80001ff2:	fd043783          	ld	a5,-48(s0)
    80001ff6:	00f76563          	bltu	a4,a5,80002000 <uvmdealloc+0x26>
    return oldsz;
    80001ffa:	fd043783          	ld	a5,-48(s0)
    80001ffe:	a885                	j	8000206e <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80002000:	fc843703          	ld	a4,-56(s0)
    80002004:	6785                	lui	a5,0x1
    80002006:	17fd                	addi	a5,a5,-1
    80002008:	973e                	add	a4,a4,a5
    8000200a:	77fd                	lui	a5,0xfffff
    8000200c:	8f7d                	and	a4,a4,a5
    8000200e:	fd043683          	ld	a3,-48(s0)
    80002012:	6785                	lui	a5,0x1
    80002014:	17fd                	addi	a5,a5,-1
    80002016:	96be                	add	a3,a3,a5
    80002018:	77fd                	lui	a5,0xfffff
    8000201a:	8ff5                	and	a5,a5,a3
    8000201c:	04f77763          	bgeu	a4,a5,8000206a <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80002020:	fd043703          	ld	a4,-48(s0)
    80002024:	6785                	lui	a5,0x1
    80002026:	17fd                	addi	a5,a5,-1
    80002028:	973e                	add	a4,a4,a5
    8000202a:	77fd                	lui	a5,0xfffff
    8000202c:	8f7d                	and	a4,a4,a5
    8000202e:	fc843683          	ld	a3,-56(s0)
    80002032:	6785                	lui	a5,0x1
    80002034:	17fd                	addi	a5,a5,-1
    80002036:	96be                	add	a3,a3,a5
    80002038:	77fd                	lui	a5,0xfffff
    8000203a:	8ff5                	and	a5,a5,a3
    8000203c:	40f707b3          	sub	a5,a4,a5
    80002040:	83b1                	srli	a5,a5,0xc
    80002042:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80002046:	fc843703          	ld	a4,-56(s0)
    8000204a:	6785                	lui	a5,0x1
    8000204c:	17fd                	addi	a5,a5,-1
    8000204e:	973e                	add	a4,a4,a5
    80002050:	77fd                	lui	a5,0xfffff
    80002052:	8ff9                	and	a5,a5,a4
    80002054:	fec42703          	lw	a4,-20(s0)
    80002058:	4685                	li	a3,1
    8000205a:	863a                	mv	a2,a4
    8000205c:	85be                	mv	a1,a5
    8000205e:	fd843503          	ld	a0,-40(s0)
    80002062:	00000097          	auipc	ra,0x0
    80002066:	cd0080e7          	jalr	-816(ra) # 80001d32 <uvmunmap>
  }

  return newsz;
    8000206a:	fc843783          	ld	a5,-56(s0)
}
    8000206e:	853e                	mv	a0,a5
    80002070:	70e2                	ld	ra,56(sp)
    80002072:	7442                	ld	s0,48(sp)
    80002074:	6121                	addi	sp,sp,64
    80002076:	8082                	ret

0000000080002078 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80002078:	7139                	addi	sp,sp,-64
    8000207a:	fc06                	sd	ra,56(sp)
    8000207c:	f822                	sd	s0,48(sp)
    8000207e:	0080                	addi	s0,sp,64
    80002080:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002084:	fe042623          	sw	zero,-20(s0)
    80002088:	a88d                	j	800020fa <freewalk+0x82>
    pte_t pte = pagetable[i];
    8000208a:	fec42783          	lw	a5,-20(s0)
    8000208e:	078e                	slli	a5,a5,0x3
    80002090:	fc843703          	ld	a4,-56(s0)
    80002094:	97ba                	add	a5,a5,a4
    80002096:	639c                	ld	a5,0(a5)
    80002098:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000209c:	fe043783          	ld	a5,-32(s0)
    800020a0:	8b85                	andi	a5,a5,1
    800020a2:	cb9d                	beqz	a5,800020d8 <freewalk+0x60>
    800020a4:	fe043783          	ld	a5,-32(s0)
    800020a8:	8bb9                	andi	a5,a5,14
    800020aa:	e79d                	bnez	a5,800020d8 <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800020ac:	fe043783          	ld	a5,-32(s0)
    800020b0:	83a9                	srli	a5,a5,0xa
    800020b2:	07b2                	slli	a5,a5,0xc
    800020b4:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    800020b8:	fd843783          	ld	a5,-40(s0)
    800020bc:	853e                	mv	a0,a5
    800020be:	00000097          	auipc	ra,0x0
    800020c2:	fba080e7          	jalr	-70(ra) # 80002078 <freewalk>
      pagetable[i] = 0;
    800020c6:	fec42783          	lw	a5,-20(s0)
    800020ca:	078e                	slli	a5,a5,0x3
    800020cc:	fc843703          	ld	a4,-56(s0)
    800020d0:	97ba                	add	a5,a5,a4
    800020d2:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ff8d000>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800020d6:	a829                	j	800020f0 <freewalk+0x78>
    } else if(pte & PTE_V){
    800020d8:	fe043783          	ld	a5,-32(s0)
    800020dc:	8b85                	andi	a5,a5,1
    800020de:	cb89                	beqz	a5,800020f0 <freewalk+0x78>
      panic("freewalk: leaf");
    800020e0:	00009517          	auipc	a0,0x9
    800020e4:	06850513          	addi	a0,a0,104 # 8000b148 <etext+0x148>
    800020e8:	fffff097          	auipc	ra,0xfffff
    800020ec:	b6a080e7          	jalr	-1174(ra) # 80000c52 <panic>
  for(int i = 0; i < 512; i++){
    800020f0:	fec42783          	lw	a5,-20(s0)
    800020f4:	2785                	addiw	a5,a5,1
    800020f6:	fef42623          	sw	a5,-20(s0)
    800020fa:	fec42783          	lw	a5,-20(s0)
    800020fe:	0007871b          	sext.w	a4,a5
    80002102:	1ff00793          	li	a5,511
    80002106:	f8e7d2e3          	bge	a5,a4,8000208a <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    8000210a:	fc843503          	ld	a0,-56(s0)
    8000210e:	fffff097          	auipc	ra,0xfffff
    80002112:	f7a080e7          	jalr	-134(ra) # 80001088 <kfree>
}
    80002116:	0001                	nop
    80002118:	70e2                	ld	ra,56(sp)
    8000211a:	7442                	ld	s0,48(sp)
    8000211c:	6121                	addi	sp,sp,64
    8000211e:	8082                	ret

0000000080002120 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80002120:	1101                	addi	sp,sp,-32
    80002122:	ec06                	sd	ra,24(sp)
    80002124:	e822                	sd	s0,16(sp)
    80002126:	1000                	addi	s0,sp,32
    80002128:	fea43423          	sd	a0,-24(s0)
    8000212c:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80002130:	fe043783          	ld	a5,-32(s0)
    80002134:	c385                	beqz	a5,80002154 <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80002136:	fe043703          	ld	a4,-32(s0)
    8000213a:	6785                	lui	a5,0x1
    8000213c:	17fd                	addi	a5,a5,-1
    8000213e:	97ba                	add	a5,a5,a4
    80002140:	83b1                	srli	a5,a5,0xc
    80002142:	4685                	li	a3,1
    80002144:	863e                	mv	a2,a5
    80002146:	4581                	li	a1,0
    80002148:	fe843503          	ld	a0,-24(s0)
    8000214c:	00000097          	auipc	ra,0x0
    80002150:	be6080e7          	jalr	-1050(ra) # 80001d32 <uvmunmap>
  freewalk(pagetable);
    80002154:	fe843503          	ld	a0,-24(s0)
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	f20080e7          	jalr	-224(ra) # 80002078 <freewalk>
}
    80002160:	0001                	nop
    80002162:	60e2                	ld	ra,24(sp)
    80002164:	6442                	ld	s0,16(sp)
    80002166:	6105                	addi	sp,sp,32
    80002168:	8082                	ret

000000008000216a <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    8000216a:	711d                	addi	sp,sp,-96
    8000216c:	ec86                	sd	ra,88(sp)
    8000216e:	e8a2                	sd	s0,80(sp)
    80002170:	1080                	addi	s0,sp,96
    80002172:	faa43c23          	sd	a0,-72(s0)
    80002176:	fab43823          	sd	a1,-80(s0)
    8000217a:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000217e:	fe043423          	sd	zero,-24(s0)
    80002182:	a0d9                	j	80002248 <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80002184:	4601                	li	a2,0
    80002186:	fe843583          	ld	a1,-24(s0)
    8000218a:	fb843503          	ld	a0,-72(s0)
    8000218e:	00000097          	auipc	ra,0x0
    80002192:	91a080e7          	jalr	-1766(ra) # 80001aa8 <walk>
    80002196:	fea43023          	sd	a0,-32(s0)
    8000219a:	fe043783          	ld	a5,-32(s0)
    8000219e:	eb89                	bnez	a5,800021b0 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    800021a0:	00009517          	auipc	a0,0x9
    800021a4:	fb850513          	addi	a0,a0,-72 # 8000b158 <etext+0x158>
    800021a8:	fffff097          	auipc	ra,0xfffff
    800021ac:	aaa080e7          	jalr	-1366(ra) # 80000c52 <panic>
    if((*pte & PTE_V) == 0)
    800021b0:	fe043783          	ld	a5,-32(s0)
    800021b4:	639c                	ld	a5,0(a5)
    800021b6:	8b85                	andi	a5,a5,1
    800021b8:	eb89                	bnez	a5,800021ca <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800021ba:	00009517          	auipc	a0,0x9
    800021be:	fbe50513          	addi	a0,a0,-66 # 8000b178 <etext+0x178>
    800021c2:	fffff097          	auipc	ra,0xfffff
    800021c6:	a90080e7          	jalr	-1392(ra) # 80000c52 <panic>
    pa = PTE2PA(*pte);
    800021ca:	fe043783          	ld	a5,-32(s0)
    800021ce:	639c                	ld	a5,0(a5)
    800021d0:	83a9                	srli	a5,a5,0xa
    800021d2:	07b2                	slli	a5,a5,0xc
    800021d4:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800021d8:	fe043783          	ld	a5,-32(s0)
    800021dc:	639c                	ld	a5,0(a5)
    800021de:	2781                	sext.w	a5,a5
    800021e0:	3ff7f793          	andi	a5,a5,1023
    800021e4:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	f44080e7          	jalr	-188(ra) # 8000112c <kalloc>
    800021f0:	fca43423          	sd	a0,-56(s0)
    800021f4:	fc843783          	ld	a5,-56(s0)
    800021f8:	c3a5                	beqz	a5,80002258 <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800021fa:	fd843783          	ld	a5,-40(s0)
    800021fe:	6605                	lui	a2,0x1
    80002200:	85be                	mv	a1,a5
    80002202:	fc843503          	ld	a0,-56(s0)
    80002206:	fffff097          	auipc	ra,0xfffff
    8000220a:	332080e7          	jalr	818(ra) # 80001538 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000220e:	fc843783          	ld	a5,-56(s0)
    80002212:	fd442703          	lw	a4,-44(s0)
    80002216:	86be                	mv	a3,a5
    80002218:	6605                	lui	a2,0x1
    8000221a:	fe843583          	ld	a1,-24(s0)
    8000221e:	fb043503          	ld	a0,-80(s0)
    80002222:	00000097          	auipc	ra,0x0
    80002226:	a48080e7          	jalr	-1464(ra) # 80001c6a <mappages>
    8000222a:	87aa                	mv	a5,a0
    8000222c:	cb81                	beqz	a5,8000223c <uvmcopy+0xd2>
      kfree(mem);
    8000222e:	fc843503          	ld	a0,-56(s0)
    80002232:	fffff097          	auipc	ra,0xfffff
    80002236:	e56080e7          	jalr	-426(ra) # 80001088 <kfree>
      goto err;
    8000223a:	a005                	j	8000225a <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    8000223c:	fe843703          	ld	a4,-24(s0)
    80002240:	6785                	lui	a5,0x1
    80002242:	97ba                	add	a5,a5,a4
    80002244:	fef43423          	sd	a5,-24(s0)
    80002248:	fe843703          	ld	a4,-24(s0)
    8000224c:	fa843783          	ld	a5,-88(s0)
    80002250:	f2f76ae3          	bltu	a4,a5,80002184 <uvmcopy+0x1a>
    }
  }
  return 0;
    80002254:	4781                	li	a5,0
    80002256:	a839                	j	80002274 <uvmcopy+0x10a>
      goto err;
    80002258:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000225a:	fe843783          	ld	a5,-24(s0)
    8000225e:	83b1                	srli	a5,a5,0xc
    80002260:	4685                	li	a3,1
    80002262:	863e                	mv	a2,a5
    80002264:	4581                	li	a1,0
    80002266:	fb043503          	ld	a0,-80(s0)
    8000226a:	00000097          	auipc	ra,0x0
    8000226e:	ac8080e7          	jalr	-1336(ra) # 80001d32 <uvmunmap>
  return -1;
    80002272:	57fd                	li	a5,-1
}
    80002274:	853e                	mv	a0,a5
    80002276:	60e6                	ld	ra,88(sp)
    80002278:	6446                	ld	s0,80(sp)
    8000227a:	6125                	addi	sp,sp,96
    8000227c:	8082                	ret

000000008000227e <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000227e:	7179                	addi	sp,sp,-48
    80002280:	f406                	sd	ra,40(sp)
    80002282:	f022                	sd	s0,32(sp)
    80002284:	1800                	addi	s0,sp,48
    80002286:	fca43c23          	sd	a0,-40(s0)
    8000228a:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000228e:	4601                	li	a2,0
    80002290:	fd043583          	ld	a1,-48(s0)
    80002294:	fd843503          	ld	a0,-40(s0)
    80002298:	00000097          	auipc	ra,0x0
    8000229c:	810080e7          	jalr	-2032(ra) # 80001aa8 <walk>
    800022a0:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800022a4:	fe843783          	ld	a5,-24(s0)
    800022a8:	eb89                	bnez	a5,800022ba <uvmclear+0x3c>
    panic("uvmclear");
    800022aa:	00009517          	auipc	a0,0x9
    800022ae:	eee50513          	addi	a0,a0,-274 # 8000b198 <etext+0x198>
    800022b2:	fffff097          	auipc	ra,0xfffff
    800022b6:	9a0080e7          	jalr	-1632(ra) # 80000c52 <panic>
  *pte &= ~PTE_U;
    800022ba:	fe843783          	ld	a5,-24(s0)
    800022be:	639c                	ld	a5,0(a5)
    800022c0:	fef7f713          	andi	a4,a5,-17
    800022c4:	fe843783          	ld	a5,-24(s0)
    800022c8:	e398                	sd	a4,0(a5)
}
    800022ca:	0001                	nop
    800022cc:	70a2                	ld	ra,40(sp)
    800022ce:	7402                	ld	s0,32(sp)
    800022d0:	6145                	addi	sp,sp,48
    800022d2:	8082                	ret

00000000800022d4 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800022d4:	715d                	addi	sp,sp,-80
    800022d6:	e486                	sd	ra,72(sp)
    800022d8:	e0a2                	sd	s0,64(sp)
    800022da:	0880                	addi	s0,sp,80
    800022dc:	fca43423          	sd	a0,-56(s0)
    800022e0:	fcb43023          	sd	a1,-64(s0)
    800022e4:	fac43c23          	sd	a2,-72(s0)
    800022e8:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800022ec:	a055                	j	80002390 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800022ee:	fc043703          	ld	a4,-64(s0)
    800022f2:	77fd                	lui	a5,0xfffff
    800022f4:	8ff9                	and	a5,a5,a4
    800022f6:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800022fa:	fe043583          	ld	a1,-32(s0)
    800022fe:	fc843503          	ld	a0,-56(s0)
    80002302:	00000097          	auipc	ra,0x0
    80002306:	896080e7          	jalr	-1898(ra) # 80001b98 <walkaddr>
    8000230a:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    8000230e:	fd843783          	ld	a5,-40(s0)
    80002312:	e399                	bnez	a5,80002318 <copyout+0x44>
      return -1;
    80002314:	57fd                	li	a5,-1
    80002316:	a049                	j	80002398 <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    80002318:	fe043703          	ld	a4,-32(s0)
    8000231c:	fc043783          	ld	a5,-64(s0)
    80002320:	8f1d                	sub	a4,a4,a5
    80002322:	6785                	lui	a5,0x1
    80002324:	97ba                	add	a5,a5,a4
    80002326:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000232a:	fe843703          	ld	a4,-24(s0)
    8000232e:	fb043783          	ld	a5,-80(s0)
    80002332:	00e7f663          	bgeu	a5,a4,8000233e <copyout+0x6a>
      n = len;
    80002336:	fb043783          	ld	a5,-80(s0)
    8000233a:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    8000233e:	fc043703          	ld	a4,-64(s0)
    80002342:	fe043783          	ld	a5,-32(s0)
    80002346:	8f1d                	sub	a4,a4,a5
    80002348:	fd843783          	ld	a5,-40(s0)
    8000234c:	97ba                	add	a5,a5,a4
    8000234e:	873e                	mv	a4,a5
    80002350:	fe843783          	ld	a5,-24(s0)
    80002354:	2781                	sext.w	a5,a5
    80002356:	863e                	mv	a2,a5
    80002358:	fb843583          	ld	a1,-72(s0)
    8000235c:	853a                	mv	a0,a4
    8000235e:	fffff097          	auipc	ra,0xfffff
    80002362:	1da080e7          	jalr	474(ra) # 80001538 <memmove>

    len -= n;
    80002366:	fb043703          	ld	a4,-80(s0)
    8000236a:	fe843783          	ld	a5,-24(s0)
    8000236e:	40f707b3          	sub	a5,a4,a5
    80002372:	faf43823          	sd	a5,-80(s0)
    src += n;
    80002376:	fb843703          	ld	a4,-72(s0)
    8000237a:	fe843783          	ld	a5,-24(s0)
    8000237e:	97ba                	add	a5,a5,a4
    80002380:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002384:	fe043703          	ld	a4,-32(s0)
    80002388:	6785                	lui	a5,0x1
    8000238a:	97ba                	add	a5,a5,a4
    8000238c:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    80002390:	fb043783          	ld	a5,-80(s0)
    80002394:	ffa9                	bnez	a5,800022ee <copyout+0x1a>
  }
  return 0;
    80002396:	4781                	li	a5,0
}
    80002398:	853e                	mv	a0,a5
    8000239a:	60a6                	ld	ra,72(sp)
    8000239c:	6406                	ld	s0,64(sp)
    8000239e:	6161                	addi	sp,sp,80
    800023a0:	8082                	ret

00000000800023a2 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    800023a2:	715d                	addi	sp,sp,-80
    800023a4:	e486                	sd	ra,72(sp)
    800023a6:	e0a2                	sd	s0,64(sp)
    800023a8:	0880                	addi	s0,sp,80
    800023aa:	fca43423          	sd	a0,-56(s0)
    800023ae:	fcb43023          	sd	a1,-64(s0)
    800023b2:	fac43c23          	sd	a2,-72(s0)
    800023b6:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800023ba:	a055                	j	8000245e <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800023bc:	fb843703          	ld	a4,-72(s0)
    800023c0:	77fd                	lui	a5,0xfffff
    800023c2:	8ff9                	and	a5,a5,a4
    800023c4:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800023c8:	fe043583          	ld	a1,-32(s0)
    800023cc:	fc843503          	ld	a0,-56(s0)
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	7c8080e7          	jalr	1992(ra) # 80001b98 <walkaddr>
    800023d8:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800023dc:	fd843783          	ld	a5,-40(s0)
    800023e0:	e399                	bnez	a5,800023e6 <copyin+0x44>
      return -1;
    800023e2:	57fd                	li	a5,-1
    800023e4:	a049                	j	80002466 <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800023e6:	fe043703          	ld	a4,-32(s0)
    800023ea:	fb843783          	ld	a5,-72(s0)
    800023ee:	8f1d                	sub	a4,a4,a5
    800023f0:	6785                	lui	a5,0x1
    800023f2:	97ba                	add	a5,a5,a4
    800023f4:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    800023f8:	fe843703          	ld	a4,-24(s0)
    800023fc:	fb043783          	ld	a5,-80(s0)
    80002400:	00e7f663          	bgeu	a5,a4,8000240c <copyin+0x6a>
      n = len;
    80002404:	fb043783          	ld	a5,-80(s0)
    80002408:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000240c:	fb843703          	ld	a4,-72(s0)
    80002410:	fe043783          	ld	a5,-32(s0)
    80002414:	8f1d                	sub	a4,a4,a5
    80002416:	fd843783          	ld	a5,-40(s0)
    8000241a:	97ba                	add	a5,a5,a4
    8000241c:	873e                	mv	a4,a5
    8000241e:	fe843783          	ld	a5,-24(s0)
    80002422:	2781                	sext.w	a5,a5
    80002424:	863e                	mv	a2,a5
    80002426:	85ba                	mv	a1,a4
    80002428:	fc043503          	ld	a0,-64(s0)
    8000242c:	fffff097          	auipc	ra,0xfffff
    80002430:	10c080e7          	jalr	268(ra) # 80001538 <memmove>

    len -= n;
    80002434:	fb043703          	ld	a4,-80(s0)
    80002438:	fe843783          	ld	a5,-24(s0)
    8000243c:	40f707b3          	sub	a5,a4,a5
    80002440:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002444:	fc043703          	ld	a4,-64(s0)
    80002448:	fe843783          	ld	a5,-24(s0)
    8000244c:	97ba                	add	a5,a5,a4
    8000244e:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002452:	fe043703          	ld	a4,-32(s0)
    80002456:	6785                	lui	a5,0x1
    80002458:	97ba                	add	a5,a5,a4
    8000245a:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    8000245e:	fb043783          	ld	a5,-80(s0)
    80002462:	ffa9                	bnez	a5,800023bc <copyin+0x1a>
  }
  return 0;
    80002464:	4781                	li	a5,0
}
    80002466:	853e                	mv	a0,a5
    80002468:	60a6                	ld	ra,72(sp)
    8000246a:	6406                	ld	s0,64(sp)
    8000246c:	6161                	addi	sp,sp,80
    8000246e:	8082                	ret

0000000080002470 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80002470:	711d                	addi	sp,sp,-96
    80002472:	ec86                	sd	ra,88(sp)
    80002474:	e8a2                	sd	s0,80(sp)
    80002476:	1080                	addi	s0,sp,96
    80002478:	faa43c23          	sd	a0,-72(s0)
    8000247c:	fab43823          	sd	a1,-80(s0)
    80002480:	fac43423          	sd	a2,-88(s0)
    80002484:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    80002488:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    8000248c:	a0f1                	j	80002558 <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    8000248e:	fa843703          	ld	a4,-88(s0)
    80002492:	77fd                	lui	a5,0xfffff
    80002494:	8ff9                	and	a5,a5,a4
    80002496:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    8000249a:	fd043583          	ld	a1,-48(s0)
    8000249e:	fb843503          	ld	a0,-72(s0)
    800024a2:	fffff097          	auipc	ra,0xfffff
    800024a6:	6f6080e7          	jalr	1782(ra) # 80001b98 <walkaddr>
    800024aa:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800024ae:	fc843783          	ld	a5,-56(s0)
    800024b2:	e399                	bnez	a5,800024b8 <copyinstr+0x48>
      return -1;
    800024b4:	57fd                	li	a5,-1
    800024b6:	a87d                	j	80002574 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800024b8:	fd043703          	ld	a4,-48(s0)
    800024bc:	fa843783          	ld	a5,-88(s0)
    800024c0:	8f1d                	sub	a4,a4,a5
    800024c2:	6785                	lui	a5,0x1
    800024c4:	97ba                	add	a5,a5,a4
    800024c6:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800024ca:	fe843703          	ld	a4,-24(s0)
    800024ce:	fa043783          	ld	a5,-96(s0)
    800024d2:	00e7f663          	bgeu	a5,a4,800024de <copyinstr+0x6e>
      n = max;
    800024d6:	fa043783          	ld	a5,-96(s0)
    800024da:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800024de:	fa843703          	ld	a4,-88(s0)
    800024e2:	fd043783          	ld	a5,-48(s0)
    800024e6:	8f1d                	sub	a4,a4,a5
    800024e8:	fc843783          	ld	a5,-56(s0)
    800024ec:	97ba                	add	a5,a5,a4
    800024ee:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    800024f2:	a891                	j	80002546 <copyinstr+0xd6>
      if(*p == '\0'){
    800024f4:	fd843783          	ld	a5,-40(s0)
    800024f8:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    800024fc:	eb89                	bnez	a5,8000250e <copyinstr+0x9e>
        *dst = '\0';
    800024fe:	fb043783          	ld	a5,-80(s0)
    80002502:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80002506:	4785                	li	a5,1
    80002508:	fef42223          	sw	a5,-28(s0)
        break;
    8000250c:	a081                	j	8000254c <copyinstr+0xdc>
      } else {
        *dst = *p;
    8000250e:	fd843783          	ld	a5,-40(s0)
    80002512:	0007c703          	lbu	a4,0(a5)
    80002516:	fb043783          	ld	a5,-80(s0)
    8000251a:	00e78023          	sb	a4,0(a5)
      }
      --n;
    8000251e:	fe843783          	ld	a5,-24(s0)
    80002522:	17fd                	addi	a5,a5,-1
    80002524:	fef43423          	sd	a5,-24(s0)
      --max;
    80002528:	fa043783          	ld	a5,-96(s0)
    8000252c:	17fd                	addi	a5,a5,-1
    8000252e:	faf43023          	sd	a5,-96(s0)
      p++;
    80002532:	fd843783          	ld	a5,-40(s0)
    80002536:	0785                	addi	a5,a5,1
    80002538:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    8000253c:	fb043783          	ld	a5,-80(s0)
    80002540:	0785                	addi	a5,a5,1
    80002542:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    80002546:	fe843783          	ld	a5,-24(s0)
    8000254a:	f7cd                	bnez	a5,800024f4 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    8000254c:	fd043703          	ld	a4,-48(s0)
    80002550:	6785                	lui	a5,0x1
    80002552:	97ba                	add	a5,a5,a4
    80002554:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    80002558:	fe442783          	lw	a5,-28(s0)
    8000255c:	2781                	sext.w	a5,a5
    8000255e:	e781                	bnez	a5,80002566 <copyinstr+0xf6>
    80002560:	fa043783          	ld	a5,-96(s0)
    80002564:	f78d                	bnez	a5,8000248e <copyinstr+0x1e>
  }
  if(got_null){
    80002566:	fe442783          	lw	a5,-28(s0)
    8000256a:	2781                	sext.w	a5,a5
    8000256c:	c399                	beqz	a5,80002572 <copyinstr+0x102>
    return 0;
    8000256e:	4781                	li	a5,0
    80002570:	a011                	j	80002574 <copyinstr+0x104>
  } else {
    return -1;
    80002572:	57fd                	li	a5,-1
  }
}
    80002574:	853e                	mv	a0,a5
    80002576:	60e6                	ld	ra,88(sp)
    80002578:	6446                	ld	s0,80(sp)
    8000257a:	6125                	addi	sp,sp,96
    8000257c:	8082                	ret

000000008000257e <r_sstatus>:
{
    8000257e:	1101                	addi	sp,sp,-32
    80002580:	ec22                	sd	s0,24(sp)
    80002582:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002584:	100027f3          	csrr	a5,sstatus
    80002588:	fef43423          	sd	a5,-24(s0)
  return x;
    8000258c:	fe843783          	ld	a5,-24(s0)
}
    80002590:	853e                	mv	a0,a5
    80002592:	6462                	ld	s0,24(sp)
    80002594:	6105                	addi	sp,sp,32
    80002596:	8082                	ret

0000000080002598 <w_sstatus>:
{
    80002598:	1101                	addi	sp,sp,-32
    8000259a:	ec22                	sd	s0,24(sp)
    8000259c:	1000                	addi	s0,sp,32
    8000259e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025a2:	fe843783          	ld	a5,-24(s0)
    800025a6:	10079073          	csrw	sstatus,a5
}
    800025aa:	0001                	nop
    800025ac:	6462                	ld	s0,24(sp)
    800025ae:	6105                	addi	sp,sp,32
    800025b0:	8082                	ret

00000000800025b2 <intr_on>:
{
    800025b2:	1141                	addi	sp,sp,-16
    800025b4:	e406                	sd	ra,8(sp)
    800025b6:	e022                	sd	s0,0(sp)
    800025b8:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800025ba:	00000097          	auipc	ra,0x0
    800025be:	fc4080e7          	jalr	-60(ra) # 8000257e <r_sstatus>
    800025c2:	87aa                	mv	a5,a0
    800025c4:	0027e793          	ori	a5,a5,2
    800025c8:	853e                	mv	a0,a5
    800025ca:	00000097          	auipc	ra,0x0
    800025ce:	fce080e7          	jalr	-50(ra) # 80002598 <w_sstatus>
}
    800025d2:	0001                	nop
    800025d4:	60a2                	ld	ra,8(sp)
    800025d6:	6402                	ld	s0,0(sp)
    800025d8:	0141                	addi	sp,sp,16
    800025da:	8082                	ret

00000000800025dc <intr_get>:
{
    800025dc:	1101                	addi	sp,sp,-32
    800025de:	ec06                	sd	ra,24(sp)
    800025e0:	e822                	sd	s0,16(sp)
    800025e2:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800025e4:	00000097          	auipc	ra,0x0
    800025e8:	f9a080e7          	jalr	-102(ra) # 8000257e <r_sstatus>
    800025ec:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800025f0:	fe843783          	ld	a5,-24(s0)
    800025f4:	8b89                	andi	a5,a5,2
    800025f6:	00f037b3          	snez	a5,a5
    800025fa:	0ff7f793          	andi	a5,a5,255
    800025fe:	2781                	sext.w	a5,a5
}
    80002600:	853e                	mv	a0,a5
    80002602:	60e2                	ld	ra,24(sp)
    80002604:	6442                	ld	s0,16(sp)
    80002606:	6105                	addi	sp,sp,32
    80002608:	8082                	ret

000000008000260a <r_tp>:
{
    8000260a:	1101                	addi	sp,sp,-32
    8000260c:	ec22                	sd	s0,24(sp)
    8000260e:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002610:	8792                	mv	a5,tp
    80002612:	fef43423          	sd	a5,-24(s0)
  return x;
    80002616:	fe843783          	ld	a5,-24(s0)
}
    8000261a:	853e                	mv	a0,a5
    8000261c:	6462                	ld	s0,24(sp)
    8000261e:	6105                	addi	sp,sp,32
    80002620:	8082                	ret

0000000080002622 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80002622:	7139                	addi	sp,sp,-64
    80002624:	fc06                	sd	ra,56(sp)
    80002626:	f822                	sd	s0,48(sp)
    80002628:	0080                	addi	s0,sp,64
    8000262a:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000262e:	00012797          	auipc	a5,0x12
    80002632:	06a78793          	addi	a5,a5,106 # 80014698 <proc>
    80002636:	fef43423          	sd	a5,-24(s0)
    8000263a:	a071                	j	800026c6 <proc_mapstacks+0xa4>
    char *pa = kalloc();
    8000263c:	fffff097          	auipc	ra,0xfffff
    80002640:	af0080e7          	jalr	-1296(ra) # 8000112c <kalloc>
    80002644:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80002648:	fe043783          	ld	a5,-32(s0)
    8000264c:	eb89                	bnez	a5,8000265e <proc_mapstacks+0x3c>
      panic("kalloc");
    8000264e:	00009517          	auipc	a0,0x9
    80002652:	b5a50513          	addi	a0,a0,-1190 # 8000b1a8 <etext+0x1a8>
    80002656:	ffffe097          	auipc	ra,0xffffe
    8000265a:	5fc080e7          	jalr	1532(ra) # 80000c52 <panic>
    uint64 va = KSTACK((int) (p - proc));
    8000265e:	fe843703          	ld	a4,-24(s0)
    80002662:	00012797          	auipc	a5,0x12
    80002666:	03678793          	addi	a5,a5,54 # 80014698 <proc>
    8000266a:	40f707b3          	sub	a5,a4,a5
    8000266e:	4047d713          	srai	a4,a5,0x4
    80002672:	00009797          	auipc	a5,0x9
    80002676:	c1e78793          	addi	a5,a5,-994 # 8000b290 <etext+0x290>
    8000267a:	639c                	ld	a5,0(a5)
    8000267c:	02f707b3          	mul	a5,a4,a5
    80002680:	2781                	sext.w	a5,a5
    80002682:	2785                	addiw	a5,a5,1
    80002684:	2781                	sext.w	a5,a5
    80002686:	00d7979b          	slliw	a5,a5,0xd
    8000268a:	2781                	sext.w	a5,a5
    8000268c:	873e                	mv	a4,a5
    8000268e:	040007b7          	lui	a5,0x4000
    80002692:	17fd                	addi	a5,a5,-1
    80002694:	07b2                	slli	a5,a5,0xc
    80002696:	8f99                	sub	a5,a5,a4
    80002698:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    8000269c:	fe043783          	ld	a5,-32(s0)
    800026a0:	4719                	li	a4,6
    800026a2:	6685                	lui	a3,0x1
    800026a4:	863e                	mv	a2,a5
    800026a6:	fd843583          	ld	a1,-40(s0)
    800026aa:	fc843503          	ld	a0,-56(s0)
    800026ae:	fffff097          	auipc	ra,0xfffff
    800026b2:	562080e7          	jalr	1378(ra) # 80001c10 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800026b6:	fe843703          	ld	a4,-24(s0)
    800026ba:	6785                	lui	a5,0x1
    800026bc:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    800026c0:	97ba                	add	a5,a5,a4
    800026c2:	fef43423          	sd	a5,-24(s0)
    800026c6:	fe843703          	ld	a4,-24(s0)
    800026ca:	00061797          	auipc	a5,0x61
    800026ce:	3ce78793          	addi	a5,a5,974 # 80063a98 <pid_lock>
    800026d2:	f6f765e3          	bltu	a4,a5,8000263c <proc_mapstacks+0x1a>
  }
}
    800026d6:	0001                	nop
    800026d8:	0001                	nop
    800026da:	70e2                	ld	ra,56(sp)
    800026dc:	7442                	ld	s0,48(sp)
    800026de:	6121                	addi	sp,sp,64
    800026e0:	8082                	ret

00000000800026e2 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800026e2:	1101                	addi	sp,sp,-32
    800026e4:	ec06                	sd	ra,24(sp)
    800026e6:	e822                	sd	s0,16(sp)
    800026e8:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800026ea:	00009597          	auipc	a1,0x9
    800026ee:	ac658593          	addi	a1,a1,-1338 # 8000b1b0 <etext+0x1b0>
    800026f2:	00061517          	auipc	a0,0x61
    800026f6:	3a650513          	addi	a0,a0,934 # 80063a98 <pid_lock>
    800026fa:	fffff097          	auipc	ra,0xfffff
    800026fe:	b56080e7          	jalr	-1194(ra) # 80001250 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002702:	00012797          	auipc	a5,0x12
    80002706:	f9678793          	addi	a5,a5,-106 # 80014698 <proc>
    8000270a:	fef43423          	sd	a5,-24(s0)
    8000270e:	a885                	j	8000277e <procinit+0x9c>
      initlock(&p->lock, "proc");
    80002710:	fe843783          	ld	a5,-24(s0)
    80002714:	00009597          	auipc	a1,0x9
    80002718:	aa458593          	addi	a1,a1,-1372 # 8000b1b8 <etext+0x1b8>
    8000271c:	853e                	mv	a0,a5
    8000271e:	fffff097          	auipc	ra,0xfffff
    80002722:	b32080e7          	jalr	-1230(ra) # 80001250 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80002726:	fe843703          	ld	a4,-24(s0)
    8000272a:	00012797          	auipc	a5,0x12
    8000272e:	f6e78793          	addi	a5,a5,-146 # 80014698 <proc>
    80002732:	40f707b3          	sub	a5,a4,a5
    80002736:	4047d713          	srai	a4,a5,0x4
    8000273a:	00009797          	auipc	a5,0x9
    8000273e:	b5678793          	addi	a5,a5,-1194 # 8000b290 <etext+0x290>
    80002742:	639c                	ld	a5,0(a5)
    80002744:	02f707b3          	mul	a5,a4,a5
    80002748:	2781                	sext.w	a5,a5
    8000274a:	2785                	addiw	a5,a5,1
    8000274c:	2781                	sext.w	a5,a5
    8000274e:	00d7979b          	slliw	a5,a5,0xd
    80002752:	2781                	sext.w	a5,a5
    80002754:	873e                	mv	a4,a5
    80002756:	040007b7          	lui	a5,0x4000
    8000275a:	17fd                	addi	a5,a5,-1
    8000275c:	07b2                	slli	a5,a5,0xc
    8000275e:	8f99                	sub	a5,a5,a4
    80002760:	86be                	mv	a3,a5
    80002762:	fe843703          	ld	a4,-24(s0)
    80002766:	6785                	lui	a5,0x1
    80002768:	97ba                	add	a5,a5,a4
    8000276a:	2ad7b423          	sd	a3,680(a5) # 12a8 <_entry-0x7fffed58>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000276e:	fe843703          	ld	a4,-24(s0)
    80002772:	6785                	lui	a5,0x1
    80002774:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    80002778:	97ba                	add	a5,a5,a4
    8000277a:	fef43423          	sd	a5,-24(s0)
    8000277e:	fe843703          	ld	a4,-24(s0)
    80002782:	00061797          	auipc	a5,0x61
    80002786:	31678793          	addi	a5,a5,790 # 80063a98 <pid_lock>
    8000278a:	f8f763e3          	bltu	a4,a5,80002710 <procinit+0x2e>
  }
}
    8000278e:	0001                	nop
    80002790:	0001                	nop
    80002792:	60e2                	ld	ra,24(sp)
    80002794:	6442                	ld	s0,16(sp)
    80002796:	6105                	addi	sp,sp,32
    80002798:	8082                	ret

000000008000279a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    8000279a:	1101                	addi	sp,sp,-32
    8000279c:	ec06                	sd	ra,24(sp)
    8000279e:	e822                	sd	s0,16(sp)
    800027a0:	1000                	addi	s0,sp,32
  int id = r_tp();
    800027a2:	00000097          	auipc	ra,0x0
    800027a6:	e68080e7          	jalr	-408(ra) # 8000260a <r_tp>
    800027aa:	87aa                	mv	a5,a0
    800027ac:	fef42623          	sw	a5,-20(s0)
  return id;
    800027b0:	fec42783          	lw	a5,-20(s0)
}
    800027b4:	853e                	mv	a0,a5
    800027b6:	60e2                	ld	ra,24(sp)
    800027b8:	6442                	ld	s0,16(sp)
    800027ba:	6105                	addi	sp,sp,32
    800027bc:	8082                	ret

00000000800027be <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    800027be:	1101                	addi	sp,sp,-32
    800027c0:	ec06                	sd	ra,24(sp)
    800027c2:	e822                	sd	s0,16(sp)
    800027c4:	1000                	addi	s0,sp,32
  int id = cpuid();
    800027c6:	00000097          	auipc	ra,0x0
    800027ca:	fd4080e7          	jalr	-44(ra) # 8000279a <cpuid>
    800027ce:	87aa                	mv	a5,a0
    800027d0:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800027d4:	fec42783          	lw	a5,-20(s0)
    800027d8:	00779713          	slli	a4,a5,0x7
    800027dc:	00012797          	auipc	a5,0x12
    800027e0:	abc78793          	addi	a5,a5,-1348 # 80014298 <cpus>
    800027e4:	97ba                	add	a5,a5,a4
    800027e6:	fef43023          	sd	a5,-32(s0)
  return c;
    800027ea:	fe043783          	ld	a5,-32(s0)
}
    800027ee:	853e                	mv	a0,a5
    800027f0:	60e2                	ld	ra,24(sp)
    800027f2:	6442                	ld	s0,16(sp)
    800027f4:	6105                	addi	sp,sp,32
    800027f6:	8082                	ret

00000000800027f8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    800027f8:	1101                	addi	sp,sp,-32
    800027fa:	ec06                	sd	ra,24(sp)
    800027fc:	e822                	sd	s0,16(sp)
    800027fe:	1000                	addi	s0,sp,32
  push_off();
    80002800:	fffff097          	auipc	ra,0xfffff
    80002804:	b7e080e7          	jalr	-1154(ra) # 8000137e <push_off>
  struct cpu *c = mycpu();
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	fb6080e7          	jalr	-74(ra) # 800027be <mycpu>
    80002810:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002814:	fe843783          	ld	a5,-24(s0)
    80002818:	639c                	ld	a5,0(a5)
    8000281a:	fef43023          	sd	a5,-32(s0)
  pop_off();
    8000281e:	fffff097          	auipc	ra,0xfffff
    80002822:	bb8080e7          	jalr	-1096(ra) # 800013d6 <pop_off>
  return p;
    80002826:	fe043783          	ld	a5,-32(s0)
}
    8000282a:	853e                	mv	a0,a5
    8000282c:	60e2                	ld	ra,24(sp)
    8000282e:	6442                	ld	s0,16(sp)
    80002830:	6105                	addi	sp,sp,32
    80002832:	8082                	ret

0000000080002834 <allocpid>:

int
allocpid() {
    80002834:	1101                	addi	sp,sp,-32
    80002836:	ec06                	sd	ra,24(sp)
    80002838:	e822                	sd	s0,16(sp)
    8000283a:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    8000283c:	00061517          	auipc	a0,0x61
    80002840:	25c50513          	addi	a0,a0,604 # 80063a98 <pid_lock>
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	a3c080e7          	jalr	-1476(ra) # 80001280 <acquire>
  pid = nextpid;
    8000284c:	00009797          	auipc	a5,0x9
    80002850:	f0478793          	addi	a5,a5,-252 # 8000b750 <nextpid>
    80002854:	439c                	lw	a5,0(a5)
    80002856:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    8000285a:	00009797          	auipc	a5,0x9
    8000285e:	ef678793          	addi	a5,a5,-266 # 8000b750 <nextpid>
    80002862:	439c                	lw	a5,0(a5)
    80002864:	2785                	addiw	a5,a5,1
    80002866:	0007871b          	sext.w	a4,a5
    8000286a:	00009797          	auipc	a5,0x9
    8000286e:	ee678793          	addi	a5,a5,-282 # 8000b750 <nextpid>
    80002872:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002874:	00061517          	auipc	a0,0x61
    80002878:	22450513          	addi	a0,a0,548 # 80063a98 <pid_lock>
    8000287c:	fffff097          	auipc	ra,0xfffff
    80002880:	a68080e7          	jalr	-1432(ra) # 800012e4 <release>

  return pid;
    80002884:	fec42783          	lw	a5,-20(s0)
}
    80002888:	853e                	mv	a0,a5
    8000288a:	60e2                	ld	ra,24(sp)
    8000288c:	6442                	ld	s0,16(sp)
    8000288e:	6105                	addi	sp,sp,32
    80002890:	8082                	ret

0000000080002892 <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    80002892:	1101                	addi	sp,sp,-32
    80002894:	ec06                	sd	ra,24(sp)
    80002896:	e822                	sd	s0,16(sp)
    80002898:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000289a:	00012797          	auipc	a5,0x12
    8000289e:	dfe78793          	addi	a5,a5,-514 # 80014698 <proc>
    800028a2:	fef43423          	sd	a5,-24(s0)
    800028a6:	a81d                	j	800028dc <allocproc+0x4a>
    acquire(&p->lock);
    800028a8:	fe843783          	ld	a5,-24(s0)
    800028ac:	853e                	mv	a0,a5
    800028ae:	fffff097          	auipc	ra,0xfffff
    800028b2:	9d2080e7          	jalr	-1582(ra) # 80001280 <acquire>
    if(p->state == UNUSED) {
    800028b6:	fe843783          	ld	a5,-24(s0)
    800028ba:	4f9c                	lw	a5,24(a5)
    800028bc:	cb95                	beqz	a5,800028f0 <allocproc+0x5e>
      goto found;
    } else {
      release(&p->lock);
    800028be:	fe843783          	ld	a5,-24(s0)
    800028c2:	853e                	mv	a0,a5
    800028c4:	fffff097          	auipc	ra,0xfffff
    800028c8:	a20080e7          	jalr	-1504(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800028cc:	fe843703          	ld	a4,-24(s0)
    800028d0:	6785                	lui	a5,0x1
    800028d2:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    800028d6:	97ba                	add	a5,a5,a4
    800028d8:	fef43423          	sd	a5,-24(s0)
    800028dc:	fe843703          	ld	a4,-24(s0)
    800028e0:	00061797          	auipc	a5,0x61
    800028e4:	1b878793          	addi	a5,a5,440 # 80063a98 <pid_lock>
    800028e8:	fcf760e3          	bltu	a4,a5,800028a8 <allocproc+0x16>
    }
  }
  return 0;
    800028ec:	4781                	li	a5,0
    800028ee:	a2b1                	j	80002a3a <allocproc+0x1a8>
      goto found;
    800028f0:	0001                	nop

found:
  p->pid = allocpid();
    800028f2:	00000097          	auipc	ra,0x0
    800028f6:	f42080e7          	jalr	-190(ra) # 80002834 <allocpid>
    800028fa:	87aa                	mv	a5,a0
    800028fc:	873e                	mv	a4,a5
    800028fe:	fe843783          	ld	a5,-24(s0)
    80002902:	df98                	sw	a4,56(a5)

  // for mp3
  p->thrdstop_ticks = 0;
    80002904:	fe843783          	ld	a5,-24(s0)
    80002908:	0207ae23          	sw	zero,60(a5)
  p->thrdstop_delay = -1;
    8000290c:	fe843783          	ld	a5,-24(s0)
    80002910:	577d                	li	a4,-1
    80002912:	c3b8                	sw	a4,64(a5)
  p->jump_flag = 0;
    80002914:	fe843703          	ld	a4,-24(s0)
    80002918:	6785                	lui	a5,0x1
    8000291a:	97ba                	add	a5,a5,a4
    8000291c:	2807ac23          	sw	zero,664(a5) # 1298 <_entry-0x7fffed68>
  p->resume_flag = -1;
    80002920:	fe843703          	ld	a4,-24(s0)
    80002924:	6785                	lui	a5,0x1
    80002926:	97ba                	add	a5,a5,a4
    80002928:	577d                	li	a4,-1
    8000292a:	28e7ae23          	sw	a4,668(a5) # 129c <_entry-0x7fffed64>
  p->cancel_save_flag = -1;
    8000292e:	fe843703          	ld	a4,-24(s0)
    80002932:	6785                	lui	a5,0x1
    80002934:	97ba                	add	a5,a5,a4
    80002936:	577d                	li	a4,-1
    80002938:	2ae7a023          	sw	a4,672(a5) # 12a0 <_entry-0x7fffed60>
  int i;
  for (i = 0; i < MAX_THRD_NUM; i++)
    8000293c:	fe042223          	sw	zero,-28(s0)
    80002940:	a005                	j	80002960 <allocproc+0xce>
  {
    p->thrdstop_context_used[i] = 0;
    80002942:	fe843703          	ld	a4,-24(s0)
    80002946:	fe442783          	lw	a5,-28(s0)
    8000294a:	49478793          	addi	a5,a5,1172
    8000294e:	078a                	slli	a5,a5,0x2
    80002950:	97ba                	add	a5,a5,a4
    80002952:	0007a423          	sw	zero,8(a5)
  for (i = 0; i < MAX_THRD_NUM; i++)
    80002956:	fe442783          	lw	a5,-28(s0)
    8000295a:	2785                	addiw	a5,a5,1
    8000295c:	fef42223          	sw	a5,-28(s0)
    80002960:	fe442783          	lw	a5,-28(s0)
    80002964:	0007871b          	sext.w	a4,a5
    80002968:	47bd                	li	a5,15
    8000296a:	fce7dce3          	bge	a5,a4,80002942 <allocproc+0xb0>
  }

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000296e:	ffffe097          	auipc	ra,0xffffe
    80002972:	7be080e7          	jalr	1982(ra) # 8000112c <kalloc>
    80002976:	86aa                	mv	a3,a0
    80002978:	fe843703          	ld	a4,-24(s0)
    8000297c:	6785                	lui	a5,0x1
    8000297e:	97ba                	add	a5,a5,a4
    80002980:	2cd7b023          	sd	a3,704(a5) # 12c0 <_entry-0x7fffed40>
    80002984:	fe843703          	ld	a4,-24(s0)
    80002988:	6785                	lui	a5,0x1
    8000298a:	97ba                	add	a5,a5,a4
    8000298c:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002990:	eb91                	bnez	a5,800029a4 <allocproc+0x112>
    release(&p->lock);
    80002992:	fe843783          	ld	a5,-24(s0)
    80002996:	853e                	mv	a0,a5
    80002998:	fffff097          	auipc	ra,0xfffff
    8000299c:	94c080e7          	jalr	-1716(ra) # 800012e4 <release>
    return 0;
    800029a0:	4781                	li	a5,0
    800029a2:	a861                	j	80002a3a <allocproc+0x1a8>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    800029a4:	fe843503          	ld	a0,-24(s0)
    800029a8:	00000097          	auipc	ra,0x0
    800029ac:	168080e7          	jalr	360(ra) # 80002b10 <proc_pagetable>
    800029b0:	86aa                	mv	a3,a0
    800029b2:	fe843703          	ld	a4,-24(s0)
    800029b6:	6785                	lui	a5,0x1
    800029b8:	97ba                	add	a5,a5,a4
    800029ba:	2ad7bc23          	sd	a3,696(a5) # 12b8 <_entry-0x7fffed48>
  if(p->pagetable == 0){
    800029be:	fe843703          	ld	a4,-24(s0)
    800029c2:	6785                	lui	a5,0x1
    800029c4:	97ba                	add	a5,a5,a4
    800029c6:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    800029ca:	e385                	bnez	a5,800029ea <allocproc+0x158>
    freeproc(p);
    800029cc:	fe843503          	ld	a0,-24(s0)
    800029d0:	00000097          	auipc	ra,0x0
    800029d4:	074080e7          	jalr	116(ra) # 80002a44 <freeproc>
    release(&p->lock);
    800029d8:	fe843783          	ld	a5,-24(s0)
    800029dc:	853e                	mv	a0,a5
    800029de:	fffff097          	auipc	ra,0xfffff
    800029e2:	906080e7          	jalr	-1786(ra) # 800012e4 <release>
    return 0;
    800029e6:	4781                	li	a5,0
    800029e8:	a889                	j	80002a3a <allocproc+0x1a8>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    800029ea:	fe843703          	ld	a4,-24(s0)
    800029ee:	6785                	lui	a5,0x1
    800029f0:	2c878793          	addi	a5,a5,712 # 12c8 <_entry-0x7fffed38>
    800029f4:	97ba                	add	a5,a5,a4
    800029f6:	07000613          	li	a2,112
    800029fa:	4581                	li	a1,0
    800029fc:	853e                	mv	a0,a5
    800029fe:	fffff097          	auipc	ra,0xfffff
    80002a02:	a56080e7          	jalr	-1450(ra) # 80001454 <memset>
  p->context.ra = (uint64)forkret;
    80002a06:	00001717          	auipc	a4,0x1
    80002a0a:	aee70713          	addi	a4,a4,-1298 # 800034f4 <forkret>
    80002a0e:	fe843683          	ld	a3,-24(s0)
    80002a12:	6785                	lui	a5,0x1
    80002a14:	97b6                	add	a5,a5,a3
    80002a16:	2ce7b423          	sd	a4,712(a5) # 12c8 <_entry-0x7fffed38>
  p->context.sp = p->kstack + PGSIZE;
    80002a1a:	fe843703          	ld	a4,-24(s0)
    80002a1e:	6785                	lui	a5,0x1
    80002a20:	97ba                	add	a5,a5,a4
    80002a22:	2a87b703          	ld	a4,680(a5) # 12a8 <_entry-0x7fffed58>
    80002a26:	6785                	lui	a5,0x1
    80002a28:	973e                	add	a4,a4,a5
    80002a2a:	fe843683          	ld	a3,-24(s0)
    80002a2e:	6785                	lui	a5,0x1
    80002a30:	97b6                	add	a5,a5,a3
    80002a32:	2ce7b823          	sd	a4,720(a5) # 12d0 <_entry-0x7fffed30>

  return p;
    80002a36:	fe843783          	ld	a5,-24(s0)
}
    80002a3a:	853e                	mv	a0,a5
    80002a3c:	60e2                	ld	ra,24(sp)
    80002a3e:	6442                	ld	s0,16(sp)
    80002a40:	6105                	addi	sp,sp,32
    80002a42:	8082                	ret

0000000080002a44 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002a44:	1101                	addi	sp,sp,-32
    80002a46:	ec06                	sd	ra,24(sp)
    80002a48:	e822                	sd	s0,16(sp)
    80002a4a:	1000                	addi	s0,sp,32
    80002a4c:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002a50:	fe843703          	ld	a4,-24(s0)
    80002a54:	6785                	lui	a5,0x1
    80002a56:	97ba                	add	a5,a5,a4
    80002a58:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002a5c:	cf81                	beqz	a5,80002a74 <freeproc+0x30>
    kfree((void*)p->trapframe);
    80002a5e:	fe843703          	ld	a4,-24(s0)
    80002a62:	6785                	lui	a5,0x1
    80002a64:	97ba                	add	a5,a5,a4
    80002a66:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002a6a:	853e                	mv	a0,a5
    80002a6c:	ffffe097          	auipc	ra,0xffffe
    80002a70:	61c080e7          	jalr	1564(ra) # 80001088 <kfree>
  p->trapframe = 0;
    80002a74:	fe843703          	ld	a4,-24(s0)
    80002a78:	6785                	lui	a5,0x1
    80002a7a:	97ba                	add	a5,a5,a4
    80002a7c:	2c07b023          	sd	zero,704(a5) # 12c0 <_entry-0x7fffed40>
  if(p->pagetable)
    80002a80:	fe843703          	ld	a4,-24(s0)
    80002a84:	6785                	lui	a5,0x1
    80002a86:	97ba                	add	a5,a5,a4
    80002a88:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002a8c:	c39d                	beqz	a5,80002ab2 <freeproc+0x6e>
    proc_freepagetable(p->pagetable, p->sz);
    80002a8e:	fe843703          	ld	a4,-24(s0)
    80002a92:	6785                	lui	a5,0x1
    80002a94:	97ba                	add	a5,a5,a4
    80002a96:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    80002a9a:	fe843703          	ld	a4,-24(s0)
    80002a9e:	6785                	lui	a5,0x1
    80002aa0:	97ba                	add	a5,a5,a4
    80002aa2:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002aa6:	85be                	mv	a1,a5
    80002aa8:	8536                	mv	a0,a3
    80002aaa:	00000097          	auipc	ra,0x0
    80002aae:	12c080e7          	jalr	300(ra) # 80002bd6 <proc_freepagetable>
  p->pagetable = 0;
    80002ab2:	fe843703          	ld	a4,-24(s0)
    80002ab6:	6785                	lui	a5,0x1
    80002ab8:	97ba                	add	a5,a5,a4
    80002aba:	2a07bc23          	sd	zero,696(a5) # 12b8 <_entry-0x7fffed48>
  p->sz = 0;
    80002abe:	fe843703          	ld	a4,-24(s0)
    80002ac2:	6785                	lui	a5,0x1
    80002ac4:	97ba                	add	a5,a5,a4
    80002ac6:	2a07b823          	sd	zero,688(a5) # 12b0 <_entry-0x7fffed50>
  p->pid = 0;
    80002aca:	fe843783          	ld	a5,-24(s0)
    80002ace:	0207ac23          	sw	zero,56(a5)
  p->parent = 0;
    80002ad2:	fe843783          	ld	a5,-24(s0)
    80002ad6:	0207b023          	sd	zero,32(a5)
  p->name[0] = 0;
    80002ada:	fe843703          	ld	a4,-24(s0)
    80002ade:	6785                	lui	a5,0x1
    80002ae0:	97ba                	add	a5,a5,a4
    80002ae2:	3c078023          	sb	zero,960(a5) # 13c0 <_entry-0x7fffec40>
  p->chan = 0;
    80002ae6:	fe843783          	ld	a5,-24(s0)
    80002aea:	0207b423          	sd	zero,40(a5)
  p->killed = 0;
    80002aee:	fe843783          	ld	a5,-24(s0)
    80002af2:	0207a823          	sw	zero,48(a5)
  p->xstate = 0;
    80002af6:	fe843783          	ld	a5,-24(s0)
    80002afa:	0207aa23          	sw	zero,52(a5)
  p->state = UNUSED;
    80002afe:	fe843783          	ld	a5,-24(s0)
    80002b02:	0007ac23          	sw	zero,24(a5)
}
    80002b06:	0001                	nop
    80002b08:	60e2                	ld	ra,24(sp)
    80002b0a:	6442                	ld	s0,16(sp)
    80002b0c:	6105                	addi	sp,sp,32
    80002b0e:	8082                	ret

0000000080002b10 <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002b10:	7179                	addi	sp,sp,-48
    80002b12:	f406                	sd	ra,40(sp)
    80002b14:	f022                	sd	s0,32(sp)
    80002b16:	1800                	addi	s0,sp,48
    80002b18:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002b1c:	fffff097          	auipc	ra,0xfffff
    80002b20:	316080e7          	jalr	790(ra) # 80001e32 <uvmcreate>
    80002b24:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002b28:	fe843783          	ld	a5,-24(s0)
    80002b2c:	e399                	bnez	a5,80002b32 <proc_pagetable+0x22>
    return 0;
    80002b2e:	4781                	li	a5,0
    80002b30:	a871                	j	80002bcc <proc_pagetable+0xbc>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002b32:	00007797          	auipc	a5,0x7
    80002b36:	4ce78793          	addi	a5,a5,1230 # 8000a000 <_trampoline>
    80002b3a:	4729                	li	a4,10
    80002b3c:	86be                	mv	a3,a5
    80002b3e:	6605                	lui	a2,0x1
    80002b40:	040007b7          	lui	a5,0x4000
    80002b44:	17fd                	addi	a5,a5,-1
    80002b46:	00c79593          	slli	a1,a5,0xc
    80002b4a:	fe843503          	ld	a0,-24(s0)
    80002b4e:	fffff097          	auipc	ra,0xfffff
    80002b52:	11c080e7          	jalr	284(ra) # 80001c6a <mappages>
    80002b56:	87aa                	mv	a5,a0
    80002b58:	0007db63          	bgez	a5,80002b6e <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002b5c:	4581                	li	a1,0
    80002b5e:	fe843503          	ld	a0,-24(s0)
    80002b62:	fffff097          	auipc	ra,0xfffff
    80002b66:	5be080e7          	jalr	1470(ra) # 80002120 <uvmfree>
    return 0;
    80002b6a:	4781                	li	a5,0
    80002b6c:	a085                	j	80002bcc <proc_pagetable+0xbc>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002b6e:	fd843703          	ld	a4,-40(s0)
    80002b72:	6785                	lui	a5,0x1
    80002b74:	97ba                	add	a5,a5,a4
    80002b76:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002b7a:	4719                	li	a4,6
    80002b7c:	86be                	mv	a3,a5
    80002b7e:	6605                	lui	a2,0x1
    80002b80:	020007b7          	lui	a5,0x2000
    80002b84:	17fd                	addi	a5,a5,-1
    80002b86:	00d79593          	slli	a1,a5,0xd
    80002b8a:	fe843503          	ld	a0,-24(s0)
    80002b8e:	fffff097          	auipc	ra,0xfffff
    80002b92:	0dc080e7          	jalr	220(ra) # 80001c6a <mappages>
    80002b96:	87aa                	mv	a5,a0
    80002b98:	0207d863          	bgez	a5,80002bc8 <proc_pagetable+0xb8>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002b9c:	4681                	li	a3,0
    80002b9e:	4605                	li	a2,1
    80002ba0:	040007b7          	lui	a5,0x4000
    80002ba4:	17fd                	addi	a5,a5,-1
    80002ba6:	00c79593          	slli	a1,a5,0xc
    80002baa:	fe843503          	ld	a0,-24(s0)
    80002bae:	fffff097          	auipc	ra,0xfffff
    80002bb2:	184080e7          	jalr	388(ra) # 80001d32 <uvmunmap>
    uvmfree(pagetable, 0);
    80002bb6:	4581                	li	a1,0
    80002bb8:	fe843503          	ld	a0,-24(s0)
    80002bbc:	fffff097          	auipc	ra,0xfffff
    80002bc0:	564080e7          	jalr	1380(ra) # 80002120 <uvmfree>
    return 0;
    80002bc4:	4781                	li	a5,0
    80002bc6:	a019                	j	80002bcc <proc_pagetable+0xbc>
  }

  return pagetable;
    80002bc8:	fe843783          	ld	a5,-24(s0)
}
    80002bcc:	853e                	mv	a0,a5
    80002bce:	70a2                	ld	ra,40(sp)
    80002bd0:	7402                	ld	s0,32(sp)
    80002bd2:	6145                	addi	sp,sp,48
    80002bd4:	8082                	ret

0000000080002bd6 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002bd6:	1101                	addi	sp,sp,-32
    80002bd8:	ec06                	sd	ra,24(sp)
    80002bda:	e822                	sd	s0,16(sp)
    80002bdc:	1000                	addi	s0,sp,32
    80002bde:	fea43423          	sd	a0,-24(s0)
    80002be2:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002be6:	4681                	li	a3,0
    80002be8:	4605                	li	a2,1
    80002bea:	040007b7          	lui	a5,0x4000
    80002bee:	17fd                	addi	a5,a5,-1
    80002bf0:	00c79593          	slli	a1,a5,0xc
    80002bf4:	fe843503          	ld	a0,-24(s0)
    80002bf8:	fffff097          	auipc	ra,0xfffff
    80002bfc:	13a080e7          	jalr	314(ra) # 80001d32 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002c00:	4681                	li	a3,0
    80002c02:	4605                	li	a2,1
    80002c04:	020007b7          	lui	a5,0x2000
    80002c08:	17fd                	addi	a5,a5,-1
    80002c0a:	00d79593          	slli	a1,a5,0xd
    80002c0e:	fe843503          	ld	a0,-24(s0)
    80002c12:	fffff097          	auipc	ra,0xfffff
    80002c16:	120080e7          	jalr	288(ra) # 80001d32 <uvmunmap>
  uvmfree(pagetable, sz);
    80002c1a:	fe043583          	ld	a1,-32(s0)
    80002c1e:	fe843503          	ld	a0,-24(s0)
    80002c22:	fffff097          	auipc	ra,0xfffff
    80002c26:	4fe080e7          	jalr	1278(ra) # 80002120 <uvmfree>
}
    80002c2a:	0001                	nop
    80002c2c:	60e2                	ld	ra,24(sp)
    80002c2e:	6442                	ld	s0,16(sp)
    80002c30:	6105                	addi	sp,sp,32
    80002c32:	8082                	ret

0000000080002c34 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002c34:	1101                	addi	sp,sp,-32
    80002c36:	ec06                	sd	ra,24(sp)
    80002c38:	e822                	sd	s0,16(sp)
    80002c3a:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002c3c:	00000097          	auipc	ra,0x0
    80002c40:	c56080e7          	jalr	-938(ra) # 80002892 <allocproc>
    80002c44:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002c48:	00009797          	auipc	a5,0x9
    80002c4c:	3d078793          	addi	a5,a5,976 # 8000c018 <initproc>
    80002c50:	fe843703          	ld	a4,-24(s0)
    80002c54:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002c56:	fe843703          	ld	a4,-24(s0)
    80002c5a:	6785                	lui	a5,0x1
    80002c5c:	97ba                	add	a5,a5,a4
    80002c5e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002c62:	03400613          	li	a2,52
    80002c66:	00009597          	auipc	a1,0x9
    80002c6a:	b1258593          	addi	a1,a1,-1262 # 8000b778 <initcode>
    80002c6e:	853e                	mv	a0,a5
    80002c70:	fffff097          	auipc	ra,0xfffff
    80002c74:	1fe080e7          	jalr	510(ra) # 80001e6e <uvminit>
  p->sz = PGSIZE;
    80002c78:	fe843703          	ld	a4,-24(s0)
    80002c7c:	6785                	lui	a5,0x1
    80002c7e:	97ba                	add	a5,a5,a4
    80002c80:	6705                	lui	a4,0x1
    80002c82:	2ae7b823          	sd	a4,688(a5) # 12b0 <_entry-0x7fffed50>

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002c86:	fe843703          	ld	a4,-24(s0)
    80002c8a:	6785                	lui	a5,0x1
    80002c8c:	97ba                	add	a5,a5,a4
    80002c8e:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002c92:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002c96:	fe843703          	ld	a4,-24(s0)
    80002c9a:	6785                	lui	a5,0x1
    80002c9c:	97ba                	add	a5,a5,a4
    80002c9e:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002ca2:	6705                	lui	a4,0x1
    80002ca4:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002ca6:	fe843703          	ld	a4,-24(s0)
    80002caa:	6785                	lui	a5,0x1
    80002cac:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    80002cb0:	97ba                	add	a5,a5,a4
    80002cb2:	4641                	li	a2,16
    80002cb4:	00008597          	auipc	a1,0x8
    80002cb8:	50c58593          	addi	a1,a1,1292 # 8000b1c0 <etext+0x1c0>
    80002cbc:	853e                	mv	a0,a5
    80002cbe:	fffff097          	auipc	ra,0xfffff
    80002cc2:	a8c080e7          	jalr	-1396(ra) # 8000174a <safestrcpy>
  p->cwd = namei("/");
    80002cc6:	00008517          	auipc	a0,0x8
    80002cca:	50a50513          	addi	a0,a0,1290 # 8000b1d0 <etext+0x1d0>
    80002cce:	00003097          	auipc	ra,0x3
    80002cd2:	45e080e7          	jalr	1118(ra) # 8000612c <namei>
    80002cd6:	86aa                	mv	a3,a0
    80002cd8:	fe843703          	ld	a4,-24(s0)
    80002cdc:	6785                	lui	a5,0x1
    80002cde:	97ba                	add	a5,a5,a4
    80002ce0:	3ad7bc23          	sd	a3,952(a5) # 13b8 <_entry-0x7fffec48>

  p->state = RUNNABLE;
    80002ce4:	fe843783          	ld	a5,-24(s0)
    80002ce8:	4709                	li	a4,2
    80002cea:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002cec:	fe843783          	ld	a5,-24(s0)
    80002cf0:	853e                	mv	a0,a5
    80002cf2:	ffffe097          	auipc	ra,0xffffe
    80002cf6:	5f2080e7          	jalr	1522(ra) # 800012e4 <release>
}
    80002cfa:	0001                	nop
    80002cfc:	60e2                	ld	ra,24(sp)
    80002cfe:	6442                	ld	s0,16(sp)
    80002d00:	6105                	addi	sp,sp,32
    80002d02:	8082                	ret

0000000080002d04 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002d04:	7179                	addi	sp,sp,-48
    80002d06:	f406                	sd	ra,40(sp)
    80002d08:	f022                	sd	s0,32(sp)
    80002d0a:	1800                	addi	s0,sp,48
    80002d0c:	87aa                	mv	a5,a0
    80002d0e:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002d12:	00000097          	auipc	ra,0x0
    80002d16:	ae6080e7          	jalr	-1306(ra) # 800027f8 <myproc>
    80002d1a:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002d1e:	fe043703          	ld	a4,-32(s0)
    80002d22:	6785                	lui	a5,0x1
    80002d24:	97ba                	add	a5,a5,a4
    80002d26:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002d2a:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002d2e:	fdc42783          	lw	a5,-36(s0)
    80002d32:	2781                	sext.w	a5,a5
    80002d34:	04f05163          	blez	a5,80002d76 <growproc+0x72>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002d38:	fe043703          	ld	a4,-32(s0)
    80002d3c:	6785                	lui	a5,0x1
    80002d3e:	97ba                	add	a5,a5,a4
    80002d40:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    80002d44:	fec46583          	lwu	a1,-20(s0)
    80002d48:	fdc42783          	lw	a5,-36(s0)
    80002d4c:	fec42703          	lw	a4,-20(s0)
    80002d50:	9fb9                	addw	a5,a5,a4
    80002d52:	2781                	sext.w	a5,a5
    80002d54:	1782                	slli	a5,a5,0x20
    80002d56:	9381                	srli	a5,a5,0x20
    80002d58:	863e                	mv	a2,a5
    80002d5a:	8536                	mv	a0,a3
    80002d5c:	fffff097          	auipc	ra,0xfffff
    80002d60:	19a080e7          	jalr	410(ra) # 80001ef6 <uvmalloc>
    80002d64:	87aa                	mv	a5,a0
    80002d66:	fef42623          	sw	a5,-20(s0)
    80002d6a:	fec42783          	lw	a5,-20(s0)
    80002d6e:	2781                	sext.w	a5,a5
    80002d70:	e3a9                	bnez	a5,80002db2 <growproc+0xae>
      return -1;
    80002d72:	57fd                	li	a5,-1
    80002d74:	a881                	j	80002dc4 <growproc+0xc0>
    }
  } else if(n < 0){
    80002d76:	fdc42783          	lw	a5,-36(s0)
    80002d7a:	2781                	sext.w	a5,a5
    80002d7c:	0207db63          	bgez	a5,80002db2 <growproc+0xae>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002d80:	fe043703          	ld	a4,-32(s0)
    80002d84:	6785                	lui	a5,0x1
    80002d86:	97ba                	add	a5,a5,a4
    80002d88:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    80002d8c:	fec46583          	lwu	a1,-20(s0)
    80002d90:	fdc42783          	lw	a5,-36(s0)
    80002d94:	fec42703          	lw	a4,-20(s0)
    80002d98:	9fb9                	addw	a5,a5,a4
    80002d9a:	2781                	sext.w	a5,a5
    80002d9c:	1782                	slli	a5,a5,0x20
    80002d9e:	9381                	srli	a5,a5,0x20
    80002da0:	863e                	mv	a2,a5
    80002da2:	8536                	mv	a0,a3
    80002da4:	fffff097          	auipc	ra,0xfffff
    80002da8:	236080e7          	jalr	566(ra) # 80001fda <uvmdealloc>
    80002dac:	87aa                	mv	a5,a0
    80002dae:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80002db2:	fec46703          	lwu	a4,-20(s0)
    80002db6:	fe043683          	ld	a3,-32(s0)
    80002dba:	6785                	lui	a5,0x1
    80002dbc:	97b6                	add	a5,a5,a3
    80002dbe:	2ae7b823          	sd	a4,688(a5) # 12b0 <_entry-0x7fffed50>
  return 0;
    80002dc2:	4781                	li	a5,0
}
    80002dc4:	853e                	mv	a0,a5
    80002dc6:	70a2                	ld	ra,40(sp)
    80002dc8:	7402                	ld	s0,32(sp)
    80002dca:	6145                	addi	sp,sp,48
    80002dcc:	8082                	ret

0000000080002dce <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80002dce:	7179                	addi	sp,sp,-48
    80002dd0:	f406                	sd	ra,40(sp)
    80002dd2:	f022                	sd	s0,32(sp)
    80002dd4:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002dd6:	00000097          	auipc	ra,0x0
    80002dda:	a22080e7          	jalr	-1502(ra) # 800027f8 <myproc>
    80002dde:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002de2:	00000097          	auipc	ra,0x0
    80002de6:	ab0080e7          	jalr	-1360(ra) # 80002892 <allocproc>
    80002dea:	fca43c23          	sd	a0,-40(s0)
    80002dee:	fd843783          	ld	a5,-40(s0)
    80002df2:	e399                	bnez	a5,80002df8 <fork+0x2a>
    return -1;
    80002df4:	57fd                	li	a5,-1
    80002df6:	a259                	j	80002f7c <fork+0x1ae>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002df8:	fe043703          	ld	a4,-32(s0)
    80002dfc:	6785                	lui	a5,0x1
    80002dfe:	97ba                	add	a5,a5,a4
    80002e00:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    80002e04:	fd843703          	ld	a4,-40(s0)
    80002e08:	6785                	lui	a5,0x1
    80002e0a:	97ba                	add	a5,a5,a4
    80002e0c:	2b87b583          	ld	a1,696(a5) # 12b8 <_entry-0x7fffed48>
    80002e10:	fe043703          	ld	a4,-32(s0)
    80002e14:	6785                	lui	a5,0x1
    80002e16:	97ba                	add	a5,a5,a4
    80002e18:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002e1c:	863e                	mv	a2,a5
    80002e1e:	8536                	mv	a0,a3
    80002e20:	fffff097          	auipc	ra,0xfffff
    80002e24:	34a080e7          	jalr	842(ra) # 8000216a <uvmcopy>
    80002e28:	87aa                	mv	a5,a0
    80002e2a:	0207d163          	bgez	a5,80002e4c <fork+0x7e>
    freeproc(np);
    80002e2e:	fd843503          	ld	a0,-40(s0)
    80002e32:	00000097          	auipc	ra,0x0
    80002e36:	c12080e7          	jalr	-1006(ra) # 80002a44 <freeproc>
    release(&np->lock);
    80002e3a:	fd843783          	ld	a5,-40(s0)
    80002e3e:	853e                	mv	a0,a5
    80002e40:	ffffe097          	auipc	ra,0xffffe
    80002e44:	4a4080e7          	jalr	1188(ra) # 800012e4 <release>
    return -1;
    80002e48:	57fd                	li	a5,-1
    80002e4a:	aa0d                	j	80002f7c <fork+0x1ae>
  }
  np->sz = p->sz;
    80002e4c:	fe043703          	ld	a4,-32(s0)
    80002e50:	6785                	lui	a5,0x1
    80002e52:	97ba                	add	a5,a5,a4
    80002e54:	2b07b703          	ld	a4,688(a5) # 12b0 <_entry-0x7fffed50>
    80002e58:	fd843683          	ld	a3,-40(s0)
    80002e5c:	6785                	lui	a5,0x1
    80002e5e:	97b6                	add	a5,a5,a3
    80002e60:	2ae7b823          	sd	a4,688(a5) # 12b0 <_entry-0x7fffed50>

  np->parent = p;
    80002e64:	fd843783          	ld	a5,-40(s0)
    80002e68:	fe043703          	ld	a4,-32(s0)
    80002e6c:	f398                	sd	a4,32(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002e6e:	fe043703          	ld	a4,-32(s0)
    80002e72:	6785                	lui	a5,0x1
    80002e74:	97ba                	add	a5,a5,a4
    80002e76:	2c07b683          	ld	a3,704(a5) # 12c0 <_entry-0x7fffed40>
    80002e7a:	fd843703          	ld	a4,-40(s0)
    80002e7e:	6785                	lui	a5,0x1
    80002e80:	97ba                	add	a5,a5,a4
    80002e82:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002e86:	873e                	mv	a4,a5
    80002e88:	12000793          	li	a5,288
    80002e8c:	863e                	mv	a2,a5
    80002e8e:	85b6                	mv	a1,a3
    80002e90:	853a                	mv	a0,a4
    80002e92:	ffffe097          	auipc	ra,0xffffe
    80002e96:	774080e7          	jalr	1908(ra) # 80001606 <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002e9a:	fd843703          	ld	a4,-40(s0)
    80002e9e:	6785                	lui	a5,0x1
    80002ea0:	97ba                	add	a5,a5,a4
    80002ea2:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80002ea6:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002eaa:	fe042623          	sw	zero,-20(s0)
    80002eae:	a881                	j	80002efe <fork+0x130>
    if(p->ofile[i])
    80002eb0:	fe043703          	ld	a4,-32(s0)
    80002eb4:	fec42783          	lw	a5,-20(s0)
    80002eb8:	26678793          	addi	a5,a5,614
    80002ebc:	078e                	slli	a5,a5,0x3
    80002ebe:	97ba                	add	a5,a5,a4
    80002ec0:	679c                	ld	a5,8(a5)
    80002ec2:	cb8d                	beqz	a5,80002ef4 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    80002ec4:	fe043703          	ld	a4,-32(s0)
    80002ec8:	fec42783          	lw	a5,-20(s0)
    80002ecc:	26678793          	addi	a5,a5,614
    80002ed0:	078e                	slli	a5,a5,0x3
    80002ed2:	97ba                	add	a5,a5,a4
    80002ed4:	679c                	ld	a5,8(a5)
    80002ed6:	853e                	mv	a0,a5
    80002ed8:	00004097          	auipc	ra,0x4
    80002edc:	bec080e7          	jalr	-1044(ra) # 80006ac4 <filedup>
    80002ee0:	86aa                	mv	a3,a0
    80002ee2:	fd843703          	ld	a4,-40(s0)
    80002ee6:	fec42783          	lw	a5,-20(s0)
    80002eea:	26678793          	addi	a5,a5,614
    80002eee:	078e                	slli	a5,a5,0x3
    80002ef0:	97ba                	add	a5,a5,a4
    80002ef2:	e794                	sd	a3,8(a5)
  for(i = 0; i < NOFILE; i++)
    80002ef4:	fec42783          	lw	a5,-20(s0)
    80002ef8:	2785                	addiw	a5,a5,1
    80002efa:	fef42623          	sw	a5,-20(s0)
    80002efe:	fec42783          	lw	a5,-20(s0)
    80002f02:	0007871b          	sext.w	a4,a5
    80002f06:	47bd                	li	a5,15
    80002f08:	fae7d4e3          	bge	a5,a4,80002eb0 <fork+0xe2>
  np->cwd = idup(p->cwd);
    80002f0c:	fe043703          	ld	a4,-32(s0)
    80002f10:	6785                	lui	a5,0x1
    80002f12:	97ba                	add	a5,a5,a4
    80002f14:	3b87b783          	ld	a5,952(a5) # 13b8 <_entry-0x7fffec48>
    80002f18:	853e                	mv	a0,a5
    80002f1a:	00002097          	auipc	ra,0x2
    80002f1e:	4be080e7          	jalr	1214(ra) # 800053d8 <idup>
    80002f22:	86aa                	mv	a3,a0
    80002f24:	fd843703          	ld	a4,-40(s0)
    80002f28:	6785                	lui	a5,0x1
    80002f2a:	97ba                	add	a5,a5,a4
    80002f2c:	3ad7bc23          	sd	a3,952(a5) # 13b8 <_entry-0x7fffec48>

  safestrcpy(np->name, p->name, sizeof(p->name));
    80002f30:	fd843703          	ld	a4,-40(s0)
    80002f34:	6785                	lui	a5,0x1
    80002f36:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    80002f3a:	00f706b3          	add	a3,a4,a5
    80002f3e:	fe043703          	ld	a4,-32(s0)
    80002f42:	6785                	lui	a5,0x1
    80002f44:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    80002f48:	97ba                	add	a5,a5,a4
    80002f4a:	4641                	li	a2,16
    80002f4c:	85be                	mv	a1,a5
    80002f4e:	8536                	mv	a0,a3
    80002f50:	ffffe097          	auipc	ra,0xffffe
    80002f54:	7fa080e7          	jalr	2042(ra) # 8000174a <safestrcpy>

  pid = np->pid;
    80002f58:	fd843783          	ld	a5,-40(s0)
    80002f5c:	5f9c                	lw	a5,56(a5)
    80002f5e:	fcf42a23          	sw	a5,-44(s0)

  np->state = RUNNABLE;
    80002f62:	fd843783          	ld	a5,-40(s0)
    80002f66:	4709                	li	a4,2
    80002f68:	cf98                	sw	a4,24(a5)

  release(&np->lock);
    80002f6a:	fd843783          	ld	a5,-40(s0)
    80002f6e:	853e                	mv	a0,a5
    80002f70:	ffffe097          	auipc	ra,0xffffe
    80002f74:	374080e7          	jalr	884(ra) # 800012e4 <release>

  return pid;
    80002f78:	fd442783          	lw	a5,-44(s0)
}
    80002f7c:	853e                	mv	a0,a5
    80002f7e:	70a2                	ld	ra,40(sp)
    80002f80:	7402                	ld	s0,32(sp)
    80002f82:	6145                	addi	sp,sp,48
    80002f84:	8082                	ret

0000000080002f86 <reparent>:

// Pass p's abandoned children to init.
// Caller must hold p->lock.
void
reparent(struct proc *p)
{
    80002f86:	7179                	addi	sp,sp,-48
    80002f88:	f406                	sd	ra,40(sp)
    80002f8a:	f022                	sd	s0,32(sp)
    80002f8c:	1800                	addi	s0,sp,48
    80002f8e:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002f92:	00011797          	auipc	a5,0x11
    80002f96:	70678793          	addi	a5,a5,1798 # 80014698 <proc>
    80002f9a:	fef43423          	sd	a5,-24(s0)
    80002f9e:	a0b1                	j	80002fea <reparent+0x64>
    // this code uses pp->parent without holding pp->lock.
    // acquiring the lock first could cause a deadlock
    // if pp or a child of pp were also in exit()
    // and about to try to lock p.
    if(pp->parent == p){
    80002fa0:	fe843783          	ld	a5,-24(s0)
    80002fa4:	739c                	ld	a5,32(a5)
    80002fa6:	fd843703          	ld	a4,-40(s0)
    80002faa:	02f71863          	bne	a4,a5,80002fda <reparent+0x54>
      // pp->parent can't change between the check and the acquire()
      // because only the parent changes it, and we're the parent.
      acquire(&pp->lock);
    80002fae:	fe843783          	ld	a5,-24(s0)
    80002fb2:	853e                	mv	a0,a5
    80002fb4:	ffffe097          	auipc	ra,0xffffe
    80002fb8:	2cc080e7          	jalr	716(ra) # 80001280 <acquire>
      pp->parent = initproc;
    80002fbc:	00009797          	auipc	a5,0x9
    80002fc0:	05c78793          	addi	a5,a5,92 # 8000c018 <initproc>
    80002fc4:	6398                	ld	a4,0(a5)
    80002fc6:	fe843783          	ld	a5,-24(s0)
    80002fca:	f398                	sd	a4,32(a5)
      // we should wake up init here, but that would require
      // initproc->lock, which would be a deadlock, since we hold
      // the lock on one of init's children (pp). this is why
      // exit() always wakes init (before acquiring any locks).
      release(&pp->lock);
    80002fcc:	fe843783          	ld	a5,-24(s0)
    80002fd0:	853e                	mv	a0,a5
    80002fd2:	ffffe097          	auipc	ra,0xffffe
    80002fd6:	312080e7          	jalr	786(ra) # 800012e4 <release>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002fda:	fe843703          	ld	a4,-24(s0)
    80002fde:	6785                	lui	a5,0x1
    80002fe0:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    80002fe4:	97ba                	add	a5,a5,a4
    80002fe6:	fef43423          	sd	a5,-24(s0)
    80002fea:	fe843703          	ld	a4,-24(s0)
    80002fee:	00061797          	auipc	a5,0x61
    80002ff2:	aaa78793          	addi	a5,a5,-1366 # 80063a98 <pid_lock>
    80002ff6:	faf765e3          	bltu	a4,a5,80002fa0 <reparent+0x1a>
    }
  }
}
    80002ffa:	0001                	nop
    80002ffc:	0001                	nop
    80002ffe:	70a2                	ld	ra,40(sp)
    80003000:	7402                	ld	s0,32(sp)
    80003002:	6145                	addi	sp,sp,48
    80003004:	8082                	ret

0000000080003006 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80003006:	7139                	addi	sp,sp,-64
    80003008:	fc06                	sd	ra,56(sp)
    8000300a:	f822                	sd	s0,48(sp)
    8000300c:	0080                	addi	s0,sp,64
    8000300e:	87aa                	mv	a5,a0
    80003010:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	7e4080e7          	jalr	2020(ra) # 800027f8 <myproc>
    8000301c:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80003020:	00009797          	auipc	a5,0x9
    80003024:	ff878793          	addi	a5,a5,-8 # 8000c018 <initproc>
    80003028:	639c                	ld	a5,0(a5)
    8000302a:	fe043703          	ld	a4,-32(s0)
    8000302e:	00f71a63          	bne	a4,a5,80003042 <exit+0x3c>
    panic("init exiting");
    80003032:	00008517          	auipc	a0,0x8
    80003036:	1a650513          	addi	a0,a0,422 # 8000b1d8 <etext+0x1d8>
    8000303a:	ffffe097          	auipc	ra,0xffffe
    8000303e:	c18080e7          	jalr	-1000(ra) # 80000c52 <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80003042:	fe042623          	sw	zero,-20(s0)
    80003046:	a899                	j	8000309c <exit+0x96>
    if(p->ofile[fd]){
    80003048:	fe043703          	ld	a4,-32(s0)
    8000304c:	fec42783          	lw	a5,-20(s0)
    80003050:	26678793          	addi	a5,a5,614
    80003054:	078e                	slli	a5,a5,0x3
    80003056:	97ba                	add	a5,a5,a4
    80003058:	679c                	ld	a5,8(a5)
    8000305a:	cf85                	beqz	a5,80003092 <exit+0x8c>
      struct file *f = p->ofile[fd];
    8000305c:	fe043703          	ld	a4,-32(s0)
    80003060:	fec42783          	lw	a5,-20(s0)
    80003064:	26678793          	addi	a5,a5,614
    80003068:	078e                	slli	a5,a5,0x3
    8000306a:	97ba                	add	a5,a5,a4
    8000306c:	679c                	ld	a5,8(a5)
    8000306e:	fcf43823          	sd	a5,-48(s0)
      fileclose(f);
    80003072:	fd043503          	ld	a0,-48(s0)
    80003076:	00004097          	auipc	ra,0x4
    8000307a:	ab4080e7          	jalr	-1356(ra) # 80006b2a <fileclose>
      p->ofile[fd] = 0;
    8000307e:	fe043703          	ld	a4,-32(s0)
    80003082:	fec42783          	lw	a5,-20(s0)
    80003086:	26678793          	addi	a5,a5,614
    8000308a:	078e                	slli	a5,a5,0x3
    8000308c:	97ba                	add	a5,a5,a4
    8000308e:	0007b423          	sd	zero,8(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80003092:	fec42783          	lw	a5,-20(s0)
    80003096:	2785                	addiw	a5,a5,1
    80003098:	fef42623          	sw	a5,-20(s0)
    8000309c:	fec42783          	lw	a5,-20(s0)
    800030a0:	0007871b          	sext.w	a4,a5
    800030a4:	47bd                	li	a5,15
    800030a6:	fae7d1e3          	bge	a5,a4,80003048 <exit+0x42>
    }
  }

  begin_op();
    800030aa:	00003097          	auipc	ra,0x3
    800030ae:	3e6080e7          	jalr	998(ra) # 80006490 <begin_op>
  iput(p->cwd);
    800030b2:	fe043703          	ld	a4,-32(s0)
    800030b6:	6785                	lui	a5,0x1
    800030b8:	97ba                	add	a5,a5,a4
    800030ba:	3b87b783          	ld	a5,952(a5) # 13b8 <_entry-0x7fffec48>
    800030be:	853e                	mv	a0,a5
    800030c0:	00002097          	auipc	ra,0x2
    800030c4:	4f2080e7          	jalr	1266(ra) # 800055b2 <iput>
  end_op();
    800030c8:	00003097          	auipc	ra,0x3
    800030cc:	48a080e7          	jalr	1162(ra) # 80006552 <end_op>
  p->cwd = 0;
    800030d0:	fe043703          	ld	a4,-32(s0)
    800030d4:	6785                	lui	a5,0x1
    800030d6:	97ba                	add	a5,a5,a4
    800030d8:	3a07bc23          	sd	zero,952(a5) # 13b8 <_entry-0x7fffec48>
  // we might re-parent a child to init. we can't be precise about
  // waking up init, since we can't acquire its lock once we've
  // acquired any other proc lock. so wake up init whether that's
  // necessary or not. init may miss this wakeup, but that seems
  // harmless.
  acquire(&initproc->lock);
    800030dc:	00009797          	auipc	a5,0x9
    800030e0:	f3c78793          	addi	a5,a5,-196 # 8000c018 <initproc>
    800030e4:	639c                	ld	a5,0(a5)
    800030e6:	853e                	mv	a0,a5
    800030e8:	ffffe097          	auipc	ra,0xffffe
    800030ec:	198080e7          	jalr	408(ra) # 80001280 <acquire>
  wakeup1(initproc);
    800030f0:	00009797          	auipc	a5,0x9
    800030f4:	f2878793          	addi	a5,a5,-216 # 8000c018 <initproc>
    800030f8:	639c                	ld	a5,0(a5)
    800030fa:	853e                	mv	a0,a5
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	562080e7          	jalr	1378(ra) # 8000365e <wakeup1>
  release(&initproc->lock);
    80003104:	00009797          	auipc	a5,0x9
    80003108:	f1478793          	addi	a5,a5,-236 # 8000c018 <initproc>
    8000310c:	639c                	ld	a5,0(a5)
    8000310e:	853e                	mv	a0,a5
    80003110:	ffffe097          	auipc	ra,0xffffe
    80003114:	1d4080e7          	jalr	468(ra) # 800012e4 <release>
  // parent we locked. in case our parent gives us away to init while
  // we're waiting for the parent lock. we may then race with an
  // exiting parent, but the result will be a harmless spurious wakeup
  // to a dead or wrong process; proc structs are never re-allocated
  // as anything else.
  acquire(&p->lock);
    80003118:	fe043783          	ld	a5,-32(s0)
    8000311c:	853e                	mv	a0,a5
    8000311e:	ffffe097          	auipc	ra,0xffffe
    80003122:	162080e7          	jalr	354(ra) # 80001280 <acquire>
  struct proc *original_parent = p->parent;
    80003126:	fe043783          	ld	a5,-32(s0)
    8000312a:	739c                	ld	a5,32(a5)
    8000312c:	fcf43c23          	sd	a5,-40(s0)
  release(&p->lock);
    80003130:	fe043783          	ld	a5,-32(s0)
    80003134:	853e                	mv	a0,a5
    80003136:	ffffe097          	auipc	ra,0xffffe
    8000313a:	1ae080e7          	jalr	430(ra) # 800012e4 <release>
  
  // we need the parent's lock in order to wake it up from wait().
  // the parent-then-child rule says we have to lock it first.
  acquire(&original_parent->lock);
    8000313e:	fd843783          	ld	a5,-40(s0)
    80003142:	853e                	mv	a0,a5
    80003144:	ffffe097          	auipc	ra,0xffffe
    80003148:	13c080e7          	jalr	316(ra) # 80001280 <acquire>

  acquire(&p->lock);
    8000314c:	fe043783          	ld	a5,-32(s0)
    80003150:	853e                	mv	a0,a5
    80003152:	ffffe097          	auipc	ra,0xffffe
    80003156:	12e080e7          	jalr	302(ra) # 80001280 <acquire>

  // Give any children to init.
  reparent(p);
    8000315a:	fe043503          	ld	a0,-32(s0)
    8000315e:	00000097          	auipc	ra,0x0
    80003162:	e28080e7          	jalr	-472(ra) # 80002f86 <reparent>

  // Parent might be sleeping in wait().
  wakeup1(original_parent);
    80003166:	fd843503          	ld	a0,-40(s0)
    8000316a:	00000097          	auipc	ra,0x0
    8000316e:	4f4080e7          	jalr	1268(ra) # 8000365e <wakeup1>

  p->xstate = status;
    80003172:	fe043783          	ld	a5,-32(s0)
    80003176:	fcc42703          	lw	a4,-52(s0)
    8000317a:	dbd8                	sw	a4,52(a5)
  p->state = ZOMBIE;
    8000317c:	fe043783          	ld	a5,-32(s0)
    80003180:	4711                	li	a4,4
    80003182:	cf98                	sw	a4,24(a5)

  release(&original_parent->lock);
    80003184:	fd843783          	ld	a5,-40(s0)
    80003188:	853e                	mv	a0,a5
    8000318a:	ffffe097          	auipc	ra,0xffffe
    8000318e:	15a080e7          	jalr	346(ra) # 800012e4 <release>

  // Jump into the scheduler, never to return.
  sched();
    80003192:	00000097          	auipc	ra,0x0
    80003196:	230080e7          	jalr	560(ra) # 800033c2 <sched>
  panic("zombie exit");
    8000319a:	00008517          	auipc	a0,0x8
    8000319e:	04e50513          	addi	a0,a0,78 # 8000b1e8 <etext+0x1e8>
    800031a2:	ffffe097          	auipc	ra,0xffffe
    800031a6:	ab0080e7          	jalr	-1360(ra) # 80000c52 <panic>

00000000800031aa <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    800031aa:	7139                	addi	sp,sp,-64
    800031ac:	fc06                	sd	ra,56(sp)
    800031ae:	f822                	sd	s0,48(sp)
    800031b0:	0080                	addi	s0,sp,64
    800031b2:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    800031b6:	fffff097          	auipc	ra,0xfffff
    800031ba:	642080e7          	jalr	1602(ra) # 800027f8 <myproc>
    800031be:	fca43c23          	sd	a0,-40(s0)

  // hold p->lock for the whole time to avoid lost
  // wakeups from a child's exit().
  acquire(&p->lock);
    800031c2:	fd843783          	ld	a5,-40(s0)
    800031c6:	853e                	mv	a0,a5
    800031c8:	ffffe097          	auipc	ra,0xffffe
    800031cc:	0b8080e7          	jalr	184(ra) # 80001280 <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    800031d0:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    800031d4:	00011797          	auipc	a5,0x11
    800031d8:	4c478793          	addi	a5,a5,1220 # 80014698 <proc>
    800031dc:	fef43423          	sd	a5,-24(s0)
    800031e0:	a8e9                	j	800032ba <wait+0x110>
      // this code uses np->parent without holding np->lock.
      // acquiring the lock first would cause a deadlock,
      // since np might be an ancestor, and we already hold p->lock.
      if(np->parent == p){
    800031e2:	fe843783          	ld	a5,-24(s0)
    800031e6:	739c                	ld	a5,32(a5)
    800031e8:	fd843703          	ld	a4,-40(s0)
    800031ec:	0af71f63          	bne	a4,a5,800032aa <wait+0x100>
        // np->parent can't change between the check and the acquire()
        // because only the parent changes it, and we're the parent.
        acquire(&np->lock);
    800031f0:	fe843783          	ld	a5,-24(s0)
    800031f4:	853e                	mv	a0,a5
    800031f6:	ffffe097          	auipc	ra,0xffffe
    800031fa:	08a080e7          	jalr	138(ra) # 80001280 <acquire>
        havekids = 1;
    800031fe:	4785                	li	a5,1
    80003200:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){
    80003204:	fe843783          	ld	a5,-24(s0)
    80003208:	4f9c                	lw	a5,24(a5)
    8000320a:	873e                	mv	a4,a5
    8000320c:	4791                	li	a5,4
    8000320e:	08f71763          	bne	a4,a5,8000329c <wait+0xf2>
          // Found one.
          pid = np->pid;
    80003212:	fe843783          	ld	a5,-24(s0)
    80003216:	5f9c                	lw	a5,56(a5)
    80003218:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000321c:	fc843783          	ld	a5,-56(s0)
    80003220:	c7b9                	beqz	a5,8000326e <wait+0xc4>
    80003222:	fd843703          	ld	a4,-40(s0)
    80003226:	6785                	lui	a5,0x1
    80003228:	97ba                	add	a5,a5,a4
    8000322a:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    8000322e:	fe843783          	ld	a5,-24(s0)
    80003232:	03478793          	addi	a5,a5,52
    80003236:	4691                	li	a3,4
    80003238:	863e                	mv	a2,a5
    8000323a:	fc843583          	ld	a1,-56(s0)
    8000323e:	853a                	mv	a0,a4
    80003240:	fffff097          	auipc	ra,0xfffff
    80003244:	094080e7          	jalr	148(ra) # 800022d4 <copyout>
    80003248:	87aa                	mv	a5,a0
    8000324a:	0207d263          	bgez	a5,8000326e <wait+0xc4>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    8000324e:	fe843783          	ld	a5,-24(s0)
    80003252:	853e                	mv	a0,a5
    80003254:	ffffe097          	auipc	ra,0xffffe
    80003258:	090080e7          	jalr	144(ra) # 800012e4 <release>
            release(&p->lock);
    8000325c:	fd843783          	ld	a5,-40(s0)
    80003260:	853e                	mv	a0,a5
    80003262:	ffffe097          	auipc	ra,0xffffe
    80003266:	082080e7          	jalr	130(ra) # 800012e4 <release>
            return -1;
    8000326a:	57fd                	li	a5,-1
    8000326c:	a851                	j	80003300 <wait+0x156>
          }
          freeproc(np);
    8000326e:	fe843503          	ld	a0,-24(s0)
    80003272:	fffff097          	auipc	ra,0xfffff
    80003276:	7d2080e7          	jalr	2002(ra) # 80002a44 <freeproc>
          release(&np->lock);
    8000327a:	fe843783          	ld	a5,-24(s0)
    8000327e:	853e                	mv	a0,a5
    80003280:	ffffe097          	auipc	ra,0xffffe
    80003284:	064080e7          	jalr	100(ra) # 800012e4 <release>
          release(&p->lock);
    80003288:	fd843783          	ld	a5,-40(s0)
    8000328c:	853e                	mv	a0,a5
    8000328e:	ffffe097          	auipc	ra,0xffffe
    80003292:	056080e7          	jalr	86(ra) # 800012e4 <release>
          return pid;
    80003296:	fd442783          	lw	a5,-44(s0)
    8000329a:	a09d                	j	80003300 <wait+0x156>
        }
        release(&np->lock);
    8000329c:	fe843783          	ld	a5,-24(s0)
    800032a0:	853e                	mv	a0,a5
    800032a2:	ffffe097          	auipc	ra,0xffffe
    800032a6:	042080e7          	jalr	66(ra) # 800012e4 <release>
    for(np = proc; np < &proc[NPROC]; np++){
    800032aa:	fe843703          	ld	a4,-24(s0)
    800032ae:	6785                	lui	a5,0x1
    800032b0:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    800032b4:	97ba                	add	a5,a5,a4
    800032b6:	fef43423          	sd	a5,-24(s0)
    800032ba:	fe843703          	ld	a4,-24(s0)
    800032be:	00060797          	auipc	a5,0x60
    800032c2:	7da78793          	addi	a5,a5,2010 # 80063a98 <pid_lock>
    800032c6:	f0f76ee3          	bltu	a4,a5,800031e2 <wait+0x38>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    800032ca:	fe442783          	lw	a5,-28(s0)
    800032ce:	2781                	sext.w	a5,a5
    800032d0:	c789                	beqz	a5,800032da <wait+0x130>
    800032d2:	fd843783          	ld	a5,-40(s0)
    800032d6:	5b9c                	lw	a5,48(a5)
    800032d8:	cb91                	beqz	a5,800032ec <wait+0x142>
      release(&p->lock);
    800032da:	fd843783          	ld	a5,-40(s0)
    800032de:	853e                	mv	a0,a5
    800032e0:	ffffe097          	auipc	ra,0xffffe
    800032e4:	004080e7          	jalr	4(ra) # 800012e4 <release>
      return -1;
    800032e8:	57fd                	li	a5,-1
    800032ea:	a819                	j	80003300 <wait+0x156>
    }
    
    // Wait for a child to exit.
    sleep(p, &p->lock);  //DOC: wait-sleep
    800032ec:	fd843783          	ld	a5,-40(s0)
    800032f0:	85be                	mv	a1,a5
    800032f2:	fd843503          	ld	a0,-40(s0)
    800032f6:	00000097          	auipc	ra,0x0
    800032fa:	24e080e7          	jalr	590(ra) # 80003544 <sleep>
    havekids = 0;
    800032fe:	bdc9                	j	800031d0 <wait+0x26>
  }
}
    80003300:	853e                	mv	a0,a5
    80003302:	70e2                	ld	ra,56(sp)
    80003304:	7442                	ld	s0,48(sp)
    80003306:	6121                	addi	sp,sp,64
    80003308:	8082                	ret

000000008000330a <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    8000330a:	1101                	addi	sp,sp,-32
    8000330c:	ec06                	sd	ra,24(sp)
    8000330e:	e822                	sd	s0,16(sp)
    80003310:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    80003312:	fffff097          	auipc	ra,0xfffff
    80003316:	4ac080e7          	jalr	1196(ra) # 800027be <mycpu>
    8000331a:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    8000331e:	fe043783          	ld	a5,-32(s0)
    80003322:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    80003326:	fffff097          	auipc	ra,0xfffff
    8000332a:	28c080e7          	jalr	652(ra) # 800025b2 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    8000332e:	00011797          	auipc	a5,0x11
    80003332:	36a78793          	addi	a5,a5,874 # 80014698 <proc>
    80003336:	fef43423          	sd	a5,-24(s0)
    8000333a:	a89d                	j	800033b0 <scheduler+0xa6>
      acquire(&p->lock);
    8000333c:	fe843783          	ld	a5,-24(s0)
    80003340:	853e                	mv	a0,a5
    80003342:	ffffe097          	auipc	ra,0xffffe
    80003346:	f3e080e7          	jalr	-194(ra) # 80001280 <acquire>
      if(p->state == RUNNABLE) {
    8000334a:	fe843783          	ld	a5,-24(s0)
    8000334e:	4f9c                	lw	a5,24(a5)
    80003350:	873e                	mv	a4,a5
    80003352:	4789                	li	a5,2
    80003354:	02f71f63          	bne	a4,a5,80003392 <scheduler+0x88>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80003358:	fe843783          	ld	a5,-24(s0)
    8000335c:	470d                	li	a4,3
    8000335e:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80003360:	fe043783          	ld	a5,-32(s0)
    80003364:	fe843703          	ld	a4,-24(s0)
    80003368:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    8000336a:	fe043783          	ld	a5,-32(s0)
    8000336e:	00878693          	addi	a3,a5,8
    80003372:	fe843703          	ld	a4,-24(s0)
    80003376:	6785                	lui	a5,0x1
    80003378:	2c878793          	addi	a5,a5,712 # 12c8 <_entry-0x7fffed38>
    8000337c:	97ba                	add	a5,a5,a4
    8000337e:	85be                	mv	a1,a5
    80003380:	8536                	mv	a0,a3
    80003382:	00000097          	auipc	ra,0x0
    80003386:	5b8080e7          	jalr	1464(ra) # 8000393a <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000338a:	fe043783          	ld	a5,-32(s0)
    8000338e:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003392:	fe843783          	ld	a5,-24(s0)
    80003396:	853e                	mv	a0,a5
    80003398:	ffffe097          	auipc	ra,0xffffe
    8000339c:	f4c080e7          	jalr	-180(ra) # 800012e4 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800033a0:	fe843703          	ld	a4,-24(s0)
    800033a4:	6785                	lui	a5,0x1
    800033a6:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    800033aa:	97ba                	add	a5,a5,a4
    800033ac:	fef43423          	sd	a5,-24(s0)
    800033b0:	fe843703          	ld	a4,-24(s0)
    800033b4:	00060797          	auipc	a5,0x60
    800033b8:	6e478793          	addi	a5,a5,1764 # 80063a98 <pid_lock>
    800033bc:	f8f760e3          	bltu	a4,a5,8000333c <scheduler+0x32>
    intr_on();
    800033c0:	b79d                	j	80003326 <scheduler+0x1c>

00000000800033c2 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    800033c2:	7179                	addi	sp,sp,-48
    800033c4:	f406                	sd	ra,40(sp)
    800033c6:	f022                	sd	s0,32(sp)
    800033c8:	ec26                	sd	s1,24(sp)
    800033ca:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    800033cc:	fffff097          	auipc	ra,0xfffff
    800033d0:	42c080e7          	jalr	1068(ra) # 800027f8 <myproc>
    800033d4:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    800033d8:	fd843783          	ld	a5,-40(s0)
    800033dc:	853e                	mv	a0,a5
    800033de:	ffffe097          	auipc	ra,0xffffe
    800033e2:	f5c080e7          	jalr	-164(ra) # 8000133a <holding>
    800033e6:	87aa                	mv	a5,a0
    800033e8:	eb89                	bnez	a5,800033fa <sched+0x38>
    panic("sched p->lock");
    800033ea:	00008517          	auipc	a0,0x8
    800033ee:	e0e50513          	addi	a0,a0,-498 # 8000b1f8 <etext+0x1f8>
    800033f2:	ffffe097          	auipc	ra,0xffffe
    800033f6:	860080e7          	jalr	-1952(ra) # 80000c52 <panic>
  if(mycpu()->noff != 1)
    800033fa:	fffff097          	auipc	ra,0xfffff
    800033fe:	3c4080e7          	jalr	964(ra) # 800027be <mycpu>
    80003402:	87aa                	mv	a5,a0
    80003404:	5fbc                	lw	a5,120(a5)
    80003406:	873e                	mv	a4,a5
    80003408:	4785                	li	a5,1
    8000340a:	00f70a63          	beq	a4,a5,8000341e <sched+0x5c>
    panic("sched locks");
    8000340e:	00008517          	auipc	a0,0x8
    80003412:	dfa50513          	addi	a0,a0,-518 # 8000b208 <etext+0x208>
    80003416:	ffffe097          	auipc	ra,0xffffe
    8000341a:	83c080e7          	jalr	-1988(ra) # 80000c52 <panic>
  if(p->state == RUNNING)
    8000341e:	fd843783          	ld	a5,-40(s0)
    80003422:	4f9c                	lw	a5,24(a5)
    80003424:	873e                	mv	a4,a5
    80003426:	478d                	li	a5,3
    80003428:	00f71a63          	bne	a4,a5,8000343c <sched+0x7a>
    panic("sched running");
    8000342c:	00008517          	auipc	a0,0x8
    80003430:	dec50513          	addi	a0,a0,-532 # 8000b218 <etext+0x218>
    80003434:	ffffe097          	auipc	ra,0xffffe
    80003438:	81e080e7          	jalr	-2018(ra) # 80000c52 <panic>
  if(intr_get())
    8000343c:	fffff097          	auipc	ra,0xfffff
    80003440:	1a0080e7          	jalr	416(ra) # 800025dc <intr_get>
    80003444:	87aa                	mv	a5,a0
    80003446:	cb89                	beqz	a5,80003458 <sched+0x96>
    panic("sched interruptible");
    80003448:	00008517          	auipc	a0,0x8
    8000344c:	de050513          	addi	a0,a0,-544 # 8000b228 <etext+0x228>
    80003450:	ffffe097          	auipc	ra,0xffffe
    80003454:	802080e7          	jalr	-2046(ra) # 80000c52 <panic>

  intena = mycpu()->intena;
    80003458:	fffff097          	auipc	ra,0xfffff
    8000345c:	366080e7          	jalr	870(ra) # 800027be <mycpu>
    80003460:	87aa                	mv	a5,a0
    80003462:	5ffc                	lw	a5,124(a5)
    80003464:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    80003468:	fd843703          	ld	a4,-40(s0)
    8000346c:	6785                	lui	a5,0x1
    8000346e:	2c878793          	addi	a5,a5,712 # 12c8 <_entry-0x7fffed38>
    80003472:	00f704b3          	add	s1,a4,a5
    80003476:	fffff097          	auipc	ra,0xfffff
    8000347a:	348080e7          	jalr	840(ra) # 800027be <mycpu>
    8000347e:	87aa                	mv	a5,a0
    80003480:	07a1                	addi	a5,a5,8
    80003482:	85be                	mv	a1,a5
    80003484:	8526                	mv	a0,s1
    80003486:	00000097          	auipc	ra,0x0
    8000348a:	4b4080e7          	jalr	1204(ra) # 8000393a <swtch>
  mycpu()->intena = intena;
    8000348e:	fffff097          	auipc	ra,0xfffff
    80003492:	330080e7          	jalr	816(ra) # 800027be <mycpu>
    80003496:	872a                	mv	a4,a0
    80003498:	fd442783          	lw	a5,-44(s0)
    8000349c:	df7c                	sw	a5,124(a4)
}
    8000349e:	0001                	nop
    800034a0:	70a2                	ld	ra,40(sp)
    800034a2:	7402                	ld	s0,32(sp)
    800034a4:	64e2                	ld	s1,24(sp)
    800034a6:	6145                	addi	sp,sp,48
    800034a8:	8082                	ret

00000000800034aa <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    800034aa:	1101                	addi	sp,sp,-32
    800034ac:	ec06                	sd	ra,24(sp)
    800034ae:	e822                	sd	s0,16(sp)
    800034b0:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800034b2:	fffff097          	auipc	ra,0xfffff
    800034b6:	346080e7          	jalr	838(ra) # 800027f8 <myproc>
    800034ba:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    800034be:	fe843783          	ld	a5,-24(s0)
    800034c2:	853e                	mv	a0,a5
    800034c4:	ffffe097          	auipc	ra,0xffffe
    800034c8:	dbc080e7          	jalr	-580(ra) # 80001280 <acquire>
  p->state = RUNNABLE;
    800034cc:	fe843783          	ld	a5,-24(s0)
    800034d0:	4709                	li	a4,2
    800034d2:	cf98                	sw	a4,24(a5)
  sched();
    800034d4:	00000097          	auipc	ra,0x0
    800034d8:	eee080e7          	jalr	-274(ra) # 800033c2 <sched>
  release(&p->lock);
    800034dc:	fe843783          	ld	a5,-24(s0)
    800034e0:	853e                	mv	a0,a5
    800034e2:	ffffe097          	auipc	ra,0xffffe
    800034e6:	e02080e7          	jalr	-510(ra) # 800012e4 <release>
}
    800034ea:	0001                	nop
    800034ec:	60e2                	ld	ra,24(sp)
    800034ee:	6442                	ld	s0,16(sp)
    800034f0:	6105                	addi	sp,sp,32
    800034f2:	8082                	ret

00000000800034f4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800034f4:	1141                	addi	sp,sp,-16
    800034f6:	e406                	sd	ra,8(sp)
    800034f8:	e022                	sd	s0,0(sp)
    800034fa:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800034fc:	fffff097          	auipc	ra,0xfffff
    80003500:	2fc080e7          	jalr	764(ra) # 800027f8 <myproc>
    80003504:	87aa                	mv	a5,a0
    80003506:	853e                	mv	a0,a5
    80003508:	ffffe097          	auipc	ra,0xffffe
    8000350c:	ddc080e7          	jalr	-548(ra) # 800012e4 <release>

  if (first) {
    80003510:	00008797          	auipc	a5,0x8
    80003514:	24478793          	addi	a5,a5,580 # 8000b754 <first.1683>
    80003518:	439c                	lw	a5,0(a5)
    8000351a:	cf81                	beqz	a5,80003532 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    8000351c:	00008797          	auipc	a5,0x8
    80003520:	23878793          	addi	a5,a5,568 # 8000b754 <first.1683>
    80003524:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    80003528:	4505                	li	a0,1
    8000352a:	00001097          	auipc	ra,0x1
    8000352e:	788080e7          	jalr	1928(ra) # 80004cb2 <fsinit>
  }

  usertrapret();
    80003532:	00000097          	auipc	ra,0x0
    80003536:	7fa080e7          	jalr	2042(ra) # 80003d2c <usertrapret>
}
    8000353a:	0001                	nop
    8000353c:	60a2                	ld	ra,8(sp)
    8000353e:	6402                	ld	s0,0(sp)
    80003540:	0141                	addi	sp,sp,16
    80003542:	8082                	ret

0000000080003544 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80003544:	7179                	addi	sp,sp,-48
    80003546:	f406                	sd	ra,40(sp)
    80003548:	f022                	sd	s0,32(sp)
    8000354a:	1800                	addi	s0,sp,48
    8000354c:	fca43c23          	sd	a0,-40(s0)
    80003550:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003554:	fffff097          	auipc	ra,0xfffff
    80003558:	2a4080e7          	jalr	676(ra) # 800027f8 <myproc>
    8000355c:	fea43423          	sd	a0,-24(s0)
  // change p->state and then call sched.
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.
  if(lk != &p->lock){  //DOC: sleeplock0
    80003560:	fe843783          	ld	a5,-24(s0)
    80003564:	fd043703          	ld	a4,-48(s0)
    80003568:	00f70f63          	beq	a4,a5,80003586 <sleep+0x42>
    acquire(&p->lock);  //DOC: sleeplock1
    8000356c:	fe843783          	ld	a5,-24(s0)
    80003570:	853e                	mv	a0,a5
    80003572:	ffffe097          	auipc	ra,0xffffe
    80003576:	d0e080e7          	jalr	-754(ra) # 80001280 <acquire>
    release(lk);
    8000357a:	fd043503          	ld	a0,-48(s0)
    8000357e:	ffffe097          	auipc	ra,0xffffe
    80003582:	d66080e7          	jalr	-666(ra) # 800012e4 <release>
  }

  // Go to sleep.
  p->chan = chan;
    80003586:	fe843783          	ld	a5,-24(s0)
    8000358a:	fd843703          	ld	a4,-40(s0)
    8000358e:	f798                	sd	a4,40(a5)
  p->state = SLEEPING;
    80003590:	fe843783          	ld	a5,-24(s0)
    80003594:	4705                	li	a4,1
    80003596:	cf98                	sw	a4,24(a5)

  sched();
    80003598:	00000097          	auipc	ra,0x0
    8000359c:	e2a080e7          	jalr	-470(ra) # 800033c2 <sched>

  // Tidy up.
  p->chan = 0;
    800035a0:	fe843783          	ld	a5,-24(s0)
    800035a4:	0207b423          	sd	zero,40(a5)

  // Reacquire original lock.
  if(lk != &p->lock){
    800035a8:	fe843783          	ld	a5,-24(s0)
    800035ac:	fd043703          	ld	a4,-48(s0)
    800035b0:	00f70f63          	beq	a4,a5,800035ce <sleep+0x8a>
    release(&p->lock);
    800035b4:	fe843783          	ld	a5,-24(s0)
    800035b8:	853e                	mv	a0,a5
    800035ba:	ffffe097          	auipc	ra,0xffffe
    800035be:	d2a080e7          	jalr	-726(ra) # 800012e4 <release>
    acquire(lk);
    800035c2:	fd043503          	ld	a0,-48(s0)
    800035c6:	ffffe097          	auipc	ra,0xffffe
    800035ca:	cba080e7          	jalr	-838(ra) # 80001280 <acquire>
  }
}
    800035ce:	0001                	nop
    800035d0:	70a2                	ld	ra,40(sp)
    800035d2:	7402                	ld	s0,32(sp)
    800035d4:	6145                	addi	sp,sp,48
    800035d6:	8082                	ret

00000000800035d8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800035d8:	7179                	addi	sp,sp,-48
    800035da:	f406                	sd	ra,40(sp)
    800035dc:	f022                	sd	s0,32(sp)
    800035de:	1800                	addi	s0,sp,48
    800035e0:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800035e4:	00011797          	auipc	a5,0x11
    800035e8:	0b478793          	addi	a5,a5,180 # 80014698 <proc>
    800035ec:	fef43423          	sd	a5,-24(s0)
    800035f0:	a889                	j	80003642 <wakeup+0x6a>
    acquire(&p->lock);
    800035f2:	fe843783          	ld	a5,-24(s0)
    800035f6:	853e                	mv	a0,a5
    800035f8:	ffffe097          	auipc	ra,0xffffe
    800035fc:	c88080e7          	jalr	-888(ra) # 80001280 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    80003600:	fe843783          	ld	a5,-24(s0)
    80003604:	4f9c                	lw	a5,24(a5)
    80003606:	873e                	mv	a4,a5
    80003608:	4785                	li	a5,1
    8000360a:	00f71d63          	bne	a4,a5,80003624 <wakeup+0x4c>
    8000360e:	fe843783          	ld	a5,-24(s0)
    80003612:	779c                	ld	a5,40(a5)
    80003614:	fd843703          	ld	a4,-40(s0)
    80003618:	00f71663          	bne	a4,a5,80003624 <wakeup+0x4c>
      p->state = RUNNABLE;
    8000361c:	fe843783          	ld	a5,-24(s0)
    80003620:	4709                	li	a4,2
    80003622:	cf98                	sw	a4,24(a5)
    }
    release(&p->lock);
    80003624:	fe843783          	ld	a5,-24(s0)
    80003628:	853e                	mv	a0,a5
    8000362a:	ffffe097          	auipc	ra,0xffffe
    8000362e:	cba080e7          	jalr	-838(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80003632:	fe843703          	ld	a4,-24(s0)
    80003636:	6785                	lui	a5,0x1
    80003638:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    8000363c:	97ba                	add	a5,a5,a4
    8000363e:	fef43423          	sd	a5,-24(s0)
    80003642:	fe843703          	ld	a4,-24(s0)
    80003646:	00060797          	auipc	a5,0x60
    8000364a:	45278793          	addi	a5,a5,1106 # 80063a98 <pid_lock>
    8000364e:	faf762e3          	bltu	a4,a5,800035f2 <wakeup+0x1a>
  }
}
    80003652:	0001                	nop
    80003654:	0001                	nop
    80003656:	70a2                	ld	ra,40(sp)
    80003658:	7402                	ld	s0,32(sp)
    8000365a:	6145                	addi	sp,sp,48
    8000365c:	8082                	ret

000000008000365e <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    8000365e:	1101                	addi	sp,sp,-32
    80003660:	ec06                	sd	ra,24(sp)
    80003662:	e822                	sd	s0,16(sp)
    80003664:	1000                	addi	s0,sp,32
    80003666:	fea43423          	sd	a0,-24(s0)
  if(!holding(&p->lock))
    8000366a:	fe843783          	ld	a5,-24(s0)
    8000366e:	853e                	mv	a0,a5
    80003670:	ffffe097          	auipc	ra,0xffffe
    80003674:	cca080e7          	jalr	-822(ra) # 8000133a <holding>
    80003678:	87aa                	mv	a5,a0
    8000367a:	eb89                	bnez	a5,8000368c <wakeup1+0x2e>
    panic("wakeup1");
    8000367c:	00008517          	auipc	a0,0x8
    80003680:	bc450513          	addi	a0,a0,-1084 # 8000b240 <etext+0x240>
    80003684:	ffffd097          	auipc	ra,0xffffd
    80003688:	5ce080e7          	jalr	1486(ra) # 80000c52 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    8000368c:	fe843783          	ld	a5,-24(s0)
    80003690:	779c                	ld	a5,40(a5)
    80003692:	fe843703          	ld	a4,-24(s0)
    80003696:	00f71d63          	bne	a4,a5,800036b0 <wakeup1+0x52>
    8000369a:	fe843783          	ld	a5,-24(s0)
    8000369e:	4f9c                	lw	a5,24(a5)
    800036a0:	873e                	mv	a4,a5
    800036a2:	4785                	li	a5,1
    800036a4:	00f71663          	bne	a4,a5,800036b0 <wakeup1+0x52>
    p->state = RUNNABLE;
    800036a8:	fe843783          	ld	a5,-24(s0)
    800036ac:	4709                	li	a4,2
    800036ae:	cf98                	sw	a4,24(a5)
  }
}
    800036b0:	0001                	nop
    800036b2:	60e2                	ld	ra,24(sp)
    800036b4:	6442                	ld	s0,16(sp)
    800036b6:	6105                	addi	sp,sp,32
    800036b8:	8082                	ret

00000000800036ba <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800036ba:	7179                	addi	sp,sp,-48
    800036bc:	f406                	sd	ra,40(sp)
    800036be:	f022                	sd	s0,32(sp)
    800036c0:	1800                	addi	s0,sp,48
    800036c2:	87aa                	mv	a5,a0
    800036c4:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800036c8:	00011797          	auipc	a5,0x11
    800036cc:	fd078793          	addi	a5,a5,-48 # 80014698 <proc>
    800036d0:	fef43423          	sd	a5,-24(s0)
    800036d4:	a0bd                	j	80003742 <kill+0x88>
    acquire(&p->lock);
    800036d6:	fe843783          	ld	a5,-24(s0)
    800036da:	853e                	mv	a0,a5
    800036dc:	ffffe097          	auipc	ra,0xffffe
    800036e0:	ba4080e7          	jalr	-1116(ra) # 80001280 <acquire>
    if(p->pid == pid){
    800036e4:	fe843783          	ld	a5,-24(s0)
    800036e8:	5f98                	lw	a4,56(a5)
    800036ea:	fdc42783          	lw	a5,-36(s0)
    800036ee:	2781                	sext.w	a5,a5
    800036f0:	02e79a63          	bne	a5,a4,80003724 <kill+0x6a>
      p->killed = 1;
    800036f4:	fe843783          	ld	a5,-24(s0)
    800036f8:	4705                	li	a4,1
    800036fa:	db98                	sw	a4,48(a5)
      if(p->state == SLEEPING){
    800036fc:	fe843783          	ld	a5,-24(s0)
    80003700:	4f9c                	lw	a5,24(a5)
    80003702:	873e                	mv	a4,a5
    80003704:	4785                	li	a5,1
    80003706:	00f71663          	bne	a4,a5,80003712 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    8000370a:	fe843783          	ld	a5,-24(s0)
    8000370e:	4709                	li	a4,2
    80003710:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003712:	fe843783          	ld	a5,-24(s0)
    80003716:	853e                	mv	a0,a5
    80003718:	ffffe097          	auipc	ra,0xffffe
    8000371c:	bcc080e7          	jalr	-1076(ra) # 800012e4 <release>
      return 0;
    80003720:	4781                	li	a5,0
    80003722:	a80d                	j	80003754 <kill+0x9a>
    }
    release(&p->lock);
    80003724:	fe843783          	ld	a5,-24(s0)
    80003728:	853e                	mv	a0,a5
    8000372a:	ffffe097          	auipc	ra,0xffffe
    8000372e:	bba080e7          	jalr	-1094(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003732:	fe843703          	ld	a4,-24(s0)
    80003736:	6785                	lui	a5,0x1
    80003738:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    8000373c:	97ba                	add	a5,a5,a4
    8000373e:	fef43423          	sd	a5,-24(s0)
    80003742:	fe843703          	ld	a4,-24(s0)
    80003746:	00060797          	auipc	a5,0x60
    8000374a:	35278793          	addi	a5,a5,850 # 80063a98 <pid_lock>
    8000374e:	f8f764e3          	bltu	a4,a5,800036d6 <kill+0x1c>
  }
  return -1;
    80003752:	57fd                	li	a5,-1
}
    80003754:	853e                	mv	a0,a5
    80003756:	70a2                	ld	ra,40(sp)
    80003758:	7402                	ld	s0,32(sp)
    8000375a:	6145                	addi	sp,sp,48
    8000375c:	8082                	ret

000000008000375e <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000375e:	7139                	addi	sp,sp,-64
    80003760:	fc06                	sd	ra,56(sp)
    80003762:	f822                	sd	s0,48(sp)
    80003764:	0080                	addi	s0,sp,64
    80003766:	87aa                	mv	a5,a0
    80003768:	fcb43823          	sd	a1,-48(s0)
    8000376c:	fcc43423          	sd	a2,-56(s0)
    80003770:	fcd43023          	sd	a3,-64(s0)
    80003774:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003778:	fffff097          	auipc	ra,0xfffff
    8000377c:	080080e7          	jalr	128(ra) # 800027f8 <myproc>
    80003780:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003784:	fdc42783          	lw	a5,-36(s0)
    80003788:	2781                	sext.w	a5,a5
    8000378a:	c785                	beqz	a5,800037b2 <either_copyout+0x54>
    return copyout(p->pagetable, dst, src, len);
    8000378c:	fe843703          	ld	a4,-24(s0)
    80003790:	6785                	lui	a5,0x1
    80003792:	97ba                	add	a5,a5,a4
    80003794:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003798:	fc043683          	ld	a3,-64(s0)
    8000379c:	fc843603          	ld	a2,-56(s0)
    800037a0:	fd043583          	ld	a1,-48(s0)
    800037a4:	853e                	mv	a0,a5
    800037a6:	fffff097          	auipc	ra,0xfffff
    800037aa:	b2e080e7          	jalr	-1234(ra) # 800022d4 <copyout>
    800037ae:	87aa                	mv	a5,a0
    800037b0:	a839                	j	800037ce <either_copyout+0x70>
  } else {
    memmove((char *)dst, src, len);
    800037b2:	fd043783          	ld	a5,-48(s0)
    800037b6:	fc043703          	ld	a4,-64(s0)
    800037ba:	2701                	sext.w	a4,a4
    800037bc:	863a                	mv	a2,a4
    800037be:	fc843583          	ld	a1,-56(s0)
    800037c2:	853e                	mv	a0,a5
    800037c4:	ffffe097          	auipc	ra,0xffffe
    800037c8:	d74080e7          	jalr	-652(ra) # 80001538 <memmove>
    return 0;
    800037cc:	4781                	li	a5,0
  }
}
    800037ce:	853e                	mv	a0,a5
    800037d0:	70e2                	ld	ra,56(sp)
    800037d2:	7442                	ld	s0,48(sp)
    800037d4:	6121                	addi	sp,sp,64
    800037d6:	8082                	ret

00000000800037d8 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800037d8:	7139                	addi	sp,sp,-64
    800037da:	fc06                	sd	ra,56(sp)
    800037dc:	f822                	sd	s0,48(sp)
    800037de:	0080                	addi	s0,sp,64
    800037e0:	fca43c23          	sd	a0,-40(s0)
    800037e4:	87ae                	mv	a5,a1
    800037e6:	fcc43423          	sd	a2,-56(s0)
    800037ea:	fcd43023          	sd	a3,-64(s0)
    800037ee:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    800037f2:	fffff097          	auipc	ra,0xfffff
    800037f6:	006080e7          	jalr	6(ra) # 800027f8 <myproc>
    800037fa:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    800037fe:	fd442783          	lw	a5,-44(s0)
    80003802:	2781                	sext.w	a5,a5
    80003804:	c785                	beqz	a5,8000382c <either_copyin+0x54>
    return copyin(p->pagetable, dst, src, len);
    80003806:	fe843703          	ld	a4,-24(s0)
    8000380a:	6785                	lui	a5,0x1
    8000380c:	97ba                	add	a5,a5,a4
    8000380e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003812:	fc043683          	ld	a3,-64(s0)
    80003816:	fc843603          	ld	a2,-56(s0)
    8000381a:	fd843583          	ld	a1,-40(s0)
    8000381e:	853e                	mv	a0,a5
    80003820:	fffff097          	auipc	ra,0xfffff
    80003824:	b82080e7          	jalr	-1150(ra) # 800023a2 <copyin>
    80003828:	87aa                	mv	a5,a0
    8000382a:	a839                	j	80003848 <either_copyin+0x70>
  } else {
    memmove(dst, (char*)src, len);
    8000382c:	fc843783          	ld	a5,-56(s0)
    80003830:	fc043703          	ld	a4,-64(s0)
    80003834:	2701                	sext.w	a4,a4
    80003836:	863a                	mv	a2,a4
    80003838:	85be                	mv	a1,a5
    8000383a:	fd843503          	ld	a0,-40(s0)
    8000383e:	ffffe097          	auipc	ra,0xffffe
    80003842:	cfa080e7          	jalr	-774(ra) # 80001538 <memmove>
    return 0;
    80003846:	4781                	li	a5,0
  }
}
    80003848:	853e                	mv	a0,a5
    8000384a:	70e2                	ld	ra,56(sp)
    8000384c:	7442                	ld	s0,48(sp)
    8000384e:	6121                	addi	sp,sp,64
    80003850:	8082                	ret

0000000080003852 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003852:	1101                	addi	sp,sp,-32
    80003854:	ec06                	sd	ra,24(sp)
    80003856:	e822                	sd	s0,16(sp)
    80003858:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000385a:	00008517          	auipc	a0,0x8
    8000385e:	9ee50513          	addi	a0,a0,-1554 # 8000b248 <etext+0x248>
    80003862:	ffffd097          	auipc	ra,0xffffd
    80003866:	19a080e7          	jalr	410(ra) # 800009fc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000386a:	00011797          	auipc	a5,0x11
    8000386e:	e2e78793          	addi	a5,a5,-466 # 80014698 <proc>
    80003872:	fef43423          	sd	a5,-24(s0)
    80003876:	a065                	j	8000391e <procdump+0xcc>
    if(p->state == UNUSED)
    80003878:	fe843783          	ld	a5,-24(s0)
    8000387c:	4f9c                	lw	a5,24(a5)
    8000387e:	c7d9                	beqz	a5,8000390c <procdump+0xba>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003880:	fe843783          	ld	a5,-24(s0)
    80003884:	4f9c                	lw	a5,24(a5)
    80003886:	873e                	mv	a4,a5
    80003888:	4791                	li	a5,4
    8000388a:	02e7ee63          	bltu	a5,a4,800038c6 <procdump+0x74>
    8000388e:	fe843783          	ld	a5,-24(s0)
    80003892:	4f9c                	lw	a5,24(a5)
    80003894:	00008717          	auipc	a4,0x8
    80003898:	f1c70713          	addi	a4,a4,-228 # 8000b7b0 <states.1723>
    8000389c:	1782                	slli	a5,a5,0x20
    8000389e:	9381                	srli	a5,a5,0x20
    800038a0:	078e                	slli	a5,a5,0x3
    800038a2:	97ba                	add	a5,a5,a4
    800038a4:	639c                	ld	a5,0(a5)
    800038a6:	c385                	beqz	a5,800038c6 <procdump+0x74>
      state = states[p->state];
    800038a8:	fe843783          	ld	a5,-24(s0)
    800038ac:	4f9c                	lw	a5,24(a5)
    800038ae:	00008717          	auipc	a4,0x8
    800038b2:	f0270713          	addi	a4,a4,-254 # 8000b7b0 <states.1723>
    800038b6:	1782                	slli	a5,a5,0x20
    800038b8:	9381                	srli	a5,a5,0x20
    800038ba:	078e                	slli	a5,a5,0x3
    800038bc:	97ba                	add	a5,a5,a4
    800038be:	639c                	ld	a5,0(a5)
    800038c0:	fef43023          	sd	a5,-32(s0)
    800038c4:	a039                	j	800038d2 <procdump+0x80>
    else
      state = "???";
    800038c6:	00008797          	auipc	a5,0x8
    800038ca:	98a78793          	addi	a5,a5,-1654 # 8000b250 <etext+0x250>
    800038ce:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    800038d2:	fe843783          	ld	a5,-24(s0)
    800038d6:	5f8c                	lw	a1,56(a5)
    800038d8:	fe843703          	ld	a4,-24(s0)
    800038dc:	6785                	lui	a5,0x1
    800038de:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    800038e2:	97ba                	add	a5,a5,a4
    800038e4:	86be                	mv	a3,a5
    800038e6:	fe043603          	ld	a2,-32(s0)
    800038ea:	00008517          	auipc	a0,0x8
    800038ee:	96e50513          	addi	a0,a0,-1682 # 8000b258 <etext+0x258>
    800038f2:	ffffd097          	auipc	ra,0xffffd
    800038f6:	10a080e7          	jalr	266(ra) # 800009fc <printf>
    printf("\n");
    800038fa:	00008517          	auipc	a0,0x8
    800038fe:	94e50513          	addi	a0,a0,-1714 # 8000b248 <etext+0x248>
    80003902:	ffffd097          	auipc	ra,0xffffd
    80003906:	0fa080e7          	jalr	250(ra) # 800009fc <printf>
    8000390a:	a011                	j	8000390e <procdump+0xbc>
      continue;
    8000390c:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    8000390e:	fe843703          	ld	a4,-24(s0)
    80003912:	6785                	lui	a5,0x1
    80003914:	3d078793          	addi	a5,a5,976 # 13d0 <_entry-0x7fffec30>
    80003918:	97ba                	add	a5,a5,a4
    8000391a:	fef43423          	sd	a5,-24(s0)
    8000391e:	fe843703          	ld	a4,-24(s0)
    80003922:	00060797          	auipc	a5,0x60
    80003926:	17678793          	addi	a5,a5,374 # 80063a98 <pid_lock>
    8000392a:	f4f767e3          	bltu	a4,a5,80003878 <procdump+0x26>
  }
}
    8000392e:	0001                	nop
    80003930:	0001                	nop
    80003932:	60e2                	ld	ra,24(sp)
    80003934:	6442                	ld	s0,16(sp)
    80003936:	6105                	addi	sp,sp,32
    80003938:	8082                	ret

000000008000393a <swtch>:
    8000393a:	00153023          	sd	ra,0(a0)
    8000393e:	00253423          	sd	sp,8(a0)
    80003942:	e900                	sd	s0,16(a0)
    80003944:	ed04                	sd	s1,24(a0)
    80003946:	03253023          	sd	s2,32(a0)
    8000394a:	03353423          	sd	s3,40(a0)
    8000394e:	03453823          	sd	s4,48(a0)
    80003952:	03553c23          	sd	s5,56(a0)
    80003956:	05653023          	sd	s6,64(a0)
    8000395a:	05753423          	sd	s7,72(a0)
    8000395e:	05853823          	sd	s8,80(a0)
    80003962:	05953c23          	sd	s9,88(a0)
    80003966:	07a53023          	sd	s10,96(a0)
    8000396a:	07b53423          	sd	s11,104(a0)
    8000396e:	0005b083          	ld	ra,0(a1)
    80003972:	0085b103          	ld	sp,8(a1)
    80003976:	6980                	ld	s0,16(a1)
    80003978:	6d84                	ld	s1,24(a1)
    8000397a:	0205b903          	ld	s2,32(a1)
    8000397e:	0285b983          	ld	s3,40(a1)
    80003982:	0305ba03          	ld	s4,48(a1)
    80003986:	0385ba83          	ld	s5,56(a1)
    8000398a:	0405bb03          	ld	s6,64(a1)
    8000398e:	0485bb83          	ld	s7,72(a1)
    80003992:	0505bc03          	ld	s8,80(a1)
    80003996:	0585bc83          	ld	s9,88(a1)
    8000399a:	0605bd03          	ld	s10,96(a1)
    8000399e:	0685bd83          	ld	s11,104(a1)
    800039a2:	8082                	ret

00000000800039a4 <r_sstatus>:
{
    800039a4:	1101                	addi	sp,sp,-32
    800039a6:	ec22                	sd	s0,24(sp)
    800039a8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800039aa:	100027f3          	csrr	a5,sstatus
    800039ae:	fef43423          	sd	a5,-24(s0)
  return x;
    800039b2:	fe843783          	ld	a5,-24(s0)
}
    800039b6:	853e                	mv	a0,a5
    800039b8:	6462                	ld	s0,24(sp)
    800039ba:	6105                	addi	sp,sp,32
    800039bc:	8082                	ret

00000000800039be <w_sstatus>:
{
    800039be:	1101                	addi	sp,sp,-32
    800039c0:	ec22                	sd	s0,24(sp)
    800039c2:	1000                	addi	s0,sp,32
    800039c4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800039c8:	fe843783          	ld	a5,-24(s0)
    800039cc:	10079073          	csrw	sstatus,a5
}
    800039d0:	0001                	nop
    800039d2:	6462                	ld	s0,24(sp)
    800039d4:	6105                	addi	sp,sp,32
    800039d6:	8082                	ret

00000000800039d8 <r_sip>:
{
    800039d8:	1101                	addi	sp,sp,-32
    800039da:	ec22                	sd	s0,24(sp)
    800039dc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    800039de:	144027f3          	csrr	a5,sip
    800039e2:	fef43423          	sd	a5,-24(s0)
  return x;
    800039e6:	fe843783          	ld	a5,-24(s0)
}
    800039ea:	853e                	mv	a0,a5
    800039ec:	6462                	ld	s0,24(sp)
    800039ee:	6105                	addi	sp,sp,32
    800039f0:	8082                	ret

00000000800039f2 <w_sip>:
{
    800039f2:	1101                	addi	sp,sp,-32
    800039f4:	ec22                	sd	s0,24(sp)
    800039f6:	1000                	addi	s0,sp,32
    800039f8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    800039fc:	fe843783          	ld	a5,-24(s0)
    80003a00:	14479073          	csrw	sip,a5
}
    80003a04:	0001                	nop
    80003a06:	6462                	ld	s0,24(sp)
    80003a08:	6105                	addi	sp,sp,32
    80003a0a:	8082                	ret

0000000080003a0c <w_sepc>:
{
    80003a0c:	1101                	addi	sp,sp,-32
    80003a0e:	ec22                	sd	s0,24(sp)
    80003a10:	1000                	addi	s0,sp,32
    80003a12:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80003a16:	fe843783          	ld	a5,-24(s0)
    80003a1a:	14179073          	csrw	sepc,a5
}
    80003a1e:	0001                	nop
    80003a20:	6462                	ld	s0,24(sp)
    80003a22:	6105                	addi	sp,sp,32
    80003a24:	8082                	ret

0000000080003a26 <r_sepc>:
{
    80003a26:	1101                	addi	sp,sp,-32
    80003a28:	ec22                	sd	s0,24(sp)
    80003a2a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003a2c:	141027f3          	csrr	a5,sepc
    80003a30:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a34:	fe843783          	ld	a5,-24(s0)
}
    80003a38:	853e                	mv	a0,a5
    80003a3a:	6462                	ld	s0,24(sp)
    80003a3c:	6105                	addi	sp,sp,32
    80003a3e:	8082                	ret

0000000080003a40 <w_stvec>:
{
    80003a40:	1101                	addi	sp,sp,-32
    80003a42:	ec22                	sd	s0,24(sp)
    80003a44:	1000                	addi	s0,sp,32
    80003a46:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003a4a:	fe843783          	ld	a5,-24(s0)
    80003a4e:	10579073          	csrw	stvec,a5
}
    80003a52:	0001                	nop
    80003a54:	6462                	ld	s0,24(sp)
    80003a56:	6105                	addi	sp,sp,32
    80003a58:	8082                	ret

0000000080003a5a <r_satp>:
{
    80003a5a:	1101                	addi	sp,sp,-32
    80003a5c:	ec22                	sd	s0,24(sp)
    80003a5e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003a60:	180027f3          	csrr	a5,satp
    80003a64:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a68:	fe843783          	ld	a5,-24(s0)
}
    80003a6c:	853e                	mv	a0,a5
    80003a6e:	6462                	ld	s0,24(sp)
    80003a70:	6105                	addi	sp,sp,32
    80003a72:	8082                	ret

0000000080003a74 <r_scause>:
{
    80003a74:	1101                	addi	sp,sp,-32
    80003a76:	ec22                	sd	s0,24(sp)
    80003a78:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003a7a:	142027f3          	csrr	a5,scause
    80003a7e:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a82:	fe843783          	ld	a5,-24(s0)
}
    80003a86:	853e                	mv	a0,a5
    80003a88:	6462                	ld	s0,24(sp)
    80003a8a:	6105                	addi	sp,sp,32
    80003a8c:	8082                	ret

0000000080003a8e <r_stval>:
{
    80003a8e:	1101                	addi	sp,sp,-32
    80003a90:	ec22                	sd	s0,24(sp)
    80003a92:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003a94:	143027f3          	csrr	a5,stval
    80003a98:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a9c:	fe843783          	ld	a5,-24(s0)
}
    80003aa0:	853e                	mv	a0,a5
    80003aa2:	6462                	ld	s0,24(sp)
    80003aa4:	6105                	addi	sp,sp,32
    80003aa6:	8082                	ret

0000000080003aa8 <intr_on>:
{
    80003aa8:	1141                	addi	sp,sp,-16
    80003aaa:	e406                	sd	ra,8(sp)
    80003aac:	e022                	sd	s0,0(sp)
    80003aae:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80003ab0:	00000097          	auipc	ra,0x0
    80003ab4:	ef4080e7          	jalr	-268(ra) # 800039a4 <r_sstatus>
    80003ab8:	87aa                	mv	a5,a0
    80003aba:	0027e793          	ori	a5,a5,2
    80003abe:	853e                	mv	a0,a5
    80003ac0:	00000097          	auipc	ra,0x0
    80003ac4:	efe080e7          	jalr	-258(ra) # 800039be <w_sstatus>
}
    80003ac8:	0001                	nop
    80003aca:	60a2                	ld	ra,8(sp)
    80003acc:	6402                	ld	s0,0(sp)
    80003ace:	0141                	addi	sp,sp,16
    80003ad0:	8082                	ret

0000000080003ad2 <intr_off>:
{
    80003ad2:	1141                	addi	sp,sp,-16
    80003ad4:	e406                	sd	ra,8(sp)
    80003ad6:	e022                	sd	s0,0(sp)
    80003ad8:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003ada:	00000097          	auipc	ra,0x0
    80003ade:	eca080e7          	jalr	-310(ra) # 800039a4 <r_sstatus>
    80003ae2:	87aa                	mv	a5,a0
    80003ae4:	9bf5                	andi	a5,a5,-3
    80003ae6:	853e                	mv	a0,a5
    80003ae8:	00000097          	auipc	ra,0x0
    80003aec:	ed6080e7          	jalr	-298(ra) # 800039be <w_sstatus>
}
    80003af0:	0001                	nop
    80003af2:	60a2                	ld	ra,8(sp)
    80003af4:	6402                	ld	s0,0(sp)
    80003af6:	0141                	addi	sp,sp,16
    80003af8:	8082                	ret

0000000080003afa <intr_get>:
{
    80003afa:	1101                	addi	sp,sp,-32
    80003afc:	ec06                	sd	ra,24(sp)
    80003afe:	e822                	sd	s0,16(sp)
    80003b00:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003b02:	00000097          	auipc	ra,0x0
    80003b06:	ea2080e7          	jalr	-350(ra) # 800039a4 <r_sstatus>
    80003b0a:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003b0e:	fe843783          	ld	a5,-24(s0)
    80003b12:	8b89                	andi	a5,a5,2
    80003b14:	00f037b3          	snez	a5,a5
    80003b18:	0ff7f793          	andi	a5,a5,255
    80003b1c:	2781                	sext.w	a5,a5
}
    80003b1e:	853e                	mv	a0,a5
    80003b20:	60e2                	ld	ra,24(sp)
    80003b22:	6442                	ld	s0,16(sp)
    80003b24:	6105                	addi	sp,sp,32
    80003b26:	8082                	ret

0000000080003b28 <r_tp>:
{
    80003b28:	1101                	addi	sp,sp,-32
    80003b2a:	ec22                	sd	s0,24(sp)
    80003b2c:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80003b2e:	8792                	mv	a5,tp
    80003b30:	fef43423          	sd	a5,-24(s0)
  return x;
    80003b34:	fe843783          	ld	a5,-24(s0)
}
    80003b38:	853e                	mv	a0,a5
    80003b3a:	6462                	ld	s0,24(sp)
    80003b3c:	6105                	addi	sp,sp,32
    80003b3e:	8082                	ret

0000000080003b40 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80003b40:	1141                	addi	sp,sp,-16
    80003b42:	e406                	sd	ra,8(sp)
    80003b44:	e022                	sd	s0,0(sp)
    80003b46:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003b48:	00007597          	auipc	a1,0x7
    80003b4c:	75058593          	addi	a1,a1,1872 # 8000b298 <etext+0x298>
    80003b50:	00060517          	auipc	a0,0x60
    80003b54:	f6050513          	addi	a0,a0,-160 # 80063ab0 <tickslock>
    80003b58:	ffffd097          	auipc	ra,0xffffd
    80003b5c:	6f8080e7          	jalr	1784(ra) # 80001250 <initlock>
}
    80003b60:	0001                	nop
    80003b62:	60a2                	ld	ra,8(sp)
    80003b64:	6402                	ld	s0,0(sp)
    80003b66:	0141                	addi	sp,sp,16
    80003b68:	8082                	ret

0000000080003b6a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003b6a:	1141                	addi	sp,sp,-16
    80003b6c:	e406                	sd	ra,8(sp)
    80003b6e:	e022                	sd	s0,0(sp)
    80003b70:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80003b72:	00005797          	auipc	a5,0x5
    80003b76:	05e78793          	addi	a5,a5,94 # 80008bd0 <kernelvec>
    80003b7a:	853e                	mv	a0,a5
    80003b7c:	00000097          	auipc	ra,0x0
    80003b80:	ec4080e7          	jalr	-316(ra) # 80003a40 <w_stvec>
}
    80003b84:	0001                	nop
    80003b86:	60a2                	ld	ra,8(sp)
    80003b88:	6402                	ld	s0,0(sp)
    80003b8a:	0141                	addi	sp,sp,16
    80003b8c:	8082                	ret

0000000080003b8e <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    80003b8e:	7179                	addi	sp,sp,-48
    80003b90:	f406                	sd	ra,40(sp)
    80003b92:	f022                	sd	s0,32(sp)
    80003b94:	ec26                	sd	s1,24(sp)
    80003b96:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80003b98:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80003b9c:	00000097          	auipc	ra,0x0
    80003ba0:	e08080e7          	jalr	-504(ra) # 800039a4 <r_sstatus>
    80003ba4:	87aa                	mv	a5,a0
    80003ba6:	1007f793          	andi	a5,a5,256
    80003baa:	cb89                	beqz	a5,80003bbc <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80003bac:	00007517          	auipc	a0,0x7
    80003bb0:	6f450513          	addi	a0,a0,1780 # 8000b2a0 <etext+0x2a0>
    80003bb4:	ffffd097          	auipc	ra,0xffffd
    80003bb8:	09e080e7          	jalr	158(ra) # 80000c52 <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    80003bbc:	00005797          	auipc	a5,0x5
    80003bc0:	01478793          	addi	a5,a5,20 # 80008bd0 <kernelvec>
    80003bc4:	853e                	mv	a0,a5
    80003bc6:	00000097          	auipc	ra,0x0
    80003bca:	e7a080e7          	jalr	-390(ra) # 80003a40 <w_stvec>

  struct proc *p = myproc();
    80003bce:	fffff097          	auipc	ra,0xfffff
    80003bd2:	c2a080e7          	jalr	-982(ra) # 800027f8 <myproc>
    80003bd6:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80003bda:	fd043703          	ld	a4,-48(s0)
    80003bde:	6785                	lui	a5,0x1
    80003be0:	97ba                	add	a5,a5,a4
    80003be2:	2c07b483          	ld	s1,704(a5) # 12c0 <_entry-0x7fffed40>
    80003be6:	00000097          	auipc	ra,0x0
    80003bea:	e40080e7          	jalr	-448(ra) # 80003a26 <r_sepc>
    80003bee:	87aa                	mv	a5,a0
    80003bf0:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80003bf2:	00000097          	auipc	ra,0x0
    80003bf6:	e82080e7          	jalr	-382(ra) # 80003a74 <r_scause>
    80003bfa:	872a                	mv	a4,a0
    80003bfc:	47a1                	li	a5,8
    80003bfe:	04f71363          	bne	a4,a5,80003c44 <usertrap+0xb6>
    // system call

    if(p->killed)
    80003c02:	fd043783          	ld	a5,-48(s0)
    80003c06:	5b9c                	lw	a5,48(a5)
    80003c08:	c791                	beqz	a5,80003c14 <usertrap+0x86>
      exit(-1);
    80003c0a:	557d                	li	a0,-1
    80003c0c:	fffff097          	auipc	ra,0xfffff
    80003c10:	3fa080e7          	jalr	1018(ra) # 80003006 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80003c14:	fd043703          	ld	a4,-48(s0)
    80003c18:	6785                	lui	a5,0x1
    80003c1a:	97ba                	add	a5,a5,a4
    80003c1c:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003c20:	6f98                	ld	a4,24(a5)
    80003c22:	fd043683          	ld	a3,-48(s0)
    80003c26:	6785                	lui	a5,0x1
    80003c28:	97b6                	add	a5,a5,a3
    80003c2a:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003c2e:	0711                	addi	a4,a4,4
    80003c30:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    80003c32:	00000097          	auipc	ra,0x0
    80003c36:	e76080e7          	jalr	-394(ra) # 80003aa8 <intr_on>

    syscall();
    80003c3a:	00001097          	auipc	ra,0x1
    80003c3e:	8c4080e7          	jalr	-1852(ra) # 800044fe <syscall>
    80003c42:	a0b5                	j	80003cae <usertrap+0x120>
  } else if((which_dev = devintr()) != 0){
    80003c44:	00000097          	auipc	ra,0x0
    80003c48:	550080e7          	jalr	1360(ra) # 80004194 <devintr>
    80003c4c:	87aa                	mv	a5,a0
    80003c4e:	fcf42e23          	sw	a5,-36(s0)
    80003c52:	fdc42783          	lw	a5,-36(s0)
    80003c56:	2781                	sext.w	a5,a5
    80003c58:	ebb9                	bnez	a5,80003cae <usertrap+0x120>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003c5a:	00000097          	auipc	ra,0x0
    80003c5e:	e1a080e7          	jalr	-486(ra) # 80003a74 <r_scause>
    80003c62:	872a                	mv	a4,a0
    80003c64:	fd043783          	ld	a5,-48(s0)
    80003c68:	5f9c                	lw	a5,56(a5)
    80003c6a:	863e                	mv	a2,a5
    80003c6c:	85ba                	mv	a1,a4
    80003c6e:	00007517          	auipc	a0,0x7
    80003c72:	65250513          	addi	a0,a0,1618 # 8000b2c0 <etext+0x2c0>
    80003c76:	ffffd097          	auipc	ra,0xffffd
    80003c7a:	d86080e7          	jalr	-634(ra) # 800009fc <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003c7e:	00000097          	auipc	ra,0x0
    80003c82:	da8080e7          	jalr	-600(ra) # 80003a26 <r_sepc>
    80003c86:	84aa                	mv	s1,a0
    80003c88:	00000097          	auipc	ra,0x0
    80003c8c:	e06080e7          	jalr	-506(ra) # 80003a8e <r_stval>
    80003c90:	87aa                	mv	a5,a0
    80003c92:	863e                	mv	a2,a5
    80003c94:	85a6                	mv	a1,s1
    80003c96:	00007517          	auipc	a0,0x7
    80003c9a:	65a50513          	addi	a0,a0,1626 # 8000b2f0 <etext+0x2f0>
    80003c9e:	ffffd097          	auipc	ra,0xffffd
    80003ca2:	d5e080e7          	jalr	-674(ra) # 800009fc <printf>
    p->killed = 1;
    80003ca6:	fd043783          	ld	a5,-48(s0)
    80003caa:	4705                	li	a4,1
    80003cac:	db98                	sw	a4,48(a5)
  }

  if(p->killed)
    80003cae:	fd043783          	ld	a5,-48(s0)
    80003cb2:	5b9c                	lw	a5,48(a5)
    80003cb4:	c791                	beqz	a5,80003cc0 <usertrap+0x132>
    exit(-1);
    80003cb6:	557d                	li	a0,-1
    80003cb8:	fffff097          	auipc	ra,0xfffff
    80003cbc:	34e080e7          	jalr	846(ra) # 80003006 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2){
    80003cc0:	fdc42783          	lw	a5,-36(s0)
    80003cc4:	0007871b          	sext.w	a4,a5
    80003cc8:	4789                	li	a5,2
    80003cca:	04f71763          	bne	a4,a5,80003d18 <usertrap+0x18a>
    // for mp3
    if(p->thrdstop_delay > 0){
    80003cce:	fd043783          	ld	a5,-48(s0)
    80003cd2:	43bc                	lw	a5,64(a5)
    80003cd4:	02f05e63          	blez	a5,80003d10 <usertrap+0x182>
      p->thrdstop_ticks++;
    80003cd8:	fd043783          	ld	a5,-48(s0)
    80003cdc:	5fdc                	lw	a5,60(a5)
    80003cde:	2785                	addiw	a5,a5,1
    80003ce0:	0007871b          	sext.w	a4,a5
    80003ce4:	fd043783          	ld	a5,-48(s0)
    80003ce8:	dfd8                	sw	a4,60(a5)
      if(p->thrdstop_ticks >= p->thrdstop_delay){
    80003cea:	fd043783          	ld	a5,-48(s0)
    80003cee:	5fd8                	lw	a4,60(a5)
    80003cf0:	fd043783          	ld	a5,-48(s0)
    80003cf4:	43bc                	lw	a5,64(a5)
    80003cf6:	00f74d63          	blt	a4,a5,80003d10 <usertrap+0x182>
        p->thrdstop_delay = -1;
    80003cfa:	fd043783          	ld	a5,-48(s0)
    80003cfe:	577d                	li	a4,-1
    80003d00:	c3b8                	sw	a4,64(a5)
        p->jump_flag = 1;
    80003d02:	fd043703          	ld	a4,-48(s0)
    80003d06:	6785                	lui	a5,0x1
    80003d08:	97ba                	add	a5,a5,a4
    80003d0a:	4705                	li	a4,1
    80003d0c:	28e7ac23          	sw	a4,664(a5) # 1298 <_entry-0x7fffed68>
      }
    }
    yield();
    80003d10:	fffff097          	auipc	ra,0xfffff
    80003d14:	79a080e7          	jalr	1946(ra) # 800034aa <yield>
  }
  usertrapret();
    80003d18:	00000097          	auipc	ra,0x0
    80003d1c:	014080e7          	jalr	20(ra) # 80003d2c <usertrapret>
}
    80003d20:	0001                	nop
    80003d22:	70a2                	ld	ra,40(sp)
    80003d24:	7402                	ld	s0,32(sp)
    80003d26:	64e2                	ld	s1,24(sp)
    80003d28:	6145                	addi	sp,sp,48
    80003d2a:	8082                	ret

0000000080003d2c <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80003d2c:	711d                	addi	sp,sp,-96
    80003d2e:	ec86                	sd	ra,88(sp)
    80003d30:	e8a2                	sd	s0,80(sp)
    80003d32:	e4a6                	sd	s1,72(sp)
    80003d34:	1080                	addi	s0,sp,96
  struct proc *p = myproc();
    80003d36:	fffff097          	auipc	ra,0xfffff
    80003d3a:	ac2080e7          	jalr	-1342(ra) # 800027f8 <myproc>
    80003d3e:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    80003d42:	00000097          	auipc	ra,0x0
    80003d46:	d90080e7          	jalr	-624(ra) # 80003ad2 <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80003d4a:	00006717          	auipc	a4,0x6
    80003d4e:	2b670713          	addi	a4,a4,694 # 8000a000 <_trampoline>
    80003d52:	00006797          	auipc	a5,0x6
    80003d56:	2ae78793          	addi	a5,a5,686 # 8000a000 <_trampoline>
    80003d5a:	8f1d                	sub	a4,a4,a5
    80003d5c:	040007b7          	lui	a5,0x4000
    80003d60:	17fd                	addi	a5,a5,-1
    80003d62:	07b2                	slli	a5,a5,0xc
    80003d64:	97ba                	add	a5,a5,a4
    80003d66:	853e                	mv	a0,a5
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	cd8080e7          	jalr	-808(ra) # 80003a40 <w_stvec>

  if(p->resume_flag != -1){ // handle thrdresume
    80003d70:	fd843703          	ld	a4,-40(s0)
    80003d74:	6785                	lui	a5,0x1
    80003d76:	97ba                	add	a5,a5,a4
    80003d78:	29c7a783          	lw	a5,668(a5) # 129c <_entry-0x7fffed64>
    80003d7c:	873e                	mv	a4,a5
    80003d7e:	57fd                	li	a5,-1
    80003d80:	04f70b63          	beq	a4,a5,80003dd6 <usertrapret+0xaa>
    // restore user context
    struct trapframe *now_thrd_context = &(p->thrdstop_context[p->resume_flag]);
    80003d84:	fd843703          	ld	a4,-40(s0)
    80003d88:	6785                	lui	a5,0x1
    80003d8a:	97ba                	add	a5,a5,a4
    80003d8c:	29c7a703          	lw	a4,668(a5) # 129c <_entry-0x7fffed64>
    80003d90:	87ba                	mv	a5,a4
    80003d92:	078e                	slli	a5,a5,0x3
    80003d94:	97ba                	add	a5,a5,a4
    80003d96:	0796                	slli	a5,a5,0x5
    80003d98:	05078793          	addi	a5,a5,80
    80003d9c:	fd843703          	ld	a4,-40(s0)
    80003da0:	97ba                	add	a5,a5,a4
    80003da2:	07a1                	addi	a5,a5,8
    80003da4:	fcf43023          	sd	a5,-64(s0)
    memmove(p->trapframe, now_thrd_context, sizeof(struct trapframe));
    80003da8:	fd843703          	ld	a4,-40(s0)
    80003dac:	6785                	lui	a5,0x1
    80003dae:	97ba                	add	a5,a5,a4
    80003db0:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003db4:	12000613          	li	a2,288
    80003db8:	fc043583          	ld	a1,-64(s0)
    80003dbc:	853e                	mv	a0,a5
    80003dbe:	ffffd097          	auipc	ra,0xffffd
    80003dc2:	77a080e7          	jalr	1914(ra) # 80001538 <memmove>
    // clear falg
    p->resume_flag = -1;
    80003dc6:	fd843703          	ld	a4,-40(s0)
    80003dca:	6785                	lui	a5,0x1
    80003dcc:	97ba                	add	a5,a5,a4
    80003dce:	577d                	li	a4,-1
    80003dd0:	28e7ae23          	sw	a4,668(a5) # 129c <_entry-0x7fffed64>
    80003dd4:	a0f5                	j	80003ec0 <usertrapret+0x194>
  }else if(p->jump_flag == 1){ // handle thrdstop
    80003dd6:	fd843703          	ld	a4,-40(s0)
    80003dda:	6785                	lui	a5,0x1
    80003ddc:	97ba                	add	a5,a5,a4
    80003dde:	2987a783          	lw	a5,664(a5) # 1298 <_entry-0x7fffed68>
    80003de2:	873e                	mv	a4,a5
    80003de4:	4785                	li	a5,1
    80003de6:	06f71b63          	bne	a4,a5,80003e5c <usertrapret+0x130>
    // save user context
    struct trapframe *now_thrd_context = &(p->thrdstop_context[p->thrdstop_context_id]);
    80003dea:	fd843783          	ld	a5,-40(s0)
    80003dee:	43f8                	lw	a4,68(a5)
    80003df0:	87ba                	mv	a5,a4
    80003df2:	078e                	slli	a5,a5,0x3
    80003df4:	97ba                	add	a5,a5,a4
    80003df6:	0796                	slli	a5,a5,0x5
    80003df8:	05078793          	addi	a5,a5,80
    80003dfc:	fd843703          	ld	a4,-40(s0)
    80003e00:	97ba                	add	a5,a5,a4
    80003e02:	07a1                	addi	a5,a5,8
    80003e04:	fcf43423          	sd	a5,-56(s0)
    memmove(now_thrd_context, p->trapframe, sizeof(struct trapframe));
    80003e08:	fd843703          	ld	a4,-40(s0)
    80003e0c:	6785                	lui	a5,0x1
    80003e0e:	97ba                	add	a5,a5,a4
    80003e10:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003e14:	12000613          	li	a2,288
    80003e18:	85be                	mv	a1,a5
    80003e1a:	fc843503          	ld	a0,-56(s0)
    80003e1e:	ffffd097          	auipc	ra,0xffffd
    80003e22:	71a080e7          	jalr	1818(ra) # 80001538 <memmove>
    // clear flag
    p->jump_flag = 0;
    80003e26:	fd843703          	ld	a4,-40(s0)
    80003e2a:	6785                	lui	a5,0x1
    80003e2c:	97ba                	add	a5,a5,a4
    80003e2e:	2807ac23          	sw	zero,664(a5) # 1298 <_entry-0x7fffed68>
    // set pc to handler function
    p->trapframe->epc = p->thrdstop_handler_pointer;
    80003e32:	fd843703          	ld	a4,-40(s0)
    80003e36:	6785                	lui	a5,0x1
    80003e38:	97ba                	add	a5,a5,a4
    80003e3a:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003e3e:	fd843703          	ld	a4,-40(s0)
    80003e42:	6b38                	ld	a4,80(a4)
    80003e44:	ef98                	sd	a4,24(a5)
    p->trapframe->a0 = p->thrdstop_handler_arg;
    80003e46:	fd843703          	ld	a4,-40(s0)
    80003e4a:	6785                	lui	a5,0x1
    80003e4c:	97ba                	add	a5,a5,a4
    80003e4e:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003e52:	fd843703          	ld	a4,-40(s0)
    80003e56:	6738                	ld	a4,72(a4)
    80003e58:	fbb8                	sd	a4,112(a5)
    80003e5a:	a09d                	j	80003ec0 <usertrapret+0x194>
  }else if(p->cancel_save_flag != -1){ // handle cancelthrdstop
    80003e5c:	fd843703          	ld	a4,-40(s0)
    80003e60:	6785                	lui	a5,0x1
    80003e62:	97ba                	add	a5,a5,a4
    80003e64:	2a07a783          	lw	a5,672(a5) # 12a0 <_entry-0x7fffed60>
    80003e68:	873e                	mv	a4,a5
    80003e6a:	57fd                	li	a5,-1
    80003e6c:	04f70a63          	beq	a4,a5,80003ec0 <usertrapret+0x194>
    // save user context
    struct trapframe *now_thrd_context = &(p->thrdstop_context[p->cancel_save_flag]);
    80003e70:	fd843703          	ld	a4,-40(s0)
    80003e74:	6785                	lui	a5,0x1
    80003e76:	97ba                	add	a5,a5,a4
    80003e78:	2a07a703          	lw	a4,672(a5) # 12a0 <_entry-0x7fffed60>
    80003e7c:	87ba                	mv	a5,a4
    80003e7e:	078e                	slli	a5,a5,0x3
    80003e80:	97ba                	add	a5,a5,a4
    80003e82:	0796                	slli	a5,a5,0x5
    80003e84:	05078793          	addi	a5,a5,80
    80003e88:	fd843703          	ld	a4,-40(s0)
    80003e8c:	97ba                	add	a5,a5,a4
    80003e8e:	07a1                	addi	a5,a5,8
    80003e90:	fcf43823          	sd	a5,-48(s0)
    memmove(now_thrd_context, p->trapframe, sizeof(struct trapframe));
    80003e94:	fd843703          	ld	a4,-40(s0)
    80003e98:	6785                	lui	a5,0x1
    80003e9a:	97ba                	add	a5,a5,a4
    80003e9c:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003ea0:	12000613          	li	a2,288
    80003ea4:	85be                	mv	a1,a5
    80003ea6:	fd043503          	ld	a0,-48(s0)
    80003eaa:	ffffd097          	auipc	ra,0xffffd
    80003eae:	68e080e7          	jalr	1678(ra) # 80001538 <memmove>
    // clear flag
    p->cancel_save_flag = -1;
    80003eb2:	fd843703          	ld	a4,-40(s0)
    80003eb6:	6785                	lui	a5,0x1
    80003eb8:	97ba                	add	a5,a5,a4
    80003eba:	577d                	li	a4,-1
    80003ebc:	2ae7a023          	sw	a4,672(a5) # 12a0 <_entry-0x7fffed60>
  }

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003ec0:	fd843703          	ld	a4,-40(s0)
    80003ec4:	6785                	lui	a5,0x1
    80003ec6:	97ba                	add	a5,a5,a4
    80003ec8:	2c07b483          	ld	s1,704(a5) # 12c0 <_entry-0x7fffed40>
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	b8e080e7          	jalr	-1138(ra) # 80003a5a <r_satp>
    80003ed4:	87aa                	mv	a5,a0
    80003ed6:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80003ed8:	fd843703          	ld	a4,-40(s0)
    80003edc:	6785                	lui	a5,0x1
    80003ede:	97ba                	add	a5,a5,a4
    80003ee0:	2a87b683          	ld	a3,680(a5) # 12a8 <_entry-0x7fffed58>
    80003ee4:	fd843703          	ld	a4,-40(s0)
    80003ee8:	6785                	lui	a5,0x1
    80003eea:	97ba                	add	a5,a5,a4
    80003eec:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003ef0:	6705                	lui	a4,0x1
    80003ef2:	9736                	add	a4,a4,a3
    80003ef4:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003ef6:	fd843703          	ld	a4,-40(s0)
    80003efa:	6785                	lui	a5,0x1
    80003efc:	97ba                	add	a5,a5,a4
    80003efe:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003f02:	00000717          	auipc	a4,0x0
    80003f06:	c8c70713          	addi	a4,a4,-884 # 80003b8e <usertrap>
    80003f0a:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003f0c:	fd843703          	ld	a4,-40(s0)
    80003f10:	6785                	lui	a5,0x1
    80003f12:	97ba                	add	a5,a5,a4
    80003f14:	2c07b483          	ld	s1,704(a5) # 12c0 <_entry-0x7fffed40>
    80003f18:	00000097          	auipc	ra,0x0
    80003f1c:	c10080e7          	jalr	-1008(ra) # 80003b28 <r_tp>
    80003f20:	87aa                	mv	a5,a0
    80003f22:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80003f24:	00000097          	auipc	ra,0x0
    80003f28:	a80080e7          	jalr	-1408(ra) # 800039a4 <r_sstatus>
    80003f2c:	faa43c23          	sd	a0,-72(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80003f30:	fb843783          	ld	a5,-72(s0)
    80003f34:	eff7f793          	andi	a5,a5,-257
    80003f38:	faf43c23          	sd	a5,-72(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80003f3c:	fb843783          	ld	a5,-72(s0)
    80003f40:	0207e793          	ori	a5,a5,32
    80003f44:	faf43c23          	sd	a5,-72(s0)
  w_sstatus(x);
    80003f48:	fb843503          	ld	a0,-72(s0)
    80003f4c:	00000097          	auipc	ra,0x0
    80003f50:	a72080e7          	jalr	-1422(ra) # 800039be <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80003f54:	fd843703          	ld	a4,-40(s0)
    80003f58:	6785                	lui	a5,0x1
    80003f5a:	97ba                	add	a5,a5,a4
    80003f5c:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80003f60:	6f9c                	ld	a5,24(a5)
    80003f62:	853e                	mv	a0,a5
    80003f64:	00000097          	auipc	ra,0x0
    80003f68:	aa8080e7          	jalr	-1368(ra) # 80003a0c <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80003f6c:	fd843703          	ld	a4,-40(s0)
    80003f70:	6785                	lui	a5,0x1
    80003f72:	97ba                	add	a5,a5,a4
    80003f74:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003f78:	00c7d713          	srli	a4,a5,0xc
    80003f7c:	57fd                	li	a5,-1
    80003f7e:	17fe                	slli	a5,a5,0x3f
    80003f80:	8fd9                	or	a5,a5,a4
    80003f82:	faf43823          	sd	a5,-80(s0)
  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80003f86:	00006717          	auipc	a4,0x6
    80003f8a:	10a70713          	addi	a4,a4,266 # 8000a090 <userret>
    80003f8e:	00006797          	auipc	a5,0x6
    80003f92:	07278793          	addi	a5,a5,114 # 8000a000 <_trampoline>
    80003f96:	8f1d                	sub	a4,a4,a5
    80003f98:	040007b7          	lui	a5,0x4000
    80003f9c:	17fd                	addi	a5,a5,-1
    80003f9e:	07b2                	slli	a5,a5,0xc
    80003fa0:	97ba                	add	a5,a5,a4
    80003fa2:	faf43423          	sd	a5,-88(s0)
  
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80003fa6:	fa843703          	ld	a4,-88(s0)
    80003faa:	fb043583          	ld	a1,-80(s0)
    80003fae:	020007b7          	lui	a5,0x2000
    80003fb2:	17fd                	addi	a5,a5,-1
    80003fb4:	00d79513          	slli	a0,a5,0xd
    80003fb8:	9702                	jalr	a4
}
    80003fba:	0001                	nop
    80003fbc:	60e6                	ld	ra,88(sp)
    80003fbe:	6446                	ld	s0,80(sp)
    80003fc0:	64a6                	ld	s1,72(sp)
    80003fc2:	6125                	addi	sp,sp,96
    80003fc4:	8082                	ret

0000000080003fc6 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80003fc6:	715d                	addi	sp,sp,-80
    80003fc8:	e486                	sd	ra,72(sp)
    80003fca:	e0a2                	sd	s0,64(sp)
    80003fcc:	fc26                	sd	s1,56(sp)
    80003fce:	0880                	addi	s0,sp,80
  int which_dev = 0;
    80003fd0:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80003fd4:	00000097          	auipc	ra,0x0
    80003fd8:	a52080e7          	jalr	-1454(ra) # 80003a26 <r_sepc>
    80003fdc:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80003fe0:	00000097          	auipc	ra,0x0
    80003fe4:	9c4080e7          	jalr	-1596(ra) # 800039a4 <r_sstatus>
    80003fe8:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80003fec:	00000097          	auipc	ra,0x0
    80003ff0:	a88080e7          	jalr	-1400(ra) # 80003a74 <r_scause>
    80003ff4:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80003ff8:	fc843783          	ld	a5,-56(s0)
    80003ffc:	1007f793          	andi	a5,a5,256
    80004000:	eb89                	bnez	a5,80004012 <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    80004002:	00007517          	auipc	a0,0x7
    80004006:	30e50513          	addi	a0,a0,782 # 8000b310 <etext+0x310>
    8000400a:	ffffd097          	auipc	ra,0xffffd
    8000400e:	c48080e7          	jalr	-952(ra) # 80000c52 <panic>
  if(intr_get() != 0)
    80004012:	00000097          	auipc	ra,0x0
    80004016:	ae8080e7          	jalr	-1304(ra) # 80003afa <intr_get>
    8000401a:	87aa                	mv	a5,a0
    8000401c:	cb89                	beqz	a5,8000402e <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    8000401e:	00007517          	auipc	a0,0x7
    80004022:	31a50513          	addi	a0,a0,794 # 8000b338 <etext+0x338>
    80004026:	ffffd097          	auipc	ra,0xffffd
    8000402a:	c2c080e7          	jalr	-980(ra) # 80000c52 <panic>

  if((which_dev = devintr()) == 0){
    8000402e:	00000097          	auipc	ra,0x0
    80004032:	166080e7          	jalr	358(ra) # 80004194 <devintr>
    80004036:	87aa                	mv	a5,a0
    80004038:	fcf42e23          	sw	a5,-36(s0)
    8000403c:	fdc42783          	lw	a5,-36(s0)
    80004040:	2781                	sext.w	a5,a5
    80004042:	e7b9                	bnez	a5,80004090 <kerneltrap+0xca>
    printf("scause %p\n", scause);
    80004044:	fc043583          	ld	a1,-64(s0)
    80004048:	00007517          	auipc	a0,0x7
    8000404c:	31050513          	addi	a0,a0,784 # 8000b358 <etext+0x358>
    80004050:	ffffd097          	auipc	ra,0xffffd
    80004054:	9ac080e7          	jalr	-1620(ra) # 800009fc <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80004058:	00000097          	auipc	ra,0x0
    8000405c:	9ce080e7          	jalr	-1586(ra) # 80003a26 <r_sepc>
    80004060:	84aa                	mv	s1,a0
    80004062:	00000097          	auipc	ra,0x0
    80004066:	a2c080e7          	jalr	-1492(ra) # 80003a8e <r_stval>
    8000406a:	87aa                	mv	a5,a0
    8000406c:	863e                	mv	a2,a5
    8000406e:	85a6                	mv	a1,s1
    80004070:	00007517          	auipc	a0,0x7
    80004074:	2f850513          	addi	a0,a0,760 # 8000b368 <etext+0x368>
    80004078:	ffffd097          	auipc	ra,0xffffd
    8000407c:	984080e7          	jalr	-1660(ra) # 800009fc <printf>
    panic("kerneltrap");
    80004080:	00007517          	auipc	a0,0x7
    80004084:	30050513          	addi	a0,a0,768 # 8000b380 <etext+0x380>
    80004088:	ffffd097          	auipc	ra,0xffffd
    8000408c:	bca080e7          	jalr	-1078(ra) # 80000c52 <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING){
    80004090:	fdc42783          	lw	a5,-36(s0)
    80004094:	0007871b          	sext.w	a4,a5
    80004098:	4789                	li	a5,2
    8000409a:	06f71d63          	bne	a4,a5,80004114 <kerneltrap+0x14e>
    8000409e:	ffffe097          	auipc	ra,0xffffe
    800040a2:	75a080e7          	jalr	1882(ra) # 800027f8 <myproc>
    800040a6:	87aa                	mv	a5,a0
    800040a8:	c7b5                	beqz	a5,80004114 <kerneltrap+0x14e>
    800040aa:	ffffe097          	auipc	ra,0xffffe
    800040ae:	74e080e7          	jalr	1870(ra) # 800027f8 <myproc>
    800040b2:	87aa                	mv	a5,a0
    800040b4:	4f9c                	lw	a5,24(a5)
    800040b6:	873e                	mv	a4,a5
    800040b8:	478d                	li	a5,3
    800040ba:	04f71d63          	bne	a4,a5,80004114 <kerneltrap+0x14e>
    // for mp3
    struct proc *p = myproc();
    800040be:	ffffe097          	auipc	ra,0xffffe
    800040c2:	73a080e7          	jalr	1850(ra) # 800027f8 <myproc>
    800040c6:	faa43c23          	sd	a0,-72(s0)

    if(p->thrdstop_delay > 0){
    800040ca:	fb843783          	ld	a5,-72(s0)
    800040ce:	43bc                	lw	a5,64(a5)
    800040d0:	02f05e63          	blez	a5,8000410c <kerneltrap+0x146>
      p->thrdstop_ticks++;
    800040d4:	fb843783          	ld	a5,-72(s0)
    800040d8:	5fdc                	lw	a5,60(a5)
    800040da:	2785                	addiw	a5,a5,1
    800040dc:	0007871b          	sext.w	a4,a5
    800040e0:	fb843783          	ld	a5,-72(s0)
    800040e4:	dfd8                	sw	a4,60(a5)
      if(p->thrdstop_ticks >= p->thrdstop_delay){
    800040e6:	fb843783          	ld	a5,-72(s0)
    800040ea:	5fd8                	lw	a4,60(a5)
    800040ec:	fb843783          	ld	a5,-72(s0)
    800040f0:	43bc                	lw	a5,64(a5)
    800040f2:	00f74d63          	blt	a4,a5,8000410c <kerneltrap+0x146>
        p->jump_flag = 1;
    800040f6:	fb843703          	ld	a4,-72(s0)
    800040fa:	6785                	lui	a5,0x1
    800040fc:	97ba                	add	a5,a5,a4
    800040fe:	4705                	li	a4,1
    80004100:	28e7ac23          	sw	a4,664(a5) # 1298 <_entry-0x7fffed68>
        p->thrdstop_delay = -1;
    80004104:	fb843783          	ld	a5,-72(s0)
    80004108:	577d                	li	a4,-1
    8000410a:	c3b8                	sw	a4,64(a5)
      }
    }
    yield();
    8000410c:	fffff097          	auipc	ra,0xfffff
    80004110:	39e080e7          	jalr	926(ra) # 800034aa <yield>
  }

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80004114:	fd043503          	ld	a0,-48(s0)
    80004118:	00000097          	auipc	ra,0x0
    8000411c:	8f4080e7          	jalr	-1804(ra) # 80003a0c <w_sepc>
  w_sstatus(sstatus);
    80004120:	fc843503          	ld	a0,-56(s0)
    80004124:	00000097          	auipc	ra,0x0
    80004128:	89a080e7          	jalr	-1894(ra) # 800039be <w_sstatus>

}
    8000412c:	0001                	nop
    8000412e:	60a6                	ld	ra,72(sp)
    80004130:	6406                	ld	s0,64(sp)
    80004132:	74e2                	ld	s1,56(sp)
    80004134:	6161                	addi	sp,sp,80
    80004136:	8082                	ret

0000000080004138 <clockintr>:

void
clockintr()
{
    80004138:	1141                	addi	sp,sp,-16
    8000413a:	e406                	sd	ra,8(sp)
    8000413c:	e022                	sd	s0,0(sp)
    8000413e:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    80004140:	00060517          	auipc	a0,0x60
    80004144:	97050513          	addi	a0,a0,-1680 # 80063ab0 <tickslock>
    80004148:	ffffd097          	auipc	ra,0xffffd
    8000414c:	138080e7          	jalr	312(ra) # 80001280 <acquire>
  ticks++;
    80004150:	00008797          	auipc	a5,0x8
    80004154:	ed078793          	addi	a5,a5,-304 # 8000c020 <ticks>
    80004158:	439c                	lw	a5,0(a5)
    8000415a:	2785                	addiw	a5,a5,1
    8000415c:	0007871b          	sext.w	a4,a5
    80004160:	00008797          	auipc	a5,0x8
    80004164:	ec078793          	addi	a5,a5,-320 # 8000c020 <ticks>
    80004168:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    8000416a:	00008517          	auipc	a0,0x8
    8000416e:	eb650513          	addi	a0,a0,-330 # 8000c020 <ticks>
    80004172:	fffff097          	auipc	ra,0xfffff
    80004176:	466080e7          	jalr	1126(ra) # 800035d8 <wakeup>
  release(&tickslock);
    8000417a:	00060517          	auipc	a0,0x60
    8000417e:	93650513          	addi	a0,a0,-1738 # 80063ab0 <tickslock>
    80004182:	ffffd097          	auipc	ra,0xffffd
    80004186:	162080e7          	jalr	354(ra) # 800012e4 <release>
}
    8000418a:	0001                	nop
    8000418c:	60a2                	ld	ra,8(sp)
    8000418e:	6402                	ld	s0,0(sp)
    80004190:	0141                	addi	sp,sp,16
    80004192:	8082                	ret

0000000080004194 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80004194:	1101                	addi	sp,sp,-32
    80004196:	ec06                	sd	ra,24(sp)
    80004198:	e822                	sd	s0,16(sp)
    8000419a:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    8000419c:	00000097          	auipc	ra,0x0
    800041a0:	8d8080e7          	jalr	-1832(ra) # 80003a74 <r_scause>
    800041a4:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    800041a8:	fe843783          	ld	a5,-24(s0)
    800041ac:	0807d463          	bgez	a5,80004234 <devintr+0xa0>
     (scause & 0xff) == 9){
    800041b0:	fe843783          	ld	a5,-24(s0)
    800041b4:	0ff7f713          	andi	a4,a5,255
  if((scause & 0x8000000000000000L) &&
    800041b8:	47a5                	li	a5,9
    800041ba:	06f71d63          	bne	a4,a5,80004234 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    800041be:	00005097          	auipc	ra,0x5
    800041c2:	b44080e7          	jalr	-1212(ra) # 80008d02 <plic_claim>
    800041c6:	87aa                	mv	a5,a0
    800041c8:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    800041cc:	fe442783          	lw	a5,-28(s0)
    800041d0:	0007871b          	sext.w	a4,a5
    800041d4:	47a9                	li	a5,10
    800041d6:	00f71763          	bne	a4,a5,800041e4 <devintr+0x50>
      uartintr();
    800041da:	ffffd097          	auipc	ra,0xffffd
    800041de:	dae080e7          	jalr	-594(ra) # 80000f88 <uartintr>
    800041e2:	a825                	j	8000421a <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    800041e4:	fe442783          	lw	a5,-28(s0)
    800041e8:	0007871b          	sext.w	a4,a5
    800041ec:	4785                	li	a5,1
    800041ee:	00f71763          	bne	a4,a5,800041fc <devintr+0x68>
      virtio_disk_intr();
    800041f2:	00005097          	auipc	ra,0x5
    800041f6:	424080e7          	jalr	1060(ra) # 80009616 <virtio_disk_intr>
    800041fa:	a005                	j	8000421a <devintr+0x86>
    } else if(irq){
    800041fc:	fe442783          	lw	a5,-28(s0)
    80004200:	2781                	sext.w	a5,a5
    80004202:	cf81                	beqz	a5,8000421a <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80004204:	fe442783          	lw	a5,-28(s0)
    80004208:	85be                	mv	a1,a5
    8000420a:	00007517          	auipc	a0,0x7
    8000420e:	18650513          	addi	a0,a0,390 # 8000b390 <etext+0x390>
    80004212:	ffffc097          	auipc	ra,0xffffc
    80004216:	7ea080e7          	jalr	2026(ra) # 800009fc <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    8000421a:	fe442783          	lw	a5,-28(s0)
    8000421e:	2781                	sext.w	a5,a5
    80004220:	cb81                	beqz	a5,80004230 <devintr+0x9c>
      plic_complete(irq);
    80004222:	fe442783          	lw	a5,-28(s0)
    80004226:	853e                	mv	a0,a5
    80004228:	00005097          	auipc	ra,0x5
    8000422c:	b18080e7          	jalr	-1256(ra) # 80008d40 <plic_complete>

    return 1;
    80004230:	4785                	li	a5,1
    80004232:	a081                	j	80004272 <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    80004234:	fe843703          	ld	a4,-24(s0)
    80004238:	57fd                	li	a5,-1
    8000423a:	17fe                	slli	a5,a5,0x3f
    8000423c:	0785                	addi	a5,a5,1
    8000423e:	02f71963          	bne	a4,a5,80004270 <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    80004242:	ffffe097          	auipc	ra,0xffffe
    80004246:	558080e7          	jalr	1368(ra) # 8000279a <cpuid>
    8000424a:	87aa                	mv	a5,a0
    8000424c:	e789                	bnez	a5,80004256 <devintr+0xc2>
      clockintr();
    8000424e:	00000097          	auipc	ra,0x0
    80004252:	eea080e7          	jalr	-278(ra) # 80004138 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    80004256:	fffff097          	auipc	ra,0xfffff
    8000425a:	782080e7          	jalr	1922(ra) # 800039d8 <r_sip>
    8000425e:	87aa                	mv	a5,a0
    80004260:	9bf5                	andi	a5,a5,-3
    80004262:	853e                	mv	a0,a5
    80004264:	fffff097          	auipc	ra,0xfffff
    80004268:	78e080e7          	jalr	1934(ra) # 800039f2 <w_sip>

    return 2;
    8000426c:	4789                	li	a5,2
    8000426e:	a011                	j	80004272 <devintr+0xde>
  } else {
    return 0;
    80004270:	4781                	li	a5,0
  }
}
    80004272:	853e                	mv	a0,a5
    80004274:	60e2                	ld	ra,24(sp)
    80004276:	6442                	ld	s0,16(sp)
    80004278:	6105                	addi	sp,sp,32
    8000427a:	8082                	ret

000000008000427c <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    8000427c:	7179                	addi	sp,sp,-48
    8000427e:	f406                	sd	ra,40(sp)
    80004280:	f022                	sd	s0,32(sp)
    80004282:	1800                	addi	s0,sp,48
    80004284:	fca43c23          	sd	a0,-40(s0)
    80004288:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    8000428c:	ffffe097          	auipc	ra,0xffffe
    80004290:	56c080e7          	jalr	1388(ra) # 800027f8 <myproc>
    80004294:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80004298:	fe843703          	ld	a4,-24(s0)
    8000429c:	6785                	lui	a5,0x1
    8000429e:	97ba                	add	a5,a5,a4
    800042a0:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    800042a4:	fd843703          	ld	a4,-40(s0)
    800042a8:	00f77e63          	bgeu	a4,a5,800042c4 <fetchaddr+0x48>
    800042ac:	fd843783          	ld	a5,-40(s0)
    800042b0:	00878713          	addi	a4,a5,8
    800042b4:	fe843683          	ld	a3,-24(s0)
    800042b8:	6785                	lui	a5,0x1
    800042ba:	97b6                	add	a5,a5,a3
    800042bc:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    800042c0:	00e7f463          	bgeu	a5,a4,800042c8 <fetchaddr+0x4c>
    return -1;
    800042c4:	57fd                	li	a5,-1
    800042c6:	a035                	j	800042f2 <fetchaddr+0x76>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800042c8:	fe843703          	ld	a4,-24(s0)
    800042cc:	6785                	lui	a5,0x1
    800042ce:	97ba                	add	a5,a5,a4
    800042d0:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    800042d4:	46a1                	li	a3,8
    800042d6:	fd843603          	ld	a2,-40(s0)
    800042da:	fd043583          	ld	a1,-48(s0)
    800042de:	853e                	mv	a0,a5
    800042e0:	ffffe097          	auipc	ra,0xffffe
    800042e4:	0c2080e7          	jalr	194(ra) # 800023a2 <copyin>
    800042e8:	87aa                	mv	a5,a0
    800042ea:	c399                	beqz	a5,800042f0 <fetchaddr+0x74>
    return -1;
    800042ec:	57fd                	li	a5,-1
    800042ee:	a011                	j	800042f2 <fetchaddr+0x76>
  return 0;
    800042f0:	4781                	li	a5,0
}
    800042f2:	853e                	mv	a0,a5
    800042f4:	70a2                	ld	ra,40(sp)
    800042f6:	7402                	ld	s0,32(sp)
    800042f8:	6145                	addi	sp,sp,48
    800042fa:	8082                	ret

00000000800042fc <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    800042fc:	7139                	addi	sp,sp,-64
    800042fe:	fc06                	sd	ra,56(sp)
    80004300:	f822                	sd	s0,48(sp)
    80004302:	0080                	addi	s0,sp,64
    80004304:	fca43c23          	sd	a0,-40(s0)
    80004308:	fcb43823          	sd	a1,-48(s0)
    8000430c:	87b2                	mv	a5,a2
    8000430e:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80004312:	ffffe097          	auipc	ra,0xffffe
    80004316:	4e6080e7          	jalr	1254(ra) # 800027f8 <myproc>
    8000431a:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    8000431e:	fe843703          	ld	a4,-24(s0)
    80004322:	6785                	lui	a5,0x1
    80004324:	97ba                	add	a5,a5,a4
    80004326:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000432a:	fcc42703          	lw	a4,-52(s0)
    8000432e:	86ba                	mv	a3,a4
    80004330:	fd843603          	ld	a2,-40(s0)
    80004334:	fd043583          	ld	a1,-48(s0)
    80004338:	853e                	mv	a0,a5
    8000433a:	ffffe097          	auipc	ra,0xffffe
    8000433e:	136080e7          	jalr	310(ra) # 80002470 <copyinstr>
    80004342:	87aa                	mv	a5,a0
    80004344:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    80004348:	fe442783          	lw	a5,-28(s0)
    8000434c:	2781                	sext.w	a5,a5
    8000434e:	0007d563          	bgez	a5,80004358 <fetchstr+0x5c>
    return err;
    80004352:	fe442783          	lw	a5,-28(s0)
    80004356:	a801                	j	80004366 <fetchstr+0x6a>
  return strlen(buf);
    80004358:	fd043503          	ld	a0,-48(s0)
    8000435c:	ffffd097          	auipc	ra,0xffffd
    80004360:	468080e7          	jalr	1128(ra) # 800017c4 <strlen>
    80004364:	87aa                	mv	a5,a0
}
    80004366:	853e                	mv	a0,a5
    80004368:	70e2                	ld	ra,56(sp)
    8000436a:	7442                	ld	s0,48(sp)
    8000436c:	6121                	addi	sp,sp,64
    8000436e:	8082                	ret

0000000080004370 <argraw>:

static uint64
argraw(int n)
{
    80004370:	7179                	addi	sp,sp,-48
    80004372:	f406                	sd	ra,40(sp)
    80004374:	f022                	sd	s0,32(sp)
    80004376:	1800                	addi	s0,sp,48
    80004378:	87aa                	mv	a5,a0
    8000437a:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    8000437e:	ffffe097          	auipc	ra,0xffffe
    80004382:	47a080e7          	jalr	1146(ra) # 800027f8 <myproc>
    80004386:	fea43423          	sd	a0,-24(s0)
    8000438a:	fdc42783          	lw	a5,-36(s0)
    8000438e:	0007871b          	sext.w	a4,a5
    80004392:	4795                	li	a5,5
    80004394:	08e7e463          	bltu	a5,a4,8000441c <argraw+0xac>
    80004398:	fdc46783          	lwu	a5,-36(s0)
    8000439c:	00279713          	slli	a4,a5,0x2
    800043a0:	00007797          	auipc	a5,0x7
    800043a4:	01878793          	addi	a5,a5,24 # 8000b3b8 <etext+0x3b8>
    800043a8:	97ba                	add	a5,a5,a4
    800043aa:	439c                	lw	a5,0(a5)
    800043ac:	0007871b          	sext.w	a4,a5
    800043b0:	00007797          	auipc	a5,0x7
    800043b4:	00878793          	addi	a5,a5,8 # 8000b3b8 <etext+0x3b8>
    800043b8:	97ba                	add	a5,a5,a4
    800043ba:	8782                	jr	a5
  switch (n) {
  case 0:
    return p->trapframe->a0;
    800043bc:	fe843703          	ld	a4,-24(s0)
    800043c0:	6785                	lui	a5,0x1
    800043c2:	97ba                	add	a5,a5,a4
    800043c4:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    800043c8:	7bbc                	ld	a5,112(a5)
    800043ca:	a08d                	j	8000442c <argraw+0xbc>
  case 1:
    return p->trapframe->a1;
    800043cc:	fe843703          	ld	a4,-24(s0)
    800043d0:	6785                	lui	a5,0x1
    800043d2:	97ba                	add	a5,a5,a4
    800043d4:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    800043d8:	7fbc                	ld	a5,120(a5)
    800043da:	a889                	j	8000442c <argraw+0xbc>
  case 2:
    return p->trapframe->a2;
    800043dc:	fe843703          	ld	a4,-24(s0)
    800043e0:	6785                	lui	a5,0x1
    800043e2:	97ba                	add	a5,a5,a4
    800043e4:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    800043e8:	63dc                	ld	a5,128(a5)
    800043ea:	a089                	j	8000442c <argraw+0xbc>
  case 3:
    return p->trapframe->a3;
    800043ec:	fe843703          	ld	a4,-24(s0)
    800043f0:	6785                	lui	a5,0x1
    800043f2:	97ba                	add	a5,a5,a4
    800043f4:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    800043f8:	67dc                	ld	a5,136(a5)
    800043fa:	a80d                	j	8000442c <argraw+0xbc>
  case 4:
    return p->trapframe->a4;
    800043fc:	fe843703          	ld	a4,-24(s0)
    80004400:	6785                	lui	a5,0x1
    80004402:	97ba                	add	a5,a5,a4
    80004404:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80004408:	6bdc                	ld	a5,144(a5)
    8000440a:	a00d                	j	8000442c <argraw+0xbc>
  case 5:
    return p->trapframe->a5;
    8000440c:	fe843703          	ld	a4,-24(s0)
    80004410:	6785                	lui	a5,0x1
    80004412:	97ba                	add	a5,a5,a4
    80004414:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80004418:	6fdc                	ld	a5,152(a5)
    8000441a:	a809                	j	8000442c <argraw+0xbc>
  }
  panic("argraw");
    8000441c:	00007517          	auipc	a0,0x7
    80004420:	f9450513          	addi	a0,a0,-108 # 8000b3b0 <etext+0x3b0>
    80004424:	ffffd097          	auipc	ra,0xffffd
    80004428:	82e080e7          	jalr	-2002(ra) # 80000c52 <panic>
  return -1;
}
    8000442c:	853e                	mv	a0,a5
    8000442e:	70a2                	ld	ra,40(sp)
    80004430:	7402                	ld	s0,32(sp)
    80004432:	6145                	addi	sp,sp,48
    80004434:	8082                	ret

0000000080004436 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80004436:	1101                	addi	sp,sp,-32
    80004438:	ec06                	sd	ra,24(sp)
    8000443a:	e822                	sd	s0,16(sp)
    8000443c:	1000                	addi	s0,sp,32
    8000443e:	87aa                	mv	a5,a0
    80004440:	feb43023          	sd	a1,-32(s0)
    80004444:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004448:	fec42783          	lw	a5,-20(s0)
    8000444c:	853e                	mv	a0,a5
    8000444e:	00000097          	auipc	ra,0x0
    80004452:	f22080e7          	jalr	-222(ra) # 80004370 <argraw>
    80004456:	87aa                	mv	a5,a0
    80004458:	0007871b          	sext.w	a4,a5
    8000445c:	fe043783          	ld	a5,-32(s0)
    80004460:	c398                	sw	a4,0(a5)
  return 0;
    80004462:	4781                	li	a5,0
}
    80004464:	853e                	mv	a0,a5
    80004466:	60e2                	ld	ra,24(sp)
    80004468:	6442                	ld	s0,16(sp)
    8000446a:	6105                	addi	sp,sp,32
    8000446c:	8082                	ret

000000008000446e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    8000446e:	1101                	addi	sp,sp,-32
    80004470:	ec06                	sd	ra,24(sp)
    80004472:	e822                	sd	s0,16(sp)
    80004474:	1000                	addi	s0,sp,32
    80004476:	87aa                	mv	a5,a0
    80004478:	feb43023          	sd	a1,-32(s0)
    8000447c:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004480:	fec42783          	lw	a5,-20(s0)
    80004484:	853e                	mv	a0,a5
    80004486:	00000097          	auipc	ra,0x0
    8000448a:	eea080e7          	jalr	-278(ra) # 80004370 <argraw>
    8000448e:	872a                	mv	a4,a0
    80004490:	fe043783          	ld	a5,-32(s0)
    80004494:	e398                	sd	a4,0(a5)
  return 0;
    80004496:	4781                	li	a5,0
}
    80004498:	853e                	mv	a0,a5
    8000449a:	60e2                	ld	ra,24(sp)
    8000449c:	6442                	ld	s0,16(sp)
    8000449e:	6105                	addi	sp,sp,32
    800044a0:	8082                	ret

00000000800044a2 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    800044a2:	7179                	addi	sp,sp,-48
    800044a4:	f406                	sd	ra,40(sp)
    800044a6:	f022                	sd	s0,32(sp)
    800044a8:	1800                	addi	s0,sp,48
    800044aa:	87aa                	mv	a5,a0
    800044ac:	fcb43823          	sd	a1,-48(s0)
    800044b0:	8732                	mv	a4,a2
    800044b2:	fcf42e23          	sw	a5,-36(s0)
    800044b6:	87ba                	mv	a5,a4
    800044b8:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    800044bc:	fe840713          	addi	a4,s0,-24
    800044c0:	fdc42783          	lw	a5,-36(s0)
    800044c4:	85ba                	mv	a1,a4
    800044c6:	853e                	mv	a0,a5
    800044c8:	00000097          	auipc	ra,0x0
    800044cc:	fa6080e7          	jalr	-90(ra) # 8000446e <argaddr>
    800044d0:	87aa                	mv	a5,a0
    800044d2:	0007d463          	bgez	a5,800044da <argstr+0x38>
    return -1;
    800044d6:	57fd                	li	a5,-1
    800044d8:	a831                	j	800044f4 <argstr+0x52>
  return fetchstr(addr, buf, max);
    800044da:	fe843783          	ld	a5,-24(s0)
    800044de:	fd842703          	lw	a4,-40(s0)
    800044e2:	863a                	mv	a2,a4
    800044e4:	fd043583          	ld	a1,-48(s0)
    800044e8:	853e                	mv	a0,a5
    800044ea:	00000097          	auipc	ra,0x0
    800044ee:	e12080e7          	jalr	-494(ra) # 800042fc <fetchstr>
    800044f2:	87aa                	mv	a5,a0
}
    800044f4:	853e                	mv	a0,a5
    800044f6:	70a2                	ld	ra,40(sp)
    800044f8:	7402                	ld	s0,32(sp)
    800044fa:	6145                	addi	sp,sp,48
    800044fc:	8082                	ret

00000000800044fe <syscall>:
[SYS_cancelthrdstop]   sys_cancelthrdstop,
};

void
syscall(void)
{
    800044fe:	7179                	addi	sp,sp,-48
    80004500:	f406                	sd	ra,40(sp)
    80004502:	f022                	sd	s0,32(sp)
    80004504:	ec26                	sd	s1,24(sp)
    80004506:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004508:	ffffe097          	auipc	ra,0xffffe
    8000450c:	2f0080e7          	jalr	752(ra) # 800027f8 <myproc>
    80004510:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004514:	fd843703          	ld	a4,-40(s0)
    80004518:	6785                	lui	a5,0x1
    8000451a:	97ba                	add	a5,a5,a4
    8000451c:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80004520:	77dc                	ld	a5,168(a5)
    80004522:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80004526:	fd442783          	lw	a5,-44(s0)
    8000452a:	2781                	sext.w	a5,a5
    8000452c:	04f05563          	blez	a5,80004576 <syscall+0x78>
    80004530:	fd442783          	lw	a5,-44(s0)
    80004534:	873e                	mv	a4,a5
    80004536:	47e1                	li	a5,24
    80004538:	02e7ef63          	bltu	a5,a4,80004576 <syscall+0x78>
    8000453c:	00007717          	auipc	a4,0x7
    80004540:	29c70713          	addi	a4,a4,668 # 8000b7d8 <syscalls>
    80004544:	fd442783          	lw	a5,-44(s0)
    80004548:	078e                	slli	a5,a5,0x3
    8000454a:	97ba                	add	a5,a5,a4
    8000454c:	639c                	ld	a5,0(a5)
    8000454e:	c785                	beqz	a5,80004576 <syscall+0x78>
    p->trapframe->a0 = syscalls[num]();
    80004550:	00007717          	auipc	a4,0x7
    80004554:	28870713          	addi	a4,a4,648 # 8000b7d8 <syscalls>
    80004558:	fd442783          	lw	a5,-44(s0)
    8000455c:	078e                	slli	a5,a5,0x3
    8000455e:	97ba                	add	a5,a5,a4
    80004560:	6394                	ld	a3,0(a5)
    80004562:	fd843703          	ld	a4,-40(s0)
    80004566:	6785                	lui	a5,0x1
    80004568:	97ba                	add	a5,a5,a4
    8000456a:	2c07b483          	ld	s1,704(a5) # 12c0 <_entry-0x7fffed40>
    8000456e:	9682                	jalr	a3
    80004570:	87aa                	mv	a5,a0
    80004572:	f8bc                	sd	a5,112(s1)
    80004574:	a83d                	j	800045b2 <syscall+0xb4>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80004576:	fd843783          	ld	a5,-40(s0)
    8000457a:	5f8c                	lw	a1,56(a5)
            p->pid, p->name, num);
    8000457c:	fd843703          	ld	a4,-40(s0)
    80004580:	6785                	lui	a5,0x1
    80004582:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    80004586:	97ba                	add	a5,a5,a4
    printf("%d %s: unknown sys call %d\n",
    80004588:	fd442703          	lw	a4,-44(s0)
    8000458c:	86ba                	mv	a3,a4
    8000458e:	863e                	mv	a2,a5
    80004590:	00007517          	auipc	a0,0x7
    80004594:	e4050513          	addi	a0,a0,-448 # 8000b3d0 <etext+0x3d0>
    80004598:	ffffc097          	auipc	ra,0xffffc
    8000459c:	464080e7          	jalr	1124(ra) # 800009fc <printf>
    p->trapframe->a0 = -1;
    800045a0:	fd843703          	ld	a4,-40(s0)
    800045a4:	6785                	lui	a5,0x1
    800045a6:	97ba                	add	a5,a5,a4
    800045a8:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    800045ac:	577d                	li	a4,-1
    800045ae:	fbb8                	sd	a4,112(a5)
  }
}
    800045b0:	0001                	nop
    800045b2:	0001                	nop
    800045b4:	70a2                	ld	ra,40(sp)
    800045b6:	7402                	ld	s0,32(sp)
    800045b8:	64e2                	ld	s1,24(sp)
    800045ba:	6145                	addi	sp,sp,48
    800045bc:	8082                	ret

00000000800045be <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800045be:	1101                	addi	sp,sp,-32
    800045c0:	ec06                	sd	ra,24(sp)
    800045c2:	e822                	sd	s0,16(sp)
    800045c4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800045c6:	fec40793          	addi	a5,s0,-20
    800045ca:	85be                	mv	a1,a5
    800045cc:	4501                	li	a0,0
    800045ce:	00000097          	auipc	ra,0x0
    800045d2:	e68080e7          	jalr	-408(ra) # 80004436 <argint>
    800045d6:	87aa                	mv	a5,a0
    800045d8:	0007d463          	bgez	a5,800045e0 <sys_exit+0x22>
    return -1;
    800045dc:	57fd                	li	a5,-1
    800045de:	a809                	j	800045f0 <sys_exit+0x32>
  exit(n);
    800045e0:	fec42783          	lw	a5,-20(s0)
    800045e4:	853e                	mv	a0,a5
    800045e6:	fffff097          	auipc	ra,0xfffff
    800045ea:	a20080e7          	jalr	-1504(ra) # 80003006 <exit>
  return 0;  // not reached
    800045ee:	4781                	li	a5,0
}
    800045f0:	853e                	mv	a0,a5
    800045f2:	60e2                	ld	ra,24(sp)
    800045f4:	6442                	ld	s0,16(sp)
    800045f6:	6105                	addi	sp,sp,32
    800045f8:	8082                	ret

00000000800045fa <sys_getpid>:

uint64
sys_getpid(void)
{
    800045fa:	1141                	addi	sp,sp,-16
    800045fc:	e406                	sd	ra,8(sp)
    800045fe:	e022                	sd	s0,0(sp)
    80004600:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004602:	ffffe097          	auipc	ra,0xffffe
    80004606:	1f6080e7          	jalr	502(ra) # 800027f8 <myproc>
    8000460a:	87aa                	mv	a5,a0
    8000460c:	5f9c                	lw	a5,56(a5)
}
    8000460e:	853e                	mv	a0,a5
    80004610:	60a2                	ld	ra,8(sp)
    80004612:	6402                	ld	s0,0(sp)
    80004614:	0141                	addi	sp,sp,16
    80004616:	8082                	ret

0000000080004618 <sys_fork>:

uint64
sys_fork(void)
{
    80004618:	1141                	addi	sp,sp,-16
    8000461a:	e406                	sd	ra,8(sp)
    8000461c:	e022                	sd	s0,0(sp)
    8000461e:	0800                	addi	s0,sp,16
  return fork();
    80004620:	ffffe097          	auipc	ra,0xffffe
    80004624:	7ae080e7          	jalr	1966(ra) # 80002dce <fork>
    80004628:	87aa                	mv	a5,a0
}
    8000462a:	853e                	mv	a0,a5
    8000462c:	60a2                	ld	ra,8(sp)
    8000462e:	6402                	ld	s0,0(sp)
    80004630:	0141                	addi	sp,sp,16
    80004632:	8082                	ret

0000000080004634 <sys_wait>:

uint64
sys_wait(void)
{
    80004634:	1101                	addi	sp,sp,-32
    80004636:	ec06                	sd	ra,24(sp)
    80004638:	e822                	sd	s0,16(sp)
    8000463a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8000463c:	fe840793          	addi	a5,s0,-24
    80004640:	85be                	mv	a1,a5
    80004642:	4501                	li	a0,0
    80004644:	00000097          	auipc	ra,0x0
    80004648:	e2a080e7          	jalr	-470(ra) # 8000446e <argaddr>
    8000464c:	87aa                	mv	a5,a0
    8000464e:	0007d463          	bgez	a5,80004656 <sys_wait+0x22>
    return -1;
    80004652:	57fd                	li	a5,-1
    80004654:	a809                	j	80004666 <sys_wait+0x32>
  return wait(p);
    80004656:	fe843783          	ld	a5,-24(s0)
    8000465a:	853e                	mv	a0,a5
    8000465c:	fffff097          	auipc	ra,0xfffff
    80004660:	b4e080e7          	jalr	-1202(ra) # 800031aa <wait>
    80004664:	87aa                	mv	a5,a0
}
    80004666:	853e                	mv	a0,a5
    80004668:	60e2                	ld	ra,24(sp)
    8000466a:	6442                	ld	s0,16(sp)
    8000466c:	6105                	addi	sp,sp,32
    8000466e:	8082                	ret

0000000080004670 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004670:	1101                	addi	sp,sp,-32
    80004672:	ec06                	sd	ra,24(sp)
    80004674:	e822                	sd	s0,16(sp)
    80004676:	1000                	addi	s0,sp,32
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80004678:	fe840793          	addi	a5,s0,-24
    8000467c:	85be                	mv	a1,a5
    8000467e:	4501                	li	a0,0
    80004680:	00000097          	auipc	ra,0x0
    80004684:	db6080e7          	jalr	-586(ra) # 80004436 <argint>
    80004688:	87aa                	mv	a5,a0
    8000468a:	0007d463          	bgez	a5,80004692 <sys_sbrk+0x22>
    return -1;
    8000468e:	57fd                	li	a5,-1
    80004690:	a815                	j	800046c4 <sys_sbrk+0x54>
  addr = myproc()->sz;
    80004692:	ffffe097          	auipc	ra,0xffffe
    80004696:	166080e7          	jalr	358(ra) # 800027f8 <myproc>
    8000469a:	872a                	mv	a4,a0
    8000469c:	6785                	lui	a5,0x1
    8000469e:	97ba                	add	a5,a5,a4
    800046a0:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    800046a4:	fef42623          	sw	a5,-20(s0)
  if(growproc(n) < 0)
    800046a8:	fe842783          	lw	a5,-24(s0)
    800046ac:	853e                	mv	a0,a5
    800046ae:	ffffe097          	auipc	ra,0xffffe
    800046b2:	656080e7          	jalr	1622(ra) # 80002d04 <growproc>
    800046b6:	87aa                	mv	a5,a0
    800046b8:	0007d463          	bgez	a5,800046c0 <sys_sbrk+0x50>
    return -1;
    800046bc:	57fd                	li	a5,-1
    800046be:	a019                	j	800046c4 <sys_sbrk+0x54>
  return addr;
    800046c0:	fec42783          	lw	a5,-20(s0)
}
    800046c4:	853e                	mv	a0,a5
    800046c6:	60e2                	ld	ra,24(sp)
    800046c8:	6442                	ld	s0,16(sp)
    800046ca:	6105                	addi	sp,sp,32
    800046cc:	8082                	ret

00000000800046ce <sys_sleep>:

uint64
sys_sleep(void)
{
    800046ce:	1101                	addi	sp,sp,-32
    800046d0:	ec06                	sd	ra,24(sp)
    800046d2:	e822                	sd	s0,16(sp)
    800046d4:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800046d6:	fe840793          	addi	a5,s0,-24
    800046da:	85be                	mv	a1,a5
    800046dc:	4501                	li	a0,0
    800046de:	00000097          	auipc	ra,0x0
    800046e2:	d58080e7          	jalr	-680(ra) # 80004436 <argint>
    800046e6:	87aa                	mv	a5,a0
    800046e8:	0007d463          	bgez	a5,800046f0 <sys_sleep+0x22>
    return -1;
    800046ec:	57fd                	li	a5,-1
    800046ee:	a079                	j	8000477c <sys_sleep+0xae>
  acquire(&tickslock);
    800046f0:	0005f517          	auipc	a0,0x5f
    800046f4:	3c050513          	addi	a0,a0,960 # 80063ab0 <tickslock>
    800046f8:	ffffd097          	auipc	ra,0xffffd
    800046fc:	b88080e7          	jalr	-1144(ra) # 80001280 <acquire>
  ticks0 = ticks;
    80004700:	00008797          	auipc	a5,0x8
    80004704:	92078793          	addi	a5,a5,-1760 # 8000c020 <ticks>
    80004708:	439c                	lw	a5,0(a5)
    8000470a:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    8000470e:	a835                	j	8000474a <sys_sleep+0x7c>
    if(myproc()->killed){
    80004710:	ffffe097          	auipc	ra,0xffffe
    80004714:	0e8080e7          	jalr	232(ra) # 800027f8 <myproc>
    80004718:	87aa                	mv	a5,a0
    8000471a:	5b9c                	lw	a5,48(a5)
    8000471c:	cb99                	beqz	a5,80004732 <sys_sleep+0x64>
      release(&tickslock);
    8000471e:	0005f517          	auipc	a0,0x5f
    80004722:	39250513          	addi	a0,a0,914 # 80063ab0 <tickslock>
    80004726:	ffffd097          	auipc	ra,0xffffd
    8000472a:	bbe080e7          	jalr	-1090(ra) # 800012e4 <release>
      return -1;
    8000472e:	57fd                	li	a5,-1
    80004730:	a0b1                	j	8000477c <sys_sleep+0xae>
    }
    sleep(&ticks, &tickslock);
    80004732:	0005f597          	auipc	a1,0x5f
    80004736:	37e58593          	addi	a1,a1,894 # 80063ab0 <tickslock>
    8000473a:	00008517          	auipc	a0,0x8
    8000473e:	8e650513          	addi	a0,a0,-1818 # 8000c020 <ticks>
    80004742:	fffff097          	auipc	ra,0xfffff
    80004746:	e02080e7          	jalr	-510(ra) # 80003544 <sleep>
  while(ticks - ticks0 < n){
    8000474a:	00008797          	auipc	a5,0x8
    8000474e:	8d678793          	addi	a5,a5,-1834 # 8000c020 <ticks>
    80004752:	4398                	lw	a4,0(a5)
    80004754:	fec42783          	lw	a5,-20(s0)
    80004758:	40f707bb          	subw	a5,a4,a5
    8000475c:	0007871b          	sext.w	a4,a5
    80004760:	fe842783          	lw	a5,-24(s0)
    80004764:	2781                	sext.w	a5,a5
    80004766:	faf765e3          	bltu	a4,a5,80004710 <sys_sleep+0x42>
  }
  release(&tickslock);
    8000476a:	0005f517          	auipc	a0,0x5f
    8000476e:	34650513          	addi	a0,a0,838 # 80063ab0 <tickslock>
    80004772:	ffffd097          	auipc	ra,0xffffd
    80004776:	b72080e7          	jalr	-1166(ra) # 800012e4 <release>
  return 0;
    8000477a:	4781                	li	a5,0
}
    8000477c:	853e                	mv	a0,a5
    8000477e:	60e2                	ld	ra,24(sp)
    80004780:	6442                	ld	s0,16(sp)
    80004782:	6105                	addi	sp,sp,32
    80004784:	8082                	ret

0000000080004786 <sys_kill>:

uint64
sys_kill(void)
{
    80004786:	1101                	addi	sp,sp,-32
    80004788:	ec06                	sd	ra,24(sp)
    8000478a:	e822                	sd	s0,16(sp)
    8000478c:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8000478e:	fec40793          	addi	a5,s0,-20
    80004792:	85be                	mv	a1,a5
    80004794:	4501                	li	a0,0
    80004796:	00000097          	auipc	ra,0x0
    8000479a:	ca0080e7          	jalr	-864(ra) # 80004436 <argint>
    8000479e:	87aa                	mv	a5,a0
    800047a0:	0007d463          	bgez	a5,800047a8 <sys_kill+0x22>
    return -1;
    800047a4:	57fd                	li	a5,-1
    800047a6:	a809                	j	800047b8 <sys_kill+0x32>
  return kill(pid);
    800047a8:	fec42783          	lw	a5,-20(s0)
    800047ac:	853e                	mv	a0,a5
    800047ae:	fffff097          	auipc	ra,0xfffff
    800047b2:	f0c080e7          	jalr	-244(ra) # 800036ba <kill>
    800047b6:	87aa                	mv	a5,a0
}
    800047b8:	853e                	mv	a0,a5
    800047ba:	60e2                	ld	ra,24(sp)
    800047bc:	6442                	ld	s0,16(sp)
    800047be:	6105                	addi	sp,sp,32
    800047c0:	8082                	ret

00000000800047c2 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800047c2:	1101                	addi	sp,sp,-32
    800047c4:	ec06                	sd	ra,24(sp)
    800047c6:	e822                	sd	s0,16(sp)
    800047c8:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800047ca:	0005f517          	auipc	a0,0x5f
    800047ce:	2e650513          	addi	a0,a0,742 # 80063ab0 <tickslock>
    800047d2:	ffffd097          	auipc	ra,0xffffd
    800047d6:	aae080e7          	jalr	-1362(ra) # 80001280 <acquire>
  xticks = ticks;
    800047da:	00008797          	auipc	a5,0x8
    800047de:	84678793          	addi	a5,a5,-1978 # 8000c020 <ticks>
    800047e2:	439c                	lw	a5,0(a5)
    800047e4:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    800047e8:	0005f517          	auipc	a0,0x5f
    800047ec:	2c850513          	addi	a0,a0,712 # 80063ab0 <tickslock>
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	af4080e7          	jalr	-1292(ra) # 800012e4 <release>
  return xticks;
    800047f8:	fec46783          	lwu	a5,-20(s0)
}
    800047fc:	853e                	mv	a0,a5
    800047fe:	60e2                	ld	ra,24(sp)
    80004800:	6442                	ld	s0,16(sp)
    80004802:	6105                	addi	sp,sp,32
    80004804:	8082                	ret

0000000080004806 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004806:	1101                	addi	sp,sp,-32
    80004808:	ec06                	sd	ra,24(sp)
    8000480a:	e822                	sd	s0,16(sp)
    8000480c:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000480e:	00007597          	auipc	a1,0x7
    80004812:	be258593          	addi	a1,a1,-1054 # 8000b3f0 <etext+0x3f0>
    80004816:	0005f517          	auipc	a0,0x5f
    8000481a:	2b250513          	addi	a0,a0,690 # 80063ac8 <bcache>
    8000481e:	ffffd097          	auipc	ra,0xffffd
    80004822:	a32080e7          	jalr	-1486(ra) # 80001250 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004826:	0005f717          	auipc	a4,0x5f
    8000482a:	2a270713          	addi	a4,a4,674 # 80063ac8 <bcache>
    8000482e:	67a1                	lui	a5,0x8
    80004830:	97ba                	add	a5,a5,a4
    80004832:	00067717          	auipc	a4,0x67
    80004836:	4fe70713          	addi	a4,a4,1278 # 8006bd30 <bcache+0x8268>
    8000483a:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    8000483e:	0005f717          	auipc	a4,0x5f
    80004842:	28a70713          	addi	a4,a4,650 # 80063ac8 <bcache>
    80004846:	67a1                	lui	a5,0x8
    80004848:	97ba                	add	a5,a5,a4
    8000484a:	00067717          	auipc	a4,0x67
    8000484e:	4e670713          	addi	a4,a4,1254 # 8006bd30 <bcache+0x8268>
    80004852:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004856:	0005f797          	auipc	a5,0x5f
    8000485a:	28a78793          	addi	a5,a5,650 # 80063ae0 <bcache+0x18>
    8000485e:	fef43423          	sd	a5,-24(s0)
    80004862:	a895                	j	800048d6 <binit+0xd0>
    b->next = bcache.head.next;
    80004864:	0005f717          	auipc	a4,0x5f
    80004868:	26470713          	addi	a4,a4,612 # 80063ac8 <bcache>
    8000486c:	67a1                	lui	a5,0x8
    8000486e:	97ba                	add	a5,a5,a4
    80004870:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004874:	fe843783          	ld	a5,-24(s0)
    80004878:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    8000487a:	fe843783          	ld	a5,-24(s0)
    8000487e:	00067717          	auipc	a4,0x67
    80004882:	4b270713          	addi	a4,a4,1202 # 8006bd30 <bcache+0x8268>
    80004886:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    80004888:	fe843783          	ld	a5,-24(s0)
    8000488c:	07c1                	addi	a5,a5,16
    8000488e:	00007597          	auipc	a1,0x7
    80004892:	b6a58593          	addi	a1,a1,-1174 # 8000b3f8 <etext+0x3f8>
    80004896:	853e                	mv	a0,a5
    80004898:	00002097          	auipc	ra,0x2
    8000489c:	00a080e7          	jalr	10(ra) # 800068a2 <initsleeplock>
    bcache.head.next->prev = b;
    800048a0:	0005f717          	auipc	a4,0x5f
    800048a4:	22870713          	addi	a4,a4,552 # 80063ac8 <bcache>
    800048a8:	67a1                	lui	a5,0x8
    800048aa:	97ba                	add	a5,a5,a4
    800048ac:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800048b0:	fe843703          	ld	a4,-24(s0)
    800048b4:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800048b6:	0005f717          	auipc	a4,0x5f
    800048ba:	21270713          	addi	a4,a4,530 # 80063ac8 <bcache>
    800048be:	67a1                	lui	a5,0x8
    800048c0:	97ba                	add	a5,a5,a4
    800048c2:	fe843703          	ld	a4,-24(s0)
    800048c6:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800048ca:	fe843783          	ld	a5,-24(s0)
    800048ce:	45878793          	addi	a5,a5,1112
    800048d2:	fef43423          	sd	a5,-24(s0)
    800048d6:	00067797          	auipc	a5,0x67
    800048da:	45a78793          	addi	a5,a5,1114 # 8006bd30 <bcache+0x8268>
    800048de:	fe843703          	ld	a4,-24(s0)
    800048e2:	f8f761e3          	bltu	a4,a5,80004864 <binit+0x5e>
  }
}
    800048e6:	0001                	nop
    800048e8:	0001                	nop
    800048ea:	60e2                	ld	ra,24(sp)
    800048ec:	6442                	ld	s0,16(sp)
    800048ee:	6105                	addi	sp,sp,32
    800048f0:	8082                	ret

00000000800048f2 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800048f2:	7179                	addi	sp,sp,-48
    800048f4:	f406                	sd	ra,40(sp)
    800048f6:	f022                	sd	s0,32(sp)
    800048f8:	1800                	addi	s0,sp,48
    800048fa:	87aa                	mv	a5,a0
    800048fc:	872e                	mv	a4,a1
    800048fe:	fcf42e23          	sw	a5,-36(s0)
    80004902:	87ba                	mv	a5,a4
    80004904:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80004908:	0005f517          	auipc	a0,0x5f
    8000490c:	1c050513          	addi	a0,a0,448 # 80063ac8 <bcache>
    80004910:	ffffd097          	auipc	ra,0xffffd
    80004914:	970080e7          	jalr	-1680(ra) # 80001280 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004918:	0005f717          	auipc	a4,0x5f
    8000491c:	1b070713          	addi	a4,a4,432 # 80063ac8 <bcache>
    80004920:	67a1                	lui	a5,0x8
    80004922:	97ba                	add	a5,a5,a4
    80004924:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004928:	fef43423          	sd	a5,-24(s0)
    8000492c:	a095                	j	80004990 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    8000492e:	fe843783          	ld	a5,-24(s0)
    80004932:	4798                	lw	a4,8(a5)
    80004934:	fdc42783          	lw	a5,-36(s0)
    80004938:	2781                	sext.w	a5,a5
    8000493a:	04e79663          	bne	a5,a4,80004986 <bget+0x94>
    8000493e:	fe843783          	ld	a5,-24(s0)
    80004942:	47d8                	lw	a4,12(a5)
    80004944:	fd842783          	lw	a5,-40(s0)
    80004948:	2781                	sext.w	a5,a5
    8000494a:	02e79e63          	bne	a5,a4,80004986 <bget+0x94>
      b->refcnt++;
    8000494e:	fe843783          	ld	a5,-24(s0)
    80004952:	43bc                	lw	a5,64(a5)
    80004954:	2785                	addiw	a5,a5,1
    80004956:	0007871b          	sext.w	a4,a5
    8000495a:	fe843783          	ld	a5,-24(s0)
    8000495e:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004960:	0005f517          	auipc	a0,0x5f
    80004964:	16850513          	addi	a0,a0,360 # 80063ac8 <bcache>
    80004968:	ffffd097          	auipc	ra,0xffffd
    8000496c:	97c080e7          	jalr	-1668(ra) # 800012e4 <release>
      acquiresleep(&b->lock);
    80004970:	fe843783          	ld	a5,-24(s0)
    80004974:	07c1                	addi	a5,a5,16
    80004976:	853e                	mv	a0,a5
    80004978:	00002097          	auipc	ra,0x2
    8000497c:	f76080e7          	jalr	-138(ra) # 800068ee <acquiresleep>
      return b;
    80004980:	fe843783          	ld	a5,-24(s0)
    80004984:	a07d                	j	80004a32 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004986:	fe843783          	ld	a5,-24(s0)
    8000498a:	6bbc                	ld	a5,80(a5)
    8000498c:	fef43423          	sd	a5,-24(s0)
    80004990:	fe843703          	ld	a4,-24(s0)
    80004994:	00067797          	auipc	a5,0x67
    80004998:	39c78793          	addi	a5,a5,924 # 8006bd30 <bcache+0x8268>
    8000499c:	f8f719e3          	bne	a4,a5,8000492e <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800049a0:	0005f717          	auipc	a4,0x5f
    800049a4:	12870713          	addi	a4,a4,296 # 80063ac8 <bcache>
    800049a8:	67a1                	lui	a5,0x8
    800049aa:	97ba                	add	a5,a5,a4
    800049ac:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800049b0:	fef43423          	sd	a5,-24(s0)
    800049b4:	a8b9                	j	80004a12 <bget+0x120>
    if(b->refcnt == 0) {
    800049b6:	fe843783          	ld	a5,-24(s0)
    800049ba:	43bc                	lw	a5,64(a5)
    800049bc:	e7b1                	bnez	a5,80004a08 <bget+0x116>
      b->dev = dev;
    800049be:	fe843783          	ld	a5,-24(s0)
    800049c2:	fdc42703          	lw	a4,-36(s0)
    800049c6:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800049c8:	fe843783          	ld	a5,-24(s0)
    800049cc:	fd842703          	lw	a4,-40(s0)
    800049d0:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    800049d2:	fe843783          	ld	a5,-24(s0)
    800049d6:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    800049da:	fe843783          	ld	a5,-24(s0)
    800049de:	4705                	li	a4,1
    800049e0:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800049e2:	0005f517          	auipc	a0,0x5f
    800049e6:	0e650513          	addi	a0,a0,230 # 80063ac8 <bcache>
    800049ea:	ffffd097          	auipc	ra,0xffffd
    800049ee:	8fa080e7          	jalr	-1798(ra) # 800012e4 <release>
      acquiresleep(&b->lock);
    800049f2:	fe843783          	ld	a5,-24(s0)
    800049f6:	07c1                	addi	a5,a5,16
    800049f8:	853e                	mv	a0,a5
    800049fa:	00002097          	auipc	ra,0x2
    800049fe:	ef4080e7          	jalr	-268(ra) # 800068ee <acquiresleep>
      return b;
    80004a02:	fe843783          	ld	a5,-24(s0)
    80004a06:	a035                	j	80004a32 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004a08:	fe843783          	ld	a5,-24(s0)
    80004a0c:	67bc                	ld	a5,72(a5)
    80004a0e:	fef43423          	sd	a5,-24(s0)
    80004a12:	fe843703          	ld	a4,-24(s0)
    80004a16:	00067797          	auipc	a5,0x67
    80004a1a:	31a78793          	addi	a5,a5,794 # 8006bd30 <bcache+0x8268>
    80004a1e:	f8f71ce3          	bne	a4,a5,800049b6 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80004a22:	00007517          	auipc	a0,0x7
    80004a26:	9de50513          	addi	a0,a0,-1570 # 8000b400 <etext+0x400>
    80004a2a:	ffffc097          	auipc	ra,0xffffc
    80004a2e:	228080e7          	jalr	552(ra) # 80000c52 <panic>
}
    80004a32:	853e                	mv	a0,a5
    80004a34:	70a2                	ld	ra,40(sp)
    80004a36:	7402                	ld	s0,32(sp)
    80004a38:	6145                	addi	sp,sp,48
    80004a3a:	8082                	ret

0000000080004a3c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80004a3c:	7179                	addi	sp,sp,-48
    80004a3e:	f406                	sd	ra,40(sp)
    80004a40:	f022                	sd	s0,32(sp)
    80004a42:	1800                	addi	s0,sp,48
    80004a44:	87aa                	mv	a5,a0
    80004a46:	872e                	mv	a4,a1
    80004a48:	fcf42e23          	sw	a5,-36(s0)
    80004a4c:	87ba                	mv	a5,a4
    80004a4e:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80004a52:	fd842703          	lw	a4,-40(s0)
    80004a56:	fdc42783          	lw	a5,-36(s0)
    80004a5a:	85ba                	mv	a1,a4
    80004a5c:	853e                	mv	a0,a5
    80004a5e:	00000097          	auipc	ra,0x0
    80004a62:	e94080e7          	jalr	-364(ra) # 800048f2 <bget>
    80004a66:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    80004a6a:	fe843783          	ld	a5,-24(s0)
    80004a6e:	439c                	lw	a5,0(a5)
    80004a70:	ef81                	bnez	a5,80004a88 <bread+0x4c>
    virtio_disk_rw(b, 0);
    80004a72:	4581                	li	a1,0
    80004a74:	fe843503          	ld	a0,-24(s0)
    80004a78:	00005097          	auipc	ra,0x5
    80004a7c:	802080e7          	jalr	-2046(ra) # 8000927a <virtio_disk_rw>
    b->valid = 1;
    80004a80:	fe843783          	ld	a5,-24(s0)
    80004a84:	4705                	li	a4,1
    80004a86:	c398                	sw	a4,0(a5)
  }
  return b;
    80004a88:	fe843783          	ld	a5,-24(s0)
}
    80004a8c:	853e                	mv	a0,a5
    80004a8e:	70a2                	ld	ra,40(sp)
    80004a90:	7402                	ld	s0,32(sp)
    80004a92:	6145                	addi	sp,sp,48
    80004a94:	8082                	ret

0000000080004a96 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80004a96:	1101                	addi	sp,sp,-32
    80004a98:	ec06                	sd	ra,24(sp)
    80004a9a:	e822                	sd	s0,16(sp)
    80004a9c:	1000                	addi	s0,sp,32
    80004a9e:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004aa2:	fe843783          	ld	a5,-24(s0)
    80004aa6:	07c1                	addi	a5,a5,16
    80004aa8:	853e                	mv	a0,a5
    80004aaa:	00002097          	auipc	ra,0x2
    80004aae:	f04080e7          	jalr	-252(ra) # 800069ae <holdingsleep>
    80004ab2:	87aa                	mv	a5,a0
    80004ab4:	eb89                	bnez	a5,80004ac6 <bwrite+0x30>
    panic("bwrite");
    80004ab6:	00007517          	auipc	a0,0x7
    80004aba:	96250513          	addi	a0,a0,-1694 # 8000b418 <etext+0x418>
    80004abe:	ffffc097          	auipc	ra,0xffffc
    80004ac2:	194080e7          	jalr	404(ra) # 80000c52 <panic>
  virtio_disk_rw(b, 1);
    80004ac6:	4585                	li	a1,1
    80004ac8:	fe843503          	ld	a0,-24(s0)
    80004acc:	00004097          	auipc	ra,0x4
    80004ad0:	7ae080e7          	jalr	1966(ra) # 8000927a <virtio_disk_rw>
}
    80004ad4:	0001                	nop
    80004ad6:	60e2                	ld	ra,24(sp)
    80004ad8:	6442                	ld	s0,16(sp)
    80004ada:	6105                	addi	sp,sp,32
    80004adc:	8082                	ret

0000000080004ade <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004ade:	1101                	addi	sp,sp,-32
    80004ae0:	ec06                	sd	ra,24(sp)
    80004ae2:	e822                	sd	s0,16(sp)
    80004ae4:	1000                	addi	s0,sp,32
    80004ae6:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004aea:	fe843783          	ld	a5,-24(s0)
    80004aee:	07c1                	addi	a5,a5,16
    80004af0:	853e                	mv	a0,a5
    80004af2:	00002097          	auipc	ra,0x2
    80004af6:	ebc080e7          	jalr	-324(ra) # 800069ae <holdingsleep>
    80004afa:	87aa                	mv	a5,a0
    80004afc:	eb89                	bnez	a5,80004b0e <brelse+0x30>
    panic("brelse");
    80004afe:	00007517          	auipc	a0,0x7
    80004b02:	92250513          	addi	a0,a0,-1758 # 8000b420 <etext+0x420>
    80004b06:	ffffc097          	auipc	ra,0xffffc
    80004b0a:	14c080e7          	jalr	332(ra) # 80000c52 <panic>

  releasesleep(&b->lock);
    80004b0e:	fe843783          	ld	a5,-24(s0)
    80004b12:	07c1                	addi	a5,a5,16
    80004b14:	853e                	mv	a0,a5
    80004b16:	00002097          	auipc	ra,0x2
    80004b1a:	e46080e7          	jalr	-442(ra) # 8000695c <releasesleep>

  acquire(&bcache.lock);
    80004b1e:	0005f517          	auipc	a0,0x5f
    80004b22:	faa50513          	addi	a0,a0,-86 # 80063ac8 <bcache>
    80004b26:	ffffc097          	auipc	ra,0xffffc
    80004b2a:	75a080e7          	jalr	1882(ra) # 80001280 <acquire>
  b->refcnt--;
    80004b2e:	fe843783          	ld	a5,-24(s0)
    80004b32:	43bc                	lw	a5,64(a5)
    80004b34:	37fd                	addiw	a5,a5,-1
    80004b36:	0007871b          	sext.w	a4,a5
    80004b3a:	fe843783          	ld	a5,-24(s0)
    80004b3e:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004b40:	fe843783          	ld	a5,-24(s0)
    80004b44:	43bc                	lw	a5,64(a5)
    80004b46:	e7b5                	bnez	a5,80004bb2 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80004b48:	fe843783          	ld	a5,-24(s0)
    80004b4c:	6bbc                	ld	a5,80(a5)
    80004b4e:	fe843703          	ld	a4,-24(s0)
    80004b52:	6738                	ld	a4,72(a4)
    80004b54:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80004b56:	fe843783          	ld	a5,-24(s0)
    80004b5a:	67bc                	ld	a5,72(a5)
    80004b5c:	fe843703          	ld	a4,-24(s0)
    80004b60:	6b38                	ld	a4,80(a4)
    80004b62:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80004b64:	0005f717          	auipc	a4,0x5f
    80004b68:	f6470713          	addi	a4,a4,-156 # 80063ac8 <bcache>
    80004b6c:	67a1                	lui	a5,0x8
    80004b6e:	97ba                	add	a5,a5,a4
    80004b70:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004b74:	fe843783          	ld	a5,-24(s0)
    80004b78:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004b7a:	fe843783          	ld	a5,-24(s0)
    80004b7e:	00067717          	auipc	a4,0x67
    80004b82:	1b270713          	addi	a4,a4,434 # 8006bd30 <bcache+0x8268>
    80004b86:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    80004b88:	0005f717          	auipc	a4,0x5f
    80004b8c:	f4070713          	addi	a4,a4,-192 # 80063ac8 <bcache>
    80004b90:	67a1                	lui	a5,0x8
    80004b92:	97ba                	add	a5,a5,a4
    80004b94:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004b98:	fe843703          	ld	a4,-24(s0)
    80004b9c:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004b9e:	0005f717          	auipc	a4,0x5f
    80004ba2:	f2a70713          	addi	a4,a4,-214 # 80063ac8 <bcache>
    80004ba6:	67a1                	lui	a5,0x8
    80004ba8:	97ba                	add	a5,a5,a4
    80004baa:	fe843703          	ld	a4,-24(s0)
    80004bae:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80004bb2:	0005f517          	auipc	a0,0x5f
    80004bb6:	f1650513          	addi	a0,a0,-234 # 80063ac8 <bcache>
    80004bba:	ffffc097          	auipc	ra,0xffffc
    80004bbe:	72a080e7          	jalr	1834(ra) # 800012e4 <release>
}
    80004bc2:	0001                	nop
    80004bc4:	60e2                	ld	ra,24(sp)
    80004bc6:	6442                	ld	s0,16(sp)
    80004bc8:	6105                	addi	sp,sp,32
    80004bca:	8082                	ret

0000000080004bcc <bpin>:

void
bpin(struct buf *b) {
    80004bcc:	1101                	addi	sp,sp,-32
    80004bce:	ec06                	sd	ra,24(sp)
    80004bd0:	e822                	sd	s0,16(sp)
    80004bd2:	1000                	addi	s0,sp,32
    80004bd4:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004bd8:	0005f517          	auipc	a0,0x5f
    80004bdc:	ef050513          	addi	a0,a0,-272 # 80063ac8 <bcache>
    80004be0:	ffffc097          	auipc	ra,0xffffc
    80004be4:	6a0080e7          	jalr	1696(ra) # 80001280 <acquire>
  b->refcnt++;
    80004be8:	fe843783          	ld	a5,-24(s0)
    80004bec:	43bc                	lw	a5,64(a5)
    80004bee:	2785                	addiw	a5,a5,1
    80004bf0:	0007871b          	sext.w	a4,a5
    80004bf4:	fe843783          	ld	a5,-24(s0)
    80004bf8:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004bfa:	0005f517          	auipc	a0,0x5f
    80004bfe:	ece50513          	addi	a0,a0,-306 # 80063ac8 <bcache>
    80004c02:	ffffc097          	auipc	ra,0xffffc
    80004c06:	6e2080e7          	jalr	1762(ra) # 800012e4 <release>
}
    80004c0a:	0001                	nop
    80004c0c:	60e2                	ld	ra,24(sp)
    80004c0e:	6442                	ld	s0,16(sp)
    80004c10:	6105                	addi	sp,sp,32
    80004c12:	8082                	ret

0000000080004c14 <bunpin>:

void
bunpin(struct buf *b) {
    80004c14:	1101                	addi	sp,sp,-32
    80004c16:	ec06                	sd	ra,24(sp)
    80004c18:	e822                	sd	s0,16(sp)
    80004c1a:	1000                	addi	s0,sp,32
    80004c1c:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004c20:	0005f517          	auipc	a0,0x5f
    80004c24:	ea850513          	addi	a0,a0,-344 # 80063ac8 <bcache>
    80004c28:	ffffc097          	auipc	ra,0xffffc
    80004c2c:	658080e7          	jalr	1624(ra) # 80001280 <acquire>
  b->refcnt--;
    80004c30:	fe843783          	ld	a5,-24(s0)
    80004c34:	43bc                	lw	a5,64(a5)
    80004c36:	37fd                	addiw	a5,a5,-1
    80004c38:	0007871b          	sext.w	a4,a5
    80004c3c:	fe843783          	ld	a5,-24(s0)
    80004c40:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004c42:	0005f517          	auipc	a0,0x5f
    80004c46:	e8650513          	addi	a0,a0,-378 # 80063ac8 <bcache>
    80004c4a:	ffffc097          	auipc	ra,0xffffc
    80004c4e:	69a080e7          	jalr	1690(ra) # 800012e4 <release>
}
    80004c52:	0001                	nop
    80004c54:	60e2                	ld	ra,24(sp)
    80004c56:	6442                	ld	s0,16(sp)
    80004c58:	6105                	addi	sp,sp,32
    80004c5a:	8082                	ret

0000000080004c5c <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004c5c:	7179                	addi	sp,sp,-48
    80004c5e:	f406                	sd	ra,40(sp)
    80004c60:	f022                	sd	s0,32(sp)
    80004c62:	1800                	addi	s0,sp,48
    80004c64:	87aa                	mv	a5,a0
    80004c66:	fcb43823          	sd	a1,-48(s0)
    80004c6a:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004c6e:	fdc42783          	lw	a5,-36(s0)
    80004c72:	4585                	li	a1,1
    80004c74:	853e                	mv	a0,a5
    80004c76:	00000097          	auipc	ra,0x0
    80004c7a:	dc6080e7          	jalr	-570(ra) # 80004a3c <bread>
    80004c7e:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80004c82:	fe843783          	ld	a5,-24(s0)
    80004c86:	05878793          	addi	a5,a5,88
    80004c8a:	02000613          	li	a2,32
    80004c8e:	85be                	mv	a1,a5
    80004c90:	fd043503          	ld	a0,-48(s0)
    80004c94:	ffffd097          	auipc	ra,0xffffd
    80004c98:	8a4080e7          	jalr	-1884(ra) # 80001538 <memmove>
  brelse(bp);
    80004c9c:	fe843503          	ld	a0,-24(s0)
    80004ca0:	00000097          	auipc	ra,0x0
    80004ca4:	e3e080e7          	jalr	-450(ra) # 80004ade <brelse>
}
    80004ca8:	0001                	nop
    80004caa:	70a2                	ld	ra,40(sp)
    80004cac:	7402                	ld	s0,32(sp)
    80004cae:	6145                	addi	sp,sp,48
    80004cb0:	8082                	ret

0000000080004cb2 <fsinit>:

// Init fs
void
fsinit(int dev) {
    80004cb2:	1101                	addi	sp,sp,-32
    80004cb4:	ec06                	sd	ra,24(sp)
    80004cb6:	e822                	sd	s0,16(sp)
    80004cb8:	1000                	addi	s0,sp,32
    80004cba:	87aa                	mv	a5,a0
    80004cbc:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    80004cc0:	fec42783          	lw	a5,-20(s0)
    80004cc4:	00067597          	auipc	a1,0x67
    80004cc8:	4c458593          	addi	a1,a1,1220 # 8006c188 <sb>
    80004ccc:	853e                	mv	a0,a5
    80004cce:	00000097          	auipc	ra,0x0
    80004cd2:	f8e080e7          	jalr	-114(ra) # 80004c5c <readsb>
  if(sb.magic != FSMAGIC)
    80004cd6:	00067797          	auipc	a5,0x67
    80004cda:	4b278793          	addi	a5,a5,1202 # 8006c188 <sb>
    80004cde:	439c                	lw	a5,0(a5)
    80004ce0:	873e                	mv	a4,a5
    80004ce2:	102037b7          	lui	a5,0x10203
    80004ce6:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80004cea:	00f70a63          	beq	a4,a5,80004cfe <fsinit+0x4c>
    panic("invalid file system");
    80004cee:	00006517          	auipc	a0,0x6
    80004cf2:	73a50513          	addi	a0,a0,1850 # 8000b428 <etext+0x428>
    80004cf6:	ffffc097          	auipc	ra,0xffffc
    80004cfa:	f5c080e7          	jalr	-164(ra) # 80000c52 <panic>
  initlog(dev, &sb);
    80004cfe:	fec42783          	lw	a5,-20(s0)
    80004d02:	00067597          	auipc	a1,0x67
    80004d06:	48658593          	addi	a1,a1,1158 # 8006c188 <sb>
    80004d0a:	853e                	mv	a0,a5
    80004d0c:	00001097          	auipc	ra,0x1
    80004d10:	47a080e7          	jalr	1146(ra) # 80006186 <initlog>
}
    80004d14:	0001                	nop
    80004d16:	60e2                	ld	ra,24(sp)
    80004d18:	6442                	ld	s0,16(sp)
    80004d1a:	6105                	addi	sp,sp,32
    80004d1c:	8082                	ret

0000000080004d1e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80004d1e:	7179                	addi	sp,sp,-48
    80004d20:	f406                	sd	ra,40(sp)
    80004d22:	f022                	sd	s0,32(sp)
    80004d24:	1800                	addi	s0,sp,48
    80004d26:	87aa                	mv	a5,a0
    80004d28:	872e                	mv	a4,a1
    80004d2a:	fcf42e23          	sw	a5,-36(s0)
    80004d2e:	87ba                	mv	a5,a4
    80004d30:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80004d34:	fdc42783          	lw	a5,-36(s0)
    80004d38:	fd842703          	lw	a4,-40(s0)
    80004d3c:	85ba                	mv	a1,a4
    80004d3e:	853e                	mv	a0,a5
    80004d40:	00000097          	auipc	ra,0x0
    80004d44:	cfc080e7          	jalr	-772(ra) # 80004a3c <bread>
    80004d48:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80004d4c:	fe843783          	ld	a5,-24(s0)
    80004d50:	05878793          	addi	a5,a5,88
    80004d54:	40000613          	li	a2,1024
    80004d58:	4581                	li	a1,0
    80004d5a:	853e                	mv	a0,a5
    80004d5c:	ffffc097          	auipc	ra,0xffffc
    80004d60:	6f8080e7          	jalr	1784(ra) # 80001454 <memset>
  log_write(bp);
    80004d64:	fe843503          	ld	a0,-24(s0)
    80004d68:	00002097          	auipc	ra,0x2
    80004d6c:	a06080e7          	jalr	-1530(ra) # 8000676e <log_write>
  brelse(bp);
    80004d70:	fe843503          	ld	a0,-24(s0)
    80004d74:	00000097          	auipc	ra,0x0
    80004d78:	d6a080e7          	jalr	-662(ra) # 80004ade <brelse>
}
    80004d7c:	0001                	nop
    80004d7e:	70a2                	ld	ra,40(sp)
    80004d80:	7402                	ld	s0,32(sp)
    80004d82:	6145                	addi	sp,sp,48
    80004d84:	8082                	ret

0000000080004d86 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    80004d86:	7139                	addi	sp,sp,-64
    80004d88:	fc06                	sd	ra,56(sp)
    80004d8a:	f822                	sd	s0,48(sp)
    80004d8c:	0080                	addi	s0,sp,64
    80004d8e:	87aa                	mv	a5,a0
    80004d90:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004d94:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    80004d98:	fe042623          	sw	zero,-20(s0)
    80004d9c:	a2b5                	j	80004f08 <balloc+0x182>
    bp = bread(dev, BBLOCK(b, sb));
    80004d9e:	fec42783          	lw	a5,-20(s0)
    80004da2:	41f7d71b          	sraiw	a4,a5,0x1f
    80004da6:	0137571b          	srliw	a4,a4,0x13
    80004daa:	9fb9                	addw	a5,a5,a4
    80004dac:	40d7d79b          	sraiw	a5,a5,0xd
    80004db0:	2781                	sext.w	a5,a5
    80004db2:	0007871b          	sext.w	a4,a5
    80004db6:	00067797          	auipc	a5,0x67
    80004dba:	3d278793          	addi	a5,a5,978 # 8006c188 <sb>
    80004dbe:	4fdc                	lw	a5,28(a5)
    80004dc0:	9fb9                	addw	a5,a5,a4
    80004dc2:	0007871b          	sext.w	a4,a5
    80004dc6:	fcc42783          	lw	a5,-52(s0)
    80004dca:	85ba                	mv	a1,a4
    80004dcc:	853e                	mv	a0,a5
    80004dce:	00000097          	auipc	ra,0x0
    80004dd2:	c6e080e7          	jalr	-914(ra) # 80004a3c <bread>
    80004dd6:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004dda:	fe042423          	sw	zero,-24(s0)
    80004dde:	a0dd                	j	80004ec4 <balloc+0x13e>
      m = 1 << (bi % 8);
    80004de0:	fe842703          	lw	a4,-24(s0)
    80004de4:	41f7579b          	sraiw	a5,a4,0x1f
    80004de8:	01d7d79b          	srliw	a5,a5,0x1d
    80004dec:	9f3d                	addw	a4,a4,a5
    80004dee:	8b1d                	andi	a4,a4,7
    80004df0:	40f707bb          	subw	a5,a4,a5
    80004df4:	2781                	sext.w	a5,a5
    80004df6:	4705                	li	a4,1
    80004df8:	00f717bb          	sllw	a5,a4,a5
    80004dfc:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80004e00:	fe842783          	lw	a5,-24(s0)
    80004e04:	41f7d71b          	sraiw	a4,a5,0x1f
    80004e08:	01d7571b          	srliw	a4,a4,0x1d
    80004e0c:	9fb9                	addw	a5,a5,a4
    80004e0e:	4037d79b          	sraiw	a5,a5,0x3
    80004e12:	2781                	sext.w	a5,a5
    80004e14:	fe043703          	ld	a4,-32(s0)
    80004e18:	97ba                	add	a5,a5,a4
    80004e1a:	0587c783          	lbu	a5,88(a5)
    80004e1e:	0007871b          	sext.w	a4,a5
    80004e22:	fdc42783          	lw	a5,-36(s0)
    80004e26:	8ff9                	and	a5,a5,a4
    80004e28:	2781                	sext.w	a5,a5
    80004e2a:	ebc1                	bnez	a5,80004eba <balloc+0x134>
        bp->data[bi/8] |= m;  // Mark block in use.
    80004e2c:	fe842783          	lw	a5,-24(s0)
    80004e30:	41f7d71b          	sraiw	a4,a5,0x1f
    80004e34:	01d7571b          	srliw	a4,a4,0x1d
    80004e38:	9fb9                	addw	a5,a5,a4
    80004e3a:	4037d79b          	sraiw	a5,a5,0x3
    80004e3e:	2781                	sext.w	a5,a5
    80004e40:	fe043703          	ld	a4,-32(s0)
    80004e44:	973e                	add	a4,a4,a5
    80004e46:	05874703          	lbu	a4,88(a4)
    80004e4a:	0187169b          	slliw	a3,a4,0x18
    80004e4e:	4186d69b          	sraiw	a3,a3,0x18
    80004e52:	fdc42703          	lw	a4,-36(s0)
    80004e56:	0187171b          	slliw	a4,a4,0x18
    80004e5a:	4187571b          	sraiw	a4,a4,0x18
    80004e5e:	8f55                	or	a4,a4,a3
    80004e60:	0187171b          	slliw	a4,a4,0x18
    80004e64:	4187571b          	sraiw	a4,a4,0x18
    80004e68:	0ff77713          	andi	a4,a4,255
    80004e6c:	fe043683          	ld	a3,-32(s0)
    80004e70:	97b6                	add	a5,a5,a3
    80004e72:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004e76:	fe043503          	ld	a0,-32(s0)
    80004e7a:	00002097          	auipc	ra,0x2
    80004e7e:	8f4080e7          	jalr	-1804(ra) # 8000676e <log_write>
        brelse(bp);
    80004e82:	fe043503          	ld	a0,-32(s0)
    80004e86:	00000097          	auipc	ra,0x0
    80004e8a:	c58080e7          	jalr	-936(ra) # 80004ade <brelse>
        bzero(dev, b + bi);
    80004e8e:	fcc42683          	lw	a3,-52(s0)
    80004e92:	fec42703          	lw	a4,-20(s0)
    80004e96:	fe842783          	lw	a5,-24(s0)
    80004e9a:	9fb9                	addw	a5,a5,a4
    80004e9c:	2781                	sext.w	a5,a5
    80004e9e:	85be                	mv	a1,a5
    80004ea0:	8536                	mv	a0,a3
    80004ea2:	00000097          	auipc	ra,0x0
    80004ea6:	e7c080e7          	jalr	-388(ra) # 80004d1e <bzero>
        return b + bi;
    80004eaa:	fec42703          	lw	a4,-20(s0)
    80004eae:	fe842783          	lw	a5,-24(s0)
    80004eb2:	9fb9                	addw	a5,a5,a4
    80004eb4:	2781                	sext.w	a5,a5
    80004eb6:	2781                	sext.w	a5,a5
    80004eb8:	a88d                	j	80004f2a <balloc+0x1a4>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004eba:	fe842783          	lw	a5,-24(s0)
    80004ebe:	2785                	addiw	a5,a5,1
    80004ec0:	fef42423          	sw	a5,-24(s0)
    80004ec4:	fe842783          	lw	a5,-24(s0)
    80004ec8:	0007871b          	sext.w	a4,a5
    80004ecc:	6789                	lui	a5,0x2
    80004ece:	02f75163          	bge	a4,a5,80004ef0 <balloc+0x16a>
    80004ed2:	fec42703          	lw	a4,-20(s0)
    80004ed6:	fe842783          	lw	a5,-24(s0)
    80004eda:	9fb9                	addw	a5,a5,a4
    80004edc:	2781                	sext.w	a5,a5
    80004ede:	0007871b          	sext.w	a4,a5
    80004ee2:	00067797          	auipc	a5,0x67
    80004ee6:	2a678793          	addi	a5,a5,678 # 8006c188 <sb>
    80004eea:	43dc                	lw	a5,4(a5)
    80004eec:	eef76ae3          	bltu	a4,a5,80004de0 <balloc+0x5a>
      }
    }
    brelse(bp);
    80004ef0:	fe043503          	ld	a0,-32(s0)
    80004ef4:	00000097          	auipc	ra,0x0
    80004ef8:	bea080e7          	jalr	-1046(ra) # 80004ade <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80004efc:	fec42703          	lw	a4,-20(s0)
    80004f00:	6789                	lui	a5,0x2
    80004f02:	9fb9                	addw	a5,a5,a4
    80004f04:	fef42623          	sw	a5,-20(s0)
    80004f08:	00067797          	auipc	a5,0x67
    80004f0c:	28078793          	addi	a5,a5,640 # 8006c188 <sb>
    80004f10:	43d8                	lw	a4,4(a5)
    80004f12:	fec42783          	lw	a5,-20(s0)
    80004f16:	e8e7e4e3          	bltu	a5,a4,80004d9e <balloc+0x18>
  }
  panic("balloc: out of blocks");
    80004f1a:	00006517          	auipc	a0,0x6
    80004f1e:	52650513          	addi	a0,a0,1318 # 8000b440 <etext+0x440>
    80004f22:	ffffc097          	auipc	ra,0xffffc
    80004f26:	d30080e7          	jalr	-720(ra) # 80000c52 <panic>
}
    80004f2a:	853e                	mv	a0,a5
    80004f2c:	70e2                	ld	ra,56(sp)
    80004f2e:	7442                	ld	s0,48(sp)
    80004f30:	6121                	addi	sp,sp,64
    80004f32:	8082                	ret

0000000080004f34 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004f34:	7179                	addi	sp,sp,-48
    80004f36:	f406                	sd	ra,40(sp)
    80004f38:	f022                	sd	s0,32(sp)
    80004f3a:	1800                	addi	s0,sp,48
    80004f3c:	87aa                	mv	a5,a0
    80004f3e:	872e                	mv	a4,a1
    80004f40:	fcf42e23          	sw	a5,-36(s0)
    80004f44:	87ba                	mv	a5,a4
    80004f46:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80004f4a:	fdc42683          	lw	a3,-36(s0)
    80004f4e:	fd842783          	lw	a5,-40(s0)
    80004f52:	00d7d79b          	srliw	a5,a5,0xd
    80004f56:	0007871b          	sext.w	a4,a5
    80004f5a:	00067797          	auipc	a5,0x67
    80004f5e:	22e78793          	addi	a5,a5,558 # 8006c188 <sb>
    80004f62:	4fdc                	lw	a5,28(a5)
    80004f64:	9fb9                	addw	a5,a5,a4
    80004f66:	2781                	sext.w	a5,a5
    80004f68:	85be                	mv	a1,a5
    80004f6a:	8536                	mv	a0,a3
    80004f6c:	00000097          	auipc	ra,0x0
    80004f70:	ad0080e7          	jalr	-1328(ra) # 80004a3c <bread>
    80004f74:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004f78:	fd842703          	lw	a4,-40(s0)
    80004f7c:	6789                	lui	a5,0x2
    80004f7e:	17fd                	addi	a5,a5,-1
    80004f80:	8ff9                	and	a5,a5,a4
    80004f82:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004f86:	fe442703          	lw	a4,-28(s0)
    80004f8a:	41f7579b          	sraiw	a5,a4,0x1f
    80004f8e:	01d7d79b          	srliw	a5,a5,0x1d
    80004f92:	9f3d                	addw	a4,a4,a5
    80004f94:	8b1d                	andi	a4,a4,7
    80004f96:	40f707bb          	subw	a5,a4,a5
    80004f9a:	2781                	sext.w	a5,a5
    80004f9c:	4705                	li	a4,1
    80004f9e:	00f717bb          	sllw	a5,a4,a5
    80004fa2:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004fa6:	fe442783          	lw	a5,-28(s0)
    80004faa:	41f7d71b          	sraiw	a4,a5,0x1f
    80004fae:	01d7571b          	srliw	a4,a4,0x1d
    80004fb2:	9fb9                	addw	a5,a5,a4
    80004fb4:	4037d79b          	sraiw	a5,a5,0x3
    80004fb8:	2781                	sext.w	a5,a5
    80004fba:	fe843703          	ld	a4,-24(s0)
    80004fbe:	97ba                	add	a5,a5,a4
    80004fc0:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    80004fc4:	0007871b          	sext.w	a4,a5
    80004fc8:	fe042783          	lw	a5,-32(s0)
    80004fcc:	8ff9                	and	a5,a5,a4
    80004fce:	2781                	sext.w	a5,a5
    80004fd0:	eb89                	bnez	a5,80004fe2 <bfree+0xae>
    panic("freeing free block");
    80004fd2:	00006517          	auipc	a0,0x6
    80004fd6:	48650513          	addi	a0,a0,1158 # 8000b458 <etext+0x458>
    80004fda:	ffffc097          	auipc	ra,0xffffc
    80004fde:	c78080e7          	jalr	-904(ra) # 80000c52 <panic>
  bp->data[bi/8] &= ~m;
    80004fe2:	fe442783          	lw	a5,-28(s0)
    80004fe6:	41f7d71b          	sraiw	a4,a5,0x1f
    80004fea:	01d7571b          	srliw	a4,a4,0x1d
    80004fee:	9fb9                	addw	a5,a5,a4
    80004ff0:	4037d79b          	sraiw	a5,a5,0x3
    80004ff4:	2781                	sext.w	a5,a5
    80004ff6:	fe843703          	ld	a4,-24(s0)
    80004ffa:	973e                	add	a4,a4,a5
    80004ffc:	05874703          	lbu	a4,88(a4)
    80005000:	0187169b          	slliw	a3,a4,0x18
    80005004:	4186d69b          	sraiw	a3,a3,0x18
    80005008:	fe042703          	lw	a4,-32(s0)
    8000500c:	0187171b          	slliw	a4,a4,0x18
    80005010:	4187571b          	sraiw	a4,a4,0x18
    80005014:	fff74713          	not	a4,a4
    80005018:	0187171b          	slliw	a4,a4,0x18
    8000501c:	4187571b          	sraiw	a4,a4,0x18
    80005020:	8f75                	and	a4,a4,a3
    80005022:	0187171b          	slliw	a4,a4,0x18
    80005026:	4187571b          	sraiw	a4,a4,0x18
    8000502a:	0ff77713          	andi	a4,a4,255
    8000502e:	fe843683          	ld	a3,-24(s0)
    80005032:	97b6                	add	a5,a5,a3
    80005034:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80005038:	fe843503          	ld	a0,-24(s0)
    8000503c:	00001097          	auipc	ra,0x1
    80005040:	732080e7          	jalr	1842(ra) # 8000676e <log_write>
  brelse(bp);
    80005044:	fe843503          	ld	a0,-24(s0)
    80005048:	00000097          	auipc	ra,0x0
    8000504c:	a96080e7          	jalr	-1386(ra) # 80004ade <brelse>
}
    80005050:	0001                	nop
    80005052:	70a2                	ld	ra,40(sp)
    80005054:	7402                	ld	s0,32(sp)
    80005056:	6145                	addi	sp,sp,48
    80005058:	8082                	ret

000000008000505a <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit()
{
    8000505a:	1101                	addi	sp,sp,-32
    8000505c:	ec06                	sd	ra,24(sp)
    8000505e:	e822                	sd	s0,16(sp)
    80005060:	1000                	addi	s0,sp,32
  int i = 0;
    80005062:	fe042623          	sw	zero,-20(s0)
  
  initlock(&icache.lock, "icache");
    80005066:	00006597          	auipc	a1,0x6
    8000506a:	40a58593          	addi	a1,a1,1034 # 8000b470 <etext+0x470>
    8000506e:	00067517          	auipc	a0,0x67
    80005072:	13a50513          	addi	a0,a0,314 # 8006c1a8 <icache>
    80005076:	ffffc097          	auipc	ra,0xffffc
    8000507a:	1da080e7          	jalr	474(ra) # 80001250 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000507e:	fe042623          	sw	zero,-20(s0)
    80005082:	a82d                	j	800050bc <iinit+0x62>
    initsleeplock(&icache.inode[i].lock, "inode");
    80005084:	fec42703          	lw	a4,-20(s0)
    80005088:	87ba                	mv	a5,a4
    8000508a:	0792                	slli	a5,a5,0x4
    8000508c:	97ba                	add	a5,a5,a4
    8000508e:	078e                	slli	a5,a5,0x3
    80005090:	02078713          	addi	a4,a5,32
    80005094:	00067797          	auipc	a5,0x67
    80005098:	11478793          	addi	a5,a5,276 # 8006c1a8 <icache>
    8000509c:	97ba                	add	a5,a5,a4
    8000509e:	07a1                	addi	a5,a5,8
    800050a0:	00006597          	auipc	a1,0x6
    800050a4:	3d858593          	addi	a1,a1,984 # 8000b478 <etext+0x478>
    800050a8:	853e                	mv	a0,a5
    800050aa:	00001097          	auipc	ra,0x1
    800050ae:	7f8080e7          	jalr	2040(ra) # 800068a2 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800050b2:	fec42783          	lw	a5,-20(s0)
    800050b6:	2785                	addiw	a5,a5,1
    800050b8:	fef42623          	sw	a5,-20(s0)
    800050bc:	fec42783          	lw	a5,-20(s0)
    800050c0:	0007871b          	sext.w	a4,a5
    800050c4:	03100793          	li	a5,49
    800050c8:	fae7dee3          	bge	a5,a4,80005084 <iinit+0x2a>
  }
}
    800050cc:	0001                	nop
    800050ce:	0001                	nop
    800050d0:	60e2                	ld	ra,24(sp)
    800050d2:	6442                	ld	s0,16(sp)
    800050d4:	6105                	addi	sp,sp,32
    800050d6:	8082                	ret

00000000800050d8 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    800050d8:	7139                	addi	sp,sp,-64
    800050da:	fc06                	sd	ra,56(sp)
    800050dc:	f822                	sd	s0,48(sp)
    800050de:	0080                	addi	s0,sp,64
    800050e0:	87aa                	mv	a5,a0
    800050e2:	872e                	mv	a4,a1
    800050e4:	fcf42623          	sw	a5,-52(s0)
    800050e8:	87ba                	mv	a5,a4
    800050ea:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    800050ee:	4785                	li	a5,1
    800050f0:	fef42623          	sw	a5,-20(s0)
    800050f4:	a855                	j	800051a8 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    800050f6:	fec42783          	lw	a5,-20(s0)
    800050fa:	8391                	srli	a5,a5,0x4
    800050fc:	0007871b          	sext.w	a4,a5
    80005100:	00067797          	auipc	a5,0x67
    80005104:	08878793          	addi	a5,a5,136 # 8006c188 <sb>
    80005108:	4f9c                	lw	a5,24(a5)
    8000510a:	9fb9                	addw	a5,a5,a4
    8000510c:	0007871b          	sext.w	a4,a5
    80005110:	fcc42783          	lw	a5,-52(s0)
    80005114:	85ba                	mv	a1,a4
    80005116:	853e                	mv	a0,a5
    80005118:	00000097          	auipc	ra,0x0
    8000511c:	924080e7          	jalr	-1756(ra) # 80004a3c <bread>
    80005120:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80005124:	fe043783          	ld	a5,-32(s0)
    80005128:	05878713          	addi	a4,a5,88
    8000512c:	fec42783          	lw	a5,-20(s0)
    80005130:	8bbd                	andi	a5,a5,15
    80005132:	079a                	slli	a5,a5,0x6
    80005134:	97ba                	add	a5,a5,a4
    80005136:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    8000513a:	fd843783          	ld	a5,-40(s0)
    8000513e:	00079783          	lh	a5,0(a5)
    80005142:	eba1                	bnez	a5,80005192 <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005144:	04000613          	li	a2,64
    80005148:	4581                	li	a1,0
    8000514a:	fd843503          	ld	a0,-40(s0)
    8000514e:	ffffc097          	auipc	ra,0xffffc
    80005152:	306080e7          	jalr	774(ra) # 80001454 <memset>
      dip->type = type;
    80005156:	fd843783          	ld	a5,-40(s0)
    8000515a:	fca45703          	lhu	a4,-54(s0)
    8000515e:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005162:	fe043503          	ld	a0,-32(s0)
    80005166:	00001097          	auipc	ra,0x1
    8000516a:	608080e7          	jalr	1544(ra) # 8000676e <log_write>
      brelse(bp);
    8000516e:	fe043503          	ld	a0,-32(s0)
    80005172:	00000097          	auipc	ra,0x0
    80005176:	96c080e7          	jalr	-1684(ra) # 80004ade <brelse>
      return iget(dev, inum);
    8000517a:	fec42703          	lw	a4,-20(s0)
    8000517e:	fcc42783          	lw	a5,-52(s0)
    80005182:	85ba                	mv	a1,a4
    80005184:	853e                	mv	a0,a5
    80005186:	00000097          	auipc	ra,0x0
    8000518a:	136080e7          	jalr	310(ra) # 800052bc <iget>
    8000518e:	87aa                	mv	a5,a0
    80005190:	a82d                	j	800051ca <ialloc+0xf2>
    }
    brelse(bp);
    80005192:	fe043503          	ld	a0,-32(s0)
    80005196:	00000097          	auipc	ra,0x0
    8000519a:	948080e7          	jalr	-1720(ra) # 80004ade <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000519e:	fec42783          	lw	a5,-20(s0)
    800051a2:	2785                	addiw	a5,a5,1
    800051a4:	fef42623          	sw	a5,-20(s0)
    800051a8:	00067797          	auipc	a5,0x67
    800051ac:	fe078793          	addi	a5,a5,-32 # 8006c188 <sb>
    800051b0:	47d8                	lw	a4,12(a5)
    800051b2:	fec42783          	lw	a5,-20(s0)
    800051b6:	f4e7e0e3          	bltu	a5,a4,800050f6 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    800051ba:	00006517          	auipc	a0,0x6
    800051be:	2c650513          	addi	a0,a0,710 # 8000b480 <etext+0x480>
    800051c2:	ffffc097          	auipc	ra,0xffffc
    800051c6:	a90080e7          	jalr	-1392(ra) # 80000c52 <panic>
}
    800051ca:	853e                	mv	a0,a5
    800051cc:	70e2                	ld	ra,56(sp)
    800051ce:	7442                	ld	s0,48(sp)
    800051d0:	6121                	addi	sp,sp,64
    800051d2:	8082                	ret

00000000800051d4 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    800051d4:	7179                	addi	sp,sp,-48
    800051d6:	f406                	sd	ra,40(sp)
    800051d8:	f022                	sd	s0,32(sp)
    800051da:	1800                	addi	s0,sp,48
    800051dc:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800051e0:	fd843783          	ld	a5,-40(s0)
    800051e4:	4394                	lw	a3,0(a5)
    800051e6:	fd843783          	ld	a5,-40(s0)
    800051ea:	43dc                	lw	a5,4(a5)
    800051ec:	0047d79b          	srliw	a5,a5,0x4
    800051f0:	0007871b          	sext.w	a4,a5
    800051f4:	00067797          	auipc	a5,0x67
    800051f8:	f9478793          	addi	a5,a5,-108 # 8006c188 <sb>
    800051fc:	4f9c                	lw	a5,24(a5)
    800051fe:	9fb9                	addw	a5,a5,a4
    80005200:	2781                	sext.w	a5,a5
    80005202:	85be                	mv	a1,a5
    80005204:	8536                	mv	a0,a3
    80005206:	00000097          	auipc	ra,0x0
    8000520a:	836080e7          	jalr	-1994(ra) # 80004a3c <bread>
    8000520e:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005212:	fe843783          	ld	a5,-24(s0)
    80005216:	05878713          	addi	a4,a5,88
    8000521a:	fd843783          	ld	a5,-40(s0)
    8000521e:	43dc                	lw	a5,4(a5)
    80005220:	1782                	slli	a5,a5,0x20
    80005222:	9381                	srli	a5,a5,0x20
    80005224:	8bbd                	andi	a5,a5,15
    80005226:	079a                	slli	a5,a5,0x6
    80005228:	97ba                	add	a5,a5,a4
    8000522a:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    8000522e:	fd843783          	ld	a5,-40(s0)
    80005232:	04479703          	lh	a4,68(a5)
    80005236:	fe043783          	ld	a5,-32(s0)
    8000523a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000523e:	fd843783          	ld	a5,-40(s0)
    80005242:	04679703          	lh	a4,70(a5)
    80005246:	fe043783          	ld	a5,-32(s0)
    8000524a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000524e:	fd843783          	ld	a5,-40(s0)
    80005252:	04879703          	lh	a4,72(a5)
    80005256:	fe043783          	ld	a5,-32(s0)
    8000525a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000525e:	fd843783          	ld	a5,-40(s0)
    80005262:	04a79703          	lh	a4,74(a5)
    80005266:	fe043783          	ld	a5,-32(s0)
    8000526a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000526e:	fd843783          	ld	a5,-40(s0)
    80005272:	47f8                	lw	a4,76(a5)
    80005274:	fe043783          	ld	a5,-32(s0)
    80005278:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000527a:	fe043783          	ld	a5,-32(s0)
    8000527e:	00c78713          	addi	a4,a5,12
    80005282:	fd843783          	ld	a5,-40(s0)
    80005286:	05078793          	addi	a5,a5,80
    8000528a:	03400613          	li	a2,52
    8000528e:	85be                	mv	a1,a5
    80005290:	853a                	mv	a0,a4
    80005292:	ffffc097          	auipc	ra,0xffffc
    80005296:	2a6080e7          	jalr	678(ra) # 80001538 <memmove>
  log_write(bp);
    8000529a:	fe843503          	ld	a0,-24(s0)
    8000529e:	00001097          	auipc	ra,0x1
    800052a2:	4d0080e7          	jalr	1232(ra) # 8000676e <log_write>
  brelse(bp);
    800052a6:	fe843503          	ld	a0,-24(s0)
    800052aa:	00000097          	auipc	ra,0x0
    800052ae:	834080e7          	jalr	-1996(ra) # 80004ade <brelse>
}
    800052b2:	0001                	nop
    800052b4:	70a2                	ld	ra,40(sp)
    800052b6:	7402                	ld	s0,32(sp)
    800052b8:	6145                	addi	sp,sp,48
    800052ba:	8082                	ret

00000000800052bc <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    800052bc:	7179                	addi	sp,sp,-48
    800052be:	f406                	sd	ra,40(sp)
    800052c0:	f022                	sd	s0,32(sp)
    800052c2:	1800                	addi	s0,sp,48
    800052c4:	87aa                	mv	a5,a0
    800052c6:	872e                	mv	a4,a1
    800052c8:	fcf42e23          	sw	a5,-36(s0)
    800052cc:	87ba                	mv	a5,a4
    800052ce:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&icache.lock);
    800052d2:	00067517          	auipc	a0,0x67
    800052d6:	ed650513          	addi	a0,a0,-298 # 8006c1a8 <icache>
    800052da:	ffffc097          	auipc	ra,0xffffc
    800052de:	fa6080e7          	jalr	-90(ra) # 80001280 <acquire>

  // Is the inode already cached?
  empty = 0;
    800052e2:	fe043023          	sd	zero,-32(s0)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    800052e6:	00067797          	auipc	a5,0x67
    800052ea:	eda78793          	addi	a5,a5,-294 # 8006c1c0 <icache+0x18>
    800052ee:	fef43423          	sd	a5,-24(s0)
    800052f2:	a89d                	j	80005368 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800052f4:	fe843783          	ld	a5,-24(s0)
    800052f8:	479c                	lw	a5,8(a5)
    800052fa:	04f05663          	blez	a5,80005346 <iget+0x8a>
    800052fe:	fe843783          	ld	a5,-24(s0)
    80005302:	4398                	lw	a4,0(a5)
    80005304:	fdc42783          	lw	a5,-36(s0)
    80005308:	2781                	sext.w	a5,a5
    8000530a:	02e79e63          	bne	a5,a4,80005346 <iget+0x8a>
    8000530e:	fe843783          	ld	a5,-24(s0)
    80005312:	43d8                	lw	a4,4(a5)
    80005314:	fd842783          	lw	a5,-40(s0)
    80005318:	2781                	sext.w	a5,a5
    8000531a:	02e79663          	bne	a5,a4,80005346 <iget+0x8a>
      ip->ref++;
    8000531e:	fe843783          	ld	a5,-24(s0)
    80005322:	479c                	lw	a5,8(a5)
    80005324:	2785                	addiw	a5,a5,1
    80005326:	0007871b          	sext.w	a4,a5
    8000532a:	fe843783          	ld	a5,-24(s0)
    8000532e:	c798                	sw	a4,8(a5)
      release(&icache.lock);
    80005330:	00067517          	auipc	a0,0x67
    80005334:	e7850513          	addi	a0,a0,-392 # 8006c1a8 <icache>
    80005338:	ffffc097          	auipc	ra,0xffffc
    8000533c:	fac080e7          	jalr	-84(ra) # 800012e4 <release>
      return ip;
    80005340:	fe843783          	ld	a5,-24(s0)
    80005344:	a069                	j	800053ce <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005346:	fe043783          	ld	a5,-32(s0)
    8000534a:	eb89                	bnez	a5,8000535c <iget+0xa0>
    8000534c:	fe843783          	ld	a5,-24(s0)
    80005350:	479c                	lw	a5,8(a5)
    80005352:	e789                	bnez	a5,8000535c <iget+0xa0>
      empty = ip;
    80005354:	fe843783          	ld	a5,-24(s0)
    80005358:	fef43023          	sd	a5,-32(s0)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    8000535c:	fe843783          	ld	a5,-24(s0)
    80005360:	08878793          	addi	a5,a5,136
    80005364:	fef43423          	sd	a5,-24(s0)
    80005368:	fe843703          	ld	a4,-24(s0)
    8000536c:	00069797          	auipc	a5,0x69
    80005370:	8e478793          	addi	a5,a5,-1820 # 8006dc50 <log>
    80005374:	f8f760e3          	bltu	a4,a5,800052f4 <iget+0x38>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    80005378:	fe043783          	ld	a5,-32(s0)
    8000537c:	eb89                	bnez	a5,8000538e <iget+0xd2>
    panic("iget: no inodes");
    8000537e:	00006517          	auipc	a0,0x6
    80005382:	11a50513          	addi	a0,a0,282 # 8000b498 <etext+0x498>
    80005386:	ffffc097          	auipc	ra,0xffffc
    8000538a:	8cc080e7          	jalr	-1844(ra) # 80000c52 <panic>

  ip = empty;
    8000538e:	fe043783          	ld	a5,-32(s0)
    80005392:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005396:	fe843783          	ld	a5,-24(s0)
    8000539a:	fdc42703          	lw	a4,-36(s0)
    8000539e:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    800053a0:	fe843783          	ld	a5,-24(s0)
    800053a4:	fd842703          	lw	a4,-40(s0)
    800053a8:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    800053aa:	fe843783          	ld	a5,-24(s0)
    800053ae:	4705                	li	a4,1
    800053b0:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    800053b2:	fe843783          	ld	a5,-24(s0)
    800053b6:	0407a023          	sw	zero,64(a5)
  release(&icache.lock);
    800053ba:	00067517          	auipc	a0,0x67
    800053be:	dee50513          	addi	a0,a0,-530 # 8006c1a8 <icache>
    800053c2:	ffffc097          	auipc	ra,0xffffc
    800053c6:	f22080e7          	jalr	-222(ra) # 800012e4 <release>

  return ip;
    800053ca:	fe843783          	ld	a5,-24(s0)
}
    800053ce:	853e                	mv	a0,a5
    800053d0:	70a2                	ld	ra,40(sp)
    800053d2:	7402                	ld	s0,32(sp)
    800053d4:	6145                	addi	sp,sp,48
    800053d6:	8082                	ret

00000000800053d8 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    800053d8:	1101                	addi	sp,sp,-32
    800053da:	ec06                	sd	ra,24(sp)
    800053dc:	e822                	sd	s0,16(sp)
    800053de:	1000                	addi	s0,sp,32
    800053e0:	fea43423          	sd	a0,-24(s0)
  acquire(&icache.lock);
    800053e4:	00067517          	auipc	a0,0x67
    800053e8:	dc450513          	addi	a0,a0,-572 # 8006c1a8 <icache>
    800053ec:	ffffc097          	auipc	ra,0xffffc
    800053f0:	e94080e7          	jalr	-364(ra) # 80001280 <acquire>
  ip->ref++;
    800053f4:	fe843783          	ld	a5,-24(s0)
    800053f8:	479c                	lw	a5,8(a5)
    800053fa:	2785                	addiw	a5,a5,1
    800053fc:	0007871b          	sext.w	a4,a5
    80005400:	fe843783          	ld	a5,-24(s0)
    80005404:	c798                	sw	a4,8(a5)
  release(&icache.lock);
    80005406:	00067517          	auipc	a0,0x67
    8000540a:	da250513          	addi	a0,a0,-606 # 8006c1a8 <icache>
    8000540e:	ffffc097          	auipc	ra,0xffffc
    80005412:	ed6080e7          	jalr	-298(ra) # 800012e4 <release>
  return ip;
    80005416:	fe843783          	ld	a5,-24(s0)
}
    8000541a:	853e                	mv	a0,a5
    8000541c:	60e2                	ld	ra,24(sp)
    8000541e:	6442                	ld	s0,16(sp)
    80005420:	6105                	addi	sp,sp,32
    80005422:	8082                	ret

0000000080005424 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005424:	7179                	addi	sp,sp,-48
    80005426:	f406                	sd	ra,40(sp)
    80005428:	f022                	sd	s0,32(sp)
    8000542a:	1800                	addi	s0,sp,48
    8000542c:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80005430:	fd843783          	ld	a5,-40(s0)
    80005434:	c791                	beqz	a5,80005440 <ilock+0x1c>
    80005436:	fd843783          	ld	a5,-40(s0)
    8000543a:	479c                	lw	a5,8(a5)
    8000543c:	00f04a63          	bgtz	a5,80005450 <ilock+0x2c>
    panic("ilock");
    80005440:	00006517          	auipc	a0,0x6
    80005444:	06850513          	addi	a0,a0,104 # 8000b4a8 <etext+0x4a8>
    80005448:	ffffc097          	auipc	ra,0xffffc
    8000544c:	80a080e7          	jalr	-2038(ra) # 80000c52 <panic>

  acquiresleep(&ip->lock);
    80005450:	fd843783          	ld	a5,-40(s0)
    80005454:	07c1                	addi	a5,a5,16
    80005456:	853e                	mv	a0,a5
    80005458:	00001097          	auipc	ra,0x1
    8000545c:	496080e7          	jalr	1174(ra) # 800068ee <acquiresleep>

  if(ip->valid == 0){
    80005460:	fd843783          	ld	a5,-40(s0)
    80005464:	43bc                	lw	a5,64(a5)
    80005466:	e7e5                	bnez	a5,8000554e <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005468:	fd843783          	ld	a5,-40(s0)
    8000546c:	4394                	lw	a3,0(a5)
    8000546e:	fd843783          	ld	a5,-40(s0)
    80005472:	43dc                	lw	a5,4(a5)
    80005474:	0047d79b          	srliw	a5,a5,0x4
    80005478:	0007871b          	sext.w	a4,a5
    8000547c:	00067797          	auipc	a5,0x67
    80005480:	d0c78793          	addi	a5,a5,-756 # 8006c188 <sb>
    80005484:	4f9c                	lw	a5,24(a5)
    80005486:	9fb9                	addw	a5,a5,a4
    80005488:	2781                	sext.w	a5,a5
    8000548a:	85be                	mv	a1,a5
    8000548c:	8536                	mv	a0,a3
    8000548e:	fffff097          	auipc	ra,0xfffff
    80005492:	5ae080e7          	jalr	1454(ra) # 80004a3c <bread>
    80005496:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000549a:	fe843783          	ld	a5,-24(s0)
    8000549e:	05878713          	addi	a4,a5,88
    800054a2:	fd843783          	ld	a5,-40(s0)
    800054a6:	43dc                	lw	a5,4(a5)
    800054a8:	1782                	slli	a5,a5,0x20
    800054aa:	9381                	srli	a5,a5,0x20
    800054ac:	8bbd                	andi	a5,a5,15
    800054ae:	079a                	slli	a5,a5,0x6
    800054b0:	97ba                	add	a5,a5,a4
    800054b2:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    800054b6:	fe043783          	ld	a5,-32(s0)
    800054ba:	00079703          	lh	a4,0(a5)
    800054be:	fd843783          	ld	a5,-40(s0)
    800054c2:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    800054c6:	fe043783          	ld	a5,-32(s0)
    800054ca:	00279703          	lh	a4,2(a5)
    800054ce:	fd843783          	ld	a5,-40(s0)
    800054d2:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    800054d6:	fe043783          	ld	a5,-32(s0)
    800054da:	00479703          	lh	a4,4(a5)
    800054de:	fd843783          	ld	a5,-40(s0)
    800054e2:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    800054e6:	fe043783          	ld	a5,-32(s0)
    800054ea:	00679703          	lh	a4,6(a5)
    800054ee:	fd843783          	ld	a5,-40(s0)
    800054f2:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    800054f6:	fe043783          	ld	a5,-32(s0)
    800054fa:	4798                	lw	a4,8(a5)
    800054fc:	fd843783          	ld	a5,-40(s0)
    80005500:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005502:	fd843783          	ld	a5,-40(s0)
    80005506:	05078713          	addi	a4,a5,80
    8000550a:	fe043783          	ld	a5,-32(s0)
    8000550e:	07b1                	addi	a5,a5,12
    80005510:	03400613          	li	a2,52
    80005514:	85be                	mv	a1,a5
    80005516:	853a                	mv	a0,a4
    80005518:	ffffc097          	auipc	ra,0xffffc
    8000551c:	020080e7          	jalr	32(ra) # 80001538 <memmove>
    brelse(bp);
    80005520:	fe843503          	ld	a0,-24(s0)
    80005524:	fffff097          	auipc	ra,0xfffff
    80005528:	5ba080e7          	jalr	1466(ra) # 80004ade <brelse>
    ip->valid = 1;
    8000552c:	fd843783          	ld	a5,-40(s0)
    80005530:	4705                	li	a4,1
    80005532:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005534:	fd843783          	ld	a5,-40(s0)
    80005538:	04479783          	lh	a5,68(a5)
    8000553c:	eb89                	bnez	a5,8000554e <ilock+0x12a>
      panic("ilock: no type");
    8000553e:	00006517          	auipc	a0,0x6
    80005542:	f7250513          	addi	a0,a0,-142 # 8000b4b0 <etext+0x4b0>
    80005546:	ffffb097          	auipc	ra,0xffffb
    8000554a:	70c080e7          	jalr	1804(ra) # 80000c52 <panic>
  }
}
    8000554e:	0001                	nop
    80005550:	70a2                	ld	ra,40(sp)
    80005552:	7402                	ld	s0,32(sp)
    80005554:	6145                	addi	sp,sp,48
    80005556:	8082                	ret

0000000080005558 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005558:	1101                	addi	sp,sp,-32
    8000555a:	ec06                	sd	ra,24(sp)
    8000555c:	e822                	sd	s0,16(sp)
    8000555e:	1000                	addi	s0,sp,32
    80005560:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005564:	fe843783          	ld	a5,-24(s0)
    80005568:	c385                	beqz	a5,80005588 <iunlock+0x30>
    8000556a:	fe843783          	ld	a5,-24(s0)
    8000556e:	07c1                	addi	a5,a5,16
    80005570:	853e                	mv	a0,a5
    80005572:	00001097          	auipc	ra,0x1
    80005576:	43c080e7          	jalr	1084(ra) # 800069ae <holdingsleep>
    8000557a:	87aa                	mv	a5,a0
    8000557c:	c791                	beqz	a5,80005588 <iunlock+0x30>
    8000557e:	fe843783          	ld	a5,-24(s0)
    80005582:	479c                	lw	a5,8(a5)
    80005584:	00f04a63          	bgtz	a5,80005598 <iunlock+0x40>
    panic("iunlock");
    80005588:	00006517          	auipc	a0,0x6
    8000558c:	f3850513          	addi	a0,a0,-200 # 8000b4c0 <etext+0x4c0>
    80005590:	ffffb097          	auipc	ra,0xffffb
    80005594:	6c2080e7          	jalr	1730(ra) # 80000c52 <panic>

  releasesleep(&ip->lock);
    80005598:	fe843783          	ld	a5,-24(s0)
    8000559c:	07c1                	addi	a5,a5,16
    8000559e:	853e                	mv	a0,a5
    800055a0:	00001097          	auipc	ra,0x1
    800055a4:	3bc080e7          	jalr	956(ra) # 8000695c <releasesleep>
}
    800055a8:	0001                	nop
    800055aa:	60e2                	ld	ra,24(sp)
    800055ac:	6442                	ld	s0,16(sp)
    800055ae:	6105                	addi	sp,sp,32
    800055b0:	8082                	ret

00000000800055b2 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800055b2:	1101                	addi	sp,sp,-32
    800055b4:	ec06                	sd	ra,24(sp)
    800055b6:	e822                	sd	s0,16(sp)
    800055b8:	1000                	addi	s0,sp,32
    800055ba:	fea43423          	sd	a0,-24(s0)
  acquire(&icache.lock);
    800055be:	00067517          	auipc	a0,0x67
    800055c2:	bea50513          	addi	a0,a0,-1046 # 8006c1a8 <icache>
    800055c6:	ffffc097          	auipc	ra,0xffffc
    800055ca:	cba080e7          	jalr	-838(ra) # 80001280 <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800055ce:	fe843783          	ld	a5,-24(s0)
    800055d2:	479c                	lw	a5,8(a5)
    800055d4:	873e                	mv	a4,a5
    800055d6:	4785                	li	a5,1
    800055d8:	06f71f63          	bne	a4,a5,80005656 <iput+0xa4>
    800055dc:	fe843783          	ld	a5,-24(s0)
    800055e0:	43bc                	lw	a5,64(a5)
    800055e2:	cbb5                	beqz	a5,80005656 <iput+0xa4>
    800055e4:	fe843783          	ld	a5,-24(s0)
    800055e8:	04a79783          	lh	a5,74(a5)
    800055ec:	e7ad                	bnez	a5,80005656 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    800055ee:	fe843783          	ld	a5,-24(s0)
    800055f2:	07c1                	addi	a5,a5,16
    800055f4:	853e                	mv	a0,a5
    800055f6:	00001097          	auipc	ra,0x1
    800055fa:	2f8080e7          	jalr	760(ra) # 800068ee <acquiresleep>

    release(&icache.lock);
    800055fe:	00067517          	auipc	a0,0x67
    80005602:	baa50513          	addi	a0,a0,-1110 # 8006c1a8 <icache>
    80005606:	ffffc097          	auipc	ra,0xffffc
    8000560a:	cde080e7          	jalr	-802(ra) # 800012e4 <release>

    itrunc(ip);
    8000560e:	fe843503          	ld	a0,-24(s0)
    80005612:	00000097          	auipc	ra,0x0
    80005616:	1fa080e7          	jalr	506(ra) # 8000580c <itrunc>
    ip->type = 0;
    8000561a:	fe843783          	ld	a5,-24(s0)
    8000561e:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005622:	fe843503          	ld	a0,-24(s0)
    80005626:	00000097          	auipc	ra,0x0
    8000562a:	bae080e7          	jalr	-1106(ra) # 800051d4 <iupdate>
    ip->valid = 0;
    8000562e:	fe843783          	ld	a5,-24(s0)
    80005632:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005636:	fe843783          	ld	a5,-24(s0)
    8000563a:	07c1                	addi	a5,a5,16
    8000563c:	853e                	mv	a0,a5
    8000563e:	00001097          	auipc	ra,0x1
    80005642:	31e080e7          	jalr	798(ra) # 8000695c <releasesleep>

    acquire(&icache.lock);
    80005646:	00067517          	auipc	a0,0x67
    8000564a:	b6250513          	addi	a0,a0,-1182 # 8006c1a8 <icache>
    8000564e:	ffffc097          	auipc	ra,0xffffc
    80005652:	c32080e7          	jalr	-974(ra) # 80001280 <acquire>
  }

  ip->ref--;
    80005656:	fe843783          	ld	a5,-24(s0)
    8000565a:	479c                	lw	a5,8(a5)
    8000565c:	37fd                	addiw	a5,a5,-1
    8000565e:	0007871b          	sext.w	a4,a5
    80005662:	fe843783          	ld	a5,-24(s0)
    80005666:	c798                	sw	a4,8(a5)
  release(&icache.lock);
    80005668:	00067517          	auipc	a0,0x67
    8000566c:	b4050513          	addi	a0,a0,-1216 # 8006c1a8 <icache>
    80005670:	ffffc097          	auipc	ra,0xffffc
    80005674:	c74080e7          	jalr	-908(ra) # 800012e4 <release>
}
    80005678:	0001                	nop
    8000567a:	60e2                	ld	ra,24(sp)
    8000567c:	6442                	ld	s0,16(sp)
    8000567e:	6105                	addi	sp,sp,32
    80005680:	8082                	ret

0000000080005682 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005682:	1101                	addi	sp,sp,-32
    80005684:	ec06                	sd	ra,24(sp)
    80005686:	e822                	sd	s0,16(sp)
    80005688:	1000                	addi	s0,sp,32
    8000568a:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    8000568e:	fe843503          	ld	a0,-24(s0)
    80005692:	00000097          	auipc	ra,0x0
    80005696:	ec6080e7          	jalr	-314(ra) # 80005558 <iunlock>
  iput(ip);
    8000569a:	fe843503          	ld	a0,-24(s0)
    8000569e:	00000097          	auipc	ra,0x0
    800056a2:	f14080e7          	jalr	-236(ra) # 800055b2 <iput>
}
    800056a6:	0001                	nop
    800056a8:	60e2                	ld	ra,24(sp)
    800056aa:	6442                	ld	s0,16(sp)
    800056ac:	6105                	addi	sp,sp,32
    800056ae:	8082                	ret

00000000800056b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    800056b0:	7139                	addi	sp,sp,-64
    800056b2:	fc06                	sd	ra,56(sp)
    800056b4:	f822                	sd	s0,48(sp)
    800056b6:	0080                	addi	s0,sp,64
    800056b8:	fca43423          	sd	a0,-56(s0)
    800056bc:	87ae                	mv	a5,a1
    800056be:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800056c2:	fc442783          	lw	a5,-60(s0)
    800056c6:	0007871b          	sext.w	a4,a5
    800056ca:	47ad                	li	a5,11
    800056cc:	04e7e863          	bltu	a5,a4,8000571c <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    800056d0:	fc843703          	ld	a4,-56(s0)
    800056d4:	fc446783          	lwu	a5,-60(s0)
    800056d8:	07d1                	addi	a5,a5,20
    800056da:	078a                	slli	a5,a5,0x2
    800056dc:	97ba                	add	a5,a5,a4
    800056de:	439c                	lw	a5,0(a5)
    800056e0:	fef42623          	sw	a5,-20(s0)
    800056e4:	fec42783          	lw	a5,-20(s0)
    800056e8:	2781                	sext.w	a5,a5
    800056ea:	e795                	bnez	a5,80005716 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800056ec:	fc843783          	ld	a5,-56(s0)
    800056f0:	439c                	lw	a5,0(a5)
    800056f2:	853e                	mv	a0,a5
    800056f4:	fffff097          	auipc	ra,0xfffff
    800056f8:	692080e7          	jalr	1682(ra) # 80004d86 <balloc>
    800056fc:	87aa                	mv	a5,a0
    800056fe:	fef42623          	sw	a5,-20(s0)
    80005702:	fc843703          	ld	a4,-56(s0)
    80005706:	fc446783          	lwu	a5,-60(s0)
    8000570a:	07d1                	addi	a5,a5,20
    8000570c:	078a                	slli	a5,a5,0x2
    8000570e:	97ba                	add	a5,a5,a4
    80005710:	fec42703          	lw	a4,-20(s0)
    80005714:	c398                	sw	a4,0(a5)
    return addr;
    80005716:	fec42783          	lw	a5,-20(s0)
    8000571a:	a0e5                	j	80005802 <bmap+0x152>
  }
  bn -= NDIRECT;
    8000571c:	fc442783          	lw	a5,-60(s0)
    80005720:	37d1                	addiw	a5,a5,-12
    80005722:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80005726:	fc442783          	lw	a5,-60(s0)
    8000572a:	0007871b          	sext.w	a4,a5
    8000572e:	0ff00793          	li	a5,255
    80005732:	0ce7e063          	bltu	a5,a4,800057f2 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80005736:	fc843783          	ld	a5,-56(s0)
    8000573a:	0807a783          	lw	a5,128(a5)
    8000573e:	fef42623          	sw	a5,-20(s0)
    80005742:	fec42783          	lw	a5,-20(s0)
    80005746:	2781                	sext.w	a5,a5
    80005748:	e395                	bnez	a5,8000576c <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    8000574a:	fc843783          	ld	a5,-56(s0)
    8000574e:	439c                	lw	a5,0(a5)
    80005750:	853e                	mv	a0,a5
    80005752:	fffff097          	auipc	ra,0xfffff
    80005756:	634080e7          	jalr	1588(ra) # 80004d86 <balloc>
    8000575a:	87aa                	mv	a5,a0
    8000575c:	fef42623          	sw	a5,-20(s0)
    80005760:	fc843783          	ld	a5,-56(s0)
    80005764:	fec42703          	lw	a4,-20(s0)
    80005768:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    8000576c:	fc843783          	ld	a5,-56(s0)
    80005770:	439c                	lw	a5,0(a5)
    80005772:	fec42703          	lw	a4,-20(s0)
    80005776:	85ba                	mv	a1,a4
    80005778:	853e                	mv	a0,a5
    8000577a:	fffff097          	auipc	ra,0xfffff
    8000577e:	2c2080e7          	jalr	706(ra) # 80004a3c <bread>
    80005782:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005786:	fe043783          	ld	a5,-32(s0)
    8000578a:	05878793          	addi	a5,a5,88
    8000578e:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    80005792:	fc446783          	lwu	a5,-60(s0)
    80005796:	078a                	slli	a5,a5,0x2
    80005798:	fd843703          	ld	a4,-40(s0)
    8000579c:	97ba                	add	a5,a5,a4
    8000579e:	439c                	lw	a5,0(a5)
    800057a0:	fef42623          	sw	a5,-20(s0)
    800057a4:	fec42783          	lw	a5,-20(s0)
    800057a8:	2781                	sext.w	a5,a5
    800057aa:	eb9d                	bnez	a5,800057e0 <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    800057ac:	fc843783          	ld	a5,-56(s0)
    800057b0:	439c                	lw	a5,0(a5)
    800057b2:	853e                	mv	a0,a5
    800057b4:	fffff097          	auipc	ra,0xfffff
    800057b8:	5d2080e7          	jalr	1490(ra) # 80004d86 <balloc>
    800057bc:	87aa                	mv	a5,a0
    800057be:	fef42623          	sw	a5,-20(s0)
    800057c2:	fc446783          	lwu	a5,-60(s0)
    800057c6:	078a                	slli	a5,a5,0x2
    800057c8:	fd843703          	ld	a4,-40(s0)
    800057cc:	97ba                	add	a5,a5,a4
    800057ce:	fec42703          	lw	a4,-20(s0)
    800057d2:	c398                	sw	a4,0(a5)
      log_write(bp);
    800057d4:	fe043503          	ld	a0,-32(s0)
    800057d8:	00001097          	auipc	ra,0x1
    800057dc:	f96080e7          	jalr	-106(ra) # 8000676e <log_write>
    }
    brelse(bp);
    800057e0:	fe043503          	ld	a0,-32(s0)
    800057e4:	fffff097          	auipc	ra,0xfffff
    800057e8:	2fa080e7          	jalr	762(ra) # 80004ade <brelse>
    return addr;
    800057ec:	fec42783          	lw	a5,-20(s0)
    800057f0:	a809                	j	80005802 <bmap+0x152>
  }

  panic("bmap: out of range");
    800057f2:	00006517          	auipc	a0,0x6
    800057f6:	cd650513          	addi	a0,a0,-810 # 8000b4c8 <etext+0x4c8>
    800057fa:	ffffb097          	auipc	ra,0xffffb
    800057fe:	458080e7          	jalr	1112(ra) # 80000c52 <panic>
}
    80005802:	853e                	mv	a0,a5
    80005804:	70e2                	ld	ra,56(sp)
    80005806:	7442                	ld	s0,48(sp)
    80005808:	6121                	addi	sp,sp,64
    8000580a:	8082                	ret

000000008000580c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000580c:	7139                	addi	sp,sp,-64
    8000580e:	fc06                	sd	ra,56(sp)
    80005810:	f822                	sd	s0,48(sp)
    80005812:	0080                	addi	s0,sp,64
    80005814:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005818:	fe042623          	sw	zero,-20(s0)
    8000581c:	a899                	j	80005872 <itrunc+0x66>
    if(ip->addrs[i]){
    8000581e:	fc843703          	ld	a4,-56(s0)
    80005822:	fec42783          	lw	a5,-20(s0)
    80005826:	07d1                	addi	a5,a5,20
    80005828:	078a                	slli	a5,a5,0x2
    8000582a:	97ba                	add	a5,a5,a4
    8000582c:	439c                	lw	a5,0(a5)
    8000582e:	cf8d                	beqz	a5,80005868 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    80005830:	fc843783          	ld	a5,-56(s0)
    80005834:	439c                	lw	a5,0(a5)
    80005836:	0007869b          	sext.w	a3,a5
    8000583a:	fc843703          	ld	a4,-56(s0)
    8000583e:	fec42783          	lw	a5,-20(s0)
    80005842:	07d1                	addi	a5,a5,20
    80005844:	078a                	slli	a5,a5,0x2
    80005846:	97ba                	add	a5,a5,a4
    80005848:	439c                	lw	a5,0(a5)
    8000584a:	85be                	mv	a1,a5
    8000584c:	8536                	mv	a0,a3
    8000584e:	fffff097          	auipc	ra,0xfffff
    80005852:	6e6080e7          	jalr	1766(ra) # 80004f34 <bfree>
      ip->addrs[i] = 0;
    80005856:	fc843703          	ld	a4,-56(s0)
    8000585a:	fec42783          	lw	a5,-20(s0)
    8000585e:	07d1                	addi	a5,a5,20
    80005860:	078a                	slli	a5,a5,0x2
    80005862:	97ba                	add	a5,a5,a4
    80005864:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005868:	fec42783          	lw	a5,-20(s0)
    8000586c:	2785                	addiw	a5,a5,1
    8000586e:	fef42623          	sw	a5,-20(s0)
    80005872:	fec42783          	lw	a5,-20(s0)
    80005876:	0007871b          	sext.w	a4,a5
    8000587a:	47ad                	li	a5,11
    8000587c:	fae7d1e3          	bge	a5,a4,8000581e <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    80005880:	fc843783          	ld	a5,-56(s0)
    80005884:	0807a783          	lw	a5,128(a5)
    80005888:	cbc5                	beqz	a5,80005938 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000588a:	fc843783          	ld	a5,-56(s0)
    8000588e:	4398                	lw	a4,0(a5)
    80005890:	fc843783          	ld	a5,-56(s0)
    80005894:	0807a783          	lw	a5,128(a5)
    80005898:	85be                	mv	a1,a5
    8000589a:	853a                	mv	a0,a4
    8000589c:	fffff097          	auipc	ra,0xfffff
    800058a0:	1a0080e7          	jalr	416(ra) # 80004a3c <bread>
    800058a4:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800058a8:	fe043783          	ld	a5,-32(s0)
    800058ac:	05878793          	addi	a5,a5,88
    800058b0:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    800058b4:	fe042423          	sw	zero,-24(s0)
    800058b8:	a081                	j	800058f8 <itrunc+0xec>
      if(a[j])
    800058ba:	fe842783          	lw	a5,-24(s0)
    800058be:	078a                	slli	a5,a5,0x2
    800058c0:	fd843703          	ld	a4,-40(s0)
    800058c4:	97ba                	add	a5,a5,a4
    800058c6:	439c                	lw	a5,0(a5)
    800058c8:	c39d                	beqz	a5,800058ee <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    800058ca:	fc843783          	ld	a5,-56(s0)
    800058ce:	439c                	lw	a5,0(a5)
    800058d0:	0007869b          	sext.w	a3,a5
    800058d4:	fe842783          	lw	a5,-24(s0)
    800058d8:	078a                	slli	a5,a5,0x2
    800058da:	fd843703          	ld	a4,-40(s0)
    800058de:	97ba                	add	a5,a5,a4
    800058e0:	439c                	lw	a5,0(a5)
    800058e2:	85be                	mv	a1,a5
    800058e4:	8536                	mv	a0,a3
    800058e6:	fffff097          	auipc	ra,0xfffff
    800058ea:	64e080e7          	jalr	1614(ra) # 80004f34 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800058ee:	fe842783          	lw	a5,-24(s0)
    800058f2:	2785                	addiw	a5,a5,1
    800058f4:	fef42423          	sw	a5,-24(s0)
    800058f8:	fe842783          	lw	a5,-24(s0)
    800058fc:	873e                	mv	a4,a5
    800058fe:	0ff00793          	li	a5,255
    80005902:	fae7fce3          	bgeu	a5,a4,800058ba <itrunc+0xae>
    }
    brelse(bp);
    80005906:	fe043503          	ld	a0,-32(s0)
    8000590a:	fffff097          	auipc	ra,0xfffff
    8000590e:	1d4080e7          	jalr	468(ra) # 80004ade <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80005912:	fc843783          	ld	a5,-56(s0)
    80005916:	439c                	lw	a5,0(a5)
    80005918:	0007871b          	sext.w	a4,a5
    8000591c:	fc843783          	ld	a5,-56(s0)
    80005920:	0807a783          	lw	a5,128(a5)
    80005924:	85be                	mv	a1,a5
    80005926:	853a                	mv	a0,a4
    80005928:	fffff097          	auipc	ra,0xfffff
    8000592c:	60c080e7          	jalr	1548(ra) # 80004f34 <bfree>
    ip->addrs[NDIRECT] = 0;
    80005930:	fc843783          	ld	a5,-56(s0)
    80005934:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005938:	fc843783          	ld	a5,-56(s0)
    8000593c:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    80005940:	fc843503          	ld	a0,-56(s0)
    80005944:	00000097          	auipc	ra,0x0
    80005948:	890080e7          	jalr	-1904(ra) # 800051d4 <iupdate>
}
    8000594c:	0001                	nop
    8000594e:	70e2                	ld	ra,56(sp)
    80005950:	7442                	ld	s0,48(sp)
    80005952:	6121                	addi	sp,sp,64
    80005954:	8082                	ret

0000000080005956 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80005956:	1101                	addi	sp,sp,-32
    80005958:	ec22                	sd	s0,24(sp)
    8000595a:	1000                	addi	s0,sp,32
    8000595c:	fea43423          	sd	a0,-24(s0)
    80005960:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    80005964:	fe843783          	ld	a5,-24(s0)
    80005968:	439c                	lw	a5,0(a5)
    8000596a:	0007871b          	sext.w	a4,a5
    8000596e:	fe043783          	ld	a5,-32(s0)
    80005972:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80005974:	fe843783          	ld	a5,-24(s0)
    80005978:	43d8                	lw	a4,4(a5)
    8000597a:	fe043783          	ld	a5,-32(s0)
    8000597e:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    80005980:	fe843783          	ld	a5,-24(s0)
    80005984:	04479703          	lh	a4,68(a5)
    80005988:	fe043783          	ld	a5,-32(s0)
    8000598c:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    80005990:	fe843783          	ld	a5,-24(s0)
    80005994:	04a79703          	lh	a4,74(a5)
    80005998:	fe043783          	ld	a5,-32(s0)
    8000599c:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    800059a0:	fe843783          	ld	a5,-24(s0)
    800059a4:	47fc                	lw	a5,76(a5)
    800059a6:	02079713          	slli	a4,a5,0x20
    800059aa:	9301                	srli	a4,a4,0x20
    800059ac:	fe043783          	ld	a5,-32(s0)
    800059b0:	eb98                	sd	a4,16(a5)
}
    800059b2:	0001                	nop
    800059b4:	6462                	ld	s0,24(sp)
    800059b6:	6105                	addi	sp,sp,32
    800059b8:	8082                	ret

00000000800059ba <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800059ba:	711d                	addi	sp,sp,-96
    800059bc:	ec86                	sd	ra,88(sp)
    800059be:	e8a2                	sd	s0,80(sp)
    800059c0:	e4a6                	sd	s1,72(sp)
    800059c2:	1080                	addi	s0,sp,96
    800059c4:	faa43c23          	sd	a0,-72(s0)
    800059c8:	87ae                	mv	a5,a1
    800059ca:	fac43423          	sd	a2,-88(s0)
    800059ce:	faf42a23          	sw	a5,-76(s0)
    800059d2:	87b6                	mv	a5,a3
    800059d4:	faf42823          	sw	a5,-80(s0)
    800059d8:	87ba                	mv	a5,a4
    800059da:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800059de:	fb843783          	ld	a5,-72(s0)
    800059e2:	47f8                	lw	a4,76(a5)
    800059e4:	fb042783          	lw	a5,-80(s0)
    800059e8:	2781                	sext.w	a5,a5
    800059ea:	00f76e63          	bltu	a4,a5,80005a06 <readi+0x4c>
    800059ee:	fb042703          	lw	a4,-80(s0)
    800059f2:	fa442783          	lw	a5,-92(s0)
    800059f6:	9fb9                	addw	a5,a5,a4
    800059f8:	0007871b          	sext.w	a4,a5
    800059fc:	fb042783          	lw	a5,-80(s0)
    80005a00:	2781                	sext.w	a5,a5
    80005a02:	00f77463          	bgeu	a4,a5,80005a0a <readi+0x50>
    return 0;
    80005a06:	4781                	li	a5,0
    80005a08:	aa05                	j	80005b38 <readi+0x17e>
  if(off + n > ip->size)
    80005a0a:	fb042703          	lw	a4,-80(s0)
    80005a0e:	fa442783          	lw	a5,-92(s0)
    80005a12:	9fb9                	addw	a5,a5,a4
    80005a14:	0007871b          	sext.w	a4,a5
    80005a18:	fb843783          	ld	a5,-72(s0)
    80005a1c:	47fc                	lw	a5,76(a5)
    80005a1e:	00e7fb63          	bgeu	a5,a4,80005a34 <readi+0x7a>
    n = ip->size - off;
    80005a22:	fb843783          	ld	a5,-72(s0)
    80005a26:	47f8                	lw	a4,76(a5)
    80005a28:	fb042783          	lw	a5,-80(s0)
    80005a2c:	40f707bb          	subw	a5,a4,a5
    80005a30:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005a34:	fc042e23          	sw	zero,-36(s0)
    80005a38:	a0f5                	j	80005b24 <readi+0x16a>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005a3a:	fb843783          	ld	a5,-72(s0)
    80005a3e:	4384                	lw	s1,0(a5)
    80005a40:	fb042783          	lw	a5,-80(s0)
    80005a44:	00a7d79b          	srliw	a5,a5,0xa
    80005a48:	2781                	sext.w	a5,a5
    80005a4a:	85be                	mv	a1,a5
    80005a4c:	fb843503          	ld	a0,-72(s0)
    80005a50:	00000097          	auipc	ra,0x0
    80005a54:	c60080e7          	jalr	-928(ra) # 800056b0 <bmap>
    80005a58:	87aa                	mv	a5,a0
    80005a5a:	2781                	sext.w	a5,a5
    80005a5c:	85be                	mv	a1,a5
    80005a5e:	8526                	mv	a0,s1
    80005a60:	fffff097          	auipc	ra,0xfffff
    80005a64:	fdc080e7          	jalr	-36(ra) # 80004a3c <bread>
    80005a68:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005a6c:	fb042783          	lw	a5,-80(s0)
    80005a70:	3ff7f793          	andi	a5,a5,1023
    80005a74:	2781                	sext.w	a5,a5
    80005a76:	40000713          	li	a4,1024
    80005a7a:	40f707bb          	subw	a5,a4,a5
    80005a7e:	0007869b          	sext.w	a3,a5
    80005a82:	fa442703          	lw	a4,-92(s0)
    80005a86:	fdc42783          	lw	a5,-36(s0)
    80005a8a:	40f707bb          	subw	a5,a4,a5
    80005a8e:	2781                	sext.w	a5,a5
    80005a90:	863e                	mv	a2,a5
    80005a92:	87b6                	mv	a5,a3
    80005a94:	0007869b          	sext.w	a3,a5
    80005a98:	0006071b          	sext.w	a4,a2
    80005a9c:	00d77363          	bgeu	a4,a3,80005aa2 <readi+0xe8>
    80005aa0:	87b2                	mv	a5,a2
    80005aa2:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80005aa6:	fd043783          	ld	a5,-48(s0)
    80005aaa:	05878713          	addi	a4,a5,88
    80005aae:	fb046783          	lwu	a5,-80(s0)
    80005ab2:	3ff7f793          	andi	a5,a5,1023
    80005ab6:	973e                	add	a4,a4,a5
    80005ab8:	fcc46683          	lwu	a3,-52(s0)
    80005abc:	fb442783          	lw	a5,-76(s0)
    80005ac0:	863a                	mv	a2,a4
    80005ac2:	fa843583          	ld	a1,-88(s0)
    80005ac6:	853e                	mv	a0,a5
    80005ac8:	ffffe097          	auipc	ra,0xffffe
    80005acc:	c96080e7          	jalr	-874(ra) # 8000375e <either_copyout>
    80005ad0:	87aa                	mv	a5,a0
    80005ad2:	873e                	mv	a4,a5
    80005ad4:	57fd                	li	a5,-1
    80005ad6:	00f71c63          	bne	a4,a5,80005aee <readi+0x134>
      brelse(bp);
    80005ada:	fd043503          	ld	a0,-48(s0)
    80005ade:	fffff097          	auipc	ra,0xfffff
    80005ae2:	000080e7          	jalr	ra # 80004ade <brelse>
      tot = -1;
    80005ae6:	57fd                	li	a5,-1
    80005ae8:	fcf42e23          	sw	a5,-36(s0)
      break;
    80005aec:	a0a1                	j	80005b34 <readi+0x17a>
    }
    brelse(bp);
    80005aee:	fd043503          	ld	a0,-48(s0)
    80005af2:	fffff097          	auipc	ra,0xfffff
    80005af6:	fec080e7          	jalr	-20(ra) # 80004ade <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005afa:	fdc42703          	lw	a4,-36(s0)
    80005afe:	fcc42783          	lw	a5,-52(s0)
    80005b02:	9fb9                	addw	a5,a5,a4
    80005b04:	fcf42e23          	sw	a5,-36(s0)
    80005b08:	fb042703          	lw	a4,-80(s0)
    80005b0c:	fcc42783          	lw	a5,-52(s0)
    80005b10:	9fb9                	addw	a5,a5,a4
    80005b12:	faf42823          	sw	a5,-80(s0)
    80005b16:	fcc46783          	lwu	a5,-52(s0)
    80005b1a:	fa843703          	ld	a4,-88(s0)
    80005b1e:	97ba                	add	a5,a5,a4
    80005b20:	faf43423          	sd	a5,-88(s0)
    80005b24:	fdc42703          	lw	a4,-36(s0)
    80005b28:	fa442783          	lw	a5,-92(s0)
    80005b2c:	2701                	sext.w	a4,a4
    80005b2e:	2781                	sext.w	a5,a5
    80005b30:	f0f765e3          	bltu	a4,a5,80005a3a <readi+0x80>
  }
  return tot;
    80005b34:	fdc42783          	lw	a5,-36(s0)
}
    80005b38:	853e                	mv	a0,a5
    80005b3a:	60e6                	ld	ra,88(sp)
    80005b3c:	6446                	ld	s0,80(sp)
    80005b3e:	64a6                	ld	s1,72(sp)
    80005b40:	6125                	addi	sp,sp,96
    80005b42:	8082                	ret

0000000080005b44 <writei>:
// Caller must hold ip->lock.
// If user_src==1, then src is a user virtual address;
// otherwise, src is a kernel address.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005b44:	711d                	addi	sp,sp,-96
    80005b46:	ec86                	sd	ra,88(sp)
    80005b48:	e8a2                	sd	s0,80(sp)
    80005b4a:	e4a6                	sd	s1,72(sp)
    80005b4c:	1080                	addi	s0,sp,96
    80005b4e:	faa43c23          	sd	a0,-72(s0)
    80005b52:	87ae                	mv	a5,a1
    80005b54:	fac43423          	sd	a2,-88(s0)
    80005b58:	faf42a23          	sw	a5,-76(s0)
    80005b5c:	87b6                	mv	a5,a3
    80005b5e:	faf42823          	sw	a5,-80(s0)
    80005b62:	87ba                	mv	a5,a4
    80005b64:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005b68:	fb843783          	ld	a5,-72(s0)
    80005b6c:	47f8                	lw	a4,76(a5)
    80005b6e:	fb042783          	lw	a5,-80(s0)
    80005b72:	2781                	sext.w	a5,a5
    80005b74:	00f76e63          	bltu	a4,a5,80005b90 <writei+0x4c>
    80005b78:	fb042703          	lw	a4,-80(s0)
    80005b7c:	fa442783          	lw	a5,-92(s0)
    80005b80:	9fb9                	addw	a5,a5,a4
    80005b82:	0007871b          	sext.w	a4,a5
    80005b86:	fb042783          	lw	a5,-80(s0)
    80005b8a:	2781                	sext.w	a5,a5
    80005b8c:	00f77463          	bgeu	a4,a5,80005b94 <writei+0x50>
    return -1;
    80005b90:	57fd                	li	a5,-1
    80005b92:	aaa9                	j	80005cec <writei+0x1a8>
  if(off + n > MAXFILE*BSIZE)
    80005b94:	fb042703          	lw	a4,-80(s0)
    80005b98:	fa442783          	lw	a5,-92(s0)
    80005b9c:	9fb9                	addw	a5,a5,a4
    80005b9e:	2781                	sext.w	a5,a5
    80005ba0:	873e                	mv	a4,a5
    80005ba2:	000437b7          	lui	a5,0x43
    80005ba6:	00e7f463          	bgeu	a5,a4,80005bae <writei+0x6a>
    return -1;
    80005baa:	57fd                	li	a5,-1
    80005bac:	a281                	j	80005cec <writei+0x1a8>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005bae:	fc042e23          	sw	zero,-36(s0)
    80005bb2:	a8e5                	j	80005caa <writei+0x166>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005bb4:	fb843783          	ld	a5,-72(s0)
    80005bb8:	4384                	lw	s1,0(a5)
    80005bba:	fb042783          	lw	a5,-80(s0)
    80005bbe:	00a7d79b          	srliw	a5,a5,0xa
    80005bc2:	2781                	sext.w	a5,a5
    80005bc4:	85be                	mv	a1,a5
    80005bc6:	fb843503          	ld	a0,-72(s0)
    80005bca:	00000097          	auipc	ra,0x0
    80005bce:	ae6080e7          	jalr	-1306(ra) # 800056b0 <bmap>
    80005bd2:	87aa                	mv	a5,a0
    80005bd4:	2781                	sext.w	a5,a5
    80005bd6:	85be                	mv	a1,a5
    80005bd8:	8526                	mv	a0,s1
    80005bda:	fffff097          	auipc	ra,0xfffff
    80005bde:	e62080e7          	jalr	-414(ra) # 80004a3c <bread>
    80005be2:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005be6:	fb042783          	lw	a5,-80(s0)
    80005bea:	3ff7f793          	andi	a5,a5,1023
    80005bee:	2781                	sext.w	a5,a5
    80005bf0:	40000713          	li	a4,1024
    80005bf4:	40f707bb          	subw	a5,a4,a5
    80005bf8:	0007869b          	sext.w	a3,a5
    80005bfc:	fa442703          	lw	a4,-92(s0)
    80005c00:	fdc42783          	lw	a5,-36(s0)
    80005c04:	40f707bb          	subw	a5,a4,a5
    80005c08:	2781                	sext.w	a5,a5
    80005c0a:	863e                	mv	a2,a5
    80005c0c:	87b6                	mv	a5,a3
    80005c0e:	0007869b          	sext.w	a3,a5
    80005c12:	0006071b          	sext.w	a4,a2
    80005c16:	00d77363          	bgeu	a4,a3,80005c1c <writei+0xd8>
    80005c1a:	87b2                	mv	a5,a2
    80005c1c:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005c20:	fd043783          	ld	a5,-48(s0)
    80005c24:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80005c28:	fb046783          	lwu	a5,-80(s0)
    80005c2c:	3ff7f793          	andi	a5,a5,1023
    80005c30:	97ba                	add	a5,a5,a4
    80005c32:	fcc46683          	lwu	a3,-52(s0)
    80005c36:	fb442703          	lw	a4,-76(s0)
    80005c3a:	fa843603          	ld	a2,-88(s0)
    80005c3e:	85ba                	mv	a1,a4
    80005c40:	853e                	mv	a0,a5
    80005c42:	ffffe097          	auipc	ra,0xffffe
    80005c46:	b96080e7          	jalr	-1130(ra) # 800037d8 <either_copyin>
    80005c4a:	87aa                	mv	a5,a0
    80005c4c:	873e                	mv	a4,a5
    80005c4e:	57fd                	li	a5,-1
    80005c50:	00f71c63          	bne	a4,a5,80005c68 <writei+0x124>
      brelse(bp);
    80005c54:	fd043503          	ld	a0,-48(s0)
    80005c58:	fffff097          	auipc	ra,0xfffff
    80005c5c:	e86080e7          	jalr	-378(ra) # 80004ade <brelse>
      n = -1;
    80005c60:	57fd                	li	a5,-1
    80005c62:	faf42223          	sw	a5,-92(s0)
      break;
    80005c66:	a891                	j	80005cba <writei+0x176>
    }
    log_write(bp);
    80005c68:	fd043503          	ld	a0,-48(s0)
    80005c6c:	00001097          	auipc	ra,0x1
    80005c70:	b02080e7          	jalr	-1278(ra) # 8000676e <log_write>
    brelse(bp);
    80005c74:	fd043503          	ld	a0,-48(s0)
    80005c78:	fffff097          	auipc	ra,0xfffff
    80005c7c:	e66080e7          	jalr	-410(ra) # 80004ade <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005c80:	fdc42703          	lw	a4,-36(s0)
    80005c84:	fcc42783          	lw	a5,-52(s0)
    80005c88:	9fb9                	addw	a5,a5,a4
    80005c8a:	fcf42e23          	sw	a5,-36(s0)
    80005c8e:	fb042703          	lw	a4,-80(s0)
    80005c92:	fcc42783          	lw	a5,-52(s0)
    80005c96:	9fb9                	addw	a5,a5,a4
    80005c98:	faf42823          	sw	a5,-80(s0)
    80005c9c:	fcc46783          	lwu	a5,-52(s0)
    80005ca0:	fa843703          	ld	a4,-88(s0)
    80005ca4:	97ba                	add	a5,a5,a4
    80005ca6:	faf43423          	sd	a5,-88(s0)
    80005caa:	fdc42703          	lw	a4,-36(s0)
    80005cae:	fa442783          	lw	a5,-92(s0)
    80005cb2:	2701                	sext.w	a4,a4
    80005cb4:	2781                	sext.w	a5,a5
    80005cb6:	eef76fe3          	bltu	a4,a5,80005bb4 <writei+0x70>
  }

  if(n > 0){
    80005cba:	fa442783          	lw	a5,-92(s0)
    80005cbe:	2781                	sext.w	a5,a5
    80005cc0:	c785                	beqz	a5,80005ce8 <writei+0x1a4>
    if(off > ip->size)
    80005cc2:	fb843783          	ld	a5,-72(s0)
    80005cc6:	47f8                	lw	a4,76(a5)
    80005cc8:	fb042783          	lw	a5,-80(s0)
    80005ccc:	2781                	sext.w	a5,a5
    80005cce:	00f77763          	bgeu	a4,a5,80005cdc <writei+0x198>
      ip->size = off;
    80005cd2:	fb843783          	ld	a5,-72(s0)
    80005cd6:	fb042703          	lw	a4,-80(s0)
    80005cda:	c7f8                	sw	a4,76(a5)
    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    80005cdc:	fb843503          	ld	a0,-72(s0)
    80005ce0:	fffff097          	auipc	ra,0xfffff
    80005ce4:	4f4080e7          	jalr	1268(ra) # 800051d4 <iupdate>
  }

  return n;
    80005ce8:	fa442783          	lw	a5,-92(s0)
}
    80005cec:	853e                	mv	a0,a5
    80005cee:	60e6                	ld	ra,88(sp)
    80005cf0:	6446                	ld	s0,80(sp)
    80005cf2:	64a6                	ld	s1,72(sp)
    80005cf4:	6125                	addi	sp,sp,96
    80005cf6:	8082                	ret

0000000080005cf8 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80005cf8:	1101                	addi	sp,sp,-32
    80005cfa:	ec06                	sd	ra,24(sp)
    80005cfc:	e822                	sd	s0,16(sp)
    80005cfe:	1000                	addi	s0,sp,32
    80005d00:	fea43423          	sd	a0,-24(s0)
    80005d04:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80005d08:	4639                	li	a2,14
    80005d0a:	fe043583          	ld	a1,-32(s0)
    80005d0e:	fe843503          	ld	a0,-24(s0)
    80005d12:	ffffc097          	auipc	ra,0xffffc
    80005d16:	92c080e7          	jalr	-1748(ra) # 8000163e <strncmp>
    80005d1a:	87aa                	mv	a5,a0
}
    80005d1c:	853e                	mv	a0,a5
    80005d1e:	60e2                	ld	ra,24(sp)
    80005d20:	6442                	ld	s0,16(sp)
    80005d22:	6105                	addi	sp,sp,32
    80005d24:	8082                	ret

0000000080005d26 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80005d26:	715d                	addi	sp,sp,-80
    80005d28:	e486                	sd	ra,72(sp)
    80005d2a:	e0a2                	sd	s0,64(sp)
    80005d2c:	0880                	addi	s0,sp,80
    80005d2e:	fca43423          	sd	a0,-56(s0)
    80005d32:	fcb43023          	sd	a1,-64(s0)
    80005d36:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80005d3a:	fc843783          	ld	a5,-56(s0)
    80005d3e:	04479783          	lh	a5,68(a5)
    80005d42:	0007871b          	sext.w	a4,a5
    80005d46:	4785                	li	a5,1
    80005d48:	00f70a63          	beq	a4,a5,80005d5c <dirlookup+0x36>
    panic("dirlookup not DIR");
    80005d4c:	00005517          	auipc	a0,0x5
    80005d50:	79450513          	addi	a0,a0,1940 # 8000b4e0 <etext+0x4e0>
    80005d54:	ffffb097          	auipc	ra,0xffffb
    80005d58:	efe080e7          	jalr	-258(ra) # 80000c52 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80005d5c:	fe042623          	sw	zero,-20(s0)
    80005d60:	a849                	j	80005df2 <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005d62:	fd840793          	addi	a5,s0,-40
    80005d66:	fec42683          	lw	a3,-20(s0)
    80005d6a:	4741                	li	a4,16
    80005d6c:	863e                	mv	a2,a5
    80005d6e:	4581                	li	a1,0
    80005d70:	fc843503          	ld	a0,-56(s0)
    80005d74:	00000097          	auipc	ra,0x0
    80005d78:	c46080e7          	jalr	-954(ra) # 800059ba <readi>
    80005d7c:	87aa                	mv	a5,a0
    80005d7e:	873e                	mv	a4,a5
    80005d80:	47c1                	li	a5,16
    80005d82:	00f70a63          	beq	a4,a5,80005d96 <dirlookup+0x70>
      panic("dirlookup read");
    80005d86:	00005517          	auipc	a0,0x5
    80005d8a:	77250513          	addi	a0,a0,1906 # 8000b4f8 <etext+0x4f8>
    80005d8e:	ffffb097          	auipc	ra,0xffffb
    80005d92:	ec4080e7          	jalr	-316(ra) # 80000c52 <panic>
    if(de.inum == 0)
    80005d96:	fd845783          	lhu	a5,-40(s0)
    80005d9a:	c7b1                	beqz	a5,80005de6 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80005d9c:	fd840793          	addi	a5,s0,-40
    80005da0:	0789                	addi	a5,a5,2
    80005da2:	85be                	mv	a1,a5
    80005da4:	fc043503          	ld	a0,-64(s0)
    80005da8:	00000097          	auipc	ra,0x0
    80005dac:	f50080e7          	jalr	-176(ra) # 80005cf8 <namecmp>
    80005db0:	87aa                	mv	a5,a0
    80005db2:	eb9d                	bnez	a5,80005de8 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    80005db4:	fb843783          	ld	a5,-72(s0)
    80005db8:	c791                	beqz	a5,80005dc4 <dirlookup+0x9e>
        *poff = off;
    80005dba:	fb843783          	ld	a5,-72(s0)
    80005dbe:	fec42703          	lw	a4,-20(s0)
    80005dc2:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80005dc4:	fd845783          	lhu	a5,-40(s0)
    80005dc8:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005dcc:	fc843783          	ld	a5,-56(s0)
    80005dd0:	439c                	lw	a5,0(a5)
    80005dd2:	fe842703          	lw	a4,-24(s0)
    80005dd6:	85ba                	mv	a1,a4
    80005dd8:	853e                	mv	a0,a5
    80005dda:	fffff097          	auipc	ra,0xfffff
    80005dde:	4e2080e7          	jalr	1250(ra) # 800052bc <iget>
    80005de2:	87aa                	mv	a5,a0
    80005de4:	a005                	j	80005e04 <dirlookup+0xde>
      continue;
    80005de6:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005de8:	fec42783          	lw	a5,-20(s0)
    80005dec:	27c1                	addiw	a5,a5,16
    80005dee:	fef42623          	sw	a5,-20(s0)
    80005df2:	fc843783          	ld	a5,-56(s0)
    80005df6:	47f8                	lw	a4,76(a5)
    80005df8:	fec42783          	lw	a5,-20(s0)
    80005dfc:	2781                	sext.w	a5,a5
    80005dfe:	f6e7e2e3          	bltu	a5,a4,80005d62 <dirlookup+0x3c>
    }
  }

  return 0;
    80005e02:	4781                	li	a5,0
}
    80005e04:	853e                	mv	a0,a5
    80005e06:	60a6                	ld	ra,72(sp)
    80005e08:	6406                	ld	s0,64(sp)
    80005e0a:	6161                	addi	sp,sp,80
    80005e0c:	8082                	ret

0000000080005e0e <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    80005e0e:	715d                	addi	sp,sp,-80
    80005e10:	e486                	sd	ra,72(sp)
    80005e12:	e0a2                	sd	s0,64(sp)
    80005e14:	0880                	addi	s0,sp,80
    80005e16:	fca43423          	sd	a0,-56(s0)
    80005e1a:	fcb43023          	sd	a1,-64(s0)
    80005e1e:	87b2                	mv	a5,a2
    80005e20:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80005e24:	4601                	li	a2,0
    80005e26:	fc043583          	ld	a1,-64(s0)
    80005e2a:	fc843503          	ld	a0,-56(s0)
    80005e2e:	00000097          	auipc	ra,0x0
    80005e32:	ef8080e7          	jalr	-264(ra) # 80005d26 <dirlookup>
    80005e36:	fea43023          	sd	a0,-32(s0)
    80005e3a:	fe043783          	ld	a5,-32(s0)
    80005e3e:	cb89                	beqz	a5,80005e50 <dirlink+0x42>
    iput(ip);
    80005e40:	fe043503          	ld	a0,-32(s0)
    80005e44:	fffff097          	auipc	ra,0xfffff
    80005e48:	76e080e7          	jalr	1902(ra) # 800055b2 <iput>
    return -1;
    80005e4c:	57fd                	li	a5,-1
    80005e4e:	a865                	j	80005f06 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005e50:	fe042623          	sw	zero,-20(s0)
    80005e54:	a0a1                	j	80005e9c <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e56:	fd040793          	addi	a5,s0,-48
    80005e5a:	fec42683          	lw	a3,-20(s0)
    80005e5e:	4741                	li	a4,16
    80005e60:	863e                	mv	a2,a5
    80005e62:	4581                	li	a1,0
    80005e64:	fc843503          	ld	a0,-56(s0)
    80005e68:	00000097          	auipc	ra,0x0
    80005e6c:	b52080e7          	jalr	-1198(ra) # 800059ba <readi>
    80005e70:	87aa                	mv	a5,a0
    80005e72:	873e                	mv	a4,a5
    80005e74:	47c1                	li	a5,16
    80005e76:	00f70a63          	beq	a4,a5,80005e8a <dirlink+0x7c>
      panic("dirlink read");
    80005e7a:	00005517          	auipc	a0,0x5
    80005e7e:	68e50513          	addi	a0,a0,1678 # 8000b508 <etext+0x508>
    80005e82:	ffffb097          	auipc	ra,0xffffb
    80005e86:	dd0080e7          	jalr	-560(ra) # 80000c52 <panic>
    if(de.inum == 0)
    80005e8a:	fd045783          	lhu	a5,-48(s0)
    80005e8e:	cf99                	beqz	a5,80005eac <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005e90:	fec42783          	lw	a5,-20(s0)
    80005e94:	27c1                	addiw	a5,a5,16
    80005e96:	2781                	sext.w	a5,a5
    80005e98:	fef42623          	sw	a5,-20(s0)
    80005e9c:	fc843783          	ld	a5,-56(s0)
    80005ea0:	47f8                	lw	a4,76(a5)
    80005ea2:	fec42783          	lw	a5,-20(s0)
    80005ea6:	fae7e8e3          	bltu	a5,a4,80005e56 <dirlink+0x48>
    80005eaa:	a011                	j	80005eae <dirlink+0xa0>
      break;
    80005eac:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80005eae:	fd040793          	addi	a5,s0,-48
    80005eb2:	0789                	addi	a5,a5,2
    80005eb4:	4639                	li	a2,14
    80005eb6:	fc043583          	ld	a1,-64(s0)
    80005eba:	853e                	mv	a0,a5
    80005ebc:	ffffc097          	auipc	ra,0xffffc
    80005ec0:	80c080e7          	jalr	-2036(ra) # 800016c8 <strncpy>
  de.inum = inum;
    80005ec4:	fbc42783          	lw	a5,-68(s0)
    80005ec8:	17c2                	slli	a5,a5,0x30
    80005eca:	93c1                	srli	a5,a5,0x30
    80005ecc:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005ed0:	fd040793          	addi	a5,s0,-48
    80005ed4:	fec42683          	lw	a3,-20(s0)
    80005ed8:	4741                	li	a4,16
    80005eda:	863e                	mv	a2,a5
    80005edc:	4581                	li	a1,0
    80005ede:	fc843503          	ld	a0,-56(s0)
    80005ee2:	00000097          	auipc	ra,0x0
    80005ee6:	c62080e7          	jalr	-926(ra) # 80005b44 <writei>
    80005eea:	87aa                	mv	a5,a0
    80005eec:	873e                	mv	a4,a5
    80005eee:	47c1                	li	a5,16
    80005ef0:	00f70a63          	beq	a4,a5,80005f04 <dirlink+0xf6>
    panic("dirlink");
    80005ef4:	00005517          	auipc	a0,0x5
    80005ef8:	62450513          	addi	a0,a0,1572 # 8000b518 <etext+0x518>
    80005efc:	ffffb097          	auipc	ra,0xffffb
    80005f00:	d56080e7          	jalr	-682(ra) # 80000c52 <panic>

  return 0;
    80005f04:	4781                	li	a5,0
}
    80005f06:	853e                	mv	a0,a5
    80005f08:	60a6                	ld	ra,72(sp)
    80005f0a:	6406                	ld	s0,64(sp)
    80005f0c:	6161                	addi	sp,sp,80
    80005f0e:	8082                	ret

0000000080005f10 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80005f10:	7179                	addi	sp,sp,-48
    80005f12:	f406                	sd	ra,40(sp)
    80005f14:	f022                	sd	s0,32(sp)
    80005f16:	1800                	addi	s0,sp,48
    80005f18:	fca43c23          	sd	a0,-40(s0)
    80005f1c:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80005f20:	a031                	j	80005f2c <skipelem+0x1c>
    path++;
    80005f22:	fd843783          	ld	a5,-40(s0)
    80005f26:	0785                	addi	a5,a5,1
    80005f28:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005f2c:	fd843783          	ld	a5,-40(s0)
    80005f30:	0007c783          	lbu	a5,0(a5)
    80005f34:	873e                	mv	a4,a5
    80005f36:	02f00793          	li	a5,47
    80005f3a:	fef704e3          	beq	a4,a5,80005f22 <skipelem+0x12>
  if(*path == 0)
    80005f3e:	fd843783          	ld	a5,-40(s0)
    80005f42:	0007c783          	lbu	a5,0(a5)
    80005f46:	e399                	bnez	a5,80005f4c <skipelem+0x3c>
    return 0;
    80005f48:	4781                	li	a5,0
    80005f4a:	a06d                	j	80005ff4 <skipelem+0xe4>
  s = path;
    80005f4c:	fd843783          	ld	a5,-40(s0)
    80005f50:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80005f54:	a031                	j	80005f60 <skipelem+0x50>
    path++;
    80005f56:	fd843783          	ld	a5,-40(s0)
    80005f5a:	0785                	addi	a5,a5,1
    80005f5c:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80005f60:	fd843783          	ld	a5,-40(s0)
    80005f64:	0007c783          	lbu	a5,0(a5)
    80005f68:	873e                	mv	a4,a5
    80005f6a:	02f00793          	li	a5,47
    80005f6e:	00f70763          	beq	a4,a5,80005f7c <skipelem+0x6c>
    80005f72:	fd843783          	ld	a5,-40(s0)
    80005f76:	0007c783          	lbu	a5,0(a5)
    80005f7a:	fff1                	bnez	a5,80005f56 <skipelem+0x46>
  len = path - s;
    80005f7c:	fd843703          	ld	a4,-40(s0)
    80005f80:	fe843783          	ld	a5,-24(s0)
    80005f84:	40f707b3          	sub	a5,a4,a5
    80005f88:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80005f8c:	fe442783          	lw	a5,-28(s0)
    80005f90:	0007871b          	sext.w	a4,a5
    80005f94:	47b5                	li	a5,13
    80005f96:	00e7dc63          	bge	a5,a4,80005fae <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80005f9a:	4639                	li	a2,14
    80005f9c:	fe843583          	ld	a1,-24(s0)
    80005fa0:	fd043503          	ld	a0,-48(s0)
    80005fa4:	ffffb097          	auipc	ra,0xffffb
    80005fa8:	594080e7          	jalr	1428(ra) # 80001538 <memmove>
    80005fac:	a80d                	j	80005fde <skipelem+0xce>
  else {
    memmove(name, s, len);
    80005fae:	fe442783          	lw	a5,-28(s0)
    80005fb2:	863e                	mv	a2,a5
    80005fb4:	fe843583          	ld	a1,-24(s0)
    80005fb8:	fd043503          	ld	a0,-48(s0)
    80005fbc:	ffffb097          	auipc	ra,0xffffb
    80005fc0:	57c080e7          	jalr	1404(ra) # 80001538 <memmove>
    name[len] = 0;
    80005fc4:	fe442783          	lw	a5,-28(s0)
    80005fc8:	fd043703          	ld	a4,-48(s0)
    80005fcc:	97ba                	add	a5,a5,a4
    80005fce:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005fd2:	a031                	j	80005fde <skipelem+0xce>
    path++;
    80005fd4:	fd843783          	ld	a5,-40(s0)
    80005fd8:	0785                	addi	a5,a5,1
    80005fda:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005fde:	fd843783          	ld	a5,-40(s0)
    80005fe2:	0007c783          	lbu	a5,0(a5)
    80005fe6:	873e                	mv	a4,a5
    80005fe8:	02f00793          	li	a5,47
    80005fec:	fef704e3          	beq	a4,a5,80005fd4 <skipelem+0xc4>
  return path;
    80005ff0:	fd843783          	ld	a5,-40(s0)
}
    80005ff4:	853e                	mv	a0,a5
    80005ff6:	70a2                	ld	ra,40(sp)
    80005ff8:	7402                	ld	s0,32(sp)
    80005ffa:	6145                	addi	sp,sp,48
    80005ffc:	8082                	ret

0000000080005ffe <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005ffe:	7139                	addi	sp,sp,-64
    80006000:	fc06                	sd	ra,56(sp)
    80006002:	f822                	sd	s0,48(sp)
    80006004:	0080                	addi	s0,sp,64
    80006006:	fca43c23          	sd	a0,-40(s0)
    8000600a:	87ae                	mv	a5,a1
    8000600c:	fcc43423          	sd	a2,-56(s0)
    80006010:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80006014:	fd843783          	ld	a5,-40(s0)
    80006018:	0007c783          	lbu	a5,0(a5)
    8000601c:	873e                	mv	a4,a5
    8000601e:	02f00793          	li	a5,47
    80006022:	00f71b63          	bne	a4,a5,80006038 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80006026:	4585                	li	a1,1
    80006028:	4505                	li	a0,1
    8000602a:	fffff097          	auipc	ra,0xfffff
    8000602e:	292080e7          	jalr	658(ra) # 800052bc <iget>
    80006032:	fea43423          	sd	a0,-24(s0)
    80006036:	a85d                	j	800060ec <namex+0xee>
  else
    ip = idup(myproc()->cwd);
    80006038:	ffffc097          	auipc	ra,0xffffc
    8000603c:	7c0080e7          	jalr	1984(ra) # 800027f8 <myproc>
    80006040:	872a                	mv	a4,a0
    80006042:	6785                	lui	a5,0x1
    80006044:	97ba                	add	a5,a5,a4
    80006046:	3b87b783          	ld	a5,952(a5) # 13b8 <_entry-0x7fffec48>
    8000604a:	853e                	mv	a0,a5
    8000604c:	fffff097          	auipc	ra,0xfffff
    80006050:	38c080e7          	jalr	908(ra) # 800053d8 <idup>
    80006054:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80006058:	a851                	j	800060ec <namex+0xee>
    ilock(ip);
    8000605a:	fe843503          	ld	a0,-24(s0)
    8000605e:	fffff097          	auipc	ra,0xfffff
    80006062:	3c6080e7          	jalr	966(ra) # 80005424 <ilock>
    if(ip->type != T_DIR){
    80006066:	fe843783          	ld	a5,-24(s0)
    8000606a:	04479783          	lh	a5,68(a5)
    8000606e:	0007871b          	sext.w	a4,a5
    80006072:	4785                	li	a5,1
    80006074:	00f70a63          	beq	a4,a5,80006088 <namex+0x8a>
      iunlockput(ip);
    80006078:	fe843503          	ld	a0,-24(s0)
    8000607c:	fffff097          	auipc	ra,0xfffff
    80006080:	606080e7          	jalr	1542(ra) # 80005682 <iunlockput>
      return 0;
    80006084:	4781                	li	a5,0
    80006086:	a871                	j	80006122 <namex+0x124>
    }
    if(nameiparent && *path == '\0'){
    80006088:	fd442783          	lw	a5,-44(s0)
    8000608c:	2781                	sext.w	a5,a5
    8000608e:	cf99                	beqz	a5,800060ac <namex+0xae>
    80006090:	fd843783          	ld	a5,-40(s0)
    80006094:	0007c783          	lbu	a5,0(a5)
    80006098:	eb91                	bnez	a5,800060ac <namex+0xae>
      // Stop one level early.
      iunlock(ip);
    8000609a:	fe843503          	ld	a0,-24(s0)
    8000609e:	fffff097          	auipc	ra,0xfffff
    800060a2:	4ba080e7          	jalr	1210(ra) # 80005558 <iunlock>
      return ip;
    800060a6:	fe843783          	ld	a5,-24(s0)
    800060aa:	a8a5                	j	80006122 <namex+0x124>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    800060ac:	4601                	li	a2,0
    800060ae:	fc843583          	ld	a1,-56(s0)
    800060b2:	fe843503          	ld	a0,-24(s0)
    800060b6:	00000097          	auipc	ra,0x0
    800060ba:	c70080e7          	jalr	-912(ra) # 80005d26 <dirlookup>
    800060be:	fea43023          	sd	a0,-32(s0)
    800060c2:	fe043783          	ld	a5,-32(s0)
    800060c6:	eb89                	bnez	a5,800060d8 <namex+0xda>
      iunlockput(ip);
    800060c8:	fe843503          	ld	a0,-24(s0)
    800060cc:	fffff097          	auipc	ra,0xfffff
    800060d0:	5b6080e7          	jalr	1462(ra) # 80005682 <iunlockput>
      return 0;
    800060d4:	4781                	li	a5,0
    800060d6:	a0b1                	j	80006122 <namex+0x124>
    }
    iunlockput(ip);
    800060d8:	fe843503          	ld	a0,-24(s0)
    800060dc:	fffff097          	auipc	ra,0xfffff
    800060e0:	5a6080e7          	jalr	1446(ra) # 80005682 <iunlockput>
    ip = next;
    800060e4:	fe043783          	ld	a5,-32(s0)
    800060e8:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    800060ec:	fc843583          	ld	a1,-56(s0)
    800060f0:	fd843503          	ld	a0,-40(s0)
    800060f4:	00000097          	auipc	ra,0x0
    800060f8:	e1c080e7          	jalr	-484(ra) # 80005f10 <skipelem>
    800060fc:	fca43c23          	sd	a0,-40(s0)
    80006100:	fd843783          	ld	a5,-40(s0)
    80006104:	fbb9                	bnez	a5,8000605a <namex+0x5c>
  }
  if(nameiparent){
    80006106:	fd442783          	lw	a5,-44(s0)
    8000610a:	2781                	sext.w	a5,a5
    8000610c:	cb89                	beqz	a5,8000611e <namex+0x120>
    iput(ip);
    8000610e:	fe843503          	ld	a0,-24(s0)
    80006112:	fffff097          	auipc	ra,0xfffff
    80006116:	4a0080e7          	jalr	1184(ra) # 800055b2 <iput>
    return 0;
    8000611a:	4781                	li	a5,0
    8000611c:	a019                	j	80006122 <namex+0x124>
  }
  return ip;
    8000611e:	fe843783          	ld	a5,-24(s0)
}
    80006122:	853e                	mv	a0,a5
    80006124:	70e2                	ld	ra,56(sp)
    80006126:	7442                	ld	s0,48(sp)
    80006128:	6121                	addi	sp,sp,64
    8000612a:	8082                	ret

000000008000612c <namei>:

struct inode*
namei(char *path)
{
    8000612c:	7179                	addi	sp,sp,-48
    8000612e:	f406                	sd	ra,40(sp)
    80006130:	f022                	sd	s0,32(sp)
    80006132:	1800                	addi	s0,sp,48
    80006134:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006138:	fe040793          	addi	a5,s0,-32
    8000613c:	863e                	mv	a2,a5
    8000613e:	4581                	li	a1,0
    80006140:	fd843503          	ld	a0,-40(s0)
    80006144:	00000097          	auipc	ra,0x0
    80006148:	eba080e7          	jalr	-326(ra) # 80005ffe <namex>
    8000614c:	87aa                	mv	a5,a0
}
    8000614e:	853e                	mv	a0,a5
    80006150:	70a2                	ld	ra,40(sp)
    80006152:	7402                	ld	s0,32(sp)
    80006154:	6145                	addi	sp,sp,48
    80006156:	8082                	ret

0000000080006158 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80006158:	1101                	addi	sp,sp,-32
    8000615a:	ec06                	sd	ra,24(sp)
    8000615c:	e822                	sd	s0,16(sp)
    8000615e:	1000                	addi	s0,sp,32
    80006160:	fea43423          	sd	a0,-24(s0)
    80006164:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80006168:	fe043603          	ld	a2,-32(s0)
    8000616c:	4585                	li	a1,1
    8000616e:	fe843503          	ld	a0,-24(s0)
    80006172:	00000097          	auipc	ra,0x0
    80006176:	e8c080e7          	jalr	-372(ra) # 80005ffe <namex>
    8000617a:	87aa                	mv	a5,a0
}
    8000617c:	853e                	mv	a0,a5
    8000617e:	60e2                	ld	ra,24(sp)
    80006180:	6442                	ld	s0,16(sp)
    80006182:	6105                	addi	sp,sp,32
    80006184:	8082                	ret

0000000080006186 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80006186:	1101                	addi	sp,sp,-32
    80006188:	ec06                	sd	ra,24(sp)
    8000618a:	e822                	sd	s0,16(sp)
    8000618c:	1000                	addi	s0,sp,32
    8000618e:	87aa                	mv	a5,a0
    80006190:	feb43023          	sd	a1,-32(s0)
    80006194:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80006198:	00005597          	auipc	a1,0x5
    8000619c:	38858593          	addi	a1,a1,904 # 8000b520 <etext+0x520>
    800061a0:	00068517          	auipc	a0,0x68
    800061a4:	ab050513          	addi	a0,a0,-1360 # 8006dc50 <log>
    800061a8:	ffffb097          	auipc	ra,0xffffb
    800061ac:	0a8080e7          	jalr	168(ra) # 80001250 <initlock>
  log.start = sb->logstart;
    800061b0:	fe043783          	ld	a5,-32(s0)
    800061b4:	4bdc                	lw	a5,20(a5)
    800061b6:	0007871b          	sext.w	a4,a5
    800061ba:	00068797          	auipc	a5,0x68
    800061be:	a9678793          	addi	a5,a5,-1386 # 8006dc50 <log>
    800061c2:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    800061c4:	fe043783          	ld	a5,-32(s0)
    800061c8:	4b9c                	lw	a5,16(a5)
    800061ca:	0007871b          	sext.w	a4,a5
    800061ce:	00068797          	auipc	a5,0x68
    800061d2:	a8278793          	addi	a5,a5,-1406 # 8006dc50 <log>
    800061d6:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    800061d8:	00068797          	auipc	a5,0x68
    800061dc:	a7878793          	addi	a5,a5,-1416 # 8006dc50 <log>
    800061e0:	fec42703          	lw	a4,-20(s0)
    800061e4:	d798                	sw	a4,40(a5)
  recover_from_log();
    800061e6:	00000097          	auipc	ra,0x0
    800061ea:	272080e7          	jalr	626(ra) # 80006458 <recover_from_log>
}
    800061ee:	0001                	nop
    800061f0:	60e2                	ld	ra,24(sp)
    800061f2:	6442                	ld	s0,16(sp)
    800061f4:	6105                	addi	sp,sp,32
    800061f6:	8082                	ret

00000000800061f8 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    800061f8:	7139                	addi	sp,sp,-64
    800061fa:	fc06                	sd	ra,56(sp)
    800061fc:	f822                	sd	s0,48(sp)
    800061fe:	0080                	addi	s0,sp,64
    80006200:	87aa                	mv	a5,a0
    80006202:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006206:	fe042623          	sw	zero,-20(s0)
    8000620a:	a0f9                	j	800062d8 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000620c:	00068797          	auipc	a5,0x68
    80006210:	a4478793          	addi	a5,a5,-1468 # 8006dc50 <log>
    80006214:	579c                	lw	a5,40(a5)
    80006216:	0007869b          	sext.w	a3,a5
    8000621a:	00068797          	auipc	a5,0x68
    8000621e:	a3678793          	addi	a5,a5,-1482 # 8006dc50 <log>
    80006222:	4f9c                	lw	a5,24(a5)
    80006224:	fec42703          	lw	a4,-20(s0)
    80006228:	9fb9                	addw	a5,a5,a4
    8000622a:	2781                	sext.w	a5,a5
    8000622c:	2785                	addiw	a5,a5,1
    8000622e:	2781                	sext.w	a5,a5
    80006230:	2781                	sext.w	a5,a5
    80006232:	85be                	mv	a1,a5
    80006234:	8536                	mv	a0,a3
    80006236:	fffff097          	auipc	ra,0xfffff
    8000623a:	806080e7          	jalr	-2042(ra) # 80004a3c <bread>
    8000623e:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80006242:	00068797          	auipc	a5,0x68
    80006246:	a0e78793          	addi	a5,a5,-1522 # 8006dc50 <log>
    8000624a:	579c                	lw	a5,40(a5)
    8000624c:	0007869b          	sext.w	a3,a5
    80006250:	00068717          	auipc	a4,0x68
    80006254:	a0070713          	addi	a4,a4,-1536 # 8006dc50 <log>
    80006258:	fec42783          	lw	a5,-20(s0)
    8000625c:	07a1                	addi	a5,a5,8
    8000625e:	078a                	slli	a5,a5,0x2
    80006260:	97ba                	add	a5,a5,a4
    80006262:	4b9c                	lw	a5,16(a5)
    80006264:	2781                	sext.w	a5,a5
    80006266:	85be                	mv	a1,a5
    80006268:	8536                	mv	a0,a3
    8000626a:	ffffe097          	auipc	ra,0xffffe
    8000626e:	7d2080e7          	jalr	2002(ra) # 80004a3c <bread>
    80006272:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80006276:	fd843783          	ld	a5,-40(s0)
    8000627a:	05878713          	addi	a4,a5,88
    8000627e:	fe043783          	ld	a5,-32(s0)
    80006282:	05878793          	addi	a5,a5,88
    80006286:	40000613          	li	a2,1024
    8000628a:	85be                	mv	a1,a5
    8000628c:	853a                	mv	a0,a4
    8000628e:	ffffb097          	auipc	ra,0xffffb
    80006292:	2aa080e7          	jalr	682(ra) # 80001538 <memmove>
    bwrite(dbuf);  // write dst to disk
    80006296:	fd843503          	ld	a0,-40(s0)
    8000629a:	ffffe097          	auipc	ra,0xffffe
    8000629e:	7fc080e7          	jalr	2044(ra) # 80004a96 <bwrite>
    if(recovering == 0)
    800062a2:	fcc42783          	lw	a5,-52(s0)
    800062a6:	2781                	sext.w	a5,a5
    800062a8:	e799                	bnez	a5,800062b6 <install_trans+0xbe>
      bunpin(dbuf);
    800062aa:	fd843503          	ld	a0,-40(s0)
    800062ae:	fffff097          	auipc	ra,0xfffff
    800062b2:	966080e7          	jalr	-1690(ra) # 80004c14 <bunpin>
    brelse(lbuf);
    800062b6:	fe043503          	ld	a0,-32(s0)
    800062ba:	fffff097          	auipc	ra,0xfffff
    800062be:	824080e7          	jalr	-2012(ra) # 80004ade <brelse>
    brelse(dbuf);
    800062c2:	fd843503          	ld	a0,-40(s0)
    800062c6:	fffff097          	auipc	ra,0xfffff
    800062ca:	818080e7          	jalr	-2024(ra) # 80004ade <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800062ce:	fec42783          	lw	a5,-20(s0)
    800062d2:	2785                	addiw	a5,a5,1
    800062d4:	fef42623          	sw	a5,-20(s0)
    800062d8:	00068797          	auipc	a5,0x68
    800062dc:	97878793          	addi	a5,a5,-1672 # 8006dc50 <log>
    800062e0:	57d8                	lw	a4,44(a5)
    800062e2:	fec42783          	lw	a5,-20(s0)
    800062e6:	2781                	sext.w	a5,a5
    800062e8:	f2e7c2e3          	blt	a5,a4,8000620c <install_trans+0x14>
  }
}
    800062ec:	0001                	nop
    800062ee:	0001                	nop
    800062f0:	70e2                	ld	ra,56(sp)
    800062f2:	7442                	ld	s0,48(sp)
    800062f4:	6121                	addi	sp,sp,64
    800062f6:	8082                	ret

00000000800062f8 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    800062f8:	7179                	addi	sp,sp,-48
    800062fa:	f406                	sd	ra,40(sp)
    800062fc:	f022                	sd	s0,32(sp)
    800062fe:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006300:	00068797          	auipc	a5,0x68
    80006304:	95078793          	addi	a5,a5,-1712 # 8006dc50 <log>
    80006308:	579c                	lw	a5,40(a5)
    8000630a:	0007871b          	sext.w	a4,a5
    8000630e:	00068797          	auipc	a5,0x68
    80006312:	94278793          	addi	a5,a5,-1726 # 8006dc50 <log>
    80006316:	4f9c                	lw	a5,24(a5)
    80006318:	2781                	sext.w	a5,a5
    8000631a:	85be                	mv	a1,a5
    8000631c:	853a                	mv	a0,a4
    8000631e:	ffffe097          	auipc	ra,0xffffe
    80006322:	71e080e7          	jalr	1822(ra) # 80004a3c <bread>
    80006326:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    8000632a:	fe043783          	ld	a5,-32(s0)
    8000632e:	05878793          	addi	a5,a5,88
    80006332:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80006336:	fd843783          	ld	a5,-40(s0)
    8000633a:	4398                	lw	a4,0(a5)
    8000633c:	00068797          	auipc	a5,0x68
    80006340:	91478793          	addi	a5,a5,-1772 # 8006dc50 <log>
    80006344:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006346:	fe042623          	sw	zero,-20(s0)
    8000634a:	a03d                	j	80006378 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    8000634c:	fd843703          	ld	a4,-40(s0)
    80006350:	fec42783          	lw	a5,-20(s0)
    80006354:	078a                	slli	a5,a5,0x2
    80006356:	97ba                	add	a5,a5,a4
    80006358:	43d8                	lw	a4,4(a5)
    8000635a:	00068697          	auipc	a3,0x68
    8000635e:	8f668693          	addi	a3,a3,-1802 # 8006dc50 <log>
    80006362:	fec42783          	lw	a5,-20(s0)
    80006366:	07a1                	addi	a5,a5,8
    80006368:	078a                	slli	a5,a5,0x2
    8000636a:	97b6                	add	a5,a5,a3
    8000636c:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000636e:	fec42783          	lw	a5,-20(s0)
    80006372:	2785                	addiw	a5,a5,1
    80006374:	fef42623          	sw	a5,-20(s0)
    80006378:	00068797          	auipc	a5,0x68
    8000637c:	8d878793          	addi	a5,a5,-1832 # 8006dc50 <log>
    80006380:	57d8                	lw	a4,44(a5)
    80006382:	fec42783          	lw	a5,-20(s0)
    80006386:	2781                	sext.w	a5,a5
    80006388:	fce7c2e3          	blt	a5,a4,8000634c <read_head+0x54>
  }
  brelse(buf);
    8000638c:	fe043503          	ld	a0,-32(s0)
    80006390:	ffffe097          	auipc	ra,0xffffe
    80006394:	74e080e7          	jalr	1870(ra) # 80004ade <brelse>
}
    80006398:	0001                	nop
    8000639a:	70a2                	ld	ra,40(sp)
    8000639c:	7402                	ld	s0,32(sp)
    8000639e:	6145                	addi	sp,sp,48
    800063a0:	8082                	ret

00000000800063a2 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800063a2:	7179                	addi	sp,sp,-48
    800063a4:	f406                	sd	ra,40(sp)
    800063a6:	f022                	sd	s0,32(sp)
    800063a8:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    800063aa:	00068797          	auipc	a5,0x68
    800063ae:	8a678793          	addi	a5,a5,-1882 # 8006dc50 <log>
    800063b2:	579c                	lw	a5,40(a5)
    800063b4:	0007871b          	sext.w	a4,a5
    800063b8:	00068797          	auipc	a5,0x68
    800063bc:	89878793          	addi	a5,a5,-1896 # 8006dc50 <log>
    800063c0:	4f9c                	lw	a5,24(a5)
    800063c2:	2781                	sext.w	a5,a5
    800063c4:	85be                	mv	a1,a5
    800063c6:	853a                	mv	a0,a4
    800063c8:	ffffe097          	auipc	ra,0xffffe
    800063cc:	674080e7          	jalr	1652(ra) # 80004a3c <bread>
    800063d0:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    800063d4:	fe043783          	ld	a5,-32(s0)
    800063d8:	05878793          	addi	a5,a5,88
    800063dc:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    800063e0:	00068797          	auipc	a5,0x68
    800063e4:	87078793          	addi	a5,a5,-1936 # 8006dc50 <log>
    800063e8:	57d8                	lw	a4,44(a5)
    800063ea:	fd843783          	ld	a5,-40(s0)
    800063ee:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    800063f0:	fe042623          	sw	zero,-20(s0)
    800063f4:	a03d                	j	80006422 <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    800063f6:	00068717          	auipc	a4,0x68
    800063fa:	85a70713          	addi	a4,a4,-1958 # 8006dc50 <log>
    800063fe:	fec42783          	lw	a5,-20(s0)
    80006402:	07a1                	addi	a5,a5,8
    80006404:	078a                	slli	a5,a5,0x2
    80006406:	97ba                	add	a5,a5,a4
    80006408:	4b98                	lw	a4,16(a5)
    8000640a:	fd843683          	ld	a3,-40(s0)
    8000640e:	fec42783          	lw	a5,-20(s0)
    80006412:	078a                	slli	a5,a5,0x2
    80006414:	97b6                	add	a5,a5,a3
    80006416:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006418:	fec42783          	lw	a5,-20(s0)
    8000641c:	2785                	addiw	a5,a5,1
    8000641e:	fef42623          	sw	a5,-20(s0)
    80006422:	00068797          	auipc	a5,0x68
    80006426:	82e78793          	addi	a5,a5,-2002 # 8006dc50 <log>
    8000642a:	57d8                	lw	a4,44(a5)
    8000642c:	fec42783          	lw	a5,-20(s0)
    80006430:	2781                	sext.w	a5,a5
    80006432:	fce7c2e3          	blt	a5,a4,800063f6 <write_head+0x54>
  }
  bwrite(buf);
    80006436:	fe043503          	ld	a0,-32(s0)
    8000643a:	ffffe097          	auipc	ra,0xffffe
    8000643e:	65c080e7          	jalr	1628(ra) # 80004a96 <bwrite>
  brelse(buf);
    80006442:	fe043503          	ld	a0,-32(s0)
    80006446:	ffffe097          	auipc	ra,0xffffe
    8000644a:	698080e7          	jalr	1688(ra) # 80004ade <brelse>
}
    8000644e:	0001                	nop
    80006450:	70a2                	ld	ra,40(sp)
    80006452:	7402                	ld	s0,32(sp)
    80006454:	6145                	addi	sp,sp,48
    80006456:	8082                	ret

0000000080006458 <recover_from_log>:

static void
recover_from_log(void)
{
    80006458:	1141                	addi	sp,sp,-16
    8000645a:	e406                	sd	ra,8(sp)
    8000645c:	e022                	sd	s0,0(sp)
    8000645e:	0800                	addi	s0,sp,16
  read_head();
    80006460:	00000097          	auipc	ra,0x0
    80006464:	e98080e7          	jalr	-360(ra) # 800062f8 <read_head>
  install_trans(1); // if committed, copy from log to disk
    80006468:	4505                	li	a0,1
    8000646a:	00000097          	auipc	ra,0x0
    8000646e:	d8e080e7          	jalr	-626(ra) # 800061f8 <install_trans>
  log.lh.n = 0;
    80006472:	00067797          	auipc	a5,0x67
    80006476:	7de78793          	addi	a5,a5,2014 # 8006dc50 <log>
    8000647a:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    8000647e:	00000097          	auipc	ra,0x0
    80006482:	f24080e7          	jalr	-220(ra) # 800063a2 <write_head>
}
    80006486:	0001                	nop
    80006488:	60a2                	ld	ra,8(sp)
    8000648a:	6402                	ld	s0,0(sp)
    8000648c:	0141                	addi	sp,sp,16
    8000648e:	8082                	ret

0000000080006490 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80006490:	1141                	addi	sp,sp,-16
    80006492:	e406                	sd	ra,8(sp)
    80006494:	e022                	sd	s0,0(sp)
    80006496:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006498:	00067517          	auipc	a0,0x67
    8000649c:	7b850513          	addi	a0,a0,1976 # 8006dc50 <log>
    800064a0:	ffffb097          	auipc	ra,0xffffb
    800064a4:	de0080e7          	jalr	-544(ra) # 80001280 <acquire>
  while(1){
    if(log.committing){
    800064a8:	00067797          	auipc	a5,0x67
    800064ac:	7a878793          	addi	a5,a5,1960 # 8006dc50 <log>
    800064b0:	53dc                	lw	a5,36(a5)
    800064b2:	cf91                	beqz	a5,800064ce <begin_op+0x3e>
      sleep(&log, &log.lock);
    800064b4:	00067597          	auipc	a1,0x67
    800064b8:	79c58593          	addi	a1,a1,1948 # 8006dc50 <log>
    800064bc:	00067517          	auipc	a0,0x67
    800064c0:	79450513          	addi	a0,a0,1940 # 8006dc50 <log>
    800064c4:	ffffd097          	auipc	ra,0xffffd
    800064c8:	080080e7          	jalr	128(ra) # 80003544 <sleep>
    800064cc:	bff1                	j	800064a8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800064ce:	00067797          	auipc	a5,0x67
    800064d2:	78278793          	addi	a5,a5,1922 # 8006dc50 <log>
    800064d6:	57d8                	lw	a4,44(a5)
    800064d8:	00067797          	auipc	a5,0x67
    800064dc:	77878793          	addi	a5,a5,1912 # 8006dc50 <log>
    800064e0:	539c                	lw	a5,32(a5)
    800064e2:	2785                	addiw	a5,a5,1
    800064e4:	2781                	sext.w	a5,a5
    800064e6:	86be                	mv	a3,a5
    800064e8:	87b6                	mv	a5,a3
    800064ea:	0027979b          	slliw	a5,a5,0x2
    800064ee:	9fb5                	addw	a5,a5,a3
    800064f0:	0017979b          	slliw	a5,a5,0x1
    800064f4:	2781                	sext.w	a5,a5
    800064f6:	9fb9                	addw	a5,a5,a4
    800064f8:	2781                	sext.w	a5,a5
    800064fa:	873e                	mv	a4,a5
    800064fc:	47f9                	li	a5,30
    800064fe:	00e7df63          	bge	a5,a4,8000651c <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80006502:	00067597          	auipc	a1,0x67
    80006506:	74e58593          	addi	a1,a1,1870 # 8006dc50 <log>
    8000650a:	00067517          	auipc	a0,0x67
    8000650e:	74650513          	addi	a0,a0,1862 # 8006dc50 <log>
    80006512:	ffffd097          	auipc	ra,0xffffd
    80006516:	032080e7          	jalr	50(ra) # 80003544 <sleep>
    8000651a:	b779                	j	800064a8 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    8000651c:	00067797          	auipc	a5,0x67
    80006520:	73478793          	addi	a5,a5,1844 # 8006dc50 <log>
    80006524:	539c                	lw	a5,32(a5)
    80006526:	2785                	addiw	a5,a5,1
    80006528:	0007871b          	sext.w	a4,a5
    8000652c:	00067797          	auipc	a5,0x67
    80006530:	72478793          	addi	a5,a5,1828 # 8006dc50 <log>
    80006534:	d398                	sw	a4,32(a5)
      release(&log.lock);
    80006536:	00067517          	auipc	a0,0x67
    8000653a:	71a50513          	addi	a0,a0,1818 # 8006dc50 <log>
    8000653e:	ffffb097          	auipc	ra,0xffffb
    80006542:	da6080e7          	jalr	-602(ra) # 800012e4 <release>
      break;
    80006546:	0001                	nop
    }
  }
}
    80006548:	0001                	nop
    8000654a:	60a2                	ld	ra,8(sp)
    8000654c:	6402                	ld	s0,0(sp)
    8000654e:	0141                	addi	sp,sp,16
    80006550:	8082                	ret

0000000080006552 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80006552:	1101                	addi	sp,sp,-32
    80006554:	ec06                	sd	ra,24(sp)
    80006556:	e822                	sd	s0,16(sp)
    80006558:	1000                	addi	s0,sp,32
  int do_commit = 0;
    8000655a:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    8000655e:	00067517          	auipc	a0,0x67
    80006562:	6f250513          	addi	a0,a0,1778 # 8006dc50 <log>
    80006566:	ffffb097          	auipc	ra,0xffffb
    8000656a:	d1a080e7          	jalr	-742(ra) # 80001280 <acquire>
  log.outstanding -= 1;
    8000656e:	00067797          	auipc	a5,0x67
    80006572:	6e278793          	addi	a5,a5,1762 # 8006dc50 <log>
    80006576:	539c                	lw	a5,32(a5)
    80006578:	37fd                	addiw	a5,a5,-1
    8000657a:	0007871b          	sext.w	a4,a5
    8000657e:	00067797          	auipc	a5,0x67
    80006582:	6d278793          	addi	a5,a5,1746 # 8006dc50 <log>
    80006586:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006588:	00067797          	auipc	a5,0x67
    8000658c:	6c878793          	addi	a5,a5,1736 # 8006dc50 <log>
    80006590:	53dc                	lw	a5,36(a5)
    80006592:	cb89                	beqz	a5,800065a4 <end_op+0x52>
    panic("log.committing");
    80006594:	00005517          	auipc	a0,0x5
    80006598:	f9450513          	addi	a0,a0,-108 # 8000b528 <etext+0x528>
    8000659c:	ffffa097          	auipc	ra,0xffffa
    800065a0:	6b6080e7          	jalr	1718(ra) # 80000c52 <panic>
  if(log.outstanding == 0){
    800065a4:	00067797          	auipc	a5,0x67
    800065a8:	6ac78793          	addi	a5,a5,1708 # 8006dc50 <log>
    800065ac:	539c                	lw	a5,32(a5)
    800065ae:	eb99                	bnez	a5,800065c4 <end_op+0x72>
    do_commit = 1;
    800065b0:	4785                	li	a5,1
    800065b2:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    800065b6:	00067797          	auipc	a5,0x67
    800065ba:	69a78793          	addi	a5,a5,1690 # 8006dc50 <log>
    800065be:	4705                	li	a4,1
    800065c0:	d3d8                	sw	a4,36(a5)
    800065c2:	a809                	j	800065d4 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    800065c4:	00067517          	auipc	a0,0x67
    800065c8:	68c50513          	addi	a0,a0,1676 # 8006dc50 <log>
    800065cc:	ffffd097          	auipc	ra,0xffffd
    800065d0:	00c080e7          	jalr	12(ra) # 800035d8 <wakeup>
  }
  release(&log.lock);
    800065d4:	00067517          	auipc	a0,0x67
    800065d8:	67c50513          	addi	a0,a0,1660 # 8006dc50 <log>
    800065dc:	ffffb097          	auipc	ra,0xffffb
    800065e0:	d08080e7          	jalr	-760(ra) # 800012e4 <release>

  if(do_commit){
    800065e4:	fec42783          	lw	a5,-20(s0)
    800065e8:	2781                	sext.w	a5,a5
    800065ea:	c3b9                	beqz	a5,80006630 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    800065ec:	00000097          	auipc	ra,0x0
    800065f0:	134080e7          	jalr	308(ra) # 80006720 <commit>
    acquire(&log.lock);
    800065f4:	00067517          	auipc	a0,0x67
    800065f8:	65c50513          	addi	a0,a0,1628 # 8006dc50 <log>
    800065fc:	ffffb097          	auipc	ra,0xffffb
    80006600:	c84080e7          	jalr	-892(ra) # 80001280 <acquire>
    log.committing = 0;
    80006604:	00067797          	auipc	a5,0x67
    80006608:	64c78793          	addi	a5,a5,1612 # 8006dc50 <log>
    8000660c:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80006610:	00067517          	auipc	a0,0x67
    80006614:	64050513          	addi	a0,a0,1600 # 8006dc50 <log>
    80006618:	ffffd097          	auipc	ra,0xffffd
    8000661c:	fc0080e7          	jalr	-64(ra) # 800035d8 <wakeup>
    release(&log.lock);
    80006620:	00067517          	auipc	a0,0x67
    80006624:	63050513          	addi	a0,a0,1584 # 8006dc50 <log>
    80006628:	ffffb097          	auipc	ra,0xffffb
    8000662c:	cbc080e7          	jalr	-836(ra) # 800012e4 <release>
  }
}
    80006630:	0001                	nop
    80006632:	60e2                	ld	ra,24(sp)
    80006634:	6442                	ld	s0,16(sp)
    80006636:	6105                	addi	sp,sp,32
    80006638:	8082                	ret

000000008000663a <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    8000663a:	7179                	addi	sp,sp,-48
    8000663c:	f406                	sd	ra,40(sp)
    8000663e:	f022                	sd	s0,32(sp)
    80006640:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006642:	fe042623          	sw	zero,-20(s0)
    80006646:	a86d                	j	80006700 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006648:	00067797          	auipc	a5,0x67
    8000664c:	60878793          	addi	a5,a5,1544 # 8006dc50 <log>
    80006650:	579c                	lw	a5,40(a5)
    80006652:	0007869b          	sext.w	a3,a5
    80006656:	00067797          	auipc	a5,0x67
    8000665a:	5fa78793          	addi	a5,a5,1530 # 8006dc50 <log>
    8000665e:	4f9c                	lw	a5,24(a5)
    80006660:	fec42703          	lw	a4,-20(s0)
    80006664:	9fb9                	addw	a5,a5,a4
    80006666:	2781                	sext.w	a5,a5
    80006668:	2785                	addiw	a5,a5,1
    8000666a:	2781                	sext.w	a5,a5
    8000666c:	2781                	sext.w	a5,a5
    8000666e:	85be                	mv	a1,a5
    80006670:	8536                	mv	a0,a3
    80006672:	ffffe097          	auipc	ra,0xffffe
    80006676:	3ca080e7          	jalr	970(ra) # 80004a3c <bread>
    8000667a:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000667e:	00067797          	auipc	a5,0x67
    80006682:	5d278793          	addi	a5,a5,1490 # 8006dc50 <log>
    80006686:	579c                	lw	a5,40(a5)
    80006688:	0007869b          	sext.w	a3,a5
    8000668c:	00067717          	auipc	a4,0x67
    80006690:	5c470713          	addi	a4,a4,1476 # 8006dc50 <log>
    80006694:	fec42783          	lw	a5,-20(s0)
    80006698:	07a1                	addi	a5,a5,8
    8000669a:	078a                	slli	a5,a5,0x2
    8000669c:	97ba                	add	a5,a5,a4
    8000669e:	4b9c                	lw	a5,16(a5)
    800066a0:	2781                	sext.w	a5,a5
    800066a2:	85be                	mv	a1,a5
    800066a4:	8536                	mv	a0,a3
    800066a6:	ffffe097          	auipc	ra,0xffffe
    800066aa:	396080e7          	jalr	918(ra) # 80004a3c <bread>
    800066ae:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    800066b2:	fe043783          	ld	a5,-32(s0)
    800066b6:	05878713          	addi	a4,a5,88
    800066ba:	fd843783          	ld	a5,-40(s0)
    800066be:	05878793          	addi	a5,a5,88
    800066c2:	40000613          	li	a2,1024
    800066c6:	85be                	mv	a1,a5
    800066c8:	853a                	mv	a0,a4
    800066ca:	ffffb097          	auipc	ra,0xffffb
    800066ce:	e6e080e7          	jalr	-402(ra) # 80001538 <memmove>
    bwrite(to);  // write the log
    800066d2:	fe043503          	ld	a0,-32(s0)
    800066d6:	ffffe097          	auipc	ra,0xffffe
    800066da:	3c0080e7          	jalr	960(ra) # 80004a96 <bwrite>
    brelse(from);
    800066de:	fd843503          	ld	a0,-40(s0)
    800066e2:	ffffe097          	auipc	ra,0xffffe
    800066e6:	3fc080e7          	jalr	1020(ra) # 80004ade <brelse>
    brelse(to);
    800066ea:	fe043503          	ld	a0,-32(s0)
    800066ee:	ffffe097          	auipc	ra,0xffffe
    800066f2:	3f0080e7          	jalr	1008(ra) # 80004ade <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800066f6:	fec42783          	lw	a5,-20(s0)
    800066fa:	2785                	addiw	a5,a5,1
    800066fc:	fef42623          	sw	a5,-20(s0)
    80006700:	00067797          	auipc	a5,0x67
    80006704:	55078793          	addi	a5,a5,1360 # 8006dc50 <log>
    80006708:	57d8                	lw	a4,44(a5)
    8000670a:	fec42783          	lw	a5,-20(s0)
    8000670e:	2781                	sext.w	a5,a5
    80006710:	f2e7cce3          	blt	a5,a4,80006648 <write_log+0xe>
  }
}
    80006714:	0001                	nop
    80006716:	0001                	nop
    80006718:	70a2                	ld	ra,40(sp)
    8000671a:	7402                	ld	s0,32(sp)
    8000671c:	6145                	addi	sp,sp,48
    8000671e:	8082                	ret

0000000080006720 <commit>:

static void
commit()
{
    80006720:	1141                	addi	sp,sp,-16
    80006722:	e406                	sd	ra,8(sp)
    80006724:	e022                	sd	s0,0(sp)
    80006726:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006728:	00067797          	auipc	a5,0x67
    8000672c:	52878793          	addi	a5,a5,1320 # 8006dc50 <log>
    80006730:	57dc                	lw	a5,44(a5)
    80006732:	02f05963          	blez	a5,80006764 <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    80006736:	00000097          	auipc	ra,0x0
    8000673a:	f04080e7          	jalr	-252(ra) # 8000663a <write_log>
    write_head();    // Write header to disk -- the real commit
    8000673e:	00000097          	auipc	ra,0x0
    80006742:	c64080e7          	jalr	-924(ra) # 800063a2 <write_head>
    install_trans(0); // Now install writes to home locations
    80006746:	4501                	li	a0,0
    80006748:	00000097          	auipc	ra,0x0
    8000674c:	ab0080e7          	jalr	-1360(ra) # 800061f8 <install_trans>
    log.lh.n = 0;
    80006750:	00067797          	auipc	a5,0x67
    80006754:	50078793          	addi	a5,a5,1280 # 8006dc50 <log>
    80006758:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    8000675c:	00000097          	auipc	ra,0x0
    80006760:	c46080e7          	jalr	-954(ra) # 800063a2 <write_head>
  }
}
    80006764:	0001                	nop
    80006766:	60a2                	ld	ra,8(sp)
    80006768:	6402                	ld	s0,0(sp)
    8000676a:	0141                	addi	sp,sp,16
    8000676c:	8082                	ret

000000008000676e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000676e:	7179                	addi	sp,sp,-48
    80006770:	f406                	sd	ra,40(sp)
    80006772:	f022                	sd	s0,32(sp)
    80006774:	1800                	addi	s0,sp,48
    80006776:	fca43c23          	sd	a0,-40(s0)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000677a:	00067797          	auipc	a5,0x67
    8000677e:	4d678793          	addi	a5,a5,1238 # 8006dc50 <log>
    80006782:	57dc                	lw	a5,44(a5)
    80006784:	873e                	mv	a4,a5
    80006786:	47f5                	li	a5,29
    80006788:	02e7c063          	blt	a5,a4,800067a8 <log_write+0x3a>
    8000678c:	00067797          	auipc	a5,0x67
    80006790:	4c478793          	addi	a5,a5,1220 # 8006dc50 <log>
    80006794:	57d8                	lw	a4,44(a5)
    80006796:	00067797          	auipc	a5,0x67
    8000679a:	4ba78793          	addi	a5,a5,1210 # 8006dc50 <log>
    8000679e:	4fdc                	lw	a5,28(a5)
    800067a0:	37fd                	addiw	a5,a5,-1
    800067a2:	2781                	sext.w	a5,a5
    800067a4:	00f74a63          	blt	a4,a5,800067b8 <log_write+0x4a>
    panic("too big a transaction");
    800067a8:	00005517          	auipc	a0,0x5
    800067ac:	d9050513          	addi	a0,a0,-624 # 8000b538 <etext+0x538>
    800067b0:	ffffa097          	auipc	ra,0xffffa
    800067b4:	4a2080e7          	jalr	1186(ra) # 80000c52 <panic>
  if (log.outstanding < 1)
    800067b8:	00067797          	auipc	a5,0x67
    800067bc:	49878793          	addi	a5,a5,1176 # 8006dc50 <log>
    800067c0:	539c                	lw	a5,32(a5)
    800067c2:	00f04a63          	bgtz	a5,800067d6 <log_write+0x68>
    panic("log_write outside of trans");
    800067c6:	00005517          	auipc	a0,0x5
    800067ca:	d8a50513          	addi	a0,a0,-630 # 8000b550 <etext+0x550>
    800067ce:	ffffa097          	auipc	ra,0xffffa
    800067d2:	484080e7          	jalr	1156(ra) # 80000c52 <panic>

  acquire(&log.lock);
    800067d6:	00067517          	auipc	a0,0x67
    800067da:	47a50513          	addi	a0,a0,1146 # 8006dc50 <log>
    800067de:	ffffb097          	auipc	ra,0xffffb
    800067e2:	aa2080e7          	jalr	-1374(ra) # 80001280 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    800067e6:	fe042623          	sw	zero,-20(s0)
    800067ea:	a03d                	j	80006818 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    800067ec:	00067717          	auipc	a4,0x67
    800067f0:	46470713          	addi	a4,a4,1124 # 8006dc50 <log>
    800067f4:	fec42783          	lw	a5,-20(s0)
    800067f8:	07a1                	addi	a5,a5,8
    800067fa:	078a                	slli	a5,a5,0x2
    800067fc:	97ba                	add	a5,a5,a4
    800067fe:	4b9c                	lw	a5,16(a5)
    80006800:	0007871b          	sext.w	a4,a5
    80006804:	fd843783          	ld	a5,-40(s0)
    80006808:	47dc                	lw	a5,12(a5)
    8000680a:	02f70263          	beq	a4,a5,8000682e <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    8000680e:	fec42783          	lw	a5,-20(s0)
    80006812:	2785                	addiw	a5,a5,1
    80006814:	fef42623          	sw	a5,-20(s0)
    80006818:	00067797          	auipc	a5,0x67
    8000681c:	43878793          	addi	a5,a5,1080 # 8006dc50 <log>
    80006820:	57d8                	lw	a4,44(a5)
    80006822:	fec42783          	lw	a5,-20(s0)
    80006826:	2781                	sext.w	a5,a5
    80006828:	fce7c2e3          	blt	a5,a4,800067ec <log_write+0x7e>
    8000682c:	a011                	j	80006830 <log_write+0xc2>
      break;
    8000682e:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006830:	fd843783          	ld	a5,-40(s0)
    80006834:	47dc                	lw	a5,12(a5)
    80006836:	0007871b          	sext.w	a4,a5
    8000683a:	00067697          	auipc	a3,0x67
    8000683e:	41668693          	addi	a3,a3,1046 # 8006dc50 <log>
    80006842:	fec42783          	lw	a5,-20(s0)
    80006846:	07a1                	addi	a5,a5,8
    80006848:	078a                	slli	a5,a5,0x2
    8000684a:	97b6                	add	a5,a5,a3
    8000684c:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    8000684e:	00067797          	auipc	a5,0x67
    80006852:	40278793          	addi	a5,a5,1026 # 8006dc50 <log>
    80006856:	57d8                	lw	a4,44(a5)
    80006858:	fec42783          	lw	a5,-20(s0)
    8000685c:	2781                	sext.w	a5,a5
    8000685e:	02e79563          	bne	a5,a4,80006888 <log_write+0x11a>
    bpin(b);
    80006862:	fd843503          	ld	a0,-40(s0)
    80006866:	ffffe097          	auipc	ra,0xffffe
    8000686a:	366080e7          	jalr	870(ra) # 80004bcc <bpin>
    log.lh.n++;
    8000686e:	00067797          	auipc	a5,0x67
    80006872:	3e278793          	addi	a5,a5,994 # 8006dc50 <log>
    80006876:	57dc                	lw	a5,44(a5)
    80006878:	2785                	addiw	a5,a5,1
    8000687a:	0007871b          	sext.w	a4,a5
    8000687e:	00067797          	auipc	a5,0x67
    80006882:	3d278793          	addi	a5,a5,978 # 8006dc50 <log>
    80006886:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    80006888:	00067517          	auipc	a0,0x67
    8000688c:	3c850513          	addi	a0,a0,968 # 8006dc50 <log>
    80006890:	ffffb097          	auipc	ra,0xffffb
    80006894:	a54080e7          	jalr	-1452(ra) # 800012e4 <release>
}
    80006898:	0001                	nop
    8000689a:	70a2                	ld	ra,40(sp)
    8000689c:	7402                	ld	s0,32(sp)
    8000689e:	6145                	addi	sp,sp,48
    800068a0:	8082                	ret

00000000800068a2 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800068a2:	1101                	addi	sp,sp,-32
    800068a4:	ec06                	sd	ra,24(sp)
    800068a6:	e822                	sd	s0,16(sp)
    800068a8:	1000                	addi	s0,sp,32
    800068aa:	fea43423          	sd	a0,-24(s0)
    800068ae:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    800068b2:	fe843783          	ld	a5,-24(s0)
    800068b6:	07a1                	addi	a5,a5,8
    800068b8:	00005597          	auipc	a1,0x5
    800068bc:	cb858593          	addi	a1,a1,-840 # 8000b570 <etext+0x570>
    800068c0:	853e                	mv	a0,a5
    800068c2:	ffffb097          	auipc	ra,0xffffb
    800068c6:	98e080e7          	jalr	-1650(ra) # 80001250 <initlock>
  lk->name = name;
    800068ca:	fe843783          	ld	a5,-24(s0)
    800068ce:	fe043703          	ld	a4,-32(s0)
    800068d2:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    800068d4:	fe843783          	ld	a5,-24(s0)
    800068d8:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800068dc:	fe843783          	ld	a5,-24(s0)
    800068e0:	0207a423          	sw	zero,40(a5)
}
    800068e4:	0001                	nop
    800068e6:	60e2                	ld	ra,24(sp)
    800068e8:	6442                	ld	s0,16(sp)
    800068ea:	6105                	addi	sp,sp,32
    800068ec:	8082                	ret

00000000800068ee <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800068ee:	1101                	addi	sp,sp,-32
    800068f0:	ec06                	sd	ra,24(sp)
    800068f2:	e822                	sd	s0,16(sp)
    800068f4:	1000                	addi	s0,sp,32
    800068f6:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800068fa:	fe843783          	ld	a5,-24(s0)
    800068fe:	07a1                	addi	a5,a5,8
    80006900:	853e                	mv	a0,a5
    80006902:	ffffb097          	auipc	ra,0xffffb
    80006906:	97e080e7          	jalr	-1666(ra) # 80001280 <acquire>
  while (lk->locked) {
    8000690a:	a819                	j	80006920 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    8000690c:	fe843783          	ld	a5,-24(s0)
    80006910:	07a1                	addi	a5,a5,8
    80006912:	85be                	mv	a1,a5
    80006914:	fe843503          	ld	a0,-24(s0)
    80006918:	ffffd097          	auipc	ra,0xffffd
    8000691c:	c2c080e7          	jalr	-980(ra) # 80003544 <sleep>
  while (lk->locked) {
    80006920:	fe843783          	ld	a5,-24(s0)
    80006924:	439c                	lw	a5,0(a5)
    80006926:	f3fd                	bnez	a5,8000690c <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80006928:	fe843783          	ld	a5,-24(s0)
    8000692c:	4705                	li	a4,1
    8000692e:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80006930:	ffffc097          	auipc	ra,0xffffc
    80006934:	ec8080e7          	jalr	-312(ra) # 800027f8 <myproc>
    80006938:	87aa                	mv	a5,a0
    8000693a:	5f98                	lw	a4,56(a5)
    8000693c:	fe843783          	ld	a5,-24(s0)
    80006940:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    80006942:	fe843783          	ld	a5,-24(s0)
    80006946:	07a1                	addi	a5,a5,8
    80006948:	853e                	mv	a0,a5
    8000694a:	ffffb097          	auipc	ra,0xffffb
    8000694e:	99a080e7          	jalr	-1638(ra) # 800012e4 <release>
}
    80006952:	0001                	nop
    80006954:	60e2                	ld	ra,24(sp)
    80006956:	6442                	ld	s0,16(sp)
    80006958:	6105                	addi	sp,sp,32
    8000695a:	8082                	ret

000000008000695c <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000695c:	1101                	addi	sp,sp,-32
    8000695e:	ec06                	sd	ra,24(sp)
    80006960:	e822                	sd	s0,16(sp)
    80006962:	1000                	addi	s0,sp,32
    80006964:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006968:	fe843783          	ld	a5,-24(s0)
    8000696c:	07a1                	addi	a5,a5,8
    8000696e:	853e                	mv	a0,a5
    80006970:	ffffb097          	auipc	ra,0xffffb
    80006974:	910080e7          	jalr	-1776(ra) # 80001280 <acquire>
  lk->locked = 0;
    80006978:	fe843783          	ld	a5,-24(s0)
    8000697c:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006980:	fe843783          	ld	a5,-24(s0)
    80006984:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    80006988:	fe843503          	ld	a0,-24(s0)
    8000698c:	ffffd097          	auipc	ra,0xffffd
    80006990:	c4c080e7          	jalr	-948(ra) # 800035d8 <wakeup>
  release(&lk->lk);
    80006994:	fe843783          	ld	a5,-24(s0)
    80006998:	07a1                	addi	a5,a5,8
    8000699a:	853e                	mv	a0,a5
    8000699c:	ffffb097          	auipc	ra,0xffffb
    800069a0:	948080e7          	jalr	-1720(ra) # 800012e4 <release>
}
    800069a4:	0001                	nop
    800069a6:	60e2                	ld	ra,24(sp)
    800069a8:	6442                	ld	s0,16(sp)
    800069aa:	6105                	addi	sp,sp,32
    800069ac:	8082                	ret

00000000800069ae <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800069ae:	7139                	addi	sp,sp,-64
    800069b0:	fc06                	sd	ra,56(sp)
    800069b2:	f822                	sd	s0,48(sp)
    800069b4:	f426                	sd	s1,40(sp)
    800069b6:	0080                	addi	s0,sp,64
    800069b8:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    800069bc:	fc843783          	ld	a5,-56(s0)
    800069c0:	07a1                	addi	a5,a5,8
    800069c2:	853e                	mv	a0,a5
    800069c4:	ffffb097          	auipc	ra,0xffffb
    800069c8:	8bc080e7          	jalr	-1860(ra) # 80001280 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800069cc:	fc843783          	ld	a5,-56(s0)
    800069d0:	439c                	lw	a5,0(a5)
    800069d2:	cf99                	beqz	a5,800069f0 <holdingsleep+0x42>
    800069d4:	fc843783          	ld	a5,-56(s0)
    800069d8:	5784                	lw	s1,40(a5)
    800069da:	ffffc097          	auipc	ra,0xffffc
    800069de:	e1e080e7          	jalr	-482(ra) # 800027f8 <myproc>
    800069e2:	87aa                	mv	a5,a0
    800069e4:	5f9c                	lw	a5,56(a5)
    800069e6:	8726                	mv	a4,s1
    800069e8:	00f71463          	bne	a4,a5,800069f0 <holdingsleep+0x42>
    800069ec:	4785                	li	a5,1
    800069ee:	a011                	j	800069f2 <holdingsleep+0x44>
    800069f0:	4781                	li	a5,0
    800069f2:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    800069f6:	fc843783          	ld	a5,-56(s0)
    800069fa:	07a1                	addi	a5,a5,8
    800069fc:	853e                	mv	a0,a5
    800069fe:	ffffb097          	auipc	ra,0xffffb
    80006a02:	8e6080e7          	jalr	-1818(ra) # 800012e4 <release>
  return r;
    80006a06:	fdc42783          	lw	a5,-36(s0)
}
    80006a0a:	853e                	mv	a0,a5
    80006a0c:	70e2                	ld	ra,56(sp)
    80006a0e:	7442                	ld	s0,48(sp)
    80006a10:	74a2                	ld	s1,40(sp)
    80006a12:	6121                	addi	sp,sp,64
    80006a14:	8082                	ret

0000000080006a16 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80006a16:	1141                	addi	sp,sp,-16
    80006a18:	e406                	sd	ra,8(sp)
    80006a1a:	e022                	sd	s0,0(sp)
    80006a1c:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006a1e:	00005597          	auipc	a1,0x5
    80006a22:	b6258593          	addi	a1,a1,-1182 # 8000b580 <etext+0x580>
    80006a26:	00067517          	auipc	a0,0x67
    80006a2a:	37250513          	addi	a0,a0,882 # 8006dd98 <ftable>
    80006a2e:	ffffb097          	auipc	ra,0xffffb
    80006a32:	822080e7          	jalr	-2014(ra) # 80001250 <initlock>
}
    80006a36:	0001                	nop
    80006a38:	60a2                	ld	ra,8(sp)
    80006a3a:	6402                	ld	s0,0(sp)
    80006a3c:	0141                	addi	sp,sp,16
    80006a3e:	8082                	ret

0000000080006a40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006a40:	1101                	addi	sp,sp,-32
    80006a42:	ec06                	sd	ra,24(sp)
    80006a44:	e822                	sd	s0,16(sp)
    80006a46:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80006a48:	00067517          	auipc	a0,0x67
    80006a4c:	35050513          	addi	a0,a0,848 # 8006dd98 <ftable>
    80006a50:	ffffb097          	auipc	ra,0xffffb
    80006a54:	830080e7          	jalr	-2000(ra) # 80001280 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006a58:	00067797          	auipc	a5,0x67
    80006a5c:	35878793          	addi	a5,a5,856 # 8006ddb0 <ftable+0x18>
    80006a60:	fef43423          	sd	a5,-24(s0)
    80006a64:	a815                	j	80006a98 <filealloc+0x58>
    if(f->ref == 0){
    80006a66:	fe843783          	ld	a5,-24(s0)
    80006a6a:	43dc                	lw	a5,4(a5)
    80006a6c:	e385                	bnez	a5,80006a8c <filealloc+0x4c>
      f->ref = 1;
    80006a6e:	fe843783          	ld	a5,-24(s0)
    80006a72:	4705                	li	a4,1
    80006a74:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    80006a76:	00067517          	auipc	a0,0x67
    80006a7a:	32250513          	addi	a0,a0,802 # 8006dd98 <ftable>
    80006a7e:	ffffb097          	auipc	ra,0xffffb
    80006a82:	866080e7          	jalr	-1946(ra) # 800012e4 <release>
      return f;
    80006a86:	fe843783          	ld	a5,-24(s0)
    80006a8a:	a805                	j	80006aba <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006a8c:	fe843783          	ld	a5,-24(s0)
    80006a90:	02878793          	addi	a5,a5,40
    80006a94:	fef43423          	sd	a5,-24(s0)
    80006a98:	00068797          	auipc	a5,0x68
    80006a9c:	2b878793          	addi	a5,a5,696 # 8006ed50 <ftable+0xfb8>
    80006aa0:	fe843703          	ld	a4,-24(s0)
    80006aa4:	fcf761e3          	bltu	a4,a5,80006a66 <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    80006aa8:	00067517          	auipc	a0,0x67
    80006aac:	2f050513          	addi	a0,a0,752 # 8006dd98 <ftable>
    80006ab0:	ffffb097          	auipc	ra,0xffffb
    80006ab4:	834080e7          	jalr	-1996(ra) # 800012e4 <release>
  return 0;
    80006ab8:	4781                	li	a5,0
}
    80006aba:	853e                	mv	a0,a5
    80006abc:	60e2                	ld	ra,24(sp)
    80006abe:	6442                	ld	s0,16(sp)
    80006ac0:	6105                	addi	sp,sp,32
    80006ac2:	8082                	ret

0000000080006ac4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80006ac4:	1101                	addi	sp,sp,-32
    80006ac6:	ec06                	sd	ra,24(sp)
    80006ac8:	e822                	sd	s0,16(sp)
    80006aca:	1000                	addi	s0,sp,32
    80006acc:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80006ad0:	00067517          	auipc	a0,0x67
    80006ad4:	2c850513          	addi	a0,a0,712 # 8006dd98 <ftable>
    80006ad8:	ffffa097          	auipc	ra,0xffffa
    80006adc:	7a8080e7          	jalr	1960(ra) # 80001280 <acquire>
  if(f->ref < 1)
    80006ae0:	fe843783          	ld	a5,-24(s0)
    80006ae4:	43dc                	lw	a5,4(a5)
    80006ae6:	00f04a63          	bgtz	a5,80006afa <filedup+0x36>
    panic("filedup");
    80006aea:	00005517          	auipc	a0,0x5
    80006aee:	a9e50513          	addi	a0,a0,-1378 # 8000b588 <etext+0x588>
    80006af2:	ffffa097          	auipc	ra,0xffffa
    80006af6:	160080e7          	jalr	352(ra) # 80000c52 <panic>
  f->ref++;
    80006afa:	fe843783          	ld	a5,-24(s0)
    80006afe:	43dc                	lw	a5,4(a5)
    80006b00:	2785                	addiw	a5,a5,1
    80006b02:	0007871b          	sext.w	a4,a5
    80006b06:	fe843783          	ld	a5,-24(s0)
    80006b0a:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006b0c:	00067517          	auipc	a0,0x67
    80006b10:	28c50513          	addi	a0,a0,652 # 8006dd98 <ftable>
    80006b14:	ffffa097          	auipc	ra,0xffffa
    80006b18:	7d0080e7          	jalr	2000(ra) # 800012e4 <release>
  return f;
    80006b1c:	fe843783          	ld	a5,-24(s0)
}
    80006b20:	853e                	mv	a0,a5
    80006b22:	60e2                	ld	ra,24(sp)
    80006b24:	6442                	ld	s0,16(sp)
    80006b26:	6105                	addi	sp,sp,32
    80006b28:	8082                	ret

0000000080006b2a <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006b2a:	715d                	addi	sp,sp,-80
    80006b2c:	e486                	sd	ra,72(sp)
    80006b2e:	e0a2                	sd	s0,64(sp)
    80006b30:	0880                	addi	s0,sp,80
    80006b32:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006b36:	00067517          	auipc	a0,0x67
    80006b3a:	26250513          	addi	a0,a0,610 # 8006dd98 <ftable>
    80006b3e:	ffffa097          	auipc	ra,0xffffa
    80006b42:	742080e7          	jalr	1858(ra) # 80001280 <acquire>
  if(f->ref < 1)
    80006b46:	fb843783          	ld	a5,-72(s0)
    80006b4a:	43dc                	lw	a5,4(a5)
    80006b4c:	00f04a63          	bgtz	a5,80006b60 <fileclose+0x36>
    panic("fileclose");
    80006b50:	00005517          	auipc	a0,0x5
    80006b54:	a4050513          	addi	a0,a0,-1472 # 8000b590 <etext+0x590>
    80006b58:	ffffa097          	auipc	ra,0xffffa
    80006b5c:	0fa080e7          	jalr	250(ra) # 80000c52 <panic>
  if(--f->ref > 0){
    80006b60:	fb843783          	ld	a5,-72(s0)
    80006b64:	43dc                	lw	a5,4(a5)
    80006b66:	37fd                	addiw	a5,a5,-1
    80006b68:	0007871b          	sext.w	a4,a5
    80006b6c:	fb843783          	ld	a5,-72(s0)
    80006b70:	c3d8                	sw	a4,4(a5)
    80006b72:	fb843783          	ld	a5,-72(s0)
    80006b76:	43dc                	lw	a5,4(a5)
    80006b78:	00f05b63          	blez	a5,80006b8e <fileclose+0x64>
    release(&ftable.lock);
    80006b7c:	00067517          	auipc	a0,0x67
    80006b80:	21c50513          	addi	a0,a0,540 # 8006dd98 <ftable>
    80006b84:	ffffa097          	auipc	ra,0xffffa
    80006b88:	760080e7          	jalr	1888(ra) # 800012e4 <release>
    80006b8c:	a879                	j	80006c2a <fileclose+0x100>
    return;
  }
  ff = *f;
    80006b8e:	fb843783          	ld	a5,-72(s0)
    80006b92:	638c                	ld	a1,0(a5)
    80006b94:	6790                	ld	a2,8(a5)
    80006b96:	6b94                	ld	a3,16(a5)
    80006b98:	6f98                	ld	a4,24(a5)
    80006b9a:	739c                	ld	a5,32(a5)
    80006b9c:	fcb43423          	sd	a1,-56(s0)
    80006ba0:	fcc43823          	sd	a2,-48(s0)
    80006ba4:	fcd43c23          	sd	a3,-40(s0)
    80006ba8:	fee43023          	sd	a4,-32(s0)
    80006bac:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006bb0:	fb843783          	ld	a5,-72(s0)
    80006bb4:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    80006bb8:	fb843783          	ld	a5,-72(s0)
    80006bbc:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006bc0:	00067517          	auipc	a0,0x67
    80006bc4:	1d850513          	addi	a0,a0,472 # 8006dd98 <ftable>
    80006bc8:	ffffa097          	auipc	ra,0xffffa
    80006bcc:	71c080e7          	jalr	1820(ra) # 800012e4 <release>

  if(ff.type == FD_PIPE){
    80006bd0:	fc842783          	lw	a5,-56(s0)
    80006bd4:	873e                	mv	a4,a5
    80006bd6:	4785                	li	a5,1
    80006bd8:	00f71e63          	bne	a4,a5,80006bf4 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80006bdc:	fd843783          	ld	a5,-40(s0)
    80006be0:	fd144703          	lbu	a4,-47(s0)
    80006be4:	2701                	sext.w	a4,a4
    80006be6:	85ba                	mv	a1,a4
    80006be8:	853e                	mv	a0,a5
    80006bea:	00000097          	auipc	ra,0x0
    80006bee:	5ca080e7          	jalr	1482(ra) # 800071b4 <pipeclose>
    80006bf2:	a825                	j	80006c2a <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80006bf4:	fc842783          	lw	a5,-56(s0)
    80006bf8:	873e                	mv	a4,a5
    80006bfa:	4789                	li	a5,2
    80006bfc:	00f70863          	beq	a4,a5,80006c0c <fileclose+0xe2>
    80006c00:	fc842783          	lw	a5,-56(s0)
    80006c04:	873e                	mv	a4,a5
    80006c06:	478d                	li	a5,3
    80006c08:	02f71163          	bne	a4,a5,80006c2a <fileclose+0x100>
    begin_op();
    80006c0c:	00000097          	auipc	ra,0x0
    80006c10:	884080e7          	jalr	-1916(ra) # 80006490 <begin_op>
    iput(ff.ip);
    80006c14:	fe043783          	ld	a5,-32(s0)
    80006c18:	853e                	mv	a0,a5
    80006c1a:	fffff097          	auipc	ra,0xfffff
    80006c1e:	998080e7          	jalr	-1640(ra) # 800055b2 <iput>
    end_op();
    80006c22:	00000097          	auipc	ra,0x0
    80006c26:	930080e7          	jalr	-1744(ra) # 80006552 <end_op>
  }
}
    80006c2a:	60a6                	ld	ra,72(sp)
    80006c2c:	6406                	ld	s0,64(sp)
    80006c2e:	6161                	addi	sp,sp,80
    80006c30:	8082                	ret

0000000080006c32 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80006c32:	7139                	addi	sp,sp,-64
    80006c34:	fc06                	sd	ra,56(sp)
    80006c36:	f822                	sd	s0,48(sp)
    80006c38:	0080                	addi	s0,sp,64
    80006c3a:	fca43423          	sd	a0,-56(s0)
    80006c3e:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    80006c42:	ffffc097          	auipc	ra,0xffffc
    80006c46:	bb6080e7          	jalr	-1098(ra) # 800027f8 <myproc>
    80006c4a:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006c4e:	fc843783          	ld	a5,-56(s0)
    80006c52:	439c                	lw	a5,0(a5)
    80006c54:	873e                	mv	a4,a5
    80006c56:	4789                	li	a5,2
    80006c58:	00f70963          	beq	a4,a5,80006c6a <filestat+0x38>
    80006c5c:	fc843783          	ld	a5,-56(s0)
    80006c60:	439c                	lw	a5,0(a5)
    80006c62:	873e                	mv	a4,a5
    80006c64:	478d                	li	a5,3
    80006c66:	06f71563          	bne	a4,a5,80006cd0 <filestat+0x9e>
    ilock(f->ip);
    80006c6a:	fc843783          	ld	a5,-56(s0)
    80006c6e:	6f9c                	ld	a5,24(a5)
    80006c70:	853e                	mv	a0,a5
    80006c72:	ffffe097          	auipc	ra,0xffffe
    80006c76:	7b2080e7          	jalr	1970(ra) # 80005424 <ilock>
    stati(f->ip, &st);
    80006c7a:	fc843783          	ld	a5,-56(s0)
    80006c7e:	6f9c                	ld	a5,24(a5)
    80006c80:	fd040713          	addi	a4,s0,-48
    80006c84:	85ba                	mv	a1,a4
    80006c86:	853e                	mv	a0,a5
    80006c88:	fffff097          	auipc	ra,0xfffff
    80006c8c:	cce080e7          	jalr	-818(ra) # 80005956 <stati>
    iunlock(f->ip);
    80006c90:	fc843783          	ld	a5,-56(s0)
    80006c94:	6f9c                	ld	a5,24(a5)
    80006c96:	853e                	mv	a0,a5
    80006c98:	fffff097          	auipc	ra,0xfffff
    80006c9c:	8c0080e7          	jalr	-1856(ra) # 80005558 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80006ca0:	fe843703          	ld	a4,-24(s0)
    80006ca4:	6785                	lui	a5,0x1
    80006ca6:	97ba                	add	a5,a5,a4
    80006ca8:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80006cac:	fd040713          	addi	a4,s0,-48
    80006cb0:	46e1                	li	a3,24
    80006cb2:	863a                	mv	a2,a4
    80006cb4:	fc043583          	ld	a1,-64(s0)
    80006cb8:	853e                	mv	a0,a5
    80006cba:	ffffb097          	auipc	ra,0xffffb
    80006cbe:	61a080e7          	jalr	1562(ra) # 800022d4 <copyout>
    80006cc2:	87aa                	mv	a5,a0
    80006cc4:	0007d463          	bgez	a5,80006ccc <filestat+0x9a>
      return -1;
    80006cc8:	57fd                	li	a5,-1
    80006cca:	a021                	j	80006cd2 <filestat+0xa0>
    return 0;
    80006ccc:	4781                	li	a5,0
    80006cce:	a011                	j	80006cd2 <filestat+0xa0>
  }
  return -1;
    80006cd0:	57fd                	li	a5,-1
}
    80006cd2:	853e                	mv	a0,a5
    80006cd4:	70e2                	ld	ra,56(sp)
    80006cd6:	7442                	ld	s0,48(sp)
    80006cd8:	6121                	addi	sp,sp,64
    80006cda:	8082                	ret

0000000080006cdc <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80006cdc:	7139                	addi	sp,sp,-64
    80006cde:	fc06                	sd	ra,56(sp)
    80006ce0:	f822                	sd	s0,48(sp)
    80006ce2:	0080                	addi	s0,sp,64
    80006ce4:	fca43c23          	sd	a0,-40(s0)
    80006ce8:	fcb43823          	sd	a1,-48(s0)
    80006cec:	87b2                	mv	a5,a2
    80006cee:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80006cf2:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80006cf6:	fd843783          	ld	a5,-40(s0)
    80006cfa:	0087c783          	lbu	a5,8(a5)
    80006cfe:	e399                	bnez	a5,80006d04 <fileread+0x28>
    return -1;
    80006d00:	57fd                	li	a5,-1
    80006d02:	aa1d                	j	80006e38 <fileread+0x15c>

  if(f->type == FD_PIPE){
    80006d04:	fd843783          	ld	a5,-40(s0)
    80006d08:	439c                	lw	a5,0(a5)
    80006d0a:	873e                	mv	a4,a5
    80006d0c:	4785                	li	a5,1
    80006d0e:	02f71363          	bne	a4,a5,80006d34 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80006d12:	fd843783          	ld	a5,-40(s0)
    80006d16:	6b9c                	ld	a5,16(a5)
    80006d18:	fcc42703          	lw	a4,-52(s0)
    80006d1c:	863a                	mv	a2,a4
    80006d1e:	fd043583          	ld	a1,-48(s0)
    80006d22:	853e                	mv	a0,a5
    80006d24:	00000097          	auipc	ra,0x0
    80006d28:	686080e7          	jalr	1670(ra) # 800073aa <piperead>
    80006d2c:	87aa                	mv	a5,a0
    80006d2e:	fef42623          	sw	a5,-20(s0)
    80006d32:	a209                	j	80006e34 <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    80006d34:	fd843783          	ld	a5,-40(s0)
    80006d38:	439c                	lw	a5,0(a5)
    80006d3a:	873e                	mv	a4,a5
    80006d3c:	478d                	li	a5,3
    80006d3e:	06f71863          	bne	a4,a5,80006dae <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80006d42:	fd843783          	ld	a5,-40(s0)
    80006d46:	02479783          	lh	a5,36(a5)
    80006d4a:	2781                	sext.w	a5,a5
    80006d4c:	0207c863          	bltz	a5,80006d7c <fileread+0xa0>
    80006d50:	fd843783          	ld	a5,-40(s0)
    80006d54:	02479783          	lh	a5,36(a5)
    80006d58:	0007871b          	sext.w	a4,a5
    80006d5c:	47a5                	li	a5,9
    80006d5e:	00e7cf63          	blt	a5,a4,80006d7c <fileread+0xa0>
    80006d62:	fd843783          	ld	a5,-40(s0)
    80006d66:	02479783          	lh	a5,36(a5)
    80006d6a:	2781                	sext.w	a5,a5
    80006d6c:	00067717          	auipc	a4,0x67
    80006d70:	f8c70713          	addi	a4,a4,-116 # 8006dcf8 <devsw>
    80006d74:	0792                	slli	a5,a5,0x4
    80006d76:	97ba                	add	a5,a5,a4
    80006d78:	639c                	ld	a5,0(a5)
    80006d7a:	e399                	bnez	a5,80006d80 <fileread+0xa4>
      return -1;
    80006d7c:	57fd                	li	a5,-1
    80006d7e:	a86d                	j	80006e38 <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80006d80:	fd843783          	ld	a5,-40(s0)
    80006d84:	02479783          	lh	a5,36(a5)
    80006d88:	2781                	sext.w	a5,a5
    80006d8a:	00067717          	auipc	a4,0x67
    80006d8e:	f6e70713          	addi	a4,a4,-146 # 8006dcf8 <devsw>
    80006d92:	0792                	slli	a5,a5,0x4
    80006d94:	97ba                	add	a5,a5,a4
    80006d96:	6398                	ld	a4,0(a5)
    80006d98:	fcc42783          	lw	a5,-52(s0)
    80006d9c:	863e                	mv	a2,a5
    80006d9e:	fd043583          	ld	a1,-48(s0)
    80006da2:	4505                	li	a0,1
    80006da4:	9702                	jalr	a4
    80006da6:	87aa                	mv	a5,a0
    80006da8:	fef42623          	sw	a5,-20(s0)
    80006dac:	a061                	j	80006e34 <fileread+0x158>
  } else if(f->type == FD_INODE){
    80006dae:	fd843783          	ld	a5,-40(s0)
    80006db2:	439c                	lw	a5,0(a5)
    80006db4:	873e                	mv	a4,a5
    80006db6:	4789                	li	a5,2
    80006db8:	06f71663          	bne	a4,a5,80006e24 <fileread+0x148>
    ilock(f->ip);
    80006dbc:	fd843783          	ld	a5,-40(s0)
    80006dc0:	6f9c                	ld	a5,24(a5)
    80006dc2:	853e                	mv	a0,a5
    80006dc4:	ffffe097          	auipc	ra,0xffffe
    80006dc8:	660080e7          	jalr	1632(ra) # 80005424 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80006dcc:	fd843783          	ld	a5,-40(s0)
    80006dd0:	6f88                	ld	a0,24(a5)
    80006dd2:	fd843783          	ld	a5,-40(s0)
    80006dd6:	539c                	lw	a5,32(a5)
    80006dd8:	fcc42703          	lw	a4,-52(s0)
    80006ddc:	86be                	mv	a3,a5
    80006dde:	fd043603          	ld	a2,-48(s0)
    80006de2:	4585                	li	a1,1
    80006de4:	fffff097          	auipc	ra,0xfffff
    80006de8:	bd6080e7          	jalr	-1066(ra) # 800059ba <readi>
    80006dec:	87aa                	mv	a5,a0
    80006dee:	fef42623          	sw	a5,-20(s0)
    80006df2:	fec42783          	lw	a5,-20(s0)
    80006df6:	2781                	sext.w	a5,a5
    80006df8:	00f05d63          	blez	a5,80006e12 <fileread+0x136>
      f->off += r;
    80006dfc:	fd843783          	ld	a5,-40(s0)
    80006e00:	5398                	lw	a4,32(a5)
    80006e02:	fec42783          	lw	a5,-20(s0)
    80006e06:	9fb9                	addw	a5,a5,a4
    80006e08:	0007871b          	sext.w	a4,a5
    80006e0c:	fd843783          	ld	a5,-40(s0)
    80006e10:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80006e12:	fd843783          	ld	a5,-40(s0)
    80006e16:	6f9c                	ld	a5,24(a5)
    80006e18:	853e                	mv	a0,a5
    80006e1a:	ffffe097          	auipc	ra,0xffffe
    80006e1e:	73e080e7          	jalr	1854(ra) # 80005558 <iunlock>
    80006e22:	a809                	j	80006e34 <fileread+0x158>
  } else {
    panic("fileread");
    80006e24:	00004517          	auipc	a0,0x4
    80006e28:	77c50513          	addi	a0,a0,1916 # 8000b5a0 <etext+0x5a0>
    80006e2c:	ffffa097          	auipc	ra,0xffffa
    80006e30:	e26080e7          	jalr	-474(ra) # 80000c52 <panic>
  }

  return r;
    80006e34:	fec42783          	lw	a5,-20(s0)
}
    80006e38:	853e                	mv	a0,a5
    80006e3a:	70e2                	ld	ra,56(sp)
    80006e3c:	7442                	ld	s0,48(sp)
    80006e3e:	6121                	addi	sp,sp,64
    80006e40:	8082                	ret

0000000080006e42 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80006e42:	715d                	addi	sp,sp,-80
    80006e44:	e486                	sd	ra,72(sp)
    80006e46:	e0a2                	sd	s0,64(sp)
    80006e48:	0880                	addi	s0,sp,80
    80006e4a:	fca43423          	sd	a0,-56(s0)
    80006e4e:	fcb43023          	sd	a1,-64(s0)
    80006e52:	87b2                	mv	a5,a2
    80006e54:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80006e58:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80006e5c:	fc843783          	ld	a5,-56(s0)
    80006e60:	0097c783          	lbu	a5,9(a5)
    80006e64:	e399                	bnez	a5,80006e6a <filewrite+0x28>
    return -1;
    80006e66:	57fd                	li	a5,-1
    80006e68:	a2fd                	j	80007056 <filewrite+0x214>

  if(f->type == FD_PIPE){
    80006e6a:	fc843783          	ld	a5,-56(s0)
    80006e6e:	439c                	lw	a5,0(a5)
    80006e70:	873e                	mv	a4,a5
    80006e72:	4785                	li	a5,1
    80006e74:	02f71363          	bne	a4,a5,80006e9a <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    80006e78:	fc843783          	ld	a5,-56(s0)
    80006e7c:	6b9c                	ld	a5,16(a5)
    80006e7e:	fbc42703          	lw	a4,-68(s0)
    80006e82:	863a                	mv	a2,a4
    80006e84:	fc043583          	ld	a1,-64(s0)
    80006e88:	853e                	mv	a0,a5
    80006e8a:	00000097          	auipc	ra,0x0
    80006e8e:	3d2080e7          	jalr	978(ra) # 8000725c <pipewrite>
    80006e92:	87aa                	mv	a5,a0
    80006e94:	fef42623          	sw	a5,-20(s0)
    80006e98:	aa6d                	j	80007052 <filewrite+0x210>
  } else if(f->type == FD_DEVICE){
    80006e9a:	fc843783          	ld	a5,-56(s0)
    80006e9e:	439c                	lw	a5,0(a5)
    80006ea0:	873e                	mv	a4,a5
    80006ea2:	478d                	li	a5,3
    80006ea4:	06f71863          	bne	a4,a5,80006f14 <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006ea8:	fc843783          	ld	a5,-56(s0)
    80006eac:	02479783          	lh	a5,36(a5)
    80006eb0:	2781                	sext.w	a5,a5
    80006eb2:	0207c863          	bltz	a5,80006ee2 <filewrite+0xa0>
    80006eb6:	fc843783          	ld	a5,-56(s0)
    80006eba:	02479783          	lh	a5,36(a5)
    80006ebe:	0007871b          	sext.w	a4,a5
    80006ec2:	47a5                	li	a5,9
    80006ec4:	00e7cf63          	blt	a5,a4,80006ee2 <filewrite+0xa0>
    80006ec8:	fc843783          	ld	a5,-56(s0)
    80006ecc:	02479783          	lh	a5,36(a5)
    80006ed0:	2781                	sext.w	a5,a5
    80006ed2:	00067717          	auipc	a4,0x67
    80006ed6:	e2670713          	addi	a4,a4,-474 # 8006dcf8 <devsw>
    80006eda:	0792                	slli	a5,a5,0x4
    80006edc:	97ba                	add	a5,a5,a4
    80006ede:	679c                	ld	a5,8(a5)
    80006ee0:	e399                	bnez	a5,80006ee6 <filewrite+0xa4>
      return -1;
    80006ee2:	57fd                	li	a5,-1
    80006ee4:	aa8d                	j	80007056 <filewrite+0x214>
    ret = devsw[f->major].write(1, addr, n);
    80006ee6:	fc843783          	ld	a5,-56(s0)
    80006eea:	02479783          	lh	a5,36(a5)
    80006eee:	2781                	sext.w	a5,a5
    80006ef0:	00067717          	auipc	a4,0x67
    80006ef4:	e0870713          	addi	a4,a4,-504 # 8006dcf8 <devsw>
    80006ef8:	0792                	slli	a5,a5,0x4
    80006efa:	97ba                	add	a5,a5,a4
    80006efc:	6798                	ld	a4,8(a5)
    80006efe:	fbc42783          	lw	a5,-68(s0)
    80006f02:	863e                	mv	a2,a5
    80006f04:	fc043583          	ld	a1,-64(s0)
    80006f08:	4505                	li	a0,1
    80006f0a:	9702                	jalr	a4
    80006f0c:	87aa                	mv	a5,a0
    80006f0e:	fef42623          	sw	a5,-20(s0)
    80006f12:	a281                	j	80007052 <filewrite+0x210>
  } else if(f->type == FD_INODE){
    80006f14:	fc843783          	ld	a5,-56(s0)
    80006f18:	439c                	lw	a5,0(a5)
    80006f1a:	873e                	mv	a4,a5
    80006f1c:	4789                	li	a5,2
    80006f1e:	12f71263          	bne	a4,a5,80007042 <filewrite+0x200>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80006f22:	6785                	lui	a5,0x1
    80006f24:	c007879b          	addiw	a5,a5,-1024
    80006f28:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80006f2c:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80006f30:	a0c5                	j	80007010 <filewrite+0x1ce>
      int n1 = n - i;
    80006f32:	fbc42703          	lw	a4,-68(s0)
    80006f36:	fe842783          	lw	a5,-24(s0)
    80006f3a:	40f707bb          	subw	a5,a4,a5
    80006f3e:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80006f42:	fe442703          	lw	a4,-28(s0)
    80006f46:	fe042783          	lw	a5,-32(s0)
    80006f4a:	2701                	sext.w	a4,a4
    80006f4c:	2781                	sext.w	a5,a5
    80006f4e:	00e7d663          	bge	a5,a4,80006f5a <filewrite+0x118>
        n1 = max;
    80006f52:	fe042783          	lw	a5,-32(s0)
    80006f56:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80006f5a:	fffff097          	auipc	ra,0xfffff
    80006f5e:	536080e7          	jalr	1334(ra) # 80006490 <begin_op>
      ilock(f->ip);
    80006f62:	fc843783          	ld	a5,-56(s0)
    80006f66:	6f9c                	ld	a5,24(a5)
    80006f68:	853e                	mv	a0,a5
    80006f6a:	ffffe097          	auipc	ra,0xffffe
    80006f6e:	4ba080e7          	jalr	1210(ra) # 80005424 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80006f72:	fc843783          	ld	a5,-56(s0)
    80006f76:	6f88                	ld	a0,24(a5)
    80006f78:	fe842703          	lw	a4,-24(s0)
    80006f7c:	fc043783          	ld	a5,-64(s0)
    80006f80:	00f70633          	add	a2,a4,a5
    80006f84:	fc843783          	ld	a5,-56(s0)
    80006f88:	539c                	lw	a5,32(a5)
    80006f8a:	fe442703          	lw	a4,-28(s0)
    80006f8e:	86be                	mv	a3,a5
    80006f90:	4585                	li	a1,1
    80006f92:	fffff097          	auipc	ra,0xfffff
    80006f96:	bb2080e7          	jalr	-1102(ra) # 80005b44 <writei>
    80006f9a:	87aa                	mv	a5,a0
    80006f9c:	fcf42e23          	sw	a5,-36(s0)
    80006fa0:	fdc42783          	lw	a5,-36(s0)
    80006fa4:	2781                	sext.w	a5,a5
    80006fa6:	00f05d63          	blez	a5,80006fc0 <filewrite+0x17e>
        f->off += r;
    80006faa:	fc843783          	ld	a5,-56(s0)
    80006fae:	5398                	lw	a4,32(a5)
    80006fb0:	fdc42783          	lw	a5,-36(s0)
    80006fb4:	9fb9                	addw	a5,a5,a4
    80006fb6:	0007871b          	sext.w	a4,a5
    80006fba:	fc843783          	ld	a5,-56(s0)
    80006fbe:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80006fc0:	fc843783          	ld	a5,-56(s0)
    80006fc4:	6f9c                	ld	a5,24(a5)
    80006fc6:	853e                	mv	a0,a5
    80006fc8:	ffffe097          	auipc	ra,0xffffe
    80006fcc:	590080e7          	jalr	1424(ra) # 80005558 <iunlock>
      end_op();
    80006fd0:	fffff097          	auipc	ra,0xfffff
    80006fd4:	582080e7          	jalr	1410(ra) # 80006552 <end_op>

      if(r < 0)
    80006fd8:	fdc42783          	lw	a5,-36(s0)
    80006fdc:	2781                	sext.w	a5,a5
    80006fde:	0407c263          	bltz	a5,80007022 <filewrite+0x1e0>
        break;
      if(r != n1)
    80006fe2:	fdc42703          	lw	a4,-36(s0)
    80006fe6:	fe442783          	lw	a5,-28(s0)
    80006fea:	2701                	sext.w	a4,a4
    80006fec:	2781                	sext.w	a5,a5
    80006fee:	00f70a63          	beq	a4,a5,80007002 <filewrite+0x1c0>
        panic("short filewrite");
    80006ff2:	00004517          	auipc	a0,0x4
    80006ff6:	5be50513          	addi	a0,a0,1470 # 8000b5b0 <etext+0x5b0>
    80006ffa:	ffffa097          	auipc	ra,0xffffa
    80006ffe:	c58080e7          	jalr	-936(ra) # 80000c52 <panic>
      i += r;
    80007002:	fe842703          	lw	a4,-24(s0)
    80007006:	fdc42783          	lw	a5,-36(s0)
    8000700a:	9fb9                	addw	a5,a5,a4
    8000700c:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80007010:	fe842703          	lw	a4,-24(s0)
    80007014:	fbc42783          	lw	a5,-68(s0)
    80007018:	2701                	sext.w	a4,a4
    8000701a:	2781                	sext.w	a5,a5
    8000701c:	f0f74be3          	blt	a4,a5,80006f32 <filewrite+0xf0>
    80007020:	a011                	j	80007024 <filewrite+0x1e2>
        break;
    80007022:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80007024:	fe842703          	lw	a4,-24(s0)
    80007028:	fbc42783          	lw	a5,-68(s0)
    8000702c:	2701                	sext.w	a4,a4
    8000702e:	2781                	sext.w	a5,a5
    80007030:	00f71563          	bne	a4,a5,8000703a <filewrite+0x1f8>
    80007034:	fbc42783          	lw	a5,-68(s0)
    80007038:	a011                	j	8000703c <filewrite+0x1fa>
    8000703a:	57fd                	li	a5,-1
    8000703c:	fef42623          	sw	a5,-20(s0)
    80007040:	a809                	j	80007052 <filewrite+0x210>
  } else {
    panic("filewrite");
    80007042:	00004517          	auipc	a0,0x4
    80007046:	57e50513          	addi	a0,a0,1406 # 8000b5c0 <etext+0x5c0>
    8000704a:	ffffa097          	auipc	ra,0xffffa
    8000704e:	c08080e7          	jalr	-1016(ra) # 80000c52 <panic>
  }

  return ret;
    80007052:	fec42783          	lw	a5,-20(s0)
}
    80007056:	853e                	mv	a0,a5
    80007058:	60a6                	ld	ra,72(sp)
    8000705a:	6406                	ld	s0,64(sp)
    8000705c:	6161                	addi	sp,sp,80
    8000705e:	8082                	ret

0000000080007060 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80007060:	7179                	addi	sp,sp,-48
    80007062:	f406                	sd	ra,40(sp)
    80007064:	f022                	sd	s0,32(sp)
    80007066:	1800                	addi	s0,sp,48
    80007068:	fca43c23          	sd	a0,-40(s0)
    8000706c:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80007070:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80007074:	fd043783          	ld	a5,-48(s0)
    80007078:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
    8000707c:	fd043783          	ld	a5,-48(s0)
    80007080:	6398                	ld	a4,0(a5)
    80007082:	fd843783          	ld	a5,-40(s0)
    80007086:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80007088:	00000097          	auipc	ra,0x0
    8000708c:	9b8080e7          	jalr	-1608(ra) # 80006a40 <filealloc>
    80007090:	872a                	mv	a4,a0
    80007092:	fd843783          	ld	a5,-40(s0)
    80007096:	e398                	sd	a4,0(a5)
    80007098:	fd843783          	ld	a5,-40(s0)
    8000709c:	639c                	ld	a5,0(a5)
    8000709e:	c3e9                	beqz	a5,80007160 <pipealloc+0x100>
    800070a0:	00000097          	auipc	ra,0x0
    800070a4:	9a0080e7          	jalr	-1632(ra) # 80006a40 <filealloc>
    800070a8:	872a                	mv	a4,a0
    800070aa:	fd043783          	ld	a5,-48(s0)
    800070ae:	e398                	sd	a4,0(a5)
    800070b0:	fd043783          	ld	a5,-48(s0)
    800070b4:	639c                	ld	a5,0(a5)
    800070b6:	c7cd                	beqz	a5,80007160 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800070b8:	ffffa097          	auipc	ra,0xffffa
    800070bc:	074080e7          	jalr	116(ra) # 8000112c <kalloc>
    800070c0:	fea43423          	sd	a0,-24(s0)
    800070c4:	fe843783          	ld	a5,-24(s0)
    800070c8:	cfd1                	beqz	a5,80007164 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    800070ca:	fe843783          	ld	a5,-24(s0)
    800070ce:	4705                	li	a4,1
    800070d0:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    800070d4:	fe843783          	ld	a5,-24(s0)
    800070d8:	4705                	li	a4,1
    800070da:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    800070de:	fe843783          	ld	a5,-24(s0)
    800070e2:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    800070e6:	fe843783          	ld	a5,-24(s0)
    800070ea:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    800070ee:	fe843783          	ld	a5,-24(s0)
    800070f2:	00004597          	auipc	a1,0x4
    800070f6:	4de58593          	addi	a1,a1,1246 # 8000b5d0 <etext+0x5d0>
    800070fa:	853e                	mv	a0,a5
    800070fc:	ffffa097          	auipc	ra,0xffffa
    80007100:	154080e7          	jalr	340(ra) # 80001250 <initlock>
  (*f0)->type = FD_PIPE;
    80007104:	fd843783          	ld	a5,-40(s0)
    80007108:	639c                	ld	a5,0(a5)
    8000710a:	4705                	li	a4,1
    8000710c:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    8000710e:	fd843783          	ld	a5,-40(s0)
    80007112:	639c                	ld	a5,0(a5)
    80007114:	4705                	li	a4,1
    80007116:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    8000711a:	fd843783          	ld	a5,-40(s0)
    8000711e:	639c                	ld	a5,0(a5)
    80007120:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80007124:	fd843783          	ld	a5,-40(s0)
    80007128:	639c                	ld	a5,0(a5)
    8000712a:	fe843703          	ld	a4,-24(s0)
    8000712e:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80007130:	fd043783          	ld	a5,-48(s0)
    80007134:	639c                	ld	a5,0(a5)
    80007136:	4705                	li	a4,1
    80007138:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    8000713a:	fd043783          	ld	a5,-48(s0)
    8000713e:	639c                	ld	a5,0(a5)
    80007140:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80007144:	fd043783          	ld	a5,-48(s0)
    80007148:	639c                	ld	a5,0(a5)
    8000714a:	4705                	li	a4,1
    8000714c:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80007150:	fd043783          	ld	a5,-48(s0)
    80007154:	639c                	ld	a5,0(a5)
    80007156:	fe843703          	ld	a4,-24(s0)
    8000715a:	eb98                	sd	a4,16(a5)
  return 0;
    8000715c:	4781                	li	a5,0
    8000715e:	a0b1                	j	800071aa <pipealloc+0x14a>
    goto bad;
    80007160:	0001                	nop
    80007162:	a011                	j	80007166 <pipealloc+0x106>
    goto bad;
    80007164:	0001                	nop

 bad:
  if(pi)
    80007166:	fe843783          	ld	a5,-24(s0)
    8000716a:	c799                	beqz	a5,80007178 <pipealloc+0x118>
    kfree((char*)pi);
    8000716c:	fe843503          	ld	a0,-24(s0)
    80007170:	ffffa097          	auipc	ra,0xffffa
    80007174:	f18080e7          	jalr	-232(ra) # 80001088 <kfree>
  if(*f0)
    80007178:	fd843783          	ld	a5,-40(s0)
    8000717c:	639c                	ld	a5,0(a5)
    8000717e:	cb89                	beqz	a5,80007190 <pipealloc+0x130>
    fileclose(*f0);
    80007180:	fd843783          	ld	a5,-40(s0)
    80007184:	639c                	ld	a5,0(a5)
    80007186:	853e                	mv	a0,a5
    80007188:	00000097          	auipc	ra,0x0
    8000718c:	9a2080e7          	jalr	-1630(ra) # 80006b2a <fileclose>
  if(*f1)
    80007190:	fd043783          	ld	a5,-48(s0)
    80007194:	639c                	ld	a5,0(a5)
    80007196:	cb89                	beqz	a5,800071a8 <pipealloc+0x148>
    fileclose(*f1);
    80007198:	fd043783          	ld	a5,-48(s0)
    8000719c:	639c                	ld	a5,0(a5)
    8000719e:	853e                	mv	a0,a5
    800071a0:	00000097          	auipc	ra,0x0
    800071a4:	98a080e7          	jalr	-1654(ra) # 80006b2a <fileclose>
  return -1;
    800071a8:	57fd                	li	a5,-1
}
    800071aa:	853e                	mv	a0,a5
    800071ac:	70a2                	ld	ra,40(sp)
    800071ae:	7402                	ld	s0,32(sp)
    800071b0:	6145                	addi	sp,sp,48
    800071b2:	8082                	ret

00000000800071b4 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800071b4:	1101                	addi	sp,sp,-32
    800071b6:	ec06                	sd	ra,24(sp)
    800071b8:	e822                	sd	s0,16(sp)
    800071ba:	1000                	addi	s0,sp,32
    800071bc:	fea43423          	sd	a0,-24(s0)
    800071c0:	87ae                	mv	a5,a1
    800071c2:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    800071c6:	fe843783          	ld	a5,-24(s0)
    800071ca:	853e                	mv	a0,a5
    800071cc:	ffffa097          	auipc	ra,0xffffa
    800071d0:	0b4080e7          	jalr	180(ra) # 80001280 <acquire>
  if(writable){
    800071d4:	fe442783          	lw	a5,-28(s0)
    800071d8:	2781                	sext.w	a5,a5
    800071da:	cf99                	beqz	a5,800071f8 <pipeclose+0x44>
    pi->writeopen = 0;
    800071dc:	fe843783          	ld	a5,-24(s0)
    800071e0:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    800071e4:	fe843783          	ld	a5,-24(s0)
    800071e8:	21878793          	addi	a5,a5,536
    800071ec:	853e                	mv	a0,a5
    800071ee:	ffffc097          	auipc	ra,0xffffc
    800071f2:	3ea080e7          	jalr	1002(ra) # 800035d8 <wakeup>
    800071f6:	a831                	j	80007212 <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    800071f8:	fe843783          	ld	a5,-24(s0)
    800071fc:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80007200:	fe843783          	ld	a5,-24(s0)
    80007204:	21c78793          	addi	a5,a5,540
    80007208:	853e                	mv	a0,a5
    8000720a:	ffffc097          	auipc	ra,0xffffc
    8000720e:	3ce080e7          	jalr	974(ra) # 800035d8 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80007212:	fe843783          	ld	a5,-24(s0)
    80007216:	2207a783          	lw	a5,544(a5)
    8000721a:	e785                	bnez	a5,80007242 <pipeclose+0x8e>
    8000721c:	fe843783          	ld	a5,-24(s0)
    80007220:	2247a783          	lw	a5,548(a5)
    80007224:	ef99                	bnez	a5,80007242 <pipeclose+0x8e>
    release(&pi->lock);
    80007226:	fe843783          	ld	a5,-24(s0)
    8000722a:	853e                	mv	a0,a5
    8000722c:	ffffa097          	auipc	ra,0xffffa
    80007230:	0b8080e7          	jalr	184(ra) # 800012e4 <release>
    kfree((char*)pi);
    80007234:	fe843503          	ld	a0,-24(s0)
    80007238:	ffffa097          	auipc	ra,0xffffa
    8000723c:	e50080e7          	jalr	-432(ra) # 80001088 <kfree>
    80007240:	a809                	j	80007252 <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80007242:	fe843783          	ld	a5,-24(s0)
    80007246:	853e                	mv	a0,a5
    80007248:	ffffa097          	auipc	ra,0xffffa
    8000724c:	09c080e7          	jalr	156(ra) # 800012e4 <release>
}
    80007250:	0001                	nop
    80007252:	0001                	nop
    80007254:	60e2                	ld	ra,24(sp)
    80007256:	6442                	ld	s0,16(sp)
    80007258:	6105                	addi	sp,sp,32
    8000725a:	8082                	ret

000000008000725c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000725c:	715d                	addi	sp,sp,-80
    8000725e:	e486                	sd	ra,72(sp)
    80007260:	e0a2                	sd	s0,64(sp)
    80007262:	0880                	addi	s0,sp,80
    80007264:	fca43423          	sd	a0,-56(s0)
    80007268:	fcb43023          	sd	a1,-64(s0)
    8000726c:	87b2                	mv	a5,a2
    8000726e:	faf42e23          	sw	a5,-68(s0)
  int i;
  char ch;
  struct proc *pr = myproc();
    80007272:	ffffb097          	auipc	ra,0xffffb
    80007276:	586080e7          	jalr	1414(ra) # 800027f8 <myproc>
    8000727a:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    8000727e:	fc843783          	ld	a5,-56(s0)
    80007282:	853e                	mv	a0,a5
    80007284:	ffffa097          	auipc	ra,0xffffa
    80007288:	ffc080e7          	jalr	-4(ra) # 80001280 <acquire>
  for(i = 0; i < n; i++){
    8000728c:	fe042623          	sw	zero,-20(s0)
    80007290:	a8e1                	j	80007368 <pipewrite+0x10c>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
    80007292:	fc843783          	ld	a5,-56(s0)
    80007296:	2207a783          	lw	a5,544(a5)
    8000729a:	c789                	beqz	a5,800072a4 <pipewrite+0x48>
    8000729c:	fe043783          	ld	a5,-32(s0)
    800072a0:	5b9c                	lw	a5,48(a5)
    800072a2:	cb91                	beqz	a5,800072b6 <pipewrite+0x5a>
        release(&pi->lock);
    800072a4:	fc843783          	ld	a5,-56(s0)
    800072a8:	853e                	mv	a0,a5
    800072aa:	ffffa097          	auipc	ra,0xffffa
    800072ae:	03a080e7          	jalr	58(ra) # 800012e4 <release>
        return -1;
    800072b2:	57fd                	li	a5,-1
    800072b4:	a0f5                	j	800073a0 <pipewrite+0x144>
      }
      wakeup(&pi->nread);
    800072b6:	fc843783          	ld	a5,-56(s0)
    800072ba:	21878793          	addi	a5,a5,536
    800072be:	853e                	mv	a0,a5
    800072c0:	ffffc097          	auipc	ra,0xffffc
    800072c4:	318080e7          	jalr	792(ra) # 800035d8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800072c8:	fc843783          	ld	a5,-56(s0)
    800072cc:	21c78793          	addi	a5,a5,540
    800072d0:	fc843703          	ld	a4,-56(s0)
    800072d4:	85ba                	mv	a1,a4
    800072d6:	853e                	mv	a0,a5
    800072d8:	ffffc097          	auipc	ra,0xffffc
    800072dc:	26c080e7          	jalr	620(ra) # 80003544 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    800072e0:	fc843783          	ld	a5,-56(s0)
    800072e4:	21c7a703          	lw	a4,540(a5)
    800072e8:	fc843783          	ld	a5,-56(s0)
    800072ec:	2187a783          	lw	a5,536(a5)
    800072f0:	2007879b          	addiw	a5,a5,512
    800072f4:	2781                	sext.w	a5,a5
    800072f6:	f8f70ee3          	beq	a4,a5,80007292 <pipewrite+0x36>
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800072fa:	fe043703          	ld	a4,-32(s0)
    800072fe:	6785                	lui	a5,0x1
    80007300:	97ba                	add	a5,a5,a4
    80007302:	2b87b503          	ld	a0,696(a5) # 12b8 <_entry-0x7fffed48>
    80007306:	fec42703          	lw	a4,-20(s0)
    8000730a:	fc043783          	ld	a5,-64(s0)
    8000730e:	973e                	add	a4,a4,a5
    80007310:	fdf40793          	addi	a5,s0,-33
    80007314:	4685                	li	a3,1
    80007316:	863a                	mv	a2,a4
    80007318:	85be                	mv	a1,a5
    8000731a:	ffffb097          	auipc	ra,0xffffb
    8000731e:	088080e7          	jalr	136(ra) # 800023a2 <copyin>
    80007322:	87aa                	mv	a5,a0
    80007324:	873e                	mv	a4,a5
    80007326:	57fd                	li	a5,-1
    80007328:	04f70963          	beq	a4,a5,8000737a <pipewrite+0x11e>
      break;
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000732c:	fc843783          	ld	a5,-56(s0)
    80007330:	21c7a783          	lw	a5,540(a5)
    80007334:	2781                	sext.w	a5,a5
    80007336:	0017871b          	addiw	a4,a5,1
    8000733a:	0007069b          	sext.w	a3,a4
    8000733e:	fc843703          	ld	a4,-56(s0)
    80007342:	20d72e23          	sw	a3,540(a4)
    80007346:	1ff7f793          	andi	a5,a5,511
    8000734a:	2781                	sext.w	a5,a5
    8000734c:	fdf44703          	lbu	a4,-33(s0)
    80007350:	fc843683          	ld	a3,-56(s0)
    80007354:	1782                	slli	a5,a5,0x20
    80007356:	9381                	srli	a5,a5,0x20
    80007358:	97b6                	add	a5,a5,a3
    8000735a:	00e78c23          	sb	a4,24(a5)
  for(i = 0; i < n; i++){
    8000735e:	fec42783          	lw	a5,-20(s0)
    80007362:	2785                	addiw	a5,a5,1
    80007364:	fef42623          	sw	a5,-20(s0)
    80007368:	fec42703          	lw	a4,-20(s0)
    8000736c:	fbc42783          	lw	a5,-68(s0)
    80007370:	2701                	sext.w	a4,a4
    80007372:	2781                	sext.w	a5,a5
    80007374:	f6f746e3          	blt	a4,a5,800072e0 <pipewrite+0x84>
    80007378:	a011                	j	8000737c <pipewrite+0x120>
      break;
    8000737a:	0001                	nop
  }
  wakeup(&pi->nread);
    8000737c:	fc843783          	ld	a5,-56(s0)
    80007380:	21878793          	addi	a5,a5,536
    80007384:	853e                	mv	a0,a5
    80007386:	ffffc097          	auipc	ra,0xffffc
    8000738a:	252080e7          	jalr	594(ra) # 800035d8 <wakeup>
  release(&pi->lock);
    8000738e:	fc843783          	ld	a5,-56(s0)
    80007392:	853e                	mv	a0,a5
    80007394:	ffffa097          	auipc	ra,0xffffa
    80007398:	f50080e7          	jalr	-176(ra) # 800012e4 <release>
  return i;
    8000739c:	fec42783          	lw	a5,-20(s0)
}
    800073a0:	853e                	mv	a0,a5
    800073a2:	60a6                	ld	ra,72(sp)
    800073a4:	6406                	ld	s0,64(sp)
    800073a6:	6161                	addi	sp,sp,80
    800073a8:	8082                	ret

00000000800073aa <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800073aa:	715d                	addi	sp,sp,-80
    800073ac:	e486                	sd	ra,72(sp)
    800073ae:	e0a2                	sd	s0,64(sp)
    800073b0:	0880                	addi	s0,sp,80
    800073b2:	fca43423          	sd	a0,-56(s0)
    800073b6:	fcb43023          	sd	a1,-64(s0)
    800073ba:	87b2                	mv	a5,a2
    800073bc:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    800073c0:	ffffb097          	auipc	ra,0xffffb
    800073c4:	438080e7          	jalr	1080(ra) # 800027f8 <myproc>
    800073c8:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    800073cc:	fc843783          	ld	a5,-56(s0)
    800073d0:	853e                	mv	a0,a5
    800073d2:	ffffa097          	auipc	ra,0xffffa
    800073d6:	eae080e7          	jalr	-338(ra) # 80001280 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800073da:	a815                	j	8000740e <piperead+0x64>
    if(pr->killed){
    800073dc:	fe043783          	ld	a5,-32(s0)
    800073e0:	5b9c                	lw	a5,48(a5)
    800073e2:	cb91                	beqz	a5,800073f6 <piperead+0x4c>
      release(&pi->lock);
    800073e4:	fc843783          	ld	a5,-56(s0)
    800073e8:	853e                	mv	a0,a5
    800073ea:	ffffa097          	auipc	ra,0xffffa
    800073ee:	efa080e7          	jalr	-262(ra) # 800012e4 <release>
      return -1;
    800073f2:	57fd                	li	a5,-1
    800073f4:	a8f5                	j	800074f0 <piperead+0x146>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800073f6:	fc843783          	ld	a5,-56(s0)
    800073fa:	21878793          	addi	a5,a5,536
    800073fe:	fc843703          	ld	a4,-56(s0)
    80007402:	85ba                	mv	a1,a4
    80007404:	853e                	mv	a0,a5
    80007406:	ffffc097          	auipc	ra,0xffffc
    8000740a:	13e080e7          	jalr	318(ra) # 80003544 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000740e:	fc843783          	ld	a5,-56(s0)
    80007412:	2187a703          	lw	a4,536(a5)
    80007416:	fc843783          	ld	a5,-56(s0)
    8000741a:	21c7a783          	lw	a5,540(a5)
    8000741e:	00f71763          	bne	a4,a5,8000742c <piperead+0x82>
    80007422:	fc843783          	ld	a5,-56(s0)
    80007426:	2247a783          	lw	a5,548(a5)
    8000742a:	fbcd                	bnez	a5,800073dc <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000742c:	fe042623          	sw	zero,-20(s0)
    80007430:	a051                	j	800074b4 <piperead+0x10a>
    if(pi->nread == pi->nwrite)
    80007432:	fc843783          	ld	a5,-56(s0)
    80007436:	2187a703          	lw	a4,536(a5)
    8000743a:	fc843783          	ld	a5,-56(s0)
    8000743e:	21c7a783          	lw	a5,540(a5)
    80007442:	08f70263          	beq	a4,a5,800074c6 <piperead+0x11c>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80007446:	fc843783          	ld	a5,-56(s0)
    8000744a:	2187a783          	lw	a5,536(a5)
    8000744e:	2781                	sext.w	a5,a5
    80007450:	0017871b          	addiw	a4,a5,1
    80007454:	0007069b          	sext.w	a3,a4
    80007458:	fc843703          	ld	a4,-56(s0)
    8000745c:	20d72c23          	sw	a3,536(a4)
    80007460:	1ff7f793          	andi	a5,a5,511
    80007464:	2781                	sext.w	a5,a5
    80007466:	fc843703          	ld	a4,-56(s0)
    8000746a:	1782                	slli	a5,a5,0x20
    8000746c:	9381                	srli	a5,a5,0x20
    8000746e:	97ba                	add	a5,a5,a4
    80007470:	0187c783          	lbu	a5,24(a5)
    80007474:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80007478:	fe043703          	ld	a4,-32(s0)
    8000747c:	6785                	lui	a5,0x1
    8000747e:	97ba                	add	a5,a5,a4
    80007480:	2b87b503          	ld	a0,696(a5) # 12b8 <_entry-0x7fffed48>
    80007484:	fec42703          	lw	a4,-20(s0)
    80007488:	fc043783          	ld	a5,-64(s0)
    8000748c:	97ba                	add	a5,a5,a4
    8000748e:	fdf40713          	addi	a4,s0,-33
    80007492:	4685                	li	a3,1
    80007494:	863a                	mv	a2,a4
    80007496:	85be                	mv	a1,a5
    80007498:	ffffb097          	auipc	ra,0xffffb
    8000749c:	e3c080e7          	jalr	-452(ra) # 800022d4 <copyout>
    800074a0:	87aa                	mv	a5,a0
    800074a2:	873e                	mv	a4,a5
    800074a4:	57fd                	li	a5,-1
    800074a6:	02f70263          	beq	a4,a5,800074ca <piperead+0x120>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800074aa:	fec42783          	lw	a5,-20(s0)
    800074ae:	2785                	addiw	a5,a5,1
    800074b0:	fef42623          	sw	a5,-20(s0)
    800074b4:	fec42703          	lw	a4,-20(s0)
    800074b8:	fbc42783          	lw	a5,-68(s0)
    800074bc:	2701                	sext.w	a4,a4
    800074be:	2781                	sext.w	a5,a5
    800074c0:	f6f749e3          	blt	a4,a5,80007432 <piperead+0x88>
    800074c4:	a021                	j	800074cc <piperead+0x122>
      break;
    800074c6:	0001                	nop
    800074c8:	a011                	j	800074cc <piperead+0x122>
      break;
    800074ca:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800074cc:	fc843783          	ld	a5,-56(s0)
    800074d0:	21c78793          	addi	a5,a5,540
    800074d4:	853e                	mv	a0,a5
    800074d6:	ffffc097          	auipc	ra,0xffffc
    800074da:	102080e7          	jalr	258(ra) # 800035d8 <wakeup>
  release(&pi->lock);
    800074de:	fc843783          	ld	a5,-56(s0)
    800074e2:	853e                	mv	a0,a5
    800074e4:	ffffa097          	auipc	ra,0xffffa
    800074e8:	e00080e7          	jalr	-512(ra) # 800012e4 <release>
  return i;
    800074ec:	fec42783          	lw	a5,-20(s0)
}
    800074f0:	853e                	mv	a0,a5
    800074f2:	60a6                	ld	ra,72(sp)
    800074f4:	6406                	ld	s0,64(sp)
    800074f6:	6161                	addi	sp,sp,80
    800074f8:	8082                	ret

00000000800074fa <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800074fa:	de010113          	addi	sp,sp,-544
    800074fe:	20113c23          	sd	ra,536(sp)
    80007502:	20813823          	sd	s0,528(sp)
    80007506:	20913423          	sd	s1,520(sp)
    8000750a:	1400                	addi	s0,sp,544
    8000750c:	dea43423          	sd	a0,-536(s0)
    80007510:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80007514:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007518:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    8000751c:	ffffb097          	auipc	ra,0xffffb
    80007520:	2dc080e7          	jalr	732(ra) # 800027f8 <myproc>
    80007524:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    80007528:	fffff097          	auipc	ra,0xfffff
    8000752c:	f68080e7          	jalr	-152(ra) # 80006490 <begin_op>

  if((ip = namei(path)) == 0){
    80007530:	de843503          	ld	a0,-536(s0)
    80007534:	fffff097          	auipc	ra,0xfffff
    80007538:	bf8080e7          	jalr	-1032(ra) # 8000612c <namei>
    8000753c:	faa43423          	sd	a0,-88(s0)
    80007540:	fa843783          	ld	a5,-88(s0)
    80007544:	e799                	bnez	a5,80007552 <exec+0x58>
    end_op();
    80007546:	fffff097          	auipc	ra,0xfffff
    8000754a:	00c080e7          	jalr	12(ra) # 80006552 <end_op>
    return -1;
    8000754e:	57fd                	li	a5,-1
    80007550:	a185                	j	800079b0 <exec+0x4b6>
  }
  ilock(ip);
    80007552:	fa843503          	ld	a0,-88(s0)
    80007556:	ffffe097          	auipc	ra,0xffffe
    8000755a:	ece080e7          	jalr	-306(ra) # 80005424 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000755e:	e2840793          	addi	a5,s0,-472
    80007562:	04000713          	li	a4,64
    80007566:	4681                	li	a3,0
    80007568:	863e                	mv	a2,a5
    8000756a:	4581                	li	a1,0
    8000756c:	fa843503          	ld	a0,-88(s0)
    80007570:	ffffe097          	auipc	ra,0xffffe
    80007574:	44a080e7          	jalr	1098(ra) # 800059ba <readi>
    80007578:	87aa                	mv	a5,a0
    8000757a:	873e                	mv	a4,a5
    8000757c:	04000793          	li	a5,64
    80007580:	3cf71263          	bne	a4,a5,80007944 <exec+0x44a>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007584:	e2842783          	lw	a5,-472(s0)
    80007588:	873e                	mv	a4,a5
    8000758a:	464c47b7          	lui	a5,0x464c4
    8000758e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007592:	3af71b63          	bne	a4,a5,80007948 <exec+0x44e>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007596:	f9843503          	ld	a0,-104(s0)
    8000759a:	ffffb097          	auipc	ra,0xffffb
    8000759e:	576080e7          	jalr	1398(ra) # 80002b10 <proc_pagetable>
    800075a2:	faa43023          	sd	a0,-96(s0)
    800075a6:	fa043783          	ld	a5,-96(s0)
    800075aa:	3a078163          	beqz	a5,8000794c <exec+0x452>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800075ae:	fc042623          	sw	zero,-52(s0)
    800075b2:	e4843783          	ld	a5,-440(s0)
    800075b6:	fcf42423          	sw	a5,-56(s0)
    800075ba:	a8e1                	j	80007692 <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800075bc:	df040793          	addi	a5,s0,-528
    800075c0:	fc842683          	lw	a3,-56(s0)
    800075c4:	03800713          	li	a4,56
    800075c8:	863e                	mv	a2,a5
    800075ca:	4581                	li	a1,0
    800075cc:	fa843503          	ld	a0,-88(s0)
    800075d0:	ffffe097          	auipc	ra,0xffffe
    800075d4:	3ea080e7          	jalr	1002(ra) # 800059ba <readi>
    800075d8:	87aa                	mv	a5,a0
    800075da:	873e                	mv	a4,a5
    800075dc:	03800793          	li	a5,56
    800075e0:	36f71863          	bne	a4,a5,80007950 <exec+0x456>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    800075e4:	df042783          	lw	a5,-528(s0)
    800075e8:	873e                	mv	a4,a5
    800075ea:	4785                	li	a5,1
    800075ec:	08f71663          	bne	a4,a5,80007678 <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    800075f0:	e1843703          	ld	a4,-488(s0)
    800075f4:	e1043783          	ld	a5,-496(s0)
    800075f8:	34f76e63          	bltu	a4,a5,80007954 <exec+0x45a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800075fc:	e0043703          	ld	a4,-512(s0)
    80007600:	e1843783          	ld	a5,-488(s0)
    80007604:	973e                	add	a4,a4,a5
    80007606:	e0043783          	ld	a5,-512(s0)
    8000760a:	34f76763          	bltu	a4,a5,80007958 <exec+0x45e>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000760e:	e0043703          	ld	a4,-512(s0)
    80007612:	e1843783          	ld	a5,-488(s0)
    80007616:	97ba                	add	a5,a5,a4
    80007618:	863e                	mv	a2,a5
    8000761a:	fb843583          	ld	a1,-72(s0)
    8000761e:	fa043503          	ld	a0,-96(s0)
    80007622:	ffffb097          	auipc	ra,0xffffb
    80007626:	8d4080e7          	jalr	-1836(ra) # 80001ef6 <uvmalloc>
    8000762a:	f6a43823          	sd	a0,-144(s0)
    8000762e:	f7043783          	ld	a5,-144(s0)
    80007632:	32078563          	beqz	a5,8000795c <exec+0x462>
      goto bad;
    sz = sz1;
    80007636:	f7043783          	ld	a5,-144(s0)
    8000763a:	faf43c23          	sd	a5,-72(s0)
    if(ph.vaddr % PGSIZE != 0)
    8000763e:	e0043703          	ld	a4,-512(s0)
    80007642:	6785                	lui	a5,0x1
    80007644:	17fd                	addi	a5,a5,-1
    80007646:	8ff9                	and	a5,a5,a4
    80007648:	30079c63          	bnez	a5,80007960 <exec+0x466>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000764c:	e0043783          	ld	a5,-512(s0)
    80007650:	df843703          	ld	a4,-520(s0)
    80007654:	0007069b          	sext.w	a3,a4
    80007658:	e1043703          	ld	a4,-496(s0)
    8000765c:	2701                	sext.w	a4,a4
    8000765e:	fa843603          	ld	a2,-88(s0)
    80007662:	85be                	mv	a1,a5
    80007664:	fa043503          	ld	a0,-96(s0)
    80007668:	00000097          	auipc	ra,0x0
    8000766c:	35c080e7          	jalr	860(ra) # 800079c4 <loadseg>
    80007670:	87aa                	mv	a5,a0
    80007672:	2e07c963          	bltz	a5,80007964 <exec+0x46a>
    80007676:	a011                	j	8000767a <exec+0x180>
      continue;
    80007678:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000767a:	fcc42783          	lw	a5,-52(s0)
    8000767e:	2785                	addiw	a5,a5,1
    80007680:	fcf42623          	sw	a5,-52(s0)
    80007684:	fc842783          	lw	a5,-56(s0)
    80007688:	0387879b          	addiw	a5,a5,56
    8000768c:	2781                	sext.w	a5,a5
    8000768e:	fcf42423          	sw	a5,-56(s0)
    80007692:	e6045783          	lhu	a5,-416(s0)
    80007696:	0007871b          	sext.w	a4,a5
    8000769a:	fcc42783          	lw	a5,-52(s0)
    8000769e:	2781                	sext.w	a5,a5
    800076a0:	f0e7cee3          	blt	a5,a4,800075bc <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    800076a4:	fa843503          	ld	a0,-88(s0)
    800076a8:	ffffe097          	auipc	ra,0xffffe
    800076ac:	fda080e7          	jalr	-38(ra) # 80005682 <iunlockput>
  end_op();
    800076b0:	fffff097          	auipc	ra,0xfffff
    800076b4:	ea2080e7          	jalr	-350(ra) # 80006552 <end_op>
  ip = 0;
    800076b8:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    800076bc:	ffffb097          	auipc	ra,0xffffb
    800076c0:	13c080e7          	jalr	316(ra) # 800027f8 <myproc>
    800076c4:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    800076c8:	f9843703          	ld	a4,-104(s0)
    800076cc:	6785                	lui	a5,0x1
    800076ce:	97ba                	add	a5,a5,a4
    800076d0:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    800076d4:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    800076d8:	fb843703          	ld	a4,-72(s0)
    800076dc:	6785                	lui	a5,0x1
    800076de:	17fd                	addi	a5,a5,-1
    800076e0:	973e                	add	a4,a4,a5
    800076e2:	77fd                	lui	a5,0xfffff
    800076e4:	8ff9                	and	a5,a5,a4
    800076e6:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800076ea:	fb843703          	ld	a4,-72(s0)
    800076ee:	6789                	lui	a5,0x2
    800076f0:	97ba                	add	a5,a5,a4
    800076f2:	863e                	mv	a2,a5
    800076f4:	fb843583          	ld	a1,-72(s0)
    800076f8:	fa043503          	ld	a0,-96(s0)
    800076fc:	ffffa097          	auipc	ra,0xffffa
    80007700:	7fa080e7          	jalr	2042(ra) # 80001ef6 <uvmalloc>
    80007704:	f8a43423          	sd	a0,-120(s0)
    80007708:	f8843783          	ld	a5,-120(s0)
    8000770c:	24078e63          	beqz	a5,80007968 <exec+0x46e>
    goto bad;
  sz = sz1;
    80007710:	f8843783          	ld	a5,-120(s0)
    80007714:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    80007718:	fb843703          	ld	a4,-72(s0)
    8000771c:	77f9                	lui	a5,0xffffe
    8000771e:	97ba                	add	a5,a5,a4
    80007720:	85be                	mv	a1,a5
    80007722:	fa043503          	ld	a0,-96(s0)
    80007726:	ffffb097          	auipc	ra,0xffffb
    8000772a:	b58080e7          	jalr	-1192(ra) # 8000227e <uvmclear>
  sp = sz;
    8000772e:	fb843783          	ld	a5,-72(s0)
    80007732:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    80007736:	fb043703          	ld	a4,-80(s0)
    8000773a:	77fd                	lui	a5,0xfffff
    8000773c:	97ba                	add	a5,a5,a4
    8000773e:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    80007742:	fc043023          	sd	zero,-64(s0)
    80007746:	a845                	j	800077f6 <exec+0x2fc>
    if(argc >= MAXARG)
    80007748:	fc043703          	ld	a4,-64(s0)
    8000774c:	47fd                	li	a5,31
    8000774e:	20e7ef63          	bltu	a5,a4,8000796c <exec+0x472>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80007752:	fc043783          	ld	a5,-64(s0)
    80007756:	078e                	slli	a5,a5,0x3
    80007758:	de043703          	ld	a4,-544(s0)
    8000775c:	97ba                	add	a5,a5,a4
    8000775e:	639c                	ld	a5,0(a5)
    80007760:	853e                	mv	a0,a5
    80007762:	ffffa097          	auipc	ra,0xffffa
    80007766:	062080e7          	jalr	98(ra) # 800017c4 <strlen>
    8000776a:	87aa                	mv	a5,a0
    8000776c:	2785                	addiw	a5,a5,1
    8000776e:	2781                	sext.w	a5,a5
    80007770:	873e                	mv	a4,a5
    80007772:	fb043783          	ld	a5,-80(s0)
    80007776:	8f99                	sub	a5,a5,a4
    80007778:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000777c:	fb043783          	ld	a5,-80(s0)
    80007780:	9bc1                	andi	a5,a5,-16
    80007782:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007786:	fb043703          	ld	a4,-80(s0)
    8000778a:	f8043783          	ld	a5,-128(s0)
    8000778e:	1ef76163          	bltu	a4,a5,80007970 <exec+0x476>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80007792:	fc043783          	ld	a5,-64(s0)
    80007796:	078e                	slli	a5,a5,0x3
    80007798:	de043703          	ld	a4,-544(s0)
    8000779c:	97ba                	add	a5,a5,a4
    8000779e:	6384                	ld	s1,0(a5)
    800077a0:	fc043783          	ld	a5,-64(s0)
    800077a4:	078e                	slli	a5,a5,0x3
    800077a6:	de043703          	ld	a4,-544(s0)
    800077aa:	97ba                	add	a5,a5,a4
    800077ac:	639c                	ld	a5,0(a5)
    800077ae:	853e                	mv	a0,a5
    800077b0:	ffffa097          	auipc	ra,0xffffa
    800077b4:	014080e7          	jalr	20(ra) # 800017c4 <strlen>
    800077b8:	87aa                	mv	a5,a0
    800077ba:	2785                	addiw	a5,a5,1
    800077bc:	2781                	sext.w	a5,a5
    800077be:	86be                	mv	a3,a5
    800077c0:	8626                	mv	a2,s1
    800077c2:	fb043583          	ld	a1,-80(s0)
    800077c6:	fa043503          	ld	a0,-96(s0)
    800077ca:	ffffb097          	auipc	ra,0xffffb
    800077ce:	b0a080e7          	jalr	-1270(ra) # 800022d4 <copyout>
    800077d2:	87aa                	mv	a5,a0
    800077d4:	1a07c063          	bltz	a5,80007974 <exec+0x47a>
      goto bad;
    ustack[argc] = sp;
    800077d8:	fc043783          	ld	a5,-64(s0)
    800077dc:	078e                	slli	a5,a5,0x3
    800077de:	fe040713          	addi	a4,s0,-32
    800077e2:	97ba                	add	a5,a5,a4
    800077e4:	fb043703          	ld	a4,-80(s0)
    800077e8:	e8e7b423          	sd	a4,-376(a5) # ffffffffffffee88 <end+0xffffffff7ff8ce88>
  for(argc = 0; argv[argc]; argc++) {
    800077ec:	fc043783          	ld	a5,-64(s0)
    800077f0:	0785                	addi	a5,a5,1
    800077f2:	fcf43023          	sd	a5,-64(s0)
    800077f6:	fc043783          	ld	a5,-64(s0)
    800077fa:	078e                	slli	a5,a5,0x3
    800077fc:	de043703          	ld	a4,-544(s0)
    80007800:	97ba                	add	a5,a5,a4
    80007802:	639c                	ld	a5,0(a5)
    80007804:	f3b1                	bnez	a5,80007748 <exec+0x24e>
  }
  ustack[argc] = 0;
    80007806:	fc043783          	ld	a5,-64(s0)
    8000780a:	078e                	slli	a5,a5,0x3
    8000780c:	fe040713          	addi	a4,s0,-32
    80007810:	97ba                	add	a5,a5,a4
    80007812:	e807b423          	sd	zero,-376(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    80007816:	fc043783          	ld	a5,-64(s0)
    8000781a:	0785                	addi	a5,a5,1
    8000781c:	078e                	slli	a5,a5,0x3
    8000781e:	fb043703          	ld	a4,-80(s0)
    80007822:	40f707b3          	sub	a5,a4,a5
    80007826:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    8000782a:	fb043783          	ld	a5,-80(s0)
    8000782e:	9bc1                	andi	a5,a5,-16
    80007830:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    80007834:	fb043703          	ld	a4,-80(s0)
    80007838:	f8043783          	ld	a5,-128(s0)
    8000783c:	12f76e63          	bltu	a4,a5,80007978 <exec+0x47e>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80007840:	fc043783          	ld	a5,-64(s0)
    80007844:	0785                	addi	a5,a5,1
    80007846:	00379713          	slli	a4,a5,0x3
    8000784a:	e6840793          	addi	a5,s0,-408
    8000784e:	86ba                	mv	a3,a4
    80007850:	863e                	mv	a2,a5
    80007852:	fb043583          	ld	a1,-80(s0)
    80007856:	fa043503          	ld	a0,-96(s0)
    8000785a:	ffffb097          	auipc	ra,0xffffb
    8000785e:	a7a080e7          	jalr	-1414(ra) # 800022d4 <copyout>
    80007862:	87aa                	mv	a5,a0
    80007864:	1007cc63          	bltz	a5,8000797c <exec+0x482>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80007868:	f9843703          	ld	a4,-104(s0)
    8000786c:	6785                	lui	a5,0x1
    8000786e:	97ba                	add	a5,a5,a4
    80007870:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80007874:	fb043703          	ld	a4,-80(s0)
    80007878:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    8000787a:	de843783          	ld	a5,-536(s0)
    8000787e:	fcf43c23          	sd	a5,-40(s0)
    80007882:	fd843783          	ld	a5,-40(s0)
    80007886:	fcf43823          	sd	a5,-48(s0)
    8000788a:	a025                	j	800078b2 <exec+0x3b8>
    if(*s == '/')
    8000788c:	fd843783          	ld	a5,-40(s0)
    80007890:	0007c783          	lbu	a5,0(a5)
    80007894:	873e                	mv	a4,a5
    80007896:	02f00793          	li	a5,47
    8000789a:	00f71763          	bne	a4,a5,800078a8 <exec+0x3ae>
      last = s+1;
    8000789e:	fd843783          	ld	a5,-40(s0)
    800078a2:	0785                	addi	a5,a5,1
    800078a4:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    800078a8:	fd843783          	ld	a5,-40(s0)
    800078ac:	0785                	addi	a5,a5,1
    800078ae:	fcf43c23          	sd	a5,-40(s0)
    800078b2:	fd843783          	ld	a5,-40(s0)
    800078b6:	0007c783          	lbu	a5,0(a5)
    800078ba:	fbe9                	bnez	a5,8000788c <exec+0x392>
  safestrcpy(p->name, last, sizeof(p->name));
    800078bc:	f9843703          	ld	a4,-104(s0)
    800078c0:	6785                	lui	a5,0x1
    800078c2:	3c078793          	addi	a5,a5,960 # 13c0 <_entry-0x7fffec40>
    800078c6:	97ba                	add	a5,a5,a4
    800078c8:	4641                	li	a2,16
    800078ca:	fd043583          	ld	a1,-48(s0)
    800078ce:	853e                	mv	a0,a5
    800078d0:	ffffa097          	auipc	ra,0xffffa
    800078d4:	e7a080e7          	jalr	-390(ra) # 8000174a <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    800078d8:	f9843703          	ld	a4,-104(s0)
    800078dc:	6785                	lui	a5,0x1
    800078de:	97ba                	add	a5,a5,a4
    800078e0:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    800078e4:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    800078e8:	f9843703          	ld	a4,-104(s0)
    800078ec:	6785                	lui	a5,0x1
    800078ee:	97ba                	add	a5,a5,a4
    800078f0:	fa043703          	ld	a4,-96(s0)
    800078f4:	2ae7bc23          	sd	a4,696(a5) # 12b8 <_entry-0x7fffed48>
  p->sz = sz;
    800078f8:	f9843703          	ld	a4,-104(s0)
    800078fc:	6785                	lui	a5,0x1
    800078fe:	97ba                	add	a5,a5,a4
    80007900:	fb843703          	ld	a4,-72(s0)
    80007904:	2ae7b823          	sd	a4,688(a5) # 12b0 <_entry-0x7fffed50>
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80007908:	f9843703          	ld	a4,-104(s0)
    8000790c:	6785                	lui	a5,0x1
    8000790e:	97ba                	add	a5,a5,a4
    80007910:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80007914:	e4043703          	ld	a4,-448(s0)
    80007918:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000791a:	f9843703          	ld	a4,-104(s0)
    8000791e:	6785                	lui	a5,0x1
    80007920:	97ba                	add	a5,a5,a4
    80007922:	2c07b783          	ld	a5,704(a5) # 12c0 <_entry-0x7fffed40>
    80007926:	fb043703          	ld	a4,-80(s0)
    8000792a:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000792c:	f9043583          	ld	a1,-112(s0)
    80007930:	f7843503          	ld	a0,-136(s0)
    80007934:	ffffb097          	auipc	ra,0xffffb
    80007938:	2a2080e7          	jalr	674(ra) # 80002bd6 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000793c:	fc043783          	ld	a5,-64(s0)
    80007940:	2781                	sext.w	a5,a5
    80007942:	a0bd                	j	800079b0 <exec+0x4b6>
    goto bad;
    80007944:	0001                	nop
    80007946:	a825                	j	8000797e <exec+0x484>
    goto bad;
    80007948:	0001                	nop
    8000794a:	a815                	j	8000797e <exec+0x484>
    goto bad;
    8000794c:	0001                	nop
    8000794e:	a805                	j	8000797e <exec+0x484>
      goto bad;
    80007950:	0001                	nop
    80007952:	a035                	j	8000797e <exec+0x484>
      goto bad;
    80007954:	0001                	nop
    80007956:	a025                	j	8000797e <exec+0x484>
      goto bad;
    80007958:	0001                	nop
    8000795a:	a015                	j	8000797e <exec+0x484>
      goto bad;
    8000795c:	0001                	nop
    8000795e:	a005                	j	8000797e <exec+0x484>
      goto bad;
    80007960:	0001                	nop
    80007962:	a831                	j	8000797e <exec+0x484>
      goto bad;
    80007964:	0001                	nop
    80007966:	a821                	j	8000797e <exec+0x484>
    goto bad;
    80007968:	0001                	nop
    8000796a:	a811                	j	8000797e <exec+0x484>
      goto bad;
    8000796c:	0001                	nop
    8000796e:	a801                	j	8000797e <exec+0x484>
      goto bad;
    80007970:	0001                	nop
    80007972:	a031                	j	8000797e <exec+0x484>
      goto bad;
    80007974:	0001                	nop
    80007976:	a021                	j	8000797e <exec+0x484>
    goto bad;
    80007978:	0001                	nop
    8000797a:	a011                	j	8000797e <exec+0x484>
    goto bad;
    8000797c:	0001                	nop

 bad:
  if(pagetable)
    8000797e:	fa043783          	ld	a5,-96(s0)
    80007982:	cb89                	beqz	a5,80007994 <exec+0x49a>
    proc_freepagetable(pagetable, sz);
    80007984:	fb843583          	ld	a1,-72(s0)
    80007988:	fa043503          	ld	a0,-96(s0)
    8000798c:	ffffb097          	auipc	ra,0xffffb
    80007990:	24a080e7          	jalr	586(ra) # 80002bd6 <proc_freepagetable>
  if(ip){
    80007994:	fa843783          	ld	a5,-88(s0)
    80007998:	cb99                	beqz	a5,800079ae <exec+0x4b4>
    iunlockput(ip);
    8000799a:	fa843503          	ld	a0,-88(s0)
    8000799e:	ffffe097          	auipc	ra,0xffffe
    800079a2:	ce4080e7          	jalr	-796(ra) # 80005682 <iunlockput>
    end_op();
    800079a6:	fffff097          	auipc	ra,0xfffff
    800079aa:	bac080e7          	jalr	-1108(ra) # 80006552 <end_op>
  }
  return -1;
    800079ae:	57fd                	li	a5,-1
}
    800079b0:	853e                	mv	a0,a5
    800079b2:	21813083          	ld	ra,536(sp)
    800079b6:	21013403          	ld	s0,528(sp)
    800079ba:	20813483          	ld	s1,520(sp)
    800079be:	22010113          	addi	sp,sp,544
    800079c2:	8082                	ret

00000000800079c4 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    800079c4:	7139                	addi	sp,sp,-64
    800079c6:	fc06                	sd	ra,56(sp)
    800079c8:	f822                	sd	s0,48(sp)
    800079ca:	0080                	addi	s0,sp,64
    800079cc:	fca43c23          	sd	a0,-40(s0)
    800079d0:	fcb43823          	sd	a1,-48(s0)
    800079d4:	fcc43423          	sd	a2,-56(s0)
    800079d8:	87b6                	mv	a5,a3
    800079da:	fcf42223          	sw	a5,-60(s0)
    800079de:	87ba                	mv	a5,a4
    800079e0:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  if((va % PGSIZE) != 0)
    800079e4:	fd043703          	ld	a4,-48(s0)
    800079e8:	6785                	lui	a5,0x1
    800079ea:	17fd                	addi	a5,a5,-1
    800079ec:	8ff9                	and	a5,a5,a4
    800079ee:	cb89                	beqz	a5,80007a00 <loadseg+0x3c>
    panic("loadseg: va must be page aligned");
    800079f0:	00004517          	auipc	a0,0x4
    800079f4:	be850513          	addi	a0,a0,-1048 # 8000b5d8 <etext+0x5d8>
    800079f8:	ffff9097          	auipc	ra,0xffff9
    800079fc:	25a080e7          	jalr	602(ra) # 80000c52 <panic>

  for(i = 0; i < sz; i += PGSIZE){
    80007a00:	fe042623          	sw	zero,-20(s0)
    80007a04:	a05d                	j	80007aaa <loadseg+0xe6>
    pa = walkaddr(pagetable, va + i);
    80007a06:	fec46703          	lwu	a4,-20(s0)
    80007a0a:	fd043783          	ld	a5,-48(s0)
    80007a0e:	97ba                	add	a5,a5,a4
    80007a10:	85be                	mv	a1,a5
    80007a12:	fd843503          	ld	a0,-40(s0)
    80007a16:	ffffa097          	auipc	ra,0xffffa
    80007a1a:	182080e7          	jalr	386(ra) # 80001b98 <walkaddr>
    80007a1e:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80007a22:	fe043783          	ld	a5,-32(s0)
    80007a26:	eb89                	bnez	a5,80007a38 <loadseg+0x74>
      panic("loadseg: address should exist");
    80007a28:	00004517          	auipc	a0,0x4
    80007a2c:	bd850513          	addi	a0,a0,-1064 # 8000b600 <etext+0x600>
    80007a30:	ffff9097          	auipc	ra,0xffff9
    80007a34:	222080e7          	jalr	546(ra) # 80000c52 <panic>
    if(sz - i < PGSIZE)
    80007a38:	fc042703          	lw	a4,-64(s0)
    80007a3c:	fec42783          	lw	a5,-20(s0)
    80007a40:	40f707bb          	subw	a5,a4,a5
    80007a44:	2781                	sext.w	a5,a5
    80007a46:	873e                	mv	a4,a5
    80007a48:	6785                	lui	a5,0x1
    80007a4a:	00f77b63          	bgeu	a4,a5,80007a60 <loadseg+0x9c>
      n = sz - i;
    80007a4e:	fc042703          	lw	a4,-64(s0)
    80007a52:	fec42783          	lw	a5,-20(s0)
    80007a56:	40f707bb          	subw	a5,a4,a5
    80007a5a:	fef42423          	sw	a5,-24(s0)
    80007a5e:	a021                	j	80007a66 <loadseg+0xa2>
    else
      n = PGSIZE;
    80007a60:	6785                	lui	a5,0x1
    80007a62:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80007a66:	fc442703          	lw	a4,-60(s0)
    80007a6a:	fec42783          	lw	a5,-20(s0)
    80007a6e:	9fb9                	addw	a5,a5,a4
    80007a70:	2781                	sext.w	a5,a5
    80007a72:	fe842703          	lw	a4,-24(s0)
    80007a76:	86be                	mv	a3,a5
    80007a78:	fe043603          	ld	a2,-32(s0)
    80007a7c:	4581                	li	a1,0
    80007a7e:	fc843503          	ld	a0,-56(s0)
    80007a82:	ffffe097          	auipc	ra,0xffffe
    80007a86:	f38080e7          	jalr	-200(ra) # 800059ba <readi>
    80007a8a:	87aa                	mv	a5,a0
    80007a8c:	0007871b          	sext.w	a4,a5
    80007a90:	fe842783          	lw	a5,-24(s0)
    80007a94:	2781                	sext.w	a5,a5
    80007a96:	00e78463          	beq	a5,a4,80007a9e <loadseg+0xda>
      return -1;
    80007a9a:	57fd                	li	a5,-1
    80007a9c:	a005                	j	80007abc <loadseg+0xf8>
  for(i = 0; i < sz; i += PGSIZE){
    80007a9e:	fec42703          	lw	a4,-20(s0)
    80007aa2:	6785                	lui	a5,0x1
    80007aa4:	9fb9                	addw	a5,a5,a4
    80007aa6:	fef42623          	sw	a5,-20(s0)
    80007aaa:	fec42703          	lw	a4,-20(s0)
    80007aae:	fc042783          	lw	a5,-64(s0)
    80007ab2:	2701                	sext.w	a4,a4
    80007ab4:	2781                	sext.w	a5,a5
    80007ab6:	f4f768e3          	bltu	a4,a5,80007a06 <loadseg+0x42>
  }
  
  return 0;
    80007aba:	4781                	li	a5,0
}
    80007abc:	853e                	mv	a0,a5
    80007abe:	70e2                	ld	ra,56(sp)
    80007ac0:	7442                	ld	s0,48(sp)
    80007ac2:	6121                	addi	sp,sp,64
    80007ac4:	8082                	ret

0000000080007ac6 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007ac6:	7139                	addi	sp,sp,-64
    80007ac8:	fc06                	sd	ra,56(sp)
    80007aca:	f822                	sd	s0,48(sp)
    80007acc:	0080                	addi	s0,sp,64
    80007ace:	87aa                	mv	a5,a0
    80007ad0:	fcb43823          	sd	a1,-48(s0)
    80007ad4:	fcc43423          	sd	a2,-56(s0)
    80007ad8:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80007adc:	fe440713          	addi	a4,s0,-28
    80007ae0:	fdc42783          	lw	a5,-36(s0)
    80007ae4:	85ba                	mv	a1,a4
    80007ae6:	853e                	mv	a0,a5
    80007ae8:	ffffd097          	auipc	ra,0xffffd
    80007aec:	94e080e7          	jalr	-1714(ra) # 80004436 <argint>
    80007af0:	87aa                	mv	a5,a0
    80007af2:	0007d463          	bgez	a5,80007afa <argfd+0x34>
    return -1;
    80007af6:	57fd                	li	a5,-1
    80007af8:	a8b9                	j	80007b56 <argfd+0x90>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80007afa:	fe442783          	lw	a5,-28(s0)
    80007afe:	0207c963          	bltz	a5,80007b30 <argfd+0x6a>
    80007b02:	fe442783          	lw	a5,-28(s0)
    80007b06:	873e                	mv	a4,a5
    80007b08:	47bd                	li	a5,15
    80007b0a:	02e7c363          	blt	a5,a4,80007b30 <argfd+0x6a>
    80007b0e:	ffffb097          	auipc	ra,0xffffb
    80007b12:	cea080e7          	jalr	-790(ra) # 800027f8 <myproc>
    80007b16:	872a                	mv	a4,a0
    80007b18:	fe442783          	lw	a5,-28(s0)
    80007b1c:	26678793          	addi	a5,a5,614 # 1266 <_entry-0x7fffed9a>
    80007b20:	078e                	slli	a5,a5,0x3
    80007b22:	97ba                	add	a5,a5,a4
    80007b24:	679c                	ld	a5,8(a5)
    80007b26:	fef43423          	sd	a5,-24(s0)
    80007b2a:	fe843783          	ld	a5,-24(s0)
    80007b2e:	e399                	bnez	a5,80007b34 <argfd+0x6e>
    return -1;
    80007b30:	57fd                	li	a5,-1
    80007b32:	a015                	j	80007b56 <argfd+0x90>
  if(pfd)
    80007b34:	fd043783          	ld	a5,-48(s0)
    80007b38:	c791                	beqz	a5,80007b44 <argfd+0x7e>
    *pfd = fd;
    80007b3a:	fe442703          	lw	a4,-28(s0)
    80007b3e:	fd043783          	ld	a5,-48(s0)
    80007b42:	c398                	sw	a4,0(a5)
  if(pf)
    80007b44:	fc843783          	ld	a5,-56(s0)
    80007b48:	c791                	beqz	a5,80007b54 <argfd+0x8e>
    *pf = f;
    80007b4a:	fc843783          	ld	a5,-56(s0)
    80007b4e:	fe843703          	ld	a4,-24(s0)
    80007b52:	e398                	sd	a4,0(a5)
  return 0;
    80007b54:	4781                	li	a5,0
}
    80007b56:	853e                	mv	a0,a5
    80007b58:	70e2                	ld	ra,56(sp)
    80007b5a:	7442                	ld	s0,48(sp)
    80007b5c:	6121                	addi	sp,sp,64
    80007b5e:	8082                	ret

0000000080007b60 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80007b60:	7179                	addi	sp,sp,-48
    80007b62:	f406                	sd	ra,40(sp)
    80007b64:	f022                	sd	s0,32(sp)
    80007b66:	1800                	addi	s0,sp,48
    80007b68:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    80007b6c:	ffffb097          	auipc	ra,0xffffb
    80007b70:	c8c080e7          	jalr	-884(ra) # 800027f8 <myproc>
    80007b74:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80007b78:	fe042623          	sw	zero,-20(s0)
    80007b7c:	a835                	j	80007bb8 <fdalloc+0x58>
    if(p->ofile[fd] == 0){
    80007b7e:	fe043703          	ld	a4,-32(s0)
    80007b82:	fec42783          	lw	a5,-20(s0)
    80007b86:	26678793          	addi	a5,a5,614
    80007b8a:	078e                	slli	a5,a5,0x3
    80007b8c:	97ba                	add	a5,a5,a4
    80007b8e:	679c                	ld	a5,8(a5)
    80007b90:	ef99                	bnez	a5,80007bae <fdalloc+0x4e>
      p->ofile[fd] = f;
    80007b92:	fe043703          	ld	a4,-32(s0)
    80007b96:	fec42783          	lw	a5,-20(s0)
    80007b9a:	26678793          	addi	a5,a5,614
    80007b9e:	078e                	slli	a5,a5,0x3
    80007ba0:	97ba                	add	a5,a5,a4
    80007ba2:	fd843703          	ld	a4,-40(s0)
    80007ba6:	e798                	sd	a4,8(a5)
      return fd;
    80007ba8:	fec42783          	lw	a5,-20(s0)
    80007bac:	a831                	j	80007bc8 <fdalloc+0x68>
  for(fd = 0; fd < NOFILE; fd++){
    80007bae:	fec42783          	lw	a5,-20(s0)
    80007bb2:	2785                	addiw	a5,a5,1
    80007bb4:	fef42623          	sw	a5,-20(s0)
    80007bb8:	fec42783          	lw	a5,-20(s0)
    80007bbc:	0007871b          	sext.w	a4,a5
    80007bc0:	47bd                	li	a5,15
    80007bc2:	fae7dee3          	bge	a5,a4,80007b7e <fdalloc+0x1e>
    }
  }
  return -1;
    80007bc6:	57fd                	li	a5,-1
}
    80007bc8:	853e                	mv	a0,a5
    80007bca:	70a2                	ld	ra,40(sp)
    80007bcc:	7402                	ld	s0,32(sp)
    80007bce:	6145                	addi	sp,sp,48
    80007bd0:	8082                	ret

0000000080007bd2 <sys_dup>:

uint64
sys_dup(void)
{
    80007bd2:	1101                	addi	sp,sp,-32
    80007bd4:	ec06                	sd	ra,24(sp)
    80007bd6:	e822                	sd	s0,16(sp)
    80007bd8:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80007bda:	fe040793          	addi	a5,s0,-32
    80007bde:	863e                	mv	a2,a5
    80007be0:	4581                	li	a1,0
    80007be2:	4501                	li	a0,0
    80007be4:	00000097          	auipc	ra,0x0
    80007be8:	ee2080e7          	jalr	-286(ra) # 80007ac6 <argfd>
    80007bec:	87aa                	mv	a5,a0
    80007bee:	0007d463          	bgez	a5,80007bf6 <sys_dup+0x24>
    return -1;
    80007bf2:	57fd                	li	a5,-1
    80007bf4:	a81d                	j	80007c2a <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80007bf6:	fe043783          	ld	a5,-32(s0)
    80007bfa:	853e                	mv	a0,a5
    80007bfc:	00000097          	auipc	ra,0x0
    80007c00:	f64080e7          	jalr	-156(ra) # 80007b60 <fdalloc>
    80007c04:	87aa                	mv	a5,a0
    80007c06:	fef42623          	sw	a5,-20(s0)
    80007c0a:	fec42783          	lw	a5,-20(s0)
    80007c0e:	2781                	sext.w	a5,a5
    80007c10:	0007d463          	bgez	a5,80007c18 <sys_dup+0x46>
    return -1;
    80007c14:	57fd                	li	a5,-1
    80007c16:	a811                	j	80007c2a <sys_dup+0x58>
  filedup(f);
    80007c18:	fe043783          	ld	a5,-32(s0)
    80007c1c:	853e                	mv	a0,a5
    80007c1e:	fffff097          	auipc	ra,0xfffff
    80007c22:	ea6080e7          	jalr	-346(ra) # 80006ac4 <filedup>
  return fd;
    80007c26:	fec42783          	lw	a5,-20(s0)
}
    80007c2a:	853e                	mv	a0,a5
    80007c2c:	60e2                	ld	ra,24(sp)
    80007c2e:	6442                	ld	s0,16(sp)
    80007c30:	6105                	addi	sp,sp,32
    80007c32:	8082                	ret

0000000080007c34 <sys_read>:

uint64
sys_read(void)
{
    80007c34:	7179                	addi	sp,sp,-48
    80007c36:	f406                	sd	ra,40(sp)
    80007c38:	f022                	sd	s0,32(sp)
    80007c3a:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80007c3c:	fe840793          	addi	a5,s0,-24
    80007c40:	863e                	mv	a2,a5
    80007c42:	4581                	li	a1,0
    80007c44:	4501                	li	a0,0
    80007c46:	00000097          	auipc	ra,0x0
    80007c4a:	e80080e7          	jalr	-384(ra) # 80007ac6 <argfd>
    80007c4e:	87aa                	mv	a5,a0
    80007c50:	0207c863          	bltz	a5,80007c80 <sys_read+0x4c>
    80007c54:	fe440793          	addi	a5,s0,-28
    80007c58:	85be                	mv	a1,a5
    80007c5a:	4509                	li	a0,2
    80007c5c:	ffffc097          	auipc	ra,0xffffc
    80007c60:	7da080e7          	jalr	2010(ra) # 80004436 <argint>
    80007c64:	87aa                	mv	a5,a0
    80007c66:	0007cd63          	bltz	a5,80007c80 <sys_read+0x4c>
    80007c6a:	fd840793          	addi	a5,s0,-40
    80007c6e:	85be                	mv	a1,a5
    80007c70:	4505                	li	a0,1
    80007c72:	ffffc097          	auipc	ra,0xffffc
    80007c76:	7fc080e7          	jalr	2044(ra) # 8000446e <argaddr>
    80007c7a:	87aa                	mv	a5,a0
    80007c7c:	0007d463          	bgez	a5,80007c84 <sys_read+0x50>
    return -1;
    80007c80:	57fd                	li	a5,-1
    80007c82:	a839                	j	80007ca0 <sys_read+0x6c>
  return fileread(f, p, n);
    80007c84:	fe843783          	ld	a5,-24(s0)
    80007c88:	fd843703          	ld	a4,-40(s0)
    80007c8c:	fe442683          	lw	a3,-28(s0)
    80007c90:	8636                	mv	a2,a3
    80007c92:	85ba                	mv	a1,a4
    80007c94:	853e                	mv	a0,a5
    80007c96:	fffff097          	auipc	ra,0xfffff
    80007c9a:	046080e7          	jalr	70(ra) # 80006cdc <fileread>
    80007c9e:	87aa                	mv	a5,a0
}
    80007ca0:	853e                	mv	a0,a5
    80007ca2:	70a2                	ld	ra,40(sp)
    80007ca4:	7402                	ld	s0,32(sp)
    80007ca6:	6145                	addi	sp,sp,48
    80007ca8:	8082                	ret

0000000080007caa <sys_write>:

uint64
sys_write(void)
{
    80007caa:	7179                	addi	sp,sp,-48
    80007cac:	f406                	sd	ra,40(sp)
    80007cae:	f022                	sd	s0,32(sp)
    80007cb0:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80007cb2:	fe840793          	addi	a5,s0,-24
    80007cb6:	863e                	mv	a2,a5
    80007cb8:	4581                	li	a1,0
    80007cba:	4501                	li	a0,0
    80007cbc:	00000097          	auipc	ra,0x0
    80007cc0:	e0a080e7          	jalr	-502(ra) # 80007ac6 <argfd>
    80007cc4:	87aa                	mv	a5,a0
    80007cc6:	0207c863          	bltz	a5,80007cf6 <sys_write+0x4c>
    80007cca:	fe440793          	addi	a5,s0,-28
    80007cce:	85be                	mv	a1,a5
    80007cd0:	4509                	li	a0,2
    80007cd2:	ffffc097          	auipc	ra,0xffffc
    80007cd6:	764080e7          	jalr	1892(ra) # 80004436 <argint>
    80007cda:	87aa                	mv	a5,a0
    80007cdc:	0007cd63          	bltz	a5,80007cf6 <sys_write+0x4c>
    80007ce0:	fd840793          	addi	a5,s0,-40
    80007ce4:	85be                	mv	a1,a5
    80007ce6:	4505                	li	a0,1
    80007ce8:	ffffc097          	auipc	ra,0xffffc
    80007cec:	786080e7          	jalr	1926(ra) # 8000446e <argaddr>
    80007cf0:	87aa                	mv	a5,a0
    80007cf2:	0007d463          	bgez	a5,80007cfa <sys_write+0x50>
    return -1;
    80007cf6:	57fd                	li	a5,-1
    80007cf8:	a839                	j	80007d16 <sys_write+0x6c>

  return filewrite(f, p, n);
    80007cfa:	fe843783          	ld	a5,-24(s0)
    80007cfe:	fd843703          	ld	a4,-40(s0)
    80007d02:	fe442683          	lw	a3,-28(s0)
    80007d06:	8636                	mv	a2,a3
    80007d08:	85ba                	mv	a1,a4
    80007d0a:	853e                	mv	a0,a5
    80007d0c:	fffff097          	auipc	ra,0xfffff
    80007d10:	136080e7          	jalr	310(ra) # 80006e42 <filewrite>
    80007d14:	87aa                	mv	a5,a0
}
    80007d16:	853e                	mv	a0,a5
    80007d18:	70a2                	ld	ra,40(sp)
    80007d1a:	7402                	ld	s0,32(sp)
    80007d1c:	6145                	addi	sp,sp,48
    80007d1e:	8082                	ret

0000000080007d20 <sys_close>:

uint64
sys_close(void)
{
    80007d20:	1101                	addi	sp,sp,-32
    80007d22:	ec06                	sd	ra,24(sp)
    80007d24:	e822                	sd	s0,16(sp)
    80007d26:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80007d28:	fe040713          	addi	a4,s0,-32
    80007d2c:	fec40793          	addi	a5,s0,-20
    80007d30:	863a                	mv	a2,a4
    80007d32:	85be                	mv	a1,a5
    80007d34:	4501                	li	a0,0
    80007d36:	00000097          	auipc	ra,0x0
    80007d3a:	d90080e7          	jalr	-624(ra) # 80007ac6 <argfd>
    80007d3e:	87aa                	mv	a5,a0
    80007d40:	0007d463          	bgez	a5,80007d48 <sys_close+0x28>
    return -1;
    80007d44:	57fd                	li	a5,-1
    80007d46:	a035                	j	80007d72 <sys_close+0x52>
  myproc()->ofile[fd] = 0;
    80007d48:	ffffb097          	auipc	ra,0xffffb
    80007d4c:	ab0080e7          	jalr	-1360(ra) # 800027f8 <myproc>
    80007d50:	872a                	mv	a4,a0
    80007d52:	fec42783          	lw	a5,-20(s0)
    80007d56:	26678793          	addi	a5,a5,614
    80007d5a:	078e                	slli	a5,a5,0x3
    80007d5c:	97ba                	add	a5,a5,a4
    80007d5e:	0007b423          	sd	zero,8(a5)
  fileclose(f);
    80007d62:	fe043783          	ld	a5,-32(s0)
    80007d66:	853e                	mv	a0,a5
    80007d68:	fffff097          	auipc	ra,0xfffff
    80007d6c:	dc2080e7          	jalr	-574(ra) # 80006b2a <fileclose>
  return 0;
    80007d70:	4781                	li	a5,0
}
    80007d72:	853e                	mv	a0,a5
    80007d74:	60e2                	ld	ra,24(sp)
    80007d76:	6442                	ld	s0,16(sp)
    80007d78:	6105                	addi	sp,sp,32
    80007d7a:	8082                	ret

0000000080007d7c <sys_fstat>:

uint64
sys_fstat(void)
{
    80007d7c:	1101                	addi	sp,sp,-32
    80007d7e:	ec06                	sd	ra,24(sp)
    80007d80:	e822                	sd	s0,16(sp)
    80007d82:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80007d84:	fe840793          	addi	a5,s0,-24
    80007d88:	863e                	mv	a2,a5
    80007d8a:	4581                	li	a1,0
    80007d8c:	4501                	li	a0,0
    80007d8e:	00000097          	auipc	ra,0x0
    80007d92:	d38080e7          	jalr	-712(ra) # 80007ac6 <argfd>
    80007d96:	87aa                	mv	a5,a0
    80007d98:	0007cd63          	bltz	a5,80007db2 <sys_fstat+0x36>
    80007d9c:	fe040793          	addi	a5,s0,-32
    80007da0:	85be                	mv	a1,a5
    80007da2:	4505                	li	a0,1
    80007da4:	ffffc097          	auipc	ra,0xffffc
    80007da8:	6ca080e7          	jalr	1738(ra) # 8000446e <argaddr>
    80007dac:	87aa                	mv	a5,a0
    80007dae:	0007d463          	bgez	a5,80007db6 <sys_fstat+0x3a>
    return -1;
    80007db2:	57fd                	li	a5,-1
    80007db4:	a821                	j	80007dcc <sys_fstat+0x50>
  return filestat(f, st);
    80007db6:	fe843783          	ld	a5,-24(s0)
    80007dba:	fe043703          	ld	a4,-32(s0)
    80007dbe:	85ba                	mv	a1,a4
    80007dc0:	853e                	mv	a0,a5
    80007dc2:	fffff097          	auipc	ra,0xfffff
    80007dc6:	e70080e7          	jalr	-400(ra) # 80006c32 <filestat>
    80007dca:	87aa                	mv	a5,a0
}
    80007dcc:	853e                	mv	a0,a5
    80007dce:	60e2                	ld	ra,24(sp)
    80007dd0:	6442                	ld	s0,16(sp)
    80007dd2:	6105                	addi	sp,sp,32
    80007dd4:	8082                	ret

0000000080007dd6 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80007dd6:	7169                	addi	sp,sp,-304
    80007dd8:	f606                	sd	ra,296(sp)
    80007dda:	f222                	sd	s0,288(sp)
    80007ddc:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80007dde:	ed040793          	addi	a5,s0,-304
    80007de2:	08000613          	li	a2,128
    80007de6:	85be                	mv	a1,a5
    80007de8:	4501                	li	a0,0
    80007dea:	ffffc097          	auipc	ra,0xffffc
    80007dee:	6b8080e7          	jalr	1720(ra) # 800044a2 <argstr>
    80007df2:	87aa                	mv	a5,a0
    80007df4:	0007cf63          	bltz	a5,80007e12 <sys_link+0x3c>
    80007df8:	f5040793          	addi	a5,s0,-176
    80007dfc:	08000613          	li	a2,128
    80007e00:	85be                	mv	a1,a5
    80007e02:	4505                	li	a0,1
    80007e04:	ffffc097          	auipc	ra,0xffffc
    80007e08:	69e080e7          	jalr	1694(ra) # 800044a2 <argstr>
    80007e0c:	87aa                	mv	a5,a0
    80007e0e:	0007d463          	bgez	a5,80007e16 <sys_link+0x40>
    return -1;
    80007e12:	57fd                	li	a5,-1
    80007e14:	aab5                	j	80007f90 <sys_link+0x1ba>

  begin_op();
    80007e16:	ffffe097          	auipc	ra,0xffffe
    80007e1a:	67a080e7          	jalr	1658(ra) # 80006490 <begin_op>
  if((ip = namei(old)) == 0){
    80007e1e:	ed040793          	addi	a5,s0,-304
    80007e22:	853e                	mv	a0,a5
    80007e24:	ffffe097          	auipc	ra,0xffffe
    80007e28:	308080e7          	jalr	776(ra) # 8000612c <namei>
    80007e2c:	fea43423          	sd	a0,-24(s0)
    80007e30:	fe843783          	ld	a5,-24(s0)
    80007e34:	e799                	bnez	a5,80007e42 <sys_link+0x6c>
    end_op();
    80007e36:	ffffe097          	auipc	ra,0xffffe
    80007e3a:	71c080e7          	jalr	1820(ra) # 80006552 <end_op>
    return -1;
    80007e3e:	57fd                	li	a5,-1
    80007e40:	aa81                	j	80007f90 <sys_link+0x1ba>
  }

  ilock(ip);
    80007e42:	fe843503          	ld	a0,-24(s0)
    80007e46:	ffffd097          	auipc	ra,0xffffd
    80007e4a:	5de080e7          	jalr	1502(ra) # 80005424 <ilock>
  if(ip->type == T_DIR){
    80007e4e:	fe843783          	ld	a5,-24(s0)
    80007e52:	04479783          	lh	a5,68(a5)
    80007e56:	0007871b          	sext.w	a4,a5
    80007e5a:	4785                	li	a5,1
    80007e5c:	00f71e63          	bne	a4,a5,80007e78 <sys_link+0xa2>
    iunlockput(ip);
    80007e60:	fe843503          	ld	a0,-24(s0)
    80007e64:	ffffe097          	auipc	ra,0xffffe
    80007e68:	81e080e7          	jalr	-2018(ra) # 80005682 <iunlockput>
    end_op();
    80007e6c:	ffffe097          	auipc	ra,0xffffe
    80007e70:	6e6080e7          	jalr	1766(ra) # 80006552 <end_op>
    return -1;
    80007e74:	57fd                	li	a5,-1
    80007e76:	aa29                	j	80007f90 <sys_link+0x1ba>
  }

  ip->nlink++;
    80007e78:	fe843783          	ld	a5,-24(s0)
    80007e7c:	04a79783          	lh	a5,74(a5)
    80007e80:	17c2                	slli	a5,a5,0x30
    80007e82:	93c1                	srli	a5,a5,0x30
    80007e84:	2785                	addiw	a5,a5,1
    80007e86:	17c2                	slli	a5,a5,0x30
    80007e88:	93c1                	srli	a5,a5,0x30
    80007e8a:	0107971b          	slliw	a4,a5,0x10
    80007e8e:	4107571b          	sraiw	a4,a4,0x10
    80007e92:	fe843783          	ld	a5,-24(s0)
    80007e96:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007e9a:	fe843503          	ld	a0,-24(s0)
    80007e9e:	ffffd097          	auipc	ra,0xffffd
    80007ea2:	336080e7          	jalr	822(ra) # 800051d4 <iupdate>
  iunlock(ip);
    80007ea6:	fe843503          	ld	a0,-24(s0)
    80007eaa:	ffffd097          	auipc	ra,0xffffd
    80007eae:	6ae080e7          	jalr	1710(ra) # 80005558 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80007eb2:	fd040713          	addi	a4,s0,-48
    80007eb6:	f5040793          	addi	a5,s0,-176
    80007eba:	85ba                	mv	a1,a4
    80007ebc:	853e                	mv	a0,a5
    80007ebe:	ffffe097          	auipc	ra,0xffffe
    80007ec2:	29a080e7          	jalr	666(ra) # 80006158 <nameiparent>
    80007ec6:	fea43023          	sd	a0,-32(s0)
    80007eca:	fe043783          	ld	a5,-32(s0)
    80007ece:	cba5                	beqz	a5,80007f3e <sys_link+0x168>
    goto bad;
  ilock(dp);
    80007ed0:	fe043503          	ld	a0,-32(s0)
    80007ed4:	ffffd097          	auipc	ra,0xffffd
    80007ed8:	550080e7          	jalr	1360(ra) # 80005424 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80007edc:	fe043783          	ld	a5,-32(s0)
    80007ee0:	4398                	lw	a4,0(a5)
    80007ee2:	fe843783          	ld	a5,-24(s0)
    80007ee6:	439c                	lw	a5,0(a5)
    80007ee8:	02f71263          	bne	a4,a5,80007f0c <sys_link+0x136>
    80007eec:	fe843783          	ld	a5,-24(s0)
    80007ef0:	43d8                	lw	a4,4(a5)
    80007ef2:	fd040793          	addi	a5,s0,-48
    80007ef6:	863a                	mv	a2,a4
    80007ef8:	85be                	mv	a1,a5
    80007efa:	fe043503          	ld	a0,-32(s0)
    80007efe:	ffffe097          	auipc	ra,0xffffe
    80007f02:	f10080e7          	jalr	-240(ra) # 80005e0e <dirlink>
    80007f06:	87aa                	mv	a5,a0
    80007f08:	0007d963          	bgez	a5,80007f1a <sys_link+0x144>
    iunlockput(dp);
    80007f0c:	fe043503          	ld	a0,-32(s0)
    80007f10:	ffffd097          	auipc	ra,0xffffd
    80007f14:	772080e7          	jalr	1906(ra) # 80005682 <iunlockput>
    goto bad;
    80007f18:	a025                	j	80007f40 <sys_link+0x16a>
  }
  iunlockput(dp);
    80007f1a:	fe043503          	ld	a0,-32(s0)
    80007f1e:	ffffd097          	auipc	ra,0xffffd
    80007f22:	764080e7          	jalr	1892(ra) # 80005682 <iunlockput>
  iput(ip);
    80007f26:	fe843503          	ld	a0,-24(s0)
    80007f2a:	ffffd097          	auipc	ra,0xffffd
    80007f2e:	688080e7          	jalr	1672(ra) # 800055b2 <iput>

  end_op();
    80007f32:	ffffe097          	auipc	ra,0xffffe
    80007f36:	620080e7          	jalr	1568(ra) # 80006552 <end_op>

  return 0;
    80007f3a:	4781                	li	a5,0
    80007f3c:	a891                	j	80007f90 <sys_link+0x1ba>
    goto bad;
    80007f3e:	0001                	nop

bad:
  ilock(ip);
    80007f40:	fe843503          	ld	a0,-24(s0)
    80007f44:	ffffd097          	auipc	ra,0xffffd
    80007f48:	4e0080e7          	jalr	1248(ra) # 80005424 <ilock>
  ip->nlink--;
    80007f4c:	fe843783          	ld	a5,-24(s0)
    80007f50:	04a79783          	lh	a5,74(a5)
    80007f54:	17c2                	slli	a5,a5,0x30
    80007f56:	93c1                	srli	a5,a5,0x30
    80007f58:	37fd                	addiw	a5,a5,-1
    80007f5a:	17c2                	slli	a5,a5,0x30
    80007f5c:	93c1                	srli	a5,a5,0x30
    80007f5e:	0107971b          	slliw	a4,a5,0x10
    80007f62:	4107571b          	sraiw	a4,a4,0x10
    80007f66:	fe843783          	ld	a5,-24(s0)
    80007f6a:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007f6e:	fe843503          	ld	a0,-24(s0)
    80007f72:	ffffd097          	auipc	ra,0xffffd
    80007f76:	262080e7          	jalr	610(ra) # 800051d4 <iupdate>
  iunlockput(ip);
    80007f7a:	fe843503          	ld	a0,-24(s0)
    80007f7e:	ffffd097          	auipc	ra,0xffffd
    80007f82:	704080e7          	jalr	1796(ra) # 80005682 <iunlockput>
  end_op();
    80007f86:	ffffe097          	auipc	ra,0xffffe
    80007f8a:	5cc080e7          	jalr	1484(ra) # 80006552 <end_op>
  return -1;
    80007f8e:	57fd                	li	a5,-1
}
    80007f90:	853e                	mv	a0,a5
    80007f92:	70b2                	ld	ra,296(sp)
    80007f94:	7412                	ld	s0,288(sp)
    80007f96:	6155                	addi	sp,sp,304
    80007f98:	8082                	ret

0000000080007f9a <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80007f9a:	7139                	addi	sp,sp,-64
    80007f9c:	fc06                	sd	ra,56(sp)
    80007f9e:	f822                	sd	s0,48(sp)
    80007fa0:	0080                	addi	s0,sp,64
    80007fa2:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007fa6:	02000793          	li	a5,32
    80007faa:	fef42623          	sw	a5,-20(s0)
    80007fae:	a0b1                	j	80007ffa <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007fb0:	fd840793          	addi	a5,s0,-40
    80007fb4:	fec42683          	lw	a3,-20(s0)
    80007fb8:	4741                	li	a4,16
    80007fba:	863e                	mv	a2,a5
    80007fbc:	4581                	li	a1,0
    80007fbe:	fc843503          	ld	a0,-56(s0)
    80007fc2:	ffffe097          	auipc	ra,0xffffe
    80007fc6:	9f8080e7          	jalr	-1544(ra) # 800059ba <readi>
    80007fca:	87aa                	mv	a5,a0
    80007fcc:	873e                	mv	a4,a5
    80007fce:	47c1                	li	a5,16
    80007fd0:	00f70a63          	beq	a4,a5,80007fe4 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80007fd4:	00003517          	auipc	a0,0x3
    80007fd8:	64c50513          	addi	a0,a0,1612 # 8000b620 <etext+0x620>
    80007fdc:	ffff9097          	auipc	ra,0xffff9
    80007fe0:	c76080e7          	jalr	-906(ra) # 80000c52 <panic>
    if(de.inum != 0)
    80007fe4:	fd845783          	lhu	a5,-40(s0)
    80007fe8:	c399                	beqz	a5,80007fee <isdirempty+0x54>
      return 0;
    80007fea:	4781                	li	a5,0
    80007fec:	a839                	j	8000800a <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007fee:	fec42783          	lw	a5,-20(s0)
    80007ff2:	27c1                	addiw	a5,a5,16
    80007ff4:	2781                	sext.w	a5,a5
    80007ff6:	fef42623          	sw	a5,-20(s0)
    80007ffa:	fc843783          	ld	a5,-56(s0)
    80007ffe:	47f8                	lw	a4,76(a5)
    80008000:	fec42783          	lw	a5,-20(s0)
    80008004:	fae7e6e3          	bltu	a5,a4,80007fb0 <isdirempty+0x16>
  }
  return 1;
    80008008:	4785                	li	a5,1
}
    8000800a:	853e                	mv	a0,a5
    8000800c:	70e2                	ld	ra,56(sp)
    8000800e:	7442                	ld	s0,48(sp)
    80008010:	6121                	addi	sp,sp,64
    80008012:	8082                	ret

0000000080008014 <sys_unlink>:

uint64
sys_unlink(void)
{
    80008014:	7155                	addi	sp,sp,-208
    80008016:	e586                	sd	ra,200(sp)
    80008018:	e1a2                	sd	s0,192(sp)
    8000801a:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    8000801c:	f4040793          	addi	a5,s0,-192
    80008020:	08000613          	li	a2,128
    80008024:	85be                	mv	a1,a5
    80008026:	4501                	li	a0,0
    80008028:	ffffc097          	auipc	ra,0xffffc
    8000802c:	47a080e7          	jalr	1146(ra) # 800044a2 <argstr>
    80008030:	87aa                	mv	a5,a0
    80008032:	0007d463          	bgez	a5,8000803a <sys_unlink+0x26>
    return -1;
    80008036:	57fd                	li	a5,-1
    80008038:	a2ed                	j	80008222 <sys_unlink+0x20e>

  begin_op();
    8000803a:	ffffe097          	auipc	ra,0xffffe
    8000803e:	456080e7          	jalr	1110(ra) # 80006490 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80008042:	fc040713          	addi	a4,s0,-64
    80008046:	f4040793          	addi	a5,s0,-192
    8000804a:	85ba                	mv	a1,a4
    8000804c:	853e                	mv	a0,a5
    8000804e:	ffffe097          	auipc	ra,0xffffe
    80008052:	10a080e7          	jalr	266(ra) # 80006158 <nameiparent>
    80008056:	fea43423          	sd	a0,-24(s0)
    8000805a:	fe843783          	ld	a5,-24(s0)
    8000805e:	e799                	bnez	a5,8000806c <sys_unlink+0x58>
    end_op();
    80008060:	ffffe097          	auipc	ra,0xffffe
    80008064:	4f2080e7          	jalr	1266(ra) # 80006552 <end_op>
    return -1;
    80008068:	57fd                	li	a5,-1
    8000806a:	aa65                	j	80008222 <sys_unlink+0x20e>
  }

  ilock(dp);
    8000806c:	fe843503          	ld	a0,-24(s0)
    80008070:	ffffd097          	auipc	ra,0xffffd
    80008074:	3b4080e7          	jalr	948(ra) # 80005424 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80008078:	fc040793          	addi	a5,s0,-64
    8000807c:	00003597          	auipc	a1,0x3
    80008080:	5bc58593          	addi	a1,a1,1468 # 8000b638 <etext+0x638>
    80008084:	853e                	mv	a0,a5
    80008086:	ffffe097          	auipc	ra,0xffffe
    8000808a:	c72080e7          	jalr	-910(ra) # 80005cf8 <namecmp>
    8000808e:	87aa                	mv	a5,a0
    80008090:	16078b63          	beqz	a5,80008206 <sys_unlink+0x1f2>
    80008094:	fc040793          	addi	a5,s0,-64
    80008098:	00003597          	auipc	a1,0x3
    8000809c:	5a858593          	addi	a1,a1,1448 # 8000b640 <etext+0x640>
    800080a0:	853e                	mv	a0,a5
    800080a2:	ffffe097          	auipc	ra,0xffffe
    800080a6:	c56080e7          	jalr	-938(ra) # 80005cf8 <namecmp>
    800080aa:	87aa                	mv	a5,a0
    800080ac:	14078d63          	beqz	a5,80008206 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    800080b0:	f3c40713          	addi	a4,s0,-196
    800080b4:	fc040793          	addi	a5,s0,-64
    800080b8:	863a                	mv	a2,a4
    800080ba:	85be                	mv	a1,a5
    800080bc:	fe843503          	ld	a0,-24(s0)
    800080c0:	ffffe097          	auipc	ra,0xffffe
    800080c4:	c66080e7          	jalr	-922(ra) # 80005d26 <dirlookup>
    800080c8:	fea43023          	sd	a0,-32(s0)
    800080cc:	fe043783          	ld	a5,-32(s0)
    800080d0:	12078d63          	beqz	a5,8000820a <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    800080d4:	fe043503          	ld	a0,-32(s0)
    800080d8:	ffffd097          	auipc	ra,0xffffd
    800080dc:	34c080e7          	jalr	844(ra) # 80005424 <ilock>

  if(ip->nlink < 1)
    800080e0:	fe043783          	ld	a5,-32(s0)
    800080e4:	04a79783          	lh	a5,74(a5)
    800080e8:	2781                	sext.w	a5,a5
    800080ea:	00f04a63          	bgtz	a5,800080fe <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    800080ee:	00003517          	auipc	a0,0x3
    800080f2:	55a50513          	addi	a0,a0,1370 # 8000b648 <etext+0x648>
    800080f6:	ffff9097          	auipc	ra,0xffff9
    800080fa:	b5c080e7          	jalr	-1188(ra) # 80000c52 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800080fe:	fe043783          	ld	a5,-32(s0)
    80008102:	04479783          	lh	a5,68(a5)
    80008106:	0007871b          	sext.w	a4,a5
    8000810a:	4785                	li	a5,1
    8000810c:	02f71163          	bne	a4,a5,8000812e <sys_unlink+0x11a>
    80008110:	fe043503          	ld	a0,-32(s0)
    80008114:	00000097          	auipc	ra,0x0
    80008118:	e86080e7          	jalr	-378(ra) # 80007f9a <isdirempty>
    8000811c:	87aa                	mv	a5,a0
    8000811e:	eb81                	bnez	a5,8000812e <sys_unlink+0x11a>
    iunlockput(ip);
    80008120:	fe043503          	ld	a0,-32(s0)
    80008124:	ffffd097          	auipc	ra,0xffffd
    80008128:	55e080e7          	jalr	1374(ra) # 80005682 <iunlockput>
    goto bad;
    8000812c:	a0c5                	j	8000820c <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    8000812e:	fd040793          	addi	a5,s0,-48
    80008132:	4641                	li	a2,16
    80008134:	4581                	li	a1,0
    80008136:	853e                	mv	a0,a5
    80008138:	ffff9097          	auipc	ra,0xffff9
    8000813c:	31c080e7          	jalr	796(ra) # 80001454 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80008140:	fd040793          	addi	a5,s0,-48
    80008144:	f3c42683          	lw	a3,-196(s0)
    80008148:	4741                	li	a4,16
    8000814a:	863e                	mv	a2,a5
    8000814c:	4581                	li	a1,0
    8000814e:	fe843503          	ld	a0,-24(s0)
    80008152:	ffffe097          	auipc	ra,0xffffe
    80008156:	9f2080e7          	jalr	-1550(ra) # 80005b44 <writei>
    8000815a:	87aa                	mv	a5,a0
    8000815c:	873e                	mv	a4,a5
    8000815e:	47c1                	li	a5,16
    80008160:	00f70a63          	beq	a4,a5,80008174 <sys_unlink+0x160>
    panic("unlink: writei");
    80008164:	00003517          	auipc	a0,0x3
    80008168:	4fc50513          	addi	a0,a0,1276 # 8000b660 <etext+0x660>
    8000816c:	ffff9097          	auipc	ra,0xffff9
    80008170:	ae6080e7          	jalr	-1306(ra) # 80000c52 <panic>
  if(ip->type == T_DIR){
    80008174:	fe043783          	ld	a5,-32(s0)
    80008178:	04479783          	lh	a5,68(a5)
    8000817c:	0007871b          	sext.w	a4,a5
    80008180:	4785                	li	a5,1
    80008182:	02f71963          	bne	a4,a5,800081b4 <sys_unlink+0x1a0>
    dp->nlink--;
    80008186:	fe843783          	ld	a5,-24(s0)
    8000818a:	04a79783          	lh	a5,74(a5)
    8000818e:	17c2                	slli	a5,a5,0x30
    80008190:	93c1                	srli	a5,a5,0x30
    80008192:	37fd                	addiw	a5,a5,-1
    80008194:	17c2                	slli	a5,a5,0x30
    80008196:	93c1                	srli	a5,a5,0x30
    80008198:	0107971b          	slliw	a4,a5,0x10
    8000819c:	4107571b          	sraiw	a4,a4,0x10
    800081a0:	fe843783          	ld	a5,-24(s0)
    800081a4:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    800081a8:	fe843503          	ld	a0,-24(s0)
    800081ac:	ffffd097          	auipc	ra,0xffffd
    800081b0:	028080e7          	jalr	40(ra) # 800051d4 <iupdate>
  }
  iunlockput(dp);
    800081b4:	fe843503          	ld	a0,-24(s0)
    800081b8:	ffffd097          	auipc	ra,0xffffd
    800081bc:	4ca080e7          	jalr	1226(ra) # 80005682 <iunlockput>

  ip->nlink--;
    800081c0:	fe043783          	ld	a5,-32(s0)
    800081c4:	04a79783          	lh	a5,74(a5)
    800081c8:	17c2                	slli	a5,a5,0x30
    800081ca:	93c1                	srli	a5,a5,0x30
    800081cc:	37fd                	addiw	a5,a5,-1
    800081ce:	17c2                	slli	a5,a5,0x30
    800081d0:	93c1                	srli	a5,a5,0x30
    800081d2:	0107971b          	slliw	a4,a5,0x10
    800081d6:	4107571b          	sraiw	a4,a4,0x10
    800081da:	fe043783          	ld	a5,-32(s0)
    800081de:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800081e2:	fe043503          	ld	a0,-32(s0)
    800081e6:	ffffd097          	auipc	ra,0xffffd
    800081ea:	fee080e7          	jalr	-18(ra) # 800051d4 <iupdate>
  iunlockput(ip);
    800081ee:	fe043503          	ld	a0,-32(s0)
    800081f2:	ffffd097          	auipc	ra,0xffffd
    800081f6:	490080e7          	jalr	1168(ra) # 80005682 <iunlockput>

  end_op();
    800081fa:	ffffe097          	auipc	ra,0xffffe
    800081fe:	358080e7          	jalr	856(ra) # 80006552 <end_op>

  return 0;
    80008202:	4781                	li	a5,0
    80008204:	a839                	j	80008222 <sys_unlink+0x20e>
    goto bad;
    80008206:	0001                	nop
    80008208:	a011                	j	8000820c <sys_unlink+0x1f8>
    goto bad;
    8000820a:	0001                	nop

bad:
  iunlockput(dp);
    8000820c:	fe843503          	ld	a0,-24(s0)
    80008210:	ffffd097          	auipc	ra,0xffffd
    80008214:	472080e7          	jalr	1138(ra) # 80005682 <iunlockput>
  end_op();
    80008218:	ffffe097          	auipc	ra,0xffffe
    8000821c:	33a080e7          	jalr	826(ra) # 80006552 <end_op>
  return -1;
    80008220:	57fd                	li	a5,-1
}
    80008222:	853e                	mv	a0,a5
    80008224:	60ae                	ld	ra,200(sp)
    80008226:	640e                	ld	s0,192(sp)
    80008228:	6169                	addi	sp,sp,208
    8000822a:	8082                	ret

000000008000822c <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000822c:	7139                	addi	sp,sp,-64
    8000822e:	fc06                	sd	ra,56(sp)
    80008230:	f822                	sd	s0,48(sp)
    80008232:	0080                	addi	s0,sp,64
    80008234:	fca43423          	sd	a0,-56(s0)
    80008238:	87ae                	mv	a5,a1
    8000823a:	8736                	mv	a4,a3
    8000823c:	fcf41323          	sh	a5,-58(s0)
    80008240:	87b2                	mv	a5,a2
    80008242:	fcf41223          	sh	a5,-60(s0)
    80008246:	87ba                	mv	a5,a4
    80008248:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    8000824c:	fd040793          	addi	a5,s0,-48
    80008250:	85be                	mv	a1,a5
    80008252:	fc843503          	ld	a0,-56(s0)
    80008256:	ffffe097          	auipc	ra,0xffffe
    8000825a:	f02080e7          	jalr	-254(ra) # 80006158 <nameiparent>
    8000825e:	fea43423          	sd	a0,-24(s0)
    80008262:	fe843783          	ld	a5,-24(s0)
    80008266:	e399                	bnez	a5,8000826c <create+0x40>
    return 0;
    80008268:	4781                	li	a5,0
    8000826a:	a2d9                	j	80008430 <create+0x204>

  ilock(dp);
    8000826c:	fe843503          	ld	a0,-24(s0)
    80008270:	ffffd097          	auipc	ra,0xffffd
    80008274:	1b4080e7          	jalr	436(ra) # 80005424 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80008278:	fd040793          	addi	a5,s0,-48
    8000827c:	4601                	li	a2,0
    8000827e:	85be                	mv	a1,a5
    80008280:	fe843503          	ld	a0,-24(s0)
    80008284:	ffffe097          	auipc	ra,0xffffe
    80008288:	aa2080e7          	jalr	-1374(ra) # 80005d26 <dirlookup>
    8000828c:	fea43023          	sd	a0,-32(s0)
    80008290:	fe043783          	ld	a5,-32(s0)
    80008294:	c3ad                	beqz	a5,800082f6 <create+0xca>
    iunlockput(dp);
    80008296:	fe843503          	ld	a0,-24(s0)
    8000829a:	ffffd097          	auipc	ra,0xffffd
    8000829e:	3e8080e7          	jalr	1000(ra) # 80005682 <iunlockput>
    ilock(ip);
    800082a2:	fe043503          	ld	a0,-32(s0)
    800082a6:	ffffd097          	auipc	ra,0xffffd
    800082aa:	17e080e7          	jalr	382(ra) # 80005424 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800082ae:	fc641783          	lh	a5,-58(s0)
    800082b2:	0007871b          	sext.w	a4,a5
    800082b6:	4789                	li	a5,2
    800082b8:	02f71763          	bne	a4,a5,800082e6 <create+0xba>
    800082bc:	fe043783          	ld	a5,-32(s0)
    800082c0:	04479783          	lh	a5,68(a5)
    800082c4:	0007871b          	sext.w	a4,a5
    800082c8:	4789                	li	a5,2
    800082ca:	00f70b63          	beq	a4,a5,800082e0 <create+0xb4>
    800082ce:	fe043783          	ld	a5,-32(s0)
    800082d2:	04479783          	lh	a5,68(a5)
    800082d6:	0007871b          	sext.w	a4,a5
    800082da:	478d                	li	a5,3
    800082dc:	00f71563          	bne	a4,a5,800082e6 <create+0xba>
      return ip;
    800082e0:	fe043783          	ld	a5,-32(s0)
    800082e4:	a2b1                	j	80008430 <create+0x204>
    iunlockput(ip);
    800082e6:	fe043503          	ld	a0,-32(s0)
    800082ea:	ffffd097          	auipc	ra,0xffffd
    800082ee:	398080e7          	jalr	920(ra) # 80005682 <iunlockput>
    return 0;
    800082f2:	4781                	li	a5,0
    800082f4:	aa35                	j	80008430 <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    800082f6:	fe843783          	ld	a5,-24(s0)
    800082fa:	439c                	lw	a5,0(a5)
    800082fc:	fc641703          	lh	a4,-58(s0)
    80008300:	85ba                	mv	a1,a4
    80008302:	853e                	mv	a0,a5
    80008304:	ffffd097          	auipc	ra,0xffffd
    80008308:	dd4080e7          	jalr	-556(ra) # 800050d8 <ialloc>
    8000830c:	fea43023          	sd	a0,-32(s0)
    80008310:	fe043783          	ld	a5,-32(s0)
    80008314:	eb89                	bnez	a5,80008326 <create+0xfa>
    panic("create: ialloc");
    80008316:	00003517          	auipc	a0,0x3
    8000831a:	35a50513          	addi	a0,a0,858 # 8000b670 <etext+0x670>
    8000831e:	ffff9097          	auipc	ra,0xffff9
    80008322:	934080e7          	jalr	-1740(ra) # 80000c52 <panic>

  ilock(ip);
    80008326:	fe043503          	ld	a0,-32(s0)
    8000832a:	ffffd097          	auipc	ra,0xffffd
    8000832e:	0fa080e7          	jalr	250(ra) # 80005424 <ilock>
  ip->major = major;
    80008332:	fe043783          	ld	a5,-32(s0)
    80008336:	fc445703          	lhu	a4,-60(s0)
    8000833a:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    8000833e:	fe043783          	ld	a5,-32(s0)
    80008342:	fc245703          	lhu	a4,-62(s0)
    80008346:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    8000834a:	fe043783          	ld	a5,-32(s0)
    8000834e:	4705                	li	a4,1
    80008350:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008354:	fe043503          	ld	a0,-32(s0)
    80008358:	ffffd097          	auipc	ra,0xffffd
    8000835c:	e7c080e7          	jalr	-388(ra) # 800051d4 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80008360:	fc641783          	lh	a5,-58(s0)
    80008364:	0007871b          	sext.w	a4,a5
    80008368:	4785                	li	a5,1
    8000836a:	08f71363          	bne	a4,a5,800083f0 <create+0x1c4>
    dp->nlink++;  // for ".."
    8000836e:	fe843783          	ld	a5,-24(s0)
    80008372:	04a79783          	lh	a5,74(a5)
    80008376:	17c2                	slli	a5,a5,0x30
    80008378:	93c1                	srli	a5,a5,0x30
    8000837a:	2785                	addiw	a5,a5,1
    8000837c:	17c2                	slli	a5,a5,0x30
    8000837e:	93c1                	srli	a5,a5,0x30
    80008380:	0107971b          	slliw	a4,a5,0x10
    80008384:	4107571b          	sraiw	a4,a4,0x10
    80008388:	fe843783          	ld	a5,-24(s0)
    8000838c:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008390:	fe843503          	ld	a0,-24(s0)
    80008394:	ffffd097          	auipc	ra,0xffffd
    80008398:	e40080e7          	jalr	-448(ra) # 800051d4 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000839c:	fe043783          	ld	a5,-32(s0)
    800083a0:	43dc                	lw	a5,4(a5)
    800083a2:	863e                	mv	a2,a5
    800083a4:	00003597          	auipc	a1,0x3
    800083a8:	29458593          	addi	a1,a1,660 # 8000b638 <etext+0x638>
    800083ac:	fe043503          	ld	a0,-32(s0)
    800083b0:	ffffe097          	auipc	ra,0xffffe
    800083b4:	a5e080e7          	jalr	-1442(ra) # 80005e0e <dirlink>
    800083b8:	87aa                	mv	a5,a0
    800083ba:	0207c363          	bltz	a5,800083e0 <create+0x1b4>
    800083be:	fe843783          	ld	a5,-24(s0)
    800083c2:	43dc                	lw	a5,4(a5)
    800083c4:	863e                	mv	a2,a5
    800083c6:	00003597          	auipc	a1,0x3
    800083ca:	27a58593          	addi	a1,a1,634 # 8000b640 <etext+0x640>
    800083ce:	fe043503          	ld	a0,-32(s0)
    800083d2:	ffffe097          	auipc	ra,0xffffe
    800083d6:	a3c080e7          	jalr	-1476(ra) # 80005e0e <dirlink>
    800083da:	87aa                	mv	a5,a0
    800083dc:	0007da63          	bgez	a5,800083f0 <create+0x1c4>
      panic("create dots");
    800083e0:	00003517          	auipc	a0,0x3
    800083e4:	2a050513          	addi	a0,a0,672 # 8000b680 <etext+0x680>
    800083e8:	ffff9097          	auipc	ra,0xffff9
    800083ec:	86a080e7          	jalr	-1942(ra) # 80000c52 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    800083f0:	fe043783          	ld	a5,-32(s0)
    800083f4:	43d8                	lw	a4,4(a5)
    800083f6:	fd040793          	addi	a5,s0,-48
    800083fa:	863a                	mv	a2,a4
    800083fc:	85be                	mv	a1,a5
    800083fe:	fe843503          	ld	a0,-24(s0)
    80008402:	ffffe097          	auipc	ra,0xffffe
    80008406:	a0c080e7          	jalr	-1524(ra) # 80005e0e <dirlink>
    8000840a:	87aa                	mv	a5,a0
    8000840c:	0007da63          	bgez	a5,80008420 <create+0x1f4>
    panic("create: dirlink");
    80008410:	00003517          	auipc	a0,0x3
    80008414:	28050513          	addi	a0,a0,640 # 8000b690 <etext+0x690>
    80008418:	ffff9097          	auipc	ra,0xffff9
    8000841c:	83a080e7          	jalr	-1990(ra) # 80000c52 <panic>

  iunlockput(dp);
    80008420:	fe843503          	ld	a0,-24(s0)
    80008424:	ffffd097          	auipc	ra,0xffffd
    80008428:	25e080e7          	jalr	606(ra) # 80005682 <iunlockput>

  return ip;
    8000842c:	fe043783          	ld	a5,-32(s0)
}
    80008430:	853e                	mv	a0,a5
    80008432:	70e2                	ld	ra,56(sp)
    80008434:	7442                	ld	s0,48(sp)
    80008436:	6121                	addi	sp,sp,64
    80008438:	8082                	ret

000000008000843a <sys_open>:

uint64
sys_open(void)
{
    8000843a:	7131                	addi	sp,sp,-192
    8000843c:	fd06                	sd	ra,184(sp)
    8000843e:	f922                	sd	s0,176(sp)
    80008440:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80008442:	f5040793          	addi	a5,s0,-176
    80008446:	08000613          	li	a2,128
    8000844a:	85be                	mv	a1,a5
    8000844c:	4501                	li	a0,0
    8000844e:	ffffc097          	auipc	ra,0xffffc
    80008452:	054080e7          	jalr	84(ra) # 800044a2 <argstr>
    80008456:	87aa                	mv	a5,a0
    80008458:	fef42223          	sw	a5,-28(s0)
    8000845c:	fe442783          	lw	a5,-28(s0)
    80008460:	2781                	sext.w	a5,a5
    80008462:	0007cd63          	bltz	a5,8000847c <sys_open+0x42>
    80008466:	f4c40793          	addi	a5,s0,-180
    8000846a:	85be                	mv	a1,a5
    8000846c:	4505                	li	a0,1
    8000846e:	ffffc097          	auipc	ra,0xffffc
    80008472:	fc8080e7          	jalr	-56(ra) # 80004436 <argint>
    80008476:	87aa                	mv	a5,a0
    80008478:	0007d463          	bgez	a5,80008480 <sys_open+0x46>
    return -1;
    8000847c:	57fd                	li	a5,-1
    8000847e:	a429                	j	80008688 <sys_open+0x24e>

  begin_op();
    80008480:	ffffe097          	auipc	ra,0xffffe
    80008484:	010080e7          	jalr	16(ra) # 80006490 <begin_op>

  if(omode & O_CREATE){
    80008488:	f4c42783          	lw	a5,-180(s0)
    8000848c:	2007f793          	andi	a5,a5,512
    80008490:	2781                	sext.w	a5,a5
    80008492:	c795                	beqz	a5,800084be <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008494:	f5040793          	addi	a5,s0,-176
    80008498:	4681                	li	a3,0
    8000849a:	4601                	li	a2,0
    8000849c:	4589                	li	a1,2
    8000849e:	853e                	mv	a0,a5
    800084a0:	00000097          	auipc	ra,0x0
    800084a4:	d8c080e7          	jalr	-628(ra) # 8000822c <create>
    800084a8:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    800084ac:	fe843783          	ld	a5,-24(s0)
    800084b0:	e7bd                	bnez	a5,8000851e <sys_open+0xe4>
      end_op();
    800084b2:	ffffe097          	auipc	ra,0xffffe
    800084b6:	0a0080e7          	jalr	160(ra) # 80006552 <end_op>
      return -1;
    800084ba:	57fd                	li	a5,-1
    800084bc:	a2f1                	j	80008688 <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    800084be:	f5040793          	addi	a5,s0,-176
    800084c2:	853e                	mv	a0,a5
    800084c4:	ffffe097          	auipc	ra,0xffffe
    800084c8:	c68080e7          	jalr	-920(ra) # 8000612c <namei>
    800084cc:	fea43423          	sd	a0,-24(s0)
    800084d0:	fe843783          	ld	a5,-24(s0)
    800084d4:	e799                	bnez	a5,800084e2 <sys_open+0xa8>
      end_op();
    800084d6:	ffffe097          	auipc	ra,0xffffe
    800084da:	07c080e7          	jalr	124(ra) # 80006552 <end_op>
      return -1;
    800084de:	57fd                	li	a5,-1
    800084e0:	a265                	j	80008688 <sys_open+0x24e>
    }
    ilock(ip);
    800084e2:	fe843503          	ld	a0,-24(s0)
    800084e6:	ffffd097          	auipc	ra,0xffffd
    800084ea:	f3e080e7          	jalr	-194(ra) # 80005424 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800084ee:	fe843783          	ld	a5,-24(s0)
    800084f2:	04479783          	lh	a5,68(a5)
    800084f6:	0007871b          	sext.w	a4,a5
    800084fa:	4785                	li	a5,1
    800084fc:	02f71163          	bne	a4,a5,8000851e <sys_open+0xe4>
    80008500:	f4c42783          	lw	a5,-180(s0)
    80008504:	cf89                	beqz	a5,8000851e <sys_open+0xe4>
      iunlockput(ip);
    80008506:	fe843503          	ld	a0,-24(s0)
    8000850a:	ffffd097          	auipc	ra,0xffffd
    8000850e:	178080e7          	jalr	376(ra) # 80005682 <iunlockput>
      end_op();
    80008512:	ffffe097          	auipc	ra,0xffffe
    80008516:	040080e7          	jalr	64(ra) # 80006552 <end_op>
      return -1;
    8000851a:	57fd                	li	a5,-1
    8000851c:	a2b5                	j	80008688 <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000851e:	fe843783          	ld	a5,-24(s0)
    80008522:	04479783          	lh	a5,68(a5)
    80008526:	0007871b          	sext.w	a4,a5
    8000852a:	478d                	li	a5,3
    8000852c:	02f71e63          	bne	a4,a5,80008568 <sys_open+0x12e>
    80008530:	fe843783          	ld	a5,-24(s0)
    80008534:	04679783          	lh	a5,70(a5)
    80008538:	2781                	sext.w	a5,a5
    8000853a:	0007cb63          	bltz	a5,80008550 <sys_open+0x116>
    8000853e:	fe843783          	ld	a5,-24(s0)
    80008542:	04679783          	lh	a5,70(a5)
    80008546:	0007871b          	sext.w	a4,a5
    8000854a:	47a5                	li	a5,9
    8000854c:	00e7de63          	bge	a5,a4,80008568 <sys_open+0x12e>
    iunlockput(ip);
    80008550:	fe843503          	ld	a0,-24(s0)
    80008554:	ffffd097          	auipc	ra,0xffffd
    80008558:	12e080e7          	jalr	302(ra) # 80005682 <iunlockput>
    end_op();
    8000855c:	ffffe097          	auipc	ra,0xffffe
    80008560:	ff6080e7          	jalr	-10(ra) # 80006552 <end_op>
    return -1;
    80008564:	57fd                	li	a5,-1
    80008566:	a20d                	j	80008688 <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80008568:	ffffe097          	auipc	ra,0xffffe
    8000856c:	4d8080e7          	jalr	1240(ra) # 80006a40 <filealloc>
    80008570:	fca43c23          	sd	a0,-40(s0)
    80008574:	fd843783          	ld	a5,-40(s0)
    80008578:	cf99                	beqz	a5,80008596 <sys_open+0x15c>
    8000857a:	fd843503          	ld	a0,-40(s0)
    8000857e:	fffff097          	auipc	ra,0xfffff
    80008582:	5e2080e7          	jalr	1506(ra) # 80007b60 <fdalloc>
    80008586:	87aa                	mv	a5,a0
    80008588:	fcf42a23          	sw	a5,-44(s0)
    8000858c:	fd442783          	lw	a5,-44(s0)
    80008590:	2781                	sext.w	a5,a5
    80008592:	0207d763          	bgez	a5,800085c0 <sys_open+0x186>
    if(f)
    80008596:	fd843783          	ld	a5,-40(s0)
    8000859a:	c799                	beqz	a5,800085a8 <sys_open+0x16e>
      fileclose(f);
    8000859c:	fd843503          	ld	a0,-40(s0)
    800085a0:	ffffe097          	auipc	ra,0xffffe
    800085a4:	58a080e7          	jalr	1418(ra) # 80006b2a <fileclose>
    iunlockput(ip);
    800085a8:	fe843503          	ld	a0,-24(s0)
    800085ac:	ffffd097          	auipc	ra,0xffffd
    800085b0:	0d6080e7          	jalr	214(ra) # 80005682 <iunlockput>
    end_op();
    800085b4:	ffffe097          	auipc	ra,0xffffe
    800085b8:	f9e080e7          	jalr	-98(ra) # 80006552 <end_op>
    return -1;
    800085bc:	57fd                	li	a5,-1
    800085be:	a0e9                	j	80008688 <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    800085c0:	fe843783          	ld	a5,-24(s0)
    800085c4:	04479783          	lh	a5,68(a5)
    800085c8:	0007871b          	sext.w	a4,a5
    800085cc:	478d                	li	a5,3
    800085ce:	00f71f63          	bne	a4,a5,800085ec <sys_open+0x1b2>
    f->type = FD_DEVICE;
    800085d2:	fd843783          	ld	a5,-40(s0)
    800085d6:	470d                	li	a4,3
    800085d8:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    800085da:	fe843783          	ld	a5,-24(s0)
    800085de:	04679703          	lh	a4,70(a5)
    800085e2:	fd843783          	ld	a5,-40(s0)
    800085e6:	02e79223          	sh	a4,36(a5)
    800085ea:	a809                	j	800085fc <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    800085ec:	fd843783          	ld	a5,-40(s0)
    800085f0:	4709                	li	a4,2
    800085f2:	c398                	sw	a4,0(a5)
    f->off = 0;
    800085f4:	fd843783          	ld	a5,-40(s0)
    800085f8:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    800085fc:	fd843783          	ld	a5,-40(s0)
    80008600:	fe843703          	ld	a4,-24(s0)
    80008604:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008606:	f4c42783          	lw	a5,-180(s0)
    8000860a:	8b85                	andi	a5,a5,1
    8000860c:	2781                	sext.w	a5,a5
    8000860e:	0017b793          	seqz	a5,a5
    80008612:	0ff7f793          	andi	a5,a5,255
    80008616:	873e                	mv	a4,a5
    80008618:	fd843783          	ld	a5,-40(s0)
    8000861c:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80008620:	f4c42783          	lw	a5,-180(s0)
    80008624:	8b85                	andi	a5,a5,1
    80008626:	2781                	sext.w	a5,a5
    80008628:	e791                	bnez	a5,80008634 <sys_open+0x1fa>
    8000862a:	f4c42783          	lw	a5,-180(s0)
    8000862e:	8b89                	andi	a5,a5,2
    80008630:	2781                	sext.w	a5,a5
    80008632:	c399                	beqz	a5,80008638 <sys_open+0x1fe>
    80008634:	4785                	li	a5,1
    80008636:	a011                	j	8000863a <sys_open+0x200>
    80008638:	4781                	li	a5,0
    8000863a:	0ff7f713          	andi	a4,a5,255
    8000863e:	fd843783          	ld	a5,-40(s0)
    80008642:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80008646:	f4c42783          	lw	a5,-180(s0)
    8000864a:	4007f793          	andi	a5,a5,1024
    8000864e:	2781                	sext.w	a5,a5
    80008650:	c385                	beqz	a5,80008670 <sys_open+0x236>
    80008652:	fe843783          	ld	a5,-24(s0)
    80008656:	04479783          	lh	a5,68(a5)
    8000865a:	0007871b          	sext.w	a4,a5
    8000865e:	4789                	li	a5,2
    80008660:	00f71863          	bne	a4,a5,80008670 <sys_open+0x236>
    itrunc(ip);
    80008664:	fe843503          	ld	a0,-24(s0)
    80008668:	ffffd097          	auipc	ra,0xffffd
    8000866c:	1a4080e7          	jalr	420(ra) # 8000580c <itrunc>
  }

  iunlock(ip);
    80008670:	fe843503          	ld	a0,-24(s0)
    80008674:	ffffd097          	auipc	ra,0xffffd
    80008678:	ee4080e7          	jalr	-284(ra) # 80005558 <iunlock>
  end_op();
    8000867c:	ffffe097          	auipc	ra,0xffffe
    80008680:	ed6080e7          	jalr	-298(ra) # 80006552 <end_op>

  return fd;
    80008684:	fd442783          	lw	a5,-44(s0)
}
    80008688:	853e                	mv	a0,a5
    8000868a:	70ea                	ld	ra,184(sp)
    8000868c:	744a                	ld	s0,176(sp)
    8000868e:	6129                	addi	sp,sp,192
    80008690:	8082                	ret

0000000080008692 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008692:	7135                	addi	sp,sp,-160
    80008694:	ed06                	sd	ra,152(sp)
    80008696:	e922                	sd	s0,144(sp)
    80008698:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000869a:	ffffe097          	auipc	ra,0xffffe
    8000869e:	df6080e7          	jalr	-522(ra) # 80006490 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800086a2:	f6840793          	addi	a5,s0,-152
    800086a6:	08000613          	li	a2,128
    800086aa:	85be                	mv	a1,a5
    800086ac:	4501                	li	a0,0
    800086ae:	ffffc097          	auipc	ra,0xffffc
    800086b2:	df4080e7          	jalr	-524(ra) # 800044a2 <argstr>
    800086b6:	87aa                	mv	a5,a0
    800086b8:	0207c163          	bltz	a5,800086da <sys_mkdir+0x48>
    800086bc:	f6840793          	addi	a5,s0,-152
    800086c0:	4681                	li	a3,0
    800086c2:	4601                	li	a2,0
    800086c4:	4585                	li	a1,1
    800086c6:	853e                	mv	a0,a5
    800086c8:	00000097          	auipc	ra,0x0
    800086cc:	b64080e7          	jalr	-1180(ra) # 8000822c <create>
    800086d0:	fea43423          	sd	a0,-24(s0)
    800086d4:	fe843783          	ld	a5,-24(s0)
    800086d8:	e799                	bnez	a5,800086e6 <sys_mkdir+0x54>
    end_op();
    800086da:	ffffe097          	auipc	ra,0xffffe
    800086de:	e78080e7          	jalr	-392(ra) # 80006552 <end_op>
    return -1;
    800086e2:	57fd                	li	a5,-1
    800086e4:	a821                	j	800086fc <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    800086e6:	fe843503          	ld	a0,-24(s0)
    800086ea:	ffffd097          	auipc	ra,0xffffd
    800086ee:	f98080e7          	jalr	-104(ra) # 80005682 <iunlockput>
  end_op();
    800086f2:	ffffe097          	auipc	ra,0xffffe
    800086f6:	e60080e7          	jalr	-416(ra) # 80006552 <end_op>
  return 0;
    800086fa:	4781                	li	a5,0
}
    800086fc:	853e                	mv	a0,a5
    800086fe:	60ea                	ld	ra,152(sp)
    80008700:	644a                	ld	s0,144(sp)
    80008702:	610d                	addi	sp,sp,160
    80008704:	8082                	ret

0000000080008706 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008706:	7135                	addi	sp,sp,-160
    80008708:	ed06                	sd	ra,152(sp)
    8000870a:	e922                	sd	s0,144(sp)
    8000870c:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000870e:	ffffe097          	auipc	ra,0xffffe
    80008712:	d82080e7          	jalr	-638(ra) # 80006490 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008716:	f6840793          	addi	a5,s0,-152
    8000871a:	08000613          	li	a2,128
    8000871e:	85be                	mv	a1,a5
    80008720:	4501                	li	a0,0
    80008722:	ffffc097          	auipc	ra,0xffffc
    80008726:	d80080e7          	jalr	-640(ra) # 800044a2 <argstr>
    8000872a:	87aa                	mv	a5,a0
    8000872c:	0607c263          	bltz	a5,80008790 <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    80008730:	f6440793          	addi	a5,s0,-156
    80008734:	85be                	mv	a1,a5
    80008736:	4505                	li	a0,1
    80008738:	ffffc097          	auipc	ra,0xffffc
    8000873c:	cfe080e7          	jalr	-770(ra) # 80004436 <argint>
    80008740:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008742:	0407c763          	bltz	a5,80008790 <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    80008746:	f6040793          	addi	a5,s0,-160
    8000874a:	85be                	mv	a1,a5
    8000874c:	4509                	li	a0,2
    8000874e:	ffffc097          	auipc	ra,0xffffc
    80008752:	ce8080e7          	jalr	-792(ra) # 80004436 <argint>
    80008756:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    80008758:	0207cc63          	bltz	a5,80008790 <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000875c:	f6442783          	lw	a5,-156(s0)
    80008760:	0107971b          	slliw	a4,a5,0x10
    80008764:	4107571b          	sraiw	a4,a4,0x10
    80008768:	f6042783          	lw	a5,-160(s0)
    8000876c:	0107969b          	slliw	a3,a5,0x10
    80008770:	4106d69b          	sraiw	a3,a3,0x10
    80008774:	f6840793          	addi	a5,s0,-152
    80008778:	863a                	mv	a2,a4
    8000877a:	458d                	li	a1,3
    8000877c:	853e                	mv	a0,a5
    8000877e:	00000097          	auipc	ra,0x0
    80008782:	aae080e7          	jalr	-1362(ra) # 8000822c <create>
    80008786:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    8000878a:	fe843783          	ld	a5,-24(s0)
    8000878e:	e799                	bnez	a5,8000879c <sys_mknod+0x96>
    end_op();
    80008790:	ffffe097          	auipc	ra,0xffffe
    80008794:	dc2080e7          	jalr	-574(ra) # 80006552 <end_op>
    return -1;
    80008798:	57fd                	li	a5,-1
    8000879a:	a821                	j	800087b2 <sys_mknod+0xac>
  }
  iunlockput(ip);
    8000879c:	fe843503          	ld	a0,-24(s0)
    800087a0:	ffffd097          	auipc	ra,0xffffd
    800087a4:	ee2080e7          	jalr	-286(ra) # 80005682 <iunlockput>
  end_op();
    800087a8:	ffffe097          	auipc	ra,0xffffe
    800087ac:	daa080e7          	jalr	-598(ra) # 80006552 <end_op>
  return 0;
    800087b0:	4781                	li	a5,0
}
    800087b2:	853e                	mv	a0,a5
    800087b4:	60ea                	ld	ra,152(sp)
    800087b6:	644a                	ld	s0,144(sp)
    800087b8:	610d                	addi	sp,sp,160
    800087ba:	8082                	ret

00000000800087bc <sys_chdir>:

uint64
sys_chdir(void)
{
    800087bc:	7135                	addi	sp,sp,-160
    800087be:	ed06                	sd	ra,152(sp)
    800087c0:	e922                	sd	s0,144(sp)
    800087c2:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800087c4:	ffffa097          	auipc	ra,0xffffa
    800087c8:	034080e7          	jalr	52(ra) # 800027f8 <myproc>
    800087cc:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    800087d0:	ffffe097          	auipc	ra,0xffffe
    800087d4:	cc0080e7          	jalr	-832(ra) # 80006490 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800087d8:	f6040793          	addi	a5,s0,-160
    800087dc:	08000613          	li	a2,128
    800087e0:	85be                	mv	a1,a5
    800087e2:	4501                	li	a0,0
    800087e4:	ffffc097          	auipc	ra,0xffffc
    800087e8:	cbe080e7          	jalr	-834(ra) # 800044a2 <argstr>
    800087ec:	87aa                	mv	a5,a0
    800087ee:	0007ce63          	bltz	a5,8000880a <sys_chdir+0x4e>
    800087f2:	f6040793          	addi	a5,s0,-160
    800087f6:	853e                	mv	a0,a5
    800087f8:	ffffe097          	auipc	ra,0xffffe
    800087fc:	934080e7          	jalr	-1740(ra) # 8000612c <namei>
    80008800:	fea43023          	sd	a0,-32(s0)
    80008804:	fe043783          	ld	a5,-32(s0)
    80008808:	e799                	bnez	a5,80008816 <sys_chdir+0x5a>
    end_op();
    8000880a:	ffffe097          	auipc	ra,0xffffe
    8000880e:	d48080e7          	jalr	-696(ra) # 80006552 <end_op>
    return -1;
    80008812:	57fd                	li	a5,-1
    80008814:	a895                	j	80008888 <sys_chdir+0xcc>
  }
  ilock(ip);
    80008816:	fe043503          	ld	a0,-32(s0)
    8000881a:	ffffd097          	auipc	ra,0xffffd
    8000881e:	c0a080e7          	jalr	-1014(ra) # 80005424 <ilock>
  if(ip->type != T_DIR){
    80008822:	fe043783          	ld	a5,-32(s0)
    80008826:	04479783          	lh	a5,68(a5)
    8000882a:	0007871b          	sext.w	a4,a5
    8000882e:	4785                	li	a5,1
    80008830:	00f70e63          	beq	a4,a5,8000884c <sys_chdir+0x90>
    iunlockput(ip);
    80008834:	fe043503          	ld	a0,-32(s0)
    80008838:	ffffd097          	auipc	ra,0xffffd
    8000883c:	e4a080e7          	jalr	-438(ra) # 80005682 <iunlockput>
    end_op();
    80008840:	ffffe097          	auipc	ra,0xffffe
    80008844:	d12080e7          	jalr	-750(ra) # 80006552 <end_op>
    return -1;
    80008848:	57fd                	li	a5,-1
    8000884a:	a83d                	j	80008888 <sys_chdir+0xcc>
  }
  iunlock(ip);
    8000884c:	fe043503          	ld	a0,-32(s0)
    80008850:	ffffd097          	auipc	ra,0xffffd
    80008854:	d08080e7          	jalr	-760(ra) # 80005558 <iunlock>
  iput(p->cwd);
    80008858:	fe843703          	ld	a4,-24(s0)
    8000885c:	6785                	lui	a5,0x1
    8000885e:	97ba                	add	a5,a5,a4
    80008860:	3b87b783          	ld	a5,952(a5) # 13b8 <_entry-0x7fffec48>
    80008864:	853e                	mv	a0,a5
    80008866:	ffffd097          	auipc	ra,0xffffd
    8000886a:	d4c080e7          	jalr	-692(ra) # 800055b2 <iput>
  end_op();
    8000886e:	ffffe097          	auipc	ra,0xffffe
    80008872:	ce4080e7          	jalr	-796(ra) # 80006552 <end_op>
  p->cwd = ip;
    80008876:	fe843703          	ld	a4,-24(s0)
    8000887a:	6785                	lui	a5,0x1
    8000887c:	97ba                	add	a5,a5,a4
    8000887e:	fe043703          	ld	a4,-32(s0)
    80008882:	3ae7bc23          	sd	a4,952(a5) # 13b8 <_entry-0x7fffec48>
  return 0;
    80008886:	4781                	li	a5,0
}
    80008888:	853e                	mv	a0,a5
    8000888a:	60ea                	ld	ra,152(sp)
    8000888c:	644a                	ld	s0,144(sp)
    8000888e:	610d                	addi	sp,sp,160
    80008890:	8082                	ret

0000000080008892 <sys_exec>:

uint64
sys_exec(void)
{
    80008892:	7161                	addi	sp,sp,-432
    80008894:	f706                	sd	ra,424(sp)
    80008896:	f322                	sd	s0,416(sp)
    80008898:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000889a:	f6840793          	addi	a5,s0,-152
    8000889e:	08000613          	li	a2,128
    800088a2:	85be                	mv	a1,a5
    800088a4:	4501                	li	a0,0
    800088a6:	ffffc097          	auipc	ra,0xffffc
    800088aa:	bfc080e7          	jalr	-1028(ra) # 800044a2 <argstr>
    800088ae:	87aa                	mv	a5,a0
    800088b0:	0007cd63          	bltz	a5,800088ca <sys_exec+0x38>
    800088b4:	e6040793          	addi	a5,s0,-416
    800088b8:	85be                	mv	a1,a5
    800088ba:	4505                	li	a0,1
    800088bc:	ffffc097          	auipc	ra,0xffffc
    800088c0:	bb2080e7          	jalr	-1102(ra) # 8000446e <argaddr>
    800088c4:	87aa                	mv	a5,a0
    800088c6:	0007d463          	bgez	a5,800088ce <sys_exec+0x3c>
    return -1;
    800088ca:	57fd                	li	a5,-1
    800088cc:	a249                	j	80008a4e <sys_exec+0x1bc>
  }
  memset(argv, 0, sizeof(argv));
    800088ce:	e6840793          	addi	a5,s0,-408
    800088d2:	10000613          	li	a2,256
    800088d6:	4581                	li	a1,0
    800088d8:	853e                	mv	a0,a5
    800088da:	ffff9097          	auipc	ra,0xffff9
    800088de:	b7a080e7          	jalr	-1158(ra) # 80001454 <memset>
  for(i=0;; i++){
    800088e2:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    800088e6:	fec42783          	lw	a5,-20(s0)
    800088ea:	873e                	mv	a4,a5
    800088ec:	47fd                	li	a5,31
    800088ee:	10e7e463          	bltu	a5,a4,800089f6 <sys_exec+0x164>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800088f2:	fec42783          	lw	a5,-20(s0)
    800088f6:	00379713          	slli	a4,a5,0x3
    800088fa:	e6043783          	ld	a5,-416(s0)
    800088fe:	97ba                	add	a5,a5,a4
    80008900:	e5840713          	addi	a4,s0,-424
    80008904:	85ba                	mv	a1,a4
    80008906:	853e                	mv	a0,a5
    80008908:	ffffc097          	auipc	ra,0xffffc
    8000890c:	974080e7          	jalr	-1676(ra) # 8000427c <fetchaddr>
    80008910:	87aa                	mv	a5,a0
    80008912:	0e07c463          	bltz	a5,800089fa <sys_exec+0x168>
      goto bad;
    }
    if(uarg == 0){
    80008916:	e5843783          	ld	a5,-424(s0)
    8000891a:	eb95                	bnez	a5,8000894e <sys_exec+0xbc>
      argv[i] = 0;
    8000891c:	fec42783          	lw	a5,-20(s0)
    80008920:	078e                	slli	a5,a5,0x3
    80008922:	ff040713          	addi	a4,s0,-16
    80008926:	97ba                	add	a5,a5,a4
    80008928:	e607bc23          	sd	zero,-392(a5)
      break;
    8000892c:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    8000892e:	e6840713          	addi	a4,s0,-408
    80008932:	f6840793          	addi	a5,s0,-152
    80008936:	85ba                	mv	a1,a4
    80008938:	853e                	mv	a0,a5
    8000893a:	fffff097          	auipc	ra,0xfffff
    8000893e:	bc0080e7          	jalr	-1088(ra) # 800074fa <exec>
    80008942:	87aa                	mv	a5,a0
    80008944:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008948:	fe042623          	sw	zero,-20(s0)
    8000894c:	a059                	j	800089d2 <sys_exec+0x140>
    argv[i] = kalloc();
    8000894e:	ffff8097          	auipc	ra,0xffff8
    80008952:	7de080e7          	jalr	2014(ra) # 8000112c <kalloc>
    80008956:	872a                	mv	a4,a0
    80008958:	fec42783          	lw	a5,-20(s0)
    8000895c:	078e                	slli	a5,a5,0x3
    8000895e:	ff040693          	addi	a3,s0,-16
    80008962:	97b6                	add	a5,a5,a3
    80008964:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    80008968:	fec42783          	lw	a5,-20(s0)
    8000896c:	078e                	slli	a5,a5,0x3
    8000896e:	ff040713          	addi	a4,s0,-16
    80008972:	97ba                	add	a5,a5,a4
    80008974:	e787b783          	ld	a5,-392(a5)
    80008978:	c3d9                	beqz	a5,800089fe <sys_exec+0x16c>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000897a:	e5843703          	ld	a4,-424(s0)
    8000897e:	fec42783          	lw	a5,-20(s0)
    80008982:	078e                	slli	a5,a5,0x3
    80008984:	ff040693          	addi	a3,s0,-16
    80008988:	97b6                	add	a5,a5,a3
    8000898a:	e787b783          	ld	a5,-392(a5)
    8000898e:	6605                	lui	a2,0x1
    80008990:	85be                	mv	a1,a5
    80008992:	853a                	mv	a0,a4
    80008994:	ffffc097          	auipc	ra,0xffffc
    80008998:	968080e7          	jalr	-1688(ra) # 800042fc <fetchstr>
    8000899c:	87aa                	mv	a5,a0
    8000899e:	0607c263          	bltz	a5,80008a02 <sys_exec+0x170>
  for(i=0;; i++){
    800089a2:	fec42783          	lw	a5,-20(s0)
    800089a6:	2785                	addiw	a5,a5,1
    800089a8:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    800089ac:	bf2d                	j	800088e6 <sys_exec+0x54>
    kfree(argv[i]);
    800089ae:	fec42783          	lw	a5,-20(s0)
    800089b2:	078e                	slli	a5,a5,0x3
    800089b4:	ff040713          	addi	a4,s0,-16
    800089b8:	97ba                	add	a5,a5,a4
    800089ba:	e787b783          	ld	a5,-392(a5)
    800089be:	853e                	mv	a0,a5
    800089c0:	ffff8097          	auipc	ra,0xffff8
    800089c4:	6c8080e7          	jalr	1736(ra) # 80001088 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800089c8:	fec42783          	lw	a5,-20(s0)
    800089cc:	2785                	addiw	a5,a5,1
    800089ce:	fef42623          	sw	a5,-20(s0)
    800089d2:	fec42783          	lw	a5,-20(s0)
    800089d6:	873e                	mv	a4,a5
    800089d8:	47fd                	li	a5,31
    800089da:	00e7eb63          	bltu	a5,a4,800089f0 <sys_exec+0x15e>
    800089de:	fec42783          	lw	a5,-20(s0)
    800089e2:	078e                	slli	a5,a5,0x3
    800089e4:	ff040713          	addi	a4,s0,-16
    800089e8:	97ba                	add	a5,a5,a4
    800089ea:	e787b783          	ld	a5,-392(a5)
    800089ee:	f3e1                	bnez	a5,800089ae <sys_exec+0x11c>

  return ret;
    800089f0:	fe842783          	lw	a5,-24(s0)
    800089f4:	a8a9                	j	80008a4e <sys_exec+0x1bc>
      goto bad;
    800089f6:	0001                	nop
    800089f8:	a031                	j	80008a04 <sys_exec+0x172>
      goto bad;
    800089fa:	0001                	nop
    800089fc:	a021                	j	80008a04 <sys_exec+0x172>
      goto bad;
    800089fe:	0001                	nop
    80008a00:	a011                	j	80008a04 <sys_exec+0x172>
      goto bad;
    80008a02:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008a04:	fe042623          	sw	zero,-20(s0)
    80008a08:	a01d                	j	80008a2e <sys_exec+0x19c>
    kfree(argv[i]);
    80008a0a:	fec42783          	lw	a5,-20(s0)
    80008a0e:	078e                	slli	a5,a5,0x3
    80008a10:	ff040713          	addi	a4,s0,-16
    80008a14:	97ba                	add	a5,a5,a4
    80008a16:	e787b783          	ld	a5,-392(a5)
    80008a1a:	853e                	mv	a0,a5
    80008a1c:	ffff8097          	auipc	ra,0xffff8
    80008a20:	66c080e7          	jalr	1644(ra) # 80001088 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008a24:	fec42783          	lw	a5,-20(s0)
    80008a28:	2785                	addiw	a5,a5,1
    80008a2a:	fef42623          	sw	a5,-20(s0)
    80008a2e:	fec42783          	lw	a5,-20(s0)
    80008a32:	873e                	mv	a4,a5
    80008a34:	47fd                	li	a5,31
    80008a36:	00e7eb63          	bltu	a5,a4,80008a4c <sys_exec+0x1ba>
    80008a3a:	fec42783          	lw	a5,-20(s0)
    80008a3e:	078e                	slli	a5,a5,0x3
    80008a40:	ff040713          	addi	a4,s0,-16
    80008a44:	97ba                	add	a5,a5,a4
    80008a46:	e787b783          	ld	a5,-392(a5)
    80008a4a:	f3e1                	bnez	a5,80008a0a <sys_exec+0x178>
  return -1;
    80008a4c:	57fd                	li	a5,-1
}
    80008a4e:	853e                	mv	a0,a5
    80008a50:	70ba                	ld	ra,424(sp)
    80008a52:	741a                	ld	s0,416(sp)
    80008a54:	615d                	addi	sp,sp,432
    80008a56:	8082                	ret

0000000080008a58 <sys_pipe>:

uint64
sys_pipe(void)
{
    80008a58:	7139                	addi	sp,sp,-64
    80008a5a:	fc06                	sd	ra,56(sp)
    80008a5c:	f822                	sd	s0,48(sp)
    80008a5e:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80008a60:	ffffa097          	auipc	ra,0xffffa
    80008a64:	d98080e7          	jalr	-616(ra) # 800027f8 <myproc>
    80008a68:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    80008a6c:	fe040793          	addi	a5,s0,-32
    80008a70:	85be                	mv	a1,a5
    80008a72:	4501                	li	a0,0
    80008a74:	ffffc097          	auipc	ra,0xffffc
    80008a78:	9fa080e7          	jalr	-1542(ra) # 8000446e <argaddr>
    80008a7c:	87aa                	mv	a5,a0
    80008a7e:	0007d463          	bgez	a5,80008a86 <sys_pipe+0x2e>
    return -1;
    80008a82:	57fd                	li	a5,-1
    80008a84:	aa1d                	j	80008bba <sys_pipe+0x162>
  if(pipealloc(&rf, &wf) < 0)
    80008a86:	fd040713          	addi	a4,s0,-48
    80008a8a:	fd840793          	addi	a5,s0,-40
    80008a8e:	85ba                	mv	a1,a4
    80008a90:	853e                	mv	a0,a5
    80008a92:	ffffe097          	auipc	ra,0xffffe
    80008a96:	5ce080e7          	jalr	1486(ra) # 80007060 <pipealloc>
    80008a9a:	87aa                	mv	a5,a0
    80008a9c:	0007d463          	bgez	a5,80008aa4 <sys_pipe+0x4c>
    return -1;
    80008aa0:	57fd                	li	a5,-1
    80008aa2:	aa21                	j	80008bba <sys_pipe+0x162>
  fd0 = -1;
    80008aa4:	57fd                	li	a5,-1
    80008aa6:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80008aaa:	fd843783          	ld	a5,-40(s0)
    80008aae:	853e                	mv	a0,a5
    80008ab0:	fffff097          	auipc	ra,0xfffff
    80008ab4:	0b0080e7          	jalr	176(ra) # 80007b60 <fdalloc>
    80008ab8:	87aa                	mv	a5,a0
    80008aba:	fcf42623          	sw	a5,-52(s0)
    80008abe:	fcc42783          	lw	a5,-52(s0)
    80008ac2:	0207c063          	bltz	a5,80008ae2 <sys_pipe+0x8a>
    80008ac6:	fd043783          	ld	a5,-48(s0)
    80008aca:	853e                	mv	a0,a5
    80008acc:	fffff097          	auipc	ra,0xfffff
    80008ad0:	094080e7          	jalr	148(ra) # 80007b60 <fdalloc>
    80008ad4:	87aa                	mv	a5,a0
    80008ad6:	fcf42423          	sw	a5,-56(s0)
    80008ada:	fc842783          	lw	a5,-56(s0)
    80008ade:	0407d063          	bgez	a5,80008b1e <sys_pipe+0xc6>
    if(fd0 >= 0)
    80008ae2:	fcc42783          	lw	a5,-52(s0)
    80008ae6:	0007cc63          	bltz	a5,80008afe <sys_pipe+0xa6>
      p->ofile[fd0] = 0;
    80008aea:	fcc42783          	lw	a5,-52(s0)
    80008aee:	fe843703          	ld	a4,-24(s0)
    80008af2:	26678793          	addi	a5,a5,614
    80008af6:	078e                	slli	a5,a5,0x3
    80008af8:	97ba                	add	a5,a5,a4
    80008afa:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80008afe:	fd843783          	ld	a5,-40(s0)
    80008b02:	853e                	mv	a0,a5
    80008b04:	ffffe097          	auipc	ra,0xffffe
    80008b08:	026080e7          	jalr	38(ra) # 80006b2a <fileclose>
    fileclose(wf);
    80008b0c:	fd043783          	ld	a5,-48(s0)
    80008b10:	853e                	mv	a0,a5
    80008b12:	ffffe097          	auipc	ra,0xffffe
    80008b16:	018080e7          	jalr	24(ra) # 80006b2a <fileclose>
    return -1;
    80008b1a:	57fd                	li	a5,-1
    80008b1c:	a879                	j	80008bba <sys_pipe+0x162>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008b1e:	fe843703          	ld	a4,-24(s0)
    80008b22:	6785                	lui	a5,0x1
    80008b24:	97ba                	add	a5,a5,a4
    80008b26:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80008b2a:	fe043703          	ld	a4,-32(s0)
    80008b2e:	fcc40613          	addi	a2,s0,-52
    80008b32:	4691                	li	a3,4
    80008b34:	85ba                	mv	a1,a4
    80008b36:	853e                	mv	a0,a5
    80008b38:	ffff9097          	auipc	ra,0xffff9
    80008b3c:	79c080e7          	jalr	1948(ra) # 800022d4 <copyout>
    80008b40:	87aa                	mv	a5,a0
    80008b42:	0207c763          	bltz	a5,80008b70 <sys_pipe+0x118>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008b46:	fe843703          	ld	a4,-24(s0)
    80008b4a:	6785                	lui	a5,0x1
    80008b4c:	97ba                	add	a5,a5,a4
    80008b4e:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    80008b52:	fe043783          	ld	a5,-32(s0)
    80008b56:	0791                	addi	a5,a5,4
    80008b58:	fc840613          	addi	a2,s0,-56
    80008b5c:	4691                	li	a3,4
    80008b5e:	85be                	mv	a1,a5
    80008b60:	853a                	mv	a0,a4
    80008b62:	ffff9097          	auipc	ra,0xffff9
    80008b66:	772080e7          	jalr	1906(ra) # 800022d4 <copyout>
    80008b6a:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008b6c:	0407d663          	bgez	a5,80008bb8 <sys_pipe+0x160>
    p->ofile[fd0] = 0;
    80008b70:	fcc42783          	lw	a5,-52(s0)
    80008b74:	fe843703          	ld	a4,-24(s0)
    80008b78:	26678793          	addi	a5,a5,614
    80008b7c:	078e                	slli	a5,a5,0x3
    80008b7e:	97ba                	add	a5,a5,a4
    80008b80:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80008b84:	fc842783          	lw	a5,-56(s0)
    80008b88:	fe843703          	ld	a4,-24(s0)
    80008b8c:	26678793          	addi	a5,a5,614
    80008b90:	078e                	slli	a5,a5,0x3
    80008b92:	97ba                	add	a5,a5,a4
    80008b94:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80008b98:	fd843783          	ld	a5,-40(s0)
    80008b9c:	853e                	mv	a0,a5
    80008b9e:	ffffe097          	auipc	ra,0xffffe
    80008ba2:	f8c080e7          	jalr	-116(ra) # 80006b2a <fileclose>
    fileclose(wf);
    80008ba6:	fd043783          	ld	a5,-48(s0)
    80008baa:	853e                	mv	a0,a5
    80008bac:	ffffe097          	auipc	ra,0xffffe
    80008bb0:	f7e080e7          	jalr	-130(ra) # 80006b2a <fileclose>
    return -1;
    80008bb4:	57fd                	li	a5,-1
    80008bb6:	a011                	j	80008bba <sys_pipe+0x162>
  }
  return 0;
    80008bb8:	4781                	li	a5,0
}
    80008bba:	853e                	mv	a0,a5
    80008bbc:	70e2                	ld	ra,56(sp)
    80008bbe:	7442                	ld	s0,48(sp)
    80008bc0:	6121                	addi	sp,sp,64
    80008bc2:	8082                	ret
	...

0000000080008bd0 <kernelvec>:
    80008bd0:	7111                	addi	sp,sp,-256
    80008bd2:	e006                	sd	ra,0(sp)
    80008bd4:	e40a                	sd	sp,8(sp)
    80008bd6:	e80e                	sd	gp,16(sp)
    80008bd8:	ec12                	sd	tp,24(sp)
    80008bda:	f016                	sd	t0,32(sp)
    80008bdc:	f41a                	sd	t1,40(sp)
    80008bde:	f81e                	sd	t2,48(sp)
    80008be0:	fc22                	sd	s0,56(sp)
    80008be2:	e0a6                	sd	s1,64(sp)
    80008be4:	e4aa                	sd	a0,72(sp)
    80008be6:	e8ae                	sd	a1,80(sp)
    80008be8:	ecb2                	sd	a2,88(sp)
    80008bea:	f0b6                	sd	a3,96(sp)
    80008bec:	f4ba                	sd	a4,104(sp)
    80008bee:	f8be                	sd	a5,112(sp)
    80008bf0:	fcc2                	sd	a6,120(sp)
    80008bf2:	e146                	sd	a7,128(sp)
    80008bf4:	e54a                	sd	s2,136(sp)
    80008bf6:	e94e                	sd	s3,144(sp)
    80008bf8:	ed52                	sd	s4,152(sp)
    80008bfa:	f156                	sd	s5,160(sp)
    80008bfc:	f55a                	sd	s6,168(sp)
    80008bfe:	f95e                	sd	s7,176(sp)
    80008c00:	fd62                	sd	s8,184(sp)
    80008c02:	e1e6                	sd	s9,192(sp)
    80008c04:	e5ea                	sd	s10,200(sp)
    80008c06:	e9ee                	sd	s11,208(sp)
    80008c08:	edf2                	sd	t3,216(sp)
    80008c0a:	f1f6                	sd	t4,224(sp)
    80008c0c:	f5fa                	sd	t5,232(sp)
    80008c0e:	f9fe                	sd	t6,240(sp)
    80008c10:	bb6fb0ef          	jal	ra,80003fc6 <kerneltrap>
    80008c14:	6082                	ld	ra,0(sp)
    80008c16:	6122                	ld	sp,8(sp)
    80008c18:	61c2                	ld	gp,16(sp)
    80008c1a:	7282                	ld	t0,32(sp)
    80008c1c:	7322                	ld	t1,40(sp)
    80008c1e:	73c2                	ld	t2,48(sp)
    80008c20:	7462                	ld	s0,56(sp)
    80008c22:	6486                	ld	s1,64(sp)
    80008c24:	6526                	ld	a0,72(sp)
    80008c26:	65c6                	ld	a1,80(sp)
    80008c28:	6666                	ld	a2,88(sp)
    80008c2a:	7686                	ld	a3,96(sp)
    80008c2c:	7726                	ld	a4,104(sp)
    80008c2e:	77c6                	ld	a5,112(sp)
    80008c30:	7866                	ld	a6,120(sp)
    80008c32:	688a                	ld	a7,128(sp)
    80008c34:	692a                	ld	s2,136(sp)
    80008c36:	69ca                	ld	s3,144(sp)
    80008c38:	6a6a                	ld	s4,152(sp)
    80008c3a:	7a8a                	ld	s5,160(sp)
    80008c3c:	7b2a                	ld	s6,168(sp)
    80008c3e:	7bca                	ld	s7,176(sp)
    80008c40:	7c6a                	ld	s8,184(sp)
    80008c42:	6c8e                	ld	s9,192(sp)
    80008c44:	6d2e                	ld	s10,200(sp)
    80008c46:	6dce                	ld	s11,208(sp)
    80008c48:	6e6e                	ld	t3,216(sp)
    80008c4a:	7e8e                	ld	t4,224(sp)
    80008c4c:	7f2e                	ld	t5,232(sp)
    80008c4e:	7fce                	ld	t6,240(sp)
    80008c50:	6111                	addi	sp,sp,256
    80008c52:	10200073          	sret
    80008c56:	00000013          	nop
    80008c5a:	00000013          	nop
    80008c5e:	0001                	nop

0000000080008c60 <timervec>:
    80008c60:	34051573          	csrrw	a0,mscratch,a0
    80008c64:	e10c                	sd	a1,0(a0)
    80008c66:	e510                	sd	a2,8(a0)
    80008c68:	e914                	sd	a3,16(a0)
    80008c6a:	6d0c                	ld	a1,24(a0)
    80008c6c:	7110                	ld	a2,32(a0)
    80008c6e:	6194                	ld	a3,0(a1)
    80008c70:	96b2                	add	a3,a3,a2
    80008c72:	e194                	sd	a3,0(a1)
    80008c74:	4589                	li	a1,2
    80008c76:	14459073          	csrw	sip,a1
    80008c7a:	6914                	ld	a3,16(a0)
    80008c7c:	6510                	ld	a2,8(a0)
    80008c7e:	610c                	ld	a1,0(a0)
    80008c80:	34051573          	csrrw	a0,mscratch,a0
    80008c84:	30200073          	mret
	...

0000000080008c8a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80008c8a:	1141                	addi	sp,sp,-16
    80008c8c:	e422                	sd	s0,8(sp)
    80008c8e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80008c90:	0c0007b7          	lui	a5,0xc000
    80008c94:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80008c98:	4705                	li	a4,1
    80008c9a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80008c9c:	0c0007b7          	lui	a5,0xc000
    80008ca0:	0791                	addi	a5,a5,4
    80008ca2:	4705                	li	a4,1
    80008ca4:	c398                	sw	a4,0(a5)
}
    80008ca6:	0001                	nop
    80008ca8:	6422                	ld	s0,8(sp)
    80008caa:	0141                	addi	sp,sp,16
    80008cac:	8082                	ret

0000000080008cae <plicinithart>:

void
plicinithart(void)
{
    80008cae:	1101                	addi	sp,sp,-32
    80008cb0:	ec06                	sd	ra,24(sp)
    80008cb2:	e822                	sd	s0,16(sp)
    80008cb4:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008cb6:	ffffa097          	auipc	ra,0xffffa
    80008cba:	ae4080e7          	jalr	-1308(ra) # 8000279a <cpuid>
    80008cbe:	87aa                	mv	a5,a0
    80008cc0:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80008cc4:	fec42783          	lw	a5,-20(s0)
    80008cc8:	0087979b          	slliw	a5,a5,0x8
    80008ccc:	2781                	sext.w	a5,a5
    80008cce:	873e                	mv	a4,a5
    80008cd0:	0c0027b7          	lui	a5,0xc002
    80008cd4:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80008cd8:	97ba                	add	a5,a5,a4
    80008cda:	873e                	mv	a4,a5
    80008cdc:	40200793          	li	a5,1026
    80008ce0:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80008ce2:	fec42783          	lw	a5,-20(s0)
    80008ce6:	00d7979b          	slliw	a5,a5,0xd
    80008cea:	2781                	sext.w	a5,a5
    80008cec:	873e                	mv	a4,a5
    80008cee:	0c2017b7          	lui	a5,0xc201
    80008cf2:	97ba                	add	a5,a5,a4
    80008cf4:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80008cf8:	0001                	nop
    80008cfa:	60e2                	ld	ra,24(sp)
    80008cfc:	6442                	ld	s0,16(sp)
    80008cfe:	6105                	addi	sp,sp,32
    80008d00:	8082                	ret

0000000080008d02 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80008d02:	1101                	addi	sp,sp,-32
    80008d04:	ec06                	sd	ra,24(sp)
    80008d06:	e822                	sd	s0,16(sp)
    80008d08:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008d0a:	ffffa097          	auipc	ra,0xffffa
    80008d0e:	a90080e7          	jalr	-1392(ra) # 8000279a <cpuid>
    80008d12:	87aa                	mv	a5,a0
    80008d14:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80008d18:	fec42783          	lw	a5,-20(s0)
    80008d1c:	00d7979b          	slliw	a5,a5,0xd
    80008d20:	2781                	sext.w	a5,a5
    80008d22:	873e                	mv	a4,a5
    80008d24:	0c2017b7          	lui	a5,0xc201
    80008d28:	0791                	addi	a5,a5,4
    80008d2a:	97ba                	add	a5,a5,a4
    80008d2c:	439c                	lw	a5,0(a5)
    80008d2e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80008d32:	fe842783          	lw	a5,-24(s0)
}
    80008d36:	853e                	mv	a0,a5
    80008d38:	60e2                	ld	ra,24(sp)
    80008d3a:	6442                	ld	s0,16(sp)
    80008d3c:	6105                	addi	sp,sp,32
    80008d3e:	8082                	ret

0000000080008d40 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80008d40:	7179                	addi	sp,sp,-48
    80008d42:	f406                	sd	ra,40(sp)
    80008d44:	f022                	sd	s0,32(sp)
    80008d46:	1800                	addi	s0,sp,48
    80008d48:	87aa                	mv	a5,a0
    80008d4a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    80008d4e:	ffffa097          	auipc	ra,0xffffa
    80008d52:	a4c080e7          	jalr	-1460(ra) # 8000279a <cpuid>
    80008d56:	87aa                	mv	a5,a0
    80008d58:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80008d5c:	fec42783          	lw	a5,-20(s0)
    80008d60:	00d7979b          	slliw	a5,a5,0xd
    80008d64:	2781                	sext.w	a5,a5
    80008d66:	873e                	mv	a4,a5
    80008d68:	0c2017b7          	lui	a5,0xc201
    80008d6c:	0791                	addi	a5,a5,4
    80008d6e:	97ba                	add	a5,a5,a4
    80008d70:	873e                	mv	a4,a5
    80008d72:	fdc42783          	lw	a5,-36(s0)
    80008d76:	c31c                	sw	a5,0(a4)
}
    80008d78:	0001                	nop
    80008d7a:	70a2                	ld	ra,40(sp)
    80008d7c:	7402                	ld	s0,32(sp)
    80008d7e:	6145                	addi	sp,sp,48
    80008d80:	8082                	ret

0000000080008d82 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    80008d82:	7179                	addi	sp,sp,-48
    80008d84:	f406                	sd	ra,40(sp)
    80008d86:	f022                	sd	s0,32(sp)
    80008d88:	1800                	addi	s0,sp,48
  uint32 status = 0;
    80008d8a:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    80008d8e:	00003597          	auipc	a1,0x3
    80008d92:	91258593          	addi	a1,a1,-1774 # 8000b6a0 <etext+0x6a0>
    80008d96:	00068517          	auipc	a0,0x68
    80008d9a:	39250513          	addi	a0,a0,914 # 80071128 <disk+0x2128>
    80008d9e:	ffff8097          	auipc	ra,0xffff8
    80008da2:	4b2080e7          	jalr	1202(ra) # 80001250 <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008da6:	100017b7          	lui	a5,0x10001
    80008daa:	439c                	lw	a5,0(a5)
    80008dac:	2781                	sext.w	a5,a5
    80008dae:	873e                	mv	a4,a5
    80008db0:	747277b7          	lui	a5,0x74727
    80008db4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80008db8:	04f71063          	bne	a4,a5,80008df8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80008dbc:	100017b7          	lui	a5,0x10001
    80008dc0:	0791                	addi	a5,a5,4
    80008dc2:	439c                	lw	a5,0(a5)
    80008dc4:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008dc6:	873e                	mv	a4,a5
    80008dc8:	4785                	li	a5,1
    80008dca:	02f71763          	bne	a4,a5,80008df8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008dce:	100017b7          	lui	a5,0x10001
    80008dd2:	07a1                	addi	a5,a5,8
    80008dd4:	439c                	lw	a5,0(a5)
    80008dd6:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80008dd8:	873e                	mv	a4,a5
    80008dda:	4789                	li	a5,2
    80008ddc:	00f71e63          	bne	a4,a5,80008df8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008de0:	100017b7          	lui	a5,0x10001
    80008de4:	07b1                	addi	a5,a5,12
    80008de6:	439c                	lw	a5,0(a5)
    80008de8:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008dea:	873e                	mv	a4,a5
    80008dec:	554d47b7          	lui	a5,0x554d4
    80008df0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80008df4:	00f70a63          	beq	a4,a5,80008e08 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80008df8:	00003517          	auipc	a0,0x3
    80008dfc:	8b850513          	addi	a0,a0,-1864 # 8000b6b0 <etext+0x6b0>
    80008e00:	ffff8097          	auipc	ra,0xffff8
    80008e04:	e52080e7          	jalr	-430(ra) # 80000c52 <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80008e08:	fe842783          	lw	a5,-24(s0)
    80008e0c:	0017e793          	ori	a5,a5,1
    80008e10:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008e14:	100017b7          	lui	a5,0x10001
    80008e18:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008e1c:	fe842703          	lw	a4,-24(s0)
    80008e20:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80008e22:	fe842783          	lw	a5,-24(s0)
    80008e26:	0027e793          	ori	a5,a5,2
    80008e2a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008e2e:	100017b7          	lui	a5,0x10001
    80008e32:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008e36:	fe842703          	lw	a4,-24(s0)
    80008e3a:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80008e3c:	100017b7          	lui	a5,0x10001
    80008e40:	07c1                	addi	a5,a5,16
    80008e42:	439c                	lw	a5,0(a5)
    80008e44:	2781                	sext.w	a5,a5
    80008e46:	1782                	slli	a5,a5,0x20
    80008e48:	9381                	srli	a5,a5,0x20
    80008e4a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    80008e4e:	fe043783          	ld	a5,-32(s0)
    80008e52:	fdf7f793          	andi	a5,a5,-33
    80008e56:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80008e5a:	fe043783          	ld	a5,-32(s0)
    80008e5e:	f7f7f793          	andi	a5,a5,-129
    80008e62:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80008e66:	fe043703          	ld	a4,-32(s0)
    80008e6a:	77fd                	lui	a5,0xfffff
    80008e6c:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ff8d7ff>
    80008e70:	8ff9                	and	a5,a5,a4
    80008e72:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80008e76:	fe043703          	ld	a4,-32(s0)
    80008e7a:	77fd                	lui	a5,0xfffff
    80008e7c:	17fd                	addi	a5,a5,-1
    80008e7e:	8ff9                	and	a5,a5,a4
    80008e80:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80008e84:	fe043703          	ld	a4,-32(s0)
    80008e88:	f80007b7          	lui	a5,0xf8000
    80008e8c:	17fd                	addi	a5,a5,-1
    80008e8e:	8ff9                	and	a5,a5,a4
    80008e90:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80008e94:	fe043703          	ld	a4,-32(s0)
    80008e98:	e00007b7          	lui	a5,0xe0000
    80008e9c:	17fd                	addi	a5,a5,-1
    80008e9e:	8ff9                	and	a5,a5,a4
    80008ea0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80008ea4:	fe043703          	ld	a4,-32(s0)
    80008ea8:	f00007b7          	lui	a5,0xf0000
    80008eac:	17fd                	addi	a5,a5,-1
    80008eae:	8ff9                	and	a5,a5,a4
    80008eb0:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80008eb4:	100017b7          	lui	a5,0x10001
    80008eb8:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    80008ebc:	fe043703          	ld	a4,-32(s0)
    80008ec0:	2701                	sext.w	a4,a4
    80008ec2:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008ec4:	fe842783          	lw	a5,-24(s0)
    80008ec8:	0087e793          	ori	a5,a5,8
    80008ecc:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008ed0:	100017b7          	lui	a5,0x10001
    80008ed4:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008ed8:	fe842703          	lw	a4,-24(s0)
    80008edc:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80008ede:	fe842783          	lw	a5,-24(s0)
    80008ee2:	0047e793          	ori	a5,a5,4
    80008ee6:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008eea:	100017b7          	lui	a5,0x10001
    80008eee:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008ef2:	fe842703          	lw	a4,-24(s0)
    80008ef6:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80008ef8:	100017b7          	lui	a5,0x10001
    80008efc:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80008f00:	6705                	lui	a4,0x1
    80008f02:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80008f04:	100017b7          	lui	a5,0x10001
    80008f08:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    80008f0c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80008f10:	100017b7          	lui	a5,0x10001
    80008f14:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80008f18:	439c                	lw	a5,0(a5)
    80008f1a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80008f1e:	fdc42783          	lw	a5,-36(s0)
    80008f22:	2781                	sext.w	a5,a5
    80008f24:	eb89                	bnez	a5,80008f36 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80008f26:	00002517          	auipc	a0,0x2
    80008f2a:	7aa50513          	addi	a0,a0,1962 # 8000b6d0 <etext+0x6d0>
    80008f2e:	ffff8097          	auipc	ra,0xffff8
    80008f32:	d24080e7          	jalr	-732(ra) # 80000c52 <panic>
  if(max < NUM)
    80008f36:	fdc42783          	lw	a5,-36(s0)
    80008f3a:	0007871b          	sext.w	a4,a5
    80008f3e:	479d                	li	a5,7
    80008f40:	00e7ea63          	bltu	a5,a4,80008f54 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    80008f44:	00002517          	auipc	a0,0x2
    80008f48:	7ac50513          	addi	a0,a0,1964 # 8000b6f0 <etext+0x6f0>
    80008f4c:	ffff8097          	auipc	ra,0xffff8
    80008f50:	d06080e7          	jalr	-762(ra) # 80000c52 <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80008f54:	100017b7          	lui	a5,0x10001
    80008f58:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    80008f5c:	4721                	li	a4,8
    80008f5e:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    80008f60:	6609                	lui	a2,0x2
    80008f62:	4581                	li	a1,0
    80008f64:	00066517          	auipc	a0,0x66
    80008f68:	09c50513          	addi	a0,a0,156 # 8006f000 <disk>
    80008f6c:	ffff8097          	auipc	ra,0xffff8
    80008f70:	4e8080e7          	jalr	1256(ra) # 80001454 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80008f74:	00066797          	auipc	a5,0x66
    80008f78:	08c78793          	addi	a5,a5,140 # 8006f000 <disk>
    80008f7c:	00c7d713          	srli	a4,a5,0xc
    80008f80:	100017b7          	lui	a5,0x10001
    80008f84:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    80008f88:	2701                	sext.w	a4,a4
    80008f8a:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    80008f8c:	00066717          	auipc	a4,0x66
    80008f90:	07470713          	addi	a4,a4,116 # 8006f000 <disk>
    80008f94:	6789                	lui	a5,0x2
    80008f96:	97ba                	add	a5,a5,a4
    80008f98:	00066717          	auipc	a4,0x66
    80008f9c:	06870713          	addi	a4,a4,104 # 8006f000 <disk>
    80008fa0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80008fa2:	00066717          	auipc	a4,0x66
    80008fa6:	0de70713          	addi	a4,a4,222 # 8006f080 <disk+0x80>
    80008faa:	00066697          	auipc	a3,0x66
    80008fae:	05668693          	addi	a3,a3,86 # 8006f000 <disk>
    80008fb2:	6789                	lui	a5,0x2
    80008fb4:	97b6                	add	a5,a5,a3
    80008fb6:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80008fb8:	00067717          	auipc	a4,0x67
    80008fbc:	04870713          	addi	a4,a4,72 # 80070000 <disk+0x1000>
    80008fc0:	00066697          	auipc	a3,0x66
    80008fc4:	04068693          	addi	a3,a3,64 # 8006f000 <disk>
    80008fc8:	6789                	lui	a5,0x2
    80008fca:	97b6                	add	a5,a5,a3
    80008fcc:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    80008fce:	fe042623          	sw	zero,-20(s0)
    80008fd2:	a015                	j	80008ff6 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80008fd4:	00066717          	auipc	a4,0x66
    80008fd8:	02c70713          	addi	a4,a4,44 # 8006f000 <disk>
    80008fdc:	fec42783          	lw	a5,-20(s0)
    80008fe0:	97ba                	add	a5,a5,a4
    80008fe2:	6709                	lui	a4,0x2
    80008fe4:	97ba                	add	a5,a5,a4
    80008fe6:	4705                	li	a4,1
    80008fe8:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    80008fec:	fec42783          	lw	a5,-20(s0)
    80008ff0:	2785                	addiw	a5,a5,1
    80008ff2:	fef42623          	sw	a5,-20(s0)
    80008ff6:	fec42783          	lw	a5,-20(s0)
    80008ffa:	0007871b          	sext.w	a4,a5
    80008ffe:	479d                	li	a5,7
    80009000:	fce7dae3          	bge	a5,a4,80008fd4 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80009004:	0001                	nop
    80009006:	0001                	nop
    80009008:	70a2                	ld	ra,40(sp)
    8000900a:	7402                	ld	s0,32(sp)
    8000900c:	6145                	addi	sp,sp,48
    8000900e:	8082                	ret

0000000080009010 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80009010:	1101                	addi	sp,sp,-32
    80009012:	ec22                	sd	s0,24(sp)
    80009014:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80009016:	fe042623          	sw	zero,-20(s0)
    8000901a:	a081                	j	8000905a <alloc_desc+0x4a>
    if(disk.free[i]){
    8000901c:	00066717          	auipc	a4,0x66
    80009020:	fe470713          	addi	a4,a4,-28 # 8006f000 <disk>
    80009024:	fec42783          	lw	a5,-20(s0)
    80009028:	97ba                	add	a5,a5,a4
    8000902a:	6709                	lui	a4,0x2
    8000902c:	97ba                	add	a5,a5,a4
    8000902e:	0187c783          	lbu	a5,24(a5)
    80009032:	cf99                	beqz	a5,80009050 <alloc_desc+0x40>
      disk.free[i] = 0;
    80009034:	00066717          	auipc	a4,0x66
    80009038:	fcc70713          	addi	a4,a4,-52 # 8006f000 <disk>
    8000903c:	fec42783          	lw	a5,-20(s0)
    80009040:	97ba                	add	a5,a5,a4
    80009042:	6709                	lui	a4,0x2
    80009044:	97ba                	add	a5,a5,a4
    80009046:	00078c23          	sb	zero,24(a5)
      return i;
    8000904a:	fec42783          	lw	a5,-20(s0)
    8000904e:	a831                	j	8000906a <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    80009050:	fec42783          	lw	a5,-20(s0)
    80009054:	2785                	addiw	a5,a5,1
    80009056:	fef42623          	sw	a5,-20(s0)
    8000905a:	fec42783          	lw	a5,-20(s0)
    8000905e:	0007871b          	sext.w	a4,a5
    80009062:	479d                	li	a5,7
    80009064:	fae7dce3          	bge	a5,a4,8000901c <alloc_desc+0xc>
    }
  }
  return -1;
    80009068:	57fd                	li	a5,-1
}
    8000906a:	853e                	mv	a0,a5
    8000906c:	6462                	ld	s0,24(sp)
    8000906e:	6105                	addi	sp,sp,32
    80009070:	8082                	ret

0000000080009072 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    80009072:	1101                	addi	sp,sp,-32
    80009074:	ec06                	sd	ra,24(sp)
    80009076:	e822                	sd	s0,16(sp)
    80009078:	1000                	addi	s0,sp,32
    8000907a:	87aa                	mv	a5,a0
    8000907c:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    80009080:	fec42783          	lw	a5,-20(s0)
    80009084:	0007871b          	sext.w	a4,a5
    80009088:	479d                	li	a5,7
    8000908a:	00e7da63          	bge	a5,a4,8000909e <free_desc+0x2c>
    panic("free_desc 1");
    8000908e:	00002517          	auipc	a0,0x2
    80009092:	68250513          	addi	a0,a0,1666 # 8000b710 <etext+0x710>
    80009096:	ffff8097          	auipc	ra,0xffff8
    8000909a:	bbc080e7          	jalr	-1092(ra) # 80000c52 <panic>
  if(disk.free[i])
    8000909e:	00066717          	auipc	a4,0x66
    800090a2:	f6270713          	addi	a4,a4,-158 # 8006f000 <disk>
    800090a6:	fec42783          	lw	a5,-20(s0)
    800090aa:	97ba                	add	a5,a5,a4
    800090ac:	6709                	lui	a4,0x2
    800090ae:	97ba                	add	a5,a5,a4
    800090b0:	0187c783          	lbu	a5,24(a5)
    800090b4:	cb89                	beqz	a5,800090c6 <free_desc+0x54>
    panic("free_desc 2");
    800090b6:	00002517          	auipc	a0,0x2
    800090ba:	66a50513          	addi	a0,a0,1642 # 8000b720 <etext+0x720>
    800090be:	ffff8097          	auipc	ra,0xffff8
    800090c2:	b94080e7          	jalr	-1132(ra) # 80000c52 <panic>
  disk.desc[i].addr = 0;
    800090c6:	00066717          	auipc	a4,0x66
    800090ca:	f3a70713          	addi	a4,a4,-198 # 8006f000 <disk>
    800090ce:	6789                	lui	a5,0x2
    800090d0:	97ba                	add	a5,a5,a4
    800090d2:	6398                	ld	a4,0(a5)
    800090d4:	fec42783          	lw	a5,-20(s0)
    800090d8:	0792                	slli	a5,a5,0x4
    800090da:	97ba                	add	a5,a5,a4
    800090dc:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    800090e0:	00066717          	auipc	a4,0x66
    800090e4:	f2070713          	addi	a4,a4,-224 # 8006f000 <disk>
    800090e8:	6789                	lui	a5,0x2
    800090ea:	97ba                	add	a5,a5,a4
    800090ec:	6398                	ld	a4,0(a5)
    800090ee:	fec42783          	lw	a5,-20(s0)
    800090f2:	0792                	slli	a5,a5,0x4
    800090f4:	97ba                	add	a5,a5,a4
    800090f6:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    800090fa:	00066717          	auipc	a4,0x66
    800090fe:	f0670713          	addi	a4,a4,-250 # 8006f000 <disk>
    80009102:	6789                	lui	a5,0x2
    80009104:	97ba                	add	a5,a5,a4
    80009106:	6398                	ld	a4,0(a5)
    80009108:	fec42783          	lw	a5,-20(s0)
    8000910c:	0792                	slli	a5,a5,0x4
    8000910e:	97ba                	add	a5,a5,a4
    80009110:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009114:	00066717          	auipc	a4,0x66
    80009118:	eec70713          	addi	a4,a4,-276 # 8006f000 <disk>
    8000911c:	6789                	lui	a5,0x2
    8000911e:	97ba                	add	a5,a5,a4
    80009120:	6398                	ld	a4,0(a5)
    80009122:	fec42783          	lw	a5,-20(s0)
    80009126:	0792                	slli	a5,a5,0x4
    80009128:	97ba                	add	a5,a5,a4
    8000912a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000912e:	00066717          	auipc	a4,0x66
    80009132:	ed270713          	addi	a4,a4,-302 # 8006f000 <disk>
    80009136:	fec42783          	lw	a5,-20(s0)
    8000913a:	97ba                	add	a5,a5,a4
    8000913c:	6709                	lui	a4,0x2
    8000913e:	97ba                	add	a5,a5,a4
    80009140:	4705                	li	a4,1
    80009142:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80009146:	00068517          	auipc	a0,0x68
    8000914a:	ed250513          	addi	a0,a0,-302 # 80071018 <disk+0x2018>
    8000914e:	ffffa097          	auipc	ra,0xffffa
    80009152:	48a080e7          	jalr	1162(ra) # 800035d8 <wakeup>
}
    80009156:	0001                	nop
    80009158:	60e2                	ld	ra,24(sp)
    8000915a:	6442                	ld	s0,16(sp)
    8000915c:	6105                	addi	sp,sp,32
    8000915e:	8082                	ret

0000000080009160 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    80009160:	7179                	addi	sp,sp,-48
    80009162:	f406                	sd	ra,40(sp)
    80009164:	f022                	sd	s0,32(sp)
    80009166:	1800                	addi	s0,sp,48
    80009168:	87aa                	mv	a5,a0
    8000916a:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    8000916e:	00066717          	auipc	a4,0x66
    80009172:	e9270713          	addi	a4,a4,-366 # 8006f000 <disk>
    80009176:	6789                	lui	a5,0x2
    80009178:	97ba                	add	a5,a5,a4
    8000917a:	6398                	ld	a4,0(a5)
    8000917c:	fdc42783          	lw	a5,-36(s0)
    80009180:	0792                	slli	a5,a5,0x4
    80009182:	97ba                	add	a5,a5,a4
    80009184:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    80009188:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    8000918c:	00066717          	auipc	a4,0x66
    80009190:	e7470713          	addi	a4,a4,-396 # 8006f000 <disk>
    80009194:	6789                	lui	a5,0x2
    80009196:	97ba                	add	a5,a5,a4
    80009198:	6398                	ld	a4,0(a5)
    8000919a:	fdc42783          	lw	a5,-36(s0)
    8000919e:	0792                	slli	a5,a5,0x4
    800091a0:	97ba                	add	a5,a5,a4
    800091a2:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    800091a6:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    800091aa:	fdc42783          	lw	a5,-36(s0)
    800091ae:	853e                	mv	a0,a5
    800091b0:	00000097          	auipc	ra,0x0
    800091b4:	ec2080e7          	jalr	-318(ra) # 80009072 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800091b8:	fec42783          	lw	a5,-20(s0)
    800091bc:	8b85                	andi	a5,a5,1
    800091be:	2781                	sext.w	a5,a5
    800091c0:	c791                	beqz	a5,800091cc <free_chain+0x6c>
      i = nxt;
    800091c2:	fe842783          	lw	a5,-24(s0)
    800091c6:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    800091ca:	b755                	j	8000916e <free_chain+0xe>
    else
      break;
    800091cc:	0001                	nop
  }
}
    800091ce:	0001                	nop
    800091d0:	70a2                	ld	ra,40(sp)
    800091d2:	7402                	ld	s0,32(sp)
    800091d4:	6145                	addi	sp,sp,48
    800091d6:	8082                	ret

00000000800091d8 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    800091d8:	7139                	addi	sp,sp,-64
    800091da:	fc06                	sd	ra,56(sp)
    800091dc:	f822                	sd	s0,48(sp)
    800091de:	f426                	sd	s1,40(sp)
    800091e0:	0080                	addi	s0,sp,64
    800091e2:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    800091e6:	fc042e23          	sw	zero,-36(s0)
    800091ea:	a895                	j	8000925e <alloc3_desc+0x86>
    idx[i] = alloc_desc();
    800091ec:	fdc42783          	lw	a5,-36(s0)
    800091f0:	078a                	slli	a5,a5,0x2
    800091f2:	fc843703          	ld	a4,-56(s0)
    800091f6:	00f704b3          	add	s1,a4,a5
    800091fa:	00000097          	auipc	ra,0x0
    800091fe:	e16080e7          	jalr	-490(ra) # 80009010 <alloc_desc>
    80009202:	87aa                	mv	a5,a0
    80009204:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009206:	fdc42783          	lw	a5,-36(s0)
    8000920a:	078a                	slli	a5,a5,0x2
    8000920c:	fc843703          	ld	a4,-56(s0)
    80009210:	97ba                	add	a5,a5,a4
    80009212:	439c                	lw	a5,0(a5)
    80009214:	0407d063          	bgez	a5,80009254 <alloc3_desc+0x7c>
      for(int j = 0; j < i; j++)
    80009218:	fc042c23          	sw	zero,-40(s0)
    8000921c:	a015                	j	80009240 <alloc3_desc+0x68>
        free_desc(idx[j]);
    8000921e:	fd842783          	lw	a5,-40(s0)
    80009222:	078a                	slli	a5,a5,0x2
    80009224:	fc843703          	ld	a4,-56(s0)
    80009228:	97ba                	add	a5,a5,a4
    8000922a:	439c                	lw	a5,0(a5)
    8000922c:	853e                	mv	a0,a5
    8000922e:	00000097          	auipc	ra,0x0
    80009232:	e44080e7          	jalr	-444(ra) # 80009072 <free_desc>
      for(int j = 0; j < i; j++)
    80009236:	fd842783          	lw	a5,-40(s0)
    8000923a:	2785                	addiw	a5,a5,1
    8000923c:	fcf42c23          	sw	a5,-40(s0)
    80009240:	fd842703          	lw	a4,-40(s0)
    80009244:	fdc42783          	lw	a5,-36(s0)
    80009248:	2701                	sext.w	a4,a4
    8000924a:	2781                	sext.w	a5,a5
    8000924c:	fcf749e3          	blt	a4,a5,8000921e <alloc3_desc+0x46>
      return -1;
    80009250:	57fd                	li	a5,-1
    80009252:	a831                	j	8000926e <alloc3_desc+0x96>
  for(int i = 0; i < 3; i++){
    80009254:	fdc42783          	lw	a5,-36(s0)
    80009258:	2785                	addiw	a5,a5,1
    8000925a:	fcf42e23          	sw	a5,-36(s0)
    8000925e:	fdc42783          	lw	a5,-36(s0)
    80009262:	0007871b          	sext.w	a4,a5
    80009266:	4789                	li	a5,2
    80009268:	f8e7d2e3          	bge	a5,a4,800091ec <alloc3_desc+0x14>
    }
  }
  return 0;
    8000926c:	4781                	li	a5,0
}
    8000926e:	853e                	mv	a0,a5
    80009270:	70e2                	ld	ra,56(sp)
    80009272:	7442                	ld	s0,48(sp)
    80009274:	74a2                	ld	s1,40(sp)
    80009276:	6121                	addi	sp,sp,64
    80009278:	8082                	ret

000000008000927a <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    8000927a:	7139                	addi	sp,sp,-64
    8000927c:	fc06                	sd	ra,56(sp)
    8000927e:	f822                	sd	s0,48(sp)
    80009280:	0080                	addi	s0,sp,64
    80009282:	fca43423          	sd	a0,-56(s0)
    80009286:	87ae                	mv	a5,a1
    80009288:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    8000928c:	fc843783          	ld	a5,-56(s0)
    80009290:	47dc                	lw	a5,12(a5)
    80009292:	0017979b          	slliw	a5,a5,0x1
    80009296:	2781                	sext.w	a5,a5
    80009298:	1782                	slli	a5,a5,0x20
    8000929a:	9381                	srli	a5,a5,0x20
    8000929c:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    800092a0:	00068517          	auipc	a0,0x68
    800092a4:	e8850513          	addi	a0,a0,-376 # 80071128 <disk+0x2128>
    800092a8:	ffff8097          	auipc	ra,0xffff8
    800092ac:	fd8080e7          	jalr	-40(ra) # 80001280 <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    800092b0:	fd040793          	addi	a5,s0,-48
    800092b4:	853e                	mv	a0,a5
    800092b6:	00000097          	auipc	ra,0x0
    800092ba:	f22080e7          	jalr	-222(ra) # 800091d8 <alloc3_desc>
    800092be:	87aa                	mv	a5,a0
    800092c0:	cf91                	beqz	a5,800092dc <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800092c2:	00068597          	auipc	a1,0x68
    800092c6:	e6658593          	addi	a1,a1,-410 # 80071128 <disk+0x2128>
    800092ca:	00068517          	auipc	a0,0x68
    800092ce:	d4e50513          	addi	a0,a0,-690 # 80071018 <disk+0x2018>
    800092d2:	ffffa097          	auipc	ra,0xffffa
    800092d6:	272080e7          	jalr	626(ra) # 80003544 <sleep>
    if(alloc3_desc(idx) == 0) {
    800092da:	bfd9                	j	800092b0 <virtio_disk_rw+0x36>
      break;
    800092dc:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800092de:	fd042783          	lw	a5,-48(s0)
    800092e2:	20078793          	addi	a5,a5,512
    800092e6:	00479713          	slli	a4,a5,0x4
    800092ea:	00066797          	auipc	a5,0x66
    800092ee:	d1678793          	addi	a5,a5,-746 # 8006f000 <disk>
    800092f2:	97ba                	add	a5,a5,a4
    800092f4:	0a878793          	addi	a5,a5,168
    800092f8:	fef43023          	sd	a5,-32(s0)

  if(write)
    800092fc:	fc442783          	lw	a5,-60(s0)
    80009300:	2781                	sext.w	a5,a5
    80009302:	c791                	beqz	a5,8000930e <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009304:	fe043783          	ld	a5,-32(s0)
    80009308:	4705                	li	a4,1
    8000930a:	c398                	sw	a4,0(a5)
    8000930c:	a029                	j	80009316 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000930e:	fe043783          	ld	a5,-32(s0)
    80009312:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009316:	fe043783          	ld	a5,-32(s0)
    8000931a:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000931e:	fe043783          	ld	a5,-32(s0)
    80009322:	fe843703          	ld	a4,-24(s0)
    80009326:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80009328:	00066717          	auipc	a4,0x66
    8000932c:	cd870713          	addi	a4,a4,-808 # 8006f000 <disk>
    80009330:	6789                	lui	a5,0x2
    80009332:	97ba                	add	a5,a5,a4
    80009334:	6398                	ld	a4,0(a5)
    80009336:	fd042783          	lw	a5,-48(s0)
    8000933a:	0792                	slli	a5,a5,0x4
    8000933c:	97ba                	add	a5,a5,a4
    8000933e:	fe043703          	ld	a4,-32(s0)
    80009342:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80009344:	00066717          	auipc	a4,0x66
    80009348:	cbc70713          	addi	a4,a4,-836 # 8006f000 <disk>
    8000934c:	6789                	lui	a5,0x2
    8000934e:	97ba                	add	a5,a5,a4
    80009350:	6398                	ld	a4,0(a5)
    80009352:	fd042783          	lw	a5,-48(s0)
    80009356:	0792                	slli	a5,a5,0x4
    80009358:	97ba                	add	a5,a5,a4
    8000935a:	4741                	li	a4,16
    8000935c:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000935e:	00066717          	auipc	a4,0x66
    80009362:	ca270713          	addi	a4,a4,-862 # 8006f000 <disk>
    80009366:	6789                	lui	a5,0x2
    80009368:	97ba                	add	a5,a5,a4
    8000936a:	6398                	ld	a4,0(a5)
    8000936c:	fd042783          	lw	a5,-48(s0)
    80009370:	0792                	slli	a5,a5,0x4
    80009372:	97ba                	add	a5,a5,a4
    80009374:	4705                	li	a4,1
    80009376:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    8000937a:	fd442683          	lw	a3,-44(s0)
    8000937e:	00066717          	auipc	a4,0x66
    80009382:	c8270713          	addi	a4,a4,-894 # 8006f000 <disk>
    80009386:	6789                	lui	a5,0x2
    80009388:	97ba                	add	a5,a5,a4
    8000938a:	6398                	ld	a4,0(a5)
    8000938c:	fd042783          	lw	a5,-48(s0)
    80009390:	0792                	slli	a5,a5,0x4
    80009392:	97ba                	add	a5,a5,a4
    80009394:	03069713          	slli	a4,a3,0x30
    80009398:	9341                	srli	a4,a4,0x30
    8000939a:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    8000939e:	fc843783          	ld	a5,-56(s0)
    800093a2:	05878693          	addi	a3,a5,88
    800093a6:	00066717          	auipc	a4,0x66
    800093aa:	c5a70713          	addi	a4,a4,-934 # 8006f000 <disk>
    800093ae:	6789                	lui	a5,0x2
    800093b0:	97ba                	add	a5,a5,a4
    800093b2:	6398                	ld	a4,0(a5)
    800093b4:	fd442783          	lw	a5,-44(s0)
    800093b8:	0792                	slli	a5,a5,0x4
    800093ba:	97ba                	add	a5,a5,a4
    800093bc:	8736                	mv	a4,a3
    800093be:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    800093c0:	00066717          	auipc	a4,0x66
    800093c4:	c4070713          	addi	a4,a4,-960 # 8006f000 <disk>
    800093c8:	6789                	lui	a5,0x2
    800093ca:	97ba                	add	a5,a5,a4
    800093cc:	6398                	ld	a4,0(a5)
    800093ce:	fd442783          	lw	a5,-44(s0)
    800093d2:	0792                	slli	a5,a5,0x4
    800093d4:	97ba                	add	a5,a5,a4
    800093d6:	40000713          	li	a4,1024
    800093da:	c798                	sw	a4,8(a5)
  if(write)
    800093dc:	fc442783          	lw	a5,-60(s0)
    800093e0:	2781                	sext.w	a5,a5
    800093e2:	cf99                	beqz	a5,80009400 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800093e4:	00066717          	auipc	a4,0x66
    800093e8:	c1c70713          	addi	a4,a4,-996 # 8006f000 <disk>
    800093ec:	6789                	lui	a5,0x2
    800093ee:	97ba                	add	a5,a5,a4
    800093f0:	6398                	ld	a4,0(a5)
    800093f2:	fd442783          	lw	a5,-44(s0)
    800093f6:	0792                	slli	a5,a5,0x4
    800093f8:	97ba                	add	a5,a5,a4
    800093fa:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    800093fe:	a839                	j	8000941c <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009400:	00066717          	auipc	a4,0x66
    80009404:	c0070713          	addi	a4,a4,-1024 # 8006f000 <disk>
    80009408:	6789                	lui	a5,0x2
    8000940a:	97ba                	add	a5,a5,a4
    8000940c:	6398                	ld	a4,0(a5)
    8000940e:	fd442783          	lw	a5,-44(s0)
    80009412:	0792                	slli	a5,a5,0x4
    80009414:	97ba                	add	a5,a5,a4
    80009416:	4709                	li	a4,2
    80009418:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000941c:	00066717          	auipc	a4,0x66
    80009420:	be470713          	addi	a4,a4,-1052 # 8006f000 <disk>
    80009424:	6789                	lui	a5,0x2
    80009426:	97ba                	add	a5,a5,a4
    80009428:	6398                	ld	a4,0(a5)
    8000942a:	fd442783          	lw	a5,-44(s0)
    8000942e:	0792                	slli	a5,a5,0x4
    80009430:	97ba                	add	a5,a5,a4
    80009432:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80009436:	00066697          	auipc	a3,0x66
    8000943a:	bca68693          	addi	a3,a3,-1078 # 8006f000 <disk>
    8000943e:	6789                	lui	a5,0x2
    80009440:	97b6                	add	a5,a5,a3
    80009442:	6394                	ld	a3,0(a5)
    80009444:	fd442783          	lw	a5,-44(s0)
    80009448:	0792                	slli	a5,a5,0x4
    8000944a:	97b6                	add	a5,a5,a3
    8000944c:	00176713          	ori	a4,a4,1
    80009450:	1742                	slli	a4,a4,0x30
    80009452:	9341                	srli	a4,a4,0x30
    80009454:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    80009458:	fd842683          	lw	a3,-40(s0)
    8000945c:	00066717          	auipc	a4,0x66
    80009460:	ba470713          	addi	a4,a4,-1116 # 8006f000 <disk>
    80009464:	6789                	lui	a5,0x2
    80009466:	97ba                	add	a5,a5,a4
    80009468:	6398                	ld	a4,0(a5)
    8000946a:	fd442783          	lw	a5,-44(s0)
    8000946e:	0792                	slli	a5,a5,0x4
    80009470:	97ba                	add	a5,a5,a4
    80009472:	03069713          	slli	a4,a3,0x30
    80009476:	9341                	srli	a4,a4,0x30
    80009478:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000947c:	fd042783          	lw	a5,-48(s0)
    80009480:	00066717          	auipc	a4,0x66
    80009484:	b8070713          	addi	a4,a4,-1152 # 8006f000 <disk>
    80009488:	20078793          	addi	a5,a5,512
    8000948c:	0792                	slli	a5,a5,0x4
    8000948e:	97ba                	add	a5,a5,a4
    80009490:	577d                	li	a4,-1
    80009492:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80009496:	fd042783          	lw	a5,-48(s0)
    8000949a:	20078793          	addi	a5,a5,512
    8000949e:	00479713          	slli	a4,a5,0x4
    800094a2:	00066797          	auipc	a5,0x66
    800094a6:	b5e78793          	addi	a5,a5,-1186 # 8006f000 <disk>
    800094aa:	97ba                	add	a5,a5,a4
    800094ac:	03078693          	addi	a3,a5,48
    800094b0:	00066717          	auipc	a4,0x66
    800094b4:	b5070713          	addi	a4,a4,-1200 # 8006f000 <disk>
    800094b8:	6789                	lui	a5,0x2
    800094ba:	97ba                	add	a5,a5,a4
    800094bc:	6398                	ld	a4,0(a5)
    800094be:	fd842783          	lw	a5,-40(s0)
    800094c2:	0792                	slli	a5,a5,0x4
    800094c4:	97ba                	add	a5,a5,a4
    800094c6:	8736                	mv	a4,a3
    800094c8:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    800094ca:	00066717          	auipc	a4,0x66
    800094ce:	b3670713          	addi	a4,a4,-1226 # 8006f000 <disk>
    800094d2:	6789                	lui	a5,0x2
    800094d4:	97ba                	add	a5,a5,a4
    800094d6:	6398                	ld	a4,0(a5)
    800094d8:	fd842783          	lw	a5,-40(s0)
    800094dc:	0792                	slli	a5,a5,0x4
    800094de:	97ba                	add	a5,a5,a4
    800094e0:	4705                	li	a4,1
    800094e2:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800094e4:	00066717          	auipc	a4,0x66
    800094e8:	b1c70713          	addi	a4,a4,-1252 # 8006f000 <disk>
    800094ec:	6789                	lui	a5,0x2
    800094ee:	97ba                	add	a5,a5,a4
    800094f0:	6398                	ld	a4,0(a5)
    800094f2:	fd842783          	lw	a5,-40(s0)
    800094f6:	0792                	slli	a5,a5,0x4
    800094f8:	97ba                	add	a5,a5,a4
    800094fa:	4709                	li	a4,2
    800094fc:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009500:	00066717          	auipc	a4,0x66
    80009504:	b0070713          	addi	a4,a4,-1280 # 8006f000 <disk>
    80009508:	6789                	lui	a5,0x2
    8000950a:	97ba                	add	a5,a5,a4
    8000950c:	6398                	ld	a4,0(a5)
    8000950e:	fd842783          	lw	a5,-40(s0)
    80009512:	0792                	slli	a5,a5,0x4
    80009514:	97ba                	add	a5,a5,a4
    80009516:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000951a:	fc843783          	ld	a5,-56(s0)
    8000951e:	4705                	li	a4,1
    80009520:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009522:	fd042783          	lw	a5,-48(s0)
    80009526:	00066717          	auipc	a4,0x66
    8000952a:	ada70713          	addi	a4,a4,-1318 # 8006f000 <disk>
    8000952e:	20078793          	addi	a5,a5,512
    80009532:	0792                	slli	a5,a5,0x4
    80009534:	97ba                	add	a5,a5,a4
    80009536:	fc843703          	ld	a4,-56(s0)
    8000953a:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    8000953c:	fd042603          	lw	a2,-48(s0)
    80009540:	00066717          	auipc	a4,0x66
    80009544:	ac070713          	addi	a4,a4,-1344 # 8006f000 <disk>
    80009548:	6789                	lui	a5,0x2
    8000954a:	97ba                	add	a5,a5,a4
    8000954c:	6794                	ld	a3,8(a5)
    8000954e:	00066717          	auipc	a4,0x66
    80009552:	ab270713          	addi	a4,a4,-1358 # 8006f000 <disk>
    80009556:	6789                	lui	a5,0x2
    80009558:	97ba                	add	a5,a5,a4
    8000955a:	679c                	ld	a5,8(a5)
    8000955c:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009560:	2781                	sext.w	a5,a5
    80009562:	8b9d                	andi	a5,a5,7
    80009564:	2781                	sext.w	a5,a5
    80009566:	03061713          	slli	a4,a2,0x30
    8000956a:	9341                	srli	a4,a4,0x30
    8000956c:	0786                	slli	a5,a5,0x1
    8000956e:	97b6                	add	a5,a5,a3
    80009570:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    80009574:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80009578:	00066717          	auipc	a4,0x66
    8000957c:	a8870713          	addi	a4,a4,-1400 # 8006f000 <disk>
    80009580:	6789                	lui	a5,0x2
    80009582:	97ba                	add	a5,a5,a4
    80009584:	679c                	ld	a5,8(a5)
    80009586:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    8000958a:	00066697          	auipc	a3,0x66
    8000958e:	a7668693          	addi	a3,a3,-1418 # 8006f000 <disk>
    80009592:	6789                	lui	a5,0x2
    80009594:	97b6                	add	a5,a5,a3
    80009596:	679c                	ld	a5,8(a5)
    80009598:	2705                	addiw	a4,a4,1
    8000959a:	1742                	slli	a4,a4,0x30
    8000959c:	9341                	srli	a4,a4,0x30
    8000959e:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    800095a2:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800095a6:	100017b7          	lui	a5,0x10001
    800095aa:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    800095ae:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800095b2:	a819                	j	800095c8 <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    800095b4:	00068597          	auipc	a1,0x68
    800095b8:	b7458593          	addi	a1,a1,-1164 # 80071128 <disk+0x2128>
    800095bc:	fc843503          	ld	a0,-56(s0)
    800095c0:	ffffa097          	auipc	ra,0xffffa
    800095c4:	f84080e7          	jalr	-124(ra) # 80003544 <sleep>
  while(b->disk == 1) {
    800095c8:	fc843783          	ld	a5,-56(s0)
    800095cc:	43dc                	lw	a5,4(a5)
    800095ce:	873e                	mv	a4,a5
    800095d0:	4785                	li	a5,1
    800095d2:	fef701e3          	beq	a4,a5,800095b4 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    800095d6:	fd042783          	lw	a5,-48(s0)
    800095da:	00066717          	auipc	a4,0x66
    800095de:	a2670713          	addi	a4,a4,-1498 # 8006f000 <disk>
    800095e2:	20078793          	addi	a5,a5,512
    800095e6:	0792                	slli	a5,a5,0x4
    800095e8:	97ba                	add	a5,a5,a4
    800095ea:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    800095ee:	fd042783          	lw	a5,-48(s0)
    800095f2:	853e                	mv	a0,a5
    800095f4:	00000097          	auipc	ra,0x0
    800095f8:	b6c080e7          	jalr	-1172(ra) # 80009160 <free_chain>

  release(&disk.vdisk_lock);
    800095fc:	00068517          	auipc	a0,0x68
    80009600:	b2c50513          	addi	a0,a0,-1236 # 80071128 <disk+0x2128>
    80009604:	ffff8097          	auipc	ra,0xffff8
    80009608:	ce0080e7          	jalr	-800(ra) # 800012e4 <release>
}
    8000960c:	0001                	nop
    8000960e:	70e2                	ld	ra,56(sp)
    80009610:	7442                	ld	s0,48(sp)
    80009612:	6121                	addi	sp,sp,64
    80009614:	8082                	ret

0000000080009616 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009616:	1101                	addi	sp,sp,-32
    80009618:	ec06                	sd	ra,24(sp)
    8000961a:	e822                	sd	s0,16(sp)
    8000961c:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000961e:	00068517          	auipc	a0,0x68
    80009622:	b0a50513          	addi	a0,a0,-1270 # 80071128 <disk+0x2128>
    80009626:	ffff8097          	auipc	ra,0xffff8
    8000962a:	c5a080e7          	jalr	-934(ra) # 80001280 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000962e:	100017b7          	lui	a5,0x10001
    80009632:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80009636:	439c                	lw	a5,0(a5)
    80009638:	0007871b          	sext.w	a4,a5
    8000963c:	100017b7          	lui	a5,0x10001
    80009640:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80009644:	8b0d                	andi	a4,a4,3
    80009646:	2701                	sext.w	a4,a4
    80009648:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    8000964a:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    8000964e:	a855                	j	80009702 <virtio_disk_intr+0xec>
    __sync_synchronize();
    80009650:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80009654:	00066717          	auipc	a4,0x66
    80009658:	9ac70713          	addi	a4,a4,-1620 # 8006f000 <disk>
    8000965c:	6789                	lui	a5,0x2
    8000965e:	97ba                	add	a5,a5,a4
    80009660:	6b98                	ld	a4,16(a5)
    80009662:	00066697          	auipc	a3,0x66
    80009666:	99e68693          	addi	a3,a3,-1634 # 8006f000 <disk>
    8000966a:	6789                	lui	a5,0x2
    8000966c:	97b6                	add	a5,a5,a3
    8000966e:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009672:	2781                	sext.w	a5,a5
    80009674:	8b9d                	andi	a5,a5,7
    80009676:	2781                	sext.w	a5,a5
    80009678:	078e                	slli	a5,a5,0x3
    8000967a:	97ba                	add	a5,a5,a4
    8000967c:	43dc                	lw	a5,4(a5)
    8000967e:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80009682:	00066717          	auipc	a4,0x66
    80009686:	97e70713          	addi	a4,a4,-1666 # 8006f000 <disk>
    8000968a:	fec42783          	lw	a5,-20(s0)
    8000968e:	20078793          	addi	a5,a5,512
    80009692:	0792                	slli	a5,a5,0x4
    80009694:	97ba                	add	a5,a5,a4
    80009696:	0307c783          	lbu	a5,48(a5)
    8000969a:	cb89                	beqz	a5,800096ac <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    8000969c:	00002517          	auipc	a0,0x2
    800096a0:	09450513          	addi	a0,a0,148 # 8000b730 <etext+0x730>
    800096a4:	ffff7097          	auipc	ra,0xffff7
    800096a8:	5ae080e7          	jalr	1454(ra) # 80000c52 <panic>

    struct buf *b = disk.info[id].b;
    800096ac:	00066717          	auipc	a4,0x66
    800096b0:	95470713          	addi	a4,a4,-1708 # 8006f000 <disk>
    800096b4:	fec42783          	lw	a5,-20(s0)
    800096b8:	20078793          	addi	a5,a5,512
    800096bc:	0792                	slli	a5,a5,0x4
    800096be:	97ba                	add	a5,a5,a4
    800096c0:	779c                	ld	a5,40(a5)
    800096c2:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    800096c6:	fe043783          	ld	a5,-32(s0)
    800096ca:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    800096ce:	fe043503          	ld	a0,-32(s0)
    800096d2:	ffffa097          	auipc	ra,0xffffa
    800096d6:	f06080e7          	jalr	-250(ra) # 800035d8 <wakeup>

    disk.used_idx += 1;
    800096da:	00066717          	auipc	a4,0x66
    800096de:	92670713          	addi	a4,a4,-1754 # 8006f000 <disk>
    800096e2:	6789                	lui	a5,0x2
    800096e4:	97ba                	add	a5,a5,a4
    800096e6:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    800096ea:	2785                	addiw	a5,a5,1
    800096ec:	03079713          	slli	a4,a5,0x30
    800096f0:	9341                	srli	a4,a4,0x30
    800096f2:	00066697          	auipc	a3,0x66
    800096f6:	90e68693          	addi	a3,a3,-1778 # 8006f000 <disk>
    800096fa:	6789                	lui	a5,0x2
    800096fc:	97b6                	add	a5,a5,a3
    800096fe:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009702:	00066717          	auipc	a4,0x66
    80009706:	8fe70713          	addi	a4,a4,-1794 # 8006f000 <disk>
    8000970a:	6789                	lui	a5,0x2
    8000970c:	97ba                	add	a5,a5,a4
    8000970e:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009712:	00066717          	auipc	a4,0x66
    80009716:	8ee70713          	addi	a4,a4,-1810 # 8006f000 <disk>
    8000971a:	6789                	lui	a5,0x2
    8000971c:	97ba                	add	a5,a5,a4
    8000971e:	6b9c                	ld	a5,16(a5)
    80009720:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009724:	0006871b          	sext.w	a4,a3
    80009728:	2781                	sext.w	a5,a5
    8000972a:	f2f713e3          	bne	a4,a5,80009650 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    8000972e:	00068517          	auipc	a0,0x68
    80009732:	9fa50513          	addi	a0,a0,-1542 # 80071128 <disk+0x2128>
    80009736:	ffff8097          	auipc	ra,0xffff8
    8000973a:	bae080e7          	jalr	-1106(ra) # 800012e4 <release>
}
    8000973e:	0001                	nop
    80009740:	60e2                	ld	ra,24(sp)
    80009742:	6442                	ld	s0,16(sp)
    80009744:	6105                	addi	sp,sp,32
    80009746:	8082                	ret

0000000080009748 <sys_thrdstop>:
#include "proc.h"

// for mp3
uint64
sys_thrdstop(void)
{
    80009748:	7139                	addi	sp,sp,-64
    8000974a:	fc06                	sd	ra,56(sp)
    8000974c:	f822                	sd	s0,48(sp)
    8000974e:	0080                	addi	s0,sp,64
  int delay, context_id;
  uint64 context_id_ptr;
  uint64 handler, handler_arg;
  if (argint(0, &delay) < 0)
    80009750:	fdc40793          	addi	a5,s0,-36
    80009754:	85be                	mv	a1,a5
    80009756:	4501                	li	a0,0
    80009758:	ffffb097          	auipc	ra,0xffffb
    8000975c:	cde080e7          	jalr	-802(ra) # 80004436 <argint>
    80009760:	87aa                	mv	a5,a0
    80009762:	0007d463          	bgez	a5,8000976a <sys_thrdstop+0x22>
    return -1;
    80009766:	57fd                	li	a5,-1
    80009768:	aa89                	j	800098ba <sys_thrdstop+0x172>
  if (argaddr(1, &context_id_ptr) < 0)
    8000976a:	fd040793          	addi	a5,s0,-48
    8000976e:	85be                	mv	a1,a5
    80009770:	4505                	li	a0,1
    80009772:	ffffb097          	auipc	ra,0xffffb
    80009776:	cfc080e7          	jalr	-772(ra) # 8000446e <argaddr>
    8000977a:	87aa                	mv	a5,a0
    8000977c:	0007d463          	bgez	a5,80009784 <sys_thrdstop+0x3c>
    return -1;
    80009780:	57fd                	li	a5,-1
    80009782:	aa25                	j	800098ba <sys_thrdstop+0x172>
  if (argaddr(2, &handler) < 0)
    80009784:	fc840793          	addi	a5,s0,-56
    80009788:	85be                	mv	a1,a5
    8000978a:	4509                	li	a0,2
    8000978c:	ffffb097          	auipc	ra,0xffffb
    80009790:	ce2080e7          	jalr	-798(ra) # 8000446e <argaddr>
    80009794:	87aa                	mv	a5,a0
    80009796:	0007d463          	bgez	a5,8000979e <sys_thrdstop+0x56>
    return -1;
    8000979a:	57fd                	li	a5,-1
    8000979c:	aa39                	j	800098ba <sys_thrdstop+0x172>
  if (argaddr(3, &handler_arg) < 0)
    8000979e:	fc040793          	addi	a5,s0,-64
    800097a2:	85be                	mv	a1,a5
    800097a4:	450d                	li	a0,3
    800097a6:	ffffb097          	auipc	ra,0xffffb
    800097aa:	cc8080e7          	jalr	-824(ra) # 8000446e <argaddr>
    800097ae:	87aa                	mv	a5,a0
    800097b0:	0007d463          	bgez	a5,800097b8 <sys_thrdstop+0x70>
    return -1;
    800097b4:	57fd                	li	a5,-1
    800097b6:	a211                	j	800098ba <sys_thrdstop+0x172>

  struct proc *proc = myproc();
    800097b8:	ffff9097          	auipc	ra,0xffff9
    800097bc:	040080e7          	jalr	64(ra) # 800027f8 <myproc>
    800097c0:	fea43023          	sd	a0,-32(s0)
  if (copyin(proc->pagetable, (char *)&context_id, context_id_ptr, sizeof(int)) == -1) {
    800097c4:	fe043703          	ld	a4,-32(s0)
    800097c8:	6785                	lui	a5,0x1
    800097ca:	97ba                	add	a5,a5,a4
    800097cc:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    800097d0:	fd043603          	ld	a2,-48(s0)
    800097d4:	fd840713          	addi	a4,s0,-40
    800097d8:	4691                	li	a3,4
    800097da:	85ba                	mv	a1,a4
    800097dc:	853e                	mv	a0,a5
    800097de:	ffff9097          	auipc	ra,0xffff9
    800097e2:	bc4080e7          	jalr	-1084(ra) # 800023a2 <copyin>
    800097e6:	87aa                	mv	a5,a0
    800097e8:	873e                	mv	a4,a5
    800097ea:	57fd                	li	a5,-1
    800097ec:	00f71463          	bne	a4,a5,800097f4 <sys_thrdstop+0xac>
    return -1;
    800097f0:	57fd                	li	a5,-1
    800097f2:	a0e1                	j	800098ba <sys_thrdstop+0x172>
  }

  if (context_id < 0) {
    800097f4:	fd842783          	lw	a5,-40(s0)
    800097f8:	0607d063          	bgez	a5,80009858 <sys_thrdstop+0x110>
    for (int i = 0; i < MAX_THRD_NUM; i++) {
    800097fc:	fe042623          	sw	zero,-20(s0)
    80009800:	a83d                	j	8000983e <sys_thrdstop+0xf6>
      if (proc->thrdstop_context_used[i] == 0) {
    80009802:	fe043703          	ld	a4,-32(s0)
    80009806:	fec42783          	lw	a5,-20(s0)
    8000980a:	49478793          	addi	a5,a5,1172
    8000980e:	078a                	slli	a5,a5,0x2
    80009810:	97ba                	add	a5,a5,a4
    80009812:	479c                	lw	a5,8(a5)
    80009814:	e385                	bnez	a5,80009834 <sys_thrdstop+0xec>
        proc->thrdstop_context_used[i] = 1;
    80009816:	fe043703          	ld	a4,-32(s0)
    8000981a:	fec42783          	lw	a5,-20(s0)
    8000981e:	49478793          	addi	a5,a5,1172
    80009822:	078a                	slli	a5,a5,0x2
    80009824:	97ba                	add	a5,a5,a4
    80009826:	4705                	li	a4,1
    80009828:	c798                	sw	a4,8(a5)
        context_id = i;
    8000982a:	fec42783          	lw	a5,-20(s0)
    8000982e:	fcf42c23          	sw	a5,-40(s0)
        break;
    80009832:	a829                	j	8000984c <sys_thrdstop+0x104>
    for (int i = 0; i < MAX_THRD_NUM; i++) {
    80009834:	fec42783          	lw	a5,-20(s0)
    80009838:	2785                	addiw	a5,a5,1
    8000983a:	fef42623          	sw	a5,-20(s0)
    8000983e:	fec42783          	lw	a5,-20(s0)
    80009842:	0007871b          	sext.w	a4,a5
    80009846:	47bd                	li	a5,15
    80009848:	fae7dde3          	bge	a5,a4,80009802 <sys_thrdstop+0xba>
      }
    }

    if (context_id < 0) {
    8000984c:	fd842783          	lw	a5,-40(s0)
    80009850:	0007d463          	bgez	a5,80009858 <sys_thrdstop+0x110>
      return -1;
    80009854:	57fd                	li	a5,-1
    80009856:	a095                	j	800098ba <sys_thrdstop+0x172>
    }
  }

  if (copyout(proc->pagetable, context_id_ptr, (char *)&context_id, sizeof(int)) == -1) {
    80009858:	fe043703          	ld	a4,-32(s0)
    8000985c:	6785                	lui	a5,0x1
    8000985e:	97ba                	add	a5,a5,a4
    80009860:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009864:	fd043703          	ld	a4,-48(s0)
    80009868:	fd840613          	addi	a2,s0,-40
    8000986c:	4691                	li	a3,4
    8000986e:	85ba                	mv	a1,a4
    80009870:	853e                	mv	a0,a5
    80009872:	ffff9097          	auipc	ra,0xffff9
    80009876:	a62080e7          	jalr	-1438(ra) # 800022d4 <copyout>
    8000987a:	87aa                	mv	a5,a0
    8000987c:	873e                	mv	a4,a5
    8000987e:	57fd                	li	a5,-1
    80009880:	00f71463          	bne	a4,a5,80009888 <sys_thrdstop+0x140>
    return -1;
    80009884:	57fd                	li	a5,-1
    80009886:	a815                	j	800098ba <sys_thrdstop+0x172>
  }

  proc->thrdstop_context_id = context_id;
    80009888:	fd842703          	lw	a4,-40(s0)
    8000988c:	fe043783          	ld	a5,-32(s0)
    80009890:	c3f8                	sw	a4,68(a5)
  proc->thrdstop_delay = delay;
    80009892:	fdc42703          	lw	a4,-36(s0)
    80009896:	fe043783          	ld	a5,-32(s0)
    8000989a:	c3b8                	sw	a4,64(a5)
  proc->thrdstop_handler_pointer = handler;
    8000989c:	fc843703          	ld	a4,-56(s0)
    800098a0:	fe043783          	ld	a5,-32(s0)
    800098a4:	ebb8                	sd	a4,80(a5)
  proc->thrdstop_ticks = 0;
    800098a6:	fe043783          	ld	a5,-32(s0)
    800098aa:	0207ae23          	sw	zero,60(a5)
  proc->thrdstop_handler_arg = handler_arg;
    800098ae:	fc043703          	ld	a4,-64(s0)
    800098b2:	fe043783          	ld	a5,-32(s0)
    800098b6:	e7b8                	sd	a4,72(a5)

  return 0;
    800098b8:	4781                	li	a5,0
}
    800098ba:	853e                	mv	a0,a5
    800098bc:	70e2                	ld	ra,56(sp)
    800098be:	7442                	ld	s0,48(sp)
    800098c0:	6121                	addi	sp,sp,64
    800098c2:	8082                	ret

00000000800098c4 <sys_cancelthrdstop>:

// for mp3
uint64
sys_cancelthrdstop(void)
{
    800098c4:	7179                	addi	sp,sp,-48
    800098c6:	f406                	sd	ra,40(sp)
    800098c8:	f022                	sd	s0,32(sp)
    800098ca:	1800                	addi	s0,sp,48
  int context_id, is_exit;
  if (argint(0, &context_id) < 0)
    800098cc:	fe040793          	addi	a5,s0,-32
    800098d0:	85be                	mv	a1,a5
    800098d2:	4501                	li	a0,0
    800098d4:	ffffb097          	auipc	ra,0xffffb
    800098d8:	b62080e7          	jalr	-1182(ra) # 80004436 <argint>
    800098dc:	87aa                	mv	a5,a0
    800098de:	0007d463          	bgez	a5,800098e6 <sys_cancelthrdstop+0x22>
    return -1;
    800098e2:	57fd                	li	a5,-1
    800098e4:	a859                	j	8000997a <sys_cancelthrdstop+0xb6>
  if (argint(1, &is_exit) < 0)
    800098e6:	fdc40793          	addi	a5,s0,-36
    800098ea:	85be                	mv	a1,a5
    800098ec:	4505                	li	a0,1
    800098ee:	ffffb097          	auipc	ra,0xffffb
    800098f2:	b48080e7          	jalr	-1208(ra) # 80004436 <argint>
    800098f6:	87aa                	mv	a5,a0
    800098f8:	0007d463          	bgez	a5,80009900 <sys_cancelthrdstop+0x3c>
    return -1;
    800098fc:	57fd                	li	a5,-1
    800098fe:	a8b5                	j	8000997a <sys_cancelthrdstop+0xb6>

  if (context_id < 0 || context_id >= MAX_THRD_NUM) {
    80009900:	fe042783          	lw	a5,-32(s0)
    80009904:	0007c863          	bltz	a5,80009914 <sys_cancelthrdstop+0x50>
    80009908:	fe042783          	lw	a5,-32(s0)
    8000990c:	873e                	mv	a4,a5
    8000990e:	47bd                	li	a5,15
    80009910:	00e7d463          	bge	a5,a4,80009918 <sys_cancelthrdstop+0x54>
    return -1;
    80009914:	57fd                	li	a5,-1
    80009916:	a095                	j	8000997a <sys_cancelthrdstop+0xb6>
  }

  struct proc *proc = myproc();
    80009918:	ffff9097          	auipc	ra,0xffff9
    8000991c:	ee0080e7          	jalr	-288(ra) # 800027f8 <myproc>
    80009920:	fea43423          	sd	a0,-24(s0)

  // cancel previous thrdstop
  int consume_tick = proc->thrdstop_ticks;
    80009924:	fe843783          	ld	a5,-24(s0)
    80009928:	5fdc                	lw	a5,60(a5)
    8000992a:	fef42223          	sw	a5,-28(s0)
  proc->thrdstop_delay = -1;
    8000992e:	fe843783          	ld	a5,-24(s0)
    80009932:	577d                	li	a4,-1
    80009934:	c3b8                	sw	a4,64(a5)

  if (is_exit == 0) {
    80009936:	fdc42783          	lw	a5,-36(s0)
    8000993a:	eb91                	bnez	a5,8000994e <sys_cancelthrdstop+0x8a>
    proc->cancel_save_flag = context_id;
    8000993c:	fe042703          	lw	a4,-32(s0)
    80009940:	fe843683          	ld	a3,-24(s0)
    80009944:	6785                	lui	a5,0x1
    80009946:	97b6                	add	a5,a5,a3
    80009948:	2ae7a023          	sw	a4,672(a5) # 12a0 <_entry-0x7fffed60>
    8000994c:	a02d                	j	80009976 <sys_cancelthrdstop+0xb2>
  } else if (context_id >= 0 && context_id < MAX_THRD_NUM) {
    8000994e:	fe042783          	lw	a5,-32(s0)
    80009952:	0207c263          	bltz	a5,80009976 <sys_cancelthrdstop+0xb2>
    80009956:	fe042783          	lw	a5,-32(s0)
    8000995a:	873e                	mv	a4,a5
    8000995c:	47bd                	li	a5,15
    8000995e:	00e7cc63          	blt	a5,a4,80009976 <sys_cancelthrdstop+0xb2>
    proc->thrdstop_context_used[context_id] = 0;
    80009962:	fe042783          	lw	a5,-32(s0)
    80009966:	fe843703          	ld	a4,-24(s0)
    8000996a:	49478793          	addi	a5,a5,1172
    8000996e:	078a                	slli	a5,a5,0x2
    80009970:	97ba                	add	a5,a5,a4
    80009972:	0007a423          	sw	zero,8(a5)
  }

  return consume_tick;
    80009976:	fe442783          	lw	a5,-28(s0)
}
    8000997a:	853e                	mv	a0,a5
    8000997c:	70a2                	ld	ra,40(sp)
    8000997e:	7402                	ld	s0,32(sp)
    80009980:	6145                	addi	sp,sp,48
    80009982:	8082                	ret

0000000080009984 <sys_thrdresume>:

// for mp3
uint64
sys_thrdresume(void)
{
    80009984:	1101                	addi	sp,sp,-32
    80009986:	ec06                	sd	ra,24(sp)
    80009988:	e822                	sd	s0,16(sp)
    8000998a:	1000                	addi	s0,sp,32
  int context_id;
  if (argint(0, &context_id) < 0)
    8000998c:	fe440793          	addi	a5,s0,-28
    80009990:	85be                	mv	a1,a5
    80009992:	4501                	li	a0,0
    80009994:	ffffb097          	auipc	ra,0xffffb
    80009998:	aa2080e7          	jalr	-1374(ra) # 80004436 <argint>
    8000999c:	87aa                	mv	a5,a0
    8000999e:	0007d463          	bgez	a5,800099a6 <sys_thrdresume+0x22>
    return -1;
    800099a2:	57fd                	li	a5,-1
    800099a4:	a825                	j	800099dc <sys_thrdresume+0x58>

  struct proc *proc = myproc();
    800099a6:	ffff9097          	auipc	ra,0xffff9
    800099aa:	e52080e7          	jalr	-430(ra) # 800027f8 <myproc>
    800099ae:	fea43423          	sd	a0,-24(s0)

  if (context_id < 0 || context_id >= MAX_THRD_NUM)
    800099b2:	fe442783          	lw	a5,-28(s0)
    800099b6:	0007c863          	bltz	a5,800099c6 <sys_thrdresume+0x42>
    800099ba:	fe442783          	lw	a5,-28(s0)
    800099be:	873e                	mv	a4,a5
    800099c0:	47bd                	li	a5,15
    800099c2:	00e7d463          	bge	a5,a4,800099ca <sys_thrdresume+0x46>
    return -1;
    800099c6:	57fd                	li	a5,-1
    800099c8:	a811                	j	800099dc <sys_thrdresume+0x58>

  proc->resume_flag = context_id;
    800099ca:	fe442703          	lw	a4,-28(s0)
    800099ce:	fe843683          	ld	a3,-24(s0)
    800099d2:	6785                	lui	a5,0x1
    800099d4:	97b6                	add	a5,a5,a3
    800099d6:	28e7ae23          	sw	a4,668(a5) # 129c <_entry-0x7fffed64>

  return 0;
    800099da:	4781                	li	a5,0
}
    800099dc:	853e                	mv	a0,a5
    800099de:	60e2                	ld	ra,24(sp)
    800099e0:	6442                	ld	s0,16(sp)
    800099e2:	6105                	addi	sp,sp,32
    800099e4:	8082                	ret
	...

000000008000a000 <_trampoline>:
    8000a000:	14051573          	csrrw	a0,sscratch,a0
    8000a004:	02153423          	sd	ra,40(a0)
    8000a008:	02253823          	sd	sp,48(a0)
    8000a00c:	02353c23          	sd	gp,56(a0)
    8000a010:	04453023          	sd	tp,64(a0)
    8000a014:	04553423          	sd	t0,72(a0)
    8000a018:	04653823          	sd	t1,80(a0)
    8000a01c:	04753c23          	sd	t2,88(a0)
    8000a020:	f120                	sd	s0,96(a0)
    8000a022:	f524                	sd	s1,104(a0)
    8000a024:	fd2c                	sd	a1,120(a0)
    8000a026:	e150                	sd	a2,128(a0)
    8000a028:	e554                	sd	a3,136(a0)
    8000a02a:	e958                	sd	a4,144(a0)
    8000a02c:	ed5c                	sd	a5,152(a0)
    8000a02e:	0b053023          	sd	a6,160(a0)
    8000a032:	0b153423          	sd	a7,168(a0)
    8000a036:	0b253823          	sd	s2,176(a0)
    8000a03a:	0b353c23          	sd	s3,184(a0)
    8000a03e:	0d453023          	sd	s4,192(a0)
    8000a042:	0d553423          	sd	s5,200(a0)
    8000a046:	0d653823          	sd	s6,208(a0)
    8000a04a:	0d753c23          	sd	s7,216(a0)
    8000a04e:	0f853023          	sd	s8,224(a0)
    8000a052:	0f953423          	sd	s9,232(a0)
    8000a056:	0fa53823          	sd	s10,240(a0)
    8000a05a:	0fb53c23          	sd	s11,248(a0)
    8000a05e:	11c53023          	sd	t3,256(a0)
    8000a062:	11d53423          	sd	t4,264(a0)
    8000a066:	11e53823          	sd	t5,272(a0)
    8000a06a:	11f53c23          	sd	t6,280(a0)
    8000a06e:	140022f3          	csrr	t0,sscratch
    8000a072:	06553823          	sd	t0,112(a0)
    8000a076:	00853103          	ld	sp,8(a0)
    8000a07a:	02053203          	ld	tp,32(a0)
    8000a07e:	01053283          	ld	t0,16(a0)
    8000a082:	00053303          	ld	t1,0(a0)
    8000a086:	18031073          	csrw	satp,t1
    8000a08a:	12000073          	sfence.vma
    8000a08e:	8282                	jr	t0

000000008000a090 <userret>:
    8000a090:	18059073          	csrw	satp,a1
    8000a094:	12000073          	sfence.vma
    8000a098:	07053283          	ld	t0,112(a0)
    8000a09c:	14029073          	csrw	sscratch,t0
    8000a0a0:	02853083          	ld	ra,40(a0)
    8000a0a4:	03053103          	ld	sp,48(a0)
    8000a0a8:	03853183          	ld	gp,56(a0)
    8000a0ac:	04053203          	ld	tp,64(a0)
    8000a0b0:	04853283          	ld	t0,72(a0)
    8000a0b4:	05053303          	ld	t1,80(a0)
    8000a0b8:	05853383          	ld	t2,88(a0)
    8000a0bc:	7120                	ld	s0,96(a0)
    8000a0be:	7524                	ld	s1,104(a0)
    8000a0c0:	7d2c                	ld	a1,120(a0)
    8000a0c2:	6150                	ld	a2,128(a0)
    8000a0c4:	6554                	ld	a3,136(a0)
    8000a0c6:	6958                	ld	a4,144(a0)
    8000a0c8:	6d5c                	ld	a5,152(a0)
    8000a0ca:	0a053803          	ld	a6,160(a0)
    8000a0ce:	0a853883          	ld	a7,168(a0)
    8000a0d2:	0b053903          	ld	s2,176(a0)
    8000a0d6:	0b853983          	ld	s3,184(a0)
    8000a0da:	0c053a03          	ld	s4,192(a0)
    8000a0de:	0c853a83          	ld	s5,200(a0)
    8000a0e2:	0d053b03          	ld	s6,208(a0)
    8000a0e6:	0d853b83          	ld	s7,216(a0)
    8000a0ea:	0e053c03          	ld	s8,224(a0)
    8000a0ee:	0e853c83          	ld	s9,232(a0)
    8000a0f2:	0f053d03          	ld	s10,240(a0)
    8000a0f6:	0f853d83          	ld	s11,248(a0)
    8000a0fa:	10053e03          	ld	t3,256(a0)
    8000a0fe:	10853e83          	ld	t4,264(a0)
    8000a102:	11053f03          	ld	t5,272(a0)
    8000a106:	11853f83          	ld	t6,280(a0)
    8000a10a:	14051573          	csrrw	a0,sscratch,a0
    8000a10e:	10200073          	sret
	...
