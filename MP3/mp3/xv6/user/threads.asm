
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
       0:	7179                	addi	sp,sp,-48
       2:	f422                	sd	s0,40(sp)
       4:	1800                	addi	s0,sp,48
       6:	fea43423          	sd	a0,-24(s0)
       a:	feb43023          	sd	a1,-32(s0)
       e:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
      12:	fd843783          	ld	a5,-40(s0)
      16:	fe843703          	ld	a4,-24(s0)
      1a:	e798                	sd	a4,8(a5)
    new_entry->next = next;
      1c:	fe843783          	ld	a5,-24(s0)
      20:	fd843703          	ld	a4,-40(s0)
      24:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
      26:	fe843783          	ld	a5,-24(s0)
      2a:	fe043703          	ld	a4,-32(s0)
      2e:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
      30:	fe043783          	ld	a5,-32(s0)
      34:	fe843703          	ld	a4,-24(s0)
      38:	e398                	sd	a4,0(a5)
}
      3a:	0001                	nop
      3c:	7422                	ld	s0,40(sp)
      3e:	6145                	addi	sp,sp,48
      40:	8082                	ret

0000000000000042 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
      42:	1101                	addi	sp,sp,-32
      44:	ec06                	sd	ra,24(sp)
      46:	e822                	sd	s0,16(sp)
      48:	1000                	addi	s0,sp,32
      4a:	fea43423          	sd	a0,-24(s0)
      4e:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
      52:	fe043783          	ld	a5,-32(s0)
      56:	679c                	ld	a5,8(a5)
      58:	fe043603          	ld	a2,-32(s0)
      5c:	85be                	mv	a1,a5
      5e:	fe843503          	ld	a0,-24(s0)
      62:	00000097          	auipc	ra,0x0
      66:	f9e080e7          	jalr	-98(ra) # 0 <__list_add>
}
      6a:	0001                	nop
      6c:	60e2                	ld	ra,24(sp)
      6e:	6442                	ld	s0,16(sp)
      70:	6105                	addi	sp,sp,32
      72:	8082                	ret

0000000000000074 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
      82:	fe043783          	ld	a5,-32(s0)
      86:	fe843703          	ld	a4,-24(s0)
      8a:	e798                	sd	a4,8(a5)
    prev->next = next;
      8c:	fe843783          	ld	a5,-24(s0)
      90:	fe043703          	ld	a4,-32(s0)
      94:	e398                	sd	a4,0(a5)
}
      96:	0001                	nop
      98:	6462                	ld	s0,24(sp)
      9a:	6105                	addi	sp,sp,32
      9c:	8082                	ret

000000000000009e <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
      9e:	1101                	addi	sp,sp,-32
      a0:	ec06                	sd	ra,24(sp)
      a2:	e822                	sd	s0,16(sp)
      a4:	1000                	addi	s0,sp,32
      a6:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
      aa:	fe843783          	ld	a5,-24(s0)
      ae:	6798                	ld	a4,8(a5)
      b0:	fe843783          	ld	a5,-24(s0)
      b4:	639c                	ld	a5,0(a5)
      b6:	85be                	mv	a1,a5
      b8:	853a                	mv	a0,a4
      ba:	00000097          	auipc	ra,0x0
      be:	fba080e7          	jalr	-70(ra) # 74 <__list_del>
    entry->next = LIST_POISON1;
      c2:	fe843783          	ld	a5,-24(s0)
      c6:	00100737          	lui	a4,0x100
      ca:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd880>
      ce:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
      d0:	fe843783          	ld	a5,-24(s0)
      d4:	00200737          	lui	a4,0x200
      d8:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd980>
      dc:	e798                	sd	a4,8(a5)
}
      de:	0001                	nop
      e0:	60e2                	ld	ra,24(sp)
      e2:	6442                	ld	s0,16(sp)
      e4:	6105                	addi	sp,sp,32
      e6:	8082                	ret

00000000000000e8 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
      e8:	1101                	addi	sp,sp,-32
      ea:	ec22                	sd	s0,24(sp)
      ec:	1000                	addi	s0,sp,32
      ee:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
      f2:	fe843783          	ld	a5,-24(s0)
      f6:	639c                	ld	a5,0(a5)
      f8:	fe843703          	ld	a4,-24(s0)
      fc:	40f707b3          	sub	a5,a4,a5
     100:	0017b793          	seqz	a5,a5
     104:	0ff7f793          	andi	a5,a5,255
     108:	2781                	sext.w	a5,a5
}
     10a:	853e                	mv	a0,a5
     10c:	6462                	ld	s0,24(sp)
     10e:	6105                	addi	sp,sp,32
     110:	8082                	ret

0000000000000112 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     112:	715d                	addi	sp,sp,-80
     114:	e486                	sd	ra,72(sp)
     116:	e0a2                	sd	s0,64(sp)
     118:	0880                	addi	s0,sp,80
     11a:	fca43423          	sd	a0,-56(s0)
     11e:	fcb43023          	sd	a1,-64(s0)
     122:	85b2                	mv	a1,a2
     124:	8636                	mv	a2,a3
     126:	86ba                	mv	a3,a4
     128:	873e                	mv	a4,a5
     12a:	87ae                	mv	a5,a1
     12c:	faf42e23          	sw	a5,-68(s0)
     130:	87b2                	mv	a5,a2
     132:	faf42c23          	sw	a5,-72(s0)
     136:	87b6                	mv	a5,a3
     138:	faf42a23          	sw	a5,-76(s0)
     13c:	87ba                	mv	a5,a4
     13e:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     142:	08000513          	li	a0,128
     146:	00001097          	auipc	ra,0x1
     14a:	6cc080e7          	jalr	1740(ra) # 1812 <malloc>
     14e:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     152:	6505                	lui	a0,0x1
     154:	00001097          	auipc	ra,0x1
     158:	6be080e7          	jalr	1726(ra) # 1812 <malloc>
     15c:	87aa                	mv	a5,a0
     15e:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     162:	fe043703          	ld	a4,-32(s0)
     166:	6785                	lui	a5,0x1
     168:	17c1                	addi	a5,a5,-16
     16a:	97ba                	add	a5,a5,a4
     16c:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     170:	fe843783          	ld	a5,-24(s0)
     174:	fc843703          	ld	a4,-56(s0)
     178:	e398                	sd	a4,0(a5)
    t->arg = arg;
     17a:	fe843783          	ld	a5,-24(s0)
     17e:	fc043703          	ld	a4,-64(s0)
     182:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     184:	00002797          	auipc	a5,0x2
     188:	f3478793          	addi	a5,a5,-204 # 20b8 <_id.1239>
     18c:	439c                	lw	a5,0(a5)
     18e:	0017871b          	addiw	a4,a5,1
     192:	0007069b          	sext.w	a3,a4
     196:	00002717          	auipc	a4,0x2
     19a:	f2270713          	addi	a4,a4,-222 # 20b8 <_id.1239>
     19e:	c314                	sw	a3,0(a4)
     1a0:	fe843703          	ld	a4,-24(s0)
     1a4:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
     1ae:	fe043703          	ld	a4,-32(s0)
     1b2:	fe843783          	ld	a5,-24(s0)
     1b6:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
     1b8:	fd843703          	ld	a4,-40(s0)
     1bc:	fe843783          	ld	a5,-24(s0)
     1c0:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
     1c2:	fe843783          	ld	a5,-24(s0)
     1c6:	fb842703          	lw	a4,-72(s0)
     1ca:	c3f8                	sw	a4,68(a5)
    t->period = period;
     1cc:	fe843783          	ld	a5,-24(s0)
     1d0:	fb442703          	lw	a4,-76(s0)
     1d4:	c7f8                	sw	a4,76(a5)
    t->deadline = period;
     1d6:	fe843783          	ld	a5,-24(s0)
     1da:	fb442703          	lw	a4,-76(s0)
     1de:	c7b8                	sw	a4,72(a5)
    t->n = n;
     1e0:	fe843783          	ld	a5,-24(s0)
     1e4:	fb042703          	lw	a4,-80(s0)
     1e8:	cbb8                	sw	a4,80(a5)
    t->is_real_time = is_real_time;
     1ea:	fe843783          	ld	a5,-24(s0)
     1ee:	fbc42703          	lw	a4,-68(s0)
     1f2:	c3b8                	sw	a4,64(a5)
    t->remaining_time = processing_time;
     1f4:	fe843783          	ld	a5,-24(s0)
     1f8:	fb842703          	lw	a4,-72(s0)
     1fc:	cbf8                	sw	a4,84(a5)
    t->current_deadline = 0;
     1fe:	fe843783          	ld	a5,-24(s0)
     202:	0407ac23          	sw	zero,88(a5)
    t->priority = 100;
     206:	fe843783          	ld	a5,-24(s0)
     20a:	06400713          	li	a4,100
     20e:	cff8                	sw	a4,92(a5)
    t->arrival_time = 30000;
     210:	fe843783          	ld	a5,-24(s0)
     214:	671d                	lui	a4,0x7
     216:	5307071b          	addiw	a4,a4,1328
     21a:	d3b8                	sw	a4,96(a5)
    
    return t;
     21c:	fe843783          	ld	a5,-24(s0)
}
     220:	853e                	mv	a0,a5
     222:	60a6                	ld	ra,72(sp)
     224:	6406                	ld	s0,64(sp)
     226:	6161                	addi	sp,sp,80
     228:	8082                	ret

000000000000022a <thread_set_priority>:

void thread_set_priority(struct thread *t, int priority)
{
     22a:	1101                	addi	sp,sp,-32
     22c:	ec22                	sd	s0,24(sp)
     22e:	1000                	addi	s0,sp,32
     230:	fea43423          	sd	a0,-24(s0)
     234:	87ae                	mv	a5,a1
     236:	fef42223          	sw	a5,-28(s0)
    t->priority = priority;
     23a:	fe843783          	ld	a5,-24(s0)
     23e:	fe442703          	lw	a4,-28(s0)
     242:	cff8                	sw	a4,92(a5)
}
     244:	0001                	nop
     246:	6462                	ld	s0,24(sp)
     248:	6105                	addi	sp,sp,32
     24a:	8082                	ret

000000000000024c <init_thread_cbs>:
void init_thread_cbs(struct thread *t, int budget, int is_hard_rt)
{
     24c:	1101                	addi	sp,sp,-32
     24e:	ec22                	sd	s0,24(sp)
     250:	1000                	addi	s0,sp,32
     252:	fea43423          	sd	a0,-24(s0)
     256:	87ae                	mv	a5,a1
     258:	8732                	mv	a4,a2
     25a:	fef42223          	sw	a5,-28(s0)
     25e:	87ba                	mv	a5,a4
     260:	fef42023          	sw	a5,-32(s0)
    t->cbs.budget = budget;
     264:	fe843783          	ld	a5,-24(s0)
     268:	fe442703          	lw	a4,-28(s0)
     26c:	d3f8                	sw	a4,100(a5)
    t->cbs.remaining_budget = budget; 
     26e:	fe843783          	ld	a5,-24(s0)
     272:	fe442703          	lw	a4,-28(s0)
     276:	d7b8                	sw	a4,104(a5)
    t->cbs.is_hard_rt = is_hard_rt;
     278:	fe843783          	ld	a5,-24(s0)
     27c:	fe042703          	lw	a4,-32(s0)
     280:	d7f8                	sw	a4,108(a5)
    t->cbs.is_throttled = 0;
     282:	fe843783          	ld	a5,-24(s0)
     286:	0607a823          	sw	zero,112(a5)
    t->cbs.throttled_arrived_time = 0;
     28a:	fe843783          	ld	a5,-24(s0)
     28e:	0607aa23          	sw	zero,116(a5)
    t->cbs.throttle_new_deadline = 0;
     292:	fe843783          	ld	a5,-24(s0)
     296:	0607ac23          	sw	zero,120(a5)
}
     29a:	0001                	nop
     29c:	6462                	ld	s0,24(sp)
     29e:	6105                	addi	sp,sp,32
     2a0:	8082                	ret

