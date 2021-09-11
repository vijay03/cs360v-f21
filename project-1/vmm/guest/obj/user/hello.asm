
vmm/guest/obj/user/hello:     file format elf64-x86-64


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
  80003c:	e8 5e 00 00 00       	callq  80009f <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 10          	sub    $0x10,%rsp
  80004b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80004e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800052:	48 bf c0 3f 80 00 00 	movabs $0x803fc0,%rdi
  800059:	00 00 00 
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  800068:	00 00 00 
  80006b:	ff d2                	callq  *%rdx
  80006d:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800074:	00 00 00 
  800077:	48 8b 00             	mov    (%rax),%rax
  80007a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800080:	89 c6                	mov    %eax,%esi
  800082:	48 bf ce 3f 80 00 00 	movabs $0x803fce,%rdi
  800089:	00 00 00 
  80008c:	b8 00 00 00 00       	mov    $0x0,%eax
  800091:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  800098:	00 00 00 
  80009b:	ff d2                	callq  *%rdx
  80009d:	c9                   	leaveq 
  80009e:	c3                   	retq   

000000000080009f <libmain>:
  80009f:	55                   	push   %rbp
  8000a0:	48 89 e5             	mov    %rsp,%rbp
  8000a3:	48 83 ec 10          	sub    $0x10,%rsp
  8000a7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8000aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8000ae:	48 b8 d2 16 80 00 00 	movabs $0x8016d2,%rax
  8000b5:	00 00 00 
  8000b8:	ff d0                	callq  *%rax
  8000ba:	25 ff 03 00 00       	and    $0x3ff,%eax
  8000bf:	48 98                	cltq   
  8000c1:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8000c8:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8000cf:	00 00 00 
  8000d2:	48 01 c2             	add    %rax,%rdx
  8000d5:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8000dc:	00 00 00 
  8000df:	48 89 10             	mov    %rdx,(%rax)
  8000e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000e6:	7e 14                	jle    8000fc <libmain+0x5d>
  8000e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8000ec:	48 8b 10             	mov    (%rax),%rdx
  8000ef:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8000f6:	00 00 00 
  8000f9:	48 89 10             	mov    %rdx,(%rax)
  8000fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800100:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800103:	48 89 d6             	mov    %rdx,%rsi
  800106:	89 c7                	mov    %eax,%edi
  800108:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  80010f:	00 00 00 
  800112:	ff d0                	callq  *%rax
  800114:	48 b8 22 01 80 00 00 	movabs $0x800122,%rax
  80011b:	00 00 00 
  80011e:	ff d0                	callq  *%rax
  800120:	c9                   	leaveq 
  800121:	c3                   	retq   

0000000000800122 <exit>:
  800122:	55                   	push   %rbp
  800123:	48 89 e5             	mov    %rsp,%rbp
  800126:	48 b8 6f 1e 80 00 00 	movabs $0x801e6f,%rax
  80012d:	00 00 00 
  800130:	ff d0                	callq  *%rax
  800132:	bf 00 00 00 00       	mov    $0x0,%edi
  800137:	48 b8 8e 16 80 00 00 	movabs $0x80168e,%rax
  80013e:	00 00 00 
  800141:	ff d0                	callq  *%rax
  800143:	5d                   	pop    %rbp
  800144:	c3                   	retq   

0000000000800145 <putch>:
  800145:	55                   	push   %rbp
  800146:	48 89 e5             	mov    %rsp,%rbp
  800149:	48 83 ec 10          	sub    $0x10,%rsp
  80014d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800150:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800154:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800158:	8b 00                	mov    (%rax),%eax
  80015a:	8d 48 01             	lea    0x1(%rax),%ecx
  80015d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800161:	89 0a                	mov    %ecx,(%rdx)
  800163:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800166:	89 d1                	mov    %edx,%ecx
  800168:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80016c:	48 98                	cltq   
  80016e:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800172:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800176:	8b 00                	mov    (%rax),%eax
  800178:	3d ff 00 00 00       	cmp    $0xff,%eax
  80017d:	75 2c                	jne    8001ab <putch+0x66>
  80017f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800183:	8b 00                	mov    (%rax),%eax
  800185:	48 98                	cltq   
  800187:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80018b:	48 83 c2 08          	add    $0x8,%rdx
  80018f:	48 89 c6             	mov    %rax,%rsi
  800192:	48 89 d7             	mov    %rdx,%rdi
  800195:	48 b8 06 16 80 00 00 	movabs $0x801606,%rax
  80019c:	00 00 00 
  80019f:	ff d0                	callq  *%rax
  8001a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8001a5:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8001ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8001af:	8b 40 04             	mov    0x4(%rax),%eax
  8001b2:	8d 50 01             	lea    0x1(%rax),%edx
  8001b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8001b9:	89 50 04             	mov    %edx,0x4(%rax)
  8001bc:	c9                   	leaveq 
  8001bd:	c3                   	retq   

00000000008001be <vcprintf>:
  8001be:	55                   	push   %rbp
  8001bf:	48 89 e5             	mov    %rsp,%rbp
  8001c2:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8001c9:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8001d0:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8001d7:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8001de:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8001e5:	48 8b 0a             	mov    (%rdx),%rcx
  8001e8:	48 89 08             	mov    %rcx,(%rax)
  8001eb:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8001ef:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8001f3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8001f7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8001fb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800202:	00 00 00 
  800205:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80020c:	00 00 00 
  80020f:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800216:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  80021d:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800224:	48 89 c6             	mov    %rax,%rsi
  800227:	48 bf 45 01 80 00 00 	movabs $0x800145,%rdi
  80022e:	00 00 00 
  800231:	48 b8 1d 06 80 00 00 	movabs $0x80061d,%rax
  800238:	00 00 00 
  80023b:	ff d0                	callq  *%rax
  80023d:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800243:	48 98                	cltq   
  800245:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80024c:	48 83 c2 08          	add    $0x8,%rdx
  800250:	48 89 c6             	mov    %rax,%rsi
  800253:	48 89 d7             	mov    %rdx,%rdi
  800256:	48 b8 06 16 80 00 00 	movabs $0x801606,%rax
  80025d:	00 00 00 
  800260:	ff d0                	callq  *%rax
  800262:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800268:	c9                   	leaveq 
  800269:	c3                   	retq   

000000000080026a <cprintf>:
  80026a:	55                   	push   %rbp
  80026b:	48 89 e5             	mov    %rsp,%rbp
  80026e:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800275:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80027c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800283:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80028a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800291:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800298:	84 c0                	test   %al,%al
  80029a:	74 20                	je     8002bc <cprintf+0x52>
  80029c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8002a0:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8002a4:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8002a8:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8002ac:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8002b0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8002b4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8002b8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8002bc:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8002c3:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8002ca:	00 00 00 
  8002cd:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8002d4:	00 00 00 
  8002d7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8002db:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8002e2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8002e9:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8002f0:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8002f7:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8002fe:	48 8b 0a             	mov    (%rdx),%rcx
  800301:	48 89 08             	mov    %rcx,(%rax)
  800304:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800308:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80030c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800310:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800314:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80031b:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800322:	48 89 d6             	mov    %rdx,%rsi
  800325:	48 89 c7             	mov    %rax,%rdi
  800328:	48 b8 be 01 80 00 00 	movabs $0x8001be,%rax
  80032f:	00 00 00 
  800332:	ff d0                	callq  *%rax
  800334:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80033a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800340:	c9                   	leaveq 
  800341:	c3                   	retq   

0000000000800342 <printnum>:
  800342:	55                   	push   %rbp
  800343:	48 89 e5             	mov    %rsp,%rbp
  800346:	53                   	push   %rbx
  800347:	48 83 ec 38          	sub    $0x38,%rsp
  80034b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80034f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800353:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800357:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80035a:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80035e:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800362:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800365:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800369:	77 3b                	ja     8003a6 <printnum+0x64>
  80036b:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80036e:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800372:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800375:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800379:	ba 00 00 00 00       	mov    $0x0,%edx
  80037e:	48 f7 f3             	div    %rbx
  800381:	48 89 c2             	mov    %rax,%rdx
  800384:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800387:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80038a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80038e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800392:	41 89 f9             	mov    %edi,%r9d
  800395:	48 89 c7             	mov    %rax,%rdi
  800398:	48 b8 42 03 80 00 00 	movabs $0x800342,%rax
  80039f:	00 00 00 
  8003a2:	ff d0                	callq  *%rax
  8003a4:	eb 1e                	jmp    8003c4 <printnum+0x82>
  8003a6:	eb 12                	jmp    8003ba <printnum+0x78>
  8003a8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8003ac:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8003af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8003b3:	48 89 ce             	mov    %rcx,%rsi
  8003b6:	89 d7                	mov    %edx,%edi
  8003b8:	ff d0                	callq  *%rax
  8003ba:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8003be:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8003c2:	7f e4                	jg     8003a8 <printnum+0x66>
  8003c4:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8003c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8003cb:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d0:	48 f7 f1             	div    %rcx
  8003d3:	48 89 d0             	mov    %rdx,%rax
  8003d6:	48 ba f0 41 80 00 00 	movabs $0x8041f0,%rdx
  8003dd:	00 00 00 
  8003e0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8003e4:	0f be d0             	movsbl %al,%edx
  8003e7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8003eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8003ef:	48 89 ce             	mov    %rcx,%rsi
  8003f2:	89 d7                	mov    %edx,%edi
  8003f4:	ff d0                	callq  *%rax
  8003f6:	48 83 c4 38          	add    $0x38,%rsp
  8003fa:	5b                   	pop    %rbx
  8003fb:	5d                   	pop    %rbp
  8003fc:	c3                   	retq   

00000000008003fd <getuint>:
  8003fd:	55                   	push   %rbp
  8003fe:	48 89 e5             	mov    %rsp,%rbp
  800401:	48 83 ec 1c          	sub    $0x1c,%rsp
  800405:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800409:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80040c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800410:	7e 52                	jle    800464 <getuint+0x67>
  800412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800416:	8b 00                	mov    (%rax),%eax
  800418:	83 f8 30             	cmp    $0x30,%eax
  80041b:	73 24                	jae    800441 <getuint+0x44>
  80041d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800421:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800425:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800429:	8b 00                	mov    (%rax),%eax
  80042b:	89 c0                	mov    %eax,%eax
  80042d:	48 01 d0             	add    %rdx,%rax
  800430:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800434:	8b 12                	mov    (%rdx),%edx
  800436:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800439:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80043d:	89 0a                	mov    %ecx,(%rdx)
  80043f:	eb 17                	jmp    800458 <getuint+0x5b>
  800441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800445:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800449:	48 89 d0             	mov    %rdx,%rax
  80044c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800450:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800454:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800458:	48 8b 00             	mov    (%rax),%rax
  80045b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80045f:	e9 a3 00 00 00       	jmpq   800507 <getuint+0x10a>
  800464:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800468:	74 4f                	je     8004b9 <getuint+0xbc>
  80046a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80046e:	8b 00                	mov    (%rax),%eax
  800470:	83 f8 30             	cmp    $0x30,%eax
  800473:	73 24                	jae    800499 <getuint+0x9c>
  800475:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800479:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80047d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800481:	8b 00                	mov    (%rax),%eax
  800483:	89 c0                	mov    %eax,%eax
  800485:	48 01 d0             	add    %rdx,%rax
  800488:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80048c:	8b 12                	mov    (%rdx),%edx
  80048e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800491:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800495:	89 0a                	mov    %ecx,(%rdx)
  800497:	eb 17                	jmp    8004b0 <getuint+0xb3>
  800499:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80049d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8004a1:	48 89 d0             	mov    %rdx,%rax
  8004a4:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8004a8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8004ac:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8004b0:	48 8b 00             	mov    (%rax),%rax
  8004b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8004b7:	eb 4e                	jmp    800507 <getuint+0x10a>
  8004b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004bd:	8b 00                	mov    (%rax),%eax
  8004bf:	83 f8 30             	cmp    $0x30,%eax
  8004c2:	73 24                	jae    8004e8 <getuint+0xeb>
  8004c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004c8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8004cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004d0:	8b 00                	mov    (%rax),%eax
  8004d2:	89 c0                	mov    %eax,%eax
  8004d4:	48 01 d0             	add    %rdx,%rax
  8004d7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8004db:	8b 12                	mov    (%rdx),%edx
  8004dd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8004e0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8004e4:	89 0a                	mov    %ecx,(%rdx)
  8004e6:	eb 17                	jmp    8004ff <getuint+0x102>
  8004e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004ec:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8004f0:	48 89 d0             	mov    %rdx,%rax
  8004f3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8004f7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8004fb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8004ff:	8b 00                	mov    (%rax),%eax
  800501:	89 c0                	mov    %eax,%eax
  800503:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800507:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80050b:	c9                   	leaveq 
  80050c:	c3                   	retq   

000000000080050d <getint>:
  80050d:	55                   	push   %rbp
  80050e:	48 89 e5             	mov    %rsp,%rbp
  800511:	48 83 ec 1c          	sub    $0x1c,%rsp
  800515:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800519:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80051c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800520:	7e 52                	jle    800574 <getint+0x67>
  800522:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800526:	8b 00                	mov    (%rax),%eax
  800528:	83 f8 30             	cmp    $0x30,%eax
  80052b:	73 24                	jae    800551 <getint+0x44>
  80052d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800531:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800535:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800539:	8b 00                	mov    (%rax),%eax
  80053b:	89 c0                	mov    %eax,%eax
  80053d:	48 01 d0             	add    %rdx,%rax
  800540:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800544:	8b 12                	mov    (%rdx),%edx
  800546:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800549:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80054d:	89 0a                	mov    %ecx,(%rdx)
  80054f:	eb 17                	jmp    800568 <getint+0x5b>
  800551:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800555:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800559:	48 89 d0             	mov    %rdx,%rax
  80055c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800560:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800564:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800568:	48 8b 00             	mov    (%rax),%rax
  80056b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80056f:	e9 a3 00 00 00       	jmpq   800617 <getint+0x10a>
  800574:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800578:	74 4f                	je     8005c9 <getint+0xbc>
  80057a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80057e:	8b 00                	mov    (%rax),%eax
  800580:	83 f8 30             	cmp    $0x30,%eax
  800583:	73 24                	jae    8005a9 <getint+0x9c>
  800585:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800589:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80058d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800591:	8b 00                	mov    (%rax),%eax
  800593:	89 c0                	mov    %eax,%eax
  800595:	48 01 d0             	add    %rdx,%rax
  800598:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80059c:	8b 12                	mov    (%rdx),%edx
  80059e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005a1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005a5:	89 0a                	mov    %ecx,(%rdx)
  8005a7:	eb 17                	jmp    8005c0 <getint+0xb3>
  8005a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ad:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005b1:	48 89 d0             	mov    %rdx,%rax
  8005b4:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8005b8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8005c0:	48 8b 00             	mov    (%rax),%rax
  8005c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005c7:	eb 4e                	jmp    800617 <getint+0x10a>
  8005c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005cd:	8b 00                	mov    (%rax),%eax
  8005cf:	83 f8 30             	cmp    $0x30,%eax
  8005d2:	73 24                	jae    8005f8 <getint+0xeb>
  8005d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005d8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8005dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005e0:	8b 00                	mov    (%rax),%eax
  8005e2:	89 c0                	mov    %eax,%eax
  8005e4:	48 01 d0             	add    %rdx,%rax
  8005e7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005eb:	8b 12                	mov    (%rdx),%edx
  8005ed:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005f0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005f4:	89 0a                	mov    %ecx,(%rdx)
  8005f6:	eb 17                	jmp    80060f <getint+0x102>
  8005f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005fc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800600:	48 89 d0             	mov    %rdx,%rax
  800603:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800607:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80060b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80060f:	8b 00                	mov    (%rax),%eax
  800611:	48 98                	cltq   
  800613:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80061b:	c9                   	leaveq 
  80061c:	c3                   	retq   

