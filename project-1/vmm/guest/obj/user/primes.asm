
vmm/guest/obj/user/primes:     file format elf64-x86-64


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
  80003c:	e8 8d 01 00 00       	callq  8001ce <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <primeproc>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 10          	sub    $0x10,%rsp
  80004b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80004f:	ba 00 00 00 00       	mov    $0x0,%edx
  800054:	be 00 00 00 00       	mov    $0x0,%esi
  800059:	48 89 c7             	mov    %rax,%rdi
  80005c:	48 b8 86 23 80 00 00 	movabs $0x802386,%rax
  800063:	00 00 00 
  800066:	ff d0                	callq  *%rax
  800068:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80006b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800072:	00 00 00 
  800075:	48 8b 00             	mov    (%rax),%rax
  800078:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
  80007e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800081:	89 c6                	mov    %eax,%esi
  800083:	48 bf 40 48 80 00 00 	movabs $0x804840,%rdi
  80008a:	00 00 00 
  80008d:	b8 00 00 00 00       	mov    $0x0,%eax
  800092:	48 b9 ad 04 80 00 00 	movabs $0x8004ad,%rcx
  800099:	00 00 00 
  80009c:	ff d1                	callq  *%rcx
  80009e:	48 b8 11 21 80 00 00 	movabs $0x802111,%rax
  8000a5:	00 00 00 
  8000a8:	ff d0                	callq  *%rax
  8000aa:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000ad:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000b1:	79 30                	jns    8000e3 <primeproc+0xa0>
  8000b3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000b6:	89 c1                	mov    %eax,%ecx
  8000b8:	48 ba 4c 48 80 00 00 	movabs $0x80484c,%rdx
  8000bf:	00 00 00 
  8000c2:	be 1b 00 00 00       	mov    $0x1b,%esi
  8000c7:	48 bf 55 48 80 00 00 	movabs $0x804855,%rdi
  8000ce:	00 00 00 
  8000d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8000d6:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8000dd:	00 00 00 
  8000e0:	41 ff d0             	callq  *%r8
  8000e3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000e7:	75 05                	jne    8000ee <primeproc+0xab>
  8000e9:	e9 5d ff ff ff       	jmpq   80004b <primeproc+0x8>
  8000ee:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8000f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8000f7:	be 00 00 00 00       	mov    $0x0,%esi
  8000fc:	48 89 c7             	mov    %rax,%rdi
  8000ff:	48 b8 86 23 80 00 00 	movabs $0x802386,%rax
  800106:	00 00 00 
  800109:	ff d0                	callq  *%rax
  80010b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80010e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800111:	99                   	cltd   
  800112:	f7 7d fc             	idivl  -0x4(%rbp)
  800115:	89 d0                	mov    %edx,%eax
  800117:	85 c0                	test   %eax,%eax
  800119:	74 20                	je     80013b <primeproc+0xf8>
  80011b:	8b 75 f4             	mov    -0xc(%rbp),%esi
  80011e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800121:	b9 00 00 00 00       	mov    $0x0,%ecx
  800126:	ba 00 00 00 00       	mov    $0x0,%edx
  80012b:	89 c7                	mov    %eax,%edi
  80012d:	48 b8 47 24 80 00 00 	movabs $0x802447,%rax
  800134:	00 00 00 
  800137:	ff d0                	callq  *%rax
  800139:	eb b3                	jmp    8000ee <primeproc+0xab>
  80013b:	eb b1                	jmp    8000ee <primeproc+0xab>

000000000080013d <umain>:
  80013d:	55                   	push   %rbp
  80013e:	48 89 e5             	mov    %rsp,%rbp
  800141:	48 83 ec 20          	sub    $0x20,%rsp
  800145:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800148:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80014c:	48 b8 11 21 80 00 00 	movabs $0x802111,%rax
  800153:	00 00 00 
  800156:	ff d0                	callq  *%rax
  800158:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80015b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80015f:	79 30                	jns    800191 <umain+0x54>
  800161:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800164:	89 c1                	mov    %eax,%ecx
  800166:	48 ba 4c 48 80 00 00 	movabs $0x80484c,%rdx
  80016d:	00 00 00 
  800170:	be 2e 00 00 00       	mov    $0x2e,%esi
  800175:	48 bf 55 48 80 00 00 	movabs $0x804855,%rdi
  80017c:	00 00 00 
  80017f:	b8 00 00 00 00       	mov    $0x0,%eax
  800184:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80018b:	00 00 00 
  80018e:	41 ff d0             	callq  *%r8
  800191:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800195:	75 0c                	jne    8001a3 <umain+0x66>
  800197:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  80019e:	00 00 00 
  8001a1:	ff d0                	callq  *%rax
  8001a3:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
  8001aa:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8001ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  8001b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8001ba:	89 c7                	mov    %eax,%edi
  8001bc:	48 b8 47 24 80 00 00 	movabs $0x802447,%rax
  8001c3:	00 00 00 
  8001c6:	ff d0                	callq  *%rax
  8001c8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8001cc:	eb dc                	jmp    8001aa <umain+0x6d>

00000000008001ce <libmain>:
  8001ce:	55                   	push   %rbp
  8001cf:	48 89 e5             	mov    %rsp,%rbp
  8001d2:	48 83 ec 10          	sub    $0x10,%rsp
  8001d6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8001d9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8001dd:	48 b8 15 19 80 00 00 	movabs $0x801915,%rax
  8001e4:	00 00 00 
  8001e7:	ff d0                	callq  *%rax
  8001e9:	25 ff 03 00 00       	and    $0x3ff,%eax
  8001ee:	48 98                	cltq   
  8001f0:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8001f7:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8001fe:	00 00 00 
  800201:	48 01 c2             	add    %rax,%rdx
  800204:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80020b:	00 00 00 
  80020e:	48 89 10             	mov    %rdx,(%rax)
  800211:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800215:	7e 14                	jle    80022b <libmain+0x5d>
  800217:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80021b:	48 8b 10             	mov    (%rax),%rdx
  80021e:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800225:	00 00 00 
  800228:	48 89 10             	mov    %rdx,(%rax)
  80022b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80022f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800232:	48 89 d6             	mov    %rdx,%rsi
  800235:	89 c7                	mov    %eax,%edi
  800237:	48 b8 3d 01 80 00 00 	movabs $0x80013d,%rax
  80023e:	00 00 00 
  800241:	ff d0                	callq  *%rax
  800243:	48 b8 51 02 80 00 00 	movabs $0x800251,%rax
  80024a:	00 00 00 
  80024d:	ff d0                	callq  *%rax
  80024f:	c9                   	leaveq 
  800250:	c3                   	retq   

0000000000800251 <exit>:
  800251:	55                   	push   %rbp
  800252:	48 89 e5             	mov    %rsp,%rbp
  800255:	48 b8 05 29 80 00 00 	movabs $0x802905,%rax
  80025c:	00 00 00 
  80025f:	ff d0                	callq  *%rax
  800261:	bf 00 00 00 00       	mov    $0x0,%edi
  800266:	48 b8 d1 18 80 00 00 	movabs $0x8018d1,%rax
  80026d:	00 00 00 
  800270:	ff d0                	callq  *%rax
  800272:	5d                   	pop    %rbp
  800273:	c3                   	retq   

0000000000800274 <_panic>:
  800274:	55                   	push   %rbp
  800275:	48 89 e5             	mov    %rsp,%rbp
  800278:	53                   	push   %rbx
  800279:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800280:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800287:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  80028d:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800294:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  80029b:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8002a2:	84 c0                	test   %al,%al
  8002a4:	74 23                	je     8002c9 <_panic+0x55>
  8002a6:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8002ad:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8002b1:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8002b5:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  8002b9:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  8002bd:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  8002c1:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  8002c5:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  8002c9:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8002d0:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  8002d7:	00 00 00 
  8002da:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  8002e1:	00 00 00 
  8002e4:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8002e8:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  8002ef:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8002f6:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8002fd:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800304:	00 00 00 
  800307:	48 8b 18             	mov    (%rax),%rbx
  80030a:	48 b8 15 19 80 00 00 	movabs $0x801915,%rax
  800311:	00 00 00 
  800314:	ff d0                	callq  *%rax
  800316:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  80031c:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800323:	41 89 c8             	mov    %ecx,%r8d
  800326:	48 89 d1             	mov    %rdx,%rcx
  800329:	48 89 da             	mov    %rbx,%rdx
  80032c:	89 c6                	mov    %eax,%esi
  80032e:	48 bf 70 48 80 00 00 	movabs $0x804870,%rdi
  800335:	00 00 00 
  800338:	b8 00 00 00 00       	mov    $0x0,%eax
  80033d:	49 b9 ad 04 80 00 00 	movabs $0x8004ad,%r9
  800344:	00 00 00 
  800347:	41 ff d1             	callq  *%r9
  80034a:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  800351:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800358:	48 89 d6             	mov    %rdx,%rsi
  80035b:	48 89 c7             	mov    %rax,%rdi
  80035e:	48 b8 01 04 80 00 00 	movabs $0x800401,%rax
  800365:	00 00 00 
  800368:	ff d0                	callq  *%rax
  80036a:	48 bf 93 48 80 00 00 	movabs $0x804893,%rdi
  800371:	00 00 00 
  800374:	b8 00 00 00 00       	mov    $0x0,%eax
  800379:	48 ba ad 04 80 00 00 	movabs $0x8004ad,%rdx
  800380:	00 00 00 
  800383:	ff d2                	callq  *%rdx
  800385:	cc                   	int3   
  800386:	eb fd                	jmp    800385 <_panic+0x111>

0000000000800388 <putch>:
  800388:	55                   	push   %rbp
  800389:	48 89 e5             	mov    %rsp,%rbp
  80038c:	48 83 ec 10          	sub    $0x10,%rsp
  800390:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800393:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800397:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80039b:	8b 00                	mov    (%rax),%eax
  80039d:	8d 48 01             	lea    0x1(%rax),%ecx
  8003a0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003a4:	89 0a                	mov    %ecx,(%rdx)
  8003a6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8003a9:	89 d1                	mov    %edx,%ecx
  8003ab:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003af:	48 98                	cltq   
  8003b1:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8003b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003b9:	8b 00                	mov    (%rax),%eax
  8003bb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003c0:	75 2c                	jne    8003ee <putch+0x66>
  8003c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003c6:	8b 00                	mov    (%rax),%eax
  8003c8:	48 98                	cltq   
  8003ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003ce:	48 83 c2 08          	add    $0x8,%rdx
  8003d2:	48 89 c6             	mov    %rax,%rsi
  8003d5:	48 89 d7             	mov    %rdx,%rdi
  8003d8:	48 b8 49 18 80 00 00 	movabs $0x801849,%rax
  8003df:	00 00 00 
  8003e2:	ff d0                	callq  *%rax
  8003e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003e8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8003ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003f2:	8b 40 04             	mov    0x4(%rax),%eax
  8003f5:	8d 50 01             	lea    0x1(%rax),%edx
  8003f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003fc:	89 50 04             	mov    %edx,0x4(%rax)
  8003ff:	c9                   	leaveq 
  800400:	c3                   	retq   

0000000000800401 <vcprintf>:
  800401:	55                   	push   %rbp
  800402:	48 89 e5             	mov    %rsp,%rbp
  800405:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80040c:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800413:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80041a:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800421:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800428:	48 8b 0a             	mov    (%rdx),%rcx
  80042b:	48 89 08             	mov    %rcx,(%rax)
  80042e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800432:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800436:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80043a:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80043e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800445:	00 00 00 
  800448:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80044f:	00 00 00 
  800452:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800459:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800460:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800467:	48 89 c6             	mov    %rax,%rsi
  80046a:	48 bf 88 03 80 00 00 	movabs $0x800388,%rdi
  800471:	00 00 00 
  800474:	48 b8 60 08 80 00 00 	movabs $0x800860,%rax
  80047b:	00 00 00 
  80047e:	ff d0                	callq  *%rax
  800480:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800486:	48 98                	cltq   
  800488:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80048f:	48 83 c2 08          	add    $0x8,%rdx
  800493:	48 89 c6             	mov    %rax,%rsi
  800496:	48 89 d7             	mov    %rdx,%rdi
  800499:	48 b8 49 18 80 00 00 	movabs $0x801849,%rax
  8004a0:	00 00 00 
  8004a3:	ff d0                	callq  *%rax
  8004a5:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8004ab:	c9                   	leaveq 
  8004ac:	c3                   	retq   

00000000008004ad <cprintf>:
  8004ad:	55                   	push   %rbp
  8004ae:	48 89 e5             	mov    %rsp,%rbp
  8004b1:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8004b8:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8004bf:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8004c6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8004cd:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8004d4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8004db:	84 c0                	test   %al,%al
  8004dd:	74 20                	je     8004ff <cprintf+0x52>
  8004df:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8004e3:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8004e7:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8004eb:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8004ef:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8004f3:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8004f7:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8004fb:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8004ff:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800506:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80050d:	00 00 00 
  800510:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800517:	00 00 00 
  80051a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80051e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800525:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80052c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800533:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80053a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800541:	48 8b 0a             	mov    (%rdx),%rcx
  800544:	48 89 08             	mov    %rcx,(%rax)
  800547:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80054b:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80054f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800553:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800557:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80055e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800565:	48 89 d6             	mov    %rdx,%rsi
  800568:	48 89 c7             	mov    %rax,%rdi
  80056b:	48 b8 01 04 80 00 00 	movabs $0x800401,%rax
  800572:	00 00 00 
  800575:	ff d0                	callq  *%rax
  800577:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80057d:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800583:	c9                   	leaveq 
  800584:	c3                   	retq   

0000000000800585 <printnum>:
  800585:	55                   	push   %rbp
  800586:	48 89 e5             	mov    %rsp,%rbp
  800589:	53                   	push   %rbx
  80058a:	48 83 ec 38          	sub    $0x38,%rsp
  80058e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800592:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800596:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80059a:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80059d:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8005a1:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8005a5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8005a8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8005ac:	77 3b                	ja     8005e9 <printnum+0x64>
  8005ae:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8005b1:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8005b5:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8005b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c1:	48 f7 f3             	div    %rbx
  8005c4:	48 89 c2             	mov    %rax,%rdx
  8005c7:	8b 7d cc             	mov    -0x34(%rbp),%edi
  8005ca:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8005cd:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  8005d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005d5:	41 89 f9             	mov    %edi,%r9d
  8005d8:	48 89 c7             	mov    %rax,%rdi
  8005db:	48 b8 85 05 80 00 00 	movabs $0x800585,%rax
  8005e2:	00 00 00 
  8005e5:	ff d0                	callq  *%rax
  8005e7:	eb 1e                	jmp    800607 <printnum+0x82>
  8005e9:	eb 12                	jmp    8005fd <printnum+0x78>
  8005eb:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8005ef:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8005f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005f6:	48 89 ce             	mov    %rcx,%rsi
  8005f9:	89 d7                	mov    %edx,%edi
  8005fb:	ff d0                	callq  *%rax
  8005fd:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800601:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800605:	7f e4                	jg     8005eb <printnum+0x66>
  800607:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80060a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80060e:	ba 00 00 00 00       	mov    $0x0,%edx
  800613:	48 f7 f1             	div    %rcx
  800616:	48 89 d0             	mov    %rdx,%rax
  800619:	48 ba 90 4a 80 00 00 	movabs $0x804a90,%rdx
  800620:	00 00 00 
  800623:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800627:	0f be d0             	movsbl %al,%edx
  80062a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80062e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800632:	48 89 ce             	mov    %rcx,%rsi
  800635:	89 d7                	mov    %edx,%edi
  800637:	ff d0                	callq  *%rax
  800639:	48 83 c4 38          	add    $0x38,%rsp
  80063d:	5b                   	pop    %rbx
  80063e:	5d                   	pop    %rbp
  80063f:	c3                   	retq   

0000000000800640 <getuint>:
  800640:	55                   	push   %rbp
  800641:	48 89 e5             	mov    %rsp,%rbp
  800644:	48 83 ec 1c          	sub    $0x1c,%rsp
  800648:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80064c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80064f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800653:	7e 52                	jle    8006a7 <getuint+0x67>
  800655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800659:	8b 00                	mov    (%rax),%eax
  80065b:	83 f8 30             	cmp    $0x30,%eax
  80065e:	73 24                	jae    800684 <getuint+0x44>
  800660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800664:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800668:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80066c:	8b 00                	mov    (%rax),%eax
  80066e:	89 c0                	mov    %eax,%eax
  800670:	48 01 d0             	add    %rdx,%rax
  800673:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800677:	8b 12                	mov    (%rdx),%edx
  800679:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80067c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800680:	89 0a                	mov    %ecx,(%rdx)
  800682:	eb 17                	jmp    80069b <getuint+0x5b>
  800684:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800688:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80068c:	48 89 d0             	mov    %rdx,%rax
  80068f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800693:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800697:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80069b:	48 8b 00             	mov    (%rax),%rax
  80069e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006a2:	e9 a3 00 00 00       	jmpq   80074a <getuint+0x10a>
  8006a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8006ab:	74 4f                	je     8006fc <getuint+0xbc>
  8006ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006b1:	8b 00                	mov    (%rax),%eax
  8006b3:	83 f8 30             	cmp    $0x30,%eax
  8006b6:	73 24                	jae    8006dc <getuint+0x9c>
  8006b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006bc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006c4:	8b 00                	mov    (%rax),%eax
  8006c6:	89 c0                	mov    %eax,%eax
  8006c8:	48 01 d0             	add    %rdx,%rax
  8006cb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006cf:	8b 12                	mov    (%rdx),%edx
  8006d1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006d4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006d8:	89 0a                	mov    %ecx,(%rdx)
  8006da:	eb 17                	jmp    8006f3 <getuint+0xb3>
  8006dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006e0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006e4:	48 89 d0             	mov    %rdx,%rax
  8006e7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006eb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006ef:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006f3:	48 8b 00             	mov    (%rax),%rax
  8006f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006fa:	eb 4e                	jmp    80074a <getuint+0x10a>
  8006fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800700:	8b 00                	mov    (%rax),%eax
  800702:	83 f8 30             	cmp    $0x30,%eax
  800705:	73 24                	jae    80072b <getuint+0xeb>
  800707:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80070b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80070f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800713:	8b 00                	mov    (%rax),%eax
  800715:	89 c0                	mov    %eax,%eax
  800717:	48 01 d0             	add    %rdx,%rax
  80071a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80071e:	8b 12                	mov    (%rdx),%edx
  800720:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800723:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800727:	89 0a                	mov    %ecx,(%rdx)
  800729:	eb 17                	jmp    800742 <getuint+0x102>
  80072b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80072f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800733:	48 89 d0             	mov    %rdx,%rax
  800736:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80073a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80073e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800742:	8b 00                	mov    (%rax),%eax
  800744:	89 c0                	mov    %eax,%eax
  800746:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80074a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80074e:	c9                   	leaveq 
  80074f:	c3                   	retq   

0000000000800750 <getint>:
  800750:	55                   	push   %rbp
  800751:	48 89 e5             	mov    %rsp,%rbp
  800754:	48 83 ec 1c          	sub    $0x1c,%rsp
  800758:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80075c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80075f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800763:	7e 52                	jle    8007b7 <getint+0x67>
  800765:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800769:	8b 00                	mov    (%rax),%eax
  80076b:	83 f8 30             	cmp    $0x30,%eax
  80076e:	73 24                	jae    800794 <getint+0x44>
  800770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800774:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800778:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80077c:	8b 00                	mov    (%rax),%eax
  80077e:	89 c0                	mov    %eax,%eax
  800780:	48 01 d0             	add    %rdx,%rax
  800783:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800787:	8b 12                	mov    (%rdx),%edx
  800789:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80078c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800790:	89 0a                	mov    %ecx,(%rdx)
  800792:	eb 17                	jmp    8007ab <getint+0x5b>
  800794:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800798:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80079c:	48 89 d0             	mov    %rdx,%rax
  80079f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8007a3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8007ab:	48 8b 00             	mov    (%rax),%rax
  8007ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8007b2:	e9 a3 00 00 00       	jmpq   80085a <getint+0x10a>
  8007b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8007bb:	74 4f                	je     80080c <getint+0xbc>
  8007bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007c1:	8b 00                	mov    (%rax),%eax
  8007c3:	83 f8 30             	cmp    $0x30,%eax
  8007c6:	73 24                	jae    8007ec <getint+0x9c>
  8007c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007cc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8007d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007d4:	8b 00                	mov    (%rax),%eax
  8007d6:	89 c0                	mov    %eax,%eax
  8007d8:	48 01 d0             	add    %rdx,%rax
  8007db:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007df:	8b 12                	mov    (%rdx),%edx
  8007e1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8007e4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007e8:	89 0a                	mov    %ecx,(%rdx)
  8007ea:	eb 17                	jmp    800803 <getint+0xb3>
  8007ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007f0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8007f4:	48 89 d0             	mov    %rdx,%rax
  8007f7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8007fb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800803:	48 8b 00             	mov    (%rax),%rax
  800806:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80080a:	eb 4e                	jmp    80085a <getint+0x10a>
  80080c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800810:	8b 00                	mov    (%rax),%eax
  800812:	83 f8 30             	cmp    $0x30,%eax
  800815:	73 24                	jae    80083b <getint+0xeb>
  800817:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80081b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80081f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800823:	8b 00                	mov    (%rax),%eax
  800825:	89 c0                	mov    %eax,%eax
  800827:	48 01 d0             	add    %rdx,%rax
  80082a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80082e:	8b 12                	mov    (%rdx),%edx
  800830:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800833:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800837:	89 0a                	mov    %ecx,(%rdx)
  800839:	eb 17                	jmp    800852 <getint+0x102>
  80083b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80083f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800843:	48 89 d0             	mov    %rdx,%rax
  800846:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80084a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80084e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800852:	8b 00                	mov    (%rax),%eax
  800854:	48 98                	cltq   
  800856:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80085a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80085e:	c9                   	leaveq 
  80085f:	c3                   	retq   

