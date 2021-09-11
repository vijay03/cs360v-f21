
vmm/guest/obj/user/writemotd:     file format elf64-x86-64


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
  80003c:	e8 36 03 00 00       	callq  800377 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  80004e:	89 bd ec fd ff ff    	mov    %edi,-0x214(%rbp)
  800054:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80005b:	be 00 00 00 00       	mov    $0x0,%esi
  800060:	48 bf a0 42 80 00 00 	movabs $0x8042a0,%rdi
  800067:	00 00 00 
  80006a:	48 b8 08 29 80 00 00 	movabs $0x802908,%rax
  800071:	00 00 00 
  800074:	ff d0                	callq  *%rax
  800076:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800079:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80007d:	79 30                	jns    8000af <umain+0x6c>
  80007f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800082:	89 c1                	mov    %eax,%ecx
  800084:	48 ba a9 42 80 00 00 	movabs $0x8042a9,%rdx
  80008b:	00 00 00 
  80008e:	be 0c 00 00 00       	mov    $0xc,%esi
  800093:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  80009a:	00 00 00 
  80009d:	b8 00 00 00 00       	mov    $0x0,%eax
  8000a2:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  8000a9:	00 00 00 
  8000ac:	41 ff d0             	callq  *%r8
  8000af:	be 02 00 00 00       	mov    $0x2,%esi
  8000b4:	48 bf cf 42 80 00 00 	movabs $0x8042cf,%rdi
  8000bb:	00 00 00 
  8000be:	48 b8 08 29 80 00 00 	movabs $0x802908,%rax
  8000c5:	00 00 00 
  8000c8:	ff d0                	callq  *%rax
  8000ca:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000cd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000d1:	79 30                	jns    800103 <umain+0xc0>
  8000d3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000d6:	89 c1                	mov    %eax,%ecx
  8000d8:	48 ba d5 42 80 00 00 	movabs $0x8042d5,%rdx
  8000df:	00 00 00 
  8000e2:	be 0e 00 00 00       	mov    $0xe,%esi
  8000e7:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  8000ee:	00 00 00 
  8000f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8000f6:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  8000fd:	00 00 00 
  800100:	41 ff d0             	callq  *%r8
  800103:	8b 55 f8             	mov    -0x8(%rbp),%edx
  800106:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800109:	89 c6                	mov    %eax,%esi
  80010b:	48 bf e4 42 80 00 00 	movabs $0x8042e4,%rdi
  800112:	00 00 00 
  800115:	b8 00 00 00 00       	mov    $0x0,%eax
  80011a:	48 b9 56 06 80 00 00 	movabs $0x800656,%rcx
  800121:	00 00 00 
  800124:	ff d1                	callq  *%rcx
  800126:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800129:	3b 45 f8             	cmp    -0x8(%rbp),%eax
  80012c:	75 2a                	jne    800158 <umain+0x115>
  80012e:	48 ba 00 43 80 00 00 	movabs $0x804300,%rdx
  800135:	00 00 00 
  800138:	be 11 00 00 00       	mov    $0x11,%esi
  80013d:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  800144:	00 00 00 
  800147:	b8 00 00 00 00       	mov    $0x0,%eax
  80014c:	48 b9 1d 04 80 00 00 	movabs $0x80041d,%rcx
  800153:	00 00 00 
  800156:	ff d1                	callq  *%rcx
  800158:	48 bf 32 43 80 00 00 	movabs $0x804332,%rdi
  80015f:	00 00 00 
  800162:	b8 00 00 00 00       	mov    $0x0,%eax
  800167:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  80016e:	00 00 00 
  800171:	ff d2                	callq  *%rdx
  800173:	eb 1f                	jmp    800194 <umain+0x151>
  800175:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800178:	48 63 d0             	movslq %eax,%rdx
  80017b:	48 8d 85 f0 fd ff ff 	lea    -0x210(%rbp),%rax
  800182:	48 89 d6             	mov    %rdx,%rsi
  800185:	48 89 c7             	mov    %rax,%rdi
  800188:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  80018f:	00 00 00 
  800192:	ff d0                	callq  *%rax
  800194:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80019b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80019e:	ba ff 01 00 00       	mov    $0x1ff,%edx
  8001a3:	48 89 ce             	mov    %rcx,%rsi
  8001a6:	89 c7                	mov    %eax,%edi
  8001a8:	48 b8 32 24 80 00 00 	movabs $0x802432,%rax
  8001af:	00 00 00 
  8001b2:	ff d0                	callq  *%rax
  8001b4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8001b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8001bb:	7f b8                	jg     800175 <umain+0x132>
  8001bd:	48 bf 40 43 80 00 00 	movabs $0x804340,%rdi
  8001c4:	00 00 00 
  8001c7:	b8 00 00 00 00       	mov    $0x0,%eax
  8001cc:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  8001d3:	00 00 00 
  8001d6:	ff d2                	callq  *%rdx
  8001d8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001db:	be 00 00 00 00       	mov    $0x0,%esi
  8001e0:	89 c7                	mov    %eax,%edi
  8001e2:	48 b8 50 26 80 00 00 	movabs $0x802650,%rax
  8001e9:	00 00 00 
  8001ec:	ff d0                	callq  *%rax
  8001ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001f1:	be 00 00 00 00       	mov    $0x0,%esi
  8001f6:	89 c7                	mov    %eax,%edi
  8001f8:	48 b8 95 26 80 00 00 	movabs $0x802695,%rax
  8001ff:	00 00 00 
  800202:	ff d0                	callq  *%rax
  800204:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800207:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80020b:	79 30                	jns    80023d <umain+0x1fa>
  80020d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800210:	89 c1                	mov    %eax,%ecx
  800212:	48 ba 45 43 80 00 00 	movabs $0x804345,%rdx
  800219:	00 00 00 
  80021c:	be 1a 00 00 00       	mov    $0x1a,%esi
  800221:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  800228:	00 00 00 
  80022b:	b8 00 00 00 00       	mov    $0x0,%eax
  800230:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  800237:	00 00 00 
  80023a:	41 ff d0             	callq  *%r8
  80023d:	48 bf 58 43 80 00 00 	movabs $0x804358,%rdi
  800244:	00 00 00 
  800247:	b8 00 00 00 00       	mov    $0x0,%eax
  80024c:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  800253:	00 00 00 
  800256:	ff d2                	callq  *%rdx
  800258:	eb 7b                	jmp    8002d5 <umain+0x292>
  80025a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80025d:	48 63 d0             	movslq %eax,%rdx
  800260:	48 8d 85 f0 fd ff ff 	lea    -0x210(%rbp),%rax
  800267:	48 89 d6             	mov    %rdx,%rsi
  80026a:	48 89 c7             	mov    %rax,%rdi
  80026d:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  800274:	00 00 00 
  800277:	ff d0                	callq  *%rax
  800279:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80027c:	48 63 d0             	movslq %eax,%rdx
  80027f:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  800286:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800289:	48 89 ce             	mov    %rcx,%rsi
  80028c:	89 c7                	mov    %eax,%edi
  80028e:	48 b8 7c 25 80 00 00 	movabs $0x80257c,%rax
  800295:	00 00 00 
  800298:	ff d0                	callq  *%rax
  80029a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80029d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002a0:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8002a3:	74 30                	je     8002d5 <umain+0x292>
  8002a5:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002a8:	89 c1                	mov    %eax,%ecx
  8002aa:	48 ba 66 43 80 00 00 	movabs $0x804366,%rdx
  8002b1:	00 00 00 
  8002b4:	be 20 00 00 00       	mov    $0x20,%esi
  8002b9:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  8002c0:	00 00 00 
  8002c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8002c8:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  8002cf:	00 00 00 
  8002d2:	41 ff d0             	callq  *%r8
  8002d5:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8002dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002df:	ba ff 01 00 00       	mov    $0x1ff,%edx
  8002e4:	48 89 ce             	mov    %rcx,%rsi
  8002e7:	89 c7                	mov    %eax,%edi
  8002e9:	48 b8 32 24 80 00 00 	movabs $0x802432,%rax
  8002f0:	00 00 00 
  8002f3:	ff d0                	callq  *%rax
  8002f5:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8002f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8002fc:	0f 8f 58 ff ff ff    	jg     80025a <umain+0x217>
  800302:	48 bf 40 43 80 00 00 	movabs $0x804340,%rdi
  800309:	00 00 00 
  80030c:	b8 00 00 00 00       	mov    $0x0,%eax
  800311:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  800318:	00 00 00 
  80031b:	ff d2                	callq  *%rdx
  80031d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  800321:	79 30                	jns    800353 <umain+0x310>
  800323:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800326:	89 c1                	mov    %eax,%ecx
  800328:	48 ba 76 43 80 00 00 	movabs $0x804376,%rdx
  80032f:	00 00 00 
  800332:	be 25 00 00 00       	mov    $0x25,%esi
  800337:	48 bf bb 42 80 00 00 	movabs $0x8042bb,%rdi
  80033e:	00 00 00 
  800341:	b8 00 00 00 00       	mov    $0x0,%eax
  800346:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  80034d:	00 00 00 
  800350:	41 ff d0             	callq  *%r8
  800353:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800356:	89 c7                	mov    %eax,%edi
  800358:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  80035f:	00 00 00 
  800362:	ff d0                	callq  *%rax
  800364:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800367:	89 c7                	mov    %eax,%edi
  800369:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  800370:	00 00 00 
  800373:	ff d0                	callq  *%rax
  800375:	c9                   	leaveq 
  800376:	c3                   	retq   

0000000000800377 <libmain>:
  800377:	55                   	push   %rbp
  800378:	48 89 e5             	mov    %rsp,%rbp
  80037b:	48 83 ec 10          	sub    $0x10,%rsp
  80037f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800382:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800386:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  80038d:	00 00 00 
  800390:	ff d0                	callq  *%rax
  800392:	25 ff 03 00 00       	and    $0x3ff,%eax
  800397:	48 98                	cltq   
  800399:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8003a0:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8003a7:	00 00 00 
  8003aa:	48 01 c2             	add    %rax,%rdx
  8003ad:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8003b4:	00 00 00 
  8003b7:	48 89 10             	mov    %rdx,(%rax)
  8003ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8003be:	7e 14                	jle    8003d4 <libmain+0x5d>
  8003c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003c4:	48 8b 10             	mov    (%rax),%rdx
  8003c7:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8003ce:	00 00 00 
  8003d1:	48 89 10             	mov    %rdx,(%rax)
  8003d4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003db:	48 89 d6             	mov    %rdx,%rsi
  8003de:	89 c7                	mov    %eax,%edi
  8003e0:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8003e7:	00 00 00 
  8003ea:	ff d0                	callq  *%rax
  8003ec:	48 b8 fa 03 80 00 00 	movabs $0x8003fa,%rax
  8003f3:	00 00 00 
  8003f6:	ff d0                	callq  *%rax
  8003f8:	c9                   	leaveq 
  8003f9:	c3                   	retq   

00000000008003fa <exit>:
  8003fa:	55                   	push   %rbp
  8003fb:	48 89 e5             	mov    %rsp,%rbp
  8003fe:	48 b8 5b 22 80 00 00 	movabs $0x80225b,%rax
  800405:	00 00 00 
  800408:	ff d0                	callq  *%rax
  80040a:	bf 00 00 00 00       	mov    $0x0,%edi
  80040f:	48 b8 7a 1a 80 00 00 	movabs $0x801a7a,%rax
  800416:	00 00 00 
  800419:	ff d0                	callq  *%rax
  80041b:	5d                   	pop    %rbp
  80041c:	c3                   	retq   

000000000080041d <_panic>:
  80041d:	55                   	push   %rbp
  80041e:	48 89 e5             	mov    %rsp,%rbp
  800421:	53                   	push   %rbx
  800422:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800429:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800430:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800436:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  80043d:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800444:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80044b:	84 c0                	test   %al,%al
  80044d:	74 23                	je     800472 <_panic+0x55>
  80044f:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800456:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80045a:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  80045e:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800462:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800466:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80046a:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80046e:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800472:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800479:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800480:	00 00 00 
  800483:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80048a:	00 00 00 
  80048d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800491:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800498:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80049f:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8004a6:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8004ad:	00 00 00 
  8004b0:	48 8b 18             	mov    (%rax),%rbx
  8004b3:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  8004ba:	00 00 00 
  8004bd:	ff d0                	callq  *%rax
  8004bf:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8004c5:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8004cc:	41 89 c8             	mov    %ecx,%r8d
  8004cf:	48 89 d1             	mov    %rdx,%rcx
  8004d2:	48 89 da             	mov    %rbx,%rdx
  8004d5:	89 c6                	mov    %eax,%esi
  8004d7:	48 bf 98 43 80 00 00 	movabs $0x804398,%rdi
  8004de:	00 00 00 
  8004e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8004e6:	49 b9 56 06 80 00 00 	movabs $0x800656,%r9
  8004ed:	00 00 00 
  8004f0:	41 ff d1             	callq  *%r9
  8004f3:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8004fa:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800501:	48 89 d6             	mov    %rdx,%rsi
  800504:	48 89 c7             	mov    %rax,%rdi
  800507:	48 b8 aa 05 80 00 00 	movabs $0x8005aa,%rax
  80050e:	00 00 00 
  800511:	ff d0                	callq  *%rax
  800513:	48 bf bb 43 80 00 00 	movabs $0x8043bb,%rdi
  80051a:	00 00 00 
  80051d:	b8 00 00 00 00       	mov    $0x0,%eax
  800522:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  800529:	00 00 00 
  80052c:	ff d2                	callq  *%rdx
  80052e:	cc                   	int3   
  80052f:	eb fd                	jmp    80052e <_panic+0x111>

0000000000800531 <putch>:
  800531:	55                   	push   %rbp
  800532:	48 89 e5             	mov    %rsp,%rbp
  800535:	48 83 ec 10          	sub    $0x10,%rsp
  800539:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80053c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800540:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800544:	8b 00                	mov    (%rax),%eax
  800546:	8d 48 01             	lea    0x1(%rax),%ecx
  800549:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80054d:	89 0a                	mov    %ecx,(%rdx)
  80054f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800552:	89 d1                	mov    %edx,%ecx
  800554:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800558:	48 98                	cltq   
  80055a:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80055e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800562:	8b 00                	mov    (%rax),%eax
  800564:	3d ff 00 00 00       	cmp    $0xff,%eax
  800569:	75 2c                	jne    800597 <putch+0x66>
  80056b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80056f:	8b 00                	mov    (%rax),%eax
  800571:	48 98                	cltq   
  800573:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800577:	48 83 c2 08          	add    $0x8,%rdx
  80057b:	48 89 c6             	mov    %rax,%rsi
  80057e:	48 89 d7             	mov    %rdx,%rdi
  800581:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  800588:	00 00 00 
  80058b:	ff d0                	callq  *%rax
  80058d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800591:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800597:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80059b:	8b 40 04             	mov    0x4(%rax),%eax
  80059e:	8d 50 01             	lea    0x1(%rax),%edx
  8005a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005a5:	89 50 04             	mov    %edx,0x4(%rax)
  8005a8:	c9                   	leaveq 
  8005a9:	c3                   	retq   

00000000008005aa <vcprintf>:
  8005aa:	55                   	push   %rbp
  8005ab:	48 89 e5             	mov    %rsp,%rbp
  8005ae:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8005b5:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8005bc:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8005c3:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8005ca:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8005d1:	48 8b 0a             	mov    (%rdx),%rcx
  8005d4:	48 89 08             	mov    %rcx,(%rax)
  8005d7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8005db:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8005df:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8005e3:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8005e7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8005ee:	00 00 00 
  8005f1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8005f8:	00 00 00 
  8005fb:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800602:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800609:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800610:	48 89 c6             	mov    %rax,%rsi
  800613:	48 bf 31 05 80 00 00 	movabs $0x800531,%rdi
  80061a:	00 00 00 
  80061d:	48 b8 09 0a 80 00 00 	movabs $0x800a09,%rax
  800624:	00 00 00 
  800627:	ff d0                	callq  *%rax
  800629:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  80062f:	48 98                	cltq   
  800631:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800638:	48 83 c2 08          	add    $0x8,%rdx
  80063c:	48 89 c6             	mov    %rax,%rsi
  80063f:	48 89 d7             	mov    %rdx,%rdi
  800642:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  800649:	00 00 00 
  80064c:	ff d0                	callq  *%rax
  80064e:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800654:	c9                   	leaveq 
  800655:	c3                   	retq   

0000000000800656 <cprintf>:
  800656:	55                   	push   %rbp
  800657:	48 89 e5             	mov    %rsp,%rbp
  80065a:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800661:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800668:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80066f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800676:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80067d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800684:	84 c0                	test   %al,%al
  800686:	74 20                	je     8006a8 <cprintf+0x52>
  800688:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80068c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800690:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800694:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800698:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80069c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8006a0:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8006a4:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8006a8:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8006af:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8006b6:	00 00 00 
  8006b9:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8006c0:	00 00 00 
  8006c3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8006c7:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8006ce:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8006d5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8006dc:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8006e3:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8006ea:	48 8b 0a             	mov    (%rdx),%rcx
  8006ed:	48 89 08             	mov    %rcx,(%rax)
  8006f0:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8006f4:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8006f8:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8006fc:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800700:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800707:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80070e:	48 89 d6             	mov    %rdx,%rsi
  800711:	48 89 c7             	mov    %rax,%rdi
  800714:	48 b8 aa 05 80 00 00 	movabs $0x8005aa,%rax
  80071b:	00 00 00 
  80071e:	ff d0                	callq  *%rax
  800720:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800726:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80072c:	c9                   	leaveq 
  80072d:	c3                   	retq   

000000000080072e <printnum>:
  80072e:	55                   	push   %rbp
  80072f:	48 89 e5             	mov    %rsp,%rbp
  800732:	53                   	push   %rbx
  800733:	48 83 ec 38          	sub    $0x38,%rsp
  800737:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80073b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80073f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800743:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800746:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80074a:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  80074e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800751:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800755:	77 3b                	ja     800792 <printnum+0x64>
  800757:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80075a:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  80075e:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800761:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800765:	ba 00 00 00 00       	mov    $0x0,%edx
  80076a:	48 f7 f3             	div    %rbx
  80076d:	48 89 c2             	mov    %rax,%rdx
  800770:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800773:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800776:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80077a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80077e:	41 89 f9             	mov    %edi,%r9d
  800781:	48 89 c7             	mov    %rax,%rdi
  800784:	48 b8 2e 07 80 00 00 	movabs $0x80072e,%rax
  80078b:	00 00 00 
  80078e:	ff d0                	callq  *%rax
  800790:	eb 1e                	jmp    8007b0 <printnum+0x82>
  800792:	eb 12                	jmp    8007a6 <printnum+0x78>
  800794:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800798:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80079b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80079f:	48 89 ce             	mov    %rcx,%rsi
  8007a2:	89 d7                	mov    %edx,%edi
  8007a4:	ff d0                	callq  *%rax
  8007a6:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8007aa:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8007ae:	7f e4                	jg     800794 <printnum+0x66>
  8007b0:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8007b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007b7:	ba 00 00 00 00       	mov    $0x0,%edx
  8007bc:	48 f7 f1             	div    %rcx
  8007bf:	48 89 d0             	mov    %rdx,%rax
  8007c2:	48 ba b0 45 80 00 00 	movabs $0x8045b0,%rdx
  8007c9:	00 00 00 
  8007cc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8007d0:	0f be d0             	movsbl %al,%edx
  8007d3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8007d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007db:	48 89 ce             	mov    %rcx,%rsi
  8007de:	89 d7                	mov    %edx,%edi
  8007e0:	ff d0                	callq  *%rax
  8007e2:	48 83 c4 38          	add    $0x38,%rsp
  8007e6:	5b                   	pop    %rbx
  8007e7:	5d                   	pop    %rbp
  8007e8:	c3                   	retq   

00000000008007e9 <getuint>:
  8007e9:	55                   	push   %rbp
  8007ea:	48 89 e5             	mov    %rsp,%rbp
  8007ed:	48 83 ec 1c          	sub    $0x1c,%rsp
  8007f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8007f5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8007f8:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8007fc:	7e 52                	jle    800850 <getuint+0x67>
  8007fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800802:	8b 00                	mov    (%rax),%eax
  800804:	83 f8 30             	cmp    $0x30,%eax
  800807:	73 24                	jae    80082d <getuint+0x44>
  800809:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80080d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800811:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800815:	8b 00                	mov    (%rax),%eax
  800817:	89 c0                	mov    %eax,%eax
  800819:	48 01 d0             	add    %rdx,%rax
  80081c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800820:	8b 12                	mov    (%rdx),%edx
  800822:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800825:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800829:	89 0a                	mov    %ecx,(%rdx)
  80082b:	eb 17                	jmp    800844 <getuint+0x5b>
  80082d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800831:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800835:	48 89 d0             	mov    %rdx,%rax
  800838:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80083c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800840:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800844:	48 8b 00             	mov    (%rax),%rax
  800847:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80084b:	e9 a3 00 00 00       	jmpq   8008f3 <getuint+0x10a>
  800850:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800854:	74 4f                	je     8008a5 <getuint+0xbc>
  800856:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80085a:	8b 00                	mov    (%rax),%eax
  80085c:	83 f8 30             	cmp    $0x30,%eax
  80085f:	73 24                	jae    800885 <getuint+0x9c>
  800861:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800865:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800869:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80086d:	8b 00                	mov    (%rax),%eax
  80086f:	89 c0                	mov    %eax,%eax
  800871:	48 01 d0             	add    %rdx,%rax
  800874:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800878:	8b 12                	mov    (%rdx),%edx
  80087a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80087d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800881:	89 0a                	mov    %ecx,(%rdx)
  800883:	eb 17                	jmp    80089c <getuint+0xb3>
  800885:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800889:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80088d:	48 89 d0             	mov    %rdx,%rax
  800890:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800894:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800898:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80089c:	48 8b 00             	mov    (%rax),%rax
  80089f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008a3:	eb 4e                	jmp    8008f3 <getuint+0x10a>
  8008a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008a9:	8b 00                	mov    (%rax),%eax
  8008ab:	83 f8 30             	cmp    $0x30,%eax
  8008ae:	73 24                	jae    8008d4 <getuint+0xeb>
  8008b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008b4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008bc:	8b 00                	mov    (%rax),%eax
  8008be:	89 c0                	mov    %eax,%eax
  8008c0:	48 01 d0             	add    %rdx,%rax
  8008c3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008c7:	8b 12                	mov    (%rdx),%edx
  8008c9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008cc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008d0:	89 0a                	mov    %ecx,(%rdx)
  8008d2:	eb 17                	jmp    8008eb <getuint+0x102>
  8008d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008d8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008dc:	48 89 d0             	mov    %rdx,%rax
  8008df:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008e3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008eb:	8b 00                	mov    (%rax),%eax
  8008ed:	89 c0                	mov    %eax,%eax
  8008ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8008f7:	c9                   	leaveq 
  8008f8:	c3                   	retq   

00000000008008f9 <getint>:
  8008f9:	55                   	push   %rbp
  8008fa:	48 89 e5             	mov    %rsp,%rbp
  8008fd:	48 83 ec 1c          	sub    $0x1c,%rsp
  800901:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800905:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800908:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80090c:	7e 52                	jle    800960 <getint+0x67>
  80090e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800912:	8b 00                	mov    (%rax),%eax
  800914:	83 f8 30             	cmp    $0x30,%eax
  800917:	73 24                	jae    80093d <getint+0x44>
  800919:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80091d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800921:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800925:	8b 00                	mov    (%rax),%eax
  800927:	89 c0                	mov    %eax,%eax
  800929:	48 01 d0             	add    %rdx,%rax
  80092c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800930:	8b 12                	mov    (%rdx),%edx
  800932:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800935:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800939:	89 0a                	mov    %ecx,(%rdx)
  80093b:	eb 17                	jmp    800954 <getint+0x5b>
  80093d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800941:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800945:	48 89 d0             	mov    %rdx,%rax
  800948:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80094c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800950:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800954:	48 8b 00             	mov    (%rax),%rax
  800957:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80095b:	e9 a3 00 00 00       	jmpq   800a03 <getint+0x10a>
  800960:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800964:	74 4f                	je     8009b5 <getint+0xbc>
  800966:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80096a:	8b 00                	mov    (%rax),%eax
  80096c:	83 f8 30             	cmp    $0x30,%eax
  80096f:	73 24                	jae    800995 <getint+0x9c>
  800971:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800975:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80097d:	8b 00                	mov    (%rax),%eax
  80097f:	89 c0                	mov    %eax,%eax
  800981:	48 01 d0             	add    %rdx,%rax
  800984:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800988:	8b 12                	mov    (%rdx),%edx
  80098a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80098d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800991:	89 0a                	mov    %ecx,(%rdx)
  800993:	eb 17                	jmp    8009ac <getint+0xb3>
  800995:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800999:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80099d:	48 89 d0             	mov    %rdx,%rax
  8009a0:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009a4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009a8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009ac:	48 8b 00             	mov    (%rax),%rax
  8009af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009b3:	eb 4e                	jmp    800a03 <getint+0x10a>
  8009b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b9:	8b 00                	mov    (%rax),%eax
  8009bb:	83 f8 30             	cmp    $0x30,%eax
  8009be:	73 24                	jae    8009e4 <getint+0xeb>
  8009c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009c4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009cc:	8b 00                	mov    (%rax),%eax
  8009ce:	89 c0                	mov    %eax,%eax
  8009d0:	48 01 d0             	add    %rdx,%rax
  8009d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009d7:	8b 12                	mov    (%rdx),%edx
  8009d9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009dc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009e0:	89 0a                	mov    %ecx,(%rdx)
  8009e2:	eb 17                	jmp    8009fb <getint+0x102>
  8009e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009e8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009ec:	48 89 d0             	mov    %rdx,%rax
  8009ef:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009f3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009fb:	8b 00                	mov    (%rax),%eax
  8009fd:	48 98                	cltq   
  8009ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800a07:	c9                   	leaveq 
  800a08:	c3                   	retq   

