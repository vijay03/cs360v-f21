
vmm/guest/obj/user/testpiperace:     file format elf64-x86-64


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
  80003c:	e8 44 03 00 00       	callq  800385 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 50          	sub    $0x50,%rsp
  80004b:	89 7d bc             	mov    %edi,-0x44(%rbp)
  80004e:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
  800052:	48 bf e0 49 80 00 00 	movabs $0x8049e0,%rdi
  800059:	00 00 00 
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  800068:	00 00 00 
  80006b:	ff d2                	callq  *%rdx
  80006d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800071:	48 89 c7             	mov    %rax,%rdi
  800074:	48 b8 3b 40 80 00 00 	movabs $0x80403b,%rax
  80007b:	00 00 00 
  80007e:	ff d0                	callq  *%rax
  800080:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800083:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800087:	79 30                	jns    8000b9 <umain+0x76>
  800089:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80008c:	89 c1                	mov    %eax,%ecx
  80008e:	48 ba f9 49 80 00 00 	movabs $0x8049f9,%rdx
  800095:	00 00 00 
  800098:	be 0e 00 00 00       	mov    $0xe,%esi
  80009d:	48 bf 02 4a 80 00 00 	movabs $0x804a02,%rdi
  8000a4:	00 00 00 
  8000a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ac:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8000b3:	00 00 00 
  8000b6:	41 ff d0             	callq  *%r8
  8000b9:	c7 45 f4 c8 00 00 00 	movl   $0xc8,-0xc(%rbp)
  8000c0:	48 b8 c8 22 80 00 00 	movabs $0x8022c8,%rax
  8000c7:	00 00 00 
  8000ca:	ff d0                	callq  *%rax
  8000cc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000cf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000d3:	79 30                	jns    800105 <umain+0xc2>
  8000d5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000d8:	89 c1                	mov    %eax,%ecx
  8000da:	48 ba 19 4a 80 00 00 	movabs $0x804a19,%rdx
  8000e1:	00 00 00 
  8000e4:	be 11 00 00 00       	mov    $0x11,%esi
  8000e9:	48 bf 02 4a 80 00 00 	movabs $0x804a02,%rdi
  8000f0:	00 00 00 
  8000f3:	b8 00 00 00 00       	mov    $0x0,%eax
  8000f8:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8000ff:	00 00 00 
  800102:	41 ff d0             	callq  *%r8
  800105:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800109:	0f 85 89 00 00 00    	jne    800198 <umain+0x155>
  80010f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800112:	89 c7                	mov    %eax,%edi
  800114:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  80011b:	00 00 00 
  80011e:	ff d0                	callq  *%rax
  800120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800127:	eb 4c                	jmp    800175 <umain+0x132>
  800129:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80012c:	89 c7                	mov    %eax,%edi
  80012e:	48 b8 04 43 80 00 00 	movabs $0x804304,%rax
  800135:	00 00 00 
  800138:	ff d0                	callq  *%rax
  80013a:	85 c0                	test   %eax,%eax
  80013c:	74 27                	je     800165 <umain+0x122>
  80013e:	48 bf 22 4a 80 00 00 	movabs $0x804a22,%rdi
  800145:	00 00 00 
  800148:	b8 00 00 00 00       	mov    $0x0,%eax
  80014d:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  800154:	00 00 00 
  800157:	ff d2                	callq  *%rdx
  800159:	48 b8 08 04 80 00 00 	movabs $0x800408,%rax
  800160:	00 00 00 
  800163:	ff d0                	callq  *%rax
  800165:	48 b8 0a 1b 80 00 00 	movabs $0x801b0a,%rax
  80016c:	00 00 00 
  80016f:	ff d0                	callq  *%rax
  800171:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800175:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800178:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  80017b:	7c ac                	jl     800129 <umain+0xe6>
  80017d:	ba 00 00 00 00       	mov    $0x0,%edx
  800182:	be 00 00 00 00       	mov    $0x0,%esi
  800187:	bf 00 00 00 00       	mov    $0x0,%edi
  80018c:	48 b8 3d 25 80 00 00 	movabs $0x80253d,%rax
  800193:	00 00 00 
  800196:	ff d0                	callq  *%rax
  800198:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80019b:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80019e:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8001a1:	89 c6                	mov    %eax,%esi
  8001a3:	48 bf 3d 4a 80 00 00 	movabs $0x804a3d,%rdi
  8001aa:	00 00 00 
  8001ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8001b2:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  8001b9:	00 00 00 
  8001bc:	ff d2                	callq  *%rdx
  8001be:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  8001c5:	00 
  8001c6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8001c9:	25 ff 03 00 00       	and    $0x3ff,%eax
  8001ce:	48 98                	cltq   
  8001d0:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8001d7:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8001de:	00 00 00 
  8001e1:	48 01 d0             	add    %rdx,%rax
  8001e4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8001e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8001ec:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8001f3:	00 00 00 
  8001f6:	48 29 c2             	sub    %rax,%rdx
  8001f9:	48 89 d0             	mov    %rdx,%rax
  8001fc:	48 c1 f8 03          	sar    $0x3,%rax
  800200:	48 89 c2             	mov    %rax,%rdx
  800203:	48 b8 a5 4f fa a4 4f 	movabs $0x4fa4fa4fa4fa4fa5,%rax
  80020a:	fa a4 4f 
  80020d:	48 0f af c2          	imul   %rdx,%rax
  800211:	48 89 c6             	mov    %rax,%rsi
  800214:	48 bf 48 4a 80 00 00 	movabs $0x804a48,%rdi
  80021b:	00 00 00 
  80021e:	b8 00 00 00 00       	mov    $0x0,%eax
  800223:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  80022a:	00 00 00 
  80022d:	ff d2                	callq  *%rdx
  80022f:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800232:	be 0a 00 00 00       	mov    $0xa,%esi
  800237:	89 c7                	mov    %eax,%edi
  800239:	48 b8 ea 2a 80 00 00 	movabs $0x802aea,%rax
  800240:	00 00 00 
  800243:	ff d0                	callq  *%rax
  800245:	eb 16                	jmp    80025d <umain+0x21a>
  800247:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80024a:	be 0a 00 00 00       	mov    $0xa,%esi
  80024f:	89 c7                	mov    %eax,%edi
  800251:	48 b8 ea 2a 80 00 00 	movabs $0x802aea,%rax
  800258:	00 00 00 
  80025b:	ff d0                	callq  *%rax
  80025d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800261:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  800267:	83 f8 02             	cmp    $0x2,%eax
  80026a:	74 db                	je     800247 <umain+0x204>
  80026c:	48 bf 53 4a 80 00 00 	movabs $0x804a53,%rdi
  800273:	00 00 00 
  800276:	b8 00 00 00 00       	mov    $0x0,%eax
  80027b:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  800282:	00 00 00 
  800285:	ff d2                	callq  *%rdx
  800287:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80028a:	89 c7                	mov    %eax,%edi
  80028c:	48 b8 04 43 80 00 00 	movabs $0x804304,%rax
  800293:	00 00 00 
  800296:	ff d0                	callq  *%rax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 2a                	je     8002c6 <umain+0x283>
  80029c:	48 ba 70 4a 80 00 00 	movabs $0x804a70,%rdx
  8002a3:	00 00 00 
  8002a6:	be 3b 00 00 00       	mov    $0x3b,%esi
  8002ab:	48 bf 02 4a 80 00 00 	movabs $0x804a02,%rdi
  8002b2:	00 00 00 
  8002b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8002ba:	48 b9 2b 04 80 00 00 	movabs $0x80042b,%rcx
  8002c1:	00 00 00 
  8002c4:	ff d1                	callq  *%rcx
  8002c6:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8002c9:	48 8d 55 c8          	lea    -0x38(%rbp),%rdx
  8002cd:	48 89 d6             	mov    %rdx,%rsi
  8002d0:	89 c7                	mov    %eax,%edi
  8002d2:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  8002d9:	00 00 00 
  8002dc:	ff d0                	callq  *%rax
  8002de:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8002e1:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8002e5:	79 30                	jns    800317 <umain+0x2d4>
  8002e7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8002ea:	89 c1                	mov    %eax,%ecx
  8002ec:	48 ba 9a 4a 80 00 00 	movabs $0x804a9a,%rdx
  8002f3:	00 00 00 
  8002f6:	be 3d 00 00 00       	mov    $0x3d,%esi
  8002fb:	48 bf 02 4a 80 00 00 	movabs $0x804a02,%rdi
  800302:	00 00 00 
  800305:	b8 00 00 00 00       	mov    $0x0,%eax
  80030a:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  800311:	00 00 00 
  800314:	41 ff d0             	callq  *%r8
  800317:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80031b:	48 89 c7             	mov    %rax,%rdi
  80031e:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  800325:	00 00 00 
  800328:	ff d0                	callq  *%rax
  80032a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80032e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800332:	48 89 c7             	mov    %rax,%rdi
  800335:	48 b8 a6 37 80 00 00 	movabs $0x8037a6,%rax
  80033c:	00 00 00 
  80033f:	ff d0                	callq  *%rax
  800341:	83 f8 04             	cmp    $0x4,%eax
  800344:	74 1d                	je     800363 <umain+0x320>
  800346:	48 bf b2 4a 80 00 00 	movabs $0x804ab2,%rdi
  80034d:	00 00 00 
  800350:	b8 00 00 00 00       	mov    $0x0,%eax
  800355:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  80035c:	00 00 00 
  80035f:	ff d2                	callq  *%rdx
  800361:	eb 20                	jmp    800383 <umain+0x340>
  800363:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800366:	89 c6                	mov    %eax,%esi
  800368:	48 bf c8 4a 80 00 00 	movabs $0x804ac8,%rdi
  80036f:	00 00 00 
  800372:	b8 00 00 00 00       	mov    $0x0,%eax
  800377:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  80037e:	00 00 00 
  800381:	ff d2                	callq  *%rdx
  800383:	c9                   	leaveq 
  800384:	c3                   	retq   

0000000000800385 <libmain>:
  800385:	55                   	push   %rbp
  800386:	48 89 e5             	mov    %rsp,%rbp
  800389:	48 83 ec 10          	sub    $0x10,%rsp
  80038d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800390:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800394:	48 b8 cc 1a 80 00 00 	movabs $0x801acc,%rax
  80039b:	00 00 00 
  80039e:	ff d0                	callq  *%rax
  8003a0:	25 ff 03 00 00       	and    $0x3ff,%eax
  8003a5:	48 98                	cltq   
  8003a7:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8003ae:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8003b5:	00 00 00 
  8003b8:	48 01 c2             	add    %rax,%rdx
  8003bb:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8003c2:	00 00 00 
  8003c5:	48 89 10             	mov    %rdx,(%rax)
  8003c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8003cc:	7e 14                	jle    8003e2 <libmain+0x5d>
  8003ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003d2:	48 8b 10             	mov    (%rax),%rdx
  8003d5:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8003dc:	00 00 00 
  8003df:	48 89 10             	mov    %rdx,(%rax)
  8003e2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003e9:	48 89 d6             	mov    %rdx,%rsi
  8003ec:	89 c7                	mov    %eax,%edi
  8003ee:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8003f5:	00 00 00 
  8003f8:	ff d0                	callq  *%rax
  8003fa:	48 b8 08 04 80 00 00 	movabs $0x800408,%rax
  800401:	00 00 00 
  800404:	ff d0                	callq  *%rax
  800406:	c9                   	leaveq 
  800407:	c3                   	retq   

0000000000800408 <exit>:
  800408:	55                   	push   %rbp
  800409:	48 89 e5             	mov    %rsp,%rbp
  80040c:	48 b8 bc 2a 80 00 00 	movabs $0x802abc,%rax
  800413:	00 00 00 
  800416:	ff d0                	callq  *%rax
  800418:	bf 00 00 00 00       	mov    $0x0,%edi
  80041d:	48 b8 88 1a 80 00 00 	movabs $0x801a88,%rax
  800424:	00 00 00 
  800427:	ff d0                	callq  *%rax
  800429:	5d                   	pop    %rbp
  80042a:	c3                   	retq   

000000000080042b <_panic>:
  80042b:	55                   	push   %rbp
  80042c:	48 89 e5             	mov    %rsp,%rbp
  80042f:	53                   	push   %rbx
  800430:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800437:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  80043e:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800444:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  80044b:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800452:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  800459:	84 c0                	test   %al,%al
  80045b:	74 23                	je     800480 <_panic+0x55>
  80045d:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800464:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800468:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  80046c:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800470:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800474:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800478:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80047c:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800480:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800487:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80048e:	00 00 00 
  800491:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800498:	00 00 00 
  80049b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80049f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  8004a6:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8004ad:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8004b4:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8004bb:	00 00 00 
  8004be:	48 8b 18             	mov    (%rax),%rbx
  8004c1:	48 b8 cc 1a 80 00 00 	movabs $0x801acc,%rax
  8004c8:	00 00 00 
  8004cb:	ff d0                	callq  *%rax
  8004cd:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8004d3:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8004da:	41 89 c8             	mov    %ecx,%r8d
  8004dd:	48 89 d1             	mov    %rdx,%rcx
  8004e0:	48 89 da             	mov    %rbx,%rdx
  8004e3:	89 c6                	mov    %eax,%esi
  8004e5:	48 bf e8 4a 80 00 00 	movabs $0x804ae8,%rdi
  8004ec:	00 00 00 
  8004ef:	b8 00 00 00 00       	mov    $0x0,%eax
  8004f4:	49 b9 64 06 80 00 00 	movabs $0x800664,%r9
  8004fb:	00 00 00 
  8004fe:	41 ff d1             	callq  *%r9
  800501:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  800508:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80050f:	48 89 d6             	mov    %rdx,%rsi
  800512:	48 89 c7             	mov    %rax,%rdi
  800515:	48 b8 b8 05 80 00 00 	movabs $0x8005b8,%rax
  80051c:	00 00 00 
  80051f:	ff d0                	callq  *%rax
  800521:	48 bf 0b 4b 80 00 00 	movabs $0x804b0b,%rdi
  800528:	00 00 00 
  80052b:	b8 00 00 00 00       	mov    $0x0,%eax
  800530:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  800537:	00 00 00 
  80053a:	ff d2                	callq  *%rdx
  80053c:	cc                   	int3   
  80053d:	eb fd                	jmp    80053c <_panic+0x111>

000000000080053f <putch>:
  80053f:	55                   	push   %rbp
  800540:	48 89 e5             	mov    %rsp,%rbp
  800543:	48 83 ec 10          	sub    $0x10,%rsp
  800547:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80054a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80054e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800552:	8b 00                	mov    (%rax),%eax
  800554:	8d 48 01             	lea    0x1(%rax),%ecx
  800557:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80055b:	89 0a                	mov    %ecx,(%rdx)
  80055d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800560:	89 d1                	mov    %edx,%ecx
  800562:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800566:	48 98                	cltq   
  800568:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80056c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800570:	8b 00                	mov    (%rax),%eax
  800572:	3d ff 00 00 00       	cmp    $0xff,%eax
  800577:	75 2c                	jne    8005a5 <putch+0x66>
  800579:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80057d:	8b 00                	mov    (%rax),%eax
  80057f:	48 98                	cltq   
  800581:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800585:	48 83 c2 08          	add    $0x8,%rdx
  800589:	48 89 c6             	mov    %rax,%rsi
  80058c:	48 89 d7             	mov    %rdx,%rdi
  80058f:	48 b8 00 1a 80 00 00 	movabs $0x801a00,%rax
  800596:	00 00 00 
  800599:	ff d0                	callq  *%rax
  80059b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80059f:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8005a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005a9:	8b 40 04             	mov    0x4(%rax),%eax
  8005ac:	8d 50 01             	lea    0x1(%rax),%edx
  8005af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005b3:	89 50 04             	mov    %edx,0x4(%rax)
  8005b6:	c9                   	leaveq 
  8005b7:	c3                   	retq   

00000000008005b8 <vcprintf>:
  8005b8:	55                   	push   %rbp
  8005b9:	48 89 e5             	mov    %rsp,%rbp
  8005bc:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8005c3:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8005ca:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8005d1:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8005d8:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8005df:	48 8b 0a             	mov    (%rdx),%rcx
  8005e2:	48 89 08             	mov    %rcx,(%rax)
  8005e5:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8005e9:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8005ed:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8005f1:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8005f5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8005fc:	00 00 00 
  8005ff:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800606:	00 00 00 
  800609:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800610:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800617:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  80061e:	48 89 c6             	mov    %rax,%rsi
  800621:	48 bf 3f 05 80 00 00 	movabs $0x80053f,%rdi
  800628:	00 00 00 
  80062b:	48 b8 17 0a 80 00 00 	movabs $0x800a17,%rax
  800632:	00 00 00 
  800635:	ff d0                	callq  *%rax
  800637:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  80063d:	48 98                	cltq   
  80063f:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800646:	48 83 c2 08          	add    $0x8,%rdx
  80064a:	48 89 c6             	mov    %rax,%rsi
  80064d:	48 89 d7             	mov    %rdx,%rdi
  800650:	48 b8 00 1a 80 00 00 	movabs $0x801a00,%rax
  800657:	00 00 00 
  80065a:	ff d0                	callq  *%rax
  80065c:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800662:	c9                   	leaveq 
  800663:	c3                   	retq   

0000000000800664 <cprintf>:
  800664:	55                   	push   %rbp
  800665:	48 89 e5             	mov    %rsp,%rbp
  800668:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  80066f:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800676:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80067d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800684:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80068b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800692:	84 c0                	test   %al,%al
  800694:	74 20                	je     8006b6 <cprintf+0x52>
  800696:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80069a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80069e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8006a2:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8006a6:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8006aa:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8006ae:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8006b2:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8006b6:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8006bd:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8006c4:	00 00 00 
  8006c7:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8006ce:	00 00 00 
  8006d1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8006d5:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8006dc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8006e3:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8006ea:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8006f1:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8006f8:	48 8b 0a             	mov    (%rdx),%rcx
  8006fb:	48 89 08             	mov    %rcx,(%rax)
  8006fe:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800702:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800706:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80070a:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80070e:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800715:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80071c:	48 89 d6             	mov    %rdx,%rsi
  80071f:	48 89 c7             	mov    %rax,%rdi
  800722:	48 b8 b8 05 80 00 00 	movabs $0x8005b8,%rax
  800729:	00 00 00 
  80072c:	ff d0                	callq  *%rax
  80072e:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800734:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80073a:	c9                   	leaveq 
  80073b:	c3                   	retq   

000000000080073c <printnum>:
  80073c:	55                   	push   %rbp
  80073d:	48 89 e5             	mov    %rsp,%rbp
  800740:	53                   	push   %rbx
  800741:	48 83 ec 38          	sub    $0x38,%rsp
  800745:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800749:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80074d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800751:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800754:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800758:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  80075c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80075f:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800763:	77 3b                	ja     8007a0 <printnum+0x64>
  800765:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800768:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  80076c:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  80076f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800773:	ba 00 00 00 00       	mov    $0x0,%edx
  800778:	48 f7 f3             	div    %rbx
  80077b:	48 89 c2             	mov    %rax,%rdx
  80077e:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800781:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800784:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800788:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80078c:	41 89 f9             	mov    %edi,%r9d
  80078f:	48 89 c7             	mov    %rax,%rdi
  800792:	48 b8 3c 07 80 00 00 	movabs $0x80073c,%rax
  800799:	00 00 00 
  80079c:	ff d0                	callq  *%rax
  80079e:	eb 1e                	jmp    8007be <printnum+0x82>
  8007a0:	eb 12                	jmp    8007b4 <printnum+0x78>
  8007a2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8007a6:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8007a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007ad:	48 89 ce             	mov    %rcx,%rsi
  8007b0:	89 d7                	mov    %edx,%edi
  8007b2:	ff d0                	callq  *%rax
  8007b4:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8007b8:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8007bc:	7f e4                	jg     8007a2 <printnum+0x66>
  8007be:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8007c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8007ca:	48 f7 f1             	div    %rcx
  8007cd:	48 89 d0             	mov    %rdx,%rax
  8007d0:	48 ba 10 4d 80 00 00 	movabs $0x804d10,%rdx
  8007d7:	00 00 00 
  8007da:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8007de:	0f be d0             	movsbl %al,%edx
  8007e1:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8007e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007e9:	48 89 ce             	mov    %rcx,%rsi
  8007ec:	89 d7                	mov    %edx,%edi
  8007ee:	ff d0                	callq  *%rax
  8007f0:	48 83 c4 38          	add    $0x38,%rsp
  8007f4:	5b                   	pop    %rbx
  8007f5:	5d                   	pop    %rbp
  8007f6:	c3                   	retq   

00000000008007f7 <getuint>:
  8007f7:	55                   	push   %rbp
  8007f8:	48 89 e5             	mov    %rsp,%rbp
  8007fb:	48 83 ec 1c          	sub    $0x1c,%rsp
  8007ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800803:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800806:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80080a:	7e 52                	jle    80085e <getuint+0x67>
  80080c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800810:	8b 00                	mov    (%rax),%eax
  800812:	83 f8 30             	cmp    $0x30,%eax
  800815:	73 24                	jae    80083b <getuint+0x44>
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
  800839:	eb 17                	jmp    800852 <getuint+0x5b>
  80083b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80083f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800843:	48 89 d0             	mov    %rdx,%rax
  800846:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80084a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80084e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800852:	48 8b 00             	mov    (%rax),%rax
  800855:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800859:	e9 a3 00 00 00       	jmpq   800901 <getuint+0x10a>
  80085e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800862:	74 4f                	je     8008b3 <getuint+0xbc>
  800864:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800868:	8b 00                	mov    (%rax),%eax
  80086a:	83 f8 30             	cmp    $0x30,%eax
  80086d:	73 24                	jae    800893 <getuint+0x9c>
  80086f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800873:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800877:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80087b:	8b 00                	mov    (%rax),%eax
  80087d:	89 c0                	mov    %eax,%eax
  80087f:	48 01 d0             	add    %rdx,%rax
  800882:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800886:	8b 12                	mov    (%rdx),%edx
  800888:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80088b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80088f:	89 0a                	mov    %ecx,(%rdx)
  800891:	eb 17                	jmp    8008aa <getuint+0xb3>
  800893:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800897:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80089b:	48 89 d0             	mov    %rdx,%rax
  80089e:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008a2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008aa:	48 8b 00             	mov    (%rax),%rax
  8008ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008b1:	eb 4e                	jmp    800901 <getuint+0x10a>
  8008b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008b7:	8b 00                	mov    (%rax),%eax
  8008b9:	83 f8 30             	cmp    $0x30,%eax
  8008bc:	73 24                	jae    8008e2 <getuint+0xeb>
  8008be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008c2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008ca:	8b 00                	mov    (%rax),%eax
  8008cc:	89 c0                	mov    %eax,%eax
  8008ce:	48 01 d0             	add    %rdx,%rax
  8008d1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008d5:	8b 12                	mov    (%rdx),%edx
  8008d7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008da:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008de:	89 0a                	mov    %ecx,(%rdx)
  8008e0:	eb 17                	jmp    8008f9 <getuint+0x102>
  8008e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008e6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008ea:	48 89 d0             	mov    %rdx,%rax
  8008ed:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008f1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008f5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008f9:	8b 00                	mov    (%rax),%eax
  8008fb:	89 c0                	mov    %eax,%eax
  8008fd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800901:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800905:	c9                   	leaveq 
  800906:	c3                   	retq   

0000000000800907 <getint>:
  800907:	55                   	push   %rbp
  800908:	48 89 e5             	mov    %rsp,%rbp
  80090b:	48 83 ec 1c          	sub    $0x1c,%rsp
  80090f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800913:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800916:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80091a:	7e 52                	jle    80096e <getint+0x67>
  80091c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800920:	8b 00                	mov    (%rax),%eax
  800922:	83 f8 30             	cmp    $0x30,%eax
  800925:	73 24                	jae    80094b <getint+0x44>
  800927:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80092b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80092f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800933:	8b 00                	mov    (%rax),%eax
  800935:	89 c0                	mov    %eax,%eax
  800937:	48 01 d0             	add    %rdx,%rax
  80093a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80093e:	8b 12                	mov    (%rdx),%edx
  800940:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800943:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800947:	89 0a                	mov    %ecx,(%rdx)
  800949:	eb 17                	jmp    800962 <getint+0x5b>
  80094b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80094f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800953:	48 89 d0             	mov    %rdx,%rax
  800956:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80095a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80095e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800962:	48 8b 00             	mov    (%rax),%rax
  800965:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800969:	e9 a3 00 00 00       	jmpq   800a11 <getint+0x10a>
  80096e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800972:	74 4f                	je     8009c3 <getint+0xbc>
  800974:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800978:	8b 00                	mov    (%rax),%eax
  80097a:	83 f8 30             	cmp    $0x30,%eax
  80097d:	73 24                	jae    8009a3 <getint+0x9c>
  80097f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800983:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800987:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80098b:	8b 00                	mov    (%rax),%eax
  80098d:	89 c0                	mov    %eax,%eax
  80098f:	48 01 d0             	add    %rdx,%rax
  800992:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800996:	8b 12                	mov    (%rdx),%edx
  800998:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80099b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80099f:	89 0a                	mov    %ecx,(%rdx)
  8009a1:	eb 17                	jmp    8009ba <getint+0xb3>
  8009a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009a7:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009ab:	48 89 d0             	mov    %rdx,%rax
  8009ae:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009b2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009b6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009ba:	48 8b 00             	mov    (%rax),%rax
  8009bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009c1:	eb 4e                	jmp    800a11 <getint+0x10a>
  8009c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009c7:	8b 00                	mov    (%rax),%eax
  8009c9:	83 f8 30             	cmp    $0x30,%eax
  8009cc:	73 24                	jae    8009f2 <getint+0xeb>
  8009ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009d2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009da:	8b 00                	mov    (%rax),%eax
  8009dc:	89 c0                	mov    %eax,%eax
  8009de:	48 01 d0             	add    %rdx,%rax
  8009e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009e5:	8b 12                	mov    (%rdx),%edx
  8009e7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009ea:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009ee:	89 0a                	mov    %ecx,(%rdx)
  8009f0:	eb 17                	jmp    800a09 <getint+0x102>
  8009f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009f6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009fa:	48 89 d0             	mov    %rdx,%rax
  8009fd:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a01:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a05:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a09:	8b 00                	mov    (%rax),%eax
  800a0b:	48 98                	cltq   
  800a0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800a15:	c9                   	leaveq 
  800a16:	c3                   	retq   