00000000000002a2 <thread_add_at>:
void thread_add_at(struct thread *t, int arrival_time)
{
     2a2:	7179                	addi	sp,sp,-48
     2a4:	f406                	sd	ra,40(sp)
     2a6:	f022                	sd	s0,32(sp)
     2a8:	1800                	addi	s0,sp,48
     2aa:	fca43c23          	sd	a0,-40(s0)
     2ae:	87ae                	mv	a5,a1
     2b0:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
     2b4:	02000513          	li	a0,32
     2b8:	00001097          	auipc	ra,0x1
     2bc:	55a080e7          	jalr	1370(ra) # 1812 <malloc>
     2c0:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
     2c4:	fe843783          	ld	a5,-24(s0)
     2c8:	fd843703          	ld	a4,-40(s0)
     2cc:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
     2ce:	fe843783          	ld	a5,-24(s0)
     2d2:	fd442703          	lw	a4,-44(s0)
     2d6:	cf98                	sw	a4,24(a5)
    t->arrival_time = arrival_time;
     2d8:	fd843783          	ld	a5,-40(s0)
     2dc:	fd442703          	lw	a4,-44(s0)
     2e0:	d3b8                	sw	a4,96(a5)
    // t->remaining_time = t->processing_time;
    if (t->is_real_time) {
     2e2:	fd843783          	ld	a5,-40(s0)
     2e6:	43bc                	lw	a5,64(a5)
     2e8:	c395                	beqz	a5,30c <thread_add_at+0x6a>
        t->remaining_time = t->processing_time;  // Reset remaining time for next period
     2ea:	fd843783          	ld	a5,-40(s0)
     2ee:	43f8                	lw	a4,68(a5)
     2f0:	fd843783          	ld	a5,-40(s0)
     2f4:	cbf8                	sw	a4,84(a5)
        t->current_deadline = arrival_time + t->period;  // Use period instead of deadline for next period
     2f6:	fd843783          	ld	a5,-40(s0)
     2fa:	47fc                	lw	a5,76(a5)
     2fc:	fd442703          	lw	a4,-44(s0)
     300:	9fb9                	addw	a5,a5,a4
     302:	0007871b          	sext.w	a4,a5
     306:	fd843783          	ld	a5,-40(s0)
     30a:	cfb8                	sw	a4,88(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
     30c:	fe843783          	ld	a5,-24(s0)
     310:	07a1                	addi	a5,a5,8
     312:	00002597          	auipc	a1,0x2
     316:	d7e58593          	addi	a1,a1,-642 # 2090 <release_queue>
     31a:	853e                	mv	a0,a5
     31c:	00000097          	auipc	ra,0x0
     320:	d26080e7          	jalr	-730(ra) # 42 <list_add_tail>
}
     324:	0001                	nop
     326:	70a2                	ld	ra,40(sp)
     328:	7402                	ld	s0,32(sp)
     32a:	6145                	addi	sp,sp,48
     32c:	8082                	ret

000000000000032e <__release>:

void __release()
{
     32e:	7139                	addi	sp,sp,-64
     330:	fc06                	sd	ra,56(sp)
     332:	f822                	sd	s0,48(sp)
     334:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     336:	00002797          	auipc	a5,0x2
     33a:	d5a78793          	addi	a5,a5,-678 # 2090 <release_queue>
     33e:	639c                	ld	a5,0(a5)
     340:	fcf43c23          	sd	a5,-40(s0)
     344:	fd843783          	ld	a5,-40(s0)
     348:	17e1                	addi	a5,a5,-8
     34a:	fef43423          	sd	a5,-24(s0)
     34e:	fe843783          	ld	a5,-24(s0)
     352:	679c                	ld	a5,8(a5)
     354:	fcf43823          	sd	a5,-48(s0)
     358:	fd043783          	ld	a5,-48(s0)
     35c:	17e1                	addi	a5,a5,-8
     35e:	fef43023          	sd	a5,-32(s0)
     362:	a851                	j	3f6 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
     364:	fe843783          	ld	a5,-24(s0)
     368:	4f98                	lw	a4,24(a5)
     36a:	00002797          	auipc	a5,0x2
     36e:	d5e78793          	addi	a5,a5,-674 # 20c8 <threading_system_time>
     372:	439c                	lw	a5,0(a5)
     374:	06e7c363          	blt	a5,a4,3da <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
     378:	fe843783          	ld	a5,-24(s0)
     37c:	6398                	ld	a4,0(a5)
     37e:	fe843783          	ld	a5,-24(s0)
     382:	639c                	ld	a5,0(a5)
     384:	4378                	lw	a4,68(a4)
     386:	cbf8                	sw	a4,84(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
     388:	fe843783          	ld	a5,-24(s0)
     38c:	4f94                	lw	a3,24(a5)
     38e:	fe843783          	ld	a5,-24(s0)
     392:	639c                	ld	a5,0(a5)
     394:	47b8                	lw	a4,72(a5)
     396:	fe843783          	ld	a5,-24(s0)
     39a:	639c                	ld	a5,0(a5)
     39c:	9f35                	addw	a4,a4,a3
     39e:	2701                	sext.w	a4,a4
     3a0:	cfb8                	sw	a4,88(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
     3a2:	fe843783          	ld	a5,-24(s0)
     3a6:	639c                	ld	a5,0(a5)
     3a8:	02878793          	addi	a5,a5,40
     3ac:	00002597          	auipc	a1,0x2
     3b0:	cd458593          	addi	a1,a1,-812 # 2080 <run_queue>
     3b4:	853e                	mv	a0,a5
     3b6:	00000097          	auipc	ra,0x0
     3ba:	c8c080e7          	jalr	-884(ra) # 42 <list_add_tail>
            list_del(&cur->thread_list);
     3be:	fe843783          	ld	a5,-24(s0)
     3c2:	07a1                	addi	a5,a5,8
     3c4:	853e                	mv	a0,a5
     3c6:	00000097          	auipc	ra,0x0
     3ca:	cd8080e7          	jalr	-808(ra) # 9e <list_del>
            free(cur);
     3ce:	fe843503          	ld	a0,-24(s0)
     3d2:	00001097          	auipc	ra,0x1
     3d6:	29e080e7          	jalr	670(ra) # 1670 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     3da:	fe043783          	ld	a5,-32(s0)
     3de:	fef43423          	sd	a5,-24(s0)
     3e2:	fe043783          	ld	a5,-32(s0)
     3e6:	679c                	ld	a5,8(a5)
     3e8:	fcf43423          	sd	a5,-56(s0)
     3ec:	fc843783          	ld	a5,-56(s0)
     3f0:	17e1                	addi	a5,a5,-8
     3f2:	fef43023          	sd	a5,-32(s0)
     3f6:	fe843783          	ld	a5,-24(s0)
     3fa:	00878713          	addi	a4,a5,8
     3fe:	00002797          	auipc	a5,0x2
     402:	c9278793          	addi	a5,a5,-878 # 2090 <release_queue>
     406:	f4f71fe3          	bne	a4,a5,364 <__release+0x36>
        }
    }
}
     40a:	0001                	nop
     40c:	0001                	nop
     40e:	70e2                	ld	ra,56(sp)
     410:	7442                	ld	s0,48(sp)
     412:	6121                	addi	sp,sp,64
     414:	8082                	ret

0000000000000416 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
     416:	1101                	addi	sp,sp,-32
     418:	ec06                	sd	ra,24(sp)
     41a:	e822                	sd	s0,16(sp)
     41c:	1000                	addi	s0,sp,32
     41e:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
     422:	fe843783          	ld	a5,-24(s0)
     426:	7b98                	ld	a4,48(a5)
     428:	00002797          	auipc	a5,0x2
     42c:	c9878793          	addi	a5,a5,-872 # 20c0 <current>
     430:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
     432:	fe843783          	ld	a5,-24(s0)
     436:	02878793          	addi	a5,a5,40
     43a:	853e                	mv	a0,a5
     43c:	00000097          	auipc	ra,0x0
     440:	c62080e7          	jalr	-926(ra) # 9e <list_del>

    free(to_remove->stack);
     444:	fe843783          	ld	a5,-24(s0)
     448:	6b9c                	ld	a5,16(a5)
     44a:	853e                	mv	a0,a5
     44c:	00001097          	auipc	ra,0x1
     450:	224080e7          	jalr	548(ra) # 1670 <free>
    free(to_remove);
     454:	fe843503          	ld	a0,-24(s0)
     458:	00001097          	auipc	ra,0x1
     45c:	218080e7          	jalr	536(ra) # 1670 <free>

    __schedule();
     460:	00000097          	auipc	ra,0x0
     464:	5ae080e7          	jalr	1454(ra) # a0e <__schedule>
    __dispatch();
     468:	00000097          	auipc	ra,0x0
     46c:	416080e7          	jalr	1046(ra) # 87e <__dispatch>
    thrdresume(main_thrd_id);
     470:	00002797          	auipc	a5,0x2
     474:	c4478793          	addi	a5,a5,-956 # 20b4 <main_thrd_id>
     478:	439c                	lw	a5,0(a5)
     47a:	853e                	mv	a0,a5
     47c:	00001097          	auipc	ra,0x1
     480:	d06080e7          	jalr	-762(ra) # 1182 <thrdresume>
}
     484:	0001                	nop
     486:	60e2                	ld	ra,24(sp)
     488:	6442                	ld	s0,16(sp)
     48a:	6105                	addi	sp,sp,32
     48c:	8082                	ret

000000000000048e <thread_exit>:

void thread_exit(void)
{
     48e:	7179                	addi	sp,sp,-48
     490:	f406                	sd	ra,40(sp)
     492:	f022                	sd	s0,32(sp)
     494:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     496:	00002797          	auipc	a5,0x2
     49a:	c2a78793          	addi	a5,a5,-982 # 20c0 <current>
     49e:	6398                	ld	a4,0(a5)
     4a0:	00002797          	auipc	a5,0x2
     4a4:	be078793          	addi	a5,a5,-1056 # 2080 <run_queue>
     4a8:	02f71063          	bne	a4,a5,4c8 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
     4ac:	00002597          	auipc	a1,0x2
     4b0:	a5458593          	addi	a1,a1,-1452 # 1f00 <schedule_edf_cbs+0x410>
     4b4:	4509                	li	a0,2
     4b6:	00001097          	auipc	ra,0x1
     4ba:	112080e7          	jalr	274(ra) # 15c8 <fprintf>
        exit(1);
     4be:	4505                	li	a0,1
     4c0:	00001097          	auipc	ra,0x1
     4c4:	c1a080e7          	jalr	-998(ra) # 10da <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
     4c8:	00002797          	auipc	a5,0x2
     4cc:	bf878793          	addi	a5,a5,-1032 # 20c0 <current>
     4d0:	639c                	ld	a5,0(a5)
     4d2:	fef43423          	sd	a5,-24(s0)
     4d6:	fe843783          	ld	a5,-24(s0)
     4da:	fd878793          	addi	a5,a5,-40
     4de:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
     4e2:	fe043783          	ld	a5,-32(s0)
     4e6:	5f9c                	lw	a5,56(a5)
     4e8:	4585                	li	a1,1
     4ea:	853e                	mv	a0,a5
     4ec:	00001097          	auipc	ra,0x1
     4f0:	c9e080e7          	jalr	-866(ra) # 118a <cancelthrdstop>
     4f4:	87aa                	mv	a5,a0
     4f6:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
     4fa:	00002797          	auipc	a5,0x2
     4fe:	bce78793          	addi	a5,a5,-1074 # 20c8 <threading_system_time>
     502:	439c                	lw	a5,0(a5)
     504:	fdc42703          	lw	a4,-36(s0)
     508:	9fb9                	addw	a5,a5,a4
     50a:	0007871b          	sext.w	a4,a5
     50e:	00002797          	auipc	a5,0x2
     512:	bba78793          	addi	a5,a5,-1094 # 20c8 <threading_system_time>
     516:	c398                	sw	a4,0(a5)

    __release();
     518:	00000097          	auipc	ra,0x0
     51c:	e16080e7          	jalr	-490(ra) # 32e <__release>
    __thread_exit(to_remove);
     520:	fe043503          	ld	a0,-32(s0)
     524:	00000097          	auipc	ra,0x0
     528:	ef2080e7          	jalr	-270(ra) # 416 <__thread_exit>
}
     52c:	0001                	nop
     52e:	70a2                	ld	ra,40(sp)
     530:	7402                	ld	s0,32(sp)
     532:	6145                	addi	sp,sp,48
     534:	8082                	ret

0000000000000536 <__finish_current>:

void __finish_current()
{
     536:	7179                	addi	sp,sp,-48
     538:	f406                	sd	ra,40(sp)
     53a:	f022                	sd	s0,32(sp)
     53c:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     53e:	00002797          	auipc	a5,0x2
     542:	b8278793          	addi	a5,a5,-1150 # 20c0 <current>
     546:	639c                	ld	a5,0(a5)
     548:	fef43423          	sd	a5,-24(s0)
     54c:	fe843783          	ld	a5,-24(s0)
     550:	fd878793          	addi	a5,a5,-40
     554:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
     558:	fe043783          	ld	a5,-32(s0)
     55c:	4bbc                	lw	a5,80(a5)
     55e:	37fd                	addiw	a5,a5,-1
     560:	0007871b          	sext.w	a4,a5
     564:	fe043783          	ld	a5,-32(s0)
     568:	cbb8                	sw	a4,80(a5)

    printf("thread#%d finish at %d\n",
     56a:	fe043783          	ld	a5,-32(s0)
     56e:	5fd8                	lw	a4,60(a5)
     570:	00002797          	auipc	a5,0x2
     574:	b5878793          	addi	a5,a5,-1192 # 20c8 <threading_system_time>
     578:	4390                	lw	a2,0(a5)
     57a:	fe043783          	ld	a5,-32(s0)
     57e:	4bbc                	lw	a5,80(a5)
     580:	86be                	mv	a3,a5
     582:	85ba                	mv	a1,a4
     584:	00002517          	auipc	a0,0x2
     588:	9b450513          	addi	a0,a0,-1612 # 1f38 <schedule_edf_cbs+0x448>
     58c:	00001097          	auipc	ra,0x1
     590:	094080e7          	jalr	148(ra) # 1620 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
     594:	fe043783          	ld	a5,-32(s0)
     598:	4bbc                	lw	a5,80(a5)
     59a:	04f05563          	blez	a5,5e4 <__finish_current+0xae>
        struct list_head *to_remove = current;
     59e:	00002797          	auipc	a5,0x2
     5a2:	b2278793          	addi	a5,a5,-1246 # 20c0 <current>
     5a6:	639c                	ld	a5,0(a5)
     5a8:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
     5ac:	00002797          	auipc	a5,0x2
     5b0:	b1478793          	addi	a5,a5,-1260 # 20c0 <current>
     5b4:	639c                	ld	a5,0(a5)
     5b6:	6798                	ld	a4,8(a5)
     5b8:	00002797          	auipc	a5,0x2
     5bc:	b0878793          	addi	a5,a5,-1272 # 20c0 <current>
     5c0:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     5c2:	fd843503          	ld	a0,-40(s0)
     5c6:	00000097          	auipc	ra,0x0
     5ca:	ad8080e7          	jalr	-1320(ra) # 9e <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
     5ce:	fe043783          	ld	a5,-32(s0)
     5d2:	4fbc                	lw	a5,88(a5)
     5d4:	85be                	mv	a1,a5
     5d6:	fe043503          	ld	a0,-32(s0)
     5da:	00000097          	auipc	ra,0x0
     5de:	cc8080e7          	jalr	-824(ra) # 2a2 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
     5e2:	a039                	j	5f0 <__finish_current+0xba>
        __thread_exit(current_thread);
     5e4:	fe043503          	ld	a0,-32(s0)
     5e8:	00000097          	auipc	ra,0x0
     5ec:	e2e080e7          	jalr	-466(ra) # 416 <__thread_exit>
}
     5f0:	0001                	nop
     5f2:	70a2                	ld	ra,40(sp)
     5f4:	7402                	ld	s0,32(sp)
     5f6:	6145                	addi	sp,sp,48
     5f8:	8082                	ret

00000000000005fa <__rt_finish_current>:
void __rt_finish_current()
{
     5fa:	7179                	addi	sp,sp,-48
     5fc:	f406                	sd	ra,40(sp)
     5fe:	f022                	sd	s0,32(sp)
     600:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     602:	00002797          	auipc	a5,0x2
     606:	abe78793          	addi	a5,a5,-1346 # 20c0 <current>
     60a:	639c                	ld	a5,0(a5)
     60c:	fef43423          	sd	a5,-24(s0)
     610:	fe843783          	ld	a5,-24(s0)
     614:	fd878793          	addi	a5,a5,-40
     618:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
     61c:	fe043783          	ld	a5,-32(s0)
     620:	4bbc                	lw	a5,80(a5)
     622:	37fd                	addiw	a5,a5,-1
     624:	0007871b          	sext.w	a4,a5
     628:	fe043783          	ld	a5,-32(s0)
     62c:	cbb8                	sw	a4,80(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
     62e:	fe043783          	ld	a5,-32(s0)
     632:	5fd8                	lw	a4,60(a5)
     634:	00002797          	auipc	a5,0x2
     638:	a9478793          	addi	a5,a5,-1388 # 20c8 <threading_system_time>
     63c:	4390                	lw	a2,0(a5)
     63e:	fe043783          	ld	a5,-32(s0)
     642:	4bbc                	lw	a5,80(a5)
     644:	86be                	mv	a3,a5
     646:	85ba                	mv	a1,a4
     648:	00002517          	auipc	a0,0x2
     64c:	90850513          	addi	a0,a0,-1784 # 1f50 <schedule_edf_cbs+0x460>
     650:	00001097          	auipc	ra,0x1
     654:	fd0080e7          	jalr	-48(ra) # 1620 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
     658:	fe043783          	ld	a5,-32(s0)
     65c:	4bbc                	lw	a5,80(a5)
     65e:	04f05f63          	blez	a5,6bc <__rt_finish_current+0xc2>
        struct list_head *to_remove = current;
     662:	00002797          	auipc	a5,0x2
     666:	a5e78793          	addi	a5,a5,-1442 # 20c0 <current>
     66a:	639c                	ld	a5,0(a5)
     66c:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
     670:	00002797          	auipc	a5,0x2
     674:	a5078793          	addi	a5,a5,-1456 # 20c0 <current>
     678:	639c                	ld	a5,0(a5)
     67a:	6798                	ld	a4,8(a5)
     67c:	00002797          	auipc	a5,0x2
     680:	a4478793          	addi	a5,a5,-1468 # 20c0 <current>
     684:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     686:	fd843503          	ld	a0,-40(s0)
     68a:	00000097          	auipc	ra,0x0
     68e:	a14080e7          	jalr	-1516(ra) # 9e <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
     692:	fe043783          	ld	a5,-32(s0)
     696:	4fbc                	lw	a5,88(a5)
     698:	85be                	mv	a1,a5
     69a:	fe043503          	ld	a0,-32(s0)
     69e:	00000097          	auipc	ra,0x0
     6a2:	c04080e7          	jalr	-1020(ra) # 2a2 <thread_add_at>
        if (!current_thread->cbs.is_hard_rt) {
     6a6:	fe043783          	ld	a5,-32(s0)
     6aa:	57fc                	lw	a5,108(a5)
     6ac:	ef91                	bnez	a5,6c8 <__rt_finish_current+0xce>
            current_thread->cbs.remaining_budget = current_thread->cbs.budget;
     6ae:	fe043783          	ld	a5,-32(s0)
     6b2:	53f8                	lw	a4,100(a5)
     6b4:	fe043783          	ld	a5,-32(s0)
     6b8:	d7b8                	sw	a4,104(a5)
        }
    } else {
        __thread_exit(current_thread);
    }
}
     6ba:	a039                	j	6c8 <__rt_finish_current+0xce>
        __thread_exit(current_thread);
     6bc:	fe043503          	ld	a0,-32(s0)
     6c0:	00000097          	auipc	ra,0x0
     6c4:	d56080e7          	jalr	-682(ra) # 416 <__thread_exit>
}
     6c8:	0001                	nop
     6ca:	70a2                	ld	ra,40(sp)
     6cc:	7402                	ld	s0,32(sp)
     6ce:	6145                	addi	sp,sp,48
     6d0:	8082                	ret

00000000000006d2 <switch_handler>:

void switch_handler(void *arg)
{
     6d2:	7139                	addi	sp,sp,-64
     6d4:	fc06                	sd	ra,56(sp)
     6d6:	f822                	sd	s0,48(sp)
     6d8:	0080                	addi	s0,sp,64
     6da:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
     6de:	fc843783          	ld	a5,-56(s0)
     6e2:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     6e6:	00002797          	auipc	a5,0x2
     6ea:	9da78793          	addi	a5,a5,-1574 # 20c0 <current>
     6ee:	639c                	ld	a5,0(a5)
     6f0:	fef43023          	sd	a5,-32(s0)
     6f4:	fe043783          	ld	a5,-32(s0)
     6f8:	fd878793          	addi	a5,a5,-40
     6fc:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
     700:	fe843783          	ld	a5,-24(s0)
     704:	0007871b          	sext.w	a4,a5
     708:	00002797          	auipc	a5,0x2
     70c:	9c078793          	addi	a5,a5,-1600 # 20c8 <threading_system_time>
     710:	439c                	lw	a5,0(a5)
     712:	2781                	sext.w	a5,a5
     714:	9fb9                	addw	a5,a5,a4
     716:	2781                	sext.w	a5,a5
     718:	0007871b          	sext.w	a4,a5
     71c:	00002797          	auipc	a5,0x2
     720:	9ac78793          	addi	a5,a5,-1620 # 20c8 <threading_system_time>
     724:	c398                	sw	a4,0(a5)
     __release();
     726:	00000097          	auipc	ra,0x0
     72a:	c08080e7          	jalr	-1016(ra) # 32e <__release>
    current_thread->remaining_time -= elapsed_time;
     72e:	fd843783          	ld	a5,-40(s0)
     732:	4bfc                	lw	a5,84(a5)
     734:	0007871b          	sext.w	a4,a5
     738:	fe843783          	ld	a5,-24(s0)
     73c:	2781                	sext.w	a5,a5
     73e:	40f707bb          	subw	a5,a4,a5
     742:	2781                	sext.w	a5,a5
     744:	0007871b          	sext.w	a4,a5
     748:	fd843783          	ld	a5,-40(s0)
     74c:	cbf8                	sw	a4,84(a5)
    if (!current_thread->cbs.is_hard_rt) {
     74e:	fd843783          	ld	a5,-40(s0)
     752:	57fc                	lw	a5,108(a5)
     754:	e38d                	bnez	a5,776 <switch_handler+0xa4>
        current_thread->cbs.remaining_budget -= elapsed_time;
     756:	fd843783          	ld	a5,-40(s0)
     75a:	57bc                	lw	a5,104(a5)
     75c:	0007871b          	sext.w	a4,a5
     760:	fe843783          	ld	a5,-24(s0)
     764:	2781                	sext.w	a5,a5
     766:	40f707bb          	subw	a5,a4,a5
     76a:	2781                	sext.w	a5,a5
     76c:	0007871b          	sext.w	a4,a5
     770:	fd843783          	ld	a5,-40(s0)
     774:	d7b8                	sw	a4,104(a5)
    }
    if (current_thread->is_real_time)
     776:	fd843783          	ld	a5,-40(s0)
     77a:	43bc                	lw	a5,64(a5)
     77c:	c3ad                	beqz	a5,7de <switch_handler+0x10c>
        if (threading_system_time > current_thread->current_deadline || 
     77e:	fd843783          	ld	a5,-40(s0)
     782:	4fb8                	lw	a4,88(a5)
     784:	00002797          	auipc	a5,0x2
     788:	94478793          	addi	a5,a5,-1724 # 20c8 <threading_system_time>
     78c:	439c                	lw	a5,0(a5)
     78e:	02f74163          	blt	a4,a5,7b0 <switch_handler+0xde>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     792:	fd843783          	ld	a5,-40(s0)
     796:	4fb8                	lw	a4,88(a5)
     798:	00002797          	auipc	a5,0x2
     79c:	93078793          	addi	a5,a5,-1744 # 20c8 <threading_system_time>
     7a0:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
     7a2:	02f71e63          	bne	a4,a5,7de <switch_handler+0x10c>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     7a6:	fd843783          	ld	a5,-40(s0)
     7aa:	4bfc                	lw	a5,84(a5)
     7ac:	02f05963          	blez	a5,7de <switch_handler+0x10c>
            printf("thread#%d misses a deadline at %d in swicth\n", current_thread->ID, threading_system_time);
     7b0:	fd843783          	ld	a5,-40(s0)
     7b4:	5fd8                	lw	a4,60(a5)
     7b6:	00002797          	auipc	a5,0x2
     7ba:	91278793          	addi	a5,a5,-1774 # 20c8 <threading_system_time>
     7be:	439c                	lw	a5,0(a5)
     7c0:	863e                	mv	a2,a5
     7c2:	85ba                	mv	a1,a4
     7c4:	00001517          	auipc	a0,0x1
     7c8:	7c450513          	addi	a0,a0,1988 # 1f88 <schedule_edf_cbs+0x498>
     7cc:	00001097          	auipc	ra,0x1
     7d0:	e54080e7          	jalr	-428(ra) # 1620 <printf>
            exit(0);
     7d4:	4501                	li	a0,0
     7d6:	00001097          	auipc	ra,0x1
     7da:	904080e7          	jalr	-1788(ra) # 10da <exit>
        }

    if (current_thread->remaining_time <= 0) {
     7de:	fd843783          	ld	a5,-40(s0)
     7e2:	4bfc                	lw	a5,84(a5)
     7e4:	02f04063          	bgtz	a5,804 <switch_handler+0x132>
        if (current_thread->is_real_time)
     7e8:	fd843783          	ld	a5,-40(s0)
     7ec:	43bc                	lw	a5,64(a5)
     7ee:	c791                	beqz	a5,7fa <switch_handler+0x128>
            __rt_finish_current();
     7f0:	00000097          	auipc	ra,0x0
     7f4:	e0a080e7          	jalr	-502(ra) # 5fa <__rt_finish_current>
     7f8:	a881                	j	848 <switch_handler+0x176>
        else
            __finish_current();
     7fa:	00000097          	auipc	ra,0x0
     7fe:	d3c080e7          	jalr	-708(ra) # 536 <__finish_current>
     802:	a099                	j	848 <switch_handler+0x176>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
     804:	00002797          	auipc	a5,0x2
     808:	8bc78793          	addi	a5,a5,-1860 # 20c0 <current>
     80c:	639c                	ld	a5,0(a5)
     80e:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
     812:	00002797          	auipc	a5,0x2
     816:	8ae78793          	addi	a5,a5,-1874 # 20c0 <current>
     81a:	639c                	ld	a5,0(a5)
     81c:	6798                	ld	a4,8(a5)
     81e:	00002797          	auipc	a5,0x2
     822:	8a278793          	addi	a5,a5,-1886 # 20c0 <current>
     826:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     828:	fd043503          	ld	a0,-48(s0)
     82c:	00000097          	auipc	ra,0x0
     830:	872080e7          	jalr	-1934(ra) # 9e <list_del>
        list_add_tail(to_remove, &run_queue);
     834:	00002597          	auipc	a1,0x2
     838:	84c58593          	addi	a1,a1,-1972 # 2080 <run_queue>
     83c:	fd043503          	ld	a0,-48(s0)
     840:	00000097          	auipc	ra,0x0
     844:	802080e7          	jalr	-2046(ra) # 42 <list_add_tail>
    }

    __release();
     848:	00000097          	auipc	ra,0x0
     84c:	ae6080e7          	jalr	-1306(ra) # 32e <__release>
    __schedule();
     850:	00000097          	auipc	ra,0x0
     854:	1be080e7          	jalr	446(ra) # a0e <__schedule>
    __dispatch();
     858:	00000097          	auipc	ra,0x0
     85c:	026080e7          	jalr	38(ra) # 87e <__dispatch>
    thrdresume(main_thrd_id);
     860:	00002797          	auipc	a5,0x2
     864:	85478793          	addi	a5,a5,-1964 # 20b4 <main_thrd_id>
     868:	439c                	lw	a5,0(a5)
     86a:	853e                	mv	a0,a5
     86c:	00001097          	auipc	ra,0x1
     870:	916080e7          	jalr	-1770(ra) # 1182 <thrdresume>
}
     874:	0001                	nop
     876:	70e2                	ld	ra,56(sp)
     878:	7442                	ld	s0,48(sp)
     87a:	6121                	addi	sp,sp,64
     87c:	8082                	ret

000000000000087e <__dispatch>:

void __dispatch()
{
     87e:	7179                	addi	sp,sp,-48
     880:	f406                	sd	ra,40(sp)
     882:	f022                	sd	s0,32(sp)
     884:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     886:	00002797          	auipc	a5,0x2
     88a:	83a78793          	addi	a5,a5,-1990 # 20c0 <current>
     88e:	6398                	ld	a4,0(a5)
     890:	00001797          	auipc	a5,0x1
     894:	7f078793          	addi	a5,a5,2032 # 2080 <run_queue>
     898:	16f70663          	beq	a4,a5,a04 <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     89c:	00002797          	auipc	a5,0x2
     8a0:	82478793          	addi	a5,a5,-2012 # 20c0 <current>
     8a4:	639c                	ld	a5,0(a5)
     8a6:	fef43423          	sd	a5,-24(s0)
     8aa:	fe843783          	ld	a5,-24(s0)
     8ae:	fd878793          	addi	a5,a5,-40
     8b2:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) {
     8b6:	fe043783          	ld	a5,-32(s0)
     8ba:	43bc                	lw	a5,64(a5)
     8bc:	cf85                	beqz	a5,8f4 <__dispatch+0x76>
     8be:	00002797          	auipc	a5,0x2
     8c2:	81278793          	addi	a5,a5,-2030 # 20d0 <allocated_time>
     8c6:	639c                	ld	a5,0(a5)
     8c8:	e795                	bnez	a5,8f4 <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d in dispatch\n", current_thread->ID, current_thread->current_deadline);
     8ca:	fe043783          	ld	a5,-32(s0)
     8ce:	5fd8                	lw	a4,60(a5)
     8d0:	fe043783          	ld	a5,-32(s0)
     8d4:	4fbc                	lw	a5,88(a5)
     8d6:	863e                	mv	a2,a5
     8d8:	85ba                	mv	a1,a4
     8da:	00001517          	auipc	a0,0x1
     8de:	6de50513          	addi	a0,a0,1758 # 1fb8 <schedule_edf_cbs+0x4c8>
     8e2:	00001097          	auipc	ra,0x1
     8e6:	d3e080e7          	jalr	-706(ra) # 1620 <printf>
        exit(0);
     8ea:	4501                	li	a0,0
     8ec:	00000097          	auipc	ra,0x0
     8f0:	7ee080e7          	jalr	2030(ra) # 10da <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
     8f4:	fe043783          	ld	a5,-32(s0)
     8f8:	5fd8                	lw	a4,60(a5)
     8fa:	00001797          	auipc	a5,0x1
     8fe:	7ce78793          	addi	a5,a5,1998 # 20c8 <threading_system_time>
     902:	4390                	lw	a2,0(a5)
     904:	00001797          	auipc	a5,0x1
     908:	7cc78793          	addi	a5,a5,1996 # 20d0 <allocated_time>
     90c:	639c                	ld	a5,0(a5)
     90e:	86be                	mv	a3,a5
     910:	85ba                	mv	a1,a4
     912:	00001517          	auipc	a0,0x1
     916:	6d650513          	addi	a0,a0,1750 # 1fe8 <schedule_edf_cbs+0x4f8>
     91a:	00001097          	auipc	ra,0x1
     91e:	d06080e7          	jalr	-762(ra) # 1620 <printf>

    if (current_thread->buf_set) {
     922:	fe043783          	ld	a5,-32(s0)
     926:	539c                	lw	a5,32(a5)
     928:	c7a1                	beqz	a5,970 <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     92a:	00001797          	auipc	a5,0x1
     92e:	7a678793          	addi	a5,a5,1958 # 20d0 <allocated_time>
     932:	639c                	ld	a5,0(a5)
     934:	0007871b          	sext.w	a4,a5
     938:	fe043783          	ld	a5,-32(s0)
     93c:	03878593          	addi	a1,a5,56
     940:	00001797          	auipc	a5,0x1
     944:	79078793          	addi	a5,a5,1936 # 20d0 <allocated_time>
     948:	639c                	ld	a5,0(a5)
     94a:	86be                	mv	a3,a5
     94c:	00000617          	auipc	a2,0x0
     950:	d8660613          	addi	a2,a2,-634 # 6d2 <switch_handler>
     954:	853a                	mv	a0,a4
     956:	00001097          	auipc	ra,0x1
     95a:	824080e7          	jalr	-2012(ra) # 117a <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
     95e:	fe043783          	ld	a5,-32(s0)
     962:	5f9c                	lw	a5,56(a5)
     964:	853e                	mv	a0,a5
     966:	00001097          	auipc	ra,0x1
     96a:	81c080e7          	jalr	-2020(ra) # 1182 <thrdresume>
     96e:	a071                	j	9fa <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
     970:	fe043783          	ld	a5,-32(s0)
     974:	4705                	li	a4,1
     976:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
     978:	fe043783          	ld	a5,-32(s0)
     97c:	6f9c                	ld	a5,24(a5)
     97e:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
     982:	fe043783          	ld	a5,-32(s0)
     986:	577d                	li	a4,-1
     988:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     98a:	00001797          	auipc	a5,0x1
     98e:	74678793          	addi	a5,a5,1862 # 20d0 <allocated_time>
     992:	639c                	ld	a5,0(a5)
     994:	0007871b          	sext.w	a4,a5
     998:	fe043783          	ld	a5,-32(s0)
     99c:	03878593          	addi	a1,a5,56
     9a0:	00001797          	auipc	a5,0x1
     9a4:	73078793          	addi	a5,a5,1840 # 20d0 <allocated_time>
     9a8:	639c                	ld	a5,0(a5)
     9aa:	86be                	mv	a3,a5
     9ac:	00000617          	auipc	a2,0x0
     9b0:	d2660613          	addi	a2,a2,-730 # 6d2 <switch_handler>
     9b4:	853a                	mv	a0,a4
     9b6:	00000097          	auipc	ra,0x0
     9ba:	7c4080e7          	jalr	1988(ra) # 117a <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
     9be:	fe043783          	ld	a5,-32(s0)
     9c2:	5f9c                	lw	a5,56(a5)
     9c4:	0207d063          	bgez	a5,9e4 <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
     9c8:	00001597          	auipc	a1,0x1
     9cc:	65058593          	addi	a1,a1,1616 # 2018 <schedule_edf_cbs+0x528>
     9d0:	4509                	li	a0,2
     9d2:	00001097          	auipc	ra,0x1
     9d6:	bf6080e7          	jalr	-1034(ra) # 15c8 <fprintf>
            exit(1);
     9da:	4505                	li	a0,1
     9dc:	00000097          	auipc	ra,0x0
     9e0:	6fe080e7          	jalr	1790(ra) # 10da <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
     9e4:	fd843783          	ld	a5,-40(s0)
     9e8:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
     9ea:	fe043783          	ld	a5,-32(s0)
     9ee:	6398                	ld	a4,0(a5)
     9f0:	fe043783          	ld	a5,-32(s0)
     9f4:	679c                	ld	a5,8(a5)
     9f6:	853e                	mv	a0,a5
     9f8:	9702                	jalr	a4
    }
    thread_exit();
     9fa:	00000097          	auipc	ra,0x0
     9fe:	a94080e7          	jalr	-1388(ra) # 48e <thread_exit>
     a02:	a011                	j	a06 <__dispatch+0x188>
        return;
     a04:	0001                	nop
}
     a06:	70a2                	ld	ra,40(sp)
     a08:	7402                	ld	s0,32(sp)
     a0a:	6145                	addi	sp,sp,48
     a0c:	8082                	ret

0000000000000a0e <__schedule>:

void __schedule()
{
     a0e:	711d                	addi	sp,sp,-96
     a10:	ec86                	sd	ra,88(sp)
     a12:	e8a2                	sd	s0,80(sp)
     a14:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
     a16:	00001797          	auipc	a5,0x1
     a1a:	6b278793          	addi	a5,a5,1714 # 20c8 <threading_system_time>
     a1e:	439c                	lw	a5,0(a5)
     a20:	fcf42c23          	sw	a5,-40(s0)
     a24:	4789                	li	a5,2
     a26:	fcf42e23          	sw	a5,-36(s0)
     a2a:	00001797          	auipc	a5,0x1
     a2e:	65678793          	addi	a5,a5,1622 # 2080 <run_queue>
     a32:	fef43023          	sd	a5,-32(s0)
     a36:	00001797          	auipc	a5,0x1
     a3a:	65a78793          	addi	a5,a5,1626 # 2090 <release_queue>
     a3e:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_PRIORITY_RR
    r = schedule_priority_rr(args);
#endif

#ifdef THREAD_SCHEDULER_EDF_CBS
    r = schedule_edf_cbs(args);
     a42:	fd843783          	ld	a5,-40(s0)
     a46:	faf43023          	sd	a5,-96(s0)
     a4a:	fe043783          	ld	a5,-32(s0)
     a4e:	faf43423          	sd	a5,-88(s0)
     a52:	fe843783          	ld	a5,-24(s0)
     a56:	faf43823          	sd	a5,-80(s0)
     a5a:	fa040793          	addi	a5,s0,-96
     a5e:	853e                	mv	a0,a5
     a60:	00001097          	auipc	ra,0x1
     a64:	090080e7          	jalr	144(ra) # 1af0 <schedule_edf_cbs>
     a68:	872a                	mv	a4,a0
     a6a:	87ae                	mv	a5,a1
     a6c:	fce43423          	sd	a4,-56(s0)
     a70:	fcf43823          	sd	a5,-48(s0)
//     r = schedule_edf_cbs(args);
// #else
//     r = schedule_default(args);
// #endif

    current = r.scheduled_thread_list_member;
     a74:	fc843703          	ld	a4,-56(s0)
     a78:	00001797          	auipc	a5,0x1
     a7c:	64878793          	addi	a5,a5,1608 # 20c0 <current>
     a80:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
     a82:	fd042783          	lw	a5,-48(s0)
     a86:	873e                	mv	a4,a5
     a88:	00001797          	auipc	a5,0x1
     a8c:	64878793          	addi	a5,a5,1608 # 20d0 <allocated_time>
     a90:	e398                	sd	a4,0(a5)
}
     a92:	0001                	nop
     a94:	60e6                	ld	ra,88(sp)
     a96:	6446                	ld	s0,80(sp)
     a98:	6125                	addi	sp,sp,96
     a9a:	8082                	ret

0000000000000a9c <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
     a9c:	1101                	addi	sp,sp,-32
     a9e:	ec06                	sd	ra,24(sp)
     aa0:	e822                	sd	s0,16(sp)
     aa2:	1000                	addi	s0,sp,32
     aa4:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
     aa8:	00001797          	auipc	a5,0x1
     aac:	62478793          	addi	a5,a5,1572 # 20cc <sleeping>
     ab0:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
     ab4:	fe843783          	ld	a5,-24(s0)
     ab8:	0007871b          	sext.w	a4,a5
     abc:	00001797          	auipc	a5,0x1
     ac0:	60c78793          	addi	a5,a5,1548 # 20c8 <threading_system_time>
     ac4:	439c                	lw	a5,0(a5)
     ac6:	2781                	sext.w	a5,a5
     ac8:	9fb9                	addw	a5,a5,a4
     aca:	2781                	sext.w	a5,a5
     acc:	0007871b          	sext.w	a4,a5
     ad0:	00001797          	auipc	a5,0x1
     ad4:	5f878793          	addi	a5,a5,1528 # 20c8 <threading_system_time>
     ad8:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
     ada:	00001797          	auipc	a5,0x1
     ade:	5da78793          	addi	a5,a5,1498 # 20b4 <main_thrd_id>
     ae2:	439c                	lw	a5,0(a5)
     ae4:	853e                	mv	a0,a5
     ae6:	00000097          	auipc	ra,0x0
     aea:	69c080e7          	jalr	1692(ra) # 1182 <thrdresume>
}
     aee:	0001                	nop
     af0:	60e2                	ld	ra,24(sp)
     af2:	6442                	ld	s0,16(sp)
     af4:	6105                	addi	sp,sp,32
     af6:	8082                	ret

