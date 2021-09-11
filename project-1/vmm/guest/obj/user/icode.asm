
vmm/guest/obj/user/icode:     file format elf64-x86-64


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
  80003c:	e8 21 02 00 00       	callq  800262 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	53                   	push   %rbx
  800048:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
  80004f:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
  800055:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
  80005c:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800063:	00 00 00 
  800066:	48 bb 00 4d 80 00 00 	movabs $0x804d00,%rbx
  80006d:	00 00 00 
  800070:	48 89 18             	mov    %rbx,(%rax)
  800073:	48 bf 06 4d 80 00 00 	movabs $0x804d06,%rdi
  80007a:	00 00 00 
  80007d:	b8 00 00 00 00       	mov    $0x0,%eax
  800082:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800089:	00 00 00 
  80008c:	ff d2                	callq  *%rdx
  80008e:	48 bf 15 4d 80 00 00 	movabs $0x804d15,%rdi
  800095:	00 00 00 
  800098:	b8 00 00 00 00       	mov    $0x0,%eax
  80009d:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  8000a4:	00 00 00 
  8000a7:	ff d2                	callq  *%rdx
  8000a9:	be 00 00 00 00       	mov    $0x0,%esi
  8000ae:	48 bf 28 4d 80 00 00 	movabs $0x804d28,%rdi
  8000b5:	00 00 00 
  8000b8:	48 b8 f3 27 80 00 00 	movabs $0x8027f3,%rax
  8000bf:	00 00 00 
  8000c2:	ff d0                	callq  *%rax
  8000c4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8000c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8000cb:	79 30                	jns    8000fd <umain+0xba>
  8000cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8000d0:	89 c1                	mov    %eax,%ecx
  8000d2:	48 ba 34 4d 80 00 00 	movabs $0x804d34,%rdx
  8000d9:	00 00 00 
  8000dc:	be 1a 00 00 00       	mov    $0x1a,%esi
  8000e1:	48 bf 4a 4d 80 00 00 	movabs $0x804d4a,%rdi
  8000e8:	00 00 00 
  8000eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8000f0:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  8000f7:	00 00 00 
  8000fa:	41 ff d0             	callq  *%r8
  8000fd:	48 bf 5a 4d 80 00 00 	movabs $0x804d5a,%rdi
  800104:	00 00 00 
  800107:	b8 00 00 00 00       	mov    $0x0,%eax
  80010c:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800113:	00 00 00 
  800116:	ff d2                	callq  *%rdx
  800118:	eb 3a                	jmp    800154 <umain+0x111>
  80011a:	48 bf 6d 4d 80 00 00 	movabs $0x804d6d,%rdi
  800121:	00 00 00 
  800124:	b8 00 00 00 00       	mov    $0x0,%eax
  800129:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800130:	00 00 00 
  800133:	ff d2                	callq  *%rdx
  800135:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800138:	48 63 d0             	movslq %eax,%rdx
  80013b:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
  800142:	48 89 d6             	mov    %rdx,%rsi
  800145:	48 89 c7             	mov    %rax,%rdi
  800148:	48 b8 dd 18 80 00 00 	movabs $0x8018dd,%rax
  80014f:	00 00 00 
  800152:	ff d0                	callq  *%rax
  800154:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
  80015b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80015e:	ba 00 02 00 00       	mov    $0x200,%edx
  800163:	48 89 ce             	mov    %rcx,%rsi
  800166:	89 c7                	mov    %eax,%edi
  800168:	48 b8 1d 23 80 00 00 	movabs $0x80231d,%rax
  80016f:	00 00 00 
  800172:	ff d0                	callq  *%rax
  800174:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800177:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80017b:	7f 9d                	jg     80011a <umain+0xd7>
  80017d:	48 bf 7b 4d 80 00 00 	movabs $0x804d7b,%rdi
  800184:	00 00 00 
  800187:	b8 00 00 00 00       	mov    $0x0,%eax
  80018c:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800193:	00 00 00 
  800196:	ff d2                	callq  *%rdx
  800198:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80019b:	89 c7                	mov    %eax,%edi
  80019d:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  8001a4:	00 00 00 
  8001a7:	ff d0                	callq  *%rax
  8001a9:	48 bf 8f 4d 80 00 00 	movabs $0x804d8f,%rdi
  8001b0:	00 00 00 
  8001b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8001b8:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  8001bf:	00 00 00 
  8001c2:	ff d2                	callq  *%rdx
  8001c4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8001ca:	48 b9 a8 4d 80 00 00 	movabs $0x804da8,%rcx
  8001d1:	00 00 00 
  8001d4:	48 ba b1 4d 80 00 00 	movabs $0x804db1,%rdx
  8001db:	00 00 00 
  8001de:	48 be ba 4d 80 00 00 	movabs $0x804dba,%rsi
  8001e5:	00 00 00 
  8001e8:	48 bf bf 4d 80 00 00 	movabs $0x804dbf,%rdi
  8001ef:	00 00 00 
  8001f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8001f7:	49 b9 83 31 80 00 00 	movabs $0x803183,%r9
  8001fe:	00 00 00 
  800201:	41 ff d1             	callq  *%r9
  800204:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  800207:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80020b:	79 30                	jns    80023d <umain+0x1fa>
  80020d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800210:	89 c1                	mov    %eax,%ecx
  800212:	48 ba ca 4d 80 00 00 	movabs $0x804dca,%rdx
  800219:	00 00 00 
  80021c:	be 28 00 00 00       	mov    $0x28,%esi
  800221:	48 bf 4a 4d 80 00 00 	movabs $0x804d4a,%rdi
  800228:	00 00 00 
  80022b:	b8 00 00 00 00       	mov    $0x0,%eax
  800230:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  800237:	00 00 00 
  80023a:	41 ff d0             	callq  *%r8
  80023d:	48 bf e6 4d 80 00 00 	movabs $0x804de6,%rdi
  800244:	00 00 00 
  800247:	b8 00 00 00 00       	mov    $0x0,%eax
  80024c:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800253:	00 00 00 
  800256:	ff d2                	callq  *%rdx
  800258:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
  80025f:	5b                   	pop    %rbx
  800260:	5d                   	pop    %rbp
  800261:	c3                   	retq   

0000000000800262 <libmain>:
  800262:	55                   	push   %rbp
  800263:	48 89 e5             	mov    %rsp,%rbp
  800266:	48 83 ec 10          	sub    $0x10,%rsp
  80026a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80026d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800271:	48 b8 a9 19 80 00 00 	movabs $0x8019a9,%rax
  800278:	00 00 00 
  80027b:	ff d0                	callq  *%rax
  80027d:	25 ff 03 00 00       	and    $0x3ff,%eax
  800282:	48 98                	cltq   
  800284:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80028b:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800292:	00 00 00 
  800295:	48 01 c2             	add    %rax,%rdx
  800298:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80029f:	00 00 00 
  8002a2:	48 89 10             	mov    %rdx,(%rax)
  8002a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8002a9:	7e 14                	jle    8002bf <libmain+0x5d>
  8002ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002af:	48 8b 10             	mov    (%rax),%rdx
  8002b2:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8002b9:	00 00 00 
  8002bc:	48 89 10             	mov    %rdx,(%rax)
  8002bf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002c6:	48 89 d6             	mov    %rdx,%rsi
  8002c9:	89 c7                	mov    %eax,%edi
  8002cb:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8002d2:	00 00 00 
  8002d5:	ff d0                	callq  *%rax
  8002d7:	48 b8 e5 02 80 00 00 	movabs $0x8002e5,%rax
  8002de:	00 00 00 
  8002e1:	ff d0                	callq  *%rax
  8002e3:	c9                   	leaveq 
  8002e4:	c3                   	retq   

00000000008002e5 <exit>:
  8002e5:	55                   	push   %rbp
  8002e6:	48 89 e5             	mov    %rsp,%rbp
  8002e9:	48 b8 46 21 80 00 00 	movabs $0x802146,%rax
  8002f0:	00 00 00 
  8002f3:	ff d0                	callq  *%rax
  8002f5:	bf 00 00 00 00       	mov    $0x0,%edi
  8002fa:	48 b8 65 19 80 00 00 	movabs $0x801965,%rax
  800301:	00 00 00 
  800304:	ff d0                	callq  *%rax
  800306:	5d                   	pop    %rbp
  800307:	c3                   	retq   

0000000000800308 <_panic>:
  800308:	55                   	push   %rbp
  800309:	48 89 e5             	mov    %rsp,%rbp
  80030c:	53                   	push   %rbx
  80030d:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800314:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  80031b:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800321:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800328:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  80032f:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  800336:	84 c0                	test   %al,%al
  800338:	74 23                	je     80035d <_panic+0x55>
  80033a:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800341:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800345:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800349:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80034d:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800351:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800355:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800359:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80035d:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800364:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80036b:	00 00 00 
  80036e:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800375:	00 00 00 
  800378:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80037c:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800383:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80038a:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800391:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800398:	00 00 00 
  80039b:	48 8b 18             	mov    (%rax),%rbx
  80039e:	48 b8 a9 19 80 00 00 	movabs $0x8019a9,%rax
  8003a5:	00 00 00 
  8003a8:	ff d0                	callq  *%rax
  8003aa:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8003b0:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8003b7:	41 89 c8             	mov    %ecx,%r8d
  8003ba:	48 89 d1             	mov    %rdx,%rcx
  8003bd:	48 89 da             	mov    %rbx,%rdx
  8003c0:	89 c6                	mov    %eax,%esi
  8003c2:	48 bf 00 4e 80 00 00 	movabs $0x804e00,%rdi
  8003c9:	00 00 00 
  8003cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8003d1:	49 b9 41 05 80 00 00 	movabs $0x800541,%r9
  8003d8:	00 00 00 
  8003db:	41 ff d1             	callq  *%r9
  8003de:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8003e5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8003ec:	48 89 d6             	mov    %rdx,%rsi
  8003ef:	48 89 c7             	mov    %rax,%rdi
  8003f2:	48 b8 95 04 80 00 00 	movabs $0x800495,%rax
  8003f9:	00 00 00 
  8003fc:	ff d0                	callq  *%rax
  8003fe:	48 bf 23 4e 80 00 00 	movabs $0x804e23,%rdi
  800405:	00 00 00 
  800408:	b8 00 00 00 00       	mov    $0x0,%eax
  80040d:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  800414:	00 00 00 
  800417:	ff d2                	callq  *%rdx
  800419:	cc                   	int3   
  80041a:	eb fd                	jmp    800419 <_panic+0x111>

000000000080041c <putch>:
  80041c:	55                   	push   %rbp
  80041d:	48 89 e5             	mov    %rsp,%rbp
  800420:	48 83 ec 10          	sub    $0x10,%rsp
  800424:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800427:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80042b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80042f:	8b 00                	mov    (%rax),%eax
  800431:	8d 48 01             	lea    0x1(%rax),%ecx
  800434:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800438:	89 0a                	mov    %ecx,(%rdx)
  80043a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80043d:	89 d1                	mov    %edx,%ecx
  80043f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800443:	48 98                	cltq   
  800445:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800449:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80044d:	8b 00                	mov    (%rax),%eax
  80044f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800454:	75 2c                	jne    800482 <putch+0x66>
  800456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80045a:	8b 00                	mov    (%rax),%eax
  80045c:	48 98                	cltq   
  80045e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800462:	48 83 c2 08          	add    $0x8,%rdx
  800466:	48 89 c6             	mov    %rax,%rsi
  800469:	48 89 d7             	mov    %rdx,%rdi
  80046c:	48 b8 dd 18 80 00 00 	movabs $0x8018dd,%rax
  800473:	00 00 00 
  800476:	ff d0                	callq  *%rax
  800478:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80047c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800486:	8b 40 04             	mov    0x4(%rax),%eax
  800489:	8d 50 01             	lea    0x1(%rax),%edx
  80048c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800490:	89 50 04             	mov    %edx,0x4(%rax)
  800493:	c9                   	leaveq 
  800494:	c3                   	retq   

0000000000800495 <vcprintf>:
  800495:	55                   	push   %rbp
  800496:	48 89 e5             	mov    %rsp,%rbp
  800499:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8004a0:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8004a7:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8004ae:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8004b5:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8004bc:	48 8b 0a             	mov    (%rdx),%rcx
  8004bf:	48 89 08             	mov    %rcx,(%rax)
  8004c2:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8004c6:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8004ca:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8004ce:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8004d2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8004d9:	00 00 00 
  8004dc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8004e3:	00 00 00 
  8004e6:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8004ed:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8004f4:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8004fb:	48 89 c6             	mov    %rax,%rsi
  8004fe:	48 bf 1c 04 80 00 00 	movabs $0x80041c,%rdi
  800505:	00 00 00 
  800508:	48 b8 f4 08 80 00 00 	movabs $0x8008f4,%rax
  80050f:	00 00 00 
  800512:	ff d0                	callq  *%rax
  800514:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  80051a:	48 98                	cltq   
  80051c:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800523:	48 83 c2 08          	add    $0x8,%rdx
  800527:	48 89 c6             	mov    %rax,%rsi
  80052a:	48 89 d7             	mov    %rdx,%rdi
  80052d:	48 b8 dd 18 80 00 00 	movabs $0x8018dd,%rax
  800534:	00 00 00 
  800537:	ff d0                	callq  *%rax
  800539:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  80053f:	c9                   	leaveq 
  800540:	c3                   	retq   

0000000000800541 <cprintf>:
  800541:	55                   	push   %rbp
  800542:	48 89 e5             	mov    %rsp,%rbp
  800545:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  80054c:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800553:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80055a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800561:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800568:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80056f:	84 c0                	test   %al,%al
  800571:	74 20                	je     800593 <cprintf+0x52>
  800573:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800577:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80057b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80057f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800583:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800587:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80058b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80058f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800593:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80059a:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8005a1:	00 00 00 
  8005a4:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8005ab:	00 00 00 
  8005ae:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8005b2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8005b9:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8005c0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8005c7:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8005ce:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8005d5:	48 8b 0a             	mov    (%rdx),%rcx
  8005d8:	48 89 08             	mov    %rcx,(%rax)
  8005db:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8005df:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8005e3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8005e7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8005eb:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8005f2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8005f9:	48 89 d6             	mov    %rdx,%rsi
  8005fc:	48 89 c7             	mov    %rax,%rdi
  8005ff:	48 b8 95 04 80 00 00 	movabs $0x800495,%rax
  800606:	00 00 00 
  800609:	ff d0                	callq  *%rax
  80060b:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800611:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800617:	c9                   	leaveq 
  800618:	c3                   	retq   

0000000000800619 <printnum>:
  800619:	55                   	push   %rbp
  80061a:	48 89 e5             	mov    %rsp,%rbp
  80061d:	53                   	push   %rbx
  80061e:	48 83 ec 38          	sub    $0x38,%rsp
  800622:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800626:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80062a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80062e:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800631:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800635:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800639:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80063c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800640:	77 3b                	ja     80067d <printnum+0x64>
  800642:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800645:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800649:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  80064c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800650:	ba 00 00 00 00       	mov    $0x0,%edx
  800655:	48 f7 f3             	div    %rbx
  800658:	48 89 c2             	mov    %rax,%rdx
  80065b:	8b 7d cc             	mov    -0x34(%rbp),%edi
  80065e:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800661:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800665:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800669:	41 89 f9             	mov    %edi,%r9d
  80066c:	48 89 c7             	mov    %rax,%rdi
  80066f:	48 b8 19 06 80 00 00 	movabs $0x800619,%rax
  800676:	00 00 00 
  800679:	ff d0                	callq  *%rax
  80067b:	eb 1e                	jmp    80069b <printnum+0x82>
  80067d:	eb 12                	jmp    800691 <printnum+0x78>
  80067f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800683:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800686:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80068a:	48 89 ce             	mov    %rcx,%rsi
  80068d:	89 d7                	mov    %edx,%edi
  80068f:	ff d0                	callq  *%rax
  800691:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800695:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800699:	7f e4                	jg     80067f <printnum+0x66>
  80069b:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80069e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8006a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8006a7:	48 f7 f1             	div    %rcx
  8006aa:	48 89 d0             	mov    %rdx,%rax
  8006ad:	48 ba 30 50 80 00 00 	movabs $0x805030,%rdx
  8006b4:	00 00 00 
  8006b7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8006bb:	0f be d0             	movsbl %al,%edx
  8006be:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8006c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006c6:	48 89 ce             	mov    %rcx,%rsi
  8006c9:	89 d7                	mov    %edx,%edi
  8006cb:	ff d0                	callq  *%rax
  8006cd:	48 83 c4 38          	add    $0x38,%rsp
  8006d1:	5b                   	pop    %rbx
  8006d2:	5d                   	pop    %rbp
  8006d3:	c3                   	retq   

00000000008006d4 <getuint>:
  8006d4:	55                   	push   %rbp
  8006d5:	48 89 e5             	mov    %rsp,%rbp
  8006d8:	48 83 ec 1c          	sub    $0x1c,%rsp
  8006dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8006e0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8006e3:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8006e7:	7e 52                	jle    80073b <getuint+0x67>
  8006e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006ed:	8b 00                	mov    (%rax),%eax
  8006ef:	83 f8 30             	cmp    $0x30,%eax
  8006f2:	73 24                	jae    800718 <getuint+0x44>
  8006f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006f8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800700:	8b 00                	mov    (%rax),%eax
  800702:	89 c0                	mov    %eax,%eax
  800704:	48 01 d0             	add    %rdx,%rax
  800707:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80070b:	8b 12                	mov    (%rdx),%edx
  80070d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800710:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800714:	89 0a                	mov    %ecx,(%rdx)
  800716:	eb 17                	jmp    80072f <getuint+0x5b>
  800718:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80071c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800720:	48 89 d0             	mov    %rdx,%rax
  800723:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800727:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80072b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80072f:	48 8b 00             	mov    (%rax),%rax
  800732:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800736:	e9 a3 00 00 00       	jmpq   8007de <getuint+0x10a>
  80073b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80073f:	74 4f                	je     800790 <getuint+0xbc>
  800741:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800745:	8b 00                	mov    (%rax),%eax
  800747:	83 f8 30             	cmp    $0x30,%eax
  80074a:	73 24                	jae    800770 <getuint+0x9c>
  80074c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800750:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800754:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800758:	8b 00                	mov    (%rax),%eax
  80075a:	89 c0                	mov    %eax,%eax
  80075c:	48 01 d0             	add    %rdx,%rax
  80075f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800763:	8b 12                	mov    (%rdx),%edx
  800765:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800768:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80076c:	89 0a                	mov    %ecx,(%rdx)
  80076e:	eb 17                	jmp    800787 <getuint+0xb3>
  800770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800774:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800778:	48 89 d0             	mov    %rdx,%rax
  80077b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80077f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800783:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800787:	48 8b 00             	mov    (%rax),%rax
  80078a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80078e:	eb 4e                	jmp    8007de <getuint+0x10a>
  800790:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800794:	8b 00                	mov    (%rax),%eax
  800796:	83 f8 30             	cmp    $0x30,%eax
  800799:	73 24                	jae    8007bf <getuint+0xeb>
  80079b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80079f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8007a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007a7:	8b 00                	mov    (%rax),%eax
  8007a9:	89 c0                	mov    %eax,%eax
  8007ab:	48 01 d0             	add    %rdx,%rax
  8007ae:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007b2:	8b 12                	mov    (%rdx),%edx
  8007b4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8007b7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007bb:	89 0a                	mov    %ecx,(%rdx)
  8007bd:	eb 17                	jmp    8007d6 <getuint+0x102>
  8007bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007c3:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8007c7:	48 89 d0             	mov    %rdx,%rax
  8007ca:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8007ce:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007d2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8007d6:	8b 00                	mov    (%rax),%eax
  8007d8:	89 c0                	mov    %eax,%eax
  8007da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8007de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8007e2:	c9                   	leaveq 
  8007e3:	c3                   	retq   

00000000008007e4 <getint>:
  8007e4:	55                   	push   %rbp
  8007e5:	48 89 e5             	mov    %rsp,%rbp
  8007e8:	48 83 ec 1c          	sub    $0x1c,%rsp
  8007ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8007f0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8007f3:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8007f7:	7e 52                	jle    80084b <getint+0x67>
  8007f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007fd:	8b 00                	mov    (%rax),%eax
  8007ff:	83 f8 30             	cmp    $0x30,%eax
  800802:	73 24                	jae    800828 <getint+0x44>
  800804:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800808:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80080c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800810:	8b 00                	mov    (%rax),%eax
  800812:	89 c0                	mov    %eax,%eax
  800814:	48 01 d0             	add    %rdx,%rax
  800817:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80081b:	8b 12                	mov    (%rdx),%edx
  80081d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800820:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800824:	89 0a                	mov    %ecx,(%rdx)
  800826:	eb 17                	jmp    80083f <getint+0x5b>
  800828:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80082c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800830:	48 89 d0             	mov    %rdx,%rax
  800833:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800837:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80083b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80083f:	48 8b 00             	mov    (%rax),%rax
  800842:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800846:	e9 a3 00 00 00       	jmpq   8008ee <getint+0x10a>
  80084b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80084f:	74 4f                	je     8008a0 <getint+0xbc>
  800851:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800855:	8b 00                	mov    (%rax),%eax
  800857:	83 f8 30             	cmp    $0x30,%eax
  80085a:	73 24                	jae    800880 <getint+0x9c>
  80085c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800860:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800864:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800868:	8b 00                	mov    (%rax),%eax
  80086a:	89 c0                	mov    %eax,%eax
  80086c:	48 01 d0             	add    %rdx,%rax
  80086f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800873:	8b 12                	mov    (%rdx),%edx
  800875:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800878:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80087c:	89 0a                	mov    %ecx,(%rdx)
  80087e:	eb 17                	jmp    800897 <getint+0xb3>
  800880:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800884:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800888:	48 89 d0             	mov    %rdx,%rax
  80088b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80088f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800893:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800897:	48 8b 00             	mov    (%rax),%rax
  80089a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80089e:	eb 4e                	jmp    8008ee <getint+0x10a>
  8008a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008a4:	8b 00                	mov    (%rax),%eax
  8008a6:	83 f8 30             	cmp    $0x30,%eax
  8008a9:	73 24                	jae    8008cf <getint+0xeb>
  8008ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008af:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008b7:	8b 00                	mov    (%rax),%eax
  8008b9:	89 c0                	mov    %eax,%eax
  8008bb:	48 01 d0             	add    %rdx,%rax
  8008be:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008c2:	8b 12                	mov    (%rdx),%edx
  8008c4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008c7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008cb:	89 0a                	mov    %ecx,(%rdx)
  8008cd:	eb 17                	jmp    8008e6 <getint+0x102>
  8008cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008d3:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008d7:	48 89 d0             	mov    %rdx,%rax
  8008da:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008de:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008e2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008e6:	8b 00                	mov    (%rax),%eax
  8008e8:	48 98                	cltq   
  8008ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8008f2:	c9                   	leaveq 
  8008f3:	c3                   	retq   

