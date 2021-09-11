
vmm/guest/obj/user/testpipe:     file format elf64-x86-64


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
  80003c:	e8 fe 04 00 00       	callq  80053f <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	53                   	push   %rbx
  800048:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  80004f:	89 bd 6c ff ff ff    	mov    %edi,-0x94(%rbp)
  800055:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80005c:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800063:	00 00 00 
  800066:	48 bb 84 4c 80 00 00 	movabs $0x804c84,%rbx
  80006d:	00 00 00 
  800070:	48 89 18             	mov    %rbx,(%rax)
  800073:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  80007a:	48 89 c7             	mov    %rax,%rdi
  80007d:	48 b8 2e 3f 80 00 00 	movabs $0x803f2e,%rax
  800084:	00 00 00 
  800087:	ff d0                	callq  *%rax
  800089:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80008c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800090:	79 30                	jns    8000c2 <umain+0x7f>
  800092:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800095:	89 c1                	mov    %eax,%ecx
  800097:	48 ba 90 4c 80 00 00 	movabs $0x804c90,%rdx
  80009e:	00 00 00 
  8000a1:	be 0f 00 00 00       	mov    $0xf,%esi
  8000a6:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  8000ad:	00 00 00 
  8000b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b5:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8000bc:	00 00 00 
  8000bf:	41 ff d0             	callq  *%r8
  8000c2:	48 b8 82 24 80 00 00 	movabs $0x802482,%rax
  8000c9:	00 00 00 
  8000cc:	ff d0                	callq  *%rax
  8000ce:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8000d1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8000d5:	79 30                	jns    800107 <umain+0xc4>
  8000d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8000da:	89 c1                	mov    %eax,%ecx
  8000dc:	48 ba ac 4c 80 00 00 	movabs $0x804cac,%rdx
  8000e3:	00 00 00 
  8000e6:	be 12 00 00 00       	mov    $0x12,%esi
  8000eb:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  8000f2:	00 00 00 
  8000f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000fa:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  800101:	00 00 00 
  800104:	41 ff d0             	callq  *%r8
  800107:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80010b:	0f 85 5c 01 00 00    	jne    80026d <umain+0x22a>
  800111:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  800117:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80011e:	00 00 00 
  800121:	48 8b 00             	mov    (%rax),%rax
  800124:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80012a:	89 c6                	mov    %eax,%esi
  80012c:	48 bf b5 4c 80 00 00 	movabs $0x804cb5,%rdi
  800133:	00 00 00 
  800136:	b8 00 00 00 00       	mov    $0x0,%eax
  80013b:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  800142:	00 00 00 
  800145:	ff d1                	callq  *%rcx
  800147:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  80014d:	89 c7                	mov    %eax,%edi
  80014f:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  800156:	00 00 00 
  800159:	ff d0                	callq  *%rax
  80015b:	8b 95 70 ff ff ff    	mov    -0x90(%rbp),%edx
  800161:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800168:	00 00 00 
  80016b:	48 8b 00             	mov    (%rax),%rax
  80016e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800174:	89 c6                	mov    %eax,%esi
  800176:	48 bf d2 4c 80 00 00 	movabs $0x804cd2,%rdi
  80017d:	00 00 00 
  800180:	b8 00 00 00 00       	mov    $0x0,%eax
  800185:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  80018c:	00 00 00 
  80018f:	ff d1                	callq  *%rcx
  800191:	8b 85 70 ff ff ff    	mov    -0x90(%rbp),%eax
  800197:	48 8d 4d 80          	lea    -0x80(%rbp),%rcx
  80019b:	ba 63 00 00 00       	mov    $0x63,%edx
  8001a0:	48 89 ce             	mov    %rcx,%rsi
  8001a3:	89 c7                	mov    %eax,%edi
  8001a5:	48 b8 e4 2c 80 00 00 	movabs $0x802ce4,%rax
  8001ac:	00 00 00 
  8001af:	ff d0                	callq  *%rax
  8001b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8001b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8001b8:	79 30                	jns    8001ea <umain+0x1a7>
  8001ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001bd:	89 c1                	mov    %eax,%ecx
  8001bf:	48 ba ef 4c 80 00 00 	movabs $0x804cef,%rdx
  8001c6:	00 00 00 
  8001c9:	be 1a 00 00 00       	mov    $0x1a,%esi
  8001ce:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  8001d5:	00 00 00 
  8001d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8001dd:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8001e4:	00 00 00 
  8001e7:	41 ff d0             	callq  *%r8
  8001ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001ed:	48 98                	cltq   
  8001ef:	c6 44 05 80 00       	movb   $0x0,-0x80(%rbp,%rax,1)
  8001f4:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8001fb:	00 00 00 
  8001fe:	48 8b 10             	mov    (%rax),%rdx
  800201:	48 8d 45 80          	lea    -0x80(%rbp),%rax
  800205:	48 89 d6             	mov    %rdx,%rsi
  800208:	48 89 c7             	mov    %rax,%rdi
  80020b:	48 b8 35 15 80 00 00 	movabs $0x801535,%rax
  800212:	00 00 00 
  800215:	ff d0                	callq  *%rax
  800217:	85 c0                	test   %eax,%eax
  800219:	75 1d                	jne    800238 <umain+0x1f5>
  80021b:	48 bf f8 4c 80 00 00 	movabs $0x804cf8,%rdi
  800222:	00 00 00 
  800225:	b8 00 00 00 00       	mov    $0x0,%eax
  80022a:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  800231:	00 00 00 
  800234:	ff d2                	callq  *%rdx
  800236:	eb 24                	jmp    80025c <umain+0x219>
  800238:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
  80023c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80023f:	89 c6                	mov    %eax,%esi
  800241:	48 bf 14 4d 80 00 00 	movabs $0x804d14,%rdi
  800248:	00 00 00 
  80024b:	b8 00 00 00 00       	mov    $0x0,%eax
  800250:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  800257:	00 00 00 
  80025a:	ff d1                	callq  *%rcx
  80025c:	48 b8 c2 05 80 00 00 	movabs $0x8005c2,%rax
  800263:	00 00 00 
  800266:	ff d0                	callq  *%rax
  800268:	e9 2b 01 00 00       	jmpq   800398 <umain+0x355>
  80026d:	8b 95 70 ff ff ff    	mov    -0x90(%rbp),%edx
  800273:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80027a:	00 00 00 
  80027d:	48 8b 00             	mov    (%rax),%rax
  800280:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800286:	89 c6                	mov    %eax,%esi
  800288:	48 bf b5 4c 80 00 00 	movabs $0x804cb5,%rdi
  80028f:	00 00 00 
  800292:	b8 00 00 00 00       	mov    $0x0,%eax
  800297:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  80029e:	00 00 00 
  8002a1:	ff d1                	callq  *%rcx
  8002a3:	8b 85 70 ff ff ff    	mov    -0x90(%rbp),%eax
  8002a9:	89 c7                	mov    %eax,%edi
  8002ab:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  8002b2:	00 00 00 
  8002b5:	ff d0                	callq  *%rax
  8002b7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  8002bd:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8002c4:	00 00 00 
  8002c7:	48 8b 00             	mov    (%rax),%rax
  8002ca:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8002d0:	89 c6                	mov    %eax,%esi
  8002d2:	48 bf 27 4d 80 00 00 	movabs $0x804d27,%rdi
  8002d9:	00 00 00 
  8002dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8002e1:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  8002e8:	00 00 00 
  8002eb:	ff d1                	callq  *%rcx
  8002ed:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8002f4:	00 00 00 
  8002f7:	48 8b 00             	mov    (%rax),%rax
  8002fa:	48 89 c7             	mov    %rax,%rdi
  8002fd:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  800304:	00 00 00 
  800307:	ff d0                	callq  *%rax
  800309:	48 63 d0             	movslq %eax,%rdx
  80030c:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800313:	00 00 00 
  800316:	48 8b 08             	mov    (%rax),%rcx
  800319:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  80031f:	48 89 ce             	mov    %rcx,%rsi
  800322:	89 c7                	mov    %eax,%edi
  800324:	48 b8 59 2d 80 00 00 	movabs $0x802d59,%rax
  80032b:	00 00 00 
  80032e:	ff d0                	callq  *%rax
  800330:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800333:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80033a:	00 00 00 
  80033d:	48 8b 00             	mov    (%rax),%rax
  800340:	48 89 c7             	mov    %rax,%rdi
  800343:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  80034a:	00 00 00 
  80034d:	ff d0                	callq  *%rax
  80034f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
  800352:	74 30                	je     800384 <umain+0x341>
  800354:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800357:	89 c1                	mov    %eax,%ecx
  800359:	48 ba 44 4d 80 00 00 	movabs $0x804d44,%rdx
  800360:	00 00 00 
  800363:	be 26 00 00 00       	mov    $0x26,%esi
  800368:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  80036f:	00 00 00 
  800372:	b8 00 00 00 00       	mov    $0x0,%eax
  800377:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  80037e:	00 00 00 
  800381:	41 ff d0             	callq  *%r8
  800384:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  80038a:	89 c7                	mov    %eax,%edi
  80038c:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  800393:	00 00 00 
  800396:	ff d0                	callq  *%rax
  800398:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80039b:	89 c7                	mov    %eax,%edi
  80039d:	48 b8 f7 44 80 00 00 	movabs $0x8044f7,%rax
  8003a4:	00 00 00 
  8003a7:	ff d0                	callq  *%rax
  8003a9:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8003b0:	00 00 00 
  8003b3:	48 bb 4e 4d 80 00 00 	movabs $0x804d4e,%rbx
  8003ba:	00 00 00 
  8003bd:	48 89 18             	mov    %rbx,(%rax)
  8003c0:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8003c7:	48 89 c7             	mov    %rax,%rdi
  8003ca:	48 b8 2e 3f 80 00 00 	movabs $0x803f2e,%rax
  8003d1:	00 00 00 
  8003d4:	ff d0                	callq  *%rax
  8003d6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8003d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8003dd:	79 30                	jns    80040f <umain+0x3cc>
  8003df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8003e2:	89 c1                	mov    %eax,%ecx
  8003e4:	48 ba 90 4c 80 00 00 	movabs $0x804c90,%rdx
  8003eb:	00 00 00 
  8003ee:	be 2d 00 00 00       	mov    $0x2d,%esi
  8003f3:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  8003fa:	00 00 00 
  8003fd:	b8 00 00 00 00       	mov    $0x0,%eax
  800402:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  800409:	00 00 00 
  80040c:	41 ff d0             	callq  *%r8
  80040f:	48 b8 82 24 80 00 00 	movabs $0x802482,%rax
  800416:	00 00 00 
  800419:	ff d0                	callq  *%rax
  80041b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80041e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800422:	79 30                	jns    800454 <umain+0x411>
  800424:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800427:	89 c1                	mov    %eax,%ecx
  800429:	48 ba ac 4c 80 00 00 	movabs $0x804cac,%rdx
  800430:	00 00 00 
  800433:	be 30 00 00 00       	mov    $0x30,%esi
  800438:	48 bf 99 4c 80 00 00 	movabs $0x804c99,%rdi
  80043f:	00 00 00 
  800442:	b8 00 00 00 00       	mov    $0x0,%eax
  800447:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  80044e:	00 00 00 
  800451:	41 ff d0             	callq  *%r8
  800454:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800458:	0f 85 83 00 00 00    	jne    8004e1 <umain+0x49e>
  80045e:	8b 85 70 ff ff ff    	mov    -0x90(%rbp),%eax
  800464:	89 c7                	mov    %eax,%edi
  800466:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  80046d:	00 00 00 
  800470:	ff d0                	callq  *%rax
  800472:	48 bf 5b 4d 80 00 00 	movabs $0x804d5b,%rdi
  800479:	00 00 00 
  80047c:	b8 00 00 00 00       	mov    $0x0,%eax
  800481:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  800488:	00 00 00 
  80048b:	ff d2                	callq  *%rdx
  80048d:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  800493:	ba 01 00 00 00       	mov    $0x1,%edx
  800498:	48 be 5d 4d 80 00 00 	movabs $0x804d5d,%rsi
  80049f:	00 00 00 
  8004a2:	89 c7                	mov    %eax,%edi
  8004a4:	48 b8 59 2d 80 00 00 	movabs $0x802d59,%rax
  8004ab:	00 00 00 
  8004ae:	ff d0                	callq  *%rax
  8004b0:	83 f8 01             	cmp    $0x1,%eax
  8004b3:	74 2a                	je     8004df <umain+0x49c>
  8004b5:	90                   	nop
  8004b6:	48 bf 5f 4d 80 00 00 	movabs $0x804d5f,%rdi
  8004bd:	00 00 00 
  8004c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8004c5:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  8004cc:	00 00 00 
  8004cf:	ff d2                	callq  *%rdx
  8004d1:	48 b8 c2 05 80 00 00 	movabs $0x8005c2,%rax
  8004d8:	00 00 00 
  8004db:	ff d0                	callq  *%rax
  8004dd:	eb 02                	jmp    8004e1 <umain+0x49e>
  8004df:	eb 91                	jmp    800472 <umain+0x42f>
  8004e1:	8b 85 70 ff ff ff    	mov    -0x90(%rbp),%eax
  8004e7:	89 c7                	mov    %eax,%edi
  8004e9:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  8004f0:	00 00 00 
  8004f3:	ff d0                	callq  *%rax
  8004f5:	8b 85 74 ff ff ff    	mov    -0x8c(%rbp),%eax
  8004fb:	89 c7                	mov    %eax,%edi
  8004fd:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  800504:	00 00 00 
  800507:	ff d0                	callq  *%rax
  800509:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80050c:	89 c7                	mov    %eax,%edi
  80050e:	48 b8 f7 44 80 00 00 	movabs $0x8044f7,%rax
  800515:	00 00 00 
  800518:	ff d0                	callq  *%rax
  80051a:	48 bf 7c 4d 80 00 00 	movabs $0x804d7c,%rdi
  800521:	00 00 00 
  800524:	b8 00 00 00 00       	mov    $0x0,%eax
  800529:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  800530:	00 00 00 
  800533:	ff d2                	callq  *%rdx
  800535:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
  80053c:	5b                   	pop    %rbx
  80053d:	5d                   	pop    %rbp
  80053e:	c3                   	retq   

000000000080053f <libmain>:
  80053f:	55                   	push   %rbp
  800540:	48 89 e5             	mov    %rsp,%rbp
  800543:	48 83 ec 10          	sub    $0x10,%rsp
  800547:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80054a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80054e:	48 b8 86 1c 80 00 00 	movabs $0x801c86,%rax
  800555:	00 00 00 
  800558:	ff d0                	callq  *%rax
  80055a:	25 ff 03 00 00       	and    $0x3ff,%eax
  80055f:	48 98                	cltq   
  800561:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800568:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80056f:	00 00 00 
  800572:	48 01 c2             	add    %rax,%rdx
  800575:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80057c:	00 00 00 
  80057f:	48 89 10             	mov    %rdx,(%rax)
  800582:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800586:	7e 14                	jle    80059c <libmain+0x5d>
  800588:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80058c:	48 8b 10             	mov    (%rax),%rdx
  80058f:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800596:	00 00 00 
  800599:	48 89 10             	mov    %rdx,(%rax)
  80059c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8005a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8005a3:	48 89 d6             	mov    %rdx,%rsi
  8005a6:	89 c7                	mov    %eax,%edi
  8005a8:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8005af:	00 00 00 
  8005b2:	ff d0                	callq  *%rax
  8005b4:	48 b8 c2 05 80 00 00 	movabs $0x8005c2,%rax
  8005bb:	00 00 00 
  8005be:	ff d0                	callq  *%rax
  8005c0:	c9                   	leaveq 
  8005c1:	c3                   	retq   

00000000008005c2 <exit>:
  8005c2:	55                   	push   %rbp
  8005c3:	48 89 e5             	mov    %rsp,%rbp
  8005c6:	48 b8 38 2a 80 00 00 	movabs $0x802a38,%rax
  8005cd:	00 00 00 
  8005d0:	ff d0                	callq  *%rax
  8005d2:	bf 00 00 00 00       	mov    $0x0,%edi
  8005d7:	48 b8 42 1c 80 00 00 	movabs $0x801c42,%rax
  8005de:	00 00 00 
  8005e1:	ff d0                	callq  *%rax
  8005e3:	5d                   	pop    %rbp
  8005e4:	c3                   	retq   

00000000008005e5 <_panic>:
  8005e5:	55                   	push   %rbp
  8005e6:	48 89 e5             	mov    %rsp,%rbp
  8005e9:	53                   	push   %rbx
  8005ea:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8005f1:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8005f8:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8005fe:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800605:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  80060c:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  800613:	84 c0                	test   %al,%al
  800615:	74 23                	je     80063a <_panic+0x55>
  800617:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  80061e:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800622:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800626:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80062a:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  80062e:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800632:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800636:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80063a:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800641:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800648:	00 00 00 
  80064b:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800652:	00 00 00 
  800655:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800659:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800660:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800667:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80066e:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800675:	00 00 00 
  800678:	48 8b 18             	mov    (%rax),%rbx
  80067b:	48 b8 86 1c 80 00 00 	movabs $0x801c86,%rax
  800682:	00 00 00 
  800685:	ff d0                	callq  *%rax
  800687:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  80068d:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800694:	41 89 c8             	mov    %ecx,%r8d
  800697:	48 89 d1             	mov    %rdx,%rcx
  80069a:	48 89 da             	mov    %rbx,%rdx
  80069d:	89 c6                	mov    %eax,%esi
  80069f:	48 bf a0 4d 80 00 00 	movabs $0x804da0,%rdi
  8006a6:	00 00 00 
  8006a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8006ae:	49 b9 1e 08 80 00 00 	movabs $0x80081e,%r9
  8006b5:	00 00 00 
  8006b8:	41 ff d1             	callq  *%r9
  8006bb:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8006c2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8006c9:	48 89 d6             	mov    %rdx,%rsi
  8006cc:	48 89 c7             	mov    %rax,%rdi
  8006cf:	48 b8 72 07 80 00 00 	movabs $0x800772,%rax
  8006d6:	00 00 00 
  8006d9:	ff d0                	callq  *%rax
  8006db:	48 bf c3 4d 80 00 00 	movabs $0x804dc3,%rdi
  8006e2:	00 00 00 
  8006e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8006ea:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  8006f1:	00 00 00 
  8006f4:	ff d2                	callq  *%rdx
  8006f6:	cc                   	int3   
  8006f7:	eb fd                	jmp    8006f6 <_panic+0x111>

00000000008006f9 <putch>:
  8006f9:	55                   	push   %rbp
  8006fa:	48 89 e5             	mov    %rsp,%rbp
  8006fd:	48 83 ec 10          	sub    $0x10,%rsp
  800701:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800704:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800708:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80070c:	8b 00                	mov    (%rax),%eax
  80070e:	8d 48 01             	lea    0x1(%rax),%ecx
  800711:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800715:	89 0a                	mov    %ecx,(%rdx)
  800717:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80071a:	89 d1                	mov    %edx,%ecx
  80071c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800720:	48 98                	cltq   
  800722:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800726:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80072a:	8b 00                	mov    (%rax),%eax
  80072c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800731:	75 2c                	jne    80075f <putch+0x66>
  800733:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800737:	8b 00                	mov    (%rax),%eax
  800739:	48 98                	cltq   
  80073b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80073f:	48 83 c2 08          	add    $0x8,%rdx
  800743:	48 89 c6             	mov    %rax,%rsi
  800746:	48 89 d7             	mov    %rdx,%rdi
  800749:	48 b8 ba 1b 80 00 00 	movabs $0x801bba,%rax
  800750:	00 00 00 
  800753:	ff d0                	callq  *%rax
  800755:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800759:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80075f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800763:	8b 40 04             	mov    0x4(%rax),%eax
  800766:	8d 50 01             	lea    0x1(%rax),%edx
  800769:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80076d:	89 50 04             	mov    %edx,0x4(%rax)
  800770:	c9                   	leaveq 
  800771:	c3                   	retq   

0000000000800772 <vcprintf>:
  800772:	55                   	push   %rbp
  800773:	48 89 e5             	mov    %rsp,%rbp
  800776:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80077d:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800784:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80078b:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800792:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800799:	48 8b 0a             	mov    (%rdx),%rcx
  80079c:	48 89 08             	mov    %rcx,(%rax)
  80079f:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8007a3:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8007a7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8007ab:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8007af:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8007b6:	00 00 00 
  8007b9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8007c0:	00 00 00 
  8007c3:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8007ca:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8007d1:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8007d8:	48 89 c6             	mov    %rax,%rsi
  8007db:	48 bf f9 06 80 00 00 	movabs $0x8006f9,%rdi
  8007e2:	00 00 00 
  8007e5:	48 b8 d1 0b 80 00 00 	movabs $0x800bd1,%rax
  8007ec:	00 00 00 
  8007ef:	ff d0                	callq  *%rax
  8007f1:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8007f7:	48 98                	cltq   
  8007f9:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800800:	48 83 c2 08          	add    $0x8,%rdx
  800804:	48 89 c6             	mov    %rax,%rsi
  800807:	48 89 d7             	mov    %rdx,%rdi
  80080a:	48 b8 ba 1b 80 00 00 	movabs $0x801bba,%rax
  800811:	00 00 00 
  800814:	ff d0                	callq  *%rax
  800816:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  80081c:	c9                   	leaveq 
  80081d:	c3                   	retq   

000000000080081e <cprintf>:
  80081e:	55                   	push   %rbp
  80081f:	48 89 e5             	mov    %rsp,%rbp
  800822:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800829:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800830:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800837:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80083e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800845:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80084c:	84 c0                	test   %al,%al
  80084e:	74 20                	je     800870 <cprintf+0x52>
  800850:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800854:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800858:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80085c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800860:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800864:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800868:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80086c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800870:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800877:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80087e:	00 00 00 
  800881:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800888:	00 00 00 
  80088b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80088f:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800896:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80089d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8008a4:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8008ab:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8008b2:	48 8b 0a             	mov    (%rdx),%rcx
  8008b5:	48 89 08             	mov    %rcx,(%rax)
  8008b8:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8008bc:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8008c0:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8008c4:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8008c8:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8008cf:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8008d6:	48 89 d6             	mov    %rdx,%rsi
  8008d9:	48 89 c7             	mov    %rax,%rdi
  8008dc:	48 b8 72 07 80 00 00 	movabs $0x800772,%rax
  8008e3:	00 00 00 
  8008e6:	ff d0                	callq  *%rax
  8008e8:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8008ee:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8008f4:	c9                   	leaveq 
  8008f5:	c3                   	retq   

00000000008008f6 <printnum>:
  8008f6:	55                   	push   %rbp
  8008f7:	48 89 e5             	mov    %rsp,%rbp
  8008fa:	53                   	push   %rbx
  8008fb:	48 83 ec 38          	sub    $0x38,%rsp
  8008ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800903:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800907:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80090b:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80090e:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800912:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800916:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800919:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80091d:	77 3b                	ja     80095a <printnum+0x64>
  80091f:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800922:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800926:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800929:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80092d:	ba 00 00 00 00       	mov    $0x0,%edx
  800932:	48 f7 f3             	div    %rbx
  800935:	48 89 c2             	mov    %rax,%rdx
  800938:	8b 7d cc             	mov    -0x34(%rbp),%edi
  80093b:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80093e:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800942:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800946:	41 89 f9             	mov    %edi,%r9d
  800949:	48 89 c7             	mov    %rax,%rdi
  80094c:	48 b8 f6 08 80 00 00 	movabs $0x8008f6,%rax
  800953:	00 00 00 
  800956:	ff d0                	callq  *%rax
  800958:	eb 1e                	jmp    800978 <printnum+0x82>
  80095a:	eb 12                	jmp    80096e <printnum+0x78>
  80095c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800960:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800963:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800967:	48 89 ce             	mov    %rcx,%rsi
  80096a:	89 d7                	mov    %edx,%edi
  80096c:	ff d0                	callq  *%rax
  80096e:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800972:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800976:	7f e4                	jg     80095c <printnum+0x66>
  800978:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80097b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80097f:	ba 00 00 00 00       	mov    $0x0,%edx
  800984:	48 f7 f1             	div    %rcx
  800987:	48 89 d0             	mov    %rdx,%rax
  80098a:	48 ba d0 4f 80 00 00 	movabs $0x804fd0,%rdx
  800991:	00 00 00 
  800994:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800998:	0f be d0             	movsbl %al,%edx
  80099b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80099f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009a3:	48 89 ce             	mov    %rcx,%rsi
  8009a6:	89 d7                	mov    %edx,%edi
  8009a8:	ff d0                	callq  *%rax
  8009aa:	48 83 c4 38          	add    $0x38,%rsp
  8009ae:	5b                   	pop    %rbx
  8009af:	5d                   	pop    %rbp
  8009b0:	c3                   	retq   

00000000008009b1 <getuint>:
  8009b1:	55                   	push   %rbp
  8009b2:	48 89 e5             	mov    %rsp,%rbp
  8009b5:	48 83 ec 1c          	sub    $0x1c,%rsp
  8009b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8009bd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8009c0:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8009c4:	7e 52                	jle    800a18 <getuint+0x67>
  8009c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009ca:	8b 00                	mov    (%rax),%eax
  8009cc:	83 f8 30             	cmp    $0x30,%eax
  8009cf:	73 24                	jae    8009f5 <getuint+0x44>
  8009d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009dd:	8b 00                	mov    (%rax),%eax
  8009df:	89 c0                	mov    %eax,%eax
  8009e1:	48 01 d0             	add    %rdx,%rax
  8009e4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009e8:	8b 12                	mov    (%rdx),%edx
  8009ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009ed:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009f1:	89 0a                	mov    %ecx,(%rdx)
  8009f3:	eb 17                	jmp    800a0c <getuint+0x5b>
  8009f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009f9:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009fd:	48 89 d0             	mov    %rdx,%rax
  800a00:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a04:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a08:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a0c:	48 8b 00             	mov    (%rax),%rax
  800a0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a13:	e9 a3 00 00 00       	jmpq   800abb <getuint+0x10a>
  800a18:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800a1c:	74 4f                	je     800a6d <getuint+0xbc>
  800a1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a22:	8b 00                	mov    (%rax),%eax
  800a24:	83 f8 30             	cmp    $0x30,%eax
  800a27:	73 24                	jae    800a4d <getuint+0x9c>
  800a29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a2d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a35:	8b 00                	mov    (%rax),%eax
  800a37:	89 c0                	mov    %eax,%eax
  800a39:	48 01 d0             	add    %rdx,%rax
  800a3c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a40:	8b 12                	mov    (%rdx),%edx
  800a42:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a45:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a49:	89 0a                	mov    %ecx,(%rdx)
  800a4b:	eb 17                	jmp    800a64 <getuint+0xb3>
  800a4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a51:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a55:	48 89 d0             	mov    %rdx,%rax
  800a58:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a5c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a60:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a64:	48 8b 00             	mov    (%rax),%rax
  800a67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a6b:	eb 4e                	jmp    800abb <getuint+0x10a>
  800a6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a71:	8b 00                	mov    (%rax),%eax
  800a73:	83 f8 30             	cmp    $0x30,%eax
  800a76:	73 24                	jae    800a9c <getuint+0xeb>
  800a78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a7c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a84:	8b 00                	mov    (%rax),%eax
  800a86:	89 c0                	mov    %eax,%eax
  800a88:	48 01 d0             	add    %rdx,%rax
  800a8b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a8f:	8b 12                	mov    (%rdx),%edx
  800a91:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a94:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a98:	89 0a                	mov    %ecx,(%rdx)
  800a9a:	eb 17                	jmp    800ab3 <getuint+0x102>
  800a9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800aa0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800aa4:	48 89 d0             	mov    %rdx,%rax
  800aa7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800aab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800aaf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800ab3:	8b 00                	mov    (%rax),%eax
  800ab5:	89 c0                	mov    %eax,%eax
  800ab7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800abb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800abf:	c9                   	leaveq 
  800ac0:	c3                   	retq   

