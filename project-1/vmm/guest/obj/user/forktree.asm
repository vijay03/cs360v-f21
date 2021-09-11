
vmm/guest/obj/user/forktree:     file format elf64-x86-64


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
  80003c:	e8 24 01 00 00       	callq  800165 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <forkchild>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80004f:	89 f0                	mov    %esi,%eax
  800051:	88 45 e4             	mov    %al,-0x1c(%rbp)
  800054:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800058:	48 89 c7             	mov    %rax,%rdi
  80005b:	48 b8 79 0e 80 00 00 	movabs $0x800e79,%rax
  800062:	00 00 00 
  800065:	ff d0                	callq  *%rax
  800067:	83 f8 02             	cmp    $0x2,%eax
  80006a:	7f 65                	jg     8000d1 <forkchild+0x8e>
  80006c:	0f be 4d e4          	movsbl -0x1c(%rbp),%ecx
  800070:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800074:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  800078:	41 89 c8             	mov    %ecx,%r8d
  80007b:	48 89 d1             	mov    %rdx,%rcx
  80007e:	48 ba c0 47 80 00 00 	movabs $0x8047c0,%rdx
  800085:	00 00 00 
  800088:	be 04 00 00 00       	mov    $0x4,%esi
  80008d:	48 89 c7             	mov    %rax,%rdi
  800090:	b8 00 00 00 00       	mov    $0x0,%eax
  800095:	49 b9 98 0d 80 00 00 	movabs $0x800d98,%r9
  80009c:	00 00 00 
  80009f:	41 ff d1             	callq  *%r9
  8000a2:	48 b8 94 1f 80 00 00 	movabs $0x801f94,%rax
  8000a9:	00 00 00 
  8000ac:	ff d0                	callq  *%rax
  8000ae:	85 c0                	test   %eax,%eax
  8000b0:	75 1f                	jne    8000d1 <forkchild+0x8e>
  8000b2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8000b6:	48 89 c7             	mov    %rax,%rdi
  8000b9:	48 b8 d3 00 80 00 00 	movabs $0x8000d3,%rax
  8000c0:	00 00 00 
  8000c3:	ff d0                	callq  *%rax
  8000c5:	48 b8 e8 01 80 00 00 	movabs $0x8001e8,%rax
  8000cc:	00 00 00 
  8000cf:	ff d0                	callq  *%rax
  8000d1:	c9                   	leaveq 
  8000d2:	c3                   	retq   

00000000008000d3 <forktree>:
  8000d3:	55                   	push   %rbp
  8000d4:	48 89 e5             	mov    %rsp,%rbp
  8000d7:	48 83 ec 10          	sub    $0x10,%rsp
  8000db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8000df:	48 b8 98 17 80 00 00 	movabs $0x801798,%rax
  8000e6:	00 00 00 
  8000e9:	ff d0                	callq  *%rax
  8000eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8000ef:	89 c6                	mov    %eax,%esi
  8000f1:	48 bf c5 47 80 00 00 	movabs $0x8047c5,%rdi
  8000f8:	00 00 00 
  8000fb:	b8 00 00 00 00       	mov    $0x0,%eax
  800100:	48 b9 30 03 80 00 00 	movabs $0x800330,%rcx
  800107:	00 00 00 
  80010a:	ff d1                	callq  *%rcx
  80010c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800110:	be 30 00 00 00       	mov    $0x30,%esi
  800115:	48 89 c7             	mov    %rax,%rdi
  800118:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  80011f:	00 00 00 
  800122:	ff d0                	callq  *%rax
  800124:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800128:	be 31 00 00 00       	mov    $0x31,%esi
  80012d:	48 89 c7             	mov    %rax,%rdi
  800130:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800137:	00 00 00 
  80013a:	ff d0                	callq  *%rax
  80013c:	c9                   	leaveq 
  80013d:	c3                   	retq   

000000000080013e <umain>:
  80013e:	55                   	push   %rbp
  80013f:	48 89 e5             	mov    %rsp,%rbp
  800142:	48 83 ec 10          	sub    $0x10,%rsp
  800146:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800149:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80014d:	48 bf d6 47 80 00 00 	movabs $0x8047d6,%rdi
  800154:	00 00 00 
  800157:	48 b8 d3 00 80 00 00 	movabs $0x8000d3,%rax
  80015e:	00 00 00 
  800161:	ff d0                	callq  *%rax
  800163:	c9                   	leaveq 
  800164:	c3                   	retq   

0000000000800165 <libmain>:
  800165:	55                   	push   %rbp
  800166:	48 89 e5             	mov    %rsp,%rbp
  800169:	48 83 ec 10          	sub    $0x10,%rsp
  80016d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800170:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800174:	48 b8 98 17 80 00 00 	movabs $0x801798,%rax
  80017b:	00 00 00 
  80017e:	ff d0                	callq  *%rax
  800180:	25 ff 03 00 00       	and    $0x3ff,%eax
  800185:	48 98                	cltq   
  800187:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80018e:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800195:	00 00 00 
  800198:	48 01 c2             	add    %rax,%rdx
  80019b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8001a2:	00 00 00 
  8001a5:	48 89 10             	mov    %rdx,(%rax)
  8001a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8001ac:	7e 14                	jle    8001c2 <libmain+0x5d>
  8001ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8001b2:	48 8b 10             	mov    (%rax),%rdx
  8001b5:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8001bc:	00 00 00 
  8001bf:	48 89 10             	mov    %rdx,(%rax)
  8001c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8001c9:	48 89 d6             	mov    %rdx,%rsi
  8001cc:	89 c7                	mov    %eax,%edi
  8001ce:	48 b8 3e 01 80 00 00 	movabs $0x80013e,%rax
  8001d5:	00 00 00 
  8001d8:	ff d0                	callq  *%rax
  8001da:	48 b8 e8 01 80 00 00 	movabs $0x8001e8,%rax
  8001e1:	00 00 00 
  8001e4:	ff d0                	callq  *%rax
  8001e6:	c9                   	leaveq 
  8001e7:	c3                   	retq   

00000000008001e8 <exit>:
  8001e8:	55                   	push   %rbp
  8001e9:	48 89 e5             	mov    %rsp,%rbp
  8001ec:	48 b8 4a 25 80 00 00 	movabs $0x80254a,%rax
  8001f3:	00 00 00 
  8001f6:	ff d0                	callq  *%rax
  8001f8:	bf 00 00 00 00       	mov    $0x0,%edi
  8001fd:	48 b8 54 17 80 00 00 	movabs $0x801754,%rax
  800204:	00 00 00 
  800207:	ff d0                	callq  *%rax
  800209:	5d                   	pop    %rbp
  80020a:	c3                   	retq   

000000000080020b <putch>:
  80020b:	55                   	push   %rbp
  80020c:	48 89 e5             	mov    %rsp,%rbp
  80020f:	48 83 ec 10          	sub    $0x10,%rsp
  800213:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800216:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80021a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80021e:	8b 00                	mov    (%rax),%eax
  800220:	8d 48 01             	lea    0x1(%rax),%ecx
  800223:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800227:	89 0a                	mov    %ecx,(%rdx)
  800229:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80022c:	89 d1                	mov    %edx,%ecx
  80022e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800232:	48 98                	cltq   
  800234:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800238:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80023c:	8b 00                	mov    (%rax),%eax
  80023e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800243:	75 2c                	jne    800271 <putch+0x66>
  800245:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800249:	8b 00                	mov    (%rax),%eax
  80024b:	48 98                	cltq   
  80024d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800251:	48 83 c2 08          	add    $0x8,%rdx
  800255:	48 89 c6             	mov    %rax,%rsi
  800258:	48 89 d7             	mov    %rdx,%rdi
  80025b:	48 b8 cc 16 80 00 00 	movabs $0x8016cc,%rax
  800262:	00 00 00 
  800265:	ff d0                	callq  *%rax
  800267:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80026b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800271:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800275:	8b 40 04             	mov    0x4(%rax),%eax
  800278:	8d 50 01             	lea    0x1(%rax),%edx
  80027b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80027f:	89 50 04             	mov    %edx,0x4(%rax)
  800282:	c9                   	leaveq 
  800283:	c3                   	retq   

0000000000800284 <vcprintf>:
  800284:	55                   	push   %rbp
  800285:	48 89 e5             	mov    %rsp,%rbp
  800288:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80028f:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800296:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80029d:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8002a4:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8002ab:	48 8b 0a             	mov    (%rdx),%rcx
  8002ae:	48 89 08             	mov    %rcx,(%rax)
  8002b1:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8002b5:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8002b9:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8002bd:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8002c1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8002c8:	00 00 00 
  8002cb:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8002d2:	00 00 00 
  8002d5:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8002dc:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8002e3:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8002ea:	48 89 c6             	mov    %rax,%rsi
  8002ed:	48 bf 0b 02 80 00 00 	movabs $0x80020b,%rdi
  8002f4:	00 00 00 
  8002f7:	48 b8 e3 06 80 00 00 	movabs $0x8006e3,%rax
  8002fe:	00 00 00 
  800301:	ff d0                	callq  *%rax
  800303:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800309:	48 98                	cltq   
  80030b:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800312:	48 83 c2 08          	add    $0x8,%rdx
  800316:	48 89 c6             	mov    %rax,%rsi
  800319:	48 89 d7             	mov    %rdx,%rdi
  80031c:	48 b8 cc 16 80 00 00 	movabs $0x8016cc,%rax
  800323:	00 00 00 
  800326:	ff d0                	callq  *%rax
  800328:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  80032e:	c9                   	leaveq 
  80032f:	c3                   	retq   

0000000000800330 <cprintf>:
  800330:	55                   	push   %rbp
  800331:	48 89 e5             	mov    %rsp,%rbp
  800334:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  80033b:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800342:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800349:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800350:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800357:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80035e:	84 c0                	test   %al,%al
  800360:	74 20                	je     800382 <cprintf+0x52>
  800362:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800366:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80036a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80036e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800372:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800376:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80037a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80037e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800382:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800389:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800390:	00 00 00 
  800393:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80039a:	00 00 00 
  80039d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8003a1:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8003a8:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8003af:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8003b6:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8003bd:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8003c4:	48 8b 0a             	mov    (%rdx),%rcx
  8003c7:	48 89 08             	mov    %rcx,(%rax)
  8003ca:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8003ce:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8003d2:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8003d6:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8003da:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8003e1:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8003e8:	48 89 d6             	mov    %rdx,%rsi
  8003eb:	48 89 c7             	mov    %rax,%rdi
  8003ee:	48 b8 84 02 80 00 00 	movabs $0x800284,%rax
  8003f5:	00 00 00 
  8003f8:	ff d0                	callq  *%rax
  8003fa:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800400:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800406:	c9                   	leaveq 
  800407:	c3                   	retq   

0000000000800408 <printnum>:
  800408:	55                   	push   %rbp
  800409:	48 89 e5             	mov    %rsp,%rbp
  80040c:	53                   	push   %rbx
  80040d:	48 83 ec 38          	sub    $0x38,%rsp
  800411:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800415:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800419:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80041d:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800420:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800424:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800428:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80042b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80042f:	77 3b                	ja     80046c <printnum+0x64>
  800431:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800434:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800438:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  80043b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80043f:	ba 00 00 00 00       	mov    $0x0,%edx
  800444:	48 f7 f3             	div    %rbx
  800447:	48 89 c2             	mov    %rax,%rdx
  80044a:	8b 7d cc             	mov    -0x34(%rbp),%edi
  80044d:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800450:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800454:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800458:	41 89 f9             	mov    %edi,%r9d
  80045b:	48 89 c7             	mov    %rax,%rdi
  80045e:	48 b8 08 04 80 00 00 	movabs $0x800408,%rax
  800465:	00 00 00 
  800468:	ff d0                	callq  *%rax
  80046a:	eb 1e                	jmp    80048a <printnum+0x82>
  80046c:	eb 12                	jmp    800480 <printnum+0x78>
  80046e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800472:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800475:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800479:	48 89 ce             	mov    %rcx,%rsi
  80047c:	89 d7                	mov    %edx,%edi
  80047e:	ff d0                	callq  *%rax
  800480:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800484:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800488:	7f e4                	jg     80046e <printnum+0x66>
  80048a:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80048d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800491:	ba 00 00 00 00       	mov    $0x0,%edx
  800496:	48 f7 f1             	div    %rcx
  800499:	48 89 d0             	mov    %rdx,%rax
  80049c:	48 ba f0 49 80 00 00 	movabs $0x8049f0,%rdx
  8004a3:	00 00 00 
  8004a6:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8004aa:	0f be d0             	movsbl %al,%edx
  8004ad:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8004b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004b5:	48 89 ce             	mov    %rcx,%rsi
  8004b8:	89 d7                	mov    %edx,%edi
  8004ba:	ff d0                	callq  *%rax
  8004bc:	48 83 c4 38          	add    $0x38,%rsp
  8004c0:	5b                   	pop    %rbx
  8004c1:	5d                   	pop    %rbp
  8004c2:	c3                   	retq   

00000000008004c3 <getuint>:
  8004c3:	55                   	push   %rbp
  8004c4:	48 89 e5             	mov    %rsp,%rbp
  8004c7:	48 83 ec 1c          	sub    $0x1c,%rsp
  8004cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8004cf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8004d2:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8004d6:	7e 52                	jle    80052a <getuint+0x67>
  8004d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004dc:	8b 00                	mov    (%rax),%eax
  8004de:	83 f8 30             	cmp    $0x30,%eax
  8004e1:	73 24                	jae    800507 <getuint+0x44>
  8004e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004e7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8004eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004ef:	8b 00                	mov    (%rax),%eax
  8004f1:	89 c0                	mov    %eax,%eax
  8004f3:	48 01 d0             	add    %rdx,%rax
  8004f6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8004fa:	8b 12                	mov    (%rdx),%edx
  8004fc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8004ff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800503:	89 0a                	mov    %ecx,(%rdx)
  800505:	eb 17                	jmp    80051e <getuint+0x5b>
  800507:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80050b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80050f:	48 89 d0             	mov    %rdx,%rax
  800512:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800516:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80051a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80051e:	48 8b 00             	mov    (%rax),%rax
  800521:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800525:	e9 a3 00 00 00       	jmpq   8005cd <getuint+0x10a>
  80052a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80052e:	74 4f                	je     80057f <getuint+0xbc>
  800530:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800534:	8b 00                	mov    (%rax),%eax
  800536:	83 f8 30             	cmp    $0x30,%eax
  800539:	73 24                	jae    80055f <getuint+0x9c>
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
  80055d:	eb 17                	jmp    800576 <getuint+0xb3>
  80055f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800563:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800567:	48 89 d0             	mov    %rdx,%rax
  80056a:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80056e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800572:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800576:	48 8b 00             	mov    (%rax),%rax
  800579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80057d:	eb 4e                	jmp    8005cd <getuint+0x10a>
  80057f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800583:	8b 00                	mov    (%rax),%eax
  800585:	83 f8 30             	cmp    $0x30,%eax
  800588:	73 24                	jae    8005ae <getuint+0xeb>
  80058a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80058e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800592:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800596:	8b 00                	mov    (%rax),%eax
  800598:	89 c0                	mov    %eax,%eax
  80059a:	48 01 d0             	add    %rdx,%rax
  80059d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005a1:	8b 12                	mov    (%rdx),%edx
  8005a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005a6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005aa:	89 0a                	mov    %ecx,(%rdx)
  8005ac:	eb 17                	jmp    8005c5 <getuint+0x102>
  8005ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005b2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005b6:	48 89 d0             	mov    %rdx,%rax
  8005b9:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8005bd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005c1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8005c5:	8b 00                	mov    (%rax),%eax
  8005c7:	89 c0                	mov    %eax,%eax
  8005c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005d1:	c9                   	leaveq 
  8005d2:	c3                   	retq   

00000000008005d3 <getint>:
  8005d3:	55                   	push   %rbp
  8005d4:	48 89 e5             	mov    %rsp,%rbp
  8005d7:	48 83 ec 1c          	sub    $0x1c,%rsp
  8005db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8005df:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8005e2:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8005e6:	7e 52                	jle    80063a <getint+0x67>
  8005e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ec:	8b 00                	mov    (%rax),%eax
  8005ee:	83 f8 30             	cmp    $0x30,%eax
  8005f1:	73 24                	jae    800617 <getint+0x44>
  8005f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005f7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8005fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ff:	8b 00                	mov    (%rax),%eax
  800601:	89 c0                	mov    %eax,%eax
  800603:	48 01 d0             	add    %rdx,%rax
  800606:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80060a:	8b 12                	mov    (%rdx),%edx
  80060c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80060f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800613:	89 0a                	mov    %ecx,(%rdx)
  800615:	eb 17                	jmp    80062e <getint+0x5b>
  800617:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80061b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80061f:	48 89 d0             	mov    %rdx,%rax
  800622:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800626:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80062a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80062e:	48 8b 00             	mov    (%rax),%rax
  800631:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800635:	e9 a3 00 00 00       	jmpq   8006dd <getint+0x10a>
  80063a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80063e:	74 4f                	je     80068f <getint+0xbc>
  800640:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800644:	8b 00                	mov    (%rax),%eax
  800646:	83 f8 30             	cmp    $0x30,%eax
  800649:	73 24                	jae    80066f <getint+0x9c>
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
  80066d:	eb 17                	jmp    800686 <getint+0xb3>
  80066f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800673:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800677:	48 89 d0             	mov    %rdx,%rax
  80067a:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80067e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800682:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800686:	48 8b 00             	mov    (%rax),%rax
  800689:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80068d:	eb 4e                	jmp    8006dd <getint+0x10a>
  80068f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800693:	8b 00                	mov    (%rax),%eax
  800695:	83 f8 30             	cmp    $0x30,%eax
  800698:	73 24                	jae    8006be <getint+0xeb>
  80069a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80069e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006a6:	8b 00                	mov    (%rax),%eax
  8006a8:	89 c0                	mov    %eax,%eax
  8006aa:	48 01 d0             	add    %rdx,%rax
  8006ad:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006b1:	8b 12                	mov    (%rdx),%edx
  8006b3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006ba:	89 0a                	mov    %ecx,(%rdx)
  8006bc:	eb 17                	jmp    8006d5 <getint+0x102>
  8006be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006c2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006c6:	48 89 d0             	mov    %rdx,%rax
  8006c9:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006cd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006d1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006d5:	8b 00                	mov    (%rax),%eax
  8006d7:	48 98                	cltq   
  8006d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006e1:	c9                   	leaveq 
  8006e2:	c3                   	retq   