00000000008008f4 <vprintfmt>:
  8008f4:	55                   	push   %rbp
  8008f5:	48 89 e5             	mov    %rsp,%rbp
  8008f8:	41 54                	push   %r12
  8008fa:	53                   	push   %rbx
  8008fb:	48 83 ec 60          	sub    $0x60,%rsp
  8008ff:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800903:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800907:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80090b:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  80090f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800913:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800917:	48 8b 0a             	mov    (%rdx),%rcx
  80091a:	48 89 08             	mov    %rcx,(%rax)
  80091d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800921:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800925:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800929:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80092d:	eb 17                	jmp    800946 <vprintfmt+0x52>
  80092f:	85 db                	test   %ebx,%ebx
  800931:	0f 84 cc 04 00 00    	je     800e03 <vprintfmt+0x50f>
  800937:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80093b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80093f:	48 89 d6             	mov    %rdx,%rsi
  800942:	89 df                	mov    %ebx,%edi
  800944:	ff d0                	callq  *%rax
  800946:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80094a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80094e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800952:	0f b6 00             	movzbl (%rax),%eax
  800955:	0f b6 d8             	movzbl %al,%ebx
  800958:	83 fb 25             	cmp    $0x25,%ebx
  80095b:	75 d2                	jne    80092f <vprintfmt+0x3b>
  80095d:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800961:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800968:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80096f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800976:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  80097d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800981:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800985:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800989:	0f b6 00             	movzbl (%rax),%eax
  80098c:	0f b6 d8             	movzbl %al,%ebx
  80098f:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800992:	83 f8 55             	cmp    $0x55,%eax
  800995:	0f 87 34 04 00 00    	ja     800dcf <vprintfmt+0x4db>
  80099b:	89 c0                	mov    %eax,%eax
  80099d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8009a4:	00 
  8009a5:	48 b8 58 50 80 00 00 	movabs $0x805058,%rax
  8009ac:	00 00 00 
  8009af:	48 01 d0             	add    %rdx,%rax
  8009b2:	48 8b 00             	mov    (%rax),%rax
  8009b5:	ff e0                	jmpq   *%rax
  8009b7:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8009bb:	eb c0                	jmp    80097d <vprintfmt+0x89>
  8009bd:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8009c1:	eb ba                	jmp    80097d <vprintfmt+0x89>
  8009c3:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8009ca:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8009cd:	89 d0                	mov    %edx,%eax
  8009cf:	c1 e0 02             	shl    $0x2,%eax
  8009d2:	01 d0                	add    %edx,%eax
  8009d4:	01 c0                	add    %eax,%eax
  8009d6:	01 d8                	add    %ebx,%eax
  8009d8:	83 e8 30             	sub    $0x30,%eax
  8009db:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8009de:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8009e2:	0f b6 00             	movzbl (%rax),%eax
  8009e5:	0f be d8             	movsbl %al,%ebx
  8009e8:	83 fb 2f             	cmp    $0x2f,%ebx
  8009eb:	7e 0c                	jle    8009f9 <vprintfmt+0x105>
  8009ed:	83 fb 39             	cmp    $0x39,%ebx
  8009f0:	7f 07                	jg     8009f9 <vprintfmt+0x105>
  8009f2:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  8009f7:	eb d1                	jmp    8009ca <vprintfmt+0xd6>
  8009f9:	eb 58                	jmp    800a53 <vprintfmt+0x15f>
  8009fb:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009fe:	83 f8 30             	cmp    $0x30,%eax
  800a01:	73 17                	jae    800a1a <vprintfmt+0x126>
  800a03:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a07:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a0a:	89 c0                	mov    %eax,%eax
  800a0c:	48 01 d0             	add    %rdx,%rax
  800a0f:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a12:	83 c2 08             	add    $0x8,%edx
  800a15:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a18:	eb 0f                	jmp    800a29 <vprintfmt+0x135>
  800a1a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a1e:	48 89 d0             	mov    %rdx,%rax
  800a21:	48 83 c2 08          	add    $0x8,%rdx
  800a25:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a29:	8b 00                	mov    (%rax),%eax
  800a2b:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800a2e:	eb 23                	jmp    800a53 <vprintfmt+0x15f>
  800a30:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a34:	79 0c                	jns    800a42 <vprintfmt+0x14e>
  800a36:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800a3d:	e9 3b ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a42:	e9 36 ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a47:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800a4e:	e9 2a ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a53:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a57:	79 12                	jns    800a6b <vprintfmt+0x177>
  800a59:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800a5c:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800a5f:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a66:	e9 12 ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a6b:	e9 0d ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a70:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800a74:	e9 04 ff ff ff       	jmpq   80097d <vprintfmt+0x89>
  800a79:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a7c:	83 f8 30             	cmp    $0x30,%eax
  800a7f:	73 17                	jae    800a98 <vprintfmt+0x1a4>
  800a81:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a85:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a88:	89 c0                	mov    %eax,%eax
  800a8a:	48 01 d0             	add    %rdx,%rax
  800a8d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a90:	83 c2 08             	add    $0x8,%edx
  800a93:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a96:	eb 0f                	jmp    800aa7 <vprintfmt+0x1b3>
  800a98:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a9c:	48 89 d0             	mov    %rdx,%rax
  800a9f:	48 83 c2 08          	add    $0x8,%rdx
  800aa3:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800aa7:	8b 10                	mov    (%rax),%edx
  800aa9:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800aad:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ab1:	48 89 ce             	mov    %rcx,%rsi
  800ab4:	89 d7                	mov    %edx,%edi
  800ab6:	ff d0                	callq  *%rax
  800ab8:	e9 40 03 00 00       	jmpq   800dfd <vprintfmt+0x509>
  800abd:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ac0:	83 f8 30             	cmp    $0x30,%eax
  800ac3:	73 17                	jae    800adc <vprintfmt+0x1e8>
  800ac5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ac9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800acc:	89 c0                	mov    %eax,%eax
  800ace:	48 01 d0             	add    %rdx,%rax
  800ad1:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ad4:	83 c2 08             	add    $0x8,%edx
  800ad7:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800ada:	eb 0f                	jmp    800aeb <vprintfmt+0x1f7>
  800adc:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ae0:	48 89 d0             	mov    %rdx,%rax
  800ae3:	48 83 c2 08          	add    $0x8,%rdx
  800ae7:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800aeb:	8b 18                	mov    (%rax),%ebx
  800aed:	85 db                	test   %ebx,%ebx
  800aef:	79 02                	jns    800af3 <vprintfmt+0x1ff>
  800af1:	f7 db                	neg    %ebx
  800af3:	83 fb 15             	cmp    $0x15,%ebx
  800af6:	7f 16                	jg     800b0e <vprintfmt+0x21a>
  800af8:	48 b8 80 4f 80 00 00 	movabs $0x804f80,%rax
  800aff:	00 00 00 
  800b02:	48 63 d3             	movslq %ebx,%rdx
  800b05:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800b09:	4d 85 e4             	test   %r12,%r12
  800b0c:	75 2e                	jne    800b3c <vprintfmt+0x248>
  800b0e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800b12:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b16:	89 d9                	mov    %ebx,%ecx
  800b18:	48 ba 41 50 80 00 00 	movabs $0x805041,%rdx
  800b1f:	00 00 00 
  800b22:	48 89 c7             	mov    %rax,%rdi
  800b25:	b8 00 00 00 00       	mov    $0x0,%eax
  800b2a:	49 b8 0c 0e 80 00 00 	movabs $0x800e0c,%r8
  800b31:	00 00 00 
  800b34:	41 ff d0             	callq  *%r8
  800b37:	e9 c1 02 00 00       	jmpq   800dfd <vprintfmt+0x509>
  800b3c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800b40:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b44:	4c 89 e1             	mov    %r12,%rcx
  800b47:	48 ba 4a 50 80 00 00 	movabs $0x80504a,%rdx
  800b4e:	00 00 00 
  800b51:	48 89 c7             	mov    %rax,%rdi
  800b54:	b8 00 00 00 00       	mov    $0x0,%eax
  800b59:	49 b8 0c 0e 80 00 00 	movabs $0x800e0c,%r8
  800b60:	00 00 00 
  800b63:	41 ff d0             	callq  *%r8
  800b66:	e9 92 02 00 00       	jmpq   800dfd <vprintfmt+0x509>
  800b6b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b6e:	83 f8 30             	cmp    $0x30,%eax
  800b71:	73 17                	jae    800b8a <vprintfmt+0x296>
  800b73:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b77:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b7a:	89 c0                	mov    %eax,%eax
  800b7c:	48 01 d0             	add    %rdx,%rax
  800b7f:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b82:	83 c2 08             	add    $0x8,%edx
  800b85:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b88:	eb 0f                	jmp    800b99 <vprintfmt+0x2a5>
  800b8a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b8e:	48 89 d0             	mov    %rdx,%rax
  800b91:	48 83 c2 08          	add    $0x8,%rdx
  800b95:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b99:	4c 8b 20             	mov    (%rax),%r12
  800b9c:	4d 85 e4             	test   %r12,%r12
  800b9f:	75 0a                	jne    800bab <vprintfmt+0x2b7>
  800ba1:	49 bc 4d 50 80 00 00 	movabs $0x80504d,%r12
  800ba8:	00 00 00 
  800bab:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800baf:	7e 3f                	jle    800bf0 <vprintfmt+0x2fc>
  800bb1:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800bb5:	74 39                	je     800bf0 <vprintfmt+0x2fc>
  800bb7:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800bba:	48 98                	cltq   
  800bbc:	48 89 c6             	mov    %rax,%rsi
  800bbf:	4c 89 e7             	mov    %r12,%rdi
  800bc2:	48 b8 b8 10 80 00 00 	movabs $0x8010b8,%rax
  800bc9:	00 00 00 
  800bcc:	ff d0                	callq  *%rax
  800bce:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800bd1:	eb 17                	jmp    800bea <vprintfmt+0x2f6>
  800bd3:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800bd7:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800bdb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bdf:	48 89 ce             	mov    %rcx,%rsi
  800be2:	89 d7                	mov    %edx,%edi
  800be4:	ff d0                	callq  *%rax
  800be6:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800bea:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800bee:	7f e3                	jg     800bd3 <vprintfmt+0x2df>
  800bf0:	eb 37                	jmp    800c29 <vprintfmt+0x335>
  800bf2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800bf6:	74 1e                	je     800c16 <vprintfmt+0x322>
  800bf8:	83 fb 1f             	cmp    $0x1f,%ebx
  800bfb:	7e 05                	jle    800c02 <vprintfmt+0x30e>
  800bfd:	83 fb 7e             	cmp    $0x7e,%ebx
  800c00:	7e 14                	jle    800c16 <vprintfmt+0x322>
  800c02:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c06:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c0a:	48 89 d6             	mov    %rdx,%rsi
  800c0d:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800c12:	ff d0                	callq  *%rax
  800c14:	eb 0f                	jmp    800c25 <vprintfmt+0x331>
  800c16:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c1a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c1e:	48 89 d6             	mov    %rdx,%rsi
  800c21:	89 df                	mov    %ebx,%edi
  800c23:	ff d0                	callq  *%rax
  800c25:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800c29:	4c 89 e0             	mov    %r12,%rax
  800c2c:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800c30:	0f b6 00             	movzbl (%rax),%eax
  800c33:	0f be d8             	movsbl %al,%ebx
  800c36:	85 db                	test   %ebx,%ebx
  800c38:	74 10                	je     800c4a <vprintfmt+0x356>
  800c3a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800c3e:	78 b2                	js     800bf2 <vprintfmt+0x2fe>
  800c40:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800c44:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800c48:	79 a8                	jns    800bf2 <vprintfmt+0x2fe>
  800c4a:	eb 16                	jmp    800c62 <vprintfmt+0x36e>
  800c4c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c50:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c54:	48 89 d6             	mov    %rdx,%rsi
  800c57:	bf 20 00 00 00       	mov    $0x20,%edi
  800c5c:	ff d0                	callq  *%rax
  800c5e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800c62:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c66:	7f e4                	jg     800c4c <vprintfmt+0x358>
  800c68:	e9 90 01 00 00       	jmpq   800dfd <vprintfmt+0x509>
  800c6d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c71:	be 03 00 00 00       	mov    $0x3,%esi
  800c76:	48 89 c7             	mov    %rax,%rdi
  800c79:	48 b8 e4 07 80 00 00 	movabs $0x8007e4,%rax
  800c80:	00 00 00 
  800c83:	ff d0                	callq  *%rax
  800c85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c8d:	48 85 c0             	test   %rax,%rax
  800c90:	79 1d                	jns    800caf <vprintfmt+0x3bb>
  800c92:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c96:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c9a:	48 89 d6             	mov    %rdx,%rsi
  800c9d:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800ca2:	ff d0                	callq  *%rax
  800ca4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ca8:	48 f7 d8             	neg    %rax
  800cab:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800caf:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800cb6:	e9 d5 00 00 00       	jmpq   800d90 <vprintfmt+0x49c>
  800cbb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800cbf:	be 03 00 00 00       	mov    $0x3,%esi
  800cc4:	48 89 c7             	mov    %rax,%rdi
  800cc7:	48 b8 d4 06 80 00 00 	movabs $0x8006d4,%rax
  800cce:	00 00 00 
  800cd1:	ff d0                	callq  *%rax
  800cd3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800cd7:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800cde:	e9 ad 00 00 00       	jmpq   800d90 <vprintfmt+0x49c>
  800ce3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ce7:	be 03 00 00 00       	mov    $0x3,%esi
  800cec:	48 89 c7             	mov    %rax,%rdi
  800cef:	48 b8 d4 06 80 00 00 	movabs $0x8006d4,%rax
  800cf6:	00 00 00 
  800cf9:	ff d0                	callq  *%rax
  800cfb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800cff:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800d06:	e9 85 00 00 00       	jmpq   800d90 <vprintfmt+0x49c>
  800d0b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d0f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d13:	48 89 d6             	mov    %rdx,%rsi
  800d16:	bf 30 00 00 00       	mov    $0x30,%edi
  800d1b:	ff d0                	callq  *%rax
  800d1d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d21:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d25:	48 89 d6             	mov    %rdx,%rsi
  800d28:	bf 78 00 00 00       	mov    $0x78,%edi
  800d2d:	ff d0                	callq  *%rax
  800d2f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d32:	83 f8 30             	cmp    $0x30,%eax
  800d35:	73 17                	jae    800d4e <vprintfmt+0x45a>
  800d37:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d3b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d3e:	89 c0                	mov    %eax,%eax
  800d40:	48 01 d0             	add    %rdx,%rax
  800d43:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d46:	83 c2 08             	add    $0x8,%edx
  800d49:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d4c:	eb 0f                	jmp    800d5d <vprintfmt+0x469>
  800d4e:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d52:	48 89 d0             	mov    %rdx,%rax
  800d55:	48 83 c2 08          	add    $0x8,%rdx
  800d59:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d5d:	48 8b 00             	mov    (%rax),%rax
  800d60:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d64:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800d6b:	eb 23                	jmp    800d90 <vprintfmt+0x49c>
  800d6d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d71:	be 03 00 00 00       	mov    $0x3,%esi
  800d76:	48 89 c7             	mov    %rax,%rdi
  800d79:	48 b8 d4 06 80 00 00 	movabs $0x8006d4,%rax
  800d80:	00 00 00 
  800d83:	ff d0                	callq  *%rax
  800d85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d89:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800d90:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800d95:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800d98:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800d9b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d9f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800da3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800da7:	45 89 c1             	mov    %r8d,%r9d
  800daa:	41 89 f8             	mov    %edi,%r8d
  800dad:	48 89 c7             	mov    %rax,%rdi
  800db0:	48 b8 19 06 80 00 00 	movabs $0x800619,%rax
  800db7:	00 00 00 
  800dba:	ff d0                	callq  *%rax
  800dbc:	eb 3f                	jmp    800dfd <vprintfmt+0x509>
  800dbe:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dc2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dc6:	48 89 d6             	mov    %rdx,%rsi
  800dc9:	89 df                	mov    %ebx,%edi
  800dcb:	ff d0                	callq  *%rax
  800dcd:	eb 2e                	jmp    800dfd <vprintfmt+0x509>
  800dcf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dd3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dd7:	48 89 d6             	mov    %rdx,%rsi
  800dda:	bf 25 00 00 00       	mov    $0x25,%edi
  800ddf:	ff d0                	callq  *%rax
  800de1:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800de6:	eb 05                	jmp    800ded <vprintfmt+0x4f9>
  800de8:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800ded:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800df1:	48 83 e8 01          	sub    $0x1,%rax
  800df5:	0f b6 00             	movzbl (%rax),%eax
  800df8:	3c 25                	cmp    $0x25,%al
  800dfa:	75 ec                	jne    800de8 <vprintfmt+0x4f4>
  800dfc:	90                   	nop
  800dfd:	90                   	nop
  800dfe:	e9 43 fb ff ff       	jmpq   800946 <vprintfmt+0x52>
  800e03:	48 83 c4 60          	add    $0x60,%rsp
  800e07:	5b                   	pop    %rbx
  800e08:	41 5c                	pop    %r12
  800e0a:	5d                   	pop    %rbp
  800e0b:	c3                   	retq   

0000000000800e0c <printfmt>:
  800e0c:	55                   	push   %rbp
  800e0d:	48 89 e5             	mov    %rsp,%rbp
  800e10:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800e17:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800e1e:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800e25:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800e2c:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800e33:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800e3a:	84 c0                	test   %al,%al
  800e3c:	74 20                	je     800e5e <printfmt+0x52>
  800e3e:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800e42:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800e46:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800e4a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800e4e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800e52:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800e56:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800e5a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800e5e:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800e65:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800e6c:	00 00 00 
  800e6f:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800e76:	00 00 00 
  800e79:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800e7d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800e84:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800e8b:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800e92:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800e99:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800ea0:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800ea7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800eae:	48 89 c7             	mov    %rax,%rdi
  800eb1:	48 b8 f4 08 80 00 00 	movabs $0x8008f4,%rax
  800eb8:	00 00 00 
  800ebb:	ff d0                	callq  *%rax
  800ebd:	c9                   	leaveq 
  800ebe:	c3                   	retq   

0000000000800ebf <sprintputch>:
  800ebf:	55                   	push   %rbp
  800ec0:	48 89 e5             	mov    %rsp,%rbp
  800ec3:	48 83 ec 10          	sub    $0x10,%rsp
  800ec7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800eca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800ece:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ed2:	8b 40 10             	mov    0x10(%rax),%eax
  800ed5:	8d 50 01             	lea    0x1(%rax),%edx
  800ed8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800edc:	89 50 10             	mov    %edx,0x10(%rax)
  800edf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ee3:	48 8b 10             	mov    (%rax),%rdx
  800ee6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800eea:	48 8b 40 08          	mov    0x8(%rax),%rax
  800eee:	48 39 c2             	cmp    %rax,%rdx
  800ef1:	73 17                	jae    800f0a <sprintputch+0x4b>
  800ef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ef7:	48 8b 00             	mov    (%rax),%rax
  800efa:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800efe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800f02:	48 89 0a             	mov    %rcx,(%rdx)
  800f05:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800f08:	88 10                	mov    %dl,(%rax)
  800f0a:	c9                   	leaveq 
  800f0b:	c3                   	retq   

0000000000800f0c <vsnprintf>:
  800f0c:	55                   	push   %rbp
  800f0d:	48 89 e5             	mov    %rsp,%rbp
  800f10:	48 83 ec 50          	sub    $0x50,%rsp
  800f14:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800f18:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800f1b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800f1f:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800f23:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800f27:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800f2b:	48 8b 0a             	mov    (%rdx),%rcx
  800f2e:	48 89 08             	mov    %rcx,(%rax)
  800f31:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800f35:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800f39:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800f3d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800f41:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800f45:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800f49:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800f4c:	48 98                	cltq   
  800f4e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800f52:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800f56:	48 01 d0             	add    %rdx,%rax
  800f59:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800f5d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800f64:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800f69:	74 06                	je     800f71 <vsnprintf+0x65>
  800f6b:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800f6f:	7f 07                	jg     800f78 <vsnprintf+0x6c>
  800f71:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800f76:	eb 2f                	jmp    800fa7 <vsnprintf+0x9b>
  800f78:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800f7c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800f80:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800f84:	48 89 c6             	mov    %rax,%rsi
  800f87:	48 bf bf 0e 80 00 00 	movabs $0x800ebf,%rdi
  800f8e:	00 00 00 
  800f91:	48 b8 f4 08 80 00 00 	movabs $0x8008f4,%rax
  800f98:	00 00 00 
  800f9b:	ff d0                	callq  *%rax
  800f9d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800fa1:	c6 00 00             	movb   $0x0,(%rax)
  800fa4:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800fa7:	c9                   	leaveq 
  800fa8:	c3                   	retq   

0000000000800fa9 <snprintf>:
  800fa9:	55                   	push   %rbp
  800faa:	48 89 e5             	mov    %rsp,%rbp
  800fad:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800fb4:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800fbb:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800fc1:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800fc8:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800fcf:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800fd6:	84 c0                	test   %al,%al
  800fd8:	74 20                	je     800ffa <snprintf+0x51>
  800fda:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800fde:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800fe2:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800fe6:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800fea:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800fee:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800ff2:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800ff6:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800ffa:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801001:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  801008:	00 00 00 
  80100b:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  801012:	00 00 00 
  801015:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801019:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801020:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801027:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80102e:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  801035:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80103c:	48 8b 0a             	mov    (%rdx),%rcx
  80103f:	48 89 08             	mov    %rcx,(%rax)
  801042:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801046:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80104a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80104e:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801052:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801059:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801060:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801066:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80106d:	48 89 c7             	mov    %rax,%rdi
  801070:	48 b8 0c 0f 80 00 00 	movabs $0x800f0c,%rax
  801077:	00 00 00 
  80107a:	ff d0                	callq  *%rax
  80107c:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801082:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801088:	c9                   	leaveq 
  801089:	c3                   	retq   

000000000080108a <strlen>:
  80108a:	55                   	push   %rbp
  80108b:	48 89 e5             	mov    %rsp,%rbp
  80108e:	48 83 ec 18          	sub    $0x18,%rsp
  801092:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801096:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80109d:	eb 09                	jmp    8010a8 <strlen+0x1e>
  80109f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8010a3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8010a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ac:	0f b6 00             	movzbl (%rax),%eax
  8010af:	84 c0                	test   %al,%al
  8010b1:	75 ec                	jne    80109f <strlen+0x15>
  8010b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8010b6:	c9                   	leaveq 
  8010b7:	c3                   	retq   

00000000008010b8 <strnlen>:
  8010b8:	55                   	push   %rbp
  8010b9:	48 89 e5             	mov    %rsp,%rbp
  8010bc:	48 83 ec 20          	sub    $0x20,%rsp
  8010c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8010c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8010cf:	eb 0e                	jmp    8010df <strnlen+0x27>
  8010d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8010d5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8010da:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8010df:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8010e4:	74 0b                	je     8010f1 <strnlen+0x39>
  8010e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ea:	0f b6 00             	movzbl (%rax),%eax
  8010ed:	84 c0                	test   %al,%al
  8010ef:	75 e0                	jne    8010d1 <strnlen+0x19>
  8010f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8010f4:	c9                   	leaveq 
  8010f5:	c3                   	retq   

00000000008010f6 <strcpy>:
  8010f6:	55                   	push   %rbp
  8010f7:	48 89 e5             	mov    %rsp,%rbp
  8010fa:	48 83 ec 20          	sub    $0x20,%rsp
  8010fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801102:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801106:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80110a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80110e:	90                   	nop
  80110f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801113:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801117:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80111b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80111f:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801123:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801127:	0f b6 12             	movzbl (%rdx),%edx
  80112a:	88 10                	mov    %dl,(%rax)
  80112c:	0f b6 00             	movzbl (%rax),%eax
  80112f:	84 c0                	test   %al,%al
  801131:	75 dc                	jne    80110f <strcpy+0x19>
  801133:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801137:	c9                   	leaveq 
  801138:	c3                   	retq   

0000000000801139 <strcat>:
  801139:	55                   	push   %rbp
  80113a:	48 89 e5             	mov    %rsp,%rbp
  80113d:	48 83 ec 20          	sub    $0x20,%rsp
  801141:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801145:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801149:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80114d:	48 89 c7             	mov    %rax,%rdi
  801150:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  801157:	00 00 00 
  80115a:	ff d0                	callq  *%rax
  80115c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80115f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801162:	48 63 d0             	movslq %eax,%rdx
  801165:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801169:	48 01 c2             	add    %rax,%rdx
  80116c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801170:	48 89 c6             	mov    %rax,%rsi
  801173:	48 89 d7             	mov    %rdx,%rdi
  801176:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  80117d:	00 00 00 
  801180:	ff d0                	callq  *%rax
  801182:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801186:	c9                   	leaveq 
  801187:	c3                   	retq   

0000000000801188 <strncpy>:
  801188:	55                   	push   %rbp
  801189:	48 89 e5             	mov    %rsp,%rbp
  80118c:	48 83 ec 28          	sub    $0x28,%rsp
  801190:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801194:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801198:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80119c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8011a4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8011ab:	00 
  8011ac:	eb 2a                	jmp    8011d8 <strncpy+0x50>
  8011ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011b2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8011b6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8011ba:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8011be:	0f b6 12             	movzbl (%rdx),%edx
  8011c1:	88 10                	mov    %dl,(%rax)
  8011c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8011c7:	0f b6 00             	movzbl (%rax),%eax
  8011ca:	84 c0                	test   %al,%al
  8011cc:	74 05                	je     8011d3 <strncpy+0x4b>
  8011ce:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8011d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8011d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011dc:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8011e0:	72 cc                	jb     8011ae <strncpy+0x26>
  8011e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011e6:	c9                   	leaveq 
  8011e7:	c3                   	retq   

00000000008011e8 <strlcpy>:
  8011e8:	55                   	push   %rbp
  8011e9:	48 89 e5             	mov    %rsp,%rbp
  8011ec:	48 83 ec 28          	sub    $0x28,%rsp
  8011f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011f4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011f8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8011fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801200:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801204:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801209:	74 3d                	je     801248 <strlcpy+0x60>
  80120b:	eb 1d                	jmp    80122a <strlcpy+0x42>
  80120d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801211:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801215:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801219:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80121d:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801221:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801225:	0f b6 12             	movzbl (%rdx),%edx
  801228:	88 10                	mov    %dl,(%rax)
  80122a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80122f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801234:	74 0b                	je     801241 <strlcpy+0x59>
  801236:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80123a:	0f b6 00             	movzbl (%rax),%eax
  80123d:	84 c0                	test   %al,%al
  80123f:	75 cc                	jne    80120d <strlcpy+0x25>
  801241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801245:	c6 00 00             	movb   $0x0,(%rax)
  801248:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80124c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801250:	48 29 c2             	sub    %rax,%rdx
  801253:	48 89 d0             	mov    %rdx,%rax
  801256:	c9                   	leaveq 
  801257:	c3                   	retq   

0000000000801258 <strcmp>:
  801258:	55                   	push   %rbp
  801259:	48 89 e5             	mov    %rsp,%rbp
  80125c:	48 83 ec 10          	sub    $0x10,%rsp
  801260:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801264:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801268:	eb 0a                	jmp    801274 <strcmp+0x1c>
  80126a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80126f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801274:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801278:	0f b6 00             	movzbl (%rax),%eax
  80127b:	84 c0                	test   %al,%al
  80127d:	74 12                	je     801291 <strcmp+0x39>
  80127f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801283:	0f b6 10             	movzbl (%rax),%edx
  801286:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80128a:	0f b6 00             	movzbl (%rax),%eax
  80128d:	38 c2                	cmp    %al,%dl
  80128f:	74 d9                	je     80126a <strcmp+0x12>
  801291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801295:	0f b6 00             	movzbl (%rax),%eax
  801298:	0f b6 d0             	movzbl %al,%edx
  80129b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80129f:	0f b6 00             	movzbl (%rax),%eax
  8012a2:	0f b6 c0             	movzbl %al,%eax
  8012a5:	29 c2                	sub    %eax,%edx
  8012a7:	89 d0                	mov    %edx,%eax
  8012a9:	c9                   	leaveq 
  8012aa:	c3                   	retq   

00000000008012ab <strncmp>:
  8012ab:	55                   	push   %rbp
  8012ac:	48 89 e5             	mov    %rsp,%rbp
  8012af:	48 83 ec 18          	sub    $0x18,%rsp
  8012b3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8012b7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8012bb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012bf:	eb 0f                	jmp    8012d0 <strncmp+0x25>
  8012c1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8012c6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012cb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8012d0:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8012d5:	74 1d                	je     8012f4 <strncmp+0x49>
  8012d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012db:	0f b6 00             	movzbl (%rax),%eax
  8012de:	84 c0                	test   %al,%al
  8012e0:	74 12                	je     8012f4 <strncmp+0x49>
  8012e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012e6:	0f b6 10             	movzbl (%rax),%edx
  8012e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012ed:	0f b6 00             	movzbl (%rax),%eax
  8012f0:	38 c2                	cmp    %al,%dl
  8012f2:	74 cd                	je     8012c1 <strncmp+0x16>
  8012f4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8012f9:	75 07                	jne    801302 <strncmp+0x57>
  8012fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801300:	eb 18                	jmp    80131a <strncmp+0x6f>
  801302:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801306:	0f b6 00             	movzbl (%rax),%eax
  801309:	0f b6 d0             	movzbl %al,%edx
  80130c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801310:	0f b6 00             	movzbl (%rax),%eax
  801313:	0f b6 c0             	movzbl %al,%eax
  801316:	29 c2                	sub    %eax,%edx
  801318:	89 d0                	mov    %edx,%eax
  80131a:	c9                   	leaveq 
  80131b:	c3                   	retq   

000000000080131c <strchr>:
  80131c:	55                   	push   %rbp
  80131d:	48 89 e5             	mov    %rsp,%rbp
  801320:	48 83 ec 0c          	sub    $0xc,%rsp
  801324:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801328:	89 f0                	mov    %esi,%eax
  80132a:	88 45 f4             	mov    %al,-0xc(%rbp)
  80132d:	eb 17                	jmp    801346 <strchr+0x2a>
  80132f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801333:	0f b6 00             	movzbl (%rax),%eax
  801336:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801339:	75 06                	jne    801341 <strchr+0x25>
  80133b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80133f:	eb 15                	jmp    801356 <strchr+0x3a>
  801341:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801346:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80134a:	0f b6 00             	movzbl (%rax),%eax
  80134d:	84 c0                	test   %al,%al
  80134f:	75 de                	jne    80132f <strchr+0x13>
  801351:	b8 00 00 00 00       	mov    $0x0,%eax
  801356:	c9                   	leaveq 
  801357:	c3                   	retq   

0000000000801358 <strfind>:
  801358:	55                   	push   %rbp
  801359:	48 89 e5             	mov    %rsp,%rbp
  80135c:	48 83 ec 0c          	sub    $0xc,%rsp
  801360:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801364:	89 f0                	mov    %esi,%eax
  801366:	88 45 f4             	mov    %al,-0xc(%rbp)
  801369:	eb 13                	jmp    80137e <strfind+0x26>
  80136b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80136f:	0f b6 00             	movzbl (%rax),%eax
  801372:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801375:	75 02                	jne    801379 <strfind+0x21>
  801377:	eb 10                	jmp    801389 <strfind+0x31>
  801379:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80137e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801382:	0f b6 00             	movzbl (%rax),%eax
  801385:	84 c0                	test   %al,%al
  801387:	75 e2                	jne    80136b <strfind+0x13>
  801389:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80138d:	c9                   	leaveq 
  80138e:	c3                   	retq   

000000000080138f <memset>:
  80138f:	55                   	push   %rbp
  801390:	48 89 e5             	mov    %rsp,%rbp
  801393:	48 83 ec 18          	sub    $0x18,%rsp
  801397:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80139b:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80139e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013a2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013a7:	75 06                	jne    8013af <memset+0x20>
  8013a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013ad:	eb 69                	jmp    801418 <memset+0x89>
  8013af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013b3:	83 e0 03             	and    $0x3,%eax
  8013b6:	48 85 c0             	test   %rax,%rax
  8013b9:	75 48                	jne    801403 <memset+0x74>
  8013bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013bf:	83 e0 03             	and    $0x3,%eax
  8013c2:	48 85 c0             	test   %rax,%rax
  8013c5:	75 3c                	jne    801403 <memset+0x74>
  8013c7:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8013ce:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8013d1:	c1 e0 18             	shl    $0x18,%eax
  8013d4:	89 c2                	mov    %eax,%edx
  8013d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8013d9:	c1 e0 10             	shl    $0x10,%eax
  8013dc:	09 c2                	or     %eax,%edx
  8013de:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8013e1:	c1 e0 08             	shl    $0x8,%eax
  8013e4:	09 d0                	or     %edx,%eax
  8013e6:	09 45 f4             	or     %eax,-0xc(%rbp)
  8013e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013ed:	48 c1 e8 02          	shr    $0x2,%rax
  8013f1:	48 89 c1             	mov    %rax,%rcx
  8013f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8013fb:	48 89 d7             	mov    %rdx,%rdi
  8013fe:	fc                   	cld    
  8013ff:	f3 ab                	rep stos %eax,%es:(%rdi)
  801401:	eb 11                	jmp    801414 <memset+0x85>
  801403:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801407:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80140a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80140e:	48 89 d7             	mov    %rdx,%rdi
  801411:	fc                   	cld    
  801412:	f3 aa                	rep stos %al,%es:(%rdi)
  801414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801418:	c9                   	leaveq 
  801419:	c3                   	retq   