0000000000800a17 <vprintfmt>:
  800a17:	55                   	push   %rbp
  800a18:	48 89 e5             	mov    %rsp,%rbp
  800a1b:	41 54                	push   %r12
  800a1d:	53                   	push   %rbx
  800a1e:	48 83 ec 60          	sub    $0x60,%rsp
  800a22:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800a26:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800a2a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a2e:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800a32:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800a36:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800a3a:	48 8b 0a             	mov    (%rdx),%rcx
  800a3d:	48 89 08             	mov    %rcx,(%rax)
  800a40:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800a44:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800a48:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800a4c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800a50:	eb 17                	jmp    800a69 <vprintfmt+0x52>
  800a52:	85 db                	test   %ebx,%ebx
  800a54:	0f 84 cc 04 00 00    	je     800f26 <vprintfmt+0x50f>
  800a5a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a5e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a62:	48 89 d6             	mov    %rdx,%rsi
  800a65:	89 df                	mov    %ebx,%edi
  800a67:	ff d0                	callq  *%rax
  800a69:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a6d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a71:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a75:	0f b6 00             	movzbl (%rax),%eax
  800a78:	0f b6 d8             	movzbl %al,%ebx
  800a7b:	83 fb 25             	cmp    $0x25,%ebx
  800a7e:	75 d2                	jne    800a52 <vprintfmt+0x3b>
  800a80:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800a84:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800a8b:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a92:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800a99:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800aa0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800aa4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800aa8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800aac:	0f b6 00             	movzbl (%rax),%eax
  800aaf:	0f b6 d8             	movzbl %al,%ebx
  800ab2:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800ab5:	83 f8 55             	cmp    $0x55,%eax
  800ab8:	0f 87 34 04 00 00    	ja     800ef2 <vprintfmt+0x4db>
  800abe:	89 c0                	mov    %eax,%eax
  800ac0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800ac7:	00 
  800ac8:	48 b8 38 4d 80 00 00 	movabs $0x804d38,%rax
  800acf:	00 00 00 
  800ad2:	48 01 d0             	add    %rdx,%rax
  800ad5:	48 8b 00             	mov    (%rax),%rax
  800ad8:	ff e0                	jmpq   *%rax
  800ada:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800ade:	eb c0                	jmp    800aa0 <vprintfmt+0x89>
  800ae0:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800ae4:	eb ba                	jmp    800aa0 <vprintfmt+0x89>
  800ae6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800aed:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800af0:	89 d0                	mov    %edx,%eax
  800af2:	c1 e0 02             	shl    $0x2,%eax
  800af5:	01 d0                	add    %edx,%eax
  800af7:	01 c0                	add    %eax,%eax
  800af9:	01 d8                	add    %ebx,%eax
  800afb:	83 e8 30             	sub    $0x30,%eax
  800afe:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800b01:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b05:	0f b6 00             	movzbl (%rax),%eax
  800b08:	0f be d8             	movsbl %al,%ebx
  800b0b:	83 fb 2f             	cmp    $0x2f,%ebx
  800b0e:	7e 0c                	jle    800b1c <vprintfmt+0x105>
  800b10:	83 fb 39             	cmp    $0x39,%ebx
  800b13:	7f 07                	jg     800b1c <vprintfmt+0x105>
  800b15:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800b1a:	eb d1                	jmp    800aed <vprintfmt+0xd6>
  800b1c:	eb 58                	jmp    800b76 <vprintfmt+0x15f>
  800b1e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b21:	83 f8 30             	cmp    $0x30,%eax
  800b24:	73 17                	jae    800b3d <vprintfmt+0x126>
  800b26:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b2a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b2d:	89 c0                	mov    %eax,%eax
  800b2f:	48 01 d0             	add    %rdx,%rax
  800b32:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b35:	83 c2 08             	add    $0x8,%edx
  800b38:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b3b:	eb 0f                	jmp    800b4c <vprintfmt+0x135>
  800b3d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b41:	48 89 d0             	mov    %rdx,%rax
  800b44:	48 83 c2 08          	add    $0x8,%rdx
  800b48:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b4c:	8b 00                	mov    (%rax),%eax
  800b4e:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800b51:	eb 23                	jmp    800b76 <vprintfmt+0x15f>
  800b53:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b57:	79 0c                	jns    800b65 <vprintfmt+0x14e>
  800b59:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800b60:	e9 3b ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b65:	e9 36 ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b6a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800b71:	e9 2a ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b76:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b7a:	79 12                	jns    800b8e <vprintfmt+0x177>
  800b7c:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b7f:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800b82:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b89:	e9 12 ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b8e:	e9 0d ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b93:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800b97:	e9 04 ff ff ff       	jmpq   800aa0 <vprintfmt+0x89>
  800b9c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b9f:	83 f8 30             	cmp    $0x30,%eax
  800ba2:	73 17                	jae    800bbb <vprintfmt+0x1a4>
  800ba4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ba8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bab:	89 c0                	mov    %eax,%eax
  800bad:	48 01 d0             	add    %rdx,%rax
  800bb0:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800bb3:	83 c2 08             	add    $0x8,%edx
  800bb6:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bb9:	eb 0f                	jmp    800bca <vprintfmt+0x1b3>
  800bbb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bbf:	48 89 d0             	mov    %rdx,%rax
  800bc2:	48 83 c2 08          	add    $0x8,%rdx
  800bc6:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bca:	8b 10                	mov    (%rax),%edx
  800bcc:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800bd0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bd4:	48 89 ce             	mov    %rcx,%rsi
  800bd7:	89 d7                	mov    %edx,%edi
  800bd9:	ff d0                	callq  *%rax
  800bdb:	e9 40 03 00 00       	jmpq   800f20 <vprintfmt+0x509>
  800be0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800be3:	83 f8 30             	cmp    $0x30,%eax
  800be6:	73 17                	jae    800bff <vprintfmt+0x1e8>
  800be8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800bec:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bef:	89 c0                	mov    %eax,%eax
  800bf1:	48 01 d0             	add    %rdx,%rax
  800bf4:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800bf7:	83 c2 08             	add    $0x8,%edx
  800bfa:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bfd:	eb 0f                	jmp    800c0e <vprintfmt+0x1f7>
  800bff:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c03:	48 89 d0             	mov    %rdx,%rax
  800c06:	48 83 c2 08          	add    $0x8,%rdx
  800c0a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c0e:	8b 18                	mov    (%rax),%ebx
  800c10:	85 db                	test   %ebx,%ebx
  800c12:	79 02                	jns    800c16 <vprintfmt+0x1ff>
  800c14:	f7 db                	neg    %ebx
  800c16:	83 fb 15             	cmp    $0x15,%ebx
  800c19:	7f 16                	jg     800c31 <vprintfmt+0x21a>
  800c1b:	48 b8 60 4c 80 00 00 	movabs $0x804c60,%rax
  800c22:	00 00 00 
  800c25:	48 63 d3             	movslq %ebx,%rdx
  800c28:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800c2c:	4d 85 e4             	test   %r12,%r12
  800c2f:	75 2e                	jne    800c5f <vprintfmt+0x248>
  800c31:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c35:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c39:	89 d9                	mov    %ebx,%ecx
  800c3b:	48 ba 21 4d 80 00 00 	movabs $0x804d21,%rdx
  800c42:	00 00 00 
  800c45:	48 89 c7             	mov    %rax,%rdi
  800c48:	b8 00 00 00 00       	mov    $0x0,%eax
  800c4d:	49 b8 2f 0f 80 00 00 	movabs $0x800f2f,%r8
  800c54:	00 00 00 
  800c57:	41 ff d0             	callq  *%r8
  800c5a:	e9 c1 02 00 00       	jmpq   800f20 <vprintfmt+0x509>
  800c5f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c63:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c67:	4c 89 e1             	mov    %r12,%rcx
  800c6a:	48 ba 2a 4d 80 00 00 	movabs $0x804d2a,%rdx
  800c71:	00 00 00 
  800c74:	48 89 c7             	mov    %rax,%rdi
  800c77:	b8 00 00 00 00       	mov    $0x0,%eax
  800c7c:	49 b8 2f 0f 80 00 00 	movabs $0x800f2f,%r8
  800c83:	00 00 00 
  800c86:	41 ff d0             	callq  *%r8
  800c89:	e9 92 02 00 00       	jmpq   800f20 <vprintfmt+0x509>
  800c8e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c91:	83 f8 30             	cmp    $0x30,%eax
  800c94:	73 17                	jae    800cad <vprintfmt+0x296>
  800c96:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c9a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c9d:	89 c0                	mov    %eax,%eax
  800c9f:	48 01 d0             	add    %rdx,%rax
  800ca2:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ca5:	83 c2 08             	add    $0x8,%edx
  800ca8:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800cab:	eb 0f                	jmp    800cbc <vprintfmt+0x2a5>
  800cad:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800cb1:	48 89 d0             	mov    %rdx,%rax
  800cb4:	48 83 c2 08          	add    $0x8,%rdx
  800cb8:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800cbc:	4c 8b 20             	mov    (%rax),%r12
  800cbf:	4d 85 e4             	test   %r12,%r12
  800cc2:	75 0a                	jne    800cce <vprintfmt+0x2b7>
  800cc4:	49 bc 2d 4d 80 00 00 	movabs $0x804d2d,%r12
  800ccb:	00 00 00 
  800cce:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800cd2:	7e 3f                	jle    800d13 <vprintfmt+0x2fc>
  800cd4:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800cd8:	74 39                	je     800d13 <vprintfmt+0x2fc>
  800cda:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800cdd:	48 98                	cltq   
  800cdf:	48 89 c6             	mov    %rax,%rsi
  800ce2:	4c 89 e7             	mov    %r12,%rdi
  800ce5:	48 b8 db 11 80 00 00 	movabs $0x8011db,%rax
  800cec:	00 00 00 
  800cef:	ff d0                	callq  *%rax
  800cf1:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800cf4:	eb 17                	jmp    800d0d <vprintfmt+0x2f6>
  800cf6:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800cfa:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800cfe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d02:	48 89 ce             	mov    %rcx,%rsi
  800d05:	89 d7                	mov    %edx,%edi
  800d07:	ff d0                	callq  *%rax
  800d09:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d0d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d11:	7f e3                	jg     800cf6 <vprintfmt+0x2df>
  800d13:	eb 37                	jmp    800d4c <vprintfmt+0x335>
  800d15:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800d19:	74 1e                	je     800d39 <vprintfmt+0x322>
  800d1b:	83 fb 1f             	cmp    $0x1f,%ebx
  800d1e:	7e 05                	jle    800d25 <vprintfmt+0x30e>
  800d20:	83 fb 7e             	cmp    $0x7e,%ebx
  800d23:	7e 14                	jle    800d39 <vprintfmt+0x322>
  800d25:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d29:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d2d:	48 89 d6             	mov    %rdx,%rsi
  800d30:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800d35:	ff d0                	callq  *%rax
  800d37:	eb 0f                	jmp    800d48 <vprintfmt+0x331>
  800d39:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d3d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d41:	48 89 d6             	mov    %rdx,%rsi
  800d44:	89 df                	mov    %ebx,%edi
  800d46:	ff d0                	callq  *%rax
  800d48:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d4c:	4c 89 e0             	mov    %r12,%rax
  800d4f:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800d53:	0f b6 00             	movzbl (%rax),%eax
  800d56:	0f be d8             	movsbl %al,%ebx
  800d59:	85 db                	test   %ebx,%ebx
  800d5b:	74 10                	je     800d6d <vprintfmt+0x356>
  800d5d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d61:	78 b2                	js     800d15 <vprintfmt+0x2fe>
  800d63:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800d67:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d6b:	79 a8                	jns    800d15 <vprintfmt+0x2fe>
  800d6d:	eb 16                	jmp    800d85 <vprintfmt+0x36e>
  800d6f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d73:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d77:	48 89 d6             	mov    %rdx,%rsi
  800d7a:	bf 20 00 00 00       	mov    $0x20,%edi
  800d7f:	ff d0                	callq  *%rax
  800d81:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d85:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d89:	7f e4                	jg     800d6f <vprintfmt+0x358>
  800d8b:	e9 90 01 00 00       	jmpq   800f20 <vprintfmt+0x509>
  800d90:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d94:	be 03 00 00 00       	mov    $0x3,%esi
  800d99:	48 89 c7             	mov    %rax,%rdi
  800d9c:	48 b8 07 09 80 00 00 	movabs $0x800907,%rax
  800da3:	00 00 00 
  800da6:	ff d0                	callq  *%rax
  800da8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800db0:	48 85 c0             	test   %rax,%rax
  800db3:	79 1d                	jns    800dd2 <vprintfmt+0x3bb>
  800db5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800db9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dbd:	48 89 d6             	mov    %rdx,%rsi
  800dc0:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800dc5:	ff d0                	callq  *%rax
  800dc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800dcb:	48 f7 d8             	neg    %rax
  800dce:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dd2:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800dd9:	e9 d5 00 00 00       	jmpq   800eb3 <vprintfmt+0x49c>
  800dde:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800de2:	be 03 00 00 00       	mov    $0x3,%esi
  800de7:	48 89 c7             	mov    %rax,%rdi
  800dea:	48 b8 f7 07 80 00 00 	movabs $0x8007f7,%rax
  800df1:	00 00 00 
  800df4:	ff d0                	callq  *%rax
  800df6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dfa:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800e01:	e9 ad 00 00 00       	jmpq   800eb3 <vprintfmt+0x49c>
  800e06:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e0a:	be 03 00 00 00       	mov    $0x3,%esi
  800e0f:	48 89 c7             	mov    %rax,%rdi
  800e12:	48 b8 f7 07 80 00 00 	movabs $0x8007f7,%rax
  800e19:	00 00 00 
  800e1c:	ff d0                	callq  *%rax
  800e1e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e22:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800e29:	e9 85 00 00 00       	jmpq   800eb3 <vprintfmt+0x49c>
  800e2e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e32:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e36:	48 89 d6             	mov    %rdx,%rsi
  800e39:	bf 30 00 00 00       	mov    $0x30,%edi
  800e3e:	ff d0                	callq  *%rax
  800e40:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e44:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e48:	48 89 d6             	mov    %rdx,%rsi
  800e4b:	bf 78 00 00 00       	mov    $0x78,%edi
  800e50:	ff d0                	callq  *%rax
  800e52:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e55:	83 f8 30             	cmp    $0x30,%eax
  800e58:	73 17                	jae    800e71 <vprintfmt+0x45a>
  800e5a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e5e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e61:	89 c0                	mov    %eax,%eax
  800e63:	48 01 d0             	add    %rdx,%rax
  800e66:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e69:	83 c2 08             	add    $0x8,%edx
  800e6c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e6f:	eb 0f                	jmp    800e80 <vprintfmt+0x469>
  800e71:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e75:	48 89 d0             	mov    %rdx,%rax
  800e78:	48 83 c2 08          	add    $0x8,%rdx
  800e7c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e80:	48 8b 00             	mov    (%rax),%rax
  800e83:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e87:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e8e:	eb 23                	jmp    800eb3 <vprintfmt+0x49c>
  800e90:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e94:	be 03 00 00 00       	mov    $0x3,%esi
  800e99:	48 89 c7             	mov    %rax,%rdi
  800e9c:	48 b8 f7 07 80 00 00 	movabs $0x8007f7,%rax
  800ea3:	00 00 00 
  800ea6:	ff d0                	callq  *%rax
  800ea8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800eac:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800eb3:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800eb8:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800ebb:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800ebe:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ec2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800ec6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800eca:	45 89 c1             	mov    %r8d,%r9d
  800ecd:	41 89 f8             	mov    %edi,%r8d
  800ed0:	48 89 c7             	mov    %rax,%rdi
  800ed3:	48 b8 3c 07 80 00 00 	movabs $0x80073c,%rax
  800eda:	00 00 00 
  800edd:	ff d0                	callq  *%rax
  800edf:	eb 3f                	jmp    800f20 <vprintfmt+0x509>
  800ee1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ee5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ee9:	48 89 d6             	mov    %rdx,%rsi
  800eec:	89 df                	mov    %ebx,%edi
  800eee:	ff d0                	callq  *%rax
  800ef0:	eb 2e                	jmp    800f20 <vprintfmt+0x509>
  800ef2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ef6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800efa:	48 89 d6             	mov    %rdx,%rsi
  800efd:	bf 25 00 00 00       	mov    $0x25,%edi
  800f02:	ff d0                	callq  *%rax
  800f04:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800f09:	eb 05                	jmp    800f10 <vprintfmt+0x4f9>
  800f0b:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800f10:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800f14:	48 83 e8 01          	sub    $0x1,%rax
  800f18:	0f b6 00             	movzbl (%rax),%eax
  800f1b:	3c 25                	cmp    $0x25,%al
  800f1d:	75 ec                	jne    800f0b <vprintfmt+0x4f4>
  800f1f:	90                   	nop
  800f20:	90                   	nop
  800f21:	e9 43 fb ff ff       	jmpq   800a69 <vprintfmt+0x52>
  800f26:	48 83 c4 60          	add    $0x60,%rsp
  800f2a:	5b                   	pop    %rbx
  800f2b:	41 5c                	pop    %r12
  800f2d:	5d                   	pop    %rbp
  800f2e:	c3                   	retq   

0000000000800f2f <printfmt>:
  800f2f:	55                   	push   %rbp
  800f30:	48 89 e5             	mov    %rsp,%rbp
  800f33:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800f3a:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800f41:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800f48:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f4f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f56:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f5d:	84 c0                	test   %al,%al
  800f5f:	74 20                	je     800f81 <printfmt+0x52>
  800f61:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f65:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f69:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f6d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f71:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f75:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f79:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f7d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f81:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800f88:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800f8f:	00 00 00 
  800f92:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800f99:	00 00 00 
  800f9c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800fa0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800fa7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800fae:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800fb5:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800fbc:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800fc3:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800fca:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800fd1:	48 89 c7             	mov    %rax,%rdi
  800fd4:	48 b8 17 0a 80 00 00 	movabs $0x800a17,%rax
  800fdb:	00 00 00 
  800fde:	ff d0                	callq  *%rax
  800fe0:	c9                   	leaveq 
  800fe1:	c3                   	retq   

0000000000800fe2 <sprintputch>:
  800fe2:	55                   	push   %rbp
  800fe3:	48 89 e5             	mov    %rsp,%rbp
  800fe6:	48 83 ec 10          	sub    $0x10,%rsp
  800fea:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800fed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800ff1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ff5:	8b 40 10             	mov    0x10(%rax),%eax
  800ff8:	8d 50 01             	lea    0x1(%rax),%edx
  800ffb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fff:	89 50 10             	mov    %edx,0x10(%rax)
  801002:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801006:	48 8b 10             	mov    (%rax),%rdx
  801009:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80100d:	48 8b 40 08          	mov    0x8(%rax),%rax
  801011:	48 39 c2             	cmp    %rax,%rdx
  801014:	73 17                	jae    80102d <sprintputch+0x4b>
  801016:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80101a:	48 8b 00             	mov    (%rax),%rax
  80101d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801021:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801025:	48 89 0a             	mov    %rcx,(%rdx)
  801028:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80102b:	88 10                	mov    %dl,(%rax)
  80102d:	c9                   	leaveq 
  80102e:	c3                   	retq   

000000000080102f <vsnprintf>:
  80102f:	55                   	push   %rbp
  801030:	48 89 e5             	mov    %rsp,%rbp
  801033:	48 83 ec 50          	sub    $0x50,%rsp
  801037:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  80103b:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  80103e:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801042:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  801046:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  80104a:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  80104e:	48 8b 0a             	mov    (%rdx),%rcx
  801051:	48 89 08             	mov    %rcx,(%rax)
  801054:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801058:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80105c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801060:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801064:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801068:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  80106c:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  80106f:	48 98                	cltq   
  801071:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801075:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801079:	48 01 d0             	add    %rdx,%rax
  80107c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801080:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801087:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  80108c:	74 06                	je     801094 <vsnprintf+0x65>
  80108e:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801092:	7f 07                	jg     80109b <vsnprintf+0x6c>
  801094:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801099:	eb 2f                	jmp    8010ca <vsnprintf+0x9b>
  80109b:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  80109f:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  8010a3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8010a7:	48 89 c6             	mov    %rax,%rsi
  8010aa:	48 bf e2 0f 80 00 00 	movabs $0x800fe2,%rdi
  8010b1:	00 00 00 
  8010b4:	48 b8 17 0a 80 00 00 	movabs $0x800a17,%rax
  8010bb:	00 00 00 
  8010be:	ff d0                	callq  *%rax
  8010c0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8010c4:	c6 00 00             	movb   $0x0,(%rax)
  8010c7:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8010ca:	c9                   	leaveq 
  8010cb:	c3                   	retq   

00000000008010cc <snprintf>:
  8010cc:	55                   	push   %rbp
  8010cd:	48 89 e5             	mov    %rsp,%rbp
  8010d0:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8010d7:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8010de:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8010e4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8010eb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8010f2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8010f9:	84 c0                	test   %al,%al
  8010fb:	74 20                	je     80111d <snprintf+0x51>
  8010fd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801101:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801105:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801109:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80110d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801111:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801115:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801119:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80111d:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801124:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  80112b:	00 00 00 
  80112e:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  801135:	00 00 00 
  801138:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80113c:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801143:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80114a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801151:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  801158:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80115f:	48 8b 0a             	mov    (%rdx),%rcx
  801162:	48 89 08             	mov    %rcx,(%rax)
  801165:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801169:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80116d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801171:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801175:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  80117c:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801183:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801189:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801190:	48 89 c7             	mov    %rax,%rdi
  801193:	48 b8 2f 10 80 00 00 	movabs $0x80102f,%rax
  80119a:	00 00 00 
  80119d:	ff d0                	callq  *%rax
  80119f:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8011a5:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8011ab:	c9                   	leaveq 
  8011ac:	c3                   	retq   

00000000008011ad <strlen>:
  8011ad:	55                   	push   %rbp
  8011ae:	48 89 e5             	mov    %rsp,%rbp
  8011b1:	48 83 ec 18          	sub    $0x18,%rsp
  8011b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011c0:	eb 09                	jmp    8011cb <strlen+0x1e>
  8011c2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8011c6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8011cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011cf:	0f b6 00             	movzbl (%rax),%eax
  8011d2:	84 c0                	test   %al,%al
  8011d4:	75 ec                	jne    8011c2 <strlen+0x15>
  8011d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011d9:	c9                   	leaveq 
  8011da:	c3                   	retq   

00000000008011db <strnlen>:
  8011db:	55                   	push   %rbp
  8011dc:	48 89 e5             	mov    %rsp,%rbp
  8011df:	48 83 ec 20          	sub    $0x20,%rsp
  8011e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011f2:	eb 0e                	jmp    801202 <strnlen+0x27>
  8011f4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8011f8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8011fd:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801202:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801207:	74 0b                	je     801214 <strnlen+0x39>
  801209:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80120d:	0f b6 00             	movzbl (%rax),%eax
  801210:	84 c0                	test   %al,%al
  801212:	75 e0                	jne    8011f4 <strnlen+0x19>
  801214:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801217:	c9                   	leaveq 
  801218:	c3                   	retq   

0000000000801219 <strcpy>:
  801219:	55                   	push   %rbp
  80121a:	48 89 e5             	mov    %rsp,%rbp
  80121d:	48 83 ec 20          	sub    $0x20,%rsp
  801221:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801225:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801229:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80122d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801231:	90                   	nop
  801232:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801236:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80123a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80123e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801242:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801246:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80124a:	0f b6 12             	movzbl (%rdx),%edx
  80124d:	88 10                	mov    %dl,(%rax)
  80124f:	0f b6 00             	movzbl (%rax),%eax
  801252:	84 c0                	test   %al,%al
  801254:	75 dc                	jne    801232 <strcpy+0x19>
  801256:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80125a:	c9                   	leaveq 
  80125b:	c3                   	retq   

000000000080125c <strcat>:
  80125c:	55                   	push   %rbp
  80125d:	48 89 e5             	mov    %rsp,%rbp
  801260:	48 83 ec 20          	sub    $0x20,%rsp
  801264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80126c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801270:	48 89 c7             	mov    %rax,%rdi
  801273:	48 b8 ad 11 80 00 00 	movabs $0x8011ad,%rax
  80127a:	00 00 00 
  80127d:	ff d0                	callq  *%rax
  80127f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801282:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801285:	48 63 d0             	movslq %eax,%rdx
  801288:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80128c:	48 01 c2             	add    %rax,%rdx
  80128f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801293:	48 89 c6             	mov    %rax,%rsi
  801296:	48 89 d7             	mov    %rdx,%rdi
  801299:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  8012a0:	00 00 00 
  8012a3:	ff d0                	callq  *%rax
  8012a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012a9:	c9                   	leaveq 
  8012aa:	c3                   	retq   

00000000008012ab <strncpy>:
  8012ab:	55                   	push   %rbp
  8012ac:	48 89 e5             	mov    %rsp,%rbp
  8012af:	48 83 ec 28          	sub    $0x28,%rsp
  8012b3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012b7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012bb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012c3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8012c7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8012ce:	00 
  8012cf:	eb 2a                	jmp    8012fb <strncpy+0x50>
  8012d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012d5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8012d9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012dd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8012e1:	0f b6 12             	movzbl (%rdx),%edx
  8012e4:	88 10                	mov    %dl,(%rax)
  8012e6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012ea:	0f b6 00             	movzbl (%rax),%eax
  8012ed:	84 c0                	test   %al,%al
  8012ef:	74 05                	je     8012f6 <strncpy+0x4b>
  8012f1:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8012f6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012ff:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801303:	72 cc                	jb     8012d1 <strncpy+0x26>
  801305:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801309:	c9                   	leaveq 
  80130a:	c3                   	retq   

000000000080130b <strlcpy>:
  80130b:	55                   	push   %rbp
  80130c:	48 89 e5             	mov    %rsp,%rbp
  80130f:	48 83 ec 28          	sub    $0x28,%rsp
  801313:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801317:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80131b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80131f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801323:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801327:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80132c:	74 3d                	je     80136b <strlcpy+0x60>
  80132e:	eb 1d                	jmp    80134d <strlcpy+0x42>
  801330:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801334:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801338:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80133c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801340:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801344:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801348:	0f b6 12             	movzbl (%rdx),%edx
  80134b:	88 10                	mov    %dl,(%rax)
  80134d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801352:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801357:	74 0b                	je     801364 <strlcpy+0x59>
  801359:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80135d:	0f b6 00             	movzbl (%rax),%eax
  801360:	84 c0                	test   %al,%al
  801362:	75 cc                	jne    801330 <strlcpy+0x25>
  801364:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801368:	c6 00 00             	movb   $0x0,(%rax)
  80136b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80136f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801373:	48 29 c2             	sub    %rax,%rdx
  801376:	48 89 d0             	mov    %rdx,%rax
  801379:	c9                   	leaveq 
  80137a:	c3                   	retq   