0000000000800ac1 <getint>:
  800ac1:	55                   	push   %rbp
  800ac2:	48 89 e5             	mov    %rsp,%rbp
  800ac5:	48 83 ec 1c          	sub    $0x1c,%rsp
  800ac9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800acd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800ad0:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800ad4:	7e 52                	jle    800b28 <getint+0x67>
  800ad6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ada:	8b 00                	mov    (%rax),%eax
  800adc:	83 f8 30             	cmp    $0x30,%eax
  800adf:	73 24                	jae    800b05 <getint+0x44>
  800ae1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ae5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800ae9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800aed:	8b 00                	mov    (%rax),%eax
  800aef:	89 c0                	mov    %eax,%eax
  800af1:	48 01 d0             	add    %rdx,%rax
  800af4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800af8:	8b 12                	mov    (%rdx),%edx
  800afa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800afd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b01:	89 0a                	mov    %ecx,(%rdx)
  800b03:	eb 17                	jmp    800b1c <getint+0x5b>
  800b05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b09:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b0d:	48 89 d0             	mov    %rdx,%rax
  800b10:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b14:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b18:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b1c:	48 8b 00             	mov    (%rax),%rax
  800b1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b23:	e9 a3 00 00 00       	jmpq   800bcb <getint+0x10a>
  800b28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800b2c:	74 4f                	je     800b7d <getint+0xbc>
  800b2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b32:	8b 00                	mov    (%rax),%eax
  800b34:	83 f8 30             	cmp    $0x30,%eax
  800b37:	73 24                	jae    800b5d <getint+0x9c>
  800b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b3d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b45:	8b 00                	mov    (%rax),%eax
  800b47:	89 c0                	mov    %eax,%eax
  800b49:	48 01 d0             	add    %rdx,%rax
  800b4c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b50:	8b 12                	mov    (%rdx),%edx
  800b52:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800b55:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b59:	89 0a                	mov    %ecx,(%rdx)
  800b5b:	eb 17                	jmp    800b74 <getint+0xb3>
  800b5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b61:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b65:	48 89 d0             	mov    %rdx,%rax
  800b68:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b6c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b70:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b74:	48 8b 00             	mov    (%rax),%rax
  800b77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b7b:	eb 4e                	jmp    800bcb <getint+0x10a>
  800b7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b81:	8b 00                	mov    (%rax),%eax
  800b83:	83 f8 30             	cmp    $0x30,%eax
  800b86:	73 24                	jae    800bac <getint+0xeb>
  800b88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b8c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b94:	8b 00                	mov    (%rax),%eax
  800b96:	89 c0                	mov    %eax,%eax
  800b98:	48 01 d0             	add    %rdx,%rax
  800b9b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b9f:	8b 12                	mov    (%rdx),%edx
  800ba1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800ba4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ba8:	89 0a                	mov    %ecx,(%rdx)
  800baa:	eb 17                	jmp    800bc3 <getint+0x102>
  800bac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bb0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800bb4:	48 89 d0             	mov    %rdx,%rax
  800bb7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800bbb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bbf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800bc3:	8b 00                	mov    (%rax),%eax
  800bc5:	48 98                	cltq   
  800bc7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800bcf:	c9                   	leaveq 
  800bd0:	c3                   	retq   

0000000000800bd1 <vprintfmt>:
  800bd1:	55                   	push   %rbp
  800bd2:	48 89 e5             	mov    %rsp,%rbp
  800bd5:	41 54                	push   %r12
  800bd7:	53                   	push   %rbx
  800bd8:	48 83 ec 60          	sub    $0x60,%rsp
  800bdc:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800be0:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800be4:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800be8:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800bec:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800bf0:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800bf4:	48 8b 0a             	mov    (%rdx),%rcx
  800bf7:	48 89 08             	mov    %rcx,(%rax)
  800bfa:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800bfe:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800c02:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800c06:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800c0a:	eb 17                	jmp    800c23 <vprintfmt+0x52>
  800c0c:	85 db                	test   %ebx,%ebx
  800c0e:	0f 84 cc 04 00 00    	je     8010e0 <vprintfmt+0x50f>
  800c14:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c18:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c1c:	48 89 d6             	mov    %rdx,%rsi
  800c1f:	89 df                	mov    %ebx,%edi
  800c21:	ff d0                	callq  *%rax
  800c23:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c27:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800c2b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c2f:	0f b6 00             	movzbl (%rax),%eax
  800c32:	0f b6 d8             	movzbl %al,%ebx
  800c35:	83 fb 25             	cmp    $0x25,%ebx
  800c38:	75 d2                	jne    800c0c <vprintfmt+0x3b>
  800c3a:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800c3e:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800c45:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800c4c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800c53:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800c5a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c5e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800c62:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c66:	0f b6 00             	movzbl (%rax),%eax
  800c69:	0f b6 d8             	movzbl %al,%ebx
  800c6c:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800c6f:	83 f8 55             	cmp    $0x55,%eax
  800c72:	0f 87 34 04 00 00    	ja     8010ac <vprintfmt+0x4db>
  800c78:	89 c0                	mov    %eax,%eax
  800c7a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800c81:	00 
  800c82:	48 b8 f8 4f 80 00 00 	movabs $0x804ff8,%rax
  800c89:	00 00 00 
  800c8c:	48 01 d0             	add    %rdx,%rax
  800c8f:	48 8b 00             	mov    (%rax),%rax
  800c92:	ff e0                	jmpq   *%rax
  800c94:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800c98:	eb c0                	jmp    800c5a <vprintfmt+0x89>
  800c9a:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800c9e:	eb ba                	jmp    800c5a <vprintfmt+0x89>
  800ca0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800ca7:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800caa:	89 d0                	mov    %edx,%eax
  800cac:	c1 e0 02             	shl    $0x2,%eax
  800caf:	01 d0                	add    %edx,%eax
  800cb1:	01 c0                	add    %eax,%eax
  800cb3:	01 d8                	add    %ebx,%eax
  800cb5:	83 e8 30             	sub    $0x30,%eax
  800cb8:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800cbb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800cbf:	0f b6 00             	movzbl (%rax),%eax
  800cc2:	0f be d8             	movsbl %al,%ebx
  800cc5:	83 fb 2f             	cmp    $0x2f,%ebx
  800cc8:	7e 0c                	jle    800cd6 <vprintfmt+0x105>
  800cca:	83 fb 39             	cmp    $0x39,%ebx
  800ccd:	7f 07                	jg     800cd6 <vprintfmt+0x105>
  800ccf:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800cd4:	eb d1                	jmp    800ca7 <vprintfmt+0xd6>
  800cd6:	eb 58                	jmp    800d30 <vprintfmt+0x15f>
  800cd8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cdb:	83 f8 30             	cmp    $0x30,%eax
  800cde:	73 17                	jae    800cf7 <vprintfmt+0x126>
  800ce0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ce4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ce7:	89 c0                	mov    %eax,%eax
  800ce9:	48 01 d0             	add    %rdx,%rax
  800cec:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800cef:	83 c2 08             	add    $0x8,%edx
  800cf2:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800cf5:	eb 0f                	jmp    800d06 <vprintfmt+0x135>
  800cf7:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800cfb:	48 89 d0             	mov    %rdx,%rax
  800cfe:	48 83 c2 08          	add    $0x8,%rdx
  800d02:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d06:	8b 00                	mov    (%rax),%eax
  800d08:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800d0b:	eb 23                	jmp    800d30 <vprintfmt+0x15f>
  800d0d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d11:	79 0c                	jns    800d1f <vprintfmt+0x14e>
  800d13:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800d1a:	e9 3b ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d1f:	e9 36 ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d24:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800d2b:	e9 2a ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d30:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d34:	79 12                	jns    800d48 <vprintfmt+0x177>
  800d36:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800d39:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800d3c:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800d43:	e9 12 ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d48:	e9 0d ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d4d:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800d51:	e9 04 ff ff ff       	jmpq   800c5a <vprintfmt+0x89>
  800d56:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d59:	83 f8 30             	cmp    $0x30,%eax
  800d5c:	73 17                	jae    800d75 <vprintfmt+0x1a4>
  800d5e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d62:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d65:	89 c0                	mov    %eax,%eax
  800d67:	48 01 d0             	add    %rdx,%rax
  800d6a:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d6d:	83 c2 08             	add    $0x8,%edx
  800d70:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d73:	eb 0f                	jmp    800d84 <vprintfmt+0x1b3>
  800d75:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d79:	48 89 d0             	mov    %rdx,%rax
  800d7c:	48 83 c2 08          	add    $0x8,%rdx
  800d80:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d84:	8b 10                	mov    (%rax),%edx
  800d86:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800d8a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d8e:	48 89 ce             	mov    %rcx,%rsi
  800d91:	89 d7                	mov    %edx,%edi
  800d93:	ff d0                	callq  *%rax
  800d95:	e9 40 03 00 00       	jmpq   8010da <vprintfmt+0x509>
  800d9a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d9d:	83 f8 30             	cmp    $0x30,%eax
  800da0:	73 17                	jae    800db9 <vprintfmt+0x1e8>
  800da2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800da6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800da9:	89 c0                	mov    %eax,%eax
  800dab:	48 01 d0             	add    %rdx,%rax
  800dae:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800db1:	83 c2 08             	add    $0x8,%edx
  800db4:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800db7:	eb 0f                	jmp    800dc8 <vprintfmt+0x1f7>
  800db9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800dbd:	48 89 d0             	mov    %rdx,%rax
  800dc0:	48 83 c2 08          	add    $0x8,%rdx
  800dc4:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800dc8:	8b 18                	mov    (%rax),%ebx
  800dca:	85 db                	test   %ebx,%ebx
  800dcc:	79 02                	jns    800dd0 <vprintfmt+0x1ff>
  800dce:	f7 db                	neg    %ebx
  800dd0:	83 fb 15             	cmp    $0x15,%ebx
  800dd3:	7f 16                	jg     800deb <vprintfmt+0x21a>
  800dd5:	48 b8 20 4f 80 00 00 	movabs $0x804f20,%rax
  800ddc:	00 00 00 
  800ddf:	48 63 d3             	movslq %ebx,%rdx
  800de2:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800de6:	4d 85 e4             	test   %r12,%r12
  800de9:	75 2e                	jne    800e19 <vprintfmt+0x248>
  800deb:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800def:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800df3:	89 d9                	mov    %ebx,%ecx
  800df5:	48 ba e1 4f 80 00 00 	movabs $0x804fe1,%rdx
  800dfc:	00 00 00 
  800dff:	48 89 c7             	mov    %rax,%rdi
  800e02:	b8 00 00 00 00       	mov    $0x0,%eax
  800e07:	49 b8 e9 10 80 00 00 	movabs $0x8010e9,%r8
  800e0e:	00 00 00 
  800e11:	41 ff d0             	callq  *%r8
  800e14:	e9 c1 02 00 00       	jmpq   8010da <vprintfmt+0x509>
  800e19:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800e1d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e21:	4c 89 e1             	mov    %r12,%rcx
  800e24:	48 ba ea 4f 80 00 00 	movabs $0x804fea,%rdx
  800e2b:	00 00 00 
  800e2e:	48 89 c7             	mov    %rax,%rdi
  800e31:	b8 00 00 00 00       	mov    $0x0,%eax
  800e36:	49 b8 e9 10 80 00 00 	movabs $0x8010e9,%r8
  800e3d:	00 00 00 
  800e40:	41 ff d0             	callq  *%r8
  800e43:	e9 92 02 00 00       	jmpq   8010da <vprintfmt+0x509>
  800e48:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e4b:	83 f8 30             	cmp    $0x30,%eax
  800e4e:	73 17                	jae    800e67 <vprintfmt+0x296>
  800e50:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e54:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e57:	89 c0                	mov    %eax,%eax
  800e59:	48 01 d0             	add    %rdx,%rax
  800e5c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e5f:	83 c2 08             	add    $0x8,%edx
  800e62:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e65:	eb 0f                	jmp    800e76 <vprintfmt+0x2a5>
  800e67:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e6b:	48 89 d0             	mov    %rdx,%rax
  800e6e:	48 83 c2 08          	add    $0x8,%rdx
  800e72:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e76:	4c 8b 20             	mov    (%rax),%r12
  800e79:	4d 85 e4             	test   %r12,%r12
  800e7c:	75 0a                	jne    800e88 <vprintfmt+0x2b7>
  800e7e:	49 bc ed 4f 80 00 00 	movabs $0x804fed,%r12
  800e85:	00 00 00 
  800e88:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e8c:	7e 3f                	jle    800ecd <vprintfmt+0x2fc>
  800e8e:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800e92:	74 39                	je     800ecd <vprintfmt+0x2fc>
  800e94:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800e97:	48 98                	cltq   
  800e99:	48 89 c6             	mov    %rax,%rsi
  800e9c:	4c 89 e7             	mov    %r12,%rdi
  800e9f:	48 b8 95 13 80 00 00 	movabs $0x801395,%rax
  800ea6:	00 00 00 
  800ea9:	ff d0                	callq  *%rax
  800eab:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800eae:	eb 17                	jmp    800ec7 <vprintfmt+0x2f6>
  800eb0:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800eb4:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800eb8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ebc:	48 89 ce             	mov    %rcx,%rsi
  800ebf:	89 d7                	mov    %edx,%edi
  800ec1:	ff d0                	callq  *%rax
  800ec3:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ec7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800ecb:	7f e3                	jg     800eb0 <vprintfmt+0x2df>
  800ecd:	eb 37                	jmp    800f06 <vprintfmt+0x335>
  800ecf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800ed3:	74 1e                	je     800ef3 <vprintfmt+0x322>
  800ed5:	83 fb 1f             	cmp    $0x1f,%ebx
  800ed8:	7e 05                	jle    800edf <vprintfmt+0x30e>
  800eda:	83 fb 7e             	cmp    $0x7e,%ebx
  800edd:	7e 14                	jle    800ef3 <vprintfmt+0x322>
  800edf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ee3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ee7:	48 89 d6             	mov    %rdx,%rsi
  800eea:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800eef:	ff d0                	callq  *%rax
  800ef1:	eb 0f                	jmp    800f02 <vprintfmt+0x331>
  800ef3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ef7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800efb:	48 89 d6             	mov    %rdx,%rsi
  800efe:	89 df                	mov    %ebx,%edi
  800f00:	ff d0                	callq  *%rax
  800f02:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f06:	4c 89 e0             	mov    %r12,%rax
  800f09:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800f0d:	0f b6 00             	movzbl (%rax),%eax
  800f10:	0f be d8             	movsbl %al,%ebx
  800f13:	85 db                	test   %ebx,%ebx
  800f15:	74 10                	je     800f27 <vprintfmt+0x356>
  800f17:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800f1b:	78 b2                	js     800ecf <vprintfmt+0x2fe>
  800f1d:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800f21:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800f25:	79 a8                	jns    800ecf <vprintfmt+0x2fe>
  800f27:	eb 16                	jmp    800f3f <vprintfmt+0x36e>
  800f29:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f2d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f31:	48 89 d6             	mov    %rdx,%rsi
  800f34:	bf 20 00 00 00       	mov    $0x20,%edi
  800f39:	ff d0                	callq  *%rax
  800f3b:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f3f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800f43:	7f e4                	jg     800f29 <vprintfmt+0x358>
  800f45:	e9 90 01 00 00       	jmpq   8010da <vprintfmt+0x509>
  800f4a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f4e:	be 03 00 00 00       	mov    $0x3,%esi
  800f53:	48 89 c7             	mov    %rax,%rdi
  800f56:	48 b8 c1 0a 80 00 00 	movabs $0x800ac1,%rax
  800f5d:	00 00 00 
  800f60:	ff d0                	callq  *%rax
  800f62:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f6a:	48 85 c0             	test   %rax,%rax
  800f6d:	79 1d                	jns    800f8c <vprintfmt+0x3bb>
  800f6f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f73:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f77:	48 89 d6             	mov    %rdx,%rsi
  800f7a:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800f7f:	ff d0                	callq  *%rax
  800f81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f85:	48 f7 d8             	neg    %rax
  800f88:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f8c:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800f93:	e9 d5 00 00 00       	jmpq   80106d <vprintfmt+0x49c>
  800f98:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f9c:	be 03 00 00 00       	mov    $0x3,%esi
  800fa1:	48 89 c7             	mov    %rax,%rdi
  800fa4:	48 b8 b1 09 80 00 00 	movabs $0x8009b1,%rax
  800fab:	00 00 00 
  800fae:	ff d0                	callq  *%rax
  800fb0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800fb4:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800fbb:	e9 ad 00 00 00       	jmpq   80106d <vprintfmt+0x49c>
  800fc0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800fc4:	be 03 00 00 00       	mov    $0x3,%esi
  800fc9:	48 89 c7             	mov    %rax,%rdi
  800fcc:	48 b8 b1 09 80 00 00 	movabs $0x8009b1,%rax
  800fd3:	00 00 00 
  800fd6:	ff d0                	callq  *%rax
  800fd8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800fdc:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800fe3:	e9 85 00 00 00       	jmpq   80106d <vprintfmt+0x49c>
  800fe8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fec:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ff0:	48 89 d6             	mov    %rdx,%rsi
  800ff3:	bf 30 00 00 00       	mov    $0x30,%edi
  800ff8:	ff d0                	callq  *%rax
  800ffa:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ffe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801002:	48 89 d6             	mov    %rdx,%rsi
  801005:	bf 78 00 00 00       	mov    $0x78,%edi
  80100a:	ff d0                	callq  *%rax
  80100c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80100f:	83 f8 30             	cmp    $0x30,%eax
  801012:	73 17                	jae    80102b <vprintfmt+0x45a>
  801014:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801018:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80101b:	89 c0                	mov    %eax,%eax
  80101d:	48 01 d0             	add    %rdx,%rax
  801020:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801023:	83 c2 08             	add    $0x8,%edx
  801026:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801029:	eb 0f                	jmp    80103a <vprintfmt+0x469>
  80102b:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80102f:	48 89 d0             	mov    %rdx,%rax
  801032:	48 83 c2 08          	add    $0x8,%rdx
  801036:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  80103a:	48 8b 00             	mov    (%rax),%rax
  80103d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801041:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801048:	eb 23                	jmp    80106d <vprintfmt+0x49c>
  80104a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80104e:	be 03 00 00 00       	mov    $0x3,%esi
  801053:	48 89 c7             	mov    %rax,%rdi
  801056:	48 b8 b1 09 80 00 00 	movabs $0x8009b1,%rax
  80105d:	00 00 00 
  801060:	ff d0                	callq  *%rax
  801062:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801066:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  80106d:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  801072:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  801075:	8b 7d dc             	mov    -0x24(%rbp),%edi
  801078:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80107c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801080:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801084:	45 89 c1             	mov    %r8d,%r9d
  801087:	41 89 f8             	mov    %edi,%r8d
  80108a:	48 89 c7             	mov    %rax,%rdi
  80108d:	48 b8 f6 08 80 00 00 	movabs $0x8008f6,%rax
  801094:	00 00 00 
  801097:	ff d0                	callq  *%rax
  801099:	eb 3f                	jmp    8010da <vprintfmt+0x509>
  80109b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80109f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8010a3:	48 89 d6             	mov    %rdx,%rsi
  8010a6:	89 df                	mov    %ebx,%edi
  8010a8:	ff d0                	callq  *%rax
  8010aa:	eb 2e                	jmp    8010da <vprintfmt+0x509>
  8010ac:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8010b0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8010b4:	48 89 d6             	mov    %rdx,%rsi
  8010b7:	bf 25 00 00 00       	mov    $0x25,%edi
  8010bc:	ff d0                	callq  *%rax
  8010be:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8010c3:	eb 05                	jmp    8010ca <vprintfmt+0x4f9>
  8010c5:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8010ca:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8010ce:	48 83 e8 01          	sub    $0x1,%rax
  8010d2:	0f b6 00             	movzbl (%rax),%eax
  8010d5:	3c 25                	cmp    $0x25,%al
  8010d7:	75 ec                	jne    8010c5 <vprintfmt+0x4f4>
  8010d9:	90                   	nop
  8010da:	90                   	nop
  8010db:	e9 43 fb ff ff       	jmpq   800c23 <vprintfmt+0x52>
  8010e0:	48 83 c4 60          	add    $0x60,%rsp
  8010e4:	5b                   	pop    %rbx
  8010e5:	41 5c                	pop    %r12
  8010e7:	5d                   	pop    %rbp
  8010e8:	c3                   	retq   

00000000008010e9 <printfmt>:
  8010e9:	55                   	push   %rbp
  8010ea:	48 89 e5             	mov    %rsp,%rbp
  8010ed:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  8010f4:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  8010fb:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  801102:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801109:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801110:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801117:	84 c0                	test   %al,%al
  801119:	74 20                	je     80113b <printfmt+0x52>
  80111b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80111f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801123:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801127:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80112b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80112f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801133:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801137:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80113b:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  801142:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801149:	00 00 00 
  80114c:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  801153:	00 00 00 
  801156:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80115a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801161:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801168:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80116f:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  801176:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80117d:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  801184:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  80118b:	48 89 c7             	mov    %rax,%rdi
  80118e:	48 b8 d1 0b 80 00 00 	movabs $0x800bd1,%rax
  801195:	00 00 00 
  801198:	ff d0                	callq  *%rax
  80119a:	c9                   	leaveq 
  80119b:	c3                   	retq   

000000000080119c <sprintputch>:
  80119c:	55                   	push   %rbp
  80119d:	48 89 e5             	mov    %rsp,%rbp
  8011a0:	48 83 ec 10          	sub    $0x10,%rsp
  8011a4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8011a7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8011ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011af:	8b 40 10             	mov    0x10(%rax),%eax
  8011b2:	8d 50 01             	lea    0x1(%rax),%edx
  8011b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011b9:	89 50 10             	mov    %edx,0x10(%rax)
  8011bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011c0:	48 8b 10             	mov    (%rax),%rdx
  8011c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011c7:	48 8b 40 08          	mov    0x8(%rax),%rax
  8011cb:	48 39 c2             	cmp    %rax,%rdx
  8011ce:	73 17                	jae    8011e7 <sprintputch+0x4b>
  8011d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011d4:	48 8b 00             	mov    (%rax),%rax
  8011d7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  8011db:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8011df:	48 89 0a             	mov    %rcx,(%rdx)
  8011e2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8011e5:	88 10                	mov    %dl,(%rax)
  8011e7:	c9                   	leaveq 
  8011e8:	c3                   	retq   

00000000008011e9 <vsnprintf>:
  8011e9:	55                   	push   %rbp
  8011ea:	48 89 e5             	mov    %rsp,%rbp
  8011ed:	48 83 ec 50          	sub    $0x50,%rsp
  8011f1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8011f5:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  8011f8:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8011fc:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  801200:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  801204:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801208:	48 8b 0a             	mov    (%rdx),%rcx
  80120b:	48 89 08             	mov    %rcx,(%rax)
  80120e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801212:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801216:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80121a:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80121e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801222:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801226:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801229:	48 98                	cltq   
  80122b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80122f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801233:	48 01 d0             	add    %rdx,%rax
  801236:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  80123a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801241:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801246:	74 06                	je     80124e <vsnprintf+0x65>
  801248:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  80124c:	7f 07                	jg     801255 <vsnprintf+0x6c>
  80124e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801253:	eb 2f                	jmp    801284 <vsnprintf+0x9b>
  801255:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801259:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  80125d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801261:	48 89 c6             	mov    %rax,%rsi
  801264:	48 bf 9c 11 80 00 00 	movabs $0x80119c,%rdi
  80126b:	00 00 00 
  80126e:	48 b8 d1 0b 80 00 00 	movabs $0x800bd1,%rax
  801275:	00 00 00 
  801278:	ff d0                	callq  *%rax
  80127a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80127e:	c6 00 00             	movb   $0x0,(%rax)
  801281:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801284:	c9                   	leaveq 
  801285:	c3                   	retq   

0000000000801286 <snprintf>:
  801286:	55                   	push   %rbp
  801287:	48 89 e5             	mov    %rsp,%rbp
  80128a:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  801291:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  801298:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  80129e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8012a5:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8012ac:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8012b3:	84 c0                	test   %al,%al
  8012b5:	74 20                	je     8012d7 <snprintf+0x51>
  8012b7:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8012bb:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8012bf:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8012c3:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8012c7:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8012cb:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8012cf:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8012d3:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8012d7:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8012de:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8012e5:	00 00 00 
  8012e8:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8012ef:	00 00 00 
  8012f2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8012f6:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8012fd:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801304:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80130b:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  801312:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801319:	48 8b 0a             	mov    (%rdx),%rcx
  80131c:	48 89 08             	mov    %rcx,(%rax)
  80131f:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801323:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801327:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80132b:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80132f:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801336:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  80133d:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801343:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80134a:	48 89 c7             	mov    %rax,%rdi
  80134d:	48 b8 e9 11 80 00 00 	movabs $0x8011e9,%rax
  801354:	00 00 00 
  801357:	ff d0                	callq  *%rax
  801359:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80135f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801365:	c9                   	leaveq 
  801366:	c3                   	retq   

0000000000801367 <strlen>:
  801367:	55                   	push   %rbp
  801368:	48 89 e5             	mov    %rsp,%rbp
  80136b:	48 83 ec 18          	sub    $0x18,%rsp
  80136f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801373:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80137a:	eb 09                	jmp    801385 <strlen+0x1e>
  80137c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801380:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801385:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801389:	0f b6 00             	movzbl (%rax),%eax
  80138c:	84 c0                	test   %al,%al
  80138e:	75 ec                	jne    80137c <strlen+0x15>
  801390:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801393:	c9                   	leaveq 
  801394:	c3                   	retq   

0000000000801395 <strnlen>:
  801395:	55                   	push   %rbp
  801396:	48 89 e5             	mov    %rsp,%rbp
  801399:	48 83 ec 20          	sub    $0x20,%rsp
  80139d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8013ac:	eb 0e                	jmp    8013bc <strnlen+0x27>
  8013ae:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8013b2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8013b7:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8013bc:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8013c1:	74 0b                	je     8013ce <strnlen+0x39>
  8013c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013c7:	0f b6 00             	movzbl (%rax),%eax
  8013ca:	84 c0                	test   %al,%al
  8013cc:	75 e0                	jne    8013ae <strnlen+0x19>
  8013ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8013d1:	c9                   	leaveq 
  8013d2:	c3                   	retq   

00000000008013d3 <strcpy>:
  8013d3:	55                   	push   %rbp
  8013d4:	48 89 e5             	mov    %rsp,%rbp
  8013d7:	48 83 ec 20          	sub    $0x20,%rsp
  8013db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013eb:	90                   	nop
  8013ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013f0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8013f4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013f8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8013fc:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801400:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801404:	0f b6 12             	movzbl (%rdx),%edx
  801407:	88 10                	mov    %dl,(%rax)
  801409:	0f b6 00             	movzbl (%rax),%eax
  80140c:	84 c0                	test   %al,%al
  80140e:	75 dc                	jne    8013ec <strcpy+0x19>
  801410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801414:	c9                   	leaveq 
  801415:	c3                   	retq   

0000000000801416 <strcat>:
  801416:	55                   	push   %rbp
  801417:	48 89 e5             	mov    %rsp,%rbp
  80141a:	48 83 ec 20          	sub    $0x20,%rsp
  80141e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801422:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801426:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80142a:	48 89 c7             	mov    %rax,%rdi
  80142d:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  801434:	00 00 00 
  801437:	ff d0                	callq  *%rax
  801439:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80143c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80143f:	48 63 d0             	movslq %eax,%rdx
  801442:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801446:	48 01 c2             	add    %rax,%rdx
  801449:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80144d:	48 89 c6             	mov    %rax,%rsi
  801450:	48 89 d7             	mov    %rdx,%rdi
  801453:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  80145a:	00 00 00 
  80145d:	ff d0                	callq  *%rax
  80145f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801463:	c9                   	leaveq 
  801464:	c3                   	retq   