000000000080061d <vprintfmt>:
  80061d:	55                   	push   %rbp
  80061e:	48 89 e5             	mov    %rsp,%rbp
  800621:	41 54                	push   %r12
  800623:	53                   	push   %rbx
  800624:	48 83 ec 60          	sub    $0x60,%rsp
  800628:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  80062c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800630:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800634:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800638:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80063c:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800640:	48 8b 0a             	mov    (%rdx),%rcx
  800643:	48 89 08             	mov    %rcx,(%rax)
  800646:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80064a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80064e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800652:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800656:	eb 17                	jmp    80066f <vprintfmt+0x52>
  800658:	85 db                	test   %ebx,%ebx
  80065a:	0f 84 cc 04 00 00    	je     800b2c <vprintfmt+0x50f>
  800660:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800664:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800668:	48 89 d6             	mov    %rdx,%rsi
  80066b:	89 df                	mov    %ebx,%edi
  80066d:	ff d0                	callq  *%rax
  80066f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800673:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800677:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80067b:	0f b6 00             	movzbl (%rax),%eax
  80067e:	0f b6 d8             	movzbl %al,%ebx
  800681:	83 fb 25             	cmp    $0x25,%ebx
  800684:	75 d2                	jne    800658 <vprintfmt+0x3b>
  800686:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  80068a:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800691:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800698:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80069f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  8006a6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8006aa:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8006ae:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8006b2:	0f b6 00             	movzbl (%rax),%eax
  8006b5:	0f b6 d8             	movzbl %al,%ebx
  8006b8:	8d 43 dd             	lea    -0x23(%rbx),%eax
  8006bb:	83 f8 55             	cmp    $0x55,%eax
  8006be:	0f 87 34 04 00 00    	ja     800af8 <vprintfmt+0x4db>
  8006c4:	89 c0                	mov    %eax,%eax
  8006c6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8006cd:	00 
  8006ce:	48 b8 18 42 80 00 00 	movabs $0x804218,%rax
  8006d5:	00 00 00 
  8006d8:	48 01 d0             	add    %rdx,%rax
  8006db:	48 8b 00             	mov    (%rax),%rax
  8006de:	ff e0                	jmpq   *%rax
  8006e0:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8006e4:	eb c0                	jmp    8006a6 <vprintfmt+0x89>
  8006e6:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8006ea:	eb ba                	jmp    8006a6 <vprintfmt+0x89>
  8006ec:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8006f3:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8006f6:	89 d0                	mov    %edx,%eax
  8006f8:	c1 e0 02             	shl    $0x2,%eax
  8006fb:	01 d0                	add    %edx,%eax
  8006fd:	01 c0                	add    %eax,%eax
  8006ff:	01 d8                	add    %ebx,%eax
  800701:	83 e8 30             	sub    $0x30,%eax
  800704:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800707:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80070b:	0f b6 00             	movzbl (%rax),%eax
  80070e:	0f be d8             	movsbl %al,%ebx
  800711:	83 fb 2f             	cmp    $0x2f,%ebx
  800714:	7e 0c                	jle    800722 <vprintfmt+0x105>
  800716:	83 fb 39             	cmp    $0x39,%ebx
  800719:	7f 07                	jg     800722 <vprintfmt+0x105>
  80071b:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800720:	eb d1                	jmp    8006f3 <vprintfmt+0xd6>
  800722:	eb 58                	jmp    80077c <vprintfmt+0x15f>
  800724:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800727:	83 f8 30             	cmp    $0x30,%eax
  80072a:	73 17                	jae    800743 <vprintfmt+0x126>
  80072c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800730:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800733:	89 c0                	mov    %eax,%eax
  800735:	48 01 d0             	add    %rdx,%rax
  800738:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80073b:	83 c2 08             	add    $0x8,%edx
  80073e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800741:	eb 0f                	jmp    800752 <vprintfmt+0x135>
  800743:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800747:	48 89 d0             	mov    %rdx,%rax
  80074a:	48 83 c2 08          	add    $0x8,%rdx
  80074e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800752:	8b 00                	mov    (%rax),%eax
  800754:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800757:	eb 23                	jmp    80077c <vprintfmt+0x15f>
  800759:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80075d:	79 0c                	jns    80076b <vprintfmt+0x14e>
  80075f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800766:	e9 3b ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  80076b:	e9 36 ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  800770:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800777:	e9 2a ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  80077c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800780:	79 12                	jns    800794 <vprintfmt+0x177>
  800782:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800785:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800788:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80078f:	e9 12 ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  800794:	e9 0d ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  800799:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  80079d:	e9 04 ff ff ff       	jmpq   8006a6 <vprintfmt+0x89>
  8007a2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007a5:	83 f8 30             	cmp    $0x30,%eax
  8007a8:	73 17                	jae    8007c1 <vprintfmt+0x1a4>
  8007aa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8007ae:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007b1:	89 c0                	mov    %eax,%eax
  8007b3:	48 01 d0             	add    %rdx,%rax
  8007b6:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8007b9:	83 c2 08             	add    $0x8,%edx
  8007bc:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8007bf:	eb 0f                	jmp    8007d0 <vprintfmt+0x1b3>
  8007c1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8007c5:	48 89 d0             	mov    %rdx,%rax
  8007c8:	48 83 c2 08          	add    $0x8,%rdx
  8007cc:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8007d0:	8b 10                	mov    (%rax),%edx
  8007d2:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8007d6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8007da:	48 89 ce             	mov    %rcx,%rsi
  8007dd:	89 d7                	mov    %edx,%edi
  8007df:	ff d0                	callq  *%rax
  8007e1:	e9 40 03 00 00       	jmpq   800b26 <vprintfmt+0x509>
  8007e6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007e9:	83 f8 30             	cmp    $0x30,%eax
  8007ec:	73 17                	jae    800805 <vprintfmt+0x1e8>
  8007ee:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8007f2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007f5:	89 c0                	mov    %eax,%eax
  8007f7:	48 01 d0             	add    %rdx,%rax
  8007fa:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8007fd:	83 c2 08             	add    $0x8,%edx
  800800:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800803:	eb 0f                	jmp    800814 <vprintfmt+0x1f7>
  800805:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800809:	48 89 d0             	mov    %rdx,%rax
  80080c:	48 83 c2 08          	add    $0x8,%rdx
  800810:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800814:	8b 18                	mov    (%rax),%ebx
  800816:	85 db                	test   %ebx,%ebx
  800818:	79 02                	jns    80081c <vprintfmt+0x1ff>
  80081a:	f7 db                	neg    %ebx
  80081c:	83 fb 15             	cmp    $0x15,%ebx
  80081f:	7f 16                	jg     800837 <vprintfmt+0x21a>
  800821:	48 b8 40 41 80 00 00 	movabs $0x804140,%rax
  800828:	00 00 00 
  80082b:	48 63 d3             	movslq %ebx,%rdx
  80082e:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800832:	4d 85 e4             	test   %r12,%r12
  800835:	75 2e                	jne    800865 <vprintfmt+0x248>
  800837:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80083b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80083f:	89 d9                	mov    %ebx,%ecx
  800841:	48 ba 01 42 80 00 00 	movabs $0x804201,%rdx
  800848:	00 00 00 
  80084b:	48 89 c7             	mov    %rax,%rdi
  80084e:	b8 00 00 00 00       	mov    $0x0,%eax
  800853:	49 b8 35 0b 80 00 00 	movabs $0x800b35,%r8
  80085a:	00 00 00 
  80085d:	41 ff d0             	callq  *%r8
  800860:	e9 c1 02 00 00       	jmpq   800b26 <vprintfmt+0x509>
  800865:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800869:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80086d:	4c 89 e1             	mov    %r12,%rcx
  800870:	48 ba 0a 42 80 00 00 	movabs $0x80420a,%rdx
  800877:	00 00 00 
  80087a:	48 89 c7             	mov    %rax,%rdi
  80087d:	b8 00 00 00 00       	mov    $0x0,%eax
  800882:	49 b8 35 0b 80 00 00 	movabs $0x800b35,%r8
  800889:	00 00 00 
  80088c:	41 ff d0             	callq  *%r8
  80088f:	e9 92 02 00 00       	jmpq   800b26 <vprintfmt+0x509>
  800894:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800897:	83 f8 30             	cmp    $0x30,%eax
  80089a:	73 17                	jae    8008b3 <vprintfmt+0x296>
  80089c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8008a0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008a3:	89 c0                	mov    %eax,%eax
  8008a5:	48 01 d0             	add    %rdx,%rax
  8008a8:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8008ab:	83 c2 08             	add    $0x8,%edx
  8008ae:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8008b1:	eb 0f                	jmp    8008c2 <vprintfmt+0x2a5>
  8008b3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8008b7:	48 89 d0             	mov    %rdx,%rax
  8008ba:	48 83 c2 08          	add    $0x8,%rdx
  8008be:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8008c2:	4c 8b 20             	mov    (%rax),%r12
  8008c5:	4d 85 e4             	test   %r12,%r12
  8008c8:	75 0a                	jne    8008d4 <vprintfmt+0x2b7>
  8008ca:	49 bc 0d 42 80 00 00 	movabs $0x80420d,%r12
  8008d1:	00 00 00 
  8008d4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8008d8:	7e 3f                	jle    800919 <vprintfmt+0x2fc>
  8008da:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  8008de:	74 39                	je     800919 <vprintfmt+0x2fc>
  8008e0:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8008e3:	48 98                	cltq   
  8008e5:	48 89 c6             	mov    %rax,%rsi
  8008e8:	4c 89 e7             	mov    %r12,%rdi
  8008eb:	48 b8 e1 0d 80 00 00 	movabs $0x800de1,%rax
  8008f2:	00 00 00 
  8008f5:	ff d0                	callq  *%rax
  8008f7:	29 45 dc             	sub    %eax,-0x24(%rbp)
  8008fa:	eb 17                	jmp    800913 <vprintfmt+0x2f6>
  8008fc:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800900:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800904:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800908:	48 89 ce             	mov    %rcx,%rsi
  80090b:	89 d7                	mov    %edx,%edi
  80090d:	ff d0                	callq  *%rax
  80090f:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800913:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800917:	7f e3                	jg     8008fc <vprintfmt+0x2df>
  800919:	eb 37                	jmp    800952 <vprintfmt+0x335>
  80091b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  80091f:	74 1e                	je     80093f <vprintfmt+0x322>
  800921:	83 fb 1f             	cmp    $0x1f,%ebx
  800924:	7e 05                	jle    80092b <vprintfmt+0x30e>
  800926:	83 fb 7e             	cmp    $0x7e,%ebx
  800929:	7e 14                	jle    80093f <vprintfmt+0x322>
  80092b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80092f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800933:	48 89 d6             	mov    %rdx,%rsi
  800936:	bf 3f 00 00 00       	mov    $0x3f,%edi
  80093b:	ff d0                	callq  *%rax
  80093d:	eb 0f                	jmp    80094e <vprintfmt+0x331>
  80093f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800943:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800947:	48 89 d6             	mov    %rdx,%rsi
  80094a:	89 df                	mov    %ebx,%edi
  80094c:	ff d0                	callq  *%rax
  80094e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800952:	4c 89 e0             	mov    %r12,%rax
  800955:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800959:	0f b6 00             	movzbl (%rax),%eax
  80095c:	0f be d8             	movsbl %al,%ebx
  80095f:	85 db                	test   %ebx,%ebx
  800961:	74 10                	je     800973 <vprintfmt+0x356>
  800963:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800967:	78 b2                	js     80091b <vprintfmt+0x2fe>
  800969:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  80096d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800971:	79 a8                	jns    80091b <vprintfmt+0x2fe>
  800973:	eb 16                	jmp    80098b <vprintfmt+0x36e>
  800975:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800979:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80097d:	48 89 d6             	mov    %rdx,%rsi
  800980:	bf 20 00 00 00       	mov    $0x20,%edi
  800985:	ff d0                	callq  *%rax
  800987:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  80098b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80098f:	7f e4                	jg     800975 <vprintfmt+0x358>
  800991:	e9 90 01 00 00       	jmpq   800b26 <vprintfmt+0x509>
  800996:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80099a:	be 03 00 00 00       	mov    $0x3,%esi
  80099f:	48 89 c7             	mov    %rax,%rdi
  8009a2:	48 b8 0d 05 80 00 00 	movabs $0x80050d,%rax
  8009a9:	00 00 00 
  8009ac:	ff d0                	callq  *%rax
  8009ae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8009b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b6:	48 85 c0             	test   %rax,%rax
  8009b9:	79 1d                	jns    8009d8 <vprintfmt+0x3bb>
  8009bb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8009bf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009c3:	48 89 d6             	mov    %rdx,%rsi
  8009c6:	bf 2d 00 00 00       	mov    $0x2d,%edi
  8009cb:	ff d0                	callq  *%rax
  8009cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009d1:	48 f7 d8             	neg    %rax
  8009d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8009d8:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8009df:	e9 d5 00 00 00       	jmpq   800ab9 <vprintfmt+0x49c>
  8009e4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8009e8:	be 03 00 00 00       	mov    $0x3,%esi
  8009ed:	48 89 c7             	mov    %rax,%rdi
  8009f0:	48 b8 fd 03 80 00 00 	movabs $0x8003fd,%rax
  8009f7:	00 00 00 
  8009fa:	ff d0                	callq  *%rax
  8009fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a00:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800a07:	e9 ad 00 00 00       	jmpq   800ab9 <vprintfmt+0x49c>
  800a0c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800a10:	be 03 00 00 00       	mov    $0x3,%esi
  800a15:	48 89 c7             	mov    %rax,%rdi
  800a18:	48 b8 fd 03 80 00 00 	movabs $0x8003fd,%rax
  800a1f:	00 00 00 
  800a22:	ff d0                	callq  *%rax
  800a24:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a28:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800a2f:	e9 85 00 00 00       	jmpq   800ab9 <vprintfmt+0x49c>
  800a34:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a38:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a3c:	48 89 d6             	mov    %rdx,%rsi
  800a3f:	bf 30 00 00 00       	mov    $0x30,%edi
  800a44:	ff d0                	callq  *%rax
  800a46:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a4a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a4e:	48 89 d6             	mov    %rdx,%rsi
  800a51:	bf 78 00 00 00       	mov    $0x78,%edi
  800a56:	ff d0                	callq  *%rax
  800a58:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a5b:	83 f8 30             	cmp    $0x30,%eax
  800a5e:	73 17                	jae    800a77 <vprintfmt+0x45a>
  800a60:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a64:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a67:	89 c0                	mov    %eax,%eax
  800a69:	48 01 d0             	add    %rdx,%rax
  800a6c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a6f:	83 c2 08             	add    $0x8,%edx
  800a72:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a75:	eb 0f                	jmp    800a86 <vprintfmt+0x469>
  800a77:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a7b:	48 89 d0             	mov    %rdx,%rax
  800a7e:	48 83 c2 08          	add    $0x8,%rdx
  800a82:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a86:	48 8b 00             	mov    (%rax),%rax
  800a89:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a8d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800a94:	eb 23                	jmp    800ab9 <vprintfmt+0x49c>
  800a96:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800a9a:	be 03 00 00 00       	mov    $0x3,%esi
  800a9f:	48 89 c7             	mov    %rax,%rdi
  800aa2:	48 b8 fd 03 80 00 00 	movabs $0x8003fd,%rax
  800aa9:	00 00 00 
  800aac:	ff d0                	callq  *%rax
  800aae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ab2:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800ab9:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800abe:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800ac1:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800ac4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ac8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800acc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ad0:	45 89 c1             	mov    %r8d,%r9d
  800ad3:	41 89 f8             	mov    %edi,%r8d
  800ad6:	48 89 c7             	mov    %rax,%rdi
  800ad9:	48 b8 42 03 80 00 00 	movabs $0x800342,%rax
  800ae0:	00 00 00 
  800ae3:	ff d0                	callq  *%rax
  800ae5:	eb 3f                	jmp    800b26 <vprintfmt+0x509>
  800ae7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800aeb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800aef:	48 89 d6             	mov    %rdx,%rsi
  800af2:	89 df                	mov    %ebx,%edi
  800af4:	ff d0                	callq  *%rax
  800af6:	eb 2e                	jmp    800b26 <vprintfmt+0x509>
  800af8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800afc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b00:	48 89 d6             	mov    %rdx,%rsi
  800b03:	bf 25 00 00 00       	mov    $0x25,%edi
  800b08:	ff d0                	callq  *%rax
  800b0a:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800b0f:	eb 05                	jmp    800b16 <vprintfmt+0x4f9>
  800b11:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800b16:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b1a:	48 83 e8 01          	sub    $0x1,%rax
  800b1e:	0f b6 00             	movzbl (%rax),%eax
  800b21:	3c 25                	cmp    $0x25,%al
  800b23:	75 ec                	jne    800b11 <vprintfmt+0x4f4>
  800b25:	90                   	nop
  800b26:	90                   	nop
  800b27:	e9 43 fb ff ff       	jmpq   80066f <vprintfmt+0x52>
  800b2c:	48 83 c4 60          	add    $0x60,%rsp
  800b30:	5b                   	pop    %rbx
  800b31:	41 5c                	pop    %r12
  800b33:	5d                   	pop    %rbp
  800b34:	c3                   	retq   

0000000000800b35 <printfmt>:
  800b35:	55                   	push   %rbp
  800b36:	48 89 e5             	mov    %rsp,%rbp
  800b39:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800b40:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800b47:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800b4e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800b55:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800b5c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800b63:	84 c0                	test   %al,%al
  800b65:	74 20                	je     800b87 <printfmt+0x52>
  800b67:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800b6b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800b6f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800b73:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800b77:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800b7b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800b7f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800b83:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800b87:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800b8e:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800b95:	00 00 00 
  800b98:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800b9f:	00 00 00 
  800ba2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800ba6:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800bad:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800bb4:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800bbb:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800bc2:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800bc9:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800bd0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800bd7:	48 89 c7             	mov    %rax,%rdi
  800bda:	48 b8 1d 06 80 00 00 	movabs $0x80061d,%rax
  800be1:	00 00 00 
  800be4:	ff d0                	callq  *%rax
  800be6:	c9                   	leaveq 
  800be7:	c3                   	retq   

0000000000800be8 <sprintputch>:
  800be8:	55                   	push   %rbp
  800be9:	48 89 e5             	mov    %rsp,%rbp
  800bec:	48 83 ec 10          	sub    $0x10,%rsp
  800bf0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800bf3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800bf7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800bfb:	8b 40 10             	mov    0x10(%rax),%eax
  800bfe:	8d 50 01             	lea    0x1(%rax),%edx
  800c01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c05:	89 50 10             	mov    %edx,0x10(%rax)
  800c08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c0c:	48 8b 10             	mov    (%rax),%rdx
  800c0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c13:	48 8b 40 08          	mov    0x8(%rax),%rax
  800c17:	48 39 c2             	cmp    %rax,%rdx
  800c1a:	73 17                	jae    800c33 <sprintputch+0x4b>
  800c1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c20:	48 8b 00             	mov    (%rax),%rax
  800c23:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800c27:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c2b:	48 89 0a             	mov    %rcx,(%rdx)
  800c2e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800c31:	88 10                	mov    %dl,(%rax)
  800c33:	c9                   	leaveq 
  800c34:	c3                   	retq   

0000000000800c35 <vsnprintf>:
  800c35:	55                   	push   %rbp
  800c36:	48 89 e5             	mov    %rsp,%rbp
  800c39:	48 83 ec 50          	sub    $0x50,%rsp
  800c3d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800c41:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800c44:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800c48:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800c4c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800c50:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800c54:	48 8b 0a             	mov    (%rdx),%rcx
  800c57:	48 89 08             	mov    %rcx,(%rax)
  800c5a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800c5e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800c62:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800c66:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800c6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800c6e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800c72:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800c75:	48 98                	cltq   
  800c77:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800c7b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800c7f:	48 01 d0             	add    %rdx,%rax
  800c82:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800c86:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800c8d:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800c92:	74 06                	je     800c9a <vsnprintf+0x65>
  800c94:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800c98:	7f 07                	jg     800ca1 <vsnprintf+0x6c>
  800c9a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800c9f:	eb 2f                	jmp    800cd0 <vsnprintf+0x9b>
  800ca1:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800ca5:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800ca9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800cad:	48 89 c6             	mov    %rax,%rsi
  800cb0:	48 bf e8 0b 80 00 00 	movabs $0x800be8,%rdi
  800cb7:	00 00 00 
  800cba:	48 b8 1d 06 80 00 00 	movabs $0x80061d,%rax
  800cc1:	00 00 00 
  800cc4:	ff d0                	callq  *%rax
  800cc6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800cca:	c6 00 00             	movb   $0x0,(%rax)
  800ccd:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800cd0:	c9                   	leaveq 
  800cd1:	c3                   	retq   

0000000000800cd2 <snprintf>:
  800cd2:	55                   	push   %rbp
  800cd3:	48 89 e5             	mov    %rsp,%rbp
  800cd6:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800cdd:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800ce4:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800cea:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800cf1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800cf8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800cff:	84 c0                	test   %al,%al
  800d01:	74 20                	je     800d23 <snprintf+0x51>
  800d03:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800d07:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800d0b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800d0f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800d13:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800d17:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800d1b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800d1f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800d23:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800d2a:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800d31:	00 00 00 
  800d34:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800d3b:	00 00 00 
  800d3e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800d42:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800d49:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800d50:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800d57:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800d5e:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800d65:	48 8b 0a             	mov    (%rdx),%rcx
  800d68:	48 89 08             	mov    %rcx,(%rax)
  800d6b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800d6f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800d73:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800d77:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800d7b:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800d82:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800d89:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800d8f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800d96:	48 89 c7             	mov    %rax,%rdi
  800d99:	48 b8 35 0c 80 00 00 	movabs $0x800c35,%rax
  800da0:	00 00 00 
  800da3:	ff d0                	callq  *%rax
  800da5:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800dab:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800db1:	c9                   	leaveq 
  800db2:	c3                   	retq   

0000000000800db3 <strlen>:
  800db3:	55                   	push   %rbp
  800db4:	48 89 e5             	mov    %rsp,%rbp
  800db7:	48 83 ec 18          	sub    $0x18,%rsp
  800dbb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800dbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800dc6:	eb 09                	jmp    800dd1 <strlen+0x1e>
  800dc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800dcc:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800dd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800dd5:	0f b6 00             	movzbl (%rax),%eax
  800dd8:	84 c0                	test   %al,%al
  800dda:	75 ec                	jne    800dc8 <strlen+0x15>
  800ddc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ddf:	c9                   	leaveq 
  800de0:	c3                   	retq   

0000000000800de1 <strnlen>:
  800de1:	55                   	push   %rbp
  800de2:	48 89 e5             	mov    %rsp,%rbp
  800de5:	48 83 ec 20          	sub    $0x20,%rsp
  800de9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800ded:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800df1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800df8:	eb 0e                	jmp    800e08 <strnlen+0x27>
  800dfa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800dfe:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800e03:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  800e08:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800e0d:	74 0b                	je     800e1a <strnlen+0x39>
  800e0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e13:	0f b6 00             	movzbl (%rax),%eax
  800e16:	84 c0                	test   %al,%al
  800e18:	75 e0                	jne    800dfa <strnlen+0x19>
  800e1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800e1d:	c9                   	leaveq 
  800e1e:	c3                   	retq   

0000000000800e1f <strcpy>:
  800e1f:	55                   	push   %rbp
  800e20:	48 89 e5             	mov    %rsp,%rbp
  800e23:	48 83 ec 20          	sub    $0x20,%rsp
  800e27:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800e2b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800e2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e33:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800e37:	90                   	nop
  800e38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e3c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800e40:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800e44:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800e48:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800e4c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800e50:	0f b6 12             	movzbl (%rdx),%edx
  800e53:	88 10                	mov    %dl,(%rax)
  800e55:	0f b6 00             	movzbl (%rax),%eax
  800e58:	84 c0                	test   %al,%al
  800e5a:	75 dc                	jne    800e38 <strcpy+0x19>
  800e5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800e60:	c9                   	leaveq 
  800e61:	c3                   	retq   

0000000000800e62 <strcat>:
  800e62:	55                   	push   %rbp
  800e63:	48 89 e5             	mov    %rsp,%rbp
  800e66:	48 83 ec 20          	sub    $0x20,%rsp
  800e6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800e6e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800e72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e76:	48 89 c7             	mov    %rax,%rdi
  800e79:	48 b8 b3 0d 80 00 00 	movabs $0x800db3,%rax
  800e80:	00 00 00 
  800e83:	ff d0                	callq  *%rax
  800e85:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800e88:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800e8b:	48 63 d0             	movslq %eax,%rdx
  800e8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e92:	48 01 c2             	add    %rax,%rdx
  800e95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800e99:	48 89 c6             	mov    %rax,%rsi
  800e9c:	48 89 d7             	mov    %rdx,%rdi
  800e9f:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  800ea6:	00 00 00 
  800ea9:	ff d0                	callq  *%rax
  800eab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800eaf:	c9                   	leaveq 
  800eb0:	c3                   	retq   

0000000000800eb1 <strncpy>:
  800eb1:	55                   	push   %rbp
  800eb2:	48 89 e5             	mov    %rsp,%rbp
  800eb5:	48 83 ec 28          	sub    $0x28,%rsp
  800eb9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800ebd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800ec1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800ec5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ec9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800ecd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  800ed4:	00 
  800ed5:	eb 2a                	jmp    800f01 <strncpy+0x50>
  800ed7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800edb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800edf:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800ee3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800ee7:	0f b6 12             	movzbl (%rdx),%edx
  800eea:	88 10                	mov    %dl,(%rax)
  800eec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800ef0:	0f b6 00             	movzbl (%rax),%eax
  800ef3:	84 c0                	test   %al,%al
  800ef5:	74 05                	je     800efc <strncpy+0x4b>
  800ef7:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  800efc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800f01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800f05:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800f09:	72 cc                	jb     800ed7 <strncpy+0x26>
  800f0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800f0f:	c9                   	leaveq 
  800f10:	c3                   	retq   

0000000000800f11 <strlcpy>:
  800f11:	55                   	push   %rbp
  800f12:	48 89 e5             	mov    %rsp,%rbp
  800f15:	48 83 ec 28          	sub    $0x28,%rsp
  800f19:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f1d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f21:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800f25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800f2d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800f32:	74 3d                	je     800f71 <strlcpy+0x60>
  800f34:	eb 1d                	jmp    800f53 <strlcpy+0x42>
  800f36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f3a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800f3e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800f42:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800f46:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800f4a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800f4e:	0f b6 12             	movzbl (%rdx),%edx
  800f51:	88 10                	mov    %dl,(%rax)
  800f53:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  800f58:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800f5d:	74 0b                	je     800f6a <strlcpy+0x59>
  800f5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800f63:	0f b6 00             	movzbl (%rax),%eax
  800f66:	84 c0                	test   %al,%al
  800f68:	75 cc                	jne    800f36 <strlcpy+0x25>
  800f6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f6e:	c6 00 00             	movb   $0x0,(%rax)
  800f71:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800f79:	48 29 c2             	sub    %rax,%rdx
  800f7c:	48 89 d0             	mov    %rdx,%rax
  800f7f:	c9                   	leaveq 
  800f80:	c3                   	retq   

0000000000800f81 <strcmp>:
  800f81:	55                   	push   %rbp
  800f82:	48 89 e5             	mov    %rsp,%rbp
  800f85:	48 83 ec 10          	sub    $0x10,%rsp
  800f89:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800f8d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800f91:	eb 0a                	jmp    800f9d <strcmp+0x1c>
  800f93:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800f98:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  800f9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fa1:	0f b6 00             	movzbl (%rax),%eax
  800fa4:	84 c0                	test   %al,%al
  800fa6:	74 12                	je     800fba <strcmp+0x39>
  800fa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fac:	0f b6 10             	movzbl (%rax),%edx
  800faf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fb3:	0f b6 00             	movzbl (%rax),%eax
  800fb6:	38 c2                	cmp    %al,%dl
  800fb8:	74 d9                	je     800f93 <strcmp+0x12>
  800fba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fbe:	0f b6 00             	movzbl (%rax),%eax
  800fc1:	0f b6 d0             	movzbl %al,%edx
  800fc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fc8:	0f b6 00             	movzbl (%rax),%eax
  800fcb:	0f b6 c0             	movzbl %al,%eax
  800fce:	29 c2                	sub    %eax,%edx
  800fd0:	89 d0                	mov    %edx,%eax
  800fd2:	c9                   	leaveq 
  800fd3:	c3                   	retq   

0000000000800fd4 <strncmp>:
  800fd4:	55                   	push   %rbp
  800fd5:	48 89 e5             	mov    %rsp,%rbp
  800fd8:	48 83 ec 18          	sub    $0x18,%rsp
  800fdc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800fe0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800fe4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800fe8:	eb 0f                	jmp    800ff9 <strncmp+0x25>
  800fea:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  800fef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800ff4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  800ff9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800ffe:	74 1d                	je     80101d <strncmp+0x49>
  801000:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801004:	0f b6 00             	movzbl (%rax),%eax
  801007:	84 c0                	test   %al,%al
  801009:	74 12                	je     80101d <strncmp+0x49>
  80100b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80100f:	0f b6 10             	movzbl (%rax),%edx
  801012:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801016:	0f b6 00             	movzbl (%rax),%eax
  801019:	38 c2                	cmp    %al,%dl
  80101b:	74 cd                	je     800fea <strncmp+0x16>
  80101d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801022:	75 07                	jne    80102b <strncmp+0x57>
  801024:	b8 00 00 00 00       	mov    $0x0,%eax
  801029:	eb 18                	jmp    801043 <strncmp+0x6f>
  80102b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80102f:	0f b6 00             	movzbl (%rax),%eax
  801032:	0f b6 d0             	movzbl %al,%edx
  801035:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801039:	0f b6 00             	movzbl (%rax),%eax
  80103c:	0f b6 c0             	movzbl %al,%eax
  80103f:	29 c2                	sub    %eax,%edx
  801041:	89 d0                	mov    %edx,%eax
  801043:	c9                   	leaveq 
  801044:	c3                   	retq   

0000000000801045 <strchr>:
  801045:	55                   	push   %rbp
  801046:	48 89 e5             	mov    %rsp,%rbp
  801049:	48 83 ec 0c          	sub    $0xc,%rsp
  80104d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801051:	89 f0                	mov    %esi,%eax
  801053:	88 45 f4             	mov    %al,-0xc(%rbp)
  801056:	eb 17                	jmp    80106f <strchr+0x2a>
  801058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80105c:	0f b6 00             	movzbl (%rax),%eax
  80105f:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801062:	75 06                	jne    80106a <strchr+0x25>
  801064:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801068:	eb 15                	jmp    80107f <strchr+0x3a>
  80106a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80106f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801073:	0f b6 00             	movzbl (%rax),%eax
  801076:	84 c0                	test   %al,%al
  801078:	75 de                	jne    801058 <strchr+0x13>
  80107a:	b8 00 00 00 00       	mov    $0x0,%eax
  80107f:	c9                   	leaveq 
  801080:	c3                   	retq   

0000000000801081 <strfind>:
  801081:	55                   	push   %rbp
  801082:	48 89 e5             	mov    %rsp,%rbp
  801085:	48 83 ec 0c          	sub    $0xc,%rsp
  801089:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80108d:	89 f0                	mov    %esi,%eax
  80108f:	88 45 f4             	mov    %al,-0xc(%rbp)
  801092:	eb 13                	jmp    8010a7 <strfind+0x26>
  801094:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801098:	0f b6 00             	movzbl (%rax),%eax
  80109b:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80109e:	75 02                	jne    8010a2 <strfind+0x21>
  8010a0:	eb 10                	jmp    8010b2 <strfind+0x31>
  8010a2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8010a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010ab:	0f b6 00             	movzbl (%rax),%eax
  8010ae:	84 c0                	test   %al,%al
  8010b0:	75 e2                	jne    801094 <strfind+0x13>
  8010b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010b6:	c9                   	leaveq 
  8010b7:	c3                   	retq   