000000000080137b <strcmp>:
  80137b:	55                   	push   %rbp
  80137c:	48 89 e5             	mov    %rsp,%rbp
  80137f:	48 83 ec 10          	sub    $0x10,%rsp
  801383:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801387:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80138b:	eb 0a                	jmp    801397 <strcmp+0x1c>
  80138d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801392:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801397:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80139b:	0f b6 00             	movzbl (%rax),%eax
  80139e:	84 c0                	test   %al,%al
  8013a0:	74 12                	je     8013b4 <strcmp+0x39>
  8013a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013a6:	0f b6 10             	movzbl (%rax),%edx
  8013a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013ad:	0f b6 00             	movzbl (%rax),%eax
  8013b0:	38 c2                	cmp    %al,%dl
  8013b2:	74 d9                	je     80138d <strcmp+0x12>
  8013b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013b8:	0f b6 00             	movzbl (%rax),%eax
  8013bb:	0f b6 d0             	movzbl %al,%edx
  8013be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013c2:	0f b6 00             	movzbl (%rax),%eax
  8013c5:	0f b6 c0             	movzbl %al,%eax
  8013c8:	29 c2                	sub    %eax,%edx
  8013ca:	89 d0                	mov    %edx,%eax
  8013cc:	c9                   	leaveq 
  8013cd:	c3                   	retq   

00000000008013ce <strncmp>:
  8013ce:	55                   	push   %rbp
  8013cf:	48 89 e5             	mov    %rsp,%rbp
  8013d2:	48 83 ec 18          	sub    $0x18,%rsp
  8013d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8013da:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8013de:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013e2:	eb 0f                	jmp    8013f3 <strncmp+0x25>
  8013e4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8013e9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8013ee:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8013f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013f8:	74 1d                	je     801417 <strncmp+0x49>
  8013fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013fe:	0f b6 00             	movzbl (%rax),%eax
  801401:	84 c0                	test   %al,%al
  801403:	74 12                	je     801417 <strncmp+0x49>
  801405:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801409:	0f b6 10             	movzbl (%rax),%edx
  80140c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801410:	0f b6 00             	movzbl (%rax),%eax
  801413:	38 c2                	cmp    %al,%dl
  801415:	74 cd                	je     8013e4 <strncmp+0x16>
  801417:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80141c:	75 07                	jne    801425 <strncmp+0x57>
  80141e:	b8 00 00 00 00       	mov    $0x0,%eax
  801423:	eb 18                	jmp    80143d <strncmp+0x6f>
  801425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801429:	0f b6 00             	movzbl (%rax),%eax
  80142c:	0f b6 d0             	movzbl %al,%edx
  80142f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801433:	0f b6 00             	movzbl (%rax),%eax
  801436:	0f b6 c0             	movzbl %al,%eax
  801439:	29 c2                	sub    %eax,%edx
  80143b:	89 d0                	mov    %edx,%eax
  80143d:	c9                   	leaveq 
  80143e:	c3                   	retq   

000000000080143f <strchr>:
  80143f:	55                   	push   %rbp
  801440:	48 89 e5             	mov    %rsp,%rbp
  801443:	48 83 ec 0c          	sub    $0xc,%rsp
  801447:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80144b:	89 f0                	mov    %esi,%eax
  80144d:	88 45 f4             	mov    %al,-0xc(%rbp)
  801450:	eb 17                	jmp    801469 <strchr+0x2a>
  801452:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801456:	0f b6 00             	movzbl (%rax),%eax
  801459:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80145c:	75 06                	jne    801464 <strchr+0x25>
  80145e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801462:	eb 15                	jmp    801479 <strchr+0x3a>
  801464:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801469:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80146d:	0f b6 00             	movzbl (%rax),%eax
  801470:	84 c0                	test   %al,%al
  801472:	75 de                	jne    801452 <strchr+0x13>
  801474:	b8 00 00 00 00       	mov    $0x0,%eax
  801479:	c9                   	leaveq 
  80147a:	c3                   	retq   

000000000080147b <strfind>:
  80147b:	55                   	push   %rbp
  80147c:	48 89 e5             	mov    %rsp,%rbp
  80147f:	48 83 ec 0c          	sub    $0xc,%rsp
  801483:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801487:	89 f0                	mov    %esi,%eax
  801489:	88 45 f4             	mov    %al,-0xc(%rbp)
  80148c:	eb 13                	jmp    8014a1 <strfind+0x26>
  80148e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801492:	0f b6 00             	movzbl (%rax),%eax
  801495:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801498:	75 02                	jne    80149c <strfind+0x21>
  80149a:	eb 10                	jmp    8014ac <strfind+0x31>
  80149c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8014a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014a5:	0f b6 00             	movzbl (%rax),%eax
  8014a8:	84 c0                	test   %al,%al
  8014aa:	75 e2                	jne    80148e <strfind+0x13>
  8014ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014b0:	c9                   	leaveq 
  8014b1:	c3                   	retq   

00000000008014b2 <memset>:
  8014b2:	55                   	push   %rbp
  8014b3:	48 89 e5             	mov    %rsp,%rbp
  8014b6:	48 83 ec 18          	sub    $0x18,%rsp
  8014ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014be:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8014c1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014c5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8014ca:	75 06                	jne    8014d2 <memset+0x20>
  8014cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d0:	eb 69                	jmp    80153b <memset+0x89>
  8014d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d6:	83 e0 03             	and    $0x3,%eax
  8014d9:	48 85 c0             	test   %rax,%rax
  8014dc:	75 48                	jne    801526 <memset+0x74>
  8014de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014e2:	83 e0 03             	and    $0x3,%eax
  8014e5:	48 85 c0             	test   %rax,%rax
  8014e8:	75 3c                	jne    801526 <memset+0x74>
  8014ea:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8014f1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014f4:	c1 e0 18             	shl    $0x18,%eax
  8014f7:	89 c2                	mov    %eax,%edx
  8014f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014fc:	c1 e0 10             	shl    $0x10,%eax
  8014ff:	09 c2                	or     %eax,%edx
  801501:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801504:	c1 e0 08             	shl    $0x8,%eax
  801507:	09 d0                	or     %edx,%eax
  801509:	09 45 f4             	or     %eax,-0xc(%rbp)
  80150c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801510:	48 c1 e8 02          	shr    $0x2,%rax
  801514:	48 89 c1             	mov    %rax,%rcx
  801517:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80151b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80151e:	48 89 d7             	mov    %rdx,%rdi
  801521:	fc                   	cld    
  801522:	f3 ab                	rep stos %eax,%es:(%rdi)
  801524:	eb 11                	jmp    801537 <memset+0x85>
  801526:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80152a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80152d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801531:	48 89 d7             	mov    %rdx,%rdi
  801534:	fc                   	cld    
  801535:	f3 aa                	rep stos %al,%es:(%rdi)
  801537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80153b:	c9                   	leaveq 
  80153c:	c3                   	retq   

000000000080153d <memmove>:
  80153d:	55                   	push   %rbp
  80153e:	48 89 e5             	mov    %rsp,%rbp
  801541:	48 83 ec 28          	sub    $0x28,%rsp
  801545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801549:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80154d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801551:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801555:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801559:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80155d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801565:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801569:	0f 83 88 00 00 00    	jae    8015f7 <memmove+0xba>
  80156f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801573:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801577:	48 01 d0             	add    %rdx,%rax
  80157a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80157e:	76 77                	jbe    8015f7 <memmove+0xba>
  801580:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801584:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801588:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80158c:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801590:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801594:	83 e0 03             	and    $0x3,%eax
  801597:	48 85 c0             	test   %rax,%rax
  80159a:	75 3b                	jne    8015d7 <memmove+0x9a>
  80159c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015a0:	83 e0 03             	and    $0x3,%eax
  8015a3:	48 85 c0             	test   %rax,%rax
  8015a6:	75 2f                	jne    8015d7 <memmove+0x9a>
  8015a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015ac:	83 e0 03             	and    $0x3,%eax
  8015af:	48 85 c0             	test   %rax,%rax
  8015b2:	75 23                	jne    8015d7 <memmove+0x9a>
  8015b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015b8:	48 83 e8 04          	sub    $0x4,%rax
  8015bc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015c0:	48 83 ea 04          	sub    $0x4,%rdx
  8015c4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8015c8:	48 c1 e9 02          	shr    $0x2,%rcx
  8015cc:	48 89 c7             	mov    %rax,%rdi
  8015cf:	48 89 d6             	mov    %rdx,%rsi
  8015d2:	fd                   	std    
  8015d3:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8015d5:	eb 1d                	jmp    8015f4 <memmove+0xb7>
  8015d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015db:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8015df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015e3:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8015e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015eb:	48 89 d7             	mov    %rdx,%rdi
  8015ee:	48 89 c1             	mov    %rax,%rcx
  8015f1:	fd                   	std    
  8015f2:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8015f4:	fc                   	cld    
  8015f5:	eb 57                	jmp    80164e <memmove+0x111>
  8015f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015fb:	83 e0 03             	and    $0x3,%eax
  8015fe:	48 85 c0             	test   %rax,%rax
  801601:	75 36                	jne    801639 <memmove+0xfc>
  801603:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801607:	83 e0 03             	and    $0x3,%eax
  80160a:	48 85 c0             	test   %rax,%rax
  80160d:	75 2a                	jne    801639 <memmove+0xfc>
  80160f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801613:	83 e0 03             	and    $0x3,%eax
  801616:	48 85 c0             	test   %rax,%rax
  801619:	75 1e                	jne    801639 <memmove+0xfc>
  80161b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80161f:	48 c1 e8 02          	shr    $0x2,%rax
  801623:	48 89 c1             	mov    %rax,%rcx
  801626:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80162a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80162e:	48 89 c7             	mov    %rax,%rdi
  801631:	48 89 d6             	mov    %rdx,%rsi
  801634:	fc                   	cld    
  801635:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801637:	eb 15                	jmp    80164e <memmove+0x111>
  801639:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80163d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801641:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801645:	48 89 c7             	mov    %rax,%rdi
  801648:	48 89 d6             	mov    %rdx,%rsi
  80164b:	fc                   	cld    
  80164c:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80164e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801652:	c9                   	leaveq 
  801653:	c3                   	retq   

0000000000801654 <memcpy>:
  801654:	55                   	push   %rbp
  801655:	48 89 e5             	mov    %rsp,%rbp
  801658:	48 83 ec 18          	sub    $0x18,%rsp
  80165c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801660:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801664:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801668:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80166c:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801670:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801674:	48 89 ce             	mov    %rcx,%rsi
  801677:	48 89 c7             	mov    %rax,%rdi
  80167a:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  801681:	00 00 00 
  801684:	ff d0                	callq  *%rax
  801686:	c9                   	leaveq 
  801687:	c3                   	retq   

0000000000801688 <memcmp>:
  801688:	55                   	push   %rbp
  801689:	48 89 e5             	mov    %rsp,%rbp
  80168c:	48 83 ec 28          	sub    $0x28,%rsp
  801690:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801694:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801698:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80169c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8016a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8016a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8016ac:	eb 36                	jmp    8016e4 <memcmp+0x5c>
  8016ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016b2:	0f b6 10             	movzbl (%rax),%edx
  8016b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016b9:	0f b6 00             	movzbl (%rax),%eax
  8016bc:	38 c2                	cmp    %al,%dl
  8016be:	74 1a                	je     8016da <memcmp+0x52>
  8016c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016c4:	0f b6 00             	movzbl (%rax),%eax
  8016c7:	0f b6 d0             	movzbl %al,%edx
  8016ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016ce:	0f b6 00             	movzbl (%rax),%eax
  8016d1:	0f b6 c0             	movzbl %al,%eax
  8016d4:	29 c2                	sub    %eax,%edx
  8016d6:	89 d0                	mov    %edx,%eax
  8016d8:	eb 20                	jmp    8016fa <memcmp+0x72>
  8016da:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016df:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8016e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016e8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8016ec:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016f0:	48 85 c0             	test   %rax,%rax
  8016f3:	75 b9                	jne    8016ae <memcmp+0x26>
  8016f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8016fa:	c9                   	leaveq 
  8016fb:	c3                   	retq   

00000000008016fc <memfind>:
  8016fc:	55                   	push   %rbp
  8016fd:	48 89 e5             	mov    %rsp,%rbp
  801700:	48 83 ec 28          	sub    $0x28,%rsp
  801704:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801708:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80170b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80170f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801713:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801717:	48 01 d0             	add    %rdx,%rax
  80171a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80171e:	eb 15                	jmp    801735 <memfind+0x39>
  801720:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801724:	0f b6 10             	movzbl (%rax),%edx
  801727:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80172a:	38 c2                	cmp    %al,%dl
  80172c:	75 02                	jne    801730 <memfind+0x34>
  80172e:	eb 0f                	jmp    80173f <memfind+0x43>
  801730:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801735:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801739:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  80173d:	72 e1                	jb     801720 <memfind+0x24>
  80173f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801743:	c9                   	leaveq 
  801744:	c3                   	retq   

0000000000801745 <strtol>:
  801745:	55                   	push   %rbp
  801746:	48 89 e5             	mov    %rsp,%rbp
  801749:	48 83 ec 34          	sub    $0x34,%rsp
  80174d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801751:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801755:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801758:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80175f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801766:	00 
  801767:	eb 05                	jmp    80176e <strtol+0x29>
  801769:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80176e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801772:	0f b6 00             	movzbl (%rax),%eax
  801775:	3c 20                	cmp    $0x20,%al
  801777:	74 f0                	je     801769 <strtol+0x24>
  801779:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80177d:	0f b6 00             	movzbl (%rax),%eax
  801780:	3c 09                	cmp    $0x9,%al
  801782:	74 e5                	je     801769 <strtol+0x24>
  801784:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801788:	0f b6 00             	movzbl (%rax),%eax
  80178b:	3c 2b                	cmp    $0x2b,%al
  80178d:	75 07                	jne    801796 <strtol+0x51>
  80178f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801794:	eb 17                	jmp    8017ad <strtol+0x68>
  801796:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80179a:	0f b6 00             	movzbl (%rax),%eax
  80179d:	3c 2d                	cmp    $0x2d,%al
  80179f:	75 0c                	jne    8017ad <strtol+0x68>
  8017a1:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8017a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8017ad:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017b1:	74 06                	je     8017b9 <strtol+0x74>
  8017b3:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8017b7:	75 28                	jne    8017e1 <strtol+0x9c>
  8017b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017bd:	0f b6 00             	movzbl (%rax),%eax
  8017c0:	3c 30                	cmp    $0x30,%al
  8017c2:	75 1d                	jne    8017e1 <strtol+0x9c>
  8017c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017c8:	48 83 c0 01          	add    $0x1,%rax
  8017cc:	0f b6 00             	movzbl (%rax),%eax
  8017cf:	3c 78                	cmp    $0x78,%al
  8017d1:	75 0e                	jne    8017e1 <strtol+0x9c>
  8017d3:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8017d8:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8017df:	eb 2c                	jmp    80180d <strtol+0xc8>
  8017e1:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017e5:	75 19                	jne    801800 <strtol+0xbb>
  8017e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017eb:	0f b6 00             	movzbl (%rax),%eax
  8017ee:	3c 30                	cmp    $0x30,%al
  8017f0:	75 0e                	jne    801800 <strtol+0xbb>
  8017f2:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8017f7:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8017fe:	eb 0d                	jmp    80180d <strtol+0xc8>
  801800:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801804:	75 07                	jne    80180d <strtol+0xc8>
  801806:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  80180d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801811:	0f b6 00             	movzbl (%rax),%eax
  801814:	3c 2f                	cmp    $0x2f,%al
  801816:	7e 1d                	jle    801835 <strtol+0xf0>
  801818:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80181c:	0f b6 00             	movzbl (%rax),%eax
  80181f:	3c 39                	cmp    $0x39,%al
  801821:	7f 12                	jg     801835 <strtol+0xf0>
  801823:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801827:	0f b6 00             	movzbl (%rax),%eax
  80182a:	0f be c0             	movsbl %al,%eax
  80182d:	83 e8 30             	sub    $0x30,%eax
  801830:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801833:	eb 4e                	jmp    801883 <strtol+0x13e>
  801835:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801839:	0f b6 00             	movzbl (%rax),%eax
  80183c:	3c 60                	cmp    $0x60,%al
  80183e:	7e 1d                	jle    80185d <strtol+0x118>
  801840:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801844:	0f b6 00             	movzbl (%rax),%eax
  801847:	3c 7a                	cmp    $0x7a,%al
  801849:	7f 12                	jg     80185d <strtol+0x118>
  80184b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80184f:	0f b6 00             	movzbl (%rax),%eax
  801852:	0f be c0             	movsbl %al,%eax
  801855:	83 e8 57             	sub    $0x57,%eax
  801858:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80185b:	eb 26                	jmp    801883 <strtol+0x13e>
  80185d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801861:	0f b6 00             	movzbl (%rax),%eax
  801864:	3c 40                	cmp    $0x40,%al
  801866:	7e 48                	jle    8018b0 <strtol+0x16b>
  801868:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80186c:	0f b6 00             	movzbl (%rax),%eax
  80186f:	3c 5a                	cmp    $0x5a,%al
  801871:	7f 3d                	jg     8018b0 <strtol+0x16b>
  801873:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801877:	0f b6 00             	movzbl (%rax),%eax
  80187a:	0f be c0             	movsbl %al,%eax
  80187d:	83 e8 37             	sub    $0x37,%eax
  801880:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801883:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801886:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801889:	7c 02                	jl     80188d <strtol+0x148>
  80188b:	eb 23                	jmp    8018b0 <strtol+0x16b>
  80188d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801892:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801895:	48 98                	cltq   
  801897:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  80189c:	48 89 c2             	mov    %rax,%rdx
  80189f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8018a2:	48 98                	cltq   
  8018a4:	48 01 d0             	add    %rdx,%rax
  8018a7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8018ab:	e9 5d ff ff ff       	jmpq   80180d <strtol+0xc8>
  8018b0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8018b5:	74 0b                	je     8018c2 <strtol+0x17d>
  8018b7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018bb:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8018bf:	48 89 10             	mov    %rdx,(%rax)
  8018c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8018c6:	74 09                	je     8018d1 <strtol+0x18c>
  8018c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018cc:	48 f7 d8             	neg    %rax
  8018cf:	eb 04                	jmp    8018d5 <strtol+0x190>
  8018d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018d5:	c9                   	leaveq 
  8018d6:	c3                   	retq   

00000000008018d7 <strstr>:
  8018d7:	55                   	push   %rbp
  8018d8:	48 89 e5             	mov    %rsp,%rbp
  8018db:	48 83 ec 30          	sub    $0x30,%rsp
  8018df:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8018e3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8018e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018eb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8018ef:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8018f3:	0f b6 00             	movzbl (%rax),%eax
  8018f6:	88 45 ff             	mov    %al,-0x1(%rbp)
  8018f9:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8018fd:	75 06                	jne    801905 <strstr+0x2e>
  8018ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801903:	eb 6b                	jmp    801970 <strstr+0x99>
  801905:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801909:	48 89 c7             	mov    %rax,%rdi
  80190c:	48 b8 ad 11 80 00 00 	movabs $0x8011ad,%rax
  801913:	00 00 00 
  801916:	ff d0                	callq  *%rax
  801918:	48 98                	cltq   
  80191a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80191e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801922:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801926:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80192a:	0f b6 00             	movzbl (%rax),%eax
  80192d:	88 45 ef             	mov    %al,-0x11(%rbp)
  801930:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801934:	75 07                	jne    80193d <strstr+0x66>
  801936:	b8 00 00 00 00       	mov    $0x0,%eax
  80193b:	eb 33                	jmp    801970 <strstr+0x99>
  80193d:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801941:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801944:	75 d8                	jne    80191e <strstr+0x47>
  801946:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80194a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  80194e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801952:	48 89 ce             	mov    %rcx,%rsi
  801955:	48 89 c7             	mov    %rax,%rdi
  801958:	48 b8 ce 13 80 00 00 	movabs $0x8013ce,%rax
  80195f:	00 00 00 
  801962:	ff d0                	callq  *%rax
  801964:	85 c0                	test   %eax,%eax
  801966:	75 b6                	jne    80191e <strstr+0x47>
  801968:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80196c:	48 83 e8 01          	sub    $0x1,%rax
  801970:	c9                   	leaveq 
  801971:	c3                   	retq   

0000000000801972 <syscall>:
  801972:	55                   	push   %rbp
  801973:	48 89 e5             	mov    %rsp,%rbp
  801976:	53                   	push   %rbx
  801977:	48 83 ec 48          	sub    $0x48,%rsp
  80197b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80197e:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801981:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801985:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801989:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80198d:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801991:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801994:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801998:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  80199c:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8019a0:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8019a4:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8019a8:	4c 89 c3             	mov    %r8,%rbx
  8019ab:	cd 30                	int    $0x30
  8019ad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8019b1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8019b5:	74 3e                	je     8019f5 <syscall+0x83>
  8019b7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8019bc:	7e 37                	jle    8019f5 <syscall+0x83>
  8019be:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8019c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8019c5:	49 89 d0             	mov    %rdx,%r8
  8019c8:	89 c1                	mov    %eax,%ecx
  8019ca:	48 ba e8 4f 80 00 00 	movabs $0x804fe8,%rdx
  8019d1:	00 00 00 
  8019d4:	be 24 00 00 00       	mov    $0x24,%esi
  8019d9:	48 bf 05 50 80 00 00 	movabs $0x805005,%rdi
  8019e0:	00 00 00 
  8019e3:	b8 00 00 00 00       	mov    $0x0,%eax
  8019e8:	49 b9 2b 04 80 00 00 	movabs $0x80042b,%r9
  8019ef:	00 00 00 
  8019f2:	41 ff d1             	callq  *%r9
  8019f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019f9:	48 83 c4 48          	add    $0x48,%rsp
  8019fd:	5b                   	pop    %rbx
  8019fe:	5d                   	pop    %rbp
  8019ff:	c3                   	retq   

0000000000801a00 <sys_cputs>:
  801a00:	55                   	push   %rbp
  801a01:	48 89 e5             	mov    %rsp,%rbp
  801a04:	48 83 ec 20          	sub    $0x20,%rsp
  801a08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a0c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a14:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a18:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a1f:	00 
  801a20:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a26:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a2c:	48 89 d1             	mov    %rdx,%rcx
  801a2f:	48 89 c2             	mov    %rax,%rdx
  801a32:	be 00 00 00 00       	mov    $0x0,%esi
  801a37:	bf 00 00 00 00       	mov    $0x0,%edi
  801a3c:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801a43:	00 00 00 
  801a46:	ff d0                	callq  *%rax
  801a48:	c9                   	leaveq 
  801a49:	c3                   	retq   

0000000000801a4a <sys_cgetc>:
  801a4a:	55                   	push   %rbp
  801a4b:	48 89 e5             	mov    %rsp,%rbp
  801a4e:	48 83 ec 10          	sub    $0x10,%rsp
  801a52:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a59:	00 
  801a5a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a60:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a66:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a6b:	ba 00 00 00 00       	mov    $0x0,%edx
  801a70:	be 00 00 00 00       	mov    $0x0,%esi
  801a75:	bf 01 00 00 00       	mov    $0x1,%edi
  801a7a:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801a81:	00 00 00 
  801a84:	ff d0                	callq  *%rax
  801a86:	c9                   	leaveq 
  801a87:	c3                   	retq   

0000000000801a88 <sys_env_destroy>:
  801a88:	55                   	push   %rbp
  801a89:	48 89 e5             	mov    %rsp,%rbp
  801a8c:	48 83 ec 10          	sub    $0x10,%rsp
  801a90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a96:	48 98                	cltq   
  801a98:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a9f:	00 
  801aa0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801aa6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801aac:	b9 00 00 00 00       	mov    $0x0,%ecx
  801ab1:	48 89 c2             	mov    %rax,%rdx
  801ab4:	be 01 00 00 00       	mov    $0x1,%esi
  801ab9:	bf 03 00 00 00       	mov    $0x3,%edi
  801abe:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801ac5:	00 00 00 
  801ac8:	ff d0                	callq  *%rax
  801aca:	c9                   	leaveq 
  801acb:	c3                   	retq   

0000000000801acc <sys_getenvid>:
  801acc:	55                   	push   %rbp
  801acd:	48 89 e5             	mov    %rsp,%rbp
  801ad0:	48 83 ec 10          	sub    $0x10,%rsp
  801ad4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801adb:	00 
  801adc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ae2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ae8:	b9 00 00 00 00       	mov    $0x0,%ecx
  801aed:	ba 00 00 00 00       	mov    $0x0,%edx
  801af2:	be 00 00 00 00       	mov    $0x0,%esi
  801af7:	bf 02 00 00 00       	mov    $0x2,%edi
  801afc:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801b03:	00 00 00 
  801b06:	ff d0                	callq  *%rax
  801b08:	c9                   	leaveq 
  801b09:	c3                   	retq   

0000000000801b0a <sys_yield>:
  801b0a:	55                   	push   %rbp
  801b0b:	48 89 e5             	mov    %rsp,%rbp
  801b0e:	48 83 ec 10          	sub    $0x10,%rsp
  801b12:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b19:	00 
  801b1a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b20:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b26:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b2b:	ba 00 00 00 00       	mov    $0x0,%edx
  801b30:	be 00 00 00 00       	mov    $0x0,%esi
  801b35:	bf 0b 00 00 00       	mov    $0xb,%edi
  801b3a:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801b41:	00 00 00 
  801b44:	ff d0                	callq  *%rax
  801b46:	c9                   	leaveq 
  801b47:	c3                   	retq   

0000000000801b48 <sys_page_alloc>:
  801b48:	55                   	push   %rbp
  801b49:	48 89 e5             	mov    %rsp,%rbp
  801b4c:	48 83 ec 20          	sub    $0x20,%rsp
  801b50:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b53:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b57:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b5d:	48 63 c8             	movslq %eax,%rcx
  801b60:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b64:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b67:	48 98                	cltq   
  801b69:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b70:	00 
  801b71:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b77:	49 89 c8             	mov    %rcx,%r8
  801b7a:	48 89 d1             	mov    %rdx,%rcx
  801b7d:	48 89 c2             	mov    %rax,%rdx
  801b80:	be 01 00 00 00       	mov    $0x1,%esi
  801b85:	bf 04 00 00 00       	mov    $0x4,%edi
  801b8a:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801b91:	00 00 00 
  801b94:	ff d0                	callq  *%rax
  801b96:	c9                   	leaveq 
  801b97:	c3                   	retq   

0000000000801b98 <sys_page_map>:
  801b98:	55                   	push   %rbp
  801b99:	48 89 e5             	mov    %rsp,%rbp
  801b9c:	48 83 ec 30          	sub    $0x30,%rsp
  801ba0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ba3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ba7:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801baa:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801bae:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801bb2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801bb5:	48 63 c8             	movslq %eax,%rcx
  801bb8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801bbc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bbf:	48 63 f0             	movslq %eax,%rsi
  801bc2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bc6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bc9:	48 98                	cltq   
  801bcb:	48 89 0c 24          	mov    %rcx,(%rsp)
  801bcf:	49 89 f9             	mov    %rdi,%r9
  801bd2:	49 89 f0             	mov    %rsi,%r8
  801bd5:	48 89 d1             	mov    %rdx,%rcx
  801bd8:	48 89 c2             	mov    %rax,%rdx
  801bdb:	be 01 00 00 00       	mov    $0x1,%esi
  801be0:	bf 05 00 00 00       	mov    $0x5,%edi
  801be5:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801bec:	00 00 00 
  801bef:	ff d0                	callq  *%rax
  801bf1:	c9                   	leaveq 
  801bf2:	c3                   	retq   