00000000008006e3 <vprintfmt>:
  8006e3:	55                   	push   %rbp
  8006e4:	48 89 e5             	mov    %rsp,%rbp
  8006e7:	41 54                	push   %r12
  8006e9:	53                   	push   %rbx
  8006ea:	48 83 ec 60          	sub    $0x60,%rsp
  8006ee:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  8006f2:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8006f6:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8006fa:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8006fe:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800702:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800706:	48 8b 0a             	mov    (%rdx),%rcx
  800709:	48 89 08             	mov    %rcx,(%rax)
  80070c:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800710:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800714:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800718:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80071c:	eb 17                	jmp    800735 <vprintfmt+0x52>
  80071e:	85 db                	test   %ebx,%ebx
  800720:	0f 84 cc 04 00 00    	je     800bf2 <vprintfmt+0x50f>
  800726:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80072a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80072e:	48 89 d6             	mov    %rdx,%rsi
  800731:	89 df                	mov    %ebx,%edi
  800733:	ff d0                	callq  *%rax
  800735:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800739:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80073d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800741:	0f b6 00             	movzbl (%rax),%eax
  800744:	0f b6 d8             	movzbl %al,%ebx
  800747:	83 fb 25             	cmp    $0x25,%ebx
  80074a:	75 d2                	jne    80071e <vprintfmt+0x3b>
  80074c:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800750:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800757:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80075e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800765:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  80076c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800770:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800774:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800778:	0f b6 00             	movzbl (%rax),%eax
  80077b:	0f b6 d8             	movzbl %al,%ebx
  80077e:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800781:	83 f8 55             	cmp    $0x55,%eax
  800784:	0f 87 34 04 00 00    	ja     800bbe <vprintfmt+0x4db>
  80078a:	89 c0                	mov    %eax,%eax
  80078c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800793:	00 
  800794:	48 b8 18 4a 80 00 00 	movabs $0x804a18,%rax
  80079b:	00 00 00 
  80079e:	48 01 d0             	add    %rdx,%rax
  8007a1:	48 8b 00             	mov    (%rax),%rax
  8007a4:	ff e0                	jmpq   *%rax
  8007a6:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8007aa:	eb c0                	jmp    80076c <vprintfmt+0x89>
  8007ac:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8007b0:	eb ba                	jmp    80076c <vprintfmt+0x89>
  8007b2:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8007b9:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8007bc:	89 d0                	mov    %edx,%eax
  8007be:	c1 e0 02             	shl    $0x2,%eax
  8007c1:	01 d0                	add    %edx,%eax
  8007c3:	01 c0                	add    %eax,%eax
  8007c5:	01 d8                	add    %ebx,%eax
  8007c7:	83 e8 30             	sub    $0x30,%eax
  8007ca:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8007cd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8007d1:	0f b6 00             	movzbl (%rax),%eax
  8007d4:	0f be d8             	movsbl %al,%ebx
  8007d7:	83 fb 2f             	cmp    $0x2f,%ebx
  8007da:	7e 0c                	jle    8007e8 <vprintfmt+0x105>
  8007dc:	83 fb 39             	cmp    $0x39,%ebx
  8007df:	7f 07                	jg     8007e8 <vprintfmt+0x105>
  8007e1:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  8007e6:	eb d1                	jmp    8007b9 <vprintfmt+0xd6>
  8007e8:	eb 58                	jmp    800842 <vprintfmt+0x15f>
  8007ea:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007ed:	83 f8 30             	cmp    $0x30,%eax
  8007f0:	73 17                	jae    800809 <vprintfmt+0x126>
  8007f2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8007f6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8007f9:	89 c0                	mov    %eax,%eax
  8007fb:	48 01 d0             	add    %rdx,%rax
  8007fe:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800801:	83 c2 08             	add    $0x8,%edx
  800804:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800807:	eb 0f                	jmp    800818 <vprintfmt+0x135>
  800809:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80080d:	48 89 d0             	mov    %rdx,%rax
  800810:	48 83 c2 08          	add    $0x8,%rdx
  800814:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800818:	8b 00                	mov    (%rax),%eax
  80081a:	89 45 d8             	mov    %eax,-0x28(%rbp)
  80081d:	eb 23                	jmp    800842 <vprintfmt+0x15f>
  80081f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800823:	79 0c                	jns    800831 <vprintfmt+0x14e>
  800825:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  80082c:	e9 3b ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  800831:	e9 36 ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  800836:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  80083d:	e9 2a ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  800842:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800846:	79 12                	jns    80085a <vprintfmt+0x177>
  800848:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80084b:	89 45 dc             	mov    %eax,-0x24(%rbp)
  80084e:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800855:	e9 12 ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  80085a:	e9 0d ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  80085f:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800863:	e9 04 ff ff ff       	jmpq   80076c <vprintfmt+0x89>
  800868:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80086b:	83 f8 30             	cmp    $0x30,%eax
  80086e:	73 17                	jae    800887 <vprintfmt+0x1a4>
  800870:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800874:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800877:	89 c0                	mov    %eax,%eax
  800879:	48 01 d0             	add    %rdx,%rax
  80087c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80087f:	83 c2 08             	add    $0x8,%edx
  800882:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800885:	eb 0f                	jmp    800896 <vprintfmt+0x1b3>
  800887:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80088b:	48 89 d0             	mov    %rdx,%rax
  80088e:	48 83 c2 08          	add    $0x8,%rdx
  800892:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800896:	8b 10                	mov    (%rax),%edx
  800898:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  80089c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8008a0:	48 89 ce             	mov    %rcx,%rsi
  8008a3:	89 d7                	mov    %edx,%edi
  8008a5:	ff d0                	callq  *%rax
  8008a7:	e9 40 03 00 00       	jmpq   800bec <vprintfmt+0x509>
  8008ac:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008af:	83 f8 30             	cmp    $0x30,%eax
  8008b2:	73 17                	jae    8008cb <vprintfmt+0x1e8>
  8008b4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8008b8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008bb:	89 c0                	mov    %eax,%eax
  8008bd:	48 01 d0             	add    %rdx,%rax
  8008c0:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8008c3:	83 c2 08             	add    $0x8,%edx
  8008c6:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8008c9:	eb 0f                	jmp    8008da <vprintfmt+0x1f7>
  8008cb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8008cf:	48 89 d0             	mov    %rdx,%rax
  8008d2:	48 83 c2 08          	add    $0x8,%rdx
  8008d6:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8008da:	8b 18                	mov    (%rax),%ebx
  8008dc:	85 db                	test   %ebx,%ebx
  8008de:	79 02                	jns    8008e2 <vprintfmt+0x1ff>
  8008e0:	f7 db                	neg    %ebx
  8008e2:	83 fb 15             	cmp    $0x15,%ebx
  8008e5:	7f 16                	jg     8008fd <vprintfmt+0x21a>
  8008e7:	48 b8 40 49 80 00 00 	movabs $0x804940,%rax
  8008ee:	00 00 00 
  8008f1:	48 63 d3             	movslq %ebx,%rdx
  8008f4:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  8008f8:	4d 85 e4             	test   %r12,%r12
  8008fb:	75 2e                	jne    80092b <vprintfmt+0x248>
  8008fd:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800901:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800905:	89 d9                	mov    %ebx,%ecx
  800907:	48 ba 01 4a 80 00 00 	movabs $0x804a01,%rdx
  80090e:	00 00 00 
  800911:	48 89 c7             	mov    %rax,%rdi
  800914:	b8 00 00 00 00       	mov    $0x0,%eax
  800919:	49 b8 fb 0b 80 00 00 	movabs $0x800bfb,%r8
  800920:	00 00 00 
  800923:	41 ff d0             	callq  *%r8
  800926:	e9 c1 02 00 00       	jmpq   800bec <vprintfmt+0x509>
  80092b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80092f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800933:	4c 89 e1             	mov    %r12,%rcx
  800936:	48 ba 0a 4a 80 00 00 	movabs $0x804a0a,%rdx
  80093d:	00 00 00 
  800940:	48 89 c7             	mov    %rax,%rdi
  800943:	b8 00 00 00 00       	mov    $0x0,%eax
  800948:	49 b8 fb 0b 80 00 00 	movabs $0x800bfb,%r8
  80094f:	00 00 00 
  800952:	41 ff d0             	callq  *%r8
  800955:	e9 92 02 00 00       	jmpq   800bec <vprintfmt+0x509>
  80095a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80095d:	83 f8 30             	cmp    $0x30,%eax
  800960:	73 17                	jae    800979 <vprintfmt+0x296>
  800962:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800966:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800969:	89 c0                	mov    %eax,%eax
  80096b:	48 01 d0             	add    %rdx,%rax
  80096e:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800971:	83 c2 08             	add    $0x8,%edx
  800974:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800977:	eb 0f                	jmp    800988 <vprintfmt+0x2a5>
  800979:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80097d:	48 89 d0             	mov    %rdx,%rax
  800980:	48 83 c2 08          	add    $0x8,%rdx
  800984:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800988:	4c 8b 20             	mov    (%rax),%r12
  80098b:	4d 85 e4             	test   %r12,%r12
  80098e:	75 0a                	jne    80099a <vprintfmt+0x2b7>
  800990:	49 bc 0d 4a 80 00 00 	movabs $0x804a0d,%r12
  800997:	00 00 00 
  80099a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80099e:	7e 3f                	jle    8009df <vprintfmt+0x2fc>
  8009a0:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  8009a4:	74 39                	je     8009df <vprintfmt+0x2fc>
  8009a6:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8009a9:	48 98                	cltq   
  8009ab:	48 89 c6             	mov    %rax,%rsi
  8009ae:	4c 89 e7             	mov    %r12,%rdi
  8009b1:	48 b8 a7 0e 80 00 00 	movabs $0x800ea7,%rax
  8009b8:	00 00 00 
  8009bb:	ff d0                	callq  *%rax
  8009bd:	29 45 dc             	sub    %eax,-0x24(%rbp)
  8009c0:	eb 17                	jmp    8009d9 <vprintfmt+0x2f6>
  8009c2:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  8009c6:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8009ca:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009ce:	48 89 ce             	mov    %rcx,%rsi
  8009d1:	89 d7                	mov    %edx,%edi
  8009d3:	ff d0                	callq  *%rax
  8009d5:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  8009d9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009dd:	7f e3                	jg     8009c2 <vprintfmt+0x2df>
  8009df:	eb 37                	jmp    800a18 <vprintfmt+0x335>
  8009e1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  8009e5:	74 1e                	je     800a05 <vprintfmt+0x322>
  8009e7:	83 fb 1f             	cmp    $0x1f,%ebx
  8009ea:	7e 05                	jle    8009f1 <vprintfmt+0x30e>
  8009ec:	83 fb 7e             	cmp    $0x7e,%ebx
  8009ef:	7e 14                	jle    800a05 <vprintfmt+0x322>
  8009f1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8009f5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009f9:	48 89 d6             	mov    %rdx,%rsi
  8009fc:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800a01:	ff d0                	callq  *%rax
  800a03:	eb 0f                	jmp    800a14 <vprintfmt+0x331>
  800a05:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a09:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a0d:	48 89 d6             	mov    %rdx,%rsi
  800a10:	89 df                	mov    %ebx,%edi
  800a12:	ff d0                	callq  *%rax
  800a14:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a18:	4c 89 e0             	mov    %r12,%rax
  800a1b:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800a1f:	0f b6 00             	movzbl (%rax),%eax
  800a22:	0f be d8             	movsbl %al,%ebx
  800a25:	85 db                	test   %ebx,%ebx
  800a27:	74 10                	je     800a39 <vprintfmt+0x356>
  800a29:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800a2d:	78 b2                	js     8009e1 <vprintfmt+0x2fe>
  800a2f:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800a33:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800a37:	79 a8                	jns    8009e1 <vprintfmt+0x2fe>
  800a39:	eb 16                	jmp    800a51 <vprintfmt+0x36e>
  800a3b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a3f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a43:	48 89 d6             	mov    %rdx,%rsi
  800a46:	bf 20 00 00 00       	mov    $0x20,%edi
  800a4b:	ff d0                	callq  *%rax
  800a4d:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a51:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a55:	7f e4                	jg     800a3b <vprintfmt+0x358>
  800a57:	e9 90 01 00 00       	jmpq   800bec <vprintfmt+0x509>
  800a5c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800a60:	be 03 00 00 00       	mov    $0x3,%esi
  800a65:	48 89 c7             	mov    %rax,%rdi
  800a68:	48 b8 d3 05 80 00 00 	movabs $0x8005d3,%rax
  800a6f:	00 00 00 
  800a72:	ff d0                	callq  *%rax
  800a74:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a7c:	48 85 c0             	test   %rax,%rax
  800a7f:	79 1d                	jns    800a9e <vprintfmt+0x3bb>
  800a81:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a85:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a89:	48 89 d6             	mov    %rdx,%rsi
  800a8c:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800a91:	ff d0                	callq  *%rax
  800a93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a97:	48 f7 d8             	neg    %rax
  800a9a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a9e:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800aa5:	e9 d5 00 00 00       	jmpq   800b7f <vprintfmt+0x49c>
  800aaa:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800aae:	be 03 00 00 00       	mov    $0x3,%esi
  800ab3:	48 89 c7             	mov    %rax,%rdi
  800ab6:	48 b8 c3 04 80 00 00 	movabs $0x8004c3,%rax
  800abd:	00 00 00 
  800ac0:	ff d0                	callq  *%rax
  800ac2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ac6:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800acd:	e9 ad 00 00 00       	jmpq   800b7f <vprintfmt+0x49c>
  800ad2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ad6:	be 03 00 00 00       	mov    $0x3,%esi
  800adb:	48 89 c7             	mov    %rax,%rdi
  800ade:	48 b8 c3 04 80 00 00 	movabs $0x8004c3,%rax
  800ae5:	00 00 00 
  800ae8:	ff d0                	callq  *%rax
  800aea:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800aee:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800af5:	e9 85 00 00 00       	jmpq   800b7f <vprintfmt+0x49c>
  800afa:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800afe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b02:	48 89 d6             	mov    %rdx,%rsi
  800b05:	bf 30 00 00 00       	mov    $0x30,%edi
  800b0a:	ff d0                	callq  *%rax
  800b0c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b10:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b14:	48 89 d6             	mov    %rdx,%rsi
  800b17:	bf 78 00 00 00       	mov    $0x78,%edi
  800b1c:	ff d0                	callq  *%rax
  800b1e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b21:	83 f8 30             	cmp    $0x30,%eax
  800b24:	73 17                	jae    800b3d <vprintfmt+0x45a>
  800b26:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b2a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b2d:	89 c0                	mov    %eax,%eax
  800b2f:	48 01 d0             	add    %rdx,%rax
  800b32:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b35:	83 c2 08             	add    $0x8,%edx
  800b38:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b3b:	eb 0f                	jmp    800b4c <vprintfmt+0x469>
  800b3d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b41:	48 89 d0             	mov    %rdx,%rax
  800b44:	48 83 c2 08          	add    $0x8,%rdx
  800b48:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b4c:	48 8b 00             	mov    (%rax),%rax
  800b4f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b53:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800b5a:	eb 23                	jmp    800b7f <vprintfmt+0x49c>
  800b5c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b60:	be 03 00 00 00       	mov    $0x3,%esi
  800b65:	48 89 c7             	mov    %rax,%rdi
  800b68:	48 b8 c3 04 80 00 00 	movabs $0x8004c3,%rax
  800b6f:	00 00 00 
  800b72:	ff d0                	callq  *%rax
  800b74:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b78:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800b7f:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800b84:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800b87:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800b8a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b8e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800b92:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b96:	45 89 c1             	mov    %r8d,%r9d
  800b99:	41 89 f8             	mov    %edi,%r8d
  800b9c:	48 89 c7             	mov    %rax,%rdi
  800b9f:	48 b8 08 04 80 00 00 	movabs $0x800408,%rax
  800ba6:	00 00 00 
  800ba9:	ff d0                	callq  *%rax
  800bab:	eb 3f                	jmp    800bec <vprintfmt+0x509>
  800bad:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bb1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bb5:	48 89 d6             	mov    %rdx,%rsi
  800bb8:	89 df                	mov    %ebx,%edi
  800bba:	ff d0                	callq  *%rax
  800bbc:	eb 2e                	jmp    800bec <vprintfmt+0x509>
  800bbe:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bc2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bc6:	48 89 d6             	mov    %rdx,%rsi
  800bc9:	bf 25 00 00 00       	mov    $0x25,%edi
  800bce:	ff d0                	callq  *%rax
  800bd0:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800bd5:	eb 05                	jmp    800bdc <vprintfmt+0x4f9>
  800bd7:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800bdc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800be0:	48 83 e8 01          	sub    $0x1,%rax
  800be4:	0f b6 00             	movzbl (%rax),%eax
  800be7:	3c 25                	cmp    $0x25,%al
  800be9:	75 ec                	jne    800bd7 <vprintfmt+0x4f4>
  800beb:	90                   	nop
  800bec:	90                   	nop
  800bed:	e9 43 fb ff ff       	jmpq   800735 <vprintfmt+0x52>
  800bf2:	48 83 c4 60          	add    $0x60,%rsp
  800bf6:	5b                   	pop    %rbx
  800bf7:	41 5c                	pop    %r12
  800bf9:	5d                   	pop    %rbp
  800bfa:	c3                   	retq   

0000000000800bfb <printfmt>:
  800bfb:	55                   	push   %rbp
  800bfc:	48 89 e5             	mov    %rsp,%rbp
  800bff:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800c06:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800c0d:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800c14:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800c1b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800c22:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800c29:	84 c0                	test   %al,%al
  800c2b:	74 20                	je     800c4d <printfmt+0x52>
  800c2d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800c31:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800c35:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800c39:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800c3d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800c41:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800c45:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800c49:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800c4d:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800c54:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800c5b:	00 00 00 
  800c5e:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800c65:	00 00 00 
  800c68:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800c6c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800c73:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800c7a:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800c81:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800c88:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800c8f:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800c96:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800c9d:	48 89 c7             	mov    %rax,%rdi
  800ca0:	48 b8 e3 06 80 00 00 	movabs $0x8006e3,%rax
  800ca7:	00 00 00 
  800caa:	ff d0                	callq  *%rax
  800cac:	c9                   	leaveq 
  800cad:	c3                   	retq   

0000000000800cae <sprintputch>:
  800cae:	55                   	push   %rbp
  800caf:	48 89 e5             	mov    %rsp,%rbp
  800cb2:	48 83 ec 10          	sub    $0x10,%rsp
  800cb6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800cb9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800cbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800cc1:	8b 40 10             	mov    0x10(%rax),%eax
  800cc4:	8d 50 01             	lea    0x1(%rax),%edx
  800cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ccb:	89 50 10             	mov    %edx,0x10(%rax)
  800cce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800cd2:	48 8b 10             	mov    (%rax),%rdx
  800cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800cd9:	48 8b 40 08          	mov    0x8(%rax),%rax
  800cdd:	48 39 c2             	cmp    %rax,%rdx
  800ce0:	73 17                	jae    800cf9 <sprintputch+0x4b>
  800ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ce6:	48 8b 00             	mov    (%rax),%rax
  800ce9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800ced:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800cf1:	48 89 0a             	mov    %rcx,(%rdx)
  800cf4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800cf7:	88 10                	mov    %dl,(%rax)
  800cf9:	c9                   	leaveq 
  800cfa:	c3                   	retq   

0000000000800cfb <vsnprintf>:
  800cfb:	55                   	push   %rbp
  800cfc:	48 89 e5             	mov    %rsp,%rbp
  800cff:	48 83 ec 50          	sub    $0x50,%rsp
  800d03:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800d07:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800d0a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800d0e:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800d12:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800d16:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800d1a:	48 8b 0a             	mov    (%rdx),%rcx
  800d1d:	48 89 08             	mov    %rcx,(%rax)
  800d20:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800d24:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800d28:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800d2c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800d30:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800d34:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800d38:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800d3b:	48 98                	cltq   
  800d3d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800d41:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800d45:	48 01 d0             	add    %rdx,%rax
  800d48:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800d4c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800d53:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800d58:	74 06                	je     800d60 <vsnprintf+0x65>
  800d5a:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800d5e:	7f 07                	jg     800d67 <vsnprintf+0x6c>
  800d60:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800d65:	eb 2f                	jmp    800d96 <vsnprintf+0x9b>
  800d67:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800d6b:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800d6f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800d73:	48 89 c6             	mov    %rax,%rsi
  800d76:	48 bf ae 0c 80 00 00 	movabs $0x800cae,%rdi
  800d7d:	00 00 00 
  800d80:	48 b8 e3 06 80 00 00 	movabs $0x8006e3,%rax
  800d87:	00 00 00 
  800d8a:	ff d0                	callq  *%rax
  800d8c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800d90:	c6 00 00             	movb   $0x0,(%rax)
  800d93:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800d96:	c9                   	leaveq 
  800d97:	c3                   	retq   

0000000000800d98 <snprintf>:
  800d98:	55                   	push   %rbp
  800d99:	48 89 e5             	mov    %rsp,%rbp
  800d9c:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800da3:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800daa:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800db0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800db7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800dbe:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800dc5:	84 c0                	test   %al,%al
  800dc7:	74 20                	je     800de9 <snprintf+0x51>
  800dc9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800dcd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800dd1:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800dd5:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800dd9:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800ddd:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800de1:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800de5:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800de9:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800df0:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800df7:	00 00 00 
  800dfa:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800e01:	00 00 00 
  800e04:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800e08:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800e0f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800e16:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800e1d:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800e24:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800e2b:	48 8b 0a             	mov    (%rdx),%rcx
  800e2e:	48 89 08             	mov    %rcx,(%rax)
  800e31:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800e35:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800e39:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800e3d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800e41:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800e48:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800e4f:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800e55:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800e5c:	48 89 c7             	mov    %rax,%rdi
  800e5f:	48 b8 fb 0c 80 00 00 	movabs $0x800cfb,%rax
  800e66:	00 00 00 
  800e69:	ff d0                	callq  *%rax
  800e6b:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800e71:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800e77:	c9                   	leaveq 
  800e78:	c3                   	retq   

0000000000800e79 <strlen>:
  800e79:	55                   	push   %rbp
  800e7a:	48 89 e5             	mov    %rsp,%rbp
  800e7d:	48 83 ec 18          	sub    $0x18,%rsp
  800e81:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800e85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800e8c:	eb 09                	jmp    800e97 <strlen+0x1e>
  800e8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800e92:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800e97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e9b:	0f b6 00             	movzbl (%rax),%eax
  800e9e:	84 c0                	test   %al,%al
  800ea0:	75 ec                	jne    800e8e <strlen+0x15>
  800ea2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ea5:	c9                   	leaveq 
  800ea6:	c3                   	retq   

0000000000800ea7 <strnlen>:
  800ea7:	55                   	push   %rbp
  800ea8:	48 89 e5             	mov    %rsp,%rbp
  800eab:	48 83 ec 20          	sub    $0x20,%rsp
  800eaf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800eb3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800eb7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800ebe:	eb 0e                	jmp    800ece <strnlen+0x27>
  800ec0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800ec4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800ec9:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  800ece:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800ed3:	74 0b                	je     800ee0 <strnlen+0x39>
  800ed5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ed9:	0f b6 00             	movzbl (%rax),%eax
  800edc:	84 c0                	test   %al,%al
  800ede:	75 e0                	jne    800ec0 <strnlen+0x19>
  800ee0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ee3:	c9                   	leaveq 
  800ee4:	c3                   	retq   

0000000000800ee5 <strcpy>:
  800ee5:	55                   	push   %rbp
  800ee6:	48 89 e5             	mov    %rsp,%rbp
  800ee9:	48 83 ec 20          	sub    $0x20,%rsp
  800eed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800ef1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800ef5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ef9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800efd:	90                   	nop
  800efe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f02:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800f06:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800f0a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800f0e:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800f12:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800f16:	0f b6 12             	movzbl (%rdx),%edx
  800f19:	88 10                	mov    %dl,(%rax)
  800f1b:	0f b6 00             	movzbl (%rax),%eax
  800f1e:	84 c0                	test   %al,%al
  800f20:	75 dc                	jne    800efe <strcpy+0x19>
  800f22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800f26:	c9                   	leaveq 
  800f27:	c3                   	retq   

0000000000800f28 <strcat>:
  800f28:	55                   	push   %rbp
  800f29:	48 89 e5             	mov    %rsp,%rbp
  800f2c:	48 83 ec 20          	sub    $0x20,%rsp
  800f30:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f34:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f3c:	48 89 c7             	mov    %rax,%rdi
  800f3f:	48 b8 79 0e 80 00 00 	movabs $0x800e79,%rax
  800f46:	00 00 00 
  800f49:	ff d0                	callq  *%rax
  800f4b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800f4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f51:	48 63 d0             	movslq %eax,%rdx
  800f54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f58:	48 01 c2             	add    %rax,%rdx
  800f5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800f5f:	48 89 c6             	mov    %rax,%rsi
  800f62:	48 89 d7             	mov    %rdx,%rdi
  800f65:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  800f6c:	00 00 00 
  800f6f:	ff d0                	callq  *%rax
  800f71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f75:	c9                   	leaveq 
  800f76:	c3                   	retq   

0000000000800f77 <strncpy>:
  800f77:	55                   	push   %rbp
  800f78:	48 89 e5             	mov    %rsp,%rbp
  800f7b:	48 83 ec 28          	sub    $0x28,%rsp
  800f7f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f83:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f87:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800f8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800f93:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  800f9a:	00 
  800f9b:	eb 2a                	jmp    800fc7 <strncpy+0x50>
  800f9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fa1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800fa5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800fa9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800fad:	0f b6 12             	movzbl (%rdx),%edx
  800fb0:	88 10                	mov    %dl,(%rax)
  800fb2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800fb6:	0f b6 00             	movzbl (%rax),%eax
  800fb9:	84 c0                	test   %al,%al
  800fbb:	74 05                	je     800fc2 <strncpy+0x4b>
  800fbd:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  800fc2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fcb:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800fcf:	72 cc                	jb     800f9d <strncpy+0x26>
  800fd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fd5:	c9                   	leaveq 
  800fd6:	c3                   	retq   

0000000000800fd7 <strlcpy>:
  800fd7:	55                   	push   %rbp
  800fd8:	48 89 e5             	mov    %rsp,%rbp
  800fdb:	48 83 ec 28          	sub    $0x28,%rsp
  800fdf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fe3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fe7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800feb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800ff3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800ff8:	74 3d                	je     801037 <strlcpy+0x60>
  800ffa:	eb 1d                	jmp    801019 <strlcpy+0x42>
  800ffc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801000:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801004:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801008:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80100c:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801010:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801014:	0f b6 12             	movzbl (%rdx),%edx
  801017:	88 10                	mov    %dl,(%rax)
  801019:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80101e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801023:	74 0b                	je     801030 <strlcpy+0x59>
  801025:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801029:	0f b6 00             	movzbl (%rax),%eax
  80102c:	84 c0                	test   %al,%al
  80102e:	75 cc                	jne    800ffc <strlcpy+0x25>
  801030:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801034:	c6 00 00             	movb   $0x0,(%rax)
  801037:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80103b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80103f:	48 29 c2             	sub    %rax,%rdx
  801042:	48 89 d0             	mov    %rdx,%rax
  801045:	c9                   	leaveq 
  801046:	c3                   	retq   

0000000000801047 <strcmp>:
  801047:	55                   	push   %rbp
  801048:	48 89 e5             	mov    %rsp,%rbp
  80104b:	48 83 ec 10          	sub    $0x10,%rsp
  80104f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801053:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801057:	eb 0a                	jmp    801063 <strcmp+0x1c>
  801059:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80105e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801063:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801067:	0f b6 00             	movzbl (%rax),%eax
  80106a:	84 c0                	test   %al,%al
  80106c:	74 12                	je     801080 <strcmp+0x39>
  80106e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801072:	0f b6 10             	movzbl (%rax),%edx
  801075:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801079:	0f b6 00             	movzbl (%rax),%eax
  80107c:	38 c2                	cmp    %al,%dl
  80107e:	74 d9                	je     801059 <strcmp+0x12>
  801080:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801084:	0f b6 00             	movzbl (%rax),%eax
  801087:	0f b6 d0             	movzbl %al,%edx
  80108a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80108e:	0f b6 00             	movzbl (%rax),%eax
  801091:	0f b6 c0             	movzbl %al,%eax
  801094:	29 c2                	sub    %eax,%edx
  801096:	89 d0                	mov    %edx,%eax
  801098:	c9                   	leaveq 
  801099:	c3                   	retq   

000000000080109a <strncmp>:
  80109a:	55                   	push   %rbp
  80109b:	48 89 e5             	mov    %rsp,%rbp
  80109e:	48 83 ec 18          	sub    $0x18,%rsp
  8010a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8010a6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8010aa:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8010ae:	eb 0f                	jmp    8010bf <strncmp+0x25>
  8010b0:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8010b5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8010ba:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8010bf:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8010c4:	74 1d                	je     8010e3 <strncmp+0x49>
  8010c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010ca:	0f b6 00             	movzbl (%rax),%eax
  8010cd:	84 c0                	test   %al,%al
  8010cf:	74 12                	je     8010e3 <strncmp+0x49>
  8010d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010d5:	0f b6 10             	movzbl (%rax),%edx
  8010d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010dc:	0f b6 00             	movzbl (%rax),%eax
  8010df:	38 c2                	cmp    %al,%dl
  8010e1:	74 cd                	je     8010b0 <strncmp+0x16>
  8010e3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8010e8:	75 07                	jne    8010f1 <strncmp+0x57>
  8010ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8010ef:	eb 18                	jmp    801109 <strncmp+0x6f>
  8010f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010f5:	0f b6 00             	movzbl (%rax),%eax
  8010f8:	0f b6 d0             	movzbl %al,%edx
  8010fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010ff:	0f b6 00             	movzbl (%rax),%eax
  801102:	0f b6 c0             	movzbl %al,%eax
  801105:	29 c2                	sub    %eax,%edx
  801107:	89 d0                	mov    %edx,%eax
  801109:	c9                   	leaveq 
  80110a:	c3                   	retq   

000000000080110b <strchr>:
  80110b:	55                   	push   %rbp
  80110c:	48 89 e5             	mov    %rsp,%rbp
  80110f:	48 83 ec 0c          	sub    $0xc,%rsp
  801113:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801117:	89 f0                	mov    %esi,%eax
  801119:	88 45 f4             	mov    %al,-0xc(%rbp)
  80111c:	eb 17                	jmp    801135 <strchr+0x2a>
  80111e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801122:	0f b6 00             	movzbl (%rax),%eax
  801125:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801128:	75 06                	jne    801130 <strchr+0x25>
  80112a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80112e:	eb 15                	jmp    801145 <strchr+0x3a>
  801130:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801139:	0f b6 00             	movzbl (%rax),%eax
  80113c:	84 c0                	test   %al,%al
  80113e:	75 de                	jne    80111e <strchr+0x13>
  801140:	b8 00 00 00 00       	mov    $0x0,%eax
  801145:	c9                   	leaveq 
  801146:	c3                   	retq   

0000000000801147 <strfind>:
  801147:	55                   	push   %rbp
  801148:	48 89 e5             	mov    %rsp,%rbp
  80114b:	48 83 ec 0c          	sub    $0xc,%rsp
  80114f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801153:	89 f0                	mov    %esi,%eax
  801155:	88 45 f4             	mov    %al,-0xc(%rbp)
  801158:	eb 13                	jmp    80116d <strfind+0x26>
  80115a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80115e:	0f b6 00             	movzbl (%rax),%eax
  801161:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801164:	75 02                	jne    801168 <strfind+0x21>
  801166:	eb 10                	jmp    801178 <strfind+0x31>
  801168:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80116d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801171:	0f b6 00             	movzbl (%rax),%eax
  801174:	84 c0                	test   %al,%al
  801176:	75 e2                	jne    80115a <strfind+0x13>
  801178:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80117c:	c9                   	leaveq 
  80117d:	c3                   	retq   

000000000080117e <memset>:
  80117e:	55                   	push   %rbp
  80117f:	48 89 e5             	mov    %rsp,%rbp
  801182:	48 83 ec 18          	sub    $0x18,%rsp
  801186:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80118a:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80118d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801191:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801196:	75 06                	jne    80119e <memset+0x20>
  801198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80119c:	eb 69                	jmp    801207 <memset+0x89>
  80119e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011a2:	83 e0 03             	and    $0x3,%eax
  8011a5:	48 85 c0             	test   %rax,%rax
  8011a8:	75 48                	jne    8011f2 <memset+0x74>
  8011aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ae:	83 e0 03             	and    $0x3,%eax
  8011b1:	48 85 c0             	test   %rax,%rax
  8011b4:	75 3c                	jne    8011f2 <memset+0x74>
  8011b6:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8011bd:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8011c0:	c1 e0 18             	shl    $0x18,%eax
  8011c3:	89 c2                	mov    %eax,%edx
  8011c5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8011c8:	c1 e0 10             	shl    $0x10,%eax
  8011cb:	09 c2                	or     %eax,%edx
  8011cd:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8011d0:	c1 e0 08             	shl    $0x8,%eax
  8011d3:	09 d0                	or     %edx,%eax
  8011d5:	09 45 f4             	or     %eax,-0xc(%rbp)
  8011d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011dc:	48 c1 e8 02          	shr    $0x2,%rax
  8011e0:	48 89 c1             	mov    %rax,%rcx
  8011e3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8011e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8011ea:	48 89 d7             	mov    %rdx,%rdi
  8011ed:	fc                   	cld    
  8011ee:	f3 ab                	rep stos %eax,%es:(%rdi)
  8011f0:	eb 11                	jmp    801203 <memset+0x85>
  8011f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8011f6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8011f9:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8011fd:	48 89 d7             	mov    %rdx,%rdi
  801200:	fc                   	cld    
  801201:	f3 aa                	rep stos %al,%es:(%rdi)
  801203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801207:	c9                   	leaveq 
  801208:	c3                   	retq   