00000000008010b8 <memset>:
  8010b8:	55                   	push   %rbp
  8010b9:	48 89 e5             	mov    %rsp,%rbp
  8010bc:	48 83 ec 18          	sub    $0x18,%rsp
  8010c0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8010c4:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8010c7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8010cb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8010d0:	75 06                	jne    8010d8 <memset+0x20>
  8010d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010d6:	eb 69                	jmp    801141 <memset+0x89>
  8010d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010dc:	83 e0 03             	and    $0x3,%eax
  8010df:	48 85 c0             	test   %rax,%rax
  8010e2:	75 48                	jne    80112c <memset+0x74>
  8010e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010e8:	83 e0 03             	and    $0x3,%eax
  8010eb:	48 85 c0             	test   %rax,%rax
  8010ee:	75 3c                	jne    80112c <memset+0x74>
  8010f0:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8010f7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8010fa:	c1 e0 18             	shl    $0x18,%eax
  8010fd:	89 c2                	mov    %eax,%edx
  8010ff:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801102:	c1 e0 10             	shl    $0x10,%eax
  801105:	09 c2                	or     %eax,%edx
  801107:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80110a:	c1 e0 08             	shl    $0x8,%eax
  80110d:	09 d0                	or     %edx,%eax
  80110f:	09 45 f4             	or     %eax,-0xc(%rbp)
  801112:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801116:	48 c1 e8 02          	shr    $0x2,%rax
  80111a:	48 89 c1             	mov    %rax,%rcx
  80111d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801121:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801124:	48 89 d7             	mov    %rdx,%rdi
  801127:	fc                   	cld    
  801128:	f3 ab                	rep stos %eax,%es:(%rdi)
  80112a:	eb 11                	jmp    80113d <memset+0x85>
  80112c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801130:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801133:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801137:	48 89 d7             	mov    %rdx,%rdi
  80113a:	fc                   	cld    
  80113b:	f3 aa                	rep stos %al,%es:(%rdi)
  80113d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801141:	c9                   	leaveq 
  801142:	c3                   	retq   

0000000000801143 <memmove>:
  801143:	55                   	push   %rbp
  801144:	48 89 e5             	mov    %rsp,%rbp
  801147:	48 83 ec 28          	sub    $0x28,%rsp
  80114b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80114f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801153:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801157:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80115b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80115f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801163:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801167:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80116b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80116f:	0f 83 88 00 00 00    	jae    8011fd <memmove+0xba>
  801175:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801179:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80117d:	48 01 d0             	add    %rdx,%rax
  801180:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801184:	76 77                	jbe    8011fd <memmove+0xba>
  801186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80118a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80118e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801192:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801196:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80119a:	83 e0 03             	and    $0x3,%eax
  80119d:	48 85 c0             	test   %rax,%rax
  8011a0:	75 3b                	jne    8011dd <memmove+0x9a>
  8011a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011a6:	83 e0 03             	and    $0x3,%eax
  8011a9:	48 85 c0             	test   %rax,%rax
  8011ac:	75 2f                	jne    8011dd <memmove+0x9a>
  8011ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8011b2:	83 e0 03             	and    $0x3,%eax
  8011b5:	48 85 c0             	test   %rax,%rax
  8011b8:	75 23                	jne    8011dd <memmove+0x9a>
  8011ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011be:	48 83 e8 04          	sub    $0x4,%rax
  8011c2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8011c6:	48 83 ea 04          	sub    $0x4,%rdx
  8011ca:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8011ce:	48 c1 e9 02          	shr    $0x2,%rcx
  8011d2:	48 89 c7             	mov    %rax,%rdi
  8011d5:	48 89 d6             	mov    %rdx,%rsi
  8011d8:	fd                   	std    
  8011d9:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8011db:	eb 1d                	jmp    8011fa <memmove+0xb7>
  8011dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011e1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8011e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011e9:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8011ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8011f1:	48 89 d7             	mov    %rdx,%rdi
  8011f4:	48 89 c1             	mov    %rax,%rcx
  8011f7:	fd                   	std    
  8011f8:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8011fa:	fc                   	cld    
  8011fb:	eb 57                	jmp    801254 <memmove+0x111>
  8011fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801201:	83 e0 03             	and    $0x3,%eax
  801204:	48 85 c0             	test   %rax,%rax
  801207:	75 36                	jne    80123f <memmove+0xfc>
  801209:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80120d:	83 e0 03             	and    $0x3,%eax
  801210:	48 85 c0             	test   %rax,%rax
  801213:	75 2a                	jne    80123f <memmove+0xfc>
  801215:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801219:	83 e0 03             	and    $0x3,%eax
  80121c:	48 85 c0             	test   %rax,%rax
  80121f:	75 1e                	jne    80123f <memmove+0xfc>
  801221:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801225:	48 c1 e8 02          	shr    $0x2,%rax
  801229:	48 89 c1             	mov    %rax,%rcx
  80122c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801230:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801234:	48 89 c7             	mov    %rax,%rdi
  801237:	48 89 d6             	mov    %rdx,%rsi
  80123a:	fc                   	cld    
  80123b:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80123d:	eb 15                	jmp    801254 <memmove+0x111>
  80123f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801243:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801247:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80124b:	48 89 c7             	mov    %rax,%rdi
  80124e:	48 89 d6             	mov    %rdx,%rsi
  801251:	fc                   	cld    
  801252:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801258:	c9                   	leaveq 
  801259:	c3                   	retq   

000000000080125a <memcpy>:
  80125a:	55                   	push   %rbp
  80125b:	48 89 e5             	mov    %rsp,%rbp
  80125e:	48 83 ec 18          	sub    $0x18,%rsp
  801262:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801266:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80126a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80126e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801272:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801276:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80127a:	48 89 ce             	mov    %rcx,%rsi
  80127d:	48 89 c7             	mov    %rax,%rdi
  801280:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  801287:	00 00 00 
  80128a:	ff d0                	callq  *%rax
  80128c:	c9                   	leaveq 
  80128d:	c3                   	retq   

000000000080128e <memcmp>:
  80128e:	55                   	push   %rbp
  80128f:	48 89 e5             	mov    %rsp,%rbp
  801292:	48 83 ec 28          	sub    $0x28,%rsp
  801296:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80129a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80129e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012a6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012aa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012ae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8012b2:	eb 36                	jmp    8012ea <memcmp+0x5c>
  8012b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012b8:	0f b6 10             	movzbl (%rax),%edx
  8012bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012bf:	0f b6 00             	movzbl (%rax),%eax
  8012c2:	38 c2                	cmp    %al,%dl
  8012c4:	74 1a                	je     8012e0 <memcmp+0x52>
  8012c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012ca:	0f b6 00             	movzbl (%rax),%eax
  8012cd:	0f b6 d0             	movzbl %al,%edx
  8012d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012d4:	0f b6 00             	movzbl (%rax),%eax
  8012d7:	0f b6 c0             	movzbl %al,%eax
  8012da:	29 c2                	sub    %eax,%edx
  8012dc:	89 d0                	mov    %edx,%eax
  8012de:	eb 20                	jmp    801300 <memcmp+0x72>
  8012e0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012e5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8012ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012ee:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8012f2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012f6:	48 85 c0             	test   %rax,%rax
  8012f9:	75 b9                	jne    8012b4 <memcmp+0x26>
  8012fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801300:	c9                   	leaveq 
  801301:	c3                   	retq   

0000000000801302 <memfind>:
  801302:	55                   	push   %rbp
  801303:	48 89 e5             	mov    %rsp,%rbp
  801306:	48 83 ec 28          	sub    $0x28,%rsp
  80130a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80130e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801311:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801315:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801319:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80131d:	48 01 d0             	add    %rdx,%rax
  801320:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801324:	eb 15                	jmp    80133b <memfind+0x39>
  801326:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80132a:	0f b6 10             	movzbl (%rax),%edx
  80132d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801330:	38 c2                	cmp    %al,%dl
  801332:	75 02                	jne    801336 <memfind+0x34>
  801334:	eb 0f                	jmp    801345 <memfind+0x43>
  801336:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80133b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80133f:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801343:	72 e1                	jb     801326 <memfind+0x24>
  801345:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801349:	c9                   	leaveq 
  80134a:	c3                   	retq   

000000000080134b <strtol>:
  80134b:	55                   	push   %rbp
  80134c:	48 89 e5             	mov    %rsp,%rbp
  80134f:	48 83 ec 34          	sub    $0x34,%rsp
  801353:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801357:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80135b:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80135e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801365:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  80136c:	00 
  80136d:	eb 05                	jmp    801374 <strtol+0x29>
  80136f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801374:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801378:	0f b6 00             	movzbl (%rax),%eax
  80137b:	3c 20                	cmp    $0x20,%al
  80137d:	74 f0                	je     80136f <strtol+0x24>
  80137f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801383:	0f b6 00             	movzbl (%rax),%eax
  801386:	3c 09                	cmp    $0x9,%al
  801388:	74 e5                	je     80136f <strtol+0x24>
  80138a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80138e:	0f b6 00             	movzbl (%rax),%eax
  801391:	3c 2b                	cmp    $0x2b,%al
  801393:	75 07                	jne    80139c <strtol+0x51>
  801395:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80139a:	eb 17                	jmp    8013b3 <strtol+0x68>
  80139c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013a0:	0f b6 00             	movzbl (%rax),%eax
  8013a3:	3c 2d                	cmp    $0x2d,%al
  8013a5:	75 0c                	jne    8013b3 <strtol+0x68>
  8013a7:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8013ac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8013b3:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8013b7:	74 06                	je     8013bf <strtol+0x74>
  8013b9:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8013bd:	75 28                	jne    8013e7 <strtol+0x9c>
  8013bf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013c3:	0f b6 00             	movzbl (%rax),%eax
  8013c6:	3c 30                	cmp    $0x30,%al
  8013c8:	75 1d                	jne    8013e7 <strtol+0x9c>
  8013ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013ce:	48 83 c0 01          	add    $0x1,%rax
  8013d2:	0f b6 00             	movzbl (%rax),%eax
  8013d5:	3c 78                	cmp    $0x78,%al
  8013d7:	75 0e                	jne    8013e7 <strtol+0x9c>
  8013d9:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8013de:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8013e5:	eb 2c                	jmp    801413 <strtol+0xc8>
  8013e7:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8013eb:	75 19                	jne    801406 <strtol+0xbb>
  8013ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013f1:	0f b6 00             	movzbl (%rax),%eax
  8013f4:	3c 30                	cmp    $0x30,%al
  8013f6:	75 0e                	jne    801406 <strtol+0xbb>
  8013f8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8013fd:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801404:	eb 0d                	jmp    801413 <strtol+0xc8>
  801406:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80140a:	75 07                	jne    801413 <strtol+0xc8>
  80140c:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801413:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801417:	0f b6 00             	movzbl (%rax),%eax
  80141a:	3c 2f                	cmp    $0x2f,%al
  80141c:	7e 1d                	jle    80143b <strtol+0xf0>
  80141e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801422:	0f b6 00             	movzbl (%rax),%eax
  801425:	3c 39                	cmp    $0x39,%al
  801427:	7f 12                	jg     80143b <strtol+0xf0>
  801429:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80142d:	0f b6 00             	movzbl (%rax),%eax
  801430:	0f be c0             	movsbl %al,%eax
  801433:	83 e8 30             	sub    $0x30,%eax
  801436:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801439:	eb 4e                	jmp    801489 <strtol+0x13e>
  80143b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80143f:	0f b6 00             	movzbl (%rax),%eax
  801442:	3c 60                	cmp    $0x60,%al
  801444:	7e 1d                	jle    801463 <strtol+0x118>
  801446:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80144a:	0f b6 00             	movzbl (%rax),%eax
  80144d:	3c 7a                	cmp    $0x7a,%al
  80144f:	7f 12                	jg     801463 <strtol+0x118>
  801451:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801455:	0f b6 00             	movzbl (%rax),%eax
  801458:	0f be c0             	movsbl %al,%eax
  80145b:	83 e8 57             	sub    $0x57,%eax
  80145e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801461:	eb 26                	jmp    801489 <strtol+0x13e>
  801463:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801467:	0f b6 00             	movzbl (%rax),%eax
  80146a:	3c 40                	cmp    $0x40,%al
  80146c:	7e 48                	jle    8014b6 <strtol+0x16b>
  80146e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801472:	0f b6 00             	movzbl (%rax),%eax
  801475:	3c 5a                	cmp    $0x5a,%al
  801477:	7f 3d                	jg     8014b6 <strtol+0x16b>
  801479:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80147d:	0f b6 00             	movzbl (%rax),%eax
  801480:	0f be c0             	movsbl %al,%eax
  801483:	83 e8 37             	sub    $0x37,%eax
  801486:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801489:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80148c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  80148f:	7c 02                	jl     801493 <strtol+0x148>
  801491:	eb 23                	jmp    8014b6 <strtol+0x16b>
  801493:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801498:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80149b:	48 98                	cltq   
  80149d:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8014a2:	48 89 c2             	mov    %rax,%rdx
  8014a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8014a8:	48 98                	cltq   
  8014aa:	48 01 d0             	add    %rdx,%rax
  8014ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8014b1:	e9 5d ff ff ff       	jmpq   801413 <strtol+0xc8>
  8014b6:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8014bb:	74 0b                	je     8014c8 <strtol+0x17d>
  8014bd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8014c1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8014c5:	48 89 10             	mov    %rdx,(%rax)
  8014c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8014cc:	74 09                	je     8014d7 <strtol+0x18c>
  8014ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014d2:	48 f7 d8             	neg    %rax
  8014d5:	eb 04                	jmp    8014db <strtol+0x190>
  8014d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014db:	c9                   	leaveq 
  8014dc:	c3                   	retq   

00000000008014dd <strstr>:
  8014dd:	55                   	push   %rbp
  8014de:	48 89 e5             	mov    %rsp,%rbp
  8014e1:	48 83 ec 30          	sub    $0x30,%rsp
  8014e5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8014e9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8014ed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8014f1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8014f5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8014f9:	0f b6 00             	movzbl (%rax),%eax
  8014fc:	88 45 ff             	mov    %al,-0x1(%rbp)
  8014ff:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801503:	75 06                	jne    80150b <strstr+0x2e>
  801505:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801509:	eb 6b                	jmp    801576 <strstr+0x99>
  80150b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80150f:	48 89 c7             	mov    %rax,%rdi
  801512:	48 b8 b3 0d 80 00 00 	movabs $0x800db3,%rax
  801519:	00 00 00 
  80151c:	ff d0                	callq  *%rax
  80151e:	48 98                	cltq   
  801520:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801524:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801528:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80152c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801530:	0f b6 00             	movzbl (%rax),%eax
  801533:	88 45 ef             	mov    %al,-0x11(%rbp)
  801536:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  80153a:	75 07                	jne    801543 <strstr+0x66>
  80153c:	b8 00 00 00 00       	mov    $0x0,%eax
  801541:	eb 33                	jmp    801576 <strstr+0x99>
  801543:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801547:	3a 45 ff             	cmp    -0x1(%rbp),%al
  80154a:	75 d8                	jne    801524 <strstr+0x47>
  80154c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801550:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801554:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801558:	48 89 ce             	mov    %rcx,%rsi
  80155b:	48 89 c7             	mov    %rax,%rdi
  80155e:	48 b8 d4 0f 80 00 00 	movabs $0x800fd4,%rax
  801565:	00 00 00 
  801568:	ff d0                	callq  *%rax
  80156a:	85 c0                	test   %eax,%eax
  80156c:	75 b6                	jne    801524 <strstr+0x47>
  80156e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801572:	48 83 e8 01          	sub    $0x1,%rax
  801576:	c9                   	leaveq 
  801577:	c3                   	retq   

0000000000801578 <syscall>:
  801578:	55                   	push   %rbp
  801579:	48 89 e5             	mov    %rsp,%rbp
  80157c:	53                   	push   %rbx
  80157d:	48 83 ec 48          	sub    $0x48,%rsp
  801581:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801584:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801587:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80158b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80158f:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801593:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801597:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80159a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80159e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8015a2:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8015a6:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8015aa:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8015ae:	4c 89 c3             	mov    %r8,%rbx
  8015b1:	cd 30                	int    $0x30
  8015b3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8015b7:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8015bb:	74 3e                	je     8015fb <syscall+0x83>
  8015bd:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8015c2:	7e 37                	jle    8015fb <syscall+0x83>
  8015c4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8015c8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8015cb:	49 89 d0             	mov    %rdx,%r8
  8015ce:	89 c1                	mov    %eax,%ecx
  8015d0:	48 ba c8 44 80 00 00 	movabs $0x8044c8,%rdx
  8015d7:	00 00 00 
  8015da:	be 24 00 00 00       	mov    $0x24,%esi
  8015df:	48 bf e5 44 80 00 00 	movabs $0x8044e5,%rdi
  8015e6:	00 00 00 
  8015e9:	b8 00 00 00 00       	mov    $0x0,%eax
  8015ee:	49 b9 e1 3b 80 00 00 	movabs $0x803be1,%r9
  8015f5:	00 00 00 
  8015f8:	41 ff d1             	callq  *%r9
  8015fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015ff:	48 83 c4 48          	add    $0x48,%rsp
  801603:	5b                   	pop    %rbx
  801604:	5d                   	pop    %rbp
  801605:	c3                   	retq   

0000000000801606 <sys_cputs>:
  801606:	55                   	push   %rbp
  801607:	48 89 e5             	mov    %rsp,%rbp
  80160a:	48 83 ec 20          	sub    $0x20,%rsp
  80160e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801612:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801616:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80161a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80161e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801625:	00 
  801626:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80162c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801632:	48 89 d1             	mov    %rdx,%rcx
  801635:	48 89 c2             	mov    %rax,%rdx
  801638:	be 00 00 00 00       	mov    $0x0,%esi
  80163d:	bf 00 00 00 00       	mov    $0x0,%edi
  801642:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801649:	00 00 00 
  80164c:	ff d0                	callq  *%rax
  80164e:	c9                   	leaveq 
  80164f:	c3                   	retq   

0000000000801650 <sys_cgetc>:
  801650:	55                   	push   %rbp
  801651:	48 89 e5             	mov    %rsp,%rbp
  801654:	48 83 ec 10          	sub    $0x10,%rsp
  801658:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80165f:	00 
  801660:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801666:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80166c:	b9 00 00 00 00       	mov    $0x0,%ecx
  801671:	ba 00 00 00 00       	mov    $0x0,%edx
  801676:	be 00 00 00 00       	mov    $0x0,%esi
  80167b:	bf 01 00 00 00       	mov    $0x1,%edi
  801680:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801687:	00 00 00 
  80168a:	ff d0                	callq  *%rax
  80168c:	c9                   	leaveq 
  80168d:	c3                   	retq   

000000000080168e <sys_env_destroy>:
  80168e:	55                   	push   %rbp
  80168f:	48 89 e5             	mov    %rsp,%rbp
  801692:	48 83 ec 10          	sub    $0x10,%rsp
  801696:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801699:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80169c:	48 98                	cltq   
  80169e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8016a5:	00 
  8016a6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8016ac:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8016b2:	b9 00 00 00 00       	mov    $0x0,%ecx
  8016b7:	48 89 c2             	mov    %rax,%rdx
  8016ba:	be 01 00 00 00       	mov    $0x1,%esi
  8016bf:	bf 03 00 00 00       	mov    $0x3,%edi
  8016c4:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  8016cb:	00 00 00 
  8016ce:	ff d0                	callq  *%rax
  8016d0:	c9                   	leaveq 
  8016d1:	c3                   	retq   

00000000008016d2 <sys_getenvid>:
  8016d2:	55                   	push   %rbp
  8016d3:	48 89 e5             	mov    %rsp,%rbp
  8016d6:	48 83 ec 10          	sub    $0x10,%rsp
  8016da:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8016e1:	00 
  8016e2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8016e8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8016ee:	b9 00 00 00 00       	mov    $0x0,%ecx
  8016f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8016f8:	be 00 00 00 00       	mov    $0x0,%esi
  8016fd:	bf 02 00 00 00       	mov    $0x2,%edi
  801702:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801709:	00 00 00 
  80170c:	ff d0                	callq  *%rax
  80170e:	c9                   	leaveq 
  80170f:	c3                   	retq   

0000000000801710 <sys_yield>:
  801710:	55                   	push   %rbp
  801711:	48 89 e5             	mov    %rsp,%rbp
  801714:	48 83 ec 10          	sub    $0x10,%rsp
  801718:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80171f:	00 
  801720:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801726:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80172c:	b9 00 00 00 00       	mov    $0x0,%ecx
  801731:	ba 00 00 00 00       	mov    $0x0,%edx
  801736:	be 00 00 00 00       	mov    $0x0,%esi
  80173b:	bf 0b 00 00 00       	mov    $0xb,%edi
  801740:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801747:	00 00 00 
  80174a:	ff d0                	callq  *%rax
  80174c:	c9                   	leaveq 
  80174d:	c3                   	retq   

000000000080174e <sys_page_alloc>:
  80174e:	55                   	push   %rbp
  80174f:	48 89 e5             	mov    %rsp,%rbp
  801752:	48 83 ec 20          	sub    $0x20,%rsp
  801756:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801759:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80175d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801760:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801763:	48 63 c8             	movslq %eax,%rcx
  801766:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80176a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80176d:	48 98                	cltq   
  80176f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801776:	00 
  801777:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80177d:	49 89 c8             	mov    %rcx,%r8
  801780:	48 89 d1             	mov    %rdx,%rcx
  801783:	48 89 c2             	mov    %rax,%rdx
  801786:	be 01 00 00 00       	mov    $0x1,%esi
  80178b:	bf 04 00 00 00       	mov    $0x4,%edi
  801790:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801797:	00 00 00 
  80179a:	ff d0                	callq  *%rax
  80179c:	c9                   	leaveq 
  80179d:	c3                   	retq   

000000000080179e <sys_page_map>:
  80179e:	55                   	push   %rbp
  80179f:	48 89 e5             	mov    %rsp,%rbp
  8017a2:	48 83 ec 30          	sub    $0x30,%rsp
  8017a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8017a9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8017ad:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8017b0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8017b4:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8017b8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8017bb:	48 63 c8             	movslq %eax,%rcx
  8017be:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8017c2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8017c5:	48 63 f0             	movslq %eax,%rsi
  8017c8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8017cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8017cf:	48 98                	cltq   
  8017d1:	48 89 0c 24          	mov    %rcx,(%rsp)
  8017d5:	49 89 f9             	mov    %rdi,%r9
  8017d8:	49 89 f0             	mov    %rsi,%r8
  8017db:	48 89 d1             	mov    %rdx,%rcx
  8017de:	48 89 c2             	mov    %rax,%rdx
  8017e1:	be 01 00 00 00       	mov    $0x1,%esi
  8017e6:	bf 05 00 00 00       	mov    $0x5,%edi
  8017eb:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  8017f2:	00 00 00 
  8017f5:	ff d0                	callq  *%rax
  8017f7:	c9                   	leaveq 
  8017f8:	c3                   	retq   

00000000008017f9 <sys_page_unmap>:
  8017f9:	55                   	push   %rbp
  8017fa:	48 89 e5             	mov    %rsp,%rbp
  8017fd:	48 83 ec 20          	sub    $0x20,%rsp
  801801:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801804:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801808:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80180c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80180f:	48 98                	cltq   
  801811:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801818:	00 
  801819:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80181f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801825:	48 89 d1             	mov    %rdx,%rcx
  801828:	48 89 c2             	mov    %rax,%rdx
  80182b:	be 01 00 00 00       	mov    $0x1,%esi
  801830:	bf 06 00 00 00       	mov    $0x6,%edi
  801835:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  80183c:	00 00 00 
  80183f:	ff d0                	callq  *%rax
  801841:	c9                   	leaveq 
  801842:	c3                   	retq   