0000000000800a09 <vprintfmt>:
  800a09:	55                   	push   %rbp
  800a0a:	48 89 e5             	mov    %rsp,%rbp
  800a0d:	41 54                	push   %r12
  800a0f:	53                   	push   %rbx
  800a10:	48 83 ec 60          	sub    $0x60,%rsp
  800a14:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800a18:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800a1c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a20:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800a24:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800a28:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800a2c:	48 8b 0a             	mov    (%rdx),%rcx
  800a2f:	48 89 08             	mov    %rcx,(%rax)
  800a32:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800a36:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800a3a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800a3e:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800a42:	eb 17                	jmp    800a5b <vprintfmt+0x52>
  800a44:	85 db                	test   %ebx,%ebx
  800a46:	0f 84 cc 04 00 00    	je     800f18 <vprintfmt+0x50f>
  800a4c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a50:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a54:	48 89 d6             	mov    %rdx,%rsi
  800a57:	89 df                	mov    %ebx,%edi
  800a59:	ff d0                	callq  *%rax
  800a5b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a5f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a63:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a67:	0f b6 00             	movzbl (%rax),%eax
  800a6a:	0f b6 d8             	movzbl %al,%ebx
  800a6d:	83 fb 25             	cmp    $0x25,%ebx
  800a70:	75 d2                	jne    800a44 <vprintfmt+0x3b>
  800a72:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800a76:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800a7d:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a84:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800a8b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800a92:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a96:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a9a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a9e:	0f b6 00             	movzbl (%rax),%eax
  800aa1:	0f b6 d8             	movzbl %al,%ebx
  800aa4:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800aa7:	83 f8 55             	cmp    $0x55,%eax
  800aaa:	0f 87 34 04 00 00    	ja     800ee4 <vprintfmt+0x4db>
  800ab0:	89 c0                	mov    %eax,%eax
  800ab2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800ab9:	00 
  800aba:	48 b8 d8 45 80 00 00 	movabs $0x8045d8,%rax
  800ac1:	00 00 00 
  800ac4:	48 01 d0             	add    %rdx,%rax
  800ac7:	48 8b 00             	mov    (%rax),%rax
  800aca:	ff e0                	jmpq   *%rax
  800acc:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800ad0:	eb c0                	jmp    800a92 <vprintfmt+0x89>
  800ad2:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800ad6:	eb ba                	jmp    800a92 <vprintfmt+0x89>
  800ad8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800adf:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800ae2:	89 d0                	mov    %edx,%eax
  800ae4:	c1 e0 02             	shl    $0x2,%eax
  800ae7:	01 d0                	add    %edx,%eax
  800ae9:	01 c0                	add    %eax,%eax
  800aeb:	01 d8                	add    %ebx,%eax
  800aed:	83 e8 30             	sub    $0x30,%eax
  800af0:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800af3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800af7:	0f b6 00             	movzbl (%rax),%eax
  800afa:	0f be d8             	movsbl %al,%ebx
  800afd:	83 fb 2f             	cmp    $0x2f,%ebx
  800b00:	7e 0c                	jle    800b0e <vprintfmt+0x105>
  800b02:	83 fb 39             	cmp    $0x39,%ebx
  800b05:	7f 07                	jg     800b0e <vprintfmt+0x105>
  800b07:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800b0c:	eb d1                	jmp    800adf <vprintfmt+0xd6>
  800b0e:	eb 58                	jmp    800b68 <vprintfmt+0x15f>
  800b10:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b13:	83 f8 30             	cmp    $0x30,%eax
  800b16:	73 17                	jae    800b2f <vprintfmt+0x126>
  800b18:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b1c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b1f:	89 c0                	mov    %eax,%eax
  800b21:	48 01 d0             	add    %rdx,%rax
  800b24:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b27:	83 c2 08             	add    $0x8,%edx
  800b2a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b2d:	eb 0f                	jmp    800b3e <vprintfmt+0x135>
  800b2f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b33:	48 89 d0             	mov    %rdx,%rax
  800b36:	48 83 c2 08          	add    $0x8,%rdx
  800b3a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b3e:	8b 00                	mov    (%rax),%eax
  800b40:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800b43:	eb 23                	jmp    800b68 <vprintfmt+0x15f>
  800b45:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b49:	79 0c                	jns    800b57 <vprintfmt+0x14e>
  800b4b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800b52:	e9 3b ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b57:	e9 36 ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b5c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800b63:	e9 2a ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b68:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b6c:	79 12                	jns    800b80 <vprintfmt+0x177>
  800b6e:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b71:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800b74:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b7b:	e9 12 ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b80:	e9 0d ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b85:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800b89:	e9 04 ff ff ff       	jmpq   800a92 <vprintfmt+0x89>
  800b8e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b91:	83 f8 30             	cmp    $0x30,%eax
  800b94:	73 17                	jae    800bad <vprintfmt+0x1a4>
  800b96:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b9a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b9d:	89 c0                	mov    %eax,%eax
  800b9f:	48 01 d0             	add    %rdx,%rax
  800ba2:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ba5:	83 c2 08             	add    $0x8,%edx
  800ba8:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bab:	eb 0f                	jmp    800bbc <vprintfmt+0x1b3>
  800bad:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bb1:	48 89 d0             	mov    %rdx,%rax
  800bb4:	48 83 c2 08          	add    $0x8,%rdx
  800bb8:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bbc:	8b 10                	mov    (%rax),%edx
  800bbe:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800bc2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bc6:	48 89 ce             	mov    %rcx,%rsi
  800bc9:	89 d7                	mov    %edx,%edi
  800bcb:	ff d0                	callq  *%rax
  800bcd:	e9 40 03 00 00       	jmpq   800f12 <vprintfmt+0x509>
  800bd2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bd5:	83 f8 30             	cmp    $0x30,%eax
  800bd8:	73 17                	jae    800bf1 <vprintfmt+0x1e8>
  800bda:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800bde:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800be1:	89 c0                	mov    %eax,%eax
  800be3:	48 01 d0             	add    %rdx,%rax
  800be6:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800be9:	83 c2 08             	add    $0x8,%edx
  800bec:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bef:	eb 0f                	jmp    800c00 <vprintfmt+0x1f7>
  800bf1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bf5:	48 89 d0             	mov    %rdx,%rax
  800bf8:	48 83 c2 08          	add    $0x8,%rdx
  800bfc:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c00:	8b 18                	mov    (%rax),%ebx
  800c02:	85 db                	test   %ebx,%ebx
  800c04:	79 02                	jns    800c08 <vprintfmt+0x1ff>
  800c06:	f7 db                	neg    %ebx
  800c08:	83 fb 15             	cmp    $0x15,%ebx
  800c0b:	7f 16                	jg     800c23 <vprintfmt+0x21a>
  800c0d:	48 b8 00 45 80 00 00 	movabs $0x804500,%rax
  800c14:	00 00 00 
  800c17:	48 63 d3             	movslq %ebx,%rdx
  800c1a:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800c1e:	4d 85 e4             	test   %r12,%r12
  800c21:	75 2e                	jne    800c51 <vprintfmt+0x248>
  800c23:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c27:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c2b:	89 d9                	mov    %ebx,%ecx
  800c2d:	48 ba c1 45 80 00 00 	movabs $0x8045c1,%rdx
  800c34:	00 00 00 
  800c37:	48 89 c7             	mov    %rax,%rdi
  800c3a:	b8 00 00 00 00       	mov    $0x0,%eax
  800c3f:	49 b8 21 0f 80 00 00 	movabs $0x800f21,%r8
  800c46:	00 00 00 
  800c49:	41 ff d0             	callq  *%r8
  800c4c:	e9 c1 02 00 00       	jmpq   800f12 <vprintfmt+0x509>
  800c51:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c55:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c59:	4c 89 e1             	mov    %r12,%rcx
  800c5c:	48 ba ca 45 80 00 00 	movabs $0x8045ca,%rdx
  800c63:	00 00 00 
  800c66:	48 89 c7             	mov    %rax,%rdi
  800c69:	b8 00 00 00 00       	mov    $0x0,%eax
  800c6e:	49 b8 21 0f 80 00 00 	movabs $0x800f21,%r8
  800c75:	00 00 00 
  800c78:	41 ff d0             	callq  *%r8
  800c7b:	e9 92 02 00 00       	jmpq   800f12 <vprintfmt+0x509>
  800c80:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c83:	83 f8 30             	cmp    $0x30,%eax
  800c86:	73 17                	jae    800c9f <vprintfmt+0x296>
  800c88:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c8c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c8f:	89 c0                	mov    %eax,%eax
  800c91:	48 01 d0             	add    %rdx,%rax
  800c94:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c97:	83 c2 08             	add    $0x8,%edx
  800c9a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c9d:	eb 0f                	jmp    800cae <vprintfmt+0x2a5>
  800c9f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ca3:	48 89 d0             	mov    %rdx,%rax
  800ca6:	48 83 c2 08          	add    $0x8,%rdx
  800caa:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800cae:	4c 8b 20             	mov    (%rax),%r12
  800cb1:	4d 85 e4             	test   %r12,%r12
  800cb4:	75 0a                	jne    800cc0 <vprintfmt+0x2b7>
  800cb6:	49 bc cd 45 80 00 00 	movabs $0x8045cd,%r12
  800cbd:	00 00 00 
  800cc0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800cc4:	7e 3f                	jle    800d05 <vprintfmt+0x2fc>
  800cc6:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800cca:	74 39                	je     800d05 <vprintfmt+0x2fc>
  800ccc:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800ccf:	48 98                	cltq   
  800cd1:	48 89 c6             	mov    %rax,%rsi
  800cd4:	4c 89 e7             	mov    %r12,%rdi
  800cd7:	48 b8 cd 11 80 00 00 	movabs $0x8011cd,%rax
  800cde:	00 00 00 
  800ce1:	ff d0                	callq  *%rax
  800ce3:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800ce6:	eb 17                	jmp    800cff <vprintfmt+0x2f6>
  800ce8:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800cec:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800cf0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cf4:	48 89 ce             	mov    %rcx,%rsi
  800cf7:	89 d7                	mov    %edx,%edi
  800cf9:	ff d0                	callq  *%rax
  800cfb:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800cff:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d03:	7f e3                	jg     800ce8 <vprintfmt+0x2df>
  800d05:	eb 37                	jmp    800d3e <vprintfmt+0x335>
  800d07:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800d0b:	74 1e                	je     800d2b <vprintfmt+0x322>
  800d0d:	83 fb 1f             	cmp    $0x1f,%ebx
  800d10:	7e 05                	jle    800d17 <vprintfmt+0x30e>
  800d12:	83 fb 7e             	cmp    $0x7e,%ebx
  800d15:	7e 14                	jle    800d2b <vprintfmt+0x322>
  800d17:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d1b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d1f:	48 89 d6             	mov    %rdx,%rsi
  800d22:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800d27:	ff d0                	callq  *%rax
  800d29:	eb 0f                	jmp    800d3a <vprintfmt+0x331>
  800d2b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d2f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d33:	48 89 d6             	mov    %rdx,%rsi
  800d36:	89 df                	mov    %ebx,%edi
  800d38:	ff d0                	callq  *%rax
  800d3a:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d3e:	4c 89 e0             	mov    %r12,%rax
  800d41:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800d45:	0f b6 00             	movzbl (%rax),%eax
  800d48:	0f be d8             	movsbl %al,%ebx
  800d4b:	85 db                	test   %ebx,%ebx
  800d4d:	74 10                	je     800d5f <vprintfmt+0x356>
  800d4f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d53:	78 b2                	js     800d07 <vprintfmt+0x2fe>
  800d55:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800d59:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d5d:	79 a8                	jns    800d07 <vprintfmt+0x2fe>
  800d5f:	eb 16                	jmp    800d77 <vprintfmt+0x36e>
  800d61:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d65:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d69:	48 89 d6             	mov    %rdx,%rsi
  800d6c:	bf 20 00 00 00       	mov    $0x20,%edi
  800d71:	ff d0                	callq  *%rax
  800d73:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d77:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d7b:	7f e4                	jg     800d61 <vprintfmt+0x358>
  800d7d:	e9 90 01 00 00       	jmpq   800f12 <vprintfmt+0x509>
  800d82:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d86:	be 03 00 00 00       	mov    $0x3,%esi
  800d8b:	48 89 c7             	mov    %rax,%rdi
  800d8e:	48 b8 f9 08 80 00 00 	movabs $0x8008f9,%rax
  800d95:	00 00 00 
  800d98:	ff d0                	callq  *%rax
  800d9a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800da2:	48 85 c0             	test   %rax,%rax
  800da5:	79 1d                	jns    800dc4 <vprintfmt+0x3bb>
  800da7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800daf:	48 89 d6             	mov    %rdx,%rsi
  800db2:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800db7:	ff d0                	callq  *%rax
  800db9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800dbd:	48 f7 d8             	neg    %rax
  800dc0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dc4:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800dcb:	e9 d5 00 00 00       	jmpq   800ea5 <vprintfmt+0x49c>
  800dd0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800dd4:	be 03 00 00 00       	mov    $0x3,%esi
  800dd9:	48 89 c7             	mov    %rax,%rdi
  800ddc:	48 b8 e9 07 80 00 00 	movabs $0x8007e9,%rax
  800de3:	00 00 00 
  800de6:	ff d0                	callq  *%rax
  800de8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dec:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800df3:	e9 ad 00 00 00       	jmpq   800ea5 <vprintfmt+0x49c>
  800df8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800dfc:	be 03 00 00 00       	mov    $0x3,%esi
  800e01:	48 89 c7             	mov    %rax,%rdi
  800e04:	48 b8 e9 07 80 00 00 	movabs $0x8007e9,%rax
  800e0b:	00 00 00 
  800e0e:	ff d0                	callq  *%rax
  800e10:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e14:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800e1b:	e9 85 00 00 00       	jmpq   800ea5 <vprintfmt+0x49c>
  800e20:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e24:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e28:	48 89 d6             	mov    %rdx,%rsi
  800e2b:	bf 30 00 00 00       	mov    $0x30,%edi
  800e30:	ff d0                	callq  *%rax
  800e32:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e36:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e3a:	48 89 d6             	mov    %rdx,%rsi
  800e3d:	bf 78 00 00 00       	mov    $0x78,%edi
  800e42:	ff d0                	callq  *%rax
  800e44:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e47:	83 f8 30             	cmp    $0x30,%eax
  800e4a:	73 17                	jae    800e63 <vprintfmt+0x45a>
  800e4c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e50:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e53:	89 c0                	mov    %eax,%eax
  800e55:	48 01 d0             	add    %rdx,%rax
  800e58:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e5b:	83 c2 08             	add    $0x8,%edx
  800e5e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e61:	eb 0f                	jmp    800e72 <vprintfmt+0x469>
  800e63:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e67:	48 89 d0             	mov    %rdx,%rax
  800e6a:	48 83 c2 08          	add    $0x8,%rdx
  800e6e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e72:	48 8b 00             	mov    (%rax),%rax
  800e75:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e79:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e80:	eb 23                	jmp    800ea5 <vprintfmt+0x49c>
  800e82:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e86:	be 03 00 00 00       	mov    $0x3,%esi
  800e8b:	48 89 c7             	mov    %rax,%rdi
  800e8e:	48 b8 e9 07 80 00 00 	movabs $0x8007e9,%rax
  800e95:	00 00 00 
  800e98:	ff d0                	callq  *%rax
  800e9a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e9e:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800ea5:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800eaa:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800ead:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800eb0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800eb4:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800eb8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ebc:	45 89 c1             	mov    %r8d,%r9d
  800ebf:	41 89 f8             	mov    %edi,%r8d
  800ec2:	48 89 c7             	mov    %rax,%rdi
  800ec5:	48 b8 2e 07 80 00 00 	movabs $0x80072e,%rax
  800ecc:	00 00 00 
  800ecf:	ff d0                	callq  *%rax
  800ed1:	eb 3f                	jmp    800f12 <vprintfmt+0x509>
  800ed3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ed7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800edb:	48 89 d6             	mov    %rdx,%rsi
  800ede:	89 df                	mov    %ebx,%edi
  800ee0:	ff d0                	callq  *%rax
  800ee2:	eb 2e                	jmp    800f12 <vprintfmt+0x509>
  800ee4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ee8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800eec:	48 89 d6             	mov    %rdx,%rsi
  800eef:	bf 25 00 00 00       	mov    $0x25,%edi
  800ef4:	ff d0                	callq  *%rax
  800ef6:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800efb:	eb 05                	jmp    800f02 <vprintfmt+0x4f9>
  800efd:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800f02:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800f06:	48 83 e8 01          	sub    $0x1,%rax
  800f0a:	0f b6 00             	movzbl (%rax),%eax
  800f0d:	3c 25                	cmp    $0x25,%al
  800f0f:	75 ec                	jne    800efd <vprintfmt+0x4f4>
  800f11:	90                   	nop
  800f12:	90                   	nop
  800f13:	e9 43 fb ff ff       	jmpq   800a5b <vprintfmt+0x52>
  800f18:	48 83 c4 60          	add    $0x60,%rsp
  800f1c:	5b                   	pop    %rbx
  800f1d:	41 5c                	pop    %r12
  800f1f:	5d                   	pop    %rbp
  800f20:	c3                   	retq   

0000000000800f21 <printfmt>:
  800f21:	55                   	push   %rbp
  800f22:	48 89 e5             	mov    %rsp,%rbp
  800f25:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800f2c:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800f33:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800f3a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f41:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f48:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f4f:	84 c0                	test   %al,%al
  800f51:	74 20                	je     800f73 <printfmt+0x52>
  800f53:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f57:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f5b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f5f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f63:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f67:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f6b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f6f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f73:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800f7a:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800f81:	00 00 00 
  800f84:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800f8b:	00 00 00 
  800f8e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800f92:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800f99:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800fa0:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800fa7:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800fae:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800fb5:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800fbc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800fc3:	48 89 c7             	mov    %rax,%rdi
  800fc6:	48 b8 09 0a 80 00 00 	movabs $0x800a09,%rax
  800fcd:	00 00 00 
  800fd0:	ff d0                	callq  *%rax
  800fd2:	c9                   	leaveq 
  800fd3:	c3                   	retq   

0000000000800fd4 <sprintputch>:
  800fd4:	55                   	push   %rbp
  800fd5:	48 89 e5             	mov    %rsp,%rbp
  800fd8:	48 83 ec 10          	sub    $0x10,%rsp
  800fdc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800fdf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800fe3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fe7:	8b 40 10             	mov    0x10(%rax),%eax
  800fea:	8d 50 01             	lea    0x1(%rax),%edx
  800fed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ff1:	89 50 10             	mov    %edx,0x10(%rax)
  800ff4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ff8:	48 8b 10             	mov    (%rax),%rdx
  800ffb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fff:	48 8b 40 08          	mov    0x8(%rax),%rax
  801003:	48 39 c2             	cmp    %rax,%rdx
  801006:	73 17                	jae    80101f <sprintputch+0x4b>
  801008:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80100c:	48 8b 00             	mov    (%rax),%rax
  80100f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801013:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801017:	48 89 0a             	mov    %rcx,(%rdx)
  80101a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80101d:	88 10                	mov    %dl,(%rax)
  80101f:	c9                   	leaveq 
  801020:	c3                   	retq   

0000000000801021 <vsnprintf>:
  801021:	55                   	push   %rbp
  801022:	48 89 e5             	mov    %rsp,%rbp
  801025:	48 83 ec 50          	sub    $0x50,%rsp
  801029:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  80102d:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801030:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801034:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  801038:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  80103c:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801040:	48 8b 0a             	mov    (%rdx),%rcx
  801043:	48 89 08             	mov    %rcx,(%rax)
  801046:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80104a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80104e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801052:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801056:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80105a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  80105e:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801061:	48 98                	cltq   
  801063:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801067:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80106b:	48 01 d0             	add    %rdx,%rax
  80106e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801072:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801079:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  80107e:	74 06                	je     801086 <vsnprintf+0x65>
  801080:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801084:	7f 07                	jg     80108d <vsnprintf+0x6c>
  801086:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80108b:	eb 2f                	jmp    8010bc <vsnprintf+0x9b>
  80108d:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801091:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801095:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801099:	48 89 c6             	mov    %rax,%rsi
  80109c:	48 bf d4 0f 80 00 00 	movabs $0x800fd4,%rdi
  8010a3:	00 00 00 
  8010a6:	48 b8 09 0a 80 00 00 	movabs $0x800a09,%rax
  8010ad:	00 00 00 
  8010b0:	ff d0                	callq  *%rax
  8010b2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8010b6:	c6 00 00             	movb   $0x0,(%rax)
  8010b9:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8010bc:	c9                   	leaveq 
  8010bd:	c3                   	retq   

00000000008010be <snprintf>:
  8010be:	55                   	push   %rbp
  8010bf:	48 89 e5             	mov    %rsp,%rbp
  8010c2:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8010c9:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8010d0:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8010d6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8010dd:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8010e4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8010eb:	84 c0                	test   %al,%al
  8010ed:	74 20                	je     80110f <snprintf+0x51>
  8010ef:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8010f3:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8010f7:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8010fb:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8010ff:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801103:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801107:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80110b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80110f:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801116:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  80111d:	00 00 00 
  801120:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  801127:	00 00 00 
  80112a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80112e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801135:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80113c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801143:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80114a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801151:	48 8b 0a             	mov    (%rdx),%rcx
  801154:	48 89 08             	mov    %rcx,(%rax)
  801157:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80115b:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80115f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801163:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801167:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  80116e:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801175:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80117b:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801182:	48 89 c7             	mov    %rax,%rdi
  801185:	48 b8 21 10 80 00 00 	movabs $0x801021,%rax
  80118c:	00 00 00 
  80118f:	ff d0                	callq  *%rax
  801191:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801197:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80119d:	c9                   	leaveq 
  80119e:	c3                   	retq   

000000000080119f <strlen>:
  80119f:	55                   	push   %rbp
  8011a0:	48 89 e5             	mov    %rsp,%rbp
  8011a3:	48 83 ec 18          	sub    $0x18,%rsp
  8011a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011b2:	eb 09                	jmp    8011bd <strlen+0x1e>
  8011b4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8011b8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8011bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011c1:	0f b6 00             	movzbl (%rax),%eax
  8011c4:	84 c0                	test   %al,%al
  8011c6:	75 ec                	jne    8011b4 <strlen+0x15>
  8011c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011cb:	c9                   	leaveq 
  8011cc:	c3                   	retq   

00000000008011cd <strnlen>:
  8011cd:	55                   	push   %rbp
  8011ce:	48 89 e5             	mov    %rsp,%rbp
  8011d1:	48 83 ec 20          	sub    $0x20,%rsp
  8011d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011e4:	eb 0e                	jmp    8011f4 <strnlen+0x27>
  8011e6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8011ea:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8011ef:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8011f4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8011f9:	74 0b                	je     801206 <strnlen+0x39>
  8011fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ff:	0f b6 00             	movzbl (%rax),%eax
  801202:	84 c0                	test   %al,%al
  801204:	75 e0                	jne    8011e6 <strnlen+0x19>
  801206:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801209:	c9                   	leaveq 
  80120a:	c3                   	retq   

000000000080120b <strcpy>:
  80120b:	55                   	push   %rbp
  80120c:	48 89 e5             	mov    %rsp,%rbp
  80120f:	48 83 ec 20          	sub    $0x20,%rsp
  801213:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801217:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80121b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80121f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801223:	90                   	nop
  801224:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801228:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80122c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801230:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801234:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801238:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80123c:	0f b6 12             	movzbl (%rdx),%edx
  80123f:	88 10                	mov    %dl,(%rax)
  801241:	0f b6 00             	movzbl (%rax),%eax
  801244:	84 c0                	test   %al,%al
  801246:	75 dc                	jne    801224 <strcpy+0x19>
  801248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80124c:	c9                   	leaveq 
  80124d:	c3                   	retq   

