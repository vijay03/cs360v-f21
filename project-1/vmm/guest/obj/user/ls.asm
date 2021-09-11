
vmm/guest/obj/user/ls:     file format elf64-x86-64


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
  80003c:	e8 da 04 00 00       	callq  80051b <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <ls>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80004e:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
  800055:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
  80005c:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  800063:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80006a:	48 89 d6             	mov    %rdx,%rsi
  80006d:	48 89 c7             	mov    %rax,%rdi
  800070:	48 b8 a3 2c 80 00 00 	movabs $0x802ca3,%rax
  800077:	00 00 00 
  80007a:	ff d0                	callq  *%rax
  80007c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80007f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800083:	79 3b                	jns    8000c0 <ls+0x7d>
  800085:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800088:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80008f:	41 89 d0             	mov    %edx,%r8d
  800092:	48 89 c1             	mov    %rax,%rcx
  800095:	48 ba 40 4a 80 00 00 	movabs $0x804a40,%rdx
  80009c:	00 00 00 
  80009f:	be 10 00 00 00       	mov    $0x10,%esi
  8000a4:	48 bf 4c 4a 80 00 00 	movabs $0x804a4c,%rdi
  8000ab:	00 00 00 
  8000ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b3:	49 b9 c1 05 80 00 00 	movabs $0x8005c1,%r9
  8000ba:	00 00 00 
  8000bd:	41 ff d1             	callq  *%r9
  8000c0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8000c3:	85 c0                	test   %eax,%eax
  8000c5:	74 36                	je     8000fd <ls+0xba>
  8000c7:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  8000ce:	00 00 00 
  8000d1:	8b 80 90 01 00 00    	mov    0x190(%rax),%eax
  8000d7:	85 c0                	test   %eax,%eax
  8000d9:	75 22                	jne    8000fd <ls+0xba>
  8000db:	48 8b 95 50 ff ff ff 	mov    -0xb0(%rbp),%rdx
  8000e2:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8000e9:	48 89 d6             	mov    %rdx,%rsi
  8000ec:	48 89 c7             	mov    %rax,%rdi
  8000ef:	48 b8 27 01 80 00 00 	movabs $0x800127,%rax
  8000f6:	00 00 00 
  8000f9:	ff d0                	callq  *%rax
  8000fb:	eb 28                	jmp    800125 <ls+0xe2>
  8000fd:	8b 55 e0             	mov    -0x20(%rbp),%edx
  800100:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800103:	85 c0                	test   %eax,%eax
  800105:	0f 95 c0             	setne  %al
  800108:	0f b6 c0             	movzbl %al,%eax
  80010b:	48 8b 8d 58 ff ff ff 	mov    -0xa8(%rbp),%rcx
  800112:	89 c6                	mov    %eax,%esi
  800114:	bf 00 00 00 00       	mov    $0x0,%edi
  800119:	48 b8 88 02 80 00 00 	movabs $0x800288,%rax
  800120:	00 00 00 
  800123:	ff d0                	callq  *%rax
  800125:	c9                   	leaveq 
  800126:	c3                   	retq   

0000000000800127 <lsdir>:
  800127:	55                   	push   %rbp
  800128:	48 89 e5             	mov    %rsp,%rbp
  80012b:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  800132:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
  800139:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  800140:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
  800147:	be 00 00 00 00       	mov    $0x0,%esi
  80014c:	48 89 c7             	mov    %rax,%rdi
  80014f:	48 b8 91 2d 80 00 00 	movabs $0x802d91,%rax
  800156:	00 00 00 
  800159:	ff d0                	callq  *%rax
  80015b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80015e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800162:	79 3b                	jns    80019f <lsdir+0x78>
  800164:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800167:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
  80016e:	41 89 d0             	mov    %edx,%r8d
  800171:	48 89 c1             	mov    %rax,%rcx
  800174:	48 ba 59 4a 80 00 00 	movabs $0x804a59,%rdx
  80017b:	00 00 00 
  80017e:	be 1e 00 00 00       	mov    $0x1e,%esi
  800183:	48 bf 4c 4a 80 00 00 	movabs $0x804a4c,%rdi
  80018a:	00 00 00 
  80018d:	b8 00 00 00 00       	mov    $0x0,%eax
  800192:	49 b9 c1 05 80 00 00 	movabs $0x8005c1,%r9
  800199:	00 00 00 
  80019c:	41 ff d1             	callq  *%r9
  80019f:	eb 3d                	jmp    8001de <lsdir+0xb7>
  8001a1:	0f b6 85 f0 fe ff ff 	movzbl -0x110(%rbp),%eax
  8001a8:	84 c0                	test   %al,%al
  8001aa:	74 32                	je     8001de <lsdir+0xb7>
  8001ac:	8b 95 70 ff ff ff    	mov    -0x90(%rbp),%edx
  8001b2:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  8001b8:	83 f8 01             	cmp    $0x1,%eax
  8001bb:	0f 94 c0             	sete   %al
  8001be:	0f b6 f0             	movzbl %al,%esi
  8001c1:	48 8d 8d f0 fe ff ff 	lea    -0x110(%rbp),%rcx
  8001c8:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
  8001cf:	48 89 c7             	mov    %rax,%rdi
  8001d2:	48 b8 88 02 80 00 00 	movabs $0x800288,%rax
  8001d9:	00 00 00 
  8001dc:	ff d0                	callq  *%rax
  8001de:	48 8d 8d f0 fe ff ff 	lea    -0x110(%rbp),%rcx
  8001e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8001e8:	ba 00 01 00 00       	mov    $0x100,%edx
  8001ed:	48 89 ce             	mov    %rcx,%rsi
  8001f0:	89 c7                	mov    %eax,%edi
  8001f2:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  8001f9:	00 00 00 
  8001fc:	ff d0                	callq  *%rax
  8001fe:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800201:	81 7d f8 00 01 00 00 	cmpl   $0x100,-0x8(%rbp)
  800208:	74 97                	je     8001a1 <lsdir+0x7a>
  80020a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80020e:	7e 35                	jle    800245 <lsdir+0x11e>
  800210:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
  800217:	48 89 c1             	mov    %rax,%rcx
  80021a:	48 ba 65 4a 80 00 00 	movabs $0x804a65,%rdx
  800221:	00 00 00 
  800224:	be 23 00 00 00       	mov    $0x23,%esi
  800229:	48 bf 4c 4a 80 00 00 	movabs $0x804a4c,%rdi
  800230:	00 00 00 
  800233:	b8 00 00 00 00       	mov    $0x0,%eax
  800238:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  80023f:	00 00 00 
  800242:	41 ff d0             	callq  *%r8
  800245:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800249:	79 3b                	jns    800286 <lsdir+0x15f>
  80024b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80024e:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
  800255:	41 89 d0             	mov    %edx,%r8d
  800258:	48 89 c1             	mov    %rax,%rcx
  80025b:	48 ba 80 4a 80 00 00 	movabs $0x804a80,%rdx
  800262:	00 00 00 
  800265:	be 25 00 00 00       	mov    $0x25,%esi
  80026a:	48 bf 4c 4a 80 00 00 	movabs $0x804a4c,%rdi
  800271:	00 00 00 
  800274:	b8 00 00 00 00       	mov    $0x0,%eax
  800279:	49 b9 c1 05 80 00 00 	movabs $0x8005c1,%r9
  800280:	00 00 00 
  800283:	41 ff d1             	callq  *%r9
  800286:	c9                   	leaveq 
  800287:	c3                   	retq   

0000000000800288 <ls1>:
  800288:	55                   	push   %rbp
  800289:	48 89 e5             	mov    %rsp,%rbp
  80028c:	48 83 ec 30          	sub    $0x30,%rsp
  800290:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800294:	89 f0                	mov    %esi,%eax
  800296:	89 55 e0             	mov    %edx,-0x20(%rbp)
  800299:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  80029d:	88 45 e4             	mov    %al,-0x1c(%rbp)
  8002a0:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  8002a7:	00 00 00 
  8002aa:	8b 80 b0 01 00 00    	mov    0x1b0(%rax),%eax
  8002b0:	85 c0                	test   %eax,%eax
  8002b2:	74 34                	je     8002e8 <ls1+0x60>
  8002b4:	80 7d e4 00          	cmpb   $0x0,-0x1c(%rbp)
  8002b8:	74 07                	je     8002c1 <ls1+0x39>
  8002ba:	b8 64 00 00 00       	mov    $0x64,%eax
  8002bf:	eb 05                	jmp    8002c6 <ls1+0x3e>
  8002c1:	b8 2d 00 00 00       	mov    $0x2d,%eax
  8002c6:	8b 4d e0             	mov    -0x20(%rbp),%ecx
  8002c9:	89 c2                	mov    %eax,%edx
  8002cb:	89 ce                	mov    %ecx,%esi
  8002cd:	48 bf 9f 4a 80 00 00 	movabs $0x804a9f,%rdi
  8002d4:	00 00 00 
  8002d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8002dc:	48 b9 1c 36 80 00 00 	movabs $0x80361c,%rcx
  8002e3:	00 00 00 
  8002e6:	ff d1                	callq  *%rcx
  8002e8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8002ed:	74 76                	je     800365 <ls1+0xdd>
  8002ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8002f3:	0f b6 00             	movzbl (%rax),%eax
  8002f6:	84 c0                	test   %al,%al
  8002f8:	74 37                	je     800331 <ls1+0xa9>
  8002fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8002fe:	48 89 c7             	mov    %rax,%rdi
  800301:	48 b8 43 13 80 00 00 	movabs $0x801343,%rax
  800308:	00 00 00 
  80030b:	ff d0                	callq  *%rax
  80030d:	48 98                	cltq   
  80030f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800313:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800317:	48 01 d0             	add    %rdx,%rax
  80031a:	0f b6 00             	movzbl (%rax),%eax
  80031d:	3c 2f                	cmp    $0x2f,%al
  80031f:	74 10                	je     800331 <ls1+0xa9>
  800321:	48 b8 a8 4a 80 00 00 	movabs $0x804aa8,%rax
  800328:	00 00 00 
  80032b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80032f:	eb 0e                	jmp    80033f <ls1+0xb7>
  800331:	48 b8 aa 4a 80 00 00 	movabs $0x804aaa,%rax
  800338:	00 00 00 
  80033b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80033f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800343:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800347:	48 89 c6             	mov    %rax,%rsi
  80034a:	48 bf ab 4a 80 00 00 	movabs $0x804aab,%rdi
  800351:	00 00 00 
  800354:	b8 00 00 00 00       	mov    $0x0,%eax
  800359:	48 b9 1c 36 80 00 00 	movabs $0x80361c,%rcx
  800360:	00 00 00 
  800363:	ff d1                	callq  *%rcx
  800365:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800369:	48 89 c6             	mov    %rax,%rsi
  80036c:	48 bf b0 4a 80 00 00 	movabs $0x804ab0,%rdi
  800373:	00 00 00 
  800376:	b8 00 00 00 00       	mov    $0x0,%eax
  80037b:	48 ba 1c 36 80 00 00 	movabs $0x80361c,%rdx
  800382:	00 00 00 
  800385:	ff d2                	callq  *%rdx
  800387:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  80038e:	00 00 00 
  800391:	8b 80 18 01 00 00    	mov    0x118(%rax),%eax
  800397:	85 c0                	test   %eax,%eax
  800399:	74 21                	je     8003bc <ls1+0x134>
  80039b:	80 7d e4 00          	cmpb   $0x0,-0x1c(%rbp)
  80039f:	74 1b                	je     8003bc <ls1+0x134>
  8003a1:	48 bf a8 4a 80 00 00 	movabs $0x804aa8,%rdi
  8003a8:	00 00 00 
  8003ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8003b0:	48 ba 1c 36 80 00 00 	movabs $0x80361c,%rdx
  8003b7:	00 00 00 
  8003ba:	ff d2                	callq  *%rdx
  8003bc:	48 bf b3 4a 80 00 00 	movabs $0x804ab3,%rdi
  8003c3:	00 00 00 
  8003c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8003cb:	48 ba 1c 36 80 00 00 	movabs $0x80361c,%rdx
  8003d2:	00 00 00 
  8003d5:	ff d2                	callq  *%rdx
  8003d7:	c9                   	leaveq 
  8003d8:	c3                   	retq   

00000000008003d9 <usage>:
  8003d9:	55                   	push   %rbp
  8003da:	48 89 e5             	mov    %rsp,%rbp
  8003dd:	48 bf b5 4a 80 00 00 	movabs $0x804ab5,%rdi
  8003e4:	00 00 00 
  8003e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8003ec:	48 ba 1c 36 80 00 00 	movabs $0x80361c,%rdx
  8003f3:	00 00 00 
  8003f6:	ff d2                	callq  *%rdx
  8003f8:	48 b8 9e 05 80 00 00 	movabs $0x80059e,%rax
  8003ff:	00 00 00 
  800402:	ff d0                	callq  *%rax
  800404:	5d                   	pop    %rbp
  800405:	c3                   	retq   

0000000000800406 <umain>:
  800406:	55                   	push   %rbp
  800407:	48 89 e5             	mov    %rsp,%rbp
  80040a:	48 83 ec 40          	sub    $0x40,%rsp
  80040e:	89 7d cc             	mov    %edi,-0x34(%rbp)
  800411:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800415:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
  800419:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  80041d:	48 8d 45 cc          	lea    -0x34(%rbp),%rax
  800421:	48 89 ce             	mov    %rcx,%rsi
  800424:	48 89 c7             	mov    %rax,%rdi
  800427:	48 b8 be 20 80 00 00 	movabs $0x8020be,%rax
  80042e:	00 00 00 
  800431:	ff d0                	callq  *%rax
  800433:	eb 49                	jmp    80047e <umain+0x78>
  800435:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800438:	83 f8 64             	cmp    $0x64,%eax
  80043b:	74 0a                	je     800447 <umain+0x41>
  80043d:	83 f8 6c             	cmp    $0x6c,%eax
  800440:	74 05                	je     800447 <umain+0x41>
  800442:	83 f8 46             	cmp    $0x46,%eax
  800445:	75 2b                	jne    800472 <umain+0x6c>
  800447:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  80044e:	00 00 00 
  800451:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800454:	48 63 d2             	movslq %edx,%rdx
  800457:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  80045a:	8d 48 01             	lea    0x1(%rax),%ecx
  80045d:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  800464:	00 00 00 
  800467:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80046a:	48 63 d2             	movslq %edx,%rdx
  80046d:	89 0c 90             	mov    %ecx,(%rax,%rdx,4)
  800470:	eb 0c                	jmp    80047e <umain+0x78>
  800472:	48 b8 d9 03 80 00 00 	movabs $0x8003d9,%rax
  800479:	00 00 00 
  80047c:	ff d0                	callq  *%rax
  80047e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800482:	48 89 c7             	mov    %rax,%rdi
  800485:	48 b8 22 21 80 00 00 	movabs $0x802122,%rax
  80048c:	00 00 00 
  80048f:	ff d0                	callq  *%rax
  800491:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800494:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800498:	79 9b                	jns    800435 <umain+0x2f>
  80049a:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80049d:	83 f8 01             	cmp    $0x1,%eax
  8004a0:	75 22                	jne    8004c4 <umain+0xbe>
  8004a2:	48 be aa 4a 80 00 00 	movabs $0x804aaa,%rsi
  8004a9:	00 00 00 
  8004ac:	48 bf a8 4a 80 00 00 	movabs $0x804aa8,%rdi
  8004b3:	00 00 00 
  8004b6:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8004bd:	00 00 00 
  8004c0:	ff d0                	callq  *%rax
  8004c2:	eb 55                	jmp    800519 <umain+0x113>
  8004c4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8004cb:	eb 44                	jmp    800511 <umain+0x10b>
  8004cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8004d0:	48 98                	cltq   
  8004d2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8004d9:	00 
  8004da:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8004de:	48 01 d0             	add    %rdx,%rax
  8004e1:	48 8b 10             	mov    (%rax),%rdx
  8004e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8004e7:	48 98                	cltq   
  8004e9:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
  8004f0:	00 
  8004f1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8004f5:	48 01 c8             	add    %rcx,%rax
  8004f8:	48 8b 00             	mov    (%rax),%rax
  8004fb:	48 89 d6             	mov    %rdx,%rsi
  8004fe:	48 89 c7             	mov    %rax,%rdi
  800501:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800508:	00 00 00 
  80050b:	ff d0                	callq  *%rax
  80050d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800511:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800514:	39 45 fc             	cmp    %eax,-0x4(%rbp)
  800517:	7c b4                	jl     8004cd <umain+0xc7>
  800519:	c9                   	leaveq 
  80051a:	c3                   	retq   

000000000080051b <libmain>:
  80051b:	55                   	push   %rbp
  80051c:	48 89 e5             	mov    %rsp,%rbp
  80051f:	48 83 ec 10          	sub    $0x10,%rsp
  800523:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800526:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80052a:	48 b8 62 1c 80 00 00 	movabs $0x801c62,%rax
  800531:	00 00 00 
  800534:	ff d0                	callq  *%rax
  800536:	25 ff 03 00 00       	and    $0x3ff,%eax
  80053b:	48 98                	cltq   
  80053d:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800544:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80054b:	00 00 00 
  80054e:	48 01 c2             	add    %rax,%rdx
  800551:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  800558:	00 00 00 
  80055b:	48 89 10             	mov    %rdx,(%rax)
  80055e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800562:	7e 14                	jle    800578 <libmain+0x5d>
  800564:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800568:	48 8b 10             	mov    (%rax),%rdx
  80056b:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800572:	00 00 00 
  800575:	48 89 10             	mov    %rdx,(%rax)
  800578:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80057c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80057f:	48 89 d6             	mov    %rdx,%rsi
  800582:	89 c7                	mov    %eax,%edi
  800584:	48 b8 06 04 80 00 00 	movabs $0x800406,%rax
  80058b:	00 00 00 
  80058e:	ff d0                	callq  *%rax
  800590:	48 b8 9e 05 80 00 00 	movabs $0x80059e,%rax
  800597:	00 00 00 
  80059a:	ff d0                	callq  *%rax
  80059c:	c9                   	leaveq 
  80059d:	c3                   	retq   

000000000080059e <exit>:
  80059e:	55                   	push   %rbp
  80059f:	48 89 e5             	mov    %rsp,%rbp
  8005a2:	48 b8 e4 26 80 00 00 	movabs $0x8026e4,%rax
  8005a9:	00 00 00 
  8005ac:	ff d0                	callq  *%rax
  8005ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8005b3:	48 b8 1e 1c 80 00 00 	movabs $0x801c1e,%rax
  8005ba:	00 00 00 
  8005bd:	ff d0                	callq  *%rax
  8005bf:	5d                   	pop    %rbp
  8005c0:	c3                   	retq   

00000000008005c1 <_panic>:
  8005c1:	55                   	push   %rbp
  8005c2:	48 89 e5             	mov    %rsp,%rbp
  8005c5:	53                   	push   %rbx
  8005c6:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8005cd:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8005d4:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8005da:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8005e1:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8005e8:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8005ef:	84 c0                	test   %al,%al
  8005f1:	74 23                	je     800616 <_panic+0x55>
  8005f3:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8005fa:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8005fe:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800602:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800606:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  80060a:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80060e:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800612:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800616:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80061d:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800624:	00 00 00 
  800627:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80062e:	00 00 00 
  800631:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800635:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  80063c:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800643:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80064a:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800651:	00 00 00 
  800654:	48 8b 18             	mov    (%rax),%rbx
  800657:	48 b8 62 1c 80 00 00 	movabs $0x801c62,%rax
  80065e:	00 00 00 
  800661:	ff d0                	callq  *%rax
  800663:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800669:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800670:	41 89 c8             	mov    %ecx,%r8d
  800673:	48 89 d1             	mov    %rdx,%rcx
  800676:	48 89 da             	mov    %rbx,%rdx
  800679:	89 c6                	mov    %eax,%esi
  80067b:	48 bf e0 4a 80 00 00 	movabs $0x804ae0,%rdi
  800682:	00 00 00 
  800685:	b8 00 00 00 00       	mov    $0x0,%eax
  80068a:	49 b9 fa 07 80 00 00 	movabs $0x8007fa,%r9
  800691:	00 00 00 
  800694:	41 ff d1             	callq  *%r9
  800697:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  80069e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8006a5:	48 89 d6             	mov    %rdx,%rsi
  8006a8:	48 89 c7             	mov    %rax,%rdi
  8006ab:	48 b8 4e 07 80 00 00 	movabs $0x80074e,%rax
  8006b2:	00 00 00 
  8006b5:	ff d0                	callq  *%rax
  8006b7:	48 bf 03 4b 80 00 00 	movabs $0x804b03,%rdi
  8006be:	00 00 00 
  8006c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8006c6:	48 ba fa 07 80 00 00 	movabs $0x8007fa,%rdx
  8006cd:	00 00 00 
  8006d0:	ff d2                	callq  *%rdx
  8006d2:	cc                   	int3   
  8006d3:	eb fd                	jmp    8006d2 <_panic+0x111>

00000000008006d5 <putch>:
  8006d5:	55                   	push   %rbp
  8006d6:	48 89 e5             	mov    %rsp,%rbp
  8006d9:	48 83 ec 10          	sub    $0x10,%rsp
  8006dd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8006e0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8006e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8006e8:	8b 00                	mov    (%rax),%eax
  8006ea:	8d 48 01             	lea    0x1(%rax),%ecx
  8006ed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8006f1:	89 0a                	mov    %ecx,(%rdx)
  8006f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8006f6:	89 d1                	mov    %edx,%ecx
  8006f8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8006fc:	48 98                	cltq   
  8006fe:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800702:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800706:	8b 00                	mov    (%rax),%eax
  800708:	3d ff 00 00 00       	cmp    $0xff,%eax
  80070d:	75 2c                	jne    80073b <putch+0x66>
  80070f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800713:	8b 00                	mov    (%rax),%eax
  800715:	48 98                	cltq   
  800717:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80071b:	48 83 c2 08          	add    $0x8,%rdx
  80071f:	48 89 c6             	mov    %rax,%rsi
  800722:	48 89 d7             	mov    %rdx,%rdi
  800725:	48 b8 96 1b 80 00 00 	movabs $0x801b96,%rax
  80072c:	00 00 00 
  80072f:	ff d0                	callq  *%rax
  800731:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800735:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80073b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80073f:	8b 40 04             	mov    0x4(%rax),%eax
  800742:	8d 50 01             	lea    0x1(%rax),%edx
  800745:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800749:	89 50 04             	mov    %edx,0x4(%rax)
  80074c:	c9                   	leaveq 
  80074d:	c3                   	retq   

000000000080074e <vcprintf>:
  80074e:	55                   	push   %rbp
  80074f:	48 89 e5             	mov    %rsp,%rbp
  800752:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800759:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800760:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800767:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  80076e:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800775:	48 8b 0a             	mov    (%rdx),%rcx
  800778:	48 89 08             	mov    %rcx,(%rax)
  80077b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80077f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800783:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800787:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80078b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800792:	00 00 00 
  800795:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80079c:	00 00 00 
  80079f:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8007a6:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8007ad:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8007b4:	48 89 c6             	mov    %rax,%rsi
  8007b7:	48 bf d5 06 80 00 00 	movabs $0x8006d5,%rdi
  8007be:	00 00 00 
  8007c1:	48 b8 ad 0b 80 00 00 	movabs $0x800bad,%rax
  8007c8:	00 00 00 
  8007cb:	ff d0                	callq  *%rax
  8007cd:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8007d3:	48 98                	cltq   
  8007d5:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8007dc:	48 83 c2 08          	add    $0x8,%rdx
  8007e0:	48 89 c6             	mov    %rax,%rsi
  8007e3:	48 89 d7             	mov    %rdx,%rdi
  8007e6:	48 b8 96 1b 80 00 00 	movabs $0x801b96,%rax
  8007ed:	00 00 00 
  8007f0:	ff d0                	callq  *%rax
  8007f2:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8007f8:	c9                   	leaveq 
  8007f9:	c3                   	retq   

00000000008007fa <cprintf>:
  8007fa:	55                   	push   %rbp
  8007fb:	48 89 e5             	mov    %rsp,%rbp
  8007fe:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800805:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80080c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800813:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80081a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800821:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800828:	84 c0                	test   %al,%al
  80082a:	74 20                	je     80084c <cprintf+0x52>
  80082c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800830:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800834:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800838:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80083c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800840:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800844:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800848:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80084c:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800853:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80085a:	00 00 00 
  80085d:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800864:	00 00 00 
  800867:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80086b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800872:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800879:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800880:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800887:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80088e:	48 8b 0a             	mov    (%rdx),%rcx
  800891:	48 89 08             	mov    %rcx,(%rax)
  800894:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800898:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80089c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8008a0:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8008a4:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8008ab:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8008b2:	48 89 d6             	mov    %rdx,%rsi
  8008b5:	48 89 c7             	mov    %rax,%rdi
  8008b8:	48 b8 4e 07 80 00 00 	movabs $0x80074e,%rax
  8008bf:	00 00 00 
  8008c2:	ff d0                	callq  *%rax
  8008c4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8008ca:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8008d0:	c9                   	leaveq 
  8008d1:	c3                   	retq   

00000000008008d2 <printnum>:
  8008d2:	55                   	push   %rbp
  8008d3:	48 89 e5             	mov    %rsp,%rbp
  8008d6:	53                   	push   %rbx
  8008d7:	48 83 ec 38          	sub    $0x38,%rsp
  8008db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8008df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8008e3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8008e7:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8008ea:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8008ee:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8008f2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8008f5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8008f9:	77 3b                	ja     800936 <printnum+0x64>
  8008fb:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8008fe:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800902:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800905:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800909:	ba 00 00 00 00       	mov    $0x0,%edx
  80090e:	48 f7 f3             	div    %rbx
  800911:	48 89 c2             	mov    %rax,%rdx
  800914:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800917:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80091a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80091e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800922:	41 89 f9             	mov    %edi,%r9d
  800925:	48 89 c7             	mov    %rax,%rdi
  800928:	48 b8 d2 08 80 00 00 	movabs $0x8008d2,%rax
  80092f:	00 00 00 
  800932:	ff d0                	callq  *%rax
  800934:	eb 1e                	jmp    800954 <printnum+0x82>
  800936:	eb 12                	jmp    80094a <printnum+0x78>
  800938:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80093c:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80093f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800943:	48 89 ce             	mov    %rcx,%rsi
  800946:	89 d7                	mov    %edx,%edi
  800948:	ff d0                	callq  *%rax
  80094a:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80094e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800952:	7f e4                	jg     800938 <printnum+0x66>
  800954:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800957:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80095b:	ba 00 00 00 00       	mov    $0x0,%edx
  800960:	48 f7 f1             	div    %rcx
  800963:	48 89 d0             	mov    %rdx,%rax
  800966:	48 ba 10 4d 80 00 00 	movabs $0x804d10,%rdx
  80096d:	00 00 00 
  800970:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800974:	0f be d0             	movsbl %al,%edx
  800977:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80097b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80097f:	48 89 ce             	mov    %rcx,%rsi
  800982:	89 d7                	mov    %edx,%edi
  800984:	ff d0                	callq  *%rax
  800986:	48 83 c4 38          	add    $0x38,%rsp
  80098a:	5b                   	pop    %rbx
  80098b:	5d                   	pop    %rbp
  80098c:	c3                   	retq   