0000000000801209 <memmove>:
  801209:	55                   	push   %rbp
  80120a:	48 89 e5             	mov    %rsp,%rbp
  80120d:	48 83 ec 28          	sub    $0x28,%rsp
  801211:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801215:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801219:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80121d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801221:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801225:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801229:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80122d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801231:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801235:	0f 83 88 00 00 00    	jae    8012c3 <memmove+0xba>
  80123b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80123f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801243:	48 01 d0             	add    %rdx,%rax
  801246:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80124a:	76 77                	jbe    8012c3 <memmove+0xba>
  80124c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801250:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801254:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801258:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  80125c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801260:	83 e0 03             	and    $0x3,%eax
  801263:	48 85 c0             	test   %rax,%rax
  801266:	75 3b                	jne    8012a3 <memmove+0x9a>
  801268:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80126c:	83 e0 03             	and    $0x3,%eax
  80126f:	48 85 c0             	test   %rax,%rax
  801272:	75 2f                	jne    8012a3 <memmove+0x9a>
  801274:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801278:	83 e0 03             	and    $0x3,%eax
  80127b:	48 85 c0             	test   %rax,%rax
  80127e:	75 23                	jne    8012a3 <memmove+0x9a>
  801280:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801284:	48 83 e8 04          	sub    $0x4,%rax
  801288:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80128c:	48 83 ea 04          	sub    $0x4,%rdx
  801290:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801294:	48 c1 e9 02          	shr    $0x2,%rcx
  801298:	48 89 c7             	mov    %rax,%rdi
  80129b:	48 89 d6             	mov    %rdx,%rsi
  80129e:	fd                   	std    
  80129f:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8012a1:	eb 1d                	jmp    8012c0 <memmove+0xb7>
  8012a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012a7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8012ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012af:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8012b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012b7:	48 89 d7             	mov    %rdx,%rdi
  8012ba:	48 89 c1             	mov    %rax,%rcx
  8012bd:	fd                   	std    
  8012be:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8012c0:	fc                   	cld    
  8012c1:	eb 57                	jmp    80131a <memmove+0x111>
  8012c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012c7:	83 e0 03             	and    $0x3,%eax
  8012ca:	48 85 c0             	test   %rax,%rax
  8012cd:	75 36                	jne    801305 <memmove+0xfc>
  8012cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012d3:	83 e0 03             	and    $0x3,%eax
  8012d6:	48 85 c0             	test   %rax,%rax
  8012d9:	75 2a                	jne    801305 <memmove+0xfc>
  8012db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012df:	83 e0 03             	and    $0x3,%eax
  8012e2:	48 85 c0             	test   %rax,%rax
  8012e5:	75 1e                	jne    801305 <memmove+0xfc>
  8012e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012eb:	48 c1 e8 02          	shr    $0x2,%rax
  8012ef:	48 89 c1             	mov    %rax,%rcx
  8012f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012f6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8012fa:	48 89 c7             	mov    %rax,%rdi
  8012fd:	48 89 d6             	mov    %rdx,%rsi
  801300:	fc                   	cld    
  801301:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801303:	eb 15                	jmp    80131a <memmove+0x111>
  801305:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801309:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80130d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801311:	48 89 c7             	mov    %rax,%rdi
  801314:	48 89 d6             	mov    %rdx,%rsi
  801317:	fc                   	cld    
  801318:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80131a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80131e:	c9                   	leaveq 
  80131f:	c3                   	retq   

0000000000801320 <memcpy>:
  801320:	55                   	push   %rbp
  801321:	48 89 e5             	mov    %rsp,%rbp
  801324:	48 83 ec 18          	sub    $0x18,%rsp
  801328:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80132c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801330:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801334:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801338:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80133c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801340:	48 89 ce             	mov    %rcx,%rsi
  801343:	48 89 c7             	mov    %rax,%rdi
  801346:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  80134d:	00 00 00 
  801350:	ff d0                	callq  *%rax
  801352:	c9                   	leaveq 
  801353:	c3                   	retq   

0000000000801354 <memcmp>:
  801354:	55                   	push   %rbp
  801355:	48 89 e5             	mov    %rsp,%rbp
  801358:	48 83 ec 28          	sub    $0x28,%rsp
  80135c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801360:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801364:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801368:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80136c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801370:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801374:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801378:	eb 36                	jmp    8013b0 <memcmp+0x5c>
  80137a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80137e:	0f b6 10             	movzbl (%rax),%edx
  801381:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801385:	0f b6 00             	movzbl (%rax),%eax
  801388:	38 c2                	cmp    %al,%dl
  80138a:	74 1a                	je     8013a6 <memcmp+0x52>
  80138c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801390:	0f b6 00             	movzbl (%rax),%eax
  801393:	0f b6 d0             	movzbl %al,%edx
  801396:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80139a:	0f b6 00             	movzbl (%rax),%eax
  80139d:	0f b6 c0             	movzbl %al,%eax
  8013a0:	29 c2                	sub    %eax,%edx
  8013a2:	89 d0                	mov    %edx,%eax
  8013a4:	eb 20                	jmp    8013c6 <memcmp+0x72>
  8013a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8013ab:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8013b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013b4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8013b8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013bc:	48 85 c0             	test   %rax,%rax
  8013bf:	75 b9                	jne    80137a <memcmp+0x26>
  8013c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c6:	c9                   	leaveq 
  8013c7:	c3                   	retq   

00000000008013c8 <memfind>:
  8013c8:	55                   	push   %rbp
  8013c9:	48 89 e5             	mov    %rsp,%rbp
  8013cc:	48 83 ec 28          	sub    $0x28,%rsp
  8013d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013d4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8013d7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013df:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8013e3:	48 01 d0             	add    %rdx,%rax
  8013e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013ea:	eb 15                	jmp    801401 <memfind+0x39>
  8013ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013f0:	0f b6 10             	movzbl (%rax),%edx
  8013f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8013f6:	38 c2                	cmp    %al,%dl
  8013f8:	75 02                	jne    8013fc <memfind+0x34>
  8013fa:	eb 0f                	jmp    80140b <memfind+0x43>
  8013fc:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801401:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801405:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801409:	72 e1                	jb     8013ec <memfind+0x24>
  80140b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80140f:	c9                   	leaveq 
  801410:	c3                   	retq   

0000000000801411 <strtol>:
  801411:	55                   	push   %rbp
  801412:	48 89 e5             	mov    %rsp,%rbp
  801415:	48 83 ec 34          	sub    $0x34,%rsp
  801419:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80141d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801421:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801424:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80142b:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801432:	00 
  801433:	eb 05                	jmp    80143a <strtol+0x29>
  801435:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80143a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80143e:	0f b6 00             	movzbl (%rax),%eax
  801441:	3c 20                	cmp    $0x20,%al
  801443:	74 f0                	je     801435 <strtol+0x24>
  801445:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801449:	0f b6 00             	movzbl (%rax),%eax
  80144c:	3c 09                	cmp    $0x9,%al
  80144e:	74 e5                	je     801435 <strtol+0x24>
  801450:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801454:	0f b6 00             	movzbl (%rax),%eax
  801457:	3c 2b                	cmp    $0x2b,%al
  801459:	75 07                	jne    801462 <strtol+0x51>
  80145b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801460:	eb 17                	jmp    801479 <strtol+0x68>
  801462:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801466:	0f b6 00             	movzbl (%rax),%eax
  801469:	3c 2d                	cmp    $0x2d,%al
  80146b:	75 0c                	jne    801479 <strtol+0x68>
  80146d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801472:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801479:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80147d:	74 06                	je     801485 <strtol+0x74>
  80147f:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801483:	75 28                	jne    8014ad <strtol+0x9c>
  801485:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801489:	0f b6 00             	movzbl (%rax),%eax
  80148c:	3c 30                	cmp    $0x30,%al
  80148e:	75 1d                	jne    8014ad <strtol+0x9c>
  801490:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801494:	48 83 c0 01          	add    $0x1,%rax
  801498:	0f b6 00             	movzbl (%rax),%eax
  80149b:	3c 78                	cmp    $0x78,%al
  80149d:	75 0e                	jne    8014ad <strtol+0x9c>
  80149f:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8014a4:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8014ab:	eb 2c                	jmp    8014d9 <strtol+0xc8>
  8014ad:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8014b1:	75 19                	jne    8014cc <strtol+0xbb>
  8014b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014b7:	0f b6 00             	movzbl (%rax),%eax
  8014ba:	3c 30                	cmp    $0x30,%al
  8014bc:	75 0e                	jne    8014cc <strtol+0xbb>
  8014be:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014c3:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8014ca:	eb 0d                	jmp    8014d9 <strtol+0xc8>
  8014cc:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8014d0:	75 07                	jne    8014d9 <strtol+0xc8>
  8014d2:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8014d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014dd:	0f b6 00             	movzbl (%rax),%eax
  8014e0:	3c 2f                	cmp    $0x2f,%al
  8014e2:	7e 1d                	jle    801501 <strtol+0xf0>
  8014e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014e8:	0f b6 00             	movzbl (%rax),%eax
  8014eb:	3c 39                	cmp    $0x39,%al
  8014ed:	7f 12                	jg     801501 <strtol+0xf0>
  8014ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014f3:	0f b6 00             	movzbl (%rax),%eax
  8014f6:	0f be c0             	movsbl %al,%eax
  8014f9:	83 e8 30             	sub    $0x30,%eax
  8014fc:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8014ff:	eb 4e                	jmp    80154f <strtol+0x13e>
  801501:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801505:	0f b6 00             	movzbl (%rax),%eax
  801508:	3c 60                	cmp    $0x60,%al
  80150a:	7e 1d                	jle    801529 <strtol+0x118>
  80150c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801510:	0f b6 00             	movzbl (%rax),%eax
  801513:	3c 7a                	cmp    $0x7a,%al
  801515:	7f 12                	jg     801529 <strtol+0x118>
  801517:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80151b:	0f b6 00             	movzbl (%rax),%eax
  80151e:	0f be c0             	movsbl %al,%eax
  801521:	83 e8 57             	sub    $0x57,%eax
  801524:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801527:	eb 26                	jmp    80154f <strtol+0x13e>
  801529:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80152d:	0f b6 00             	movzbl (%rax),%eax
  801530:	3c 40                	cmp    $0x40,%al
  801532:	7e 48                	jle    80157c <strtol+0x16b>
  801534:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801538:	0f b6 00             	movzbl (%rax),%eax
  80153b:	3c 5a                	cmp    $0x5a,%al
  80153d:	7f 3d                	jg     80157c <strtol+0x16b>
  80153f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801543:	0f b6 00             	movzbl (%rax),%eax
  801546:	0f be c0             	movsbl %al,%eax
  801549:	83 e8 37             	sub    $0x37,%eax
  80154c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80154f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801552:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801555:	7c 02                	jl     801559 <strtol+0x148>
  801557:	eb 23                	jmp    80157c <strtol+0x16b>
  801559:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80155e:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801561:	48 98                	cltq   
  801563:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801568:	48 89 c2             	mov    %rax,%rdx
  80156b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80156e:	48 98                	cltq   
  801570:	48 01 d0             	add    %rdx,%rax
  801573:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801577:	e9 5d ff ff ff       	jmpq   8014d9 <strtol+0xc8>
  80157c:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801581:	74 0b                	je     80158e <strtol+0x17d>
  801583:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801587:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80158b:	48 89 10             	mov    %rdx,(%rax)
  80158e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801592:	74 09                	je     80159d <strtol+0x18c>
  801594:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801598:	48 f7 d8             	neg    %rax
  80159b:	eb 04                	jmp    8015a1 <strtol+0x190>
  80159d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015a1:	c9                   	leaveq 
  8015a2:	c3                   	retq   

00000000008015a3 <strstr>:
  8015a3:	55                   	push   %rbp
  8015a4:	48 89 e5             	mov    %rsp,%rbp
  8015a7:	48 83 ec 30          	sub    $0x30,%rsp
  8015ab:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8015af:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8015b3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8015b7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8015bb:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8015bf:	0f b6 00             	movzbl (%rax),%eax
  8015c2:	88 45 ff             	mov    %al,-0x1(%rbp)
  8015c5:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8015c9:	75 06                	jne    8015d1 <strstr+0x2e>
  8015cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015cf:	eb 6b                	jmp    80163c <strstr+0x99>
  8015d1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8015d5:	48 89 c7             	mov    %rax,%rdi
  8015d8:	48 b8 79 0e 80 00 00 	movabs $0x800e79,%rax
  8015df:	00 00 00 
  8015e2:	ff d0                	callq  *%rax
  8015e4:	48 98                	cltq   
  8015e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8015ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015ee:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8015f2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8015f6:	0f b6 00             	movzbl (%rax),%eax
  8015f9:	88 45 ef             	mov    %al,-0x11(%rbp)
  8015fc:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801600:	75 07                	jne    801609 <strstr+0x66>
  801602:	b8 00 00 00 00       	mov    $0x0,%eax
  801607:	eb 33                	jmp    80163c <strstr+0x99>
  801609:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80160d:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801610:	75 d8                	jne    8015ea <strstr+0x47>
  801612:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801616:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  80161a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80161e:	48 89 ce             	mov    %rcx,%rsi
  801621:	48 89 c7             	mov    %rax,%rdi
  801624:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  80162b:	00 00 00 
  80162e:	ff d0                	callq  *%rax
  801630:	85 c0                	test   %eax,%eax
  801632:	75 b6                	jne    8015ea <strstr+0x47>
  801634:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801638:	48 83 e8 01          	sub    $0x1,%rax
  80163c:	c9                   	leaveq 
  80163d:	c3                   	retq   

000000000080163e <syscall>:
  80163e:	55                   	push   %rbp
  80163f:	48 89 e5             	mov    %rsp,%rbp
  801642:	53                   	push   %rbx
  801643:	48 83 ec 48          	sub    $0x48,%rsp
  801647:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80164a:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80164d:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801651:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801655:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801659:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  80165d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801660:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801664:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801668:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  80166c:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801670:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801674:	4c 89 c3             	mov    %r8,%rbx
  801677:	cd 30                	int    $0x30
  801679:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80167d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801681:	74 3e                	je     8016c1 <syscall+0x83>
  801683:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801688:	7e 37                	jle    8016c1 <syscall+0x83>
  80168a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80168e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801691:	49 89 d0             	mov    %rdx,%r8
  801694:	89 c1                	mov    %eax,%ecx
  801696:	48 ba c8 4c 80 00 00 	movabs $0x804cc8,%rdx
  80169d:	00 00 00 
  8016a0:	be 24 00 00 00       	mov    $0x24,%esi
  8016a5:	48 bf e5 4c 80 00 00 	movabs $0x804ce5,%rdi
  8016ac:	00 00 00 
  8016af:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b4:	49 b9 bc 42 80 00 00 	movabs $0x8042bc,%r9
  8016bb:	00 00 00 
  8016be:	41 ff d1             	callq  *%r9
  8016c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016c5:	48 83 c4 48          	add    $0x48,%rsp
  8016c9:	5b                   	pop    %rbx
  8016ca:	5d                   	pop    %rbp
  8016cb:	c3                   	retq   

00000000008016cc <sys_cputs>:
  8016cc:	55                   	push   %rbp
  8016cd:	48 89 e5             	mov    %rsp,%rbp
  8016d0:	48 83 ec 20          	sub    $0x20,%rsp
  8016d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016d8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8016dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016e0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8016e4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8016eb:	00 
  8016ec:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8016f2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8016f8:	48 89 d1             	mov    %rdx,%rcx
  8016fb:	48 89 c2             	mov    %rax,%rdx
  8016fe:	be 00 00 00 00       	mov    $0x0,%esi
  801703:	bf 00 00 00 00       	mov    $0x0,%edi
  801708:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  80170f:	00 00 00 
  801712:	ff d0                	callq  *%rax
  801714:	c9                   	leaveq 
  801715:	c3                   	retq   

0000000000801716 <sys_cgetc>:
  801716:	55                   	push   %rbp
  801717:	48 89 e5             	mov    %rsp,%rbp
  80171a:	48 83 ec 10          	sub    $0x10,%rsp
  80171e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801725:	00 
  801726:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80172c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801732:	b9 00 00 00 00       	mov    $0x0,%ecx
  801737:	ba 00 00 00 00       	mov    $0x0,%edx
  80173c:	be 00 00 00 00       	mov    $0x0,%esi
  801741:	bf 01 00 00 00       	mov    $0x1,%edi
  801746:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  80174d:	00 00 00 
  801750:	ff d0                	callq  *%rax
  801752:	c9                   	leaveq 
  801753:	c3                   	retq   

0000000000801754 <sys_env_destroy>:
  801754:	55                   	push   %rbp
  801755:	48 89 e5             	mov    %rsp,%rbp
  801758:	48 83 ec 10          	sub    $0x10,%rsp
  80175c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80175f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801762:	48 98                	cltq   
  801764:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80176b:	00 
  80176c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801772:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801778:	b9 00 00 00 00       	mov    $0x0,%ecx
  80177d:	48 89 c2             	mov    %rax,%rdx
  801780:	be 01 00 00 00       	mov    $0x1,%esi
  801785:	bf 03 00 00 00       	mov    $0x3,%edi
  80178a:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801791:	00 00 00 
  801794:	ff d0                	callq  *%rax
  801796:	c9                   	leaveq 
  801797:	c3                   	retq   

0000000000801798 <sys_getenvid>:
  801798:	55                   	push   %rbp
  801799:	48 89 e5             	mov    %rsp,%rbp
  80179c:	48 83 ec 10          	sub    $0x10,%rsp
  8017a0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017a7:	00 
  8017a8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8017ae:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017b4:	b9 00 00 00 00       	mov    $0x0,%ecx
  8017b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8017be:	be 00 00 00 00       	mov    $0x0,%esi
  8017c3:	bf 02 00 00 00       	mov    $0x2,%edi
  8017c8:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  8017cf:	00 00 00 
  8017d2:	ff d0                	callq  *%rax
  8017d4:	c9                   	leaveq 
  8017d5:	c3                   	retq   

00000000008017d6 <sys_yield>:
  8017d6:	55                   	push   %rbp
  8017d7:	48 89 e5             	mov    %rsp,%rbp
  8017da:	48 83 ec 10          	sub    $0x10,%rsp
  8017de:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017e5:	00 
  8017e6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8017ec:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017f2:	b9 00 00 00 00       	mov    $0x0,%ecx
  8017f7:	ba 00 00 00 00       	mov    $0x0,%edx
  8017fc:	be 00 00 00 00       	mov    $0x0,%esi
  801801:	bf 0b 00 00 00       	mov    $0xb,%edi
  801806:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  80180d:	00 00 00 
  801810:	ff d0                	callq  *%rax
  801812:	c9                   	leaveq 
  801813:	c3                   	retq   

0000000000801814 <sys_page_alloc>:
  801814:	55                   	push   %rbp
  801815:	48 89 e5             	mov    %rsp,%rbp
  801818:	48 83 ec 20          	sub    $0x20,%rsp
  80181c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80181f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801823:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801826:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801829:	48 63 c8             	movslq %eax,%rcx
  80182c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801830:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801833:	48 98                	cltq   
  801835:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80183c:	00 
  80183d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801843:	49 89 c8             	mov    %rcx,%r8
  801846:	48 89 d1             	mov    %rdx,%rcx
  801849:	48 89 c2             	mov    %rax,%rdx
  80184c:	be 01 00 00 00       	mov    $0x1,%esi
  801851:	bf 04 00 00 00       	mov    $0x4,%edi
  801856:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  80185d:	00 00 00 
  801860:	ff d0                	callq  *%rax
  801862:	c9                   	leaveq 
  801863:	c3                   	retq   

0000000000801864 <sys_page_map>:
  801864:	55                   	push   %rbp
  801865:	48 89 e5             	mov    %rsp,%rbp
  801868:	48 83 ec 30          	sub    $0x30,%rsp
  80186c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80186f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801873:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801876:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80187a:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  80187e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801881:	48 63 c8             	movslq %eax,%rcx
  801884:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801888:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80188b:	48 63 f0             	movslq %eax,%rsi
  80188e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801892:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801895:	48 98                	cltq   
  801897:	48 89 0c 24          	mov    %rcx,(%rsp)
  80189b:	49 89 f9             	mov    %rdi,%r9
  80189e:	49 89 f0             	mov    %rsi,%r8
  8018a1:	48 89 d1             	mov    %rdx,%rcx
  8018a4:	48 89 c2             	mov    %rax,%rdx
  8018a7:	be 01 00 00 00       	mov    $0x1,%esi
  8018ac:	bf 05 00 00 00       	mov    $0x5,%edi
  8018b1:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  8018b8:	00 00 00 
  8018bb:	ff d0                	callq  *%rax
  8018bd:	c9                   	leaveq 
  8018be:	c3                   	retq   

00000000008018bf <sys_page_unmap>:
  8018bf:	55                   	push   %rbp
  8018c0:	48 89 e5             	mov    %rsp,%rbp
  8018c3:	48 83 ec 20          	sub    $0x20,%rsp
  8018c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018ce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018d5:	48 98                	cltq   
  8018d7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018de:	00 
  8018df:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018e5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018eb:	48 89 d1             	mov    %rdx,%rcx
  8018ee:	48 89 c2             	mov    %rax,%rdx
  8018f1:	be 01 00 00 00       	mov    $0x1,%esi
  8018f6:	bf 06 00 00 00       	mov    $0x6,%edi
  8018fb:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801902:	00 00 00 
  801905:	ff d0                	callq  *%rax
  801907:	c9                   	leaveq 
  801908:	c3                   	retq   

0000000000801909 <sys_env_set_status>:
  801909:	55                   	push   %rbp
  80190a:	48 89 e5             	mov    %rsp,%rbp
  80190d:	48 83 ec 10          	sub    $0x10,%rsp
  801911:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801914:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801917:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80191a:	48 63 d0             	movslq %eax,%rdx
  80191d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801920:	48 98                	cltq   
  801922:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801929:	00 
  80192a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801930:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801936:	48 89 d1             	mov    %rdx,%rcx
  801939:	48 89 c2             	mov    %rax,%rdx
  80193c:	be 01 00 00 00       	mov    $0x1,%esi
  801941:	bf 08 00 00 00       	mov    $0x8,%edi
  801946:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  80194d:	00 00 00 
  801950:	ff d0                	callq  *%rax
  801952:	c9                   	leaveq 
  801953:	c3                   	retq   

0000000000801954 <sys_env_set_trapframe>:
  801954:	55                   	push   %rbp
  801955:	48 89 e5             	mov    %rsp,%rbp
  801958:	48 83 ec 20          	sub    $0x20,%rsp
  80195c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80195f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801963:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801967:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80196a:	48 98                	cltq   
  80196c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801973:	00 
  801974:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80197a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801980:	48 89 d1             	mov    %rdx,%rcx
  801983:	48 89 c2             	mov    %rax,%rdx
  801986:	be 01 00 00 00       	mov    $0x1,%esi
  80198b:	bf 09 00 00 00       	mov    $0x9,%edi
  801990:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801997:	00 00 00 
  80199a:	ff d0                	callq  *%rax
  80199c:	c9                   	leaveq 
  80199d:	c3                   	retq   

000000000080199e <sys_env_set_pgfault_upcall>:
  80199e:	55                   	push   %rbp
  80199f:	48 89 e5             	mov    %rsp,%rbp
  8019a2:	48 83 ec 20          	sub    $0x20,%rsp
  8019a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019a9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019ad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b4:	48 98                	cltq   
  8019b6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019bd:	00 
  8019be:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019c4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019ca:	48 89 d1             	mov    %rdx,%rcx
  8019cd:	48 89 c2             	mov    %rax,%rdx
  8019d0:	be 01 00 00 00       	mov    $0x1,%esi
  8019d5:	bf 0a 00 00 00       	mov    $0xa,%edi
  8019da:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  8019e1:	00 00 00 
  8019e4:	ff d0                	callq  *%rax
  8019e6:	c9                   	leaveq 
  8019e7:	c3                   	retq   

00000000008019e8 <sys_ipc_try_send>:
  8019e8:	55                   	push   %rbp
  8019e9:	48 89 e5             	mov    %rsp,%rbp
  8019ec:	48 83 ec 20          	sub    $0x20,%rsp
  8019f0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019f3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019f7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8019fb:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  8019fe:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a01:	48 63 f0             	movslq %eax,%rsi
  801a04:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801a08:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a0b:	48 98                	cltq   
  801a0d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a11:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a18:	00 
  801a19:	49 89 f1             	mov    %rsi,%r9
  801a1c:	49 89 c8             	mov    %rcx,%r8
  801a1f:	48 89 d1             	mov    %rdx,%rcx
  801a22:	48 89 c2             	mov    %rax,%rdx
  801a25:	be 00 00 00 00       	mov    $0x0,%esi
  801a2a:	bf 0c 00 00 00       	mov    $0xc,%edi
  801a2f:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801a36:	00 00 00 
  801a39:	ff d0                	callq  *%rax
  801a3b:	c9                   	leaveq 
  801a3c:	c3                   	retq   

0000000000801a3d <sys_ipc_recv>:
  801a3d:	55                   	push   %rbp
  801a3e:	48 89 e5             	mov    %rsp,%rbp
  801a41:	48 83 ec 10          	sub    $0x10,%rsp
  801a45:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a4d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a54:	00 
  801a55:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a5b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a61:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a66:	48 89 c2             	mov    %rax,%rdx
  801a69:	be 01 00 00 00       	mov    $0x1,%esi
  801a6e:	bf 0d 00 00 00       	mov    $0xd,%edi
  801a73:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801a7a:	00 00 00 
  801a7d:	ff d0                	callq  *%rax
  801a7f:	c9                   	leaveq 
  801a80:	c3                   	retq   

0000000000801a81 <sys_time_msec>:
  801a81:	55                   	push   %rbp
  801a82:	48 89 e5             	mov    %rsp,%rbp
  801a85:	48 83 ec 10          	sub    $0x10,%rsp
  801a89:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a90:	00 
  801a91:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a97:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a9d:	b9 00 00 00 00       	mov    $0x0,%ecx
  801aa2:	ba 00 00 00 00       	mov    $0x0,%edx
  801aa7:	be 00 00 00 00       	mov    $0x0,%esi
  801aac:	bf 0e 00 00 00       	mov    $0xe,%edi
  801ab1:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801ab8:	00 00 00 
  801abb:	ff d0                	callq  *%rax
  801abd:	c9                   	leaveq 
  801abe:	c3                   	retq   

0000000000801abf <sys_net_transmit>:
  801abf:	55                   	push   %rbp
  801ac0:	48 89 e5             	mov    %rsp,%rbp
  801ac3:	48 83 ec 20          	sub    $0x20,%rsp
  801ac7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801acb:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801ace:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ad5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801adc:	00 
  801add:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ae3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ae9:	48 89 d1             	mov    %rdx,%rcx
  801aec:	48 89 c2             	mov    %rax,%rdx
  801aef:	be 00 00 00 00       	mov    $0x0,%esi
  801af4:	bf 0f 00 00 00       	mov    $0xf,%edi
  801af9:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801b00:	00 00 00 
  801b03:	ff d0                	callq  *%rax
  801b05:	c9                   	leaveq 
  801b06:	c3                   	retq   