0000000000000af8 <thread_start_threading>:

void thread_start_threading()
{
     af8:	1141                	addi	sp,sp,-16
     afa:	e406                	sd	ra,8(sp)
     afc:	e022                	sd	s0,0(sp)
     afe:	0800                	addi	s0,sp,16
    threading_system_time = 0;
     b00:	00001797          	auipc	a5,0x1
     b04:	5c878793          	addi	a5,a5,1480 # 20c8 <threading_system_time>
     b08:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
     b0c:	00001797          	auipc	a5,0x1
     b10:	5b478793          	addi	a5,a5,1460 # 20c0 <current>
     b14:	00001717          	auipc	a4,0x1
     b18:	56c70713          	addi	a4,a4,1388 # 2080 <run_queue>
     b1c:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
     b1e:	4681                	li	a3,0
     b20:	00000617          	auipc	a2,0x0
     b24:	f7c60613          	addi	a2,a2,-132 # a9c <back_to_main_handler>
     b28:	00001597          	auipc	a1,0x1
     b2c:	58c58593          	addi	a1,a1,1420 # 20b4 <main_thrd_id>
     b30:	3e800513          	li	a0,1000
     b34:	00000097          	auipc	ra,0x0
     b38:	646080e7          	jalr	1606(ra) # 117a <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
     b3c:	00001797          	auipc	a5,0x1
     b40:	57878793          	addi	a5,a5,1400 # 20b4 <main_thrd_id>
     b44:	439c                	lw	a5,0(a5)
     b46:	4581                	li	a1,0
     b48:	853e                	mv	a0,a5
     b4a:	00000097          	auipc	ra,0x0
     b4e:	640080e7          	jalr	1600(ra) # 118a <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     b52:	a0c9                	j	c14 <thread_start_threading+0x11c>
        __release();
     b54:	fffff097          	auipc	ra,0xfffff
     b58:	7da080e7          	jalr	2010(ra) # 32e <__release>
        __schedule();
     b5c:	00000097          	auipc	ra,0x0
     b60:	eb2080e7          	jalr	-334(ra) # a0e <__schedule>
        cancelthrdstop(main_thrd_id, 0);
     b64:	00001797          	auipc	a5,0x1
     b68:	55078793          	addi	a5,a5,1360 # 20b4 <main_thrd_id>
     b6c:	439c                	lw	a5,0(a5)
     b6e:	4581                	li	a1,0
     b70:	853e                	mv	a0,a5
     b72:	00000097          	auipc	ra,0x0
     b76:	618080e7          	jalr	1560(ra) # 118a <cancelthrdstop>
        __dispatch();
     b7a:	00000097          	auipc	ra,0x0
     b7e:	d04080e7          	jalr	-764(ra) # 87e <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
     b82:	00001517          	auipc	a0,0x1
     b86:	4fe50513          	addi	a0,a0,1278 # 2080 <run_queue>
     b8a:	fffff097          	auipc	ra,0xfffff
     b8e:	55e080e7          	jalr	1374(ra) # e8 <list_empty>
     b92:	87aa                	mv	a5,a0
     b94:	cb99                	beqz	a5,baa <thread_start_threading+0xb2>
     b96:	00001517          	auipc	a0,0x1
     b9a:	4fa50513          	addi	a0,a0,1274 # 2090 <release_queue>
     b9e:	fffff097          	auipc	ra,0xfffff
     ba2:	54a080e7          	jalr	1354(ra) # e8 <list_empty>
     ba6:	87aa                	mv	a5,a0
     ba8:	ebd9                	bnez	a5,c3e <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
     baa:	00001797          	auipc	a5,0x1
     bae:	52678793          	addi	a5,a5,1318 # 20d0 <allocated_time>
     bb2:	639c                	ld	a5,0(a5)
     bb4:	85be                	mv	a1,a5
     bb6:	00001517          	auipc	a0,0x1
     bba:	49a50513          	addi	a0,a0,1178 # 2050 <schedule_edf_cbs+0x560>
     bbe:	00001097          	auipc	ra,0x1
     bc2:	a62080e7          	jalr	-1438(ra) # 1620 <printf>
        sleeping = 1;
     bc6:	00001797          	auipc	a5,0x1
     bca:	50678793          	addi	a5,a5,1286 # 20cc <sleeping>
     bce:	4705                	li	a4,1
     bd0:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
     bd2:	00001797          	auipc	a5,0x1
     bd6:	4fe78793          	addi	a5,a5,1278 # 20d0 <allocated_time>
     bda:	639c                	ld	a5,0(a5)
     bdc:	0007871b          	sext.w	a4,a5
     be0:	00001797          	auipc	a5,0x1
     be4:	4f078793          	addi	a5,a5,1264 # 20d0 <allocated_time>
     be8:	639c                	ld	a5,0(a5)
     bea:	86be                	mv	a3,a5
     bec:	00000617          	auipc	a2,0x0
     bf0:	eb060613          	addi	a2,a2,-336 # a9c <back_to_main_handler>
     bf4:	00001597          	auipc	a1,0x1
     bf8:	4c058593          	addi	a1,a1,1216 # 20b4 <main_thrd_id>
     bfc:	853a                	mv	a0,a4
     bfe:	00000097          	auipc	ra,0x0
     c02:	57c080e7          	jalr	1404(ra) # 117a <thrdstop>
        while (sleeping) {
     c06:	0001                	nop
     c08:	00001797          	auipc	a5,0x1
     c0c:	4c478793          	addi	a5,a5,1220 # 20cc <sleeping>
     c10:	439c                	lw	a5,0(a5)
     c12:	fbfd                	bnez	a5,c08 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     c14:	00001517          	auipc	a0,0x1
     c18:	46c50513          	addi	a0,a0,1132 # 2080 <run_queue>
     c1c:	fffff097          	auipc	ra,0xfffff
     c20:	4cc080e7          	jalr	1228(ra) # e8 <list_empty>
     c24:	87aa                	mv	a5,a0
     c26:	d79d                	beqz	a5,b54 <thread_start_threading+0x5c>
     c28:	00001517          	auipc	a0,0x1
     c2c:	46850513          	addi	a0,a0,1128 # 2090 <release_queue>
     c30:	fffff097          	auipc	ra,0xfffff
     c34:	4b8080e7          	jalr	1208(ra) # e8 <list_empty>
     c38:	87aa                	mv	a5,a0
     c3a:	df89                	beqz	a5,b54 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
     c3c:	a011                	j	c40 <thread_start_threading+0x148>
            break;
     c3e:	0001                	nop
}
     c40:	0001                	nop
     c42:	60a2                	ld	ra,8(sp)
     c44:	6402                	ld	s0,0(sp)
     c46:	0141                	addi	sp,sp,16
     c48:	8082                	ret

0000000000000c4a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     c4a:	7179                	addi	sp,sp,-48
     c4c:	f422                	sd	s0,40(sp)
     c4e:	1800                	addi	s0,sp,48
     c50:	fca43c23          	sd	a0,-40(s0)
     c54:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     c58:	fd843783          	ld	a5,-40(s0)
     c5c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     c60:	0001                	nop
     c62:	fd043703          	ld	a4,-48(s0)
     c66:	00170793          	addi	a5,a4,1
     c6a:	fcf43823          	sd	a5,-48(s0)
     c6e:	fd843783          	ld	a5,-40(s0)
     c72:	00178693          	addi	a3,a5,1
     c76:	fcd43c23          	sd	a3,-40(s0)
     c7a:	00074703          	lbu	a4,0(a4)
     c7e:	00e78023          	sb	a4,0(a5)
     c82:	0007c783          	lbu	a5,0(a5)
     c86:	fff1                	bnez	a5,c62 <strcpy+0x18>
    ;
  return os;
     c88:	fe843783          	ld	a5,-24(s0)
}
     c8c:	853e                	mv	a0,a5
     c8e:	7422                	ld	s0,40(sp)
     c90:	6145                	addi	sp,sp,48
     c92:	8082                	ret