000000000080141a <memmove>:
  80141a:	55                   	push   %rbp
  80141b:	48 89 e5             	mov    %rsp,%rbp
  80141e:	48 83 ec 28          	sub    $0x28,%rsp
  801422:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801426:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80142a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80142e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801432:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80143a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80143e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801442:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801446:	0f 83 88 00 00 00    	jae    8014d4 <memmove+0xba>
  80144c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801450:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801454:	48 01 d0             	add    %rdx,%rax
  801457:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80145b:	76 77                	jbe    8014d4 <memmove+0xba>
  80145d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801461:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801465:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801469:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  80146d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801471:	83 e0 03             	and    $0x3,%eax
  801474:	48 85 c0             	test   %rax,%rax
  801477:	75 3b                	jne    8014b4 <memmove+0x9a>
  801479:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80147d:	83 e0 03             	and    $0x3,%eax
  801480:	48 85 c0             	test   %rax,%rax
  801483:	75 2f                	jne    8014b4 <memmove+0x9a>
  801485:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801489:	83 e0 03             	and    $0x3,%eax
  80148c:	48 85 c0             	test   %rax,%rax
  80148f:	75 23                	jne    8014b4 <memmove+0x9a>
  801491:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801495:	48 83 e8 04          	sub    $0x4,%rax
  801499:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80149d:	48 83 ea 04          	sub    $0x4,%rdx
  8014a1:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8014a5:	48 c1 e9 02          	shr    $0x2,%rcx
  8014a9:	48 89 c7             	mov    %rax,%rdi
  8014ac:	48 89 d6             	mov    %rdx,%rsi
  8014af:	fd                   	std    
  8014b0:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8014b2:	eb 1d                	jmp    8014d1 <memmove+0xb7>
  8014b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014b8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8014bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014c0:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8014c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014c8:	48 89 d7             	mov    %rdx,%rdi
  8014cb:	48 89 c1             	mov    %rax,%rcx
  8014ce:	fd                   	std    
  8014cf:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8014d1:	fc                   	cld    
  8014d2:	eb 57                	jmp    80152b <memmove+0x111>
  8014d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d8:	83 e0 03             	and    $0x3,%eax
  8014db:	48 85 c0             	test   %rax,%rax
  8014de:	75 36                	jne    801516 <memmove+0xfc>
  8014e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014e4:	83 e0 03             	and    $0x3,%eax
  8014e7:	48 85 c0             	test   %rax,%rax
  8014ea:	75 2a                	jne    801516 <memmove+0xfc>
  8014ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014f0:	83 e0 03             	and    $0x3,%eax
  8014f3:	48 85 c0             	test   %rax,%rax
  8014f6:	75 1e                	jne    801516 <memmove+0xfc>
  8014f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014fc:	48 c1 e8 02          	shr    $0x2,%rax
  801500:	48 89 c1             	mov    %rax,%rcx
  801503:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801507:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80150b:	48 89 c7             	mov    %rax,%rdi
  80150e:	48 89 d6             	mov    %rdx,%rsi
  801511:	fc                   	cld    
  801512:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801514:	eb 15                	jmp    80152b <memmove+0x111>
  801516:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80151a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80151e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801522:	48 89 c7             	mov    %rax,%rdi
  801525:	48 89 d6             	mov    %rdx,%rsi
  801528:	fc                   	cld    
  801529:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80152b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80152f:	c9                   	leaveq 
  801530:	c3                   	retq   

0000000000801531 <memcpy>:
  801531:	55                   	push   %rbp
  801532:	48 89 e5             	mov    %rsp,%rbp
  801535:	48 83 ec 18          	sub    $0x18,%rsp
  801539:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80153d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801541:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801545:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801549:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80154d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801551:	48 89 ce             	mov    %rcx,%rsi
  801554:	48 89 c7             	mov    %rax,%rdi
  801557:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  80155e:	00 00 00 
  801561:	ff d0                	callq  *%rax
  801563:	c9                   	leaveq 
  801564:	c3                   	retq   

0000000000801565 <memcmp>:
  801565:	55                   	push   %rbp
  801566:	48 89 e5             	mov    %rsp,%rbp
  801569:	48 83 ec 28          	sub    $0x28,%rsp
  80156d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801571:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801575:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801579:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80157d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801581:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801585:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801589:	eb 36                	jmp    8015c1 <memcmp+0x5c>
  80158b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80158f:	0f b6 10             	movzbl (%rax),%edx
  801592:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801596:	0f b6 00             	movzbl (%rax),%eax
  801599:	38 c2                	cmp    %al,%dl
  80159b:	74 1a                	je     8015b7 <memcmp+0x52>
  80159d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015a1:	0f b6 00             	movzbl (%rax),%eax
  8015a4:	0f b6 d0             	movzbl %al,%edx
  8015a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015ab:	0f b6 00             	movzbl (%rax),%eax
  8015ae:	0f b6 c0             	movzbl %al,%eax
  8015b1:	29 c2                	sub    %eax,%edx
  8015b3:	89 d0                	mov    %edx,%eax
  8015b5:	eb 20                	jmp    8015d7 <memcmp+0x72>
  8015b7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8015bc:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8015c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015c5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8015c9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8015cd:	48 85 c0             	test   %rax,%rax
  8015d0:	75 b9                	jne    80158b <memcmp+0x26>
  8015d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8015d7:	c9                   	leaveq 
  8015d8:	c3                   	retq   

00000000008015d9 <memfind>:
  8015d9:	55                   	push   %rbp
  8015da:	48 89 e5             	mov    %rsp,%rbp
  8015dd:	48 83 ec 28          	sub    $0x28,%rsp
  8015e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8015e5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8015e8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8015ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015f0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8015f4:	48 01 d0             	add    %rdx,%rax
  8015f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8015fb:	eb 15                	jmp    801612 <memfind+0x39>
  8015fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801601:	0f b6 10             	movzbl (%rax),%edx
  801604:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801607:	38 c2                	cmp    %al,%dl
  801609:	75 02                	jne    80160d <memfind+0x34>
  80160b:	eb 0f                	jmp    80161c <memfind+0x43>
  80160d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801612:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801616:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  80161a:	72 e1                	jb     8015fd <memfind+0x24>
  80161c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801620:	c9                   	leaveq 
  801621:	c3                   	retq   

0000000000801622 <strtol>:
  801622:	55                   	push   %rbp
  801623:	48 89 e5             	mov    %rsp,%rbp
  801626:	48 83 ec 34          	sub    $0x34,%rsp
  80162a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80162e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801632:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801635:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80163c:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801643:	00 
  801644:	eb 05                	jmp    80164b <strtol+0x29>
  801646:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80164b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80164f:	0f b6 00             	movzbl (%rax),%eax
  801652:	3c 20                	cmp    $0x20,%al
  801654:	74 f0                	je     801646 <strtol+0x24>
  801656:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80165a:	0f b6 00             	movzbl (%rax),%eax
  80165d:	3c 09                	cmp    $0x9,%al
  80165f:	74 e5                	je     801646 <strtol+0x24>
  801661:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801665:	0f b6 00             	movzbl (%rax),%eax
  801668:	3c 2b                	cmp    $0x2b,%al
  80166a:	75 07                	jne    801673 <strtol+0x51>
  80166c:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801671:	eb 17                	jmp    80168a <strtol+0x68>
  801673:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801677:	0f b6 00             	movzbl (%rax),%eax
  80167a:	3c 2d                	cmp    $0x2d,%al
  80167c:	75 0c                	jne    80168a <strtol+0x68>
  80167e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801683:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80168a:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80168e:	74 06                	je     801696 <strtol+0x74>
  801690:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801694:	75 28                	jne    8016be <strtol+0x9c>
  801696:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80169a:	0f b6 00             	movzbl (%rax),%eax
  80169d:	3c 30                	cmp    $0x30,%al
  80169f:	75 1d                	jne    8016be <strtol+0x9c>
  8016a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016a5:	48 83 c0 01          	add    $0x1,%rax
  8016a9:	0f b6 00             	movzbl (%rax),%eax
  8016ac:	3c 78                	cmp    $0x78,%al
  8016ae:	75 0e                	jne    8016be <strtol+0x9c>
  8016b0:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8016b5:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8016bc:	eb 2c                	jmp    8016ea <strtol+0xc8>
  8016be:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8016c2:	75 19                	jne    8016dd <strtol+0xbb>
  8016c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016c8:	0f b6 00             	movzbl (%rax),%eax
  8016cb:	3c 30                	cmp    $0x30,%al
  8016cd:	75 0e                	jne    8016dd <strtol+0xbb>
  8016cf:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8016d4:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8016db:	eb 0d                	jmp    8016ea <strtol+0xc8>
  8016dd:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8016e1:	75 07                	jne    8016ea <strtol+0xc8>
  8016e3:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8016ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016ee:	0f b6 00             	movzbl (%rax),%eax
  8016f1:	3c 2f                	cmp    $0x2f,%al
  8016f3:	7e 1d                	jle    801712 <strtol+0xf0>
  8016f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016f9:	0f b6 00             	movzbl (%rax),%eax
  8016fc:	3c 39                	cmp    $0x39,%al
  8016fe:	7f 12                	jg     801712 <strtol+0xf0>
  801700:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801704:	0f b6 00             	movzbl (%rax),%eax
  801707:	0f be c0             	movsbl %al,%eax
  80170a:	83 e8 30             	sub    $0x30,%eax
  80170d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801710:	eb 4e                	jmp    801760 <strtol+0x13e>
  801712:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801716:	0f b6 00             	movzbl (%rax),%eax
  801719:	3c 60                	cmp    $0x60,%al
  80171b:	7e 1d                	jle    80173a <strtol+0x118>
  80171d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801721:	0f b6 00             	movzbl (%rax),%eax
  801724:	3c 7a                	cmp    $0x7a,%al
  801726:	7f 12                	jg     80173a <strtol+0x118>
  801728:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80172c:	0f b6 00             	movzbl (%rax),%eax
  80172f:	0f be c0             	movsbl %al,%eax
  801732:	83 e8 57             	sub    $0x57,%eax
  801735:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801738:	eb 26                	jmp    801760 <strtol+0x13e>
  80173a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80173e:	0f b6 00             	movzbl (%rax),%eax
  801741:	3c 40                	cmp    $0x40,%al
  801743:	7e 48                	jle    80178d <strtol+0x16b>
  801745:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801749:	0f b6 00             	movzbl (%rax),%eax
  80174c:	3c 5a                	cmp    $0x5a,%al
  80174e:	7f 3d                	jg     80178d <strtol+0x16b>
  801750:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801754:	0f b6 00             	movzbl (%rax),%eax
  801757:	0f be c0             	movsbl %al,%eax
  80175a:	83 e8 37             	sub    $0x37,%eax
  80175d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801760:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801763:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801766:	7c 02                	jl     80176a <strtol+0x148>
  801768:	eb 23                	jmp    80178d <strtol+0x16b>
  80176a:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80176f:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801772:	48 98                	cltq   
  801774:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801779:	48 89 c2             	mov    %rax,%rdx
  80177c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80177f:	48 98                	cltq   
  801781:	48 01 d0             	add    %rdx,%rax
  801784:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801788:	e9 5d ff ff ff       	jmpq   8016ea <strtol+0xc8>
  80178d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801792:	74 0b                	je     80179f <strtol+0x17d>
  801794:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801798:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80179c:	48 89 10             	mov    %rdx,(%rax)
  80179f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8017a3:	74 09                	je     8017ae <strtol+0x18c>
  8017a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017a9:	48 f7 d8             	neg    %rax
  8017ac:	eb 04                	jmp    8017b2 <strtol+0x190>
  8017ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017b2:	c9                   	leaveq 
  8017b3:	c3                   	retq   

00000000008017b4 <strstr>:
  8017b4:	55                   	push   %rbp
  8017b5:	48 89 e5             	mov    %rsp,%rbp
  8017b8:	48 83 ec 30          	sub    $0x30,%rsp
  8017bc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8017c0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8017c4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8017c8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8017cc:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8017d0:	0f b6 00             	movzbl (%rax),%eax
  8017d3:	88 45 ff             	mov    %al,-0x1(%rbp)
  8017d6:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8017da:	75 06                	jne    8017e2 <strstr+0x2e>
  8017dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017e0:	eb 6b                	jmp    80184d <strstr+0x99>
  8017e2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8017e6:	48 89 c7             	mov    %rax,%rdi
  8017e9:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  8017f0:	00 00 00 
  8017f3:	ff d0                	callq  *%rax
  8017f5:	48 98                	cltq   
  8017f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8017fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ff:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801803:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801807:	0f b6 00             	movzbl (%rax),%eax
  80180a:	88 45 ef             	mov    %al,-0x11(%rbp)
  80180d:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801811:	75 07                	jne    80181a <strstr+0x66>
  801813:	b8 00 00 00 00       	mov    $0x0,%eax
  801818:	eb 33                	jmp    80184d <strstr+0x99>
  80181a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80181e:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801821:	75 d8                	jne    8017fb <strstr+0x47>
  801823:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801827:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  80182b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80182f:	48 89 ce             	mov    %rcx,%rsi
  801832:	48 89 c7             	mov    %rax,%rdi
  801835:	48 b8 ab 12 80 00 00 	movabs $0x8012ab,%rax
  80183c:	00 00 00 
  80183f:	ff d0                	callq  *%rax
  801841:	85 c0                	test   %eax,%eax
  801843:	75 b6                	jne    8017fb <strstr+0x47>
  801845:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801849:	48 83 e8 01          	sub    $0x1,%rax
  80184d:	c9                   	leaveq 
  80184e:	c3                   	retq   

000000000080184f <syscall>:
  80184f:	55                   	push   %rbp
  801850:	48 89 e5             	mov    %rsp,%rbp
  801853:	53                   	push   %rbx
  801854:	48 83 ec 48          	sub    $0x48,%rsp
  801858:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80185b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80185e:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801862:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801866:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80186a:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  80186e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801871:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801875:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801879:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  80187d:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801881:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801885:	4c 89 c3             	mov    %r8,%rbx
  801888:	cd 30                	int    $0x30
  80188a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80188e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801892:	74 3e                	je     8018d2 <syscall+0x83>
  801894:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801899:	7e 37                	jle    8018d2 <syscall+0x83>
  80189b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80189f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8018a2:	49 89 d0             	mov    %rdx,%r8
  8018a5:	89 c1                	mov    %eax,%ecx
  8018a7:	48 ba 08 53 80 00 00 	movabs $0x805308,%rdx
  8018ae:	00 00 00 
  8018b1:	be 24 00 00 00       	mov    $0x24,%esi
  8018b6:	48 bf 25 53 80 00 00 	movabs $0x805325,%rdi
  8018bd:	00 00 00 
  8018c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8018c5:	49 b9 08 03 80 00 00 	movabs $0x800308,%r9
  8018cc:	00 00 00 
  8018cf:	41 ff d1             	callq  *%r9
  8018d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018d6:	48 83 c4 48          	add    $0x48,%rsp
  8018da:	5b                   	pop    %rbx
  8018db:	5d                   	pop    %rbp
  8018dc:	c3                   	retq   

00000000008018dd <sys_cputs>:
  8018dd:	55                   	push   %rbp
  8018de:	48 89 e5             	mov    %rsp,%rbp
  8018e1:	48 83 ec 20          	sub    $0x20,%rsp
  8018e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8018e9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018f5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018fc:	00 
  8018fd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801903:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801909:	48 89 d1             	mov    %rdx,%rcx
  80190c:	48 89 c2             	mov    %rax,%rdx
  80190f:	be 00 00 00 00       	mov    $0x0,%esi
  801914:	bf 00 00 00 00       	mov    $0x0,%edi
  801919:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801920:	00 00 00 
  801923:	ff d0                	callq  *%rax
  801925:	c9                   	leaveq 
  801926:	c3                   	retq   

0000000000801927 <sys_cgetc>:
  801927:	55                   	push   %rbp
  801928:	48 89 e5             	mov    %rsp,%rbp
  80192b:	48 83 ec 10          	sub    $0x10,%rsp
  80192f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801936:	00 
  801937:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80193d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801943:	b9 00 00 00 00       	mov    $0x0,%ecx
  801948:	ba 00 00 00 00       	mov    $0x0,%edx
  80194d:	be 00 00 00 00       	mov    $0x0,%esi
  801952:	bf 01 00 00 00       	mov    $0x1,%edi
  801957:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  80195e:	00 00 00 
  801961:	ff d0                	callq  *%rax
  801963:	c9                   	leaveq 
  801964:	c3                   	retq   

0000000000801965 <sys_env_destroy>:
  801965:	55                   	push   %rbp
  801966:	48 89 e5             	mov    %rsp,%rbp
  801969:	48 83 ec 10          	sub    $0x10,%rsp
  80196d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801970:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801973:	48 98                	cltq   
  801975:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80197c:	00 
  80197d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801983:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801989:	b9 00 00 00 00       	mov    $0x0,%ecx
  80198e:	48 89 c2             	mov    %rax,%rdx
  801991:	be 01 00 00 00       	mov    $0x1,%esi
  801996:	bf 03 00 00 00       	mov    $0x3,%edi
  80199b:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  8019a2:	00 00 00 
  8019a5:	ff d0                	callq  *%rax
  8019a7:	c9                   	leaveq 
  8019a8:	c3                   	retq   

00000000008019a9 <sys_getenvid>:
  8019a9:	55                   	push   %rbp
  8019aa:	48 89 e5             	mov    %rsp,%rbp
  8019ad:	48 83 ec 10          	sub    $0x10,%rsp
  8019b1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019b8:	00 
  8019b9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019bf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019c5:	b9 00 00 00 00       	mov    $0x0,%ecx
  8019ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8019cf:	be 00 00 00 00       	mov    $0x0,%esi
  8019d4:	bf 02 00 00 00       	mov    $0x2,%edi
  8019d9:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  8019e0:	00 00 00 
  8019e3:	ff d0                	callq  *%rax
  8019e5:	c9                   	leaveq 
  8019e6:	c3                   	retq   

00000000008019e7 <sys_yield>:
  8019e7:	55                   	push   %rbp
  8019e8:	48 89 e5             	mov    %rsp,%rbp
  8019eb:	48 83 ec 10          	sub    $0x10,%rsp
  8019ef:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019f6:	00 
  8019f7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019fd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a03:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a08:	ba 00 00 00 00       	mov    $0x0,%edx
  801a0d:	be 00 00 00 00       	mov    $0x0,%esi
  801a12:	bf 0b 00 00 00       	mov    $0xb,%edi
  801a17:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801a1e:	00 00 00 
  801a21:	ff d0                	callq  *%rax
  801a23:	c9                   	leaveq 
  801a24:	c3                   	retq   

0000000000801a25 <sys_page_alloc>:
  801a25:	55                   	push   %rbp
  801a26:	48 89 e5             	mov    %rsp,%rbp
  801a29:	48 83 ec 20          	sub    $0x20,%rsp
  801a2d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a30:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a34:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801a37:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a3a:	48 63 c8             	movslq %eax,%rcx
  801a3d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a41:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a44:	48 98                	cltq   
  801a46:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a4d:	00 
  801a4e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a54:	49 89 c8             	mov    %rcx,%r8
  801a57:	48 89 d1             	mov    %rdx,%rcx
  801a5a:	48 89 c2             	mov    %rax,%rdx
  801a5d:	be 01 00 00 00       	mov    $0x1,%esi
  801a62:	bf 04 00 00 00       	mov    $0x4,%edi
  801a67:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801a6e:	00 00 00 
  801a71:	ff d0                	callq  *%rax
  801a73:	c9                   	leaveq 
  801a74:	c3                   	retq   

0000000000801a75 <sys_page_map>:
  801a75:	55                   	push   %rbp
  801a76:	48 89 e5             	mov    %rsp,%rbp
  801a79:	48 83 ec 30          	sub    $0x30,%rsp
  801a7d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a80:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a84:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801a87:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801a8b:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801a8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801a92:	48 63 c8             	movslq %eax,%rcx
  801a95:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801a99:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a9c:	48 63 f0             	movslq %eax,%rsi
  801a9f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801aa3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801aa6:	48 98                	cltq   
  801aa8:	48 89 0c 24          	mov    %rcx,(%rsp)
  801aac:	49 89 f9             	mov    %rdi,%r9
  801aaf:	49 89 f0             	mov    %rsi,%r8
  801ab2:	48 89 d1             	mov    %rdx,%rcx
  801ab5:	48 89 c2             	mov    %rax,%rdx
  801ab8:	be 01 00 00 00       	mov    $0x1,%esi
  801abd:	bf 05 00 00 00       	mov    $0x5,%edi
  801ac2:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801ac9:	00 00 00 
  801acc:	ff d0                	callq  *%rax
  801ace:	c9                   	leaveq 
  801acf:	c3                   	retq   

0000000000801ad0 <sys_page_unmap>:
  801ad0:	55                   	push   %rbp
  801ad1:	48 89 e5             	mov    %rsp,%rbp
  801ad4:	48 83 ec 20          	sub    $0x20,%rsp
  801ad8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801adb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801adf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ae3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ae6:	48 98                	cltq   
  801ae8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aef:	00 
  801af0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801af6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801afc:	48 89 d1             	mov    %rdx,%rcx
  801aff:	48 89 c2             	mov    %rax,%rdx
  801b02:	be 01 00 00 00       	mov    $0x1,%esi
  801b07:	bf 06 00 00 00       	mov    $0x6,%edi
  801b0c:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801b13:	00 00 00 
  801b16:	ff d0                	callq  *%rax
  801b18:	c9                   	leaveq 
  801b19:	c3                   	retq   

0000000000801b1a <sys_env_set_status>:
  801b1a:	55                   	push   %rbp
  801b1b:	48 89 e5             	mov    %rsp,%rbp
  801b1e:	48 83 ec 10          	sub    $0x10,%rsp
  801b22:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b25:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801b28:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b2b:	48 63 d0             	movslq %eax,%rdx
  801b2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b31:	48 98                	cltq   
  801b33:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b3a:	00 
  801b3b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b41:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b47:	48 89 d1             	mov    %rdx,%rcx
  801b4a:	48 89 c2             	mov    %rax,%rdx
  801b4d:	be 01 00 00 00       	mov    $0x1,%esi
  801b52:	bf 08 00 00 00       	mov    $0x8,%edi
  801b57:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801b5e:	00 00 00 
  801b61:	ff d0                	callq  *%rax
  801b63:	c9                   	leaveq 
  801b64:	c3                   	retq   

0000000000801b65 <sys_env_set_trapframe>:
  801b65:	55                   	push   %rbp
  801b66:	48 89 e5             	mov    %rsp,%rbp
  801b69:	48 83 ec 20          	sub    $0x20,%rsp
  801b6d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b70:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b74:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b78:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b7b:	48 98                	cltq   
  801b7d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b84:	00 
  801b85:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b8b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b91:	48 89 d1             	mov    %rdx,%rcx
  801b94:	48 89 c2             	mov    %rax,%rdx
  801b97:	be 01 00 00 00       	mov    $0x1,%esi
  801b9c:	bf 09 00 00 00       	mov    $0x9,%edi
  801ba1:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801ba8:	00 00 00 
  801bab:	ff d0                	callq  *%rax
  801bad:	c9                   	leaveq 
  801bae:	c3                   	retq   

0000000000801baf <sys_env_set_pgfault_upcall>:
  801baf:	55                   	push   %rbp
  801bb0:	48 89 e5             	mov    %rsp,%rbp
  801bb3:	48 83 ec 20          	sub    $0x20,%rsp
  801bb7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bba:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bbe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bc5:	48 98                	cltq   
  801bc7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bce:	00 
  801bcf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bd5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bdb:	48 89 d1             	mov    %rdx,%rcx
  801bde:	48 89 c2             	mov    %rax,%rdx
  801be1:	be 01 00 00 00       	mov    $0x1,%esi
  801be6:	bf 0a 00 00 00       	mov    $0xa,%edi
  801beb:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801bf2:	00 00 00 
  801bf5:	ff d0                	callq  *%rax
  801bf7:	c9                   	leaveq 
  801bf8:	c3                   	retq   

0000000000801bf9 <sys_ipc_try_send>:
  801bf9:	55                   	push   %rbp
  801bfa:	48 89 e5             	mov    %rsp,%rbp
  801bfd:	48 83 ec 20          	sub    $0x20,%rsp
  801c01:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c04:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c08:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801c0c:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801c0f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c12:	48 63 f0             	movslq %eax,%rsi
  801c15:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801c19:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c1c:	48 98                	cltq   
  801c1e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c22:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c29:	00 
  801c2a:	49 89 f1             	mov    %rsi,%r9
  801c2d:	49 89 c8             	mov    %rcx,%r8
  801c30:	48 89 d1             	mov    %rdx,%rcx
  801c33:	48 89 c2             	mov    %rax,%rdx
  801c36:	be 00 00 00 00       	mov    $0x0,%esi
  801c3b:	bf 0c 00 00 00       	mov    $0xc,%edi
  801c40:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801c47:	00 00 00 
  801c4a:	ff d0                	callq  *%rax
  801c4c:	c9                   	leaveq 
  801c4d:	c3                   	retq   

0000000000801c4e <sys_ipc_recv>:
  801c4e:	55                   	push   %rbp
  801c4f:	48 89 e5             	mov    %rsp,%rbp
  801c52:	48 83 ec 10          	sub    $0x10,%rsp
  801c56:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c5e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c65:	00 
  801c66:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c6c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c72:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c77:	48 89 c2             	mov    %rax,%rdx
  801c7a:	be 01 00 00 00       	mov    $0x1,%esi
  801c7f:	bf 0d 00 00 00       	mov    $0xd,%edi
  801c84:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801c8b:	00 00 00 
  801c8e:	ff d0                	callq  *%rax
  801c90:	c9                   	leaveq 
  801c91:	c3                   	retq   

0000000000801c92 <sys_time_msec>:
  801c92:	55                   	push   %rbp
  801c93:	48 89 e5             	mov    %rsp,%rbp
  801c96:	48 83 ec 10          	sub    $0x10,%rsp
  801c9a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ca1:	00 
  801ca2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ca8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cae:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cb3:	ba 00 00 00 00       	mov    $0x0,%edx
  801cb8:	be 00 00 00 00       	mov    $0x0,%esi
  801cbd:	bf 0e 00 00 00       	mov    $0xe,%edi
  801cc2:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801cc9:	00 00 00 
  801ccc:	ff d0                	callq  *%rax
  801cce:	c9                   	leaveq 
  801ccf:	c3                   	retq   

0000000000801cd0 <sys_net_transmit>:
  801cd0:	55                   	push   %rbp
  801cd1:	48 89 e5             	mov    %rsp,%rbp
  801cd4:	48 83 ec 20          	sub    $0x20,%rsp
  801cd8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801cdc:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801cdf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ce6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ced:	00 
  801cee:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cf4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cfa:	48 89 d1             	mov    %rdx,%rcx
  801cfd:	48 89 c2             	mov    %rax,%rdx
  801d00:	be 00 00 00 00       	mov    $0x0,%esi
  801d05:	bf 0f 00 00 00       	mov    $0xf,%edi
  801d0a:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801d11:	00 00 00 
  801d14:	ff d0                	callq  *%rax
  801d16:	c9                   	leaveq 
  801d17:	c3                   	retq   

0000000000801d18 <sys_net_receive>:
  801d18:	55                   	push   %rbp
  801d19:	48 89 e5             	mov    %rsp,%rbp
  801d1c:	48 83 ec 20          	sub    $0x20,%rsp
  801d20:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d24:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801d27:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801d2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d2e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d35:	00 
  801d36:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d3c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d42:	48 89 d1             	mov    %rdx,%rcx
  801d45:	48 89 c2             	mov    %rax,%rdx
  801d48:	be 00 00 00 00       	mov    $0x0,%esi
  801d4d:	bf 10 00 00 00       	mov    $0x10,%edi
  801d52:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801d59:	00 00 00 
  801d5c:	ff d0                	callq  *%rax
  801d5e:	c9                   	leaveq 
  801d5f:	c3                   	retq   

0000000000801d60 <sys_ept_map>:
  801d60:	55                   	push   %rbp
  801d61:	48 89 e5             	mov    %rsp,%rbp
  801d64:	48 83 ec 30          	sub    $0x30,%rsp
  801d68:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d6b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d6f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d72:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801d76:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801d7a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801d7d:	48 63 c8             	movslq %eax,%rcx
  801d80:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801d84:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d87:	48 63 f0             	movslq %eax,%rsi
  801d8a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d8e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d91:	48 98                	cltq   
  801d93:	48 89 0c 24          	mov    %rcx,(%rsp)
  801d97:	49 89 f9             	mov    %rdi,%r9
  801d9a:	49 89 f0             	mov    %rsi,%r8
  801d9d:	48 89 d1             	mov    %rdx,%rcx
  801da0:	48 89 c2             	mov    %rax,%rdx
  801da3:	be 00 00 00 00       	mov    $0x0,%esi
  801da8:	bf 11 00 00 00       	mov    $0x11,%edi
  801dad:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801db4:	00 00 00 
  801db7:	ff d0                	callq  *%rax
  801db9:	c9                   	leaveq 
  801dba:	c3                   	retq   

