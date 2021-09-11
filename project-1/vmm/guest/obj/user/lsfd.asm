
vmm/guest/obj/user/lsfd:     file format elf64-x86-64


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
  80003c:	e8 7c 01 00 00       	callq  8001bd <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <usage>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 bf e0 46 80 00 00 	movabs $0x8046e0,%rdi
  80004e:	00 00 00 
  800051:	b8 00 00 00 00       	mov    $0x0,%eax
  800056:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  80005d:	00 00 00 
  800060:	ff d2                	callq  *%rdx
  800062:	48 b8 40 02 80 00 00 	movabs $0x800240,%rax
  800069:	00 00 00 
  80006c:	ff d0                	callq  *%rax
  80006e:	5d                   	pop    %rbp
  80006f:	c3                   	retq   

0000000000800070 <umain>:
  800070:	55                   	push   %rbp
  800071:	48 89 e5             	mov    %rsp,%rbp
  800074:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  80007b:	89 bd 3c ff ff ff    	mov    %edi,-0xc4(%rbp)
  800081:	48 89 b5 30 ff ff ff 	mov    %rsi,-0xd0(%rbp)
  800088:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  80008f:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
  800096:	48 8b 8d 30 ff ff ff 	mov    -0xd0(%rbp),%rcx
  80009d:	48 8d 85 3c ff ff ff 	lea    -0xc4(%rbp),%rax
  8000a4:	48 89 ce             	mov    %rcx,%rsi
  8000a7:	48 89 c7             	mov    %rax,%rdi
  8000aa:	48 b8 4c 1c 80 00 00 	movabs $0x801c4c,%rax
  8000b1:	00 00 00 
  8000b4:	ff d0                	callq  *%rax
  8000b6:	eb 1b                	jmp    8000d3 <umain+0x63>
  8000b8:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
  8000bc:	75 09                	jne    8000c7 <umain+0x57>
  8000be:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
  8000c5:	eb 0c                	jmp    8000d3 <umain+0x63>
  8000c7:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8000ce:	00 00 00 
  8000d1:	ff d0                	callq  *%rax
  8000d3:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8000da:	48 89 c7             	mov    %rax,%rdi
  8000dd:	48 b8 b0 1c 80 00 00 	movabs $0x801cb0,%rax
  8000e4:	00 00 00 
  8000e7:	ff d0                	callq  *%rax
  8000e9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8000ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000f0:	79 c6                	jns    8000b8 <umain+0x48>
  8000f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8000f9:	e9 b3 00 00 00       	jmpq   8001b1 <umain+0x141>
  8000fe:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  800105:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800108:	48 89 d6             	mov    %rdx,%rsi
  80010b:	89 c7                	mov    %eax,%edi
  80010d:	48 b8 78 27 80 00 00 	movabs $0x802778,%rax
  800114:	00 00 00 
  800117:	ff d0                	callq  *%rax
  800119:	85 c0                	test   %eax,%eax
  80011b:	0f 88 8c 00 00 00    	js     8001ad <umain+0x13d>
  800121:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800125:	74 4a                	je     800171 <umain+0x101>
  800127:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80012b:	48 8b 48 08          	mov    0x8(%rax),%rcx
  80012f:	8b 7d e0             	mov    -0x20(%rbp),%edi
  800132:	8b 75 e4             	mov    -0x1c(%rbp),%esi
  800135:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  80013c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80013f:	48 89 0c 24          	mov    %rcx,(%rsp)
  800143:	41 89 f9             	mov    %edi,%r9d
  800146:	41 89 f0             	mov    %esi,%r8d
  800149:	48 89 d1             	mov    %rdx,%rcx
  80014c:	89 c2                	mov    %eax,%edx
  80014e:	48 be f8 46 80 00 00 	movabs $0x8046f8,%rsi
  800155:	00 00 00 
  800158:	bf 01 00 00 00       	mov    $0x1,%edi
  80015d:	b8 00 00 00 00       	mov    $0x0,%eax
  800162:	49 ba f2 30 80 00 00 	movabs $0x8030f2,%r10
  800169:	00 00 00 
  80016c:	41 ff d2             	callq  *%r10
  80016f:	eb 3c                	jmp    8001ad <umain+0x13d>
  800171:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800175:	48 8b 78 08          	mov    0x8(%rax),%rdi
  800179:	8b 75 e0             	mov    -0x20(%rbp),%esi
  80017c:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  80017f:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  800186:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800189:	49 89 f9             	mov    %rdi,%r9
  80018c:	41 89 f0             	mov    %esi,%r8d
  80018f:	89 c6                	mov    %eax,%esi
  800191:	48 bf f8 46 80 00 00 	movabs $0x8046f8,%rdi
  800198:	00 00 00 
  80019b:	b8 00 00 00 00       	mov    $0x0,%eax
  8001a0:	49 ba 88 03 80 00 00 	movabs $0x800388,%r10
  8001a7:	00 00 00 
  8001aa:	41 ff d2             	callq  *%r10
  8001ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8001b1:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8001b5:	0f 8e 43 ff ff ff    	jle    8000fe <umain+0x8e>
  8001bb:	c9                   	leaveq 
  8001bc:	c3                   	retq   

00000000008001bd <libmain>:
  8001bd:	55                   	push   %rbp
  8001be:	48 89 e5             	mov    %rsp,%rbp
  8001c1:	48 83 ec 10          	sub    $0x10,%rsp
  8001c5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8001c8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8001cc:	48 b8 f0 17 80 00 00 	movabs $0x8017f0,%rax
  8001d3:	00 00 00 
  8001d6:	ff d0                	callq  *%rax
  8001d8:	25 ff 03 00 00       	and    $0x3ff,%eax
  8001dd:	48 98                	cltq   
  8001df:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8001e6:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8001ed:	00 00 00 
  8001f0:	48 01 c2             	add    %rax,%rdx
  8001f3:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8001fa:	00 00 00 
  8001fd:	48 89 10             	mov    %rdx,(%rax)
  800200:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800204:	7e 14                	jle    80021a <libmain+0x5d>
  800206:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80020a:	48 8b 10             	mov    (%rax),%rdx
  80020d:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  800214:	00 00 00 
  800217:	48 89 10             	mov    %rdx,(%rax)
  80021a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80021e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800221:	48 89 d6             	mov    %rdx,%rsi
  800224:	89 c7                	mov    %eax,%edi
  800226:	48 b8 70 00 80 00 00 	movabs $0x800070,%rax
  80022d:	00 00 00 
  800230:	ff d0                	callq  *%rax
  800232:	48 b8 40 02 80 00 00 	movabs $0x800240,%rax
  800239:	00 00 00 
  80023c:	ff d0                	callq  *%rax
  80023e:	c9                   	leaveq 
  80023f:	c3                   	retq   

0000000000800240 <exit>:
  800240:	55                   	push   %rbp
  800241:	48 89 e5             	mov    %rsp,%rbp
  800244:	48 b8 72 22 80 00 00 	movabs $0x802272,%rax
  80024b:	00 00 00 
  80024e:	ff d0                	callq  *%rax
  800250:	bf 00 00 00 00       	mov    $0x0,%edi
  800255:	48 b8 ac 17 80 00 00 	movabs $0x8017ac,%rax
  80025c:	00 00 00 
  80025f:	ff d0                	callq  *%rax
  800261:	5d                   	pop    %rbp
  800262:	c3                   	retq   

0000000000800263 <putch>:
  800263:	55                   	push   %rbp
  800264:	48 89 e5             	mov    %rsp,%rbp
  800267:	48 83 ec 10          	sub    $0x10,%rsp
  80026b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80026e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800272:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800276:	8b 00                	mov    (%rax),%eax
  800278:	8d 48 01             	lea    0x1(%rax),%ecx
  80027b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80027f:	89 0a                	mov    %ecx,(%rdx)
  800281:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800284:	89 d1                	mov    %edx,%ecx
  800286:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80028a:	48 98                	cltq   
  80028c:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800290:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800294:	8b 00                	mov    (%rax),%eax
  800296:	3d ff 00 00 00       	cmp    $0xff,%eax
  80029b:	75 2c                	jne    8002c9 <putch+0x66>
  80029d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002a1:	8b 00                	mov    (%rax),%eax
  8002a3:	48 98                	cltq   
  8002a5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002a9:	48 83 c2 08          	add    $0x8,%rdx
  8002ad:	48 89 c6             	mov    %rax,%rsi
  8002b0:	48 89 d7             	mov    %rdx,%rdi
  8002b3:	48 b8 24 17 80 00 00 	movabs $0x801724,%rax
  8002ba:	00 00 00 
  8002bd:	ff d0                	callq  *%rax
  8002bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002c3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8002c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002cd:	8b 40 04             	mov    0x4(%rax),%eax
  8002d0:	8d 50 01             	lea    0x1(%rax),%edx
  8002d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002d7:	89 50 04             	mov    %edx,0x4(%rax)
  8002da:	c9                   	leaveq 
  8002db:	c3                   	retq   

00000000008002dc <vcprintf>:
  8002dc:	55                   	push   %rbp
  8002dd:	48 89 e5             	mov    %rsp,%rbp
  8002e0:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8002e7:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8002ee:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8002f5:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8002fc:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800303:	48 8b 0a             	mov    (%rdx),%rcx
  800306:	48 89 08             	mov    %rcx,(%rax)
  800309:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80030d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800311:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800315:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800319:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800320:	00 00 00 
  800323:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80032a:	00 00 00 
  80032d:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800334:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  80033b:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800342:	48 89 c6             	mov    %rax,%rsi
  800345:	48 bf 63 02 80 00 00 	movabs $0x800263,%rdi
  80034c:	00 00 00 
  80034f:	48 b8 3b 07 80 00 00 	movabs $0x80073b,%rax
  800356:	00 00 00 
  800359:	ff d0                	callq  *%rax
  80035b:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800361:	48 98                	cltq   
  800363:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80036a:	48 83 c2 08          	add    $0x8,%rdx
  80036e:	48 89 c6             	mov    %rax,%rsi
  800371:	48 89 d7             	mov    %rdx,%rdi
  800374:	48 b8 24 17 80 00 00 	movabs $0x801724,%rax
  80037b:	00 00 00 
  80037e:	ff d0                	callq  *%rax
  800380:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800386:	c9                   	leaveq 
  800387:	c3                   	retq   

0000000000800388 <cprintf>:
  800388:	55                   	push   %rbp
  800389:	48 89 e5             	mov    %rsp,%rbp
  80038c:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800393:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80039a:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8003a1:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8003a8:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8003af:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8003b6:	84 c0                	test   %al,%al
  8003b8:	74 20                	je     8003da <cprintf+0x52>
  8003ba:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8003be:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8003c2:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8003c6:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8003ca:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8003ce:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8003d2:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8003d6:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8003da:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8003e1:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8003e8:	00 00 00 
  8003eb:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8003f2:	00 00 00 
  8003f5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8003f9:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800400:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800407:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80040e:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800415:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80041c:	48 8b 0a             	mov    (%rdx),%rcx
  80041f:	48 89 08             	mov    %rcx,(%rax)
  800422:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800426:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80042a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80042e:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800432:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800439:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800440:	48 89 d6             	mov    %rdx,%rsi
  800443:	48 89 c7             	mov    %rax,%rdi
  800446:	48 b8 dc 02 80 00 00 	movabs $0x8002dc,%rax
  80044d:	00 00 00 
  800450:	ff d0                	callq  *%rax
  800452:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800458:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80045e:	c9                   	leaveq 
  80045f:	c3                   	retq   

0000000000800460 <printnum>:
  800460:	55                   	push   %rbp
  800461:	48 89 e5             	mov    %rsp,%rbp
  800464:	53                   	push   %rbx
  800465:	48 83 ec 38          	sub    $0x38,%rsp
  800469:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80046d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800471:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800475:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800478:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80047c:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800480:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800483:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800487:	77 3b                	ja     8004c4 <printnum+0x64>
  800489:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80048c:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800490:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800493:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800497:	ba 00 00 00 00       	mov    $0x0,%edx
  80049c:	48 f7 f3             	div    %rbx
  80049f:	48 89 c2             	mov    %rax,%rdx
  8004a2:	8b 7d cc             	mov    -0x34(%rbp),%edi
  8004a5:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8004a8:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  8004ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004b0:	41 89 f9             	mov    %edi,%r9d
  8004b3:	48 89 c7             	mov    %rax,%rdi
  8004b6:	48 b8 60 04 80 00 00 	movabs $0x800460,%rax
  8004bd:	00 00 00 
  8004c0:	ff d0                	callq  *%rax
  8004c2:	eb 1e                	jmp    8004e2 <printnum+0x82>
  8004c4:	eb 12                	jmp    8004d8 <printnum+0x78>
  8004c6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8004ca:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8004cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004d1:	48 89 ce             	mov    %rcx,%rsi
  8004d4:	89 d7                	mov    %edx,%edi
  8004d6:	ff d0                	callq  *%rax
  8004d8:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8004dc:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8004e0:	7f e4                	jg     8004c6 <printnum+0x66>
  8004e2:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8004e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8004e9:	ba 00 00 00 00       	mov    $0x0,%edx
  8004ee:	48 f7 f1             	div    %rcx
  8004f1:	48 89 d0             	mov    %rdx,%rax
  8004f4:	48 ba 30 49 80 00 00 	movabs $0x804930,%rdx
  8004fb:	00 00 00 
  8004fe:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800502:	0f be d0             	movsbl %al,%edx
  800505:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800509:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80050d:	48 89 ce             	mov    %rcx,%rsi
  800510:	89 d7                	mov    %edx,%edi
  800512:	ff d0                	callq  *%rax
  800514:	48 83 c4 38          	add    $0x38,%rsp
  800518:	5b                   	pop    %rbx
  800519:	5d                   	pop    %rbp
  80051a:	c3                   	retq   

000000000080051b <getuint>:
  80051b:	55                   	push   %rbp
  80051c:	48 89 e5             	mov    %rsp,%rbp
  80051f:	48 83 ec 1c          	sub    $0x1c,%rsp
  800523:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800527:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80052a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80052e:	7e 52                	jle    800582 <getuint+0x67>
  800530:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800534:	8b 00                	mov    (%rax),%eax
  800536:	83 f8 30             	cmp    $0x30,%eax
  800539:	73 24                	jae    80055f <getuint+0x44>
  80053b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80053f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800543:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800547:	8b 00                	mov    (%rax),%eax
  800549:	89 c0                	mov    %eax,%eax
  80054b:	48 01 d0             	add    %rdx,%rax
  80054e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800552:	8b 12                	mov    (%rdx),%edx
  800554:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800557:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80055b:	89 0a                	mov    %ecx,(%rdx)
  80055d:	eb 17                	jmp    800576 <getuint+0x5b>
  80055f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800563:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800567:	48 89 d0             	mov    %rdx,%rax
  80056a:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80056e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800572:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800576:	48 8b 00             	mov    (%rax),%rax
  800579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80057d:	e9 a3 00 00 00       	jmpq   800625 <getuint+0x10a>
  800582:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800586:	74 4f                	je     8005d7 <getuint+0xbc>
  800588:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80058c:	8b 00                	mov    (%rax),%eax
  80058e:	83 f8 30             	cmp    $0x30,%eax
  800591:	73 24                	jae    8005b7 <getuint+0x9c>
  800593:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800597:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80059b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80059f:	8b 00                	mov    (%rax),%eax
  8005a1:	89 c0                	mov    %eax,%eax
  8005a3:	48 01 d0             	add    %rdx,%rax
  8005a6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005aa:	8b 12                	mov    (%rdx),%edx
  8005ac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005af:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005b3:	89 0a                	mov    %ecx,(%rdx)
  8005b5:	eb 17                	jmp    8005ce <getuint+0xb3>
  8005b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005bb:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005bf:	48 89 d0             	mov    %rdx,%rax
  8005c2:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8005c6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005ca:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8005ce:	48 8b 00             	mov    (%rax),%rax
  8005d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005d5:	eb 4e                	jmp    800625 <getuint+0x10a>
  8005d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005db:	8b 00                	mov    (%rax),%eax
  8005dd:	83 f8 30             	cmp    $0x30,%eax
  8005e0:	73 24                	jae    800606 <getuint+0xeb>
  8005e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005e6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8005ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ee:	8b 00                	mov    (%rax),%eax
  8005f0:	89 c0                	mov    %eax,%eax
  8005f2:	48 01 d0             	add    %rdx,%rax
  8005f5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005f9:	8b 12                	mov    (%rdx),%edx
  8005fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005fe:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800602:	89 0a                	mov    %ecx,(%rdx)
  800604:	eb 17                	jmp    80061d <getuint+0x102>
  800606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80060a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80060e:	48 89 d0             	mov    %rdx,%rax
  800611:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800615:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800619:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80061d:	8b 00                	mov    (%rax),%eax
  80061f:	89 c0                	mov    %eax,%eax
  800621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800629:	c9                   	leaveq 
  80062a:	c3                   	retq   

000000000080062b <getint>:
  80062b:	55                   	push   %rbp
  80062c:	48 89 e5             	mov    %rsp,%rbp
  80062f:	48 83 ec 1c          	sub    $0x1c,%rsp
  800633:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800637:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80063a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80063e:	7e 52                	jle    800692 <getint+0x67>
  800640:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800644:	8b 00                	mov    (%rax),%eax
  800646:	83 f8 30             	cmp    $0x30,%eax
  800649:	73 24                	jae    80066f <getint+0x44>
  80064b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80064f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800653:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800657:	8b 00                	mov    (%rax),%eax
  800659:	89 c0                	mov    %eax,%eax
  80065b:	48 01 d0             	add    %rdx,%rax
  80065e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800662:	8b 12                	mov    (%rdx),%edx
  800664:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800667:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80066b:	89 0a                	mov    %ecx,(%rdx)
  80066d:	eb 17                	jmp    800686 <getint+0x5b>
  80066f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800673:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800677:	48 89 d0             	mov    %rdx,%rax
  80067a:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80067e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800682:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800686:	48 8b 00             	mov    (%rax),%rax
  800689:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80068d:	e9 a3 00 00 00       	jmpq   800735 <getint+0x10a>
  800692:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800696:	74 4f                	je     8006e7 <getint+0xbc>
  800698:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80069c:	8b 00                	mov    (%rax),%eax
  80069e:	83 f8 30             	cmp    $0x30,%eax
  8006a1:	73 24                	jae    8006c7 <getint+0x9c>
  8006a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006a7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006af:	8b 00                	mov    (%rax),%eax
  8006b1:	89 c0                	mov    %eax,%eax
  8006b3:	48 01 d0             	add    %rdx,%rax
  8006b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006ba:	8b 12                	mov    (%rdx),%edx
  8006bc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006bf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006c3:	89 0a                	mov    %ecx,(%rdx)
  8006c5:	eb 17                	jmp    8006de <getint+0xb3>
  8006c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006cb:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006cf:	48 89 d0             	mov    %rdx,%rax
  8006d2:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006d6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006de:	48 8b 00             	mov    (%rax),%rax
  8006e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006e5:	eb 4e                	jmp    800735 <getint+0x10a>
  8006e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006eb:	8b 00                	mov    (%rax),%eax
  8006ed:	83 f8 30             	cmp    $0x30,%eax
  8006f0:	73 24                	jae    800716 <getint+0xeb>
  8006f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006f6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006fe:	8b 00                	mov    (%rax),%eax
  800700:	89 c0                	mov    %eax,%eax
  800702:	48 01 d0             	add    %rdx,%rax
  800705:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800709:	8b 12                	mov    (%rdx),%edx
  80070b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80070e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800712:	89 0a                	mov    %ecx,(%rdx)
  800714:	eb 17                	jmp    80072d <getint+0x102>
  800716:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80071a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80071e:	48 89 d0             	mov    %rdx,%rax
  800721:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800725:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800729:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80072d:	8b 00                	mov    (%rax),%eax
  80072f:	48 98                	cltq   
  800731:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800735:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800739:	c9                   	leaveq 
  80073a:	c3                   	retq   