0000000000801465 <strncpy>:
  801465:	55                   	push   %rbp
  801466:	48 89 e5             	mov    %rsp,%rbp
  801469:	48 83 ec 28          	sub    $0x28,%rsp
  80146d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801471:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801475:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801479:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80147d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801481:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801488:	00 
  801489:	eb 2a                	jmp    8014b5 <strncpy+0x50>
  80148b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80148f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801493:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801497:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80149b:	0f b6 12             	movzbl (%rdx),%edx
  80149e:	88 10                	mov    %dl,(%rax)
  8014a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014a4:	0f b6 00             	movzbl (%rax),%eax
  8014a7:	84 c0                	test   %al,%al
  8014a9:	74 05                	je     8014b0 <strncpy+0x4b>
  8014ab:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8014b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8014b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014b9:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8014bd:	72 cc                	jb     80148b <strncpy+0x26>
  8014bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014c3:	c9                   	leaveq 
  8014c4:	c3                   	retq   

00000000008014c5 <strlcpy>:
  8014c5:	55                   	push   %rbp
  8014c6:	48 89 e5             	mov    %rsp,%rbp
  8014c9:	48 83 ec 28          	sub    $0x28,%rsp
  8014cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014d1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014d5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8014e1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8014e6:	74 3d                	je     801525 <strlcpy+0x60>
  8014e8:	eb 1d                	jmp    801507 <strlcpy+0x42>
  8014ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014ee:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8014f2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014f6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8014fa:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8014fe:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801502:	0f b6 12             	movzbl (%rdx),%edx
  801505:	88 10                	mov    %dl,(%rax)
  801507:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80150c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801511:	74 0b                	je     80151e <strlcpy+0x59>
  801513:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801517:	0f b6 00             	movzbl (%rax),%eax
  80151a:	84 c0                	test   %al,%al
  80151c:	75 cc                	jne    8014ea <strlcpy+0x25>
  80151e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801522:	c6 00 00             	movb   $0x0,(%rax)
  801525:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80152d:	48 29 c2             	sub    %rax,%rdx
  801530:	48 89 d0             	mov    %rdx,%rax
  801533:	c9                   	leaveq 
  801534:	c3                   	retq   

0000000000801535 <strcmp>:
  801535:	55                   	push   %rbp
  801536:	48 89 e5             	mov    %rsp,%rbp
  801539:	48 83 ec 10          	sub    $0x10,%rsp
  80153d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801541:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801545:	eb 0a                	jmp    801551 <strcmp+0x1c>
  801547:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80154c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801555:	0f b6 00             	movzbl (%rax),%eax
  801558:	84 c0                	test   %al,%al
  80155a:	74 12                	je     80156e <strcmp+0x39>
  80155c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801560:	0f b6 10             	movzbl (%rax),%edx
  801563:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801567:	0f b6 00             	movzbl (%rax),%eax
  80156a:	38 c2                	cmp    %al,%dl
  80156c:	74 d9                	je     801547 <strcmp+0x12>
  80156e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801572:	0f b6 00             	movzbl (%rax),%eax
  801575:	0f b6 d0             	movzbl %al,%edx
  801578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80157c:	0f b6 00             	movzbl (%rax),%eax
  80157f:	0f b6 c0             	movzbl %al,%eax
  801582:	29 c2                	sub    %eax,%edx
  801584:	89 d0                	mov    %edx,%eax
  801586:	c9                   	leaveq 
  801587:	c3                   	retq   

0000000000801588 <strncmp>:
  801588:	55                   	push   %rbp
  801589:	48 89 e5             	mov    %rsp,%rbp
  80158c:	48 83 ec 18          	sub    $0x18,%rsp
  801590:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801594:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801598:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80159c:	eb 0f                	jmp    8015ad <strncmp+0x25>
  80159e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8015a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8015a8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8015ad:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8015b2:	74 1d                	je     8015d1 <strncmp+0x49>
  8015b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015b8:	0f b6 00             	movzbl (%rax),%eax
  8015bb:	84 c0                	test   %al,%al
  8015bd:	74 12                	je     8015d1 <strncmp+0x49>
  8015bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015c3:	0f b6 10             	movzbl (%rax),%edx
  8015c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015ca:	0f b6 00             	movzbl (%rax),%eax
  8015cd:	38 c2                	cmp    %al,%dl
  8015cf:	74 cd                	je     80159e <strncmp+0x16>
  8015d1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8015d6:	75 07                	jne    8015df <strncmp+0x57>
  8015d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8015dd:	eb 18                	jmp    8015f7 <strncmp+0x6f>
  8015df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015e3:	0f b6 00             	movzbl (%rax),%eax
  8015e6:	0f b6 d0             	movzbl %al,%edx
  8015e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015ed:	0f b6 00             	movzbl (%rax),%eax
  8015f0:	0f b6 c0             	movzbl %al,%eax
  8015f3:	29 c2                	sub    %eax,%edx
  8015f5:	89 d0                	mov    %edx,%eax
  8015f7:	c9                   	leaveq 
  8015f8:	c3                   	retq   

00000000008015f9 <strchr>:
  8015f9:	55                   	push   %rbp
  8015fa:	48 89 e5             	mov    %rsp,%rbp
  8015fd:	48 83 ec 0c          	sub    $0xc,%rsp
  801601:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801605:	89 f0                	mov    %esi,%eax
  801607:	88 45 f4             	mov    %al,-0xc(%rbp)
  80160a:	eb 17                	jmp    801623 <strchr+0x2a>
  80160c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801610:	0f b6 00             	movzbl (%rax),%eax
  801613:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801616:	75 06                	jne    80161e <strchr+0x25>
  801618:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80161c:	eb 15                	jmp    801633 <strchr+0x3a>
  80161e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801623:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801627:	0f b6 00             	movzbl (%rax),%eax
  80162a:	84 c0                	test   %al,%al
  80162c:	75 de                	jne    80160c <strchr+0x13>
  80162e:	b8 00 00 00 00       	mov    $0x0,%eax
  801633:	c9                   	leaveq 
  801634:	c3                   	retq   

0000000000801635 <strfind>:
  801635:	55                   	push   %rbp
  801636:	48 89 e5             	mov    %rsp,%rbp
  801639:	48 83 ec 0c          	sub    $0xc,%rsp
  80163d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801641:	89 f0                	mov    %esi,%eax
  801643:	88 45 f4             	mov    %al,-0xc(%rbp)
  801646:	eb 13                	jmp    80165b <strfind+0x26>
  801648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80164c:	0f b6 00             	movzbl (%rax),%eax
  80164f:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801652:	75 02                	jne    801656 <strfind+0x21>
  801654:	eb 10                	jmp    801666 <strfind+0x31>
  801656:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80165b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80165f:	0f b6 00             	movzbl (%rax),%eax
  801662:	84 c0                	test   %al,%al
  801664:	75 e2                	jne    801648 <strfind+0x13>
  801666:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80166a:	c9                   	leaveq 
  80166b:	c3                   	retq   

000000000080166c <memset>:
  80166c:	55                   	push   %rbp
  80166d:	48 89 e5             	mov    %rsp,%rbp
  801670:	48 83 ec 18          	sub    $0x18,%rsp
  801674:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801678:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80167b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80167f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801684:	75 06                	jne    80168c <memset+0x20>
  801686:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80168a:	eb 69                	jmp    8016f5 <memset+0x89>
  80168c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801690:	83 e0 03             	and    $0x3,%eax
  801693:	48 85 c0             	test   %rax,%rax
  801696:	75 48                	jne    8016e0 <memset+0x74>
  801698:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80169c:	83 e0 03             	and    $0x3,%eax
  80169f:	48 85 c0             	test   %rax,%rax
  8016a2:	75 3c                	jne    8016e0 <memset+0x74>
  8016a4:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  8016ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016ae:	c1 e0 18             	shl    $0x18,%eax
  8016b1:	89 c2                	mov    %eax,%edx
  8016b3:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016b6:	c1 e0 10             	shl    $0x10,%eax
  8016b9:	09 c2                	or     %eax,%edx
  8016bb:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016be:	c1 e0 08             	shl    $0x8,%eax
  8016c1:	09 d0                	or     %edx,%eax
  8016c3:	09 45 f4             	or     %eax,-0xc(%rbp)
  8016c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016ca:	48 c1 e8 02          	shr    $0x2,%rax
  8016ce:	48 89 c1             	mov    %rax,%rcx
  8016d1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016d5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016d8:	48 89 d7             	mov    %rdx,%rdi
  8016db:	fc                   	cld    
  8016dc:	f3 ab                	rep stos %eax,%es:(%rdi)
  8016de:	eb 11                	jmp    8016f1 <memset+0x85>
  8016e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016e4:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016e7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8016eb:	48 89 d7             	mov    %rdx,%rdi
  8016ee:	fc                   	cld    
  8016ef:	f3 aa                	rep stos %al,%es:(%rdi)
  8016f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016f5:	c9                   	leaveq 
  8016f6:	c3                   	retq   

00000000008016f7 <memmove>:
  8016f7:	55                   	push   %rbp
  8016f8:	48 89 e5             	mov    %rsp,%rbp
  8016fb:	48 83 ec 28          	sub    $0x28,%rsp
  8016ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801703:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801707:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80170b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80170f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801713:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801717:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80171b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80171f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801723:	0f 83 88 00 00 00    	jae    8017b1 <memmove+0xba>
  801729:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80172d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801731:	48 01 d0             	add    %rdx,%rax
  801734:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801738:	76 77                	jbe    8017b1 <memmove+0xba>
  80173a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80173e:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801742:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801746:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  80174a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80174e:	83 e0 03             	and    $0x3,%eax
  801751:	48 85 c0             	test   %rax,%rax
  801754:	75 3b                	jne    801791 <memmove+0x9a>
  801756:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80175a:	83 e0 03             	and    $0x3,%eax
  80175d:	48 85 c0             	test   %rax,%rax
  801760:	75 2f                	jne    801791 <memmove+0x9a>
  801762:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801766:	83 e0 03             	and    $0x3,%eax
  801769:	48 85 c0             	test   %rax,%rax
  80176c:	75 23                	jne    801791 <memmove+0x9a>
  80176e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801772:	48 83 e8 04          	sub    $0x4,%rax
  801776:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80177a:	48 83 ea 04          	sub    $0x4,%rdx
  80177e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801782:	48 c1 e9 02          	shr    $0x2,%rcx
  801786:	48 89 c7             	mov    %rax,%rdi
  801789:	48 89 d6             	mov    %rdx,%rsi
  80178c:	fd                   	std    
  80178d:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80178f:	eb 1d                	jmp    8017ae <memmove+0xb7>
  801791:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801795:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801799:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80179d:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8017a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a5:	48 89 d7             	mov    %rdx,%rdi
  8017a8:	48 89 c1             	mov    %rax,%rcx
  8017ab:	fd                   	std    
  8017ac:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8017ae:	fc                   	cld    
  8017af:	eb 57                	jmp    801808 <memmove+0x111>
  8017b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017b5:	83 e0 03             	and    $0x3,%eax
  8017b8:	48 85 c0             	test   %rax,%rax
  8017bb:	75 36                	jne    8017f3 <memmove+0xfc>
  8017bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017c1:	83 e0 03             	and    $0x3,%eax
  8017c4:	48 85 c0             	test   %rax,%rax
  8017c7:	75 2a                	jne    8017f3 <memmove+0xfc>
  8017c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017cd:	83 e0 03             	and    $0x3,%eax
  8017d0:	48 85 c0             	test   %rax,%rax
  8017d3:	75 1e                	jne    8017f3 <memmove+0xfc>
  8017d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017d9:	48 c1 e8 02          	shr    $0x2,%rax
  8017dd:	48 89 c1             	mov    %rax,%rcx
  8017e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017e4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017e8:	48 89 c7             	mov    %rax,%rdi
  8017eb:	48 89 d6             	mov    %rdx,%rsi
  8017ee:	fc                   	cld    
  8017ef:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8017f1:	eb 15                	jmp    801808 <memmove+0x111>
  8017f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017f7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017fb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8017ff:	48 89 c7             	mov    %rax,%rdi
  801802:	48 89 d6             	mov    %rdx,%rsi
  801805:	fc                   	cld    
  801806:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801808:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80180c:	c9                   	leaveq 
  80180d:	c3                   	retq   

000000000080180e <memcpy>:
  80180e:	55                   	push   %rbp
  80180f:	48 89 e5             	mov    %rsp,%rbp
  801812:	48 83 ec 18          	sub    $0x18,%rsp
  801816:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80181a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80181e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801822:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801826:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80182a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80182e:	48 89 ce             	mov    %rcx,%rsi
  801831:	48 89 c7             	mov    %rax,%rdi
  801834:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  80183b:	00 00 00 
  80183e:	ff d0                	callq  *%rax
  801840:	c9                   	leaveq 
  801841:	c3                   	retq   

0000000000801842 <memcmp>:
  801842:	55                   	push   %rbp
  801843:	48 89 e5             	mov    %rsp,%rbp
  801846:	48 83 ec 28          	sub    $0x28,%rsp
  80184a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80184e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801852:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801856:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80185a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80185e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801862:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801866:	eb 36                	jmp    80189e <memcmp+0x5c>
  801868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80186c:	0f b6 10             	movzbl (%rax),%edx
  80186f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801873:	0f b6 00             	movzbl (%rax),%eax
  801876:	38 c2                	cmp    %al,%dl
  801878:	74 1a                	je     801894 <memcmp+0x52>
  80187a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80187e:	0f b6 00             	movzbl (%rax),%eax
  801881:	0f b6 d0             	movzbl %al,%edx
  801884:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801888:	0f b6 00             	movzbl (%rax),%eax
  80188b:	0f b6 c0             	movzbl %al,%eax
  80188e:	29 c2                	sub    %eax,%edx
  801890:	89 d0                	mov    %edx,%eax
  801892:	eb 20                	jmp    8018b4 <memcmp+0x72>
  801894:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801899:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80189e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018a2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8018a6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018aa:	48 85 c0             	test   %rax,%rax
  8018ad:	75 b9                	jne    801868 <memcmp+0x26>
  8018af:	b8 00 00 00 00       	mov    $0x0,%eax
  8018b4:	c9                   	leaveq 
  8018b5:	c3                   	retq   

00000000008018b6 <memfind>:
  8018b6:	55                   	push   %rbp
  8018b7:	48 89 e5             	mov    %rsp,%rbp
  8018ba:	48 83 ec 28          	sub    $0x28,%rsp
  8018be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8018c2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8018c5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018cd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018d1:	48 01 d0             	add    %rdx,%rax
  8018d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018d8:	eb 15                	jmp    8018ef <memfind+0x39>
  8018da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018de:	0f b6 10             	movzbl (%rax),%edx
  8018e1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8018e4:	38 c2                	cmp    %al,%dl
  8018e6:	75 02                	jne    8018ea <memfind+0x34>
  8018e8:	eb 0f                	jmp    8018f9 <memfind+0x43>
  8018ea:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8018ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018f3:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8018f7:	72 e1                	jb     8018da <memfind+0x24>
  8018f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018fd:	c9                   	leaveq 
  8018fe:	c3                   	retq   

00000000008018ff <strtol>:
  8018ff:	55                   	push   %rbp
  801900:	48 89 e5             	mov    %rsp,%rbp
  801903:	48 83 ec 34          	sub    $0x34,%rsp
  801907:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80190b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80190f:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801912:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801919:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801920:	00 
  801921:	eb 05                	jmp    801928 <strtol+0x29>
  801923:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801928:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80192c:	0f b6 00             	movzbl (%rax),%eax
  80192f:	3c 20                	cmp    $0x20,%al
  801931:	74 f0                	je     801923 <strtol+0x24>
  801933:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801937:	0f b6 00             	movzbl (%rax),%eax
  80193a:	3c 09                	cmp    $0x9,%al
  80193c:	74 e5                	je     801923 <strtol+0x24>
  80193e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801942:	0f b6 00             	movzbl (%rax),%eax
  801945:	3c 2b                	cmp    $0x2b,%al
  801947:	75 07                	jne    801950 <strtol+0x51>
  801949:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80194e:	eb 17                	jmp    801967 <strtol+0x68>
  801950:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801954:	0f b6 00             	movzbl (%rax),%eax
  801957:	3c 2d                	cmp    $0x2d,%al
  801959:	75 0c                	jne    801967 <strtol+0x68>
  80195b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801960:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801967:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80196b:	74 06                	je     801973 <strtol+0x74>
  80196d:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801971:	75 28                	jne    80199b <strtol+0x9c>
  801973:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801977:	0f b6 00             	movzbl (%rax),%eax
  80197a:	3c 30                	cmp    $0x30,%al
  80197c:	75 1d                	jne    80199b <strtol+0x9c>
  80197e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801982:	48 83 c0 01          	add    $0x1,%rax
  801986:	0f b6 00             	movzbl (%rax),%eax
  801989:	3c 78                	cmp    $0x78,%al
  80198b:	75 0e                	jne    80199b <strtol+0x9c>
  80198d:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801992:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801999:	eb 2c                	jmp    8019c7 <strtol+0xc8>
  80199b:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80199f:	75 19                	jne    8019ba <strtol+0xbb>
  8019a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019a5:	0f b6 00             	movzbl (%rax),%eax
  8019a8:	3c 30                	cmp    $0x30,%al
  8019aa:	75 0e                	jne    8019ba <strtol+0xbb>
  8019ac:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019b1:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8019b8:	eb 0d                	jmp    8019c7 <strtol+0xc8>
  8019ba:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8019be:	75 07                	jne    8019c7 <strtol+0xc8>
  8019c0:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8019c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019cb:	0f b6 00             	movzbl (%rax),%eax
  8019ce:	3c 2f                	cmp    $0x2f,%al
  8019d0:	7e 1d                	jle    8019ef <strtol+0xf0>
  8019d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019d6:	0f b6 00             	movzbl (%rax),%eax
  8019d9:	3c 39                	cmp    $0x39,%al
  8019db:	7f 12                	jg     8019ef <strtol+0xf0>
  8019dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019e1:	0f b6 00             	movzbl (%rax),%eax
  8019e4:	0f be c0             	movsbl %al,%eax
  8019e7:	83 e8 30             	sub    $0x30,%eax
  8019ea:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8019ed:	eb 4e                	jmp    801a3d <strtol+0x13e>
  8019ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019f3:	0f b6 00             	movzbl (%rax),%eax
  8019f6:	3c 60                	cmp    $0x60,%al
  8019f8:	7e 1d                	jle    801a17 <strtol+0x118>
  8019fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019fe:	0f b6 00             	movzbl (%rax),%eax
  801a01:	3c 7a                	cmp    $0x7a,%al
  801a03:	7f 12                	jg     801a17 <strtol+0x118>
  801a05:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a09:	0f b6 00             	movzbl (%rax),%eax
  801a0c:	0f be c0             	movsbl %al,%eax
  801a0f:	83 e8 57             	sub    $0x57,%eax
  801a12:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a15:	eb 26                	jmp    801a3d <strtol+0x13e>
  801a17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a1b:	0f b6 00             	movzbl (%rax),%eax
  801a1e:	3c 40                	cmp    $0x40,%al
  801a20:	7e 48                	jle    801a6a <strtol+0x16b>
  801a22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a26:	0f b6 00             	movzbl (%rax),%eax
  801a29:	3c 5a                	cmp    $0x5a,%al
  801a2b:	7f 3d                	jg     801a6a <strtol+0x16b>
  801a2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a31:	0f b6 00             	movzbl (%rax),%eax
  801a34:	0f be c0             	movsbl %al,%eax
  801a37:	83 e8 37             	sub    $0x37,%eax
  801a3a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a3d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a40:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801a43:	7c 02                	jl     801a47 <strtol+0x148>
  801a45:	eb 23                	jmp    801a6a <strtol+0x16b>
  801a47:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801a4c:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801a4f:	48 98                	cltq   
  801a51:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801a56:	48 89 c2             	mov    %rax,%rdx
  801a59:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a5c:	48 98                	cltq   
  801a5e:	48 01 d0             	add    %rdx,%rax
  801a61:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801a65:	e9 5d ff ff ff       	jmpq   8019c7 <strtol+0xc8>
  801a6a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801a6f:	74 0b                	je     801a7c <strtol+0x17d>
  801a71:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801a75:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801a79:	48 89 10             	mov    %rdx,(%rax)
  801a7c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801a80:	74 09                	je     801a8b <strtol+0x18c>
  801a82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a86:	48 f7 d8             	neg    %rax
  801a89:	eb 04                	jmp    801a8f <strtol+0x190>
  801a8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a8f:	c9                   	leaveq 
  801a90:	c3                   	retq   

0000000000801a91 <strstr>:
  801a91:	55                   	push   %rbp
  801a92:	48 89 e5             	mov    %rsp,%rbp
  801a95:	48 83 ec 30          	sub    $0x30,%rsp
  801a99:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801a9d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801aa1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801aa5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801aa9:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801aad:	0f b6 00             	movzbl (%rax),%eax
  801ab0:	88 45 ff             	mov    %al,-0x1(%rbp)
  801ab3:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801ab7:	75 06                	jne    801abf <strstr+0x2e>
  801ab9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801abd:	eb 6b                	jmp    801b2a <strstr+0x99>
  801abf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801ac3:	48 89 c7             	mov    %rax,%rdi
  801ac6:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  801acd:	00 00 00 
  801ad0:	ff d0                	callq  *%rax
  801ad2:	48 98                	cltq   
  801ad4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ad8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801adc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801ae0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801ae4:	0f b6 00             	movzbl (%rax),%eax
  801ae7:	88 45 ef             	mov    %al,-0x11(%rbp)
  801aea:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801aee:	75 07                	jne    801af7 <strstr+0x66>
  801af0:	b8 00 00 00 00       	mov    $0x0,%eax
  801af5:	eb 33                	jmp    801b2a <strstr+0x99>
  801af7:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801afb:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801afe:	75 d8                	jne    801ad8 <strstr+0x47>
  801b00:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b04:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801b08:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b0c:	48 89 ce             	mov    %rcx,%rsi
  801b0f:	48 89 c7             	mov    %rax,%rdi
  801b12:	48 b8 88 15 80 00 00 	movabs $0x801588,%rax
  801b19:	00 00 00 
  801b1c:	ff d0                	callq  *%rax
  801b1e:	85 c0                	test   %eax,%eax
  801b20:	75 b6                	jne    801ad8 <strstr+0x47>
  801b22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b26:	48 83 e8 01          	sub    $0x1,%rax
  801b2a:	c9                   	leaveq 
  801b2b:	c3                   	retq   

0000000000801b2c <syscall>:
  801b2c:	55                   	push   %rbp
  801b2d:	48 89 e5             	mov    %rsp,%rbp
  801b30:	53                   	push   %rbx
  801b31:	48 83 ec 48          	sub    $0x48,%rsp
  801b35:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801b38:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801b3b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801b3f:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801b43:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801b47:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801b4b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801b4e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801b52:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801b56:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801b5a:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801b5e:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801b62:	4c 89 c3             	mov    %r8,%rbx
  801b65:	cd 30                	int    $0x30
  801b67:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801b6b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801b6f:	74 3e                	je     801baf <syscall+0x83>
  801b71:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801b76:	7e 37                	jle    801baf <syscall+0x83>
  801b78:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801b7c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801b7f:	49 89 d0             	mov    %rdx,%r8
  801b82:	89 c1                	mov    %eax,%ecx
  801b84:	48 ba a8 52 80 00 00 	movabs $0x8052a8,%rdx
  801b8b:	00 00 00 
  801b8e:	be 24 00 00 00       	mov    $0x24,%esi
  801b93:	48 bf c5 52 80 00 00 	movabs $0x8052c5,%rdi
  801b9a:	00 00 00 
  801b9d:	b8 00 00 00 00       	mov    $0x0,%eax
  801ba2:	49 b9 e5 05 80 00 00 	movabs $0x8005e5,%r9
  801ba9:	00 00 00 
  801bac:	41 ff d1             	callq  *%r9
  801baf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bb3:	48 83 c4 48          	add    $0x48,%rsp
  801bb7:	5b                   	pop    %rbx
  801bb8:	5d                   	pop    %rbp
  801bb9:	c3                   	retq   

0000000000801bba <sys_cputs>:
  801bba:	55                   	push   %rbp
  801bbb:	48 89 e5             	mov    %rsp,%rbp
  801bbe:	48 83 ec 20          	sub    $0x20,%rsp
  801bc2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801bc6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bd2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bd9:	00 
  801bda:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801be0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801be6:	48 89 d1             	mov    %rdx,%rcx
  801be9:	48 89 c2             	mov    %rax,%rdx
  801bec:	be 00 00 00 00       	mov    $0x0,%esi
  801bf1:	bf 00 00 00 00       	mov    $0x0,%edi
  801bf6:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801bfd:	00 00 00 
  801c00:	ff d0                	callq  *%rax
  801c02:	c9                   	leaveq 
  801c03:	c3                   	retq   

0000000000801c04 <sys_cgetc>:
  801c04:	55                   	push   %rbp
  801c05:	48 89 e5             	mov    %rsp,%rbp
  801c08:	48 83 ec 10          	sub    $0x10,%rsp
  801c0c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c13:	00 
  801c14:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c1a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c20:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c25:	ba 00 00 00 00       	mov    $0x0,%edx
  801c2a:	be 00 00 00 00       	mov    $0x0,%esi
  801c2f:	bf 01 00 00 00       	mov    $0x1,%edi
  801c34:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801c3b:	00 00 00 
  801c3e:	ff d0                	callq  *%rax
  801c40:	c9                   	leaveq 
  801c41:	c3                   	retq   

0000000000801c42 <sys_env_destroy>:
  801c42:	55                   	push   %rbp
  801c43:	48 89 e5             	mov    %rsp,%rbp
  801c46:	48 83 ec 10          	sub    $0x10,%rsp
  801c4a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c50:	48 98                	cltq   
  801c52:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c59:	00 
  801c5a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c60:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c66:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c6b:	48 89 c2             	mov    %rax,%rdx
  801c6e:	be 01 00 00 00       	mov    $0x1,%esi
  801c73:	bf 03 00 00 00       	mov    $0x3,%edi
  801c78:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801c7f:	00 00 00 
  801c82:	ff d0                	callq  *%rax
  801c84:	c9                   	leaveq 
  801c85:	c3                   	retq   

0000000000801c86 <sys_getenvid>:
  801c86:	55                   	push   %rbp
  801c87:	48 89 e5             	mov    %rsp,%rbp
  801c8a:	48 83 ec 10          	sub    $0x10,%rsp
  801c8e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c95:	00 
  801c96:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c9c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ca2:	b9 00 00 00 00       	mov    $0x0,%ecx
  801ca7:	ba 00 00 00 00       	mov    $0x0,%edx
  801cac:	be 00 00 00 00       	mov    $0x0,%esi
  801cb1:	bf 02 00 00 00       	mov    $0x2,%edi
  801cb6:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801cbd:	00 00 00 
  801cc0:	ff d0                	callq  *%rax
  801cc2:	c9                   	leaveq 
  801cc3:	c3                   	retq   