0000000000801bf3 <sys_page_unmap>:
  801bf3:	55                   	push   %rbp
  801bf4:	48 89 e5             	mov    %rsp,%rbp
  801bf7:	48 83 ec 20          	sub    $0x20,%rsp
  801bfb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bfe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c09:	48 98                	cltq   
  801c0b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c12:	00 
  801c13:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c19:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c1f:	48 89 d1             	mov    %rdx,%rcx
  801c22:	48 89 c2             	mov    %rax,%rdx
  801c25:	be 01 00 00 00       	mov    $0x1,%esi
  801c2a:	bf 06 00 00 00       	mov    $0x6,%edi
  801c2f:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801c36:	00 00 00 
  801c39:	ff d0                	callq  *%rax
  801c3b:	c9                   	leaveq 
  801c3c:	c3                   	retq   

0000000000801c3d <sys_env_set_status>:
  801c3d:	55                   	push   %rbp
  801c3e:	48 89 e5             	mov    %rsp,%rbp
  801c41:	48 83 ec 10          	sub    $0x10,%rsp
  801c45:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c48:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801c4b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c4e:	48 63 d0             	movslq %eax,%rdx
  801c51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c54:	48 98                	cltq   
  801c56:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c5d:	00 
  801c5e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c64:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c6a:	48 89 d1             	mov    %rdx,%rcx
  801c6d:	48 89 c2             	mov    %rax,%rdx
  801c70:	be 01 00 00 00       	mov    $0x1,%esi
  801c75:	bf 08 00 00 00       	mov    $0x8,%edi
  801c7a:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801c81:	00 00 00 
  801c84:	ff d0                	callq  *%rax
  801c86:	c9                   	leaveq 
  801c87:	c3                   	retq   

0000000000801c88 <sys_env_set_trapframe>:
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
  801cbf:	bf 09 00 00 00       	mov    $0x9,%edi
  801cc4:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801ccb:	00 00 00 
  801cce:	ff d0                	callq  *%rax
  801cd0:	c9                   	leaveq 
  801cd1:	c3                   	retq   

0000000000801cd2 <sys_env_set_pgfault_upcall>:
  801cd2:	55                   	push   %rbp
  801cd3:	48 89 e5             	mov    %rsp,%rbp
  801cd6:	48 83 ec 20          	sub    $0x20,%rsp
  801cda:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cdd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ce1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ce5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ce8:	48 98                	cltq   
  801cea:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cf1:	00 
  801cf2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cf8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cfe:	48 89 d1             	mov    %rdx,%rcx
  801d01:	48 89 c2             	mov    %rax,%rdx
  801d04:	be 01 00 00 00       	mov    $0x1,%esi
  801d09:	bf 0a 00 00 00       	mov    $0xa,%edi
  801d0e:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801d15:	00 00 00 
  801d18:	ff d0                	callq  *%rax
  801d1a:	c9                   	leaveq 
  801d1b:	c3                   	retq   

0000000000801d1c <sys_ipc_try_send>:
  801d1c:	55                   	push   %rbp
  801d1d:	48 89 e5             	mov    %rsp,%rbp
  801d20:	48 83 ec 20          	sub    $0x20,%rsp
  801d24:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d27:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d2b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801d2f:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801d32:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d35:	48 63 f0             	movslq %eax,%rsi
  801d38:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801d3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d3f:	48 98                	cltq   
  801d41:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d45:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d4c:	00 
  801d4d:	49 89 f1             	mov    %rsi,%r9
  801d50:	49 89 c8             	mov    %rcx,%r8
  801d53:	48 89 d1             	mov    %rdx,%rcx
  801d56:	48 89 c2             	mov    %rax,%rdx
  801d59:	be 00 00 00 00       	mov    $0x0,%esi
  801d5e:	bf 0c 00 00 00       	mov    $0xc,%edi
  801d63:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801d6a:	00 00 00 
  801d6d:	ff d0                	callq  *%rax
  801d6f:	c9                   	leaveq 
  801d70:	c3                   	retq   

0000000000801d71 <sys_ipc_recv>:
  801d71:	55                   	push   %rbp
  801d72:	48 89 e5             	mov    %rsp,%rbp
  801d75:	48 83 ec 10          	sub    $0x10,%rsp
  801d79:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d81:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d88:	00 
  801d89:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d8f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d95:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d9a:	48 89 c2             	mov    %rax,%rdx
  801d9d:	be 01 00 00 00       	mov    $0x1,%esi
  801da2:	bf 0d 00 00 00       	mov    $0xd,%edi
  801da7:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801dae:	00 00 00 
  801db1:	ff d0                	callq  *%rax
  801db3:	c9                   	leaveq 
  801db4:	c3                   	retq   

0000000000801db5 <sys_time_msec>:
  801db5:	55                   	push   %rbp
  801db6:	48 89 e5             	mov    %rsp,%rbp
  801db9:	48 83 ec 10          	sub    $0x10,%rsp
  801dbd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dc4:	00 
  801dc5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dcb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dd1:	b9 00 00 00 00       	mov    $0x0,%ecx
  801dd6:	ba 00 00 00 00       	mov    $0x0,%edx
  801ddb:	be 00 00 00 00       	mov    $0x0,%esi
  801de0:	bf 0e 00 00 00       	mov    $0xe,%edi
  801de5:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801dec:	00 00 00 
  801def:	ff d0                	callq  *%rax
  801df1:	c9                   	leaveq 
  801df2:	c3                   	retq   

0000000000801df3 <sys_net_transmit>:
  801df3:	55                   	push   %rbp
  801df4:	48 89 e5             	mov    %rsp,%rbp
  801df7:	48 83 ec 20          	sub    $0x20,%rsp
  801dfb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801dff:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801e02:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801e05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e09:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e10:	00 
  801e11:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e17:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e1d:	48 89 d1             	mov    %rdx,%rcx
  801e20:	48 89 c2             	mov    %rax,%rdx
  801e23:	be 00 00 00 00       	mov    $0x0,%esi
  801e28:	bf 0f 00 00 00       	mov    $0xf,%edi
  801e2d:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801e34:	00 00 00 
  801e37:	ff d0                	callq  *%rax
  801e39:	c9                   	leaveq 
  801e3a:	c3                   	retq   

0000000000801e3b <sys_net_receive>:
  801e3b:	55                   	push   %rbp
  801e3c:	48 89 e5             	mov    %rsp,%rbp
  801e3f:	48 83 ec 20          	sub    $0x20,%rsp
  801e43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e47:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801e4a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801e4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e51:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e58:	00 
  801e59:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e5f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e65:	48 89 d1             	mov    %rdx,%rcx
  801e68:	48 89 c2             	mov    %rax,%rdx
  801e6b:	be 00 00 00 00       	mov    $0x0,%esi
  801e70:	bf 10 00 00 00       	mov    $0x10,%edi
  801e75:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801e7c:	00 00 00 
  801e7f:	ff d0                	callq  *%rax
  801e81:	c9                   	leaveq 
  801e82:	c3                   	retq   

0000000000801e83 <sys_ept_map>:
  801e83:	55                   	push   %rbp
  801e84:	48 89 e5             	mov    %rsp,%rbp
  801e87:	48 83 ec 30          	sub    $0x30,%rsp
  801e8b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e8e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e92:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e95:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801e99:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801e9d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801ea0:	48 63 c8             	movslq %eax,%rcx
  801ea3:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801ea7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801eaa:	48 63 f0             	movslq %eax,%rsi
  801ead:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801eb1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801eb4:	48 98                	cltq   
  801eb6:	48 89 0c 24          	mov    %rcx,(%rsp)
  801eba:	49 89 f9             	mov    %rdi,%r9
  801ebd:	49 89 f0             	mov    %rsi,%r8
  801ec0:	48 89 d1             	mov    %rdx,%rcx
  801ec3:	48 89 c2             	mov    %rax,%rdx
  801ec6:	be 00 00 00 00       	mov    $0x0,%esi
  801ecb:	bf 11 00 00 00       	mov    $0x11,%edi
  801ed0:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801ed7:	00 00 00 
  801eda:	ff d0                	callq  *%rax
  801edc:	c9                   	leaveq 
  801edd:	c3                   	retq   

0000000000801ede <sys_env_mkguest>:
  801ede:	55                   	push   %rbp
  801edf:	48 89 e5             	mov    %rsp,%rbp
  801ee2:	48 83 ec 20          	sub    $0x20,%rsp
  801ee6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801eea:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801eee:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ef2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ef6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801efd:	00 
  801efe:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f04:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f0a:	48 89 d1             	mov    %rdx,%rcx
  801f0d:	48 89 c2             	mov    %rax,%rdx
  801f10:	be 00 00 00 00       	mov    $0x0,%esi
  801f15:	bf 12 00 00 00       	mov    $0x12,%edi
  801f1a:	48 b8 72 19 80 00 00 	movabs $0x801972,%rax
  801f21:	00 00 00 
  801f24:	ff d0                	callq  *%rax
  801f26:	c9                   	leaveq 
  801f27:	c3                   	retq   

0000000000801f28 <pgfault>:
  801f28:	55                   	push   %rbp
  801f29:	48 89 e5             	mov    %rsp,%rbp
  801f2c:	48 83 ec 30          	sub    $0x30,%rsp
  801f30:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801f34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f38:	48 8b 00             	mov    (%rax),%rax
  801f3b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801f3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f43:	48 8b 40 08          	mov    0x8(%rax),%rax
  801f47:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801f4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f4d:	83 e0 02             	and    $0x2,%eax
  801f50:	85 c0                	test   %eax,%eax
  801f52:	75 40                	jne    801f94 <pgfault+0x6c>
  801f54:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f58:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801f5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f63:	49 89 d0             	mov    %rdx,%r8
  801f66:	48 89 c1             	mov    %rax,%rcx
  801f69:	48 ba 18 50 80 00 00 	movabs $0x805018,%rdx
  801f70:	00 00 00 
  801f73:	be 1f 00 00 00       	mov    $0x1f,%esi
  801f78:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  801f7f:	00 00 00 
  801f82:	b8 00 00 00 00       	mov    $0x0,%eax
  801f87:	49 b9 2b 04 80 00 00 	movabs $0x80042b,%r9
  801f8e:	00 00 00 
  801f91:	41 ff d1             	callq  *%r9
  801f94:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f98:	48 c1 e8 0c          	shr    $0xc,%rax
  801f9c:	48 89 c2             	mov    %rax,%rdx
  801f9f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fa6:	01 00 00 
  801fa9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fad:	25 07 08 00 00       	and    $0x807,%eax
  801fb2:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  801fb8:	74 4e                	je     802008 <pgfault+0xe0>
  801fba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801fbe:	48 c1 e8 0c          	shr    $0xc,%rax
  801fc2:	48 89 c2             	mov    %rax,%rdx
  801fc5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fcc:	01 00 00 
  801fcf:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801fd3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801fd7:	49 89 d0             	mov    %rdx,%r8
  801fda:	48 89 c1             	mov    %rax,%rcx
  801fdd:	48 ba 40 50 80 00 00 	movabs $0x805040,%rdx
  801fe4:	00 00 00 
  801fe7:	be 22 00 00 00       	mov    $0x22,%esi
  801fec:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  801ff3:	00 00 00 
  801ff6:	b8 00 00 00 00       	mov    $0x0,%eax
  801ffb:	49 b9 2b 04 80 00 00 	movabs $0x80042b,%r9
  802002:	00 00 00 
  802005:	41 ff d1             	callq  *%r9
  802008:	ba 07 00 00 00       	mov    $0x7,%edx
  80200d:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802012:	bf 00 00 00 00       	mov    $0x0,%edi
  802017:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  80201e:	00 00 00 
  802021:	ff d0                	callq  *%rax
  802023:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802026:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80202a:	79 30                	jns    80205c <pgfault+0x134>
  80202c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80202f:	89 c1                	mov    %eax,%ecx
  802031:	48 ba 6b 50 80 00 00 	movabs $0x80506b,%rdx
  802038:	00 00 00 
  80203b:	be 30 00 00 00       	mov    $0x30,%esi
  802040:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  802047:	00 00 00 
  80204a:	b8 00 00 00 00       	mov    $0x0,%eax
  80204f:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  802056:	00 00 00 
  802059:	41 ff d0             	callq  *%r8
  80205c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802060:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802064:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802068:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  80206e:	ba 00 10 00 00       	mov    $0x1000,%edx
  802073:	48 89 c6             	mov    %rax,%rsi
  802076:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  80207b:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  802082:	00 00 00 
  802085:	ff d0                	callq  *%rax
  802087:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80208b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80208f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802093:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802099:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  80209f:	48 89 c1             	mov    %rax,%rcx
  8020a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8020a7:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8020ac:	bf 00 00 00 00       	mov    $0x0,%edi
  8020b1:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  8020b8:	00 00 00 
  8020bb:	ff d0                	callq  *%rax
  8020bd:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8020c0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8020c4:	79 30                	jns    8020f6 <pgfault+0x1ce>
  8020c6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020c9:	89 c1                	mov    %eax,%ecx
  8020cb:	48 ba 7e 50 80 00 00 	movabs $0x80507e,%rdx
  8020d2:	00 00 00 
  8020d5:	be 35 00 00 00       	mov    $0x35,%esi
  8020da:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  8020e1:	00 00 00 
  8020e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8020e9:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8020f0:	00 00 00 
  8020f3:	41 ff d0             	callq  *%r8
  8020f6:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8020fb:	bf 00 00 00 00       	mov    $0x0,%edi
  802100:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  802107:	00 00 00 
  80210a:	ff d0                	callq  *%rax
  80210c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80210f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802113:	79 30                	jns    802145 <pgfault+0x21d>
  802115:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802118:	89 c1                	mov    %eax,%ecx
  80211a:	48 ba 8f 50 80 00 00 	movabs $0x80508f,%rdx
  802121:	00 00 00 
  802124:	be 39 00 00 00       	mov    $0x39,%esi
  802129:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  802130:	00 00 00 
  802133:	b8 00 00 00 00       	mov    $0x0,%eax
  802138:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  80213f:	00 00 00 
  802142:	41 ff d0             	callq  *%r8
  802145:	c9                   	leaveq 
  802146:	c3                   	retq   

0000000000802147 <duppage>:
  802147:	55                   	push   %rbp
  802148:	48 89 e5             	mov    %rsp,%rbp
  80214b:	48 83 ec 30          	sub    $0x30,%rsp
  80214f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802152:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802155:	8b 45 d8             	mov    -0x28(%rbp),%eax
  802158:	c1 e0 0c             	shl    $0xc,%eax
  80215b:	89 c0                	mov    %eax,%eax
  80215d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802161:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802168:	01 00 00 
  80216b:	8b 55 d8             	mov    -0x28(%rbp),%edx
  80216e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802172:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802176:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80217a:	25 02 08 00 00       	and    $0x802,%eax
  80217f:	48 85 c0             	test   %rax,%rax
  802182:	74 0e                	je     802192 <duppage+0x4b>
  802184:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802188:	25 00 04 00 00       	and    $0x400,%eax
  80218d:	48 85 c0             	test   %rax,%rax
  802190:	74 70                	je     802202 <duppage+0xbb>
  802192:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802196:	25 07 0e 00 00       	and    $0xe07,%eax
  80219b:	89 c6                	mov    %eax,%esi
  80219d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8021a1:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8021a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8021a8:	41 89 f0             	mov    %esi,%r8d
  8021ab:	48 89 c6             	mov    %rax,%rsi
  8021ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8021b3:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  8021ba:	00 00 00 
  8021bd:	ff d0                	callq  *%rax
  8021bf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8021c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8021c6:	79 30                	jns    8021f8 <duppage+0xb1>
  8021c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8021cb:	89 c1                	mov    %eax,%ecx
  8021cd:	48 ba 7e 50 80 00 00 	movabs $0x80507e,%rdx
  8021d4:	00 00 00 
  8021d7:	be 63 00 00 00       	mov    $0x63,%esi
  8021dc:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  8021e3:	00 00 00 
  8021e6:	b8 00 00 00 00       	mov    $0x0,%eax
  8021eb:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8021f2:	00 00 00 
  8021f5:	41 ff d0             	callq  *%r8
  8021f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8021fd:	e9 c4 00 00 00       	jmpq   8022c6 <duppage+0x17f>
  802202:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802206:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802209:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80220d:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802213:	48 89 c6             	mov    %rax,%rsi
  802216:	bf 00 00 00 00       	mov    $0x0,%edi
  80221b:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  802222:	00 00 00 
  802225:	ff d0                	callq  *%rax
  802227:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80222a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80222e:	79 30                	jns    802260 <duppage+0x119>
  802230:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802233:	89 c1                	mov    %eax,%ecx
  802235:	48 ba 7e 50 80 00 00 	movabs $0x80507e,%rdx
  80223c:	00 00 00 
  80223f:	be 7e 00 00 00       	mov    $0x7e,%esi
  802244:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  80224b:	00 00 00 
  80224e:	b8 00 00 00 00       	mov    $0x0,%eax
  802253:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  80225a:	00 00 00 
  80225d:	41 ff d0             	callq  *%r8
  802260:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802268:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  80226e:	48 89 d1             	mov    %rdx,%rcx
  802271:	ba 00 00 00 00       	mov    $0x0,%edx
  802276:	48 89 c6             	mov    %rax,%rsi
  802279:	bf 00 00 00 00       	mov    $0x0,%edi
  80227e:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  802285:	00 00 00 
  802288:	ff d0                	callq  *%rax
  80228a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80228d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802291:	79 30                	jns    8022c3 <duppage+0x17c>
  802293:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802296:	89 c1                	mov    %eax,%ecx
  802298:	48 ba 7e 50 80 00 00 	movabs $0x80507e,%rdx
  80229f:	00 00 00 
  8022a2:	be 80 00 00 00       	mov    $0x80,%esi
  8022a7:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  8022ae:	00 00 00 
  8022b1:	b8 00 00 00 00       	mov    $0x0,%eax
  8022b6:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8022bd:	00 00 00 
  8022c0:	41 ff d0             	callq  *%r8
  8022c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022c6:	c9                   	leaveq 
  8022c7:	c3                   	retq   

00000000008022c8 <fork>:
  8022c8:	55                   	push   %rbp
  8022c9:	48 89 e5             	mov    %rsp,%rbp
  8022cc:	48 83 ec 20          	sub    $0x20,%rsp
  8022d0:	48 bf 28 1f 80 00 00 	movabs $0x801f28,%rdi
  8022d7:	00 00 00 
  8022da:	48 b8 b7 48 80 00 00 	movabs $0x8048b7,%rax
  8022e1:	00 00 00 
  8022e4:	ff d0                	callq  *%rax
  8022e6:	b8 07 00 00 00       	mov    $0x7,%eax
  8022eb:	cd 30                	int    $0x30
  8022ed:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8022f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022f3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022f6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022fa:	79 08                	jns    802304 <fork+0x3c>
  8022fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022ff:	e9 09 02 00 00       	jmpq   80250d <fork+0x245>
  802304:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802308:	75 3e                	jne    802348 <fork+0x80>
  80230a:	48 b8 cc 1a 80 00 00 	movabs $0x801acc,%rax
  802311:	00 00 00 
  802314:	ff d0                	callq  *%rax
  802316:	25 ff 03 00 00       	and    $0x3ff,%eax
  80231b:	48 98                	cltq   
  80231d:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  802324:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80232b:	00 00 00 
  80232e:	48 01 c2             	add    %rax,%rdx
  802331:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802338:	00 00 00 
  80233b:	48 89 10             	mov    %rdx,(%rax)
  80233e:	b8 00 00 00 00       	mov    $0x0,%eax
  802343:	e9 c5 01 00 00       	jmpq   80250d <fork+0x245>
  802348:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80234f:	e9 a4 00 00 00       	jmpq   8023f8 <fork+0x130>
  802354:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802357:	c1 f8 12             	sar    $0x12,%eax
  80235a:	89 c2                	mov    %eax,%edx
  80235c:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  802363:	01 00 00 
  802366:	48 63 d2             	movslq %edx,%rdx
  802369:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80236d:	83 e0 01             	and    $0x1,%eax
  802370:	48 85 c0             	test   %rax,%rax
  802373:	74 21                	je     802396 <fork+0xce>
  802375:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802378:	c1 f8 09             	sar    $0x9,%eax
  80237b:	89 c2                	mov    %eax,%edx
  80237d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802384:	01 00 00 
  802387:	48 63 d2             	movslq %edx,%rdx
  80238a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80238e:	83 e0 01             	and    $0x1,%eax
  802391:	48 85 c0             	test   %rax,%rax
  802394:	75 09                	jne    80239f <fork+0xd7>
  802396:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  80239d:	eb 59                	jmp    8023f8 <fork+0x130>
  80239f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023a2:	05 00 02 00 00       	add    $0x200,%eax
  8023a7:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8023aa:	eb 44                	jmp    8023f0 <fork+0x128>
  8023ac:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8023b3:	01 00 00 
  8023b6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8023b9:	48 63 d2             	movslq %edx,%rdx
  8023bc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023c0:	83 e0 05             	and    $0x5,%eax
  8023c3:	48 83 f8 05          	cmp    $0x5,%rax
  8023c7:	74 02                	je     8023cb <fork+0x103>
  8023c9:	eb 21                	jmp    8023ec <fork+0x124>
  8023cb:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  8023d2:	75 02                	jne    8023d6 <fork+0x10e>
  8023d4:	eb 16                	jmp    8023ec <fork+0x124>
  8023d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8023d9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023dc:	89 d6                	mov    %edx,%esi
  8023de:	89 c7                	mov    %eax,%edi
  8023e0:	48 b8 47 21 80 00 00 	movabs $0x802147,%rax
  8023e7:	00 00 00 
  8023ea:	ff d0                	callq  *%rax
  8023ec:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8023f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023f3:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8023f6:	7c b4                	jl     8023ac <fork+0xe4>
  8023f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023fb:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  802400:	0f 86 4e ff ff ff    	jbe    802354 <fork+0x8c>
  802406:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802409:	ba 07 00 00 00       	mov    $0x7,%edx
  80240e:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  802413:	89 c7                	mov    %eax,%edi
  802415:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  80241c:	00 00 00 
  80241f:	ff d0                	callq  *%rax
  802421:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802424:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802428:	79 30                	jns    80245a <fork+0x192>
  80242a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80242d:	89 c1                	mov    %eax,%ecx
  80242f:	48 ba a8 50 80 00 00 	movabs $0x8050a8,%rdx
  802436:	00 00 00 
  802439:	be bc 00 00 00       	mov    $0xbc,%esi
  80243e:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  802445:	00 00 00 
  802448:	b8 00 00 00 00       	mov    $0x0,%eax
  80244d:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  802454:	00 00 00 
  802457:	41 ff d0             	callq  *%r8
  80245a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802461:	00 00 00 
  802464:	48 8b 00             	mov    (%rax),%rax
  802467:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  80246e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802471:	48 89 d6             	mov    %rdx,%rsi
  802474:	89 c7                	mov    %eax,%edi
  802476:	48 b8 d2 1c 80 00 00 	movabs $0x801cd2,%rax
  80247d:	00 00 00 
  802480:	ff d0                	callq  *%rax
  802482:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802485:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802489:	79 30                	jns    8024bb <fork+0x1f3>
  80248b:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80248e:	89 c1                	mov    %eax,%ecx
  802490:	48 ba c8 50 80 00 00 	movabs $0x8050c8,%rdx
  802497:	00 00 00 
  80249a:	be c0 00 00 00       	mov    $0xc0,%esi
  80249f:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  8024a6:	00 00 00 
  8024a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8024ae:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  8024b5:	00 00 00 
  8024b8:	41 ff d0             	callq  *%r8
  8024bb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8024be:	be 02 00 00 00       	mov    $0x2,%esi
  8024c3:	89 c7                	mov    %eax,%edi
  8024c5:	48 b8 3d 1c 80 00 00 	movabs $0x801c3d,%rax
  8024cc:	00 00 00 
  8024cf:	ff d0                	callq  *%rax
  8024d1:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8024d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8024d8:	79 30                	jns    80250a <fork+0x242>
  8024da:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8024dd:	89 c1                	mov    %eax,%ecx
  8024df:	48 ba e7 50 80 00 00 	movabs $0x8050e7,%rdx
  8024e6:	00 00 00 
  8024e9:	be c5 00 00 00       	mov    $0xc5,%esi
  8024ee:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  8024f5:	00 00 00 
  8024f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8024fd:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  802504:	00 00 00 
  802507:	41 ff d0             	callq  *%r8
  80250a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80250d:	c9                   	leaveq 
  80250e:	c3                   	retq   

000000000080250f <sfork>:
  80250f:	55                   	push   %rbp
  802510:	48 89 e5             	mov    %rsp,%rbp
  802513:	48 ba fe 50 80 00 00 	movabs $0x8050fe,%rdx
  80251a:	00 00 00 
  80251d:	be d2 00 00 00       	mov    $0xd2,%esi
  802522:	48 bf 31 50 80 00 00 	movabs $0x805031,%rdi
  802529:	00 00 00 
  80252c:	b8 00 00 00 00       	mov    $0x0,%eax
  802531:	48 b9 2b 04 80 00 00 	movabs $0x80042b,%rcx
  802538:	00 00 00 
  80253b:	ff d1                	callq  *%rcx

000000000080253d <ipc_recv>:
  80253d:	55                   	push   %rbp
  80253e:	48 89 e5             	mov    %rsp,%rbp
  802541:	48 83 ec 30          	sub    $0x30,%rsp
  802545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802549:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80254d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802551:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802556:	75 0e                	jne    802566 <ipc_recv+0x29>
  802558:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80255f:	00 00 00 
  802562:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802566:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80256a:	48 89 c7             	mov    %rax,%rdi
  80256d:	48 b8 71 1d 80 00 00 	movabs $0x801d71,%rax
  802574:	00 00 00 
  802577:	ff d0                	callq  *%rax
  802579:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80257c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802580:	79 27                	jns    8025a9 <ipc_recv+0x6c>
  802582:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802587:	74 0a                	je     802593 <ipc_recv+0x56>
  802589:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80258d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802593:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802598:	74 0a                	je     8025a4 <ipc_recv+0x67>
  80259a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80259e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8025a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025a7:	eb 53                	jmp    8025fc <ipc_recv+0xbf>
  8025a9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8025ae:	74 19                	je     8025c9 <ipc_recv+0x8c>
  8025b0:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8025b7:	00 00 00 
  8025ba:	48 8b 00             	mov    (%rax),%rax
  8025bd:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8025c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025c7:	89 10                	mov    %edx,(%rax)
  8025c9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8025ce:	74 19                	je     8025e9 <ipc_recv+0xac>
  8025d0:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8025d7:	00 00 00 
  8025da:	48 8b 00             	mov    (%rax),%rax
  8025dd:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  8025e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025e7:	89 10                	mov    %edx,(%rax)
  8025e9:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8025f0:	00 00 00 
  8025f3:	48 8b 00             	mov    (%rax),%rax
  8025f6:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  8025fc:	c9                   	leaveq 
  8025fd:	c3                   	retq   