0000000000800860 <vprintfmt>:
  800860:	55                   	push   %rbp
  800861:	48 89 e5             	mov    %rsp,%rbp
  800864:	41 54                	push   %r12
  800866:	53                   	push   %rbx
  800867:	48 83 ec 60          	sub    $0x60,%rsp
  80086b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  80086f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800873:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800877:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  80087b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80087f:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800883:	48 8b 0a             	mov    (%rdx),%rcx
  800886:	48 89 08             	mov    %rcx,(%rax)
  800889:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80088d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800891:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800895:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800899:	eb 17                	jmp    8008b2 <vprintfmt+0x52>
  80089b:	85 db                	test   %ebx,%ebx
  80089d:	0f 84 cc 04 00 00    	je     800d6f <vprintfmt+0x50f>
  8008a3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8008a7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8008ab:	48 89 d6             	mov    %rdx,%rsi
  8008ae:	89 df                	mov    %ebx,%edi
  8008b0:	ff d0                	callq  *%rax
  8008b2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8008b6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8008ba:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8008be:	0f b6 00             	movzbl (%rax),%eax
  8008c1:	0f b6 d8             	movzbl %al,%ebx
  8008c4:	83 fb 25             	cmp    $0x25,%ebx
  8008c7:	75 d2                	jne    80089b <vprintfmt+0x3b>
  8008c9:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  8008cd:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  8008d4:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8008db:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8008e2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  8008e9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8008ed:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8008f1:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8008f5:	0f b6 00             	movzbl (%rax),%eax
  8008f8:	0f b6 d8             	movzbl %al,%ebx
  8008fb:	8d 43 dd             	lea    -0x23(%rbx),%eax
  8008fe:	83 f8 55             	cmp    $0x55,%eax
  800901:	0f 87 34 04 00 00    	ja     800d3b <vprintfmt+0x4db>
  800907:	89 c0                	mov    %eax,%eax
  800909:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800910:	00 
  800911:	48 b8 b8 4a 80 00 00 	movabs $0x804ab8,%rax
  800918:	00 00 00 
  80091b:	48 01 d0             	add    %rdx,%rax
  80091e:	48 8b 00             	mov    (%rax),%rax
  800921:	ff e0                	jmpq   *%rax
  800923:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800927:	eb c0                	jmp    8008e9 <vprintfmt+0x89>
  800929:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  80092d:	eb ba                	jmp    8008e9 <vprintfmt+0x89>
  80092f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800936:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800939:	89 d0                	mov    %edx,%eax
  80093b:	c1 e0 02             	shl    $0x2,%eax
  80093e:	01 d0                	add    %edx,%eax
  800940:	01 c0                	add    %eax,%eax
  800942:	01 d8                	add    %ebx,%eax
  800944:	83 e8 30             	sub    $0x30,%eax
  800947:	89 45 d8             	mov    %eax,-0x28(%rbp)
  80094a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80094e:	0f b6 00             	movzbl (%rax),%eax
  800951:	0f be d8             	movsbl %al,%ebx
  800954:	83 fb 2f             	cmp    $0x2f,%ebx
  800957:	7e 0c                	jle    800965 <vprintfmt+0x105>
  800959:	83 fb 39             	cmp    $0x39,%ebx
  80095c:	7f 07                	jg     800965 <vprintfmt+0x105>
  80095e:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800963:	eb d1                	jmp    800936 <vprintfmt+0xd6>
  800965:	eb 58                	jmp    8009bf <vprintfmt+0x15f>
  800967:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80096a:	83 f8 30             	cmp    $0x30,%eax
  80096d:	73 17                	jae    800986 <vprintfmt+0x126>
  80096f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800973:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800976:	89 c0                	mov    %eax,%eax
  800978:	48 01 d0             	add    %rdx,%rax
  80097b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80097e:	83 c2 08             	add    $0x8,%edx
  800981:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800984:	eb 0f                	jmp    800995 <vprintfmt+0x135>
  800986:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80098a:	48 89 d0             	mov    %rdx,%rax
  80098d:	48 83 c2 08          	add    $0x8,%rdx
  800991:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800995:	8b 00                	mov    (%rax),%eax
  800997:	89 45 d8             	mov    %eax,-0x28(%rbp)
  80099a:	eb 23                	jmp    8009bf <vprintfmt+0x15f>
  80099c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009a0:	79 0c                	jns    8009ae <vprintfmt+0x14e>
  8009a2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  8009a9:	e9 3b ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009ae:	e9 36 ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009b3:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  8009ba:	e9 2a ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009bf:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009c3:	79 12                	jns    8009d7 <vprintfmt+0x177>
  8009c5:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8009c8:	89 45 dc             	mov    %eax,-0x24(%rbp)
  8009cb:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8009d2:	e9 12 ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009d7:	e9 0d ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009dc:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  8009e0:	e9 04 ff ff ff       	jmpq   8008e9 <vprintfmt+0x89>
  8009e5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009e8:	83 f8 30             	cmp    $0x30,%eax
  8009eb:	73 17                	jae    800a04 <vprintfmt+0x1a4>
  8009ed:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8009f1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009f4:	89 c0                	mov    %eax,%eax
  8009f6:	48 01 d0             	add    %rdx,%rax
  8009f9:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8009fc:	83 c2 08             	add    $0x8,%edx
  8009ff:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a02:	eb 0f                	jmp    800a13 <vprintfmt+0x1b3>
  800a04:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a08:	48 89 d0             	mov    %rdx,%rax
  800a0b:	48 83 c2 08          	add    $0x8,%rdx
  800a0f:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a13:	8b 10                	mov    (%rax),%edx
  800a15:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800a19:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a1d:	48 89 ce             	mov    %rcx,%rsi
  800a20:	89 d7                	mov    %edx,%edi
  800a22:	ff d0                	callq  *%rax
  800a24:	e9 40 03 00 00       	jmpq   800d69 <vprintfmt+0x509>
  800a29:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a2c:	83 f8 30             	cmp    $0x30,%eax
  800a2f:	73 17                	jae    800a48 <vprintfmt+0x1e8>
  800a31:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a35:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a38:	89 c0                	mov    %eax,%eax
  800a3a:	48 01 d0             	add    %rdx,%rax
  800a3d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a40:	83 c2 08             	add    $0x8,%edx
  800a43:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a46:	eb 0f                	jmp    800a57 <vprintfmt+0x1f7>
  800a48:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a4c:	48 89 d0             	mov    %rdx,%rax
  800a4f:	48 83 c2 08          	add    $0x8,%rdx
  800a53:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a57:	8b 18                	mov    (%rax),%ebx
  800a59:	85 db                	test   %ebx,%ebx
  800a5b:	79 02                	jns    800a5f <vprintfmt+0x1ff>
  800a5d:	f7 db                	neg    %ebx
  800a5f:	83 fb 15             	cmp    $0x15,%ebx
  800a62:	7f 16                	jg     800a7a <vprintfmt+0x21a>
  800a64:	48 b8 e0 49 80 00 00 	movabs $0x8049e0,%rax
  800a6b:	00 00 00 
  800a6e:	48 63 d3             	movslq %ebx,%rdx
  800a71:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800a75:	4d 85 e4             	test   %r12,%r12
  800a78:	75 2e                	jne    800aa8 <vprintfmt+0x248>
  800a7a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800a7e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a82:	89 d9                	mov    %ebx,%ecx
  800a84:	48 ba a1 4a 80 00 00 	movabs $0x804aa1,%rdx
  800a8b:	00 00 00 
  800a8e:	48 89 c7             	mov    %rax,%rdi
  800a91:	b8 00 00 00 00       	mov    $0x0,%eax
  800a96:	49 b8 78 0d 80 00 00 	movabs $0x800d78,%r8
  800a9d:	00 00 00 
  800aa0:	41 ff d0             	callq  *%r8
  800aa3:	e9 c1 02 00 00       	jmpq   800d69 <vprintfmt+0x509>
  800aa8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800aac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ab0:	4c 89 e1             	mov    %r12,%rcx
  800ab3:	48 ba aa 4a 80 00 00 	movabs $0x804aaa,%rdx
  800aba:	00 00 00 
  800abd:	48 89 c7             	mov    %rax,%rdi
  800ac0:	b8 00 00 00 00       	mov    $0x0,%eax
  800ac5:	49 b8 78 0d 80 00 00 	movabs $0x800d78,%r8
  800acc:	00 00 00 
  800acf:	41 ff d0             	callq  *%r8
  800ad2:	e9 92 02 00 00       	jmpq   800d69 <vprintfmt+0x509>
  800ad7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ada:	83 f8 30             	cmp    $0x30,%eax
  800add:	73 17                	jae    800af6 <vprintfmt+0x296>
  800adf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ae3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ae6:	89 c0                	mov    %eax,%eax
  800ae8:	48 01 d0             	add    %rdx,%rax
  800aeb:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800aee:	83 c2 08             	add    $0x8,%edx
  800af1:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800af4:	eb 0f                	jmp    800b05 <vprintfmt+0x2a5>
  800af6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800afa:	48 89 d0             	mov    %rdx,%rax
  800afd:	48 83 c2 08          	add    $0x8,%rdx
  800b01:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b05:	4c 8b 20             	mov    (%rax),%r12
  800b08:	4d 85 e4             	test   %r12,%r12
  800b0b:	75 0a                	jne    800b17 <vprintfmt+0x2b7>
  800b0d:	49 bc ad 4a 80 00 00 	movabs $0x804aad,%r12
  800b14:	00 00 00 
  800b17:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b1b:	7e 3f                	jle    800b5c <vprintfmt+0x2fc>
  800b1d:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800b21:	74 39                	je     800b5c <vprintfmt+0x2fc>
  800b23:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b26:	48 98                	cltq   
  800b28:	48 89 c6             	mov    %rax,%rsi
  800b2b:	4c 89 e7             	mov    %r12,%rdi
  800b2e:	48 b8 24 10 80 00 00 	movabs $0x801024,%rax
  800b35:	00 00 00 
  800b38:	ff d0                	callq  *%rax
  800b3a:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800b3d:	eb 17                	jmp    800b56 <vprintfmt+0x2f6>
  800b3f:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800b43:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800b47:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b4b:	48 89 ce             	mov    %rcx,%rsi
  800b4e:	89 d7                	mov    %edx,%edi
  800b50:	ff d0                	callq  *%rax
  800b52:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800b56:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b5a:	7f e3                	jg     800b3f <vprintfmt+0x2df>
  800b5c:	eb 37                	jmp    800b95 <vprintfmt+0x335>
  800b5e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800b62:	74 1e                	je     800b82 <vprintfmt+0x322>
  800b64:	83 fb 1f             	cmp    $0x1f,%ebx
  800b67:	7e 05                	jle    800b6e <vprintfmt+0x30e>
  800b69:	83 fb 7e             	cmp    $0x7e,%ebx
  800b6c:	7e 14                	jle    800b82 <vprintfmt+0x322>
  800b6e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b72:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b76:	48 89 d6             	mov    %rdx,%rsi
  800b79:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800b7e:	ff d0                	callq  *%rax
  800b80:	eb 0f                	jmp    800b91 <vprintfmt+0x331>
  800b82:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b86:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b8a:	48 89 d6             	mov    %rdx,%rsi
  800b8d:	89 df                	mov    %ebx,%edi
  800b8f:	ff d0                	callq  *%rax
  800b91:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800b95:	4c 89 e0             	mov    %r12,%rax
  800b98:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800b9c:	0f b6 00             	movzbl (%rax),%eax
  800b9f:	0f be d8             	movsbl %al,%ebx
  800ba2:	85 db                	test   %ebx,%ebx
  800ba4:	74 10                	je     800bb6 <vprintfmt+0x356>
  800ba6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800baa:	78 b2                	js     800b5e <vprintfmt+0x2fe>
  800bac:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800bb0:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800bb4:	79 a8                	jns    800b5e <vprintfmt+0x2fe>
  800bb6:	eb 16                	jmp    800bce <vprintfmt+0x36e>
  800bb8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bbc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bc0:	48 89 d6             	mov    %rdx,%rsi
  800bc3:	bf 20 00 00 00       	mov    $0x20,%edi
  800bc8:	ff d0                	callq  *%rax
  800bca:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800bce:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800bd2:	7f e4                	jg     800bb8 <vprintfmt+0x358>
  800bd4:	e9 90 01 00 00       	jmpq   800d69 <vprintfmt+0x509>
  800bd9:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800bdd:	be 03 00 00 00       	mov    $0x3,%esi
  800be2:	48 89 c7             	mov    %rax,%rdi
  800be5:	48 b8 50 07 80 00 00 	movabs $0x800750,%rax
  800bec:	00 00 00 
  800bef:	ff d0                	callq  *%rax
  800bf1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800bf5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bf9:	48 85 c0             	test   %rax,%rax
  800bfc:	79 1d                	jns    800c1b <vprintfmt+0x3bb>
  800bfe:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c02:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c06:	48 89 d6             	mov    %rdx,%rsi
  800c09:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800c0e:	ff d0                	callq  *%rax
  800c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c14:	48 f7 d8             	neg    %rax
  800c17:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c1b:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800c22:	e9 d5 00 00 00       	jmpq   800cfc <vprintfmt+0x49c>
  800c27:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c2b:	be 03 00 00 00       	mov    $0x3,%esi
  800c30:	48 89 c7             	mov    %rax,%rdi
  800c33:	48 b8 40 06 80 00 00 	movabs $0x800640,%rax
  800c3a:	00 00 00 
  800c3d:	ff d0                	callq  *%rax
  800c3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c43:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800c4a:	e9 ad 00 00 00       	jmpq   800cfc <vprintfmt+0x49c>
  800c4f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c53:	be 03 00 00 00       	mov    $0x3,%esi
  800c58:	48 89 c7             	mov    %rax,%rdi
  800c5b:	48 b8 40 06 80 00 00 	movabs $0x800640,%rax
  800c62:	00 00 00 
  800c65:	ff d0                	callq  *%rax
  800c67:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c6b:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800c72:	e9 85 00 00 00       	jmpq   800cfc <vprintfmt+0x49c>
  800c77:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c7b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c7f:	48 89 d6             	mov    %rdx,%rsi
  800c82:	bf 30 00 00 00       	mov    $0x30,%edi
  800c87:	ff d0                	callq  *%rax
  800c89:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c8d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c91:	48 89 d6             	mov    %rdx,%rsi
  800c94:	bf 78 00 00 00       	mov    $0x78,%edi
  800c99:	ff d0                	callq  *%rax
  800c9b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c9e:	83 f8 30             	cmp    $0x30,%eax
  800ca1:	73 17                	jae    800cba <vprintfmt+0x45a>
  800ca3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ca7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800caa:	89 c0                	mov    %eax,%eax
  800cac:	48 01 d0             	add    %rdx,%rax
  800caf:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800cb2:	83 c2 08             	add    $0x8,%edx
  800cb5:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800cb8:	eb 0f                	jmp    800cc9 <vprintfmt+0x469>
  800cba:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800cbe:	48 89 d0             	mov    %rdx,%rax
  800cc1:	48 83 c2 08          	add    $0x8,%rdx
  800cc5:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800cc9:	48 8b 00             	mov    (%rax),%rax
  800ccc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800cd0:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800cd7:	eb 23                	jmp    800cfc <vprintfmt+0x49c>
  800cd9:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800cdd:	be 03 00 00 00       	mov    $0x3,%esi
  800ce2:	48 89 c7             	mov    %rax,%rdi
  800ce5:	48 b8 40 06 80 00 00 	movabs $0x800640,%rax
  800cec:	00 00 00 
  800cef:	ff d0                	callq  *%rax
  800cf1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800cf5:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800cfc:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800d01:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800d04:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800d07:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d0b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800d0f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d13:	45 89 c1             	mov    %r8d,%r9d
  800d16:	41 89 f8             	mov    %edi,%r8d
  800d19:	48 89 c7             	mov    %rax,%rdi
  800d1c:	48 b8 85 05 80 00 00 	movabs $0x800585,%rax
  800d23:	00 00 00 
  800d26:	ff d0                	callq  *%rax
  800d28:	eb 3f                	jmp    800d69 <vprintfmt+0x509>
  800d2a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d2e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d32:	48 89 d6             	mov    %rdx,%rsi
  800d35:	89 df                	mov    %ebx,%edi
  800d37:	ff d0                	callq  *%rax
  800d39:	eb 2e                	jmp    800d69 <vprintfmt+0x509>
  800d3b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d3f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d43:	48 89 d6             	mov    %rdx,%rsi
  800d46:	bf 25 00 00 00       	mov    $0x25,%edi
  800d4b:	ff d0                	callq  *%rax
  800d4d:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800d52:	eb 05                	jmp    800d59 <vprintfmt+0x4f9>
  800d54:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800d59:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800d5d:	48 83 e8 01          	sub    $0x1,%rax
  800d61:	0f b6 00             	movzbl (%rax),%eax
  800d64:	3c 25                	cmp    $0x25,%al
  800d66:	75 ec                	jne    800d54 <vprintfmt+0x4f4>
  800d68:	90                   	nop
  800d69:	90                   	nop
  800d6a:	e9 43 fb ff ff       	jmpq   8008b2 <vprintfmt+0x52>
  800d6f:	48 83 c4 60          	add    $0x60,%rsp
  800d73:	5b                   	pop    %rbx
  800d74:	41 5c                	pop    %r12
  800d76:	5d                   	pop    %rbp
  800d77:	c3                   	retq   

0000000000800d78 <printfmt>:
  800d78:	55                   	push   %rbp
  800d79:	48 89 e5             	mov    %rsp,%rbp
  800d7c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800d83:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800d8a:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800d91:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800d98:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800d9f:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800da6:	84 c0                	test   %al,%al
  800da8:	74 20                	je     800dca <printfmt+0x52>
  800daa:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800dae:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800db2:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800db6:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800dba:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800dbe:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800dc2:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800dc6:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800dca:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800dd1:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800dd8:	00 00 00 
  800ddb:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800de2:	00 00 00 
  800de5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800de9:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800df0:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800df7:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800dfe:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800e05:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800e0c:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800e13:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800e1a:	48 89 c7             	mov    %rax,%rdi
  800e1d:	48 b8 60 08 80 00 00 	movabs $0x800860,%rax
  800e24:	00 00 00 
  800e27:	ff d0                	callq  *%rax
  800e29:	c9                   	leaveq 
  800e2a:	c3                   	retq   

0000000000800e2b <sprintputch>:
  800e2b:	55                   	push   %rbp
  800e2c:	48 89 e5             	mov    %rsp,%rbp
  800e2f:	48 83 ec 10          	sub    $0x10,%rsp
  800e33:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800e36:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800e3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e3e:	8b 40 10             	mov    0x10(%rax),%eax
  800e41:	8d 50 01             	lea    0x1(%rax),%edx
  800e44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e48:	89 50 10             	mov    %edx,0x10(%rax)
  800e4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e4f:	48 8b 10             	mov    (%rax),%rdx
  800e52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e56:	48 8b 40 08          	mov    0x8(%rax),%rax
  800e5a:	48 39 c2             	cmp    %rax,%rdx
  800e5d:	73 17                	jae    800e76 <sprintputch+0x4b>
  800e5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e63:	48 8b 00             	mov    (%rax),%rax
  800e66:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800e6a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800e6e:	48 89 0a             	mov    %rcx,(%rdx)
  800e71:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800e74:	88 10                	mov    %dl,(%rax)
  800e76:	c9                   	leaveq 
  800e77:	c3                   	retq   

0000000000800e78 <vsnprintf>:
  800e78:	55                   	push   %rbp
  800e79:	48 89 e5             	mov    %rsp,%rbp
  800e7c:	48 83 ec 50          	sub    $0x50,%rsp
  800e80:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800e84:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800e87:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800e8b:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800e8f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800e93:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800e97:	48 8b 0a             	mov    (%rdx),%rcx
  800e9a:	48 89 08             	mov    %rcx,(%rax)
  800e9d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ea1:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ea5:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ea9:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800ead:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800eb1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800eb5:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800eb8:	48 98                	cltq   
  800eba:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800ebe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800ec2:	48 01 d0             	add    %rdx,%rax
  800ec5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800ec9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800ed0:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800ed5:	74 06                	je     800edd <vsnprintf+0x65>
  800ed7:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800edb:	7f 07                	jg     800ee4 <vsnprintf+0x6c>
  800edd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800ee2:	eb 2f                	jmp    800f13 <vsnprintf+0x9b>
  800ee4:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800ee8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800eec:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800ef0:	48 89 c6             	mov    %rax,%rsi
  800ef3:	48 bf 2b 0e 80 00 00 	movabs $0x800e2b,%rdi
  800efa:	00 00 00 
  800efd:	48 b8 60 08 80 00 00 	movabs $0x800860,%rax
  800f04:	00 00 00 
  800f07:	ff d0                	callq  *%rax
  800f09:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800f0d:	c6 00 00             	movb   $0x0,(%rax)
  800f10:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800f13:	c9                   	leaveq 
  800f14:	c3                   	retq   

0000000000800f15 <snprintf>:
  800f15:	55                   	push   %rbp
  800f16:	48 89 e5             	mov    %rsp,%rbp
  800f19:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800f20:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800f27:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800f2d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f34:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f3b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f42:	84 c0                	test   %al,%al
  800f44:	74 20                	je     800f66 <snprintf+0x51>
  800f46:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f4a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f4e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f52:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f56:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f5a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f5e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f62:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f66:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800f6d:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800f74:	00 00 00 
  800f77:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800f7e:	00 00 00 
  800f81:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800f85:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800f8c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800f93:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800f9a:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800fa1:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800fa8:	48 8b 0a             	mov    (%rdx),%rcx
  800fab:	48 89 08             	mov    %rcx,(%rax)
  800fae:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800fb2:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800fb6:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800fba:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800fbe:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800fc5:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800fcc:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800fd2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800fd9:	48 89 c7             	mov    %rax,%rdi
  800fdc:	48 b8 78 0e 80 00 00 	movabs $0x800e78,%rax
  800fe3:	00 00 00 
  800fe6:	ff d0                	callq  *%rax
  800fe8:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800fee:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800ff4:	c9                   	leaveq 
  800ff5:	c3                   	retq   

0000000000800ff6 <strlen>:
  800ff6:	55                   	push   %rbp
  800ff7:	48 89 e5             	mov    %rsp,%rbp
  800ffa:	48 83 ec 18          	sub    $0x18,%rsp
  800ffe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801002:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801009:	eb 09                	jmp    801014 <strlen+0x1e>
  80100b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80100f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801014:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801018:	0f b6 00             	movzbl (%rax),%eax
  80101b:	84 c0                	test   %al,%al
  80101d:	75 ec                	jne    80100b <strlen+0x15>
  80101f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801022:	c9                   	leaveq 
  801023:	c3                   	retq   

0000000000801024 <strnlen>:
  801024:	55                   	push   %rbp
  801025:	48 89 e5             	mov    %rsp,%rbp
  801028:	48 83 ec 20          	sub    $0x20,%rsp
  80102c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801030:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801034:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80103b:	eb 0e                	jmp    80104b <strnlen+0x27>
  80103d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801041:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801046:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  80104b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801050:	74 0b                	je     80105d <strnlen+0x39>
  801052:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801056:	0f b6 00             	movzbl (%rax),%eax
  801059:	84 c0                	test   %al,%al
  80105b:	75 e0                	jne    80103d <strnlen+0x19>
  80105d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801060:	c9                   	leaveq 
  801061:	c3                   	retq   

0000000000801062 <strcpy>:
  801062:	55                   	push   %rbp
  801063:	48 89 e5             	mov    %rsp,%rbp
  801066:	48 83 ec 20          	sub    $0x20,%rsp
  80106a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80106e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801072:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801076:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80107a:	90                   	nop
  80107b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80107f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801083:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801087:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80108b:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80108f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801093:	0f b6 12             	movzbl (%rdx),%edx
  801096:	88 10                	mov    %dl,(%rax)
  801098:	0f b6 00             	movzbl (%rax),%eax
  80109b:	84 c0                	test   %al,%al
  80109d:	75 dc                	jne    80107b <strcpy+0x19>
  80109f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010a3:	c9                   	leaveq 
  8010a4:	c3                   	retq   

00000000008010a5 <strcat>:
  8010a5:	55                   	push   %rbp
  8010a6:	48 89 e5             	mov    %rsp,%rbp
  8010a9:	48 83 ec 20          	sub    $0x20,%rsp
  8010ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8010b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010b9:	48 89 c7             	mov    %rax,%rdi
  8010bc:	48 b8 f6 0f 80 00 00 	movabs $0x800ff6,%rax
  8010c3:	00 00 00 
  8010c6:	ff d0                	callq  *%rax
  8010c8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8010cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8010ce:	48 63 d0             	movslq %eax,%rdx
  8010d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010d5:	48 01 c2             	add    %rax,%rdx
  8010d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8010dc:	48 89 c6             	mov    %rax,%rsi
  8010df:	48 89 d7             	mov    %rdx,%rdi
  8010e2:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  8010e9:	00 00 00 
  8010ec:	ff d0                	callq  *%rax
  8010ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010f2:	c9                   	leaveq 
  8010f3:	c3                   	retq   

00000000008010f4 <strncpy>:
  8010f4:	55                   	push   %rbp
  8010f5:	48 89 e5             	mov    %rsp,%rbp
  8010f8:	48 83 ec 28          	sub    $0x28,%rsp
  8010fc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801100:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801104:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801108:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80110c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801110:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801117:	00 
  801118:	eb 2a                	jmp    801144 <strncpy+0x50>
  80111a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80111e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801122:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801126:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80112a:	0f b6 12             	movzbl (%rdx),%edx
  80112d:	88 10                	mov    %dl,(%rax)
  80112f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801133:	0f b6 00             	movzbl (%rax),%eax
  801136:	84 c0                	test   %al,%al
  801138:	74 05                	je     80113f <strncpy+0x4b>
  80113a:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80113f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801144:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801148:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80114c:	72 cc                	jb     80111a <strncpy+0x26>
  80114e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801152:	c9                   	leaveq 
  801153:	c3                   	retq   

0000000000801154 <strlcpy>:
  801154:	55                   	push   %rbp
  801155:	48 89 e5             	mov    %rsp,%rbp
  801158:	48 83 ec 28          	sub    $0x28,%rsp
  80115c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801160:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801164:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801168:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80116c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801170:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801175:	74 3d                	je     8011b4 <strlcpy+0x60>
  801177:	eb 1d                	jmp    801196 <strlcpy+0x42>
  801179:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80117d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801181:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801185:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801189:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80118d:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801191:	0f b6 12             	movzbl (%rdx),%edx
  801194:	88 10                	mov    %dl,(%rax)
  801196:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80119b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8011a0:	74 0b                	je     8011ad <strlcpy+0x59>
  8011a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8011a6:	0f b6 00             	movzbl (%rax),%eax
  8011a9:	84 c0                	test   %al,%al
  8011ab:	75 cc                	jne    801179 <strlcpy+0x25>
  8011ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011b1:	c6 00 00             	movb   $0x0,(%rax)
  8011b4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011bc:	48 29 c2             	sub    %rax,%rdx
  8011bf:	48 89 d0             	mov    %rdx,%rax
  8011c2:	c9                   	leaveq 
  8011c3:	c3                   	retq   

00000000008011c4 <strcmp>:
  8011c4:	55                   	push   %rbp
  8011c5:	48 89 e5             	mov    %rsp,%rbp
  8011c8:	48 83 ec 10          	sub    $0x10,%rsp
  8011cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011d0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8011d4:	eb 0a                	jmp    8011e0 <strcmp+0x1c>
  8011d6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8011db:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8011e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011e4:	0f b6 00             	movzbl (%rax),%eax
  8011e7:	84 c0                	test   %al,%al
  8011e9:	74 12                	je     8011fd <strcmp+0x39>
  8011eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011ef:	0f b6 10             	movzbl (%rax),%edx
  8011f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011f6:	0f b6 00             	movzbl (%rax),%eax
  8011f9:	38 c2                	cmp    %al,%dl
  8011fb:	74 d9                	je     8011d6 <strcmp+0x12>
  8011fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801201:	0f b6 00             	movzbl (%rax),%eax
  801204:	0f b6 d0             	movzbl %al,%edx
  801207:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80120b:	0f b6 00             	movzbl (%rax),%eax
  80120e:	0f b6 c0             	movzbl %al,%eax
  801211:	29 c2                	sub    %eax,%edx
  801213:	89 d0                	mov    %edx,%eax
  801215:	c9                   	leaveq 
  801216:	c3                   	retq   

0000000000801217 <strncmp>:
  801217:	55                   	push   %rbp
  801218:	48 89 e5             	mov    %rsp,%rbp
  80121b:	48 83 ec 18          	sub    $0x18,%rsp
  80121f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801223:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801227:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80122b:	eb 0f                	jmp    80123c <strncmp+0x25>
  80122d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801232:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801237:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80123c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801241:	74 1d                	je     801260 <strncmp+0x49>
  801243:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801247:	0f b6 00             	movzbl (%rax),%eax
  80124a:	84 c0                	test   %al,%al
  80124c:	74 12                	je     801260 <strncmp+0x49>
  80124e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801252:	0f b6 10             	movzbl (%rax),%edx
  801255:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801259:	0f b6 00             	movzbl (%rax),%eax
  80125c:	38 c2                	cmp    %al,%dl
  80125e:	74 cd                	je     80122d <strncmp+0x16>
  801260:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801265:	75 07                	jne    80126e <strncmp+0x57>
  801267:	b8 00 00 00 00       	mov    $0x0,%eax
  80126c:	eb 18                	jmp    801286 <strncmp+0x6f>
  80126e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801272:	0f b6 00             	movzbl (%rax),%eax
  801275:	0f b6 d0             	movzbl %al,%edx
  801278:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80127c:	0f b6 00             	movzbl (%rax),%eax
  80127f:	0f b6 c0             	movzbl %al,%eax
  801282:	29 c2                	sub    %eax,%edx
  801284:	89 d0                	mov    %edx,%eax
  801286:	c9                   	leaveq 
  801287:	c3                   	retq   

0000000000801288 <strchr>:
  801288:	55                   	push   %rbp
  801289:	48 89 e5             	mov    %rsp,%rbp
  80128c:	48 83 ec 0c          	sub    $0xc,%rsp
  801290:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801294:	89 f0                	mov    %esi,%eax
  801296:	88 45 f4             	mov    %al,-0xc(%rbp)
  801299:	eb 17                	jmp    8012b2 <strchr+0x2a>
  80129b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80129f:	0f b6 00             	movzbl (%rax),%eax
  8012a2:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8012a5:	75 06                	jne    8012ad <strchr+0x25>
  8012a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012ab:	eb 15                	jmp    8012c2 <strchr+0x3a>
  8012ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012b6:	0f b6 00             	movzbl (%rax),%eax
  8012b9:	84 c0                	test   %al,%al
  8012bb:	75 de                	jne    80129b <strchr+0x13>
  8012bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8012c2:	c9                   	leaveq 
  8012c3:	c3                   	retq   