000000000080073b <vprintfmt>:
  80073b:	55                   	push   %rbp
  80073c:	48 89 e5             	mov    %rsp,%rbp
  80073f:	41 54                	push   %r12
  800741:	53                   	push   %rbx
  800742:	48 83 ec 60          	sub    $0x60,%rsp
  800746:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  80074a:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  80074e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800752:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800756:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80075a:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  80075e:	48 8b 0a             	mov    (%rdx),%rcx
  800761:	48 89 08             	mov    %rcx,(%rax)
  800764:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800768:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80076c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800770:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800774:	eb 17                	jmp    80078d <vprintfmt+0x52>
  800776:	85 db                	test   %ebx,%ebx
  800778:	0f 84 cc 04 00 00    	je     800c4a <vprintfmt+0x50f>
  80077e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800782:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800786:	48 89 d6             	mov    %rdx,%rsi
  800789:	89 df                	mov    %ebx,%edi
  80078b:	ff d0                	callq  *%rax
  80078d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800791:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800795:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800799:	0f b6 00             	movzbl (%rax),%eax
  80079c:	0f b6 d8             	movzbl %al,%ebx
  80079f:	83 fb 25             	cmp    $0x25,%ebx
  8007a2:	75 d2                	jne    800776 <vprintfmt+0x3b>
  8007a4:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  8007a8:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  8007af:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8007b6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8007bd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  8007c4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8007c8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8007cc:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8007d0:	0f b6 00             	movzbl (%rax),%eax
  8007d3:	0f b6 d8             	movzbl %al,%ebx
  8007d6:	8d 43 dd             	lea    -0x23(%rbx),%eax
  8007d9:	83 f8 55             	cmp    $0x55,%eax
  8007dc:	0f 87 34 04 00 00    	ja     800c16 <vprintfmt+0x4db>
  8007e2:	89 c0                	mov    %eax,%eax
  8007e4:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8007eb:	00 
  8007ec:	48 b8 58 49 80 00 00 	movabs $0x804958,%rax
  8007f3:	00 00 00 
  8007f6:	48 01 d0             	add    %rdx,%rax
  8007f9:	48 8b 00             	mov    (%rax),%rax
  8007fc:	ff e0                	jmpq   *%rax
  8007fe:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800802:	eb c0                	jmp    8007c4 <vprintfmt+0x89>
  800804:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800808:	eb ba                	jmp    8007c4 <vprintfmt+0x89>
  80080a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800811:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800814:	89 d0                	mov    %edx,%eax
  800816:	c1 e0 02             	shl    $0x2,%eax
  800819:	01 d0                	add    %edx,%eax
  80081b:	01 c0                	add    %eax,%eax
  80081d:	01 d8                	add    %ebx,%eax
  80081f:	83 e8 30             	sub    $0x30,%eax
  800822:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800825:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800829:	0f b6 00             	movzbl (%rax),%eax
  80082c:	0f be d8             	movsbl %al,%ebx
  80082f:	83 fb 2f             	cmp    $0x2f,%ebx
  800832:	7e 0c                	jle    800840 <vprintfmt+0x105>
  800834:	83 fb 39             	cmp    $0x39,%ebx
  800837:	7f 07                	jg     800840 <vprintfmt+0x105>
  800839:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  80083e:	eb d1                	jmp    800811 <vprintfmt+0xd6>
  800840:	eb 58                	jmp    80089a <vprintfmt+0x15f>
  800842:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800845:	83 f8 30             	cmp    $0x30,%eax
  800848:	73 17                	jae    800861 <vprintfmt+0x126>
  80084a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80084e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800851:	89 c0                	mov    %eax,%eax
  800853:	48 01 d0             	add    %rdx,%rax
  800856:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800859:	83 c2 08             	add    $0x8,%edx
  80085c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  80085f:	eb 0f                	jmp    800870 <vprintfmt+0x135>
  800861:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800865:	48 89 d0             	mov    %rdx,%rax
  800868:	48 83 c2 08          	add    $0x8,%rdx
  80086c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800870:	8b 00                	mov    (%rax),%eax
  800872:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800875:	eb 23                	jmp    80089a <vprintfmt+0x15f>
  800877:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80087b:	79 0c                	jns    800889 <vprintfmt+0x14e>
  80087d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800884:	e9 3b ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  800889:	e9 36 ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  80088e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800895:	e9 2a ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  80089a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80089e:	79 12                	jns    8008b2 <vprintfmt+0x177>
  8008a0:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8008a3:	89 45 dc             	mov    %eax,-0x24(%rbp)
  8008a6:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8008ad:	e9 12 ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  8008b2:	e9 0d ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  8008b7:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  8008bb:	e9 04 ff ff ff       	jmpq   8007c4 <vprintfmt+0x89>
  8008c0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008c3:	83 f8 30             	cmp    $0x30,%eax
  8008c6:	73 17                	jae    8008df <vprintfmt+0x1a4>
  8008c8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8008cc:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008cf:	89 c0                	mov    %eax,%eax
  8008d1:	48 01 d0             	add    %rdx,%rax
  8008d4:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8008d7:	83 c2 08             	add    $0x8,%edx
  8008da:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8008dd:	eb 0f                	jmp    8008ee <vprintfmt+0x1b3>
  8008df:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8008e3:	48 89 d0             	mov    %rdx,%rax
  8008e6:	48 83 c2 08          	add    $0x8,%rdx
  8008ea:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8008ee:	8b 10                	mov    (%rax),%edx
  8008f0:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8008f4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8008f8:	48 89 ce             	mov    %rcx,%rsi
  8008fb:	89 d7                	mov    %edx,%edi
  8008fd:	ff d0                	callq  *%rax
  8008ff:	e9 40 03 00 00       	jmpq   800c44 <vprintfmt+0x509>
  800904:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800907:	83 f8 30             	cmp    $0x30,%eax
  80090a:	73 17                	jae    800923 <vprintfmt+0x1e8>
  80090c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800910:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800913:	89 c0                	mov    %eax,%eax
  800915:	48 01 d0             	add    %rdx,%rax
  800918:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80091b:	83 c2 08             	add    $0x8,%edx
  80091e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800921:	eb 0f                	jmp    800932 <vprintfmt+0x1f7>
  800923:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800927:	48 89 d0             	mov    %rdx,%rax
  80092a:	48 83 c2 08          	add    $0x8,%rdx
  80092e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800932:	8b 18                	mov    (%rax),%ebx
  800934:	85 db                	test   %ebx,%ebx
  800936:	79 02                	jns    80093a <vprintfmt+0x1ff>
  800938:	f7 db                	neg    %ebx
  80093a:	83 fb 15             	cmp    $0x15,%ebx
  80093d:	7f 16                	jg     800955 <vprintfmt+0x21a>
  80093f:	48 b8 80 48 80 00 00 	movabs $0x804880,%rax
  800946:	00 00 00 
  800949:	48 63 d3             	movslq %ebx,%rdx
  80094c:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800950:	4d 85 e4             	test   %r12,%r12
  800953:	75 2e                	jne    800983 <vprintfmt+0x248>
  800955:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800959:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80095d:	89 d9                	mov    %ebx,%ecx
  80095f:	48 ba 41 49 80 00 00 	movabs $0x804941,%rdx
  800966:	00 00 00 
  800969:	48 89 c7             	mov    %rax,%rdi
  80096c:	b8 00 00 00 00       	mov    $0x0,%eax
  800971:	49 b8 53 0c 80 00 00 	movabs $0x800c53,%r8
  800978:	00 00 00 
  80097b:	41 ff d0             	callq  *%r8
  80097e:	e9 c1 02 00 00       	jmpq   800c44 <vprintfmt+0x509>
  800983:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800987:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80098b:	4c 89 e1             	mov    %r12,%rcx
  80098e:	48 ba 4a 49 80 00 00 	movabs $0x80494a,%rdx
  800995:	00 00 00 
  800998:	48 89 c7             	mov    %rax,%rdi
  80099b:	b8 00 00 00 00       	mov    $0x0,%eax
  8009a0:	49 b8 53 0c 80 00 00 	movabs $0x800c53,%r8
  8009a7:	00 00 00 
  8009aa:	41 ff d0             	callq  *%r8
  8009ad:	e9 92 02 00 00       	jmpq   800c44 <vprintfmt+0x509>
  8009b2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009b5:	83 f8 30             	cmp    $0x30,%eax
  8009b8:	73 17                	jae    8009d1 <vprintfmt+0x296>
  8009ba:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8009be:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009c1:	89 c0                	mov    %eax,%eax
  8009c3:	48 01 d0             	add    %rdx,%rax
  8009c6:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8009c9:	83 c2 08             	add    $0x8,%edx
  8009cc:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8009cf:	eb 0f                	jmp    8009e0 <vprintfmt+0x2a5>
  8009d1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8009d5:	48 89 d0             	mov    %rdx,%rax
  8009d8:	48 83 c2 08          	add    $0x8,%rdx
  8009dc:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8009e0:	4c 8b 20             	mov    (%rax),%r12
  8009e3:	4d 85 e4             	test   %r12,%r12
  8009e6:	75 0a                	jne    8009f2 <vprintfmt+0x2b7>
  8009e8:	49 bc 4d 49 80 00 00 	movabs $0x80494d,%r12
  8009ef:	00 00 00 
  8009f2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009f6:	7e 3f                	jle    800a37 <vprintfmt+0x2fc>
  8009f8:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  8009fc:	74 39                	je     800a37 <vprintfmt+0x2fc>
  8009fe:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800a01:	48 98                	cltq   
  800a03:	48 89 c6             	mov    %rax,%rsi
  800a06:	4c 89 e7             	mov    %r12,%rdi
  800a09:	48 b8 ff 0e 80 00 00 	movabs $0x800eff,%rax
  800a10:	00 00 00 
  800a13:	ff d0                	callq  *%rax
  800a15:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800a18:	eb 17                	jmp    800a31 <vprintfmt+0x2f6>
  800a1a:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800a1e:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800a22:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a26:	48 89 ce             	mov    %rcx,%rsi
  800a29:	89 d7                	mov    %edx,%edi
  800a2b:	ff d0                	callq  *%rax
  800a2d:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a31:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a35:	7f e3                	jg     800a1a <vprintfmt+0x2df>
  800a37:	eb 37                	jmp    800a70 <vprintfmt+0x335>
  800a39:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800a3d:	74 1e                	je     800a5d <vprintfmt+0x322>
  800a3f:	83 fb 1f             	cmp    $0x1f,%ebx
  800a42:	7e 05                	jle    800a49 <vprintfmt+0x30e>
  800a44:	83 fb 7e             	cmp    $0x7e,%ebx
  800a47:	7e 14                	jle    800a5d <vprintfmt+0x322>
  800a49:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a4d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a51:	48 89 d6             	mov    %rdx,%rsi
  800a54:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800a59:	ff d0                	callq  *%rax
  800a5b:	eb 0f                	jmp    800a6c <vprintfmt+0x331>
  800a5d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a61:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a65:	48 89 d6             	mov    %rdx,%rsi
  800a68:	89 df                	mov    %ebx,%edi
  800a6a:	ff d0                	callq  *%rax
  800a6c:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a70:	4c 89 e0             	mov    %r12,%rax
  800a73:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800a77:	0f b6 00             	movzbl (%rax),%eax
  800a7a:	0f be d8             	movsbl %al,%ebx
  800a7d:	85 db                	test   %ebx,%ebx
  800a7f:	74 10                	je     800a91 <vprintfmt+0x356>
  800a81:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800a85:	78 b2                	js     800a39 <vprintfmt+0x2fe>
  800a87:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800a8b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800a8f:	79 a8                	jns    800a39 <vprintfmt+0x2fe>
  800a91:	eb 16                	jmp    800aa9 <vprintfmt+0x36e>
  800a93:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a97:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a9b:	48 89 d6             	mov    %rdx,%rsi
  800a9e:	bf 20 00 00 00       	mov    $0x20,%edi
  800aa3:	ff d0                	callq  *%rax
  800aa5:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800aa9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800aad:	7f e4                	jg     800a93 <vprintfmt+0x358>
  800aaf:	e9 90 01 00 00       	jmpq   800c44 <vprintfmt+0x509>
  800ab4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ab8:	be 03 00 00 00       	mov    $0x3,%esi
  800abd:	48 89 c7             	mov    %rax,%rdi
  800ac0:	48 b8 2b 06 80 00 00 	movabs $0x80062b,%rax
  800ac7:	00 00 00 
  800aca:	ff d0                	callq  *%rax
  800acc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ad0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ad4:	48 85 c0             	test   %rax,%rax
  800ad7:	79 1d                	jns    800af6 <vprintfmt+0x3bb>
  800ad9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800add:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ae1:	48 89 d6             	mov    %rdx,%rsi
  800ae4:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800ae9:	ff d0                	callq  *%rax
  800aeb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800aef:	48 f7 d8             	neg    %rax
  800af2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800af6:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800afd:	e9 d5 00 00 00       	jmpq   800bd7 <vprintfmt+0x49c>
  800b02:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b06:	be 03 00 00 00       	mov    $0x3,%esi
  800b0b:	48 89 c7             	mov    %rax,%rdi
  800b0e:	48 b8 1b 05 80 00 00 	movabs $0x80051b,%rax
  800b15:	00 00 00 
  800b18:	ff d0                	callq  *%rax
  800b1a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b1e:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800b25:	e9 ad 00 00 00       	jmpq   800bd7 <vprintfmt+0x49c>
  800b2a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b2e:	be 03 00 00 00       	mov    $0x3,%esi
  800b33:	48 89 c7             	mov    %rax,%rdi
  800b36:	48 b8 1b 05 80 00 00 	movabs $0x80051b,%rax
  800b3d:	00 00 00 
  800b40:	ff d0                	callq  *%rax
  800b42:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b46:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800b4d:	e9 85 00 00 00       	jmpq   800bd7 <vprintfmt+0x49c>
  800b52:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b56:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b5a:	48 89 d6             	mov    %rdx,%rsi
  800b5d:	bf 30 00 00 00       	mov    $0x30,%edi
  800b62:	ff d0                	callq  *%rax
  800b64:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b68:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b6c:	48 89 d6             	mov    %rdx,%rsi
  800b6f:	bf 78 00 00 00       	mov    $0x78,%edi
  800b74:	ff d0                	callq  *%rax
  800b76:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b79:	83 f8 30             	cmp    $0x30,%eax
  800b7c:	73 17                	jae    800b95 <vprintfmt+0x45a>
  800b7e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b82:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b85:	89 c0                	mov    %eax,%eax
  800b87:	48 01 d0             	add    %rdx,%rax
  800b8a:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b8d:	83 c2 08             	add    $0x8,%edx
  800b90:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b93:	eb 0f                	jmp    800ba4 <vprintfmt+0x469>
  800b95:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b99:	48 89 d0             	mov    %rdx,%rax
  800b9c:	48 83 c2 08          	add    $0x8,%rdx
  800ba0:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800ba4:	48 8b 00             	mov    (%rax),%rax
  800ba7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800bab:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800bb2:	eb 23                	jmp    800bd7 <vprintfmt+0x49c>
  800bb4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800bb8:	be 03 00 00 00       	mov    $0x3,%esi
  800bbd:	48 89 c7             	mov    %rax,%rdi
  800bc0:	48 b8 1b 05 80 00 00 	movabs $0x80051b,%rax
  800bc7:	00 00 00 
  800bca:	ff d0                	callq  *%rax
  800bcc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800bd0:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800bd7:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800bdc:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800bdf:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800be2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800be6:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800bea:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bee:	45 89 c1             	mov    %r8d,%r9d
  800bf1:	41 89 f8             	mov    %edi,%r8d
  800bf4:	48 89 c7             	mov    %rax,%rdi
  800bf7:	48 b8 60 04 80 00 00 	movabs $0x800460,%rax
  800bfe:	00 00 00 
  800c01:	ff d0                	callq  *%rax
  800c03:	eb 3f                	jmp    800c44 <vprintfmt+0x509>
  800c05:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c09:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c0d:	48 89 d6             	mov    %rdx,%rsi
  800c10:	89 df                	mov    %ebx,%edi
  800c12:	ff d0                	callq  *%rax
  800c14:	eb 2e                	jmp    800c44 <vprintfmt+0x509>
  800c16:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c1a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c1e:	48 89 d6             	mov    %rdx,%rsi
  800c21:	bf 25 00 00 00       	mov    $0x25,%edi
  800c26:	ff d0                	callq  *%rax
  800c28:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c2d:	eb 05                	jmp    800c34 <vprintfmt+0x4f9>
  800c2f:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c34:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c38:	48 83 e8 01          	sub    $0x1,%rax
  800c3c:	0f b6 00             	movzbl (%rax),%eax
  800c3f:	3c 25                	cmp    $0x25,%al
  800c41:	75 ec                	jne    800c2f <vprintfmt+0x4f4>
  800c43:	90                   	nop
  800c44:	90                   	nop
  800c45:	e9 43 fb ff ff       	jmpq   80078d <vprintfmt+0x52>
  800c4a:	48 83 c4 60          	add    $0x60,%rsp
  800c4e:	5b                   	pop    %rbx
  800c4f:	41 5c                	pop    %r12
  800c51:	5d                   	pop    %rbp
  800c52:	c3                   	retq   

0000000000800c53 <printfmt>:
  800c53:	55                   	push   %rbp
  800c54:	48 89 e5             	mov    %rsp,%rbp
  800c57:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800c5e:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800c65:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800c6c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800c73:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800c7a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800c81:	84 c0                	test   %al,%al
  800c83:	74 20                	je     800ca5 <printfmt+0x52>
  800c85:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800c89:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800c8d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800c91:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800c95:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800c99:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800c9d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800ca1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800ca5:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800cac:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800cb3:	00 00 00 
  800cb6:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800cbd:	00 00 00 
  800cc0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800cc4:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800ccb:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800cd2:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800cd9:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800ce0:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800ce7:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800cee:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800cf5:	48 89 c7             	mov    %rax,%rdi
  800cf8:	48 b8 3b 07 80 00 00 	movabs $0x80073b,%rax
  800cff:	00 00 00 
  800d02:	ff d0                	callq  *%rax
  800d04:	c9                   	leaveq 
  800d05:	c3                   	retq   

0000000000800d06 <sprintputch>:
  800d06:	55                   	push   %rbp
  800d07:	48 89 e5             	mov    %rsp,%rbp
  800d0a:	48 83 ec 10          	sub    $0x10,%rsp
  800d0e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d11:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d19:	8b 40 10             	mov    0x10(%rax),%eax
  800d1c:	8d 50 01             	lea    0x1(%rax),%edx
  800d1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d23:	89 50 10             	mov    %edx,0x10(%rax)
  800d26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d2a:	48 8b 10             	mov    (%rax),%rdx
  800d2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d31:	48 8b 40 08          	mov    0x8(%rax),%rax
  800d35:	48 39 c2             	cmp    %rax,%rdx
  800d38:	73 17                	jae    800d51 <sprintputch+0x4b>
  800d3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d3e:	48 8b 00             	mov    (%rax),%rax
  800d41:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800d45:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800d49:	48 89 0a             	mov    %rcx,(%rdx)
  800d4c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800d4f:	88 10                	mov    %dl,(%rax)
  800d51:	c9                   	leaveq 
  800d52:	c3                   	retq   

0000000000800d53 <vsnprintf>:
  800d53:	55                   	push   %rbp
  800d54:	48 89 e5             	mov    %rsp,%rbp
  800d57:	48 83 ec 50          	sub    $0x50,%rsp
  800d5b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800d5f:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800d62:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800d66:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800d6a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800d6e:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800d72:	48 8b 0a             	mov    (%rdx),%rcx
  800d75:	48 89 08             	mov    %rcx,(%rax)
  800d78:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800d7c:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800d80:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800d84:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800d88:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800d8c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800d90:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800d93:	48 98                	cltq   
  800d95:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800d99:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800d9d:	48 01 d0             	add    %rdx,%rax
  800da0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800da4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800dab:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800db0:	74 06                	je     800db8 <vsnprintf+0x65>
  800db2:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800db6:	7f 07                	jg     800dbf <vsnprintf+0x6c>
  800db8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800dbd:	eb 2f                	jmp    800dee <vsnprintf+0x9b>
  800dbf:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800dc3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800dc7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800dcb:	48 89 c6             	mov    %rax,%rsi
  800dce:	48 bf 06 0d 80 00 00 	movabs $0x800d06,%rdi
  800dd5:	00 00 00 
  800dd8:	48 b8 3b 07 80 00 00 	movabs $0x80073b,%rax
  800ddf:	00 00 00 
  800de2:	ff d0                	callq  *%rax
  800de4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800de8:	c6 00 00             	movb   $0x0,(%rax)
  800deb:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800dee:	c9                   	leaveq 
  800def:	c3                   	retq   

0000000000800df0 <snprintf>:
  800df0:	55                   	push   %rbp
  800df1:	48 89 e5             	mov    %rsp,%rbp
  800df4:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800dfb:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800e02:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800e08:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800e0f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800e16:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800e1d:	84 c0                	test   %al,%al
  800e1f:	74 20                	je     800e41 <snprintf+0x51>
  800e21:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800e25:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800e29:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800e2d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800e31:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800e35:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800e39:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800e3d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800e41:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800e48:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800e4f:	00 00 00 
  800e52:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800e59:	00 00 00 
  800e5c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800e60:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800e67:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800e6e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800e75:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800e7c:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800e83:	48 8b 0a             	mov    (%rdx),%rcx
  800e86:	48 89 08             	mov    %rcx,(%rax)
  800e89:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800e8d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800e91:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800e95:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800e99:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800ea0:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800ea7:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800ead:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800eb4:	48 89 c7             	mov    %rax,%rdi
  800eb7:	48 b8 53 0d 80 00 00 	movabs $0x800d53,%rax
  800ebe:	00 00 00 
  800ec1:	ff d0                	callq  *%rax
  800ec3:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800ec9:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800ecf:	c9                   	leaveq 
  800ed0:	c3                   	retq   

0000000000800ed1 <strlen>:
  800ed1:	55                   	push   %rbp
  800ed2:	48 89 e5             	mov    %rsp,%rbp
  800ed5:	48 83 ec 18          	sub    $0x18,%rsp
  800ed9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800edd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800ee4:	eb 09                	jmp    800eef <strlen+0x1e>
  800ee6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800eea:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800eef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ef3:	0f b6 00             	movzbl (%rax),%eax
  800ef6:	84 c0                	test   %al,%al
  800ef8:	75 ec                	jne    800ee6 <strlen+0x15>
  800efa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800efd:	c9                   	leaveq 
  800efe:	c3                   	retq   

0000000000800eff <strnlen>:
  800eff:	55                   	push   %rbp
  800f00:	48 89 e5             	mov    %rsp,%rbp
  800f03:	48 83 ec 20          	sub    $0x20,%rsp
  800f07:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f0b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800f16:	eb 0e                	jmp    800f26 <strnlen+0x27>
  800f18:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f1c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800f21:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  800f26:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800f2b:	74 0b                	je     800f38 <strnlen+0x39>
  800f2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f31:	0f b6 00             	movzbl (%rax),%eax
  800f34:	84 c0                	test   %al,%al
  800f36:	75 e0                	jne    800f18 <strnlen+0x19>
  800f38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f3b:	c9                   	leaveq 
  800f3c:	c3                   	retq   

0000000000800f3d <strcpy>:
  800f3d:	55                   	push   %rbp
  800f3e:	48 89 e5             	mov    %rsp,%rbp
  800f41:	48 83 ec 20          	sub    $0x20,%rsp
  800f45:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f49:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800f55:	90                   	nop
  800f56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f5a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800f5e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800f62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800f66:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800f6a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800f6e:	0f b6 12             	movzbl (%rdx),%edx
  800f71:	88 10                	mov    %dl,(%rax)
  800f73:	0f b6 00             	movzbl (%rax),%eax
  800f76:	84 c0                	test   %al,%al
  800f78:	75 dc                	jne    800f56 <strcpy+0x19>
  800f7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800f7e:	c9                   	leaveq 
  800f7f:	c3                   	retq   

0000000000800f80 <strcat>:
  800f80:	55                   	push   %rbp
  800f81:	48 89 e5             	mov    %rsp,%rbp
  800f84:	48 83 ec 20          	sub    $0x20,%rsp
  800f88:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f8c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f94:	48 89 c7             	mov    %rax,%rdi
  800f97:	48 b8 d1 0e 80 00 00 	movabs $0x800ed1,%rax
  800f9e:	00 00 00 
  800fa1:	ff d0                	callq  *%rax
  800fa3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800fa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800fa9:	48 63 d0             	movslq %eax,%rdx
  800fac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fb0:	48 01 c2             	add    %rax,%rdx
  800fb3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800fb7:	48 89 c6             	mov    %rax,%rsi
  800fba:	48 89 d7             	mov    %rdx,%rdi
  800fbd:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  800fc4:	00 00 00 
  800fc7:	ff d0                	callq  *%rax
  800fc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fcd:	c9                   	leaveq 
  800fce:	c3                   	retq   

0000000000800fcf <strncpy>:
  800fcf:	55                   	push   %rbp
  800fd0:	48 89 e5             	mov    %rsp,%rbp
  800fd3:	48 83 ec 28          	sub    $0x28,%rsp
  800fd7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fdb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fdf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800fe3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fe7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800feb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  800ff2:	00 
  800ff3:	eb 2a                	jmp    80101f <strncpy+0x50>
  800ff5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ff9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800ffd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801001:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801005:	0f b6 12             	movzbl (%rdx),%edx
  801008:	88 10                	mov    %dl,(%rax)
  80100a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80100e:	0f b6 00             	movzbl (%rax),%eax
  801011:	84 c0                	test   %al,%al
  801013:	74 05                	je     80101a <strncpy+0x4b>
  801015:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80101a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80101f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801023:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801027:	72 cc                	jb     800ff5 <strncpy+0x26>
  801029:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80102d:	c9                   	leaveq 
  80102e:	c3                   	retq   

000000000080102f <strlcpy>:
  80102f:	55                   	push   %rbp
  801030:	48 89 e5             	mov    %rsp,%rbp
  801033:	48 83 ec 28          	sub    $0x28,%rsp
  801037:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80103b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80103f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801043:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801047:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80104b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801050:	74 3d                	je     80108f <strlcpy+0x60>
  801052:	eb 1d                	jmp    801071 <strlcpy+0x42>
  801054:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801058:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80105c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801060:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801064:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801068:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80106c:	0f b6 12             	movzbl (%rdx),%edx
  80106f:	88 10                	mov    %dl,(%rax)
  801071:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801076:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80107b:	74 0b                	je     801088 <strlcpy+0x59>
  80107d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801081:	0f b6 00             	movzbl (%rax),%eax
  801084:	84 c0                	test   %al,%al
  801086:	75 cc                	jne    801054 <strlcpy+0x25>
  801088:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80108c:	c6 00 00             	movb   $0x0,(%rax)
  80108f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801093:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801097:	48 29 c2             	sub    %rax,%rdx
  80109a:	48 89 d0             	mov    %rdx,%rax
  80109d:	c9                   	leaveq 
  80109e:	c3                   	retq   

000000000080109f <strcmp>:
  80109f:	55                   	push   %rbp
  8010a0:	48 89 e5             	mov    %rsp,%rbp
  8010a3:	48 83 ec 10          	sub    $0x10,%rsp
  8010a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8010ab:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8010af:	eb 0a                	jmp    8010bb <strcmp+0x1c>
  8010b1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8010b6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8010bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010bf:	0f b6 00             	movzbl (%rax),%eax
  8010c2:	84 c0                	test   %al,%al
  8010c4:	74 12                	je     8010d8 <strcmp+0x39>
  8010c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010ca:	0f b6 10             	movzbl (%rax),%edx
  8010cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010d1:	0f b6 00             	movzbl (%rax),%eax
  8010d4:	38 c2                	cmp    %al,%dl
  8010d6:	74 d9                	je     8010b1 <strcmp+0x12>
  8010d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010dc:	0f b6 00             	movzbl (%rax),%eax
  8010df:	0f b6 d0             	movzbl %al,%edx
  8010e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010e6:	0f b6 00             	movzbl (%rax),%eax
  8010e9:	0f b6 c0             	movzbl %al,%eax
  8010ec:	29 c2                	sub    %eax,%edx
  8010ee:	89 d0                	mov    %edx,%eax
  8010f0:	c9                   	leaveq 
  8010f1:	c3                   	retq   

00000000008010f2 <strncmp>:
  8010f2:	55                   	push   %rbp
  8010f3:	48 89 e5             	mov    %rsp,%rbp
  8010f6:	48 83 ec 18          	sub    $0x18,%rsp
  8010fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8010fe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801102:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801106:	eb 0f                	jmp    801117 <strncmp+0x25>
  801108:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80110d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801112:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801117:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80111c:	74 1d                	je     80113b <strncmp+0x49>
  80111e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801122:	0f b6 00             	movzbl (%rax),%eax
  801125:	84 c0                	test   %al,%al
  801127:	74 12                	je     80113b <strncmp+0x49>
  801129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80112d:	0f b6 10             	movzbl (%rax),%edx
  801130:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801134:	0f b6 00             	movzbl (%rax),%eax
  801137:	38 c2                	cmp    %al,%dl
  801139:	74 cd                	je     801108 <strncmp+0x16>
  80113b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801140:	75 07                	jne    801149 <strncmp+0x57>
  801142:	b8 00 00 00 00       	mov    $0x0,%eax
  801147:	eb 18                	jmp    801161 <strncmp+0x6f>
  801149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80114d:	0f b6 00             	movzbl (%rax),%eax
  801150:	0f b6 d0             	movzbl %al,%edx
  801153:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801157:	0f b6 00             	movzbl (%rax),%eax
  80115a:	0f b6 c0             	movzbl %al,%eax
  80115d:	29 c2                	sub    %eax,%edx
  80115f:	89 d0                	mov    %edx,%eax
  801161:	c9                   	leaveq 
  801162:	c3                   	retq   

0000000000801163 <strchr>:
  801163:	55                   	push   %rbp
  801164:	48 89 e5             	mov    %rsp,%rbp
  801167:	48 83 ec 0c          	sub    $0xc,%rsp
  80116b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80116f:	89 f0                	mov    %esi,%eax
  801171:	88 45 f4             	mov    %al,-0xc(%rbp)
  801174:	eb 17                	jmp    80118d <strchr+0x2a>
  801176:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80117a:	0f b6 00             	movzbl (%rax),%eax
  80117d:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801180:	75 06                	jne    801188 <strchr+0x25>
  801182:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801186:	eb 15                	jmp    80119d <strchr+0x3a>
  801188:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80118d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801191:	0f b6 00             	movzbl (%rax),%eax
  801194:	84 c0                	test   %al,%al
  801196:	75 de                	jne    801176 <strchr+0x13>
  801198:	b8 00 00 00 00       	mov    $0x0,%eax
  80119d:	c9                   	leaveq 
  80119e:	c3                   	retq   

000000000080119f <strfind>:
  80119f:	55                   	push   %rbp
  8011a0:	48 89 e5             	mov    %rsp,%rbp
  8011a3:	48 83 ec 0c          	sub    $0xc,%rsp
  8011a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011ab:	89 f0                	mov    %esi,%eax
  8011ad:	88 45 f4             	mov    %al,-0xc(%rbp)
  8011b0:	eb 13                	jmp    8011c5 <strfind+0x26>
  8011b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011b6:	0f b6 00             	movzbl (%rax),%eax
  8011b9:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8011bc:	75 02                	jne    8011c0 <strfind+0x21>
  8011be:	eb 10                	jmp    8011d0 <strfind+0x31>
  8011c0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8011c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011c9:	0f b6 00             	movzbl (%rax),%eax
  8011cc:	84 c0                	test   %al,%al
  8011ce:	75 e2                	jne    8011b2 <strfind+0x13>
  8011d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011d4:	c9                   	leaveq 
  8011d5:	c3                   	retq   