00000000008025fe <ipc_send>:
  8025fe:	55                   	push   %rbp
  8025ff:	48 89 e5             	mov    %rsp,%rbp
  802602:	48 83 ec 30          	sub    $0x30,%rsp
  802606:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802609:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80260c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802610:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  802613:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802618:	75 10                	jne    80262a <ipc_send+0x2c>
  80261a:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802621:	00 00 00 
  802624:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802628:	eb 0e                	jmp    802638 <ipc_send+0x3a>
  80262a:	eb 0c                	jmp    802638 <ipc_send+0x3a>
  80262c:	48 b8 0a 1b 80 00 00 	movabs $0x801b0a,%rax
  802633:	00 00 00 
  802636:	ff d0                	callq  *%rax
  802638:	8b 75 e8             	mov    -0x18(%rbp),%esi
  80263b:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  80263e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802642:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802645:	89 c7                	mov    %eax,%edi
  802647:	48 b8 1c 1d 80 00 00 	movabs $0x801d1c,%rax
  80264e:	00 00 00 
  802651:	ff d0                	callq  *%rax
  802653:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802656:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  80265a:	74 d0                	je     80262c <ipc_send+0x2e>
  80265c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802660:	79 30                	jns    802692 <ipc_send+0x94>
  802662:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802665:	89 c1                	mov    %eax,%ecx
  802667:	48 ba 18 51 80 00 00 	movabs $0x805118,%rdx
  80266e:	00 00 00 
  802671:	be 44 00 00 00       	mov    $0x44,%esi
  802676:	48 bf 2e 51 80 00 00 	movabs $0x80512e,%rdi
  80267d:	00 00 00 
  802680:	b8 00 00 00 00       	mov    $0x0,%eax
  802685:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  80268c:	00 00 00 
  80268f:	41 ff d0             	callq  *%r8
  802692:	c9                   	leaveq 
  802693:	c3                   	retq   

0000000000802694 <ipc_host_recv>:
  802694:	55                   	push   %rbp
  802695:	48 89 e5             	mov    %rsp,%rbp
  802698:	48 83 ec 10          	sub    $0x10,%rsp
  80269c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8026a0:	48 ba 40 51 80 00 00 	movabs $0x805140,%rdx
  8026a7:	00 00 00 
  8026aa:	be 4e 00 00 00       	mov    $0x4e,%esi
  8026af:	48 bf 2e 51 80 00 00 	movabs $0x80512e,%rdi
  8026b6:	00 00 00 
  8026b9:	b8 00 00 00 00       	mov    $0x0,%eax
  8026be:	48 b9 2b 04 80 00 00 	movabs $0x80042b,%rcx
  8026c5:	00 00 00 
  8026c8:	ff d1                	callq  *%rcx

00000000008026ca <ipc_host_send>:
  8026ca:	55                   	push   %rbp
  8026cb:	48 89 e5             	mov    %rsp,%rbp
  8026ce:	48 83 ec 20          	sub    $0x20,%rsp
  8026d2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8026d5:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8026d8:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  8026dc:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8026df:	48 ba 60 51 80 00 00 	movabs $0x805160,%rdx
  8026e6:	00 00 00 
  8026e9:	be 67 00 00 00       	mov    $0x67,%esi
  8026ee:	48 bf 2e 51 80 00 00 	movabs $0x80512e,%rdi
  8026f5:	00 00 00 
  8026f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8026fd:	48 b9 2b 04 80 00 00 	movabs $0x80042b,%rcx
  802704:	00 00 00 
  802707:	ff d1                	callq  *%rcx

0000000000802709 <ipc_find_env>:
  802709:	55                   	push   %rbp
  80270a:	48 89 e5             	mov    %rsp,%rbp
  80270d:	48 83 ec 14          	sub    $0x14,%rsp
  802711:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802714:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80271b:	eb 4e                	jmp    80276b <ipc_find_env+0x62>
  80271d:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802724:	00 00 00 
  802727:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80272a:	48 98                	cltq   
  80272c:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802733:	48 01 d0             	add    %rdx,%rax
  802736:	48 05 d0 00 00 00    	add    $0xd0,%rax
  80273c:	8b 00                	mov    (%rax),%eax
  80273e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802741:	75 24                	jne    802767 <ipc_find_env+0x5e>
  802743:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80274a:	00 00 00 
  80274d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802750:	48 98                	cltq   
  802752:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802759:	48 01 d0             	add    %rdx,%rax
  80275c:	48 05 c0 00 00 00    	add    $0xc0,%rax
  802762:	8b 40 08             	mov    0x8(%rax),%eax
  802765:	eb 12                	jmp    802779 <ipc_find_env+0x70>
  802767:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80276b:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  802772:	7e a9                	jle    80271d <ipc_find_env+0x14>
  802774:	b8 00 00 00 00       	mov    $0x0,%eax
  802779:	c9                   	leaveq 
  80277a:	c3                   	retq   

000000000080277b <fd2num>:
  80277b:	55                   	push   %rbp
  80277c:	48 89 e5             	mov    %rsp,%rbp
  80277f:	48 83 ec 08          	sub    $0x8,%rsp
  802783:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802787:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80278b:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  802792:	ff ff ff 
  802795:	48 01 d0             	add    %rdx,%rax
  802798:	48 c1 e8 0c          	shr    $0xc,%rax
  80279c:	c9                   	leaveq 
  80279d:	c3                   	retq   

000000000080279e <fd2data>:
  80279e:	55                   	push   %rbp
  80279f:	48 89 e5             	mov    %rsp,%rbp
  8027a2:	48 83 ec 08          	sub    $0x8,%rsp
  8027a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8027aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8027ae:	48 89 c7             	mov    %rax,%rdi
  8027b1:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  8027b8:	00 00 00 
  8027bb:	ff d0                	callq  *%rax
  8027bd:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  8027c3:	48 c1 e0 0c          	shl    $0xc,%rax
  8027c7:	c9                   	leaveq 
  8027c8:	c3                   	retq   

00000000008027c9 <fd_alloc>:
  8027c9:	55                   	push   %rbp
  8027ca:	48 89 e5             	mov    %rsp,%rbp
  8027cd:	48 83 ec 18          	sub    $0x18,%rsp
  8027d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8027d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8027dc:	eb 6b                	jmp    802849 <fd_alloc+0x80>
  8027de:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027e1:	48 98                	cltq   
  8027e3:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8027e9:	48 c1 e0 0c          	shl    $0xc,%rax
  8027ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8027f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027f5:	48 c1 e8 15          	shr    $0x15,%rax
  8027f9:	48 89 c2             	mov    %rax,%rdx
  8027fc:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802803:	01 00 00 
  802806:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80280a:	83 e0 01             	and    $0x1,%eax
  80280d:	48 85 c0             	test   %rax,%rax
  802810:	74 21                	je     802833 <fd_alloc+0x6a>
  802812:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802816:	48 c1 e8 0c          	shr    $0xc,%rax
  80281a:	48 89 c2             	mov    %rax,%rdx
  80281d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802824:	01 00 00 
  802827:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80282b:	83 e0 01             	and    $0x1,%eax
  80282e:	48 85 c0             	test   %rax,%rax
  802831:	75 12                	jne    802845 <fd_alloc+0x7c>
  802833:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802837:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80283b:	48 89 10             	mov    %rdx,(%rax)
  80283e:	b8 00 00 00 00       	mov    $0x0,%eax
  802843:	eb 1a                	jmp    80285f <fd_alloc+0x96>
  802845:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802849:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80284d:	7e 8f                	jle    8027de <fd_alloc+0x15>
  80284f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802853:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80285a:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  80285f:	c9                   	leaveq 
  802860:	c3                   	retq   

0000000000802861 <fd_lookup>:
  802861:	55                   	push   %rbp
  802862:	48 89 e5             	mov    %rsp,%rbp
  802865:	48 83 ec 20          	sub    $0x20,%rsp
  802869:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80286c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802870:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802874:	78 06                	js     80287c <fd_lookup+0x1b>
  802876:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  80287a:	7e 07                	jle    802883 <fd_lookup+0x22>
  80287c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802881:	eb 6c                	jmp    8028ef <fd_lookup+0x8e>
  802883:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802886:	48 98                	cltq   
  802888:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80288e:	48 c1 e0 0c          	shl    $0xc,%rax
  802892:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802896:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80289a:	48 c1 e8 15          	shr    $0x15,%rax
  80289e:	48 89 c2             	mov    %rax,%rdx
  8028a1:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8028a8:	01 00 00 
  8028ab:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8028af:	83 e0 01             	and    $0x1,%eax
  8028b2:	48 85 c0             	test   %rax,%rax
  8028b5:	74 21                	je     8028d8 <fd_lookup+0x77>
  8028b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8028bb:	48 c1 e8 0c          	shr    $0xc,%rax
  8028bf:	48 89 c2             	mov    %rax,%rdx
  8028c2:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8028c9:	01 00 00 
  8028cc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8028d0:	83 e0 01             	and    $0x1,%eax
  8028d3:	48 85 c0             	test   %rax,%rax
  8028d6:	75 07                	jne    8028df <fd_lookup+0x7e>
  8028d8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8028dd:	eb 10                	jmp    8028ef <fd_lookup+0x8e>
  8028df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028e3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8028e7:	48 89 10             	mov    %rdx,(%rax)
  8028ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8028ef:	c9                   	leaveq 
  8028f0:	c3                   	retq   

00000000008028f1 <fd_close>:
  8028f1:	55                   	push   %rbp
  8028f2:	48 89 e5             	mov    %rsp,%rbp
  8028f5:	48 83 ec 30          	sub    $0x30,%rsp
  8028f9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8028fd:	89 f0                	mov    %esi,%eax
  8028ff:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802902:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802906:	48 89 c7             	mov    %rax,%rdi
  802909:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  802910:	00 00 00 
  802913:	ff d0                	callq  *%rax
  802915:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802919:	48 89 d6             	mov    %rdx,%rsi
  80291c:	89 c7                	mov    %eax,%edi
  80291e:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802925:	00 00 00 
  802928:	ff d0                	callq  *%rax
  80292a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80292d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802931:	78 0a                	js     80293d <fd_close+0x4c>
  802933:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802937:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  80293b:	74 12                	je     80294f <fd_close+0x5e>
  80293d:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802941:	74 05                	je     802948 <fd_close+0x57>
  802943:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802946:	eb 05                	jmp    80294d <fd_close+0x5c>
  802948:	b8 00 00 00 00       	mov    $0x0,%eax
  80294d:	eb 69                	jmp    8029b8 <fd_close+0xc7>
  80294f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802953:	8b 00                	mov    (%rax),%eax
  802955:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802959:	48 89 d6             	mov    %rdx,%rsi
  80295c:	89 c7                	mov    %eax,%edi
  80295e:	48 b8 ba 29 80 00 00 	movabs $0x8029ba,%rax
  802965:	00 00 00 
  802968:	ff d0                	callq  *%rax
  80296a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80296d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802971:	78 2a                	js     80299d <fd_close+0xac>
  802973:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802977:	48 8b 40 20          	mov    0x20(%rax),%rax
  80297b:	48 85 c0             	test   %rax,%rax
  80297e:	74 16                	je     802996 <fd_close+0xa5>
  802980:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802984:	48 8b 40 20          	mov    0x20(%rax),%rax
  802988:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80298c:	48 89 d7             	mov    %rdx,%rdi
  80298f:	ff d0                	callq  *%rax
  802991:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802994:	eb 07                	jmp    80299d <fd_close+0xac>
  802996:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80299d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029a1:	48 89 c6             	mov    %rax,%rsi
  8029a4:	bf 00 00 00 00       	mov    $0x0,%edi
  8029a9:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  8029b0:	00 00 00 
  8029b3:	ff d0                	callq  *%rax
  8029b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029b8:	c9                   	leaveq 
  8029b9:	c3                   	retq   

00000000008029ba <dev_lookup>:
  8029ba:	55                   	push   %rbp
  8029bb:	48 89 e5             	mov    %rsp,%rbp
  8029be:	48 83 ec 20          	sub    $0x20,%rsp
  8029c2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8029c5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8029c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8029d0:	eb 41                	jmp    802a13 <dev_lookup+0x59>
  8029d2:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  8029d9:	00 00 00 
  8029dc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8029df:	48 63 d2             	movslq %edx,%rdx
  8029e2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029e6:	8b 00                	mov    (%rax),%eax
  8029e8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8029eb:	75 22                	jne    802a0f <dev_lookup+0x55>
  8029ed:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  8029f4:	00 00 00 
  8029f7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8029fa:	48 63 d2             	movslq %edx,%rdx
  8029fd:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802a01:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a05:	48 89 10             	mov    %rdx,(%rax)
  802a08:	b8 00 00 00 00       	mov    $0x0,%eax
  802a0d:	eb 60                	jmp    802a6f <dev_lookup+0xb5>
  802a0f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802a13:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802a1a:	00 00 00 
  802a1d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802a20:	48 63 d2             	movslq %edx,%rdx
  802a23:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a27:	48 85 c0             	test   %rax,%rax
  802a2a:	75 a6                	jne    8029d2 <dev_lookup+0x18>
  802a2c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802a33:	00 00 00 
  802a36:	48 8b 00             	mov    (%rax),%rax
  802a39:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a3f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802a42:	89 c6                	mov    %eax,%esi
  802a44:	48 bf 80 51 80 00 00 	movabs $0x805180,%rdi
  802a4b:	00 00 00 
  802a4e:	b8 00 00 00 00       	mov    $0x0,%eax
  802a53:	48 b9 64 06 80 00 00 	movabs $0x800664,%rcx
  802a5a:	00 00 00 
  802a5d:	ff d1                	callq  *%rcx
  802a5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a63:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802a6a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802a6f:	c9                   	leaveq 
  802a70:	c3                   	retq   

0000000000802a71 <close>:
  802a71:	55                   	push   %rbp
  802a72:	48 89 e5             	mov    %rsp,%rbp
  802a75:	48 83 ec 20          	sub    $0x20,%rsp
  802a79:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802a7c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a80:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a83:	48 89 d6             	mov    %rdx,%rsi
  802a86:	89 c7                	mov    %eax,%edi
  802a88:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802a8f:	00 00 00 
  802a92:	ff d0                	callq  *%rax
  802a94:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a97:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a9b:	79 05                	jns    802aa2 <close+0x31>
  802a9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aa0:	eb 18                	jmp    802aba <close+0x49>
  802aa2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802aa6:	be 01 00 00 00       	mov    $0x1,%esi
  802aab:	48 89 c7             	mov    %rax,%rdi
  802aae:	48 b8 f1 28 80 00 00 	movabs $0x8028f1,%rax
  802ab5:	00 00 00 
  802ab8:	ff d0                	callq  *%rax
  802aba:	c9                   	leaveq 
  802abb:	c3                   	retq   

0000000000802abc <close_all>:
  802abc:	55                   	push   %rbp
  802abd:	48 89 e5             	mov    %rsp,%rbp
  802ac0:	48 83 ec 10          	sub    $0x10,%rsp
  802ac4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802acb:	eb 15                	jmp    802ae2 <close_all+0x26>
  802acd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ad0:	89 c7                	mov    %eax,%edi
  802ad2:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  802ad9:	00 00 00 
  802adc:	ff d0                	callq  *%rax
  802ade:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802ae2:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802ae6:	7e e5                	jle    802acd <close_all+0x11>
  802ae8:	c9                   	leaveq 
  802ae9:	c3                   	retq   

0000000000802aea <dup>:
  802aea:	55                   	push   %rbp
  802aeb:	48 89 e5             	mov    %rsp,%rbp
  802aee:	48 83 ec 40          	sub    $0x40,%rsp
  802af2:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802af5:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802af8:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802afc:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802aff:	48 89 d6             	mov    %rdx,%rsi
  802b02:	89 c7                	mov    %eax,%edi
  802b04:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802b0b:	00 00 00 
  802b0e:	ff d0                	callq  *%rax
  802b10:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b13:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b17:	79 08                	jns    802b21 <dup+0x37>
  802b19:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b1c:	e9 70 01 00 00       	jmpq   802c91 <dup+0x1a7>
  802b21:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802b24:	89 c7                	mov    %eax,%edi
  802b26:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  802b2d:	00 00 00 
  802b30:	ff d0                	callq  *%rax
  802b32:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802b35:	48 98                	cltq   
  802b37:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802b3d:	48 c1 e0 0c          	shl    $0xc,%rax
  802b41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802b45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b49:	48 89 c7             	mov    %rax,%rdi
  802b4c:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  802b53:	00 00 00 
  802b56:	ff d0                	callq  *%rax
  802b58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802b5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b60:	48 89 c7             	mov    %rax,%rdi
  802b63:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  802b6a:	00 00 00 
  802b6d:	ff d0                	callq  *%rax
  802b6f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802b73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b77:	48 c1 e8 15          	shr    $0x15,%rax
  802b7b:	48 89 c2             	mov    %rax,%rdx
  802b7e:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802b85:	01 00 00 
  802b88:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b8c:	83 e0 01             	and    $0x1,%eax
  802b8f:	48 85 c0             	test   %rax,%rax
  802b92:	74 73                	je     802c07 <dup+0x11d>
  802b94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b98:	48 c1 e8 0c          	shr    $0xc,%rax
  802b9c:	48 89 c2             	mov    %rax,%rdx
  802b9f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ba6:	01 00 00 
  802ba9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802bad:	83 e0 01             	and    $0x1,%eax
  802bb0:	48 85 c0             	test   %rax,%rax
  802bb3:	74 52                	je     802c07 <dup+0x11d>
  802bb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bb9:	48 c1 e8 0c          	shr    $0xc,%rax
  802bbd:	48 89 c2             	mov    %rax,%rdx
  802bc0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802bc7:	01 00 00 
  802bca:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802bce:	25 07 0e 00 00       	and    $0xe07,%eax
  802bd3:	89 c1                	mov    %eax,%ecx
  802bd5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802bd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bdd:	41 89 c8             	mov    %ecx,%r8d
  802be0:	48 89 d1             	mov    %rdx,%rcx
  802be3:	ba 00 00 00 00       	mov    $0x0,%edx
  802be8:	48 89 c6             	mov    %rax,%rsi
  802beb:	bf 00 00 00 00       	mov    $0x0,%edi
  802bf0:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  802bf7:	00 00 00 
  802bfa:	ff d0                	callq  *%rax
  802bfc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802bff:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c03:	79 02                	jns    802c07 <dup+0x11d>
  802c05:	eb 57                	jmp    802c5e <dup+0x174>
  802c07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c0b:	48 c1 e8 0c          	shr    $0xc,%rax
  802c0f:	48 89 c2             	mov    %rax,%rdx
  802c12:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802c19:	01 00 00 
  802c1c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802c20:	25 07 0e 00 00       	and    $0xe07,%eax
  802c25:	89 c1                	mov    %eax,%ecx
  802c27:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c2b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c2f:	41 89 c8             	mov    %ecx,%r8d
  802c32:	48 89 d1             	mov    %rdx,%rcx
  802c35:	ba 00 00 00 00       	mov    $0x0,%edx
  802c3a:	48 89 c6             	mov    %rax,%rsi
  802c3d:	bf 00 00 00 00       	mov    $0x0,%edi
  802c42:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  802c49:	00 00 00 
  802c4c:	ff d0                	callq  *%rax
  802c4e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c51:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c55:	79 02                	jns    802c59 <dup+0x16f>
  802c57:	eb 05                	jmp    802c5e <dup+0x174>
  802c59:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802c5c:	eb 33                	jmp    802c91 <dup+0x1a7>
  802c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c62:	48 89 c6             	mov    %rax,%rsi
  802c65:	bf 00 00 00 00       	mov    $0x0,%edi
  802c6a:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  802c71:	00 00 00 
  802c74:	ff d0                	callq  *%rax
  802c76:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c7a:	48 89 c6             	mov    %rax,%rsi
  802c7d:	bf 00 00 00 00       	mov    $0x0,%edi
  802c82:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  802c89:	00 00 00 
  802c8c:	ff d0                	callq  *%rax
  802c8e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c91:	c9                   	leaveq 
  802c92:	c3                   	retq   

0000000000802c93 <read>:
  802c93:	55                   	push   %rbp
  802c94:	48 89 e5             	mov    %rsp,%rbp
  802c97:	48 83 ec 40          	sub    $0x40,%rsp
  802c9b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c9e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802ca2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802ca6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802caa:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802cad:	48 89 d6             	mov    %rdx,%rsi
  802cb0:	89 c7                	mov    %eax,%edi
  802cb2:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802cb9:	00 00 00 
  802cbc:	ff d0                	callq  *%rax
  802cbe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cc1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cc5:	78 24                	js     802ceb <read+0x58>
  802cc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ccb:	8b 00                	mov    (%rax),%eax
  802ccd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802cd1:	48 89 d6             	mov    %rdx,%rsi
  802cd4:	89 c7                	mov    %eax,%edi
  802cd6:	48 b8 ba 29 80 00 00 	movabs $0x8029ba,%rax
  802cdd:	00 00 00 
  802ce0:	ff d0                	callq  *%rax
  802ce2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ce5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ce9:	79 05                	jns    802cf0 <read+0x5d>
  802ceb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cee:	eb 76                	jmp    802d66 <read+0xd3>
  802cf0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cf4:	8b 40 08             	mov    0x8(%rax),%eax
  802cf7:	83 e0 03             	and    $0x3,%eax
  802cfa:	83 f8 01             	cmp    $0x1,%eax
  802cfd:	75 3a                	jne    802d39 <read+0xa6>
  802cff:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802d06:	00 00 00 
  802d09:	48 8b 00             	mov    (%rax),%rax
  802d0c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802d12:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802d15:	89 c6                	mov    %eax,%esi
  802d17:	48 bf 9f 51 80 00 00 	movabs $0x80519f,%rdi
  802d1e:	00 00 00 
  802d21:	b8 00 00 00 00       	mov    $0x0,%eax
  802d26:	48 b9 64 06 80 00 00 	movabs $0x800664,%rcx
  802d2d:	00 00 00 
  802d30:	ff d1                	callq  *%rcx
  802d32:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802d37:	eb 2d                	jmp    802d66 <read+0xd3>
  802d39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d3d:	48 8b 40 10          	mov    0x10(%rax),%rax
  802d41:	48 85 c0             	test   %rax,%rax
  802d44:	75 07                	jne    802d4d <read+0xba>
  802d46:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802d4b:	eb 19                	jmp    802d66 <read+0xd3>
  802d4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d51:	48 8b 40 10          	mov    0x10(%rax),%rax
  802d55:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802d59:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802d5d:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802d61:	48 89 cf             	mov    %rcx,%rdi
  802d64:	ff d0                	callq  *%rax
  802d66:	c9                   	leaveq 
  802d67:	c3                   	retq   

0000000000802d68 <readn>:
  802d68:	55                   	push   %rbp
  802d69:	48 89 e5             	mov    %rsp,%rbp
  802d6c:	48 83 ec 30          	sub    $0x30,%rsp
  802d70:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d73:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802d77:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802d7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802d82:	eb 49                	jmp    802dcd <readn+0x65>
  802d84:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d87:	48 98                	cltq   
  802d89:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802d8d:	48 29 c2             	sub    %rax,%rdx
  802d90:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d93:	48 63 c8             	movslq %eax,%rcx
  802d96:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d9a:	48 01 c1             	add    %rax,%rcx
  802d9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802da0:	48 89 ce             	mov    %rcx,%rsi
  802da3:	89 c7                	mov    %eax,%edi
  802da5:	48 b8 93 2c 80 00 00 	movabs $0x802c93,%rax
  802dac:	00 00 00 
  802daf:	ff d0                	callq  *%rax
  802db1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802db4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802db8:	79 05                	jns    802dbf <readn+0x57>
  802dba:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802dbd:	eb 1c                	jmp    802ddb <readn+0x73>
  802dbf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802dc3:	75 02                	jne    802dc7 <readn+0x5f>
  802dc5:	eb 11                	jmp    802dd8 <readn+0x70>
  802dc7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802dca:	01 45 fc             	add    %eax,-0x4(%rbp)
  802dcd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dd0:	48 98                	cltq   
  802dd2:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802dd6:	72 ac                	jb     802d84 <readn+0x1c>
  802dd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ddb:	c9                   	leaveq 
  802ddc:	c3                   	retq   

0000000000802ddd <write>:
  802ddd:	55                   	push   %rbp
  802dde:	48 89 e5             	mov    %rsp,%rbp
  802de1:	48 83 ec 40          	sub    $0x40,%rsp
  802de5:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802de8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802dec:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802df0:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802df4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802df7:	48 89 d6             	mov    %rdx,%rsi
  802dfa:	89 c7                	mov    %eax,%edi
  802dfc:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802e03:	00 00 00 
  802e06:	ff d0                	callq  *%rax
  802e08:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e0b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e0f:	78 24                	js     802e35 <write+0x58>
  802e11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e15:	8b 00                	mov    (%rax),%eax
  802e17:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802e1b:	48 89 d6             	mov    %rdx,%rsi
  802e1e:	89 c7                	mov    %eax,%edi
  802e20:	48 b8 ba 29 80 00 00 	movabs $0x8029ba,%rax
  802e27:	00 00 00 
  802e2a:	ff d0                	callq  *%rax
  802e2c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e2f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e33:	79 05                	jns    802e3a <write+0x5d>
  802e35:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e38:	eb 75                	jmp    802eaf <write+0xd2>
  802e3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e3e:	8b 40 08             	mov    0x8(%rax),%eax
  802e41:	83 e0 03             	and    $0x3,%eax
  802e44:	85 c0                	test   %eax,%eax
  802e46:	75 3a                	jne    802e82 <write+0xa5>
  802e48:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802e4f:	00 00 00 
  802e52:	48 8b 00             	mov    (%rax),%rax
  802e55:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802e5b:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802e5e:	89 c6                	mov    %eax,%esi
  802e60:	48 bf bb 51 80 00 00 	movabs $0x8051bb,%rdi
  802e67:	00 00 00 
  802e6a:	b8 00 00 00 00       	mov    $0x0,%eax
  802e6f:	48 b9 64 06 80 00 00 	movabs $0x800664,%rcx
  802e76:	00 00 00 
  802e79:	ff d1                	callq  *%rcx
  802e7b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802e80:	eb 2d                	jmp    802eaf <write+0xd2>
  802e82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e86:	48 8b 40 18          	mov    0x18(%rax),%rax
  802e8a:	48 85 c0             	test   %rax,%rax
  802e8d:	75 07                	jne    802e96 <write+0xb9>
  802e8f:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802e94:	eb 19                	jmp    802eaf <write+0xd2>
  802e96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e9a:	48 8b 40 18          	mov    0x18(%rax),%rax
  802e9e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ea2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ea6:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802eaa:	48 89 cf             	mov    %rcx,%rdi
  802ead:	ff d0                	callq  *%rax
  802eaf:	c9                   	leaveq 
  802eb0:	c3                   	retq   