00000000008012c4 <strfind>:
  8012c4:	55                   	push   %rbp
  8012c5:	48 89 e5             	mov    %rsp,%rbp
  8012c8:	48 83 ec 0c          	sub    $0xc,%rsp
  8012cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8012d0:	89 f0                	mov    %esi,%eax
  8012d2:	88 45 f4             	mov    %al,-0xc(%rbp)
  8012d5:	eb 13                	jmp    8012ea <strfind+0x26>
  8012d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012db:	0f b6 00             	movzbl (%rax),%eax
  8012de:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8012e1:	75 02                	jne    8012e5 <strfind+0x21>
  8012e3:	eb 10                	jmp    8012f5 <strfind+0x31>
  8012e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012ee:	0f b6 00             	movzbl (%rax),%eax
  8012f1:	84 c0                	test   %al,%al
  8012f3:	75 e2                	jne    8012d7 <strfind+0x13>
  8012f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012f9:	c9                   	leaveq 
  8012fa:	c3                   	retq   

00000000008012fb <memset>:
  8012fb:	55                   	push   %rbp
  8012fc:	48 89 e5             	mov    %rsp,%rbp
  8012ff:	48 83 ec 18          	sub    $0x18,%rsp
  801303:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801307:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80130a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80130e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801313:	75 06                	jne    80131b <memset+0x20>
  801315:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801319:	eb 69                	jmp    801384 <memset+0x89>
  80131b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80131f:	83 e0 03             	and    $0x3,%eax
  801322:	48 85 c0             	test   %rax,%rax
  801325:	75 48                	jne    80136f <memset+0x74>
  801327:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80132b:	83 e0 03             	and    $0x3,%eax
  80132e:	48 85 c0             	test   %rax,%rax
  801331:	75 3c                	jne    80136f <memset+0x74>
  801333:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80133a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80133d:	c1 e0 18             	shl    $0x18,%eax
  801340:	89 c2                	mov    %eax,%edx
  801342:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801345:	c1 e0 10             	shl    $0x10,%eax
  801348:	09 c2                	or     %eax,%edx
  80134a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80134d:	c1 e0 08             	shl    $0x8,%eax
  801350:	09 d0                	or     %edx,%eax
  801352:	09 45 f4             	or     %eax,-0xc(%rbp)
  801355:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801359:	48 c1 e8 02          	shr    $0x2,%rax
  80135d:	48 89 c1             	mov    %rax,%rcx
  801360:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801364:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801367:	48 89 d7             	mov    %rdx,%rdi
  80136a:	fc                   	cld    
  80136b:	f3 ab                	rep stos %eax,%es:(%rdi)
  80136d:	eb 11                	jmp    801380 <memset+0x85>
  80136f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801373:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801376:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80137a:	48 89 d7             	mov    %rdx,%rdi
  80137d:	fc                   	cld    
  80137e:	f3 aa                	rep stos %al,%es:(%rdi)
  801380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801384:	c9                   	leaveq 
  801385:	c3                   	retq   

0000000000801386 <memmove>:
  801386:	55                   	push   %rbp
  801387:	48 89 e5             	mov    %rsp,%rbp
  80138a:	48 83 ec 28          	sub    $0x28,%rsp
  80138e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801392:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801396:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80139a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80139e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8013aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013ae:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8013b2:	0f 83 88 00 00 00    	jae    801440 <memmove+0xba>
  8013b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013bc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013c0:	48 01 d0             	add    %rdx,%rax
  8013c3:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8013c7:	76 77                	jbe    801440 <memmove+0xba>
  8013c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013cd:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8013d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013d5:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8013d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013dd:	83 e0 03             	and    $0x3,%eax
  8013e0:	48 85 c0             	test   %rax,%rax
  8013e3:	75 3b                	jne    801420 <memmove+0x9a>
  8013e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013e9:	83 e0 03             	and    $0x3,%eax
  8013ec:	48 85 c0             	test   %rax,%rax
  8013ef:	75 2f                	jne    801420 <memmove+0x9a>
  8013f1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013f5:	83 e0 03             	and    $0x3,%eax
  8013f8:	48 85 c0             	test   %rax,%rax
  8013fb:	75 23                	jne    801420 <memmove+0x9a>
  8013fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801401:	48 83 e8 04          	sub    $0x4,%rax
  801405:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801409:	48 83 ea 04          	sub    $0x4,%rdx
  80140d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801411:	48 c1 e9 02          	shr    $0x2,%rcx
  801415:	48 89 c7             	mov    %rax,%rdi
  801418:	48 89 d6             	mov    %rdx,%rsi
  80141b:	fd                   	std    
  80141c:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80141e:	eb 1d                	jmp    80143d <memmove+0xb7>
  801420:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801424:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801428:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80142c:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801430:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801434:	48 89 d7             	mov    %rdx,%rdi
  801437:	48 89 c1             	mov    %rax,%rcx
  80143a:	fd                   	std    
  80143b:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80143d:	fc                   	cld    
  80143e:	eb 57                	jmp    801497 <memmove+0x111>
  801440:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801444:	83 e0 03             	and    $0x3,%eax
  801447:	48 85 c0             	test   %rax,%rax
  80144a:	75 36                	jne    801482 <memmove+0xfc>
  80144c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801450:	83 e0 03             	and    $0x3,%eax
  801453:	48 85 c0             	test   %rax,%rax
  801456:	75 2a                	jne    801482 <memmove+0xfc>
  801458:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80145c:	83 e0 03             	and    $0x3,%eax
  80145f:	48 85 c0             	test   %rax,%rax
  801462:	75 1e                	jne    801482 <memmove+0xfc>
  801464:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801468:	48 c1 e8 02          	shr    $0x2,%rax
  80146c:	48 89 c1             	mov    %rax,%rcx
  80146f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801473:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801477:	48 89 c7             	mov    %rax,%rdi
  80147a:	48 89 d6             	mov    %rdx,%rsi
  80147d:	fc                   	cld    
  80147e:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801480:	eb 15                	jmp    801497 <memmove+0x111>
  801482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801486:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80148a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80148e:	48 89 c7             	mov    %rax,%rdi
  801491:	48 89 d6             	mov    %rdx,%rsi
  801494:	fc                   	cld    
  801495:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801497:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80149b:	c9                   	leaveq 
  80149c:	c3                   	retq   

000000000080149d <memcpy>:
  80149d:	55                   	push   %rbp
  80149e:	48 89 e5             	mov    %rsp,%rbp
  8014a1:	48 83 ec 18          	sub    $0x18,%rsp
  8014a5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014a9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8014ad:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014b1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8014b5:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8014b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014bd:	48 89 ce             	mov    %rcx,%rsi
  8014c0:	48 89 c7             	mov    %rax,%rdi
  8014c3:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  8014ca:	00 00 00 
  8014cd:	ff d0                	callq  *%rax
  8014cf:	c9                   	leaveq 
  8014d0:	c3                   	retq   

00000000008014d1 <memcmp>:
  8014d1:	55                   	push   %rbp
  8014d2:	48 89 e5             	mov    %rsp,%rbp
  8014d5:	48 83 ec 28          	sub    $0x28,%rsp
  8014d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014dd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014e1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8014ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014f1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8014f5:	eb 36                	jmp    80152d <memcmp+0x5c>
  8014f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014fb:	0f b6 10             	movzbl (%rax),%edx
  8014fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801502:	0f b6 00             	movzbl (%rax),%eax
  801505:	38 c2                	cmp    %al,%dl
  801507:	74 1a                	je     801523 <memcmp+0x52>
  801509:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80150d:	0f b6 00             	movzbl (%rax),%eax
  801510:	0f b6 d0             	movzbl %al,%edx
  801513:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801517:	0f b6 00             	movzbl (%rax),%eax
  80151a:	0f b6 c0             	movzbl %al,%eax
  80151d:	29 c2                	sub    %eax,%edx
  80151f:	89 d0                	mov    %edx,%eax
  801521:	eb 20                	jmp    801543 <memcmp+0x72>
  801523:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801528:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80152d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801531:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801535:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801539:	48 85 c0             	test   %rax,%rax
  80153c:	75 b9                	jne    8014f7 <memcmp+0x26>
  80153e:	b8 00 00 00 00       	mov    $0x0,%eax
  801543:	c9                   	leaveq 
  801544:	c3                   	retq   

0000000000801545 <memfind>:
  801545:	55                   	push   %rbp
  801546:	48 89 e5             	mov    %rsp,%rbp
  801549:	48 83 ec 28          	sub    $0x28,%rsp
  80154d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801551:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801554:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801558:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80155c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801560:	48 01 d0             	add    %rdx,%rax
  801563:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801567:	eb 15                	jmp    80157e <memfind+0x39>
  801569:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80156d:	0f b6 10             	movzbl (%rax),%edx
  801570:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801573:	38 c2                	cmp    %al,%dl
  801575:	75 02                	jne    801579 <memfind+0x34>
  801577:	eb 0f                	jmp    801588 <memfind+0x43>
  801579:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80157e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801582:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801586:	72 e1                	jb     801569 <memfind+0x24>
  801588:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80158c:	c9                   	leaveq 
  80158d:	c3                   	retq   

000000000080158e <strtol>:
  80158e:	55                   	push   %rbp
  80158f:	48 89 e5             	mov    %rsp,%rbp
  801592:	48 83 ec 34          	sub    $0x34,%rsp
  801596:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80159a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80159e:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8015a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8015a8:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8015af:	00 
  8015b0:	eb 05                	jmp    8015b7 <strtol+0x29>
  8015b2:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015bb:	0f b6 00             	movzbl (%rax),%eax
  8015be:	3c 20                	cmp    $0x20,%al
  8015c0:	74 f0                	je     8015b2 <strtol+0x24>
  8015c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015c6:	0f b6 00             	movzbl (%rax),%eax
  8015c9:	3c 09                	cmp    $0x9,%al
  8015cb:	74 e5                	je     8015b2 <strtol+0x24>
  8015cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015d1:	0f b6 00             	movzbl (%rax),%eax
  8015d4:	3c 2b                	cmp    $0x2b,%al
  8015d6:	75 07                	jne    8015df <strtol+0x51>
  8015d8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015dd:	eb 17                	jmp    8015f6 <strtol+0x68>
  8015df:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015e3:	0f b6 00             	movzbl (%rax),%eax
  8015e6:	3c 2d                	cmp    $0x2d,%al
  8015e8:	75 0c                	jne    8015f6 <strtol+0x68>
  8015ea:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015ef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8015f6:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8015fa:	74 06                	je     801602 <strtol+0x74>
  8015fc:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801600:	75 28                	jne    80162a <strtol+0x9c>
  801602:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801606:	0f b6 00             	movzbl (%rax),%eax
  801609:	3c 30                	cmp    $0x30,%al
  80160b:	75 1d                	jne    80162a <strtol+0x9c>
  80160d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801611:	48 83 c0 01          	add    $0x1,%rax
  801615:	0f b6 00             	movzbl (%rax),%eax
  801618:	3c 78                	cmp    $0x78,%al
  80161a:	75 0e                	jne    80162a <strtol+0x9c>
  80161c:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801621:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801628:	eb 2c                	jmp    801656 <strtol+0xc8>
  80162a:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80162e:	75 19                	jne    801649 <strtol+0xbb>
  801630:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801634:	0f b6 00             	movzbl (%rax),%eax
  801637:	3c 30                	cmp    $0x30,%al
  801639:	75 0e                	jne    801649 <strtol+0xbb>
  80163b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801640:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801647:	eb 0d                	jmp    801656 <strtol+0xc8>
  801649:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80164d:	75 07                	jne    801656 <strtol+0xc8>
  80164f:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801656:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80165a:	0f b6 00             	movzbl (%rax),%eax
  80165d:	3c 2f                	cmp    $0x2f,%al
  80165f:	7e 1d                	jle    80167e <strtol+0xf0>
  801661:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801665:	0f b6 00             	movzbl (%rax),%eax
  801668:	3c 39                	cmp    $0x39,%al
  80166a:	7f 12                	jg     80167e <strtol+0xf0>
  80166c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801670:	0f b6 00             	movzbl (%rax),%eax
  801673:	0f be c0             	movsbl %al,%eax
  801676:	83 e8 30             	sub    $0x30,%eax
  801679:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80167c:	eb 4e                	jmp    8016cc <strtol+0x13e>
  80167e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801682:	0f b6 00             	movzbl (%rax),%eax
  801685:	3c 60                	cmp    $0x60,%al
  801687:	7e 1d                	jle    8016a6 <strtol+0x118>
  801689:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80168d:	0f b6 00             	movzbl (%rax),%eax
  801690:	3c 7a                	cmp    $0x7a,%al
  801692:	7f 12                	jg     8016a6 <strtol+0x118>
  801694:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801698:	0f b6 00             	movzbl (%rax),%eax
  80169b:	0f be c0             	movsbl %al,%eax
  80169e:	83 e8 57             	sub    $0x57,%eax
  8016a1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8016a4:	eb 26                	jmp    8016cc <strtol+0x13e>
  8016a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016aa:	0f b6 00             	movzbl (%rax),%eax
  8016ad:	3c 40                	cmp    $0x40,%al
  8016af:	7e 48                	jle    8016f9 <strtol+0x16b>
  8016b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016b5:	0f b6 00             	movzbl (%rax),%eax
  8016b8:	3c 5a                	cmp    $0x5a,%al
  8016ba:	7f 3d                	jg     8016f9 <strtol+0x16b>
  8016bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016c0:	0f b6 00             	movzbl (%rax),%eax
  8016c3:	0f be c0             	movsbl %al,%eax
  8016c6:	83 e8 37             	sub    $0x37,%eax
  8016c9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8016cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016cf:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  8016d2:	7c 02                	jl     8016d6 <strtol+0x148>
  8016d4:	eb 23                	jmp    8016f9 <strtol+0x16b>
  8016d6:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8016db:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8016de:	48 98                	cltq   
  8016e0:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8016e5:	48 89 c2             	mov    %rax,%rdx
  8016e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016eb:	48 98                	cltq   
  8016ed:	48 01 d0             	add    %rdx,%rax
  8016f0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8016f4:	e9 5d ff ff ff       	jmpq   801656 <strtol+0xc8>
  8016f9:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8016fe:	74 0b                	je     80170b <strtol+0x17d>
  801700:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801704:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801708:	48 89 10             	mov    %rdx,(%rax)
  80170b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80170f:	74 09                	je     80171a <strtol+0x18c>
  801711:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801715:	48 f7 d8             	neg    %rax
  801718:	eb 04                	jmp    80171e <strtol+0x190>
  80171a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80171e:	c9                   	leaveq 
  80171f:	c3                   	retq   

0000000000801720 <strstr>:
  801720:	55                   	push   %rbp
  801721:	48 89 e5             	mov    %rsp,%rbp
  801724:	48 83 ec 30          	sub    $0x30,%rsp
  801728:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80172c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801730:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801734:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801738:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80173c:	0f b6 00             	movzbl (%rax),%eax
  80173f:	88 45 ff             	mov    %al,-0x1(%rbp)
  801742:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801746:	75 06                	jne    80174e <strstr+0x2e>
  801748:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80174c:	eb 6b                	jmp    8017b9 <strstr+0x99>
  80174e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801752:	48 89 c7             	mov    %rax,%rdi
  801755:	48 b8 f6 0f 80 00 00 	movabs $0x800ff6,%rax
  80175c:	00 00 00 
  80175f:	ff d0                	callq  *%rax
  801761:	48 98                	cltq   
  801763:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801767:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80176b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80176f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801773:	0f b6 00             	movzbl (%rax),%eax
  801776:	88 45 ef             	mov    %al,-0x11(%rbp)
  801779:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  80177d:	75 07                	jne    801786 <strstr+0x66>
  80177f:	b8 00 00 00 00       	mov    $0x0,%eax
  801784:	eb 33                	jmp    8017b9 <strstr+0x99>
  801786:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80178a:	3a 45 ff             	cmp    -0x1(%rbp),%al
  80178d:	75 d8                	jne    801767 <strstr+0x47>
  80178f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801793:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801797:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80179b:	48 89 ce             	mov    %rcx,%rsi
  80179e:	48 89 c7             	mov    %rax,%rdi
  8017a1:	48 b8 17 12 80 00 00 	movabs $0x801217,%rax
  8017a8:	00 00 00 
  8017ab:	ff d0                	callq  *%rax
  8017ad:	85 c0                	test   %eax,%eax
  8017af:	75 b6                	jne    801767 <strstr+0x47>
  8017b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017b5:	48 83 e8 01          	sub    $0x1,%rax
  8017b9:	c9                   	leaveq 
  8017ba:	c3                   	retq   

00000000008017bb <syscall>:
  8017bb:	55                   	push   %rbp
  8017bc:	48 89 e5             	mov    %rsp,%rbp
  8017bf:	53                   	push   %rbx
  8017c0:	48 83 ec 48          	sub    $0x48,%rsp
  8017c4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8017c7:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8017ca:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8017ce:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  8017d2:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8017d6:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  8017da:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8017dd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8017e1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8017e5:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8017e9:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8017ed:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8017f1:	4c 89 c3             	mov    %r8,%rbx
  8017f4:	cd 30                	int    $0x30
  8017f6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8017fa:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8017fe:	74 3e                	je     80183e <syscall+0x83>
  801800:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801805:	7e 37                	jle    80183e <syscall+0x83>
  801807:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80180b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80180e:	49 89 d0             	mov    %rdx,%r8
  801811:	89 c1                	mov    %eax,%ecx
  801813:	48 ba 68 4d 80 00 00 	movabs $0x804d68,%rdx
  80181a:	00 00 00 
  80181d:	be 24 00 00 00       	mov    $0x24,%esi
  801822:	48 bf 85 4d 80 00 00 	movabs $0x804d85,%rdi
  801829:	00 00 00 
  80182c:	b8 00 00 00 00       	mov    $0x0,%eax
  801831:	49 b9 74 02 80 00 00 	movabs $0x800274,%r9
  801838:	00 00 00 
  80183b:	41 ff d1             	callq  *%r9
  80183e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801842:	48 83 c4 48          	add    $0x48,%rsp
  801846:	5b                   	pop    %rbx
  801847:	5d                   	pop    %rbp
  801848:	c3                   	retq   

0000000000801849 <sys_cputs>:
  801849:	55                   	push   %rbp
  80184a:	48 89 e5             	mov    %rsp,%rbp
  80184d:	48 83 ec 20          	sub    $0x20,%rsp
  801851:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801855:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801859:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80185d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801861:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801868:	00 
  801869:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80186f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801875:	48 89 d1             	mov    %rdx,%rcx
  801878:	48 89 c2             	mov    %rax,%rdx
  80187b:	be 00 00 00 00       	mov    $0x0,%esi
  801880:	bf 00 00 00 00       	mov    $0x0,%edi
  801885:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  80188c:	00 00 00 
  80188f:	ff d0                	callq  *%rax
  801891:	c9                   	leaveq 
  801892:	c3                   	retq   

0000000000801893 <sys_cgetc>:
  801893:	55                   	push   %rbp
  801894:	48 89 e5             	mov    %rsp,%rbp
  801897:	48 83 ec 10          	sub    $0x10,%rsp
  80189b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018a2:	00 
  8018a3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018a9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018af:	b9 00 00 00 00       	mov    $0x0,%ecx
  8018b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8018b9:	be 00 00 00 00       	mov    $0x0,%esi
  8018be:	bf 01 00 00 00       	mov    $0x1,%edi
  8018c3:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  8018ca:	00 00 00 
  8018cd:	ff d0                	callq  *%rax
  8018cf:	c9                   	leaveq 
  8018d0:	c3                   	retq   

00000000008018d1 <sys_env_destroy>:
  8018d1:	55                   	push   %rbp
  8018d2:	48 89 e5             	mov    %rsp,%rbp
  8018d5:	48 83 ec 10          	sub    $0x10,%rsp
  8018d9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018df:	48 98                	cltq   
  8018e1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018e8:	00 
  8018e9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018ef:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018f5:	b9 00 00 00 00       	mov    $0x0,%ecx
  8018fa:	48 89 c2             	mov    %rax,%rdx
  8018fd:	be 01 00 00 00       	mov    $0x1,%esi
  801902:	bf 03 00 00 00       	mov    $0x3,%edi
  801907:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  80190e:	00 00 00 
  801911:	ff d0                	callq  *%rax
  801913:	c9                   	leaveq 
  801914:	c3                   	retq   

0000000000801915 <sys_getenvid>:
  801915:	55                   	push   %rbp
  801916:	48 89 e5             	mov    %rsp,%rbp
  801919:	48 83 ec 10          	sub    $0x10,%rsp
  80191d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801924:	00 
  801925:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80192b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801931:	b9 00 00 00 00       	mov    $0x0,%ecx
  801936:	ba 00 00 00 00       	mov    $0x0,%edx
  80193b:	be 00 00 00 00       	mov    $0x0,%esi
  801940:	bf 02 00 00 00       	mov    $0x2,%edi
  801945:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  80194c:	00 00 00 
  80194f:	ff d0                	callq  *%rax
  801951:	c9                   	leaveq 
  801952:	c3                   	retq   

0000000000801953 <sys_yield>:
  801953:	55                   	push   %rbp
  801954:	48 89 e5             	mov    %rsp,%rbp
  801957:	48 83 ec 10          	sub    $0x10,%rsp
  80195b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801962:	00 
  801963:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801969:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80196f:	b9 00 00 00 00       	mov    $0x0,%ecx
  801974:	ba 00 00 00 00       	mov    $0x0,%edx
  801979:	be 00 00 00 00       	mov    $0x0,%esi
  80197e:	bf 0b 00 00 00       	mov    $0xb,%edi
  801983:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  80198a:	00 00 00 
  80198d:	ff d0                	callq  *%rax
  80198f:	c9                   	leaveq 
  801990:	c3                   	retq   

0000000000801991 <sys_page_alloc>:
  801991:	55                   	push   %rbp
  801992:	48 89 e5             	mov    %rsp,%rbp
  801995:	48 83 ec 20          	sub    $0x20,%rsp
  801999:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80199c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019a0:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8019a3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8019a6:	48 63 c8             	movslq %eax,%rcx
  8019a9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b0:	48 98                	cltq   
  8019b2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019b9:	00 
  8019ba:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019c0:	49 89 c8             	mov    %rcx,%r8
  8019c3:	48 89 d1             	mov    %rdx,%rcx
  8019c6:	48 89 c2             	mov    %rax,%rdx
  8019c9:	be 01 00 00 00       	mov    $0x1,%esi
  8019ce:	bf 04 00 00 00       	mov    $0x4,%edi
  8019d3:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  8019da:	00 00 00 
  8019dd:	ff d0                	callq  *%rax
  8019df:	c9                   	leaveq 
  8019e0:	c3                   	retq   

00000000008019e1 <sys_page_map>:
  8019e1:	55                   	push   %rbp
  8019e2:	48 89 e5             	mov    %rsp,%rbp
  8019e5:	48 83 ec 30          	sub    $0x30,%rsp
  8019e9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019ec:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019f0:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8019f3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8019f7:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8019fb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8019fe:	48 63 c8             	movslq %eax,%rcx
  801a01:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801a05:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a08:	48 63 f0             	movslq %eax,%rsi
  801a0b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a12:	48 98                	cltq   
  801a14:	48 89 0c 24          	mov    %rcx,(%rsp)
  801a18:	49 89 f9             	mov    %rdi,%r9
  801a1b:	49 89 f0             	mov    %rsi,%r8
  801a1e:	48 89 d1             	mov    %rdx,%rcx
  801a21:	48 89 c2             	mov    %rax,%rdx
  801a24:	be 01 00 00 00       	mov    $0x1,%esi
  801a29:	bf 05 00 00 00       	mov    $0x5,%edi
  801a2e:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801a35:	00 00 00 
  801a38:	ff d0                	callq  *%rax
  801a3a:	c9                   	leaveq 
  801a3b:	c3                   	retq   

0000000000801a3c <sys_page_unmap>:
  801a3c:	55                   	push   %rbp
  801a3d:	48 89 e5             	mov    %rsp,%rbp
  801a40:	48 83 ec 20          	sub    $0x20,%rsp
  801a44:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a47:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a4b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a52:	48 98                	cltq   
  801a54:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a5b:	00 
  801a5c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a62:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a68:	48 89 d1             	mov    %rdx,%rcx
  801a6b:	48 89 c2             	mov    %rax,%rdx
  801a6e:	be 01 00 00 00       	mov    $0x1,%esi
  801a73:	bf 06 00 00 00       	mov    $0x6,%edi
  801a78:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801a7f:	00 00 00 
  801a82:	ff d0                	callq  *%rax
  801a84:	c9                   	leaveq 
  801a85:	c3                   	retq   

0000000000801a86 <sys_env_set_status>:
  801a86:	55                   	push   %rbp
  801a87:	48 89 e5             	mov    %rsp,%rbp
  801a8a:	48 83 ec 10          	sub    $0x10,%rsp
  801a8e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a91:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801a94:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a97:	48 63 d0             	movslq %eax,%rdx
  801a9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a9d:	48 98                	cltq   
  801a9f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aa6:	00 
  801aa7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801aad:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ab3:	48 89 d1             	mov    %rdx,%rcx
  801ab6:	48 89 c2             	mov    %rax,%rdx
  801ab9:	be 01 00 00 00       	mov    $0x1,%esi
  801abe:	bf 08 00 00 00       	mov    $0x8,%edi
  801ac3:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801aca:	00 00 00 
  801acd:	ff d0                	callq  *%rax
  801acf:	c9                   	leaveq 
  801ad0:	c3                   	retq   

0000000000801ad1 <sys_env_set_trapframe>:
  801ad1:	55                   	push   %rbp
  801ad2:	48 89 e5             	mov    %rsp,%rbp
  801ad5:	48 83 ec 20          	sub    $0x20,%rsp
  801ad9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801adc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ae0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ae4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ae7:	48 98                	cltq   
  801ae9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801af0:	00 
  801af1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801af7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801afd:	48 89 d1             	mov    %rdx,%rcx
  801b00:	48 89 c2             	mov    %rax,%rdx
  801b03:	be 01 00 00 00       	mov    $0x1,%esi
  801b08:	bf 09 00 00 00       	mov    $0x9,%edi
  801b0d:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801b14:	00 00 00 
  801b17:	ff d0                	callq  *%rax
  801b19:	c9                   	leaveq 
  801b1a:	c3                   	retq   