0000000000801843 <sys_env_set_status>:
  801843:	55                   	push   %rbp
  801844:	48 89 e5             	mov    %rsp,%rbp
  801847:	48 83 ec 10          	sub    $0x10,%rsp
  80184b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80184e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801851:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801854:	48 63 d0             	movslq %eax,%rdx
  801857:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80185a:	48 98                	cltq   
  80185c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801863:	00 
  801864:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80186a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801870:	48 89 d1             	mov    %rdx,%rcx
  801873:	48 89 c2             	mov    %rax,%rdx
  801876:	be 01 00 00 00       	mov    $0x1,%esi
  80187b:	bf 08 00 00 00       	mov    $0x8,%edi
  801880:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801887:	00 00 00 
  80188a:	ff d0                	callq  *%rax
  80188c:	c9                   	leaveq 
  80188d:	c3                   	retq   

000000000080188e <sys_env_set_trapframe>:
  80188e:	55                   	push   %rbp
  80188f:	48 89 e5             	mov    %rsp,%rbp
  801892:	48 83 ec 20          	sub    $0x20,%rsp
  801896:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801899:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80189d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018a4:	48 98                	cltq   
  8018a6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018ad:	00 
  8018ae:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018b4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018ba:	48 89 d1             	mov    %rdx,%rcx
  8018bd:	48 89 c2             	mov    %rax,%rdx
  8018c0:	be 01 00 00 00       	mov    $0x1,%esi
  8018c5:	bf 09 00 00 00       	mov    $0x9,%edi
  8018ca:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  8018d1:	00 00 00 
  8018d4:	ff d0                	callq  *%rax
  8018d6:	c9                   	leaveq 
  8018d7:	c3                   	retq   

00000000008018d8 <sys_env_set_pgfault_upcall>:
  8018d8:	55                   	push   %rbp
  8018d9:	48 89 e5             	mov    %rsp,%rbp
  8018dc:	48 83 ec 20          	sub    $0x20,%rsp
  8018e0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018e3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018e7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018ee:	48 98                	cltq   
  8018f0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018f7:	00 
  8018f8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018fe:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801904:	48 89 d1             	mov    %rdx,%rcx
  801907:	48 89 c2             	mov    %rax,%rdx
  80190a:	be 01 00 00 00       	mov    $0x1,%esi
  80190f:	bf 0a 00 00 00       	mov    $0xa,%edi
  801914:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  80191b:	00 00 00 
  80191e:	ff d0                	callq  *%rax
  801920:	c9                   	leaveq 
  801921:	c3                   	retq   

0000000000801922 <sys_ipc_try_send>:
  801922:	55                   	push   %rbp
  801923:	48 89 e5             	mov    %rsp,%rbp
  801926:	48 83 ec 20          	sub    $0x20,%rsp
  80192a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80192d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801931:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801935:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801938:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80193b:	48 63 f0             	movslq %eax,%rsi
  80193e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801942:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801945:	48 98                	cltq   
  801947:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80194b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801952:	00 
  801953:	49 89 f1             	mov    %rsi,%r9
  801956:	49 89 c8             	mov    %rcx,%r8
  801959:	48 89 d1             	mov    %rdx,%rcx
  80195c:	48 89 c2             	mov    %rax,%rdx
  80195f:	be 00 00 00 00       	mov    $0x0,%esi
  801964:	bf 0c 00 00 00       	mov    $0xc,%edi
  801969:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801970:	00 00 00 
  801973:	ff d0                	callq  *%rax
  801975:	c9                   	leaveq 
  801976:	c3                   	retq   

0000000000801977 <sys_ipc_recv>:
  801977:	55                   	push   %rbp
  801978:	48 89 e5             	mov    %rsp,%rbp
  80197b:	48 83 ec 10          	sub    $0x10,%rsp
  80197f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801983:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801987:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80198e:	00 
  80198f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801995:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80199b:	b9 00 00 00 00       	mov    $0x0,%ecx
  8019a0:	48 89 c2             	mov    %rax,%rdx
  8019a3:	be 01 00 00 00       	mov    $0x1,%esi
  8019a8:	bf 0d 00 00 00       	mov    $0xd,%edi
  8019ad:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  8019b4:	00 00 00 
  8019b7:	ff d0                	callq  *%rax
  8019b9:	c9                   	leaveq 
  8019ba:	c3                   	retq   

00000000008019bb <sys_time_msec>:
  8019bb:	55                   	push   %rbp
  8019bc:	48 89 e5             	mov    %rsp,%rbp
  8019bf:	48 83 ec 10          	sub    $0x10,%rsp
  8019c3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019ca:	00 
  8019cb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019d1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019d7:	b9 00 00 00 00       	mov    $0x0,%ecx
  8019dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8019e1:	be 00 00 00 00       	mov    $0x0,%esi
  8019e6:	bf 0e 00 00 00       	mov    $0xe,%edi
  8019eb:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  8019f2:	00 00 00 
  8019f5:	ff d0                	callq  *%rax
  8019f7:	c9                   	leaveq 
  8019f8:	c3                   	retq   

00000000008019f9 <sys_net_transmit>:
  8019f9:	55                   	push   %rbp
  8019fa:	48 89 e5             	mov    %rsp,%rbp
  8019fd:	48 83 ec 20          	sub    $0x20,%rsp
  801a01:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a05:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801a08:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801a0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a0f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a16:	00 
  801a17:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a1d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a23:	48 89 d1             	mov    %rdx,%rcx
  801a26:	48 89 c2             	mov    %rax,%rdx
  801a29:	be 00 00 00 00       	mov    $0x0,%esi
  801a2e:	bf 0f 00 00 00       	mov    $0xf,%edi
  801a33:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801a3a:	00 00 00 
  801a3d:	ff d0                	callq  *%rax
  801a3f:	c9                   	leaveq 
  801a40:	c3                   	retq   

0000000000801a41 <sys_net_receive>:
  801a41:	55                   	push   %rbp
  801a42:	48 89 e5             	mov    %rsp,%rbp
  801a45:	48 83 ec 20          	sub    $0x20,%rsp
  801a49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a4d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801a50:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801a53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a57:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a5e:	00 
  801a5f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a65:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a6b:	48 89 d1             	mov    %rdx,%rcx
  801a6e:	48 89 c2             	mov    %rax,%rdx
  801a71:	be 00 00 00 00       	mov    $0x0,%esi
  801a76:	bf 10 00 00 00       	mov    $0x10,%edi
  801a7b:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801a82:	00 00 00 
  801a85:	ff d0                	callq  *%rax
  801a87:	c9                   	leaveq 
  801a88:	c3                   	retq   

0000000000801a89 <sys_ept_map>:
  801a89:	55                   	push   %rbp
  801a8a:	48 89 e5             	mov    %rsp,%rbp
  801a8d:	48 83 ec 30          	sub    $0x30,%rsp
  801a91:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a94:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a98:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801a9b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801a9f:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801aa3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801aa6:	48 63 c8             	movslq %eax,%rcx
  801aa9:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801aad:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801ab0:	48 63 f0             	movslq %eax,%rsi
  801ab3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ab7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801aba:	48 98                	cltq   
  801abc:	48 89 0c 24          	mov    %rcx,(%rsp)
  801ac0:	49 89 f9             	mov    %rdi,%r9
  801ac3:	49 89 f0             	mov    %rsi,%r8
  801ac6:	48 89 d1             	mov    %rdx,%rcx
  801ac9:	48 89 c2             	mov    %rax,%rdx
  801acc:	be 00 00 00 00       	mov    $0x0,%esi
  801ad1:	bf 11 00 00 00       	mov    $0x11,%edi
  801ad6:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801add:	00 00 00 
  801ae0:	ff d0                	callq  *%rax
  801ae2:	c9                   	leaveq 
  801ae3:	c3                   	retq   

0000000000801ae4 <sys_env_mkguest>:
  801ae4:	55                   	push   %rbp
  801ae5:	48 89 e5             	mov    %rsp,%rbp
  801ae8:	48 83 ec 20          	sub    $0x20,%rsp
  801aec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801af0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801af4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801af8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801afc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b03:	00 
  801b04:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b0a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b10:	48 89 d1             	mov    %rdx,%rcx
  801b13:	48 89 c2             	mov    %rax,%rdx
  801b16:	be 00 00 00 00       	mov    $0x0,%esi
  801b1b:	bf 12 00 00 00       	mov    $0x12,%edi
  801b20:	48 b8 78 15 80 00 00 	movabs $0x801578,%rax
  801b27:	00 00 00 
  801b2a:	ff d0                	callq  *%rax
  801b2c:	c9                   	leaveq 
  801b2d:	c3                   	retq   

0000000000801b2e <fd2num>:
  801b2e:	55                   	push   %rbp
  801b2f:	48 89 e5             	mov    %rsp,%rbp
  801b32:	48 83 ec 08          	sub    $0x8,%rsp
  801b36:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b3a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801b3e:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801b45:	ff ff ff 
  801b48:	48 01 d0             	add    %rdx,%rax
  801b4b:	48 c1 e8 0c          	shr    $0xc,%rax
  801b4f:	c9                   	leaveq 
  801b50:	c3                   	retq   

0000000000801b51 <fd2data>:
  801b51:	55                   	push   %rbp
  801b52:	48 89 e5             	mov    %rsp,%rbp
  801b55:	48 83 ec 08          	sub    $0x8,%rsp
  801b59:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b61:	48 89 c7             	mov    %rax,%rdi
  801b64:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  801b6b:	00 00 00 
  801b6e:	ff d0                	callq  *%rax
  801b70:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801b76:	48 c1 e0 0c          	shl    $0xc,%rax
  801b7a:	c9                   	leaveq 
  801b7b:	c3                   	retq   

0000000000801b7c <fd_alloc>:
  801b7c:	55                   	push   %rbp
  801b7d:	48 89 e5             	mov    %rsp,%rbp
  801b80:	48 83 ec 18          	sub    $0x18,%rsp
  801b84:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801b8f:	eb 6b                	jmp    801bfc <fd_alloc+0x80>
  801b91:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b94:	48 98                	cltq   
  801b96:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801b9c:	48 c1 e0 0c          	shl    $0xc,%rax
  801ba0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ba4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ba8:	48 c1 e8 15          	shr    $0x15,%rax
  801bac:	48 89 c2             	mov    %rax,%rdx
  801baf:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801bb6:	01 00 00 
  801bb9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801bbd:	83 e0 01             	and    $0x1,%eax
  801bc0:	48 85 c0             	test   %rax,%rax
  801bc3:	74 21                	je     801be6 <fd_alloc+0x6a>
  801bc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801bc9:	48 c1 e8 0c          	shr    $0xc,%rax
  801bcd:	48 89 c2             	mov    %rax,%rdx
  801bd0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801bd7:	01 00 00 
  801bda:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801bde:	83 e0 01             	and    $0x1,%eax
  801be1:	48 85 c0             	test   %rax,%rax
  801be4:	75 12                	jne    801bf8 <fd_alloc+0x7c>
  801be6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bee:	48 89 10             	mov    %rdx,(%rax)
  801bf1:	b8 00 00 00 00       	mov    $0x0,%eax
  801bf6:	eb 1a                	jmp    801c12 <fd_alloc+0x96>
  801bf8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801bfc:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801c00:	7e 8f                	jle    801b91 <fd_alloc+0x15>
  801c02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c06:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801c0d:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801c12:	c9                   	leaveq 
  801c13:	c3                   	retq   

0000000000801c14 <fd_lookup>:
  801c14:	55                   	push   %rbp
  801c15:	48 89 e5             	mov    %rsp,%rbp
  801c18:	48 83 ec 20          	sub    $0x20,%rsp
  801c1c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801c1f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801c23:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801c27:	78 06                	js     801c2f <fd_lookup+0x1b>
  801c29:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801c2d:	7e 07                	jle    801c36 <fd_lookup+0x22>
  801c2f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801c34:	eb 6c                	jmp    801ca2 <fd_lookup+0x8e>
  801c36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801c39:	48 98                	cltq   
  801c3b:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801c41:	48 c1 e0 0c          	shl    $0xc,%rax
  801c45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801c49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c4d:	48 c1 e8 15          	shr    $0x15,%rax
  801c51:	48 89 c2             	mov    %rax,%rdx
  801c54:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801c5b:	01 00 00 
  801c5e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801c62:	83 e0 01             	and    $0x1,%eax
  801c65:	48 85 c0             	test   %rax,%rax
  801c68:	74 21                	je     801c8b <fd_lookup+0x77>
  801c6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c6e:	48 c1 e8 0c          	shr    $0xc,%rax
  801c72:	48 89 c2             	mov    %rax,%rdx
  801c75:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801c7c:	01 00 00 
  801c7f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801c83:	83 e0 01             	and    $0x1,%eax
  801c86:	48 85 c0             	test   %rax,%rax
  801c89:	75 07                	jne    801c92 <fd_lookup+0x7e>
  801c8b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801c90:	eb 10                	jmp    801ca2 <fd_lookup+0x8e>
  801c92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c96:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801c9a:	48 89 10             	mov    %rdx,(%rax)
  801c9d:	b8 00 00 00 00       	mov    $0x0,%eax
  801ca2:	c9                   	leaveq 
  801ca3:	c3                   	retq   

0000000000801ca4 <fd_close>:
  801ca4:	55                   	push   %rbp
  801ca5:	48 89 e5             	mov    %rsp,%rbp
  801ca8:	48 83 ec 30          	sub    $0x30,%rsp
  801cac:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801cb0:	89 f0                	mov    %esi,%eax
  801cb2:	88 45 d4             	mov    %al,-0x2c(%rbp)
  801cb5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801cb9:	48 89 c7             	mov    %rax,%rdi
  801cbc:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  801cc3:	00 00 00 
  801cc6:	ff d0                	callq  *%rax
  801cc8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801ccc:	48 89 d6             	mov    %rdx,%rsi
  801ccf:	89 c7                	mov    %eax,%edi
  801cd1:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  801cd8:	00 00 00 
  801cdb:	ff d0                	callq  *%rax
  801cdd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ce0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801ce4:	78 0a                	js     801cf0 <fd_close+0x4c>
  801ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cea:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801cee:	74 12                	je     801d02 <fd_close+0x5e>
  801cf0:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801cf4:	74 05                	je     801cfb <fd_close+0x57>
  801cf6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cf9:	eb 05                	jmp    801d00 <fd_close+0x5c>
  801cfb:	b8 00 00 00 00       	mov    $0x0,%eax
  801d00:	eb 69                	jmp    801d6b <fd_close+0xc7>
  801d02:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801d06:	8b 00                	mov    (%rax),%eax
  801d08:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801d0c:	48 89 d6             	mov    %rdx,%rsi
  801d0f:	89 c7                	mov    %eax,%edi
  801d11:	48 b8 6d 1d 80 00 00 	movabs $0x801d6d,%rax
  801d18:	00 00 00 
  801d1b:	ff d0                	callq  *%rax
  801d1d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801d20:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801d24:	78 2a                	js     801d50 <fd_close+0xac>
  801d26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d2a:	48 8b 40 20          	mov    0x20(%rax),%rax
  801d2e:	48 85 c0             	test   %rax,%rax
  801d31:	74 16                	je     801d49 <fd_close+0xa5>
  801d33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d37:	48 8b 40 20          	mov    0x20(%rax),%rax
  801d3b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801d3f:	48 89 d7             	mov    %rdx,%rdi
  801d42:	ff d0                	callq  *%rax
  801d44:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801d47:	eb 07                	jmp    801d50 <fd_close+0xac>
  801d49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801d54:	48 89 c6             	mov    %rax,%rsi
  801d57:	bf 00 00 00 00       	mov    $0x0,%edi
  801d5c:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  801d63:	00 00 00 
  801d66:	ff d0                	callq  *%rax
  801d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d6b:	c9                   	leaveq 
  801d6c:	c3                   	retq   

0000000000801d6d <dev_lookup>:
  801d6d:	55                   	push   %rbp
  801d6e:	48 89 e5             	mov    %rsp,%rbp
  801d71:	48 83 ec 20          	sub    $0x20,%rsp
  801d75:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801d78:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801d7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801d83:	eb 41                	jmp    801dc6 <dev_lookup+0x59>
  801d85:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801d8c:	00 00 00 
  801d8f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801d92:	48 63 d2             	movslq %edx,%rdx
  801d95:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801d99:	8b 00                	mov    (%rax),%eax
  801d9b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  801d9e:	75 22                	jne    801dc2 <dev_lookup+0x55>
  801da0:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801da7:	00 00 00 
  801daa:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801dad:	48 63 d2             	movslq %edx,%rdx
  801db0:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801db4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801db8:	48 89 10             	mov    %rdx,(%rax)
  801dbb:	b8 00 00 00 00       	mov    $0x0,%eax
  801dc0:	eb 60                	jmp    801e22 <dev_lookup+0xb5>
  801dc2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801dc6:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801dcd:	00 00 00 
  801dd0:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801dd3:	48 63 d2             	movslq %edx,%rdx
  801dd6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801dda:	48 85 c0             	test   %rax,%rax
  801ddd:	75 a6                	jne    801d85 <dev_lookup+0x18>
  801ddf:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  801de6:	00 00 00 
  801de9:	48 8b 00             	mov    (%rax),%rax
  801dec:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801df2:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801df5:	89 c6                	mov    %eax,%esi
  801df7:	48 bf f8 44 80 00 00 	movabs $0x8044f8,%rdi
  801dfe:	00 00 00 
  801e01:	b8 00 00 00 00       	mov    $0x0,%eax
  801e06:	48 b9 6a 02 80 00 00 	movabs $0x80026a,%rcx
  801e0d:	00 00 00 
  801e10:	ff d1                	callq  *%rcx
  801e12:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801e16:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801e1d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801e22:	c9                   	leaveq 
  801e23:	c3                   	retq   

0000000000801e24 <close>:
  801e24:	55                   	push   %rbp
  801e25:	48 89 e5             	mov    %rsp,%rbp
  801e28:	48 83 ec 20          	sub    $0x20,%rsp
  801e2c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801e2f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801e33:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801e36:	48 89 d6             	mov    %rdx,%rsi
  801e39:	89 c7                	mov    %eax,%edi
  801e3b:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  801e42:	00 00 00 
  801e45:	ff d0                	callq  *%rax
  801e47:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801e4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801e4e:	79 05                	jns    801e55 <close+0x31>
  801e50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e53:	eb 18                	jmp    801e6d <close+0x49>
  801e55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e59:	be 01 00 00 00       	mov    $0x1,%esi
  801e5e:	48 89 c7             	mov    %rax,%rdi
  801e61:	48 b8 a4 1c 80 00 00 	movabs $0x801ca4,%rax
  801e68:	00 00 00 
  801e6b:	ff d0                	callq  *%rax
  801e6d:	c9                   	leaveq 
  801e6e:	c3                   	retq   

0000000000801e6f <close_all>:
  801e6f:	55                   	push   %rbp
  801e70:	48 89 e5             	mov    %rsp,%rbp
  801e73:	48 83 ec 10          	sub    $0x10,%rsp
  801e77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801e7e:	eb 15                	jmp    801e95 <close_all+0x26>
  801e80:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e83:	89 c7                	mov    %eax,%edi
  801e85:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  801e8c:	00 00 00 
  801e8f:	ff d0                	callq  *%rax
  801e91:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801e95:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801e99:	7e e5                	jle    801e80 <close_all+0x11>
  801e9b:	c9                   	leaveq 
  801e9c:	c3                   	retq   

0000000000801e9d <dup>:
  801e9d:	55                   	push   %rbp
  801e9e:	48 89 e5             	mov    %rsp,%rbp
  801ea1:	48 83 ec 40          	sub    $0x40,%rsp
  801ea5:	89 7d cc             	mov    %edi,-0x34(%rbp)
  801ea8:	89 75 c8             	mov    %esi,-0x38(%rbp)
  801eab:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  801eaf:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801eb2:	48 89 d6             	mov    %rdx,%rsi
  801eb5:	89 c7                	mov    %eax,%edi
  801eb7:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  801ebe:	00 00 00 
  801ec1:	ff d0                	callq  *%rax
  801ec3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ec6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801eca:	79 08                	jns    801ed4 <dup+0x37>
  801ecc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ecf:	e9 70 01 00 00       	jmpq   802044 <dup+0x1a7>
  801ed4:	8b 45 c8             	mov    -0x38(%rbp),%eax
  801ed7:	89 c7                	mov    %eax,%edi
  801ed9:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  801ee0:	00 00 00 
  801ee3:	ff d0                	callq  *%rax
  801ee5:	8b 45 c8             	mov    -0x38(%rbp),%eax
  801ee8:	48 98                	cltq   
  801eea:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801ef0:	48 c1 e0 0c          	shl    $0xc,%rax
  801ef4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ef8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801efc:	48 89 c7             	mov    %rax,%rdi
  801eff:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  801f06:	00 00 00 
  801f09:	ff d0                	callq  *%rax
  801f0b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801f0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f13:	48 89 c7             	mov    %rax,%rdi
  801f16:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  801f1d:	00 00 00 
  801f20:	ff d0                	callq  *%rax
  801f22:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801f26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f2a:	48 c1 e8 15          	shr    $0x15,%rax
  801f2e:	48 89 c2             	mov    %rax,%rdx
  801f31:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801f38:	01 00 00 
  801f3b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f3f:	83 e0 01             	and    $0x1,%eax
  801f42:	48 85 c0             	test   %rax,%rax
  801f45:	74 73                	je     801fba <dup+0x11d>
  801f47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f4b:	48 c1 e8 0c          	shr    $0xc,%rax
  801f4f:	48 89 c2             	mov    %rax,%rdx
  801f52:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f59:	01 00 00 
  801f5c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f60:	83 e0 01             	and    $0x1,%eax
  801f63:	48 85 c0             	test   %rax,%rax
  801f66:	74 52                	je     801fba <dup+0x11d>
  801f68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f6c:	48 c1 e8 0c          	shr    $0xc,%rax
  801f70:	48 89 c2             	mov    %rax,%rdx
  801f73:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f7a:	01 00 00 
  801f7d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f81:	25 07 0e 00 00       	and    $0xe07,%eax
  801f86:	89 c1                	mov    %eax,%ecx
  801f88:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f90:	41 89 c8             	mov    %ecx,%r8d
  801f93:	48 89 d1             	mov    %rdx,%rcx
  801f96:	ba 00 00 00 00       	mov    $0x0,%edx
  801f9b:	48 89 c6             	mov    %rax,%rsi
  801f9e:	bf 00 00 00 00       	mov    $0x0,%edi
  801fa3:	48 b8 9e 17 80 00 00 	movabs $0x80179e,%rax
  801faa:	00 00 00 
  801fad:	ff d0                	callq  *%rax
  801faf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fb2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801fb6:	79 02                	jns    801fba <dup+0x11d>
  801fb8:	eb 57                	jmp    802011 <dup+0x174>
  801fba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fbe:	48 c1 e8 0c          	shr    $0xc,%rax
  801fc2:	48 89 c2             	mov    %rax,%rdx
  801fc5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fcc:	01 00 00 
  801fcf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fd3:	25 07 0e 00 00       	and    $0xe07,%eax
  801fd8:	89 c1                	mov    %eax,%ecx
  801fda:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fde:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801fe2:	41 89 c8             	mov    %ecx,%r8d
  801fe5:	48 89 d1             	mov    %rdx,%rcx
  801fe8:	ba 00 00 00 00       	mov    $0x0,%edx
  801fed:	48 89 c6             	mov    %rax,%rsi
  801ff0:	bf 00 00 00 00       	mov    $0x0,%edi
  801ff5:	48 b8 9e 17 80 00 00 	movabs $0x80179e,%rax
  801ffc:	00 00 00 
  801fff:	ff d0                	callq  *%rax
  802001:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802004:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802008:	79 02                	jns    80200c <dup+0x16f>
  80200a:	eb 05                	jmp    802011 <dup+0x174>
  80200c:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80200f:	eb 33                	jmp    802044 <dup+0x1a7>
  802011:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802015:	48 89 c6             	mov    %rax,%rsi
  802018:	bf 00 00 00 00       	mov    $0x0,%edi
  80201d:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  802024:	00 00 00 
  802027:	ff d0                	callq  *%rax
  802029:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80202d:	48 89 c6             	mov    %rax,%rsi
  802030:	bf 00 00 00 00       	mov    $0x0,%edi
  802035:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  80203c:	00 00 00 
  80203f:	ff d0                	callq  *%rax
  802041:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802044:	c9                   	leaveq 
  802045:	c3                   	retq   