000000000080124e <strcat>:
  80124e:	55                   	push   %rbp
  80124f:	48 89 e5             	mov    %rsp,%rbp
  801252:	48 83 ec 20          	sub    $0x20,%rsp
  801256:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80125a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80125e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801262:	48 89 c7             	mov    %rax,%rdi
  801265:	48 b8 9f 11 80 00 00 	movabs $0x80119f,%rax
  80126c:	00 00 00 
  80126f:	ff d0                	callq  *%rax
  801271:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801274:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801277:	48 63 d0             	movslq %eax,%rdx
  80127a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80127e:	48 01 c2             	add    %rax,%rdx
  801281:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801285:	48 89 c6             	mov    %rax,%rsi
  801288:	48 89 d7             	mov    %rdx,%rdi
  80128b:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  801292:	00 00 00 
  801295:	ff d0                	callq  *%rax
  801297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80129b:	c9                   	leaveq 
  80129c:	c3                   	retq   

000000000080129d <strncpy>:
  80129d:	55                   	push   %rbp
  80129e:	48 89 e5             	mov    %rsp,%rbp
  8012a1:	48 83 ec 28          	sub    $0x28,%rsp
  8012a5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012a9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8012b9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8012c0:	00 
  8012c1:	eb 2a                	jmp    8012ed <strncpy+0x50>
  8012c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012c7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8012cb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012cf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8012d3:	0f b6 12             	movzbl (%rdx),%edx
  8012d6:	88 10                	mov    %dl,(%rax)
  8012d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012dc:	0f b6 00             	movzbl (%rax),%eax
  8012df:	84 c0                	test   %al,%al
  8012e1:	74 05                	je     8012e8 <strncpy+0x4b>
  8012e3:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8012e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012f1:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8012f5:	72 cc                	jb     8012c3 <strncpy+0x26>
  8012f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012fb:	c9                   	leaveq 
  8012fc:	c3                   	retq   

00000000008012fd <strlcpy>:
  8012fd:	55                   	push   %rbp
  8012fe:	48 89 e5             	mov    %rsp,%rbp
  801301:	48 83 ec 28          	sub    $0x28,%rsp
  801305:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801309:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80130d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801311:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801315:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801319:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80131e:	74 3d                	je     80135d <strlcpy+0x60>
  801320:	eb 1d                	jmp    80133f <strlcpy+0x42>
  801322:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801326:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80132a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80132e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801332:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801336:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80133a:	0f b6 12             	movzbl (%rdx),%edx
  80133d:	88 10                	mov    %dl,(%rax)
  80133f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801344:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801349:	74 0b                	je     801356 <strlcpy+0x59>
  80134b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80134f:	0f b6 00             	movzbl (%rax),%eax
  801352:	84 c0                	test   %al,%al
  801354:	75 cc                	jne    801322 <strlcpy+0x25>
  801356:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80135a:	c6 00 00             	movb   $0x0,(%rax)
  80135d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801361:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801365:	48 29 c2             	sub    %rax,%rdx
  801368:	48 89 d0             	mov    %rdx,%rax
  80136b:	c9                   	leaveq 
  80136c:	c3                   	retq   

000000000080136d <strcmp>:
  80136d:	55                   	push   %rbp
  80136e:	48 89 e5             	mov    %rsp,%rbp
  801371:	48 83 ec 10          	sub    $0x10,%rsp
  801375:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801379:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80137d:	eb 0a                	jmp    801389 <strcmp+0x1c>
  80137f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801384:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801389:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80138d:	0f b6 00             	movzbl (%rax),%eax
  801390:	84 c0                	test   %al,%al
  801392:	74 12                	je     8013a6 <strcmp+0x39>
  801394:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801398:	0f b6 10             	movzbl (%rax),%edx
  80139b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80139f:	0f b6 00             	movzbl (%rax),%eax
  8013a2:	38 c2                	cmp    %al,%dl
  8013a4:	74 d9                	je     80137f <strcmp+0x12>
  8013a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013aa:	0f b6 00             	movzbl (%rax),%eax
  8013ad:	0f b6 d0             	movzbl %al,%edx
  8013b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013b4:	0f b6 00             	movzbl (%rax),%eax
  8013b7:	0f b6 c0             	movzbl %al,%eax
  8013ba:	29 c2                	sub    %eax,%edx
  8013bc:	89 d0                	mov    %edx,%eax
  8013be:	c9                   	leaveq 
  8013bf:	c3                   	retq   

00000000008013c0 <strncmp>:
  8013c0:	55                   	push   %rbp
  8013c1:	48 89 e5             	mov    %rsp,%rbp
  8013c4:	48 83 ec 18          	sub    $0x18,%rsp
  8013c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8013cc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8013d0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013d4:	eb 0f                	jmp    8013e5 <strncmp+0x25>
  8013d6:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8013db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8013e0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8013e5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013ea:	74 1d                	je     801409 <strncmp+0x49>
  8013ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013f0:	0f b6 00             	movzbl (%rax),%eax
  8013f3:	84 c0                	test   %al,%al
  8013f5:	74 12                	je     801409 <strncmp+0x49>
  8013f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013fb:	0f b6 10             	movzbl (%rax),%edx
  8013fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801402:	0f b6 00             	movzbl (%rax),%eax
  801405:	38 c2                	cmp    %al,%dl
  801407:	74 cd                	je     8013d6 <strncmp+0x16>
  801409:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80140e:	75 07                	jne    801417 <strncmp+0x57>
  801410:	b8 00 00 00 00       	mov    $0x0,%eax
  801415:	eb 18                	jmp    80142f <strncmp+0x6f>
  801417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80141b:	0f b6 00             	movzbl (%rax),%eax
  80141e:	0f b6 d0             	movzbl %al,%edx
  801421:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801425:	0f b6 00             	movzbl (%rax),%eax
  801428:	0f b6 c0             	movzbl %al,%eax
  80142b:	29 c2                	sub    %eax,%edx
  80142d:	89 d0                	mov    %edx,%eax
  80142f:	c9                   	leaveq 
  801430:	c3                   	retq   

0000000000801431 <strchr>:
  801431:	55                   	push   %rbp
  801432:	48 89 e5             	mov    %rsp,%rbp
  801435:	48 83 ec 0c          	sub    $0xc,%rsp
  801439:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80143d:	89 f0                	mov    %esi,%eax
  80143f:	88 45 f4             	mov    %al,-0xc(%rbp)
  801442:	eb 17                	jmp    80145b <strchr+0x2a>
  801444:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801448:	0f b6 00             	movzbl (%rax),%eax
  80144b:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80144e:	75 06                	jne    801456 <strchr+0x25>
  801450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801454:	eb 15                	jmp    80146b <strchr+0x3a>
  801456:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80145b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80145f:	0f b6 00             	movzbl (%rax),%eax
  801462:	84 c0                	test   %al,%al
  801464:	75 de                	jne    801444 <strchr+0x13>
  801466:	b8 00 00 00 00       	mov    $0x0,%eax
  80146b:	c9                   	leaveq 
  80146c:	c3                   	retq   

000000000080146d <strfind>:
  80146d:	55                   	push   %rbp
  80146e:	48 89 e5             	mov    %rsp,%rbp
  801471:	48 83 ec 0c          	sub    $0xc,%rsp
  801475:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801479:	89 f0                	mov    %esi,%eax
  80147b:	88 45 f4             	mov    %al,-0xc(%rbp)
  80147e:	eb 13                	jmp    801493 <strfind+0x26>
  801480:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801484:	0f b6 00             	movzbl (%rax),%eax
  801487:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80148a:	75 02                	jne    80148e <strfind+0x21>
  80148c:	eb 10                	jmp    80149e <strfind+0x31>
  80148e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801493:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801497:	0f b6 00             	movzbl (%rax),%eax
  80149a:	84 c0                	test   %al,%al
  80149c:	75 e2                	jne    801480 <strfind+0x13>
  80149e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014a2:	c9                   	leaveq 
  8014a3:	c3                   	retq   

00000000008014a4 <memset>:
  8014a4:	55                   	push   %rbp
  8014a5:	48 89 e5             	mov    %rsp,%rbp
  8014a8:	48 83 ec 18          	sub    $0x18,%rsp
  8014ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014b0:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8014b3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014b7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8014bc:	75 06                	jne    8014c4 <memset+0x20>
  8014be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014c2:	eb 69                	jmp    80152d <memset+0x89>
  8014c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014c8:	83 e0 03             	and    $0x3,%eax
  8014cb:	48 85 c0             	test   %rax,%rax
  8014ce:	75 48                	jne    801518 <memset+0x74>
  8014d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014d4:	83 e0 03             	and    $0x3,%eax
  8014d7:	48 85 c0             	test   %rax,%rax
  8014da:	75 3c                	jne    801518 <memset+0x74>
  8014dc:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8014e3:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014e6:	c1 e0 18             	shl    $0x18,%eax
  8014e9:	89 c2                	mov    %eax,%edx
  8014eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014ee:	c1 e0 10             	shl    $0x10,%eax
  8014f1:	09 c2                	or     %eax,%edx
  8014f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014f6:	c1 e0 08             	shl    $0x8,%eax
  8014f9:	09 d0                	or     %edx,%eax
  8014fb:	09 45 f4             	or     %eax,-0xc(%rbp)
  8014fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801502:	48 c1 e8 02          	shr    $0x2,%rax
  801506:	48 89 c1             	mov    %rax,%rcx
  801509:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80150d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801510:	48 89 d7             	mov    %rdx,%rdi
  801513:	fc                   	cld    
  801514:	f3 ab                	rep stos %eax,%es:(%rdi)
  801516:	eb 11                	jmp    801529 <memset+0x85>
  801518:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80151c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80151f:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801523:	48 89 d7             	mov    %rdx,%rdi
  801526:	fc                   	cld    
  801527:	f3 aa                	rep stos %al,%es:(%rdi)
  801529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80152d:	c9                   	leaveq 
  80152e:	c3                   	retq   

000000000080152f <memmove>:
  80152f:	55                   	push   %rbp
  801530:	48 89 e5             	mov    %rsp,%rbp
  801533:	48 83 ec 28          	sub    $0x28,%rsp
  801537:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80153b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80153f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801543:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801547:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80154b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80154f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801557:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80155b:	0f 83 88 00 00 00    	jae    8015e9 <memmove+0xba>
  801561:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801565:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801569:	48 01 d0             	add    %rdx,%rax
  80156c:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801570:	76 77                	jbe    8015e9 <memmove+0xba>
  801572:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801576:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80157a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80157e:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801582:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801586:	83 e0 03             	and    $0x3,%eax
  801589:	48 85 c0             	test   %rax,%rax
  80158c:	75 3b                	jne    8015c9 <memmove+0x9a>
  80158e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801592:	83 e0 03             	and    $0x3,%eax
  801595:	48 85 c0             	test   %rax,%rax
  801598:	75 2f                	jne    8015c9 <memmove+0x9a>
  80159a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80159e:	83 e0 03             	and    $0x3,%eax
  8015a1:	48 85 c0             	test   %rax,%rax
  8015a4:	75 23                	jne    8015c9 <memmove+0x9a>
  8015a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015aa:	48 83 e8 04          	sub    $0x4,%rax
  8015ae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015b2:	48 83 ea 04          	sub    $0x4,%rdx
  8015b6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8015ba:	48 c1 e9 02          	shr    $0x2,%rcx
  8015be:	48 89 c7             	mov    %rax,%rdi
  8015c1:	48 89 d6             	mov    %rdx,%rsi
  8015c4:	fd                   	std    
  8015c5:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8015c7:	eb 1d                	jmp    8015e6 <memmove+0xb7>
  8015c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015cd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8015d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015d5:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8015d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015dd:	48 89 d7             	mov    %rdx,%rdi
  8015e0:	48 89 c1             	mov    %rax,%rcx
  8015e3:	fd                   	std    
  8015e4:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8015e6:	fc                   	cld    
  8015e7:	eb 57                	jmp    801640 <memmove+0x111>
  8015e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015ed:	83 e0 03             	and    $0x3,%eax
  8015f0:	48 85 c0             	test   %rax,%rax
  8015f3:	75 36                	jne    80162b <memmove+0xfc>
  8015f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015f9:	83 e0 03             	and    $0x3,%eax
  8015fc:	48 85 c0             	test   %rax,%rax
  8015ff:	75 2a                	jne    80162b <memmove+0xfc>
  801601:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801605:	83 e0 03             	and    $0x3,%eax
  801608:	48 85 c0             	test   %rax,%rax
  80160b:	75 1e                	jne    80162b <memmove+0xfc>
  80160d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801611:	48 c1 e8 02          	shr    $0x2,%rax
  801615:	48 89 c1             	mov    %rax,%rcx
  801618:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80161c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801620:	48 89 c7             	mov    %rax,%rdi
  801623:	48 89 d6             	mov    %rdx,%rsi
  801626:	fc                   	cld    
  801627:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801629:	eb 15                	jmp    801640 <memmove+0x111>
  80162b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80162f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801633:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801637:	48 89 c7             	mov    %rax,%rdi
  80163a:	48 89 d6             	mov    %rdx,%rsi
  80163d:	fc                   	cld    
  80163e:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801640:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801644:	c9                   	leaveq 
  801645:	c3                   	retq   

0000000000801646 <memcpy>:
  801646:	55                   	push   %rbp
  801647:	48 89 e5             	mov    %rsp,%rbp
  80164a:	48 83 ec 18          	sub    $0x18,%rsp
  80164e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801652:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801656:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80165a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80165e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801662:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801666:	48 89 ce             	mov    %rcx,%rsi
  801669:	48 89 c7             	mov    %rax,%rdi
  80166c:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  801673:	00 00 00 
  801676:	ff d0                	callq  *%rax
  801678:	c9                   	leaveq 
  801679:	c3                   	retq   

000000000080167a <memcmp>:
  80167a:	55                   	push   %rbp
  80167b:	48 89 e5             	mov    %rsp,%rbp
  80167e:	48 83 ec 28          	sub    $0x28,%rsp
  801682:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801686:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80168a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80168e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801692:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801696:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80169a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80169e:	eb 36                	jmp    8016d6 <memcmp+0x5c>
  8016a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016a4:	0f b6 10             	movzbl (%rax),%edx
  8016a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016ab:	0f b6 00             	movzbl (%rax),%eax
  8016ae:	38 c2                	cmp    %al,%dl
  8016b0:	74 1a                	je     8016cc <memcmp+0x52>
  8016b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016b6:	0f b6 00             	movzbl (%rax),%eax
  8016b9:	0f b6 d0             	movzbl %al,%edx
  8016bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016c0:	0f b6 00             	movzbl (%rax),%eax
  8016c3:	0f b6 c0             	movzbl %al,%eax
  8016c6:	29 c2                	sub    %eax,%edx
  8016c8:	89 d0                	mov    %edx,%eax
  8016ca:	eb 20                	jmp    8016ec <memcmp+0x72>
  8016cc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016d1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8016d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016da:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8016de:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016e2:	48 85 c0             	test   %rax,%rax
  8016e5:	75 b9                	jne    8016a0 <memcmp+0x26>
  8016e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8016ec:	c9                   	leaveq 
  8016ed:	c3                   	retq   

00000000008016ee <memfind>:
  8016ee:	55                   	push   %rbp
  8016ef:	48 89 e5             	mov    %rsp,%rbp
  8016f2:	48 83 ec 28          	sub    $0x28,%rsp
  8016f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8016fa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8016fd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801701:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801705:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801709:	48 01 d0             	add    %rdx,%rax
  80170c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801710:	eb 15                	jmp    801727 <memfind+0x39>
  801712:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801716:	0f b6 10             	movzbl (%rax),%edx
  801719:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80171c:	38 c2                	cmp    %al,%dl
  80171e:	75 02                	jne    801722 <memfind+0x34>
  801720:	eb 0f                	jmp    801731 <memfind+0x43>
  801722:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801727:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80172b:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  80172f:	72 e1                	jb     801712 <memfind+0x24>
  801731:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801735:	c9                   	leaveq 
  801736:	c3                   	retq   

0000000000801737 <strtol>:
  801737:	55                   	push   %rbp
  801738:	48 89 e5             	mov    %rsp,%rbp
  80173b:	48 83 ec 34          	sub    $0x34,%rsp
  80173f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801743:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801747:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80174a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801751:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801758:	00 
  801759:	eb 05                	jmp    801760 <strtol+0x29>
  80175b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801760:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801764:	0f b6 00             	movzbl (%rax),%eax
  801767:	3c 20                	cmp    $0x20,%al
  801769:	74 f0                	je     80175b <strtol+0x24>
  80176b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80176f:	0f b6 00             	movzbl (%rax),%eax
  801772:	3c 09                	cmp    $0x9,%al
  801774:	74 e5                	je     80175b <strtol+0x24>
  801776:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80177a:	0f b6 00             	movzbl (%rax),%eax
  80177d:	3c 2b                	cmp    $0x2b,%al
  80177f:	75 07                	jne    801788 <strtol+0x51>
  801781:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801786:	eb 17                	jmp    80179f <strtol+0x68>
  801788:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80178c:	0f b6 00             	movzbl (%rax),%eax
  80178f:	3c 2d                	cmp    $0x2d,%al
  801791:	75 0c                	jne    80179f <strtol+0x68>
  801793:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801798:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80179f:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017a3:	74 06                	je     8017ab <strtol+0x74>
  8017a5:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8017a9:	75 28                	jne    8017d3 <strtol+0x9c>
  8017ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017af:	0f b6 00             	movzbl (%rax),%eax
  8017b2:	3c 30                	cmp    $0x30,%al
  8017b4:	75 1d                	jne    8017d3 <strtol+0x9c>
  8017b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ba:	48 83 c0 01          	add    $0x1,%rax
  8017be:	0f b6 00             	movzbl (%rax),%eax
  8017c1:	3c 78                	cmp    $0x78,%al
  8017c3:	75 0e                	jne    8017d3 <strtol+0x9c>
  8017c5:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8017ca:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8017d1:	eb 2c                	jmp    8017ff <strtol+0xc8>
  8017d3:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017d7:	75 19                	jne    8017f2 <strtol+0xbb>
  8017d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017dd:	0f b6 00             	movzbl (%rax),%eax
  8017e0:	3c 30                	cmp    $0x30,%al
  8017e2:	75 0e                	jne    8017f2 <strtol+0xbb>
  8017e4:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8017e9:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8017f0:	eb 0d                	jmp    8017ff <strtol+0xc8>
  8017f2:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017f6:	75 07                	jne    8017ff <strtol+0xc8>
  8017f8:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8017ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801803:	0f b6 00             	movzbl (%rax),%eax
  801806:	3c 2f                	cmp    $0x2f,%al
  801808:	7e 1d                	jle    801827 <strtol+0xf0>
  80180a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80180e:	0f b6 00             	movzbl (%rax),%eax
  801811:	3c 39                	cmp    $0x39,%al
  801813:	7f 12                	jg     801827 <strtol+0xf0>
  801815:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801819:	0f b6 00             	movzbl (%rax),%eax
  80181c:	0f be c0             	movsbl %al,%eax
  80181f:	83 e8 30             	sub    $0x30,%eax
  801822:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801825:	eb 4e                	jmp    801875 <strtol+0x13e>
  801827:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80182b:	0f b6 00             	movzbl (%rax),%eax
  80182e:	3c 60                	cmp    $0x60,%al
  801830:	7e 1d                	jle    80184f <strtol+0x118>
  801832:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801836:	0f b6 00             	movzbl (%rax),%eax
  801839:	3c 7a                	cmp    $0x7a,%al
  80183b:	7f 12                	jg     80184f <strtol+0x118>
  80183d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801841:	0f b6 00             	movzbl (%rax),%eax
  801844:	0f be c0             	movsbl %al,%eax
  801847:	83 e8 57             	sub    $0x57,%eax
  80184a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80184d:	eb 26                	jmp    801875 <strtol+0x13e>
  80184f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801853:	0f b6 00             	movzbl (%rax),%eax
  801856:	3c 40                	cmp    $0x40,%al
  801858:	7e 48                	jle    8018a2 <strtol+0x16b>
  80185a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80185e:	0f b6 00             	movzbl (%rax),%eax
  801861:	3c 5a                	cmp    $0x5a,%al
  801863:	7f 3d                	jg     8018a2 <strtol+0x16b>
  801865:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801869:	0f b6 00             	movzbl (%rax),%eax
  80186c:	0f be c0             	movsbl %al,%eax
  80186f:	83 e8 37             	sub    $0x37,%eax
  801872:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801875:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801878:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  80187b:	7c 02                	jl     80187f <strtol+0x148>
  80187d:	eb 23                	jmp    8018a2 <strtol+0x16b>
  80187f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801884:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801887:	48 98                	cltq   
  801889:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  80188e:	48 89 c2             	mov    %rax,%rdx
  801891:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801894:	48 98                	cltq   
  801896:	48 01 d0             	add    %rdx,%rax
  801899:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80189d:	e9 5d ff ff ff       	jmpq   8017ff <strtol+0xc8>
  8018a2:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8018a7:	74 0b                	je     8018b4 <strtol+0x17d>
  8018a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018ad:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8018b1:	48 89 10             	mov    %rdx,(%rax)
  8018b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8018b8:	74 09                	je     8018c3 <strtol+0x18c>
  8018ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018be:	48 f7 d8             	neg    %rax
  8018c1:	eb 04                	jmp    8018c7 <strtol+0x190>
  8018c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018c7:	c9                   	leaveq 
  8018c8:	c3                   	retq   

00000000008018c9 <strstr>:
  8018c9:	55                   	push   %rbp
  8018ca:	48 89 e5             	mov    %rsp,%rbp
  8018cd:	48 83 ec 30          	sub    $0x30,%rsp
  8018d1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8018d5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8018d9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8018e1:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8018e5:	0f b6 00             	movzbl (%rax),%eax
  8018e8:	88 45 ff             	mov    %al,-0x1(%rbp)
  8018eb:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8018ef:	75 06                	jne    8018f7 <strstr+0x2e>
  8018f1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018f5:	eb 6b                	jmp    801962 <strstr+0x99>
  8018f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018fb:	48 89 c7             	mov    %rax,%rdi
  8018fe:	48 b8 9f 11 80 00 00 	movabs $0x80119f,%rax
  801905:	00 00 00 
  801908:	ff d0                	callq  *%rax
  80190a:	48 98                	cltq   
  80190c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801910:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801914:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801918:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80191c:	0f b6 00             	movzbl (%rax),%eax
  80191f:	88 45 ef             	mov    %al,-0x11(%rbp)
  801922:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801926:	75 07                	jne    80192f <strstr+0x66>
  801928:	b8 00 00 00 00       	mov    $0x0,%eax
  80192d:	eb 33                	jmp    801962 <strstr+0x99>
  80192f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801933:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801936:	75 d8                	jne    801910 <strstr+0x47>
  801938:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80193c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801940:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801944:	48 89 ce             	mov    %rcx,%rsi
  801947:	48 89 c7             	mov    %rax,%rdi
  80194a:	48 b8 c0 13 80 00 00 	movabs $0x8013c0,%rax
  801951:	00 00 00 
  801954:	ff d0                	callq  *%rax
  801956:	85 c0                	test   %eax,%eax
  801958:	75 b6                	jne    801910 <strstr+0x47>
  80195a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80195e:	48 83 e8 01          	sub    $0x1,%rax
  801962:	c9                   	leaveq 
  801963:	c3                   	retq   

0000000000801964 <syscall>:
  801964:	55                   	push   %rbp
  801965:	48 89 e5             	mov    %rsp,%rbp
  801968:	53                   	push   %rbx
  801969:	48 83 ec 48          	sub    $0x48,%rsp
  80196d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801970:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801973:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801977:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80197b:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80197f:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801983:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801986:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80198a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  80198e:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801992:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801996:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  80199a:	4c 89 c3             	mov    %r8,%rbx
  80199d:	cd 30                	int    $0x30
  80199f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8019a3:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8019a7:	74 3e                	je     8019e7 <syscall+0x83>
  8019a9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8019ae:	7e 37                	jle    8019e7 <syscall+0x83>
  8019b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8019b4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8019b7:	49 89 d0             	mov    %rdx,%r8
  8019ba:	89 c1                	mov    %eax,%ecx
  8019bc:	48 ba 88 48 80 00 00 	movabs $0x804888,%rdx
  8019c3:	00 00 00 
  8019c6:	be 24 00 00 00       	mov    $0x24,%esi
  8019cb:	48 bf a5 48 80 00 00 	movabs $0x8048a5,%rdi
  8019d2:	00 00 00 
  8019d5:	b8 00 00 00 00       	mov    $0x0,%eax
  8019da:	49 b9 1d 04 80 00 00 	movabs $0x80041d,%r9
  8019e1:	00 00 00 
  8019e4:	41 ff d1             	callq  *%r9
  8019e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019eb:	48 83 c4 48          	add    $0x48,%rsp
  8019ef:	5b                   	pop    %rbx
  8019f0:	5d                   	pop    %rbp
  8019f1:	c3                   	retq   