0000000000801b1b <sys_env_set_pgfault_upcall>:
  801b1b:	55                   	push   %rbp
  801b1c:	48 89 e5             	mov    %rsp,%rbp
  801b1f:	48 83 ec 20          	sub    $0x20,%rsp
  801b23:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b26:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b2a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b31:	48 98                	cltq   
  801b33:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b3a:	00 
  801b3b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b41:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b47:	48 89 d1             	mov    %rdx,%rcx
  801b4a:	48 89 c2             	mov    %rax,%rdx
  801b4d:	be 01 00 00 00       	mov    $0x1,%esi
  801b52:	bf 0a 00 00 00       	mov    $0xa,%edi
  801b57:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801b5e:	00 00 00 
  801b61:	ff d0                	callq  *%rax
  801b63:	c9                   	leaveq 
  801b64:	c3                   	retq   

0000000000801b65 <sys_ipc_try_send>:
  801b65:	55                   	push   %rbp
  801b66:	48 89 e5             	mov    %rsp,%rbp
  801b69:	48 83 ec 20          	sub    $0x20,%rsp
  801b6d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b70:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b74:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801b78:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801b7b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b7e:	48 63 f0             	movslq %eax,%rsi
  801b81:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801b85:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b88:	48 98                	cltq   
  801b8a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b8e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b95:	00 
  801b96:	49 89 f1             	mov    %rsi,%r9
  801b99:	49 89 c8             	mov    %rcx,%r8
  801b9c:	48 89 d1             	mov    %rdx,%rcx
  801b9f:	48 89 c2             	mov    %rax,%rdx
  801ba2:	be 00 00 00 00       	mov    $0x0,%esi
  801ba7:	bf 0c 00 00 00       	mov    $0xc,%edi
  801bac:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801bb3:	00 00 00 
  801bb6:	ff d0                	callq  *%rax
  801bb8:	c9                   	leaveq 
  801bb9:	c3                   	retq   

0000000000801bba <sys_ipc_recv>:
  801bba:	55                   	push   %rbp
  801bbb:	48 89 e5             	mov    %rsp,%rbp
  801bbe:	48 83 ec 10          	sub    $0x10,%rsp
  801bc2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bca:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bd1:	00 
  801bd2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bd8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bde:	b9 00 00 00 00       	mov    $0x0,%ecx
  801be3:	48 89 c2             	mov    %rax,%rdx
  801be6:	be 01 00 00 00       	mov    $0x1,%esi
  801beb:	bf 0d 00 00 00       	mov    $0xd,%edi
  801bf0:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801bf7:	00 00 00 
  801bfa:	ff d0                	callq  *%rax
  801bfc:	c9                   	leaveq 
  801bfd:	c3                   	retq   

0000000000801bfe <sys_time_msec>:
  801bfe:	55                   	push   %rbp
  801bff:	48 89 e5             	mov    %rsp,%rbp
  801c02:	48 83 ec 10          	sub    $0x10,%rsp
  801c06:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c0d:	00 
  801c0e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c14:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c1a:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c1f:	ba 00 00 00 00       	mov    $0x0,%edx
  801c24:	be 00 00 00 00       	mov    $0x0,%esi
  801c29:	bf 0e 00 00 00       	mov    $0xe,%edi
  801c2e:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801c35:	00 00 00 
  801c38:	ff d0                	callq  *%rax
  801c3a:	c9                   	leaveq 
  801c3b:	c3                   	retq   

0000000000801c3c <sys_net_transmit>:
  801c3c:	55                   	push   %rbp
  801c3d:	48 89 e5             	mov    %rsp,%rbp
  801c40:	48 83 ec 20          	sub    $0x20,%rsp
  801c44:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c48:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801c4b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c52:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c59:	00 
  801c5a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c60:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c66:	48 89 d1             	mov    %rdx,%rcx
  801c69:	48 89 c2             	mov    %rax,%rdx
  801c6c:	be 00 00 00 00       	mov    $0x0,%esi
  801c71:	bf 0f 00 00 00       	mov    $0xf,%edi
  801c76:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801c7d:	00 00 00 
  801c80:	ff d0                	callq  *%rax
  801c82:	c9                   	leaveq 
  801c83:	c3                   	retq   

0000000000801c84 <sys_net_receive>:
  801c84:	55                   	push   %rbp
  801c85:	48 89 e5             	mov    %rsp,%rbp
  801c88:	48 83 ec 20          	sub    $0x20,%rsp
  801c8c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c90:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801c93:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801c96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c9a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ca1:	00 
  801ca2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ca8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cae:	48 89 d1             	mov    %rdx,%rcx
  801cb1:	48 89 c2             	mov    %rax,%rdx
  801cb4:	be 00 00 00 00       	mov    $0x0,%esi
  801cb9:	bf 10 00 00 00       	mov    $0x10,%edi
  801cbe:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801cc5:	00 00 00 
  801cc8:	ff d0                	callq  *%rax
  801cca:	c9                   	leaveq 
  801ccb:	c3                   	retq   

0000000000801ccc <sys_ept_map>:
  801ccc:	55                   	push   %rbp
  801ccd:	48 89 e5             	mov    %rsp,%rbp
  801cd0:	48 83 ec 30          	sub    $0x30,%rsp
  801cd4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cd7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801cdb:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801cde:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801ce2:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801ce6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801ce9:	48 63 c8             	movslq %eax,%rcx
  801cec:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801cf0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801cf3:	48 63 f0             	movslq %eax,%rsi
  801cf6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801cfa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cfd:	48 98                	cltq   
  801cff:	48 89 0c 24          	mov    %rcx,(%rsp)
  801d03:	49 89 f9             	mov    %rdi,%r9
  801d06:	49 89 f0             	mov    %rsi,%r8
  801d09:	48 89 d1             	mov    %rdx,%rcx
  801d0c:	48 89 c2             	mov    %rax,%rdx
  801d0f:	be 00 00 00 00       	mov    $0x0,%esi
  801d14:	bf 11 00 00 00       	mov    $0x11,%edi
  801d19:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801d20:	00 00 00 
  801d23:	ff d0                	callq  *%rax
  801d25:	c9                   	leaveq 
  801d26:	c3                   	retq   

0000000000801d27 <sys_env_mkguest>:
  801d27:	55                   	push   %rbp
  801d28:	48 89 e5             	mov    %rsp,%rbp
  801d2b:	48 83 ec 20          	sub    $0x20,%rsp
  801d2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d33:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d37:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d3f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d46:	00 
  801d47:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d4d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d53:	48 89 d1             	mov    %rdx,%rcx
  801d56:	48 89 c2             	mov    %rax,%rdx
  801d59:	be 00 00 00 00       	mov    $0x0,%esi
  801d5e:	bf 12 00 00 00       	mov    $0x12,%edi
  801d63:	48 b8 bb 17 80 00 00 	movabs $0x8017bb,%rax
  801d6a:	00 00 00 
  801d6d:	ff d0                	callq  *%rax
  801d6f:	c9                   	leaveq 
  801d70:	c3                   	retq   

0000000000801d71 <pgfault>:
  801d71:	55                   	push   %rbp
  801d72:	48 89 e5             	mov    %rsp,%rbp
  801d75:	48 83 ec 30          	sub    $0x30,%rsp
  801d79:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801d7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801d81:	48 8b 00             	mov    (%rax),%rax
  801d84:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801d88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801d8c:	48 8b 40 08          	mov    0x8(%rax),%rax
  801d90:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801d93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d96:	83 e0 02             	and    $0x2,%eax
  801d99:	85 c0                	test   %eax,%eax
  801d9b:	75 40                	jne    801ddd <pgfault+0x6c>
  801d9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801da1:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801da8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801dac:	49 89 d0             	mov    %rdx,%r8
  801daf:	48 89 c1             	mov    %rax,%rcx
  801db2:	48 ba 98 4d 80 00 00 	movabs $0x804d98,%rdx
  801db9:	00 00 00 
  801dbc:	be 1f 00 00 00       	mov    $0x1f,%esi
  801dc1:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  801dc8:	00 00 00 
  801dcb:	b8 00 00 00 00       	mov    $0x0,%eax
  801dd0:	49 b9 74 02 80 00 00 	movabs $0x800274,%r9
  801dd7:	00 00 00 
  801dda:	41 ff d1             	callq  *%r9
  801ddd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801de1:	48 c1 e8 0c          	shr    $0xc,%rax
  801de5:	48 89 c2             	mov    %rax,%rdx
  801de8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801def:	01 00 00 
  801df2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801df6:	25 07 08 00 00       	and    $0x807,%eax
  801dfb:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  801e01:	74 4e                	je     801e51 <pgfault+0xe0>
  801e03:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801e07:	48 c1 e8 0c          	shr    $0xc,%rax
  801e0b:	48 89 c2             	mov    %rax,%rdx
  801e0e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801e15:	01 00 00 
  801e18:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801e1c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801e20:	49 89 d0             	mov    %rdx,%r8
  801e23:	48 89 c1             	mov    %rax,%rcx
  801e26:	48 ba c0 4d 80 00 00 	movabs $0x804dc0,%rdx
  801e2d:	00 00 00 
  801e30:	be 22 00 00 00       	mov    $0x22,%esi
  801e35:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  801e3c:	00 00 00 
  801e3f:	b8 00 00 00 00       	mov    $0x0,%eax
  801e44:	49 b9 74 02 80 00 00 	movabs $0x800274,%r9
  801e4b:	00 00 00 
  801e4e:	41 ff d1             	callq  *%r9
  801e51:	ba 07 00 00 00       	mov    $0x7,%edx
  801e56:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801e5b:	bf 00 00 00 00       	mov    $0x0,%edi
  801e60:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  801e67:	00 00 00 
  801e6a:	ff d0                	callq  *%rax
  801e6c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801e6f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801e73:	79 30                	jns    801ea5 <pgfault+0x134>
  801e75:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e78:	89 c1                	mov    %eax,%ecx
  801e7a:	48 ba eb 4d 80 00 00 	movabs $0x804deb,%rdx
  801e81:	00 00 00 
  801e84:	be 30 00 00 00       	mov    $0x30,%esi
  801e89:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  801e90:	00 00 00 
  801e93:	b8 00 00 00 00       	mov    $0x0,%eax
  801e98:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  801e9f:	00 00 00 
  801ea2:	41 ff d0             	callq  *%r8
  801ea5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ea9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ead:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801eb1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  801eb7:	ba 00 10 00 00       	mov    $0x1000,%edx
  801ebc:	48 89 c6             	mov    %rax,%rsi
  801ebf:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  801ec4:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  801ecb:	00 00 00 
  801ece:	ff d0                	callq  *%rax
  801ed0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ed4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801ed8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801edc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  801ee2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  801ee8:	48 89 c1             	mov    %rax,%rcx
  801eeb:	ba 00 00 00 00       	mov    $0x0,%edx
  801ef0:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801ef5:	bf 00 00 00 00       	mov    $0x0,%edi
  801efa:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  801f01:	00 00 00 
  801f04:	ff d0                	callq  *%rax
  801f06:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801f09:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801f0d:	79 30                	jns    801f3f <pgfault+0x1ce>
  801f0f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f12:	89 c1                	mov    %eax,%ecx
  801f14:	48 ba fe 4d 80 00 00 	movabs $0x804dfe,%rdx
  801f1b:	00 00 00 
  801f1e:	be 35 00 00 00       	mov    $0x35,%esi
  801f23:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  801f2a:	00 00 00 
  801f2d:	b8 00 00 00 00       	mov    $0x0,%eax
  801f32:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  801f39:	00 00 00 
  801f3c:	41 ff d0             	callq  *%r8
  801f3f:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801f44:	bf 00 00 00 00       	mov    $0x0,%edi
  801f49:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  801f50:	00 00 00 
  801f53:	ff d0                	callq  *%rax
  801f55:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801f58:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801f5c:	79 30                	jns    801f8e <pgfault+0x21d>
  801f5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f61:	89 c1                	mov    %eax,%ecx
  801f63:	48 ba 0f 4e 80 00 00 	movabs $0x804e0f,%rdx
  801f6a:	00 00 00 
  801f6d:	be 39 00 00 00       	mov    $0x39,%esi
  801f72:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  801f79:	00 00 00 
  801f7c:	b8 00 00 00 00       	mov    $0x0,%eax
  801f81:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  801f88:	00 00 00 
  801f8b:	41 ff d0             	callq  *%r8
  801f8e:	c9                   	leaveq 
  801f8f:	c3                   	retq   

0000000000801f90 <duppage>:
  801f90:	55                   	push   %rbp
  801f91:	48 89 e5             	mov    %rsp,%rbp
  801f94:	48 83 ec 30          	sub    $0x30,%rsp
  801f98:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801f9b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801f9e:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801fa1:	c1 e0 0c             	shl    $0xc,%eax
  801fa4:	89 c0                	mov    %eax,%eax
  801fa6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801faa:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fb1:	01 00 00 
  801fb4:	8b 55 d8             	mov    -0x28(%rbp),%edx
  801fb7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fbb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801fbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fc3:	25 02 08 00 00       	and    $0x802,%eax
  801fc8:	48 85 c0             	test   %rax,%rax
  801fcb:	74 0e                	je     801fdb <duppage+0x4b>
  801fcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fd1:	25 00 04 00 00       	and    $0x400,%eax
  801fd6:	48 85 c0             	test   %rax,%rax
  801fd9:	74 70                	je     80204b <duppage+0xbb>
  801fdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fdf:	25 07 0e 00 00       	and    $0xe07,%eax
  801fe4:	89 c6                	mov    %eax,%esi
  801fe6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  801fea:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801fed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ff1:	41 89 f0             	mov    %esi,%r8d
  801ff4:	48 89 c6             	mov    %rax,%rsi
  801ff7:	bf 00 00 00 00       	mov    $0x0,%edi
  801ffc:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  802003:	00 00 00 
  802006:	ff d0                	callq  *%rax
  802008:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80200b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80200f:	79 30                	jns    802041 <duppage+0xb1>
  802011:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802014:	89 c1                	mov    %eax,%ecx
  802016:	48 ba fe 4d 80 00 00 	movabs $0x804dfe,%rdx
  80201d:	00 00 00 
  802020:	be 63 00 00 00       	mov    $0x63,%esi
  802025:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  80202c:	00 00 00 
  80202f:	b8 00 00 00 00       	mov    $0x0,%eax
  802034:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80203b:	00 00 00 
  80203e:	41 ff d0             	callq  *%r8
  802041:	b8 00 00 00 00       	mov    $0x0,%eax
  802046:	e9 c4 00 00 00       	jmpq   80210f <duppage+0x17f>
  80204b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  80204f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802056:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  80205c:	48 89 c6             	mov    %rax,%rsi
  80205f:	bf 00 00 00 00       	mov    $0x0,%edi
  802064:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  80206b:	00 00 00 
  80206e:	ff d0                	callq  *%rax
  802070:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802073:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802077:	79 30                	jns    8020a9 <duppage+0x119>
  802079:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80207c:	89 c1                	mov    %eax,%ecx
  80207e:	48 ba fe 4d 80 00 00 	movabs $0x804dfe,%rdx
  802085:	00 00 00 
  802088:	be 7e 00 00 00       	mov    $0x7e,%esi
  80208d:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  802094:	00 00 00 
  802097:	b8 00 00 00 00       	mov    $0x0,%eax
  80209c:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8020a3:	00 00 00 
  8020a6:	41 ff d0             	callq  *%r8
  8020a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8020ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8020b1:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8020b7:	48 89 d1             	mov    %rdx,%rcx
  8020ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8020bf:	48 89 c6             	mov    %rax,%rsi
  8020c2:	bf 00 00 00 00       	mov    $0x0,%edi
  8020c7:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  8020ce:	00 00 00 
  8020d1:	ff d0                	callq  *%rax
  8020d3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8020d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8020da:	79 30                	jns    80210c <duppage+0x17c>
  8020dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8020df:	89 c1                	mov    %eax,%ecx
  8020e1:	48 ba fe 4d 80 00 00 	movabs $0x804dfe,%rdx
  8020e8:	00 00 00 
  8020eb:	be 80 00 00 00       	mov    $0x80,%esi
  8020f0:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  8020f7:	00 00 00 
  8020fa:	b8 00 00 00 00       	mov    $0x0,%eax
  8020ff:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  802106:	00 00 00 
  802109:	41 ff d0             	callq  *%r8
  80210c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80210f:	c9                   	leaveq 
  802110:	c3                   	retq   

0000000000802111 <fork>:
  802111:	55                   	push   %rbp
  802112:	48 89 e5             	mov    %rsp,%rbp
  802115:	48 83 ec 20          	sub    $0x20,%rsp
  802119:	48 bf 71 1d 80 00 00 	movabs $0x801d71,%rdi
  802120:	00 00 00 
  802123:	48 b8 77 46 80 00 00 	movabs $0x804677,%rax
  80212a:	00 00 00 
  80212d:	ff d0                	callq  *%rax
  80212f:	b8 07 00 00 00       	mov    $0x7,%eax
  802134:	cd 30                	int    $0x30
  802136:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802139:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80213c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80213f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802143:	79 08                	jns    80214d <fork+0x3c>
  802145:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802148:	e9 09 02 00 00       	jmpq   802356 <fork+0x245>
  80214d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802151:	75 3e                	jne    802191 <fork+0x80>
  802153:	48 b8 15 19 80 00 00 	movabs $0x801915,%rax
  80215a:	00 00 00 
  80215d:	ff d0                	callq  *%rax
  80215f:	25 ff 03 00 00       	and    $0x3ff,%eax
  802164:	48 98                	cltq   
  802166:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80216d:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802174:	00 00 00 
  802177:	48 01 c2             	add    %rax,%rdx
  80217a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802181:	00 00 00 
  802184:	48 89 10             	mov    %rdx,(%rax)
  802187:	b8 00 00 00 00       	mov    $0x0,%eax
  80218c:	e9 c5 01 00 00       	jmpq   802356 <fork+0x245>
  802191:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802198:	e9 a4 00 00 00       	jmpq   802241 <fork+0x130>
  80219d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021a0:	c1 f8 12             	sar    $0x12,%eax
  8021a3:	89 c2                	mov    %eax,%edx
  8021a5:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  8021ac:	01 00 00 
  8021af:	48 63 d2             	movslq %edx,%rdx
  8021b2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021b6:	83 e0 01             	and    $0x1,%eax
  8021b9:	48 85 c0             	test   %rax,%rax
  8021bc:	74 21                	je     8021df <fork+0xce>
  8021be:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021c1:	c1 f8 09             	sar    $0x9,%eax
  8021c4:	89 c2                	mov    %eax,%edx
  8021c6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8021cd:	01 00 00 
  8021d0:	48 63 d2             	movslq %edx,%rdx
  8021d3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021d7:	83 e0 01             	and    $0x1,%eax
  8021da:	48 85 c0             	test   %rax,%rax
  8021dd:	75 09                	jne    8021e8 <fork+0xd7>
  8021df:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  8021e6:	eb 59                	jmp    802241 <fork+0x130>
  8021e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021eb:	05 00 02 00 00       	add    $0x200,%eax
  8021f0:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8021f3:	eb 44                	jmp    802239 <fork+0x128>
  8021f5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021fc:	01 00 00 
  8021ff:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802202:	48 63 d2             	movslq %edx,%rdx
  802205:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802209:	83 e0 05             	and    $0x5,%eax
  80220c:	48 83 f8 05          	cmp    $0x5,%rax
  802210:	74 02                	je     802214 <fork+0x103>
  802212:	eb 21                	jmp    802235 <fork+0x124>
  802214:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  80221b:	75 02                	jne    80221f <fork+0x10e>
  80221d:	eb 16                	jmp    802235 <fork+0x124>
  80221f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802222:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802225:	89 d6                	mov    %edx,%esi
  802227:	89 c7                	mov    %eax,%edi
  802229:	48 b8 90 1f 80 00 00 	movabs $0x801f90,%rax
  802230:	00 00 00 
  802233:	ff d0                	callq  *%rax
  802235:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802239:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80223c:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  80223f:	7c b4                	jl     8021f5 <fork+0xe4>
  802241:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802244:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  802249:	0f 86 4e ff ff ff    	jbe    80219d <fork+0x8c>
  80224f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802252:	ba 07 00 00 00       	mov    $0x7,%edx
  802257:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  80225c:	89 c7                	mov    %eax,%edi
  80225e:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  802265:	00 00 00 
  802268:	ff d0                	callq  *%rax
  80226a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80226d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802271:	79 30                	jns    8022a3 <fork+0x192>
  802273:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802276:	89 c1                	mov    %eax,%ecx
  802278:	48 ba 28 4e 80 00 00 	movabs $0x804e28,%rdx
  80227f:	00 00 00 
  802282:	be bc 00 00 00       	mov    $0xbc,%esi
  802287:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  80228e:	00 00 00 
  802291:	b8 00 00 00 00       	mov    $0x0,%eax
  802296:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80229d:	00 00 00 
  8022a0:	41 ff d0             	callq  *%r8
  8022a3:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8022aa:	00 00 00 
  8022ad:	48 8b 00             	mov    (%rax),%rax
  8022b0:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  8022b7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022ba:	48 89 d6             	mov    %rdx,%rsi
  8022bd:	89 c7                	mov    %eax,%edi
  8022bf:	48 b8 1b 1b 80 00 00 	movabs $0x801b1b,%rax
  8022c6:	00 00 00 
  8022c9:	ff d0                	callq  *%rax
  8022cb:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8022ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8022d2:	79 30                	jns    802304 <fork+0x1f3>
  8022d4:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8022d7:	89 c1                	mov    %eax,%ecx
  8022d9:	48 ba 48 4e 80 00 00 	movabs $0x804e48,%rdx
  8022e0:	00 00 00 
  8022e3:	be c0 00 00 00       	mov    $0xc0,%esi
  8022e8:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  8022ef:	00 00 00 
  8022f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8022f7:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8022fe:	00 00 00 
  802301:	41 ff d0             	callq  *%r8
  802304:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802307:	be 02 00 00 00       	mov    $0x2,%esi
  80230c:	89 c7                	mov    %eax,%edi
  80230e:	48 b8 86 1a 80 00 00 	movabs $0x801a86,%rax
  802315:	00 00 00 
  802318:	ff d0                	callq  *%rax
  80231a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80231d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802321:	79 30                	jns    802353 <fork+0x242>
  802323:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802326:	89 c1                	mov    %eax,%ecx
  802328:	48 ba 67 4e 80 00 00 	movabs $0x804e67,%rdx
  80232f:	00 00 00 
  802332:	be c5 00 00 00       	mov    $0xc5,%esi
  802337:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  80233e:	00 00 00 
  802341:	b8 00 00 00 00       	mov    $0x0,%eax
  802346:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80234d:	00 00 00 
  802350:	41 ff d0             	callq  *%r8
  802353:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802356:	c9                   	leaveq 
  802357:	c3                   	retq   

0000000000802358 <sfork>:
  802358:	55                   	push   %rbp
  802359:	48 89 e5             	mov    %rsp,%rbp
  80235c:	48 ba 7e 4e 80 00 00 	movabs $0x804e7e,%rdx
  802363:	00 00 00 
  802366:	be d2 00 00 00       	mov    $0xd2,%esi
  80236b:	48 bf b1 4d 80 00 00 	movabs $0x804db1,%rdi
  802372:	00 00 00 
  802375:	b8 00 00 00 00       	mov    $0x0,%eax
  80237a:	48 b9 74 02 80 00 00 	movabs $0x800274,%rcx
  802381:	00 00 00 
  802384:	ff d1                	callq  *%rcx

0000000000802386 <ipc_recv>:
  802386:	55                   	push   %rbp
  802387:	48 89 e5             	mov    %rsp,%rbp
  80238a:	48 83 ec 30          	sub    $0x30,%rsp
  80238e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802392:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802396:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80239a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80239f:	75 0e                	jne    8023af <ipc_recv+0x29>
  8023a1:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8023a8:	00 00 00 
  8023ab:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8023af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8023b3:	48 89 c7             	mov    %rax,%rdi
  8023b6:	48 b8 ba 1b 80 00 00 	movabs $0x801bba,%rax
  8023bd:	00 00 00 
  8023c0:	ff d0                	callq  *%rax
  8023c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023c9:	79 27                	jns    8023f2 <ipc_recv+0x6c>
  8023cb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8023d0:	74 0a                	je     8023dc <ipc_recv+0x56>
  8023d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8023d6:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8023dc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8023e1:	74 0a                	je     8023ed <ipc_recv+0x67>
  8023e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023e7:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8023ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023f0:	eb 53                	jmp    802445 <ipc_recv+0xbf>
  8023f2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8023f7:	74 19                	je     802412 <ipc_recv+0x8c>
  8023f9:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802400:	00 00 00 
  802403:	48 8b 00             	mov    (%rax),%rax
  802406:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80240c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802410:	89 10                	mov    %edx,(%rax)
  802412:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802417:	74 19                	je     802432 <ipc_recv+0xac>
  802419:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802420:	00 00 00 
  802423:	48 8b 00             	mov    (%rax),%rax
  802426:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80242c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802430:	89 10                	mov    %edx,(%rax)
  802432:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802439:	00 00 00 
  80243c:	48 8b 00             	mov    (%rax),%rax
  80243f:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  802445:	c9                   	leaveq 
  802446:	c3                   	retq   

0000000000802447 <ipc_send>:
  802447:	55                   	push   %rbp
  802448:	48 89 e5             	mov    %rsp,%rbp
  80244b:	48 83 ec 30          	sub    $0x30,%rsp
  80244f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802452:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802455:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802459:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80245c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802461:	75 10                	jne    802473 <ipc_send+0x2c>
  802463:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80246a:	00 00 00 
  80246d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802471:	eb 0e                	jmp    802481 <ipc_send+0x3a>
  802473:	eb 0c                	jmp    802481 <ipc_send+0x3a>
  802475:	48 b8 53 19 80 00 00 	movabs $0x801953,%rax
  80247c:	00 00 00 
  80247f:	ff d0                	callq  *%rax
  802481:	8b 75 e8             	mov    -0x18(%rbp),%esi
  802484:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  802487:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80248b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80248e:	89 c7                	mov    %eax,%edi
  802490:	48 b8 65 1b 80 00 00 	movabs $0x801b65,%rax
  802497:	00 00 00 
  80249a:	ff d0                	callq  *%rax
  80249c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80249f:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8024a3:	74 d0                	je     802475 <ipc_send+0x2e>
  8024a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8024a9:	79 30                	jns    8024db <ipc_send+0x94>
  8024ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024ae:	89 c1                	mov    %eax,%ecx
  8024b0:	48 ba 98 4e 80 00 00 	movabs $0x804e98,%rdx
  8024b7:	00 00 00 
  8024ba:	be 44 00 00 00       	mov    $0x44,%esi
  8024bf:	48 bf ae 4e 80 00 00 	movabs $0x804eae,%rdi
  8024c6:	00 00 00 
  8024c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8024ce:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8024d5:	00 00 00 
  8024d8:	41 ff d0             	callq  *%r8
  8024db:	c9                   	leaveq 
  8024dc:	c3                   	retq   