00000000008011d6 <memset>:
  8011d6:	55                   	push   %rbp
  8011d7:	48 89 e5             	mov    %rsp,%rbp
  8011da:	48 83 ec 18          	sub    $0x18,%rsp
  8011de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8011e5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8011e9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8011ee:	75 06                	jne    8011f6 <memset+0x20>
  8011f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011f4:	eb 69                	jmp    80125f <memset+0x89>
  8011f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011fa:	83 e0 03             	and    $0x3,%eax
  8011fd:	48 85 c0             	test   %rax,%rax
  801200:	75 48                	jne    80124a <memset+0x74>
  801202:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801206:	83 e0 03             	and    $0x3,%eax
  801209:	48 85 c0             	test   %rax,%rax
  80120c:	75 3c                	jne    80124a <memset+0x74>
  80120e:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801215:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801218:	c1 e0 18             	shl    $0x18,%eax
  80121b:	89 c2                	mov    %eax,%edx
  80121d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801220:	c1 e0 10             	shl    $0x10,%eax
  801223:	09 c2                	or     %eax,%edx
  801225:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801228:	c1 e0 08             	shl    $0x8,%eax
  80122b:	09 d0                	or     %edx,%eax
  80122d:	09 45 f4             	or     %eax,-0xc(%rbp)
  801230:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801234:	48 c1 e8 02          	shr    $0x2,%rax
  801238:	48 89 c1             	mov    %rax,%rcx
  80123b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80123f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801242:	48 89 d7             	mov    %rdx,%rdi
  801245:	fc                   	cld    
  801246:	f3 ab                	rep stos %eax,%es:(%rdi)
  801248:	eb 11                	jmp    80125b <memset+0x85>
  80124a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80124e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801251:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801255:	48 89 d7             	mov    %rdx,%rdi
  801258:	fc                   	cld    
  801259:	f3 aa                	rep stos %al,%es:(%rdi)
  80125b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80125f:	c9                   	leaveq 
  801260:	c3                   	retq   

0000000000801261 <memmove>:
  801261:	55                   	push   %rbp
  801262:	48 89 e5             	mov    %rsp,%rbp
  801265:	48 83 ec 28          	sub    $0x28,%rsp
  801269:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80126d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801271:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801275:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801279:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80127d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801281:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801285:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801289:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80128d:	0f 83 88 00 00 00    	jae    80131b <memmove+0xba>
  801293:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801297:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80129b:	48 01 d0             	add    %rdx,%rax
  80129e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8012a2:	76 77                	jbe    80131b <memmove+0xba>
  8012a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012a8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8012ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012b0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8012b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012b8:	83 e0 03             	and    $0x3,%eax
  8012bb:	48 85 c0             	test   %rax,%rax
  8012be:	75 3b                	jne    8012fb <memmove+0x9a>
  8012c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012c4:	83 e0 03             	and    $0x3,%eax
  8012c7:	48 85 c0             	test   %rax,%rax
  8012ca:	75 2f                	jne    8012fb <memmove+0x9a>
  8012cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012d0:	83 e0 03             	and    $0x3,%eax
  8012d3:	48 85 c0             	test   %rax,%rax
  8012d6:	75 23                	jne    8012fb <memmove+0x9a>
  8012d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012dc:	48 83 e8 04          	sub    $0x4,%rax
  8012e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8012e4:	48 83 ea 04          	sub    $0x4,%rdx
  8012e8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8012ec:	48 c1 e9 02          	shr    $0x2,%rcx
  8012f0:	48 89 c7             	mov    %rax,%rdi
  8012f3:	48 89 d6             	mov    %rdx,%rsi
  8012f6:	fd                   	std    
  8012f7:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8012f9:	eb 1d                	jmp    801318 <memmove+0xb7>
  8012fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012ff:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801303:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801307:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  80130b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80130f:	48 89 d7             	mov    %rdx,%rdi
  801312:	48 89 c1             	mov    %rax,%rcx
  801315:	fd                   	std    
  801316:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801318:	fc                   	cld    
  801319:	eb 57                	jmp    801372 <memmove+0x111>
  80131b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80131f:	83 e0 03             	and    $0x3,%eax
  801322:	48 85 c0             	test   %rax,%rax
  801325:	75 36                	jne    80135d <memmove+0xfc>
  801327:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80132b:	83 e0 03             	and    $0x3,%eax
  80132e:	48 85 c0             	test   %rax,%rax
  801331:	75 2a                	jne    80135d <memmove+0xfc>
  801333:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801337:	83 e0 03             	and    $0x3,%eax
  80133a:	48 85 c0             	test   %rax,%rax
  80133d:	75 1e                	jne    80135d <memmove+0xfc>
  80133f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801343:	48 c1 e8 02          	shr    $0x2,%rax
  801347:	48 89 c1             	mov    %rax,%rcx
  80134a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80134e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801352:	48 89 c7             	mov    %rax,%rdi
  801355:	48 89 d6             	mov    %rdx,%rsi
  801358:	fc                   	cld    
  801359:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80135b:	eb 15                	jmp    801372 <memmove+0x111>
  80135d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801361:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801365:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801369:	48 89 c7             	mov    %rax,%rdi
  80136c:	48 89 d6             	mov    %rdx,%rsi
  80136f:	fc                   	cld    
  801370:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801372:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801376:	c9                   	leaveq 
  801377:	c3                   	retq   

0000000000801378 <memcpy>:
  801378:	55                   	push   %rbp
  801379:	48 89 e5             	mov    %rsp,%rbp
  80137c:	48 83 ec 18          	sub    $0x18,%rsp
  801380:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801384:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801388:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80138c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801390:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801394:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801398:	48 89 ce             	mov    %rcx,%rsi
  80139b:	48 89 c7             	mov    %rax,%rdi
  80139e:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  8013a5:	00 00 00 
  8013a8:	ff d0                	callq  *%rax
  8013aa:	c9                   	leaveq 
  8013ab:	c3                   	retq   

00000000008013ac <memcmp>:
  8013ac:	55                   	push   %rbp
  8013ad:	48 89 e5             	mov    %rsp,%rbp
  8013b0:	48 83 ec 28          	sub    $0x28,%rsp
  8013b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013b8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013bc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013c8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8013cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8013d0:	eb 36                	jmp    801408 <memcmp+0x5c>
  8013d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013d6:	0f b6 10             	movzbl (%rax),%edx
  8013d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013dd:	0f b6 00             	movzbl (%rax),%eax
  8013e0:	38 c2                	cmp    %al,%dl
  8013e2:	74 1a                	je     8013fe <memcmp+0x52>
  8013e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013e8:	0f b6 00             	movzbl (%rax),%eax
  8013eb:	0f b6 d0             	movzbl %al,%edx
  8013ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013f2:	0f b6 00             	movzbl (%rax),%eax
  8013f5:	0f b6 c0             	movzbl %al,%eax
  8013f8:	29 c2                	sub    %eax,%edx
  8013fa:	89 d0                	mov    %edx,%eax
  8013fc:	eb 20                	jmp    80141e <memcmp+0x72>
  8013fe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801403:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801408:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80140c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801410:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801414:	48 85 c0             	test   %rax,%rax
  801417:	75 b9                	jne    8013d2 <memcmp+0x26>
  801419:	b8 00 00 00 00       	mov    $0x0,%eax
  80141e:	c9                   	leaveq 
  80141f:	c3                   	retq   

0000000000801420 <memfind>:
  801420:	55                   	push   %rbp
  801421:	48 89 e5             	mov    %rsp,%rbp
  801424:	48 83 ec 28          	sub    $0x28,%rsp
  801428:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80142c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80142f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801433:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801437:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80143b:	48 01 d0             	add    %rdx,%rax
  80143e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801442:	eb 15                	jmp    801459 <memfind+0x39>
  801444:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801448:	0f b6 10             	movzbl (%rax),%edx
  80144b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80144e:	38 c2                	cmp    %al,%dl
  801450:	75 02                	jne    801454 <memfind+0x34>
  801452:	eb 0f                	jmp    801463 <memfind+0x43>
  801454:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801459:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80145d:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801461:	72 e1                	jb     801444 <memfind+0x24>
  801463:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801467:	c9                   	leaveq 
  801468:	c3                   	retq   

0000000000801469 <strtol>:
  801469:	55                   	push   %rbp
  80146a:	48 89 e5             	mov    %rsp,%rbp
  80146d:	48 83 ec 34          	sub    $0x34,%rsp
  801471:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801475:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801479:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80147c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801483:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  80148a:	00 
  80148b:	eb 05                	jmp    801492 <strtol+0x29>
  80148d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801492:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801496:	0f b6 00             	movzbl (%rax),%eax
  801499:	3c 20                	cmp    $0x20,%al
  80149b:	74 f0                	je     80148d <strtol+0x24>
  80149d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014a1:	0f b6 00             	movzbl (%rax),%eax
  8014a4:	3c 09                	cmp    $0x9,%al
  8014a6:	74 e5                	je     80148d <strtol+0x24>
  8014a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014ac:	0f b6 00             	movzbl (%rax),%eax
  8014af:	3c 2b                	cmp    $0x2b,%al
  8014b1:	75 07                	jne    8014ba <strtol+0x51>
  8014b3:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014b8:	eb 17                	jmp    8014d1 <strtol+0x68>
  8014ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014be:	0f b6 00             	movzbl (%rax),%eax
  8014c1:	3c 2d                	cmp    $0x2d,%al
  8014c3:	75 0c                	jne    8014d1 <strtol+0x68>
  8014c5:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8014d1:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8014d5:	74 06                	je     8014dd <strtol+0x74>
  8014d7:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8014db:	75 28                	jne    801505 <strtol+0x9c>
  8014dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014e1:	0f b6 00             	movzbl (%rax),%eax
  8014e4:	3c 30                	cmp    $0x30,%al
  8014e6:	75 1d                	jne    801505 <strtol+0x9c>
  8014e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014ec:	48 83 c0 01          	add    $0x1,%rax
  8014f0:	0f b6 00             	movzbl (%rax),%eax
  8014f3:	3c 78                	cmp    $0x78,%al
  8014f5:	75 0e                	jne    801505 <strtol+0x9c>
  8014f7:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8014fc:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801503:	eb 2c                	jmp    801531 <strtol+0xc8>
  801505:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801509:	75 19                	jne    801524 <strtol+0xbb>
  80150b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80150f:	0f b6 00             	movzbl (%rax),%eax
  801512:	3c 30                	cmp    $0x30,%al
  801514:	75 0e                	jne    801524 <strtol+0xbb>
  801516:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80151b:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801522:	eb 0d                	jmp    801531 <strtol+0xc8>
  801524:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801528:	75 07                	jne    801531 <strtol+0xc8>
  80152a:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801531:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801535:	0f b6 00             	movzbl (%rax),%eax
  801538:	3c 2f                	cmp    $0x2f,%al
  80153a:	7e 1d                	jle    801559 <strtol+0xf0>
  80153c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801540:	0f b6 00             	movzbl (%rax),%eax
  801543:	3c 39                	cmp    $0x39,%al
  801545:	7f 12                	jg     801559 <strtol+0xf0>
  801547:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80154b:	0f b6 00             	movzbl (%rax),%eax
  80154e:	0f be c0             	movsbl %al,%eax
  801551:	83 e8 30             	sub    $0x30,%eax
  801554:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801557:	eb 4e                	jmp    8015a7 <strtol+0x13e>
  801559:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80155d:	0f b6 00             	movzbl (%rax),%eax
  801560:	3c 60                	cmp    $0x60,%al
  801562:	7e 1d                	jle    801581 <strtol+0x118>
  801564:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801568:	0f b6 00             	movzbl (%rax),%eax
  80156b:	3c 7a                	cmp    $0x7a,%al
  80156d:	7f 12                	jg     801581 <strtol+0x118>
  80156f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801573:	0f b6 00             	movzbl (%rax),%eax
  801576:	0f be c0             	movsbl %al,%eax
  801579:	83 e8 57             	sub    $0x57,%eax
  80157c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80157f:	eb 26                	jmp    8015a7 <strtol+0x13e>
  801581:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801585:	0f b6 00             	movzbl (%rax),%eax
  801588:	3c 40                	cmp    $0x40,%al
  80158a:	7e 48                	jle    8015d4 <strtol+0x16b>
  80158c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801590:	0f b6 00             	movzbl (%rax),%eax
  801593:	3c 5a                	cmp    $0x5a,%al
  801595:	7f 3d                	jg     8015d4 <strtol+0x16b>
  801597:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80159b:	0f b6 00             	movzbl (%rax),%eax
  80159e:	0f be c0             	movsbl %al,%eax
  8015a1:	83 e8 37             	sub    $0x37,%eax
  8015a4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8015aa:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  8015ad:	7c 02                	jl     8015b1 <strtol+0x148>
  8015af:	eb 23                	jmp    8015d4 <strtol+0x16b>
  8015b1:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015b6:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8015b9:	48 98                	cltq   
  8015bb:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8015c0:	48 89 c2             	mov    %rax,%rdx
  8015c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8015c6:	48 98                	cltq   
  8015c8:	48 01 d0             	add    %rdx,%rax
  8015cb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8015cf:	e9 5d ff ff ff       	jmpq   801531 <strtol+0xc8>
  8015d4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8015d9:	74 0b                	je     8015e6 <strtol+0x17d>
  8015db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8015df:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8015e3:	48 89 10             	mov    %rdx,(%rax)
  8015e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8015ea:	74 09                	je     8015f5 <strtol+0x18c>
  8015ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015f0:	48 f7 d8             	neg    %rax
  8015f3:	eb 04                	jmp    8015f9 <strtol+0x190>
  8015f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015f9:	c9                   	leaveq 
  8015fa:	c3                   	retq   

00000000008015fb <strstr>:
  8015fb:	55                   	push   %rbp
  8015fc:	48 89 e5             	mov    %rsp,%rbp
  8015ff:	48 83 ec 30          	sub    $0x30,%rsp
  801603:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801607:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80160b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80160f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801613:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801617:	0f b6 00             	movzbl (%rax),%eax
  80161a:	88 45 ff             	mov    %al,-0x1(%rbp)
  80161d:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801621:	75 06                	jne    801629 <strstr+0x2e>
  801623:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801627:	eb 6b                	jmp    801694 <strstr+0x99>
  801629:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80162d:	48 89 c7             	mov    %rax,%rdi
  801630:	48 b8 d1 0e 80 00 00 	movabs $0x800ed1,%rax
  801637:	00 00 00 
  80163a:	ff d0                	callq  *%rax
  80163c:	48 98                	cltq   
  80163e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801642:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801646:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80164a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80164e:	0f b6 00             	movzbl (%rax),%eax
  801651:	88 45 ef             	mov    %al,-0x11(%rbp)
  801654:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801658:	75 07                	jne    801661 <strstr+0x66>
  80165a:	b8 00 00 00 00       	mov    $0x0,%eax
  80165f:	eb 33                	jmp    801694 <strstr+0x99>
  801661:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801665:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801668:	75 d8                	jne    801642 <strstr+0x47>
  80166a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80166e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801672:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801676:	48 89 ce             	mov    %rcx,%rsi
  801679:	48 89 c7             	mov    %rax,%rdi
  80167c:	48 b8 f2 10 80 00 00 	movabs $0x8010f2,%rax
  801683:	00 00 00 
  801686:	ff d0                	callq  *%rax
  801688:	85 c0                	test   %eax,%eax
  80168a:	75 b6                	jne    801642 <strstr+0x47>
  80168c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801690:	48 83 e8 01          	sub    $0x1,%rax
  801694:	c9                   	leaveq 
  801695:	c3                   	retq   

0000000000801696 <syscall>:
  801696:	55                   	push   %rbp
  801697:	48 89 e5             	mov    %rsp,%rbp
  80169a:	53                   	push   %rbx
  80169b:	48 83 ec 48          	sub    $0x48,%rsp
  80169f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8016a2:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8016a5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8016a9:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  8016ad:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8016b1:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  8016b5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8016b8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8016bc:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8016c0:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8016c4:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8016c8:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8016cc:	4c 89 c3             	mov    %r8,%rbx
  8016cf:	cd 30                	int    $0x30
  8016d1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8016d5:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8016d9:	74 3e                	je     801719 <syscall+0x83>
  8016db:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8016e0:	7e 37                	jle    801719 <syscall+0x83>
  8016e2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8016e6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8016e9:	49 89 d0             	mov    %rdx,%r8
  8016ec:	89 c1                	mov    %eax,%ecx
  8016ee:	48 ba 08 4c 80 00 00 	movabs $0x804c08,%rdx
  8016f5:	00 00 00 
  8016f8:	be 24 00 00 00       	mov    $0x24,%esi
  8016fd:	48 bf 25 4c 80 00 00 	movabs $0x804c25,%rdi
  801704:	00 00 00 
  801707:	b8 00 00 00 00       	mov    $0x0,%eax
  80170c:	49 b9 e8 42 80 00 00 	movabs $0x8042e8,%r9
  801713:	00 00 00 
  801716:	41 ff d1             	callq  *%r9
  801719:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80171d:	48 83 c4 48          	add    $0x48,%rsp
  801721:	5b                   	pop    %rbx
  801722:	5d                   	pop    %rbp
  801723:	c3                   	retq   

0000000000801724 <sys_cputs>:
  801724:	55                   	push   %rbp
  801725:	48 89 e5             	mov    %rsp,%rbp
  801728:	48 83 ec 20          	sub    $0x20,%rsp
  80172c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801730:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801734:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801738:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80173c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801743:	00 
  801744:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80174a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801750:	48 89 d1             	mov    %rdx,%rcx
  801753:	48 89 c2             	mov    %rax,%rdx
  801756:	be 00 00 00 00       	mov    $0x0,%esi
  80175b:	bf 00 00 00 00       	mov    $0x0,%edi
  801760:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801767:	00 00 00 
  80176a:	ff d0                	callq  *%rax
  80176c:	c9                   	leaveq 
  80176d:	c3                   	retq   

000000000080176e <sys_cgetc>:
  80176e:	55                   	push   %rbp
  80176f:	48 89 e5             	mov    %rsp,%rbp
  801772:	48 83 ec 10          	sub    $0x10,%rsp
  801776:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80177d:	00 
  80177e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801784:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80178a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80178f:	ba 00 00 00 00       	mov    $0x0,%edx
  801794:	be 00 00 00 00       	mov    $0x0,%esi
  801799:	bf 01 00 00 00       	mov    $0x1,%edi
  80179e:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  8017a5:	00 00 00 
  8017a8:	ff d0                	callq  *%rax
  8017aa:	c9                   	leaveq 
  8017ab:	c3                   	retq   

00000000008017ac <sys_env_destroy>:
  8017ac:	55                   	push   %rbp
  8017ad:	48 89 e5             	mov    %rsp,%rbp
  8017b0:	48 83 ec 10          	sub    $0x10,%rsp
  8017b4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8017b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8017ba:	48 98                	cltq   
  8017bc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017c3:	00 
  8017c4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8017ca:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  8017d5:	48 89 c2             	mov    %rax,%rdx
  8017d8:	be 01 00 00 00       	mov    $0x1,%esi
  8017dd:	bf 03 00 00 00       	mov    $0x3,%edi
  8017e2:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  8017e9:	00 00 00 
  8017ec:	ff d0                	callq  *%rax
  8017ee:	c9                   	leaveq 
  8017ef:	c3                   	retq   

00000000008017f0 <sys_getenvid>:
  8017f0:	55                   	push   %rbp
  8017f1:	48 89 e5             	mov    %rsp,%rbp
  8017f4:	48 83 ec 10          	sub    $0x10,%rsp
  8017f8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017ff:	00 
  801800:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801806:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80180c:	b9 00 00 00 00       	mov    $0x0,%ecx
  801811:	ba 00 00 00 00       	mov    $0x0,%edx
  801816:	be 00 00 00 00       	mov    $0x0,%esi
  80181b:	bf 02 00 00 00       	mov    $0x2,%edi
  801820:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801827:	00 00 00 
  80182a:	ff d0                	callq  *%rax
  80182c:	c9                   	leaveq 
  80182d:	c3                   	retq   

000000000080182e <sys_yield>:
  80182e:	55                   	push   %rbp
  80182f:	48 89 e5             	mov    %rsp,%rbp
  801832:	48 83 ec 10          	sub    $0x10,%rsp
  801836:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80183d:	00 
  80183e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801844:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80184a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80184f:	ba 00 00 00 00       	mov    $0x0,%edx
  801854:	be 00 00 00 00       	mov    $0x0,%esi
  801859:	bf 0b 00 00 00       	mov    $0xb,%edi
  80185e:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801865:	00 00 00 
  801868:	ff d0                	callq  *%rax
  80186a:	c9                   	leaveq 
  80186b:	c3                   	retq   

000000000080186c <sys_page_alloc>:
  80186c:	55                   	push   %rbp
  80186d:	48 89 e5             	mov    %rsp,%rbp
  801870:	48 83 ec 20          	sub    $0x20,%rsp
  801874:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801877:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80187b:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80187e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801881:	48 63 c8             	movslq %eax,%rcx
  801884:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801888:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80188b:	48 98                	cltq   
  80188d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801894:	00 
  801895:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80189b:	49 89 c8             	mov    %rcx,%r8
  80189e:	48 89 d1             	mov    %rdx,%rcx
  8018a1:	48 89 c2             	mov    %rax,%rdx
  8018a4:	be 01 00 00 00       	mov    $0x1,%esi
  8018a9:	bf 04 00 00 00       	mov    $0x4,%edi
  8018ae:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  8018b5:	00 00 00 
  8018b8:	ff d0                	callq  *%rax
  8018ba:	c9                   	leaveq 
  8018bb:	c3                   	retq   

00000000008018bc <sys_page_map>:
  8018bc:	55                   	push   %rbp
  8018bd:	48 89 e5             	mov    %rsp,%rbp
  8018c0:	48 83 ec 30          	sub    $0x30,%rsp
  8018c4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018c7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018cb:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8018ce:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8018d2:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8018d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8018d9:	48 63 c8             	movslq %eax,%rcx
  8018dc:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8018e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8018e3:	48 63 f0             	movslq %eax,%rsi
  8018e6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018ed:	48 98                	cltq   
  8018ef:	48 89 0c 24          	mov    %rcx,(%rsp)
  8018f3:	49 89 f9             	mov    %rdi,%r9
  8018f6:	49 89 f0             	mov    %rsi,%r8
  8018f9:	48 89 d1             	mov    %rdx,%rcx
  8018fc:	48 89 c2             	mov    %rax,%rdx
  8018ff:	be 01 00 00 00       	mov    $0x1,%esi
  801904:	bf 05 00 00 00       	mov    $0x5,%edi
  801909:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801910:	00 00 00 
  801913:	ff d0                	callq  *%rax
  801915:	c9                   	leaveq 
  801916:	c3                   	retq   

0000000000801917 <sys_page_unmap>:
  801917:	55                   	push   %rbp
  801918:	48 89 e5             	mov    %rsp,%rbp
  80191b:	48 83 ec 20          	sub    $0x20,%rsp
  80191f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801922:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801926:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80192a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80192d:	48 98                	cltq   
  80192f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801936:	00 
  801937:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80193d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801943:	48 89 d1             	mov    %rdx,%rcx
  801946:	48 89 c2             	mov    %rax,%rdx
  801949:	be 01 00 00 00       	mov    $0x1,%esi
  80194e:	bf 06 00 00 00       	mov    $0x6,%edi
  801953:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  80195a:	00 00 00 
  80195d:	ff d0                	callq  *%rax
  80195f:	c9                   	leaveq 
  801960:	c3                   	retq   

0000000000801961 <sys_env_set_status>:
  801961:	55                   	push   %rbp
  801962:	48 89 e5             	mov    %rsp,%rbp
  801965:	48 83 ec 10          	sub    $0x10,%rsp
  801969:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80196c:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80196f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801972:	48 63 d0             	movslq %eax,%rdx
  801975:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801978:	48 98                	cltq   
  80197a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801981:	00 
  801982:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801988:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80198e:	48 89 d1             	mov    %rdx,%rcx
  801991:	48 89 c2             	mov    %rax,%rdx
  801994:	be 01 00 00 00       	mov    $0x1,%esi
  801999:	bf 08 00 00 00       	mov    $0x8,%edi
  80199e:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  8019a5:	00 00 00 
  8019a8:	ff d0                	callq  *%rax
  8019aa:	c9                   	leaveq 
  8019ab:	c3                   	retq   

00000000008019ac <sys_env_set_trapframe>:
  8019ac:	55                   	push   %rbp
  8019ad:	48 89 e5             	mov    %rsp,%rbp
  8019b0:	48 83 ec 20          	sub    $0x20,%rsp
  8019b4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019b7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019bb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019c2:	48 98                	cltq   
  8019c4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019cb:	00 
  8019cc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019d2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019d8:	48 89 d1             	mov    %rdx,%rcx
  8019db:	48 89 c2             	mov    %rax,%rdx
  8019de:	be 01 00 00 00       	mov    $0x1,%esi
  8019e3:	bf 09 00 00 00       	mov    $0x9,%edi
  8019e8:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  8019ef:	00 00 00 
  8019f2:	ff d0                	callq  *%rax
  8019f4:	c9                   	leaveq 
  8019f5:	c3                   	retq   

00000000008019f6 <sys_env_set_pgfault_upcall>:
  8019f6:	55                   	push   %rbp
  8019f7:	48 89 e5             	mov    %rsp,%rbp
  8019fa:	48 83 ec 20          	sub    $0x20,%rsp
  8019fe:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a01:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a05:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a0c:	48 98                	cltq   
  801a0e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a15:	00 
  801a16:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a1c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a22:	48 89 d1             	mov    %rdx,%rcx
  801a25:	48 89 c2             	mov    %rax,%rdx
  801a28:	be 01 00 00 00       	mov    $0x1,%esi
  801a2d:	bf 0a 00 00 00       	mov    $0xa,%edi
  801a32:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801a39:	00 00 00 
  801a3c:	ff d0                	callq  *%rax
  801a3e:	c9                   	leaveq 
  801a3f:	c3                   	retq   

0000000000801a40 <sys_ipc_try_send>:
  801a40:	55                   	push   %rbp
  801a41:	48 89 e5             	mov    %rsp,%rbp
  801a44:	48 83 ec 20          	sub    $0x20,%rsp
  801a48:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a4b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a4f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801a53:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801a56:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a59:	48 63 f0             	movslq %eax,%rsi
  801a5c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801a60:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a63:	48 98                	cltq   
  801a65:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a69:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a70:	00 
  801a71:	49 89 f1             	mov    %rsi,%r9
  801a74:	49 89 c8             	mov    %rcx,%r8
  801a77:	48 89 d1             	mov    %rdx,%rcx
  801a7a:	48 89 c2             	mov    %rax,%rdx
  801a7d:	be 00 00 00 00       	mov    $0x0,%esi
  801a82:	bf 0c 00 00 00       	mov    $0xc,%edi
  801a87:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801a8e:	00 00 00 
  801a91:	ff d0                	callq  *%rax
  801a93:	c9                   	leaveq 
  801a94:	c3                   	retq   