0000000000801dbb <sys_env_mkguest>:
  801dbb:	55                   	push   %rbp
  801dbc:	48 89 e5             	mov    %rsp,%rbp
  801dbf:	48 83 ec 20          	sub    $0x20,%rsp
  801dc3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801dc7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801dcb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dd3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dda:	00 
  801ddb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801de1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801de7:	48 89 d1             	mov    %rdx,%rcx
  801dea:	48 89 c2             	mov    %rax,%rdx
  801ded:	be 00 00 00 00       	mov    $0x0,%esi
  801df2:	bf 12 00 00 00       	mov    $0x12,%edi
  801df7:	48 b8 4f 18 80 00 00 	movabs $0x80184f,%rax
  801dfe:	00 00 00 
  801e01:	ff d0                	callq  *%rax
  801e03:	c9                   	leaveq 
  801e04:	c3                   	retq   

0000000000801e05 <fd2num>:
  801e05:	55                   	push   %rbp
  801e06:	48 89 e5             	mov    %rsp,%rbp
  801e09:	48 83 ec 08          	sub    $0x8,%rsp
  801e0d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e11:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801e15:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801e1c:	ff ff ff 
  801e1f:	48 01 d0             	add    %rdx,%rax
  801e22:	48 c1 e8 0c          	shr    $0xc,%rax
  801e26:	c9                   	leaveq 
  801e27:	c3                   	retq   

0000000000801e28 <fd2data>:
  801e28:	55                   	push   %rbp
  801e29:	48 89 e5             	mov    %rsp,%rbp
  801e2c:	48 83 ec 08          	sub    $0x8,%rsp
  801e30:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e38:	48 89 c7             	mov    %rax,%rdi
  801e3b:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  801e42:	00 00 00 
  801e45:	ff d0                	callq  *%rax
  801e47:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801e4d:	48 c1 e0 0c          	shl    $0xc,%rax
  801e51:	c9                   	leaveq 
  801e52:	c3                   	retq   

0000000000801e53 <fd_alloc>:
  801e53:	55                   	push   %rbp
  801e54:	48 89 e5             	mov    %rsp,%rbp
  801e57:	48 83 ec 18          	sub    $0x18,%rsp
  801e5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801e5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801e66:	eb 6b                	jmp    801ed3 <fd_alloc+0x80>
  801e68:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e6b:	48 98                	cltq   
  801e6d:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801e73:	48 c1 e0 0c          	shl    $0xc,%rax
  801e77:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801e7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e7f:	48 c1 e8 15          	shr    $0x15,%rax
  801e83:	48 89 c2             	mov    %rax,%rdx
  801e86:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801e8d:	01 00 00 
  801e90:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801e94:	83 e0 01             	and    $0x1,%eax
  801e97:	48 85 c0             	test   %rax,%rax
  801e9a:	74 21                	je     801ebd <fd_alloc+0x6a>
  801e9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ea0:	48 c1 e8 0c          	shr    $0xc,%rax
  801ea4:	48 89 c2             	mov    %rax,%rdx
  801ea7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801eae:	01 00 00 
  801eb1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801eb5:	83 e0 01             	and    $0x1,%eax
  801eb8:	48 85 c0             	test   %rax,%rax
  801ebb:	75 12                	jne    801ecf <fd_alloc+0x7c>
  801ebd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ec1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ec5:	48 89 10             	mov    %rdx,(%rax)
  801ec8:	b8 00 00 00 00       	mov    $0x0,%eax
  801ecd:	eb 1a                	jmp    801ee9 <fd_alloc+0x96>
  801ecf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801ed3:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801ed7:	7e 8f                	jle    801e68 <fd_alloc+0x15>
  801ed9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801edd:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801ee4:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801ee9:	c9                   	leaveq 
  801eea:	c3                   	retq   

0000000000801eeb <fd_lookup>:
  801eeb:	55                   	push   %rbp
  801eec:	48 89 e5             	mov    %rsp,%rbp
  801eef:	48 83 ec 20          	sub    $0x20,%rsp
  801ef3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801ef6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801efa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801efe:	78 06                	js     801f06 <fd_lookup+0x1b>
  801f00:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801f04:	7e 07                	jle    801f0d <fd_lookup+0x22>
  801f06:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f0b:	eb 6c                	jmp    801f79 <fd_lookup+0x8e>
  801f0d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f10:	48 98                	cltq   
  801f12:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801f18:	48 c1 e0 0c          	shl    $0xc,%rax
  801f1c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801f20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f24:	48 c1 e8 15          	shr    $0x15,%rax
  801f28:	48 89 c2             	mov    %rax,%rdx
  801f2b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801f32:	01 00 00 
  801f35:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f39:	83 e0 01             	and    $0x1,%eax
  801f3c:	48 85 c0             	test   %rax,%rax
  801f3f:	74 21                	je     801f62 <fd_lookup+0x77>
  801f41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f45:	48 c1 e8 0c          	shr    $0xc,%rax
  801f49:	48 89 c2             	mov    %rax,%rdx
  801f4c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f53:	01 00 00 
  801f56:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f5a:	83 e0 01             	and    $0x1,%eax
  801f5d:	48 85 c0             	test   %rax,%rax
  801f60:	75 07                	jne    801f69 <fd_lookup+0x7e>
  801f62:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f67:	eb 10                	jmp    801f79 <fd_lookup+0x8e>
  801f69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f6d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f71:	48 89 10             	mov    %rdx,(%rax)
  801f74:	b8 00 00 00 00       	mov    $0x0,%eax
  801f79:	c9                   	leaveq 
  801f7a:	c3                   	retq   

0000000000801f7b <fd_close>:
  801f7b:	55                   	push   %rbp
  801f7c:	48 89 e5             	mov    %rsp,%rbp
  801f7f:	48 83 ec 30          	sub    $0x30,%rsp
  801f83:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801f87:	89 f0                	mov    %esi,%eax
  801f89:	88 45 d4             	mov    %al,-0x2c(%rbp)
  801f8c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f90:	48 89 c7             	mov    %rax,%rdi
  801f93:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  801f9a:	00 00 00 
  801f9d:	ff d0                	callq  *%rax
  801f9f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801fa3:	48 89 d6             	mov    %rdx,%rsi
  801fa6:	89 c7                	mov    %eax,%edi
  801fa8:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  801faf:	00 00 00 
  801fb2:	ff d0                	callq  *%rax
  801fb4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fb7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801fbb:	78 0a                	js     801fc7 <fd_close+0x4c>
  801fbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fc1:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801fc5:	74 12                	je     801fd9 <fd_close+0x5e>
  801fc7:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801fcb:	74 05                	je     801fd2 <fd_close+0x57>
  801fcd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fd0:	eb 05                	jmp    801fd7 <fd_close+0x5c>
  801fd2:	b8 00 00 00 00       	mov    $0x0,%eax
  801fd7:	eb 69                	jmp    802042 <fd_close+0xc7>
  801fd9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fdd:	8b 00                	mov    (%rax),%eax
  801fdf:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801fe3:	48 89 d6             	mov    %rdx,%rsi
  801fe6:	89 c7                	mov    %eax,%edi
  801fe8:	48 b8 44 20 80 00 00 	movabs $0x802044,%rax
  801fef:	00 00 00 
  801ff2:	ff d0                	callq  *%rax
  801ff4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ff7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801ffb:	78 2a                	js     802027 <fd_close+0xac>
  801ffd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802001:	48 8b 40 20          	mov    0x20(%rax),%rax
  802005:	48 85 c0             	test   %rax,%rax
  802008:	74 16                	je     802020 <fd_close+0xa5>
  80200a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80200e:	48 8b 40 20          	mov    0x20(%rax),%rax
  802012:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802016:	48 89 d7             	mov    %rdx,%rdi
  802019:	ff d0                	callq  *%rax
  80201b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80201e:	eb 07                	jmp    802027 <fd_close+0xac>
  802020:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802027:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80202b:	48 89 c6             	mov    %rax,%rsi
  80202e:	bf 00 00 00 00       	mov    $0x0,%edi
  802033:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  80203a:	00 00 00 
  80203d:	ff d0                	callq  *%rax
  80203f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802042:	c9                   	leaveq 
  802043:	c3                   	retq   

0000000000802044 <dev_lookup>:
  802044:	55                   	push   %rbp
  802045:	48 89 e5             	mov    %rsp,%rbp
  802048:	48 83 ec 20          	sub    $0x20,%rsp
  80204c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80204f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802053:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80205a:	eb 41                	jmp    80209d <dev_lookup+0x59>
  80205c:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802063:	00 00 00 
  802066:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802069:	48 63 d2             	movslq %edx,%rdx
  80206c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802070:	8b 00                	mov    (%rax),%eax
  802072:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802075:	75 22                	jne    802099 <dev_lookup+0x55>
  802077:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80207e:	00 00 00 
  802081:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802084:	48 63 d2             	movslq %edx,%rdx
  802087:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80208b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80208f:	48 89 10             	mov    %rdx,(%rax)
  802092:	b8 00 00 00 00       	mov    $0x0,%eax
  802097:	eb 60                	jmp    8020f9 <dev_lookup+0xb5>
  802099:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80209d:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  8020a4:	00 00 00 
  8020a7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8020aa:	48 63 d2             	movslq %edx,%rdx
  8020ad:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020b1:	48 85 c0             	test   %rax,%rax
  8020b4:	75 a6                	jne    80205c <dev_lookup+0x18>
  8020b6:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8020bd:	00 00 00 
  8020c0:	48 8b 00             	mov    (%rax),%rax
  8020c3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8020c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8020cc:	89 c6                	mov    %eax,%esi
  8020ce:	48 bf 38 53 80 00 00 	movabs $0x805338,%rdi
  8020d5:	00 00 00 
  8020d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8020dd:	48 b9 41 05 80 00 00 	movabs $0x800541,%rcx
  8020e4:	00 00 00 
  8020e7:	ff d1                	callq  *%rcx
  8020e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8020ed:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8020f4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8020f9:	c9                   	leaveq 
  8020fa:	c3                   	retq   

00000000008020fb <close>:
  8020fb:	55                   	push   %rbp
  8020fc:	48 89 e5             	mov    %rsp,%rbp
  8020ff:	48 83 ec 20          	sub    $0x20,%rsp
  802103:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802106:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80210a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80210d:	48 89 d6             	mov    %rdx,%rsi
  802110:	89 c7                	mov    %eax,%edi
  802112:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  802119:	00 00 00 
  80211c:	ff d0                	callq  *%rax
  80211e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802121:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802125:	79 05                	jns    80212c <close+0x31>
  802127:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80212a:	eb 18                	jmp    802144 <close+0x49>
  80212c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802130:	be 01 00 00 00       	mov    $0x1,%esi
  802135:	48 89 c7             	mov    %rax,%rdi
  802138:	48 b8 7b 1f 80 00 00 	movabs $0x801f7b,%rax
  80213f:	00 00 00 
  802142:	ff d0                	callq  *%rax
  802144:	c9                   	leaveq 
  802145:	c3                   	retq   

0000000000802146 <close_all>:
  802146:	55                   	push   %rbp
  802147:	48 89 e5             	mov    %rsp,%rbp
  80214a:	48 83 ec 10          	sub    $0x10,%rsp
  80214e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802155:	eb 15                	jmp    80216c <close_all+0x26>
  802157:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80215a:	89 c7                	mov    %eax,%edi
  80215c:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802163:	00 00 00 
  802166:	ff d0                	callq  *%rax
  802168:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80216c:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802170:	7e e5                	jle    802157 <close_all+0x11>
  802172:	c9                   	leaveq 
  802173:	c3                   	retq   

0000000000802174 <dup>:
  802174:	55                   	push   %rbp
  802175:	48 89 e5             	mov    %rsp,%rbp
  802178:	48 83 ec 40          	sub    $0x40,%rsp
  80217c:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80217f:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802182:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802186:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802189:	48 89 d6             	mov    %rdx,%rsi
  80218c:	89 c7                	mov    %eax,%edi
  80218e:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  802195:	00 00 00 
  802198:	ff d0                	callq  *%rax
  80219a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80219d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021a1:	79 08                	jns    8021ab <dup+0x37>
  8021a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021a6:	e9 70 01 00 00       	jmpq   80231b <dup+0x1a7>
  8021ab:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8021ae:	89 c7                	mov    %eax,%edi
  8021b0:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  8021b7:	00 00 00 
  8021ba:	ff d0                	callq  *%rax
  8021bc:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8021bf:	48 98                	cltq   
  8021c1:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8021c7:	48 c1 e0 0c          	shl    $0xc,%rax
  8021cb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8021cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8021d3:	48 89 c7             	mov    %rax,%rdi
  8021d6:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8021dd:	00 00 00 
  8021e0:	ff d0                	callq  *%rax
  8021e2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8021e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8021ea:	48 89 c7             	mov    %rax,%rdi
  8021ed:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8021f4:	00 00 00 
  8021f7:	ff d0                	callq  *%rax
  8021f9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8021fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802201:	48 c1 e8 15          	shr    $0x15,%rax
  802205:	48 89 c2             	mov    %rax,%rdx
  802208:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80220f:	01 00 00 
  802212:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802216:	83 e0 01             	and    $0x1,%eax
  802219:	48 85 c0             	test   %rax,%rax
  80221c:	74 73                	je     802291 <dup+0x11d>
  80221e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802222:	48 c1 e8 0c          	shr    $0xc,%rax
  802226:	48 89 c2             	mov    %rax,%rdx
  802229:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802230:	01 00 00 
  802233:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802237:	83 e0 01             	and    $0x1,%eax
  80223a:	48 85 c0             	test   %rax,%rax
  80223d:	74 52                	je     802291 <dup+0x11d>
  80223f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802243:	48 c1 e8 0c          	shr    $0xc,%rax
  802247:	48 89 c2             	mov    %rax,%rdx
  80224a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802251:	01 00 00 
  802254:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802258:	25 07 0e 00 00       	and    $0xe07,%eax
  80225d:	89 c1                	mov    %eax,%ecx
  80225f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802263:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802267:	41 89 c8             	mov    %ecx,%r8d
  80226a:	48 89 d1             	mov    %rdx,%rcx
  80226d:	ba 00 00 00 00       	mov    $0x0,%edx
  802272:	48 89 c6             	mov    %rax,%rsi
  802275:	bf 00 00 00 00       	mov    $0x0,%edi
  80227a:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  802281:	00 00 00 
  802284:	ff d0                	callq  *%rax
  802286:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802289:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80228d:	79 02                	jns    802291 <dup+0x11d>
  80228f:	eb 57                	jmp    8022e8 <dup+0x174>
  802291:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802295:	48 c1 e8 0c          	shr    $0xc,%rax
  802299:	48 89 c2             	mov    %rax,%rdx
  80229c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8022a3:	01 00 00 
  8022a6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8022aa:	25 07 0e 00 00       	and    $0xe07,%eax
  8022af:	89 c1                	mov    %eax,%ecx
  8022b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8022b5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8022b9:	41 89 c8             	mov    %ecx,%r8d
  8022bc:	48 89 d1             	mov    %rdx,%rcx
  8022bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8022c4:	48 89 c6             	mov    %rax,%rsi
  8022c7:	bf 00 00 00 00       	mov    $0x0,%edi
  8022cc:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  8022d3:	00 00 00 
  8022d6:	ff d0                	callq  *%rax
  8022d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022df:	79 02                	jns    8022e3 <dup+0x16f>
  8022e1:	eb 05                	jmp    8022e8 <dup+0x174>
  8022e3:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8022e6:	eb 33                	jmp    80231b <dup+0x1a7>
  8022e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022ec:	48 89 c6             	mov    %rax,%rsi
  8022ef:	bf 00 00 00 00       	mov    $0x0,%edi
  8022f4:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  8022fb:	00 00 00 
  8022fe:	ff d0                	callq  *%rax
  802300:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802304:	48 89 c6             	mov    %rax,%rsi
  802307:	bf 00 00 00 00       	mov    $0x0,%edi
  80230c:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  802313:	00 00 00 
  802316:	ff d0                	callq  *%rax
  802318:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80231b:	c9                   	leaveq 
  80231c:	c3                   	retq   

000000000080231d <read>:
  80231d:	55                   	push   %rbp
  80231e:	48 89 e5             	mov    %rsp,%rbp
  802321:	48 83 ec 40          	sub    $0x40,%rsp
  802325:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802328:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80232c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802330:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802334:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802337:	48 89 d6             	mov    %rdx,%rsi
  80233a:	89 c7                	mov    %eax,%edi
  80233c:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  802343:	00 00 00 
  802346:	ff d0                	callq  *%rax
  802348:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80234b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80234f:	78 24                	js     802375 <read+0x58>
  802351:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802355:	8b 00                	mov    (%rax),%eax
  802357:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80235b:	48 89 d6             	mov    %rdx,%rsi
  80235e:	89 c7                	mov    %eax,%edi
  802360:	48 b8 44 20 80 00 00 	movabs $0x802044,%rax
  802367:	00 00 00 
  80236a:	ff d0                	callq  *%rax
  80236c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80236f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802373:	79 05                	jns    80237a <read+0x5d>
  802375:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802378:	eb 76                	jmp    8023f0 <read+0xd3>
  80237a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80237e:	8b 40 08             	mov    0x8(%rax),%eax
  802381:	83 e0 03             	and    $0x3,%eax
  802384:	83 f8 01             	cmp    $0x1,%eax
  802387:	75 3a                	jne    8023c3 <read+0xa6>
  802389:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802390:	00 00 00 
  802393:	48 8b 00             	mov    (%rax),%rax
  802396:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80239c:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80239f:	89 c6                	mov    %eax,%esi
  8023a1:	48 bf 57 53 80 00 00 	movabs $0x805357,%rdi
  8023a8:	00 00 00 
  8023ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8023b0:	48 b9 41 05 80 00 00 	movabs $0x800541,%rcx
  8023b7:	00 00 00 
  8023ba:	ff d1                	callq  *%rcx
  8023bc:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8023c1:	eb 2d                	jmp    8023f0 <read+0xd3>
  8023c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023c7:	48 8b 40 10          	mov    0x10(%rax),%rax
  8023cb:	48 85 c0             	test   %rax,%rax
  8023ce:	75 07                	jne    8023d7 <read+0xba>
  8023d0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8023d5:	eb 19                	jmp    8023f0 <read+0xd3>
  8023d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023db:	48 8b 40 10          	mov    0x10(%rax),%rax
  8023df:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8023e3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8023e7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8023eb:	48 89 cf             	mov    %rcx,%rdi
  8023ee:	ff d0                	callq  *%rax
  8023f0:	c9                   	leaveq 
  8023f1:	c3                   	retq   

00000000008023f2 <readn>:
  8023f2:	55                   	push   %rbp
  8023f3:	48 89 e5             	mov    %rsp,%rbp
  8023f6:	48 83 ec 30          	sub    $0x30,%rsp
  8023fa:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023fd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802401:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802405:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80240c:	eb 49                	jmp    802457 <readn+0x65>
  80240e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802411:	48 98                	cltq   
  802413:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802417:	48 29 c2             	sub    %rax,%rdx
  80241a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80241d:	48 63 c8             	movslq %eax,%rcx
  802420:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802424:	48 01 c1             	add    %rax,%rcx
  802427:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80242a:	48 89 ce             	mov    %rcx,%rsi
  80242d:	89 c7                	mov    %eax,%edi
  80242f:	48 b8 1d 23 80 00 00 	movabs $0x80231d,%rax
  802436:	00 00 00 
  802439:	ff d0                	callq  *%rax
  80243b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80243e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802442:	79 05                	jns    802449 <readn+0x57>
  802444:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802447:	eb 1c                	jmp    802465 <readn+0x73>
  802449:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80244d:	75 02                	jne    802451 <readn+0x5f>
  80244f:	eb 11                	jmp    802462 <readn+0x70>
  802451:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802454:	01 45 fc             	add    %eax,-0x4(%rbp)
  802457:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80245a:	48 98                	cltq   
  80245c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802460:	72 ac                	jb     80240e <readn+0x1c>
  802462:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802465:	c9                   	leaveq 
  802466:	c3                   	retq   

0000000000802467 <write>:
  802467:	55                   	push   %rbp
  802468:	48 89 e5             	mov    %rsp,%rbp
  80246b:	48 83 ec 40          	sub    $0x40,%rsp
  80246f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802472:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802476:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80247a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80247e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802481:	48 89 d6             	mov    %rdx,%rsi
  802484:	89 c7                	mov    %eax,%edi
  802486:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  80248d:	00 00 00 
  802490:	ff d0                	callq  *%rax
  802492:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802495:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802499:	78 24                	js     8024bf <write+0x58>
  80249b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80249f:	8b 00                	mov    (%rax),%eax
  8024a1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8024a5:	48 89 d6             	mov    %rdx,%rsi
  8024a8:	89 c7                	mov    %eax,%edi
  8024aa:	48 b8 44 20 80 00 00 	movabs $0x802044,%rax
  8024b1:	00 00 00 
  8024b4:	ff d0                	callq  *%rax
  8024b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8024b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8024bd:	79 05                	jns    8024c4 <write+0x5d>
  8024bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024c2:	eb 75                	jmp    802539 <write+0xd2>
  8024c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8024c8:	8b 40 08             	mov    0x8(%rax),%eax
  8024cb:	83 e0 03             	and    $0x3,%eax
  8024ce:	85 c0                	test   %eax,%eax
  8024d0:	75 3a                	jne    80250c <write+0xa5>
  8024d2:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8024d9:	00 00 00 
  8024dc:	48 8b 00             	mov    (%rax),%rax
  8024df:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8024e5:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8024e8:	89 c6                	mov    %eax,%esi
  8024ea:	48 bf 73 53 80 00 00 	movabs $0x805373,%rdi
  8024f1:	00 00 00 
  8024f4:	b8 00 00 00 00       	mov    $0x0,%eax
  8024f9:	48 b9 41 05 80 00 00 	movabs $0x800541,%rcx
  802500:	00 00 00 
  802503:	ff d1                	callq  *%rcx
  802505:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80250a:	eb 2d                	jmp    802539 <write+0xd2>
  80250c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802510:	48 8b 40 18          	mov    0x18(%rax),%rax
  802514:	48 85 c0             	test   %rax,%rax
  802517:	75 07                	jne    802520 <write+0xb9>
  802519:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80251e:	eb 19                	jmp    802539 <write+0xd2>
  802520:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802524:	48 8b 40 18          	mov    0x18(%rax),%rax
  802528:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80252c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802530:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802534:	48 89 cf             	mov    %rcx,%rdi
  802537:	ff d0                	callq  *%rax
  802539:	c9                   	leaveq 
  80253a:	c3                   	retq   

000000000080253b <seek>:
  80253b:	55                   	push   %rbp
  80253c:	48 89 e5             	mov    %rsp,%rbp
  80253f:	48 83 ec 18          	sub    $0x18,%rsp
  802543:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802546:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802549:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80254d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802550:	48 89 d6             	mov    %rdx,%rsi
  802553:	89 c7                	mov    %eax,%edi
  802555:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  80255c:	00 00 00 
  80255f:	ff d0                	callq  *%rax
  802561:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802564:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802568:	79 05                	jns    80256f <seek+0x34>
  80256a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80256d:	eb 0f                	jmp    80257e <seek+0x43>
  80256f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802573:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802576:	89 50 04             	mov    %edx,0x4(%rax)
  802579:	b8 00 00 00 00       	mov    $0x0,%eax
  80257e:	c9                   	leaveq 
  80257f:	c3                   	retq   

0000000000802580 <ftruncate>:
  802580:	55                   	push   %rbp
  802581:	48 89 e5             	mov    %rsp,%rbp
  802584:	48 83 ec 30          	sub    $0x30,%rsp
  802588:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80258b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80258e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802592:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802595:	48 89 d6             	mov    %rdx,%rsi
  802598:	89 c7                	mov    %eax,%edi
  80259a:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  8025a1:	00 00 00 
  8025a4:	ff d0                	callq  *%rax
  8025a6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025a9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025ad:	78 24                	js     8025d3 <ftruncate+0x53>
  8025af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025b3:	8b 00                	mov    (%rax),%eax
  8025b5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8025b9:	48 89 d6             	mov    %rdx,%rsi
  8025bc:	89 c7                	mov    %eax,%edi
  8025be:	48 b8 44 20 80 00 00 	movabs $0x802044,%rax
  8025c5:	00 00 00 
  8025c8:	ff d0                	callq  *%rax
  8025ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025d1:	79 05                	jns    8025d8 <ftruncate+0x58>
  8025d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025d6:	eb 72                	jmp    80264a <ftruncate+0xca>
  8025d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025dc:	8b 40 08             	mov    0x8(%rax),%eax
  8025df:	83 e0 03             	and    $0x3,%eax
  8025e2:	85 c0                	test   %eax,%eax
  8025e4:	75 3a                	jne    802620 <ftruncate+0xa0>
  8025e6:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8025ed:	00 00 00 
  8025f0:	48 8b 00             	mov    (%rax),%rax
  8025f3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8025f9:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8025fc:	89 c6                	mov    %eax,%esi
  8025fe:	48 bf 90 53 80 00 00 	movabs $0x805390,%rdi
  802605:	00 00 00 
  802608:	b8 00 00 00 00       	mov    $0x0,%eax
  80260d:	48 b9 41 05 80 00 00 	movabs $0x800541,%rcx
  802614:	00 00 00 
  802617:	ff d1                	callq  *%rcx
  802619:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80261e:	eb 2a                	jmp    80264a <ftruncate+0xca>
  802620:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802624:	48 8b 40 30          	mov    0x30(%rax),%rax
  802628:	48 85 c0             	test   %rax,%rax
  80262b:	75 07                	jne    802634 <ftruncate+0xb4>
  80262d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802632:	eb 16                	jmp    80264a <ftruncate+0xca>
  802634:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802638:	48 8b 40 30          	mov    0x30(%rax),%rax
  80263c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802640:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802643:	89 ce                	mov    %ecx,%esi
  802645:	48 89 d7             	mov    %rdx,%rdi
  802648:	ff d0                	callq  *%rax
  80264a:	c9                   	leaveq 
  80264b:	c3                   	retq   

000000000080264c <fstat>:
  80264c:	55                   	push   %rbp
  80264d:	48 89 e5             	mov    %rsp,%rbp
  802650:	48 83 ec 30          	sub    $0x30,%rsp
  802654:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802657:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80265b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80265f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802662:	48 89 d6             	mov    %rdx,%rsi
  802665:	89 c7                	mov    %eax,%edi
  802667:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  80266e:	00 00 00 
  802671:	ff d0                	callq  *%rax
  802673:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802676:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80267a:	78 24                	js     8026a0 <fstat+0x54>
  80267c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802680:	8b 00                	mov    (%rax),%eax
  802682:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802686:	48 89 d6             	mov    %rdx,%rsi
  802689:	89 c7                	mov    %eax,%edi
  80268b:	48 b8 44 20 80 00 00 	movabs $0x802044,%rax
  802692:	00 00 00 
  802695:	ff d0                	callq  *%rax
  802697:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80269a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80269e:	79 05                	jns    8026a5 <fstat+0x59>
  8026a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026a3:	eb 5e                	jmp    802703 <fstat+0xb7>
  8026a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026a9:	48 8b 40 28          	mov    0x28(%rax),%rax
  8026ad:	48 85 c0             	test   %rax,%rax
  8026b0:	75 07                	jne    8026b9 <fstat+0x6d>
  8026b2:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8026b7:	eb 4a                	jmp    802703 <fstat+0xb7>
  8026b9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8026bd:	c6 00 00             	movb   $0x0,(%rax)
  8026c0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8026c4:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  8026cb:	00 00 00 
  8026ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8026d2:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  8026d9:	00 00 00 
  8026dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8026e0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8026e4:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  8026eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026ef:	48 8b 40 28          	mov    0x28(%rax),%rax
  8026f3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8026f7:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8026fb:	48 89 ce             	mov    %rcx,%rsi
  8026fe:	48 89 d7             	mov    %rdx,%rdi
  802701:	ff d0                	callq  *%rax
  802703:	c9                   	leaveq 
  802704:	c3                   	retq   