000000000080098d <getuint>:
  80098d:	55                   	push   %rbp
  80098e:	48 89 e5             	mov    %rsp,%rbp
  800991:	48 83 ec 1c          	sub    $0x1c,%rsp
  800995:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800999:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80099c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8009a0:	7e 52                	jle    8009f4 <getuint+0x67>
  8009a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009a6:	8b 00                	mov    (%rax),%eax
  8009a8:	83 f8 30             	cmp    $0x30,%eax
  8009ab:	73 24                	jae    8009d1 <getuint+0x44>
  8009ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b9:	8b 00                	mov    (%rax),%eax
  8009bb:	89 c0                	mov    %eax,%eax
  8009bd:	48 01 d0             	add    %rdx,%rax
  8009c0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009c4:	8b 12                	mov    (%rdx),%edx
  8009c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009c9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009cd:	89 0a                	mov    %ecx,(%rdx)
  8009cf:	eb 17                	jmp    8009e8 <getuint+0x5b>
  8009d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009d5:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009d9:	48 89 d0             	mov    %rdx,%rax
  8009dc:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009e0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009e8:	48 8b 00             	mov    (%rax),%rax
  8009eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009ef:	e9 a3 00 00 00       	jmpq   800a97 <getuint+0x10a>
  8009f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8009f8:	74 4f                	je     800a49 <getuint+0xbc>
  8009fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009fe:	8b 00                	mov    (%rax),%eax
  800a00:	83 f8 30             	cmp    $0x30,%eax
  800a03:	73 24                	jae    800a29 <getuint+0x9c>
  800a05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a09:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a11:	8b 00                	mov    (%rax),%eax
  800a13:	89 c0                	mov    %eax,%eax
  800a15:	48 01 d0             	add    %rdx,%rax
  800a18:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a1c:	8b 12                	mov    (%rdx),%edx
  800a1e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a21:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a25:	89 0a                	mov    %ecx,(%rdx)
  800a27:	eb 17                	jmp    800a40 <getuint+0xb3>
  800a29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a2d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a31:	48 89 d0             	mov    %rdx,%rax
  800a34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a38:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a3c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a40:	48 8b 00             	mov    (%rax),%rax
  800a43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a47:	eb 4e                	jmp    800a97 <getuint+0x10a>
  800a49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a4d:	8b 00                	mov    (%rax),%eax
  800a4f:	83 f8 30             	cmp    $0x30,%eax
  800a52:	73 24                	jae    800a78 <getuint+0xeb>
  800a54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a58:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a60:	8b 00                	mov    (%rax),%eax
  800a62:	89 c0                	mov    %eax,%eax
  800a64:	48 01 d0             	add    %rdx,%rax
  800a67:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a6b:	8b 12                	mov    (%rdx),%edx
  800a6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a70:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a74:	89 0a                	mov    %ecx,(%rdx)
  800a76:	eb 17                	jmp    800a8f <getuint+0x102>
  800a78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a7c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a80:	48 89 d0             	mov    %rdx,%rax
  800a83:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a87:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a8f:	8b 00                	mov    (%rax),%eax
  800a91:	89 c0                	mov    %eax,%eax
  800a93:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800a9b:	c9                   	leaveq 
  800a9c:	c3                   	retq   

0000000000800a9d <getint>:
  800a9d:	55                   	push   %rbp
  800a9e:	48 89 e5             	mov    %rsp,%rbp
  800aa1:	48 83 ec 1c          	sub    $0x1c,%rsp
  800aa5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800aa9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800aac:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800ab0:	7e 52                	jle    800b04 <getint+0x67>
  800ab2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ab6:	8b 00                	mov    (%rax),%eax
  800ab8:	83 f8 30             	cmp    $0x30,%eax
  800abb:	73 24                	jae    800ae1 <getint+0x44>
  800abd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ac1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800ac5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ac9:	8b 00                	mov    (%rax),%eax
  800acb:	89 c0                	mov    %eax,%eax
  800acd:	48 01 d0             	add    %rdx,%rax
  800ad0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ad4:	8b 12                	mov    (%rdx),%edx
  800ad6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800ad9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800add:	89 0a                	mov    %ecx,(%rdx)
  800adf:	eb 17                	jmp    800af8 <getint+0x5b>
  800ae1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ae5:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800ae9:	48 89 d0             	mov    %rdx,%rax
  800aec:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800af0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800af4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800af8:	48 8b 00             	mov    (%rax),%rax
  800afb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800aff:	e9 a3 00 00 00       	jmpq   800ba7 <getint+0x10a>
  800b04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800b08:	74 4f                	je     800b59 <getint+0xbc>
  800b0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b0e:	8b 00                	mov    (%rax),%eax
  800b10:	83 f8 30             	cmp    $0x30,%eax
  800b13:	73 24                	jae    800b39 <getint+0x9c>
  800b15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b19:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b21:	8b 00                	mov    (%rax),%eax
  800b23:	89 c0                	mov    %eax,%eax
  800b25:	48 01 d0             	add    %rdx,%rax
  800b28:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b2c:	8b 12                	mov    (%rdx),%edx
  800b2e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800b31:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b35:	89 0a                	mov    %ecx,(%rdx)
  800b37:	eb 17                	jmp    800b50 <getint+0xb3>
  800b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b3d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b41:	48 89 d0             	mov    %rdx,%rax
  800b44:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b48:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b4c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b50:	48 8b 00             	mov    (%rax),%rax
  800b53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b57:	eb 4e                	jmp    800ba7 <getint+0x10a>
  800b59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b5d:	8b 00                	mov    (%rax),%eax
  800b5f:	83 f8 30             	cmp    $0x30,%eax
  800b62:	73 24                	jae    800b88 <getint+0xeb>
  800b64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b68:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b70:	8b 00                	mov    (%rax),%eax
  800b72:	89 c0                	mov    %eax,%eax
  800b74:	48 01 d0             	add    %rdx,%rax
  800b77:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b7b:	8b 12                	mov    (%rdx),%edx
  800b7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800b80:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b84:	89 0a                	mov    %ecx,(%rdx)
  800b86:	eb 17                	jmp    800b9f <getint+0x102>
  800b88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b8c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b90:	48 89 d0             	mov    %rdx,%rax
  800b93:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b97:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b9b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b9f:	8b 00                	mov    (%rax),%eax
  800ba1:	48 98                	cltq   
  800ba3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800ba7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800bab:	c9                   	leaveq 
  800bac:	c3                   	retq   

0000000000800bad <vprintfmt>:
  800bad:	55                   	push   %rbp
  800bae:	48 89 e5             	mov    %rsp,%rbp
  800bb1:	41 54                	push   %r12
  800bb3:	53                   	push   %rbx
  800bb4:	48 83 ec 60          	sub    $0x60,%rsp
  800bb8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800bbc:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800bc0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800bc4:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800bc8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800bcc:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800bd0:	48 8b 0a             	mov    (%rdx),%rcx
  800bd3:	48 89 08             	mov    %rcx,(%rax)
  800bd6:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800bda:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800bde:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800be2:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800be6:	eb 17                	jmp    800bff <vprintfmt+0x52>
  800be8:	85 db                	test   %ebx,%ebx
  800bea:	0f 84 cc 04 00 00    	je     8010bc <vprintfmt+0x50f>
  800bf0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bf4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bf8:	48 89 d6             	mov    %rdx,%rsi
  800bfb:	89 df                	mov    %ebx,%edi
  800bfd:	ff d0                	callq  *%rax
  800bff:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c03:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800c07:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c0b:	0f b6 00             	movzbl (%rax),%eax
  800c0e:	0f b6 d8             	movzbl %al,%ebx
  800c11:	83 fb 25             	cmp    $0x25,%ebx
  800c14:	75 d2                	jne    800be8 <vprintfmt+0x3b>
  800c16:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800c1a:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800c21:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800c28:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800c2f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800c36:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c3a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800c3e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c42:	0f b6 00             	movzbl (%rax),%eax
  800c45:	0f b6 d8             	movzbl %al,%ebx
  800c48:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800c4b:	83 f8 55             	cmp    $0x55,%eax
  800c4e:	0f 87 34 04 00 00    	ja     801088 <vprintfmt+0x4db>
  800c54:	89 c0                	mov    %eax,%eax
  800c56:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800c5d:	00 
  800c5e:	48 b8 38 4d 80 00 00 	movabs $0x804d38,%rax
  800c65:	00 00 00 
  800c68:	48 01 d0             	add    %rdx,%rax
  800c6b:	48 8b 00             	mov    (%rax),%rax
  800c6e:	ff e0                	jmpq   *%rax
  800c70:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800c74:	eb c0                	jmp    800c36 <vprintfmt+0x89>
  800c76:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800c7a:	eb ba                	jmp    800c36 <vprintfmt+0x89>
  800c7c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800c83:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800c86:	89 d0                	mov    %edx,%eax
  800c88:	c1 e0 02             	shl    $0x2,%eax
  800c8b:	01 d0                	add    %edx,%eax
  800c8d:	01 c0                	add    %eax,%eax
  800c8f:	01 d8                	add    %ebx,%eax
  800c91:	83 e8 30             	sub    $0x30,%eax
  800c94:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800c97:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c9b:	0f b6 00             	movzbl (%rax),%eax
  800c9e:	0f be d8             	movsbl %al,%ebx
  800ca1:	83 fb 2f             	cmp    $0x2f,%ebx
  800ca4:	7e 0c                	jle    800cb2 <vprintfmt+0x105>
  800ca6:	83 fb 39             	cmp    $0x39,%ebx
  800ca9:	7f 07                	jg     800cb2 <vprintfmt+0x105>
  800cab:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800cb0:	eb d1                	jmp    800c83 <vprintfmt+0xd6>
  800cb2:	eb 58                	jmp    800d0c <vprintfmt+0x15f>
  800cb4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cb7:	83 f8 30             	cmp    $0x30,%eax
  800cba:	73 17                	jae    800cd3 <vprintfmt+0x126>
  800cbc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800cc0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cc3:	89 c0                	mov    %eax,%eax
  800cc5:	48 01 d0             	add    %rdx,%rax
  800cc8:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ccb:	83 c2 08             	add    $0x8,%edx
  800cce:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800cd1:	eb 0f                	jmp    800ce2 <vprintfmt+0x135>
  800cd3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800cd7:	48 89 d0             	mov    %rdx,%rax
  800cda:	48 83 c2 08          	add    $0x8,%rdx
  800cde:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800ce2:	8b 00                	mov    (%rax),%eax
  800ce4:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800ce7:	eb 23                	jmp    800d0c <vprintfmt+0x15f>
  800ce9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800ced:	79 0c                	jns    800cfb <vprintfmt+0x14e>
  800cef:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800cf6:	e9 3b ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800cfb:	e9 36 ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800d00:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800d07:	e9 2a ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800d0c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d10:	79 12                	jns    800d24 <vprintfmt+0x177>
  800d12:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800d15:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800d18:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800d1f:	e9 12 ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800d24:	e9 0d ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800d29:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800d2d:	e9 04 ff ff ff       	jmpq   800c36 <vprintfmt+0x89>
  800d32:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d35:	83 f8 30             	cmp    $0x30,%eax
  800d38:	73 17                	jae    800d51 <vprintfmt+0x1a4>
  800d3a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d3e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d41:	89 c0                	mov    %eax,%eax
  800d43:	48 01 d0             	add    %rdx,%rax
  800d46:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d49:	83 c2 08             	add    $0x8,%edx
  800d4c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d4f:	eb 0f                	jmp    800d60 <vprintfmt+0x1b3>
  800d51:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d55:	48 89 d0             	mov    %rdx,%rax
  800d58:	48 83 c2 08          	add    $0x8,%rdx
  800d5c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d60:	8b 10                	mov    (%rax),%edx
  800d62:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800d66:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d6a:	48 89 ce             	mov    %rcx,%rsi
  800d6d:	89 d7                	mov    %edx,%edi
  800d6f:	ff d0                	callq  *%rax
  800d71:	e9 40 03 00 00       	jmpq   8010b6 <vprintfmt+0x509>
  800d76:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d79:	83 f8 30             	cmp    $0x30,%eax
  800d7c:	73 17                	jae    800d95 <vprintfmt+0x1e8>
  800d7e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d82:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d85:	89 c0                	mov    %eax,%eax
  800d87:	48 01 d0             	add    %rdx,%rax
  800d8a:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d8d:	83 c2 08             	add    $0x8,%edx
  800d90:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d93:	eb 0f                	jmp    800da4 <vprintfmt+0x1f7>
  800d95:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d99:	48 89 d0             	mov    %rdx,%rax
  800d9c:	48 83 c2 08          	add    $0x8,%rdx
  800da0:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800da4:	8b 18                	mov    (%rax),%ebx
  800da6:	85 db                	test   %ebx,%ebx
  800da8:	79 02                	jns    800dac <vprintfmt+0x1ff>
  800daa:	f7 db                	neg    %ebx
  800dac:	83 fb 15             	cmp    $0x15,%ebx
  800daf:	7f 16                	jg     800dc7 <vprintfmt+0x21a>
  800db1:	48 b8 60 4c 80 00 00 	movabs $0x804c60,%rax
  800db8:	00 00 00 
  800dbb:	48 63 d3             	movslq %ebx,%rdx
  800dbe:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800dc2:	4d 85 e4             	test   %r12,%r12
  800dc5:	75 2e                	jne    800df5 <vprintfmt+0x248>
  800dc7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800dcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dcf:	89 d9                	mov    %ebx,%ecx
  800dd1:	48 ba 21 4d 80 00 00 	movabs $0x804d21,%rdx
  800dd8:	00 00 00 
  800ddb:	48 89 c7             	mov    %rax,%rdi
  800dde:	b8 00 00 00 00       	mov    $0x0,%eax
  800de3:	49 b8 c5 10 80 00 00 	movabs $0x8010c5,%r8
  800dea:	00 00 00 
  800ded:	41 ff d0             	callq  *%r8
  800df0:	e9 c1 02 00 00       	jmpq   8010b6 <vprintfmt+0x509>
  800df5:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800df9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dfd:	4c 89 e1             	mov    %r12,%rcx
  800e00:	48 ba 2a 4d 80 00 00 	movabs $0x804d2a,%rdx
  800e07:	00 00 00 
  800e0a:	48 89 c7             	mov    %rax,%rdi
  800e0d:	b8 00 00 00 00       	mov    $0x0,%eax
  800e12:	49 b8 c5 10 80 00 00 	movabs $0x8010c5,%r8
  800e19:	00 00 00 
  800e1c:	41 ff d0             	callq  *%r8
  800e1f:	e9 92 02 00 00       	jmpq   8010b6 <vprintfmt+0x509>
  800e24:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e27:	83 f8 30             	cmp    $0x30,%eax
  800e2a:	73 17                	jae    800e43 <vprintfmt+0x296>
  800e2c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e30:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e33:	89 c0                	mov    %eax,%eax
  800e35:	48 01 d0             	add    %rdx,%rax
  800e38:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e3b:	83 c2 08             	add    $0x8,%edx
  800e3e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e41:	eb 0f                	jmp    800e52 <vprintfmt+0x2a5>
  800e43:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e47:	48 89 d0             	mov    %rdx,%rax
  800e4a:	48 83 c2 08          	add    $0x8,%rdx
  800e4e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e52:	4c 8b 20             	mov    (%rax),%r12
  800e55:	4d 85 e4             	test   %r12,%r12
  800e58:	75 0a                	jne    800e64 <vprintfmt+0x2b7>
  800e5a:	49 bc 2d 4d 80 00 00 	movabs $0x804d2d,%r12
  800e61:	00 00 00 
  800e64:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e68:	7e 3f                	jle    800ea9 <vprintfmt+0x2fc>
  800e6a:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800e6e:	74 39                	je     800ea9 <vprintfmt+0x2fc>
  800e70:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800e73:	48 98                	cltq   
  800e75:	48 89 c6             	mov    %rax,%rsi
  800e78:	4c 89 e7             	mov    %r12,%rdi
  800e7b:	48 b8 71 13 80 00 00 	movabs $0x801371,%rax
  800e82:	00 00 00 
  800e85:	ff d0                	callq  *%rax
  800e87:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800e8a:	eb 17                	jmp    800ea3 <vprintfmt+0x2f6>
  800e8c:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800e90:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800e94:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e98:	48 89 ce             	mov    %rcx,%rsi
  800e9b:	89 d7                	mov    %edx,%edi
  800e9d:	ff d0                	callq  *%rax
  800e9f:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ea3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800ea7:	7f e3                	jg     800e8c <vprintfmt+0x2df>
  800ea9:	eb 37                	jmp    800ee2 <vprintfmt+0x335>
  800eab:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800eaf:	74 1e                	je     800ecf <vprintfmt+0x322>
  800eb1:	83 fb 1f             	cmp    $0x1f,%ebx
  800eb4:	7e 05                	jle    800ebb <vprintfmt+0x30e>
  800eb6:	83 fb 7e             	cmp    $0x7e,%ebx
  800eb9:	7e 14                	jle    800ecf <vprintfmt+0x322>
  800ebb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ebf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ec3:	48 89 d6             	mov    %rdx,%rsi
  800ec6:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800ecb:	ff d0                	callq  *%rax
  800ecd:	eb 0f                	jmp    800ede <vprintfmt+0x331>
  800ecf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ed3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ed7:	48 89 d6             	mov    %rdx,%rsi
  800eda:	89 df                	mov    %ebx,%edi
  800edc:	ff d0                	callq  *%rax
  800ede:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ee2:	4c 89 e0             	mov    %r12,%rax
  800ee5:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800ee9:	0f b6 00             	movzbl (%rax),%eax
  800eec:	0f be d8             	movsbl %al,%ebx
  800eef:	85 db                	test   %ebx,%ebx
  800ef1:	74 10                	je     800f03 <vprintfmt+0x356>
  800ef3:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800ef7:	78 b2                	js     800eab <vprintfmt+0x2fe>
  800ef9:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800efd:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800f01:	79 a8                	jns    800eab <vprintfmt+0x2fe>
  800f03:	eb 16                	jmp    800f1b <vprintfmt+0x36e>
  800f05:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f09:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f0d:	48 89 d6             	mov    %rdx,%rsi
  800f10:	bf 20 00 00 00       	mov    $0x20,%edi
  800f15:	ff d0                	callq  *%rax
  800f17:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f1b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800f1f:	7f e4                	jg     800f05 <vprintfmt+0x358>
  800f21:	e9 90 01 00 00       	jmpq   8010b6 <vprintfmt+0x509>
  800f26:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f2a:	be 03 00 00 00       	mov    $0x3,%esi
  800f2f:	48 89 c7             	mov    %rax,%rdi
  800f32:	48 b8 9d 0a 80 00 00 	movabs $0x800a9d,%rax
  800f39:	00 00 00 
  800f3c:	ff d0                	callq  *%rax
  800f3e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f46:	48 85 c0             	test   %rax,%rax
  800f49:	79 1d                	jns    800f68 <vprintfmt+0x3bb>
  800f4b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f4f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f53:	48 89 d6             	mov    %rdx,%rsi
  800f56:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800f5b:	ff d0                	callq  *%rax
  800f5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f61:	48 f7 d8             	neg    %rax
  800f64:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f68:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800f6f:	e9 d5 00 00 00       	jmpq   801049 <vprintfmt+0x49c>
  800f74:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f78:	be 03 00 00 00       	mov    $0x3,%esi
  800f7d:	48 89 c7             	mov    %rax,%rdi
  800f80:	48 b8 8d 09 80 00 00 	movabs $0x80098d,%rax
  800f87:	00 00 00 
  800f8a:	ff d0                	callq  *%rax
  800f8c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f90:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800f97:	e9 ad 00 00 00       	jmpq   801049 <vprintfmt+0x49c>
  800f9c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800fa0:	be 03 00 00 00       	mov    $0x3,%esi
  800fa5:	48 89 c7             	mov    %rax,%rdi
  800fa8:	48 b8 8d 09 80 00 00 	movabs $0x80098d,%rax
  800faf:	00 00 00 
  800fb2:	ff d0                	callq  *%rax
  800fb4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800fb8:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800fbf:	e9 85 00 00 00       	jmpq   801049 <vprintfmt+0x49c>
  800fc4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fc8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fcc:	48 89 d6             	mov    %rdx,%rsi
  800fcf:	bf 30 00 00 00       	mov    $0x30,%edi
  800fd4:	ff d0                	callq  *%rax
  800fd6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fda:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fde:	48 89 d6             	mov    %rdx,%rsi
  800fe1:	bf 78 00 00 00       	mov    $0x78,%edi
  800fe6:	ff d0                	callq  *%rax
  800fe8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800feb:	83 f8 30             	cmp    $0x30,%eax
  800fee:	73 17                	jae    801007 <vprintfmt+0x45a>
  800ff0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ff4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ff7:	89 c0                	mov    %eax,%eax
  800ff9:	48 01 d0             	add    %rdx,%rax
  800ffc:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800fff:	83 c2 08             	add    $0x8,%edx
  801002:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801005:	eb 0f                	jmp    801016 <vprintfmt+0x469>
  801007:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80100b:	48 89 d0             	mov    %rdx,%rax
  80100e:	48 83 c2 08          	add    $0x8,%rdx
  801012:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801016:	48 8b 00             	mov    (%rax),%rax
  801019:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80101d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801024:	eb 23                	jmp    801049 <vprintfmt+0x49c>
  801026:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80102a:	be 03 00 00 00       	mov    $0x3,%esi
  80102f:	48 89 c7             	mov    %rax,%rdi
  801032:	48 b8 8d 09 80 00 00 	movabs $0x80098d,%rax
  801039:	00 00 00 
  80103c:	ff d0                	callq  *%rax
  80103e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801042:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801049:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  80104e:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  801051:	8b 7d dc             	mov    -0x24(%rbp),%edi
  801054:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801058:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80105c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801060:	45 89 c1             	mov    %r8d,%r9d
  801063:	41 89 f8             	mov    %edi,%r8d
  801066:	48 89 c7             	mov    %rax,%rdi
  801069:	48 b8 d2 08 80 00 00 	movabs $0x8008d2,%rax
  801070:	00 00 00 
  801073:	ff d0                	callq  *%rax
  801075:	eb 3f                	jmp    8010b6 <vprintfmt+0x509>
  801077:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80107b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80107f:	48 89 d6             	mov    %rdx,%rsi
  801082:	89 df                	mov    %ebx,%edi
  801084:	ff d0                	callq  *%rax
  801086:	eb 2e                	jmp    8010b6 <vprintfmt+0x509>
  801088:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80108c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801090:	48 89 d6             	mov    %rdx,%rsi
  801093:	bf 25 00 00 00       	mov    $0x25,%edi
  801098:	ff d0                	callq  *%rax
  80109a:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80109f:	eb 05                	jmp    8010a6 <vprintfmt+0x4f9>
  8010a1:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8010a6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8010aa:	48 83 e8 01          	sub    $0x1,%rax
  8010ae:	0f b6 00             	movzbl (%rax),%eax
  8010b1:	3c 25                	cmp    $0x25,%al
  8010b3:	75 ec                	jne    8010a1 <vprintfmt+0x4f4>
  8010b5:	90                   	nop
  8010b6:	90                   	nop
  8010b7:	e9 43 fb ff ff       	jmpq   800bff <vprintfmt+0x52>
  8010bc:	48 83 c4 60          	add    $0x60,%rsp
  8010c0:	5b                   	pop    %rbx
  8010c1:	41 5c                	pop    %r12
  8010c3:	5d                   	pop    %rbp
  8010c4:	c3                   	retq   

00000000008010c5 <printfmt>:
  8010c5:	55                   	push   %rbp
  8010c6:	48 89 e5             	mov    %rsp,%rbp
  8010c9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  8010d0:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  8010d7:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  8010de:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8010e5:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8010ec:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8010f3:	84 c0                	test   %al,%al
  8010f5:	74 20                	je     801117 <printfmt+0x52>
  8010f7:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8010fb:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8010ff:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801103:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801107:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80110b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80110f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801113:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801117:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80111e:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801125:	00 00 00 
  801128:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  80112f:	00 00 00 
  801132:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801136:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80113d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801144:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80114b:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  801152:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  801159:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  801160:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  801167:	48 89 c7             	mov    %rax,%rdi
  80116a:	48 b8 ad 0b 80 00 00 	movabs $0x800bad,%rax
  801171:	00 00 00 
  801174:	ff d0                	callq  *%rax
  801176:	c9                   	leaveq 
  801177:	c3                   	retq   

0000000000801178 <sprintputch>:
  801178:	55                   	push   %rbp
  801179:	48 89 e5             	mov    %rsp,%rbp
  80117c:	48 83 ec 10          	sub    $0x10,%rsp
  801180:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801183:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801187:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80118b:	8b 40 10             	mov    0x10(%rax),%eax
  80118e:	8d 50 01             	lea    0x1(%rax),%edx
  801191:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801195:	89 50 10             	mov    %edx,0x10(%rax)
  801198:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80119c:	48 8b 10             	mov    (%rax),%rdx
  80119f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011a3:	48 8b 40 08          	mov    0x8(%rax),%rax
  8011a7:	48 39 c2             	cmp    %rax,%rdx
  8011aa:	73 17                	jae    8011c3 <sprintputch+0x4b>
  8011ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011b0:	48 8b 00             	mov    (%rax),%rax
  8011b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  8011b7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8011bb:	48 89 0a             	mov    %rcx,(%rdx)
  8011be:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8011c1:	88 10                	mov    %dl,(%rax)
  8011c3:	c9                   	leaveq 
  8011c4:	c3                   	retq   

00000000008011c5 <vsnprintf>:
  8011c5:	55                   	push   %rbp
  8011c6:	48 89 e5             	mov    %rsp,%rbp
  8011c9:	48 83 ec 50          	sub    $0x50,%rsp
  8011cd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8011d1:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  8011d4:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8011d8:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  8011dc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  8011e0:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  8011e4:	48 8b 0a             	mov    (%rdx),%rcx
  8011e7:	48 89 08             	mov    %rcx,(%rax)
  8011ea:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8011ee:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8011f2:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8011f6:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8011fa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8011fe:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801202:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801205:	48 98                	cltq   
  801207:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80120b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80120f:	48 01 d0             	add    %rdx,%rax
  801212:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801216:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80121d:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801222:	74 06                	je     80122a <vsnprintf+0x65>
  801224:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801228:	7f 07                	jg     801231 <vsnprintf+0x6c>
  80122a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80122f:	eb 2f                	jmp    801260 <vsnprintf+0x9b>
  801231:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801235:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801239:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80123d:	48 89 c6             	mov    %rax,%rsi
  801240:	48 bf 78 11 80 00 00 	movabs $0x801178,%rdi
  801247:	00 00 00 
  80124a:	48 b8 ad 0b 80 00 00 	movabs $0x800bad,%rax
  801251:	00 00 00 
  801254:	ff d0                	callq  *%rax
  801256:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80125a:	c6 00 00             	movb   $0x0,(%rax)
  80125d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801260:	c9                   	leaveq 
  801261:	c3                   	retq   

0000000000801262 <snprintf>:
  801262:	55                   	push   %rbp
  801263:	48 89 e5             	mov    %rsp,%rbp
  801266:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  80126d:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  801274:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  80127a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801281:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801288:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80128f:	84 c0                	test   %al,%al
  801291:	74 20                	je     8012b3 <snprintf+0x51>
  801293:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801297:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80129b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80129f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8012a3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8012a7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8012ab:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8012af:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8012b3:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8012ba:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8012c1:	00 00 00 
  8012c4:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8012cb:	00 00 00 
  8012ce:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8012d2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8012d9:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8012e0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8012e7:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8012ee:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8012f5:	48 8b 0a             	mov    (%rdx),%rcx
  8012f8:	48 89 08             	mov    %rcx,(%rax)
  8012fb:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8012ff:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801303:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801307:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80130b:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801312:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801319:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80131f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801326:	48 89 c7             	mov    %rax,%rdi
  801329:	48 b8 c5 11 80 00 00 	movabs $0x8011c5,%rax
  801330:	00 00 00 
  801333:	ff d0                	callq  *%rax
  801335:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80133b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801341:	c9                   	leaveq 
  801342:	c3                   	retq   

0000000000801343 <strlen>:
  801343:	55                   	push   %rbp
  801344:	48 89 e5             	mov    %rsp,%rbp
  801347:	48 83 ec 18          	sub    $0x18,%rsp
  80134b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80134f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801356:	eb 09                	jmp    801361 <strlen+0x1e>
  801358:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80135c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801361:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801365:	0f b6 00             	movzbl (%rax),%eax
  801368:	84 c0                	test   %al,%al
  80136a:	75 ec                	jne    801358 <strlen+0x15>
  80136c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80136f:	c9                   	leaveq 
  801370:	c3                   	retq   