0000000000801cc4 <sys_yield>:
  801cc4:	55                   	push   %rbp
  801cc5:	48 89 e5             	mov    %rsp,%rbp
  801cc8:	48 83 ec 10          	sub    $0x10,%rsp
  801ccc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cd3:	00 
  801cd4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cda:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ce0:	b9 00 00 00 00       	mov    $0x0,%ecx
  801ce5:	ba 00 00 00 00       	mov    $0x0,%edx
  801cea:	be 00 00 00 00       	mov    $0x0,%esi
  801cef:	bf 0b 00 00 00       	mov    $0xb,%edi
  801cf4:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801cfb:	00 00 00 
  801cfe:	ff d0                	callq  *%rax
  801d00:	c9                   	leaveq 
  801d01:	c3                   	retq   

0000000000801d02 <sys_page_alloc>:
  801d02:	55                   	push   %rbp
  801d03:	48 89 e5             	mov    %rsp,%rbp
  801d06:	48 83 ec 20          	sub    $0x20,%rsp
  801d0a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d0d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d11:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d14:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d17:	48 63 c8             	movslq %eax,%rcx
  801d1a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d21:	48 98                	cltq   
  801d23:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d2a:	00 
  801d2b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d31:	49 89 c8             	mov    %rcx,%r8
  801d34:	48 89 d1             	mov    %rdx,%rcx
  801d37:	48 89 c2             	mov    %rax,%rdx
  801d3a:	be 01 00 00 00       	mov    $0x1,%esi
  801d3f:	bf 04 00 00 00       	mov    $0x4,%edi
  801d44:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801d4b:	00 00 00 
  801d4e:	ff d0                	callq  *%rax
  801d50:	c9                   	leaveq 
  801d51:	c3                   	retq   

0000000000801d52 <sys_page_map>:
  801d52:	55                   	push   %rbp
  801d53:	48 89 e5             	mov    %rsp,%rbp
  801d56:	48 83 ec 30          	sub    $0x30,%rsp
  801d5a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d5d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d61:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d64:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801d68:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801d6c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801d6f:	48 63 c8             	movslq %eax,%rcx
  801d72:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801d76:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d79:	48 63 f0             	movslq %eax,%rsi
  801d7c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d80:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d83:	48 98                	cltq   
  801d85:	48 89 0c 24          	mov    %rcx,(%rsp)
  801d89:	49 89 f9             	mov    %rdi,%r9
  801d8c:	49 89 f0             	mov    %rsi,%r8
  801d8f:	48 89 d1             	mov    %rdx,%rcx
  801d92:	48 89 c2             	mov    %rax,%rdx
  801d95:	be 01 00 00 00       	mov    $0x1,%esi
  801d9a:	bf 05 00 00 00       	mov    $0x5,%edi
  801d9f:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801da6:	00 00 00 
  801da9:	ff d0                	callq  *%rax
  801dab:	c9                   	leaveq 
  801dac:	c3                   	retq   

0000000000801dad <sys_page_unmap>:
  801dad:	55                   	push   %rbp
  801dae:	48 89 e5             	mov    %rsp,%rbp
  801db1:	48 83 ec 20          	sub    $0x20,%rsp
  801db5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801db8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801dbc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801dc0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dc3:	48 98                	cltq   
  801dc5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dcc:	00 
  801dcd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dd3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dd9:	48 89 d1             	mov    %rdx,%rcx
  801ddc:	48 89 c2             	mov    %rax,%rdx
  801ddf:	be 01 00 00 00       	mov    $0x1,%esi
  801de4:	bf 06 00 00 00       	mov    $0x6,%edi
  801de9:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801df0:	00 00 00 
  801df3:	ff d0                	callq  *%rax
  801df5:	c9                   	leaveq 
  801df6:	c3                   	retq   

0000000000801df7 <sys_env_set_status>:
  801df7:	55                   	push   %rbp
  801df8:	48 89 e5             	mov    %rsp,%rbp
  801dfb:	48 83 ec 10          	sub    $0x10,%rsp
  801dff:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e02:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801e05:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e08:	48 63 d0             	movslq %eax,%rdx
  801e0b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e0e:	48 98                	cltq   
  801e10:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e17:	00 
  801e18:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e1e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e24:	48 89 d1             	mov    %rdx,%rcx
  801e27:	48 89 c2             	mov    %rax,%rdx
  801e2a:	be 01 00 00 00       	mov    $0x1,%esi
  801e2f:	bf 08 00 00 00       	mov    $0x8,%edi
  801e34:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801e3b:	00 00 00 
  801e3e:	ff d0                	callq  *%rax
  801e40:	c9                   	leaveq 
  801e41:	c3                   	retq   

0000000000801e42 <sys_env_set_trapframe>:
  801e42:	55                   	push   %rbp
  801e43:	48 89 e5             	mov    %rsp,%rbp
  801e46:	48 83 ec 20          	sub    $0x20,%rsp
  801e4a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e4d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e51:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e55:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e58:	48 98                	cltq   
  801e5a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e61:	00 
  801e62:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e68:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e6e:	48 89 d1             	mov    %rdx,%rcx
  801e71:	48 89 c2             	mov    %rax,%rdx
  801e74:	be 01 00 00 00       	mov    $0x1,%esi
  801e79:	bf 09 00 00 00       	mov    $0x9,%edi
  801e7e:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801e85:	00 00 00 
  801e88:	ff d0                	callq  *%rax
  801e8a:	c9                   	leaveq 
  801e8b:	c3                   	retq   

0000000000801e8c <sys_env_set_pgfault_upcall>:
  801e8c:	55                   	push   %rbp
  801e8d:	48 89 e5             	mov    %rsp,%rbp
  801e90:	48 83 ec 20          	sub    $0x20,%rsp
  801e94:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e97:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e9b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ea2:	48 98                	cltq   
  801ea4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801eab:	00 
  801eac:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801eb2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801eb8:	48 89 d1             	mov    %rdx,%rcx
  801ebb:	48 89 c2             	mov    %rax,%rdx
  801ebe:	be 01 00 00 00       	mov    $0x1,%esi
  801ec3:	bf 0a 00 00 00       	mov    $0xa,%edi
  801ec8:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801ecf:	00 00 00 
  801ed2:	ff d0                	callq  *%rax
  801ed4:	c9                   	leaveq 
  801ed5:	c3                   	retq   

0000000000801ed6 <sys_ipc_try_send>:
  801ed6:	55                   	push   %rbp
  801ed7:	48 89 e5             	mov    %rsp,%rbp
  801eda:	48 83 ec 20          	sub    $0x20,%rsp
  801ede:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ee1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ee5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801ee9:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801eec:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801eef:	48 63 f0             	movslq %eax,%rsi
  801ef2:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801ef6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ef9:	48 98                	cltq   
  801efb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801eff:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f06:	00 
  801f07:	49 89 f1             	mov    %rsi,%r9
  801f0a:	49 89 c8             	mov    %rcx,%r8
  801f0d:	48 89 d1             	mov    %rdx,%rcx
  801f10:	48 89 c2             	mov    %rax,%rdx
  801f13:	be 00 00 00 00       	mov    $0x0,%esi
  801f18:	bf 0c 00 00 00       	mov    $0xc,%edi
  801f1d:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801f24:	00 00 00 
  801f27:	ff d0                	callq  *%rax
  801f29:	c9                   	leaveq 
  801f2a:	c3                   	retq   

0000000000801f2b <sys_ipc_recv>:
  801f2b:	55                   	push   %rbp
  801f2c:	48 89 e5             	mov    %rsp,%rbp
  801f2f:	48 83 ec 10          	sub    $0x10,%rsp
  801f33:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f3b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f42:	00 
  801f43:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f49:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f4f:	b9 00 00 00 00       	mov    $0x0,%ecx
  801f54:	48 89 c2             	mov    %rax,%rdx
  801f57:	be 01 00 00 00       	mov    $0x1,%esi
  801f5c:	bf 0d 00 00 00       	mov    $0xd,%edi
  801f61:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801f68:	00 00 00 
  801f6b:	ff d0                	callq  *%rax
  801f6d:	c9                   	leaveq 
  801f6e:	c3                   	retq   

0000000000801f6f <sys_time_msec>:
  801f6f:	55                   	push   %rbp
  801f70:	48 89 e5             	mov    %rsp,%rbp
  801f73:	48 83 ec 10          	sub    $0x10,%rsp
  801f77:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f7e:	00 
  801f7f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f85:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f8b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801f90:	ba 00 00 00 00       	mov    $0x0,%edx
  801f95:	be 00 00 00 00       	mov    $0x0,%esi
  801f9a:	bf 0e 00 00 00       	mov    $0xe,%edi
  801f9f:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801fa6:	00 00 00 
  801fa9:	ff d0                	callq  *%rax
  801fab:	c9                   	leaveq 
  801fac:	c3                   	retq   

0000000000801fad <sys_net_transmit>:
  801fad:	55                   	push   %rbp
  801fae:	48 89 e5             	mov    %rsp,%rbp
  801fb1:	48 83 ec 20          	sub    $0x20,%rsp
  801fb5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801fb9:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801fbc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801fbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801fc3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fca:	00 
  801fcb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fd1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801fd7:	48 89 d1             	mov    %rdx,%rcx
  801fda:	48 89 c2             	mov    %rax,%rdx
  801fdd:	be 00 00 00 00       	mov    $0x0,%esi
  801fe2:	bf 0f 00 00 00       	mov    $0xf,%edi
  801fe7:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  801fee:	00 00 00 
  801ff1:	ff d0                	callq  *%rax
  801ff3:	c9                   	leaveq 
  801ff4:	c3                   	retq   

0000000000801ff5 <sys_net_receive>:
  801ff5:	55                   	push   %rbp
  801ff6:	48 89 e5             	mov    %rsp,%rbp
  801ff9:	48 83 ec 20          	sub    $0x20,%rsp
  801ffd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802001:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802004:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802007:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80200b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802012:	00 
  802013:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802019:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80201f:	48 89 d1             	mov    %rdx,%rcx
  802022:	48 89 c2             	mov    %rax,%rdx
  802025:	be 00 00 00 00       	mov    $0x0,%esi
  80202a:	bf 10 00 00 00       	mov    $0x10,%edi
  80202f:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  802036:	00 00 00 
  802039:	ff d0                	callq  *%rax
  80203b:	c9                   	leaveq 
  80203c:	c3                   	retq   

000000000080203d <sys_ept_map>:
  80203d:	55                   	push   %rbp
  80203e:	48 89 e5             	mov    %rsp,%rbp
  802041:	48 83 ec 30          	sub    $0x30,%rsp
  802045:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802048:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80204c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80204f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  802053:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802057:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80205a:	48 63 c8             	movslq %eax,%rcx
  80205d:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  802061:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802064:	48 63 f0             	movslq %eax,%rsi
  802067:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80206b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80206e:	48 98                	cltq   
  802070:	48 89 0c 24          	mov    %rcx,(%rsp)
  802074:	49 89 f9             	mov    %rdi,%r9
  802077:	49 89 f0             	mov    %rsi,%r8
  80207a:	48 89 d1             	mov    %rdx,%rcx
  80207d:	48 89 c2             	mov    %rax,%rdx
  802080:	be 00 00 00 00       	mov    $0x0,%esi
  802085:	bf 11 00 00 00       	mov    $0x11,%edi
  80208a:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  802091:	00 00 00 
  802094:	ff d0                	callq  *%rax
  802096:	c9                   	leaveq 
  802097:	c3                   	retq   

0000000000802098 <sys_env_mkguest>:
  802098:	55                   	push   %rbp
  802099:	48 89 e5             	mov    %rsp,%rbp
  80209c:	48 83 ec 20          	sub    $0x20,%rsp
  8020a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8020a4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8020a8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8020ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8020b0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8020b7:	00 
  8020b8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8020be:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020c4:	48 89 d1             	mov    %rdx,%rcx
  8020c7:	48 89 c2             	mov    %rax,%rdx
  8020ca:	be 00 00 00 00       	mov    $0x0,%esi
  8020cf:	bf 12 00 00 00       	mov    $0x12,%edi
  8020d4:	48 b8 2c 1b 80 00 00 	movabs $0x801b2c,%rax
  8020db:	00 00 00 
  8020de:	ff d0                	callq  *%rax
  8020e0:	c9                   	leaveq 
  8020e1:	c3                   	retq   

00000000008020e2 <pgfault>:
  8020e2:	55                   	push   %rbp
  8020e3:	48 89 e5             	mov    %rsp,%rbp
  8020e6:	48 83 ec 30          	sub    $0x30,%rsp
  8020ea:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8020ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020f2:	48 8b 00             	mov    (%rax),%rax
  8020f5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8020f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  802101:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802104:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802107:	83 e0 02             	and    $0x2,%eax
  80210a:	85 c0                	test   %eax,%eax
  80210c:	75 40                	jne    80214e <pgfault+0x6c>
  80210e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802112:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  802119:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80211d:	49 89 d0             	mov    %rdx,%r8
  802120:	48 89 c1             	mov    %rax,%rcx
  802123:	48 ba d8 52 80 00 00 	movabs $0x8052d8,%rdx
  80212a:	00 00 00 
  80212d:	be 1f 00 00 00       	mov    $0x1f,%esi
  802132:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802139:	00 00 00 
  80213c:	b8 00 00 00 00       	mov    $0x0,%eax
  802141:	49 b9 e5 05 80 00 00 	movabs $0x8005e5,%r9
  802148:	00 00 00 
  80214b:	41 ff d1             	callq  *%r9
  80214e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802152:	48 c1 e8 0c          	shr    $0xc,%rax
  802156:	48 89 c2             	mov    %rax,%rdx
  802159:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802160:	01 00 00 
  802163:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802167:	25 07 08 00 00       	and    $0x807,%eax
  80216c:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  802172:	74 4e                	je     8021c2 <pgfault+0xe0>
  802174:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802178:	48 c1 e8 0c          	shr    $0xc,%rax
  80217c:	48 89 c2             	mov    %rax,%rdx
  80217f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802186:	01 00 00 
  802189:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80218d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802191:	49 89 d0             	mov    %rdx,%r8
  802194:	48 89 c1             	mov    %rax,%rcx
  802197:	48 ba 00 53 80 00 00 	movabs $0x805300,%rdx
  80219e:	00 00 00 
  8021a1:	be 22 00 00 00       	mov    $0x22,%esi
  8021a6:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8021ad:	00 00 00 
  8021b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8021b5:	49 b9 e5 05 80 00 00 	movabs $0x8005e5,%r9
  8021bc:	00 00 00 
  8021bf:	41 ff d1             	callq  *%r9
  8021c2:	ba 07 00 00 00       	mov    $0x7,%edx
  8021c7:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8021cc:	bf 00 00 00 00       	mov    $0x0,%edi
  8021d1:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  8021d8:	00 00 00 
  8021db:	ff d0                	callq  *%rax
  8021dd:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8021e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8021e4:	79 30                	jns    802216 <pgfault+0x134>
  8021e6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8021e9:	89 c1                	mov    %eax,%ecx
  8021eb:	48 ba 2b 53 80 00 00 	movabs $0x80532b,%rdx
  8021f2:	00 00 00 
  8021f5:	be 30 00 00 00       	mov    $0x30,%esi
  8021fa:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802201:	00 00 00 
  802204:	b8 00 00 00 00       	mov    $0x0,%eax
  802209:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  802210:	00 00 00 
  802213:	41 ff d0             	callq  *%r8
  802216:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80221a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80221e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802222:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802228:	ba 00 10 00 00       	mov    $0x1000,%edx
  80222d:	48 89 c6             	mov    %rax,%rsi
  802230:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  802235:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  80223c:	00 00 00 
  80223f:	ff d0                	callq  *%rax
  802241:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802245:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802249:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80224d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802253:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  802259:	48 89 c1             	mov    %rax,%rcx
  80225c:	ba 00 00 00 00       	mov    $0x0,%edx
  802261:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802266:	bf 00 00 00 00       	mov    $0x0,%edi
  80226b:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  802272:	00 00 00 
  802275:	ff d0                	callq  *%rax
  802277:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80227a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80227e:	79 30                	jns    8022b0 <pgfault+0x1ce>
  802280:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802283:	89 c1                	mov    %eax,%ecx
  802285:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  80228c:	00 00 00 
  80228f:	be 35 00 00 00       	mov    $0x35,%esi
  802294:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80229b:	00 00 00 
  80229e:	b8 00 00 00 00       	mov    $0x0,%eax
  8022a3:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8022aa:	00 00 00 
  8022ad:	41 ff d0             	callq  *%r8
  8022b0:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8022b5:	bf 00 00 00 00       	mov    $0x0,%edi
  8022ba:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8022c1:	00 00 00 
  8022c4:	ff d0                	callq  *%rax
  8022c6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022c9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022cd:	79 30                	jns    8022ff <pgfault+0x21d>
  8022cf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022d2:	89 c1                	mov    %eax,%ecx
  8022d4:	48 ba 4f 53 80 00 00 	movabs $0x80534f,%rdx
  8022db:	00 00 00 
  8022de:	be 39 00 00 00       	mov    $0x39,%esi
  8022e3:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8022ea:	00 00 00 
  8022ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8022f2:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8022f9:	00 00 00 
  8022fc:	41 ff d0             	callq  *%r8
  8022ff:	c9                   	leaveq 
  802300:	c3                   	retq   

0000000000802301 <duppage>:
  802301:	55                   	push   %rbp
  802302:	48 89 e5             	mov    %rsp,%rbp
  802305:	48 83 ec 30          	sub    $0x30,%rsp
  802309:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80230c:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80230f:	8b 45 d8             	mov    -0x28(%rbp),%eax
  802312:	c1 e0 0c             	shl    $0xc,%eax
  802315:	89 c0                	mov    %eax,%eax
  802317:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80231b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802322:	01 00 00 
  802325:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802328:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80232c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802330:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802334:	25 02 08 00 00       	and    $0x802,%eax
  802339:	48 85 c0             	test   %rax,%rax
  80233c:	74 0e                	je     80234c <duppage+0x4b>
  80233e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802342:	25 00 04 00 00       	and    $0x400,%eax
  802347:	48 85 c0             	test   %rax,%rax
  80234a:	74 70                	je     8023bc <duppage+0xbb>
  80234c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802350:	25 07 0e 00 00       	and    $0xe07,%eax
  802355:	89 c6                	mov    %eax,%esi
  802357:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  80235b:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80235e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802362:	41 89 f0             	mov    %esi,%r8d
  802365:	48 89 c6             	mov    %rax,%rsi
  802368:	bf 00 00 00 00       	mov    $0x0,%edi
  80236d:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  802374:	00 00 00 
  802377:	ff d0                	callq  *%rax
  802379:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80237c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802380:	79 30                	jns    8023b2 <duppage+0xb1>
  802382:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802385:	89 c1                	mov    %eax,%ecx
  802387:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  80238e:	00 00 00 
  802391:	be 63 00 00 00       	mov    $0x63,%esi
  802396:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80239d:	00 00 00 
  8023a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8023a5:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8023ac:	00 00 00 
  8023af:	41 ff d0             	callq  *%r8
  8023b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8023b7:	e9 c4 00 00 00       	jmpq   802480 <duppage+0x17f>
  8023bc:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8023c0:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8023c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023c7:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8023cd:	48 89 c6             	mov    %rax,%rsi
  8023d0:	bf 00 00 00 00       	mov    $0x0,%edi
  8023d5:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  8023dc:	00 00 00 
  8023df:	ff d0                	callq  *%rax
  8023e1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8023e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8023e8:	79 30                	jns    80241a <duppage+0x119>
  8023ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8023ed:	89 c1                	mov    %eax,%ecx
  8023ef:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  8023f6:	00 00 00 
  8023f9:	be 7e 00 00 00       	mov    $0x7e,%esi
  8023fe:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802405:	00 00 00 
  802408:	b8 00 00 00 00       	mov    $0x0,%eax
  80240d:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  802414:	00 00 00 
  802417:	41 ff d0             	callq  *%r8
  80241a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80241e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802422:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802428:	48 89 d1             	mov    %rdx,%rcx
  80242b:	ba 00 00 00 00       	mov    $0x0,%edx
  802430:	48 89 c6             	mov    %rax,%rsi
  802433:	bf 00 00 00 00       	mov    $0x0,%edi
  802438:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  80243f:	00 00 00 
  802442:	ff d0                	callq  *%rax
  802444:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802447:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80244b:	79 30                	jns    80247d <duppage+0x17c>
  80244d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802450:	89 c1                	mov    %eax,%ecx
  802452:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  802459:	00 00 00 
  80245c:	be 80 00 00 00       	mov    $0x80,%esi
  802461:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802468:	00 00 00 
  80246b:	b8 00 00 00 00       	mov    $0x0,%eax
  802470:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  802477:	00 00 00 
  80247a:	41 ff d0             	callq  *%r8
  80247d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802480:	c9                   	leaveq 
  802481:	c3                   	retq   

0000000000802482 <fork>:
  802482:	55                   	push   %rbp
  802483:	48 89 e5             	mov    %rsp,%rbp
  802486:	48 83 ec 20          	sub    $0x20,%rsp
  80248a:	48 bf e2 20 80 00 00 	movabs $0x8020e2,%rdi
  802491:	00 00 00 
  802494:	48 b8 3f 48 80 00 00 	movabs $0x80483f,%rax
  80249b:	00 00 00 
  80249e:	ff d0                	callq  *%rax
  8024a0:	b8 07 00 00 00       	mov    $0x7,%eax
  8024a5:	cd 30                	int    $0x30
  8024a7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8024aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024ad:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8024b0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8024b4:	79 08                	jns    8024be <fork+0x3c>
  8024b6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8024b9:	e9 09 02 00 00       	jmpq   8026c7 <fork+0x245>
  8024be:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8024c2:	75 3e                	jne    802502 <fork+0x80>
  8024c4:	48 b8 86 1c 80 00 00 	movabs $0x801c86,%rax
  8024cb:	00 00 00 
  8024ce:	ff d0                	callq  *%rax
  8024d0:	25 ff 03 00 00       	and    $0x3ff,%eax
  8024d5:	48 98                	cltq   
  8024d7:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8024de:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8024e5:	00 00 00 
  8024e8:	48 01 c2             	add    %rax,%rdx
  8024eb:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8024f2:	00 00 00 
  8024f5:	48 89 10             	mov    %rdx,(%rax)
  8024f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8024fd:	e9 c5 01 00 00       	jmpq   8026c7 <fork+0x245>
  802502:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802509:	e9 a4 00 00 00       	jmpq   8025b2 <fork+0x130>
  80250e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802511:	c1 f8 12             	sar    $0x12,%eax
  802514:	89 c2                	mov    %eax,%edx
  802516:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  80251d:	01 00 00 
  802520:	48 63 d2             	movslq %edx,%rdx
  802523:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802527:	83 e0 01             	and    $0x1,%eax
  80252a:	48 85 c0             	test   %rax,%rax
  80252d:	74 21                	je     802550 <fork+0xce>
  80252f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802532:	c1 f8 09             	sar    $0x9,%eax
  802535:	89 c2                	mov    %eax,%edx
  802537:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80253e:	01 00 00 
  802541:	48 63 d2             	movslq %edx,%rdx
  802544:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802548:	83 e0 01             	and    $0x1,%eax
  80254b:	48 85 c0             	test   %rax,%rax
  80254e:	75 09                	jne    802559 <fork+0xd7>
  802550:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  802557:	eb 59                	jmp    8025b2 <fork+0x130>
  802559:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80255c:	05 00 02 00 00       	add    $0x200,%eax
  802561:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802564:	eb 44                	jmp    8025aa <fork+0x128>
  802566:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80256d:	01 00 00 
  802570:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802573:	48 63 d2             	movslq %edx,%rdx
  802576:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80257a:	83 e0 05             	and    $0x5,%eax
  80257d:	48 83 f8 05          	cmp    $0x5,%rax
  802581:	74 02                	je     802585 <fork+0x103>
  802583:	eb 21                	jmp    8025a6 <fork+0x124>
  802585:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  80258c:	75 02                	jne    802590 <fork+0x10e>
  80258e:	eb 16                	jmp    8025a6 <fork+0x124>
  802590:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802593:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802596:	89 d6                	mov    %edx,%esi
  802598:	89 c7                	mov    %eax,%edi
  80259a:	48 b8 01 23 80 00 00 	movabs $0x802301,%rax
  8025a1:	00 00 00 
  8025a4:	ff d0                	callq  *%rax
  8025a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8025aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025ad:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8025b0:	7c b4                	jl     802566 <fork+0xe4>
  8025b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025b5:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  8025ba:	0f 86 4e ff ff ff    	jbe    80250e <fork+0x8c>
  8025c0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8025c3:	ba 07 00 00 00       	mov    $0x7,%edx
  8025c8:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8025cd:	89 c7                	mov    %eax,%edi
  8025cf:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  8025d6:	00 00 00 
  8025d9:	ff d0                	callq  *%rax
  8025db:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8025de:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8025e2:	79 30                	jns    802614 <fork+0x192>
  8025e4:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8025e7:	89 c1                	mov    %eax,%ecx
  8025e9:	48 ba 68 53 80 00 00 	movabs $0x805368,%rdx
  8025f0:	00 00 00 
  8025f3:	be bc 00 00 00       	mov    $0xbc,%esi
  8025f8:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8025ff:	00 00 00 
  802602:	b8 00 00 00 00       	mov    $0x0,%eax
  802607:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  80260e:	00 00 00 
  802611:	41 ff d0             	callq  *%r8
  802614:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80261b:	00 00 00 
  80261e:	48 8b 00             	mov    (%rax),%rax
  802621:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  802628:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80262b:	48 89 d6             	mov    %rdx,%rsi
  80262e:	89 c7                	mov    %eax,%edi
  802630:	48 b8 8c 1e 80 00 00 	movabs $0x801e8c,%rax
  802637:	00 00 00 
  80263a:	ff d0                	callq  *%rax
  80263c:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80263f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802643:	79 30                	jns    802675 <fork+0x1f3>
  802645:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802648:	89 c1                	mov    %eax,%ecx
  80264a:	48 ba 88 53 80 00 00 	movabs $0x805388,%rdx
  802651:	00 00 00 
  802654:	be c0 00 00 00       	mov    $0xc0,%esi
  802659:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802660:	00 00 00 
  802663:	b8 00 00 00 00       	mov    $0x0,%eax
  802668:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  80266f:	00 00 00 
  802672:	41 ff d0             	callq  *%r8
  802675:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802678:	be 02 00 00 00       	mov    $0x2,%esi
  80267d:	89 c7                	mov    %eax,%edi
  80267f:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  802686:	00 00 00 
  802689:	ff d0                	callq  *%rax
  80268b:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80268e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802692:	79 30                	jns    8026c4 <fork+0x242>
  802694:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802697:	89 c1                	mov    %eax,%ecx
  802699:	48 ba a7 53 80 00 00 	movabs $0x8053a7,%rdx
  8026a0:	00 00 00 
  8026a3:	be c5 00 00 00       	mov    $0xc5,%esi
  8026a8:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8026af:	00 00 00 
  8026b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8026b7:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8026be:	00 00 00 
  8026c1:	41 ff d0             	callq  *%r8
  8026c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8026c7:	c9                   	leaveq 
  8026c8:	c3                   	retq   

00000000008026c9 <sfork>:
  8026c9:	55                   	push   %rbp
  8026ca:	48 89 e5             	mov    %rsp,%rbp
  8026cd:	48 ba be 53 80 00 00 	movabs $0x8053be,%rdx
  8026d4:	00 00 00 
  8026d7:	be d2 00 00 00       	mov    $0xd2,%esi
  8026dc:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8026e3:	00 00 00 
  8026e6:	b8 00 00 00 00       	mov    $0x0,%eax
  8026eb:	48 b9 e5 05 80 00 00 	movabs $0x8005e5,%rcx
  8026f2:	00 00 00 
  8026f5:	ff d1                	callq  *%rcx