0000000000802705 <stat>:
  802705:	55                   	push   %rbp
  802706:	48 89 e5             	mov    %rsp,%rbp
  802709:	48 83 ec 20          	sub    $0x20,%rsp
  80270d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802711:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802715:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802719:	be 00 00 00 00       	mov    $0x0,%esi
  80271e:	48 89 c7             	mov    %rax,%rdi
  802721:	48 b8 f3 27 80 00 00 	movabs $0x8027f3,%rax
  802728:	00 00 00 
  80272b:	ff d0                	callq  *%rax
  80272d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802730:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802734:	79 05                	jns    80273b <stat+0x36>
  802736:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802739:	eb 2f                	jmp    80276a <stat+0x65>
  80273b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80273f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802742:	48 89 d6             	mov    %rdx,%rsi
  802745:	89 c7                	mov    %eax,%edi
  802747:	48 b8 4c 26 80 00 00 	movabs $0x80264c,%rax
  80274e:	00 00 00 
  802751:	ff d0                	callq  *%rax
  802753:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802756:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802759:	89 c7                	mov    %eax,%edi
  80275b:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802762:	00 00 00 
  802765:	ff d0                	callq  *%rax
  802767:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80276a:	c9                   	leaveq 
  80276b:	c3                   	retq   

000000000080276c <fsipc>:
  80276c:	55                   	push   %rbp
  80276d:	48 89 e5             	mov    %rsp,%rbp
  802770:	48 83 ec 10          	sub    $0x10,%rsp
  802774:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802777:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80277b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802782:	00 00 00 
  802785:	8b 00                	mov    (%rax),%eax
  802787:	85 c0                	test   %eax,%eax
  802789:	75 1d                	jne    8027a8 <fsipc+0x3c>
  80278b:	bf 01 00 00 00       	mov    $0x1,%edi
  802790:	48 b8 ee 4b 80 00 00 	movabs $0x804bee,%rax
  802797:	00 00 00 
  80279a:	ff d0                	callq  *%rax
  80279c:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  8027a3:	00 00 00 
  8027a6:	89 02                	mov    %eax,(%rdx)
  8027a8:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8027af:	00 00 00 
  8027b2:	8b 00                	mov    (%rax),%eax
  8027b4:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8027b7:	b9 07 00 00 00       	mov    $0x7,%ecx
  8027bc:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  8027c3:	00 00 00 
  8027c6:	89 c7                	mov    %eax,%edi
  8027c8:	48 b8 e3 4a 80 00 00 	movabs $0x804ae3,%rax
  8027cf:	00 00 00 
  8027d2:	ff d0                	callq  *%rax
  8027d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027d8:	ba 00 00 00 00       	mov    $0x0,%edx
  8027dd:	48 89 c6             	mov    %rax,%rsi
  8027e0:	bf 00 00 00 00       	mov    $0x0,%edi
  8027e5:	48 b8 22 4a 80 00 00 	movabs $0x804a22,%rax
  8027ec:	00 00 00 
  8027ef:	ff d0                	callq  *%rax
  8027f1:	c9                   	leaveq 
  8027f2:	c3                   	retq   

00000000008027f3 <open>:
  8027f3:	55                   	push   %rbp
  8027f4:	48 89 e5             	mov    %rsp,%rbp
  8027f7:	48 83 ec 20          	sub    $0x20,%rsp
  8027fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8027ff:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802802:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802806:	48 89 c7             	mov    %rax,%rdi
  802809:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  802810:	00 00 00 
  802813:	ff d0                	callq  *%rax
  802815:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  80281a:	7e 0a                	jle    802826 <open+0x33>
  80281c:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802821:	e9 a5 00 00 00       	jmpq   8028cb <open+0xd8>
  802826:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80282a:	48 89 c7             	mov    %rax,%rdi
  80282d:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  802834:	00 00 00 
  802837:	ff d0                	callq  *%rax
  802839:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80283c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802840:	79 08                	jns    80284a <open+0x57>
  802842:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802845:	e9 81 00 00 00       	jmpq   8028cb <open+0xd8>
  80284a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80284e:	48 89 c6             	mov    %rax,%rsi
  802851:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802858:	00 00 00 
  80285b:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  802862:	00 00 00 
  802865:	ff d0                	callq  *%rax
  802867:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80286e:	00 00 00 
  802871:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802874:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  80287a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80287e:	48 89 c6             	mov    %rax,%rsi
  802881:	bf 01 00 00 00       	mov    $0x1,%edi
  802886:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  80288d:	00 00 00 
  802890:	ff d0                	callq  *%rax
  802892:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802895:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802899:	79 1d                	jns    8028b8 <open+0xc5>
  80289b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80289f:	be 00 00 00 00       	mov    $0x0,%esi
  8028a4:	48 89 c7             	mov    %rax,%rdi
  8028a7:	48 b8 7b 1f 80 00 00 	movabs $0x801f7b,%rax
  8028ae:	00 00 00 
  8028b1:	ff d0                	callq  *%rax
  8028b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028b6:	eb 13                	jmp    8028cb <open+0xd8>
  8028b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028bc:	48 89 c7             	mov    %rax,%rdi
  8028bf:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  8028c6:	00 00 00 
  8028c9:	ff d0                	callq  *%rax
  8028cb:	c9                   	leaveq 
  8028cc:	c3                   	retq   

00000000008028cd <devfile_flush>:
  8028cd:	55                   	push   %rbp
  8028ce:	48 89 e5             	mov    %rsp,%rbp
  8028d1:	48 83 ec 10          	sub    $0x10,%rsp
  8028d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8028d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8028dd:	8b 50 0c             	mov    0xc(%rax),%edx
  8028e0:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8028e7:	00 00 00 
  8028ea:	89 10                	mov    %edx,(%rax)
  8028ec:	be 00 00 00 00       	mov    $0x0,%esi
  8028f1:	bf 06 00 00 00       	mov    $0x6,%edi
  8028f6:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  8028fd:	00 00 00 
  802900:	ff d0                	callq  *%rax
  802902:	c9                   	leaveq 
  802903:	c3                   	retq   

0000000000802904 <devfile_read>:
  802904:	55                   	push   %rbp
  802905:	48 89 e5             	mov    %rsp,%rbp
  802908:	48 83 ec 30          	sub    $0x30,%rsp
  80290c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802910:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802914:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802918:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80291c:	8b 50 0c             	mov    0xc(%rax),%edx
  80291f:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802926:	00 00 00 
  802929:	89 10                	mov    %edx,(%rax)
  80292b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802932:	00 00 00 
  802935:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802939:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80293d:	be 00 00 00 00       	mov    $0x0,%esi
  802942:	bf 03 00 00 00       	mov    $0x3,%edi
  802947:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  80294e:	00 00 00 
  802951:	ff d0                	callq  *%rax
  802953:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802956:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80295a:	79 08                	jns    802964 <devfile_read+0x60>
  80295c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80295f:	e9 a4 00 00 00       	jmpq   802a08 <devfile_read+0x104>
  802964:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802967:	48 98                	cltq   
  802969:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80296d:	76 35                	jbe    8029a4 <devfile_read+0xa0>
  80296f:	48 b9 b6 53 80 00 00 	movabs $0x8053b6,%rcx
  802976:	00 00 00 
  802979:	48 ba bd 53 80 00 00 	movabs $0x8053bd,%rdx
  802980:	00 00 00 
  802983:	be 89 00 00 00       	mov    $0x89,%esi
  802988:	48 bf d2 53 80 00 00 	movabs $0x8053d2,%rdi
  80298f:	00 00 00 
  802992:	b8 00 00 00 00       	mov    $0x0,%eax
  802997:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  80299e:	00 00 00 
  8029a1:	41 ff d0             	callq  *%r8
  8029a4:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  8029ab:	7e 35                	jle    8029e2 <devfile_read+0xde>
  8029ad:	48 b9 e0 53 80 00 00 	movabs $0x8053e0,%rcx
  8029b4:	00 00 00 
  8029b7:	48 ba bd 53 80 00 00 	movabs $0x8053bd,%rdx
  8029be:	00 00 00 
  8029c1:	be 8a 00 00 00       	mov    $0x8a,%esi
  8029c6:	48 bf d2 53 80 00 00 	movabs $0x8053d2,%rdi
  8029cd:	00 00 00 
  8029d0:	b8 00 00 00 00       	mov    $0x0,%eax
  8029d5:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  8029dc:	00 00 00 
  8029df:	41 ff d0             	callq  *%r8
  8029e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029e5:	48 63 d0             	movslq %eax,%rdx
  8029e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029ec:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8029f3:	00 00 00 
  8029f6:	48 89 c7             	mov    %rax,%rdi
  8029f9:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  802a00:	00 00 00 
  802a03:	ff d0                	callq  *%rax
  802a05:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a08:	c9                   	leaveq 
  802a09:	c3                   	retq   

0000000000802a0a <devfile_write>:
  802a0a:	55                   	push   %rbp
  802a0b:	48 89 e5             	mov    %rsp,%rbp
  802a0e:	48 83 ec 40          	sub    $0x40,%rsp
  802a12:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802a16:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802a1a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802a1e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802a22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802a26:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802a2d:	00 
  802a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a32:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802a36:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802a3b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802a3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802a43:	8b 50 0c             	mov    0xc(%rax),%edx
  802a46:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802a4d:	00 00 00 
  802a50:	89 10                	mov    %edx,(%rax)
  802a52:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802a59:	00 00 00 
  802a5c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802a60:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802a64:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802a68:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a6c:	48 89 c6             	mov    %rax,%rsi
  802a6f:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  802a76:	00 00 00 
  802a79:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  802a80:	00 00 00 
  802a83:	ff d0                	callq  *%rax
  802a85:	be 00 00 00 00       	mov    $0x0,%esi
  802a8a:	bf 04 00 00 00       	mov    $0x4,%edi
  802a8f:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  802a96:	00 00 00 
  802a99:	ff d0                	callq  *%rax
  802a9b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802a9e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802aa2:	79 05                	jns    802aa9 <devfile_write+0x9f>
  802aa4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802aa7:	eb 43                	jmp    802aec <devfile_write+0xe2>
  802aa9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802aac:	48 98                	cltq   
  802aae:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802ab2:	76 35                	jbe    802ae9 <devfile_write+0xdf>
  802ab4:	48 b9 b6 53 80 00 00 	movabs $0x8053b6,%rcx
  802abb:	00 00 00 
  802abe:	48 ba bd 53 80 00 00 	movabs $0x8053bd,%rdx
  802ac5:	00 00 00 
  802ac8:	be a8 00 00 00       	mov    $0xa8,%esi
  802acd:	48 bf d2 53 80 00 00 	movabs $0x8053d2,%rdi
  802ad4:	00 00 00 
  802ad7:	b8 00 00 00 00       	mov    $0x0,%eax
  802adc:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  802ae3:	00 00 00 
  802ae6:	41 ff d0             	callq  *%r8
  802ae9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802aec:	c9                   	leaveq 
  802aed:	c3                   	retq   

0000000000802aee <devfile_stat>:
  802aee:	55                   	push   %rbp
  802aef:	48 89 e5             	mov    %rsp,%rbp
  802af2:	48 83 ec 20          	sub    $0x20,%rsp
  802af6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802afa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802afe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b02:	8b 50 0c             	mov    0xc(%rax),%edx
  802b05:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802b0c:	00 00 00 
  802b0f:	89 10                	mov    %edx,(%rax)
  802b11:	be 00 00 00 00       	mov    $0x0,%esi
  802b16:	bf 05 00 00 00       	mov    $0x5,%edi
  802b1b:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  802b22:	00 00 00 
  802b25:	ff d0                	callq  *%rax
  802b27:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b2e:	79 05                	jns    802b35 <devfile_stat+0x47>
  802b30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b33:	eb 56                	jmp    802b8b <devfile_stat+0x9d>
  802b35:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b39:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  802b40:	00 00 00 
  802b43:	48 89 c7             	mov    %rax,%rdi
  802b46:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  802b4d:	00 00 00 
  802b50:	ff d0                	callq  *%rax
  802b52:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802b59:	00 00 00 
  802b5c:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802b62:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b66:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802b6c:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802b73:	00 00 00 
  802b76:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802b7c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b80:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802b86:	b8 00 00 00 00       	mov    $0x0,%eax
  802b8b:	c9                   	leaveq 
  802b8c:	c3                   	retq   

0000000000802b8d <devfile_trunc>:
  802b8d:	55                   	push   %rbp
  802b8e:	48 89 e5             	mov    %rsp,%rbp
  802b91:	48 83 ec 10          	sub    $0x10,%rsp
  802b95:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802b99:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802b9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ba0:	8b 50 0c             	mov    0xc(%rax),%edx
  802ba3:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802baa:	00 00 00 
  802bad:	89 10                	mov    %edx,(%rax)
  802baf:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802bb6:	00 00 00 
  802bb9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802bbc:	89 50 04             	mov    %edx,0x4(%rax)
  802bbf:	be 00 00 00 00       	mov    $0x0,%esi
  802bc4:	bf 02 00 00 00       	mov    $0x2,%edi
  802bc9:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  802bd0:	00 00 00 
  802bd3:	ff d0                	callq  *%rax
  802bd5:	c9                   	leaveq 
  802bd6:	c3                   	retq   

0000000000802bd7 <remove>:
  802bd7:	55                   	push   %rbp
  802bd8:	48 89 e5             	mov    %rsp,%rbp
  802bdb:	48 83 ec 10          	sub    $0x10,%rsp
  802bdf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802be3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802be7:	48 89 c7             	mov    %rax,%rdi
  802bea:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  802bf1:	00 00 00 
  802bf4:	ff d0                	callq  *%rax
  802bf6:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802bfb:	7e 07                	jle    802c04 <remove+0x2d>
  802bfd:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802c02:	eb 33                	jmp    802c37 <remove+0x60>
  802c04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802c08:	48 89 c6             	mov    %rax,%rsi
  802c0b:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802c12:	00 00 00 
  802c15:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  802c1c:	00 00 00 
  802c1f:	ff d0                	callq  *%rax
  802c21:	be 00 00 00 00       	mov    $0x0,%esi
  802c26:	bf 07 00 00 00       	mov    $0x7,%edi
  802c2b:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  802c32:	00 00 00 
  802c35:	ff d0                	callq  *%rax
  802c37:	c9                   	leaveq 
  802c38:	c3                   	retq   

0000000000802c39 <sync>:
  802c39:	55                   	push   %rbp
  802c3a:	48 89 e5             	mov    %rsp,%rbp
  802c3d:	be 00 00 00 00       	mov    $0x0,%esi
  802c42:	bf 08 00 00 00       	mov    $0x8,%edi
  802c47:	48 b8 6c 27 80 00 00 	movabs $0x80276c,%rax
  802c4e:	00 00 00 
  802c51:	ff d0                	callq  *%rax
  802c53:	5d                   	pop    %rbp
  802c54:	c3                   	retq   

0000000000802c55 <copy>:
  802c55:	55                   	push   %rbp
  802c56:	48 89 e5             	mov    %rsp,%rbp
  802c59:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802c60:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802c67:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802c6e:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802c75:	be 00 00 00 00       	mov    $0x0,%esi
  802c7a:	48 89 c7             	mov    %rax,%rdi
  802c7d:	48 b8 f3 27 80 00 00 	movabs $0x8027f3,%rax
  802c84:	00 00 00 
  802c87:	ff d0                	callq  *%rax
  802c89:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c8c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c90:	79 28                	jns    802cba <copy+0x65>
  802c92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c95:	89 c6                	mov    %eax,%esi
  802c97:	48 bf ec 53 80 00 00 	movabs $0x8053ec,%rdi
  802c9e:	00 00 00 
  802ca1:	b8 00 00 00 00       	mov    $0x0,%eax
  802ca6:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  802cad:	00 00 00 
  802cb0:	ff d2                	callq  *%rdx
  802cb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cb5:	e9 74 01 00 00       	jmpq   802e2e <copy+0x1d9>
  802cba:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802cc1:	be 01 01 00 00       	mov    $0x101,%esi
  802cc6:	48 89 c7             	mov    %rax,%rdi
  802cc9:	48 b8 f3 27 80 00 00 	movabs $0x8027f3,%rax
  802cd0:	00 00 00 
  802cd3:	ff d0                	callq  *%rax
  802cd5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802cd8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802cdc:	79 39                	jns    802d17 <copy+0xc2>
  802cde:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802ce1:	89 c6                	mov    %eax,%esi
  802ce3:	48 bf 02 54 80 00 00 	movabs $0x805402,%rdi
  802cea:	00 00 00 
  802ced:	b8 00 00 00 00       	mov    $0x0,%eax
  802cf2:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  802cf9:	00 00 00 
  802cfc:	ff d2                	callq  *%rdx
  802cfe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d01:	89 c7                	mov    %eax,%edi
  802d03:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802d0a:	00 00 00 
  802d0d:	ff d0                	callq  *%rax
  802d0f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d12:	e9 17 01 00 00       	jmpq   802e2e <copy+0x1d9>
  802d17:	eb 74                	jmp    802d8d <copy+0x138>
  802d19:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802d1c:	48 63 d0             	movslq %eax,%rdx
  802d1f:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802d26:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d29:	48 89 ce             	mov    %rcx,%rsi
  802d2c:	89 c7                	mov    %eax,%edi
  802d2e:	48 b8 67 24 80 00 00 	movabs $0x802467,%rax
  802d35:	00 00 00 
  802d38:	ff d0                	callq  *%rax
  802d3a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802d3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802d41:	79 4a                	jns    802d8d <copy+0x138>
  802d43:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802d46:	89 c6                	mov    %eax,%esi
  802d48:	48 bf 1c 54 80 00 00 	movabs $0x80541c,%rdi
  802d4f:	00 00 00 
  802d52:	b8 00 00 00 00       	mov    $0x0,%eax
  802d57:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  802d5e:	00 00 00 
  802d61:	ff d2                	callq  *%rdx
  802d63:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d66:	89 c7                	mov    %eax,%edi
  802d68:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802d6f:	00 00 00 
  802d72:	ff d0                	callq  *%rax
  802d74:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d77:	89 c7                	mov    %eax,%edi
  802d79:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802d80:	00 00 00 
  802d83:	ff d0                	callq  *%rax
  802d85:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802d88:	e9 a1 00 00 00       	jmpq   802e2e <copy+0x1d9>
  802d8d:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802d94:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d97:	ba 00 02 00 00       	mov    $0x200,%edx
  802d9c:	48 89 ce             	mov    %rcx,%rsi
  802d9f:	89 c7                	mov    %eax,%edi
  802da1:	48 b8 1d 23 80 00 00 	movabs $0x80231d,%rax
  802da8:	00 00 00 
  802dab:	ff d0                	callq  *%rax
  802dad:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802db0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802db4:	0f 8f 5f ff ff ff    	jg     802d19 <copy+0xc4>
  802dba:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802dbe:	79 47                	jns    802e07 <copy+0x1b2>
  802dc0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802dc3:	89 c6                	mov    %eax,%esi
  802dc5:	48 bf 2f 54 80 00 00 	movabs $0x80542f,%rdi
  802dcc:	00 00 00 
  802dcf:	b8 00 00 00 00       	mov    $0x0,%eax
  802dd4:	48 ba 41 05 80 00 00 	movabs $0x800541,%rdx
  802ddb:	00 00 00 
  802dde:	ff d2                	callq  *%rdx
  802de0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802de3:	89 c7                	mov    %eax,%edi
  802de5:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802dec:	00 00 00 
  802def:	ff d0                	callq  *%rax
  802df1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802df4:	89 c7                	mov    %eax,%edi
  802df6:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802dfd:	00 00 00 
  802e00:	ff d0                	callq  *%rax
  802e02:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802e05:	eb 27                	jmp    802e2e <copy+0x1d9>
  802e07:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e0a:	89 c7                	mov    %eax,%edi
  802e0c:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802e13:	00 00 00 
  802e16:	ff d0                	callq  *%rax
  802e18:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e1b:	89 c7                	mov    %eax,%edi
  802e1d:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802e24:	00 00 00 
  802e27:	ff d0                	callq  *%rax
  802e29:	b8 00 00 00 00       	mov    $0x0,%eax
  802e2e:	c9                   	leaveq 
  802e2f:	c3                   	retq   

0000000000802e30 <spawn>:
  802e30:	55                   	push   %rbp
  802e31:	48 89 e5             	mov    %rsp,%rbp
  802e34:	48 81 ec 10 03 00 00 	sub    $0x310,%rsp
  802e3b:	48 89 bd 08 fd ff ff 	mov    %rdi,-0x2f8(%rbp)
  802e42:	48 89 b5 00 fd ff ff 	mov    %rsi,-0x300(%rbp)
  802e49:	48 8b 85 08 fd ff ff 	mov    -0x2f8(%rbp),%rax
  802e50:	be 00 00 00 00       	mov    $0x0,%esi
  802e55:	48 89 c7             	mov    %rax,%rdi
  802e58:	48 b8 f3 27 80 00 00 	movabs $0x8027f3,%rax
  802e5f:	00 00 00 
  802e62:	ff d0                	callq  *%rax
  802e64:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802e67:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802e6b:	79 08                	jns    802e75 <spawn+0x45>
  802e6d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802e70:	e9 0c 03 00 00       	jmpq   803181 <spawn+0x351>
  802e75:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802e78:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  802e7b:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
  802e82:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  802e86:	48 8d 8d d0 fd ff ff 	lea    -0x230(%rbp),%rcx
  802e8d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802e90:	ba 00 02 00 00       	mov    $0x200,%edx
  802e95:	48 89 ce             	mov    %rcx,%rsi
  802e98:	89 c7                	mov    %eax,%edi
  802e9a:	48 b8 f2 23 80 00 00 	movabs $0x8023f2,%rax
  802ea1:	00 00 00 
  802ea4:	ff d0                	callq  *%rax
  802ea6:	3d 00 02 00 00       	cmp    $0x200,%eax
  802eab:	75 0d                	jne    802eba <spawn+0x8a>
  802ead:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802eb1:	8b 00                	mov    (%rax),%eax
  802eb3:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  802eb8:	74 43                	je     802efd <spawn+0xcd>
  802eba:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802ebd:	89 c7                	mov    %eax,%edi
  802ebf:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  802ec6:	00 00 00 
  802ec9:	ff d0                	callq  *%rax
  802ecb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802ecf:	8b 00                	mov    (%rax),%eax
  802ed1:	ba 7f 45 4c 46       	mov    $0x464c457f,%edx
  802ed6:	89 c6                	mov    %eax,%esi
  802ed8:	48 bf 48 54 80 00 00 	movabs $0x805448,%rdi
  802edf:	00 00 00 
  802ee2:	b8 00 00 00 00       	mov    $0x0,%eax
  802ee7:	48 b9 41 05 80 00 00 	movabs $0x800541,%rcx
  802eee:	00 00 00 
  802ef1:	ff d1                	callq  *%rcx
  802ef3:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
  802ef8:	e9 84 02 00 00       	jmpq   803181 <spawn+0x351>
  802efd:	b8 07 00 00 00       	mov    $0x7,%eax
  802f02:	cd 30                	int    $0x30
  802f04:	89 45 d0             	mov    %eax,-0x30(%rbp)
  802f07:	8b 45 d0             	mov    -0x30(%rbp),%eax
  802f0a:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802f0d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802f11:	79 08                	jns    802f1b <spawn+0xeb>
  802f13:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802f16:	e9 66 02 00 00       	jmpq   803181 <spawn+0x351>
  802f1b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802f1e:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  802f21:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802f24:	25 ff 03 00 00       	and    $0x3ff,%eax
  802f29:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802f30:	00 00 00 
  802f33:	48 98                	cltq   
  802f35:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802f3c:	48 01 d0             	add    %rdx,%rax
  802f3f:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  802f46:	48 89 c6             	mov    %rax,%rsi
  802f49:	b8 18 00 00 00       	mov    $0x18,%eax
  802f4e:	48 89 d7             	mov    %rdx,%rdi
  802f51:	48 89 c1             	mov    %rax,%rcx
  802f54:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  802f57:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802f5b:	48 8b 40 18          	mov    0x18(%rax),%rax
  802f5f:	48 89 85 a8 fd ff ff 	mov    %rax,-0x258(%rbp)
  802f66:	48 8d 85 10 fd ff ff 	lea    -0x2f0(%rbp),%rax
  802f6d:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
  802f74:	48 8b 8d 00 fd ff ff 	mov    -0x300(%rbp),%rcx
  802f7b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802f7e:	48 89 ce             	mov    %rcx,%rsi
  802f81:	89 c7                	mov    %eax,%edi
  802f83:	48 b8 eb 33 80 00 00 	movabs $0x8033eb,%rax
  802f8a:	00 00 00 
  802f8d:	ff d0                	callq  *%rax
  802f8f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802f92:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802f96:	79 08                	jns    802fa0 <spawn+0x170>
  802f98:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802f9b:	e9 e1 01 00 00       	jmpq   803181 <spawn+0x351>
  802fa0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802fa4:	48 8b 40 20          	mov    0x20(%rax),%rax
  802fa8:	48 8d 95 d0 fd ff ff 	lea    -0x230(%rbp),%rdx
  802faf:	48 01 d0             	add    %rdx,%rax
  802fb2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802fb6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802fbd:	e9 a3 00 00 00       	jmpq   803065 <spawn+0x235>
  802fc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fc6:	8b 00                	mov    (%rax),%eax
  802fc8:	83 f8 01             	cmp    $0x1,%eax
  802fcb:	74 05                	je     802fd2 <spawn+0x1a2>
  802fcd:	e9 8a 00 00 00       	jmpq   80305c <spawn+0x22c>
  802fd2:	c7 45 ec 05 00 00 00 	movl   $0x5,-0x14(%rbp)
  802fd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fdd:	8b 40 04             	mov    0x4(%rax),%eax
  802fe0:	83 e0 02             	and    $0x2,%eax
  802fe3:	85 c0                	test   %eax,%eax
  802fe5:	74 04                	je     802feb <spawn+0x1bb>
  802fe7:	83 4d ec 02          	orl    $0x2,-0x14(%rbp)
  802feb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fef:	48 8b 40 08          	mov    0x8(%rax),%rax
  802ff3:	41 89 c1             	mov    %eax,%r9d
  802ff6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ffa:	4c 8b 40 20          	mov    0x20(%rax),%r8
  802ffe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803002:	48 8b 50 28          	mov    0x28(%rax),%rdx
  803006:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80300a:	48 8b 70 10          	mov    0x10(%rax),%rsi
  80300e:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  803011:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803014:	8b 7d ec             	mov    -0x14(%rbp),%edi
  803017:	89 3c 24             	mov    %edi,(%rsp)
  80301a:	89 c7                	mov    %eax,%edi
  80301c:	48 b8 94 36 80 00 00 	movabs $0x803694,%rax
  803023:	00 00 00 
  803026:	ff d0                	callq  *%rax
  803028:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80302b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80302f:	79 2b                	jns    80305c <spawn+0x22c>
  803031:	90                   	nop
  803032:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803035:	89 c7                	mov    %eax,%edi
  803037:	48 b8 65 19 80 00 00 	movabs $0x801965,%rax
  80303e:	00 00 00 
  803041:	ff d0                	callq  *%rax
  803043:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  803046:	89 c7                	mov    %eax,%edi
  803048:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  80304f:	00 00 00 
  803052:	ff d0                	callq  *%rax
  803054:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803057:	e9 25 01 00 00       	jmpq   803181 <spawn+0x351>
  80305c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803060:	48 83 45 f0 38       	addq   $0x38,-0x10(%rbp)
  803065:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803069:	0f b7 40 38          	movzwl 0x38(%rax),%eax
  80306d:	0f b7 c0             	movzwl %ax,%eax
  803070:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  803073:	0f 8f 49 ff ff ff    	jg     802fc2 <spawn+0x192>
  803079:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80307c:	89 c7                	mov    %eax,%edi
  80307e:	48 b8 fb 20 80 00 00 	movabs $0x8020fb,%rax
  803085:	00 00 00 
  803088:	ff d0                	callq  *%rax
  80308a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
  803091:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803094:	89 c7                	mov    %eax,%edi
  803096:	48 b8 80 38 80 00 00 	movabs $0x803880,%rax
  80309d:	00 00 00 
  8030a0:	ff d0                	callq  *%rax
  8030a2:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8030a5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8030a9:	79 30                	jns    8030db <spawn+0x2ab>
  8030ab:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8030ae:	89 c1                	mov    %eax,%ecx
  8030b0:	48 ba 62 54 80 00 00 	movabs $0x805462,%rdx
  8030b7:	00 00 00 
  8030ba:	be 86 00 00 00       	mov    $0x86,%esi
  8030bf:	48 bf 78 54 80 00 00 	movabs $0x805478,%rdi
  8030c6:	00 00 00 
  8030c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8030ce:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  8030d5:	00 00 00 
  8030d8:	41 ff d0             	callq  *%r8
  8030db:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  8030e2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8030e5:	48 89 d6             	mov    %rdx,%rsi
  8030e8:	89 c7                	mov    %eax,%edi
  8030ea:	48 b8 65 1b 80 00 00 	movabs $0x801b65,%rax
  8030f1:	00 00 00 
  8030f4:	ff d0                	callq  *%rax
  8030f6:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8030f9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8030fd:	79 30                	jns    80312f <spawn+0x2ff>
  8030ff:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803102:	89 c1                	mov    %eax,%ecx
  803104:	48 ba 87 54 80 00 00 	movabs $0x805487,%rdx
  80310b:	00 00 00 
  80310e:	be 8a 00 00 00       	mov    $0x8a,%esi
  803113:	48 bf 78 54 80 00 00 	movabs $0x805478,%rdi
  80311a:	00 00 00 
  80311d:	b8 00 00 00 00       	mov    $0x0,%eax
  803122:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  803129:	00 00 00 
  80312c:	41 ff d0             	callq  *%r8
  80312f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803132:	be 02 00 00 00       	mov    $0x2,%esi
  803137:	89 c7                	mov    %eax,%edi
  803139:	48 b8 1a 1b 80 00 00 	movabs $0x801b1a,%rax
  803140:	00 00 00 
  803143:	ff d0                	callq  *%rax
  803145:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803148:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80314c:	79 30                	jns    80317e <spawn+0x34e>
  80314e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803151:	89 c1                	mov    %eax,%ecx
  803153:	48 ba a1 54 80 00 00 	movabs $0x8054a1,%rdx
  80315a:	00 00 00 
  80315d:	be 8d 00 00 00       	mov    $0x8d,%esi
  803162:	48 bf 78 54 80 00 00 	movabs $0x805478,%rdi
  803169:	00 00 00 
  80316c:	b8 00 00 00 00       	mov    $0x0,%eax
  803171:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  803178:	00 00 00 
  80317b:	41 ff d0             	callq  *%r8
  80317e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803181:	c9                   	leaveq 
  803182:	c3                   	retq   