0000000000801371 <strnlen>:
  801371:	55                   	push   %rbp
  801372:	48 89 e5             	mov    %rsp,%rbp
  801375:	48 83 ec 20          	sub    $0x20,%rsp
  801379:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80137d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801388:	eb 0e                	jmp    801398 <strnlen+0x27>
  80138a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80138e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801393:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801398:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80139d:	74 0b                	je     8013aa <strnlen+0x39>
  80139f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013a3:	0f b6 00             	movzbl (%rax),%eax
  8013a6:	84 c0                	test   %al,%al
  8013a8:	75 e0                	jne    80138a <strnlen+0x19>
  8013aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8013ad:	c9                   	leaveq 
  8013ae:	c3                   	retq   

00000000008013af <strcpy>:
  8013af:	55                   	push   %rbp
  8013b0:	48 89 e5             	mov    %rsp,%rbp
  8013b3:	48 83 ec 20          	sub    $0x20,%rsp
  8013b7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013bb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013c7:	90                   	nop
  8013c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013cc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8013d0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013d4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8013d8:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8013dc:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8013e0:	0f b6 12             	movzbl (%rdx),%edx
  8013e3:	88 10                	mov    %dl,(%rax)
  8013e5:	0f b6 00             	movzbl (%rax),%eax
  8013e8:	84 c0                	test   %al,%al
  8013ea:	75 dc                	jne    8013c8 <strcpy+0x19>
  8013ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013f0:	c9                   	leaveq 
  8013f1:	c3                   	retq   

00000000008013f2 <strcat>:
  8013f2:	55                   	push   %rbp
  8013f3:	48 89 e5             	mov    %rsp,%rbp
  8013f6:	48 83 ec 20          	sub    $0x20,%rsp
  8013fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013fe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801402:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801406:	48 89 c7             	mov    %rax,%rdi
  801409:	48 b8 43 13 80 00 00 	movabs $0x801343,%rax
  801410:	00 00 00 
  801413:	ff d0                	callq  *%rax
  801415:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801418:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80141b:	48 63 d0             	movslq %eax,%rdx
  80141e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801422:	48 01 c2             	add    %rax,%rdx
  801425:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801429:	48 89 c6             	mov    %rax,%rsi
  80142c:	48 89 d7             	mov    %rdx,%rdi
  80142f:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  801436:	00 00 00 
  801439:	ff d0                	callq  *%rax
  80143b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80143f:	c9                   	leaveq 
  801440:	c3                   	retq   

0000000000801441 <strncpy>:
  801441:	55                   	push   %rbp
  801442:	48 89 e5             	mov    %rsp,%rbp
  801445:	48 83 ec 28          	sub    $0x28,%rsp
  801449:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80144d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801451:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801455:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801459:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80145d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801464:	00 
  801465:	eb 2a                	jmp    801491 <strncpy+0x50>
  801467:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80146b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80146f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801473:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801477:	0f b6 12             	movzbl (%rdx),%edx
  80147a:	88 10                	mov    %dl,(%rax)
  80147c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801480:	0f b6 00             	movzbl (%rax),%eax
  801483:	84 c0                	test   %al,%al
  801485:	74 05                	je     80148c <strncpy+0x4b>
  801487:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80148c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801491:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801495:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801499:	72 cc                	jb     801467 <strncpy+0x26>
  80149b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80149f:	c9                   	leaveq 
  8014a0:	c3                   	retq   

00000000008014a1 <strlcpy>:
  8014a1:	55                   	push   %rbp
  8014a2:	48 89 e5             	mov    %rsp,%rbp
  8014a5:	48 83 ec 28          	sub    $0x28,%rsp
  8014a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014b1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8014bd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8014c2:	74 3d                	je     801501 <strlcpy+0x60>
  8014c4:	eb 1d                	jmp    8014e3 <strlcpy+0x42>
  8014c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014ca:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8014ce:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014d2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8014d6:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8014da:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8014de:	0f b6 12             	movzbl (%rdx),%edx
  8014e1:	88 10                	mov    %dl,(%rax)
  8014e3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8014e8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8014ed:	74 0b                	je     8014fa <strlcpy+0x59>
  8014ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014f3:	0f b6 00             	movzbl (%rax),%eax
  8014f6:	84 c0                	test   %al,%al
  8014f8:	75 cc                	jne    8014c6 <strlcpy+0x25>
  8014fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014fe:	c6 00 00             	movb   $0x0,(%rax)
  801501:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801505:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801509:	48 29 c2             	sub    %rax,%rdx
  80150c:	48 89 d0             	mov    %rdx,%rax
  80150f:	c9                   	leaveq 
  801510:	c3                   	retq   

0000000000801511 <strcmp>:
  801511:	55                   	push   %rbp
  801512:	48 89 e5             	mov    %rsp,%rbp
  801515:	48 83 ec 10          	sub    $0x10,%rsp
  801519:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80151d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801521:	eb 0a                	jmp    80152d <strcmp+0x1c>
  801523:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801528:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80152d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801531:	0f b6 00             	movzbl (%rax),%eax
  801534:	84 c0                	test   %al,%al
  801536:	74 12                	je     80154a <strcmp+0x39>
  801538:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80153c:	0f b6 10             	movzbl (%rax),%edx
  80153f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801543:	0f b6 00             	movzbl (%rax),%eax
  801546:	38 c2                	cmp    %al,%dl
  801548:	74 d9                	je     801523 <strcmp+0x12>
  80154a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80154e:	0f b6 00             	movzbl (%rax),%eax
  801551:	0f b6 d0             	movzbl %al,%edx
  801554:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801558:	0f b6 00             	movzbl (%rax),%eax
  80155b:	0f b6 c0             	movzbl %al,%eax
  80155e:	29 c2                	sub    %eax,%edx
  801560:	89 d0                	mov    %edx,%eax
  801562:	c9                   	leaveq 
  801563:	c3                   	retq   

0000000000801564 <strncmp>:
  801564:	55                   	push   %rbp
  801565:	48 89 e5             	mov    %rsp,%rbp
  801568:	48 83 ec 18          	sub    $0x18,%rsp
  80156c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801570:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801574:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801578:	eb 0f                	jmp    801589 <strncmp+0x25>
  80157a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80157f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801584:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801589:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80158e:	74 1d                	je     8015ad <strncmp+0x49>
  801590:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801594:	0f b6 00             	movzbl (%rax),%eax
  801597:	84 c0                	test   %al,%al
  801599:	74 12                	je     8015ad <strncmp+0x49>
  80159b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80159f:	0f b6 10             	movzbl (%rax),%edx
  8015a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015a6:	0f b6 00             	movzbl (%rax),%eax
  8015a9:	38 c2                	cmp    %al,%dl
  8015ab:	74 cd                	je     80157a <strncmp+0x16>
  8015ad:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8015b2:	75 07                	jne    8015bb <strncmp+0x57>
  8015b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8015b9:	eb 18                	jmp    8015d3 <strncmp+0x6f>
  8015bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015bf:	0f b6 00             	movzbl (%rax),%eax
  8015c2:	0f b6 d0             	movzbl %al,%edx
  8015c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015c9:	0f b6 00             	movzbl (%rax),%eax
  8015cc:	0f b6 c0             	movzbl %al,%eax
  8015cf:	29 c2                	sub    %eax,%edx
  8015d1:	89 d0                	mov    %edx,%eax
  8015d3:	c9                   	leaveq 
  8015d4:	c3                   	retq   

00000000008015d5 <strchr>:
  8015d5:	55                   	push   %rbp
  8015d6:	48 89 e5             	mov    %rsp,%rbp
  8015d9:	48 83 ec 0c          	sub    $0xc,%rsp
  8015dd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8015e1:	89 f0                	mov    %esi,%eax
  8015e3:	88 45 f4             	mov    %al,-0xc(%rbp)
  8015e6:	eb 17                	jmp    8015ff <strchr+0x2a>
  8015e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015ec:	0f b6 00             	movzbl (%rax),%eax
  8015ef:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8015f2:	75 06                	jne    8015fa <strchr+0x25>
  8015f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015f8:	eb 15                	jmp    80160f <strchr+0x3a>
  8015fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8015ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801603:	0f b6 00             	movzbl (%rax),%eax
  801606:	84 c0                	test   %al,%al
  801608:	75 de                	jne    8015e8 <strchr+0x13>
  80160a:	b8 00 00 00 00       	mov    $0x0,%eax
  80160f:	c9                   	leaveq 
  801610:	c3                   	retq   

0000000000801611 <strfind>:
  801611:	55                   	push   %rbp
  801612:	48 89 e5             	mov    %rsp,%rbp
  801615:	48 83 ec 0c          	sub    $0xc,%rsp
  801619:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80161d:	89 f0                	mov    %esi,%eax
  80161f:	88 45 f4             	mov    %al,-0xc(%rbp)
  801622:	eb 13                	jmp    801637 <strfind+0x26>
  801624:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801628:	0f b6 00             	movzbl (%rax),%eax
  80162b:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80162e:	75 02                	jne    801632 <strfind+0x21>
  801630:	eb 10                	jmp    801642 <strfind+0x31>
  801632:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801637:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80163b:	0f b6 00             	movzbl (%rax),%eax
  80163e:	84 c0                	test   %al,%al
  801640:	75 e2                	jne    801624 <strfind+0x13>
  801642:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801646:	c9                   	leaveq 
  801647:	c3                   	retq   

0000000000801648 <memset>:
  801648:	55                   	push   %rbp
  801649:	48 89 e5             	mov    %rsp,%rbp
  80164c:	48 83 ec 18          	sub    $0x18,%rsp
  801650:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801654:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801657:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80165b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801660:	75 06                	jne    801668 <memset+0x20>
  801662:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801666:	eb 69                	jmp    8016d1 <memset+0x89>
  801668:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80166c:	83 e0 03             	and    $0x3,%eax
  80166f:	48 85 c0             	test   %rax,%rax
  801672:	75 48                	jne    8016bc <memset+0x74>
  801674:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801678:	83 e0 03             	and    $0x3,%eax
  80167b:	48 85 c0             	test   %rax,%rax
  80167e:	75 3c                	jne    8016bc <memset+0x74>
  801680:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801687:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80168a:	c1 e0 18             	shl    $0x18,%eax
  80168d:	89 c2                	mov    %eax,%edx
  80168f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801692:	c1 e0 10             	shl    $0x10,%eax
  801695:	09 c2                	or     %eax,%edx
  801697:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80169a:	c1 e0 08             	shl    $0x8,%eax
  80169d:	09 d0                	or     %edx,%eax
  80169f:	09 45 f4             	or     %eax,-0xc(%rbp)
  8016a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016a6:	48 c1 e8 02          	shr    $0x2,%rax
  8016aa:	48 89 c1             	mov    %rax,%rcx
  8016ad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016b4:	48 89 d7             	mov    %rdx,%rdi
  8016b7:	fc                   	cld    
  8016b8:	f3 ab                	rep stos %eax,%es:(%rdi)
  8016ba:	eb 11                	jmp    8016cd <memset+0x85>
  8016bc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016c0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016c3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8016c7:	48 89 d7             	mov    %rdx,%rdi
  8016ca:	fc                   	cld    
  8016cb:	f3 aa                	rep stos %al,%es:(%rdi)
  8016cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016d1:	c9                   	leaveq 
  8016d2:	c3                   	retq   

00000000008016d3 <memmove>:
  8016d3:	55                   	push   %rbp
  8016d4:	48 89 e5             	mov    %rsp,%rbp
  8016d7:	48 83 ec 28          	sub    $0x28,%rsp
  8016db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8016df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8016e3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8016eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8016ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8016f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016fb:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8016ff:	0f 83 88 00 00 00    	jae    80178d <memmove+0xba>
  801705:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801709:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80170d:	48 01 d0             	add    %rdx,%rax
  801710:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801714:	76 77                	jbe    80178d <memmove+0xba>
  801716:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80171a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80171e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801722:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801726:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80172a:	83 e0 03             	and    $0x3,%eax
  80172d:	48 85 c0             	test   %rax,%rax
  801730:	75 3b                	jne    80176d <memmove+0x9a>
  801732:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801736:	83 e0 03             	and    $0x3,%eax
  801739:	48 85 c0             	test   %rax,%rax
  80173c:	75 2f                	jne    80176d <memmove+0x9a>
  80173e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801742:	83 e0 03             	and    $0x3,%eax
  801745:	48 85 c0             	test   %rax,%rax
  801748:	75 23                	jne    80176d <memmove+0x9a>
  80174a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80174e:	48 83 e8 04          	sub    $0x4,%rax
  801752:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801756:	48 83 ea 04          	sub    $0x4,%rdx
  80175a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80175e:	48 c1 e9 02          	shr    $0x2,%rcx
  801762:	48 89 c7             	mov    %rax,%rdi
  801765:	48 89 d6             	mov    %rdx,%rsi
  801768:	fd                   	std    
  801769:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80176b:	eb 1d                	jmp    80178a <memmove+0xb7>
  80176d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801771:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801775:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801779:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  80177d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801781:	48 89 d7             	mov    %rdx,%rdi
  801784:	48 89 c1             	mov    %rax,%rcx
  801787:	fd                   	std    
  801788:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80178a:	fc                   	cld    
  80178b:	eb 57                	jmp    8017e4 <memmove+0x111>
  80178d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801791:	83 e0 03             	and    $0x3,%eax
  801794:	48 85 c0             	test   %rax,%rax
  801797:	75 36                	jne    8017cf <memmove+0xfc>
  801799:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80179d:	83 e0 03             	and    $0x3,%eax
  8017a0:	48 85 c0             	test   %rax,%rax
  8017a3:	75 2a                	jne    8017cf <memmove+0xfc>
  8017a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a9:	83 e0 03             	and    $0x3,%eax
  8017ac:	48 85 c0             	test   %rax,%rax
  8017af:	75 1e                	jne    8017cf <memmove+0xfc>
  8017b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017b5:	48 c1 e8 02          	shr    $0x2,%rax
  8017b9:	48 89 c1             	mov    %rax,%rcx
  8017bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017c4:	48 89 c7             	mov    %rax,%rdi
  8017c7:	48 89 d6             	mov    %rdx,%rsi
  8017ca:	fc                   	cld    
  8017cb:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8017cd:	eb 15                	jmp    8017e4 <memmove+0x111>
  8017cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017d3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017d7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8017db:	48 89 c7             	mov    %rax,%rdi
  8017de:	48 89 d6             	mov    %rdx,%rsi
  8017e1:	fc                   	cld    
  8017e2:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8017e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017e8:	c9                   	leaveq 
  8017e9:	c3                   	retq   

00000000008017ea <memcpy>:
  8017ea:	55                   	push   %rbp
  8017eb:	48 89 e5             	mov    %rsp,%rbp
  8017ee:	48 83 ec 18          	sub    $0x18,%rsp
  8017f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8017f6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8017fa:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8017fe:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801802:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801806:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80180a:	48 89 ce             	mov    %rcx,%rsi
  80180d:	48 89 c7             	mov    %rax,%rdi
  801810:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  801817:	00 00 00 
  80181a:	ff d0                	callq  *%rax
  80181c:	c9                   	leaveq 
  80181d:	c3                   	retq   

000000000080181e <memcmp>:
  80181e:	55                   	push   %rbp
  80181f:	48 89 e5             	mov    %rsp,%rbp
  801822:	48 83 ec 28          	sub    $0x28,%rsp
  801826:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80182a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80182e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801832:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801836:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80183a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80183e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801842:	eb 36                	jmp    80187a <memcmp+0x5c>
  801844:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801848:	0f b6 10             	movzbl (%rax),%edx
  80184b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80184f:	0f b6 00             	movzbl (%rax),%eax
  801852:	38 c2                	cmp    %al,%dl
  801854:	74 1a                	je     801870 <memcmp+0x52>
  801856:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80185a:	0f b6 00             	movzbl (%rax),%eax
  80185d:	0f b6 d0             	movzbl %al,%edx
  801860:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801864:	0f b6 00             	movzbl (%rax),%eax
  801867:	0f b6 c0             	movzbl %al,%eax
  80186a:	29 c2                	sub    %eax,%edx
  80186c:	89 d0                	mov    %edx,%eax
  80186e:	eb 20                	jmp    801890 <memcmp+0x72>
  801870:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801875:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80187a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80187e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801882:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801886:	48 85 c0             	test   %rax,%rax
  801889:	75 b9                	jne    801844 <memcmp+0x26>
  80188b:	b8 00 00 00 00       	mov    $0x0,%eax
  801890:	c9                   	leaveq 
  801891:	c3                   	retq   

0000000000801892 <memfind>:
  801892:	55                   	push   %rbp
  801893:	48 89 e5             	mov    %rsp,%rbp
  801896:	48 83 ec 28          	sub    $0x28,%rsp
  80189a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80189e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8018a1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018a9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018ad:	48 01 d0             	add    %rdx,%rax
  8018b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018b4:	eb 15                	jmp    8018cb <memfind+0x39>
  8018b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018ba:	0f b6 10             	movzbl (%rax),%edx
  8018bd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8018c0:	38 c2                	cmp    %al,%dl
  8018c2:	75 02                	jne    8018c6 <memfind+0x34>
  8018c4:	eb 0f                	jmp    8018d5 <memfind+0x43>
  8018c6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8018cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018cf:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8018d3:	72 e1                	jb     8018b6 <memfind+0x24>
  8018d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018d9:	c9                   	leaveq 
  8018da:	c3                   	retq   

00000000008018db <strtol>:
  8018db:	55                   	push   %rbp
  8018dc:	48 89 e5             	mov    %rsp,%rbp
  8018df:	48 83 ec 34          	sub    $0x34,%rsp
  8018e3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8018e7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8018eb:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8018ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8018f5:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8018fc:	00 
  8018fd:	eb 05                	jmp    801904 <strtol+0x29>
  8018ff:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801904:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801908:	0f b6 00             	movzbl (%rax),%eax
  80190b:	3c 20                	cmp    $0x20,%al
  80190d:	74 f0                	je     8018ff <strtol+0x24>
  80190f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801913:	0f b6 00             	movzbl (%rax),%eax
  801916:	3c 09                	cmp    $0x9,%al
  801918:	74 e5                	je     8018ff <strtol+0x24>
  80191a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80191e:	0f b6 00             	movzbl (%rax),%eax
  801921:	3c 2b                	cmp    $0x2b,%al
  801923:	75 07                	jne    80192c <strtol+0x51>
  801925:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80192a:	eb 17                	jmp    801943 <strtol+0x68>
  80192c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801930:	0f b6 00             	movzbl (%rax),%eax
  801933:	3c 2d                	cmp    $0x2d,%al
  801935:	75 0c                	jne    801943 <strtol+0x68>
  801937:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80193c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801943:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801947:	74 06                	je     80194f <strtol+0x74>
  801949:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  80194d:	75 28                	jne    801977 <strtol+0x9c>
  80194f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801953:	0f b6 00             	movzbl (%rax),%eax
  801956:	3c 30                	cmp    $0x30,%al
  801958:	75 1d                	jne    801977 <strtol+0x9c>
  80195a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80195e:	48 83 c0 01          	add    $0x1,%rax
  801962:	0f b6 00             	movzbl (%rax),%eax
  801965:	3c 78                	cmp    $0x78,%al
  801967:	75 0e                	jne    801977 <strtol+0x9c>
  801969:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  80196e:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801975:	eb 2c                	jmp    8019a3 <strtol+0xc8>
  801977:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80197b:	75 19                	jne    801996 <strtol+0xbb>
  80197d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801981:	0f b6 00             	movzbl (%rax),%eax
  801984:	3c 30                	cmp    $0x30,%al
  801986:	75 0e                	jne    801996 <strtol+0xbb>
  801988:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80198d:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801994:	eb 0d                	jmp    8019a3 <strtol+0xc8>
  801996:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80199a:	75 07                	jne    8019a3 <strtol+0xc8>
  80199c:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8019a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019a7:	0f b6 00             	movzbl (%rax),%eax
  8019aa:	3c 2f                	cmp    $0x2f,%al
  8019ac:	7e 1d                	jle    8019cb <strtol+0xf0>
  8019ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019b2:	0f b6 00             	movzbl (%rax),%eax
  8019b5:	3c 39                	cmp    $0x39,%al
  8019b7:	7f 12                	jg     8019cb <strtol+0xf0>
  8019b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019bd:	0f b6 00             	movzbl (%rax),%eax
  8019c0:	0f be c0             	movsbl %al,%eax
  8019c3:	83 e8 30             	sub    $0x30,%eax
  8019c6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8019c9:	eb 4e                	jmp    801a19 <strtol+0x13e>
  8019cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019cf:	0f b6 00             	movzbl (%rax),%eax
  8019d2:	3c 60                	cmp    $0x60,%al
  8019d4:	7e 1d                	jle    8019f3 <strtol+0x118>
  8019d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019da:	0f b6 00             	movzbl (%rax),%eax
  8019dd:	3c 7a                	cmp    $0x7a,%al
  8019df:	7f 12                	jg     8019f3 <strtol+0x118>
  8019e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019e5:	0f b6 00             	movzbl (%rax),%eax
  8019e8:	0f be c0             	movsbl %al,%eax
  8019eb:	83 e8 57             	sub    $0x57,%eax
  8019ee:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8019f1:	eb 26                	jmp    801a19 <strtol+0x13e>
  8019f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019f7:	0f b6 00             	movzbl (%rax),%eax
  8019fa:	3c 40                	cmp    $0x40,%al
  8019fc:	7e 48                	jle    801a46 <strtol+0x16b>
  8019fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a02:	0f b6 00             	movzbl (%rax),%eax
  801a05:	3c 5a                	cmp    $0x5a,%al
  801a07:	7f 3d                	jg     801a46 <strtol+0x16b>
  801a09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a0d:	0f b6 00             	movzbl (%rax),%eax
  801a10:	0f be c0             	movsbl %al,%eax
  801a13:	83 e8 37             	sub    $0x37,%eax
  801a16:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a1c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801a1f:	7c 02                	jl     801a23 <strtol+0x148>
  801a21:	eb 23                	jmp    801a46 <strtol+0x16b>
  801a23:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801a28:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801a2b:	48 98                	cltq   
  801a2d:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801a32:	48 89 c2             	mov    %rax,%rdx
  801a35:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a38:	48 98                	cltq   
  801a3a:	48 01 d0             	add    %rdx,%rax
  801a3d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801a41:	e9 5d ff ff ff       	jmpq   8019a3 <strtol+0xc8>
  801a46:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801a4b:	74 0b                	je     801a58 <strtol+0x17d>
  801a4d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801a51:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801a55:	48 89 10             	mov    %rdx,(%rax)
  801a58:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801a5c:	74 09                	je     801a67 <strtol+0x18c>
  801a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a62:	48 f7 d8             	neg    %rax
  801a65:	eb 04                	jmp    801a6b <strtol+0x190>
  801a67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a6b:	c9                   	leaveq 
  801a6c:	c3                   	retq   

0000000000801a6d <strstr>:
  801a6d:	55                   	push   %rbp
  801a6e:	48 89 e5             	mov    %rsp,%rbp
  801a71:	48 83 ec 30          	sub    $0x30,%rsp
  801a75:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801a79:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801a7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801a81:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801a85:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801a89:	0f b6 00             	movzbl (%rax),%eax
  801a8c:	88 45 ff             	mov    %al,-0x1(%rbp)
  801a8f:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801a93:	75 06                	jne    801a9b <strstr+0x2e>
  801a95:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a99:	eb 6b                	jmp    801b06 <strstr+0x99>
  801a9b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801a9f:	48 89 c7             	mov    %rax,%rdi
  801aa2:	48 b8 43 13 80 00 00 	movabs $0x801343,%rax
  801aa9:	00 00 00 
  801aac:	ff d0                	callq  *%rax
  801aae:	48 98                	cltq   
  801ab0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ab4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ab8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801abc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801ac0:	0f b6 00             	movzbl (%rax),%eax
  801ac3:	88 45 ef             	mov    %al,-0x11(%rbp)
  801ac6:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801aca:	75 07                	jne    801ad3 <strstr+0x66>
  801acc:	b8 00 00 00 00       	mov    $0x0,%eax
  801ad1:	eb 33                	jmp    801b06 <strstr+0x99>
  801ad3:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801ad7:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801ada:	75 d8                	jne    801ab4 <strstr+0x47>
  801adc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ae0:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801ae4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ae8:	48 89 ce             	mov    %rcx,%rsi
  801aeb:	48 89 c7             	mov    %rax,%rdi
  801aee:	48 b8 64 15 80 00 00 	movabs $0x801564,%rax
  801af5:	00 00 00 
  801af8:	ff d0                	callq  *%rax
  801afa:	85 c0                	test   %eax,%eax
  801afc:	75 b6                	jne    801ab4 <strstr+0x47>
  801afe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b02:	48 83 e8 01          	sub    $0x1,%rax
  801b06:	c9                   	leaveq 
  801b07:	c3                   	retq   

0000000000801b08 <syscall>:
  801b08:	55                   	push   %rbp
  801b09:	48 89 e5             	mov    %rsp,%rbp
  801b0c:	53                   	push   %rbx
  801b0d:	48 83 ec 48          	sub    $0x48,%rsp
  801b11:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801b14:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801b17:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801b1b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801b1f:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801b23:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801b27:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801b2a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801b2e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801b32:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801b36:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801b3a:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801b3e:	4c 89 c3             	mov    %r8,%rbx
  801b41:	cd 30                	int    $0x30
  801b43:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801b47:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801b4b:	74 3e                	je     801b8b <syscall+0x83>
  801b4d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801b52:	7e 37                	jle    801b8b <syscall+0x83>
  801b54:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801b58:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801b5b:	49 89 d0             	mov    %rdx,%r8
  801b5e:	89 c1                	mov    %eax,%ecx
  801b60:	48 ba e8 4f 80 00 00 	movabs $0x804fe8,%rdx
  801b67:	00 00 00 
  801b6a:	be 24 00 00 00       	mov    $0x24,%esi
  801b6f:	48 bf 05 50 80 00 00 	movabs $0x805005,%rdi
  801b76:	00 00 00 
  801b79:	b8 00 00 00 00       	mov    $0x0,%eax
  801b7e:	49 b9 c1 05 80 00 00 	movabs $0x8005c1,%r9
  801b85:	00 00 00 
  801b88:	41 ff d1             	callq  *%r9
  801b8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b8f:	48 83 c4 48          	add    $0x48,%rsp
  801b93:	5b                   	pop    %rbx
  801b94:	5d                   	pop    %rbp
  801b95:	c3                   	retq   

0000000000801b96 <sys_cputs>:
  801b96:	55                   	push   %rbp
  801b97:	48 89 e5             	mov    %rsp,%rbp
  801b9a:	48 83 ec 20          	sub    $0x20,%rsp
  801b9e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801ba2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ba6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801baa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bae:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bb5:	00 
  801bb6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bbc:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bc2:	48 89 d1             	mov    %rdx,%rcx
  801bc5:	48 89 c2             	mov    %rax,%rdx
  801bc8:	be 00 00 00 00       	mov    $0x0,%esi
  801bcd:	bf 00 00 00 00       	mov    $0x0,%edi
  801bd2:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801bd9:	00 00 00 
  801bdc:	ff d0                	callq  *%rax
  801bde:	c9                   	leaveq 
  801bdf:	c3                   	retq   

0000000000801be0 <sys_cgetc>:
  801be0:	55                   	push   %rbp
  801be1:	48 89 e5             	mov    %rsp,%rbp
  801be4:	48 83 ec 10          	sub    $0x10,%rsp
  801be8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bef:	00 
  801bf0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bf6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bfc:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c01:	ba 00 00 00 00       	mov    $0x0,%edx
  801c06:	be 00 00 00 00       	mov    $0x0,%esi
  801c0b:	bf 01 00 00 00       	mov    $0x1,%edi
  801c10:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801c17:	00 00 00 
  801c1a:	ff d0                	callq  *%rax
  801c1c:	c9                   	leaveq 
  801c1d:	c3                   	retq   