00000000008024dd <ipc_host_recv>:
  8024dd:	55                   	push   %rbp
  8024de:	48 89 e5             	mov    %rsp,%rbp
  8024e1:	48 83 ec 10          	sub    $0x10,%rsp
  8024e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024e9:	48 ba c0 4e 80 00 00 	movabs $0x804ec0,%rdx
  8024f0:	00 00 00 
  8024f3:	be 4e 00 00 00       	mov    $0x4e,%esi
  8024f8:	48 bf ae 4e 80 00 00 	movabs $0x804eae,%rdi
  8024ff:	00 00 00 
  802502:	b8 00 00 00 00       	mov    $0x0,%eax
  802507:	48 b9 74 02 80 00 00 	movabs $0x800274,%rcx
  80250e:	00 00 00 
  802511:	ff d1                	callq  *%rcx

0000000000802513 <ipc_host_send>:
  802513:	55                   	push   %rbp
  802514:	48 89 e5             	mov    %rsp,%rbp
  802517:	48 83 ec 20          	sub    $0x20,%rsp
  80251b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80251e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802521:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  802525:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  802528:	48 ba e0 4e 80 00 00 	movabs $0x804ee0,%rdx
  80252f:	00 00 00 
  802532:	be 67 00 00 00       	mov    $0x67,%esi
  802537:	48 bf ae 4e 80 00 00 	movabs $0x804eae,%rdi
  80253e:	00 00 00 
  802541:	b8 00 00 00 00       	mov    $0x0,%eax
  802546:	48 b9 74 02 80 00 00 	movabs $0x800274,%rcx
  80254d:	00 00 00 
  802550:	ff d1                	callq  *%rcx

0000000000802552 <ipc_find_env>:
  802552:	55                   	push   %rbp
  802553:	48 89 e5             	mov    %rsp,%rbp
  802556:	48 83 ec 14          	sub    $0x14,%rsp
  80255a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80255d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802564:	eb 4e                	jmp    8025b4 <ipc_find_env+0x62>
  802566:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80256d:	00 00 00 
  802570:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802573:	48 98                	cltq   
  802575:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80257c:	48 01 d0             	add    %rdx,%rax
  80257f:	48 05 d0 00 00 00    	add    $0xd0,%rax
  802585:	8b 00                	mov    (%rax),%eax
  802587:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80258a:	75 24                	jne    8025b0 <ipc_find_env+0x5e>
  80258c:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802593:	00 00 00 
  802596:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802599:	48 98                	cltq   
  80259b:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8025a2:	48 01 d0             	add    %rdx,%rax
  8025a5:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8025ab:	8b 40 08             	mov    0x8(%rax),%eax
  8025ae:	eb 12                	jmp    8025c2 <ipc_find_env+0x70>
  8025b0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8025b4:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8025bb:	7e a9                	jle    802566 <ipc_find_env+0x14>
  8025bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8025c2:	c9                   	leaveq 
  8025c3:	c3                   	retq   

00000000008025c4 <fd2num>:
  8025c4:	55                   	push   %rbp
  8025c5:	48 89 e5             	mov    %rsp,%rbp
  8025c8:	48 83 ec 08          	sub    $0x8,%rsp
  8025cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8025d0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8025d4:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8025db:	ff ff ff 
  8025de:	48 01 d0             	add    %rdx,%rax
  8025e1:	48 c1 e8 0c          	shr    $0xc,%rax
  8025e5:	c9                   	leaveq 
  8025e6:	c3                   	retq   

00000000008025e7 <fd2data>:
  8025e7:	55                   	push   %rbp
  8025e8:	48 89 e5             	mov    %rsp,%rbp
  8025eb:	48 83 ec 08          	sub    $0x8,%rsp
  8025ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8025f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025f7:	48 89 c7             	mov    %rax,%rdi
  8025fa:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  802601:	00 00 00 
  802604:	ff d0                	callq  *%rax
  802606:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  80260c:	48 c1 e0 0c          	shl    $0xc,%rax
  802610:	c9                   	leaveq 
  802611:	c3                   	retq   

0000000000802612 <fd_alloc>:
  802612:	55                   	push   %rbp
  802613:	48 89 e5             	mov    %rsp,%rbp
  802616:	48 83 ec 18          	sub    $0x18,%rsp
  80261a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80261e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802625:	eb 6b                	jmp    802692 <fd_alloc+0x80>
  802627:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80262a:	48 98                	cltq   
  80262c:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802632:	48 c1 e0 0c          	shl    $0xc,%rax
  802636:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80263a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80263e:	48 c1 e8 15          	shr    $0x15,%rax
  802642:	48 89 c2             	mov    %rax,%rdx
  802645:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80264c:	01 00 00 
  80264f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802653:	83 e0 01             	and    $0x1,%eax
  802656:	48 85 c0             	test   %rax,%rax
  802659:	74 21                	je     80267c <fd_alloc+0x6a>
  80265b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80265f:	48 c1 e8 0c          	shr    $0xc,%rax
  802663:	48 89 c2             	mov    %rax,%rdx
  802666:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80266d:	01 00 00 
  802670:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802674:	83 e0 01             	and    $0x1,%eax
  802677:	48 85 c0             	test   %rax,%rax
  80267a:	75 12                	jne    80268e <fd_alloc+0x7c>
  80267c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802680:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802684:	48 89 10             	mov    %rdx,(%rax)
  802687:	b8 00 00 00 00       	mov    $0x0,%eax
  80268c:	eb 1a                	jmp    8026a8 <fd_alloc+0x96>
  80268e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802692:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802696:	7e 8f                	jle    802627 <fd_alloc+0x15>
  802698:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80269c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8026a3:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8026a8:	c9                   	leaveq 
  8026a9:	c3                   	retq   

00000000008026aa <fd_lookup>:
  8026aa:	55                   	push   %rbp
  8026ab:	48 89 e5             	mov    %rsp,%rbp
  8026ae:	48 83 ec 20          	sub    $0x20,%rsp
  8026b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8026b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8026b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8026bd:	78 06                	js     8026c5 <fd_lookup+0x1b>
  8026bf:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8026c3:	7e 07                	jle    8026cc <fd_lookup+0x22>
  8026c5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8026ca:	eb 6c                	jmp    802738 <fd_lookup+0x8e>
  8026cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8026cf:	48 98                	cltq   
  8026d1:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8026d7:	48 c1 e0 0c          	shl    $0xc,%rax
  8026db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8026df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8026e3:	48 c1 e8 15          	shr    $0x15,%rax
  8026e7:	48 89 c2             	mov    %rax,%rdx
  8026ea:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8026f1:	01 00 00 
  8026f4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8026f8:	83 e0 01             	and    $0x1,%eax
  8026fb:	48 85 c0             	test   %rax,%rax
  8026fe:	74 21                	je     802721 <fd_lookup+0x77>
  802700:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802704:	48 c1 e8 0c          	shr    $0xc,%rax
  802708:	48 89 c2             	mov    %rax,%rdx
  80270b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802712:	01 00 00 
  802715:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802719:	83 e0 01             	and    $0x1,%eax
  80271c:	48 85 c0             	test   %rax,%rax
  80271f:	75 07                	jne    802728 <fd_lookup+0x7e>
  802721:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802726:	eb 10                	jmp    802738 <fd_lookup+0x8e>
  802728:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80272c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802730:	48 89 10             	mov    %rdx,(%rax)
  802733:	b8 00 00 00 00       	mov    $0x0,%eax
  802738:	c9                   	leaveq 
  802739:	c3                   	retq   

000000000080273a <fd_close>:
  80273a:	55                   	push   %rbp
  80273b:	48 89 e5             	mov    %rsp,%rbp
  80273e:	48 83 ec 30          	sub    $0x30,%rsp
  802742:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802746:	89 f0                	mov    %esi,%eax
  802748:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80274b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80274f:	48 89 c7             	mov    %rax,%rdi
  802752:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  802759:	00 00 00 
  80275c:	ff d0                	callq  *%rax
  80275e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802762:	48 89 d6             	mov    %rdx,%rsi
  802765:	89 c7                	mov    %eax,%edi
  802767:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  80276e:	00 00 00 
  802771:	ff d0                	callq  *%rax
  802773:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802776:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80277a:	78 0a                	js     802786 <fd_close+0x4c>
  80277c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802780:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  802784:	74 12                	je     802798 <fd_close+0x5e>
  802786:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  80278a:	74 05                	je     802791 <fd_close+0x57>
  80278c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80278f:	eb 05                	jmp    802796 <fd_close+0x5c>
  802791:	b8 00 00 00 00       	mov    $0x0,%eax
  802796:	eb 69                	jmp    802801 <fd_close+0xc7>
  802798:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80279c:	8b 00                	mov    (%rax),%eax
  80279e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8027a2:	48 89 d6             	mov    %rdx,%rsi
  8027a5:	89 c7                	mov    %eax,%edi
  8027a7:	48 b8 03 28 80 00 00 	movabs $0x802803,%rax
  8027ae:	00 00 00 
  8027b1:	ff d0                	callq  *%rax
  8027b3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027ba:	78 2a                	js     8027e6 <fd_close+0xac>
  8027bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027c0:	48 8b 40 20          	mov    0x20(%rax),%rax
  8027c4:	48 85 c0             	test   %rax,%rax
  8027c7:	74 16                	je     8027df <fd_close+0xa5>
  8027c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027cd:	48 8b 40 20          	mov    0x20(%rax),%rax
  8027d1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8027d5:	48 89 d7             	mov    %rdx,%rdi
  8027d8:	ff d0                	callq  *%rax
  8027da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027dd:	eb 07                	jmp    8027e6 <fd_close+0xac>
  8027df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8027e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027ea:	48 89 c6             	mov    %rax,%rsi
  8027ed:	bf 00 00 00 00       	mov    $0x0,%edi
  8027f2:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  8027f9:	00 00 00 
  8027fc:	ff d0                	callq  *%rax
  8027fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802801:	c9                   	leaveq 
  802802:	c3                   	retq   

0000000000802803 <dev_lookup>:
  802803:	55                   	push   %rbp
  802804:	48 89 e5             	mov    %rsp,%rbp
  802807:	48 83 ec 20          	sub    $0x20,%rsp
  80280b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80280e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802812:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802819:	eb 41                	jmp    80285c <dev_lookup+0x59>
  80281b:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802822:	00 00 00 
  802825:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802828:	48 63 d2             	movslq %edx,%rdx
  80282b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80282f:	8b 00                	mov    (%rax),%eax
  802831:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802834:	75 22                	jne    802858 <dev_lookup+0x55>
  802836:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80283d:	00 00 00 
  802840:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802843:	48 63 d2             	movslq %edx,%rdx
  802846:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80284a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80284e:	48 89 10             	mov    %rdx,(%rax)
  802851:	b8 00 00 00 00       	mov    $0x0,%eax
  802856:	eb 60                	jmp    8028b8 <dev_lookup+0xb5>
  802858:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80285c:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802863:	00 00 00 
  802866:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802869:	48 63 d2             	movslq %edx,%rdx
  80286c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802870:	48 85 c0             	test   %rax,%rax
  802873:	75 a6                	jne    80281b <dev_lookup+0x18>
  802875:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80287c:	00 00 00 
  80287f:	48 8b 00             	mov    (%rax),%rax
  802882:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802888:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80288b:	89 c6                	mov    %eax,%esi
  80288d:	48 bf 00 4f 80 00 00 	movabs $0x804f00,%rdi
  802894:	00 00 00 
  802897:	b8 00 00 00 00       	mov    $0x0,%eax
  80289c:	48 b9 ad 04 80 00 00 	movabs $0x8004ad,%rcx
  8028a3:	00 00 00 
  8028a6:	ff d1                	callq  *%rcx
  8028a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028ac:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8028b3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8028b8:	c9                   	leaveq 
  8028b9:	c3                   	retq   

00000000008028ba <close>:
  8028ba:	55                   	push   %rbp
  8028bb:	48 89 e5             	mov    %rsp,%rbp
  8028be:	48 83 ec 20          	sub    $0x20,%rsp
  8028c2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8028c5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028cc:	48 89 d6             	mov    %rdx,%rsi
  8028cf:	89 c7                	mov    %eax,%edi
  8028d1:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  8028d8:	00 00 00 
  8028db:	ff d0                	callq  *%rax
  8028dd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028e4:	79 05                	jns    8028eb <close+0x31>
  8028e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028e9:	eb 18                	jmp    802903 <close+0x49>
  8028eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028ef:	be 01 00 00 00       	mov    $0x1,%esi
  8028f4:	48 89 c7             	mov    %rax,%rdi
  8028f7:	48 b8 3a 27 80 00 00 	movabs $0x80273a,%rax
  8028fe:	00 00 00 
  802901:	ff d0                	callq  *%rax
  802903:	c9                   	leaveq 
  802904:	c3                   	retq   

0000000000802905 <close_all>:
  802905:	55                   	push   %rbp
  802906:	48 89 e5             	mov    %rsp,%rbp
  802909:	48 83 ec 10          	sub    $0x10,%rsp
  80290d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802914:	eb 15                	jmp    80292b <close_all+0x26>
  802916:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802919:	89 c7                	mov    %eax,%edi
  80291b:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  802922:	00 00 00 
  802925:	ff d0                	callq  *%rax
  802927:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80292b:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80292f:	7e e5                	jle    802916 <close_all+0x11>
  802931:	c9                   	leaveq 
  802932:	c3                   	retq   

0000000000802933 <dup>:
  802933:	55                   	push   %rbp
  802934:	48 89 e5             	mov    %rsp,%rbp
  802937:	48 83 ec 40          	sub    $0x40,%rsp
  80293b:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80293e:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802941:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802945:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802948:	48 89 d6             	mov    %rdx,%rsi
  80294b:	89 c7                	mov    %eax,%edi
  80294d:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802954:	00 00 00 
  802957:	ff d0                	callq  *%rax
  802959:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80295c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802960:	79 08                	jns    80296a <dup+0x37>
  802962:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802965:	e9 70 01 00 00       	jmpq   802ada <dup+0x1a7>
  80296a:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80296d:	89 c7                	mov    %eax,%edi
  80296f:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  802976:	00 00 00 
  802979:	ff d0                	callq  *%rax
  80297b:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80297e:	48 98                	cltq   
  802980:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802986:	48 c1 e0 0c          	shl    $0xc,%rax
  80298a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80298e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802992:	48 89 c7             	mov    %rax,%rdi
  802995:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  80299c:	00 00 00 
  80299f:	ff d0                	callq  *%rax
  8029a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8029a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029a9:	48 89 c7             	mov    %rax,%rdi
  8029ac:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  8029b3:	00 00 00 
  8029b6:	ff d0                	callq  *%rax
  8029b8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8029bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029c0:	48 c1 e8 15          	shr    $0x15,%rax
  8029c4:	48 89 c2             	mov    %rax,%rdx
  8029c7:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8029ce:	01 00 00 
  8029d1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029d5:	83 e0 01             	and    $0x1,%eax
  8029d8:	48 85 c0             	test   %rax,%rax
  8029db:	74 73                	je     802a50 <dup+0x11d>
  8029dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029e1:	48 c1 e8 0c          	shr    $0xc,%rax
  8029e5:	48 89 c2             	mov    %rax,%rdx
  8029e8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8029ef:	01 00 00 
  8029f2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029f6:	83 e0 01             	and    $0x1,%eax
  8029f9:	48 85 c0             	test   %rax,%rax
  8029fc:	74 52                	je     802a50 <dup+0x11d>
  8029fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a02:	48 c1 e8 0c          	shr    $0xc,%rax
  802a06:	48 89 c2             	mov    %rax,%rdx
  802a09:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a10:	01 00 00 
  802a13:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a17:	25 07 0e 00 00       	and    $0xe07,%eax
  802a1c:	89 c1                	mov    %eax,%ecx
  802a1e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802a22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a26:	41 89 c8             	mov    %ecx,%r8d
  802a29:	48 89 d1             	mov    %rdx,%rcx
  802a2c:	ba 00 00 00 00       	mov    $0x0,%edx
  802a31:	48 89 c6             	mov    %rax,%rsi
  802a34:	bf 00 00 00 00       	mov    $0x0,%edi
  802a39:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  802a40:	00 00 00 
  802a43:	ff d0                	callq  *%rax
  802a45:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a48:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a4c:	79 02                	jns    802a50 <dup+0x11d>
  802a4e:	eb 57                	jmp    802aa7 <dup+0x174>
  802a50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802a54:	48 c1 e8 0c          	shr    $0xc,%rax
  802a58:	48 89 c2             	mov    %rax,%rdx
  802a5b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a62:	01 00 00 
  802a65:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a69:	25 07 0e 00 00       	and    $0xe07,%eax
  802a6e:	89 c1                	mov    %eax,%ecx
  802a70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802a74:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a78:	41 89 c8             	mov    %ecx,%r8d
  802a7b:	48 89 d1             	mov    %rdx,%rcx
  802a7e:	ba 00 00 00 00       	mov    $0x0,%edx
  802a83:	48 89 c6             	mov    %rax,%rsi
  802a86:	bf 00 00 00 00       	mov    $0x0,%edi
  802a8b:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  802a92:	00 00 00 
  802a95:	ff d0                	callq  *%rax
  802a97:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a9a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a9e:	79 02                	jns    802aa2 <dup+0x16f>
  802aa0:	eb 05                	jmp    802aa7 <dup+0x174>
  802aa2:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802aa5:	eb 33                	jmp    802ada <dup+0x1a7>
  802aa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802aab:	48 89 c6             	mov    %rax,%rsi
  802aae:	bf 00 00 00 00       	mov    $0x0,%edi
  802ab3:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  802aba:	00 00 00 
  802abd:	ff d0                	callq  *%rax
  802abf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ac3:	48 89 c6             	mov    %rax,%rsi
  802ac6:	bf 00 00 00 00       	mov    $0x0,%edi
  802acb:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  802ad2:	00 00 00 
  802ad5:	ff d0                	callq  *%rax
  802ad7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ada:	c9                   	leaveq 
  802adb:	c3                   	retq   

0000000000802adc <read>:
  802adc:	55                   	push   %rbp
  802add:	48 89 e5             	mov    %rsp,%rbp
  802ae0:	48 83 ec 40          	sub    $0x40,%rsp
  802ae4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802ae7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802aeb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802aef:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802af3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802af6:	48 89 d6             	mov    %rdx,%rsi
  802af9:	89 c7                	mov    %eax,%edi
  802afb:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802b02:	00 00 00 
  802b05:	ff d0                	callq  *%rax
  802b07:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b0a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b0e:	78 24                	js     802b34 <read+0x58>
  802b10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b14:	8b 00                	mov    (%rax),%eax
  802b16:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b1a:	48 89 d6             	mov    %rdx,%rsi
  802b1d:	89 c7                	mov    %eax,%edi
  802b1f:	48 b8 03 28 80 00 00 	movabs $0x802803,%rax
  802b26:	00 00 00 
  802b29:	ff d0                	callq  *%rax
  802b2b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b2e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b32:	79 05                	jns    802b39 <read+0x5d>
  802b34:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b37:	eb 76                	jmp    802baf <read+0xd3>
  802b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b3d:	8b 40 08             	mov    0x8(%rax),%eax
  802b40:	83 e0 03             	and    $0x3,%eax
  802b43:	83 f8 01             	cmp    $0x1,%eax
  802b46:	75 3a                	jne    802b82 <read+0xa6>
  802b48:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802b4f:	00 00 00 
  802b52:	48 8b 00             	mov    (%rax),%rax
  802b55:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802b5b:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802b5e:	89 c6                	mov    %eax,%esi
  802b60:	48 bf 1f 4f 80 00 00 	movabs $0x804f1f,%rdi
  802b67:	00 00 00 
  802b6a:	b8 00 00 00 00       	mov    $0x0,%eax
  802b6f:	48 b9 ad 04 80 00 00 	movabs $0x8004ad,%rcx
  802b76:	00 00 00 
  802b79:	ff d1                	callq  *%rcx
  802b7b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802b80:	eb 2d                	jmp    802baf <read+0xd3>
  802b82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b86:	48 8b 40 10          	mov    0x10(%rax),%rax
  802b8a:	48 85 c0             	test   %rax,%rax
  802b8d:	75 07                	jne    802b96 <read+0xba>
  802b8f:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802b94:	eb 19                	jmp    802baf <read+0xd3>
  802b96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b9a:	48 8b 40 10          	mov    0x10(%rax),%rax
  802b9e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ba2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ba6:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802baa:	48 89 cf             	mov    %rcx,%rdi
  802bad:	ff d0                	callq  *%rax
  802baf:	c9                   	leaveq 
  802bb0:	c3                   	retq   

0000000000802bb1 <readn>:
  802bb1:	55                   	push   %rbp
  802bb2:	48 89 e5             	mov    %rsp,%rbp
  802bb5:	48 83 ec 30          	sub    $0x30,%rsp
  802bb9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802bbc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802bc0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802bc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802bcb:	eb 49                	jmp    802c16 <readn+0x65>
  802bcd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802bd0:	48 98                	cltq   
  802bd2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802bd6:	48 29 c2             	sub    %rax,%rdx
  802bd9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802bdc:	48 63 c8             	movslq %eax,%rcx
  802bdf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802be3:	48 01 c1             	add    %rax,%rcx
  802be6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802be9:	48 89 ce             	mov    %rcx,%rsi
  802bec:	89 c7                	mov    %eax,%edi
  802bee:	48 b8 dc 2a 80 00 00 	movabs $0x802adc,%rax
  802bf5:	00 00 00 
  802bf8:	ff d0                	callq  *%rax
  802bfa:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802bfd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802c01:	79 05                	jns    802c08 <readn+0x57>
  802c03:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c06:	eb 1c                	jmp    802c24 <readn+0x73>
  802c08:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802c0c:	75 02                	jne    802c10 <readn+0x5f>
  802c0e:	eb 11                	jmp    802c21 <readn+0x70>
  802c10:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c13:	01 45 fc             	add    %eax,-0x4(%rbp)
  802c16:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c19:	48 98                	cltq   
  802c1b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802c1f:	72 ac                	jb     802bcd <readn+0x1c>
  802c21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c24:	c9                   	leaveq 
  802c25:	c3                   	retq   

0000000000802c26 <write>:
  802c26:	55                   	push   %rbp
  802c27:	48 89 e5             	mov    %rsp,%rbp
  802c2a:	48 83 ec 40          	sub    $0x40,%rsp
  802c2e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c31:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802c35:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802c39:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c3d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c40:	48 89 d6             	mov    %rdx,%rsi
  802c43:	89 c7                	mov    %eax,%edi
  802c45:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802c4c:	00 00 00 
  802c4f:	ff d0                	callq  *%rax
  802c51:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c54:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c58:	78 24                	js     802c7e <write+0x58>
  802c5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c5e:	8b 00                	mov    (%rax),%eax
  802c60:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c64:	48 89 d6             	mov    %rdx,%rsi
  802c67:	89 c7                	mov    %eax,%edi
  802c69:	48 b8 03 28 80 00 00 	movabs $0x802803,%rax
  802c70:	00 00 00 
  802c73:	ff d0                	callq  *%rax
  802c75:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c78:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c7c:	79 05                	jns    802c83 <write+0x5d>
  802c7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c81:	eb 75                	jmp    802cf8 <write+0xd2>
  802c83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c87:	8b 40 08             	mov    0x8(%rax),%eax
  802c8a:	83 e0 03             	and    $0x3,%eax
  802c8d:	85 c0                	test   %eax,%eax
  802c8f:	75 3a                	jne    802ccb <write+0xa5>
  802c91:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802c98:	00 00 00 
  802c9b:	48 8b 00             	mov    (%rax),%rax
  802c9e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802ca4:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802ca7:	89 c6                	mov    %eax,%esi
  802ca9:	48 bf 3b 4f 80 00 00 	movabs $0x804f3b,%rdi
  802cb0:	00 00 00 
  802cb3:	b8 00 00 00 00       	mov    $0x0,%eax
  802cb8:	48 b9 ad 04 80 00 00 	movabs $0x8004ad,%rcx
  802cbf:	00 00 00 
  802cc2:	ff d1                	callq  *%rcx
  802cc4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802cc9:	eb 2d                	jmp    802cf8 <write+0xd2>
  802ccb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ccf:	48 8b 40 18          	mov    0x18(%rax),%rax
  802cd3:	48 85 c0             	test   %rax,%rax
  802cd6:	75 07                	jne    802cdf <write+0xb9>
  802cd8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802cdd:	eb 19                	jmp    802cf8 <write+0xd2>
  802cdf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ce3:	48 8b 40 18          	mov    0x18(%rax),%rax
  802ce7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ceb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802cef:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802cf3:	48 89 cf             	mov    %rcx,%rdi
  802cf6:	ff d0                	callq  *%rax
  802cf8:	c9                   	leaveq 
  802cf9:	c3                   	retq   

0000000000802cfa <seek>:
  802cfa:	55                   	push   %rbp
  802cfb:	48 89 e5             	mov    %rsp,%rbp
  802cfe:	48 83 ec 18          	sub    $0x18,%rsp
  802d02:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d05:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802d08:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d0c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d0f:	48 89 d6             	mov    %rdx,%rsi
  802d12:	89 c7                	mov    %eax,%edi
  802d14:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802d1b:	00 00 00 
  802d1e:	ff d0                	callq  *%rax
  802d20:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d23:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d27:	79 05                	jns    802d2e <seek+0x34>
  802d29:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d2c:	eb 0f                	jmp    802d3d <seek+0x43>
  802d2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d32:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802d35:	89 50 04             	mov    %edx,0x4(%rax)
  802d38:	b8 00 00 00 00       	mov    $0x0,%eax
  802d3d:	c9                   	leaveq 
  802d3e:	c3                   	retq   