0000000000801b07 <sys_net_receive>:
  801b07:	55                   	push   %rbp
  801b08:	48 89 e5             	mov    %rsp,%rbp
  801b0b:	48 83 ec 20          	sub    $0x20,%rsp
  801b0f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b13:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b16:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b1d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b24:	00 
  801b25:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b2b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b31:	48 89 d1             	mov    %rdx,%rcx
  801b34:	48 89 c2             	mov    %rax,%rdx
  801b37:	be 00 00 00 00       	mov    $0x0,%esi
  801b3c:	bf 10 00 00 00       	mov    $0x10,%edi
  801b41:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801b48:	00 00 00 
  801b4b:	ff d0                	callq  *%rax
  801b4d:	c9                   	leaveq 
  801b4e:	c3                   	retq   

0000000000801b4f <sys_ept_map>:
  801b4f:	55                   	push   %rbp
  801b50:	48 89 e5             	mov    %rsp,%rbp
  801b53:	48 83 ec 30          	sub    $0x30,%rsp
  801b57:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b5a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b5e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b61:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801b65:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801b69:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801b6c:	48 63 c8             	movslq %eax,%rcx
  801b6f:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801b73:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b76:	48 63 f0             	movslq %eax,%rsi
  801b79:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b80:	48 98                	cltq   
  801b82:	48 89 0c 24          	mov    %rcx,(%rsp)
  801b86:	49 89 f9             	mov    %rdi,%r9
  801b89:	49 89 f0             	mov    %rsi,%r8
  801b8c:	48 89 d1             	mov    %rdx,%rcx
  801b8f:	48 89 c2             	mov    %rax,%rdx
  801b92:	be 00 00 00 00       	mov    $0x0,%esi
  801b97:	bf 11 00 00 00       	mov    $0x11,%edi
  801b9c:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801ba3:	00 00 00 
  801ba6:	ff d0                	callq  *%rax
  801ba8:	c9                   	leaveq 
  801ba9:	c3                   	retq   

0000000000801baa <sys_env_mkguest>:
  801baa:	55                   	push   %rbp
  801bab:	48 89 e5             	mov    %rsp,%rbp
  801bae:	48 83 ec 20          	sub    $0x20,%rsp
  801bb2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801bb6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bc2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bc9:	00 
  801bca:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bd0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bd6:	48 89 d1             	mov    %rdx,%rcx
  801bd9:	48 89 c2             	mov    %rax,%rdx
  801bdc:	be 00 00 00 00       	mov    $0x0,%esi
  801be1:	bf 12 00 00 00       	mov    $0x12,%edi
  801be6:	48 b8 3e 16 80 00 00 	movabs $0x80163e,%rax
  801bed:	00 00 00 
  801bf0:	ff d0                	callq  *%rax
  801bf2:	c9                   	leaveq 
  801bf3:	c3                   	retq   

0000000000801bf4 <pgfault>:
  801bf4:	55                   	push   %rbp
  801bf5:	48 89 e5             	mov    %rsp,%rbp
  801bf8:	48 83 ec 30          	sub    $0x30,%rsp
  801bfc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801c00:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c04:	48 8b 00             	mov    (%rax),%rax
  801c07:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801c0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c0f:	48 8b 40 08          	mov    0x8(%rax),%rax
  801c13:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801c16:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c19:	83 e0 02             	and    $0x2,%eax
  801c1c:	85 c0                	test   %eax,%eax
  801c1e:	75 40                	jne    801c60 <pgfault+0x6c>
  801c20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c24:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801c2b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c2f:	49 89 d0             	mov    %rdx,%r8
  801c32:	48 89 c1             	mov    %rax,%rcx
  801c35:	48 ba f8 4c 80 00 00 	movabs $0x804cf8,%rdx
  801c3c:	00 00 00 
  801c3f:	be 1f 00 00 00       	mov    $0x1f,%esi
  801c44:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801c4b:	00 00 00 
  801c4e:	b8 00 00 00 00       	mov    $0x0,%eax
  801c53:	49 b9 bc 42 80 00 00 	movabs $0x8042bc,%r9
  801c5a:	00 00 00 
  801c5d:	41 ff d1             	callq  *%r9
  801c60:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c64:	48 c1 e8 0c          	shr    $0xc,%rax
  801c68:	48 89 c2             	mov    %rax,%rdx
  801c6b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801c72:	01 00 00 
  801c75:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801c79:	25 07 08 00 00       	and    $0x807,%eax
  801c7e:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  801c84:	74 4e                	je     801cd4 <pgfault+0xe0>
  801c86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c8a:	48 c1 e8 0c          	shr    $0xc,%rax
  801c8e:	48 89 c2             	mov    %rax,%rdx
  801c91:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801c98:	01 00 00 
  801c9b:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801c9f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ca3:	49 89 d0             	mov    %rdx,%r8
  801ca6:	48 89 c1             	mov    %rax,%rcx
  801ca9:	48 ba 20 4d 80 00 00 	movabs $0x804d20,%rdx
  801cb0:	00 00 00 
  801cb3:	be 22 00 00 00       	mov    $0x22,%esi
  801cb8:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801cbf:	00 00 00 
  801cc2:	b8 00 00 00 00       	mov    $0x0,%eax
  801cc7:	49 b9 bc 42 80 00 00 	movabs $0x8042bc,%r9
  801cce:	00 00 00 
  801cd1:	41 ff d1             	callq  *%r9
  801cd4:	ba 07 00 00 00       	mov    $0x7,%edx
  801cd9:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801cde:	bf 00 00 00 00       	mov    $0x0,%edi
  801ce3:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  801cea:	00 00 00 
  801ced:	ff d0                	callq  *%rax
  801cef:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801cf2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801cf6:	79 30                	jns    801d28 <pgfault+0x134>
  801cf8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801cfb:	89 c1                	mov    %eax,%ecx
  801cfd:	48 ba 4b 4d 80 00 00 	movabs $0x804d4b,%rdx
  801d04:	00 00 00 
  801d07:	be 30 00 00 00       	mov    $0x30,%esi
  801d0c:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801d13:	00 00 00 
  801d16:	b8 00 00 00 00       	mov    $0x0,%eax
  801d1b:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801d22:	00 00 00 
  801d25:	41 ff d0             	callq  *%r8
  801d28:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801d2c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801d30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d34:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  801d3a:	ba 00 10 00 00       	mov    $0x1000,%edx
  801d3f:	48 89 c6             	mov    %rax,%rsi
  801d42:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  801d47:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  801d4e:	00 00 00 
  801d51:	ff d0                	callq  *%rax
  801d53:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801d57:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801d5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d5f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  801d65:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  801d6b:	48 89 c1             	mov    %rax,%rcx
  801d6e:	ba 00 00 00 00       	mov    $0x0,%edx
  801d73:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801d78:	bf 00 00 00 00       	mov    $0x0,%edi
  801d7d:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  801d84:	00 00 00 
  801d87:	ff d0                	callq  *%rax
  801d89:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801d8c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801d90:	79 30                	jns    801dc2 <pgfault+0x1ce>
  801d92:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d95:	89 c1                	mov    %eax,%ecx
  801d97:	48 ba 5e 4d 80 00 00 	movabs $0x804d5e,%rdx
  801d9e:	00 00 00 
  801da1:	be 35 00 00 00       	mov    $0x35,%esi
  801da6:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801dad:	00 00 00 
  801db0:	b8 00 00 00 00       	mov    $0x0,%eax
  801db5:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801dbc:	00 00 00 
  801dbf:	41 ff d0             	callq  *%r8
  801dc2:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801dc7:	bf 00 00 00 00       	mov    $0x0,%edi
  801dcc:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  801dd3:	00 00 00 
  801dd6:	ff d0                	callq  *%rax
  801dd8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801ddb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801ddf:	79 30                	jns    801e11 <pgfault+0x21d>
  801de1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801de4:	89 c1                	mov    %eax,%ecx
  801de6:	48 ba 6f 4d 80 00 00 	movabs $0x804d6f,%rdx
  801ded:	00 00 00 
  801df0:	be 39 00 00 00       	mov    $0x39,%esi
  801df5:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801dfc:	00 00 00 
  801dff:	b8 00 00 00 00       	mov    $0x0,%eax
  801e04:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801e0b:	00 00 00 
  801e0e:	41 ff d0             	callq  *%r8
  801e11:	c9                   	leaveq 
  801e12:	c3                   	retq   

0000000000801e13 <duppage>:
  801e13:	55                   	push   %rbp
  801e14:	48 89 e5             	mov    %rsp,%rbp
  801e17:	48 83 ec 30          	sub    $0x30,%rsp
  801e1b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801e1e:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801e21:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801e24:	c1 e0 0c             	shl    $0xc,%eax
  801e27:	89 c0                	mov    %eax,%eax
  801e29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801e2d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801e34:	01 00 00 
  801e37:	8b 55 d8             	mov    -0x28(%rbp),%edx
  801e3a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801e3e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801e42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e46:	25 02 08 00 00       	and    $0x802,%eax
  801e4b:	48 85 c0             	test   %rax,%rax
  801e4e:	74 0e                	je     801e5e <duppage+0x4b>
  801e50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e54:	25 00 04 00 00       	and    $0x400,%eax
  801e59:	48 85 c0             	test   %rax,%rax
  801e5c:	74 70                	je     801ece <duppage+0xbb>
  801e5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e62:	25 07 0e 00 00       	and    $0xe07,%eax
  801e67:	89 c6                	mov    %eax,%esi
  801e69:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  801e6d:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e74:	41 89 f0             	mov    %esi,%r8d
  801e77:	48 89 c6             	mov    %rax,%rsi
  801e7a:	bf 00 00 00 00       	mov    $0x0,%edi
  801e7f:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  801e86:	00 00 00 
  801e89:	ff d0                	callq  *%rax
  801e8b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801e8e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801e92:	79 30                	jns    801ec4 <duppage+0xb1>
  801e94:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801e97:	89 c1                	mov    %eax,%ecx
  801e99:	48 ba 5e 4d 80 00 00 	movabs $0x804d5e,%rdx
  801ea0:	00 00 00 
  801ea3:	be 63 00 00 00       	mov    $0x63,%esi
  801ea8:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801eaf:	00 00 00 
  801eb2:	b8 00 00 00 00       	mov    $0x0,%eax
  801eb7:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801ebe:	00 00 00 
  801ec1:	41 ff d0             	callq  *%r8
  801ec4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ec9:	e9 c4 00 00 00       	jmpq   801f92 <duppage+0x17f>
  801ece:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  801ed2:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ed9:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  801edf:	48 89 c6             	mov    %rax,%rsi
  801ee2:	bf 00 00 00 00       	mov    $0x0,%edi
  801ee7:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  801eee:	00 00 00 
  801ef1:	ff d0                	callq  *%rax
  801ef3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801ef6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801efa:	79 30                	jns    801f2c <duppage+0x119>
  801efc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801eff:	89 c1                	mov    %eax,%ecx
  801f01:	48 ba 5e 4d 80 00 00 	movabs $0x804d5e,%rdx
  801f08:	00 00 00 
  801f0b:	be 7e 00 00 00       	mov    $0x7e,%esi
  801f10:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801f17:	00 00 00 
  801f1a:	b8 00 00 00 00       	mov    $0x0,%eax
  801f1f:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801f26:	00 00 00 
  801f29:	41 ff d0             	callq  *%r8
  801f2c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f34:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  801f3a:	48 89 d1             	mov    %rdx,%rcx
  801f3d:	ba 00 00 00 00       	mov    $0x0,%edx
  801f42:	48 89 c6             	mov    %rax,%rsi
  801f45:	bf 00 00 00 00       	mov    $0x0,%edi
  801f4a:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  801f51:	00 00 00 
  801f54:	ff d0                	callq  *%rax
  801f56:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f59:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801f5d:	79 30                	jns    801f8f <duppage+0x17c>
  801f5f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f62:	89 c1                	mov    %eax,%ecx
  801f64:	48 ba 5e 4d 80 00 00 	movabs $0x804d5e,%rdx
  801f6b:	00 00 00 
  801f6e:	be 80 00 00 00       	mov    $0x80,%esi
  801f73:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  801f7a:	00 00 00 
  801f7d:	b8 00 00 00 00       	mov    $0x0,%eax
  801f82:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  801f89:	00 00 00 
  801f8c:	41 ff d0             	callq  *%r8
  801f8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f92:	c9                   	leaveq 
  801f93:	c3                   	retq   

0000000000801f94 <fork>:
  801f94:	55                   	push   %rbp
  801f95:	48 89 e5             	mov    %rsp,%rbp
  801f98:	48 83 ec 20          	sub    $0x20,%rsp
  801f9c:	48 bf f4 1b 80 00 00 	movabs $0x801bf4,%rdi
  801fa3:	00 00 00 
  801fa6:	48 b8 d0 43 80 00 00 	movabs $0x8043d0,%rax
  801fad:	00 00 00 
  801fb0:	ff d0                	callq  *%rax
  801fb2:	b8 07 00 00 00       	mov    $0x7,%eax
  801fb7:	cd 30                	int    $0x30
  801fb9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801fbc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801fbf:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801fc2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801fc6:	79 08                	jns    801fd0 <fork+0x3c>
  801fc8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801fcb:	e9 09 02 00 00       	jmpq   8021d9 <fork+0x245>
  801fd0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801fd4:	75 3e                	jne    802014 <fork+0x80>
  801fd6:	48 b8 98 17 80 00 00 	movabs $0x801798,%rax
  801fdd:	00 00 00 
  801fe0:	ff d0                	callq  *%rax
  801fe2:	25 ff 03 00 00       	and    $0x3ff,%eax
  801fe7:	48 98                	cltq   
  801fe9:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  801ff0:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  801ff7:	00 00 00 
  801ffa:	48 01 c2             	add    %rax,%rdx
  801ffd:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802004:	00 00 00 
  802007:	48 89 10             	mov    %rdx,(%rax)
  80200a:	b8 00 00 00 00       	mov    $0x0,%eax
  80200f:	e9 c5 01 00 00       	jmpq   8021d9 <fork+0x245>
  802014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80201b:	e9 a4 00 00 00       	jmpq   8020c4 <fork+0x130>
  802020:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802023:	c1 f8 12             	sar    $0x12,%eax
  802026:	89 c2                	mov    %eax,%edx
  802028:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  80202f:	01 00 00 
  802032:	48 63 d2             	movslq %edx,%rdx
  802035:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802039:	83 e0 01             	and    $0x1,%eax
  80203c:	48 85 c0             	test   %rax,%rax
  80203f:	74 21                	je     802062 <fork+0xce>
  802041:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802044:	c1 f8 09             	sar    $0x9,%eax
  802047:	89 c2                	mov    %eax,%edx
  802049:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802050:	01 00 00 
  802053:	48 63 d2             	movslq %edx,%rdx
  802056:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80205a:	83 e0 01             	and    $0x1,%eax
  80205d:	48 85 c0             	test   %rax,%rax
  802060:	75 09                	jne    80206b <fork+0xd7>
  802062:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  802069:	eb 59                	jmp    8020c4 <fork+0x130>
  80206b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80206e:	05 00 02 00 00       	add    $0x200,%eax
  802073:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802076:	eb 44                	jmp    8020bc <fork+0x128>
  802078:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80207f:	01 00 00 
  802082:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802085:	48 63 d2             	movslq %edx,%rdx
  802088:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80208c:	83 e0 05             	and    $0x5,%eax
  80208f:	48 83 f8 05          	cmp    $0x5,%rax
  802093:	74 02                	je     802097 <fork+0x103>
  802095:	eb 21                	jmp    8020b8 <fork+0x124>
  802097:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  80209e:	75 02                	jne    8020a2 <fork+0x10e>
  8020a0:	eb 16                	jmp    8020b8 <fork+0x124>
  8020a2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8020a5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020a8:	89 d6                	mov    %edx,%esi
  8020aa:	89 c7                	mov    %eax,%edi
  8020ac:	48 b8 13 1e 80 00 00 	movabs $0x801e13,%rax
  8020b3:	00 00 00 
  8020b6:	ff d0                	callq  *%rax
  8020b8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8020bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020bf:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8020c2:	7c b4                	jl     802078 <fork+0xe4>
  8020c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020c7:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  8020cc:	0f 86 4e ff ff ff    	jbe    802020 <fork+0x8c>
  8020d2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020d5:	ba 07 00 00 00       	mov    $0x7,%edx
  8020da:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8020df:	89 c7                	mov    %eax,%edi
  8020e1:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  8020e8:	00 00 00 
  8020eb:	ff d0                	callq  *%rax
  8020ed:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8020f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8020f4:	79 30                	jns    802126 <fork+0x192>
  8020f6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8020f9:	89 c1                	mov    %eax,%ecx
  8020fb:	48 ba 88 4d 80 00 00 	movabs $0x804d88,%rdx
  802102:	00 00 00 
  802105:	be bc 00 00 00       	mov    $0xbc,%esi
  80210a:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  802111:	00 00 00 
  802114:	b8 00 00 00 00       	mov    $0x0,%eax
  802119:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  802120:	00 00 00 
  802123:	41 ff d0             	callq  *%r8
  802126:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80212d:	00 00 00 
  802130:	48 8b 00             	mov    (%rax),%rax
  802133:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  80213a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80213d:	48 89 d6             	mov    %rdx,%rsi
  802140:	89 c7                	mov    %eax,%edi
  802142:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  802149:	00 00 00 
  80214c:	ff d0                	callq  *%rax
  80214e:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802151:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802155:	79 30                	jns    802187 <fork+0x1f3>
  802157:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80215a:	89 c1                	mov    %eax,%ecx
  80215c:	48 ba a8 4d 80 00 00 	movabs $0x804da8,%rdx
  802163:	00 00 00 
  802166:	be c0 00 00 00       	mov    $0xc0,%esi
  80216b:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  802172:	00 00 00 
  802175:	b8 00 00 00 00       	mov    $0x0,%eax
  80217a:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  802181:	00 00 00 
  802184:	41 ff d0             	callq  *%r8
  802187:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80218a:	be 02 00 00 00       	mov    $0x2,%esi
  80218f:	89 c7                	mov    %eax,%edi
  802191:	48 b8 09 19 80 00 00 	movabs $0x801909,%rax
  802198:	00 00 00 
  80219b:	ff d0                	callq  *%rax
  80219d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8021a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8021a4:	79 30                	jns    8021d6 <fork+0x242>
  8021a6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8021a9:	89 c1                	mov    %eax,%ecx
  8021ab:	48 ba c7 4d 80 00 00 	movabs $0x804dc7,%rdx
  8021b2:	00 00 00 
  8021b5:	be c5 00 00 00       	mov    $0xc5,%esi
  8021ba:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  8021c1:	00 00 00 
  8021c4:	b8 00 00 00 00       	mov    $0x0,%eax
  8021c9:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  8021d0:	00 00 00 
  8021d3:	41 ff d0             	callq  *%r8
  8021d6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8021d9:	c9                   	leaveq 
  8021da:	c3                   	retq   

00000000008021db <sfork>:
  8021db:	55                   	push   %rbp
  8021dc:	48 89 e5             	mov    %rsp,%rbp
  8021df:	48 ba de 4d 80 00 00 	movabs $0x804dde,%rdx
  8021e6:	00 00 00 
  8021e9:	be d2 00 00 00       	mov    $0xd2,%esi
  8021ee:	48 bf 11 4d 80 00 00 	movabs $0x804d11,%rdi
  8021f5:	00 00 00 
  8021f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8021fd:	48 b9 bc 42 80 00 00 	movabs $0x8042bc,%rcx
  802204:	00 00 00 
  802207:	ff d1                	callq  *%rcx

0000000000802209 <fd2num>:
  802209:	55                   	push   %rbp
  80220a:	48 89 e5             	mov    %rsp,%rbp
  80220d:	48 83 ec 08          	sub    $0x8,%rsp
  802211:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802215:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802219:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  802220:	ff ff ff 
  802223:	48 01 d0             	add    %rdx,%rax
  802226:	48 c1 e8 0c          	shr    $0xc,%rax
  80222a:	c9                   	leaveq 
  80222b:	c3                   	retq   

000000000080222c <fd2data>:
  80222c:	55                   	push   %rbp
  80222d:	48 89 e5             	mov    %rsp,%rbp
  802230:	48 83 ec 08          	sub    $0x8,%rsp
  802234:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802238:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80223c:	48 89 c7             	mov    %rax,%rdi
  80223f:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  802246:	00 00 00 
  802249:	ff d0                	callq  *%rax
  80224b:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802251:	48 c1 e0 0c          	shl    $0xc,%rax
  802255:	c9                   	leaveq 
  802256:	c3                   	retq   

0000000000802257 <fd_alloc>:
  802257:	55                   	push   %rbp
  802258:	48 89 e5             	mov    %rsp,%rbp
  80225b:	48 83 ec 18          	sub    $0x18,%rsp
  80225f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80226a:	eb 6b                	jmp    8022d7 <fd_alloc+0x80>
  80226c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80226f:	48 98                	cltq   
  802271:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802277:	48 c1 e0 0c          	shl    $0xc,%rax
  80227b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80227f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802283:	48 c1 e8 15          	shr    $0x15,%rax
  802287:	48 89 c2             	mov    %rax,%rdx
  80228a:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802291:	01 00 00 
  802294:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802298:	83 e0 01             	and    $0x1,%eax
  80229b:	48 85 c0             	test   %rax,%rax
  80229e:	74 21                	je     8022c1 <fd_alloc+0x6a>
  8022a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022a4:	48 c1 e8 0c          	shr    $0xc,%rax
  8022a8:	48 89 c2             	mov    %rax,%rdx
  8022ab:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8022b2:	01 00 00 
  8022b5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8022b9:	83 e0 01             	and    $0x1,%eax
  8022bc:	48 85 c0             	test   %rax,%rax
  8022bf:	75 12                	jne    8022d3 <fd_alloc+0x7c>
  8022c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022c5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8022c9:	48 89 10             	mov    %rdx,(%rax)
  8022cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8022d1:	eb 1a                	jmp    8022ed <fd_alloc+0x96>
  8022d3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8022d7:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8022db:	7e 8f                	jle    80226c <fd_alloc+0x15>
  8022dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022e1:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8022e8:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8022ed:	c9                   	leaveq 
  8022ee:	c3                   	retq   

00000000008022ef <fd_lookup>:
  8022ef:	55                   	push   %rbp
  8022f0:	48 89 e5             	mov    %rsp,%rbp
  8022f3:	48 83 ec 20          	sub    $0x20,%rsp
  8022f7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8022fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8022fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802302:	78 06                	js     80230a <fd_lookup+0x1b>
  802304:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802308:	7e 07                	jle    802311 <fd_lookup+0x22>
  80230a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80230f:	eb 6c                	jmp    80237d <fd_lookup+0x8e>
  802311:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802314:	48 98                	cltq   
  802316:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80231c:	48 c1 e0 0c          	shl    $0xc,%rax
  802320:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802324:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802328:	48 c1 e8 15          	shr    $0x15,%rax
  80232c:	48 89 c2             	mov    %rax,%rdx
  80232f:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802336:	01 00 00 
  802339:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80233d:	83 e0 01             	and    $0x1,%eax
  802340:	48 85 c0             	test   %rax,%rax
  802343:	74 21                	je     802366 <fd_lookup+0x77>
  802345:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802349:	48 c1 e8 0c          	shr    $0xc,%rax
  80234d:	48 89 c2             	mov    %rax,%rdx
  802350:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802357:	01 00 00 
  80235a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80235e:	83 e0 01             	and    $0x1,%eax
  802361:	48 85 c0             	test   %rax,%rax
  802364:	75 07                	jne    80236d <fd_lookup+0x7e>
  802366:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80236b:	eb 10                	jmp    80237d <fd_lookup+0x8e>
  80236d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802371:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802375:	48 89 10             	mov    %rdx,(%rax)
  802378:	b8 00 00 00 00       	mov    $0x0,%eax
  80237d:	c9                   	leaveq 
  80237e:	c3                   	retq   

000000000080237f <fd_close>:
  80237f:	55                   	push   %rbp
  802380:	48 89 e5             	mov    %rsp,%rbp
  802383:	48 83 ec 30          	sub    $0x30,%rsp
  802387:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80238b:	89 f0                	mov    %esi,%eax
  80238d:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802390:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802394:	48 89 c7             	mov    %rax,%rdi
  802397:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  80239e:	00 00 00 
  8023a1:	ff d0                	callq  *%rax
  8023a3:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8023a7:	48 89 d6             	mov    %rdx,%rsi
  8023aa:	89 c7                	mov    %eax,%edi
  8023ac:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  8023b3:	00 00 00 
  8023b6:	ff d0                	callq  *%rax
  8023b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023bf:	78 0a                	js     8023cb <fd_close+0x4c>
  8023c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023c5:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8023c9:	74 12                	je     8023dd <fd_close+0x5e>
  8023cb:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8023cf:	74 05                	je     8023d6 <fd_close+0x57>
  8023d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023d4:	eb 05                	jmp    8023db <fd_close+0x5c>
  8023d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8023db:	eb 69                	jmp    802446 <fd_close+0xc7>
  8023dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023e1:	8b 00                	mov    (%rax),%eax
  8023e3:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8023e7:	48 89 d6             	mov    %rdx,%rsi
  8023ea:	89 c7                	mov    %eax,%edi
  8023ec:	48 b8 48 24 80 00 00 	movabs $0x802448,%rax
  8023f3:	00 00 00 
  8023f6:	ff d0                	callq  *%rax
  8023f8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023fb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023ff:	78 2a                	js     80242b <fd_close+0xac>
  802401:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802405:	48 8b 40 20          	mov    0x20(%rax),%rax
  802409:	48 85 c0             	test   %rax,%rax
  80240c:	74 16                	je     802424 <fd_close+0xa5>
  80240e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802412:	48 8b 40 20          	mov    0x20(%rax),%rax
  802416:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80241a:	48 89 d7             	mov    %rdx,%rdi
  80241d:	ff d0                	callq  *%rax
  80241f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802422:	eb 07                	jmp    80242b <fd_close+0xac>
  802424:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80242b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80242f:	48 89 c6             	mov    %rax,%rsi
  802432:	bf 00 00 00 00       	mov    $0x0,%edi
  802437:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  80243e:	00 00 00 
  802441:	ff d0                	callq  *%rax
  802443:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802446:	c9                   	leaveq 
  802447:	c3                   	retq   