0000000000801c1e <sys_env_destroy>:
  801c1e:	55                   	push   %rbp
  801c1f:	48 89 e5             	mov    %rsp,%rbp
  801c22:	48 83 ec 10          	sub    $0x10,%rsp
  801c26:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c29:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c2c:	48 98                	cltq   
  801c2e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c35:	00 
  801c36:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c3c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c42:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c47:	48 89 c2             	mov    %rax,%rdx
  801c4a:	be 01 00 00 00       	mov    $0x1,%esi
  801c4f:	bf 03 00 00 00       	mov    $0x3,%edi
  801c54:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801c5b:	00 00 00 
  801c5e:	ff d0                	callq  *%rax
  801c60:	c9                   	leaveq 
  801c61:	c3                   	retq   

0000000000801c62 <sys_getenvid>:
  801c62:	55                   	push   %rbp
  801c63:	48 89 e5             	mov    %rsp,%rbp
  801c66:	48 83 ec 10          	sub    $0x10,%rsp
  801c6a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c71:	00 
  801c72:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c78:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c7e:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c83:	ba 00 00 00 00       	mov    $0x0,%edx
  801c88:	be 00 00 00 00       	mov    $0x0,%esi
  801c8d:	bf 02 00 00 00       	mov    $0x2,%edi
  801c92:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801c99:	00 00 00 
  801c9c:	ff d0                	callq  *%rax
  801c9e:	c9                   	leaveq 
  801c9f:	c3                   	retq   

0000000000801ca0 <sys_yield>:
  801ca0:	55                   	push   %rbp
  801ca1:	48 89 e5             	mov    %rsp,%rbp
  801ca4:	48 83 ec 10          	sub    $0x10,%rsp
  801ca8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801caf:	00 
  801cb0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cb6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cbc:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cc1:	ba 00 00 00 00       	mov    $0x0,%edx
  801cc6:	be 00 00 00 00       	mov    $0x0,%esi
  801ccb:	bf 0b 00 00 00       	mov    $0xb,%edi
  801cd0:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801cd7:	00 00 00 
  801cda:	ff d0                	callq  *%rax
  801cdc:	c9                   	leaveq 
  801cdd:	c3                   	retq   

0000000000801cde <sys_page_alloc>:
  801cde:	55                   	push   %rbp
  801cdf:	48 89 e5             	mov    %rsp,%rbp
  801ce2:	48 83 ec 20          	sub    $0x20,%rsp
  801ce6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ce9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ced:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801cf0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801cf3:	48 63 c8             	movslq %eax,%rcx
  801cf6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801cfa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cfd:	48 98                	cltq   
  801cff:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d06:	00 
  801d07:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d0d:	49 89 c8             	mov    %rcx,%r8
  801d10:	48 89 d1             	mov    %rdx,%rcx
  801d13:	48 89 c2             	mov    %rax,%rdx
  801d16:	be 01 00 00 00       	mov    $0x1,%esi
  801d1b:	bf 04 00 00 00       	mov    $0x4,%edi
  801d20:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801d27:	00 00 00 
  801d2a:	ff d0                	callq  *%rax
  801d2c:	c9                   	leaveq 
  801d2d:	c3                   	retq   

0000000000801d2e <sys_page_map>:
  801d2e:	55                   	push   %rbp
  801d2f:	48 89 e5             	mov    %rsp,%rbp
  801d32:	48 83 ec 30          	sub    $0x30,%rsp
  801d36:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d39:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d3d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d40:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801d44:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801d48:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801d4b:	48 63 c8             	movslq %eax,%rcx
  801d4e:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801d52:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d55:	48 63 f0             	movslq %eax,%rsi
  801d58:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d5f:	48 98                	cltq   
  801d61:	48 89 0c 24          	mov    %rcx,(%rsp)
  801d65:	49 89 f9             	mov    %rdi,%r9
  801d68:	49 89 f0             	mov    %rsi,%r8
  801d6b:	48 89 d1             	mov    %rdx,%rcx
  801d6e:	48 89 c2             	mov    %rax,%rdx
  801d71:	be 01 00 00 00       	mov    $0x1,%esi
  801d76:	bf 05 00 00 00       	mov    $0x5,%edi
  801d7b:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801d82:	00 00 00 
  801d85:	ff d0                	callq  *%rax
  801d87:	c9                   	leaveq 
  801d88:	c3                   	retq   

0000000000801d89 <sys_page_unmap>:
  801d89:	55                   	push   %rbp
  801d8a:	48 89 e5             	mov    %rsp,%rbp
  801d8d:	48 83 ec 20          	sub    $0x20,%rsp
  801d91:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d94:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d98:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d9f:	48 98                	cltq   
  801da1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801da8:	00 
  801da9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801daf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801db5:	48 89 d1             	mov    %rdx,%rcx
  801db8:	48 89 c2             	mov    %rax,%rdx
  801dbb:	be 01 00 00 00       	mov    $0x1,%esi
  801dc0:	bf 06 00 00 00       	mov    $0x6,%edi
  801dc5:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801dcc:	00 00 00 
  801dcf:	ff d0                	callq  *%rax
  801dd1:	c9                   	leaveq 
  801dd2:	c3                   	retq   

0000000000801dd3 <sys_env_set_status>:
  801dd3:	55                   	push   %rbp
  801dd4:	48 89 e5             	mov    %rsp,%rbp
  801dd7:	48 83 ec 10          	sub    $0x10,%rsp
  801ddb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801dde:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801de1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801de4:	48 63 d0             	movslq %eax,%rdx
  801de7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dea:	48 98                	cltq   
  801dec:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801df3:	00 
  801df4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dfa:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e00:	48 89 d1             	mov    %rdx,%rcx
  801e03:	48 89 c2             	mov    %rax,%rdx
  801e06:	be 01 00 00 00       	mov    $0x1,%esi
  801e0b:	bf 08 00 00 00       	mov    $0x8,%edi
  801e10:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801e17:	00 00 00 
  801e1a:	ff d0                	callq  *%rax
  801e1c:	c9                   	leaveq 
  801e1d:	c3                   	retq   

0000000000801e1e <sys_env_set_trapframe>:
  801e1e:	55                   	push   %rbp
  801e1f:	48 89 e5             	mov    %rsp,%rbp
  801e22:	48 83 ec 20          	sub    $0x20,%rsp
  801e26:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e29:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e2d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e31:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e34:	48 98                	cltq   
  801e36:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e3d:	00 
  801e3e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e44:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e4a:	48 89 d1             	mov    %rdx,%rcx
  801e4d:	48 89 c2             	mov    %rax,%rdx
  801e50:	be 01 00 00 00       	mov    $0x1,%esi
  801e55:	bf 09 00 00 00       	mov    $0x9,%edi
  801e5a:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801e61:	00 00 00 
  801e64:	ff d0                	callq  *%rax
  801e66:	c9                   	leaveq 
  801e67:	c3                   	retq   

0000000000801e68 <sys_env_set_pgfault_upcall>:
  801e68:	55                   	push   %rbp
  801e69:	48 89 e5             	mov    %rsp,%rbp
  801e6c:	48 83 ec 20          	sub    $0x20,%rsp
  801e70:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e73:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e77:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e7e:	48 98                	cltq   
  801e80:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e87:	00 
  801e88:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e8e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e94:	48 89 d1             	mov    %rdx,%rcx
  801e97:	48 89 c2             	mov    %rax,%rdx
  801e9a:	be 01 00 00 00       	mov    $0x1,%esi
  801e9f:	bf 0a 00 00 00       	mov    $0xa,%edi
  801ea4:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801eab:	00 00 00 
  801eae:	ff d0                	callq  *%rax
  801eb0:	c9                   	leaveq 
  801eb1:	c3                   	retq   

0000000000801eb2 <sys_ipc_try_send>:
  801eb2:	55                   	push   %rbp
  801eb3:	48 89 e5             	mov    %rsp,%rbp
  801eb6:	48 83 ec 20          	sub    $0x20,%rsp
  801eba:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ebd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ec1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801ec5:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801ec8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801ecb:	48 63 f0             	movslq %eax,%rsi
  801ece:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801ed2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ed5:	48 98                	cltq   
  801ed7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801edb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ee2:	00 
  801ee3:	49 89 f1             	mov    %rsi,%r9
  801ee6:	49 89 c8             	mov    %rcx,%r8
  801ee9:	48 89 d1             	mov    %rdx,%rcx
  801eec:	48 89 c2             	mov    %rax,%rdx
  801eef:	be 00 00 00 00       	mov    $0x0,%esi
  801ef4:	bf 0c 00 00 00       	mov    $0xc,%edi
  801ef9:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801f00:	00 00 00 
  801f03:	ff d0                	callq  *%rax
  801f05:	c9                   	leaveq 
  801f06:	c3                   	retq   

0000000000801f07 <sys_ipc_recv>:
  801f07:	55                   	push   %rbp
  801f08:	48 89 e5             	mov    %rsp,%rbp
  801f0b:	48 83 ec 10          	sub    $0x10,%rsp
  801f0f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f17:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f1e:	00 
  801f1f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f25:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f2b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801f30:	48 89 c2             	mov    %rax,%rdx
  801f33:	be 01 00 00 00       	mov    $0x1,%esi
  801f38:	bf 0d 00 00 00       	mov    $0xd,%edi
  801f3d:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801f44:	00 00 00 
  801f47:	ff d0                	callq  *%rax
  801f49:	c9                   	leaveq 
  801f4a:	c3                   	retq   

0000000000801f4b <sys_time_msec>:
  801f4b:	55                   	push   %rbp
  801f4c:	48 89 e5             	mov    %rsp,%rbp
  801f4f:	48 83 ec 10          	sub    $0x10,%rsp
  801f53:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f5a:	00 
  801f5b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f61:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f67:	b9 00 00 00 00       	mov    $0x0,%ecx
  801f6c:	ba 00 00 00 00       	mov    $0x0,%edx
  801f71:	be 00 00 00 00       	mov    $0x0,%esi
  801f76:	bf 0e 00 00 00       	mov    $0xe,%edi
  801f7b:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801f82:	00 00 00 
  801f85:	ff d0                	callq  *%rax
  801f87:	c9                   	leaveq 
  801f88:	c3                   	retq   

0000000000801f89 <sys_net_transmit>:
  801f89:	55                   	push   %rbp
  801f8a:	48 89 e5             	mov    %rsp,%rbp
  801f8d:	48 83 ec 20          	sub    $0x20,%rsp
  801f91:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f95:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801f98:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801f9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f9f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fa6:	00 
  801fa7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fad:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801fb3:	48 89 d1             	mov    %rdx,%rcx
  801fb6:	48 89 c2             	mov    %rax,%rdx
  801fb9:	be 00 00 00 00       	mov    $0x0,%esi
  801fbe:	bf 0f 00 00 00       	mov    $0xf,%edi
  801fc3:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  801fca:	00 00 00 
  801fcd:	ff d0                	callq  *%rax
  801fcf:	c9                   	leaveq 
  801fd0:	c3                   	retq   

0000000000801fd1 <sys_net_receive>:
  801fd1:	55                   	push   %rbp
  801fd2:	48 89 e5             	mov    %rsp,%rbp
  801fd5:	48 83 ec 20          	sub    $0x20,%rsp
  801fd9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801fdd:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801fe0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801fe3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801fe7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fee:	00 
  801fef:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ff5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ffb:	48 89 d1             	mov    %rdx,%rcx
  801ffe:	48 89 c2             	mov    %rax,%rdx
  802001:	be 00 00 00 00       	mov    $0x0,%esi
  802006:	bf 10 00 00 00       	mov    $0x10,%edi
  80200b:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  802012:	00 00 00 
  802015:	ff d0                	callq  *%rax
  802017:	c9                   	leaveq 
  802018:	c3                   	retq   

0000000000802019 <sys_ept_map>:
  802019:	55                   	push   %rbp
  80201a:	48 89 e5             	mov    %rsp,%rbp
  80201d:	48 83 ec 30          	sub    $0x30,%rsp
  802021:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802024:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802028:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80202b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80202f:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802033:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802036:	48 63 c8             	movslq %eax,%rcx
  802039:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  80203d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802040:	48 63 f0             	movslq %eax,%rsi
  802043:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802047:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80204a:	48 98                	cltq   
  80204c:	48 89 0c 24          	mov    %rcx,(%rsp)
  802050:	49 89 f9             	mov    %rdi,%r9
  802053:	49 89 f0             	mov    %rsi,%r8
  802056:	48 89 d1             	mov    %rdx,%rcx
  802059:	48 89 c2             	mov    %rax,%rdx
  80205c:	be 00 00 00 00       	mov    $0x0,%esi
  802061:	bf 11 00 00 00       	mov    $0x11,%edi
  802066:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  80206d:	00 00 00 
  802070:	ff d0                	callq  *%rax
  802072:	c9                   	leaveq 
  802073:	c3                   	retq   

0000000000802074 <sys_env_mkguest>:
  802074:	55                   	push   %rbp
  802075:	48 89 e5             	mov    %rsp,%rbp
  802078:	48 83 ec 20          	sub    $0x20,%rsp
  80207c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802080:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802084:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802088:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80208c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802093:	00 
  802094:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80209a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020a0:	48 89 d1             	mov    %rdx,%rcx
  8020a3:	48 89 c2             	mov    %rax,%rdx
  8020a6:	be 00 00 00 00       	mov    $0x0,%esi
  8020ab:	bf 12 00 00 00       	mov    $0x12,%edi
  8020b0:	48 b8 08 1b 80 00 00 	movabs $0x801b08,%rax
  8020b7:	00 00 00 
  8020ba:	ff d0                	callq  *%rax
  8020bc:	c9                   	leaveq 
  8020bd:	c3                   	retq   

00000000008020be <argstart>:
  8020be:	55                   	push   %rbp
  8020bf:	48 89 e5             	mov    %rsp,%rbp
  8020c2:	48 83 ec 18          	sub    $0x18,%rsp
  8020c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8020ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8020ce:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8020d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020d6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8020da:	48 89 10             	mov    %rdx,(%rax)
  8020dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8020e5:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8020e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8020ed:	8b 00                	mov    (%rax),%eax
  8020ef:	83 f8 01             	cmp    $0x1,%eax
  8020f2:	7e 13                	jle    802107 <argstart+0x49>
  8020f4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
  8020f9:	74 0c                	je     802107 <argstart+0x49>
  8020fb:	48 b8 16 50 80 00 00 	movabs $0x805016,%rax
  802102:	00 00 00 
  802105:	eb 05                	jmp    80210c <argstart+0x4e>
  802107:	b8 00 00 00 00       	mov    $0x0,%eax
  80210c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802110:	48 89 42 10          	mov    %rax,0x10(%rdx)
  802114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802118:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  80211f:	00 
  802120:	c9                   	leaveq 
  802121:	c3                   	retq   

0000000000802122 <argnext>:
  802122:	55                   	push   %rbp
  802123:	48 89 e5             	mov    %rsp,%rbp
  802126:	48 83 ec 20          	sub    $0x20,%rsp
  80212a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80212e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802132:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  802139:	00 
  80213a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80213e:	48 8b 40 10          	mov    0x10(%rax),%rax
  802142:	48 85 c0             	test   %rax,%rax
  802145:	75 0a                	jne    802151 <argnext+0x2f>
  802147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  80214c:	e9 25 01 00 00       	jmpq   802276 <argnext+0x154>
  802151:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802155:	48 8b 40 10          	mov    0x10(%rax),%rax
  802159:	0f b6 00             	movzbl (%rax),%eax
  80215c:	84 c0                	test   %al,%al
  80215e:	0f 85 d7 00 00 00    	jne    80223b <argnext+0x119>
  802164:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802168:	48 8b 00             	mov    (%rax),%rax
  80216b:	8b 00                	mov    (%rax),%eax
  80216d:	83 f8 01             	cmp    $0x1,%eax
  802170:	0f 84 ef 00 00 00    	je     802265 <argnext+0x143>
  802176:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80217a:	48 8b 40 08          	mov    0x8(%rax),%rax
  80217e:	48 83 c0 08          	add    $0x8,%rax
  802182:	48 8b 00             	mov    (%rax),%rax
  802185:	0f b6 00             	movzbl (%rax),%eax
  802188:	3c 2d                	cmp    $0x2d,%al
  80218a:	0f 85 d5 00 00 00    	jne    802265 <argnext+0x143>
  802190:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802194:	48 8b 40 08          	mov    0x8(%rax),%rax
  802198:	48 83 c0 08          	add    $0x8,%rax
  80219c:	48 8b 00             	mov    (%rax),%rax
  80219f:	48 83 c0 01          	add    $0x1,%rax
  8021a3:	0f b6 00             	movzbl (%rax),%eax
  8021a6:	84 c0                	test   %al,%al
  8021a8:	0f 84 b7 00 00 00    	je     802265 <argnext+0x143>
  8021ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021b2:	48 8b 40 08          	mov    0x8(%rax),%rax
  8021b6:	48 83 c0 08          	add    $0x8,%rax
  8021ba:	48 8b 00             	mov    (%rax),%rax
  8021bd:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8021c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021c5:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8021c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021cd:	48 8b 00             	mov    (%rax),%rax
  8021d0:	8b 00                	mov    (%rax),%eax
  8021d2:	83 e8 01             	sub    $0x1,%eax
  8021d5:	48 98                	cltq   
  8021d7:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8021de:	00 
  8021df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021e3:	48 8b 40 08          	mov    0x8(%rax),%rax
  8021e7:	48 8d 48 10          	lea    0x10(%rax),%rcx
  8021eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021ef:	48 8b 40 08          	mov    0x8(%rax),%rax
  8021f3:	48 83 c0 08          	add    $0x8,%rax
  8021f7:	48 89 ce             	mov    %rcx,%rsi
  8021fa:	48 89 c7             	mov    %rax,%rdi
  8021fd:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  802204:	00 00 00 
  802207:	ff d0                	callq  *%rax
  802209:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80220d:	48 8b 00             	mov    (%rax),%rax
  802210:	8b 10                	mov    (%rax),%edx
  802212:	83 ea 01             	sub    $0x1,%edx
  802215:	89 10                	mov    %edx,(%rax)
  802217:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80221b:	48 8b 40 10          	mov    0x10(%rax),%rax
  80221f:	0f b6 00             	movzbl (%rax),%eax
  802222:	3c 2d                	cmp    $0x2d,%al
  802224:	75 15                	jne    80223b <argnext+0x119>
  802226:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80222a:	48 8b 40 10          	mov    0x10(%rax),%rax
  80222e:	48 83 c0 01          	add    $0x1,%rax
  802232:	0f b6 00             	movzbl (%rax),%eax
  802235:	84 c0                	test   %al,%al
  802237:	75 02                	jne    80223b <argnext+0x119>
  802239:	eb 2a                	jmp    802265 <argnext+0x143>
  80223b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80223f:	48 8b 40 10          	mov    0x10(%rax),%rax
  802243:	0f b6 00             	movzbl (%rax),%eax
  802246:	0f b6 c0             	movzbl %al,%eax
  802249:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80224c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802250:	48 8b 40 10          	mov    0x10(%rax),%rax
  802254:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802258:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80225c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  802260:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802263:	eb 11                	jmp    802276 <argnext+0x154>
  802265:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802269:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  802270:	00 
  802271:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  802276:	c9                   	leaveq 
  802277:	c3                   	retq   

0000000000802278 <argvalue>:
  802278:	55                   	push   %rbp
  802279:	48 89 e5             	mov    %rsp,%rbp
  80227c:	48 83 ec 10          	sub    $0x10,%rsp
  802280:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802288:	48 8b 40 18          	mov    0x18(%rax),%rax
  80228c:	48 85 c0             	test   %rax,%rax
  80228f:	74 0a                	je     80229b <argvalue+0x23>
  802291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802295:	48 8b 40 18          	mov    0x18(%rax),%rax
  802299:	eb 13                	jmp    8022ae <argvalue+0x36>
  80229b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80229f:	48 89 c7             	mov    %rax,%rdi
  8022a2:	48 b8 b0 22 80 00 00 	movabs $0x8022b0,%rax
  8022a9:	00 00 00 
  8022ac:	ff d0                	callq  *%rax
  8022ae:	c9                   	leaveq 
  8022af:	c3                   	retq   

00000000008022b0 <argnextvalue>:
  8022b0:	55                   	push   %rbp
  8022b1:	48 89 e5             	mov    %rsp,%rbp
  8022b4:	53                   	push   %rbx
  8022b5:	48 83 ec 18          	sub    $0x18,%rsp
  8022b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8022bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022c1:	48 8b 40 10          	mov    0x10(%rax),%rax
  8022c5:	48 85 c0             	test   %rax,%rax
  8022c8:	75 0a                	jne    8022d4 <argnextvalue+0x24>
  8022ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8022cf:	e9 c8 00 00 00       	jmpq   80239c <argnextvalue+0xec>
  8022d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022d8:	48 8b 40 10          	mov    0x10(%rax),%rax
  8022dc:	0f b6 00             	movzbl (%rax),%eax
  8022df:	84 c0                	test   %al,%al
  8022e1:	74 27                	je     80230a <argnextvalue+0x5a>
  8022e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022e7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8022eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022ef:	48 89 50 18          	mov    %rdx,0x18(%rax)
  8022f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022f7:	48 bb 16 50 80 00 00 	movabs $0x805016,%rbx
  8022fe:	00 00 00 
  802301:	48 89 58 10          	mov    %rbx,0x10(%rax)
  802305:	e9 8a 00 00 00       	jmpq   802394 <argnextvalue+0xe4>
  80230a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80230e:	48 8b 00             	mov    (%rax),%rax
  802311:	8b 00                	mov    (%rax),%eax
  802313:	83 f8 01             	cmp    $0x1,%eax
  802316:	7e 64                	jle    80237c <argnextvalue+0xcc>
  802318:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80231c:	48 8b 40 08          	mov    0x8(%rax),%rax
  802320:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802324:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802328:	48 89 50 18          	mov    %rdx,0x18(%rax)
  80232c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802330:	48 8b 00             	mov    (%rax),%rax
  802333:	8b 00                	mov    (%rax),%eax
  802335:	83 e8 01             	sub    $0x1,%eax
  802338:	48 98                	cltq   
  80233a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  802341:	00 
  802342:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802346:	48 8b 40 08          	mov    0x8(%rax),%rax
  80234a:	48 8d 48 10          	lea    0x10(%rax),%rcx
  80234e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802352:	48 8b 40 08          	mov    0x8(%rax),%rax
  802356:	48 83 c0 08          	add    $0x8,%rax
  80235a:	48 89 ce             	mov    %rcx,%rsi
  80235d:	48 89 c7             	mov    %rax,%rdi
  802360:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  802367:	00 00 00 
  80236a:	ff d0                	callq  *%rax
  80236c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802370:	48 8b 00             	mov    (%rax),%rax
  802373:	8b 10                	mov    (%rax),%edx
  802375:	83 ea 01             	sub    $0x1,%edx
  802378:	89 10                	mov    %edx,(%rax)
  80237a:	eb 18                	jmp    802394 <argnextvalue+0xe4>
  80237c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802380:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  802387:	00 
  802388:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80238c:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  802393:	00 
  802394:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802398:	48 8b 40 18          	mov    0x18(%rax),%rax
  80239c:	48 83 c4 18          	add    $0x18,%rsp
  8023a0:	5b                   	pop    %rbx
  8023a1:	5d                   	pop    %rbp
  8023a2:	c3                   	retq   

00000000008023a3 <fd2num>:
  8023a3:	55                   	push   %rbp
  8023a4:	48 89 e5             	mov    %rsp,%rbp
  8023a7:	48 83 ec 08          	sub    $0x8,%rsp
  8023ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8023af:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8023b3:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8023ba:	ff ff ff 
  8023bd:	48 01 d0             	add    %rdx,%rax
  8023c0:	48 c1 e8 0c          	shr    $0xc,%rax
  8023c4:	c9                   	leaveq 
  8023c5:	c3                   	retq   

00000000008023c6 <fd2data>:
  8023c6:	55                   	push   %rbp
  8023c7:	48 89 e5             	mov    %rsp,%rbp
  8023ca:	48 83 ec 08          	sub    $0x8,%rsp
  8023ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8023d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023d6:	48 89 c7             	mov    %rax,%rdi
  8023d9:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  8023e0:	00 00 00 
  8023e3:	ff d0                	callq  *%rax
  8023e5:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  8023eb:	48 c1 e0 0c          	shl    $0xc,%rax
  8023ef:	c9                   	leaveq 
  8023f0:	c3                   	retq   

00000000008023f1 <fd_alloc>:
  8023f1:	55                   	push   %rbp
  8023f2:	48 89 e5             	mov    %rsp,%rbp
  8023f5:	48 83 ec 18          	sub    $0x18,%rsp
  8023f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8023fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802404:	eb 6b                	jmp    802471 <fd_alloc+0x80>
  802406:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802409:	48 98                	cltq   
  80240b:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802411:	48 c1 e0 0c          	shl    $0xc,%rax
  802415:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802419:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80241d:	48 c1 e8 15          	shr    $0x15,%rax
  802421:	48 89 c2             	mov    %rax,%rdx
  802424:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80242b:	01 00 00 
  80242e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802432:	83 e0 01             	and    $0x1,%eax
  802435:	48 85 c0             	test   %rax,%rax
  802438:	74 21                	je     80245b <fd_alloc+0x6a>
  80243a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80243e:	48 c1 e8 0c          	shr    $0xc,%rax
  802442:	48 89 c2             	mov    %rax,%rdx
  802445:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80244c:	01 00 00 
  80244f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802453:	83 e0 01             	and    $0x1,%eax
  802456:	48 85 c0             	test   %rax,%rax
  802459:	75 12                	jne    80246d <fd_alloc+0x7c>
  80245b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80245f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802463:	48 89 10             	mov    %rdx,(%rax)
  802466:	b8 00 00 00 00       	mov    $0x0,%eax
  80246b:	eb 1a                	jmp    802487 <fd_alloc+0x96>
  80246d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802471:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802475:	7e 8f                	jle    802406 <fd_alloc+0x15>
  802477:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80247b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802482:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802487:	c9                   	leaveq 
  802488:	c3                   	retq   

0000000000802489 <fd_lookup>:
  802489:	55                   	push   %rbp
  80248a:	48 89 e5             	mov    %rsp,%rbp
  80248d:	48 83 ec 20          	sub    $0x20,%rsp
  802491:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802494:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802498:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80249c:	78 06                	js     8024a4 <fd_lookup+0x1b>
  80249e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8024a2:	7e 07                	jle    8024ab <fd_lookup+0x22>
  8024a4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024a9:	eb 6c                	jmp    802517 <fd_lookup+0x8e>
  8024ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024ae:	48 98                	cltq   
  8024b0:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8024b6:	48 c1 e0 0c          	shl    $0xc,%rax
  8024ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8024be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024c2:	48 c1 e8 15          	shr    $0x15,%rax
  8024c6:	48 89 c2             	mov    %rax,%rdx
  8024c9:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8024d0:	01 00 00 
  8024d3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8024d7:	83 e0 01             	and    $0x1,%eax
  8024da:	48 85 c0             	test   %rax,%rax
  8024dd:	74 21                	je     802500 <fd_lookup+0x77>
  8024df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024e3:	48 c1 e8 0c          	shr    $0xc,%rax
  8024e7:	48 89 c2             	mov    %rax,%rdx
  8024ea:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8024f1:	01 00 00 
  8024f4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8024f8:	83 e0 01             	and    $0x1,%eax
  8024fb:	48 85 c0             	test   %rax,%rax
  8024fe:	75 07                	jne    802507 <fd_lookup+0x7e>
  802500:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802505:	eb 10                	jmp    802517 <fd_lookup+0x8e>
  802507:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80250b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80250f:	48 89 10             	mov    %rdx,(%rax)
  802512:	b8 00 00 00 00       	mov    $0x0,%eax
  802517:	c9                   	leaveq 
  802518:	c3                   	retq   