0000000000801a95 <sys_ipc_recv>:
  801a95:	55                   	push   %rbp
  801a96:	48 89 e5             	mov    %rsp,%rbp
  801a99:	48 83 ec 10          	sub    $0x10,%rsp
  801a9d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801aa1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801aa5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aac:	00 
  801aad:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ab3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ab9:	b9 00 00 00 00       	mov    $0x0,%ecx
  801abe:	48 89 c2             	mov    %rax,%rdx
  801ac1:	be 01 00 00 00       	mov    $0x1,%esi
  801ac6:	bf 0d 00 00 00       	mov    $0xd,%edi
  801acb:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801ad2:	00 00 00 
  801ad5:	ff d0                	callq  *%rax
  801ad7:	c9                   	leaveq 
  801ad8:	c3                   	retq   

0000000000801ad9 <sys_time_msec>:
  801ad9:	55                   	push   %rbp
  801ada:	48 89 e5             	mov    %rsp,%rbp
  801add:	48 83 ec 10          	sub    $0x10,%rsp
  801ae1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ae8:	00 
  801ae9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801aef:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801af5:	b9 00 00 00 00       	mov    $0x0,%ecx
  801afa:	ba 00 00 00 00       	mov    $0x0,%edx
  801aff:	be 00 00 00 00       	mov    $0x0,%esi
  801b04:	bf 0e 00 00 00       	mov    $0xe,%edi
  801b09:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801b10:	00 00 00 
  801b13:	ff d0                	callq  *%rax
  801b15:	c9                   	leaveq 
  801b16:	c3                   	retq   

0000000000801b17 <sys_net_transmit>:
  801b17:	55                   	push   %rbp
  801b18:	48 89 e5             	mov    %rsp,%rbp
  801b1b:	48 83 ec 20          	sub    $0x20,%rsp
  801b1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b23:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b26:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b2d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b34:	00 
  801b35:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b3b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b41:	48 89 d1             	mov    %rdx,%rcx
  801b44:	48 89 c2             	mov    %rax,%rdx
  801b47:	be 00 00 00 00       	mov    $0x0,%esi
  801b4c:	bf 0f 00 00 00       	mov    $0xf,%edi
  801b51:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801b58:	00 00 00 
  801b5b:	ff d0                	callq  *%rax
  801b5d:	c9                   	leaveq 
  801b5e:	c3                   	retq   

0000000000801b5f <sys_net_receive>:
  801b5f:	55                   	push   %rbp
  801b60:	48 89 e5             	mov    %rsp,%rbp
  801b63:	48 83 ec 20          	sub    $0x20,%rsp
  801b67:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b6b:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b6e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801b71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b75:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b7c:	00 
  801b7d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b83:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b89:	48 89 d1             	mov    %rdx,%rcx
  801b8c:	48 89 c2             	mov    %rax,%rdx
  801b8f:	be 00 00 00 00       	mov    $0x0,%esi
  801b94:	bf 10 00 00 00       	mov    $0x10,%edi
  801b99:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801ba0:	00 00 00 
  801ba3:	ff d0                	callq  *%rax
  801ba5:	c9                   	leaveq 
  801ba6:	c3                   	retq   

0000000000801ba7 <sys_ept_map>:
  801ba7:	55                   	push   %rbp
  801ba8:	48 89 e5             	mov    %rsp,%rbp
  801bab:	48 83 ec 30          	sub    $0x30,%rsp
  801baf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bb2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bb6:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801bb9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801bbd:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801bc1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801bc4:	48 63 c8             	movslq %eax,%rcx
  801bc7:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801bcb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bce:	48 63 f0             	movslq %eax,%rsi
  801bd1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bd5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bd8:	48 98                	cltq   
  801bda:	48 89 0c 24          	mov    %rcx,(%rsp)
  801bde:	49 89 f9             	mov    %rdi,%r9
  801be1:	49 89 f0             	mov    %rsi,%r8
  801be4:	48 89 d1             	mov    %rdx,%rcx
  801be7:	48 89 c2             	mov    %rax,%rdx
  801bea:	be 00 00 00 00       	mov    $0x0,%esi
  801bef:	bf 11 00 00 00       	mov    $0x11,%edi
  801bf4:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801bfb:	00 00 00 
  801bfe:	ff d0                	callq  *%rax
  801c00:	c9                   	leaveq 
  801c01:	c3                   	retq   

0000000000801c02 <sys_env_mkguest>:
  801c02:	55                   	push   %rbp
  801c03:	48 89 e5             	mov    %rsp,%rbp
  801c06:	48 83 ec 20          	sub    $0x20,%rsp
  801c0a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c0e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c12:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c1a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c21:	00 
  801c22:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c28:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c2e:	48 89 d1             	mov    %rdx,%rcx
  801c31:	48 89 c2             	mov    %rax,%rdx
  801c34:	be 00 00 00 00       	mov    $0x0,%esi
  801c39:	bf 12 00 00 00       	mov    $0x12,%edi
  801c3e:	48 b8 96 16 80 00 00 	movabs $0x801696,%rax
  801c45:	00 00 00 
  801c48:	ff d0                	callq  *%rax
  801c4a:	c9                   	leaveq 
  801c4b:	c3                   	retq   

0000000000801c4c <argstart>:
  801c4c:	55                   	push   %rbp
  801c4d:	48 89 e5             	mov    %rsp,%rbp
  801c50:	48 83 ec 18          	sub    $0x18,%rsp
  801c54:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c58:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c5c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801c60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c64:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801c68:	48 89 10             	mov    %rdx,(%rax)
  801c6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c6f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c73:	48 89 50 08          	mov    %rdx,0x8(%rax)
  801c77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c7b:	8b 00                	mov    (%rax),%eax
  801c7d:	83 f8 01             	cmp    $0x1,%eax
  801c80:	7e 13                	jle    801c95 <argstart+0x49>
  801c82:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
  801c87:	74 0c                	je     801c95 <argstart+0x49>
  801c89:	48 b8 36 4c 80 00 00 	movabs $0x804c36,%rax
  801c90:	00 00 00 
  801c93:	eb 05                	jmp    801c9a <argstart+0x4e>
  801c95:	b8 00 00 00 00       	mov    $0x0,%eax
  801c9a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801c9e:	48 89 42 10          	mov    %rax,0x10(%rdx)
  801ca2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ca6:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  801cad:	00 
  801cae:	c9                   	leaveq 
  801caf:	c3                   	retq   

0000000000801cb0 <argnext>:
  801cb0:	55                   	push   %rbp
  801cb1:	48 89 e5             	mov    %rsp,%rbp
  801cb4:	48 83 ec 20          	sub    $0x20,%rsp
  801cb8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801cbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801cc0:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  801cc7:	00 
  801cc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ccc:	48 8b 40 10          	mov    0x10(%rax),%rax
  801cd0:	48 85 c0             	test   %rax,%rax
  801cd3:	75 0a                	jne    801cdf <argnext+0x2f>
  801cd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  801cda:	e9 25 01 00 00       	jmpq   801e04 <argnext+0x154>
  801cdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ce3:	48 8b 40 10          	mov    0x10(%rax),%rax
  801ce7:	0f b6 00             	movzbl (%rax),%eax
  801cea:	84 c0                	test   %al,%al
  801cec:	0f 85 d7 00 00 00    	jne    801dc9 <argnext+0x119>
  801cf2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801cf6:	48 8b 00             	mov    (%rax),%rax
  801cf9:	8b 00                	mov    (%rax),%eax
  801cfb:	83 f8 01             	cmp    $0x1,%eax
  801cfe:	0f 84 ef 00 00 00    	je     801df3 <argnext+0x143>
  801d04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d08:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d0c:	48 83 c0 08          	add    $0x8,%rax
  801d10:	48 8b 00             	mov    (%rax),%rax
  801d13:	0f b6 00             	movzbl (%rax),%eax
  801d16:	3c 2d                	cmp    $0x2d,%al
  801d18:	0f 85 d5 00 00 00    	jne    801df3 <argnext+0x143>
  801d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d22:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d26:	48 83 c0 08          	add    $0x8,%rax
  801d2a:	48 8b 00             	mov    (%rax),%rax
  801d2d:	48 83 c0 01          	add    $0x1,%rax
  801d31:	0f b6 00             	movzbl (%rax),%eax
  801d34:	84 c0                	test   %al,%al
  801d36:	0f 84 b7 00 00 00    	je     801df3 <argnext+0x143>
  801d3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d40:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d44:	48 83 c0 08          	add    $0x8,%rax
  801d48:	48 8b 00             	mov    (%rax),%rax
  801d4b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801d4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d53:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801d57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d5b:	48 8b 00             	mov    (%rax),%rax
  801d5e:	8b 00                	mov    (%rax),%eax
  801d60:	83 e8 01             	sub    $0x1,%eax
  801d63:	48 98                	cltq   
  801d65:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  801d6c:	00 
  801d6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d71:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d75:	48 8d 48 10          	lea    0x10(%rax),%rcx
  801d79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d7d:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d81:	48 83 c0 08          	add    $0x8,%rax
  801d85:	48 89 ce             	mov    %rcx,%rsi
  801d88:	48 89 c7             	mov    %rax,%rdi
  801d8b:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  801d92:	00 00 00 
  801d95:	ff d0                	callq  *%rax
  801d97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d9b:	48 8b 00             	mov    (%rax),%rax
  801d9e:	8b 10                	mov    (%rax),%edx
  801da0:	83 ea 01             	sub    $0x1,%edx
  801da3:	89 10                	mov    %edx,(%rax)
  801da5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801da9:	48 8b 40 10          	mov    0x10(%rax),%rax
  801dad:	0f b6 00             	movzbl (%rax),%eax
  801db0:	3c 2d                	cmp    $0x2d,%al
  801db2:	75 15                	jne    801dc9 <argnext+0x119>
  801db4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801db8:	48 8b 40 10          	mov    0x10(%rax),%rax
  801dbc:	48 83 c0 01          	add    $0x1,%rax
  801dc0:	0f b6 00             	movzbl (%rax),%eax
  801dc3:	84 c0                	test   %al,%al
  801dc5:	75 02                	jne    801dc9 <argnext+0x119>
  801dc7:	eb 2a                	jmp    801df3 <argnext+0x143>
  801dc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dcd:	48 8b 40 10          	mov    0x10(%rax),%rax
  801dd1:	0f b6 00             	movzbl (%rax),%eax
  801dd4:	0f b6 c0             	movzbl %al,%eax
  801dd7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801dda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dde:	48 8b 40 10          	mov    0x10(%rax),%rax
  801de2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801de6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dea:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801dee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801df1:	eb 11                	jmp    801e04 <argnext+0x154>
  801df3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801df7:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  801dfe:	00 
  801dff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  801e04:	c9                   	leaveq 
  801e05:	c3                   	retq   

0000000000801e06 <argvalue>:
  801e06:	55                   	push   %rbp
  801e07:	48 89 e5             	mov    %rsp,%rbp
  801e0a:	48 83 ec 10          	sub    $0x10,%rsp
  801e0e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e16:	48 8b 40 18          	mov    0x18(%rax),%rax
  801e1a:	48 85 c0             	test   %rax,%rax
  801e1d:	74 0a                	je     801e29 <argvalue+0x23>
  801e1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e23:	48 8b 40 18          	mov    0x18(%rax),%rax
  801e27:	eb 13                	jmp    801e3c <argvalue+0x36>
  801e29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e2d:	48 89 c7             	mov    %rax,%rdi
  801e30:	48 b8 3e 1e 80 00 00 	movabs $0x801e3e,%rax
  801e37:	00 00 00 
  801e3a:	ff d0                	callq  *%rax
  801e3c:	c9                   	leaveq 
  801e3d:	c3                   	retq   

0000000000801e3e <argnextvalue>:
  801e3e:	55                   	push   %rbp
  801e3f:	48 89 e5             	mov    %rsp,%rbp
  801e42:	53                   	push   %rbx
  801e43:	48 83 ec 18          	sub    $0x18,%rsp
  801e47:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801e4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e4f:	48 8b 40 10          	mov    0x10(%rax),%rax
  801e53:	48 85 c0             	test   %rax,%rax
  801e56:	75 0a                	jne    801e62 <argnextvalue+0x24>
  801e58:	b8 00 00 00 00       	mov    $0x0,%eax
  801e5d:	e9 c8 00 00 00       	jmpq   801f2a <argnextvalue+0xec>
  801e62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e66:	48 8b 40 10          	mov    0x10(%rax),%rax
  801e6a:	0f b6 00             	movzbl (%rax),%eax
  801e6d:	84 c0                	test   %al,%al
  801e6f:	74 27                	je     801e98 <argnextvalue+0x5a>
  801e71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e75:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801e79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e7d:	48 89 50 18          	mov    %rdx,0x18(%rax)
  801e81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e85:	48 bb 36 4c 80 00 00 	movabs $0x804c36,%rbx
  801e8c:	00 00 00 
  801e8f:	48 89 58 10          	mov    %rbx,0x10(%rax)
  801e93:	e9 8a 00 00 00       	jmpq   801f22 <argnextvalue+0xe4>
  801e98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e9c:	48 8b 00             	mov    (%rax),%rax
  801e9f:	8b 00                	mov    (%rax),%eax
  801ea1:	83 f8 01             	cmp    $0x1,%eax
  801ea4:	7e 64                	jle    801f0a <argnextvalue+0xcc>
  801ea6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801eaa:	48 8b 40 08          	mov    0x8(%rax),%rax
  801eae:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801eb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801eb6:	48 89 50 18          	mov    %rdx,0x18(%rax)
  801eba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ebe:	48 8b 00             	mov    (%rax),%rax
  801ec1:	8b 00                	mov    (%rax),%eax
  801ec3:	83 e8 01             	sub    $0x1,%eax
  801ec6:	48 98                	cltq   
  801ec8:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  801ecf:	00 
  801ed0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ed4:	48 8b 40 08          	mov    0x8(%rax),%rax
  801ed8:	48 8d 48 10          	lea    0x10(%rax),%rcx
  801edc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ee0:	48 8b 40 08          	mov    0x8(%rax),%rax
  801ee4:	48 83 c0 08          	add    $0x8,%rax
  801ee8:	48 89 ce             	mov    %rcx,%rsi
  801eeb:	48 89 c7             	mov    %rax,%rdi
  801eee:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  801ef5:	00 00 00 
  801ef8:	ff d0                	callq  *%rax
  801efa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801efe:	48 8b 00             	mov    (%rax),%rax
  801f01:	8b 10                	mov    (%rax),%edx
  801f03:	83 ea 01             	sub    $0x1,%edx
  801f06:	89 10                	mov    %edx,(%rax)
  801f08:	eb 18                	jmp    801f22 <argnextvalue+0xe4>
  801f0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f0e:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  801f15:	00 
  801f16:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f1a:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  801f21:	00 
  801f22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f26:	48 8b 40 18          	mov    0x18(%rax),%rax
  801f2a:	48 83 c4 18          	add    $0x18,%rsp
  801f2e:	5b                   	pop    %rbx
  801f2f:	5d                   	pop    %rbp
  801f30:	c3                   	retq   

0000000000801f31 <fd2num>:
  801f31:	55                   	push   %rbp
  801f32:	48 89 e5             	mov    %rsp,%rbp
  801f35:	48 83 ec 08          	sub    $0x8,%rsp
  801f39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f3d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f41:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801f48:	ff ff ff 
  801f4b:	48 01 d0             	add    %rdx,%rax
  801f4e:	48 c1 e8 0c          	shr    $0xc,%rax
  801f52:	c9                   	leaveq 
  801f53:	c3                   	retq   

0000000000801f54 <fd2data>:
  801f54:	55                   	push   %rbp
  801f55:	48 89 e5             	mov    %rsp,%rbp
  801f58:	48 83 ec 08          	sub    $0x8,%rsp
  801f5c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f64:	48 89 c7             	mov    %rax,%rdi
  801f67:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  801f6e:	00 00 00 
  801f71:	ff d0                	callq  *%rax
  801f73:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801f79:	48 c1 e0 0c          	shl    $0xc,%rax
  801f7d:	c9                   	leaveq 
  801f7e:	c3                   	retq   

0000000000801f7f <fd_alloc>:
  801f7f:	55                   	push   %rbp
  801f80:	48 89 e5             	mov    %rsp,%rbp
  801f83:	48 83 ec 18          	sub    $0x18,%rsp
  801f87:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801f8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801f92:	eb 6b                	jmp    801fff <fd_alloc+0x80>
  801f94:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f97:	48 98                	cltq   
  801f99:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801f9f:	48 c1 e0 0c          	shl    $0xc,%rax
  801fa3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801fa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fab:	48 c1 e8 15          	shr    $0x15,%rax
  801faf:	48 89 c2             	mov    %rax,%rdx
  801fb2:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801fb9:	01 00 00 
  801fbc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fc0:	83 e0 01             	and    $0x1,%eax
  801fc3:	48 85 c0             	test   %rax,%rax
  801fc6:	74 21                	je     801fe9 <fd_alloc+0x6a>
  801fc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fcc:	48 c1 e8 0c          	shr    $0xc,%rax
  801fd0:	48 89 c2             	mov    %rax,%rdx
  801fd3:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fda:	01 00 00 
  801fdd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fe1:	83 e0 01             	and    $0x1,%eax
  801fe4:	48 85 c0             	test   %rax,%rax
  801fe7:	75 12                	jne    801ffb <fd_alloc+0x7c>
  801fe9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801fed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ff1:	48 89 10             	mov    %rdx,(%rax)
  801ff4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ff9:	eb 1a                	jmp    802015 <fd_alloc+0x96>
  801ffb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801fff:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802003:	7e 8f                	jle    801f94 <fd_alloc+0x15>
  802005:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802009:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802010:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802015:	c9                   	leaveq 
  802016:	c3                   	retq   

0000000000802017 <fd_lookup>:
  802017:	55                   	push   %rbp
  802018:	48 89 e5             	mov    %rsp,%rbp
  80201b:	48 83 ec 20          	sub    $0x20,%rsp
  80201f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802022:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802026:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80202a:	78 06                	js     802032 <fd_lookup+0x1b>
  80202c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802030:	7e 07                	jle    802039 <fd_lookup+0x22>
  802032:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802037:	eb 6c                	jmp    8020a5 <fd_lookup+0x8e>
  802039:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80203c:	48 98                	cltq   
  80203e:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802044:	48 c1 e0 0c          	shl    $0xc,%rax
  802048:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80204c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802050:	48 c1 e8 15          	shr    $0x15,%rax
  802054:	48 89 c2             	mov    %rax,%rdx
  802057:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80205e:	01 00 00 
  802061:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802065:	83 e0 01             	and    $0x1,%eax
  802068:	48 85 c0             	test   %rax,%rax
  80206b:	74 21                	je     80208e <fd_lookup+0x77>
  80206d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802071:	48 c1 e8 0c          	shr    $0xc,%rax
  802075:	48 89 c2             	mov    %rax,%rdx
  802078:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80207f:	01 00 00 
  802082:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802086:	83 e0 01             	and    $0x1,%eax
  802089:	48 85 c0             	test   %rax,%rax
  80208c:	75 07                	jne    802095 <fd_lookup+0x7e>
  80208e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802093:	eb 10                	jmp    8020a5 <fd_lookup+0x8e>
  802095:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802099:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80209d:	48 89 10             	mov    %rdx,(%rax)
  8020a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8020a5:	c9                   	leaveq 
  8020a6:	c3                   	retq   

00000000008020a7 <fd_close>:
  8020a7:	55                   	push   %rbp
  8020a8:	48 89 e5             	mov    %rsp,%rbp
  8020ab:	48 83 ec 30          	sub    $0x30,%rsp
  8020af:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8020b3:	89 f0                	mov    %esi,%eax
  8020b5:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8020b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020bc:	48 89 c7             	mov    %rax,%rdi
  8020bf:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  8020c6:	00 00 00 
  8020c9:	ff d0                	callq  *%rax
  8020cb:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8020cf:	48 89 d6             	mov    %rdx,%rsi
  8020d2:	89 c7                	mov    %eax,%edi
  8020d4:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  8020db:	00 00 00 
  8020de:	ff d0                	callq  *%rax
  8020e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8020e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8020e7:	78 0a                	js     8020f3 <fd_close+0x4c>
  8020e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8020ed:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8020f1:	74 12                	je     802105 <fd_close+0x5e>
  8020f3:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8020f7:	74 05                	je     8020fe <fd_close+0x57>
  8020f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020fc:	eb 05                	jmp    802103 <fd_close+0x5c>
  8020fe:	b8 00 00 00 00       	mov    $0x0,%eax
  802103:	eb 69                	jmp    80216e <fd_close+0xc7>
  802105:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802109:	8b 00                	mov    (%rax),%eax
  80210b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80210f:	48 89 d6             	mov    %rdx,%rsi
  802112:	89 c7                	mov    %eax,%edi
  802114:	48 b8 70 21 80 00 00 	movabs $0x802170,%rax
  80211b:	00 00 00 
  80211e:	ff d0                	callq  *%rax
  802120:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802123:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802127:	78 2a                	js     802153 <fd_close+0xac>
  802129:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80212d:	48 8b 40 20          	mov    0x20(%rax),%rax
  802131:	48 85 c0             	test   %rax,%rax
  802134:	74 16                	je     80214c <fd_close+0xa5>
  802136:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80213a:	48 8b 40 20          	mov    0x20(%rax),%rax
  80213e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802142:	48 89 d7             	mov    %rdx,%rdi
  802145:	ff d0                	callq  *%rax
  802147:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80214a:	eb 07                	jmp    802153 <fd_close+0xac>
  80214c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802153:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802157:	48 89 c6             	mov    %rax,%rsi
  80215a:	bf 00 00 00 00       	mov    $0x0,%edi
  80215f:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  802166:	00 00 00 
  802169:	ff d0                	callq  *%rax
  80216b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80216e:	c9                   	leaveq 
  80216f:	c3                   	retq   

0000000000802170 <dev_lookup>:
  802170:	55                   	push   %rbp
  802171:	48 89 e5             	mov    %rsp,%rbp
  802174:	48 83 ec 20          	sub    $0x20,%rsp
  802178:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80217b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80217f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802186:	eb 41                	jmp    8021c9 <dev_lookup+0x59>
  802188:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  80218f:	00 00 00 
  802192:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802195:	48 63 d2             	movslq %edx,%rdx
  802198:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80219c:	8b 00                	mov    (%rax),%eax
  80219e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8021a1:	75 22                	jne    8021c5 <dev_lookup+0x55>
  8021a3:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  8021aa:	00 00 00 
  8021ad:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8021b0:	48 63 d2             	movslq %edx,%rdx
  8021b3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8021b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021bb:	48 89 10             	mov    %rdx,(%rax)
  8021be:	b8 00 00 00 00       	mov    $0x0,%eax
  8021c3:	eb 60                	jmp    802225 <dev_lookup+0xb5>
  8021c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8021c9:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  8021d0:	00 00 00 
  8021d3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8021d6:	48 63 d2             	movslq %edx,%rdx
  8021d9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021dd:	48 85 c0             	test   %rax,%rax
  8021e0:	75 a6                	jne    802188 <dev_lookup+0x18>
  8021e2:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8021e9:	00 00 00 
  8021ec:	48 8b 00             	mov    (%rax),%rax
  8021ef:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8021f5:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8021f8:	89 c6                	mov    %eax,%esi
  8021fa:	48 bf 38 4c 80 00 00 	movabs $0x804c38,%rdi
  802201:	00 00 00 
  802204:	b8 00 00 00 00       	mov    $0x0,%eax
  802209:	48 b9 88 03 80 00 00 	movabs $0x800388,%rcx
  802210:	00 00 00 
  802213:	ff d1                	callq  *%rcx
  802215:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802219:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802220:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802225:	c9                   	leaveq 
  802226:	c3                   	retq   

0000000000802227 <close>:
  802227:	55                   	push   %rbp
  802228:	48 89 e5             	mov    %rsp,%rbp
  80222b:	48 83 ec 20          	sub    $0x20,%rsp
  80222f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802232:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802236:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802239:	48 89 d6             	mov    %rdx,%rsi
  80223c:	89 c7                	mov    %eax,%edi
  80223e:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  802245:	00 00 00 
  802248:	ff d0                	callq  *%rax
  80224a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80224d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802251:	79 05                	jns    802258 <close+0x31>
  802253:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802256:	eb 18                	jmp    802270 <close+0x49>
  802258:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80225c:	be 01 00 00 00       	mov    $0x1,%esi
  802261:	48 89 c7             	mov    %rax,%rdi
  802264:	48 b8 a7 20 80 00 00 	movabs $0x8020a7,%rax
  80226b:	00 00 00 
  80226e:	ff d0                	callq  *%rax
  802270:	c9                   	leaveq 
  802271:	c3                   	retq   

0000000000802272 <close_all>:
  802272:	55                   	push   %rbp
  802273:	48 89 e5             	mov    %rsp,%rbp
  802276:	48 83 ec 10          	sub    $0x10,%rsp
  80227a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802281:	eb 15                	jmp    802298 <close_all+0x26>
  802283:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802286:	89 c7                	mov    %eax,%edi
  802288:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  80228f:	00 00 00 
  802292:	ff d0                	callq  *%rax
  802294:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802298:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80229c:	7e e5                	jle    802283 <close_all+0x11>
  80229e:	c9                   	leaveq 
  80229f:	c3                   	retq   