0000000000802448 <dev_lookup>:
  802448:	55                   	push   %rbp
  802449:	48 89 e5             	mov    %rsp,%rbp
  80244c:	48 83 ec 20          	sub    $0x20,%rsp
  802450:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802453:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802457:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80245e:	eb 41                	jmp    8024a1 <dev_lookup+0x59>
  802460:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802467:	00 00 00 
  80246a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80246d:	48 63 d2             	movslq %edx,%rdx
  802470:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802474:	8b 00                	mov    (%rax),%eax
  802476:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802479:	75 22                	jne    80249d <dev_lookup+0x55>
  80247b:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802482:	00 00 00 
  802485:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802488:	48 63 d2             	movslq %edx,%rdx
  80248b:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80248f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802493:	48 89 10             	mov    %rdx,(%rax)
  802496:	b8 00 00 00 00       	mov    $0x0,%eax
  80249b:	eb 60                	jmp    8024fd <dev_lookup+0xb5>
  80249d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8024a1:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  8024a8:	00 00 00 
  8024ab:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8024ae:	48 63 d2             	movslq %edx,%rdx
  8024b1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8024b5:	48 85 c0             	test   %rax,%rax
  8024b8:	75 a6                	jne    802460 <dev_lookup+0x18>
  8024ba:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8024c1:	00 00 00 
  8024c4:	48 8b 00             	mov    (%rax),%rax
  8024c7:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8024cd:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8024d0:	89 c6                	mov    %eax,%esi
  8024d2:	48 bf f8 4d 80 00 00 	movabs $0x804df8,%rdi
  8024d9:	00 00 00 
  8024dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8024e1:	48 b9 30 03 80 00 00 	movabs $0x800330,%rcx
  8024e8:	00 00 00 
  8024eb:	ff d1                	callq  *%rcx
  8024ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8024f1:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8024f8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024fd:	c9                   	leaveq 
  8024fe:	c3                   	retq   

00000000008024ff <close>:
  8024ff:	55                   	push   %rbp
  802500:	48 89 e5             	mov    %rsp,%rbp
  802503:	48 83 ec 20          	sub    $0x20,%rsp
  802507:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80250a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80250e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802511:	48 89 d6             	mov    %rdx,%rsi
  802514:	89 c7                	mov    %eax,%edi
  802516:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  80251d:	00 00 00 
  802520:	ff d0                	callq  *%rax
  802522:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802525:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802529:	79 05                	jns    802530 <close+0x31>
  80252b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80252e:	eb 18                	jmp    802548 <close+0x49>
  802530:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802534:	be 01 00 00 00       	mov    $0x1,%esi
  802539:	48 89 c7             	mov    %rax,%rdi
  80253c:	48 b8 7f 23 80 00 00 	movabs $0x80237f,%rax
  802543:	00 00 00 
  802546:	ff d0                	callq  *%rax
  802548:	c9                   	leaveq 
  802549:	c3                   	retq   

000000000080254a <close_all>:
  80254a:	55                   	push   %rbp
  80254b:	48 89 e5             	mov    %rsp,%rbp
  80254e:	48 83 ec 10          	sub    $0x10,%rsp
  802552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802559:	eb 15                	jmp    802570 <close_all+0x26>
  80255b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80255e:	89 c7                	mov    %eax,%edi
  802560:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  802567:	00 00 00 
  80256a:	ff d0                	callq  *%rax
  80256c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802570:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802574:	7e e5                	jle    80255b <close_all+0x11>
  802576:	c9                   	leaveq 
  802577:	c3                   	retq   

0000000000802578 <dup>:
  802578:	55                   	push   %rbp
  802579:	48 89 e5             	mov    %rsp,%rbp
  80257c:	48 83 ec 40          	sub    $0x40,%rsp
  802580:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802583:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802586:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80258a:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80258d:	48 89 d6             	mov    %rdx,%rsi
  802590:	89 c7                	mov    %eax,%edi
  802592:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  802599:	00 00 00 
  80259c:	ff d0                	callq  *%rax
  80259e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025a5:	79 08                	jns    8025af <dup+0x37>
  8025a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025aa:	e9 70 01 00 00       	jmpq   80271f <dup+0x1a7>
  8025af:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8025b2:	89 c7                	mov    %eax,%edi
  8025b4:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  8025bb:	00 00 00 
  8025be:	ff d0                	callq  *%rax
  8025c0:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8025c3:	48 98                	cltq   
  8025c5:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8025cb:	48 c1 e0 0c          	shl    $0xc,%rax
  8025cf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8025d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025d7:	48 89 c7             	mov    %rax,%rdi
  8025da:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  8025e1:	00 00 00 
  8025e4:	ff d0                	callq  *%rax
  8025e6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8025ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025ee:	48 89 c7             	mov    %rax,%rdi
  8025f1:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  8025f8:	00 00 00 
  8025fb:	ff d0                	callq  *%rax
  8025fd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802601:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802605:	48 c1 e8 15          	shr    $0x15,%rax
  802609:	48 89 c2             	mov    %rax,%rdx
  80260c:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802613:	01 00 00 
  802616:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80261a:	83 e0 01             	and    $0x1,%eax
  80261d:	48 85 c0             	test   %rax,%rax
  802620:	74 73                	je     802695 <dup+0x11d>
  802622:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802626:	48 c1 e8 0c          	shr    $0xc,%rax
  80262a:	48 89 c2             	mov    %rax,%rdx
  80262d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802634:	01 00 00 
  802637:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80263b:	83 e0 01             	and    $0x1,%eax
  80263e:	48 85 c0             	test   %rax,%rax
  802641:	74 52                	je     802695 <dup+0x11d>
  802643:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802647:	48 c1 e8 0c          	shr    $0xc,%rax
  80264b:	48 89 c2             	mov    %rax,%rdx
  80264e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802655:	01 00 00 
  802658:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80265c:	25 07 0e 00 00       	and    $0xe07,%eax
  802661:	89 c1                	mov    %eax,%ecx
  802663:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802667:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80266b:	41 89 c8             	mov    %ecx,%r8d
  80266e:	48 89 d1             	mov    %rdx,%rcx
  802671:	ba 00 00 00 00       	mov    $0x0,%edx
  802676:	48 89 c6             	mov    %rax,%rsi
  802679:	bf 00 00 00 00       	mov    $0x0,%edi
  80267e:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  802685:	00 00 00 
  802688:	ff d0                	callq  *%rax
  80268a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80268d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802691:	79 02                	jns    802695 <dup+0x11d>
  802693:	eb 57                	jmp    8026ec <dup+0x174>
  802695:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802699:	48 c1 e8 0c          	shr    $0xc,%rax
  80269d:	48 89 c2             	mov    %rax,%rdx
  8026a0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8026a7:	01 00 00 
  8026aa:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8026ae:	25 07 0e 00 00       	and    $0xe07,%eax
  8026b3:	89 c1                	mov    %eax,%ecx
  8026b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8026b9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8026bd:	41 89 c8             	mov    %ecx,%r8d
  8026c0:	48 89 d1             	mov    %rdx,%rcx
  8026c3:	ba 00 00 00 00       	mov    $0x0,%edx
  8026c8:	48 89 c6             	mov    %rax,%rsi
  8026cb:	bf 00 00 00 00       	mov    $0x0,%edi
  8026d0:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  8026d7:	00 00 00 
  8026da:	ff d0                	callq  *%rax
  8026dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026e3:	79 02                	jns    8026e7 <dup+0x16f>
  8026e5:	eb 05                	jmp    8026ec <dup+0x174>
  8026e7:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8026ea:	eb 33                	jmp    80271f <dup+0x1a7>
  8026ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026f0:	48 89 c6             	mov    %rax,%rsi
  8026f3:	bf 00 00 00 00       	mov    $0x0,%edi
  8026f8:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  8026ff:	00 00 00 
  802702:	ff d0                	callq  *%rax
  802704:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802708:	48 89 c6             	mov    %rax,%rsi
  80270b:	bf 00 00 00 00       	mov    $0x0,%edi
  802710:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  802717:	00 00 00 
  80271a:	ff d0                	callq  *%rax
  80271c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80271f:	c9                   	leaveq 
  802720:	c3                   	retq   

0000000000802721 <read>:
  802721:	55                   	push   %rbp
  802722:	48 89 e5             	mov    %rsp,%rbp
  802725:	48 83 ec 40          	sub    $0x40,%rsp
  802729:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80272c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802730:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802734:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802738:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80273b:	48 89 d6             	mov    %rdx,%rsi
  80273e:	89 c7                	mov    %eax,%edi
  802740:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  802747:	00 00 00 
  80274a:	ff d0                	callq  *%rax
  80274c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80274f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802753:	78 24                	js     802779 <read+0x58>
  802755:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802759:	8b 00                	mov    (%rax),%eax
  80275b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80275f:	48 89 d6             	mov    %rdx,%rsi
  802762:	89 c7                	mov    %eax,%edi
  802764:	48 b8 48 24 80 00 00 	movabs $0x802448,%rax
  80276b:	00 00 00 
  80276e:	ff d0                	callq  *%rax
  802770:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802773:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802777:	79 05                	jns    80277e <read+0x5d>
  802779:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80277c:	eb 76                	jmp    8027f4 <read+0xd3>
  80277e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802782:	8b 40 08             	mov    0x8(%rax),%eax
  802785:	83 e0 03             	and    $0x3,%eax
  802788:	83 f8 01             	cmp    $0x1,%eax
  80278b:	75 3a                	jne    8027c7 <read+0xa6>
  80278d:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802794:	00 00 00 
  802797:	48 8b 00             	mov    (%rax),%rax
  80279a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8027a0:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8027a3:	89 c6                	mov    %eax,%esi
  8027a5:	48 bf 17 4e 80 00 00 	movabs $0x804e17,%rdi
  8027ac:	00 00 00 
  8027af:	b8 00 00 00 00       	mov    $0x0,%eax
  8027b4:	48 b9 30 03 80 00 00 	movabs $0x800330,%rcx
  8027bb:	00 00 00 
  8027be:	ff d1                	callq  *%rcx
  8027c0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8027c5:	eb 2d                	jmp    8027f4 <read+0xd3>
  8027c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027cb:	48 8b 40 10          	mov    0x10(%rax),%rax
  8027cf:	48 85 c0             	test   %rax,%rax
  8027d2:	75 07                	jne    8027db <read+0xba>
  8027d4:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8027d9:	eb 19                	jmp    8027f4 <read+0xd3>
  8027db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027df:	48 8b 40 10          	mov    0x10(%rax),%rax
  8027e3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8027e7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8027eb:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8027ef:	48 89 cf             	mov    %rcx,%rdi
  8027f2:	ff d0                	callq  *%rax
  8027f4:	c9                   	leaveq 
  8027f5:	c3                   	retq   

00000000008027f6 <readn>:
  8027f6:	55                   	push   %rbp
  8027f7:	48 89 e5             	mov    %rsp,%rbp
  8027fa:	48 83 ec 30          	sub    $0x30,%rsp
  8027fe:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802801:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802805:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802809:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802810:	eb 49                	jmp    80285b <readn+0x65>
  802812:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802815:	48 98                	cltq   
  802817:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80281b:	48 29 c2             	sub    %rax,%rdx
  80281e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802821:	48 63 c8             	movslq %eax,%rcx
  802824:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802828:	48 01 c1             	add    %rax,%rcx
  80282b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80282e:	48 89 ce             	mov    %rcx,%rsi
  802831:	89 c7                	mov    %eax,%edi
  802833:	48 b8 21 27 80 00 00 	movabs $0x802721,%rax
  80283a:	00 00 00 
  80283d:	ff d0                	callq  *%rax
  80283f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802842:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802846:	79 05                	jns    80284d <readn+0x57>
  802848:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80284b:	eb 1c                	jmp    802869 <readn+0x73>
  80284d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802851:	75 02                	jne    802855 <readn+0x5f>
  802853:	eb 11                	jmp    802866 <readn+0x70>
  802855:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802858:	01 45 fc             	add    %eax,-0x4(%rbp)
  80285b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80285e:	48 98                	cltq   
  802860:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802864:	72 ac                	jb     802812 <readn+0x1c>
  802866:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802869:	c9                   	leaveq 
  80286a:	c3                   	retq   

000000000080286b <write>:
  80286b:	55                   	push   %rbp
  80286c:	48 89 e5             	mov    %rsp,%rbp
  80286f:	48 83 ec 40          	sub    $0x40,%rsp
  802873:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802876:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80287a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80287e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802882:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802885:	48 89 d6             	mov    %rdx,%rsi
  802888:	89 c7                	mov    %eax,%edi
  80288a:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  802891:	00 00 00 
  802894:	ff d0                	callq  *%rax
  802896:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802899:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80289d:	78 24                	js     8028c3 <write+0x58>
  80289f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028a3:	8b 00                	mov    (%rax),%eax
  8028a5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028a9:	48 89 d6             	mov    %rdx,%rsi
  8028ac:	89 c7                	mov    %eax,%edi
  8028ae:	48 b8 48 24 80 00 00 	movabs $0x802448,%rax
  8028b5:	00 00 00 
  8028b8:	ff d0                	callq  *%rax
  8028ba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028c1:	79 05                	jns    8028c8 <write+0x5d>
  8028c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028c6:	eb 75                	jmp    80293d <write+0xd2>
  8028c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028cc:	8b 40 08             	mov    0x8(%rax),%eax
  8028cf:	83 e0 03             	and    $0x3,%eax
  8028d2:	85 c0                	test   %eax,%eax
  8028d4:	75 3a                	jne    802910 <write+0xa5>
  8028d6:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8028dd:	00 00 00 
  8028e0:	48 8b 00             	mov    (%rax),%rax
  8028e3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8028e9:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8028ec:	89 c6                	mov    %eax,%esi
  8028ee:	48 bf 33 4e 80 00 00 	movabs $0x804e33,%rdi
  8028f5:	00 00 00 
  8028f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8028fd:	48 b9 30 03 80 00 00 	movabs $0x800330,%rcx
  802904:	00 00 00 
  802907:	ff d1                	callq  *%rcx
  802909:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80290e:	eb 2d                	jmp    80293d <write+0xd2>
  802910:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802914:	48 8b 40 18          	mov    0x18(%rax),%rax
  802918:	48 85 c0             	test   %rax,%rax
  80291b:	75 07                	jne    802924 <write+0xb9>
  80291d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802922:	eb 19                	jmp    80293d <write+0xd2>
  802924:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802928:	48 8b 40 18          	mov    0x18(%rax),%rax
  80292c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802930:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802934:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802938:	48 89 cf             	mov    %rcx,%rdi
  80293b:	ff d0                	callq  *%rax
  80293d:	c9                   	leaveq 
  80293e:	c3                   	retq   

000000000080293f <seek>:
  80293f:	55                   	push   %rbp
  802940:	48 89 e5             	mov    %rsp,%rbp
  802943:	48 83 ec 18          	sub    $0x18,%rsp
  802947:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80294a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80294d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802951:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802954:	48 89 d6             	mov    %rdx,%rsi
  802957:	89 c7                	mov    %eax,%edi
  802959:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  802960:	00 00 00 
  802963:	ff d0                	callq  *%rax
  802965:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802968:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80296c:	79 05                	jns    802973 <seek+0x34>
  80296e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802971:	eb 0f                	jmp    802982 <seek+0x43>
  802973:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802977:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80297a:	89 50 04             	mov    %edx,0x4(%rax)
  80297d:	b8 00 00 00 00       	mov    $0x0,%eax
  802982:	c9                   	leaveq 
  802983:	c3                   	retq   

0000000000802984 <ftruncate>:
  802984:	55                   	push   %rbp
  802985:	48 89 e5             	mov    %rsp,%rbp
  802988:	48 83 ec 30          	sub    $0x30,%rsp
  80298c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80298f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802992:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802996:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802999:	48 89 d6             	mov    %rdx,%rsi
  80299c:	89 c7                	mov    %eax,%edi
  80299e:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  8029a5:	00 00 00 
  8029a8:	ff d0                	callq  *%rax
  8029aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029b1:	78 24                	js     8029d7 <ftruncate+0x53>
  8029b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029b7:	8b 00                	mov    (%rax),%eax
  8029b9:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8029bd:	48 89 d6             	mov    %rdx,%rsi
  8029c0:	89 c7                	mov    %eax,%edi
  8029c2:	48 b8 48 24 80 00 00 	movabs $0x802448,%rax
  8029c9:	00 00 00 
  8029cc:	ff d0                	callq  *%rax
  8029ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029d5:	79 05                	jns    8029dc <ftruncate+0x58>
  8029d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029da:	eb 72                	jmp    802a4e <ftruncate+0xca>
  8029dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029e0:	8b 40 08             	mov    0x8(%rax),%eax
  8029e3:	83 e0 03             	and    $0x3,%eax
  8029e6:	85 c0                	test   %eax,%eax
  8029e8:	75 3a                	jne    802a24 <ftruncate+0xa0>
  8029ea:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8029f1:	00 00 00 
  8029f4:	48 8b 00             	mov    (%rax),%rax
  8029f7:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8029fd:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802a00:	89 c6                	mov    %eax,%esi
  802a02:	48 bf 50 4e 80 00 00 	movabs $0x804e50,%rdi
  802a09:	00 00 00 
  802a0c:	b8 00 00 00 00       	mov    $0x0,%eax
  802a11:	48 b9 30 03 80 00 00 	movabs $0x800330,%rcx
  802a18:	00 00 00 
  802a1b:	ff d1                	callq  *%rcx
  802a1d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802a22:	eb 2a                	jmp    802a4e <ftruncate+0xca>
  802a24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a28:	48 8b 40 30          	mov    0x30(%rax),%rax
  802a2c:	48 85 c0             	test   %rax,%rax
  802a2f:	75 07                	jne    802a38 <ftruncate+0xb4>
  802a31:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802a36:	eb 16                	jmp    802a4e <ftruncate+0xca>
  802a38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a3c:	48 8b 40 30          	mov    0x30(%rax),%rax
  802a40:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802a44:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802a47:	89 ce                	mov    %ecx,%esi
  802a49:	48 89 d7             	mov    %rdx,%rdi
  802a4c:	ff d0                	callq  *%rax
  802a4e:	c9                   	leaveq 
  802a4f:	c3                   	retq   

0000000000802a50 <fstat>:
  802a50:	55                   	push   %rbp
  802a51:	48 89 e5             	mov    %rsp,%rbp
  802a54:	48 83 ec 30          	sub    $0x30,%rsp
  802a58:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802a5b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802a5f:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802a63:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a66:	48 89 d6             	mov    %rdx,%rsi
  802a69:	89 c7                	mov    %eax,%edi
  802a6b:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  802a72:	00 00 00 
  802a75:	ff d0                	callq  *%rax
  802a77:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a7e:	78 24                	js     802aa4 <fstat+0x54>
  802a80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a84:	8b 00                	mov    (%rax),%eax
  802a86:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a8a:	48 89 d6             	mov    %rdx,%rsi
  802a8d:	89 c7                	mov    %eax,%edi
  802a8f:	48 b8 48 24 80 00 00 	movabs $0x802448,%rax
  802a96:	00 00 00 
  802a99:	ff d0                	callq  *%rax
  802a9b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802aa2:	79 05                	jns    802aa9 <fstat+0x59>
  802aa4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aa7:	eb 5e                	jmp    802b07 <fstat+0xb7>
  802aa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802aad:	48 8b 40 28          	mov    0x28(%rax),%rax
  802ab1:	48 85 c0             	test   %rax,%rax
  802ab4:	75 07                	jne    802abd <fstat+0x6d>
  802ab6:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802abb:	eb 4a                	jmp    802b07 <fstat+0xb7>
  802abd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802ac1:	c6 00 00             	movb   $0x0,(%rax)
  802ac4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802ac8:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802acf:	00 00 00 
  802ad2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802ad6:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802add:	00 00 00 
  802ae0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802ae4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802ae8:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802aef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802af3:	48 8b 40 28          	mov    0x28(%rax),%rax
  802af7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802afb:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802aff:	48 89 ce             	mov    %rcx,%rsi
  802b02:	48 89 d7             	mov    %rdx,%rdi
  802b05:	ff d0                	callq  *%rax
  802b07:	c9                   	leaveq 
  802b08:	c3                   	retq   

0000000000802b09 <stat>:
  802b09:	55                   	push   %rbp
  802b0a:	48 89 e5             	mov    %rsp,%rbp
  802b0d:	48 83 ec 20          	sub    $0x20,%rsp
  802b11:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802b15:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802b19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b1d:	be 00 00 00 00       	mov    $0x0,%esi
  802b22:	48 89 c7             	mov    %rax,%rdi
  802b25:	48 b8 f7 2b 80 00 00 	movabs $0x802bf7,%rax
  802b2c:	00 00 00 
  802b2f:	ff d0                	callq  *%rax
  802b31:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b34:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b38:	79 05                	jns    802b3f <stat+0x36>
  802b3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b3d:	eb 2f                	jmp    802b6e <stat+0x65>
  802b3f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802b43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b46:	48 89 d6             	mov    %rdx,%rsi
  802b49:	89 c7                	mov    %eax,%edi
  802b4b:	48 b8 50 2a 80 00 00 	movabs $0x802a50,%rax
  802b52:	00 00 00 
  802b55:	ff d0                	callq  *%rax
  802b57:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b5d:	89 c7                	mov    %eax,%edi
  802b5f:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  802b66:	00 00 00 
  802b69:	ff d0                	callq  *%rax
  802b6b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b6e:	c9                   	leaveq 
  802b6f:	c3                   	retq   

0000000000802b70 <fsipc>:
  802b70:	55                   	push   %rbp
  802b71:	48 89 e5             	mov    %rsp,%rbp
  802b74:	48 83 ec 10          	sub    $0x10,%rsp
  802b78:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802b7b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802b7f:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b86:	00 00 00 
  802b89:	8b 00                	mov    (%rax),%eax
  802b8b:	85 c0                	test   %eax,%eax
  802b8d:	75 1d                	jne    802bac <fsipc+0x3c>
  802b8f:	bf 01 00 00 00       	mov    $0x1,%edi
  802b94:	48 b8 c4 46 80 00 00 	movabs $0x8046c4,%rax
  802b9b:	00 00 00 
  802b9e:	ff d0                	callq  *%rax
  802ba0:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802ba7:	00 00 00 
  802baa:	89 02                	mov    %eax,(%rdx)
  802bac:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802bb3:	00 00 00 
  802bb6:	8b 00                	mov    (%rax),%eax
  802bb8:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802bbb:	b9 07 00 00 00       	mov    $0x7,%ecx
  802bc0:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802bc7:	00 00 00 
  802bca:	89 c7                	mov    %eax,%edi
  802bcc:	48 b8 b9 45 80 00 00 	movabs $0x8045b9,%rax
  802bd3:	00 00 00 
  802bd6:	ff d0                	callq  *%rax
  802bd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bdc:	ba 00 00 00 00       	mov    $0x0,%edx
  802be1:	48 89 c6             	mov    %rax,%rsi
  802be4:	bf 00 00 00 00       	mov    $0x0,%edi
  802be9:	48 b8 f8 44 80 00 00 	movabs $0x8044f8,%rax
  802bf0:	00 00 00 
  802bf3:	ff d0                	callq  *%rax
  802bf5:	c9                   	leaveq 
  802bf6:	c3                   	retq   

0000000000802bf7 <open>:
  802bf7:	55                   	push   %rbp
  802bf8:	48 89 e5             	mov    %rsp,%rbp
  802bfb:	48 83 ec 20          	sub    $0x20,%rsp
  802bff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c03:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802c06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c0a:	48 89 c7             	mov    %rax,%rdi
  802c0d:	48 b8 79 0e 80 00 00 	movabs $0x800e79,%rax
  802c14:	00 00 00 
  802c17:	ff d0                	callq  *%rax
  802c19:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802c1e:	7e 0a                	jle    802c2a <open+0x33>
  802c20:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802c25:	e9 a5 00 00 00       	jmpq   802ccf <open+0xd8>
  802c2a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802c2e:	48 89 c7             	mov    %rax,%rdi
  802c31:	48 b8 57 22 80 00 00 	movabs $0x802257,%rax
  802c38:	00 00 00 
  802c3b:	ff d0                	callq  *%rax
  802c3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c40:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c44:	79 08                	jns    802c4e <open+0x57>
  802c46:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c49:	e9 81 00 00 00       	jmpq   802ccf <open+0xd8>
  802c4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c52:	48 89 c6             	mov    %rax,%rsi
  802c55:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802c5c:	00 00 00 
  802c5f:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  802c66:	00 00 00 
  802c69:	ff d0                	callq  *%rax
  802c6b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802c72:	00 00 00 
  802c75:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802c78:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802c7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c82:	48 89 c6             	mov    %rax,%rsi
  802c85:	bf 01 00 00 00       	mov    $0x1,%edi
  802c8a:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802c91:	00 00 00 
  802c94:	ff d0                	callq  *%rax
  802c96:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c99:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c9d:	79 1d                	jns    802cbc <open+0xc5>
  802c9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ca3:	be 00 00 00 00       	mov    $0x0,%esi
  802ca8:	48 89 c7             	mov    %rax,%rdi
  802cab:	48 b8 7f 23 80 00 00 	movabs $0x80237f,%rax
  802cb2:	00 00 00 
  802cb5:	ff d0                	callq  *%rax
  802cb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cba:	eb 13                	jmp    802ccf <open+0xd8>
  802cbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cc0:	48 89 c7             	mov    %rax,%rdi
  802cc3:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  802cca:	00 00 00 
  802ccd:	ff d0                	callq  *%rax
  802ccf:	c9                   	leaveq 
  802cd0:	c3                   	retq   

0000000000802cd1 <devfile_flush>:
  802cd1:	55                   	push   %rbp
  802cd2:	48 89 e5             	mov    %rsp,%rbp
  802cd5:	48 83 ec 10          	sub    $0x10,%rsp
  802cd9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ce1:	8b 50 0c             	mov    0xc(%rax),%edx
  802ce4:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802ceb:	00 00 00 
  802cee:	89 10                	mov    %edx,(%rax)
  802cf0:	be 00 00 00 00       	mov    $0x0,%esi
  802cf5:	bf 06 00 00 00       	mov    $0x6,%edi
  802cfa:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802d01:	00 00 00 
  802d04:	ff d0                	callq  *%rax
  802d06:	c9                   	leaveq 
  802d07:	c3                   	retq   