0000000000000c94 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c94:	1101                	addi	sp,sp,-32
     c96:	ec22                	sd	s0,24(sp)
     c98:	1000                	addi	s0,sp,32
     c9a:	fea43423          	sd	a0,-24(s0)
     c9e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     ca2:	a819                	j	cb8 <strcmp+0x24>
    p++, q++;
     ca4:	fe843783          	ld	a5,-24(s0)
     ca8:	0785                	addi	a5,a5,1
     caa:	fef43423          	sd	a5,-24(s0)
     cae:	fe043783          	ld	a5,-32(s0)
     cb2:	0785                	addi	a5,a5,1
     cb4:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     cb8:	fe843783          	ld	a5,-24(s0)
     cbc:	0007c783          	lbu	a5,0(a5)
     cc0:	cb99                	beqz	a5,cd6 <strcmp+0x42>
     cc2:	fe843783          	ld	a5,-24(s0)
     cc6:	0007c703          	lbu	a4,0(a5)
     cca:	fe043783          	ld	a5,-32(s0)
     cce:	0007c783          	lbu	a5,0(a5)
     cd2:	fcf709e3          	beq	a4,a5,ca4 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     cd6:	fe843783          	ld	a5,-24(s0)
     cda:	0007c783          	lbu	a5,0(a5)
     cde:	0007871b          	sext.w	a4,a5
     ce2:	fe043783          	ld	a5,-32(s0)
     ce6:	0007c783          	lbu	a5,0(a5)
     cea:	2781                	sext.w	a5,a5
     cec:	40f707bb          	subw	a5,a4,a5
     cf0:	2781                	sext.w	a5,a5
}
     cf2:	853e                	mv	a0,a5
     cf4:	6462                	ld	s0,24(sp)
     cf6:	6105                	addi	sp,sp,32
     cf8:	8082                	ret

0000000000000cfa <strlen>:

uint
strlen(const char *s)
{
     cfa:	7179                	addi	sp,sp,-48
     cfc:	f422                	sd	s0,40(sp)
     cfe:	1800                	addi	s0,sp,48
     d00:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     d04:	fe042623          	sw	zero,-20(s0)
     d08:	a031                	j	d14 <strlen+0x1a>
     d0a:	fec42783          	lw	a5,-20(s0)
     d0e:	2785                	addiw	a5,a5,1
     d10:	fef42623          	sw	a5,-20(s0)
     d14:	fec42783          	lw	a5,-20(s0)
     d18:	fd843703          	ld	a4,-40(s0)
     d1c:	97ba                	add	a5,a5,a4
     d1e:	0007c783          	lbu	a5,0(a5)
     d22:	f7e5                	bnez	a5,d0a <strlen+0x10>
    ;
  return n;
     d24:	fec42783          	lw	a5,-20(s0)
}
     d28:	853e                	mv	a0,a5
     d2a:	7422                	ld	s0,40(sp)
     d2c:	6145                	addi	sp,sp,48
     d2e:	8082                	ret

0000000000000d30 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d30:	7179                	addi	sp,sp,-48
     d32:	f422                	sd	s0,40(sp)
     d34:	1800                	addi	s0,sp,48
     d36:	fca43c23          	sd	a0,-40(s0)
     d3a:	87ae                	mv	a5,a1
     d3c:	8732                	mv	a4,a2
     d3e:	fcf42a23          	sw	a5,-44(s0)
     d42:	87ba                	mv	a5,a4
     d44:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     d48:	fd843783          	ld	a5,-40(s0)
     d4c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     d50:	fe042623          	sw	zero,-20(s0)
     d54:	a00d                	j	d76 <memset+0x46>
    cdst[i] = c;
     d56:	fec42783          	lw	a5,-20(s0)
     d5a:	fe043703          	ld	a4,-32(s0)
     d5e:	97ba                	add	a5,a5,a4
     d60:	fd442703          	lw	a4,-44(s0)
     d64:	0ff77713          	andi	a4,a4,255
     d68:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     d6c:	fec42783          	lw	a5,-20(s0)
     d70:	2785                	addiw	a5,a5,1
     d72:	fef42623          	sw	a5,-20(s0)
     d76:	fec42703          	lw	a4,-20(s0)
     d7a:	fd042783          	lw	a5,-48(s0)
     d7e:	2781                	sext.w	a5,a5
     d80:	fcf76be3          	bltu	a4,a5,d56 <memset+0x26>
  }
  return dst;
     d84:	fd843783          	ld	a5,-40(s0)
}
     d88:	853e                	mv	a0,a5
     d8a:	7422                	ld	s0,40(sp)
     d8c:	6145                	addi	sp,sp,48
     d8e:	8082                	ret

0000000000000d90 <strchr>:

char*
strchr(const char *s, char c)
{
     d90:	1101                	addi	sp,sp,-32
     d92:	ec22                	sd	s0,24(sp)
     d94:	1000                	addi	s0,sp,32
     d96:	fea43423          	sd	a0,-24(s0)
     d9a:	87ae                	mv	a5,a1
     d9c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     da0:	a01d                	j	dc6 <strchr+0x36>
    if(*s == c)
     da2:	fe843783          	ld	a5,-24(s0)
     da6:	0007c703          	lbu	a4,0(a5)
     daa:	fe744783          	lbu	a5,-25(s0)
     dae:	0ff7f793          	andi	a5,a5,255
     db2:	00e79563          	bne	a5,a4,dbc <strchr+0x2c>
      return (char*)s;
     db6:	fe843783          	ld	a5,-24(s0)
     dba:	a821                	j	dd2 <strchr+0x42>
  for(; *s; s++)
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	0785                	addi	a5,a5,1
     dc2:	fef43423          	sd	a5,-24(s0)
     dc6:	fe843783          	ld	a5,-24(s0)
     dca:	0007c783          	lbu	a5,0(a5)
     dce:	fbf1                	bnez	a5,da2 <strchr+0x12>
  return 0;
     dd0:	4781                	li	a5,0
}
     dd2:	853e                	mv	a0,a5
     dd4:	6462                	ld	s0,24(sp)
     dd6:	6105                	addi	sp,sp,32
     dd8:	8082                	ret

0000000000000dda <gets>:

char*
gets(char *buf, int max)
{
     dda:	7179                	addi	sp,sp,-48
     ddc:	f406                	sd	ra,40(sp)
     dde:	f022                	sd	s0,32(sp)
     de0:	1800                	addi	s0,sp,48
     de2:	fca43c23          	sd	a0,-40(s0)
     de6:	87ae                	mv	a5,a1
     de8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     dec:	fe042623          	sw	zero,-20(s0)
     df0:	a8a1                	j	e48 <gets+0x6e>
    cc = read(0, &c, 1);
     df2:	fe740793          	addi	a5,s0,-25
     df6:	4605                	li	a2,1
     df8:	85be                	mv	a1,a5
     dfa:	4501                	li	a0,0
     dfc:	00000097          	auipc	ra,0x0
     e00:	2f6080e7          	jalr	758(ra) # 10f2 <read>
     e04:	87aa                	mv	a5,a0
     e06:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     e0a:	fe842783          	lw	a5,-24(s0)
     e0e:	2781                	sext.w	a5,a5
     e10:	04f05763          	blez	a5,e5e <gets+0x84>
      break;
    buf[i++] = c;
     e14:	fec42783          	lw	a5,-20(s0)
     e18:	0017871b          	addiw	a4,a5,1
     e1c:	fee42623          	sw	a4,-20(s0)
     e20:	873e                	mv	a4,a5
     e22:	fd843783          	ld	a5,-40(s0)
     e26:	97ba                	add	a5,a5,a4
     e28:	fe744703          	lbu	a4,-25(s0)
     e2c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     e30:	fe744783          	lbu	a5,-25(s0)
     e34:	873e                	mv	a4,a5
     e36:	47a9                	li	a5,10
     e38:	02f70463          	beq	a4,a5,e60 <gets+0x86>
     e3c:	fe744783          	lbu	a5,-25(s0)
     e40:	873e                	mv	a4,a5
     e42:	47b5                	li	a5,13
     e44:	00f70e63          	beq	a4,a5,e60 <gets+0x86>
  for(i=0; i+1 < max; ){
     e48:	fec42783          	lw	a5,-20(s0)
     e4c:	2785                	addiw	a5,a5,1
     e4e:	0007871b          	sext.w	a4,a5
     e52:	fd442783          	lw	a5,-44(s0)
     e56:	2781                	sext.w	a5,a5
     e58:	f8f74de3          	blt	a4,a5,df2 <gets+0x18>
     e5c:	a011                	j	e60 <gets+0x86>
      break;
     e5e:	0001                	nop
      break;
  }
  buf[i] = '\0';
     e60:	fec42783          	lw	a5,-20(s0)
     e64:	fd843703          	ld	a4,-40(s0)
     e68:	97ba                	add	a5,a5,a4
     e6a:	00078023          	sb	zero,0(a5)
  return buf;
     e6e:	fd843783          	ld	a5,-40(s0)
}
     e72:	853e                	mv	a0,a5
     e74:	70a2                	ld	ra,40(sp)
     e76:	7402                	ld	s0,32(sp)
     e78:	6145                	addi	sp,sp,48
     e7a:	8082                	ret

0000000000000e7c <stat>:

int
stat(const char *n, struct stat *st)
{
     e7c:	7179                	addi	sp,sp,-48
     e7e:	f406                	sd	ra,40(sp)
     e80:	f022                	sd	s0,32(sp)
     e82:	1800                	addi	s0,sp,48
     e84:	fca43c23          	sd	a0,-40(s0)
     e88:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e8c:	4581                	li	a1,0
     e8e:	fd843503          	ld	a0,-40(s0)
     e92:	00000097          	auipc	ra,0x0
     e96:	288080e7          	jalr	648(ra) # 111a <open>
     e9a:	87aa                	mv	a5,a0
     e9c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     ea0:	fec42783          	lw	a5,-20(s0)
     ea4:	2781                	sext.w	a5,a5
     ea6:	0007d463          	bgez	a5,eae <stat+0x32>
    return -1;
     eaa:	57fd                	li	a5,-1
     eac:	a035                	j	ed8 <stat+0x5c>
  r = fstat(fd, st);
     eae:	fec42783          	lw	a5,-20(s0)
     eb2:	fd043583          	ld	a1,-48(s0)
     eb6:	853e                	mv	a0,a5
     eb8:	00000097          	auipc	ra,0x0
     ebc:	27a080e7          	jalr	634(ra) # 1132 <fstat>
     ec0:	87aa                	mv	a5,a0
     ec2:	fef42423          	sw	a5,-24(s0)
  close(fd);
     ec6:	fec42783          	lw	a5,-20(s0)
     eca:	853e                	mv	a0,a5
     ecc:	00000097          	auipc	ra,0x0
     ed0:	236080e7          	jalr	566(ra) # 1102 <close>
  return r;
     ed4:	fe842783          	lw	a5,-24(s0)
}
     ed8:	853e                	mv	a0,a5
     eda:	70a2                	ld	ra,40(sp)
     edc:	7402                	ld	s0,32(sp)
     ede:	6145                	addi	sp,sp,48
     ee0:	8082                	ret

0000000000000ee2 <atoi>:

int
atoi(const char *s)
{
     ee2:	7179                	addi	sp,sp,-48
     ee4:	f422                	sd	s0,40(sp)
     ee6:	1800                	addi	s0,sp,48
     ee8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     eec:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     ef0:	a815                	j	f24 <atoi+0x42>
    n = n*10 + *s++ - '0';
     ef2:	fec42703          	lw	a4,-20(s0)
     ef6:	87ba                	mv	a5,a4
     ef8:	0027979b          	slliw	a5,a5,0x2
     efc:	9fb9                	addw	a5,a5,a4
     efe:	0017979b          	slliw	a5,a5,0x1
     f02:	0007871b          	sext.w	a4,a5
     f06:	fd843783          	ld	a5,-40(s0)
     f0a:	00178693          	addi	a3,a5,1
     f0e:	fcd43c23          	sd	a3,-40(s0)
     f12:	0007c783          	lbu	a5,0(a5)
     f16:	2781                	sext.w	a5,a5
     f18:	9fb9                	addw	a5,a5,a4
     f1a:	2781                	sext.w	a5,a5
     f1c:	fd07879b          	addiw	a5,a5,-48
     f20:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     f24:	fd843783          	ld	a5,-40(s0)
     f28:	0007c783          	lbu	a5,0(a5)
     f2c:	873e                	mv	a4,a5
     f2e:	02f00793          	li	a5,47
     f32:	00e7fb63          	bgeu	a5,a4,f48 <atoi+0x66>
     f36:	fd843783          	ld	a5,-40(s0)
     f3a:	0007c783          	lbu	a5,0(a5)
     f3e:	873e                	mv	a4,a5
     f40:	03900793          	li	a5,57
     f44:	fae7f7e3          	bgeu	a5,a4,ef2 <atoi+0x10>
  return n;
     f48:	fec42783          	lw	a5,-20(s0)
}
     f4c:	853e                	mv	a0,a5
     f4e:	7422                	ld	s0,40(sp)
     f50:	6145                	addi	sp,sp,48
     f52:	8082                	ret

0000000000000f54 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f54:	7139                	addi	sp,sp,-64
     f56:	fc22                	sd	s0,56(sp)
     f58:	0080                	addi	s0,sp,64
     f5a:	fca43c23          	sd	a0,-40(s0)
     f5e:	fcb43823          	sd	a1,-48(s0)
     f62:	87b2                	mv	a5,a2
     f64:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     f68:	fd843783          	ld	a5,-40(s0)
     f6c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     f70:	fd043783          	ld	a5,-48(s0)
     f74:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     f78:	fe043703          	ld	a4,-32(s0)
     f7c:	fe843783          	ld	a5,-24(s0)
     f80:	02e7fc63          	bgeu	a5,a4,fb8 <memmove+0x64>
    while(n-- > 0)
     f84:	a00d                	j	fa6 <memmove+0x52>
      *dst++ = *src++;
     f86:	fe043703          	ld	a4,-32(s0)
     f8a:	00170793          	addi	a5,a4,1
     f8e:	fef43023          	sd	a5,-32(s0)
     f92:	fe843783          	ld	a5,-24(s0)
     f96:	00178693          	addi	a3,a5,1
     f9a:	fed43423          	sd	a3,-24(s0)
     f9e:	00074703          	lbu	a4,0(a4)
     fa2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     fa6:	fcc42783          	lw	a5,-52(s0)
     faa:	fff7871b          	addiw	a4,a5,-1
     fae:	fce42623          	sw	a4,-52(s0)
     fb2:	fcf04ae3          	bgtz	a5,f86 <memmove+0x32>
     fb6:	a891                	j	100a <memmove+0xb6>
  } else {
    dst += n;
     fb8:	fcc42783          	lw	a5,-52(s0)
     fbc:	fe843703          	ld	a4,-24(s0)
     fc0:	97ba                	add	a5,a5,a4
     fc2:	fef43423          	sd	a5,-24(s0)
    src += n;
     fc6:	fcc42783          	lw	a5,-52(s0)
     fca:	fe043703          	ld	a4,-32(s0)
     fce:	97ba                	add	a5,a5,a4
     fd0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     fd4:	a01d                	j	ffa <memmove+0xa6>
      *--dst = *--src;
     fd6:	fe043783          	ld	a5,-32(s0)
     fda:	17fd                	addi	a5,a5,-1
     fdc:	fef43023          	sd	a5,-32(s0)
     fe0:	fe843783          	ld	a5,-24(s0)
     fe4:	17fd                	addi	a5,a5,-1
     fe6:	fef43423          	sd	a5,-24(s0)
     fea:	fe043783          	ld	a5,-32(s0)
     fee:	0007c703          	lbu	a4,0(a5)
     ff2:	fe843783          	ld	a5,-24(s0)
     ff6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     ffa:	fcc42783          	lw	a5,-52(s0)
     ffe:	fff7871b          	addiw	a4,a5,-1
    1002:	fce42623          	sw	a4,-52(s0)
    1006:	fcf048e3          	bgtz	a5,fd6 <memmove+0x82>
  }
  return vdst;
    100a:	fd843783          	ld	a5,-40(s0)
}
    100e:	853e                	mv	a0,a5
    1010:	7462                	ld	s0,56(sp)
    1012:	6121                	addi	sp,sp,64
    1014:	8082                	ret