00000000008019f2 <sys_cputs>:
  8019f2:	55                   	push   %rbp
  8019f3:	48 89 e5             	mov    %rsp,%rbp
  8019f6:	48 83 ec 20          	sub    $0x20,%rsp
  8019fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8019fe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a06:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a0a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a11:	00 
  801a12:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a18:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a1e:	48 89 d1             	mov    %rdx,%rcx
  801a21:	48 89 c2             	mov    %rax,%rdx
  801a24:	be 00 00 00 00       	mov    $0x0,%esi
  801a29:	bf 00 00 00 00       	mov    $0x0,%edi
  801a2e:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801a35:	00 00 00 
  801a38:	ff d0                	callq  *%rax
  801a3a:	c9                   	leaveq 
  801a3b:	c3                   	retq   

0000000000801a3c <sys_cgetc>:
  801a3c:	55                   	push   %rbp
  801a3d:	48 89 e5             	mov    %rsp,%rbp
  801a40:	48 83 ec 10          	sub    $0x10,%rsp
  801a44:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a4b:	00 
  801a4c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a52:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a58:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a5d:	ba 00 00 00 00       	mov    $0x0,%edx
  801a62:	be 00 00 00 00       	mov    $0x0,%esi
  801a67:	bf 01 00 00 00       	mov    $0x1,%edi
  801a6c:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801a73:	00 00 00 
  801a76:	ff d0                	callq  *%rax
  801a78:	c9                   	leaveq 
  801a79:	c3                   	retq   

0000000000801a7a <sys_env_destroy>:
  801a7a:	55                   	push   %rbp
  801a7b:	48 89 e5             	mov    %rsp,%rbp
  801a7e:	48 83 ec 10          	sub    $0x10,%rsp
  801a82:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a85:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a88:	48 98                	cltq   
  801a8a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a91:	00 
  801a92:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a98:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a9e:	b9 00 00 00 00       	mov    $0x0,%ecx
  801aa3:	48 89 c2             	mov    %rax,%rdx
  801aa6:	be 01 00 00 00       	mov    $0x1,%esi
  801aab:	bf 03 00 00 00       	mov    $0x3,%edi
  801ab0:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801ab7:	00 00 00 
  801aba:	ff d0                	callq  *%rax
  801abc:	c9                   	leaveq 
  801abd:	c3                   	retq   

0000000000801abe <sys_getenvid>:
  801abe:	55                   	push   %rbp
  801abf:	48 89 e5             	mov    %rsp,%rbp
  801ac2:	48 83 ec 10          	sub    $0x10,%rsp
  801ac6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801acd:	00 
  801ace:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ad4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ada:	b9 00 00 00 00       	mov    $0x0,%ecx
  801adf:	ba 00 00 00 00       	mov    $0x0,%edx
  801ae4:	be 00 00 00 00       	mov    $0x0,%esi
  801ae9:	bf 02 00 00 00       	mov    $0x2,%edi
  801aee:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801af5:	00 00 00 
  801af8:	ff d0                	callq  *%rax
  801afa:	c9                   	leaveq 
  801afb:	c3                   	retq   

0000000000801afc <sys_yield>:
  801afc:	55                   	push   %rbp
  801afd:	48 89 e5             	mov    %rsp,%rbp
  801b00:	48 83 ec 10          	sub    $0x10,%rsp
  801b04:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b0b:	00 
  801b0c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b12:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b18:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b1d:	ba 00 00 00 00       	mov    $0x0,%edx
  801b22:	be 00 00 00 00       	mov    $0x0,%esi
  801b27:	bf 0b 00 00 00       	mov    $0xb,%edi
  801b2c:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801b33:	00 00 00 
  801b36:	ff d0                	callq  *%rax
  801b38:	c9                   	leaveq 
  801b39:	c3                   	retq   

0000000000801b3a <sys_page_alloc>:
  801b3a:	55                   	push   %rbp
  801b3b:	48 89 e5             	mov    %rsp,%rbp
  801b3e:	48 83 ec 20          	sub    $0x20,%rsp
  801b42:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b45:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b49:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b4c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b4f:	48 63 c8             	movslq %eax,%rcx
  801b52:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b56:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b59:	48 98                	cltq   
  801b5b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b62:	00 
  801b63:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b69:	49 89 c8             	mov    %rcx,%r8
  801b6c:	48 89 d1             	mov    %rdx,%rcx
  801b6f:	48 89 c2             	mov    %rax,%rdx
  801b72:	be 01 00 00 00       	mov    $0x1,%esi
  801b77:	bf 04 00 00 00       	mov    $0x4,%edi
  801b7c:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801b83:	00 00 00 
  801b86:	ff d0                	callq  *%rax
  801b88:	c9                   	leaveq 
  801b89:	c3                   	retq   

0000000000801b8a <sys_page_map>:
  801b8a:	55                   	push   %rbp
  801b8b:	48 89 e5             	mov    %rsp,%rbp
  801b8e:	48 83 ec 30          	sub    $0x30,%rsp
  801b92:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b95:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b99:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b9c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801ba0:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801ba4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801ba7:	48 63 c8             	movslq %eax,%rcx
  801baa:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801bae:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bb1:	48 63 f0             	movslq %eax,%rsi
  801bb4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bbb:	48 98                	cltq   
  801bbd:	48 89 0c 24          	mov    %rcx,(%rsp)
  801bc1:	49 89 f9             	mov    %rdi,%r9
  801bc4:	49 89 f0             	mov    %rsi,%r8
  801bc7:	48 89 d1             	mov    %rdx,%rcx
  801bca:	48 89 c2             	mov    %rax,%rdx
  801bcd:	be 01 00 00 00       	mov    $0x1,%esi
  801bd2:	bf 05 00 00 00       	mov    $0x5,%edi
  801bd7:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801bde:	00 00 00 
  801be1:	ff d0                	callq  *%rax
  801be3:	c9                   	leaveq 
  801be4:	c3                   	retq   

0000000000801be5 <sys_page_unmap>:
  801be5:	55                   	push   %rbp
  801be6:	48 89 e5             	mov    %rsp,%rbp
  801be9:	48 83 ec 20          	sub    $0x20,%rsp
  801bed:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bf0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bf4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bf8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bfb:	48 98                	cltq   
  801bfd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c04:	00 
  801c05:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c0b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c11:	48 89 d1             	mov    %rdx,%rcx
  801c14:	48 89 c2             	mov    %rax,%rdx
  801c17:	be 01 00 00 00       	mov    $0x1,%esi
  801c1c:	bf 06 00 00 00       	mov    $0x6,%edi
  801c21:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801c28:	00 00 00 
  801c2b:	ff d0                	callq  *%rax
  801c2d:	c9                   	leaveq 
  801c2e:	c3                   	retq   

0000000000801c2f <sys_env_set_status>:
  801c2f:	55                   	push   %rbp
  801c30:	48 89 e5             	mov    %rsp,%rbp
  801c33:	48 83 ec 10          	sub    $0x10,%rsp
  801c37:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c3a:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801c3d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c40:	48 63 d0             	movslq %eax,%rdx
  801c43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c46:	48 98                	cltq   
  801c48:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c4f:	00 
  801c50:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c56:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c5c:	48 89 d1             	mov    %rdx,%rcx
  801c5f:	48 89 c2             	mov    %rax,%rdx
  801c62:	be 01 00 00 00       	mov    $0x1,%esi
  801c67:	bf 08 00 00 00       	mov    $0x8,%edi
  801c6c:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801c73:	00 00 00 
  801c76:	ff d0                	callq  *%rax
  801c78:	c9                   	leaveq 
  801c79:	c3                   	retq   

0000000000801c7a <sys_env_set_trapframe>:
  801c7a:	55                   	push   %rbp
  801c7b:	48 89 e5             	mov    %rsp,%rbp
  801c7e:	48 83 ec 20          	sub    $0x20,%rsp
  801c82:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c85:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c89:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c90:	48 98                	cltq   
  801c92:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c99:	00 
  801c9a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ca0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ca6:	48 89 d1             	mov    %rdx,%rcx
  801ca9:	48 89 c2             	mov    %rax,%rdx
  801cac:	be 01 00 00 00       	mov    $0x1,%esi
  801cb1:	bf 09 00 00 00       	mov    $0x9,%edi
  801cb6:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801cbd:	00 00 00 
  801cc0:	ff d0                	callq  *%rax
  801cc2:	c9                   	leaveq 
  801cc3:	c3                   	retq   

0000000000801cc4 <sys_env_set_pgfault_upcall>:
  801cc4:	55                   	push   %rbp
  801cc5:	48 89 e5             	mov    %rsp,%rbp
  801cc8:	48 83 ec 20          	sub    $0x20,%rsp
  801ccc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ccf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801cd3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801cd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cda:	48 98                	cltq   
  801cdc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ce3:	00 
  801ce4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cea:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cf0:	48 89 d1             	mov    %rdx,%rcx
  801cf3:	48 89 c2             	mov    %rax,%rdx
  801cf6:	be 01 00 00 00       	mov    $0x1,%esi
  801cfb:	bf 0a 00 00 00       	mov    $0xa,%edi
  801d00:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801d07:	00 00 00 
  801d0a:	ff d0                	callq  *%rax
  801d0c:	c9                   	leaveq 
  801d0d:	c3                   	retq   

0000000000801d0e <sys_ipc_try_send>:
  801d0e:	55                   	push   %rbp
  801d0f:	48 89 e5             	mov    %rsp,%rbp
  801d12:	48 83 ec 20          	sub    $0x20,%rsp
  801d16:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d19:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d1d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801d21:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801d24:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d27:	48 63 f0             	movslq %eax,%rsi
  801d2a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801d2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d31:	48 98                	cltq   
  801d33:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d37:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d3e:	00 
  801d3f:	49 89 f1             	mov    %rsi,%r9
  801d42:	49 89 c8             	mov    %rcx,%r8
  801d45:	48 89 d1             	mov    %rdx,%rcx
  801d48:	48 89 c2             	mov    %rax,%rdx
  801d4b:	be 00 00 00 00       	mov    $0x0,%esi
  801d50:	bf 0c 00 00 00       	mov    $0xc,%edi
  801d55:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801d5c:	00 00 00 
  801d5f:	ff d0                	callq  *%rax
  801d61:	c9                   	leaveq 
  801d62:	c3                   	retq   

0000000000801d63 <sys_ipc_recv>:
  801d63:	55                   	push   %rbp
  801d64:	48 89 e5             	mov    %rsp,%rbp
  801d67:	48 83 ec 10          	sub    $0x10,%rsp
  801d6b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d73:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d7a:	00 
  801d7b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d81:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d87:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d8c:	48 89 c2             	mov    %rax,%rdx
  801d8f:	be 01 00 00 00       	mov    $0x1,%esi
  801d94:	bf 0d 00 00 00       	mov    $0xd,%edi
  801d99:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801da0:	00 00 00 
  801da3:	ff d0                	callq  *%rax
  801da5:	c9                   	leaveq 
  801da6:	c3                   	retq   

0000000000801da7 <sys_time_msec>:
  801da7:	55                   	push   %rbp
  801da8:	48 89 e5             	mov    %rsp,%rbp
  801dab:	48 83 ec 10          	sub    $0x10,%rsp
  801daf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801db6:	00 
  801db7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dbd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dc3:	b9 00 00 00 00       	mov    $0x0,%ecx
  801dc8:	ba 00 00 00 00       	mov    $0x0,%edx
  801dcd:	be 00 00 00 00       	mov    $0x0,%esi
  801dd2:	bf 0e 00 00 00       	mov    $0xe,%edi
  801dd7:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801dde:	00 00 00 
  801de1:	ff d0                	callq  *%rax
  801de3:	c9                   	leaveq 
  801de4:	c3                   	retq   

0000000000801de5 <sys_net_transmit>:
  801de5:	55                   	push   %rbp
  801de6:	48 89 e5             	mov    %rsp,%rbp
  801de9:	48 83 ec 20          	sub    $0x20,%rsp
  801ded:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801df1:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801df4:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dfb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e02:	00 
  801e03:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e09:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e0f:	48 89 d1             	mov    %rdx,%rcx
  801e12:	48 89 c2             	mov    %rax,%rdx
  801e15:	be 00 00 00 00       	mov    $0x0,%esi
  801e1a:	bf 0f 00 00 00       	mov    $0xf,%edi
  801e1f:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801e26:	00 00 00 
  801e29:	ff d0                	callq  *%rax
  801e2b:	c9                   	leaveq 
  801e2c:	c3                   	retq   

0000000000801e2d <sys_net_receive>:
  801e2d:	55                   	push   %rbp
  801e2e:	48 89 e5             	mov    %rsp,%rbp
  801e31:	48 83 ec 20          	sub    $0x20,%rsp
  801e35:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e39:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801e3c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e43:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e4a:	00 
  801e4b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e51:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e57:	48 89 d1             	mov    %rdx,%rcx
  801e5a:	48 89 c2             	mov    %rax,%rdx
  801e5d:	be 00 00 00 00       	mov    $0x0,%esi
  801e62:	bf 10 00 00 00       	mov    $0x10,%edi
  801e67:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801e6e:	00 00 00 
  801e71:	ff d0                	callq  *%rax
  801e73:	c9                   	leaveq 
  801e74:	c3                   	retq   

0000000000801e75 <sys_ept_map>:
  801e75:	55                   	push   %rbp
  801e76:	48 89 e5             	mov    %rsp,%rbp
  801e79:	48 83 ec 30          	sub    $0x30,%rsp
  801e7d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e80:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e84:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e87:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801e8b:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801e8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801e92:	48 63 c8             	movslq %eax,%rcx
  801e95:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801e99:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e9c:	48 63 f0             	movslq %eax,%rsi
  801e9f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ea3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ea6:	48 98                	cltq   
  801ea8:	48 89 0c 24          	mov    %rcx,(%rsp)
  801eac:	49 89 f9             	mov    %rdi,%r9
  801eaf:	49 89 f0             	mov    %rsi,%r8
  801eb2:	48 89 d1             	mov    %rdx,%rcx
  801eb5:	48 89 c2             	mov    %rax,%rdx
  801eb8:	be 00 00 00 00       	mov    $0x0,%esi
  801ebd:	bf 11 00 00 00       	mov    $0x11,%edi
  801ec2:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801ec9:	00 00 00 
  801ecc:	ff d0                	callq  *%rax
  801ece:	c9                   	leaveq 
  801ecf:	c3                   	retq   

0000000000801ed0 <sys_env_mkguest>:
  801ed0:	55                   	push   %rbp
  801ed1:	48 89 e5             	mov    %rsp,%rbp
  801ed4:	48 83 ec 20          	sub    $0x20,%rsp
  801ed8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801edc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ee0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ee4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ee8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801eef:	00 
  801ef0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ef6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801efc:	48 89 d1             	mov    %rdx,%rcx
  801eff:	48 89 c2             	mov    %rax,%rdx
  801f02:	be 00 00 00 00       	mov    $0x0,%esi
  801f07:	bf 12 00 00 00       	mov    $0x12,%edi
  801f0c:	48 b8 64 19 80 00 00 	movabs $0x801964,%rax
  801f13:	00 00 00 
  801f16:	ff d0                	callq  *%rax
  801f18:	c9                   	leaveq 
  801f19:	c3                   	retq   

0000000000801f1a <fd2num>:
  801f1a:	55                   	push   %rbp
  801f1b:	48 89 e5             	mov    %rsp,%rbp
  801f1e:	48 83 ec 08          	sub    $0x8,%rsp
  801f22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f26:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f2a:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801f31:	ff ff ff 
  801f34:	48 01 d0             	add    %rdx,%rax
  801f37:	48 c1 e8 0c          	shr    $0xc,%rax
  801f3b:	c9                   	leaveq 
  801f3c:	c3                   	retq   

0000000000801f3d <fd2data>:
  801f3d:	55                   	push   %rbp
  801f3e:	48 89 e5             	mov    %rsp,%rbp
  801f41:	48 83 ec 08          	sub    $0x8,%rsp
  801f45:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f4d:	48 89 c7             	mov    %rax,%rdi
  801f50:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  801f57:	00 00 00 
  801f5a:	ff d0                	callq  *%rax
  801f5c:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801f62:	48 c1 e0 0c          	shl    $0xc,%rax
  801f66:	c9                   	leaveq 
  801f67:	c3                   	retq   

0000000000801f68 <fd_alloc>:
  801f68:	55                   	push   %rbp
  801f69:	48 89 e5             	mov    %rsp,%rbp
  801f6c:	48 83 ec 18          	sub    $0x18,%rsp
  801f70:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801f74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801f7b:	eb 6b                	jmp    801fe8 <fd_alloc+0x80>
  801f7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f80:	48 98                	cltq   
  801f82:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801f88:	48 c1 e0 0c          	shl    $0xc,%rax
  801f8c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801f90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f94:	48 c1 e8 15          	shr    $0x15,%rax
  801f98:	48 89 c2             	mov    %rax,%rdx
  801f9b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801fa2:	01 00 00 
  801fa5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fa9:	83 e0 01             	and    $0x1,%eax
  801fac:	48 85 c0             	test   %rax,%rax
  801faf:	74 21                	je     801fd2 <fd_alloc+0x6a>
  801fb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fb5:	48 c1 e8 0c          	shr    $0xc,%rax
  801fb9:	48 89 c2             	mov    %rax,%rdx
  801fbc:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801fc3:	01 00 00 
  801fc6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801fca:	83 e0 01             	and    $0x1,%eax
  801fcd:	48 85 c0             	test   %rax,%rax
  801fd0:	75 12                	jne    801fe4 <fd_alloc+0x7c>
  801fd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801fd6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801fda:	48 89 10             	mov    %rdx,(%rax)
  801fdd:	b8 00 00 00 00       	mov    $0x0,%eax
  801fe2:	eb 1a                	jmp    801ffe <fd_alloc+0x96>
  801fe4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801fe8:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801fec:	7e 8f                	jle    801f7d <fd_alloc+0x15>
  801fee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ff2:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801ff9:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801ffe:	c9                   	leaveq 
  801fff:	c3                   	retq   

0000000000802000 <fd_lookup>:
  802000:	55                   	push   %rbp
  802001:	48 89 e5             	mov    %rsp,%rbp
  802004:	48 83 ec 20          	sub    $0x20,%rsp
  802008:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80200b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80200f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802013:	78 06                	js     80201b <fd_lookup+0x1b>
  802015:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802019:	7e 07                	jle    802022 <fd_lookup+0x22>
  80201b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802020:	eb 6c                	jmp    80208e <fd_lookup+0x8e>
  802022:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802025:	48 98                	cltq   
  802027:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80202d:	48 c1 e0 0c          	shl    $0xc,%rax
  802031:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802035:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802039:	48 c1 e8 15          	shr    $0x15,%rax
  80203d:	48 89 c2             	mov    %rax,%rdx
  802040:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802047:	01 00 00 
  80204a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80204e:	83 e0 01             	and    $0x1,%eax
  802051:	48 85 c0             	test   %rax,%rax
  802054:	74 21                	je     802077 <fd_lookup+0x77>
  802056:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80205a:	48 c1 e8 0c          	shr    $0xc,%rax
  80205e:	48 89 c2             	mov    %rax,%rdx
  802061:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802068:	01 00 00 
  80206b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80206f:	83 e0 01             	and    $0x1,%eax
  802072:	48 85 c0             	test   %rax,%rax
  802075:	75 07                	jne    80207e <fd_lookup+0x7e>
  802077:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80207c:	eb 10                	jmp    80208e <fd_lookup+0x8e>
  80207e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802082:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802086:	48 89 10             	mov    %rdx,(%rax)
  802089:	b8 00 00 00 00       	mov    $0x0,%eax
  80208e:	c9                   	leaveq 
  80208f:	c3                   	retq   

0000000000802090 <fd_close>:
  802090:	55                   	push   %rbp
  802091:	48 89 e5             	mov    %rsp,%rbp
  802094:	48 83 ec 30          	sub    $0x30,%rsp
  802098:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80209c:	89 f0                	mov    %esi,%eax
  80209e:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8020a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020a5:	48 89 c7             	mov    %rax,%rdi
  8020a8:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  8020af:	00 00 00 
  8020b2:	ff d0                	callq  *%rax
  8020b4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8020b8:	48 89 d6             	mov    %rdx,%rsi
  8020bb:	89 c7                	mov    %eax,%edi
  8020bd:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  8020c4:	00 00 00 
  8020c7:	ff d0                	callq  *%rax
  8020c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8020cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8020d0:	78 0a                	js     8020dc <fd_close+0x4c>
  8020d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8020d6:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8020da:	74 12                	je     8020ee <fd_close+0x5e>
  8020dc:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8020e0:	74 05                	je     8020e7 <fd_close+0x57>
  8020e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020e5:	eb 05                	jmp    8020ec <fd_close+0x5c>
  8020e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8020ec:	eb 69                	jmp    802157 <fd_close+0xc7>
  8020ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020f2:	8b 00                	mov    (%rax),%eax
  8020f4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8020f8:	48 89 d6             	mov    %rdx,%rsi
  8020fb:	89 c7                	mov    %eax,%edi
  8020fd:	48 b8 59 21 80 00 00 	movabs $0x802159,%rax
  802104:	00 00 00 
  802107:	ff d0                	callq  *%rax
  802109:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80210c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802110:	78 2a                	js     80213c <fd_close+0xac>
  802112:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802116:	48 8b 40 20          	mov    0x20(%rax),%rax
  80211a:	48 85 c0             	test   %rax,%rax
  80211d:	74 16                	je     802135 <fd_close+0xa5>
  80211f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802123:	48 8b 40 20          	mov    0x20(%rax),%rax
  802127:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80212b:	48 89 d7             	mov    %rdx,%rdi
  80212e:	ff d0                	callq  *%rax
  802130:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802133:	eb 07                	jmp    80213c <fd_close+0xac>
  802135:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80213c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802140:	48 89 c6             	mov    %rax,%rsi
  802143:	bf 00 00 00 00       	mov    $0x0,%edi
  802148:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  80214f:	00 00 00 
  802152:	ff d0                	callq  *%rax
  802154:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802157:	c9                   	leaveq 
  802158:	c3                   	retq   

0000000000802159 <dev_lookup>:
  802159:	55                   	push   %rbp
  80215a:	48 89 e5             	mov    %rsp,%rbp
  80215d:	48 83 ec 20          	sub    $0x20,%rsp
  802161:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802164:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80216f:	eb 41                	jmp    8021b2 <dev_lookup+0x59>
  802171:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  802178:	00 00 00 
  80217b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80217e:	48 63 d2             	movslq %edx,%rdx
  802181:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802185:	8b 00                	mov    (%rax),%eax
  802187:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80218a:	75 22                	jne    8021ae <dev_lookup+0x55>
  80218c:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  802193:	00 00 00 
  802196:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802199:	48 63 d2             	movslq %edx,%rdx
  80219c:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8021a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021a4:	48 89 10             	mov    %rdx,(%rax)
  8021a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8021ac:	eb 60                	jmp    80220e <dev_lookup+0xb5>
  8021ae:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8021b2:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  8021b9:	00 00 00 
  8021bc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8021bf:	48 63 d2             	movslq %edx,%rdx
  8021c2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021c6:	48 85 c0             	test   %rax,%rax
  8021c9:	75 a6                	jne    802171 <dev_lookup+0x18>
  8021cb:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8021d2:	00 00 00 
  8021d5:	48 8b 00             	mov    (%rax),%rax
  8021d8:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8021de:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8021e1:	89 c6                	mov    %eax,%esi
  8021e3:	48 bf b8 48 80 00 00 	movabs $0x8048b8,%rdi
  8021ea:	00 00 00 
  8021ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8021f2:	48 b9 56 06 80 00 00 	movabs $0x800656,%rcx
  8021f9:	00 00 00 
  8021fc:	ff d1                	callq  *%rcx
  8021fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802202:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802209:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80220e:	c9                   	leaveq 
  80220f:	c3                   	retq   