0000000000802046 <read>:
  802046:	55                   	push   %rbp
  802047:	48 89 e5             	mov    %rsp,%rbp
  80204a:	48 83 ec 40          	sub    $0x40,%rsp
  80204e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802051:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802055:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802059:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80205d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802060:	48 89 d6             	mov    %rdx,%rsi
  802063:	89 c7                	mov    %eax,%edi
  802065:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  80206c:	00 00 00 
  80206f:	ff d0                	callq  *%rax
  802071:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802074:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802078:	78 24                	js     80209e <read+0x58>
  80207a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80207e:	8b 00                	mov    (%rax),%eax
  802080:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802084:	48 89 d6             	mov    %rdx,%rsi
  802087:	89 c7                	mov    %eax,%edi
  802089:	48 b8 6d 1d 80 00 00 	movabs $0x801d6d,%rax
  802090:	00 00 00 
  802093:	ff d0                	callq  *%rax
  802095:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802098:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80209c:	79 05                	jns    8020a3 <read+0x5d>
  80209e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020a1:	eb 76                	jmp    802119 <read+0xd3>
  8020a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020a7:	8b 40 08             	mov    0x8(%rax),%eax
  8020aa:	83 e0 03             	and    $0x3,%eax
  8020ad:	83 f8 01             	cmp    $0x1,%eax
  8020b0:	75 3a                	jne    8020ec <read+0xa6>
  8020b2:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8020b9:	00 00 00 
  8020bc:	48 8b 00             	mov    (%rax),%rax
  8020bf:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8020c5:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8020c8:	89 c6                	mov    %eax,%esi
  8020ca:	48 bf 17 45 80 00 00 	movabs $0x804517,%rdi
  8020d1:	00 00 00 
  8020d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8020d9:	48 b9 6a 02 80 00 00 	movabs $0x80026a,%rcx
  8020e0:	00 00 00 
  8020e3:	ff d1                	callq  *%rcx
  8020e5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8020ea:	eb 2d                	jmp    802119 <read+0xd3>
  8020ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8020f0:	48 8b 40 10          	mov    0x10(%rax),%rax
  8020f4:	48 85 c0             	test   %rax,%rax
  8020f7:	75 07                	jne    802100 <read+0xba>
  8020f9:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8020fe:	eb 19                	jmp    802119 <read+0xd3>
  802100:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802104:	48 8b 40 10          	mov    0x10(%rax),%rax
  802108:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80210c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802110:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802114:	48 89 cf             	mov    %rcx,%rdi
  802117:	ff d0                	callq  *%rax
  802119:	c9                   	leaveq 
  80211a:	c3                   	retq   

000000000080211b <readn>:
  80211b:	55                   	push   %rbp
  80211c:	48 89 e5             	mov    %rsp,%rbp
  80211f:	48 83 ec 30          	sub    $0x30,%rsp
  802123:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802126:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80212a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80212e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802135:	eb 49                	jmp    802180 <readn+0x65>
  802137:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80213a:	48 98                	cltq   
  80213c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802140:	48 29 c2             	sub    %rax,%rdx
  802143:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802146:	48 63 c8             	movslq %eax,%rcx
  802149:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80214d:	48 01 c1             	add    %rax,%rcx
  802150:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802153:	48 89 ce             	mov    %rcx,%rsi
  802156:	89 c7                	mov    %eax,%edi
  802158:	48 b8 46 20 80 00 00 	movabs $0x802046,%rax
  80215f:	00 00 00 
  802162:	ff d0                	callq  *%rax
  802164:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802167:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80216b:	79 05                	jns    802172 <readn+0x57>
  80216d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802170:	eb 1c                	jmp    80218e <readn+0x73>
  802172:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802176:	75 02                	jne    80217a <readn+0x5f>
  802178:	eb 11                	jmp    80218b <readn+0x70>
  80217a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80217d:	01 45 fc             	add    %eax,-0x4(%rbp)
  802180:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802183:	48 98                	cltq   
  802185:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802189:	72 ac                	jb     802137 <readn+0x1c>
  80218b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80218e:	c9                   	leaveq 
  80218f:	c3                   	retq   

0000000000802190 <write>:
  802190:	55                   	push   %rbp
  802191:	48 89 e5             	mov    %rsp,%rbp
  802194:	48 83 ec 40          	sub    $0x40,%rsp
  802198:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80219b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80219f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8021a3:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8021a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8021aa:	48 89 d6             	mov    %rdx,%rsi
  8021ad:	89 c7                	mov    %eax,%edi
  8021af:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  8021b6:	00 00 00 
  8021b9:	ff d0                	callq  *%rax
  8021bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021c2:	78 24                	js     8021e8 <write+0x58>
  8021c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021c8:	8b 00                	mov    (%rax),%eax
  8021ca:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8021ce:	48 89 d6             	mov    %rdx,%rsi
  8021d1:	89 c7                	mov    %eax,%edi
  8021d3:	48 b8 6d 1d 80 00 00 	movabs $0x801d6d,%rax
  8021da:	00 00 00 
  8021dd:	ff d0                	callq  *%rax
  8021df:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021e6:	79 05                	jns    8021ed <write+0x5d>
  8021e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021eb:	eb 75                	jmp    802262 <write+0xd2>
  8021ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021f1:	8b 40 08             	mov    0x8(%rax),%eax
  8021f4:	83 e0 03             	and    $0x3,%eax
  8021f7:	85 c0                	test   %eax,%eax
  8021f9:	75 3a                	jne    802235 <write+0xa5>
  8021fb:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802202:	00 00 00 
  802205:	48 8b 00             	mov    (%rax),%rax
  802208:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80220e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802211:	89 c6                	mov    %eax,%esi
  802213:	48 bf 33 45 80 00 00 	movabs $0x804533,%rdi
  80221a:	00 00 00 
  80221d:	b8 00 00 00 00       	mov    $0x0,%eax
  802222:	48 b9 6a 02 80 00 00 	movabs $0x80026a,%rcx
  802229:	00 00 00 
  80222c:	ff d1                	callq  *%rcx
  80222e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802233:	eb 2d                	jmp    802262 <write+0xd2>
  802235:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802239:	48 8b 40 18          	mov    0x18(%rax),%rax
  80223d:	48 85 c0             	test   %rax,%rax
  802240:	75 07                	jne    802249 <write+0xb9>
  802242:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802247:	eb 19                	jmp    802262 <write+0xd2>
  802249:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80224d:	48 8b 40 18          	mov    0x18(%rax),%rax
  802251:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802255:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802259:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  80225d:	48 89 cf             	mov    %rcx,%rdi
  802260:	ff d0                	callq  *%rax
  802262:	c9                   	leaveq 
  802263:	c3                   	retq   

0000000000802264 <seek>:
  802264:	55                   	push   %rbp
  802265:	48 89 e5             	mov    %rsp,%rbp
  802268:	48 83 ec 18          	sub    $0x18,%rsp
  80226c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80226f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802272:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802276:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802279:	48 89 d6             	mov    %rdx,%rsi
  80227c:	89 c7                	mov    %eax,%edi
  80227e:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  802285:	00 00 00 
  802288:	ff d0                	callq  *%rax
  80228a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80228d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802291:	79 05                	jns    802298 <seek+0x34>
  802293:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802296:	eb 0f                	jmp    8022a7 <seek+0x43>
  802298:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80229c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80229f:	89 50 04             	mov    %edx,0x4(%rax)
  8022a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8022a7:	c9                   	leaveq 
  8022a8:	c3                   	retq   

00000000008022a9 <ftruncate>:
  8022a9:	55                   	push   %rbp
  8022aa:	48 89 e5             	mov    %rsp,%rbp
  8022ad:	48 83 ec 30          	sub    $0x30,%rsp
  8022b1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8022b4:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8022b7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8022bb:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8022be:	48 89 d6             	mov    %rdx,%rsi
  8022c1:	89 c7                	mov    %eax,%edi
  8022c3:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  8022ca:	00 00 00 
  8022cd:	ff d0                	callq  *%rax
  8022cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022d6:	78 24                	js     8022fc <ftruncate+0x53>
  8022d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022dc:	8b 00                	mov    (%rax),%eax
  8022de:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8022e2:	48 89 d6             	mov    %rdx,%rsi
  8022e5:	89 c7                	mov    %eax,%edi
  8022e7:	48 b8 6d 1d 80 00 00 	movabs $0x801d6d,%rax
  8022ee:	00 00 00 
  8022f1:	ff d0                	callq  *%rax
  8022f3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022fa:	79 05                	jns    802301 <ftruncate+0x58>
  8022fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022ff:	eb 72                	jmp    802373 <ftruncate+0xca>
  802301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802305:	8b 40 08             	mov    0x8(%rax),%eax
  802308:	83 e0 03             	and    $0x3,%eax
  80230b:	85 c0                	test   %eax,%eax
  80230d:	75 3a                	jne    802349 <ftruncate+0xa0>
  80230f:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802316:	00 00 00 
  802319:	48 8b 00             	mov    (%rax),%rax
  80231c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802322:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802325:	89 c6                	mov    %eax,%esi
  802327:	48 bf 50 45 80 00 00 	movabs $0x804550,%rdi
  80232e:	00 00 00 
  802331:	b8 00 00 00 00       	mov    $0x0,%eax
  802336:	48 b9 6a 02 80 00 00 	movabs $0x80026a,%rcx
  80233d:	00 00 00 
  802340:	ff d1                	callq  *%rcx
  802342:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802347:	eb 2a                	jmp    802373 <ftruncate+0xca>
  802349:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80234d:	48 8b 40 30          	mov    0x30(%rax),%rax
  802351:	48 85 c0             	test   %rax,%rax
  802354:	75 07                	jne    80235d <ftruncate+0xb4>
  802356:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80235b:	eb 16                	jmp    802373 <ftruncate+0xca>
  80235d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802361:	48 8b 40 30          	mov    0x30(%rax),%rax
  802365:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802369:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  80236c:	89 ce                	mov    %ecx,%esi
  80236e:	48 89 d7             	mov    %rdx,%rdi
  802371:	ff d0                	callq  *%rax
  802373:	c9                   	leaveq 
  802374:	c3                   	retq   

0000000000802375 <fstat>:
  802375:	55                   	push   %rbp
  802376:	48 89 e5             	mov    %rsp,%rbp
  802379:	48 83 ec 30          	sub    $0x30,%rsp
  80237d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802380:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802384:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802388:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80238b:	48 89 d6             	mov    %rdx,%rsi
  80238e:	89 c7                	mov    %eax,%edi
  802390:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  802397:	00 00 00 
  80239a:	ff d0                	callq  *%rax
  80239c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80239f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023a3:	78 24                	js     8023c9 <fstat+0x54>
  8023a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8023a9:	8b 00                	mov    (%rax),%eax
  8023ab:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8023af:	48 89 d6             	mov    %rdx,%rsi
  8023b2:	89 c7                	mov    %eax,%edi
  8023b4:	48 b8 6d 1d 80 00 00 	movabs $0x801d6d,%rax
  8023bb:	00 00 00 
  8023be:	ff d0                	callq  *%rax
  8023c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023c7:	79 05                	jns    8023ce <fstat+0x59>
  8023c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023cc:	eb 5e                	jmp    80242c <fstat+0xb7>
  8023ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023d2:	48 8b 40 28          	mov    0x28(%rax),%rax
  8023d6:	48 85 c0             	test   %rax,%rax
  8023d9:	75 07                	jne    8023e2 <fstat+0x6d>
  8023db:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8023e0:	eb 4a                	jmp    80242c <fstat+0xb7>
  8023e2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8023e6:	c6 00 00             	movb   $0x0,(%rax)
  8023e9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8023ed:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  8023f4:	00 00 00 
  8023f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8023fb:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802402:	00 00 00 
  802405:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802409:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80240d:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802414:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802418:	48 8b 40 28          	mov    0x28(%rax),%rax
  80241c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802420:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802424:	48 89 ce             	mov    %rcx,%rsi
  802427:	48 89 d7             	mov    %rdx,%rdi
  80242a:	ff d0                	callq  *%rax
  80242c:	c9                   	leaveq 
  80242d:	c3                   	retq   

000000000080242e <stat>:
  80242e:	55                   	push   %rbp
  80242f:	48 89 e5             	mov    %rsp,%rbp
  802432:	48 83 ec 20          	sub    $0x20,%rsp
  802436:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80243a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80243e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802442:	be 00 00 00 00       	mov    $0x0,%esi
  802447:	48 89 c7             	mov    %rax,%rdi
  80244a:	48 b8 1c 25 80 00 00 	movabs $0x80251c,%rax
  802451:	00 00 00 
  802454:	ff d0                	callq  *%rax
  802456:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802459:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80245d:	79 05                	jns    802464 <stat+0x36>
  80245f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802462:	eb 2f                	jmp    802493 <stat+0x65>
  802464:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802468:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80246b:	48 89 d6             	mov    %rdx,%rsi
  80246e:	89 c7                	mov    %eax,%edi
  802470:	48 b8 75 23 80 00 00 	movabs $0x802375,%rax
  802477:	00 00 00 
  80247a:	ff d0                	callq  *%rax
  80247c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80247f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802482:	89 c7                	mov    %eax,%edi
  802484:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  80248b:	00 00 00 
  80248e:	ff d0                	callq  *%rax
  802490:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802493:	c9                   	leaveq 
  802494:	c3                   	retq   

0000000000802495 <fsipc>:
  802495:	55                   	push   %rbp
  802496:	48 89 e5             	mov    %rsp,%rbp
  802499:	48 83 ec 10          	sub    $0x10,%rsp
  80249d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8024a0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8024a4:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8024ab:	00 00 00 
  8024ae:	8b 00                	mov    (%rax),%eax
  8024b0:	85 c0                	test   %eax,%eax
  8024b2:	75 1d                	jne    8024d1 <fsipc+0x3c>
  8024b4:	bf 01 00 00 00       	mov    $0x1,%edi
  8024b9:	48 b8 c1 3e 80 00 00 	movabs $0x803ec1,%rax
  8024c0:	00 00 00 
  8024c3:	ff d0                	callq  *%rax
  8024c5:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  8024cc:	00 00 00 
  8024cf:	89 02                	mov    %eax,(%rdx)
  8024d1:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8024d8:	00 00 00 
  8024db:	8b 00                	mov    (%rax),%eax
  8024dd:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8024e0:	b9 07 00 00 00       	mov    $0x7,%ecx
  8024e5:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  8024ec:	00 00 00 
  8024ef:	89 c7                	mov    %eax,%edi
  8024f1:	48 b8 b6 3d 80 00 00 	movabs $0x803db6,%rax
  8024f8:	00 00 00 
  8024fb:	ff d0                	callq  *%rax
  8024fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802501:	ba 00 00 00 00       	mov    $0x0,%edx
  802506:	48 89 c6             	mov    %rax,%rsi
  802509:	bf 00 00 00 00       	mov    $0x0,%edi
  80250e:	48 b8 f5 3c 80 00 00 	movabs $0x803cf5,%rax
  802515:	00 00 00 
  802518:	ff d0                	callq  *%rax
  80251a:	c9                   	leaveq 
  80251b:	c3                   	retq   

000000000080251c <open>:
  80251c:	55                   	push   %rbp
  80251d:	48 89 e5             	mov    %rsp,%rbp
  802520:	48 83 ec 20          	sub    $0x20,%rsp
  802524:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802528:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80252b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80252f:	48 89 c7             	mov    %rax,%rdi
  802532:	48 b8 b3 0d 80 00 00 	movabs $0x800db3,%rax
  802539:	00 00 00 
  80253c:	ff d0                	callq  *%rax
  80253e:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802543:	7e 0a                	jle    80254f <open+0x33>
  802545:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80254a:	e9 a5 00 00 00       	jmpq   8025f4 <open+0xd8>
  80254f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802553:	48 89 c7             	mov    %rax,%rdi
  802556:	48 b8 7c 1b 80 00 00 	movabs $0x801b7c,%rax
  80255d:	00 00 00 
  802560:	ff d0                	callq  *%rax
  802562:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802565:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802569:	79 08                	jns    802573 <open+0x57>
  80256b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80256e:	e9 81 00 00 00       	jmpq   8025f4 <open+0xd8>
  802573:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802577:	48 89 c6             	mov    %rax,%rsi
  80257a:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802581:	00 00 00 
  802584:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  80258b:	00 00 00 
  80258e:	ff d0                	callq  *%rax
  802590:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802597:	00 00 00 
  80259a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80259d:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8025a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025a7:	48 89 c6             	mov    %rax,%rsi
  8025aa:	bf 01 00 00 00       	mov    $0x1,%edi
  8025af:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  8025b6:	00 00 00 
  8025b9:	ff d0                	callq  *%rax
  8025bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025c2:	79 1d                	jns    8025e1 <open+0xc5>
  8025c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025c8:	be 00 00 00 00       	mov    $0x0,%esi
  8025cd:	48 89 c7             	mov    %rax,%rdi
  8025d0:	48 b8 a4 1c 80 00 00 	movabs $0x801ca4,%rax
  8025d7:	00 00 00 
  8025da:	ff d0                	callq  *%rax
  8025dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025df:	eb 13                	jmp    8025f4 <open+0xd8>
  8025e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025e5:	48 89 c7             	mov    %rax,%rdi
  8025e8:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  8025ef:	00 00 00 
  8025f2:	ff d0                	callq  *%rax
  8025f4:	c9                   	leaveq 
  8025f5:	c3                   	retq   

00000000008025f6 <devfile_flush>:
  8025f6:	55                   	push   %rbp
  8025f7:	48 89 e5             	mov    %rsp,%rbp
  8025fa:	48 83 ec 10          	sub    $0x10,%rsp
  8025fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802602:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802606:	8b 50 0c             	mov    0xc(%rax),%edx
  802609:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802610:	00 00 00 
  802613:	89 10                	mov    %edx,(%rax)
  802615:	be 00 00 00 00       	mov    $0x0,%esi
  80261a:	bf 06 00 00 00       	mov    $0x6,%edi
  80261f:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  802626:	00 00 00 
  802629:	ff d0                	callq  *%rax
  80262b:	c9                   	leaveq 
  80262c:	c3                   	retq   

000000000080262d <devfile_read>:
  80262d:	55                   	push   %rbp
  80262e:	48 89 e5             	mov    %rsp,%rbp
  802631:	48 83 ec 30          	sub    $0x30,%rsp
  802635:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802639:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80263d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802641:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802645:	8b 50 0c             	mov    0xc(%rax),%edx
  802648:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80264f:	00 00 00 
  802652:	89 10                	mov    %edx,(%rax)
  802654:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80265b:	00 00 00 
  80265e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802662:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802666:	be 00 00 00 00       	mov    $0x0,%esi
  80266b:	bf 03 00 00 00       	mov    $0x3,%edi
  802670:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  802677:	00 00 00 
  80267a:	ff d0                	callq  *%rax
  80267c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80267f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802683:	79 08                	jns    80268d <devfile_read+0x60>
  802685:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802688:	e9 a4 00 00 00       	jmpq   802731 <devfile_read+0x104>
  80268d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802690:	48 98                	cltq   
  802692:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802696:	76 35                	jbe    8026cd <devfile_read+0xa0>
  802698:	48 b9 76 45 80 00 00 	movabs $0x804576,%rcx
  80269f:	00 00 00 
  8026a2:	48 ba 7d 45 80 00 00 	movabs $0x80457d,%rdx
  8026a9:	00 00 00 
  8026ac:	be 89 00 00 00       	mov    $0x89,%esi
  8026b1:	48 bf 92 45 80 00 00 	movabs $0x804592,%rdi
  8026b8:	00 00 00 
  8026bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8026c0:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  8026c7:	00 00 00 
  8026ca:	41 ff d0             	callq  *%r8
  8026cd:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  8026d4:	7e 35                	jle    80270b <devfile_read+0xde>
  8026d6:	48 b9 a0 45 80 00 00 	movabs $0x8045a0,%rcx
  8026dd:	00 00 00 
  8026e0:	48 ba 7d 45 80 00 00 	movabs $0x80457d,%rdx
  8026e7:	00 00 00 
  8026ea:	be 8a 00 00 00       	mov    $0x8a,%esi
  8026ef:	48 bf 92 45 80 00 00 	movabs $0x804592,%rdi
  8026f6:	00 00 00 
  8026f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8026fe:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  802705:	00 00 00 
  802708:	41 ff d0             	callq  *%r8
  80270b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80270e:	48 63 d0             	movslq %eax,%rdx
  802711:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802715:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  80271c:	00 00 00 
  80271f:	48 89 c7             	mov    %rax,%rdi
  802722:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  802729:	00 00 00 
  80272c:	ff d0                	callq  *%rax
  80272e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802731:	c9                   	leaveq 
  802732:	c3                   	retq   

0000000000802733 <devfile_write>:
  802733:	55                   	push   %rbp
  802734:	48 89 e5             	mov    %rsp,%rbp
  802737:	48 83 ec 40          	sub    $0x40,%rsp
  80273b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80273f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802743:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802747:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80274b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80274f:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802756:	00 
  802757:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80275b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  80275f:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802764:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802768:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80276c:	8b 50 0c             	mov    0xc(%rax),%edx
  80276f:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802776:	00 00 00 
  802779:	89 10                	mov    %edx,(%rax)
  80277b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802782:	00 00 00 
  802785:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802789:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80278d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802791:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802795:	48 89 c6             	mov    %rax,%rsi
  802798:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  80279f:	00 00 00 
  8027a2:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  8027a9:	00 00 00 
  8027ac:	ff d0                	callq  *%rax
  8027ae:	be 00 00 00 00       	mov    $0x0,%esi
  8027b3:	bf 04 00 00 00       	mov    $0x4,%edi
  8027b8:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  8027bf:	00 00 00 
  8027c2:	ff d0                	callq  *%rax
  8027c4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8027c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8027cb:	79 05                	jns    8027d2 <devfile_write+0x9f>
  8027cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8027d0:	eb 43                	jmp    802815 <devfile_write+0xe2>
  8027d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8027d5:	48 98                	cltq   
  8027d7:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8027db:	76 35                	jbe    802812 <devfile_write+0xdf>
  8027dd:	48 b9 76 45 80 00 00 	movabs $0x804576,%rcx
  8027e4:	00 00 00 
  8027e7:	48 ba 7d 45 80 00 00 	movabs $0x80457d,%rdx
  8027ee:	00 00 00 
  8027f1:	be a8 00 00 00       	mov    $0xa8,%esi
  8027f6:	48 bf 92 45 80 00 00 	movabs $0x804592,%rdi
  8027fd:	00 00 00 
  802800:	b8 00 00 00 00       	mov    $0x0,%eax
  802805:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  80280c:	00 00 00 
  80280f:	41 ff d0             	callq  *%r8
  802812:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802815:	c9                   	leaveq 
  802816:	c3                   	retq   

0000000000802817 <devfile_stat>:
  802817:	55                   	push   %rbp
  802818:	48 89 e5             	mov    %rsp,%rbp
  80281b:	48 83 ec 20          	sub    $0x20,%rsp
  80281f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802823:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802827:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80282b:	8b 50 0c             	mov    0xc(%rax),%edx
  80282e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802835:	00 00 00 
  802838:	89 10                	mov    %edx,(%rax)
  80283a:	be 00 00 00 00       	mov    $0x0,%esi
  80283f:	bf 05 00 00 00       	mov    $0x5,%edi
  802844:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  80284b:	00 00 00 
  80284e:	ff d0                	callq  *%rax
  802850:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802853:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802857:	79 05                	jns    80285e <devfile_stat+0x47>
  802859:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80285c:	eb 56                	jmp    8028b4 <devfile_stat+0x9d>
  80285e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802862:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802869:	00 00 00 
  80286c:	48 89 c7             	mov    %rax,%rdi
  80286f:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  802876:	00 00 00 
  802879:	ff d0                	callq  *%rax
  80287b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802882:	00 00 00 
  802885:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  80288b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80288f:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802895:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80289c:	00 00 00 
  80289f:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  8028a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028a9:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  8028af:	b8 00 00 00 00       	mov    $0x0,%eax
  8028b4:	c9                   	leaveq 
  8028b5:	c3                   	retq   