00000000008022a0 <dup>:
  8022a0:	55                   	push   %rbp
  8022a1:	48 89 e5             	mov    %rsp,%rbp
  8022a4:	48 83 ec 40          	sub    $0x40,%rsp
  8022a8:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8022ab:	89 75 c8             	mov    %esi,-0x38(%rbp)
  8022ae:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8022b2:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8022b5:	48 89 d6             	mov    %rdx,%rsi
  8022b8:	89 c7                	mov    %eax,%edi
  8022ba:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  8022c1:	00 00 00 
  8022c4:	ff d0                	callq  *%rax
  8022c6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022cd:	79 08                	jns    8022d7 <dup+0x37>
  8022cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022d2:	e9 70 01 00 00       	jmpq   802447 <dup+0x1a7>
  8022d7:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8022da:	89 c7                	mov    %eax,%edi
  8022dc:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  8022e3:	00 00 00 
  8022e6:	ff d0                	callq  *%rax
  8022e8:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8022eb:	48 98                	cltq   
  8022ed:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8022f3:	48 c1 e0 0c          	shl    $0xc,%rax
  8022f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8022fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8022ff:	48 89 c7             	mov    %rax,%rdi
  802302:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  802309:	00 00 00 
  80230c:	ff d0                	callq  *%rax
  80230e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802312:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802316:	48 89 c7             	mov    %rax,%rdi
  802319:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  802320:	00 00 00 
  802323:	ff d0                	callq  *%rax
  802325:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802329:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80232d:	48 c1 e8 15          	shr    $0x15,%rax
  802331:	48 89 c2             	mov    %rax,%rdx
  802334:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80233b:	01 00 00 
  80233e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802342:	83 e0 01             	and    $0x1,%eax
  802345:	48 85 c0             	test   %rax,%rax
  802348:	74 73                	je     8023bd <dup+0x11d>
  80234a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80234e:	48 c1 e8 0c          	shr    $0xc,%rax
  802352:	48 89 c2             	mov    %rax,%rdx
  802355:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80235c:	01 00 00 
  80235f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802363:	83 e0 01             	and    $0x1,%eax
  802366:	48 85 c0             	test   %rax,%rax
  802369:	74 52                	je     8023bd <dup+0x11d>
  80236b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80236f:	48 c1 e8 0c          	shr    $0xc,%rax
  802373:	48 89 c2             	mov    %rax,%rdx
  802376:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80237d:	01 00 00 
  802380:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802384:	25 07 0e 00 00       	and    $0xe07,%eax
  802389:	89 c1                	mov    %eax,%ecx
  80238b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80238f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802393:	41 89 c8             	mov    %ecx,%r8d
  802396:	48 89 d1             	mov    %rdx,%rcx
  802399:	ba 00 00 00 00       	mov    $0x0,%edx
  80239e:	48 89 c6             	mov    %rax,%rsi
  8023a1:	bf 00 00 00 00       	mov    $0x0,%edi
  8023a6:	48 b8 bc 18 80 00 00 	movabs $0x8018bc,%rax
  8023ad:	00 00 00 
  8023b0:	ff d0                	callq  *%rax
  8023b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023b9:	79 02                	jns    8023bd <dup+0x11d>
  8023bb:	eb 57                	jmp    802414 <dup+0x174>
  8023bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023c1:	48 c1 e8 0c          	shr    $0xc,%rax
  8023c5:	48 89 c2             	mov    %rax,%rdx
  8023c8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8023cf:	01 00 00 
  8023d2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023d6:	25 07 0e 00 00       	and    $0xe07,%eax
  8023db:	89 c1                	mov    %eax,%ecx
  8023dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8023e5:	41 89 c8             	mov    %ecx,%r8d
  8023e8:	48 89 d1             	mov    %rdx,%rcx
  8023eb:	ba 00 00 00 00       	mov    $0x0,%edx
  8023f0:	48 89 c6             	mov    %rax,%rsi
  8023f3:	bf 00 00 00 00       	mov    $0x0,%edi
  8023f8:	48 b8 bc 18 80 00 00 	movabs $0x8018bc,%rax
  8023ff:	00 00 00 
  802402:	ff d0                	callq  *%rax
  802404:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802407:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80240b:	79 02                	jns    80240f <dup+0x16f>
  80240d:	eb 05                	jmp    802414 <dup+0x174>
  80240f:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802412:	eb 33                	jmp    802447 <dup+0x1a7>
  802414:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802418:	48 89 c6             	mov    %rax,%rsi
  80241b:	bf 00 00 00 00       	mov    $0x0,%edi
  802420:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  802427:	00 00 00 
  80242a:	ff d0                	callq  *%rax
  80242c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802430:	48 89 c6             	mov    %rax,%rsi
  802433:	bf 00 00 00 00       	mov    $0x0,%edi
  802438:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  80243f:	00 00 00 
  802442:	ff d0                	callq  *%rax
  802444:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802447:	c9                   	leaveq 
  802448:	c3                   	retq   

0000000000802449 <read>:
  802449:	55                   	push   %rbp
  80244a:	48 89 e5             	mov    %rsp,%rbp
  80244d:	48 83 ec 40          	sub    $0x40,%rsp
  802451:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802454:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802458:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80245c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802460:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802463:	48 89 d6             	mov    %rdx,%rsi
  802466:	89 c7                	mov    %eax,%edi
  802468:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  80246f:	00 00 00 
  802472:	ff d0                	callq  *%rax
  802474:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802477:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80247b:	78 24                	js     8024a1 <read+0x58>
  80247d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802481:	8b 00                	mov    (%rax),%eax
  802483:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802487:	48 89 d6             	mov    %rdx,%rsi
  80248a:	89 c7                	mov    %eax,%edi
  80248c:	48 b8 70 21 80 00 00 	movabs $0x802170,%rax
  802493:	00 00 00 
  802496:	ff d0                	callq  *%rax
  802498:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80249b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80249f:	79 05                	jns    8024a6 <read+0x5d>
  8024a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024a4:	eb 76                	jmp    80251c <read+0xd3>
  8024a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8024aa:	8b 40 08             	mov    0x8(%rax),%eax
  8024ad:	83 e0 03             	and    $0x3,%eax
  8024b0:	83 f8 01             	cmp    $0x1,%eax
  8024b3:	75 3a                	jne    8024ef <read+0xa6>
  8024b5:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8024bc:	00 00 00 
  8024bf:	48 8b 00             	mov    (%rax),%rax
  8024c2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8024c8:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8024cb:	89 c6                	mov    %eax,%esi
  8024cd:	48 bf 57 4c 80 00 00 	movabs $0x804c57,%rdi
  8024d4:	00 00 00 
  8024d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8024dc:	48 b9 88 03 80 00 00 	movabs $0x800388,%rcx
  8024e3:	00 00 00 
  8024e6:	ff d1                	callq  *%rcx
  8024e8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024ed:	eb 2d                	jmp    80251c <read+0xd3>
  8024ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024f3:	48 8b 40 10          	mov    0x10(%rax),%rax
  8024f7:	48 85 c0             	test   %rax,%rax
  8024fa:	75 07                	jne    802503 <read+0xba>
  8024fc:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802501:	eb 19                	jmp    80251c <read+0xd3>
  802503:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802507:	48 8b 40 10          	mov    0x10(%rax),%rax
  80250b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80250f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802513:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802517:	48 89 cf             	mov    %rcx,%rdi
  80251a:	ff d0                	callq  *%rax
  80251c:	c9                   	leaveq 
  80251d:	c3                   	retq   

000000000080251e <readn>:
  80251e:	55                   	push   %rbp
  80251f:	48 89 e5             	mov    %rsp,%rbp
  802522:	48 83 ec 30          	sub    $0x30,%rsp
  802526:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802529:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80252d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802538:	eb 49                	jmp    802583 <readn+0x65>
  80253a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80253d:	48 98                	cltq   
  80253f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802543:	48 29 c2             	sub    %rax,%rdx
  802546:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802549:	48 63 c8             	movslq %eax,%rcx
  80254c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802550:	48 01 c1             	add    %rax,%rcx
  802553:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802556:	48 89 ce             	mov    %rcx,%rsi
  802559:	89 c7                	mov    %eax,%edi
  80255b:	48 b8 49 24 80 00 00 	movabs $0x802449,%rax
  802562:	00 00 00 
  802565:	ff d0                	callq  *%rax
  802567:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80256a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80256e:	79 05                	jns    802575 <readn+0x57>
  802570:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802573:	eb 1c                	jmp    802591 <readn+0x73>
  802575:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802579:	75 02                	jne    80257d <readn+0x5f>
  80257b:	eb 11                	jmp    80258e <readn+0x70>
  80257d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802580:	01 45 fc             	add    %eax,-0x4(%rbp)
  802583:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802586:	48 98                	cltq   
  802588:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80258c:	72 ac                	jb     80253a <readn+0x1c>
  80258e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802591:	c9                   	leaveq 
  802592:	c3                   	retq   

0000000000802593 <write>:
  802593:	55                   	push   %rbp
  802594:	48 89 e5             	mov    %rsp,%rbp
  802597:	48 83 ec 40          	sub    $0x40,%rsp
  80259b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80259e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8025a2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8025a6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8025aa:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8025ad:	48 89 d6             	mov    %rdx,%rsi
  8025b0:	89 c7                	mov    %eax,%edi
  8025b2:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  8025b9:	00 00 00 
  8025bc:	ff d0                	callq  *%rax
  8025be:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025c5:	78 24                	js     8025eb <write+0x58>
  8025c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025cb:	8b 00                	mov    (%rax),%eax
  8025cd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8025d1:	48 89 d6             	mov    %rdx,%rsi
  8025d4:	89 c7                	mov    %eax,%edi
  8025d6:	48 b8 70 21 80 00 00 	movabs $0x802170,%rax
  8025dd:	00 00 00 
  8025e0:	ff d0                	callq  *%rax
  8025e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025e9:	79 05                	jns    8025f0 <write+0x5d>
  8025eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025ee:	eb 75                	jmp    802665 <write+0xd2>
  8025f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025f4:	8b 40 08             	mov    0x8(%rax),%eax
  8025f7:	83 e0 03             	and    $0x3,%eax
  8025fa:	85 c0                	test   %eax,%eax
  8025fc:	75 3a                	jne    802638 <write+0xa5>
  8025fe:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802605:	00 00 00 
  802608:	48 8b 00             	mov    (%rax),%rax
  80260b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802611:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802614:	89 c6                	mov    %eax,%esi
  802616:	48 bf 73 4c 80 00 00 	movabs $0x804c73,%rdi
  80261d:	00 00 00 
  802620:	b8 00 00 00 00       	mov    $0x0,%eax
  802625:	48 b9 88 03 80 00 00 	movabs $0x800388,%rcx
  80262c:	00 00 00 
  80262f:	ff d1                	callq  *%rcx
  802631:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802636:	eb 2d                	jmp    802665 <write+0xd2>
  802638:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80263c:	48 8b 40 18          	mov    0x18(%rax),%rax
  802640:	48 85 c0             	test   %rax,%rax
  802643:	75 07                	jne    80264c <write+0xb9>
  802645:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80264a:	eb 19                	jmp    802665 <write+0xd2>
  80264c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802650:	48 8b 40 18          	mov    0x18(%rax),%rax
  802654:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802658:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80265c:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802660:	48 89 cf             	mov    %rcx,%rdi
  802663:	ff d0                	callq  *%rax
  802665:	c9                   	leaveq 
  802666:	c3                   	retq   

0000000000802667 <seek>:
  802667:	55                   	push   %rbp
  802668:	48 89 e5             	mov    %rsp,%rbp
  80266b:	48 83 ec 18          	sub    $0x18,%rsp
  80266f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802672:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802675:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802679:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80267c:	48 89 d6             	mov    %rdx,%rsi
  80267f:	89 c7                	mov    %eax,%edi
  802681:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  802688:	00 00 00 
  80268b:	ff d0                	callq  *%rax
  80268d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802690:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802694:	79 05                	jns    80269b <seek+0x34>
  802696:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802699:	eb 0f                	jmp    8026aa <seek+0x43>
  80269b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80269f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8026a2:	89 50 04             	mov    %edx,0x4(%rax)
  8026a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8026aa:	c9                   	leaveq 
  8026ab:	c3                   	retq   

00000000008026ac <ftruncate>:
  8026ac:	55                   	push   %rbp
  8026ad:	48 89 e5             	mov    %rsp,%rbp
  8026b0:	48 83 ec 30          	sub    $0x30,%rsp
  8026b4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8026b7:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8026ba:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8026be:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8026c1:	48 89 d6             	mov    %rdx,%rsi
  8026c4:	89 c7                	mov    %eax,%edi
  8026c6:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  8026cd:	00 00 00 
  8026d0:	ff d0                	callq  *%rax
  8026d2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026d5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026d9:	78 24                	js     8026ff <ftruncate+0x53>
  8026db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026df:	8b 00                	mov    (%rax),%eax
  8026e1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8026e5:	48 89 d6             	mov    %rdx,%rsi
  8026e8:	89 c7                	mov    %eax,%edi
  8026ea:	48 b8 70 21 80 00 00 	movabs $0x802170,%rax
  8026f1:	00 00 00 
  8026f4:	ff d0                	callq  *%rax
  8026f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026f9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026fd:	79 05                	jns    802704 <ftruncate+0x58>
  8026ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802702:	eb 72                	jmp    802776 <ftruncate+0xca>
  802704:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802708:	8b 40 08             	mov    0x8(%rax),%eax
  80270b:	83 e0 03             	and    $0x3,%eax
  80270e:	85 c0                	test   %eax,%eax
  802710:	75 3a                	jne    80274c <ftruncate+0xa0>
  802712:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802719:	00 00 00 
  80271c:	48 8b 00             	mov    (%rax),%rax
  80271f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802725:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802728:	89 c6                	mov    %eax,%esi
  80272a:	48 bf 90 4c 80 00 00 	movabs $0x804c90,%rdi
  802731:	00 00 00 
  802734:	b8 00 00 00 00       	mov    $0x0,%eax
  802739:	48 b9 88 03 80 00 00 	movabs $0x800388,%rcx
  802740:	00 00 00 
  802743:	ff d1                	callq  *%rcx
  802745:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80274a:	eb 2a                	jmp    802776 <ftruncate+0xca>
  80274c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802750:	48 8b 40 30          	mov    0x30(%rax),%rax
  802754:	48 85 c0             	test   %rax,%rax
  802757:	75 07                	jne    802760 <ftruncate+0xb4>
  802759:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80275e:	eb 16                	jmp    802776 <ftruncate+0xca>
  802760:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802764:	48 8b 40 30          	mov    0x30(%rax),%rax
  802768:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80276c:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  80276f:	89 ce                	mov    %ecx,%esi
  802771:	48 89 d7             	mov    %rdx,%rdi
  802774:	ff d0                	callq  *%rax
  802776:	c9                   	leaveq 
  802777:	c3                   	retq   

0000000000802778 <fstat>:
  802778:	55                   	push   %rbp
  802779:	48 89 e5             	mov    %rsp,%rbp
  80277c:	48 83 ec 30          	sub    $0x30,%rsp
  802780:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802783:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802787:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80278b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80278e:	48 89 d6             	mov    %rdx,%rsi
  802791:	89 c7                	mov    %eax,%edi
  802793:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  80279a:	00 00 00 
  80279d:	ff d0                	callq  *%rax
  80279f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027a6:	78 24                	js     8027cc <fstat+0x54>
  8027a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027ac:	8b 00                	mov    (%rax),%eax
  8027ae:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8027b2:	48 89 d6             	mov    %rdx,%rsi
  8027b5:	89 c7                	mov    %eax,%edi
  8027b7:	48 b8 70 21 80 00 00 	movabs $0x802170,%rax
  8027be:	00 00 00 
  8027c1:	ff d0                	callq  *%rax
  8027c3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027ca:	79 05                	jns    8027d1 <fstat+0x59>
  8027cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027cf:	eb 5e                	jmp    80282f <fstat+0xb7>
  8027d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027d5:	48 8b 40 28          	mov    0x28(%rax),%rax
  8027d9:	48 85 c0             	test   %rax,%rax
  8027dc:	75 07                	jne    8027e5 <fstat+0x6d>
  8027de:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8027e3:	eb 4a                	jmp    80282f <fstat+0xb7>
  8027e5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027e9:	c6 00 00             	movb   $0x0,(%rax)
  8027ec:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027f0:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  8027f7:	00 00 00 
  8027fa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027fe:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802805:	00 00 00 
  802808:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80280c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802810:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802817:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80281b:	48 8b 40 28          	mov    0x28(%rax),%rax
  80281f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802823:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802827:	48 89 ce             	mov    %rcx,%rsi
  80282a:	48 89 d7             	mov    %rdx,%rdi
  80282d:	ff d0                	callq  *%rax
  80282f:	c9                   	leaveq 
  802830:	c3                   	retq   

0000000000802831 <stat>:
  802831:	55                   	push   %rbp
  802832:	48 89 e5             	mov    %rsp,%rbp
  802835:	48 83 ec 20          	sub    $0x20,%rsp
  802839:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80283d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802841:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802845:	be 00 00 00 00       	mov    $0x0,%esi
  80284a:	48 89 c7             	mov    %rax,%rdi
  80284d:	48 b8 1f 29 80 00 00 	movabs $0x80291f,%rax
  802854:	00 00 00 
  802857:	ff d0                	callq  *%rax
  802859:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80285c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802860:	79 05                	jns    802867 <stat+0x36>
  802862:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802865:	eb 2f                	jmp    802896 <stat+0x65>
  802867:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80286b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80286e:	48 89 d6             	mov    %rdx,%rsi
  802871:	89 c7                	mov    %eax,%edi
  802873:	48 b8 78 27 80 00 00 	movabs $0x802778,%rax
  80287a:	00 00 00 
  80287d:	ff d0                	callq  *%rax
  80287f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802882:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802885:	89 c7                	mov    %eax,%edi
  802887:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  80288e:	00 00 00 
  802891:	ff d0                	callq  *%rax
  802893:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802896:	c9                   	leaveq 
  802897:	c3                   	retq   

0000000000802898 <fsipc>:
  802898:	55                   	push   %rbp
  802899:	48 89 e5             	mov    %rsp,%rbp
  80289c:	48 83 ec 10          	sub    $0x10,%rsp
  8028a0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8028a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8028a7:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8028ae:	00 00 00 
  8028b1:	8b 00                	mov    (%rax),%eax
  8028b3:	85 c0                	test   %eax,%eax
  8028b5:	75 1d                	jne    8028d4 <fsipc+0x3c>
  8028b7:	bf 01 00 00 00       	mov    $0x1,%edi
  8028bc:	48 b8 c8 45 80 00 00 	movabs $0x8045c8,%rax
  8028c3:	00 00 00 
  8028c6:	ff d0                	callq  *%rax
  8028c8:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  8028cf:	00 00 00 
  8028d2:	89 02                	mov    %eax,(%rdx)
  8028d4:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8028db:	00 00 00 
  8028de:	8b 00                	mov    (%rax),%eax
  8028e0:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8028e3:	b9 07 00 00 00       	mov    $0x7,%ecx
  8028e8:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  8028ef:	00 00 00 
  8028f2:	89 c7                	mov    %eax,%edi
  8028f4:	48 b8 bd 44 80 00 00 	movabs $0x8044bd,%rax
  8028fb:	00 00 00 
  8028fe:	ff d0                	callq  *%rax
  802900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802904:	ba 00 00 00 00       	mov    $0x0,%edx
  802909:	48 89 c6             	mov    %rax,%rsi
  80290c:	bf 00 00 00 00       	mov    $0x0,%edi
  802911:	48 b8 fc 43 80 00 00 	movabs $0x8043fc,%rax
  802918:	00 00 00 
  80291b:	ff d0                	callq  *%rax
  80291d:	c9                   	leaveq 
  80291e:	c3                   	retq   

000000000080291f <open>:
  80291f:	55                   	push   %rbp
  802920:	48 89 e5             	mov    %rsp,%rbp
  802923:	48 83 ec 20          	sub    $0x20,%rsp
  802927:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80292b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80292e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802932:	48 89 c7             	mov    %rax,%rdi
  802935:	48 b8 d1 0e 80 00 00 	movabs $0x800ed1,%rax
  80293c:	00 00 00 
  80293f:	ff d0                	callq  *%rax
  802941:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802946:	7e 0a                	jle    802952 <open+0x33>
  802948:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80294d:	e9 a5 00 00 00       	jmpq   8029f7 <open+0xd8>
  802952:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802956:	48 89 c7             	mov    %rax,%rdi
  802959:	48 b8 7f 1f 80 00 00 	movabs $0x801f7f,%rax
  802960:	00 00 00 
  802963:	ff d0                	callq  *%rax
  802965:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802968:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80296c:	79 08                	jns    802976 <open+0x57>
  80296e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802971:	e9 81 00 00 00       	jmpq   8029f7 <open+0xd8>
  802976:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80297a:	48 89 c6             	mov    %rax,%rsi
  80297d:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802984:	00 00 00 
  802987:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  80298e:	00 00 00 
  802991:	ff d0                	callq  *%rax
  802993:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80299a:	00 00 00 
  80299d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8029a0:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8029a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029aa:	48 89 c6             	mov    %rax,%rsi
  8029ad:	bf 01 00 00 00       	mov    $0x1,%edi
  8029b2:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  8029b9:	00 00 00 
  8029bc:	ff d0                	callq  *%rax
  8029be:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029c5:	79 1d                	jns    8029e4 <open+0xc5>
  8029c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029cb:	be 00 00 00 00       	mov    $0x0,%esi
  8029d0:	48 89 c7             	mov    %rax,%rdi
  8029d3:	48 b8 a7 20 80 00 00 	movabs $0x8020a7,%rax
  8029da:	00 00 00 
  8029dd:	ff d0                	callq  *%rax
  8029df:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029e2:	eb 13                	jmp    8029f7 <open+0xd8>
  8029e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029e8:	48 89 c7             	mov    %rax,%rdi
  8029eb:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  8029f2:	00 00 00 
  8029f5:	ff d0                	callq  *%rax
  8029f7:	c9                   	leaveq 
  8029f8:	c3                   	retq   

00000000008029f9 <devfile_flush>:
  8029f9:	55                   	push   %rbp
  8029fa:	48 89 e5             	mov    %rsp,%rbp
  8029fd:	48 83 ec 10          	sub    $0x10,%rsp
  802a01:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a09:	8b 50 0c             	mov    0xc(%rax),%edx
  802a0c:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a13:	00 00 00 
  802a16:	89 10                	mov    %edx,(%rax)
  802a18:	be 00 00 00 00       	mov    $0x0,%esi
  802a1d:	bf 06 00 00 00       	mov    $0x6,%edi
  802a22:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802a29:	00 00 00 
  802a2c:	ff d0                	callq  *%rax
  802a2e:	c9                   	leaveq 
  802a2f:	c3                   	retq   

0000000000802a30 <devfile_read>:
  802a30:	55                   	push   %rbp
  802a31:	48 89 e5             	mov    %rsp,%rbp
  802a34:	48 83 ec 30          	sub    $0x30,%rsp
  802a38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802a3c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802a40:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802a44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a48:	8b 50 0c             	mov    0xc(%rax),%edx
  802a4b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a52:	00 00 00 
  802a55:	89 10                	mov    %edx,(%rax)
  802a57:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a5e:	00 00 00 
  802a61:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802a65:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802a69:	be 00 00 00 00       	mov    $0x0,%esi
  802a6e:	bf 03 00 00 00       	mov    $0x3,%edi
  802a73:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802a7a:	00 00 00 
  802a7d:	ff d0                	callq  *%rax
  802a7f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a82:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a86:	79 08                	jns    802a90 <devfile_read+0x60>
  802a88:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a8b:	e9 a4 00 00 00       	jmpq   802b34 <devfile_read+0x104>
  802a90:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a93:	48 98                	cltq   
  802a95:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802a99:	76 35                	jbe    802ad0 <devfile_read+0xa0>
  802a9b:	48 b9 b6 4c 80 00 00 	movabs $0x804cb6,%rcx
  802aa2:	00 00 00 
  802aa5:	48 ba bd 4c 80 00 00 	movabs $0x804cbd,%rdx
  802aac:	00 00 00 
  802aaf:	be 89 00 00 00       	mov    $0x89,%esi
  802ab4:	48 bf d2 4c 80 00 00 	movabs $0x804cd2,%rdi
  802abb:	00 00 00 
  802abe:	b8 00 00 00 00       	mov    $0x0,%eax
  802ac3:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  802aca:	00 00 00 
  802acd:	41 ff d0             	callq  *%r8
  802ad0:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802ad7:	7e 35                	jle    802b0e <devfile_read+0xde>
  802ad9:	48 b9 e0 4c 80 00 00 	movabs $0x804ce0,%rcx
  802ae0:	00 00 00 
  802ae3:	48 ba bd 4c 80 00 00 	movabs $0x804cbd,%rdx
  802aea:	00 00 00 
  802aed:	be 8a 00 00 00       	mov    $0x8a,%esi
  802af2:	48 bf d2 4c 80 00 00 	movabs $0x804cd2,%rdi
  802af9:	00 00 00 
  802afc:	b8 00 00 00 00       	mov    $0x0,%eax
  802b01:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  802b08:	00 00 00 
  802b0b:	41 ff d0             	callq  *%r8
  802b0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b11:	48 63 d0             	movslq %eax,%rdx
  802b14:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b18:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802b1f:	00 00 00 
  802b22:	48 89 c7             	mov    %rax,%rdi
  802b25:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  802b2c:	00 00 00 
  802b2f:	ff d0                	callq  *%rax
  802b31:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b34:	c9                   	leaveq 
  802b35:	c3                   	retq   

0000000000802b36 <devfile_write>:
  802b36:	55                   	push   %rbp
  802b37:	48 89 e5             	mov    %rsp,%rbp
  802b3a:	48 83 ec 40          	sub    $0x40,%rsp
  802b3e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802b42:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802b46:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802b4a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802b4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802b52:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802b59:	00 
  802b5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b5e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802b62:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802b67:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802b6b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b6f:	8b 50 0c             	mov    0xc(%rax),%edx
  802b72:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b79:	00 00 00 
  802b7c:	89 10                	mov    %edx,(%rax)
  802b7e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b85:	00 00 00 
  802b88:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802b8c:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802b90:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802b94:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b98:	48 89 c6             	mov    %rax,%rsi
  802b9b:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  802ba2:	00 00 00 
  802ba5:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  802bac:	00 00 00 
  802baf:	ff d0                	callq  *%rax
  802bb1:	be 00 00 00 00       	mov    $0x0,%esi
  802bb6:	bf 04 00 00 00       	mov    $0x4,%edi
  802bbb:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802bc2:	00 00 00 
  802bc5:	ff d0                	callq  *%rax
  802bc7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802bca:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802bce:	79 05                	jns    802bd5 <devfile_write+0x9f>
  802bd0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802bd3:	eb 43                	jmp    802c18 <devfile_write+0xe2>
  802bd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802bd8:	48 98                	cltq   
  802bda:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802bde:	76 35                	jbe    802c15 <devfile_write+0xdf>
  802be0:	48 b9 b6 4c 80 00 00 	movabs $0x804cb6,%rcx
  802be7:	00 00 00 
  802bea:	48 ba bd 4c 80 00 00 	movabs $0x804cbd,%rdx
  802bf1:	00 00 00 
  802bf4:	be a8 00 00 00       	mov    $0xa8,%esi
  802bf9:	48 bf d2 4c 80 00 00 	movabs $0x804cd2,%rdi
  802c00:	00 00 00 
  802c03:	b8 00 00 00 00       	mov    $0x0,%eax
  802c08:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  802c0f:	00 00 00 
  802c12:	41 ff d0             	callq  *%r8
  802c15:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c18:	c9                   	leaveq 
  802c19:	c3                   	retq   