0000000000802210 <close>:
  802210:	55                   	push   %rbp
  802211:	48 89 e5             	mov    %rsp,%rbp
  802214:	48 83 ec 20          	sub    $0x20,%rsp
  802218:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80221b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80221f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802222:	48 89 d6             	mov    %rdx,%rsi
  802225:	89 c7                	mov    %eax,%edi
  802227:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  80222e:	00 00 00 
  802231:	ff d0                	callq  *%rax
  802233:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802236:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80223a:	79 05                	jns    802241 <close+0x31>
  80223c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80223f:	eb 18                	jmp    802259 <close+0x49>
  802241:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802245:	be 01 00 00 00       	mov    $0x1,%esi
  80224a:	48 89 c7             	mov    %rax,%rdi
  80224d:	48 b8 90 20 80 00 00 	movabs $0x802090,%rax
  802254:	00 00 00 
  802257:	ff d0                	callq  *%rax
  802259:	c9                   	leaveq 
  80225a:	c3                   	retq   

000000000080225b <close_all>:
  80225b:	55                   	push   %rbp
  80225c:	48 89 e5             	mov    %rsp,%rbp
  80225f:	48 83 ec 10          	sub    $0x10,%rsp
  802263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80226a:	eb 15                	jmp    802281 <close_all+0x26>
  80226c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80226f:	89 c7                	mov    %eax,%edi
  802271:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802278:	00 00 00 
  80227b:	ff d0                	callq  *%rax
  80227d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802281:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802285:	7e e5                	jle    80226c <close_all+0x11>
  802287:	c9                   	leaveq 
  802288:	c3                   	retq   

0000000000802289 <dup>:
  802289:	55                   	push   %rbp
  80228a:	48 89 e5             	mov    %rsp,%rbp
  80228d:	48 83 ec 40          	sub    $0x40,%rsp
  802291:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802294:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802297:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80229b:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80229e:	48 89 d6             	mov    %rdx,%rsi
  8022a1:	89 c7                	mov    %eax,%edi
  8022a3:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  8022aa:	00 00 00 
  8022ad:	ff d0                	callq  *%rax
  8022af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022b6:	79 08                	jns    8022c0 <dup+0x37>
  8022b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022bb:	e9 70 01 00 00       	jmpq   802430 <dup+0x1a7>
  8022c0:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8022c3:	89 c7                	mov    %eax,%edi
  8022c5:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  8022cc:	00 00 00 
  8022cf:	ff d0                	callq  *%rax
  8022d1:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8022d4:	48 98                	cltq   
  8022d6:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8022dc:	48 c1 e0 0c          	shl    $0xc,%rax
  8022e0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8022e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8022e8:	48 89 c7             	mov    %rax,%rdi
  8022eb:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  8022f2:	00 00 00 
  8022f5:	ff d0                	callq  *%rax
  8022f7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8022fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022ff:	48 89 c7             	mov    %rax,%rdi
  802302:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  802309:	00 00 00 
  80230c:	ff d0                	callq  *%rax
  80230e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802312:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802316:	48 c1 e8 15          	shr    $0x15,%rax
  80231a:	48 89 c2             	mov    %rax,%rdx
  80231d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802324:	01 00 00 
  802327:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80232b:	83 e0 01             	and    $0x1,%eax
  80232e:	48 85 c0             	test   %rax,%rax
  802331:	74 73                	je     8023a6 <dup+0x11d>
  802333:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802337:	48 c1 e8 0c          	shr    $0xc,%rax
  80233b:	48 89 c2             	mov    %rax,%rdx
  80233e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802345:	01 00 00 
  802348:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80234c:	83 e0 01             	and    $0x1,%eax
  80234f:	48 85 c0             	test   %rax,%rax
  802352:	74 52                	je     8023a6 <dup+0x11d>
  802354:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802358:	48 c1 e8 0c          	shr    $0xc,%rax
  80235c:	48 89 c2             	mov    %rax,%rdx
  80235f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802366:	01 00 00 
  802369:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80236d:	25 07 0e 00 00       	and    $0xe07,%eax
  802372:	89 c1                	mov    %eax,%ecx
  802374:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802378:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80237c:	41 89 c8             	mov    %ecx,%r8d
  80237f:	48 89 d1             	mov    %rdx,%rcx
  802382:	ba 00 00 00 00       	mov    $0x0,%edx
  802387:	48 89 c6             	mov    %rax,%rsi
  80238a:	bf 00 00 00 00       	mov    $0x0,%edi
  80238f:	48 b8 8a 1b 80 00 00 	movabs $0x801b8a,%rax
  802396:	00 00 00 
  802399:	ff d0                	callq  *%rax
  80239b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80239e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023a2:	79 02                	jns    8023a6 <dup+0x11d>
  8023a4:	eb 57                	jmp    8023fd <dup+0x174>
  8023a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023aa:	48 c1 e8 0c          	shr    $0xc,%rax
  8023ae:	48 89 c2             	mov    %rax,%rdx
  8023b1:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8023b8:	01 00 00 
  8023bb:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023bf:	25 07 0e 00 00       	and    $0xe07,%eax
  8023c4:	89 c1                	mov    %eax,%ecx
  8023c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8023ce:	41 89 c8             	mov    %ecx,%r8d
  8023d1:	48 89 d1             	mov    %rdx,%rcx
  8023d4:	ba 00 00 00 00       	mov    $0x0,%edx
  8023d9:	48 89 c6             	mov    %rax,%rsi
  8023dc:	bf 00 00 00 00       	mov    $0x0,%edi
  8023e1:	48 b8 8a 1b 80 00 00 	movabs $0x801b8a,%rax
  8023e8:	00 00 00 
  8023eb:	ff d0                	callq  *%rax
  8023ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023f4:	79 02                	jns    8023f8 <dup+0x16f>
  8023f6:	eb 05                	jmp    8023fd <dup+0x174>
  8023f8:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8023fb:	eb 33                	jmp    802430 <dup+0x1a7>
  8023fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802401:	48 89 c6             	mov    %rax,%rsi
  802404:	bf 00 00 00 00       	mov    $0x0,%edi
  802409:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  802410:	00 00 00 
  802413:	ff d0                	callq  *%rax
  802415:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802419:	48 89 c6             	mov    %rax,%rsi
  80241c:	bf 00 00 00 00       	mov    $0x0,%edi
  802421:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  802428:	00 00 00 
  80242b:	ff d0                	callq  *%rax
  80242d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802430:	c9                   	leaveq 
  802431:	c3                   	retq   

0000000000802432 <read>:
  802432:	55                   	push   %rbp
  802433:	48 89 e5             	mov    %rsp,%rbp
  802436:	48 83 ec 40          	sub    $0x40,%rsp
  80243a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80243d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802441:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802445:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802449:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80244c:	48 89 d6             	mov    %rdx,%rsi
  80244f:	89 c7                	mov    %eax,%edi
  802451:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  802458:	00 00 00 
  80245b:	ff d0                	callq  *%rax
  80245d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802460:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802464:	78 24                	js     80248a <read+0x58>
  802466:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80246a:	8b 00                	mov    (%rax),%eax
  80246c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802470:	48 89 d6             	mov    %rdx,%rsi
  802473:	89 c7                	mov    %eax,%edi
  802475:	48 b8 59 21 80 00 00 	movabs $0x802159,%rax
  80247c:	00 00 00 
  80247f:	ff d0                	callq  *%rax
  802481:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802484:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802488:	79 05                	jns    80248f <read+0x5d>
  80248a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80248d:	eb 76                	jmp    802505 <read+0xd3>
  80248f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802493:	8b 40 08             	mov    0x8(%rax),%eax
  802496:	83 e0 03             	and    $0x3,%eax
  802499:	83 f8 01             	cmp    $0x1,%eax
  80249c:	75 3a                	jne    8024d8 <read+0xa6>
  80249e:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8024a5:	00 00 00 
  8024a8:	48 8b 00             	mov    (%rax),%rax
  8024ab:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8024b1:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8024b4:	89 c6                	mov    %eax,%esi
  8024b6:	48 bf d7 48 80 00 00 	movabs $0x8048d7,%rdi
  8024bd:	00 00 00 
  8024c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8024c5:	48 b9 56 06 80 00 00 	movabs $0x800656,%rcx
  8024cc:	00 00 00 
  8024cf:	ff d1                	callq  *%rcx
  8024d1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024d6:	eb 2d                	jmp    802505 <read+0xd3>
  8024d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024dc:	48 8b 40 10          	mov    0x10(%rax),%rax
  8024e0:	48 85 c0             	test   %rax,%rax
  8024e3:	75 07                	jne    8024ec <read+0xba>
  8024e5:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8024ea:	eb 19                	jmp    802505 <read+0xd3>
  8024ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024f0:	48 8b 40 10          	mov    0x10(%rax),%rax
  8024f4:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8024f8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8024fc:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802500:	48 89 cf             	mov    %rcx,%rdi
  802503:	ff d0                	callq  *%rax
  802505:	c9                   	leaveq 
  802506:	c3                   	retq   

0000000000802507 <readn>:
  802507:	55                   	push   %rbp
  802508:	48 89 e5             	mov    %rsp,%rbp
  80250b:	48 83 ec 30          	sub    $0x30,%rsp
  80250f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802512:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802516:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80251a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802521:	eb 49                	jmp    80256c <readn+0x65>
  802523:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802526:	48 98                	cltq   
  802528:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80252c:	48 29 c2             	sub    %rax,%rdx
  80252f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802532:	48 63 c8             	movslq %eax,%rcx
  802535:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802539:	48 01 c1             	add    %rax,%rcx
  80253c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80253f:	48 89 ce             	mov    %rcx,%rsi
  802542:	89 c7                	mov    %eax,%edi
  802544:	48 b8 32 24 80 00 00 	movabs $0x802432,%rax
  80254b:	00 00 00 
  80254e:	ff d0                	callq  *%rax
  802550:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802553:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802557:	79 05                	jns    80255e <readn+0x57>
  802559:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80255c:	eb 1c                	jmp    80257a <readn+0x73>
  80255e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802562:	75 02                	jne    802566 <readn+0x5f>
  802564:	eb 11                	jmp    802577 <readn+0x70>
  802566:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802569:	01 45 fc             	add    %eax,-0x4(%rbp)
  80256c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80256f:	48 98                	cltq   
  802571:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802575:	72 ac                	jb     802523 <readn+0x1c>
  802577:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80257a:	c9                   	leaveq 
  80257b:	c3                   	retq   

000000000080257c <write>:
  80257c:	55                   	push   %rbp
  80257d:	48 89 e5             	mov    %rsp,%rbp
  802580:	48 83 ec 40          	sub    $0x40,%rsp
  802584:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802587:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80258b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80258f:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802593:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802596:	48 89 d6             	mov    %rdx,%rsi
  802599:	89 c7                	mov    %eax,%edi
  80259b:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  8025a2:	00 00 00 
  8025a5:	ff d0                	callq  *%rax
  8025a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025ae:	78 24                	js     8025d4 <write+0x58>
  8025b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025b4:	8b 00                	mov    (%rax),%eax
  8025b6:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8025ba:	48 89 d6             	mov    %rdx,%rsi
  8025bd:	89 c7                	mov    %eax,%edi
  8025bf:	48 b8 59 21 80 00 00 	movabs $0x802159,%rax
  8025c6:	00 00 00 
  8025c9:	ff d0                	callq  *%rax
  8025cb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025ce:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025d2:	79 05                	jns    8025d9 <write+0x5d>
  8025d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025d7:	eb 75                	jmp    80264e <write+0xd2>
  8025d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025dd:	8b 40 08             	mov    0x8(%rax),%eax
  8025e0:	83 e0 03             	and    $0x3,%eax
  8025e3:	85 c0                	test   %eax,%eax
  8025e5:	75 3a                	jne    802621 <write+0xa5>
  8025e7:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8025ee:	00 00 00 
  8025f1:	48 8b 00             	mov    (%rax),%rax
  8025f4:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8025fa:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8025fd:	89 c6                	mov    %eax,%esi
  8025ff:	48 bf f3 48 80 00 00 	movabs $0x8048f3,%rdi
  802606:	00 00 00 
  802609:	b8 00 00 00 00       	mov    $0x0,%eax
  80260e:	48 b9 56 06 80 00 00 	movabs $0x800656,%rcx
  802615:	00 00 00 
  802618:	ff d1                	callq  *%rcx
  80261a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80261f:	eb 2d                	jmp    80264e <write+0xd2>
  802621:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802625:	48 8b 40 18          	mov    0x18(%rax),%rax
  802629:	48 85 c0             	test   %rax,%rax
  80262c:	75 07                	jne    802635 <write+0xb9>
  80262e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802633:	eb 19                	jmp    80264e <write+0xd2>
  802635:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802639:	48 8b 40 18          	mov    0x18(%rax),%rax
  80263d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802641:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802645:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802649:	48 89 cf             	mov    %rcx,%rdi
  80264c:	ff d0                	callq  *%rax
  80264e:	c9                   	leaveq 
  80264f:	c3                   	retq   

0000000000802650 <seek>:
  802650:	55                   	push   %rbp
  802651:	48 89 e5             	mov    %rsp,%rbp
  802654:	48 83 ec 18          	sub    $0x18,%rsp
  802658:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80265b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80265e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802662:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802665:	48 89 d6             	mov    %rdx,%rsi
  802668:	89 c7                	mov    %eax,%edi
  80266a:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  802671:	00 00 00 
  802674:	ff d0                	callq  *%rax
  802676:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802679:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80267d:	79 05                	jns    802684 <seek+0x34>
  80267f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802682:	eb 0f                	jmp    802693 <seek+0x43>
  802684:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802688:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80268b:	89 50 04             	mov    %edx,0x4(%rax)
  80268e:	b8 00 00 00 00       	mov    $0x0,%eax
  802693:	c9                   	leaveq 
  802694:	c3                   	retq   

0000000000802695 <ftruncate>:
  802695:	55                   	push   %rbp
  802696:	48 89 e5             	mov    %rsp,%rbp
  802699:	48 83 ec 30          	sub    $0x30,%rsp
  80269d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8026a0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8026a3:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8026a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8026aa:	48 89 d6             	mov    %rdx,%rsi
  8026ad:	89 c7                	mov    %eax,%edi
  8026af:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  8026b6:	00 00 00 
  8026b9:	ff d0                	callq  *%rax
  8026bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026c2:	78 24                	js     8026e8 <ftruncate+0x53>
  8026c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026c8:	8b 00                	mov    (%rax),%eax
  8026ca:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8026ce:	48 89 d6             	mov    %rdx,%rsi
  8026d1:	89 c7                	mov    %eax,%edi
  8026d3:	48 b8 59 21 80 00 00 	movabs $0x802159,%rax
  8026da:	00 00 00 
  8026dd:	ff d0                	callq  *%rax
  8026df:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026e6:	79 05                	jns    8026ed <ftruncate+0x58>
  8026e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026eb:	eb 72                	jmp    80275f <ftruncate+0xca>
  8026ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026f1:	8b 40 08             	mov    0x8(%rax),%eax
  8026f4:	83 e0 03             	and    $0x3,%eax
  8026f7:	85 c0                	test   %eax,%eax
  8026f9:	75 3a                	jne    802735 <ftruncate+0xa0>
  8026fb:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802702:	00 00 00 
  802705:	48 8b 00             	mov    (%rax),%rax
  802708:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80270e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802711:	89 c6                	mov    %eax,%esi
  802713:	48 bf 10 49 80 00 00 	movabs $0x804910,%rdi
  80271a:	00 00 00 
  80271d:	b8 00 00 00 00       	mov    $0x0,%eax
  802722:	48 b9 56 06 80 00 00 	movabs $0x800656,%rcx
  802729:	00 00 00 
  80272c:	ff d1                	callq  *%rcx
  80272e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802733:	eb 2a                	jmp    80275f <ftruncate+0xca>
  802735:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802739:	48 8b 40 30          	mov    0x30(%rax),%rax
  80273d:	48 85 c0             	test   %rax,%rax
  802740:	75 07                	jne    802749 <ftruncate+0xb4>
  802742:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802747:	eb 16                	jmp    80275f <ftruncate+0xca>
  802749:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80274d:	48 8b 40 30          	mov    0x30(%rax),%rax
  802751:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802755:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802758:	89 ce                	mov    %ecx,%esi
  80275a:	48 89 d7             	mov    %rdx,%rdi
  80275d:	ff d0                	callq  *%rax
  80275f:	c9                   	leaveq 
  802760:	c3                   	retq   

0000000000802761 <fstat>:
  802761:	55                   	push   %rbp
  802762:	48 89 e5             	mov    %rsp,%rbp
  802765:	48 83 ec 30          	sub    $0x30,%rsp
  802769:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80276c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802770:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802774:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802777:	48 89 d6             	mov    %rdx,%rsi
  80277a:	89 c7                	mov    %eax,%edi
  80277c:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  802783:	00 00 00 
  802786:	ff d0                	callq  *%rax
  802788:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80278b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80278f:	78 24                	js     8027b5 <fstat+0x54>
  802791:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802795:	8b 00                	mov    (%rax),%eax
  802797:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80279b:	48 89 d6             	mov    %rdx,%rsi
  80279e:	89 c7                	mov    %eax,%edi
  8027a0:	48 b8 59 21 80 00 00 	movabs $0x802159,%rax
  8027a7:	00 00 00 
  8027aa:	ff d0                	callq  *%rax
  8027ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027b3:	79 05                	jns    8027ba <fstat+0x59>
  8027b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027b8:	eb 5e                	jmp    802818 <fstat+0xb7>
  8027ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8027be:	48 8b 40 28          	mov    0x28(%rax),%rax
  8027c2:	48 85 c0             	test   %rax,%rax
  8027c5:	75 07                	jne    8027ce <fstat+0x6d>
  8027c7:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8027cc:	eb 4a                	jmp    802818 <fstat+0xb7>
  8027ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027d2:	c6 00 00             	movb   $0x0,(%rax)
  8027d5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027d9:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  8027e0:	00 00 00 
  8027e3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027e7:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  8027ee:	00 00 00 
  8027f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8027f5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8027f9:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802800:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802804:	48 8b 40 28          	mov    0x28(%rax),%rax
  802808:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80280c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802810:	48 89 ce             	mov    %rcx,%rsi
  802813:	48 89 d7             	mov    %rdx,%rdi
  802816:	ff d0                	callq  *%rax
  802818:	c9                   	leaveq 
  802819:	c3                   	retq   

000000000080281a <stat>:
  80281a:	55                   	push   %rbp
  80281b:	48 89 e5             	mov    %rsp,%rbp
  80281e:	48 83 ec 20          	sub    $0x20,%rsp
  802822:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802826:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80282a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80282e:	be 00 00 00 00       	mov    $0x0,%esi
  802833:	48 89 c7             	mov    %rax,%rdi
  802836:	48 b8 08 29 80 00 00 	movabs $0x802908,%rax
  80283d:	00 00 00 
  802840:	ff d0                	callq  *%rax
  802842:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802845:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802849:	79 05                	jns    802850 <stat+0x36>
  80284b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80284e:	eb 2f                	jmp    80287f <stat+0x65>
  802850:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802854:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802857:	48 89 d6             	mov    %rdx,%rsi
  80285a:	89 c7                	mov    %eax,%edi
  80285c:	48 b8 61 27 80 00 00 	movabs $0x802761,%rax
  802863:	00 00 00 
  802866:	ff d0                	callq  *%rax
  802868:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80286b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80286e:	89 c7                	mov    %eax,%edi
  802870:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802877:	00 00 00 
  80287a:	ff d0                	callq  *%rax
  80287c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80287f:	c9                   	leaveq 
  802880:	c3                   	retq   

0000000000802881 <fsipc>:
  802881:	55                   	push   %rbp
  802882:	48 89 e5             	mov    %rsp,%rbp
  802885:	48 83 ec 10          	sub    $0x10,%rsp
  802889:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80288c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802890:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  802897:	00 00 00 
  80289a:	8b 00                	mov    (%rax),%eax
  80289c:	85 c0                	test   %eax,%eax
  80289e:	75 1d                	jne    8028bd <fsipc+0x3c>
  8028a0:	bf 01 00 00 00       	mov    $0x1,%edi
  8028a5:	48 b8 99 41 80 00 00 	movabs $0x804199,%rax
  8028ac:	00 00 00 
  8028af:	ff d0                	callq  *%rax
  8028b1:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  8028b8:	00 00 00 
  8028bb:	89 02                	mov    %eax,(%rdx)
  8028bd:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8028c4:	00 00 00 
  8028c7:	8b 00                	mov    (%rax),%eax
  8028c9:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8028cc:	b9 07 00 00 00       	mov    $0x7,%ecx
  8028d1:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  8028d8:	00 00 00 
  8028db:	89 c7                	mov    %eax,%edi
  8028dd:	48 b8 8e 40 80 00 00 	movabs $0x80408e,%rax
  8028e4:	00 00 00 
  8028e7:	ff d0                	callq  *%rax
  8028e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028ed:	ba 00 00 00 00       	mov    $0x0,%edx
  8028f2:	48 89 c6             	mov    %rax,%rsi
  8028f5:	bf 00 00 00 00       	mov    $0x0,%edi
  8028fa:	48 b8 cd 3f 80 00 00 	movabs $0x803fcd,%rax
  802901:	00 00 00 
  802904:	ff d0                	callq  *%rax
  802906:	c9                   	leaveq 
  802907:	c3                   	retq   

0000000000802908 <open>:
  802908:	55                   	push   %rbp
  802909:	48 89 e5             	mov    %rsp,%rbp
  80290c:	48 83 ec 20          	sub    $0x20,%rsp
  802910:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802914:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802917:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80291b:	48 89 c7             	mov    %rax,%rdi
  80291e:	48 b8 9f 11 80 00 00 	movabs $0x80119f,%rax
  802925:	00 00 00 
  802928:	ff d0                	callq  *%rax
  80292a:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  80292f:	7e 0a                	jle    80293b <open+0x33>
  802931:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802936:	e9 a5 00 00 00       	jmpq   8029e0 <open+0xd8>
  80293b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80293f:	48 89 c7             	mov    %rax,%rdi
  802942:	48 b8 68 1f 80 00 00 	movabs $0x801f68,%rax
  802949:	00 00 00 
  80294c:	ff d0                	callq  *%rax
  80294e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802951:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802955:	79 08                	jns    80295f <open+0x57>
  802957:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80295a:	e9 81 00 00 00       	jmpq   8029e0 <open+0xd8>
  80295f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802963:	48 89 c6             	mov    %rax,%rsi
  802966:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  80296d:	00 00 00 
  802970:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  802977:	00 00 00 
  80297a:	ff d0                	callq  *%rax
  80297c:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802983:	00 00 00 
  802986:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802989:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  80298f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802993:	48 89 c6             	mov    %rax,%rsi
  802996:	bf 01 00 00 00       	mov    $0x1,%edi
  80299b:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  8029a2:	00 00 00 
  8029a5:	ff d0                	callq  *%rax
  8029a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029ae:	79 1d                	jns    8029cd <open+0xc5>
  8029b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029b4:	be 00 00 00 00       	mov    $0x0,%esi
  8029b9:	48 89 c7             	mov    %rax,%rdi
  8029bc:	48 b8 90 20 80 00 00 	movabs $0x802090,%rax
  8029c3:	00 00 00 
  8029c6:	ff d0                	callq  *%rax
  8029c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029cb:	eb 13                	jmp    8029e0 <open+0xd8>
  8029cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029d1:	48 89 c7             	mov    %rax,%rdi
  8029d4:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  8029db:	00 00 00 
  8029de:	ff d0                	callq  *%rax
  8029e0:	c9                   	leaveq 
  8029e1:	c3                   	retq   

00000000008029e2 <devfile_flush>:
  8029e2:	55                   	push   %rbp
  8029e3:	48 89 e5             	mov    %rsp,%rbp
  8029e6:	48 83 ec 10          	sub    $0x10,%rsp
  8029ea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8029ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8029f2:	8b 50 0c             	mov    0xc(%rax),%edx
  8029f5:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8029fc:	00 00 00 
  8029ff:	89 10                	mov    %edx,(%rax)
  802a01:	be 00 00 00 00       	mov    $0x0,%esi
  802a06:	bf 06 00 00 00       	mov    $0x6,%edi
  802a0b:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802a12:	00 00 00 
  802a15:	ff d0                	callq  *%rax
  802a17:	c9                   	leaveq 
  802a18:	c3                   	retq   