00000000008026f7 <fd2num>:
  8026f7:	55                   	push   %rbp
  8026f8:	48 89 e5             	mov    %rsp,%rbp
  8026fb:	48 83 ec 08          	sub    $0x8,%rsp
  8026ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802703:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802707:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  80270e:	ff ff ff 
  802711:	48 01 d0             	add    %rdx,%rax
  802714:	48 c1 e8 0c          	shr    $0xc,%rax
  802718:	c9                   	leaveq 
  802719:	c3                   	retq   

000000000080271a <fd2data>:
  80271a:	55                   	push   %rbp
  80271b:	48 89 e5             	mov    %rsp,%rbp
  80271e:	48 83 ec 08          	sub    $0x8,%rsp
  802722:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802726:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80272a:	48 89 c7             	mov    %rax,%rdi
  80272d:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  802734:	00 00 00 
  802737:	ff d0                	callq  *%rax
  802739:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  80273f:	48 c1 e0 0c          	shl    $0xc,%rax
  802743:	c9                   	leaveq 
  802744:	c3                   	retq   

0000000000802745 <fd_alloc>:
  802745:	55                   	push   %rbp
  802746:	48 89 e5             	mov    %rsp,%rbp
  802749:	48 83 ec 18          	sub    $0x18,%rsp
  80274d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802751:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802758:	eb 6b                	jmp    8027c5 <fd_alloc+0x80>
  80275a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80275d:	48 98                	cltq   
  80275f:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802765:	48 c1 e0 0c          	shl    $0xc,%rax
  802769:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80276d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802771:	48 c1 e8 15          	shr    $0x15,%rax
  802775:	48 89 c2             	mov    %rax,%rdx
  802778:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80277f:	01 00 00 
  802782:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802786:	83 e0 01             	and    $0x1,%eax
  802789:	48 85 c0             	test   %rax,%rax
  80278c:	74 21                	je     8027af <fd_alloc+0x6a>
  80278e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802792:	48 c1 e8 0c          	shr    $0xc,%rax
  802796:	48 89 c2             	mov    %rax,%rdx
  802799:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8027a0:	01 00 00 
  8027a3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8027a7:	83 e0 01             	and    $0x1,%eax
  8027aa:	48 85 c0             	test   %rax,%rax
  8027ad:	75 12                	jne    8027c1 <fd_alloc+0x7c>
  8027af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027b3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8027b7:	48 89 10             	mov    %rdx,(%rax)
  8027ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8027bf:	eb 1a                	jmp    8027db <fd_alloc+0x96>
  8027c1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8027c5:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8027c9:	7e 8f                	jle    80275a <fd_alloc+0x15>
  8027cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027cf:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8027d6:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8027db:	c9                   	leaveq 
  8027dc:	c3                   	retq   

00000000008027dd <fd_lookup>:
  8027dd:	55                   	push   %rbp
  8027de:	48 89 e5             	mov    %rsp,%rbp
  8027e1:	48 83 ec 20          	sub    $0x20,%rsp
  8027e5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8027e8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8027ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8027f0:	78 06                	js     8027f8 <fd_lookup+0x1b>
  8027f2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8027f6:	7e 07                	jle    8027ff <fd_lookup+0x22>
  8027f8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8027fd:	eb 6c                	jmp    80286b <fd_lookup+0x8e>
  8027ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802802:	48 98                	cltq   
  802804:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80280a:	48 c1 e0 0c          	shl    $0xc,%rax
  80280e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802812:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802816:	48 c1 e8 15          	shr    $0x15,%rax
  80281a:	48 89 c2             	mov    %rax,%rdx
  80281d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802824:	01 00 00 
  802827:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80282b:	83 e0 01             	and    $0x1,%eax
  80282e:	48 85 c0             	test   %rax,%rax
  802831:	74 21                	je     802854 <fd_lookup+0x77>
  802833:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802837:	48 c1 e8 0c          	shr    $0xc,%rax
  80283b:	48 89 c2             	mov    %rax,%rdx
  80283e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802845:	01 00 00 
  802848:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80284c:	83 e0 01             	and    $0x1,%eax
  80284f:	48 85 c0             	test   %rax,%rax
  802852:	75 07                	jne    80285b <fd_lookup+0x7e>
  802854:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802859:	eb 10                	jmp    80286b <fd_lookup+0x8e>
  80285b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80285f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802863:	48 89 10             	mov    %rdx,(%rax)
  802866:	b8 00 00 00 00       	mov    $0x0,%eax
  80286b:	c9                   	leaveq 
  80286c:	c3                   	retq   

000000000080286d <fd_close>:
  80286d:	55                   	push   %rbp
  80286e:	48 89 e5             	mov    %rsp,%rbp
  802871:	48 83 ec 30          	sub    $0x30,%rsp
  802875:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802879:	89 f0                	mov    %esi,%eax
  80287b:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80287e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802882:	48 89 c7             	mov    %rax,%rdi
  802885:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  80288c:	00 00 00 
  80288f:	ff d0                	callq  *%rax
  802891:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802895:	48 89 d6             	mov    %rdx,%rsi
  802898:	89 c7                	mov    %eax,%edi
  80289a:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  8028a1:	00 00 00 
  8028a4:	ff d0                	callq  *%rax
  8028a6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028a9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028ad:	78 0a                	js     8028b9 <fd_close+0x4c>
  8028af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028b3:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  8028b7:	74 12                	je     8028cb <fd_close+0x5e>
  8028b9:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8028bd:	74 05                	je     8028c4 <fd_close+0x57>
  8028bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028c2:	eb 05                	jmp    8028c9 <fd_close+0x5c>
  8028c4:	b8 00 00 00 00       	mov    $0x0,%eax
  8028c9:	eb 69                	jmp    802934 <fd_close+0xc7>
  8028cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028cf:	8b 00                	mov    (%rax),%eax
  8028d1:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8028d5:	48 89 d6             	mov    %rdx,%rsi
  8028d8:	89 c7                	mov    %eax,%edi
  8028da:	48 b8 36 29 80 00 00 	movabs $0x802936,%rax
  8028e1:	00 00 00 
  8028e4:	ff d0                	callq  *%rax
  8028e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028ed:	78 2a                	js     802919 <fd_close+0xac>
  8028ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028f3:	48 8b 40 20          	mov    0x20(%rax),%rax
  8028f7:	48 85 c0             	test   %rax,%rax
  8028fa:	74 16                	je     802912 <fd_close+0xa5>
  8028fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802900:	48 8b 40 20          	mov    0x20(%rax),%rax
  802904:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802908:	48 89 d7             	mov    %rdx,%rdi
  80290b:	ff d0                	callq  *%rax
  80290d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802910:	eb 07                	jmp    802919 <fd_close+0xac>
  802912:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802919:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80291d:	48 89 c6             	mov    %rax,%rsi
  802920:	bf 00 00 00 00       	mov    $0x0,%edi
  802925:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  80292c:	00 00 00 
  80292f:	ff d0                	callq  *%rax
  802931:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802934:	c9                   	leaveq 
  802935:	c3                   	retq   

0000000000802936 <dev_lookup>:
  802936:	55                   	push   %rbp
  802937:	48 89 e5             	mov    %rsp,%rbp
  80293a:	48 83 ec 20          	sub    $0x20,%rsp
  80293e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802941:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802945:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80294c:	eb 41                	jmp    80298f <dev_lookup+0x59>
  80294e:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802955:	00 00 00 
  802958:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80295b:	48 63 d2             	movslq %edx,%rdx
  80295e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802962:	8b 00                	mov    (%rax),%eax
  802964:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802967:	75 22                	jne    80298b <dev_lookup+0x55>
  802969:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802970:	00 00 00 
  802973:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802976:	48 63 d2             	movslq %edx,%rdx
  802979:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80297d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802981:	48 89 10             	mov    %rdx,(%rax)
  802984:	b8 00 00 00 00       	mov    $0x0,%eax
  802989:	eb 60                	jmp    8029eb <dev_lookup+0xb5>
  80298b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80298f:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802996:	00 00 00 
  802999:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80299c:	48 63 d2             	movslq %edx,%rdx
  80299f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029a3:	48 85 c0             	test   %rax,%rax
  8029a6:	75 a6                	jne    80294e <dev_lookup+0x18>
  8029a8:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8029af:	00 00 00 
  8029b2:	48 8b 00             	mov    (%rax),%rax
  8029b5:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8029bb:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8029be:	89 c6                	mov    %eax,%esi
  8029c0:	48 bf d8 53 80 00 00 	movabs $0x8053d8,%rdi
  8029c7:	00 00 00 
  8029ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8029cf:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  8029d6:	00 00 00 
  8029d9:	ff d1                	callq  *%rcx
  8029db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029df:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8029e6:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8029eb:	c9                   	leaveq 
  8029ec:	c3                   	retq   

00000000008029ed <close>:
  8029ed:	55                   	push   %rbp
  8029ee:	48 89 e5             	mov    %rsp,%rbp
  8029f1:	48 83 ec 20          	sub    $0x20,%rsp
  8029f5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8029f8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8029fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8029ff:	48 89 d6             	mov    %rdx,%rsi
  802a02:	89 c7                	mov    %eax,%edi
  802a04:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802a0b:	00 00 00 
  802a0e:	ff d0                	callq  *%rax
  802a10:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a13:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a17:	79 05                	jns    802a1e <close+0x31>
  802a19:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a1c:	eb 18                	jmp    802a36 <close+0x49>
  802a1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a22:	be 01 00 00 00       	mov    $0x1,%esi
  802a27:	48 89 c7             	mov    %rax,%rdi
  802a2a:	48 b8 6d 28 80 00 00 	movabs $0x80286d,%rax
  802a31:	00 00 00 
  802a34:	ff d0                	callq  *%rax
  802a36:	c9                   	leaveq 
  802a37:	c3                   	retq   

0000000000802a38 <close_all>:
  802a38:	55                   	push   %rbp
  802a39:	48 89 e5             	mov    %rsp,%rbp
  802a3c:	48 83 ec 10          	sub    $0x10,%rsp
  802a40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802a47:	eb 15                	jmp    802a5e <close_all+0x26>
  802a49:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a4c:	89 c7                	mov    %eax,%edi
  802a4e:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  802a55:	00 00 00 
  802a58:	ff d0                	callq  *%rax
  802a5a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802a5e:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802a62:	7e e5                	jle    802a49 <close_all+0x11>
  802a64:	c9                   	leaveq 
  802a65:	c3                   	retq   

0000000000802a66 <dup>:
  802a66:	55                   	push   %rbp
  802a67:	48 89 e5             	mov    %rsp,%rbp
  802a6a:	48 83 ec 40          	sub    $0x40,%rsp
  802a6e:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802a71:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802a74:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802a78:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802a7b:	48 89 d6             	mov    %rdx,%rsi
  802a7e:	89 c7                	mov    %eax,%edi
  802a80:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802a87:	00 00 00 
  802a8a:	ff d0                	callq  *%rax
  802a8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a93:	79 08                	jns    802a9d <dup+0x37>
  802a95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a98:	e9 70 01 00 00       	jmpq   802c0d <dup+0x1a7>
  802a9d:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802aa0:	89 c7                	mov    %eax,%edi
  802aa2:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  802aa9:	00 00 00 
  802aac:	ff d0                	callq  *%rax
  802aae:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802ab1:	48 98                	cltq   
  802ab3:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802ab9:	48 c1 e0 0c          	shl    $0xc,%rax
  802abd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802ac1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802ac5:	48 89 c7             	mov    %rax,%rdi
  802ac8:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802acf:	00 00 00 
  802ad2:	ff d0                	callq  *%rax
  802ad4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802ad8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802adc:	48 89 c7             	mov    %rax,%rdi
  802adf:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802ae6:	00 00 00 
  802ae9:	ff d0                	callq  *%rax
  802aeb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802aef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802af3:	48 c1 e8 15          	shr    $0x15,%rax
  802af7:	48 89 c2             	mov    %rax,%rdx
  802afa:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802b01:	01 00 00 
  802b04:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b08:	83 e0 01             	and    $0x1,%eax
  802b0b:	48 85 c0             	test   %rax,%rax
  802b0e:	74 73                	je     802b83 <dup+0x11d>
  802b10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b14:	48 c1 e8 0c          	shr    $0xc,%rax
  802b18:	48 89 c2             	mov    %rax,%rdx
  802b1b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802b22:	01 00 00 
  802b25:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b29:	83 e0 01             	and    $0x1,%eax
  802b2c:	48 85 c0             	test   %rax,%rax
  802b2f:	74 52                	je     802b83 <dup+0x11d>
  802b31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b35:	48 c1 e8 0c          	shr    $0xc,%rax
  802b39:	48 89 c2             	mov    %rax,%rdx
  802b3c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802b43:	01 00 00 
  802b46:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b4a:	25 07 0e 00 00       	and    $0xe07,%eax
  802b4f:	89 c1                	mov    %eax,%ecx
  802b51:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802b55:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b59:	41 89 c8             	mov    %ecx,%r8d
  802b5c:	48 89 d1             	mov    %rdx,%rcx
  802b5f:	ba 00 00 00 00       	mov    $0x0,%edx
  802b64:	48 89 c6             	mov    %rax,%rsi
  802b67:	bf 00 00 00 00       	mov    $0x0,%edi
  802b6c:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  802b73:	00 00 00 
  802b76:	ff d0                	callq  *%rax
  802b78:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b7b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b7f:	79 02                	jns    802b83 <dup+0x11d>
  802b81:	eb 57                	jmp    802bda <dup+0x174>
  802b83:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b87:	48 c1 e8 0c          	shr    $0xc,%rax
  802b8b:	48 89 c2             	mov    %rax,%rdx
  802b8e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802b95:	01 00 00 
  802b98:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b9c:	25 07 0e 00 00       	and    $0xe07,%eax
  802ba1:	89 c1                	mov    %eax,%ecx
  802ba3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802ba7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802bab:	41 89 c8             	mov    %ecx,%r8d
  802bae:	48 89 d1             	mov    %rdx,%rcx
  802bb1:	ba 00 00 00 00       	mov    $0x0,%edx
  802bb6:	48 89 c6             	mov    %rax,%rsi
  802bb9:	bf 00 00 00 00       	mov    $0x0,%edi
  802bbe:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  802bc5:	00 00 00 
  802bc8:	ff d0                	callq  *%rax
  802bca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802bcd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802bd1:	79 02                	jns    802bd5 <dup+0x16f>
  802bd3:	eb 05                	jmp    802bda <dup+0x174>
  802bd5:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802bd8:	eb 33                	jmp    802c0d <dup+0x1a7>
  802bda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bde:	48 89 c6             	mov    %rax,%rsi
  802be1:	bf 00 00 00 00       	mov    $0x0,%edi
  802be6:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  802bed:	00 00 00 
  802bf0:	ff d0                	callq  *%rax
  802bf2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802bf6:	48 89 c6             	mov    %rax,%rsi
  802bf9:	bf 00 00 00 00       	mov    $0x0,%edi
  802bfe:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  802c05:	00 00 00 
  802c08:	ff d0                	callq  *%rax
  802c0a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c0d:	c9                   	leaveq 
  802c0e:	c3                   	retq   

0000000000802c0f <read>:
  802c0f:	55                   	push   %rbp
  802c10:	48 89 e5             	mov    %rsp,%rbp
  802c13:	48 83 ec 40          	sub    $0x40,%rsp
  802c17:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c1a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802c1e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802c22:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c26:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c29:	48 89 d6             	mov    %rdx,%rsi
  802c2c:	89 c7                	mov    %eax,%edi
  802c2e:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802c35:	00 00 00 
  802c38:	ff d0                	callq  *%rax
  802c3a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c3d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c41:	78 24                	js     802c67 <read+0x58>
  802c43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c47:	8b 00                	mov    (%rax),%eax
  802c49:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c4d:	48 89 d6             	mov    %rdx,%rsi
  802c50:	89 c7                	mov    %eax,%edi
  802c52:	48 b8 36 29 80 00 00 	movabs $0x802936,%rax
  802c59:	00 00 00 
  802c5c:	ff d0                	callq  *%rax
  802c5e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c61:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c65:	79 05                	jns    802c6c <read+0x5d>
  802c67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c6a:	eb 76                	jmp    802ce2 <read+0xd3>
  802c6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c70:	8b 40 08             	mov    0x8(%rax),%eax
  802c73:	83 e0 03             	and    $0x3,%eax
  802c76:	83 f8 01             	cmp    $0x1,%eax
  802c79:	75 3a                	jne    802cb5 <read+0xa6>
  802c7b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802c82:	00 00 00 
  802c85:	48 8b 00             	mov    (%rax),%rax
  802c88:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802c8e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802c91:	89 c6                	mov    %eax,%esi
  802c93:	48 bf f7 53 80 00 00 	movabs $0x8053f7,%rdi
  802c9a:	00 00 00 
  802c9d:	b8 00 00 00 00       	mov    $0x0,%eax
  802ca2:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  802ca9:	00 00 00 
  802cac:	ff d1                	callq  *%rcx
  802cae:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802cb3:	eb 2d                	jmp    802ce2 <read+0xd3>
  802cb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cb9:	48 8b 40 10          	mov    0x10(%rax),%rax
  802cbd:	48 85 c0             	test   %rax,%rax
  802cc0:	75 07                	jne    802cc9 <read+0xba>
  802cc2:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802cc7:	eb 19                	jmp    802ce2 <read+0xd3>
  802cc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ccd:	48 8b 40 10          	mov    0x10(%rax),%rax
  802cd1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802cd5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802cd9:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802cdd:	48 89 cf             	mov    %rcx,%rdi
  802ce0:	ff d0                	callq  *%rax
  802ce2:	c9                   	leaveq 
  802ce3:	c3                   	retq   

0000000000802ce4 <readn>:
  802ce4:	55                   	push   %rbp
  802ce5:	48 89 e5             	mov    %rsp,%rbp
  802ce8:	48 83 ec 30          	sub    $0x30,%rsp
  802cec:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802cef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802cf3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802cf7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802cfe:	eb 49                	jmp    802d49 <readn+0x65>
  802d00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d03:	48 98                	cltq   
  802d05:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802d09:	48 29 c2             	sub    %rax,%rdx
  802d0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d0f:	48 63 c8             	movslq %eax,%rcx
  802d12:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d16:	48 01 c1             	add    %rax,%rcx
  802d19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d1c:	48 89 ce             	mov    %rcx,%rsi
  802d1f:	89 c7                	mov    %eax,%edi
  802d21:	48 b8 0f 2c 80 00 00 	movabs $0x802c0f,%rax
  802d28:	00 00 00 
  802d2b:	ff d0                	callq  *%rax
  802d2d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802d30:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802d34:	79 05                	jns    802d3b <readn+0x57>
  802d36:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d39:	eb 1c                	jmp    802d57 <readn+0x73>
  802d3b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802d3f:	75 02                	jne    802d43 <readn+0x5f>
  802d41:	eb 11                	jmp    802d54 <readn+0x70>
  802d43:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d46:	01 45 fc             	add    %eax,-0x4(%rbp)
  802d49:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d4c:	48 98                	cltq   
  802d4e:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802d52:	72 ac                	jb     802d00 <readn+0x1c>
  802d54:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d57:	c9                   	leaveq 
  802d58:	c3                   	retq   

0000000000802d59 <write>:
  802d59:	55                   	push   %rbp
  802d5a:	48 89 e5             	mov    %rsp,%rbp
  802d5d:	48 83 ec 40          	sub    $0x40,%rsp
  802d61:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802d64:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802d68:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802d6c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802d70:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802d73:	48 89 d6             	mov    %rdx,%rsi
  802d76:	89 c7                	mov    %eax,%edi
  802d78:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802d7f:	00 00 00 
  802d82:	ff d0                	callq  *%rax
  802d84:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d87:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d8b:	78 24                	js     802db1 <write+0x58>
  802d8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d91:	8b 00                	mov    (%rax),%eax
  802d93:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d97:	48 89 d6             	mov    %rdx,%rsi
  802d9a:	89 c7                	mov    %eax,%edi
  802d9c:	48 b8 36 29 80 00 00 	movabs $0x802936,%rax
  802da3:	00 00 00 
  802da6:	ff d0                	callq  *%rax
  802da8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802dab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802daf:	79 05                	jns    802db6 <write+0x5d>
  802db1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802db4:	eb 75                	jmp    802e2b <write+0xd2>
  802db6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dba:	8b 40 08             	mov    0x8(%rax),%eax
  802dbd:	83 e0 03             	and    $0x3,%eax
  802dc0:	85 c0                	test   %eax,%eax
  802dc2:	75 3a                	jne    802dfe <write+0xa5>
  802dc4:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802dcb:	00 00 00 
  802dce:	48 8b 00             	mov    (%rax),%rax
  802dd1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802dd7:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802dda:	89 c6                	mov    %eax,%esi
  802ddc:	48 bf 13 54 80 00 00 	movabs $0x805413,%rdi
  802de3:	00 00 00 
  802de6:	b8 00 00 00 00       	mov    $0x0,%eax
  802deb:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  802df2:	00 00 00 
  802df5:	ff d1                	callq  *%rcx
  802df7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802dfc:	eb 2d                	jmp    802e2b <write+0xd2>
  802dfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e02:	48 8b 40 18          	mov    0x18(%rax),%rax
  802e06:	48 85 c0             	test   %rax,%rax
  802e09:	75 07                	jne    802e12 <write+0xb9>
  802e0b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802e10:	eb 19                	jmp    802e2b <write+0xd2>
  802e12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e16:	48 8b 40 18          	mov    0x18(%rax),%rax
  802e1a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802e1e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802e22:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802e26:	48 89 cf             	mov    %rcx,%rdi
  802e29:	ff d0                	callq  *%rax
  802e2b:	c9                   	leaveq 
  802e2c:	c3                   	retq   

0000000000802e2d <seek>:
  802e2d:	55                   	push   %rbp
  802e2e:	48 89 e5             	mov    %rsp,%rbp
  802e31:	48 83 ec 18          	sub    $0x18,%rsp
  802e35:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802e38:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802e3b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802e3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e42:	48 89 d6             	mov    %rdx,%rsi
  802e45:	89 c7                	mov    %eax,%edi
  802e47:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802e4e:	00 00 00 
  802e51:	ff d0                	callq  *%rax
  802e53:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e56:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e5a:	79 05                	jns    802e61 <seek+0x34>
  802e5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e5f:	eb 0f                	jmp    802e70 <seek+0x43>
  802e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e65:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802e68:	89 50 04             	mov    %edx,0x4(%rax)
  802e6b:	b8 00 00 00 00       	mov    $0x0,%eax
  802e70:	c9                   	leaveq 
  802e71:	c3                   	retq   

0000000000802e72 <ftruncate>:
  802e72:	55                   	push   %rbp
  802e73:	48 89 e5             	mov    %rsp,%rbp
  802e76:	48 83 ec 30          	sub    $0x30,%rsp
  802e7a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802e7d:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802e80:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802e84:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802e87:	48 89 d6             	mov    %rdx,%rsi
  802e8a:	89 c7                	mov    %eax,%edi
  802e8c:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802e93:	00 00 00 
  802e96:	ff d0                	callq  *%rax
  802e98:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e9f:	78 24                	js     802ec5 <ftruncate+0x53>
  802ea1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ea5:	8b 00                	mov    (%rax),%eax
  802ea7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802eab:	48 89 d6             	mov    %rdx,%rsi
  802eae:	89 c7                	mov    %eax,%edi
  802eb0:	48 b8 36 29 80 00 00 	movabs $0x802936,%rax
  802eb7:	00 00 00 
  802eba:	ff d0                	callq  *%rax
  802ebc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ebf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ec3:	79 05                	jns    802eca <ftruncate+0x58>
  802ec5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ec8:	eb 72                	jmp    802f3c <ftruncate+0xca>
  802eca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ece:	8b 40 08             	mov    0x8(%rax),%eax
  802ed1:	83 e0 03             	and    $0x3,%eax
  802ed4:	85 c0                	test   %eax,%eax
  802ed6:	75 3a                	jne    802f12 <ftruncate+0xa0>
  802ed8:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802edf:	00 00 00 
  802ee2:	48 8b 00             	mov    (%rax),%rax
  802ee5:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802eeb:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802eee:	89 c6                	mov    %eax,%esi
  802ef0:	48 bf 30 54 80 00 00 	movabs $0x805430,%rdi
  802ef7:	00 00 00 
  802efa:	b8 00 00 00 00       	mov    $0x0,%eax
  802eff:	48 b9 1e 08 80 00 00 	movabs $0x80081e,%rcx
  802f06:	00 00 00 
  802f09:	ff d1                	callq  *%rcx
  802f0b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802f10:	eb 2a                	jmp    802f3c <ftruncate+0xca>
  802f12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f16:	48 8b 40 30          	mov    0x30(%rax),%rax
  802f1a:	48 85 c0             	test   %rax,%rax
  802f1d:	75 07                	jne    802f26 <ftruncate+0xb4>
  802f1f:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802f24:	eb 16                	jmp    802f3c <ftruncate+0xca>
  802f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f2a:	48 8b 40 30          	mov    0x30(%rax),%rax
  802f2e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802f32:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802f35:	89 ce                	mov    %ecx,%esi
  802f37:	48 89 d7             	mov    %rdx,%rdi
  802f3a:	ff d0                	callq  *%rax
  802f3c:	c9                   	leaveq 
  802f3d:	c3                   	retq   

0000000000802f3e <fstat>:
  802f3e:	55                   	push   %rbp
  802f3f:	48 89 e5             	mov    %rsp,%rbp
  802f42:	48 83 ec 30          	sub    $0x30,%rsp
  802f46:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802f49:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802f4d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802f51:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802f54:	48 89 d6             	mov    %rdx,%rsi
  802f57:	89 c7                	mov    %eax,%edi
  802f59:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  802f60:	00 00 00 
  802f63:	ff d0                	callq  *%rax
  802f65:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f68:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f6c:	78 24                	js     802f92 <fstat+0x54>
  802f6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f72:	8b 00                	mov    (%rax),%eax
  802f74:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802f78:	48 89 d6             	mov    %rdx,%rsi
  802f7b:	89 c7                	mov    %eax,%edi
  802f7d:	48 b8 36 29 80 00 00 	movabs $0x802936,%rax
  802f84:	00 00 00 
  802f87:	ff d0                	callq  *%rax
  802f89:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f8c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f90:	79 05                	jns    802f97 <fstat+0x59>
  802f92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f95:	eb 5e                	jmp    802ff5 <fstat+0xb7>
  802f97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f9b:	48 8b 40 28          	mov    0x28(%rax),%rax
  802f9f:	48 85 c0             	test   %rax,%rax
  802fa2:	75 07                	jne    802fab <fstat+0x6d>
  802fa4:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802fa9:	eb 4a                	jmp    802ff5 <fstat+0xb7>
  802fab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802faf:	c6 00 00             	movb   $0x0,(%rax)
  802fb2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802fb6:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802fbd:	00 00 00 
  802fc0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802fc4:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802fcb:	00 00 00 
  802fce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802fd2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802fd6:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802fdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802fe1:	48 8b 40 28          	mov    0x28(%rax),%rax
  802fe5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802fe9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802fed:	48 89 ce             	mov    %rcx,%rsi
  802ff0:	48 89 d7             	mov    %rdx,%rdi
  802ff3:	ff d0                	callq  *%rax
  802ff5:	c9                   	leaveq 
  802ff6:	c3                   	retq   