0000000000802d3f <ftruncate>:
  802d3f:	55                   	push   %rbp
  802d40:	48 89 e5             	mov    %rsp,%rbp
  802d43:	48 83 ec 30          	sub    $0x30,%rsp
  802d47:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802d4a:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802d4d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802d51:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802d54:	48 89 d6             	mov    %rdx,%rsi
  802d57:	89 c7                	mov    %eax,%edi
  802d59:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802d60:	00 00 00 
  802d63:	ff d0                	callq  *%rax
  802d65:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d68:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d6c:	78 24                	js     802d92 <ftruncate+0x53>
  802d6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d72:	8b 00                	mov    (%rax),%eax
  802d74:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d78:	48 89 d6             	mov    %rdx,%rsi
  802d7b:	89 c7                	mov    %eax,%edi
  802d7d:	48 b8 03 28 80 00 00 	movabs $0x802803,%rax
  802d84:	00 00 00 
  802d87:	ff d0                	callq  *%rax
  802d89:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d8c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d90:	79 05                	jns    802d97 <ftruncate+0x58>
  802d92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d95:	eb 72                	jmp    802e09 <ftruncate+0xca>
  802d97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d9b:	8b 40 08             	mov    0x8(%rax),%eax
  802d9e:	83 e0 03             	and    $0x3,%eax
  802da1:	85 c0                	test   %eax,%eax
  802da3:	75 3a                	jne    802ddf <ftruncate+0xa0>
  802da5:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802dac:	00 00 00 
  802daf:	48 8b 00             	mov    (%rax),%rax
  802db2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802db8:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802dbb:	89 c6                	mov    %eax,%esi
  802dbd:	48 bf 58 4f 80 00 00 	movabs $0x804f58,%rdi
  802dc4:	00 00 00 
  802dc7:	b8 00 00 00 00       	mov    $0x0,%eax
  802dcc:	48 b9 ad 04 80 00 00 	movabs $0x8004ad,%rcx
  802dd3:	00 00 00 
  802dd6:	ff d1                	callq  *%rcx
  802dd8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802ddd:	eb 2a                	jmp    802e09 <ftruncate+0xca>
  802ddf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802de3:	48 8b 40 30          	mov    0x30(%rax),%rax
  802de7:	48 85 c0             	test   %rax,%rax
  802dea:	75 07                	jne    802df3 <ftruncate+0xb4>
  802dec:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802df1:	eb 16                	jmp    802e09 <ftruncate+0xca>
  802df3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802df7:	48 8b 40 30          	mov    0x30(%rax),%rax
  802dfb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802dff:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802e02:	89 ce                	mov    %ecx,%esi
  802e04:	48 89 d7             	mov    %rdx,%rdi
  802e07:	ff d0                	callq  *%rax
  802e09:	c9                   	leaveq 
  802e0a:	c3                   	retq   

0000000000802e0b <fstat>:
  802e0b:	55                   	push   %rbp
  802e0c:	48 89 e5             	mov    %rsp,%rbp
  802e0f:	48 83 ec 30          	sub    $0x30,%rsp
  802e13:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802e16:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802e1a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802e1e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802e21:	48 89 d6             	mov    %rdx,%rsi
  802e24:	89 c7                	mov    %eax,%edi
  802e26:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  802e2d:	00 00 00 
  802e30:	ff d0                	callq  *%rax
  802e32:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e35:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e39:	78 24                	js     802e5f <fstat+0x54>
  802e3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e3f:	8b 00                	mov    (%rax),%eax
  802e41:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802e45:	48 89 d6             	mov    %rdx,%rsi
  802e48:	89 c7                	mov    %eax,%edi
  802e4a:	48 b8 03 28 80 00 00 	movabs $0x802803,%rax
  802e51:	00 00 00 
  802e54:	ff d0                	callq  *%rax
  802e56:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e59:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e5d:	79 05                	jns    802e64 <fstat+0x59>
  802e5f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e62:	eb 5e                	jmp    802ec2 <fstat+0xb7>
  802e64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e68:	48 8b 40 28          	mov    0x28(%rax),%rax
  802e6c:	48 85 c0             	test   %rax,%rax
  802e6f:	75 07                	jne    802e78 <fstat+0x6d>
  802e71:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802e76:	eb 4a                	jmp    802ec2 <fstat+0xb7>
  802e78:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e7c:	c6 00 00             	movb   $0x0,(%rax)
  802e7f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e83:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802e8a:	00 00 00 
  802e8d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e91:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802e98:	00 00 00 
  802e9b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802e9f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802ea3:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802eaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eae:	48 8b 40 28          	mov    0x28(%rax),%rax
  802eb2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802eb6:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802eba:	48 89 ce             	mov    %rcx,%rsi
  802ebd:	48 89 d7             	mov    %rdx,%rdi
  802ec0:	ff d0                	callq  *%rax
  802ec2:	c9                   	leaveq 
  802ec3:	c3                   	retq   

0000000000802ec4 <stat>:
  802ec4:	55                   	push   %rbp
  802ec5:	48 89 e5             	mov    %rsp,%rbp
  802ec8:	48 83 ec 20          	sub    $0x20,%rsp
  802ecc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ed0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802ed4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ed8:	be 00 00 00 00       	mov    $0x0,%esi
  802edd:	48 89 c7             	mov    %rax,%rdi
  802ee0:	48 b8 b2 2f 80 00 00 	movabs $0x802fb2,%rax
  802ee7:	00 00 00 
  802eea:	ff d0                	callq  *%rax
  802eec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802eef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ef3:	79 05                	jns    802efa <stat+0x36>
  802ef5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ef8:	eb 2f                	jmp    802f29 <stat+0x65>
  802efa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802efe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f01:	48 89 d6             	mov    %rdx,%rsi
  802f04:	89 c7                	mov    %eax,%edi
  802f06:	48 b8 0b 2e 80 00 00 	movabs $0x802e0b,%rax
  802f0d:	00 00 00 
  802f10:	ff d0                	callq  *%rax
  802f12:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802f15:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f18:	89 c7                	mov    %eax,%edi
  802f1a:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  802f21:	00 00 00 
  802f24:	ff d0                	callq  *%rax
  802f26:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f29:	c9                   	leaveq 
  802f2a:	c3                   	retq   

0000000000802f2b <fsipc>:
  802f2b:	55                   	push   %rbp
  802f2c:	48 89 e5             	mov    %rsp,%rbp
  802f2f:	48 83 ec 10          	sub    $0x10,%rsp
  802f33:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802f36:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802f3a:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f41:	00 00 00 
  802f44:	8b 00                	mov    (%rax),%eax
  802f46:	85 c0                	test   %eax,%eax
  802f48:	75 1d                	jne    802f67 <fsipc+0x3c>
  802f4a:	bf 01 00 00 00       	mov    $0x1,%edi
  802f4f:	48 b8 52 25 80 00 00 	movabs $0x802552,%rax
  802f56:	00 00 00 
  802f59:	ff d0                	callq  *%rax
  802f5b:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802f62:	00 00 00 
  802f65:	89 02                	mov    %eax,(%rdx)
  802f67:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f6e:	00 00 00 
  802f71:	8b 00                	mov    (%rax),%eax
  802f73:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802f76:	b9 07 00 00 00       	mov    $0x7,%ecx
  802f7b:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802f82:	00 00 00 
  802f85:	89 c7                	mov    %eax,%edi
  802f87:	48 b8 47 24 80 00 00 	movabs $0x802447,%rax
  802f8e:	00 00 00 
  802f91:	ff d0                	callq  *%rax
  802f93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f97:	ba 00 00 00 00       	mov    $0x0,%edx
  802f9c:	48 89 c6             	mov    %rax,%rsi
  802f9f:	bf 00 00 00 00       	mov    $0x0,%edi
  802fa4:	48 b8 86 23 80 00 00 	movabs $0x802386,%rax
  802fab:	00 00 00 
  802fae:	ff d0                	callq  *%rax
  802fb0:	c9                   	leaveq 
  802fb1:	c3                   	retq   

0000000000802fb2 <open>:
  802fb2:	55                   	push   %rbp
  802fb3:	48 89 e5             	mov    %rsp,%rbp
  802fb6:	48 83 ec 20          	sub    $0x20,%rsp
  802fba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802fbe:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802fc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fc5:	48 89 c7             	mov    %rax,%rdi
  802fc8:	48 b8 f6 0f 80 00 00 	movabs $0x800ff6,%rax
  802fcf:	00 00 00 
  802fd2:	ff d0                	callq  *%rax
  802fd4:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802fd9:	7e 0a                	jle    802fe5 <open+0x33>
  802fdb:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802fe0:	e9 a5 00 00 00       	jmpq   80308a <open+0xd8>
  802fe5:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802fe9:	48 89 c7             	mov    %rax,%rdi
  802fec:	48 b8 12 26 80 00 00 	movabs $0x802612,%rax
  802ff3:	00 00 00 
  802ff6:	ff d0                	callq  *%rax
  802ff8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ffb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fff:	79 08                	jns    803009 <open+0x57>
  803001:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803004:	e9 81 00 00 00       	jmpq   80308a <open+0xd8>
  803009:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80300d:	48 89 c6             	mov    %rax,%rsi
  803010:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803017:	00 00 00 
  80301a:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  803021:	00 00 00 
  803024:	ff d0                	callq  *%rax
  803026:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80302d:	00 00 00 
  803030:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803033:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  803039:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80303d:	48 89 c6             	mov    %rax,%rsi
  803040:	bf 01 00 00 00       	mov    $0x1,%edi
  803045:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  80304c:	00 00 00 
  80304f:	ff d0                	callq  *%rax
  803051:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803054:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803058:	79 1d                	jns    803077 <open+0xc5>
  80305a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80305e:	be 00 00 00 00       	mov    $0x0,%esi
  803063:	48 89 c7             	mov    %rax,%rdi
  803066:	48 b8 3a 27 80 00 00 	movabs $0x80273a,%rax
  80306d:	00 00 00 
  803070:	ff d0                	callq  *%rax
  803072:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803075:	eb 13                	jmp    80308a <open+0xd8>
  803077:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80307b:	48 89 c7             	mov    %rax,%rdi
  80307e:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  803085:	00 00 00 
  803088:	ff d0                	callq  *%rax
  80308a:	c9                   	leaveq 
  80308b:	c3                   	retq   

000000000080308c <devfile_flush>:
  80308c:	55                   	push   %rbp
  80308d:	48 89 e5             	mov    %rsp,%rbp
  803090:	48 83 ec 10          	sub    $0x10,%rsp
  803094:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803098:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80309c:	8b 50 0c             	mov    0xc(%rax),%edx
  80309f:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030a6:	00 00 00 
  8030a9:	89 10                	mov    %edx,(%rax)
  8030ab:	be 00 00 00 00       	mov    $0x0,%esi
  8030b0:	bf 06 00 00 00       	mov    $0x6,%edi
  8030b5:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  8030bc:	00 00 00 
  8030bf:	ff d0                	callq  *%rax
  8030c1:	c9                   	leaveq 
  8030c2:	c3                   	retq   

00000000008030c3 <devfile_read>:
  8030c3:	55                   	push   %rbp
  8030c4:	48 89 e5             	mov    %rsp,%rbp
  8030c7:	48 83 ec 30          	sub    $0x30,%rsp
  8030cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8030cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8030d3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8030d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030db:	8b 50 0c             	mov    0xc(%rax),%edx
  8030de:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030e5:	00 00 00 
  8030e8:	89 10                	mov    %edx,(%rax)
  8030ea:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030f1:	00 00 00 
  8030f4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8030f8:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8030fc:	be 00 00 00 00       	mov    $0x0,%esi
  803101:	bf 03 00 00 00       	mov    $0x3,%edi
  803106:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  80310d:	00 00 00 
  803110:	ff d0                	callq  *%rax
  803112:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803115:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803119:	79 08                	jns    803123 <devfile_read+0x60>
  80311b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80311e:	e9 a4 00 00 00       	jmpq   8031c7 <devfile_read+0x104>
  803123:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803126:	48 98                	cltq   
  803128:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80312c:	76 35                	jbe    803163 <devfile_read+0xa0>
  80312e:	48 b9 7e 4f 80 00 00 	movabs $0x804f7e,%rcx
  803135:	00 00 00 
  803138:	48 ba 85 4f 80 00 00 	movabs $0x804f85,%rdx
  80313f:	00 00 00 
  803142:	be 89 00 00 00       	mov    $0x89,%esi
  803147:	48 bf 9a 4f 80 00 00 	movabs $0x804f9a,%rdi
  80314e:	00 00 00 
  803151:	b8 00 00 00 00       	mov    $0x0,%eax
  803156:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80315d:	00 00 00 
  803160:	41 ff d0             	callq  *%r8
  803163:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  80316a:	7e 35                	jle    8031a1 <devfile_read+0xde>
  80316c:	48 b9 a8 4f 80 00 00 	movabs $0x804fa8,%rcx
  803173:	00 00 00 
  803176:	48 ba 85 4f 80 00 00 	movabs $0x804f85,%rdx
  80317d:	00 00 00 
  803180:	be 8a 00 00 00       	mov    $0x8a,%esi
  803185:	48 bf 9a 4f 80 00 00 	movabs $0x804f9a,%rdi
  80318c:	00 00 00 
  80318f:	b8 00 00 00 00       	mov    $0x0,%eax
  803194:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  80319b:	00 00 00 
  80319e:	41 ff d0             	callq  *%r8
  8031a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031a4:	48 63 d0             	movslq %eax,%rdx
  8031a7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8031ab:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8031b2:	00 00 00 
  8031b5:	48 89 c7             	mov    %rax,%rdi
  8031b8:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  8031bf:	00 00 00 
  8031c2:	ff d0                	callq  *%rax
  8031c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031c7:	c9                   	leaveq 
  8031c8:	c3                   	retq   

00000000008031c9 <devfile_write>:
  8031c9:	55                   	push   %rbp
  8031ca:	48 89 e5             	mov    %rsp,%rbp
  8031cd:	48 83 ec 40          	sub    $0x40,%rsp
  8031d1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8031d5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8031d9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8031dd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8031e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8031e5:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8031ec:	00 
  8031ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031f1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8031f5:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8031fa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8031fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803202:	8b 50 0c             	mov    0xc(%rax),%edx
  803205:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80320c:	00 00 00 
  80320f:	89 10                	mov    %edx,(%rax)
  803211:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803218:	00 00 00 
  80321b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80321f:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803223:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803227:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80322b:	48 89 c6             	mov    %rax,%rsi
  80322e:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  803235:	00 00 00 
  803238:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  80323f:	00 00 00 
  803242:	ff d0                	callq  *%rax
  803244:	be 00 00 00 00       	mov    $0x0,%esi
  803249:	bf 04 00 00 00       	mov    $0x4,%edi
  80324e:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  803255:	00 00 00 
  803258:	ff d0                	callq  *%rax
  80325a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80325d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803261:	79 05                	jns    803268 <devfile_write+0x9f>
  803263:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803266:	eb 43                	jmp    8032ab <devfile_write+0xe2>
  803268:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80326b:	48 98                	cltq   
  80326d:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803271:	76 35                	jbe    8032a8 <devfile_write+0xdf>
  803273:	48 b9 7e 4f 80 00 00 	movabs $0x804f7e,%rcx
  80327a:	00 00 00 
  80327d:	48 ba 85 4f 80 00 00 	movabs $0x804f85,%rdx
  803284:	00 00 00 
  803287:	be a8 00 00 00       	mov    $0xa8,%esi
  80328c:	48 bf 9a 4f 80 00 00 	movabs $0x804f9a,%rdi
  803293:	00 00 00 
  803296:	b8 00 00 00 00       	mov    $0x0,%eax
  80329b:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8032a2:	00 00 00 
  8032a5:	41 ff d0             	callq  *%r8
  8032a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8032ab:	c9                   	leaveq 
  8032ac:	c3                   	retq   

00000000008032ad <devfile_stat>:
  8032ad:	55                   	push   %rbp
  8032ae:	48 89 e5             	mov    %rsp,%rbp
  8032b1:	48 83 ec 20          	sub    $0x20,%rsp
  8032b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8032b9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8032bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8032c1:	8b 50 0c             	mov    0xc(%rax),%edx
  8032c4:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8032cb:	00 00 00 
  8032ce:	89 10                	mov    %edx,(%rax)
  8032d0:	be 00 00 00 00       	mov    $0x0,%esi
  8032d5:	bf 05 00 00 00       	mov    $0x5,%edi
  8032da:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  8032e1:	00 00 00 
  8032e4:	ff d0                	callq  *%rax
  8032e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032ed:	79 05                	jns    8032f4 <devfile_stat+0x47>
  8032ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032f2:	eb 56                	jmp    80334a <devfile_stat+0x9d>
  8032f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8032f8:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8032ff:	00 00 00 
  803302:	48 89 c7             	mov    %rax,%rdi
  803305:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  80330c:	00 00 00 
  80330f:	ff d0                	callq  *%rax
  803311:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803318:	00 00 00 
  80331b:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803321:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803325:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80332b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803332:	00 00 00 
  803335:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80333b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80333f:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803345:	b8 00 00 00 00       	mov    $0x0,%eax
  80334a:	c9                   	leaveq 
  80334b:	c3                   	retq   

000000000080334c <devfile_trunc>:
  80334c:	55                   	push   %rbp
  80334d:	48 89 e5             	mov    %rsp,%rbp
  803350:	48 83 ec 10          	sub    $0x10,%rsp
  803354:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803358:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80335b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80335f:	8b 50 0c             	mov    0xc(%rax),%edx
  803362:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803369:	00 00 00 
  80336c:	89 10                	mov    %edx,(%rax)
  80336e:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803375:	00 00 00 
  803378:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80337b:	89 50 04             	mov    %edx,0x4(%rax)
  80337e:	be 00 00 00 00       	mov    $0x0,%esi
  803383:	bf 02 00 00 00       	mov    $0x2,%edi
  803388:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  80338f:	00 00 00 
  803392:	ff d0                	callq  *%rax
  803394:	c9                   	leaveq 
  803395:	c3                   	retq   

0000000000803396 <remove>:
  803396:	55                   	push   %rbp
  803397:	48 89 e5             	mov    %rsp,%rbp
  80339a:	48 83 ec 10          	sub    $0x10,%rsp
  80339e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8033a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8033a6:	48 89 c7             	mov    %rax,%rdi
  8033a9:	48 b8 f6 0f 80 00 00 	movabs $0x800ff6,%rax
  8033b0:	00 00 00 
  8033b3:	ff d0                	callq  *%rax
  8033b5:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8033ba:	7e 07                	jle    8033c3 <remove+0x2d>
  8033bc:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8033c1:	eb 33                	jmp    8033f6 <remove+0x60>
  8033c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8033c7:	48 89 c6             	mov    %rax,%rsi
  8033ca:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8033d1:	00 00 00 
  8033d4:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  8033db:	00 00 00 
  8033de:	ff d0                	callq  *%rax
  8033e0:	be 00 00 00 00       	mov    $0x0,%esi
  8033e5:	bf 07 00 00 00       	mov    $0x7,%edi
  8033ea:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  8033f1:	00 00 00 
  8033f4:	ff d0                	callq  *%rax
  8033f6:	c9                   	leaveq 
  8033f7:	c3                   	retq   

00000000008033f8 <sync>:
  8033f8:	55                   	push   %rbp
  8033f9:	48 89 e5             	mov    %rsp,%rbp
  8033fc:	be 00 00 00 00       	mov    $0x0,%esi
  803401:	bf 08 00 00 00       	mov    $0x8,%edi
  803406:	48 b8 2b 2f 80 00 00 	movabs $0x802f2b,%rax
  80340d:	00 00 00 
  803410:	ff d0                	callq  *%rax
  803412:	5d                   	pop    %rbp
  803413:	c3                   	retq   

0000000000803414 <copy>:
  803414:	55                   	push   %rbp
  803415:	48 89 e5             	mov    %rsp,%rbp
  803418:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  80341f:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  803426:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80342d:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803434:	be 00 00 00 00       	mov    $0x0,%esi
  803439:	48 89 c7             	mov    %rax,%rdi
  80343c:	48 b8 b2 2f 80 00 00 	movabs $0x802fb2,%rax
  803443:	00 00 00 
  803446:	ff d0                	callq  *%rax
  803448:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80344b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80344f:	79 28                	jns    803479 <copy+0x65>
  803451:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803454:	89 c6                	mov    %eax,%esi
  803456:	48 bf b4 4f 80 00 00 	movabs $0x804fb4,%rdi
  80345d:	00 00 00 
  803460:	b8 00 00 00 00       	mov    $0x0,%eax
  803465:	48 ba ad 04 80 00 00 	movabs $0x8004ad,%rdx
  80346c:	00 00 00 
  80346f:	ff d2                	callq  *%rdx
  803471:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803474:	e9 74 01 00 00       	jmpq   8035ed <copy+0x1d9>
  803479:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803480:	be 01 01 00 00       	mov    $0x101,%esi
  803485:	48 89 c7             	mov    %rax,%rdi
  803488:	48 b8 b2 2f 80 00 00 	movabs $0x802fb2,%rax
  80348f:	00 00 00 
  803492:	ff d0                	callq  *%rax
  803494:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803497:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80349b:	79 39                	jns    8034d6 <copy+0xc2>
  80349d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034a0:	89 c6                	mov    %eax,%esi
  8034a2:	48 bf ca 4f 80 00 00 	movabs $0x804fca,%rdi
  8034a9:	00 00 00 
  8034ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8034b1:	48 ba ad 04 80 00 00 	movabs $0x8004ad,%rdx
  8034b8:	00 00 00 
  8034bb:	ff d2                	callq  *%rdx
  8034bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034c0:	89 c7                	mov    %eax,%edi
  8034c2:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  8034c9:	00 00 00 
  8034cc:	ff d0                	callq  *%rax
  8034ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034d1:	e9 17 01 00 00       	jmpq   8035ed <copy+0x1d9>
  8034d6:	eb 74                	jmp    80354c <copy+0x138>
  8034d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8034db:	48 63 d0             	movslq %eax,%rdx
  8034de:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8034e5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034e8:	48 89 ce             	mov    %rcx,%rsi
  8034eb:	89 c7                	mov    %eax,%edi
  8034ed:	48 b8 26 2c 80 00 00 	movabs $0x802c26,%rax
  8034f4:	00 00 00 
  8034f7:	ff d0                	callq  *%rax
  8034f9:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8034fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803500:	79 4a                	jns    80354c <copy+0x138>
  803502:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803505:	89 c6                	mov    %eax,%esi
  803507:	48 bf e4 4f 80 00 00 	movabs $0x804fe4,%rdi
  80350e:	00 00 00 
  803511:	b8 00 00 00 00       	mov    $0x0,%eax
  803516:	48 ba ad 04 80 00 00 	movabs $0x8004ad,%rdx
  80351d:	00 00 00 
  803520:	ff d2                	callq  *%rdx
  803522:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803525:	89 c7                	mov    %eax,%edi
  803527:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  80352e:	00 00 00 
  803531:	ff d0                	callq  *%rax
  803533:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803536:	89 c7                	mov    %eax,%edi
  803538:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  80353f:	00 00 00 
  803542:	ff d0                	callq  *%rax
  803544:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803547:	e9 a1 00 00 00       	jmpq   8035ed <copy+0x1d9>
  80354c:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803553:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803556:	ba 00 02 00 00       	mov    $0x200,%edx
  80355b:	48 89 ce             	mov    %rcx,%rsi
  80355e:	89 c7                	mov    %eax,%edi
  803560:	48 b8 dc 2a 80 00 00 	movabs $0x802adc,%rax
  803567:	00 00 00 
  80356a:	ff d0                	callq  *%rax
  80356c:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80356f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803573:	0f 8f 5f ff ff ff    	jg     8034d8 <copy+0xc4>
  803579:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80357d:	79 47                	jns    8035c6 <copy+0x1b2>
  80357f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803582:	89 c6                	mov    %eax,%esi
  803584:	48 bf f7 4f 80 00 00 	movabs $0x804ff7,%rdi
  80358b:	00 00 00 
  80358e:	b8 00 00 00 00       	mov    $0x0,%eax
  803593:	48 ba ad 04 80 00 00 	movabs $0x8004ad,%rdx
  80359a:	00 00 00 
  80359d:	ff d2                	callq  *%rdx
  80359f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035a2:	89 c7                	mov    %eax,%edi
  8035a4:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  8035ab:	00 00 00 
  8035ae:	ff d0                	callq  *%rax
  8035b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035b3:	89 c7                	mov    %eax,%edi
  8035b5:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  8035bc:	00 00 00 
  8035bf:	ff d0                	callq  *%rax
  8035c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8035c4:	eb 27                	jmp    8035ed <copy+0x1d9>
  8035c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035c9:	89 c7                	mov    %eax,%edi
  8035cb:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  8035d2:	00 00 00 
  8035d5:	ff d0                	callq  *%rax
  8035d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035da:	89 c7                	mov    %eax,%edi
  8035dc:	48 b8 ba 28 80 00 00 	movabs $0x8028ba,%rax
  8035e3:	00 00 00 
  8035e6:	ff d0                	callq  *%rax
  8035e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8035ed:	c9                   	leaveq 
  8035ee:	c3                   	retq   

00000000008035ef <fd2sockid>:
  8035ef:	55                   	push   %rbp
  8035f0:	48 89 e5             	mov    %rsp,%rbp
  8035f3:	48 83 ec 20          	sub    $0x20,%rsp
  8035f7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8035fa:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8035fe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803601:	48 89 d6             	mov    %rdx,%rsi
  803604:	89 c7                	mov    %eax,%edi
  803606:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  80360d:	00 00 00 
  803610:	ff d0                	callq  *%rax
  803612:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803615:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803619:	79 05                	jns    803620 <fd2sockid+0x31>
  80361b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80361e:	eb 24                	jmp    803644 <fd2sockid+0x55>
  803620:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803624:	8b 10                	mov    (%rax),%edx
  803626:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  80362d:	00 00 00 
  803630:	8b 00                	mov    (%rax),%eax
  803632:	39 c2                	cmp    %eax,%edx
  803634:	74 07                	je     80363d <fd2sockid+0x4e>
  803636:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80363b:	eb 07                	jmp    803644 <fd2sockid+0x55>
  80363d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803641:	8b 40 0c             	mov    0xc(%rax),%eax
  803644:	c9                   	leaveq 
  803645:	c3                   	retq   