0000000000001016 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1016:	7139                	addi	sp,sp,-64
    1018:	fc22                	sd	s0,56(sp)
    101a:	0080                	addi	s0,sp,64
    101c:	fca43c23          	sd	a0,-40(s0)
    1020:	fcb43823          	sd	a1,-48(s0)
    1024:	87b2                	mv	a5,a2
    1026:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    102a:	fd843783          	ld	a5,-40(s0)
    102e:	fef43423          	sd	a5,-24(s0)
    1032:	fd043783          	ld	a5,-48(s0)
    1036:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    103a:	a0a1                	j	1082 <memcmp+0x6c>
    if (*p1 != *p2) {
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	0007c703          	lbu	a4,0(a5)
    1044:	fe043783          	ld	a5,-32(s0)
    1048:	0007c783          	lbu	a5,0(a5)
    104c:	02f70163          	beq	a4,a5,106e <memcmp+0x58>
      return *p1 - *p2;
    1050:	fe843783          	ld	a5,-24(s0)
    1054:	0007c783          	lbu	a5,0(a5)
    1058:	0007871b          	sext.w	a4,a5
    105c:	fe043783          	ld	a5,-32(s0)
    1060:	0007c783          	lbu	a5,0(a5)
    1064:	2781                	sext.w	a5,a5
    1066:	40f707bb          	subw	a5,a4,a5
    106a:	2781                	sext.w	a5,a5
    106c:	a01d                	j	1092 <memcmp+0x7c>
    }
    p1++;
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	0785                	addi	a5,a5,1
    1074:	fef43423          	sd	a5,-24(s0)
    p2++;
    1078:	fe043783          	ld	a5,-32(s0)
    107c:	0785                	addi	a5,a5,1
    107e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    1082:	fcc42783          	lw	a5,-52(s0)
    1086:	fff7871b          	addiw	a4,a5,-1
    108a:	fce42623          	sw	a4,-52(s0)
    108e:	f7dd                	bnez	a5,103c <memcmp+0x26>
  }
  return 0;
    1090:	4781                	li	a5,0
}
    1092:	853e                	mv	a0,a5
    1094:	7462                	ld	s0,56(sp)
    1096:	6121                	addi	sp,sp,64
    1098:	8082                	ret

000000000000109a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    109a:	7179                	addi	sp,sp,-48
    109c:	f406                	sd	ra,40(sp)
    109e:	f022                	sd	s0,32(sp)
    10a0:	1800                	addi	s0,sp,48
    10a2:	fea43423          	sd	a0,-24(s0)
    10a6:	feb43023          	sd	a1,-32(s0)
    10aa:	87b2                	mv	a5,a2
    10ac:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    10b0:	fdc42783          	lw	a5,-36(s0)
    10b4:	863e                	mv	a2,a5
    10b6:	fe043583          	ld	a1,-32(s0)
    10ba:	fe843503          	ld	a0,-24(s0)
    10be:	00000097          	auipc	ra,0x0
    10c2:	e96080e7          	jalr	-362(ra) # f54 <memmove>
    10c6:	87aa                	mv	a5,a0
}
    10c8:	853e                	mv	a0,a5
    10ca:	70a2                	ld	ra,40(sp)
    10cc:	7402                	ld	s0,32(sp)
    10ce:	6145                	addi	sp,sp,48
    10d0:	8082                	ret

00000000000010d2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    10d2:	4885                	li	a7,1
 ecall
    10d4:	00000073          	ecall
 ret
    10d8:	8082                	ret

00000000000010da <exit>:
.global exit
exit:
 li a7, SYS_exit
    10da:	4889                	li	a7,2
 ecall
    10dc:	00000073          	ecall
 ret
    10e0:	8082                	ret

00000000000010e2 <wait>:
.global wait
wait:
 li a7, SYS_wait
    10e2:	488d                	li	a7,3
 ecall
    10e4:	00000073          	ecall
 ret
    10e8:	8082                	ret

00000000000010ea <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    10ea:	4891                	li	a7,4
 ecall
    10ec:	00000073          	ecall
 ret
    10f0:	8082                	ret

00000000000010f2 <read>:
.global read
read:
 li a7, SYS_read
    10f2:	4895                	li	a7,5
 ecall
    10f4:	00000073          	ecall
 ret
    10f8:	8082                	ret

00000000000010fa <write>:
.global write
write:
 li a7, SYS_write
    10fa:	48c1                	li	a7,16
 ecall
    10fc:	00000073          	ecall
 ret
    1100:	8082                	ret

0000000000001102 <close>:
.global close
close:
 li a7, SYS_close
    1102:	48d5                	li	a7,21
 ecall
    1104:	00000073          	ecall
 ret
    1108:	8082                	ret

000000000000110a <kill>:
.global kill
kill:
 li a7, SYS_kill
    110a:	4899                	li	a7,6
 ecall
    110c:	00000073          	ecall
 ret
    1110:	8082                	ret

0000000000001112 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1112:	489d                	li	a7,7
 ecall
    1114:	00000073          	ecall
 ret
    1118:	8082                	ret

000000000000111a <open>:
.global open
open:
 li a7, SYS_open
    111a:	48bd                	li	a7,15
 ecall
    111c:	00000073          	ecall
 ret
    1120:	8082                	ret

0000000000001122 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1122:	48c5                	li	a7,17
 ecall
    1124:	00000073          	ecall
 ret
    1128:	8082                	ret

000000000000112a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    112a:	48c9                	li	a7,18
 ecall
    112c:	00000073          	ecall
 ret
    1130:	8082                	ret

0000000000001132 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1132:	48a1                	li	a7,8
 ecall
    1134:	00000073          	ecall
 ret
    1138:	8082                	ret

000000000000113a <link>:
.global link
link:
 li a7, SYS_link
    113a:	48cd                	li	a7,19
 ecall
    113c:	00000073          	ecall
 ret
    1140:	8082                	ret

0000000000001142 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1142:	48d1                	li	a7,20
 ecall
    1144:	00000073          	ecall
 ret
    1148:	8082                	ret

000000000000114a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    114a:	48a5                	li	a7,9
 ecall
    114c:	00000073          	ecall
 ret
    1150:	8082                	ret

0000000000001152 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1152:	48a9                	li	a7,10
 ecall
    1154:	00000073          	ecall
 ret
    1158:	8082                	ret

000000000000115a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    115a:	48ad                	li	a7,11
 ecall
    115c:	00000073          	ecall
 ret
    1160:	8082                	ret

0000000000001162 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1162:	48b1                	li	a7,12
 ecall
    1164:	00000073          	ecall
 ret
    1168:	8082                	ret

000000000000116a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    116a:	48b5                	li	a7,13
 ecall
    116c:	00000073          	ecall
 ret
    1170:	8082                	ret

0000000000001172 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1172:	48b9                	li	a7,14
 ecall
    1174:	00000073          	ecall
 ret
    1178:	8082                	ret

000000000000117a <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
    117a:	48d9                	li	a7,22
 ecall
    117c:	00000073          	ecall
 ret
    1180:	8082                	ret

0000000000001182 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
    1182:	48dd                	li	a7,23
 ecall
    1184:	00000073          	ecall
 ret
    1188:	8082                	ret

000000000000118a <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
    118a:	48e1                	li	a7,24
 ecall
    118c:	00000073          	ecall
 ret
    1190:	8082                	ret

0000000000001192 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1192:	1101                	addi	sp,sp,-32
    1194:	ec06                	sd	ra,24(sp)
    1196:	e822                	sd	s0,16(sp)
    1198:	1000                	addi	s0,sp,32
    119a:	87aa                	mv	a5,a0
    119c:	872e                	mv	a4,a1
    119e:	fef42623          	sw	a5,-20(s0)
    11a2:	87ba                	mv	a5,a4
    11a4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    11a8:	feb40713          	addi	a4,s0,-21
    11ac:	fec42783          	lw	a5,-20(s0)
    11b0:	4605                	li	a2,1
    11b2:	85ba                	mv	a1,a4
    11b4:	853e                	mv	a0,a5
    11b6:	00000097          	auipc	ra,0x0
    11ba:	f44080e7          	jalr	-188(ra) # 10fa <write>
}
    11be:	0001                	nop
    11c0:	60e2                	ld	ra,24(sp)
    11c2:	6442                	ld	s0,16(sp)
    11c4:	6105                	addi	sp,sp,32
    11c6:	8082                	ret

00000000000011c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    11c8:	7139                	addi	sp,sp,-64
    11ca:	fc06                	sd	ra,56(sp)
    11cc:	f822                	sd	s0,48(sp)
    11ce:	0080                	addi	s0,sp,64
    11d0:	87aa                	mv	a5,a0
    11d2:	8736                	mv	a4,a3
    11d4:	fcf42623          	sw	a5,-52(s0)
    11d8:	87ae                	mv	a5,a1
    11da:	fcf42423          	sw	a5,-56(s0)
    11de:	87b2                	mv	a5,a2
    11e0:	fcf42223          	sw	a5,-60(s0)
    11e4:	87ba                	mv	a5,a4
    11e6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    11ea:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    11ee:	fc042783          	lw	a5,-64(s0)
    11f2:	2781                	sext.w	a5,a5
    11f4:	c38d                	beqz	a5,1216 <printint+0x4e>
    11f6:	fc842783          	lw	a5,-56(s0)
    11fa:	2781                	sext.w	a5,a5
    11fc:	0007dd63          	bgez	a5,1216 <printint+0x4e>
    neg = 1;
    1200:	4785                	li	a5,1
    1202:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    1206:	fc842783          	lw	a5,-56(s0)
    120a:	40f007bb          	negw	a5,a5
    120e:	2781                	sext.w	a5,a5
    1210:	fef42223          	sw	a5,-28(s0)
    1214:	a029                	j	121e <printint+0x56>
  } else {
    x = xx;
    1216:	fc842783          	lw	a5,-56(s0)
    121a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    121e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    1222:	fc442783          	lw	a5,-60(s0)
    1226:	fe442703          	lw	a4,-28(s0)
    122a:	02f777bb          	remuw	a5,a4,a5
    122e:	0007861b          	sext.w	a2,a5
    1232:	fec42783          	lw	a5,-20(s0)
    1236:	0017871b          	addiw	a4,a5,1
    123a:	fee42623          	sw	a4,-20(s0)
    123e:	00001697          	auipc	a3,0x1
    1242:	e6268693          	addi	a3,a3,-414 # 20a0 <digits>
    1246:	02061713          	slli	a4,a2,0x20
    124a:	9301                	srli	a4,a4,0x20
    124c:	9736                	add	a4,a4,a3
    124e:	00074703          	lbu	a4,0(a4)
    1252:	ff040693          	addi	a3,s0,-16
    1256:	97b6                	add	a5,a5,a3
    1258:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    125c:	fc442783          	lw	a5,-60(s0)
    1260:	fe442703          	lw	a4,-28(s0)
    1264:	02f757bb          	divuw	a5,a4,a5
    1268:	fef42223          	sw	a5,-28(s0)
    126c:	fe442783          	lw	a5,-28(s0)
    1270:	2781                	sext.w	a5,a5
    1272:	fbc5                	bnez	a5,1222 <printint+0x5a>
  if(neg)
    1274:	fe842783          	lw	a5,-24(s0)
    1278:	2781                	sext.w	a5,a5
    127a:	cf95                	beqz	a5,12b6 <printint+0xee>
    buf[i++] = '-';
    127c:	fec42783          	lw	a5,-20(s0)
    1280:	0017871b          	addiw	a4,a5,1
    1284:	fee42623          	sw	a4,-20(s0)
    1288:	ff040713          	addi	a4,s0,-16
    128c:	97ba                	add	a5,a5,a4
    128e:	02d00713          	li	a4,45
    1292:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    1296:	a005                	j	12b6 <printint+0xee>
    putc(fd, buf[i]);
    1298:	fec42783          	lw	a5,-20(s0)
    129c:	ff040713          	addi	a4,s0,-16
    12a0:	97ba                	add	a5,a5,a4
    12a2:	fe07c703          	lbu	a4,-32(a5)
    12a6:	fcc42783          	lw	a5,-52(s0)
    12aa:	85ba                	mv	a1,a4
    12ac:	853e                	mv	a0,a5
    12ae:	00000097          	auipc	ra,0x0
    12b2:	ee4080e7          	jalr	-284(ra) # 1192 <putc>
  while(--i >= 0)
    12b6:	fec42783          	lw	a5,-20(s0)
    12ba:	37fd                	addiw	a5,a5,-1
    12bc:	fef42623          	sw	a5,-20(s0)
    12c0:	fec42783          	lw	a5,-20(s0)
    12c4:	2781                	sext.w	a5,a5
    12c6:	fc07d9e3          	bgez	a5,1298 <printint+0xd0>
}
    12ca:	0001                	nop
    12cc:	0001                	nop
    12ce:	70e2                	ld	ra,56(sp)
    12d0:	7442                	ld	s0,48(sp)
    12d2:	6121                	addi	sp,sp,64
    12d4:	8082                	ret

00000000000012d6 <printptr>:

static void
printptr(int fd, uint64 x) {
    12d6:	7179                	addi	sp,sp,-48
    12d8:	f406                	sd	ra,40(sp)
    12da:	f022                	sd	s0,32(sp)
    12dc:	1800                	addi	s0,sp,48
    12de:	87aa                	mv	a5,a0
    12e0:	fcb43823          	sd	a1,-48(s0)
    12e4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    12e8:	fdc42783          	lw	a5,-36(s0)
    12ec:	03000593          	li	a1,48
    12f0:	853e                	mv	a0,a5
    12f2:	00000097          	auipc	ra,0x0
    12f6:	ea0080e7          	jalr	-352(ra) # 1192 <putc>
  putc(fd, 'x');
    12fa:	fdc42783          	lw	a5,-36(s0)
    12fe:	07800593          	li	a1,120
    1302:	853e                	mv	a0,a5
    1304:	00000097          	auipc	ra,0x0
    1308:	e8e080e7          	jalr	-370(ra) # 1192 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    130c:	fe042623          	sw	zero,-20(s0)
    1310:	a82d                	j	134a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1312:	fd043783          	ld	a5,-48(s0)
    1316:	93f1                	srli	a5,a5,0x3c
    1318:	00001717          	auipc	a4,0x1
    131c:	d8870713          	addi	a4,a4,-632 # 20a0 <digits>
    1320:	97ba                	add	a5,a5,a4
    1322:	0007c703          	lbu	a4,0(a5)
    1326:	fdc42783          	lw	a5,-36(s0)
    132a:	85ba                	mv	a1,a4
    132c:	853e                	mv	a0,a5
    132e:	00000097          	auipc	ra,0x0
    1332:	e64080e7          	jalr	-412(ra) # 1192 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1336:	fec42783          	lw	a5,-20(s0)
    133a:	2785                	addiw	a5,a5,1
    133c:	fef42623          	sw	a5,-20(s0)
    1340:	fd043783          	ld	a5,-48(s0)
    1344:	0792                	slli	a5,a5,0x4
    1346:	fcf43823          	sd	a5,-48(s0)
    134a:	fec42783          	lw	a5,-20(s0)
    134e:	873e                	mv	a4,a5
    1350:	47bd                	li	a5,15
    1352:	fce7f0e3          	bgeu	a5,a4,1312 <printptr+0x3c>
}
    1356:	0001                	nop
    1358:	0001                	nop
    135a:	70a2                	ld	ra,40(sp)
    135c:	7402                	ld	s0,32(sp)
    135e:	6145                	addi	sp,sp,48
    1360:	8082                	ret