0000000000802ff7 <stat>:
  802ff7:	55                   	push   %rbp
  802ff8:	48 89 e5             	mov    %rsp,%rbp
  802ffb:	48 83 ec 20          	sub    $0x20,%rsp
  802fff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803003:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803007:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80300b:	be 00 00 00 00       	mov    $0x0,%esi
  803010:	48 89 c7             	mov    %rax,%rdi
  803013:	48 b8 e5 30 80 00 00 	movabs $0x8030e5,%rax
  80301a:	00 00 00 
  80301d:	ff d0                	callq  *%rax
  80301f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803022:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803026:	79 05                	jns    80302d <stat+0x36>
  803028:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80302b:	eb 2f                	jmp    80305c <stat+0x65>
  80302d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803031:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803034:	48 89 d6             	mov    %rdx,%rsi
  803037:	89 c7                	mov    %eax,%edi
  803039:	48 b8 3e 2f 80 00 00 	movabs $0x802f3e,%rax
  803040:	00 00 00 
  803043:	ff d0                	callq  *%rax
  803045:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803048:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80304b:	89 c7                	mov    %eax,%edi
  80304d:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  803054:	00 00 00 
  803057:	ff d0                	callq  *%rax
  803059:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80305c:	c9                   	leaveq 
  80305d:	c3                   	retq   

000000000080305e <fsipc>:
  80305e:	55                   	push   %rbp
  80305f:	48 89 e5             	mov    %rsp,%rbp
  803062:	48 83 ec 10          	sub    $0x10,%rsp
  803066:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803069:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80306d:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  803074:	00 00 00 
  803077:	8b 00                	mov    (%rax),%eax
  803079:	85 c0                	test   %eax,%eax
  80307b:	75 1d                	jne    80309a <fsipc+0x3c>
  80307d:	bf 01 00 00 00       	mov    $0x1,%edi
  803082:	48 b8 33 4b 80 00 00 	movabs $0x804b33,%rax
  803089:	00 00 00 
  80308c:	ff d0                	callq  *%rax
  80308e:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  803095:	00 00 00 
  803098:	89 02                	mov    %eax,(%rdx)
  80309a:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8030a1:	00 00 00 
  8030a4:	8b 00                	mov    (%rax),%eax
  8030a6:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8030a9:	b9 07 00 00 00       	mov    $0x7,%ecx
  8030ae:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  8030b5:	00 00 00 
  8030b8:	89 c7                	mov    %eax,%edi
  8030ba:	48 b8 28 4a 80 00 00 	movabs $0x804a28,%rax
  8030c1:	00 00 00 
  8030c4:	ff d0                	callq  *%rax
  8030c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8030ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8030cf:	48 89 c6             	mov    %rax,%rsi
  8030d2:	bf 00 00 00 00       	mov    $0x0,%edi
  8030d7:	48 b8 67 49 80 00 00 	movabs $0x804967,%rax
  8030de:	00 00 00 
  8030e1:	ff d0                	callq  *%rax
  8030e3:	c9                   	leaveq 
  8030e4:	c3                   	retq   

00000000008030e5 <open>:
  8030e5:	55                   	push   %rbp
  8030e6:	48 89 e5             	mov    %rsp,%rbp
  8030e9:	48 83 ec 20          	sub    $0x20,%rsp
  8030ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8030f1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8030f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030f8:	48 89 c7             	mov    %rax,%rdi
  8030fb:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  803102:	00 00 00 
  803105:	ff d0                	callq  *%rax
  803107:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  80310c:	7e 0a                	jle    803118 <open+0x33>
  80310e:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803113:	e9 a5 00 00 00       	jmpq   8031bd <open+0xd8>
  803118:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80311c:	48 89 c7             	mov    %rax,%rdi
  80311f:	48 b8 45 27 80 00 00 	movabs $0x802745,%rax
  803126:	00 00 00 
  803129:	ff d0                	callq  *%rax
  80312b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80312e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803132:	79 08                	jns    80313c <open+0x57>
  803134:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803137:	e9 81 00 00 00       	jmpq   8031bd <open+0xd8>
  80313c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803140:	48 89 c6             	mov    %rax,%rsi
  803143:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  80314a:	00 00 00 
  80314d:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  803154:	00 00 00 
  803157:	ff d0                	callq  *%rax
  803159:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803160:	00 00 00 
  803163:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803166:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  80316c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803170:	48 89 c6             	mov    %rax,%rsi
  803173:	bf 01 00 00 00       	mov    $0x1,%edi
  803178:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  80317f:	00 00 00 
  803182:	ff d0                	callq  *%rax
  803184:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803187:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80318b:	79 1d                	jns    8031aa <open+0xc5>
  80318d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803191:	be 00 00 00 00       	mov    $0x0,%esi
  803196:	48 89 c7             	mov    %rax,%rdi
  803199:	48 b8 6d 28 80 00 00 	movabs $0x80286d,%rax
  8031a0:	00 00 00 
  8031a3:	ff d0                	callq  *%rax
  8031a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031a8:	eb 13                	jmp    8031bd <open+0xd8>
  8031aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031ae:	48 89 c7             	mov    %rax,%rdi
  8031b1:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  8031b8:	00 00 00 
  8031bb:	ff d0                	callq  *%rax
  8031bd:	c9                   	leaveq 
  8031be:	c3                   	retq   

00000000008031bf <devfile_flush>:
  8031bf:	55                   	push   %rbp
  8031c0:	48 89 e5             	mov    %rsp,%rbp
  8031c3:	48 83 ec 10          	sub    $0x10,%rsp
  8031c7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8031cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8031cf:	8b 50 0c             	mov    0xc(%rax),%edx
  8031d2:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8031d9:	00 00 00 
  8031dc:	89 10                	mov    %edx,(%rax)
  8031de:	be 00 00 00 00       	mov    $0x0,%esi
  8031e3:	bf 06 00 00 00       	mov    $0x6,%edi
  8031e8:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  8031ef:	00 00 00 
  8031f2:	ff d0                	callq  *%rax
  8031f4:	c9                   	leaveq 
  8031f5:	c3                   	retq   

00000000008031f6 <devfile_read>:
  8031f6:	55                   	push   %rbp
  8031f7:	48 89 e5             	mov    %rsp,%rbp
  8031fa:	48 83 ec 30          	sub    $0x30,%rsp
  8031fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803202:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803206:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80320a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80320e:	8b 50 0c             	mov    0xc(%rax),%edx
  803211:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803218:	00 00 00 
  80321b:	89 10                	mov    %edx,(%rax)
  80321d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803224:	00 00 00 
  803227:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80322b:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80322f:	be 00 00 00 00       	mov    $0x0,%esi
  803234:	bf 03 00 00 00       	mov    $0x3,%edi
  803239:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  803240:	00 00 00 
  803243:	ff d0                	callq  *%rax
  803245:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803248:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80324c:	79 08                	jns    803256 <devfile_read+0x60>
  80324e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803251:	e9 a4 00 00 00       	jmpq   8032fa <devfile_read+0x104>
  803256:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803259:	48 98                	cltq   
  80325b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80325f:	76 35                	jbe    803296 <devfile_read+0xa0>
  803261:	48 b9 56 54 80 00 00 	movabs $0x805456,%rcx
  803268:	00 00 00 
  80326b:	48 ba 5d 54 80 00 00 	movabs $0x80545d,%rdx
  803272:	00 00 00 
  803275:	be 89 00 00 00       	mov    $0x89,%esi
  80327a:	48 bf 72 54 80 00 00 	movabs $0x805472,%rdi
  803281:	00 00 00 
  803284:	b8 00 00 00 00       	mov    $0x0,%eax
  803289:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  803290:	00 00 00 
  803293:	41 ff d0             	callq  *%r8
  803296:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  80329d:	7e 35                	jle    8032d4 <devfile_read+0xde>
  80329f:	48 b9 80 54 80 00 00 	movabs $0x805480,%rcx
  8032a6:	00 00 00 
  8032a9:	48 ba 5d 54 80 00 00 	movabs $0x80545d,%rdx
  8032b0:	00 00 00 
  8032b3:	be 8a 00 00 00       	mov    $0x8a,%esi
  8032b8:	48 bf 72 54 80 00 00 	movabs $0x805472,%rdi
  8032bf:	00 00 00 
  8032c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8032c7:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8032ce:	00 00 00 
  8032d1:	41 ff d0             	callq  *%r8
  8032d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032d7:	48 63 d0             	movslq %eax,%rdx
  8032da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8032de:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8032e5:	00 00 00 
  8032e8:	48 89 c7             	mov    %rax,%rdi
  8032eb:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  8032f2:	00 00 00 
  8032f5:	ff d0                	callq  *%rax
  8032f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032fa:	c9                   	leaveq 
  8032fb:	c3                   	retq   

00000000008032fc <devfile_write>:
  8032fc:	55                   	push   %rbp
  8032fd:	48 89 e5             	mov    %rsp,%rbp
  803300:	48 83 ec 40          	sub    $0x40,%rsp
  803304:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803308:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80330c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803310:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803314:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803318:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  80331f:	00 
  803320:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803324:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  803328:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  80332d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  803331:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803335:	8b 50 0c             	mov    0xc(%rax),%edx
  803338:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80333f:	00 00 00 
  803342:	89 10                	mov    %edx,(%rax)
  803344:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80334b:	00 00 00 
  80334e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803352:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803356:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80335a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80335e:	48 89 c6             	mov    %rax,%rsi
  803361:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  803368:	00 00 00 
  80336b:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803372:	00 00 00 
  803375:	ff d0                	callq  *%rax
  803377:	be 00 00 00 00       	mov    $0x0,%esi
  80337c:	bf 04 00 00 00       	mov    $0x4,%edi
  803381:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  803388:	00 00 00 
  80338b:	ff d0                	callq  *%rax
  80338d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803390:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803394:	79 05                	jns    80339b <devfile_write+0x9f>
  803396:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803399:	eb 43                	jmp    8033de <devfile_write+0xe2>
  80339b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80339e:	48 98                	cltq   
  8033a0:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8033a4:	76 35                	jbe    8033db <devfile_write+0xdf>
  8033a6:	48 b9 56 54 80 00 00 	movabs $0x805456,%rcx
  8033ad:	00 00 00 
  8033b0:	48 ba 5d 54 80 00 00 	movabs $0x80545d,%rdx
  8033b7:	00 00 00 
  8033ba:	be a8 00 00 00       	mov    $0xa8,%esi
  8033bf:	48 bf 72 54 80 00 00 	movabs $0x805472,%rdi
  8033c6:	00 00 00 
  8033c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8033ce:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8033d5:	00 00 00 
  8033d8:	41 ff d0             	callq  *%r8
  8033db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8033de:	c9                   	leaveq 
  8033df:	c3                   	retq   

00000000008033e0 <devfile_stat>:
  8033e0:	55                   	push   %rbp
  8033e1:	48 89 e5             	mov    %rsp,%rbp
  8033e4:	48 83 ec 20          	sub    $0x20,%rsp
  8033e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8033ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8033f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033f4:	8b 50 0c             	mov    0xc(%rax),%edx
  8033f7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8033fe:	00 00 00 
  803401:	89 10                	mov    %edx,(%rax)
  803403:	be 00 00 00 00       	mov    $0x0,%esi
  803408:	bf 05 00 00 00       	mov    $0x5,%edi
  80340d:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  803414:	00 00 00 
  803417:	ff d0                	callq  *%rax
  803419:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80341c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803420:	79 05                	jns    803427 <devfile_stat+0x47>
  803422:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803425:	eb 56                	jmp    80347d <devfile_stat+0x9d>
  803427:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80342b:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803432:	00 00 00 
  803435:	48 89 c7             	mov    %rax,%rdi
  803438:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  80343f:	00 00 00 
  803442:	ff d0                	callq  *%rax
  803444:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80344b:	00 00 00 
  80344e:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803454:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803458:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80345e:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803465:	00 00 00 
  803468:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80346e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803472:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803478:	b8 00 00 00 00       	mov    $0x0,%eax
  80347d:	c9                   	leaveq 
  80347e:	c3                   	retq   

000000000080347f <devfile_trunc>:
  80347f:	55                   	push   %rbp
  803480:	48 89 e5             	mov    %rsp,%rbp
  803483:	48 83 ec 10          	sub    $0x10,%rsp
  803487:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80348b:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80348e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803492:	8b 50 0c             	mov    0xc(%rax),%edx
  803495:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80349c:	00 00 00 
  80349f:	89 10                	mov    %edx,(%rax)
  8034a1:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034a8:	00 00 00 
  8034ab:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8034ae:	89 50 04             	mov    %edx,0x4(%rax)
  8034b1:	be 00 00 00 00       	mov    $0x0,%esi
  8034b6:	bf 02 00 00 00       	mov    $0x2,%edi
  8034bb:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  8034c2:	00 00 00 
  8034c5:	ff d0                	callq  *%rax
  8034c7:	c9                   	leaveq 
  8034c8:	c3                   	retq   

00000000008034c9 <remove>:
  8034c9:	55                   	push   %rbp
  8034ca:	48 89 e5             	mov    %rsp,%rbp
  8034cd:	48 83 ec 10          	sub    $0x10,%rsp
  8034d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8034d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8034d9:	48 89 c7             	mov    %rax,%rdi
  8034dc:	48 b8 67 13 80 00 00 	movabs $0x801367,%rax
  8034e3:	00 00 00 
  8034e6:	ff d0                	callq  *%rax
  8034e8:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8034ed:	7e 07                	jle    8034f6 <remove+0x2d>
  8034ef:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8034f4:	eb 33                	jmp    803529 <remove+0x60>
  8034f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8034fa:	48 89 c6             	mov    %rax,%rsi
  8034fd:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803504:	00 00 00 
  803507:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  80350e:	00 00 00 
  803511:	ff d0                	callq  *%rax
  803513:	be 00 00 00 00       	mov    $0x0,%esi
  803518:	bf 07 00 00 00       	mov    $0x7,%edi
  80351d:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  803524:	00 00 00 
  803527:	ff d0                	callq  *%rax
  803529:	c9                   	leaveq 
  80352a:	c3                   	retq   

000000000080352b <sync>:
  80352b:	55                   	push   %rbp
  80352c:	48 89 e5             	mov    %rsp,%rbp
  80352f:	be 00 00 00 00       	mov    $0x0,%esi
  803534:	bf 08 00 00 00       	mov    $0x8,%edi
  803539:	48 b8 5e 30 80 00 00 	movabs $0x80305e,%rax
  803540:	00 00 00 
  803543:	ff d0                	callq  *%rax
  803545:	5d                   	pop    %rbp
  803546:	c3                   	retq   

0000000000803547 <copy>:
  803547:	55                   	push   %rbp
  803548:	48 89 e5             	mov    %rsp,%rbp
  80354b:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  803552:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  803559:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  803560:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803567:	be 00 00 00 00       	mov    $0x0,%esi
  80356c:	48 89 c7             	mov    %rax,%rdi
  80356f:	48 b8 e5 30 80 00 00 	movabs $0x8030e5,%rax
  803576:	00 00 00 
  803579:	ff d0                	callq  *%rax
  80357b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80357e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803582:	79 28                	jns    8035ac <copy+0x65>
  803584:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803587:	89 c6                	mov    %eax,%esi
  803589:	48 bf 8c 54 80 00 00 	movabs $0x80548c,%rdi
  803590:	00 00 00 
  803593:	b8 00 00 00 00       	mov    $0x0,%eax
  803598:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  80359f:	00 00 00 
  8035a2:	ff d2                	callq  *%rdx
  8035a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035a7:	e9 74 01 00 00       	jmpq   803720 <copy+0x1d9>
  8035ac:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  8035b3:	be 01 01 00 00       	mov    $0x101,%esi
  8035b8:	48 89 c7             	mov    %rax,%rdi
  8035bb:	48 b8 e5 30 80 00 00 	movabs $0x8030e5,%rax
  8035c2:	00 00 00 
  8035c5:	ff d0                	callq  *%rax
  8035c7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8035ca:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8035ce:	79 39                	jns    803609 <copy+0xc2>
  8035d0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035d3:	89 c6                	mov    %eax,%esi
  8035d5:	48 bf a2 54 80 00 00 	movabs $0x8054a2,%rdi
  8035dc:	00 00 00 
  8035df:	b8 00 00 00 00       	mov    $0x0,%eax
  8035e4:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  8035eb:	00 00 00 
  8035ee:	ff d2                	callq  *%rdx
  8035f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035f3:	89 c7                	mov    %eax,%edi
  8035f5:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  8035fc:	00 00 00 
  8035ff:	ff d0                	callq  *%rax
  803601:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803604:	e9 17 01 00 00       	jmpq   803720 <copy+0x1d9>
  803609:	eb 74                	jmp    80367f <copy+0x138>
  80360b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80360e:	48 63 d0             	movslq %eax,%rdx
  803611:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803618:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80361b:	48 89 ce             	mov    %rcx,%rsi
  80361e:	89 c7                	mov    %eax,%edi
  803620:	48 b8 59 2d 80 00 00 	movabs $0x802d59,%rax
  803627:	00 00 00 
  80362a:	ff d0                	callq  *%rax
  80362c:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80362f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803633:	79 4a                	jns    80367f <copy+0x138>
  803635:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803638:	89 c6                	mov    %eax,%esi
  80363a:	48 bf bc 54 80 00 00 	movabs $0x8054bc,%rdi
  803641:	00 00 00 
  803644:	b8 00 00 00 00       	mov    $0x0,%eax
  803649:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  803650:	00 00 00 
  803653:	ff d2                	callq  *%rdx
  803655:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803658:	89 c7                	mov    %eax,%edi
  80365a:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  803661:	00 00 00 
  803664:	ff d0                	callq  *%rax
  803666:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803669:	89 c7                	mov    %eax,%edi
  80366b:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  803672:	00 00 00 
  803675:	ff d0                	callq  *%rax
  803677:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80367a:	e9 a1 00 00 00       	jmpq   803720 <copy+0x1d9>
  80367f:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803686:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803689:	ba 00 02 00 00       	mov    $0x200,%edx
  80368e:	48 89 ce             	mov    %rcx,%rsi
  803691:	89 c7                	mov    %eax,%edi
  803693:	48 b8 0f 2c 80 00 00 	movabs $0x802c0f,%rax
  80369a:	00 00 00 
  80369d:	ff d0                	callq  *%rax
  80369f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8036a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8036a6:	0f 8f 5f ff ff ff    	jg     80360b <copy+0xc4>
  8036ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8036b0:	79 47                	jns    8036f9 <copy+0x1b2>
  8036b2:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8036b5:	89 c6                	mov    %eax,%esi
  8036b7:	48 bf cf 54 80 00 00 	movabs $0x8054cf,%rdi
  8036be:	00 00 00 
  8036c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8036c6:	48 ba 1e 08 80 00 00 	movabs $0x80081e,%rdx
  8036cd:	00 00 00 
  8036d0:	ff d2                	callq  *%rdx
  8036d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036d5:	89 c7                	mov    %eax,%edi
  8036d7:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  8036de:	00 00 00 
  8036e1:	ff d0                	callq  *%rax
  8036e3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8036e6:	89 c7                	mov    %eax,%edi
  8036e8:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  8036ef:	00 00 00 
  8036f2:	ff d0                	callq  *%rax
  8036f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8036f7:	eb 27                	jmp    803720 <copy+0x1d9>
  8036f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036fc:	89 c7                	mov    %eax,%edi
  8036fe:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  803705:	00 00 00 
  803708:	ff d0                	callq  *%rax
  80370a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80370d:	89 c7                	mov    %eax,%edi
  80370f:	48 b8 ed 29 80 00 00 	movabs $0x8029ed,%rax
  803716:	00 00 00 
  803719:	ff d0                	callq  *%rax
  80371b:	b8 00 00 00 00       	mov    $0x0,%eax
  803720:	c9                   	leaveq 
  803721:	c3                   	retq   

0000000000803722 <fd2sockid>:
  803722:	55                   	push   %rbp
  803723:	48 89 e5             	mov    %rsp,%rbp
  803726:	48 83 ec 20          	sub    $0x20,%rsp
  80372a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80372d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803731:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803734:	48 89 d6             	mov    %rdx,%rsi
  803737:	89 c7                	mov    %eax,%edi
  803739:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  803740:	00 00 00 
  803743:	ff d0                	callq  *%rax
  803745:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803748:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80374c:	79 05                	jns    803753 <fd2sockid+0x31>
  80374e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803751:	eb 24                	jmp    803777 <fd2sockid+0x55>
  803753:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803757:	8b 10                	mov    (%rax),%edx
  803759:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803760:	00 00 00 
  803763:	8b 00                	mov    (%rax),%eax
  803765:	39 c2                	cmp    %eax,%edx
  803767:	74 07                	je     803770 <fd2sockid+0x4e>
  803769:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80376e:	eb 07                	jmp    803777 <fd2sockid+0x55>
  803770:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803774:	8b 40 0c             	mov    0xc(%rax),%eax
  803777:	c9                   	leaveq 
  803778:	c3                   	retq   

0000000000803779 <alloc_sockfd>:
  803779:	55                   	push   %rbp
  80377a:	48 89 e5             	mov    %rsp,%rbp
  80377d:	48 83 ec 20          	sub    $0x20,%rsp
  803781:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803784:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803788:	48 89 c7             	mov    %rax,%rdi
  80378b:	48 b8 45 27 80 00 00 	movabs $0x802745,%rax
  803792:	00 00 00 
  803795:	ff d0                	callq  *%rax
  803797:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80379a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80379e:	78 26                	js     8037c6 <alloc_sockfd+0x4d>
  8037a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037a4:	ba 07 04 00 00       	mov    $0x407,%edx
  8037a9:	48 89 c6             	mov    %rax,%rsi
  8037ac:	bf 00 00 00 00       	mov    $0x0,%edi
  8037b1:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  8037b8:	00 00 00 
  8037bb:	ff d0                	callq  *%rax
  8037bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037c4:	79 16                	jns    8037dc <alloc_sockfd+0x63>
  8037c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037c9:	89 c7                	mov    %eax,%edi
  8037cb:	48 b8 86 3c 80 00 00 	movabs $0x803c86,%rax
  8037d2:	00 00 00 
  8037d5:	ff d0                	callq  *%rax
  8037d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037da:	eb 3a                	jmp    803816 <alloc_sockfd+0x9d>
  8037dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037e0:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8037e7:	00 00 00 
  8037ea:	8b 12                	mov    (%rdx),%edx
  8037ec:	89 10                	mov    %edx,(%rax)
  8037ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037f2:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8037f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037fd:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803800:	89 50 0c             	mov    %edx,0xc(%rax)
  803803:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803807:	48 89 c7             	mov    %rax,%rdi
  80380a:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  803811:	00 00 00 
  803814:	ff d0                	callq  *%rax
  803816:	c9                   	leaveq 
  803817:	c3                   	retq   

0000000000803818 <accept>:
  803818:	55                   	push   %rbp
  803819:	48 89 e5             	mov    %rsp,%rbp
  80381c:	48 83 ec 30          	sub    $0x30,%rsp
  803820:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803823:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803827:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80382b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80382e:	89 c7                	mov    %eax,%edi
  803830:	48 b8 22 37 80 00 00 	movabs $0x803722,%rax
  803837:	00 00 00 
  80383a:	ff d0                	callq  *%rax
  80383c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80383f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803843:	79 05                	jns    80384a <accept+0x32>
  803845:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803848:	eb 3b                	jmp    803885 <accept+0x6d>
  80384a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80384e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803852:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803855:	48 89 ce             	mov    %rcx,%rsi
  803858:	89 c7                	mov    %eax,%edi
  80385a:	48 b8 63 3b 80 00 00 	movabs $0x803b63,%rax
  803861:	00 00 00 
  803864:	ff d0                	callq  *%rax
  803866:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803869:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80386d:	79 05                	jns    803874 <accept+0x5c>
  80386f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803872:	eb 11                	jmp    803885 <accept+0x6d>
  803874:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803877:	89 c7                	mov    %eax,%edi
  803879:	48 b8 79 37 80 00 00 	movabs $0x803779,%rax
  803880:	00 00 00 
  803883:	ff d0                	callq  *%rax
  803885:	c9                   	leaveq 
  803886:	c3                   	retq   

0000000000803887 <bind>:
  803887:	55                   	push   %rbp
  803888:	48 89 e5             	mov    %rsp,%rbp
  80388b:	48 83 ec 20          	sub    $0x20,%rsp
  80388f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803892:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803896:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803899:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80389c:	89 c7                	mov    %eax,%edi
  80389e:	48 b8 22 37 80 00 00 	movabs $0x803722,%rax
  8038a5:	00 00 00 
  8038a8:	ff d0                	callq  *%rax
  8038aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038b1:	79 05                	jns    8038b8 <bind+0x31>
  8038b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b6:	eb 1b                	jmp    8038d3 <bind+0x4c>
  8038b8:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8038bb:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8038bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038c2:	48 89 ce             	mov    %rcx,%rsi
  8038c5:	89 c7                	mov    %eax,%edi
  8038c7:	48 b8 e2 3b 80 00 00 	movabs $0x803be2,%rax
  8038ce:	00 00 00 
  8038d1:	ff d0                	callq  *%rax
  8038d3:	c9                   	leaveq 
  8038d4:	c3                   	retq   

00000000008038d5 <shutdown>:
  8038d5:	55                   	push   %rbp
  8038d6:	48 89 e5             	mov    %rsp,%rbp
  8038d9:	48 83 ec 20          	sub    $0x20,%rsp
  8038dd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8038e0:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8038e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8038e6:	89 c7                	mov    %eax,%edi
  8038e8:	48 b8 22 37 80 00 00 	movabs $0x803722,%rax
  8038ef:	00 00 00 
  8038f2:	ff d0                	callq  *%rax
  8038f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038fb:	79 05                	jns    803902 <shutdown+0x2d>
  8038fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803900:	eb 16                	jmp    803918 <shutdown+0x43>
  803902:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803905:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803908:	89 d6                	mov    %edx,%esi
  80390a:	89 c7                	mov    %eax,%edi
  80390c:	48 b8 46 3c 80 00 00 	movabs $0x803c46,%rax
  803913:	00 00 00 
  803916:	ff d0                	callq  *%rax
  803918:	c9                   	leaveq 
  803919:	c3                   	retq   

000000000080391a <devsock_close>:
  80391a:	55                   	push   %rbp
  80391b:	48 89 e5             	mov    %rsp,%rbp
  80391e:	48 83 ec 10          	sub    $0x10,%rsp
  803922:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803926:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80392a:	48 89 c7             	mov    %rax,%rdi
  80392d:	48 b8 a5 4b 80 00 00 	movabs $0x804ba5,%rax
  803934:	00 00 00 
  803937:	ff d0                	callq  *%rax
  803939:	83 f8 01             	cmp    $0x1,%eax
  80393c:	75 17                	jne    803955 <devsock_close+0x3b>
  80393e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803942:	8b 40 0c             	mov    0xc(%rax),%eax
  803945:	89 c7                	mov    %eax,%edi
  803947:	48 b8 86 3c 80 00 00 	movabs $0x803c86,%rax
  80394e:	00 00 00 
  803951:	ff d0                	callq  *%rax
  803953:	eb 05                	jmp    80395a <devsock_close+0x40>
  803955:	b8 00 00 00 00       	mov    $0x0,%eax
  80395a:	c9                   	leaveq 
  80395b:	c3                   	retq   

000000000080395c <connect>:
  80395c:	55                   	push   %rbp
  80395d:	48 89 e5             	mov    %rsp,%rbp
  803960:	48 83 ec 20          	sub    $0x20,%rsp
  803964:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803967:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80396b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80396e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803971:	89 c7                	mov    %eax,%edi
  803973:	48 b8 22 37 80 00 00 	movabs $0x803722,%rax
  80397a:	00 00 00 
  80397d:	ff d0                	callq  *%rax
  80397f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803982:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803986:	79 05                	jns    80398d <connect+0x31>
  803988:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80398b:	eb 1b                	jmp    8039a8 <connect+0x4c>
  80398d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803990:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803994:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803997:	48 89 ce             	mov    %rcx,%rsi
  80399a:	89 c7                	mov    %eax,%edi
  80399c:	48 b8 b3 3c 80 00 00 	movabs $0x803cb3,%rax
  8039a3:	00 00 00 
  8039a6:	ff d0                	callq  *%rax
  8039a8:	c9                   	leaveq 
  8039a9:	c3                   	retq   