0000000000803646 <alloc_sockfd>:
  803646:	55                   	push   %rbp
  803647:	48 89 e5             	mov    %rsp,%rbp
  80364a:	48 83 ec 20          	sub    $0x20,%rsp
  80364e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803651:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803655:	48 89 c7             	mov    %rax,%rdi
  803658:	48 b8 12 26 80 00 00 	movabs $0x802612,%rax
  80365f:	00 00 00 
  803662:	ff d0                	callq  *%rax
  803664:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803667:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80366b:	78 26                	js     803693 <alloc_sockfd+0x4d>
  80366d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803671:	ba 07 04 00 00       	mov    $0x407,%edx
  803676:	48 89 c6             	mov    %rax,%rsi
  803679:	bf 00 00 00 00       	mov    $0x0,%edi
  80367e:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  803685:	00 00 00 
  803688:	ff d0                	callq  *%rax
  80368a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80368d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803691:	79 16                	jns    8036a9 <alloc_sockfd+0x63>
  803693:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803696:	89 c7                	mov    %eax,%edi
  803698:	48 b8 53 3b 80 00 00 	movabs $0x803b53,%rax
  80369f:	00 00 00 
  8036a2:	ff d0                	callq  *%rax
  8036a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036a7:	eb 3a                	jmp    8036e3 <alloc_sockfd+0x9d>
  8036a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036ad:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8036b4:	00 00 00 
  8036b7:	8b 12                	mov    (%rdx),%edx
  8036b9:	89 10                	mov    %edx,(%rax)
  8036bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036bf:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8036c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036ca:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8036cd:	89 50 0c             	mov    %edx,0xc(%rax)
  8036d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036d4:	48 89 c7             	mov    %rax,%rdi
  8036d7:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  8036de:	00 00 00 
  8036e1:	ff d0                	callq  *%rax
  8036e3:	c9                   	leaveq 
  8036e4:	c3                   	retq   

00000000008036e5 <accept>:
  8036e5:	55                   	push   %rbp
  8036e6:	48 89 e5             	mov    %rsp,%rbp
  8036e9:	48 83 ec 30          	sub    $0x30,%rsp
  8036ed:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8036f4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8036f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036fb:	89 c7                	mov    %eax,%edi
  8036fd:	48 b8 ef 35 80 00 00 	movabs $0x8035ef,%rax
  803704:	00 00 00 
  803707:	ff d0                	callq  *%rax
  803709:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80370c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803710:	79 05                	jns    803717 <accept+0x32>
  803712:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803715:	eb 3b                	jmp    803752 <accept+0x6d>
  803717:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80371b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80371f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803722:	48 89 ce             	mov    %rcx,%rsi
  803725:	89 c7                	mov    %eax,%edi
  803727:	48 b8 30 3a 80 00 00 	movabs $0x803a30,%rax
  80372e:	00 00 00 
  803731:	ff d0                	callq  *%rax
  803733:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803736:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80373a:	79 05                	jns    803741 <accept+0x5c>
  80373c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80373f:	eb 11                	jmp    803752 <accept+0x6d>
  803741:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803744:	89 c7                	mov    %eax,%edi
  803746:	48 b8 46 36 80 00 00 	movabs $0x803646,%rax
  80374d:	00 00 00 
  803750:	ff d0                	callq  *%rax
  803752:	c9                   	leaveq 
  803753:	c3                   	retq   

0000000000803754 <bind>:
  803754:	55                   	push   %rbp
  803755:	48 89 e5             	mov    %rsp,%rbp
  803758:	48 83 ec 20          	sub    $0x20,%rsp
  80375c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80375f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803763:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803766:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803769:	89 c7                	mov    %eax,%edi
  80376b:	48 b8 ef 35 80 00 00 	movabs $0x8035ef,%rax
  803772:	00 00 00 
  803775:	ff d0                	callq  *%rax
  803777:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80377a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80377e:	79 05                	jns    803785 <bind+0x31>
  803780:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803783:	eb 1b                	jmp    8037a0 <bind+0x4c>
  803785:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803788:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80378c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80378f:	48 89 ce             	mov    %rcx,%rsi
  803792:	89 c7                	mov    %eax,%edi
  803794:	48 b8 af 3a 80 00 00 	movabs $0x803aaf,%rax
  80379b:	00 00 00 
  80379e:	ff d0                	callq  *%rax
  8037a0:	c9                   	leaveq 
  8037a1:	c3                   	retq   

00000000008037a2 <shutdown>:
  8037a2:	55                   	push   %rbp
  8037a3:	48 89 e5             	mov    %rsp,%rbp
  8037a6:	48 83 ec 20          	sub    $0x20,%rsp
  8037aa:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8037ad:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8037b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037b3:	89 c7                	mov    %eax,%edi
  8037b5:	48 b8 ef 35 80 00 00 	movabs $0x8035ef,%rax
  8037bc:	00 00 00 
  8037bf:	ff d0                	callq  *%rax
  8037c1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037c8:	79 05                	jns    8037cf <shutdown+0x2d>
  8037ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037cd:	eb 16                	jmp    8037e5 <shutdown+0x43>
  8037cf:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8037d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037d5:	89 d6                	mov    %edx,%esi
  8037d7:	89 c7                	mov    %eax,%edi
  8037d9:	48 b8 13 3b 80 00 00 	movabs $0x803b13,%rax
  8037e0:	00 00 00 
  8037e3:	ff d0                	callq  *%rax
  8037e5:	c9                   	leaveq 
  8037e6:	c3                   	retq   

00000000008037e7 <devsock_close>:
  8037e7:	55                   	push   %rbp
  8037e8:	48 89 e5             	mov    %rsp,%rbp
  8037eb:	48 83 ec 10          	sub    $0x10,%rsp
  8037ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037f7:	48 89 c7             	mov    %rax,%rdi
  8037fa:	48 b8 9f 47 80 00 00 	movabs $0x80479f,%rax
  803801:	00 00 00 
  803804:	ff d0                	callq  *%rax
  803806:	83 f8 01             	cmp    $0x1,%eax
  803809:	75 17                	jne    803822 <devsock_close+0x3b>
  80380b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80380f:	8b 40 0c             	mov    0xc(%rax),%eax
  803812:	89 c7                	mov    %eax,%edi
  803814:	48 b8 53 3b 80 00 00 	movabs $0x803b53,%rax
  80381b:	00 00 00 
  80381e:	ff d0                	callq  *%rax
  803820:	eb 05                	jmp    803827 <devsock_close+0x40>
  803822:	b8 00 00 00 00       	mov    $0x0,%eax
  803827:	c9                   	leaveq 
  803828:	c3                   	retq   

0000000000803829 <connect>:
  803829:	55                   	push   %rbp
  80382a:	48 89 e5             	mov    %rsp,%rbp
  80382d:	48 83 ec 20          	sub    $0x20,%rsp
  803831:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803834:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803838:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80383b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80383e:	89 c7                	mov    %eax,%edi
  803840:	48 b8 ef 35 80 00 00 	movabs $0x8035ef,%rax
  803847:	00 00 00 
  80384a:	ff d0                	callq  *%rax
  80384c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80384f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803853:	79 05                	jns    80385a <connect+0x31>
  803855:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803858:	eb 1b                	jmp    803875 <connect+0x4c>
  80385a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80385d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803861:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803864:	48 89 ce             	mov    %rcx,%rsi
  803867:	89 c7                	mov    %eax,%edi
  803869:	48 b8 80 3b 80 00 00 	movabs $0x803b80,%rax
  803870:	00 00 00 
  803873:	ff d0                	callq  *%rax
  803875:	c9                   	leaveq 
  803876:	c3                   	retq   

0000000000803877 <listen>:
  803877:	55                   	push   %rbp
  803878:	48 89 e5             	mov    %rsp,%rbp
  80387b:	48 83 ec 20          	sub    $0x20,%rsp
  80387f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803882:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803885:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803888:	89 c7                	mov    %eax,%edi
  80388a:	48 b8 ef 35 80 00 00 	movabs $0x8035ef,%rax
  803891:	00 00 00 
  803894:	ff d0                	callq  *%rax
  803896:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803899:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80389d:	79 05                	jns    8038a4 <listen+0x2d>
  80389f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038a2:	eb 16                	jmp    8038ba <listen+0x43>
  8038a4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8038a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038aa:	89 d6                	mov    %edx,%esi
  8038ac:	89 c7                	mov    %eax,%edi
  8038ae:	48 b8 e4 3b 80 00 00 	movabs $0x803be4,%rax
  8038b5:	00 00 00 
  8038b8:	ff d0                	callq  *%rax
  8038ba:	c9                   	leaveq 
  8038bb:	c3                   	retq   

00000000008038bc <devsock_read>:
  8038bc:	55                   	push   %rbp
  8038bd:	48 89 e5             	mov    %rsp,%rbp
  8038c0:	48 83 ec 20          	sub    $0x20,%rsp
  8038c4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8038c8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8038cc:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8038d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038d4:	89 c2                	mov    %eax,%edx
  8038d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038da:	8b 40 0c             	mov    0xc(%rax),%eax
  8038dd:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8038e1:	b9 00 00 00 00       	mov    $0x0,%ecx
  8038e6:	89 c7                	mov    %eax,%edi
  8038e8:	48 b8 24 3c 80 00 00 	movabs $0x803c24,%rax
  8038ef:	00 00 00 
  8038f2:	ff d0                	callq  *%rax
  8038f4:	c9                   	leaveq 
  8038f5:	c3                   	retq   

00000000008038f6 <devsock_write>:
  8038f6:	55                   	push   %rbp
  8038f7:	48 89 e5             	mov    %rsp,%rbp
  8038fa:	48 83 ec 20          	sub    $0x20,%rsp
  8038fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803902:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803906:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80390a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80390e:	89 c2                	mov    %eax,%edx
  803910:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803914:	8b 40 0c             	mov    0xc(%rax),%eax
  803917:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80391b:	b9 00 00 00 00       	mov    $0x0,%ecx
  803920:	89 c7                	mov    %eax,%edi
  803922:	48 b8 f0 3c 80 00 00 	movabs $0x803cf0,%rax
  803929:	00 00 00 
  80392c:	ff d0                	callq  *%rax
  80392e:	c9                   	leaveq 
  80392f:	c3                   	retq   

0000000000803930 <devsock_stat>:
  803930:	55                   	push   %rbp
  803931:	48 89 e5             	mov    %rsp,%rbp
  803934:	48 83 ec 10          	sub    $0x10,%rsp
  803938:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80393c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803940:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803944:	48 be 12 50 80 00 00 	movabs $0x805012,%rsi
  80394b:	00 00 00 
  80394e:	48 89 c7             	mov    %rax,%rdi
  803951:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  803958:	00 00 00 
  80395b:	ff d0                	callq  *%rax
  80395d:	b8 00 00 00 00       	mov    $0x0,%eax
  803962:	c9                   	leaveq 
  803963:	c3                   	retq   

0000000000803964 <socket>:
  803964:	55                   	push   %rbp
  803965:	48 89 e5             	mov    %rsp,%rbp
  803968:	48 83 ec 20          	sub    $0x20,%rsp
  80396c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80396f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803972:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803975:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803978:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80397b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80397e:	89 ce                	mov    %ecx,%esi
  803980:	89 c7                	mov    %eax,%edi
  803982:	48 b8 a8 3d 80 00 00 	movabs $0x803da8,%rax
  803989:	00 00 00 
  80398c:	ff d0                	callq  *%rax
  80398e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803991:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803995:	79 05                	jns    80399c <socket+0x38>
  803997:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80399a:	eb 11                	jmp    8039ad <socket+0x49>
  80399c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80399f:	89 c7                	mov    %eax,%edi
  8039a1:	48 b8 46 36 80 00 00 	movabs $0x803646,%rax
  8039a8:	00 00 00 
  8039ab:	ff d0                	callq  *%rax
  8039ad:	c9                   	leaveq 
  8039ae:	c3                   	retq   

00000000008039af <nsipc>:
  8039af:	55                   	push   %rbp
  8039b0:	48 89 e5             	mov    %rsp,%rbp
  8039b3:	48 83 ec 10          	sub    $0x10,%rsp
  8039b7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039ba:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8039c1:	00 00 00 
  8039c4:	8b 00                	mov    (%rax),%eax
  8039c6:	85 c0                	test   %eax,%eax
  8039c8:	75 1d                	jne    8039e7 <nsipc+0x38>
  8039ca:	bf 02 00 00 00       	mov    $0x2,%edi
  8039cf:	48 b8 52 25 80 00 00 	movabs $0x802552,%rax
  8039d6:	00 00 00 
  8039d9:	ff d0                	callq  *%rax
  8039db:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  8039e2:	00 00 00 
  8039e5:	89 02                	mov    %eax,(%rdx)
  8039e7:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8039ee:	00 00 00 
  8039f1:	8b 00                	mov    (%rax),%eax
  8039f3:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8039f6:	b9 07 00 00 00       	mov    $0x7,%ecx
  8039fb:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803a02:	00 00 00 
  803a05:	89 c7                	mov    %eax,%edi
  803a07:	48 b8 47 24 80 00 00 	movabs $0x802447,%rax
  803a0e:	00 00 00 
  803a11:	ff d0                	callq  *%rax
  803a13:	ba 00 00 00 00       	mov    $0x0,%edx
  803a18:	be 00 00 00 00       	mov    $0x0,%esi
  803a1d:	bf 00 00 00 00       	mov    $0x0,%edi
  803a22:	48 b8 86 23 80 00 00 	movabs $0x802386,%rax
  803a29:	00 00 00 
  803a2c:	ff d0                	callq  *%rax
  803a2e:	c9                   	leaveq 
  803a2f:	c3                   	retq   

0000000000803a30 <nsipc_accept>:
  803a30:	55                   	push   %rbp
  803a31:	48 89 e5             	mov    %rsp,%rbp
  803a34:	48 83 ec 30          	sub    $0x30,%rsp
  803a38:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a3b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a3f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803a43:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a4a:	00 00 00 
  803a4d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803a50:	89 10                	mov    %edx,(%rax)
  803a52:	bf 01 00 00 00       	mov    $0x1,%edi
  803a57:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803a5e:	00 00 00 
  803a61:	ff d0                	callq  *%rax
  803a63:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a66:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a6a:	78 3e                	js     803aaa <nsipc_accept+0x7a>
  803a6c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a73:	00 00 00 
  803a76:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803a7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a7e:	8b 40 10             	mov    0x10(%rax),%eax
  803a81:	89 c2                	mov    %eax,%edx
  803a83:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803a87:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a8b:	48 89 ce             	mov    %rcx,%rsi
  803a8e:	48 89 c7             	mov    %rax,%rdi
  803a91:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  803a98:	00 00 00 
  803a9b:	ff d0                	callq  *%rax
  803a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803aa1:	8b 50 10             	mov    0x10(%rax),%edx
  803aa4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803aa8:	89 10                	mov    %edx,(%rax)
  803aaa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aad:	c9                   	leaveq 
  803aae:	c3                   	retq   

0000000000803aaf <nsipc_bind>:
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
  803ae4:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  803aeb:	00 00 00 
  803aee:	ff d0                	callq  *%rax
  803af0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803af7:	00 00 00 
  803afa:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803afd:	89 50 14             	mov    %edx,0x14(%rax)
  803b00:	bf 02 00 00 00       	mov    $0x2,%edi
  803b05:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803b0c:	00 00 00 
  803b0f:	ff d0                	callq  *%rax
  803b11:	c9                   	leaveq 
  803b12:	c3                   	retq   

0000000000803b13 <nsipc_shutdown>:
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
  803b40:	bf 03 00 00 00       	mov    $0x3,%edi
  803b45:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803b4c:	00 00 00 
  803b4f:	ff d0                	callq  *%rax
  803b51:	c9                   	leaveq 
  803b52:	c3                   	retq   

0000000000803b53 <nsipc_close>:
  803b53:	55                   	push   %rbp
  803b54:	48 89 e5             	mov    %rsp,%rbp
  803b57:	48 83 ec 10          	sub    $0x10,%rsp
  803b5b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b5e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b65:	00 00 00 
  803b68:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b6b:	89 10                	mov    %edx,(%rax)
  803b6d:	bf 04 00 00 00       	mov    $0x4,%edi
  803b72:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803b79:	00 00 00 
  803b7c:	ff d0                	callq  *%rax
  803b7e:	c9                   	leaveq 
  803b7f:	c3                   	retq   

0000000000803b80 <nsipc_connect>:
  803b80:	55                   	push   %rbp
  803b81:	48 89 e5             	mov    %rsp,%rbp
  803b84:	48 83 ec 10          	sub    $0x10,%rsp
  803b88:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b8b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b8f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803b92:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b99:	00 00 00 
  803b9c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b9f:	89 10                	mov    %edx,(%rax)
  803ba1:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ba4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ba8:	48 89 c6             	mov    %rax,%rsi
  803bab:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803bb2:	00 00 00 
  803bb5:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  803bbc:	00 00 00 
  803bbf:	ff d0                	callq  *%rax
  803bc1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bc8:	00 00 00 
  803bcb:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803bce:	89 50 14             	mov    %edx,0x14(%rax)
  803bd1:	bf 05 00 00 00       	mov    $0x5,%edi
  803bd6:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803bdd:	00 00 00 
  803be0:	ff d0                	callq  *%rax
  803be2:	c9                   	leaveq 
  803be3:	c3                   	retq   

0000000000803be4 <nsipc_listen>:
  803be4:	55                   	push   %rbp
  803be5:	48 89 e5             	mov    %rsp,%rbp
  803be8:	48 83 ec 10          	sub    $0x10,%rsp
  803bec:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803bef:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803bf2:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bf9:	00 00 00 
  803bfc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803bff:	89 10                	mov    %edx,(%rax)
  803c01:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c08:	00 00 00 
  803c0b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c0e:	89 50 04             	mov    %edx,0x4(%rax)
  803c11:	bf 06 00 00 00       	mov    $0x6,%edi
  803c16:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803c1d:	00 00 00 
  803c20:	ff d0                	callq  *%rax
  803c22:	c9                   	leaveq 
  803c23:	c3                   	retq   

0000000000803c24 <nsipc_recv>:
  803c24:	55                   	push   %rbp
  803c25:	48 89 e5             	mov    %rsp,%rbp
  803c28:	48 83 ec 30          	sub    $0x30,%rsp
  803c2c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c2f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c33:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803c36:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803c39:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c40:	00 00 00 
  803c43:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803c46:	89 10                	mov    %edx,(%rax)
  803c48:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c4f:	00 00 00 
  803c52:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c55:	89 50 04             	mov    %edx,0x4(%rax)
  803c58:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c5f:	00 00 00 
  803c62:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803c65:	89 50 08             	mov    %edx,0x8(%rax)
  803c68:	bf 07 00 00 00       	mov    $0x7,%edi
  803c6d:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803c74:	00 00 00 
  803c77:	ff d0                	callq  *%rax
  803c79:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c7c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c80:	78 69                	js     803ceb <nsipc_recv+0xc7>
  803c82:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803c89:	7f 08                	jg     803c93 <nsipc_recv+0x6f>
  803c8b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c8e:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803c91:	7e 35                	jle    803cc8 <nsipc_recv+0xa4>
  803c93:	48 b9 19 50 80 00 00 	movabs $0x805019,%rcx
  803c9a:	00 00 00 
  803c9d:	48 ba 2e 50 80 00 00 	movabs $0x80502e,%rdx
  803ca4:	00 00 00 
  803ca7:	be 62 00 00 00       	mov    $0x62,%esi
  803cac:	48 bf 43 50 80 00 00 	movabs $0x805043,%rdi
  803cb3:	00 00 00 
  803cb6:	b8 00 00 00 00       	mov    $0x0,%eax
  803cbb:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  803cc2:	00 00 00 
  803cc5:	41 ff d0             	callq  *%r8
  803cc8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ccb:	48 63 d0             	movslq %eax,%rdx
  803cce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803cd2:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803cd9:	00 00 00 
  803cdc:	48 89 c7             	mov    %rax,%rdi
  803cdf:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  803ce6:	00 00 00 
  803ce9:	ff d0                	callq  *%rax
  803ceb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cee:	c9                   	leaveq 
  803cef:	c3                   	retq   

0000000000803cf0 <nsipc_send>:
  803cf0:	55                   	push   %rbp
  803cf1:	48 89 e5             	mov    %rsp,%rbp
  803cf4:	48 83 ec 20          	sub    $0x20,%rsp
  803cf8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cfb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cff:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803d02:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803d05:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d0c:	00 00 00 
  803d0f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d12:	89 10                	mov    %edx,(%rax)
  803d14:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803d1b:	7e 35                	jle    803d52 <nsipc_send+0x62>
  803d1d:	48 b9 52 50 80 00 00 	movabs $0x805052,%rcx
  803d24:	00 00 00 
  803d27:	48 ba 2e 50 80 00 00 	movabs $0x80502e,%rdx
  803d2e:	00 00 00 
  803d31:	be 6d 00 00 00       	mov    $0x6d,%esi
  803d36:	48 bf 43 50 80 00 00 	movabs $0x805043,%rdi
  803d3d:	00 00 00 
  803d40:	b8 00 00 00 00       	mov    $0x0,%eax
  803d45:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  803d4c:	00 00 00 
  803d4f:	41 ff d0             	callq  *%r8
  803d52:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d55:	48 63 d0             	movslq %eax,%rdx
  803d58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d5c:	48 89 c6             	mov    %rax,%rsi
  803d5f:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803d66:	00 00 00 
  803d69:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  803d70:	00 00 00 
  803d73:	ff d0                	callq  *%rax
  803d75:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d7c:	00 00 00 
  803d7f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d82:	89 50 04             	mov    %edx,0x4(%rax)
  803d85:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d8c:	00 00 00 
  803d8f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803d92:	89 50 08             	mov    %edx,0x8(%rax)
  803d95:	bf 08 00 00 00       	mov    $0x8,%edi
  803d9a:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803da1:	00 00 00 
  803da4:	ff d0                	callq  *%rax
  803da6:	c9                   	leaveq 
  803da7:	c3                   	retq   

0000000000803da8 <nsipc_socket>:
  803da8:	55                   	push   %rbp
  803da9:	48 89 e5             	mov    %rsp,%rbp
  803dac:	48 83 ec 10          	sub    $0x10,%rsp
  803db0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803db3:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803db6:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803db9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dc0:	00 00 00 
  803dc3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803dc6:	89 10                	mov    %edx,(%rax)
  803dc8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dcf:	00 00 00 
  803dd2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803dd5:	89 50 04             	mov    %edx,0x4(%rax)
  803dd8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ddf:	00 00 00 
  803de2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803de5:	89 50 08             	mov    %edx,0x8(%rax)
  803de8:	bf 09 00 00 00       	mov    $0x9,%edi
  803ded:	48 b8 af 39 80 00 00 	movabs $0x8039af,%rax
  803df4:	00 00 00 
  803df7:	ff d0                	callq  *%rax
  803df9:	c9                   	leaveq 
  803dfa:	c3                   	retq   

0000000000803dfb <pipe>:
  803dfb:	55                   	push   %rbp
  803dfc:	48 89 e5             	mov    %rsp,%rbp
  803dff:	53                   	push   %rbx
  803e00:	48 83 ec 38          	sub    $0x38,%rsp
  803e04:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803e08:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803e0c:	48 89 c7             	mov    %rax,%rdi
  803e0f:	48 b8 12 26 80 00 00 	movabs $0x802612,%rax
  803e16:	00 00 00 
  803e19:	ff d0                	callq  *%rax
  803e1b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e1e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e22:	0f 88 bf 01 00 00    	js     803fe7 <pipe+0x1ec>
  803e28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e2c:	ba 07 04 00 00       	mov    $0x407,%edx
  803e31:	48 89 c6             	mov    %rax,%rsi
  803e34:	bf 00 00 00 00       	mov    $0x0,%edi
  803e39:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  803e40:	00 00 00 
  803e43:	ff d0                	callq  *%rax
  803e45:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e48:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e4c:	0f 88 95 01 00 00    	js     803fe7 <pipe+0x1ec>
  803e52:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803e56:	48 89 c7             	mov    %rax,%rdi
  803e59:	48 b8 12 26 80 00 00 	movabs $0x802612,%rax
  803e60:	00 00 00 
  803e63:	ff d0                	callq  *%rax
  803e65:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e68:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e6c:	0f 88 5d 01 00 00    	js     803fcf <pipe+0x1d4>
  803e72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e76:	ba 07 04 00 00       	mov    $0x407,%edx
  803e7b:	48 89 c6             	mov    %rax,%rsi
  803e7e:	bf 00 00 00 00       	mov    $0x0,%edi
  803e83:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  803e8a:	00 00 00 
  803e8d:	ff d0                	callq  *%rax
  803e8f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e92:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e96:	0f 88 33 01 00 00    	js     803fcf <pipe+0x1d4>
  803e9c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ea0:	48 89 c7             	mov    %rax,%rdi
  803ea3:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  803eaa:	00 00 00 
  803ead:	ff d0                	callq  *%rax
  803eaf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803eb3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803eb7:	ba 07 04 00 00       	mov    $0x407,%edx
  803ebc:	48 89 c6             	mov    %rax,%rsi
  803ebf:	bf 00 00 00 00       	mov    $0x0,%edi
  803ec4:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  803ecb:	00 00 00 
  803ece:	ff d0                	callq  *%rax
  803ed0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ed3:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803ed7:	79 05                	jns    803ede <pipe+0xe3>
  803ed9:	e9 d9 00 00 00       	jmpq   803fb7 <pipe+0x1bc>
  803ede:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ee2:	48 89 c7             	mov    %rax,%rdi
  803ee5:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  803eec:	00 00 00 
  803eef:	ff d0                	callq  *%rax
  803ef1:	48 89 c2             	mov    %rax,%rdx
  803ef4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ef8:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803efe:	48 89 d1             	mov    %rdx,%rcx
  803f01:	ba 00 00 00 00       	mov    $0x0,%edx
  803f06:	48 89 c6             	mov    %rax,%rsi
  803f09:	bf 00 00 00 00       	mov    $0x0,%edi
  803f0e:	48 b8 e1 19 80 00 00 	movabs $0x8019e1,%rax
  803f15:	00 00 00 
  803f18:	ff d0                	callq  *%rax
  803f1a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f1d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f21:	79 1b                	jns    803f3e <pipe+0x143>
  803f23:	90                   	nop
  803f24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f28:	48 89 c6             	mov    %rax,%rsi
  803f2b:	bf 00 00 00 00       	mov    $0x0,%edi
  803f30:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  803f37:	00 00 00 
  803f3a:	ff d0                	callq  *%rax
  803f3c:	eb 79                	jmp    803fb7 <pipe+0x1bc>
  803f3e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f42:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803f49:	00 00 00 
  803f4c:	8b 12                	mov    (%rdx),%edx
  803f4e:	89 10                	mov    %edx,(%rax)
  803f50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f54:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803f5b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f5f:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803f66:	00 00 00 
  803f69:	8b 12                	mov    (%rdx),%edx
  803f6b:	89 10                	mov    %edx,(%rax)
  803f6d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f71:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803f78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f7c:	48 89 c7             	mov    %rax,%rdi
  803f7f:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  803f86:	00 00 00 
  803f89:	ff d0                	callq  *%rax
  803f8b:	89 c2                	mov    %eax,%edx
  803f8d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803f91:	89 10                	mov    %edx,(%rax)
  803f93:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803f97:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803f9b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f9f:	48 89 c7             	mov    %rax,%rdi
  803fa2:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  803fa9:	00 00 00 
  803fac:	ff d0                	callq  *%rax
  803fae:	89 03                	mov    %eax,(%rbx)
  803fb0:	b8 00 00 00 00       	mov    $0x0,%eax
  803fb5:	eb 33                	jmp    803fea <pipe+0x1ef>
  803fb7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fbb:	48 89 c6             	mov    %rax,%rsi
  803fbe:	bf 00 00 00 00       	mov    $0x0,%edi
  803fc3:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  803fca:	00 00 00 
  803fcd:	ff d0                	callq  *%rax
  803fcf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fd3:	48 89 c6             	mov    %rax,%rsi
  803fd6:	bf 00 00 00 00       	mov    $0x0,%edi
  803fdb:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  803fe2:	00 00 00 
  803fe5:	ff d0                	callq  *%rax
  803fe7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fea:	48 83 c4 38          	add    $0x38,%rsp
  803fee:	5b                   	pop    %rbx
  803fef:	5d                   	pop    %rbp
  803ff0:	c3                   	retq   