0000000000802eb1 <seek>:
  802eb1:	55                   	push   %rbp
  802eb2:	48 89 e5             	mov    %rsp,%rbp
  802eb5:	48 83 ec 18          	sub    $0x18,%rsp
  802eb9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ebc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802ebf:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802ec3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802ec6:	48 89 d6             	mov    %rdx,%rsi
  802ec9:	89 c7                	mov    %eax,%edi
  802ecb:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802ed2:	00 00 00 
  802ed5:	ff d0                	callq  *%rax
  802ed7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802eda:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ede:	79 05                	jns    802ee5 <seek+0x34>
  802ee0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ee3:	eb 0f                	jmp    802ef4 <seek+0x43>
  802ee5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ee9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802eec:	89 50 04             	mov    %edx,0x4(%rax)
  802eef:	b8 00 00 00 00       	mov    $0x0,%eax
  802ef4:	c9                   	leaveq 
  802ef5:	c3                   	retq   

0000000000802ef6 <ftruncate>:
  802ef6:	55                   	push   %rbp
  802ef7:	48 89 e5             	mov    %rsp,%rbp
  802efa:	48 83 ec 30          	sub    $0x30,%rsp
  802efe:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802f01:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802f04:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802f08:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802f0b:	48 89 d6             	mov    %rdx,%rsi
  802f0e:	89 c7                	mov    %eax,%edi
  802f10:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802f17:	00 00 00 
  802f1a:	ff d0                	callq  *%rax
  802f1c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f1f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f23:	78 24                	js     802f49 <ftruncate+0x53>
  802f25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f29:	8b 00                	mov    (%rax),%eax
  802f2b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802f2f:	48 89 d6             	mov    %rdx,%rsi
  802f32:	89 c7                	mov    %eax,%edi
  802f34:	48 b8 ba 29 80 00 00 	movabs $0x8029ba,%rax
  802f3b:	00 00 00 
  802f3e:	ff d0                	callq  *%rax
  802f40:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f43:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f47:	79 05                	jns    802f4e <ftruncate+0x58>
  802f49:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f4c:	eb 72                	jmp    802fc0 <ftruncate+0xca>
  802f4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f52:	8b 40 08             	mov    0x8(%rax),%eax
  802f55:	83 e0 03             	and    $0x3,%eax
  802f58:	85 c0                	test   %eax,%eax
  802f5a:	75 3a                	jne    802f96 <ftruncate+0xa0>
  802f5c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802f63:	00 00 00 
  802f66:	48 8b 00             	mov    (%rax),%rax
  802f69:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802f6f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802f72:	89 c6                	mov    %eax,%esi
  802f74:	48 bf d8 51 80 00 00 	movabs $0x8051d8,%rdi
  802f7b:	00 00 00 
  802f7e:	b8 00 00 00 00       	mov    $0x0,%eax
  802f83:	48 b9 64 06 80 00 00 	movabs $0x800664,%rcx
  802f8a:	00 00 00 
  802f8d:	ff d1                	callq  *%rcx
  802f8f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802f94:	eb 2a                	jmp    802fc0 <ftruncate+0xca>
  802f96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f9a:	48 8b 40 30          	mov    0x30(%rax),%rax
  802f9e:	48 85 c0             	test   %rax,%rax
  802fa1:	75 07                	jne    802faa <ftruncate+0xb4>
  802fa3:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802fa8:	eb 16                	jmp    802fc0 <ftruncate+0xca>
  802faa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fae:	48 8b 40 30          	mov    0x30(%rax),%rax
  802fb2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802fb6:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802fb9:	89 ce                	mov    %ecx,%esi
  802fbb:	48 89 d7             	mov    %rdx,%rdi
  802fbe:	ff d0                	callq  *%rax
  802fc0:	c9                   	leaveq 
  802fc1:	c3                   	retq   

0000000000802fc2 <fstat>:
  802fc2:	55                   	push   %rbp
  802fc3:	48 89 e5             	mov    %rsp,%rbp
  802fc6:	48 83 ec 30          	sub    $0x30,%rsp
  802fca:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802fcd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802fd1:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802fd5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802fd8:	48 89 d6             	mov    %rdx,%rsi
  802fdb:	89 c7                	mov    %eax,%edi
  802fdd:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  802fe4:	00 00 00 
  802fe7:	ff d0                	callq  *%rax
  802fe9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fec:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ff0:	78 24                	js     803016 <fstat+0x54>
  802ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ff6:	8b 00                	mov    (%rax),%eax
  802ff8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802ffc:	48 89 d6             	mov    %rdx,%rsi
  802fff:	89 c7                	mov    %eax,%edi
  803001:	48 b8 ba 29 80 00 00 	movabs $0x8029ba,%rax
  803008:	00 00 00 
  80300b:	ff d0                	callq  *%rax
  80300d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803010:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803014:	79 05                	jns    80301b <fstat+0x59>
  803016:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803019:	eb 5e                	jmp    803079 <fstat+0xb7>
  80301b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80301f:	48 8b 40 28          	mov    0x28(%rax),%rax
  803023:	48 85 c0             	test   %rax,%rax
  803026:	75 07                	jne    80302f <fstat+0x6d>
  803028:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80302d:	eb 4a                	jmp    803079 <fstat+0xb7>
  80302f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803033:	c6 00 00             	movb   $0x0,(%rax)
  803036:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80303a:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  803041:	00 00 00 
  803044:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803048:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80304f:	00 00 00 
  803052:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803056:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80305a:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  803061:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803065:	48 8b 40 28          	mov    0x28(%rax),%rax
  803069:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80306d:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  803071:	48 89 ce             	mov    %rcx,%rsi
  803074:	48 89 d7             	mov    %rdx,%rdi
  803077:	ff d0                	callq  *%rax
  803079:	c9                   	leaveq 
  80307a:	c3                   	retq   

000000000080307b <stat>:
  80307b:	55                   	push   %rbp
  80307c:	48 89 e5             	mov    %rsp,%rbp
  80307f:	48 83 ec 20          	sub    $0x20,%rsp
  803083:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803087:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80308b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80308f:	be 00 00 00 00       	mov    $0x0,%esi
  803094:	48 89 c7             	mov    %rax,%rdi
  803097:	48 b8 69 31 80 00 00 	movabs $0x803169,%rax
  80309e:	00 00 00 
  8030a1:	ff d0                	callq  *%rax
  8030a3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030aa:	79 05                	jns    8030b1 <stat+0x36>
  8030ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030af:	eb 2f                	jmp    8030e0 <stat+0x65>
  8030b1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8030b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030b8:	48 89 d6             	mov    %rdx,%rsi
  8030bb:	89 c7                	mov    %eax,%edi
  8030bd:	48 b8 c2 2f 80 00 00 	movabs $0x802fc2,%rax
  8030c4:	00 00 00 
  8030c7:	ff d0                	callq  *%rax
  8030c9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8030cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030cf:	89 c7                	mov    %eax,%edi
  8030d1:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  8030d8:	00 00 00 
  8030db:	ff d0                	callq  *%rax
  8030dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8030e0:	c9                   	leaveq 
  8030e1:	c3                   	retq   

00000000008030e2 <fsipc>:
  8030e2:	55                   	push   %rbp
  8030e3:	48 89 e5             	mov    %rsp,%rbp
  8030e6:	48 83 ec 10          	sub    $0x10,%rsp
  8030ea:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8030ed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8030f1:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8030f8:	00 00 00 
  8030fb:	8b 00                	mov    (%rax),%eax
  8030fd:	85 c0                	test   %eax,%eax
  8030ff:	75 1d                	jne    80311e <fsipc+0x3c>
  803101:	bf 01 00 00 00       	mov    $0x1,%edi
  803106:	48 b8 09 27 80 00 00 	movabs $0x802709,%rax
  80310d:	00 00 00 
  803110:	ff d0                	callq  *%rax
  803112:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  803119:	00 00 00 
  80311c:	89 02                	mov    %eax,(%rdx)
  80311e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  803125:	00 00 00 
  803128:	8b 00                	mov    (%rax),%eax
  80312a:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80312d:	b9 07 00 00 00       	mov    $0x7,%ecx
  803132:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  803139:	00 00 00 
  80313c:	89 c7                	mov    %eax,%edi
  80313e:	48 b8 fe 25 80 00 00 	movabs $0x8025fe,%rax
  803145:	00 00 00 
  803148:	ff d0                	callq  *%rax
  80314a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80314e:	ba 00 00 00 00       	mov    $0x0,%edx
  803153:	48 89 c6             	mov    %rax,%rsi
  803156:	bf 00 00 00 00       	mov    $0x0,%edi
  80315b:	48 b8 3d 25 80 00 00 	movabs $0x80253d,%rax
  803162:	00 00 00 
  803165:	ff d0                	callq  *%rax
  803167:	c9                   	leaveq 
  803168:	c3                   	retq   

0000000000803169 <open>:
  803169:	55                   	push   %rbp
  80316a:	48 89 e5             	mov    %rsp,%rbp
  80316d:	48 83 ec 20          	sub    $0x20,%rsp
  803171:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803175:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  803178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80317c:	48 89 c7             	mov    %rax,%rdi
  80317f:	48 b8 ad 11 80 00 00 	movabs $0x8011ad,%rax
  803186:	00 00 00 
  803189:	ff d0                	callq  *%rax
  80318b:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803190:	7e 0a                	jle    80319c <open+0x33>
  803192:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803197:	e9 a5 00 00 00       	jmpq   803241 <open+0xd8>
  80319c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8031a0:	48 89 c7             	mov    %rax,%rdi
  8031a3:	48 b8 c9 27 80 00 00 	movabs $0x8027c9,%rax
  8031aa:	00 00 00 
  8031ad:	ff d0                	callq  *%rax
  8031af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031b6:	79 08                	jns    8031c0 <open+0x57>
  8031b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031bb:	e9 81 00 00 00       	jmpq   803241 <open+0xd8>
  8031c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031c4:	48 89 c6             	mov    %rax,%rsi
  8031c7:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8031ce:	00 00 00 
  8031d1:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  8031d8:	00 00 00 
  8031db:	ff d0                	callq  *%rax
  8031dd:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8031e4:	00 00 00 
  8031e7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8031ea:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8031f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031f4:	48 89 c6             	mov    %rax,%rsi
  8031f7:	bf 01 00 00 00       	mov    $0x1,%edi
  8031fc:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  803203:	00 00 00 
  803206:	ff d0                	callq  *%rax
  803208:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80320b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80320f:	79 1d                	jns    80322e <open+0xc5>
  803211:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803215:	be 00 00 00 00       	mov    $0x0,%esi
  80321a:	48 89 c7             	mov    %rax,%rdi
  80321d:	48 b8 f1 28 80 00 00 	movabs $0x8028f1,%rax
  803224:	00 00 00 
  803227:	ff d0                	callq  *%rax
  803229:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80322c:	eb 13                	jmp    803241 <open+0xd8>
  80322e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803232:	48 89 c7             	mov    %rax,%rdi
  803235:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  80323c:	00 00 00 
  80323f:	ff d0                	callq  *%rax
  803241:	c9                   	leaveq 
  803242:	c3                   	retq   

0000000000803243 <devfile_flush>:
  803243:	55                   	push   %rbp
  803244:	48 89 e5             	mov    %rsp,%rbp
  803247:	48 83 ec 10          	sub    $0x10,%rsp
  80324b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80324f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803253:	8b 50 0c             	mov    0xc(%rax),%edx
  803256:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80325d:	00 00 00 
  803260:	89 10                	mov    %edx,(%rax)
  803262:	be 00 00 00 00       	mov    $0x0,%esi
  803267:	bf 06 00 00 00       	mov    $0x6,%edi
  80326c:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  803273:	00 00 00 
  803276:	ff d0                	callq  *%rax
  803278:	c9                   	leaveq 
  803279:	c3                   	retq   

000000000080327a <devfile_read>:
  80327a:	55                   	push   %rbp
  80327b:	48 89 e5             	mov    %rsp,%rbp
  80327e:	48 83 ec 30          	sub    $0x30,%rsp
  803282:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803286:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80328a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80328e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803292:	8b 50 0c             	mov    0xc(%rax),%edx
  803295:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80329c:	00 00 00 
  80329f:	89 10                	mov    %edx,(%rax)
  8032a1:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8032a8:	00 00 00 
  8032ab:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8032af:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8032b3:	be 00 00 00 00       	mov    $0x0,%esi
  8032b8:	bf 03 00 00 00       	mov    $0x3,%edi
  8032bd:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  8032c4:	00 00 00 
  8032c7:	ff d0                	callq  *%rax
  8032c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032d0:	79 08                	jns    8032da <devfile_read+0x60>
  8032d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032d5:	e9 a4 00 00 00       	jmpq   80337e <devfile_read+0x104>
  8032da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032dd:	48 98                	cltq   
  8032df:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8032e3:	76 35                	jbe    80331a <devfile_read+0xa0>
  8032e5:	48 b9 fe 51 80 00 00 	movabs $0x8051fe,%rcx
  8032ec:	00 00 00 
  8032ef:	48 ba 05 52 80 00 00 	movabs $0x805205,%rdx
  8032f6:	00 00 00 
  8032f9:	be 89 00 00 00       	mov    $0x89,%esi
  8032fe:	48 bf 1a 52 80 00 00 	movabs $0x80521a,%rdi
  803305:	00 00 00 
  803308:	b8 00 00 00 00       	mov    $0x0,%eax
  80330d:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  803314:	00 00 00 
  803317:	41 ff d0             	callq  *%r8
  80331a:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803321:	7e 35                	jle    803358 <devfile_read+0xde>
  803323:	48 b9 28 52 80 00 00 	movabs $0x805228,%rcx
  80332a:	00 00 00 
  80332d:	48 ba 05 52 80 00 00 	movabs $0x805205,%rdx
  803334:	00 00 00 
  803337:	be 8a 00 00 00       	mov    $0x8a,%esi
  80333c:	48 bf 1a 52 80 00 00 	movabs $0x80521a,%rdi
  803343:	00 00 00 
  803346:	b8 00 00 00 00       	mov    $0x0,%eax
  80334b:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  803352:	00 00 00 
  803355:	41 ff d0             	callq  *%r8
  803358:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80335b:	48 63 d0             	movslq %eax,%rdx
  80335e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803362:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803369:	00 00 00 
  80336c:	48 89 c7             	mov    %rax,%rdi
  80336f:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803376:	00 00 00 
  803379:	ff d0                	callq  *%rax
  80337b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80337e:	c9                   	leaveq 
  80337f:	c3                   	retq   

0000000000803380 <devfile_write>:
  803380:	55                   	push   %rbp
  803381:	48 89 e5             	mov    %rsp,%rbp
  803384:	48 83 ec 40          	sub    $0x40,%rsp
  803388:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80338c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803390:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803394:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803398:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80339c:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8033a3:	00 
  8033a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8033a8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8033ac:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8033b1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8033b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8033b9:	8b 50 0c             	mov    0xc(%rax),%edx
  8033bc:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8033c3:	00 00 00 
  8033c6:	89 10                	mov    %edx,(%rax)
  8033c8:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8033cf:	00 00 00 
  8033d2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8033d6:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8033da:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8033de:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8033e2:	48 89 c6             	mov    %rax,%rsi
  8033e5:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  8033ec:	00 00 00 
  8033ef:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  8033f6:	00 00 00 
  8033f9:	ff d0                	callq  *%rax
  8033fb:	be 00 00 00 00       	mov    $0x0,%esi
  803400:	bf 04 00 00 00       	mov    $0x4,%edi
  803405:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  80340c:	00 00 00 
  80340f:	ff d0                	callq  *%rax
  803411:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803414:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803418:	79 05                	jns    80341f <devfile_write+0x9f>
  80341a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80341d:	eb 43                	jmp    803462 <devfile_write+0xe2>
  80341f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803422:	48 98                	cltq   
  803424:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803428:	76 35                	jbe    80345f <devfile_write+0xdf>
  80342a:	48 b9 fe 51 80 00 00 	movabs $0x8051fe,%rcx
  803431:	00 00 00 
  803434:	48 ba 05 52 80 00 00 	movabs $0x805205,%rdx
  80343b:	00 00 00 
  80343e:	be a8 00 00 00       	mov    $0xa8,%esi
  803443:	48 bf 1a 52 80 00 00 	movabs $0x80521a,%rdi
  80344a:	00 00 00 
  80344d:	b8 00 00 00 00       	mov    $0x0,%eax
  803452:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  803459:	00 00 00 
  80345c:	41 ff d0             	callq  *%r8
  80345f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803462:	c9                   	leaveq 
  803463:	c3                   	retq   

0000000000803464 <devfile_stat>:
  803464:	55                   	push   %rbp
  803465:	48 89 e5             	mov    %rsp,%rbp
  803468:	48 83 ec 20          	sub    $0x20,%rsp
  80346c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803470:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803478:	8b 50 0c             	mov    0xc(%rax),%edx
  80347b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803482:	00 00 00 
  803485:	89 10                	mov    %edx,(%rax)
  803487:	be 00 00 00 00       	mov    $0x0,%esi
  80348c:	bf 05 00 00 00       	mov    $0x5,%edi
  803491:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  803498:	00 00 00 
  80349b:	ff d0                	callq  *%rax
  80349d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034a0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034a4:	79 05                	jns    8034ab <devfile_stat+0x47>
  8034a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034a9:	eb 56                	jmp    803501 <devfile_stat+0x9d>
  8034ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8034af:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8034b6:	00 00 00 
  8034b9:	48 89 c7             	mov    %rax,%rdi
  8034bc:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  8034c3:	00 00 00 
  8034c6:	ff d0                	callq  *%rax
  8034c8:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034cf:	00 00 00 
  8034d2:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8034d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8034dc:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8034e2:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034e9:	00 00 00 
  8034ec:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  8034f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8034f6:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  8034fc:	b8 00 00 00 00       	mov    $0x0,%eax
  803501:	c9                   	leaveq 
  803502:	c3                   	retq   

0000000000803503 <devfile_trunc>:
  803503:	55                   	push   %rbp
  803504:	48 89 e5             	mov    %rsp,%rbp
  803507:	48 83 ec 10          	sub    $0x10,%rsp
  80350b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80350f:	89 75 f4             	mov    %esi,-0xc(%rbp)
  803512:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803516:	8b 50 0c             	mov    0xc(%rax),%edx
  803519:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803520:	00 00 00 
  803523:	89 10                	mov    %edx,(%rax)
  803525:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80352c:	00 00 00 
  80352f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803532:	89 50 04             	mov    %edx,0x4(%rax)
  803535:	be 00 00 00 00       	mov    $0x0,%esi
  80353a:	bf 02 00 00 00       	mov    $0x2,%edi
  80353f:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  803546:	00 00 00 
  803549:	ff d0                	callq  *%rax
  80354b:	c9                   	leaveq 
  80354c:	c3                   	retq   

000000000080354d <remove>:
  80354d:	55                   	push   %rbp
  80354e:	48 89 e5             	mov    %rsp,%rbp
  803551:	48 83 ec 10          	sub    $0x10,%rsp
  803555:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80355d:	48 89 c7             	mov    %rax,%rdi
  803560:	48 b8 ad 11 80 00 00 	movabs $0x8011ad,%rax
  803567:	00 00 00 
  80356a:	ff d0                	callq  *%rax
  80356c:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803571:	7e 07                	jle    80357a <remove+0x2d>
  803573:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803578:	eb 33                	jmp    8035ad <remove+0x60>
  80357a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80357e:	48 89 c6             	mov    %rax,%rsi
  803581:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803588:	00 00 00 
  80358b:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  803592:	00 00 00 
  803595:	ff d0                	callq  *%rax
  803597:	be 00 00 00 00       	mov    $0x0,%esi
  80359c:	bf 07 00 00 00       	mov    $0x7,%edi
  8035a1:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  8035a8:	00 00 00 
  8035ab:	ff d0                	callq  *%rax
  8035ad:	c9                   	leaveq 
  8035ae:	c3                   	retq   

00000000008035af <sync>:
  8035af:	55                   	push   %rbp
  8035b0:	48 89 e5             	mov    %rsp,%rbp
  8035b3:	be 00 00 00 00       	mov    $0x0,%esi
  8035b8:	bf 08 00 00 00       	mov    $0x8,%edi
  8035bd:	48 b8 e2 30 80 00 00 	movabs $0x8030e2,%rax
  8035c4:	00 00 00 
  8035c7:	ff d0                	callq  *%rax
  8035c9:	5d                   	pop    %rbp
  8035ca:	c3                   	retq   

00000000008035cb <copy>:
  8035cb:	55                   	push   %rbp
  8035cc:	48 89 e5             	mov    %rsp,%rbp
  8035cf:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8035d6:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  8035dd:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  8035e4:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  8035eb:	be 00 00 00 00       	mov    $0x0,%esi
  8035f0:	48 89 c7             	mov    %rax,%rdi
  8035f3:	48 b8 69 31 80 00 00 	movabs $0x803169,%rax
  8035fa:	00 00 00 
  8035fd:	ff d0                	callq  *%rax
  8035ff:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803602:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803606:	79 28                	jns    803630 <copy+0x65>
  803608:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80360b:	89 c6                	mov    %eax,%esi
  80360d:	48 bf 34 52 80 00 00 	movabs $0x805234,%rdi
  803614:	00 00 00 
  803617:	b8 00 00 00 00       	mov    $0x0,%eax
  80361c:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  803623:	00 00 00 
  803626:	ff d2                	callq  *%rdx
  803628:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80362b:	e9 74 01 00 00       	jmpq   8037a4 <copy+0x1d9>
  803630:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803637:	be 01 01 00 00       	mov    $0x101,%esi
  80363c:	48 89 c7             	mov    %rax,%rdi
  80363f:	48 b8 69 31 80 00 00 	movabs $0x803169,%rax
  803646:	00 00 00 
  803649:	ff d0                	callq  *%rax
  80364b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80364e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803652:	79 39                	jns    80368d <copy+0xc2>
  803654:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803657:	89 c6                	mov    %eax,%esi
  803659:	48 bf 4a 52 80 00 00 	movabs $0x80524a,%rdi
  803660:	00 00 00 
  803663:	b8 00 00 00 00       	mov    $0x0,%eax
  803668:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  80366f:	00 00 00 
  803672:	ff d2                	callq  *%rdx
  803674:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803677:	89 c7                	mov    %eax,%edi
  803679:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  803680:	00 00 00 
  803683:	ff d0                	callq  *%rax
  803685:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803688:	e9 17 01 00 00       	jmpq   8037a4 <copy+0x1d9>
  80368d:	eb 74                	jmp    803703 <copy+0x138>
  80368f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803692:	48 63 d0             	movslq %eax,%rdx
  803695:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80369c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80369f:	48 89 ce             	mov    %rcx,%rsi
  8036a2:	89 c7                	mov    %eax,%edi
  8036a4:	48 b8 dd 2d 80 00 00 	movabs $0x802ddd,%rax
  8036ab:	00 00 00 
  8036ae:	ff d0                	callq  *%rax
  8036b0:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8036b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8036b7:	79 4a                	jns    803703 <copy+0x138>
  8036b9:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8036bc:	89 c6                	mov    %eax,%esi
  8036be:	48 bf 64 52 80 00 00 	movabs $0x805264,%rdi
  8036c5:	00 00 00 
  8036c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8036cd:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  8036d4:	00 00 00 
  8036d7:	ff d2                	callq  *%rdx
  8036d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036dc:	89 c7                	mov    %eax,%edi
  8036de:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  8036e5:	00 00 00 
  8036e8:	ff d0                	callq  *%rax
  8036ea:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8036ed:	89 c7                	mov    %eax,%edi
  8036ef:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  8036f6:	00 00 00 
  8036f9:	ff d0                	callq  *%rax
  8036fb:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8036fe:	e9 a1 00 00 00       	jmpq   8037a4 <copy+0x1d9>
  803703:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80370a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80370d:	ba 00 02 00 00       	mov    $0x200,%edx
  803712:	48 89 ce             	mov    %rcx,%rsi
  803715:	89 c7                	mov    %eax,%edi
  803717:	48 b8 93 2c 80 00 00 	movabs $0x802c93,%rax
  80371e:	00 00 00 
  803721:	ff d0                	callq  *%rax
  803723:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803726:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80372a:	0f 8f 5f ff ff ff    	jg     80368f <copy+0xc4>
  803730:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803734:	79 47                	jns    80377d <copy+0x1b2>
  803736:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803739:	89 c6                	mov    %eax,%esi
  80373b:	48 bf 77 52 80 00 00 	movabs $0x805277,%rdi
  803742:	00 00 00 
  803745:	b8 00 00 00 00       	mov    $0x0,%eax
  80374a:	48 ba 64 06 80 00 00 	movabs $0x800664,%rdx
  803751:	00 00 00 
  803754:	ff d2                	callq  *%rdx
  803756:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803759:	89 c7                	mov    %eax,%edi
  80375b:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  803762:	00 00 00 
  803765:	ff d0                	callq  *%rax
  803767:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80376a:	89 c7                	mov    %eax,%edi
  80376c:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  803773:	00 00 00 
  803776:	ff d0                	callq  *%rax
  803778:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80377b:	eb 27                	jmp    8037a4 <copy+0x1d9>
  80377d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803780:	89 c7                	mov    %eax,%edi
  803782:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  803789:	00 00 00 
  80378c:	ff d0                	callq  *%rax
  80378e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803791:	89 c7                	mov    %eax,%edi
  803793:	48 b8 71 2a 80 00 00 	movabs $0x802a71,%rax
  80379a:	00 00 00 
  80379d:	ff d0                	callq  *%rax
  80379f:	b8 00 00 00 00       	mov    $0x0,%eax
  8037a4:	c9                   	leaveq 
  8037a5:	c3                   	retq   

00000000008037a6 <pageref>:
  8037a6:	55                   	push   %rbp
  8037a7:	48 89 e5             	mov    %rsp,%rbp
  8037aa:	48 83 ec 18          	sub    $0x18,%rsp
  8037ae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8037b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037b6:	48 c1 e8 15          	shr    $0x15,%rax
  8037ba:	48 89 c2             	mov    %rax,%rdx
  8037bd:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8037c4:	01 00 00 
  8037c7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8037cb:	83 e0 01             	and    $0x1,%eax
  8037ce:	48 85 c0             	test   %rax,%rax
  8037d1:	75 07                	jne    8037da <pageref+0x34>
  8037d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8037d8:	eb 53                	jmp    80382d <pageref+0x87>
  8037da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037de:	48 c1 e8 0c          	shr    $0xc,%rax
  8037e2:	48 89 c2             	mov    %rax,%rdx
  8037e5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8037ec:	01 00 00 
  8037ef:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8037f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8037f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037fb:	83 e0 01             	and    $0x1,%eax
  8037fe:	48 85 c0             	test   %rax,%rax
  803801:	75 07                	jne    80380a <pageref+0x64>
  803803:	b8 00 00 00 00       	mov    $0x0,%eax
  803808:	eb 23                	jmp    80382d <pageref+0x87>
  80380a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80380e:	48 c1 e8 0c          	shr    $0xc,%rax
  803812:	48 89 c2             	mov    %rax,%rdx
  803815:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  80381c:	00 00 00 
  80381f:	48 c1 e2 04          	shl    $0x4,%rdx
  803823:	48 01 d0             	add    %rdx,%rax
  803826:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  80382a:	0f b7 c0             	movzwl %ax,%eax
  80382d:	c9                   	leaveq 
  80382e:	c3                   	retq   