0000000000802519 <fd_close>:
  802519:	55                   	push   %rbp
  80251a:	48 89 e5             	mov    %rsp,%rbp
  80251d:	48 83 ec 30          	sub    $0x30,%rsp
  802521:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802525:	89 f0                	mov    %esi,%eax
  802527:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80252a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80252e:	48 89 c7             	mov    %rax,%rdi
  802531:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  802538:	00 00 00 
  80253b:	ff d0                	callq  *%rax
  80253d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802541:	48 89 d6             	mov    %rdx,%rsi
  802544:	89 c7                	mov    %eax,%edi
  802546:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  80254d:	00 00 00 
  802550:	ff d0                	callq  *%rax
  802552:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802555:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802559:	78 0a                	js     802565 <fd_close+0x4c>
  80255b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80255f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  802563:	74 12                	je     802577 <fd_close+0x5e>
  802565:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802569:	74 05                	je     802570 <fd_close+0x57>
  80256b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80256e:	eb 05                	jmp    802575 <fd_close+0x5c>
  802570:	b8 00 00 00 00       	mov    $0x0,%eax
  802575:	eb 69                	jmp    8025e0 <fd_close+0xc7>
  802577:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80257b:	8b 00                	mov    (%rax),%eax
  80257d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802581:	48 89 d6             	mov    %rdx,%rsi
  802584:	89 c7                	mov    %eax,%edi
  802586:	48 b8 e2 25 80 00 00 	movabs $0x8025e2,%rax
  80258d:	00 00 00 
  802590:	ff d0                	callq  *%rax
  802592:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802595:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802599:	78 2a                	js     8025c5 <fd_close+0xac>
  80259b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80259f:	48 8b 40 20          	mov    0x20(%rax),%rax
  8025a3:	48 85 c0             	test   %rax,%rax
  8025a6:	74 16                	je     8025be <fd_close+0xa5>
  8025a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025ac:	48 8b 40 20          	mov    0x20(%rax),%rax
  8025b0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8025b4:	48 89 d7             	mov    %rdx,%rdi
  8025b7:	ff d0                	callq  *%rax
  8025b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025bc:	eb 07                	jmp    8025c5 <fd_close+0xac>
  8025be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8025c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025c9:	48 89 c6             	mov    %rax,%rsi
  8025cc:	bf 00 00 00 00       	mov    $0x0,%edi
  8025d1:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  8025d8:	00 00 00 
  8025db:	ff d0                	callq  *%rax
  8025dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025e0:	c9                   	leaveq 
  8025e1:	c3                   	retq   

00000000008025e2 <dev_lookup>:
  8025e2:	55                   	push   %rbp
  8025e3:	48 89 e5             	mov    %rsp,%rbp
  8025e6:	48 83 ec 20          	sub    $0x20,%rsp
  8025ea:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8025ed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8025f8:	eb 41                	jmp    80263b <dev_lookup+0x59>
  8025fa:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802601:	00 00 00 
  802604:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802607:	48 63 d2             	movslq %edx,%rdx
  80260a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80260e:	8b 00                	mov    (%rax),%eax
  802610:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802613:	75 22                	jne    802637 <dev_lookup+0x55>
  802615:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80261c:	00 00 00 
  80261f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802622:	48 63 d2             	movslq %edx,%rdx
  802625:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802629:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80262d:	48 89 10             	mov    %rdx,(%rax)
  802630:	b8 00 00 00 00       	mov    $0x0,%eax
  802635:	eb 60                	jmp    802697 <dev_lookup+0xb5>
  802637:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80263b:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802642:	00 00 00 
  802645:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802648:	48 63 d2             	movslq %edx,%rdx
  80264b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80264f:	48 85 c0             	test   %rax,%rax
  802652:	75 a6                	jne    8025fa <dev_lookup+0x18>
  802654:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  80265b:	00 00 00 
  80265e:	48 8b 00             	mov    (%rax),%rax
  802661:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802667:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80266a:	89 c6                	mov    %eax,%esi
  80266c:	48 bf 18 50 80 00 00 	movabs $0x805018,%rdi
  802673:	00 00 00 
  802676:	b8 00 00 00 00       	mov    $0x0,%eax
  80267b:	48 b9 fa 07 80 00 00 	movabs $0x8007fa,%rcx
  802682:	00 00 00 
  802685:	ff d1                	callq  *%rcx
  802687:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80268b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802692:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802697:	c9                   	leaveq 
  802698:	c3                   	retq   

0000000000802699 <close>:
  802699:	55                   	push   %rbp
  80269a:	48 89 e5             	mov    %rsp,%rbp
  80269d:	48 83 ec 20          	sub    $0x20,%rsp
  8026a1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8026a4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8026a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8026ab:	48 89 d6             	mov    %rdx,%rsi
  8026ae:	89 c7                	mov    %eax,%edi
  8026b0:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  8026b7:	00 00 00 
  8026ba:	ff d0                	callq  *%rax
  8026bc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026c3:	79 05                	jns    8026ca <close+0x31>
  8026c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026c8:	eb 18                	jmp    8026e2 <close+0x49>
  8026ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026ce:	be 01 00 00 00       	mov    $0x1,%esi
  8026d3:	48 89 c7             	mov    %rax,%rdi
  8026d6:	48 b8 19 25 80 00 00 	movabs $0x802519,%rax
  8026dd:	00 00 00 
  8026e0:	ff d0                	callq  *%rax
  8026e2:	c9                   	leaveq 
  8026e3:	c3                   	retq   

00000000008026e4 <close_all>:
  8026e4:	55                   	push   %rbp
  8026e5:	48 89 e5             	mov    %rsp,%rbp
  8026e8:	48 83 ec 10          	sub    $0x10,%rsp
  8026ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8026f3:	eb 15                	jmp    80270a <close_all+0x26>
  8026f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026f8:	89 c7                	mov    %eax,%edi
  8026fa:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  802701:	00 00 00 
  802704:	ff d0                	callq  *%rax
  802706:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80270a:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80270e:	7e e5                	jle    8026f5 <close_all+0x11>
  802710:	c9                   	leaveq 
  802711:	c3                   	retq   

0000000000802712 <dup>:
  802712:	55                   	push   %rbp
  802713:	48 89 e5             	mov    %rsp,%rbp
  802716:	48 83 ec 40          	sub    $0x40,%rsp
  80271a:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80271d:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802720:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802724:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802727:	48 89 d6             	mov    %rdx,%rsi
  80272a:	89 c7                	mov    %eax,%edi
  80272c:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  802733:	00 00 00 
  802736:	ff d0                	callq  *%rax
  802738:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80273b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80273f:	79 08                	jns    802749 <dup+0x37>
  802741:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802744:	e9 70 01 00 00       	jmpq   8028b9 <dup+0x1a7>
  802749:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80274c:	89 c7                	mov    %eax,%edi
  80274e:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  802755:	00 00 00 
  802758:	ff d0                	callq  *%rax
  80275a:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80275d:	48 98                	cltq   
  80275f:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802765:	48 c1 e0 0c          	shl    $0xc,%rax
  802769:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80276d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802771:	48 89 c7             	mov    %rax,%rdi
  802774:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  80277b:	00 00 00 
  80277e:	ff d0                	callq  *%rax
  802780:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802784:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802788:	48 89 c7             	mov    %rax,%rdi
  80278b:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  802792:	00 00 00 
  802795:	ff d0                	callq  *%rax
  802797:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80279b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80279f:	48 c1 e8 15          	shr    $0x15,%rax
  8027a3:	48 89 c2             	mov    %rax,%rdx
  8027a6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8027ad:	01 00 00 
  8027b0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8027b4:	83 e0 01             	and    $0x1,%eax
  8027b7:	48 85 c0             	test   %rax,%rax
  8027ba:	74 73                	je     80282f <dup+0x11d>
  8027bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027c0:	48 c1 e8 0c          	shr    $0xc,%rax
  8027c4:	48 89 c2             	mov    %rax,%rdx
  8027c7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8027ce:	01 00 00 
  8027d1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8027d5:	83 e0 01             	and    $0x1,%eax
  8027d8:	48 85 c0             	test   %rax,%rax
  8027db:	74 52                	je     80282f <dup+0x11d>
  8027dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027e1:	48 c1 e8 0c          	shr    $0xc,%rax
  8027e5:	48 89 c2             	mov    %rax,%rdx
  8027e8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8027ef:	01 00 00 
  8027f2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8027f6:	25 07 0e 00 00       	and    $0xe07,%eax
  8027fb:	89 c1                	mov    %eax,%ecx
  8027fd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802801:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802805:	41 89 c8             	mov    %ecx,%r8d
  802808:	48 89 d1             	mov    %rdx,%rcx
  80280b:	ba 00 00 00 00       	mov    $0x0,%edx
  802810:	48 89 c6             	mov    %rax,%rsi
  802813:	bf 00 00 00 00       	mov    $0x0,%edi
  802818:	48 b8 2e 1d 80 00 00 	movabs $0x801d2e,%rax
  80281f:	00 00 00 
  802822:	ff d0                	callq  *%rax
  802824:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802827:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80282b:	79 02                	jns    80282f <dup+0x11d>
  80282d:	eb 57                	jmp    802886 <dup+0x174>
  80282f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802833:	48 c1 e8 0c          	shr    $0xc,%rax
  802837:	48 89 c2             	mov    %rax,%rdx
  80283a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802841:	01 00 00 
  802844:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802848:	25 07 0e 00 00       	and    $0xe07,%eax
  80284d:	89 c1                	mov    %eax,%ecx
  80284f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802853:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802857:	41 89 c8             	mov    %ecx,%r8d
  80285a:	48 89 d1             	mov    %rdx,%rcx
  80285d:	ba 00 00 00 00       	mov    $0x0,%edx
  802862:	48 89 c6             	mov    %rax,%rsi
  802865:	bf 00 00 00 00       	mov    $0x0,%edi
  80286a:	48 b8 2e 1d 80 00 00 	movabs $0x801d2e,%rax
  802871:	00 00 00 
  802874:	ff d0                	callq  *%rax
  802876:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802879:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80287d:	79 02                	jns    802881 <dup+0x16f>
  80287f:	eb 05                	jmp    802886 <dup+0x174>
  802881:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802884:	eb 33                	jmp    8028b9 <dup+0x1a7>
  802886:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80288a:	48 89 c6             	mov    %rax,%rsi
  80288d:	bf 00 00 00 00       	mov    $0x0,%edi
  802892:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  802899:	00 00 00 
  80289c:	ff d0                	callq  *%rax
  80289e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028a2:	48 89 c6             	mov    %rax,%rsi
  8028a5:	bf 00 00 00 00       	mov    $0x0,%edi
  8028aa:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  8028b1:	00 00 00 
  8028b4:	ff d0                	callq  *%rax
  8028b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028b9:	c9                   	leaveq 
  8028ba:	c3                   	retq   

00000000008028bb <read>:
  8028bb:	55                   	push   %rbp
  8028bc:	48 89 e5             	mov    %rsp,%rbp
  8028bf:	48 83 ec 40          	sub    $0x40,%rsp
  8028c3:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8028c6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8028ca:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8028ce:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8028d2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8028d5:	48 89 d6             	mov    %rdx,%rsi
  8028d8:	89 c7                	mov    %eax,%edi
  8028da:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  8028e1:	00 00 00 
  8028e4:	ff d0                	callq  *%rax
  8028e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028ed:	78 24                	js     802913 <read+0x58>
  8028ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028f3:	8b 00                	mov    (%rax),%eax
  8028f5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028f9:	48 89 d6             	mov    %rdx,%rsi
  8028fc:	89 c7                	mov    %eax,%edi
  8028fe:	48 b8 e2 25 80 00 00 	movabs $0x8025e2,%rax
  802905:	00 00 00 
  802908:	ff d0                	callq  *%rax
  80290a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80290d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802911:	79 05                	jns    802918 <read+0x5d>
  802913:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802916:	eb 76                	jmp    80298e <read+0xd3>
  802918:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80291c:	8b 40 08             	mov    0x8(%rax),%eax
  80291f:	83 e0 03             	and    $0x3,%eax
  802922:	83 f8 01             	cmp    $0x1,%eax
  802925:	75 3a                	jne    802961 <read+0xa6>
  802927:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  80292e:	00 00 00 
  802931:	48 8b 00             	mov    (%rax),%rax
  802934:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80293a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80293d:	89 c6                	mov    %eax,%esi
  80293f:	48 bf 37 50 80 00 00 	movabs $0x805037,%rdi
  802946:	00 00 00 
  802949:	b8 00 00 00 00       	mov    $0x0,%eax
  80294e:	48 b9 fa 07 80 00 00 	movabs $0x8007fa,%rcx
  802955:	00 00 00 
  802958:	ff d1                	callq  *%rcx
  80295a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80295f:	eb 2d                	jmp    80298e <read+0xd3>
  802961:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802965:	48 8b 40 10          	mov    0x10(%rax),%rax
  802969:	48 85 c0             	test   %rax,%rax
  80296c:	75 07                	jne    802975 <read+0xba>
  80296e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802973:	eb 19                	jmp    80298e <read+0xd3>
  802975:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802979:	48 8b 40 10          	mov    0x10(%rax),%rax
  80297d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802981:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802985:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802989:	48 89 cf             	mov    %rcx,%rdi
  80298c:	ff d0                	callq  *%rax
  80298e:	c9                   	leaveq 
  80298f:	c3                   	retq   

0000000000802990 <readn>:
  802990:	55                   	push   %rbp
  802991:	48 89 e5             	mov    %rsp,%rbp
  802994:	48 83 ec 30          	sub    $0x30,%rsp
  802998:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80299b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80299f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8029a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8029aa:	eb 49                	jmp    8029f5 <readn+0x65>
  8029ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029af:	48 98                	cltq   
  8029b1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8029b5:	48 29 c2             	sub    %rax,%rdx
  8029b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029bb:	48 63 c8             	movslq %eax,%rcx
  8029be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029c2:	48 01 c1             	add    %rax,%rcx
  8029c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8029c8:	48 89 ce             	mov    %rcx,%rsi
  8029cb:	89 c7                	mov    %eax,%edi
  8029cd:	48 b8 bb 28 80 00 00 	movabs $0x8028bb,%rax
  8029d4:	00 00 00 
  8029d7:	ff d0                	callq  *%rax
  8029d9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8029dc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8029e0:	79 05                	jns    8029e7 <readn+0x57>
  8029e2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8029e5:	eb 1c                	jmp    802a03 <readn+0x73>
  8029e7:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8029eb:	75 02                	jne    8029ef <readn+0x5f>
  8029ed:	eb 11                	jmp    802a00 <readn+0x70>
  8029ef:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8029f2:	01 45 fc             	add    %eax,-0x4(%rbp)
  8029f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029f8:	48 98                	cltq   
  8029fa:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8029fe:	72 ac                	jb     8029ac <readn+0x1c>
  802a00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a03:	c9                   	leaveq 
  802a04:	c3                   	retq   

0000000000802a05 <write>:
  802a05:	55                   	push   %rbp
  802a06:	48 89 e5             	mov    %rsp,%rbp
  802a09:	48 83 ec 40          	sub    $0x40,%rsp
  802a0d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802a10:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802a14:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802a18:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802a1c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a1f:	48 89 d6             	mov    %rdx,%rsi
  802a22:	89 c7                	mov    %eax,%edi
  802a24:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  802a2b:	00 00 00 
  802a2e:	ff d0                	callq  *%rax
  802a30:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a33:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a37:	78 24                	js     802a5d <write+0x58>
  802a39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a3d:	8b 00                	mov    (%rax),%eax
  802a3f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a43:	48 89 d6             	mov    %rdx,%rsi
  802a46:	89 c7                	mov    %eax,%edi
  802a48:	48 b8 e2 25 80 00 00 	movabs $0x8025e2,%rax
  802a4f:	00 00 00 
  802a52:	ff d0                	callq  *%rax
  802a54:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a57:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a5b:	79 05                	jns    802a62 <write+0x5d>
  802a5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a60:	eb 75                	jmp    802ad7 <write+0xd2>
  802a62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a66:	8b 40 08             	mov    0x8(%rax),%eax
  802a69:	83 e0 03             	and    $0x3,%eax
  802a6c:	85 c0                	test   %eax,%eax
  802a6e:	75 3a                	jne    802aaa <write+0xa5>
  802a70:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802a77:	00 00 00 
  802a7a:	48 8b 00             	mov    (%rax),%rax
  802a7d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a83:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802a86:	89 c6                	mov    %eax,%esi
  802a88:	48 bf 53 50 80 00 00 	movabs $0x805053,%rdi
  802a8f:	00 00 00 
  802a92:	b8 00 00 00 00       	mov    $0x0,%eax
  802a97:	48 b9 fa 07 80 00 00 	movabs $0x8007fa,%rcx
  802a9e:	00 00 00 
  802aa1:	ff d1                	callq  *%rcx
  802aa3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802aa8:	eb 2d                	jmp    802ad7 <write+0xd2>
  802aaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802aae:	48 8b 40 18          	mov    0x18(%rax),%rax
  802ab2:	48 85 c0             	test   %rax,%rax
  802ab5:	75 07                	jne    802abe <write+0xb9>
  802ab7:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802abc:	eb 19                	jmp    802ad7 <write+0xd2>
  802abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ac2:	48 8b 40 18          	mov    0x18(%rax),%rax
  802ac6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802aca:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ace:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802ad2:	48 89 cf             	mov    %rcx,%rdi
  802ad5:	ff d0                	callq  *%rax
  802ad7:	c9                   	leaveq 
  802ad8:	c3                   	retq   

0000000000802ad9 <seek>:
  802ad9:	55                   	push   %rbp
  802ada:	48 89 e5             	mov    %rsp,%rbp
  802add:	48 83 ec 18          	sub    $0x18,%rsp
  802ae1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ae4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802ae7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802aeb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802aee:	48 89 d6             	mov    %rdx,%rsi
  802af1:	89 c7                	mov    %eax,%edi
  802af3:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  802afa:	00 00 00 
  802afd:	ff d0                	callq  *%rax
  802aff:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b02:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b06:	79 05                	jns    802b0d <seek+0x34>
  802b08:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b0b:	eb 0f                	jmp    802b1c <seek+0x43>
  802b0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b11:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802b14:	89 50 04             	mov    %edx,0x4(%rax)
  802b17:	b8 00 00 00 00       	mov    $0x0,%eax
  802b1c:	c9                   	leaveq 
  802b1d:	c3                   	retq   

0000000000802b1e <ftruncate>:
  802b1e:	55                   	push   %rbp
  802b1f:	48 89 e5             	mov    %rsp,%rbp
  802b22:	48 83 ec 30          	sub    $0x30,%rsp
  802b26:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802b29:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802b2c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802b30:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802b33:	48 89 d6             	mov    %rdx,%rsi
  802b36:	89 c7                	mov    %eax,%edi
  802b38:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  802b3f:	00 00 00 
  802b42:	ff d0                	callq  *%rax
  802b44:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b47:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b4b:	78 24                	js     802b71 <ftruncate+0x53>
  802b4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b51:	8b 00                	mov    (%rax),%eax
  802b53:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b57:	48 89 d6             	mov    %rdx,%rsi
  802b5a:	89 c7                	mov    %eax,%edi
  802b5c:	48 b8 e2 25 80 00 00 	movabs $0x8025e2,%rax
  802b63:	00 00 00 
  802b66:	ff d0                	callq  *%rax
  802b68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b6f:	79 05                	jns    802b76 <ftruncate+0x58>
  802b71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b74:	eb 72                	jmp    802be8 <ftruncate+0xca>
  802b76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b7a:	8b 40 08             	mov    0x8(%rax),%eax
  802b7d:	83 e0 03             	and    $0x3,%eax
  802b80:	85 c0                	test   %eax,%eax
  802b82:	75 3a                	jne    802bbe <ftruncate+0xa0>
  802b84:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  802b8b:	00 00 00 
  802b8e:	48 8b 00             	mov    (%rax),%rax
  802b91:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802b97:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802b9a:	89 c6                	mov    %eax,%esi
  802b9c:	48 bf 70 50 80 00 00 	movabs $0x805070,%rdi
  802ba3:	00 00 00 
  802ba6:	b8 00 00 00 00       	mov    $0x0,%eax
  802bab:	48 b9 fa 07 80 00 00 	movabs $0x8007fa,%rcx
  802bb2:	00 00 00 
  802bb5:	ff d1                	callq  *%rcx
  802bb7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802bbc:	eb 2a                	jmp    802be8 <ftruncate+0xca>
  802bbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bc2:	48 8b 40 30          	mov    0x30(%rax),%rax
  802bc6:	48 85 c0             	test   %rax,%rax
  802bc9:	75 07                	jne    802bd2 <ftruncate+0xb4>
  802bcb:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802bd0:	eb 16                	jmp    802be8 <ftruncate+0xca>
  802bd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bd6:	48 8b 40 30          	mov    0x30(%rax),%rax
  802bda:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802bde:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802be1:	89 ce                	mov    %ecx,%esi
  802be3:	48 89 d7             	mov    %rdx,%rdi
  802be6:	ff d0                	callq  *%rax
  802be8:	c9                   	leaveq 
  802be9:	c3                   	retq   

0000000000802bea <fstat>:
  802bea:	55                   	push   %rbp
  802beb:	48 89 e5             	mov    %rsp,%rbp
  802bee:	48 83 ec 30          	sub    $0x30,%rsp
  802bf2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802bf5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802bf9:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802bfd:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c00:	48 89 d6             	mov    %rdx,%rsi
  802c03:	89 c7                	mov    %eax,%edi
  802c05:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  802c0c:	00 00 00 
  802c0f:	ff d0                	callq  *%rax
  802c11:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c14:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c18:	78 24                	js     802c3e <fstat+0x54>
  802c1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c1e:	8b 00                	mov    (%rax),%eax
  802c20:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c24:	48 89 d6             	mov    %rdx,%rsi
  802c27:	89 c7                	mov    %eax,%edi
  802c29:	48 b8 e2 25 80 00 00 	movabs $0x8025e2,%rax
  802c30:	00 00 00 
  802c33:	ff d0                	callq  *%rax
  802c35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c38:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c3c:	79 05                	jns    802c43 <fstat+0x59>
  802c3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c41:	eb 5e                	jmp    802ca1 <fstat+0xb7>
  802c43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c47:	48 8b 40 28          	mov    0x28(%rax),%rax
  802c4b:	48 85 c0             	test   %rax,%rax
  802c4e:	75 07                	jne    802c57 <fstat+0x6d>
  802c50:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802c55:	eb 4a                	jmp    802ca1 <fstat+0xb7>
  802c57:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802c5b:	c6 00 00             	movb   $0x0,(%rax)
  802c5e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802c62:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802c69:	00 00 00 
  802c6c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802c70:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802c77:	00 00 00 
  802c7a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c7e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802c82:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802c89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c8d:	48 8b 40 28          	mov    0x28(%rax),%rax
  802c91:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c95:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802c99:	48 89 ce             	mov    %rcx,%rsi
  802c9c:	48 89 d7             	mov    %rdx,%rdi
  802c9f:	ff d0                	callq  *%rax
  802ca1:	c9                   	leaveq 
  802ca2:	c3                   	retq   

0000000000802ca3 <stat>:
  802ca3:	55                   	push   %rbp
  802ca4:	48 89 e5             	mov    %rsp,%rbp
  802ca7:	48 83 ec 20          	sub    $0x20,%rsp
  802cab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802caf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802cb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cb7:	be 00 00 00 00       	mov    $0x0,%esi
  802cbc:	48 89 c7             	mov    %rax,%rdi
  802cbf:	48 b8 91 2d 80 00 00 	movabs $0x802d91,%rax
  802cc6:	00 00 00 
  802cc9:	ff d0                	callq  *%rax
  802ccb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cce:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cd2:	79 05                	jns    802cd9 <stat+0x36>
  802cd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cd7:	eb 2f                	jmp    802d08 <stat+0x65>
  802cd9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802cdd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ce0:	48 89 d6             	mov    %rdx,%rsi
  802ce3:	89 c7                	mov    %eax,%edi
  802ce5:	48 b8 ea 2b 80 00 00 	movabs $0x802bea,%rax
  802cec:	00 00 00 
  802cef:	ff d0                	callq  *%rax
  802cf1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802cf4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cf7:	89 c7                	mov    %eax,%edi
  802cf9:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  802d00:	00 00 00 
  802d03:	ff d0                	callq  *%rax
  802d05:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d08:	c9                   	leaveq 
  802d09:	c3                   	retq   

0000000000802d0a <fsipc>:
  802d0a:	55                   	push   %rbp
  802d0b:	48 89 e5             	mov    %rsp,%rbp
  802d0e:	48 83 ec 10          	sub    $0x10,%rsp
  802d12:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802d15:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802d19:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802d20:	00 00 00 
  802d23:	8b 00                	mov    (%rax),%eax
  802d25:	85 c0                	test   %eax,%eax
  802d27:	75 1d                	jne    802d46 <fsipc+0x3c>
  802d29:	bf 01 00 00 00       	mov    $0x1,%edi
  802d2e:	48 b8 26 49 80 00 00 	movabs $0x804926,%rax
  802d35:	00 00 00 
  802d38:	ff d0                	callq  *%rax
  802d3a:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802d41:	00 00 00 
  802d44:	89 02                	mov    %eax,(%rdx)
  802d46:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802d4d:	00 00 00 
  802d50:	8b 00                	mov    (%rax),%eax
  802d52:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802d55:	b9 07 00 00 00       	mov    $0x7,%ecx
  802d5a:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802d61:	00 00 00 
  802d64:	89 c7                	mov    %eax,%edi
  802d66:	48 b8 1b 48 80 00 00 	movabs $0x80481b,%rax
  802d6d:	00 00 00 
  802d70:	ff d0                	callq  *%rax
  802d72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d76:	ba 00 00 00 00       	mov    $0x0,%edx
  802d7b:	48 89 c6             	mov    %rax,%rsi
  802d7e:	bf 00 00 00 00       	mov    $0x0,%edi
  802d83:	48 b8 5a 47 80 00 00 	movabs $0x80475a,%rax
  802d8a:	00 00 00 
  802d8d:	ff d0                	callq  *%rax
  802d8f:	c9                   	leaveq 
  802d90:	c3                   	retq   

0000000000802d91 <open>:
  802d91:	55                   	push   %rbp
  802d92:	48 89 e5             	mov    %rsp,%rbp
  802d95:	48 83 ec 20          	sub    $0x20,%rsp
  802d99:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802d9d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802da0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802da4:	48 89 c7             	mov    %rax,%rdi
  802da7:	48 b8 43 13 80 00 00 	movabs $0x801343,%rax
  802dae:	00 00 00 
  802db1:	ff d0                	callq  *%rax
  802db3:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802db8:	7e 0a                	jle    802dc4 <open+0x33>
  802dba:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802dbf:	e9 a5 00 00 00       	jmpq   802e69 <open+0xd8>
  802dc4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802dc8:	48 89 c7             	mov    %rax,%rdi
  802dcb:	48 b8 f1 23 80 00 00 	movabs $0x8023f1,%rax
  802dd2:	00 00 00 
  802dd5:	ff d0                	callq  *%rax
  802dd7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802dda:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dde:	79 08                	jns    802de8 <open+0x57>
  802de0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802de3:	e9 81 00 00 00       	jmpq   802e69 <open+0xd8>
  802de8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dec:	48 89 c6             	mov    %rax,%rsi
  802def:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802df6:	00 00 00 
  802df9:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  802e00:	00 00 00 
  802e03:	ff d0                	callq  *%rax
  802e05:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802e0c:	00 00 00 
  802e0f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802e12:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802e18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e1c:	48 89 c6             	mov    %rax,%rsi
  802e1f:	bf 01 00 00 00       	mov    $0x1,%edi
  802e24:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  802e2b:	00 00 00 
  802e2e:	ff d0                	callq  *%rax
  802e30:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e33:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e37:	79 1d                	jns    802e56 <open+0xc5>
  802e39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e3d:	be 00 00 00 00       	mov    $0x0,%esi
  802e42:	48 89 c7             	mov    %rax,%rdi
  802e45:	48 b8 19 25 80 00 00 	movabs $0x802519,%rax
  802e4c:	00 00 00 
  802e4f:	ff d0                	callq  *%rax
  802e51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e54:	eb 13                	jmp    802e69 <open+0xd8>
  802e56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e5a:	48 89 c7             	mov    %rax,%rdi
  802e5d:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  802e64:	00 00 00 
  802e67:	ff d0                	callq  *%rax
  802e69:	c9                   	leaveq 
  802e6a:	c3                   	retq   