0000000000802d08 <devfile_read>:
  802d08:	55                   	push   %rbp
  802d09:	48 89 e5             	mov    %rsp,%rbp
  802d0c:	48 83 ec 30          	sub    $0x30,%rsp
  802d10:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802d14:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802d18:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802d1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d20:	8b 50 0c             	mov    0xc(%rax),%edx
  802d23:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802d2a:	00 00 00 
  802d2d:	89 10                	mov    %edx,(%rax)
  802d2f:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802d36:	00 00 00 
  802d39:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802d3d:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802d41:	be 00 00 00 00       	mov    $0x0,%esi
  802d46:	bf 03 00 00 00       	mov    $0x3,%edi
  802d4b:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802d52:	00 00 00 
  802d55:	ff d0                	callq  *%rax
  802d57:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d5a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d5e:	79 08                	jns    802d68 <devfile_read+0x60>
  802d60:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d63:	e9 a4 00 00 00       	jmpq   802e0c <devfile_read+0x104>
  802d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d6b:	48 98                	cltq   
  802d6d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802d71:	76 35                	jbe    802da8 <devfile_read+0xa0>
  802d73:	48 b9 76 4e 80 00 00 	movabs $0x804e76,%rcx
  802d7a:	00 00 00 
  802d7d:	48 ba 7d 4e 80 00 00 	movabs $0x804e7d,%rdx
  802d84:	00 00 00 
  802d87:	be 89 00 00 00       	mov    $0x89,%esi
  802d8c:	48 bf 92 4e 80 00 00 	movabs $0x804e92,%rdi
  802d93:	00 00 00 
  802d96:	b8 00 00 00 00       	mov    $0x0,%eax
  802d9b:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  802da2:	00 00 00 
  802da5:	41 ff d0             	callq  *%r8
  802da8:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802daf:	7e 35                	jle    802de6 <devfile_read+0xde>
  802db1:	48 b9 a0 4e 80 00 00 	movabs $0x804ea0,%rcx
  802db8:	00 00 00 
  802dbb:	48 ba 7d 4e 80 00 00 	movabs $0x804e7d,%rdx
  802dc2:	00 00 00 
  802dc5:	be 8a 00 00 00       	mov    $0x8a,%esi
  802dca:	48 bf 92 4e 80 00 00 	movabs $0x804e92,%rdi
  802dd1:	00 00 00 
  802dd4:	b8 00 00 00 00       	mov    $0x0,%eax
  802dd9:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  802de0:	00 00 00 
  802de3:	41 ff d0             	callq  *%r8
  802de6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802de9:	48 63 d0             	movslq %eax,%rdx
  802dec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802df0:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  802df7:	00 00 00 
  802dfa:	48 89 c7             	mov    %rax,%rdi
  802dfd:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  802e04:	00 00 00 
  802e07:	ff d0                	callq  *%rax
  802e09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e0c:	c9                   	leaveq 
  802e0d:	c3                   	retq   

0000000000802e0e <devfile_write>:
  802e0e:	55                   	push   %rbp
  802e0f:	48 89 e5             	mov    %rsp,%rbp
  802e12:	48 83 ec 40          	sub    $0x40,%rsp
  802e16:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802e1a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802e1e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802e22:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802e26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802e2a:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802e31:	00 
  802e32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e36:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802e3a:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802e3f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802e43:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e47:	8b 50 0c             	mov    0xc(%rax),%edx
  802e4a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802e51:	00 00 00 
  802e54:	89 10                	mov    %edx,(%rax)
  802e56:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802e5d:	00 00 00 
  802e60:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802e64:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802e68:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802e6c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e70:	48 89 c6             	mov    %rax,%rsi
  802e73:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  802e7a:	00 00 00 
  802e7d:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  802e84:	00 00 00 
  802e87:	ff d0                	callq  *%rax
  802e89:	be 00 00 00 00       	mov    $0x0,%esi
  802e8e:	bf 04 00 00 00       	mov    $0x4,%edi
  802e93:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802e9a:	00 00 00 
  802e9d:	ff d0                	callq  *%rax
  802e9f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802ea2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802ea6:	79 05                	jns    802ead <devfile_write+0x9f>
  802ea8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802eab:	eb 43                	jmp    802ef0 <devfile_write+0xe2>
  802ead:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802eb0:	48 98                	cltq   
  802eb2:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802eb6:	76 35                	jbe    802eed <devfile_write+0xdf>
  802eb8:	48 b9 76 4e 80 00 00 	movabs $0x804e76,%rcx
  802ebf:	00 00 00 
  802ec2:	48 ba 7d 4e 80 00 00 	movabs $0x804e7d,%rdx
  802ec9:	00 00 00 
  802ecc:	be a8 00 00 00       	mov    $0xa8,%esi
  802ed1:	48 bf 92 4e 80 00 00 	movabs $0x804e92,%rdi
  802ed8:	00 00 00 
  802edb:	b8 00 00 00 00       	mov    $0x0,%eax
  802ee0:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  802ee7:	00 00 00 
  802eea:	41 ff d0             	callq  *%r8
  802eed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802ef0:	c9                   	leaveq 
  802ef1:	c3                   	retq   

0000000000802ef2 <devfile_stat>:
  802ef2:	55                   	push   %rbp
  802ef3:	48 89 e5             	mov    %rsp,%rbp
  802ef6:	48 83 ec 20          	sub    $0x20,%rsp
  802efa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802efe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f06:	8b 50 0c             	mov    0xc(%rax),%edx
  802f09:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802f10:	00 00 00 
  802f13:	89 10                	mov    %edx,(%rax)
  802f15:	be 00 00 00 00       	mov    $0x0,%esi
  802f1a:	bf 05 00 00 00       	mov    $0x5,%edi
  802f1f:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802f26:	00 00 00 
  802f29:	ff d0                	callq  *%rax
  802f2b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f2e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f32:	79 05                	jns    802f39 <devfile_stat+0x47>
  802f34:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f37:	eb 56                	jmp    802f8f <devfile_stat+0x9d>
  802f39:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f3d:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  802f44:	00 00 00 
  802f47:	48 89 c7             	mov    %rax,%rdi
  802f4a:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  802f51:	00 00 00 
  802f54:	ff d0                	callq  *%rax
  802f56:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802f5d:	00 00 00 
  802f60:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802f66:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f6a:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802f70:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802f77:	00 00 00 
  802f7a:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802f80:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f84:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802f8a:	b8 00 00 00 00       	mov    $0x0,%eax
  802f8f:	c9                   	leaveq 
  802f90:	c3                   	retq   

0000000000802f91 <devfile_trunc>:
  802f91:	55                   	push   %rbp
  802f92:	48 89 e5             	mov    %rsp,%rbp
  802f95:	48 83 ec 10          	sub    $0x10,%rsp
  802f99:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802f9d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802fa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fa4:	8b 50 0c             	mov    0xc(%rax),%edx
  802fa7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802fae:	00 00 00 
  802fb1:	89 10                	mov    %edx,(%rax)
  802fb3:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802fba:	00 00 00 
  802fbd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802fc0:	89 50 04             	mov    %edx,0x4(%rax)
  802fc3:	be 00 00 00 00       	mov    $0x0,%esi
  802fc8:	bf 02 00 00 00       	mov    $0x2,%edi
  802fcd:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  802fd4:	00 00 00 
  802fd7:	ff d0                	callq  *%rax
  802fd9:	c9                   	leaveq 
  802fda:	c3                   	retq   

0000000000802fdb <remove>:
  802fdb:	55                   	push   %rbp
  802fdc:	48 89 e5             	mov    %rsp,%rbp
  802fdf:	48 83 ec 10          	sub    $0x10,%rsp
  802fe3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fe7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802feb:	48 89 c7             	mov    %rax,%rdi
  802fee:	48 b8 79 0e 80 00 00 	movabs $0x800e79,%rax
  802ff5:	00 00 00 
  802ff8:	ff d0                	callq  *%rax
  802ffa:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802fff:	7e 07                	jle    803008 <remove+0x2d>
  803001:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803006:	eb 33                	jmp    80303b <remove+0x60>
  803008:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80300c:	48 89 c6             	mov    %rax,%rsi
  80300f:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803016:	00 00 00 
  803019:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  803020:	00 00 00 
  803023:	ff d0                	callq  *%rax
  803025:	be 00 00 00 00       	mov    $0x0,%esi
  80302a:	bf 07 00 00 00       	mov    $0x7,%edi
  80302f:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  803036:	00 00 00 
  803039:	ff d0                	callq  *%rax
  80303b:	c9                   	leaveq 
  80303c:	c3                   	retq   

000000000080303d <sync>:
  80303d:	55                   	push   %rbp
  80303e:	48 89 e5             	mov    %rsp,%rbp
  803041:	be 00 00 00 00       	mov    $0x0,%esi
  803046:	bf 08 00 00 00       	mov    $0x8,%edi
  80304b:	48 b8 70 2b 80 00 00 	movabs $0x802b70,%rax
  803052:	00 00 00 
  803055:	ff d0                	callq  *%rax
  803057:	5d                   	pop    %rbp
  803058:	c3                   	retq   

0000000000803059 <copy>:
  803059:	55                   	push   %rbp
  80305a:	48 89 e5             	mov    %rsp,%rbp
  80305d:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  803064:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  80306b:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  803072:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803079:	be 00 00 00 00       	mov    $0x0,%esi
  80307e:	48 89 c7             	mov    %rax,%rdi
  803081:	48 b8 f7 2b 80 00 00 	movabs $0x802bf7,%rax
  803088:	00 00 00 
  80308b:	ff d0                	callq  *%rax
  80308d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803090:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803094:	79 28                	jns    8030be <copy+0x65>
  803096:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803099:	89 c6                	mov    %eax,%esi
  80309b:	48 bf ac 4e 80 00 00 	movabs $0x804eac,%rdi
  8030a2:	00 00 00 
  8030a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8030aa:	48 ba 30 03 80 00 00 	movabs $0x800330,%rdx
  8030b1:	00 00 00 
  8030b4:	ff d2                	callq  *%rdx
  8030b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030b9:	e9 74 01 00 00       	jmpq   803232 <copy+0x1d9>
  8030be:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  8030c5:	be 01 01 00 00       	mov    $0x101,%esi
  8030ca:	48 89 c7             	mov    %rax,%rdi
  8030cd:	48 b8 f7 2b 80 00 00 	movabs $0x802bf7,%rax
  8030d4:	00 00 00 
  8030d7:	ff d0                	callq  *%rax
  8030d9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8030dc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8030e0:	79 39                	jns    80311b <copy+0xc2>
  8030e2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8030e5:	89 c6                	mov    %eax,%esi
  8030e7:	48 bf c2 4e 80 00 00 	movabs $0x804ec2,%rdi
  8030ee:	00 00 00 
  8030f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8030f6:	48 ba 30 03 80 00 00 	movabs $0x800330,%rdx
  8030fd:	00 00 00 
  803100:	ff d2                	callq  *%rdx
  803102:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803105:	89 c7                	mov    %eax,%edi
  803107:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  80310e:	00 00 00 
  803111:	ff d0                	callq  *%rax
  803113:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803116:	e9 17 01 00 00       	jmpq   803232 <copy+0x1d9>
  80311b:	eb 74                	jmp    803191 <copy+0x138>
  80311d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803120:	48 63 d0             	movslq %eax,%rdx
  803123:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80312a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80312d:	48 89 ce             	mov    %rcx,%rsi
  803130:	89 c7                	mov    %eax,%edi
  803132:	48 b8 6b 28 80 00 00 	movabs $0x80286b,%rax
  803139:	00 00 00 
  80313c:	ff d0                	callq  *%rax
  80313e:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803141:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803145:	79 4a                	jns    803191 <copy+0x138>
  803147:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80314a:	89 c6                	mov    %eax,%esi
  80314c:	48 bf dc 4e 80 00 00 	movabs $0x804edc,%rdi
  803153:	00 00 00 
  803156:	b8 00 00 00 00       	mov    $0x0,%eax
  80315b:	48 ba 30 03 80 00 00 	movabs $0x800330,%rdx
  803162:	00 00 00 
  803165:	ff d2                	callq  *%rdx
  803167:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80316a:	89 c7                	mov    %eax,%edi
  80316c:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  803173:	00 00 00 
  803176:	ff d0                	callq  *%rax
  803178:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80317b:	89 c7                	mov    %eax,%edi
  80317d:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  803184:	00 00 00 
  803187:	ff d0                	callq  *%rax
  803189:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80318c:	e9 a1 00 00 00       	jmpq   803232 <copy+0x1d9>
  803191:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803198:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80319b:	ba 00 02 00 00       	mov    $0x200,%edx
  8031a0:	48 89 ce             	mov    %rcx,%rsi
  8031a3:	89 c7                	mov    %eax,%edi
  8031a5:	48 b8 21 27 80 00 00 	movabs $0x802721,%rax
  8031ac:	00 00 00 
  8031af:	ff d0                	callq  *%rax
  8031b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8031b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8031b8:	0f 8f 5f ff ff ff    	jg     80311d <copy+0xc4>
  8031be:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8031c2:	79 47                	jns    80320b <copy+0x1b2>
  8031c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8031c7:	89 c6                	mov    %eax,%esi
  8031c9:	48 bf ef 4e 80 00 00 	movabs $0x804eef,%rdi
  8031d0:	00 00 00 
  8031d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8031d8:	48 ba 30 03 80 00 00 	movabs $0x800330,%rdx
  8031df:	00 00 00 
  8031e2:	ff d2                	callq  *%rdx
  8031e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031e7:	89 c7                	mov    %eax,%edi
  8031e9:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  8031f0:	00 00 00 
  8031f3:	ff d0                	callq  *%rax
  8031f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8031f8:	89 c7                	mov    %eax,%edi
  8031fa:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  803201:	00 00 00 
  803204:	ff d0                	callq  *%rax
  803206:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803209:	eb 27                	jmp    803232 <copy+0x1d9>
  80320b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80320e:	89 c7                	mov    %eax,%edi
  803210:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  803217:	00 00 00 
  80321a:	ff d0                	callq  *%rax
  80321c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80321f:	89 c7                	mov    %eax,%edi
  803221:	48 b8 ff 24 80 00 00 	movabs $0x8024ff,%rax
  803228:	00 00 00 
  80322b:	ff d0                	callq  *%rax
  80322d:	b8 00 00 00 00       	mov    $0x0,%eax
  803232:	c9                   	leaveq 
  803233:	c3                   	retq   

0000000000803234 <fd2sockid>:
  803234:	55                   	push   %rbp
  803235:	48 89 e5             	mov    %rsp,%rbp
  803238:	48 83 ec 20          	sub    $0x20,%rsp
  80323c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80323f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803243:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803246:	48 89 d6             	mov    %rdx,%rsi
  803249:	89 c7                	mov    %eax,%edi
  80324b:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  803252:	00 00 00 
  803255:	ff d0                	callq  *%rax
  803257:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80325a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80325e:	79 05                	jns    803265 <fd2sockid+0x31>
  803260:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803263:	eb 24                	jmp    803289 <fd2sockid+0x55>
  803265:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803269:	8b 10                	mov    (%rax),%edx
  80326b:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803272:	00 00 00 
  803275:	8b 00                	mov    (%rax),%eax
  803277:	39 c2                	cmp    %eax,%edx
  803279:	74 07                	je     803282 <fd2sockid+0x4e>
  80327b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803280:	eb 07                	jmp    803289 <fd2sockid+0x55>
  803282:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803286:	8b 40 0c             	mov    0xc(%rax),%eax
  803289:	c9                   	leaveq 
  80328a:	c3                   	retq   

000000000080328b <alloc_sockfd>:
  80328b:	55                   	push   %rbp
  80328c:	48 89 e5             	mov    %rsp,%rbp
  80328f:	48 83 ec 20          	sub    $0x20,%rsp
  803293:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803296:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80329a:	48 89 c7             	mov    %rax,%rdi
  80329d:	48 b8 57 22 80 00 00 	movabs $0x802257,%rax
  8032a4:	00 00 00 
  8032a7:	ff d0                	callq  *%rax
  8032a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032b0:	78 26                	js     8032d8 <alloc_sockfd+0x4d>
  8032b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032b6:	ba 07 04 00 00       	mov    $0x407,%edx
  8032bb:	48 89 c6             	mov    %rax,%rsi
  8032be:	bf 00 00 00 00       	mov    $0x0,%edi
  8032c3:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  8032ca:	00 00 00 
  8032cd:	ff d0                	callq  *%rax
  8032cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032d6:	79 16                	jns    8032ee <alloc_sockfd+0x63>
  8032d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8032db:	89 c7                	mov    %eax,%edi
  8032dd:	48 b8 98 37 80 00 00 	movabs $0x803798,%rax
  8032e4:	00 00 00 
  8032e7:	ff d0                	callq  *%rax
  8032e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032ec:	eb 3a                	jmp    803328 <alloc_sockfd+0x9d>
  8032ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032f2:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8032f9:	00 00 00 
  8032fc:	8b 12                	mov    (%rdx),%edx
  8032fe:	89 10                	mov    %edx,(%rax)
  803300:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803304:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80330b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80330f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803312:	89 50 0c             	mov    %edx,0xc(%rax)
  803315:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803319:	48 89 c7             	mov    %rax,%rdi
  80331c:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  803323:	00 00 00 
  803326:	ff d0                	callq  *%rax
  803328:	c9                   	leaveq 
  803329:	c3                   	retq   

000000000080332a <accept>:
  80332a:	55                   	push   %rbp
  80332b:	48 89 e5             	mov    %rsp,%rbp
  80332e:	48 83 ec 30          	sub    $0x30,%rsp
  803332:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803335:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803339:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80333d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803340:	89 c7                	mov    %eax,%edi
  803342:	48 b8 34 32 80 00 00 	movabs $0x803234,%rax
  803349:	00 00 00 
  80334c:	ff d0                	callq  *%rax
  80334e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803351:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803355:	79 05                	jns    80335c <accept+0x32>
  803357:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80335a:	eb 3b                	jmp    803397 <accept+0x6d>
  80335c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803360:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803364:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803367:	48 89 ce             	mov    %rcx,%rsi
  80336a:	89 c7                	mov    %eax,%edi
  80336c:	48 b8 75 36 80 00 00 	movabs $0x803675,%rax
  803373:	00 00 00 
  803376:	ff d0                	callq  *%rax
  803378:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80337b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80337f:	79 05                	jns    803386 <accept+0x5c>
  803381:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803384:	eb 11                	jmp    803397 <accept+0x6d>
  803386:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803389:	89 c7                	mov    %eax,%edi
  80338b:	48 b8 8b 32 80 00 00 	movabs $0x80328b,%rax
  803392:	00 00 00 
  803395:	ff d0                	callq  *%rax
  803397:	c9                   	leaveq 
  803398:	c3                   	retq   

0000000000803399 <bind>:
  803399:	55                   	push   %rbp
  80339a:	48 89 e5             	mov    %rsp,%rbp
  80339d:	48 83 ec 20          	sub    $0x20,%rsp
  8033a1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8033a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8033a8:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8033ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8033ae:	89 c7                	mov    %eax,%edi
  8033b0:	48 b8 34 32 80 00 00 	movabs $0x803234,%rax
  8033b7:	00 00 00 
  8033ba:	ff d0                	callq  *%rax
  8033bc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033c3:	79 05                	jns    8033ca <bind+0x31>
  8033c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033c8:	eb 1b                	jmp    8033e5 <bind+0x4c>
  8033ca:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8033cd:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8033d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033d4:	48 89 ce             	mov    %rcx,%rsi
  8033d7:	89 c7                	mov    %eax,%edi
  8033d9:	48 b8 f4 36 80 00 00 	movabs $0x8036f4,%rax
  8033e0:	00 00 00 
  8033e3:	ff d0                	callq  *%rax
  8033e5:	c9                   	leaveq 
  8033e6:	c3                   	retq   

00000000008033e7 <shutdown>:
  8033e7:	55                   	push   %rbp
  8033e8:	48 89 e5             	mov    %rsp,%rbp
  8033eb:	48 83 ec 20          	sub    $0x20,%rsp
  8033ef:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8033f2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8033f5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8033f8:	89 c7                	mov    %eax,%edi
  8033fa:	48 b8 34 32 80 00 00 	movabs $0x803234,%rax
  803401:	00 00 00 
  803404:	ff d0                	callq  *%rax
  803406:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803409:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80340d:	79 05                	jns    803414 <shutdown+0x2d>
  80340f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803412:	eb 16                	jmp    80342a <shutdown+0x43>
  803414:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803417:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80341a:	89 d6                	mov    %edx,%esi
  80341c:	89 c7                	mov    %eax,%edi
  80341e:	48 b8 58 37 80 00 00 	movabs $0x803758,%rax
  803425:	00 00 00 
  803428:	ff d0                	callq  *%rax
  80342a:	c9                   	leaveq 
  80342b:	c3                   	retq   

000000000080342c <devsock_close>:
  80342c:	55                   	push   %rbp
  80342d:	48 89 e5             	mov    %rsp,%rbp
  803430:	48 83 ec 10          	sub    $0x10,%rsp
  803434:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803438:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80343c:	48 89 c7             	mov    %rax,%rdi
  80343f:	48 b8 36 47 80 00 00 	movabs $0x804736,%rax
  803446:	00 00 00 
  803449:	ff d0                	callq  *%rax
  80344b:	83 f8 01             	cmp    $0x1,%eax
  80344e:	75 17                	jne    803467 <devsock_close+0x3b>
  803450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803454:	8b 40 0c             	mov    0xc(%rax),%eax
  803457:	89 c7                	mov    %eax,%edi
  803459:	48 b8 98 37 80 00 00 	movabs $0x803798,%rax
  803460:	00 00 00 
  803463:	ff d0                	callq  *%rax
  803465:	eb 05                	jmp    80346c <devsock_close+0x40>
  803467:	b8 00 00 00 00       	mov    $0x0,%eax
  80346c:	c9                   	leaveq 
  80346d:	c3                   	retq   

000000000080346e <connect>:
  80346e:	55                   	push   %rbp
  80346f:	48 89 e5             	mov    %rsp,%rbp
  803472:	48 83 ec 20          	sub    $0x20,%rsp
  803476:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803479:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80347d:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803480:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803483:	89 c7                	mov    %eax,%edi
  803485:	48 b8 34 32 80 00 00 	movabs $0x803234,%rax
  80348c:	00 00 00 
  80348f:	ff d0                	callq  *%rax
  803491:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803494:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803498:	79 05                	jns    80349f <connect+0x31>
  80349a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80349d:	eb 1b                	jmp    8034ba <connect+0x4c>
  80349f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8034a2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8034a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034a9:	48 89 ce             	mov    %rcx,%rsi
  8034ac:	89 c7                	mov    %eax,%edi
  8034ae:	48 b8 c5 37 80 00 00 	movabs $0x8037c5,%rax
  8034b5:	00 00 00 
  8034b8:	ff d0                	callq  *%rax
  8034ba:	c9                   	leaveq 
  8034bb:	c3                   	retq   

00000000008034bc <listen>:
  8034bc:	55                   	push   %rbp
  8034bd:	48 89 e5             	mov    %rsp,%rbp
  8034c0:	48 83 ec 20          	sub    $0x20,%rsp
  8034c4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8034c7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8034ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8034cd:	89 c7                	mov    %eax,%edi
  8034cf:	48 b8 34 32 80 00 00 	movabs $0x803234,%rax
  8034d6:	00 00 00 
  8034d9:	ff d0                	callq  *%rax
  8034db:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034de:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034e2:	79 05                	jns    8034e9 <listen+0x2d>
  8034e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034e7:	eb 16                	jmp    8034ff <listen+0x43>
  8034e9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8034ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034ef:	89 d6                	mov    %edx,%esi
  8034f1:	89 c7                	mov    %eax,%edi
  8034f3:	48 b8 29 38 80 00 00 	movabs $0x803829,%rax
  8034fa:	00 00 00 
  8034fd:	ff d0                	callq  *%rax
  8034ff:	c9                   	leaveq 
  803500:	c3                   	retq   

0000000000803501 <devsock_read>:
  803501:	55                   	push   %rbp
  803502:	48 89 e5             	mov    %rsp,%rbp
  803505:	48 83 ec 20          	sub    $0x20,%rsp
  803509:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80350d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803511:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803519:	89 c2                	mov    %eax,%edx
  80351b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80351f:	8b 40 0c             	mov    0xc(%rax),%eax
  803522:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803526:	b9 00 00 00 00       	mov    $0x0,%ecx
  80352b:	89 c7                	mov    %eax,%edi
  80352d:	48 b8 69 38 80 00 00 	movabs $0x803869,%rax
  803534:	00 00 00 
  803537:	ff d0                	callq  *%rax
  803539:	c9                   	leaveq 
  80353a:	c3                   	retq   

000000000080353b <devsock_write>:
  80353b:	55                   	push   %rbp
  80353c:	48 89 e5             	mov    %rsp,%rbp
  80353f:	48 83 ec 20          	sub    $0x20,%rsp
  803543:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803547:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80354b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80354f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803553:	89 c2                	mov    %eax,%edx
  803555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803559:	8b 40 0c             	mov    0xc(%rax),%eax
  80355c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803560:	b9 00 00 00 00       	mov    $0x0,%ecx
  803565:	89 c7                	mov    %eax,%edi
  803567:	48 b8 35 39 80 00 00 	movabs $0x803935,%rax
  80356e:	00 00 00 
  803571:	ff d0                	callq  *%rax
  803573:	c9                   	leaveq 
  803574:	c3                   	retq   

0000000000803575 <devsock_stat>:
  803575:	55                   	push   %rbp
  803576:	48 89 e5             	mov    %rsp,%rbp
  803579:	48 83 ec 10          	sub    $0x10,%rsp
  80357d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803581:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803585:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803589:	48 be 0a 4f 80 00 00 	movabs $0x804f0a,%rsi
  803590:	00 00 00 
  803593:	48 89 c7             	mov    %rax,%rdi
  803596:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  80359d:	00 00 00 
  8035a0:	ff d0                	callq  *%rax
  8035a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8035a7:	c9                   	leaveq 
  8035a8:	c3                   	retq   

