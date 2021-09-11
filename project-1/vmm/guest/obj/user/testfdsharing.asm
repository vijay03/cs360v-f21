
vmm/guest/obj/user/testfdsharing:     file format elf64-x86-64


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
  80003c:	e8 fa 02 00 00       	callq  80033b <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80004e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800052:	be 00 00 00 00       	mov    $0x0,%esi
  800057:	48 bf 40 4a 80 00 00 	movabs $0x804a40,%rdi
  80005e:	00 00 00 
  800061:	48 b8 e1 2e 80 00 00 	movabs $0x802ee1,%rax
  800068:	00 00 00 
  80006b:	ff d0                	callq  *%rax
  80006d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800070:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800074:	79 30                	jns    8000a6 <umain+0x63>
  800076:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800079:	89 c1                	mov    %eax,%ecx
  80007b:	48 ba 45 4a 80 00 00 	movabs $0x804a45,%rdx
  800082:	00 00 00 
  800085:	be 0d 00 00 00       	mov    $0xd,%esi
  80008a:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  800091:	00 00 00 
  800094:	b8 00 00 00 00       	mov    $0x0,%eax
  800099:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8000a0:	00 00 00 
  8000a3:	41 ff d0             	callq  *%r8
  8000a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000a9:	be 00 00 00 00       	mov    $0x0,%esi
  8000ae:	89 c7                	mov    %eax,%edi
  8000b0:	48 b8 29 2c 80 00 00 	movabs $0x802c29,%rax
  8000b7:	00 00 00 
  8000ba:	ff d0                	callq  *%rax
  8000bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000bf:	ba 00 02 00 00       	mov    $0x200,%edx
  8000c4:	48 be 20 82 80 00 00 	movabs $0x808220,%rsi
  8000cb:	00 00 00 
  8000ce:	89 c7                	mov    %eax,%edi
  8000d0:	48 b8 e0 2a 80 00 00 	movabs $0x802ae0,%rax
  8000d7:	00 00 00 
  8000da:	ff d0                	callq  *%rax
  8000dc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000df:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000e3:	7f 30                	jg     800115 <umain+0xd2>
  8000e5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000e8:	89 c1                	mov    %eax,%ecx
  8000ea:	48 ba 6b 4a 80 00 00 	movabs $0x804a6b,%rdx
  8000f1:	00 00 00 
  8000f4:	be 10 00 00 00       	mov    $0x10,%esi
  8000f9:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  800100:	00 00 00 
  800103:	b8 00 00 00 00       	mov    $0x0,%eax
  800108:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  80010f:	00 00 00 
  800112:	41 ff d0             	callq  *%r8
  800115:	48 b8 7e 22 80 00 00 	movabs $0x80227e,%rax
  80011c:	00 00 00 
  80011f:	ff d0                	callq  *%rax
  800121:	89 45 f4             	mov    %eax,-0xc(%rbp)
  800124:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  800128:	79 30                	jns    80015a <umain+0x117>
  80012a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80012d:	89 c1                	mov    %eax,%ecx
  80012f:	48 ba 75 4a 80 00 00 	movabs $0x804a75,%rdx
  800136:	00 00 00 
  800139:	be 13 00 00 00       	mov    $0x13,%esi
  80013e:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  800145:	00 00 00 
  800148:	b8 00 00 00 00       	mov    $0x0,%eax
  80014d:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  800154:	00 00 00 
  800157:	41 ff d0             	callq  *%r8
  80015a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80015e:	0f 85 36 01 00 00    	jne    80029a <umain+0x257>
  800164:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800167:	be 00 00 00 00       	mov    $0x0,%esi
  80016c:	89 c7                	mov    %eax,%edi
  80016e:	48 b8 29 2c 80 00 00 	movabs $0x802c29,%rax
  800175:	00 00 00 
  800178:	ff d0                	callq  *%rax
  80017a:	48 bf 80 4a 80 00 00 	movabs $0x804a80,%rdi
  800181:	00 00 00 
  800184:	b8 00 00 00 00       	mov    $0x0,%eax
  800189:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  800190:	00 00 00 
  800193:	ff d2                	callq  *%rdx
  800195:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800198:	ba 00 02 00 00       	mov    $0x200,%edx
  80019d:	48 be 20 80 80 00 00 	movabs $0x808020,%rsi
  8001a4:	00 00 00 
  8001a7:	89 c7                	mov    %eax,%edi
  8001a9:	48 b8 e0 2a 80 00 00 	movabs $0x802ae0,%rax
  8001b0:	00 00 00 
  8001b3:	ff d0                	callq  *%rax
  8001b5:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8001b8:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8001bb:	3b 45 f8             	cmp    -0x8(%rbp),%eax
  8001be:	74 36                	je     8001f6 <umain+0x1b3>
  8001c0:	8b 55 f0             	mov    -0x10(%rbp),%edx
  8001c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001c6:	41 89 d0             	mov    %edx,%r8d
  8001c9:	89 c1                	mov    %eax,%ecx
  8001cb:	48 ba c8 4a 80 00 00 	movabs $0x804ac8,%rdx
  8001d2:	00 00 00 
  8001d5:	be 18 00 00 00       	mov    $0x18,%esi
  8001da:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  8001e1:	00 00 00 
  8001e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8001e9:	49 b9 e1 03 80 00 00 	movabs $0x8003e1,%r9
  8001f0:	00 00 00 
  8001f3:	41 ff d1             	callq  *%r9
  8001f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001f9:	48 98                	cltq   
  8001fb:	48 89 c2             	mov    %rax,%rdx
  8001fe:	48 be 20 80 80 00 00 	movabs $0x808020,%rsi
  800205:	00 00 00 
  800208:	48 bf 20 82 80 00 00 	movabs $0x808220,%rdi
  80020f:	00 00 00 
  800212:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  800219:	00 00 00 
  80021c:	ff d0                	callq  *%rax
  80021e:	85 c0                	test   %eax,%eax
  800220:	74 2a                	je     80024c <umain+0x209>
  800222:	48 ba f8 4a 80 00 00 	movabs $0x804af8,%rdx
  800229:	00 00 00 
  80022c:	be 1a 00 00 00       	mov    $0x1a,%esi
  800231:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  800238:	00 00 00 
  80023b:	b8 00 00 00 00       	mov    $0x0,%eax
  800240:	48 b9 e1 03 80 00 00 	movabs $0x8003e1,%rcx
  800247:	00 00 00 
  80024a:	ff d1                	callq  *%rcx
  80024c:	48 bf 2e 4b 80 00 00 	movabs $0x804b2e,%rdi
  800253:	00 00 00 
  800256:	b8 00 00 00 00       	mov    $0x0,%eax
  80025b:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  800262:	00 00 00 
  800265:	ff d2                	callq  *%rdx
  800267:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80026a:	be 00 00 00 00       	mov    $0x0,%esi
  80026f:	89 c7                	mov    %eax,%edi
  800271:	48 b8 29 2c 80 00 00 	movabs $0x802c29,%rax
  800278:	00 00 00 
  80027b:	ff d0                	callq  *%rax
  80027d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800280:	89 c7                	mov    %eax,%edi
  800282:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  800289:	00 00 00 
  80028c:	ff d0                	callq  *%rax
  80028e:	48 b8 be 03 80 00 00 	movabs $0x8003be,%rax
  800295:	00 00 00 
  800298:	ff d0                	callq  *%rax
  80029a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80029d:	89 c7                	mov    %eax,%edi
  80029f:	48 b8 f3 42 80 00 00 	movabs $0x8042f3,%rax
  8002a6:	00 00 00 
  8002a9:	ff d0                	callq  *%rax
  8002ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002ae:	ba 00 02 00 00       	mov    $0x200,%edx
  8002b3:	48 be 20 80 80 00 00 	movabs $0x808020,%rsi
  8002ba:	00 00 00 
  8002bd:	89 c7                	mov    %eax,%edi
  8002bf:	48 b8 e0 2a 80 00 00 	movabs $0x802ae0,%rax
  8002c6:	00 00 00 
  8002c9:	ff d0                	callq  *%rax
  8002cb:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8002ce:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002d1:	3b 45 f8             	cmp    -0x8(%rbp),%eax
  8002d4:	74 36                	je     80030c <umain+0x2c9>
  8002d6:	8b 55 f0             	mov    -0x10(%rbp),%edx
  8002d9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8002dc:	41 89 d0             	mov    %edx,%r8d
  8002df:	89 c1                	mov    %eax,%ecx
  8002e1:	48 ba 48 4b 80 00 00 	movabs $0x804b48,%rdx
  8002e8:	00 00 00 
  8002eb:	be 22 00 00 00       	mov    $0x22,%esi
  8002f0:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  8002f7:	00 00 00 
  8002fa:	b8 00 00 00 00       	mov    $0x0,%eax
  8002ff:	49 b9 e1 03 80 00 00 	movabs $0x8003e1,%r9
  800306:	00 00 00 
  800309:	41 ff d1             	callq  *%r9
  80030c:	48 bf 6b 4b 80 00 00 	movabs $0x804b6b,%rdi
  800313:	00 00 00 
  800316:	b8 00 00 00 00       	mov    $0x0,%eax
  80031b:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  800322:	00 00 00 
  800325:	ff d2                	callq  *%rdx
  800327:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80032a:	89 c7                	mov    %eax,%edi
  80032c:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  800333:	00 00 00 
  800336:	ff d0                	callq  *%rax
static __inline void read_gdtr (uint64_t *gdtbase, uint16_t *gdtlimit) __attribute__((always_inline));