0000000000802e6b <devfile_flush>:
  802e6b:	55                   	push   %rbp
  802e6c:	48 89 e5             	mov    %rsp,%rbp
  802e6f:	48 83 ec 10          	sub    $0x10,%rsp
  802e73:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e7b:	8b 50 0c             	mov    0xc(%rax),%edx
  802e7e:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802e85:	00 00 00 
  802e88:	89 10                	mov    %edx,(%rax)
  802e8a:	be 00 00 00 00       	mov    $0x0,%esi
  802e8f:	bf 06 00 00 00       	mov    $0x6,%edi
  802e94:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  802e9b:	00 00 00 
  802e9e:	ff d0                	callq  *%rax
  802ea0:	c9                   	leaveq 
  802ea1:	c3                   	retq   

0000000000802ea2 <devfile_read>:
  802ea2:	55                   	push   %rbp
  802ea3:	48 89 e5             	mov    %rsp,%rbp
  802ea6:	48 83 ec 30          	sub    $0x30,%rsp
  802eaa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802eae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802eb2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802eb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802eba:	8b 50 0c             	mov    0xc(%rax),%edx
  802ebd:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802ec4:	00 00 00 
  802ec7:	89 10                	mov    %edx,(%rax)
  802ec9:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802ed0:	00 00 00 
  802ed3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802ed7:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802edb:	be 00 00 00 00       	mov    $0x0,%esi
  802ee0:	bf 03 00 00 00       	mov    $0x3,%edi
  802ee5:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  802eec:	00 00 00 
  802eef:	ff d0                	callq  *%rax
  802ef1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ef4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ef8:	79 08                	jns    802f02 <devfile_read+0x60>
  802efa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802efd:	e9 a4 00 00 00       	jmpq   802fa6 <devfile_read+0x104>
  802f02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f05:	48 98                	cltq   
  802f07:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802f0b:	76 35                	jbe    802f42 <devfile_read+0xa0>
  802f0d:	48 b9 96 50 80 00 00 	movabs $0x805096,%rcx
  802f14:	00 00 00 
  802f17:	48 ba 9d 50 80 00 00 	movabs $0x80509d,%rdx
  802f1e:	00 00 00 
  802f21:	be 89 00 00 00       	mov    $0x89,%esi
  802f26:	48 bf b2 50 80 00 00 	movabs $0x8050b2,%rdi
  802f2d:	00 00 00 
  802f30:	b8 00 00 00 00       	mov    $0x0,%eax
  802f35:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  802f3c:	00 00 00 
  802f3f:	41 ff d0             	callq  *%r8
  802f42:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802f49:	7e 35                	jle    802f80 <devfile_read+0xde>
  802f4b:	48 b9 c0 50 80 00 00 	movabs $0x8050c0,%rcx
  802f52:	00 00 00 
  802f55:	48 ba 9d 50 80 00 00 	movabs $0x80509d,%rdx
  802f5c:	00 00 00 
  802f5f:	be 8a 00 00 00       	mov    $0x8a,%esi
  802f64:	48 bf b2 50 80 00 00 	movabs $0x8050b2,%rdi
  802f6b:	00 00 00 
  802f6e:	b8 00 00 00 00       	mov    $0x0,%eax
  802f73:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  802f7a:	00 00 00 
  802f7d:	41 ff d0             	callq  *%r8
  802f80:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f83:	48 63 d0             	movslq %eax,%rdx
  802f86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f8a:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  802f91:	00 00 00 
  802f94:	48 89 c7             	mov    %rax,%rdi
  802f97:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  802f9e:	00 00 00 
  802fa1:	ff d0                	callq  *%rax
  802fa3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fa6:	c9                   	leaveq 
  802fa7:	c3                   	retq   

0000000000802fa8 <devfile_write>:
  802fa8:	55                   	push   %rbp
  802fa9:	48 89 e5             	mov    %rsp,%rbp
  802fac:	48 83 ec 40          	sub    $0x40,%rsp
  802fb0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802fb4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802fb8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802fbc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802fc0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802fc4:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802fcb:	00 
  802fcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fd0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802fd4:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802fd9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802fdd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802fe1:	8b 50 0c             	mov    0xc(%rax),%edx
  802fe4:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802feb:	00 00 00 
  802fee:	89 10                	mov    %edx,(%rax)
  802ff0:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802ff7:	00 00 00 
  802ffa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ffe:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803002:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803006:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80300a:	48 89 c6             	mov    %rax,%rsi
  80300d:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  803014:	00 00 00 
  803017:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  80301e:	00 00 00 
  803021:	ff d0                	callq  *%rax
  803023:	be 00 00 00 00       	mov    $0x0,%esi
  803028:	bf 04 00 00 00       	mov    $0x4,%edi
  80302d:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  803034:	00 00 00 
  803037:	ff d0                	callq  *%rax
  803039:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80303c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803040:	79 05                	jns    803047 <devfile_write+0x9f>
  803042:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803045:	eb 43                	jmp    80308a <devfile_write+0xe2>
  803047:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80304a:	48 98                	cltq   
  80304c:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803050:	76 35                	jbe    803087 <devfile_write+0xdf>
  803052:	48 b9 96 50 80 00 00 	movabs $0x805096,%rcx
  803059:	00 00 00 
  80305c:	48 ba 9d 50 80 00 00 	movabs $0x80509d,%rdx
  803063:	00 00 00 
  803066:	be a8 00 00 00       	mov    $0xa8,%esi
  80306b:	48 bf b2 50 80 00 00 	movabs $0x8050b2,%rdi
  803072:	00 00 00 
  803075:	b8 00 00 00 00       	mov    $0x0,%eax
  80307a:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  803081:	00 00 00 
  803084:	41 ff d0             	callq  *%r8
  803087:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80308a:	c9                   	leaveq 
  80308b:	c3                   	retq   

000000000080308c <devfile_stat>:
  80308c:	55                   	push   %rbp
  80308d:	48 89 e5             	mov    %rsp,%rbp
  803090:	48 83 ec 20          	sub    $0x20,%rsp
  803094:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803098:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80309c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030a0:	8b 50 0c             	mov    0xc(%rax),%edx
  8030a3:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030aa:	00 00 00 
  8030ad:	89 10                	mov    %edx,(%rax)
  8030af:	be 00 00 00 00       	mov    $0x0,%esi
  8030b4:	bf 05 00 00 00       	mov    $0x5,%edi
  8030b9:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  8030c0:	00 00 00 
  8030c3:	ff d0                	callq  *%rax
  8030c5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030cc:	79 05                	jns    8030d3 <devfile_stat+0x47>
  8030ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030d1:	eb 56                	jmp    803129 <devfile_stat+0x9d>
  8030d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8030d7:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8030de:	00 00 00 
  8030e1:	48 89 c7             	mov    %rax,%rdi
  8030e4:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  8030eb:	00 00 00 
  8030ee:	ff d0                	callq  *%rax
  8030f0:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030f7:	00 00 00 
  8030fa:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803100:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803104:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80310a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803111:	00 00 00 
  803114:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80311a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80311e:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803124:	b8 00 00 00 00       	mov    $0x0,%eax
  803129:	c9                   	leaveq 
  80312a:	c3                   	retq   

000000000080312b <devfile_trunc>:
  80312b:	55                   	push   %rbp
  80312c:	48 89 e5             	mov    %rsp,%rbp
  80312f:	48 83 ec 10          	sub    $0x10,%rsp
  803133:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803137:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80313a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80313e:	8b 50 0c             	mov    0xc(%rax),%edx
  803141:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803148:	00 00 00 
  80314b:	89 10                	mov    %edx,(%rax)
  80314d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803154:	00 00 00 
  803157:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80315a:	89 50 04             	mov    %edx,0x4(%rax)
  80315d:	be 00 00 00 00       	mov    $0x0,%esi
  803162:	bf 02 00 00 00       	mov    $0x2,%edi
  803167:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  80316e:	00 00 00 
  803171:	ff d0                	callq  *%rax
  803173:	c9                   	leaveq 
  803174:	c3                   	retq   

0000000000803175 <remove>:
  803175:	55                   	push   %rbp
  803176:	48 89 e5             	mov    %rsp,%rbp
  803179:	48 83 ec 10          	sub    $0x10,%rsp
  80317d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803181:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803185:	48 89 c7             	mov    %rax,%rdi
  803188:	48 b8 43 13 80 00 00 	movabs $0x801343,%rax
  80318f:	00 00 00 
  803192:	ff d0                	callq  *%rax
  803194:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803199:	7e 07                	jle    8031a2 <remove+0x2d>
  80319b:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8031a0:	eb 33                	jmp    8031d5 <remove+0x60>
  8031a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8031a6:	48 89 c6             	mov    %rax,%rsi
  8031a9:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8031b0:	00 00 00 
  8031b3:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  8031ba:	00 00 00 
  8031bd:	ff d0                	callq  *%rax
  8031bf:	be 00 00 00 00       	mov    $0x0,%esi
  8031c4:	bf 07 00 00 00       	mov    $0x7,%edi
  8031c9:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  8031d0:	00 00 00 
  8031d3:	ff d0                	callq  *%rax
  8031d5:	c9                   	leaveq 
  8031d6:	c3                   	retq   

00000000008031d7 <sync>:
  8031d7:	55                   	push   %rbp
  8031d8:	48 89 e5             	mov    %rsp,%rbp
  8031db:	be 00 00 00 00       	mov    $0x0,%esi
  8031e0:	bf 08 00 00 00       	mov    $0x8,%edi
  8031e5:	48 b8 0a 2d 80 00 00 	movabs $0x802d0a,%rax
  8031ec:	00 00 00 
  8031ef:	ff d0                	callq  *%rax
  8031f1:	5d                   	pop    %rbp
  8031f2:	c3                   	retq   

00000000008031f3 <copy>:
  8031f3:	55                   	push   %rbp
  8031f4:	48 89 e5             	mov    %rsp,%rbp
  8031f7:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8031fe:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  803205:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80320c:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803213:	be 00 00 00 00       	mov    $0x0,%esi
  803218:	48 89 c7             	mov    %rax,%rdi
  80321b:	48 b8 91 2d 80 00 00 	movabs $0x802d91,%rax
  803222:	00 00 00 
  803225:	ff d0                	callq  *%rax
  803227:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80322a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80322e:	79 28                	jns    803258 <copy+0x65>
  803230:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803233:	89 c6                	mov    %eax,%esi
  803235:	48 bf cc 50 80 00 00 	movabs $0x8050cc,%rdi
  80323c:	00 00 00 
  80323f:	b8 00 00 00 00       	mov    $0x0,%eax
  803244:	48 ba fa 07 80 00 00 	movabs $0x8007fa,%rdx
  80324b:	00 00 00 
  80324e:	ff d2                	callq  *%rdx
  803250:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803253:	e9 74 01 00 00       	jmpq   8033cc <copy+0x1d9>
  803258:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  80325f:	be 01 01 00 00       	mov    $0x101,%esi
  803264:	48 89 c7             	mov    %rax,%rdi
  803267:	48 b8 91 2d 80 00 00 	movabs $0x802d91,%rax
  80326e:	00 00 00 
  803271:	ff d0                	callq  *%rax
  803273:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803276:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80327a:	79 39                	jns    8032b5 <copy+0xc2>
  80327c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80327f:	89 c6                	mov    %eax,%esi
  803281:	48 bf e2 50 80 00 00 	movabs $0x8050e2,%rdi
  803288:	00 00 00 
  80328b:	b8 00 00 00 00       	mov    $0x0,%eax
  803290:	48 ba fa 07 80 00 00 	movabs $0x8007fa,%rdx
  803297:	00 00 00 
  80329a:	ff d2                	callq  *%rdx
  80329c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80329f:	89 c7                	mov    %eax,%edi
  8032a1:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  8032a8:	00 00 00 
  8032ab:	ff d0                	callq  *%rax
  8032ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8032b0:	e9 17 01 00 00       	jmpq   8033cc <copy+0x1d9>
  8032b5:	eb 74                	jmp    80332b <copy+0x138>
  8032b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8032ba:	48 63 d0             	movslq %eax,%rdx
  8032bd:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8032c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8032c7:	48 89 ce             	mov    %rcx,%rsi
  8032ca:	89 c7                	mov    %eax,%edi
  8032cc:	48 b8 05 2a 80 00 00 	movabs $0x802a05,%rax
  8032d3:	00 00 00 
  8032d6:	ff d0                	callq  *%rax
  8032d8:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8032db:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8032df:	79 4a                	jns    80332b <copy+0x138>
  8032e1:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8032e4:	89 c6                	mov    %eax,%esi
  8032e6:	48 bf fc 50 80 00 00 	movabs $0x8050fc,%rdi
  8032ed:	00 00 00 
  8032f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8032f5:	48 ba fa 07 80 00 00 	movabs $0x8007fa,%rdx
  8032fc:	00 00 00 
  8032ff:	ff d2                	callq  *%rdx
  803301:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803304:	89 c7                	mov    %eax,%edi
  803306:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  80330d:	00 00 00 
  803310:	ff d0                	callq  *%rax
  803312:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803315:	89 c7                	mov    %eax,%edi
  803317:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  80331e:	00 00 00 
  803321:	ff d0                	callq  *%rax
  803323:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803326:	e9 a1 00 00 00       	jmpq   8033cc <copy+0x1d9>
  80332b:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803332:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803335:	ba 00 02 00 00       	mov    $0x200,%edx
  80333a:	48 89 ce             	mov    %rcx,%rsi
  80333d:	89 c7                	mov    %eax,%edi
  80333f:	48 b8 bb 28 80 00 00 	movabs $0x8028bb,%rax
  803346:	00 00 00 
  803349:	ff d0                	callq  *%rax
  80334b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80334e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803352:	0f 8f 5f ff ff ff    	jg     8032b7 <copy+0xc4>
  803358:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80335c:	79 47                	jns    8033a5 <copy+0x1b2>
  80335e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803361:	89 c6                	mov    %eax,%esi
  803363:	48 bf 0f 51 80 00 00 	movabs $0x80510f,%rdi
  80336a:	00 00 00 
  80336d:	b8 00 00 00 00       	mov    $0x0,%eax
  803372:	48 ba fa 07 80 00 00 	movabs $0x8007fa,%rdx
  803379:	00 00 00 
  80337c:	ff d2                	callq  *%rdx
  80337e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803381:	89 c7                	mov    %eax,%edi
  803383:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  80338a:	00 00 00 
  80338d:	ff d0                	callq  *%rax
  80338f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803392:	89 c7                	mov    %eax,%edi
  803394:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  80339b:	00 00 00 
  80339e:	ff d0                	callq  *%rax
  8033a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8033a3:	eb 27                	jmp    8033cc <copy+0x1d9>
  8033a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033a8:	89 c7                	mov    %eax,%edi
  8033aa:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  8033b1:	00 00 00 
  8033b4:	ff d0                	callq  *%rax
  8033b6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033b9:	89 c7                	mov    %eax,%edi
  8033bb:	48 b8 99 26 80 00 00 	movabs $0x802699,%rax
  8033c2:	00 00 00 
  8033c5:	ff d0                	callq  *%rax
  8033c7:	b8 00 00 00 00       	mov    $0x0,%eax
  8033cc:	c9                   	leaveq 
  8033cd:	c3                   	retq   

00000000008033ce <writebuf>:
  8033ce:	55                   	push   %rbp
  8033cf:	48 89 e5             	mov    %rsp,%rbp
  8033d2:	48 83 ec 20          	sub    $0x20,%rsp
  8033d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8033da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033de:	8b 40 0c             	mov    0xc(%rax),%eax
  8033e1:	85 c0                	test   %eax,%eax
  8033e3:	7e 67                	jle    80344c <writebuf+0x7e>
  8033e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033e9:	8b 40 04             	mov    0x4(%rax),%eax
  8033ec:	48 63 d0             	movslq %eax,%rdx
  8033ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033f3:	48 8d 48 10          	lea    0x10(%rax),%rcx
  8033f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033fb:	8b 00                	mov    (%rax),%eax
  8033fd:	48 89 ce             	mov    %rcx,%rsi
  803400:	89 c7                	mov    %eax,%edi
  803402:	48 b8 05 2a 80 00 00 	movabs $0x802a05,%rax
  803409:	00 00 00 
  80340c:	ff d0                	callq  *%rax
  80340e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803411:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803415:	7e 13                	jle    80342a <writebuf+0x5c>
  803417:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80341b:	8b 50 08             	mov    0x8(%rax),%edx
  80341e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803421:	01 c2                	add    %eax,%edx
  803423:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803427:	89 50 08             	mov    %edx,0x8(%rax)
  80342a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80342e:	8b 40 04             	mov    0x4(%rax),%eax
  803431:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  803434:	74 16                	je     80344c <writebuf+0x7e>
  803436:	b8 00 00 00 00       	mov    $0x0,%eax
  80343b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80343f:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  803443:	89 c2                	mov    %eax,%edx
  803445:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803449:	89 50 0c             	mov    %edx,0xc(%rax)
  80344c:	c9                   	leaveq 
  80344d:	c3                   	retq   

000000000080344e <putch>:
  80344e:	55                   	push   %rbp
  80344f:	48 89 e5             	mov    %rsp,%rbp
  803452:	48 83 ec 20          	sub    $0x20,%rsp
  803456:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803459:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80345d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803461:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803465:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803469:	8b 40 04             	mov    0x4(%rax),%eax
  80346c:	8d 48 01             	lea    0x1(%rax),%ecx
  80346f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803473:	89 4a 04             	mov    %ecx,0x4(%rdx)
  803476:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803479:	89 d1                	mov    %edx,%ecx
  80347b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80347f:	48 98                	cltq   
  803481:	88 4c 02 10          	mov    %cl,0x10(%rdx,%rax,1)
  803485:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803489:	8b 40 04             	mov    0x4(%rax),%eax
  80348c:	3d 00 01 00 00       	cmp    $0x100,%eax
  803491:	75 1e                	jne    8034b1 <putch+0x63>
  803493:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803497:	48 89 c7             	mov    %rax,%rdi
  80349a:	48 b8 ce 33 80 00 00 	movabs $0x8033ce,%rax
  8034a1:	00 00 00 
  8034a4:	ff d0                	callq  *%rax
  8034a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8034aa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  8034b1:	c9                   	leaveq 
  8034b2:	c3                   	retq   

00000000008034b3 <vfprintf>:
  8034b3:	55                   	push   %rbp
  8034b4:	48 89 e5             	mov    %rsp,%rbp
  8034b7:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  8034be:	89 bd ec fe ff ff    	mov    %edi,-0x114(%rbp)
  8034c4:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  8034cb:	48 89 95 d8 fe ff ff 	mov    %rdx,-0x128(%rbp)
  8034d2:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  8034d8:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%rbp)
  8034de:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8034e5:	00 00 00 
  8034e8:	c7 85 f8 fe ff ff 00 	movl   $0x0,-0x108(%rbp)
  8034ef:	00 00 00 
  8034f2:	c7 85 fc fe ff ff 01 	movl   $0x1,-0x104(%rbp)
  8034f9:	00 00 00 
  8034fc:	48 8b 8d d8 fe ff ff 	mov    -0x128(%rbp),%rcx
  803503:	48 8b 95 e0 fe ff ff 	mov    -0x120(%rbp),%rdx
  80350a:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  803511:	48 89 c6             	mov    %rax,%rsi
  803514:	48 bf 4e 34 80 00 00 	movabs $0x80344e,%rdi
  80351b:	00 00 00 
  80351e:	48 b8 ad 0b 80 00 00 	movabs $0x800bad,%rax
  803525:	00 00 00 
  803528:	ff d0                	callq  *%rax
  80352a:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  803530:	85 c0                	test   %eax,%eax
  803532:	7e 16                	jle    80354a <vfprintf+0x97>
  803534:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  80353b:	48 89 c7             	mov    %rax,%rdi
  80353e:	48 b8 ce 33 80 00 00 	movabs $0x8033ce,%rax
  803545:	00 00 00 
  803548:	ff d0                	callq  *%rax
  80354a:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  803550:	85 c0                	test   %eax,%eax
  803552:	74 08                	je     80355c <vfprintf+0xa9>
  803554:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  80355a:	eb 06                	jmp    803562 <vfprintf+0xaf>
  80355c:	8b 85 fc fe ff ff    	mov    -0x104(%rbp),%eax
  803562:	c9                   	leaveq 
  803563:	c3                   	retq   

0000000000803564 <fprintf>:
  803564:	55                   	push   %rbp
  803565:	48 89 e5             	mov    %rsp,%rbp
  803568:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  80356f:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%rbp)
  803575:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80357c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803583:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80358a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803591:	84 c0                	test   %al,%al
  803593:	74 20                	je     8035b5 <fprintf+0x51>
  803595:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803599:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80359d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8035a1:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8035a5:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8035a9:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8035ad:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8035b1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8035b5:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  8035bc:	c7 85 30 ff ff ff 10 	movl   $0x10,-0xd0(%rbp)
  8035c3:	00 00 00 
  8035c6:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8035cd:	00 00 00 
  8035d0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8035d4:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8035db:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8035e2:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8035e9:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8035f0:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
  8035f7:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8035fd:	48 89 ce             	mov    %rcx,%rsi
  803600:	89 c7                	mov    %eax,%edi
  803602:	48 b8 b3 34 80 00 00 	movabs $0x8034b3,%rax
  803609:	00 00 00 
  80360c:	ff d0                	callq  *%rax
  80360e:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  803614:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80361a:	c9                   	leaveq 
  80361b:	c3                   	retq   

000000000080361c <printf>:
  80361c:	55                   	push   %rbp
  80361d:	48 89 e5             	mov    %rsp,%rbp
  803620:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  803627:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80362e:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  803635:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80363c:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803643:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80364a:	84 c0                	test   %al,%al
  80364c:	74 20                	je     80366e <printf+0x52>
  80364e:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803652:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803656:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80365a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80365e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803662:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803666:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80366a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80366e:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  803675:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80367c:	00 00 00 
  80367f:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803686:	00 00 00 
  803689:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80368d:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803694:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80369b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8036a2:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8036a9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  8036b0:	48 89 c6             	mov    %rax,%rsi
  8036b3:	bf 01 00 00 00       	mov    $0x1,%edi
  8036b8:	48 b8 b3 34 80 00 00 	movabs $0x8034b3,%rax
  8036bf:	00 00 00 
  8036c2:	ff d0                	callq  *%rax
  8036c4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8036ca:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8036d0:	c9                   	leaveq 
  8036d1:	c3                   	retq   

00000000008036d2 <fd2sockid>:
  8036d2:	55                   	push   %rbp
  8036d3:	48 89 e5             	mov    %rsp,%rbp
  8036d6:	48 83 ec 20          	sub    $0x20,%rsp
  8036da:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036dd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8036e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036e4:	48 89 d6             	mov    %rdx,%rsi
  8036e7:	89 c7                	mov    %eax,%edi
  8036e9:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  8036f0:	00 00 00 
  8036f3:	ff d0                	callq  *%rax
  8036f5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036fc:	79 05                	jns    803703 <fd2sockid+0x31>
  8036fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803701:	eb 24                	jmp    803727 <fd2sockid+0x55>
  803703:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803707:	8b 10                	mov    (%rax),%edx
  803709:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803710:	00 00 00 
  803713:	8b 00                	mov    (%rax),%eax
  803715:	39 c2                	cmp    %eax,%edx
  803717:	74 07                	je     803720 <fd2sockid+0x4e>
  803719:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80371e:	eb 07                	jmp    803727 <fd2sockid+0x55>
  803720:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803724:	8b 40 0c             	mov    0xc(%rax),%eax
  803727:	c9                   	leaveq 
  803728:	c3                   	retq   

0000000000803729 <alloc_sockfd>:
  803729:	55                   	push   %rbp
  80372a:	48 89 e5             	mov    %rsp,%rbp
  80372d:	48 83 ec 20          	sub    $0x20,%rsp
  803731:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803734:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803738:	48 89 c7             	mov    %rax,%rdi
  80373b:	48 b8 f1 23 80 00 00 	movabs $0x8023f1,%rax
  803742:	00 00 00 
  803745:	ff d0                	callq  *%rax
  803747:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80374a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80374e:	78 26                	js     803776 <alloc_sockfd+0x4d>
  803750:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803754:	ba 07 04 00 00       	mov    $0x407,%edx
  803759:	48 89 c6             	mov    %rax,%rsi
  80375c:	bf 00 00 00 00       	mov    $0x0,%edi
  803761:	48 b8 de 1c 80 00 00 	movabs $0x801cde,%rax
  803768:	00 00 00 
  80376b:	ff d0                	callq  *%rax
  80376d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803770:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803774:	79 16                	jns    80378c <alloc_sockfd+0x63>
  803776:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803779:	89 c7                	mov    %eax,%edi
  80377b:	48 b8 36 3c 80 00 00 	movabs $0x803c36,%rax
  803782:	00 00 00 
  803785:	ff d0                	callq  *%rax
  803787:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80378a:	eb 3a                	jmp    8037c6 <alloc_sockfd+0x9d>
  80378c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803790:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  803797:	00 00 00 
  80379a:	8b 12                	mov    (%rdx),%edx
  80379c:	89 10                	mov    %edx,(%rax)
  80379e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037a2:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8037a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037ad:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8037b0:	89 50 0c             	mov    %edx,0xc(%rax)
  8037b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037b7:	48 89 c7             	mov    %rax,%rdi
  8037ba:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  8037c1:	00 00 00 
  8037c4:	ff d0                	callq  *%rax
  8037c6:	c9                   	leaveq 
  8037c7:	c3                   	retq   

00000000008037c8 <accept>:
  8037c8:	55                   	push   %rbp
  8037c9:	48 89 e5             	mov    %rsp,%rbp
  8037cc:	48 83 ec 30          	sub    $0x30,%rsp
  8037d0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8037d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8037d7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8037db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037de:	89 c7                	mov    %eax,%edi
  8037e0:	48 b8 d2 36 80 00 00 	movabs $0x8036d2,%rax
  8037e7:	00 00 00 
  8037ea:	ff d0                	callq  *%rax
  8037ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037f3:	79 05                	jns    8037fa <accept+0x32>
  8037f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037f8:	eb 3b                	jmp    803835 <accept+0x6d>
  8037fa:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8037fe:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803802:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803805:	48 89 ce             	mov    %rcx,%rsi
  803808:	89 c7                	mov    %eax,%edi
  80380a:	48 b8 13 3b 80 00 00 	movabs $0x803b13,%rax
  803811:	00 00 00 
  803814:	ff d0                	callq  *%rax
  803816:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803819:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80381d:	79 05                	jns    803824 <accept+0x5c>
  80381f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803822:	eb 11                	jmp    803835 <accept+0x6d>
  803824:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803827:	89 c7                	mov    %eax,%edi
  803829:	48 b8 29 37 80 00 00 	movabs $0x803729,%rax
  803830:	00 00 00 
  803833:	ff d0                	callq  *%rax
  803835:	c9                   	leaveq 
  803836:	c3                   	retq   