000000000080382f <fd2sockid>:
  80382f:	55                   	push   %rbp
  803830:	48 89 e5             	mov    %rsp,%rbp
  803833:	48 83 ec 20          	sub    $0x20,%rsp
  803837:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80383a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80383e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803841:	48 89 d6             	mov    %rdx,%rsi
  803844:	89 c7                	mov    %eax,%edi
  803846:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  80384d:	00 00 00 
  803850:	ff d0                	callq  *%rax
  803852:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803855:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803859:	79 05                	jns    803860 <fd2sockid+0x31>
  80385b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80385e:	eb 24                	jmp    803884 <fd2sockid+0x55>
  803860:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803864:	8b 10                	mov    (%rax),%edx
  803866:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  80386d:	00 00 00 
  803870:	8b 00                	mov    (%rax),%eax
  803872:	39 c2                	cmp    %eax,%edx
  803874:	74 07                	je     80387d <fd2sockid+0x4e>
  803876:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80387b:	eb 07                	jmp    803884 <fd2sockid+0x55>
  80387d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803881:	8b 40 0c             	mov    0xc(%rax),%eax
  803884:	c9                   	leaveq 
  803885:	c3                   	retq   

0000000000803886 <alloc_sockfd>:
  803886:	55                   	push   %rbp
  803887:	48 89 e5             	mov    %rsp,%rbp
  80388a:	48 83 ec 20          	sub    $0x20,%rsp
  80388e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803891:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803895:	48 89 c7             	mov    %rax,%rdi
  803898:	48 b8 c9 27 80 00 00 	movabs $0x8027c9,%rax
  80389f:	00 00 00 
  8038a2:	ff d0                	callq  *%rax
  8038a4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038ab:	78 26                	js     8038d3 <alloc_sockfd+0x4d>
  8038ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038b1:	ba 07 04 00 00       	mov    $0x407,%edx
  8038b6:	48 89 c6             	mov    %rax,%rsi
  8038b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8038be:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  8038c5:	00 00 00 
  8038c8:	ff d0                	callq  *%rax
  8038ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038d1:	79 16                	jns    8038e9 <alloc_sockfd+0x63>
  8038d3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8038d6:	89 c7                	mov    %eax,%edi
  8038d8:	48 b8 93 3d 80 00 00 	movabs $0x803d93,%rax
  8038df:	00 00 00 
  8038e2:	ff d0                	callq  *%rax
  8038e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038e7:	eb 3a                	jmp    803923 <alloc_sockfd+0x9d>
  8038e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038ed:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8038f4:	00 00 00 
  8038f7:	8b 12                	mov    (%rdx),%edx
  8038f9:	89 10                	mov    %edx,(%rax)
  8038fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038ff:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803906:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80390a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80390d:	89 50 0c             	mov    %edx,0xc(%rax)
  803910:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803914:	48 89 c7             	mov    %rax,%rdi
  803917:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  80391e:	00 00 00 
  803921:	ff d0                	callq  *%rax
  803923:	c9                   	leaveq 
  803924:	c3                   	retq   

0000000000803925 <accept>:
  803925:	55                   	push   %rbp
  803926:	48 89 e5             	mov    %rsp,%rbp
  803929:	48 83 ec 30          	sub    $0x30,%rsp
  80392d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803930:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803934:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803938:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80393b:	89 c7                	mov    %eax,%edi
  80393d:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803944:	00 00 00 
  803947:	ff d0                	callq  *%rax
  803949:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80394c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803950:	79 05                	jns    803957 <accept+0x32>
  803952:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803955:	eb 3b                	jmp    803992 <accept+0x6d>
  803957:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80395b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80395f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803962:	48 89 ce             	mov    %rcx,%rsi
  803965:	89 c7                	mov    %eax,%edi
  803967:	48 b8 70 3c 80 00 00 	movabs $0x803c70,%rax
  80396e:	00 00 00 
  803971:	ff d0                	callq  *%rax
  803973:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803976:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80397a:	79 05                	jns    803981 <accept+0x5c>
  80397c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80397f:	eb 11                	jmp    803992 <accept+0x6d>
  803981:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803984:	89 c7                	mov    %eax,%edi
  803986:	48 b8 86 38 80 00 00 	movabs $0x803886,%rax
  80398d:	00 00 00 
  803990:	ff d0                	callq  *%rax
  803992:	c9                   	leaveq 
  803993:	c3                   	retq   

0000000000803994 <bind>:
  803994:	55                   	push   %rbp
  803995:	48 89 e5             	mov    %rsp,%rbp
  803998:	48 83 ec 20          	sub    $0x20,%rsp
  80399c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80399f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8039a3:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8039a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039a9:	89 c7                	mov    %eax,%edi
  8039ab:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  8039b2:	00 00 00 
  8039b5:	ff d0                	callq  *%rax
  8039b7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039be:	79 05                	jns    8039c5 <bind+0x31>
  8039c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039c3:	eb 1b                	jmp    8039e0 <bind+0x4c>
  8039c5:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8039c8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8039cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039cf:	48 89 ce             	mov    %rcx,%rsi
  8039d2:	89 c7                	mov    %eax,%edi
  8039d4:	48 b8 ef 3c 80 00 00 	movabs $0x803cef,%rax
  8039db:	00 00 00 
  8039de:	ff d0                	callq  *%rax
  8039e0:	c9                   	leaveq 
  8039e1:	c3                   	retq   

00000000008039e2 <shutdown>:
  8039e2:	55                   	push   %rbp
  8039e3:	48 89 e5             	mov    %rsp,%rbp
  8039e6:	48 83 ec 20          	sub    $0x20,%rsp
  8039ea:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039ed:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8039f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039f3:	89 c7                	mov    %eax,%edi
  8039f5:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  8039fc:	00 00 00 
  8039ff:	ff d0                	callq  *%rax
  803a01:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a04:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a08:	79 05                	jns    803a0f <shutdown+0x2d>
  803a0a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a0d:	eb 16                	jmp    803a25 <shutdown+0x43>
  803a0f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803a12:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a15:	89 d6                	mov    %edx,%esi
  803a17:	89 c7                	mov    %eax,%edi
  803a19:	48 b8 53 3d 80 00 00 	movabs $0x803d53,%rax
  803a20:	00 00 00 
  803a23:	ff d0                	callq  *%rax
  803a25:	c9                   	leaveq 
  803a26:	c3                   	retq   

0000000000803a27 <devsock_close>:
  803a27:	55                   	push   %rbp
  803a28:	48 89 e5             	mov    %rsp,%rbp
  803a2b:	48 83 ec 10          	sub    $0x10,%rsp
  803a2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a37:	48 89 c7             	mov    %rax,%rdi
  803a3a:	48 b8 a6 37 80 00 00 	movabs $0x8037a6,%rax
  803a41:	00 00 00 
  803a44:	ff d0                	callq  *%rax
  803a46:	83 f8 01             	cmp    $0x1,%eax
  803a49:	75 17                	jne    803a62 <devsock_close+0x3b>
  803a4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a4f:	8b 40 0c             	mov    0xc(%rax),%eax
  803a52:	89 c7                	mov    %eax,%edi
  803a54:	48 b8 93 3d 80 00 00 	movabs $0x803d93,%rax
  803a5b:	00 00 00 
  803a5e:	ff d0                	callq  *%rax
  803a60:	eb 05                	jmp    803a67 <devsock_close+0x40>
  803a62:	b8 00 00 00 00       	mov    $0x0,%eax
  803a67:	c9                   	leaveq 
  803a68:	c3                   	retq   

0000000000803a69 <connect>:
  803a69:	55                   	push   %rbp
  803a6a:	48 89 e5             	mov    %rsp,%rbp
  803a6d:	48 83 ec 20          	sub    $0x20,%rsp
  803a71:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a74:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a78:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803a7b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a7e:	89 c7                	mov    %eax,%edi
  803a80:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803a87:	00 00 00 
  803a8a:	ff d0                	callq  *%rax
  803a8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a93:	79 05                	jns    803a9a <connect+0x31>
  803a95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a98:	eb 1b                	jmp    803ab5 <connect+0x4c>
  803a9a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803a9d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803aa1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aa4:	48 89 ce             	mov    %rcx,%rsi
  803aa7:	89 c7                	mov    %eax,%edi
  803aa9:	48 b8 c0 3d 80 00 00 	movabs $0x803dc0,%rax
  803ab0:	00 00 00 
  803ab3:	ff d0                	callq  *%rax
  803ab5:	c9                   	leaveq 
  803ab6:	c3                   	retq   

0000000000803ab7 <listen>:
  803ab7:	55                   	push   %rbp
  803ab8:	48 89 e5             	mov    %rsp,%rbp
  803abb:	48 83 ec 20          	sub    $0x20,%rsp
  803abf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ac2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803ac5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ac8:	89 c7                	mov    %eax,%edi
  803aca:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803ad1:	00 00 00 
  803ad4:	ff d0                	callq  *%rax
  803ad6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ad9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803add:	79 05                	jns    803ae4 <listen+0x2d>
  803adf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ae2:	eb 16                	jmp    803afa <listen+0x43>
  803ae4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803ae7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aea:	89 d6                	mov    %edx,%esi
  803aec:	89 c7                	mov    %eax,%edi
  803aee:	48 b8 24 3e 80 00 00 	movabs $0x803e24,%rax
  803af5:	00 00 00 
  803af8:	ff d0                	callq  *%rax
  803afa:	c9                   	leaveq 
  803afb:	c3                   	retq   

0000000000803afc <devsock_read>:
  803afc:	55                   	push   %rbp
  803afd:	48 89 e5             	mov    %rsp,%rbp
  803b00:	48 83 ec 20          	sub    $0x20,%rsp
  803b04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b08:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b0c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803b10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803b14:	89 c2                	mov    %eax,%edx
  803b16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b1a:	8b 40 0c             	mov    0xc(%rax),%eax
  803b1d:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803b21:	b9 00 00 00 00       	mov    $0x0,%ecx
  803b26:	89 c7                	mov    %eax,%edi
  803b28:	48 b8 64 3e 80 00 00 	movabs $0x803e64,%rax
  803b2f:	00 00 00 
  803b32:	ff d0                	callq  *%rax
  803b34:	c9                   	leaveq 
  803b35:	c3                   	retq   

0000000000803b36 <devsock_write>:
  803b36:	55                   	push   %rbp
  803b37:	48 89 e5             	mov    %rsp,%rbp
  803b3a:	48 83 ec 20          	sub    $0x20,%rsp
  803b3e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b42:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b46:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803b4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803b4e:	89 c2                	mov    %eax,%edx
  803b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b54:	8b 40 0c             	mov    0xc(%rax),%eax
  803b57:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803b5b:	b9 00 00 00 00       	mov    $0x0,%ecx
  803b60:	89 c7                	mov    %eax,%edi
  803b62:	48 b8 30 3f 80 00 00 	movabs $0x803f30,%rax
  803b69:	00 00 00 
  803b6c:	ff d0                	callq  *%rax
  803b6e:	c9                   	leaveq 
  803b6f:	c3                   	retq   

0000000000803b70 <devsock_stat>:
  803b70:	55                   	push   %rbp
  803b71:	48 89 e5             	mov    %rsp,%rbp
  803b74:	48 83 ec 10          	sub    $0x10,%rsp
  803b78:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b7c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b84:	48 be 92 52 80 00 00 	movabs $0x805292,%rsi
  803b8b:	00 00 00 
  803b8e:	48 89 c7             	mov    %rax,%rdi
  803b91:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  803b98:	00 00 00 
  803b9b:	ff d0                	callq  *%rax
  803b9d:	b8 00 00 00 00       	mov    $0x0,%eax
  803ba2:	c9                   	leaveq 
  803ba3:	c3                   	retq   

0000000000803ba4 <socket>:
  803ba4:	55                   	push   %rbp
  803ba5:	48 89 e5             	mov    %rsp,%rbp
  803ba8:	48 83 ec 20          	sub    $0x20,%rsp
  803bac:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803baf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803bb2:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803bb5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803bb8:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803bbb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803bbe:	89 ce                	mov    %ecx,%esi
  803bc0:	89 c7                	mov    %eax,%edi
  803bc2:	48 b8 e8 3f 80 00 00 	movabs $0x803fe8,%rax
  803bc9:	00 00 00 
  803bcc:	ff d0                	callq  *%rax
  803bce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bd5:	79 05                	jns    803bdc <socket+0x38>
  803bd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bda:	eb 11                	jmp    803bed <socket+0x49>
  803bdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bdf:	89 c7                	mov    %eax,%edi
  803be1:	48 b8 86 38 80 00 00 	movabs $0x803886,%rax
  803be8:	00 00 00 
  803beb:	ff d0                	callq  *%rax
  803bed:	c9                   	leaveq 
  803bee:	c3                   	retq   

0000000000803bef <nsipc>:
  803bef:	55                   	push   %rbp
  803bf0:	48 89 e5             	mov    %rsp,%rbp
  803bf3:	48 83 ec 10          	sub    $0x10,%rsp
  803bf7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803bfa:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803c01:	00 00 00 
  803c04:	8b 00                	mov    (%rax),%eax
  803c06:	85 c0                	test   %eax,%eax
  803c08:	75 1d                	jne    803c27 <nsipc+0x38>
  803c0a:	bf 02 00 00 00       	mov    $0x2,%edi
  803c0f:	48 b8 09 27 80 00 00 	movabs $0x802709,%rax
  803c16:	00 00 00 
  803c19:	ff d0                	callq  *%rax
  803c1b:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803c22:	00 00 00 
  803c25:	89 02                	mov    %eax,(%rdx)
  803c27:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803c2e:	00 00 00 
  803c31:	8b 00                	mov    (%rax),%eax
  803c33:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803c36:	b9 07 00 00 00       	mov    $0x7,%ecx
  803c3b:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803c42:	00 00 00 
  803c45:	89 c7                	mov    %eax,%edi
  803c47:	48 b8 fe 25 80 00 00 	movabs $0x8025fe,%rax
  803c4e:	00 00 00 
  803c51:	ff d0                	callq  *%rax
  803c53:	ba 00 00 00 00       	mov    $0x0,%edx
  803c58:	be 00 00 00 00       	mov    $0x0,%esi
  803c5d:	bf 00 00 00 00       	mov    $0x0,%edi
  803c62:	48 b8 3d 25 80 00 00 	movabs $0x80253d,%rax
  803c69:	00 00 00 
  803c6c:	ff d0                	callq  *%rax
  803c6e:	c9                   	leaveq 
  803c6f:	c3                   	retq   

0000000000803c70 <nsipc_accept>:
  803c70:	55                   	push   %rbp
  803c71:	48 89 e5             	mov    %rsp,%rbp
  803c74:	48 83 ec 30          	sub    $0x30,%rsp
  803c78:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c7b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c7f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803c83:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c8a:	00 00 00 
  803c8d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803c90:	89 10                	mov    %edx,(%rax)
  803c92:	bf 01 00 00 00       	mov    $0x1,%edi
  803c97:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803c9e:	00 00 00 
  803ca1:	ff d0                	callq  *%rax
  803ca3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ca6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803caa:	78 3e                	js     803cea <nsipc_accept+0x7a>
  803cac:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cb3:	00 00 00 
  803cb6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cbe:	8b 40 10             	mov    0x10(%rax),%eax
  803cc1:	89 c2                	mov    %eax,%edx
  803cc3:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803cc7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ccb:	48 89 ce             	mov    %rcx,%rsi
  803cce:	48 89 c7             	mov    %rax,%rdi
  803cd1:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803cd8:	00 00 00 
  803cdb:	ff d0                	callq  *%rax
  803cdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ce1:	8b 50 10             	mov    0x10(%rax),%edx
  803ce4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ce8:	89 10                	mov    %edx,(%rax)
  803cea:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ced:	c9                   	leaveq 
  803cee:	c3                   	retq   

0000000000803cef <nsipc_bind>:
  803cef:	55                   	push   %rbp
  803cf0:	48 89 e5             	mov    %rsp,%rbp
  803cf3:	48 83 ec 10          	sub    $0x10,%rsp
  803cf7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cfa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cfe:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803d01:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d08:	00 00 00 
  803d0b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d0e:	89 10                	mov    %edx,(%rax)
  803d10:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d17:	48 89 c6             	mov    %rax,%rsi
  803d1a:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803d21:	00 00 00 
  803d24:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803d2b:	00 00 00 
  803d2e:	ff d0                	callq  *%rax
  803d30:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d37:	00 00 00 
  803d3a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d3d:	89 50 14             	mov    %edx,0x14(%rax)
  803d40:	bf 02 00 00 00       	mov    $0x2,%edi
  803d45:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803d4c:	00 00 00 
  803d4f:	ff d0                	callq  *%rax
  803d51:	c9                   	leaveq 
  803d52:	c3                   	retq   

0000000000803d53 <nsipc_shutdown>:
  803d53:	55                   	push   %rbp
  803d54:	48 89 e5             	mov    %rsp,%rbp
  803d57:	48 83 ec 10          	sub    $0x10,%rsp
  803d5b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d5e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803d61:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d68:	00 00 00 
  803d6b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d6e:	89 10                	mov    %edx,(%rax)
  803d70:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d77:	00 00 00 
  803d7a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d7d:	89 50 04             	mov    %edx,0x4(%rax)
  803d80:	bf 03 00 00 00       	mov    $0x3,%edi
  803d85:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803d8c:	00 00 00 
  803d8f:	ff d0                	callq  *%rax
  803d91:	c9                   	leaveq 
  803d92:	c3                   	retq   

0000000000803d93 <nsipc_close>:
  803d93:	55                   	push   %rbp
  803d94:	48 89 e5             	mov    %rsp,%rbp
  803d97:	48 83 ec 10          	sub    $0x10,%rsp
  803d9b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d9e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803da5:	00 00 00 
  803da8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803dab:	89 10                	mov    %edx,(%rax)
  803dad:	bf 04 00 00 00       	mov    $0x4,%edi
  803db2:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803db9:	00 00 00 
  803dbc:	ff d0                	callq  *%rax
  803dbe:	c9                   	leaveq 
  803dbf:	c3                   	retq   

0000000000803dc0 <nsipc_connect>:
  803dc0:	55                   	push   %rbp
  803dc1:	48 89 e5             	mov    %rsp,%rbp
  803dc4:	48 83 ec 10          	sub    $0x10,%rsp
  803dc8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803dcb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803dcf:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803dd2:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dd9:	00 00 00 
  803ddc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ddf:	89 10                	mov    %edx,(%rax)
  803de1:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803de4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803de8:	48 89 c6             	mov    %rax,%rsi
  803deb:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803df2:	00 00 00 
  803df5:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803dfc:	00 00 00 
  803dff:	ff d0                	callq  *%rax
  803e01:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e08:	00 00 00 
  803e0b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e0e:	89 50 14             	mov    %edx,0x14(%rax)
  803e11:	bf 05 00 00 00       	mov    $0x5,%edi
  803e16:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803e1d:	00 00 00 
  803e20:	ff d0                	callq  *%rax
  803e22:	c9                   	leaveq 
  803e23:	c3                   	retq   

0000000000803e24 <nsipc_listen>:
  803e24:	55                   	push   %rbp
  803e25:	48 89 e5             	mov    %rsp,%rbp
  803e28:	48 83 ec 10          	sub    $0x10,%rsp
  803e2c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e2f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803e32:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e39:	00 00 00 
  803e3c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803e3f:	89 10                	mov    %edx,(%rax)
  803e41:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e48:	00 00 00 
  803e4b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e4e:	89 50 04             	mov    %edx,0x4(%rax)
  803e51:	bf 06 00 00 00       	mov    $0x6,%edi
  803e56:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803e5d:	00 00 00 
  803e60:	ff d0                	callq  *%rax
  803e62:	c9                   	leaveq 
  803e63:	c3                   	retq   

0000000000803e64 <nsipc_recv>:
  803e64:	55                   	push   %rbp
  803e65:	48 89 e5             	mov    %rsp,%rbp
  803e68:	48 83 ec 30          	sub    $0x30,%rsp
  803e6c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e6f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803e73:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803e76:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803e79:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e80:	00 00 00 
  803e83:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803e86:	89 10                	mov    %edx,(%rax)
  803e88:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e8f:	00 00 00 
  803e92:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803e95:	89 50 04             	mov    %edx,0x4(%rax)
  803e98:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e9f:	00 00 00 
  803ea2:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803ea5:	89 50 08             	mov    %edx,0x8(%rax)
  803ea8:	bf 07 00 00 00       	mov    $0x7,%edi
  803ead:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803eb4:	00 00 00 
  803eb7:	ff d0                	callq  *%rax
  803eb9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ebc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ec0:	78 69                	js     803f2b <nsipc_recv+0xc7>
  803ec2:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803ec9:	7f 08                	jg     803ed3 <nsipc_recv+0x6f>
  803ecb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ece:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803ed1:	7e 35                	jle    803f08 <nsipc_recv+0xa4>
  803ed3:	48 b9 99 52 80 00 00 	movabs $0x805299,%rcx
  803eda:	00 00 00 
  803edd:	48 ba ae 52 80 00 00 	movabs $0x8052ae,%rdx
  803ee4:	00 00 00 
  803ee7:	be 62 00 00 00       	mov    $0x62,%esi
  803eec:	48 bf c3 52 80 00 00 	movabs $0x8052c3,%rdi
  803ef3:	00 00 00 
  803ef6:	b8 00 00 00 00       	mov    $0x0,%eax
  803efb:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  803f02:	00 00 00 
  803f05:	41 ff d0             	callq  *%r8
  803f08:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f0b:	48 63 d0             	movslq %eax,%rdx
  803f0e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f12:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803f19:	00 00 00 
  803f1c:	48 89 c7             	mov    %rax,%rdi
  803f1f:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803f26:	00 00 00 
  803f29:	ff d0                	callq  *%rax
  803f2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f2e:	c9                   	leaveq 
  803f2f:	c3                   	retq   

0000000000803f30 <nsipc_send>:
  803f30:	55                   	push   %rbp
  803f31:	48 89 e5             	mov    %rsp,%rbp
  803f34:	48 83 ec 20          	sub    $0x20,%rsp
  803f38:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f3b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803f3f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803f42:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803f45:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f4c:	00 00 00 
  803f4f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f52:	89 10                	mov    %edx,(%rax)
  803f54:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803f5b:	7e 35                	jle    803f92 <nsipc_send+0x62>
  803f5d:	48 b9 d2 52 80 00 00 	movabs $0x8052d2,%rcx
  803f64:	00 00 00 
  803f67:	48 ba ae 52 80 00 00 	movabs $0x8052ae,%rdx
  803f6e:	00 00 00 
  803f71:	be 6d 00 00 00       	mov    $0x6d,%esi
  803f76:	48 bf c3 52 80 00 00 	movabs $0x8052c3,%rdi
  803f7d:	00 00 00 
  803f80:	b8 00 00 00 00       	mov    $0x0,%eax
  803f85:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  803f8c:	00 00 00 
  803f8f:	41 ff d0             	callq  *%r8
  803f92:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f95:	48 63 d0             	movslq %eax,%rdx
  803f98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f9c:	48 89 c6             	mov    %rax,%rsi
  803f9f:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803fa6:	00 00 00 
  803fa9:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  803fb0:	00 00 00 
  803fb3:	ff d0                	callq  *%rax
  803fb5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fbc:	00 00 00 
  803fbf:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803fc2:	89 50 04             	mov    %edx,0x4(%rax)
  803fc5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fcc:	00 00 00 
  803fcf:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803fd2:	89 50 08             	mov    %edx,0x8(%rax)
  803fd5:	bf 08 00 00 00       	mov    $0x8,%edi
  803fda:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  803fe1:	00 00 00 
  803fe4:	ff d0                	callq  *%rax
  803fe6:	c9                   	leaveq 
  803fe7:	c3                   	retq   

0000000000803fe8 <nsipc_socket>:
  803fe8:	55                   	push   %rbp
  803fe9:	48 89 e5             	mov    %rsp,%rbp
  803fec:	48 83 ec 10          	sub    $0x10,%rsp
  803ff0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ff3:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803ff6:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803ff9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804000:	00 00 00 
  804003:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804006:	89 10                	mov    %edx,(%rax)
  804008:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80400f:	00 00 00 
  804012:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804015:	89 50 04             	mov    %edx,0x4(%rax)
  804018:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80401f:	00 00 00 
  804022:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804025:	89 50 08             	mov    %edx,0x8(%rax)
  804028:	bf 09 00 00 00       	mov    $0x9,%edi
  80402d:	48 b8 ef 3b 80 00 00 	movabs $0x803bef,%rax
  804034:	00 00 00 
  804037:	ff d0                	callq  *%rax
  804039:	c9                   	leaveq 
  80403a:	c3                   	retq   