00000000008035a9 <socket>:
  8035a9:	55                   	push   %rbp
  8035aa:	48 89 e5             	mov    %rsp,%rbp
  8035ad:	48 83 ec 20          	sub    $0x20,%rsp
  8035b1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8035b4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8035b7:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  8035ba:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8035bd:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8035c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035c3:	89 ce                	mov    %ecx,%esi
  8035c5:	89 c7                	mov    %eax,%edi
  8035c7:	48 b8 ed 39 80 00 00 	movabs $0x8039ed,%rax
  8035ce:	00 00 00 
  8035d1:	ff d0                	callq  *%rax
  8035d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035da:	79 05                	jns    8035e1 <socket+0x38>
  8035dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035df:	eb 11                	jmp    8035f2 <socket+0x49>
  8035e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035e4:	89 c7                	mov    %eax,%edi
  8035e6:	48 b8 8b 32 80 00 00 	movabs $0x80328b,%rax
  8035ed:	00 00 00 
  8035f0:	ff d0                	callq  *%rax
  8035f2:	c9                   	leaveq 
  8035f3:	c3                   	retq   

00000000008035f4 <nsipc>:
  8035f4:	55                   	push   %rbp
  8035f5:	48 89 e5             	mov    %rsp,%rbp
  8035f8:	48 83 ec 10          	sub    $0x10,%rsp
  8035fc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8035ff:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803606:	00 00 00 
  803609:	8b 00                	mov    (%rax),%eax
  80360b:	85 c0                	test   %eax,%eax
  80360d:	75 1d                	jne    80362c <nsipc+0x38>
  80360f:	bf 02 00 00 00       	mov    $0x2,%edi
  803614:	48 b8 c4 46 80 00 00 	movabs $0x8046c4,%rax
  80361b:	00 00 00 
  80361e:	ff d0                	callq  *%rax
  803620:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803627:	00 00 00 
  80362a:	89 02                	mov    %eax,(%rdx)
  80362c:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803633:	00 00 00 
  803636:	8b 00                	mov    (%rax),%eax
  803638:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80363b:	b9 07 00 00 00       	mov    $0x7,%ecx
  803640:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803647:	00 00 00 
  80364a:	89 c7                	mov    %eax,%edi
  80364c:	48 b8 b9 45 80 00 00 	movabs $0x8045b9,%rax
  803653:	00 00 00 
  803656:	ff d0                	callq  *%rax
  803658:	ba 00 00 00 00       	mov    $0x0,%edx
  80365d:	be 00 00 00 00       	mov    $0x0,%esi
  803662:	bf 00 00 00 00       	mov    $0x0,%edi
  803667:	48 b8 f8 44 80 00 00 	movabs $0x8044f8,%rax
  80366e:	00 00 00 
  803671:	ff d0                	callq  *%rax
  803673:	c9                   	leaveq 
  803674:	c3                   	retq   

0000000000803675 <nsipc_accept>:
  803675:	55                   	push   %rbp
  803676:	48 89 e5             	mov    %rsp,%rbp
  803679:	48 83 ec 30          	sub    $0x30,%rsp
  80367d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803680:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803684:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803688:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80368f:	00 00 00 
  803692:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803695:	89 10                	mov    %edx,(%rax)
  803697:	bf 01 00 00 00       	mov    $0x1,%edi
  80369c:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  8036a3:	00 00 00 
  8036a6:	ff d0                	callq  *%rax
  8036a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036af:	78 3e                	js     8036ef <nsipc_accept+0x7a>
  8036b1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8036b8:	00 00 00 
  8036bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8036bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036c3:	8b 40 10             	mov    0x10(%rax),%eax
  8036c6:	89 c2                	mov    %eax,%edx
  8036c8:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8036cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036d0:	48 89 ce             	mov    %rcx,%rsi
  8036d3:	48 89 c7             	mov    %rax,%rdi
  8036d6:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  8036dd:	00 00 00 
  8036e0:	ff d0                	callq  *%rax
  8036e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036e6:	8b 50 10             	mov    0x10(%rax),%edx
  8036e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8036ed:	89 10                	mov    %edx,(%rax)
  8036ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036f2:	c9                   	leaveq 
  8036f3:	c3                   	retq   

00000000008036f4 <nsipc_bind>:
  8036f4:	55                   	push   %rbp
  8036f5:	48 89 e5             	mov    %rsp,%rbp
  8036f8:	48 83 ec 10          	sub    $0x10,%rsp
  8036fc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8036ff:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803703:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803706:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80370d:	00 00 00 
  803710:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803713:	89 10                	mov    %edx,(%rax)
  803715:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803718:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80371c:	48 89 c6             	mov    %rax,%rsi
  80371f:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803726:	00 00 00 
  803729:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  803730:	00 00 00 
  803733:	ff d0                	callq  *%rax
  803735:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80373c:	00 00 00 
  80373f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803742:	89 50 14             	mov    %edx,0x14(%rax)
  803745:	bf 02 00 00 00       	mov    $0x2,%edi
  80374a:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  803751:	00 00 00 
  803754:	ff d0                	callq  *%rax
  803756:	c9                   	leaveq 
  803757:	c3                   	retq   

0000000000803758 <nsipc_shutdown>:
  803758:	55                   	push   %rbp
  803759:	48 89 e5             	mov    %rsp,%rbp
  80375c:	48 83 ec 10          	sub    $0x10,%rsp
  803760:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803763:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803766:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80376d:	00 00 00 
  803770:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803773:	89 10                	mov    %edx,(%rax)
  803775:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80377c:	00 00 00 
  80377f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803782:	89 50 04             	mov    %edx,0x4(%rax)
  803785:	bf 03 00 00 00       	mov    $0x3,%edi
  80378a:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  803791:	00 00 00 
  803794:	ff d0                	callq  *%rax
  803796:	c9                   	leaveq 
  803797:	c3                   	retq   

0000000000803798 <nsipc_close>:
  803798:	55                   	push   %rbp
  803799:	48 89 e5             	mov    %rsp,%rbp
  80379c:	48 83 ec 10          	sub    $0x10,%rsp
  8037a0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8037a3:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8037aa:	00 00 00 
  8037ad:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8037b0:	89 10                	mov    %edx,(%rax)
  8037b2:	bf 04 00 00 00       	mov    $0x4,%edi
  8037b7:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  8037be:	00 00 00 
  8037c1:	ff d0                	callq  *%rax
  8037c3:	c9                   	leaveq 
  8037c4:	c3                   	retq   

00000000008037c5 <nsipc_connect>:
  8037c5:	55                   	push   %rbp
  8037c6:	48 89 e5             	mov    %rsp,%rbp
  8037c9:	48 83 ec 10          	sub    $0x10,%rsp
  8037cd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8037d0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037d4:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8037d7:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8037de:	00 00 00 
  8037e1:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8037e4:	89 10                	mov    %edx,(%rax)
  8037e6:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8037e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037ed:	48 89 c6             	mov    %rax,%rsi
  8037f0:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  8037f7:	00 00 00 
  8037fa:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  803801:	00 00 00 
  803804:	ff d0                	callq  *%rax
  803806:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80380d:	00 00 00 
  803810:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803813:	89 50 14             	mov    %edx,0x14(%rax)
  803816:	bf 05 00 00 00       	mov    $0x5,%edi
  80381b:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  803822:	00 00 00 
  803825:	ff d0                	callq  *%rax
  803827:	c9                   	leaveq 
  803828:	c3                   	retq   

0000000000803829 <nsipc_listen>:
  803829:	55                   	push   %rbp
  80382a:	48 89 e5             	mov    %rsp,%rbp
  80382d:	48 83 ec 10          	sub    $0x10,%rsp
  803831:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803834:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803837:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80383e:	00 00 00 
  803841:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803844:	89 10                	mov    %edx,(%rax)
  803846:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80384d:	00 00 00 
  803850:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803853:	89 50 04             	mov    %edx,0x4(%rax)
  803856:	bf 06 00 00 00       	mov    $0x6,%edi
  80385b:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  803862:	00 00 00 
  803865:	ff d0                	callq  *%rax
  803867:	c9                   	leaveq 
  803868:	c3                   	retq   

0000000000803869 <nsipc_recv>:
  803869:	55                   	push   %rbp
  80386a:	48 89 e5             	mov    %rsp,%rbp
  80386d:	48 83 ec 30          	sub    $0x30,%rsp
  803871:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803874:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803878:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80387b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80387e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803885:	00 00 00 
  803888:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80388b:	89 10                	mov    %edx,(%rax)
  80388d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803894:	00 00 00 
  803897:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80389a:	89 50 04             	mov    %edx,0x4(%rax)
  80389d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8038a4:	00 00 00 
  8038a7:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8038aa:	89 50 08             	mov    %edx,0x8(%rax)
  8038ad:	bf 07 00 00 00       	mov    $0x7,%edi
  8038b2:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  8038b9:	00 00 00 
  8038bc:	ff d0                	callq  *%rax
  8038be:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038c5:	78 69                	js     803930 <nsipc_recv+0xc7>
  8038c7:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  8038ce:	7f 08                	jg     8038d8 <nsipc_recv+0x6f>
  8038d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038d3:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  8038d6:	7e 35                	jle    80390d <nsipc_recv+0xa4>
  8038d8:	48 b9 11 4f 80 00 00 	movabs $0x804f11,%rcx
  8038df:	00 00 00 
  8038e2:	48 ba 26 4f 80 00 00 	movabs $0x804f26,%rdx
  8038e9:	00 00 00 
  8038ec:	be 62 00 00 00       	mov    $0x62,%esi
  8038f1:	48 bf 3b 4f 80 00 00 	movabs $0x804f3b,%rdi
  8038f8:	00 00 00 
  8038fb:	b8 00 00 00 00       	mov    $0x0,%eax
  803900:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  803907:	00 00 00 
  80390a:	41 ff d0             	callq  *%r8
  80390d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803910:	48 63 d0             	movslq %eax,%rdx
  803913:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803917:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  80391e:	00 00 00 
  803921:	48 89 c7             	mov    %rax,%rdi
  803924:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  80392b:	00 00 00 
  80392e:	ff d0                	callq  *%rax
  803930:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803933:	c9                   	leaveq 
  803934:	c3                   	retq   

0000000000803935 <nsipc_send>:
  803935:	55                   	push   %rbp
  803936:	48 89 e5             	mov    %rsp,%rbp
  803939:	48 83 ec 20          	sub    $0x20,%rsp
  80393d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803940:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803944:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803947:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80394a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803951:	00 00 00 
  803954:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803957:	89 10                	mov    %edx,(%rax)
  803959:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803960:	7e 35                	jle    803997 <nsipc_send+0x62>
  803962:	48 b9 4a 4f 80 00 00 	movabs $0x804f4a,%rcx
  803969:	00 00 00 
  80396c:	48 ba 26 4f 80 00 00 	movabs $0x804f26,%rdx
  803973:	00 00 00 
  803976:	be 6d 00 00 00       	mov    $0x6d,%esi
  80397b:	48 bf 3b 4f 80 00 00 	movabs $0x804f3b,%rdi
  803982:	00 00 00 
  803985:	b8 00 00 00 00       	mov    $0x0,%eax
  80398a:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  803991:	00 00 00 
  803994:	41 ff d0             	callq  *%r8
  803997:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80399a:	48 63 d0             	movslq %eax,%rdx
  80399d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039a1:	48 89 c6             	mov    %rax,%rsi
  8039a4:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  8039ab:	00 00 00 
  8039ae:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  8039b5:	00 00 00 
  8039b8:	ff d0                	callq  *%rax
  8039ba:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8039c1:	00 00 00 
  8039c4:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8039c7:	89 50 04             	mov    %edx,0x4(%rax)
  8039ca:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8039d1:	00 00 00 
  8039d4:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8039d7:	89 50 08             	mov    %edx,0x8(%rax)
  8039da:	bf 08 00 00 00       	mov    $0x8,%edi
  8039df:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  8039e6:	00 00 00 
  8039e9:	ff d0                	callq  *%rax
  8039eb:	c9                   	leaveq 
  8039ec:	c3                   	retq   

00000000008039ed <nsipc_socket>:
  8039ed:	55                   	push   %rbp
  8039ee:	48 89 e5             	mov    %rsp,%rbp
  8039f1:	48 83 ec 10          	sub    $0x10,%rsp
  8039f5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039f8:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8039fb:	89 55 f4             	mov    %edx,-0xc(%rbp)
  8039fe:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a05:	00 00 00 
  803a08:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a0b:	89 10                	mov    %edx,(%rax)
  803a0d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a14:	00 00 00 
  803a17:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a1a:	89 50 04             	mov    %edx,0x4(%rax)
  803a1d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a24:	00 00 00 
  803a27:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803a2a:	89 50 08             	mov    %edx,0x8(%rax)
  803a2d:	bf 09 00 00 00       	mov    $0x9,%edi
  803a32:	48 b8 f4 35 80 00 00 	movabs $0x8035f4,%rax
  803a39:	00 00 00 
  803a3c:	ff d0                	callq  *%rax
  803a3e:	c9                   	leaveq 
  803a3f:	c3                   	retq   

0000000000803a40 <pipe>:
  803a40:	55                   	push   %rbp
  803a41:	48 89 e5             	mov    %rsp,%rbp
  803a44:	53                   	push   %rbx
  803a45:	48 83 ec 38          	sub    $0x38,%rsp
  803a49:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803a4d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803a51:	48 89 c7             	mov    %rax,%rdi
  803a54:	48 b8 57 22 80 00 00 	movabs $0x802257,%rax
  803a5b:	00 00 00 
  803a5e:	ff d0                	callq  *%rax
  803a60:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803a63:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803a67:	0f 88 bf 01 00 00    	js     803c2c <pipe+0x1ec>
  803a6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a71:	ba 07 04 00 00       	mov    $0x407,%edx
  803a76:	48 89 c6             	mov    %rax,%rsi
  803a79:	bf 00 00 00 00       	mov    $0x0,%edi
  803a7e:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  803a85:	00 00 00 
  803a88:	ff d0                	callq  *%rax
  803a8a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803a8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803a91:	0f 88 95 01 00 00    	js     803c2c <pipe+0x1ec>
  803a97:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803a9b:	48 89 c7             	mov    %rax,%rdi
  803a9e:	48 b8 57 22 80 00 00 	movabs $0x802257,%rax
  803aa5:	00 00 00 
  803aa8:	ff d0                	callq  *%rax
  803aaa:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803aad:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803ab1:	0f 88 5d 01 00 00    	js     803c14 <pipe+0x1d4>
  803ab7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803abb:	ba 07 04 00 00       	mov    $0x407,%edx
  803ac0:	48 89 c6             	mov    %rax,%rsi
  803ac3:	bf 00 00 00 00       	mov    $0x0,%edi
  803ac8:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  803acf:	00 00 00 
  803ad2:	ff d0                	callq  *%rax
  803ad4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ad7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803adb:	0f 88 33 01 00 00    	js     803c14 <pipe+0x1d4>
  803ae1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ae5:	48 89 c7             	mov    %rax,%rdi
  803ae8:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803aef:	00 00 00 
  803af2:	ff d0                	callq  *%rax
  803af4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803af8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803afc:	ba 07 04 00 00       	mov    $0x407,%edx
  803b01:	48 89 c6             	mov    %rax,%rsi
  803b04:	bf 00 00 00 00       	mov    $0x0,%edi
  803b09:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  803b10:	00 00 00 
  803b13:	ff d0                	callq  *%rax
  803b15:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b18:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803b1c:	79 05                	jns    803b23 <pipe+0xe3>
  803b1e:	e9 d9 00 00 00       	jmpq   803bfc <pipe+0x1bc>
  803b23:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803b27:	48 89 c7             	mov    %rax,%rdi
  803b2a:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803b31:	00 00 00 
  803b34:	ff d0                	callq  *%rax
  803b36:	48 89 c2             	mov    %rax,%rdx
  803b39:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b3d:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803b43:	48 89 d1             	mov    %rdx,%rcx
  803b46:	ba 00 00 00 00       	mov    $0x0,%edx
  803b4b:	48 89 c6             	mov    %rax,%rsi
  803b4e:	bf 00 00 00 00       	mov    $0x0,%edi
  803b53:	48 b8 64 18 80 00 00 	movabs $0x801864,%rax
  803b5a:	00 00 00 
  803b5d:	ff d0                	callq  *%rax
  803b5f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b62:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803b66:	79 1b                	jns    803b83 <pipe+0x143>
  803b68:	90                   	nop
  803b69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b6d:	48 89 c6             	mov    %rax,%rsi
  803b70:	bf 00 00 00 00       	mov    $0x0,%edi
  803b75:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  803b7c:	00 00 00 
  803b7f:	ff d0                	callq  *%rax
  803b81:	eb 79                	jmp    803bfc <pipe+0x1bc>
  803b83:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b87:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803b8e:	00 00 00 
  803b91:	8b 12                	mov    (%rdx),%edx
  803b93:	89 10                	mov    %edx,(%rax)
  803b95:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b99:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803ba0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ba4:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803bab:	00 00 00 
  803bae:	8b 12                	mov    (%rdx),%edx
  803bb0:	89 10                	mov    %edx,(%rax)
  803bb2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803bb6:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803bbd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bc1:	48 89 c7             	mov    %rax,%rdi
  803bc4:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  803bcb:	00 00 00 
  803bce:	ff d0                	callq  *%rax
  803bd0:	89 c2                	mov    %eax,%edx
  803bd2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803bd6:	89 10                	mov    %edx,(%rax)
  803bd8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803bdc:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803be0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803be4:	48 89 c7             	mov    %rax,%rdi
  803be7:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  803bee:	00 00 00 
  803bf1:	ff d0                	callq  *%rax
  803bf3:	89 03                	mov    %eax,(%rbx)
  803bf5:	b8 00 00 00 00       	mov    $0x0,%eax
  803bfa:	eb 33                	jmp    803c2f <pipe+0x1ef>
  803bfc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c00:	48 89 c6             	mov    %rax,%rsi
  803c03:	bf 00 00 00 00       	mov    $0x0,%edi
  803c08:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  803c0f:	00 00 00 
  803c12:	ff d0                	callq  *%rax
  803c14:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c18:	48 89 c6             	mov    %rax,%rsi
  803c1b:	bf 00 00 00 00       	mov    $0x0,%edi
  803c20:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  803c27:	00 00 00 
  803c2a:	ff d0                	callq  *%rax
  803c2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c2f:	48 83 c4 38          	add    $0x38,%rsp
  803c33:	5b                   	pop    %rbx
  803c34:	5d                   	pop    %rbp
  803c35:	c3                   	retq   

0000000000803c36 <_pipeisclosed>:
  803c36:	55                   	push   %rbp
  803c37:	48 89 e5             	mov    %rsp,%rbp
  803c3a:	53                   	push   %rbx
  803c3b:	48 83 ec 28          	sub    $0x28,%rsp
  803c3f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803c43:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803c47:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803c4e:	00 00 00 
  803c51:	48 8b 00             	mov    (%rax),%rax
  803c54:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803c5a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803c5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c61:	48 89 c7             	mov    %rax,%rdi
  803c64:	48 b8 36 47 80 00 00 	movabs $0x804736,%rax
  803c6b:	00 00 00 
  803c6e:	ff d0                	callq  *%rax
  803c70:	89 c3                	mov    %eax,%ebx
  803c72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c76:	48 89 c7             	mov    %rax,%rdi
  803c79:	48 b8 36 47 80 00 00 	movabs $0x804736,%rax
  803c80:	00 00 00 
  803c83:	ff d0                	callq  *%rax
  803c85:	39 c3                	cmp    %eax,%ebx
  803c87:	0f 94 c0             	sete   %al
  803c8a:	0f b6 c0             	movzbl %al,%eax
  803c8d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803c90:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803c97:	00 00 00 
  803c9a:	48 8b 00             	mov    (%rax),%rax
  803c9d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803ca3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803ca6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ca9:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803cac:	75 05                	jne    803cb3 <_pipeisclosed+0x7d>
  803cae:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803cb1:	eb 4f                	jmp    803d02 <_pipeisclosed+0xcc>
  803cb3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803cb6:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803cb9:	74 42                	je     803cfd <_pipeisclosed+0xc7>
  803cbb:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803cbf:	75 3c                	jne    803cfd <_pipeisclosed+0xc7>
  803cc1:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803cc8:	00 00 00 
  803ccb:	48 8b 00             	mov    (%rax),%rax
  803cce:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803cd4:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803cd7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803cda:	89 c6                	mov    %eax,%esi
  803cdc:	48 bf 5b 4f 80 00 00 	movabs $0x804f5b,%rdi
  803ce3:	00 00 00 
  803ce6:	b8 00 00 00 00       	mov    $0x0,%eax
  803ceb:	49 b8 30 03 80 00 00 	movabs $0x800330,%r8
  803cf2:	00 00 00 
  803cf5:	41 ff d0             	callq  *%r8
  803cf8:	e9 4a ff ff ff       	jmpq   803c47 <_pipeisclosed+0x11>
  803cfd:	e9 45 ff ff ff       	jmpq   803c47 <_pipeisclosed+0x11>
  803d02:	48 83 c4 28          	add    $0x28,%rsp
  803d06:	5b                   	pop    %rbx
  803d07:	5d                   	pop    %rbp
  803d08:	c3                   	retq   

0000000000803d09 <pipeisclosed>:
  803d09:	55                   	push   %rbp
  803d0a:	48 89 e5             	mov    %rsp,%rbp
  803d0d:	48 83 ec 30          	sub    $0x30,%rsp
  803d11:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803d14:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803d18:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803d1b:	48 89 d6             	mov    %rdx,%rsi
  803d1e:	89 c7                	mov    %eax,%edi
  803d20:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  803d27:	00 00 00 
  803d2a:	ff d0                	callq  *%rax
  803d2c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d2f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d33:	79 05                	jns    803d3a <pipeisclosed+0x31>
  803d35:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d38:	eb 31                	jmp    803d6b <pipeisclosed+0x62>
  803d3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d3e:	48 89 c7             	mov    %rax,%rdi
  803d41:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803d48:	00 00 00 
  803d4b:	ff d0                	callq  *%rax
  803d4d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803d51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d55:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803d59:	48 89 d6             	mov    %rdx,%rsi
  803d5c:	48 89 c7             	mov    %rax,%rdi
  803d5f:	48 b8 36 3c 80 00 00 	movabs $0x803c36,%rax
  803d66:	00 00 00 
  803d69:	ff d0                	callq  *%rax
  803d6b:	c9                   	leaveq 
  803d6c:	c3                   	retq   

0000000000803d6d <devpipe_read>:
  803d6d:	55                   	push   %rbp
  803d6e:	48 89 e5             	mov    %rsp,%rbp
  803d71:	48 83 ec 40          	sub    $0x40,%rsp
  803d75:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803d79:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803d7d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803d81:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d85:	48 89 c7             	mov    %rax,%rdi
  803d88:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803d8f:	00 00 00 
  803d92:	ff d0                	callq  *%rax
  803d94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803d98:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803d9c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803da0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803da7:	00 
  803da8:	e9 92 00 00 00       	jmpq   803e3f <devpipe_read+0xd2>
  803dad:	eb 41                	jmp    803df0 <devpipe_read+0x83>
  803daf:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  803db4:	74 09                	je     803dbf <devpipe_read+0x52>
  803db6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803dba:	e9 92 00 00 00       	jmpq   803e51 <devpipe_read+0xe4>
  803dbf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803dc3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803dc7:	48 89 d6             	mov    %rdx,%rsi
  803dca:	48 89 c7             	mov    %rax,%rdi
  803dcd:	48 b8 36 3c 80 00 00 	movabs $0x803c36,%rax
  803dd4:	00 00 00 
  803dd7:	ff d0                	callq  *%rax
  803dd9:	85 c0                	test   %eax,%eax
  803ddb:	74 07                	je     803de4 <devpipe_read+0x77>
  803ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  803de2:	eb 6d                	jmp    803e51 <devpipe_read+0xe4>
  803de4:	48 b8 d6 17 80 00 00 	movabs $0x8017d6,%rax
  803deb:	00 00 00 
  803dee:	ff d0                	callq  *%rax
  803df0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803df4:	8b 10                	mov    (%rax),%edx
  803df6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803dfa:	8b 40 04             	mov    0x4(%rax),%eax
  803dfd:	39 c2                	cmp    %eax,%edx
  803dff:	74 ae                	je     803daf <devpipe_read+0x42>
  803e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e05:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803e09:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  803e0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e11:	8b 00                	mov    (%rax),%eax
  803e13:	99                   	cltd   
  803e14:	c1 ea 1b             	shr    $0x1b,%edx
  803e17:	01 d0                	add    %edx,%eax
  803e19:	83 e0 1f             	and    $0x1f,%eax
  803e1c:	29 d0                	sub    %edx,%eax
  803e1e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803e22:	48 98                	cltq   
  803e24:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  803e29:	88 01                	mov    %al,(%rcx)
  803e2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e2f:	8b 00                	mov    (%rax),%eax
  803e31:	8d 50 01             	lea    0x1(%rax),%edx
  803e34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e38:	89 10                	mov    %edx,(%rax)
  803e3a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e43:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803e47:	0f 82 60 ff ff ff    	jb     803dad <devpipe_read+0x40>
  803e4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803e51:	c9                   	leaveq 
  803e52:	c3                   	retq   