0000000000803837 <bind>:
  803837:	55                   	push   %rbp
  803838:	48 89 e5             	mov    %rsp,%rbp
  80383b:	48 83 ec 20          	sub    $0x20,%rsp
  80383f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803842:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803846:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803849:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80384c:	89 c7                	mov    %eax,%edi
  80384e:	48 b8 d2 36 80 00 00 	movabs $0x8036d2,%rax
  803855:	00 00 00 
  803858:	ff d0                	callq  *%rax
  80385a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80385d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803861:	79 05                	jns    803868 <bind+0x31>
  803863:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803866:	eb 1b                	jmp    803883 <bind+0x4c>
  803868:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80386b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80386f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803872:	48 89 ce             	mov    %rcx,%rsi
  803875:	89 c7                	mov    %eax,%edi
  803877:	48 b8 92 3b 80 00 00 	movabs $0x803b92,%rax
  80387e:	00 00 00 
  803881:	ff d0                	callq  *%rax
  803883:	c9                   	leaveq 
  803884:	c3                   	retq   

0000000000803885 <shutdown>:
  803885:	55                   	push   %rbp
  803886:	48 89 e5             	mov    %rsp,%rbp
  803889:	48 83 ec 20          	sub    $0x20,%rsp
  80388d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803890:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803893:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803896:	89 c7                	mov    %eax,%edi
  803898:	48 b8 d2 36 80 00 00 	movabs $0x8036d2,%rax
  80389f:	00 00 00 
  8038a2:	ff d0                	callq  *%rax
  8038a4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038ab:	79 05                	jns    8038b2 <shutdown+0x2d>
  8038ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b0:	eb 16                	jmp    8038c8 <shutdown+0x43>
  8038b2:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8038b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b8:	89 d6                	mov    %edx,%esi
  8038ba:	89 c7                	mov    %eax,%edi
  8038bc:	48 b8 f6 3b 80 00 00 	movabs $0x803bf6,%rax
  8038c3:	00 00 00 
  8038c6:	ff d0                	callq  *%rax
  8038c8:	c9                   	leaveq 
  8038c9:	c3                   	retq   

00000000008038ca <devsock_close>:
  8038ca:	55                   	push   %rbp
  8038cb:	48 89 e5             	mov    %rsp,%rbp
  8038ce:	48 83 ec 10          	sub    $0x10,%rsp
  8038d2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8038d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038da:	48 89 c7             	mov    %rax,%rdi
  8038dd:	48 b8 98 49 80 00 00 	movabs $0x804998,%rax
  8038e4:	00 00 00 
  8038e7:	ff d0                	callq  *%rax
  8038e9:	83 f8 01             	cmp    $0x1,%eax
  8038ec:	75 17                	jne    803905 <devsock_close+0x3b>
  8038ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038f2:	8b 40 0c             	mov    0xc(%rax),%eax
  8038f5:	89 c7                	mov    %eax,%edi
  8038f7:	48 b8 36 3c 80 00 00 	movabs $0x803c36,%rax
  8038fe:	00 00 00 
  803901:	ff d0                	callq  *%rax
  803903:	eb 05                	jmp    80390a <devsock_close+0x40>
  803905:	b8 00 00 00 00       	mov    $0x0,%eax
  80390a:	c9                   	leaveq 
  80390b:	c3                   	retq   

000000000080390c <connect>:
  80390c:	55                   	push   %rbp
  80390d:	48 89 e5             	mov    %rsp,%rbp
  803910:	48 83 ec 20          	sub    $0x20,%rsp
  803914:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803917:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80391b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80391e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803921:	89 c7                	mov    %eax,%edi
  803923:	48 b8 d2 36 80 00 00 	movabs $0x8036d2,%rax
  80392a:	00 00 00 
  80392d:	ff d0                	callq  *%rax
  80392f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803932:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803936:	79 05                	jns    80393d <connect+0x31>
  803938:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80393b:	eb 1b                	jmp    803958 <connect+0x4c>
  80393d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803940:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803944:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803947:	48 89 ce             	mov    %rcx,%rsi
  80394a:	89 c7                	mov    %eax,%edi
  80394c:	48 b8 63 3c 80 00 00 	movabs $0x803c63,%rax
  803953:	00 00 00 
  803956:	ff d0                	callq  *%rax
  803958:	c9                   	leaveq 
  803959:	c3                   	retq   

000000000080395a <listen>:
  80395a:	55                   	push   %rbp
  80395b:	48 89 e5             	mov    %rsp,%rbp
  80395e:	48 83 ec 20          	sub    $0x20,%rsp
  803962:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803965:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803968:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80396b:	89 c7                	mov    %eax,%edi
  80396d:	48 b8 d2 36 80 00 00 	movabs $0x8036d2,%rax
  803974:	00 00 00 
  803977:	ff d0                	callq  *%rax
  803979:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80397c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803980:	79 05                	jns    803987 <listen+0x2d>
  803982:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803985:	eb 16                	jmp    80399d <listen+0x43>
  803987:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80398a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80398d:	89 d6                	mov    %edx,%esi
  80398f:	89 c7                	mov    %eax,%edi
  803991:	48 b8 c7 3c 80 00 00 	movabs $0x803cc7,%rax
  803998:	00 00 00 
  80399b:	ff d0                	callq  *%rax
  80399d:	c9                   	leaveq 
  80399e:	c3                   	retq   

000000000080399f <devsock_read>:
  80399f:	55                   	push   %rbp
  8039a0:	48 89 e5             	mov    %rsp,%rbp
  8039a3:	48 83 ec 20          	sub    $0x20,%rsp
  8039a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8039ab:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039af:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8039b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039b7:	89 c2                	mov    %eax,%edx
  8039b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039bd:	8b 40 0c             	mov    0xc(%rax),%eax
  8039c0:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8039c4:	b9 00 00 00 00       	mov    $0x0,%ecx
  8039c9:	89 c7                	mov    %eax,%edi
  8039cb:	48 b8 07 3d 80 00 00 	movabs $0x803d07,%rax
  8039d2:	00 00 00 
  8039d5:	ff d0                	callq  *%rax
  8039d7:	c9                   	leaveq 
  8039d8:	c3                   	retq   

00000000008039d9 <devsock_write>:
  8039d9:	55                   	push   %rbp
  8039da:	48 89 e5             	mov    %rsp,%rbp
  8039dd:	48 83 ec 20          	sub    $0x20,%rsp
  8039e1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8039e5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039e9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8039ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039f1:	89 c2                	mov    %eax,%edx
  8039f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039f7:	8b 40 0c             	mov    0xc(%rax),%eax
  8039fa:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8039fe:	b9 00 00 00 00       	mov    $0x0,%ecx
  803a03:	89 c7                	mov    %eax,%edi
  803a05:	48 b8 d3 3d 80 00 00 	movabs $0x803dd3,%rax
  803a0c:	00 00 00 
  803a0f:	ff d0                	callq  *%rax
  803a11:	c9                   	leaveq 
  803a12:	c3                   	retq   

0000000000803a13 <devsock_stat>:
  803a13:	55                   	push   %rbp
  803a14:	48 89 e5             	mov    %rsp,%rbp
  803a17:	48 83 ec 10          	sub    $0x10,%rsp
  803a1b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a1f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803a23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a27:	48 be 2a 51 80 00 00 	movabs $0x80512a,%rsi
  803a2e:	00 00 00 
  803a31:	48 89 c7             	mov    %rax,%rdi
  803a34:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  803a3b:	00 00 00 
  803a3e:	ff d0                	callq  *%rax
  803a40:	b8 00 00 00 00       	mov    $0x0,%eax
  803a45:	c9                   	leaveq 
  803a46:	c3                   	retq   

0000000000803a47 <socket>:
  803a47:	55                   	push   %rbp
  803a48:	48 89 e5             	mov    %rsp,%rbp
  803a4b:	48 83 ec 20          	sub    $0x20,%rsp
  803a4f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a52:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803a55:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803a58:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803a5b:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803a5e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a61:	89 ce                	mov    %ecx,%esi
  803a63:	89 c7                	mov    %eax,%edi
  803a65:	48 b8 8b 3e 80 00 00 	movabs $0x803e8b,%rax
  803a6c:	00 00 00 
  803a6f:	ff d0                	callq  *%rax
  803a71:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a74:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a78:	79 05                	jns    803a7f <socket+0x38>
  803a7a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a7d:	eb 11                	jmp    803a90 <socket+0x49>
  803a7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a82:	89 c7                	mov    %eax,%edi
  803a84:	48 b8 29 37 80 00 00 	movabs $0x803729,%rax
  803a8b:	00 00 00 
  803a8e:	ff d0                	callq  *%rax
  803a90:	c9                   	leaveq 
  803a91:	c3                   	retq   

0000000000803a92 <nsipc>:
  803a92:	55                   	push   %rbp
  803a93:	48 89 e5             	mov    %rsp,%rbp
  803a96:	48 83 ec 10          	sub    $0x10,%rsp
  803a9a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a9d:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803aa4:	00 00 00 
  803aa7:	8b 00                	mov    (%rax),%eax
  803aa9:	85 c0                	test   %eax,%eax
  803aab:	75 1d                	jne    803aca <nsipc+0x38>
  803aad:	bf 02 00 00 00       	mov    $0x2,%edi
  803ab2:	48 b8 26 49 80 00 00 	movabs $0x804926,%rax
  803ab9:	00 00 00 
  803abc:	ff d0                	callq  *%rax
  803abe:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803ac5:	00 00 00 
  803ac8:	89 02                	mov    %eax,(%rdx)
  803aca:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803ad1:	00 00 00 
  803ad4:	8b 00                	mov    (%rax),%eax
  803ad6:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803ad9:	b9 07 00 00 00       	mov    $0x7,%ecx
  803ade:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803ae5:	00 00 00 
  803ae8:	89 c7                	mov    %eax,%edi
  803aea:	48 b8 1b 48 80 00 00 	movabs $0x80481b,%rax
  803af1:	00 00 00 
  803af4:	ff d0                	callq  *%rax
  803af6:	ba 00 00 00 00       	mov    $0x0,%edx
  803afb:	be 00 00 00 00       	mov    $0x0,%esi
  803b00:	bf 00 00 00 00       	mov    $0x0,%edi
  803b05:	48 b8 5a 47 80 00 00 	movabs $0x80475a,%rax
  803b0c:	00 00 00 
  803b0f:	ff d0                	callq  *%rax
  803b11:	c9                   	leaveq 
  803b12:	c3                   	retq   

0000000000803b13 <nsipc_accept>:
  803b13:	55                   	push   %rbp
  803b14:	48 89 e5             	mov    %rsp,%rbp
  803b17:	48 83 ec 30          	sub    $0x30,%rsp
  803b1b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b1e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b22:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803b26:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b2d:	00 00 00 
  803b30:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b33:	89 10                	mov    %edx,(%rax)
  803b35:	bf 01 00 00 00       	mov    $0x1,%edi
  803b3a:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803b41:	00 00 00 
  803b44:	ff d0                	callq  *%rax
  803b46:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b49:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b4d:	78 3e                	js     803b8d <nsipc_accept+0x7a>
  803b4f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b56:	00 00 00 
  803b59:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803b5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b61:	8b 40 10             	mov    0x10(%rax),%eax
  803b64:	89 c2                	mov    %eax,%edx
  803b66:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803b6a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b6e:	48 89 ce             	mov    %rcx,%rsi
  803b71:	48 89 c7             	mov    %rax,%rdi
  803b74:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  803b7b:	00 00 00 
  803b7e:	ff d0                	callq  *%rax
  803b80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b84:	8b 50 10             	mov    0x10(%rax),%edx
  803b87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b8b:	89 10                	mov    %edx,(%rax)
  803b8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b90:	c9                   	leaveq 
  803b91:	c3                   	retq   

0000000000803b92 <nsipc_bind>:
  803b92:	55                   	push   %rbp
  803b93:	48 89 e5             	mov    %rsp,%rbp
  803b96:	48 83 ec 10          	sub    $0x10,%rsp
  803b9a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b9d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803ba1:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803ba4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bab:	00 00 00 
  803bae:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803bb1:	89 10                	mov    %edx,(%rax)
  803bb3:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803bb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bba:	48 89 c6             	mov    %rax,%rsi
  803bbd:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803bc4:	00 00 00 
  803bc7:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  803bce:	00 00 00 
  803bd1:	ff d0                	callq  *%rax
  803bd3:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bda:	00 00 00 
  803bdd:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803be0:	89 50 14             	mov    %edx,0x14(%rax)
  803be3:	bf 02 00 00 00       	mov    $0x2,%edi
  803be8:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803bef:	00 00 00 
  803bf2:	ff d0                	callq  *%rax
  803bf4:	c9                   	leaveq 
  803bf5:	c3                   	retq   

0000000000803bf6 <nsipc_shutdown>:
  803bf6:	55                   	push   %rbp
  803bf7:	48 89 e5             	mov    %rsp,%rbp
  803bfa:	48 83 ec 10          	sub    $0x10,%rsp
  803bfe:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c01:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803c04:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c0b:	00 00 00 
  803c0e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c11:	89 10                	mov    %edx,(%rax)
  803c13:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c1a:	00 00 00 
  803c1d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c20:	89 50 04             	mov    %edx,0x4(%rax)
  803c23:	bf 03 00 00 00       	mov    $0x3,%edi
  803c28:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803c2f:	00 00 00 
  803c32:	ff d0                	callq  *%rax
  803c34:	c9                   	leaveq 
  803c35:	c3                   	retq   

0000000000803c36 <nsipc_close>:
  803c36:	55                   	push   %rbp
  803c37:	48 89 e5             	mov    %rsp,%rbp
  803c3a:	48 83 ec 10          	sub    $0x10,%rsp
  803c3e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c41:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c48:	00 00 00 
  803c4b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c4e:	89 10                	mov    %edx,(%rax)
  803c50:	bf 04 00 00 00       	mov    $0x4,%edi
  803c55:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803c5c:	00 00 00 
  803c5f:	ff d0                	callq  *%rax
  803c61:	c9                   	leaveq 
  803c62:	c3                   	retq   

0000000000803c63 <nsipc_connect>:
  803c63:	55                   	push   %rbp
  803c64:	48 89 e5             	mov    %rsp,%rbp
  803c67:	48 83 ec 10          	sub    $0x10,%rsp
  803c6b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c6e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803c72:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803c75:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c7c:	00 00 00 
  803c7f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c82:	89 10                	mov    %edx,(%rax)
  803c84:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c8b:	48 89 c6             	mov    %rax,%rsi
  803c8e:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803c95:	00 00 00 
  803c98:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  803c9f:	00 00 00 
  803ca2:	ff d0                	callq  *%rax
  803ca4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cab:	00 00 00 
  803cae:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803cb1:	89 50 14             	mov    %edx,0x14(%rax)
  803cb4:	bf 05 00 00 00       	mov    $0x5,%edi
  803cb9:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803cc0:	00 00 00 
  803cc3:	ff d0                	callq  *%rax
  803cc5:	c9                   	leaveq 
  803cc6:	c3                   	retq   

0000000000803cc7 <nsipc_listen>:
  803cc7:	55                   	push   %rbp
  803cc8:	48 89 e5             	mov    %rsp,%rbp
  803ccb:	48 83 ec 10          	sub    $0x10,%rsp
  803ccf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cd2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803cd5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cdc:	00 00 00 
  803cdf:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ce2:	89 10                	mov    %edx,(%rax)
  803ce4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ceb:	00 00 00 
  803cee:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803cf1:	89 50 04             	mov    %edx,0x4(%rax)
  803cf4:	bf 06 00 00 00       	mov    $0x6,%edi
  803cf9:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803d00:	00 00 00 
  803d03:	ff d0                	callq  *%rax
  803d05:	c9                   	leaveq 
  803d06:	c3                   	retq   

0000000000803d07 <nsipc_recv>:
  803d07:	55                   	push   %rbp
  803d08:	48 89 e5             	mov    %rsp,%rbp
  803d0b:	48 83 ec 30          	sub    $0x30,%rsp
  803d0f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d12:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803d16:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803d19:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803d1c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d23:	00 00 00 
  803d26:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803d29:	89 10                	mov    %edx,(%rax)
  803d2b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d32:	00 00 00 
  803d35:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803d38:	89 50 04             	mov    %edx,0x4(%rax)
  803d3b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d42:	00 00 00 
  803d45:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803d48:	89 50 08             	mov    %edx,0x8(%rax)
  803d4b:	bf 07 00 00 00       	mov    $0x7,%edi
  803d50:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803d57:	00 00 00 
  803d5a:	ff d0                	callq  *%rax
  803d5c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d5f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d63:	78 69                	js     803dce <nsipc_recv+0xc7>
  803d65:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803d6c:	7f 08                	jg     803d76 <nsipc_recv+0x6f>
  803d6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d71:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803d74:	7e 35                	jle    803dab <nsipc_recv+0xa4>
  803d76:	48 b9 31 51 80 00 00 	movabs $0x805131,%rcx
  803d7d:	00 00 00 
  803d80:	48 ba 46 51 80 00 00 	movabs $0x805146,%rdx
  803d87:	00 00 00 
  803d8a:	be 62 00 00 00       	mov    $0x62,%esi
  803d8f:	48 bf 5b 51 80 00 00 	movabs $0x80515b,%rdi
  803d96:	00 00 00 
  803d99:	b8 00 00 00 00       	mov    $0x0,%eax
  803d9e:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  803da5:	00 00 00 
  803da8:	41 ff d0             	callq  *%r8
  803dab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dae:	48 63 d0             	movslq %eax,%rdx
  803db1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803db5:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803dbc:	00 00 00 
  803dbf:	48 89 c7             	mov    %rax,%rdi
  803dc2:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  803dc9:	00 00 00 
  803dcc:	ff d0                	callq  *%rax
  803dce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dd1:	c9                   	leaveq 
  803dd2:	c3                   	retq   

0000000000803dd3 <nsipc_send>:
  803dd3:	55                   	push   %rbp
  803dd4:	48 89 e5             	mov    %rsp,%rbp
  803dd7:	48 83 ec 20          	sub    $0x20,%rsp
  803ddb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803dde:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803de2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803de5:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803de8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803def:	00 00 00 
  803df2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803df5:	89 10                	mov    %edx,(%rax)
  803df7:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803dfe:	7e 35                	jle    803e35 <nsipc_send+0x62>
  803e00:	48 b9 6a 51 80 00 00 	movabs $0x80516a,%rcx
  803e07:	00 00 00 
  803e0a:	48 ba 46 51 80 00 00 	movabs $0x805146,%rdx
  803e11:	00 00 00 
  803e14:	be 6d 00 00 00       	mov    $0x6d,%esi
  803e19:	48 bf 5b 51 80 00 00 	movabs $0x80515b,%rdi
  803e20:	00 00 00 
  803e23:	b8 00 00 00 00       	mov    $0x0,%eax
  803e28:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  803e2f:	00 00 00 
  803e32:	41 ff d0             	callq  *%r8
  803e35:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803e38:	48 63 d0             	movslq %eax,%rdx
  803e3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e3f:	48 89 c6             	mov    %rax,%rsi
  803e42:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803e49:	00 00 00 
  803e4c:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  803e53:	00 00 00 
  803e56:	ff d0                	callq  *%rax
  803e58:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e5f:	00 00 00 
  803e62:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e65:	89 50 04             	mov    %edx,0x4(%rax)
  803e68:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e6f:	00 00 00 
  803e72:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803e75:	89 50 08             	mov    %edx,0x8(%rax)
  803e78:	bf 08 00 00 00       	mov    $0x8,%edi
  803e7d:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803e84:	00 00 00 
  803e87:	ff d0                	callq  *%rax
  803e89:	c9                   	leaveq 
  803e8a:	c3                   	retq   

0000000000803e8b <nsipc_socket>:
  803e8b:	55                   	push   %rbp
  803e8c:	48 89 e5             	mov    %rsp,%rbp
  803e8f:	48 83 ec 10          	sub    $0x10,%rsp
  803e93:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e96:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803e99:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803e9c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ea3:	00 00 00 
  803ea6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ea9:	89 10                	mov    %edx,(%rax)
  803eab:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803eb2:	00 00 00 
  803eb5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803eb8:	89 50 04             	mov    %edx,0x4(%rax)
  803ebb:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ec2:	00 00 00 
  803ec5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803ec8:	89 50 08             	mov    %edx,0x8(%rax)
  803ecb:	bf 09 00 00 00       	mov    $0x9,%edi
  803ed0:	48 b8 92 3a 80 00 00 	movabs $0x803a92,%rax
  803ed7:	00 00 00 
  803eda:	ff d0                	callq  *%rax
  803edc:	c9                   	leaveq 
  803edd:	c3                   	retq   

0000000000803ede <pipe>:
  803ede:	55                   	push   %rbp
  803edf:	48 89 e5             	mov    %rsp,%rbp
  803ee2:	53                   	push   %rbx
  803ee3:	48 83 ec 38          	sub    $0x38,%rsp
  803ee7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803eeb:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803eef:	48 89 c7             	mov    %rax,%rdi
  803ef2:	48 b8 f1 23 80 00 00 	movabs $0x8023f1,%rax
  803ef9:	00 00 00 
  803efc:	ff d0                	callq  *%rax
  803efe:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f01:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f05:	0f 88 bf 01 00 00    	js     8040ca <pipe+0x1ec>
  803f0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f0f:	ba 07 04 00 00       	mov    $0x407,%edx
  803f14:	48 89 c6             	mov    %rax,%rsi
  803f17:	bf 00 00 00 00       	mov    $0x0,%edi
  803f1c:	48 b8 de 1c 80 00 00 	movabs $0x801cde,%rax
  803f23:	00 00 00 
  803f26:	ff d0                	callq  *%rax
  803f28:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f2b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f2f:	0f 88 95 01 00 00    	js     8040ca <pipe+0x1ec>
  803f35:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803f39:	48 89 c7             	mov    %rax,%rdi
  803f3c:	48 b8 f1 23 80 00 00 	movabs $0x8023f1,%rax
  803f43:	00 00 00 
  803f46:	ff d0                	callq  *%rax
  803f48:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f4b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f4f:	0f 88 5d 01 00 00    	js     8040b2 <pipe+0x1d4>
  803f55:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f59:	ba 07 04 00 00       	mov    $0x407,%edx
  803f5e:	48 89 c6             	mov    %rax,%rsi
  803f61:	bf 00 00 00 00       	mov    $0x0,%edi
  803f66:	48 b8 de 1c 80 00 00 	movabs $0x801cde,%rax
  803f6d:	00 00 00 
  803f70:	ff d0                	callq  *%rax
  803f72:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f75:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f79:	0f 88 33 01 00 00    	js     8040b2 <pipe+0x1d4>
  803f7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f83:	48 89 c7             	mov    %rax,%rdi
  803f86:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  803f8d:	00 00 00 
  803f90:	ff d0                	callq  *%rax
  803f92:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803f96:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f9a:	ba 07 04 00 00       	mov    $0x407,%edx
  803f9f:	48 89 c6             	mov    %rax,%rsi
  803fa2:	bf 00 00 00 00       	mov    $0x0,%edi
  803fa7:	48 b8 de 1c 80 00 00 	movabs $0x801cde,%rax
  803fae:	00 00 00 
  803fb1:	ff d0                	callq  *%rax
  803fb3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803fb6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803fba:	79 05                	jns    803fc1 <pipe+0xe3>
  803fbc:	e9 d9 00 00 00       	jmpq   80409a <pipe+0x1bc>
  803fc1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fc5:	48 89 c7             	mov    %rax,%rdi
  803fc8:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  803fcf:	00 00 00 
  803fd2:	ff d0                	callq  *%rax
  803fd4:	48 89 c2             	mov    %rax,%rdx
  803fd7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fdb:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803fe1:	48 89 d1             	mov    %rdx,%rcx
  803fe4:	ba 00 00 00 00       	mov    $0x0,%edx
  803fe9:	48 89 c6             	mov    %rax,%rsi
  803fec:	bf 00 00 00 00       	mov    $0x0,%edi
  803ff1:	48 b8 2e 1d 80 00 00 	movabs $0x801d2e,%rax
  803ff8:	00 00 00 
  803ffb:	ff d0                	callq  *%rax
  803ffd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804000:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804004:	79 1b                	jns    804021 <pipe+0x143>
  804006:	90                   	nop
  804007:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80400b:	48 89 c6             	mov    %rax,%rsi
  80400e:	bf 00 00 00 00       	mov    $0x0,%edi
  804013:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  80401a:	00 00 00 
  80401d:	ff d0                	callq  *%rax
  80401f:	eb 79                	jmp    80409a <pipe+0x1bc>
  804021:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804025:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  80402c:	00 00 00 
  80402f:	8b 12                	mov    (%rdx),%edx
  804031:	89 10                	mov    %edx,(%rax)
  804033:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804037:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80403e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804042:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804049:	00 00 00 
  80404c:	8b 12                	mov    (%rdx),%edx
  80404e:	89 10                	mov    %edx,(%rax)
  804050:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804054:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  80405b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80405f:	48 89 c7             	mov    %rax,%rdi
  804062:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  804069:	00 00 00 
  80406c:	ff d0                	callq  *%rax
  80406e:	89 c2                	mov    %eax,%edx
  804070:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804074:	89 10                	mov    %edx,(%rax)
  804076:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80407a:	48 8d 58 04          	lea    0x4(%rax),%rbx
  80407e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804082:	48 89 c7             	mov    %rax,%rdi
  804085:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  80408c:	00 00 00 
  80408f:	ff d0                	callq  *%rax
  804091:	89 03                	mov    %eax,(%rbx)
  804093:	b8 00 00 00 00       	mov    $0x0,%eax
  804098:	eb 33                	jmp    8040cd <pipe+0x1ef>
  80409a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80409e:	48 89 c6             	mov    %rax,%rsi
  8040a1:	bf 00 00 00 00       	mov    $0x0,%edi
  8040a6:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  8040ad:	00 00 00 
  8040b0:	ff d0                	callq  *%rax
  8040b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040b6:	48 89 c6             	mov    %rax,%rsi
  8040b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8040be:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  8040c5:	00 00 00 
  8040c8:	ff d0                	callq  *%rax
  8040ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8040cd:	48 83 c4 38          	add    $0x38,%rsp
  8040d1:	5b                   	pop    %rbx
  8040d2:	5d                   	pop    %rbp
  8040d3:	c3                   	retq   

00000000008040d4 <_pipeisclosed>:
  8040d4:	55                   	push   %rbp
  8040d5:	48 89 e5             	mov    %rsp,%rbp
  8040d8:	53                   	push   %rbx
  8040d9:	48 83 ec 28          	sub    $0x28,%rsp
  8040dd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8040e1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8040e5:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8040ec:	00 00 00 
  8040ef:	48 8b 00             	mov    (%rax),%rax
  8040f2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8040f8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8040fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040ff:	48 89 c7             	mov    %rax,%rdi
  804102:	48 b8 98 49 80 00 00 	movabs $0x804998,%rax
  804109:	00 00 00 
  80410c:	ff d0                	callq  *%rax
  80410e:	89 c3                	mov    %eax,%ebx
  804110:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804114:	48 89 c7             	mov    %rax,%rdi
  804117:	48 b8 98 49 80 00 00 	movabs $0x804998,%rax
  80411e:	00 00 00 
  804121:	ff d0                	callq  *%rax
  804123:	39 c3                	cmp    %eax,%ebx
  804125:	0f 94 c0             	sete   %al
  804128:	0f b6 c0             	movzbl %al,%eax
  80412b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80412e:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  804135:	00 00 00 
  804138:	48 8b 00             	mov    (%rax),%rax
  80413b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804141:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804144:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804147:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80414a:	75 05                	jne    804151 <_pipeisclosed+0x7d>
  80414c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80414f:	eb 4f                	jmp    8041a0 <_pipeisclosed+0xcc>
  804151:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804154:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804157:	74 42                	je     80419b <_pipeisclosed+0xc7>
  804159:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  80415d:	75 3c                	jne    80419b <_pipeisclosed+0xc7>
  80415f:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  804166:	00 00 00 
  804169:	48 8b 00             	mov    (%rax),%rax
  80416c:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  804172:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  804175:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804178:	89 c6                	mov    %eax,%esi
  80417a:	48 bf 7b 51 80 00 00 	movabs $0x80517b,%rdi
  804181:	00 00 00 
  804184:	b8 00 00 00 00       	mov    $0x0,%eax
  804189:	49 b8 fa 07 80 00 00 	movabs $0x8007fa,%r8
  804190:	00 00 00 
  804193:	41 ff d0             	callq  *%r8
  804196:	e9 4a ff ff ff       	jmpq   8040e5 <_pipeisclosed+0x11>
  80419b:	e9 45 ff ff ff       	jmpq   8040e5 <_pipeisclosed+0x11>
  8041a0:	48 83 c4 28          	add    $0x28,%rsp
  8041a4:	5b                   	pop    %rbx
  8041a5:	5d                   	pop    %rbp
  8041a6:	c3                   	retq   