0000000000803183 <spawnl>:
  803183:	55                   	push   %rbp
  803184:	48 89 e5             	mov    %rsp,%rbp
  803187:	41 55                	push   %r13
  803189:	41 54                	push   %r12
  80318b:	53                   	push   %rbx
  80318c:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803193:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
  80319a:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
  8031a1:	48 89 8d 48 ff ff ff 	mov    %rcx,-0xb8(%rbp)
  8031a8:	4c 89 85 50 ff ff ff 	mov    %r8,-0xb0(%rbp)
  8031af:	4c 89 8d 58 ff ff ff 	mov    %r9,-0xa8(%rbp)
  8031b6:	84 c0                	test   %al,%al
  8031b8:	74 26                	je     8031e0 <spawnl+0x5d>
  8031ba:	0f 29 85 60 ff ff ff 	movaps %xmm0,-0xa0(%rbp)
  8031c1:	0f 29 8d 70 ff ff ff 	movaps %xmm1,-0x90(%rbp)
  8031c8:	0f 29 55 80          	movaps %xmm2,-0x80(%rbp)
  8031cc:	0f 29 5d 90          	movaps %xmm3,-0x70(%rbp)
  8031d0:	0f 29 65 a0          	movaps %xmm4,-0x60(%rbp)
  8031d4:	0f 29 6d b0          	movaps %xmm5,-0x50(%rbp)
  8031d8:	0f 29 75 c0          	movaps %xmm6,-0x40(%rbp)
  8031dc:	0f 29 7d d0          	movaps %xmm7,-0x30(%rbp)
  8031e0:	48 89 b5 f0 fe ff ff 	mov    %rsi,-0x110(%rbp)
  8031e7:	c7 85 2c ff ff ff 00 	movl   $0x0,-0xd4(%rbp)
  8031ee:	00 00 00 
  8031f1:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  8031f8:	00 00 00 
  8031fb:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  803202:	00 00 00 
  803205:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803209:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  803210:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  803217:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  80321e:	eb 07                	jmp    803227 <spawnl+0xa4>
  803220:	83 85 2c ff ff ff 01 	addl   $0x1,-0xd4(%rbp)
  803227:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  80322d:	83 f8 30             	cmp    $0x30,%eax
  803230:	73 23                	jae    803255 <spawnl+0xd2>
  803232:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  803239:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  80323f:	89 c0                	mov    %eax,%eax
  803241:	48 01 d0             	add    %rdx,%rax
  803244:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  80324a:	83 c2 08             	add    $0x8,%edx
  80324d:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  803253:	eb 15                	jmp    80326a <spawnl+0xe7>
  803255:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  80325c:	48 89 d0             	mov    %rdx,%rax
  80325f:	48 83 c2 08          	add    $0x8,%rdx
  803263:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80326a:	48 8b 00             	mov    (%rax),%rax
  80326d:	48 85 c0             	test   %rax,%rax
  803270:	75 ae                	jne    803220 <spawnl+0x9d>
  803272:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  803278:	83 c0 02             	add    $0x2,%eax
  80327b:	48 89 e2             	mov    %rsp,%rdx
  80327e:	48 89 d3             	mov    %rdx,%rbx
  803281:	48 63 d0             	movslq %eax,%rdx
  803284:	48 83 ea 01          	sub    $0x1,%rdx
  803288:	48 89 95 20 ff ff ff 	mov    %rdx,-0xe0(%rbp)
  80328f:	48 63 d0             	movslq %eax,%rdx
  803292:	49 89 d4             	mov    %rdx,%r12
  803295:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  80329b:	48 63 d0             	movslq %eax,%rdx
  80329e:	49 89 d2             	mov    %rdx,%r10
  8032a1:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  8032a7:	48 98                	cltq   
  8032a9:	48 c1 e0 03          	shl    $0x3,%rax
  8032ad:	48 8d 50 07          	lea    0x7(%rax),%rdx
  8032b1:	b8 10 00 00 00       	mov    $0x10,%eax
  8032b6:	48 83 e8 01          	sub    $0x1,%rax
  8032ba:	48 01 d0             	add    %rdx,%rax
  8032bd:	bf 10 00 00 00       	mov    $0x10,%edi
  8032c2:	ba 00 00 00 00       	mov    $0x0,%edx
  8032c7:	48 f7 f7             	div    %rdi
  8032ca:	48 6b c0 10          	imul   $0x10,%rax,%rax
  8032ce:	48 29 c4             	sub    %rax,%rsp
  8032d1:	48 89 e0             	mov    %rsp,%rax
  8032d4:	48 83 c0 07          	add    $0x7,%rax
  8032d8:	48 c1 e8 03          	shr    $0x3,%rax
  8032dc:	48 c1 e0 03          	shl    $0x3,%rax
  8032e0:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
  8032e7:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  8032ee:	48 8b 95 f0 fe ff ff 	mov    -0x110(%rbp),%rdx
  8032f5:	48 89 10             	mov    %rdx,(%rax)
  8032f8:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8032fe:	8d 50 01             	lea    0x1(%rax),%edx
  803301:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  803308:	48 63 d2             	movslq %edx,%rdx
  80330b:	48 c7 04 d0 00 00 00 	movq   $0x0,(%rax,%rdx,8)
  803312:	00 
  803313:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  80331a:	00 00 00 
  80331d:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  803324:	00 00 00 
  803327:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80332b:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  803332:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  803339:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  803340:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
  803347:	00 00 00 
  80334a:	eb 63                	jmp    8033af <spawnl+0x22c>
  80334c:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
  803352:	8d 70 01             	lea    0x1(%rax),%esi
  803355:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  80335b:	83 f8 30             	cmp    $0x30,%eax
  80335e:	73 23                	jae    803383 <spawnl+0x200>
  803360:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  803367:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  80336d:	89 c0                	mov    %eax,%eax
  80336f:	48 01 d0             	add    %rdx,%rax
  803372:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  803378:	83 c2 08             	add    $0x8,%edx
  80337b:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  803381:	eb 15                	jmp    803398 <spawnl+0x215>
  803383:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  80338a:	48 89 d0             	mov    %rdx,%rax
  80338d:	48 83 c2 08          	add    $0x8,%rdx
  803391:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  803398:	48 8b 08             	mov    (%rax),%rcx
  80339b:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  8033a2:	89 f2                	mov    %esi,%edx
  8033a4:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
  8033a8:	83 85 28 ff ff ff 01 	addl   $0x1,-0xd8(%rbp)
  8033af:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8033b5:	3b 85 28 ff ff ff    	cmp    -0xd8(%rbp),%eax
  8033bb:	77 8f                	ja     80334c <spawnl+0x1c9>
  8033bd:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8033c4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
  8033cb:	48 89 d6             	mov    %rdx,%rsi
  8033ce:	48 89 c7             	mov    %rax,%rdi
  8033d1:	48 b8 30 2e 80 00 00 	movabs $0x802e30,%rax
  8033d8:	00 00 00 
  8033db:	ff d0                	callq  *%rax
  8033dd:	48 89 dc             	mov    %rbx,%rsp
  8033e0:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
  8033e4:	5b                   	pop    %rbx
  8033e5:	41 5c                	pop    %r12
  8033e7:	41 5d                	pop    %r13
  8033e9:	5d                   	pop    %rbp
  8033ea:	c3                   	retq   

00000000008033eb <init_stack>:
  8033eb:	55                   	push   %rbp
  8033ec:	48 89 e5             	mov    %rsp,%rbp
  8033ef:	48 83 ec 50          	sub    $0x50,%rsp
  8033f3:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8033f6:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  8033fa:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8033fe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803405:	00 
  803406:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  80340d:	eb 33                	jmp    803442 <init_stack+0x57>
  80340f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803412:	48 98                	cltq   
  803414:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80341b:	00 
  80341c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803420:	48 01 d0             	add    %rdx,%rax
  803423:	48 8b 00             	mov    (%rax),%rax
  803426:	48 89 c7             	mov    %rax,%rdi
  803429:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  803430:	00 00 00 
  803433:	ff d0                	callq  *%rax
  803435:	83 c0 01             	add    $0x1,%eax
  803438:	48 98                	cltq   
  80343a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80343e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
  803442:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803445:	48 98                	cltq   
  803447:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80344e:	00 
  80344f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803453:	48 01 d0             	add    %rdx,%rax
  803456:	48 8b 00             	mov    (%rax),%rax
  803459:	48 85 c0             	test   %rax,%rax
  80345c:	75 b1                	jne    80340f <init_stack+0x24>
  80345e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803462:	48 f7 d8             	neg    %rax
  803465:	48 05 00 10 40 00    	add    $0x401000,%rax
  80346b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80346f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803473:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  803477:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80347b:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  80347f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803482:	83 c2 01             	add    $0x1,%edx
  803485:	c1 e2 03             	shl    $0x3,%edx
  803488:	48 63 d2             	movslq %edx,%rdx
  80348b:	48 f7 da             	neg    %rdx
  80348e:	48 01 d0             	add    %rdx,%rax
  803491:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  803495:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803499:	48 83 e8 10          	sub    $0x10,%rax
  80349d:	48 3d ff ff 3f 00    	cmp    $0x3fffff,%rax
  8034a3:	77 0a                	ja     8034af <init_stack+0xc4>
  8034a5:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  8034aa:	e9 e3 01 00 00       	jmpq   803692 <init_stack+0x2a7>
  8034af:	ba 07 00 00 00       	mov    $0x7,%edx
  8034b4:	be 00 00 40 00       	mov    $0x400000,%esi
  8034b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8034be:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  8034c5:	00 00 00 
  8034c8:	ff d0                	callq  *%rax
  8034ca:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8034cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8034d1:	79 08                	jns    8034db <init_stack+0xf0>
  8034d3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8034d6:	e9 b7 01 00 00       	jmpq   803692 <init_stack+0x2a7>
  8034db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  8034e2:	e9 8a 00 00 00       	jmpq   803571 <init_stack+0x186>
  8034e7:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8034ea:	48 98                	cltq   
  8034ec:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8034f3:	00 
  8034f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8034f8:	48 01 c2             	add    %rax,%rdx
  8034fb:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803500:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803504:	48 01 c8             	add    %rcx,%rax
  803507:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  80350d:	48 89 02             	mov    %rax,(%rdx)
  803510:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803513:	48 98                	cltq   
  803515:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80351c:	00 
  80351d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803521:	48 01 d0             	add    %rdx,%rax
  803524:	48 8b 10             	mov    (%rax),%rdx
  803527:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80352b:	48 89 d6             	mov    %rdx,%rsi
  80352e:	48 89 c7             	mov    %rax,%rdi
  803531:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  803538:	00 00 00 
  80353b:	ff d0                	callq  *%rax
  80353d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803540:	48 98                	cltq   
  803542:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803549:	00 
  80354a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  80354e:	48 01 d0             	add    %rdx,%rax
  803551:	48 8b 00             	mov    (%rax),%rax
  803554:	48 89 c7             	mov    %rax,%rdi
  803557:	48 b8 8a 10 80 00 00 	movabs $0x80108a,%rax
  80355e:	00 00 00 
  803561:	ff d0                	callq  *%rax
  803563:	48 98                	cltq   
  803565:	48 83 c0 01          	add    $0x1,%rax
  803569:	48 01 45 e0          	add    %rax,-0x20(%rbp)
  80356d:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  803571:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803574:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  803577:	0f 8c 6a ff ff ff    	jl     8034e7 <init_stack+0xfc>
  80357d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803580:	48 98                	cltq   
  803582:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803589:	00 
  80358a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80358e:	48 01 d0             	add    %rdx,%rax
  803591:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  803598:	48 81 7d e0 00 10 40 	cmpq   $0x401000,-0x20(%rbp)
  80359f:	00 
  8035a0:	74 35                	je     8035d7 <init_stack+0x1ec>
  8035a2:	48 b9 b8 54 80 00 00 	movabs $0x8054b8,%rcx
  8035a9:	00 00 00 
  8035ac:	48 ba de 54 80 00 00 	movabs $0x8054de,%rdx
  8035b3:	00 00 00 
  8035b6:	be f6 00 00 00       	mov    $0xf6,%esi
  8035bb:	48 bf 78 54 80 00 00 	movabs $0x805478,%rdi
  8035c2:	00 00 00 
  8035c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8035ca:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  8035d1:	00 00 00 
  8035d4:	41 ff d0             	callq  *%r8
  8035d7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8035db:	48 8d 50 f8          	lea    -0x8(%rax),%rdx
  8035df:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  8035e4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8035e8:	48 01 c8             	add    %rcx,%rax
  8035eb:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  8035f1:	48 89 02             	mov    %rax,(%rdx)
  8035f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8035f8:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
  8035fc:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8035ff:	48 98                	cltq   
  803601:	48 89 02             	mov    %rax,(%rdx)
  803604:	ba f0 cf 7f ef       	mov    $0xef7fcff0,%edx
  803609:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80360d:	48 01 d0             	add    %rdx,%rax
  803610:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803616:	48 89 c2             	mov    %rax,%rdx
  803619:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  80361d:	48 89 10             	mov    %rdx,(%rax)
  803620:	8b 45 cc             	mov    -0x34(%rbp),%eax
  803623:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  803629:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  80362e:	89 c2                	mov    %eax,%edx
  803630:	be 00 00 40 00       	mov    $0x400000,%esi
  803635:	bf 00 00 00 00       	mov    $0x0,%edi
  80363a:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  803641:	00 00 00 
  803644:	ff d0                	callq  *%rax
  803646:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803649:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80364d:	79 02                	jns    803651 <init_stack+0x266>
  80364f:	eb 28                	jmp    803679 <init_stack+0x28e>
  803651:	be 00 00 40 00       	mov    $0x400000,%esi
  803656:	bf 00 00 00 00       	mov    $0x0,%edi
  80365b:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  803662:	00 00 00 
  803665:	ff d0                	callq  *%rax
  803667:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80366a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80366e:	79 02                	jns    803672 <init_stack+0x287>
  803670:	eb 07                	jmp    803679 <init_stack+0x28e>
  803672:	b8 00 00 00 00       	mov    $0x0,%eax
  803677:	eb 19                	jmp    803692 <init_stack+0x2a7>
  803679:	be 00 00 40 00       	mov    $0x400000,%esi
  80367e:	bf 00 00 00 00       	mov    $0x0,%edi
  803683:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  80368a:	00 00 00 
  80368d:	ff d0                	callq  *%rax
  80368f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803692:	c9                   	leaveq 
  803693:	c3                   	retq   

0000000000803694 <map_segment>:
  803694:	55                   	push   %rbp
  803695:	48 89 e5             	mov    %rsp,%rbp
  803698:	48 83 ec 50          	sub    $0x50,%rsp
  80369c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80369f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8036a3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8036a7:	89 4d d8             	mov    %ecx,-0x28(%rbp)
  8036aa:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8036ae:	44 89 4d bc          	mov    %r9d,-0x44(%rbp)
  8036b2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8036b6:	25 ff 0f 00 00       	and    $0xfff,%eax
  8036bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036c2:	74 21                	je     8036e5 <map_segment+0x51>
  8036c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036c7:	48 98                	cltq   
  8036c9:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  8036cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036d0:	48 98                	cltq   
  8036d2:	48 01 45 c8          	add    %rax,-0x38(%rbp)
  8036d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036d9:	48 98                	cltq   
  8036db:	48 01 45 c0          	add    %rax,-0x40(%rbp)
  8036df:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036e2:	29 45 bc             	sub    %eax,-0x44(%rbp)
  8036e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8036ec:	e9 79 01 00 00       	jmpq   80386a <map_segment+0x1d6>
  8036f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036f4:	48 98                	cltq   
  8036f6:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
  8036fa:	72 3c                	jb     803738 <map_segment+0xa4>
  8036fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036ff:	48 63 d0             	movslq %eax,%rdx
  803702:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803706:	48 01 d0             	add    %rdx,%rax
  803709:	48 89 c1             	mov    %rax,%rcx
  80370c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80370f:	8b 55 10             	mov    0x10(%rbp),%edx
  803712:	48 89 ce             	mov    %rcx,%rsi
  803715:	89 c7                	mov    %eax,%edi
  803717:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  80371e:	00 00 00 
  803721:	ff d0                	callq  *%rax
  803723:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803726:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80372a:	0f 89 33 01 00 00    	jns    803863 <map_segment+0x1cf>
  803730:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803733:	e9 46 01 00 00       	jmpq   80387e <map_segment+0x1ea>
  803738:	ba 07 00 00 00       	mov    $0x7,%edx
  80373d:	be 00 00 40 00       	mov    $0x400000,%esi
  803742:	bf 00 00 00 00       	mov    $0x0,%edi
  803747:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  80374e:	00 00 00 
  803751:	ff d0                	callq  *%rax
  803753:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803756:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80375a:	79 08                	jns    803764 <map_segment+0xd0>
  80375c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80375f:	e9 1a 01 00 00       	jmpq   80387e <map_segment+0x1ea>
  803764:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803767:	8b 55 bc             	mov    -0x44(%rbp),%edx
  80376a:	01 c2                	add    %eax,%edx
  80376c:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80376f:	89 d6                	mov    %edx,%esi
  803771:	89 c7                	mov    %eax,%edi
  803773:	48 b8 3b 25 80 00 00 	movabs $0x80253b,%rax
  80377a:	00 00 00 
  80377d:	ff d0                	callq  *%rax
  80377f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803782:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803786:	79 08                	jns    803790 <map_segment+0xfc>
  803788:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80378b:	e9 ee 00 00 00       	jmpq   80387e <map_segment+0x1ea>
  803790:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%rbp)
  803797:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80379a:	48 98                	cltq   
  80379c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8037a0:	48 29 c2             	sub    %rax,%rdx
  8037a3:	48 89 d0             	mov    %rdx,%rax
  8037a6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8037aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8037ad:	48 63 d0             	movslq %eax,%rdx
  8037b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037b4:	48 39 c2             	cmp    %rax,%rdx
  8037b7:	48 0f 47 d0          	cmova  %rax,%rdx
  8037bb:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8037be:	be 00 00 40 00       	mov    $0x400000,%esi
  8037c3:	89 c7                	mov    %eax,%edi
  8037c5:	48 b8 f2 23 80 00 00 	movabs $0x8023f2,%rax
  8037cc:	00 00 00 
  8037cf:	ff d0                	callq  *%rax
  8037d1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8037d4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8037d8:	79 08                	jns    8037e2 <map_segment+0x14e>
  8037da:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8037dd:	e9 9c 00 00 00       	jmpq   80387e <map_segment+0x1ea>
  8037e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037e5:	48 63 d0             	movslq %eax,%rdx
  8037e8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8037ec:	48 01 d0             	add    %rdx,%rax
  8037ef:	48 89 c2             	mov    %rax,%rdx
  8037f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8037f5:	44 8b 45 10          	mov    0x10(%rbp),%r8d
  8037f9:	48 89 d1             	mov    %rdx,%rcx
  8037fc:	89 c2                	mov    %eax,%edx
  8037fe:	be 00 00 40 00       	mov    $0x400000,%esi
  803803:	bf 00 00 00 00       	mov    $0x0,%edi
  803808:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  80380f:	00 00 00 
  803812:	ff d0                	callq  *%rax
  803814:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803817:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80381b:	79 30                	jns    80384d <map_segment+0x1b9>
  80381d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803820:	89 c1                	mov    %eax,%ecx
  803822:	48 ba f3 54 80 00 00 	movabs $0x8054f3,%rdx
  803829:	00 00 00 
  80382c:	be 29 01 00 00       	mov    $0x129,%esi
  803831:	48 bf 78 54 80 00 00 	movabs $0x805478,%rdi
  803838:	00 00 00 
  80383b:	b8 00 00 00 00       	mov    $0x0,%eax
  803840:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  803847:	00 00 00 
  80384a:	41 ff d0             	callq  *%r8
  80384d:	be 00 00 40 00       	mov    $0x400000,%esi
  803852:	bf 00 00 00 00       	mov    $0x0,%edi
  803857:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  80385e:	00 00 00 
  803861:	ff d0                	callq  *%rax
  803863:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
  80386a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80386d:	48 98                	cltq   
  80386f:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803873:	0f 82 78 fe ff ff    	jb     8036f1 <map_segment+0x5d>
  803879:	b8 00 00 00 00       	mov    $0x0,%eax
  80387e:	c9                   	leaveq 
  80387f:	c3                   	retq   

0000000000803880 <copy_shared_pages>:
  803880:	55                   	push   %rbp
  803881:	48 89 e5             	mov    %rsp,%rbp
  803884:	48 83 ec 30          	sub    $0x30,%rsp
  803888:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80388b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803892:	00 
  803893:	e9 eb 00 00 00       	jmpq   803983 <copy_shared_pages+0x103>
  803898:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80389c:	48 c1 f8 12          	sar    $0x12,%rax
  8038a0:	48 89 c2             	mov    %rax,%rdx
  8038a3:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  8038aa:	01 00 00 
  8038ad:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8038b1:	83 e0 01             	and    $0x1,%eax
  8038b4:	48 85 c0             	test   %rax,%rax
  8038b7:	74 21                	je     8038da <copy_shared_pages+0x5a>
  8038b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038bd:	48 c1 f8 09          	sar    $0x9,%rax
  8038c1:	48 89 c2             	mov    %rax,%rdx
  8038c4:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8038cb:	01 00 00 
  8038ce:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8038d2:	83 e0 01             	and    $0x1,%eax
  8038d5:	48 85 c0             	test   %rax,%rax
  8038d8:	75 0d                	jne    8038e7 <copy_shared_pages+0x67>
  8038da:	48 81 45 f8 00 02 00 	addq   $0x200,-0x8(%rbp)
  8038e1:	00 
  8038e2:	e9 9c 00 00 00       	jmpq   803983 <copy_shared_pages+0x103>
  8038e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038eb:	48 05 00 02 00 00    	add    $0x200,%rax
  8038f1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8038f5:	eb 7e                	jmp    803975 <copy_shared_pages+0xf5>
  8038f7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8038fe:	01 00 00 
  803901:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803905:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803909:	25 01 04 00 00       	and    $0x401,%eax
  80390e:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  803914:	75 5a                	jne    803970 <copy_shared_pages+0xf0>
  803916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80391a:	48 c1 e0 0c          	shl    $0xc,%rax
  80391e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803922:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803929:	01 00 00 
  80392c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803930:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803934:	25 07 0e 00 00       	and    $0xe07,%eax
  803939:	89 c6                	mov    %eax,%esi
  80393b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80393f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803942:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803946:	41 89 f0             	mov    %esi,%r8d
  803949:	48 89 c6             	mov    %rax,%rsi
  80394c:	bf 00 00 00 00       	mov    $0x0,%edi
  803951:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  803958:	00 00 00 
  80395b:	ff d0                	callq  *%rax
  80395d:	48 98                	cltq   
  80395f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803963:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803968:	79 06                	jns    803970 <copy_shared_pages+0xf0>
  80396a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80396e:	eb 28                	jmp    803998 <copy_shared_pages+0x118>
  803970:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803979:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80397d:	0f 8c 74 ff ff ff    	jl     8038f7 <copy_shared_pages+0x77>
  803983:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803987:	48 3d ff 07 00 08    	cmp    $0x80007ff,%rax
  80398d:	0f 86 05 ff ff ff    	jbe    803898 <copy_shared_pages+0x18>
  803993:	b8 00 00 00 00       	mov    $0x0,%eax
  803998:	c9                   	leaveq 
  803999:	c3                   	retq   

000000000080399a <fd2sockid>:
  80399a:	55                   	push   %rbp
  80399b:	48 89 e5             	mov    %rsp,%rbp
  80399e:	48 83 ec 20          	sub    $0x20,%rsp
  8039a2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039a5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8039a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039ac:	48 89 d6             	mov    %rdx,%rsi
  8039af:	89 c7                	mov    %eax,%edi
  8039b1:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  8039b8:	00 00 00 
  8039bb:	ff d0                	callq  *%rax
  8039bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039c4:	79 05                	jns    8039cb <fd2sockid+0x31>
  8039c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039c9:	eb 24                	jmp    8039ef <fd2sockid+0x55>
  8039cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039cf:	8b 10                	mov    (%rax),%edx
  8039d1:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  8039d8:	00 00 00 
  8039db:	8b 00                	mov    (%rax),%eax
  8039dd:	39 c2                	cmp    %eax,%edx
  8039df:	74 07                	je     8039e8 <fd2sockid+0x4e>
  8039e1:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8039e6:	eb 07                	jmp    8039ef <fd2sockid+0x55>
  8039e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039ec:	8b 40 0c             	mov    0xc(%rax),%eax
  8039ef:	c9                   	leaveq 
  8039f0:	c3                   	retq   

00000000008039f1 <alloc_sockfd>:
  8039f1:	55                   	push   %rbp
  8039f2:	48 89 e5             	mov    %rsp,%rbp
  8039f5:	48 83 ec 20          	sub    $0x20,%rsp
  8039f9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039fc:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803a00:	48 89 c7             	mov    %rax,%rdi
  803a03:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  803a0a:	00 00 00 
  803a0d:	ff d0                	callq  *%rax
  803a0f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a12:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a16:	78 26                	js     803a3e <alloc_sockfd+0x4d>
  803a18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a1c:	ba 07 04 00 00       	mov    $0x407,%edx
  803a21:	48 89 c6             	mov    %rax,%rsi
  803a24:	bf 00 00 00 00       	mov    $0x0,%edi
  803a29:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  803a30:	00 00 00 
  803a33:	ff d0                	callq  *%rax
  803a35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a38:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a3c:	79 16                	jns    803a54 <alloc_sockfd+0x63>
  803a3e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a41:	89 c7                	mov    %eax,%edi
  803a43:	48 b8 fe 3e 80 00 00 	movabs $0x803efe,%rax
  803a4a:	00 00 00 
  803a4d:	ff d0                	callq  *%rax
  803a4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a52:	eb 3a                	jmp    803a8e <alloc_sockfd+0x9d>
  803a54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a58:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  803a5f:	00 00 00 
  803a62:	8b 12                	mov    (%rdx),%edx
  803a64:	89 10                	mov    %edx,(%rax)
  803a66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a6a:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803a71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a75:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803a78:	89 50 0c             	mov    %edx,0xc(%rax)
  803a7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a7f:	48 89 c7             	mov    %rax,%rdi
  803a82:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  803a89:	00 00 00 
  803a8c:	ff d0                	callq  *%rax
  803a8e:	c9                   	leaveq 
  803a8f:	c3                   	retq   