0000000000802a19 <devfile_read>:
  802a19:	55                   	push   %rbp
  802a1a:	48 89 e5             	mov    %rsp,%rbp
  802a1d:	48 83 ec 30          	sub    $0x30,%rsp
  802a21:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802a25:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802a29:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802a2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a31:	8b 50 0c             	mov    0xc(%rax),%edx
  802a34:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a3b:	00 00 00 
  802a3e:	89 10                	mov    %edx,(%rax)
  802a40:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a47:	00 00 00 
  802a4a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802a4e:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802a52:	be 00 00 00 00       	mov    $0x0,%esi
  802a57:	bf 03 00 00 00       	mov    $0x3,%edi
  802a5c:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802a63:	00 00 00 
  802a66:	ff d0                	callq  *%rax
  802a68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a6f:	79 08                	jns    802a79 <devfile_read+0x60>
  802a71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a74:	e9 a4 00 00 00       	jmpq   802b1d <devfile_read+0x104>
  802a79:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a7c:	48 98                	cltq   
  802a7e:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802a82:	76 35                	jbe    802ab9 <devfile_read+0xa0>
  802a84:	48 b9 36 49 80 00 00 	movabs $0x804936,%rcx
  802a8b:	00 00 00 
  802a8e:	48 ba 3d 49 80 00 00 	movabs $0x80493d,%rdx
  802a95:	00 00 00 
  802a98:	be 89 00 00 00       	mov    $0x89,%esi
  802a9d:	48 bf 52 49 80 00 00 	movabs $0x804952,%rdi
  802aa4:	00 00 00 
  802aa7:	b8 00 00 00 00       	mov    $0x0,%eax
  802aac:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  802ab3:	00 00 00 
  802ab6:	41 ff d0             	callq  *%r8
  802ab9:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802ac0:	7e 35                	jle    802af7 <devfile_read+0xde>
  802ac2:	48 b9 60 49 80 00 00 	movabs $0x804960,%rcx
  802ac9:	00 00 00 
  802acc:	48 ba 3d 49 80 00 00 	movabs $0x80493d,%rdx
  802ad3:	00 00 00 
  802ad6:	be 8a 00 00 00       	mov    $0x8a,%esi
  802adb:	48 bf 52 49 80 00 00 	movabs $0x804952,%rdi
  802ae2:	00 00 00 
  802ae5:	b8 00 00 00 00       	mov    $0x0,%eax
  802aea:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  802af1:	00 00 00 
  802af4:	41 ff d0             	callq  *%r8
  802af7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802afa:	48 63 d0             	movslq %eax,%rdx
  802afd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b01:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802b08:	00 00 00 
  802b0b:	48 89 c7             	mov    %rax,%rdi
  802b0e:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  802b15:	00 00 00 
  802b18:	ff d0                	callq  *%rax
  802b1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b1d:	c9                   	leaveq 
  802b1e:	c3                   	retq   

0000000000802b1f <devfile_write>:
  802b1f:	55                   	push   %rbp
  802b20:	48 89 e5             	mov    %rsp,%rbp
  802b23:	48 83 ec 40          	sub    $0x40,%rsp
  802b27:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802b2b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802b2f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802b33:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802b37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802b3b:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802b42:	00 
  802b43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b47:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802b4b:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802b50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802b54:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b58:	8b 50 0c             	mov    0xc(%rax),%edx
  802b5b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b62:	00 00 00 
  802b65:	89 10                	mov    %edx,(%rax)
  802b67:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b6e:	00 00 00 
  802b71:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802b75:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802b79:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802b7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b81:	48 89 c6             	mov    %rax,%rsi
  802b84:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  802b8b:	00 00 00 
  802b8e:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  802b95:	00 00 00 
  802b98:	ff d0                	callq  *%rax
  802b9a:	be 00 00 00 00       	mov    $0x0,%esi
  802b9f:	bf 04 00 00 00       	mov    $0x4,%edi
  802ba4:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802bab:	00 00 00 
  802bae:	ff d0                	callq  *%rax
  802bb0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802bb3:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802bb7:	79 05                	jns    802bbe <devfile_write+0x9f>
  802bb9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802bbc:	eb 43                	jmp    802c01 <devfile_write+0xe2>
  802bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802bc1:	48 98                	cltq   
  802bc3:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802bc7:	76 35                	jbe    802bfe <devfile_write+0xdf>
  802bc9:	48 b9 36 49 80 00 00 	movabs $0x804936,%rcx
  802bd0:	00 00 00 
  802bd3:	48 ba 3d 49 80 00 00 	movabs $0x80493d,%rdx
  802bda:	00 00 00 
  802bdd:	be a8 00 00 00       	mov    $0xa8,%esi
  802be2:	48 bf 52 49 80 00 00 	movabs $0x804952,%rdi
  802be9:	00 00 00 
  802bec:	b8 00 00 00 00       	mov    $0x0,%eax
  802bf1:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  802bf8:	00 00 00 
  802bfb:	41 ff d0             	callq  *%r8
  802bfe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c01:	c9                   	leaveq 
  802c02:	c3                   	retq   

0000000000802c03 <devfile_stat>:
  802c03:	55                   	push   %rbp
  802c04:	48 89 e5             	mov    %rsp,%rbp
  802c07:	48 83 ec 20          	sub    $0x20,%rsp
  802c0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802c13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c17:	8b 50 0c             	mov    0xc(%rax),%edx
  802c1a:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c21:	00 00 00 
  802c24:	89 10                	mov    %edx,(%rax)
  802c26:	be 00 00 00 00       	mov    $0x0,%esi
  802c2b:	bf 05 00 00 00       	mov    $0x5,%edi
  802c30:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802c37:	00 00 00 
  802c3a:	ff d0                	callq  *%rax
  802c3c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c3f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c43:	79 05                	jns    802c4a <devfile_stat+0x47>
  802c45:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c48:	eb 56                	jmp    802ca0 <devfile_stat+0x9d>
  802c4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c4e:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802c55:	00 00 00 
  802c58:	48 89 c7             	mov    %rax,%rdi
  802c5b:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  802c62:	00 00 00 
  802c65:	ff d0                	callq  *%rax
  802c67:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c6e:	00 00 00 
  802c71:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802c77:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c7b:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802c81:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c88:	00 00 00 
  802c8b:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802c91:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c95:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802c9b:	b8 00 00 00 00       	mov    $0x0,%eax
  802ca0:	c9                   	leaveq 
  802ca1:	c3                   	retq   

0000000000802ca2 <devfile_trunc>:
  802ca2:	55                   	push   %rbp
  802ca3:	48 89 e5             	mov    %rsp,%rbp
  802ca6:	48 83 ec 10          	sub    $0x10,%rsp
  802caa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802cae:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802cb5:	8b 50 0c             	mov    0xc(%rax),%edx
  802cb8:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802cbf:	00 00 00 
  802cc2:	89 10                	mov    %edx,(%rax)
  802cc4:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802ccb:	00 00 00 
  802cce:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802cd1:	89 50 04             	mov    %edx,0x4(%rax)
  802cd4:	be 00 00 00 00       	mov    $0x0,%esi
  802cd9:	bf 02 00 00 00       	mov    $0x2,%edi
  802cde:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802ce5:	00 00 00 
  802ce8:	ff d0                	callq  *%rax
  802cea:	c9                   	leaveq 
  802ceb:	c3                   	retq   

0000000000802cec <remove>:
  802cec:	55                   	push   %rbp
  802ced:	48 89 e5             	mov    %rsp,%rbp
  802cf0:	48 83 ec 10          	sub    $0x10,%rsp
  802cf4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802cf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802cfc:	48 89 c7             	mov    %rax,%rdi
  802cff:	48 b8 9f 11 80 00 00 	movabs $0x80119f,%rax
  802d06:	00 00 00 
  802d09:	ff d0                	callq  *%rax
  802d0b:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802d10:	7e 07                	jle    802d19 <remove+0x2d>
  802d12:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802d17:	eb 33                	jmp    802d4c <remove+0x60>
  802d19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d1d:	48 89 c6             	mov    %rax,%rsi
  802d20:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802d27:	00 00 00 
  802d2a:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  802d31:	00 00 00 
  802d34:	ff d0                	callq  *%rax
  802d36:	be 00 00 00 00       	mov    $0x0,%esi
  802d3b:	bf 07 00 00 00       	mov    $0x7,%edi
  802d40:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802d47:	00 00 00 
  802d4a:	ff d0                	callq  *%rax
  802d4c:	c9                   	leaveq 
  802d4d:	c3                   	retq   

0000000000802d4e <sync>:
  802d4e:	55                   	push   %rbp
  802d4f:	48 89 e5             	mov    %rsp,%rbp
  802d52:	be 00 00 00 00       	mov    $0x0,%esi
  802d57:	bf 08 00 00 00       	mov    $0x8,%edi
  802d5c:	48 b8 81 28 80 00 00 	movabs $0x802881,%rax
  802d63:	00 00 00 
  802d66:	ff d0                	callq  *%rax
  802d68:	5d                   	pop    %rbp
  802d69:	c3                   	retq   

0000000000802d6a <copy>:
  802d6a:	55                   	push   %rbp
  802d6b:	48 89 e5             	mov    %rsp,%rbp
  802d6e:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802d75:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802d7c:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802d83:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802d8a:	be 00 00 00 00       	mov    $0x0,%esi
  802d8f:	48 89 c7             	mov    %rax,%rdi
  802d92:	48 b8 08 29 80 00 00 	movabs $0x802908,%rax
  802d99:	00 00 00 
  802d9c:	ff d0                	callq  *%rax
  802d9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802da1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802da5:	79 28                	jns    802dcf <copy+0x65>
  802da7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802daa:	89 c6                	mov    %eax,%esi
  802dac:	48 bf 6c 49 80 00 00 	movabs $0x80496c,%rdi
  802db3:	00 00 00 
  802db6:	b8 00 00 00 00       	mov    $0x0,%eax
  802dbb:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  802dc2:	00 00 00 
  802dc5:	ff d2                	callq  *%rdx
  802dc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dca:	e9 74 01 00 00       	jmpq   802f43 <copy+0x1d9>
  802dcf:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802dd6:	be 01 01 00 00       	mov    $0x101,%esi
  802ddb:	48 89 c7             	mov    %rax,%rdi
  802dde:	48 b8 08 29 80 00 00 	movabs $0x802908,%rax
  802de5:	00 00 00 
  802de8:	ff d0                	callq  *%rax
  802dea:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802ded:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802df1:	79 39                	jns    802e2c <copy+0xc2>
  802df3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802df6:	89 c6                	mov    %eax,%esi
  802df8:	48 bf 82 49 80 00 00 	movabs $0x804982,%rdi
  802dff:	00 00 00 
  802e02:	b8 00 00 00 00       	mov    $0x0,%eax
  802e07:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  802e0e:	00 00 00 
  802e11:	ff d2                	callq  *%rdx
  802e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e16:	89 c7                	mov    %eax,%edi
  802e18:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802e1f:	00 00 00 
  802e22:	ff d0                	callq  *%rax
  802e24:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e27:	e9 17 01 00 00       	jmpq   802f43 <copy+0x1d9>
  802e2c:	eb 74                	jmp    802ea2 <copy+0x138>
  802e2e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802e31:	48 63 d0             	movslq %eax,%rdx
  802e34:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802e3b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e3e:	48 89 ce             	mov    %rcx,%rsi
  802e41:	89 c7                	mov    %eax,%edi
  802e43:	48 b8 7c 25 80 00 00 	movabs $0x80257c,%rax
  802e4a:	00 00 00 
  802e4d:	ff d0                	callq  *%rax
  802e4f:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802e52:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802e56:	79 4a                	jns    802ea2 <copy+0x138>
  802e58:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802e5b:	89 c6                	mov    %eax,%esi
  802e5d:	48 bf 9c 49 80 00 00 	movabs $0x80499c,%rdi
  802e64:	00 00 00 
  802e67:	b8 00 00 00 00       	mov    $0x0,%eax
  802e6c:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  802e73:	00 00 00 
  802e76:	ff d2                	callq  *%rdx
  802e78:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e7b:	89 c7                	mov    %eax,%edi
  802e7d:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802e84:	00 00 00 
  802e87:	ff d0                	callq  *%rax
  802e89:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e8c:	89 c7                	mov    %eax,%edi
  802e8e:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802e95:	00 00 00 
  802e98:	ff d0                	callq  *%rax
  802e9a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802e9d:	e9 a1 00 00 00       	jmpq   802f43 <copy+0x1d9>
  802ea2:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802ea9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802eac:	ba 00 02 00 00       	mov    $0x200,%edx
  802eb1:	48 89 ce             	mov    %rcx,%rsi
  802eb4:	89 c7                	mov    %eax,%edi
  802eb6:	48 b8 32 24 80 00 00 	movabs $0x802432,%rax
  802ebd:	00 00 00 
  802ec0:	ff d0                	callq  *%rax
  802ec2:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802ec5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802ec9:	0f 8f 5f ff ff ff    	jg     802e2e <copy+0xc4>
  802ecf:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802ed3:	79 47                	jns    802f1c <copy+0x1b2>
  802ed5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802ed8:	89 c6                	mov    %eax,%esi
  802eda:	48 bf af 49 80 00 00 	movabs $0x8049af,%rdi
  802ee1:	00 00 00 
  802ee4:	b8 00 00 00 00       	mov    $0x0,%eax
  802ee9:	48 ba 56 06 80 00 00 	movabs $0x800656,%rdx
  802ef0:	00 00 00 
  802ef3:	ff d2                	callq  *%rdx
  802ef5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ef8:	89 c7                	mov    %eax,%edi
  802efa:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802f01:	00 00 00 
  802f04:	ff d0                	callq  *%rax
  802f06:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f09:	89 c7                	mov    %eax,%edi
  802f0b:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802f12:	00 00 00 
  802f15:	ff d0                	callq  *%rax
  802f17:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802f1a:	eb 27                	jmp    802f43 <copy+0x1d9>
  802f1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f1f:	89 c7                	mov    %eax,%edi
  802f21:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802f28:	00 00 00 
  802f2b:	ff d0                	callq  *%rax
  802f2d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f30:	89 c7                	mov    %eax,%edi
  802f32:	48 b8 10 22 80 00 00 	movabs $0x802210,%rax
  802f39:	00 00 00 
  802f3c:	ff d0                	callq  *%rax
  802f3e:	b8 00 00 00 00       	mov    $0x0,%eax
  802f43:	c9                   	leaveq 
  802f44:	c3                   	retq   

0000000000802f45 <fd2sockid>:
  802f45:	55                   	push   %rbp
  802f46:	48 89 e5             	mov    %rsp,%rbp
  802f49:	48 83 ec 20          	sub    $0x20,%rsp
  802f4d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f50:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802f54:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f57:	48 89 d6             	mov    %rdx,%rsi
  802f5a:	89 c7                	mov    %eax,%edi
  802f5c:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  802f63:	00 00 00 
  802f66:	ff d0                	callq  *%rax
  802f68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f6f:	79 05                	jns    802f76 <fd2sockid+0x31>
  802f71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f74:	eb 24                	jmp    802f9a <fd2sockid+0x55>
  802f76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f7a:	8b 10                	mov    (%rax),%edx
  802f7c:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  802f83:	00 00 00 
  802f86:	8b 00                	mov    (%rax),%eax
  802f88:	39 c2                	cmp    %eax,%edx
  802f8a:	74 07                	je     802f93 <fd2sockid+0x4e>
  802f8c:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802f91:	eb 07                	jmp    802f9a <fd2sockid+0x55>
  802f93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f97:	8b 40 0c             	mov    0xc(%rax),%eax
  802f9a:	c9                   	leaveq 
  802f9b:	c3                   	retq   

0000000000802f9c <alloc_sockfd>:
  802f9c:	55                   	push   %rbp
  802f9d:	48 89 e5             	mov    %rsp,%rbp
  802fa0:	48 83 ec 20          	sub    $0x20,%rsp
  802fa4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802fa7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802fab:	48 89 c7             	mov    %rax,%rdi
  802fae:	48 b8 68 1f 80 00 00 	movabs $0x801f68,%rax
  802fb5:	00 00 00 
  802fb8:	ff d0                	callq  *%rax
  802fba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fbd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fc1:	78 26                	js     802fe9 <alloc_sockfd+0x4d>
  802fc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fc7:	ba 07 04 00 00       	mov    $0x407,%edx
  802fcc:	48 89 c6             	mov    %rax,%rsi
  802fcf:	bf 00 00 00 00       	mov    $0x0,%edi
  802fd4:	48 b8 3a 1b 80 00 00 	movabs $0x801b3a,%rax
  802fdb:	00 00 00 
  802fde:	ff d0                	callq  *%rax
  802fe0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fe3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fe7:	79 16                	jns    802fff <alloc_sockfd+0x63>
  802fe9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802fec:	89 c7                	mov    %eax,%edi
  802fee:	48 b8 a9 34 80 00 00 	movabs $0x8034a9,%rax
  802ff5:	00 00 00 
  802ff8:	ff d0                	callq  *%rax
  802ffa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ffd:	eb 3a                	jmp    803039 <alloc_sockfd+0x9d>
  802fff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803003:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  80300a:	00 00 00 
  80300d:	8b 12                	mov    (%rdx),%edx
  80300f:	89 10                	mov    %edx,(%rax)
  803011:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803015:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80301c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803020:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803023:	89 50 0c             	mov    %edx,0xc(%rax)
  803026:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80302a:	48 89 c7             	mov    %rax,%rdi
  80302d:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  803034:	00 00 00 
  803037:	ff d0                	callq  *%rax
  803039:	c9                   	leaveq 
  80303a:	c3                   	retq   

000000000080303b <accept>:
  80303b:	55                   	push   %rbp
  80303c:	48 89 e5             	mov    %rsp,%rbp
  80303f:	48 83 ec 30          	sub    $0x30,%rsp
  803043:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803046:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80304a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80304e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803051:	89 c7                	mov    %eax,%edi
  803053:	48 b8 45 2f 80 00 00 	movabs $0x802f45,%rax
  80305a:	00 00 00 
  80305d:	ff d0                	callq  *%rax
  80305f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803062:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803066:	79 05                	jns    80306d <accept+0x32>
  803068:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80306b:	eb 3b                	jmp    8030a8 <accept+0x6d>
  80306d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803071:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803075:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803078:	48 89 ce             	mov    %rcx,%rsi
  80307b:	89 c7                	mov    %eax,%edi
  80307d:	48 b8 86 33 80 00 00 	movabs $0x803386,%rax
  803084:	00 00 00 
  803087:	ff d0                	callq  *%rax
  803089:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80308c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803090:	79 05                	jns    803097 <accept+0x5c>
  803092:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803095:	eb 11                	jmp    8030a8 <accept+0x6d>
  803097:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80309a:	89 c7                	mov    %eax,%edi
  80309c:	48 b8 9c 2f 80 00 00 	movabs $0x802f9c,%rax
  8030a3:	00 00 00 
  8030a6:	ff d0                	callq  *%rax
  8030a8:	c9                   	leaveq 
  8030a9:	c3                   	retq   

00000000008030aa <bind>:
  8030aa:	55                   	push   %rbp
  8030ab:	48 89 e5             	mov    %rsp,%rbp
  8030ae:	48 83 ec 20          	sub    $0x20,%rsp
  8030b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8030b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8030b9:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8030bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8030bf:	89 c7                	mov    %eax,%edi
  8030c1:	48 b8 45 2f 80 00 00 	movabs $0x802f45,%rax
  8030c8:	00 00 00 
  8030cb:	ff d0                	callq  *%rax
  8030cd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030d4:	79 05                	jns    8030db <bind+0x31>
  8030d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030d9:	eb 1b                	jmp    8030f6 <bind+0x4c>
  8030db:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8030de:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8030e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030e5:	48 89 ce             	mov    %rcx,%rsi
  8030e8:	89 c7                	mov    %eax,%edi
  8030ea:	48 b8 05 34 80 00 00 	movabs $0x803405,%rax
  8030f1:	00 00 00 
  8030f4:	ff d0                	callq  *%rax
  8030f6:	c9                   	leaveq 
  8030f7:	c3                   	retq   

00000000008030f8 <shutdown>:
  8030f8:	55                   	push   %rbp
  8030f9:	48 89 e5             	mov    %rsp,%rbp
  8030fc:	48 83 ec 20          	sub    $0x20,%rsp
  803100:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803103:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803106:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803109:	89 c7                	mov    %eax,%edi
  80310b:	48 b8 45 2f 80 00 00 	movabs $0x802f45,%rax
  803112:	00 00 00 
  803115:	ff d0                	callq  *%rax
  803117:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80311a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80311e:	79 05                	jns    803125 <shutdown+0x2d>
  803120:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803123:	eb 16                	jmp    80313b <shutdown+0x43>
  803125:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803128:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80312b:	89 d6                	mov    %edx,%esi
  80312d:	89 c7                	mov    %eax,%edi
  80312f:	48 b8 69 34 80 00 00 	movabs $0x803469,%rax
  803136:	00 00 00 
  803139:	ff d0                	callq  *%rax
  80313b:	c9                   	leaveq 
  80313c:	c3                   	retq   

000000000080313d <devsock_close>:
  80313d:	55                   	push   %rbp
  80313e:	48 89 e5             	mov    %rsp,%rbp
  803141:	48 83 ec 10          	sub    $0x10,%rsp
  803145:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80314d:	48 89 c7             	mov    %rax,%rdi
  803150:	48 b8 0b 42 80 00 00 	movabs $0x80420b,%rax
  803157:	00 00 00 
  80315a:	ff d0                	callq  *%rax
  80315c:	83 f8 01             	cmp    $0x1,%eax
  80315f:	75 17                	jne    803178 <devsock_close+0x3b>
  803161:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803165:	8b 40 0c             	mov    0xc(%rax),%eax
  803168:	89 c7                	mov    %eax,%edi
  80316a:	48 b8 a9 34 80 00 00 	movabs $0x8034a9,%rax
  803171:	00 00 00 
  803174:	ff d0                	callq  *%rax
  803176:	eb 05                	jmp    80317d <devsock_close+0x40>
  803178:	b8 00 00 00 00       	mov    $0x0,%eax
  80317d:	c9                   	leaveq 
  80317e:	c3                   	retq   

000000000080317f <connect>:
  80317f:	55                   	push   %rbp
  803180:	48 89 e5             	mov    %rsp,%rbp
  803183:	48 83 ec 20          	sub    $0x20,%rsp
  803187:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80318a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80318e:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803191:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803194:	89 c7                	mov    %eax,%edi
  803196:	48 b8 45 2f 80 00 00 	movabs $0x802f45,%rax
  80319d:	00 00 00 
  8031a0:	ff d0                	callq  *%rax
  8031a2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031a9:	79 05                	jns    8031b0 <connect+0x31>
  8031ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031ae:	eb 1b                	jmp    8031cb <connect+0x4c>
  8031b0:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8031b3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8031b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031ba:	48 89 ce             	mov    %rcx,%rsi
  8031bd:	89 c7                	mov    %eax,%edi
  8031bf:	48 b8 d6 34 80 00 00 	movabs $0x8034d6,%rax
  8031c6:	00 00 00 
  8031c9:	ff d0                	callq  *%rax
  8031cb:	c9                   	leaveq 
  8031cc:	c3                   	retq   

00000000008031cd <listen>:
  8031cd:	55                   	push   %rbp
  8031ce:	48 89 e5             	mov    %rsp,%rbp
  8031d1:	48 83 ec 20          	sub    $0x20,%rsp
  8031d5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8031d8:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8031db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8031de:	89 c7                	mov    %eax,%edi
  8031e0:	48 b8 45 2f 80 00 00 	movabs $0x802f45,%rax
  8031e7:	00 00 00 
  8031ea:	ff d0                	callq  *%rax
  8031ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031f3:	79 05                	jns    8031fa <listen+0x2d>
  8031f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031f8:	eb 16                	jmp    803210 <listen+0x43>
  8031fa:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8031fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803200:	89 d6                	mov    %edx,%esi
  803202:	89 c7                	mov    %eax,%edi
  803204:	48 b8 3a 35 80 00 00 	movabs $0x80353a,%rax
  80320b:	00 00 00 
  80320e:	ff d0                	callq  *%rax
  803210:	c9                   	leaveq 
  803211:	c3                   	retq   

0000000000803212 <devsock_read>:
  803212:	55                   	push   %rbp
  803213:	48 89 e5             	mov    %rsp,%rbp
  803216:	48 83 ec 20          	sub    $0x20,%rsp
  80321a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80321e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803222:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803226:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80322a:	89 c2                	mov    %eax,%edx
  80322c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803230:	8b 40 0c             	mov    0xc(%rax),%eax
  803233:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803237:	b9 00 00 00 00       	mov    $0x0,%ecx
  80323c:	89 c7                	mov    %eax,%edi
  80323e:	48 b8 7a 35 80 00 00 	movabs $0x80357a,%rax
  803245:	00 00 00 
  803248:	ff d0                	callq  *%rax
  80324a:	c9                   	leaveq 
  80324b:	c3                   	retq   