00000000008028b6 <devfile_trunc>:
  8028b6:	55                   	push   %rbp
  8028b7:	48 89 e5             	mov    %rsp,%rbp
  8028ba:	48 83 ec 10          	sub    $0x10,%rsp
  8028be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8028c2:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8028c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8028c9:	8b 50 0c             	mov    0xc(%rax),%edx
  8028cc:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028d3:	00 00 00 
  8028d6:	89 10                	mov    %edx,(%rax)
  8028d8:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028df:	00 00 00 
  8028e2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8028e5:	89 50 04             	mov    %edx,0x4(%rax)
  8028e8:	be 00 00 00 00       	mov    $0x0,%esi
  8028ed:	bf 02 00 00 00       	mov    $0x2,%edi
  8028f2:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  8028f9:	00 00 00 
  8028fc:	ff d0                	callq  *%rax
  8028fe:	c9                   	leaveq 
  8028ff:	c3                   	retq   

0000000000802900 <remove>:
  802900:	55                   	push   %rbp
  802901:	48 89 e5             	mov    %rsp,%rbp
  802904:	48 83 ec 10          	sub    $0x10,%rsp
  802908:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80290c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802910:	48 89 c7             	mov    %rax,%rdi
  802913:	48 b8 b3 0d 80 00 00 	movabs $0x800db3,%rax
  80291a:	00 00 00 
  80291d:	ff d0                	callq  *%rax
  80291f:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802924:	7e 07                	jle    80292d <remove+0x2d>
  802926:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80292b:	eb 33                	jmp    802960 <remove+0x60>
  80292d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802931:	48 89 c6             	mov    %rax,%rsi
  802934:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  80293b:	00 00 00 
  80293e:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  802945:	00 00 00 
  802948:	ff d0                	callq  *%rax
  80294a:	be 00 00 00 00       	mov    $0x0,%esi
  80294f:	bf 07 00 00 00       	mov    $0x7,%edi
  802954:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  80295b:	00 00 00 
  80295e:	ff d0                	callq  *%rax
  802960:	c9                   	leaveq 
  802961:	c3                   	retq   

0000000000802962 <sync>:
  802962:	55                   	push   %rbp
  802963:	48 89 e5             	mov    %rsp,%rbp
  802966:	be 00 00 00 00       	mov    $0x0,%esi
  80296b:	bf 08 00 00 00       	mov    $0x8,%edi
  802970:	48 b8 95 24 80 00 00 	movabs $0x802495,%rax
  802977:	00 00 00 
  80297a:	ff d0                	callq  *%rax
  80297c:	5d                   	pop    %rbp
  80297d:	c3                   	retq   

000000000080297e <copy>:
  80297e:	55                   	push   %rbp
  80297f:	48 89 e5             	mov    %rsp,%rbp
  802982:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802989:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802990:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802997:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  80299e:	be 00 00 00 00       	mov    $0x0,%esi
  8029a3:	48 89 c7             	mov    %rax,%rdi
  8029a6:	48 b8 1c 25 80 00 00 	movabs $0x80251c,%rax
  8029ad:	00 00 00 
  8029b0:	ff d0                	callq  *%rax
  8029b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029b9:	79 28                	jns    8029e3 <copy+0x65>
  8029bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029be:	89 c6                	mov    %eax,%esi
  8029c0:	48 bf ac 45 80 00 00 	movabs $0x8045ac,%rdi
  8029c7:	00 00 00 
  8029ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8029cf:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  8029d6:	00 00 00 
  8029d9:	ff d2                	callq  *%rdx
  8029db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029de:	e9 74 01 00 00       	jmpq   802b57 <copy+0x1d9>
  8029e3:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  8029ea:	be 01 01 00 00       	mov    $0x101,%esi
  8029ef:	48 89 c7             	mov    %rax,%rdi
  8029f2:	48 b8 1c 25 80 00 00 	movabs $0x80251c,%rax
  8029f9:	00 00 00 
  8029fc:	ff d0                	callq  *%rax
  8029fe:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802a01:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802a05:	79 39                	jns    802a40 <copy+0xc2>
  802a07:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802a0a:	89 c6                	mov    %eax,%esi
  802a0c:	48 bf c2 45 80 00 00 	movabs $0x8045c2,%rdi
  802a13:	00 00 00 
  802a16:	b8 00 00 00 00       	mov    $0x0,%eax
  802a1b:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  802a22:	00 00 00 
  802a25:	ff d2                	callq  *%rdx
  802a27:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a2a:	89 c7                	mov    %eax,%edi
  802a2c:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802a33:	00 00 00 
  802a36:	ff d0                	callq  *%rax
  802a38:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802a3b:	e9 17 01 00 00       	jmpq   802b57 <copy+0x1d9>
  802a40:	eb 74                	jmp    802ab6 <copy+0x138>
  802a42:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802a45:	48 63 d0             	movslq %eax,%rdx
  802a48:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802a4f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802a52:	48 89 ce             	mov    %rcx,%rsi
  802a55:	89 c7                	mov    %eax,%edi
  802a57:	48 b8 90 21 80 00 00 	movabs $0x802190,%rax
  802a5e:	00 00 00 
  802a61:	ff d0                	callq  *%rax
  802a63:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802a66:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802a6a:	79 4a                	jns    802ab6 <copy+0x138>
  802a6c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802a6f:	89 c6                	mov    %eax,%esi
  802a71:	48 bf dc 45 80 00 00 	movabs $0x8045dc,%rdi
  802a78:	00 00 00 
  802a7b:	b8 00 00 00 00       	mov    $0x0,%eax
  802a80:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  802a87:	00 00 00 
  802a8a:	ff d2                	callq  *%rdx
  802a8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a8f:	89 c7                	mov    %eax,%edi
  802a91:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802a98:	00 00 00 
  802a9b:	ff d0                	callq  *%rax
  802a9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802aa0:	89 c7                	mov    %eax,%edi
  802aa2:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802aa9:	00 00 00 
  802aac:	ff d0                	callq  *%rax
  802aae:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802ab1:	e9 a1 00 00 00       	jmpq   802b57 <copy+0x1d9>
  802ab6:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802abd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ac0:	ba 00 02 00 00       	mov    $0x200,%edx
  802ac5:	48 89 ce             	mov    %rcx,%rsi
  802ac8:	89 c7                	mov    %eax,%edi
  802aca:	48 b8 46 20 80 00 00 	movabs $0x802046,%rax
  802ad1:	00 00 00 
  802ad4:	ff d0                	callq  *%rax
  802ad6:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802ad9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802add:	0f 8f 5f ff ff ff    	jg     802a42 <copy+0xc4>
  802ae3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802ae7:	79 47                	jns    802b30 <copy+0x1b2>
  802ae9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802aec:	89 c6                	mov    %eax,%esi
  802aee:	48 bf ef 45 80 00 00 	movabs $0x8045ef,%rdi
  802af5:	00 00 00 
  802af8:	b8 00 00 00 00       	mov    $0x0,%eax
  802afd:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  802b04:	00 00 00 
  802b07:	ff d2                	callq  *%rdx
  802b09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b0c:	89 c7                	mov    %eax,%edi
  802b0e:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802b15:	00 00 00 
  802b18:	ff d0                	callq  *%rax
  802b1a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b1d:	89 c7                	mov    %eax,%edi
  802b1f:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802b26:	00 00 00 
  802b29:	ff d0                	callq  *%rax
  802b2b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802b2e:	eb 27                	jmp    802b57 <copy+0x1d9>
  802b30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b33:	89 c7                	mov    %eax,%edi
  802b35:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802b3c:	00 00 00 
  802b3f:	ff d0                	callq  *%rax
  802b41:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b44:	89 c7                	mov    %eax,%edi
  802b46:	48 b8 24 1e 80 00 00 	movabs $0x801e24,%rax
  802b4d:	00 00 00 
  802b50:	ff d0                	callq  *%rax
  802b52:	b8 00 00 00 00       	mov    $0x0,%eax
  802b57:	c9                   	leaveq 
  802b58:	c3                   	retq   

0000000000802b59 <fd2sockid>:
  802b59:	55                   	push   %rbp
  802b5a:	48 89 e5             	mov    %rsp,%rbp
  802b5d:	48 83 ec 20          	sub    $0x20,%rsp
  802b61:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802b64:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802b6b:	48 89 d6             	mov    %rdx,%rsi
  802b6e:	89 c7                	mov    %eax,%edi
  802b70:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  802b77:	00 00 00 
  802b7a:	ff d0                	callq  *%rax
  802b7c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b83:	79 05                	jns    802b8a <fd2sockid+0x31>
  802b85:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b88:	eb 24                	jmp    802bae <fd2sockid+0x55>
  802b8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b8e:	8b 10                	mov    (%rax),%edx
  802b90:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  802b97:	00 00 00 
  802b9a:	8b 00                	mov    (%rax),%eax
  802b9c:	39 c2                	cmp    %eax,%edx
  802b9e:	74 07                	je     802ba7 <fd2sockid+0x4e>
  802ba0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802ba5:	eb 07                	jmp    802bae <fd2sockid+0x55>
  802ba7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bab:	8b 40 0c             	mov    0xc(%rax),%eax
  802bae:	c9                   	leaveq 
  802baf:	c3                   	retq   

0000000000802bb0 <alloc_sockfd>:
  802bb0:	55                   	push   %rbp
  802bb1:	48 89 e5             	mov    %rsp,%rbp
  802bb4:	48 83 ec 20          	sub    $0x20,%rsp
  802bb8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802bbb:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802bbf:	48 89 c7             	mov    %rax,%rdi
  802bc2:	48 b8 7c 1b 80 00 00 	movabs $0x801b7c,%rax
  802bc9:	00 00 00 
  802bcc:	ff d0                	callq  *%rax
  802bce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802bd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802bd5:	78 26                	js     802bfd <alloc_sockfd+0x4d>
  802bd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bdb:	ba 07 04 00 00       	mov    $0x407,%edx
  802be0:	48 89 c6             	mov    %rax,%rsi
  802be3:	bf 00 00 00 00       	mov    $0x0,%edi
  802be8:	48 b8 4e 17 80 00 00 	movabs $0x80174e,%rax
  802bef:	00 00 00 
  802bf2:	ff d0                	callq  *%rax
  802bf4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802bf7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802bfb:	79 16                	jns    802c13 <alloc_sockfd+0x63>
  802bfd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c00:	89 c7                	mov    %eax,%edi
  802c02:	48 b8 bd 30 80 00 00 	movabs $0x8030bd,%rax
  802c09:	00 00 00 
  802c0c:	ff d0                	callq  *%rax
  802c0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c11:	eb 3a                	jmp    802c4d <alloc_sockfd+0x9d>
  802c13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c17:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  802c1e:	00 00 00 
  802c21:	8b 12                	mov    (%rdx),%edx
  802c23:	89 10                	mov    %edx,(%rax)
  802c25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c29:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802c30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c34:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802c37:	89 50 0c             	mov    %edx,0xc(%rax)
  802c3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c3e:	48 89 c7             	mov    %rax,%rdi
  802c41:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  802c48:	00 00 00 
  802c4b:	ff d0                	callq  *%rax
  802c4d:	c9                   	leaveq 
  802c4e:	c3                   	retq   

0000000000802c4f <accept>:
  802c4f:	55                   	push   %rbp
  802c50:	48 89 e5             	mov    %rsp,%rbp
  802c53:	48 83 ec 30          	sub    $0x30,%rsp
  802c57:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802c5a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802c5e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802c62:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c65:	89 c7                	mov    %eax,%edi
  802c67:	48 b8 59 2b 80 00 00 	movabs $0x802b59,%rax
  802c6e:	00 00 00 
  802c71:	ff d0                	callq  *%rax
  802c73:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c7a:	79 05                	jns    802c81 <accept+0x32>
  802c7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c7f:	eb 3b                	jmp    802cbc <accept+0x6d>
  802c81:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802c85:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802c89:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c8c:	48 89 ce             	mov    %rcx,%rsi
  802c8f:	89 c7                	mov    %eax,%edi
  802c91:	48 b8 9a 2f 80 00 00 	movabs $0x802f9a,%rax
  802c98:	00 00 00 
  802c9b:	ff d0                	callq  *%rax
  802c9d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ca0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ca4:	79 05                	jns    802cab <accept+0x5c>
  802ca6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ca9:	eb 11                	jmp    802cbc <accept+0x6d>
  802cab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cae:	89 c7                	mov    %eax,%edi
  802cb0:	48 b8 b0 2b 80 00 00 	movabs $0x802bb0,%rax
  802cb7:	00 00 00 
  802cba:	ff d0                	callq  *%rax
  802cbc:	c9                   	leaveq 
  802cbd:	c3                   	retq   

0000000000802cbe <bind>:
  802cbe:	55                   	push   %rbp
  802cbf:	48 89 e5             	mov    %rsp,%rbp
  802cc2:	48 83 ec 20          	sub    $0x20,%rsp
  802cc6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802cc9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802ccd:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802cd0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802cd3:	89 c7                	mov    %eax,%edi
  802cd5:	48 b8 59 2b 80 00 00 	movabs $0x802b59,%rax
  802cdc:	00 00 00 
  802cdf:	ff d0                	callq  *%rax
  802ce1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ce4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ce8:	79 05                	jns    802cef <bind+0x31>
  802cea:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ced:	eb 1b                	jmp    802d0a <bind+0x4c>
  802cef:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802cf2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802cf6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cf9:	48 89 ce             	mov    %rcx,%rsi
  802cfc:	89 c7                	mov    %eax,%edi
  802cfe:	48 b8 19 30 80 00 00 	movabs $0x803019,%rax
  802d05:	00 00 00 
  802d08:	ff d0                	callq  *%rax
  802d0a:	c9                   	leaveq 
  802d0b:	c3                   	retq   

0000000000802d0c <shutdown>:
  802d0c:	55                   	push   %rbp
  802d0d:	48 89 e5             	mov    %rsp,%rbp
  802d10:	48 83 ec 20          	sub    $0x20,%rsp
  802d14:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d17:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802d1a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d1d:	89 c7                	mov    %eax,%edi
  802d1f:	48 b8 59 2b 80 00 00 	movabs $0x802b59,%rax
  802d26:	00 00 00 
  802d29:	ff d0                	callq  *%rax
  802d2b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d2e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d32:	79 05                	jns    802d39 <shutdown+0x2d>
  802d34:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d37:	eb 16                	jmp    802d4f <shutdown+0x43>
  802d39:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802d3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d3f:	89 d6                	mov    %edx,%esi
  802d41:	89 c7                	mov    %eax,%edi
  802d43:	48 b8 7d 30 80 00 00 	movabs $0x80307d,%rax
  802d4a:	00 00 00 
  802d4d:	ff d0                	callq  *%rax
  802d4f:	c9                   	leaveq 
  802d50:	c3                   	retq   

0000000000802d51 <devsock_close>:
  802d51:	55                   	push   %rbp
  802d52:	48 89 e5             	mov    %rsp,%rbp
  802d55:	48 83 ec 10          	sub    $0x10,%rsp
  802d59:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802d5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d61:	48 89 c7             	mov    %rax,%rdi
  802d64:	48 b8 33 3f 80 00 00 	movabs $0x803f33,%rax
  802d6b:	00 00 00 
  802d6e:	ff d0                	callq  *%rax
  802d70:	83 f8 01             	cmp    $0x1,%eax
  802d73:	75 17                	jne    802d8c <devsock_close+0x3b>
  802d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d79:	8b 40 0c             	mov    0xc(%rax),%eax
  802d7c:	89 c7                	mov    %eax,%edi
  802d7e:	48 b8 bd 30 80 00 00 	movabs $0x8030bd,%rax
  802d85:	00 00 00 
  802d88:	ff d0                	callq  *%rax
  802d8a:	eb 05                	jmp    802d91 <devsock_close+0x40>
  802d8c:	b8 00 00 00 00       	mov    $0x0,%eax
  802d91:	c9                   	leaveq 
  802d92:	c3                   	retq   

0000000000802d93 <connect>:
  802d93:	55                   	push   %rbp
  802d94:	48 89 e5             	mov    %rsp,%rbp
  802d97:	48 83 ec 20          	sub    $0x20,%rsp
  802d9b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d9e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802da2:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802da5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802da8:	89 c7                	mov    %eax,%edi
  802daa:	48 b8 59 2b 80 00 00 	movabs $0x802b59,%rax
  802db1:	00 00 00 
  802db4:	ff d0                	callq  *%rax
  802db6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802db9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dbd:	79 05                	jns    802dc4 <connect+0x31>
  802dbf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dc2:	eb 1b                	jmp    802ddf <connect+0x4c>
  802dc4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802dc7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802dcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dce:	48 89 ce             	mov    %rcx,%rsi
  802dd1:	89 c7                	mov    %eax,%edi
  802dd3:	48 b8 ea 30 80 00 00 	movabs $0x8030ea,%rax
  802dda:	00 00 00 
  802ddd:	ff d0                	callq  *%rax
  802ddf:	c9                   	leaveq 
  802de0:	c3                   	retq   

0000000000802de1 <listen>:
  802de1:	55                   	push   %rbp
  802de2:	48 89 e5             	mov    %rsp,%rbp
  802de5:	48 83 ec 20          	sub    $0x20,%rsp
  802de9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802dec:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802def:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802df2:	89 c7                	mov    %eax,%edi
  802df4:	48 b8 59 2b 80 00 00 	movabs $0x802b59,%rax
  802dfb:	00 00 00 
  802dfe:	ff d0                	callq  *%rax
  802e00:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e03:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e07:	79 05                	jns    802e0e <listen+0x2d>
  802e09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e0c:	eb 16                	jmp    802e24 <listen+0x43>
  802e0e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802e11:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e14:	89 d6                	mov    %edx,%esi
  802e16:	89 c7                	mov    %eax,%edi
  802e18:	48 b8 4e 31 80 00 00 	movabs $0x80314e,%rax
  802e1f:	00 00 00 
  802e22:	ff d0                	callq  *%rax
  802e24:	c9                   	leaveq 
  802e25:	c3                   	retq   

0000000000802e26 <devsock_read>:
  802e26:	55                   	push   %rbp
  802e27:	48 89 e5             	mov    %rsp,%rbp
  802e2a:	48 83 ec 20          	sub    $0x20,%rsp
  802e2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e32:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802e36:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802e3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e3e:	89 c2                	mov    %eax,%edx
  802e40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e44:	8b 40 0c             	mov    0xc(%rax),%eax
  802e47:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802e4b:	b9 00 00 00 00       	mov    $0x0,%ecx
  802e50:	89 c7                	mov    %eax,%edi
  802e52:	48 b8 8e 31 80 00 00 	movabs $0x80318e,%rax
  802e59:	00 00 00 
  802e5c:	ff d0                	callq  *%rax
  802e5e:	c9                   	leaveq 
  802e5f:	c3                   	retq   

0000000000802e60 <devsock_write>:
  802e60:	55                   	push   %rbp
  802e61:	48 89 e5             	mov    %rsp,%rbp
  802e64:	48 83 ec 20          	sub    $0x20,%rsp
  802e68:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e6c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802e70:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e78:	89 c2                	mov    %eax,%edx
  802e7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e7e:	8b 40 0c             	mov    0xc(%rax),%eax
  802e81:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802e85:	b9 00 00 00 00       	mov    $0x0,%ecx
  802e8a:	89 c7                	mov    %eax,%edi
  802e8c:	48 b8 5a 32 80 00 00 	movabs $0x80325a,%rax
  802e93:	00 00 00 
  802e96:	ff d0                	callq  *%rax
  802e98:	c9                   	leaveq 
  802e99:	c3                   	retq   

0000000000802e9a <devsock_stat>:
  802e9a:	55                   	push   %rbp
  802e9b:	48 89 e5             	mov    %rsp,%rbp
  802e9e:	48 83 ec 10          	sub    $0x10,%rsp
  802ea2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802ea6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802eaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eae:	48 be 0a 46 80 00 00 	movabs $0x80460a,%rsi
  802eb5:	00 00 00 
  802eb8:	48 89 c7             	mov    %rax,%rdi
  802ebb:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  802ec2:	00 00 00 
  802ec5:	ff d0                	callq  *%rax
  802ec7:	b8 00 00 00 00       	mov    $0x0,%eax
  802ecc:	c9                   	leaveq 
  802ecd:	c3                   	retq   

0000000000802ece <socket>:
  802ece:	55                   	push   %rbp
  802ecf:	48 89 e5             	mov    %rsp,%rbp
  802ed2:	48 83 ec 20          	sub    $0x20,%rsp
  802ed6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ed9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802edc:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  802edf:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802ee2:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  802ee5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802ee8:	89 ce                	mov    %ecx,%esi
  802eea:	89 c7                	mov    %eax,%edi
  802eec:	48 b8 12 33 80 00 00 	movabs $0x803312,%rax
  802ef3:	00 00 00 
  802ef6:	ff d0                	callq  *%rax
  802ef8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802efb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802eff:	79 05                	jns    802f06 <socket+0x38>
  802f01:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f04:	eb 11                	jmp    802f17 <socket+0x49>
  802f06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f09:	89 c7                	mov    %eax,%edi
  802f0b:	48 b8 b0 2b 80 00 00 	movabs $0x802bb0,%rax
  802f12:	00 00 00 
  802f15:	ff d0                	callq  *%rax
  802f17:	c9                   	leaveq 
  802f18:	c3                   	retq   

0000000000802f19 <nsipc>:
  802f19:	55                   	push   %rbp
  802f1a:	48 89 e5             	mov    %rsp,%rbp
  802f1d:	48 83 ec 10          	sub    $0x10,%rsp
  802f21:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802f24:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  802f2b:	00 00 00 
  802f2e:	8b 00                	mov    (%rax),%eax
  802f30:	85 c0                	test   %eax,%eax
  802f32:	75 1d                	jne    802f51 <nsipc+0x38>
  802f34:	bf 02 00 00 00       	mov    $0x2,%edi
  802f39:	48 b8 c1 3e 80 00 00 	movabs $0x803ec1,%rax
  802f40:	00 00 00 
  802f43:	ff d0                	callq  *%rax
  802f45:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  802f4c:	00 00 00 
  802f4f:	89 02                	mov    %eax,(%rdx)
  802f51:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  802f58:	00 00 00 
  802f5b:	8b 00                	mov    (%rax),%eax
  802f5d:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802f60:	b9 07 00 00 00       	mov    $0x7,%ecx
  802f65:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  802f6c:	00 00 00 
  802f6f:	89 c7                	mov    %eax,%edi
  802f71:	48 b8 b6 3d 80 00 00 	movabs $0x803db6,%rax
  802f78:	00 00 00 
  802f7b:	ff d0                	callq  *%rax
  802f7d:	ba 00 00 00 00       	mov    $0x0,%edx
  802f82:	be 00 00 00 00       	mov    $0x0,%esi
  802f87:	bf 00 00 00 00       	mov    $0x0,%edi
  802f8c:	48 b8 f5 3c 80 00 00 	movabs $0x803cf5,%rax
  802f93:	00 00 00 
  802f96:	ff d0                	callq  *%rax
  802f98:	c9                   	leaveq 
  802f99:	c3                   	retq   