000000000080403b <pipe>:
  80403b:	55                   	push   %rbp
  80403c:	48 89 e5             	mov    %rsp,%rbp
  80403f:	53                   	push   %rbx
  804040:	48 83 ec 38          	sub    $0x38,%rsp
  804044:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  804048:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  80404c:	48 89 c7             	mov    %rax,%rdi
  80404f:	48 b8 c9 27 80 00 00 	movabs $0x8027c9,%rax
  804056:	00 00 00 
  804059:	ff d0                	callq  *%rax
  80405b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80405e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804062:	0f 88 bf 01 00 00    	js     804227 <pipe+0x1ec>
  804068:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80406c:	ba 07 04 00 00       	mov    $0x407,%edx
  804071:	48 89 c6             	mov    %rax,%rsi
  804074:	bf 00 00 00 00       	mov    $0x0,%edi
  804079:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  804080:	00 00 00 
  804083:	ff d0                	callq  *%rax
  804085:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804088:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80408c:	0f 88 95 01 00 00    	js     804227 <pipe+0x1ec>
  804092:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804096:	48 89 c7             	mov    %rax,%rdi
  804099:	48 b8 c9 27 80 00 00 	movabs $0x8027c9,%rax
  8040a0:	00 00 00 
  8040a3:	ff d0                	callq  *%rax
  8040a5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8040a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8040ac:	0f 88 5d 01 00 00    	js     80420f <pipe+0x1d4>
  8040b2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040b6:	ba 07 04 00 00       	mov    $0x407,%edx
  8040bb:	48 89 c6             	mov    %rax,%rsi
  8040be:	bf 00 00 00 00       	mov    $0x0,%edi
  8040c3:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  8040ca:	00 00 00 
  8040cd:	ff d0                	callq  *%rax
  8040cf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8040d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8040d6:	0f 88 33 01 00 00    	js     80420f <pipe+0x1d4>
  8040dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040e0:	48 89 c7             	mov    %rax,%rdi
  8040e3:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  8040ea:	00 00 00 
  8040ed:	ff d0                	callq  *%rax
  8040ef:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8040f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8040f7:	ba 07 04 00 00       	mov    $0x407,%edx
  8040fc:	48 89 c6             	mov    %rax,%rsi
  8040ff:	bf 00 00 00 00       	mov    $0x0,%edi
  804104:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  80410b:	00 00 00 
  80410e:	ff d0                	callq  *%rax
  804110:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804113:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804117:	79 05                	jns    80411e <pipe+0xe3>
  804119:	e9 d9 00 00 00       	jmpq   8041f7 <pipe+0x1bc>
  80411e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804122:	48 89 c7             	mov    %rax,%rdi
  804125:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  80412c:	00 00 00 
  80412f:	ff d0                	callq  *%rax
  804131:	48 89 c2             	mov    %rax,%rdx
  804134:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804138:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  80413e:	48 89 d1             	mov    %rdx,%rcx
  804141:	ba 00 00 00 00       	mov    $0x0,%edx
  804146:	48 89 c6             	mov    %rax,%rsi
  804149:	bf 00 00 00 00       	mov    $0x0,%edi
  80414e:	48 b8 98 1b 80 00 00 	movabs $0x801b98,%rax
  804155:	00 00 00 
  804158:	ff d0                	callq  *%rax
  80415a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80415d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804161:	79 1b                	jns    80417e <pipe+0x143>
  804163:	90                   	nop
  804164:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804168:	48 89 c6             	mov    %rax,%rsi
  80416b:	bf 00 00 00 00       	mov    $0x0,%edi
  804170:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  804177:	00 00 00 
  80417a:	ff d0                	callq  *%rax
  80417c:	eb 79                	jmp    8041f7 <pipe+0x1bc>
  80417e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804182:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804189:	00 00 00 
  80418c:	8b 12                	mov    (%rdx),%edx
  80418e:	89 10                	mov    %edx,(%rax)
  804190:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804194:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80419b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80419f:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  8041a6:	00 00 00 
  8041a9:	8b 12                	mov    (%rdx),%edx
  8041ab:	89 10                	mov    %edx,(%rax)
  8041ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041b1:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8041b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8041bc:	48 89 c7             	mov    %rax,%rdi
  8041bf:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  8041c6:	00 00 00 
  8041c9:	ff d0                	callq  *%rax
  8041cb:	89 c2                	mov    %eax,%edx
  8041cd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8041d1:	89 10                	mov    %edx,(%rax)
  8041d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8041d7:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8041db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041df:	48 89 c7             	mov    %rax,%rdi
  8041e2:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  8041e9:	00 00 00 
  8041ec:	ff d0                	callq  *%rax
  8041ee:	89 03                	mov    %eax,(%rbx)
  8041f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8041f5:	eb 33                	jmp    80422a <pipe+0x1ef>
  8041f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041fb:	48 89 c6             	mov    %rax,%rsi
  8041fe:	bf 00 00 00 00       	mov    $0x0,%edi
  804203:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  80420a:	00 00 00 
  80420d:	ff d0                	callq  *%rax
  80420f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804213:	48 89 c6             	mov    %rax,%rsi
  804216:	bf 00 00 00 00       	mov    $0x0,%edi
  80421b:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  804222:	00 00 00 
  804225:	ff d0                	callq  *%rax
  804227:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80422a:	48 83 c4 38          	add    $0x38,%rsp
  80422e:	5b                   	pop    %rbx
  80422f:	5d                   	pop    %rbp
  804230:	c3                   	retq   

0000000000804231 <_pipeisclosed>:
  804231:	55                   	push   %rbp
  804232:	48 89 e5             	mov    %rsp,%rbp
  804235:	53                   	push   %rbx
  804236:	48 83 ec 28          	sub    $0x28,%rsp
  80423a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80423e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804242:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804249:	00 00 00 
  80424c:	48 8b 00             	mov    (%rax),%rax
  80424f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804255:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804258:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80425c:	48 89 c7             	mov    %rax,%rdi
  80425f:	48 b8 a6 37 80 00 00 	movabs $0x8037a6,%rax
  804266:	00 00 00 
  804269:	ff d0                	callq  *%rax
  80426b:	89 c3                	mov    %eax,%ebx
  80426d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804271:	48 89 c7             	mov    %rax,%rdi
  804274:	48 b8 a6 37 80 00 00 	movabs $0x8037a6,%rax
  80427b:	00 00 00 
  80427e:	ff d0                	callq  *%rax
  804280:	39 c3                	cmp    %eax,%ebx
  804282:	0f 94 c0             	sete   %al
  804285:	0f b6 c0             	movzbl %al,%eax
  804288:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80428b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804292:	00 00 00 
  804295:	48 8b 00             	mov    (%rax),%rax
  804298:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80429e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8042a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042a4:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8042a7:	75 05                	jne    8042ae <_pipeisclosed+0x7d>
  8042a9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8042ac:	eb 4f                	jmp    8042fd <_pipeisclosed+0xcc>
  8042ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042b1:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8042b4:	74 42                	je     8042f8 <_pipeisclosed+0xc7>
  8042b6:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8042ba:	75 3c                	jne    8042f8 <_pipeisclosed+0xc7>
  8042bc:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8042c3:	00 00 00 
  8042c6:	48 8b 00             	mov    (%rax),%rax
  8042c9:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  8042cf:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8042d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042d5:	89 c6                	mov    %eax,%esi
  8042d7:	48 bf e3 52 80 00 00 	movabs $0x8052e3,%rdi
  8042de:	00 00 00 
  8042e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8042e6:	49 b8 64 06 80 00 00 	movabs $0x800664,%r8
  8042ed:	00 00 00 
  8042f0:	41 ff d0             	callq  *%r8
  8042f3:	e9 4a ff ff ff       	jmpq   804242 <_pipeisclosed+0x11>
  8042f8:	e9 45 ff ff ff       	jmpq   804242 <_pipeisclosed+0x11>
  8042fd:	48 83 c4 28          	add    $0x28,%rsp
  804301:	5b                   	pop    %rbx
  804302:	5d                   	pop    %rbp
  804303:	c3                   	retq   

0000000000804304 <pipeisclosed>:
  804304:	55                   	push   %rbp
  804305:	48 89 e5             	mov    %rsp,%rbp
  804308:	48 83 ec 30          	sub    $0x30,%rsp
  80430c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80430f:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  804313:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804316:	48 89 d6             	mov    %rdx,%rsi
  804319:	89 c7                	mov    %eax,%edi
  80431b:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  804322:	00 00 00 
  804325:	ff d0                	callq  *%rax
  804327:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80432a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80432e:	79 05                	jns    804335 <pipeisclosed+0x31>
  804330:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804333:	eb 31                	jmp    804366 <pipeisclosed+0x62>
  804335:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804339:	48 89 c7             	mov    %rax,%rdi
  80433c:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  804343:	00 00 00 
  804346:	ff d0                	callq  *%rax
  804348:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80434c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804350:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804354:	48 89 d6             	mov    %rdx,%rsi
  804357:	48 89 c7             	mov    %rax,%rdi
  80435a:	48 b8 31 42 80 00 00 	movabs $0x804231,%rax
  804361:	00 00 00 
  804364:	ff d0                	callq  *%rax
  804366:	c9                   	leaveq 
  804367:	c3                   	retq   

0000000000804368 <devpipe_read>:
  804368:	55                   	push   %rbp
  804369:	48 89 e5             	mov    %rsp,%rbp
  80436c:	48 83 ec 40          	sub    $0x40,%rsp
  804370:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804374:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804378:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80437c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804380:	48 89 c7             	mov    %rax,%rdi
  804383:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  80438a:	00 00 00 
  80438d:	ff d0                	callq  *%rax
  80438f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804393:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804397:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80439b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8043a2:	00 
  8043a3:	e9 92 00 00 00       	jmpq   80443a <devpipe_read+0xd2>
  8043a8:	eb 41                	jmp    8043eb <devpipe_read+0x83>
  8043aa:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  8043af:	74 09                	je     8043ba <devpipe_read+0x52>
  8043b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043b5:	e9 92 00 00 00       	jmpq   80444c <devpipe_read+0xe4>
  8043ba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8043be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043c2:	48 89 d6             	mov    %rdx,%rsi
  8043c5:	48 89 c7             	mov    %rax,%rdi
  8043c8:	48 b8 31 42 80 00 00 	movabs $0x804231,%rax
  8043cf:	00 00 00 
  8043d2:	ff d0                	callq  *%rax
  8043d4:	85 c0                	test   %eax,%eax
  8043d6:	74 07                	je     8043df <devpipe_read+0x77>
  8043d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8043dd:	eb 6d                	jmp    80444c <devpipe_read+0xe4>
  8043df:	48 b8 0a 1b 80 00 00 	movabs $0x801b0a,%rax
  8043e6:	00 00 00 
  8043e9:	ff d0                	callq  *%rax
  8043eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043ef:	8b 10                	mov    (%rax),%edx
  8043f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043f5:	8b 40 04             	mov    0x4(%rax),%eax
  8043f8:	39 c2                	cmp    %eax,%edx
  8043fa:	74 ae                	je     8043aa <devpipe_read+0x42>
  8043fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804400:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804404:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  804408:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80440c:	8b 00                	mov    (%rax),%eax
  80440e:	99                   	cltd   
  80440f:	c1 ea 1b             	shr    $0x1b,%edx
  804412:	01 d0                	add    %edx,%eax
  804414:	83 e0 1f             	and    $0x1f,%eax
  804417:	29 d0                	sub    %edx,%eax
  804419:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80441d:	48 98                	cltq   
  80441f:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  804424:	88 01                	mov    %al,(%rcx)
  804426:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80442a:	8b 00                	mov    (%rax),%eax
  80442c:	8d 50 01             	lea    0x1(%rax),%edx
  80442f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804433:	89 10                	mov    %edx,(%rax)
  804435:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80443a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80443e:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804442:	0f 82 60 ff ff ff    	jb     8043a8 <devpipe_read+0x40>
  804448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80444c:	c9                   	leaveq 
  80444d:	c3                   	retq   

000000000080444e <devpipe_write>:
  80444e:	55                   	push   %rbp
  80444f:	48 89 e5             	mov    %rsp,%rbp
  804452:	48 83 ec 40          	sub    $0x40,%rsp
  804456:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80445a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80445e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804462:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804466:	48 89 c7             	mov    %rax,%rdi
  804469:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  804470:	00 00 00 
  804473:	ff d0                	callq  *%rax
  804475:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804479:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80447d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804481:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804488:	00 
  804489:	e9 8e 00 00 00       	jmpq   80451c <devpipe_write+0xce>
  80448e:	eb 31                	jmp    8044c1 <devpipe_write+0x73>
  804490:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804494:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804498:	48 89 d6             	mov    %rdx,%rsi
  80449b:	48 89 c7             	mov    %rax,%rdi
  80449e:	48 b8 31 42 80 00 00 	movabs $0x804231,%rax
  8044a5:	00 00 00 
  8044a8:	ff d0                	callq  *%rax
  8044aa:	85 c0                	test   %eax,%eax
  8044ac:	74 07                	je     8044b5 <devpipe_write+0x67>
  8044ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8044b3:	eb 79                	jmp    80452e <devpipe_write+0xe0>
  8044b5:	48 b8 0a 1b 80 00 00 	movabs $0x801b0a,%rax
  8044bc:	00 00 00 
  8044bf:	ff d0                	callq  *%rax
  8044c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044c5:	8b 40 04             	mov    0x4(%rax),%eax
  8044c8:	48 63 d0             	movslq %eax,%rdx
  8044cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044cf:	8b 00                	mov    (%rax),%eax
  8044d1:	48 98                	cltq   
  8044d3:	48 83 c0 20          	add    $0x20,%rax
  8044d7:	48 39 c2             	cmp    %rax,%rdx
  8044da:	73 b4                	jae    804490 <devpipe_write+0x42>
  8044dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044e0:	8b 40 04             	mov    0x4(%rax),%eax
  8044e3:	99                   	cltd   
  8044e4:	c1 ea 1b             	shr    $0x1b,%edx
  8044e7:	01 d0                	add    %edx,%eax
  8044e9:	83 e0 1f             	and    $0x1f,%eax
  8044ec:	29 d0                	sub    %edx,%eax
  8044ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8044f2:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8044f6:	48 01 ca             	add    %rcx,%rdx
  8044f9:	0f b6 0a             	movzbl (%rdx),%ecx
  8044fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804500:	48 98                	cltq   
  804502:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  804506:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80450a:	8b 40 04             	mov    0x4(%rax),%eax
  80450d:	8d 50 01             	lea    0x1(%rax),%edx
  804510:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804514:	89 50 04             	mov    %edx,0x4(%rax)
  804517:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80451c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804520:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804524:	0f 82 64 ff ff ff    	jb     80448e <devpipe_write+0x40>
  80452a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80452e:	c9                   	leaveq 
  80452f:	c3                   	retq   

0000000000804530 <devpipe_stat>:
  804530:	55                   	push   %rbp
  804531:	48 89 e5             	mov    %rsp,%rbp
  804534:	48 83 ec 20          	sub    $0x20,%rsp
  804538:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80453c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804540:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804544:	48 89 c7             	mov    %rax,%rdi
  804547:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  80454e:	00 00 00 
  804551:	ff d0                	callq  *%rax
  804553:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804557:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80455b:	48 be f6 52 80 00 00 	movabs $0x8052f6,%rsi
  804562:	00 00 00 
  804565:	48 89 c7             	mov    %rax,%rdi
  804568:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  80456f:	00 00 00 
  804572:	ff d0                	callq  *%rax
  804574:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804578:	8b 50 04             	mov    0x4(%rax),%edx
  80457b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80457f:	8b 00                	mov    (%rax),%eax
  804581:	29 c2                	sub    %eax,%edx
  804583:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804587:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80458d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804591:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804598:	00 00 00 
  80459b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80459f:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  8045a6:	00 00 00 
  8045a9:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  8045b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8045b5:	c9                   	leaveq 
  8045b6:	c3                   	retq   

00000000008045b7 <devpipe_close>:
  8045b7:	55                   	push   %rbp
  8045b8:	48 89 e5             	mov    %rsp,%rbp
  8045bb:	48 83 ec 10          	sub    $0x10,%rsp
  8045bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8045c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045c7:	48 89 c6             	mov    %rax,%rsi
  8045ca:	bf 00 00 00 00       	mov    $0x0,%edi
  8045cf:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  8045d6:	00 00 00 
  8045d9:	ff d0                	callq  *%rax
  8045db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045df:	48 89 c7             	mov    %rax,%rdi
  8045e2:	48 b8 9e 27 80 00 00 	movabs $0x80279e,%rax
  8045e9:	00 00 00 
  8045ec:	ff d0                	callq  *%rax
  8045ee:	48 89 c6             	mov    %rax,%rsi
  8045f1:	bf 00 00 00 00       	mov    $0x0,%edi
  8045f6:	48 b8 f3 1b 80 00 00 	movabs $0x801bf3,%rax
  8045fd:	00 00 00 
  804600:	ff d0                	callq  *%rax
  804602:	c9                   	leaveq 
  804603:	c3                   	retq   

0000000000804604 <cputchar>:
  804604:	55                   	push   %rbp
  804605:	48 89 e5             	mov    %rsp,%rbp
  804608:	48 83 ec 20          	sub    $0x20,%rsp
  80460c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80460f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804612:	88 45 ff             	mov    %al,-0x1(%rbp)
  804615:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  804619:	be 01 00 00 00       	mov    $0x1,%esi
  80461e:	48 89 c7             	mov    %rax,%rdi
  804621:	48 b8 00 1a 80 00 00 	movabs $0x801a00,%rax
  804628:	00 00 00 
  80462b:	ff d0                	callq  *%rax
  80462d:	c9                   	leaveq 
  80462e:	c3                   	retq   

000000000080462f <getchar>:
  80462f:	55                   	push   %rbp
  804630:	48 89 e5             	mov    %rsp,%rbp
  804633:	48 83 ec 10          	sub    $0x10,%rsp
  804637:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  80463b:	ba 01 00 00 00       	mov    $0x1,%edx
  804640:	48 89 c6             	mov    %rax,%rsi
  804643:	bf 00 00 00 00       	mov    $0x0,%edi
  804648:	48 b8 93 2c 80 00 00 	movabs $0x802c93,%rax
  80464f:	00 00 00 
  804652:	ff d0                	callq  *%rax
  804654:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804657:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80465b:	79 05                	jns    804662 <getchar+0x33>
  80465d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804660:	eb 14                	jmp    804676 <getchar+0x47>
  804662:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804666:	7f 07                	jg     80466f <getchar+0x40>
  804668:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80466d:	eb 07                	jmp    804676 <getchar+0x47>
  80466f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804673:	0f b6 c0             	movzbl %al,%eax
  804676:	c9                   	leaveq 
  804677:	c3                   	retq   

0000000000804678 <iscons>:
  804678:	55                   	push   %rbp
  804679:	48 89 e5             	mov    %rsp,%rbp
  80467c:	48 83 ec 20          	sub    $0x20,%rsp
  804680:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804683:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804687:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80468a:	48 89 d6             	mov    %rdx,%rsi
  80468d:	89 c7                	mov    %eax,%edi
  80468f:	48 b8 61 28 80 00 00 	movabs $0x802861,%rax
  804696:	00 00 00 
  804699:	ff d0                	callq  *%rax
  80469b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80469e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046a2:	79 05                	jns    8046a9 <iscons+0x31>
  8046a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046a7:	eb 1a                	jmp    8046c3 <iscons+0x4b>
  8046a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046ad:	8b 10                	mov    (%rax),%edx
  8046af:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  8046b6:	00 00 00 
  8046b9:	8b 00                	mov    (%rax),%eax
  8046bb:	39 c2                	cmp    %eax,%edx
  8046bd:	0f 94 c0             	sete   %al
  8046c0:	0f b6 c0             	movzbl %al,%eax
  8046c3:	c9                   	leaveq 
  8046c4:	c3                   	retq   

00000000008046c5 <opencons>:
  8046c5:	55                   	push   %rbp
  8046c6:	48 89 e5             	mov    %rsp,%rbp
  8046c9:	48 83 ec 10          	sub    $0x10,%rsp
  8046cd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8046d1:	48 89 c7             	mov    %rax,%rdi
  8046d4:	48 b8 c9 27 80 00 00 	movabs $0x8027c9,%rax
  8046db:	00 00 00 
  8046de:	ff d0                	callq  *%rax
  8046e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046e7:	79 05                	jns    8046ee <opencons+0x29>
  8046e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046ec:	eb 5b                	jmp    804749 <opencons+0x84>
  8046ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046f2:	ba 07 04 00 00       	mov    $0x407,%edx
  8046f7:	48 89 c6             	mov    %rax,%rsi
  8046fa:	bf 00 00 00 00       	mov    $0x0,%edi
  8046ff:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  804706:	00 00 00 
  804709:	ff d0                	callq  *%rax
  80470b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80470e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804712:	79 05                	jns    804719 <opencons+0x54>
  804714:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804717:	eb 30                	jmp    804749 <opencons+0x84>
  804719:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80471d:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  804724:	00 00 00 
  804727:	8b 12                	mov    (%rdx),%edx
  804729:	89 10                	mov    %edx,(%rax)
  80472b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80472f:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  804736:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80473a:	48 89 c7             	mov    %rax,%rdi
  80473d:	48 b8 7b 27 80 00 00 	movabs $0x80277b,%rax
  804744:	00 00 00 
  804747:	ff d0                	callq  *%rax
  804749:	c9                   	leaveq 
  80474a:	c3                   	retq   

000000000080474b <devcons_read>:
  80474b:	55                   	push   %rbp
  80474c:	48 89 e5             	mov    %rsp,%rbp
  80474f:	48 83 ec 30          	sub    $0x30,%rsp
  804753:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804757:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80475b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80475f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804764:	75 07                	jne    80476d <devcons_read+0x22>
  804766:	b8 00 00 00 00       	mov    $0x0,%eax
  80476b:	eb 4b                	jmp    8047b8 <devcons_read+0x6d>
  80476d:	eb 0c                	jmp    80477b <devcons_read+0x30>
  80476f:	48 b8 0a 1b 80 00 00 	movabs $0x801b0a,%rax
  804776:	00 00 00 
  804779:	ff d0                	callq  *%rax
  80477b:	48 b8 4a 1a 80 00 00 	movabs $0x801a4a,%rax
  804782:	00 00 00 
  804785:	ff d0                	callq  *%rax
  804787:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80478a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80478e:	74 df                	je     80476f <devcons_read+0x24>
  804790:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804794:	79 05                	jns    80479b <devcons_read+0x50>
  804796:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804799:	eb 1d                	jmp    8047b8 <devcons_read+0x6d>
  80479b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80479f:	75 07                	jne    8047a8 <devcons_read+0x5d>
  8047a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8047a6:	eb 10                	jmp    8047b8 <devcons_read+0x6d>
  8047a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047ab:	89 c2                	mov    %eax,%edx
  8047ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047b1:	88 10                	mov    %dl,(%rax)
  8047b3:	b8 01 00 00 00       	mov    $0x1,%eax
  8047b8:	c9                   	leaveq 
  8047b9:	c3                   	retq   

00000000008047ba <devcons_write>:
  8047ba:	55                   	push   %rbp
  8047bb:	48 89 e5             	mov    %rsp,%rbp
  8047be:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  8047c5:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8047cc:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8047d3:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8047da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8047e1:	eb 76                	jmp    804859 <devcons_write+0x9f>
  8047e3:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8047ea:	89 c2                	mov    %eax,%edx
  8047ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047ef:	29 c2                	sub    %eax,%edx
  8047f1:	89 d0                	mov    %edx,%eax
  8047f3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8047f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047f9:	83 f8 7f             	cmp    $0x7f,%eax
  8047fc:	76 07                	jbe    804805 <devcons_write+0x4b>
  8047fe:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804805:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804808:	48 63 d0             	movslq %eax,%rdx
  80480b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80480e:	48 63 c8             	movslq %eax,%rcx
  804811:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804818:	48 01 c1             	add    %rax,%rcx
  80481b:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804822:	48 89 ce             	mov    %rcx,%rsi
  804825:	48 89 c7             	mov    %rax,%rdi
  804828:	48 b8 3d 15 80 00 00 	movabs $0x80153d,%rax
  80482f:	00 00 00 
  804832:	ff d0                	callq  *%rax
  804834:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804837:	48 63 d0             	movslq %eax,%rdx
  80483a:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804841:	48 89 d6             	mov    %rdx,%rsi
  804844:	48 89 c7             	mov    %rax,%rdi
  804847:	48 b8 00 1a 80 00 00 	movabs $0x801a00,%rax
  80484e:	00 00 00 
  804851:	ff d0                	callq  *%rax
  804853:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804856:	01 45 fc             	add    %eax,-0x4(%rbp)
  804859:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80485c:	48 98                	cltq   
  80485e:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804865:	0f 82 78 ff ff ff    	jb     8047e3 <devcons_write+0x29>
  80486b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80486e:	c9                   	leaveq 
  80486f:	c3                   	retq   

0000000000804870 <devcons_close>:
  804870:	55                   	push   %rbp
  804871:	48 89 e5             	mov    %rsp,%rbp
  804874:	48 83 ec 08          	sub    $0x8,%rsp
  804878:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80487c:	b8 00 00 00 00       	mov    $0x0,%eax
  804881:	c9                   	leaveq 
  804882:	c3                   	retq   

0000000000804883 <devcons_stat>:
  804883:	55                   	push   %rbp
  804884:	48 89 e5             	mov    %rsp,%rbp
  804887:	48 83 ec 10          	sub    $0x10,%rsp
  80488b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80488f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804893:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804897:	48 be 02 53 80 00 00 	movabs $0x805302,%rsi
  80489e:	00 00 00 
  8048a1:	48 89 c7             	mov    %rax,%rdi
  8048a4:	48 b8 19 12 80 00 00 	movabs $0x801219,%rax
  8048ab:	00 00 00 
  8048ae:	ff d0                	callq  *%rax
  8048b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8048b5:	c9                   	leaveq 
  8048b6:	c3                   	retq   

00000000008048b7 <set_pgfault_handler>:
  8048b7:	55                   	push   %rbp
  8048b8:	48 89 e5             	mov    %rsp,%rbp
  8048bb:	48 83 ec 20          	sub    $0x20,%rsp
  8048bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8048c3:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8048ca:	00 00 00 
  8048cd:	48 8b 00             	mov    (%rax),%rax
  8048d0:	48 85 c0             	test   %rax,%rax
  8048d3:	75 6f                	jne    804944 <set_pgfault_handler+0x8d>
  8048d5:	ba 07 00 00 00       	mov    $0x7,%edx
  8048da:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8048df:	bf 00 00 00 00       	mov    $0x0,%edi
  8048e4:	48 b8 48 1b 80 00 00 	movabs $0x801b48,%rax
  8048eb:	00 00 00 
  8048ee:	ff d0                	callq  *%rax
  8048f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048f7:	79 30                	jns    804929 <set_pgfault_handler+0x72>
  8048f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048fc:	89 c1                	mov    %eax,%ecx
  8048fe:	48 ba 10 53 80 00 00 	movabs $0x805310,%rdx
  804905:	00 00 00 
  804908:	be 22 00 00 00       	mov    $0x22,%esi
  80490d:	48 bf 2f 53 80 00 00 	movabs $0x80532f,%rdi
  804914:	00 00 00 
  804917:	b8 00 00 00 00       	mov    $0x0,%eax
  80491c:	49 b8 2b 04 80 00 00 	movabs $0x80042b,%r8
  804923:	00 00 00 
  804926:	41 ff d0             	callq  *%r8
  804929:	48 be 57 49 80 00 00 	movabs $0x804957,%rsi
  804930:	00 00 00 
  804933:	bf 00 00 00 00       	mov    $0x0,%edi
  804938:	48 b8 d2 1c 80 00 00 	movabs $0x801cd2,%rax
  80493f:	00 00 00 
  804942:	ff d0                	callq  *%rax
  804944:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80494b:	00 00 00 
  80494e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804952:	48 89 10             	mov    %rdx,(%rax)
  804955:	c9                   	leaveq 
  804956:	c3                   	retq   

0000000000804957 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  804957:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  80495a:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  804961:	00 00 00 
call *%rax
  804964:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  804966:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  80496d:	00 08 
    movq 152(%rsp), %rax
  80496f:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  804976:	00 
    movq 136(%rsp), %rbx
  804977:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  80497e:	00 
movq %rbx, (%rax)
  80497f:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804982:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  804986:	4c 8b 3c 24          	mov    (%rsp),%r15
  80498a:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  80498f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  804994:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804999:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  80499e:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  8049a3:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  8049a8:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  8049ad:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  8049b2:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  8049b7:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  8049bc:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  8049c1:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  8049c6:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  8049cb:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  8049d0:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  8049d4:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  8049d8:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  8049d9:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  8049de:	c3                   	retq   