00000000008039aa <listen>:
  8039aa:	55                   	push   %rbp
  8039ab:	48 89 e5             	mov    %rsp,%rbp
  8039ae:	48 83 ec 20          	sub    $0x20,%rsp
  8039b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039b5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8039b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039bb:	89 c7                	mov    %eax,%edi
  8039bd:	48 b8 22 37 80 00 00 	movabs $0x803722,%rax
  8039c4:	00 00 00 
  8039c7:	ff d0                	callq  *%rax
  8039c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039d0:	79 05                	jns    8039d7 <listen+0x2d>
  8039d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039d5:	eb 16                	jmp    8039ed <listen+0x43>
  8039d7:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8039da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039dd:	89 d6                	mov    %edx,%esi
  8039df:	89 c7                	mov    %eax,%edi
  8039e1:	48 b8 17 3d 80 00 00 	movabs $0x803d17,%rax
  8039e8:	00 00 00 
  8039eb:	ff d0                	callq  *%rax
  8039ed:	c9                   	leaveq 
  8039ee:	c3                   	retq   

00000000008039ef <devsock_read>:
  8039ef:	55                   	push   %rbp
  8039f0:	48 89 e5             	mov    %rsp,%rbp
  8039f3:	48 83 ec 20          	sub    $0x20,%rsp
  8039f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8039fb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039ff:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a07:	89 c2                	mov    %eax,%edx
  803a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a0d:	8b 40 0c             	mov    0xc(%rax),%eax
  803a10:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803a14:	b9 00 00 00 00       	mov    $0x0,%ecx
  803a19:	89 c7                	mov    %eax,%edi
  803a1b:	48 b8 57 3d 80 00 00 	movabs $0x803d57,%rax
  803a22:	00 00 00 
  803a25:	ff d0                	callq  *%rax
  803a27:	c9                   	leaveq 
  803a28:	c3                   	retq   

0000000000803a29 <devsock_write>:
  803a29:	55                   	push   %rbp
  803a2a:	48 89 e5             	mov    %rsp,%rbp
  803a2d:	48 83 ec 20          	sub    $0x20,%rsp
  803a31:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a35:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803a39:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803a3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a41:	89 c2                	mov    %eax,%edx
  803a43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a47:	8b 40 0c             	mov    0xc(%rax),%eax
  803a4a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803a4e:	b9 00 00 00 00       	mov    $0x0,%ecx
  803a53:	89 c7                	mov    %eax,%edi
  803a55:	48 b8 23 3e 80 00 00 	movabs $0x803e23,%rax
  803a5c:	00 00 00 
  803a5f:	ff d0                	callq  *%rax
  803a61:	c9                   	leaveq 
  803a62:	c3                   	retq   

0000000000803a63 <devsock_stat>:
  803a63:	55                   	push   %rbp
  803a64:	48 89 e5             	mov    %rsp,%rbp
  803a67:	48 83 ec 10          	sub    $0x10,%rsp
  803a6b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a6f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803a73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a77:	48 be ea 54 80 00 00 	movabs $0x8054ea,%rsi
  803a7e:	00 00 00 
  803a81:	48 89 c7             	mov    %rax,%rdi
  803a84:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  803a8b:	00 00 00 
  803a8e:	ff d0                	callq  *%rax
  803a90:	b8 00 00 00 00       	mov    $0x0,%eax
  803a95:	c9                   	leaveq 
  803a96:	c3                   	retq   

0000000000803a97 <socket>:
  803a97:	55                   	push   %rbp
  803a98:	48 89 e5             	mov    %rsp,%rbp
  803a9b:	48 83 ec 20          	sub    $0x20,%rsp
  803a9f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803aa2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803aa5:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803aa8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803aab:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803aae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ab1:	89 ce                	mov    %ecx,%esi
  803ab3:	89 c7                	mov    %eax,%edi
  803ab5:	48 b8 db 3e 80 00 00 	movabs $0x803edb,%rax
  803abc:	00 00 00 
  803abf:	ff d0                	callq  *%rax
  803ac1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ac4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ac8:	79 05                	jns    803acf <socket+0x38>
  803aca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803acd:	eb 11                	jmp    803ae0 <socket+0x49>
  803acf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ad2:	89 c7                	mov    %eax,%edi
  803ad4:	48 b8 79 37 80 00 00 	movabs $0x803779,%rax
  803adb:	00 00 00 
  803ade:	ff d0                	callq  *%rax
  803ae0:	c9                   	leaveq 
  803ae1:	c3                   	retq   

0000000000803ae2 <nsipc>:
  803ae2:	55                   	push   %rbp
  803ae3:	48 89 e5             	mov    %rsp,%rbp
  803ae6:	48 83 ec 10          	sub    $0x10,%rsp
  803aea:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803aed:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803af4:	00 00 00 
  803af7:	8b 00                	mov    (%rax),%eax
  803af9:	85 c0                	test   %eax,%eax
  803afb:	75 1d                	jne    803b1a <nsipc+0x38>
  803afd:	bf 02 00 00 00       	mov    $0x2,%edi
  803b02:	48 b8 33 4b 80 00 00 	movabs $0x804b33,%rax
  803b09:	00 00 00 
  803b0c:	ff d0                	callq  *%rax
  803b0e:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803b15:	00 00 00 
  803b18:	89 02                	mov    %eax,(%rdx)
  803b1a:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803b21:	00 00 00 
  803b24:	8b 00                	mov    (%rax),%eax
  803b26:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803b29:	b9 07 00 00 00       	mov    $0x7,%ecx
  803b2e:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803b35:	00 00 00 
  803b38:	89 c7                	mov    %eax,%edi
  803b3a:	48 b8 28 4a 80 00 00 	movabs $0x804a28,%rax
  803b41:	00 00 00 
  803b44:	ff d0                	callq  *%rax
  803b46:	ba 00 00 00 00       	mov    $0x0,%edx
  803b4b:	be 00 00 00 00       	mov    $0x0,%esi
  803b50:	bf 00 00 00 00       	mov    $0x0,%edi
  803b55:	48 b8 67 49 80 00 00 	movabs $0x804967,%rax
  803b5c:	00 00 00 
  803b5f:	ff d0                	callq  *%rax
  803b61:	c9                   	leaveq 
  803b62:	c3                   	retq   

0000000000803b63 <nsipc_accept>:
  803b63:	55                   	push   %rbp
  803b64:	48 89 e5             	mov    %rsp,%rbp
  803b67:	48 83 ec 30          	sub    $0x30,%rsp
  803b6b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b6e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b72:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803b76:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b7d:	00 00 00 
  803b80:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b83:	89 10                	mov    %edx,(%rax)
  803b85:	bf 01 00 00 00       	mov    $0x1,%edi
  803b8a:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803b91:	00 00 00 
  803b94:	ff d0                	callq  *%rax
  803b96:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b99:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b9d:	78 3e                	js     803bdd <nsipc_accept+0x7a>
  803b9f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ba6:	00 00 00 
  803ba9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803bad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bb1:	8b 40 10             	mov    0x10(%rax),%eax
  803bb4:	89 c2                	mov    %eax,%edx
  803bb6:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803bba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803bbe:	48 89 ce             	mov    %rcx,%rsi
  803bc1:	48 89 c7             	mov    %rax,%rdi
  803bc4:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803bcb:	00 00 00 
  803bce:	ff d0                	callq  *%rax
  803bd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bd4:	8b 50 10             	mov    0x10(%rax),%edx
  803bd7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bdb:	89 10                	mov    %edx,(%rax)
  803bdd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803be0:	c9                   	leaveq 
  803be1:	c3                   	retq   

0000000000803be2 <nsipc_bind>:
  803be2:	55                   	push   %rbp
  803be3:	48 89 e5             	mov    %rsp,%rbp
  803be6:	48 83 ec 10          	sub    $0x10,%rsp
  803bea:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803bed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803bf1:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803bf4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bfb:	00 00 00 
  803bfe:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c01:	89 10                	mov    %edx,(%rax)
  803c03:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c0a:	48 89 c6             	mov    %rax,%rsi
  803c0d:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803c14:	00 00 00 
  803c17:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803c1e:	00 00 00 
  803c21:	ff d0                	callq  *%rax
  803c23:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c2a:	00 00 00 
  803c2d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c30:	89 50 14             	mov    %edx,0x14(%rax)
  803c33:	bf 02 00 00 00       	mov    $0x2,%edi
  803c38:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803c3f:	00 00 00 
  803c42:	ff d0                	callq  *%rax
  803c44:	c9                   	leaveq 
  803c45:	c3                   	retq   

0000000000803c46 <nsipc_shutdown>:
  803c46:	55                   	push   %rbp
  803c47:	48 89 e5             	mov    %rsp,%rbp
  803c4a:	48 83 ec 10          	sub    $0x10,%rsp
  803c4e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c51:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803c54:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c5b:	00 00 00 
  803c5e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c61:	89 10                	mov    %edx,(%rax)
  803c63:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c6a:	00 00 00 
  803c6d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c70:	89 50 04             	mov    %edx,0x4(%rax)
  803c73:	bf 03 00 00 00       	mov    $0x3,%edi
  803c78:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803c7f:	00 00 00 
  803c82:	ff d0                	callq  *%rax
  803c84:	c9                   	leaveq 
  803c85:	c3                   	retq   

0000000000803c86 <nsipc_close>:
  803c86:	55                   	push   %rbp
  803c87:	48 89 e5             	mov    %rsp,%rbp
  803c8a:	48 83 ec 10          	sub    $0x10,%rsp
  803c8e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c91:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c98:	00 00 00 
  803c9b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c9e:	89 10                	mov    %edx,(%rax)
  803ca0:	bf 04 00 00 00       	mov    $0x4,%edi
  803ca5:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803cac:	00 00 00 
  803caf:	ff d0                	callq  *%rax
  803cb1:	c9                   	leaveq 
  803cb2:	c3                   	retq   

0000000000803cb3 <nsipc_connect>:
  803cb3:	55                   	push   %rbp
  803cb4:	48 89 e5             	mov    %rsp,%rbp
  803cb7:	48 83 ec 10          	sub    $0x10,%rsp
  803cbb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cbe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cc2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803cc5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ccc:	00 00 00 
  803ccf:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803cd2:	89 10                	mov    %edx,(%rax)
  803cd4:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803cd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cdb:	48 89 c6             	mov    %rax,%rsi
  803cde:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803ce5:	00 00 00 
  803ce8:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803cef:	00 00 00 
  803cf2:	ff d0                	callq  *%rax
  803cf4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cfb:	00 00 00 
  803cfe:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d01:	89 50 14             	mov    %edx,0x14(%rax)
  803d04:	bf 05 00 00 00       	mov    $0x5,%edi
  803d09:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803d10:	00 00 00 
  803d13:	ff d0                	callq  *%rax
  803d15:	c9                   	leaveq 
  803d16:	c3                   	retq   

0000000000803d17 <nsipc_listen>:
  803d17:	55                   	push   %rbp
  803d18:	48 89 e5             	mov    %rsp,%rbp
  803d1b:	48 83 ec 10          	sub    $0x10,%rsp
  803d1f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d22:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803d25:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d2c:	00 00 00 
  803d2f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d32:	89 10                	mov    %edx,(%rax)
  803d34:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d3b:	00 00 00 
  803d3e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d41:	89 50 04             	mov    %edx,0x4(%rax)
  803d44:	bf 06 00 00 00       	mov    $0x6,%edi
  803d49:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803d50:	00 00 00 
  803d53:	ff d0                	callq  *%rax
  803d55:	c9                   	leaveq 
  803d56:	c3                   	retq   

0000000000803d57 <nsipc_recv>:
  803d57:	55                   	push   %rbp
  803d58:	48 89 e5             	mov    %rsp,%rbp
  803d5b:	48 83 ec 30          	sub    $0x30,%rsp
  803d5f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d62:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803d66:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803d69:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803d6c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d73:	00 00 00 
  803d76:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803d79:	89 10                	mov    %edx,(%rax)
  803d7b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d82:	00 00 00 
  803d85:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803d88:	89 50 04             	mov    %edx,0x4(%rax)
  803d8b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d92:	00 00 00 
  803d95:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803d98:	89 50 08             	mov    %edx,0x8(%rax)
  803d9b:	bf 07 00 00 00       	mov    $0x7,%edi
  803da0:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803da7:	00 00 00 
  803daa:	ff d0                	callq  *%rax
  803dac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803daf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803db3:	78 69                	js     803e1e <nsipc_recv+0xc7>
  803db5:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803dbc:	7f 08                	jg     803dc6 <nsipc_recv+0x6f>
  803dbe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dc1:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803dc4:	7e 35                	jle    803dfb <nsipc_recv+0xa4>
  803dc6:	48 b9 f1 54 80 00 00 	movabs $0x8054f1,%rcx
  803dcd:	00 00 00 
  803dd0:	48 ba 06 55 80 00 00 	movabs $0x805506,%rdx
  803dd7:	00 00 00 
  803dda:	be 62 00 00 00       	mov    $0x62,%esi
  803ddf:	48 bf 1b 55 80 00 00 	movabs $0x80551b,%rdi
  803de6:	00 00 00 
  803de9:	b8 00 00 00 00       	mov    $0x0,%eax
  803dee:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  803df5:	00 00 00 
  803df8:	41 ff d0             	callq  *%r8
  803dfb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dfe:	48 63 d0             	movslq %eax,%rdx
  803e01:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e05:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803e0c:	00 00 00 
  803e0f:	48 89 c7             	mov    %rax,%rdi
  803e12:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803e19:	00 00 00 
  803e1c:	ff d0                	callq  *%rax
  803e1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e21:	c9                   	leaveq 
  803e22:	c3                   	retq   

0000000000803e23 <nsipc_send>:
  803e23:	55                   	push   %rbp
  803e24:	48 89 e5             	mov    %rsp,%rbp
  803e27:	48 83 ec 20          	sub    $0x20,%rsp
  803e2b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e2e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803e32:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803e35:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803e38:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e3f:	00 00 00 
  803e42:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803e45:	89 10                	mov    %edx,(%rax)
  803e47:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803e4e:	7e 35                	jle    803e85 <nsipc_send+0x62>
  803e50:	48 b9 2a 55 80 00 00 	movabs $0x80552a,%rcx
  803e57:	00 00 00 
  803e5a:	48 ba 06 55 80 00 00 	movabs $0x805506,%rdx
  803e61:	00 00 00 
  803e64:	be 6d 00 00 00       	mov    $0x6d,%esi
  803e69:	48 bf 1b 55 80 00 00 	movabs $0x80551b,%rdi
  803e70:	00 00 00 
  803e73:	b8 00 00 00 00       	mov    $0x0,%eax
  803e78:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  803e7f:	00 00 00 
  803e82:	41 ff d0             	callq  *%r8
  803e85:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803e88:	48 63 d0             	movslq %eax,%rdx
  803e8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e8f:	48 89 c6             	mov    %rax,%rsi
  803e92:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803e99:	00 00 00 
  803e9c:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  803ea3:	00 00 00 
  803ea6:	ff d0                	callq  *%rax
  803ea8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803eaf:	00 00 00 
  803eb2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803eb5:	89 50 04             	mov    %edx,0x4(%rax)
  803eb8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ebf:	00 00 00 
  803ec2:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803ec5:	89 50 08             	mov    %edx,0x8(%rax)
  803ec8:	bf 08 00 00 00       	mov    $0x8,%edi
  803ecd:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803ed4:	00 00 00 
  803ed7:	ff d0                	callq  *%rax
  803ed9:	c9                   	leaveq 
  803eda:	c3                   	retq   

0000000000803edb <nsipc_socket>:
  803edb:	55                   	push   %rbp
  803edc:	48 89 e5             	mov    %rsp,%rbp
  803edf:	48 83 ec 10          	sub    $0x10,%rsp
  803ee3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ee6:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803ee9:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803eec:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ef3:	00 00 00 
  803ef6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ef9:	89 10                	mov    %edx,(%rax)
  803efb:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f02:	00 00 00 
  803f05:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f08:	89 50 04             	mov    %edx,0x4(%rax)
  803f0b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f12:	00 00 00 
  803f15:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803f18:	89 50 08             	mov    %edx,0x8(%rax)
  803f1b:	bf 09 00 00 00       	mov    $0x9,%edi
  803f20:	48 b8 e2 3a 80 00 00 	movabs $0x803ae2,%rax
  803f27:	00 00 00 
  803f2a:	ff d0                	callq  *%rax
  803f2c:	c9                   	leaveq 
  803f2d:	c3                   	retq   

0000000000803f2e <pipe>:
  803f2e:	55                   	push   %rbp
  803f2f:	48 89 e5             	mov    %rsp,%rbp
  803f32:	53                   	push   %rbx
  803f33:	48 83 ec 38          	sub    $0x38,%rsp
  803f37:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803f3b:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803f3f:	48 89 c7             	mov    %rax,%rdi
  803f42:	48 b8 45 27 80 00 00 	movabs $0x802745,%rax
  803f49:	00 00 00 
  803f4c:	ff d0                	callq  *%rax
  803f4e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f51:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f55:	0f 88 bf 01 00 00    	js     80411a <pipe+0x1ec>
  803f5b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f5f:	ba 07 04 00 00       	mov    $0x407,%edx
  803f64:	48 89 c6             	mov    %rax,%rsi
  803f67:	bf 00 00 00 00       	mov    $0x0,%edi
  803f6c:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  803f73:	00 00 00 
  803f76:	ff d0                	callq  *%rax
  803f78:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f7f:	0f 88 95 01 00 00    	js     80411a <pipe+0x1ec>
  803f85:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803f89:	48 89 c7             	mov    %rax,%rdi
  803f8c:	48 b8 45 27 80 00 00 	movabs $0x802745,%rax
  803f93:	00 00 00 
  803f96:	ff d0                	callq  *%rax
  803f98:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f9f:	0f 88 5d 01 00 00    	js     804102 <pipe+0x1d4>
  803fa5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fa9:	ba 07 04 00 00       	mov    $0x407,%edx
  803fae:	48 89 c6             	mov    %rax,%rsi
  803fb1:	bf 00 00 00 00       	mov    $0x0,%edi
  803fb6:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  803fbd:	00 00 00 
  803fc0:	ff d0                	callq  *%rax
  803fc2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803fc5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803fc9:	0f 88 33 01 00 00    	js     804102 <pipe+0x1d4>
  803fcf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fd3:	48 89 c7             	mov    %rax,%rdi
  803fd6:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  803fdd:	00 00 00 
  803fe0:	ff d0                	callq  *%rax
  803fe2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803fe6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803fea:	ba 07 04 00 00       	mov    $0x407,%edx
  803fef:	48 89 c6             	mov    %rax,%rsi
  803ff2:	bf 00 00 00 00       	mov    $0x0,%edi
  803ff7:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  803ffe:	00 00 00 
  804001:	ff d0                	callq  *%rax
  804003:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804006:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80400a:	79 05                	jns    804011 <pipe+0xe3>
  80400c:	e9 d9 00 00 00       	jmpq   8040ea <pipe+0x1bc>
  804011:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804015:	48 89 c7             	mov    %rax,%rdi
  804018:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  80401f:	00 00 00 
  804022:	ff d0                	callq  *%rax
  804024:	48 89 c2             	mov    %rax,%rdx
  804027:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80402b:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  804031:	48 89 d1             	mov    %rdx,%rcx
  804034:	ba 00 00 00 00       	mov    $0x0,%edx
  804039:	48 89 c6             	mov    %rax,%rsi
  80403c:	bf 00 00 00 00       	mov    $0x0,%edi
  804041:	48 b8 52 1d 80 00 00 	movabs $0x801d52,%rax
  804048:	00 00 00 
  80404b:	ff d0                	callq  *%rax
  80404d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804050:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804054:	79 1b                	jns    804071 <pipe+0x143>
  804056:	90                   	nop
  804057:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80405b:	48 89 c6             	mov    %rax,%rsi
  80405e:	bf 00 00 00 00       	mov    $0x0,%edi
  804063:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  80406a:	00 00 00 
  80406d:	ff d0                	callq  *%rax
  80406f:	eb 79                	jmp    8040ea <pipe+0x1bc>
  804071:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804075:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  80407c:	00 00 00 
  80407f:	8b 12                	mov    (%rdx),%edx
  804081:	89 10                	mov    %edx,(%rax)
  804083:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804087:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80408e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804092:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804099:	00 00 00 
  80409c:	8b 12                	mov    (%rdx),%edx
  80409e:	89 10                	mov    %edx,(%rax)
  8040a0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040a4:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8040ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040af:	48 89 c7             	mov    %rax,%rdi
  8040b2:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  8040b9:	00 00 00 
  8040bc:	ff d0                	callq  *%rax
  8040be:	89 c2                	mov    %eax,%edx
  8040c0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8040c4:	89 10                	mov    %edx,(%rax)
  8040c6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8040ca:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8040ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040d2:	48 89 c7             	mov    %rax,%rdi
  8040d5:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  8040dc:	00 00 00 
  8040df:	ff d0                	callq  *%rax
  8040e1:	89 03                	mov    %eax,(%rbx)
  8040e3:	b8 00 00 00 00       	mov    $0x0,%eax
  8040e8:	eb 33                	jmp    80411d <pipe+0x1ef>
  8040ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040ee:	48 89 c6             	mov    %rax,%rsi
  8040f1:	bf 00 00 00 00       	mov    $0x0,%edi
  8040f6:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8040fd:	00 00 00 
  804100:	ff d0                	callq  *%rax
  804102:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804106:	48 89 c6             	mov    %rax,%rsi
  804109:	bf 00 00 00 00       	mov    $0x0,%edi
  80410e:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  804115:	00 00 00 
  804118:	ff d0                	callq  *%rax
  80411a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80411d:	48 83 c4 38          	add    $0x38,%rsp
  804121:	5b                   	pop    %rbx
  804122:	5d                   	pop    %rbp
  804123:	c3                   	retq   

0000000000804124 <_pipeisclosed>:
  804124:	55                   	push   %rbp
  804125:	48 89 e5             	mov    %rsp,%rbp
  804128:	53                   	push   %rbx
  804129:	48 83 ec 28          	sub    $0x28,%rsp
  80412d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804131:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804135:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80413c:	00 00 00 
  80413f:	48 8b 00             	mov    (%rax),%rax
  804142:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804148:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80414b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80414f:	48 89 c7             	mov    %rax,%rdi
  804152:	48 b8 a5 4b 80 00 00 	movabs $0x804ba5,%rax
  804159:	00 00 00 
  80415c:	ff d0                	callq  *%rax
  80415e:	89 c3                	mov    %eax,%ebx
  804160:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804164:	48 89 c7             	mov    %rax,%rdi
  804167:	48 b8 a5 4b 80 00 00 	movabs $0x804ba5,%rax
  80416e:	00 00 00 
  804171:	ff d0                	callq  *%rax
  804173:	39 c3                	cmp    %eax,%ebx
  804175:	0f 94 c0             	sete   %al
  804178:	0f b6 c0             	movzbl %al,%eax
  80417b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80417e:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804185:	00 00 00 
  804188:	48 8b 00             	mov    (%rax),%rax
  80418b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804191:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804194:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804197:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80419a:	75 05                	jne    8041a1 <_pipeisclosed+0x7d>
  80419c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80419f:	eb 4f                	jmp    8041f0 <_pipeisclosed+0xcc>
  8041a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8041a4:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8041a7:	74 42                	je     8041eb <_pipeisclosed+0xc7>
  8041a9:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8041ad:	75 3c                	jne    8041eb <_pipeisclosed+0xc7>
  8041af:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8041b6:	00 00 00 
  8041b9:	48 8b 00             	mov    (%rax),%rax
  8041bc:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  8041c2:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8041c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8041c8:	89 c6                	mov    %eax,%esi
  8041ca:	48 bf 3b 55 80 00 00 	movabs $0x80553b,%rdi
  8041d1:	00 00 00 
  8041d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8041d9:	49 b8 1e 08 80 00 00 	movabs $0x80081e,%r8
  8041e0:	00 00 00 
  8041e3:	41 ff d0             	callq  *%r8
  8041e6:	e9 4a ff ff ff       	jmpq   804135 <_pipeisclosed+0x11>
  8041eb:	e9 45 ff ff ff       	jmpq   804135 <_pipeisclosed+0x11>
  8041f0:	48 83 c4 28          	add    $0x28,%rsp
  8041f4:	5b                   	pop    %rbx
  8041f5:	5d                   	pop    %rbp
  8041f6:	c3                   	retq   

00000000008041f7 <pipeisclosed>:
  8041f7:	55                   	push   %rbp
  8041f8:	48 89 e5             	mov    %rsp,%rbp
  8041fb:	48 83 ec 30          	sub    $0x30,%rsp
  8041ff:	89 7d dc             	mov    %edi,-0x24(%rbp)
  804202:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  804206:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804209:	48 89 d6             	mov    %rdx,%rsi
  80420c:	89 c7                	mov    %eax,%edi
  80420e:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  804215:	00 00 00 
  804218:	ff d0                	callq  *%rax
  80421a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80421d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804221:	79 05                	jns    804228 <pipeisclosed+0x31>
  804223:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804226:	eb 31                	jmp    804259 <pipeisclosed+0x62>
  804228:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80422c:	48 89 c7             	mov    %rax,%rdi
  80422f:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  804236:	00 00 00 
  804239:	ff d0                	callq  *%rax
  80423b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80423f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804243:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804247:	48 89 d6             	mov    %rdx,%rsi
  80424a:	48 89 c7             	mov    %rax,%rdi
  80424d:	48 b8 24 41 80 00 00 	movabs $0x804124,%rax
  804254:	00 00 00 
  804257:	ff d0                	callq  *%rax
  804259:	c9                   	leaveq 
  80425a:	c3                   	retq   

000000000080425b <devpipe_read>:
  80425b:	55                   	push   %rbp
  80425c:	48 89 e5             	mov    %rsp,%rbp
  80425f:	48 83 ec 40          	sub    $0x40,%rsp
  804263:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804267:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80426b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80426f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804273:	48 89 c7             	mov    %rax,%rdi
  804276:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  80427d:	00 00 00 
  804280:	ff d0                	callq  *%rax
  804282:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804286:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80428a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80428e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804295:	00 
  804296:	e9 92 00 00 00       	jmpq   80432d <devpipe_read+0xd2>
  80429b:	eb 41                	jmp    8042de <devpipe_read+0x83>
  80429d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  8042a2:	74 09                	je     8042ad <devpipe_read+0x52>
  8042a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042a8:	e9 92 00 00 00       	jmpq   80433f <devpipe_read+0xe4>
  8042ad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8042b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8042b5:	48 89 d6             	mov    %rdx,%rsi
  8042b8:	48 89 c7             	mov    %rax,%rdi
  8042bb:	48 b8 24 41 80 00 00 	movabs $0x804124,%rax
  8042c2:	00 00 00 
  8042c5:	ff d0                	callq  *%rax
  8042c7:	85 c0                	test   %eax,%eax
  8042c9:	74 07                	je     8042d2 <devpipe_read+0x77>
  8042cb:	b8 00 00 00 00       	mov    $0x0,%eax
  8042d0:	eb 6d                	jmp    80433f <devpipe_read+0xe4>
  8042d2:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8042d9:	00 00 00 
  8042dc:	ff d0                	callq  *%rax
  8042de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042e2:	8b 10                	mov    (%rax),%edx
  8042e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042e8:	8b 40 04             	mov    0x4(%rax),%eax
  8042eb:	39 c2                	cmp    %eax,%edx
  8042ed:	74 ae                	je     80429d <devpipe_read+0x42>
  8042ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042f3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8042f7:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8042fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042ff:	8b 00                	mov    (%rax),%eax
  804301:	99                   	cltd   
  804302:	c1 ea 1b             	shr    $0x1b,%edx
  804305:	01 d0                	add    %edx,%eax
  804307:	83 e0 1f             	and    $0x1f,%eax
  80430a:	29 d0                	sub    %edx,%eax
  80430c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804310:	48 98                	cltq   
  804312:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  804317:	88 01                	mov    %al,(%rcx)
  804319:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80431d:	8b 00                	mov    (%rax),%eax
  80431f:	8d 50 01             	lea    0x1(%rax),%edx
  804322:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804326:	89 10                	mov    %edx,(%rax)
  804328:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80432d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804331:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804335:	0f 82 60 ff ff ff    	jb     80429b <devpipe_read+0x40>
  80433b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80433f:	c9                   	leaveq 
  804340:	c3                   	retq   