0000000000001362 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1362:	715d                	addi	sp,sp,-80
    1364:	e486                	sd	ra,72(sp)
    1366:	e0a2                	sd	s0,64(sp)
    1368:	0880                	addi	s0,sp,80
    136a:	87aa                	mv	a5,a0
    136c:	fcb43023          	sd	a1,-64(s0)
    1370:	fac43c23          	sd	a2,-72(s0)
    1374:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    1378:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    137c:	fe042223          	sw	zero,-28(s0)
    1380:	a42d                	j	15aa <vprintf+0x248>
    c = fmt[i] & 0xff;
    1382:	fe442783          	lw	a5,-28(s0)
    1386:	fc043703          	ld	a4,-64(s0)
    138a:	97ba                	add	a5,a5,a4
    138c:	0007c783          	lbu	a5,0(a5)
    1390:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    1394:	fe042783          	lw	a5,-32(s0)
    1398:	2781                	sext.w	a5,a5
    139a:	eb9d                	bnez	a5,13d0 <vprintf+0x6e>
      if(c == '%'){
    139c:	fdc42783          	lw	a5,-36(s0)
    13a0:	0007871b          	sext.w	a4,a5
    13a4:	02500793          	li	a5,37
    13a8:	00f71763          	bne	a4,a5,13b6 <vprintf+0x54>
        state = '%';
    13ac:	02500793          	li	a5,37
    13b0:	fef42023          	sw	a5,-32(s0)
    13b4:	a2f5                	j	15a0 <vprintf+0x23e>
      } else {
        putc(fd, c);
    13b6:	fdc42783          	lw	a5,-36(s0)
    13ba:	0ff7f713          	andi	a4,a5,255
    13be:	fcc42783          	lw	a5,-52(s0)
    13c2:	85ba                	mv	a1,a4
    13c4:	853e                	mv	a0,a5
    13c6:	00000097          	auipc	ra,0x0
    13ca:	dcc080e7          	jalr	-564(ra) # 1192 <putc>
    13ce:	aac9                	j	15a0 <vprintf+0x23e>
      }
    } else if(state == '%'){
    13d0:	fe042783          	lw	a5,-32(s0)
    13d4:	0007871b          	sext.w	a4,a5
    13d8:	02500793          	li	a5,37
    13dc:	1cf71263          	bne	a4,a5,15a0 <vprintf+0x23e>
      if(c == 'd'){
    13e0:	fdc42783          	lw	a5,-36(s0)
    13e4:	0007871b          	sext.w	a4,a5
    13e8:	06400793          	li	a5,100
    13ec:	02f71463          	bne	a4,a5,1414 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    13f0:	fb843783          	ld	a5,-72(s0)
    13f4:	00878713          	addi	a4,a5,8
    13f8:	fae43c23          	sd	a4,-72(s0)
    13fc:	4398                	lw	a4,0(a5)
    13fe:	fcc42783          	lw	a5,-52(s0)
    1402:	4685                	li	a3,1
    1404:	4629                	li	a2,10
    1406:	85ba                	mv	a1,a4
    1408:	853e                	mv	a0,a5
    140a:	00000097          	auipc	ra,0x0
    140e:	dbe080e7          	jalr	-578(ra) # 11c8 <printint>
    1412:	a269                	j	159c <vprintf+0x23a>
      } else if(c == 'l') {
    1414:	fdc42783          	lw	a5,-36(s0)
    1418:	0007871b          	sext.w	a4,a5
    141c:	06c00793          	li	a5,108
    1420:	02f71663          	bne	a4,a5,144c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1424:	fb843783          	ld	a5,-72(s0)
    1428:	00878713          	addi	a4,a5,8
    142c:	fae43c23          	sd	a4,-72(s0)
    1430:	639c                	ld	a5,0(a5)
    1432:	0007871b          	sext.w	a4,a5
    1436:	fcc42783          	lw	a5,-52(s0)
    143a:	4681                	li	a3,0
    143c:	4629                	li	a2,10
    143e:	85ba                	mv	a1,a4
    1440:	853e                	mv	a0,a5
    1442:	00000097          	auipc	ra,0x0
    1446:	d86080e7          	jalr	-634(ra) # 11c8 <printint>
    144a:	aa89                	j	159c <vprintf+0x23a>
      } else if(c == 'x') {
    144c:	fdc42783          	lw	a5,-36(s0)
    1450:	0007871b          	sext.w	a4,a5
    1454:	07800793          	li	a5,120
    1458:	02f71463          	bne	a4,a5,1480 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    145c:	fb843783          	ld	a5,-72(s0)
    1460:	00878713          	addi	a4,a5,8
    1464:	fae43c23          	sd	a4,-72(s0)
    1468:	4398                	lw	a4,0(a5)
    146a:	fcc42783          	lw	a5,-52(s0)
    146e:	4681                	li	a3,0
    1470:	4641                	li	a2,16
    1472:	85ba                	mv	a1,a4
    1474:	853e                	mv	a0,a5
    1476:	00000097          	auipc	ra,0x0
    147a:	d52080e7          	jalr	-686(ra) # 11c8 <printint>
    147e:	aa39                	j	159c <vprintf+0x23a>
      } else if(c == 'p') {
    1480:	fdc42783          	lw	a5,-36(s0)
    1484:	0007871b          	sext.w	a4,a5
    1488:	07000793          	li	a5,112
    148c:	02f71263          	bne	a4,a5,14b0 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    1490:	fb843783          	ld	a5,-72(s0)
    1494:	00878713          	addi	a4,a5,8
    1498:	fae43c23          	sd	a4,-72(s0)
    149c:	6398                	ld	a4,0(a5)
    149e:	fcc42783          	lw	a5,-52(s0)
    14a2:	85ba                	mv	a1,a4
    14a4:	853e                	mv	a0,a5
    14a6:	00000097          	auipc	ra,0x0
    14aa:	e30080e7          	jalr	-464(ra) # 12d6 <printptr>
    14ae:	a0fd                	j	159c <vprintf+0x23a>
      } else if(c == 's'){
    14b0:	fdc42783          	lw	a5,-36(s0)
    14b4:	0007871b          	sext.w	a4,a5
    14b8:	07300793          	li	a5,115
    14bc:	04f71c63          	bne	a4,a5,1514 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    14c0:	fb843783          	ld	a5,-72(s0)
    14c4:	00878713          	addi	a4,a5,8
    14c8:	fae43c23          	sd	a4,-72(s0)
    14cc:	639c                	ld	a5,0(a5)
    14ce:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    14d2:	fe843783          	ld	a5,-24(s0)
    14d6:	eb8d                	bnez	a5,1508 <vprintf+0x1a6>
          s = "(null)";
    14d8:	00001797          	auipc	a5,0x1
    14dc:	ba078793          	addi	a5,a5,-1120 # 2078 <schedule_edf_cbs+0x588>
    14e0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    14e4:	a015                	j	1508 <vprintf+0x1a6>
          putc(fd, *s);
    14e6:	fe843783          	ld	a5,-24(s0)
    14ea:	0007c703          	lbu	a4,0(a5)
    14ee:	fcc42783          	lw	a5,-52(s0)
    14f2:	85ba                	mv	a1,a4
    14f4:	853e                	mv	a0,a5
    14f6:	00000097          	auipc	ra,0x0
    14fa:	c9c080e7          	jalr	-868(ra) # 1192 <putc>
          s++;
    14fe:	fe843783          	ld	a5,-24(s0)
    1502:	0785                	addi	a5,a5,1
    1504:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1508:	fe843783          	ld	a5,-24(s0)
    150c:	0007c783          	lbu	a5,0(a5)
    1510:	fbf9                	bnez	a5,14e6 <vprintf+0x184>
    1512:	a069                	j	159c <vprintf+0x23a>
        }
      } else if(c == 'c'){
    1514:	fdc42783          	lw	a5,-36(s0)
    1518:	0007871b          	sext.w	a4,a5
    151c:	06300793          	li	a5,99
    1520:	02f71463          	bne	a4,a5,1548 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    1524:	fb843783          	ld	a5,-72(s0)
    1528:	00878713          	addi	a4,a5,8
    152c:	fae43c23          	sd	a4,-72(s0)
    1530:	439c                	lw	a5,0(a5)
    1532:	0ff7f713          	andi	a4,a5,255
    1536:	fcc42783          	lw	a5,-52(s0)
    153a:	85ba                	mv	a1,a4
    153c:	853e                	mv	a0,a5
    153e:	00000097          	auipc	ra,0x0
    1542:	c54080e7          	jalr	-940(ra) # 1192 <putc>
    1546:	a899                	j	159c <vprintf+0x23a>
      } else if(c == '%'){
    1548:	fdc42783          	lw	a5,-36(s0)
    154c:	0007871b          	sext.w	a4,a5
    1550:	02500793          	li	a5,37
    1554:	00f71f63          	bne	a4,a5,1572 <vprintf+0x210>
        putc(fd, c);
    1558:	fdc42783          	lw	a5,-36(s0)
    155c:	0ff7f713          	andi	a4,a5,255
    1560:	fcc42783          	lw	a5,-52(s0)
    1564:	85ba                	mv	a1,a4
    1566:	853e                	mv	a0,a5
    1568:	00000097          	auipc	ra,0x0
    156c:	c2a080e7          	jalr	-982(ra) # 1192 <putc>
    1570:	a035                	j	159c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1572:	fcc42783          	lw	a5,-52(s0)
    1576:	02500593          	li	a1,37
    157a:	853e                	mv	a0,a5
    157c:	00000097          	auipc	ra,0x0
    1580:	c16080e7          	jalr	-1002(ra) # 1192 <putc>
        putc(fd, c);
    1584:	fdc42783          	lw	a5,-36(s0)
    1588:	0ff7f713          	andi	a4,a5,255
    158c:	fcc42783          	lw	a5,-52(s0)
    1590:	85ba                	mv	a1,a4
    1592:	853e                	mv	a0,a5
    1594:	00000097          	auipc	ra,0x0
    1598:	bfe080e7          	jalr	-1026(ra) # 1192 <putc>
      }
      state = 0;
    159c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    15a0:	fe442783          	lw	a5,-28(s0)
    15a4:	2785                	addiw	a5,a5,1
    15a6:	fef42223          	sw	a5,-28(s0)
    15aa:	fe442783          	lw	a5,-28(s0)
    15ae:	fc043703          	ld	a4,-64(s0)
    15b2:	97ba                	add	a5,a5,a4
    15b4:	0007c783          	lbu	a5,0(a5)
    15b8:	dc0795e3          	bnez	a5,1382 <vprintf+0x20>
    }
  }
}
    15bc:	0001                	nop
    15be:	0001                	nop
    15c0:	60a6                	ld	ra,72(sp)
    15c2:	6406                	ld	s0,64(sp)
    15c4:	6161                	addi	sp,sp,80
    15c6:	8082                	ret

00000000000015c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    15c8:	7159                	addi	sp,sp,-112
    15ca:	fc06                	sd	ra,56(sp)
    15cc:	f822                	sd	s0,48(sp)
    15ce:	0080                	addi	s0,sp,64
    15d0:	fcb43823          	sd	a1,-48(s0)
    15d4:	e010                	sd	a2,0(s0)
    15d6:	e414                	sd	a3,8(s0)
    15d8:	e818                	sd	a4,16(s0)
    15da:	ec1c                	sd	a5,24(s0)
    15dc:	03043023          	sd	a6,32(s0)
    15e0:	03143423          	sd	a7,40(s0)
    15e4:	87aa                	mv	a5,a0
    15e6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    15ea:	03040793          	addi	a5,s0,48
    15ee:	fcf43423          	sd	a5,-56(s0)
    15f2:	fc843783          	ld	a5,-56(s0)
    15f6:	fd078793          	addi	a5,a5,-48
    15fa:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    15fe:	fe843703          	ld	a4,-24(s0)
    1602:	fdc42783          	lw	a5,-36(s0)
    1606:	863a                	mv	a2,a4
    1608:	fd043583          	ld	a1,-48(s0)
    160c:	853e                	mv	a0,a5
    160e:	00000097          	auipc	ra,0x0
    1612:	d54080e7          	jalr	-684(ra) # 1362 <vprintf>
}
    1616:	0001                	nop
    1618:	70e2                	ld	ra,56(sp)
    161a:	7442                	ld	s0,48(sp)
    161c:	6165                	addi	sp,sp,112
    161e:	8082                	ret

0000000000001620 <printf>:

void
printf(const char *fmt, ...)
{
    1620:	7159                	addi	sp,sp,-112
    1622:	f406                	sd	ra,40(sp)
    1624:	f022                	sd	s0,32(sp)
    1626:	1800                	addi	s0,sp,48
    1628:	fca43c23          	sd	a0,-40(s0)
    162c:	e40c                	sd	a1,8(s0)
    162e:	e810                	sd	a2,16(s0)
    1630:	ec14                	sd	a3,24(s0)
    1632:	f018                	sd	a4,32(s0)
    1634:	f41c                	sd	a5,40(s0)
    1636:	03043823          	sd	a6,48(s0)
    163a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    163e:	04040793          	addi	a5,s0,64
    1642:	fcf43823          	sd	a5,-48(s0)
    1646:	fd043783          	ld	a5,-48(s0)
    164a:	fc878793          	addi	a5,a5,-56
    164e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1652:	fe843783          	ld	a5,-24(s0)
    1656:	863e                	mv	a2,a5
    1658:	fd843583          	ld	a1,-40(s0)
    165c:	4505                	li	a0,1
    165e:	00000097          	auipc	ra,0x0
    1662:	d04080e7          	jalr	-764(ra) # 1362 <vprintf>
}
    1666:	0001                	nop
    1668:	70a2                	ld	ra,40(sp)
    166a:	7402                	ld	s0,32(sp)
    166c:	6165                	addi	sp,sp,112
    166e:	8082                	ret

0000000000001670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1670:	7179                	addi	sp,sp,-48
    1672:	f422                	sd	s0,40(sp)
    1674:	1800                	addi	s0,sp,48
    1676:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    167a:	fd843783          	ld	a5,-40(s0)
    167e:	17c1                	addi	a5,a5,-16
    1680:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1684:	00001797          	auipc	a5,0x1
    1688:	a6478793          	addi	a5,a5,-1436 # 20e8 <freep>
    168c:	639c                	ld	a5,0(a5)
    168e:	fef43423          	sd	a5,-24(s0)
    1692:	a815                	j	16c6 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1694:	fe843783          	ld	a5,-24(s0)
    1698:	639c                	ld	a5,0(a5)
    169a:	fe843703          	ld	a4,-24(s0)
    169e:	00f76f63          	bltu	a4,a5,16bc <free+0x4c>
    16a2:	fe043703          	ld	a4,-32(s0)
    16a6:	fe843783          	ld	a5,-24(s0)
    16aa:	02e7eb63          	bltu	a5,a4,16e0 <free+0x70>
    16ae:	fe843783          	ld	a5,-24(s0)
    16b2:	639c                	ld	a5,0(a5)
    16b4:	fe043703          	ld	a4,-32(s0)
    16b8:	02f76463          	bltu	a4,a5,16e0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16bc:	fe843783          	ld	a5,-24(s0)
    16c0:	639c                	ld	a5,0(a5)
    16c2:	fef43423          	sd	a5,-24(s0)
    16c6:	fe043703          	ld	a4,-32(s0)
    16ca:	fe843783          	ld	a5,-24(s0)
    16ce:	fce7f3e3          	bgeu	a5,a4,1694 <free+0x24>
    16d2:	fe843783          	ld	a5,-24(s0)
    16d6:	639c                	ld	a5,0(a5)
    16d8:	fe043703          	ld	a4,-32(s0)
    16dc:	faf77ce3          	bgeu	a4,a5,1694 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16e0:	fe043783          	ld	a5,-32(s0)
    16e4:	479c                	lw	a5,8(a5)
    16e6:	1782                	slli	a5,a5,0x20
    16e8:	9381                	srli	a5,a5,0x20
    16ea:	0792                	slli	a5,a5,0x4
    16ec:	fe043703          	ld	a4,-32(s0)
    16f0:	973e                	add	a4,a4,a5
    16f2:	fe843783          	ld	a5,-24(s0)
    16f6:	639c                	ld	a5,0(a5)
    16f8:	02f71763          	bne	a4,a5,1726 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    16fc:	fe043783          	ld	a5,-32(s0)
    1700:	4798                	lw	a4,8(a5)
    1702:	fe843783          	ld	a5,-24(s0)
    1706:	639c                	ld	a5,0(a5)
    1708:	479c                	lw	a5,8(a5)
    170a:	9fb9                	addw	a5,a5,a4
    170c:	0007871b          	sext.w	a4,a5
    1710:	fe043783          	ld	a5,-32(s0)
    1714:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    1716:	fe843783          	ld	a5,-24(s0)
    171a:	639c                	ld	a5,0(a5)
    171c:	6398                	ld	a4,0(a5)
    171e:	fe043783          	ld	a5,-32(s0)
    1722:	e398                	sd	a4,0(a5)
    1724:	a039                	j	1732 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    1726:	fe843783          	ld	a5,-24(s0)
    172a:	6398                	ld	a4,0(a5)
    172c:	fe043783          	ld	a5,-32(s0)
    1730:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1732:	fe843783          	ld	a5,-24(s0)
    1736:	479c                	lw	a5,8(a5)
    1738:	1782                	slli	a5,a5,0x20
    173a:	9381                	srli	a5,a5,0x20
    173c:	0792                	slli	a5,a5,0x4
    173e:	fe843703          	ld	a4,-24(s0)
    1742:	97ba                	add	a5,a5,a4
    1744:	fe043703          	ld	a4,-32(s0)
    1748:	02f71563          	bne	a4,a5,1772 <free+0x102>
    p->s.size += bp->s.size;
    174c:	fe843783          	ld	a5,-24(s0)
    1750:	4798                	lw	a4,8(a5)
    1752:	fe043783          	ld	a5,-32(s0)
    1756:	479c                	lw	a5,8(a5)
    1758:	9fb9                	addw	a5,a5,a4
    175a:	0007871b          	sext.w	a4,a5
    175e:	fe843783          	ld	a5,-24(s0)
    1762:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1764:	fe043783          	ld	a5,-32(s0)
    1768:	6398                	ld	a4,0(a5)
    176a:	fe843783          	ld	a5,-24(s0)
    176e:	e398                	sd	a4,0(a5)
    1770:	a031                	j	177c <free+0x10c>
  } else
    p->s.ptr = bp;
    1772:	fe843783          	ld	a5,-24(s0)
    1776:	fe043703          	ld	a4,-32(s0)
    177a:	e398                	sd	a4,0(a5)
  freep = p;
    177c:	00001797          	auipc	a5,0x1
    1780:	96c78793          	addi	a5,a5,-1684 # 20e8 <freep>
    1784:	fe843703          	ld	a4,-24(s0)
    1788:	e398                	sd	a4,0(a5)
}
    178a:	0001                	nop
    178c:	7422                	ld	s0,40(sp)
    178e:	6145                	addi	sp,sp,48
    1790:	8082                	ret

0000000000001792 <morecore>:

static Header*
morecore(uint nu)
{
    1792:	7179                	addi	sp,sp,-48
    1794:	f406                	sd	ra,40(sp)
    1796:	f022                	sd	s0,32(sp)
    1798:	1800                	addi	s0,sp,48
    179a:	87aa                	mv	a5,a0
    179c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    17a0:	fdc42783          	lw	a5,-36(s0)
    17a4:	0007871b          	sext.w	a4,a5
    17a8:	6785                	lui	a5,0x1
    17aa:	00f77563          	bgeu	a4,a5,17b4 <morecore+0x22>
    nu = 4096;
    17ae:	6785                	lui	a5,0x1
    17b0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    17b4:	fdc42783          	lw	a5,-36(s0)
    17b8:	0047979b          	slliw	a5,a5,0x4
    17bc:	2781                	sext.w	a5,a5
    17be:	2781                	sext.w	a5,a5
    17c0:	853e                	mv	a0,a5
    17c2:	00000097          	auipc	ra,0x0
    17c6:	9a0080e7          	jalr	-1632(ra) # 1162 <sbrk>
    17ca:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    17ce:	fe843703          	ld	a4,-24(s0)
    17d2:	57fd                	li	a5,-1
    17d4:	00f71463          	bne	a4,a5,17dc <morecore+0x4a>
    return 0;
    17d8:	4781                	li	a5,0
    17da:	a03d                	j	1808 <morecore+0x76>
  hp = (Header*)p;
    17dc:	fe843783          	ld	a5,-24(s0)
    17e0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    17e4:	fe043783          	ld	a5,-32(s0)
    17e8:	fdc42703          	lw	a4,-36(s0)
    17ec:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    17ee:	fe043783          	ld	a5,-32(s0)
    17f2:	07c1                	addi	a5,a5,16
    17f4:	853e                	mv	a0,a5
    17f6:	00000097          	auipc	ra,0x0
    17fa:	e7a080e7          	jalr	-390(ra) # 1670 <free>
  return freep;
    17fe:	00001797          	auipc	a5,0x1
    1802:	8ea78793          	addi	a5,a5,-1814 # 20e8 <freep>
    1806:	639c                	ld	a5,0(a5)
}
    1808:	853e                	mv	a0,a5
    180a:	70a2                	ld	ra,40(sp)
    180c:	7402                	ld	s0,32(sp)
    180e:	6145                	addi	sp,sp,48
    1810:	8082                	ret

0000000000001812 <malloc>:

void*
malloc(uint nbytes)
{
    1812:	7139                	addi	sp,sp,-64
    1814:	fc06                	sd	ra,56(sp)
    1816:	f822                	sd	s0,48(sp)
    1818:	0080                	addi	s0,sp,64
    181a:	87aa                	mv	a5,a0
    181c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1820:	fcc46783          	lwu	a5,-52(s0)
    1824:	07bd                	addi	a5,a5,15
    1826:	8391                	srli	a5,a5,0x4
    1828:	2781                	sext.w	a5,a5
    182a:	2785                	addiw	a5,a5,1
    182c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1830:	00001797          	auipc	a5,0x1
    1834:	8b878793          	addi	a5,a5,-1864 # 20e8 <freep>
    1838:	639c                	ld	a5,0(a5)
    183a:	fef43023          	sd	a5,-32(s0)
    183e:	fe043783          	ld	a5,-32(s0)
    1842:	ef95                	bnez	a5,187e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1844:	00001797          	auipc	a5,0x1
    1848:	89478793          	addi	a5,a5,-1900 # 20d8 <base>
    184c:	fef43023          	sd	a5,-32(s0)
    1850:	00001797          	auipc	a5,0x1
    1854:	89878793          	addi	a5,a5,-1896 # 20e8 <freep>
    1858:	fe043703          	ld	a4,-32(s0)
    185c:	e398                	sd	a4,0(a5)
    185e:	00001797          	auipc	a5,0x1
    1862:	88a78793          	addi	a5,a5,-1910 # 20e8 <freep>
    1866:	6398                	ld	a4,0(a5)
    1868:	00001797          	auipc	a5,0x1
    186c:	87078793          	addi	a5,a5,-1936 # 20d8 <base>
    1870:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1872:	00001797          	auipc	a5,0x1
    1876:	86678793          	addi	a5,a5,-1946 # 20d8 <base>
    187a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    187e:	fe043783          	ld	a5,-32(s0)
    1882:	639c                	ld	a5,0(a5)
    1884:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1888:	fe843783          	ld	a5,-24(s0)
    188c:	4798                	lw	a4,8(a5)
    188e:	fdc42783          	lw	a5,-36(s0)
    1892:	2781                	sext.w	a5,a5
    1894:	06f76863          	bltu	a4,a5,1904 <malloc+0xf2>
      if(p->s.size == nunits)
    1898:	fe843783          	ld	a5,-24(s0)
    189c:	4798                	lw	a4,8(a5)
    189e:	fdc42783          	lw	a5,-36(s0)
    18a2:	2781                	sext.w	a5,a5
    18a4:	00e79963          	bne	a5,a4,18b6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    18a8:	fe843783          	ld	a5,-24(s0)
    18ac:	6398                	ld	a4,0(a5)
    18ae:	fe043783          	ld	a5,-32(s0)
    18b2:	e398                	sd	a4,0(a5)
    18b4:	a82d                	j	18ee <malloc+0xdc>
      else {
        p->s.size -= nunits;
    18b6:	fe843783          	ld	a5,-24(s0)
    18ba:	4798                	lw	a4,8(a5)
    18bc:	fdc42783          	lw	a5,-36(s0)
    18c0:	40f707bb          	subw	a5,a4,a5
    18c4:	0007871b          	sext.w	a4,a5
    18c8:	fe843783          	ld	a5,-24(s0)
    18cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
    18ce:	fe843783          	ld	a5,-24(s0)
    18d2:	479c                	lw	a5,8(a5)
    18d4:	1782                	slli	a5,a5,0x20
    18d6:	9381                	srli	a5,a5,0x20
    18d8:	0792                	slli	a5,a5,0x4
    18da:	fe843703          	ld	a4,-24(s0)
    18de:	97ba                	add	a5,a5,a4
    18e0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    18e4:	fe843783          	ld	a5,-24(s0)
    18e8:	fdc42703          	lw	a4,-36(s0)
    18ec:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    18ee:	00000797          	auipc	a5,0x0
    18f2:	7fa78793          	addi	a5,a5,2042 # 20e8 <freep>
    18f6:	fe043703          	ld	a4,-32(s0)
    18fa:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    18fc:	fe843783          	ld	a5,-24(s0)
    1900:	07c1                	addi	a5,a5,16
    1902:	a091                	j	1946 <malloc+0x134>
    }
    if(p == freep)
    1904:	00000797          	auipc	a5,0x0
    1908:	7e478793          	addi	a5,a5,2020 # 20e8 <freep>
    190c:	639c                	ld	a5,0(a5)
    190e:	fe843703          	ld	a4,-24(s0)
    1912:	02f71063          	bne	a4,a5,1932 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    1916:	fdc42783          	lw	a5,-36(s0)
    191a:	853e                	mv	a0,a5
    191c:	00000097          	auipc	ra,0x0
    1920:	e76080e7          	jalr	-394(ra) # 1792 <morecore>
    1924:	fea43423          	sd	a0,-24(s0)
    1928:	fe843783          	ld	a5,-24(s0)
    192c:	e399                	bnez	a5,1932 <malloc+0x120>
        return 0;
    192e:	4781                	li	a5,0
    1930:	a819                	j	1946 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1932:	fe843783          	ld	a5,-24(s0)
    1936:	fef43023          	sd	a5,-32(s0)
    193a:	fe843783          	ld	a5,-24(s0)
    193e:	639c                	ld	a5,0(a5)
    1940:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1944:	b791                	j	1888 <malloc+0x76>
  }
}
    1946:	853e                	mv	a0,a5
    1948:	70e2                	ld	ra,56(sp)
    194a:	7442                	ld	s0,48(sp)
    194c:	6121                	addi	sp,sp,64
    194e:	8082                	ret

0000000000001950 <setjmp>:
    1950:	e100                	sd	s0,0(a0)
    1952:	e504                	sd	s1,8(a0)
    1954:	01253823          	sd	s2,16(a0)
    1958:	01353c23          	sd	s3,24(a0)
    195c:	03453023          	sd	s4,32(a0)
    1960:	03553423          	sd	s5,40(a0)
    1964:	03653823          	sd	s6,48(a0)
    1968:	03753c23          	sd	s7,56(a0)
    196c:	05853023          	sd	s8,64(a0)
    1970:	05953423          	sd	s9,72(a0)
    1974:	05a53823          	sd	s10,80(a0)
    1978:	05b53c23          	sd	s11,88(a0)
    197c:	06153023          	sd	ra,96(a0)
    1980:	06253423          	sd	sp,104(a0)
    1984:	4501                	li	a0,0
    1986:	8082                	ret

0000000000001988 <longjmp>:
    1988:	6100                	ld	s0,0(a0)
    198a:	6504                	ld	s1,8(a0)
    198c:	01053903          	ld	s2,16(a0)
    1990:	01853983          	ld	s3,24(a0)
    1994:	02053a03          	ld	s4,32(a0)
    1998:	02853a83          	ld	s5,40(a0)
    199c:	03053b03          	ld	s6,48(a0)
    19a0:	03853b83          	ld	s7,56(a0)
    19a4:	04053c03          	ld	s8,64(a0)
    19a8:	04853c83          	ld	s9,72(a0)
    19ac:	05053d03          	ld	s10,80(a0)
    19b0:	05853d83          	ld	s11,88(a0)
    19b4:	06053083          	ld	ra,96(a0)
    19b8:	06853103          	ld	sp,104(a0)
    19bc:	c199                	beqz	a1,19c2 <longjmp_1>
    19be:	852e                	mv	a0,a1
    19c0:	8082                	ret

00000000000019c2 <longjmp_1>:
    19c2:	4505                	li	a0,1
    19c4:	8082                	ret

00000000000019c6 <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
    19c6:	7139                	addi	sp,sp,-64
    19c8:	fc22                	sd	s0,56(sp)
    19ca:	0080                	addi	s0,sp,64
    19cc:	fca43423          	sd	a0,-56(s0)
    19d0:	87ae                	mv	a5,a1
    19d2:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
    19d6:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
    19da:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
    19de:	fc843783          	ld	a5,-56(s0)
    19e2:	639c                	ld	a5,0(a5)
    19e4:	fcf43c23          	sd	a5,-40(s0)
    19e8:	fd843783          	ld	a5,-40(s0)
    19ec:	fd878793          	addi	a5,a5,-40
    19f0:	fef43423          	sd	a5,-24(s0)
    19f4:	a881                	j	1a44 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
    19f6:	fe843783          	ld	a5,-24(s0)
    19fa:	4fb8                	lw	a4,88(a5)
    19fc:	fc442783          	lw	a5,-60(s0)
    1a00:	2781                	sext.w	a5,a5
    1a02:	02e7c663          	blt	a5,a4,1a2e <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
    1a06:	fe043783          	ld	a5,-32(s0)
    1a0a:	e791                	bnez	a5,1a16 <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
    1a0c:	fe843783          	ld	a5,-24(s0)
    1a10:	fef43023          	sd	a5,-32(s0)
    1a14:	a829                	j	1a2e <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
    1a16:	fe843783          	ld	a5,-24(s0)
    1a1a:	5fd8                	lw	a4,60(a5)
    1a1c:	fe043783          	ld	a5,-32(s0)
    1a20:	5fdc                	lw	a5,60(a5)
    1a22:	00f75663          	bge	a4,a5,1a2e <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
    1a26:	fe843783          	ld	a5,-24(s0)
    1a2a:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
    1a2e:	fe843783          	ld	a5,-24(s0)
    1a32:	779c                	ld	a5,40(a5)
    1a34:	fcf43823          	sd	a5,-48(s0)
    1a38:	fd043783          	ld	a5,-48(s0)
    1a3c:	fd878793          	addi	a5,a5,-40
    1a40:	fef43423          	sd	a5,-24(s0)
    1a44:	fe843783          	ld	a5,-24(s0)
    1a48:	02878793          	addi	a5,a5,40
    1a4c:	fc843703          	ld	a4,-56(s0)
    1a50:	faf713e3          	bne	a4,a5,19f6 <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
    1a54:	fe043783          	ld	a5,-32(s0)
}
    1a58:	853e                	mv	a0,a5
    1a5a:	7462                	ld	s0,56(sp)
    1a5c:	6121                	addi	sp,sp,64
    1a5e:	8082                	ret

0000000000001a60 <__edf_thread_cmp>:


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
    1a60:	1101                	addi	sp,sp,-32
    1a62:	ec22                	sd	s0,24(sp)
    1a64:	1000                	addi	s0,sp,32
    1a66:	fea43423          	sd	a0,-24(s0)
    1a6a:	feb43023          	sd	a1,-32(s0)
    // Hard real-time tasks have priority over soft real-time tasks
    if (a->cbs.is_hard_rt && !b->cbs.is_hard_rt) return -1;
    1a6e:	fe843783          	ld	a5,-24(s0)
    1a72:	57fc                	lw	a5,108(a5)
    1a74:	c799                	beqz	a5,1a82 <__edf_thread_cmp+0x22>
    1a76:	fe043783          	ld	a5,-32(s0)
    1a7a:	57fc                	lw	a5,108(a5)
    1a7c:	e399                	bnez	a5,1a82 <__edf_thread_cmp+0x22>
    1a7e:	57fd                	li	a5,-1
    1a80:	a0a5                	j	1ae8 <__edf_thread_cmp+0x88>
    if (!a->cbs.is_hard_rt && b->cbs.is_hard_rt) return 1;
    1a82:	fe843783          	ld	a5,-24(s0)
    1a86:	57fc                	lw	a5,108(a5)
    1a88:	e799                	bnez	a5,1a96 <__edf_thread_cmp+0x36>
    1a8a:	fe043783          	ld	a5,-32(s0)
    1a8e:	57fc                	lw	a5,108(a5)
    1a90:	c399                	beqz	a5,1a96 <__edf_thread_cmp+0x36>
    1a92:	4785                	li	a5,1
    1a94:	a891                	j	1ae8 <__edf_thread_cmp+0x88>
    
    // Compare deadlines
    if (a->current_deadline < b->current_deadline) return -1;
    1a96:	fe843783          	ld	a5,-24(s0)
    1a9a:	4fb8                	lw	a4,88(a5)
    1a9c:	fe043783          	ld	a5,-32(s0)
    1aa0:	4fbc                	lw	a5,88(a5)
    1aa2:	00f75463          	bge	a4,a5,1aaa <__edf_thread_cmp+0x4a>
    1aa6:	57fd                	li	a5,-1
    1aa8:	a081                	j	1ae8 <__edf_thread_cmp+0x88>
    if (a->current_deadline > b->current_deadline) return 1;
    1aaa:	fe843783          	ld	a5,-24(s0)
    1aae:	4fb8                	lw	a4,88(a5)
    1ab0:	fe043783          	ld	a5,-32(s0)
    1ab4:	4fbc                	lw	a5,88(a5)
    1ab6:	00e7d463          	bge	a5,a4,1abe <__edf_thread_cmp+0x5e>
    1aba:	4785                	li	a5,1
    1abc:	a035                	j	1ae8 <__edf_thread_cmp+0x88>
    
    // Break ties using thread ID
    if (a->ID < b->ID) return -1;
    1abe:	fe843783          	ld	a5,-24(s0)
    1ac2:	5fd8                	lw	a4,60(a5)
    1ac4:	fe043783          	ld	a5,-32(s0)
    1ac8:	5fdc                	lw	a5,60(a5)
    1aca:	00f75463          	bge	a4,a5,1ad2 <__edf_thread_cmp+0x72>
    1ace:	57fd                	li	a5,-1
    1ad0:	a821                	j	1ae8 <__edf_thread_cmp+0x88>
    if (a->ID > b->ID) return 1;
    1ad2:	fe843783          	ld	a5,-24(s0)
    1ad6:	5fd8                	lw	a4,60(a5)
    1ad8:	fe043783          	ld	a5,-32(s0)
    1adc:	5fdc                	lw	a5,60(a5)
    1ade:	00e7d463          	bge	a5,a4,1ae6 <__edf_thread_cmp+0x86>
    1ae2:	4785                	li	a5,1
    1ae4:	a011                	j	1ae8 <__edf_thread_cmp+0x88>
    
    return 0;
    1ae6:	4781                	li	a5,0
}
    1ae8:	853e                	mv	a0,a5
    1aea:	6462                	ld	s0,24(sp)
    1aec:	6105                	addi	sp,sp,32
    1aee:	8082                	ret

0000000000001af0 <schedule_edf_cbs>:

//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
    1af0:	7151                	addi	sp,sp,-240
    1af2:	f586                	sd	ra,232(sp)
    1af4:	f1a2                	sd	s0,224(sp)
    1af6:	eda6                	sd	s1,216(sp)
    1af8:	e9ca                	sd	s2,208(sp)
    1afa:	e5ce                	sd	s3,200(sp)
    1afc:	1980                	addi	s0,sp,240
    1afe:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *t;