0000000000803a90 <accept>:
  803a90:	55                   	push   %rbp
  803a91:	48 89 e5             	mov    %rsp,%rbp
  803a94:	48 83 ec 30          	sub    $0x30,%rsp
  803a98:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a9b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a9f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803aa3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803aa6:	89 c7                	mov    %eax,%edi
  803aa8:	48 b8 9a 39 80 00 00 	movabs $0x80399a,%rax
  803aaf:	00 00 00 
  803ab2:	ff d0                	callq  *%rax
  803ab4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ab7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803abb:	79 05                	jns    803ac2 <accept+0x32>
  803abd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ac0:	eb 3b                	jmp    803afd <accept+0x6d>
  803ac2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803ac6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803aca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803acd:	48 89 ce             	mov    %rcx,%rsi
  803ad0:	89 c7                	mov    %eax,%edi
  803ad2:	48 b8 db 3d 80 00 00 	movabs $0x803ddb,%rax
  803ad9:	00 00 00 
  803adc:	ff d0                	callq  *%rax
  803ade:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ae1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ae5:	79 05                	jns    803aec <accept+0x5c>
  803ae7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aea:	eb 11                	jmp    803afd <accept+0x6d>
  803aec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aef:	89 c7                	mov    %eax,%edi
  803af1:	48 b8 f1 39 80 00 00 	movabs $0x8039f1,%rax
  803af8:	00 00 00 
  803afb:	ff d0                	callq  *%rax
  803afd:	c9                   	leaveq 
  803afe:	c3                   	retq   

0000000000803aff <bind>:
  803aff:	55                   	push   %rbp
  803b00:	48 89 e5             	mov    %rsp,%rbp
  803b03:	48 83 ec 20          	sub    $0x20,%rsp
  803b07:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b0a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b0e:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803b11:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b14:	89 c7                	mov    %eax,%edi
  803b16:	48 b8 9a 39 80 00 00 	movabs $0x80399a,%rax
  803b1d:	00 00 00 
  803b20:	ff d0                	callq  *%rax
  803b22:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b25:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b29:	79 05                	jns    803b30 <bind+0x31>
  803b2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b2e:	eb 1b                	jmp    803b4b <bind+0x4c>
  803b30:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b33:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803b37:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b3a:	48 89 ce             	mov    %rcx,%rsi
  803b3d:	89 c7                	mov    %eax,%edi
  803b3f:	48 b8 5a 3e 80 00 00 	movabs $0x803e5a,%rax
  803b46:	00 00 00 
  803b49:	ff d0                	callq  *%rax
  803b4b:	c9                   	leaveq 
  803b4c:	c3                   	retq   

0000000000803b4d <shutdown>:
  803b4d:	55                   	push   %rbp
  803b4e:	48 89 e5             	mov    %rsp,%rbp
  803b51:	48 83 ec 20          	sub    $0x20,%rsp
  803b55:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b58:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803b5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b5e:	89 c7                	mov    %eax,%edi
  803b60:	48 b8 9a 39 80 00 00 	movabs $0x80399a,%rax
  803b67:	00 00 00 
  803b6a:	ff d0                	callq  *%rax
  803b6c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b6f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b73:	79 05                	jns    803b7a <shutdown+0x2d>
  803b75:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b78:	eb 16                	jmp    803b90 <shutdown+0x43>
  803b7a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b80:	89 d6                	mov    %edx,%esi
  803b82:	89 c7                	mov    %eax,%edi
  803b84:	48 b8 be 3e 80 00 00 	movabs $0x803ebe,%rax
  803b8b:	00 00 00 
  803b8e:	ff d0                	callq  *%rax
  803b90:	c9                   	leaveq 
  803b91:	c3                   	retq   

0000000000803b92 <devsock_close>:
  803b92:	55                   	push   %rbp
  803b93:	48 89 e5             	mov    %rsp,%rbp
  803b96:	48 83 ec 10          	sub    $0x10,%rsp
  803b9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ba2:	48 89 c7             	mov    %rax,%rdi
  803ba5:	48 b8 60 4c 80 00 00 	movabs $0x804c60,%rax
  803bac:	00 00 00 
  803baf:	ff d0                	callq  *%rax
  803bb1:	83 f8 01             	cmp    $0x1,%eax
  803bb4:	75 17                	jne    803bcd <devsock_close+0x3b>
  803bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803bba:	8b 40 0c             	mov    0xc(%rax),%eax
  803bbd:	89 c7                	mov    %eax,%edi
  803bbf:	48 b8 fe 3e 80 00 00 	movabs $0x803efe,%rax
  803bc6:	00 00 00 
  803bc9:	ff d0                	callq  *%rax
  803bcb:	eb 05                	jmp    803bd2 <devsock_close+0x40>
  803bcd:	b8 00 00 00 00       	mov    $0x0,%eax
  803bd2:	c9                   	leaveq 
  803bd3:	c3                   	retq   

0000000000803bd4 <connect>:
  803bd4:	55                   	push   %rbp
  803bd5:	48 89 e5             	mov    %rsp,%rbp
  803bd8:	48 83 ec 20          	sub    $0x20,%rsp
  803bdc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803bdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803be3:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803be6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803be9:	89 c7                	mov    %eax,%edi
  803beb:	48 b8 9a 39 80 00 00 	movabs $0x80399a,%rax
  803bf2:	00 00 00 
  803bf5:	ff d0                	callq  *%rax
  803bf7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bfa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bfe:	79 05                	jns    803c05 <connect+0x31>
  803c00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c03:	eb 1b                	jmp    803c20 <connect+0x4c>
  803c05:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c08:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803c0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c0f:	48 89 ce             	mov    %rcx,%rsi
  803c12:	89 c7                	mov    %eax,%edi
  803c14:	48 b8 2b 3f 80 00 00 	movabs $0x803f2b,%rax
  803c1b:	00 00 00 
  803c1e:	ff d0                	callq  *%rax
  803c20:	c9                   	leaveq 
  803c21:	c3                   	retq   

0000000000803c22 <listen>:
  803c22:	55                   	push   %rbp
  803c23:	48 89 e5             	mov    %rsp,%rbp
  803c26:	48 83 ec 20          	sub    $0x20,%rsp
  803c2a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c2d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803c30:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c33:	89 c7                	mov    %eax,%edi
  803c35:	48 b8 9a 39 80 00 00 	movabs $0x80399a,%rax
  803c3c:	00 00 00 
  803c3f:	ff d0                	callq  *%rax
  803c41:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c44:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c48:	79 05                	jns    803c4f <listen+0x2d>
  803c4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c4d:	eb 16                	jmp    803c65 <listen+0x43>
  803c4f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c52:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c55:	89 d6                	mov    %edx,%esi
  803c57:	89 c7                	mov    %eax,%edi
  803c59:	48 b8 8f 3f 80 00 00 	movabs $0x803f8f,%rax
  803c60:	00 00 00 
  803c63:	ff d0                	callq  *%rax
  803c65:	c9                   	leaveq 
  803c66:	c3                   	retq   

0000000000803c67 <devsock_read>:
  803c67:	55                   	push   %rbp
  803c68:	48 89 e5             	mov    %rsp,%rbp
  803c6b:	48 83 ec 20          	sub    $0x20,%rsp
  803c6f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803c73:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803c77:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803c7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803c7f:	89 c2                	mov    %eax,%edx
  803c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c85:	8b 40 0c             	mov    0xc(%rax),%eax
  803c88:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803c8c:	b9 00 00 00 00       	mov    $0x0,%ecx
  803c91:	89 c7                	mov    %eax,%edi
  803c93:	48 b8 cf 3f 80 00 00 	movabs $0x803fcf,%rax
  803c9a:	00 00 00 
  803c9d:	ff d0                	callq  *%rax
  803c9f:	c9                   	leaveq 
  803ca0:	c3                   	retq   

0000000000803ca1 <devsock_write>:
  803ca1:	55                   	push   %rbp
  803ca2:	48 89 e5             	mov    %rsp,%rbp
  803ca5:	48 83 ec 20          	sub    $0x20,%rsp
  803ca9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803cad:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cb1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803cb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803cb9:	89 c2                	mov    %eax,%edx
  803cbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803cbf:	8b 40 0c             	mov    0xc(%rax),%eax
  803cc2:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803cc6:	b9 00 00 00 00       	mov    $0x0,%ecx
  803ccb:	89 c7                	mov    %eax,%edi
  803ccd:	48 b8 9b 40 80 00 00 	movabs $0x80409b,%rax
  803cd4:	00 00 00 
  803cd7:	ff d0                	callq  *%rax
  803cd9:	c9                   	leaveq 
  803cda:	c3                   	retq   

0000000000803cdb <devsock_stat>:
  803cdb:	55                   	push   %rbp
  803cdc:	48 89 e5             	mov    %rsp,%rbp
  803cdf:	48 83 ec 10          	sub    $0x10,%rsp
  803ce3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803ce7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803ceb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cef:	48 be 15 55 80 00 00 	movabs $0x805515,%rsi
  803cf6:	00 00 00 
  803cf9:	48 89 c7             	mov    %rax,%rdi
  803cfc:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  803d03:	00 00 00 
  803d06:	ff d0                	callq  *%rax
  803d08:	b8 00 00 00 00       	mov    $0x0,%eax
  803d0d:	c9                   	leaveq 
  803d0e:	c3                   	retq   

0000000000803d0f <socket>:
  803d0f:	55                   	push   %rbp
  803d10:	48 89 e5             	mov    %rsp,%rbp
  803d13:	48 83 ec 20          	sub    $0x20,%rsp
  803d17:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d1a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803d1d:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803d20:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803d23:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803d26:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803d29:	89 ce                	mov    %ecx,%esi
  803d2b:	89 c7                	mov    %eax,%edi
  803d2d:	48 b8 53 41 80 00 00 	movabs $0x804153,%rax
  803d34:	00 00 00 
  803d37:	ff d0                	callq  *%rax
  803d39:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d3c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d40:	79 05                	jns    803d47 <socket+0x38>
  803d42:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d45:	eb 11                	jmp    803d58 <socket+0x49>
  803d47:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d4a:	89 c7                	mov    %eax,%edi
  803d4c:	48 b8 f1 39 80 00 00 	movabs $0x8039f1,%rax
  803d53:	00 00 00 
  803d56:	ff d0                	callq  *%rax
  803d58:	c9                   	leaveq 
  803d59:	c3                   	retq   

0000000000803d5a <nsipc>:
  803d5a:	55                   	push   %rbp
  803d5b:	48 89 e5             	mov    %rsp,%rbp
  803d5e:	48 83 ec 10          	sub    $0x10,%rsp
  803d62:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d65:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803d6c:	00 00 00 
  803d6f:	8b 00                	mov    (%rax),%eax
  803d71:	85 c0                	test   %eax,%eax
  803d73:	75 1d                	jne    803d92 <nsipc+0x38>
  803d75:	bf 02 00 00 00       	mov    $0x2,%edi
  803d7a:	48 b8 ee 4b 80 00 00 	movabs $0x804bee,%rax
  803d81:	00 00 00 
  803d84:	ff d0                	callq  *%rax
  803d86:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803d8d:	00 00 00 
  803d90:	89 02                	mov    %eax,(%rdx)
  803d92:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803d99:	00 00 00 
  803d9c:	8b 00                	mov    (%rax),%eax
  803d9e:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803da1:	b9 07 00 00 00       	mov    $0x7,%ecx
  803da6:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803dad:	00 00 00 
  803db0:	89 c7                	mov    %eax,%edi
  803db2:	48 b8 e3 4a 80 00 00 	movabs $0x804ae3,%rax
  803db9:	00 00 00 
  803dbc:	ff d0                	callq  *%rax
  803dbe:	ba 00 00 00 00       	mov    $0x0,%edx
  803dc3:	be 00 00 00 00       	mov    $0x0,%esi
  803dc8:	bf 00 00 00 00       	mov    $0x0,%edi
  803dcd:	48 b8 22 4a 80 00 00 	movabs $0x804a22,%rax
  803dd4:	00 00 00 
  803dd7:	ff d0                	callq  *%rax
  803dd9:	c9                   	leaveq 
  803dda:	c3                   	retq   

0000000000803ddb <nsipc_accept>:
  803ddb:	55                   	push   %rbp
  803ddc:	48 89 e5             	mov    %rsp,%rbp
  803ddf:	48 83 ec 30          	sub    $0x30,%rsp
  803de3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803de6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803dea:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803dee:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803df5:	00 00 00 
  803df8:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803dfb:	89 10                	mov    %edx,(%rax)
  803dfd:	bf 01 00 00 00       	mov    $0x1,%edi
  803e02:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803e09:	00 00 00 
  803e0c:	ff d0                	callq  *%rax
  803e0e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e11:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e15:	78 3e                	js     803e55 <nsipc_accept+0x7a>
  803e17:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e1e:	00 00 00 
  803e21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803e25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e29:	8b 40 10             	mov    0x10(%rax),%eax
  803e2c:	89 c2                	mov    %eax,%edx
  803e2e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803e32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e36:	48 89 ce             	mov    %rcx,%rsi
  803e39:	48 89 c7             	mov    %rax,%rdi
  803e3c:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  803e43:	00 00 00 
  803e46:	ff d0                	callq  *%rax
  803e48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e4c:	8b 50 10             	mov    0x10(%rax),%edx
  803e4f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e53:	89 10                	mov    %edx,(%rax)
  803e55:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e58:	c9                   	leaveq 
  803e59:	c3                   	retq   

0000000000803e5a <nsipc_bind>:
  803e5a:	55                   	push   %rbp
  803e5b:	48 89 e5             	mov    %rsp,%rbp
  803e5e:	48 83 ec 10          	sub    $0x10,%rsp
  803e62:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e65:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803e69:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803e6c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e73:	00 00 00 
  803e76:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803e79:	89 10                	mov    %edx,(%rax)
  803e7b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e82:	48 89 c6             	mov    %rax,%rsi
  803e85:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803e8c:	00 00 00 
  803e8f:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  803e96:	00 00 00 
  803e99:	ff d0                	callq  *%rax
  803e9b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ea2:	00 00 00 
  803ea5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ea8:	89 50 14             	mov    %edx,0x14(%rax)
  803eab:	bf 02 00 00 00       	mov    $0x2,%edi
  803eb0:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803eb7:	00 00 00 
  803eba:	ff d0                	callq  *%rax
  803ebc:	c9                   	leaveq 
  803ebd:	c3                   	retq   

0000000000803ebe <nsipc_shutdown>:
  803ebe:	55                   	push   %rbp
  803ebf:	48 89 e5             	mov    %rsp,%rbp
  803ec2:	48 83 ec 10          	sub    $0x10,%rsp
  803ec6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ec9:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803ecc:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ed3:	00 00 00 
  803ed6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ed9:	89 10                	mov    %edx,(%rax)
  803edb:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ee2:	00 00 00 
  803ee5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ee8:	89 50 04             	mov    %edx,0x4(%rax)
  803eeb:	bf 03 00 00 00       	mov    $0x3,%edi
  803ef0:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803ef7:	00 00 00 
  803efa:	ff d0                	callq  *%rax
  803efc:	c9                   	leaveq 
  803efd:	c3                   	retq   

0000000000803efe <nsipc_close>:
  803efe:	55                   	push   %rbp
  803eff:	48 89 e5             	mov    %rsp,%rbp
  803f02:	48 83 ec 10          	sub    $0x10,%rsp
  803f06:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f09:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f10:	00 00 00 
  803f13:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f16:	89 10                	mov    %edx,(%rax)
  803f18:	bf 04 00 00 00       	mov    $0x4,%edi
  803f1d:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803f24:	00 00 00 
  803f27:	ff d0                	callq  *%rax
  803f29:	c9                   	leaveq 
  803f2a:	c3                   	retq   

0000000000803f2b <nsipc_connect>:
  803f2b:	55                   	push   %rbp
  803f2c:	48 89 e5             	mov    %rsp,%rbp
  803f2f:	48 83 ec 10          	sub    $0x10,%rsp
  803f33:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f36:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803f3a:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803f3d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f44:	00 00 00 
  803f47:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f4a:	89 10                	mov    %edx,(%rax)
  803f4c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f53:	48 89 c6             	mov    %rax,%rsi
  803f56:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803f5d:	00 00 00 
  803f60:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  803f67:	00 00 00 
  803f6a:	ff d0                	callq  *%rax
  803f6c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f73:	00 00 00 
  803f76:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f79:	89 50 14             	mov    %edx,0x14(%rax)
  803f7c:	bf 05 00 00 00       	mov    $0x5,%edi
  803f81:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803f88:	00 00 00 
  803f8b:	ff d0                	callq  *%rax
  803f8d:	c9                   	leaveq 
  803f8e:	c3                   	retq   

0000000000803f8f <nsipc_listen>:
  803f8f:	55                   	push   %rbp
  803f90:	48 89 e5             	mov    %rsp,%rbp
  803f93:	48 83 ec 10          	sub    $0x10,%rsp
  803f97:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f9a:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803f9d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fa4:	00 00 00 
  803fa7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803faa:	89 10                	mov    %edx,(%rax)
  803fac:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fb3:	00 00 00 
  803fb6:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803fb9:	89 50 04             	mov    %edx,0x4(%rax)
  803fbc:	bf 06 00 00 00       	mov    $0x6,%edi
  803fc1:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  803fc8:	00 00 00 
  803fcb:	ff d0                	callq  *%rax
  803fcd:	c9                   	leaveq 
  803fce:	c3                   	retq   

0000000000803fcf <nsipc_recv>:
  803fcf:	55                   	push   %rbp
  803fd0:	48 89 e5             	mov    %rsp,%rbp
  803fd3:	48 83 ec 30          	sub    $0x30,%rsp
  803fd7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803fda:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803fde:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803fe1:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803fe4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803feb:	00 00 00 
  803fee:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803ff1:	89 10                	mov    %edx,(%rax)
  803ff3:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ffa:	00 00 00 
  803ffd:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804000:	89 50 04             	mov    %edx,0x4(%rax)
  804003:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80400a:	00 00 00 
  80400d:	8b 55 dc             	mov    -0x24(%rbp),%edx
  804010:	89 50 08             	mov    %edx,0x8(%rax)
  804013:	bf 07 00 00 00       	mov    $0x7,%edi
  804018:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  80401f:	00 00 00 
  804022:	ff d0                	callq  *%rax
  804024:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804027:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80402b:	78 69                	js     804096 <nsipc_recv+0xc7>
  80402d:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  804034:	7f 08                	jg     80403e <nsipc_recv+0x6f>
  804036:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804039:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  80403c:	7e 35                	jle    804073 <nsipc_recv+0xa4>
  80403e:	48 b9 1c 55 80 00 00 	movabs $0x80551c,%rcx
  804045:	00 00 00 
  804048:	48 ba 31 55 80 00 00 	movabs $0x805531,%rdx
  80404f:	00 00 00 
  804052:	be 62 00 00 00       	mov    $0x62,%esi
  804057:	48 bf 46 55 80 00 00 	movabs $0x805546,%rdi
  80405e:	00 00 00 
  804061:	b8 00 00 00 00       	mov    $0x0,%eax
  804066:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  80406d:	00 00 00 
  804070:	41 ff d0             	callq  *%r8
  804073:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804076:	48 63 d0             	movslq %eax,%rdx
  804079:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80407d:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  804084:	00 00 00 
  804087:	48 89 c7             	mov    %rax,%rdi
  80408a:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  804091:	00 00 00 
  804094:	ff d0                	callq  *%rax
  804096:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804099:	c9                   	leaveq 
  80409a:	c3                   	retq   

000000000080409b <nsipc_send>:
  80409b:	55                   	push   %rbp
  80409c:	48 89 e5             	mov    %rsp,%rbp
  80409f:	48 83 ec 20          	sub    $0x20,%rsp
  8040a3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8040a6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8040aa:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8040ad:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8040b0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8040b7:	00 00 00 
  8040ba:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8040bd:	89 10                	mov    %edx,(%rax)
  8040bf:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  8040c6:	7e 35                	jle    8040fd <nsipc_send+0x62>
  8040c8:	48 b9 55 55 80 00 00 	movabs $0x805555,%rcx
  8040cf:	00 00 00 
  8040d2:	48 ba 31 55 80 00 00 	movabs $0x805531,%rdx
  8040d9:	00 00 00 
  8040dc:	be 6d 00 00 00       	mov    $0x6d,%esi
  8040e1:	48 bf 46 55 80 00 00 	movabs $0x805546,%rdi
  8040e8:	00 00 00 
  8040eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8040f0:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  8040f7:	00 00 00 
  8040fa:	41 ff d0             	callq  *%r8
  8040fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804100:	48 63 d0             	movslq %eax,%rdx
  804103:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804107:	48 89 c6             	mov    %rax,%rsi
  80410a:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  804111:	00 00 00 
  804114:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  80411b:	00 00 00 
  80411e:	ff d0                	callq  *%rax
  804120:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804127:	00 00 00 
  80412a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80412d:	89 50 04             	mov    %edx,0x4(%rax)
  804130:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804137:	00 00 00 
  80413a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80413d:	89 50 08             	mov    %edx,0x8(%rax)
  804140:	bf 08 00 00 00       	mov    $0x8,%edi
  804145:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  80414c:	00 00 00 
  80414f:	ff d0                	callq  *%rax
  804151:	c9                   	leaveq 
  804152:	c3                   	retq   

0000000000804153 <nsipc_socket>:
  804153:	55                   	push   %rbp
  804154:	48 89 e5             	mov    %rsp,%rbp
  804157:	48 83 ec 10          	sub    $0x10,%rsp
  80415b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80415e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804161:	89 55 f4             	mov    %edx,-0xc(%rbp)
  804164:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80416b:	00 00 00 
  80416e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804171:	89 10                	mov    %edx,(%rax)
  804173:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80417a:	00 00 00 
  80417d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804180:	89 50 04             	mov    %edx,0x4(%rax)
  804183:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80418a:	00 00 00 
  80418d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804190:	89 50 08             	mov    %edx,0x8(%rax)
  804193:	bf 09 00 00 00       	mov    $0x9,%edi
  804198:	48 b8 5a 3d 80 00 00 	movabs $0x803d5a,%rax
  80419f:	00 00 00 
  8041a2:	ff d0                	callq  *%rax
  8041a4:	c9                   	leaveq 
  8041a5:	c3                   	retq   

00000000008041a6 <pipe>:
  8041a6:	55                   	push   %rbp
  8041a7:	48 89 e5             	mov    %rsp,%rbp
  8041aa:	53                   	push   %rbx
  8041ab:	48 83 ec 38          	sub    $0x38,%rsp
  8041af:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8041b3:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8041b7:	48 89 c7             	mov    %rax,%rdi
  8041ba:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  8041c1:	00 00 00 
  8041c4:	ff d0                	callq  *%rax
  8041c6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8041c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8041cd:	0f 88 bf 01 00 00    	js     804392 <pipe+0x1ec>
  8041d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8041d7:	ba 07 04 00 00       	mov    $0x407,%edx
  8041dc:	48 89 c6             	mov    %rax,%rsi
  8041df:	bf 00 00 00 00       	mov    $0x0,%edi
  8041e4:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  8041eb:	00 00 00 
  8041ee:	ff d0                	callq  *%rax
  8041f0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8041f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8041f7:	0f 88 95 01 00 00    	js     804392 <pipe+0x1ec>
  8041fd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804201:	48 89 c7             	mov    %rax,%rdi
  804204:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  80420b:	00 00 00 
  80420e:	ff d0                	callq  *%rax
  804210:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804213:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804217:	0f 88 5d 01 00 00    	js     80437a <pipe+0x1d4>
  80421d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804221:	ba 07 04 00 00       	mov    $0x407,%edx
  804226:	48 89 c6             	mov    %rax,%rsi
  804229:	bf 00 00 00 00       	mov    $0x0,%edi
  80422e:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  804235:	00 00 00 
  804238:	ff d0                	callq  *%rax
  80423a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80423d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804241:	0f 88 33 01 00 00    	js     80437a <pipe+0x1d4>
  804247:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80424b:	48 89 c7             	mov    %rax,%rdi
  80424e:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  804255:	00 00 00 
  804258:	ff d0                	callq  *%rax
  80425a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80425e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804262:	ba 07 04 00 00       	mov    $0x407,%edx
  804267:	48 89 c6             	mov    %rax,%rsi
  80426a:	bf 00 00 00 00       	mov    $0x0,%edi
  80426f:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  804276:	00 00 00 
  804279:	ff d0                	callq  *%rax
  80427b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80427e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804282:	79 05                	jns    804289 <pipe+0xe3>
  804284:	e9 d9 00 00 00       	jmpq   804362 <pipe+0x1bc>
  804289:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80428d:	48 89 c7             	mov    %rax,%rdi
  804290:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  804297:	00 00 00 
  80429a:	ff d0                	callq  *%rax
  80429c:	48 89 c2             	mov    %rax,%rdx
  80429f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8042a3:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8042a9:	48 89 d1             	mov    %rdx,%rcx
  8042ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8042b1:	48 89 c6             	mov    %rax,%rsi
  8042b4:	bf 00 00 00 00       	mov    $0x0,%edi
  8042b9:	48 b8 75 1a 80 00 00 	movabs $0x801a75,%rax
  8042c0:	00 00 00 
  8042c3:	ff d0                	callq  *%rax
  8042c5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8042c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8042cc:	79 1b                	jns    8042e9 <pipe+0x143>
  8042ce:	90                   	nop
  8042cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8042d3:	48 89 c6             	mov    %rax,%rsi
  8042d6:	bf 00 00 00 00       	mov    $0x0,%edi
  8042db:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  8042e2:	00 00 00 
  8042e5:	ff d0                	callq  *%rax
  8042e7:	eb 79                	jmp    804362 <pipe+0x1bc>
  8042e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8042ed:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  8042f4:	00 00 00 
  8042f7:	8b 12                	mov    (%rdx),%edx
  8042f9:	89 10                	mov    %edx,(%rax)
  8042fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8042ff:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  804306:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80430a:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804311:	00 00 00 
  804314:	8b 12                	mov    (%rdx),%edx
  804316:	89 10                	mov    %edx,(%rax)
  804318:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80431c:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  804323:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804327:	48 89 c7             	mov    %rax,%rdi
  80432a:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  804331:	00 00 00 
  804334:	ff d0                	callq  *%rax
  804336:	89 c2                	mov    %eax,%edx
  804338:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80433c:	89 10                	mov    %edx,(%rax)
  80433e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804342:	48 8d 58 04          	lea    0x4(%rax),%rbx
  804346:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80434a:	48 89 c7             	mov    %rax,%rdi
  80434d:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  804354:	00 00 00 
  804357:	ff d0                	callq  *%rax
  804359:	89 03                	mov    %eax,(%rbx)
  80435b:	b8 00 00 00 00       	mov    $0x0,%eax
  804360:	eb 33                	jmp    804395 <pipe+0x1ef>
  804362:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804366:	48 89 c6             	mov    %rax,%rsi
  804369:	bf 00 00 00 00       	mov    $0x0,%edi
  80436e:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  804375:	00 00 00 
  804378:	ff d0                	callq  *%rax
  80437a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80437e:	48 89 c6             	mov    %rax,%rsi
  804381:	bf 00 00 00 00       	mov    $0x0,%edi
  804386:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  80438d:	00 00 00 
  804390:	ff d0                	callq  *%rax
  804392:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804395:	48 83 c4 38          	add    $0x38,%rsp
  804399:	5b                   	pop    %rbx
  80439a:	5d                   	pop    %rbp
  80439b:	c3                   	retq   