0000000000804341 <devpipe_write>:
  804341:	55                   	push   %rbp
  804342:	48 89 e5             	mov    %rsp,%rbp
  804345:	48 83 ec 40          	sub    $0x40,%rsp
  804349:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80434d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804351:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804355:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804359:	48 89 c7             	mov    %rax,%rdi
  80435c:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  804363:	00 00 00 
  804366:	ff d0                	callq  *%rax
  804368:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80436c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804370:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804374:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80437b:	00 
  80437c:	e9 8e 00 00 00       	jmpq   80440f <devpipe_write+0xce>
  804381:	eb 31                	jmp    8043b4 <devpipe_write+0x73>
  804383:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804387:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80438b:	48 89 d6             	mov    %rdx,%rsi
  80438e:	48 89 c7             	mov    %rax,%rdi
  804391:	48 b8 24 41 80 00 00 	movabs $0x804124,%rax
  804398:	00 00 00 
  80439b:	ff d0                	callq  *%rax
  80439d:	85 c0                	test   %eax,%eax
  80439f:	74 07                	je     8043a8 <devpipe_write+0x67>
  8043a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8043a6:	eb 79                	jmp    804421 <devpipe_write+0xe0>
  8043a8:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8043af:	00 00 00 
  8043b2:	ff d0                	callq  *%rax
  8043b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043b8:	8b 40 04             	mov    0x4(%rax),%eax
  8043bb:	48 63 d0             	movslq %eax,%rdx
  8043be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043c2:	8b 00                	mov    (%rax),%eax
  8043c4:	48 98                	cltq   
  8043c6:	48 83 c0 20          	add    $0x20,%rax
  8043ca:	48 39 c2             	cmp    %rax,%rdx
  8043cd:	73 b4                	jae    804383 <devpipe_write+0x42>
  8043cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043d3:	8b 40 04             	mov    0x4(%rax),%eax
  8043d6:	99                   	cltd   
  8043d7:	c1 ea 1b             	shr    $0x1b,%edx
  8043da:	01 d0                	add    %edx,%eax
  8043dc:	83 e0 1f             	and    $0x1f,%eax
  8043df:	29 d0                	sub    %edx,%eax
  8043e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8043e5:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8043e9:	48 01 ca             	add    %rcx,%rdx
  8043ec:	0f b6 0a             	movzbl (%rdx),%ecx
  8043ef:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8043f3:	48 98                	cltq   
  8043f5:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8043f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043fd:	8b 40 04             	mov    0x4(%rax),%eax
  804400:	8d 50 01             	lea    0x1(%rax),%edx
  804403:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804407:	89 50 04             	mov    %edx,0x4(%rax)
  80440a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80440f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804413:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804417:	0f 82 64 ff ff ff    	jb     804381 <devpipe_write+0x40>
  80441d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804421:	c9                   	leaveq 
  804422:	c3                   	retq   

0000000000804423 <devpipe_stat>:
  804423:	55                   	push   %rbp
  804424:	48 89 e5             	mov    %rsp,%rbp
  804427:	48 83 ec 20          	sub    $0x20,%rsp
  80442b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80442f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804433:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804437:	48 89 c7             	mov    %rax,%rdi
  80443a:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  804441:	00 00 00 
  804444:	ff d0                	callq  *%rax
  804446:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80444a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80444e:	48 be 4e 55 80 00 00 	movabs $0x80554e,%rsi
  804455:	00 00 00 
  804458:	48 89 c7             	mov    %rax,%rdi
  80445b:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  804462:	00 00 00 
  804465:	ff d0                	callq  *%rax
  804467:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80446b:	8b 50 04             	mov    0x4(%rax),%edx
  80446e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804472:	8b 00                	mov    (%rax),%eax
  804474:	29 c2                	sub    %eax,%edx
  804476:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80447a:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804480:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804484:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80448b:	00 00 00 
  80448e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804492:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804499:	00 00 00 
  80449c:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  8044a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8044a8:	c9                   	leaveq 
  8044a9:	c3                   	retq   

00000000008044aa <devpipe_close>:
  8044aa:	55                   	push   %rbp
  8044ab:	48 89 e5             	mov    %rsp,%rbp
  8044ae:	48 83 ec 10          	sub    $0x10,%rsp
  8044b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8044b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044ba:	48 89 c6             	mov    %rax,%rsi
  8044bd:	bf 00 00 00 00       	mov    $0x0,%edi
  8044c2:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8044c9:	00 00 00 
  8044cc:	ff d0                	callq  *%rax
  8044ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044d2:	48 89 c7             	mov    %rax,%rdi
  8044d5:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  8044dc:	00 00 00 
  8044df:	ff d0                	callq  *%rax
  8044e1:	48 89 c6             	mov    %rax,%rsi
  8044e4:	bf 00 00 00 00       	mov    $0x0,%edi
  8044e9:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8044f0:	00 00 00 
  8044f3:	ff d0                	callq  *%rax
  8044f5:	c9                   	leaveq 
  8044f6:	c3                   	retq   

00000000008044f7 <wait>:
  8044f7:	55                   	push   %rbp
  8044f8:	48 89 e5             	mov    %rsp,%rbp
  8044fb:	48 83 ec 20          	sub    $0x20,%rsp
  8044ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804502:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804506:	75 35                	jne    80453d <wait+0x46>
  804508:	48 b9 55 55 80 00 00 	movabs $0x805555,%rcx
  80450f:	00 00 00 
  804512:	48 ba 60 55 80 00 00 	movabs $0x805560,%rdx
  804519:	00 00 00 
  80451c:	be 0a 00 00 00       	mov    $0xa,%esi
  804521:	48 bf 75 55 80 00 00 	movabs $0x805575,%rdi
  804528:	00 00 00 
  80452b:	b8 00 00 00 00       	mov    $0x0,%eax
  804530:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  804537:	00 00 00 
  80453a:	41 ff d0             	callq  *%r8
  80453d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804540:	25 ff 03 00 00       	and    $0x3ff,%eax
  804545:	48 98                	cltq   
  804547:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80454e:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804555:	00 00 00 
  804558:	48 01 d0             	add    %rdx,%rax
  80455b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80455f:	eb 0c                	jmp    80456d <wait+0x76>
  804561:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  804568:	00 00 00 
  80456b:	ff d0                	callq  *%rax
  80456d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804571:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804577:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80457a:	75 0e                	jne    80458a <wait+0x93>
  80457c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804580:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  804586:	85 c0                	test   %eax,%eax
  804588:	75 d7                	jne    804561 <wait+0x6a>
  80458a:	c9                   	leaveq 
  80458b:	c3                   	retq   

000000000080458c <cputchar>:
  80458c:	55                   	push   %rbp
  80458d:	48 89 e5             	mov    %rsp,%rbp
  804590:	48 83 ec 20          	sub    $0x20,%rsp
  804594:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804597:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80459a:	88 45 ff             	mov    %al,-0x1(%rbp)
  80459d:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8045a1:	be 01 00 00 00       	mov    $0x1,%esi
  8045a6:	48 89 c7             	mov    %rax,%rdi
  8045a9:	48 b8 ba 1b 80 00 00 	movabs $0x801bba,%rax
  8045b0:	00 00 00 
  8045b3:	ff d0                	callq  *%rax
  8045b5:	c9                   	leaveq 
  8045b6:	c3                   	retq   

00000000008045b7 <getchar>:
  8045b7:	55                   	push   %rbp
  8045b8:	48 89 e5             	mov    %rsp,%rbp
  8045bb:	48 83 ec 10          	sub    $0x10,%rsp
  8045bf:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8045c3:	ba 01 00 00 00       	mov    $0x1,%edx
  8045c8:	48 89 c6             	mov    %rax,%rsi
  8045cb:	bf 00 00 00 00       	mov    $0x0,%edi
  8045d0:	48 b8 0f 2c 80 00 00 	movabs $0x802c0f,%rax
  8045d7:	00 00 00 
  8045da:	ff d0                	callq  *%rax
  8045dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8045df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8045e3:	79 05                	jns    8045ea <getchar+0x33>
  8045e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045e8:	eb 14                	jmp    8045fe <getchar+0x47>
  8045ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8045ee:	7f 07                	jg     8045f7 <getchar+0x40>
  8045f0:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  8045f5:	eb 07                	jmp    8045fe <getchar+0x47>
  8045f7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8045fb:	0f b6 c0             	movzbl %al,%eax
  8045fe:	c9                   	leaveq 
  8045ff:	c3                   	retq   

0000000000804600 <iscons>:
  804600:	55                   	push   %rbp
  804601:	48 89 e5             	mov    %rsp,%rbp
  804604:	48 83 ec 20          	sub    $0x20,%rsp
  804608:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80460b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80460f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804612:	48 89 d6             	mov    %rdx,%rsi
  804615:	89 c7                	mov    %eax,%edi
  804617:	48 b8 dd 27 80 00 00 	movabs $0x8027dd,%rax
  80461e:	00 00 00 
  804621:	ff d0                	callq  *%rax
  804623:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804626:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80462a:	79 05                	jns    804631 <iscons+0x31>
  80462c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80462f:	eb 1a                	jmp    80464b <iscons+0x4b>
  804631:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804635:	8b 10                	mov    (%rax),%edx
  804637:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  80463e:	00 00 00 
  804641:	8b 00                	mov    (%rax),%eax
  804643:	39 c2                	cmp    %eax,%edx
  804645:	0f 94 c0             	sete   %al
  804648:	0f b6 c0             	movzbl %al,%eax
  80464b:	c9                   	leaveq 
  80464c:	c3                   	retq   

000000000080464d <opencons>:
  80464d:	55                   	push   %rbp
  80464e:	48 89 e5             	mov    %rsp,%rbp
  804651:	48 83 ec 10          	sub    $0x10,%rsp
  804655:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804659:	48 89 c7             	mov    %rax,%rdi
  80465c:	48 b8 45 27 80 00 00 	movabs $0x802745,%rax
  804663:	00 00 00 
  804666:	ff d0                	callq  *%rax
  804668:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80466b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80466f:	79 05                	jns    804676 <opencons+0x29>
  804671:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804674:	eb 5b                	jmp    8046d1 <opencons+0x84>
  804676:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80467a:	ba 07 04 00 00       	mov    $0x407,%edx
  80467f:	48 89 c6             	mov    %rax,%rsi
  804682:	bf 00 00 00 00       	mov    $0x0,%edi
  804687:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  80468e:	00 00 00 
  804691:	ff d0                	callq  *%rax
  804693:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804696:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80469a:	79 05                	jns    8046a1 <opencons+0x54>
  80469c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80469f:	eb 30                	jmp    8046d1 <opencons+0x84>
  8046a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046a5:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8046ac:	00 00 00 
  8046af:	8b 12                	mov    (%rdx),%edx
  8046b1:	89 10                	mov    %edx,(%rax)
  8046b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046b7:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8046be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046c2:	48 89 c7             	mov    %rax,%rdi
  8046c5:	48 b8 f7 26 80 00 00 	movabs $0x8026f7,%rax
  8046cc:	00 00 00 
  8046cf:	ff d0                	callq  *%rax
  8046d1:	c9                   	leaveq 
  8046d2:	c3                   	retq   

00000000008046d3 <devcons_read>:
  8046d3:	55                   	push   %rbp
  8046d4:	48 89 e5             	mov    %rsp,%rbp
  8046d7:	48 83 ec 30          	sub    $0x30,%rsp
  8046db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8046df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8046e3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8046e7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8046ec:	75 07                	jne    8046f5 <devcons_read+0x22>
  8046ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8046f3:	eb 4b                	jmp    804740 <devcons_read+0x6d>
  8046f5:	eb 0c                	jmp    804703 <devcons_read+0x30>
  8046f7:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8046fe:	00 00 00 
  804701:	ff d0                	callq  *%rax
  804703:	48 b8 04 1c 80 00 00 	movabs $0x801c04,%rax
  80470a:	00 00 00 
  80470d:	ff d0                	callq  *%rax
  80470f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804712:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804716:	74 df                	je     8046f7 <devcons_read+0x24>
  804718:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80471c:	79 05                	jns    804723 <devcons_read+0x50>
  80471e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804721:	eb 1d                	jmp    804740 <devcons_read+0x6d>
  804723:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804727:	75 07                	jne    804730 <devcons_read+0x5d>
  804729:	b8 00 00 00 00       	mov    $0x0,%eax
  80472e:	eb 10                	jmp    804740 <devcons_read+0x6d>
  804730:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804733:	89 c2                	mov    %eax,%edx
  804735:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804739:	88 10                	mov    %dl,(%rax)
  80473b:	b8 01 00 00 00       	mov    $0x1,%eax
  804740:	c9                   	leaveq 
  804741:	c3                   	retq   

0000000000804742 <devcons_write>:
  804742:	55                   	push   %rbp
  804743:	48 89 e5             	mov    %rsp,%rbp
  804746:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80474d:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804754:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80475b:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  804762:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804769:	eb 76                	jmp    8047e1 <devcons_write+0x9f>
  80476b:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  804772:	89 c2                	mov    %eax,%edx
  804774:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804777:	29 c2                	sub    %eax,%edx
  804779:	89 d0                	mov    %edx,%eax
  80477b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80477e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804781:	83 f8 7f             	cmp    $0x7f,%eax
  804784:	76 07                	jbe    80478d <devcons_write+0x4b>
  804786:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  80478d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804790:	48 63 d0             	movslq %eax,%rdx
  804793:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804796:	48 63 c8             	movslq %eax,%rcx
  804799:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8047a0:	48 01 c1             	add    %rax,%rcx
  8047a3:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8047aa:	48 89 ce             	mov    %rcx,%rsi
  8047ad:	48 89 c7             	mov    %rax,%rdi
  8047b0:	48 b8 f7 16 80 00 00 	movabs $0x8016f7,%rax
  8047b7:	00 00 00 
  8047ba:	ff d0                	callq  *%rax
  8047bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047bf:	48 63 d0             	movslq %eax,%rdx
  8047c2:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8047c9:	48 89 d6             	mov    %rdx,%rsi
  8047cc:	48 89 c7             	mov    %rax,%rdi
  8047cf:	48 b8 ba 1b 80 00 00 	movabs $0x801bba,%rax
  8047d6:	00 00 00 
  8047d9:	ff d0                	callq  *%rax
  8047db:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047de:	01 45 fc             	add    %eax,-0x4(%rbp)
  8047e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047e4:	48 98                	cltq   
  8047e6:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  8047ed:	0f 82 78 ff ff ff    	jb     80476b <devcons_write+0x29>
  8047f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047f6:	c9                   	leaveq 
  8047f7:	c3                   	retq   

00000000008047f8 <devcons_close>:
  8047f8:	55                   	push   %rbp
  8047f9:	48 89 e5             	mov    %rsp,%rbp
  8047fc:	48 83 ec 08          	sub    $0x8,%rsp
  804800:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804804:	b8 00 00 00 00       	mov    $0x0,%eax
  804809:	c9                   	leaveq 
  80480a:	c3                   	retq   

000000000080480b <devcons_stat>:
  80480b:	55                   	push   %rbp
  80480c:	48 89 e5             	mov    %rsp,%rbp
  80480f:	48 83 ec 10          	sub    $0x10,%rsp
  804813:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804817:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80481b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80481f:	48 be 88 55 80 00 00 	movabs $0x805588,%rsi
  804826:	00 00 00 
  804829:	48 89 c7             	mov    %rax,%rdi
  80482c:	48 b8 d3 13 80 00 00 	movabs $0x8013d3,%rax
  804833:	00 00 00 
  804836:	ff d0                	callq  *%rax
  804838:	b8 00 00 00 00       	mov    $0x0,%eax
  80483d:	c9                   	leaveq 
  80483e:	c3                   	retq   

000000000080483f <set_pgfault_handler>:
  80483f:	55                   	push   %rbp
  804840:	48 89 e5             	mov    %rsp,%rbp
  804843:	48 83 ec 20          	sub    $0x20,%rsp
  804847:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80484b:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804852:	00 00 00 
  804855:	48 8b 00             	mov    (%rax),%rax
  804858:	48 85 c0             	test   %rax,%rax
  80485b:	75 6f                	jne    8048cc <set_pgfault_handler+0x8d>
  80485d:	ba 07 00 00 00       	mov    $0x7,%edx
  804862:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  804867:	bf 00 00 00 00       	mov    $0x0,%edi
  80486c:	48 b8 02 1d 80 00 00 	movabs $0x801d02,%rax
  804873:	00 00 00 
  804876:	ff d0                	callq  *%rax
  804878:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80487b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80487f:	79 30                	jns    8048b1 <set_pgfault_handler+0x72>
  804881:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804884:	89 c1                	mov    %eax,%ecx
  804886:	48 ba 90 55 80 00 00 	movabs $0x805590,%rdx
  80488d:	00 00 00 
  804890:	be 22 00 00 00       	mov    $0x22,%esi
  804895:	48 bf af 55 80 00 00 	movabs $0x8055af,%rdi
  80489c:	00 00 00 
  80489f:	b8 00 00 00 00       	mov    $0x0,%eax
  8048a4:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  8048ab:	00 00 00 
  8048ae:	41 ff d0             	callq  *%r8
  8048b1:	48 be df 48 80 00 00 	movabs $0x8048df,%rsi
  8048b8:	00 00 00 
  8048bb:	bf 00 00 00 00       	mov    $0x0,%edi
  8048c0:	48 b8 8c 1e 80 00 00 	movabs $0x801e8c,%rax
  8048c7:	00 00 00 
  8048ca:	ff d0                	callq  *%rax
  8048cc:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8048d3:	00 00 00 
  8048d6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8048da:	48 89 10             	mov    %rdx,(%rax)
  8048dd:	c9                   	leaveq 
  8048de:	c3                   	retq   

00000000008048df <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  8048df:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  8048e2:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  8048e9:	00 00 00 
call *%rax
  8048ec:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  8048ee:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  8048f5:	00 08 
    movq 152(%rsp), %rax
  8048f7:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  8048fe:	00 
    movq 136(%rsp), %rbx
  8048ff:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804906:	00 
movq %rbx, (%rax)
  804907:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  80490a:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80490e:	4c 8b 3c 24          	mov    (%rsp),%r15
  804912:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804917:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  80491c:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804921:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804926:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  80492b:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  804930:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804935:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  80493a:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  80493f:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804944:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804949:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  80494e:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  804953:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  804958:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  80495c:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  804960:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  804961:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  804966:	c3                   	retq   

0000000000804967 <ipc_recv>:
  804967:	55                   	push   %rbp
  804968:	48 89 e5             	mov    %rsp,%rbp
  80496b:	48 83 ec 30          	sub    $0x30,%rsp
  80496f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804973:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804977:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80497b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804980:	75 0e                	jne    804990 <ipc_recv+0x29>
  804982:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804989:	00 00 00 
  80498c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804990:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804994:	48 89 c7             	mov    %rax,%rdi
  804997:	48 b8 2b 1f 80 00 00 	movabs $0x801f2b,%rax
  80499e:	00 00 00 
  8049a1:	ff d0                	callq  *%rax
  8049a3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8049a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8049aa:	79 27                	jns    8049d3 <ipc_recv+0x6c>
  8049ac:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8049b1:	74 0a                	je     8049bd <ipc_recv+0x56>
  8049b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049b7:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8049bd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8049c2:	74 0a                	je     8049ce <ipc_recv+0x67>
  8049c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049c8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8049ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049d1:	eb 53                	jmp    804a26 <ipc_recv+0xbf>
  8049d3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8049d8:	74 19                	je     8049f3 <ipc_recv+0x8c>
  8049da:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8049e1:	00 00 00 
  8049e4:	48 8b 00             	mov    (%rax),%rax
  8049e7:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8049ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049f1:	89 10                	mov    %edx,(%rax)
  8049f3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8049f8:	74 19                	je     804a13 <ipc_recv+0xac>
  8049fa:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804a01:	00 00 00 
  804a04:	48 8b 00             	mov    (%rax),%rax
  804a07:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804a0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804a11:	89 10                	mov    %edx,(%rax)
  804a13:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804a1a:	00 00 00 
  804a1d:	48 8b 00             	mov    (%rax),%rax
  804a20:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804a26:	c9                   	leaveq 
  804a27:	c3                   	retq   

0000000000804a28 <ipc_send>:
  804a28:	55                   	push   %rbp
  804a29:	48 89 e5             	mov    %rsp,%rbp
  804a2c:	48 83 ec 30          	sub    $0x30,%rsp
  804a30:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804a33:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804a36:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804a3a:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804a3d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804a42:	75 10                	jne    804a54 <ipc_send+0x2c>
  804a44:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804a4b:	00 00 00 
  804a4e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804a52:	eb 0e                	jmp    804a62 <ipc_send+0x3a>
  804a54:	eb 0c                	jmp    804a62 <ipc_send+0x3a>
  804a56:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  804a5d:	00 00 00 
  804a60:	ff d0                	callq  *%rax
  804a62:	8b 75 e8             	mov    -0x18(%rbp),%esi
  804a65:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  804a68:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804a6c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804a6f:	89 c7                	mov    %eax,%edi
  804a71:	48 b8 d6 1e 80 00 00 	movabs $0x801ed6,%rax
  804a78:	00 00 00 
  804a7b:	ff d0                	callq  *%rax
  804a7d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804a80:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804a84:	74 d0                	je     804a56 <ipc_send+0x2e>
  804a86:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804a8a:	79 30                	jns    804abc <ipc_send+0x94>
  804a8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a8f:	89 c1                	mov    %eax,%ecx
  804a91:	48 ba c0 55 80 00 00 	movabs $0x8055c0,%rdx
  804a98:	00 00 00 
  804a9b:	be 44 00 00 00       	mov    $0x44,%esi
  804aa0:	48 bf d6 55 80 00 00 	movabs $0x8055d6,%rdi
  804aa7:	00 00 00 
  804aaa:	b8 00 00 00 00       	mov    $0x0,%eax
  804aaf:	49 b8 e5 05 80 00 00 	movabs $0x8005e5,%r8
  804ab6:	00 00 00 
  804ab9:	41 ff d0             	callq  *%r8
  804abc:	c9                   	leaveq 
  804abd:	c3                   	retq   

0000000000804abe <ipc_host_recv>:
  804abe:	55                   	push   %rbp
  804abf:	48 89 e5             	mov    %rsp,%rbp
  804ac2:	48 83 ec 10          	sub    $0x10,%rsp
  804ac6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804aca:	48 ba e8 55 80 00 00 	movabs $0x8055e8,%rdx
  804ad1:	00 00 00 
  804ad4:	be 4e 00 00 00       	mov    $0x4e,%esi
  804ad9:	48 bf d6 55 80 00 00 	movabs $0x8055d6,%rdi
  804ae0:	00 00 00 
  804ae3:	b8 00 00 00 00       	mov    $0x0,%eax
  804ae8:	48 b9 e5 05 80 00 00 	movabs $0x8005e5,%rcx
  804aef:	00 00 00 
  804af2:	ff d1                	callq  *%rcx

0000000000804af4 <ipc_host_send>:
  804af4:	55                   	push   %rbp
  804af5:	48 89 e5             	mov    %rsp,%rbp
  804af8:	48 83 ec 20          	sub    $0x20,%rsp
  804afc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804aff:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804b02:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804b06:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804b09:	48 ba 08 56 80 00 00 	movabs $0x805608,%rdx
  804b10:	00 00 00 
  804b13:	be 67 00 00 00       	mov    $0x67,%esi
  804b18:	48 bf d6 55 80 00 00 	movabs $0x8055d6,%rdi
  804b1f:	00 00 00 
  804b22:	b8 00 00 00 00       	mov    $0x0,%eax
  804b27:	48 b9 e5 05 80 00 00 	movabs $0x8005e5,%rcx
  804b2e:	00 00 00 
  804b31:	ff d1                	callq  *%rcx

0000000000804b33 <ipc_find_env>:
  804b33:	55                   	push   %rbp
  804b34:	48 89 e5             	mov    %rsp,%rbp
  804b37:	48 83 ec 14          	sub    $0x14,%rsp
  804b3b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804b3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804b45:	eb 4e                	jmp    804b95 <ipc_find_env+0x62>
  804b47:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804b4e:	00 00 00 
  804b51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804b54:	48 98                	cltq   
  804b56:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804b5d:	48 01 d0             	add    %rdx,%rax
  804b60:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804b66:	8b 00                	mov    (%rax),%eax
  804b68:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804b6b:	75 24                	jne    804b91 <ipc_find_env+0x5e>
  804b6d:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804b74:	00 00 00 
  804b77:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804b7a:	48 98                	cltq   
  804b7c:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804b83:	48 01 d0             	add    %rdx,%rax
  804b86:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804b8c:	8b 40 08             	mov    0x8(%rax),%eax
  804b8f:	eb 12                	jmp    804ba3 <ipc_find_env+0x70>
  804b91:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804b95:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804b9c:	7e a9                	jle    804b47 <ipc_find_env+0x14>
  804b9e:	b8 00 00 00 00       	mov    $0x0,%eax
  804ba3:	c9                   	leaveq 
  804ba4:	c3                   	retq   

0000000000804ba5 <pageref>:
  804ba5:	55                   	push   %rbp
  804ba6:	48 89 e5             	mov    %rsp,%rbp
  804ba9:	48 83 ec 18          	sub    $0x18,%rsp
  804bad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804bb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804bb5:	48 c1 e8 15          	shr    $0x15,%rax
  804bb9:	48 89 c2             	mov    %rax,%rdx
  804bbc:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804bc3:	01 00 00 
  804bc6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804bca:	83 e0 01             	and    $0x1,%eax
  804bcd:	48 85 c0             	test   %rax,%rax
  804bd0:	75 07                	jne    804bd9 <pageref+0x34>
  804bd2:	b8 00 00 00 00       	mov    $0x0,%eax
  804bd7:	eb 53                	jmp    804c2c <pageref+0x87>
  804bd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804bdd:	48 c1 e8 0c          	shr    $0xc,%rax
  804be1:	48 89 c2             	mov    %rax,%rdx
  804be4:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804beb:	01 00 00 
  804bee:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804bf2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804bf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804bfa:	83 e0 01             	and    $0x1,%eax
  804bfd:	48 85 c0             	test   %rax,%rax
  804c00:	75 07                	jne    804c09 <pageref+0x64>
  804c02:	b8 00 00 00 00       	mov    $0x0,%eax
  804c07:	eb 23                	jmp    804c2c <pageref+0x87>
  804c09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804c0d:	48 c1 e8 0c          	shr    $0xc,%rax
  804c11:	48 89 c2             	mov    %rax,%rdx
  804c14:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804c1b:	00 00 00 
  804c1e:	48 c1 e2 04          	shl    $0x4,%rdx
  804c22:	48 01 d0             	add    %rdx,%rax
  804c25:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804c29:	0f b7 c0             	movzwl %ax,%eax
  804c2c:	c9                   	leaveq 
  804c2d:	c3                   	retq   