start_scheduling:    // Label to reevaluate scheduling decision after replenishing
    // Reset the result structure each time we restart
    r.scheduled_thread_list_member = NULL;
    1b00:	f0043823          	sd	zero,-240(s0)
    r.allocated_time = 0;
    1b04:	f0042c23          	sw	zero,-232(s0)

    // 1. Notify the throttle task
    list_for_each_entry(t, args.run_queue, thread_list) {
    1b08:	649c                	ld	a5,8(s1)
    1b0a:	639c                	ld	a5,0(a5)
    1b0c:	f8f43c23          	sd	a5,-104(s0)
    1b10:	f9843783          	ld	a5,-104(s0)
    1b14:	fd878793          	addi	a5,a5,-40
    1b18:	fcf43423          	sd	a5,-56(s0)
    1b1c:	a8b1                	j	1b78 <schedule_edf_cbs+0x88>
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1b1e:	fc843783          	ld	a5,-56(s0)
    1b22:	57bc                	lw	a5,104(a5)
    1b24:	02f04f63          	bgtz	a5,1b62 <schedule_edf_cbs+0x72>
    1b28:	fc843783          	ld	a5,-56(s0)
    1b2c:	4bfc                	lw	a5,84(a5)
    1b2e:	02f05a63          	blez	a5,1b62 <schedule_edf_cbs+0x72>
            args.current_time == t->current_deadline) {
    1b32:	4098                	lw	a4,0(s1)
    1b34:	fc843783          	ld	a5,-56(s0)
    1b38:	4fbc                	lw	a5,88(a5)
        if (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1b3a:	02f71463          	bne	a4,a5,1b62 <schedule_edf_cbs+0x72>
            // replenish
            t->current_deadline += t->period;
    1b3e:	fc843783          	ld	a5,-56(s0)
    1b42:	4fb8                	lw	a4,88(a5)
    1b44:	fc843783          	ld	a5,-56(s0)
    1b48:	47fc                	lw	a5,76(a5)
    1b4a:	9fb9                	addw	a5,a5,a4
    1b4c:	0007871b          	sext.w	a4,a5
    1b50:	fc843783          	ld	a5,-56(s0)
    1b54:	cfb8                	sw	a4,88(a5)
            t->cbs.remaining_budget = t->cbs.budget;
    1b56:	fc843783          	ld	a5,-56(s0)
    1b5a:	53f8                	lw	a4,100(a5)
    1b5c:	fc843783          	ld	a5,-56(s0)
    1b60:	d7b8                	sw	a4,104(a5)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1b62:	fc843783          	ld	a5,-56(s0)
    1b66:	779c                	ld	a5,40(a5)
    1b68:	f2f43823          	sd	a5,-208(s0)
    1b6c:	f3043783          	ld	a5,-208(s0)
    1b70:	fd878793          	addi	a5,a5,-40
    1b74:	fcf43423          	sd	a5,-56(s0)
    1b78:	fc843783          	ld	a5,-56(s0)
    1b7c:	02878713          	addi	a4,a5,40
    1b80:	649c                	ld	a5,8(s1)
    1b82:	f8f71ee3          	bne	a4,a5,1b1e <schedule_edf_cbs+0x2e>
        }
    }

    // 2. Check if there is any thread has missed its current deadline 
    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    1b86:	649c                	ld	a5,8(s1)
    1b88:	4098                	lw	a4,0(s1)
    1b8a:	85ba                	mv	a1,a4
    1b8c:	853e                	mv	a0,a5
    1b8e:	00000097          	auipc	ra,0x0
    1b92:	e38080e7          	jalr	-456(ra) # 19c6 <__check_deadline_miss>
    1b96:	f8a43823          	sd	a0,-112(s0)
    if (missed) {
    1b9a:	f9043783          	ld	a5,-112(s0)
    1b9e:	c395                	beqz	a5,1bc2 <schedule_edf_cbs+0xd2>
        r.scheduled_thread_list_member = &missed->thread_list;
    1ba0:	f9043783          	ld	a5,-112(s0)
    1ba4:	02878793          	addi	a5,a5,40
    1ba8:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = 0;
    1bac:	f0042c23          	sw	zero,-232(s0)
        return r;
    1bb0:	f1043783          	ld	a5,-240(s0)
    1bb4:	f2f43023          	sd	a5,-224(s0)
    1bb8:	f1843783          	ld	a5,-232(s0)
    1bbc:	f2f43423          	sd	a5,-216(s0)
    1bc0:	ae19                	j	1ed6 <schedule_edf_cbs+0x3e6>
    }

    // 3. Find the best thread according to EDF
    struct thread *selected = NULL;
    1bc2:	fc043023          	sd	zero,-64(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1bc6:	649c                	ld	a5,8(s1)
    1bc8:	639c                	ld	a5,0(a5)
    1bca:	f8f43423          	sd	a5,-120(s0)
    1bce:	f8843783          	ld	a5,-120(s0)
    1bd2:	fd878793          	addi	a5,a5,-40
    1bd6:	fcf43423          	sd	a5,-56(s0)
    1bda:	a0ad                	j	1c44 <schedule_edf_cbs+0x154>
        // skip finished or throttled threads
        if (t->remaining_time <= 0 || 
    1bdc:	fc843783          	ld	a5,-56(s0)
    1be0:	4bfc                	lw	a5,84(a5)
    1be2:	04f05563          	blez	a5,1c2c <schedule_edf_cbs+0x13c>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1be6:	fc843783          	ld	a5,-56(s0)
    1bea:	57bc                	lw	a5,104(a5)
        if (t->remaining_time <= 0 || 
    1bec:	00f04d63          	bgtz	a5,1c06 <schedule_edf_cbs+0x116>
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1bf0:	fc843783          	ld	a5,-56(s0)
    1bf4:	4bfc                	lw	a5,84(a5)
    1bf6:	00f05863          	blez	a5,1c06 <schedule_edf_cbs+0x116>
             args.current_time < t->current_deadline))
    1bfa:	4098                	lw	a4,0(s1)
    1bfc:	fc843783          	ld	a5,-56(s0)
    1c00:	4fbc                	lw	a5,88(a5)
            (t->cbs.remaining_budget <= 0 && t->remaining_time > 0 && 
    1c02:	02f74563          	blt	a4,a5,1c2c <schedule_edf_cbs+0x13c>
            continue;

        if (!selected || __edf_thread_cmp(t, selected) < 0)
    1c06:	fc043783          	ld	a5,-64(s0)
    1c0a:	cf81                	beqz	a5,1c22 <schedule_edf_cbs+0x132>
    1c0c:	fc043583          	ld	a1,-64(s0)
    1c10:	fc843503          	ld	a0,-56(s0)
    1c14:	00000097          	auipc	ra,0x0
    1c18:	e4c080e7          	jalr	-436(ra) # 1a60 <__edf_thread_cmp>
    1c1c:	87aa                	mv	a5,a0
    1c1e:	0007d863          	bgez	a5,1c2e <schedule_edf_cbs+0x13e>
            selected = t;
    1c22:	fc843783          	ld	a5,-56(s0)
    1c26:	fcf43023          	sd	a5,-64(s0)
    1c2a:	a011                	j	1c2e <schedule_edf_cbs+0x13e>
            continue;
    1c2c:	0001                	nop
    list_for_each_entry(t, args.run_queue, thread_list) {
    1c2e:	fc843783          	ld	a5,-56(s0)
    1c32:	779c                	ld	a5,40(a5)
    1c34:	f2f43c23          	sd	a5,-200(s0)
    1c38:	f3843783          	ld	a5,-200(s0)
    1c3c:	fd878793          	addi	a5,a5,-40
    1c40:	fcf43423          	sd	a5,-56(s0)
    1c44:	fc843783          	ld	a5,-56(s0)
    1c48:	02878713          	addi	a4,a5,40
    1c4c:	649c                	ld	a5,8(s1)
    1c4e:	f8f717e3          	bne	a4,a5,1bdc <schedule_edf_cbs+0xec>
    }

    // 4. If no valid thread is found, find the next release time
    if (!selected) {
    1c52:	fc043783          	ld	a5,-64(s0)
    1c56:	ebd5                	bnez	a5,1d0a <schedule_edf_cbs+0x21a>
        int next_release = INT_MAX;
    1c58:	800007b7          	lui	a5,0x80000
    1c5c:	fff7c793          	not	a5,a5
    1c60:	faf42e23          	sw	a5,-68(s0)
        struct release_queue_entry *rqe = NULL;
    1c64:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1c68:	689c                	ld	a5,16(s1)
    1c6a:	639c                	ld	a5,0(a5)
    1c6c:	f4f43423          	sd	a5,-184(s0)
    1c70:	f4843783          	ld	a5,-184(s0)
    1c74:	17e1                	addi	a5,a5,-8
    1c76:	faf43823          	sd	a5,-80(s0)
    1c7a:	a835                	j	1cb6 <schedule_edf_cbs+0x1c6>
            if (rqe->release_time > args.current_time && rqe->release_time < next_release) {
    1c7c:	fb043783          	ld	a5,-80(s0)
    1c80:	4f98                	lw	a4,24(a5)
    1c82:	409c                	lw	a5,0(s1)
    1c84:	00e7df63          	bge	a5,a4,1ca2 <schedule_edf_cbs+0x1b2>
    1c88:	fb043783          	ld	a5,-80(s0)
    1c8c:	4f98                	lw	a4,24(a5)
    1c8e:	fbc42783          	lw	a5,-68(s0)
    1c92:	2781                	sext.w	a5,a5
    1c94:	00f75763          	bge	a4,a5,1ca2 <schedule_edf_cbs+0x1b2>
                next_release = rqe->release_time;
    1c98:	fb043783          	ld	a5,-80(s0)
    1c9c:	4f9c                	lw	a5,24(a5)
    1c9e:	faf42e23          	sw	a5,-68(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1ca2:	fb043783          	ld	a5,-80(s0)
    1ca6:	679c                	ld	a5,8(a5)
    1ca8:	f4f43023          	sd	a5,-192(s0)
    1cac:	f4043783          	ld	a5,-192(s0)
    1cb0:	17e1                	addi	a5,a5,-8
    1cb2:	faf43823          	sd	a5,-80(s0)
    1cb6:	fb043783          	ld	a5,-80(s0)
    1cba:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffd788>
    1cbe:	689c                	ld	a5,16(s1)
    1cc0:	faf71ee3          	bne	a4,a5,1c7c <schedule_edf_cbs+0x18c>
            }
        }
        
        if (next_release != INT_MAX) {
    1cc4:	fbc42783          	lw	a5,-68(s0)
    1cc8:	0007871b          	sext.w	a4,a5
    1ccc:	800007b7          	lui	a5,0x80000
    1cd0:	fff7c793          	not	a5,a5
    1cd4:	00f70e63          	beq	a4,a5,1cf0 <schedule_edf_cbs+0x200>
            // Sleep until next release
            r.scheduled_thread_list_member = args.run_queue;
    1cd8:	649c                	ld	a5,8(s1)
    1cda:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = next_release - args.current_time;
    1cde:	409c                	lw	a5,0(s1)
    1ce0:	fbc42703          	lw	a4,-68(s0)
    1ce4:	40f707bb          	subw	a5,a4,a5
    1ce8:	2781                	sext.w	a5,a5
    1cea:	f0f42c23          	sw	a5,-232(s0)
    1cee:	a029                	j	1cf8 <schedule_edf_cbs+0x208>
        } else {
            // No future releases
            r.scheduled_thread_list_member = NULL;
    1cf0:	f0043823          	sd	zero,-240(s0)
            r.allocated_time = 0;
    1cf4:	f0042c23          	sw	zero,-232(s0)
        }
        return r;
    1cf8:	f1043783          	ld	a5,-240(s0)
    1cfc:	f2f43023          	sd	a5,-224(s0)
    1d00:	f1843783          	ld	a5,-232(s0)
    1d04:	f2f43423          	sd	a5,-216(s0)
    1d08:	a2f9                	j	1ed6 <schedule_edf_cbs+0x3e6>
    }

    // 5. CBS admission control (for soft real-time tasks only)
    if (!selected->cbs.is_hard_rt) {
    1d0a:	fc043783          	ld	a5,-64(s0)
    1d0e:	57fc                	lw	a5,108(a5)
    1d10:	e7f1                	bnez	a5,1ddc <schedule_edf_cbs+0x2ec>
        int remaining_budget = selected->cbs.remaining_budget;
    1d12:	fc043783          	ld	a5,-64(s0)
    1d16:	57bc                	lw	a5,104(a5)
    1d18:	f4f42e23          	sw	a5,-164(s0)
        int time_until_deadline = selected->current_deadline - args.current_time;
    1d1c:	fc043783          	ld	a5,-64(s0)
    1d20:	4fb8                	lw	a4,88(a5)
    1d22:	409c                	lw	a5,0(s1)
    1d24:	40f707bb          	subw	a5,a4,a5
    1d28:	f4f42c23          	sw	a5,-168(s0)
        int scaled_left = remaining_budget * selected->period;
    1d2c:	fc043783          	ld	a5,-64(s0)
    1d30:	47fc                	lw	a5,76(a5)
    1d32:	f5c42703          	lw	a4,-164(s0)
    1d36:	02f707bb          	mulw	a5,a4,a5
    1d3a:	f4f42a23          	sw	a5,-172(s0)
        int scaled_right = selected->cbs.budget * time_until_deadline;
    1d3e:	fc043783          	ld	a5,-64(s0)
    1d42:	53fc                	lw	a5,100(a5)
    1d44:	f5842703          	lw	a4,-168(s0)
    1d48:	02f707bb          	mulw	a5,a4,a5
    1d4c:	f4f42823          	sw	a5,-176(s0)

        if (scaled_left > scaled_right) {
    1d50:	f5442703          	lw	a4,-172(s0)
    1d54:	f5042783          	lw	a5,-176(s0)
    1d58:	2701                	sext.w	a4,a4
    1d5a:	2781                	sext.w	a5,a5
    1d5c:	02e7d363          	bge	a5,a4,1d82 <schedule_edf_cbs+0x292>
            // Replenish and restart scheduling decision
            selected->current_deadline = args.current_time + selected->period;
    1d60:	4098                	lw	a4,0(s1)
    1d62:	fc043783          	ld	a5,-64(s0)
    1d66:	47fc                	lw	a5,76(a5)
    1d68:	9fb9                	addw	a5,a5,a4
    1d6a:	0007871b          	sext.w	a4,a5
    1d6e:	fc043783          	ld	a5,-64(s0)
    1d72:	cfb8                	sw	a4,88(a5)
            selected->cbs.remaining_budget = selected->cbs.budget;
    1d74:	fc043783          	ld	a5,-64(s0)
    1d78:	53f8                	lw	a4,100(a5)
    1d7a:	fc043783          	ld	a5,-64(s0)
    1d7e:	d7b8                	sw	a4,104(a5)
            goto start_scheduling;  // Restart scheduling decision
    1d80:	b341                	j	1b00 <schedule_edf_cbs+0x10>
        }

        // Check again: if still throttled (no budget but has work)
        if (selected->cbs.remaining_budget <= 0 && selected->remaining_time > 0) {
    1d82:	fc043783          	ld	a5,-64(s0)
    1d86:	57bc                	lw	a5,104(a5)
    1d88:	02f04063          	bgtz	a5,1da8 <schedule_edf_cbs+0x2b8>
    1d8c:	fc043783          	ld	a5,-64(s0)
    1d90:	4bfc                	lw	a5,84(a5)
    1d92:	00f05b63          	blez	a5,1da8 <schedule_edf_cbs+0x2b8>
            r.scheduled_thread_list_member = &selected->thread_list;
    1d96:	fc043783          	ld	a5,-64(s0)
    1d9a:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffd7a8>
    1d9e:	f0f43823          	sd	a5,-240(s0)
            r.allocated_time = 0;
    1da2:	f0042c23          	sw	zero,-232(s0)
            goto start_scheduling;  // Restart scheduling decision after throttling
    1da6:	bba9                	j	1b00 <schedule_edf_cbs+0x10>
        }

        // For soft real-time tasks, allocate time based on remaining CBS budget
        r.scheduled_thread_list_member = &selected->thread_list;
    1da8:	fc043783          	ld	a5,-64(s0)
    1dac:	02878793          	addi	a5,a5,40
    1db0:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1db4:	fc043783          	ld	a5,-64(s0)
    1db8:	57b8                	lw	a4,104(a5)
    1dba:	fc043783          	ld	a5,-64(s0)
    1dbe:	4bfc                	lw	a5,84(a5)
                          ? selected->remaining_time 
                          : selected->cbs.remaining_budget;
    1dc0:	863e                	mv	a2,a5
    1dc2:	86ba                	mv	a3,a4
    1dc4:	0006871b          	sext.w	a4,a3
    1dc8:	0006079b          	sext.w	a5,a2
    1dcc:	00e7d363          	bge	a5,a4,1dd2 <schedule_edf_cbs+0x2e2>
    1dd0:	86b2                	mv	a3,a2
    1dd2:	0006879b          	sext.w	a5,a3
        r.allocated_time = (selected->remaining_time < selected->cbs.remaining_budget) 
    1dd6:	f0f42c23          	sw	a5,-232(s0)
    1dda:	a0f5                	j	1ec6 <schedule_edf_cbs+0x3d6>
    } else {
        // For hard real-time tasks
        // First check if any higher priority task will arrive before completion
        int max_alloc = selected->remaining_time;
    1ddc:	fc043783          	ld	a5,-64(s0)
    1de0:	4bfc                	lw	a5,84(a5)
    1de2:	faf42623          	sw	a5,-84(s0)
        struct release_queue_entry *rqe = NULL;
    1de6:	fa043023          	sd	zero,-96(s0)
        
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1dea:	689c                	ld	a5,16(s1)
    1dec:	639c                	ld	a5,0(a5)
    1dee:	f8f43023          	sd	a5,-128(s0)
    1df2:	f8043783          	ld	a5,-128(s0)
    1df6:	17e1                	addi	a5,a5,-8
    1df8:	faf43023          	sd	a5,-96(s0)
    1dfc:	a041                	j	1e7c <schedule_edf_cbs+0x38c>
            struct thread *future = rqe->thrd;
    1dfe:	fa043783          	ld	a5,-96(s0)
    1e02:	639c                	ld	a5,0(a5)
    1e04:	f6f43823          	sd	a5,-144(s0)
            if (future->arrival_time > args.current_time &&
    1e08:	f7043783          	ld	a5,-144(s0)
    1e0c:	53b8                	lw	a4,96(a5)
    1e0e:	409c                	lw	a5,0(s1)
    1e10:	04e7dc63          	bge	a5,a4,1e68 <schedule_edf_cbs+0x378>
                future->arrival_time < args.current_time + max_alloc &&
    1e14:	f7043783          	ld	a5,-144(s0)
    1e18:	53b4                	lw	a3,96(a5)
    1e1a:	409c                	lw	a5,0(s1)
    1e1c:	fac42703          	lw	a4,-84(s0)
    1e20:	9fb9                	addw	a5,a5,a4
    1e22:	2781                	sext.w	a5,a5
            if (future->arrival_time > args.current_time &&
    1e24:	8736                	mv	a4,a3
    1e26:	04f75163          	bge	a4,a5,1e68 <schedule_edf_cbs+0x378>
                __edf_thread_cmp(future, selected) < 0) {
    1e2a:	fc043583          	ld	a1,-64(s0)
    1e2e:	f7043503          	ld	a0,-144(s0)
    1e32:	00000097          	auipc	ra,0x0
    1e36:	c2e080e7          	jalr	-978(ra) # 1a60 <__edf_thread_cmp>
    1e3a:	87aa                	mv	a5,a0
                future->arrival_time < args.current_time + max_alloc &&
    1e3c:	0207d663          	bgez	a5,1e68 <schedule_edf_cbs+0x378>
                
                // A higher priority task will arrive, need to preempt
                int safe_time = future->arrival_time - args.current_time;
    1e40:	f7043783          	ld	a5,-144(s0)
    1e44:	53b8                	lw	a4,96(a5)
    1e46:	409c                	lw	a5,0(s1)
    1e48:	40f707bb          	subw	a5,a4,a5
    1e4c:	f6f42623          	sw	a5,-148(s0)
                if (safe_time < max_alloc) {
    1e50:	f6c42703          	lw	a4,-148(s0)
    1e54:	fac42783          	lw	a5,-84(s0)
    1e58:	2701                	sext.w	a4,a4
    1e5a:	2781                	sext.w	a5,a5
    1e5c:	00f75663          	bge	a4,a5,1e68 <schedule_edf_cbs+0x378>
                    max_alloc = safe_time;
    1e60:	f6c42783          	lw	a5,-148(s0)
    1e64:	faf42623          	sw	a5,-84(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list) {
    1e68:	fa043783          	ld	a5,-96(s0)
    1e6c:	679c                	ld	a5,8(a5)
    1e6e:	f6f43023          	sd	a5,-160(s0)
    1e72:	f6043783          	ld	a5,-160(s0)
    1e76:	17e1                	addi	a5,a5,-8
    1e78:	faf43023          	sd	a5,-96(s0)
    1e7c:	fa043783          	ld	a5,-96(s0)
    1e80:	00878713          	addi	a4,a5,8
    1e84:	689c                	ld	a5,16(s1)
    1e86:	f6f71ce3          	bne	a4,a5,1dfe <schedule_edf_cbs+0x30e>
                }
            }
        }

        // Also check deadline constraint
        int time_to_deadline = selected->current_deadline - args.current_time;
    1e8a:	fc043783          	ld	a5,-64(s0)
    1e8e:	4fb8                	lw	a4,88(a5)
    1e90:	409c                	lw	a5,0(s1)
    1e92:	40f707bb          	subw	a5,a4,a5
    1e96:	f6f42e23          	sw	a5,-132(s0)
        if (time_to_deadline < max_alloc) {
    1e9a:	f7c42703          	lw	a4,-132(s0)
    1e9e:	fac42783          	lw	a5,-84(s0)
    1ea2:	2701                	sext.w	a4,a4
    1ea4:	2781                	sext.w	a5,a5
    1ea6:	00f75663          	bge	a4,a5,1eb2 <schedule_edf_cbs+0x3c2>
            max_alloc = time_to_deadline;
    1eaa:	f7c42783          	lw	a5,-132(s0)
    1eae:	faf42623          	sw	a5,-84(s0)
        }

        r.scheduled_thread_list_member = &selected->thread_list;
    1eb2:	fc043783          	ld	a5,-64(s0)
    1eb6:	02878793          	addi	a5,a5,40
    1eba:	f0f43823          	sd	a5,-240(s0)
        r.allocated_time = max_alloc;
    1ebe:	fac42783          	lw	a5,-84(s0)
    1ec2:	f0f42c23          	sw	a5,-232(s0)
    }

    return r;
    1ec6:	f1043783          	ld	a5,-240(s0)
    1eca:	f2f43023          	sd	a5,-224(s0)
    1ece:	f1843783          	ld	a5,-232(s0)
    1ed2:	f2f43423          	sd	a5,-216(s0)
    1ed6:	4701                	li	a4,0
    1ed8:	f2043703          	ld	a4,-224(s0)
    1edc:	4781                	li	a5,0
    1ede:	f2843783          	ld	a5,-216(s0)
    1ee2:	893a                	mv	s2,a4
    1ee4:	89be                	mv	s3,a5
    1ee6:	874a                	mv	a4,s2
    1ee8:	87ce                	mv	a5,s3
}
    1eea:	853a                	mv	a0,a4
    1eec:	85be                	mv	a1,a5
    1eee:	70ae                	ld	ra,232(sp)
    1ef0:	740e                	ld	s0,224(sp)
    1ef2:	64ee                	ld	s1,216(sp)
    1ef4:	694e                	ld	s2,208(sp)
    1ef6:	69ae                	ld	s3,200(sp)
    1ef8:	616d                	addi	sp,sp,240
    1efa:	8082                	ret