000000000080324c <devsock_write>:
  80324c:	55                   	push   %rbp
  80324d:	48 89 e5             	mov    %rsp,%rbp
  803250:	48 83 ec 20          	sub    $0x20,%rsp
  803254:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803258:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80325c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803260:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803264:	89 c2                	mov    %eax,%edx
  803266:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80326a:	8b 40 0c             	mov    0xc(%rax),%eax
  80326d:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803271:	b9 00 00 00 00       	mov    $0x0,%ecx
  803276:	89 c7                	mov    %eax,%edi
  803278:	48 b8 46 36 80 00 00 	movabs $0x803646,%rax
  80327f:	00 00 00 
  803282:	ff d0                	callq  *%rax
  803284:	c9                   	leaveq 
  803285:	c3                   	retq   

0000000000803286 <devsock_stat>:
  803286:	55                   	push   %rbp
  803287:	48 89 e5             	mov    %rsp,%rbp
  80328a:	48 83 ec 10          	sub    $0x10,%rsp
  80328e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803292:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803296:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80329a:	48 be ca 49 80 00 00 	movabs $0x8049ca,%rsi
  8032a1:	00 00 00 
  8032a4:	48 89 c7             	mov    %rax,%rdi
  8032a7:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  8032ae:	00 00 00 
  8032b1:	ff d0                	callq  *%rax
  8032b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8032b8:	c9                   	leaveq 
  8032b9:	c3                   	retq   

00000000008032ba <socket>:
  8032ba:	55                   	push   %rbp
  8032bb:	48 89 e5             	mov    %rsp,%rbp
  8032be:	48 83 ec 20          	sub    $0x20,%rsp
  8032c2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8032c5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8032c8:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  8032cb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8032ce:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8032d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8032d4:	89 ce                	mov    %ecx,%esi
  8032d6:	89 c7                	mov    %eax,%edi
  8032d8:	48 b8 fe 36 80 00 00 	movabs $0x8036fe,%rax
  8032df:	00 00 00 
  8032e2:	ff d0                	callq  *%rax
  8032e4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032eb:	79 05                	jns    8032f2 <socket+0x38>
  8032ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032f0:	eb 11                	jmp    803303 <socket+0x49>
  8032f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032f5:	89 c7                	mov    %eax,%edi
  8032f7:	48 b8 9c 2f 80 00 00 	movabs $0x802f9c,%rax
  8032fe:	00 00 00 
  803301:	ff d0                	callq  *%rax
  803303:	c9                   	leaveq 
  803304:	c3                   	retq   

0000000000803305 <nsipc>:
  803305:	55                   	push   %rbp
  803306:	48 89 e5             	mov    %rsp,%rbp
  803309:	48 83 ec 10          	sub    $0x10,%rsp
  80330d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803310:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  803317:	00 00 00 
  80331a:	8b 00                	mov    (%rax),%eax
  80331c:	85 c0                	test   %eax,%eax
  80331e:	75 1d                	jne    80333d <nsipc+0x38>
  803320:	bf 02 00 00 00       	mov    $0x2,%edi
  803325:	48 b8 99 41 80 00 00 	movabs $0x804199,%rax
  80332c:	00 00 00 
  80332f:	ff d0                	callq  *%rax
  803331:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  803338:	00 00 00 
  80333b:	89 02                	mov    %eax,(%rdx)
  80333d:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  803344:	00 00 00 
  803347:	8b 00                	mov    (%rax),%eax
  803349:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80334c:	b9 07 00 00 00       	mov    $0x7,%ecx
  803351:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  803358:	00 00 00 
  80335b:	89 c7                	mov    %eax,%edi
  80335d:	48 b8 8e 40 80 00 00 	movabs $0x80408e,%rax
  803364:	00 00 00 
  803367:	ff d0                	callq  *%rax
  803369:	ba 00 00 00 00       	mov    $0x0,%edx
  80336e:	be 00 00 00 00       	mov    $0x0,%esi
  803373:	bf 00 00 00 00       	mov    $0x0,%edi
  803378:	48 b8 cd 3f 80 00 00 	movabs $0x803fcd,%rax
  80337f:	00 00 00 
  803382:	ff d0                	callq  *%rax
  803384:	c9                   	leaveq 
  803385:	c3                   	retq   

0000000000803386 <nsipc_accept>:
  803386:	55                   	push   %rbp
  803387:	48 89 e5             	mov    %rsp,%rbp
  80338a:	48 83 ec 30          	sub    $0x30,%rsp
  80338e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803391:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803395:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803399:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033a0:	00 00 00 
  8033a3:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8033a6:	89 10                	mov    %edx,(%rax)
  8033a8:	bf 01 00 00 00       	mov    $0x1,%edi
  8033ad:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  8033b4:	00 00 00 
  8033b7:	ff d0                	callq  *%rax
  8033b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033c0:	78 3e                	js     803400 <nsipc_accept+0x7a>
  8033c2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033c9:	00 00 00 
  8033cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8033d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8033d4:	8b 40 10             	mov    0x10(%rax),%eax
  8033d7:	89 c2                	mov    %eax,%edx
  8033d9:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8033dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8033e1:	48 89 ce             	mov    %rcx,%rsi
  8033e4:	48 89 c7             	mov    %rax,%rdi
  8033e7:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  8033ee:	00 00 00 
  8033f1:	ff d0                	callq  *%rax
  8033f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8033f7:	8b 50 10             	mov    0x10(%rax),%edx
  8033fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8033fe:	89 10                	mov    %edx,(%rax)
  803400:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803403:	c9                   	leaveq 
  803404:	c3                   	retq   

0000000000803405 <nsipc_bind>:
  803405:	55                   	push   %rbp
  803406:	48 89 e5             	mov    %rsp,%rbp
  803409:	48 83 ec 10          	sub    $0x10,%rsp
  80340d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803410:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803414:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803417:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80341e:	00 00 00 
  803421:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803424:	89 10                	mov    %edx,(%rax)
  803426:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803429:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80342d:	48 89 c6             	mov    %rax,%rsi
  803430:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803437:	00 00 00 
  80343a:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  803441:	00 00 00 
  803444:	ff d0                	callq  *%rax
  803446:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80344d:	00 00 00 
  803450:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803453:	89 50 14             	mov    %edx,0x14(%rax)
  803456:	bf 02 00 00 00       	mov    $0x2,%edi
  80345b:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  803462:	00 00 00 
  803465:	ff d0                	callq  *%rax
  803467:	c9                   	leaveq 
  803468:	c3                   	retq   

0000000000803469 <nsipc_shutdown>:
  803469:	55                   	push   %rbp
  80346a:	48 89 e5             	mov    %rsp,%rbp
  80346d:	48 83 ec 10          	sub    $0x10,%rsp
  803471:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803474:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803477:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80347e:	00 00 00 
  803481:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803484:	89 10                	mov    %edx,(%rax)
  803486:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80348d:	00 00 00 
  803490:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803493:	89 50 04             	mov    %edx,0x4(%rax)
  803496:	bf 03 00 00 00       	mov    $0x3,%edi
  80349b:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  8034a2:	00 00 00 
  8034a5:	ff d0                	callq  *%rax
  8034a7:	c9                   	leaveq 
  8034a8:	c3                   	retq   

00000000008034a9 <nsipc_close>:
  8034a9:	55                   	push   %rbp
  8034aa:	48 89 e5             	mov    %rsp,%rbp
  8034ad:	48 83 ec 10          	sub    $0x10,%rsp
  8034b1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8034b4:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8034bb:	00 00 00 
  8034be:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8034c1:	89 10                	mov    %edx,(%rax)
  8034c3:	bf 04 00 00 00       	mov    $0x4,%edi
  8034c8:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  8034cf:	00 00 00 
  8034d2:	ff d0                	callq  *%rax
  8034d4:	c9                   	leaveq 
  8034d5:	c3                   	retq   

00000000008034d6 <nsipc_connect>:
  8034d6:	55                   	push   %rbp
  8034d7:	48 89 e5             	mov    %rsp,%rbp
  8034da:	48 83 ec 10          	sub    $0x10,%rsp
  8034de:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8034e1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8034e5:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8034e8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8034ef:	00 00 00 
  8034f2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8034f5:	89 10                	mov    %edx,(%rax)
  8034f7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8034fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8034fe:	48 89 c6             	mov    %rax,%rsi
  803501:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803508:	00 00 00 
  80350b:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  803512:	00 00 00 
  803515:	ff d0                	callq  *%rax
  803517:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80351e:	00 00 00 
  803521:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803524:	89 50 14             	mov    %edx,0x14(%rax)
  803527:	bf 05 00 00 00       	mov    $0x5,%edi
  80352c:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  803533:	00 00 00 
  803536:	ff d0                	callq  *%rax
  803538:	c9                   	leaveq 
  803539:	c3                   	retq   

000000000080353a <nsipc_listen>:
  80353a:	55                   	push   %rbp
  80353b:	48 89 e5             	mov    %rsp,%rbp
  80353e:	48 83 ec 10          	sub    $0x10,%rsp
  803542:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803545:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803548:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80354f:	00 00 00 
  803552:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803555:	89 10                	mov    %edx,(%rax)
  803557:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80355e:	00 00 00 
  803561:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803564:	89 50 04             	mov    %edx,0x4(%rax)
  803567:	bf 06 00 00 00       	mov    $0x6,%edi
  80356c:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  803573:	00 00 00 
  803576:	ff d0                	callq  *%rax
  803578:	c9                   	leaveq 
  803579:	c3                   	retq   

000000000080357a <nsipc_recv>:
  80357a:	55                   	push   %rbp
  80357b:	48 89 e5             	mov    %rsp,%rbp
  80357e:	48 83 ec 30          	sub    $0x30,%rsp
  803582:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803585:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803589:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80358c:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80358f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803596:	00 00 00 
  803599:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80359c:	89 10                	mov    %edx,(%rax)
  80359e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8035a5:	00 00 00 
  8035a8:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8035ab:	89 50 04             	mov    %edx,0x4(%rax)
  8035ae:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8035b5:	00 00 00 
  8035b8:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8035bb:	89 50 08             	mov    %edx,0x8(%rax)
  8035be:	bf 07 00 00 00       	mov    $0x7,%edi
  8035c3:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  8035ca:	00 00 00 
  8035cd:	ff d0                	callq  *%rax
  8035cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035d6:	78 69                	js     803641 <nsipc_recv+0xc7>
  8035d8:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  8035df:	7f 08                	jg     8035e9 <nsipc_recv+0x6f>
  8035e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035e4:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  8035e7:	7e 35                	jle    80361e <nsipc_recv+0xa4>
  8035e9:	48 b9 d1 49 80 00 00 	movabs $0x8049d1,%rcx
  8035f0:	00 00 00 
  8035f3:	48 ba e6 49 80 00 00 	movabs $0x8049e6,%rdx
  8035fa:	00 00 00 
  8035fd:	be 62 00 00 00       	mov    $0x62,%esi
  803602:	48 bf fb 49 80 00 00 	movabs $0x8049fb,%rdi
  803609:	00 00 00 
  80360c:	b8 00 00 00 00       	mov    $0x0,%eax
  803611:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  803618:	00 00 00 
  80361b:	41 ff d0             	callq  *%r8
  80361e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803621:	48 63 d0             	movslq %eax,%rdx
  803624:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803628:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  80362f:	00 00 00 
  803632:	48 89 c7             	mov    %rax,%rdi
  803635:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  80363c:	00 00 00 
  80363f:	ff d0                	callq  *%rax
  803641:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803644:	c9                   	leaveq 
  803645:	c3                   	retq   

0000000000803646 <nsipc_send>:
  803646:	55                   	push   %rbp
  803647:	48 89 e5             	mov    %rsp,%rbp
  80364a:	48 83 ec 20          	sub    $0x20,%rsp
  80364e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803651:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803655:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803658:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80365b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803662:	00 00 00 
  803665:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803668:	89 10                	mov    %edx,(%rax)
  80366a:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803671:	7e 35                	jle    8036a8 <nsipc_send+0x62>
  803673:	48 b9 0a 4a 80 00 00 	movabs $0x804a0a,%rcx
  80367a:	00 00 00 
  80367d:	48 ba e6 49 80 00 00 	movabs $0x8049e6,%rdx
  803684:	00 00 00 
  803687:	be 6d 00 00 00       	mov    $0x6d,%esi
  80368c:	48 bf fb 49 80 00 00 	movabs $0x8049fb,%rdi
  803693:	00 00 00 
  803696:	b8 00 00 00 00       	mov    $0x0,%eax
  80369b:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  8036a2:	00 00 00 
  8036a5:	41 ff d0             	callq  *%r8
  8036a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8036ab:	48 63 d0             	movslq %eax,%rdx
  8036ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036b2:	48 89 c6             	mov    %rax,%rsi
  8036b5:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  8036bc:	00 00 00 
  8036bf:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  8036c6:	00 00 00 
  8036c9:	ff d0                	callq  *%rax
  8036cb:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8036d2:	00 00 00 
  8036d5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8036d8:	89 50 04             	mov    %edx,0x4(%rax)
  8036db:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8036e2:	00 00 00 
  8036e5:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8036e8:	89 50 08             	mov    %edx,0x8(%rax)
  8036eb:	bf 08 00 00 00       	mov    $0x8,%edi
  8036f0:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  8036f7:	00 00 00 
  8036fa:	ff d0                	callq  *%rax
  8036fc:	c9                   	leaveq 
  8036fd:	c3                   	retq   

00000000008036fe <nsipc_socket>:
  8036fe:	55                   	push   %rbp
  8036ff:	48 89 e5             	mov    %rsp,%rbp
  803702:	48 83 ec 10          	sub    $0x10,%rsp
  803706:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803709:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80370c:	89 55 f4             	mov    %edx,-0xc(%rbp)
  80370f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803716:	00 00 00 
  803719:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80371c:	89 10                	mov    %edx,(%rax)
  80371e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803725:	00 00 00 
  803728:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80372b:	89 50 04             	mov    %edx,0x4(%rax)
  80372e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803735:	00 00 00 
  803738:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80373b:	89 50 08             	mov    %edx,0x8(%rax)
  80373e:	bf 09 00 00 00       	mov    $0x9,%edi
  803743:	48 b8 05 33 80 00 00 	movabs $0x803305,%rax
  80374a:	00 00 00 
  80374d:	ff d0                	callq  *%rax
  80374f:	c9                   	leaveq 
  803750:	c3                   	retq   

0000000000803751 <pipe>:
  803751:	55                   	push   %rbp
  803752:	48 89 e5             	mov    %rsp,%rbp
  803755:	53                   	push   %rbx
  803756:	48 83 ec 38          	sub    $0x38,%rsp
  80375a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  80375e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803762:	48 89 c7             	mov    %rax,%rdi
  803765:	48 b8 68 1f 80 00 00 	movabs $0x801f68,%rax
  80376c:	00 00 00 
  80376f:	ff d0                	callq  *%rax
  803771:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803774:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803778:	0f 88 bf 01 00 00    	js     80393d <pipe+0x1ec>
  80377e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803782:	ba 07 04 00 00       	mov    $0x407,%edx
  803787:	48 89 c6             	mov    %rax,%rsi
  80378a:	bf 00 00 00 00       	mov    $0x0,%edi
  80378f:	48 b8 3a 1b 80 00 00 	movabs $0x801b3a,%rax
  803796:	00 00 00 
  803799:	ff d0                	callq  *%rax
  80379b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80379e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8037a2:	0f 88 95 01 00 00    	js     80393d <pipe+0x1ec>
  8037a8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8037ac:	48 89 c7             	mov    %rax,%rdi
  8037af:	48 b8 68 1f 80 00 00 	movabs $0x801f68,%rax
  8037b6:	00 00 00 
  8037b9:	ff d0                	callq  *%rax
  8037bb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8037be:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8037c2:	0f 88 5d 01 00 00    	js     803925 <pipe+0x1d4>
  8037c8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8037cc:	ba 07 04 00 00       	mov    $0x407,%edx
  8037d1:	48 89 c6             	mov    %rax,%rsi
  8037d4:	bf 00 00 00 00       	mov    $0x0,%edi
  8037d9:	48 b8 3a 1b 80 00 00 	movabs $0x801b3a,%rax
  8037e0:	00 00 00 
  8037e3:	ff d0                	callq  *%rax
  8037e5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8037e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8037ec:	0f 88 33 01 00 00    	js     803925 <pipe+0x1d4>
  8037f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8037f6:	48 89 c7             	mov    %rax,%rdi
  8037f9:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803800:	00 00 00 
  803803:	ff d0                	callq  *%rax
  803805:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803809:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80380d:	ba 07 04 00 00       	mov    $0x407,%edx
  803812:	48 89 c6             	mov    %rax,%rsi
  803815:	bf 00 00 00 00       	mov    $0x0,%edi
  80381a:	48 b8 3a 1b 80 00 00 	movabs $0x801b3a,%rax
  803821:	00 00 00 
  803824:	ff d0                	callq  *%rax
  803826:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803829:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80382d:	79 05                	jns    803834 <pipe+0xe3>
  80382f:	e9 d9 00 00 00       	jmpq   80390d <pipe+0x1bc>
  803834:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803838:	48 89 c7             	mov    %rax,%rdi
  80383b:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803842:	00 00 00 
  803845:	ff d0                	callq  *%rax
  803847:	48 89 c2             	mov    %rax,%rdx
  80384a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80384e:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803854:	48 89 d1             	mov    %rdx,%rcx
  803857:	ba 00 00 00 00       	mov    $0x0,%edx
  80385c:	48 89 c6             	mov    %rax,%rsi
  80385f:	bf 00 00 00 00       	mov    $0x0,%edi
  803864:	48 b8 8a 1b 80 00 00 	movabs $0x801b8a,%rax
  80386b:	00 00 00 
  80386e:	ff d0                	callq  *%rax
  803870:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803873:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803877:	79 1b                	jns    803894 <pipe+0x143>
  803879:	90                   	nop
  80387a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80387e:	48 89 c6             	mov    %rax,%rsi
  803881:	bf 00 00 00 00       	mov    $0x0,%edi
  803886:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  80388d:	00 00 00 
  803890:	ff d0                	callq  *%rax
  803892:	eb 79                	jmp    80390d <pipe+0x1bc>
  803894:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803898:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  80389f:	00 00 00 
  8038a2:	8b 12                	mov    (%rdx),%edx
  8038a4:	89 10                	mov    %edx,(%rax)
  8038a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038aa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  8038b1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8038b5:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  8038bc:	00 00 00 
  8038bf:	8b 12                	mov    (%rdx),%edx
  8038c1:	89 10                	mov    %edx,(%rax)
  8038c3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8038c7:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8038ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038d2:	48 89 c7             	mov    %rax,%rdi
  8038d5:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  8038dc:	00 00 00 
  8038df:	ff d0                	callq  *%rax
  8038e1:	89 c2                	mov    %eax,%edx
  8038e3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8038e7:	89 10                	mov    %edx,(%rax)
  8038e9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8038ed:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8038f1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8038f5:	48 89 c7             	mov    %rax,%rdi
  8038f8:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  8038ff:	00 00 00 
  803902:	ff d0                	callq  *%rax
  803904:	89 03                	mov    %eax,(%rbx)
  803906:	b8 00 00 00 00       	mov    $0x0,%eax
  80390b:	eb 33                	jmp    803940 <pipe+0x1ef>
  80390d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803911:	48 89 c6             	mov    %rax,%rsi
  803914:	bf 00 00 00 00       	mov    $0x0,%edi
  803919:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  803920:	00 00 00 
  803923:	ff d0                	callq  *%rax
  803925:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803929:	48 89 c6             	mov    %rax,%rsi
  80392c:	bf 00 00 00 00       	mov    $0x0,%edi
  803931:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  803938:	00 00 00 
  80393b:	ff d0                	callq  *%rax
  80393d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803940:	48 83 c4 38          	add    $0x38,%rsp
  803944:	5b                   	pop    %rbx
  803945:	5d                   	pop    %rbp
  803946:	c3                   	retq   

0000000000803947 <_pipeisclosed>:
  803947:	55                   	push   %rbp
  803948:	48 89 e5             	mov    %rsp,%rbp
  80394b:	53                   	push   %rbx
  80394c:	48 83 ec 28          	sub    $0x28,%rsp
  803950:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803954:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803958:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80395f:	00 00 00 
  803962:	48 8b 00             	mov    (%rax),%rax
  803965:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80396b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80396e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803972:	48 89 c7             	mov    %rax,%rdi
  803975:	48 b8 0b 42 80 00 00 	movabs $0x80420b,%rax
  80397c:	00 00 00 
  80397f:	ff d0                	callq  *%rax
  803981:	89 c3                	mov    %eax,%ebx
  803983:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803987:	48 89 c7             	mov    %rax,%rdi
  80398a:	48 b8 0b 42 80 00 00 	movabs $0x80420b,%rax
  803991:	00 00 00 
  803994:	ff d0                	callq  *%rax
  803996:	39 c3                	cmp    %eax,%ebx
  803998:	0f 94 c0             	sete   %al
  80399b:	0f b6 c0             	movzbl %al,%eax
  80399e:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8039a1:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8039a8:	00 00 00 
  8039ab:	48 8b 00             	mov    (%rax),%rax
  8039ae:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8039b4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8039b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039ba:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8039bd:	75 05                	jne    8039c4 <_pipeisclosed+0x7d>
  8039bf:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8039c2:	eb 4f                	jmp    803a13 <_pipeisclosed+0xcc>
  8039c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039c7:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8039ca:	74 42                	je     803a0e <_pipeisclosed+0xc7>
  8039cc:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8039d0:	75 3c                	jne    803a0e <_pipeisclosed+0xc7>
  8039d2:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8039d9:	00 00 00 
  8039dc:	48 8b 00             	mov    (%rax),%rax
  8039df:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  8039e5:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8039e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039eb:	89 c6                	mov    %eax,%esi
  8039ed:	48 bf 1b 4a 80 00 00 	movabs $0x804a1b,%rdi
  8039f4:	00 00 00 
  8039f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8039fc:	49 b8 56 06 80 00 00 	movabs $0x800656,%r8
  803a03:	00 00 00 
  803a06:	41 ff d0             	callq  *%r8
  803a09:	e9 4a ff ff ff       	jmpq   803958 <_pipeisclosed+0x11>
  803a0e:	e9 45 ff ff ff       	jmpq   803958 <_pipeisclosed+0x11>
  803a13:	48 83 c4 28          	add    $0x28,%rsp
  803a17:	5b                   	pop    %rbx
  803a18:	5d                   	pop    %rbp
  803a19:	c3                   	retq   

0000000000803a1a <pipeisclosed>:
  803a1a:	55                   	push   %rbp
  803a1b:	48 89 e5             	mov    %rsp,%rbp
  803a1e:	48 83 ec 30          	sub    $0x30,%rsp
  803a22:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803a25:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803a29:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803a2c:	48 89 d6             	mov    %rdx,%rsi
  803a2f:	89 c7                	mov    %eax,%edi
  803a31:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  803a38:	00 00 00 
  803a3b:	ff d0                	callq  *%rax
  803a3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a40:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a44:	79 05                	jns    803a4b <pipeisclosed+0x31>
  803a46:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a49:	eb 31                	jmp    803a7c <pipeisclosed+0x62>
  803a4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a4f:	48 89 c7             	mov    %rax,%rdi
  803a52:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803a59:	00 00 00 
  803a5c:	ff d0                	callq  *%rax
  803a5e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803a62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a66:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803a6a:	48 89 d6             	mov    %rdx,%rsi
  803a6d:	48 89 c7             	mov    %rax,%rdi
  803a70:	48 b8 47 39 80 00 00 	movabs $0x803947,%rax
  803a77:	00 00 00 
  803a7a:	ff d0                	callq  *%rax
  803a7c:	c9                   	leaveq 
  803a7d:	c3                   	retq   