0000000000803e53 <devpipe_write>:
  803e53:	55                   	push   %rbp
  803e54:	48 89 e5             	mov    %rsp,%rbp
  803e57:	48 83 ec 40          	sub    $0x40,%rsp
  803e5b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803e5f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803e63:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803e67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e6b:	48 89 c7             	mov    %rax,%rdi
  803e6e:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803e75:	00 00 00 
  803e78:	ff d0                	callq  *%rax
  803e7a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803e7e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e82:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803e86:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803e8d:	00 
  803e8e:	e9 8e 00 00 00       	jmpq   803f21 <devpipe_write+0xce>
  803e93:	eb 31                	jmp    803ec6 <devpipe_write+0x73>
  803e95:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803e99:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e9d:	48 89 d6             	mov    %rdx,%rsi
  803ea0:	48 89 c7             	mov    %rax,%rdi
  803ea3:	48 b8 36 3c 80 00 00 	movabs $0x803c36,%rax
  803eaa:	00 00 00 
  803ead:	ff d0                	callq  *%rax
  803eaf:	85 c0                	test   %eax,%eax
  803eb1:	74 07                	je     803eba <devpipe_write+0x67>
  803eb3:	b8 00 00 00 00       	mov    $0x0,%eax
  803eb8:	eb 79                	jmp    803f33 <devpipe_write+0xe0>
  803eba:	48 b8 d6 17 80 00 00 	movabs $0x8017d6,%rax
  803ec1:	00 00 00 
  803ec4:	ff d0                	callq  *%rax
  803ec6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803eca:	8b 40 04             	mov    0x4(%rax),%eax
  803ecd:	48 63 d0             	movslq %eax,%rdx
  803ed0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ed4:	8b 00                	mov    (%rax),%eax
  803ed6:	48 98                	cltq   
  803ed8:	48 83 c0 20          	add    $0x20,%rax
  803edc:	48 39 c2             	cmp    %rax,%rdx
  803edf:	73 b4                	jae    803e95 <devpipe_write+0x42>
  803ee1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ee5:	8b 40 04             	mov    0x4(%rax),%eax
  803ee8:	99                   	cltd   
  803ee9:	c1 ea 1b             	shr    $0x1b,%edx
  803eec:	01 d0                	add    %edx,%eax
  803eee:	83 e0 1f             	and    $0x1f,%eax
  803ef1:	29 d0                	sub    %edx,%eax
  803ef3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803ef7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803efb:	48 01 ca             	add    %rcx,%rdx
  803efe:	0f b6 0a             	movzbl (%rdx),%ecx
  803f01:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803f05:	48 98                	cltq   
  803f07:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803f0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f0f:	8b 40 04             	mov    0x4(%rax),%eax
  803f12:	8d 50 01             	lea    0x1(%rax),%edx
  803f15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f19:	89 50 04             	mov    %edx,0x4(%rax)
  803f1c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803f21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f25:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803f29:	0f 82 64 ff ff ff    	jb     803e93 <devpipe_write+0x40>
  803f2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f33:	c9                   	leaveq 
  803f34:	c3                   	retq   

0000000000803f35 <devpipe_stat>:
  803f35:	55                   	push   %rbp
  803f36:	48 89 e5             	mov    %rsp,%rbp
  803f39:	48 83 ec 20          	sub    $0x20,%rsp
  803f3d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f41:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f49:	48 89 c7             	mov    %rax,%rdi
  803f4c:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803f53:	00 00 00 
  803f56:	ff d0                	callq  *%rax
  803f58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803f5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f60:	48 be 6e 4f 80 00 00 	movabs $0x804f6e,%rsi
  803f67:	00 00 00 
  803f6a:	48 89 c7             	mov    %rax,%rdi
  803f6d:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  803f74:	00 00 00 
  803f77:	ff d0                	callq  *%rax
  803f79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f7d:	8b 50 04             	mov    0x4(%rax),%edx
  803f80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f84:	8b 00                	mov    (%rax),%eax
  803f86:	29 c2                	sub    %eax,%edx
  803f88:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f8c:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803f92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f96:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803f9d:	00 00 00 
  803fa0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fa4:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  803fab:	00 00 00 
  803fae:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  803fb5:	b8 00 00 00 00       	mov    $0x0,%eax
  803fba:	c9                   	leaveq 
  803fbb:	c3                   	retq   

0000000000803fbc <devpipe_close>:
  803fbc:	55                   	push   %rbp
  803fbd:	48 89 e5             	mov    %rsp,%rbp
  803fc0:	48 83 ec 10          	sub    $0x10,%rsp
  803fc4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803fc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803fcc:	48 89 c6             	mov    %rax,%rsi
  803fcf:	bf 00 00 00 00       	mov    $0x0,%edi
  803fd4:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  803fdb:	00 00 00 
  803fde:	ff d0                	callq  *%rax
  803fe0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803fe4:	48 89 c7             	mov    %rax,%rdi
  803fe7:	48 b8 2c 22 80 00 00 	movabs $0x80222c,%rax
  803fee:	00 00 00 
  803ff1:	ff d0                	callq  *%rax
  803ff3:	48 89 c6             	mov    %rax,%rsi
  803ff6:	bf 00 00 00 00       	mov    $0x0,%edi
  803ffb:	48 b8 bf 18 80 00 00 	movabs $0x8018bf,%rax
  804002:	00 00 00 
  804005:	ff d0                	callq  *%rax
  804007:	c9                   	leaveq 
  804008:	c3                   	retq   

0000000000804009 <cputchar>:
  804009:	55                   	push   %rbp
  80400a:	48 89 e5             	mov    %rsp,%rbp
  80400d:	48 83 ec 20          	sub    $0x20,%rsp
  804011:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804014:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804017:	88 45 ff             	mov    %al,-0x1(%rbp)
  80401a:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  80401e:	be 01 00 00 00       	mov    $0x1,%esi
  804023:	48 89 c7             	mov    %rax,%rdi
  804026:	48 b8 cc 16 80 00 00 	movabs $0x8016cc,%rax
  80402d:	00 00 00 
  804030:	ff d0                	callq  *%rax
  804032:	c9                   	leaveq 
  804033:	c3                   	retq   

0000000000804034 <getchar>:
  804034:	55                   	push   %rbp
  804035:	48 89 e5             	mov    %rsp,%rbp
  804038:	48 83 ec 10          	sub    $0x10,%rsp
  80403c:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  804040:	ba 01 00 00 00       	mov    $0x1,%edx
  804045:	48 89 c6             	mov    %rax,%rsi
  804048:	bf 00 00 00 00       	mov    $0x0,%edi
  80404d:	48 b8 21 27 80 00 00 	movabs $0x802721,%rax
  804054:	00 00 00 
  804057:	ff d0                	callq  *%rax
  804059:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80405c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804060:	79 05                	jns    804067 <getchar+0x33>
  804062:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804065:	eb 14                	jmp    80407b <getchar+0x47>
  804067:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80406b:	7f 07                	jg     804074 <getchar+0x40>
  80406d:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  804072:	eb 07                	jmp    80407b <getchar+0x47>
  804074:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804078:	0f b6 c0             	movzbl %al,%eax
  80407b:	c9                   	leaveq 
  80407c:	c3                   	retq   

000000000080407d <iscons>:
  80407d:	55                   	push   %rbp
  80407e:	48 89 e5             	mov    %rsp,%rbp
  804081:	48 83 ec 20          	sub    $0x20,%rsp
  804085:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804088:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80408c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80408f:	48 89 d6             	mov    %rdx,%rsi
  804092:	89 c7                	mov    %eax,%edi
  804094:	48 b8 ef 22 80 00 00 	movabs $0x8022ef,%rax
  80409b:	00 00 00 
  80409e:	ff d0                	callq  *%rax
  8040a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040a7:	79 05                	jns    8040ae <iscons+0x31>
  8040a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040ac:	eb 1a                	jmp    8040c8 <iscons+0x4b>
  8040ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040b2:	8b 10                	mov    (%rax),%edx
  8040b4:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  8040bb:	00 00 00 
  8040be:	8b 00                	mov    (%rax),%eax
  8040c0:	39 c2                	cmp    %eax,%edx
  8040c2:	0f 94 c0             	sete   %al
  8040c5:	0f b6 c0             	movzbl %al,%eax
  8040c8:	c9                   	leaveq 
  8040c9:	c3                   	retq   

00000000008040ca <opencons>:
  8040ca:	55                   	push   %rbp
  8040cb:	48 89 e5             	mov    %rsp,%rbp
  8040ce:	48 83 ec 10          	sub    $0x10,%rsp
  8040d2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8040d6:	48 89 c7             	mov    %rax,%rdi
  8040d9:	48 b8 57 22 80 00 00 	movabs $0x802257,%rax
  8040e0:	00 00 00 
  8040e3:	ff d0                	callq  *%rax
  8040e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040ec:	79 05                	jns    8040f3 <opencons+0x29>
  8040ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040f1:	eb 5b                	jmp    80414e <opencons+0x84>
  8040f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040f7:	ba 07 04 00 00       	mov    $0x407,%edx
  8040fc:	48 89 c6             	mov    %rax,%rsi
  8040ff:	bf 00 00 00 00       	mov    $0x0,%edi
  804104:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  80410b:	00 00 00 
  80410e:	ff d0                	callq  *%rax
  804110:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804113:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804117:	79 05                	jns    80411e <opencons+0x54>
  804119:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80411c:	eb 30                	jmp    80414e <opencons+0x84>
  80411e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804122:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  804129:	00 00 00 
  80412c:	8b 12                	mov    (%rdx),%edx
  80412e:	89 10                	mov    %edx,(%rax)
  804130:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804134:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80413b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80413f:	48 89 c7             	mov    %rax,%rdi
  804142:	48 b8 09 22 80 00 00 	movabs $0x802209,%rax
  804149:	00 00 00 
  80414c:	ff d0                	callq  *%rax
  80414e:	c9                   	leaveq 
  80414f:	c3                   	retq   

0000000000804150 <devcons_read>:
  804150:	55                   	push   %rbp
  804151:	48 89 e5             	mov    %rsp,%rbp
  804154:	48 83 ec 30          	sub    $0x30,%rsp
  804158:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80415c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804160:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804164:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804169:	75 07                	jne    804172 <devcons_read+0x22>
  80416b:	b8 00 00 00 00       	mov    $0x0,%eax
  804170:	eb 4b                	jmp    8041bd <devcons_read+0x6d>
  804172:	eb 0c                	jmp    804180 <devcons_read+0x30>
  804174:	48 b8 d6 17 80 00 00 	movabs $0x8017d6,%rax
  80417b:	00 00 00 
  80417e:	ff d0                	callq  *%rax
  804180:	48 b8 16 17 80 00 00 	movabs $0x801716,%rax
  804187:	00 00 00 
  80418a:	ff d0                	callq  *%rax
  80418c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80418f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804193:	74 df                	je     804174 <devcons_read+0x24>
  804195:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804199:	79 05                	jns    8041a0 <devcons_read+0x50>
  80419b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80419e:	eb 1d                	jmp    8041bd <devcons_read+0x6d>
  8041a0:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  8041a4:	75 07                	jne    8041ad <devcons_read+0x5d>
  8041a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8041ab:	eb 10                	jmp    8041bd <devcons_read+0x6d>
  8041ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041b0:	89 c2                	mov    %eax,%edx
  8041b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8041b6:	88 10                	mov    %dl,(%rax)
  8041b8:	b8 01 00 00 00       	mov    $0x1,%eax
  8041bd:	c9                   	leaveq 
  8041be:	c3                   	retq   

00000000008041bf <devcons_write>:
  8041bf:	55                   	push   %rbp
  8041c0:	48 89 e5             	mov    %rsp,%rbp
  8041c3:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  8041ca:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8041d1:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8041d8:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8041df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8041e6:	eb 76                	jmp    80425e <devcons_write+0x9f>
  8041e8:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8041ef:	89 c2                	mov    %eax,%edx
  8041f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041f4:	29 c2                	sub    %eax,%edx
  8041f6:	89 d0                	mov    %edx,%eax
  8041f8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8041fb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8041fe:	83 f8 7f             	cmp    $0x7f,%eax
  804201:	76 07                	jbe    80420a <devcons_write+0x4b>
  804203:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  80420a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80420d:	48 63 d0             	movslq %eax,%rdx
  804210:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804213:	48 63 c8             	movslq %eax,%rcx
  804216:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  80421d:	48 01 c1             	add    %rax,%rcx
  804220:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804227:	48 89 ce             	mov    %rcx,%rsi
  80422a:	48 89 c7             	mov    %rax,%rdi
  80422d:	48 b8 09 12 80 00 00 	movabs $0x801209,%rax
  804234:	00 00 00 
  804237:	ff d0                	callq  *%rax
  804239:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80423c:	48 63 d0             	movslq %eax,%rdx
  80423f:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804246:	48 89 d6             	mov    %rdx,%rsi
  804249:	48 89 c7             	mov    %rax,%rdi
  80424c:	48 b8 cc 16 80 00 00 	movabs $0x8016cc,%rax
  804253:	00 00 00 
  804256:	ff d0                	callq  *%rax
  804258:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80425b:	01 45 fc             	add    %eax,-0x4(%rbp)
  80425e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804261:	48 98                	cltq   
  804263:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  80426a:	0f 82 78 ff ff ff    	jb     8041e8 <devcons_write+0x29>
  804270:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804273:	c9                   	leaveq 
  804274:	c3                   	retq   

0000000000804275 <devcons_close>:
  804275:	55                   	push   %rbp
  804276:	48 89 e5             	mov    %rsp,%rbp
  804279:	48 83 ec 08          	sub    $0x8,%rsp
  80427d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804281:	b8 00 00 00 00       	mov    $0x0,%eax
  804286:	c9                   	leaveq 
  804287:	c3                   	retq   

0000000000804288 <devcons_stat>:
  804288:	55                   	push   %rbp
  804289:	48 89 e5             	mov    %rsp,%rbp
  80428c:	48 83 ec 10          	sub    $0x10,%rsp
  804290:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804294:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804298:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80429c:	48 be 7a 4f 80 00 00 	movabs $0x804f7a,%rsi
  8042a3:	00 00 00 
  8042a6:	48 89 c7             	mov    %rax,%rdi
  8042a9:	48 b8 e5 0e 80 00 00 	movabs $0x800ee5,%rax
  8042b0:	00 00 00 
  8042b3:	ff d0                	callq  *%rax
  8042b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8042ba:	c9                   	leaveq 
  8042bb:	c3                   	retq   

00000000008042bc <_panic>:
  8042bc:	55                   	push   %rbp
  8042bd:	48 89 e5             	mov    %rsp,%rbp
  8042c0:	53                   	push   %rbx
  8042c1:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8042c8:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8042cf:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8042d5:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8042dc:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8042e3:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8042ea:	84 c0                	test   %al,%al
  8042ec:	74 23                	je     804311 <_panic+0x55>
  8042ee:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8042f5:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8042f9:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8042fd:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  804301:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  804305:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  804309:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80430d:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  804311:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  804318:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80431f:	00 00 00 
  804322:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  804329:	00 00 00 
  80432c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  804330:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  804337:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80433e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  804345:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80434c:	00 00 00 
  80434f:	48 8b 18             	mov    (%rax),%rbx
  804352:	48 b8 98 17 80 00 00 	movabs $0x801798,%rax
  804359:	00 00 00 
  80435c:	ff d0                	callq  *%rax
  80435e:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  804364:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80436b:	41 89 c8             	mov    %ecx,%r8d
  80436e:	48 89 d1             	mov    %rdx,%rcx
  804371:	48 89 da             	mov    %rbx,%rdx
  804374:	89 c6                	mov    %eax,%esi
  804376:	48 bf 88 4f 80 00 00 	movabs $0x804f88,%rdi
  80437d:	00 00 00 
  804380:	b8 00 00 00 00       	mov    $0x0,%eax
  804385:	49 b9 30 03 80 00 00 	movabs $0x800330,%r9
  80438c:	00 00 00 
  80438f:	41 ff d1             	callq  *%r9
  804392:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  804399:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8043a0:	48 89 d6             	mov    %rdx,%rsi
  8043a3:	48 89 c7             	mov    %rax,%rdi
  8043a6:	48 b8 84 02 80 00 00 	movabs $0x800284,%rax
  8043ad:	00 00 00 
  8043b0:	ff d0                	callq  *%rax
  8043b2:	48 bf ab 4f 80 00 00 	movabs $0x804fab,%rdi
  8043b9:	00 00 00 
  8043bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8043c1:	48 ba 30 03 80 00 00 	movabs $0x800330,%rdx
  8043c8:	00 00 00 
  8043cb:	ff d2                	callq  *%rdx
  8043cd:	cc                   	int3   
  8043ce:	eb fd                	jmp    8043cd <_panic+0x111>

00000000008043d0 <set_pgfault_handler>:
  8043d0:	55                   	push   %rbp
  8043d1:	48 89 e5             	mov    %rsp,%rbp
  8043d4:	48 83 ec 20          	sub    $0x20,%rsp
  8043d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8043dc:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8043e3:	00 00 00 
  8043e6:	48 8b 00             	mov    (%rax),%rax
  8043e9:	48 85 c0             	test   %rax,%rax
  8043ec:	75 6f                	jne    80445d <set_pgfault_handler+0x8d>
  8043ee:	ba 07 00 00 00       	mov    $0x7,%edx
  8043f3:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8043f8:	bf 00 00 00 00       	mov    $0x0,%edi
  8043fd:	48 b8 14 18 80 00 00 	movabs $0x801814,%rax
  804404:	00 00 00 
  804407:	ff d0                	callq  *%rax
  804409:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80440c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804410:	79 30                	jns    804442 <set_pgfault_handler+0x72>
  804412:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804415:	89 c1                	mov    %eax,%ecx
  804417:	48 ba b0 4f 80 00 00 	movabs $0x804fb0,%rdx
  80441e:	00 00 00 
  804421:	be 22 00 00 00       	mov    $0x22,%esi
  804426:	48 bf cf 4f 80 00 00 	movabs $0x804fcf,%rdi
  80442d:	00 00 00 
  804430:	b8 00 00 00 00       	mov    $0x0,%eax
  804435:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  80443c:	00 00 00 
  80443f:	41 ff d0             	callq  *%r8
  804442:	48 be 70 44 80 00 00 	movabs $0x804470,%rsi
  804449:	00 00 00 
  80444c:	bf 00 00 00 00       	mov    $0x0,%edi
  804451:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  804458:	00 00 00 
  80445b:	ff d0                	callq  *%rax
  80445d:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804464:	00 00 00 
  804467:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80446b:	48 89 10             	mov    %rdx,(%rax)
  80446e:	c9                   	leaveq 
  80446f:	c3                   	retq   

0000000000804470 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  804470:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  804473:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  80447a:	00 00 00 
call *%rax
  80447d:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  80447f:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  804486:	00 08 
    movq 152(%rsp), %rax
  804488:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  80448f:	00 
    movq 136(%rsp), %rbx
  804490:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804497:	00 
movq %rbx, (%rax)
  804498:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  80449b:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80449f:	4c 8b 3c 24          	mov    (%rsp),%r15
  8044a3:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  8044a8:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  8044ad:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  8044b2:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  8044b7:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  8044bc:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  8044c1:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  8044c6:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  8044cb:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  8044d0:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  8044d5:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  8044da:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  8044df:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  8044e4:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  8044e9:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  8044ed:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  8044f1:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  8044f2:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  8044f7:	c3                   	retq   

00000000008044f8 <ipc_recv>:
  8044f8:	55                   	push   %rbp
  8044f9:	48 89 e5             	mov    %rsp,%rbp
  8044fc:	48 83 ec 30          	sub    $0x30,%rsp
  804500:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804504:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804508:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80450c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804511:	75 0e                	jne    804521 <ipc_recv+0x29>
  804513:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80451a:	00 00 00 
  80451d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804521:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804525:	48 89 c7             	mov    %rax,%rdi
  804528:	48 b8 3d 1a 80 00 00 	movabs $0x801a3d,%rax
  80452f:	00 00 00 
  804532:	ff d0                	callq  *%rax
  804534:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804537:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80453b:	79 27                	jns    804564 <ipc_recv+0x6c>
  80453d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804542:	74 0a                	je     80454e <ipc_recv+0x56>
  804544:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804548:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80454e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804553:	74 0a                	je     80455f <ipc_recv+0x67>
  804555:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804559:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80455f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804562:	eb 53                	jmp    8045b7 <ipc_recv+0xbf>
  804564:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804569:	74 19                	je     804584 <ipc_recv+0x8c>
  80456b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804572:	00 00 00 
  804575:	48 8b 00             	mov    (%rax),%rax
  804578:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80457e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804582:	89 10                	mov    %edx,(%rax)
  804584:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804589:	74 19                	je     8045a4 <ipc_recv+0xac>
  80458b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804592:	00 00 00 
  804595:	48 8b 00             	mov    (%rax),%rax
  804598:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80459e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8045a2:	89 10                	mov    %edx,(%rax)
  8045a4:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8045ab:	00 00 00 
  8045ae:	48 8b 00             	mov    (%rax),%rax
  8045b1:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  8045b7:	c9                   	leaveq 
  8045b8:	c3                   	retq   

00000000008045b9 <ipc_send>:
  8045b9:	55                   	push   %rbp
  8045ba:	48 89 e5             	mov    %rsp,%rbp
  8045bd:	48 83 ec 30          	sub    $0x30,%rsp
  8045c1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8045c4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8045c7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8045cb:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8045ce:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8045d3:	75 10                	jne    8045e5 <ipc_send+0x2c>
  8045d5:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8045dc:	00 00 00 
  8045df:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8045e3:	eb 0e                	jmp    8045f3 <ipc_send+0x3a>
  8045e5:	eb 0c                	jmp    8045f3 <ipc_send+0x3a>
  8045e7:	48 b8 d6 17 80 00 00 	movabs $0x8017d6,%rax
  8045ee:	00 00 00 
  8045f1:	ff d0                	callq  *%rax
  8045f3:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8045f6:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8045f9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8045fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804600:	89 c7                	mov    %eax,%edi
  804602:	48 b8 e8 19 80 00 00 	movabs $0x8019e8,%rax
  804609:	00 00 00 
  80460c:	ff d0                	callq  *%rax
  80460e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804611:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804615:	74 d0                	je     8045e7 <ipc_send+0x2e>
  804617:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80461b:	79 30                	jns    80464d <ipc_send+0x94>
  80461d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804620:	89 c1                	mov    %eax,%ecx
  804622:	48 ba e0 4f 80 00 00 	movabs $0x804fe0,%rdx
  804629:	00 00 00 
  80462c:	be 44 00 00 00       	mov    $0x44,%esi
  804631:	48 bf f6 4f 80 00 00 	movabs $0x804ff6,%rdi
  804638:	00 00 00 
  80463b:	b8 00 00 00 00       	mov    $0x0,%eax
  804640:	49 b8 bc 42 80 00 00 	movabs $0x8042bc,%r8
  804647:	00 00 00 
  80464a:	41 ff d0             	callq  *%r8
  80464d:	c9                   	leaveq 
  80464e:	c3                   	retq   

000000000080464f <ipc_host_recv>:
  80464f:	55                   	push   %rbp
  804650:	48 89 e5             	mov    %rsp,%rbp
  804653:	48 83 ec 10          	sub    $0x10,%rsp
  804657:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80465b:	48 ba 08 50 80 00 00 	movabs $0x805008,%rdx
  804662:	00 00 00 
  804665:	be 4e 00 00 00       	mov    $0x4e,%esi
  80466a:	48 bf f6 4f 80 00 00 	movabs $0x804ff6,%rdi
  804671:	00 00 00 
  804674:	b8 00 00 00 00       	mov    $0x0,%eax
  804679:	48 b9 bc 42 80 00 00 	movabs $0x8042bc,%rcx
  804680:	00 00 00 
  804683:	ff d1                	callq  *%rcx

0000000000804685 <ipc_host_send>:
  804685:	55                   	push   %rbp
  804686:	48 89 e5             	mov    %rsp,%rbp
  804689:	48 83 ec 20          	sub    $0x20,%rsp
  80468d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804690:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804693:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804697:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80469a:	48 ba 28 50 80 00 00 	movabs $0x805028,%rdx
  8046a1:	00 00 00 
  8046a4:	be 67 00 00 00       	mov    $0x67,%esi
  8046a9:	48 bf f6 4f 80 00 00 	movabs $0x804ff6,%rdi
  8046b0:	00 00 00 
  8046b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8046b8:	48 b9 bc 42 80 00 00 	movabs $0x8042bc,%rcx
  8046bf:	00 00 00 
  8046c2:	ff d1                	callq  *%rcx

00000000008046c4 <ipc_find_env>:
  8046c4:	55                   	push   %rbp
  8046c5:	48 89 e5             	mov    %rsp,%rbp
  8046c8:	48 83 ec 14          	sub    $0x14,%rsp
  8046cc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8046cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8046d6:	eb 4e                	jmp    804726 <ipc_find_env+0x62>
  8046d8:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8046df:	00 00 00 
  8046e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046e5:	48 98                	cltq   
  8046e7:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8046ee:	48 01 d0             	add    %rdx,%rax
  8046f1:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8046f7:	8b 00                	mov    (%rax),%eax
  8046f9:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8046fc:	75 24                	jne    804722 <ipc_find_env+0x5e>
  8046fe:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804705:	00 00 00 
  804708:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80470b:	48 98                	cltq   
  80470d:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804714:	48 01 d0             	add    %rdx,%rax
  804717:	48 05 c0 00 00 00    	add    $0xc0,%rax
  80471d:	8b 40 08             	mov    0x8(%rax),%eax
  804720:	eb 12                	jmp    804734 <ipc_find_env+0x70>
  804722:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804726:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  80472d:	7e a9                	jle    8046d8 <ipc_find_env+0x14>
  80472f:	b8 00 00 00 00       	mov    $0x0,%eax
  804734:	c9                   	leaveq 
  804735:	c3                   	retq   

0000000000804736 <pageref>:
  804736:	55                   	push   %rbp
  804737:	48 89 e5             	mov    %rsp,%rbp
  80473a:	48 83 ec 18          	sub    $0x18,%rsp
  80473e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804742:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804746:	48 c1 e8 15          	shr    $0x15,%rax
  80474a:	48 89 c2             	mov    %rax,%rdx
  80474d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804754:	01 00 00 
  804757:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80475b:	83 e0 01             	and    $0x1,%eax
  80475e:	48 85 c0             	test   %rax,%rax
  804761:	75 07                	jne    80476a <pageref+0x34>
  804763:	b8 00 00 00 00       	mov    $0x0,%eax
  804768:	eb 53                	jmp    8047bd <pageref+0x87>
  80476a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80476e:	48 c1 e8 0c          	shr    $0xc,%rax
  804772:	48 89 c2             	mov    %rax,%rdx
  804775:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80477c:	01 00 00 
  80477f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804783:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804787:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80478b:	83 e0 01             	and    $0x1,%eax
  80478e:	48 85 c0             	test   %rax,%rax
  804791:	75 07                	jne    80479a <pageref+0x64>
  804793:	b8 00 00 00 00       	mov    $0x0,%eax
  804798:	eb 23                	jmp    8047bd <pageref+0x87>
  80479a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80479e:	48 c1 e8 0c          	shr    $0xc,%rax
  8047a2:	48 89 c2             	mov    %rax,%rdx
  8047a5:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  8047ac:	00 00 00 
  8047af:	48 c1 e2 04          	shl    $0x4,%rdx
  8047b3:	48 01 d0             	add    %rdx,%rax
  8047b6:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  8047ba:	0f b7 c0             	movzwl %ax,%eax
  8047bd:	c9                   	leaveq 
  8047be:	c3                   	retq   