0000000000802f9a <nsipc_accept>:
  802f9a:	55                   	push   %rbp
  802f9b:	48 89 e5             	mov    %rsp,%rbp
  802f9e:	48 83 ec 30          	sub    $0x30,%rsp
  802fa2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802fa5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802fa9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802fad:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802fb4:	00 00 00 
  802fb7:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802fba:	89 10                	mov    %edx,(%rax)
  802fbc:	bf 01 00 00 00       	mov    $0x1,%edi
  802fc1:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  802fc8:	00 00 00 
  802fcb:	ff d0                	callq  *%rax
  802fcd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fd0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fd4:	78 3e                	js     803014 <nsipc_accept+0x7a>
  802fd6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802fdd:	00 00 00 
  802fe0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802fe4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fe8:	8b 40 10             	mov    0x10(%rax),%eax
  802feb:	89 c2                	mov    %eax,%edx
  802fed:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  802ff1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ff5:	48 89 ce             	mov    %rcx,%rsi
  802ff8:	48 89 c7             	mov    %rax,%rdi
  802ffb:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  803002:	00 00 00 
  803005:	ff d0                	callq  *%rax
  803007:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80300b:	8b 50 10             	mov    0x10(%rax),%edx
  80300e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803012:	89 10                	mov    %edx,(%rax)
  803014:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803017:	c9                   	leaveq 
  803018:	c3                   	retq   

0000000000803019 <nsipc_bind>:
  803019:	55                   	push   %rbp
  80301a:	48 89 e5             	mov    %rsp,%rbp
  80301d:	48 83 ec 10          	sub    $0x10,%rsp
  803021:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803024:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803028:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80302b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803032:	00 00 00 
  803035:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803038:	89 10                	mov    %edx,(%rax)
  80303a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80303d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803041:	48 89 c6             	mov    %rax,%rsi
  803044:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  80304b:	00 00 00 
  80304e:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  803055:	00 00 00 
  803058:	ff d0                	callq  *%rax
  80305a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803061:	00 00 00 
  803064:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803067:	89 50 14             	mov    %edx,0x14(%rax)
  80306a:	bf 02 00 00 00       	mov    $0x2,%edi
  80306f:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  803076:	00 00 00 
  803079:	ff d0                	callq  *%rax
  80307b:	c9                   	leaveq 
  80307c:	c3                   	retq   

000000000080307d <nsipc_shutdown>:
  80307d:	55                   	push   %rbp
  80307e:	48 89 e5             	mov    %rsp,%rbp
  803081:	48 83 ec 10          	sub    $0x10,%rsp
  803085:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803088:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80308b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803092:	00 00 00 
  803095:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803098:	89 10                	mov    %edx,(%rax)
  80309a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8030a1:	00 00 00 
  8030a4:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8030a7:	89 50 04             	mov    %edx,0x4(%rax)
  8030aa:	bf 03 00 00 00       	mov    $0x3,%edi
  8030af:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  8030b6:	00 00 00 
  8030b9:	ff d0                	callq  *%rax
  8030bb:	c9                   	leaveq 
  8030bc:	c3                   	retq   

00000000008030bd <nsipc_close>:
  8030bd:	55                   	push   %rbp
  8030be:	48 89 e5             	mov    %rsp,%rbp
  8030c1:	48 83 ec 10          	sub    $0x10,%rsp
  8030c5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8030c8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8030cf:	00 00 00 
  8030d2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8030d5:	89 10                	mov    %edx,(%rax)
  8030d7:	bf 04 00 00 00       	mov    $0x4,%edi
  8030dc:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  8030e3:	00 00 00 
  8030e6:	ff d0                	callq  *%rax
  8030e8:	c9                   	leaveq 
  8030e9:	c3                   	retq   

00000000008030ea <nsipc_connect>:
  8030ea:	55                   	push   %rbp
  8030eb:	48 89 e5             	mov    %rsp,%rbp
  8030ee:	48 83 ec 10          	sub    $0x10,%rsp
  8030f2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8030f5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8030f9:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8030fc:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803103:	00 00 00 
  803106:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803109:	89 10                	mov    %edx,(%rax)
  80310b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80310e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803112:	48 89 c6             	mov    %rax,%rsi
  803115:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  80311c:	00 00 00 
  80311f:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  803126:	00 00 00 
  803129:	ff d0                	callq  *%rax
  80312b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803132:	00 00 00 
  803135:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803138:	89 50 14             	mov    %edx,0x14(%rax)
  80313b:	bf 05 00 00 00       	mov    $0x5,%edi
  803140:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  803147:	00 00 00 
  80314a:	ff d0                	callq  *%rax
  80314c:	c9                   	leaveq 
  80314d:	c3                   	retq   

000000000080314e <nsipc_listen>:
  80314e:	55                   	push   %rbp
  80314f:	48 89 e5             	mov    %rsp,%rbp
  803152:	48 83 ec 10          	sub    $0x10,%rsp
  803156:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803159:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80315c:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803163:	00 00 00 
  803166:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803169:	89 10                	mov    %edx,(%rax)
  80316b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803172:	00 00 00 
  803175:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803178:	89 50 04             	mov    %edx,0x4(%rax)
  80317b:	bf 06 00 00 00       	mov    $0x6,%edi
  803180:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  803187:	00 00 00 
  80318a:	ff d0                	callq  *%rax
  80318c:	c9                   	leaveq 
  80318d:	c3                   	retq   

000000000080318e <nsipc_recv>:
  80318e:	55                   	push   %rbp
  80318f:	48 89 e5             	mov    %rsp,%rbp
  803192:	48 83 ec 30          	sub    $0x30,%rsp
  803196:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803199:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80319d:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8031a0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8031a3:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8031aa:	00 00 00 
  8031ad:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8031b0:	89 10                	mov    %edx,(%rax)
  8031b2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8031b9:	00 00 00 
  8031bc:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8031bf:	89 50 04             	mov    %edx,0x4(%rax)
  8031c2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8031c9:	00 00 00 
  8031cc:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8031cf:	89 50 08             	mov    %edx,0x8(%rax)
  8031d2:	bf 07 00 00 00       	mov    $0x7,%edi
  8031d7:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  8031de:	00 00 00 
  8031e1:	ff d0                	callq  *%rax
  8031e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031ea:	78 69                	js     803255 <nsipc_recv+0xc7>
  8031ec:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  8031f3:	7f 08                	jg     8031fd <nsipc_recv+0x6f>
  8031f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031f8:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  8031fb:	7e 35                	jle    803232 <nsipc_recv+0xa4>
  8031fd:	48 b9 11 46 80 00 00 	movabs $0x804611,%rcx
  803204:	00 00 00 
  803207:	48 ba 26 46 80 00 00 	movabs $0x804626,%rdx
  80320e:	00 00 00 
  803211:	be 62 00 00 00       	mov    $0x62,%esi
  803216:	48 bf 3b 46 80 00 00 	movabs $0x80463b,%rdi
  80321d:	00 00 00 
  803220:	b8 00 00 00 00       	mov    $0x0,%eax
  803225:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  80322c:	00 00 00 
  80322f:	41 ff d0             	callq  *%r8
  803232:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803235:	48 63 d0             	movslq %eax,%rdx
  803238:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80323c:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  803243:	00 00 00 
  803246:	48 89 c7             	mov    %rax,%rdi
  803249:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  803250:	00 00 00 
  803253:	ff d0                	callq  *%rax
  803255:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803258:	c9                   	leaveq 
  803259:	c3                   	retq   

000000000080325a <nsipc_send>:
  80325a:	55                   	push   %rbp
  80325b:	48 89 e5             	mov    %rsp,%rbp
  80325e:	48 83 ec 20          	sub    $0x20,%rsp
  803262:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803265:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803269:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80326c:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80326f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803276:	00 00 00 
  803279:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80327c:	89 10                	mov    %edx,(%rax)
  80327e:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803285:	7e 35                	jle    8032bc <nsipc_send+0x62>
  803287:	48 b9 4a 46 80 00 00 	movabs $0x80464a,%rcx
  80328e:	00 00 00 
  803291:	48 ba 26 46 80 00 00 	movabs $0x804626,%rdx
  803298:	00 00 00 
  80329b:	be 6d 00 00 00       	mov    $0x6d,%esi
  8032a0:	48 bf 3b 46 80 00 00 	movabs $0x80463b,%rdi
  8032a7:	00 00 00 
  8032aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8032af:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  8032b6:	00 00 00 
  8032b9:	41 ff d0             	callq  *%r8
  8032bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8032bf:	48 63 d0             	movslq %eax,%rdx
  8032c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032c6:	48 89 c6             	mov    %rax,%rsi
  8032c9:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  8032d0:	00 00 00 
  8032d3:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  8032da:	00 00 00 
  8032dd:	ff d0                	callq  *%rax
  8032df:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032e6:	00 00 00 
  8032e9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8032ec:	89 50 04             	mov    %edx,0x4(%rax)
  8032ef:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032f6:	00 00 00 
  8032f9:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8032fc:	89 50 08             	mov    %edx,0x8(%rax)
  8032ff:	bf 08 00 00 00       	mov    $0x8,%edi
  803304:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  80330b:	00 00 00 
  80330e:	ff d0                	callq  *%rax
  803310:	c9                   	leaveq 
  803311:	c3                   	retq   

0000000000803312 <nsipc_socket>:
  803312:	55                   	push   %rbp
  803313:	48 89 e5             	mov    %rsp,%rbp
  803316:	48 83 ec 10          	sub    $0x10,%rsp
  80331a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80331d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803320:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803323:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80332a:	00 00 00 
  80332d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803330:	89 10                	mov    %edx,(%rax)
  803332:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803339:	00 00 00 
  80333c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80333f:	89 50 04             	mov    %edx,0x4(%rax)
  803342:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803349:	00 00 00 
  80334c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80334f:	89 50 08             	mov    %edx,0x8(%rax)
  803352:	bf 09 00 00 00       	mov    $0x9,%edi
  803357:	48 b8 19 2f 80 00 00 	movabs $0x802f19,%rax
  80335e:	00 00 00 
  803361:	ff d0                	callq  *%rax
  803363:	c9                   	leaveq 
  803364:	c3                   	retq   

0000000000803365 <pipe>:
  803365:	55                   	push   %rbp
  803366:	48 89 e5             	mov    %rsp,%rbp
  803369:	53                   	push   %rbx
  80336a:	48 83 ec 38          	sub    $0x38,%rsp
  80336e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803372:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803376:	48 89 c7             	mov    %rax,%rdi
  803379:	48 b8 7c 1b 80 00 00 	movabs $0x801b7c,%rax
  803380:	00 00 00 
  803383:	ff d0                	callq  *%rax
  803385:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803388:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80338c:	0f 88 bf 01 00 00    	js     803551 <pipe+0x1ec>
  803392:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803396:	ba 07 04 00 00       	mov    $0x407,%edx
  80339b:	48 89 c6             	mov    %rax,%rsi
  80339e:	bf 00 00 00 00       	mov    $0x0,%edi
  8033a3:	48 b8 4e 17 80 00 00 	movabs $0x80174e,%rax
  8033aa:	00 00 00 
  8033ad:	ff d0                	callq  *%rax
  8033af:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8033b2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8033b6:	0f 88 95 01 00 00    	js     803551 <pipe+0x1ec>
  8033bc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8033c0:	48 89 c7             	mov    %rax,%rdi
  8033c3:	48 b8 7c 1b 80 00 00 	movabs $0x801b7c,%rax
  8033ca:	00 00 00 
  8033cd:	ff d0                	callq  *%rax
  8033cf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8033d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8033d6:	0f 88 5d 01 00 00    	js     803539 <pipe+0x1d4>
  8033dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8033e0:	ba 07 04 00 00       	mov    $0x407,%edx
  8033e5:	48 89 c6             	mov    %rax,%rsi
  8033e8:	bf 00 00 00 00       	mov    $0x0,%edi
  8033ed:	48 b8 4e 17 80 00 00 	movabs $0x80174e,%rax
  8033f4:	00 00 00 
  8033f7:	ff d0                	callq  *%rax
  8033f9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8033fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803400:	0f 88 33 01 00 00    	js     803539 <pipe+0x1d4>
  803406:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80340a:	48 89 c7             	mov    %rax,%rdi
  80340d:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  803414:	00 00 00 
  803417:	ff d0                	callq  *%rax
  803419:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80341d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803421:	ba 07 04 00 00       	mov    $0x407,%edx
  803426:	48 89 c6             	mov    %rax,%rsi
  803429:	bf 00 00 00 00       	mov    $0x0,%edi
  80342e:	48 b8 4e 17 80 00 00 	movabs $0x80174e,%rax
  803435:	00 00 00 
  803438:	ff d0                	callq  *%rax
  80343a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80343d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803441:	79 05                	jns    803448 <pipe+0xe3>
  803443:	e9 d9 00 00 00       	jmpq   803521 <pipe+0x1bc>
  803448:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80344c:	48 89 c7             	mov    %rax,%rdi
  80344f:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  803456:	00 00 00 
  803459:	ff d0                	callq  *%rax
  80345b:	48 89 c2             	mov    %rax,%rdx
  80345e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803462:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803468:	48 89 d1             	mov    %rdx,%rcx
  80346b:	ba 00 00 00 00       	mov    $0x0,%edx
  803470:	48 89 c6             	mov    %rax,%rsi
  803473:	bf 00 00 00 00       	mov    $0x0,%edi
  803478:	48 b8 9e 17 80 00 00 	movabs $0x80179e,%rax
  80347f:	00 00 00 
  803482:	ff d0                	callq  *%rax
  803484:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803487:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80348b:	79 1b                	jns    8034a8 <pipe+0x143>
  80348d:	90                   	nop
  80348e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803492:	48 89 c6             	mov    %rax,%rsi
  803495:	bf 00 00 00 00       	mov    $0x0,%edi
  80349a:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  8034a1:	00 00 00 
  8034a4:	ff d0                	callq  *%rax
  8034a6:	eb 79                	jmp    803521 <pipe+0x1bc>
  8034a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8034ac:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  8034b3:	00 00 00 
  8034b6:	8b 12                	mov    (%rdx),%edx
  8034b8:	89 10                	mov    %edx,(%rax)
  8034ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8034be:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  8034c5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8034c9:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  8034d0:	00 00 00 
  8034d3:	8b 12                	mov    (%rdx),%edx
  8034d5:	89 10                	mov    %edx,(%rax)
  8034d7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8034db:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8034e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8034e6:	48 89 c7             	mov    %rax,%rdi
  8034e9:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  8034f0:	00 00 00 
  8034f3:	ff d0                	callq  *%rax
  8034f5:	89 c2                	mov    %eax,%edx
  8034f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8034fb:	89 10                	mov    %edx,(%rax)
  8034fd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803501:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803505:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803509:	48 89 c7             	mov    %rax,%rdi
  80350c:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  803513:	00 00 00 
  803516:	ff d0                	callq  *%rax
  803518:	89 03                	mov    %eax,(%rbx)
  80351a:	b8 00 00 00 00       	mov    $0x0,%eax
  80351f:	eb 33                	jmp    803554 <pipe+0x1ef>
  803521:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803525:	48 89 c6             	mov    %rax,%rsi
  803528:	bf 00 00 00 00       	mov    $0x0,%edi
  80352d:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  803534:	00 00 00 
  803537:	ff d0                	callq  *%rax
  803539:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80353d:	48 89 c6             	mov    %rax,%rsi
  803540:	bf 00 00 00 00       	mov    $0x0,%edi
  803545:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  80354c:	00 00 00 
  80354f:	ff d0                	callq  *%rax
  803551:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803554:	48 83 c4 38          	add    $0x38,%rsp
  803558:	5b                   	pop    %rbx
  803559:	5d                   	pop    %rbp
  80355a:	c3                   	retq   

000000000080355b <_pipeisclosed>:
  80355b:	55                   	push   %rbp
  80355c:	48 89 e5             	mov    %rsp,%rbp
  80355f:	53                   	push   %rbx
  803560:	48 83 ec 28          	sub    $0x28,%rsp
  803564:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803568:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80356c:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803573:	00 00 00 
  803576:	48 8b 00             	mov    (%rax),%rax
  803579:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80357f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803582:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803586:	48 89 c7             	mov    %rax,%rdi
  803589:	48 b8 33 3f 80 00 00 	movabs $0x803f33,%rax
  803590:	00 00 00 
  803593:	ff d0                	callq  *%rax
  803595:	89 c3                	mov    %eax,%ebx
  803597:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80359b:	48 89 c7             	mov    %rax,%rdi
  80359e:	48 b8 33 3f 80 00 00 	movabs $0x803f33,%rax
  8035a5:	00 00 00 
  8035a8:	ff d0                	callq  *%rax
  8035aa:	39 c3                	cmp    %eax,%ebx
  8035ac:	0f 94 c0             	sete   %al
  8035af:	0f b6 c0             	movzbl %al,%eax
  8035b2:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8035b5:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8035bc:	00 00 00 
  8035bf:	48 8b 00             	mov    (%rax),%rax
  8035c2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8035c8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8035cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035ce:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8035d1:	75 05                	jne    8035d8 <_pipeisclosed+0x7d>
  8035d3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8035d6:	eb 4f                	jmp    803627 <_pipeisclosed+0xcc>
  8035d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035db:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8035de:	74 42                	je     803622 <_pipeisclosed+0xc7>
  8035e0:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8035e4:	75 3c                	jne    803622 <_pipeisclosed+0xc7>
  8035e6:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8035ed:	00 00 00 
  8035f0:	48 8b 00             	mov    (%rax),%rax
  8035f3:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  8035f9:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8035fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035ff:	89 c6                	mov    %eax,%esi
  803601:	48 bf 5b 46 80 00 00 	movabs $0x80465b,%rdi
  803608:	00 00 00 
  80360b:	b8 00 00 00 00       	mov    $0x0,%eax
  803610:	49 b8 6a 02 80 00 00 	movabs $0x80026a,%r8
  803617:	00 00 00 
  80361a:	41 ff d0             	callq  *%r8
  80361d:	e9 4a ff ff ff       	jmpq   80356c <_pipeisclosed+0x11>
  803622:	e9 45 ff ff ff       	jmpq   80356c <_pipeisclosed+0x11>
  803627:	48 83 c4 28          	add    $0x28,%rsp
  80362b:	5b                   	pop    %rbx
  80362c:	5d                   	pop    %rbp
  80362d:	c3                   	retq   

000000000080362e <pipeisclosed>:
  80362e:	55                   	push   %rbp
  80362f:	48 89 e5             	mov    %rsp,%rbp
  803632:	48 83 ec 30          	sub    $0x30,%rsp
  803636:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803639:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80363d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803640:	48 89 d6             	mov    %rdx,%rsi
  803643:	89 c7                	mov    %eax,%edi
  803645:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  80364c:	00 00 00 
  80364f:	ff d0                	callq  *%rax
  803651:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803654:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803658:	79 05                	jns    80365f <pipeisclosed+0x31>
  80365a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80365d:	eb 31                	jmp    803690 <pipeisclosed+0x62>
  80365f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803663:	48 89 c7             	mov    %rax,%rdi
  803666:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  80366d:	00 00 00 
  803670:	ff d0                	callq  *%rax
  803672:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803676:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80367a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80367e:	48 89 d6             	mov    %rdx,%rsi
  803681:	48 89 c7             	mov    %rax,%rdi
  803684:	48 b8 5b 35 80 00 00 	movabs $0x80355b,%rax
  80368b:	00 00 00 
  80368e:	ff d0                	callq  *%rax
  803690:	c9                   	leaveq 
  803691:	c3                   	retq   

0000000000803692 <devpipe_read>:
  803692:	55                   	push   %rbp
  803693:	48 89 e5             	mov    %rsp,%rbp
  803696:	48 83 ec 40          	sub    $0x40,%rsp
  80369a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80369e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8036a2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8036a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8036aa:	48 89 c7             	mov    %rax,%rdi
  8036ad:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  8036b4:	00 00 00 
  8036b7:	ff d0                	callq  *%rax
  8036b9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8036bd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8036c1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8036c5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8036cc:	00 
  8036cd:	e9 92 00 00 00       	jmpq   803764 <devpipe_read+0xd2>
  8036d2:	eb 41                	jmp    803715 <devpipe_read+0x83>
  8036d4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  8036d9:	74 09                	je     8036e4 <devpipe_read+0x52>
  8036db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8036df:	e9 92 00 00 00       	jmpq   803776 <devpipe_read+0xe4>
  8036e4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8036e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8036ec:	48 89 d6             	mov    %rdx,%rsi
  8036ef:	48 89 c7             	mov    %rax,%rdi
  8036f2:	48 b8 5b 35 80 00 00 	movabs $0x80355b,%rax
  8036f9:	00 00 00 
  8036fc:	ff d0                	callq  *%rax
  8036fe:	85 c0                	test   %eax,%eax
  803700:	74 07                	je     803709 <devpipe_read+0x77>
  803702:	b8 00 00 00 00       	mov    $0x0,%eax
  803707:	eb 6d                	jmp    803776 <devpipe_read+0xe4>
  803709:	48 b8 10 17 80 00 00 	movabs $0x801710,%rax
  803710:	00 00 00 
  803713:	ff d0                	callq  *%rax
  803715:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803719:	8b 10                	mov    (%rax),%edx
  80371b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80371f:	8b 40 04             	mov    0x4(%rax),%eax
  803722:	39 c2                	cmp    %eax,%edx
  803724:	74 ae                	je     8036d4 <devpipe_read+0x42>
  803726:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80372a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80372e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  803732:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803736:	8b 00                	mov    (%rax),%eax
  803738:	99                   	cltd   
  803739:	c1 ea 1b             	shr    $0x1b,%edx
  80373c:	01 d0                	add    %edx,%eax
  80373e:	83 e0 1f             	and    $0x1f,%eax
  803741:	29 d0                	sub    %edx,%eax
  803743:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803747:	48 98                	cltq   
  803749:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  80374e:	88 01                	mov    %al,(%rcx)
  803750:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803754:	8b 00                	mov    (%rax),%eax
  803756:	8d 50 01             	lea    0x1(%rax),%edx
  803759:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80375d:	89 10                	mov    %edx,(%rax)
  80375f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803764:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803768:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80376c:	0f 82 60 ff ff ff    	jb     8036d2 <devpipe_read+0x40>
  803772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803776:	c9                   	leaveq 
  803777:	c3                   	retq   

0000000000803778 <devpipe_write>:
  803778:	55                   	push   %rbp
  803779:	48 89 e5             	mov    %rsp,%rbp
  80377c:	48 83 ec 40          	sub    $0x40,%rsp
  803780:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803784:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803788:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80378c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803790:	48 89 c7             	mov    %rax,%rdi
  803793:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  80379a:	00 00 00 
  80379d:	ff d0                	callq  *%rax
  80379f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8037a3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8037a7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8037ab:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8037b2:	00 
  8037b3:	e9 8e 00 00 00       	jmpq   803846 <devpipe_write+0xce>
  8037b8:	eb 31                	jmp    8037eb <devpipe_write+0x73>
  8037ba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8037be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8037c2:	48 89 d6             	mov    %rdx,%rsi
  8037c5:	48 89 c7             	mov    %rax,%rdi
  8037c8:	48 b8 5b 35 80 00 00 	movabs $0x80355b,%rax
  8037cf:	00 00 00 
  8037d2:	ff d0                	callq  *%rax
  8037d4:	85 c0                	test   %eax,%eax
  8037d6:	74 07                	je     8037df <devpipe_write+0x67>
  8037d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8037dd:	eb 79                	jmp    803858 <devpipe_write+0xe0>
  8037df:	48 b8 10 17 80 00 00 	movabs $0x801710,%rax
  8037e6:	00 00 00 
  8037e9:	ff d0                	callq  *%rax
  8037eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037ef:	8b 40 04             	mov    0x4(%rax),%eax
  8037f2:	48 63 d0             	movslq %eax,%rdx
  8037f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037f9:	8b 00                	mov    (%rax),%eax
  8037fb:	48 98                	cltq   
  8037fd:	48 83 c0 20          	add    $0x20,%rax
  803801:	48 39 c2             	cmp    %rax,%rdx
  803804:	73 b4                	jae    8037ba <devpipe_write+0x42>
  803806:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80380a:	8b 40 04             	mov    0x4(%rax),%eax
  80380d:	99                   	cltd   
  80380e:	c1 ea 1b             	shr    $0x1b,%edx
  803811:	01 d0                	add    %edx,%eax
  803813:	83 e0 1f             	and    $0x1f,%eax
  803816:	29 d0                	sub    %edx,%eax
  803818:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80381c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803820:	48 01 ca             	add    %rcx,%rdx
  803823:	0f b6 0a             	movzbl (%rdx),%ecx
  803826:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80382a:	48 98                	cltq   
  80382c:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803830:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803834:	8b 40 04             	mov    0x4(%rax),%eax
  803837:	8d 50 01             	lea    0x1(%rax),%edx
  80383a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80383e:	89 50 04             	mov    %edx,0x4(%rax)
  803841:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803846:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80384a:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80384e:	0f 82 64 ff ff ff    	jb     8037b8 <devpipe_write+0x40>
  803854:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803858:	c9                   	leaveq 
  803859:	c3                   	retq   