0000000000803a7e <devpipe_read>:
  803a7e:	55                   	push   %rbp
  803a7f:	48 89 e5             	mov    %rsp,%rbp
  803a82:	48 83 ec 40          	sub    $0x40,%rsp
  803a86:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803a8a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803a8e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803a92:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a96:	48 89 c7             	mov    %rax,%rdi
  803a99:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803aa0:	00 00 00 
  803aa3:	ff d0                	callq  *%rax
  803aa5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803aa9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803aad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803ab1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803ab8:	00 
  803ab9:	e9 92 00 00 00       	jmpq   803b50 <devpipe_read+0xd2>
  803abe:	eb 41                	jmp    803b01 <devpipe_read+0x83>
  803ac0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  803ac5:	74 09                	je     803ad0 <devpipe_read+0x52>
  803ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803acb:	e9 92 00 00 00       	jmpq   803b62 <devpipe_read+0xe4>
  803ad0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803ad4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ad8:	48 89 d6             	mov    %rdx,%rsi
  803adb:	48 89 c7             	mov    %rax,%rdi
  803ade:	48 b8 47 39 80 00 00 	movabs $0x803947,%rax
  803ae5:	00 00 00 
  803ae8:	ff d0                	callq  *%rax
  803aea:	85 c0                	test   %eax,%eax
  803aec:	74 07                	je     803af5 <devpipe_read+0x77>
  803aee:	b8 00 00 00 00       	mov    $0x0,%eax
  803af3:	eb 6d                	jmp    803b62 <devpipe_read+0xe4>
  803af5:	48 b8 fc 1a 80 00 00 	movabs $0x801afc,%rax
  803afc:	00 00 00 
  803aff:	ff d0                	callq  *%rax
  803b01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b05:	8b 10                	mov    (%rax),%edx
  803b07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b0b:	8b 40 04             	mov    0x4(%rax),%eax
  803b0e:	39 c2                	cmp    %eax,%edx
  803b10:	74 ae                	je     803ac0 <devpipe_read+0x42>
  803b12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b16:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803b1a:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  803b1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b22:	8b 00                	mov    (%rax),%eax
  803b24:	99                   	cltd   
  803b25:	c1 ea 1b             	shr    $0x1b,%edx
  803b28:	01 d0                	add    %edx,%eax
  803b2a:	83 e0 1f             	and    $0x1f,%eax
  803b2d:	29 d0                	sub    %edx,%eax
  803b2f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803b33:	48 98                	cltq   
  803b35:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  803b3a:	88 01                	mov    %al,(%rcx)
  803b3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b40:	8b 00                	mov    (%rax),%eax
  803b42:	8d 50 01             	lea    0x1(%rax),%edx
  803b45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b49:	89 10                	mov    %edx,(%rax)
  803b4b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b54:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803b58:	0f 82 60 ff ff ff    	jb     803abe <devpipe_read+0x40>
  803b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b62:	c9                   	leaveq 
  803b63:	c3                   	retq   

0000000000803b64 <devpipe_write>:
  803b64:	55                   	push   %rbp
  803b65:	48 89 e5             	mov    %rsp,%rbp
  803b68:	48 83 ec 40          	sub    $0x40,%rsp
  803b6c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803b70:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803b74:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803b78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b7c:	48 89 c7             	mov    %rax,%rdi
  803b7f:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803b86:	00 00 00 
  803b89:	ff d0                	callq  *%rax
  803b8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803b8f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803b93:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803b97:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803b9e:	00 
  803b9f:	e9 8e 00 00 00       	jmpq   803c32 <devpipe_write+0xce>
  803ba4:	eb 31                	jmp    803bd7 <devpipe_write+0x73>
  803ba6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803baa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bae:	48 89 d6             	mov    %rdx,%rsi
  803bb1:	48 89 c7             	mov    %rax,%rdi
  803bb4:	48 b8 47 39 80 00 00 	movabs $0x803947,%rax
  803bbb:	00 00 00 
  803bbe:	ff d0                	callq  *%rax
  803bc0:	85 c0                	test   %eax,%eax
  803bc2:	74 07                	je     803bcb <devpipe_write+0x67>
  803bc4:	b8 00 00 00 00       	mov    $0x0,%eax
  803bc9:	eb 79                	jmp    803c44 <devpipe_write+0xe0>
  803bcb:	48 b8 fc 1a 80 00 00 	movabs $0x801afc,%rax
  803bd2:	00 00 00 
  803bd5:	ff d0                	callq  *%rax
  803bd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bdb:	8b 40 04             	mov    0x4(%rax),%eax
  803bde:	48 63 d0             	movslq %eax,%rdx
  803be1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803be5:	8b 00                	mov    (%rax),%eax
  803be7:	48 98                	cltq   
  803be9:	48 83 c0 20          	add    $0x20,%rax
  803bed:	48 39 c2             	cmp    %rax,%rdx
  803bf0:	73 b4                	jae    803ba6 <devpipe_write+0x42>
  803bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bf6:	8b 40 04             	mov    0x4(%rax),%eax
  803bf9:	99                   	cltd   
  803bfa:	c1 ea 1b             	shr    $0x1b,%edx
  803bfd:	01 d0                	add    %edx,%eax
  803bff:	83 e0 1f             	and    $0x1f,%eax
  803c02:	29 d0                	sub    %edx,%eax
  803c04:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803c08:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803c0c:	48 01 ca             	add    %rcx,%rdx
  803c0f:	0f b6 0a             	movzbl (%rdx),%ecx
  803c12:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803c16:	48 98                	cltq   
  803c18:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803c1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c20:	8b 40 04             	mov    0x4(%rax),%eax
  803c23:	8d 50 01             	lea    0x1(%rax),%edx
  803c26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c2a:	89 50 04             	mov    %edx,0x4(%rax)
  803c2d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803c32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c36:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803c3a:	0f 82 64 ff ff ff    	jb     803ba4 <devpipe_write+0x40>
  803c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c44:	c9                   	leaveq 
  803c45:	c3                   	retq   

0000000000803c46 <devpipe_stat>:
  803c46:	55                   	push   %rbp
  803c47:	48 89 e5             	mov    %rsp,%rbp
  803c4a:	48 83 ec 20          	sub    $0x20,%rsp
  803c4e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803c52:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803c5a:	48 89 c7             	mov    %rax,%rdi
  803c5d:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803c64:	00 00 00 
  803c67:	ff d0                	callq  *%rax
  803c69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803c6d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803c71:	48 be 2e 4a 80 00 00 	movabs $0x804a2e,%rsi
  803c78:	00 00 00 
  803c7b:	48 89 c7             	mov    %rax,%rdi
  803c7e:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  803c85:	00 00 00 
  803c88:	ff d0                	callq  *%rax
  803c8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c8e:	8b 50 04             	mov    0x4(%rax),%edx
  803c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c95:	8b 00                	mov    (%rax),%eax
  803c97:	29 c2                	sub    %eax,%edx
  803c99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803c9d:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803ca3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ca7:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803cae:	00 00 00 
  803cb1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803cb5:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  803cbc:	00 00 00 
  803cbf:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  803cc6:	b8 00 00 00 00       	mov    $0x0,%eax
  803ccb:	c9                   	leaveq 
  803ccc:	c3                   	retq   

0000000000803ccd <devpipe_close>:
  803ccd:	55                   	push   %rbp
  803cce:	48 89 e5             	mov    %rsp,%rbp
  803cd1:	48 83 ec 10          	sub    $0x10,%rsp
  803cd5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803cd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803cdd:	48 89 c6             	mov    %rax,%rsi
  803ce0:	bf 00 00 00 00       	mov    $0x0,%edi
  803ce5:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  803cec:	00 00 00 
  803cef:	ff d0                	callq  *%rax
  803cf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803cf5:	48 89 c7             	mov    %rax,%rdi
  803cf8:	48 b8 3d 1f 80 00 00 	movabs $0x801f3d,%rax
  803cff:	00 00 00 
  803d02:	ff d0                	callq  *%rax
  803d04:	48 89 c6             	mov    %rax,%rsi
  803d07:	bf 00 00 00 00       	mov    $0x0,%edi
  803d0c:	48 b8 e5 1b 80 00 00 	movabs $0x801be5,%rax
  803d13:	00 00 00 
  803d16:	ff d0                	callq  *%rax
  803d18:	c9                   	leaveq 
  803d19:	c3                   	retq   

0000000000803d1a <cputchar>:
  803d1a:	55                   	push   %rbp
  803d1b:	48 89 e5             	mov    %rsp,%rbp
  803d1e:	48 83 ec 20          	sub    $0x20,%rsp
  803d22:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d25:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803d28:	88 45 ff             	mov    %al,-0x1(%rbp)
  803d2b:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  803d2f:	be 01 00 00 00       	mov    $0x1,%esi
  803d34:	48 89 c7             	mov    %rax,%rdi
  803d37:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  803d3e:	00 00 00 
  803d41:	ff d0                	callq  *%rax
  803d43:	c9                   	leaveq 
  803d44:	c3                   	retq   

0000000000803d45 <getchar>:
  803d45:	55                   	push   %rbp
  803d46:	48 89 e5             	mov    %rsp,%rbp
  803d49:	48 83 ec 10          	sub    $0x10,%rsp
  803d4d:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  803d51:	ba 01 00 00 00       	mov    $0x1,%edx
  803d56:	48 89 c6             	mov    %rax,%rsi
  803d59:	bf 00 00 00 00       	mov    $0x0,%edi
  803d5e:	48 b8 32 24 80 00 00 	movabs $0x802432,%rax
  803d65:	00 00 00 
  803d68:	ff d0                	callq  *%rax
  803d6a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d6d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d71:	79 05                	jns    803d78 <getchar+0x33>
  803d73:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d76:	eb 14                	jmp    803d8c <getchar+0x47>
  803d78:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d7c:	7f 07                	jg     803d85 <getchar+0x40>
  803d7e:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  803d83:	eb 07                	jmp    803d8c <getchar+0x47>
  803d85:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  803d89:	0f b6 c0             	movzbl %al,%eax
  803d8c:	c9                   	leaveq 
  803d8d:	c3                   	retq   

0000000000803d8e <iscons>:
  803d8e:	55                   	push   %rbp
  803d8f:	48 89 e5             	mov    %rsp,%rbp
  803d92:	48 83 ec 20          	sub    $0x20,%rsp
  803d96:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d99:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803d9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803da0:	48 89 d6             	mov    %rdx,%rsi
  803da3:	89 c7                	mov    %eax,%edi
  803da5:	48 b8 00 20 80 00 00 	movabs $0x802000,%rax
  803dac:	00 00 00 
  803daf:	ff d0                	callq  *%rax
  803db1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803db4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803db8:	79 05                	jns    803dbf <iscons+0x31>
  803dba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dbd:	eb 1a                	jmp    803dd9 <iscons+0x4b>
  803dbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803dc3:	8b 10                	mov    (%rax),%edx
  803dc5:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  803dcc:	00 00 00 
  803dcf:	8b 00                	mov    (%rax),%eax
  803dd1:	39 c2                	cmp    %eax,%edx
  803dd3:	0f 94 c0             	sete   %al
  803dd6:	0f b6 c0             	movzbl %al,%eax
  803dd9:	c9                   	leaveq 
  803dda:	c3                   	retq   

0000000000803ddb <opencons>:
  803ddb:	55                   	push   %rbp
  803ddc:	48 89 e5             	mov    %rsp,%rbp
  803ddf:	48 83 ec 10          	sub    $0x10,%rsp
  803de3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803de7:	48 89 c7             	mov    %rax,%rdi
  803dea:	48 b8 68 1f 80 00 00 	movabs $0x801f68,%rax
  803df1:	00 00 00 
  803df4:	ff d0                	callq  *%rax
  803df6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803df9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803dfd:	79 05                	jns    803e04 <opencons+0x29>
  803dff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e02:	eb 5b                	jmp    803e5f <opencons+0x84>
  803e04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e08:	ba 07 04 00 00       	mov    $0x407,%edx
  803e0d:	48 89 c6             	mov    %rax,%rsi
  803e10:	bf 00 00 00 00       	mov    $0x0,%edi
  803e15:	48 b8 3a 1b 80 00 00 	movabs $0x801b3a,%rax
  803e1c:	00 00 00 
  803e1f:	ff d0                	callq  *%rax
  803e21:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e24:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e28:	79 05                	jns    803e2f <opencons+0x54>
  803e2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e2d:	eb 30                	jmp    803e5f <opencons+0x84>
  803e2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e33:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  803e3a:	00 00 00 
  803e3d:	8b 12                	mov    (%rdx),%edx
  803e3f:	89 10                	mov    %edx,(%rax)
  803e41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e45:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803e4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e50:	48 89 c7             	mov    %rax,%rdi
  803e53:	48 b8 1a 1f 80 00 00 	movabs $0x801f1a,%rax
  803e5a:	00 00 00 
  803e5d:	ff d0                	callq  *%rax
  803e5f:	c9                   	leaveq 
  803e60:	c3                   	retq   

0000000000803e61 <devcons_read>:
  803e61:	55                   	push   %rbp
  803e62:	48 89 e5             	mov    %rsp,%rbp
  803e65:	48 83 ec 30          	sub    $0x30,%rsp
  803e69:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803e6d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803e71:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803e75:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803e7a:	75 07                	jne    803e83 <devcons_read+0x22>
  803e7c:	b8 00 00 00 00       	mov    $0x0,%eax
  803e81:	eb 4b                	jmp    803ece <devcons_read+0x6d>
  803e83:	eb 0c                	jmp    803e91 <devcons_read+0x30>
  803e85:	48 b8 fc 1a 80 00 00 	movabs $0x801afc,%rax
  803e8c:	00 00 00 
  803e8f:	ff d0                	callq  *%rax
  803e91:	48 b8 3c 1a 80 00 00 	movabs $0x801a3c,%rax
  803e98:	00 00 00 
  803e9b:	ff d0                	callq  *%rax
  803e9d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ea0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ea4:	74 df                	je     803e85 <devcons_read+0x24>
  803ea6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803eaa:	79 05                	jns    803eb1 <devcons_read+0x50>
  803eac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803eaf:	eb 1d                	jmp    803ece <devcons_read+0x6d>
  803eb1:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  803eb5:	75 07                	jne    803ebe <devcons_read+0x5d>
  803eb7:	b8 00 00 00 00       	mov    $0x0,%eax
  803ebc:	eb 10                	jmp    803ece <devcons_read+0x6d>
  803ebe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ec1:	89 c2                	mov    %eax,%edx
  803ec3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ec7:	88 10                	mov    %dl,(%rax)
  803ec9:	b8 01 00 00 00       	mov    $0x1,%eax
  803ece:	c9                   	leaveq 
  803ecf:	c3                   	retq   

0000000000803ed0 <devcons_write>:
  803ed0:	55                   	push   %rbp
  803ed1:	48 89 e5             	mov    %rsp,%rbp
  803ed4:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  803edb:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  803ee2:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  803ee9:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  803ef0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803ef7:	eb 76                	jmp    803f6f <devcons_write+0x9f>
  803ef9:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  803f00:	89 c2                	mov    %eax,%edx
  803f02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f05:	29 c2                	sub    %eax,%edx
  803f07:	89 d0                	mov    %edx,%eax
  803f09:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803f0c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f0f:	83 f8 7f             	cmp    $0x7f,%eax
  803f12:	76 07                	jbe    803f1b <devcons_write+0x4b>
  803f14:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  803f1b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f1e:	48 63 d0             	movslq %eax,%rdx
  803f21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f24:	48 63 c8             	movslq %eax,%rcx
  803f27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  803f2e:	48 01 c1             	add    %rax,%rcx
  803f31:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803f38:	48 89 ce             	mov    %rcx,%rsi
  803f3b:	48 89 c7             	mov    %rax,%rdi
  803f3e:	48 b8 2f 15 80 00 00 	movabs $0x80152f,%rax
  803f45:	00 00 00 
  803f48:	ff d0                	callq  *%rax
  803f4a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f4d:	48 63 d0             	movslq %eax,%rdx
  803f50:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803f57:	48 89 d6             	mov    %rdx,%rsi
  803f5a:	48 89 c7             	mov    %rax,%rdi
  803f5d:	48 b8 f2 19 80 00 00 	movabs $0x8019f2,%rax
  803f64:	00 00 00 
  803f67:	ff d0                	callq  *%rax
  803f69:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f6c:	01 45 fc             	add    %eax,-0x4(%rbp)
  803f6f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f72:	48 98                	cltq   
  803f74:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  803f7b:	0f 82 78 ff ff ff    	jb     803ef9 <devcons_write+0x29>
  803f81:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f84:	c9                   	leaveq 
  803f85:	c3                   	retq   

0000000000803f86 <devcons_close>:
  803f86:	55                   	push   %rbp
  803f87:	48 89 e5             	mov    %rsp,%rbp
  803f8a:	48 83 ec 08          	sub    $0x8,%rsp
  803f8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803f92:	b8 00 00 00 00       	mov    $0x0,%eax
  803f97:	c9                   	leaveq 
  803f98:	c3                   	retq   

0000000000803f99 <devcons_stat>:
  803f99:	55                   	push   %rbp
  803f9a:	48 89 e5             	mov    %rsp,%rbp
  803f9d:	48 83 ec 10          	sub    $0x10,%rsp
  803fa1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803fa5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803fa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803fad:	48 be 3a 4a 80 00 00 	movabs $0x804a3a,%rsi
  803fb4:	00 00 00 
  803fb7:	48 89 c7             	mov    %rax,%rdi
  803fba:	48 b8 0b 12 80 00 00 	movabs $0x80120b,%rax
  803fc1:	00 00 00 
  803fc4:	ff d0                	callq  *%rax
  803fc6:	b8 00 00 00 00       	mov    $0x0,%eax
  803fcb:	c9                   	leaveq 
  803fcc:	c3                   	retq   

0000000000803fcd <ipc_recv>:
  803fcd:	55                   	push   %rbp
  803fce:	48 89 e5             	mov    %rsp,%rbp
  803fd1:	48 83 ec 30          	sub    $0x30,%rsp
  803fd5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803fd9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803fdd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803fe1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803fe6:	75 0e                	jne    803ff6 <ipc_recv+0x29>
  803fe8:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803fef:	00 00 00 
  803ff2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803ff6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ffa:	48 89 c7             	mov    %rax,%rdi
  803ffd:	48 b8 63 1d 80 00 00 	movabs $0x801d63,%rax
  804004:	00 00 00 
  804007:	ff d0                	callq  *%rax
  804009:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80400c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804010:	79 27                	jns    804039 <ipc_recv+0x6c>
  804012:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804017:	74 0a                	je     804023 <ipc_recv+0x56>
  804019:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80401d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804023:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804028:	74 0a                	je     804034 <ipc_recv+0x67>
  80402a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80402e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804034:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804037:	eb 53                	jmp    80408c <ipc_recv+0xbf>
  804039:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80403e:	74 19                	je     804059 <ipc_recv+0x8c>
  804040:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  804047:	00 00 00 
  80404a:	48 8b 00             	mov    (%rax),%rax
  80404d:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  804053:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804057:	89 10                	mov    %edx,(%rax)
  804059:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80405e:	74 19                	je     804079 <ipc_recv+0xac>
  804060:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  804067:	00 00 00 
  80406a:	48 8b 00             	mov    (%rax),%rax
  80406d:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804073:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804077:	89 10                	mov    %edx,(%rax)
  804079:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  804080:	00 00 00 
  804083:	48 8b 00             	mov    (%rax),%rax
  804086:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  80408c:	c9                   	leaveq 
  80408d:	c3                   	retq   

000000000080408e <ipc_send>:
  80408e:	55                   	push   %rbp
  80408f:	48 89 e5             	mov    %rsp,%rbp
  804092:	48 83 ec 30          	sub    $0x30,%rsp
  804096:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804099:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80409c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8040a0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8040a3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8040a8:	75 10                	jne    8040ba <ipc_send+0x2c>
  8040aa:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8040b1:	00 00 00 
  8040b4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8040b8:	eb 0e                	jmp    8040c8 <ipc_send+0x3a>
  8040ba:	eb 0c                	jmp    8040c8 <ipc_send+0x3a>
  8040bc:	48 b8 fc 1a 80 00 00 	movabs $0x801afc,%rax
  8040c3:	00 00 00 
  8040c6:	ff d0                	callq  *%rax
  8040c8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8040cb:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8040ce:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8040d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8040d5:	89 c7                	mov    %eax,%edi
  8040d7:	48 b8 0e 1d 80 00 00 	movabs $0x801d0e,%rax
  8040de:	00 00 00 
  8040e1:	ff d0                	callq  *%rax
  8040e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040e6:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8040ea:	74 d0                	je     8040bc <ipc_send+0x2e>
  8040ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040f0:	79 30                	jns    804122 <ipc_send+0x94>
  8040f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040f5:	89 c1                	mov    %eax,%ecx
  8040f7:	48 ba 48 4a 80 00 00 	movabs $0x804a48,%rdx
  8040fe:	00 00 00 
  804101:	be 44 00 00 00       	mov    $0x44,%esi
  804106:	48 bf 5e 4a 80 00 00 	movabs $0x804a5e,%rdi
  80410d:	00 00 00 
  804110:	b8 00 00 00 00       	mov    $0x0,%eax
  804115:	49 b8 1d 04 80 00 00 	movabs $0x80041d,%r8
  80411c:	00 00 00 
  80411f:	41 ff d0             	callq  *%r8
  804122:	c9                   	leaveq 
  804123:	c3                   	retq   

0000000000804124 <ipc_host_recv>:
  804124:	55                   	push   %rbp
  804125:	48 89 e5             	mov    %rsp,%rbp
  804128:	48 83 ec 10          	sub    $0x10,%rsp
  80412c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804130:	48 ba 70 4a 80 00 00 	movabs $0x804a70,%rdx
  804137:	00 00 00 
  80413a:	be 4e 00 00 00       	mov    $0x4e,%esi
  80413f:	48 bf 5e 4a 80 00 00 	movabs $0x804a5e,%rdi
  804146:	00 00 00 
  804149:	b8 00 00 00 00       	mov    $0x0,%eax
  80414e:	48 b9 1d 04 80 00 00 	movabs $0x80041d,%rcx
  804155:	00 00 00 
  804158:	ff d1                	callq  *%rcx

000000000080415a <ipc_host_send>:
  80415a:	55                   	push   %rbp
  80415b:	48 89 e5             	mov    %rsp,%rbp
  80415e:	48 83 ec 20          	sub    $0x20,%rsp
  804162:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804165:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804168:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80416c:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80416f:	48 ba 90 4a 80 00 00 	movabs $0x804a90,%rdx
  804176:	00 00 00 
  804179:	be 67 00 00 00       	mov    $0x67,%esi
  80417e:	48 bf 5e 4a 80 00 00 	movabs $0x804a5e,%rdi
  804185:	00 00 00 
  804188:	b8 00 00 00 00       	mov    $0x0,%eax
  80418d:	48 b9 1d 04 80 00 00 	movabs $0x80041d,%rcx
  804194:	00 00 00 
  804197:	ff d1                	callq  *%rcx

0000000000804199 <ipc_find_env>:
  804199:	55                   	push   %rbp
  80419a:	48 89 e5             	mov    %rsp,%rbp
  80419d:	48 83 ec 14          	sub    $0x14,%rsp
  8041a1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8041a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8041ab:	eb 4e                	jmp    8041fb <ipc_find_env+0x62>
  8041ad:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8041b4:	00 00 00 
  8041b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041ba:	48 98                	cltq   
  8041bc:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8041c3:	48 01 d0             	add    %rdx,%rax
  8041c6:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8041cc:	8b 00                	mov    (%rax),%eax
  8041ce:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8041d1:	75 24                	jne    8041f7 <ipc_find_env+0x5e>
  8041d3:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8041da:	00 00 00 
  8041dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041e0:	48 98                	cltq   
  8041e2:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8041e9:	48 01 d0             	add    %rdx,%rax
  8041ec:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8041f2:	8b 40 08             	mov    0x8(%rax),%eax
  8041f5:	eb 12                	jmp    804209 <ipc_find_env+0x70>
  8041f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8041fb:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804202:	7e a9                	jle    8041ad <ipc_find_env+0x14>
  804204:	b8 00 00 00 00       	mov    $0x0,%eax
  804209:	c9                   	leaveq 
  80420a:	c3                   	retq   

000000000080420b <pageref>:
  80420b:	55                   	push   %rbp
  80420c:	48 89 e5             	mov    %rsp,%rbp
  80420f:	48 83 ec 18          	sub    $0x18,%rsp
  804213:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804217:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80421b:	48 c1 e8 15          	shr    $0x15,%rax
  80421f:	48 89 c2             	mov    %rax,%rdx
  804222:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804229:	01 00 00 
  80422c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804230:	83 e0 01             	and    $0x1,%eax
  804233:	48 85 c0             	test   %rax,%rax
  804236:	75 07                	jne    80423f <pageref+0x34>
  804238:	b8 00 00 00 00       	mov    $0x0,%eax
  80423d:	eb 53                	jmp    804292 <pageref+0x87>
  80423f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804243:	48 c1 e8 0c          	shr    $0xc,%rax
  804247:	48 89 c2             	mov    %rax,%rdx
  80424a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804251:	01 00 00 
  804254:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804258:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80425c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804260:	83 e0 01             	and    $0x1,%eax
  804263:	48 85 c0             	test   %rax,%rax
  804266:	75 07                	jne    80426f <pageref+0x64>
  804268:	b8 00 00 00 00       	mov    $0x0,%eax
  80426d:	eb 23                	jmp    804292 <pageref+0x87>
  80426f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804273:	48 c1 e8 0c          	shr    $0xc,%rax
  804277:	48 89 c2             	mov    %rax,%rdx
  80427a:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804281:	00 00 00 
  804284:	48 c1 e2 04          	shl    $0x4,%rdx
  804288:	48 01 d0             	add    %rdx,%rax
  80428b:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  80428f:	0f b7 c0             	movzwl %ax,%eax
  804292:	c9                   	leaveq 
  804293:	c3                   	retq   