0000000000803ff1 <_pipeisclosed>:
  803ff1:	55                   	push   %rbp
  803ff2:	48 89 e5             	mov    %rsp,%rbp
  803ff5:	53                   	push   %rbx
  803ff6:	48 83 ec 28          	sub    $0x28,%rsp
  803ffa:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803ffe:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804002:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804009:	00 00 00 
  80400c:	48 8b 00             	mov    (%rax),%rax
  80400f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804015:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804018:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80401c:	48 89 c7             	mov    %rax,%rdi
  80401f:	48 b8 9f 47 80 00 00 	movabs $0x80479f,%rax
  804026:	00 00 00 
  804029:	ff d0                	callq  *%rax
  80402b:	89 c3                	mov    %eax,%ebx
  80402d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804031:	48 89 c7             	mov    %rax,%rdi
  804034:	48 b8 9f 47 80 00 00 	movabs $0x80479f,%rax
  80403b:	00 00 00 
  80403e:	ff d0                	callq  *%rax
  804040:	39 c3                	cmp    %eax,%ebx
  804042:	0f 94 c0             	sete   %al
  804045:	0f b6 c0             	movzbl %al,%eax
  804048:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80404b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804052:	00 00 00 
  804055:	48 8b 00             	mov    (%rax),%rax
  804058:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80405e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804061:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804064:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804067:	75 05                	jne    80406e <_pipeisclosed+0x7d>
  804069:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80406c:	eb 4f                	jmp    8040bd <_pipeisclosed+0xcc>
  80406e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804071:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804074:	74 42                	je     8040b8 <_pipeisclosed+0xc7>
  804076:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  80407a:	75 3c                	jne    8040b8 <_pipeisclosed+0xc7>
  80407c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804083:	00 00 00 
  804086:	48 8b 00             	mov    (%rax),%rax
  804089:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80408f:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  804092:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804095:	89 c6                	mov    %eax,%esi
  804097:	48 bf 63 50 80 00 00 	movabs $0x805063,%rdi
  80409e:	00 00 00 
  8040a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8040a6:	49 b8 ad 04 80 00 00 	movabs $0x8004ad,%r8
  8040ad:	00 00 00 
  8040b0:	41 ff d0             	callq  *%r8
  8040b3:	e9 4a ff ff ff       	jmpq   804002 <_pipeisclosed+0x11>
  8040b8:	e9 45 ff ff ff       	jmpq   804002 <_pipeisclosed+0x11>
  8040bd:	48 83 c4 28          	add    $0x28,%rsp
  8040c1:	5b                   	pop    %rbx
  8040c2:	5d                   	pop    %rbp
  8040c3:	c3                   	retq   

00000000008040c4 <pipeisclosed>:
  8040c4:	55                   	push   %rbp
  8040c5:	48 89 e5             	mov    %rsp,%rbp
  8040c8:	48 83 ec 30          	sub    $0x30,%rsp
  8040cc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8040cf:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8040d3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8040d6:	48 89 d6             	mov    %rdx,%rsi
  8040d9:	89 c7                	mov    %eax,%edi
  8040db:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  8040e2:	00 00 00 
  8040e5:	ff d0                	callq  *%rax
  8040e7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040ee:	79 05                	jns    8040f5 <pipeisclosed+0x31>
  8040f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040f3:	eb 31                	jmp    804126 <pipeisclosed+0x62>
  8040f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8040f9:	48 89 c7             	mov    %rax,%rdi
  8040fc:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  804103:	00 00 00 
  804106:	ff d0                	callq  *%rax
  804108:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80410c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804110:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804114:	48 89 d6             	mov    %rdx,%rsi
  804117:	48 89 c7             	mov    %rax,%rdi
  80411a:	48 b8 f1 3f 80 00 00 	movabs $0x803ff1,%rax
  804121:	00 00 00 
  804124:	ff d0                	callq  *%rax
  804126:	c9                   	leaveq 
  804127:	c3                   	retq   

0000000000804128 <devpipe_read>:
  804128:	55                   	push   %rbp
  804129:	48 89 e5             	mov    %rsp,%rbp
  80412c:	48 83 ec 40          	sub    $0x40,%rsp
  804130:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804134:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804138:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80413c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804140:	48 89 c7             	mov    %rax,%rdi
  804143:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  80414a:	00 00 00 
  80414d:	ff d0                	callq  *%rax
  80414f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804153:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804157:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80415b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804162:	00 
  804163:	e9 92 00 00 00       	jmpq   8041fa <devpipe_read+0xd2>
  804168:	eb 41                	jmp    8041ab <devpipe_read+0x83>
  80416a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80416f:	74 09                	je     80417a <devpipe_read+0x52>
  804171:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804175:	e9 92 00 00 00       	jmpq   80420c <devpipe_read+0xe4>
  80417a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80417e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804182:	48 89 d6             	mov    %rdx,%rsi
  804185:	48 89 c7             	mov    %rax,%rdi
  804188:	48 b8 f1 3f 80 00 00 	movabs $0x803ff1,%rax
  80418f:	00 00 00 
  804192:	ff d0                	callq  *%rax
  804194:	85 c0                	test   %eax,%eax
  804196:	74 07                	je     80419f <devpipe_read+0x77>
  804198:	b8 00 00 00 00       	mov    $0x0,%eax
  80419d:	eb 6d                	jmp    80420c <devpipe_read+0xe4>
  80419f:	48 b8 53 19 80 00 00 	movabs $0x801953,%rax
  8041a6:	00 00 00 
  8041a9:	ff d0                	callq  *%rax
  8041ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041af:	8b 10                	mov    (%rax),%edx
  8041b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041b5:	8b 40 04             	mov    0x4(%rax),%eax
  8041b8:	39 c2                	cmp    %eax,%edx
  8041ba:	74 ae                	je     80416a <devpipe_read+0x42>
  8041bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041c0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8041c4:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8041c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041cc:	8b 00                	mov    (%rax),%eax
  8041ce:	99                   	cltd   
  8041cf:	c1 ea 1b             	shr    $0x1b,%edx
  8041d2:	01 d0                	add    %edx,%eax
  8041d4:	83 e0 1f             	and    $0x1f,%eax
  8041d7:	29 d0                	sub    %edx,%eax
  8041d9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8041dd:	48 98                	cltq   
  8041df:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8041e4:	88 01                	mov    %al,(%rcx)
  8041e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041ea:	8b 00                	mov    (%rax),%eax
  8041ec:	8d 50 01             	lea    0x1(%rax),%edx
  8041ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041f3:	89 10                	mov    %edx,(%rax)
  8041f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8041fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041fe:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804202:	0f 82 60 ff ff ff    	jb     804168 <devpipe_read+0x40>
  804208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80420c:	c9                   	leaveq 
  80420d:	c3                   	retq   

000000000080420e <devpipe_write>:
  80420e:	55                   	push   %rbp
  80420f:	48 89 e5             	mov    %rsp,%rbp
  804212:	48 83 ec 40          	sub    $0x40,%rsp
  804216:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80421a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80421e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804222:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804226:	48 89 c7             	mov    %rax,%rdi
  804229:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  804230:	00 00 00 
  804233:	ff d0                	callq  *%rax
  804235:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804239:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80423d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804241:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804248:	00 
  804249:	e9 8e 00 00 00       	jmpq   8042dc <devpipe_write+0xce>
  80424e:	eb 31                	jmp    804281 <devpipe_write+0x73>
  804250:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804254:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804258:	48 89 d6             	mov    %rdx,%rsi
  80425b:	48 89 c7             	mov    %rax,%rdi
  80425e:	48 b8 f1 3f 80 00 00 	movabs $0x803ff1,%rax
  804265:	00 00 00 
  804268:	ff d0                	callq  *%rax
  80426a:	85 c0                	test   %eax,%eax
  80426c:	74 07                	je     804275 <devpipe_write+0x67>
  80426e:	b8 00 00 00 00       	mov    $0x0,%eax
  804273:	eb 79                	jmp    8042ee <devpipe_write+0xe0>
  804275:	48 b8 53 19 80 00 00 	movabs $0x801953,%rax
  80427c:	00 00 00 
  80427f:	ff d0                	callq  *%rax
  804281:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804285:	8b 40 04             	mov    0x4(%rax),%eax
  804288:	48 63 d0             	movslq %eax,%rdx
  80428b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80428f:	8b 00                	mov    (%rax),%eax
  804291:	48 98                	cltq   
  804293:	48 83 c0 20          	add    $0x20,%rax
  804297:	48 39 c2             	cmp    %rax,%rdx
  80429a:	73 b4                	jae    804250 <devpipe_write+0x42>
  80429c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042a0:	8b 40 04             	mov    0x4(%rax),%eax
  8042a3:	99                   	cltd   
  8042a4:	c1 ea 1b             	shr    $0x1b,%edx
  8042a7:	01 d0                	add    %edx,%eax
  8042a9:	83 e0 1f             	and    $0x1f,%eax
  8042ac:	29 d0                	sub    %edx,%eax
  8042ae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8042b2:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8042b6:	48 01 ca             	add    %rcx,%rdx
  8042b9:	0f b6 0a             	movzbl (%rdx),%ecx
  8042bc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8042c0:	48 98                	cltq   
  8042c2:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8042c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042ca:	8b 40 04             	mov    0x4(%rax),%eax
  8042cd:	8d 50 01             	lea    0x1(%rax),%edx
  8042d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042d4:	89 50 04             	mov    %edx,0x4(%rax)
  8042d7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8042dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042e0:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8042e4:	0f 82 64 ff ff ff    	jb     80424e <devpipe_write+0x40>
  8042ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042ee:	c9                   	leaveq 
  8042ef:	c3                   	retq   

00000000008042f0 <devpipe_stat>:
  8042f0:	55                   	push   %rbp
  8042f1:	48 89 e5             	mov    %rsp,%rbp
  8042f4:	48 83 ec 20          	sub    $0x20,%rsp
  8042f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8042fc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804300:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804304:	48 89 c7             	mov    %rax,%rdi
  804307:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  80430e:	00 00 00 
  804311:	ff d0                	callq  *%rax
  804313:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804317:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80431b:	48 be 76 50 80 00 00 	movabs $0x805076,%rsi
  804322:	00 00 00 
  804325:	48 89 c7             	mov    %rax,%rdi
  804328:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  80432f:	00 00 00 
  804332:	ff d0                	callq  *%rax
  804334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804338:	8b 50 04             	mov    0x4(%rax),%edx
  80433b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80433f:	8b 00                	mov    (%rax),%eax
  804341:	29 c2                	sub    %eax,%edx
  804343:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804347:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80434d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804351:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804358:	00 00 00 
  80435b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80435f:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804366:	00 00 00 
  804369:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804370:	b8 00 00 00 00       	mov    $0x0,%eax
  804375:	c9                   	leaveq 
  804376:	c3                   	retq   

0000000000804377 <devpipe_close>:
  804377:	55                   	push   %rbp
  804378:	48 89 e5             	mov    %rsp,%rbp
  80437b:	48 83 ec 10          	sub    $0x10,%rsp
  80437f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804383:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804387:	48 89 c6             	mov    %rax,%rsi
  80438a:	bf 00 00 00 00       	mov    $0x0,%edi
  80438f:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  804396:	00 00 00 
  804399:	ff d0                	callq  *%rax
  80439b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80439f:	48 89 c7             	mov    %rax,%rdi
  8043a2:	48 b8 e7 25 80 00 00 	movabs $0x8025e7,%rax
  8043a9:	00 00 00 
  8043ac:	ff d0                	callq  *%rax
  8043ae:	48 89 c6             	mov    %rax,%rsi
  8043b1:	bf 00 00 00 00       	mov    $0x0,%edi
  8043b6:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  8043bd:	00 00 00 
  8043c0:	ff d0                	callq  *%rax
  8043c2:	c9                   	leaveq 
  8043c3:	c3                   	retq   

00000000008043c4 <cputchar>:
  8043c4:	55                   	push   %rbp
  8043c5:	48 89 e5             	mov    %rsp,%rbp
  8043c8:	48 83 ec 20          	sub    $0x20,%rsp
  8043cc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8043cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8043d2:	88 45 ff             	mov    %al,-0x1(%rbp)
  8043d5:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8043d9:	be 01 00 00 00       	mov    $0x1,%esi
  8043de:	48 89 c7             	mov    %rax,%rdi
  8043e1:	48 b8 49 18 80 00 00 	movabs $0x801849,%rax
  8043e8:	00 00 00 
  8043eb:	ff d0                	callq  *%rax
  8043ed:	c9                   	leaveq 
  8043ee:	c3                   	retq   

00000000008043ef <getchar>:
  8043ef:	55                   	push   %rbp
  8043f0:	48 89 e5             	mov    %rsp,%rbp
  8043f3:	48 83 ec 10          	sub    $0x10,%rsp
  8043f7:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8043fb:	ba 01 00 00 00       	mov    $0x1,%edx
  804400:	48 89 c6             	mov    %rax,%rsi
  804403:	bf 00 00 00 00       	mov    $0x0,%edi
  804408:	48 b8 dc 2a 80 00 00 	movabs $0x802adc,%rax
  80440f:	00 00 00 
  804412:	ff d0                	callq  *%rax
  804414:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804417:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80441b:	79 05                	jns    804422 <getchar+0x33>
  80441d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804420:	eb 14                	jmp    804436 <getchar+0x47>
  804422:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804426:	7f 07                	jg     80442f <getchar+0x40>
  804428:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80442d:	eb 07                	jmp    804436 <getchar+0x47>
  80442f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804433:	0f b6 c0             	movzbl %al,%eax
  804436:	c9                   	leaveq 
  804437:	c3                   	retq   

0000000000804438 <iscons>:
  804438:	55                   	push   %rbp
  804439:	48 89 e5             	mov    %rsp,%rbp
  80443c:	48 83 ec 20          	sub    $0x20,%rsp
  804440:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804443:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804447:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80444a:	48 89 d6             	mov    %rdx,%rsi
  80444d:	89 c7                	mov    %eax,%edi
  80444f:	48 b8 aa 26 80 00 00 	movabs $0x8026aa,%rax
  804456:	00 00 00 
  804459:	ff d0                	callq  *%rax
  80445b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80445e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804462:	79 05                	jns    804469 <iscons+0x31>
  804464:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804467:	eb 1a                	jmp    804483 <iscons+0x4b>
  804469:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80446d:	8b 10                	mov    (%rax),%edx
  80446f:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  804476:	00 00 00 
  804479:	8b 00                	mov    (%rax),%eax
  80447b:	39 c2                	cmp    %eax,%edx
  80447d:	0f 94 c0             	sete   %al
  804480:	0f b6 c0             	movzbl %al,%eax
  804483:	c9                   	leaveq 
  804484:	c3                   	retq   

0000000000804485 <opencons>:
  804485:	55                   	push   %rbp
  804486:	48 89 e5             	mov    %rsp,%rbp
  804489:	48 83 ec 10          	sub    $0x10,%rsp
  80448d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804491:	48 89 c7             	mov    %rax,%rdi
  804494:	48 b8 12 26 80 00 00 	movabs $0x802612,%rax
  80449b:	00 00 00 
  80449e:	ff d0                	callq  *%rax
  8044a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044a7:	79 05                	jns    8044ae <opencons+0x29>
  8044a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044ac:	eb 5b                	jmp    804509 <opencons+0x84>
  8044ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044b2:	ba 07 04 00 00       	mov    $0x407,%edx
  8044b7:	48 89 c6             	mov    %rax,%rsi
  8044ba:	bf 00 00 00 00       	mov    $0x0,%edi
  8044bf:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  8044c6:	00 00 00 
  8044c9:	ff d0                	callq  *%rax
  8044cb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044ce:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044d2:	79 05                	jns    8044d9 <opencons+0x54>
  8044d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044d7:	eb 30                	jmp    804509 <opencons+0x84>
  8044d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044dd:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8044e4:	00 00 00 
  8044e7:	8b 12                	mov    (%rdx),%edx
  8044e9:	89 10                	mov    %edx,(%rax)
  8044eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044ef:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8044f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044fa:	48 89 c7             	mov    %rax,%rdi
  8044fd:	48 b8 c4 25 80 00 00 	movabs $0x8025c4,%rax
  804504:	00 00 00 
  804507:	ff d0                	callq  *%rax
  804509:	c9                   	leaveq 
  80450a:	c3                   	retq   

000000000080450b <devcons_read>:
  80450b:	55                   	push   %rbp
  80450c:	48 89 e5             	mov    %rsp,%rbp
  80450f:	48 83 ec 30          	sub    $0x30,%rsp
  804513:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804517:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80451b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80451f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804524:	75 07                	jne    80452d <devcons_read+0x22>
  804526:	b8 00 00 00 00       	mov    $0x0,%eax
  80452b:	eb 4b                	jmp    804578 <devcons_read+0x6d>
  80452d:	eb 0c                	jmp    80453b <devcons_read+0x30>
  80452f:	48 b8 53 19 80 00 00 	movabs $0x801953,%rax
  804536:	00 00 00 
  804539:	ff d0                	callq  *%rax
  80453b:	48 b8 93 18 80 00 00 	movabs $0x801893,%rax
  804542:	00 00 00 
  804545:	ff d0                	callq  *%rax
  804547:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80454a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80454e:	74 df                	je     80452f <devcons_read+0x24>
  804550:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804554:	79 05                	jns    80455b <devcons_read+0x50>
  804556:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804559:	eb 1d                	jmp    804578 <devcons_read+0x6d>
  80455b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80455f:	75 07                	jne    804568 <devcons_read+0x5d>
  804561:	b8 00 00 00 00       	mov    $0x0,%eax
  804566:	eb 10                	jmp    804578 <devcons_read+0x6d>
  804568:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80456b:	89 c2                	mov    %eax,%edx
  80456d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804571:	88 10                	mov    %dl,(%rax)
  804573:	b8 01 00 00 00       	mov    $0x1,%eax
  804578:	c9                   	leaveq 
  804579:	c3                   	retq   

000000000080457a <devcons_write>:
  80457a:	55                   	push   %rbp
  80457b:	48 89 e5             	mov    %rsp,%rbp
  80457e:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804585:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  80458c:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804593:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80459a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8045a1:	eb 76                	jmp    804619 <devcons_write+0x9f>
  8045a3:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8045aa:	89 c2                	mov    %eax,%edx
  8045ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045af:	29 c2                	sub    %eax,%edx
  8045b1:	89 d0                	mov    %edx,%eax
  8045b3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8045b6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045b9:	83 f8 7f             	cmp    $0x7f,%eax
  8045bc:	76 07                	jbe    8045c5 <devcons_write+0x4b>
  8045be:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8045c5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045c8:	48 63 d0             	movslq %eax,%rdx
  8045cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045ce:	48 63 c8             	movslq %eax,%rcx
  8045d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8045d8:	48 01 c1             	add    %rax,%rcx
  8045db:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8045e2:	48 89 ce             	mov    %rcx,%rsi
  8045e5:	48 89 c7             	mov    %rax,%rdi
  8045e8:	48 b8 86 13 80 00 00 	movabs $0x801386,%rax
  8045ef:	00 00 00 
  8045f2:	ff d0                	callq  *%rax
  8045f4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045f7:	48 63 d0             	movslq %eax,%rdx
  8045fa:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804601:	48 89 d6             	mov    %rdx,%rsi
  804604:	48 89 c7             	mov    %rax,%rdi
  804607:	48 b8 49 18 80 00 00 	movabs $0x801849,%rax
  80460e:	00 00 00 
  804611:	ff d0                	callq  *%rax
  804613:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804616:	01 45 fc             	add    %eax,-0x4(%rbp)
  804619:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80461c:	48 98                	cltq   
  80461e:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804625:	0f 82 78 ff ff ff    	jb     8045a3 <devcons_write+0x29>
  80462b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80462e:	c9                   	leaveq 
  80462f:	c3                   	retq   

0000000000804630 <devcons_close>:
  804630:	55                   	push   %rbp
  804631:	48 89 e5             	mov    %rsp,%rbp
  804634:	48 83 ec 08          	sub    $0x8,%rsp
  804638:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80463c:	b8 00 00 00 00       	mov    $0x0,%eax
  804641:	c9                   	leaveq 
  804642:	c3                   	retq   

0000000000804643 <devcons_stat>:
  804643:	55                   	push   %rbp
  804644:	48 89 e5             	mov    %rsp,%rbp
  804647:	48 83 ec 10          	sub    $0x10,%rsp
  80464b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80464f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804653:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804657:	48 be 82 50 80 00 00 	movabs $0x805082,%rsi
  80465e:	00 00 00 
  804661:	48 89 c7             	mov    %rax,%rdi
  804664:	48 b8 62 10 80 00 00 	movabs $0x801062,%rax
  80466b:	00 00 00 
  80466e:	ff d0                	callq  *%rax
  804670:	b8 00 00 00 00       	mov    $0x0,%eax
  804675:	c9                   	leaveq 
  804676:	c3                   	retq   

0000000000804677 <set_pgfault_handler>:
  804677:	55                   	push   %rbp
  804678:	48 89 e5             	mov    %rsp,%rbp
  80467b:	48 83 ec 20          	sub    $0x20,%rsp
  80467f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804683:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80468a:	00 00 00 
  80468d:	48 8b 00             	mov    (%rax),%rax
  804690:	48 85 c0             	test   %rax,%rax
  804693:	75 6f                	jne    804704 <set_pgfault_handler+0x8d>
  804695:	ba 07 00 00 00       	mov    $0x7,%edx
  80469a:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  80469f:	bf 00 00 00 00       	mov    $0x0,%edi
  8046a4:	48 b8 91 19 80 00 00 	movabs $0x801991,%rax
  8046ab:	00 00 00 
  8046ae:	ff d0                	callq  *%rax
  8046b0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046b7:	79 30                	jns    8046e9 <set_pgfault_handler+0x72>
  8046b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046bc:	89 c1                	mov    %eax,%ecx
  8046be:	48 ba 90 50 80 00 00 	movabs $0x805090,%rdx
  8046c5:	00 00 00 
  8046c8:	be 22 00 00 00       	mov    $0x22,%esi
  8046cd:	48 bf af 50 80 00 00 	movabs $0x8050af,%rdi
  8046d4:	00 00 00 
  8046d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8046dc:	49 b8 74 02 80 00 00 	movabs $0x800274,%r8
  8046e3:	00 00 00 
  8046e6:	41 ff d0             	callq  *%r8
  8046e9:	48 be 17 47 80 00 00 	movabs $0x804717,%rsi
  8046f0:	00 00 00 
  8046f3:	bf 00 00 00 00       	mov    $0x0,%edi
  8046f8:	48 b8 1b 1b 80 00 00 	movabs $0x801b1b,%rax
  8046ff:	00 00 00 
  804702:	ff d0                	callq  *%rax
  804704:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80470b:	00 00 00 
  80470e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804712:	48 89 10             	mov    %rdx,(%rax)
  804715:	c9                   	leaveq 
  804716:	c3                   	retq   

0000000000804717 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  804717:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  80471a:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  804721:	00 00 00 
call *%rax
  804724:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  804726:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  80472d:	00 08 
    movq 152(%rsp), %rax
  80472f:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  804736:	00 
    movq 136(%rsp), %rbx
  804737:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  80473e:	00 
movq %rbx, (%rax)
  80473f:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804742:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  804746:	4c 8b 3c 24          	mov    (%rsp),%r15
  80474a:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  80474f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  804754:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804759:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  80475e:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  804763:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  804768:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  80476d:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  804772:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  804777:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  80477c:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804781:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  804786:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  80478b:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  804790:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  804794:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  804798:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  804799:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  80479e:	c3                   	retq   

000000000080479f <pageref>:
  80479f:	55                   	push   %rbp
  8047a0:	48 89 e5             	mov    %rsp,%rbp
  8047a3:	48 83 ec 18          	sub    $0x18,%rsp
  8047a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8047ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047af:	48 c1 e8 15          	shr    $0x15,%rax
  8047b3:	48 89 c2             	mov    %rax,%rdx
  8047b6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8047bd:	01 00 00 
  8047c0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8047c4:	83 e0 01             	and    $0x1,%eax
  8047c7:	48 85 c0             	test   %rax,%rax
  8047ca:	75 07                	jne    8047d3 <pageref+0x34>
  8047cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8047d1:	eb 53                	jmp    804826 <pageref+0x87>
  8047d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047d7:	48 c1 e8 0c          	shr    $0xc,%rax
  8047db:	48 89 c2             	mov    %rax,%rdx
  8047de:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8047e5:	01 00 00 
  8047e8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8047ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8047f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8047f4:	83 e0 01             	and    $0x1,%eax
  8047f7:	48 85 c0             	test   %rax,%rax
  8047fa:	75 07                	jne    804803 <pageref+0x64>
  8047fc:	b8 00 00 00 00       	mov    $0x0,%eax
  804801:	eb 23                	jmp    804826 <pageref+0x87>
  804803:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804807:	48 c1 e8 0c          	shr    $0xc,%rax
  80480b:	48 89 c2             	mov    %rax,%rdx
  80480e:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804815:	00 00 00 
  804818:	48 c1 e2 04          	shl    $0x4,%rdx
  80481c:	48 01 d0             	add    %rdx,%rax
  80481f:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804823:	0f b7 c0             	movzwl %ax,%eax
  804826:	c9                   	leaveq 
  804827:	c3                   	retq   