0000000000802c1a <devfile_stat>:
  802c1a:	55                   	push   %rbp
  802c1b:	48 89 e5             	mov    %rsp,%rbp
  802c1e:	48 83 ec 20          	sub    $0x20,%rsp
  802c22:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c26:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802c2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c2e:	8b 50 0c             	mov    0xc(%rax),%edx
  802c31:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c38:	00 00 00 
  802c3b:	89 10                	mov    %edx,(%rax)
  802c3d:	be 00 00 00 00       	mov    $0x0,%esi
  802c42:	bf 05 00 00 00       	mov    $0x5,%edi
  802c47:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802c4e:	00 00 00 
  802c51:	ff d0                	callq  *%rax
  802c53:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c56:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c5a:	79 05                	jns    802c61 <devfile_stat+0x47>
  802c5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c5f:	eb 56                	jmp    802cb7 <devfile_stat+0x9d>
  802c61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c65:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802c6c:	00 00 00 
  802c6f:	48 89 c7             	mov    %rax,%rdi
  802c72:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  802c79:	00 00 00 
  802c7c:	ff d0                	callq  *%rax
  802c7e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c85:	00 00 00 
  802c88:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802c8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c92:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802c98:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c9f:	00 00 00 
  802ca2:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802ca8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802cac:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802cb2:	b8 00 00 00 00       	mov    $0x0,%eax
  802cb7:	c9                   	leaveq 
  802cb8:	c3                   	retq   

0000000000802cb9 <devfile_trunc>:
  802cb9:	55                   	push   %rbp
  802cba:	48 89 e5             	mov    %rsp,%rbp
  802cbd:	48 83 ec 10          	sub    $0x10,%rsp
  802cc1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802cc5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ccc:	8b 50 0c             	mov    0xc(%rax),%edx
  802ccf:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802cd6:	00 00 00 
  802cd9:	89 10                	mov    %edx,(%rax)
  802cdb:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802ce2:	00 00 00 
  802ce5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802ce8:	89 50 04             	mov    %edx,0x4(%rax)
  802ceb:	be 00 00 00 00       	mov    $0x0,%esi
  802cf0:	bf 02 00 00 00       	mov    $0x2,%edi
  802cf5:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802cfc:	00 00 00 
  802cff:	ff d0                	callq  *%rax
  802d01:	c9                   	leaveq 
  802d02:	c3                   	retq   

0000000000802d03 <remove>:
  802d03:	55                   	push   %rbp
  802d04:	48 89 e5             	mov    %rsp,%rbp
  802d07:	48 83 ec 10          	sub    $0x10,%rsp
  802d0b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d13:	48 89 c7             	mov    %rax,%rdi
  802d16:	48 b8 d1 0e 80 00 00 	movabs $0x800ed1,%rax
  802d1d:	00 00 00 
  802d20:	ff d0                	callq  *%rax
  802d22:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802d27:	7e 07                	jle    802d30 <remove+0x2d>
  802d29:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802d2e:	eb 33                	jmp    802d63 <remove+0x60>
  802d30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d34:	48 89 c6             	mov    %rax,%rsi
  802d37:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802d3e:	00 00 00 
  802d41:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  802d48:	00 00 00 
  802d4b:	ff d0                	callq  *%rax
  802d4d:	be 00 00 00 00       	mov    $0x0,%esi
  802d52:	bf 07 00 00 00       	mov    $0x7,%edi
  802d57:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802d5e:	00 00 00 
  802d61:	ff d0                	callq  *%rax
  802d63:	c9                   	leaveq 
  802d64:	c3                   	retq   

0000000000802d65 <sync>:
  802d65:	55                   	push   %rbp
  802d66:	48 89 e5             	mov    %rsp,%rbp
  802d69:	be 00 00 00 00       	mov    $0x0,%esi
  802d6e:	bf 08 00 00 00       	mov    $0x8,%edi
  802d73:	48 b8 98 28 80 00 00 	movabs $0x802898,%rax
  802d7a:	00 00 00 
  802d7d:	ff d0                	callq  *%rax
  802d7f:	5d                   	pop    %rbp
  802d80:	c3                   	retq   

0000000000802d81 <copy>:
  802d81:	55                   	push   %rbp
  802d82:	48 89 e5             	mov    %rsp,%rbp
  802d85:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802d8c:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802d93:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802d9a:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802da1:	be 00 00 00 00       	mov    $0x0,%esi
  802da6:	48 89 c7             	mov    %rax,%rdi
  802da9:	48 b8 1f 29 80 00 00 	movabs $0x80291f,%rax
  802db0:	00 00 00 
  802db3:	ff d0                	callq  *%rax
  802db5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802db8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dbc:	79 28                	jns    802de6 <copy+0x65>
  802dbe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dc1:	89 c6                	mov    %eax,%esi
  802dc3:	48 bf ec 4c 80 00 00 	movabs $0x804cec,%rdi
  802dca:	00 00 00 
  802dcd:	b8 00 00 00 00       	mov    $0x0,%eax
  802dd2:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  802dd9:	00 00 00 
  802ddc:	ff d2                	callq  *%rdx
  802dde:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802de1:	e9 74 01 00 00       	jmpq   802f5a <copy+0x1d9>
  802de6:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802ded:	be 01 01 00 00       	mov    $0x101,%esi
  802df2:	48 89 c7             	mov    %rax,%rdi
  802df5:	48 b8 1f 29 80 00 00 	movabs $0x80291f,%rax
  802dfc:	00 00 00 
  802dff:	ff d0                	callq  *%rax
  802e01:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802e04:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802e08:	79 39                	jns    802e43 <copy+0xc2>
  802e0a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e0d:	89 c6                	mov    %eax,%esi
  802e0f:	48 bf 02 4d 80 00 00 	movabs $0x804d02,%rdi
  802e16:	00 00 00 
  802e19:	b8 00 00 00 00       	mov    $0x0,%eax
  802e1e:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  802e25:	00 00 00 
  802e28:	ff d2                	callq  *%rdx
  802e2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e2d:	89 c7                	mov    %eax,%edi
  802e2f:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802e36:	00 00 00 
  802e39:	ff d0                	callq  *%rax
  802e3b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e3e:	e9 17 01 00 00       	jmpq   802f5a <copy+0x1d9>
  802e43:	eb 74                	jmp    802eb9 <copy+0x138>
  802e45:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802e48:	48 63 d0             	movslq %eax,%rdx
  802e4b:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802e52:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e55:	48 89 ce             	mov    %rcx,%rsi
  802e58:	89 c7                	mov    %eax,%edi
  802e5a:	48 b8 93 25 80 00 00 	movabs $0x802593,%rax
  802e61:	00 00 00 
  802e64:	ff d0                	callq  *%rax
  802e66:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802e69:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802e6d:	79 4a                	jns    802eb9 <copy+0x138>
  802e6f:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802e72:	89 c6                	mov    %eax,%esi
  802e74:	48 bf 1c 4d 80 00 00 	movabs $0x804d1c,%rdi
  802e7b:	00 00 00 
  802e7e:	b8 00 00 00 00       	mov    $0x0,%eax
  802e83:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  802e8a:	00 00 00 
  802e8d:	ff d2                	callq  *%rdx
  802e8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e92:	89 c7                	mov    %eax,%edi
  802e94:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802e9b:	00 00 00 
  802e9e:	ff d0                	callq  *%rax
  802ea0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802ea3:	89 c7                	mov    %eax,%edi
  802ea5:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802eac:	00 00 00 
  802eaf:	ff d0                	callq  *%rax
  802eb1:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802eb4:	e9 a1 00 00 00       	jmpq   802f5a <copy+0x1d9>
  802eb9:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802ec0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ec3:	ba 00 02 00 00       	mov    $0x200,%edx
  802ec8:	48 89 ce             	mov    %rcx,%rsi
  802ecb:	89 c7                	mov    %eax,%edi
  802ecd:	48 b8 49 24 80 00 00 	movabs $0x802449,%rax
  802ed4:	00 00 00 
  802ed7:	ff d0                	callq  *%rax
  802ed9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802edc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802ee0:	0f 8f 5f ff ff ff    	jg     802e45 <copy+0xc4>
  802ee6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802eea:	79 47                	jns    802f33 <copy+0x1b2>
  802eec:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802eef:	89 c6                	mov    %eax,%esi
  802ef1:	48 bf 2f 4d 80 00 00 	movabs $0x804d2f,%rdi
  802ef8:	00 00 00 
  802efb:	b8 00 00 00 00       	mov    $0x0,%eax
  802f00:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  802f07:	00 00 00 
  802f0a:	ff d2                	callq  *%rdx
  802f0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f0f:	89 c7                	mov    %eax,%edi
  802f11:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802f18:	00 00 00 
  802f1b:	ff d0                	callq  *%rax
  802f1d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f20:	89 c7                	mov    %eax,%edi
  802f22:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802f29:	00 00 00 
  802f2c:	ff d0                	callq  *%rax
  802f2e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802f31:	eb 27                	jmp    802f5a <copy+0x1d9>
  802f33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f36:	89 c7                	mov    %eax,%edi
  802f38:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802f3f:	00 00 00 
  802f42:	ff d0                	callq  *%rax
  802f44:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f47:	89 c7                	mov    %eax,%edi
  802f49:	48 b8 27 22 80 00 00 	movabs $0x802227,%rax
  802f50:	00 00 00 
  802f53:	ff d0                	callq  *%rax
  802f55:	b8 00 00 00 00       	mov    $0x0,%eax
  802f5a:	c9                   	leaveq 
  802f5b:	c3                   	retq   

0000000000802f5c <writebuf>:
  802f5c:	55                   	push   %rbp
  802f5d:	48 89 e5             	mov    %rsp,%rbp
  802f60:	48 83 ec 20          	sub    $0x20,%rsp
  802f64:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802f68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f6c:	8b 40 0c             	mov    0xc(%rax),%eax
  802f6f:	85 c0                	test   %eax,%eax
  802f71:	7e 67                	jle    802fda <writebuf+0x7e>
  802f73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f77:	8b 40 04             	mov    0x4(%rax),%eax
  802f7a:	48 63 d0             	movslq %eax,%rdx
  802f7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f81:	48 8d 48 10          	lea    0x10(%rax),%rcx
  802f85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f89:	8b 00                	mov    (%rax),%eax
  802f8b:	48 89 ce             	mov    %rcx,%rsi
  802f8e:	89 c7                	mov    %eax,%edi
  802f90:	48 b8 93 25 80 00 00 	movabs $0x802593,%rax
  802f97:	00 00 00 
  802f9a:	ff d0                	callq  *%rax
  802f9c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f9f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fa3:	7e 13                	jle    802fb8 <writebuf+0x5c>
  802fa5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fa9:	8b 50 08             	mov    0x8(%rax),%edx
  802fac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802faf:	01 c2                	add    %eax,%edx
  802fb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fb5:	89 50 08             	mov    %edx,0x8(%rax)
  802fb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fbc:	8b 40 04             	mov    0x4(%rax),%eax
  802fbf:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  802fc2:	74 16                	je     802fda <writebuf+0x7e>
  802fc4:	b8 00 00 00 00       	mov    $0x0,%eax
  802fc9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fcd:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  802fd1:	89 c2                	mov    %eax,%edx
  802fd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fd7:	89 50 0c             	mov    %edx,0xc(%rax)
  802fda:	c9                   	leaveq 
  802fdb:	c3                   	retq   

0000000000802fdc <putch>:
  802fdc:	55                   	push   %rbp
  802fdd:	48 89 e5             	mov    %rsp,%rbp
  802fe0:	48 83 ec 20          	sub    $0x20,%rsp
  802fe4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802fe7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802feb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802ff3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ff7:	8b 40 04             	mov    0x4(%rax),%eax
  802ffa:	8d 48 01             	lea    0x1(%rax),%ecx
  802ffd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803001:	89 4a 04             	mov    %ecx,0x4(%rdx)
  803004:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803007:	89 d1                	mov    %edx,%ecx
  803009:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80300d:	48 98                	cltq   
  80300f:	88 4c 02 10          	mov    %cl,0x10(%rdx,%rax,1)
  803013:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803017:	8b 40 04             	mov    0x4(%rax),%eax
  80301a:	3d 00 01 00 00       	cmp    $0x100,%eax
  80301f:	75 1e                	jne    80303f <putch+0x63>
  803021:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803025:	48 89 c7             	mov    %rax,%rdi
  803028:	48 b8 5c 2f 80 00 00 	movabs $0x802f5c,%rax
  80302f:	00 00 00 
  803032:	ff d0                	callq  *%rax
  803034:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803038:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  80303f:	c9                   	leaveq 
  803040:	c3                   	retq   

0000000000803041 <vfprintf>:
  803041:	55                   	push   %rbp
  803042:	48 89 e5             	mov    %rsp,%rbp
  803045:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  80304c:	89 bd ec fe ff ff    	mov    %edi,-0x114(%rbp)
  803052:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  803059:	48 89 95 d8 fe ff ff 	mov    %rdx,-0x128(%rbp)
  803060:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  803066:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%rbp)
  80306c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  803073:	00 00 00 
  803076:	c7 85 f8 fe ff ff 00 	movl   $0x0,-0x108(%rbp)
  80307d:	00 00 00 
  803080:	c7 85 fc fe ff ff 01 	movl   $0x1,-0x104(%rbp)
  803087:	00 00 00 
  80308a:	48 8b 8d d8 fe ff ff 	mov    -0x128(%rbp),%rcx
  803091:	48 8b 95 e0 fe ff ff 	mov    -0x120(%rbp),%rdx
  803098:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  80309f:	48 89 c6             	mov    %rax,%rsi
  8030a2:	48 bf dc 2f 80 00 00 	movabs $0x802fdc,%rdi
  8030a9:	00 00 00 
  8030ac:	48 b8 3b 07 80 00 00 	movabs $0x80073b,%rax
  8030b3:	00 00 00 
  8030b6:	ff d0                	callq  *%rax
  8030b8:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8030be:	85 c0                	test   %eax,%eax
  8030c0:	7e 16                	jle    8030d8 <vfprintf+0x97>
  8030c2:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8030c9:	48 89 c7             	mov    %rax,%rdi
  8030cc:	48 b8 5c 2f 80 00 00 	movabs $0x802f5c,%rax
  8030d3:	00 00 00 
  8030d6:	ff d0                	callq  *%rax
  8030d8:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  8030de:	85 c0                	test   %eax,%eax
  8030e0:	74 08                	je     8030ea <vfprintf+0xa9>
  8030e2:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  8030e8:	eb 06                	jmp    8030f0 <vfprintf+0xaf>
  8030ea:	8b 85 fc fe ff ff    	mov    -0x104(%rbp),%eax
  8030f0:	c9                   	leaveq 
  8030f1:	c3                   	retq   

00000000008030f2 <fprintf>:
  8030f2:	55                   	push   %rbp
  8030f3:	48 89 e5             	mov    %rsp,%rbp
  8030f6:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  8030fd:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%rbp)
  803103:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80310a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803111:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803118:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80311f:	84 c0                	test   %al,%al
  803121:	74 20                	je     803143 <fprintf+0x51>
  803123:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803127:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80312b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80312f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803133:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803137:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80313b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80313f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  803143:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80314a:	c7 85 30 ff ff ff 10 	movl   $0x10,-0xd0(%rbp)
  803151:	00 00 00 
  803154:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80315b:	00 00 00 
  80315e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803162:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803169:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803170:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803177:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80317e:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
  803185:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  80318b:	48 89 ce             	mov    %rcx,%rsi
  80318e:	89 c7                	mov    %eax,%edi
  803190:	48 b8 41 30 80 00 00 	movabs $0x803041,%rax
  803197:	00 00 00 
  80319a:	ff d0                	callq  *%rax
  80319c:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8031a2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8031a8:	c9                   	leaveq 
  8031a9:	c3                   	retq   

00000000008031aa <printf>:
  8031aa:	55                   	push   %rbp
  8031ab:	48 89 e5             	mov    %rsp,%rbp
  8031ae:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  8031b5:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8031bc:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8031c3:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8031ca:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8031d1:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8031d8:	84 c0                	test   %al,%al
  8031da:	74 20                	je     8031fc <printf+0x52>
  8031dc:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8031e0:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8031e4:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8031e8:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8031ec:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8031f0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8031f4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8031f8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8031fc:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  803203:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80320a:	00 00 00 
  80320d:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803214:	00 00 00 
  803217:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80321b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803222:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803229:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803230:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  803237:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  80323e:	48 89 c6             	mov    %rax,%rsi
  803241:	bf 01 00 00 00       	mov    $0x1,%edi
  803246:	48 b8 41 30 80 00 00 	movabs $0x803041,%rax
  80324d:	00 00 00 
  803250:	ff d0                	callq  *%rax
  803252:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  803258:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80325e:	c9                   	leaveq 
  80325f:	c3                   	retq   

0000000000803260 <fd2sockid>:
  803260:	55                   	push   %rbp
  803261:	48 89 e5             	mov    %rsp,%rbp
  803264:	48 83 ec 20          	sub    $0x20,%rsp
  803268:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80326b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80326f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803272:	48 89 d6             	mov    %rdx,%rsi
  803275:	89 c7                	mov    %eax,%edi
  803277:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  80327e:	00 00 00 
  803281:	ff d0                	callq  *%rax
  803283:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803286:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80328a:	79 05                	jns    803291 <fd2sockid+0x31>
  80328c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80328f:	eb 24                	jmp    8032b5 <fd2sockid+0x55>
  803291:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803295:	8b 10                	mov    (%rax),%edx
  803297:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  80329e:	00 00 00 
  8032a1:	8b 00                	mov    (%rax),%eax
  8032a3:	39 c2                	cmp    %eax,%edx
  8032a5:	74 07                	je     8032ae <fd2sockid+0x4e>
  8032a7:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8032ac:	eb 07                	jmp    8032b5 <fd2sockid+0x55>
  8032ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032b2:	8b 40 0c             	mov    0xc(%rax),%eax
  8032b5:	c9                   	leaveq 
  8032b6:	c3                   	retq   

00000000008032b7 <alloc_sockfd>:
  8032b7:	55                   	push   %rbp
  8032b8:	48 89 e5             	mov    %rsp,%rbp
  8032bb:	48 83 ec 20          	sub    $0x20,%rsp
  8032bf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8032c2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8032c6:	48 89 c7             	mov    %rax,%rdi
  8032c9:	48 b8 7f 1f 80 00 00 	movabs $0x801f7f,%rax
  8032d0:	00 00 00 
  8032d3:	ff d0                	callq  *%rax
  8032d5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032dc:	78 26                	js     803304 <alloc_sockfd+0x4d>
  8032de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032e2:	ba 07 04 00 00       	mov    $0x407,%edx
  8032e7:	48 89 c6             	mov    %rax,%rsi
  8032ea:	bf 00 00 00 00       	mov    $0x0,%edi
  8032ef:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  8032f6:	00 00 00 
  8032f9:	ff d0                	callq  *%rax
  8032fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803302:	79 16                	jns    80331a <alloc_sockfd+0x63>
  803304:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803307:	89 c7                	mov    %eax,%edi
  803309:	48 b8 c4 37 80 00 00 	movabs $0x8037c4,%rax
  803310:	00 00 00 
  803313:	ff d0                	callq  *%rax
  803315:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803318:	eb 3a                	jmp    803354 <alloc_sockfd+0x9d>
  80331a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80331e:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  803325:	00 00 00 
  803328:	8b 12                	mov    (%rdx),%edx
  80332a:	89 10                	mov    %edx,(%rax)
  80332c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803330:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803337:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80333b:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80333e:	89 50 0c             	mov    %edx,0xc(%rax)
  803341:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803345:	48 89 c7             	mov    %rax,%rdi
  803348:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  80334f:	00 00 00 
  803352:	ff d0                	callq  *%rax
  803354:	c9                   	leaveq 
  803355:	c3                   	retq   

0000000000803356 <accept>:
  803356:	55                   	push   %rbp
  803357:	48 89 e5             	mov    %rsp,%rbp
  80335a:	48 83 ec 30          	sub    $0x30,%rsp
  80335e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803361:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803365:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803369:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80336c:	89 c7                	mov    %eax,%edi
  80336e:	48 b8 60 32 80 00 00 	movabs $0x803260,%rax
  803375:	00 00 00 
  803378:	ff d0                	callq  *%rax
  80337a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80337d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803381:	79 05                	jns    803388 <accept+0x32>
  803383:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803386:	eb 3b                	jmp    8033c3 <accept+0x6d>
  803388:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80338c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803390:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803393:	48 89 ce             	mov    %rcx,%rsi
  803396:	89 c7                	mov    %eax,%edi
  803398:	48 b8 a1 36 80 00 00 	movabs $0x8036a1,%rax
  80339f:	00 00 00 
  8033a2:	ff d0                	callq  *%rax
  8033a4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033ab:	79 05                	jns    8033b2 <accept+0x5c>
  8033ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033b0:	eb 11                	jmp    8033c3 <accept+0x6d>
  8033b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033b5:	89 c7                	mov    %eax,%edi
  8033b7:	48 b8 b7 32 80 00 00 	movabs $0x8032b7,%rax
  8033be:	00 00 00 
  8033c1:	ff d0                	callq  *%rax
  8033c3:	c9                   	leaveq 
  8033c4:	c3                   	retq   

00000000008033c5 <bind>:
  8033c5:	55                   	push   %rbp
  8033c6:	48 89 e5             	mov    %rsp,%rbp
  8033c9:	48 83 ec 20          	sub    $0x20,%rsp
  8033cd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8033d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8033d4:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8033d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8033da:	89 c7                	mov    %eax,%edi
  8033dc:	48 b8 60 32 80 00 00 	movabs $0x803260,%rax
  8033e3:	00 00 00 
  8033e6:	ff d0                	callq  *%rax
  8033e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033ef:	79 05                	jns    8033f6 <bind+0x31>
  8033f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033f4:	eb 1b                	jmp    803411 <bind+0x4c>
  8033f6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8033f9:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8033fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803400:	48 89 ce             	mov    %rcx,%rsi
  803403:	89 c7                	mov    %eax,%edi
  803405:	48 b8 20 37 80 00 00 	movabs $0x803720,%rax
  80340c:	00 00 00 
  80340f:	ff d0                	callq  *%rax
  803411:	c9                   	leaveq 
  803412:	c3                   	retq   

0000000000803413 <shutdown>:
  803413:	55                   	push   %rbp
  803414:	48 89 e5             	mov    %rsp,%rbp
  803417:	48 83 ec 20          	sub    $0x20,%rsp
  80341b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80341e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803421:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803424:	89 c7                	mov    %eax,%edi
  803426:	48 b8 60 32 80 00 00 	movabs $0x803260,%rax
  80342d:	00 00 00 
  803430:	ff d0                	callq  *%rax
  803432:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803435:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803439:	79 05                	jns    803440 <shutdown+0x2d>
  80343b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80343e:	eb 16                	jmp    803456 <shutdown+0x43>
  803440:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803443:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803446:	89 d6                	mov    %edx,%esi
  803448:	89 c7                	mov    %eax,%edi
  80344a:	48 b8 84 37 80 00 00 	movabs $0x803784,%rax
  803451:	00 00 00 
  803454:	ff d0                	callq  *%rax
  803456:	c9                   	leaveq 
  803457:	c3                   	retq   

0000000000803458 <devsock_close>:
  803458:	55                   	push   %rbp
  803459:	48 89 e5             	mov    %rsp,%rbp
  80345c:	48 83 ec 10          	sub    $0x10,%rsp
  803460:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803464:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803468:	48 89 c7             	mov    %rax,%rdi
  80346b:	48 b8 3a 46 80 00 00 	movabs $0x80463a,%rax
  803472:	00 00 00 
  803475:	ff d0                	callq  *%rax
  803477:	83 f8 01             	cmp    $0x1,%eax
  80347a:	75 17                	jne    803493 <devsock_close+0x3b>
  80347c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803480:	8b 40 0c             	mov    0xc(%rax),%eax
  803483:	89 c7                	mov    %eax,%edi
  803485:	48 b8 c4 37 80 00 00 	movabs $0x8037c4,%rax
  80348c:	00 00 00 
  80348f:	ff d0                	callq  *%rax
  803491:	eb 05                	jmp    803498 <devsock_close+0x40>
  803493:	b8 00 00 00 00       	mov    $0x0,%eax
  803498:	c9                   	leaveq 
  803499:	c3                   	retq   

000000000080349a <connect>:
  80349a:	55                   	push   %rbp
  80349b:	48 89 e5             	mov    %rsp,%rbp
  80349e:	48 83 ec 20          	sub    $0x20,%rsp
  8034a2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8034a5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8034a9:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8034ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8034af:	89 c7                	mov    %eax,%edi
  8034b1:	48 b8 60 32 80 00 00 	movabs $0x803260,%rax
  8034b8:	00 00 00 
  8034bb:	ff d0                	callq  *%rax
  8034bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034c4:	79 05                	jns    8034cb <connect+0x31>
  8034c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034c9:	eb 1b                	jmp    8034e6 <connect+0x4c>
  8034cb:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8034ce:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8034d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034d5:	48 89 ce             	mov    %rcx,%rsi
  8034d8:	89 c7                	mov    %eax,%edi
  8034da:	48 b8 f1 37 80 00 00 	movabs $0x8037f1,%rax
  8034e1:	00 00 00 
  8034e4:	ff d0                	callq  *%rax
  8034e6:	c9                   	leaveq 
  8034e7:	c3                   	retq   