static __inline void
breakpoint(void)
{
	__asm __volatile("int3");
  800338:	cc                   	int3   
  800339:	c9                   	leaveq 
  80033a:	c3                   	retq   

000000000080033b <libmain>:
  80033b:	55                   	push   %rbp
  80033c:	48 89 e5             	mov    %rsp,%rbp
  80033f:	48 83 ec 10          	sub    $0x10,%rsp
  800343:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800346:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80034a:	48 b8 82 1a 80 00 00 	movabs $0x801a82,%rax
  800351:	00 00 00 
  800354:	ff d0                	callq  *%rax
  800356:	25 ff 03 00 00       	and    $0x3ff,%eax
  80035b:	48 98                	cltq   
  80035d:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800364:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80036b:	00 00 00 
  80036e:	48 01 c2             	add    %rax,%rdx
  800371:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  800378:	00 00 00 
  80037b:	48 89 10             	mov    %rdx,(%rax)
  80037e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800382:	7e 14                	jle    800398 <libmain+0x5d>
  800384:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800388:	48 8b 10             	mov    (%rax),%rdx
  80038b:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800392:	00 00 00 
  800395:	48 89 10             	mov    %rdx,(%rax)
  800398:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80039c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80039f:	48 89 d6             	mov    %rdx,%rsi
  8003a2:	89 c7                	mov    %eax,%edi
  8003a4:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8003ab:	00 00 00 
  8003ae:	ff d0                	callq  *%rax
  8003b0:	48 b8 be 03 80 00 00 	movabs $0x8003be,%rax
  8003b7:	00 00 00 
  8003ba:	ff d0                	callq  *%rax
  8003bc:	c9                   	leaveq 
  8003bd:	c3                   	retq   

00000000008003be <exit>:
  8003be:	55                   	push   %rbp
  8003bf:	48 89 e5             	mov    %rsp,%rbp
  8003c2:	48 b8 34 28 80 00 00 	movabs $0x802834,%rax
  8003c9:	00 00 00 
  8003cc:	ff d0                	callq  *%rax
  8003ce:	bf 00 00 00 00       	mov    $0x0,%edi
  8003d3:	48 b8 3e 1a 80 00 00 	movabs $0x801a3e,%rax
  8003da:	00 00 00 
  8003dd:	ff d0                	callq  *%rax
  8003df:	5d                   	pop    %rbp
  8003e0:	c3                   	retq   

00000000008003e1 <_panic>:
  8003e1:	55                   	push   %rbp
  8003e2:	48 89 e5             	mov    %rsp,%rbp
  8003e5:	53                   	push   %rbx
  8003e6:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8003ed:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8003f4:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8003fa:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800401:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800408:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80040f:	84 c0                	test   %al,%al
  800411:	74 23                	je     800436 <_panic+0x55>
  800413:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  80041a:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80041e:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800422:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800426:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  80042a:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80042e:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800432:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800436:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80043d:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800444:	00 00 00 
  800447:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80044e:	00 00 00 
  800451:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800455:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  80045c:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800463:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80046a:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800471:	00 00 00 
  800474:	48 8b 18             	mov    (%rax),%rbx
  800477:	48 b8 82 1a 80 00 00 	movabs $0x801a82,%rax
  80047e:	00 00 00 
  800481:	ff d0                	callq  *%rax
  800483:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800489:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800490:	41 89 c8             	mov    %ecx,%r8d
  800493:	48 89 d1             	mov    %rdx,%rcx
  800496:	48 89 da             	mov    %rbx,%rdx
  800499:	89 c6                	mov    %eax,%esi
  80049b:	48 bf 90 4b 80 00 00 	movabs $0x804b90,%rdi
  8004a2:	00 00 00 
  8004a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8004aa:	49 b9 1a 06 80 00 00 	movabs $0x80061a,%r9
  8004b1:	00 00 00 
  8004b4:	41 ff d1             	callq  *%r9
  8004b7:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8004be:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8004c5:	48 89 d6             	mov    %rdx,%rsi
  8004c8:	48 89 c7             	mov    %rax,%rdi
  8004cb:	48 b8 6e 05 80 00 00 	movabs $0x80056e,%rax
  8004d2:	00 00 00 
  8004d5:	ff d0                	callq  *%rax
  8004d7:	48 bf b3 4b 80 00 00 	movabs $0x804bb3,%rdi
  8004de:	00 00 00 
  8004e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8004e6:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  8004ed:	00 00 00 
  8004f0:	ff d2                	callq  *%rdx
  8004f2:	cc                   	int3   
  8004f3:	eb fd                	jmp    8004f2 <_panic+0x111>

00000000008004f5 <putch>:
  8004f5:	55                   	push   %rbp
  8004f6:	48 89 e5             	mov    %rsp,%rbp
  8004f9:	48 83 ec 10          	sub    $0x10,%rsp
  8004fd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800500:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800504:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800508:	8b 00                	mov    (%rax),%eax
  80050a:	8d 48 01             	lea    0x1(%rax),%ecx
  80050d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800511:	89 0a                	mov    %ecx,(%rdx)
  800513:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800516:	89 d1                	mov    %edx,%ecx
  800518:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80051c:	48 98                	cltq   
  80051e:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800522:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800526:	8b 00                	mov    (%rax),%eax
  800528:	3d ff 00 00 00       	cmp    $0xff,%eax
  80052d:	75 2c                	jne    80055b <putch+0x66>
  80052f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800533:	8b 00                	mov    (%rax),%eax
  800535:	48 98                	cltq   
  800537:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80053b:	48 83 c2 08          	add    $0x8,%rdx
  80053f:	48 89 c6             	mov    %rax,%rsi
  800542:	48 89 d7             	mov    %rdx,%rdi
  800545:	48 b8 b6 19 80 00 00 	movabs $0x8019b6,%rax
  80054c:	00 00 00 
  80054f:	ff d0                	callq  *%rax
  800551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800555:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80055b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80055f:	8b 40 04             	mov    0x4(%rax),%eax
  800562:	8d 50 01             	lea    0x1(%rax),%edx
  800565:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800569:	89 50 04             	mov    %edx,0x4(%rax)
  80056c:	c9                   	leaveq 
  80056d:	c3                   	retq   

000000000080056e <vcprintf>:
  80056e:	55                   	push   %rbp
  80056f:	48 89 e5             	mov    %rsp,%rbp
  800572:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800579:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800580:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800587:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  80058e:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800595:	48 8b 0a             	mov    (%rdx),%rcx
  800598:	48 89 08             	mov    %rcx,(%rax)
  80059b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80059f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8005a3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8005a7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8005ab:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8005b2:	00 00 00 
  8005b5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8005bc:	00 00 00 
  8005bf:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8005c6:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8005cd:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8005d4:	48 89 c6             	mov    %rax,%rsi
  8005d7:	48 bf f5 04 80 00 00 	movabs $0x8004f5,%rdi
  8005de:	00 00 00 
  8005e1:	48 b8 cd 09 80 00 00 	movabs $0x8009cd,%rax
  8005e8:	00 00 00 
  8005eb:	ff d0                	callq  *%rax
  8005ed:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8005f3:	48 98                	cltq   
  8005f5:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8005fc:	48 83 c2 08          	add    $0x8,%rdx
  800600:	48 89 c6             	mov    %rax,%rsi
  800603:	48 89 d7             	mov    %rdx,%rdi
  800606:	48 b8 b6 19 80 00 00 	movabs $0x8019b6,%rax
  80060d:	00 00 00 
  800610:	ff d0                	callq  *%rax
  800612:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800618:	c9                   	leaveq 
  800619:	c3                   	retq   

000000000080061a <cprintf>:
  80061a:	55                   	push   %rbp
  80061b:	48 89 e5             	mov    %rsp,%rbp
  80061e:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800625:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80062c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800633:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80063a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800641:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800648:	84 c0                	test   %al,%al
  80064a:	74 20                	je     80066c <cprintf+0x52>
  80064c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800650:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800654:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800658:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80065c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800660:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800664:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800668:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80066c:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800673:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80067a:	00 00 00 
  80067d:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800684:	00 00 00 
  800687:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80068b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800692:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800699:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8006a0:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8006a7:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8006ae:	48 8b 0a             	mov    (%rdx),%rcx
  8006b1:	48 89 08             	mov    %rcx,(%rax)
  8006b4:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8006b8:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8006bc:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8006c0:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8006c4:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8006cb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8006d2:	48 89 d6             	mov    %rdx,%rsi
  8006d5:	48 89 c7             	mov    %rax,%rdi
  8006d8:	48 b8 6e 05 80 00 00 	movabs $0x80056e,%rax
  8006df:	00 00 00 
  8006e2:	ff d0                	callq  *%rax
  8006e4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8006ea:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8006f0:	c9                   	leaveq 
  8006f1:	c3                   	retq   

00000000008006f2 <printnum>:
  8006f2:	55                   	push   %rbp
  8006f3:	48 89 e5             	mov    %rsp,%rbp
  8006f6:	53                   	push   %rbx
  8006f7:	48 83 ec 38          	sub    $0x38,%rsp
  8006fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8006ff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800703:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800707:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80070a:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80070e:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800712:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800715:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800719:	77 3b                	ja     800756 <printnum+0x64>
  80071b:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80071e:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800722:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800725:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800729:	ba 00 00 00 00       	mov    $0x0,%edx
  80072e:	48 f7 f3             	div    %rbx
  800731:	48 89 c2             	mov    %rax,%rdx
  800734:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800737:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80073a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80073e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800742:	41 89 f9             	mov    %edi,%r9d
  800745:	48 89 c7             	mov    %rax,%rdi
  800748:	48 b8 f2 06 80 00 00 	movabs $0x8006f2,%rax
  80074f:	00 00 00 
  800752:	ff d0                	callq  *%rax
  800754:	eb 1e                	jmp    800774 <printnum+0x82>
  800756:	eb 12                	jmp    80076a <printnum+0x78>
  800758:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80075c:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80075f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800763:	48 89 ce             	mov    %rcx,%rsi
  800766:	89 d7                	mov    %edx,%edi
  800768:	ff d0                	callq  *%rax
  80076a:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80076e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800772:	7f e4                	jg     800758 <printnum+0x66>
  800774:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800777:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80077b:	ba 00 00 00 00       	mov    $0x0,%edx
  800780:	48 f7 f1             	div    %rcx
  800783:	48 89 d0             	mov    %rdx,%rax
  800786:	48 ba b0 4d 80 00 00 	movabs $0x804db0,%rdx
  80078d:	00 00 00 
  800790:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800794:	0f be d0             	movsbl %al,%edx
  800797:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80079b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80079f:	48 89 ce             	mov    %rcx,%rsi
  8007a2:	89 d7                	mov    %edx,%edi
  8007a4:	ff d0                	callq  *%rax
  8007a6:	48 83 c4 38          	add    $0x38,%rsp
  8007aa:	5b                   	pop    %rbx
  8007ab:	5d                   	pop    %rbp
  8007ac:	c3                   	retq   

00000000008007ad <getuint>:
  8007ad:	55                   	push   %rbp
  8007ae:	48 89 e5             	mov    %rsp,%rbp
  8007b1:	48 83 ec 1c          	sub    $0x1c,%rsp
  8007b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8007b9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8007bc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8007c0:	7e 52                	jle    800814 <getuint+0x67>
  8007c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007c6:	8b 00                	mov    (%rax),%eax
  8007c8:	83 f8 30             	cmp    $0x30,%eax
  8007cb:	73 24                	jae    8007f1 <getuint+0x44>
  8007cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007d1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8007d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007d9:	8b 00                	mov    (%rax),%eax
  8007db:	89 c0                	mov    %eax,%eax
  8007dd:	48 01 d0             	add    %rdx,%rax
  8007e0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007e4:	8b 12                	mov    (%rdx),%edx
  8007e6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8007e9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007ed:	89 0a                	mov    %ecx,(%rdx)
  8007ef:	eb 17                	jmp    800808 <getuint+0x5b>
  8007f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007f5:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8007f9:	48 89 d0             	mov    %rdx,%rax
  8007fc:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800800:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800804:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800808:	48 8b 00             	mov    (%rax),%rax
  80080b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80080f:	e9 a3 00 00 00       	jmpq   8008b7 <getuint+0x10a>
  800814:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800818:	74 4f                	je     800869 <getuint+0xbc>
  80081a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80081e:	8b 00                	mov    (%rax),%eax
  800820:	83 f8 30             	cmp    $0x30,%eax
  800823:	73 24                	jae    800849 <getuint+0x9c>
  800825:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800829:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80082d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800831:	8b 00                	mov    (%rax),%eax
  800833:	89 c0                	mov    %eax,%eax
  800835:	48 01 d0             	add    %rdx,%rax
  800838:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80083c:	8b 12                	mov    (%rdx),%edx
  80083e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800841:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800845:	89 0a                	mov    %ecx,(%rdx)
  800847:	eb 17                	jmp    800860 <getuint+0xb3>
  800849:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80084d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800851:	48 89 d0             	mov    %rdx,%rax
  800854:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800858:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80085c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800860:	48 8b 00             	mov    (%rax),%rax
  800863:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800867:	eb 4e                	jmp    8008b7 <getuint+0x10a>
  800869:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80086d:	8b 00                	mov    (%rax),%eax
  80086f:	83 f8 30             	cmp    $0x30,%eax
  800872:	73 24                	jae    800898 <getuint+0xeb>
  800874:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800878:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80087c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800880:	8b 00                	mov    (%rax),%eax
  800882:	89 c0                	mov    %eax,%eax
  800884:	48 01 d0             	add    %rdx,%rax
  800887:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80088b:	8b 12                	mov    (%rdx),%edx
  80088d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800890:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800894:	89 0a                	mov    %ecx,(%rdx)
  800896:	eb 17                	jmp    8008af <getuint+0x102>
  800898:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80089c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008a0:	48 89 d0             	mov    %rdx,%rax
  8008a3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008a7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008af:	8b 00                	mov    (%rax),%eax
  8008b1:	89 c0                	mov    %eax,%eax
  8008b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8008bb:	c9                   	leaveq 
  8008bc:	c3                   	retq   

00000000008008bd <getint>:
  8008bd:	55                   	push   %rbp
  8008be:	48 89 e5             	mov    %rsp,%rbp
  8008c1:	48 83 ec 1c          	sub    $0x1c,%rsp
  8008c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8008c9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8008cc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8008d0:	7e 52                	jle    800924 <getint+0x67>
  8008d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008d6:	8b 00                	mov    (%rax),%eax
  8008d8:	83 f8 30             	cmp    $0x30,%eax
  8008db:	73 24                	jae    800901 <getint+0x44>
  8008dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008e1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008e9:	8b 00                	mov    (%rax),%eax
  8008eb:	89 c0                	mov    %eax,%eax
  8008ed:	48 01 d0             	add    %rdx,%rax
  8008f0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008f4:	8b 12                	mov    (%rdx),%edx
  8008f6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008f9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008fd:	89 0a                	mov    %ecx,(%rdx)
  8008ff:	eb 17                	jmp    800918 <getint+0x5b>
  800901:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800905:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800909:	48 89 d0             	mov    %rdx,%rax
  80090c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800910:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800914:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800918:	48 8b 00             	mov    (%rax),%rax
  80091b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80091f:	e9 a3 00 00 00       	jmpq   8009c7 <getint+0x10a>
  800924:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800928:	74 4f                	je     800979 <getint+0xbc>
  80092a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80092e:	8b 00                	mov    (%rax),%eax
  800930:	83 f8 30             	cmp    $0x30,%eax
  800933:	73 24                	jae    800959 <getint+0x9c>
  800935:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800939:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80093d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800941:	8b 00                	mov    (%rax),%eax
  800943:	89 c0                	mov    %eax,%eax
  800945:	48 01 d0             	add    %rdx,%rax
  800948:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80094c:	8b 12                	mov    (%rdx),%edx
  80094e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800951:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800955:	89 0a                	mov    %ecx,(%rdx)
  800957:	eb 17                	jmp    800970 <getint+0xb3>
  800959:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80095d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800961:	48 89 d0             	mov    %rdx,%rax
  800964:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800968:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80096c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800970:	48 8b 00             	mov    (%rax),%rax
  800973:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800977:	eb 4e                	jmp    8009c7 <getint+0x10a>
  800979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80097d:	8b 00                	mov    (%rax),%eax
  80097f:	83 f8 30             	cmp    $0x30,%eax
  800982:	73 24                	jae    8009a8 <getint+0xeb>
  800984:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800988:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80098c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800990:	8b 00                	mov    (%rax),%eax
  800992:	89 c0                	mov    %eax,%eax
  800994:	48 01 d0             	add    %rdx,%rax
  800997:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80099b:	8b 12                	mov    (%rdx),%edx
  80099d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009a0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009a4:	89 0a                	mov    %ecx,(%rdx)
  8009a6:	eb 17                	jmp    8009bf <getint+0x102>
  8009a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009ac:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009b0:	48 89 d0             	mov    %rdx,%rax
  8009b3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009b7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009bf:	8b 00                	mov    (%rax),%eax
  8009c1:	48 98                	cltq   
  8009c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8009cb:	c9                   	leaveq 
  8009cc:	c3                   	retq   

00000000008009cd <vprintfmt>:
  8009cd:	55                   	push   %rbp
  8009ce:	48 89 e5             	mov    %rsp,%rbp
  8009d1:	41 54                	push   %r12
  8009d3:	53                   	push   %rbx
  8009d4:	48 83 ec 60          	sub    $0x60,%rsp
  8009d8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  8009dc:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8009e0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8009e4:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8009e8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8009ec:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  8009f0:	48 8b 0a             	mov    (%rdx),%rcx
  8009f3:	48 89 08             	mov    %rcx,(%rax)
  8009f6:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8009fa:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8009fe:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800a02:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800a06:	eb 17                	jmp    800a1f <vprintfmt+0x52>
  800a08:	85 db                	test   %ebx,%ebx
  800a0a:	0f 84 cc 04 00 00    	je     800edc <vprintfmt+0x50f>
  800a10:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a14:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a18:	48 89 d6             	mov    %rdx,%rsi
  800a1b:	89 df                	mov    %ebx,%edi
  800a1d:	ff d0                	callq  *%rax
  800a1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a23:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a27:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a2b:	0f b6 00             	movzbl (%rax),%eax
  800a2e:	0f b6 d8             	movzbl %al,%ebx
  800a31:	83 fb 25             	cmp    $0x25,%ebx
  800a34:	75 d2                	jne    800a08 <vprintfmt+0x3b>
  800a36:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800a3a:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800a41:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a48:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800a4f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800a56:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a5a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a5e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a62:	0f b6 00             	movzbl (%rax),%eax
  800a65:	0f b6 d8             	movzbl %al,%ebx
  800a68:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800a6b:	83 f8 55             	cmp    $0x55,%eax
  800a6e:	0f 87 34 04 00 00    	ja     800ea8 <vprintfmt+0x4db>
  800a74:	89 c0                	mov    %eax,%eax
  800a76:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800a7d:	00 
  800a7e:	48 b8 d8 4d 80 00 00 	movabs $0x804dd8,%rax
  800a85:	00 00 00 
  800a88:	48 01 d0             	add    %rdx,%rax
  800a8b:	48 8b 00             	mov    (%rax),%rax
  800a8e:	ff e0                	jmpq   *%rax
  800a90:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800a94:	eb c0                	jmp    800a56 <vprintfmt+0x89>
  800a96:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800a9a:	eb ba                	jmp    800a56 <vprintfmt+0x89>
  800a9c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800aa3:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800aa6:	89 d0                	mov    %edx,%eax
  800aa8:	c1 e0 02             	shl    $0x2,%eax
  800aab:	01 d0                	add    %edx,%eax
  800aad:	01 c0                	add    %eax,%eax
  800aaf:	01 d8                	add    %ebx,%eax
  800ab1:	83 e8 30             	sub    $0x30,%eax
  800ab4:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800ab7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800abb:	0f b6 00             	movzbl (%rax),%eax
  800abe:	0f be d8             	movsbl %al,%ebx
  800ac1:	83 fb 2f             	cmp    $0x2f,%ebx
  800ac4:	7e 0c                	jle    800ad2 <vprintfmt+0x105>
  800ac6:	83 fb 39             	cmp    $0x39,%ebx
  800ac9:	7f 07                	jg     800ad2 <vprintfmt+0x105>
  800acb:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800ad0:	eb d1                	jmp    800aa3 <vprintfmt+0xd6>
  800ad2:	eb 58                	jmp    800b2c <vprintfmt+0x15f>
  800ad4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ad7:	83 f8 30             	cmp    $0x30,%eax
  800ada:	73 17                	jae    800af3 <vprintfmt+0x126>
  800adc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ae0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ae3:	89 c0                	mov    %eax,%eax
  800ae5:	48 01 d0             	add    %rdx,%rax
  800ae8:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800aeb:	83 c2 08             	add    $0x8,%edx
  800aee:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800af1:	eb 0f                	jmp    800b02 <vprintfmt+0x135>
  800af3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800af7:	48 89 d0             	mov    %rdx,%rax
  800afa:	48 83 c2 08          	add    $0x8,%rdx
  800afe:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b02:	8b 00                	mov    (%rax),%eax
  800b04:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800b07:	eb 23                	jmp    800b2c <vprintfmt+0x15f>
  800b09:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b0d:	79 0c                	jns    800b1b <vprintfmt+0x14e>
  800b0f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800b16:	e9 3b ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b1b:	e9 36 ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b20:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800b27:	e9 2a ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b2c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b30:	79 12                	jns    800b44 <vprintfmt+0x177>
  800b32:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b35:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800b38:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b3f:	e9 12 ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b44:	e9 0d ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b49:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800b4d:	e9 04 ff ff ff       	jmpq   800a56 <vprintfmt+0x89>
  800b52:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b55:	83 f8 30             	cmp    $0x30,%eax
  800b58:	73 17                	jae    800b71 <vprintfmt+0x1a4>
  800b5a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b5e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b61:	89 c0                	mov    %eax,%eax
  800b63:	48 01 d0             	add    %rdx,%rax
  800b66:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b69:	83 c2 08             	add    $0x8,%edx
  800b6c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b6f:	eb 0f                	jmp    800b80 <vprintfmt+0x1b3>
  800b71:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b75:	48 89 d0             	mov    %rdx,%rax
  800b78:	48 83 c2 08          	add    $0x8,%rdx
  800b7c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b80:	8b 10                	mov    (%rax),%edx
  800b82:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800b86:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b8a:	48 89 ce             	mov    %rcx,%rsi
  800b8d:	89 d7                	mov    %edx,%edi
  800b8f:	ff d0                	callq  *%rax
  800b91:	e9 40 03 00 00       	jmpq   800ed6 <vprintfmt+0x509>
  800b96:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b99:	83 f8 30             	cmp    $0x30,%eax
  800b9c:	73 17                	jae    800bb5 <vprintfmt+0x1e8>
  800b9e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ba2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ba5:	89 c0                	mov    %eax,%eax
  800ba7:	48 01 d0             	add    %rdx,%rax
  800baa:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800bad:	83 c2 08             	add    $0x8,%edx
  800bb0:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bb3:	eb 0f                	jmp    800bc4 <vprintfmt+0x1f7>
  800bb5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bb9:	48 89 d0             	mov    %rdx,%rax
  800bbc:	48 83 c2 08          	add    $0x8,%rdx
  800bc0:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bc4:	8b 18                	mov    (%rax),%ebx
  800bc6:	85 db                	test   %ebx,%ebx
  800bc8:	79 02                	jns    800bcc <vprintfmt+0x1ff>
  800bca:	f7 db                	neg    %ebx
  800bcc:	83 fb 15             	cmp    $0x15,%ebx
  800bcf:	7f 16                	jg     800be7 <vprintfmt+0x21a>
  800bd1:	48 b8 00 4d 80 00 00 	movabs $0x804d00,%rax
  800bd8:	00 00 00 
  800bdb:	48 63 d3             	movslq %ebx,%rdx
  800bde:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800be2:	4d 85 e4             	test   %r12,%r12
  800be5:	75 2e                	jne    800c15 <vprintfmt+0x248>
  800be7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800beb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bef:	89 d9                	mov    %ebx,%ecx
  800bf1:	48 ba c1 4d 80 00 00 	movabs $0x804dc1,%rdx
  800bf8:	00 00 00 
  800bfb:	48 89 c7             	mov    %rax,%rdi
  800bfe:	b8 00 00 00 00       	mov    $0x0,%eax
  800c03:	49 b8 e5 0e 80 00 00 	movabs $0x800ee5,%r8
  800c0a:	00 00 00 
  800c0d:	41 ff d0             	callq  *%r8
  800c10:	e9 c1 02 00 00       	jmpq   800ed6 <vprintfmt+0x509>
  800c15:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c19:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c1d:	4c 89 e1             	mov    %r12,%rcx
  800c20:	48 ba ca 4d 80 00 00 	movabs $0x804dca,%rdx
  800c27:	00 00 00 
  800c2a:	48 89 c7             	mov    %rax,%rdi
  800c2d:	b8 00 00 00 00       	mov    $0x0,%eax
  800c32:	49 b8 e5 0e 80 00 00 	movabs $0x800ee5,%r8
  800c39:	00 00 00 
  800c3c:	41 ff d0             	callq  *%r8
  800c3f:	e9 92 02 00 00       	jmpq   800ed6 <vprintfmt+0x509>
  800c44:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c47:	83 f8 30             	cmp    $0x30,%eax
  800c4a:	73 17                	jae    800c63 <vprintfmt+0x296>
  800c4c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c50:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c53:	89 c0                	mov    %eax,%eax
  800c55:	48 01 d0             	add    %rdx,%rax
  800c58:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c5b:	83 c2 08             	add    $0x8,%edx
  800c5e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c61:	eb 0f                	jmp    800c72 <vprintfmt+0x2a5>
  800c63:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c67:	48 89 d0             	mov    %rdx,%rax
  800c6a:	48 83 c2 08          	add    $0x8,%rdx
  800c6e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c72:	4c 8b 20             	mov    (%rax),%r12
  800c75:	4d 85 e4             	test   %r12,%r12
  800c78:	75 0a                	jne    800c84 <vprintfmt+0x2b7>
  800c7a:	49 bc cd 4d 80 00 00 	movabs $0x804dcd,%r12
  800c81:	00 00 00 
  800c84:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c88:	7e 3f                	jle    800cc9 <vprintfmt+0x2fc>
  800c8a:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800c8e:	74 39                	je     800cc9 <vprintfmt+0x2fc>
  800c90:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800c93:	48 98                	cltq   
  800c95:	48 89 c6             	mov    %rax,%rsi
  800c98:	4c 89 e7             	mov    %r12,%rdi
  800c9b:	48 b8 91 11 80 00 00 	movabs $0x801191,%rax
  800ca2:	00 00 00 
  800ca5:	ff d0                	callq  *%rax
  800ca7:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800caa:	eb 17                	jmp    800cc3 <vprintfmt+0x2f6>
  800cac:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800cb0:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800cb4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cb8:	48 89 ce             	mov    %rcx,%rsi
  800cbb:	89 d7                	mov    %edx,%edi
  800cbd:	ff d0                	callq  *%rax
  800cbf:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800cc3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800cc7:	7f e3                	jg     800cac <vprintfmt+0x2df>
  800cc9:	eb 37                	jmp    800d02 <vprintfmt+0x335>
  800ccb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800ccf:	74 1e                	je     800cef <vprintfmt+0x322>
  800cd1:	83 fb 1f             	cmp    $0x1f,%ebx
  800cd4:	7e 05                	jle    800cdb <vprintfmt+0x30e>
  800cd6:	83 fb 7e             	cmp    $0x7e,%ebx
  800cd9:	7e 14                	jle    800cef <vprintfmt+0x322>
  800cdb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cdf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ce3:	48 89 d6             	mov    %rdx,%rsi
  800ce6:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800ceb:	ff d0                	callq  *%rax
  800ced:	eb 0f                	jmp    800cfe <vprintfmt+0x331>
  800cef:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cf3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cf7:	48 89 d6             	mov    %rdx,%rsi
  800cfa:	89 df                	mov    %ebx,%edi
  800cfc:	ff d0                	callq  *%rax
  800cfe:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d02:	4c 89 e0             	mov    %r12,%rax
  800d05:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800d09:	0f b6 00             	movzbl (%rax),%eax
  800d0c:	0f be d8             	movsbl %al,%ebx
  800d0f:	85 db                	test   %ebx,%ebx
  800d11:	74 10                	je     800d23 <vprintfmt+0x356>
  800d13:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d17:	78 b2                	js     800ccb <vprintfmt+0x2fe>
  800d19:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800d1d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d21:	79 a8                	jns    800ccb <vprintfmt+0x2fe>
  800d23:	eb 16                	jmp    800d3b <vprintfmt+0x36e>
  800d25:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d29:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d2d:	48 89 d6             	mov    %rdx,%rsi
  800d30:	bf 20 00 00 00       	mov    $0x20,%edi
  800d35:	ff d0                	callq  *%rax
  800d37:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d3b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d3f:	7f e4                	jg     800d25 <vprintfmt+0x358>
  800d41:	e9 90 01 00 00       	jmpq   800ed6 <vprintfmt+0x509>
  800d46:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d4a:	be 03 00 00 00       	mov    $0x3,%esi
  800d4f:	48 89 c7             	mov    %rax,%rdi
  800d52:	48 b8 bd 08 80 00 00 	movabs $0x8008bd,%rax
  800d59:	00 00 00 
  800d5c:	ff d0                	callq  *%rax
  800d5e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d66:	48 85 c0             	test   %rax,%rax
  800d69:	79 1d                	jns    800d88 <vprintfmt+0x3bb>
  800d6b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d6f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d73:	48 89 d6             	mov    %rdx,%rsi
  800d76:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800d7b:	ff d0                	callq  *%rax
  800d7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d81:	48 f7 d8             	neg    %rax
  800d84:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d88:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800d8f:	e9 d5 00 00 00       	jmpq   800e69 <vprintfmt+0x49c>
  800d94:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d98:	be 03 00 00 00       	mov    $0x3,%esi
  800d9d:	48 89 c7             	mov    %rax,%rdi
  800da0:	48 b8 ad 07 80 00 00 	movabs $0x8007ad,%rax
  800da7:	00 00 00 
  800daa:	ff d0                	callq  *%rax
  800dac:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800db0:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800db7:	e9 ad 00 00 00       	jmpq   800e69 <vprintfmt+0x49c>
  800dbc:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800dc0:	be 03 00 00 00       	mov    $0x3,%esi
  800dc5:	48 89 c7             	mov    %rax,%rdi
  800dc8:	48 b8 ad 07 80 00 00 	movabs $0x8007ad,%rax
  800dcf:	00 00 00 
  800dd2:	ff d0                	callq  *%rax
  800dd4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dd8:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800ddf:	e9 85 00 00 00       	jmpq   800e69 <vprintfmt+0x49c>
  800de4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800de8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dec:	48 89 d6             	mov    %rdx,%rsi
  800def:	bf 30 00 00 00       	mov    $0x30,%edi
  800df4:	ff d0                	callq  *%rax
  800df6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dfa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dfe:	48 89 d6             	mov    %rdx,%rsi
  800e01:	bf 78 00 00 00       	mov    $0x78,%edi
  800e06:	ff d0                	callq  *%rax
  800e08:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e0b:	83 f8 30             	cmp    $0x30,%eax
  800e0e:	73 17                	jae    800e27 <vprintfmt+0x45a>
  800e10:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e14:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e17:	89 c0                	mov    %eax,%eax
  800e19:	48 01 d0             	add    %rdx,%rax
  800e1c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e1f:	83 c2 08             	add    $0x8,%edx
  800e22:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e25:	eb 0f                	jmp    800e36 <vprintfmt+0x469>
  800e27:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e2b:	48 89 d0             	mov    %rdx,%rax
  800e2e:	48 83 c2 08          	add    $0x8,%rdx
  800e32:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e36:	48 8b 00             	mov    (%rax),%rax
  800e39:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e3d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e44:	eb 23                	jmp    800e69 <vprintfmt+0x49c>
  800e46:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e4a:	be 03 00 00 00       	mov    $0x3,%esi
  800e4f:	48 89 c7             	mov    %rax,%rdi
  800e52:	48 b8 ad 07 80 00 00 	movabs $0x8007ad,%rax
  800e59:	00 00 00 
  800e5c:	ff d0                	callq  *%rax
  800e5e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e62:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e69:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800e6e:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800e71:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800e74:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800e78:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800e7c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e80:	45 89 c1             	mov    %r8d,%r9d
  800e83:	41 89 f8             	mov    %edi,%r8d
  800e86:	48 89 c7             	mov    %rax,%rdi
  800e89:	48 b8 f2 06 80 00 00 	movabs $0x8006f2,%rax
  800e90:	00 00 00 
  800e93:	ff d0                	callq  *%rax
  800e95:	eb 3f                	jmp    800ed6 <vprintfmt+0x509>
  800e97:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e9b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e9f:	48 89 d6             	mov    %rdx,%rsi
  800ea2:	89 df                	mov    %ebx,%edi
  800ea4:	ff d0                	callq  *%rax
  800ea6:	eb 2e                	jmp    800ed6 <vprintfmt+0x509>
  800ea8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800eac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800eb0:	48 89 d6             	mov    %rdx,%rsi
  800eb3:	bf 25 00 00 00       	mov    $0x25,%edi
  800eb8:	ff d0                	callq  *%rax
  800eba:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800ebf:	eb 05                	jmp    800ec6 <vprintfmt+0x4f9>
  800ec1:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800ec6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800eca:	48 83 e8 01          	sub    $0x1,%rax
  800ece:	0f b6 00             	movzbl (%rax),%eax
  800ed1:	3c 25                	cmp    $0x25,%al
  800ed3:	75 ec                	jne    800ec1 <vprintfmt+0x4f4>
  800ed5:	90                   	nop
  800ed6:	90                   	nop
  800ed7:	e9 43 fb ff ff       	jmpq   800a1f <vprintfmt+0x52>
  800edc:	48 83 c4 60          	add    $0x60,%rsp
  800ee0:	5b                   	pop    %rbx
  800ee1:	41 5c                	pop    %r12
  800ee3:	5d                   	pop    %rbp
  800ee4:	c3                   	retq   

0000000000800ee5 <printfmt>:
  800ee5:	55                   	push   %rbp
  800ee6:	48 89 e5             	mov    %rsp,%rbp
  800ee9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800ef0:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800ef7:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800efe:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f05:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f0c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f13:	84 c0                	test   %al,%al
  800f15:	74 20                	je     800f37 <printfmt+0x52>
  800f17:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f1b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f1f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f23:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f27:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f2b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f2f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f33:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f37:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800f3e:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800f45:	00 00 00 
  800f48:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800f4f:	00 00 00 
  800f52:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800f56:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800f5d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800f64:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800f6b:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800f72:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800f79:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800f80:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800f87:	48 89 c7             	mov    %rax,%rdi
  800f8a:	48 b8 cd 09 80 00 00 	movabs $0x8009cd,%rax
  800f91:	00 00 00 
  800f94:	ff d0                	callq  *%rax
  800f96:	c9                   	leaveq 
  800f97:	c3                   	retq   

0000000000800f98 <sprintputch>:
  800f98:	55                   	push   %rbp
  800f99:	48 89 e5             	mov    %rsp,%rbp
  800f9c:	48 83 ec 10          	sub    $0x10,%rsp
  800fa0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800fa3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800fa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fab:	8b 40 10             	mov    0x10(%rax),%eax
  800fae:	8d 50 01             	lea    0x1(%rax),%edx
  800fb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fb5:	89 50 10             	mov    %edx,0x10(%rax)
  800fb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fbc:	48 8b 10             	mov    (%rax),%rdx
  800fbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fc3:	48 8b 40 08          	mov    0x8(%rax),%rax
  800fc7:	48 39 c2             	cmp    %rax,%rdx
  800fca:	73 17                	jae    800fe3 <sprintputch+0x4b>
  800fcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fd0:	48 8b 00             	mov    (%rax),%rax
  800fd3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800fd7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800fdb:	48 89 0a             	mov    %rcx,(%rdx)
  800fde:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800fe1:	88 10                	mov    %dl,(%rax)
  800fe3:	c9                   	leaveq 
  800fe4:	c3                   	retq   

0000000000800fe5 <vsnprintf>:
  800fe5:	55                   	push   %rbp
  800fe6:	48 89 e5             	mov    %rsp,%rbp
  800fe9:	48 83 ec 50          	sub    $0x50,%rsp
  800fed:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800ff1:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800ff4:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800ff8:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800ffc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  801000:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801004:	48 8b 0a             	mov    (%rdx),%rcx
  801007:	48 89 08             	mov    %rcx,(%rax)
  80100a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80100e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801012:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801016:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80101a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80101e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801022:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801025:	48 98                	cltq   
  801027:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80102b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80102f:	48 01 d0             	add    %rdx,%rax
  801032:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801036:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80103d:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801042:	74 06                	je     80104a <vsnprintf+0x65>
  801044:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801048:	7f 07                	jg     801051 <vsnprintf+0x6c>
  80104a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80104f:	eb 2f                	jmp    801080 <vsnprintf+0x9b>
  801051:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801055:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801059:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80105d:	48 89 c6             	mov    %rax,%rsi
  801060:	48 bf 98 0f 80 00 00 	movabs $0x800f98,%rdi
  801067:	00 00 00 
  80106a:	48 b8 cd 09 80 00 00 	movabs $0x8009cd,%rax
  801071:	00 00 00 
  801074:	ff d0                	callq  *%rax
  801076:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80107a:	c6 00 00             	movb   $0x0,(%rax)
  80107d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801080:	c9                   	leaveq 
  801081:	c3                   	retq   

0000000000801082 <snprintf>:
  801082:	55                   	push   %rbp
  801083:	48 89 e5             	mov    %rsp,%rbp
  801086:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  80108d:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  801094:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  80109a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8010a1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8010a8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8010af:	84 c0                	test   %al,%al
  8010b1:	74 20                	je     8010d3 <snprintf+0x51>
  8010b3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8010b7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8010bb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8010bf:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8010c3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8010c7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8010cb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8010cf:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8010d3:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8010da:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8010e1:	00 00 00 
  8010e4:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8010eb:	00 00 00 
  8010ee:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8010f2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8010f9:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801100:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801107:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80110e:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801115:	48 8b 0a             	mov    (%rdx),%rcx
  801118:	48 89 08             	mov    %rcx,(%rax)
  80111b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80111f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801123:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801127:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80112b:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801132:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801139:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80113f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801146:	48 89 c7             	mov    %rax,%rdi
  801149:	48 b8 e5 0f 80 00 00 	movabs $0x800fe5,%rax
  801150:	00 00 00 
  801153:	ff d0                	callq  *%rax
  801155:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80115b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801161:	c9                   	leaveq 
  801162:	c3                   	retq   

0000000000801163 <strlen>:
  801163:	55                   	push   %rbp
  801164:	48 89 e5             	mov    %rsp,%rbp
  801167:	48 83 ec 18          	sub    $0x18,%rsp
  80116b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80116f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801176:	eb 09                	jmp    801181 <strlen+0x1e>
  801178:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80117c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801181:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801185:	0f b6 00             	movzbl (%rax),%eax
  801188:	84 c0                	test   %al,%al
  80118a:	75 ec                	jne    801178 <strlen+0x15>
  80118c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80118f:	c9                   	leaveq 
  801190:	c3                   	retq   

0000000000801191 <strnlen>:
  801191:	55                   	push   %rbp
  801192:	48 89 e5             	mov    %rsp,%rbp
  801195:	48 83 ec 20          	sub    $0x20,%rsp
  801199:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80119d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011a8:	eb 0e                	jmp    8011b8 <strnlen+0x27>
  8011aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8011ae:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8011b3:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8011b8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8011bd:	74 0b                	je     8011ca <strnlen+0x39>
  8011bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011c3:	0f b6 00             	movzbl (%rax),%eax
  8011c6:	84 c0                	test   %al,%al
  8011c8:	75 e0                	jne    8011aa <strnlen+0x19>
  8011ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011cd:	c9                   	leaveq 
  8011ce:	c3                   	retq   

00000000008011cf <strcpy>:
  8011cf:	55                   	push   %rbp
  8011d0:	48 89 e5             	mov    %rsp,%rbp
  8011d3:	48 83 ec 20          	sub    $0x20,%rsp
  8011d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8011e7:	90                   	nop
  8011e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ec:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8011f0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8011f4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8011f8:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8011fc:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801200:	0f b6 12             	movzbl (%rdx),%edx
  801203:	88 10                	mov    %dl,(%rax)
  801205:	0f b6 00             	movzbl (%rax),%eax
  801208:	84 c0                	test   %al,%al
  80120a:	75 dc                	jne    8011e8 <strcpy+0x19>
  80120c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801210:	c9                   	leaveq 
  801211:	c3                   	retq   

0000000000801212 <strcat>:
  801212:	55                   	push   %rbp
  801213:	48 89 e5             	mov    %rsp,%rbp
  801216:	48 83 ec 20          	sub    $0x20,%rsp
  80121a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80121e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801222:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801226:	48 89 c7             	mov    %rax,%rdi
  801229:	48 b8 63 11 80 00 00 	movabs $0x801163,%rax
  801230:	00 00 00 
  801233:	ff d0                	callq  *%rax
  801235:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801238:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80123b:	48 63 d0             	movslq %eax,%rdx
  80123e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801242:	48 01 c2             	add    %rax,%rdx
  801245:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801249:	48 89 c6             	mov    %rax,%rsi
  80124c:	48 89 d7             	mov    %rdx,%rdi
  80124f:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  801256:	00 00 00 
  801259:	ff d0                	callq  *%rax
  80125b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80125f:	c9                   	leaveq 
  801260:	c3                   	retq   

0000000000801261 <strncpy>:
  801261:	55                   	push   %rbp
  801262:	48 89 e5             	mov    %rsp,%rbp
  801265:	48 83 ec 28          	sub    $0x28,%rsp
  801269:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80126d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801271:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801275:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801279:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80127d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801284:	00 
  801285:	eb 2a                	jmp    8012b1 <strncpy+0x50>
  801287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80128b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80128f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801293:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801297:	0f b6 12             	movzbl (%rdx),%edx
  80129a:	88 10                	mov    %dl,(%rax)
  80129c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012a0:	0f b6 00             	movzbl (%rax),%eax
  8012a3:	84 c0                	test   %al,%al
  8012a5:	74 05                	je     8012ac <strncpy+0x4b>
  8012a7:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8012ac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012b5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8012b9:	72 cc                	jb     801287 <strncpy+0x26>
  8012bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012bf:	c9                   	leaveq 
  8012c0:	c3                   	retq   

00000000008012c1 <strlcpy>:
  8012c1:	55                   	push   %rbp
  8012c2:	48 89 e5             	mov    %rsp,%rbp
  8012c5:	48 83 ec 28          	sub    $0x28,%rsp
  8012c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012cd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012d1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8012e2:	74 3d                	je     801321 <strlcpy+0x60>
  8012e4:	eb 1d                	jmp    801303 <strlcpy+0x42>
  8012e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012ea:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8012ee:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8012f6:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8012fa:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8012fe:	0f b6 12             	movzbl (%rdx),%edx
  801301:	88 10                	mov    %dl,(%rax)
  801303:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801308:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80130d:	74 0b                	je     80131a <strlcpy+0x59>
  80130f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801313:	0f b6 00             	movzbl (%rax),%eax
  801316:	84 c0                	test   %al,%al
  801318:	75 cc                	jne    8012e6 <strlcpy+0x25>
  80131a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80131e:	c6 00 00             	movb   $0x0,(%rax)
  801321:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801325:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801329:	48 29 c2             	sub    %rax,%rdx
  80132c:	48 89 d0             	mov    %rdx,%rax
  80132f:	c9                   	leaveq 
  801330:	c3                   	retq   

0000000000801331 <strcmp>:
  801331:	55                   	push   %rbp
  801332:	48 89 e5             	mov    %rsp,%rbp
  801335:	48 83 ec 10          	sub    $0x10,%rsp
  801339:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80133d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801341:	eb 0a                	jmp    80134d <strcmp+0x1c>
  801343:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801348:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80134d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801351:	0f b6 00             	movzbl (%rax),%eax
  801354:	84 c0                	test   %al,%al
  801356:	74 12                	je     80136a <strcmp+0x39>
  801358:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80135c:	0f b6 10             	movzbl (%rax),%edx
  80135f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801363:	0f b6 00             	movzbl (%rax),%eax
  801366:	38 c2                	cmp    %al,%dl
  801368:	74 d9                	je     801343 <strcmp+0x12>
  80136a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80136e:	0f b6 00             	movzbl (%rax),%eax
  801371:	0f b6 d0             	movzbl %al,%edx
  801374:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801378:	0f b6 00             	movzbl (%rax),%eax
  80137b:	0f b6 c0             	movzbl %al,%eax
  80137e:	29 c2                	sub    %eax,%edx
  801380:	89 d0                	mov    %edx,%eax
  801382:	c9                   	leaveq 
  801383:	c3                   	retq   

0000000000801384 <strncmp>:
  801384:	55                   	push   %rbp
  801385:	48 89 e5             	mov    %rsp,%rbp
  801388:	48 83 ec 18          	sub    $0x18,%rsp
  80138c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801390:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801394:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801398:	eb 0f                	jmp    8013a9 <strncmp+0x25>
  80139a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80139f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8013a4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8013a9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013ae:	74 1d                	je     8013cd <strncmp+0x49>
  8013b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013b4:	0f b6 00             	movzbl (%rax),%eax
  8013b7:	84 c0                	test   %al,%al
  8013b9:	74 12                	je     8013cd <strncmp+0x49>
  8013bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013bf:	0f b6 10             	movzbl (%rax),%edx
  8013c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013c6:	0f b6 00             	movzbl (%rax),%eax
  8013c9:	38 c2                	cmp    %al,%dl
  8013cb:	74 cd                	je     80139a <strncmp+0x16>
  8013cd:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013d2:	75 07                	jne    8013db <strncmp+0x57>
  8013d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d9:	eb 18                	jmp    8013f3 <strncmp+0x6f>
  8013db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013df:	0f b6 00             	movzbl (%rax),%eax
  8013e2:	0f b6 d0             	movzbl %al,%edx
  8013e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013e9:	0f b6 00             	movzbl (%rax),%eax
  8013ec:	0f b6 c0             	movzbl %al,%eax
  8013ef:	29 c2                	sub    %eax,%edx
  8013f1:	89 d0                	mov    %edx,%eax
  8013f3:	c9                   	leaveq 
  8013f4:	c3                   	retq   

00000000008013f5 <strchr>:
  8013f5:	55                   	push   %rbp
  8013f6:	48 89 e5             	mov    %rsp,%rbp
  8013f9:	48 83 ec 0c          	sub    $0xc,%rsp
  8013fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801401:	89 f0                	mov    %esi,%eax
  801403:	88 45 f4             	mov    %al,-0xc(%rbp)
  801406:	eb 17                	jmp    80141f <strchr+0x2a>
  801408:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80140c:	0f b6 00             	movzbl (%rax),%eax
  80140f:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801412:	75 06                	jne    80141a <strchr+0x25>
  801414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801418:	eb 15                	jmp    80142f <strchr+0x3a>
  80141a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80141f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801423:	0f b6 00             	movzbl (%rax),%eax
  801426:	84 c0                	test   %al,%al
  801428:	75 de                	jne    801408 <strchr+0x13>
  80142a:	b8 00 00 00 00       	mov    $0x0,%eax
  80142f:	c9                   	leaveq 
  801430:	c3                   	retq   

0000000000801431 <strfind>:
  801431:	55                   	push   %rbp
  801432:	48 89 e5             	mov    %rsp,%rbp
  801435:	48 83 ec 0c          	sub    $0xc,%rsp
  801439:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80143d:	89 f0                	mov    %esi,%eax
  80143f:	88 45 f4             	mov    %al,-0xc(%rbp)
  801442:	eb 13                	jmp    801457 <strfind+0x26>
  801444:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801448:	0f b6 00             	movzbl (%rax),%eax
  80144b:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80144e:	75 02                	jne    801452 <strfind+0x21>
  801450:	eb 10                	jmp    801462 <strfind+0x31>
  801452:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80145b:	0f b6 00             	movzbl (%rax),%eax
  80145e:	84 c0                	test   %al,%al
  801460:	75 e2                	jne    801444 <strfind+0x13>
  801462:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801466:	c9                   	leaveq 
  801467:	c3                   	retq   

0000000000801468 <memset>:
  801468:	55                   	push   %rbp
  801469:	48 89 e5             	mov    %rsp,%rbp
  80146c:	48 83 ec 18          	sub    $0x18,%rsp
  801470:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801474:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801477:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80147b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801480:	75 06                	jne    801488 <memset+0x20>
  801482:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801486:	eb 69                	jmp    8014f1 <memset+0x89>
  801488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80148c:	83 e0 03             	and    $0x3,%eax
  80148f:	48 85 c0             	test   %rax,%rax
  801492:	75 48                	jne    8014dc <memset+0x74>
  801494:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801498:	83 e0 03             	and    $0x3,%eax
  80149b:	48 85 c0             	test   %rax,%rax
  80149e:	75 3c                	jne    8014dc <memset+0x74>
  8014a0:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8014a7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014aa:	c1 e0 18             	shl    $0x18,%eax
  8014ad:	89 c2                	mov    %eax,%edx
  8014af:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014b2:	c1 e0 10             	shl    $0x10,%eax
  8014b5:	09 c2                	or     %eax,%edx
  8014b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014ba:	c1 e0 08             	shl    $0x8,%eax
  8014bd:	09 d0                	or     %edx,%eax
  8014bf:	09 45 f4             	or     %eax,-0xc(%rbp)
  8014c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014c6:	48 c1 e8 02          	shr    $0x2,%rax
  8014ca:	48 89 c1             	mov    %rax,%rcx
  8014cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014d4:	48 89 d7             	mov    %rdx,%rdi
  8014d7:	fc                   	cld    
  8014d8:	f3 ab                	rep stos %eax,%es:(%rdi)
  8014da:	eb 11                	jmp    8014ed <memset+0x85>
  8014dc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014e3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8014e7:	48 89 d7             	mov    %rdx,%rdi
  8014ea:	fc                   	cld    
  8014eb:	f3 aa                	rep stos %al,%es:(%rdi)
  8014ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014f1:	c9                   	leaveq 
  8014f2:	c3                   	retq   

00000000008014f3 <memmove>:
  8014f3:	55                   	push   %rbp
  8014f4:	48 89 e5             	mov    %rsp,%rbp
  8014f7:	48 83 ec 28          	sub    $0x28,%rsp
  8014fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014ff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801503:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801507:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80150b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80150f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801513:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80151b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80151f:	0f 83 88 00 00 00    	jae    8015ad <memmove+0xba>
  801525:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801529:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80152d:	48 01 d0             	add    %rdx,%rax
  801530:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801534:	76 77                	jbe    8015ad <memmove+0xba>
  801536:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80153a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80153e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801542:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801546:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80154a:	83 e0 03             	and    $0x3,%eax
  80154d:	48 85 c0             	test   %rax,%rax
  801550:	75 3b                	jne    80158d <memmove+0x9a>
  801552:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801556:	83 e0 03             	and    $0x3,%eax
  801559:	48 85 c0             	test   %rax,%rax
  80155c:	75 2f                	jne    80158d <memmove+0x9a>
  80155e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801562:	83 e0 03             	and    $0x3,%eax
  801565:	48 85 c0             	test   %rax,%rax
  801568:	75 23                	jne    80158d <memmove+0x9a>
  80156a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80156e:	48 83 e8 04          	sub    $0x4,%rax
  801572:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801576:	48 83 ea 04          	sub    $0x4,%rdx
  80157a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80157e:	48 c1 e9 02          	shr    $0x2,%rcx
  801582:	48 89 c7             	mov    %rax,%rdi
  801585:	48 89 d6             	mov    %rdx,%rsi
  801588:	fd                   	std    
  801589:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80158b:	eb 1d                	jmp    8015aa <memmove+0xb7>
  80158d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801591:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801595:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801599:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  80159d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015a1:	48 89 d7             	mov    %rdx,%rdi
  8015a4:	48 89 c1             	mov    %rax,%rcx
  8015a7:	fd                   	std    
  8015a8:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8015aa:	fc                   	cld    
  8015ab:	eb 57                	jmp    801604 <memmove+0x111>
  8015ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015b1:	83 e0 03             	and    $0x3,%eax
  8015b4:	48 85 c0             	test   %rax,%rax
  8015b7:	75 36                	jne    8015ef <memmove+0xfc>
  8015b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015bd:	83 e0 03             	and    $0x3,%eax
  8015c0:	48 85 c0             	test   %rax,%rax
  8015c3:	75 2a                	jne    8015ef <memmove+0xfc>
  8015c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015c9:	83 e0 03             	and    $0x3,%eax
  8015cc:	48 85 c0             	test   %rax,%rax
  8015cf:	75 1e                	jne    8015ef <memmove+0xfc>
  8015d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015d5:	48 c1 e8 02          	shr    $0x2,%rax
  8015d9:	48 89 c1             	mov    %rax,%rcx
  8015dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015e4:	48 89 c7             	mov    %rax,%rdi
  8015e7:	48 89 d6             	mov    %rdx,%rsi
  8015ea:	fc                   	cld    
  8015eb:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8015ed:	eb 15                	jmp    801604 <memmove+0x111>
  8015ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015f3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015f7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8015fb:	48 89 c7             	mov    %rax,%rdi
  8015fe:	48 89 d6             	mov    %rdx,%rsi
  801601:	fc                   	cld    
  801602:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801604:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801608:	c9                   	leaveq 
  801609:	c3                   	retq   

000000000080160a <memcpy>:
  80160a:	55                   	push   %rbp
  80160b:	48 89 e5             	mov    %rsp,%rbp
  80160e:	48 83 ec 18          	sub    $0x18,%rsp
  801612:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801616:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80161a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80161e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801622:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801626:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80162a:	48 89 ce             	mov    %rcx,%rsi
  80162d:	48 89 c7             	mov    %rax,%rdi
  801630:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  801637:	00 00 00 
  80163a:	ff d0                	callq  *%rax
  80163c:	c9                   	leaveq 
  80163d:	c3                   	retq   

000000000080163e <memcmp>:
  80163e:	55                   	push   %rbp
  80163f:	48 89 e5             	mov    %rsp,%rbp
  801642:	48 83 ec 28          	sub    $0x28,%rsp
  801646:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80164a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80164e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801652:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801656:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80165a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80165e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801662:	eb 36                	jmp    80169a <memcmp+0x5c>
  801664:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801668:	0f b6 10             	movzbl (%rax),%edx
  80166b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80166f:	0f b6 00             	movzbl (%rax),%eax
  801672:	38 c2                	cmp    %al,%dl
  801674:	74 1a                	je     801690 <memcmp+0x52>
  801676:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80167a:	0f b6 00             	movzbl (%rax),%eax
  80167d:	0f b6 d0             	movzbl %al,%edx
  801680:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801684:	0f b6 00             	movzbl (%rax),%eax
  801687:	0f b6 c0             	movzbl %al,%eax
  80168a:	29 c2                	sub    %eax,%edx
  80168c:	89 d0                	mov    %edx,%eax
  80168e:	eb 20                	jmp    8016b0 <memcmp+0x72>
  801690:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801695:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80169a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80169e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8016a2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016a6:	48 85 c0             	test   %rax,%rax
  8016a9:	75 b9                	jne    801664 <memcmp+0x26>
  8016ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b0:	c9                   	leaveq 
  8016b1:	c3                   	retq   

00000000008016b2 <memfind>:
  8016b2:	55                   	push   %rbp
  8016b3:	48 89 e5             	mov    %rsp,%rbp
  8016b6:	48 83 ec 28          	sub    $0x28,%rsp
  8016ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8016be:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8016c1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016c9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8016cd:	48 01 d0             	add    %rdx,%rax
  8016d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8016d4:	eb 15                	jmp    8016eb <memfind+0x39>
  8016d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016da:	0f b6 10             	movzbl (%rax),%edx
  8016dd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8016e0:	38 c2                	cmp    %al,%dl
  8016e2:	75 02                	jne    8016e6 <memfind+0x34>
  8016e4:	eb 0f                	jmp    8016f5 <memfind+0x43>
  8016e6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8016eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016ef:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8016f3:	72 e1                	jb     8016d6 <memfind+0x24>
  8016f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016f9:	c9                   	leaveq 
  8016fa:	c3                   	retq   

00000000008016fb <strtol>:
  8016fb:	55                   	push   %rbp
  8016fc:	48 89 e5             	mov    %rsp,%rbp
  8016ff:	48 83 ec 34          	sub    $0x34,%rsp
  801703:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801707:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80170b:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80170e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801715:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  80171c:	00 
  80171d:	eb 05                	jmp    801724 <strtol+0x29>
  80171f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801724:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801728:	0f b6 00             	movzbl (%rax),%eax
  80172b:	3c 20                	cmp    $0x20,%al
  80172d:	74 f0                	je     80171f <strtol+0x24>
  80172f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801733:	0f b6 00             	movzbl (%rax),%eax
  801736:	3c 09                	cmp    $0x9,%al
  801738:	74 e5                	je     80171f <strtol+0x24>
  80173a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80173e:	0f b6 00             	movzbl (%rax),%eax
  801741:	3c 2b                	cmp    $0x2b,%al
  801743:	75 07                	jne    80174c <strtol+0x51>
  801745:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80174a:	eb 17                	jmp    801763 <strtol+0x68>
  80174c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801750:	0f b6 00             	movzbl (%rax),%eax
  801753:	3c 2d                	cmp    $0x2d,%al
  801755:	75 0c                	jne    801763 <strtol+0x68>
  801757:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80175c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801763:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801767:	74 06                	je     80176f <strtol+0x74>
  801769:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  80176d:	75 28                	jne    801797 <strtol+0x9c>
  80176f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801773:	0f b6 00             	movzbl (%rax),%eax
  801776:	3c 30                	cmp    $0x30,%al
  801778:	75 1d                	jne    801797 <strtol+0x9c>
  80177a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80177e:	48 83 c0 01          	add    $0x1,%rax
  801782:	0f b6 00             	movzbl (%rax),%eax
  801785:	3c 78                	cmp    $0x78,%al
  801787:	75 0e                	jne    801797 <strtol+0x9c>
  801789:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  80178e:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801795:	eb 2c                	jmp    8017c3 <strtol+0xc8>
  801797:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80179b:	75 19                	jne    8017b6 <strtol+0xbb>
  80179d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a1:	0f b6 00             	movzbl (%rax),%eax
  8017a4:	3c 30                	cmp    $0x30,%al
  8017a6:	75 0e                	jne    8017b6 <strtol+0xbb>
  8017a8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8017ad:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8017b4:	eb 0d                	jmp    8017c3 <strtol+0xc8>
  8017b6:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017ba:	75 07                	jne    8017c3 <strtol+0xc8>
  8017bc:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8017c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017c7:	0f b6 00             	movzbl (%rax),%eax
  8017ca:	3c 2f                	cmp    $0x2f,%al
  8017cc:	7e 1d                	jle    8017eb <strtol+0xf0>
  8017ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017d2:	0f b6 00             	movzbl (%rax),%eax
  8017d5:	3c 39                	cmp    $0x39,%al
  8017d7:	7f 12                	jg     8017eb <strtol+0xf0>
  8017d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017dd:	0f b6 00             	movzbl (%rax),%eax
  8017e0:	0f be c0             	movsbl %al,%eax
  8017e3:	83 e8 30             	sub    $0x30,%eax
  8017e6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8017e9:	eb 4e                	jmp    801839 <strtol+0x13e>
  8017eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ef:	0f b6 00             	movzbl (%rax),%eax
  8017f2:	3c 60                	cmp    $0x60,%al
  8017f4:	7e 1d                	jle    801813 <strtol+0x118>
  8017f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017fa:	0f b6 00             	movzbl (%rax),%eax
  8017fd:	3c 7a                	cmp    $0x7a,%al
  8017ff:	7f 12                	jg     801813 <strtol+0x118>
  801801:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801805:	0f b6 00             	movzbl (%rax),%eax
  801808:	0f be c0             	movsbl %al,%eax
  80180b:	83 e8 57             	sub    $0x57,%eax
  80180e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801811:	eb 26                	jmp    801839 <strtol+0x13e>
  801813:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801817:	0f b6 00             	movzbl (%rax),%eax
  80181a:	3c 40                	cmp    $0x40,%al
  80181c:	7e 48                	jle    801866 <strtol+0x16b>
  80181e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801822:	0f b6 00             	movzbl (%rax),%eax
  801825:	3c 5a                	cmp    $0x5a,%al
  801827:	7f 3d                	jg     801866 <strtol+0x16b>
  801829:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80182d:	0f b6 00             	movzbl (%rax),%eax
  801830:	0f be c0             	movsbl %al,%eax
  801833:	83 e8 37             	sub    $0x37,%eax
  801836:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801839:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80183c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  80183f:	7c 02                	jl     801843 <strtol+0x148>
  801841:	eb 23                	jmp    801866 <strtol+0x16b>
  801843:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801848:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80184b:	48 98                	cltq   
  80184d:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801852:	48 89 c2             	mov    %rax,%rdx
  801855:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801858:	48 98                	cltq   
  80185a:	48 01 d0             	add    %rdx,%rax
  80185d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801861:	e9 5d ff ff ff       	jmpq   8017c3 <strtol+0xc8>
  801866:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  80186b:	74 0b                	je     801878 <strtol+0x17d>
  80186d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801871:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801875:	48 89 10             	mov    %rdx,(%rax)
  801878:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80187c:	74 09                	je     801887 <strtol+0x18c>
  80187e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801882:	48 f7 d8             	neg    %rax
  801885:	eb 04                	jmp    80188b <strtol+0x190>
  801887:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80188b:	c9                   	leaveq 
  80188c:	c3                   	retq   

000000000080188d <strstr>:
  80188d:	55                   	push   %rbp
  80188e:	48 89 e5             	mov    %rsp,%rbp
  801891:	48 83 ec 30          	sub    $0x30,%rsp
  801895:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801899:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80189d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018a1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8018a5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8018a9:	0f b6 00             	movzbl (%rax),%eax
  8018ac:	88 45 ff             	mov    %al,-0x1(%rbp)
  8018af:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8018b3:	75 06                	jne    8018bb <strstr+0x2e>
  8018b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018b9:	eb 6b                	jmp    801926 <strstr+0x99>
  8018bb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018bf:	48 89 c7             	mov    %rax,%rdi
  8018c2:	48 b8 63 11 80 00 00 	movabs $0x801163,%rax
  8018c9:	00 00 00 
  8018cc:	ff d0                	callq  *%rax
  8018ce:	48 98                	cltq   
  8018d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8018d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018d8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8018dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018e0:	0f b6 00             	movzbl (%rax),%eax
  8018e3:	88 45 ef             	mov    %al,-0x11(%rbp)
  8018e6:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8018ea:	75 07                	jne    8018f3 <strstr+0x66>
  8018ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8018f1:	eb 33                	jmp    801926 <strstr+0x99>
  8018f3:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8018f7:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8018fa:	75 d8                	jne    8018d4 <strstr+0x47>
  8018fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801900:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801904:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801908:	48 89 ce             	mov    %rcx,%rsi
  80190b:	48 89 c7             	mov    %rax,%rdi
  80190e:	48 b8 84 13 80 00 00 	movabs $0x801384,%rax
  801915:	00 00 00 
  801918:	ff d0                	callq  *%rax
  80191a:	85 c0                	test   %eax,%eax
  80191c:	75 b6                	jne    8018d4 <strstr+0x47>
  80191e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801922:	48 83 e8 01          	sub    $0x1,%rax
  801926:	c9                   	leaveq 
  801927:	c3                   	retq   

0000000000801928 <syscall>:
  801928:	55                   	push   %rbp
  801929:	48 89 e5             	mov    %rsp,%rbp
  80192c:	53                   	push   %rbx
  80192d:	48 83 ec 48          	sub    $0x48,%rsp
  801931:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801934:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801937:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80193b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80193f:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801943:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801947:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80194a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80194e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801952:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801956:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  80195a:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  80195e:	4c 89 c3             	mov    %r8,%rbx
  801961:	cd 30                	int    $0x30
  801963:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801967:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  80196b:	74 3e                	je     8019ab <syscall+0x83>
  80196d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801972:	7e 37                	jle    8019ab <syscall+0x83>
  801974:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801978:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80197b:	49 89 d0             	mov    %rdx,%r8
  80197e:	89 c1                	mov    %eax,%ecx
  801980:	48 ba 88 50 80 00 00 	movabs $0x805088,%rdx
  801987:	00 00 00 
  80198a:	be 24 00 00 00       	mov    $0x24,%esi
  80198f:	48 bf a5 50 80 00 00 	movabs $0x8050a5,%rdi
  801996:	00 00 00 
  801999:	b8 00 00 00 00       	mov    $0x0,%eax
  80199e:	49 b9 e1 03 80 00 00 	movabs $0x8003e1,%r9
  8019a5:	00 00 00 
  8019a8:	41 ff d1             	callq  *%r9
  8019ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019af:	48 83 c4 48          	add    $0x48,%rsp
  8019b3:	5b                   	pop    %rbx
  8019b4:	5d                   	pop    %rbp
  8019b5:	c3                   	retq   

00000000008019b6 <sys_cputs>:
  8019b6:	55                   	push   %rbp
  8019b7:	48 89 e5             	mov    %rsp,%rbp
  8019ba:	48 83 ec 20          	sub    $0x20,%rsp
  8019be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8019c2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019ce:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019d5:	00 
  8019d6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019dc:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019e2:	48 89 d1             	mov    %rdx,%rcx
  8019e5:	48 89 c2             	mov    %rax,%rdx
  8019e8:	be 00 00 00 00       	mov    $0x0,%esi
  8019ed:	bf 00 00 00 00       	mov    $0x0,%edi
  8019f2:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  8019f9:	00 00 00 
  8019fc:	ff d0                	callq  *%rax
  8019fe:	c9                   	leaveq 
  8019ff:	c3                   	retq   

0000000000801a00 <sys_cgetc>:
  801a00:	55                   	push   %rbp
  801a01:	48 89 e5             	mov    %rsp,%rbp
  801a04:	48 83 ec 10          	sub    $0x10,%rsp
  801a08:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a0f:	00 
  801a10:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a16:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a1c:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a21:	ba 00 00 00 00       	mov    $0x0,%edx
  801a26:	be 00 00 00 00       	mov    $0x0,%esi
  801a2b:	bf 01 00 00 00       	mov    $0x1,%edi
  801a30:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801a37:	00 00 00 
  801a3a:	ff d0                	callq  *%rax
  801a3c:	c9                   	leaveq 
  801a3d:	c3                   	retq   

0000000000801a3e <sys_env_destroy>:
  801a3e:	55                   	push   %rbp
  801a3f:	48 89 e5             	mov    %rsp,%rbp
  801a42:	48 83 ec 10          	sub    $0x10,%rsp
  801a46:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a49:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a4c:	48 98                	cltq   
  801a4e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a55:	00 
  801a56:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a5c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a62:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a67:	48 89 c2             	mov    %rax,%rdx
  801a6a:	be 01 00 00 00       	mov    $0x1,%esi
  801a6f:	bf 03 00 00 00       	mov    $0x3,%edi
  801a74:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801a7b:	00 00 00 
  801a7e:	ff d0                	callq  *%rax
  801a80:	c9                   	leaveq 
  801a81:	c3                   	retq   

0000000000801a82 <sys_getenvid>:
  801a82:	55                   	push   %rbp
  801a83:	48 89 e5             	mov    %rsp,%rbp
  801a86:	48 83 ec 10          	sub    $0x10,%rsp
  801a8a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a91:	00 
  801a92:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a98:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a9e:	b9 00 00 00 00       	mov    $0x0,%ecx
  801aa3:	ba 00 00 00 00       	mov    $0x0,%edx
  801aa8:	be 00 00 00 00       	mov    $0x0,%esi
  801aad:	bf 02 00 00 00       	mov    $0x2,%edi
  801ab2:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801ab9:	00 00 00 
  801abc:	ff d0                	callq  *%rax
  801abe:	c9                   	leaveq 
  801abf:	c3                   	retq   

0000000000801ac0 <sys_yield>:
  801ac0:	55                   	push   %rbp
  801ac1:	48 89 e5             	mov    %rsp,%rbp
  801ac4:	48 83 ec 10          	sub    $0x10,%rsp
  801ac8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801acf:	00 
  801ad0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ad6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801adc:	b9 00 00 00 00       	mov    $0x0,%ecx
  801ae1:	ba 00 00 00 00       	mov    $0x0,%edx
  801ae6:	be 00 00 00 00       	mov    $0x0,%esi
  801aeb:	bf 0b 00 00 00       	mov    $0xb,%edi
  801af0:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801af7:	00 00 00 
  801afa:	ff d0                	callq  *%rax
  801afc:	c9                   	leaveq 
  801afd:	c3                   	retq   

0000000000801afe <sys_page_alloc>:
  801afe:	55                   	push   %rbp
  801aff:	48 89 e5             	mov    %rsp,%rbp
  801b02:	48 83 ec 20          	sub    $0x20,%rsp
  801b06:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b09:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b0d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b10:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b13:	48 63 c8             	movslq %eax,%rcx
  801b16:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b1d:	48 98                	cltq   
  801b1f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b26:	00 
  801b27:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b2d:	49 89 c8             	mov    %rcx,%r8
  801b30:	48 89 d1             	mov    %rdx,%rcx
  801b33:	48 89 c2             	mov    %rax,%rdx
  801b36:	be 01 00 00 00       	mov    $0x1,%esi
  801b3b:	bf 04 00 00 00       	mov    $0x4,%edi
  801b40:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801b47:	00 00 00 
  801b4a:	ff d0                	callq  *%rax
  801b4c:	c9                   	leaveq 
  801b4d:	c3                   	retq   

0000000000801b4e <sys_page_map>:
  801b4e:	55                   	push   %rbp
  801b4f:	48 89 e5             	mov    %rsp,%rbp
  801b52:	48 83 ec 30          	sub    $0x30,%rsp
  801b56:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b59:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b5d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b60:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801b64:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801b68:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801b6b:	48 63 c8             	movslq %eax,%rcx
  801b6e:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801b72:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b75:	48 63 f0             	movslq %eax,%rsi
  801b78:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b7f:	48 98                	cltq   
  801b81:	48 89 0c 24          	mov    %rcx,(%rsp)
  801b85:	49 89 f9             	mov    %rdi,%r9
  801b88:	49 89 f0             	mov    %rsi,%r8
  801b8b:	48 89 d1             	mov    %rdx,%rcx
  801b8e:	48 89 c2             	mov    %rax,%rdx
  801b91:	be 01 00 00 00       	mov    $0x1,%esi
  801b96:	bf 05 00 00 00       	mov    $0x5,%edi
  801b9b:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801ba2:	00 00 00 
  801ba5:	ff d0                	callq  *%rax
  801ba7:	c9                   	leaveq 
  801ba8:	c3                   	retq   

0000000000801ba9 <sys_page_unmap>:
  801ba9:	55                   	push   %rbp
  801baa:	48 89 e5             	mov    %rsp,%rbp
  801bad:	48 83 ec 20          	sub    $0x20,%rsp
  801bb1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bb4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bb8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bbf:	48 98                	cltq   
  801bc1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bc8:	00 
  801bc9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bcf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bd5:	48 89 d1             	mov    %rdx,%rcx
  801bd8:	48 89 c2             	mov    %rax,%rdx
  801bdb:	be 01 00 00 00       	mov    $0x1,%esi
  801be0:	bf 06 00 00 00       	mov    $0x6,%edi
  801be5:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801bec:	00 00 00 
  801bef:	ff d0                	callq  *%rax
  801bf1:	c9                   	leaveq 
  801bf2:	c3                   	retq   

0000000000801bf3 <sys_env_set_status>:
  801bf3:	55                   	push   %rbp
  801bf4:	48 89 e5             	mov    %rsp,%rbp
  801bf7:	48 83 ec 10          	sub    $0x10,%rsp
  801bfb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bfe:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801c01:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c04:	48 63 d0             	movslq %eax,%rdx
  801c07:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c0a:	48 98                	cltq   
  801c0c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c13:	00 
  801c14:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c1a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c20:	48 89 d1             	mov    %rdx,%rcx
  801c23:	48 89 c2             	mov    %rax,%rdx
  801c26:	be 01 00 00 00       	mov    $0x1,%esi
  801c2b:	bf 08 00 00 00       	mov    $0x8,%edi
  801c30:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801c37:	00 00 00 
  801c3a:	ff d0                	callq  *%rax
  801c3c:	c9                   	leaveq 
  801c3d:	c3                   	retq   

0000000000801c3e <sys_env_set_trapframe>:
  801c3e:	55                   	push   %rbp
  801c3f:	48 89 e5             	mov    %rsp,%rbp
  801c42:	48 83 ec 20          	sub    $0x20,%rsp
  801c46:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c49:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c4d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c54:	48 98                	cltq   
  801c56:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c5d:	00 
  801c5e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c64:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c6a:	48 89 d1             	mov    %rdx,%rcx
  801c6d:	48 89 c2             	mov    %rax,%rdx
  801c70:	be 01 00 00 00       	mov    $0x1,%esi
  801c75:	bf 09 00 00 00       	mov    $0x9,%edi
  801c7a:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801c81:	00 00 00 
  801c84:	ff d0                	callq  *%rax
  801c86:	c9                   	leaveq 
  801c87:	c3                   	retq   

0000000000801c88 <sys_env_set_pgfault_upcall>:
  801c88:	55                   	push   %rbp
  801c89:	48 89 e5             	mov    %rsp,%rbp
  801c8c:	48 83 ec 20          	sub    $0x20,%rsp
  801c90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c93:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c97:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c9b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c9e:	48 98                	cltq   
  801ca0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ca7:	00 
  801ca8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cae:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cb4:	48 89 d1             	mov    %rdx,%rcx
  801cb7:	48 89 c2             	mov    %rax,%rdx
  801cba:	be 01 00 00 00       	mov    $0x1,%esi
  801cbf:	bf 0a 00 00 00       	mov    $0xa,%edi
  801cc4:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801ccb:	00 00 00 
  801cce:	ff d0                	callq  *%rax
  801cd0:	c9                   	leaveq 
  801cd1:	c3                   	retq   

0000000000801cd2 <sys_ipc_try_send>:
  801cd2:	55                   	push   %rbp
  801cd3:	48 89 e5             	mov    %rsp,%rbp
  801cd6:	48 83 ec 20          	sub    $0x20,%rsp
  801cda:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cdd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ce1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801ce5:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801ce8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801ceb:	48 63 f0             	movslq %eax,%rsi
  801cee:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801cf2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cf5:	48 98                	cltq   
  801cf7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801cfb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d02:	00 
  801d03:	49 89 f1             	mov    %rsi,%r9
  801d06:	49 89 c8             	mov    %rcx,%r8
  801d09:	48 89 d1             	mov    %rdx,%rcx
  801d0c:	48 89 c2             	mov    %rax,%rdx
  801d0f:	be 00 00 00 00       	mov    $0x0,%esi
  801d14:	bf 0c 00 00 00       	mov    $0xc,%edi
  801d19:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801d20:	00 00 00 
  801d23:	ff d0                	callq  *%rax
  801d25:	c9                   	leaveq 
  801d26:	c3                   	retq   

0000000000801d27 <sys_ipc_recv>:
  801d27:	55                   	push   %rbp
  801d28:	48 89 e5             	mov    %rsp,%rbp
  801d2b:	48 83 ec 10          	sub    $0x10,%rsp
  801d2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d37:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d3e:	00 
  801d3f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d45:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d4b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d50:	48 89 c2             	mov    %rax,%rdx
  801d53:	be 01 00 00 00       	mov    $0x1,%esi
  801d58:	bf 0d 00 00 00       	mov    $0xd,%edi
  801d5d:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801d64:	00 00 00 
  801d67:	ff d0                	callq  *%rax
  801d69:	c9                   	leaveq 
  801d6a:	c3                   	retq   

0000000000801d6b <sys_time_msec>:
  801d6b:	55                   	push   %rbp
  801d6c:	48 89 e5             	mov    %rsp,%rbp
  801d6f:	48 83 ec 10          	sub    $0x10,%rsp
  801d73:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d7a:	00 
  801d7b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d81:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d87:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d8c:	ba 00 00 00 00       	mov    $0x0,%edx
  801d91:	be 00 00 00 00       	mov    $0x0,%esi
  801d96:	bf 0e 00 00 00       	mov    $0xe,%edi
  801d9b:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801da2:	00 00 00 
  801da5:	ff d0                	callq  *%rax
  801da7:	c9                   	leaveq 
  801da8:	c3                   	retq   

0000000000801da9 <sys_net_transmit>:
  801da9:	55                   	push   %rbp
  801daa:	48 89 e5             	mov    %rsp,%rbp
  801dad:	48 83 ec 20          	sub    $0x20,%rsp
  801db1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801db5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801db8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801dbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dbf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dc6:	00 
  801dc7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dcd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dd3:	48 89 d1             	mov    %rdx,%rcx
  801dd6:	48 89 c2             	mov    %rax,%rdx
  801dd9:	be 00 00 00 00       	mov    $0x0,%esi
  801dde:	bf 0f 00 00 00       	mov    $0xf,%edi
  801de3:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801dea:	00 00 00 
  801ded:	ff d0                	callq  *%rax
  801def:	c9                   	leaveq 
  801df0:	c3                   	retq   

0000000000801df1 <sys_net_receive>:
  801df1:	55                   	push   %rbp
  801df2:	48 89 e5             	mov    %rsp,%rbp
  801df5:	48 83 ec 20          	sub    $0x20,%rsp
  801df9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801dfd:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801e00:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801e03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e07:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e0e:	00 
  801e0f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e15:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e1b:	48 89 d1             	mov    %rdx,%rcx
  801e1e:	48 89 c2             	mov    %rax,%rdx
  801e21:	be 00 00 00 00       	mov    $0x0,%esi
  801e26:	bf 10 00 00 00       	mov    $0x10,%edi
  801e2b:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801e32:	00 00 00 
  801e35:	ff d0                	callq  *%rax
  801e37:	c9                   	leaveq 
  801e38:	c3                   	retq   

0000000000801e39 <sys_ept_map>:
  801e39:	55                   	push   %rbp
  801e3a:	48 89 e5             	mov    %rsp,%rbp
  801e3d:	48 83 ec 30          	sub    $0x30,%rsp
  801e41:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e44:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e48:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e4b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801e4f:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801e53:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801e56:	48 63 c8             	movslq %eax,%rcx
  801e59:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801e5d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e60:	48 63 f0             	movslq %eax,%rsi
  801e63:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e6a:	48 98                	cltq   
  801e6c:	48 89 0c 24          	mov    %rcx,(%rsp)
  801e70:	49 89 f9             	mov    %rdi,%r9
  801e73:	49 89 f0             	mov    %rsi,%r8
  801e76:	48 89 d1             	mov    %rdx,%rcx
  801e79:	48 89 c2             	mov    %rax,%rdx
  801e7c:	be 00 00 00 00       	mov    $0x0,%esi
  801e81:	bf 11 00 00 00       	mov    $0x11,%edi
  801e86:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801e8d:	00 00 00 
  801e90:	ff d0                	callq  *%rax
  801e92:	c9                   	leaveq 
  801e93:	c3                   	retq   

0000000000801e94 <sys_env_mkguest>:
  801e94:	55                   	push   %rbp
  801e95:	48 89 e5             	mov    %rsp,%rbp
  801e98:	48 83 ec 20          	sub    $0x20,%rsp
  801e9c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801ea0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ea4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ea8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801eac:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801eb3:	00 
  801eb4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801eba:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ec0:	48 89 d1             	mov    %rdx,%rcx
  801ec3:	48 89 c2             	mov    %rax,%rdx
  801ec6:	be 00 00 00 00       	mov    $0x0,%esi
  801ecb:	bf 12 00 00 00       	mov    $0x12,%edi
  801ed0:	48 b8 28 19 80 00 00 	movabs $0x801928,%rax
  801ed7:	00 00 00 
  801eda:	ff d0                	callq  *%rax
  801edc:	c9                   	leaveq 
  801edd:	c3                   	retq   

0000000000801ede <pgfault>:
  801ede:	55                   	push   %rbp
  801edf:	48 89 e5             	mov    %rsp,%rbp
  801ee2:	48 83 ec 30          	sub    $0x30,%rsp
  801ee6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801eea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801eee:	48 8b 00             	mov    (%rax),%rax
  801ef1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801ef5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ef9:	48 8b 40 08          	mov    0x8(%rax),%rax
  801efd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801f00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f03:	83 e0 02             	and    $0x2,%eax
  801f06:	85 c0                	test   %eax,%eax
  801f08:	75 40                	jne    801f4a <pgfault+0x6c>
  801f0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f0e:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801f15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f19:	49 89 d0             	mov    %rdx,%r8
  801f1c:	48 89 c1             	mov    %rax,%rcx
  801f1f:	48 ba b8 50 80 00 00 	movabs $0x8050b8,%rdx
  801f26:	00 00 00 
  801f29:	be 1f 00 00 00       	mov    $0x1f,%esi
  801f2e:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  801f35:	00 00 00 
  801f38:	b8 00 00 00 00       	mov    $0x0,%eax
  801f3d:	49 b9 e1 03 80 00 00 	movabs $0x8003e1,%r9
  801f44:	00 00 00 
  801f47:	41 ff d1             	callq  *%r9
  801f4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f4e:	48 c1 e8 0c          	shr    $0xc,%rax
  801f52:	48 89 c2             	mov    %rax,%rdx
  801f55:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f5c:	01 00 00 
  801f5f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f63:	25 07 08 00 00       	and    $0x807,%eax
  801f68:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  801f6e:	74 4e                	je     801fbe <pgfault+0xe0>
  801f70:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f74:	48 c1 e8 0c          	shr    $0xc,%rax
  801f78:	48 89 c2             	mov    %rax,%rdx
  801f7b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f82:	01 00 00 
  801f85:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801f89:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f8d:	49 89 d0             	mov    %rdx,%r8
  801f90:	48 89 c1             	mov    %rax,%rcx
  801f93:	48 ba e0 50 80 00 00 	movabs $0x8050e0,%rdx
  801f9a:	00 00 00 
  801f9d:	be 22 00 00 00       	mov    $0x22,%esi
  801fa2:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  801fa9:	00 00 00 
  801fac:	b8 00 00 00 00       	mov    $0x0,%eax
  801fb1:	49 b9 e1 03 80 00 00 	movabs $0x8003e1,%r9
  801fb8:	00 00 00 
  801fbb:	41 ff d1             	callq  *%r9
  801fbe:	ba 07 00 00 00       	mov    $0x7,%edx
  801fc3:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801fc8:	bf 00 00 00 00       	mov    $0x0,%edi
  801fcd:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  801fd4:	00 00 00 
  801fd7:	ff d0                	callq  *%rax
  801fd9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801fdc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801fe0:	79 30                	jns    802012 <pgfault+0x134>
  801fe2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801fe5:	89 c1                	mov    %eax,%ecx
  801fe7:	48 ba 0b 51 80 00 00 	movabs $0x80510b,%rdx
  801fee:	00 00 00 
  801ff1:	be 30 00 00 00       	mov    $0x30,%esi
  801ff6:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  801ffd:	00 00 00 
  802000:	b8 00 00 00 00       	mov    $0x0,%eax
  802005:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  80200c:	00 00 00 
  80200f:	41 ff d0             	callq  *%r8
  802012:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802016:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80201a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80201e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802024:	ba 00 10 00 00       	mov    $0x1000,%edx
  802029:	48 89 c6             	mov    %rax,%rsi
  80202c:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  802031:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  802038:	00 00 00 
  80203b:	ff d0                	callq  *%rax
  80203d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802041:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802045:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802049:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  80204f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  802055:	48 89 c1             	mov    %rax,%rcx
  802058:	ba 00 00 00 00       	mov    $0x0,%edx
  80205d:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802062:	bf 00 00 00 00       	mov    $0x0,%edi
  802067:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  80206e:	00 00 00 
  802071:	ff d0                	callq  *%rax
  802073:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802076:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80207a:	79 30                	jns    8020ac <pgfault+0x1ce>
  80207c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80207f:	89 c1                	mov    %eax,%ecx
  802081:	48 ba 1e 51 80 00 00 	movabs $0x80511e,%rdx
  802088:	00 00 00 
  80208b:	be 35 00 00 00       	mov    $0x35,%esi
  802090:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  802097:	00 00 00 
  80209a:	b8 00 00 00 00       	mov    $0x0,%eax
  80209f:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8020a6:	00 00 00 
  8020a9:	41 ff d0             	callq  *%r8
  8020ac:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8020b1:	bf 00 00 00 00       	mov    $0x0,%edi
  8020b6:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  8020bd:	00 00 00 
  8020c0:	ff d0                	callq  *%rax
  8020c2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8020c5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8020c9:	79 30                	jns    8020fb <pgfault+0x21d>
  8020cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020ce:	89 c1                	mov    %eax,%ecx
  8020d0:	48 ba 2f 51 80 00 00 	movabs $0x80512f,%rdx
  8020d7:	00 00 00 
  8020da:	be 39 00 00 00       	mov    $0x39,%esi
  8020df:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  8020e6:	00 00 00 
  8020e9:	b8 00 00 00 00       	mov    $0x0,%eax
  8020ee:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8020f5:	00 00 00 
  8020f8:	41 ff d0             	callq  *%r8
  8020fb:	c9                   	leaveq 
  8020fc:	c3                   	retq   

00000000008020fd <duppage>:
  8020fd:	55                   	push   %rbp
  8020fe:	48 89 e5             	mov    %rsp,%rbp
  802101:	48 83 ec 30          	sub    $0x30,%rsp
  802105:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802108:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80210b:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80210e:	c1 e0 0c             	shl    $0xc,%eax
  802111:	89 c0                	mov    %eax,%eax
  802113:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802117:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80211e:	01 00 00 
  802121:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802124:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802128:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80212c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802130:	25 02 08 00 00       	and    $0x802,%eax
  802135:	48 85 c0             	test   %rax,%rax
  802138:	74 0e                	je     802148 <duppage+0x4b>
  80213a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80213e:	25 00 04 00 00       	and    $0x400,%eax
  802143:	48 85 c0             	test   %rax,%rax
  802146:	74 70                	je     8021b8 <duppage+0xbb>
  802148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80214c:	25 07 0e 00 00       	and    $0xe07,%eax
  802151:	89 c6                	mov    %eax,%esi
  802153:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802157:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80215a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80215e:	41 89 f0             	mov    %esi,%r8d
  802161:	48 89 c6             	mov    %rax,%rsi
  802164:	bf 00 00 00 00       	mov    $0x0,%edi
  802169:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  802170:	00 00 00 
  802173:	ff d0                	callq  *%rax
  802175:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802178:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80217c:	79 30                	jns    8021ae <duppage+0xb1>
  80217e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802181:	89 c1                	mov    %eax,%ecx
  802183:	48 ba 1e 51 80 00 00 	movabs $0x80511e,%rdx
  80218a:	00 00 00 
  80218d:	be 63 00 00 00       	mov    $0x63,%esi
  802192:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  802199:	00 00 00 
  80219c:	b8 00 00 00 00       	mov    $0x0,%eax
  8021a1:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8021a8:	00 00 00 
  8021ab:	41 ff d0             	callq  *%r8
  8021ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8021b3:	e9 c4 00 00 00       	jmpq   80227c <duppage+0x17f>
  8021b8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8021bc:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8021bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8021c3:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8021c9:	48 89 c6             	mov    %rax,%rsi
  8021cc:	bf 00 00 00 00       	mov    $0x0,%edi
  8021d1:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  8021d8:	00 00 00 
  8021db:	ff d0                	callq  *%rax
  8021dd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8021e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8021e4:	79 30                	jns    802216 <duppage+0x119>
  8021e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8021e9:	89 c1                	mov    %eax,%ecx
  8021eb:	48 ba 1e 51 80 00 00 	movabs $0x80511e,%rdx
  8021f2:	00 00 00 
  8021f5:	be 7e 00 00 00       	mov    $0x7e,%esi
  8021fa:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  802201:	00 00 00 
  802204:	b8 00 00 00 00       	mov    $0x0,%eax
  802209:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  802210:	00 00 00 
  802213:	41 ff d0             	callq  *%r8
  802216:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80221a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80221e:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802224:	48 89 d1             	mov    %rdx,%rcx
  802227:	ba 00 00 00 00       	mov    $0x0,%edx
  80222c:	48 89 c6             	mov    %rax,%rsi
  80222f:	bf 00 00 00 00       	mov    $0x0,%edi
  802234:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  80223b:	00 00 00 
  80223e:	ff d0                	callq  *%rax
  802240:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802243:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802247:	79 30                	jns    802279 <duppage+0x17c>
  802249:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80224c:	89 c1                	mov    %eax,%ecx
  80224e:	48 ba 1e 51 80 00 00 	movabs $0x80511e,%rdx
  802255:	00 00 00 
  802258:	be 80 00 00 00       	mov    $0x80,%esi
  80225d:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  802264:	00 00 00 
  802267:	b8 00 00 00 00       	mov    $0x0,%eax
  80226c:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  802273:	00 00 00 
  802276:	41 ff d0             	callq  *%r8
  802279:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80227c:	c9                   	leaveq 
  80227d:	c3                   	retq   

000000000080227e <fork>:
  80227e:	55                   	push   %rbp
  80227f:	48 89 e5             	mov    %rsp,%rbp
  802282:	48 83 ec 20          	sub    $0x20,%rsp
  802286:	48 bf de 1e 80 00 00 	movabs $0x801ede,%rdi
  80228d:	00 00 00 
  802290:	48 b8 3b 46 80 00 00 	movabs $0x80463b,%rax
  802297:	00 00 00 
  80229a:	ff d0                	callq  *%rax
  80229c:	b8 07 00 00 00       	mov    $0x7,%eax
  8022a1:	cd 30                	int    $0x30
  8022a3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8022a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022a9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022ac:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022b0:	79 08                	jns    8022ba <fork+0x3c>
  8022b2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022b5:	e9 09 02 00 00       	jmpq   8024c3 <fork+0x245>
  8022ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022be:	75 3e                	jne    8022fe <fork+0x80>
  8022c0:	48 b8 82 1a 80 00 00 	movabs $0x801a82,%rax
  8022c7:	00 00 00 
  8022ca:	ff d0                	callq  *%rax
  8022cc:	25 ff 03 00 00       	and    $0x3ff,%eax
  8022d1:	48 98                	cltq   
  8022d3:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8022da:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8022e1:	00 00 00 
  8022e4:	48 01 c2             	add    %rax,%rdx
  8022e7:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8022ee:	00 00 00 
  8022f1:	48 89 10             	mov    %rdx,(%rax)
  8022f4:	b8 00 00 00 00       	mov    $0x0,%eax
  8022f9:	e9 c5 01 00 00       	jmpq   8024c3 <fork+0x245>
  8022fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802305:	e9 a4 00 00 00       	jmpq   8023ae <fork+0x130>
  80230a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80230d:	c1 f8 12             	sar    $0x12,%eax
  802310:	89 c2                	mov    %eax,%edx
  802312:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  802319:	01 00 00 
  80231c:	48 63 d2             	movslq %edx,%rdx
  80231f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802323:	83 e0 01             	and    $0x1,%eax
  802326:	48 85 c0             	test   %rax,%rax
  802329:	74 21                	je     80234c <fork+0xce>
  80232b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80232e:	c1 f8 09             	sar    $0x9,%eax
  802331:	89 c2                	mov    %eax,%edx
  802333:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80233a:	01 00 00 
  80233d:	48 63 d2             	movslq %edx,%rdx
  802340:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802344:	83 e0 01             	and    $0x1,%eax
  802347:	48 85 c0             	test   %rax,%rax
  80234a:	75 09                	jne    802355 <fork+0xd7>
  80234c:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  802353:	eb 59                	jmp    8023ae <fork+0x130>
  802355:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802358:	05 00 02 00 00       	add    $0x200,%eax
  80235d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802360:	eb 44                	jmp    8023a6 <fork+0x128>
  802362:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802369:	01 00 00 
  80236c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80236f:	48 63 d2             	movslq %edx,%rdx
  802372:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802376:	83 e0 05             	and    $0x5,%eax
  802379:	48 83 f8 05          	cmp    $0x5,%rax
  80237d:	74 02                	je     802381 <fork+0x103>
  80237f:	eb 21                	jmp    8023a2 <fork+0x124>
  802381:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  802388:	75 02                	jne    80238c <fork+0x10e>
  80238a:	eb 16                	jmp    8023a2 <fork+0x124>
  80238c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80238f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802392:	89 d6                	mov    %edx,%esi
  802394:	89 c7                	mov    %eax,%edi
  802396:	48 b8 fd 20 80 00 00 	movabs $0x8020fd,%rax
  80239d:	00 00 00 
  8023a0:	ff d0                	callq  *%rax
  8023a2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8023a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023a9:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8023ac:	7c b4                	jl     802362 <fork+0xe4>
  8023ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023b1:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  8023b6:	0f 86 4e ff ff ff    	jbe    80230a <fork+0x8c>
  8023bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023bf:	ba 07 00 00 00       	mov    $0x7,%edx
  8023c4:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8023c9:	89 c7                	mov    %eax,%edi
  8023cb:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  8023d2:	00 00 00 
  8023d5:	ff d0                	callq  *%rax
  8023d7:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8023da:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8023de:	79 30                	jns    802410 <fork+0x192>
  8023e0:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8023e3:	89 c1                	mov    %eax,%ecx
  8023e5:	48 ba 48 51 80 00 00 	movabs $0x805148,%rdx
  8023ec:	00 00 00 
  8023ef:	be bc 00 00 00       	mov    $0xbc,%esi
  8023f4:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  8023fb:	00 00 00 
  8023fe:	b8 00 00 00 00       	mov    $0x0,%eax
  802403:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  80240a:	00 00 00 
  80240d:	41 ff d0             	callq  *%r8
  802410:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802417:	00 00 00 
  80241a:	48 8b 00             	mov    (%rax),%rax
  80241d:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  802424:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802427:	48 89 d6             	mov    %rdx,%rsi
  80242a:	89 c7                	mov    %eax,%edi
  80242c:	48 b8 88 1c 80 00 00 	movabs $0x801c88,%rax
  802433:	00 00 00 
  802436:	ff d0                	callq  *%rax
  802438:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80243b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80243f:	79 30                	jns    802471 <fork+0x1f3>
  802441:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802444:	89 c1                	mov    %eax,%ecx
  802446:	48 ba 68 51 80 00 00 	movabs $0x805168,%rdx
  80244d:	00 00 00 
  802450:	be c0 00 00 00       	mov    $0xc0,%esi
  802455:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  80245c:	00 00 00 
  80245f:	b8 00 00 00 00       	mov    $0x0,%eax
  802464:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  80246b:	00 00 00 
  80246e:	41 ff d0             	callq  *%r8
  802471:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802474:	be 02 00 00 00       	mov    $0x2,%esi
  802479:	89 c7                	mov    %eax,%edi
  80247b:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  802482:	00 00 00 
  802485:	ff d0                	callq  *%rax
  802487:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80248a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80248e:	79 30                	jns    8024c0 <fork+0x242>
  802490:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802493:	89 c1                	mov    %eax,%ecx
  802495:	48 ba 87 51 80 00 00 	movabs $0x805187,%rdx
  80249c:	00 00 00 
  80249f:	be c5 00 00 00       	mov    $0xc5,%esi
  8024a4:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  8024ab:	00 00 00 
  8024ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8024b3:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8024ba:	00 00 00 
  8024bd:	41 ff d0             	callq  *%r8
  8024c0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8024c3:	c9                   	leaveq 
  8024c4:	c3                   	retq   

00000000008024c5 <sfork>:
  8024c5:	55                   	push   %rbp
  8024c6:	48 89 e5             	mov    %rsp,%rbp
  8024c9:	48 ba 9e 51 80 00 00 	movabs $0x80519e,%rdx
  8024d0:	00 00 00 
  8024d3:	be d2 00 00 00       	mov    $0xd2,%esi
  8024d8:	48 bf d1 50 80 00 00 	movabs $0x8050d1,%rdi
  8024df:	00 00 00 
  8024e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8024e7:	48 b9 e1 03 80 00 00 	movabs $0x8003e1,%rcx
  8024ee:	00 00 00 
  8024f1:	ff d1                	callq  *%rcx

00000000008024f3 <fd2num>:
  8024f3:	55                   	push   %rbp
  8024f4:	48 89 e5             	mov    %rsp,%rbp
  8024f7:	48 83 ec 08          	sub    $0x8,%rsp
  8024fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024ff:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802503:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  80250a:	ff ff ff 
  80250d:	48 01 d0             	add    %rdx,%rax
  802510:	48 c1 e8 0c          	shr    $0xc,%rax
  802514:	c9                   	leaveq 
  802515:	c3                   	retq   

0000000000802516 <fd2data>:
  802516:	55                   	push   %rbp
  802517:	48 89 e5             	mov    %rsp,%rbp
  80251a:	48 83 ec 08          	sub    $0x8,%rsp
  80251e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802522:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802526:	48 89 c7             	mov    %rax,%rdi
  802529:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  802530:	00 00 00 
  802533:	ff d0                	callq  *%rax
  802535:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  80253b:	48 c1 e0 0c          	shl    $0xc,%rax
  80253f:	c9                   	leaveq 
  802540:	c3                   	retq   

0000000000802541 <fd_alloc>:
  802541:	55                   	push   %rbp
  802542:	48 89 e5             	mov    %rsp,%rbp
  802545:	48 83 ec 18          	sub    $0x18,%rsp
  802549:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80254d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802554:	eb 6b                	jmp    8025c1 <fd_alloc+0x80>
  802556:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802559:	48 98                	cltq   
  80255b:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802561:	48 c1 e0 0c          	shl    $0xc,%rax
  802565:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802569:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80256d:	48 c1 e8 15          	shr    $0x15,%rax
  802571:	48 89 c2             	mov    %rax,%rdx
  802574:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80257b:	01 00 00 
  80257e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802582:	83 e0 01             	and    $0x1,%eax
  802585:	48 85 c0             	test   %rax,%rax
  802588:	74 21                	je     8025ab <fd_alloc+0x6a>
  80258a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80258e:	48 c1 e8 0c          	shr    $0xc,%rax
  802592:	48 89 c2             	mov    %rax,%rdx
  802595:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80259c:	01 00 00 
  80259f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8025a3:	83 e0 01             	and    $0x1,%eax
  8025a6:	48 85 c0             	test   %rax,%rax
  8025a9:	75 12                	jne    8025bd <fd_alloc+0x7c>
  8025ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025af:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8025b3:	48 89 10             	mov    %rdx,(%rax)
  8025b6:	b8 00 00 00 00       	mov    $0x0,%eax
  8025bb:	eb 1a                	jmp    8025d7 <fd_alloc+0x96>
  8025bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8025c1:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8025c5:	7e 8f                	jle    802556 <fd_alloc+0x15>
  8025c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025cb:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8025d2:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8025d7:	c9                   	leaveq 
  8025d8:	c3                   	retq   

00000000008025d9 <fd_lookup>:
  8025d9:	55                   	push   %rbp
  8025da:	48 89 e5             	mov    %rsp,%rbp
  8025dd:	48 83 ec 20          	sub    $0x20,%rsp
  8025e1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8025e4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8025ec:	78 06                	js     8025f4 <fd_lookup+0x1b>
  8025ee:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8025f2:	7e 07                	jle    8025fb <fd_lookup+0x22>
  8025f4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8025f9:	eb 6c                	jmp    802667 <fd_lookup+0x8e>
  8025fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8025fe:	48 98                	cltq   
  802600:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802606:	48 c1 e0 0c          	shl    $0xc,%rax
  80260a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80260e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802612:	48 c1 e8 15          	shr    $0x15,%rax
  802616:	48 89 c2             	mov    %rax,%rdx
  802619:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802620:	01 00 00 
  802623:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802627:	83 e0 01             	and    $0x1,%eax
  80262a:	48 85 c0             	test   %rax,%rax
  80262d:	74 21                	je     802650 <fd_lookup+0x77>
  80262f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802633:	48 c1 e8 0c          	shr    $0xc,%rax
  802637:	48 89 c2             	mov    %rax,%rdx
  80263a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802641:	01 00 00 
  802644:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802648:	83 e0 01             	and    $0x1,%eax
  80264b:	48 85 c0             	test   %rax,%rax
  80264e:	75 07                	jne    802657 <fd_lookup+0x7e>
  802650:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802655:	eb 10                	jmp    802667 <fd_lookup+0x8e>
  802657:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80265b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80265f:	48 89 10             	mov    %rdx,(%rax)
  802662:	b8 00 00 00 00       	mov    $0x0,%eax
  802667:	c9                   	leaveq 
  802668:	c3                   	retq   

0000000000802669 <fd_close>:
  802669:	55                   	push   %rbp
  80266a:	48 89 e5             	mov    %rsp,%rbp
  80266d:	48 83 ec 30          	sub    $0x30,%rsp
  802671:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802675:	89 f0                	mov    %esi,%eax
  802677:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80267a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80267e:	48 89 c7             	mov    %rax,%rdi
  802681:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  802688:	00 00 00 
  80268b:	ff d0                	callq  *%rax
  80268d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802691:	48 89 d6             	mov    %rdx,%rsi
  802694:	89 c7                	mov    %eax,%edi
  802696:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  80269d:	00 00 00 
  8026a0:	ff d0                	callq  *%rax
  8026a2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026a9:	78 0a                	js     8026b5 <fd_close+0x4c>
  8026ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026af:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8026b3:	74 12                	je     8026c7 <fd_close+0x5e>
  8026b5:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8026b9:	74 05                	je     8026c0 <fd_close+0x57>
  8026bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026be:	eb 05                	jmp    8026c5 <fd_close+0x5c>
  8026c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8026c5:	eb 69                	jmp    802730 <fd_close+0xc7>
  8026c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8026cb:	8b 00                	mov    (%rax),%eax
  8026cd:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8026d1:	48 89 d6             	mov    %rdx,%rsi
  8026d4:	89 c7                	mov    %eax,%edi
  8026d6:	48 b8 32 27 80 00 00 	movabs $0x802732,%rax
  8026dd:	00 00 00 
  8026e0:	ff d0                	callq  *%rax
  8026e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026e9:	78 2a                	js     802715 <fd_close+0xac>
  8026eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026ef:	48 8b 40 20          	mov    0x20(%rax),%rax
  8026f3:	48 85 c0             	test   %rax,%rax
  8026f6:	74 16                	je     80270e <fd_close+0xa5>
  8026f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026fc:	48 8b 40 20          	mov    0x20(%rax),%rax
  802700:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802704:	48 89 d7             	mov    %rdx,%rdi
  802707:	ff d0                	callq  *%rax
  802709:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80270c:	eb 07                	jmp    802715 <fd_close+0xac>
  80270e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802715:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802719:	48 89 c6             	mov    %rax,%rsi
  80271c:	bf 00 00 00 00       	mov    $0x0,%edi
  802721:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  802728:	00 00 00 
  80272b:	ff d0                	callq  *%rax
  80272d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802730:	c9                   	leaveq 
  802731:	c3                   	retq   

0000000000802732 <dev_lookup>:
  802732:	55                   	push   %rbp
  802733:	48 89 e5             	mov    %rsp,%rbp
  802736:	48 83 ec 20          	sub    $0x20,%rsp
  80273a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80273d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802741:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802748:	eb 41                	jmp    80278b <dev_lookup+0x59>
  80274a:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802751:	00 00 00 
  802754:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802757:	48 63 d2             	movslq %edx,%rdx
  80275a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80275e:	8b 00                	mov    (%rax),%eax
  802760:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802763:	75 22                	jne    802787 <dev_lookup+0x55>
  802765:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80276c:	00 00 00 
  80276f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802772:	48 63 d2             	movslq %edx,%rdx
  802775:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802779:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80277d:	48 89 10             	mov    %rdx,(%rax)
  802780:	b8 00 00 00 00       	mov    $0x0,%eax
  802785:	eb 60                	jmp    8027e7 <dev_lookup+0xb5>
  802787:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80278b:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802792:	00 00 00 
  802795:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802798:	48 63 d2             	movslq %edx,%rdx
  80279b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80279f:	48 85 c0             	test   %rax,%rax
  8027a2:	75 a6                	jne    80274a <dev_lookup+0x18>
  8027a4:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8027ab:	00 00 00 
  8027ae:	48 8b 00             	mov    (%rax),%rax
  8027b1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8027b7:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8027ba:	89 c6                	mov    %eax,%esi
  8027bc:	48 bf b8 51 80 00 00 	movabs $0x8051b8,%rdi
  8027c3:	00 00 00 
  8027c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8027cb:	48 b9 1a 06 80 00 00 	movabs $0x80061a,%rcx
  8027d2:	00 00 00 
  8027d5:	ff d1                	callq  *%rcx
  8027d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8027db:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8027e2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8027e7:	c9                   	leaveq 
  8027e8:	c3                   	retq   

00000000008027e9 <close>:
  8027e9:	55                   	push   %rbp
  8027ea:	48 89 e5             	mov    %rsp,%rbp
  8027ed:	48 83 ec 20          	sub    $0x20,%rsp
  8027f1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8027f4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8027f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8027fb:	48 89 d6             	mov    %rdx,%rsi
  8027fe:	89 c7                	mov    %eax,%edi
  802800:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802807:	00 00 00 
  80280a:	ff d0                	callq  *%rax
  80280c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80280f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802813:	79 05                	jns    80281a <close+0x31>
  802815:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802818:	eb 18                	jmp    802832 <close+0x49>
  80281a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80281e:	be 01 00 00 00       	mov    $0x1,%esi
  802823:	48 89 c7             	mov    %rax,%rdi
  802826:	48 b8 69 26 80 00 00 	movabs $0x802669,%rax
  80282d:	00 00 00 
  802830:	ff d0                	callq  *%rax
  802832:	c9                   	leaveq 
  802833:	c3                   	retq   

0000000000802834 <close_all>:
  802834:	55                   	push   %rbp
  802835:	48 89 e5             	mov    %rsp,%rbp
  802838:	48 83 ec 10          	sub    $0x10,%rsp
  80283c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802843:	eb 15                	jmp    80285a <close_all+0x26>
  802845:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802848:	89 c7                	mov    %eax,%edi
  80284a:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  802851:	00 00 00 
  802854:	ff d0                	callq  *%rax
  802856:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80285a:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80285e:	7e e5                	jle    802845 <close_all+0x11>
  802860:	c9                   	leaveq 
  802861:	c3                   	retq   

0000000000802862 <dup>:
  802862:	55                   	push   %rbp
  802863:	48 89 e5             	mov    %rsp,%rbp
  802866:	48 83 ec 40          	sub    $0x40,%rsp
  80286a:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80286d:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802870:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802874:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802877:	48 89 d6             	mov    %rdx,%rsi
  80287a:	89 c7                	mov    %eax,%edi
  80287c:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802883:	00 00 00 
  802886:	ff d0                	callq  *%rax
  802888:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80288b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80288f:	79 08                	jns    802899 <dup+0x37>
  802891:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802894:	e9 70 01 00 00       	jmpq   802a09 <dup+0x1a7>
  802899:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80289c:	89 c7                	mov    %eax,%edi
  80289e:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  8028a5:	00 00 00 
  8028a8:	ff d0                	callq  *%rax
  8028aa:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8028ad:	48 98                	cltq   
  8028af:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8028b5:	48 c1 e0 0c          	shl    $0xc,%rax
  8028b9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8028bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028c1:	48 89 c7             	mov    %rax,%rdi
  8028c4:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  8028cb:	00 00 00 
  8028ce:	ff d0                	callq  *%rax
  8028d0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8028d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028d8:	48 89 c7             	mov    %rax,%rdi
  8028db:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  8028e2:	00 00 00 
  8028e5:	ff d0                	callq  *%rax
  8028e7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8028eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028ef:	48 c1 e8 15          	shr    $0x15,%rax
  8028f3:	48 89 c2             	mov    %rax,%rdx
  8028f6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8028fd:	01 00 00 
  802900:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802904:	83 e0 01             	and    $0x1,%eax
  802907:	48 85 c0             	test   %rax,%rax
  80290a:	74 73                	je     80297f <dup+0x11d>
  80290c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802910:	48 c1 e8 0c          	shr    $0xc,%rax
  802914:	48 89 c2             	mov    %rax,%rdx
  802917:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80291e:	01 00 00 
  802921:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802925:	83 e0 01             	and    $0x1,%eax
  802928:	48 85 c0             	test   %rax,%rax
  80292b:	74 52                	je     80297f <dup+0x11d>
  80292d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802931:	48 c1 e8 0c          	shr    $0xc,%rax
  802935:	48 89 c2             	mov    %rax,%rdx
  802938:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80293f:	01 00 00 
  802942:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802946:	25 07 0e 00 00       	and    $0xe07,%eax
  80294b:	89 c1                	mov    %eax,%ecx
  80294d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802951:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802955:	41 89 c8             	mov    %ecx,%r8d
  802958:	48 89 d1             	mov    %rdx,%rcx
  80295b:	ba 00 00 00 00       	mov    $0x0,%edx
  802960:	48 89 c6             	mov    %rax,%rsi
  802963:	bf 00 00 00 00       	mov    $0x0,%edi
  802968:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  80296f:	00 00 00 
  802972:	ff d0                	callq  *%rax
  802974:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802977:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80297b:	79 02                	jns    80297f <dup+0x11d>
  80297d:	eb 57                	jmp    8029d6 <dup+0x174>
  80297f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802983:	48 c1 e8 0c          	shr    $0xc,%rax
  802987:	48 89 c2             	mov    %rax,%rdx
  80298a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802991:	01 00 00 
  802994:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802998:	25 07 0e 00 00       	and    $0xe07,%eax
  80299d:	89 c1                	mov    %eax,%ecx
  80299f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029a3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8029a7:	41 89 c8             	mov    %ecx,%r8d
  8029aa:	48 89 d1             	mov    %rdx,%rcx
  8029ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8029b2:	48 89 c6             	mov    %rax,%rsi
  8029b5:	bf 00 00 00 00       	mov    $0x0,%edi
  8029ba:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  8029c1:	00 00 00 
  8029c4:	ff d0                	callq  *%rax
  8029c6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029cd:	79 02                	jns    8029d1 <dup+0x16f>
  8029cf:	eb 05                	jmp    8029d6 <dup+0x174>
  8029d1:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8029d4:	eb 33                	jmp    802a09 <dup+0x1a7>
  8029d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029da:	48 89 c6             	mov    %rax,%rsi
  8029dd:	bf 00 00 00 00       	mov    $0x0,%edi
  8029e2:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  8029e9:	00 00 00 
  8029ec:	ff d0                	callq  *%rax
  8029ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029f2:	48 89 c6             	mov    %rax,%rsi
  8029f5:	bf 00 00 00 00       	mov    $0x0,%edi
  8029fa:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  802a01:	00 00 00 
  802a04:	ff d0                	callq  *%rax
  802a06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a09:	c9                   	leaveq 
  802a0a:	c3                   	retq   

0000000000802a0b <read>:
  802a0b:	55                   	push   %rbp
  802a0c:	48 89 e5             	mov    %rsp,%rbp
  802a0f:	48 83 ec 40          	sub    $0x40,%rsp
  802a13:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802a16:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802a1a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802a1e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802a22:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a25:	48 89 d6             	mov    %rdx,%rsi
  802a28:	89 c7                	mov    %eax,%edi
  802a2a:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802a31:	00 00 00 
  802a34:	ff d0                	callq  *%rax
  802a36:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a39:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a3d:	78 24                	js     802a63 <read+0x58>
  802a3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a43:	8b 00                	mov    (%rax),%eax
  802a45:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a49:	48 89 d6             	mov    %rdx,%rsi
  802a4c:	89 c7                	mov    %eax,%edi
  802a4e:	48 b8 32 27 80 00 00 	movabs $0x802732,%rax
  802a55:	00 00 00 
  802a58:	ff d0                	callq  *%rax
  802a5a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a5d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a61:	79 05                	jns    802a68 <read+0x5d>
  802a63:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a66:	eb 76                	jmp    802ade <read+0xd3>
  802a68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a6c:	8b 40 08             	mov    0x8(%rax),%eax
  802a6f:	83 e0 03             	and    $0x3,%eax
  802a72:	83 f8 01             	cmp    $0x1,%eax
  802a75:	75 3a                	jne    802ab1 <read+0xa6>
  802a77:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802a7e:	00 00 00 
  802a81:	48 8b 00             	mov    (%rax),%rax
  802a84:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a8a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802a8d:	89 c6                	mov    %eax,%esi
  802a8f:	48 bf d7 51 80 00 00 	movabs $0x8051d7,%rdi
  802a96:	00 00 00 
  802a99:	b8 00 00 00 00       	mov    $0x0,%eax
  802a9e:	48 b9 1a 06 80 00 00 	movabs $0x80061a,%rcx
  802aa5:	00 00 00 
  802aa8:	ff d1                	callq  *%rcx
  802aaa:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802aaf:	eb 2d                	jmp    802ade <read+0xd3>
  802ab1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ab5:	48 8b 40 10          	mov    0x10(%rax),%rax
  802ab9:	48 85 c0             	test   %rax,%rax
  802abc:	75 07                	jne    802ac5 <read+0xba>
  802abe:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802ac3:	eb 19                	jmp    802ade <read+0xd3>
  802ac5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ac9:	48 8b 40 10          	mov    0x10(%rax),%rax
  802acd:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ad1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ad5:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802ad9:	48 89 cf             	mov    %rcx,%rdi
  802adc:	ff d0                	callq  *%rax
  802ade:	c9                   	leaveq 
  802adf:	c3                   	retq   

0000000000802ae0 <readn>:
  802ae0:	55                   	push   %rbp
  802ae1:	48 89 e5             	mov    %rsp,%rbp
  802ae4:	48 83 ec 30          	sub    $0x30,%rsp
  802ae8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802aeb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802aef:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802af3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802afa:	eb 49                	jmp    802b45 <readn+0x65>
  802afc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aff:	48 98                	cltq   
  802b01:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802b05:	48 29 c2             	sub    %rax,%rdx
  802b08:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b0b:	48 63 c8             	movslq %eax,%rcx
  802b0e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b12:	48 01 c1             	add    %rax,%rcx
  802b15:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802b18:	48 89 ce             	mov    %rcx,%rsi
  802b1b:	89 c7                	mov    %eax,%edi
  802b1d:	48 b8 0b 2a 80 00 00 	movabs $0x802a0b,%rax
  802b24:	00 00 00 
  802b27:	ff d0                	callq  *%rax
  802b29:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b2c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b30:	79 05                	jns    802b37 <readn+0x57>
  802b32:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b35:	eb 1c                	jmp    802b53 <readn+0x73>
  802b37:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b3b:	75 02                	jne    802b3f <readn+0x5f>
  802b3d:	eb 11                	jmp    802b50 <readn+0x70>
  802b3f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b42:	01 45 fc             	add    %eax,-0x4(%rbp)
  802b45:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b48:	48 98                	cltq   
  802b4a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802b4e:	72 ac                	jb     802afc <readn+0x1c>
  802b50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b53:	c9                   	leaveq 
  802b54:	c3                   	retq   

0000000000802b55 <write>:
  802b55:	55                   	push   %rbp
  802b56:	48 89 e5             	mov    %rsp,%rbp
  802b59:	48 83 ec 40          	sub    $0x40,%rsp
  802b5d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802b60:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802b64:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802b68:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802b6c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802b6f:	48 89 d6             	mov    %rdx,%rsi
  802b72:	89 c7                	mov    %eax,%edi
  802b74:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802b7b:	00 00 00 
  802b7e:	ff d0                	callq  *%rax
  802b80:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b83:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b87:	78 24                	js     802bad <write+0x58>
  802b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b8d:	8b 00                	mov    (%rax),%eax
  802b8f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b93:	48 89 d6             	mov    %rdx,%rsi
  802b96:	89 c7                	mov    %eax,%edi
  802b98:	48 b8 32 27 80 00 00 	movabs $0x802732,%rax
  802b9f:	00 00 00 
  802ba2:	ff d0                	callq  *%rax
  802ba4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ba7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802bab:	79 05                	jns    802bb2 <write+0x5d>
  802bad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802bb0:	eb 75                	jmp    802c27 <write+0xd2>
  802bb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bb6:	8b 40 08             	mov    0x8(%rax),%eax
  802bb9:	83 e0 03             	and    $0x3,%eax
  802bbc:	85 c0                	test   %eax,%eax
  802bbe:	75 3a                	jne    802bfa <write+0xa5>
  802bc0:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802bc7:	00 00 00 
  802bca:	48 8b 00             	mov    (%rax),%rax
  802bcd:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802bd3:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802bd6:	89 c6                	mov    %eax,%esi
  802bd8:	48 bf f3 51 80 00 00 	movabs $0x8051f3,%rdi
  802bdf:	00 00 00 
  802be2:	b8 00 00 00 00       	mov    $0x0,%eax
  802be7:	48 b9 1a 06 80 00 00 	movabs $0x80061a,%rcx
  802bee:	00 00 00 
  802bf1:	ff d1                	callq  *%rcx
  802bf3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802bf8:	eb 2d                	jmp    802c27 <write+0xd2>
  802bfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bfe:	48 8b 40 18          	mov    0x18(%rax),%rax
  802c02:	48 85 c0             	test   %rax,%rax
  802c05:	75 07                	jne    802c0e <write+0xb9>
  802c07:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802c0c:	eb 19                	jmp    802c27 <write+0xd2>
  802c0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c12:	48 8b 40 18          	mov    0x18(%rax),%rax
  802c16:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802c1a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802c1e:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802c22:	48 89 cf             	mov    %rcx,%rdi
  802c25:	ff d0                	callq  *%rax
  802c27:	c9                   	leaveq 
  802c28:	c3                   	retq   

0000000000802c29 <seek>:
  802c29:	55                   	push   %rbp
  802c2a:	48 89 e5             	mov    %rsp,%rbp
  802c2d:	48 83 ec 18          	sub    $0x18,%rsp
  802c31:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802c34:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802c37:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c3e:	48 89 d6             	mov    %rdx,%rsi
  802c41:	89 c7                	mov    %eax,%edi
  802c43:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802c4a:	00 00 00 
  802c4d:	ff d0                	callq  *%rax
  802c4f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c52:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c56:	79 05                	jns    802c5d <seek+0x34>
  802c58:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c5b:	eb 0f                	jmp    802c6c <seek+0x43>
  802c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c61:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802c64:	89 50 04             	mov    %edx,0x4(%rax)
  802c67:	b8 00 00 00 00       	mov    $0x0,%eax
  802c6c:	c9                   	leaveq 
  802c6d:	c3                   	retq   

0000000000802c6e <ftruncate>:
  802c6e:	55                   	push   %rbp
  802c6f:	48 89 e5             	mov    %rsp,%rbp
  802c72:	48 83 ec 30          	sub    $0x30,%rsp
  802c76:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c79:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802c7c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c80:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c83:	48 89 d6             	mov    %rdx,%rsi
  802c86:	89 c7                	mov    %eax,%edi
  802c88:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802c8f:	00 00 00 
  802c92:	ff d0                	callq  *%rax
  802c94:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c97:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c9b:	78 24                	js     802cc1 <ftruncate+0x53>
  802c9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ca1:	8b 00                	mov    (%rax),%eax
  802ca3:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802ca7:	48 89 d6             	mov    %rdx,%rsi
  802caa:	89 c7                	mov    %eax,%edi
  802cac:	48 b8 32 27 80 00 00 	movabs $0x802732,%rax
  802cb3:	00 00 00 
  802cb6:	ff d0                	callq  *%rax
  802cb8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cbb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cbf:	79 05                	jns    802cc6 <ftruncate+0x58>
  802cc1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cc4:	eb 72                	jmp    802d38 <ftruncate+0xca>
  802cc6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cca:	8b 40 08             	mov    0x8(%rax),%eax
  802ccd:	83 e0 03             	and    $0x3,%eax
  802cd0:	85 c0                	test   %eax,%eax
  802cd2:	75 3a                	jne    802d0e <ftruncate+0xa0>
  802cd4:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802cdb:	00 00 00 
  802cde:	48 8b 00             	mov    (%rax),%rax
  802ce1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802ce7:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802cea:	89 c6                	mov    %eax,%esi
  802cec:	48 bf 10 52 80 00 00 	movabs $0x805210,%rdi
  802cf3:	00 00 00 
  802cf6:	b8 00 00 00 00       	mov    $0x0,%eax
  802cfb:	48 b9 1a 06 80 00 00 	movabs $0x80061a,%rcx
  802d02:	00 00 00 
  802d05:	ff d1                	callq  *%rcx
  802d07:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802d0c:	eb 2a                	jmp    802d38 <ftruncate+0xca>
  802d0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d12:	48 8b 40 30          	mov    0x30(%rax),%rax
  802d16:	48 85 c0             	test   %rax,%rax
  802d19:	75 07                	jne    802d22 <ftruncate+0xb4>
  802d1b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802d20:	eb 16                	jmp    802d38 <ftruncate+0xca>
  802d22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d26:	48 8b 40 30          	mov    0x30(%rax),%rax
  802d2a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d2e:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802d31:	89 ce                	mov    %ecx,%esi
  802d33:	48 89 d7             	mov    %rdx,%rdi
  802d36:	ff d0                	callq  *%rax
  802d38:	c9                   	leaveq 
  802d39:	c3                   	retq   

0000000000802d3a <fstat>:
  802d3a:	55                   	push   %rbp
  802d3b:	48 89 e5             	mov    %rsp,%rbp
  802d3e:	48 83 ec 30          	sub    $0x30,%rsp
  802d42:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802d45:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802d49:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802d4d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802d50:	48 89 d6             	mov    %rdx,%rsi
  802d53:	89 c7                	mov    %eax,%edi
  802d55:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  802d5c:	00 00 00 
  802d5f:	ff d0                	callq  *%rax
  802d61:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d64:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d68:	78 24                	js     802d8e <fstat+0x54>
  802d6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d6e:	8b 00                	mov    (%rax),%eax
  802d70:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d74:	48 89 d6             	mov    %rdx,%rsi
  802d77:	89 c7                	mov    %eax,%edi
  802d79:	48 b8 32 27 80 00 00 	movabs $0x802732,%rax
  802d80:	00 00 00 
  802d83:	ff d0                	callq  *%rax
  802d85:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d88:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d8c:	79 05                	jns    802d93 <fstat+0x59>
  802d8e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d91:	eb 5e                	jmp    802df1 <fstat+0xb7>
  802d93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d97:	48 8b 40 28          	mov    0x28(%rax),%rax
  802d9b:	48 85 c0             	test   %rax,%rax
  802d9e:	75 07                	jne    802da7 <fstat+0x6d>
  802da0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802da5:	eb 4a                	jmp    802df1 <fstat+0xb7>
  802da7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802dab:	c6 00 00             	movb   $0x0,(%rax)
  802dae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802db2:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802db9:	00 00 00 
  802dbc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802dc0:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802dc7:	00 00 00 
  802dca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802dce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802dd2:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802dd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ddd:	48 8b 40 28          	mov    0x28(%rax),%rax
  802de1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802de5:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802de9:	48 89 ce             	mov    %rcx,%rsi
  802dec:	48 89 d7             	mov    %rdx,%rdi
  802def:	ff d0                	callq  *%rax
  802df1:	c9                   	leaveq 
  802df2:	c3                   	retq   

0000000000802df3 <stat>:
  802df3:	55                   	push   %rbp
  802df4:	48 89 e5             	mov    %rsp,%rbp
  802df7:	48 83 ec 20          	sub    $0x20,%rsp
  802dfb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802dff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802e03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e07:	be 00 00 00 00       	mov    $0x0,%esi
  802e0c:	48 89 c7             	mov    %rax,%rdi
  802e0f:	48 b8 e1 2e 80 00 00 	movabs $0x802ee1,%rax
  802e16:	00 00 00 
  802e19:	ff d0                	callq  *%rax
  802e1b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e1e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e22:	79 05                	jns    802e29 <stat+0x36>
  802e24:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e27:	eb 2f                	jmp    802e58 <stat+0x65>
  802e29:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802e2d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e30:	48 89 d6             	mov    %rdx,%rsi
  802e33:	89 c7                	mov    %eax,%edi
  802e35:	48 b8 3a 2d 80 00 00 	movabs $0x802d3a,%rax
  802e3c:	00 00 00 
  802e3f:	ff d0                	callq  *%rax
  802e41:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802e44:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e47:	89 c7                	mov    %eax,%edi
  802e49:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  802e50:	00 00 00 
  802e53:	ff d0                	callq  *%rax
  802e55:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e58:	c9                   	leaveq 
  802e59:	c3                   	retq   

0000000000802e5a <fsipc>:
  802e5a:	55                   	push   %rbp
  802e5b:	48 89 e5             	mov    %rsp,%rbp
  802e5e:	48 83 ec 10          	sub    $0x10,%rsp
  802e62:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802e65:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802e69:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802e70:	00 00 00 
  802e73:	8b 00                	mov    (%rax),%eax
  802e75:	85 c0                	test   %eax,%eax
  802e77:	75 1d                	jne    802e96 <fsipc+0x3c>
  802e79:	bf 01 00 00 00       	mov    $0x1,%edi
  802e7e:	48 b8 2f 49 80 00 00 	movabs $0x80492f,%rax
  802e85:	00 00 00 
  802e88:	ff d0                	callq  *%rax
  802e8a:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802e91:	00 00 00 
  802e94:	89 02                	mov    %eax,(%rdx)
  802e96:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802e9d:	00 00 00 
  802ea0:	8b 00                	mov    (%rax),%eax
  802ea2:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802ea5:	b9 07 00 00 00       	mov    $0x7,%ecx
  802eaa:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802eb1:	00 00 00 
  802eb4:	89 c7                	mov    %eax,%edi
  802eb6:	48 b8 24 48 80 00 00 	movabs $0x804824,%rax
  802ebd:	00 00 00 
  802ec0:	ff d0                	callq  *%rax
  802ec2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ec6:	ba 00 00 00 00       	mov    $0x0,%edx
  802ecb:	48 89 c6             	mov    %rax,%rsi
  802ece:	bf 00 00 00 00       	mov    $0x0,%edi
  802ed3:	48 b8 63 47 80 00 00 	movabs $0x804763,%rax
  802eda:	00 00 00 
  802edd:	ff d0                	callq  *%rax
  802edf:	c9                   	leaveq 
  802ee0:	c3                   	retq   

0000000000802ee1 <open>:
  802ee1:	55                   	push   %rbp
  802ee2:	48 89 e5             	mov    %rsp,%rbp
  802ee5:	48 83 ec 20          	sub    $0x20,%rsp
  802ee9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802eed:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802ef0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ef4:	48 89 c7             	mov    %rax,%rdi
  802ef7:	48 b8 63 11 80 00 00 	movabs $0x801163,%rax
  802efe:	00 00 00 
  802f01:	ff d0                	callq  *%rax
  802f03:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802f08:	7e 0a                	jle    802f14 <open+0x33>
  802f0a:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802f0f:	e9 a5 00 00 00       	jmpq   802fb9 <open+0xd8>
  802f14:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802f18:	48 89 c7             	mov    %rax,%rdi
  802f1b:	48 b8 41 25 80 00 00 	movabs $0x802541,%rax
  802f22:	00 00 00 
  802f25:	ff d0                	callq  *%rax
  802f27:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f2e:	79 08                	jns    802f38 <open+0x57>
  802f30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f33:	e9 81 00 00 00       	jmpq   802fb9 <open+0xd8>
  802f38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f3c:	48 89 c6             	mov    %rax,%rsi
  802f3f:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802f46:	00 00 00 
  802f49:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  802f50:	00 00 00 
  802f53:	ff d0                	callq  *%rax
  802f55:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802f5c:	00 00 00 
  802f5f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802f62:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802f68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f6c:	48 89 c6             	mov    %rax,%rsi
  802f6f:	bf 01 00 00 00       	mov    $0x1,%edi
  802f74:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  802f7b:	00 00 00 
  802f7e:	ff d0                	callq  *%rax
  802f80:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f83:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f87:	79 1d                	jns    802fa6 <open+0xc5>
  802f89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f8d:	be 00 00 00 00       	mov    $0x0,%esi
  802f92:	48 89 c7             	mov    %rax,%rdi
  802f95:	48 b8 69 26 80 00 00 	movabs $0x802669,%rax
  802f9c:	00 00 00 
  802f9f:	ff d0                	callq  *%rax
  802fa1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fa4:	eb 13                	jmp    802fb9 <open+0xd8>
  802fa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802faa:	48 89 c7             	mov    %rax,%rdi
  802fad:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  802fb4:	00 00 00 
  802fb7:	ff d0                	callq  *%rax
  802fb9:	c9                   	leaveq 
  802fba:	c3                   	retq   

0000000000802fbb <devfile_flush>:
  802fbb:	55                   	push   %rbp
  802fbc:	48 89 e5             	mov    %rsp,%rbp
  802fbf:	48 83 ec 10          	sub    $0x10,%rsp
  802fc3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fcb:	8b 50 0c             	mov    0xc(%rax),%edx
  802fce:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802fd5:	00 00 00 
  802fd8:	89 10                	mov    %edx,(%rax)
  802fda:	be 00 00 00 00       	mov    $0x0,%esi
  802fdf:	bf 06 00 00 00       	mov    $0x6,%edi
  802fe4:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  802feb:	00 00 00 
  802fee:	ff d0                	callq  *%rax
  802ff0:	c9                   	leaveq 
  802ff1:	c3                   	retq   

0000000000802ff2 <devfile_read>:
  802ff2:	55                   	push   %rbp
  802ff3:	48 89 e5             	mov    %rsp,%rbp
  802ff6:	48 83 ec 30          	sub    $0x30,%rsp
  802ffa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ffe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803002:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803006:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80300a:	8b 50 0c             	mov    0xc(%rax),%edx
  80300d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803014:	00 00 00 
  803017:	89 10                	mov    %edx,(%rax)
  803019:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803020:	00 00 00 
  803023:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803027:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80302b:	be 00 00 00 00       	mov    $0x0,%esi
  803030:	bf 03 00 00 00       	mov    $0x3,%edi
  803035:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  80303c:	00 00 00 
  80303f:	ff d0                	callq  *%rax
  803041:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803044:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803048:	79 08                	jns    803052 <devfile_read+0x60>
  80304a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80304d:	e9 a4 00 00 00       	jmpq   8030f6 <devfile_read+0x104>
  803052:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803055:	48 98                	cltq   
  803057:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80305b:	76 35                	jbe    803092 <devfile_read+0xa0>
  80305d:	48 b9 36 52 80 00 00 	movabs $0x805236,%rcx
  803064:	00 00 00 
  803067:	48 ba 3d 52 80 00 00 	movabs $0x80523d,%rdx
  80306e:	00 00 00 
  803071:	be 89 00 00 00       	mov    $0x89,%esi
  803076:	48 bf 52 52 80 00 00 	movabs $0x805252,%rdi
  80307d:	00 00 00 
  803080:	b8 00 00 00 00       	mov    $0x0,%eax
  803085:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  80308c:	00 00 00 
  80308f:	41 ff d0             	callq  *%r8
  803092:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803099:	7e 35                	jle    8030d0 <devfile_read+0xde>
  80309b:	48 b9 60 52 80 00 00 	movabs $0x805260,%rcx
  8030a2:	00 00 00 
  8030a5:	48 ba 3d 52 80 00 00 	movabs $0x80523d,%rdx
  8030ac:	00 00 00 
  8030af:	be 8a 00 00 00       	mov    $0x8a,%esi
  8030b4:	48 bf 52 52 80 00 00 	movabs $0x805252,%rdi
  8030bb:	00 00 00 
  8030be:	b8 00 00 00 00       	mov    $0x0,%eax
  8030c3:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8030ca:	00 00 00 
  8030cd:	41 ff d0             	callq  *%r8
  8030d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030d3:	48 63 d0             	movslq %eax,%rdx
  8030d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8030da:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8030e1:	00 00 00 
  8030e4:	48 89 c7             	mov    %rax,%rdi
  8030e7:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  8030ee:	00 00 00 
  8030f1:	ff d0                	callq  *%rax
  8030f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030f6:	c9                   	leaveq 
  8030f7:	c3                   	retq   

00000000008030f8 <devfile_write>:
  8030f8:	55                   	push   %rbp
  8030f9:	48 89 e5             	mov    %rsp,%rbp
  8030fc:	48 83 ec 40          	sub    $0x40,%rsp
  803100:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803104:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803108:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80310c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803110:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803114:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  80311b:	00 
  80311c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803120:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  803124:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  803129:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  80312d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803131:	8b 50 0c             	mov    0xc(%rax),%edx
  803134:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80313b:	00 00 00 
  80313e:	89 10                	mov    %edx,(%rax)
  803140:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803147:	00 00 00 
  80314a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80314e:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803152:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803156:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80315a:	48 89 c6             	mov    %rax,%rsi
  80315d:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  803164:	00 00 00 
  803167:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  80316e:	00 00 00 
  803171:	ff d0                	callq  *%rax
  803173:	be 00 00 00 00       	mov    $0x0,%esi
  803178:	bf 04 00 00 00       	mov    $0x4,%edi
  80317d:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  803184:	00 00 00 
  803187:	ff d0                	callq  *%rax
  803189:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80318c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803190:	79 05                	jns    803197 <devfile_write+0x9f>
  803192:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803195:	eb 43                	jmp    8031da <devfile_write+0xe2>
  803197:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80319a:	48 98                	cltq   
  80319c:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8031a0:	76 35                	jbe    8031d7 <devfile_write+0xdf>
  8031a2:	48 b9 36 52 80 00 00 	movabs $0x805236,%rcx
  8031a9:	00 00 00 
  8031ac:	48 ba 3d 52 80 00 00 	movabs $0x80523d,%rdx
  8031b3:	00 00 00 
  8031b6:	be a8 00 00 00       	mov    $0xa8,%esi
  8031bb:	48 bf 52 52 80 00 00 	movabs $0x805252,%rdi
  8031c2:	00 00 00 
  8031c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8031ca:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8031d1:	00 00 00 
  8031d4:	41 ff d0             	callq  *%r8
  8031d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8031da:	c9                   	leaveq 
  8031db:	c3                   	retq   

00000000008031dc <devfile_stat>:
  8031dc:	55                   	push   %rbp
  8031dd:	48 89 e5             	mov    %rsp,%rbp
  8031e0:	48 83 ec 20          	sub    $0x20,%rsp
  8031e4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8031e8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8031ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031f0:	8b 50 0c             	mov    0xc(%rax),%edx
  8031f3:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8031fa:	00 00 00 
  8031fd:	89 10                	mov    %edx,(%rax)
  8031ff:	be 00 00 00 00       	mov    $0x0,%esi
  803204:	bf 05 00 00 00       	mov    $0x5,%edi
  803209:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  803210:	00 00 00 
  803213:	ff d0                	callq  *%rax
  803215:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803218:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80321c:	79 05                	jns    803223 <devfile_stat+0x47>
  80321e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803221:	eb 56                	jmp    803279 <devfile_stat+0x9d>
  803223:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803227:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  80322e:	00 00 00 
  803231:	48 89 c7             	mov    %rax,%rdi
  803234:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  80323b:	00 00 00 
  80323e:	ff d0                	callq  *%rax
  803240:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803247:	00 00 00 
  80324a:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803250:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803254:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80325a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803261:	00 00 00 
  803264:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80326a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80326e:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803274:	b8 00 00 00 00       	mov    $0x0,%eax
  803279:	c9                   	leaveq 
  80327a:	c3                   	retq   

000000000080327b <devfile_trunc>:
  80327b:	55                   	push   %rbp
  80327c:	48 89 e5             	mov    %rsp,%rbp
  80327f:	48 83 ec 10          	sub    $0x10,%rsp
  803283:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803287:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80328a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80328e:	8b 50 0c             	mov    0xc(%rax),%edx
  803291:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803298:	00 00 00 
  80329b:	89 10                	mov    %edx,(%rax)
  80329d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8032a4:	00 00 00 
  8032a7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8032aa:	89 50 04             	mov    %edx,0x4(%rax)
  8032ad:	be 00 00 00 00       	mov    $0x0,%esi
  8032b2:	bf 02 00 00 00       	mov    $0x2,%edi
  8032b7:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  8032be:	00 00 00 
  8032c1:	ff d0                	callq  *%rax
  8032c3:	c9                   	leaveq 
  8032c4:	c3                   	retq   

00000000008032c5 <remove>:
  8032c5:	55                   	push   %rbp
  8032c6:	48 89 e5             	mov    %rsp,%rbp
  8032c9:	48 83 ec 10          	sub    $0x10,%rsp
  8032cd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8032d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032d5:	48 89 c7             	mov    %rax,%rdi
  8032d8:	48 b8 63 11 80 00 00 	movabs $0x801163,%rax
  8032df:	00 00 00 
  8032e2:	ff d0                	callq  *%rax
  8032e4:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8032e9:	7e 07                	jle    8032f2 <remove+0x2d>
  8032eb:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8032f0:	eb 33                	jmp    803325 <remove+0x60>
  8032f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032f6:	48 89 c6             	mov    %rax,%rsi
  8032f9:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803300:	00 00 00 
  803303:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  80330a:	00 00 00 
  80330d:	ff d0                	callq  *%rax
  80330f:	be 00 00 00 00       	mov    $0x0,%esi
  803314:	bf 07 00 00 00       	mov    $0x7,%edi
  803319:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  803320:	00 00 00 
  803323:	ff d0                	callq  *%rax
  803325:	c9                   	leaveq 
  803326:	c3                   	retq   

0000000000803327 <sync>:
  803327:	55                   	push   %rbp
  803328:	48 89 e5             	mov    %rsp,%rbp
  80332b:	be 00 00 00 00       	mov    $0x0,%esi
  803330:	bf 08 00 00 00       	mov    $0x8,%edi
  803335:	48 b8 5a 2e 80 00 00 	movabs $0x802e5a,%rax
  80333c:	00 00 00 
  80333f:	ff d0                	callq  *%rax
  803341:	5d                   	pop    %rbp
  803342:	c3                   	retq   

0000000000803343 <copy>:
  803343:	55                   	push   %rbp
  803344:	48 89 e5             	mov    %rsp,%rbp
  803347:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  80334e:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  803355:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80335c:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803363:	be 00 00 00 00       	mov    $0x0,%esi
  803368:	48 89 c7             	mov    %rax,%rdi
  80336b:	48 b8 e1 2e 80 00 00 	movabs $0x802ee1,%rax
  803372:	00 00 00 
  803375:	ff d0                	callq  *%rax
  803377:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80337a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80337e:	79 28                	jns    8033a8 <copy+0x65>
  803380:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803383:	89 c6                	mov    %eax,%esi
  803385:	48 bf 6c 52 80 00 00 	movabs $0x80526c,%rdi
  80338c:	00 00 00 
  80338f:	b8 00 00 00 00       	mov    $0x0,%eax
  803394:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  80339b:	00 00 00 
  80339e:	ff d2                	callq  *%rdx
  8033a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033a3:	e9 74 01 00 00       	jmpq   80351c <copy+0x1d9>
  8033a8:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  8033af:	be 01 01 00 00       	mov    $0x101,%esi
  8033b4:	48 89 c7             	mov    %rax,%rdi
  8033b7:	48 b8 e1 2e 80 00 00 	movabs $0x802ee1,%rax
  8033be:	00 00 00 
  8033c1:	ff d0                	callq  *%rax
  8033c3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8033c6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8033ca:	79 39                	jns    803405 <copy+0xc2>
  8033cc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033cf:	89 c6                	mov    %eax,%esi
  8033d1:	48 bf 82 52 80 00 00 	movabs $0x805282,%rdi
  8033d8:	00 00 00 
  8033db:	b8 00 00 00 00       	mov    $0x0,%eax
  8033e0:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  8033e7:	00 00 00 
  8033ea:	ff d2                	callq  *%rdx
  8033ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033ef:	89 c7                	mov    %eax,%edi
  8033f1:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  8033f8:	00 00 00 
  8033fb:	ff d0                	callq  *%rax
  8033fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803400:	e9 17 01 00 00       	jmpq   80351c <copy+0x1d9>
  803405:	eb 74                	jmp    80347b <copy+0x138>
  803407:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80340a:	48 63 d0             	movslq %eax,%rdx
  80340d:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803414:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803417:	48 89 ce             	mov    %rcx,%rsi
  80341a:	89 c7                	mov    %eax,%edi
  80341c:	48 b8 55 2b 80 00 00 	movabs $0x802b55,%rax
  803423:	00 00 00 
  803426:	ff d0                	callq  *%rax
  803428:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80342b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80342f:	79 4a                	jns    80347b <copy+0x138>
  803431:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803434:	89 c6                	mov    %eax,%esi
  803436:	48 bf 9c 52 80 00 00 	movabs $0x80529c,%rdi
  80343d:	00 00 00 
  803440:	b8 00 00 00 00       	mov    $0x0,%eax
  803445:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  80344c:	00 00 00 
  80344f:	ff d2                	callq  *%rdx
  803451:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803454:	89 c7                	mov    %eax,%edi
  803456:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  80345d:	00 00 00 
  803460:	ff d0                	callq  *%rax
  803462:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803465:	89 c7                	mov    %eax,%edi
  803467:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  80346e:	00 00 00 
  803471:	ff d0                	callq  *%rax
  803473:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803476:	e9 a1 00 00 00       	jmpq   80351c <copy+0x1d9>
  80347b:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803482:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803485:	ba 00 02 00 00       	mov    $0x200,%edx
  80348a:	48 89 ce             	mov    %rcx,%rsi
  80348d:	89 c7                	mov    %eax,%edi
  80348f:	48 b8 0b 2a 80 00 00 	movabs $0x802a0b,%rax
  803496:	00 00 00 
  803499:	ff d0                	callq  *%rax
  80349b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80349e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8034a2:	0f 8f 5f ff ff ff    	jg     803407 <copy+0xc4>
  8034a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8034ac:	79 47                	jns    8034f5 <copy+0x1b2>
  8034ae:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8034b1:	89 c6                	mov    %eax,%esi
  8034b3:	48 bf af 52 80 00 00 	movabs $0x8052af,%rdi
  8034ba:	00 00 00 
  8034bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8034c2:	48 ba 1a 06 80 00 00 	movabs $0x80061a,%rdx
  8034c9:	00 00 00 
  8034cc:	ff d2                	callq  *%rdx
  8034ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034d1:	89 c7                	mov    %eax,%edi
  8034d3:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  8034da:	00 00 00 
  8034dd:	ff d0                	callq  *%rax
  8034df:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034e2:	89 c7                	mov    %eax,%edi
  8034e4:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  8034eb:	00 00 00 
  8034ee:	ff d0                	callq  *%rax
  8034f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8034f3:	eb 27                	jmp    80351c <copy+0x1d9>
  8034f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034f8:	89 c7                	mov    %eax,%edi
  8034fa:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  803501:	00 00 00 
  803504:	ff d0                	callq  *%rax
  803506:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803509:	89 c7                	mov    %eax,%edi
  80350b:	48 b8 e9 27 80 00 00 	movabs $0x8027e9,%rax
  803512:	00 00 00 
  803515:	ff d0                	callq  *%rax
  803517:	b8 00 00 00 00       	mov    $0x0,%eax
  80351c:	c9                   	leaveq 
  80351d:	c3                   	retq   

000000000080351e <fd2sockid>:
  80351e:	55                   	push   %rbp
  80351f:	48 89 e5             	mov    %rsp,%rbp
  803522:	48 83 ec 20          	sub    $0x20,%rsp
  803526:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803529:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80352d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803530:	48 89 d6             	mov    %rdx,%rsi
  803533:	89 c7                	mov    %eax,%edi
  803535:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  80353c:	00 00 00 
  80353f:	ff d0                	callq  *%rax
  803541:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803544:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803548:	79 05                	jns    80354f <fd2sockid+0x31>
  80354a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80354d:	eb 24                	jmp    803573 <fd2sockid+0x55>
  80354f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803553:	8b 10                	mov    (%rax),%edx
  803555:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  80355c:	00 00 00 
  80355f:	8b 00                	mov    (%rax),%eax
  803561:	39 c2                	cmp    %eax,%edx
  803563:	74 07                	je     80356c <fd2sockid+0x4e>
  803565:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80356a:	eb 07                	jmp    803573 <fd2sockid+0x55>
  80356c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803570:	8b 40 0c             	mov    0xc(%rax),%eax
  803573:	c9                   	leaveq 
  803574:	c3                   	retq   

0000000000803575 <alloc_sockfd>:
  803575:	55                   	push   %rbp
  803576:	48 89 e5             	mov    %rsp,%rbp
  803579:	48 83 ec 20          	sub    $0x20,%rsp
  80357d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803580:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803584:	48 89 c7             	mov    %rax,%rdi
  803587:	48 b8 41 25 80 00 00 	movabs $0x802541,%rax
  80358e:	00 00 00 
  803591:	ff d0                	callq  *%rax
  803593:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803596:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80359a:	78 26                	js     8035c2 <alloc_sockfd+0x4d>
  80359c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035a0:	ba 07 04 00 00       	mov    $0x407,%edx
  8035a5:	48 89 c6             	mov    %rax,%rsi
  8035a8:	bf 00 00 00 00       	mov    $0x0,%edi
  8035ad:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  8035b4:	00 00 00 
  8035b7:	ff d0                	callq  *%rax
  8035b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035c0:	79 16                	jns    8035d8 <alloc_sockfd+0x63>
  8035c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035c5:	89 c7                	mov    %eax,%edi
  8035c7:	48 b8 82 3a 80 00 00 	movabs $0x803a82,%rax
  8035ce:	00 00 00 
  8035d1:	ff d0                	callq  *%rax
  8035d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035d6:	eb 3a                	jmp    803612 <alloc_sockfd+0x9d>
  8035d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035dc:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8035e3:	00 00 00 
  8035e6:	8b 12                	mov    (%rdx),%edx
  8035e8:	89 10                	mov    %edx,(%rax)
  8035ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035ee:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8035f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035f9:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8035fc:	89 50 0c             	mov    %edx,0xc(%rax)
  8035ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803603:	48 89 c7             	mov    %rax,%rdi
  803606:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  80360d:	00 00 00 
  803610:	ff d0                	callq  *%rax
  803612:	c9                   	leaveq 
  803613:	c3                   	retq   

0000000000803614 <accept>:
  803614:	55                   	push   %rbp
  803615:	48 89 e5             	mov    %rsp,%rbp
  803618:	48 83 ec 30          	sub    $0x30,%rsp
  80361c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80361f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803623:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803627:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80362a:	89 c7                	mov    %eax,%edi
  80362c:	48 b8 1e 35 80 00 00 	movabs $0x80351e,%rax
  803633:	00 00 00 
  803636:	ff d0                	callq  *%rax
  803638:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80363b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80363f:	79 05                	jns    803646 <accept+0x32>
  803641:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803644:	eb 3b                	jmp    803681 <accept+0x6d>
  803646:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80364a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80364e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803651:	48 89 ce             	mov    %rcx,%rsi
  803654:	89 c7                	mov    %eax,%edi
  803656:	48 b8 5f 39 80 00 00 	movabs $0x80395f,%rax
  80365d:	00 00 00 
  803660:	ff d0                	callq  *%rax
  803662:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803665:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803669:	79 05                	jns    803670 <accept+0x5c>
  80366b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80366e:	eb 11                	jmp    803681 <accept+0x6d>
  803670:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803673:	89 c7                	mov    %eax,%edi
  803675:	48 b8 75 35 80 00 00 	movabs $0x803575,%rax
  80367c:	00 00 00 
  80367f:	ff d0                	callq  *%rax
  803681:	c9                   	leaveq 
  803682:	c3                   	retq   

0000000000803683 <bind>:
  803683:	55                   	push   %rbp
  803684:	48 89 e5             	mov    %rsp,%rbp
  803687:	48 83 ec 20          	sub    $0x20,%rsp
  80368b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80368e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803692:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803695:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803698:	89 c7                	mov    %eax,%edi
  80369a:	48 b8 1e 35 80 00 00 	movabs $0x80351e,%rax
  8036a1:	00 00 00 
  8036a4:	ff d0                	callq  *%rax
  8036a6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036a9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036ad:	79 05                	jns    8036b4 <bind+0x31>
  8036af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036b2:	eb 1b                	jmp    8036cf <bind+0x4c>
  8036b4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8036b7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8036bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036be:	48 89 ce             	mov    %rcx,%rsi
  8036c1:	89 c7                	mov    %eax,%edi
  8036c3:	48 b8 de 39 80 00 00 	movabs $0x8039de,%rax
  8036ca:	00 00 00 
  8036cd:	ff d0                	callq  *%rax
  8036cf:	c9                   	leaveq 
  8036d0:	c3                   	retq   

00000000008036d1 <shutdown>:
  8036d1:	55                   	push   %rbp
  8036d2:	48 89 e5             	mov    %rsp,%rbp
  8036d5:	48 83 ec 20          	sub    $0x20,%rsp
  8036d9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036dc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8036df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036e2:	89 c7                	mov    %eax,%edi
  8036e4:	48 b8 1e 35 80 00 00 	movabs $0x80351e,%rax
  8036eb:	00 00 00 
  8036ee:	ff d0                	callq  *%rax
  8036f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036f7:	79 05                	jns    8036fe <shutdown+0x2d>
  8036f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036fc:	eb 16                	jmp    803714 <shutdown+0x43>
  8036fe:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803701:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803704:	89 d6                	mov    %edx,%esi
  803706:	89 c7                	mov    %eax,%edi
  803708:	48 b8 42 3a 80 00 00 	movabs $0x803a42,%rax
  80370f:	00 00 00 
  803712:	ff d0                	callq  *%rax
  803714:	c9                   	leaveq 
  803715:	c3                   	retq   

0000000000803716 <devsock_close>:
  803716:	55                   	push   %rbp
  803717:	48 89 e5             	mov    %rsp,%rbp
  80371a:	48 83 ec 10          	sub    $0x10,%rsp
  80371e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803722:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803726:	48 89 c7             	mov    %rax,%rdi
  803729:	48 b8 a1 49 80 00 00 	movabs $0x8049a1,%rax
  803730:	00 00 00 
  803733:	ff d0                	callq  *%rax
  803735:	83 f8 01             	cmp    $0x1,%eax
  803738:	75 17                	jne    803751 <devsock_close+0x3b>
  80373a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80373e:	8b 40 0c             	mov    0xc(%rax),%eax
  803741:	89 c7                	mov    %eax,%edi
  803743:	48 b8 82 3a 80 00 00 	movabs $0x803a82,%rax
  80374a:	00 00 00 
  80374d:	ff d0                	callq  *%rax
  80374f:	eb 05                	jmp    803756 <devsock_close+0x40>
  803751:	b8 00 00 00 00       	mov    $0x0,%eax
  803756:	c9                   	leaveq 
  803757:	c3                   	retq   

0000000000803758 <connect>:
  803758:	55                   	push   %rbp
  803759:	48 89 e5             	mov    %rsp,%rbp
  80375c:	48 83 ec 20          	sub    $0x20,%rsp
  803760:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803763:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803767:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80376a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80376d:	89 c7                	mov    %eax,%edi
  80376f:	48 b8 1e 35 80 00 00 	movabs $0x80351e,%rax
  803776:	00 00 00 
  803779:	ff d0                	callq  *%rax
  80377b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80377e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803782:	79 05                	jns    803789 <connect+0x31>
  803784:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803787:	eb 1b                	jmp    8037a4 <connect+0x4c>
  803789:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80378c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803790:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803793:	48 89 ce             	mov    %rcx,%rsi
  803796:	89 c7                	mov    %eax,%edi
  803798:	48 b8 af 3a 80 00 00 	movabs $0x803aaf,%rax
  80379f:	00 00 00 
  8037a2:	ff d0                	callq  *%rax
  8037a4:	c9                   	leaveq 
  8037a5:	c3                   	retq   

00000000008037a6 <listen>:
  8037a6:	55                   	push   %rbp
  8037a7:	48 89 e5             	mov    %rsp,%rbp
  8037aa:	48 83 ec 20          	sub    $0x20,%rsp
  8037ae:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8037b1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8037b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037b7:	89 c7                	mov    %eax,%edi
  8037b9:	48 b8 1e 35 80 00 00 	movabs $0x80351e,%rax
  8037c0:	00 00 00 
  8037c3:	ff d0                	callq  *%rax
  8037c5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037cc:	79 05                	jns    8037d3 <listen+0x2d>
  8037ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037d1:	eb 16                	jmp    8037e9 <listen+0x43>
  8037d3:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8037d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037d9:	89 d6                	mov    %edx,%esi
  8037db:	89 c7                	mov    %eax,%edi
  8037dd:	48 b8 13 3b 80 00 00 	movabs $0x803b13,%rax
  8037e4:	00 00 00 
  8037e7:	ff d0                	callq  *%rax
  8037e9:	c9                   	leaveq 
  8037ea:	c3                   	retq   

00000000008037eb <devsock_read>:
  8037eb:	55                   	push   %rbp
  8037ec:	48 89 e5             	mov    %rsp,%rbp
  8037ef:	48 83 ec 20          	sub    $0x20,%rsp
  8037f3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037f7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037fb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8037ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803803:	89 c2                	mov    %eax,%edx
  803805:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803809:	8b 40 0c             	mov    0xc(%rax),%eax
  80380c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803810:	b9 00 00 00 00       	mov    $0x0,%ecx
  803815:	89 c7                	mov    %eax,%edi
  803817:	48 b8 53 3b 80 00 00 	movabs $0x803b53,%rax
  80381e:	00 00 00 
  803821:	ff d0                	callq  *%rax
  803823:	c9                   	leaveq 
  803824:	c3                   	retq   

0000000000803825 <devsock_write>:
  803825:	55                   	push   %rbp
  803826:	48 89 e5             	mov    %rsp,%rbp
  803829:	48 83 ec 20          	sub    $0x20,%rsp
  80382d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803831:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803835:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803839:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80383d:	89 c2                	mov    %eax,%edx
  80383f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803843:	8b 40 0c             	mov    0xc(%rax),%eax
  803846:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80384a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80384f:	89 c7                	mov    %eax,%edi
  803851:	48 b8 1f 3c 80 00 00 	movabs $0x803c1f,%rax
  803858:	00 00 00 
  80385b:	ff d0                	callq  *%rax
  80385d:	c9                   	leaveq 
  80385e:	c3                   	retq   

000000000080385f <devsock_stat>:
  80385f:	55                   	push   %rbp
  803860:	48 89 e5             	mov    %rsp,%rbp
  803863:	48 83 ec 10          	sub    $0x10,%rsp
  803867:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80386b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80386f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803873:	48 be ca 52 80 00 00 	movabs $0x8052ca,%rsi
  80387a:	00 00 00 
  80387d:	48 89 c7             	mov    %rax,%rdi
  803880:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  803887:	00 00 00 
  80388a:	ff d0                	callq  *%rax
  80388c:	b8 00 00 00 00       	mov    $0x0,%eax
  803891:	c9                   	leaveq 
  803892:	c3                   	retq   

0000000000803893 <socket>:
  803893:	55                   	push   %rbp
  803894:	48 89 e5             	mov    %rsp,%rbp
  803897:	48 83 ec 20          	sub    $0x20,%rsp
  80389b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80389e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8038a1:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  8038a4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8038a7:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8038aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8038ad:	89 ce                	mov    %ecx,%esi
  8038af:	89 c7                	mov    %eax,%edi
  8038b1:	48 b8 d7 3c 80 00 00 	movabs $0x803cd7,%rax
  8038b8:	00 00 00 
  8038bb:	ff d0                	callq  *%rax
  8038bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038c4:	79 05                	jns    8038cb <socket+0x38>
  8038c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038c9:	eb 11                	jmp    8038dc <socket+0x49>
  8038cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038ce:	89 c7                	mov    %eax,%edi
  8038d0:	48 b8 75 35 80 00 00 	movabs $0x803575,%rax
  8038d7:	00 00 00 
  8038da:	ff d0                	callq  *%rax
  8038dc:	c9                   	leaveq 
  8038dd:	c3                   	retq   

00000000008038de <nsipc>:
  8038de:	55                   	push   %rbp
  8038df:	48 89 e5             	mov    %rsp,%rbp
  8038e2:	48 83 ec 10          	sub    $0x10,%rsp
  8038e6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8038e9:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8038f0:	00 00 00 
  8038f3:	8b 00                	mov    (%rax),%eax
  8038f5:	85 c0                	test   %eax,%eax
  8038f7:	75 1d                	jne    803916 <nsipc+0x38>
  8038f9:	bf 02 00 00 00       	mov    $0x2,%edi
  8038fe:	48 b8 2f 49 80 00 00 	movabs $0x80492f,%rax
  803905:	00 00 00 
  803908:	ff d0                	callq  *%rax
  80390a:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803911:	00 00 00 
  803914:	89 02                	mov    %eax,(%rdx)
  803916:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  80391d:	00 00 00 
  803920:	8b 00                	mov    (%rax),%eax
  803922:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803925:	b9 07 00 00 00       	mov    $0x7,%ecx
  80392a:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803931:	00 00 00 
  803934:	89 c7                	mov    %eax,%edi
  803936:	48 b8 24 48 80 00 00 	movabs $0x804824,%rax
  80393d:	00 00 00 
  803940:	ff d0                	callq  *%rax
  803942:	ba 00 00 00 00       	mov    $0x0,%edx
  803947:	be 00 00 00 00       	mov    $0x0,%esi
  80394c:	bf 00 00 00 00       	mov    $0x0,%edi
  803951:	48 b8 63 47 80 00 00 	movabs $0x804763,%rax
  803958:	00 00 00 
  80395b:	ff d0                	callq  *%rax
  80395d:	c9                   	leaveq 
  80395e:	c3                   	retq   

000000000080395f <nsipc_accept>:
  80395f:	55                   	push   %rbp
  803960:	48 89 e5             	mov    %rsp,%rbp
  803963:	48 83 ec 30          	sub    $0x30,%rsp
  803967:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80396a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80396e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803972:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803979:	00 00 00 
  80397c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80397f:	89 10                	mov    %edx,(%rax)
  803981:	bf 01 00 00 00       	mov    $0x1,%edi
  803986:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  80398d:	00 00 00 
  803990:	ff d0                	callq  *%rax
  803992:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803995:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803999:	78 3e                	js     8039d9 <nsipc_accept+0x7a>
  80399b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8039a2:	00 00 00 
  8039a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8039a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039ad:	8b 40 10             	mov    0x10(%rax),%eax
  8039b0:	89 c2                	mov    %eax,%edx
  8039b2:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8039b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8039ba:	48 89 ce             	mov    %rcx,%rsi
  8039bd:	48 89 c7             	mov    %rax,%rdi
  8039c0:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  8039c7:	00 00 00 
  8039ca:	ff d0                	callq  *%rax
  8039cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039d0:	8b 50 10             	mov    0x10(%rax),%edx
  8039d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8039d7:	89 10                	mov    %edx,(%rax)
  8039d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039dc:	c9                   	leaveq 
  8039dd:	c3                   	retq   

00000000008039de <nsipc_bind>:
  8039de:	55                   	push   %rbp
  8039df:	48 89 e5             	mov    %rsp,%rbp
  8039e2:	48 83 ec 10          	sub    $0x10,%rsp
  8039e6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039e9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039ed:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8039f0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8039f7:	00 00 00 
  8039fa:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8039fd:	89 10                	mov    %edx,(%rax)
  8039ff:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a06:	48 89 c6             	mov    %rax,%rsi
  803a09:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803a10:	00 00 00 
  803a13:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  803a1a:	00 00 00 
  803a1d:	ff d0                	callq  *%rax
  803a1f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a26:	00 00 00 
  803a29:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a2c:	89 50 14             	mov    %edx,0x14(%rax)
  803a2f:	bf 02 00 00 00       	mov    $0x2,%edi
  803a34:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803a3b:	00 00 00 
  803a3e:	ff d0                	callq  *%rax
  803a40:	c9                   	leaveq 
  803a41:	c3                   	retq   

0000000000803a42 <nsipc_shutdown>:
  803a42:	55                   	push   %rbp
  803a43:	48 89 e5             	mov    %rsp,%rbp
  803a46:	48 83 ec 10          	sub    $0x10,%rsp
  803a4a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a4d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803a50:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a57:	00 00 00 
  803a5a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a5d:	89 10                	mov    %edx,(%rax)
  803a5f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a66:	00 00 00 
  803a69:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a6c:	89 50 04             	mov    %edx,0x4(%rax)
  803a6f:	bf 03 00 00 00       	mov    $0x3,%edi
  803a74:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803a7b:	00 00 00 
  803a7e:	ff d0                	callq  *%rax
  803a80:	c9                   	leaveq 
  803a81:	c3                   	retq   

0000000000803a82 <nsipc_close>:
  803a82:	55                   	push   %rbp
  803a83:	48 89 e5             	mov    %rsp,%rbp
  803a86:	48 83 ec 10          	sub    $0x10,%rsp
  803a8a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a8d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a94:	00 00 00 
  803a97:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a9a:	89 10                	mov    %edx,(%rax)
  803a9c:	bf 04 00 00 00       	mov    $0x4,%edi
  803aa1:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803aa8:	00 00 00 
  803aab:	ff d0                	callq  *%rax
  803aad:	c9                   	leaveq 
  803aae:	c3                   	retq   

0000000000803aaf <nsipc_connect>:
  803aaf:	55                   	push   %rbp
  803ab0:	48 89 e5             	mov    %rsp,%rbp
  803ab3:	48 83 ec 10          	sub    $0x10,%rsp
  803ab7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803aba:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803abe:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803ac1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ac8:	00 00 00 
  803acb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ace:	89 10                	mov    %edx,(%rax)
  803ad0:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ad3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ad7:	48 89 c6             	mov    %rax,%rsi
  803ada:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803ae1:	00 00 00 
  803ae4:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  803aeb:	00 00 00 
  803aee:	ff d0                	callq  *%rax
  803af0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803af7:	00 00 00 
  803afa:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803afd:	89 50 14             	mov    %edx,0x14(%rax)
  803b00:	bf 05 00 00 00       	mov    $0x5,%edi
  803b05:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803b0c:	00 00 00 
  803b0f:	ff d0                	callq  *%rax
  803b11:	c9                   	leaveq 
  803b12:	c3                   	retq   

0000000000803b13 <nsipc_listen>:
  803b13:	55                   	push   %rbp
  803b14:	48 89 e5             	mov    %rsp,%rbp
  803b17:	48 83 ec 10          	sub    $0x10,%rsp
  803b1b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b1e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803b21:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b28:	00 00 00 
  803b2b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b2e:	89 10                	mov    %edx,(%rax)
  803b30:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b37:	00 00 00 
  803b3a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803b3d:	89 50 04             	mov    %edx,0x4(%rax)
  803b40:	bf 06 00 00 00       	mov    $0x6,%edi
  803b45:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803b4c:	00 00 00 
  803b4f:	ff d0                	callq  *%rax
  803b51:	c9                   	leaveq 
  803b52:	c3                   	retq   

0000000000803b53 <nsipc_recv>:
  803b53:	55                   	push   %rbp
  803b54:	48 89 e5             	mov    %rsp,%rbp
  803b57:	48 83 ec 30          	sub    $0x30,%rsp
  803b5b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b5e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b62:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803b65:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803b68:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b6f:	00 00 00 
  803b72:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b75:	89 10                	mov    %edx,(%rax)
  803b77:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b7e:	00 00 00 
  803b81:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b84:	89 50 04             	mov    %edx,0x4(%rax)
  803b87:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b8e:	00 00 00 
  803b91:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803b94:	89 50 08             	mov    %edx,0x8(%rax)
  803b97:	bf 07 00 00 00       	mov    $0x7,%edi
  803b9c:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803ba3:	00 00 00 
  803ba6:	ff d0                	callq  *%rax
  803ba8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803baf:	78 69                	js     803c1a <nsipc_recv+0xc7>
  803bb1:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803bb8:	7f 08                	jg     803bc2 <nsipc_recv+0x6f>
  803bba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bbd:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803bc0:	7e 35                	jle    803bf7 <nsipc_recv+0xa4>
  803bc2:	48 b9 d1 52 80 00 00 	movabs $0x8052d1,%rcx
  803bc9:	00 00 00 
  803bcc:	48 ba e6 52 80 00 00 	movabs $0x8052e6,%rdx
  803bd3:	00 00 00 
  803bd6:	be 62 00 00 00       	mov    $0x62,%esi
  803bdb:	48 bf fb 52 80 00 00 	movabs $0x8052fb,%rdi
  803be2:	00 00 00 
  803be5:	b8 00 00 00 00       	mov    $0x0,%eax
  803bea:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  803bf1:	00 00 00 
  803bf4:	41 ff d0             	callq  *%r8
  803bf7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bfa:	48 63 d0             	movslq %eax,%rdx
  803bfd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803c01:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803c08:	00 00 00 
  803c0b:	48 89 c7             	mov    %rax,%rdi
  803c0e:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  803c15:	00 00 00 
  803c18:	ff d0                	callq  *%rax
  803c1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c1d:	c9                   	leaveq 
  803c1e:	c3                   	retq   

0000000000803c1f <nsipc_send>:
  803c1f:	55                   	push   %rbp
  803c20:	48 89 e5             	mov    %rsp,%rbp
  803c23:	48 83 ec 20          	sub    $0x20,%rsp
  803c27:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c2a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803c2e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803c31:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803c34:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c3b:	00 00 00 
  803c3e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c41:	89 10                	mov    %edx,(%rax)
  803c43:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803c4a:	7e 35                	jle    803c81 <nsipc_send+0x62>
  803c4c:	48 b9 0a 53 80 00 00 	movabs $0x80530a,%rcx
  803c53:	00 00 00 
  803c56:	48 ba e6 52 80 00 00 	movabs $0x8052e6,%rdx
  803c5d:	00 00 00 
  803c60:	be 6d 00 00 00       	mov    $0x6d,%esi
  803c65:	48 bf fb 52 80 00 00 	movabs $0x8052fb,%rdi
  803c6c:	00 00 00 
  803c6f:	b8 00 00 00 00       	mov    $0x0,%eax
  803c74:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  803c7b:	00 00 00 
  803c7e:	41 ff d0             	callq  *%r8
  803c81:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803c84:	48 63 d0             	movslq %eax,%rdx
  803c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c8b:	48 89 c6             	mov    %rax,%rsi
  803c8e:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803c95:	00 00 00 
  803c98:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  803c9f:	00 00 00 
  803ca2:	ff d0                	callq  *%rax
  803ca4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cab:	00 00 00 
  803cae:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803cb1:	89 50 04             	mov    %edx,0x4(%rax)
  803cb4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cbb:	00 00 00 
  803cbe:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803cc1:	89 50 08             	mov    %edx,0x8(%rax)
  803cc4:	bf 08 00 00 00       	mov    $0x8,%edi
  803cc9:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803cd0:	00 00 00 
  803cd3:	ff d0                	callq  *%rax
  803cd5:	c9                   	leaveq 
  803cd6:	c3                   	retq   

0000000000803cd7 <nsipc_socket>:
  803cd7:	55                   	push   %rbp
  803cd8:	48 89 e5             	mov    %rsp,%rbp
  803cdb:	48 83 ec 10          	sub    $0x10,%rsp
  803cdf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ce2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803ce5:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803ce8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cef:	00 00 00 
  803cf2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803cf5:	89 10                	mov    %edx,(%rax)
  803cf7:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cfe:	00 00 00 
  803d01:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d04:	89 50 04             	mov    %edx,0x4(%rax)
  803d07:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d0e:	00 00 00 
  803d11:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803d14:	89 50 08             	mov    %edx,0x8(%rax)
  803d17:	bf 09 00 00 00       	mov    $0x9,%edi
  803d1c:	48 b8 de 38 80 00 00 	movabs $0x8038de,%rax
  803d23:	00 00 00 
  803d26:	ff d0                	callq  *%rax
  803d28:	c9                   	leaveq 
  803d29:	c3                   	retq   

0000000000803d2a <pipe>:
  803d2a:	55                   	push   %rbp
  803d2b:	48 89 e5             	mov    %rsp,%rbp
  803d2e:	53                   	push   %rbx
  803d2f:	48 83 ec 38          	sub    $0x38,%rsp
  803d33:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803d37:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803d3b:	48 89 c7             	mov    %rax,%rdi
  803d3e:	48 b8 41 25 80 00 00 	movabs $0x802541,%rax
  803d45:	00 00 00 
  803d48:	ff d0                	callq  *%rax
  803d4a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d4d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d51:	0f 88 bf 01 00 00    	js     803f16 <pipe+0x1ec>
  803d57:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d5b:	ba 07 04 00 00       	mov    $0x407,%edx
  803d60:	48 89 c6             	mov    %rax,%rsi
  803d63:	bf 00 00 00 00       	mov    $0x0,%edi
  803d68:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  803d6f:	00 00 00 
  803d72:	ff d0                	callq  *%rax
  803d74:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d77:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d7b:	0f 88 95 01 00 00    	js     803f16 <pipe+0x1ec>
  803d81:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803d85:	48 89 c7             	mov    %rax,%rdi
  803d88:	48 b8 41 25 80 00 00 	movabs $0x802541,%rax
  803d8f:	00 00 00 
  803d92:	ff d0                	callq  *%rax
  803d94:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d97:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d9b:	0f 88 5d 01 00 00    	js     803efe <pipe+0x1d4>
  803da1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803da5:	ba 07 04 00 00       	mov    $0x407,%edx
  803daa:	48 89 c6             	mov    %rax,%rsi
  803dad:	bf 00 00 00 00       	mov    $0x0,%edi
  803db2:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  803db9:	00 00 00 
  803dbc:	ff d0                	callq  *%rax
  803dbe:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803dc1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803dc5:	0f 88 33 01 00 00    	js     803efe <pipe+0x1d4>
  803dcb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803dcf:	48 89 c7             	mov    %rax,%rdi
  803dd2:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  803dd9:	00 00 00 
  803ddc:	ff d0                	callq  *%rax
  803dde:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803de2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803de6:	ba 07 04 00 00       	mov    $0x407,%edx
  803deb:	48 89 c6             	mov    %rax,%rsi
  803dee:	bf 00 00 00 00       	mov    $0x0,%edi
  803df3:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  803dfa:	00 00 00 
  803dfd:	ff d0                	callq  *%rax
  803dff:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e02:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e06:	79 05                	jns    803e0d <pipe+0xe3>
  803e08:	e9 d9 00 00 00       	jmpq   803ee6 <pipe+0x1bc>
  803e0d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e11:	48 89 c7             	mov    %rax,%rdi
  803e14:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  803e1b:	00 00 00 
  803e1e:	ff d0                	callq  *%rax
  803e20:	48 89 c2             	mov    %rax,%rdx
  803e23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e27:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803e2d:	48 89 d1             	mov    %rdx,%rcx
  803e30:	ba 00 00 00 00       	mov    $0x0,%edx
  803e35:	48 89 c6             	mov    %rax,%rsi
  803e38:	bf 00 00 00 00       	mov    $0x0,%edi
  803e3d:	48 b8 4e 1b 80 00 00 	movabs $0x801b4e,%rax
  803e44:	00 00 00 
  803e47:	ff d0                	callq  *%rax
  803e49:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e4c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e50:	79 1b                	jns    803e6d <pipe+0x143>
  803e52:	90                   	nop
  803e53:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e57:	48 89 c6             	mov    %rax,%rsi
  803e5a:	bf 00 00 00 00       	mov    $0x0,%edi
  803e5f:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  803e66:	00 00 00 
  803e69:	ff d0                	callq  *%rax
  803e6b:	eb 79                	jmp    803ee6 <pipe+0x1bc>
  803e6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e71:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803e78:	00 00 00 
  803e7b:	8b 12                	mov    (%rdx),%edx
  803e7d:	89 10                	mov    %edx,(%rax)
  803e7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e83:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803e8a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e8e:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803e95:	00 00 00 
  803e98:	8b 12                	mov    (%rdx),%edx
  803e9a:	89 10                	mov    %edx,(%rax)
  803e9c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ea0:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803ea7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803eab:	48 89 c7             	mov    %rax,%rdi
  803eae:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  803eb5:	00 00 00 
  803eb8:	ff d0                	callq  *%rax
  803eba:	89 c2                	mov    %eax,%edx
  803ebc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803ec0:	89 10                	mov    %edx,(%rax)
  803ec2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803ec6:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803eca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ece:	48 89 c7             	mov    %rax,%rdi
  803ed1:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  803ed8:	00 00 00 
  803edb:	ff d0                	callq  *%rax
  803edd:	89 03                	mov    %eax,(%rbx)
  803edf:	b8 00 00 00 00       	mov    $0x0,%eax
  803ee4:	eb 33                	jmp    803f19 <pipe+0x1ef>
  803ee6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803eea:	48 89 c6             	mov    %rax,%rsi
  803eed:	bf 00 00 00 00       	mov    $0x0,%edi
  803ef2:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  803ef9:	00 00 00 
  803efc:	ff d0                	callq  *%rax
  803efe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f02:	48 89 c6             	mov    %rax,%rsi
  803f05:	bf 00 00 00 00       	mov    $0x0,%edi
  803f0a:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  803f11:	00 00 00 
  803f14:	ff d0                	callq  *%rax
  803f16:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f19:	48 83 c4 38          	add    $0x38,%rsp
  803f1d:	5b                   	pop    %rbx
  803f1e:	5d                   	pop    %rbp
  803f1f:	c3                   	retq   

0000000000803f20 <_pipeisclosed>:
  803f20:	55                   	push   %rbp
  803f21:	48 89 e5             	mov    %rsp,%rbp
  803f24:	53                   	push   %rbx
  803f25:	48 83 ec 28          	sub    $0x28,%rsp
  803f29:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803f2d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803f31:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  803f38:	00 00 00 
  803f3b:	48 8b 00             	mov    (%rax),%rax
  803f3e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f44:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f47:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f4b:	48 89 c7             	mov    %rax,%rdi
  803f4e:	48 b8 a1 49 80 00 00 	movabs $0x8049a1,%rax
  803f55:	00 00 00 
  803f58:	ff d0                	callq  *%rax
  803f5a:	89 c3                	mov    %eax,%ebx
  803f5c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f60:	48 89 c7             	mov    %rax,%rdi
  803f63:	48 b8 a1 49 80 00 00 	movabs $0x8049a1,%rax
  803f6a:	00 00 00 
  803f6d:	ff d0                	callq  *%rax
  803f6f:	39 c3                	cmp    %eax,%ebx
  803f71:	0f 94 c0             	sete   %al
  803f74:	0f b6 c0             	movzbl %al,%eax
  803f77:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803f7a:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  803f81:	00 00 00 
  803f84:	48 8b 00             	mov    (%rax),%rax
  803f87:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f8d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803f90:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f93:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803f96:	75 05                	jne    803f9d <_pipeisclosed+0x7d>
  803f98:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803f9b:	eb 4f                	jmp    803fec <_pipeisclosed+0xcc>
  803f9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fa0:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803fa3:	74 42                	je     803fe7 <_pipeisclosed+0xc7>
  803fa5:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803fa9:	75 3c                	jne    803fe7 <_pipeisclosed+0xc7>
  803fab:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  803fb2:	00 00 00 
  803fb5:	48 8b 00             	mov    (%rax),%rax
  803fb8:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803fbe:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803fc1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fc4:	89 c6                	mov    %eax,%esi
  803fc6:	48 bf 1b 53 80 00 00 	movabs $0x80531b,%rdi
  803fcd:	00 00 00 
  803fd0:	b8 00 00 00 00       	mov    $0x0,%eax
  803fd5:	49 b8 1a 06 80 00 00 	movabs $0x80061a,%r8
  803fdc:	00 00 00 
  803fdf:	41 ff d0             	callq  *%r8
  803fe2:	e9 4a ff ff ff       	jmpq   803f31 <_pipeisclosed+0x11>
  803fe7:	e9 45 ff ff ff       	jmpq   803f31 <_pipeisclosed+0x11>
  803fec:	48 83 c4 28          	add    $0x28,%rsp
  803ff0:	5b                   	pop    %rbx
  803ff1:	5d                   	pop    %rbp
  803ff2:	c3                   	retq   

0000000000803ff3 <pipeisclosed>:
  803ff3:	55                   	push   %rbp
  803ff4:	48 89 e5             	mov    %rsp,%rbp
  803ff7:	48 83 ec 30          	sub    $0x30,%rsp
  803ffb:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803ffe:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  804002:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804005:	48 89 d6             	mov    %rdx,%rsi
  804008:	89 c7                	mov    %eax,%edi
  80400a:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  804011:	00 00 00 
  804014:	ff d0                	callq  *%rax
  804016:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804019:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80401d:	79 05                	jns    804024 <pipeisclosed+0x31>
  80401f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804022:	eb 31                	jmp    804055 <pipeisclosed+0x62>
  804024:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804028:	48 89 c7             	mov    %rax,%rdi
  80402b:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  804032:	00 00 00 
  804035:	ff d0                	callq  *%rax
  804037:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80403b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80403f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804043:	48 89 d6             	mov    %rdx,%rsi
  804046:	48 89 c7             	mov    %rax,%rdi
  804049:	48 b8 20 3f 80 00 00 	movabs $0x803f20,%rax
  804050:	00 00 00 
  804053:	ff d0                	callq  *%rax
  804055:	c9                   	leaveq 
  804056:	c3                   	retq   

0000000000804057 <devpipe_read>:
  804057:	55                   	push   %rbp
  804058:	48 89 e5             	mov    %rsp,%rbp
  80405b:	48 83 ec 40          	sub    $0x40,%rsp
  80405f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804063:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804067:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80406b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80406f:	48 89 c7             	mov    %rax,%rdi
  804072:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  804079:	00 00 00 
  80407c:	ff d0                	callq  *%rax
  80407e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804082:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804086:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80408a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804091:	00 
  804092:	e9 92 00 00 00       	jmpq   804129 <devpipe_read+0xd2>
  804097:	eb 41                	jmp    8040da <devpipe_read+0x83>
  804099:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80409e:	74 09                	je     8040a9 <devpipe_read+0x52>
  8040a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040a4:	e9 92 00 00 00       	jmpq   80413b <devpipe_read+0xe4>
  8040a9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8040ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040b1:	48 89 d6             	mov    %rdx,%rsi
  8040b4:	48 89 c7             	mov    %rax,%rdi
  8040b7:	48 b8 20 3f 80 00 00 	movabs $0x803f20,%rax
  8040be:	00 00 00 
  8040c1:	ff d0                	callq  *%rax
  8040c3:	85 c0                	test   %eax,%eax
  8040c5:	74 07                	je     8040ce <devpipe_read+0x77>
  8040c7:	b8 00 00 00 00       	mov    $0x0,%eax
  8040cc:	eb 6d                	jmp    80413b <devpipe_read+0xe4>
  8040ce:	48 b8 c0 1a 80 00 00 	movabs $0x801ac0,%rax
  8040d5:	00 00 00 
  8040d8:	ff d0                	callq  *%rax
  8040da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040de:	8b 10                	mov    (%rax),%edx
  8040e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040e4:	8b 40 04             	mov    0x4(%rax),%eax
  8040e7:	39 c2                	cmp    %eax,%edx
  8040e9:	74 ae                	je     804099 <devpipe_read+0x42>
  8040eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040ef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8040f3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8040f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040fb:	8b 00                	mov    (%rax),%eax
  8040fd:	99                   	cltd   
  8040fe:	c1 ea 1b             	shr    $0x1b,%edx
  804101:	01 d0                	add    %edx,%eax
  804103:	83 e0 1f             	and    $0x1f,%eax
  804106:	29 d0                	sub    %edx,%eax
  804108:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80410c:	48 98                	cltq   
  80410e:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  804113:	88 01                	mov    %al,(%rcx)
  804115:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804119:	8b 00                	mov    (%rax),%eax
  80411b:	8d 50 01             	lea    0x1(%rax),%edx
  80411e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804122:	89 10                	mov    %edx,(%rax)
  804124:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80412d:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804131:	0f 82 60 ff ff ff    	jb     804097 <devpipe_read+0x40>
  804137:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80413b:	c9                   	leaveq 
  80413c:	c3                   	retq   

000000000080413d <devpipe_write>:
  80413d:	55                   	push   %rbp
  80413e:	48 89 e5             	mov    %rsp,%rbp
  804141:	48 83 ec 40          	sub    $0x40,%rsp
  804145:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804149:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80414d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804151:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804155:	48 89 c7             	mov    %rax,%rdi
  804158:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  80415f:	00 00 00 
  804162:	ff d0                	callq  *%rax
  804164:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804168:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80416c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804170:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804177:	00 
  804178:	e9 8e 00 00 00       	jmpq   80420b <devpipe_write+0xce>
  80417d:	eb 31                	jmp    8041b0 <devpipe_write+0x73>
  80417f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804183:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804187:	48 89 d6             	mov    %rdx,%rsi
  80418a:	48 89 c7             	mov    %rax,%rdi
  80418d:	48 b8 20 3f 80 00 00 	movabs $0x803f20,%rax
  804194:	00 00 00 
  804197:	ff d0                	callq  *%rax
  804199:	85 c0                	test   %eax,%eax
  80419b:	74 07                	je     8041a4 <devpipe_write+0x67>
  80419d:	b8 00 00 00 00       	mov    $0x0,%eax
  8041a2:	eb 79                	jmp    80421d <devpipe_write+0xe0>
  8041a4:	48 b8 c0 1a 80 00 00 	movabs $0x801ac0,%rax
  8041ab:	00 00 00 
  8041ae:	ff d0                	callq  *%rax
  8041b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041b4:	8b 40 04             	mov    0x4(%rax),%eax
  8041b7:	48 63 d0             	movslq %eax,%rdx
  8041ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041be:	8b 00                	mov    (%rax),%eax
  8041c0:	48 98                	cltq   
  8041c2:	48 83 c0 20          	add    $0x20,%rax
  8041c6:	48 39 c2             	cmp    %rax,%rdx
  8041c9:	73 b4                	jae    80417f <devpipe_write+0x42>
  8041cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041cf:	8b 40 04             	mov    0x4(%rax),%eax
  8041d2:	99                   	cltd   
  8041d3:	c1 ea 1b             	shr    $0x1b,%edx
  8041d6:	01 d0                	add    %edx,%eax
  8041d8:	83 e0 1f             	and    $0x1f,%eax
  8041db:	29 d0                	sub    %edx,%eax
  8041dd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8041e1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8041e5:	48 01 ca             	add    %rcx,%rdx
  8041e8:	0f b6 0a             	movzbl (%rdx),%ecx
  8041eb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8041ef:	48 98                	cltq   
  8041f1:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8041f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041f9:	8b 40 04             	mov    0x4(%rax),%eax
  8041fc:	8d 50 01             	lea    0x1(%rax),%edx
  8041ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804203:	89 50 04             	mov    %edx,0x4(%rax)
  804206:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80420b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80420f:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804213:	0f 82 64 ff ff ff    	jb     80417d <devpipe_write+0x40>
  804219:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80421d:	c9                   	leaveq 
  80421e:	c3                   	retq   

000000000080421f <devpipe_stat>:
  80421f:	55                   	push   %rbp
  804220:	48 89 e5             	mov    %rsp,%rbp
  804223:	48 83 ec 20          	sub    $0x20,%rsp
  804227:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80422b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80422f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804233:	48 89 c7             	mov    %rax,%rdi
  804236:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  80423d:	00 00 00 
  804240:	ff d0                	callq  *%rax
  804242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804246:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80424a:	48 be 2e 53 80 00 00 	movabs $0x80532e,%rsi
  804251:	00 00 00 
  804254:	48 89 c7             	mov    %rax,%rdi
  804257:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  80425e:	00 00 00 
  804261:	ff d0                	callq  *%rax
  804263:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804267:	8b 50 04             	mov    0x4(%rax),%edx
  80426a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80426e:	8b 00                	mov    (%rax),%eax
  804270:	29 c2                	sub    %eax,%edx
  804272:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804276:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80427c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804280:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804287:	00 00 00 
  80428a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80428e:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804295:	00 00 00 
  804298:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  80429f:	b8 00 00 00 00       	mov    $0x0,%eax
  8042a4:	c9                   	leaveq 
  8042a5:	c3                   	retq   

00000000008042a6 <devpipe_close>:
  8042a6:	55                   	push   %rbp
  8042a7:	48 89 e5             	mov    %rsp,%rbp
  8042aa:	48 83 ec 10          	sub    $0x10,%rsp
  8042ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8042b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042b6:	48 89 c6             	mov    %rax,%rsi
  8042b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8042be:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  8042c5:	00 00 00 
  8042c8:	ff d0                	callq  *%rax
  8042ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042ce:	48 89 c7             	mov    %rax,%rdi
  8042d1:	48 b8 16 25 80 00 00 	movabs $0x802516,%rax
  8042d8:	00 00 00 
  8042db:	ff d0                	callq  *%rax
  8042dd:	48 89 c6             	mov    %rax,%rsi
  8042e0:	bf 00 00 00 00       	mov    $0x0,%edi
  8042e5:	48 b8 a9 1b 80 00 00 	movabs $0x801ba9,%rax
  8042ec:	00 00 00 
  8042ef:	ff d0                	callq  *%rax
  8042f1:	c9                   	leaveq 
  8042f2:	c3                   	retq   

00000000008042f3 <wait>:
  8042f3:	55                   	push   %rbp
  8042f4:	48 89 e5             	mov    %rsp,%rbp
  8042f7:	48 83 ec 20          	sub    $0x20,%rsp
  8042fb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8042fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804302:	75 35                	jne    804339 <wait+0x46>
  804304:	48 b9 35 53 80 00 00 	movabs $0x805335,%rcx
  80430b:	00 00 00 
  80430e:	48 ba 40 53 80 00 00 	movabs $0x805340,%rdx
  804315:	00 00 00 
  804318:	be 0a 00 00 00       	mov    $0xa,%esi
  80431d:	48 bf 55 53 80 00 00 	movabs $0x805355,%rdi
  804324:	00 00 00 
  804327:	b8 00 00 00 00       	mov    $0x0,%eax
  80432c:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  804333:	00 00 00 
  804336:	41 ff d0             	callq  *%r8
  804339:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80433c:	25 ff 03 00 00       	and    $0x3ff,%eax
  804341:	48 98                	cltq   
  804343:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80434a:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804351:	00 00 00 
  804354:	48 01 d0             	add    %rdx,%rax
  804357:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80435b:	eb 0c                	jmp    804369 <wait+0x76>
  80435d:	48 b8 c0 1a 80 00 00 	movabs $0x801ac0,%rax
  804364:	00 00 00 
  804367:	ff d0                	callq  *%rax
  804369:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80436d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804373:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804376:	75 0e                	jne    804386 <wait+0x93>
  804378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80437c:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  804382:	85 c0                	test   %eax,%eax
  804384:	75 d7                	jne    80435d <wait+0x6a>
  804386:	c9                   	leaveq 
  804387:	c3                   	retq   

0000000000804388 <cputchar>:
  804388:	55                   	push   %rbp
  804389:	48 89 e5             	mov    %rsp,%rbp
  80438c:	48 83 ec 20          	sub    $0x20,%rsp
  804390:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804393:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804396:	88 45 ff             	mov    %al,-0x1(%rbp)
  804399:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  80439d:	be 01 00 00 00       	mov    $0x1,%esi
  8043a2:	48 89 c7             	mov    %rax,%rdi
  8043a5:	48 b8 b6 19 80 00 00 	movabs $0x8019b6,%rax
  8043ac:	00 00 00 
  8043af:	ff d0                	callq  *%rax
  8043b1:	c9                   	leaveq 
  8043b2:	c3                   	retq   

00000000008043b3 <getchar>:
  8043b3:	55                   	push   %rbp
  8043b4:	48 89 e5             	mov    %rsp,%rbp
  8043b7:	48 83 ec 10          	sub    $0x10,%rsp
  8043bb:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8043bf:	ba 01 00 00 00       	mov    $0x1,%edx
  8043c4:	48 89 c6             	mov    %rax,%rsi
  8043c7:	bf 00 00 00 00       	mov    $0x0,%edi
  8043cc:	48 b8 0b 2a 80 00 00 	movabs $0x802a0b,%rax
  8043d3:	00 00 00 
  8043d6:	ff d0                	callq  *%rax
  8043d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8043db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8043df:	79 05                	jns    8043e6 <getchar+0x33>
  8043e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8043e4:	eb 14                	jmp    8043fa <getchar+0x47>
  8043e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8043ea:	7f 07                	jg     8043f3 <getchar+0x40>
  8043ec:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  8043f1:	eb 07                	jmp    8043fa <getchar+0x47>
  8043f3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8043f7:	0f b6 c0             	movzbl %al,%eax
  8043fa:	c9                   	leaveq 
  8043fb:	c3                   	retq   

00000000008043fc <iscons>:
  8043fc:	55                   	push   %rbp
  8043fd:	48 89 e5             	mov    %rsp,%rbp
  804400:	48 83 ec 20          	sub    $0x20,%rsp
  804404:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804407:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80440b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80440e:	48 89 d6             	mov    %rdx,%rsi
  804411:	89 c7                	mov    %eax,%edi
  804413:	48 b8 d9 25 80 00 00 	movabs $0x8025d9,%rax
  80441a:	00 00 00 
  80441d:	ff d0                	callq  *%rax
  80441f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804422:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804426:	79 05                	jns    80442d <iscons+0x31>
  804428:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80442b:	eb 1a                	jmp    804447 <iscons+0x4b>
  80442d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804431:	8b 10                	mov    (%rax),%edx
  804433:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  80443a:	00 00 00 
  80443d:	8b 00                	mov    (%rax),%eax
  80443f:	39 c2                	cmp    %eax,%edx
  804441:	0f 94 c0             	sete   %al
  804444:	0f b6 c0             	movzbl %al,%eax
  804447:	c9                   	leaveq 
  804448:	c3                   	retq   

0000000000804449 <opencons>:
  804449:	55                   	push   %rbp
  80444a:	48 89 e5             	mov    %rsp,%rbp
  80444d:	48 83 ec 10          	sub    $0x10,%rsp
  804451:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804455:	48 89 c7             	mov    %rax,%rdi
  804458:	48 b8 41 25 80 00 00 	movabs $0x802541,%rax
  80445f:	00 00 00 
  804462:	ff d0                	callq  *%rax
  804464:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804467:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80446b:	79 05                	jns    804472 <opencons+0x29>
  80446d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804470:	eb 5b                	jmp    8044cd <opencons+0x84>
  804472:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804476:	ba 07 04 00 00       	mov    $0x407,%edx
  80447b:	48 89 c6             	mov    %rax,%rsi
  80447e:	bf 00 00 00 00       	mov    $0x0,%edi
  804483:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  80448a:	00 00 00 
  80448d:	ff d0                	callq  *%rax
  80448f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804492:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804496:	79 05                	jns    80449d <opencons+0x54>
  804498:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80449b:	eb 30                	jmp    8044cd <opencons+0x84>
  80449d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044a1:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8044a8:	00 00 00 
  8044ab:	8b 12                	mov    (%rdx),%edx
  8044ad:	89 10                	mov    %edx,(%rax)
  8044af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044b3:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8044ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044be:	48 89 c7             	mov    %rax,%rdi
  8044c1:	48 b8 f3 24 80 00 00 	movabs $0x8024f3,%rax
  8044c8:	00 00 00 
  8044cb:	ff d0                	callq  *%rax
  8044cd:	c9                   	leaveq 
  8044ce:	c3                   	retq   

00000000008044cf <devcons_read>:
  8044cf:	55                   	push   %rbp
  8044d0:	48 89 e5             	mov    %rsp,%rbp
  8044d3:	48 83 ec 30          	sub    $0x30,%rsp
  8044d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8044db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8044df:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8044e3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8044e8:	75 07                	jne    8044f1 <devcons_read+0x22>
  8044ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8044ef:	eb 4b                	jmp    80453c <devcons_read+0x6d>
  8044f1:	eb 0c                	jmp    8044ff <devcons_read+0x30>
  8044f3:	48 b8 c0 1a 80 00 00 	movabs $0x801ac0,%rax
  8044fa:	00 00 00 
  8044fd:	ff d0                	callq  *%rax
  8044ff:	48 b8 00 1a 80 00 00 	movabs $0x801a00,%rax
  804506:	00 00 00 
  804509:	ff d0                	callq  *%rax
  80450b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80450e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804512:	74 df                	je     8044f3 <devcons_read+0x24>
  804514:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804518:	79 05                	jns    80451f <devcons_read+0x50>
  80451a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80451d:	eb 1d                	jmp    80453c <devcons_read+0x6d>
  80451f:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804523:	75 07                	jne    80452c <devcons_read+0x5d>
  804525:	b8 00 00 00 00       	mov    $0x0,%eax
  80452a:	eb 10                	jmp    80453c <devcons_read+0x6d>
  80452c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80452f:	89 c2                	mov    %eax,%edx
  804531:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804535:	88 10                	mov    %dl,(%rax)
  804537:	b8 01 00 00 00       	mov    $0x1,%eax
  80453c:	c9                   	leaveq 
  80453d:	c3                   	retq   

000000000080453e <devcons_write>:
  80453e:	55                   	push   %rbp
  80453f:	48 89 e5             	mov    %rsp,%rbp
  804542:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804549:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804550:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804557:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80455e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804565:	eb 76                	jmp    8045dd <devcons_write+0x9f>
  804567:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80456e:	89 c2                	mov    %eax,%edx
  804570:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804573:	29 c2                	sub    %eax,%edx
  804575:	89 d0                	mov    %edx,%eax
  804577:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80457a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80457d:	83 f8 7f             	cmp    $0x7f,%eax
  804580:	76 07                	jbe    804589 <devcons_write+0x4b>
  804582:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804589:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80458c:	48 63 d0             	movslq %eax,%rdx
  80458f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804592:	48 63 c8             	movslq %eax,%rcx
  804595:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  80459c:	48 01 c1             	add    %rax,%rcx
  80459f:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8045a6:	48 89 ce             	mov    %rcx,%rsi
  8045a9:	48 89 c7             	mov    %rax,%rdi
  8045ac:	48 b8 f3 14 80 00 00 	movabs $0x8014f3,%rax
  8045b3:	00 00 00 
  8045b6:	ff d0                	callq  *%rax
  8045b8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045bb:	48 63 d0             	movslq %eax,%rdx
  8045be:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8045c5:	48 89 d6             	mov    %rdx,%rsi
  8045c8:	48 89 c7             	mov    %rax,%rdi
  8045cb:	48 b8 b6 19 80 00 00 	movabs $0x8019b6,%rax
  8045d2:	00 00 00 
  8045d5:	ff d0                	callq  *%rax
  8045d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045da:	01 45 fc             	add    %eax,-0x4(%rbp)
  8045dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045e0:	48 98                	cltq   
  8045e2:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  8045e9:	0f 82 78 ff ff ff    	jb     804567 <devcons_write+0x29>
  8045ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045f2:	c9                   	leaveq 
  8045f3:	c3                   	retq   

00000000008045f4 <devcons_close>:
  8045f4:	55                   	push   %rbp
  8045f5:	48 89 e5             	mov    %rsp,%rbp
  8045f8:	48 83 ec 08          	sub    $0x8,%rsp
  8045fc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804600:	b8 00 00 00 00       	mov    $0x0,%eax
  804605:	c9                   	leaveq 
  804606:	c3                   	retq   

0000000000804607 <devcons_stat>:
  804607:	55                   	push   %rbp
  804608:	48 89 e5             	mov    %rsp,%rbp
  80460b:	48 83 ec 10          	sub    $0x10,%rsp
  80460f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804613:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804617:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80461b:	48 be 68 53 80 00 00 	movabs $0x805368,%rsi
  804622:	00 00 00 
  804625:	48 89 c7             	mov    %rax,%rdi
  804628:	48 b8 cf 11 80 00 00 	movabs $0x8011cf,%rax
  80462f:	00 00 00 
  804632:	ff d0                	callq  *%rax
  804634:	b8 00 00 00 00       	mov    $0x0,%eax
  804639:	c9                   	leaveq 
  80463a:	c3                   	retq   

000000000080463b <set_pgfault_handler>:
  80463b:	55                   	push   %rbp
  80463c:	48 89 e5             	mov    %rsp,%rbp
  80463f:	48 83 ec 20          	sub    $0x20,%rsp
  804643:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804647:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80464e:	00 00 00 
  804651:	48 8b 00             	mov    (%rax),%rax
  804654:	48 85 c0             	test   %rax,%rax
  804657:	75 6f                	jne    8046c8 <set_pgfault_handler+0x8d>
  804659:	ba 07 00 00 00       	mov    $0x7,%edx
  80465e:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  804663:	bf 00 00 00 00       	mov    $0x0,%edi
  804668:	48 b8 fe 1a 80 00 00 	movabs $0x801afe,%rax
  80466f:	00 00 00 
  804672:	ff d0                	callq  *%rax
  804674:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804677:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80467b:	79 30                	jns    8046ad <set_pgfault_handler+0x72>
  80467d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804680:	89 c1                	mov    %eax,%ecx
  804682:	48 ba 70 53 80 00 00 	movabs $0x805370,%rdx
  804689:	00 00 00 
  80468c:	be 22 00 00 00       	mov    $0x22,%esi
  804691:	48 bf 8f 53 80 00 00 	movabs $0x80538f,%rdi
  804698:	00 00 00 
  80469b:	b8 00 00 00 00       	mov    $0x0,%eax
  8046a0:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8046a7:	00 00 00 
  8046aa:	41 ff d0             	callq  *%r8
  8046ad:	48 be db 46 80 00 00 	movabs $0x8046db,%rsi
  8046b4:	00 00 00 
  8046b7:	bf 00 00 00 00       	mov    $0x0,%edi
  8046bc:	48 b8 88 1c 80 00 00 	movabs $0x801c88,%rax
  8046c3:	00 00 00 
  8046c6:	ff d0                	callq  *%rax
  8046c8:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8046cf:	00 00 00 
  8046d2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8046d6:	48 89 10             	mov    %rdx,(%rax)
  8046d9:	c9                   	leaveq 
  8046da:	c3                   	retq   

00000000008046db <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  8046db:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  8046de:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  8046e5:	00 00 00 
call *%rax
  8046e8:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  8046ea:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  8046f1:	00 08 
    movq 152(%rsp), %rax
  8046f3:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  8046fa:	00 
    movq 136(%rsp), %rbx
  8046fb:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804702:	00 
movq %rbx, (%rax)
  804703:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804706:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80470a:	4c 8b 3c 24          	mov    (%rsp),%r15
  80470e:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804713:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  804718:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  80471d:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804722:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  804727:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  80472c:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804731:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  804736:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  80473b:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804740:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804745:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  80474a:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  80474f:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  804754:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  804758:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  80475c:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  80475d:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  804762:	c3                   	retq   

0000000000804763 <ipc_recv>:
  804763:	55                   	push   %rbp
  804764:	48 89 e5             	mov    %rsp,%rbp
  804767:	48 83 ec 30          	sub    $0x30,%rsp
  80476b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80476f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804773:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804777:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80477c:	75 0e                	jne    80478c <ipc_recv+0x29>
  80477e:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804785:	00 00 00 
  804788:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80478c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804790:	48 89 c7             	mov    %rax,%rdi
  804793:	48 b8 27 1d 80 00 00 	movabs $0x801d27,%rax
  80479a:	00 00 00 
  80479d:	ff d0                	callq  *%rax
  80479f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8047a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047a6:	79 27                	jns    8047cf <ipc_recv+0x6c>
  8047a8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8047ad:	74 0a                	je     8047b9 <ipc_recv+0x56>
  8047af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047b3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8047b9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8047be:	74 0a                	je     8047ca <ipc_recv+0x67>
  8047c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047c4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8047ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047cd:	eb 53                	jmp    804822 <ipc_recv+0xbf>
  8047cf:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8047d4:	74 19                	je     8047ef <ipc_recv+0x8c>
  8047d6:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8047dd:	00 00 00 
  8047e0:	48 8b 00             	mov    (%rax),%rax
  8047e3:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8047e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047ed:	89 10                	mov    %edx,(%rax)
  8047ef:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8047f4:	74 19                	je     80480f <ipc_recv+0xac>
  8047f6:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8047fd:	00 00 00 
  804800:	48 8b 00             	mov    (%rax),%rax
  804803:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804809:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80480d:	89 10                	mov    %edx,(%rax)
  80480f:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  804816:	00 00 00 
  804819:	48 8b 00             	mov    (%rax),%rax
  80481c:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804822:	c9                   	leaveq 
  804823:	c3                   	retq   

0000000000804824 <ipc_send>:
  804824:	55                   	push   %rbp
  804825:	48 89 e5             	mov    %rsp,%rbp
  804828:	48 83 ec 30          	sub    $0x30,%rsp
  80482c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80482f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804832:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804836:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804839:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80483e:	75 10                	jne    804850 <ipc_send+0x2c>
  804840:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804847:	00 00 00 
  80484a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80484e:	eb 0e                	jmp    80485e <ipc_send+0x3a>
  804850:	eb 0c                	jmp    80485e <ipc_send+0x3a>
  804852:	48 b8 c0 1a 80 00 00 	movabs $0x801ac0,%rax
  804859:	00 00 00 
  80485c:	ff d0                	callq  *%rax
  80485e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  804861:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  804864:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804868:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80486b:	89 c7                	mov    %eax,%edi
  80486d:	48 b8 d2 1c 80 00 00 	movabs $0x801cd2,%rax
  804874:	00 00 00 
  804877:	ff d0                	callq  *%rax
  804879:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80487c:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804880:	74 d0                	je     804852 <ipc_send+0x2e>
  804882:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804886:	79 30                	jns    8048b8 <ipc_send+0x94>
  804888:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80488b:	89 c1                	mov    %eax,%ecx
  80488d:	48 ba a0 53 80 00 00 	movabs $0x8053a0,%rdx
  804894:	00 00 00 
  804897:	be 44 00 00 00       	mov    $0x44,%esi
  80489c:	48 bf b6 53 80 00 00 	movabs $0x8053b6,%rdi
  8048a3:	00 00 00 
  8048a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8048ab:	49 b8 e1 03 80 00 00 	movabs $0x8003e1,%r8
  8048b2:	00 00 00 
  8048b5:	41 ff d0             	callq  *%r8
  8048b8:	c9                   	leaveq 
  8048b9:	c3                   	retq   

00000000008048ba <ipc_host_recv>:
  8048ba:	55                   	push   %rbp
  8048bb:	48 89 e5             	mov    %rsp,%rbp
  8048be:	48 83 ec 10          	sub    $0x10,%rsp
  8048c2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8048c6:	48 ba c8 53 80 00 00 	movabs $0x8053c8,%rdx
  8048cd:	00 00 00 
  8048d0:	be 4e 00 00 00       	mov    $0x4e,%esi
  8048d5:	48 bf b6 53 80 00 00 	movabs $0x8053b6,%rdi
  8048dc:	00 00 00 
  8048df:	b8 00 00 00 00       	mov    $0x0,%eax
  8048e4:	48 b9 e1 03 80 00 00 	movabs $0x8003e1,%rcx
  8048eb:	00 00 00 
  8048ee:	ff d1                	callq  *%rcx

00000000008048f0 <ipc_host_send>:
  8048f0:	55                   	push   %rbp
  8048f1:	48 89 e5             	mov    %rsp,%rbp
  8048f4:	48 83 ec 20          	sub    $0x20,%rsp
  8048f8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8048fb:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8048fe:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804902:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804905:	48 ba e8 53 80 00 00 	movabs $0x8053e8,%rdx
  80490c:	00 00 00 
  80490f:	be 67 00 00 00       	mov    $0x67,%esi
  804914:	48 bf b6 53 80 00 00 	movabs $0x8053b6,%rdi
  80491b:	00 00 00 
  80491e:	b8 00 00 00 00       	mov    $0x0,%eax
  804923:	48 b9 e1 03 80 00 00 	movabs $0x8003e1,%rcx
  80492a:	00 00 00 
  80492d:	ff d1                	callq  *%rcx

000000000080492f <ipc_find_env>:
  80492f:	55                   	push   %rbp
  804930:	48 89 e5             	mov    %rsp,%rbp
  804933:	48 83 ec 14          	sub    $0x14,%rsp
  804937:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80493a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804941:	eb 4e                	jmp    804991 <ipc_find_env+0x62>
  804943:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80494a:	00 00 00 
  80494d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804950:	48 98                	cltq   
  804952:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804959:	48 01 d0             	add    %rdx,%rax
  80495c:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804962:	8b 00                	mov    (%rax),%eax
  804964:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804967:	75 24                	jne    80498d <ipc_find_env+0x5e>
  804969:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804970:	00 00 00 
  804973:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804976:	48 98                	cltq   
  804978:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80497f:	48 01 d0             	add    %rdx,%rax
  804982:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804988:	8b 40 08             	mov    0x8(%rax),%eax
  80498b:	eb 12                	jmp    80499f <ipc_find_env+0x70>
  80498d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804991:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804998:	7e a9                	jle    804943 <ipc_find_env+0x14>
  80499a:	b8 00 00 00 00       	mov    $0x0,%eax
  80499f:	c9                   	leaveq 
  8049a0:	c3                   	retq   

00000000008049a1 <pageref>:
  8049a1:	55                   	push   %rbp
  8049a2:	48 89 e5             	mov    %rsp,%rbp
  8049a5:	48 83 ec 18          	sub    $0x18,%rsp
  8049a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8049ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049b1:	48 c1 e8 15          	shr    $0x15,%rax
  8049b5:	48 89 c2             	mov    %rax,%rdx
  8049b8:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8049bf:	01 00 00 
  8049c2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8049c6:	83 e0 01             	and    $0x1,%eax
  8049c9:	48 85 c0             	test   %rax,%rax
  8049cc:	75 07                	jne    8049d5 <pageref+0x34>
  8049ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8049d3:	eb 53                	jmp    804a28 <pageref+0x87>
  8049d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049d9:	48 c1 e8 0c          	shr    $0xc,%rax
  8049dd:	48 89 c2             	mov    %rax,%rdx
  8049e0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8049e7:	01 00 00 
  8049ea:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8049ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8049f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049f6:	83 e0 01             	and    $0x1,%eax
  8049f9:	48 85 c0             	test   %rax,%rax
  8049fc:	75 07                	jne    804a05 <pageref+0x64>
  8049fe:	b8 00 00 00 00       	mov    $0x0,%eax
  804a03:	eb 23                	jmp    804a28 <pageref+0x87>
  804a05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a09:	48 c1 e8 0c          	shr    $0xc,%rax
  804a0d:	48 89 c2             	mov    %rax,%rdx
  804a10:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804a17:	00 00 00 
  804a1a:	48 c1 e2 04          	shl    $0x4,%rdx
  804a1e:	48 01 d0             	add    %rdx,%rax
  804a21:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804a25:	0f b7 c0             	movzwl %ax,%eax
  804a28:	c9                   	leaveq 
  804a29:	c3                   	retq   