000000000080439c <_pipeisclosed>:
  80439c:	55                   	push   %rbp
  80439d:	48 89 e5             	mov    %rsp,%rbp
  8043a0:	53                   	push   %rbx
  8043a1:	48 83 ec 28          	sub    $0x28,%rsp
  8043a5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8043a9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8043ad:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8043b4:	00 00 00 
  8043b7:	48 8b 00             	mov    (%rax),%rax
  8043ba:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8043c0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8043c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043c7:	48 89 c7             	mov    %rax,%rdi
  8043ca:	48 b8 60 4c 80 00 00 	movabs $0x804c60,%rax
  8043d1:	00 00 00 
  8043d4:	ff d0                	callq  *%rax
  8043d6:	89 c3                	mov    %eax,%ebx
  8043d8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8043dc:	48 89 c7             	mov    %rax,%rdi
  8043df:	48 b8 60 4c 80 00 00 	movabs $0x804c60,%rax
  8043e6:	00 00 00 
  8043e9:	ff d0                	callq  *%rax
  8043eb:	39 c3                	cmp    %eax,%ebx
  8043ed:	0f 94 c0             	sete   %al
  8043f0:	0f b6 c0             	movzbl %al,%eax
  8043f3:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8043f6:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8043fd:	00 00 00 
  804400:	48 8b 00             	mov    (%rax),%rax
  804403:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804409:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80440c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80440f:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804412:	75 05                	jne    804419 <_pipeisclosed+0x7d>
  804414:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804417:	eb 4f                	jmp    804468 <_pipeisclosed+0xcc>
  804419:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80441c:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80441f:	74 42                	je     804463 <_pipeisclosed+0xc7>
  804421:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  804425:	75 3c                	jne    804463 <_pipeisclosed+0xc7>
  804427:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80442e:	00 00 00 
  804431:	48 8b 00             	mov    (%rax),%rax
  804434:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80443a:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80443d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804440:	89 c6                	mov    %eax,%esi
  804442:	48 bf 66 55 80 00 00 	movabs $0x805566,%rdi
  804449:	00 00 00 
  80444c:	b8 00 00 00 00       	mov    $0x0,%eax
  804451:	49 b8 41 05 80 00 00 	movabs $0x800541,%r8
  804458:	00 00 00 
  80445b:	41 ff d0             	callq  *%r8
  80445e:	e9 4a ff ff ff       	jmpq   8043ad <_pipeisclosed+0x11>
  804463:	e9 45 ff ff ff       	jmpq   8043ad <_pipeisclosed+0x11>
  804468:	48 83 c4 28          	add    $0x28,%rsp
  80446c:	5b                   	pop    %rbx
  80446d:	5d                   	pop    %rbp
  80446e:	c3                   	retq   

000000000080446f <pipeisclosed>:
  80446f:	55                   	push   %rbp
  804470:	48 89 e5             	mov    %rsp,%rbp
  804473:	48 83 ec 30          	sub    $0x30,%rsp
  804477:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80447a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80447e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804481:	48 89 d6             	mov    %rdx,%rsi
  804484:	89 c7                	mov    %eax,%edi
  804486:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  80448d:	00 00 00 
  804490:	ff d0                	callq  *%rax
  804492:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804495:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804499:	79 05                	jns    8044a0 <pipeisclosed+0x31>
  80449b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80449e:	eb 31                	jmp    8044d1 <pipeisclosed+0x62>
  8044a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044a4:	48 89 c7             	mov    %rax,%rdi
  8044a7:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8044ae:	00 00 00 
  8044b1:	ff d0                	callq  *%rax
  8044b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8044b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044bb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8044bf:	48 89 d6             	mov    %rdx,%rsi
  8044c2:	48 89 c7             	mov    %rax,%rdi
  8044c5:	48 b8 9c 43 80 00 00 	movabs $0x80439c,%rax
  8044cc:	00 00 00 
  8044cf:	ff d0                	callq  *%rax
  8044d1:	c9                   	leaveq 
  8044d2:	c3                   	retq   

00000000008044d3 <devpipe_read>:
  8044d3:	55                   	push   %rbp
  8044d4:	48 89 e5             	mov    %rsp,%rbp
  8044d7:	48 83 ec 40          	sub    $0x40,%rsp
  8044db:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8044df:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8044e3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8044e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8044eb:	48 89 c7             	mov    %rax,%rdi
  8044ee:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8044f5:	00 00 00 
  8044f8:	ff d0                	callq  *%rax
  8044fa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8044fe:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804502:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804506:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80450d:	00 
  80450e:	e9 92 00 00 00       	jmpq   8045a5 <devpipe_read+0xd2>
  804513:	eb 41                	jmp    804556 <devpipe_read+0x83>
  804515:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80451a:	74 09                	je     804525 <devpipe_read+0x52>
  80451c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804520:	e9 92 00 00 00       	jmpq   8045b7 <devpipe_read+0xe4>
  804525:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804529:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80452d:	48 89 d6             	mov    %rdx,%rsi
  804530:	48 89 c7             	mov    %rax,%rdi
  804533:	48 b8 9c 43 80 00 00 	movabs $0x80439c,%rax
  80453a:	00 00 00 
  80453d:	ff d0                	callq  *%rax
  80453f:	85 c0                	test   %eax,%eax
  804541:	74 07                	je     80454a <devpipe_read+0x77>
  804543:	b8 00 00 00 00       	mov    $0x0,%eax
  804548:	eb 6d                	jmp    8045b7 <devpipe_read+0xe4>
  80454a:	48 b8 e7 19 80 00 00 	movabs $0x8019e7,%rax
  804551:	00 00 00 
  804554:	ff d0                	callq  *%rax
  804556:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80455a:	8b 10                	mov    (%rax),%edx
  80455c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804560:	8b 40 04             	mov    0x4(%rax),%eax
  804563:	39 c2                	cmp    %eax,%edx
  804565:	74 ae                	je     804515 <devpipe_read+0x42>
  804567:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80456b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80456f:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  804573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804577:	8b 00                	mov    (%rax),%eax
  804579:	99                   	cltd   
  80457a:	c1 ea 1b             	shr    $0x1b,%edx
  80457d:	01 d0                	add    %edx,%eax
  80457f:	83 e0 1f             	and    $0x1f,%eax
  804582:	29 d0                	sub    %edx,%eax
  804584:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804588:	48 98                	cltq   
  80458a:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  80458f:	88 01                	mov    %al,(%rcx)
  804591:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804595:	8b 00                	mov    (%rax),%eax
  804597:	8d 50 01             	lea    0x1(%rax),%edx
  80459a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80459e:	89 10                	mov    %edx,(%rax)
  8045a0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8045a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045a9:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8045ad:	0f 82 60 ff ff ff    	jb     804513 <devpipe_read+0x40>
  8045b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045b7:	c9                   	leaveq 
  8045b8:	c3                   	retq   

00000000008045b9 <devpipe_write>:
  8045b9:	55                   	push   %rbp
  8045ba:	48 89 e5             	mov    %rsp,%rbp
  8045bd:	48 83 ec 40          	sub    $0x40,%rsp
  8045c1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8045c5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8045c9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8045cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8045d1:	48 89 c7             	mov    %rax,%rdi
  8045d4:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8045db:	00 00 00 
  8045de:	ff d0                	callq  *%rax
  8045e0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8045e4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8045e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8045ec:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8045f3:	00 
  8045f4:	e9 8e 00 00 00       	jmpq   804687 <devpipe_write+0xce>
  8045f9:	eb 31                	jmp    80462c <devpipe_write+0x73>
  8045fb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8045ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804603:	48 89 d6             	mov    %rdx,%rsi
  804606:	48 89 c7             	mov    %rax,%rdi
  804609:	48 b8 9c 43 80 00 00 	movabs $0x80439c,%rax
  804610:	00 00 00 
  804613:	ff d0                	callq  *%rax
  804615:	85 c0                	test   %eax,%eax
  804617:	74 07                	je     804620 <devpipe_write+0x67>
  804619:	b8 00 00 00 00       	mov    $0x0,%eax
  80461e:	eb 79                	jmp    804699 <devpipe_write+0xe0>
  804620:	48 b8 e7 19 80 00 00 	movabs $0x8019e7,%rax
  804627:	00 00 00 
  80462a:	ff d0                	callq  *%rax
  80462c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804630:	8b 40 04             	mov    0x4(%rax),%eax
  804633:	48 63 d0             	movslq %eax,%rdx
  804636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80463a:	8b 00                	mov    (%rax),%eax
  80463c:	48 98                	cltq   
  80463e:	48 83 c0 20          	add    $0x20,%rax
  804642:	48 39 c2             	cmp    %rax,%rdx
  804645:	73 b4                	jae    8045fb <devpipe_write+0x42>
  804647:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80464b:	8b 40 04             	mov    0x4(%rax),%eax
  80464e:	99                   	cltd   
  80464f:	c1 ea 1b             	shr    $0x1b,%edx
  804652:	01 d0                	add    %edx,%eax
  804654:	83 e0 1f             	and    $0x1f,%eax
  804657:	29 d0                	sub    %edx,%eax
  804659:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80465d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804661:	48 01 ca             	add    %rcx,%rdx
  804664:	0f b6 0a             	movzbl (%rdx),%ecx
  804667:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80466b:	48 98                	cltq   
  80466d:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  804671:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804675:	8b 40 04             	mov    0x4(%rax),%eax
  804678:	8d 50 01             	lea    0x1(%rax),%edx
  80467b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80467f:	89 50 04             	mov    %edx,0x4(%rax)
  804682:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804687:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80468b:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80468f:	0f 82 64 ff ff ff    	jb     8045f9 <devpipe_write+0x40>
  804695:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804699:	c9                   	leaveq 
  80469a:	c3                   	retq   

000000000080469b <devpipe_stat>:
  80469b:	55                   	push   %rbp
  80469c:	48 89 e5             	mov    %rsp,%rbp
  80469f:	48 83 ec 20          	sub    $0x20,%rsp
  8046a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8046a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8046ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8046af:	48 89 c7             	mov    %rax,%rdi
  8046b2:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  8046b9:	00 00 00 
  8046bc:	ff d0                	callq  *%rax
  8046be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8046c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046c6:	48 be 79 55 80 00 00 	movabs $0x805579,%rsi
  8046cd:	00 00 00 
  8046d0:	48 89 c7             	mov    %rax,%rdi
  8046d3:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  8046da:	00 00 00 
  8046dd:	ff d0                	callq  *%rax
  8046df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046e3:	8b 50 04             	mov    0x4(%rax),%edx
  8046e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046ea:	8b 00                	mov    (%rax),%eax
  8046ec:	29 c2                	sub    %eax,%edx
  8046ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046f2:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8046f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046fc:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804703:	00 00 00 
  804706:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80470a:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804711:	00 00 00 
  804714:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  80471b:	b8 00 00 00 00       	mov    $0x0,%eax
  804720:	c9                   	leaveq 
  804721:	c3                   	retq   

0000000000804722 <devpipe_close>:
  804722:	55                   	push   %rbp
  804723:	48 89 e5             	mov    %rsp,%rbp
  804726:	48 83 ec 10          	sub    $0x10,%rsp
  80472a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80472e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804732:	48 89 c6             	mov    %rax,%rsi
  804735:	bf 00 00 00 00       	mov    $0x0,%edi
  80473a:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  804741:	00 00 00 
  804744:	ff d0                	callq  *%rax
  804746:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80474a:	48 89 c7             	mov    %rax,%rdi
  80474d:	48 b8 28 1e 80 00 00 	movabs $0x801e28,%rax
  804754:	00 00 00 
  804757:	ff d0                	callq  *%rax
  804759:	48 89 c6             	mov    %rax,%rsi
  80475c:	bf 00 00 00 00       	mov    $0x0,%edi
  804761:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  804768:	00 00 00 
  80476b:	ff d0                	callq  *%rax
  80476d:	c9                   	leaveq 
  80476e:	c3                   	retq   

000000000080476f <cputchar>:
  80476f:	55                   	push   %rbp
  804770:	48 89 e5             	mov    %rsp,%rbp
  804773:	48 83 ec 20          	sub    $0x20,%rsp
  804777:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80477a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80477d:	88 45 ff             	mov    %al,-0x1(%rbp)
  804780:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  804784:	be 01 00 00 00       	mov    $0x1,%esi
  804789:	48 89 c7             	mov    %rax,%rdi
  80478c:	48 b8 dd 18 80 00 00 	movabs $0x8018dd,%rax
  804793:	00 00 00 
  804796:	ff d0                	callq  *%rax
  804798:	c9                   	leaveq 
  804799:	c3                   	retq   

000000000080479a <getchar>:
  80479a:	55                   	push   %rbp
  80479b:	48 89 e5             	mov    %rsp,%rbp
  80479e:	48 83 ec 10          	sub    $0x10,%rsp
  8047a2:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8047a6:	ba 01 00 00 00       	mov    $0x1,%edx
  8047ab:	48 89 c6             	mov    %rax,%rsi
  8047ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8047b3:	48 b8 1d 23 80 00 00 	movabs $0x80231d,%rax
  8047ba:	00 00 00 
  8047bd:	ff d0                	callq  *%rax
  8047bf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8047c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047c6:	79 05                	jns    8047cd <getchar+0x33>
  8047c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047cb:	eb 14                	jmp    8047e1 <getchar+0x47>
  8047cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047d1:	7f 07                	jg     8047da <getchar+0x40>
  8047d3:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  8047d8:	eb 07                	jmp    8047e1 <getchar+0x47>
  8047da:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8047de:	0f b6 c0             	movzbl %al,%eax
  8047e1:	c9                   	leaveq 
  8047e2:	c3                   	retq   

00000000008047e3 <iscons>:
  8047e3:	55                   	push   %rbp
  8047e4:	48 89 e5             	mov    %rsp,%rbp
  8047e7:	48 83 ec 20          	sub    $0x20,%rsp
  8047eb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8047ee:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8047f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8047f5:	48 89 d6             	mov    %rdx,%rsi
  8047f8:	89 c7                	mov    %eax,%edi
  8047fa:	48 b8 eb 1e 80 00 00 	movabs $0x801eeb,%rax
  804801:	00 00 00 
  804804:	ff d0                	callq  *%rax
  804806:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804809:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80480d:	79 05                	jns    804814 <iscons+0x31>
  80480f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804812:	eb 1a                	jmp    80482e <iscons+0x4b>
  804814:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804818:	8b 10                	mov    (%rax),%edx
  80481a:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  804821:	00 00 00 
  804824:	8b 00                	mov    (%rax),%eax
  804826:	39 c2                	cmp    %eax,%edx
  804828:	0f 94 c0             	sete   %al
  80482b:	0f b6 c0             	movzbl %al,%eax
  80482e:	c9                   	leaveq 
  80482f:	c3                   	retq   

0000000000804830 <opencons>:
  804830:	55                   	push   %rbp
  804831:	48 89 e5             	mov    %rsp,%rbp
  804834:	48 83 ec 10          	sub    $0x10,%rsp
  804838:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80483c:	48 89 c7             	mov    %rax,%rdi
  80483f:	48 b8 53 1e 80 00 00 	movabs $0x801e53,%rax
  804846:	00 00 00 
  804849:	ff d0                	callq  *%rax
  80484b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80484e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804852:	79 05                	jns    804859 <opencons+0x29>
  804854:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804857:	eb 5b                	jmp    8048b4 <opencons+0x84>
  804859:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80485d:	ba 07 04 00 00       	mov    $0x407,%edx
  804862:	48 89 c6             	mov    %rax,%rsi
  804865:	bf 00 00 00 00       	mov    $0x0,%edi
  80486a:	48 b8 25 1a 80 00 00 	movabs $0x801a25,%rax
  804871:	00 00 00 
  804874:	ff d0                	callq  *%rax
  804876:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804879:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80487d:	79 05                	jns    804884 <opencons+0x54>
  80487f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804882:	eb 30                	jmp    8048b4 <opencons+0x84>
  804884:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804888:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  80488f:	00 00 00 
  804892:	8b 12                	mov    (%rdx),%edx
  804894:	89 10                	mov    %edx,(%rax)
  804896:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80489a:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8048a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8048a5:	48 89 c7             	mov    %rax,%rdi
  8048a8:	48 b8 05 1e 80 00 00 	movabs $0x801e05,%rax
  8048af:	00 00 00 
  8048b2:	ff d0                	callq  *%rax
  8048b4:	c9                   	leaveq 
  8048b5:	c3                   	retq   

00000000008048b6 <devcons_read>:
  8048b6:	55                   	push   %rbp
  8048b7:	48 89 e5             	mov    %rsp,%rbp
  8048ba:	48 83 ec 30          	sub    $0x30,%rsp
  8048be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8048c2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8048c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8048ca:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8048cf:	75 07                	jne    8048d8 <devcons_read+0x22>
  8048d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8048d6:	eb 4b                	jmp    804923 <devcons_read+0x6d>
  8048d8:	eb 0c                	jmp    8048e6 <devcons_read+0x30>
  8048da:	48 b8 e7 19 80 00 00 	movabs $0x8019e7,%rax
  8048e1:	00 00 00 
  8048e4:	ff d0                	callq  *%rax
  8048e6:	48 b8 27 19 80 00 00 	movabs $0x801927,%rax
  8048ed:	00 00 00 
  8048f0:	ff d0                	callq  *%rax
  8048f2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048f9:	74 df                	je     8048da <devcons_read+0x24>
  8048fb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048ff:	79 05                	jns    804906 <devcons_read+0x50>
  804901:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804904:	eb 1d                	jmp    804923 <devcons_read+0x6d>
  804906:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80490a:	75 07                	jne    804913 <devcons_read+0x5d>
  80490c:	b8 00 00 00 00       	mov    $0x0,%eax
  804911:	eb 10                	jmp    804923 <devcons_read+0x6d>
  804913:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804916:	89 c2                	mov    %eax,%edx
  804918:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80491c:	88 10                	mov    %dl,(%rax)
  80491e:	b8 01 00 00 00       	mov    $0x1,%eax
  804923:	c9                   	leaveq 
  804924:	c3                   	retq   

0000000000804925 <devcons_write>:
  804925:	55                   	push   %rbp
  804926:	48 89 e5             	mov    %rsp,%rbp
  804929:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804930:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804937:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80493e:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  804945:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80494c:	eb 76                	jmp    8049c4 <devcons_write+0x9f>
  80494e:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  804955:	89 c2                	mov    %eax,%edx
  804957:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80495a:	29 c2                	sub    %eax,%edx
  80495c:	89 d0                	mov    %edx,%eax
  80495e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804961:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804964:	83 f8 7f             	cmp    $0x7f,%eax
  804967:	76 07                	jbe    804970 <devcons_write+0x4b>
  804969:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804970:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804973:	48 63 d0             	movslq %eax,%rdx
  804976:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804979:	48 63 c8             	movslq %eax,%rcx
  80497c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804983:	48 01 c1             	add    %rax,%rcx
  804986:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  80498d:	48 89 ce             	mov    %rcx,%rsi
  804990:	48 89 c7             	mov    %rax,%rdi
  804993:	48 b8 1a 14 80 00 00 	movabs $0x80141a,%rax
  80499a:	00 00 00 
  80499d:	ff d0                	callq  *%rax
  80499f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8049a2:	48 63 d0             	movslq %eax,%rdx
  8049a5:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8049ac:	48 89 d6             	mov    %rdx,%rsi
  8049af:	48 89 c7             	mov    %rax,%rdi
  8049b2:	48 b8 dd 18 80 00 00 	movabs $0x8018dd,%rax
  8049b9:	00 00 00 
  8049bc:	ff d0                	callq  *%rax
  8049be:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8049c1:	01 45 fc             	add    %eax,-0x4(%rbp)
  8049c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049c7:	48 98                	cltq   
  8049c9:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  8049d0:	0f 82 78 ff ff ff    	jb     80494e <devcons_write+0x29>
  8049d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049d9:	c9                   	leaveq 
  8049da:	c3                   	retq   

00000000008049db <devcons_close>:
  8049db:	55                   	push   %rbp
  8049dc:	48 89 e5             	mov    %rsp,%rbp
  8049df:	48 83 ec 08          	sub    $0x8,%rsp
  8049e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8049e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8049ec:	c9                   	leaveq 
  8049ed:	c3                   	retq   

00000000008049ee <devcons_stat>:
  8049ee:	55                   	push   %rbp
  8049ef:	48 89 e5             	mov    %rsp,%rbp
  8049f2:	48 83 ec 10          	sub    $0x10,%rsp
  8049f6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8049fa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8049fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a02:	48 be 85 55 80 00 00 	movabs $0x805585,%rsi
  804a09:	00 00 00 
  804a0c:	48 89 c7             	mov    %rax,%rdi
  804a0f:	48 b8 f6 10 80 00 00 	movabs $0x8010f6,%rax
  804a16:	00 00 00 
  804a19:	ff d0                	callq  *%rax
  804a1b:	b8 00 00 00 00       	mov    $0x0,%eax
  804a20:	c9                   	leaveq 
  804a21:	c3                   	retq   

0000000000804a22 <ipc_recv>:
  804a22:	55                   	push   %rbp
  804a23:	48 89 e5             	mov    %rsp,%rbp
  804a26:	48 83 ec 30          	sub    $0x30,%rsp
  804a2a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804a2e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804a32:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804a36:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804a3b:	75 0e                	jne    804a4b <ipc_recv+0x29>
  804a3d:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804a44:	00 00 00 
  804a47:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804a4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804a4f:	48 89 c7             	mov    %rax,%rdi
  804a52:	48 b8 4e 1c 80 00 00 	movabs $0x801c4e,%rax
  804a59:	00 00 00 
  804a5c:	ff d0                	callq  *%rax
  804a5e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804a61:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804a65:	79 27                	jns    804a8e <ipc_recv+0x6c>
  804a67:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804a6c:	74 0a                	je     804a78 <ipc_recv+0x56>
  804a6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804a72:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804a78:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804a7d:	74 0a                	je     804a89 <ipc_recv+0x67>
  804a7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804a83:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804a89:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a8c:	eb 53                	jmp    804ae1 <ipc_recv+0xbf>
  804a8e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804a93:	74 19                	je     804aae <ipc_recv+0x8c>
  804a95:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804a9c:	00 00 00 
  804a9f:	48 8b 00             	mov    (%rax),%rax
  804aa2:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  804aa8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804aac:	89 10                	mov    %edx,(%rax)
  804aae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804ab3:	74 19                	je     804ace <ipc_recv+0xac>
  804ab5:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804abc:	00 00 00 
  804abf:	48 8b 00             	mov    (%rax),%rax
  804ac2:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804ac8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804acc:	89 10                	mov    %edx,(%rax)
  804ace:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804ad5:	00 00 00 
  804ad8:	48 8b 00             	mov    (%rax),%rax
  804adb:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804ae1:	c9                   	leaveq 
  804ae2:	c3                   	retq   

0000000000804ae3 <ipc_send>:
  804ae3:	55                   	push   %rbp
  804ae4:	48 89 e5             	mov    %rsp,%rbp
  804ae7:	48 83 ec 30          	sub    $0x30,%rsp
  804aeb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804aee:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804af1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804af5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804af8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804afd:	75 10                	jne    804b0f <ipc_send+0x2c>
  804aff:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804b06:	00 00 00 
  804b09:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804b0d:	eb 0e                	jmp    804b1d <ipc_send+0x3a>
  804b0f:	eb 0c                	jmp    804b1d <ipc_send+0x3a>
  804b11:	48 b8 e7 19 80 00 00 	movabs $0x8019e7,%rax
  804b18:	00 00 00 
  804b1b:	ff d0                	callq  *%rax
  804b1d:	8b 75 e8             	mov    -0x18(%rbp),%esi
  804b20:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  804b23:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804b27:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804b2a:	89 c7                	mov    %eax,%edi
  804b2c:	48 b8 f9 1b 80 00 00 	movabs $0x801bf9,%rax
  804b33:	00 00 00 
  804b36:	ff d0                	callq  *%rax
  804b38:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804b3b:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804b3f:	74 d0                	je     804b11 <ipc_send+0x2e>
  804b41:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804b45:	79 30                	jns    804b77 <ipc_send+0x94>
  804b47:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804b4a:	89 c1                	mov    %eax,%ecx
  804b4c:	48 ba 90 55 80 00 00 	movabs $0x805590,%rdx
  804b53:	00 00 00 
  804b56:	be 44 00 00 00       	mov    $0x44,%esi
  804b5b:	48 bf a6 55 80 00 00 	movabs $0x8055a6,%rdi
  804b62:	00 00 00 
  804b65:	b8 00 00 00 00       	mov    $0x0,%eax
  804b6a:	49 b8 08 03 80 00 00 	movabs $0x800308,%r8
  804b71:	00 00 00 
  804b74:	41 ff d0             	callq  *%r8
  804b77:	c9                   	leaveq 
  804b78:	c3                   	retq   

0000000000804b79 <ipc_host_recv>:
  804b79:	55                   	push   %rbp
  804b7a:	48 89 e5             	mov    %rsp,%rbp
  804b7d:	48 83 ec 10          	sub    $0x10,%rsp
  804b81:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804b85:	48 ba b8 55 80 00 00 	movabs $0x8055b8,%rdx
  804b8c:	00 00 00 
  804b8f:	be 4e 00 00 00       	mov    $0x4e,%esi
  804b94:	48 bf a6 55 80 00 00 	movabs $0x8055a6,%rdi
  804b9b:	00 00 00 
  804b9e:	b8 00 00 00 00       	mov    $0x0,%eax
  804ba3:	48 b9 08 03 80 00 00 	movabs $0x800308,%rcx
  804baa:	00 00 00 
  804bad:	ff d1                	callq  *%rcx

0000000000804baf <ipc_host_send>:
  804baf:	55                   	push   %rbp
  804bb0:	48 89 e5             	mov    %rsp,%rbp
  804bb3:	48 83 ec 20          	sub    $0x20,%rsp
  804bb7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804bba:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804bbd:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804bc1:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804bc4:	48 ba d8 55 80 00 00 	movabs $0x8055d8,%rdx
  804bcb:	00 00 00 
  804bce:	be 67 00 00 00       	mov    $0x67,%esi
  804bd3:	48 bf a6 55 80 00 00 	movabs $0x8055a6,%rdi
  804bda:	00 00 00 
  804bdd:	b8 00 00 00 00       	mov    $0x0,%eax
  804be2:	48 b9 08 03 80 00 00 	movabs $0x800308,%rcx
  804be9:	00 00 00 
  804bec:	ff d1                	callq  *%rcx

0000000000804bee <ipc_find_env>:
  804bee:	55                   	push   %rbp
  804bef:	48 89 e5             	mov    %rsp,%rbp
  804bf2:	48 83 ec 14          	sub    $0x14,%rsp
  804bf6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804bf9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804c00:	eb 4e                	jmp    804c50 <ipc_find_env+0x62>
  804c02:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804c09:	00 00 00 
  804c0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804c0f:	48 98                	cltq   
  804c11:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804c18:	48 01 d0             	add    %rdx,%rax
  804c1b:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804c21:	8b 00                	mov    (%rax),%eax
  804c23:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804c26:	75 24                	jne    804c4c <ipc_find_env+0x5e>
  804c28:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804c2f:	00 00 00 
  804c32:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804c35:	48 98                	cltq   
  804c37:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804c3e:	48 01 d0             	add    %rdx,%rax
  804c41:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804c47:	8b 40 08             	mov    0x8(%rax),%eax
  804c4a:	eb 12                	jmp    804c5e <ipc_find_env+0x70>
  804c4c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804c50:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804c57:	7e a9                	jle    804c02 <ipc_find_env+0x14>
  804c59:	b8 00 00 00 00       	mov    $0x0,%eax
  804c5e:	c9                   	leaveq 
  804c5f:	c3                   	retq   

0000000000804c60 <pageref>:
  804c60:	55                   	push   %rbp
  804c61:	48 89 e5             	mov    %rsp,%rbp
  804c64:	48 83 ec 18          	sub    $0x18,%rsp
  804c68:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804c6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804c70:	48 c1 e8 15          	shr    $0x15,%rax
  804c74:	48 89 c2             	mov    %rax,%rdx
  804c77:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804c7e:	01 00 00 
  804c81:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804c85:	83 e0 01             	and    $0x1,%eax
  804c88:	48 85 c0             	test   %rax,%rax
  804c8b:	75 07                	jne    804c94 <pageref+0x34>
  804c8d:	b8 00 00 00 00       	mov    $0x0,%eax
  804c92:	eb 53                	jmp    804ce7 <pageref+0x87>
  804c94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804c98:	48 c1 e8 0c          	shr    $0xc,%rax
  804c9c:	48 89 c2             	mov    %rax,%rdx
  804c9f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804ca6:	01 00 00 
  804ca9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804cad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804cb5:	83 e0 01             	and    $0x1,%eax
  804cb8:	48 85 c0             	test   %rax,%rax
  804cbb:	75 07                	jne    804cc4 <pageref+0x64>
  804cbd:	b8 00 00 00 00       	mov    $0x0,%eax
  804cc2:	eb 23                	jmp    804ce7 <pageref+0x87>
  804cc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804cc8:	48 c1 e8 0c          	shr    $0xc,%rax
  804ccc:	48 89 c2             	mov    %rax,%rdx
  804ccf:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804cd6:	00 00 00 
  804cd9:	48 c1 e2 04          	shl    $0x4,%rdx
  804cdd:	48 01 d0             	add    %rdx,%rax
  804ce0:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804ce4:	0f b7 c0             	movzwl %ax,%eax
  804ce7:	c9                   	leaveq 
  804ce8:	c3                   	retq   
