
vmm/guest/obj/fs/fs:     file format elf64-x86-64


Disassembly of section .text:

0000000000800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	movabs $USTACKTOP, %rax
  800020:	48 b8 00 e0 7f ef 00 	movabs $0xef7fe000,%rax
  800027:	00 00 00 
	cmpq %rax,%rsp
  80002a:	48 39 c4             	cmp    %rax,%rsp
	jne args_exist
  80002d:	75 04                	jne    800033 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushq $0
  80002f:	6a 00                	pushq  $0x0
	pushq $0
  800031:	6a 00                	pushq  $0x0

0000000000800033 <args_exist>:

args_exist:
	movq 8(%rsp), %rsi
  800033:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
	movq (%rsp), %rdi
  800038:	48 8b 3c 24          	mov    (%rsp),%rdi
	call libmain
  80003c:	e8 cb 33 00 00       	callq  80340c <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <ide_wait_ready>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 14          	sub    $0x14,%rsp
  80004b:	89 f8                	mov    %edi,%eax
  80004d:	88 45 ec             	mov    %al,-0x14(%rbp)
  800050:	90                   	nop
  800051:	c7 45 f8 f7 01 00 00 	movl   $0x1f7,-0x8(%rbp)

static __inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  800058:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80005b:	89 c2                	mov    %eax,%edx
  80005d:	ec                   	in     (%dx),%al
  80005e:	88 45 f7             	mov    %al,-0x9(%rbp)
	return data;
  800061:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
  800065:	0f b6 c0             	movzbl %al,%eax
  800068:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80006b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80006e:	25 c0 00 00 00       	and    $0xc0,%eax
  800073:	83 f8 40             	cmp    $0x40,%eax
  800076:	75 d9                	jne    800051 <ide_wait_ready+0xe>
  800078:	80 7d ec 00          	cmpb   $0x0,-0x14(%rbp)
  80007c:	74 11                	je     80008f <ide_wait_ready+0x4c>
  80007e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800081:	83 e0 21             	and    $0x21,%eax
  800084:	85 c0                	test   %eax,%eax
  800086:	74 07                	je     80008f <ide_wait_ready+0x4c>
  800088:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  80008d:	eb 05                	jmp    800094 <ide_wait_ready+0x51>
  80008f:	b8 00 00 00 00       	mov    $0x0,%eax
  800094:	c9                   	leaveq 
  800095:	c3                   	retq   

0000000000800096 <ide_probe_disk1>:
  800096:	55                   	push   %rbp
  800097:	48 89 e5             	mov    %rsp,%rbp
  80009a:	48 83 ec 20          	sub    $0x20,%rsp
  80009e:	bf 00 00 00 00       	mov    $0x0,%edi
  8000a3:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8000aa:	00 00 00 
  8000ad:	ff d0                	callq  *%rax
  8000af:	c7 45 f4 f6 01 00 00 	movl   $0x1f6,-0xc(%rbp)
  8000b6:	c6 45 f3 f0          	movb   $0xf0,-0xd(%rbp)
}

static __inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  8000ba:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
  8000be:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8000c1:	ee                   	out    %al,(%dx)
  8000c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8000c9:	eb 04                	jmp    8000cf <ide_probe_disk1+0x39>
  8000cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8000cf:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
  8000d6:	7f 26                	jg     8000fe <ide_probe_disk1+0x68>
  8000d8:	c7 45 ec f7 01 00 00 	movl   $0x1f7,-0x14(%rbp)

static __inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  8000df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8000e2:	89 c2                	mov    %eax,%edx
  8000e4:	ec                   	in     (%dx),%al
  8000e5:	88 45 eb             	mov    %al,-0x15(%rbp)
	return data;
  8000e8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
  8000ec:	0f b6 c0             	movzbl %al,%eax
  8000ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000f5:	25 a1 00 00 00       	and    $0xa1,%eax
  8000fa:	85 c0                	test   %eax,%eax
  8000fc:	75 cd                	jne    8000cb <ide_probe_disk1+0x35>
  8000fe:	c7 45 e4 f6 01 00 00 	movl   $0x1f6,-0x1c(%rbp)
  800105:	c6 45 e3 e0          	movb   $0xe0,-0x1d(%rbp)
}

static __inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  800109:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
  80010d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  800110:	ee                   	out    %al,(%dx)
  800111:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
  800118:	0f 9e c0             	setle  %al
  80011b:	0f b6 c0             	movzbl %al,%eax
  80011e:	89 c6                	mov    %eax,%esi
  800120:	48 bf 60 74 80 00 00 	movabs $0x807460,%rdi
  800127:	00 00 00 
  80012a:	b8 00 00 00 00       	mov    $0x0,%eax
  80012f:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  800136:	00 00 00 
  800139:	ff d2                	callq  *%rdx
  80013b:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
  800142:	0f 9e c0             	setle  %al
  800145:	c9                   	leaveq 
  800146:	c3                   	retq   

0000000000800147 <ide_set_disk>:
  800147:	55                   	push   %rbp
  800148:	48 89 e5             	mov    %rsp,%rbp
  80014b:	48 83 ec 10          	sub    $0x10,%rsp
  80014f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800152:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800156:	74 30                	je     800188 <ide_set_disk+0x41>
  800158:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
  80015c:	74 2a                	je     800188 <ide_set_disk+0x41>
  80015e:	48 ba 77 74 80 00 00 	movabs $0x807477,%rdx
  800165:	00 00 00 
  800168:	be 3f 00 00 00       	mov    $0x3f,%esi
  80016d:	48 bf 87 74 80 00 00 	movabs $0x807487,%rdi
  800174:	00 00 00 
  800177:	b8 00 00 00 00       	mov    $0x0,%eax
  80017c:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  800183:	00 00 00 
  800186:	ff d1                	callq  *%rcx
  800188:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80018f:	00 00 00 
  800192:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800195:	89 10                	mov    %edx,(%rax)
  800197:	c9                   	leaveq 
  800198:	c3                   	retq   

0000000000800199 <ide_read>:
  800199:	55                   	push   %rbp
  80019a:	48 89 e5             	mov    %rsp,%rbp
  80019d:	48 83 ec 70          	sub    $0x70,%rsp
  8001a1:	89 7d ac             	mov    %edi,-0x54(%rbp)
  8001a4:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8001a8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8001ac:	48 81 7d 98 00 01 00 	cmpq   $0x100,-0x68(%rbp)
  8001b3:	00 
  8001b4:	76 35                	jbe    8001eb <ide_read+0x52>
  8001b6:	48 b9 93 74 80 00 00 	movabs $0x807493,%rcx
  8001bd:	00 00 00 
  8001c0:	48 ba a0 74 80 00 00 	movabs $0x8074a0,%rdx
  8001c7:	00 00 00 
  8001ca:	be 51 00 00 00       	mov    $0x51,%esi
  8001cf:	48 bf 87 74 80 00 00 	movabs $0x807487,%rdi
  8001d6:	00 00 00 
  8001d9:	b8 00 00 00 00       	mov    $0x0,%eax
  8001de:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8001e5:	00 00 00 
  8001e8:	41 ff d0             	callq  *%r8
  8001eb:	bf 00 00 00 00       	mov    $0x0,%edi
  8001f0:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8001f7:	00 00 00 
  8001fa:	ff d0                	callq  *%rax
  8001fc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800200:	0f b6 c0             	movzbl %al,%eax
  800203:	c7 45 f8 f2 01 00 00 	movl   $0x1f2,-0x8(%rbp)
  80020a:	88 45 f7             	mov    %al,-0x9(%rbp)
  80020d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
  800211:	8b 55 f8             	mov    -0x8(%rbp),%edx
  800214:	ee                   	out    %al,(%dx)
  800215:	8b 45 ac             	mov    -0x54(%rbp),%eax
  800218:	0f b6 c0             	movzbl %al,%eax
  80021b:	c7 45 f0 f3 01 00 00 	movl   $0x1f3,-0x10(%rbp)
  800222:	88 45 ef             	mov    %al,-0x11(%rbp)
  800225:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  800229:	8b 55 f0             	mov    -0x10(%rbp),%edx
  80022c:	ee                   	out    %al,(%dx)
  80022d:	8b 45 ac             	mov    -0x54(%rbp),%eax
  800230:	c1 e8 08             	shr    $0x8,%eax
  800233:	0f b6 c0             	movzbl %al,%eax
  800236:	c7 45 e8 f4 01 00 00 	movl   $0x1f4,-0x18(%rbp)
  80023d:	88 45 e7             	mov    %al,-0x19(%rbp)
  800240:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
  800244:	8b 55 e8             	mov    -0x18(%rbp),%edx
  800247:	ee                   	out    %al,(%dx)
  800248:	8b 45 ac             	mov    -0x54(%rbp),%eax
  80024b:	c1 e8 10             	shr    $0x10,%eax
  80024e:	0f b6 c0             	movzbl %al,%eax
  800251:	c7 45 e0 f5 01 00 00 	movl   $0x1f5,-0x20(%rbp)
  800258:	88 45 df             	mov    %al,-0x21(%rbp)
  80025b:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
  80025f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  800262:	ee                   	out    %al,(%dx)
  800263:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80026a:	00 00 00 
  80026d:	8b 00                	mov    (%rax),%eax
  80026f:	83 e0 01             	and    $0x1,%eax
  800272:	c1 e0 04             	shl    $0x4,%eax
  800275:	89 c2                	mov    %eax,%edx
  800277:	8b 45 ac             	mov    -0x54(%rbp),%eax
  80027a:	c1 e8 18             	shr    $0x18,%eax
  80027d:	83 e0 0f             	and    $0xf,%eax
  800280:	09 d0                	or     %edx,%eax
  800282:	83 c8 e0             	or     $0xffffffe0,%eax
  800285:	0f b6 c0             	movzbl %al,%eax
  800288:	c7 45 d8 f6 01 00 00 	movl   $0x1f6,-0x28(%rbp)
  80028f:	88 45 d7             	mov    %al,-0x29(%rbp)
  800292:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
  800296:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800299:	ee                   	out    %al,(%dx)
  80029a:	c7 45 d0 f7 01 00 00 	movl   $0x1f7,-0x30(%rbp)
  8002a1:	c6 45 cf 20          	movb   $0x20,-0x31(%rbp)
  8002a5:	0f b6 45 cf          	movzbl -0x31(%rbp),%eax
  8002a9:	8b 55 d0             	mov    -0x30(%rbp),%edx
  8002ac:	ee                   	out    %al,(%dx)
  8002ad:	eb 64                	jmp    800313 <ide_read+0x17a>
  8002af:	bf 01 00 00 00       	mov    $0x1,%edi
  8002b4:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8002bb:	00 00 00 
  8002be:	ff d0                	callq  *%rax
  8002c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8002c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8002c7:	79 05                	jns    8002ce <ide_read+0x135>
  8002c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002cc:	eb 51                	jmp    80031f <ide_read+0x186>
  8002ce:	c7 45 c8 f0 01 00 00 	movl   $0x1f0,-0x38(%rbp)
  8002d5:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8002d9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  8002dd:	c7 45 bc 00 01 00 00 	movl   $0x100,-0x44(%rbp)
}

static __inline void
insw(int port, void *addr, int cnt)
{
	__asm __volatile("cld\n\trepne\n\tinsw"			:
  8002e4:	8b 55 c8             	mov    -0x38(%rbp),%edx
  8002e7:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  8002eb:	8b 45 bc             	mov    -0x44(%rbp),%eax
  8002ee:	48 89 ce             	mov    %rcx,%rsi
  8002f1:	48 89 f7             	mov    %rsi,%rdi
  8002f4:	89 c1                	mov    %eax,%ecx
  8002f6:	fc                   	cld    
  8002f7:	f2 66 6d             	repnz insw (%dx),%es:(%rdi)
  8002fa:	89 c8                	mov    %ecx,%eax
  8002fc:	48 89 fe             	mov    %rdi,%rsi
  8002ff:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800303:	89 45 bc             	mov    %eax,-0x44(%rbp)
  800306:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80030b:	48 81 45 a0 00 02 00 	addq   $0x200,-0x60(%rbp)
  800312:	00 
  800313:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
  800318:	75 95                	jne    8002af <ide_read+0x116>
  80031a:	b8 00 00 00 00       	mov    $0x0,%eax
  80031f:	c9                   	leaveq 
  800320:	c3                   	retq   

0000000000800321 <ide_write>:
  800321:	55                   	push   %rbp
  800322:	48 89 e5             	mov    %rsp,%rbp
  800325:	48 83 ec 70          	sub    $0x70,%rsp
  800329:	89 7d ac             	mov    %edi,-0x54(%rbp)
  80032c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800330:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800334:	48 81 7d 98 00 01 00 	cmpq   $0x100,-0x68(%rbp)
  80033b:	00 
  80033c:	76 35                	jbe    800373 <ide_write+0x52>
  80033e:	48 b9 93 74 80 00 00 	movabs $0x807493,%rcx
  800345:	00 00 00 
  800348:	48 ba a0 74 80 00 00 	movabs $0x8074a0,%rdx
  80034f:	00 00 00 
  800352:	be 71 00 00 00       	mov    $0x71,%esi
  800357:	48 bf 87 74 80 00 00 	movabs $0x807487,%rdi
  80035e:	00 00 00 
  800361:	b8 00 00 00 00       	mov    $0x0,%eax
  800366:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80036d:	00 00 00 
  800370:	41 ff d0             	callq  *%r8
  800373:	bf 00 00 00 00       	mov    $0x0,%edi
  800378:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  80037f:	00 00 00 
  800382:	ff d0                	callq  *%rax
  800384:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800388:	0f b6 c0             	movzbl %al,%eax
  80038b:	c7 45 f8 f2 01 00 00 	movl   $0x1f2,-0x8(%rbp)
  800392:	88 45 f7             	mov    %al,-0x9(%rbp)
}

static __inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  800395:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
  800399:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80039c:	ee                   	out    %al,(%dx)
  80039d:	8b 45 ac             	mov    -0x54(%rbp),%eax
  8003a0:	0f b6 c0             	movzbl %al,%eax
  8003a3:	c7 45 f0 f3 01 00 00 	movl   $0x1f3,-0x10(%rbp)
  8003aa:	88 45 ef             	mov    %al,-0x11(%rbp)
  8003ad:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8003b1:	8b 55 f0             	mov    -0x10(%rbp),%edx
  8003b4:	ee                   	out    %al,(%dx)
  8003b5:	8b 45 ac             	mov    -0x54(%rbp),%eax
  8003b8:	c1 e8 08             	shr    $0x8,%eax
  8003bb:	0f b6 c0             	movzbl %al,%eax
  8003be:	c7 45 e8 f4 01 00 00 	movl   $0x1f4,-0x18(%rbp)
  8003c5:	88 45 e7             	mov    %al,-0x19(%rbp)
  8003c8:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
  8003cc:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8003cf:	ee                   	out    %al,(%dx)
  8003d0:	8b 45 ac             	mov    -0x54(%rbp),%eax
  8003d3:	c1 e8 10             	shr    $0x10,%eax
  8003d6:	0f b6 c0             	movzbl %al,%eax
  8003d9:	c7 45 e0 f5 01 00 00 	movl   $0x1f5,-0x20(%rbp)
  8003e0:	88 45 df             	mov    %al,-0x21(%rbp)
  8003e3:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
  8003e7:	8b 55 e0             	mov    -0x20(%rbp),%edx
  8003ea:	ee                   	out    %al,(%dx)
  8003eb:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8003f2:	00 00 00 
  8003f5:	8b 00                	mov    (%rax),%eax
  8003f7:	83 e0 01             	and    $0x1,%eax
  8003fa:	c1 e0 04             	shl    $0x4,%eax
  8003fd:	89 c2                	mov    %eax,%edx
  8003ff:	8b 45 ac             	mov    -0x54(%rbp),%eax
  800402:	c1 e8 18             	shr    $0x18,%eax
  800405:	83 e0 0f             	and    $0xf,%eax
  800408:	09 d0                	or     %edx,%eax
  80040a:	83 c8 e0             	or     $0xffffffe0,%eax
  80040d:	0f b6 c0             	movzbl %al,%eax
  800410:	c7 45 d8 f6 01 00 00 	movl   $0x1f6,-0x28(%rbp)
  800417:	88 45 d7             	mov    %al,-0x29(%rbp)
  80041a:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
  80041e:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800421:	ee                   	out    %al,(%dx)
  800422:	c7 45 d0 f7 01 00 00 	movl   $0x1f7,-0x30(%rbp)
  800429:	c6 45 cf 30          	movb   $0x30,-0x31(%rbp)
  80042d:	0f b6 45 cf          	movzbl -0x31(%rbp),%eax
  800431:	8b 55 d0             	mov    -0x30(%rbp),%edx
  800434:	ee                   	out    %al,(%dx)
  800435:	eb 5e                	jmp    800495 <ide_write+0x174>
  800437:	bf 01 00 00 00       	mov    $0x1,%edi
  80043c:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800443:	00 00 00 
  800446:	ff d0                	callq  *%rax
  800448:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80044b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80044f:	79 05                	jns    800456 <ide_write+0x135>
  800451:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800454:	eb 4b                	jmp    8004a1 <ide_write+0x180>
  800456:	c7 45 c8 f0 01 00 00 	movl   $0x1f0,-0x38(%rbp)
  80045d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  800461:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  800465:	c7 45 bc 00 01 00 00 	movl   $0x100,-0x44(%rbp)
}

static __inline void
outsw(int port, const void *addr, int cnt)
{
	__asm __volatile("cld\n\trepne\n\toutsw"		:
  80046c:	8b 55 c8             	mov    -0x38(%rbp),%edx
  80046f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  800473:	8b 45 bc             	mov    -0x44(%rbp),%eax
  800476:	48 89 ce             	mov    %rcx,%rsi
  800479:	89 c1                	mov    %eax,%ecx
  80047b:	fc                   	cld    
  80047c:	f2 66 6f             	repnz outsw %ds:(%rsi),(%dx)
  80047f:	89 c8                	mov    %ecx,%eax
  800481:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800485:	89 45 bc             	mov    %eax,-0x44(%rbp)
  800488:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80048d:	48 81 45 a0 00 02 00 	addq   $0x200,-0x60(%rbp)
  800494:	00 
  800495:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
  80049a:	75 9b                	jne    800437 <ide_write+0x116>
  80049c:	b8 00 00 00 00       	mov    $0x0,%eax
  8004a1:	c9                   	leaveq 
  8004a2:	c3                   	retq   

00000000008004a3 <diskaddr>:
#include "fs.h"

// Return the virtual address of this disk block.
void*
diskaddr(uint64_t blockno)
{
  8004a3:	55                   	push   %rbp
  8004a4:	48 89 e5             	mov    %rsp,%rbp
  8004a7:	48 83 ec 10          	sub    $0x10,%rsp
  8004ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if (blockno == 0 || (super && blockno >= super->s_nblocks))
  8004af:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  8004b4:	74 2a                	je     8004e0 <diskaddr+0x3d>
  8004b6:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  8004bd:	00 00 00 
  8004c0:	48 8b 00             	mov    (%rax),%rax
  8004c3:	48 85 c0             	test   %rax,%rax
  8004c6:	74 4a                	je     800512 <diskaddr+0x6f>
  8004c8:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  8004cf:	00 00 00 
  8004d2:	48 8b 00             	mov    (%rax),%rax
  8004d5:	8b 40 04             	mov    0x4(%rax),%eax
  8004d8:	89 c0                	mov    %eax,%eax
  8004da:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8004de:	77 32                	ja     800512 <diskaddr+0x6f>
		panic("bad block number %08x in diskaddr", blockno);
  8004e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004e4:	48 89 c1             	mov    %rax,%rcx
  8004e7:	48 ba b8 74 80 00 00 	movabs $0x8074b8,%rdx
  8004ee:	00 00 00 
  8004f1:	be 09 00 00 00       	mov    $0x9,%esi
  8004f6:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  8004fd:	00 00 00 
  800500:	b8 00 00 00 00       	mov    $0x0,%eax
  800505:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80050c:	00 00 00 
  80050f:	41 ff d0             	callq  *%r8
	return (char*) (DISKMAP + blockno * BLKSIZE);
  800512:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800516:	48 05 00 00 01 00    	add    $0x10000,%rax
  80051c:	48 c1 e0 0c          	shl    $0xc,%rax
}
  800520:	c9                   	leaveq 
  800521:	c3                   	retq   

0000000000800522 <va_is_mapped>:

// Is this virtual address mapped?
bool
va_is_mapped(void *va)
{
  800522:	55                   	push   %rbp
  800523:	48 89 e5             	mov    %rsp,%rbp
  800526:	48 83 ec 08          	sub    $0x8,%rsp
  80052a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	return (uvpml4e[VPML4E(va)] & PTE_P) && (uvpde[VPDPE(va)] & PTE_P) && (uvpd[VPD(va)] & PTE_P) && (uvpt[PGNUM(va)] & PTE_P);
  80052e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800532:	48 c1 e8 27          	shr    $0x27,%rax
  800536:	48 89 c2             	mov    %rax,%rdx
  800539:	48 b8 00 20 40 80 00 	movabs $0x10080402000,%rax
  800540:	01 00 00 
  800543:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800547:	83 e0 01             	and    $0x1,%eax
  80054a:	48 85 c0             	test   %rax,%rax
  80054d:	74 6a                	je     8005b9 <va_is_mapped+0x97>
  80054f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800553:	48 c1 e8 1e          	shr    $0x1e,%rax
  800557:	48 89 c2             	mov    %rax,%rdx
  80055a:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  800561:	01 00 00 
  800564:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800568:	83 e0 01             	and    $0x1,%eax
  80056b:	48 85 c0             	test   %rax,%rax
  80056e:	74 49                	je     8005b9 <va_is_mapped+0x97>
  800570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800574:	48 c1 e8 15          	shr    $0x15,%rax
  800578:	48 89 c2             	mov    %rax,%rdx
  80057b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  800582:	01 00 00 
  800585:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800589:	83 e0 01             	and    $0x1,%eax
  80058c:	48 85 c0             	test   %rax,%rax
  80058f:	74 28                	je     8005b9 <va_is_mapped+0x97>
  800591:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800595:	48 c1 e8 0c          	shr    $0xc,%rax
  800599:	48 89 c2             	mov    %rax,%rdx
  80059c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8005a3:	01 00 00 
  8005a6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8005aa:	83 e0 01             	and    $0x1,%eax
  8005ad:	48 85 c0             	test   %rax,%rax
  8005b0:	74 07                	je     8005b9 <va_is_mapped+0x97>
  8005b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8005b7:	eb 05                	jmp    8005be <va_is_mapped+0x9c>
  8005b9:	b8 00 00 00 00       	mov    $0x0,%eax
  8005be:	83 e0 01             	and    $0x1,%eax
}
  8005c1:	c9                   	leaveq 
  8005c2:	c3                   	retq   

00000000008005c3 <va_is_dirty>:

// Is this virtual address dirty?
bool
va_is_dirty(void *va)
{
  8005c3:	55                   	push   %rbp
  8005c4:	48 89 e5             	mov    %rsp,%rbp
  8005c7:	48 83 ec 08          	sub    $0x8,%rsp
  8005cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	return (uvpt[PGNUM(va)] & PTE_D) != 0;
  8005cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005d3:	48 c1 e8 0c          	shr    $0xc,%rax
  8005d7:	48 89 c2             	mov    %rax,%rdx
  8005da:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8005e1:	01 00 00 
  8005e4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8005e8:	83 e0 40             	and    $0x40,%eax
  8005eb:	48 85 c0             	test   %rax,%rax
  8005ee:	0f 95 c0             	setne  %al
}
  8005f1:	c9                   	leaveq 
  8005f2:	c3                   	retq   

00000000008005f3 <bc_pgfault>:
// Fault any disk block that is read in to memory by
// loading it from disk.
// Hint: Use ide_read and BLKSECTS.
static void
bc_pgfault(struct UTrapframe *utf)
{
  8005f3:	55                   	push   %rbp
  8005f4:	48 89 e5             	mov    %rsp,%rbp
  8005f7:	48 83 ec 30          	sub    $0x30,%rsp
  8005fb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	void *addr = (void *) utf->utf_fault_va;
  8005ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800603:	48 8b 00             	mov    (%rax),%rax
  800606:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	uint64_t blockno = ((uint64_t)addr - DISKMAP) / BLKSIZE;
  80060a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80060e:	48 2d 00 00 00 10    	sub    $0x10000000,%rax
  800614:	48 c1 e8 0c          	shr    $0xc,%rax
  800618:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	int r;

	// Check that the fault was within the block cache region
	if (addr < (void*)DISKMAP || addr >= (void*)(DISKMAP + DISKSIZE))
  80061c:	48 81 7d f8 ff ff ff 	cmpq   $0xfffffff,-0x8(%rbp)
  800623:	0f 
  800624:	76 0b                	jbe    800631 <bc_pgfault+0x3e>
  800626:	b8 ff ff ff cf       	mov    $0xcfffffff,%eax
  80062b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  80062f:	76 4b                	jbe    80067c <bc_pgfault+0x89>
		panic("page fault in FS: eip %08x, va %08x, err %04x",
  800631:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800635:	48 8b 48 08          	mov    0x8(%rax),%rcx
  800639:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80063d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
  800644:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800648:	49 89 c9             	mov    %rcx,%r9
  80064b:	49 89 d0             	mov    %rdx,%r8
  80064e:	48 89 c1             	mov    %rax,%rcx
  800651:	48 ba e8 74 80 00 00 	movabs $0x8074e8,%rdx
  800658:	00 00 00 
  80065b:	be 28 00 00 00       	mov    $0x28,%esi
  800660:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800667:	00 00 00 
  80066a:	b8 00 00 00 00       	mov    $0x0,%eax
  80066f:	49 ba b2 34 80 00 00 	movabs $0x8034b2,%r10
  800676:	00 00 00 
  800679:	41 ff d2             	callq  *%r10
		      utf->utf_rip, addr, utf->utf_err);

	// Sanity check the block number.
	if (super && blockno >= super->s_nblocks)
  80067c:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800683:	00 00 00 
  800686:	48 8b 00             	mov    (%rax),%rax
  800689:	48 85 c0             	test   %rax,%rax
  80068c:	74 4a                	je     8006d8 <bc_pgfault+0xe5>
  80068e:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800695:	00 00 00 
  800698:	48 8b 00             	mov    (%rax),%rax
  80069b:	8b 40 04             	mov    0x4(%rax),%eax
  80069e:	89 c0                	mov    %eax,%eax
  8006a0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8006a4:	77 32                	ja     8006d8 <bc_pgfault+0xe5>
		panic("reading non-existent block %08x\n", blockno);
  8006a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8006aa:	48 89 c1             	mov    %rax,%rcx
  8006ad:	48 ba 18 75 80 00 00 	movabs $0x807518,%rdx
  8006b4:	00 00 00 
  8006b7:	be 2c 00 00 00       	mov    $0x2c,%esi
  8006bc:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  8006c3:	00 00 00 
  8006c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8006cb:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8006d2:	00 00 00 
  8006d5:	41 ff d0             	callq  *%r8

	// Allocate a page in the disk map region, read the contents
	// of the block from the disk into that page.
	// Hint: first round addr to page boundary.
	//
	addr = ROUNDDOWN(addr, PGSIZE);
  8006d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006dc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8006e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006e4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8006ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	if ((r = sys_page_alloc(0, addr, PTE_U|PTE_P|PTE_W)) < 0)
  8006ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006f2:	ba 07 00 00 00       	mov    $0x7,%edx
  8006f7:	48 89 c6             	mov    %rax,%rsi
  8006fa:	bf 00 00 00 00       	mov    $0x0,%edi
  8006ff:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  800706:	00 00 00 
  800709:	ff d0                	callq  *%rax
  80070b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80070e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800712:	79 30                	jns    800744 <bc_pgfault+0x151>
		panic("in bc_pgfault, sys_page_alloc: %e", r);
  800714:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800717:	89 c1                	mov    %eax,%ecx
  800719:	48 ba 40 75 80 00 00 	movabs $0x807540,%rdx
  800720:	00 00 00 
  800723:	be 34 00 00 00       	mov    $0x34,%esi
  800728:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  80072f:	00 00 00 
  800732:	b8 00 00 00 00       	mov    $0x0,%eax
  800737:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80073e:	00 00 00 
  800741:	41 ff d0             	callq  *%r8
	/* FIXME DP: Should be lab 8 */
    /* Your code here */

#endif // VMM_GUEST

	if ((r = sys_page_map(0, addr, 0, addr, uvpt[PGNUM(addr)] & PTE_SYSCALL)) < 0)
  800744:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800748:	48 c1 e8 0c          	shr    $0xc,%rax
  80074c:	48 89 c2             	mov    %rax,%rdx
  80074f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  800756:	01 00 00 
  800759:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80075d:	25 07 0e 00 00       	and    $0xe07,%eax
  800762:	89 c1                	mov    %eax,%ecx
  800764:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800768:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80076c:	41 89 c8             	mov    %ecx,%r8d
  80076f:	48 89 d1             	mov    %rdx,%rcx
  800772:	ba 00 00 00 00       	mov    $0x0,%edx
  800777:	48 89 c6             	mov    %rax,%rsi
  80077a:	bf 00 00 00 00       	mov    $0x0,%edi
  80077f:	48 b8 1f 4c 80 00 00 	movabs $0x804c1f,%rax
  800786:	00 00 00 
  800789:	ff d0                	callq  *%rax
  80078b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80078e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800792:	79 30                	jns    8007c4 <bc_pgfault+0x1d1>
		panic("in bc_pgfault, sys_page_map: %e", r);
  800794:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800797:	89 c1                	mov    %eax,%ecx
  800799:	48 ba 68 75 80 00 00 	movabs $0x807568,%rdx
  8007a0:	00 00 00 
  8007a3:	be 43 00 00 00       	mov    $0x43,%esi
  8007a8:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  8007af:	00 00 00 
  8007b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8007b7:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8007be:	00 00 00 
  8007c1:	41 ff d0             	callq  *%r8

	// Check that the block we read was allocated. (exercise for
	// the reader: why do we do this *after* reading the block
	// in?)
	if (bitmap && block_is_free(blockno))
  8007c4:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  8007cb:	00 00 00 
  8007ce:	48 8b 00             	mov    (%rax),%rax
  8007d1:	48 85 c0             	test   %rax,%rax
  8007d4:	74 48                	je     80081e <bc_pgfault+0x22b>
  8007d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8007da:	89 c7                	mov    %eax,%edi
  8007dc:	48 b8 a6 0c 80 00 00 	movabs $0x800ca6,%rax
  8007e3:	00 00 00 
  8007e6:	ff d0                	callq  *%rax
  8007e8:	84 c0                	test   %al,%al
  8007ea:	74 32                	je     80081e <bc_pgfault+0x22b>
		panic("reading free block %08x\n", blockno);
  8007ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8007f0:	48 89 c1             	mov    %rax,%rcx
  8007f3:	48 ba 88 75 80 00 00 	movabs $0x807588,%rdx
  8007fa:	00 00 00 
  8007fd:	be 49 00 00 00       	mov    $0x49,%esi
  800802:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800809:	00 00 00 
  80080c:	b8 00 00 00 00       	mov    $0x0,%eax
  800811:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800818:	00 00 00 
  80081b:	41 ff d0             	callq  *%r8
}
  80081e:	c9                   	leaveq 
  80081f:	c3                   	retq   

0000000000800820 <flush_block>:
// Hint: Use va_is_mapped, va_is_dirty, and ide_write.
// Hint: Use the PTE_SYSCALL constant when calling sys_page_map.
// Hint: Don't forget to round addr down.
void
flush_block(void *addr)
{
  800820:	55                   	push   %rbp
  800821:	48 89 e5             	mov    %rsp,%rbp
  800824:	48 83 ec 20          	sub    $0x20,%rsp
  800828:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	uint64_t blockno = ((uint64_t)addr - DISKMAP) / BLKSIZE;
  80082c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800830:	48 2d 00 00 00 10    	sub    $0x10000000,%rax
  800836:	48 c1 e8 0c          	shr    $0xc,%rax
  80083a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

	if (addr < (void*)DISKMAP || addr >= (void*)(DISKMAP + DISKSIZE))
  80083e:	48 81 7d e8 ff ff ff 	cmpq   $0xfffffff,-0x18(%rbp)
  800845:	0f 
  800846:	76 0b                	jbe    800853 <flush_block+0x33>
  800848:	b8 ff ff ff cf       	mov    $0xcfffffff,%eax
  80084d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
  800851:	76 32                	jbe    800885 <flush_block+0x65>
		panic("flush_block of bad va %08x", addr);
  800853:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800857:	48 89 c1             	mov    %rax,%rcx
  80085a:	48 ba a1 75 80 00 00 	movabs $0x8075a1,%rdx
  800861:	00 00 00 
  800864:	be 59 00 00 00       	mov    $0x59,%esi
  800869:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800870:	00 00 00 
  800873:	b8 00 00 00 00       	mov    $0x0,%eax
  800878:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80087f:	00 00 00 
  800882:	41 ff d0             	callq  *%r8

	if (!va_is_mapped(addr) || !va_is_dirty(addr))
  800885:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800889:	48 89 c7             	mov    %rax,%rdi
  80088c:	48 b8 22 05 80 00 00 	movabs $0x800522,%rax
  800893:	00 00 00 
  800896:	ff d0                	callq  *%rax
  800898:	83 f0 01             	xor    $0x1,%eax
  80089b:	84 c0                	test   %al,%al
  80089d:	75 1a                	jne    8008b9 <flush_block+0x99>
  80089f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008a3:	48 89 c7             	mov    %rax,%rdi
  8008a6:	48 b8 c3 05 80 00 00 	movabs $0x8005c3,%rax
  8008ad:	00 00 00 
  8008b0:	ff d0                	callq  *%rax
  8008b2:	83 f0 01             	xor    $0x1,%eax
  8008b5:	84 c0                	test   %al,%al
  8008b7:	74 02                	je     8008bb <flush_block+0x9b>
		return;
  8008b9:	eb 5d                	jmp    800918 <flush_block+0xf8>

	// Write the disk block and clear PTE_D.
	addr = ROUNDDOWN(addr, BLKSIZE);
  8008bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8008c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8008c7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8008cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
	/* FIXME DP: Should be lab 8 */
    /* Your code here */

#endif

	sys_page_map(0, addr, 0, addr, uvpt[PGNUM(addr)] & PTE_SYSCALL);
  8008d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008d5:	48 c1 e8 0c          	shr    $0xc,%rax
  8008d9:	48 89 c2             	mov    %rax,%rdx
  8008dc:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8008e3:	01 00 00 
  8008e6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8008ea:	25 07 0e 00 00       	and    $0xe07,%eax
  8008ef:	89 c1                	mov    %eax,%ecx
  8008f1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008f9:	41 89 c8             	mov    %ecx,%r8d
  8008fc:	48 89 d1             	mov    %rdx,%rcx
  8008ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800904:	48 89 c6             	mov    %rax,%rsi
  800907:	bf 00 00 00 00       	mov    $0x0,%edi
  80090c:	48 b8 1f 4c 80 00 00 	movabs $0x804c1f,%rax
  800913:	00 00 00 
  800916:	ff d0                	callq  *%rax
}
  800918:	c9                   	leaveq 
  800919:	c3                   	retq   

000000000080091a <check_bc>:

// Test that the block cache works, by smashing the superblock and
// reading it back.
static void
check_bc(void)
{
  80091a:	55                   	push   %rbp
  80091b:	48 89 e5             	mov    %rsp,%rbp
  80091e:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
	struct Super backup;

	// back up super block
	memmove(&backup, diskaddr(1), sizeof backup);
  800925:	bf 01 00 00 00       	mov    $0x1,%edi
  80092a:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800931:	00 00 00 
  800934:	ff d0                	callq  *%rax
  800936:	48 89 c1             	mov    %rax,%rcx
  800939:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800940:	ba 08 01 00 00       	mov    $0x108,%edx
  800945:	48 89 ce             	mov    %rcx,%rsi
  800948:	48 89 c7             	mov    %rax,%rdi
  80094b:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  800952:	00 00 00 
  800955:	ff d0                	callq  *%rax

	// smash it
	strcpy(diskaddr(1), "OOPS!\n");
  800957:	bf 01 00 00 00       	mov    $0x1,%edi
  80095c:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800963:	00 00 00 
  800966:	ff d0                	callq  *%rax
  800968:	48 be bc 75 80 00 00 	movabs $0x8075bc,%rsi
  80096f:	00 00 00 
  800972:	48 89 c7             	mov    %rax,%rdi
  800975:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  80097c:	00 00 00 
  80097f:	ff d0                	callq  *%rax
	flush_block(diskaddr(1));
  800981:	bf 01 00 00 00       	mov    $0x1,%edi
  800986:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  80098d:	00 00 00 
  800990:	ff d0                	callq  *%rax
  800992:	48 89 c7             	mov    %rax,%rdi
  800995:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  80099c:	00 00 00 
  80099f:	ff d0                	callq  *%rax
	assert(va_is_mapped(diskaddr(1)));
  8009a1:	bf 01 00 00 00       	mov    $0x1,%edi
  8009a6:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  8009ad:	00 00 00 
  8009b0:	ff d0                	callq  *%rax
  8009b2:	48 89 c7             	mov    %rax,%rdi
  8009b5:	48 b8 22 05 80 00 00 	movabs $0x800522,%rax
  8009bc:	00 00 00 
  8009bf:	ff d0                	callq  *%rax
  8009c1:	83 f0 01             	xor    $0x1,%eax
  8009c4:	84 c0                	test   %al,%al
  8009c6:	74 35                	je     8009fd <check_bc+0xe3>
  8009c8:	48 b9 c3 75 80 00 00 	movabs $0x8075c3,%rcx
  8009cf:	00 00 00 
  8009d2:	48 ba dd 75 80 00 00 	movabs $0x8075dd,%rdx
  8009d9:	00 00 00 
  8009dc:	be 7c 00 00 00       	mov    $0x7c,%esi
  8009e1:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  8009e8:	00 00 00 
  8009eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8009f0:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8009f7:	00 00 00 
  8009fa:	41 ff d0             	callq  *%r8
	assert(!va_is_dirty(diskaddr(1)));
  8009fd:	bf 01 00 00 00       	mov    $0x1,%edi
  800a02:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800a09:	00 00 00 
  800a0c:	ff d0                	callq  *%rax
  800a0e:	48 89 c7             	mov    %rax,%rdi
  800a11:	48 b8 c3 05 80 00 00 	movabs $0x8005c3,%rax
  800a18:	00 00 00 
  800a1b:	ff d0                	callq  *%rax
  800a1d:	84 c0                	test   %al,%al
  800a1f:	74 35                	je     800a56 <check_bc+0x13c>
  800a21:	48 b9 f2 75 80 00 00 	movabs $0x8075f2,%rcx
  800a28:	00 00 00 
  800a2b:	48 ba dd 75 80 00 00 	movabs $0x8075dd,%rdx
  800a32:	00 00 00 
  800a35:	be 7d 00 00 00       	mov    $0x7d,%esi
  800a3a:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800a41:	00 00 00 
  800a44:	b8 00 00 00 00       	mov    $0x0,%eax
  800a49:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800a50:	00 00 00 
  800a53:	41 ff d0             	callq  *%r8

	// clear it out
	sys_page_unmap(0, diskaddr(1));
  800a56:	bf 01 00 00 00       	mov    $0x1,%edi
  800a5b:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800a62:	00 00 00 
  800a65:	ff d0                	callq  *%rax
  800a67:	48 89 c6             	mov    %rax,%rsi
  800a6a:	bf 00 00 00 00       	mov    $0x0,%edi
  800a6f:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  800a76:	00 00 00 
  800a79:	ff d0                	callq  *%rax
	assert(!va_is_mapped(diskaddr(1)));
  800a7b:	bf 01 00 00 00       	mov    $0x1,%edi
  800a80:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800a87:	00 00 00 
  800a8a:	ff d0                	callq  *%rax
  800a8c:	48 89 c7             	mov    %rax,%rdi
  800a8f:	48 b8 22 05 80 00 00 	movabs $0x800522,%rax
  800a96:	00 00 00 
  800a99:	ff d0                	callq  *%rax
  800a9b:	84 c0                	test   %al,%al
  800a9d:	74 35                	je     800ad4 <check_bc+0x1ba>
  800a9f:	48 b9 0c 76 80 00 00 	movabs $0x80760c,%rcx
  800aa6:	00 00 00 
  800aa9:	48 ba dd 75 80 00 00 	movabs $0x8075dd,%rdx
  800ab0:	00 00 00 
  800ab3:	be 81 00 00 00       	mov    $0x81,%esi
  800ab8:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800abf:	00 00 00 
  800ac2:	b8 00 00 00 00       	mov    $0x0,%eax
  800ac7:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800ace:	00 00 00 
  800ad1:	41 ff d0             	callq  *%r8

	// read it back in
	assert(strcmp(diskaddr(1), "OOPS!\n") == 0);
  800ad4:	bf 01 00 00 00       	mov    $0x1,%edi
  800ad9:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800ae0:	00 00 00 
  800ae3:	ff d0                	callq  *%rax
  800ae5:	48 be bc 75 80 00 00 	movabs $0x8075bc,%rsi
  800aec:	00 00 00 
  800aef:	48 89 c7             	mov    %rax,%rdi
  800af2:	48 b8 02 44 80 00 00 	movabs $0x804402,%rax
  800af9:	00 00 00 
  800afc:	ff d0                	callq  *%rax
  800afe:	85 c0                	test   %eax,%eax
  800b00:	74 35                	je     800b37 <check_bc+0x21d>
  800b02:	48 b9 28 76 80 00 00 	movabs $0x807628,%rcx
  800b09:	00 00 00 
  800b0c:	48 ba dd 75 80 00 00 	movabs $0x8075dd,%rdx
  800b13:	00 00 00 
  800b16:	be 84 00 00 00       	mov    $0x84,%esi
  800b1b:	48 bf da 74 80 00 00 	movabs $0x8074da,%rdi
  800b22:	00 00 00 
  800b25:	b8 00 00 00 00       	mov    $0x0,%eax
  800b2a:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800b31:	00 00 00 
  800b34:	41 ff d0             	callq  *%r8

	// fix it
	memmove(diskaddr(1), &backup, sizeof backup);
  800b37:	bf 01 00 00 00       	mov    $0x1,%edi
  800b3c:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800b43:	00 00 00 
  800b46:	ff d0                	callq  *%rax
  800b48:	48 8d 8d f0 fe ff ff 	lea    -0x110(%rbp),%rcx
  800b4f:	ba 08 01 00 00       	mov    $0x108,%edx
  800b54:	48 89 ce             	mov    %rcx,%rsi
  800b57:	48 89 c7             	mov    %rax,%rdi
  800b5a:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  800b61:	00 00 00 
  800b64:	ff d0                	callq  *%rax
	flush_block(diskaddr(1));
  800b66:	bf 01 00 00 00       	mov    $0x1,%edi
  800b6b:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800b72:	00 00 00 
  800b75:	ff d0                	callq  *%rax
  800b77:	48 89 c7             	mov    %rax,%rdi
  800b7a:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  800b81:	00 00 00 
  800b84:	ff d0                	callq  *%rax

	cprintf("block cache is good\n");
  800b86:	48 bf 4c 76 80 00 00 	movabs $0x80764c,%rdi
  800b8d:	00 00 00 
  800b90:	b8 00 00 00 00       	mov    $0x0,%eax
  800b95:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  800b9c:	00 00 00 
  800b9f:	ff d2                	callq  *%rdx
}
  800ba1:	c9                   	leaveq 
  800ba2:	c3                   	retq   

0000000000800ba3 <bc_init>:

void
bc_init(void)
{
  800ba3:	55                   	push   %rbp
  800ba4:	48 89 e5             	mov    %rsp,%rbp
  800ba7:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
	struct Super super;
	set_pgfault_handler(bc_pgfault);
  800bae:	48 bf f3 05 80 00 00 	movabs $0x8005f3,%rdi
  800bb5:	00 00 00 
  800bb8:	48 b8 af 4f 80 00 00 	movabs $0x804faf,%rax
  800bbf:	00 00 00 
  800bc2:	ff d0                	callq  *%rax
	check_bc();
  800bc4:	48 b8 1a 09 80 00 00 	movabs $0x80091a,%rax
  800bcb:	00 00 00 
  800bce:	ff d0                	callq  *%rax

	// cache the super block by reading it once
	memmove(&super, diskaddr(1), sizeof super);
  800bd0:	bf 01 00 00 00       	mov    $0x1,%edi
  800bd5:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  800bdc:	00 00 00 
  800bdf:	ff d0                	callq  *%rax
  800be1:	48 89 c1             	mov    %rax,%rcx
  800be4:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800beb:	ba 08 01 00 00       	mov    $0x108,%edx
  800bf0:	48 89 ce             	mov    %rcx,%rsi
  800bf3:	48 89 c7             	mov    %rax,%rdi
  800bf6:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  800bfd:	00 00 00 
  800c00:	ff d0                	callq  *%rax
}
  800c02:	c9                   	leaveq 
  800c03:	c3                   	retq   

0000000000800c04 <check_super>:
  800c04:	55                   	push   %rbp
  800c05:	48 89 e5             	mov    %rsp,%rbp
  800c08:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800c0f:	00 00 00 
  800c12:	48 8b 00             	mov    (%rax),%rax
  800c15:	8b 00                	mov    (%rax),%eax
  800c17:	3d ae 30 05 4a       	cmp    $0x4a0530ae,%eax
  800c1c:	74 2a                	je     800c48 <check_super+0x44>
  800c1e:	48 ba 61 76 80 00 00 	movabs $0x807661,%rdx
  800c25:	00 00 00 
  800c28:	be 12 00 00 00       	mov    $0x12,%esi
  800c2d:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800c34:	00 00 00 
  800c37:	b8 00 00 00 00       	mov    $0x0,%eax
  800c3c:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  800c43:	00 00 00 
  800c46:	ff d1                	callq  *%rcx
  800c48:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800c4f:	00 00 00 
  800c52:	48 8b 00             	mov    (%rax),%rax
  800c55:	8b 40 04             	mov    0x4(%rax),%eax
  800c58:	3d 00 00 0c 00       	cmp    $0xc0000,%eax
  800c5d:	76 2a                	jbe    800c89 <check_super+0x85>
  800c5f:	48 ba 89 76 80 00 00 	movabs $0x807689,%rdx
  800c66:	00 00 00 
  800c69:	be 15 00 00 00       	mov    $0x15,%esi
  800c6e:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800c75:	00 00 00 
  800c78:	b8 00 00 00 00       	mov    $0x0,%eax
  800c7d:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  800c84:	00 00 00 
  800c87:	ff d1                	callq  *%rcx
  800c89:	48 bf a2 76 80 00 00 	movabs $0x8076a2,%rdi
  800c90:	00 00 00 
  800c93:	b8 00 00 00 00       	mov    $0x0,%eax
  800c98:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  800c9f:	00 00 00 
  800ca2:	ff d2                	callq  *%rdx
  800ca4:	5d                   	pop    %rbp
  800ca5:	c3                   	retq   

0000000000800ca6 <block_is_free>:
  800ca6:	55                   	push   %rbp
  800ca7:	48 89 e5             	mov    %rsp,%rbp
  800caa:	48 83 ec 04          	sub    $0x4,%rsp
  800cae:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800cb1:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800cb8:	00 00 00 
  800cbb:	48 8b 00             	mov    (%rax),%rax
  800cbe:	48 85 c0             	test   %rax,%rax
  800cc1:	74 15                	je     800cd8 <block_is_free+0x32>
  800cc3:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800cca:	00 00 00 
  800ccd:	48 8b 00             	mov    (%rax),%rax
  800cd0:	8b 40 04             	mov    0x4(%rax),%eax
  800cd3:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  800cd6:	77 07                	ja     800cdf <block_is_free+0x39>
  800cd8:	b8 00 00 00 00       	mov    $0x0,%eax
  800cdd:	eb 41                	jmp    800d20 <block_is_free+0x7a>
  800cdf:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  800ce6:	00 00 00 
  800ce9:	48 8b 00             	mov    (%rax),%rax
  800cec:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800cef:	c1 ea 05             	shr    $0x5,%edx
  800cf2:	89 d2                	mov    %edx,%edx
  800cf4:	48 c1 e2 02          	shl    $0x2,%rdx
  800cf8:	48 01 d0             	add    %rdx,%rax
  800cfb:	8b 10                	mov    (%rax),%edx
  800cfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d00:	83 e0 1f             	and    $0x1f,%eax
  800d03:	be 01 00 00 00       	mov    $0x1,%esi
  800d08:	89 c1                	mov    %eax,%ecx
  800d0a:	d3 e6                	shl    %cl,%esi
  800d0c:	89 f0                	mov    %esi,%eax
  800d0e:	21 d0                	and    %edx,%eax
  800d10:	85 c0                	test   %eax,%eax
  800d12:	74 07                	je     800d1b <block_is_free+0x75>
  800d14:	b8 01 00 00 00       	mov    $0x1,%eax
  800d19:	eb 05                	jmp    800d20 <block_is_free+0x7a>
  800d1b:	b8 00 00 00 00       	mov    $0x0,%eax
  800d20:	c9                   	leaveq 
  800d21:	c3                   	retq   

0000000000800d22 <free_block>:
  800d22:	55                   	push   %rbp
  800d23:	48 89 e5             	mov    %rsp,%rbp
  800d26:	48 83 ec 10          	sub    $0x10,%rsp
  800d2a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d2d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800d31:	75 2a                	jne    800d5d <free_block+0x3b>
  800d33:	48 ba b6 76 80 00 00 	movabs $0x8076b6,%rdx
  800d3a:	00 00 00 
  800d3d:	be 30 00 00 00       	mov    $0x30,%esi
  800d42:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800d49:	00 00 00 
  800d4c:	b8 00 00 00 00       	mov    $0x0,%eax
  800d51:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  800d58:	00 00 00 
  800d5b:	ff d1                	callq  *%rcx
  800d5d:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  800d64:	00 00 00 
  800d67:	48 8b 10             	mov    (%rax),%rdx
  800d6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d6d:	c1 e8 05             	shr    $0x5,%eax
  800d70:	89 c1                	mov    %eax,%ecx
  800d72:	48 c1 e1 02          	shl    $0x2,%rcx
  800d76:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
  800d7a:	48 ba 10 60 81 00 00 	movabs $0x816010,%rdx
  800d81:	00 00 00 
  800d84:	48 8b 12             	mov    (%rdx),%rdx
  800d87:	89 c0                	mov    %eax,%eax
  800d89:	48 c1 e0 02          	shl    $0x2,%rax
  800d8d:	48 01 d0             	add    %rdx,%rax
  800d90:	8b 10                	mov    (%rax),%edx
  800d92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d95:	83 e0 1f             	and    $0x1f,%eax
  800d98:	bf 01 00 00 00       	mov    $0x1,%edi
  800d9d:	89 c1                	mov    %eax,%ecx
  800d9f:	d3 e7                	shl    %cl,%edi
  800da1:	89 f8                	mov    %edi,%eax
  800da3:	09 d0                	or     %edx,%eax
  800da5:	89 06                	mov    %eax,(%rsi)
  800da7:	c9                   	leaveq 
  800da8:	c3                   	retq   

0000000000800da9 <alloc_block>:
  800da9:	55                   	push   %rbp
  800daa:	48 89 e5             	mov    %rsp,%rbp
  800dad:	48 83 ec 10          	sub    $0x10,%rsp
  800db1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800db8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800dbf:	e9 ee 00 00 00       	jmpq   800eb2 <alloc_block+0x109>
  800dc4:	48 b8 00 30 81 00 00 	movabs $0x813000,%rax
  800dcb:	00 00 00 
  800dce:	8b 10                	mov    (%rax),%edx
  800dd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800dd3:	01 d0                	add    %edx,%eax
  800dd5:	48 ba 18 60 81 00 00 	movabs $0x816018,%rdx
  800ddc:	00 00 00 
  800ddf:	48 8b 12             	mov    (%rdx),%rdx
  800de2:	8b 4a 04             	mov    0x4(%rdx),%ecx
  800de5:	ba 00 00 00 00       	mov    $0x0,%edx
  800dea:	f7 f1                	div    %ecx
  800dec:	89 d0                	mov    %edx,%eax
  800dee:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800df1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800df4:	89 c7                	mov    %eax,%edi
  800df6:	48 b8 a6 0c 80 00 00 	movabs $0x800ca6,%rax
  800dfd:	00 00 00 
  800e00:	ff d0                	callq  *%rax
  800e02:	84 c0                	test   %al,%al
  800e04:	0f 84 a4 00 00 00    	je     800eae <alloc_block+0x105>
  800e0a:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  800e11:	00 00 00 
  800e14:	48 8b 10             	mov    (%rax),%rdx
  800e17:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800e1a:	8d 48 1f             	lea    0x1f(%rax),%ecx
  800e1d:	85 c0                	test   %eax,%eax
  800e1f:	0f 48 c1             	cmovs  %ecx,%eax
  800e22:	c1 f8 05             	sar    $0x5,%eax
  800e25:	48 63 c8             	movslq %eax,%rcx
  800e28:	48 c1 e1 02          	shl    $0x2,%rcx
  800e2c:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
  800e30:	48 ba 10 60 81 00 00 	movabs $0x816010,%rdx
  800e37:	00 00 00 
  800e3a:	48 8b 12             	mov    (%rdx),%rdx
  800e3d:	48 98                	cltq   
  800e3f:	48 c1 e0 02          	shl    $0x2,%rax
  800e43:	48 01 d0             	add    %rdx,%rax
  800e46:	8b 38                	mov    (%rax),%edi
  800e48:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800e4b:	99                   	cltd   
  800e4c:	c1 ea 1b             	shr    $0x1b,%edx
  800e4f:	01 d0                	add    %edx,%eax
  800e51:	83 e0 1f             	and    $0x1f,%eax
  800e54:	29 d0                	sub    %edx,%eax
  800e56:	ba 01 00 00 00       	mov    $0x1,%edx
  800e5b:	89 c1                	mov    %eax,%ecx
  800e5d:	d3 e2                	shl    %cl,%edx
  800e5f:	89 d0                	mov    %edx,%eax
  800e61:	f7 d0                	not    %eax
  800e63:	21 f8                	and    %edi,%eax
  800e65:	89 06                	mov    %eax,(%rsi)
  800e67:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  800e6e:	00 00 00 
  800e71:	48 8b 10             	mov    (%rax),%rdx
  800e74:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800e77:	8d 48 1f             	lea    0x1f(%rax),%ecx
  800e7a:	85 c0                	test   %eax,%eax
  800e7c:	0f 48 c1             	cmovs  %ecx,%eax
  800e7f:	c1 f8 05             	sar    $0x5,%eax
  800e82:	48 98                	cltq   
  800e84:	48 c1 e0 02          	shl    $0x2,%rax
  800e88:	48 01 d0             	add    %rdx,%rax
  800e8b:	48 89 c7             	mov    %rax,%rdi
  800e8e:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  800e95:	00 00 00 
  800e98:	ff d0                	callq  *%rax
  800e9a:	48 b8 00 30 81 00 00 	movabs $0x813000,%rax
  800ea1:	00 00 00 
  800ea4:	8b 55 f8             	mov    -0x8(%rbp),%edx
  800ea7:	89 10                	mov    %edx,(%rax)
  800ea9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800eac:	eb 24                	jmp    800ed2 <alloc_block+0x129>
  800eae:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800eb2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800eb5:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800ebc:	00 00 00 
  800ebf:	48 8b 00             	mov    (%rax),%rax
  800ec2:	8b 40 04             	mov    0x4(%rax),%eax
  800ec5:	39 c2                	cmp    %eax,%edx
  800ec7:	0f 82 f7 fe ff ff    	jb     800dc4 <alloc_block+0x1b>
  800ecd:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
  800ed2:	c9                   	leaveq 
  800ed3:	c3                   	retq   

0000000000800ed4 <check_bitmap>:
  800ed4:	55                   	push   %rbp
  800ed5:	48 89 e5             	mov    %rsp,%rbp
  800ed8:	48 83 ec 10          	sub    $0x10,%rsp
  800edc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800ee3:	eb 51                	jmp    800f36 <check_bitmap+0x62>
  800ee5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ee8:	83 c0 02             	add    $0x2,%eax
  800eeb:	89 c7                	mov    %eax,%edi
  800eed:	48 b8 a6 0c 80 00 00 	movabs $0x800ca6,%rax
  800ef4:	00 00 00 
  800ef7:	ff d0                	callq  *%rax
  800ef9:	84 c0                	test   %al,%al
  800efb:	74 35                	je     800f32 <check_bitmap+0x5e>
  800efd:	48 b9 d1 76 80 00 00 	movabs $0x8076d1,%rcx
  800f04:	00 00 00 
  800f07:	48 ba e5 76 80 00 00 	movabs $0x8076e5,%rdx
  800f0e:	00 00 00 
  800f11:	be 62 00 00 00       	mov    $0x62,%esi
  800f16:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800f1d:	00 00 00 
  800f20:	b8 00 00 00 00       	mov    $0x0,%eax
  800f25:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800f2c:	00 00 00 
  800f2f:	41 ff d0             	callq  *%r8
  800f32:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f39:	c1 e0 0f             	shl    $0xf,%eax
  800f3c:	89 c2                	mov    %eax,%edx
  800f3e:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  800f45:	00 00 00 
  800f48:	48 8b 00             	mov    (%rax),%rax
  800f4b:	8b 40 04             	mov    0x4(%rax),%eax
  800f4e:	39 c2                	cmp    %eax,%edx
  800f50:	72 93                	jb     800ee5 <check_bitmap+0x11>
  800f52:	bf 00 00 00 00       	mov    $0x0,%edi
  800f57:	48 b8 a6 0c 80 00 00 	movabs $0x800ca6,%rax
  800f5e:	00 00 00 
  800f61:	ff d0                	callq  *%rax
  800f63:	84 c0                	test   %al,%al
  800f65:	74 35                	je     800f9c <check_bitmap+0xc8>
  800f67:	48 b9 fa 76 80 00 00 	movabs $0x8076fa,%rcx
  800f6e:	00 00 00 
  800f71:	48 ba e5 76 80 00 00 	movabs $0x8076e5,%rdx
  800f78:	00 00 00 
  800f7b:	be 65 00 00 00       	mov    $0x65,%esi
  800f80:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800f87:	00 00 00 
  800f8a:	b8 00 00 00 00       	mov    $0x0,%eax
  800f8f:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800f96:	00 00 00 
  800f99:	41 ff d0             	callq  *%r8
  800f9c:	bf 01 00 00 00       	mov    $0x1,%edi
  800fa1:	48 b8 a6 0c 80 00 00 	movabs $0x800ca6,%rax
  800fa8:	00 00 00 
  800fab:	ff d0                	callq  *%rax
  800fad:	84 c0                	test   %al,%al
  800faf:	74 35                	je     800fe6 <check_bitmap+0x112>
  800fb1:	48 b9 0c 77 80 00 00 	movabs $0x80770c,%rcx
  800fb8:	00 00 00 
  800fbb:	48 ba e5 76 80 00 00 	movabs $0x8076e5,%rdx
  800fc2:	00 00 00 
  800fc5:	be 66 00 00 00       	mov    $0x66,%esi
  800fca:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  800fd1:	00 00 00 
  800fd4:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd9:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  800fe0:	00 00 00 
  800fe3:	41 ff d0             	callq  *%r8
  800fe6:	48 bf 1e 77 80 00 00 	movabs $0x80771e,%rdi
  800fed:	00 00 00 
  800ff0:	b8 00 00 00 00       	mov    $0x0,%eax
  800ff5:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  800ffc:	00 00 00 
  800fff:	ff d2                	callq  *%rdx
  801001:	c9                   	leaveq 
  801002:	c3                   	retq   

0000000000801003 <fs_init>:
  801003:	55                   	push   %rbp
  801004:	48 89 e5             	mov    %rsp,%rbp
  801007:	b8 00 00 00 00       	mov    $0x0,%eax
  80100c:	48 ba db 32 80 00 00 	movabs $0x8032db,%rdx
  801013:	00 00 00 
  801016:	ff d2                	callq  *%rdx
  801018:	48 b8 a3 0b 80 00 00 	movabs $0x800ba3,%rax
  80101f:	00 00 00 
  801022:	ff d0                	callq  *%rax
  801024:	bf 01 00 00 00       	mov    $0x1,%edi
  801029:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801030:	00 00 00 
  801033:	ff d0                	callq  *%rax
  801035:	48 ba 18 60 81 00 00 	movabs $0x816018,%rdx
  80103c:	00 00 00 
  80103f:	48 89 02             	mov    %rax,(%rdx)
  801042:	48 b8 04 0c 80 00 00 	movabs $0x800c04,%rax
  801049:	00 00 00 
  80104c:	ff d0                	callq  *%rax
  80104e:	bf 02 00 00 00       	mov    $0x2,%edi
  801053:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  80105a:	00 00 00 
  80105d:	ff d0                	callq  *%rax
  80105f:	48 ba 10 60 81 00 00 	movabs $0x816010,%rdx
  801066:	00 00 00 
  801069:	48 89 02             	mov    %rax,(%rdx)
  80106c:	48 b8 d4 0e 80 00 00 	movabs $0x800ed4,%rax
  801073:	00 00 00 
  801076:	ff d0                	callq  *%rax
  801078:	5d                   	pop    %rbp
  801079:	c3                   	retq   

000000000080107a <file_block_walk>:
  80107a:	55                   	push   %rbp
  80107b:	48 89 e5             	mov    %rsp,%rbp
  80107e:	48 83 ec 30          	sub    $0x30,%rsp
  801082:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801086:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801089:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80108d:	89 c8                	mov    %ecx,%eax
  80108f:	88 45 e0             	mov    %al,-0x20(%rbp)
  801092:	83 7d e4 09          	cmpl   $0x9,-0x1c(%rbp)
  801096:	77 23                	ja     8010bb <file_block_walk+0x41>
  801098:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80109b:	48 83 c0 20          	add    $0x20,%rax
  80109f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  8010a6:	00 
  8010a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ab:	48 01 d0             	add    %rdx,%rax
  8010ae:	48 83 c0 08          	add    $0x8,%rax
  8010b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8010b6:	e9 bd 00 00 00       	jmpq   801178 <file_block_walk+0xfe>
  8010bb:	81 7d e4 09 04 00 00 	cmpl   $0x409,-0x1c(%rbp)
  8010c2:	0f 87 a9 00 00 00    	ja     801171 <file_block_walk+0xf7>
  8010c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010cc:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  8010d2:	85 c0                	test   %eax,%eax
  8010d4:	75 6c                	jne    801142 <file_block_walk+0xc8>
  8010d6:	0f b6 45 e0          	movzbl -0x20(%rbp),%eax
  8010da:	83 f0 01             	xor    $0x1,%eax
  8010dd:	84 c0                	test   %al,%al
  8010df:	74 0a                	je     8010eb <file_block_walk+0x71>
  8010e1:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  8010e6:	e9 9d 00 00 00       	jmpq   801188 <file_block_walk+0x10e>
  8010eb:	48 b8 a9 0d 80 00 00 	movabs $0x800da9,%rax
  8010f2:	00 00 00 
  8010f5:	ff d0                	callq  *%rax
  8010f7:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8010fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8010fe:	79 08                	jns    801108 <file_block_walk+0x8e>
  801100:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801103:	e9 80 00 00 00       	jmpq   801188 <file_block_walk+0x10e>
  801108:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80110b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80110f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%rax)
  801115:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801118:	48 98                	cltq   
  80111a:	48 89 c7             	mov    %rax,%rdi
  80111d:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801124:	00 00 00 
  801127:	ff d0                	callq  *%rax
  801129:	ba 00 10 00 00       	mov    $0x1000,%edx
  80112e:	be 00 00 00 00       	mov    $0x0,%esi
  801133:	48 89 c7             	mov    %rax,%rdi
  801136:	48 b8 39 45 80 00 00 	movabs $0x804539,%rax
  80113d:	00 00 00 
  801140:	ff d0                	callq  *%rax
  801142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801146:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  80114c:	89 c0                	mov    %eax,%eax
  80114e:	48 89 c7             	mov    %rax,%rdi
  801151:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801158:	00 00 00 
  80115b:	ff d0                	callq  *%rax
  80115d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  801160:	48 c1 e2 02          	shl    $0x2,%rdx
  801164:	48 83 ea 28          	sub    $0x28,%rdx
  801168:	48 01 d0             	add    %rdx,%rax
  80116b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80116f:	eb 07                	jmp    801178 <file_block_walk+0xfe>
  801171:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801176:	eb 10                	jmp    801188 <file_block_walk+0x10e>
  801178:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80117c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801180:	48 89 10             	mov    %rdx,(%rax)
  801183:	b8 00 00 00 00       	mov    $0x0,%eax
  801188:	c9                   	leaveq 
  801189:	c3                   	retq   

000000000080118a <file_get_block>:
  80118a:	55                   	push   %rbp
  80118b:	48 89 e5             	mov    %rsp,%rbp
  80118e:	48 83 ec 30          	sub    $0x30,%rsp
  801192:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801196:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801199:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80119d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8011a1:	8b 75 e4             	mov    -0x1c(%rbp),%esi
  8011a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011a8:	b9 01 00 00 00       	mov    $0x1,%ecx
  8011ad:	48 89 c7             	mov    %rax,%rdi
  8011b0:	48 b8 7a 10 80 00 00 	movabs $0x80107a,%rax
  8011b7:	00 00 00 
  8011ba:	ff d0                	callq  *%rax
  8011bc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8011bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8011c3:	79 05                	jns    8011ca <file_get_block+0x40>
  8011c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011c8:	eb 50                	jmp    80121a <file_get_block+0x90>
  8011ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011ce:	8b 00                	mov    (%rax),%eax
  8011d0:	85 c0                	test   %eax,%eax
  8011d2:	75 23                	jne    8011f7 <file_get_block+0x6d>
  8011d4:	48 b8 a9 0d 80 00 00 	movabs $0x800da9,%rax
  8011db:	00 00 00 
  8011de:	ff d0                	callq  *%rax
  8011e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8011e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8011e7:	79 05                	jns    8011ee <file_get_block+0x64>
  8011e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011ec:	eb 2c                	jmp    80121a <file_get_block+0x90>
  8011ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011f2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8011f5:	89 10                	mov    %edx,(%rax)
  8011f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011fb:	8b 00                	mov    (%rax),%eax
  8011fd:	89 c0                	mov    %eax,%eax
  8011ff:	48 89 c7             	mov    %rax,%rdi
  801202:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801209:	00 00 00 
  80120c:	ff d0                	callq  *%rax
  80120e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801212:	48 89 02             	mov    %rax,(%rdx)
  801215:	b8 00 00 00 00       	mov    $0x0,%eax
  80121a:	c9                   	leaveq 
  80121b:	c3                   	retq   

000000000080121c <dir_lookup>:
  80121c:	55                   	push   %rbp
  80121d:	48 89 e5             	mov    %rsp,%rbp
  801220:	48 83 ec 40          	sub    $0x40,%rsp
  801224:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801228:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80122c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  801230:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801234:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  80123a:	25 ff 0f 00 00       	and    $0xfff,%eax
  80123f:	85 c0                	test   %eax,%eax
  801241:	74 35                	je     801278 <dir_lookup+0x5c>
  801243:	48 b9 2e 77 80 00 00 	movabs $0x80772e,%rcx
  80124a:	00 00 00 
  80124d:	48 ba e5 76 80 00 00 	movabs $0x8076e5,%rdx
  801254:	00 00 00 
  801257:	be 32 01 00 00       	mov    $0x132,%esi
  80125c:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  801263:	00 00 00 
  801266:	b8 00 00 00 00       	mov    $0x0,%eax
  80126b:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  801272:	00 00 00 
  801275:	41 ff d0             	callq  *%r8
  801278:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80127c:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  801282:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  801288:	85 c0                	test   %eax,%eax
  80128a:	0f 48 c2             	cmovs  %edx,%eax
  80128d:	c1 f8 0c             	sar    $0xc,%eax
  801290:	89 45 f4             	mov    %eax,-0xc(%rbp)
  801293:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80129a:	e9 93 00 00 00       	jmpq   801332 <dir_lookup+0x116>
  80129f:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  8012a3:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  8012a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012aa:	89 ce                	mov    %ecx,%esi
  8012ac:	48 89 c7             	mov    %rax,%rdi
  8012af:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  8012b6:	00 00 00 
  8012b9:	ff d0                	callq  *%rax
  8012bb:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8012be:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8012c2:	79 05                	jns    8012c9 <dir_lookup+0xad>
  8012c4:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8012c7:	eb 7a                	jmp    801343 <dir_lookup+0x127>
  8012c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8012d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  8012d8:	eb 4e                	jmp    801328 <dir_lookup+0x10c>
  8012da:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8012dd:	48 c1 e0 08          	shl    $0x8,%rax
  8012e1:	48 89 c2             	mov    %rax,%rdx
  8012e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012e8:	48 01 d0             	add    %rdx,%rax
  8012eb:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8012ef:	48 89 d6             	mov    %rdx,%rsi
  8012f2:	48 89 c7             	mov    %rax,%rdi
  8012f5:	48 b8 02 44 80 00 00 	movabs $0x804402,%rax
  8012fc:	00 00 00 
  8012ff:	ff d0                	callq  *%rax
  801301:	85 c0                	test   %eax,%eax
  801303:	75 1f                	jne    801324 <dir_lookup+0x108>
  801305:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801308:	48 c1 e0 08          	shl    $0x8,%rax
  80130c:	48 89 c2             	mov    %rax,%rdx
  80130f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801313:	48 01 c2             	add    %rax,%rdx
  801316:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80131a:	48 89 10             	mov    %rdx,(%rax)
  80131d:	b8 00 00 00 00       	mov    $0x0,%eax
  801322:	eb 1f                	jmp    801343 <dir_lookup+0x127>
  801324:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  801328:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
  80132c:	76 ac                	jbe    8012da <dir_lookup+0xbe>
  80132e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801332:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801335:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  801338:	0f 82 61 ff ff ff    	jb     80129f <dir_lookup+0x83>
  80133e:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  801343:	c9                   	leaveq 
  801344:	c3                   	retq   

0000000000801345 <dir_alloc_file>:
  801345:	55                   	push   %rbp
  801346:	48 89 e5             	mov    %rsp,%rbp
  801349:	48 83 ec 30          	sub    $0x30,%rsp
  80134d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801351:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801355:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801359:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  80135f:	25 ff 0f 00 00       	and    $0xfff,%eax
  801364:	85 c0                	test   %eax,%eax
  801366:	74 35                	je     80139d <dir_alloc_file+0x58>
  801368:	48 b9 2e 77 80 00 00 	movabs $0x80772e,%rcx
  80136f:	00 00 00 
  801372:	48 ba e5 76 80 00 00 	movabs $0x8076e5,%rdx
  801379:	00 00 00 
  80137c:	be 4b 01 00 00       	mov    $0x14b,%esi
  801381:	48 bf 7e 76 80 00 00 	movabs $0x80767e,%rdi
  801388:	00 00 00 
  80138b:	b8 00 00 00 00       	mov    $0x0,%eax
  801390:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  801397:	00 00 00 
  80139a:	41 ff d0             	callq  *%r8
  80139d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013a1:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  8013a7:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  8013ad:	85 c0                	test   %eax,%eax
  8013af:	0f 48 c2             	cmovs  %edx,%eax
  8013b2:	c1 f8 0c             	sar    $0xc,%eax
  8013b5:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8013b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8013bf:	e9 83 00 00 00       	jmpq   801447 <dir_alloc_file+0x102>
  8013c4:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  8013c8:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  8013cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013cf:	89 ce                	mov    %ecx,%esi
  8013d1:	48 89 c7             	mov    %rax,%rdi
  8013d4:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  8013db:	00 00 00 
  8013de:	ff d0                	callq  *%rax
  8013e0:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8013e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8013e7:	79 08                	jns    8013f1 <dir_alloc_file+0xac>
  8013e9:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8013ec:	e9 be 00 00 00       	jmpq   8014af <dir_alloc_file+0x16a>
  8013f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8013f5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8013f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  801400:	eb 3b                	jmp    80143d <dir_alloc_file+0xf8>
  801402:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801405:	48 c1 e0 08          	shl    $0x8,%rax
  801409:	48 89 c2             	mov    %rax,%rdx
  80140c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801410:	48 01 d0             	add    %rdx,%rax
  801413:	0f b6 00             	movzbl (%rax),%eax
  801416:	84 c0                	test   %al,%al
  801418:	75 1f                	jne    801439 <dir_alloc_file+0xf4>
  80141a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80141d:	48 c1 e0 08          	shl    $0x8,%rax
  801421:	48 89 c2             	mov    %rax,%rdx
  801424:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801428:	48 01 c2             	add    %rax,%rdx
  80142b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80142f:	48 89 10             	mov    %rdx,(%rax)
  801432:	b8 00 00 00 00       	mov    $0x0,%eax
  801437:	eb 76                	jmp    8014af <dir_alloc_file+0x16a>
  801439:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  80143d:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
  801441:	76 bf                	jbe    801402 <dir_alloc_file+0xbd>
  801443:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801447:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80144a:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  80144d:	0f 82 71 ff ff ff    	jb     8013c4 <dir_alloc_file+0x7f>
  801453:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801457:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  80145d:	8d 90 00 10 00 00    	lea    0x1000(%rax),%edx
  801463:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801467:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80146d:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  801471:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  801474:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801478:	89 ce                	mov    %ecx,%esi
  80147a:	48 89 c7             	mov    %rax,%rdi
  80147d:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  801484:	00 00 00 
  801487:	ff d0                	callq  *%rax
  801489:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80148c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  801490:	79 05                	jns    801497 <dir_alloc_file+0x152>
  801492:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801495:	eb 18                	jmp    8014af <dir_alloc_file+0x16a>
  801497:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80149b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80149f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8014a3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8014a7:	48 89 10             	mov    %rdx,(%rax)
  8014aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8014af:	c9                   	leaveq 
  8014b0:	c3                   	retq   

00000000008014b1 <skip_slash>:
  8014b1:	55                   	push   %rbp
  8014b2:	48 89 e5             	mov    %rsp,%rbp
  8014b5:	48 83 ec 08          	sub    $0x8,%rsp
  8014b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014bd:	eb 05                	jmp    8014c4 <skip_slash+0x13>
  8014bf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8014c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014c8:	0f b6 00             	movzbl (%rax),%eax
  8014cb:	3c 2f                	cmp    $0x2f,%al
  8014cd:	74 f0                	je     8014bf <skip_slash+0xe>
  8014cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d3:	c9                   	leaveq 
  8014d4:	c3                   	retq   

00000000008014d5 <walk_path>:
  8014d5:	55                   	push   %rbp
  8014d6:	48 89 e5             	mov    %rsp,%rbp
  8014d9:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
  8014e0:	48 89 bd 48 ff ff ff 	mov    %rdi,-0xb8(%rbp)
  8014e7:	48 89 b5 40 ff ff ff 	mov    %rsi,-0xc0(%rbp)
  8014ee:	48 89 95 38 ff ff ff 	mov    %rdx,-0xc8(%rbp)
  8014f5:	48 89 8d 30 ff ff ff 	mov    %rcx,-0xd0(%rbp)
  8014fc:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  801503:	48 89 c7             	mov    %rax,%rdi
  801506:	48 b8 b1 14 80 00 00 	movabs $0x8014b1,%rax
  80150d:	00 00 00 
  801510:	ff d0                	callq  *%rax
  801512:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  801519:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  801520:	00 00 00 
  801523:	48 8b 00             	mov    (%rax),%rax
  801526:	48 83 c0 08          	add    $0x8,%rax
  80152a:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
  801531:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801538:	00 
  801539:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%rbp)
  801540:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
  801547:	00 
  801548:	74 0e                	je     801558 <walk_path+0x83>
  80154a:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
  801551:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801558:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
  80155f:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801566:	e9 73 01 00 00       	jmpq   8016de <walk_path+0x209>
  80156b:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  801572:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801576:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  80157d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801581:	eb 08                	jmp    80158b <walk_path+0xb6>
  801583:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
  80158a:	01 
  80158b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  801592:	0f b6 00             	movzbl (%rax),%eax
  801595:	3c 2f                	cmp    $0x2f,%al
  801597:	74 0e                	je     8015a7 <walk_path+0xd2>
  801599:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  8015a0:	0f b6 00             	movzbl (%rax),%eax
  8015a3:	84 c0                	test   %al,%al
  8015a5:	75 dc                	jne    801583 <walk_path+0xae>
  8015a7:	48 8b 95 48 ff ff ff 	mov    -0xb8(%rbp),%rdx
  8015ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015b2:	48 29 c2             	sub    %rax,%rdx
  8015b5:	48 89 d0             	mov    %rdx,%rax
  8015b8:	48 83 f8 7f          	cmp    $0x7f,%rax
  8015bc:	7e 0a                	jle    8015c8 <walk_path+0xf3>
  8015be:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8015c3:	e9 56 01 00 00       	jmpq   80171e <walk_path+0x249>
  8015c8:	48 8b 95 48 ff ff ff 	mov    -0xb8(%rbp),%rdx
  8015cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015d3:	48 29 c2             	sub    %rax,%rdx
  8015d6:	48 89 d0             	mov    %rdx,%rax
  8015d9:	48 89 c2             	mov    %rax,%rdx
  8015dc:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8015e0:	48 8d 85 60 ff ff ff 	lea    -0xa0(%rbp),%rax
  8015e7:	48 89 ce             	mov    %rcx,%rsi
  8015ea:	48 89 c7             	mov    %rax,%rdi
  8015ed:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  8015f4:	00 00 00 
  8015f7:	ff d0                	callq  *%rax
  8015f9:	48 8b 95 48 ff ff ff 	mov    -0xb8(%rbp),%rdx
  801600:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801604:	48 29 c2             	sub    %rax,%rdx
  801607:	48 89 d0             	mov    %rdx,%rax
  80160a:	c6 84 05 60 ff ff ff 	movb   $0x0,-0xa0(%rbp,%rax,1)
  801611:	00 
  801612:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  801619:	48 89 c7             	mov    %rax,%rdi
  80161c:	48 b8 b1 14 80 00 00 	movabs $0x8014b1,%rax
  801623:	00 00 00 
  801626:	ff d0                	callq  *%rax
  801628:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80162f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801633:	8b 80 84 00 00 00    	mov    0x84(%rax),%eax
  801639:	83 f8 01             	cmp    $0x1,%eax
  80163c:	74 0a                	je     801648 <walk_path+0x173>
  80163e:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  801643:	e9 d6 00 00 00       	jmpq   80171e <walk_path+0x249>
  801648:	48 8d 95 58 ff ff ff 	lea    -0xa8(%rbp),%rdx
  80164f:	48 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%rcx
  801656:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80165a:	48 89 ce             	mov    %rcx,%rsi
  80165d:	48 89 c7             	mov    %rax,%rdi
  801660:	48 b8 1c 12 80 00 00 	movabs $0x80121c,%rax
  801667:	00 00 00 
  80166a:	ff d0                	callq  *%rax
  80166c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80166f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801673:	79 69                	jns    8016de <walk_path+0x209>
  801675:	83 7d ec f4          	cmpl   $0xfffffff4,-0x14(%rbp)
  801679:	75 5e                	jne    8016d9 <walk_path+0x204>
  80167b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  801682:	0f b6 00             	movzbl (%rax),%eax
  801685:	84 c0                	test   %al,%al
  801687:	75 50                	jne    8016d9 <walk_path+0x204>
  801689:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
  801690:	00 
  801691:	74 0e                	je     8016a1 <walk_path+0x1cc>
  801693:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
  80169a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80169e:	48 89 10             	mov    %rdx,(%rax)
  8016a1:	48 83 bd 30 ff ff ff 	cmpq   $0x0,-0xd0(%rbp)
  8016a8:	00 
  8016a9:	74 20                	je     8016cb <walk_path+0x1f6>
  8016ab:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  8016b2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
  8016b9:	48 89 d6             	mov    %rdx,%rsi
  8016bc:	48 89 c7             	mov    %rax,%rdi
  8016bf:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  8016c6:	00 00 00 
  8016c9:	ff d0                	callq  *%rax
  8016cb:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
  8016d2:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8016d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016dc:	eb 40                	jmp    80171e <walk_path+0x249>
  8016de:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  8016e5:	0f b6 00             	movzbl (%rax),%eax
  8016e8:	84 c0                	test   %al,%al
  8016ea:	0f 85 7b fe ff ff    	jne    80156b <walk_path+0x96>
  8016f0:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
  8016f7:	00 
  8016f8:	74 0e                	je     801708 <walk_path+0x233>
  8016fa:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
  801701:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801705:	48 89 10             	mov    %rdx,(%rax)
  801708:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
  80170f:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
  801716:	48 89 10             	mov    %rdx,(%rax)
  801719:	b8 00 00 00 00       	mov    $0x0,%eax
  80171e:	c9                   	leaveq 
  80171f:	c3                   	retq   

0000000000801720 <file_create>:
  801720:	55                   	push   %rbp
  801721:	48 89 e5             	mov    %rsp,%rbp
  801724:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80172b:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
  801732:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
  801739:	48 8d 8d 70 ff ff ff 	lea    -0x90(%rbp),%rcx
  801740:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  801747:	48 8d b5 68 ff ff ff 	lea    -0x98(%rbp),%rsi
  80174e:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  801755:	48 89 c7             	mov    %rax,%rdi
  801758:	48 b8 d5 14 80 00 00 	movabs $0x8014d5,%rax
  80175f:	00 00 00 
  801762:	ff d0                	callq  *%rax
  801764:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801767:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80176b:	75 0a                	jne    801777 <file_create+0x57>
  80176d:	b8 f2 ff ff ff       	mov    $0xfffffff2,%eax
  801772:	e9 91 00 00 00       	jmpq   801808 <file_create+0xe8>
  801777:	83 7d fc f4          	cmpl   $0xfffffff4,-0x4(%rbp)
  80177b:	75 0c                	jne    801789 <file_create+0x69>
  80177d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  801784:	48 85 c0             	test   %rax,%rax
  801787:	75 05                	jne    80178e <file_create+0x6e>
  801789:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80178c:	eb 7a                	jmp    801808 <file_create+0xe8>
  80178e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  801795:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  80179c:	48 89 d6             	mov    %rdx,%rsi
  80179f:	48 89 c7             	mov    %rax,%rdi
  8017a2:	48 b8 45 13 80 00 00 	movabs $0x801345,%rax
  8017a9:	00 00 00 
  8017ac:	ff d0                	callq  *%rax
  8017ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8017b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8017b5:	79 05                	jns    8017bc <file_create+0x9c>
  8017b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8017ba:	eb 4c                	jmp    801808 <file_create+0xe8>
  8017bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8017c3:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
  8017ca:	48 89 d6             	mov    %rdx,%rsi
  8017cd:	48 89 c7             	mov    %rax,%rdi
  8017d0:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  8017d7:	00 00 00 
  8017da:	ff d0                	callq  *%rax
  8017dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  8017e3:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
  8017ea:	48 89 10             	mov    %rdx,(%rax)
  8017ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  8017f4:	48 89 c7             	mov    %rax,%rdi
  8017f7:	48 b8 96 1c 80 00 00 	movabs $0x801c96,%rax
  8017fe:	00 00 00 
  801801:	ff d0                	callq  *%rax
  801803:	b8 00 00 00 00       	mov    $0x0,%eax
  801808:	c9                   	leaveq 
  801809:	c3                   	retq   

000000000080180a <file_open>:
  80180a:	55                   	push   %rbp
  80180b:	48 89 e5             	mov    %rsp,%rbp
  80180e:	48 83 ec 10          	sub    $0x10,%rsp
  801812:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801816:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80181a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80181e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801822:	b9 00 00 00 00       	mov    $0x0,%ecx
  801827:	be 00 00 00 00       	mov    $0x0,%esi
  80182c:	48 89 c7             	mov    %rax,%rdi
  80182f:	48 b8 d5 14 80 00 00 	movabs $0x8014d5,%rax
  801836:	00 00 00 
  801839:	ff d0                	callq  *%rax
  80183b:	c9                   	leaveq 
  80183c:	c3                   	retq   

000000000080183d <file_read>:
  80183d:	55                   	push   %rbp
  80183e:	48 89 e5             	mov    %rsp,%rbp
  801841:	48 83 ec 60          	sub    $0x60,%rsp
  801845:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  801849:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
  80184d:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801851:	89 4d a4             	mov    %ecx,-0x5c(%rbp)
  801854:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  801858:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  80185e:	3b 45 a4             	cmp    -0x5c(%rbp),%eax
  801861:	7f 0a                	jg     80186d <file_read+0x30>
  801863:	b8 00 00 00 00       	mov    $0x0,%eax
  801868:	e9 24 01 00 00       	jmpq   801991 <file_read+0x154>
  80186d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801871:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801875:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  801879:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  80187f:	2b 45 a4             	sub    -0x5c(%rbp),%eax
  801882:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801885:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801888:	48 63 d0             	movslq %eax,%rdx
  80188b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80188f:	48 39 c2             	cmp    %rax,%rdx
  801892:	48 0f 46 c2          	cmovbe %rdx,%rax
  801896:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
  80189a:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  80189d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8018a0:	e9 cd 00 00 00       	jmpq   801972 <file_read+0x135>
  8018a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018a8:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  8018ae:	85 c0                	test   %eax,%eax
  8018b0:	0f 48 c2             	cmovs  %edx,%eax
  8018b3:	c1 f8 0c             	sar    $0xc,%eax
  8018b6:	89 c1                	mov    %eax,%ecx
  8018b8:	48 8d 55 c8          	lea    -0x38(%rbp),%rdx
  8018bc:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  8018c0:	89 ce                	mov    %ecx,%esi
  8018c2:	48 89 c7             	mov    %rax,%rdi
  8018c5:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  8018cc:	00 00 00 
  8018cf:	ff d0                	callq  *%rax
  8018d1:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8018d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8018d8:	79 08                	jns    8018e2 <file_read+0xa5>
  8018da:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8018dd:	e9 af 00 00 00       	jmpq   801991 <file_read+0x154>
  8018e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018e5:	99                   	cltd   
  8018e6:	c1 ea 14             	shr    $0x14,%edx
  8018e9:	01 d0                	add    %edx,%eax
  8018eb:	25 ff 0f 00 00       	and    $0xfff,%eax
  8018f0:	29 d0                	sub    %edx,%eax
  8018f2:	ba 00 10 00 00       	mov    $0x1000,%edx
  8018f7:	29 c2                	sub    %eax,%edx
  8018f9:	89 d0                	mov    %edx,%eax
  8018fb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8018fe:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  801901:	48 63 d0             	movslq %eax,%rdx
  801904:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801908:	48 01 c2             	add    %rax,%rdx
  80190b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80190e:	48 98                	cltq   
  801910:	48 29 c2             	sub    %rax,%rdx
  801913:	48 89 d0             	mov    %rdx,%rax
  801916:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  80191a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80191d:	48 63 d0             	movslq %eax,%rdx
  801920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801924:	48 39 c2             	cmp    %rax,%rdx
  801927:	48 0f 46 c2          	cmovbe %rdx,%rax
  80192b:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  80192e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  801931:	48 63 c8             	movslq %eax,%rcx
  801934:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
  801938:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80193b:	99                   	cltd   
  80193c:	c1 ea 14             	shr    $0x14,%edx
  80193f:	01 d0                	add    %edx,%eax
  801941:	25 ff 0f 00 00       	and    $0xfff,%eax
  801946:	29 d0                	sub    %edx,%eax
  801948:	48 98                	cltq   
  80194a:	48 01 c6             	add    %rax,%rsi
  80194d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  801951:	48 89 ca             	mov    %rcx,%rdx
  801954:	48 89 c7             	mov    %rax,%rdi
  801957:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  80195e:	00 00 00 
  801961:	ff d0                	callq  *%rax
  801963:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  801966:	01 45 fc             	add    %eax,-0x4(%rbp)
  801969:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80196c:	48 98                	cltq   
  80196e:	48 01 45 b0          	add    %rax,-0x50(%rbp)
  801972:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801975:	48 98                	cltq   
  801977:	8b 55 a4             	mov    -0x5c(%rbp),%edx
  80197a:	48 63 ca             	movslq %edx,%rcx
  80197d:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
  801981:	48 01 ca             	add    %rcx,%rdx
  801984:	48 39 d0             	cmp    %rdx,%rax
  801987:	0f 82 18 ff ff ff    	jb     8018a5 <file_read+0x68>
  80198d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801991:	c9                   	leaveq 
  801992:	c3                   	retq   

0000000000801993 <file_write>:
  801993:	55                   	push   %rbp
  801994:	48 89 e5             	mov    %rsp,%rbp
  801997:	48 83 ec 50          	sub    $0x50,%rsp
  80199b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  80199f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  8019a3:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8019a7:	89 4d b4             	mov    %ecx,-0x4c(%rbp)
  8019aa:	8b 45 b4             	mov    -0x4c(%rbp),%eax
  8019ad:	48 63 d0             	movslq %eax,%rdx
  8019b0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  8019b4:	48 01 c2             	add    %rax,%rdx
  8019b7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8019bb:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  8019c1:	48 98                	cltq   
  8019c3:	48 39 c2             	cmp    %rax,%rdx
  8019c6:	76 33                	jbe    8019fb <file_write+0x68>
  8019c8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  8019cc:	89 c2                	mov    %eax,%edx
  8019ce:	8b 45 b4             	mov    -0x4c(%rbp),%eax
  8019d1:	01 d0                	add    %edx,%eax
  8019d3:	89 c2                	mov    %eax,%edx
  8019d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8019d9:	89 d6                	mov    %edx,%esi
  8019db:	48 89 c7             	mov    %rax,%rdi
  8019de:	48 b8 39 1c 80 00 00 	movabs $0x801c39,%rax
  8019e5:	00 00 00 
  8019e8:	ff d0                	callq  *%rax
  8019ea:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8019ed:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8019f1:	79 08                	jns    8019fb <file_write+0x68>
  8019f3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8019f6:	e9 f8 00 00 00       	jmpq   801af3 <file_write+0x160>
  8019fb:	8b 45 b4             	mov    -0x4c(%rbp),%eax
  8019fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801a01:	e9 ce 00 00 00       	jmpq   801ad4 <file_write+0x141>
  801a06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a09:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  801a0f:	85 c0                	test   %eax,%eax
  801a11:	0f 48 c2             	cmovs  %edx,%eax
  801a14:	c1 f8 0c             	sar    $0xc,%eax
  801a17:	89 c1                	mov    %eax,%ecx
  801a19:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  801a1d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801a21:	89 ce                	mov    %ecx,%esi
  801a23:	48 89 c7             	mov    %rax,%rdi
  801a26:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  801a2d:	00 00 00 
  801a30:	ff d0                	callq  *%rax
  801a32:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801a35:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801a39:	79 08                	jns    801a43 <file_write+0xb0>
  801a3b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a3e:	e9 b0 00 00 00       	jmpq   801af3 <file_write+0x160>
  801a43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a46:	99                   	cltd   
  801a47:	c1 ea 14             	shr    $0x14,%edx
  801a4a:	01 d0                	add    %edx,%eax
  801a4c:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a51:	29 d0                	sub    %edx,%eax
  801a53:	ba 00 10 00 00       	mov    $0x1000,%edx
  801a58:	29 c2                	sub    %eax,%edx
  801a5a:	89 d0                	mov    %edx,%eax
  801a5c:	89 45 f4             	mov    %eax,-0xc(%rbp)
  801a5f:	8b 45 b4             	mov    -0x4c(%rbp),%eax
  801a62:	48 63 d0             	movslq %eax,%rdx
  801a65:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  801a69:	48 01 c2             	add    %rax,%rdx
  801a6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a6f:	48 98                	cltq   
  801a71:	48 29 c2             	sub    %rax,%rdx
  801a74:	48 89 d0             	mov    %rdx,%rax
  801a77:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801a7b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801a7e:	48 63 d0             	movslq %eax,%rdx
  801a81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a85:	48 39 c2             	cmp    %rax,%rdx
  801a88:	48 0f 46 c2          	cmovbe %rdx,%rax
  801a8c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  801a8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801a92:	48 63 c8             	movslq %eax,%rcx
  801a95:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
  801a99:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a9c:	99                   	cltd   
  801a9d:	c1 ea 14             	shr    $0x14,%edx
  801aa0:	01 d0                	add    %edx,%eax
  801aa2:	25 ff 0f 00 00       	and    $0xfff,%eax
  801aa7:	29 d0                	sub    %edx,%eax
  801aa9:	48 98                	cltq   
  801aab:	48 8d 3c 06          	lea    (%rsi,%rax,1),%rdi
  801aaf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  801ab3:	48 89 ca             	mov    %rcx,%rdx
  801ab6:	48 89 c6             	mov    %rax,%rsi
  801ab9:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  801ac0:	00 00 00 
  801ac3:	ff d0                	callq  *%rax
  801ac5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801ac8:	01 45 fc             	add    %eax,-0x4(%rbp)
  801acb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801ace:	48 98                	cltq   
  801ad0:	48 01 45 c0          	add    %rax,-0x40(%rbp)
  801ad4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ad7:	48 98                	cltq   
  801ad9:	8b 55 b4             	mov    -0x4c(%rbp),%edx
  801adc:	48 63 ca             	movslq %edx,%rcx
  801adf:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801ae3:	48 01 ca             	add    %rcx,%rdx
  801ae6:	48 39 d0             	cmp    %rdx,%rax
  801ae9:	0f 82 17 ff ff ff    	jb     801a06 <file_write+0x73>
  801aef:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  801af3:	c9                   	leaveq 
  801af4:	c3                   	retq   

0000000000801af5 <file_free_block>:
  801af5:	55                   	push   %rbp
  801af6:	48 89 e5             	mov    %rsp,%rbp
  801af9:	48 83 ec 20          	sub    $0x20,%rsp
  801afd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b01:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801b04:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801b08:	8b 75 e4             	mov    -0x1c(%rbp),%esi
  801b0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b0f:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b14:	48 89 c7             	mov    %rax,%rdi
  801b17:	48 b8 7a 10 80 00 00 	movabs $0x80107a,%rax
  801b1e:	00 00 00 
  801b21:	ff d0                	callq  *%rax
  801b23:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801b26:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801b2a:	79 05                	jns    801b31 <file_free_block+0x3c>
  801b2c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b2f:	eb 2d                	jmp    801b5e <file_free_block+0x69>
  801b31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b35:	8b 00                	mov    (%rax),%eax
  801b37:	85 c0                	test   %eax,%eax
  801b39:	74 1e                	je     801b59 <file_free_block+0x64>
  801b3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b3f:	8b 00                	mov    (%rax),%eax
  801b41:	89 c7                	mov    %eax,%edi
  801b43:	48 b8 22 0d 80 00 00 	movabs $0x800d22,%rax
  801b4a:	00 00 00 
  801b4d:	ff d0                	callq  *%rax
  801b4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b53:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  801b59:	b8 00 00 00 00       	mov    $0x0,%eax
  801b5e:	c9                   	leaveq 
  801b5f:	c3                   	retq   

0000000000801b60 <file_truncate_blocks>:
  801b60:	55                   	push   %rbp
  801b61:	48 89 e5             	mov    %rsp,%rbp
  801b64:	48 83 ec 20          	sub    $0x20,%rsp
  801b68:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b6c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801b6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b73:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  801b79:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b7e:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  801b84:	85 c0                	test   %eax,%eax
  801b86:	0f 48 c2             	cmovs  %edx,%eax
  801b89:	c1 f8 0c             	sar    $0xc,%eax
  801b8c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801b8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801b92:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b97:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  801b9d:	85 c0                	test   %eax,%eax
  801b9f:	0f 48 c2             	cmovs  %edx,%eax
  801ba2:	c1 f8 0c             	sar    $0xc,%eax
  801ba5:	89 45 f4             	mov    %eax,-0xc(%rbp)
  801ba8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801bab:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801bae:	eb 45                	jmp    801bf5 <file_truncate_blocks+0x95>
  801bb0:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801bb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bb7:	89 d6                	mov    %edx,%esi
  801bb9:	48 89 c7             	mov    %rax,%rdi
  801bbc:	48 b8 f5 1a 80 00 00 	movabs $0x801af5,%rax
  801bc3:	00 00 00 
  801bc6:	ff d0                	callq  *%rax
  801bc8:	89 45 f0             	mov    %eax,-0x10(%rbp)
  801bcb:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  801bcf:	79 20                	jns    801bf1 <file_truncate_blocks+0x91>
  801bd1:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801bd4:	89 c6                	mov    %eax,%esi
  801bd6:	48 bf 4b 77 80 00 00 	movabs $0x80774b,%rdi
  801bdd:	00 00 00 
  801be0:	b8 00 00 00 00       	mov    $0x0,%eax
  801be5:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  801bec:	00 00 00 
  801bef:	ff d2                	callq  *%rdx
  801bf1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801bf5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bf8:	3b 45 f8             	cmp    -0x8(%rbp),%eax
  801bfb:	72 b3                	jb     801bb0 <file_truncate_blocks+0x50>
  801bfd:	83 7d f4 0a          	cmpl   $0xa,-0xc(%rbp)
  801c01:	77 34                	ja     801c37 <file_truncate_blocks+0xd7>
  801c03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c07:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  801c0d:	85 c0                	test   %eax,%eax
  801c0f:	74 26                	je     801c37 <file_truncate_blocks+0xd7>
  801c11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c15:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  801c1b:	89 c7                	mov    %eax,%edi
  801c1d:	48 b8 22 0d 80 00 00 	movabs $0x800d22,%rax
  801c24:	00 00 00 
  801c27:	ff d0                	callq  *%rax
  801c29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c2d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%rax)
  801c34:	00 00 00 
  801c37:	c9                   	leaveq 
  801c38:	c3                   	retq   

0000000000801c39 <file_set_size>:
  801c39:	55                   	push   %rbp
  801c3a:	48 89 e5             	mov    %rsp,%rbp
  801c3d:	48 83 ec 10          	sub    $0x10,%rsp
  801c41:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c45:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c4c:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  801c52:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  801c55:	7e 18                	jle    801c6f <file_set_size+0x36>
  801c57:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c5e:	89 d6                	mov    %edx,%esi
  801c60:	48 89 c7             	mov    %rax,%rdi
  801c63:	48 b8 60 1b 80 00 00 	movabs $0x801b60,%rax
  801c6a:	00 00 00 
  801c6d:	ff d0                	callq  *%rax
  801c6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c73:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801c76:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  801c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c80:	48 89 c7             	mov    %rax,%rdi
  801c83:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801c8a:	00 00 00 
  801c8d:	ff d0                	callq  *%rax
  801c8f:	b8 00 00 00 00       	mov    $0x0,%eax
  801c94:	c9                   	leaveq 
  801c95:	c3                   	retq   

0000000000801c96 <file_flush>:
  801c96:	55                   	push   %rbp
  801c97:	48 89 e5             	mov    %rsp,%rbp
  801c9a:	48 83 ec 20          	sub    $0x20,%rsp
  801c9e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801ca2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ca9:	eb 62                	jmp    801d0d <file_flush+0x77>
  801cab:	8b 75 fc             	mov    -0x4(%rbp),%esi
  801cae:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801cb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801cb6:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cbb:	48 89 c7             	mov    %rax,%rdi
  801cbe:	48 b8 7a 10 80 00 00 	movabs $0x80107a,%rax
  801cc5:	00 00 00 
  801cc8:	ff d0                	callq  *%rax
  801cca:	85 c0                	test   %eax,%eax
  801ccc:	78 13                	js     801ce1 <file_flush+0x4b>
  801cce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cd2:	48 85 c0             	test   %rax,%rax
  801cd5:	74 0a                	je     801ce1 <file_flush+0x4b>
  801cd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cdb:	8b 00                	mov    (%rax),%eax
  801cdd:	85 c0                	test   %eax,%eax
  801cdf:	75 02                	jne    801ce3 <file_flush+0x4d>
  801ce1:	eb 26                	jmp    801d09 <file_flush+0x73>
  801ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ce7:	8b 00                	mov    (%rax),%eax
  801ce9:	89 c0                	mov    %eax,%eax
  801ceb:	48 89 c7             	mov    %rax,%rdi
  801cee:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801cf5:	00 00 00 
  801cf8:	ff d0                	callq  *%rax
  801cfa:	48 89 c7             	mov    %rax,%rdi
  801cfd:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801d04:	00 00 00 
  801d07:	ff d0                	callq  *%rax
  801d09:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801d0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d11:	8b 80 80 00 00 00    	mov    0x80(%rax),%eax
  801d17:	05 ff 0f 00 00       	add    $0xfff,%eax
  801d1c:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
  801d22:	85 c0                	test   %eax,%eax
  801d24:	0f 48 c2             	cmovs  %edx,%eax
  801d27:	c1 f8 0c             	sar    $0xc,%eax
  801d2a:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  801d2d:	0f 8f 78 ff ff ff    	jg     801cab <file_flush+0x15>
  801d33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d37:	48 89 c7             	mov    %rax,%rdi
  801d3a:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801d41:	00 00 00 
  801d44:	ff d0                	callq  *%rax
  801d46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d4a:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  801d50:	85 c0                	test   %eax,%eax
  801d52:	74 2a                	je     801d7e <file_flush+0xe8>
  801d54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d58:	8b 80 b0 00 00 00    	mov    0xb0(%rax),%eax
  801d5e:	89 c0                	mov    %eax,%eax
  801d60:	48 89 c7             	mov    %rax,%rdi
  801d63:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801d6a:	00 00 00 
  801d6d:	ff d0                	callq  *%rax
  801d6f:	48 89 c7             	mov    %rax,%rdi
  801d72:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801d79:	00 00 00 
  801d7c:	ff d0                	callq  *%rax
  801d7e:	c9                   	leaveq 
  801d7f:	c3                   	retq   

0000000000801d80 <file_remove>:
  801d80:	55                   	push   %rbp
  801d81:	48 89 e5             	mov    %rsp,%rbp
  801d84:	48 83 ec 20          	sub    $0x20,%rsp
  801d88:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801d8c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801d90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d94:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d99:	be 00 00 00 00       	mov    $0x0,%esi
  801d9e:	48 89 c7             	mov    %rax,%rdi
  801da1:	48 b8 d5 14 80 00 00 	movabs $0x8014d5,%rax
  801da8:	00 00 00 
  801dab:	ff d0                	callq  *%rax
  801dad:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801db0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801db4:	79 05                	jns    801dbb <file_remove+0x3b>
  801db6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801db9:	eb 45                	jmp    801e00 <file_remove+0x80>
  801dbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801dbf:	be 00 00 00 00       	mov    $0x0,%esi
  801dc4:	48 89 c7             	mov    %rax,%rdi
  801dc7:	48 b8 60 1b 80 00 00 	movabs $0x801b60,%rax
  801dce:	00 00 00 
  801dd1:	ff d0                	callq  *%rax
  801dd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801dd7:	c6 00 00             	movb   $0x0,(%rax)
  801dda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801dde:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  801de5:	00 00 00 
  801de8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801dec:	48 89 c7             	mov    %rax,%rdi
  801def:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801df6:	00 00 00 
  801df9:	ff d0                	callq  *%rax
  801dfb:	b8 00 00 00 00       	mov    $0x0,%eax
  801e00:	c9                   	leaveq 
  801e01:	c3                   	retq   

0000000000801e02 <fs_sync>:
  801e02:	55                   	push   %rbp
  801e03:	48 89 e5             	mov    %rsp,%rbp
  801e06:	48 83 ec 10          	sub    $0x10,%rsp
  801e0a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801e11:	eb 27                	jmp    801e3a <fs_sync+0x38>
  801e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e16:	48 98                	cltq   
  801e18:	48 89 c7             	mov    %rax,%rdi
  801e1b:	48 b8 a3 04 80 00 00 	movabs $0x8004a3,%rax
  801e22:	00 00 00 
  801e25:	ff d0                	callq  *%rax
  801e27:	48 89 c7             	mov    %rax,%rdi
  801e2a:	48 b8 20 08 80 00 00 	movabs $0x800820,%rax
  801e31:	00 00 00 
  801e34:	ff d0                	callq  *%rax
  801e36:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801e3a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801e3d:	48 b8 18 60 81 00 00 	movabs $0x816018,%rax
  801e44:	00 00 00 
  801e47:	48 8b 00             	mov    (%rax),%rax
  801e4a:	8b 40 04             	mov    0x4(%rax),%eax
  801e4d:	39 c2                	cmp    %eax,%edx
  801e4f:	72 c2                	jb     801e13 <fs_sync+0x11>
  801e51:	c9                   	leaveq 
  801e52:	c3                   	retq   

0000000000801e53 <serve_init>:
  801e53:	55                   	push   %rbp
  801e54:	48 89 e5             	mov    %rsp,%rbp
  801e57:	48 83 ec 10          	sub    $0x10,%rsp
  801e5b:	b8 00 00 00 d0       	mov    $0xd0000000,%eax
  801e60:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801e64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801e6b:	eb 4b                	jmp    801eb8 <serve_init+0x65>
  801e6d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e70:	48 ba 20 a0 80 00 00 	movabs $0x80a020,%rdx
  801e77:	00 00 00 
  801e7a:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  801e7d:	48 63 c9             	movslq %ecx,%rcx
  801e80:	48 c1 e1 05          	shl    $0x5,%rcx
  801e84:	48 01 ca             	add    %rcx,%rdx
  801e87:	89 02                	mov    %eax,(%rdx)
  801e89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e8d:	48 ba 20 a0 80 00 00 	movabs $0x80a020,%rdx
  801e94:	00 00 00 
  801e97:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  801e9a:	48 63 c9             	movslq %ecx,%rcx
  801e9d:	48 c1 e1 05          	shl    $0x5,%rcx
  801ea1:	48 01 ca             	add    %rcx,%rdx
  801ea4:	48 83 c2 10          	add    $0x10,%rdx
  801ea8:	48 89 42 08          	mov    %rax,0x8(%rdx)
  801eac:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
  801eb3:	00 
  801eb4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801eb8:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  801ebf:	7e ac                	jle    801e6d <serve_init+0x1a>
  801ec1:	c9                   	leaveq 
  801ec2:	c3                   	retq   

0000000000801ec3 <openfile_alloc>:
  801ec3:	55                   	push   %rbp
  801ec4:	48 89 e5             	mov    %rsp,%rbp
  801ec7:	53                   	push   %rbx
  801ec8:	48 83 ec 28          	sub    $0x28,%rsp
  801ecc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801ed0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801ed7:	e9 02 02 00 00       	jmpq   8020de <openfile_alloc+0x21b>
  801edc:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801ee3:	00 00 00 
  801ee6:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801ee9:	48 63 d2             	movslq %edx,%rdx
  801eec:	48 c1 e2 05          	shl    $0x5,%rdx
  801ef0:	48 01 d0             	add    %rdx,%rax
  801ef3:	48 83 c0 10          	add    $0x10,%rax
  801ef7:	48 8b 40 08          	mov    0x8(%rax),%rax
  801efb:	48 89 c7             	mov    %rax,%rdi
  801efe:	48 b8 40 63 80 00 00 	movabs $0x806340,%rax
  801f05:	00 00 00 
  801f08:	ff d0                	callq  *%rax
  801f0a:	85 c0                	test   %eax,%eax
  801f0c:	74 0e                	je     801f1c <openfile_alloc+0x59>
  801f0e:	83 f8 01             	cmp    $0x1,%eax
  801f11:	0f 84 ec 00 00 00    	je     802003 <openfile_alloc+0x140>
  801f17:	e9 be 01 00 00       	jmpq   8020da <openfile_alloc+0x217>
  801f1c:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801f23:	00 00 00 
  801f26:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801f29:	48 63 d2             	movslq %edx,%rdx
  801f2c:	48 c1 e2 05          	shl    $0x5,%rdx
  801f30:	48 01 d0             	add    %rdx,%rax
  801f33:	48 83 c0 10          	add    $0x10,%rax
  801f37:	48 8b 40 08          	mov    0x8(%rax),%rax
  801f3b:	ba 07 00 00 00       	mov    $0x7,%edx
  801f40:	48 89 c6             	mov    %rax,%rsi
  801f43:	bf 00 00 00 00       	mov    $0x0,%edi
  801f48:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  801f4f:	00 00 00 
  801f52:	ff d0                	callq  *%rax
  801f54:	89 45 e8             	mov    %eax,-0x18(%rbp)
  801f57:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  801f5b:	79 08                	jns    801f65 <openfile_alloc+0xa2>
  801f5d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  801f60:	e9 8b 01 00 00       	jmpq   8020f0 <openfile_alloc+0x22d>
  801f65:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801f6c:	00 00 00 
  801f6f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801f72:	48 63 d2             	movslq %edx,%rdx
  801f75:	48 c1 e2 05          	shl    $0x5,%rdx
  801f79:	48 01 d0             	add    %rdx,%rax
  801f7c:	8b 00                	mov    (%rax),%eax
  801f7e:	8d 90 00 04 00 00    	lea    0x400(%rax),%edx
  801f84:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801f8b:	00 00 00 
  801f8e:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  801f91:	48 63 c9             	movslq %ecx,%rcx
  801f94:	48 c1 e1 05          	shl    $0x5,%rcx
  801f98:	48 01 c8             	add    %rcx,%rax
  801f9b:	89 10                	mov    %edx,(%rax)
  801f9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801fa0:	48 98                	cltq   
  801fa2:	48 c1 e0 05          	shl    $0x5,%rax
  801fa6:	48 89 c2             	mov    %rax,%rdx
  801fa9:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801fb0:	00 00 00 
  801fb3:	48 01 c2             	add    %rax,%rdx
  801fb6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fba:	48 89 10             	mov    %rdx,(%rax)
  801fbd:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  801fc4:	00 00 00 
  801fc7:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801fca:	48 63 d2             	movslq %edx,%rdx
  801fcd:	48 c1 e2 05          	shl    $0x5,%rdx
  801fd1:	48 01 d0             	add    %rdx,%rax
  801fd4:	48 83 c0 10          	add    $0x10,%rax
  801fd8:	48 8b 40 08          	mov    0x8(%rax),%rax
  801fdc:	ba 00 10 00 00       	mov    $0x1000,%edx
  801fe1:	be 00 00 00 00       	mov    $0x0,%esi
  801fe6:	48 89 c7             	mov    %rax,%rdi
  801fe9:	48 b8 39 45 80 00 00 	movabs $0x804539,%rax
  801ff0:	00 00 00 
  801ff3:	ff d0                	callq  *%rax
  801ff5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ff9:	48 8b 00             	mov    (%rax),%rax
  801ffc:	8b 00                	mov    (%rax),%eax
  801ffe:	e9 ed 00 00 00       	jmpq   8020f0 <openfile_alloc+0x22d>
  802003:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  80200a:	00 00 00 
  80200d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802010:	48 63 d2             	movslq %edx,%rdx
  802013:	48 c1 e2 05          	shl    $0x5,%rdx
  802017:	48 01 d0             	add    %rdx,%rax
  80201a:	48 83 c0 10          	add    $0x10,%rax
  80201e:	48 8b 40 08          	mov    0x8(%rax),%rax
  802022:	48 89 c3             	mov    %rax,%rbx
  802025:	b8 00 00 00 00       	mov    $0x0,%eax
  80202a:	48 ba db 30 80 00 00 	movabs $0x8030db,%rdx
  802031:	00 00 00 
  802034:	ff d2                	callq  *%rdx
  802036:	48 39 c3             	cmp    %rax,%rbx
  802039:	0f 84 9b 00 00 00    	je     8020da <openfile_alloc+0x217>
  80203f:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  802046:	00 00 00 
  802049:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80204c:	48 63 d2             	movslq %edx,%rdx
  80204f:	48 c1 e2 05          	shl    $0x5,%rdx
  802053:	48 01 d0             	add    %rdx,%rax
  802056:	8b 00                	mov    (%rax),%eax
  802058:	8d 90 00 04 00 00    	lea    0x400(%rax),%edx
  80205e:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  802065:	00 00 00 
  802068:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  80206b:	48 63 c9             	movslq %ecx,%rcx
  80206e:	48 c1 e1 05          	shl    $0x5,%rcx
  802072:	48 01 c8             	add    %rcx,%rax
  802075:	89 10                	mov    %edx,(%rax)
  802077:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80207a:	48 98                	cltq   
  80207c:	48 c1 e0 05          	shl    $0x5,%rax
  802080:	48 89 c2             	mov    %rax,%rdx
  802083:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  80208a:	00 00 00 
  80208d:	48 01 c2             	add    %rax,%rdx
  802090:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802094:	48 89 10             	mov    %rdx,(%rax)
  802097:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  80209e:	00 00 00 
  8020a1:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8020a4:	48 63 d2             	movslq %edx,%rdx
  8020a7:	48 c1 e2 05          	shl    $0x5,%rdx
  8020ab:	48 01 d0             	add    %rdx,%rax
  8020ae:	48 83 c0 10          	add    $0x10,%rax
  8020b2:	48 8b 40 08          	mov    0x8(%rax),%rax
  8020b6:	ba 00 10 00 00       	mov    $0x1000,%edx
  8020bb:	be 00 00 00 00       	mov    $0x0,%esi
  8020c0:	48 89 c7             	mov    %rax,%rdi
  8020c3:	48 b8 39 45 80 00 00 	movabs $0x804539,%rax
  8020ca:	00 00 00 
  8020cd:	ff d0                	callq  *%rax
  8020cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020d3:	48 8b 00             	mov    (%rax),%rax
  8020d6:	8b 00                	mov    (%rax),%eax
  8020d8:	eb 16                	jmp    8020f0 <openfile_alloc+0x22d>
  8020da:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  8020de:	81 7d ec ff 03 00 00 	cmpl   $0x3ff,-0x14(%rbp)
  8020e5:	0f 8e f1 fd ff ff    	jle    801edc <openfile_alloc+0x19>
  8020eb:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8020f0:	48 83 c4 28          	add    $0x28,%rsp
  8020f4:	5b                   	pop    %rbx
  8020f5:	5d                   	pop    %rbp
  8020f6:	c3                   	retq   

00000000008020f7 <openfile_lookup>:
  8020f7:	55                   	push   %rbp
  8020f8:	48 89 e5             	mov    %rsp,%rbp
  8020fb:	48 83 ec 20          	sub    $0x20,%rsp
  8020ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802102:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802105:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802109:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80210c:	25 ff 03 00 00       	and    $0x3ff,%eax
  802111:	89 c0                	mov    %eax,%eax
  802113:	48 c1 e0 05          	shl    $0x5,%rax
  802117:	48 89 c2             	mov    %rax,%rdx
  80211a:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  802121:	00 00 00 
  802124:	48 01 d0             	add    %rdx,%rax
  802127:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80212b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80212f:	48 8b 40 18          	mov    0x18(%rax),%rax
  802133:	48 89 c7             	mov    %rax,%rdi
  802136:	48 b8 40 63 80 00 00 	movabs $0x806340,%rax
  80213d:	00 00 00 
  802140:	ff d0                	callq  *%rax
  802142:	83 f8 01             	cmp    $0x1,%eax
  802145:	74 0b                	je     802152 <openfile_lookup+0x5b>
  802147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80214b:	8b 00                	mov    (%rax),%eax
  80214d:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  802150:	74 07                	je     802159 <openfile_lookup+0x62>
  802152:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802157:	eb 10                	jmp    802169 <openfile_lookup+0x72>
  802159:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80215d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802161:	48 89 10             	mov    %rdx,(%rax)
  802164:	b8 00 00 00 00       	mov    $0x0,%eax
  802169:	c9                   	leaveq 
  80216a:	c3                   	retq   

000000000080216b <serve_open>:
  80216b:	55                   	push   %rbp
  80216c:	48 89 e5             	mov    %rsp,%rbp
  80216f:	48 81 ec 40 04 00 00 	sub    $0x440,%rsp
  802176:	89 bd dc fb ff ff    	mov    %edi,-0x424(%rbp)
  80217c:	48 89 b5 d0 fb ff ff 	mov    %rsi,-0x430(%rbp)
  802183:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
  80218a:	48 89 8d c0 fb ff ff 	mov    %rcx,-0x440(%rbp)
  802191:	48 8b 8d d0 fb ff ff 	mov    -0x430(%rbp),%rcx
  802198:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  80219f:	ba 00 04 00 00       	mov    $0x400,%edx
  8021a4:	48 89 ce             	mov    %rcx,%rsi
  8021a7:	48 89 c7             	mov    %rax,%rdi
  8021aa:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  8021b1:	00 00 00 
  8021b4:	ff d0                	callq  *%rax
  8021b6:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  8021ba:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  8021c1:	48 89 c7             	mov    %rax,%rdi
  8021c4:	48 b8 c3 1e 80 00 00 	movabs $0x801ec3,%rax
  8021cb:	00 00 00 
  8021ce:	ff d0                	callq  *%rax
  8021d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021d7:	79 08                	jns    8021e1 <serve_open+0x76>
  8021d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021dc:	e9 7c 01 00 00       	jmpq   80235d <serve_open+0x1f2>
  8021e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021e4:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8021e7:	48 8b 85 d0 fb ff ff 	mov    -0x430(%rbp),%rax
  8021ee:	8b 80 00 04 00 00    	mov    0x400(%rax),%eax
  8021f4:	25 00 01 00 00       	and    $0x100,%eax
  8021f9:	85 c0                	test   %eax,%eax
  8021fb:	74 4f                	je     80224c <serve_open+0xe1>
  8021fd:	48 8d 95 e8 fb ff ff 	lea    -0x418(%rbp),%rdx
  802204:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  80220b:	48 89 d6             	mov    %rdx,%rsi
  80220e:	48 89 c7             	mov    %rax,%rdi
  802211:	48 b8 20 17 80 00 00 	movabs $0x801720,%rax
  802218:	00 00 00 
  80221b:	ff d0                	callq  *%rax
  80221d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802220:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802224:	79 57                	jns    80227d <serve_open+0x112>
  802226:	48 8b 85 d0 fb ff ff 	mov    -0x430(%rbp),%rax
  80222d:	8b 80 00 04 00 00    	mov    0x400(%rax),%eax
  802233:	25 00 04 00 00       	and    $0x400,%eax
  802238:	85 c0                	test   %eax,%eax
  80223a:	75 08                	jne    802244 <serve_open+0xd9>
  80223c:	83 7d fc f2          	cmpl   $0xfffffff2,-0x4(%rbp)
  802240:	75 02                	jne    802244 <serve_open+0xd9>
  802242:	eb 08                	jmp    80224c <serve_open+0xe1>
  802244:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802247:	e9 11 01 00 00       	jmpq   80235d <serve_open+0x1f2>
  80224c:	48 8d 95 e8 fb ff ff 	lea    -0x418(%rbp),%rdx
  802253:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  80225a:	48 89 d6             	mov    %rdx,%rsi
  80225d:	48 89 c7             	mov    %rax,%rdi
  802260:	48 b8 0a 18 80 00 00 	movabs $0x80180a,%rax
  802267:	00 00 00 
  80226a:	ff d0                	callq  *%rax
  80226c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80226f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802273:	79 08                	jns    80227d <serve_open+0x112>
  802275:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802278:	e9 e0 00 00 00       	jmpq   80235d <serve_open+0x1f2>
  80227d:	48 8b 85 d0 fb ff ff 	mov    -0x430(%rbp),%rax
  802284:	8b 80 00 04 00 00    	mov    0x400(%rax),%eax
  80228a:	25 00 02 00 00       	and    $0x200,%eax
  80228f:	85 c0                	test   %eax,%eax
  802291:	74 2c                	je     8022bf <serve_open+0x154>
  802293:	48 8b 85 e8 fb ff ff 	mov    -0x418(%rbp),%rax
  80229a:	be 00 00 00 00       	mov    $0x0,%esi
  80229f:	48 89 c7             	mov    %rax,%rdi
  8022a2:	48 b8 39 1c 80 00 00 	movabs $0x801c39,%rax
  8022a9:	00 00 00 
  8022ac:	ff d0                	callq  *%rax
  8022ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022b5:	79 08                	jns    8022bf <serve_open+0x154>
  8022b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022ba:	e9 9e 00 00 00       	jmpq   80235d <serve_open+0x1f2>
  8022bf:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  8022c6:	48 8b 95 e8 fb ff ff 	mov    -0x418(%rbp),%rdx
  8022cd:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8022d1:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  8022d8:	48 8b 40 18          	mov    0x18(%rax),%rax
  8022dc:	48 8b 95 e0 fb ff ff 	mov    -0x420(%rbp),%rdx
  8022e3:	8b 12                	mov    (%rdx),%edx
  8022e5:	89 50 0c             	mov    %edx,0xc(%rax)
  8022e8:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  8022ef:	48 8b 40 18          	mov    0x18(%rax),%rax
  8022f3:	48 8b 95 d0 fb ff ff 	mov    -0x430(%rbp),%rdx
  8022fa:	8b 92 00 04 00 00    	mov    0x400(%rdx),%edx
  802300:	83 e2 03             	and    $0x3,%edx
  802303:	89 50 08             	mov    %edx,0x8(%rax)
  802306:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  80230d:	48 8b 40 18          	mov    0x18(%rax),%rax
  802311:	48 ba e0 20 81 00 00 	movabs $0x8120e0,%rdx
  802318:	00 00 00 
  80231b:	8b 12                	mov    (%rdx),%edx
  80231d:	89 10                	mov    %edx,(%rax)
  80231f:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  802326:	48 8b 95 d0 fb ff ff 	mov    -0x430(%rbp),%rdx
  80232d:	8b 92 00 04 00 00    	mov    0x400(%rdx),%edx
  802333:	89 50 10             	mov    %edx,0x10(%rax)
  802336:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  80233d:	48 8b 50 18          	mov    0x18(%rax),%rdx
  802341:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  802348:	48 89 10             	mov    %rdx,(%rax)
  80234b:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  802352:	c7 00 07 04 00 00    	movl   $0x407,(%rax)
  802358:	b8 00 00 00 00       	mov    $0x0,%eax
  80235d:	c9                   	leaveq 
  80235e:	c3                   	retq   

000000000080235f <serve_set_size>:
  80235f:	55                   	push   %rbp
  802360:	48 89 e5             	mov    %rsp,%rbp
  802363:	48 83 ec 20          	sub    $0x20,%rsp
  802367:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80236a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80236e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802372:	8b 00                	mov    (%rax),%eax
  802374:	89 c1                	mov    %eax,%ecx
  802376:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80237a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80237d:	89 ce                	mov    %ecx,%esi
  80237f:	89 c7                	mov    %eax,%edi
  802381:	48 b8 f7 20 80 00 00 	movabs $0x8020f7,%rax
  802388:	00 00 00 
  80238b:	ff d0                	callq  *%rax
  80238d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802390:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802394:	79 05                	jns    80239b <serve_set_size+0x3c>
  802396:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802399:	eb 20                	jmp    8023bb <serve_set_size+0x5c>
  80239b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80239f:	8b 50 04             	mov    0x4(%rax),%edx
  8023a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023a6:	48 8b 40 08          	mov    0x8(%rax),%rax
  8023aa:	89 d6                	mov    %edx,%esi
  8023ac:	48 89 c7             	mov    %rax,%rdi
  8023af:	48 b8 39 1c 80 00 00 	movabs $0x801c39,%rax
  8023b6:	00 00 00 
  8023b9:	ff d0                	callq  *%rax
  8023bb:	c9                   	leaveq 
  8023bc:	c3                   	retq   

00000000008023bd <serve_read>:
  8023bd:	55                   	push   %rbp
  8023be:	48 89 e5             	mov    %rsp,%rbp
  8023c1:	48 83 ec 40          	sub    $0x40,%rsp
  8023c5:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8023c8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  8023cc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8023d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8023d4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8023d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8023dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023e0:	8b 00                	mov    (%rax),%eax
  8023e2:	89 c1                	mov    %eax,%ecx
  8023e4:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
  8023e8:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8023eb:	89 ce                	mov    %ecx,%esi
  8023ed:	89 c7                	mov    %eax,%edi
  8023ef:	48 b8 f7 20 80 00 00 	movabs $0x8020f7,%rax
  8023f6:	00 00 00 
  8023f9:	ff d0                	callq  *%rax
  8023fb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8023fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802402:	79 05                	jns    802409 <serve_read+0x4c>
  802404:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802407:	eb 76                	jmp    80247f <serve_read+0xc2>
  802409:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80240d:	48 8b 40 18          	mov    0x18(%rax),%rax
  802411:	8b 48 04             	mov    0x4(%rax),%ecx
  802414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802418:	48 8b 40 08          	mov    0x8(%rax),%rax
  80241c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802420:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
  802427:	00 
  802428:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80242c:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
  802430:	48 0f 46 45 e0       	cmovbe -0x20(%rbp),%rax
  802435:	48 89 c2             	mov    %rax,%rdx
  802438:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80243c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802440:	48 8b 40 08          	mov    0x8(%rax),%rax
  802444:	48 89 c7             	mov    %rax,%rdi
  802447:	48 b8 3d 18 80 00 00 	movabs $0x80183d,%rax
  80244e:	00 00 00 
  802451:	ff d0                	callq  *%rax
  802453:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802456:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80245a:	79 05                	jns    802461 <serve_read+0xa4>
  80245c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80245f:	eb 1e                	jmp    80247f <serve_read+0xc2>
  802461:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802465:	48 8b 40 18          	mov    0x18(%rax),%rax
  802469:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80246d:	48 8b 52 18          	mov    0x18(%rdx),%rdx
  802471:	8b 4a 04             	mov    0x4(%rdx),%ecx
  802474:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802477:	01 ca                	add    %ecx,%edx
  802479:	89 50 04             	mov    %edx,0x4(%rax)
  80247c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80247f:	c9                   	leaveq 
  802480:	c3                   	retq   

0000000000802481 <serve_write>:
  802481:	55                   	push   %rbp
  802482:	48 89 e5             	mov    %rsp,%rbp
  802485:	48 83 ec 20          	sub    $0x20,%rsp
  802489:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80248c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802490:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802494:	8b 00                	mov    (%rax),%eax
  802496:	89 c1                	mov    %eax,%ecx
  802498:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80249c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80249f:	89 ce                	mov    %ecx,%esi
  8024a1:	89 c7                	mov    %eax,%edi
  8024a3:	48 b8 f7 20 80 00 00 	movabs $0x8020f7,%rax
  8024aa:	00 00 00 
  8024ad:	ff d0                	callq  *%rax
  8024af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8024b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8024b6:	79 05                	jns    8024bd <serve_write+0x3c>
  8024b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024bb:	eb 75                	jmp    802532 <serve_write+0xb1>
  8024bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8024c1:	48 8b 40 08          	mov    0x8(%rax),%rax
  8024c5:	48 3d f4 0f 00 00    	cmp    $0xff4,%rax
  8024cb:	76 07                	jbe    8024d4 <serve_write+0x53>
  8024cd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024d2:	eb 5e                	jmp    802532 <serve_write+0xb1>
  8024d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024d8:	48 8b 40 18          	mov    0x18(%rax),%rax
  8024dc:	8b 48 04             	mov    0x4(%rax),%ecx
  8024df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8024e3:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8024e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8024eb:	48 8d 70 10          	lea    0x10(%rax),%rsi
  8024ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  8024f7:	48 89 c7             	mov    %rax,%rdi
  8024fa:	48 b8 93 19 80 00 00 	movabs $0x801993,%rax
  802501:	00 00 00 
  802504:	ff d0                	callq  *%rax
  802506:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802509:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80250d:	79 05                	jns    802514 <serve_write+0x93>
  80250f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802512:	eb 1e                	jmp    802532 <serve_write+0xb1>
  802514:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802518:	48 8b 40 18          	mov    0x18(%rax),%rax
  80251c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802520:	48 8b 52 18          	mov    0x18(%rdx),%rdx
  802524:	8b 4a 04             	mov    0x4(%rdx),%ecx
  802527:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80252a:	01 ca                	add    %ecx,%edx
  80252c:	89 50 04             	mov    %edx,0x4(%rax)
  80252f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802532:	c9                   	leaveq 
  802533:	c3                   	retq   

0000000000802534 <serve_stat>:
  802534:	55                   	push   %rbp
  802535:	48 89 e5             	mov    %rsp,%rbp
  802538:	48 83 ec 30          	sub    $0x30,%rsp
  80253c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80253f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802543:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802547:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80254b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80254f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802557:	8b 00                	mov    (%rax),%eax
  802559:	89 c1                	mov    %eax,%ecx
  80255b:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  80255f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802562:	89 ce                	mov    %ecx,%esi
  802564:	89 c7                	mov    %eax,%edi
  802566:	48 b8 f7 20 80 00 00 	movabs $0x8020f7,%rax
  80256d:	00 00 00 
  802570:	ff d0                	callq  *%rax
  802572:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802575:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802579:	79 05                	jns    802580 <serve_stat+0x4c>
  80257b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80257e:	eb 5f                	jmp    8025df <serve_stat+0xab>
  802580:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802584:	48 8b 40 08          	mov    0x8(%rax),%rax
  802588:	48 89 c2             	mov    %rax,%rdx
  80258b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80258f:	48 89 d6             	mov    %rdx,%rsi
  802592:	48 89 c7             	mov    %rax,%rdi
  802595:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  80259c:	00 00 00 
  80259f:	ff d0                	callq  *%rax
  8025a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8025a5:	48 8b 40 08          	mov    0x8(%rax),%rax
  8025a9:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8025af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025b3:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8025b9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8025bd:	48 8b 40 08          	mov    0x8(%rax),%rax
  8025c1:	8b 80 84 00 00 00    	mov    0x84(%rax),%eax
  8025c7:	83 f8 01             	cmp    $0x1,%eax
  8025ca:	0f 94 c0             	sete   %al
  8025cd:	0f b6 d0             	movzbl %al,%edx
  8025d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025d4:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  8025da:	b8 00 00 00 00       	mov    $0x0,%eax
  8025df:	c9                   	leaveq 
  8025e0:	c3                   	retq   

00000000008025e1 <serve_flush>:
  8025e1:	55                   	push   %rbp
  8025e2:	48 89 e5             	mov    %rsp,%rbp
  8025e5:	48 83 ec 20          	sub    $0x20,%rsp
  8025e9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8025ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8025f4:	8b 00                	mov    (%rax),%eax
  8025f6:	89 c1                	mov    %eax,%ecx
  8025f8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8025fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8025ff:	89 ce                	mov    %ecx,%esi
  802601:	89 c7                	mov    %eax,%edi
  802603:	48 b8 f7 20 80 00 00 	movabs $0x8020f7,%rax
  80260a:	00 00 00 
  80260d:	ff d0                	callq  *%rax
  80260f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802612:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802616:	79 05                	jns    80261d <serve_flush+0x3c>
  802618:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80261b:	eb 1c                	jmp    802639 <serve_flush+0x58>
  80261d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802621:	48 8b 40 08          	mov    0x8(%rax),%rax
  802625:	48 89 c7             	mov    %rax,%rdi
  802628:	48 b8 96 1c 80 00 00 	movabs $0x801c96,%rax
  80262f:	00 00 00 
  802632:	ff d0                	callq  *%rax
  802634:	b8 00 00 00 00       	mov    $0x0,%eax
  802639:	c9                   	leaveq 
  80263a:	c3                   	retq   

000000000080263b <serve_remove>:
  80263b:	55                   	push   %rbp
  80263c:	48 89 e5             	mov    %rsp,%rbp
  80263f:	48 81 ec 10 04 00 00 	sub    $0x410,%rsp
  802646:	89 bd fc fb ff ff    	mov    %edi,-0x404(%rbp)
  80264c:	48 89 b5 f0 fb ff ff 	mov    %rsi,-0x410(%rbp)
  802653:	48 8b 8d f0 fb ff ff 	mov    -0x410(%rbp),%rcx
  80265a:	48 8d 85 00 fc ff ff 	lea    -0x400(%rbp),%rax
  802661:	ba 00 04 00 00       	mov    $0x400,%edx
  802666:	48 89 ce             	mov    %rcx,%rsi
  802669:	48 89 c7             	mov    %rax,%rdi
  80266c:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  802673:	00 00 00 
  802676:	ff d0                	callq  *%rax
  802678:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
  80267c:	48 8d 85 00 fc ff ff 	lea    -0x400(%rbp),%rax
  802683:	48 89 c7             	mov    %rax,%rdi
  802686:	48 b8 80 1d 80 00 00 	movabs $0x801d80,%rax
  80268d:	00 00 00 
  802690:	ff d0                	callq  *%rax
  802692:	c9                   	leaveq 
  802693:	c3                   	retq   

0000000000802694 <serve_sync>:
  802694:	55                   	push   %rbp
  802695:	48 89 e5             	mov    %rsp,%rbp
  802698:	48 83 ec 10          	sub    $0x10,%rsp
  80269c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80269f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8026a3:	48 b8 02 1e 80 00 00 	movabs $0x801e02,%rax
  8026aa:	00 00 00 
  8026ad:	ff d0                	callq  *%rax
  8026af:	b8 00 00 00 00       	mov    $0x0,%eax
  8026b4:	c9                   	leaveq 
  8026b5:	c3                   	retq   

00000000008026b6 <serve>:
  8026b6:	55                   	push   %rbp
  8026b7:	48 89 e5             	mov    %rsp,%rbp
  8026ba:	48 83 ec 20          	sub    $0x20,%rsp
  8026be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  8026c5:	48 b8 20 20 81 00 00 	movabs $0x812020,%rax
  8026cc:	00 00 00 
  8026cf:	48 8b 08             	mov    (%rax),%rcx
  8026d2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8026d6:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
  8026da:	48 89 ce             	mov    %rcx,%rsi
  8026dd:	48 89 c7             	mov    %rax,%rdi
  8026e0:	48 b8 d7 50 80 00 00 	movabs $0x8050d7,%rax
  8026e7:	00 00 00 
  8026ea:	ff d0                	callq  *%rax
  8026ec:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8026ef:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8026f2:	83 e0 01             	and    $0x1,%eax
  8026f5:	85 c0                	test   %eax,%eax
  8026f7:	75 23                	jne    80271c <serve+0x66>
  8026f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8026fc:	89 c6                	mov    %eax,%esi
  8026fe:	48 bf 68 77 80 00 00 	movabs $0x807768,%rdi
  802705:	00 00 00 
  802708:	b8 00 00 00 00       	mov    $0x0,%eax
  80270d:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802714:	00 00 00 
  802717:	ff d2                	callq  *%rdx
  802719:	90                   	nop
  80271a:	eb a2                	jmp    8026be <serve+0x8>
  80271c:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  802723:	00 
  802724:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
  802728:	75 2b                	jne    802755 <serve+0x9f>
  80272a:	48 b8 20 20 81 00 00 	movabs $0x812020,%rax
  802731:	00 00 00 
  802734:	48 8b 30             	mov    (%rax),%rsi
  802737:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80273a:	48 8d 4d f0          	lea    -0x10(%rbp),%rcx
  80273e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802742:	89 c7                	mov    %eax,%edi
  802744:	48 b8 6b 21 80 00 00 	movabs $0x80216b,%rax
  80274b:	00 00 00 
  80274e:	ff d0                	callq  *%rax
  802750:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802753:	eb 73                	jmp    8027c8 <serve+0x112>
  802755:	83 7d f8 08          	cmpl   $0x8,-0x8(%rbp)
  802759:	77 43                	ja     80279e <serve+0xe8>
  80275b:	48 b8 40 20 81 00 00 	movabs $0x812040,%rax
  802762:	00 00 00 
  802765:	8b 55 f8             	mov    -0x8(%rbp),%edx
  802768:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80276c:	48 85 c0             	test   %rax,%rax
  80276f:	74 2d                	je     80279e <serve+0xe8>
  802771:	48 b8 40 20 81 00 00 	movabs $0x812040,%rax
  802778:	00 00 00 
  80277b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80277e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802782:	48 ba 20 20 81 00 00 	movabs $0x812020,%rdx
  802789:	00 00 00 
  80278c:	48 8b 0a             	mov    (%rdx),%rcx
  80278f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802792:	48 89 ce             	mov    %rcx,%rsi
  802795:	89 d7                	mov    %edx,%edi
  802797:	ff d0                	callq  *%rax
  802799:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80279c:	eb 2a                	jmp    8027c8 <serve+0x112>
  80279e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8027a1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8027a4:	89 c6                	mov    %eax,%esi
  8027a6:	48 bf 98 77 80 00 00 	movabs $0x807798,%rdi
  8027ad:	00 00 00 
  8027b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8027b5:	48 b9 eb 36 80 00 00 	movabs $0x8036eb,%rcx
  8027bc:	00 00 00 
  8027bf:	ff d1                	callq  *%rcx
  8027c1:	c7 45 fc fd ff ff ff 	movl   $0xfffffffd,-0x4(%rbp)
  8027c8:	8b 4d f0             	mov    -0x10(%rbp),%ecx
  8027cb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8027cf:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8027d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8027d5:	89 c7                	mov    %eax,%edi
  8027d7:	48 b8 98 51 80 00 00 	movabs $0x805198,%rax
  8027de:	00 00 00 
  8027e1:	ff d0                	callq  *%rax
  8027e3:	48 b8 20 20 81 00 00 	movabs $0x812020,%rax
  8027ea:	00 00 00 
  8027ed:	48 8b 00             	mov    (%rax),%rax
  8027f0:	48 89 c6             	mov    %rax,%rsi
  8027f3:	bf 00 00 00 00       	mov    $0x0,%edi
  8027f8:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  8027ff:	00 00 00 
  802802:	ff d0                	callq  *%rax
  802804:	e9 b5 fe ff ff       	jmpq   8026be <serve+0x8>

0000000000802809 <umain>:
  802809:	55                   	push   %rbp
  80280a:	48 89 e5             	mov    %rsp,%rbp
  80280d:	48 83 ec 20          	sub    $0x20,%rsp
  802811:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802814:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802818:	48 b8 90 20 81 00 00 	movabs $0x812090,%rax
  80281f:	00 00 00 
  802822:	48 b9 bb 77 80 00 00 	movabs $0x8077bb,%rcx
  802829:	00 00 00 
  80282c:	48 89 08             	mov    %rcx,(%rax)
  80282f:	48 bf be 77 80 00 00 	movabs $0x8077be,%rdi
  802836:	00 00 00 
  802839:	b8 00 00 00 00       	mov    $0x0,%eax
  80283e:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802845:	00 00 00 
  802848:	ff d2                	callq  *%rdx
  80284a:	c7 45 fc 00 8a 00 00 	movl   $0x8a00,-0x4(%rbp)
  802851:	66 c7 45 fa 00 8a    	movw   $0x8a00,-0x6(%rbp)
}

static __inline void
outw(int port, uint16_t data)
{
	__asm __volatile("outw %0,%w1" : : "a" (data), "d" (port));
  802857:	0f b7 45 fa          	movzwl -0x6(%rbp),%eax
  80285b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80285e:	66 ef                	out    %ax,(%dx)
  802860:	48 bf cd 77 80 00 00 	movabs $0x8077cd,%rdi
  802867:	00 00 00 
  80286a:	b8 00 00 00 00       	mov    $0x0,%eax
  80286f:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802876:	00 00 00 
  802879:	ff d2                	callq  *%rdx
  80287b:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  802882:	00 00 00 
  802885:	ff d0                	callq  *%rax
  802887:	48 b8 03 10 80 00 00 	movabs $0x801003,%rax
  80288e:	00 00 00 
  802891:	ff d0                	callq  *%rax
  802893:	48 b8 b6 26 80 00 00 	movabs $0x8026b6,%rax
  80289a:	00 00 00 
  80289d:	ff d0                	callq  *%rax
  80289f:	c9                   	leaveq 
  8028a0:	c3                   	retq   

00000000008028a1 <fs_test>:
  8028a1:	55                   	push   %rbp
  8028a2:	48 89 e5             	mov    %rsp,%rbp
  8028a5:	48 83 ec 20          	sub    $0x20,%rsp
  8028a9:	ba 07 00 00 00       	mov    $0x7,%edx
  8028ae:	be 00 10 00 00       	mov    $0x1000,%esi
  8028b3:	bf 00 00 00 00       	mov    $0x0,%edi
  8028b8:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  8028bf:	00 00 00 
  8028c2:	ff d0                	callq  *%rax
  8028c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028cb:	79 30                	jns    8028fd <fs_test+0x5c>
  8028cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028d0:	89 c1                	mov    %eax,%ecx
  8028d2:	48 ba 06 78 80 00 00 	movabs $0x807806,%rdx
  8028d9:	00 00 00 
  8028dc:	be 14 00 00 00       	mov    $0x14,%esi
  8028e1:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  8028e8:	00 00 00 
  8028eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8028f0:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8028f7:	00 00 00 
  8028fa:	41 ff d0             	callq  *%r8
  8028fd:	48 c7 45 f0 00 10 00 	movq   $0x1000,-0x10(%rbp)
  802904:	00 
  802905:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  80290c:	00 00 00 
  80290f:	48 8b 08             	mov    (%rax),%rcx
  802912:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802916:	ba 00 10 00 00       	mov    $0x1000,%edx
  80291b:	48 89 ce             	mov    %rcx,%rsi
  80291e:	48 89 c7             	mov    %rax,%rdi
  802921:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  802928:	00 00 00 
  80292b:	ff d0                	callq  *%rax
  80292d:	48 b8 a9 0d 80 00 00 	movabs $0x800da9,%rax
  802934:	00 00 00 
  802937:	ff d0                	callq  *%rax
  802939:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80293c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802940:	79 30                	jns    802972 <fs_test+0xd1>
  802942:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802945:	89 c1                	mov    %eax,%ecx
  802947:	48 ba 26 78 80 00 00 	movabs $0x807826,%rdx
  80294e:	00 00 00 
  802951:	be 19 00 00 00       	mov    $0x19,%esi
  802956:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  80295d:	00 00 00 
  802960:	b8 00 00 00 00       	mov    $0x0,%eax
  802965:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80296c:	00 00 00 
  80296f:	41 ff d0             	callq  *%r8
  802972:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802975:	8d 50 1f             	lea    0x1f(%rax),%edx
  802978:	85 c0                	test   %eax,%eax
  80297a:	0f 48 c2             	cmovs  %edx,%eax
  80297d:	c1 f8 05             	sar    $0x5,%eax
  802980:	48 98                	cltq   
  802982:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  802989:	00 
  80298a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80298e:	48 01 d0             	add    %rdx,%rax
  802991:	8b 30                	mov    (%rax),%esi
  802993:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802996:	99                   	cltd   
  802997:	c1 ea 1b             	shr    $0x1b,%edx
  80299a:	01 d0                	add    %edx,%eax
  80299c:	83 e0 1f             	and    $0x1f,%eax
  80299f:	29 d0                	sub    %edx,%eax
  8029a1:	ba 01 00 00 00       	mov    $0x1,%edx
  8029a6:	89 c1                	mov    %eax,%ecx
  8029a8:	d3 e2                	shl    %cl,%edx
  8029aa:	89 d0                	mov    %edx,%eax
  8029ac:	21 f0                	and    %esi,%eax
  8029ae:	85 c0                	test   %eax,%eax
  8029b0:	75 35                	jne    8029e7 <fs_test+0x146>
  8029b2:	48 b9 36 78 80 00 00 	movabs $0x807836,%rcx
  8029b9:	00 00 00 
  8029bc:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  8029c3:	00 00 00 
  8029c6:	be 1b 00 00 00       	mov    $0x1b,%esi
  8029cb:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  8029d2:	00 00 00 
  8029d5:	b8 00 00 00 00       	mov    $0x0,%eax
  8029da:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  8029e1:	00 00 00 
  8029e4:	41 ff d0             	callq  *%r8
  8029e7:	48 b8 10 60 81 00 00 	movabs $0x816010,%rax
  8029ee:	00 00 00 
  8029f1:	48 8b 10             	mov    (%rax),%rdx
  8029f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029f7:	8d 48 1f             	lea    0x1f(%rax),%ecx
  8029fa:	85 c0                	test   %eax,%eax
  8029fc:	0f 48 c1             	cmovs  %ecx,%eax
  8029ff:	c1 f8 05             	sar    $0x5,%eax
  802a02:	48 98                	cltq   
  802a04:	48 c1 e0 02          	shl    $0x2,%rax
  802a08:	48 01 d0             	add    %rdx,%rax
  802a0b:	8b 30                	mov    (%rax),%esi
  802a0d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a10:	99                   	cltd   
  802a11:	c1 ea 1b             	shr    $0x1b,%edx
  802a14:	01 d0                	add    %edx,%eax
  802a16:	83 e0 1f             	and    $0x1f,%eax
  802a19:	29 d0                	sub    %edx,%eax
  802a1b:	ba 01 00 00 00       	mov    $0x1,%edx
  802a20:	89 c1                	mov    %eax,%ecx
  802a22:	d3 e2                	shl    %cl,%edx
  802a24:	89 d0                	mov    %edx,%eax
  802a26:	21 f0                	and    %esi,%eax
  802a28:	85 c0                	test   %eax,%eax
  802a2a:	74 35                	je     802a61 <fs_test+0x1c0>
  802a2c:	48 b9 68 78 80 00 00 	movabs $0x807868,%rcx
  802a33:	00 00 00 
  802a36:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802a3d:	00 00 00 
  802a40:	be 1d 00 00 00       	mov    $0x1d,%esi
  802a45:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802a4c:	00 00 00 
  802a4f:	b8 00 00 00 00       	mov    $0x0,%eax
  802a54:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802a5b:	00 00 00 
  802a5e:	41 ff d0             	callq  *%r8
  802a61:	48 bf 88 78 80 00 00 	movabs $0x807888,%rdi
  802a68:	00 00 00 
  802a6b:	b8 00 00 00 00       	mov    $0x0,%eax
  802a70:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802a77:	00 00 00 
  802a7a:	ff d2                	callq  *%rdx
  802a7c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  802a80:	48 89 c6             	mov    %rax,%rsi
  802a83:	48 bf 9d 78 80 00 00 	movabs $0x80789d,%rdi
  802a8a:	00 00 00 
  802a8d:	48 b8 0a 18 80 00 00 	movabs $0x80180a,%rax
  802a94:	00 00 00 
  802a97:	ff d0                	callq  *%rax
  802a99:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a9c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802aa0:	79 36                	jns    802ad8 <fs_test+0x237>
  802aa2:	83 7d fc f4          	cmpl   $0xfffffff4,-0x4(%rbp)
  802aa6:	74 30                	je     802ad8 <fs_test+0x237>
  802aa8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aab:	89 c1                	mov    %eax,%ecx
  802aad:	48 ba a8 78 80 00 00 	movabs $0x8078a8,%rdx
  802ab4:	00 00 00 
  802ab7:	be 21 00 00 00       	mov    $0x21,%esi
  802abc:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802ac3:	00 00 00 
  802ac6:	b8 00 00 00 00       	mov    $0x0,%eax
  802acb:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802ad2:	00 00 00 
  802ad5:	41 ff d0             	callq  *%r8
  802ad8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802adc:	75 2a                	jne    802b08 <fs_test+0x267>
  802ade:	48 ba c8 78 80 00 00 	movabs $0x8078c8,%rdx
  802ae5:	00 00 00 
  802ae8:	be 23 00 00 00       	mov    $0x23,%esi
  802aed:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802af4:	00 00 00 
  802af7:	b8 00 00 00 00       	mov    $0x0,%eax
  802afc:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  802b03:	00 00 00 
  802b06:	ff d1                	callq  *%rcx
  802b08:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  802b0c:	48 89 c6             	mov    %rax,%rsi
  802b0f:	48 bf e8 78 80 00 00 	movabs $0x8078e8,%rdi
  802b16:	00 00 00 
  802b19:	48 b8 0a 18 80 00 00 	movabs $0x80180a,%rax
  802b20:	00 00 00 
  802b23:	ff d0                	callq  *%rax
  802b25:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b28:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b2c:	79 30                	jns    802b5e <fs_test+0x2bd>
  802b2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b31:	89 c1                	mov    %eax,%ecx
  802b33:	48 ba f1 78 80 00 00 	movabs $0x8078f1,%rdx
  802b3a:	00 00 00 
  802b3d:	be 25 00 00 00       	mov    $0x25,%esi
  802b42:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802b49:	00 00 00 
  802b4c:	b8 00 00 00 00       	mov    $0x0,%eax
  802b51:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802b58:	00 00 00 
  802b5b:	41 ff d0             	callq  *%r8
  802b5e:	48 bf 08 79 80 00 00 	movabs $0x807908,%rdi
  802b65:	00 00 00 
  802b68:	b8 00 00 00 00       	mov    $0x0,%eax
  802b6d:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802b74:	00 00 00 
  802b77:	ff d2                	callq  *%rdx
  802b79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b7d:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  802b81:	be 00 00 00 00       	mov    $0x0,%esi
  802b86:	48 89 c7             	mov    %rax,%rdi
  802b89:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  802b90:	00 00 00 
  802b93:	ff d0                	callq  *%rax
  802b95:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b98:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b9c:	79 30                	jns    802bce <fs_test+0x32d>
  802b9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ba1:	89 c1                	mov    %eax,%ecx
  802ba3:	48 ba 1b 79 80 00 00 	movabs $0x80791b,%rdx
  802baa:	00 00 00 
  802bad:	be 29 00 00 00       	mov    $0x29,%esi
  802bb2:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802bb9:	00 00 00 
  802bbc:	b8 00 00 00 00       	mov    $0x0,%eax
  802bc1:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802bc8:	00 00 00 
  802bcb:	41 ff d0             	callq  *%r8
  802bce:	48 b8 88 20 81 00 00 	movabs $0x812088,%rax
  802bd5:	00 00 00 
  802bd8:	48 8b 10             	mov    (%rax),%rdx
  802bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802bdf:	48 89 d6             	mov    %rdx,%rsi
  802be2:	48 89 c7             	mov    %rax,%rdi
  802be5:	48 b8 02 44 80 00 00 	movabs $0x804402,%rax
  802bec:	00 00 00 
  802bef:	ff d0                	callq  *%rax
  802bf1:	85 c0                	test   %eax,%eax
  802bf3:	74 2a                	je     802c1f <fs_test+0x37e>
  802bf5:	48 ba 30 79 80 00 00 	movabs $0x807930,%rdx
  802bfc:	00 00 00 
  802bff:	be 2b 00 00 00       	mov    $0x2b,%esi
  802c04:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802c0b:	00 00 00 
  802c0e:	b8 00 00 00 00       	mov    $0x0,%eax
  802c13:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  802c1a:	00 00 00 
  802c1d:	ff d1                	callq  *%rcx
  802c1f:	48 bf 53 79 80 00 00 	movabs $0x807953,%rdi
  802c26:	00 00 00 
  802c29:	b8 00 00 00 00       	mov    $0x0,%eax
  802c2e:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802c35:	00 00 00 
  802c38:	ff d2                	callq  *%rdx
  802c3a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c3e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802c42:	0f b6 12             	movzbl (%rdx),%edx
  802c45:	88 10                	mov    %dl,(%rax)
  802c47:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c4b:	48 c1 e8 0c          	shr    $0xc,%rax
  802c4f:	48 89 c2             	mov    %rax,%rdx
  802c52:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802c59:	01 00 00 
  802c5c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802c60:	83 e0 40             	and    $0x40,%eax
  802c63:	48 85 c0             	test   %rax,%rax
  802c66:	75 35                	jne    802c9d <fs_test+0x3fc>
  802c68:	48 b9 6b 79 80 00 00 	movabs $0x80796b,%rcx
  802c6f:	00 00 00 
  802c72:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802c79:	00 00 00 
  802c7c:	be 2f 00 00 00       	mov    $0x2f,%esi
  802c81:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802c88:	00 00 00 
  802c8b:	b8 00 00 00 00       	mov    $0x0,%eax
  802c90:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802c97:	00 00 00 
  802c9a:	41 ff d0             	callq  *%r8
  802c9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ca1:	48 89 c7             	mov    %rax,%rdi
  802ca4:	48 b8 96 1c 80 00 00 	movabs $0x801c96,%rax
  802cab:	00 00 00 
  802cae:	ff d0                	callq  *%rax
  802cb0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802cb4:	48 c1 e8 0c          	shr    $0xc,%rax
  802cb8:	48 89 c2             	mov    %rax,%rdx
  802cbb:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802cc2:	01 00 00 
  802cc5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802cc9:	83 e0 40             	and    $0x40,%eax
  802ccc:	48 85 c0             	test   %rax,%rax
  802ccf:	74 35                	je     802d06 <fs_test+0x465>
  802cd1:	48 b9 86 79 80 00 00 	movabs $0x807986,%rcx
  802cd8:	00 00 00 
  802cdb:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802ce2:	00 00 00 
  802ce5:	be 31 00 00 00       	mov    $0x31,%esi
  802cea:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802cf1:	00 00 00 
  802cf4:	b8 00 00 00 00       	mov    $0x0,%eax
  802cf9:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802d00:	00 00 00 
  802d03:	41 ff d0             	callq  *%r8
  802d06:	48 bf a2 79 80 00 00 	movabs $0x8079a2,%rdi
  802d0d:	00 00 00 
  802d10:	b8 00 00 00 00       	mov    $0x0,%eax
  802d15:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802d1c:	00 00 00 
  802d1f:	ff d2                	callq  *%rdx
  802d21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d25:	be 00 00 00 00       	mov    $0x0,%esi
  802d2a:	48 89 c7             	mov    %rax,%rdi
  802d2d:	48 b8 39 1c 80 00 00 	movabs $0x801c39,%rax
  802d34:	00 00 00 
  802d37:	ff d0                	callq  *%rax
  802d39:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d3c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d40:	79 30                	jns    802d72 <fs_test+0x4d1>
  802d42:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d45:	89 c1                	mov    %eax,%ecx
  802d47:	48 ba b6 79 80 00 00 	movabs $0x8079b6,%rdx
  802d4e:	00 00 00 
  802d51:	be 35 00 00 00       	mov    $0x35,%esi
  802d56:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802d5d:	00 00 00 
  802d60:	b8 00 00 00 00       	mov    $0x0,%eax
  802d65:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802d6c:	00 00 00 
  802d6f:	41 ff d0             	callq  *%r8
  802d72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d76:	8b 80 88 00 00 00    	mov    0x88(%rax),%eax
  802d7c:	85 c0                	test   %eax,%eax
  802d7e:	74 35                	je     802db5 <fs_test+0x514>
  802d80:	48 b9 c8 79 80 00 00 	movabs $0x8079c8,%rcx
  802d87:	00 00 00 
  802d8a:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802d91:	00 00 00 
  802d94:	be 36 00 00 00       	mov    $0x36,%esi
  802d99:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802da0:	00 00 00 
  802da3:	b8 00 00 00 00       	mov    $0x0,%eax
  802da8:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802daf:	00 00 00 
  802db2:	41 ff d0             	callq  *%r8
  802db5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802db9:	48 c1 e8 0c          	shr    $0xc,%rax
  802dbd:	48 89 c2             	mov    %rax,%rdx
  802dc0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802dc7:	01 00 00 
  802dca:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802dce:	83 e0 40             	and    $0x40,%eax
  802dd1:	48 85 c0             	test   %rax,%rax
  802dd4:	74 35                	je     802e0b <fs_test+0x56a>
  802dd6:	48 b9 dc 79 80 00 00 	movabs $0x8079dc,%rcx
  802ddd:	00 00 00 
  802de0:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802de7:	00 00 00 
  802dea:	be 37 00 00 00       	mov    $0x37,%esi
  802def:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802df6:	00 00 00 
  802df9:	b8 00 00 00 00       	mov    $0x0,%eax
  802dfe:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802e05:	00 00 00 
  802e08:	41 ff d0             	callq  *%r8
  802e0b:	48 bf f6 79 80 00 00 	movabs $0x8079f6,%rdi
  802e12:	00 00 00 
  802e15:	b8 00 00 00 00       	mov    $0x0,%eax
  802e1a:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  802e21:	00 00 00 
  802e24:	ff d2                	callq  *%rdx
  802e26:	48 b8 88 20 81 00 00 	movabs $0x812088,%rax
  802e2d:	00 00 00 
  802e30:	48 8b 00             	mov    (%rax),%rax
  802e33:	48 89 c7             	mov    %rax,%rdi
  802e36:	48 b8 34 42 80 00 00 	movabs $0x804234,%rax
  802e3d:	00 00 00 
  802e40:	ff d0                	callq  *%rax
  802e42:	89 c2                	mov    %eax,%edx
  802e44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e48:	89 d6                	mov    %edx,%esi
  802e4a:	48 89 c7             	mov    %rax,%rdi
  802e4d:	48 b8 39 1c 80 00 00 	movabs $0x801c39,%rax
  802e54:	00 00 00 
  802e57:	ff d0                	callq  *%rax
  802e59:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e5c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e60:	79 30                	jns    802e92 <fs_test+0x5f1>
  802e62:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e65:	89 c1                	mov    %eax,%ecx
  802e67:	48 ba 0d 7a 80 00 00 	movabs $0x807a0d,%rdx
  802e6e:	00 00 00 
  802e71:	be 3b 00 00 00       	mov    $0x3b,%esi
  802e76:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802e7d:	00 00 00 
  802e80:	b8 00 00 00 00       	mov    $0x0,%eax
  802e85:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802e8c:	00 00 00 
  802e8f:	41 ff d0             	callq  *%r8
  802e92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e96:	48 c1 e8 0c          	shr    $0xc,%rax
  802e9a:	48 89 c2             	mov    %rax,%rdx
  802e9d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ea4:	01 00 00 
  802ea7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802eab:	83 e0 40             	and    $0x40,%eax
  802eae:	48 85 c0             	test   %rax,%rax
  802eb1:	74 35                	je     802ee8 <fs_test+0x647>
  802eb3:	48 b9 dc 79 80 00 00 	movabs $0x8079dc,%rcx
  802eba:	00 00 00 
  802ebd:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802ec4:	00 00 00 
  802ec7:	be 3c 00 00 00       	mov    $0x3c,%esi
  802ecc:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802ed3:	00 00 00 
  802ed6:	b8 00 00 00 00       	mov    $0x0,%eax
  802edb:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802ee2:	00 00 00 
  802ee5:	41 ff d0             	callq  *%r8
  802ee8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802eec:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  802ef0:	be 00 00 00 00       	mov    $0x0,%esi
  802ef5:	48 89 c7             	mov    %rax,%rdi
  802ef8:	48 b8 8a 11 80 00 00 	movabs $0x80118a,%rax
  802eff:	00 00 00 
  802f02:	ff d0                	callq  *%rax
  802f04:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f07:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f0b:	79 30                	jns    802f3d <fs_test+0x69c>
  802f0d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f10:	89 c1                	mov    %eax,%ecx
  802f12:	48 ba 21 7a 80 00 00 	movabs $0x807a21,%rdx
  802f19:	00 00 00 
  802f1c:	be 3e 00 00 00       	mov    $0x3e,%esi
  802f21:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802f28:	00 00 00 
  802f2b:	b8 00 00 00 00       	mov    $0x0,%eax
  802f30:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802f37:	00 00 00 
  802f3a:	41 ff d0             	callq  *%r8
  802f3d:	48 b8 88 20 81 00 00 	movabs $0x812088,%rax
  802f44:	00 00 00 
  802f47:	48 8b 10             	mov    (%rax),%rdx
  802f4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f4e:	48 89 d6             	mov    %rdx,%rsi
  802f51:	48 89 c7             	mov    %rax,%rdi
  802f54:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  802f5b:	00 00 00 
  802f5e:	ff d0                	callq  *%rax
  802f60:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f64:	48 c1 e8 0c          	shr    $0xc,%rax
  802f68:	48 89 c2             	mov    %rax,%rdx
  802f6b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802f72:	01 00 00 
  802f75:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802f79:	83 e0 40             	and    $0x40,%eax
  802f7c:	48 85 c0             	test   %rax,%rax
  802f7f:	75 35                	jne    802fb6 <fs_test+0x715>
  802f81:	48 b9 6b 79 80 00 00 	movabs $0x80796b,%rcx
  802f88:	00 00 00 
  802f8b:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802f92:	00 00 00 
  802f95:	be 40 00 00 00       	mov    $0x40,%esi
  802f9a:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  802fa1:	00 00 00 
  802fa4:	b8 00 00 00 00       	mov    $0x0,%eax
  802fa9:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  802fb0:	00 00 00 
  802fb3:	41 ff d0             	callq  *%r8
  802fb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fba:	48 89 c7             	mov    %rax,%rdi
  802fbd:	48 b8 96 1c 80 00 00 	movabs $0x801c96,%rax
  802fc4:	00 00 00 
  802fc7:	ff d0                	callq  *%rax
  802fc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fcd:	48 c1 e8 0c          	shr    $0xc,%rax
  802fd1:	48 89 c2             	mov    %rax,%rdx
  802fd4:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802fdb:	01 00 00 
  802fde:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802fe2:	83 e0 40             	and    $0x40,%eax
  802fe5:	48 85 c0             	test   %rax,%rax
  802fe8:	74 35                	je     80301f <fs_test+0x77e>
  802fea:	48 b9 86 79 80 00 00 	movabs $0x807986,%rcx
  802ff1:	00 00 00 
  802ff4:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  802ffb:	00 00 00 
  802ffe:	be 42 00 00 00       	mov    $0x42,%esi
  803003:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  80300a:	00 00 00 
  80300d:	b8 00 00 00 00       	mov    $0x0,%eax
  803012:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  803019:	00 00 00 
  80301c:	41 ff d0             	callq  *%r8
  80301f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803023:	48 c1 e8 0c          	shr    $0xc,%rax
  803027:	48 89 c2             	mov    %rax,%rdx
  80302a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803031:	01 00 00 
  803034:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803038:	83 e0 40             	and    $0x40,%eax
  80303b:	48 85 c0             	test   %rax,%rax
  80303e:	74 35                	je     803075 <fs_test+0x7d4>
  803040:	48 b9 dc 79 80 00 00 	movabs $0x8079dc,%rcx
  803047:	00 00 00 
  80304a:	48 ba 51 78 80 00 00 	movabs $0x807851,%rdx
  803051:	00 00 00 
  803054:	be 43 00 00 00       	mov    $0x43,%esi
  803059:	48 bf 19 78 80 00 00 	movabs $0x807819,%rdi
  803060:	00 00 00 
  803063:	b8 00 00 00 00       	mov    $0x0,%eax
  803068:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80306f:	00 00 00 
  803072:	41 ff d0             	callq  *%r8
  803075:	48 bf 36 7a 80 00 00 	movabs $0x807a36,%rdi
  80307c:	00 00 00 
  80307f:	b8 00 00 00 00       	mov    $0x0,%eax
  803084:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  80308b:	00 00 00 
  80308e:	ff d2                	callq  *%rdx
  803090:	c9                   	leaveq 
  803091:	c3                   	retq   

0000000000803092 <host_fsipc>:
  803092:	55                   	push   %rbp
  803093:	48 89 e5             	mov    %rsp,%rbp
  803096:	48 83 ec 10          	sub    $0x10,%rsp
  80309a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80309d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8030a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030a4:	b9 07 00 00 00       	mov    $0x7,%ecx
  8030a9:	48 ba 00 50 81 00 00 	movabs $0x815000,%rdx
  8030b0:	00 00 00 
  8030b3:	89 c6                	mov    %eax,%esi
  8030b5:	bf 01 00 00 00       	mov    $0x1,%edi
  8030ba:	48 b8 64 52 80 00 00 	movabs $0x805264,%rax
  8030c1:	00 00 00 
  8030c4:	ff d0                	callq  *%rax
  8030c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8030ca:	48 89 c7             	mov    %rax,%rdi
  8030cd:	48 b8 2e 52 80 00 00 	movabs $0x80522e,%rax
  8030d4:	00 00 00 
  8030d7:	ff d0                	callq  *%rax
  8030d9:	c9                   	leaveq 
  8030da:	c3                   	retq   

00000000008030db <get_host_fd>:
  8030db:	55                   	push   %rbp
  8030dc:	48 89 e5             	mov    %rsp,%rbp
  8030df:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  8030e6:	00 00 00 
  8030e9:	48 8b 00             	mov    (%rax),%rax
  8030ec:	5d                   	pop    %rbp
  8030ed:	c3                   	retq   

00000000008030ee <host_read>:
  8030ee:	55                   	push   %rbp
  8030ef:	48 89 e5             	mov    %rsp,%rbp
  8030f2:	48 83 ec 30          	sub    $0x30,%rsp
  8030f6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8030f9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8030fd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803101:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803108:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  80310f:	00 00 00 
  803112:	48 8b 00             	mov    (%rax),%rax
  803115:	8b 40 0c             	mov    0xc(%rax),%eax
  803118:	85 c0                	test   %eax,%eax
  80311a:	75 11                	jne    80312d <host_read+0x3f>
  80311c:	b8 00 00 00 00       	mov    $0x0,%eax
  803121:	48 ba db 32 80 00 00 	movabs $0x8032db,%rdx
  803128:	00 00 00 
  80312b:	ff d2                	callq  *%rdx
  80312d:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  803134:	00 00 00 
  803137:	48 8b 00             	mov    (%rax),%rax
  80313a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80313d:	c1 e2 09             	shl    $0x9,%edx
  803140:	89 50 04             	mov    %edx,0x4(%rax)
  803143:	e9 8c 00 00 00       	jmpq   8031d4 <host_read+0xe6>
  803148:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  80314f:	00 00 00 
  803152:	48 8b 00             	mov    (%rax),%rax
  803155:	8b 50 0c             	mov    0xc(%rax),%edx
  803158:	48 b8 00 50 81 00 00 	movabs $0x815000,%rax
  80315f:	00 00 00 
  803162:	89 10                	mov    %edx,(%rax)
  803164:	48 b8 00 50 81 00 00 	movabs $0x815000,%rax
  80316b:	00 00 00 
  80316e:	48 c7 40 08 00 04 00 	movq   $0x400,0x8(%rax)
  803175:	00 
  803176:	be 00 00 00 00       	mov    $0x0,%esi
  80317b:	bf 03 00 00 00       	mov    $0x3,%edi
  803180:	48 b8 92 30 80 00 00 	movabs $0x803092,%rax
  803187:	00 00 00 
  80318a:	ff d0                	callq  *%rax
  80318c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80318f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803193:	79 05                	jns    80319a <host_read+0xac>
  803195:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803198:	eb 4a                	jmp    8031e4 <host_read+0xf6>
  80319a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80319d:	48 98                	cltq   
  80319f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8031a2:	48 63 ca             	movslq %edx,%rcx
  8031a5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8031a9:	48 01 d1             	add    %rdx,%rcx
  8031ac:	48 89 c2             	mov    %rax,%rdx
  8031af:	48 be 00 50 81 00 00 	movabs $0x815000,%rsi
  8031b6:	00 00 00 
  8031b9:	48 89 cf             	mov    %rcx,%rdi
  8031bc:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  8031c3:	00 00 00 
  8031c6:	ff d0                	callq  *%rax
  8031c8:	81 45 fc 00 04 00 00 	addl   $0x400,-0x4(%rbp)
  8031cf:	48 83 6d d8 02       	subq   $0x2,-0x28(%rbp)
  8031d4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8031d9:	0f 85 69 ff ff ff    	jne    803148 <host_read+0x5a>
  8031df:	b8 00 00 00 00       	mov    $0x0,%eax
  8031e4:	c9                   	leaveq 
  8031e5:	c3                   	retq   

00000000008031e6 <host_write>:
  8031e6:	55                   	push   %rbp
  8031e7:	48 89 e5             	mov    %rsp,%rbp
  8031ea:	48 83 ec 30          	sub    $0x30,%rsp
  8031ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8031f1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8031f5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8031f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803200:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  803207:	00 00 00 
  80320a:	48 8b 00             	mov    (%rax),%rax
  80320d:	8b 40 0c             	mov    0xc(%rax),%eax
  803210:	85 c0                	test   %eax,%eax
  803212:	75 11                	jne    803225 <host_write+0x3f>
  803214:	b8 00 00 00 00       	mov    $0x0,%eax
  803219:	48 ba db 32 80 00 00 	movabs $0x8032db,%rdx
  803220:	00 00 00 
  803223:	ff d2                	callq  *%rdx
  803225:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  80322c:	00 00 00 
  80322f:	48 8b 00             	mov    (%rax),%rax
  803232:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803235:	c1 e2 09             	shl    $0x9,%edx
  803238:	89 50 04             	mov    %edx,0x4(%rax)
  80323b:	e9 89 00 00 00       	jmpq   8032c9 <host_write+0xe3>
  803240:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  803247:	00 00 00 
  80324a:	48 8b 00             	mov    (%rax),%rax
  80324d:	8b 50 0c             	mov    0xc(%rax),%edx
  803250:	48 b8 00 50 81 00 00 	movabs $0x815000,%rax
  803257:	00 00 00 
  80325a:	89 10                	mov    %edx,(%rax)
  80325c:	48 b8 00 50 81 00 00 	movabs $0x815000,%rax
  803263:	00 00 00 
  803266:	48 c7 40 08 00 04 00 	movq   $0x400,0x8(%rax)
  80326d:	00 
  80326e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803271:	48 63 d0             	movslq %eax,%rdx
  803274:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803278:	48 01 d0             	add    %rdx,%rax
  80327b:	ba 00 04 00 00       	mov    $0x400,%edx
  803280:	48 89 c6             	mov    %rax,%rsi
  803283:	48 bf 10 50 81 00 00 	movabs $0x815010,%rdi
  80328a:	00 00 00 
  80328d:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  803294:	00 00 00 
  803297:	ff d0                	callq  *%rax
  803299:	be 00 00 00 00       	mov    $0x0,%esi
  80329e:	bf 04 00 00 00       	mov    $0x4,%edi
  8032a3:	48 b8 92 30 80 00 00 	movabs $0x803092,%rax
  8032aa:	00 00 00 
  8032ad:	ff d0                	callq  *%rax
  8032af:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8032b2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8032b6:	79 05                	jns    8032bd <host_write+0xd7>
  8032b8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8032bb:	eb 1c                	jmp    8032d9 <host_write+0xf3>
  8032bd:	81 45 fc 00 04 00 00 	addl   $0x400,-0x4(%rbp)
  8032c4:	48 83 6d d8 02       	subq   $0x2,-0x28(%rbp)
  8032c9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8032ce:	0f 85 6c ff ff ff    	jne    803240 <host_write+0x5a>
  8032d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8032d9:	c9                   	leaveq 
  8032da:	c3                   	retq   

00000000008032db <host_ipc_init>:
  8032db:	55                   	push   %rbp
  8032dc:	48 89 e5             	mov    %rsp,%rbp
  8032df:	48 83 ec 40          	sub    $0x40,%rsp
  8032e3:	48 bf 00 40 81 00 00 	movabs $0x814000,%rdi
  8032ea:	00 00 00 
  8032ed:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  8032f4:	00 00 00 
  8032f7:	ff d0                	callq  *%rax
  8032f9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803300:	79 2a                	jns    80332c <host_ipc_init+0x51>
  803302:	48 ba 4c 7a 80 00 00 	movabs $0x807a4c,%rdx
  803309:	00 00 00 
  80330c:	be 53 00 00 00       	mov    $0x53,%esi
  803311:	48 bf 65 7a 80 00 00 	movabs $0x807a65,%rdi
  803318:	00 00 00 
  80331b:	b8 00 00 00 00       	mov    $0x0,%eax
  803320:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  803327:	00 00 00 
  80332a:	ff d1                	callq  *%rcx
  80332c:	b8 06 00 00 00       	mov    $0x6,%eax
  803331:	0f 01 c1             	vmcall 
  803334:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803337:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80333a:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  80333e:	89 d1                	mov    %edx,%ecx
  803340:	48 ba 76 7a 80 00 00 	movabs $0x807a76,%rdx
  803347:	00 00 00 
  80334a:	be 32 00 00 00       	mov    $0x32,%esi
  80334f:	48 89 c7             	mov    %rax,%rdi
  803352:	b8 00 00 00 00       	mov    $0x0,%eax
  803357:	49 b8 53 41 80 00 00 	movabs $0x804153,%r8
  80335e:	00 00 00 
  803361:	41 ff d0             	callq  *%r8
  803364:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  803368:	48 89 c6             	mov    %rax,%rsi
  80336b:	48 bf 00 50 81 00 00 	movabs $0x815000,%rdi
  803372:	00 00 00 
  803375:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  80337c:	00 00 00 
  80337f:	ff d0                	callq  *%rax
  803381:	48 b8 00 50 81 00 00 	movabs $0x815000,%rax
  803388:	00 00 00 
  80338b:	c7 80 00 04 00 00 02 	movl   $0x2,0x400(%rax)
  803392:	00 00 00 
  803395:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  80339c:	00 00 00 
  80339f:	48 8b 00             	mov    (%rax),%rax
  8033a2:	48 89 c6             	mov    %rax,%rsi
  8033a5:	bf 01 00 00 00       	mov    $0x1,%edi
  8033aa:	48 b8 92 30 80 00 00 	movabs $0x803092,%rax
  8033b1:	00 00 00 
  8033b4:	ff d0                	callq  *%rax
  8033b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033bd:	79 4b                	jns    80340a <host_ipc_init+0x12f>
  8033bf:	48 b8 00 40 81 00 00 	movabs $0x814000,%rax
  8033c6:	00 00 00 
  8033c9:	48 8b 00             	mov    (%rax),%rax
  8033cc:	be 00 00 00 00       	mov    $0x0,%esi
  8033d1:	48 89 c7             	mov    %rax,%rdi
  8033d4:	48 b8 8b 54 80 00 00 	movabs $0x80548b,%rax
  8033db:	00 00 00 
  8033de:	ff d0                	callq  *%rax
  8033e0:	48 ba 84 7a 80 00 00 	movabs $0x807a84,%rdx
  8033e7:	00 00 00 
  8033ea:	be 5b 00 00 00       	mov    $0x5b,%esi
  8033ef:	48 bf 65 7a 80 00 00 	movabs $0x807a65,%rdi
  8033f6:	00 00 00 
  8033f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8033fe:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  803405:	00 00 00 
  803408:	ff d1                	callq  *%rcx
  80340a:	c9                   	leaveq 
  80340b:	c3                   	retq   

000000000080340c <libmain>:
  80340c:	55                   	push   %rbp
  80340d:	48 89 e5             	mov    %rsp,%rbp
  803410:	48 83 ec 10          	sub    $0x10,%rsp
  803414:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803417:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80341b:	48 b8 53 4b 80 00 00 	movabs $0x804b53,%rax
  803422:	00 00 00 
  803425:	ff d0                	callq  *%rax
  803427:	25 ff 03 00 00       	and    $0x3ff,%eax
  80342c:	48 98                	cltq   
  80342e:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  803435:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80343c:	00 00 00 
  80343f:	48 01 c2             	add    %rax,%rdx
  803442:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  803449:	00 00 00 
  80344c:	48 89 10             	mov    %rdx,(%rax)
  80344f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803453:	7e 14                	jle    803469 <libmain+0x5d>
  803455:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803459:	48 8b 10             	mov    (%rax),%rdx
  80345c:	48 b8 90 20 81 00 00 	movabs $0x812090,%rax
  803463:	00 00 00 
  803466:	48 89 10             	mov    %rdx,(%rax)
  803469:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80346d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803470:	48 89 d6             	mov    %rdx,%rsi
  803473:	89 c7                	mov    %eax,%edi
  803475:	48 b8 09 28 80 00 00 	movabs $0x802809,%rax
  80347c:	00 00 00 
  80347f:	ff d0                	callq  *%rax
  803481:	48 b8 8f 34 80 00 00 	movabs $0x80348f,%rax
  803488:	00 00 00 
  80348b:	ff d0                	callq  *%rax
  80348d:	c9                   	leaveq 
  80348e:	c3                   	retq   

000000000080348f <exit>:
  80348f:	55                   	push   %rbp
  803490:	48 89 e5             	mov    %rsp,%rbp
  803493:	48 b8 56 56 80 00 00 	movabs $0x805656,%rax
  80349a:	00 00 00 
  80349d:	ff d0                	callq  *%rax
  80349f:	bf 00 00 00 00       	mov    $0x0,%edi
  8034a4:	48 b8 0f 4b 80 00 00 	movabs $0x804b0f,%rax
  8034ab:	00 00 00 
  8034ae:	ff d0                	callq  *%rax
  8034b0:	5d                   	pop    %rbp
  8034b1:	c3                   	retq   

00000000008034b2 <_panic>:
  8034b2:	55                   	push   %rbp
  8034b3:	48 89 e5             	mov    %rsp,%rbp
  8034b6:	53                   	push   %rbx
  8034b7:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8034be:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8034c5:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8034cb:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8034d2:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8034d9:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8034e0:	84 c0                	test   %al,%al
  8034e2:	74 23                	je     803507 <_panic+0x55>
  8034e4:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8034eb:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8034ef:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8034f3:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  8034f7:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  8034fb:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  8034ff:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  803503:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  803507:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80350e:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  803515:	00 00 00 
  803518:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80351f:	00 00 00 
  803522:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803526:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  80352d:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  803534:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80353b:	48 b8 90 20 81 00 00 	movabs $0x812090,%rax
  803542:	00 00 00 
  803545:	48 8b 18             	mov    (%rax),%rbx
  803548:	48 b8 53 4b 80 00 00 	movabs $0x804b53,%rax
  80354f:	00 00 00 
  803552:	ff d0                	callq  *%rax
  803554:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  80355a:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803561:	41 89 c8             	mov    %ecx,%r8d
  803564:	48 89 d1             	mov    %rdx,%rcx
  803567:	48 89 da             	mov    %rbx,%rdx
  80356a:	89 c6                	mov    %eax,%esi
  80356c:	48 bf a8 7a 80 00 00 	movabs $0x807aa8,%rdi
  803573:	00 00 00 
  803576:	b8 00 00 00 00       	mov    $0x0,%eax
  80357b:	49 b9 eb 36 80 00 00 	movabs $0x8036eb,%r9
  803582:	00 00 00 
  803585:	41 ff d1             	callq  *%r9
  803588:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  80358f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803596:	48 89 d6             	mov    %rdx,%rsi
  803599:	48 89 c7             	mov    %rax,%rdi
  80359c:	48 b8 3f 36 80 00 00 	movabs $0x80363f,%rax
  8035a3:	00 00 00 
  8035a6:	ff d0                	callq  *%rax
  8035a8:	48 bf cb 7a 80 00 00 	movabs $0x807acb,%rdi
  8035af:	00 00 00 
  8035b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8035b7:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  8035be:	00 00 00 
  8035c1:	ff d2                	callq  *%rdx
  8035c3:	cc                   	int3   
  8035c4:	eb fd                	jmp    8035c3 <_panic+0x111>

00000000008035c6 <putch>:
  8035c6:	55                   	push   %rbp
  8035c7:	48 89 e5             	mov    %rsp,%rbp
  8035ca:	48 83 ec 10          	sub    $0x10,%rsp
  8035ce:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8035d1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8035d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035d9:	8b 00                	mov    (%rax),%eax
  8035db:	8d 48 01             	lea    0x1(%rax),%ecx
  8035de:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8035e2:	89 0a                	mov    %ecx,(%rdx)
  8035e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8035e7:	89 d1                	mov    %edx,%ecx
  8035e9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8035ed:	48 98                	cltq   
  8035ef:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8035f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035f7:	8b 00                	mov    (%rax),%eax
  8035f9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8035fe:	75 2c                	jne    80362c <putch+0x66>
  803600:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803604:	8b 00                	mov    (%rax),%eax
  803606:	48 98                	cltq   
  803608:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80360c:	48 83 c2 08          	add    $0x8,%rdx
  803610:	48 89 c6             	mov    %rax,%rsi
  803613:	48 89 d7             	mov    %rdx,%rdi
  803616:	48 b8 87 4a 80 00 00 	movabs $0x804a87,%rax
  80361d:	00 00 00 
  803620:	ff d0                	callq  *%rax
  803622:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803626:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80362c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803630:	8b 40 04             	mov    0x4(%rax),%eax
  803633:	8d 50 01             	lea    0x1(%rax),%edx
  803636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80363a:	89 50 04             	mov    %edx,0x4(%rax)
  80363d:	c9                   	leaveq 
  80363e:	c3                   	retq   

000000000080363f <vcprintf>:
  80363f:	55                   	push   %rbp
  803640:	48 89 e5             	mov    %rsp,%rbp
  803643:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80364a:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  803651:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  803658:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  80365f:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  803666:	48 8b 0a             	mov    (%rdx),%rcx
  803669:	48 89 08             	mov    %rcx,(%rax)
  80366c:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  803670:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803674:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803678:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80367c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  803683:	00 00 00 
  803686:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80368d:	00 00 00 
  803690:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  803697:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  80369e:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8036a5:	48 89 c6             	mov    %rax,%rsi
  8036a8:	48 bf c6 35 80 00 00 	movabs $0x8035c6,%rdi
  8036af:	00 00 00 
  8036b2:	48 b8 9e 3a 80 00 00 	movabs $0x803a9e,%rax
  8036b9:	00 00 00 
  8036bc:	ff d0                	callq  *%rax
  8036be:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8036c4:	48 98                	cltq   
  8036c6:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8036cd:	48 83 c2 08          	add    $0x8,%rdx
  8036d1:	48 89 c6             	mov    %rax,%rsi
  8036d4:	48 89 d7             	mov    %rdx,%rdi
  8036d7:	48 b8 87 4a 80 00 00 	movabs $0x804a87,%rax
  8036de:	00 00 00 
  8036e1:	ff d0                	callq  *%rax
  8036e3:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8036e9:	c9                   	leaveq 
  8036ea:	c3                   	retq   

00000000008036eb <cprintf>:
  8036eb:	55                   	push   %rbp
  8036ec:	48 89 e5             	mov    %rsp,%rbp
  8036ef:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8036f6:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8036fd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  803704:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80370b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803712:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803719:	84 c0                	test   %al,%al
  80371b:	74 20                	je     80373d <cprintf+0x52>
  80371d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803721:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803725:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803729:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80372d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803731:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803735:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  803739:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80373d:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  803744:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80374b:	00 00 00 
  80374e:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803755:	00 00 00 
  803758:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80375c:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803763:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80376a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803771:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  803778:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80377f:	48 8b 0a             	mov    (%rdx),%rcx
  803782:	48 89 08             	mov    %rcx,(%rax)
  803785:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  803789:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80378d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803791:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803795:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80379c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8037a3:	48 89 d6             	mov    %rdx,%rsi
  8037a6:	48 89 c7             	mov    %rax,%rdi
  8037a9:	48 b8 3f 36 80 00 00 	movabs $0x80363f,%rax
  8037b0:	00 00 00 
  8037b3:	ff d0                	callq  *%rax
  8037b5:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8037bb:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8037c1:	c9                   	leaveq 
  8037c2:	c3                   	retq   

00000000008037c3 <printnum>:
  8037c3:	55                   	push   %rbp
  8037c4:	48 89 e5             	mov    %rsp,%rbp
  8037c7:	53                   	push   %rbx
  8037c8:	48 83 ec 38          	sub    $0x38,%rsp
  8037cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8037d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8037d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8037d8:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8037db:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8037df:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8037e3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8037e6:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8037ea:	77 3b                	ja     803827 <printnum+0x64>
  8037ec:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8037ef:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8037f3:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8037f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8037fa:	ba 00 00 00 00       	mov    $0x0,%edx
  8037ff:	48 f7 f3             	div    %rbx
  803802:	48 89 c2             	mov    %rax,%rdx
  803805:	8b 7d cc             	mov    -0x34(%rbp),%edi
  803808:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80380b:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80380f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803813:	41 89 f9             	mov    %edi,%r9d
  803816:	48 89 c7             	mov    %rax,%rdi
  803819:	48 b8 c3 37 80 00 00 	movabs $0x8037c3,%rax
  803820:	00 00 00 
  803823:	ff d0                	callq  *%rax
  803825:	eb 1e                	jmp    803845 <printnum+0x82>
  803827:	eb 12                	jmp    80383b <printnum+0x78>
  803829:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80382d:	8b 55 cc             	mov    -0x34(%rbp),%edx
  803830:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803834:	48 89 ce             	mov    %rcx,%rsi
  803837:	89 d7                	mov    %edx,%edi
  803839:	ff d0                	callq  *%rax
  80383b:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80383f:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  803843:	7f e4                	jg     803829 <printnum+0x66>
  803845:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  803848:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80384c:	ba 00 00 00 00       	mov    $0x0,%edx
  803851:	48 f7 f1             	div    %rcx
  803854:	48 89 d0             	mov    %rdx,%rax
  803857:	48 ba d0 7c 80 00 00 	movabs $0x807cd0,%rdx
  80385e:	00 00 00 
  803861:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  803865:	0f be d0             	movsbl %al,%edx
  803868:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80386c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803870:	48 89 ce             	mov    %rcx,%rsi
  803873:	89 d7                	mov    %edx,%edi
  803875:	ff d0                	callq  *%rax
  803877:	48 83 c4 38          	add    $0x38,%rsp
  80387b:	5b                   	pop    %rbx
  80387c:	5d                   	pop    %rbp
  80387d:	c3                   	retq   

000000000080387e <getuint>:
  80387e:	55                   	push   %rbp
  80387f:	48 89 e5             	mov    %rsp,%rbp
  803882:	48 83 ec 1c          	sub    $0x1c,%rsp
  803886:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80388a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80388d:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  803891:	7e 52                	jle    8038e5 <getuint+0x67>
  803893:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803897:	8b 00                	mov    (%rax),%eax
  803899:	83 f8 30             	cmp    $0x30,%eax
  80389c:	73 24                	jae    8038c2 <getuint+0x44>
  80389e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038a2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8038a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038aa:	8b 00                	mov    (%rax),%eax
  8038ac:	89 c0                	mov    %eax,%eax
  8038ae:	48 01 d0             	add    %rdx,%rax
  8038b1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8038b5:	8b 12                	mov    (%rdx),%edx
  8038b7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8038ba:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8038be:	89 0a                	mov    %ecx,(%rdx)
  8038c0:	eb 17                	jmp    8038d9 <getuint+0x5b>
  8038c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038c6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8038ca:	48 89 d0             	mov    %rdx,%rax
  8038cd:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8038d1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8038d5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8038d9:	48 8b 00             	mov    (%rax),%rax
  8038dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8038e0:	e9 a3 00 00 00       	jmpq   803988 <getuint+0x10a>
  8038e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8038e9:	74 4f                	je     80393a <getuint+0xbc>
  8038eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038ef:	8b 00                	mov    (%rax),%eax
  8038f1:	83 f8 30             	cmp    $0x30,%eax
  8038f4:	73 24                	jae    80391a <getuint+0x9c>
  8038f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038fa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8038fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803902:	8b 00                	mov    (%rax),%eax
  803904:	89 c0                	mov    %eax,%eax
  803906:	48 01 d0             	add    %rdx,%rax
  803909:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80390d:	8b 12                	mov    (%rdx),%edx
  80390f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803912:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803916:	89 0a                	mov    %ecx,(%rdx)
  803918:	eb 17                	jmp    803931 <getuint+0xb3>
  80391a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80391e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  803922:	48 89 d0             	mov    %rdx,%rax
  803925:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803929:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80392d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  803931:	48 8b 00             	mov    (%rax),%rax
  803934:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803938:	eb 4e                	jmp    803988 <getuint+0x10a>
  80393a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80393e:	8b 00                	mov    (%rax),%eax
  803940:	83 f8 30             	cmp    $0x30,%eax
  803943:	73 24                	jae    803969 <getuint+0xeb>
  803945:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803949:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80394d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803951:	8b 00                	mov    (%rax),%eax
  803953:	89 c0                	mov    %eax,%eax
  803955:	48 01 d0             	add    %rdx,%rax
  803958:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80395c:	8b 12                	mov    (%rdx),%edx
  80395e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803961:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803965:	89 0a                	mov    %ecx,(%rdx)
  803967:	eb 17                	jmp    803980 <getuint+0x102>
  803969:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80396d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  803971:	48 89 d0             	mov    %rdx,%rax
  803974:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803978:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80397c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  803980:	8b 00                	mov    (%rax),%eax
  803982:	89 c0                	mov    %eax,%eax
  803984:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803988:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80398c:	c9                   	leaveq 
  80398d:	c3                   	retq   

000000000080398e <getint>:
  80398e:	55                   	push   %rbp
  80398f:	48 89 e5             	mov    %rsp,%rbp
  803992:	48 83 ec 1c          	sub    $0x1c,%rsp
  803996:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80399a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80399d:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8039a1:	7e 52                	jle    8039f5 <getint+0x67>
  8039a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039a7:	8b 00                	mov    (%rax),%eax
  8039a9:	83 f8 30             	cmp    $0x30,%eax
  8039ac:	73 24                	jae    8039d2 <getint+0x44>
  8039ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039b2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8039b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039ba:	8b 00                	mov    (%rax),%eax
  8039bc:	89 c0                	mov    %eax,%eax
  8039be:	48 01 d0             	add    %rdx,%rax
  8039c1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8039c5:	8b 12                	mov    (%rdx),%edx
  8039c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8039ca:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8039ce:	89 0a                	mov    %ecx,(%rdx)
  8039d0:	eb 17                	jmp    8039e9 <getint+0x5b>
  8039d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039d6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8039da:	48 89 d0             	mov    %rdx,%rax
  8039dd:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8039e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8039e5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8039e9:	48 8b 00             	mov    (%rax),%rax
  8039ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8039f0:	e9 a3 00 00 00       	jmpq   803a98 <getint+0x10a>
  8039f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8039f9:	74 4f                	je     803a4a <getint+0xbc>
  8039fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039ff:	8b 00                	mov    (%rax),%eax
  803a01:	83 f8 30             	cmp    $0x30,%eax
  803a04:	73 24                	jae    803a2a <getint+0x9c>
  803a06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a0a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  803a0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a12:	8b 00                	mov    (%rax),%eax
  803a14:	89 c0                	mov    %eax,%eax
  803a16:	48 01 d0             	add    %rdx,%rax
  803a19:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a1d:	8b 12                	mov    (%rdx),%edx
  803a1f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803a22:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a26:	89 0a                	mov    %ecx,(%rdx)
  803a28:	eb 17                	jmp    803a41 <getint+0xb3>
  803a2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a2e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  803a32:	48 89 d0             	mov    %rdx,%rax
  803a35:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803a39:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a3d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  803a41:	48 8b 00             	mov    (%rax),%rax
  803a44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803a48:	eb 4e                	jmp    803a98 <getint+0x10a>
  803a4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a4e:	8b 00                	mov    (%rax),%eax
  803a50:	83 f8 30             	cmp    $0x30,%eax
  803a53:	73 24                	jae    803a79 <getint+0xeb>
  803a55:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a59:	48 8b 50 10          	mov    0x10(%rax),%rdx
  803a5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a61:	8b 00                	mov    (%rax),%eax
  803a63:	89 c0                	mov    %eax,%eax
  803a65:	48 01 d0             	add    %rdx,%rax
  803a68:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a6c:	8b 12                	mov    (%rdx),%edx
  803a6e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803a71:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a75:	89 0a                	mov    %ecx,(%rdx)
  803a77:	eb 17                	jmp    803a90 <getint+0x102>
  803a79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a7d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  803a81:	48 89 d0             	mov    %rdx,%rax
  803a84:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803a88:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a8c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  803a90:	8b 00                	mov    (%rax),%eax
  803a92:	48 98                	cltq   
  803a94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a9c:	c9                   	leaveq 
  803a9d:	c3                   	retq   

0000000000803a9e <vprintfmt>:
  803a9e:	55                   	push   %rbp
  803a9f:	48 89 e5             	mov    %rsp,%rbp
  803aa2:	41 54                	push   %r12
  803aa4:	53                   	push   %rbx
  803aa5:	48 83 ec 60          	sub    $0x60,%rsp
  803aa9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  803aad:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  803ab1:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  803ab5:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  803ab9:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803abd:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  803ac1:	48 8b 0a             	mov    (%rdx),%rcx
  803ac4:	48 89 08             	mov    %rcx,(%rax)
  803ac7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  803acb:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803acf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803ad3:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803ad7:	eb 17                	jmp    803af0 <vprintfmt+0x52>
  803ad9:	85 db                	test   %ebx,%ebx
  803adb:	0f 84 cc 04 00 00    	je     803fad <vprintfmt+0x50f>
  803ae1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803ae5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803ae9:	48 89 d6             	mov    %rdx,%rsi
  803aec:	89 df                	mov    %ebx,%edi
  803aee:	ff d0                	callq  *%rax
  803af0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803af4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803af8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  803afc:	0f b6 00             	movzbl (%rax),%eax
  803aff:	0f b6 d8             	movzbl %al,%ebx
  803b02:	83 fb 25             	cmp    $0x25,%ebx
  803b05:	75 d2                	jne    803ad9 <vprintfmt+0x3b>
  803b07:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  803b0b:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  803b12:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  803b19:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  803b20:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  803b27:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803b2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803b2f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  803b33:	0f b6 00             	movzbl (%rax),%eax
  803b36:	0f b6 d8             	movzbl %al,%ebx
  803b39:	8d 43 dd             	lea    -0x23(%rbx),%eax
  803b3c:	83 f8 55             	cmp    $0x55,%eax
  803b3f:	0f 87 34 04 00 00    	ja     803f79 <vprintfmt+0x4db>
  803b45:	89 c0                	mov    %eax,%eax
  803b47:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803b4e:	00 
  803b4f:	48 b8 f8 7c 80 00 00 	movabs $0x807cf8,%rax
  803b56:	00 00 00 
  803b59:	48 01 d0             	add    %rdx,%rax
  803b5c:	48 8b 00             	mov    (%rax),%rax
  803b5f:	ff e0                	jmpq   *%rax
  803b61:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  803b65:	eb c0                	jmp    803b27 <vprintfmt+0x89>
  803b67:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  803b6b:	eb ba                	jmp    803b27 <vprintfmt+0x89>
  803b6d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  803b74:	8b 55 d8             	mov    -0x28(%rbp),%edx
  803b77:	89 d0                	mov    %edx,%eax
  803b79:	c1 e0 02             	shl    $0x2,%eax
  803b7c:	01 d0                	add    %edx,%eax
  803b7e:	01 c0                	add    %eax,%eax
  803b80:	01 d8                	add    %ebx,%eax
  803b82:	83 e8 30             	sub    $0x30,%eax
  803b85:	89 45 d8             	mov    %eax,-0x28(%rbp)
  803b88:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803b8c:	0f b6 00             	movzbl (%rax),%eax
  803b8f:	0f be d8             	movsbl %al,%ebx
  803b92:	83 fb 2f             	cmp    $0x2f,%ebx
  803b95:	7e 0c                	jle    803ba3 <vprintfmt+0x105>
  803b97:	83 fb 39             	cmp    $0x39,%ebx
  803b9a:	7f 07                	jg     803ba3 <vprintfmt+0x105>
  803b9c:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  803ba1:	eb d1                	jmp    803b74 <vprintfmt+0xd6>
  803ba3:	eb 58                	jmp    803bfd <vprintfmt+0x15f>
  803ba5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803ba8:	83 f8 30             	cmp    $0x30,%eax
  803bab:	73 17                	jae    803bc4 <vprintfmt+0x126>
  803bad:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803bb1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803bb4:	89 c0                	mov    %eax,%eax
  803bb6:	48 01 d0             	add    %rdx,%rax
  803bb9:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803bbc:	83 c2 08             	add    $0x8,%edx
  803bbf:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803bc2:	eb 0f                	jmp    803bd3 <vprintfmt+0x135>
  803bc4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803bc8:	48 89 d0             	mov    %rdx,%rax
  803bcb:	48 83 c2 08          	add    $0x8,%rdx
  803bcf:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803bd3:	8b 00                	mov    (%rax),%eax
  803bd5:	89 45 d8             	mov    %eax,-0x28(%rbp)
  803bd8:	eb 23                	jmp    803bfd <vprintfmt+0x15f>
  803bda:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803bde:	79 0c                	jns    803bec <vprintfmt+0x14e>
  803be0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  803be7:	e9 3b ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803bec:	e9 36 ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803bf1:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  803bf8:	e9 2a ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803bfd:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803c01:	79 12                	jns    803c15 <vprintfmt+0x177>
  803c03:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803c06:	89 45 dc             	mov    %eax,-0x24(%rbp)
  803c09:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  803c10:	e9 12 ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803c15:	e9 0d ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803c1a:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  803c1e:	e9 04 ff ff ff       	jmpq   803b27 <vprintfmt+0x89>
  803c23:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803c26:	83 f8 30             	cmp    $0x30,%eax
  803c29:	73 17                	jae    803c42 <vprintfmt+0x1a4>
  803c2b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803c2f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803c32:	89 c0                	mov    %eax,%eax
  803c34:	48 01 d0             	add    %rdx,%rax
  803c37:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803c3a:	83 c2 08             	add    $0x8,%edx
  803c3d:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803c40:	eb 0f                	jmp    803c51 <vprintfmt+0x1b3>
  803c42:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803c46:	48 89 d0             	mov    %rdx,%rax
  803c49:	48 83 c2 08          	add    $0x8,%rdx
  803c4d:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803c51:	8b 10                	mov    (%rax),%edx
  803c53:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  803c57:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803c5b:	48 89 ce             	mov    %rcx,%rsi
  803c5e:	89 d7                	mov    %edx,%edi
  803c60:	ff d0                	callq  *%rax
  803c62:	e9 40 03 00 00       	jmpq   803fa7 <vprintfmt+0x509>
  803c67:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803c6a:	83 f8 30             	cmp    $0x30,%eax
  803c6d:	73 17                	jae    803c86 <vprintfmt+0x1e8>
  803c6f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803c73:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803c76:	89 c0                	mov    %eax,%eax
  803c78:	48 01 d0             	add    %rdx,%rax
  803c7b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803c7e:	83 c2 08             	add    $0x8,%edx
  803c81:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803c84:	eb 0f                	jmp    803c95 <vprintfmt+0x1f7>
  803c86:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803c8a:	48 89 d0             	mov    %rdx,%rax
  803c8d:	48 83 c2 08          	add    $0x8,%rdx
  803c91:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803c95:	8b 18                	mov    (%rax),%ebx
  803c97:	85 db                	test   %ebx,%ebx
  803c99:	79 02                	jns    803c9d <vprintfmt+0x1ff>
  803c9b:	f7 db                	neg    %ebx
  803c9d:	83 fb 15             	cmp    $0x15,%ebx
  803ca0:	7f 16                	jg     803cb8 <vprintfmt+0x21a>
  803ca2:	48 b8 20 7c 80 00 00 	movabs $0x807c20,%rax
  803ca9:	00 00 00 
  803cac:	48 63 d3             	movslq %ebx,%rdx
  803caf:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  803cb3:	4d 85 e4             	test   %r12,%r12
  803cb6:	75 2e                	jne    803ce6 <vprintfmt+0x248>
  803cb8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803cbc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803cc0:	89 d9                	mov    %ebx,%ecx
  803cc2:	48 ba e1 7c 80 00 00 	movabs $0x807ce1,%rdx
  803cc9:	00 00 00 
  803ccc:	48 89 c7             	mov    %rax,%rdi
  803ccf:	b8 00 00 00 00       	mov    $0x0,%eax
  803cd4:	49 b8 b6 3f 80 00 00 	movabs $0x803fb6,%r8
  803cdb:	00 00 00 
  803cde:	41 ff d0             	callq  *%r8
  803ce1:	e9 c1 02 00 00       	jmpq   803fa7 <vprintfmt+0x509>
  803ce6:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803cea:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803cee:	4c 89 e1             	mov    %r12,%rcx
  803cf1:	48 ba ea 7c 80 00 00 	movabs $0x807cea,%rdx
  803cf8:	00 00 00 
  803cfb:	48 89 c7             	mov    %rax,%rdi
  803cfe:	b8 00 00 00 00       	mov    $0x0,%eax
  803d03:	49 b8 b6 3f 80 00 00 	movabs $0x803fb6,%r8
  803d0a:	00 00 00 
  803d0d:	41 ff d0             	callq  *%r8
  803d10:	e9 92 02 00 00       	jmpq   803fa7 <vprintfmt+0x509>
  803d15:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803d18:	83 f8 30             	cmp    $0x30,%eax
  803d1b:	73 17                	jae    803d34 <vprintfmt+0x296>
  803d1d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803d21:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803d24:	89 c0                	mov    %eax,%eax
  803d26:	48 01 d0             	add    %rdx,%rax
  803d29:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803d2c:	83 c2 08             	add    $0x8,%edx
  803d2f:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803d32:	eb 0f                	jmp    803d43 <vprintfmt+0x2a5>
  803d34:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803d38:	48 89 d0             	mov    %rdx,%rax
  803d3b:	48 83 c2 08          	add    $0x8,%rdx
  803d3f:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803d43:	4c 8b 20             	mov    (%rax),%r12
  803d46:	4d 85 e4             	test   %r12,%r12
  803d49:	75 0a                	jne    803d55 <vprintfmt+0x2b7>
  803d4b:	49 bc ed 7c 80 00 00 	movabs $0x807ced,%r12
  803d52:	00 00 00 
  803d55:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803d59:	7e 3f                	jle    803d9a <vprintfmt+0x2fc>
  803d5b:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  803d5f:	74 39                	je     803d9a <vprintfmt+0x2fc>
  803d61:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803d64:	48 98                	cltq   
  803d66:	48 89 c6             	mov    %rax,%rsi
  803d69:	4c 89 e7             	mov    %r12,%rdi
  803d6c:	48 b8 62 42 80 00 00 	movabs $0x804262,%rax
  803d73:	00 00 00 
  803d76:	ff d0                	callq  *%rax
  803d78:	29 45 dc             	sub    %eax,-0x24(%rbp)
  803d7b:	eb 17                	jmp    803d94 <vprintfmt+0x2f6>
  803d7d:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  803d81:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  803d85:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803d89:	48 89 ce             	mov    %rcx,%rsi
  803d8c:	89 d7                	mov    %edx,%edi
  803d8e:	ff d0                	callq  *%rax
  803d90:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803d94:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803d98:	7f e3                	jg     803d7d <vprintfmt+0x2df>
  803d9a:	eb 37                	jmp    803dd3 <vprintfmt+0x335>
  803d9c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  803da0:	74 1e                	je     803dc0 <vprintfmt+0x322>
  803da2:	83 fb 1f             	cmp    $0x1f,%ebx
  803da5:	7e 05                	jle    803dac <vprintfmt+0x30e>
  803da7:	83 fb 7e             	cmp    $0x7e,%ebx
  803daa:	7e 14                	jle    803dc0 <vprintfmt+0x322>
  803dac:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803db0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803db4:	48 89 d6             	mov    %rdx,%rsi
  803db7:	bf 3f 00 00 00       	mov    $0x3f,%edi
  803dbc:	ff d0                	callq  *%rax
  803dbe:	eb 0f                	jmp    803dcf <vprintfmt+0x331>
  803dc0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803dc4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803dc8:	48 89 d6             	mov    %rdx,%rsi
  803dcb:	89 df                	mov    %ebx,%edi
  803dcd:	ff d0                	callq  *%rax
  803dcf:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803dd3:	4c 89 e0             	mov    %r12,%rax
  803dd6:	4c 8d 60 01          	lea    0x1(%rax),%r12
  803dda:	0f b6 00             	movzbl (%rax),%eax
  803ddd:	0f be d8             	movsbl %al,%ebx
  803de0:	85 db                	test   %ebx,%ebx
  803de2:	74 10                	je     803df4 <vprintfmt+0x356>
  803de4:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  803de8:	78 b2                	js     803d9c <vprintfmt+0x2fe>
  803dea:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  803dee:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  803df2:	79 a8                	jns    803d9c <vprintfmt+0x2fe>
  803df4:	eb 16                	jmp    803e0c <vprintfmt+0x36e>
  803df6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803dfa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803dfe:	48 89 d6             	mov    %rdx,%rsi
  803e01:	bf 20 00 00 00       	mov    $0x20,%edi
  803e06:	ff d0                	callq  *%rax
  803e08:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803e0c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803e10:	7f e4                	jg     803df6 <vprintfmt+0x358>
  803e12:	e9 90 01 00 00       	jmpq   803fa7 <vprintfmt+0x509>
  803e17:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803e1b:	be 03 00 00 00       	mov    $0x3,%esi
  803e20:	48 89 c7             	mov    %rax,%rdi
  803e23:	48 b8 8e 39 80 00 00 	movabs $0x80398e,%rax
  803e2a:	00 00 00 
  803e2d:	ff d0                	callq  *%rax
  803e2f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803e33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803e37:	48 85 c0             	test   %rax,%rax
  803e3a:	79 1d                	jns    803e59 <vprintfmt+0x3bb>
  803e3c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803e40:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803e44:	48 89 d6             	mov    %rdx,%rsi
  803e47:	bf 2d 00 00 00       	mov    $0x2d,%edi
  803e4c:	ff d0                	callq  *%rax
  803e4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803e52:	48 f7 d8             	neg    %rax
  803e55:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803e59:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  803e60:	e9 d5 00 00 00       	jmpq   803f3a <vprintfmt+0x49c>
  803e65:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803e69:	be 03 00 00 00       	mov    $0x3,%esi
  803e6e:	48 89 c7             	mov    %rax,%rdi
  803e71:	48 b8 7e 38 80 00 00 	movabs $0x80387e,%rax
  803e78:	00 00 00 
  803e7b:	ff d0                	callq  *%rax
  803e7d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803e81:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  803e88:	e9 ad 00 00 00       	jmpq   803f3a <vprintfmt+0x49c>
  803e8d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803e91:	be 03 00 00 00       	mov    $0x3,%esi
  803e96:	48 89 c7             	mov    %rax,%rdi
  803e99:	48 b8 7e 38 80 00 00 	movabs $0x80387e,%rax
  803ea0:	00 00 00 
  803ea3:	ff d0                	callq  *%rax
  803ea5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803ea9:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  803eb0:	e9 85 00 00 00       	jmpq   803f3a <vprintfmt+0x49c>
  803eb5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803eb9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803ebd:	48 89 d6             	mov    %rdx,%rsi
  803ec0:	bf 30 00 00 00       	mov    $0x30,%edi
  803ec5:	ff d0                	callq  *%rax
  803ec7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803ecb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803ecf:	48 89 d6             	mov    %rdx,%rsi
  803ed2:	bf 78 00 00 00       	mov    $0x78,%edi
  803ed7:	ff d0                	callq  *%rax
  803ed9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803edc:	83 f8 30             	cmp    $0x30,%eax
  803edf:	73 17                	jae    803ef8 <vprintfmt+0x45a>
  803ee1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803ee5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803ee8:	89 c0                	mov    %eax,%eax
  803eea:	48 01 d0             	add    %rdx,%rax
  803eed:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803ef0:	83 c2 08             	add    $0x8,%edx
  803ef3:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803ef6:	eb 0f                	jmp    803f07 <vprintfmt+0x469>
  803ef8:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803efc:	48 89 d0             	mov    %rdx,%rax
  803eff:	48 83 c2 08          	add    $0x8,%rdx
  803f03:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803f07:	48 8b 00             	mov    (%rax),%rax
  803f0a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803f0e:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  803f15:	eb 23                	jmp    803f3a <vprintfmt+0x49c>
  803f17:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803f1b:	be 03 00 00 00       	mov    $0x3,%esi
  803f20:	48 89 c7             	mov    %rax,%rdi
  803f23:	48 b8 7e 38 80 00 00 	movabs $0x80387e,%rax
  803f2a:	00 00 00 
  803f2d:	ff d0                	callq  *%rax
  803f2f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803f33:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  803f3a:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  803f3f:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  803f42:	8b 7d dc             	mov    -0x24(%rbp),%edi
  803f45:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803f49:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803f4d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803f51:	45 89 c1             	mov    %r8d,%r9d
  803f54:	41 89 f8             	mov    %edi,%r8d
  803f57:	48 89 c7             	mov    %rax,%rdi
  803f5a:	48 b8 c3 37 80 00 00 	movabs $0x8037c3,%rax
  803f61:	00 00 00 
  803f64:	ff d0                	callq  *%rax
  803f66:	eb 3f                	jmp    803fa7 <vprintfmt+0x509>
  803f68:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803f6c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803f70:	48 89 d6             	mov    %rdx,%rsi
  803f73:	89 df                	mov    %ebx,%edi
  803f75:	ff d0                	callq  *%rax
  803f77:	eb 2e                	jmp    803fa7 <vprintfmt+0x509>
  803f79:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803f7d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803f81:	48 89 d6             	mov    %rdx,%rsi
  803f84:	bf 25 00 00 00       	mov    $0x25,%edi
  803f89:	ff d0                	callq  *%rax
  803f8b:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  803f90:	eb 05                	jmp    803f97 <vprintfmt+0x4f9>
  803f92:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  803f97:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803f9b:	48 83 e8 01          	sub    $0x1,%rax
  803f9f:	0f b6 00             	movzbl (%rax),%eax
  803fa2:	3c 25                	cmp    $0x25,%al
  803fa4:	75 ec                	jne    803f92 <vprintfmt+0x4f4>
  803fa6:	90                   	nop
  803fa7:	90                   	nop
  803fa8:	e9 43 fb ff ff       	jmpq   803af0 <vprintfmt+0x52>
  803fad:	48 83 c4 60          	add    $0x60,%rsp
  803fb1:	5b                   	pop    %rbx
  803fb2:	41 5c                	pop    %r12
  803fb4:	5d                   	pop    %rbp
  803fb5:	c3                   	retq   

0000000000803fb6 <printfmt>:
  803fb6:	55                   	push   %rbp
  803fb7:	48 89 e5             	mov    %rsp,%rbp
  803fba:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  803fc1:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  803fc8:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  803fcf:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803fd6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803fdd:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803fe4:	84 c0                	test   %al,%al
  803fe6:	74 20                	je     804008 <printfmt+0x52>
  803fe8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803fec:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803ff0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803ff4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803ff8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803ffc:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  804000:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  804004:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  804008:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80400f:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  804016:	00 00 00 
  804019:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  804020:	00 00 00 
  804023:	48 8d 45 10          	lea    0x10(%rbp),%rax
  804027:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80402e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  804035:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80403c:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  804043:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80404a:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  804051:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  804058:	48 89 c7             	mov    %rax,%rdi
  80405b:	48 b8 9e 3a 80 00 00 	movabs $0x803a9e,%rax
  804062:	00 00 00 
  804065:	ff d0                	callq  *%rax
  804067:	c9                   	leaveq 
  804068:	c3                   	retq   

0000000000804069 <sprintputch>:
  804069:	55                   	push   %rbp
  80406a:	48 89 e5             	mov    %rsp,%rbp
  80406d:	48 83 ec 10          	sub    $0x10,%rsp
  804071:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804074:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804078:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80407c:	8b 40 10             	mov    0x10(%rax),%eax
  80407f:	8d 50 01             	lea    0x1(%rax),%edx
  804082:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804086:	89 50 10             	mov    %edx,0x10(%rax)
  804089:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80408d:	48 8b 10             	mov    (%rax),%rdx
  804090:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804094:	48 8b 40 08          	mov    0x8(%rax),%rax
  804098:	48 39 c2             	cmp    %rax,%rdx
  80409b:	73 17                	jae    8040b4 <sprintputch+0x4b>
  80409d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040a1:	48 8b 00             	mov    (%rax),%rax
  8040a4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  8040a8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8040ac:	48 89 0a             	mov    %rcx,(%rdx)
  8040af:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8040b2:	88 10                	mov    %dl,(%rax)
  8040b4:	c9                   	leaveq 
  8040b5:	c3                   	retq   

00000000008040b6 <vsnprintf>:
  8040b6:	55                   	push   %rbp
  8040b7:	48 89 e5             	mov    %rsp,%rbp
  8040ba:	48 83 ec 50          	sub    $0x50,%rsp
  8040be:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8040c2:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  8040c5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8040c9:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  8040cd:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  8040d1:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  8040d5:	48 8b 0a             	mov    (%rdx),%rcx
  8040d8:	48 89 08             	mov    %rcx,(%rax)
  8040db:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8040df:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8040e3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8040e7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8040eb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8040ef:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8040f3:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  8040f6:	48 98                	cltq   
  8040f8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8040fc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804100:	48 01 d0             	add    %rdx,%rax
  804103:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  804107:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80410e:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  804113:	74 06                	je     80411b <vsnprintf+0x65>
  804115:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  804119:	7f 07                	jg     804122 <vsnprintf+0x6c>
  80411b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  804120:	eb 2f                	jmp    804151 <vsnprintf+0x9b>
  804122:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  804126:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  80412a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80412e:	48 89 c6             	mov    %rax,%rsi
  804131:	48 bf 69 40 80 00 00 	movabs $0x804069,%rdi
  804138:	00 00 00 
  80413b:	48 b8 9e 3a 80 00 00 	movabs $0x803a9e,%rax
  804142:	00 00 00 
  804145:	ff d0                	callq  *%rax
  804147:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80414b:	c6 00 00             	movb   $0x0,(%rax)
  80414e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  804151:	c9                   	leaveq 
  804152:	c3                   	retq   

0000000000804153 <snprintf>:
  804153:	55                   	push   %rbp
  804154:	48 89 e5             	mov    %rsp,%rbp
  804157:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  80415e:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  804165:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  80416b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  804172:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  804179:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  804180:	84 c0                	test   %al,%al
  804182:	74 20                	je     8041a4 <snprintf+0x51>
  804184:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  804188:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80418c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  804190:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  804194:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  804198:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80419c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8041a0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8041a4:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8041ab:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8041b2:	00 00 00 
  8041b5:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8041bc:	00 00 00 
  8041bf:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8041c3:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8041ca:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8041d1:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8041d8:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8041df:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8041e6:	48 8b 0a             	mov    (%rdx),%rcx
  8041e9:	48 89 08             	mov    %rcx,(%rax)
  8041ec:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8041f0:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8041f4:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8041f8:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8041fc:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  804203:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  80420a:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  804210:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  804217:	48 89 c7             	mov    %rax,%rdi
  80421a:	48 b8 b6 40 80 00 00 	movabs $0x8040b6,%rax
  804221:	00 00 00 
  804224:	ff d0                	callq  *%rax
  804226:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80422c:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  804232:	c9                   	leaveq 
  804233:	c3                   	retq   

0000000000804234 <strlen>:
  804234:	55                   	push   %rbp
  804235:	48 89 e5             	mov    %rsp,%rbp
  804238:	48 83 ec 18          	sub    $0x18,%rsp
  80423c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804240:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804247:	eb 09                	jmp    804252 <strlen+0x1e>
  804249:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80424d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  804252:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804256:	0f b6 00             	movzbl (%rax),%eax
  804259:	84 c0                	test   %al,%al
  80425b:	75 ec                	jne    804249 <strlen+0x15>
  80425d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804260:	c9                   	leaveq 
  804261:	c3                   	retq   

0000000000804262 <strnlen>:
  804262:	55                   	push   %rbp
  804263:	48 89 e5             	mov    %rsp,%rbp
  804266:	48 83 ec 20          	sub    $0x20,%rsp
  80426a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80426e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804272:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804279:	eb 0e                	jmp    804289 <strnlen+0x27>
  80427b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80427f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  804284:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  804289:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80428e:	74 0b                	je     80429b <strnlen+0x39>
  804290:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804294:	0f b6 00             	movzbl (%rax),%eax
  804297:	84 c0                	test   %al,%al
  804299:	75 e0                	jne    80427b <strnlen+0x19>
  80429b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80429e:	c9                   	leaveq 
  80429f:	c3                   	retq   

00000000008042a0 <strcpy>:
  8042a0:	55                   	push   %rbp
  8042a1:	48 89 e5             	mov    %rsp,%rbp
  8042a4:	48 83 ec 20          	sub    $0x20,%rsp
  8042a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8042ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8042b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8042b8:	90                   	nop
  8042b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042bd:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8042c1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8042c5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8042c9:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8042cd:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8042d1:	0f b6 12             	movzbl (%rdx),%edx
  8042d4:	88 10                	mov    %dl,(%rax)
  8042d6:	0f b6 00             	movzbl (%rax),%eax
  8042d9:	84 c0                	test   %al,%al
  8042db:	75 dc                	jne    8042b9 <strcpy+0x19>
  8042dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042e1:	c9                   	leaveq 
  8042e2:	c3                   	retq   

00000000008042e3 <strcat>:
  8042e3:	55                   	push   %rbp
  8042e4:	48 89 e5             	mov    %rsp,%rbp
  8042e7:	48 83 ec 20          	sub    $0x20,%rsp
  8042eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8042ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8042f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042f7:	48 89 c7             	mov    %rax,%rdi
  8042fa:	48 b8 34 42 80 00 00 	movabs $0x804234,%rax
  804301:	00 00 00 
  804304:	ff d0                	callq  *%rax
  804306:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804309:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80430c:	48 63 d0             	movslq %eax,%rdx
  80430f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804313:	48 01 c2             	add    %rax,%rdx
  804316:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80431a:	48 89 c6             	mov    %rax,%rsi
  80431d:	48 89 d7             	mov    %rdx,%rdi
  804320:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  804327:	00 00 00 
  80432a:	ff d0                	callq  *%rax
  80432c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804330:	c9                   	leaveq 
  804331:	c3                   	retq   

0000000000804332 <strncpy>:
  804332:	55                   	push   %rbp
  804333:	48 89 e5             	mov    %rsp,%rbp
  804336:	48 83 ec 28          	sub    $0x28,%rsp
  80433a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80433e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804342:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804346:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80434a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80434e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804355:	00 
  804356:	eb 2a                	jmp    804382 <strncpy+0x50>
  804358:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80435c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  804360:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  804364:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804368:	0f b6 12             	movzbl (%rdx),%edx
  80436b:	88 10                	mov    %dl,(%rax)
  80436d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804371:	0f b6 00             	movzbl (%rax),%eax
  804374:	84 c0                	test   %al,%al
  804376:	74 05                	je     80437d <strncpy+0x4b>
  804378:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80437d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804382:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804386:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80438a:	72 cc                	jb     804358 <strncpy+0x26>
  80438c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804390:	c9                   	leaveq 
  804391:	c3                   	retq   

0000000000804392 <strlcpy>:
  804392:	55                   	push   %rbp
  804393:	48 89 e5             	mov    %rsp,%rbp
  804396:	48 83 ec 28          	sub    $0x28,%rsp
  80439a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80439e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8043a2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8043a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8043aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8043ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8043b3:	74 3d                	je     8043f2 <strlcpy+0x60>
  8043b5:	eb 1d                	jmp    8043d4 <strlcpy+0x42>
  8043b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8043bb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8043bf:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8043c3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8043c7:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8043cb:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8043cf:	0f b6 12             	movzbl (%rdx),%edx
  8043d2:	88 10                	mov    %dl,(%rax)
  8043d4:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8043d9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8043de:	74 0b                	je     8043eb <strlcpy+0x59>
  8043e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8043e4:	0f b6 00             	movzbl (%rax),%eax
  8043e7:	84 c0                	test   %al,%al
  8043e9:	75 cc                	jne    8043b7 <strlcpy+0x25>
  8043eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8043ef:	c6 00 00             	movb   $0x0,(%rax)
  8043f2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8043f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043fa:	48 29 c2             	sub    %rax,%rdx
  8043fd:	48 89 d0             	mov    %rdx,%rax
  804400:	c9                   	leaveq 
  804401:	c3                   	retq   

0000000000804402 <strcmp>:
  804402:	55                   	push   %rbp
  804403:	48 89 e5             	mov    %rsp,%rbp
  804406:	48 83 ec 10          	sub    $0x10,%rsp
  80440a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80440e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804412:	eb 0a                	jmp    80441e <strcmp+0x1c>
  804414:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804419:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80441e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804422:	0f b6 00             	movzbl (%rax),%eax
  804425:	84 c0                	test   %al,%al
  804427:	74 12                	je     80443b <strcmp+0x39>
  804429:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80442d:	0f b6 10             	movzbl (%rax),%edx
  804430:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804434:	0f b6 00             	movzbl (%rax),%eax
  804437:	38 c2                	cmp    %al,%dl
  804439:	74 d9                	je     804414 <strcmp+0x12>
  80443b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80443f:	0f b6 00             	movzbl (%rax),%eax
  804442:	0f b6 d0             	movzbl %al,%edx
  804445:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804449:	0f b6 00             	movzbl (%rax),%eax
  80444c:	0f b6 c0             	movzbl %al,%eax
  80444f:	29 c2                	sub    %eax,%edx
  804451:	89 d0                	mov    %edx,%eax
  804453:	c9                   	leaveq 
  804454:	c3                   	retq   

0000000000804455 <strncmp>:
  804455:	55                   	push   %rbp
  804456:	48 89 e5             	mov    %rsp,%rbp
  804459:	48 83 ec 18          	sub    $0x18,%rsp
  80445d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804461:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804465:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  804469:	eb 0f                	jmp    80447a <strncmp+0x25>
  80446b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  804470:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804475:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80447a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80447f:	74 1d                	je     80449e <strncmp+0x49>
  804481:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804485:	0f b6 00             	movzbl (%rax),%eax
  804488:	84 c0                	test   %al,%al
  80448a:	74 12                	je     80449e <strncmp+0x49>
  80448c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804490:	0f b6 10             	movzbl (%rax),%edx
  804493:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804497:	0f b6 00             	movzbl (%rax),%eax
  80449a:	38 c2                	cmp    %al,%dl
  80449c:	74 cd                	je     80446b <strncmp+0x16>
  80449e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8044a3:	75 07                	jne    8044ac <strncmp+0x57>
  8044a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8044aa:	eb 18                	jmp    8044c4 <strncmp+0x6f>
  8044ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044b0:	0f b6 00             	movzbl (%rax),%eax
  8044b3:	0f b6 d0             	movzbl %al,%edx
  8044b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044ba:	0f b6 00             	movzbl (%rax),%eax
  8044bd:	0f b6 c0             	movzbl %al,%eax
  8044c0:	29 c2                	sub    %eax,%edx
  8044c2:	89 d0                	mov    %edx,%eax
  8044c4:	c9                   	leaveq 
  8044c5:	c3                   	retq   

00000000008044c6 <strchr>:
  8044c6:	55                   	push   %rbp
  8044c7:	48 89 e5             	mov    %rsp,%rbp
  8044ca:	48 83 ec 0c          	sub    $0xc,%rsp
  8044ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8044d2:	89 f0                	mov    %esi,%eax
  8044d4:	88 45 f4             	mov    %al,-0xc(%rbp)
  8044d7:	eb 17                	jmp    8044f0 <strchr+0x2a>
  8044d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044dd:	0f b6 00             	movzbl (%rax),%eax
  8044e0:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8044e3:	75 06                	jne    8044eb <strchr+0x25>
  8044e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044e9:	eb 15                	jmp    804500 <strchr+0x3a>
  8044eb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8044f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044f4:	0f b6 00             	movzbl (%rax),%eax
  8044f7:	84 c0                	test   %al,%al
  8044f9:	75 de                	jne    8044d9 <strchr+0x13>
  8044fb:	b8 00 00 00 00       	mov    $0x0,%eax
  804500:	c9                   	leaveq 
  804501:	c3                   	retq   

0000000000804502 <strfind>:
  804502:	55                   	push   %rbp
  804503:	48 89 e5             	mov    %rsp,%rbp
  804506:	48 83 ec 0c          	sub    $0xc,%rsp
  80450a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80450e:	89 f0                	mov    %esi,%eax
  804510:	88 45 f4             	mov    %al,-0xc(%rbp)
  804513:	eb 13                	jmp    804528 <strfind+0x26>
  804515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804519:	0f b6 00             	movzbl (%rax),%eax
  80451c:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80451f:	75 02                	jne    804523 <strfind+0x21>
  804521:	eb 10                	jmp    804533 <strfind+0x31>
  804523:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804528:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80452c:	0f b6 00             	movzbl (%rax),%eax
  80452f:	84 c0                	test   %al,%al
  804531:	75 e2                	jne    804515 <strfind+0x13>
  804533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804537:	c9                   	leaveq 
  804538:	c3                   	retq   

0000000000804539 <memset>:
  804539:	55                   	push   %rbp
  80453a:	48 89 e5             	mov    %rsp,%rbp
  80453d:	48 83 ec 18          	sub    $0x18,%rsp
  804541:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804545:	89 75 f4             	mov    %esi,-0xc(%rbp)
  804548:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80454c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804551:	75 06                	jne    804559 <memset+0x20>
  804553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804557:	eb 69                	jmp    8045c2 <memset+0x89>
  804559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80455d:	83 e0 03             	and    $0x3,%eax
  804560:	48 85 c0             	test   %rax,%rax
  804563:	75 48                	jne    8045ad <memset+0x74>
  804565:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804569:	83 e0 03             	and    $0x3,%eax
  80456c:	48 85 c0             	test   %rax,%rax
  80456f:	75 3c                	jne    8045ad <memset+0x74>
  804571:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  804578:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80457b:	c1 e0 18             	shl    $0x18,%eax
  80457e:	89 c2                	mov    %eax,%edx
  804580:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804583:	c1 e0 10             	shl    $0x10,%eax
  804586:	09 c2                	or     %eax,%edx
  804588:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80458b:	c1 e0 08             	shl    $0x8,%eax
  80458e:	09 d0                	or     %edx,%eax
  804590:	09 45 f4             	or     %eax,-0xc(%rbp)
  804593:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804597:	48 c1 e8 02          	shr    $0x2,%rax
  80459b:	48 89 c1             	mov    %rax,%rcx
  80459e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8045a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8045a5:	48 89 d7             	mov    %rdx,%rdi
  8045a8:	fc                   	cld    
  8045a9:	f3 ab                	rep stos %eax,%es:(%rdi)
  8045ab:	eb 11                	jmp    8045be <memset+0x85>
  8045ad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8045b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8045b4:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8045b8:	48 89 d7             	mov    %rdx,%rdi
  8045bb:	fc                   	cld    
  8045bc:	f3 aa                	rep stos %al,%es:(%rdi)
  8045be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045c2:	c9                   	leaveq 
  8045c3:	c3                   	retq   

00000000008045c4 <memmove>:
  8045c4:	55                   	push   %rbp
  8045c5:	48 89 e5             	mov    %rsp,%rbp
  8045c8:	48 83 ec 28          	sub    $0x28,%rsp
  8045cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8045d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8045d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8045d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8045dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8045e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8045e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8045e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045ec:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8045f0:	0f 83 88 00 00 00    	jae    80467e <memmove+0xba>
  8045f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8045fa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8045fe:	48 01 d0             	add    %rdx,%rax
  804601:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  804605:	76 77                	jbe    80467e <memmove+0xba>
  804607:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80460b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80460f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804613:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  804617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80461b:	83 e0 03             	and    $0x3,%eax
  80461e:	48 85 c0             	test   %rax,%rax
  804621:	75 3b                	jne    80465e <memmove+0x9a>
  804623:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804627:	83 e0 03             	and    $0x3,%eax
  80462a:	48 85 c0             	test   %rax,%rax
  80462d:	75 2f                	jne    80465e <memmove+0x9a>
  80462f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804633:	83 e0 03             	and    $0x3,%eax
  804636:	48 85 c0             	test   %rax,%rax
  804639:	75 23                	jne    80465e <memmove+0x9a>
  80463b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80463f:	48 83 e8 04          	sub    $0x4,%rax
  804643:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  804647:	48 83 ea 04          	sub    $0x4,%rdx
  80464b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80464f:	48 c1 e9 02          	shr    $0x2,%rcx
  804653:	48 89 c7             	mov    %rax,%rdi
  804656:	48 89 d6             	mov    %rdx,%rsi
  804659:	fd                   	std    
  80465a:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80465c:	eb 1d                	jmp    80467b <memmove+0xb7>
  80465e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804662:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  804666:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80466a:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  80466e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804672:	48 89 d7             	mov    %rdx,%rdi
  804675:	48 89 c1             	mov    %rax,%rcx
  804678:	fd                   	std    
  804679:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80467b:	fc                   	cld    
  80467c:	eb 57                	jmp    8046d5 <memmove+0x111>
  80467e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804682:	83 e0 03             	and    $0x3,%eax
  804685:	48 85 c0             	test   %rax,%rax
  804688:	75 36                	jne    8046c0 <memmove+0xfc>
  80468a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80468e:	83 e0 03             	and    $0x3,%eax
  804691:	48 85 c0             	test   %rax,%rax
  804694:	75 2a                	jne    8046c0 <memmove+0xfc>
  804696:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80469a:	83 e0 03             	and    $0x3,%eax
  80469d:	48 85 c0             	test   %rax,%rax
  8046a0:	75 1e                	jne    8046c0 <memmove+0xfc>
  8046a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8046a6:	48 c1 e8 02          	shr    $0x2,%rax
  8046aa:	48 89 c1             	mov    %rax,%rcx
  8046ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046b1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8046b5:	48 89 c7             	mov    %rax,%rdi
  8046b8:	48 89 d6             	mov    %rdx,%rsi
  8046bb:	fc                   	cld    
  8046bc:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8046be:	eb 15                	jmp    8046d5 <memmove+0x111>
  8046c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046c4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8046c8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8046cc:	48 89 c7             	mov    %rax,%rdi
  8046cf:	48 89 d6             	mov    %rdx,%rsi
  8046d2:	fc                   	cld    
  8046d3:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8046d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8046d9:	c9                   	leaveq 
  8046da:	c3                   	retq   

00000000008046db <memcpy>:
  8046db:	55                   	push   %rbp
  8046dc:	48 89 e5             	mov    %rsp,%rbp
  8046df:	48 83 ec 18          	sub    $0x18,%rsp
  8046e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8046e7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8046eb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8046ef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8046f3:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8046f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046fb:	48 89 ce             	mov    %rcx,%rsi
  8046fe:	48 89 c7             	mov    %rax,%rdi
  804701:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  804708:	00 00 00 
  80470b:	ff d0                	callq  *%rax
  80470d:	c9                   	leaveq 
  80470e:	c3                   	retq   

000000000080470f <memcmp>:
  80470f:	55                   	push   %rbp
  804710:	48 89 e5             	mov    %rsp,%rbp
  804713:	48 83 ec 28          	sub    $0x28,%rsp
  804717:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80471b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80471f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804723:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804727:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80472b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80472f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804733:	eb 36                	jmp    80476b <memcmp+0x5c>
  804735:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804739:	0f b6 10             	movzbl (%rax),%edx
  80473c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804740:	0f b6 00             	movzbl (%rax),%eax
  804743:	38 c2                	cmp    %al,%dl
  804745:	74 1a                	je     804761 <memcmp+0x52>
  804747:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80474b:	0f b6 00             	movzbl (%rax),%eax
  80474e:	0f b6 d0             	movzbl %al,%edx
  804751:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804755:	0f b6 00             	movzbl (%rax),%eax
  804758:	0f b6 c0             	movzbl %al,%eax
  80475b:	29 c2                	sub    %eax,%edx
  80475d:	89 d0                	mov    %edx,%eax
  80475f:	eb 20                	jmp    804781 <memcmp+0x72>
  804761:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804766:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80476b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80476f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  804773:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804777:	48 85 c0             	test   %rax,%rax
  80477a:	75 b9                	jne    804735 <memcmp+0x26>
  80477c:	b8 00 00 00 00       	mov    $0x0,%eax
  804781:	c9                   	leaveq 
  804782:	c3                   	retq   

0000000000804783 <memfind>:
  804783:	55                   	push   %rbp
  804784:	48 89 e5             	mov    %rsp,%rbp
  804787:	48 83 ec 28          	sub    $0x28,%rsp
  80478b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80478f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  804792:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804796:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80479a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80479e:	48 01 d0             	add    %rdx,%rax
  8047a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8047a5:	eb 15                	jmp    8047bc <memfind+0x39>
  8047a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047ab:	0f b6 10             	movzbl (%rax),%edx
  8047ae:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8047b1:	38 c2                	cmp    %al,%dl
  8047b3:	75 02                	jne    8047b7 <memfind+0x34>
  8047b5:	eb 0f                	jmp    8047c6 <memfind+0x43>
  8047b7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8047bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047c0:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8047c4:	72 e1                	jb     8047a7 <memfind+0x24>
  8047c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047ca:	c9                   	leaveq 
  8047cb:	c3                   	retq   

00000000008047cc <strtol>:
  8047cc:	55                   	push   %rbp
  8047cd:	48 89 e5             	mov    %rsp,%rbp
  8047d0:	48 83 ec 34          	sub    $0x34,%rsp
  8047d4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8047d8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8047dc:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8047df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8047e6:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8047ed:	00 
  8047ee:	eb 05                	jmp    8047f5 <strtol+0x29>
  8047f0:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8047f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047f9:	0f b6 00             	movzbl (%rax),%eax
  8047fc:	3c 20                	cmp    $0x20,%al
  8047fe:	74 f0                	je     8047f0 <strtol+0x24>
  804800:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804804:	0f b6 00             	movzbl (%rax),%eax
  804807:	3c 09                	cmp    $0x9,%al
  804809:	74 e5                	je     8047f0 <strtol+0x24>
  80480b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80480f:	0f b6 00             	movzbl (%rax),%eax
  804812:	3c 2b                	cmp    $0x2b,%al
  804814:	75 07                	jne    80481d <strtol+0x51>
  804816:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80481b:	eb 17                	jmp    804834 <strtol+0x68>
  80481d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804821:	0f b6 00             	movzbl (%rax),%eax
  804824:	3c 2d                	cmp    $0x2d,%al
  804826:	75 0c                	jne    804834 <strtol+0x68>
  804828:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80482d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  804834:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  804838:	74 06                	je     804840 <strtol+0x74>
  80483a:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  80483e:	75 28                	jne    804868 <strtol+0x9c>
  804840:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804844:	0f b6 00             	movzbl (%rax),%eax
  804847:	3c 30                	cmp    $0x30,%al
  804849:	75 1d                	jne    804868 <strtol+0x9c>
  80484b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80484f:	48 83 c0 01          	add    $0x1,%rax
  804853:	0f b6 00             	movzbl (%rax),%eax
  804856:	3c 78                	cmp    $0x78,%al
  804858:	75 0e                	jne    804868 <strtol+0x9c>
  80485a:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  80485f:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  804866:	eb 2c                	jmp    804894 <strtol+0xc8>
  804868:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80486c:	75 19                	jne    804887 <strtol+0xbb>
  80486e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804872:	0f b6 00             	movzbl (%rax),%eax
  804875:	3c 30                	cmp    $0x30,%al
  804877:	75 0e                	jne    804887 <strtol+0xbb>
  804879:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80487e:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  804885:	eb 0d                	jmp    804894 <strtol+0xc8>
  804887:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80488b:	75 07                	jne    804894 <strtol+0xc8>
  80488d:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  804894:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804898:	0f b6 00             	movzbl (%rax),%eax
  80489b:	3c 2f                	cmp    $0x2f,%al
  80489d:	7e 1d                	jle    8048bc <strtol+0xf0>
  80489f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048a3:	0f b6 00             	movzbl (%rax),%eax
  8048a6:	3c 39                	cmp    $0x39,%al
  8048a8:	7f 12                	jg     8048bc <strtol+0xf0>
  8048aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048ae:	0f b6 00             	movzbl (%rax),%eax
  8048b1:	0f be c0             	movsbl %al,%eax
  8048b4:	83 e8 30             	sub    $0x30,%eax
  8048b7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8048ba:	eb 4e                	jmp    80490a <strtol+0x13e>
  8048bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048c0:	0f b6 00             	movzbl (%rax),%eax
  8048c3:	3c 60                	cmp    $0x60,%al
  8048c5:	7e 1d                	jle    8048e4 <strtol+0x118>
  8048c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048cb:	0f b6 00             	movzbl (%rax),%eax
  8048ce:	3c 7a                	cmp    $0x7a,%al
  8048d0:	7f 12                	jg     8048e4 <strtol+0x118>
  8048d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048d6:	0f b6 00             	movzbl (%rax),%eax
  8048d9:	0f be c0             	movsbl %al,%eax
  8048dc:	83 e8 57             	sub    $0x57,%eax
  8048df:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8048e2:	eb 26                	jmp    80490a <strtol+0x13e>
  8048e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048e8:	0f b6 00             	movzbl (%rax),%eax
  8048eb:	3c 40                	cmp    $0x40,%al
  8048ed:	7e 48                	jle    804937 <strtol+0x16b>
  8048ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048f3:	0f b6 00             	movzbl (%rax),%eax
  8048f6:	3c 5a                	cmp    $0x5a,%al
  8048f8:	7f 3d                	jg     804937 <strtol+0x16b>
  8048fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8048fe:	0f b6 00             	movzbl (%rax),%eax
  804901:	0f be c0             	movsbl %al,%eax
  804904:	83 e8 37             	sub    $0x37,%eax
  804907:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80490a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80490d:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  804910:	7c 02                	jl     804914 <strtol+0x148>
  804912:	eb 23                	jmp    804937 <strtol+0x16b>
  804914:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  804919:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80491c:	48 98                	cltq   
  80491e:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  804923:	48 89 c2             	mov    %rax,%rdx
  804926:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804929:	48 98                	cltq   
  80492b:	48 01 d0             	add    %rdx,%rax
  80492e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804932:	e9 5d ff ff ff       	jmpq   804894 <strtol+0xc8>
  804937:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  80493c:	74 0b                	je     804949 <strtol+0x17d>
  80493e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804942:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  804946:	48 89 10             	mov    %rdx,(%rax)
  804949:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80494d:	74 09                	je     804958 <strtol+0x18c>
  80494f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804953:	48 f7 d8             	neg    %rax
  804956:	eb 04                	jmp    80495c <strtol+0x190>
  804958:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80495c:	c9                   	leaveq 
  80495d:	c3                   	retq   

000000000080495e <strstr>:
  80495e:	55                   	push   %rbp
  80495f:	48 89 e5             	mov    %rsp,%rbp
  804962:	48 83 ec 30          	sub    $0x30,%rsp
  804966:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80496a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80496e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804972:	48 8d 50 01          	lea    0x1(%rax),%rdx
  804976:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80497a:	0f b6 00             	movzbl (%rax),%eax
  80497d:	88 45 ff             	mov    %al,-0x1(%rbp)
  804980:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  804984:	75 06                	jne    80498c <strstr+0x2e>
  804986:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80498a:	eb 6b                	jmp    8049f7 <strstr+0x99>
  80498c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804990:	48 89 c7             	mov    %rax,%rdi
  804993:	48 b8 34 42 80 00 00 	movabs $0x804234,%rax
  80499a:	00 00 00 
  80499d:	ff d0                	callq  *%rax
  80499f:	48 98                	cltq   
  8049a1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8049a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049a9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8049ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8049b1:	0f b6 00             	movzbl (%rax),%eax
  8049b4:	88 45 ef             	mov    %al,-0x11(%rbp)
  8049b7:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8049bb:	75 07                	jne    8049c4 <strstr+0x66>
  8049bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8049c2:	eb 33                	jmp    8049f7 <strstr+0x99>
  8049c4:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8049c8:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8049cb:	75 d8                	jne    8049a5 <strstr+0x47>
  8049cd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8049d1:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8049d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049d9:	48 89 ce             	mov    %rcx,%rsi
  8049dc:	48 89 c7             	mov    %rax,%rdi
  8049df:	48 b8 55 44 80 00 00 	movabs $0x804455,%rax
  8049e6:	00 00 00 
  8049e9:	ff d0                	callq  *%rax
  8049eb:	85 c0                	test   %eax,%eax
  8049ed:	75 b6                	jne    8049a5 <strstr+0x47>
  8049ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049f3:	48 83 e8 01          	sub    $0x1,%rax
  8049f7:	c9                   	leaveq 
  8049f8:	c3                   	retq   

00000000008049f9 <syscall>:
  8049f9:	55                   	push   %rbp
  8049fa:	48 89 e5             	mov    %rsp,%rbp
  8049fd:	53                   	push   %rbx
  8049fe:	48 83 ec 48          	sub    $0x48,%rsp
  804a02:	89 7d dc             	mov    %edi,-0x24(%rbp)
  804a05:	89 75 d8             	mov    %esi,-0x28(%rbp)
  804a08:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  804a0c:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  804a10:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  804a14:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  804a18:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804a1b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  804a1f:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  804a23:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  804a27:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  804a2b:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  804a2f:	4c 89 c3             	mov    %r8,%rbx
  804a32:	cd 30                	int    $0x30
  804a34:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804a38:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  804a3c:	74 3e                	je     804a7c <syscall+0x83>
  804a3e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804a43:	7e 37                	jle    804a7c <syscall+0x83>
  804a45:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804a49:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804a4c:	49 89 d0             	mov    %rdx,%r8
  804a4f:	89 c1                	mov    %eax,%ecx
  804a51:	48 ba a8 7f 80 00 00 	movabs $0x807fa8,%rdx
  804a58:	00 00 00 
  804a5b:	be 24 00 00 00       	mov    $0x24,%esi
  804a60:	48 bf c5 7f 80 00 00 	movabs $0x807fc5,%rdi
  804a67:	00 00 00 
  804a6a:	b8 00 00 00 00       	mov    $0x0,%eax
  804a6f:	49 b9 b2 34 80 00 00 	movabs $0x8034b2,%r9
  804a76:	00 00 00 
  804a79:	41 ff d1             	callq  *%r9
  804a7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804a80:	48 83 c4 48          	add    $0x48,%rsp
  804a84:	5b                   	pop    %rbx
  804a85:	5d                   	pop    %rbp
  804a86:	c3                   	retq   

0000000000804a87 <sys_cputs>:
  804a87:	55                   	push   %rbp
  804a88:	48 89 e5             	mov    %rsp,%rbp
  804a8b:	48 83 ec 20          	sub    $0x20,%rsp
  804a8f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804a93:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804a97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a9b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804a9f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804aa6:	00 
  804aa7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804aad:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804ab3:	48 89 d1             	mov    %rdx,%rcx
  804ab6:	48 89 c2             	mov    %rax,%rdx
  804ab9:	be 00 00 00 00       	mov    $0x0,%esi
  804abe:	bf 00 00 00 00       	mov    $0x0,%edi
  804ac3:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804aca:	00 00 00 
  804acd:	ff d0                	callq  *%rax
  804acf:	c9                   	leaveq 
  804ad0:	c3                   	retq   

0000000000804ad1 <sys_cgetc>:
  804ad1:	55                   	push   %rbp
  804ad2:	48 89 e5             	mov    %rsp,%rbp
  804ad5:	48 83 ec 10          	sub    $0x10,%rsp
  804ad9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804ae0:	00 
  804ae1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804ae7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804aed:	b9 00 00 00 00       	mov    $0x0,%ecx
  804af2:	ba 00 00 00 00       	mov    $0x0,%edx
  804af7:	be 00 00 00 00       	mov    $0x0,%esi
  804afc:	bf 01 00 00 00       	mov    $0x1,%edi
  804b01:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804b08:	00 00 00 
  804b0b:	ff d0                	callq  *%rax
  804b0d:	c9                   	leaveq 
  804b0e:	c3                   	retq   

0000000000804b0f <sys_env_destroy>:
  804b0f:	55                   	push   %rbp
  804b10:	48 89 e5             	mov    %rsp,%rbp
  804b13:	48 83 ec 10          	sub    $0x10,%rsp
  804b17:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804b1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804b1d:	48 98                	cltq   
  804b1f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804b26:	00 
  804b27:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804b2d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804b33:	b9 00 00 00 00       	mov    $0x0,%ecx
  804b38:	48 89 c2             	mov    %rax,%rdx
  804b3b:	be 01 00 00 00       	mov    $0x1,%esi
  804b40:	bf 03 00 00 00       	mov    $0x3,%edi
  804b45:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804b4c:	00 00 00 
  804b4f:	ff d0                	callq  *%rax
  804b51:	c9                   	leaveq 
  804b52:	c3                   	retq   

0000000000804b53 <sys_getenvid>:
  804b53:	55                   	push   %rbp
  804b54:	48 89 e5             	mov    %rsp,%rbp
  804b57:	48 83 ec 10          	sub    $0x10,%rsp
  804b5b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804b62:	00 
  804b63:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804b69:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804b6f:	b9 00 00 00 00       	mov    $0x0,%ecx
  804b74:	ba 00 00 00 00       	mov    $0x0,%edx
  804b79:	be 00 00 00 00       	mov    $0x0,%esi
  804b7e:	bf 02 00 00 00       	mov    $0x2,%edi
  804b83:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804b8a:	00 00 00 
  804b8d:	ff d0                	callq  *%rax
  804b8f:	c9                   	leaveq 
  804b90:	c3                   	retq   

0000000000804b91 <sys_yield>:
  804b91:	55                   	push   %rbp
  804b92:	48 89 e5             	mov    %rsp,%rbp
  804b95:	48 83 ec 10          	sub    $0x10,%rsp
  804b99:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804ba0:	00 
  804ba1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804ba7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804bad:	b9 00 00 00 00       	mov    $0x0,%ecx
  804bb2:	ba 00 00 00 00       	mov    $0x0,%edx
  804bb7:	be 00 00 00 00       	mov    $0x0,%esi
  804bbc:	bf 0b 00 00 00       	mov    $0xb,%edi
  804bc1:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804bc8:	00 00 00 
  804bcb:	ff d0                	callq  *%rax
  804bcd:	c9                   	leaveq 
  804bce:	c3                   	retq   

0000000000804bcf <sys_page_alloc>:
  804bcf:	55                   	push   %rbp
  804bd0:	48 89 e5             	mov    %rsp,%rbp
  804bd3:	48 83 ec 20          	sub    $0x20,%rsp
  804bd7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804bda:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804bde:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804be1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804be4:	48 63 c8             	movslq %eax,%rcx
  804be7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804beb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804bee:	48 98                	cltq   
  804bf0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804bf7:	00 
  804bf8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804bfe:	49 89 c8             	mov    %rcx,%r8
  804c01:	48 89 d1             	mov    %rdx,%rcx
  804c04:	48 89 c2             	mov    %rax,%rdx
  804c07:	be 01 00 00 00       	mov    $0x1,%esi
  804c0c:	bf 04 00 00 00       	mov    $0x4,%edi
  804c11:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804c18:	00 00 00 
  804c1b:	ff d0                	callq  *%rax
  804c1d:	c9                   	leaveq 
  804c1e:	c3                   	retq   

0000000000804c1f <sys_page_map>:
  804c1f:	55                   	push   %rbp
  804c20:	48 89 e5             	mov    %rsp,%rbp
  804c23:	48 83 ec 30          	sub    $0x30,%rsp
  804c27:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804c2a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804c2e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804c31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  804c35:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  804c39:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804c3c:	48 63 c8             	movslq %eax,%rcx
  804c3f:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  804c43:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804c46:	48 63 f0             	movslq %eax,%rsi
  804c49:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804c4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804c50:	48 98                	cltq   
  804c52:	48 89 0c 24          	mov    %rcx,(%rsp)
  804c56:	49 89 f9             	mov    %rdi,%r9
  804c59:	49 89 f0             	mov    %rsi,%r8
  804c5c:	48 89 d1             	mov    %rdx,%rcx
  804c5f:	48 89 c2             	mov    %rax,%rdx
  804c62:	be 01 00 00 00       	mov    $0x1,%esi
  804c67:	bf 05 00 00 00       	mov    $0x5,%edi
  804c6c:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804c73:	00 00 00 
  804c76:	ff d0                	callq  *%rax
  804c78:	c9                   	leaveq 
  804c79:	c3                   	retq   

0000000000804c7a <sys_page_unmap>:
  804c7a:	55                   	push   %rbp
  804c7b:	48 89 e5             	mov    %rsp,%rbp
  804c7e:	48 83 ec 20          	sub    $0x20,%rsp
  804c82:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804c85:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804c89:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804c8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804c90:	48 98                	cltq   
  804c92:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804c99:	00 
  804c9a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804ca0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804ca6:	48 89 d1             	mov    %rdx,%rcx
  804ca9:	48 89 c2             	mov    %rax,%rdx
  804cac:	be 01 00 00 00       	mov    $0x1,%esi
  804cb1:	bf 06 00 00 00       	mov    $0x6,%edi
  804cb6:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804cbd:	00 00 00 
  804cc0:	ff d0                	callq  *%rax
  804cc2:	c9                   	leaveq 
  804cc3:	c3                   	retq   

0000000000804cc4 <sys_env_set_status>:
  804cc4:	55                   	push   %rbp
  804cc5:	48 89 e5             	mov    %rsp,%rbp
  804cc8:	48 83 ec 10          	sub    $0x10,%rsp
  804ccc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804ccf:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804cd2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804cd5:	48 63 d0             	movslq %eax,%rdx
  804cd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804cdb:	48 98                	cltq   
  804cdd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804ce4:	00 
  804ce5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804ceb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804cf1:	48 89 d1             	mov    %rdx,%rcx
  804cf4:	48 89 c2             	mov    %rax,%rdx
  804cf7:	be 01 00 00 00       	mov    $0x1,%esi
  804cfc:	bf 08 00 00 00       	mov    $0x8,%edi
  804d01:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804d08:	00 00 00 
  804d0b:	ff d0                	callq  *%rax
  804d0d:	c9                   	leaveq 
  804d0e:	c3                   	retq   

0000000000804d0f <sys_env_set_trapframe>:
  804d0f:	55                   	push   %rbp
  804d10:	48 89 e5             	mov    %rsp,%rbp
  804d13:	48 83 ec 20          	sub    $0x20,%rsp
  804d17:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804d1a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804d1e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804d22:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804d25:	48 98                	cltq   
  804d27:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804d2e:	00 
  804d2f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804d35:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804d3b:	48 89 d1             	mov    %rdx,%rcx
  804d3e:	48 89 c2             	mov    %rax,%rdx
  804d41:	be 01 00 00 00       	mov    $0x1,%esi
  804d46:	bf 09 00 00 00       	mov    $0x9,%edi
  804d4b:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804d52:	00 00 00 
  804d55:	ff d0                	callq  *%rax
  804d57:	c9                   	leaveq 
  804d58:	c3                   	retq   

0000000000804d59 <sys_env_set_pgfault_upcall>:
  804d59:	55                   	push   %rbp
  804d5a:	48 89 e5             	mov    %rsp,%rbp
  804d5d:	48 83 ec 20          	sub    $0x20,%rsp
  804d61:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804d64:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804d68:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804d6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804d6f:	48 98                	cltq   
  804d71:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804d78:	00 
  804d79:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804d7f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804d85:	48 89 d1             	mov    %rdx,%rcx
  804d88:	48 89 c2             	mov    %rax,%rdx
  804d8b:	be 01 00 00 00       	mov    $0x1,%esi
  804d90:	bf 0a 00 00 00       	mov    $0xa,%edi
  804d95:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804d9c:	00 00 00 
  804d9f:	ff d0                	callq  *%rax
  804da1:	c9                   	leaveq 
  804da2:	c3                   	retq   

0000000000804da3 <sys_ipc_try_send>:
  804da3:	55                   	push   %rbp
  804da4:	48 89 e5             	mov    %rsp,%rbp
  804da7:	48 83 ec 20          	sub    $0x20,%rsp
  804dab:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804dae:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804db2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  804db6:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  804db9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804dbc:	48 63 f0             	movslq %eax,%rsi
  804dbf:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804dc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804dc6:	48 98                	cltq   
  804dc8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804dcc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804dd3:	00 
  804dd4:	49 89 f1             	mov    %rsi,%r9
  804dd7:	49 89 c8             	mov    %rcx,%r8
  804dda:	48 89 d1             	mov    %rdx,%rcx
  804ddd:	48 89 c2             	mov    %rax,%rdx
  804de0:	be 00 00 00 00       	mov    $0x0,%esi
  804de5:	bf 0c 00 00 00       	mov    $0xc,%edi
  804dea:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804df1:	00 00 00 
  804df4:	ff d0                	callq  *%rax
  804df6:	c9                   	leaveq 
  804df7:	c3                   	retq   

0000000000804df8 <sys_ipc_recv>:
  804df8:	55                   	push   %rbp
  804df9:	48 89 e5             	mov    %rsp,%rbp
  804dfc:	48 83 ec 10          	sub    $0x10,%rsp
  804e00:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804e04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804e08:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804e0f:	00 
  804e10:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804e16:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804e1c:	b9 00 00 00 00       	mov    $0x0,%ecx
  804e21:	48 89 c2             	mov    %rax,%rdx
  804e24:	be 01 00 00 00       	mov    $0x1,%esi
  804e29:	bf 0d 00 00 00       	mov    $0xd,%edi
  804e2e:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804e35:	00 00 00 
  804e38:	ff d0                	callq  *%rax
  804e3a:	c9                   	leaveq 
  804e3b:	c3                   	retq   

0000000000804e3c <sys_time_msec>:
  804e3c:	55                   	push   %rbp
  804e3d:	48 89 e5             	mov    %rsp,%rbp
  804e40:	48 83 ec 10          	sub    $0x10,%rsp
  804e44:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804e4b:	00 
  804e4c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804e52:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804e58:	b9 00 00 00 00       	mov    $0x0,%ecx
  804e5d:	ba 00 00 00 00       	mov    $0x0,%edx
  804e62:	be 00 00 00 00       	mov    $0x0,%esi
  804e67:	bf 0e 00 00 00       	mov    $0xe,%edi
  804e6c:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804e73:	00 00 00 
  804e76:	ff d0                	callq  *%rax
  804e78:	c9                   	leaveq 
  804e79:	c3                   	retq   

0000000000804e7a <sys_net_transmit>:
  804e7a:	55                   	push   %rbp
  804e7b:	48 89 e5             	mov    %rsp,%rbp
  804e7e:	48 83 ec 20          	sub    $0x20,%rsp
  804e82:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804e86:	89 75 f4             	mov    %esi,-0xc(%rbp)
  804e89:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804e8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804e90:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804e97:	00 
  804e98:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804e9e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804ea4:	48 89 d1             	mov    %rdx,%rcx
  804ea7:	48 89 c2             	mov    %rax,%rdx
  804eaa:	be 00 00 00 00       	mov    $0x0,%esi
  804eaf:	bf 0f 00 00 00       	mov    $0xf,%edi
  804eb4:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804ebb:	00 00 00 
  804ebe:	ff d0                	callq  *%rax
  804ec0:	c9                   	leaveq 
  804ec1:	c3                   	retq   

0000000000804ec2 <sys_net_receive>:
  804ec2:	55                   	push   %rbp
  804ec3:	48 89 e5             	mov    %rsp,%rbp
  804ec6:	48 83 ec 20          	sub    $0x20,%rsp
  804eca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804ece:	89 75 f4             	mov    %esi,-0xc(%rbp)
  804ed1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804ed8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804edf:	00 
  804ee0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804ee6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804eec:	48 89 d1             	mov    %rdx,%rcx
  804eef:	48 89 c2             	mov    %rax,%rdx
  804ef2:	be 00 00 00 00       	mov    $0x0,%esi
  804ef7:	bf 10 00 00 00       	mov    $0x10,%edi
  804efc:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804f03:	00 00 00 
  804f06:	ff d0                	callq  *%rax
  804f08:	c9                   	leaveq 
  804f09:	c3                   	retq   

0000000000804f0a <sys_ept_map>:
  804f0a:	55                   	push   %rbp
  804f0b:	48 89 e5             	mov    %rsp,%rbp
  804f0e:	48 83 ec 30          	sub    $0x30,%rsp
  804f12:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804f15:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804f19:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804f1c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  804f20:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  804f24:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804f27:	48 63 c8             	movslq %eax,%rcx
  804f2a:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  804f2e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804f31:	48 63 f0             	movslq %eax,%rsi
  804f34:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804f38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804f3b:	48 98                	cltq   
  804f3d:	48 89 0c 24          	mov    %rcx,(%rsp)
  804f41:	49 89 f9             	mov    %rdi,%r9
  804f44:	49 89 f0             	mov    %rsi,%r8
  804f47:	48 89 d1             	mov    %rdx,%rcx
  804f4a:	48 89 c2             	mov    %rax,%rdx
  804f4d:	be 00 00 00 00       	mov    $0x0,%esi
  804f52:	bf 11 00 00 00       	mov    $0x11,%edi
  804f57:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804f5e:	00 00 00 
  804f61:	ff d0                	callq  *%rax
  804f63:	c9                   	leaveq 
  804f64:	c3                   	retq   

0000000000804f65 <sys_env_mkguest>:
  804f65:	55                   	push   %rbp
  804f66:	48 89 e5             	mov    %rsp,%rbp
  804f69:	48 83 ec 20          	sub    $0x20,%rsp
  804f6d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804f71:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804f75:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804f79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804f7d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  804f84:	00 
  804f85:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  804f8b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  804f91:	48 89 d1             	mov    %rdx,%rcx
  804f94:	48 89 c2             	mov    %rax,%rdx
  804f97:	be 00 00 00 00       	mov    $0x0,%esi
  804f9c:	bf 12 00 00 00       	mov    $0x12,%edi
  804fa1:	48 b8 f9 49 80 00 00 	movabs $0x8049f9,%rax
  804fa8:	00 00 00 
  804fab:	ff d0                	callq  *%rax
  804fad:	c9                   	leaveq 
  804fae:	c3                   	retq   

0000000000804faf <set_pgfault_handler>:
  804faf:	55                   	push   %rbp
  804fb0:	48 89 e5             	mov    %rsp,%rbp
  804fb3:	48 83 ec 20          	sub    $0x20,%rsp
  804fb7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804fbb:	48 b8 28 60 81 00 00 	movabs $0x816028,%rax
  804fc2:	00 00 00 
  804fc5:	48 8b 00             	mov    (%rax),%rax
  804fc8:	48 85 c0             	test   %rax,%rax
  804fcb:	75 6f                	jne    80503c <set_pgfault_handler+0x8d>
  804fcd:	ba 07 00 00 00       	mov    $0x7,%edx
  804fd2:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  804fd7:	bf 00 00 00 00       	mov    $0x0,%edi
  804fdc:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  804fe3:	00 00 00 
  804fe6:	ff d0                	callq  *%rax
  804fe8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804feb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804fef:	79 30                	jns    805021 <set_pgfault_handler+0x72>
  804ff1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804ff4:	89 c1                	mov    %eax,%ecx
  804ff6:	48 ba d8 7f 80 00 00 	movabs $0x807fd8,%rdx
  804ffd:	00 00 00 
  805000:	be 22 00 00 00       	mov    $0x22,%esi
  805005:	48 bf f7 7f 80 00 00 	movabs $0x807ff7,%rdi
  80500c:	00 00 00 
  80500f:	b8 00 00 00 00       	mov    $0x0,%eax
  805014:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  80501b:	00 00 00 
  80501e:	41 ff d0             	callq  *%r8
  805021:	48 be 4f 50 80 00 00 	movabs $0x80504f,%rsi
  805028:	00 00 00 
  80502b:	bf 00 00 00 00       	mov    $0x0,%edi
  805030:	48 b8 59 4d 80 00 00 	movabs $0x804d59,%rax
  805037:	00 00 00 
  80503a:	ff d0                	callq  *%rax
  80503c:	48 b8 28 60 81 00 00 	movabs $0x816028,%rax
  805043:	00 00 00 
  805046:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80504a:	48 89 10             	mov    %rdx,(%rax)
  80504d:	c9                   	leaveq 
  80504e:	c3                   	retq   

000000000080504f <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  80504f:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  805052:	48 a1 28 60 81 00 00 	movabs 0x816028,%rax
  805059:	00 00 00 
call *%rax
  80505c:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  80505e:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  805065:	00 08 
    movq 152(%rsp), %rax
  805067:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  80506e:	00 
    movq 136(%rsp), %rbx
  80506f:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  805076:	00 
movq %rbx, (%rax)
  805077:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  80507a:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80507e:	4c 8b 3c 24          	mov    (%rsp),%r15
  805082:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  805087:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  80508c:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  805091:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  805096:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  80509b:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  8050a0:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  8050a5:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  8050aa:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  8050af:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  8050b4:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  8050b9:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  8050be:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  8050c3:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  8050c8:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  8050cc:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  8050d0:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  8050d1:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  8050d6:	c3                   	retq   

00000000008050d7 <ipc_recv>:
  8050d7:	55                   	push   %rbp
  8050d8:	48 89 e5             	mov    %rsp,%rbp
  8050db:	48 83 ec 30          	sub    $0x30,%rsp
  8050df:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8050e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8050e7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8050eb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8050f0:	75 0e                	jne    805100 <ipc_recv+0x29>
  8050f2:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8050f9:	00 00 00 
  8050fc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  805100:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805104:	48 89 c7             	mov    %rax,%rdi
  805107:	48 b8 f8 4d 80 00 00 	movabs $0x804df8,%rax
  80510e:	00 00 00 
  805111:	ff d0                	callq  *%rax
  805113:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805116:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80511a:	79 27                	jns    805143 <ipc_recv+0x6c>
  80511c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  805121:	74 0a                	je     80512d <ipc_recv+0x56>
  805123:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805127:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80512d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  805132:	74 0a                	je     80513e <ipc_recv+0x67>
  805134:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805138:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80513e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805141:	eb 53                	jmp    805196 <ipc_recv+0xbf>
  805143:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  805148:	74 19                	je     805163 <ipc_recv+0x8c>
  80514a:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  805151:	00 00 00 
  805154:	48 8b 00             	mov    (%rax),%rax
  805157:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80515d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805161:	89 10                	mov    %edx,(%rax)
  805163:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  805168:	74 19                	je     805183 <ipc_recv+0xac>
  80516a:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  805171:	00 00 00 
  805174:	48 8b 00             	mov    (%rax),%rax
  805177:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80517d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805181:	89 10                	mov    %edx,(%rax)
  805183:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  80518a:	00 00 00 
  80518d:	48 8b 00             	mov    (%rax),%rax
  805190:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  805196:	c9                   	leaveq 
  805197:	c3                   	retq   

0000000000805198 <ipc_send>:
  805198:	55                   	push   %rbp
  805199:	48 89 e5             	mov    %rsp,%rbp
  80519c:	48 83 ec 30          	sub    $0x30,%rsp
  8051a0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8051a3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8051a6:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8051aa:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8051ad:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8051b2:	75 10                	jne    8051c4 <ipc_send+0x2c>
  8051b4:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8051bb:	00 00 00 
  8051be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8051c2:	eb 0e                	jmp    8051d2 <ipc_send+0x3a>
  8051c4:	eb 0c                	jmp    8051d2 <ipc_send+0x3a>
  8051c6:	48 b8 91 4b 80 00 00 	movabs $0x804b91,%rax
  8051cd:	00 00 00 
  8051d0:	ff d0                	callq  *%rax
  8051d2:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8051d5:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8051d8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8051dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8051df:	89 c7                	mov    %eax,%edi
  8051e1:	48 b8 a3 4d 80 00 00 	movabs $0x804da3,%rax
  8051e8:	00 00 00 
  8051eb:	ff d0                	callq  *%rax
  8051ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8051f0:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8051f4:	74 d0                	je     8051c6 <ipc_send+0x2e>
  8051f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8051fa:	79 30                	jns    80522c <ipc_send+0x94>
  8051fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8051ff:	89 c1                	mov    %eax,%ecx
  805201:	48 ba 08 80 80 00 00 	movabs $0x808008,%rdx
  805208:	00 00 00 
  80520b:	be 44 00 00 00       	mov    $0x44,%esi
  805210:	48 bf 1e 80 80 00 00 	movabs $0x80801e,%rdi
  805217:	00 00 00 
  80521a:	b8 00 00 00 00       	mov    $0x0,%eax
  80521f:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  805226:	00 00 00 
  805229:	41 ff d0             	callq  *%r8
  80522c:	c9                   	leaveq 
  80522d:	c3                   	retq   

000000000080522e <ipc_host_recv>:
  80522e:	55                   	push   %rbp
  80522f:	48 89 e5             	mov    %rsp,%rbp
  805232:	48 83 ec 10          	sub    $0x10,%rsp
  805236:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80523a:	48 ba 30 80 80 00 00 	movabs $0x808030,%rdx
  805241:	00 00 00 
  805244:	be 4e 00 00 00       	mov    $0x4e,%esi
  805249:	48 bf 1e 80 80 00 00 	movabs $0x80801e,%rdi
  805250:	00 00 00 
  805253:	b8 00 00 00 00       	mov    $0x0,%eax
  805258:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  80525f:	00 00 00 
  805262:	ff d1                	callq  *%rcx

0000000000805264 <ipc_host_send>:
  805264:	55                   	push   %rbp
  805265:	48 89 e5             	mov    %rsp,%rbp
  805268:	48 83 ec 20          	sub    $0x20,%rsp
  80526c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80526f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  805272:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  805276:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  805279:	48 ba 50 80 80 00 00 	movabs $0x808050,%rdx
  805280:	00 00 00 
  805283:	be 67 00 00 00       	mov    $0x67,%esi
  805288:	48 bf 1e 80 80 00 00 	movabs $0x80801e,%rdi
  80528f:	00 00 00 
  805292:	b8 00 00 00 00       	mov    $0x0,%eax
  805297:	48 b9 b2 34 80 00 00 	movabs $0x8034b2,%rcx
  80529e:	00 00 00 
  8052a1:	ff d1                	callq  *%rcx

00000000008052a3 <ipc_find_env>:
  8052a3:	55                   	push   %rbp
  8052a4:	48 89 e5             	mov    %rsp,%rbp
  8052a7:	48 83 ec 14          	sub    $0x14,%rsp
  8052ab:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8052ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8052b5:	eb 4e                	jmp    805305 <ipc_find_env+0x62>
  8052b7:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8052be:	00 00 00 
  8052c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8052c4:	48 98                	cltq   
  8052c6:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8052cd:	48 01 d0             	add    %rdx,%rax
  8052d0:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8052d6:	8b 00                	mov    (%rax),%eax
  8052d8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8052db:	75 24                	jne    805301 <ipc_find_env+0x5e>
  8052dd:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8052e4:	00 00 00 
  8052e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8052ea:	48 98                	cltq   
  8052ec:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8052f3:	48 01 d0             	add    %rdx,%rax
  8052f6:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8052fc:	8b 40 08             	mov    0x8(%rax),%eax
  8052ff:	eb 12                	jmp    805313 <ipc_find_env+0x70>
  805301:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  805305:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  80530c:	7e a9                	jle    8052b7 <ipc_find_env+0x14>
  80530e:	b8 00 00 00 00       	mov    $0x0,%eax
  805313:	c9                   	leaveq 
  805314:	c3                   	retq   

0000000000805315 <fd2num>:
  805315:	55                   	push   %rbp
  805316:	48 89 e5             	mov    %rsp,%rbp
  805319:	48 83 ec 08          	sub    $0x8,%rsp
  80531d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  805321:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  805325:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  80532c:	ff ff ff 
  80532f:	48 01 d0             	add    %rdx,%rax
  805332:	48 c1 e8 0c          	shr    $0xc,%rax
  805336:	c9                   	leaveq 
  805337:	c3                   	retq   

0000000000805338 <fd2data>:
  805338:	55                   	push   %rbp
  805339:	48 89 e5             	mov    %rsp,%rbp
  80533c:	48 83 ec 08          	sub    $0x8,%rsp
  805340:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  805344:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805348:	48 89 c7             	mov    %rax,%rdi
  80534b:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  805352:	00 00 00 
  805355:	ff d0                	callq  *%rax
  805357:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  80535d:	48 c1 e0 0c          	shl    $0xc,%rax
  805361:	c9                   	leaveq 
  805362:	c3                   	retq   

0000000000805363 <fd_alloc>:
  805363:	55                   	push   %rbp
  805364:	48 89 e5             	mov    %rsp,%rbp
  805367:	48 83 ec 18          	sub    $0x18,%rsp
  80536b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80536f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  805376:	eb 6b                	jmp    8053e3 <fd_alloc+0x80>
  805378:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80537b:	48 98                	cltq   
  80537d:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  805383:	48 c1 e0 0c          	shl    $0xc,%rax
  805387:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80538b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80538f:	48 c1 e8 15          	shr    $0x15,%rax
  805393:	48 89 c2             	mov    %rax,%rdx
  805396:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80539d:	01 00 00 
  8053a0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8053a4:	83 e0 01             	and    $0x1,%eax
  8053a7:	48 85 c0             	test   %rax,%rax
  8053aa:	74 21                	je     8053cd <fd_alloc+0x6a>
  8053ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8053b0:	48 c1 e8 0c          	shr    $0xc,%rax
  8053b4:	48 89 c2             	mov    %rax,%rdx
  8053b7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8053be:	01 00 00 
  8053c1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8053c5:	83 e0 01             	and    $0x1,%eax
  8053c8:	48 85 c0             	test   %rax,%rax
  8053cb:	75 12                	jne    8053df <fd_alloc+0x7c>
  8053cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8053d1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8053d5:	48 89 10             	mov    %rdx,(%rax)
  8053d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8053dd:	eb 1a                	jmp    8053f9 <fd_alloc+0x96>
  8053df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8053e3:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8053e7:	7e 8f                	jle    805378 <fd_alloc+0x15>
  8053e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8053ed:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8053f4:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8053f9:	c9                   	leaveq 
  8053fa:	c3                   	retq   

00000000008053fb <fd_lookup>:
  8053fb:	55                   	push   %rbp
  8053fc:	48 89 e5             	mov    %rsp,%rbp
  8053ff:	48 83 ec 20          	sub    $0x20,%rsp
  805403:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805406:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80540a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80540e:	78 06                	js     805416 <fd_lookup+0x1b>
  805410:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  805414:	7e 07                	jle    80541d <fd_lookup+0x22>
  805416:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80541b:	eb 6c                	jmp    805489 <fd_lookup+0x8e>
  80541d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805420:	48 98                	cltq   
  805422:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  805428:	48 c1 e0 0c          	shl    $0xc,%rax
  80542c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  805430:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805434:	48 c1 e8 15          	shr    $0x15,%rax
  805438:	48 89 c2             	mov    %rax,%rdx
  80543b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  805442:	01 00 00 
  805445:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805449:	83 e0 01             	and    $0x1,%eax
  80544c:	48 85 c0             	test   %rax,%rax
  80544f:	74 21                	je     805472 <fd_lookup+0x77>
  805451:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805455:	48 c1 e8 0c          	shr    $0xc,%rax
  805459:	48 89 c2             	mov    %rax,%rdx
  80545c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  805463:	01 00 00 
  805466:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80546a:	83 e0 01             	and    $0x1,%eax
  80546d:	48 85 c0             	test   %rax,%rax
  805470:	75 07                	jne    805479 <fd_lookup+0x7e>
  805472:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  805477:	eb 10                	jmp    805489 <fd_lookup+0x8e>
  805479:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80547d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  805481:	48 89 10             	mov    %rdx,(%rax)
  805484:	b8 00 00 00 00       	mov    $0x0,%eax
  805489:	c9                   	leaveq 
  80548a:	c3                   	retq   

000000000080548b <fd_close>:
  80548b:	55                   	push   %rbp
  80548c:	48 89 e5             	mov    %rsp,%rbp
  80548f:	48 83 ec 30          	sub    $0x30,%rsp
  805493:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  805497:	89 f0                	mov    %esi,%eax
  805499:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80549c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8054a0:	48 89 c7             	mov    %rax,%rdi
  8054a3:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  8054aa:	00 00 00 
  8054ad:	ff d0                	callq  *%rax
  8054af:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8054b3:	48 89 d6             	mov    %rdx,%rsi
  8054b6:	89 c7                	mov    %eax,%edi
  8054b8:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  8054bf:	00 00 00 
  8054c2:	ff d0                	callq  *%rax
  8054c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8054c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8054cb:	78 0a                	js     8054d7 <fd_close+0x4c>
  8054cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8054d1:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8054d5:	74 12                	je     8054e9 <fd_close+0x5e>
  8054d7:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8054db:	74 05                	je     8054e2 <fd_close+0x57>
  8054dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8054e0:	eb 05                	jmp    8054e7 <fd_close+0x5c>
  8054e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8054e7:	eb 69                	jmp    805552 <fd_close+0xc7>
  8054e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8054ed:	8b 00                	mov    (%rax),%eax
  8054ef:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8054f3:	48 89 d6             	mov    %rdx,%rsi
  8054f6:	89 c7                	mov    %eax,%edi
  8054f8:	48 b8 54 55 80 00 00 	movabs $0x805554,%rax
  8054ff:	00 00 00 
  805502:	ff d0                	callq  *%rax
  805504:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805507:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80550b:	78 2a                	js     805537 <fd_close+0xac>
  80550d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805511:	48 8b 40 20          	mov    0x20(%rax),%rax
  805515:	48 85 c0             	test   %rax,%rax
  805518:	74 16                	je     805530 <fd_close+0xa5>
  80551a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80551e:	48 8b 40 20          	mov    0x20(%rax),%rax
  805522:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  805526:	48 89 d7             	mov    %rdx,%rdi
  805529:	ff d0                	callq  *%rax
  80552b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80552e:	eb 07                	jmp    805537 <fd_close+0xac>
  805530:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  805537:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80553b:	48 89 c6             	mov    %rax,%rsi
  80553e:	bf 00 00 00 00       	mov    $0x0,%edi
  805543:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  80554a:	00 00 00 
  80554d:	ff d0                	callq  *%rax
  80554f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805552:	c9                   	leaveq 
  805553:	c3                   	retq   

0000000000805554 <dev_lookup>:
  805554:	55                   	push   %rbp
  805555:	48 89 e5             	mov    %rsp,%rbp
  805558:	48 83 ec 20          	sub    $0x20,%rsp
  80555c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80555f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805563:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80556a:	eb 41                	jmp    8055ad <dev_lookup+0x59>
  80556c:	48 b8 a0 20 81 00 00 	movabs $0x8120a0,%rax
  805573:	00 00 00 
  805576:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805579:	48 63 d2             	movslq %edx,%rdx
  80557c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805580:	8b 00                	mov    (%rax),%eax
  805582:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  805585:	75 22                	jne    8055a9 <dev_lookup+0x55>
  805587:	48 b8 a0 20 81 00 00 	movabs $0x8120a0,%rax
  80558e:	00 00 00 
  805591:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805594:	48 63 d2             	movslq %edx,%rdx
  805597:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80559b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80559f:	48 89 10             	mov    %rdx,(%rax)
  8055a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8055a7:	eb 60                	jmp    805609 <dev_lookup+0xb5>
  8055a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8055ad:	48 b8 a0 20 81 00 00 	movabs $0x8120a0,%rax
  8055b4:	00 00 00 
  8055b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8055ba:	48 63 d2             	movslq %edx,%rdx
  8055bd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8055c1:	48 85 c0             	test   %rax,%rax
  8055c4:	75 a6                	jne    80556c <dev_lookup+0x18>
  8055c6:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  8055cd:	00 00 00 
  8055d0:	48 8b 00             	mov    (%rax),%rax
  8055d3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8055d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8055dc:	89 c6                	mov    %eax,%esi
  8055de:	48 bf 70 80 80 00 00 	movabs $0x808070,%rdi
  8055e5:	00 00 00 
  8055e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8055ed:	48 b9 eb 36 80 00 00 	movabs $0x8036eb,%rcx
  8055f4:	00 00 00 
  8055f7:	ff d1                	callq  *%rcx
  8055f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8055fd:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  805604:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  805609:	c9                   	leaveq 
  80560a:	c3                   	retq   

000000000080560b <close>:
  80560b:	55                   	push   %rbp
  80560c:	48 89 e5             	mov    %rsp,%rbp
  80560f:	48 83 ec 20          	sub    $0x20,%rsp
  805613:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805616:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80561a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80561d:	48 89 d6             	mov    %rdx,%rsi
  805620:	89 c7                	mov    %eax,%edi
  805622:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  805629:	00 00 00 
  80562c:	ff d0                	callq  *%rax
  80562e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805631:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805635:	79 05                	jns    80563c <close+0x31>
  805637:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80563a:	eb 18                	jmp    805654 <close+0x49>
  80563c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805640:	be 01 00 00 00       	mov    $0x1,%esi
  805645:	48 89 c7             	mov    %rax,%rdi
  805648:	48 b8 8b 54 80 00 00 	movabs $0x80548b,%rax
  80564f:	00 00 00 
  805652:	ff d0                	callq  *%rax
  805654:	c9                   	leaveq 
  805655:	c3                   	retq   

0000000000805656 <close_all>:
  805656:	55                   	push   %rbp
  805657:	48 89 e5             	mov    %rsp,%rbp
  80565a:	48 83 ec 10          	sub    $0x10,%rsp
  80565e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  805665:	eb 15                	jmp    80567c <close_all+0x26>
  805667:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80566a:	89 c7                	mov    %eax,%edi
  80566c:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  805673:	00 00 00 
  805676:	ff d0                	callq  *%rax
  805678:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80567c:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  805680:	7e e5                	jle    805667 <close_all+0x11>
  805682:	c9                   	leaveq 
  805683:	c3                   	retq   

0000000000805684 <dup>:
  805684:	55                   	push   %rbp
  805685:	48 89 e5             	mov    %rsp,%rbp
  805688:	48 83 ec 40          	sub    $0x40,%rsp
  80568c:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80568f:	89 75 c8             	mov    %esi,-0x38(%rbp)
  805692:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  805696:	8b 45 cc             	mov    -0x34(%rbp),%eax
  805699:	48 89 d6             	mov    %rdx,%rsi
  80569c:	89 c7                	mov    %eax,%edi
  80569e:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  8056a5:	00 00 00 
  8056a8:	ff d0                	callq  *%rax
  8056aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8056ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8056b1:	79 08                	jns    8056bb <dup+0x37>
  8056b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8056b6:	e9 70 01 00 00       	jmpq   80582b <dup+0x1a7>
  8056bb:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8056be:	89 c7                	mov    %eax,%edi
  8056c0:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  8056c7:	00 00 00 
  8056ca:	ff d0                	callq  *%rax
  8056cc:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8056cf:	48 98                	cltq   
  8056d1:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8056d7:	48 c1 e0 0c          	shl    $0xc,%rax
  8056db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8056df:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8056e3:	48 89 c7             	mov    %rax,%rdi
  8056e6:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  8056ed:	00 00 00 
  8056f0:	ff d0                	callq  *%rax
  8056f2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8056f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8056fa:	48 89 c7             	mov    %rax,%rdi
  8056fd:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  805704:	00 00 00 
  805707:	ff d0                	callq  *%rax
  805709:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80570d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805711:	48 c1 e8 15          	shr    $0x15,%rax
  805715:	48 89 c2             	mov    %rax,%rdx
  805718:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80571f:	01 00 00 
  805722:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805726:	83 e0 01             	and    $0x1,%eax
  805729:	48 85 c0             	test   %rax,%rax
  80572c:	74 73                	je     8057a1 <dup+0x11d>
  80572e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805732:	48 c1 e8 0c          	shr    $0xc,%rax
  805736:	48 89 c2             	mov    %rax,%rdx
  805739:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  805740:	01 00 00 
  805743:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805747:	83 e0 01             	and    $0x1,%eax
  80574a:	48 85 c0             	test   %rax,%rax
  80574d:	74 52                	je     8057a1 <dup+0x11d>
  80574f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805753:	48 c1 e8 0c          	shr    $0xc,%rax
  805757:	48 89 c2             	mov    %rax,%rdx
  80575a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  805761:	01 00 00 
  805764:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805768:	25 07 0e 00 00       	and    $0xe07,%eax
  80576d:	89 c1                	mov    %eax,%ecx
  80576f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  805773:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805777:	41 89 c8             	mov    %ecx,%r8d
  80577a:	48 89 d1             	mov    %rdx,%rcx
  80577d:	ba 00 00 00 00       	mov    $0x0,%edx
  805782:	48 89 c6             	mov    %rax,%rsi
  805785:	bf 00 00 00 00       	mov    $0x0,%edi
  80578a:	48 b8 1f 4c 80 00 00 	movabs $0x804c1f,%rax
  805791:	00 00 00 
  805794:	ff d0                	callq  *%rax
  805796:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805799:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80579d:	79 02                	jns    8057a1 <dup+0x11d>
  80579f:	eb 57                	jmp    8057f8 <dup+0x174>
  8057a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8057a5:	48 c1 e8 0c          	shr    $0xc,%rax
  8057a9:	48 89 c2             	mov    %rax,%rdx
  8057ac:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8057b3:	01 00 00 
  8057b6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8057ba:	25 07 0e 00 00       	and    $0xe07,%eax
  8057bf:	89 c1                	mov    %eax,%ecx
  8057c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8057c5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8057c9:	41 89 c8             	mov    %ecx,%r8d
  8057cc:	48 89 d1             	mov    %rdx,%rcx
  8057cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8057d4:	48 89 c6             	mov    %rax,%rsi
  8057d7:	bf 00 00 00 00       	mov    $0x0,%edi
  8057dc:	48 b8 1f 4c 80 00 00 	movabs $0x804c1f,%rax
  8057e3:	00 00 00 
  8057e6:	ff d0                	callq  *%rax
  8057e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8057eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8057ef:	79 02                	jns    8057f3 <dup+0x16f>
  8057f1:	eb 05                	jmp    8057f8 <dup+0x174>
  8057f3:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8057f6:	eb 33                	jmp    80582b <dup+0x1a7>
  8057f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8057fc:	48 89 c6             	mov    %rax,%rsi
  8057ff:	bf 00 00 00 00       	mov    $0x0,%edi
  805804:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  80580b:	00 00 00 
  80580e:	ff d0                	callq  *%rax
  805810:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805814:	48 89 c6             	mov    %rax,%rsi
  805817:	bf 00 00 00 00       	mov    $0x0,%edi
  80581c:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  805823:	00 00 00 
  805826:	ff d0                	callq  *%rax
  805828:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80582b:	c9                   	leaveq 
  80582c:	c3                   	retq   

000000000080582d <read>:
  80582d:	55                   	push   %rbp
  80582e:	48 89 e5             	mov    %rsp,%rbp
  805831:	48 83 ec 40          	sub    $0x40,%rsp
  805835:	89 7d dc             	mov    %edi,-0x24(%rbp)
  805838:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80583c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  805840:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  805844:	8b 45 dc             	mov    -0x24(%rbp),%eax
  805847:	48 89 d6             	mov    %rdx,%rsi
  80584a:	89 c7                	mov    %eax,%edi
  80584c:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  805853:	00 00 00 
  805856:	ff d0                	callq  *%rax
  805858:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80585b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80585f:	78 24                	js     805885 <read+0x58>
  805861:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805865:	8b 00                	mov    (%rax),%eax
  805867:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80586b:	48 89 d6             	mov    %rdx,%rsi
  80586e:	89 c7                	mov    %eax,%edi
  805870:	48 b8 54 55 80 00 00 	movabs $0x805554,%rax
  805877:	00 00 00 
  80587a:	ff d0                	callq  *%rax
  80587c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80587f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805883:	79 05                	jns    80588a <read+0x5d>
  805885:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805888:	eb 76                	jmp    805900 <read+0xd3>
  80588a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80588e:	8b 40 08             	mov    0x8(%rax),%eax
  805891:	83 e0 03             	and    $0x3,%eax
  805894:	83 f8 01             	cmp    $0x1,%eax
  805897:	75 3a                	jne    8058d3 <read+0xa6>
  805899:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  8058a0:	00 00 00 
  8058a3:	48 8b 00             	mov    (%rax),%rax
  8058a6:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8058ac:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8058af:	89 c6                	mov    %eax,%esi
  8058b1:	48 bf 8f 80 80 00 00 	movabs $0x80808f,%rdi
  8058b8:	00 00 00 
  8058bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8058c0:	48 b9 eb 36 80 00 00 	movabs $0x8036eb,%rcx
  8058c7:	00 00 00 
  8058ca:	ff d1                	callq  *%rcx
  8058cc:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8058d1:	eb 2d                	jmp    805900 <read+0xd3>
  8058d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8058d7:	48 8b 40 10          	mov    0x10(%rax),%rax
  8058db:	48 85 c0             	test   %rax,%rax
  8058de:	75 07                	jne    8058e7 <read+0xba>
  8058e0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8058e5:	eb 19                	jmp    805900 <read+0xd3>
  8058e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8058eb:	48 8b 40 10          	mov    0x10(%rax),%rax
  8058ef:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8058f3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8058f7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8058fb:	48 89 cf             	mov    %rcx,%rdi
  8058fe:	ff d0                	callq  *%rax
  805900:	c9                   	leaveq 
  805901:	c3                   	retq   

0000000000805902 <readn>:
  805902:	55                   	push   %rbp
  805903:	48 89 e5             	mov    %rsp,%rbp
  805906:	48 83 ec 30          	sub    $0x30,%rsp
  80590a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80590d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805911:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  805915:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80591c:	eb 49                	jmp    805967 <readn+0x65>
  80591e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805921:	48 98                	cltq   
  805923:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  805927:	48 29 c2             	sub    %rax,%rdx
  80592a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80592d:	48 63 c8             	movslq %eax,%rcx
  805930:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805934:	48 01 c1             	add    %rax,%rcx
  805937:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80593a:	48 89 ce             	mov    %rcx,%rsi
  80593d:	89 c7                	mov    %eax,%edi
  80593f:	48 b8 2d 58 80 00 00 	movabs $0x80582d,%rax
  805946:	00 00 00 
  805949:	ff d0                	callq  *%rax
  80594b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80594e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  805952:	79 05                	jns    805959 <readn+0x57>
  805954:	8b 45 f8             	mov    -0x8(%rbp),%eax
  805957:	eb 1c                	jmp    805975 <readn+0x73>
  805959:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80595d:	75 02                	jne    805961 <readn+0x5f>
  80595f:	eb 11                	jmp    805972 <readn+0x70>
  805961:	8b 45 f8             	mov    -0x8(%rbp),%eax
  805964:	01 45 fc             	add    %eax,-0x4(%rbp)
  805967:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80596a:	48 98                	cltq   
  80596c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  805970:	72 ac                	jb     80591e <readn+0x1c>
  805972:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805975:	c9                   	leaveq 
  805976:	c3                   	retq   

0000000000805977 <write>:
  805977:	55                   	push   %rbp
  805978:	48 89 e5             	mov    %rsp,%rbp
  80597b:	48 83 ec 40          	sub    $0x40,%rsp
  80597f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  805982:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  805986:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80598a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80598e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  805991:	48 89 d6             	mov    %rdx,%rsi
  805994:	89 c7                	mov    %eax,%edi
  805996:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  80599d:	00 00 00 
  8059a0:	ff d0                	callq  *%rax
  8059a2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8059a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8059a9:	78 24                	js     8059cf <write+0x58>
  8059ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8059af:	8b 00                	mov    (%rax),%eax
  8059b1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8059b5:	48 89 d6             	mov    %rdx,%rsi
  8059b8:	89 c7                	mov    %eax,%edi
  8059ba:	48 b8 54 55 80 00 00 	movabs $0x805554,%rax
  8059c1:	00 00 00 
  8059c4:	ff d0                	callq  *%rax
  8059c6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8059c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8059cd:	79 05                	jns    8059d4 <write+0x5d>
  8059cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8059d2:	eb 75                	jmp    805a49 <write+0xd2>
  8059d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8059d8:	8b 40 08             	mov    0x8(%rax),%eax
  8059db:	83 e0 03             	and    $0x3,%eax
  8059de:	85 c0                	test   %eax,%eax
  8059e0:	75 3a                	jne    805a1c <write+0xa5>
  8059e2:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  8059e9:	00 00 00 
  8059ec:	48 8b 00             	mov    (%rax),%rax
  8059ef:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8059f5:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8059f8:	89 c6                	mov    %eax,%esi
  8059fa:	48 bf ab 80 80 00 00 	movabs $0x8080ab,%rdi
  805a01:	00 00 00 
  805a04:	b8 00 00 00 00       	mov    $0x0,%eax
  805a09:	48 b9 eb 36 80 00 00 	movabs $0x8036eb,%rcx
  805a10:	00 00 00 
  805a13:	ff d1                	callq  *%rcx
  805a15:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  805a1a:	eb 2d                	jmp    805a49 <write+0xd2>
  805a1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805a20:	48 8b 40 18          	mov    0x18(%rax),%rax
  805a24:	48 85 c0             	test   %rax,%rax
  805a27:	75 07                	jne    805a30 <write+0xb9>
  805a29:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  805a2e:	eb 19                	jmp    805a49 <write+0xd2>
  805a30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805a34:	48 8b 40 18          	mov    0x18(%rax),%rax
  805a38:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  805a3c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  805a40:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  805a44:	48 89 cf             	mov    %rcx,%rdi
  805a47:	ff d0                	callq  *%rax
  805a49:	c9                   	leaveq 
  805a4a:	c3                   	retq   

0000000000805a4b <seek>:
  805a4b:	55                   	push   %rbp
  805a4c:	48 89 e5             	mov    %rsp,%rbp
  805a4f:	48 83 ec 18          	sub    $0x18,%rsp
  805a53:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805a56:	89 75 e8             	mov    %esi,-0x18(%rbp)
  805a59:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  805a5d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805a60:	48 89 d6             	mov    %rdx,%rsi
  805a63:	89 c7                	mov    %eax,%edi
  805a65:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  805a6c:	00 00 00 
  805a6f:	ff d0                	callq  *%rax
  805a71:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805a74:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805a78:	79 05                	jns    805a7f <seek+0x34>
  805a7a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805a7d:	eb 0f                	jmp    805a8e <seek+0x43>
  805a7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805a83:	8b 55 e8             	mov    -0x18(%rbp),%edx
  805a86:	89 50 04             	mov    %edx,0x4(%rax)
  805a89:	b8 00 00 00 00       	mov    $0x0,%eax
  805a8e:	c9                   	leaveq 
  805a8f:	c3                   	retq   

0000000000805a90 <ftruncate>:
  805a90:	55                   	push   %rbp
  805a91:	48 89 e5             	mov    %rsp,%rbp
  805a94:	48 83 ec 30          	sub    $0x30,%rsp
  805a98:	89 7d dc             	mov    %edi,-0x24(%rbp)
  805a9b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  805a9e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  805aa2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  805aa5:	48 89 d6             	mov    %rdx,%rsi
  805aa8:	89 c7                	mov    %eax,%edi
  805aaa:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  805ab1:	00 00 00 
  805ab4:	ff d0                	callq  *%rax
  805ab6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805ab9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805abd:	78 24                	js     805ae3 <ftruncate+0x53>
  805abf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805ac3:	8b 00                	mov    (%rax),%eax
  805ac5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  805ac9:	48 89 d6             	mov    %rdx,%rsi
  805acc:	89 c7                	mov    %eax,%edi
  805ace:	48 b8 54 55 80 00 00 	movabs $0x805554,%rax
  805ad5:	00 00 00 
  805ad8:	ff d0                	callq  *%rax
  805ada:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805add:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805ae1:	79 05                	jns    805ae8 <ftruncate+0x58>
  805ae3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805ae6:	eb 72                	jmp    805b5a <ftruncate+0xca>
  805ae8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805aec:	8b 40 08             	mov    0x8(%rax),%eax
  805aef:	83 e0 03             	and    $0x3,%eax
  805af2:	85 c0                	test   %eax,%eax
  805af4:	75 3a                	jne    805b30 <ftruncate+0xa0>
  805af6:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  805afd:	00 00 00 
  805b00:	48 8b 00             	mov    (%rax),%rax
  805b03:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  805b09:	8b 55 dc             	mov    -0x24(%rbp),%edx
  805b0c:	89 c6                	mov    %eax,%esi
  805b0e:	48 bf c8 80 80 00 00 	movabs $0x8080c8,%rdi
  805b15:	00 00 00 
  805b18:	b8 00 00 00 00       	mov    $0x0,%eax
  805b1d:	48 b9 eb 36 80 00 00 	movabs $0x8036eb,%rcx
  805b24:	00 00 00 
  805b27:	ff d1                	callq  *%rcx
  805b29:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  805b2e:	eb 2a                	jmp    805b5a <ftruncate+0xca>
  805b30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805b34:	48 8b 40 30          	mov    0x30(%rax),%rax
  805b38:	48 85 c0             	test   %rax,%rax
  805b3b:	75 07                	jne    805b44 <ftruncate+0xb4>
  805b3d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  805b42:	eb 16                	jmp    805b5a <ftruncate+0xca>
  805b44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805b48:	48 8b 40 30          	mov    0x30(%rax),%rax
  805b4c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  805b50:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  805b53:	89 ce                	mov    %ecx,%esi
  805b55:	48 89 d7             	mov    %rdx,%rdi
  805b58:	ff d0                	callq  *%rax
  805b5a:	c9                   	leaveq 
  805b5b:	c3                   	retq   

0000000000805b5c <fstat>:
  805b5c:	55                   	push   %rbp
  805b5d:	48 89 e5             	mov    %rsp,%rbp
  805b60:	48 83 ec 30          	sub    $0x30,%rsp
  805b64:	89 7d dc             	mov    %edi,-0x24(%rbp)
  805b67:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  805b6b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  805b6f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  805b72:	48 89 d6             	mov    %rdx,%rsi
  805b75:	89 c7                	mov    %eax,%edi
  805b77:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  805b7e:	00 00 00 
  805b81:	ff d0                	callq  *%rax
  805b83:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805b86:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805b8a:	78 24                	js     805bb0 <fstat+0x54>
  805b8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805b90:	8b 00                	mov    (%rax),%eax
  805b92:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  805b96:	48 89 d6             	mov    %rdx,%rsi
  805b99:	89 c7                	mov    %eax,%edi
  805b9b:	48 b8 54 55 80 00 00 	movabs $0x805554,%rax
  805ba2:	00 00 00 
  805ba5:	ff d0                	callq  *%rax
  805ba7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805baa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805bae:	79 05                	jns    805bb5 <fstat+0x59>
  805bb0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805bb3:	eb 5e                	jmp    805c13 <fstat+0xb7>
  805bb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805bb9:	48 8b 40 28          	mov    0x28(%rax),%rax
  805bbd:	48 85 c0             	test   %rax,%rax
  805bc0:	75 07                	jne    805bc9 <fstat+0x6d>
  805bc2:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  805bc7:	eb 4a                	jmp    805c13 <fstat+0xb7>
  805bc9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805bcd:	c6 00 00             	movb   $0x0,(%rax)
  805bd0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805bd4:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  805bdb:	00 00 00 
  805bde:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805be2:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  805be9:	00 00 00 
  805bec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  805bf0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805bf4:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  805bfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805bff:	48 8b 40 28          	mov    0x28(%rax),%rax
  805c03:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  805c07:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  805c0b:	48 89 ce             	mov    %rcx,%rsi
  805c0e:	48 89 d7             	mov    %rdx,%rdi
  805c11:	ff d0                	callq  *%rax
  805c13:	c9                   	leaveq 
  805c14:	c3                   	retq   

0000000000805c15 <stat>:
  805c15:	55                   	push   %rbp
  805c16:	48 89 e5             	mov    %rsp,%rbp
  805c19:	48 83 ec 20          	sub    $0x20,%rsp
  805c1d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  805c21:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805c25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805c29:	be 00 00 00 00       	mov    $0x0,%esi
  805c2e:	48 89 c7             	mov    %rax,%rdi
  805c31:	48 b8 03 5d 80 00 00 	movabs $0x805d03,%rax
  805c38:	00 00 00 
  805c3b:	ff d0                	callq  *%rax
  805c3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805c40:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805c44:	79 05                	jns    805c4b <stat+0x36>
  805c46:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805c49:	eb 2f                	jmp    805c7a <stat+0x65>
  805c4b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  805c4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805c52:	48 89 d6             	mov    %rdx,%rsi
  805c55:	89 c7                	mov    %eax,%edi
  805c57:	48 b8 5c 5b 80 00 00 	movabs $0x805b5c,%rax
  805c5e:	00 00 00 
  805c61:	ff d0                	callq  *%rax
  805c63:	89 45 f8             	mov    %eax,-0x8(%rbp)
  805c66:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805c69:	89 c7                	mov    %eax,%edi
  805c6b:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  805c72:	00 00 00 
  805c75:	ff d0                	callq  *%rax
  805c77:	8b 45 f8             	mov    -0x8(%rbp),%eax
  805c7a:	c9                   	leaveq 
  805c7b:	c3                   	retq   

0000000000805c7c <fsipc>:
  805c7c:	55                   	push   %rbp
  805c7d:	48 89 e5             	mov    %rsp,%rbp
  805c80:	48 83 ec 10          	sub    $0x10,%rsp
  805c84:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805c87:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805c8b:	48 b8 08 60 81 00 00 	movabs $0x816008,%rax
  805c92:	00 00 00 
  805c95:	8b 00                	mov    (%rax),%eax
  805c97:	85 c0                	test   %eax,%eax
  805c99:	75 1d                	jne    805cb8 <fsipc+0x3c>
  805c9b:	bf 01 00 00 00       	mov    $0x1,%edi
  805ca0:	48 b8 a3 52 80 00 00 	movabs $0x8052a3,%rax
  805ca7:	00 00 00 
  805caa:	ff d0                	callq  *%rax
  805cac:	48 ba 08 60 81 00 00 	movabs $0x816008,%rdx
  805cb3:	00 00 00 
  805cb6:	89 02                	mov    %eax,(%rdx)
  805cb8:	48 b8 08 60 81 00 00 	movabs $0x816008,%rax
  805cbf:	00 00 00 
  805cc2:	8b 00                	mov    (%rax),%eax
  805cc4:	8b 75 fc             	mov    -0x4(%rbp),%esi
  805cc7:	b9 07 00 00 00       	mov    $0x7,%ecx
  805ccc:	48 ba 00 70 81 00 00 	movabs $0x817000,%rdx
  805cd3:	00 00 00 
  805cd6:	89 c7                	mov    %eax,%edi
  805cd8:	48 b8 98 51 80 00 00 	movabs $0x805198,%rax
  805cdf:	00 00 00 
  805ce2:	ff d0                	callq  *%rax
  805ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805ce8:	ba 00 00 00 00       	mov    $0x0,%edx
  805ced:	48 89 c6             	mov    %rax,%rsi
  805cf0:	bf 00 00 00 00       	mov    $0x0,%edi
  805cf5:	48 b8 d7 50 80 00 00 	movabs $0x8050d7,%rax
  805cfc:	00 00 00 
  805cff:	ff d0                	callq  *%rax
  805d01:	c9                   	leaveq 
  805d02:	c3                   	retq   

0000000000805d03 <open>:
  805d03:	55                   	push   %rbp
  805d04:	48 89 e5             	mov    %rsp,%rbp
  805d07:	48 83 ec 20          	sub    $0x20,%rsp
  805d0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  805d0f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  805d12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805d16:	48 89 c7             	mov    %rax,%rdi
  805d19:	48 b8 34 42 80 00 00 	movabs $0x804234,%rax
  805d20:	00 00 00 
  805d23:	ff d0                	callq  *%rax
  805d25:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  805d2a:	7e 0a                	jle    805d36 <open+0x33>
  805d2c:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  805d31:	e9 a5 00 00 00       	jmpq   805ddb <open+0xd8>
  805d36:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  805d3a:	48 89 c7             	mov    %rax,%rdi
  805d3d:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  805d44:	00 00 00 
  805d47:	ff d0                	callq  *%rax
  805d49:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805d4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805d50:	79 08                	jns    805d5a <open+0x57>
  805d52:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805d55:	e9 81 00 00 00       	jmpq   805ddb <open+0xd8>
  805d5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805d5e:	48 89 c6             	mov    %rax,%rsi
  805d61:	48 bf 00 70 81 00 00 	movabs $0x817000,%rdi
  805d68:	00 00 00 
  805d6b:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  805d72:	00 00 00 
  805d75:	ff d0                	callq  *%rax
  805d77:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805d7e:	00 00 00 
  805d81:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  805d84:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  805d8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805d8e:	48 89 c6             	mov    %rax,%rsi
  805d91:	bf 01 00 00 00       	mov    $0x1,%edi
  805d96:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  805d9d:	00 00 00 
  805da0:	ff d0                	callq  *%rax
  805da2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805da5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805da9:	79 1d                	jns    805dc8 <open+0xc5>
  805dab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805daf:	be 00 00 00 00       	mov    $0x0,%esi
  805db4:	48 89 c7             	mov    %rax,%rdi
  805db7:	48 b8 8b 54 80 00 00 	movabs $0x80548b,%rax
  805dbe:	00 00 00 
  805dc1:	ff d0                	callq  *%rax
  805dc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805dc6:	eb 13                	jmp    805ddb <open+0xd8>
  805dc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805dcc:	48 89 c7             	mov    %rax,%rdi
  805dcf:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  805dd6:	00 00 00 
  805dd9:	ff d0                	callq  *%rax
  805ddb:	c9                   	leaveq 
  805ddc:	c3                   	retq   

0000000000805ddd <devfile_flush>:
  805ddd:	55                   	push   %rbp
  805dde:	48 89 e5             	mov    %rsp,%rbp
  805de1:	48 83 ec 10          	sub    $0x10,%rsp
  805de5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  805de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805ded:	8b 50 0c             	mov    0xc(%rax),%edx
  805df0:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805df7:	00 00 00 
  805dfa:	89 10                	mov    %edx,(%rax)
  805dfc:	be 00 00 00 00       	mov    $0x0,%esi
  805e01:	bf 06 00 00 00       	mov    $0x6,%edi
  805e06:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  805e0d:	00 00 00 
  805e10:	ff d0                	callq  *%rax
  805e12:	c9                   	leaveq 
  805e13:	c3                   	retq   

0000000000805e14 <devfile_read>:
  805e14:	55                   	push   %rbp
  805e15:	48 89 e5             	mov    %rsp,%rbp
  805e18:	48 83 ec 30          	sub    $0x30,%rsp
  805e1c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  805e20:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805e24:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  805e28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805e2c:	8b 50 0c             	mov    0xc(%rax),%edx
  805e2f:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805e36:	00 00 00 
  805e39:	89 10                	mov    %edx,(%rax)
  805e3b:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805e42:	00 00 00 
  805e45:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  805e49:	48 89 50 08          	mov    %rdx,0x8(%rax)
  805e4d:	be 00 00 00 00       	mov    $0x0,%esi
  805e52:	bf 03 00 00 00       	mov    $0x3,%edi
  805e57:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  805e5e:	00 00 00 
  805e61:	ff d0                	callq  *%rax
  805e63:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805e66:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805e6a:	79 08                	jns    805e74 <devfile_read+0x60>
  805e6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805e6f:	e9 a4 00 00 00       	jmpq   805f18 <devfile_read+0x104>
  805e74:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805e77:	48 98                	cltq   
  805e79:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  805e7d:	76 35                	jbe    805eb4 <devfile_read+0xa0>
  805e7f:	48 b9 ee 80 80 00 00 	movabs $0x8080ee,%rcx
  805e86:	00 00 00 
  805e89:	48 ba f5 80 80 00 00 	movabs $0x8080f5,%rdx
  805e90:	00 00 00 
  805e93:	be 89 00 00 00       	mov    $0x89,%esi
  805e98:	48 bf 0a 81 80 00 00 	movabs $0x80810a,%rdi
  805e9f:	00 00 00 
  805ea2:	b8 00 00 00 00       	mov    $0x0,%eax
  805ea7:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  805eae:	00 00 00 
  805eb1:	41 ff d0             	callq  *%r8
  805eb4:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  805ebb:	7e 35                	jle    805ef2 <devfile_read+0xde>
  805ebd:	48 b9 18 81 80 00 00 	movabs $0x808118,%rcx
  805ec4:	00 00 00 
  805ec7:	48 ba f5 80 80 00 00 	movabs $0x8080f5,%rdx
  805ece:	00 00 00 
  805ed1:	be 8a 00 00 00       	mov    $0x8a,%esi
  805ed6:	48 bf 0a 81 80 00 00 	movabs $0x80810a,%rdi
  805edd:	00 00 00 
  805ee0:	b8 00 00 00 00       	mov    $0x0,%eax
  805ee5:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  805eec:	00 00 00 
  805eef:	41 ff d0             	callq  *%r8
  805ef2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805ef5:	48 63 d0             	movslq %eax,%rdx
  805ef8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805efc:	48 be 00 70 81 00 00 	movabs $0x817000,%rsi
  805f03:	00 00 00 
  805f06:	48 89 c7             	mov    %rax,%rdi
  805f09:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  805f10:	00 00 00 
  805f13:	ff d0                	callq  *%rax
  805f15:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805f18:	c9                   	leaveq 
  805f19:	c3                   	retq   

0000000000805f1a <devfile_write>:
  805f1a:	55                   	push   %rbp
  805f1b:	48 89 e5             	mov    %rsp,%rbp
  805f1e:	48 83 ec 40          	sub    $0x40,%rsp
  805f22:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  805f26:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  805f2a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  805f2e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  805f32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  805f36:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  805f3d:	00 
  805f3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805f42:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  805f46:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  805f4b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  805f4f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805f53:	8b 50 0c             	mov    0xc(%rax),%edx
  805f56:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805f5d:	00 00 00 
  805f60:	89 10                	mov    %edx,(%rax)
  805f62:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  805f69:	00 00 00 
  805f6c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  805f70:	48 89 50 08          	mov    %rdx,0x8(%rax)
  805f74:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  805f78:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805f7c:	48 89 c6             	mov    %rax,%rsi
  805f7f:	48 bf 10 70 81 00 00 	movabs $0x817010,%rdi
  805f86:	00 00 00 
  805f89:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  805f90:	00 00 00 
  805f93:	ff d0                	callq  *%rax
  805f95:	be 00 00 00 00       	mov    $0x0,%esi
  805f9a:	bf 04 00 00 00       	mov    $0x4,%edi
  805f9f:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  805fa6:	00 00 00 
  805fa9:	ff d0                	callq  *%rax
  805fab:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805fae:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805fb2:	79 05                	jns    805fb9 <devfile_write+0x9f>
  805fb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805fb7:	eb 43                	jmp    805ffc <devfile_write+0xe2>
  805fb9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805fbc:	48 98                	cltq   
  805fbe:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  805fc2:	76 35                	jbe    805ff9 <devfile_write+0xdf>
  805fc4:	48 b9 ee 80 80 00 00 	movabs $0x8080ee,%rcx
  805fcb:	00 00 00 
  805fce:	48 ba f5 80 80 00 00 	movabs $0x8080f5,%rdx
  805fd5:	00 00 00 
  805fd8:	be a8 00 00 00       	mov    $0xa8,%esi
  805fdd:	48 bf 0a 81 80 00 00 	movabs $0x80810a,%rdi
  805fe4:	00 00 00 
  805fe7:	b8 00 00 00 00       	mov    $0x0,%eax
  805fec:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  805ff3:	00 00 00 
  805ff6:	41 ff d0             	callq  *%r8
  805ff9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805ffc:	c9                   	leaveq 
  805ffd:	c3                   	retq   

0000000000805ffe <devfile_stat>:
  805ffe:	55                   	push   %rbp
  805fff:	48 89 e5             	mov    %rsp,%rbp
  806002:	48 83 ec 20          	sub    $0x20,%rsp
  806006:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80600a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80600e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806012:	8b 50 0c             	mov    0xc(%rax),%edx
  806015:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  80601c:	00 00 00 
  80601f:	89 10                	mov    %edx,(%rax)
  806021:	be 00 00 00 00       	mov    $0x0,%esi
  806026:	bf 05 00 00 00       	mov    $0x5,%edi
  80602b:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  806032:	00 00 00 
  806035:	ff d0                	callq  *%rax
  806037:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80603a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80603e:	79 05                	jns    806045 <devfile_stat+0x47>
  806040:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806043:	eb 56                	jmp    80609b <devfile_stat+0x9d>
  806045:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806049:	48 be 00 70 81 00 00 	movabs $0x817000,%rsi
  806050:	00 00 00 
  806053:	48 89 c7             	mov    %rax,%rdi
  806056:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  80605d:	00 00 00 
  806060:	ff d0                	callq  *%rax
  806062:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  806069:	00 00 00 
  80606c:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  806072:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806076:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80607c:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  806083:	00 00 00 
  806086:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80608c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806090:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  806096:	b8 00 00 00 00       	mov    $0x0,%eax
  80609b:	c9                   	leaveq 
  80609c:	c3                   	retq   

000000000080609d <devfile_trunc>:
  80609d:	55                   	push   %rbp
  80609e:	48 89 e5             	mov    %rsp,%rbp
  8060a1:	48 83 ec 10          	sub    $0x10,%rsp
  8060a5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8060a9:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8060ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8060b0:	8b 50 0c             	mov    0xc(%rax),%edx
  8060b3:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  8060ba:	00 00 00 
  8060bd:	89 10                	mov    %edx,(%rax)
  8060bf:	48 b8 00 70 81 00 00 	movabs $0x817000,%rax
  8060c6:	00 00 00 
  8060c9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8060cc:	89 50 04             	mov    %edx,0x4(%rax)
  8060cf:	be 00 00 00 00       	mov    $0x0,%esi
  8060d4:	bf 02 00 00 00       	mov    $0x2,%edi
  8060d9:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  8060e0:	00 00 00 
  8060e3:	ff d0                	callq  *%rax
  8060e5:	c9                   	leaveq 
  8060e6:	c3                   	retq   

00000000008060e7 <remove>:
  8060e7:	55                   	push   %rbp
  8060e8:	48 89 e5             	mov    %rsp,%rbp
  8060eb:	48 83 ec 10          	sub    $0x10,%rsp
  8060ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8060f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8060f7:	48 89 c7             	mov    %rax,%rdi
  8060fa:	48 b8 34 42 80 00 00 	movabs $0x804234,%rax
  806101:	00 00 00 
  806104:	ff d0                	callq  *%rax
  806106:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  80610b:	7e 07                	jle    806114 <remove+0x2d>
  80610d:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  806112:	eb 33                	jmp    806147 <remove+0x60>
  806114:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806118:	48 89 c6             	mov    %rax,%rsi
  80611b:	48 bf 00 70 81 00 00 	movabs $0x817000,%rdi
  806122:	00 00 00 
  806125:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  80612c:	00 00 00 
  80612f:	ff d0                	callq  *%rax
  806131:	be 00 00 00 00       	mov    $0x0,%esi
  806136:	bf 07 00 00 00       	mov    $0x7,%edi
  80613b:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  806142:	00 00 00 
  806145:	ff d0                	callq  *%rax
  806147:	c9                   	leaveq 
  806148:	c3                   	retq   

0000000000806149 <sync>:
  806149:	55                   	push   %rbp
  80614a:	48 89 e5             	mov    %rsp,%rbp
  80614d:	be 00 00 00 00       	mov    $0x0,%esi
  806152:	bf 08 00 00 00       	mov    $0x8,%edi
  806157:	48 b8 7c 5c 80 00 00 	movabs $0x805c7c,%rax
  80615e:	00 00 00 
  806161:	ff d0                	callq  *%rax
  806163:	5d                   	pop    %rbp
  806164:	c3                   	retq   

0000000000806165 <copy>:
  806165:	55                   	push   %rbp
  806166:	48 89 e5             	mov    %rsp,%rbp
  806169:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  806170:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  806177:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80617e:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  806185:	be 00 00 00 00       	mov    $0x0,%esi
  80618a:	48 89 c7             	mov    %rax,%rdi
  80618d:	48 b8 03 5d 80 00 00 	movabs $0x805d03,%rax
  806194:	00 00 00 
  806197:	ff d0                	callq  *%rax
  806199:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80619c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8061a0:	79 28                	jns    8061ca <copy+0x65>
  8061a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8061a5:	89 c6                	mov    %eax,%esi
  8061a7:	48 bf 24 81 80 00 00 	movabs $0x808124,%rdi
  8061ae:	00 00 00 
  8061b1:	b8 00 00 00 00       	mov    $0x0,%eax
  8061b6:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  8061bd:	00 00 00 
  8061c0:	ff d2                	callq  *%rdx
  8061c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8061c5:	e9 74 01 00 00       	jmpq   80633e <copy+0x1d9>
  8061ca:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  8061d1:	be 01 01 00 00       	mov    $0x101,%esi
  8061d6:	48 89 c7             	mov    %rax,%rdi
  8061d9:	48 b8 03 5d 80 00 00 	movabs $0x805d03,%rax
  8061e0:	00 00 00 
  8061e3:	ff d0                	callq  *%rax
  8061e5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8061e8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8061ec:	79 39                	jns    806227 <copy+0xc2>
  8061ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8061f1:	89 c6                	mov    %eax,%esi
  8061f3:	48 bf 3a 81 80 00 00 	movabs $0x80813a,%rdi
  8061fa:	00 00 00 
  8061fd:	b8 00 00 00 00       	mov    $0x0,%eax
  806202:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  806209:	00 00 00 
  80620c:	ff d2                	callq  *%rdx
  80620e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806211:	89 c7                	mov    %eax,%edi
  806213:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  80621a:	00 00 00 
  80621d:	ff d0                	callq  *%rax
  80621f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  806222:	e9 17 01 00 00       	jmpq   80633e <copy+0x1d9>
  806227:	eb 74                	jmp    80629d <copy+0x138>
  806229:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80622c:	48 63 d0             	movslq %eax,%rdx
  80622f:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  806236:	8b 45 f8             	mov    -0x8(%rbp),%eax
  806239:	48 89 ce             	mov    %rcx,%rsi
  80623c:	89 c7                	mov    %eax,%edi
  80623e:	48 b8 77 59 80 00 00 	movabs $0x805977,%rax
  806245:	00 00 00 
  806248:	ff d0                	callq  *%rax
  80624a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80624d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  806251:	79 4a                	jns    80629d <copy+0x138>
  806253:	8b 45 f0             	mov    -0x10(%rbp),%eax
  806256:	89 c6                	mov    %eax,%esi
  806258:	48 bf 54 81 80 00 00 	movabs $0x808154,%rdi
  80625f:	00 00 00 
  806262:	b8 00 00 00 00       	mov    $0x0,%eax
  806267:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  80626e:	00 00 00 
  806271:	ff d2                	callq  *%rdx
  806273:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806276:	89 c7                	mov    %eax,%edi
  806278:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  80627f:	00 00 00 
  806282:	ff d0                	callq  *%rax
  806284:	8b 45 f8             	mov    -0x8(%rbp),%eax
  806287:	89 c7                	mov    %eax,%edi
  806289:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  806290:	00 00 00 
  806293:	ff d0                	callq  *%rax
  806295:	8b 45 f0             	mov    -0x10(%rbp),%eax
  806298:	e9 a1 00 00 00       	jmpq   80633e <copy+0x1d9>
  80629d:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8062a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8062a7:	ba 00 02 00 00       	mov    $0x200,%edx
  8062ac:	48 89 ce             	mov    %rcx,%rsi
  8062af:	89 c7                	mov    %eax,%edi
  8062b1:	48 b8 2d 58 80 00 00 	movabs $0x80582d,%rax
  8062b8:	00 00 00 
  8062bb:	ff d0                	callq  *%rax
  8062bd:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8062c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8062c4:	0f 8f 5f ff ff ff    	jg     806229 <copy+0xc4>
  8062ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8062ce:	79 47                	jns    806317 <copy+0x1b2>
  8062d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8062d3:	89 c6                	mov    %eax,%esi
  8062d5:	48 bf 67 81 80 00 00 	movabs $0x808167,%rdi
  8062dc:	00 00 00 
  8062df:	b8 00 00 00 00       	mov    $0x0,%eax
  8062e4:	48 ba eb 36 80 00 00 	movabs $0x8036eb,%rdx
  8062eb:	00 00 00 
  8062ee:	ff d2                	callq  *%rdx
  8062f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8062f3:	89 c7                	mov    %eax,%edi
  8062f5:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  8062fc:	00 00 00 
  8062ff:	ff d0                	callq  *%rax
  806301:	8b 45 f8             	mov    -0x8(%rbp),%eax
  806304:	89 c7                	mov    %eax,%edi
  806306:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  80630d:	00 00 00 
  806310:	ff d0                	callq  *%rax
  806312:	8b 45 f4             	mov    -0xc(%rbp),%eax
  806315:	eb 27                	jmp    80633e <copy+0x1d9>
  806317:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80631a:	89 c7                	mov    %eax,%edi
  80631c:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  806323:	00 00 00 
  806326:	ff d0                	callq  *%rax
  806328:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80632b:	89 c7                	mov    %eax,%edi
  80632d:	48 b8 0b 56 80 00 00 	movabs $0x80560b,%rax
  806334:	00 00 00 
  806337:	ff d0                	callq  *%rax
  806339:	b8 00 00 00 00       	mov    $0x0,%eax
  80633e:	c9                   	leaveq 
  80633f:	c3                   	retq   

0000000000806340 <pageref>:
  806340:	55                   	push   %rbp
  806341:	48 89 e5             	mov    %rsp,%rbp
  806344:	48 83 ec 18          	sub    $0x18,%rsp
  806348:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80634c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806350:	48 c1 e8 15          	shr    $0x15,%rax
  806354:	48 89 c2             	mov    %rax,%rdx
  806357:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80635e:	01 00 00 
  806361:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  806365:	83 e0 01             	and    $0x1,%eax
  806368:	48 85 c0             	test   %rax,%rax
  80636b:	75 07                	jne    806374 <pageref+0x34>
  80636d:	b8 00 00 00 00       	mov    $0x0,%eax
  806372:	eb 53                	jmp    8063c7 <pageref+0x87>
  806374:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806378:	48 c1 e8 0c          	shr    $0xc,%rax
  80637c:	48 89 c2             	mov    %rax,%rdx
  80637f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  806386:	01 00 00 
  806389:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80638d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  806391:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806395:	83 e0 01             	and    $0x1,%eax
  806398:	48 85 c0             	test   %rax,%rax
  80639b:	75 07                	jne    8063a4 <pageref+0x64>
  80639d:	b8 00 00 00 00       	mov    $0x0,%eax
  8063a2:	eb 23                	jmp    8063c7 <pageref+0x87>
  8063a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8063a8:	48 c1 e8 0c          	shr    $0xc,%rax
  8063ac:	48 89 c2             	mov    %rax,%rdx
  8063af:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  8063b6:	00 00 00 
  8063b9:	48 c1 e2 04          	shl    $0x4,%rdx
  8063bd:	48 01 d0             	add    %rdx,%rax
  8063c0:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  8063c4:	0f b7 c0             	movzwl %ax,%eax
  8063c7:	c9                   	leaveq 
  8063c8:	c3                   	retq   

00000000008063c9 <fd2sockid>:
  8063c9:	55                   	push   %rbp
  8063ca:	48 89 e5             	mov    %rsp,%rbp
  8063cd:	48 83 ec 20          	sub    $0x20,%rsp
  8063d1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8063d4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8063d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8063db:	48 89 d6             	mov    %rdx,%rsi
  8063de:	89 c7                	mov    %eax,%edi
  8063e0:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  8063e7:	00 00 00 
  8063ea:	ff d0                	callq  *%rax
  8063ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8063ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8063f3:	79 05                	jns    8063fa <fd2sockid+0x31>
  8063f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8063f8:	eb 24                	jmp    80641e <fd2sockid+0x55>
  8063fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8063fe:	8b 10                	mov    (%rax),%edx
  806400:	48 b8 20 21 81 00 00 	movabs $0x812120,%rax
  806407:	00 00 00 
  80640a:	8b 00                	mov    (%rax),%eax
  80640c:	39 c2                	cmp    %eax,%edx
  80640e:	74 07                	je     806417 <fd2sockid+0x4e>
  806410:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  806415:	eb 07                	jmp    80641e <fd2sockid+0x55>
  806417:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80641b:	8b 40 0c             	mov    0xc(%rax),%eax
  80641e:	c9                   	leaveq 
  80641f:	c3                   	retq   

0000000000806420 <alloc_sockfd>:
  806420:	55                   	push   %rbp
  806421:	48 89 e5             	mov    %rsp,%rbp
  806424:	48 83 ec 20          	sub    $0x20,%rsp
  806428:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80642b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80642f:	48 89 c7             	mov    %rax,%rdi
  806432:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  806439:	00 00 00 
  80643c:	ff d0                	callq  *%rax
  80643e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806441:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806445:	78 26                	js     80646d <alloc_sockfd+0x4d>
  806447:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80644b:	ba 07 04 00 00       	mov    $0x407,%edx
  806450:	48 89 c6             	mov    %rax,%rsi
  806453:	bf 00 00 00 00       	mov    $0x0,%edi
  806458:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  80645f:	00 00 00 
  806462:	ff d0                	callq  *%rax
  806464:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806467:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80646b:	79 16                	jns    806483 <alloc_sockfd+0x63>
  80646d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806470:	89 c7                	mov    %eax,%edi
  806472:	48 b8 2d 69 80 00 00 	movabs $0x80692d,%rax
  806479:	00 00 00 
  80647c:	ff d0                	callq  *%rax
  80647e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806481:	eb 3a                	jmp    8064bd <alloc_sockfd+0x9d>
  806483:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806487:	48 ba 20 21 81 00 00 	movabs $0x812120,%rdx
  80648e:	00 00 00 
  806491:	8b 12                	mov    (%rdx),%edx
  806493:	89 10                	mov    %edx,(%rax)
  806495:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806499:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8064a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8064a4:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8064a7:	89 50 0c             	mov    %edx,0xc(%rax)
  8064aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8064ae:	48 89 c7             	mov    %rax,%rdi
  8064b1:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  8064b8:	00 00 00 
  8064bb:	ff d0                	callq  *%rax
  8064bd:	c9                   	leaveq 
  8064be:	c3                   	retq   

00000000008064bf <accept>:
  8064bf:	55                   	push   %rbp
  8064c0:	48 89 e5             	mov    %rsp,%rbp
  8064c3:	48 83 ec 30          	sub    $0x30,%rsp
  8064c7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8064ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8064ce:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8064d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8064d5:	89 c7                	mov    %eax,%edi
  8064d7:	48 b8 c9 63 80 00 00 	movabs $0x8063c9,%rax
  8064de:	00 00 00 
  8064e1:	ff d0                	callq  *%rax
  8064e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8064e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8064ea:	79 05                	jns    8064f1 <accept+0x32>
  8064ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8064ef:	eb 3b                	jmp    80652c <accept+0x6d>
  8064f1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8064f5:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8064f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8064fc:	48 89 ce             	mov    %rcx,%rsi
  8064ff:	89 c7                	mov    %eax,%edi
  806501:	48 b8 0a 68 80 00 00 	movabs $0x80680a,%rax
  806508:	00 00 00 
  80650b:	ff d0                	callq  *%rax
  80650d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806510:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806514:	79 05                	jns    80651b <accept+0x5c>
  806516:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806519:	eb 11                	jmp    80652c <accept+0x6d>
  80651b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80651e:	89 c7                	mov    %eax,%edi
  806520:	48 b8 20 64 80 00 00 	movabs $0x806420,%rax
  806527:	00 00 00 
  80652a:	ff d0                	callq  *%rax
  80652c:	c9                   	leaveq 
  80652d:	c3                   	retq   

000000000080652e <bind>:
  80652e:	55                   	push   %rbp
  80652f:	48 89 e5             	mov    %rsp,%rbp
  806532:	48 83 ec 20          	sub    $0x20,%rsp
  806536:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806539:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80653d:	89 55 e8             	mov    %edx,-0x18(%rbp)
  806540:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806543:	89 c7                	mov    %eax,%edi
  806545:	48 b8 c9 63 80 00 00 	movabs $0x8063c9,%rax
  80654c:	00 00 00 
  80654f:	ff d0                	callq  *%rax
  806551:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806554:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806558:	79 05                	jns    80655f <bind+0x31>
  80655a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80655d:	eb 1b                	jmp    80657a <bind+0x4c>
  80655f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  806562:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  806566:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806569:	48 89 ce             	mov    %rcx,%rsi
  80656c:	89 c7                	mov    %eax,%edi
  80656e:	48 b8 89 68 80 00 00 	movabs $0x806889,%rax
  806575:	00 00 00 
  806578:	ff d0                	callq  *%rax
  80657a:	c9                   	leaveq 
  80657b:	c3                   	retq   

000000000080657c <shutdown>:
  80657c:	55                   	push   %rbp
  80657d:	48 89 e5             	mov    %rsp,%rbp
  806580:	48 83 ec 20          	sub    $0x20,%rsp
  806584:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806587:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80658a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80658d:	89 c7                	mov    %eax,%edi
  80658f:	48 b8 c9 63 80 00 00 	movabs $0x8063c9,%rax
  806596:	00 00 00 
  806599:	ff d0                	callq  *%rax
  80659b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80659e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8065a2:	79 05                	jns    8065a9 <shutdown+0x2d>
  8065a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8065a7:	eb 16                	jmp    8065bf <shutdown+0x43>
  8065a9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8065ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8065af:	89 d6                	mov    %edx,%esi
  8065b1:	89 c7                	mov    %eax,%edi
  8065b3:	48 b8 ed 68 80 00 00 	movabs $0x8068ed,%rax
  8065ba:	00 00 00 
  8065bd:	ff d0                	callq  *%rax
  8065bf:	c9                   	leaveq 
  8065c0:	c3                   	retq   

00000000008065c1 <devsock_close>:
  8065c1:	55                   	push   %rbp
  8065c2:	48 89 e5             	mov    %rsp,%rbp
  8065c5:	48 83 ec 10          	sub    $0x10,%rsp
  8065c9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8065cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8065d1:	48 89 c7             	mov    %rax,%rdi
  8065d4:	48 b8 40 63 80 00 00 	movabs $0x806340,%rax
  8065db:	00 00 00 
  8065de:	ff d0                	callq  *%rax
  8065e0:	83 f8 01             	cmp    $0x1,%eax
  8065e3:	75 17                	jne    8065fc <devsock_close+0x3b>
  8065e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8065e9:	8b 40 0c             	mov    0xc(%rax),%eax
  8065ec:	89 c7                	mov    %eax,%edi
  8065ee:	48 b8 2d 69 80 00 00 	movabs $0x80692d,%rax
  8065f5:	00 00 00 
  8065f8:	ff d0                	callq  *%rax
  8065fa:	eb 05                	jmp    806601 <devsock_close+0x40>
  8065fc:	b8 00 00 00 00       	mov    $0x0,%eax
  806601:	c9                   	leaveq 
  806602:	c3                   	retq   

0000000000806603 <connect>:
  806603:	55                   	push   %rbp
  806604:	48 89 e5             	mov    %rsp,%rbp
  806607:	48 83 ec 20          	sub    $0x20,%rsp
  80660b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80660e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  806612:	89 55 e8             	mov    %edx,-0x18(%rbp)
  806615:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806618:	89 c7                	mov    %eax,%edi
  80661a:	48 b8 c9 63 80 00 00 	movabs $0x8063c9,%rax
  806621:	00 00 00 
  806624:	ff d0                	callq  *%rax
  806626:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806629:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80662d:	79 05                	jns    806634 <connect+0x31>
  80662f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806632:	eb 1b                	jmp    80664f <connect+0x4c>
  806634:	8b 55 e8             	mov    -0x18(%rbp),%edx
  806637:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80663b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80663e:	48 89 ce             	mov    %rcx,%rsi
  806641:	89 c7                	mov    %eax,%edi
  806643:	48 b8 5a 69 80 00 00 	movabs $0x80695a,%rax
  80664a:	00 00 00 
  80664d:	ff d0                	callq  *%rax
  80664f:	c9                   	leaveq 
  806650:	c3                   	retq   

0000000000806651 <listen>:
  806651:	55                   	push   %rbp
  806652:	48 89 e5             	mov    %rsp,%rbp
  806655:	48 83 ec 20          	sub    $0x20,%rsp
  806659:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80665c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80665f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806662:	89 c7                	mov    %eax,%edi
  806664:	48 b8 c9 63 80 00 00 	movabs $0x8063c9,%rax
  80666b:	00 00 00 
  80666e:	ff d0                	callq  *%rax
  806670:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806673:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806677:	79 05                	jns    80667e <listen+0x2d>
  806679:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80667c:	eb 16                	jmp    806694 <listen+0x43>
  80667e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  806681:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806684:	89 d6                	mov    %edx,%esi
  806686:	89 c7                	mov    %eax,%edi
  806688:	48 b8 be 69 80 00 00 	movabs $0x8069be,%rax
  80668f:	00 00 00 
  806692:	ff d0                	callq  *%rax
  806694:	c9                   	leaveq 
  806695:	c3                   	retq   

0000000000806696 <devsock_read>:
  806696:	55                   	push   %rbp
  806697:	48 89 e5             	mov    %rsp,%rbp
  80669a:	48 83 ec 20          	sub    $0x20,%rsp
  80669e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8066a2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8066a6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8066aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8066ae:	89 c2                	mov    %eax,%edx
  8066b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8066b4:	8b 40 0c             	mov    0xc(%rax),%eax
  8066b7:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8066bb:	b9 00 00 00 00       	mov    $0x0,%ecx
  8066c0:	89 c7                	mov    %eax,%edi
  8066c2:	48 b8 fe 69 80 00 00 	movabs $0x8069fe,%rax
  8066c9:	00 00 00 
  8066cc:	ff d0                	callq  *%rax
  8066ce:	c9                   	leaveq 
  8066cf:	c3                   	retq   

00000000008066d0 <devsock_write>:
  8066d0:	55                   	push   %rbp
  8066d1:	48 89 e5             	mov    %rsp,%rbp
  8066d4:	48 83 ec 20          	sub    $0x20,%rsp
  8066d8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8066dc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8066e0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8066e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8066e8:	89 c2                	mov    %eax,%edx
  8066ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8066ee:	8b 40 0c             	mov    0xc(%rax),%eax
  8066f1:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8066f5:	b9 00 00 00 00       	mov    $0x0,%ecx
  8066fa:	89 c7                	mov    %eax,%edi
  8066fc:	48 b8 ca 6a 80 00 00 	movabs $0x806aca,%rax
  806703:	00 00 00 
  806706:	ff d0                	callq  *%rax
  806708:	c9                   	leaveq 
  806709:	c3                   	retq   

000000000080670a <devsock_stat>:
  80670a:	55                   	push   %rbp
  80670b:	48 89 e5             	mov    %rsp,%rbp
  80670e:	48 83 ec 10          	sub    $0x10,%rsp
  806712:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  806716:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80671a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80671e:	48 be 82 81 80 00 00 	movabs $0x808182,%rsi
  806725:	00 00 00 
  806728:	48 89 c7             	mov    %rax,%rdi
  80672b:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  806732:	00 00 00 
  806735:	ff d0                	callq  *%rax
  806737:	b8 00 00 00 00       	mov    $0x0,%eax
  80673c:	c9                   	leaveq 
  80673d:	c3                   	retq   

000000000080673e <socket>:
  80673e:	55                   	push   %rbp
  80673f:	48 89 e5             	mov    %rsp,%rbp
  806742:	48 83 ec 20          	sub    $0x20,%rsp
  806746:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806749:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80674c:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80674f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  806752:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  806755:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806758:	89 ce                	mov    %ecx,%esi
  80675a:	89 c7                	mov    %eax,%edi
  80675c:	48 b8 82 6b 80 00 00 	movabs $0x806b82,%rax
  806763:	00 00 00 
  806766:	ff d0                	callq  *%rax
  806768:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80676b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80676f:	79 05                	jns    806776 <socket+0x38>
  806771:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806774:	eb 11                	jmp    806787 <socket+0x49>
  806776:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806779:	89 c7                	mov    %eax,%edi
  80677b:	48 b8 20 64 80 00 00 	movabs $0x806420,%rax
  806782:	00 00 00 
  806785:	ff d0                	callq  *%rax
  806787:	c9                   	leaveq 
  806788:	c3                   	retq   

0000000000806789 <nsipc>:
  806789:	55                   	push   %rbp
  80678a:	48 89 e5             	mov    %rsp,%rbp
  80678d:	48 83 ec 10          	sub    $0x10,%rsp
  806791:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806794:	48 b8 0c 60 81 00 00 	movabs $0x81600c,%rax
  80679b:	00 00 00 
  80679e:	8b 00                	mov    (%rax),%eax
  8067a0:	85 c0                	test   %eax,%eax
  8067a2:	75 1d                	jne    8067c1 <nsipc+0x38>
  8067a4:	bf 02 00 00 00       	mov    $0x2,%edi
  8067a9:	48 b8 a3 52 80 00 00 	movabs $0x8052a3,%rax
  8067b0:	00 00 00 
  8067b3:	ff d0                	callq  *%rax
  8067b5:	48 ba 0c 60 81 00 00 	movabs $0x81600c,%rdx
  8067bc:	00 00 00 
  8067bf:	89 02                	mov    %eax,(%rdx)
  8067c1:	48 b8 0c 60 81 00 00 	movabs $0x81600c,%rax
  8067c8:	00 00 00 
  8067cb:	8b 00                	mov    (%rax),%eax
  8067cd:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8067d0:	b9 07 00 00 00       	mov    $0x7,%ecx
  8067d5:	48 ba 00 90 81 00 00 	movabs $0x819000,%rdx
  8067dc:	00 00 00 
  8067df:	89 c7                	mov    %eax,%edi
  8067e1:	48 b8 98 51 80 00 00 	movabs $0x805198,%rax
  8067e8:	00 00 00 
  8067eb:	ff d0                	callq  *%rax
  8067ed:	ba 00 00 00 00       	mov    $0x0,%edx
  8067f2:	be 00 00 00 00       	mov    $0x0,%esi
  8067f7:	bf 00 00 00 00       	mov    $0x0,%edi
  8067fc:	48 b8 d7 50 80 00 00 	movabs $0x8050d7,%rax
  806803:	00 00 00 
  806806:	ff d0                	callq  *%rax
  806808:	c9                   	leaveq 
  806809:	c3                   	retq   

000000000080680a <nsipc_accept>:
  80680a:	55                   	push   %rbp
  80680b:	48 89 e5             	mov    %rsp,%rbp
  80680e:	48 83 ec 30          	sub    $0x30,%rsp
  806812:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806815:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  806819:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80681d:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806824:	00 00 00 
  806827:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80682a:	89 10                	mov    %edx,(%rax)
  80682c:	bf 01 00 00 00       	mov    $0x1,%edi
  806831:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806838:	00 00 00 
  80683b:	ff d0                	callq  *%rax
  80683d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806840:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806844:	78 3e                	js     806884 <nsipc_accept+0x7a>
  806846:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  80684d:	00 00 00 
  806850:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  806854:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806858:	8b 40 10             	mov    0x10(%rax),%eax
  80685b:	89 c2                	mov    %eax,%edx
  80685d:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  806861:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806865:	48 89 ce             	mov    %rcx,%rsi
  806868:	48 89 c7             	mov    %rax,%rdi
  80686b:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  806872:	00 00 00 
  806875:	ff d0                	callq  *%rax
  806877:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80687b:	8b 50 10             	mov    0x10(%rax),%edx
  80687e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806882:	89 10                	mov    %edx,(%rax)
  806884:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806887:	c9                   	leaveq 
  806888:	c3                   	retq   

0000000000806889 <nsipc_bind>:
  806889:	55                   	push   %rbp
  80688a:	48 89 e5             	mov    %rsp,%rbp
  80688d:	48 83 ec 10          	sub    $0x10,%rsp
  806891:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806894:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  806898:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80689b:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  8068a2:	00 00 00 
  8068a5:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8068a8:	89 10                	mov    %edx,(%rax)
  8068aa:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8068ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8068b1:	48 89 c6             	mov    %rax,%rsi
  8068b4:	48 bf 04 90 81 00 00 	movabs $0x819004,%rdi
  8068bb:	00 00 00 
  8068be:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  8068c5:	00 00 00 
  8068c8:	ff d0                	callq  *%rax
  8068ca:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  8068d1:	00 00 00 
  8068d4:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8068d7:	89 50 14             	mov    %edx,0x14(%rax)
  8068da:	bf 02 00 00 00       	mov    $0x2,%edi
  8068df:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  8068e6:	00 00 00 
  8068e9:	ff d0                	callq  *%rax
  8068eb:	c9                   	leaveq 
  8068ec:	c3                   	retq   

00000000008068ed <nsipc_shutdown>:
  8068ed:	55                   	push   %rbp
  8068ee:	48 89 e5             	mov    %rsp,%rbp
  8068f1:	48 83 ec 10          	sub    $0x10,%rsp
  8068f5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8068f8:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8068fb:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806902:	00 00 00 
  806905:	8b 55 fc             	mov    -0x4(%rbp),%edx
  806908:	89 10                	mov    %edx,(%rax)
  80690a:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806911:	00 00 00 
  806914:	8b 55 f8             	mov    -0x8(%rbp),%edx
  806917:	89 50 04             	mov    %edx,0x4(%rax)
  80691a:	bf 03 00 00 00       	mov    $0x3,%edi
  80691f:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806926:	00 00 00 
  806929:	ff d0                	callq  *%rax
  80692b:	c9                   	leaveq 
  80692c:	c3                   	retq   

000000000080692d <nsipc_close>:
  80692d:	55                   	push   %rbp
  80692e:	48 89 e5             	mov    %rsp,%rbp
  806931:	48 83 ec 10          	sub    $0x10,%rsp
  806935:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806938:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  80693f:	00 00 00 
  806942:	8b 55 fc             	mov    -0x4(%rbp),%edx
  806945:	89 10                	mov    %edx,(%rax)
  806947:	bf 04 00 00 00       	mov    $0x4,%edi
  80694c:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806953:	00 00 00 
  806956:	ff d0                	callq  *%rax
  806958:	c9                   	leaveq 
  806959:	c3                   	retq   

000000000080695a <nsipc_connect>:
  80695a:	55                   	push   %rbp
  80695b:	48 89 e5             	mov    %rsp,%rbp
  80695e:	48 83 ec 10          	sub    $0x10,%rsp
  806962:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806965:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  806969:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80696c:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806973:	00 00 00 
  806976:	8b 55 fc             	mov    -0x4(%rbp),%edx
  806979:	89 10                	mov    %edx,(%rax)
  80697b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80697e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806982:	48 89 c6             	mov    %rax,%rsi
  806985:	48 bf 04 90 81 00 00 	movabs $0x819004,%rdi
  80698c:	00 00 00 
  80698f:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  806996:	00 00 00 
  806999:	ff d0                	callq  *%rax
  80699b:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  8069a2:	00 00 00 
  8069a5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8069a8:	89 50 14             	mov    %edx,0x14(%rax)
  8069ab:	bf 05 00 00 00       	mov    $0x5,%edi
  8069b0:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  8069b7:	00 00 00 
  8069ba:	ff d0                	callq  *%rax
  8069bc:	c9                   	leaveq 
  8069bd:	c3                   	retq   

00000000008069be <nsipc_listen>:
  8069be:	55                   	push   %rbp
  8069bf:	48 89 e5             	mov    %rsp,%rbp
  8069c2:	48 83 ec 10          	sub    $0x10,%rsp
  8069c6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8069c9:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8069cc:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  8069d3:	00 00 00 
  8069d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8069d9:	89 10                	mov    %edx,(%rax)
  8069db:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  8069e2:	00 00 00 
  8069e5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8069e8:	89 50 04             	mov    %edx,0x4(%rax)
  8069eb:	bf 06 00 00 00       	mov    $0x6,%edi
  8069f0:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  8069f7:	00 00 00 
  8069fa:	ff d0                	callq  *%rax
  8069fc:	c9                   	leaveq 
  8069fd:	c3                   	retq   

00000000008069fe <nsipc_recv>:
  8069fe:	55                   	push   %rbp
  8069ff:	48 89 e5             	mov    %rsp,%rbp
  806a02:	48 83 ec 30          	sub    $0x30,%rsp
  806a06:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806a09:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  806a0d:	89 55 e8             	mov    %edx,-0x18(%rbp)
  806a10:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  806a13:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806a1a:	00 00 00 
  806a1d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  806a20:	89 10                	mov    %edx,(%rax)
  806a22:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806a29:	00 00 00 
  806a2c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  806a2f:	89 50 04             	mov    %edx,0x4(%rax)
  806a32:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806a39:	00 00 00 
  806a3c:	8b 55 dc             	mov    -0x24(%rbp),%edx
  806a3f:	89 50 08             	mov    %edx,0x8(%rax)
  806a42:	bf 07 00 00 00       	mov    $0x7,%edi
  806a47:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806a4e:	00 00 00 
  806a51:	ff d0                	callq  *%rax
  806a53:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806a56:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806a5a:	78 69                	js     806ac5 <nsipc_recv+0xc7>
  806a5c:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  806a63:	7f 08                	jg     806a6d <nsipc_recv+0x6f>
  806a65:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806a68:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  806a6b:	7e 35                	jle    806aa2 <nsipc_recv+0xa4>
  806a6d:	48 b9 89 81 80 00 00 	movabs $0x808189,%rcx
  806a74:	00 00 00 
  806a77:	48 ba 9e 81 80 00 00 	movabs $0x80819e,%rdx
  806a7e:	00 00 00 
  806a81:	be 62 00 00 00       	mov    $0x62,%esi
  806a86:	48 bf b3 81 80 00 00 	movabs $0x8081b3,%rdi
  806a8d:	00 00 00 
  806a90:	b8 00 00 00 00       	mov    $0x0,%eax
  806a95:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  806a9c:	00 00 00 
  806a9f:	41 ff d0             	callq  *%r8
  806aa2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806aa5:	48 63 d0             	movslq %eax,%rdx
  806aa8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806aac:	48 be 00 90 81 00 00 	movabs $0x819000,%rsi
  806ab3:	00 00 00 
  806ab6:	48 89 c7             	mov    %rax,%rdi
  806ab9:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  806ac0:	00 00 00 
  806ac3:	ff d0                	callq  *%rax
  806ac5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806ac8:	c9                   	leaveq 
  806ac9:	c3                   	retq   

0000000000806aca <nsipc_send>:
  806aca:	55                   	push   %rbp
  806acb:	48 89 e5             	mov    %rsp,%rbp
  806ace:	48 83 ec 20          	sub    $0x20,%rsp
  806ad2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806ad5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  806ad9:	89 55 f8             	mov    %edx,-0x8(%rbp)
  806adc:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  806adf:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806ae6:	00 00 00 
  806ae9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  806aec:	89 10                	mov    %edx,(%rax)
  806aee:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  806af5:	7e 35                	jle    806b2c <nsipc_send+0x62>
  806af7:	48 b9 c2 81 80 00 00 	movabs $0x8081c2,%rcx
  806afe:	00 00 00 
  806b01:	48 ba 9e 81 80 00 00 	movabs $0x80819e,%rdx
  806b08:	00 00 00 
  806b0b:	be 6d 00 00 00       	mov    $0x6d,%esi
  806b10:	48 bf b3 81 80 00 00 	movabs $0x8081b3,%rdi
  806b17:	00 00 00 
  806b1a:	b8 00 00 00 00       	mov    $0x0,%eax
  806b1f:	49 b8 b2 34 80 00 00 	movabs $0x8034b2,%r8
  806b26:	00 00 00 
  806b29:	41 ff d0             	callq  *%r8
  806b2c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  806b2f:	48 63 d0             	movslq %eax,%rdx
  806b32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806b36:	48 89 c6             	mov    %rax,%rsi
  806b39:	48 bf 0c 90 81 00 00 	movabs $0x81900c,%rdi
  806b40:	00 00 00 
  806b43:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  806b4a:	00 00 00 
  806b4d:	ff d0                	callq  *%rax
  806b4f:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806b56:	00 00 00 
  806b59:	8b 55 f8             	mov    -0x8(%rbp),%edx
  806b5c:	89 50 04             	mov    %edx,0x4(%rax)
  806b5f:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806b66:	00 00 00 
  806b69:	8b 55 ec             	mov    -0x14(%rbp),%edx
  806b6c:	89 50 08             	mov    %edx,0x8(%rax)
  806b6f:	bf 08 00 00 00       	mov    $0x8,%edi
  806b74:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806b7b:	00 00 00 
  806b7e:	ff d0                	callq  *%rax
  806b80:	c9                   	leaveq 
  806b81:	c3                   	retq   

0000000000806b82 <nsipc_socket>:
  806b82:	55                   	push   %rbp
  806b83:	48 89 e5             	mov    %rsp,%rbp
  806b86:	48 83 ec 10          	sub    $0x10,%rsp
  806b8a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806b8d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  806b90:	89 55 f4             	mov    %edx,-0xc(%rbp)
  806b93:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806b9a:	00 00 00 
  806b9d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  806ba0:	89 10                	mov    %edx,(%rax)
  806ba2:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806ba9:	00 00 00 
  806bac:	8b 55 f8             	mov    -0x8(%rbp),%edx
  806baf:	89 50 04             	mov    %edx,0x4(%rax)
  806bb2:	48 b8 00 90 81 00 00 	movabs $0x819000,%rax
  806bb9:	00 00 00 
  806bbc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  806bbf:	89 50 08             	mov    %edx,0x8(%rax)
  806bc2:	bf 09 00 00 00       	mov    $0x9,%edi
  806bc7:	48 b8 89 67 80 00 00 	movabs $0x806789,%rax
  806bce:	00 00 00 
  806bd1:	ff d0                	callq  *%rax
  806bd3:	c9                   	leaveq 
  806bd4:	c3                   	retq   

0000000000806bd5 <pipe>:
  806bd5:	55                   	push   %rbp
  806bd6:	48 89 e5             	mov    %rsp,%rbp
  806bd9:	53                   	push   %rbx
  806bda:	48 83 ec 38          	sub    $0x38,%rsp
  806bde:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  806be2:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  806be6:	48 89 c7             	mov    %rax,%rdi
  806be9:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  806bf0:	00 00 00 
  806bf3:	ff d0                	callq  *%rax
  806bf5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806bf8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806bfc:	0f 88 bf 01 00 00    	js     806dc1 <pipe+0x1ec>
  806c02:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806c06:	ba 07 04 00 00       	mov    $0x407,%edx
  806c0b:	48 89 c6             	mov    %rax,%rsi
  806c0e:	bf 00 00 00 00       	mov    $0x0,%edi
  806c13:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  806c1a:	00 00 00 
  806c1d:	ff d0                	callq  *%rax
  806c1f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806c22:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806c26:	0f 88 95 01 00 00    	js     806dc1 <pipe+0x1ec>
  806c2c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  806c30:	48 89 c7             	mov    %rax,%rdi
  806c33:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  806c3a:	00 00 00 
  806c3d:	ff d0                	callq  *%rax
  806c3f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806c42:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806c46:	0f 88 5d 01 00 00    	js     806da9 <pipe+0x1d4>
  806c4c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806c50:	ba 07 04 00 00       	mov    $0x407,%edx
  806c55:	48 89 c6             	mov    %rax,%rsi
  806c58:	bf 00 00 00 00       	mov    $0x0,%edi
  806c5d:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  806c64:	00 00 00 
  806c67:	ff d0                	callq  *%rax
  806c69:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806c6c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806c70:	0f 88 33 01 00 00    	js     806da9 <pipe+0x1d4>
  806c76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806c7a:	48 89 c7             	mov    %rax,%rdi
  806c7d:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  806c84:	00 00 00 
  806c87:	ff d0                	callq  *%rax
  806c89:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  806c8d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806c91:	ba 07 04 00 00       	mov    $0x407,%edx
  806c96:	48 89 c6             	mov    %rax,%rsi
  806c99:	bf 00 00 00 00       	mov    $0x0,%edi
  806c9e:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  806ca5:	00 00 00 
  806ca8:	ff d0                	callq  *%rax
  806caa:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806cad:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806cb1:	79 05                	jns    806cb8 <pipe+0xe3>
  806cb3:	e9 d9 00 00 00       	jmpq   806d91 <pipe+0x1bc>
  806cb8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806cbc:	48 89 c7             	mov    %rax,%rdi
  806cbf:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  806cc6:	00 00 00 
  806cc9:	ff d0                	callq  *%rax
  806ccb:	48 89 c2             	mov    %rax,%rdx
  806cce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806cd2:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  806cd8:	48 89 d1             	mov    %rdx,%rcx
  806cdb:	ba 00 00 00 00       	mov    $0x0,%edx
  806ce0:	48 89 c6             	mov    %rax,%rsi
  806ce3:	bf 00 00 00 00       	mov    $0x0,%edi
  806ce8:	48 b8 1f 4c 80 00 00 	movabs $0x804c1f,%rax
  806cef:	00 00 00 
  806cf2:	ff d0                	callq  *%rax
  806cf4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806cf7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806cfb:	79 1b                	jns    806d18 <pipe+0x143>
  806cfd:	90                   	nop
  806cfe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806d02:	48 89 c6             	mov    %rax,%rsi
  806d05:	bf 00 00 00 00       	mov    $0x0,%edi
  806d0a:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  806d11:	00 00 00 
  806d14:	ff d0                	callq  *%rax
  806d16:	eb 79                	jmp    806d91 <pipe+0x1bc>
  806d18:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806d1c:	48 ba 60 21 81 00 00 	movabs $0x812160,%rdx
  806d23:	00 00 00 
  806d26:	8b 12                	mov    (%rdx),%edx
  806d28:	89 10                	mov    %edx,(%rax)
  806d2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806d2e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  806d35:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806d39:	48 ba 60 21 81 00 00 	movabs $0x812160,%rdx
  806d40:	00 00 00 
  806d43:	8b 12                	mov    (%rdx),%edx
  806d45:	89 10                	mov    %edx,(%rax)
  806d47:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806d4b:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  806d52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806d56:	48 89 c7             	mov    %rax,%rdi
  806d59:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  806d60:	00 00 00 
  806d63:	ff d0                	callq  *%rax
  806d65:	89 c2                	mov    %eax,%edx
  806d67:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  806d6b:	89 10                	mov    %edx,(%rax)
  806d6d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  806d71:	48 8d 58 04          	lea    0x4(%rax),%rbx
  806d75:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806d79:	48 89 c7             	mov    %rax,%rdi
  806d7c:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  806d83:	00 00 00 
  806d86:	ff d0                	callq  *%rax
  806d88:	89 03                	mov    %eax,(%rbx)
  806d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  806d8f:	eb 33                	jmp    806dc4 <pipe+0x1ef>
  806d91:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806d95:	48 89 c6             	mov    %rax,%rsi
  806d98:	bf 00 00 00 00       	mov    $0x0,%edi
  806d9d:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  806da4:	00 00 00 
  806da7:	ff d0                	callq  *%rax
  806da9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806dad:	48 89 c6             	mov    %rax,%rsi
  806db0:	bf 00 00 00 00       	mov    $0x0,%edi
  806db5:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  806dbc:	00 00 00 
  806dbf:	ff d0                	callq  *%rax
  806dc1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806dc4:	48 83 c4 38          	add    $0x38,%rsp
  806dc8:	5b                   	pop    %rbx
  806dc9:	5d                   	pop    %rbp
  806dca:	c3                   	retq   

0000000000806dcb <_pipeisclosed>:
  806dcb:	55                   	push   %rbp
  806dcc:	48 89 e5             	mov    %rsp,%rbp
  806dcf:	53                   	push   %rbx
  806dd0:	48 83 ec 28          	sub    $0x28,%rsp
  806dd4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  806dd8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  806ddc:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  806de3:	00 00 00 
  806de6:	48 8b 00             	mov    (%rax),%rax
  806de9:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  806def:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806df2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806df6:	48 89 c7             	mov    %rax,%rdi
  806df9:	48 b8 40 63 80 00 00 	movabs $0x806340,%rax
  806e00:	00 00 00 
  806e03:	ff d0                	callq  *%rax
  806e05:	89 c3                	mov    %eax,%ebx
  806e07:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806e0b:	48 89 c7             	mov    %rax,%rdi
  806e0e:	48 b8 40 63 80 00 00 	movabs $0x806340,%rax
  806e15:	00 00 00 
  806e18:	ff d0                	callq  *%rax
  806e1a:	39 c3                	cmp    %eax,%ebx
  806e1c:	0f 94 c0             	sete   %al
  806e1f:	0f b6 c0             	movzbl %al,%eax
  806e22:	89 45 e8             	mov    %eax,-0x18(%rbp)
  806e25:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  806e2c:	00 00 00 
  806e2f:	48 8b 00             	mov    (%rax),%rax
  806e32:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  806e38:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  806e3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806e3e:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  806e41:	75 05                	jne    806e48 <_pipeisclosed+0x7d>
  806e43:	8b 45 e8             	mov    -0x18(%rbp),%eax
  806e46:	eb 4f                	jmp    806e97 <_pipeisclosed+0xcc>
  806e48:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806e4b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  806e4e:	74 42                	je     806e92 <_pipeisclosed+0xc7>
  806e50:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  806e54:	75 3c                	jne    806e92 <_pipeisclosed+0xc7>
  806e56:	48 b8 20 60 81 00 00 	movabs $0x816020,%rax
  806e5d:	00 00 00 
  806e60:	48 8b 00             	mov    (%rax),%rax
  806e63:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  806e69:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  806e6c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806e6f:	89 c6                	mov    %eax,%esi
  806e71:	48 bf d3 81 80 00 00 	movabs $0x8081d3,%rdi
  806e78:	00 00 00 
  806e7b:	b8 00 00 00 00       	mov    $0x0,%eax
  806e80:	49 b8 eb 36 80 00 00 	movabs $0x8036eb,%r8
  806e87:	00 00 00 
  806e8a:	41 ff d0             	callq  *%r8
  806e8d:	e9 4a ff ff ff       	jmpq   806ddc <_pipeisclosed+0x11>
  806e92:	e9 45 ff ff ff       	jmpq   806ddc <_pipeisclosed+0x11>
  806e97:	48 83 c4 28          	add    $0x28,%rsp
  806e9b:	5b                   	pop    %rbx
  806e9c:	5d                   	pop    %rbp
  806e9d:	c3                   	retq   

0000000000806e9e <pipeisclosed>:
  806e9e:	55                   	push   %rbp
  806e9f:	48 89 e5             	mov    %rsp,%rbp
  806ea2:	48 83 ec 30          	sub    $0x30,%rsp
  806ea6:	89 7d dc             	mov    %edi,-0x24(%rbp)
  806ea9:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  806ead:	8b 45 dc             	mov    -0x24(%rbp),%eax
  806eb0:	48 89 d6             	mov    %rdx,%rsi
  806eb3:	89 c7                	mov    %eax,%edi
  806eb5:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  806ebc:	00 00 00 
  806ebf:	ff d0                	callq  *%rax
  806ec1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  806ec4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  806ec8:	79 05                	jns    806ecf <pipeisclosed+0x31>
  806eca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806ecd:	eb 31                	jmp    806f00 <pipeisclosed+0x62>
  806ecf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806ed3:	48 89 c7             	mov    %rax,%rdi
  806ed6:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  806edd:	00 00 00 
  806ee0:	ff d0                	callq  *%rax
  806ee2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  806ee6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806eea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  806eee:	48 89 d6             	mov    %rdx,%rsi
  806ef1:	48 89 c7             	mov    %rax,%rdi
  806ef4:	48 b8 cb 6d 80 00 00 	movabs $0x806dcb,%rax
  806efb:	00 00 00 
  806efe:	ff d0                	callq  *%rax
  806f00:	c9                   	leaveq 
  806f01:	c3                   	retq   

0000000000806f02 <devpipe_read>:
  806f02:	55                   	push   %rbp
  806f03:	48 89 e5             	mov    %rsp,%rbp
  806f06:	48 83 ec 40          	sub    $0x40,%rsp
  806f0a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  806f0e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  806f12:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  806f16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806f1a:	48 89 c7             	mov    %rax,%rdi
  806f1d:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  806f24:	00 00 00 
  806f27:	ff d0                	callq  *%rax
  806f29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  806f2d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806f31:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  806f35:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  806f3c:	00 
  806f3d:	e9 92 00 00 00       	jmpq   806fd4 <devpipe_read+0xd2>
  806f42:	eb 41                	jmp    806f85 <devpipe_read+0x83>
  806f44:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  806f49:	74 09                	je     806f54 <devpipe_read+0x52>
  806f4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806f4f:	e9 92 00 00 00       	jmpq   806fe6 <devpipe_read+0xe4>
  806f54:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  806f58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806f5c:	48 89 d6             	mov    %rdx,%rsi
  806f5f:	48 89 c7             	mov    %rax,%rdi
  806f62:	48 b8 cb 6d 80 00 00 	movabs $0x806dcb,%rax
  806f69:	00 00 00 
  806f6c:	ff d0                	callq  *%rax
  806f6e:	85 c0                	test   %eax,%eax
  806f70:	74 07                	je     806f79 <devpipe_read+0x77>
  806f72:	b8 00 00 00 00       	mov    $0x0,%eax
  806f77:	eb 6d                	jmp    806fe6 <devpipe_read+0xe4>
  806f79:	48 b8 91 4b 80 00 00 	movabs $0x804b91,%rax
  806f80:	00 00 00 
  806f83:	ff d0                	callq  *%rax
  806f85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806f89:	8b 10                	mov    (%rax),%edx
  806f8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806f8f:	8b 40 04             	mov    0x4(%rax),%eax
  806f92:	39 c2                	cmp    %eax,%edx
  806f94:	74 ae                	je     806f44 <devpipe_read+0x42>
  806f96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806f9a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  806f9e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  806fa2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806fa6:	8b 00                	mov    (%rax),%eax
  806fa8:	99                   	cltd   
  806fa9:	c1 ea 1b             	shr    $0x1b,%edx
  806fac:	01 d0                	add    %edx,%eax
  806fae:	83 e0 1f             	and    $0x1f,%eax
  806fb1:	29 d0                	sub    %edx,%eax
  806fb3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  806fb7:	48 98                	cltq   
  806fb9:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  806fbe:	88 01                	mov    %al,(%rcx)
  806fc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806fc4:	8b 00                	mov    (%rax),%eax
  806fc6:	8d 50 01             	lea    0x1(%rax),%edx
  806fc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806fcd:	89 10                	mov    %edx,(%rax)
  806fcf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  806fd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806fd8:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  806fdc:	0f 82 60 ff ff ff    	jb     806f42 <devpipe_read+0x40>
  806fe2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806fe6:	c9                   	leaveq 
  806fe7:	c3                   	retq   

0000000000806fe8 <devpipe_write>:
  806fe8:	55                   	push   %rbp
  806fe9:	48 89 e5             	mov    %rsp,%rbp
  806fec:	48 83 ec 40          	sub    $0x40,%rsp
  806ff0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  806ff4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  806ff8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  806ffc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  807000:	48 89 c7             	mov    %rax,%rdi
  807003:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  80700a:	00 00 00 
  80700d:	ff d0                	callq  *%rax
  80700f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  807013:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  807017:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80701b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  807022:	00 
  807023:	e9 8e 00 00 00       	jmpq   8070b6 <devpipe_write+0xce>
  807028:	eb 31                	jmp    80705b <devpipe_write+0x73>
  80702a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80702e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  807032:	48 89 d6             	mov    %rdx,%rsi
  807035:	48 89 c7             	mov    %rax,%rdi
  807038:	48 b8 cb 6d 80 00 00 	movabs $0x806dcb,%rax
  80703f:	00 00 00 
  807042:	ff d0                	callq  *%rax
  807044:	85 c0                	test   %eax,%eax
  807046:	74 07                	je     80704f <devpipe_write+0x67>
  807048:	b8 00 00 00 00       	mov    $0x0,%eax
  80704d:	eb 79                	jmp    8070c8 <devpipe_write+0xe0>
  80704f:	48 b8 91 4b 80 00 00 	movabs $0x804b91,%rax
  807056:	00 00 00 
  807059:	ff d0                	callq  *%rax
  80705b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80705f:	8b 40 04             	mov    0x4(%rax),%eax
  807062:	48 63 d0             	movslq %eax,%rdx
  807065:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  807069:	8b 00                	mov    (%rax),%eax
  80706b:	48 98                	cltq   
  80706d:	48 83 c0 20          	add    $0x20,%rax
  807071:	48 39 c2             	cmp    %rax,%rdx
  807074:	73 b4                	jae    80702a <devpipe_write+0x42>
  807076:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80707a:	8b 40 04             	mov    0x4(%rax),%eax
  80707d:	99                   	cltd   
  80707e:	c1 ea 1b             	shr    $0x1b,%edx
  807081:	01 d0                	add    %edx,%eax
  807083:	83 e0 1f             	and    $0x1f,%eax
  807086:	29 d0                	sub    %edx,%eax
  807088:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80708c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  807090:	48 01 ca             	add    %rcx,%rdx
  807093:	0f b6 0a             	movzbl (%rdx),%ecx
  807096:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80709a:	48 98                	cltq   
  80709c:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8070a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8070a4:	8b 40 04             	mov    0x4(%rax),%eax
  8070a7:	8d 50 01             	lea    0x1(%rax),%edx
  8070aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8070ae:	89 50 04             	mov    %edx,0x4(%rax)
  8070b1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8070b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8070ba:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8070be:	0f 82 64 ff ff ff    	jb     807028 <devpipe_write+0x40>
  8070c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8070c8:	c9                   	leaveq 
  8070c9:	c3                   	retq   

00000000008070ca <devpipe_stat>:
  8070ca:	55                   	push   %rbp
  8070cb:	48 89 e5             	mov    %rsp,%rbp
  8070ce:	48 83 ec 20          	sub    $0x20,%rsp
  8070d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8070d6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8070da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8070de:	48 89 c7             	mov    %rax,%rdi
  8070e1:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  8070e8:	00 00 00 
  8070eb:	ff d0                	callq  *%rax
  8070ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8070f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8070f5:	48 be e6 81 80 00 00 	movabs $0x8081e6,%rsi
  8070fc:	00 00 00 
  8070ff:	48 89 c7             	mov    %rax,%rdi
  807102:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  807109:	00 00 00 
  80710c:	ff d0                	callq  *%rax
  80710e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  807112:	8b 50 04             	mov    0x4(%rax),%edx
  807115:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  807119:	8b 00                	mov    (%rax),%eax
  80711b:	29 c2                	sub    %eax,%edx
  80711d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  807121:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  807127:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80712b:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  807132:	00 00 00 
  807135:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  807139:	48 b9 60 21 81 00 00 	movabs $0x812160,%rcx
  807140:	00 00 00 
  807143:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  80714a:	b8 00 00 00 00       	mov    $0x0,%eax
  80714f:	c9                   	leaveq 
  807150:	c3                   	retq   

0000000000807151 <devpipe_close>:
  807151:	55                   	push   %rbp
  807152:	48 89 e5             	mov    %rsp,%rbp
  807155:	48 83 ec 10          	sub    $0x10,%rsp
  807159:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80715d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  807161:	48 89 c6             	mov    %rax,%rsi
  807164:	bf 00 00 00 00       	mov    $0x0,%edi
  807169:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  807170:	00 00 00 
  807173:	ff d0                	callq  *%rax
  807175:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  807179:	48 89 c7             	mov    %rax,%rdi
  80717c:	48 b8 38 53 80 00 00 	movabs $0x805338,%rax
  807183:	00 00 00 
  807186:	ff d0                	callq  *%rax
  807188:	48 89 c6             	mov    %rax,%rsi
  80718b:	bf 00 00 00 00       	mov    $0x0,%edi
  807190:	48 b8 7a 4c 80 00 00 	movabs $0x804c7a,%rax
  807197:	00 00 00 
  80719a:	ff d0                	callq  *%rax
  80719c:	c9                   	leaveq 
  80719d:	c3                   	retq   

000000000080719e <cputchar>:
  80719e:	55                   	push   %rbp
  80719f:	48 89 e5             	mov    %rsp,%rbp
  8071a2:	48 83 ec 20          	sub    $0x20,%rsp
  8071a6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8071a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8071ac:	88 45 ff             	mov    %al,-0x1(%rbp)
  8071af:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8071b3:	be 01 00 00 00       	mov    $0x1,%esi
  8071b8:	48 89 c7             	mov    %rax,%rdi
  8071bb:	48 b8 87 4a 80 00 00 	movabs $0x804a87,%rax
  8071c2:	00 00 00 
  8071c5:	ff d0                	callq  *%rax
  8071c7:	c9                   	leaveq 
  8071c8:	c3                   	retq   

00000000008071c9 <getchar>:
  8071c9:	55                   	push   %rbp
  8071ca:	48 89 e5             	mov    %rsp,%rbp
  8071cd:	48 83 ec 10          	sub    $0x10,%rsp
  8071d1:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8071d5:	ba 01 00 00 00       	mov    $0x1,%edx
  8071da:	48 89 c6             	mov    %rax,%rsi
  8071dd:	bf 00 00 00 00       	mov    $0x0,%edi
  8071e2:	48 b8 2d 58 80 00 00 	movabs $0x80582d,%rax
  8071e9:	00 00 00 
  8071ec:	ff d0                	callq  *%rax
  8071ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8071f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8071f5:	79 05                	jns    8071fc <getchar+0x33>
  8071f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8071fa:	eb 14                	jmp    807210 <getchar+0x47>
  8071fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  807200:	7f 07                	jg     807209 <getchar+0x40>
  807202:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  807207:	eb 07                	jmp    807210 <getchar+0x47>
  807209:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  80720d:	0f b6 c0             	movzbl %al,%eax
  807210:	c9                   	leaveq 
  807211:	c3                   	retq   

0000000000807212 <iscons>:
  807212:	55                   	push   %rbp
  807213:	48 89 e5             	mov    %rsp,%rbp
  807216:	48 83 ec 20          	sub    $0x20,%rsp
  80721a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80721d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  807221:	8b 45 ec             	mov    -0x14(%rbp),%eax
  807224:	48 89 d6             	mov    %rdx,%rsi
  807227:	89 c7                	mov    %eax,%edi
  807229:	48 b8 fb 53 80 00 00 	movabs $0x8053fb,%rax
  807230:	00 00 00 
  807233:	ff d0                	callq  *%rax
  807235:	89 45 fc             	mov    %eax,-0x4(%rbp)
  807238:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80723c:	79 05                	jns    807243 <iscons+0x31>
  80723e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807241:	eb 1a                	jmp    80725d <iscons+0x4b>
  807243:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  807247:	8b 10                	mov    (%rax),%edx
  807249:	48 b8 a0 21 81 00 00 	movabs $0x8121a0,%rax
  807250:	00 00 00 
  807253:	8b 00                	mov    (%rax),%eax
  807255:	39 c2                	cmp    %eax,%edx
  807257:	0f 94 c0             	sete   %al
  80725a:	0f b6 c0             	movzbl %al,%eax
  80725d:	c9                   	leaveq 
  80725e:	c3                   	retq   

000000000080725f <opencons>:
  80725f:	55                   	push   %rbp
  807260:	48 89 e5             	mov    %rsp,%rbp
  807263:	48 83 ec 10          	sub    $0x10,%rsp
  807267:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80726b:	48 89 c7             	mov    %rax,%rdi
  80726e:	48 b8 63 53 80 00 00 	movabs $0x805363,%rax
  807275:	00 00 00 
  807278:	ff d0                	callq  *%rax
  80727a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80727d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  807281:	79 05                	jns    807288 <opencons+0x29>
  807283:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807286:	eb 5b                	jmp    8072e3 <opencons+0x84>
  807288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80728c:	ba 07 04 00 00       	mov    $0x407,%edx
  807291:	48 89 c6             	mov    %rax,%rsi
  807294:	bf 00 00 00 00       	mov    $0x0,%edi
  807299:	48 b8 cf 4b 80 00 00 	movabs $0x804bcf,%rax
  8072a0:	00 00 00 
  8072a3:	ff d0                	callq  *%rax
  8072a5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8072a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8072ac:	79 05                	jns    8072b3 <opencons+0x54>
  8072ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8072b1:	eb 30                	jmp    8072e3 <opencons+0x84>
  8072b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8072b7:	48 ba a0 21 81 00 00 	movabs $0x8121a0,%rdx
  8072be:	00 00 00 
  8072c1:	8b 12                	mov    (%rdx),%edx
  8072c3:	89 10                	mov    %edx,(%rax)
  8072c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8072c9:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8072d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8072d4:	48 89 c7             	mov    %rax,%rdi
  8072d7:	48 b8 15 53 80 00 00 	movabs $0x805315,%rax
  8072de:	00 00 00 
  8072e1:	ff d0                	callq  *%rax
  8072e3:	c9                   	leaveq 
  8072e4:	c3                   	retq   

00000000008072e5 <devcons_read>:
  8072e5:	55                   	push   %rbp
  8072e6:	48 89 e5             	mov    %rsp,%rbp
  8072e9:	48 83 ec 30          	sub    $0x30,%rsp
  8072ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8072f1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8072f5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8072f9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8072fe:	75 07                	jne    807307 <devcons_read+0x22>
  807300:	b8 00 00 00 00       	mov    $0x0,%eax
  807305:	eb 4b                	jmp    807352 <devcons_read+0x6d>
  807307:	eb 0c                	jmp    807315 <devcons_read+0x30>
  807309:	48 b8 91 4b 80 00 00 	movabs $0x804b91,%rax
  807310:	00 00 00 
  807313:	ff d0                	callq  *%rax
  807315:	48 b8 d1 4a 80 00 00 	movabs $0x804ad1,%rax
  80731c:	00 00 00 
  80731f:	ff d0                	callq  *%rax
  807321:	89 45 fc             	mov    %eax,-0x4(%rbp)
  807324:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  807328:	74 df                	je     807309 <devcons_read+0x24>
  80732a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80732e:	79 05                	jns    807335 <devcons_read+0x50>
  807330:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807333:	eb 1d                	jmp    807352 <devcons_read+0x6d>
  807335:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  807339:	75 07                	jne    807342 <devcons_read+0x5d>
  80733b:	b8 00 00 00 00       	mov    $0x0,%eax
  807340:	eb 10                	jmp    807352 <devcons_read+0x6d>
  807342:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807345:	89 c2                	mov    %eax,%edx
  807347:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80734b:	88 10                	mov    %dl,(%rax)
  80734d:	b8 01 00 00 00       	mov    $0x1,%eax
  807352:	c9                   	leaveq 
  807353:	c3                   	retq   

0000000000807354 <devcons_write>:
  807354:	55                   	push   %rbp
  807355:	48 89 e5             	mov    %rsp,%rbp
  807358:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80735f:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  807366:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80736d:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  807374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80737b:	eb 76                	jmp    8073f3 <devcons_write+0x9f>
  80737d:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  807384:	89 c2                	mov    %eax,%edx
  807386:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807389:	29 c2                	sub    %eax,%edx
  80738b:	89 d0                	mov    %edx,%eax
  80738d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  807390:	8b 45 f8             	mov    -0x8(%rbp),%eax
  807393:	83 f8 7f             	cmp    $0x7f,%eax
  807396:	76 07                	jbe    80739f <devcons_write+0x4b>
  807398:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  80739f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8073a2:	48 63 d0             	movslq %eax,%rdx
  8073a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8073a8:	48 63 c8             	movslq %eax,%rcx
  8073ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8073b2:	48 01 c1             	add    %rax,%rcx
  8073b5:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8073bc:	48 89 ce             	mov    %rcx,%rsi
  8073bf:	48 89 c7             	mov    %rax,%rdi
  8073c2:	48 b8 c4 45 80 00 00 	movabs $0x8045c4,%rax
  8073c9:	00 00 00 
  8073cc:	ff d0                	callq  *%rax
  8073ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8073d1:	48 63 d0             	movslq %eax,%rdx
  8073d4:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8073db:	48 89 d6             	mov    %rdx,%rsi
  8073de:	48 89 c7             	mov    %rax,%rdi
  8073e1:	48 b8 87 4a 80 00 00 	movabs $0x804a87,%rax
  8073e8:	00 00 00 
  8073eb:	ff d0                	callq  *%rax
  8073ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8073f0:	01 45 fc             	add    %eax,-0x4(%rbp)
  8073f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8073f6:	48 98                	cltq   
  8073f8:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  8073ff:	0f 82 78 ff ff ff    	jb     80737d <devcons_write+0x29>
  807405:	8b 45 fc             	mov    -0x4(%rbp),%eax
  807408:	c9                   	leaveq 
  807409:	c3                   	retq   

000000000080740a <devcons_close>:
  80740a:	55                   	push   %rbp
  80740b:	48 89 e5             	mov    %rsp,%rbp
  80740e:	48 83 ec 08          	sub    $0x8,%rsp
  807412:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  807416:	b8 00 00 00 00       	mov    $0x0,%eax
  80741b:	c9                   	leaveq 
  80741c:	c3                   	retq   

000000000080741d <devcons_stat>:
  80741d:	55                   	push   %rbp
  80741e:	48 89 e5             	mov    %rsp,%rbp
  807421:	48 83 ec 10          	sub    $0x10,%rsp
  807425:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  807429:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80742d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  807431:	48 be f2 81 80 00 00 	movabs $0x8081f2,%rsi
  807438:	00 00 00 
  80743b:	48 89 c7             	mov    %rax,%rdi
  80743e:	48 b8 a0 42 80 00 00 	movabs $0x8042a0,%rax
  807445:	00 00 00 
  807448:	ff d0                	callq  *%rax
  80744a:	b8 00 00 00 00       	mov    $0x0,%eax
  80744f:	c9                   	leaveq 
  807450:	c3                   	retq   