00000000008041a7 <pipeisclosed>:
  8041a7:	55                   	push   %rbp
  8041a8:	48 89 e5             	mov    %rsp,%rbp
  8041ab:	48 83 ec 30          	sub    $0x30,%rsp
  8041af:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8041b2:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8041b6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8041b9:	48 89 d6             	mov    %rdx,%rsi
  8041bc:	89 c7                	mov    %eax,%edi
  8041be:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  8041c5:	00 00 00 
  8041c8:	ff d0                	callq  *%rax
  8041ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8041cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8041d1:	79 05                	jns    8041d8 <pipeisclosed+0x31>
  8041d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041d6:	eb 31                	jmp    804209 <pipeisclosed+0x62>
  8041d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8041dc:	48 89 c7             	mov    %rax,%rdi
  8041df:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  8041e6:	00 00 00 
  8041e9:	ff d0                	callq  *%rax
  8041eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8041ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8041f3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8041f7:	48 89 d6             	mov    %rdx,%rsi
  8041fa:	48 89 c7             	mov    %rax,%rdi
  8041fd:	48 b8 d4 40 80 00 00 	movabs $0x8040d4,%rax
  804204:	00 00 00 
  804207:	ff d0                	callq  *%rax
  804209:	c9                   	leaveq 
  80420a:	c3                   	retq   

000000000080420b <devpipe_read>:
  80420b:	55                   	push   %rbp
  80420c:	48 89 e5             	mov    %rsp,%rbp
  80420f:	48 83 ec 40          	sub    $0x40,%rsp
  804213:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804217:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80421b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80421f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804223:	48 89 c7             	mov    %rax,%rdi
  804226:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  80422d:	00 00 00 
  804230:	ff d0                	callq  *%rax
  804232:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804236:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80423a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80423e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804245:	00 
  804246:	e9 92 00 00 00       	jmpq   8042dd <devpipe_read+0xd2>
  80424b:	eb 41                	jmp    80428e <devpipe_read+0x83>
  80424d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804252:	74 09                	je     80425d <devpipe_read+0x52>
  804254:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804258:	e9 92 00 00 00       	jmpq   8042ef <devpipe_read+0xe4>
  80425d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804261:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804265:	48 89 d6             	mov    %rdx,%rsi
  804268:	48 89 c7             	mov    %rax,%rdi
  80426b:	48 b8 d4 40 80 00 00 	movabs $0x8040d4,%rax
  804272:	00 00 00 
  804275:	ff d0                	callq  *%rax
  804277:	85 c0                	test   %eax,%eax
  804279:	74 07                	je     804282 <devpipe_read+0x77>
  80427b:	b8 00 00 00 00       	mov    $0x0,%eax
  804280:	eb 6d                	jmp    8042ef <devpipe_read+0xe4>
  804282:	48 b8 a0 1c 80 00 00 	movabs $0x801ca0,%rax
  804289:	00 00 00 
  80428c:	ff d0                	callq  *%rax
  80428e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804292:	8b 10                	mov    (%rax),%edx
  804294:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804298:	8b 40 04             	mov    0x4(%rax),%eax
  80429b:	39 c2                	cmp    %eax,%edx
  80429d:	74 ae                	je     80424d <devpipe_read+0x42>
  80429f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042a3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8042a7:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8042ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042af:	8b 00                	mov    (%rax),%eax
  8042b1:	99                   	cltd   
  8042b2:	c1 ea 1b             	shr    $0x1b,%edx
  8042b5:	01 d0                	add    %edx,%eax
  8042b7:	83 e0 1f             	and    $0x1f,%eax
  8042ba:	29 d0                	sub    %edx,%eax
  8042bc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8042c0:	48 98                	cltq   
  8042c2:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8042c7:	88 01                	mov    %al,(%rcx)
  8042c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042cd:	8b 00                	mov    (%rax),%eax
  8042cf:	8d 50 01             	lea    0x1(%rax),%edx
  8042d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042d6:	89 10                	mov    %edx,(%rax)
  8042d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8042dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042e1:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8042e5:	0f 82 60 ff ff ff    	jb     80424b <devpipe_read+0x40>
  8042eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042ef:	c9                   	leaveq 
  8042f0:	c3                   	retq   

00000000008042f1 <devpipe_write>:
  8042f1:	55                   	push   %rbp
  8042f2:	48 89 e5             	mov    %rsp,%rbp
  8042f5:	48 83 ec 40          	sub    $0x40,%rsp
  8042f9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8042fd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804301:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804305:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804309:	48 89 c7             	mov    %rax,%rdi
  80430c:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  804313:	00 00 00 
  804316:	ff d0                	callq  *%rax
  804318:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80431c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804320:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804324:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80432b:	00 
  80432c:	e9 8e 00 00 00       	jmpq   8043bf <devpipe_write+0xce>
  804331:	eb 31                	jmp    804364 <devpipe_write+0x73>
  804333:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804337:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80433b:	48 89 d6             	mov    %rdx,%rsi
  80433e:	48 89 c7             	mov    %rax,%rdi
  804341:	48 b8 d4 40 80 00 00 	movabs $0x8040d4,%rax
  804348:	00 00 00 
  80434b:	ff d0                	callq  *%rax
  80434d:	85 c0                	test   %eax,%eax
  80434f:	74 07                	je     804358 <devpipe_write+0x67>
  804351:	b8 00 00 00 00       	mov    $0x0,%eax
  804356:	eb 79                	jmp    8043d1 <devpipe_write+0xe0>
  804358:	48 b8 a0 1c 80 00 00 	movabs $0x801ca0,%rax
  80435f:	00 00 00 
  804362:	ff d0                	callq  *%rax
  804364:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804368:	8b 40 04             	mov    0x4(%rax),%eax
  80436b:	48 63 d0             	movslq %eax,%rdx
  80436e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804372:	8b 00                	mov    (%rax),%eax
  804374:	48 98                	cltq   
  804376:	48 83 c0 20          	add    $0x20,%rax
  80437a:	48 39 c2             	cmp    %rax,%rdx
  80437d:	73 b4                	jae    804333 <devpipe_write+0x42>
  80437f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804383:	8b 40 04             	mov    0x4(%rax),%eax
  804386:	99                   	cltd   
  804387:	c1 ea 1b             	shr    $0x1b,%edx
  80438a:	01 d0                	add    %edx,%eax
  80438c:	83 e0 1f             	and    $0x1f,%eax
  80438f:	29 d0                	sub    %edx,%eax
  804391:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  804395:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804399:	48 01 ca             	add    %rcx,%rdx
  80439c:	0f b6 0a             	movzbl (%rdx),%ecx
  80439f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8043a3:	48 98                	cltq   
  8043a5:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8043a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043ad:	8b 40 04             	mov    0x4(%rax),%eax
  8043b0:	8d 50 01             	lea    0x1(%rax),%edx
  8043b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043b7:	89 50 04             	mov    %edx,0x4(%rax)
  8043ba:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8043bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043c3:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8043c7:	0f 82 64 ff ff ff    	jb     804331 <devpipe_write+0x40>
  8043cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043d1:	c9                   	leaveq 
  8043d2:	c3                   	retq   

00000000008043d3 <devpipe_stat>:
  8043d3:	55                   	push   %rbp
  8043d4:	48 89 e5             	mov    %rsp,%rbp
  8043d7:	48 83 ec 20          	sub    $0x20,%rsp
  8043db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8043df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8043e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8043e7:	48 89 c7             	mov    %rax,%rdi
  8043ea:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  8043f1:	00 00 00 
  8043f4:	ff d0                	callq  *%rax
  8043f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8043fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8043fe:	48 be 8e 51 80 00 00 	movabs $0x80518e,%rsi
  804405:	00 00 00 
  804408:	48 89 c7             	mov    %rax,%rdi
  80440b:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  804412:	00 00 00 
  804415:	ff d0                	callq  *%rax
  804417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80441b:	8b 50 04             	mov    0x4(%rax),%edx
  80441e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804422:	8b 00                	mov    (%rax),%eax
  804424:	29 c2                	sub    %eax,%edx
  804426:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80442a:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804430:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804434:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80443b:	00 00 00 
  80443e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804442:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804449:	00 00 00 
  80444c:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804453:	b8 00 00 00 00       	mov    $0x0,%eax
  804458:	c9                   	leaveq 
  804459:	c3                   	retq   

000000000080445a <devpipe_close>:
  80445a:	55                   	push   %rbp
  80445b:	48 89 e5             	mov    %rsp,%rbp
  80445e:	48 83 ec 10          	sub    $0x10,%rsp
  804462:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804466:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80446a:	48 89 c6             	mov    %rax,%rsi
  80446d:	bf 00 00 00 00       	mov    $0x0,%edi
  804472:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  804479:	00 00 00 
  80447c:	ff d0                	callq  *%rax
  80447e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804482:	48 89 c7             	mov    %rax,%rdi
  804485:	48 b8 c6 23 80 00 00 	movabs $0x8023c6,%rax
  80448c:	00 00 00 
  80448f:	ff d0                	callq  *%rax
  804491:	48 89 c6             	mov    %rax,%rsi
  804494:	bf 00 00 00 00       	mov    $0x0,%edi
  804499:	48 b8 89 1d 80 00 00 	movabs $0x801d89,%rax
  8044a0:	00 00 00 
  8044a3:	ff d0                	callq  *%rax
  8044a5:	c9                   	leaveq 
  8044a6:	c3                   	retq   

00000000008044a7 <cputchar>:
  8044a7:	55                   	push   %rbp
  8044a8:	48 89 e5             	mov    %rsp,%rbp
  8044ab:	48 83 ec 20          	sub    $0x20,%rsp
  8044af:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8044b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8044b5:	88 45 ff             	mov    %al,-0x1(%rbp)
  8044b8:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8044bc:	be 01 00 00 00       	mov    $0x1,%esi
  8044c1:	48 89 c7             	mov    %rax,%rdi
  8044c4:	48 b8 96 1b 80 00 00 	movabs $0x801b96,%rax
  8044cb:	00 00 00 
  8044ce:	ff d0                	callq  *%rax
  8044d0:	c9                   	leaveq 
  8044d1:	c3                   	retq   

00000000008044d2 <getchar>:
  8044d2:	55                   	push   %rbp
  8044d3:	48 89 e5             	mov    %rsp,%rbp
  8044d6:	48 83 ec 10          	sub    $0x10,%rsp
  8044da:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8044de:	ba 01 00 00 00       	mov    $0x1,%edx
  8044e3:	48 89 c6             	mov    %rax,%rsi
  8044e6:	bf 00 00 00 00       	mov    $0x0,%edi
  8044eb:	48 b8 bb 28 80 00 00 	movabs $0x8028bb,%rax
  8044f2:	00 00 00 
  8044f5:	ff d0                	callq  *%rax
  8044f7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044fa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044fe:	79 05                	jns    804505 <getchar+0x33>
  804500:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804503:	eb 14                	jmp    804519 <getchar+0x47>
  804505:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804509:	7f 07                	jg     804512 <getchar+0x40>
  80450b:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  804510:	eb 07                	jmp    804519 <getchar+0x47>
  804512:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804516:	0f b6 c0             	movzbl %al,%eax
  804519:	c9                   	leaveq 
  80451a:	c3                   	retq   

000000000080451b <iscons>:
  80451b:	55                   	push   %rbp
  80451c:	48 89 e5             	mov    %rsp,%rbp
  80451f:	48 83 ec 20          	sub    $0x20,%rsp
  804523:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804526:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80452a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80452d:	48 89 d6             	mov    %rdx,%rsi
  804530:	89 c7                	mov    %eax,%edi
  804532:	48 b8 89 24 80 00 00 	movabs $0x802489,%rax
  804539:	00 00 00 
  80453c:	ff d0                	callq  *%rax
  80453e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804541:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804545:	79 05                	jns    80454c <iscons+0x31>
  804547:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80454a:	eb 1a                	jmp    804566 <iscons+0x4b>
  80454c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804550:	8b 10                	mov    (%rax),%edx
  804552:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  804559:	00 00 00 
  80455c:	8b 00                	mov    (%rax),%eax
  80455e:	39 c2                	cmp    %eax,%edx
  804560:	0f 94 c0             	sete   %al
  804563:	0f b6 c0             	movzbl %al,%eax
  804566:	c9                   	leaveq 
  804567:	c3                   	retq   

0000000000804568 <opencons>:
  804568:	55                   	push   %rbp
  804569:	48 89 e5             	mov    %rsp,%rbp
  80456c:	48 83 ec 10          	sub    $0x10,%rsp
  804570:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804574:	48 89 c7             	mov    %rax,%rdi
  804577:	48 b8 f1 23 80 00 00 	movabs $0x8023f1,%rax
  80457e:	00 00 00 
  804581:	ff d0                	callq  *%rax
  804583:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804586:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80458a:	79 05                	jns    804591 <opencons+0x29>
  80458c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80458f:	eb 5b                	jmp    8045ec <opencons+0x84>
  804591:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804595:	ba 07 04 00 00       	mov    $0x407,%edx
  80459a:	48 89 c6             	mov    %rax,%rsi
  80459d:	bf 00 00 00 00       	mov    $0x0,%edi
  8045a2:	48 b8 de 1c 80 00 00 	movabs $0x801cde,%rax
  8045a9:	00 00 00 
  8045ac:	ff d0                	callq  *%rax
  8045ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8045b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8045b5:	79 05                	jns    8045bc <opencons+0x54>
  8045b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045ba:	eb 30                	jmp    8045ec <opencons+0x84>
  8045bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045c0:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8045c7:	00 00 00 
  8045ca:	8b 12                	mov    (%rdx),%edx
  8045cc:	89 10                	mov    %edx,(%rax)
  8045ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045d2:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8045d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045dd:	48 89 c7             	mov    %rax,%rdi
  8045e0:	48 b8 a3 23 80 00 00 	movabs $0x8023a3,%rax
  8045e7:	00 00 00 
  8045ea:	ff d0                	callq  *%rax
  8045ec:	c9                   	leaveq 
  8045ed:	c3                   	retq   

00000000008045ee <devcons_read>:
  8045ee:	55                   	push   %rbp
  8045ef:	48 89 e5             	mov    %rsp,%rbp
  8045f2:	48 83 ec 30          	sub    $0x30,%rsp
  8045f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8045fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8045fe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804602:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804607:	75 07                	jne    804610 <devcons_read+0x22>
  804609:	b8 00 00 00 00       	mov    $0x0,%eax
  80460e:	eb 4b                	jmp    80465b <devcons_read+0x6d>
  804610:	eb 0c                	jmp    80461e <devcons_read+0x30>
  804612:	48 b8 a0 1c 80 00 00 	movabs $0x801ca0,%rax
  804619:	00 00 00 
  80461c:	ff d0                	callq  *%rax
  80461e:	48 b8 e0 1b 80 00 00 	movabs $0x801be0,%rax
  804625:	00 00 00 
  804628:	ff d0                	callq  *%rax
  80462a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80462d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804631:	74 df                	je     804612 <devcons_read+0x24>
  804633:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804637:	79 05                	jns    80463e <devcons_read+0x50>
  804639:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80463c:	eb 1d                	jmp    80465b <devcons_read+0x6d>
  80463e:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804642:	75 07                	jne    80464b <devcons_read+0x5d>
  804644:	b8 00 00 00 00       	mov    $0x0,%eax
  804649:	eb 10                	jmp    80465b <devcons_read+0x6d>
  80464b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80464e:	89 c2                	mov    %eax,%edx
  804650:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804654:	88 10                	mov    %dl,(%rax)
  804656:	b8 01 00 00 00       	mov    $0x1,%eax
  80465b:	c9                   	leaveq 
  80465c:	c3                   	retq   

000000000080465d <devcons_write>:
  80465d:	55                   	push   %rbp
  80465e:	48 89 e5             	mov    %rsp,%rbp
  804661:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804668:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  80466f:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804676:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80467d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804684:	eb 76                	jmp    8046fc <devcons_write+0x9f>
  804686:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80468d:	89 c2                	mov    %eax,%edx
  80468f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804692:	29 c2                	sub    %eax,%edx
  804694:	89 d0                	mov    %edx,%eax
  804696:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804699:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80469c:	83 f8 7f             	cmp    $0x7f,%eax
  80469f:	76 07                	jbe    8046a8 <devcons_write+0x4b>
  8046a1:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8046a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8046ab:	48 63 d0             	movslq %eax,%rdx
  8046ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046b1:	48 63 c8             	movslq %eax,%rcx
  8046b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8046bb:	48 01 c1             	add    %rax,%rcx
  8046be:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8046c5:	48 89 ce             	mov    %rcx,%rsi
  8046c8:	48 89 c7             	mov    %rax,%rdi
  8046cb:	48 b8 d3 16 80 00 00 	movabs $0x8016d3,%rax
  8046d2:	00 00 00 
  8046d5:	ff d0                	callq  *%rax
  8046d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8046da:	48 63 d0             	movslq %eax,%rdx
  8046dd:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8046e4:	48 89 d6             	mov    %rdx,%rsi
  8046e7:	48 89 c7             	mov    %rax,%rdi
  8046ea:	48 b8 96 1b 80 00 00 	movabs $0x801b96,%rax
  8046f1:	00 00 00 
  8046f4:	ff d0                	callq  *%rax
  8046f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8046f9:	01 45 fc             	add    %eax,-0x4(%rbp)
  8046fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046ff:	48 98                	cltq   
  804701:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804708:	0f 82 78 ff ff ff    	jb     804686 <devcons_write+0x29>
  80470e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804711:	c9                   	leaveq 
  804712:	c3                   	retq   

0000000000804713 <devcons_close>:
  804713:	55                   	push   %rbp
  804714:	48 89 e5             	mov    %rsp,%rbp
  804717:	48 83 ec 08          	sub    $0x8,%rsp
  80471b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80471f:	b8 00 00 00 00       	mov    $0x0,%eax
  804724:	c9                   	leaveq 
  804725:	c3                   	retq   

0000000000804726 <devcons_stat>:
  804726:	55                   	push   %rbp
  804727:	48 89 e5             	mov    %rsp,%rbp
  80472a:	48 83 ec 10          	sub    $0x10,%rsp
  80472e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804732:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804736:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80473a:	48 be 9a 51 80 00 00 	movabs $0x80519a,%rsi
  804741:	00 00 00 
  804744:	48 89 c7             	mov    %rax,%rdi
  804747:	48 b8 af 13 80 00 00 	movabs $0x8013af,%rax
  80474e:	00 00 00 
  804751:	ff d0                	callq  *%rax
  804753:	b8 00 00 00 00       	mov    $0x0,%eax
  804758:	c9                   	leaveq 
  804759:	c3                   	retq   

000000000080475a <ipc_recv>:
  80475a:	55                   	push   %rbp
  80475b:	48 89 e5             	mov    %rsp,%rbp
  80475e:	48 83 ec 30          	sub    $0x30,%rsp
  804762:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804766:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80476a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80476e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804773:	75 0e                	jne    804783 <ipc_recv+0x29>
  804775:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80477c:	00 00 00 
  80477f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804783:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804787:	48 89 c7             	mov    %rax,%rdi
  80478a:	48 b8 07 1f 80 00 00 	movabs $0x801f07,%rax
  804791:	00 00 00 
  804794:	ff d0                	callq  *%rax
  804796:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804799:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80479d:	79 27                	jns    8047c6 <ipc_recv+0x6c>
  80479f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8047a4:	74 0a                	je     8047b0 <ipc_recv+0x56>
  8047a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047aa:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8047b0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8047b5:	74 0a                	je     8047c1 <ipc_recv+0x67>
  8047b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047bb:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8047c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047c4:	eb 53                	jmp    804819 <ipc_recv+0xbf>
  8047c6:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8047cb:	74 19                	je     8047e6 <ipc_recv+0x8c>
  8047cd:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8047d4:	00 00 00 
  8047d7:	48 8b 00             	mov    (%rax),%rax
  8047da:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8047e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047e4:	89 10                	mov    %edx,(%rax)
  8047e6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8047eb:	74 19                	je     804806 <ipc_recv+0xac>
  8047ed:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  8047f4:	00 00 00 
  8047f7:	48 8b 00             	mov    (%rax),%rax
  8047fa:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804800:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804804:	89 10                	mov    %edx,(%rax)
  804806:	48 b8 20 84 80 00 00 	movabs $0x808420,%rax
  80480d:	00 00 00 
  804810:	48 8b 00             	mov    (%rax),%rax
  804813:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804819:	c9                   	leaveq 
  80481a:	c3                   	retq   

000000000080481b <ipc_send>:
  80481b:	55                   	push   %rbp
  80481c:	48 89 e5             	mov    %rsp,%rbp
  80481f:	48 83 ec 30          	sub    $0x30,%rsp
  804823:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804826:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804829:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  80482d:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804830:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804835:	75 10                	jne    804847 <ipc_send+0x2c>
  804837:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80483e:	00 00 00 
  804841:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804845:	eb 0e                	jmp    804855 <ipc_send+0x3a>
  804847:	eb 0c                	jmp    804855 <ipc_send+0x3a>
  804849:	48 b8 a0 1c 80 00 00 	movabs $0x801ca0,%rax
  804850:	00 00 00 
  804853:	ff d0                	callq  *%rax
  804855:	8b 75 e8             	mov    -0x18(%rbp),%esi
  804858:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  80485b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80485f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804862:	89 c7                	mov    %eax,%edi
  804864:	48 b8 b2 1e 80 00 00 	movabs $0x801eb2,%rax
  80486b:	00 00 00 
  80486e:	ff d0                	callq  *%rax
  804870:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804873:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804877:	74 d0                	je     804849 <ipc_send+0x2e>
  804879:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80487d:	79 30                	jns    8048af <ipc_send+0x94>
  80487f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804882:	89 c1                	mov    %eax,%ecx
  804884:	48 ba a8 51 80 00 00 	movabs $0x8051a8,%rdx
  80488b:	00 00 00 
  80488e:	be 44 00 00 00       	mov    $0x44,%esi
  804893:	48 bf be 51 80 00 00 	movabs $0x8051be,%rdi
  80489a:	00 00 00 
  80489d:	b8 00 00 00 00       	mov    $0x0,%eax
  8048a2:	49 b8 c1 05 80 00 00 	movabs $0x8005c1,%r8
  8048a9:	00 00 00 
  8048ac:	41 ff d0             	callq  *%r8
  8048af:	c9                   	leaveq 
  8048b0:	c3                   	retq   

00000000008048b1 <ipc_host_recv>:
  8048b1:	55                   	push   %rbp
  8048b2:	48 89 e5             	mov    %rsp,%rbp
  8048b5:	48 83 ec 10          	sub    $0x10,%rsp
  8048b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8048bd:	48 ba d0 51 80 00 00 	movabs $0x8051d0,%rdx
  8048c4:	00 00 00 
  8048c7:	be 4e 00 00 00       	mov    $0x4e,%esi
  8048cc:	48 bf be 51 80 00 00 	movabs $0x8051be,%rdi
  8048d3:	00 00 00 
  8048d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8048db:	48 b9 c1 05 80 00 00 	movabs $0x8005c1,%rcx
  8048e2:	00 00 00 
  8048e5:	ff d1                	callq  *%rcx

00000000008048e7 <ipc_host_send>:
  8048e7:	55                   	push   %rbp
  8048e8:	48 89 e5             	mov    %rsp,%rbp
  8048eb:	48 83 ec 20          	sub    $0x20,%rsp
  8048ef:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8048f2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8048f5:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  8048f9:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8048fc:	48 ba f0 51 80 00 00 	movabs $0x8051f0,%rdx
  804903:	00 00 00 
  804906:	be 67 00 00 00       	mov    $0x67,%esi
  80490b:	48 bf be 51 80 00 00 	movabs $0x8051be,%rdi
  804912:	00 00 00 
  804915:	b8 00 00 00 00       	mov    $0x0,%eax
  80491a:	48 b9 c1 05 80 00 00 	movabs $0x8005c1,%rcx
  804921:	00 00 00 
  804924:	ff d1                	callq  *%rcx

0000000000804926 <ipc_find_env>:
  804926:	55                   	push   %rbp
  804927:	48 89 e5             	mov    %rsp,%rbp
  80492a:	48 83 ec 14          	sub    $0x14,%rsp
  80492e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804931:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804938:	eb 4e                	jmp    804988 <ipc_find_env+0x62>
  80493a:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804941:	00 00 00 
  804944:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804947:	48 98                	cltq   
  804949:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804950:	48 01 d0             	add    %rdx,%rax
  804953:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804959:	8b 00                	mov    (%rax),%eax
  80495b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80495e:	75 24                	jne    804984 <ipc_find_env+0x5e>
  804960:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804967:	00 00 00 
  80496a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80496d:	48 98                	cltq   
  80496f:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804976:	48 01 d0             	add    %rdx,%rax
  804979:	48 05 c0 00 00 00    	add    $0xc0,%rax
  80497f:	8b 40 08             	mov    0x8(%rax),%eax
  804982:	eb 12                	jmp    804996 <ipc_find_env+0x70>
  804984:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804988:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  80498f:	7e a9                	jle    80493a <ipc_find_env+0x14>
  804991:	b8 00 00 00 00       	mov    $0x0,%eax
  804996:	c9                   	leaveq 
  804997:	c3                   	retq   

0000000000804998 <pageref>:
  804998:	55                   	push   %rbp
  804999:	48 89 e5             	mov    %rsp,%rbp
  80499c:	48 83 ec 18          	sub    $0x18,%rsp
  8049a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8049a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049a8:	48 c1 e8 15          	shr    $0x15,%rax
  8049ac:	48 89 c2             	mov    %rax,%rdx
  8049af:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8049b6:	01 00 00 
  8049b9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8049bd:	83 e0 01             	and    $0x1,%eax
  8049c0:	48 85 c0             	test   %rax,%rax
  8049c3:	75 07                	jne    8049cc <pageref+0x34>
  8049c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8049ca:	eb 53                	jmp    804a1f <pageref+0x87>
  8049cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049d0:	48 c1 e8 0c          	shr    $0xc,%rax
  8049d4:	48 89 c2             	mov    %rax,%rdx
  8049d7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8049de:	01 00 00 
  8049e1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8049e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8049e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049ed:	83 e0 01             	and    $0x1,%eax
  8049f0:	48 85 c0             	test   %rax,%rax
  8049f3:	75 07                	jne    8049fc <pageref+0x64>
  8049f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8049fa:	eb 23                	jmp    804a1f <pageref+0x87>
  8049fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a00:	48 c1 e8 0c          	shr    $0xc,%rax
  804a04:	48 89 c2             	mov    %rax,%rdx
  804a07:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804a0e:	00 00 00 
  804a11:	48 c1 e2 04          	shl    $0x4,%rdx
  804a15:	48 01 d0             	add    %rdx,%rax
  804a18:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804a1c:	0f b7 c0             	movzwl %ax,%eax
  804a1f:	c9                   	leaveq 
  804a20:	c3                   	retq   