000000000080385a <devpipe_stat>:
  80385a:	55                   	push   %rbp
  80385b:	48 89 e5             	mov    %rsp,%rbp
  80385e:	48 83 ec 20          	sub    $0x20,%rsp
  803862:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803866:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80386a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80386e:	48 89 c7             	mov    %rax,%rdi
  803871:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  803878:	00 00 00 
  80387b:	ff d0                	callq  *%rax
  80387d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803881:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803885:	48 be 6e 46 80 00 00 	movabs $0x80466e,%rsi
  80388c:	00 00 00 
  80388f:	48 89 c7             	mov    %rax,%rdi
  803892:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  803899:	00 00 00 
  80389c:	ff d0                	callq  *%rax
  80389e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038a2:	8b 50 04             	mov    0x4(%rax),%edx
  8038a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038a9:	8b 00                	mov    (%rax),%eax
  8038ab:	29 c2                	sub    %eax,%edx
  8038ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8038b1:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8038b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8038bb:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  8038c2:	00 00 00 
  8038c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8038c9:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  8038d0:	00 00 00 
  8038d3:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  8038da:	b8 00 00 00 00       	mov    $0x0,%eax
  8038df:	c9                   	leaveq 
  8038e0:	c3                   	retq   

00000000008038e1 <devpipe_close>:
  8038e1:	55                   	push   %rbp
  8038e2:	48 89 e5             	mov    %rsp,%rbp
  8038e5:	48 83 ec 10          	sub    $0x10,%rsp
  8038e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8038ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038f1:	48 89 c6             	mov    %rax,%rsi
  8038f4:	bf 00 00 00 00       	mov    $0x0,%edi
  8038f9:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  803900:	00 00 00 
  803903:	ff d0                	callq  *%rax
  803905:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803909:	48 89 c7             	mov    %rax,%rdi
  80390c:	48 b8 51 1b 80 00 00 	movabs $0x801b51,%rax
  803913:	00 00 00 
  803916:	ff d0                	callq  *%rax
  803918:	48 89 c6             	mov    %rax,%rsi
  80391b:	bf 00 00 00 00       	mov    $0x0,%edi
  803920:	48 b8 f9 17 80 00 00 	movabs $0x8017f9,%rax
  803927:	00 00 00 
  80392a:	ff d0                	callq  *%rax
  80392c:	c9                   	leaveq 
  80392d:	c3                   	retq   

000000000080392e <cputchar>:
  80392e:	55                   	push   %rbp
  80392f:	48 89 e5             	mov    %rsp,%rbp
  803932:	48 83 ec 20          	sub    $0x20,%rsp
  803936:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803939:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80393c:	88 45 ff             	mov    %al,-0x1(%rbp)
  80393f:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  803943:	be 01 00 00 00       	mov    $0x1,%esi
  803948:	48 89 c7             	mov    %rax,%rdi
  80394b:	48 b8 06 16 80 00 00 	movabs $0x801606,%rax
  803952:	00 00 00 
  803955:	ff d0                	callq  *%rax
  803957:	c9                   	leaveq 
  803958:	c3                   	retq   

0000000000803959 <getchar>:
  803959:	55                   	push   %rbp
  80395a:	48 89 e5             	mov    %rsp,%rbp
  80395d:	48 83 ec 10          	sub    $0x10,%rsp
  803961:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  803965:	ba 01 00 00 00       	mov    $0x1,%edx
  80396a:	48 89 c6             	mov    %rax,%rsi
  80396d:	bf 00 00 00 00       	mov    $0x0,%edi
  803972:	48 b8 46 20 80 00 00 	movabs $0x802046,%rax
  803979:	00 00 00 
  80397c:	ff d0                	callq  *%rax
  80397e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803981:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803985:	79 05                	jns    80398c <getchar+0x33>
  803987:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80398a:	eb 14                	jmp    8039a0 <getchar+0x47>
  80398c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803990:	7f 07                	jg     803999 <getchar+0x40>
  803992:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  803997:	eb 07                	jmp    8039a0 <getchar+0x47>
  803999:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  80399d:	0f b6 c0             	movzbl %al,%eax
  8039a0:	c9                   	leaveq 
  8039a1:	c3                   	retq   

00000000008039a2 <iscons>:
  8039a2:	55                   	push   %rbp
  8039a3:	48 89 e5             	mov    %rsp,%rbp
  8039a6:	48 83 ec 20          	sub    $0x20,%rsp
  8039aa:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039ad:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8039b1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039b4:	48 89 d6             	mov    %rdx,%rsi
  8039b7:	89 c7                	mov    %eax,%edi
  8039b9:	48 b8 14 1c 80 00 00 	movabs $0x801c14,%rax
  8039c0:	00 00 00 
  8039c3:	ff d0                	callq  *%rax
  8039c5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039cc:	79 05                	jns    8039d3 <iscons+0x31>
  8039ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039d1:	eb 1a                	jmp    8039ed <iscons+0x4b>
  8039d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039d7:	8b 10                	mov    (%rax),%edx
  8039d9:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  8039e0:	00 00 00 
  8039e3:	8b 00                	mov    (%rax),%eax
  8039e5:	39 c2                	cmp    %eax,%edx
  8039e7:	0f 94 c0             	sete   %al
  8039ea:	0f b6 c0             	movzbl %al,%eax
  8039ed:	c9                   	leaveq 
  8039ee:	c3                   	retq   

00000000008039ef <opencons>:
  8039ef:	55                   	push   %rbp
  8039f0:	48 89 e5             	mov    %rsp,%rbp
  8039f3:	48 83 ec 10          	sub    $0x10,%rsp
  8039f7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8039fb:	48 89 c7             	mov    %rax,%rdi
  8039fe:	48 b8 7c 1b 80 00 00 	movabs $0x801b7c,%rax
  803a05:	00 00 00 
  803a08:	ff d0                	callq  *%rax
  803a0a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a0d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a11:	79 05                	jns    803a18 <opencons+0x29>
  803a13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a16:	eb 5b                	jmp    803a73 <opencons+0x84>
  803a18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a1c:	ba 07 04 00 00       	mov    $0x407,%edx
  803a21:	48 89 c6             	mov    %rax,%rsi
  803a24:	bf 00 00 00 00       	mov    $0x0,%edi
  803a29:	48 b8 4e 17 80 00 00 	movabs $0x80174e,%rax
  803a30:	00 00 00 
  803a33:	ff d0                	callq  *%rax
  803a35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a38:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a3c:	79 05                	jns    803a43 <opencons+0x54>
  803a3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a41:	eb 30                	jmp    803a73 <opencons+0x84>
  803a43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a47:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  803a4e:	00 00 00 
  803a51:	8b 12                	mov    (%rdx),%edx
  803a53:	89 10                	mov    %edx,(%rax)
  803a55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a59:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803a60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a64:	48 89 c7             	mov    %rax,%rdi
  803a67:	48 b8 2e 1b 80 00 00 	movabs $0x801b2e,%rax
  803a6e:	00 00 00 
  803a71:	ff d0                	callq  *%rax
  803a73:	c9                   	leaveq 
  803a74:	c3                   	retq   

0000000000803a75 <devcons_read>:
  803a75:	55                   	push   %rbp
  803a76:	48 89 e5             	mov    %rsp,%rbp
  803a79:	48 83 ec 30          	sub    $0x30,%rsp
  803a7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803a81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a85:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803a89:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803a8e:	75 07                	jne    803a97 <devcons_read+0x22>
  803a90:	b8 00 00 00 00       	mov    $0x0,%eax
  803a95:	eb 4b                	jmp    803ae2 <devcons_read+0x6d>
  803a97:	eb 0c                	jmp    803aa5 <devcons_read+0x30>
  803a99:	48 b8 10 17 80 00 00 	movabs $0x801710,%rax
  803aa0:	00 00 00 
  803aa3:	ff d0                	callq  *%rax
  803aa5:	48 b8 50 16 80 00 00 	movabs $0x801650,%rax
  803aac:	00 00 00 
  803aaf:	ff d0                	callq  *%rax
  803ab1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ab4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ab8:	74 df                	je     803a99 <devcons_read+0x24>
  803aba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803abe:	79 05                	jns    803ac5 <devcons_read+0x50>
  803ac0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ac3:	eb 1d                	jmp    803ae2 <devcons_read+0x6d>
  803ac5:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  803ac9:	75 07                	jne    803ad2 <devcons_read+0x5d>
  803acb:	b8 00 00 00 00       	mov    $0x0,%eax
  803ad0:	eb 10                	jmp    803ae2 <devcons_read+0x6d>
  803ad2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ad5:	89 c2                	mov    %eax,%edx
  803ad7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803adb:	88 10                	mov    %dl,(%rax)
  803add:	b8 01 00 00 00       	mov    $0x1,%eax
  803ae2:	c9                   	leaveq 
  803ae3:	c3                   	retq   

0000000000803ae4 <devcons_write>:
  803ae4:	55                   	push   %rbp
  803ae5:	48 89 e5             	mov    %rsp,%rbp
  803ae8:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  803aef:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  803af6:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  803afd:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  803b04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803b0b:	eb 76                	jmp    803b83 <devcons_write+0x9f>
  803b0d:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  803b14:	89 c2                	mov    %eax,%edx
  803b16:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b19:	29 c2                	sub    %eax,%edx
  803b1b:	89 d0                	mov    %edx,%eax
  803b1d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803b20:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803b23:	83 f8 7f             	cmp    $0x7f,%eax
  803b26:	76 07                	jbe    803b2f <devcons_write+0x4b>
  803b28:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  803b2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803b32:	48 63 d0             	movslq %eax,%rdx
  803b35:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b38:	48 63 c8             	movslq %eax,%rcx
  803b3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  803b42:	48 01 c1             	add    %rax,%rcx
  803b45:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803b4c:	48 89 ce             	mov    %rcx,%rsi
  803b4f:	48 89 c7             	mov    %rax,%rdi
  803b52:	48 b8 43 11 80 00 00 	movabs $0x801143,%rax
  803b59:	00 00 00 
  803b5c:	ff d0                	callq  *%rax
  803b5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803b61:	48 63 d0             	movslq %eax,%rdx
  803b64:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803b6b:	48 89 d6             	mov    %rdx,%rsi
  803b6e:	48 89 c7             	mov    %rax,%rdi
  803b71:	48 b8 06 16 80 00 00 	movabs $0x801606,%rax
  803b78:	00 00 00 
  803b7b:	ff d0                	callq  *%rax
  803b7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803b80:	01 45 fc             	add    %eax,-0x4(%rbp)
  803b83:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b86:	48 98                	cltq   
  803b88:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  803b8f:	0f 82 78 ff ff ff    	jb     803b0d <devcons_write+0x29>
  803b95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b98:	c9                   	leaveq 
  803b99:	c3                   	retq   

0000000000803b9a <devcons_close>:
  803b9a:	55                   	push   %rbp
  803b9b:	48 89 e5             	mov    %rsp,%rbp
  803b9e:	48 83 ec 08          	sub    $0x8,%rsp
  803ba2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803ba6:	b8 00 00 00 00       	mov    $0x0,%eax
  803bab:	c9                   	leaveq 
  803bac:	c3                   	retq   

0000000000803bad <devcons_stat>:
  803bad:	55                   	push   %rbp
  803bae:	48 89 e5             	mov    %rsp,%rbp
  803bb1:	48 83 ec 10          	sub    $0x10,%rsp
  803bb5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803bb9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803bbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bc1:	48 be 7a 46 80 00 00 	movabs $0x80467a,%rsi
  803bc8:	00 00 00 
  803bcb:	48 89 c7             	mov    %rax,%rdi
  803bce:	48 b8 1f 0e 80 00 00 	movabs $0x800e1f,%rax
  803bd5:	00 00 00 
  803bd8:	ff d0                	callq  *%rax
  803bda:	b8 00 00 00 00       	mov    $0x0,%eax
  803bdf:	c9                   	leaveq 
  803be0:	c3                   	retq   

0000000000803be1 <_panic>:
  803be1:	55                   	push   %rbp
  803be2:	48 89 e5             	mov    %rsp,%rbp
  803be5:	53                   	push   %rbx
  803be6:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803bed:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  803bf4:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  803bfa:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  803c01:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  803c08:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  803c0f:	84 c0                	test   %al,%al
  803c11:	74 23                	je     803c36 <_panic+0x55>
  803c13:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  803c1a:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  803c1e:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  803c22:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  803c26:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  803c2a:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  803c2e:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  803c32:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  803c36:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  803c3d:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  803c44:	00 00 00 
  803c47:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  803c4e:	00 00 00 
  803c51:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803c55:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  803c5c:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  803c63:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803c6a:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  803c71:	00 00 00 
  803c74:	48 8b 18             	mov    (%rax),%rbx
  803c77:	48 b8 d2 16 80 00 00 	movabs $0x8016d2,%rax
  803c7e:	00 00 00 
  803c81:	ff d0                	callq  *%rax
  803c83:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  803c89:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803c90:	41 89 c8             	mov    %ecx,%r8d
  803c93:	48 89 d1             	mov    %rdx,%rcx
  803c96:	48 89 da             	mov    %rbx,%rdx
  803c99:	89 c6                	mov    %eax,%esi
  803c9b:	48 bf 88 46 80 00 00 	movabs $0x804688,%rdi
  803ca2:	00 00 00 
  803ca5:	b8 00 00 00 00       	mov    $0x0,%eax
  803caa:	49 b9 6a 02 80 00 00 	movabs $0x80026a,%r9
  803cb1:	00 00 00 
  803cb4:	41 ff d1             	callq  *%r9
  803cb7:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  803cbe:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803cc5:	48 89 d6             	mov    %rdx,%rsi
  803cc8:	48 89 c7             	mov    %rax,%rdi
  803ccb:	48 b8 be 01 80 00 00 	movabs $0x8001be,%rax
  803cd2:	00 00 00 
  803cd5:	ff d0                	callq  *%rax
  803cd7:	48 bf ab 46 80 00 00 	movabs $0x8046ab,%rdi
  803cde:	00 00 00 
  803ce1:	b8 00 00 00 00       	mov    $0x0,%eax
  803ce6:	48 ba 6a 02 80 00 00 	movabs $0x80026a,%rdx
  803ced:	00 00 00 
  803cf0:	ff d2                	callq  *%rdx
  803cf2:	cc                   	int3   
  803cf3:	eb fd                	jmp    803cf2 <_panic+0x111>

0000000000803cf5 <ipc_recv>:
  803cf5:	55                   	push   %rbp
  803cf6:	48 89 e5             	mov    %rsp,%rbp
  803cf9:	48 83 ec 30          	sub    $0x30,%rsp
  803cfd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803d01:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803d05:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803d09:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803d0e:	75 0e                	jne    803d1e <ipc_recv+0x29>
  803d10:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803d17:	00 00 00 
  803d1a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803d1e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803d22:	48 89 c7             	mov    %rax,%rdi
  803d25:	48 b8 77 19 80 00 00 	movabs $0x801977,%rax
  803d2c:	00 00 00 
  803d2f:	ff d0                	callq  *%rax
  803d31:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d34:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d38:	79 27                	jns    803d61 <ipc_recv+0x6c>
  803d3a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803d3f:	74 0a                	je     803d4b <ipc_recv+0x56>
  803d41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d45:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803d4b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803d50:	74 0a                	je     803d5c <ipc_recv+0x67>
  803d52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d56:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803d5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d5f:	eb 53                	jmp    803db4 <ipc_recv+0xbf>
  803d61:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803d66:	74 19                	je     803d81 <ipc_recv+0x8c>
  803d68:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803d6f:	00 00 00 
  803d72:	48 8b 00             	mov    (%rax),%rax
  803d75:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  803d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d7f:	89 10                	mov    %edx,(%rax)
  803d81:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803d86:	74 19                	je     803da1 <ipc_recv+0xac>
  803d88:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803d8f:	00 00 00 
  803d92:	48 8b 00             	mov    (%rax),%rax
  803d95:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  803d9b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d9f:	89 10                	mov    %edx,(%rax)
  803da1:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803da8:	00 00 00 
  803dab:	48 8b 00             	mov    (%rax),%rax
  803dae:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  803db4:	c9                   	leaveq 
  803db5:	c3                   	retq   

0000000000803db6 <ipc_send>:
  803db6:	55                   	push   %rbp
  803db7:	48 89 e5             	mov    %rsp,%rbp
  803dba:	48 83 ec 30          	sub    $0x30,%rsp
  803dbe:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803dc1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803dc4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  803dc8:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803dcb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803dd0:	75 10                	jne    803de2 <ipc_send+0x2c>
  803dd2:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803dd9:	00 00 00 
  803ddc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803de0:	eb 0e                	jmp    803df0 <ipc_send+0x3a>
  803de2:	eb 0c                	jmp    803df0 <ipc_send+0x3a>
  803de4:	48 b8 10 17 80 00 00 	movabs $0x801710,%rax
  803deb:	00 00 00 
  803dee:	ff d0                	callq  *%rax
  803df0:	8b 75 e8             	mov    -0x18(%rbp),%esi
  803df3:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  803df6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803dfa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803dfd:	89 c7                	mov    %eax,%edi
  803dff:	48 b8 22 19 80 00 00 	movabs $0x801922,%rax
  803e06:	00 00 00 
  803e09:	ff d0                	callq  *%rax
  803e0b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e0e:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  803e12:	74 d0                	je     803de4 <ipc_send+0x2e>
  803e14:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e18:	79 30                	jns    803e4a <ipc_send+0x94>
  803e1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e1d:	89 c1                	mov    %eax,%ecx
  803e1f:	48 ba b0 46 80 00 00 	movabs $0x8046b0,%rdx
  803e26:	00 00 00 
  803e29:	be 44 00 00 00       	mov    $0x44,%esi
  803e2e:	48 bf c6 46 80 00 00 	movabs $0x8046c6,%rdi
  803e35:	00 00 00 
  803e38:	b8 00 00 00 00       	mov    $0x0,%eax
  803e3d:	49 b8 e1 3b 80 00 00 	movabs $0x803be1,%r8
  803e44:	00 00 00 
  803e47:	41 ff d0             	callq  *%r8
  803e4a:	c9                   	leaveq 
  803e4b:	c3                   	retq   

0000000000803e4c <ipc_host_recv>:
  803e4c:	55                   	push   %rbp
  803e4d:	48 89 e5             	mov    %rsp,%rbp
  803e50:	48 83 ec 10          	sub    $0x10,%rsp
  803e54:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803e58:	48 ba d8 46 80 00 00 	movabs $0x8046d8,%rdx
  803e5f:	00 00 00 
  803e62:	be 4e 00 00 00       	mov    $0x4e,%esi
  803e67:	48 bf c6 46 80 00 00 	movabs $0x8046c6,%rdi
  803e6e:	00 00 00 
  803e71:	b8 00 00 00 00       	mov    $0x0,%eax
  803e76:	48 b9 e1 3b 80 00 00 	movabs $0x803be1,%rcx
  803e7d:	00 00 00 
  803e80:	ff d1                	callq  *%rcx

0000000000803e82 <ipc_host_send>:
  803e82:	55                   	push   %rbp
  803e83:	48 89 e5             	mov    %rsp,%rbp
  803e86:	48 83 ec 20          	sub    $0x20,%rsp
  803e8a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e8d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803e90:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  803e94:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803e97:	48 ba f8 46 80 00 00 	movabs $0x8046f8,%rdx
  803e9e:	00 00 00 
  803ea1:	be 67 00 00 00       	mov    $0x67,%esi
  803ea6:	48 bf c6 46 80 00 00 	movabs $0x8046c6,%rdi
  803ead:	00 00 00 
  803eb0:	b8 00 00 00 00       	mov    $0x0,%eax
  803eb5:	48 b9 e1 3b 80 00 00 	movabs $0x803be1,%rcx
  803ebc:	00 00 00 
  803ebf:	ff d1                	callq  *%rcx

0000000000803ec1 <ipc_find_env>:
  803ec1:	55                   	push   %rbp
  803ec2:	48 89 e5             	mov    %rsp,%rbp
  803ec5:	48 83 ec 14          	sub    $0x14,%rsp
  803ec9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ecc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803ed3:	eb 4e                	jmp    803f23 <ipc_find_env+0x62>
  803ed5:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803edc:	00 00 00 
  803edf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ee2:	48 98                	cltq   
  803ee4:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803eeb:	48 01 d0             	add    %rdx,%rax
  803eee:	48 05 d0 00 00 00    	add    $0xd0,%rax
  803ef4:	8b 00                	mov    (%rax),%eax
  803ef6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  803ef9:	75 24                	jne    803f1f <ipc_find_env+0x5e>
  803efb:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803f02:	00 00 00 
  803f05:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f08:	48 98                	cltq   
  803f0a:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803f11:	48 01 d0             	add    %rdx,%rax
  803f14:	48 05 c0 00 00 00    	add    $0xc0,%rax
  803f1a:	8b 40 08             	mov    0x8(%rax),%eax
  803f1d:	eb 12                	jmp    803f31 <ipc_find_env+0x70>
  803f1f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803f23:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  803f2a:	7e a9                	jle    803ed5 <ipc_find_env+0x14>
  803f2c:	b8 00 00 00 00       	mov    $0x0,%eax
  803f31:	c9                   	leaveq 
  803f32:	c3                   	retq   

0000000000803f33 <pageref>:
  803f33:	55                   	push   %rbp
  803f34:	48 89 e5             	mov    %rsp,%rbp
  803f37:	48 83 ec 18          	sub    $0x18,%rsp
  803f3b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f43:	48 c1 e8 15          	shr    $0x15,%rax
  803f47:	48 89 c2             	mov    %rax,%rdx
  803f4a:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  803f51:	01 00 00 
  803f54:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803f58:	83 e0 01             	and    $0x1,%eax
  803f5b:	48 85 c0             	test   %rax,%rax
  803f5e:	75 07                	jne    803f67 <pageref+0x34>
  803f60:	b8 00 00 00 00       	mov    $0x0,%eax
  803f65:	eb 53                	jmp    803fba <pageref+0x87>
  803f67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f6b:	48 c1 e8 0c          	shr    $0xc,%rax
  803f6f:	48 89 c2             	mov    %rax,%rdx
  803f72:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803f79:	01 00 00 
  803f7c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803f80:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f88:	83 e0 01             	and    $0x1,%eax
  803f8b:	48 85 c0             	test   %rax,%rax
  803f8e:	75 07                	jne    803f97 <pageref+0x64>
  803f90:	b8 00 00 00 00       	mov    $0x0,%eax
  803f95:	eb 23                	jmp    803fba <pageref+0x87>
  803f97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f9b:	48 c1 e8 0c          	shr    $0xc,%rax
  803f9f:	48 89 c2             	mov    %rax,%rdx
  803fa2:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  803fa9:	00 00 00 
  803fac:	48 c1 e2 04          	shl    $0x4,%rdx
  803fb0:	48 01 d0             	add    %rdx,%rax
  803fb3:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  803fb7:	0f b7 c0             	movzwl %ax,%eax
  803fba:	c9                   	leaveq 
  803fbb:	c3                   	retq   