00000000008034e8 <listen>:
  8034e8:	55                   	push   %rbp
  8034e9:	48 89 e5             	mov    %rsp,%rbp
  8034ec:	48 83 ec 20          	sub    $0x20,%rsp
  8034f0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8034f3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8034f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8034f9:	89 c7                	mov    %eax,%edi
  8034fb:	48 b8 60 32 80 00 00 	movabs $0x803260,%rax
  803502:	00 00 00 
  803505:	ff d0                	callq  *%rax
  803507:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80350a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80350e:	79 05                	jns    803515 <listen+0x2d>
  803510:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803513:	eb 16                	jmp    80352b <listen+0x43>
  803515:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803518:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80351b:	89 d6                	mov    %edx,%esi
  80351d:	89 c7                	mov    %eax,%edi
  80351f:	48 b8 55 38 80 00 00 	movabs $0x803855,%rax
  803526:	00 00 00 
  803529:	ff d0                	callq  *%rax
  80352b:	c9                   	leaveq 
  80352c:	c3                   	retq   

000000000080352d <devsock_read>:
  80352d:	55                   	push   %rbp
  80352e:	48 89 e5             	mov    %rsp,%rbp
  803531:	48 83 ec 20          	sub    $0x20,%rsp
  803535:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803539:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80353d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803541:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803545:	89 c2                	mov    %eax,%edx
  803547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80354b:	8b 40 0c             	mov    0xc(%rax),%eax
  80354e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803552:	b9 00 00 00 00       	mov    $0x0,%ecx
  803557:	89 c7                	mov    %eax,%edi
  803559:	48 b8 95 38 80 00 00 	movabs $0x803895,%rax
  803560:	00 00 00 
  803563:	ff d0                	callq  *%rax
  803565:	c9                   	leaveq 
  803566:	c3                   	retq   

0000000000803567 <devsock_write>:
  803567:	55                   	push   %rbp
  803568:	48 89 e5             	mov    %rsp,%rbp
  80356b:	48 83 ec 20          	sub    $0x20,%rsp
  80356f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803573:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803577:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80357b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80357f:	89 c2                	mov    %eax,%edx
  803581:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803585:	8b 40 0c             	mov    0xc(%rax),%eax
  803588:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80358c:	b9 00 00 00 00       	mov    $0x0,%ecx
  803591:	89 c7                	mov    %eax,%edi
  803593:	48 b8 61 39 80 00 00 	movabs $0x803961,%rax
  80359a:	00 00 00 
  80359d:	ff d0                	callq  *%rax
  80359f:	c9                   	leaveq 
  8035a0:	c3                   	retq   

00000000008035a1 <devsock_stat>:
  8035a1:	55                   	push   %rbp
  8035a2:	48 89 e5             	mov    %rsp,%rbp
  8035a5:	48 83 ec 10          	sub    $0x10,%rsp
  8035a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8035ad:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8035b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035b5:	48 be 4a 4d 80 00 00 	movabs $0x804d4a,%rsi
  8035bc:	00 00 00 
  8035bf:	48 89 c7             	mov    %rax,%rdi
  8035c2:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  8035c9:	00 00 00 
  8035cc:	ff d0                	callq  *%rax
  8035ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8035d3:	c9                   	leaveq 
  8035d4:	c3                   	retq   

00000000008035d5 <socket>:
  8035d5:	55                   	push   %rbp
  8035d6:	48 89 e5             	mov    %rsp,%rbp
  8035d9:	48 83 ec 20          	sub    $0x20,%rsp
  8035dd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8035e0:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8035e3:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  8035e6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8035e9:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8035ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035ef:	89 ce                	mov    %ecx,%esi
  8035f1:	89 c7                	mov    %eax,%edi
  8035f3:	48 b8 19 3a 80 00 00 	movabs $0x803a19,%rax
  8035fa:	00 00 00 
  8035fd:	ff d0                	callq  *%rax
  8035ff:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803602:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803606:	79 05                	jns    80360d <socket+0x38>
  803608:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80360b:	eb 11                	jmp    80361e <socket+0x49>
  80360d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803610:	89 c7                	mov    %eax,%edi
  803612:	48 b8 b7 32 80 00 00 	movabs $0x8032b7,%rax
  803619:	00 00 00 
  80361c:	ff d0                	callq  *%rax
  80361e:	c9                   	leaveq 
  80361f:	c3                   	retq   

0000000000803620 <nsipc>:
  803620:	55                   	push   %rbp
  803621:	48 89 e5             	mov    %rsp,%rbp
  803624:	48 83 ec 10          	sub    $0x10,%rsp
  803628:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80362b:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  803632:	00 00 00 
  803635:	8b 00                	mov    (%rax),%eax
  803637:	85 c0                	test   %eax,%eax
  803639:	75 1d                	jne    803658 <nsipc+0x38>
  80363b:	bf 02 00 00 00       	mov    $0x2,%edi
  803640:	48 b8 c8 45 80 00 00 	movabs $0x8045c8,%rax
  803647:	00 00 00 
  80364a:	ff d0                	callq  *%rax
  80364c:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  803653:	00 00 00 
  803656:	89 02                	mov    %eax,(%rdx)
  803658:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  80365f:	00 00 00 
  803662:	8b 00                	mov    (%rax),%eax
  803664:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803667:	b9 07 00 00 00       	mov    $0x7,%ecx
  80366c:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  803673:	00 00 00 
  803676:	89 c7                	mov    %eax,%edi
  803678:	48 b8 bd 44 80 00 00 	movabs $0x8044bd,%rax
  80367f:	00 00 00 
  803682:	ff d0                	callq  *%rax
  803684:	ba 00 00 00 00       	mov    $0x0,%edx
  803689:	be 00 00 00 00       	mov    $0x0,%esi
  80368e:	bf 00 00 00 00       	mov    $0x0,%edi
  803693:	48 b8 fc 43 80 00 00 	movabs $0x8043fc,%rax
  80369a:	00 00 00 
  80369d:	ff d0                	callq  *%rax
  80369f:	c9                   	leaveq 
  8036a0:	c3                   	retq   

00000000008036a1 <nsipc_accept>:
  8036a1:	55                   	push   %rbp
  8036a2:	48 89 e5             	mov    %rsp,%rbp
  8036a5:	48 83 ec 30          	sub    $0x30,%rsp
  8036a9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8036b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8036b4:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8036bb:	00 00 00 
  8036be:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8036c1:	89 10                	mov    %edx,(%rax)
  8036c3:	bf 01 00 00 00       	mov    $0x1,%edi
  8036c8:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  8036cf:	00 00 00 
  8036d2:	ff d0                	callq  *%rax
  8036d4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036db:	78 3e                	js     80371b <nsipc_accept+0x7a>
  8036dd:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8036e4:	00 00 00 
  8036e7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8036eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036ef:	8b 40 10             	mov    0x10(%rax),%eax
  8036f2:	89 c2                	mov    %eax,%edx
  8036f4:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8036f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036fc:	48 89 ce             	mov    %rcx,%rsi
  8036ff:	48 89 c7             	mov    %rax,%rdi
  803702:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  803709:	00 00 00 
  80370c:	ff d0                	callq  *%rax
  80370e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803712:	8b 50 10             	mov    0x10(%rax),%edx
  803715:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803719:	89 10                	mov    %edx,(%rax)
  80371b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80371e:	c9                   	leaveq 
  80371f:	c3                   	retq   

0000000000803720 <nsipc_bind>:
  803720:	55                   	push   %rbp
  803721:	48 89 e5             	mov    %rsp,%rbp
  803724:	48 83 ec 10          	sub    $0x10,%rsp
  803728:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80372b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80372f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803732:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803739:	00 00 00 
  80373c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80373f:	89 10                	mov    %edx,(%rax)
  803741:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803744:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803748:	48 89 c6             	mov    %rax,%rsi
  80374b:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803752:	00 00 00 
  803755:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  80375c:	00 00 00 
  80375f:	ff d0                	callq  *%rax
  803761:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803768:	00 00 00 
  80376b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80376e:	89 50 14             	mov    %edx,0x14(%rax)
  803771:	bf 02 00 00 00       	mov    $0x2,%edi
  803776:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  80377d:	00 00 00 
  803780:	ff d0                	callq  *%rax
  803782:	c9                   	leaveq 
  803783:	c3                   	retq   

0000000000803784 <nsipc_shutdown>:
  803784:	55                   	push   %rbp
  803785:	48 89 e5             	mov    %rsp,%rbp
  803788:	48 83 ec 10          	sub    $0x10,%rsp
  80378c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80378f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803792:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803799:	00 00 00 
  80379c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80379f:	89 10                	mov    %edx,(%rax)
  8037a1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8037a8:	00 00 00 
  8037ab:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8037ae:	89 50 04             	mov    %edx,0x4(%rax)
  8037b1:	bf 03 00 00 00       	mov    $0x3,%edi
  8037b6:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  8037bd:	00 00 00 
  8037c0:	ff d0                	callq  *%rax
  8037c2:	c9                   	leaveq 
  8037c3:	c3                   	retq   

00000000008037c4 <nsipc_close>:
  8037c4:	55                   	push   %rbp
  8037c5:	48 89 e5             	mov    %rsp,%rbp
  8037c8:	48 83 ec 10          	sub    $0x10,%rsp
  8037cc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8037cf:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8037d6:	00 00 00 
  8037d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8037dc:	89 10                	mov    %edx,(%rax)
  8037de:	bf 04 00 00 00       	mov    $0x4,%edi
  8037e3:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  8037ea:	00 00 00 
  8037ed:	ff d0                	callq  *%rax
  8037ef:	c9                   	leaveq 
  8037f0:	c3                   	retq   

00000000008037f1 <nsipc_connect>:
  8037f1:	55                   	push   %rbp
  8037f2:	48 89 e5             	mov    %rsp,%rbp
  8037f5:	48 83 ec 10          	sub    $0x10,%rsp
  8037f9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8037fc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803800:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803803:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80380a:	00 00 00 
  80380d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803810:	89 10                	mov    %edx,(%rax)
  803812:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803815:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803819:	48 89 c6             	mov    %rax,%rsi
  80381c:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803823:	00 00 00 
  803826:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  80382d:	00 00 00 
  803830:	ff d0                	callq  *%rax
  803832:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803839:	00 00 00 
  80383c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80383f:	89 50 14             	mov    %edx,0x14(%rax)
  803842:	bf 05 00 00 00       	mov    $0x5,%edi
  803847:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  80384e:	00 00 00 
  803851:	ff d0                	callq  *%rax
  803853:	c9                   	leaveq 
  803854:	c3                   	retq   

0000000000803855 <nsipc_listen>:
  803855:	55                   	push   %rbp
  803856:	48 89 e5             	mov    %rsp,%rbp
  803859:	48 83 ec 10          	sub    $0x10,%rsp
  80385d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803860:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803863:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80386a:	00 00 00 
  80386d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803870:	89 10                	mov    %edx,(%rax)
  803872:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803879:	00 00 00 
  80387c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80387f:	89 50 04             	mov    %edx,0x4(%rax)
  803882:	bf 06 00 00 00       	mov    $0x6,%edi
  803887:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  80388e:	00 00 00 
  803891:	ff d0                	callq  *%rax
  803893:	c9                   	leaveq 
  803894:	c3                   	retq   

0000000000803895 <nsipc_recv>:
  803895:	55                   	push   %rbp
  803896:	48 89 e5             	mov    %rsp,%rbp
  803899:	48 83 ec 30          	sub    $0x30,%rsp
  80389d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8038a0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8038a4:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8038a7:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8038aa:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8038b1:	00 00 00 
  8038b4:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8038b7:	89 10                	mov    %edx,(%rax)
  8038b9:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8038c0:	00 00 00 
  8038c3:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8038c6:	89 50 04             	mov    %edx,0x4(%rax)
  8038c9:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8038d0:	00 00 00 
  8038d3:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8038d6:	89 50 08             	mov    %edx,0x8(%rax)
  8038d9:	bf 07 00 00 00       	mov    $0x7,%edi
  8038de:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  8038e5:	00 00 00 
  8038e8:	ff d0                	callq  *%rax
  8038ea:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038f1:	78 69                	js     80395c <nsipc_recv+0xc7>
  8038f3:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  8038fa:	7f 08                	jg     803904 <nsipc_recv+0x6f>
  8038fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038ff:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803902:	7e 35                	jle    803939 <nsipc_recv+0xa4>
  803904:	48 b9 51 4d 80 00 00 	movabs $0x804d51,%rcx
  80390b:	00 00 00 
  80390e:	48 ba 66 4d 80 00 00 	movabs $0x804d66,%rdx
  803915:	00 00 00 
  803918:	be 62 00 00 00       	mov    $0x62,%esi
  80391d:	48 bf 7b 4d 80 00 00 	movabs $0x804d7b,%rdi
  803924:	00 00 00 
  803927:	b8 00 00 00 00       	mov    $0x0,%eax
  80392c:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  803933:	00 00 00 
  803936:	41 ff d0             	callq  *%r8
  803939:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80393c:	48 63 d0             	movslq %eax,%rdx
  80393f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803943:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  80394a:	00 00 00 
  80394d:	48 89 c7             	mov    %rax,%rdi
  803950:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  803957:	00 00 00 
  80395a:	ff d0                	callq  *%rax
  80395c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80395f:	c9                   	leaveq 
  803960:	c3                   	retq   

0000000000803961 <nsipc_send>:
  803961:	55                   	push   %rbp
  803962:	48 89 e5             	mov    %rsp,%rbp
  803965:	48 83 ec 20          	sub    $0x20,%rsp
  803969:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80396c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803970:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803973:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803976:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80397d:	00 00 00 
  803980:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803983:	89 10                	mov    %edx,(%rax)
  803985:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  80398c:	7e 35                	jle    8039c3 <nsipc_send+0x62>
  80398e:	48 b9 8a 4d 80 00 00 	movabs $0x804d8a,%rcx
  803995:	00 00 00 
  803998:	48 ba 66 4d 80 00 00 	movabs $0x804d66,%rdx
  80399f:	00 00 00 
  8039a2:	be 6d 00 00 00       	mov    $0x6d,%esi
  8039a7:	48 bf 7b 4d 80 00 00 	movabs $0x804d7b,%rdi
  8039ae:	00 00 00 
  8039b1:	b8 00 00 00 00       	mov    $0x0,%eax
  8039b6:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  8039bd:	00 00 00 
  8039c0:	41 ff d0             	callq  *%r8
  8039c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8039c6:	48 63 d0             	movslq %eax,%rdx
  8039c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039cd:	48 89 c6             	mov    %rax,%rsi
  8039d0:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  8039d7:	00 00 00 
  8039da:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  8039e1:	00 00 00 
  8039e4:	ff d0                	callq  *%rax
  8039e6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8039ed:	00 00 00 
  8039f0:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8039f3:	89 50 04             	mov    %edx,0x4(%rax)
  8039f6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8039fd:	00 00 00 
  803a00:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803a03:	89 50 08             	mov    %edx,0x8(%rax)
  803a06:	bf 08 00 00 00       	mov    $0x8,%edi
  803a0b:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  803a12:	00 00 00 
  803a15:	ff d0                	callq  *%rax
  803a17:	c9                   	leaveq 
  803a18:	c3                   	retq   

0000000000803a19 <nsipc_socket>:
  803a19:	55                   	push   %rbp
  803a1a:	48 89 e5             	mov    %rsp,%rbp
  803a1d:	48 83 ec 10          	sub    $0x10,%rsp
  803a21:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a24:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803a27:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803a2a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a31:	00 00 00 
  803a34:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a37:	89 10                	mov    %edx,(%rax)
  803a39:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a40:	00 00 00 
  803a43:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a46:	89 50 04             	mov    %edx,0x4(%rax)
  803a49:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a50:	00 00 00 
  803a53:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803a56:	89 50 08             	mov    %edx,0x8(%rax)
  803a59:	bf 09 00 00 00       	mov    $0x9,%edi
  803a5e:	48 b8 20 36 80 00 00 	movabs $0x803620,%rax
  803a65:	00 00 00 
  803a68:	ff d0                	callq  *%rax
  803a6a:	c9                   	leaveq 
  803a6b:	c3                   	retq   

0000000000803a6c <pipe>:
  803a6c:	55                   	push   %rbp
  803a6d:	48 89 e5             	mov    %rsp,%rbp
  803a70:	53                   	push   %rbx
  803a71:	48 83 ec 38          	sub    $0x38,%rsp
  803a75:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803a79:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803a7d:	48 89 c7             	mov    %rax,%rdi
  803a80:	48 b8 7f 1f 80 00 00 	movabs $0x801f7f,%rax
  803a87:	00 00 00 
  803a8a:	ff d0                	callq  *%rax
  803a8c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803a8f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803a93:	0f 88 bf 01 00 00    	js     803c58 <pipe+0x1ec>
  803a99:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a9d:	ba 07 04 00 00       	mov    $0x407,%edx
  803aa2:	48 89 c6             	mov    %rax,%rsi
  803aa5:	bf 00 00 00 00       	mov    $0x0,%edi
  803aaa:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  803ab1:	00 00 00 
  803ab4:	ff d0                	callq  *%rax
  803ab6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ab9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803abd:	0f 88 95 01 00 00    	js     803c58 <pipe+0x1ec>
  803ac3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803ac7:	48 89 c7             	mov    %rax,%rdi
  803aca:	48 b8 7f 1f 80 00 00 	movabs $0x801f7f,%rax
  803ad1:	00 00 00 
  803ad4:	ff d0                	callq  *%rax
  803ad6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ad9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803add:	0f 88 5d 01 00 00    	js     803c40 <pipe+0x1d4>
  803ae3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ae7:	ba 07 04 00 00       	mov    $0x407,%edx
  803aec:	48 89 c6             	mov    %rax,%rsi
  803aef:	bf 00 00 00 00       	mov    $0x0,%edi
  803af4:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  803afb:	00 00 00 
  803afe:	ff d0                	callq  *%rax
  803b00:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b03:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803b07:	0f 88 33 01 00 00    	js     803c40 <pipe+0x1d4>
  803b0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b11:	48 89 c7             	mov    %rax,%rdi
  803b14:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803b1b:	00 00 00 
  803b1e:	ff d0                	callq  *%rax
  803b20:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803b24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b28:	ba 07 04 00 00       	mov    $0x407,%edx
  803b2d:	48 89 c6             	mov    %rax,%rsi
  803b30:	bf 00 00 00 00       	mov    $0x0,%edi
  803b35:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  803b3c:	00 00 00 
  803b3f:	ff d0                	callq  *%rax
  803b41:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b44:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803b48:	79 05                	jns    803b4f <pipe+0xe3>
  803b4a:	e9 d9 00 00 00       	jmpq   803c28 <pipe+0x1bc>
  803b4f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803b53:	48 89 c7             	mov    %rax,%rdi
  803b56:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803b5d:	00 00 00 
  803b60:	ff d0                	callq  *%rax
  803b62:	48 89 c2             	mov    %rax,%rdx
  803b65:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b69:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803b6f:	48 89 d1             	mov    %rdx,%rcx
  803b72:	ba 00 00 00 00       	mov    $0x0,%edx
  803b77:	48 89 c6             	mov    %rax,%rsi
  803b7a:	bf 00 00 00 00       	mov    $0x0,%edi
  803b7f:	48 b8 bc 18 80 00 00 	movabs $0x8018bc,%rax
  803b86:	00 00 00 
  803b89:	ff d0                	callq  *%rax
  803b8b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b8e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803b92:	79 1b                	jns    803baf <pipe+0x143>
  803b94:	90                   	nop
  803b95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b99:	48 89 c6             	mov    %rax,%rsi
  803b9c:	bf 00 00 00 00       	mov    $0x0,%edi
  803ba1:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  803ba8:	00 00 00 
  803bab:	ff d0                	callq  *%rax
  803bad:	eb 79                	jmp    803c28 <pipe+0x1bc>
  803baf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bb3:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  803bba:	00 00 00 
  803bbd:	8b 12                	mov    (%rdx),%edx
  803bbf:	89 10                	mov    %edx,(%rax)
  803bc1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bc5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803bcc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803bd0:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  803bd7:	00 00 00 
  803bda:	8b 12                	mov    (%rdx),%edx
  803bdc:	89 10                	mov    %edx,(%rax)
  803bde:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803be2:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803be9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bed:	48 89 c7             	mov    %rax,%rdi
  803bf0:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  803bf7:	00 00 00 
  803bfa:	ff d0                	callq  *%rax
  803bfc:	89 c2                	mov    %eax,%edx
  803bfe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803c02:	89 10                	mov    %edx,(%rax)
  803c04:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803c08:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803c0c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c10:	48 89 c7             	mov    %rax,%rdi
  803c13:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  803c1a:	00 00 00 
  803c1d:	ff d0                	callq  *%rax
  803c1f:	89 03                	mov    %eax,(%rbx)
  803c21:	b8 00 00 00 00       	mov    $0x0,%eax
  803c26:	eb 33                	jmp    803c5b <pipe+0x1ef>
  803c28:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c2c:	48 89 c6             	mov    %rax,%rsi
  803c2f:	bf 00 00 00 00       	mov    $0x0,%edi
  803c34:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  803c3b:	00 00 00 
  803c3e:	ff d0                	callq  *%rax
  803c40:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c44:	48 89 c6             	mov    %rax,%rsi
  803c47:	bf 00 00 00 00       	mov    $0x0,%edi
  803c4c:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  803c53:	00 00 00 
  803c56:	ff d0                	callq  *%rax
  803c58:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c5b:	48 83 c4 38          	add    $0x38,%rsp
  803c5f:	5b                   	pop    %rbx
  803c60:	5d                   	pop    %rbp
  803c61:	c3                   	retq   

0000000000803c62 <_pipeisclosed>:
  803c62:	55                   	push   %rbp
  803c63:	48 89 e5             	mov    %rsp,%rbp
  803c66:	53                   	push   %rbx
  803c67:	48 83 ec 28          	sub    $0x28,%rsp
  803c6b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803c6f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803c73:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803c7a:	00 00 00 
  803c7d:	48 8b 00             	mov    (%rax),%rax
  803c80:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803c86:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803c89:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c8d:	48 89 c7             	mov    %rax,%rdi
  803c90:	48 b8 3a 46 80 00 00 	movabs $0x80463a,%rax
  803c97:	00 00 00 
  803c9a:	ff d0                	callq  *%rax
  803c9c:	89 c3                	mov    %eax,%ebx
  803c9e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ca2:	48 89 c7             	mov    %rax,%rdi
  803ca5:	48 b8 3a 46 80 00 00 	movabs $0x80463a,%rax
  803cac:	00 00 00 
  803caf:	ff d0                	callq  *%rax
  803cb1:	39 c3                	cmp    %eax,%ebx
  803cb3:	0f 94 c0             	sete   %al
  803cb6:	0f b6 c0             	movzbl %al,%eax
  803cb9:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803cbc:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803cc3:	00 00 00 
  803cc6:	48 8b 00             	mov    (%rax),%rax
  803cc9:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803ccf:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803cd2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803cd5:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803cd8:	75 05                	jne    803cdf <_pipeisclosed+0x7d>
  803cda:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803cdd:	eb 4f                	jmp    803d2e <_pipeisclosed+0xcc>
  803cdf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ce2:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803ce5:	74 42                	je     803d29 <_pipeisclosed+0xc7>
  803ce7:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803ceb:	75 3c                	jne    803d29 <_pipeisclosed+0xc7>
  803ced:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803cf4:	00 00 00 
  803cf7:	48 8b 00             	mov    (%rax),%rax
  803cfa:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803d00:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803d03:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803d06:	89 c6                	mov    %eax,%esi
  803d08:	48 bf 9b 4d 80 00 00 	movabs $0x804d9b,%rdi
  803d0f:	00 00 00 
  803d12:	b8 00 00 00 00       	mov    $0x0,%eax
  803d17:	49 b8 88 03 80 00 00 	movabs $0x800388,%r8
  803d1e:	00 00 00 
  803d21:	41 ff d0             	callq  *%r8
  803d24:	e9 4a ff ff ff       	jmpq   803c73 <_pipeisclosed+0x11>
  803d29:	e9 45 ff ff ff       	jmpq   803c73 <_pipeisclosed+0x11>
  803d2e:	48 83 c4 28          	add    $0x28,%rsp
  803d32:	5b                   	pop    %rbx
  803d33:	5d                   	pop    %rbp
  803d34:	c3                   	retq   

0000000000803d35 <pipeisclosed>:
  803d35:	55                   	push   %rbp
  803d36:	48 89 e5             	mov    %rsp,%rbp
  803d39:	48 83 ec 30          	sub    $0x30,%rsp
  803d3d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803d40:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803d44:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803d47:	48 89 d6             	mov    %rdx,%rsi
  803d4a:	89 c7                	mov    %eax,%edi
  803d4c:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  803d53:	00 00 00 
  803d56:	ff d0                	callq  *%rax
  803d58:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d5b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d5f:	79 05                	jns    803d66 <pipeisclosed+0x31>
  803d61:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d64:	eb 31                	jmp    803d97 <pipeisclosed+0x62>
  803d66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d6a:	48 89 c7             	mov    %rax,%rdi
  803d6d:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803d74:	00 00 00 
  803d77:	ff d0                	callq  *%rax
  803d79:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803d7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d81:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803d85:	48 89 d6             	mov    %rdx,%rsi
  803d88:	48 89 c7             	mov    %rax,%rdi
  803d8b:	48 b8 62 3c 80 00 00 	movabs $0x803c62,%rax
  803d92:	00 00 00 
  803d95:	ff d0                	callq  *%rax
  803d97:	c9                   	leaveq 
  803d98:	c3                   	retq   

0000000000803d99 <devpipe_read>:
  803d99:	55                   	push   %rbp
  803d9a:	48 89 e5             	mov    %rsp,%rbp
  803d9d:	48 83 ec 40          	sub    $0x40,%rsp
  803da1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803da5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803da9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803dad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803db1:	48 89 c7             	mov    %rax,%rdi
  803db4:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803dbb:	00 00 00 
  803dbe:	ff d0                	callq  *%rax
  803dc0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803dc4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803dc8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803dcc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803dd3:	00 
  803dd4:	e9 92 00 00 00       	jmpq   803e6b <devpipe_read+0xd2>
  803dd9:	eb 41                	jmp    803e1c <devpipe_read+0x83>
  803ddb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  803de0:	74 09                	je     803deb <devpipe_read+0x52>
  803de2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803de6:	e9 92 00 00 00       	jmpq   803e7d <devpipe_read+0xe4>
  803deb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803def:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803df3:	48 89 d6             	mov    %rdx,%rsi
  803df6:	48 89 c7             	mov    %rax,%rdi
  803df9:	48 b8 62 3c 80 00 00 	movabs $0x803c62,%rax
  803e00:	00 00 00 
  803e03:	ff d0                	callq  *%rax
  803e05:	85 c0                	test   %eax,%eax
  803e07:	74 07                	je     803e10 <devpipe_read+0x77>
  803e09:	b8 00 00 00 00       	mov    $0x0,%eax
  803e0e:	eb 6d                	jmp    803e7d <devpipe_read+0xe4>
  803e10:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  803e17:	00 00 00 
  803e1a:	ff d0                	callq  *%rax
  803e1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e20:	8b 10                	mov    (%rax),%edx
  803e22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e26:	8b 40 04             	mov    0x4(%rax),%eax
  803e29:	39 c2                	cmp    %eax,%edx
  803e2b:	74 ae                	je     803ddb <devpipe_read+0x42>
  803e2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e31:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803e35:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  803e39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e3d:	8b 00                	mov    (%rax),%eax
  803e3f:	99                   	cltd   
  803e40:	c1 ea 1b             	shr    $0x1b,%edx
  803e43:	01 d0                	add    %edx,%eax
  803e45:	83 e0 1f             	and    $0x1f,%eax
  803e48:	29 d0                	sub    %edx,%eax
  803e4a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803e4e:	48 98                	cltq   
  803e50:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  803e55:	88 01                	mov    %al,(%rcx)
  803e57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e5b:	8b 00                	mov    (%rax),%eax
  803e5d:	8d 50 01             	lea    0x1(%rax),%edx
  803e60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e64:	89 10                	mov    %edx,(%rax)
  803e66:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803e6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e6f:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803e73:	0f 82 60 ff ff ff    	jb     803dd9 <devpipe_read+0x40>
  803e79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e7d:	c9                   	leaveq 
  803e7e:	c3                   	retq   

0000000000803e7f <devpipe_write>:
  803e7f:	55                   	push   %rbp
  803e80:	48 89 e5             	mov    %rsp,%rbp
  803e83:	48 83 ec 40          	sub    $0x40,%rsp
  803e87:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803e8b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803e8f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803e93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e97:	48 89 c7             	mov    %rax,%rdi
  803e9a:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803ea1:	00 00 00 
  803ea4:	ff d0                	callq  *%rax
  803ea6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803eaa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803eae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803eb2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803eb9:	00 
  803eba:	e9 8e 00 00 00       	jmpq   803f4d <devpipe_write+0xce>
  803ebf:	eb 31                	jmp    803ef2 <devpipe_write+0x73>
  803ec1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803ec5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ec9:	48 89 d6             	mov    %rdx,%rsi
  803ecc:	48 89 c7             	mov    %rax,%rdi
  803ecf:	48 b8 62 3c 80 00 00 	movabs $0x803c62,%rax
  803ed6:	00 00 00 
  803ed9:	ff d0                	callq  *%rax
  803edb:	85 c0                	test   %eax,%eax
  803edd:	74 07                	je     803ee6 <devpipe_write+0x67>
  803edf:	b8 00 00 00 00       	mov    $0x0,%eax
  803ee4:	eb 79                	jmp    803f5f <devpipe_write+0xe0>
  803ee6:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  803eed:	00 00 00 
  803ef0:	ff d0                	callq  *%rax
  803ef2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ef6:	8b 40 04             	mov    0x4(%rax),%eax
  803ef9:	48 63 d0             	movslq %eax,%rdx
  803efc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f00:	8b 00                	mov    (%rax),%eax
  803f02:	48 98                	cltq   
  803f04:	48 83 c0 20          	add    $0x20,%rax
  803f08:	48 39 c2             	cmp    %rax,%rdx
  803f0b:	73 b4                	jae    803ec1 <devpipe_write+0x42>
  803f0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f11:	8b 40 04             	mov    0x4(%rax),%eax
  803f14:	99                   	cltd   
  803f15:	c1 ea 1b             	shr    $0x1b,%edx
  803f18:	01 d0                	add    %edx,%eax
  803f1a:	83 e0 1f             	and    $0x1f,%eax
  803f1d:	29 d0                	sub    %edx,%eax
  803f1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803f23:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803f27:	48 01 ca             	add    %rcx,%rdx
  803f2a:	0f b6 0a             	movzbl (%rdx),%ecx
  803f2d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803f31:	48 98                	cltq   
  803f33:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803f37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f3b:	8b 40 04             	mov    0x4(%rax),%eax
  803f3e:	8d 50 01             	lea    0x1(%rax),%edx
  803f41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f45:	89 50 04             	mov    %edx,0x4(%rax)
  803f48:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803f4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f51:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803f55:	0f 82 64 ff ff ff    	jb     803ebf <devpipe_write+0x40>
  803f5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f5f:	c9                   	leaveq 
  803f60:	c3                   	retq   

0000000000803f61 <devpipe_stat>:
  803f61:	55                   	push   %rbp
  803f62:	48 89 e5             	mov    %rsp,%rbp
  803f65:	48 83 ec 20          	sub    $0x20,%rsp
  803f69:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f6d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f75:	48 89 c7             	mov    %rax,%rdi
  803f78:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  803f7f:	00 00 00 
  803f82:	ff d0                	callq  *%rax
  803f84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803f88:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f8c:	48 be ae 4d 80 00 00 	movabs $0x804dae,%rsi
  803f93:	00 00 00 
  803f96:	48 89 c7             	mov    %rax,%rdi
  803f99:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  803fa0:	00 00 00 
  803fa3:	ff d0                	callq  *%rax
  803fa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803fa9:	8b 50 04             	mov    0x4(%rax),%edx
  803fac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803fb0:	8b 00                	mov    (%rax),%eax
  803fb2:	29 c2                	sub    %eax,%edx
  803fb4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fb8:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803fbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fc2:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803fc9:	00 00 00 
  803fcc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fd0:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  803fd7:	00 00 00 
  803fda:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  803fe1:	b8 00 00 00 00       	mov    $0x0,%eax
  803fe6:	c9                   	leaveq 
  803fe7:	c3                   	retq   

0000000000803fe8 <devpipe_close>:
  803fe8:	55                   	push   %rbp
  803fe9:	48 89 e5             	mov    %rsp,%rbp
  803fec:	48 83 ec 10          	sub    $0x10,%rsp
  803ff0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803ff4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ff8:	48 89 c6             	mov    %rax,%rsi
  803ffb:	bf 00 00 00 00       	mov    $0x0,%edi
  804000:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  804007:	00 00 00 
  80400a:	ff d0                	callq  *%rax
  80400c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804010:	48 89 c7             	mov    %rax,%rdi
  804013:	48 b8 54 1f 80 00 00 	movabs $0x801f54,%rax
  80401a:	00 00 00 
  80401d:	ff d0                	callq  *%rax
  80401f:	48 89 c6             	mov    %rax,%rsi
  804022:	bf 00 00 00 00       	mov    $0x0,%edi
  804027:	48 b8 17 19 80 00 00 	movabs $0x801917,%rax
  80402e:	00 00 00 
  804031:	ff d0                	callq  *%rax
  804033:	c9                   	leaveq 
  804034:	c3                   	retq   

0000000000804035 <cputchar>:
  804035:	55                   	push   %rbp
  804036:	48 89 e5             	mov    %rsp,%rbp
  804039:	48 83 ec 20          	sub    $0x20,%rsp
  80403d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804040:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804043:	88 45 ff             	mov    %al,-0x1(%rbp)
  804046:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  80404a:	be 01 00 00 00       	mov    $0x1,%esi
  80404f:	48 89 c7             	mov    %rax,%rdi
  804052:	48 b8 24 17 80 00 00 	movabs $0x801724,%rax
  804059:	00 00 00 
  80405c:	ff d0                	callq  *%rax
  80405e:	c9                   	leaveq 
  80405f:	c3                   	retq   

0000000000804060 <getchar>:
  804060:	55                   	push   %rbp
  804061:	48 89 e5             	mov    %rsp,%rbp
  804064:	48 83 ec 10          	sub    $0x10,%rsp
  804068:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  80406c:	ba 01 00 00 00       	mov    $0x1,%edx
  804071:	48 89 c6             	mov    %rax,%rsi
  804074:	bf 00 00 00 00       	mov    $0x0,%edi
  804079:	48 b8 49 24 80 00 00 	movabs $0x802449,%rax
  804080:	00 00 00 
  804083:	ff d0                	callq  *%rax
  804085:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804088:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80408c:	79 05                	jns    804093 <getchar+0x33>
  80408e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804091:	eb 14                	jmp    8040a7 <getchar+0x47>
  804093:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804097:	7f 07                	jg     8040a0 <getchar+0x40>
  804099:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80409e:	eb 07                	jmp    8040a7 <getchar+0x47>
  8040a0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8040a4:	0f b6 c0             	movzbl %al,%eax
  8040a7:	c9                   	leaveq 
  8040a8:	c3                   	retq   

00000000008040a9 <iscons>:
  8040a9:	55                   	push   %rbp
  8040aa:	48 89 e5             	mov    %rsp,%rbp
  8040ad:	48 83 ec 20          	sub    $0x20,%rsp
  8040b1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8040b4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8040b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8040bb:	48 89 d6             	mov    %rdx,%rsi
  8040be:	89 c7                	mov    %eax,%edi
  8040c0:	48 b8 17 20 80 00 00 	movabs $0x802017,%rax
  8040c7:	00 00 00 
  8040ca:	ff d0                	callq  *%rax
  8040cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040d3:	79 05                	jns    8040da <iscons+0x31>
  8040d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040d8:	eb 1a                	jmp    8040f4 <iscons+0x4b>
  8040da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040de:	8b 10                	mov    (%rax),%edx
  8040e0:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  8040e7:	00 00 00 
  8040ea:	8b 00                	mov    (%rax),%eax
  8040ec:	39 c2                	cmp    %eax,%edx
  8040ee:	0f 94 c0             	sete   %al
  8040f1:	0f b6 c0             	movzbl %al,%eax
  8040f4:	c9                   	leaveq 
  8040f5:	c3                   	retq   

00000000008040f6 <opencons>:
  8040f6:	55                   	push   %rbp
  8040f7:	48 89 e5             	mov    %rsp,%rbp
  8040fa:	48 83 ec 10          	sub    $0x10,%rsp
  8040fe:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804102:	48 89 c7             	mov    %rax,%rdi
  804105:	48 b8 7f 1f 80 00 00 	movabs $0x801f7f,%rax
  80410c:	00 00 00 
  80410f:	ff d0                	callq  *%rax
  804111:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804114:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804118:	79 05                	jns    80411f <opencons+0x29>
  80411a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80411d:	eb 5b                	jmp    80417a <opencons+0x84>
  80411f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804123:	ba 07 04 00 00       	mov    $0x407,%edx
  804128:	48 89 c6             	mov    %rax,%rsi
  80412b:	bf 00 00 00 00       	mov    $0x0,%edi
  804130:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  804137:	00 00 00 
  80413a:	ff d0                	callq  *%rax
  80413c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80413f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804143:	79 05                	jns    80414a <opencons+0x54>
  804145:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804148:	eb 30                	jmp    80417a <opencons+0x84>
  80414a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80414e:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  804155:	00 00 00 
  804158:	8b 12                	mov    (%rdx),%edx
  80415a:	89 10                	mov    %edx,(%rax)
  80415c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804160:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  804167:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80416b:	48 89 c7             	mov    %rax,%rdi
  80416e:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  804175:	00 00 00 
  804178:	ff d0                	callq  *%rax
  80417a:	c9                   	leaveq 
  80417b:	c3                   	retq   

000000000080417c <devcons_read>:
  80417c:	55                   	push   %rbp
  80417d:	48 89 e5             	mov    %rsp,%rbp
  804180:	48 83 ec 30          	sub    $0x30,%rsp
  804184:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804188:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80418c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804190:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804195:	75 07                	jne    80419e <devcons_read+0x22>
  804197:	b8 00 00 00 00       	mov    $0x0,%eax
  80419c:	eb 4b                	jmp    8041e9 <devcons_read+0x6d>
  80419e:	eb 0c                	jmp    8041ac <devcons_read+0x30>
  8041a0:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  8041a7:	00 00 00 
  8041aa:	ff d0                	callq  *%rax
  8041ac:	48 b8 6e 17 80 00 00 	movabs $0x80176e,%rax
  8041b3:	00 00 00 
  8041b6:	ff d0                	callq  *%rax
  8041b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8041bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8041bf:	74 df                	je     8041a0 <devcons_read+0x24>
  8041c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8041c5:	79 05                	jns    8041cc <devcons_read+0x50>
  8041c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041ca:	eb 1d                	jmp    8041e9 <devcons_read+0x6d>
  8041cc:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  8041d0:	75 07                	jne    8041d9 <devcons_read+0x5d>
  8041d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8041d7:	eb 10                	jmp    8041e9 <devcons_read+0x6d>
  8041d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041dc:	89 c2                	mov    %eax,%edx
  8041de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8041e2:	88 10                	mov    %dl,(%rax)
  8041e4:	b8 01 00 00 00       	mov    $0x1,%eax
  8041e9:	c9                   	leaveq 
  8041ea:	c3                   	retq   

00000000008041eb <devcons_write>:
  8041eb:	55                   	push   %rbp
  8041ec:	48 89 e5             	mov    %rsp,%rbp
  8041ef:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  8041f6:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8041fd:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804204:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80420b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804212:	eb 76                	jmp    80428a <devcons_write+0x9f>
  804214:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80421b:	89 c2                	mov    %eax,%edx
  80421d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804220:	29 c2                	sub    %eax,%edx
  804222:	89 d0                	mov    %edx,%eax
  804224:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804227:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80422a:	83 f8 7f             	cmp    $0x7f,%eax
  80422d:	76 07                	jbe    804236 <devcons_write+0x4b>
  80422f:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804236:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804239:	48 63 d0             	movslq %eax,%rdx
  80423c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80423f:	48 63 c8             	movslq %eax,%rcx
  804242:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804249:	48 01 c1             	add    %rax,%rcx
  80424c:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804253:	48 89 ce             	mov    %rcx,%rsi
  804256:	48 89 c7             	mov    %rax,%rdi
  804259:	48 b8 61 12 80 00 00 	movabs $0x801261,%rax
  804260:	00 00 00 
  804263:	ff d0                	callq  *%rax
  804265:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804268:	48 63 d0             	movslq %eax,%rdx
  80426b:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804272:	48 89 d6             	mov    %rdx,%rsi
  804275:	48 89 c7             	mov    %rax,%rdi
  804278:	48 b8 24 17 80 00 00 	movabs $0x801724,%rax
  80427f:	00 00 00 
  804282:	ff d0                	callq  *%rax
  804284:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804287:	01 45 fc             	add    %eax,-0x4(%rbp)
  80428a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80428d:	48 98                	cltq   
  80428f:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804296:	0f 82 78 ff ff ff    	jb     804214 <devcons_write+0x29>
  80429c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80429f:	c9                   	leaveq 
  8042a0:	c3                   	retq   

00000000008042a1 <devcons_close>:
  8042a1:	55                   	push   %rbp
  8042a2:	48 89 e5             	mov    %rsp,%rbp
  8042a5:	48 83 ec 08          	sub    $0x8,%rsp
  8042a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8042ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8042b2:	c9                   	leaveq 
  8042b3:	c3                   	retq   

00000000008042b4 <devcons_stat>:
  8042b4:	55                   	push   %rbp
  8042b5:	48 89 e5             	mov    %rsp,%rbp
  8042b8:	48 83 ec 10          	sub    $0x10,%rsp
  8042bc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8042c0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8042c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042c8:	48 be ba 4d 80 00 00 	movabs $0x804dba,%rsi
  8042cf:	00 00 00 
  8042d2:	48 89 c7             	mov    %rax,%rdi
  8042d5:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  8042dc:	00 00 00 
  8042df:	ff d0                	callq  *%rax
  8042e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8042e6:	c9                   	leaveq 
  8042e7:	c3                   	retq   

00000000008042e8 <_panic>:
  8042e8:	55                   	push   %rbp
  8042e9:	48 89 e5             	mov    %rsp,%rbp
  8042ec:	53                   	push   %rbx
  8042ed:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8042f4:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8042fb:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  804301:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  804308:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  80430f:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  804316:	84 c0                	test   %al,%al
  804318:	74 23                	je     80433d <_panic+0x55>
  80431a:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  804321:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  804325:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  804329:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80432d:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  804331:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  804335:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  804339:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80433d:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  804344:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80434b:	00 00 00 
  80434e:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  804355:	00 00 00 
  804358:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80435c:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  804363:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80436a:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  804371:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  804378:	00 00 00 
  80437b:	48 8b 18             	mov    (%rax),%rbx
  80437e:	48 b8 f0 17 80 00 00 	movabs $0x8017f0,%rax
  804385:	00 00 00 
  804388:	ff d0                	callq  *%rax
  80438a:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  804390:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  804397:	41 89 c8             	mov    %ecx,%r8d
  80439a:	48 89 d1             	mov    %rdx,%rcx
  80439d:	48 89 da             	mov    %rbx,%rdx
  8043a0:	89 c6                	mov    %eax,%esi
  8043a2:	48 bf c8 4d 80 00 00 	movabs $0x804dc8,%rdi
  8043a9:	00 00 00 
  8043ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8043b1:	49 b9 88 03 80 00 00 	movabs $0x800388,%r9
  8043b8:	00 00 00 
  8043bb:	41 ff d1             	callq  *%r9
  8043be:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8043c5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8043cc:	48 89 d6             	mov    %rdx,%rsi
  8043cf:	48 89 c7             	mov    %rax,%rdi
  8043d2:	48 b8 dc 02 80 00 00 	movabs $0x8002dc,%rax
  8043d9:	00 00 00 
  8043dc:	ff d0                	callq  *%rax
  8043de:	48 bf eb 4d 80 00 00 	movabs $0x804deb,%rdi
  8043e5:	00 00 00 
  8043e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8043ed:	48 ba 88 03 80 00 00 	movabs $0x800388,%rdx
  8043f4:	00 00 00 
  8043f7:	ff d2                	callq  *%rdx
  8043f9:	cc                   	int3   
  8043fa:	eb fd                	jmp    8043f9 <_panic+0x111>

00000000008043fc <ipc_recv>:
  8043fc:	55                   	push   %rbp
  8043fd:	48 89 e5             	mov    %rsp,%rbp
  804400:	48 83 ec 30          	sub    $0x30,%rsp
  804404:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804408:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80440c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804410:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804415:	75 0e                	jne    804425 <ipc_recv+0x29>
  804417:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80441e:	00 00 00 
  804421:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804425:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804429:	48 89 c7             	mov    %rax,%rdi
  80442c:	48 b8 95 1a 80 00 00 	movabs $0x801a95,%rax
  804433:	00 00 00 
  804436:	ff d0                	callq  *%rax
  804438:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80443b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80443f:	79 27                	jns    804468 <ipc_recv+0x6c>
  804441:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804446:	74 0a                	je     804452 <ipc_recv+0x56>
  804448:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80444c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804452:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804457:	74 0a                	je     804463 <ipc_recv+0x67>
  804459:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80445d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804463:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804466:	eb 53                	jmp    8044bb <ipc_recv+0xbf>
  804468:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80446d:	74 19                	je     804488 <ipc_recv+0x8c>
  80446f:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  804476:	00 00 00 
  804479:	48 8b 00             	mov    (%rax),%rax
  80447c:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  804482:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804486:	89 10                	mov    %edx,(%rax)
  804488:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80448d:	74 19                	je     8044a8 <ipc_recv+0xac>
  80448f:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  804496:	00 00 00 
  804499:	48 8b 00             	mov    (%rax),%rax
  80449c:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  8044a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8044a6:	89 10                	mov    %edx,(%rax)
  8044a8:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8044af:	00 00 00 
  8044b2:	48 8b 00             	mov    (%rax),%rax
  8044b5:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  8044bb:	c9                   	leaveq 
  8044bc:	c3                   	retq   

00000000008044bd <ipc_send>:
  8044bd:	55                   	push   %rbp
  8044be:	48 89 e5             	mov    %rsp,%rbp
  8044c1:	48 83 ec 30          	sub    $0x30,%rsp
  8044c5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8044c8:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8044cb:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8044cf:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8044d2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8044d7:	75 10                	jne    8044e9 <ipc_send+0x2c>
  8044d9:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8044e0:	00 00 00 
  8044e3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8044e7:	eb 0e                	jmp    8044f7 <ipc_send+0x3a>
  8044e9:	eb 0c                	jmp    8044f7 <ipc_send+0x3a>
  8044eb:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  8044f2:	00 00 00 
  8044f5:	ff d0                	callq  *%rax
  8044f7:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8044fa:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8044fd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804501:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804504:	89 c7                	mov    %eax,%edi
  804506:	48 b8 40 1a 80 00 00 	movabs $0x801a40,%rax
  80450d:	00 00 00 
  804510:	ff d0                	callq  *%rax
  804512:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804515:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804519:	74 d0                	je     8044eb <ipc_send+0x2e>
  80451b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80451f:	79 30                	jns    804551 <ipc_send+0x94>
  804521:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804524:	89 c1                	mov    %eax,%ecx
  804526:	48 ba f0 4d 80 00 00 	movabs $0x804df0,%rdx
  80452d:	00 00 00 
  804530:	be 44 00 00 00       	mov    $0x44,%esi
  804535:	48 bf 06 4e 80 00 00 	movabs $0x804e06,%rdi
  80453c:	00 00 00 
  80453f:	b8 00 00 00 00       	mov    $0x0,%eax
  804544:	49 b8 e8 42 80 00 00 	movabs $0x8042e8,%r8
  80454b:	00 00 00 
  80454e:	41 ff d0             	callq  *%r8
  804551:	c9                   	leaveq 
  804552:	c3                   	retq   

0000000000804553 <ipc_host_recv>:
  804553:	55                   	push   %rbp
  804554:	48 89 e5             	mov    %rsp,%rbp
  804557:	48 83 ec 10          	sub    $0x10,%rsp
  80455b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80455f:	48 ba 18 4e 80 00 00 	movabs $0x804e18,%rdx
  804566:	00 00 00 
  804569:	be 4e 00 00 00       	mov    $0x4e,%esi
  80456e:	48 bf 06 4e 80 00 00 	movabs $0x804e06,%rdi
  804575:	00 00 00 
  804578:	b8 00 00 00 00       	mov    $0x0,%eax
  80457d:	48 b9 e8 42 80 00 00 	movabs $0x8042e8,%rcx
  804584:	00 00 00 
  804587:	ff d1                	callq  *%rcx

0000000000804589 <ipc_host_send>:
  804589:	55                   	push   %rbp
  80458a:	48 89 e5             	mov    %rsp,%rbp
  80458d:	48 83 ec 20          	sub    $0x20,%rsp
  804591:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804594:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804597:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80459b:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80459e:	48 ba 38 4e 80 00 00 	movabs $0x804e38,%rdx
  8045a5:	00 00 00 
  8045a8:	be 67 00 00 00       	mov    $0x67,%esi
  8045ad:	48 bf 06 4e 80 00 00 	movabs $0x804e06,%rdi
  8045b4:	00 00 00 
  8045b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8045bc:	48 b9 e8 42 80 00 00 	movabs $0x8042e8,%rcx
  8045c3:	00 00 00 
  8045c6:	ff d1                	callq  *%rcx

00000000008045c8 <ipc_find_env>:
  8045c8:	55                   	push   %rbp
  8045c9:	48 89 e5             	mov    %rsp,%rbp
  8045cc:	48 83 ec 14          	sub    $0x14,%rsp
  8045d0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8045d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8045da:	eb 4e                	jmp    80462a <ipc_find_env+0x62>
  8045dc:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8045e3:	00 00 00 
  8045e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045e9:	48 98                	cltq   
  8045eb:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8045f2:	48 01 d0             	add    %rdx,%rax
  8045f5:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8045fb:	8b 00                	mov    (%rax),%eax
  8045fd:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804600:	75 24                	jne    804626 <ipc_find_env+0x5e>
  804602:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804609:	00 00 00 
  80460c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80460f:	48 98                	cltq   
  804611:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804618:	48 01 d0             	add    %rdx,%rax
  80461b:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804621:	8b 40 08             	mov    0x8(%rax),%eax
  804624:	eb 12                	jmp    804638 <ipc_find_env+0x70>
  804626:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80462a:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804631:	7e a9                	jle    8045dc <ipc_find_env+0x14>
  804633:	b8 00 00 00 00       	mov    $0x0,%eax
  804638:	c9                   	leaveq 
  804639:	c3                   	retq   

000000000080463a <pageref>:
  80463a:	55                   	push   %rbp
  80463b:	48 89 e5             	mov    %rsp,%rbp
  80463e:	48 83 ec 18          	sub    $0x18,%rsp
  804642:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804646:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80464a:	48 c1 e8 15          	shr    $0x15,%rax
  80464e:	48 89 c2             	mov    %rax,%rdx
  804651:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804658:	01 00 00 
  80465b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80465f:	83 e0 01             	and    $0x1,%eax
  804662:	48 85 c0             	test   %rax,%rax
  804665:	75 07                	jne    80466e <pageref+0x34>
  804667:	b8 00 00 00 00       	mov    $0x0,%eax
  80466c:	eb 53                	jmp    8046c1 <pageref+0x87>
  80466e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804672:	48 c1 e8 0c          	shr    $0xc,%rax
  804676:	48 89 c2             	mov    %rax,%rdx
  804679:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804680:	01 00 00 
  804683:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804687:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80468b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80468f:	83 e0 01             	and    $0x1,%eax
  804692:	48 85 c0             	test   %rax,%rax
  804695:	75 07                	jne    80469e <pageref+0x64>
  804697:	b8 00 00 00 00       	mov    $0x0,%eax
  80469c:	eb 23                	jmp    8046c1 <pageref+0x87>
  80469e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046a2:	48 c1 e8 0c          	shr    $0xc,%rax
  8046a6:	48 89 c2             	mov    %rax,%rdx
  8046a9:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  8046b0:	00 00 00 
  8046b3:	48 c1 e2 04          	shl    $0x4,%rdx
  8046b7:	48 01 d0             	add    %rdx,%rax
  8046ba:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  8046be:	0f b7 c0             	movzwl %ax,%eax
  8046c1:	c9                   	leaveq 
  8046c2:	c3                   	retq   
