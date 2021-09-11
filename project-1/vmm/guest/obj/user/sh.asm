
vmm/guest/obj/user/sh:     file format elf64-x86-64


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
  80003c:	e8 26 12 00 00       	callq  801267 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <runcmd>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 81 ec 60 05 00 00 	sub    $0x560,%rsp
  80004e:	48 89 bd a8 fa ff ff 	mov    %rdi,-0x558(%rbp)
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  80005c:	48 8b 85 a8 fa ff ff 	mov    -0x558(%rbp),%rax
  800063:	be 00 00 00 00       	mov    $0x0,%esi
  800068:	48 89 c7             	mov    %rax,%rdi
  80006b:	48 b8 5b 0a 80 00 00 	movabs $0x800a5b,%rax
  800072:	00 00 00 
  800075:	ff d0                	callq  *%rax
  800077:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80007e:	48 8d 85 58 ff ff ff 	lea    -0xa8(%rbp),%rax
  800085:	48 89 c6             	mov    %rax,%rsi
  800088:	bf 00 00 00 00       	mov    $0x0,%edi
  80008d:	48 b8 5b 0a 80 00 00 	movabs $0x800a5b,%rax
  800094:	00 00 00 
  800097:	ff d0                	callq  *%rax
  800099:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80009c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80009f:	83 f8 3e             	cmp    $0x3e,%eax
  8000a2:	0f 84 4c 01 00 00    	je     8001f4 <runcmd+0x1b1>
  8000a8:	83 f8 3e             	cmp    $0x3e,%eax
  8000ab:	7f 12                	jg     8000bf <runcmd+0x7c>
  8000ad:	85 c0                	test   %eax,%eax
  8000af:	0f 84 b9 03 00 00    	je     80046e <runcmd+0x42b>
  8000b5:	83 f8 3c             	cmp    $0x3c,%eax
  8000b8:	74 64                	je     80011e <runcmd+0xdb>
  8000ba:	e9 7a 03 00 00       	jmpq   800439 <runcmd+0x3f6>
  8000bf:	83 f8 77             	cmp    $0x77,%eax
  8000c2:	74 0e                	je     8000d2 <runcmd+0x8f>
  8000c4:	83 f8 7c             	cmp    $0x7c,%eax
  8000c7:	0f 84 fd 01 00 00    	je     8002ca <runcmd+0x287>
  8000cd:	e9 67 03 00 00       	jmpq   800439 <runcmd+0x3f6>
  8000d2:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
  8000d6:	75 27                	jne    8000ff <runcmd+0xbc>
  8000d8:	48 bf 68 69 80 00 00 	movabs $0x806968,%rdi
  8000df:	00 00 00 
  8000e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e7:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  8000ee:	00 00 00 
  8000f1:	ff d2                	callq  *%rdx
  8000f3:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  8000fa:	00 00 00 
  8000fd:	ff d0                	callq  *%rax
  8000ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800102:	8d 50 01             	lea    0x1(%rax),%edx
  800105:	89 55 fc             	mov    %edx,-0x4(%rbp)
  800108:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
  80010f:	48 98                	cltq   
  800111:	48 89 94 c5 60 ff ff 	mov    %rdx,-0xa0(%rbp,%rax,8)
  800118:	ff 
  800119:	e9 4b 03 00 00       	jmpq   800469 <runcmd+0x426>
  80011e:	48 8d 85 58 ff ff ff 	lea    -0xa8(%rbp),%rax
  800125:	48 89 c6             	mov    %rax,%rsi
  800128:	bf 00 00 00 00       	mov    $0x0,%edi
  80012d:	48 b8 5b 0a 80 00 00 	movabs $0x800a5b,%rax
  800134:	00 00 00 
  800137:	ff d0                	callq  *%rax
  800139:	83 f8 77             	cmp    $0x77,%eax
  80013c:	74 27                	je     800165 <runcmd+0x122>
  80013e:	48 bf 80 69 80 00 00 	movabs $0x806980,%rdi
  800145:	00 00 00 
  800148:	b8 00 00 00 00       	mov    $0x0,%eax
  80014d:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800154:	00 00 00 
  800157:	ff d2                	callq  *%rdx
  800159:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800160:	00 00 00 
  800163:	ff d0                	callq  *%rax
  800165:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80016c:	be 00 00 00 00       	mov    $0x0,%esi
  800171:	48 89 c7             	mov    %rax,%rdi
  800174:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  80017b:	00 00 00 
  80017e:	ff d0                	callq  *%rax
  800180:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800183:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800187:	79 34                	jns    8001bd <runcmd+0x17a>
  800189:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  800190:	8b 55 ec             	mov    -0x14(%rbp),%edx
  800193:	48 89 c6             	mov    %rax,%rsi
  800196:	48 bf a6 69 80 00 00 	movabs $0x8069a6,%rdi
  80019d:	00 00 00 
  8001a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8001a5:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  8001ac:	00 00 00 
  8001af:	ff d1                	callq  *%rcx
  8001b1:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  8001b8:	00 00 00 
  8001bb:	ff d0                	callq  *%rax
  8001bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8001c1:	74 2c                	je     8001ef <runcmd+0x1ac>
  8001c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001c6:	be 00 00 00 00       	mov    $0x0,%esi
  8001cb:	89 c7                	mov    %eax,%edi
  8001cd:	48 b8 cd 3b 80 00 00 	movabs $0x803bcd,%rax
  8001d4:	00 00 00 
  8001d7:	ff d0                	callq  *%rax
  8001d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001dc:	89 c7                	mov    %eax,%edi
  8001de:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8001e5:	00 00 00 
  8001e8:	ff d0                	callq  *%rax
  8001ea:	e9 7a 02 00 00       	jmpq   800469 <runcmd+0x426>
  8001ef:	e9 75 02 00 00       	jmpq   800469 <runcmd+0x426>
  8001f4:	48 8d 85 58 ff ff ff 	lea    -0xa8(%rbp),%rax
  8001fb:	48 89 c6             	mov    %rax,%rsi
  8001fe:	bf 00 00 00 00       	mov    $0x0,%edi
  800203:	48 b8 5b 0a 80 00 00 	movabs $0x800a5b,%rax
  80020a:	00 00 00 
  80020d:	ff d0                	callq  *%rax
  80020f:	83 f8 77             	cmp    $0x77,%eax
  800212:	74 27                	je     80023b <runcmd+0x1f8>
  800214:	48 bf c0 69 80 00 00 	movabs $0x8069c0,%rdi
  80021b:	00 00 00 
  80021e:	b8 00 00 00 00       	mov    $0x0,%eax
  800223:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80022a:	00 00 00 
  80022d:	ff d2                	callq  *%rdx
  80022f:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800236:	00 00 00 
  800239:	ff d0                	callq  *%rax
  80023b:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  800242:	be 01 03 00 00       	mov    $0x301,%esi
  800247:	48 89 c7             	mov    %rax,%rdi
  80024a:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  800251:	00 00 00 
  800254:	ff d0                	callq  *%rax
  800256:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800259:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80025d:	79 34                	jns    800293 <runcmd+0x250>
  80025f:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  800266:	8b 55 ec             	mov    -0x14(%rbp),%edx
  800269:	48 89 c6             	mov    %rax,%rsi
  80026c:	48 bf e6 69 80 00 00 	movabs $0x8069e6,%rdi
  800273:	00 00 00 
  800276:	b8 00 00 00 00       	mov    $0x0,%eax
  80027b:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  800282:	00 00 00 
  800285:	ff d1                	callq  *%rcx
  800287:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  80028e:	00 00 00 
  800291:	ff d0                	callq  *%rax
  800293:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  800297:	74 2c                	je     8002c5 <runcmd+0x282>
  800299:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80029c:	be 01 00 00 00       	mov    $0x1,%esi
  8002a1:	89 c7                	mov    %eax,%edi
  8002a3:	48 b8 cd 3b 80 00 00 	movabs $0x803bcd,%rax
  8002aa:	00 00 00 
  8002ad:	ff d0                	callq  *%rax
  8002af:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8002b2:	89 c7                	mov    %eax,%edi
  8002b4:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8002bb:	00 00 00 
  8002be:	ff d0                	callq  *%rax
  8002c0:	e9 a4 01 00 00       	jmpq   800469 <runcmd+0x426>
  8002c5:	e9 9f 01 00 00       	jmpq   800469 <runcmd+0x426>
  8002ca:	48 8d 85 40 fb ff ff 	lea    -0x4c0(%rbp),%rax
  8002d1:	48 89 c7             	mov    %rax,%rdi
  8002d4:	48 b8 03 5f 80 00 00 	movabs $0x805f03,%rax
  8002db:	00 00 00 
  8002de:	ff d0                	callq  *%rax
  8002e0:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8002e3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8002e7:	79 2c                	jns    800315 <runcmd+0x2d2>
  8002e9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8002ec:	89 c6                	mov    %eax,%esi
  8002ee:	48 bf fc 69 80 00 00 	movabs $0x8069fc,%rdi
  8002f5:	00 00 00 
  8002f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8002fd:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800304:	00 00 00 
  800307:	ff d2                	callq  *%rdx
  800309:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800310:	00 00 00 
  800313:	ff d0                	callq  *%rax
  800315:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80031c:	00 00 00 
  80031f:	8b 00                	mov    (%rax),%eax
  800321:	85 c0                	test   %eax,%eax
  800323:	74 29                	je     80034e <runcmd+0x30b>
  800325:	8b 95 44 fb ff ff    	mov    -0x4bc(%rbp),%edx
  80032b:	8b 85 40 fb ff ff    	mov    -0x4c0(%rbp),%eax
  800331:	89 c6                	mov    %eax,%esi
  800333:	48 bf 05 6a 80 00 00 	movabs $0x806a05,%rdi
  80033a:	00 00 00 
  80033d:	b8 00 00 00 00       	mov    $0x0,%eax
  800342:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  800349:	00 00 00 
  80034c:	ff d1                	callq  *%rcx
  80034e:	48 b8 04 33 80 00 00 	movabs $0x803304,%rax
  800355:	00 00 00 
  800358:	ff d0                	callq  *%rax
  80035a:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80035d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800361:	79 2c                	jns    80038f <runcmd+0x34c>
  800363:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800366:	89 c6                	mov    %eax,%esi
  800368:	48 bf 12 6a 80 00 00 	movabs $0x806a12,%rdi
  80036f:	00 00 00 
  800372:	b8 00 00 00 00       	mov    $0x0,%eax
  800377:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80037e:	00 00 00 
  800381:	ff d2                	callq  *%rdx
  800383:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  80038a:	00 00 00 
  80038d:	ff d0                	callq  *%rax
  80038f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800393:	75 50                	jne    8003e5 <runcmd+0x3a2>
  800395:	8b 85 40 fb ff ff    	mov    -0x4c0(%rbp),%eax
  80039b:	85 c0                	test   %eax,%eax
  80039d:	74 2d                	je     8003cc <runcmd+0x389>
  80039f:	8b 85 40 fb ff ff    	mov    -0x4c0(%rbp),%eax
  8003a5:	be 00 00 00 00       	mov    $0x0,%esi
  8003aa:	89 c7                	mov    %eax,%edi
  8003ac:	48 b8 cd 3b 80 00 00 	movabs $0x803bcd,%rax
  8003b3:	00 00 00 
  8003b6:	ff d0                	callq  *%rax
  8003b8:	8b 85 40 fb ff ff    	mov    -0x4c0(%rbp),%eax
  8003be:	89 c7                	mov    %eax,%edi
  8003c0:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8003c7:	00 00 00 
  8003ca:	ff d0                	callq  *%rax
  8003cc:	8b 85 44 fb ff ff    	mov    -0x4bc(%rbp),%eax
  8003d2:	89 c7                	mov    %eax,%edi
  8003d4:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8003db:	00 00 00 
  8003de:	ff d0                	callq  *%rax
  8003e0:	e9 92 fc ff ff       	jmpq   800077 <runcmd+0x34>
  8003e5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8003e8:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8003eb:	8b 85 44 fb ff ff    	mov    -0x4bc(%rbp),%eax
  8003f1:	83 f8 01             	cmp    $0x1,%eax
  8003f4:	74 2d                	je     800423 <runcmd+0x3e0>
  8003f6:	8b 85 44 fb ff ff    	mov    -0x4bc(%rbp),%eax
  8003fc:	be 01 00 00 00       	mov    $0x1,%esi
  800401:	89 c7                	mov    %eax,%edi
  800403:	48 b8 cd 3b 80 00 00 	movabs $0x803bcd,%rax
  80040a:	00 00 00 
  80040d:	ff d0                	callq  *%rax
  80040f:	8b 85 44 fb ff ff    	mov    -0x4bc(%rbp),%eax
  800415:	89 c7                	mov    %eax,%edi
  800417:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  80041e:	00 00 00 
  800421:	ff d0                	callq  *%rax
  800423:	8b 85 40 fb ff ff    	mov    -0x4c0(%rbp),%eax
  800429:	89 c7                	mov    %eax,%edi
  80042b:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  800432:	00 00 00 
  800435:	ff d0                	callq  *%rax
  800437:	eb 36                	jmp    80046f <runcmd+0x42c>
  800439:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80043c:	89 c1                	mov    %eax,%ecx
  80043e:	48 ba 1b 6a 80 00 00 	movabs $0x806a1b,%rdx
  800445:	00 00 00 
  800448:	be ab 00 00 00       	mov    $0xab,%esi
  80044d:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800454:	00 00 00 
  800457:	b8 00 00 00 00       	mov    $0x0,%eax
  80045c:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800463:	00 00 00 
  800466:	41 ff d0             	callq  *%r8
  800469:	e9 10 fc ff ff       	jmpq   80007e <runcmd+0x3b>
  80046e:	90                   	nop
  80046f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800473:	75 34                	jne    8004a9 <runcmd+0x466>
  800475:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80047c:	00 00 00 
  80047f:	8b 00                	mov    (%rax),%eax
  800481:	85 c0                	test   %eax,%eax
  800483:	0f 84 79 03 00 00    	je     800802 <runcmd+0x7bf>
  800489:	48 bf 44 6a 80 00 00 	movabs $0x806a44,%rdi
  800490:	00 00 00 
  800493:	b8 00 00 00 00       	mov    $0x0,%eax
  800498:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80049f:	00 00 00 
  8004a2:	ff d2                	callq  *%rdx
  8004a4:	e9 59 03 00 00       	jmpq   800802 <runcmd+0x7bf>
  8004a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  8004b0:	e9 8a 00 00 00       	jmpq   80053f <runcmd+0x4fc>
  8004b5:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8004bc:	00 00 00 
  8004bf:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8004c2:	48 63 d2             	movslq %edx,%rdx
  8004c5:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8004c9:	48 8d 85 50 fb ff ff 	lea    -0x4b0(%rbp),%rax
  8004d0:	48 89 d6             	mov    %rdx,%rsi
  8004d3:	48 89 c7             	mov    %rax,%rdi
  8004d6:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  8004dd:	00 00 00 
  8004e0:	ff d0                	callq  *%rax
  8004e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  8004e9:	48 8d 85 50 fb ff ff 	lea    -0x4b0(%rbp),%rax
  8004f0:	48 89 d6             	mov    %rdx,%rsi
  8004f3:	48 89 c7             	mov    %rax,%rdi
  8004f6:	48 b8 98 22 80 00 00 	movabs $0x802298,%rax
  8004fd:	00 00 00 
  800500:	ff d0                	callq  *%rax
  800502:	48 8d 95 b0 fa ff ff 	lea    -0x550(%rbp),%rdx
  800509:	48 8d 85 50 fb ff ff 	lea    -0x4b0(%rbp),%rax
  800510:	48 89 d6             	mov    %rdx,%rsi
  800513:	48 89 c7             	mov    %rax,%rdi
  800516:	48 b8 5e 41 80 00 00 	movabs $0x80415e,%rax
  80051d:	00 00 00 
  800520:	ff d0                	callq  *%rax
  800522:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800525:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800529:	75 10                	jne    80053b <runcmd+0x4f8>
  80052b:	48 8d 85 50 fb ff ff 	lea    -0x4b0(%rbp),%rax
  800532:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
  800539:	eb 19                	jmp    800554 <runcmd+0x511>
  80053b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  80053f:	48 b8 10 90 80 00 00 	movabs $0x809010,%rax
  800546:	00 00 00 
  800549:	8b 00                	mov    (%rax),%eax
  80054b:	39 45 f8             	cmp    %eax,-0x8(%rbp)
  80054e:	0f 8c 61 ff ff ff    	jl     8004b5 <runcmd+0x472>
  800554:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  80055b:	0f b6 00             	movzbl (%rax),%eax
  80055e:	3c 2f                	cmp    $0x2f,%al
  800560:	74 39                	je     80059b <runcmd+0x558>
  800562:	c6 85 50 fb ff ff 2f 	movb   $0x2f,-0x4b0(%rbp)
  800569:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  800570:	48 8d 95 50 fb ff ff 	lea    -0x4b0(%rbp),%rdx
  800577:	48 83 c2 01          	add    $0x1,%rdx
  80057b:	48 89 c6             	mov    %rax,%rsi
  80057e:	48 89 d7             	mov    %rdx,%rdi
  800581:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  800588:	00 00 00 
  80058b:	ff d0                	callq  *%rax
  80058d:	48 8d 85 50 fb ff ff 	lea    -0x4b0(%rbp),%rax
  800594:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
  80059b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80059e:	48 98                	cltq   
  8005a0:	48 c7 84 c5 60 ff ff 	movq   $0x0,-0xa0(%rbp,%rax,8)
  8005a7:	ff 00 00 00 00 
  8005ac:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8005b3:	00 00 00 
  8005b6:	8b 00                	mov    (%rax),%eax
  8005b8:	85 c0                	test   %eax,%eax
  8005ba:	0f 84 95 00 00 00    	je     800655 <runcmd+0x612>
  8005c0:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  8005c7:	00 00 00 
  8005ca:	48 8b 00             	mov    (%rax),%rax
  8005cd:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8005d3:	89 c6                	mov    %eax,%esi
  8005d5:	48 bf 53 6a 80 00 00 	movabs $0x806a53,%rdi
  8005dc:	00 00 00 
  8005df:	b8 00 00 00 00       	mov    $0x0,%eax
  8005e4:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  8005eb:	00 00 00 
  8005ee:	ff d2                	callq  *%rdx
  8005f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  8005f7:	eb 2f                	jmp    800628 <runcmd+0x5e5>
  8005f9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8005fc:	48 98                	cltq   
  8005fe:	48 8b 84 c5 60 ff ff 	mov    -0xa0(%rbp,%rax,8),%rax
  800605:	ff 
  800606:	48 89 c6             	mov    %rax,%rsi
  800609:	48 bf 61 6a 80 00 00 	movabs $0x806a61,%rdi
  800610:	00 00 00 
  800613:	b8 00 00 00 00       	mov    $0x0,%eax
  800618:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80061f:	00 00 00 
  800622:	ff d2                	callq  *%rdx
  800624:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  800628:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80062b:	48 98                	cltq   
  80062d:	48 8b 84 c5 60 ff ff 	mov    -0xa0(%rbp,%rax,8),%rax
  800634:	ff 
  800635:	48 85 c0             	test   %rax,%rax
  800638:	75 bf                	jne    8005f9 <runcmd+0x5b6>
  80063a:	48 bf 65 6a 80 00 00 	movabs $0x806a65,%rdi
  800641:	00 00 00 
  800644:	b8 00 00 00 00       	mov    $0x0,%eax
  800649:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800650:	00 00 00 
  800653:	ff d2                	callq  *%rdx
  800655:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  80065c:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
  800663:	48 89 d6             	mov    %rdx,%rsi
  800666:	48 89 c7             	mov    %rax,%rdi
  800669:	48 b8 8d 4b 80 00 00 	movabs $0x804b8d,%rax
  800670:	00 00 00 
  800673:	ff d0                	callq  *%rax
  800675:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800678:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80067c:	79 28                	jns    8006a6 <runcmd+0x663>
  80067e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  800685:	8b 55 e8             	mov    -0x18(%rbp),%edx
  800688:	48 89 c6             	mov    %rax,%rsi
  80068b:	48 bf 67 6a 80 00 00 	movabs $0x806a67,%rdi
  800692:	00 00 00 
  800695:	b8 00 00 00 00       	mov    $0x0,%eax
  80069a:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  8006a1:	00 00 00 
  8006a4:	ff d1                	callq  *%rcx
  8006a6:	48 b8 9f 3b 80 00 00 	movabs $0x803b9f,%rax
  8006ad:	00 00 00 
  8006b0:	ff d0                	callq  *%rax
  8006b2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8006b6:	0f 88 9c 00 00 00    	js     800758 <runcmd+0x715>
  8006bc:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8006c3:	00 00 00 
  8006c6:	8b 00                	mov    (%rax),%eax
  8006c8:	85 c0                	test   %eax,%eax
  8006ca:	74 3b                	je     800707 <runcmd+0x6c4>
  8006cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  8006d3:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  8006da:	00 00 00 
  8006dd:	48 8b 00             	mov    (%rax),%rax
  8006e0:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8006e6:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8006e9:	89 c6                	mov    %eax,%esi
  8006eb:	48 bf 75 6a 80 00 00 	movabs $0x806a75,%rdi
  8006f2:	00 00 00 
  8006f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8006fa:	49 b8 46 15 80 00 00 	movabs $0x801546,%r8
  800701:	00 00 00 
  800704:	41 ff d0             	callq  *%r8
  800707:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80070a:	89 c7                	mov    %eax,%edi
  80070c:	48 b8 cc 64 80 00 00 	movabs $0x8064cc,%rax
  800713:	00 00 00 
  800716:	ff d0                	callq  *%rax
  800718:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80071f:	00 00 00 
  800722:	8b 00                	mov    (%rax),%eax
  800724:	85 c0                	test   %eax,%eax
  800726:	74 30                	je     800758 <runcmd+0x715>
  800728:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  80072f:	00 00 00 
  800732:	48 8b 00             	mov    (%rax),%rax
  800735:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80073b:	89 c6                	mov    %eax,%esi
  80073d:	48 bf 8a 6a 80 00 00 	movabs $0x806a8a,%rdi
  800744:	00 00 00 
  800747:	b8 00 00 00 00       	mov    $0x0,%eax
  80074c:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800753:	00 00 00 
  800756:	ff d2                	callq  *%rdx
  800758:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80075c:	0f 84 94 00 00 00    	je     8007f6 <runcmd+0x7b3>
  800762:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800769:	00 00 00 
  80076c:	8b 00                	mov    (%rax),%eax
  80076e:	85 c0                	test   %eax,%eax
  800770:	74 33                	je     8007a5 <runcmd+0x762>
  800772:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  800779:	00 00 00 
  80077c:	48 8b 00             	mov    (%rax),%rax
  80077f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800785:	8b 55 f4             	mov    -0xc(%rbp),%edx
  800788:	89 c6                	mov    %eax,%esi
  80078a:	48 bf a0 6a 80 00 00 	movabs $0x806aa0,%rdi
  800791:	00 00 00 
  800794:	b8 00 00 00 00       	mov    $0x0,%eax
  800799:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  8007a0:	00 00 00 
  8007a3:	ff d1                	callq  *%rcx
  8007a5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8007a8:	89 c7                	mov    %eax,%edi
  8007aa:	48 b8 cc 64 80 00 00 	movabs $0x8064cc,%rax
  8007b1:	00 00 00 
  8007b4:	ff d0                	callq  *%rax
  8007b6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8007bd:	00 00 00 
  8007c0:	8b 00                	mov    (%rax),%eax
  8007c2:	85 c0                	test   %eax,%eax
  8007c4:	74 30                	je     8007f6 <runcmd+0x7b3>
  8007c6:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  8007cd:	00 00 00 
  8007d0:	48 8b 00             	mov    (%rax),%rax
  8007d3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8007d9:	89 c6                	mov    %eax,%esi
  8007db:	48 bf 8a 6a 80 00 00 	movabs $0x806a8a,%rdi
  8007e2:	00 00 00 
  8007e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8007ea:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  8007f1:	00 00 00 
  8007f4:	ff d2                	callq  *%rdx
  8007f6:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  8007fd:	00 00 00 
  800800:	ff d0                	callq  *%rax
  800802:	c9                   	leaveq 
  800803:	c3                   	retq   

0000000000800804 <_gettoken>:
  800804:	55                   	push   %rbp
  800805:	48 89 e5             	mov    %rsp,%rbp
  800808:	48 83 ec 30          	sub    $0x30,%rsp
  80080c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800810:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800814:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800818:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80081d:	75 36                	jne    800855 <_gettoken+0x51>
  80081f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800826:	00 00 00 
  800829:	8b 00                	mov    (%rax),%eax
  80082b:	83 f8 01             	cmp    $0x1,%eax
  80082e:	7e 1b                	jle    80084b <_gettoken+0x47>
  800830:	48 bf bd 6a 80 00 00 	movabs $0x806abd,%rdi
  800837:	00 00 00 
  80083a:	b8 00 00 00 00       	mov    $0x0,%eax
  80083f:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800846:	00 00 00 
  800849:	ff d2                	callq  *%rdx
  80084b:	b8 00 00 00 00       	mov    $0x0,%eax
  800850:	e9 04 02 00 00       	jmpq   800a59 <_gettoken+0x255>
  800855:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80085c:	00 00 00 
  80085f:	8b 00                	mov    (%rax),%eax
  800861:	83 f8 01             	cmp    $0x1,%eax
  800864:	7e 22                	jle    800888 <_gettoken+0x84>
  800866:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80086a:	48 89 c6             	mov    %rax,%rsi
  80086d:	48 bf cc 6a 80 00 00 	movabs $0x806acc,%rdi
  800874:	00 00 00 
  800877:	b8 00 00 00 00       	mov    $0x0,%eax
  80087c:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800883:	00 00 00 
  800886:	ff d2                	callq  *%rdx
  800888:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80088c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  800893:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800897:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80089e:	eb 0f                	jmp    8008af <_gettoken+0xab>
  8008a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008a4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8008a8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8008ac:	c6 00 00             	movb   $0x0,(%rax)
  8008af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008b3:	0f b6 00             	movzbl (%rax),%eax
  8008b6:	0f be c0             	movsbl %al,%eax
  8008b9:	89 c6                	mov    %eax,%esi
  8008bb:	48 bf da 6a 80 00 00 	movabs $0x806ada,%rdi
  8008c2:	00 00 00 
  8008c5:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  8008cc:	00 00 00 
  8008cf:	ff d0                	callq  *%rax
  8008d1:	48 85 c0             	test   %rax,%rax
  8008d4:	75 ca                	jne    8008a0 <_gettoken+0x9c>
  8008d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008da:	0f b6 00             	movzbl (%rax),%eax
  8008dd:	84 c0                	test   %al,%al
  8008df:	75 36                	jne    800917 <_gettoken+0x113>
  8008e1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8008e8:	00 00 00 
  8008eb:	8b 00                	mov    (%rax),%eax
  8008ed:	83 f8 01             	cmp    $0x1,%eax
  8008f0:	7e 1b                	jle    80090d <_gettoken+0x109>
  8008f2:	48 bf df 6a 80 00 00 	movabs $0x806adf,%rdi
  8008f9:	00 00 00 
  8008fc:	b8 00 00 00 00       	mov    $0x0,%eax
  800901:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800908:	00 00 00 
  80090b:	ff d2                	callq  *%rdx
  80090d:	b8 00 00 00 00       	mov    $0x0,%eax
  800912:	e9 42 01 00 00       	jmpq   800a59 <_gettoken+0x255>
  800917:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80091b:	0f b6 00             	movzbl (%rax),%eax
  80091e:	0f be c0             	movsbl %al,%eax
  800921:	89 c6                	mov    %eax,%esi
  800923:	48 bf e4 6a 80 00 00 	movabs $0x806ae4,%rdi
  80092a:	00 00 00 
  80092d:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  800934:	00 00 00 
  800937:	ff d0                	callq  *%rax
  800939:	48 85 c0             	test   %rax,%rax
  80093c:	74 6b                	je     8009a9 <_gettoken+0x1a5>
  80093e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800942:	0f b6 00             	movzbl (%rax),%eax
  800945:	0f be c0             	movsbl %al,%eax
  800948:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80094b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80094f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800953:	48 89 10             	mov    %rdx,(%rax)
  800956:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80095a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80095e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800962:	c6 00 00             	movb   $0x0,(%rax)
  800965:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800969:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80096d:	48 89 10             	mov    %rdx,(%rax)
  800970:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800977:	00 00 00 
  80097a:	8b 00                	mov    (%rax),%eax
  80097c:	83 f8 01             	cmp    $0x1,%eax
  80097f:	7e 20                	jle    8009a1 <_gettoken+0x19d>
  800981:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800984:	89 c6                	mov    %eax,%esi
  800986:	48 bf ec 6a 80 00 00 	movabs $0x806aec,%rdi
  80098d:	00 00 00 
  800990:	b8 00 00 00 00       	mov    $0x0,%eax
  800995:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80099c:	00 00 00 
  80099f:	ff d2                	callq  *%rdx
  8009a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8009a4:	e9 b0 00 00 00       	jmpq   800a59 <_gettoken+0x255>
  8009a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8009ad:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009b1:	48 89 10             	mov    %rdx,(%rax)
  8009b4:	eb 05                	jmp    8009bb <_gettoken+0x1b7>
  8009b6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8009bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009bf:	0f b6 00             	movzbl (%rax),%eax
  8009c2:	84 c0                	test   %al,%al
  8009c4:	74 27                	je     8009ed <_gettoken+0x1e9>
  8009c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009ca:	0f b6 00             	movzbl (%rax),%eax
  8009cd:	0f be c0             	movsbl %al,%eax
  8009d0:	89 c6                	mov    %eax,%esi
  8009d2:	48 bf f4 6a 80 00 00 	movabs $0x806af4,%rdi
  8009d9:	00 00 00 
  8009dc:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  8009e3:	00 00 00 
  8009e6:	ff d0                	callq  *%rax
  8009e8:	48 85 c0             	test   %rax,%rax
  8009eb:	74 c9                	je     8009b6 <_gettoken+0x1b2>
  8009ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8009f1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009f5:	48 89 10             	mov    %rdx,(%rax)
  8009f8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8009ff:	00 00 00 
  800a02:	8b 00                	mov    (%rax),%eax
  800a04:	83 f8 01             	cmp    $0x1,%eax
  800a07:	7e 4b                	jle    800a54 <_gettoken+0x250>
  800a09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800a0d:	48 8b 00             	mov    (%rax),%rax
  800a10:	0f b6 00             	movzbl (%rax),%eax
  800a13:	0f be c0             	movsbl %al,%eax
  800a16:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800a19:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800a1d:	48 8b 00             	mov    (%rax),%rax
  800a20:	c6 00 00             	movb   $0x0,(%rax)
  800a23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800a27:	48 8b 00             	mov    (%rax),%rax
  800a2a:	48 89 c6             	mov    %rax,%rsi
  800a2d:	48 bf 00 6b 80 00 00 	movabs $0x806b00,%rdi
  800a34:	00 00 00 
  800a37:	b8 00 00 00 00       	mov    $0x0,%eax
  800a3c:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800a43:	00 00 00 
  800a46:	ff d2                	callq  *%rdx
  800a48:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800a4c:	48 8b 00             	mov    (%rax),%rax
  800a4f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800a52:	88 10                	mov    %dl,(%rax)
  800a54:	b8 77 00 00 00       	mov    $0x77,%eax
  800a59:	c9                   	leaveq 
  800a5a:	c3                   	retq   

0000000000800a5b <gettoken>:
  800a5b:	55                   	push   %rbp
  800a5c:	48 89 e5             	mov    %rsp,%rbp
  800a5f:	48 83 ec 10          	sub    $0x10,%rsp
  800a63:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800a67:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800a6b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  800a70:	74 3a                	je     800aac <gettoken+0x51>
  800a72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800a76:	48 ba 10 a0 80 00 00 	movabs $0x80a010,%rdx
  800a7d:	00 00 00 
  800a80:	48 be 08 a0 80 00 00 	movabs $0x80a008,%rsi
  800a87:	00 00 00 
  800a8a:	48 89 c7             	mov    %rax,%rdi
  800a8d:	48 b8 04 08 80 00 00 	movabs $0x800804,%rax
  800a94:	00 00 00 
  800a97:	ff d0                	callq  *%rax
  800a99:	48 ba 18 a0 80 00 00 	movabs $0x80a018,%rdx
  800aa0:	00 00 00 
  800aa3:	89 02                	mov    %eax,(%rdx)
  800aa5:	b8 00 00 00 00       	mov    $0x0,%eax
  800aaa:	eb 74                	jmp    800b20 <gettoken+0xc5>
  800aac:	48 b8 18 a0 80 00 00 	movabs $0x80a018,%rax
  800ab3:	00 00 00 
  800ab6:	8b 10                	mov    (%rax),%edx
  800ab8:	48 b8 1c a0 80 00 00 	movabs $0x80a01c,%rax
  800abf:	00 00 00 
  800ac2:	89 10                	mov    %edx,(%rax)
  800ac4:	48 b8 08 a0 80 00 00 	movabs $0x80a008,%rax
  800acb:	00 00 00 
  800ace:	48 8b 10             	mov    (%rax),%rdx
  800ad1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ad5:	48 89 10             	mov    %rdx,(%rax)
  800ad8:	48 b8 10 a0 80 00 00 	movabs $0x80a010,%rax
  800adf:	00 00 00 
  800ae2:	48 8b 00             	mov    (%rax),%rax
  800ae5:	48 ba 10 a0 80 00 00 	movabs $0x80a010,%rdx
  800aec:	00 00 00 
  800aef:	48 be 08 a0 80 00 00 	movabs $0x80a008,%rsi
  800af6:	00 00 00 
  800af9:	48 89 c7             	mov    %rax,%rdi
  800afc:	48 b8 04 08 80 00 00 	movabs $0x800804,%rax
  800b03:	00 00 00 
  800b06:	ff d0                	callq  *%rax
  800b08:	48 ba 18 a0 80 00 00 	movabs $0x80a018,%rdx
  800b0f:	00 00 00 
  800b12:	89 02                	mov    %eax,(%rdx)
  800b14:	48 b8 1c a0 80 00 00 	movabs $0x80a01c,%rax
  800b1b:	00 00 00 
  800b1e:	8b 00                	mov    (%rax),%eax
  800b20:	c9                   	leaveq 
  800b21:	c3                   	retq   

0000000000800b22 <usage>:
  800b22:	55                   	push   %rbp
  800b23:	48 89 e5             	mov    %rsp,%rbp
  800b26:	48 bf 10 6b 80 00 00 	movabs $0x806b10,%rdi
  800b2d:	00 00 00 
  800b30:	b8 00 00 00 00       	mov    $0x0,%eax
  800b35:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800b3c:	00 00 00 
  800b3f:	ff d2                	callq  *%rdx
  800b41:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800b48:	00 00 00 
  800b4b:	ff d0                	callq  *%rax
  800b4d:	5d                   	pop    %rbp
  800b4e:	c3                   	retq   

0000000000800b4f <umain>:
  800b4f:	55                   	push   %rbp
  800b50:	48 89 e5             	mov    %rsp,%rbp
  800b53:	48 83 ec 50          	sub    $0x50,%rsp
  800b57:	89 7d bc             	mov    %edi,-0x44(%rbp)
  800b5a:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
  800b5e:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
  800b62:	c7 45 fc 3f 00 00 00 	movl   $0x3f,-0x4(%rbp)
  800b69:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  800b70:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
  800b74:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
  800b78:	48 8d 45 bc          	lea    -0x44(%rbp),%rax
  800b7c:	48 89 ce             	mov    %rcx,%rsi
  800b7f:	48 89 c7             	mov    %rax,%rdi
  800b82:	48 b8 79 35 80 00 00 	movabs $0x803579,%rax
  800b89:	00 00 00 
  800b8c:	ff d0                	callq  *%rax
  800b8e:	eb 4d                	jmp    800bdd <umain+0x8e>
  800b90:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800b93:	83 f8 69             	cmp    $0x69,%eax
  800b96:	74 27                	je     800bbf <umain+0x70>
  800b98:	83 f8 78             	cmp    $0x78,%eax
  800b9b:	74 2b                	je     800bc8 <umain+0x79>
  800b9d:	83 f8 64             	cmp    $0x64,%eax
  800ba0:	75 2f                	jne    800bd1 <umain+0x82>
  800ba2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800ba9:	00 00 00 
  800bac:	8b 00                	mov    (%rax),%eax
  800bae:	8d 50 01             	lea    0x1(%rax),%edx
  800bb1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800bb8:	00 00 00 
  800bbb:	89 10                	mov    %edx,(%rax)
  800bbd:	eb 1e                	jmp    800bdd <umain+0x8e>
  800bbf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  800bc6:	eb 15                	jmp    800bdd <umain+0x8e>
  800bc8:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
  800bcf:	eb 0c                	jmp    800bdd <umain+0x8e>
  800bd1:	48 b8 22 0b 80 00 00 	movabs $0x800b22,%rax
  800bd8:	00 00 00 
  800bdb:	ff d0                	callq  *%rax
  800bdd:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  800be1:	48 89 c7             	mov    %rax,%rdi
  800be4:	48 b8 dd 35 80 00 00 	movabs $0x8035dd,%rax
  800beb:	00 00 00 
  800bee:	ff d0                	callq  *%rax
  800bf0:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800bf3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800bf7:	79 97                	jns    800b90 <umain+0x41>
  800bf9:	bf 00 00 00 00       	mov    $0x0,%edi
  800bfe:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  800c05:	00 00 00 
  800c08:	ff d0                	callq  *%rax
  800c0a:	48 b8 75 10 80 00 00 	movabs $0x801075,%rax
  800c11:	00 00 00 
  800c14:	ff d0                	callq  *%rax
  800c16:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800c19:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800c1d:	79 30                	jns    800c4f <umain+0x100>
  800c1f:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800c22:	89 c1                	mov    %eax,%ecx
  800c24:	48 ba 31 6b 80 00 00 	movabs $0x806b31,%rdx
  800c2b:	00 00 00 
  800c2e:	be 66 01 00 00       	mov    $0x166,%esi
  800c33:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800c3a:	00 00 00 
  800c3d:	b8 00 00 00 00       	mov    $0x0,%eax
  800c42:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800c49:	00 00 00 
  800c4c:	41 ff d0             	callq  *%r8
  800c4f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800c53:	74 30                	je     800c85 <umain+0x136>
  800c55:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800c58:	89 c1                	mov    %eax,%ecx
  800c5a:	48 ba 3e 6b 80 00 00 	movabs $0x806b3e,%rdx
  800c61:	00 00 00 
  800c64:	be 68 01 00 00       	mov    $0x168,%esi
  800c69:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800c70:	00 00 00 
  800c73:	b8 00 00 00 00       	mov    $0x0,%eax
  800c78:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800c7f:	00 00 00 
  800c82:	41 ff d0             	callq  *%r8
  800c85:	be 01 00 00 00       	mov    $0x1,%esi
  800c8a:	bf 00 00 00 00       	mov    $0x0,%edi
  800c8f:	48 b8 cd 3b 80 00 00 	movabs $0x803bcd,%rax
  800c96:	00 00 00 
  800c99:	ff d0                	callq  *%rax
  800c9b:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800c9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800ca2:	79 30                	jns    800cd4 <umain+0x185>
  800ca4:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800ca7:	89 c1                	mov    %eax,%ecx
  800ca9:	48 ba 58 6b 80 00 00 	movabs $0x806b58,%rdx
  800cb0:	00 00 00 
  800cb3:	be 6a 01 00 00       	mov    $0x16a,%esi
  800cb8:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800cbf:	00 00 00 
  800cc2:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc7:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800cce:	00 00 00 
  800cd1:	41 ff d0             	callq  *%r8
  800cd4:	8b 45 bc             	mov    -0x44(%rbp),%eax
  800cd7:	83 f8 02             	cmp    $0x2,%eax
  800cda:	7e 0c                	jle    800ce8 <umain+0x199>
  800cdc:	48 b8 22 0b 80 00 00 	movabs $0x800b22,%rax
  800ce3:	00 00 00 
  800ce6:	ff d0                	callq  *%rax
  800ce8:	8b 45 bc             	mov    -0x44(%rbp),%eax
  800ceb:	83 f8 02             	cmp    $0x2,%eax
  800cee:	0f 85 b3 00 00 00    	jne    800da7 <umain+0x258>
  800cf4:	bf 00 00 00 00       	mov    $0x0,%edi
  800cf9:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  800d00:	00 00 00 
  800d03:	ff d0                	callq  *%rax
  800d05:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  800d09:	48 83 c0 08          	add    $0x8,%rax
  800d0d:	48 8b 00             	mov    (%rax),%rax
  800d10:	be 00 00 00 00       	mov    $0x0,%esi
  800d15:	48 89 c7             	mov    %rax,%rdi
  800d18:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  800d1f:	00 00 00 
  800d22:	ff d0                	callq  *%rax
  800d24:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800d27:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800d2b:	79 3f                	jns    800d6c <umain+0x21d>
  800d2d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  800d31:	48 83 c0 08          	add    $0x8,%rax
  800d35:	48 8b 00             	mov    (%rax),%rax
  800d38:	8b 55 f0             	mov    -0x10(%rbp),%edx
  800d3b:	41 89 d0             	mov    %edx,%r8d
  800d3e:	48 89 c1             	mov    %rax,%rcx
  800d41:	48 ba 60 6b 80 00 00 	movabs $0x806b60,%rdx
  800d48:	00 00 00 
  800d4b:	be 71 01 00 00       	mov    $0x171,%esi
  800d50:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800d57:	00 00 00 
  800d5a:	b8 00 00 00 00       	mov    $0x0,%eax
  800d5f:	49 b9 0d 13 80 00 00 	movabs $0x80130d,%r9
  800d66:	00 00 00 
  800d69:	41 ff d1             	callq  *%r9
  800d6c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800d70:	74 35                	je     800da7 <umain+0x258>
  800d72:	48 b9 6c 6b 80 00 00 	movabs $0x806b6c,%rcx
  800d79:	00 00 00 
  800d7c:	48 ba 73 6b 80 00 00 	movabs $0x806b73,%rdx
  800d83:	00 00 00 
  800d86:	be 72 01 00 00       	mov    $0x172,%esi
  800d8b:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800d92:	00 00 00 
  800d95:	b8 00 00 00 00       	mov    $0x0,%eax
  800d9a:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800da1:	00 00 00 
  800da4:	41 ff d0             	callq  *%r8
  800da7:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
  800dab:	75 14                	jne    800dc1 <umain+0x272>
  800dad:	bf 00 00 00 00       	mov    $0x0,%edi
  800db2:	48 b8 28 10 80 00 00 	movabs $0x801028,%rax
  800db9:	00 00 00 
  800dbc:	ff d0                	callq  *%rax
  800dbe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800dc1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800dc5:	74 0c                	je     800dd3 <umain+0x284>
  800dc7:	48 b8 88 6b 80 00 00 	movabs $0x806b88,%rax
  800dce:	00 00 00 
  800dd1:	eb 05                	jmp    800dd8 <umain+0x289>
  800dd3:	b8 00 00 00 00       	mov    $0x0,%eax
  800dd8:	48 89 c7             	mov    %rax,%rdi
  800ddb:	48 b8 8f 20 80 00 00 	movabs $0x80208f,%rax
  800de2:	00 00 00 
  800de5:	ff d0                	callq  *%rax
  800de7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800deb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800df0:	75 37                	jne    800e29 <umain+0x2da>
  800df2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800df9:	00 00 00 
  800dfc:	8b 00                	mov    (%rax),%eax
  800dfe:	85 c0                	test   %eax,%eax
  800e00:	74 1b                	je     800e1d <umain+0x2ce>
  800e02:	48 bf 8d 6b 80 00 00 	movabs $0x806b8d,%rdi
  800e09:	00 00 00 
  800e0c:	b8 00 00 00 00       	mov    $0x0,%eax
  800e11:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800e18:	00 00 00 
  800e1b:	ff d2                	callq  *%rdx
  800e1d:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800e24:	00 00 00 
  800e27:	ff d0                	callq  *%rax
  800e29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e2d:	48 be 96 6b 80 00 00 	movabs $0x806b96,%rsi
  800e34:	00 00 00 
  800e37:	48 89 c7             	mov    %rax,%rdi
  800e3a:	48 b8 b7 23 80 00 00 	movabs $0x8023b7,%rax
  800e41:	00 00 00 
  800e44:	ff d0                	callq  *%rax
  800e46:	85 c0                	test   %eax,%eax
  800e48:	75 0c                	jne    800e56 <umain+0x307>
  800e4a:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800e51:	00 00 00 
  800e54:	ff d0                	callq  *%rax
  800e56:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800e5d:	00 00 00 
  800e60:	8b 00                	mov    (%rax),%eax
  800e62:	85 c0                	test   %eax,%eax
  800e64:	74 22                	je     800e88 <umain+0x339>
  800e66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e6a:	48 89 c6             	mov    %rax,%rsi
  800e6d:	48 bf 9b 6b 80 00 00 	movabs $0x806b9b,%rdi
  800e74:	00 00 00 
  800e77:	b8 00 00 00 00       	mov    $0x0,%eax
  800e7c:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800e83:	00 00 00 
  800e86:	ff d2                	callq  *%rdx
  800e88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e8c:	0f b6 00             	movzbl (%rax),%eax
  800e8f:	3c 23                	cmp    $0x23,%al
  800e91:	75 05                	jne    800e98 <umain+0x349>
  800e93:	e9 17 01 00 00       	jmpq   800faf <umain+0x460>
  800e98:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800e9c:	74 22                	je     800ec0 <umain+0x371>
  800e9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ea2:	48 89 c6             	mov    %rax,%rsi
  800ea5:	48 bf a5 6b 80 00 00 	movabs $0x806ba5,%rdi
  800eac:	00 00 00 
  800eaf:	b8 00 00 00 00       	mov    $0x0,%eax
  800eb4:	48 ba d7 4a 80 00 00 	movabs $0x804ad7,%rdx
  800ebb:	00 00 00 
  800ebe:	ff d2                	callq  *%rdx
  800ec0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800ec7:	00 00 00 
  800eca:	8b 00                	mov    (%rax),%eax
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	74 1b                	je     800eeb <umain+0x39c>
  800ed0:	48 bf ab 6b 80 00 00 	movabs $0x806bab,%rdi
  800ed7:	00 00 00 
  800eda:	b8 00 00 00 00       	mov    $0x0,%eax
  800edf:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800ee6:	00 00 00 
  800ee9:	ff d2                	callq  *%rdx
  800eeb:	48 b8 04 33 80 00 00 	movabs $0x803304,%rax
  800ef2:	00 00 00 
  800ef5:	ff d0                	callq  *%rax
  800ef7:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800efa:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800efe:	79 30                	jns    800f30 <umain+0x3e1>
  800f00:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800f03:	89 c1                	mov    %eax,%ecx
  800f05:	48 ba 12 6a 80 00 00 	movabs $0x806a12,%rdx
  800f0c:	00 00 00 
  800f0f:	be 98 01 00 00       	mov    $0x198,%esi
  800f14:	48 bf 37 6a 80 00 00 	movabs $0x806a37,%rdi
  800f1b:	00 00 00 
  800f1e:	b8 00 00 00 00       	mov    $0x0,%eax
  800f23:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  800f2a:	00 00 00 
  800f2d:	41 ff d0             	callq  *%r8
  800f30:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  800f37:	00 00 00 
  800f3a:	8b 00                	mov    (%rax),%eax
  800f3c:	85 c0                	test   %eax,%eax
  800f3e:	74 20                	je     800f60 <umain+0x411>
  800f40:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800f43:	89 c6                	mov    %eax,%esi
  800f45:	48 bf b8 6b 80 00 00 	movabs $0x806bb8,%rdi
  800f4c:	00 00 00 
  800f4f:	b8 00 00 00 00       	mov    $0x0,%eax
  800f54:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  800f5b:	00 00 00 
  800f5e:	ff d2                	callq  *%rdx
  800f60:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800f64:	75 21                	jne    800f87 <umain+0x438>
  800f66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f6a:	48 89 c7             	mov    %rax,%rdi
  800f6d:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800f74:	00 00 00 
  800f77:	ff d0                	callq  *%rax
  800f79:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800f80:	00 00 00 
  800f83:	ff d0                	callq  *%rax
  800f85:	eb 28                	jmp    800faf <umain+0x460>
  800f87:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800f8a:	89 c7                	mov    %eax,%edi
  800f8c:	48 b8 cc 64 80 00 00 	movabs $0x8064cc,%rax
  800f93:	00 00 00 
  800f96:	ff d0                	callq  *%rax
  800f98:	80 7d f7 00          	cmpb   $0x0,-0x9(%rbp)
  800f9c:	74 11                	je     800faf <umain+0x460>
  800f9e:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  800fa5:	00 00 00 
  800fa8:	ff d0                	callq  *%rax
  800faa:	e9 12 fe ff ff       	jmpq   800dc1 <umain+0x272>
  800faf:	e9 0d fe ff ff       	jmpq   800dc1 <umain+0x272>

0000000000800fb4 <cputchar>:
  800fb4:	55                   	push   %rbp
  800fb5:	48 89 e5             	mov    %rsp,%rbp
  800fb8:	48 83 ec 20          	sub    $0x20,%rsp
  800fbc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800fbf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800fc2:	88 45 ff             	mov    %al,-0x1(%rbp)
  800fc5:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  800fc9:	be 01 00 00 00       	mov    $0x1,%esi
  800fce:	48 89 c7             	mov    %rax,%rdi
  800fd1:	48 b8 3c 2a 80 00 00 	movabs $0x802a3c,%rax
  800fd8:	00 00 00 
  800fdb:	ff d0                	callq  *%rax
  800fdd:	c9                   	leaveq 
  800fde:	c3                   	retq   

0000000000800fdf <getchar>:
  800fdf:	55                   	push   %rbp
  800fe0:	48 89 e5             	mov    %rsp,%rbp
  800fe3:	48 83 ec 10          	sub    $0x10,%rsp
  800fe7:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  800feb:	ba 01 00 00 00       	mov    $0x1,%edx
  800ff0:	48 89 c6             	mov    %rax,%rsi
  800ff3:	bf 00 00 00 00       	mov    $0x0,%edi
  800ff8:	48 b8 76 3d 80 00 00 	movabs $0x803d76,%rax
  800fff:	00 00 00 
  801002:	ff d0                	callq  *%rax
  801004:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801007:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80100b:	79 05                	jns    801012 <getchar+0x33>
  80100d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801010:	eb 14                	jmp    801026 <getchar+0x47>
  801012:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801016:	7f 07                	jg     80101f <getchar+0x40>
  801018:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80101d:	eb 07                	jmp    801026 <getchar+0x47>
  80101f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  801023:	0f b6 c0             	movzbl %al,%eax
  801026:	c9                   	leaveq 
  801027:	c3                   	retq   

0000000000801028 <iscons>:
  801028:	55                   	push   %rbp
  801029:	48 89 e5             	mov    %rsp,%rbp
  80102c:	48 83 ec 20          	sub    $0x20,%rsp
  801030:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801033:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801037:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80103a:	48 89 d6             	mov    %rdx,%rsi
  80103d:	89 c7                	mov    %eax,%edi
  80103f:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  801046:	00 00 00 
  801049:	ff d0                	callq  *%rax
  80104b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80104e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801052:	79 05                	jns    801059 <iscons+0x31>
  801054:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801057:	eb 1a                	jmp    801073 <iscons+0x4b>
  801059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80105d:	8b 10                	mov    (%rax),%edx
  80105f:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  801066:	00 00 00 
  801069:	8b 00                	mov    (%rax),%eax
  80106b:	39 c2                	cmp    %eax,%edx
  80106d:	0f 94 c0             	sete   %al
  801070:	0f b6 c0             	movzbl %al,%eax
  801073:	c9                   	leaveq 
  801074:	c3                   	retq   

0000000000801075 <opencons>:
  801075:	55                   	push   %rbp
  801076:	48 89 e5             	mov    %rsp,%rbp
  801079:	48 83 ec 10          	sub    $0x10,%rsp
  80107d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  801081:	48 89 c7             	mov    %rax,%rdi
  801084:	48 b8 ac 38 80 00 00 	movabs $0x8038ac,%rax
  80108b:	00 00 00 
  80108e:	ff d0                	callq  *%rax
  801090:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801093:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801097:	79 05                	jns    80109e <opencons+0x29>
  801099:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80109c:	eb 5b                	jmp    8010f9 <opencons+0x84>
  80109e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010a2:	ba 07 04 00 00       	mov    $0x407,%edx
  8010a7:	48 89 c6             	mov    %rax,%rsi
  8010aa:	bf 00 00 00 00       	mov    $0x0,%edi
  8010af:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  8010b6:	00 00 00 
  8010b9:	ff d0                	callq  *%rax
  8010bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8010be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8010c2:	79 05                	jns    8010c9 <opencons+0x54>
  8010c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8010c7:	eb 30                	jmp    8010f9 <opencons+0x84>
  8010c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010cd:	48 ba 20 90 80 00 00 	movabs $0x809020,%rdx
  8010d4:	00 00 00 
  8010d7:	8b 12                	mov    (%rdx),%edx
  8010d9:	89 10                	mov    %edx,(%rax)
  8010db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010df:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8010e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010ea:	48 89 c7             	mov    %rax,%rdi
  8010ed:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  8010f4:	00 00 00 
  8010f7:	ff d0                	callq  *%rax
  8010f9:	c9                   	leaveq 
  8010fa:	c3                   	retq   

00000000008010fb <devcons_read>:
  8010fb:	55                   	push   %rbp
  8010fc:	48 89 e5             	mov    %rsp,%rbp
  8010ff:	48 83 ec 30          	sub    $0x30,%rsp
  801103:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801107:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80110b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80110f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801114:	75 07                	jne    80111d <devcons_read+0x22>
  801116:	b8 00 00 00 00       	mov    $0x0,%eax
  80111b:	eb 4b                	jmp    801168 <devcons_read+0x6d>
  80111d:	eb 0c                	jmp    80112b <devcons_read+0x30>
  80111f:	48 b8 46 2b 80 00 00 	movabs $0x802b46,%rax
  801126:	00 00 00 
  801129:	ff d0                	callq  *%rax
  80112b:	48 b8 86 2a 80 00 00 	movabs $0x802a86,%rax
  801132:	00 00 00 
  801135:	ff d0                	callq  *%rax
  801137:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80113a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80113e:	74 df                	je     80111f <devcons_read+0x24>
  801140:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801144:	79 05                	jns    80114b <devcons_read+0x50>
  801146:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801149:	eb 1d                	jmp    801168 <devcons_read+0x6d>
  80114b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80114f:	75 07                	jne    801158 <devcons_read+0x5d>
  801151:	b8 00 00 00 00       	mov    $0x0,%eax
  801156:	eb 10                	jmp    801168 <devcons_read+0x6d>
  801158:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80115b:	89 c2                	mov    %eax,%edx
  80115d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801161:	88 10                	mov    %dl,(%rax)
  801163:	b8 01 00 00 00       	mov    $0x1,%eax
  801168:	c9                   	leaveq 
  801169:	c3                   	retq   

000000000080116a <devcons_write>:
  80116a:	55                   	push   %rbp
  80116b:	48 89 e5             	mov    %rsp,%rbp
  80116e:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  801175:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  80117c:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  801183:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80118a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801191:	eb 76                	jmp    801209 <devcons_write+0x9f>
  801193:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80119a:	89 c2                	mov    %eax,%edx
  80119c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80119f:	29 c2                	sub    %eax,%edx
  8011a1:	89 d0                	mov    %edx,%eax
  8011a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8011a6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8011a9:	83 f8 7f             	cmp    $0x7f,%eax
  8011ac:	76 07                	jbe    8011b5 <devcons_write+0x4b>
  8011ae:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8011b5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8011b8:	48 63 d0             	movslq %eax,%rdx
  8011bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011be:	48 63 c8             	movslq %eax,%rcx
  8011c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8011c8:	48 01 c1             	add    %rax,%rcx
  8011cb:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8011d2:	48 89 ce             	mov    %rcx,%rsi
  8011d5:	48 89 c7             	mov    %rax,%rdi
  8011d8:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  8011df:	00 00 00 
  8011e2:	ff d0                	callq  *%rax
  8011e4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8011e7:	48 63 d0             	movslq %eax,%rdx
  8011ea:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8011f1:	48 89 d6             	mov    %rdx,%rsi
  8011f4:	48 89 c7             	mov    %rax,%rdi
  8011f7:	48 b8 3c 2a 80 00 00 	movabs $0x802a3c,%rax
  8011fe:	00 00 00 
  801201:	ff d0                	callq  *%rax
  801203:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801206:	01 45 fc             	add    %eax,-0x4(%rbp)
  801209:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80120c:	48 98                	cltq   
  80120e:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  801215:	0f 82 78 ff ff ff    	jb     801193 <devcons_write+0x29>
  80121b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80121e:	c9                   	leaveq 
  80121f:	c3                   	retq   

0000000000801220 <devcons_close>:
  801220:	55                   	push   %rbp
  801221:	48 89 e5             	mov    %rsp,%rbp
  801224:	48 83 ec 08          	sub    $0x8,%rsp
  801228:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80122c:	b8 00 00 00 00       	mov    $0x0,%eax
  801231:	c9                   	leaveq 
  801232:	c3                   	retq   

0000000000801233 <devcons_stat>:
  801233:	55                   	push   %rbp
  801234:	48 89 e5             	mov    %rsp,%rbp
  801237:	48 83 ec 10          	sub    $0x10,%rsp
  80123b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80123f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801243:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801247:	48 be c7 6b 80 00 00 	movabs $0x806bc7,%rsi
  80124e:	00 00 00 
  801251:	48 89 c7             	mov    %rax,%rdi
  801254:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  80125b:	00 00 00 
  80125e:	ff d0                	callq  *%rax
  801260:	b8 00 00 00 00       	mov    $0x0,%eax
  801265:	c9                   	leaveq 
  801266:	c3                   	retq   

0000000000801267 <libmain>:
  801267:	55                   	push   %rbp
  801268:	48 89 e5             	mov    %rsp,%rbp
  80126b:	48 83 ec 10          	sub    $0x10,%rsp
  80126f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801272:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801276:	48 b8 08 2b 80 00 00 	movabs $0x802b08,%rax
  80127d:	00 00 00 
  801280:	ff d0                	callq  *%rax
  801282:	25 ff 03 00 00       	and    $0x3ff,%eax
  801287:	48 98                	cltq   
  801289:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  801290:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  801297:	00 00 00 
  80129a:	48 01 c2             	add    %rax,%rdx
  80129d:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  8012a4:	00 00 00 
  8012a7:	48 89 10             	mov    %rdx,(%rax)
  8012aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8012ae:	7e 14                	jle    8012c4 <libmain+0x5d>
  8012b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012b4:	48 8b 10             	mov    (%rax),%rdx
  8012b7:	48 b8 58 90 80 00 00 	movabs $0x809058,%rax
  8012be:	00 00 00 
  8012c1:	48 89 10             	mov    %rdx,(%rax)
  8012c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8012c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8012cb:	48 89 d6             	mov    %rdx,%rsi
  8012ce:	89 c7                	mov    %eax,%edi
  8012d0:	48 b8 4f 0b 80 00 00 	movabs $0x800b4f,%rax
  8012d7:	00 00 00 
  8012da:	ff d0                	callq  *%rax
  8012dc:	48 b8 ea 12 80 00 00 	movabs $0x8012ea,%rax
  8012e3:	00 00 00 
  8012e6:	ff d0                	callq  *%rax
  8012e8:	c9                   	leaveq 
  8012e9:	c3                   	retq   

00000000008012ea <exit>:
  8012ea:	55                   	push   %rbp
  8012eb:	48 89 e5             	mov    %rsp,%rbp
  8012ee:	48 b8 9f 3b 80 00 00 	movabs $0x803b9f,%rax
  8012f5:	00 00 00 
  8012f8:	ff d0                	callq  *%rax
  8012fa:	bf 00 00 00 00       	mov    $0x0,%edi
  8012ff:	48 b8 c4 2a 80 00 00 	movabs $0x802ac4,%rax
  801306:	00 00 00 
  801309:	ff d0                	callq  *%rax
  80130b:	5d                   	pop    %rbp
  80130c:	c3                   	retq   

000000000080130d <_panic>:
  80130d:	55                   	push   %rbp
  80130e:	48 89 e5             	mov    %rsp,%rbp
  801311:	53                   	push   %rbx
  801312:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  801319:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  801320:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  801326:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  80132d:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  801334:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80133b:	84 c0                	test   %al,%al
  80133d:	74 23                	je     801362 <_panic+0x55>
  80133f:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  801346:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80134a:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  80134e:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  801352:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  801356:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80135a:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80135e:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  801362:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  801369:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  801370:	00 00 00 
  801373:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80137a:	00 00 00 
  80137d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801381:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  801388:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80138f:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801396:	48 b8 58 90 80 00 00 	movabs $0x809058,%rax
  80139d:	00 00 00 
  8013a0:	48 8b 18             	mov    (%rax),%rbx
  8013a3:	48 b8 08 2b 80 00 00 	movabs $0x802b08,%rax
  8013aa:	00 00 00 
  8013ad:	ff d0                	callq  *%rax
  8013af:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8013b5:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8013bc:	41 89 c8             	mov    %ecx,%r8d
  8013bf:	48 89 d1             	mov    %rdx,%rcx
  8013c2:	48 89 da             	mov    %rbx,%rdx
  8013c5:	89 c6                	mov    %eax,%esi
  8013c7:	48 bf d8 6b 80 00 00 	movabs $0x806bd8,%rdi
  8013ce:	00 00 00 
  8013d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d6:	49 b9 46 15 80 00 00 	movabs $0x801546,%r9
  8013dd:	00 00 00 
  8013e0:	41 ff d1             	callq  *%r9
  8013e3:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8013ea:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8013f1:	48 89 d6             	mov    %rdx,%rsi
  8013f4:	48 89 c7             	mov    %rax,%rdi
  8013f7:	48 b8 9a 14 80 00 00 	movabs $0x80149a,%rax
  8013fe:	00 00 00 
  801401:	ff d0                	callq  *%rax
  801403:	48 bf fb 6b 80 00 00 	movabs $0x806bfb,%rdi
  80140a:	00 00 00 
  80140d:	b8 00 00 00 00       	mov    $0x0,%eax
  801412:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  801419:	00 00 00 
  80141c:	ff d2                	callq  *%rdx
  80141e:	cc                   	int3   
  80141f:	eb fd                	jmp    80141e <_panic+0x111>

0000000000801421 <putch>:
  801421:	55                   	push   %rbp
  801422:	48 89 e5             	mov    %rsp,%rbp
  801425:	48 83 ec 10          	sub    $0x10,%rsp
  801429:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80142c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801430:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801434:	8b 00                	mov    (%rax),%eax
  801436:	8d 48 01             	lea    0x1(%rax),%ecx
  801439:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80143d:	89 0a                	mov    %ecx,(%rdx)
  80143f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801442:	89 d1                	mov    %edx,%ecx
  801444:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801448:	48 98                	cltq   
  80144a:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80144e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801452:	8b 00                	mov    (%rax),%eax
  801454:	3d ff 00 00 00       	cmp    $0xff,%eax
  801459:	75 2c                	jne    801487 <putch+0x66>
  80145b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80145f:	8b 00                	mov    (%rax),%eax
  801461:	48 98                	cltq   
  801463:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801467:	48 83 c2 08          	add    $0x8,%rdx
  80146b:	48 89 c6             	mov    %rax,%rsi
  80146e:	48 89 d7             	mov    %rdx,%rdi
  801471:	48 b8 3c 2a 80 00 00 	movabs $0x802a3c,%rax
  801478:	00 00 00 
  80147b:	ff d0                	callq  *%rax
  80147d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801481:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  801487:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80148b:	8b 40 04             	mov    0x4(%rax),%eax
  80148e:	8d 50 01             	lea    0x1(%rax),%edx
  801491:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801495:	89 50 04             	mov    %edx,0x4(%rax)
  801498:	c9                   	leaveq 
  801499:	c3                   	retq   

000000000080149a <vcprintf>:
  80149a:	55                   	push   %rbp
  80149b:	48 89 e5             	mov    %rsp,%rbp
  80149e:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8014a5:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8014ac:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8014b3:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8014ba:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8014c1:	48 8b 0a             	mov    (%rdx),%rcx
  8014c4:	48 89 08             	mov    %rcx,(%rax)
  8014c7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8014cb:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8014cf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8014d3:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8014d7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8014de:	00 00 00 
  8014e1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8014e8:	00 00 00 
  8014eb:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8014f2:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8014f9:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  801500:	48 89 c6             	mov    %rax,%rsi
  801503:	48 bf 21 14 80 00 00 	movabs $0x801421,%rdi
  80150a:	00 00 00 
  80150d:	48 b8 f9 18 80 00 00 	movabs $0x8018f9,%rax
  801514:	00 00 00 
  801517:	ff d0                	callq  *%rax
  801519:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  80151f:	48 98                	cltq   
  801521:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  801528:	48 83 c2 08          	add    $0x8,%rdx
  80152c:	48 89 c6             	mov    %rax,%rsi
  80152f:	48 89 d7             	mov    %rdx,%rdi
  801532:	48 b8 3c 2a 80 00 00 	movabs $0x802a3c,%rax
  801539:	00 00 00 
  80153c:	ff d0                	callq  *%rax
  80153e:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  801544:	c9                   	leaveq 
  801545:	c3                   	retq   

0000000000801546 <cprintf>:
  801546:	55                   	push   %rbp
  801547:	48 89 e5             	mov    %rsp,%rbp
  80154a:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  801551:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  801558:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80155f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801566:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80156d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801574:	84 c0                	test   %al,%al
  801576:	74 20                	je     801598 <cprintf+0x52>
  801578:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80157c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801580:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801584:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801588:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80158c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801590:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801594:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801598:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80159f:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8015a6:	00 00 00 
  8015a9:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8015b0:	00 00 00 
  8015b3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8015b7:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8015be:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8015c5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8015cc:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8015d3:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8015da:	48 8b 0a             	mov    (%rdx),%rcx
  8015dd:	48 89 08             	mov    %rcx,(%rax)
  8015e0:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8015e4:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8015e8:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8015ec:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8015f0:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8015f7:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8015fe:	48 89 d6             	mov    %rdx,%rsi
  801601:	48 89 c7             	mov    %rax,%rdi
  801604:	48 b8 9a 14 80 00 00 	movabs $0x80149a,%rax
  80160b:	00 00 00 
  80160e:	ff d0                	callq  *%rax
  801610:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801616:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80161c:	c9                   	leaveq 
  80161d:	c3                   	retq   

000000000080161e <printnum>:
  80161e:	55                   	push   %rbp
  80161f:	48 89 e5             	mov    %rsp,%rbp
  801622:	53                   	push   %rbx
  801623:	48 83 ec 38          	sub    $0x38,%rsp
  801627:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80162b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80162f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801633:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  801636:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80163a:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  80163e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  801641:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801645:	77 3b                	ja     801682 <printnum+0x64>
  801647:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80164a:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  80164e:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  801651:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801655:	ba 00 00 00 00       	mov    $0x0,%edx
  80165a:	48 f7 f3             	div    %rbx
  80165d:	48 89 c2             	mov    %rax,%rdx
  801660:	8b 7d cc             	mov    -0x34(%rbp),%edi
  801663:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  801666:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80166a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80166e:	41 89 f9             	mov    %edi,%r9d
  801671:	48 89 c7             	mov    %rax,%rdi
  801674:	48 b8 1e 16 80 00 00 	movabs $0x80161e,%rax
  80167b:	00 00 00 
  80167e:	ff d0                	callq  *%rax
  801680:	eb 1e                	jmp    8016a0 <printnum+0x82>
  801682:	eb 12                	jmp    801696 <printnum+0x78>
  801684:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  801688:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80168b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80168f:	48 89 ce             	mov    %rcx,%rsi
  801692:	89 d7                	mov    %edx,%edi
  801694:	ff d0                	callq  *%rax
  801696:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80169a:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  80169e:	7f e4                	jg     801684 <printnum+0x66>
  8016a0:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8016a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016a7:	ba 00 00 00 00       	mov    $0x0,%edx
  8016ac:	48 f7 f1             	div    %rcx
  8016af:	48 89 d0             	mov    %rdx,%rax
  8016b2:	48 ba f0 6d 80 00 00 	movabs $0x806df0,%rdx
  8016b9:	00 00 00 
  8016bc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8016c0:	0f be d0             	movsbl %al,%edx
  8016c3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8016c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016cb:	48 89 ce             	mov    %rcx,%rsi
  8016ce:	89 d7                	mov    %edx,%edi
  8016d0:	ff d0                	callq  *%rax
  8016d2:	48 83 c4 38          	add    $0x38,%rsp
  8016d6:	5b                   	pop    %rbx
  8016d7:	5d                   	pop    %rbp
  8016d8:	c3                   	retq   

00000000008016d9 <getuint>:
  8016d9:	55                   	push   %rbp
  8016da:	48 89 e5             	mov    %rsp,%rbp
  8016dd:	48 83 ec 1c          	sub    $0x1c,%rsp
  8016e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8016e5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8016e8:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8016ec:	7e 52                	jle    801740 <getuint+0x67>
  8016ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016f2:	8b 00                	mov    (%rax),%eax
  8016f4:	83 f8 30             	cmp    $0x30,%eax
  8016f7:	73 24                	jae    80171d <getuint+0x44>
  8016f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016fd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801701:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801705:	8b 00                	mov    (%rax),%eax
  801707:	89 c0                	mov    %eax,%eax
  801709:	48 01 d0             	add    %rdx,%rax
  80170c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801710:	8b 12                	mov    (%rdx),%edx
  801712:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801715:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801719:	89 0a                	mov    %ecx,(%rdx)
  80171b:	eb 17                	jmp    801734 <getuint+0x5b>
  80171d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801721:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801725:	48 89 d0             	mov    %rdx,%rax
  801728:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80172c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801730:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801734:	48 8b 00             	mov    (%rax),%rax
  801737:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80173b:	e9 a3 00 00 00       	jmpq   8017e3 <getuint+0x10a>
  801740:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  801744:	74 4f                	je     801795 <getuint+0xbc>
  801746:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80174a:	8b 00                	mov    (%rax),%eax
  80174c:	83 f8 30             	cmp    $0x30,%eax
  80174f:	73 24                	jae    801775 <getuint+0x9c>
  801751:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801755:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801759:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80175d:	8b 00                	mov    (%rax),%eax
  80175f:	89 c0                	mov    %eax,%eax
  801761:	48 01 d0             	add    %rdx,%rax
  801764:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801768:	8b 12                	mov    (%rdx),%edx
  80176a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80176d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801771:	89 0a                	mov    %ecx,(%rdx)
  801773:	eb 17                	jmp    80178c <getuint+0xb3>
  801775:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801779:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80177d:	48 89 d0             	mov    %rdx,%rax
  801780:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  801784:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801788:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80178c:	48 8b 00             	mov    (%rax),%rax
  80178f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801793:	eb 4e                	jmp    8017e3 <getuint+0x10a>
  801795:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801799:	8b 00                	mov    (%rax),%eax
  80179b:	83 f8 30             	cmp    $0x30,%eax
  80179e:	73 24                	jae    8017c4 <getuint+0xeb>
  8017a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8017a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017ac:	8b 00                	mov    (%rax),%eax
  8017ae:	89 c0                	mov    %eax,%eax
  8017b0:	48 01 d0             	add    %rdx,%rax
  8017b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017b7:	8b 12                	mov    (%rdx),%edx
  8017b9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8017bc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017c0:	89 0a                	mov    %ecx,(%rdx)
  8017c2:	eb 17                	jmp    8017db <getuint+0x102>
  8017c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017c8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8017cc:	48 89 d0             	mov    %rdx,%rax
  8017cf:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8017d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8017db:	8b 00                	mov    (%rax),%eax
  8017dd:	89 c0                	mov    %eax,%eax
  8017df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8017e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017e7:	c9                   	leaveq 
  8017e8:	c3                   	retq   

00000000008017e9 <getint>:
  8017e9:	55                   	push   %rbp
  8017ea:	48 89 e5             	mov    %rsp,%rbp
  8017ed:	48 83 ec 1c          	sub    $0x1c,%rsp
  8017f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8017f5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8017f8:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8017fc:	7e 52                	jle    801850 <getint+0x67>
  8017fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801802:	8b 00                	mov    (%rax),%eax
  801804:	83 f8 30             	cmp    $0x30,%eax
  801807:	73 24                	jae    80182d <getint+0x44>
  801809:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80180d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801811:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801815:	8b 00                	mov    (%rax),%eax
  801817:	89 c0                	mov    %eax,%eax
  801819:	48 01 d0             	add    %rdx,%rax
  80181c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801820:	8b 12                	mov    (%rdx),%edx
  801822:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801825:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801829:	89 0a                	mov    %ecx,(%rdx)
  80182b:	eb 17                	jmp    801844 <getint+0x5b>
  80182d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801831:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801835:	48 89 d0             	mov    %rdx,%rax
  801838:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80183c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801840:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801844:	48 8b 00             	mov    (%rax),%rax
  801847:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80184b:	e9 a3 00 00 00       	jmpq   8018f3 <getint+0x10a>
  801850:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  801854:	74 4f                	je     8018a5 <getint+0xbc>
  801856:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80185a:	8b 00                	mov    (%rax),%eax
  80185c:	83 f8 30             	cmp    $0x30,%eax
  80185f:	73 24                	jae    801885 <getint+0x9c>
  801861:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801865:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801869:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80186d:	8b 00                	mov    (%rax),%eax
  80186f:	89 c0                	mov    %eax,%eax
  801871:	48 01 d0             	add    %rdx,%rax
  801874:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801878:	8b 12                	mov    (%rdx),%edx
  80187a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80187d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801881:	89 0a                	mov    %ecx,(%rdx)
  801883:	eb 17                	jmp    80189c <getint+0xb3>
  801885:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801889:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80188d:	48 89 d0             	mov    %rdx,%rax
  801890:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  801894:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801898:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80189c:	48 8b 00             	mov    (%rax),%rax
  80189f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018a3:	eb 4e                	jmp    8018f3 <getint+0x10a>
  8018a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018a9:	8b 00                	mov    (%rax),%eax
  8018ab:	83 f8 30             	cmp    $0x30,%eax
  8018ae:	73 24                	jae    8018d4 <getint+0xeb>
  8018b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018b4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8018b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018bc:	8b 00                	mov    (%rax),%eax
  8018be:	89 c0                	mov    %eax,%eax
  8018c0:	48 01 d0             	add    %rdx,%rax
  8018c3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018c7:	8b 12                	mov    (%rdx),%edx
  8018c9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8018cc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018d0:	89 0a                	mov    %ecx,(%rdx)
  8018d2:	eb 17                	jmp    8018eb <getint+0x102>
  8018d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018d8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8018dc:	48 89 d0             	mov    %rdx,%rax
  8018df:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8018e3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8018eb:	8b 00                	mov    (%rax),%eax
  8018ed:	48 98                	cltq   
  8018ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018f7:	c9                   	leaveq 
  8018f8:	c3                   	retq   

00000000008018f9 <vprintfmt>:
  8018f9:	55                   	push   %rbp
  8018fa:	48 89 e5             	mov    %rsp,%rbp
  8018fd:	41 54                	push   %r12
  8018ff:	53                   	push   %rbx
  801900:	48 83 ec 60          	sub    $0x60,%rsp
  801904:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  801908:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  80190c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  801910:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  801914:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801918:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  80191c:	48 8b 0a             	mov    (%rdx),%rcx
  80191f:	48 89 08             	mov    %rcx,(%rax)
  801922:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801926:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80192a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80192e:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801932:	eb 17                	jmp    80194b <vprintfmt+0x52>
  801934:	85 db                	test   %ebx,%ebx
  801936:	0f 84 cc 04 00 00    	je     801e08 <vprintfmt+0x50f>
  80193c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801940:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801944:	48 89 d6             	mov    %rdx,%rsi
  801947:	89 df                	mov    %ebx,%edi
  801949:	ff d0                	callq  *%rax
  80194b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80194f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801953:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  801957:	0f b6 00             	movzbl (%rax),%eax
  80195a:	0f b6 d8             	movzbl %al,%ebx
  80195d:	83 fb 25             	cmp    $0x25,%ebx
  801960:	75 d2                	jne    801934 <vprintfmt+0x3b>
  801962:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  801966:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  80196d:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  801974:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80197b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  801982:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801986:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80198a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80198e:	0f b6 00             	movzbl (%rax),%eax
  801991:	0f b6 d8             	movzbl %al,%ebx
  801994:	8d 43 dd             	lea    -0x23(%rbx),%eax
  801997:	83 f8 55             	cmp    $0x55,%eax
  80199a:	0f 87 34 04 00 00    	ja     801dd4 <vprintfmt+0x4db>
  8019a0:	89 c0                	mov    %eax,%eax
  8019a2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8019a9:	00 
  8019aa:	48 b8 18 6e 80 00 00 	movabs $0x806e18,%rax
  8019b1:	00 00 00 
  8019b4:	48 01 d0             	add    %rdx,%rax
  8019b7:	48 8b 00             	mov    (%rax),%rax
  8019ba:	ff e0                	jmpq   *%rax
  8019bc:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8019c0:	eb c0                	jmp    801982 <vprintfmt+0x89>
  8019c2:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8019c6:	eb ba                	jmp    801982 <vprintfmt+0x89>
  8019c8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8019cf:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8019d2:	89 d0                	mov    %edx,%eax
  8019d4:	c1 e0 02             	shl    $0x2,%eax
  8019d7:	01 d0                	add    %edx,%eax
  8019d9:	01 c0                	add    %eax,%eax
  8019db:	01 d8                	add    %ebx,%eax
  8019dd:	83 e8 30             	sub    $0x30,%eax
  8019e0:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8019e3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8019e7:	0f b6 00             	movzbl (%rax),%eax
  8019ea:	0f be d8             	movsbl %al,%ebx
  8019ed:	83 fb 2f             	cmp    $0x2f,%ebx
  8019f0:	7e 0c                	jle    8019fe <vprintfmt+0x105>
  8019f2:	83 fb 39             	cmp    $0x39,%ebx
  8019f5:	7f 07                	jg     8019fe <vprintfmt+0x105>
  8019f7:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  8019fc:	eb d1                	jmp    8019cf <vprintfmt+0xd6>
  8019fe:	eb 58                	jmp    801a58 <vprintfmt+0x15f>
  801a00:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801a03:	83 f8 30             	cmp    $0x30,%eax
  801a06:	73 17                	jae    801a1f <vprintfmt+0x126>
  801a08:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801a0c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801a0f:	89 c0                	mov    %eax,%eax
  801a11:	48 01 d0             	add    %rdx,%rax
  801a14:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801a17:	83 c2 08             	add    $0x8,%edx
  801a1a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801a1d:	eb 0f                	jmp    801a2e <vprintfmt+0x135>
  801a1f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801a23:	48 89 d0             	mov    %rdx,%rax
  801a26:	48 83 c2 08          	add    $0x8,%rdx
  801a2a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801a2e:	8b 00                	mov    (%rax),%eax
  801a30:	89 45 d8             	mov    %eax,-0x28(%rbp)
  801a33:	eb 23                	jmp    801a58 <vprintfmt+0x15f>
  801a35:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801a39:	79 0c                	jns    801a47 <vprintfmt+0x14e>
  801a3b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  801a42:	e9 3b ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a47:	e9 36 ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a4c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  801a53:	e9 2a ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a58:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801a5c:	79 12                	jns    801a70 <vprintfmt+0x177>
  801a5e:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801a61:	89 45 dc             	mov    %eax,-0x24(%rbp)
  801a64:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  801a6b:	e9 12 ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a70:	e9 0d ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a75:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  801a79:	e9 04 ff ff ff       	jmpq   801982 <vprintfmt+0x89>
  801a7e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801a81:	83 f8 30             	cmp    $0x30,%eax
  801a84:	73 17                	jae    801a9d <vprintfmt+0x1a4>
  801a86:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801a8a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801a8d:	89 c0                	mov    %eax,%eax
  801a8f:	48 01 d0             	add    %rdx,%rax
  801a92:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801a95:	83 c2 08             	add    $0x8,%edx
  801a98:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801a9b:	eb 0f                	jmp    801aac <vprintfmt+0x1b3>
  801a9d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801aa1:	48 89 d0             	mov    %rdx,%rax
  801aa4:	48 83 c2 08          	add    $0x8,%rdx
  801aa8:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801aac:	8b 10                	mov    (%rax),%edx
  801aae:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  801ab2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801ab6:	48 89 ce             	mov    %rcx,%rsi
  801ab9:	89 d7                	mov    %edx,%edi
  801abb:	ff d0                	callq  *%rax
  801abd:	e9 40 03 00 00       	jmpq   801e02 <vprintfmt+0x509>
  801ac2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801ac5:	83 f8 30             	cmp    $0x30,%eax
  801ac8:	73 17                	jae    801ae1 <vprintfmt+0x1e8>
  801aca:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801ace:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801ad1:	89 c0                	mov    %eax,%eax
  801ad3:	48 01 d0             	add    %rdx,%rax
  801ad6:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801ad9:	83 c2 08             	add    $0x8,%edx
  801adc:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801adf:	eb 0f                	jmp    801af0 <vprintfmt+0x1f7>
  801ae1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801ae5:	48 89 d0             	mov    %rdx,%rax
  801ae8:	48 83 c2 08          	add    $0x8,%rdx
  801aec:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801af0:	8b 18                	mov    (%rax),%ebx
  801af2:	85 db                	test   %ebx,%ebx
  801af4:	79 02                	jns    801af8 <vprintfmt+0x1ff>
  801af6:	f7 db                	neg    %ebx
  801af8:	83 fb 15             	cmp    $0x15,%ebx
  801afb:	7f 16                	jg     801b13 <vprintfmt+0x21a>
  801afd:	48 b8 40 6d 80 00 00 	movabs $0x806d40,%rax
  801b04:	00 00 00 
  801b07:	48 63 d3             	movslq %ebx,%rdx
  801b0a:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  801b0e:	4d 85 e4             	test   %r12,%r12
  801b11:	75 2e                	jne    801b41 <vprintfmt+0x248>
  801b13:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801b17:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801b1b:	89 d9                	mov    %ebx,%ecx
  801b1d:	48 ba 01 6e 80 00 00 	movabs $0x806e01,%rdx
  801b24:	00 00 00 
  801b27:	48 89 c7             	mov    %rax,%rdi
  801b2a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b2f:	49 b8 11 1e 80 00 00 	movabs $0x801e11,%r8
  801b36:	00 00 00 
  801b39:	41 ff d0             	callq  *%r8
  801b3c:	e9 c1 02 00 00       	jmpq   801e02 <vprintfmt+0x509>
  801b41:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801b45:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801b49:	4c 89 e1             	mov    %r12,%rcx
  801b4c:	48 ba 0a 6e 80 00 00 	movabs $0x806e0a,%rdx
  801b53:	00 00 00 
  801b56:	48 89 c7             	mov    %rax,%rdi
  801b59:	b8 00 00 00 00       	mov    $0x0,%eax
  801b5e:	49 b8 11 1e 80 00 00 	movabs $0x801e11,%r8
  801b65:	00 00 00 
  801b68:	41 ff d0             	callq  *%r8
  801b6b:	e9 92 02 00 00       	jmpq   801e02 <vprintfmt+0x509>
  801b70:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801b73:	83 f8 30             	cmp    $0x30,%eax
  801b76:	73 17                	jae    801b8f <vprintfmt+0x296>
  801b78:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801b7c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801b7f:	89 c0                	mov    %eax,%eax
  801b81:	48 01 d0             	add    %rdx,%rax
  801b84:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801b87:	83 c2 08             	add    $0x8,%edx
  801b8a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801b8d:	eb 0f                	jmp    801b9e <vprintfmt+0x2a5>
  801b8f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801b93:	48 89 d0             	mov    %rdx,%rax
  801b96:	48 83 c2 08          	add    $0x8,%rdx
  801b9a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801b9e:	4c 8b 20             	mov    (%rax),%r12
  801ba1:	4d 85 e4             	test   %r12,%r12
  801ba4:	75 0a                	jne    801bb0 <vprintfmt+0x2b7>
  801ba6:	49 bc 0d 6e 80 00 00 	movabs $0x806e0d,%r12
  801bad:	00 00 00 
  801bb0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801bb4:	7e 3f                	jle    801bf5 <vprintfmt+0x2fc>
  801bb6:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  801bba:	74 39                	je     801bf5 <vprintfmt+0x2fc>
  801bbc:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801bbf:	48 98                	cltq   
  801bc1:	48 89 c6             	mov    %rax,%rsi
  801bc4:	4c 89 e7             	mov    %r12,%rdi
  801bc7:	48 b8 17 22 80 00 00 	movabs $0x802217,%rax
  801bce:	00 00 00 
  801bd1:	ff d0                	callq  *%rax
  801bd3:	29 45 dc             	sub    %eax,-0x24(%rbp)
  801bd6:	eb 17                	jmp    801bef <vprintfmt+0x2f6>
  801bd8:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  801bdc:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  801be0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801be4:	48 89 ce             	mov    %rcx,%rsi
  801be7:	89 d7                	mov    %edx,%edi
  801be9:	ff d0                	callq  *%rax
  801beb:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801bef:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801bf3:	7f e3                	jg     801bd8 <vprintfmt+0x2df>
  801bf5:	eb 37                	jmp    801c2e <vprintfmt+0x335>
  801bf7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  801bfb:	74 1e                	je     801c1b <vprintfmt+0x322>
  801bfd:	83 fb 1f             	cmp    $0x1f,%ebx
  801c00:	7e 05                	jle    801c07 <vprintfmt+0x30e>
  801c02:	83 fb 7e             	cmp    $0x7e,%ebx
  801c05:	7e 14                	jle    801c1b <vprintfmt+0x322>
  801c07:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801c0b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801c0f:	48 89 d6             	mov    %rdx,%rsi
  801c12:	bf 3f 00 00 00       	mov    $0x3f,%edi
  801c17:	ff d0                	callq  *%rax
  801c19:	eb 0f                	jmp    801c2a <vprintfmt+0x331>
  801c1b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801c1f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801c23:	48 89 d6             	mov    %rdx,%rsi
  801c26:	89 df                	mov    %ebx,%edi
  801c28:	ff d0                	callq  *%rax
  801c2a:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801c2e:	4c 89 e0             	mov    %r12,%rax
  801c31:	4c 8d 60 01          	lea    0x1(%rax),%r12
  801c35:	0f b6 00             	movzbl (%rax),%eax
  801c38:	0f be d8             	movsbl %al,%ebx
  801c3b:	85 db                	test   %ebx,%ebx
  801c3d:	74 10                	je     801c4f <vprintfmt+0x356>
  801c3f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801c43:	78 b2                	js     801bf7 <vprintfmt+0x2fe>
  801c45:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  801c49:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801c4d:	79 a8                	jns    801bf7 <vprintfmt+0x2fe>
  801c4f:	eb 16                	jmp    801c67 <vprintfmt+0x36e>
  801c51:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801c55:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801c59:	48 89 d6             	mov    %rdx,%rsi
  801c5c:	bf 20 00 00 00       	mov    $0x20,%edi
  801c61:	ff d0                	callq  *%rax
  801c63:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801c67:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801c6b:	7f e4                	jg     801c51 <vprintfmt+0x358>
  801c6d:	e9 90 01 00 00       	jmpq   801e02 <vprintfmt+0x509>
  801c72:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801c76:	be 03 00 00 00       	mov    $0x3,%esi
  801c7b:	48 89 c7             	mov    %rax,%rdi
  801c7e:	48 b8 e9 17 80 00 00 	movabs $0x8017e9,%rax
  801c85:	00 00 00 
  801c88:	ff d0                	callq  *%rax
  801c8a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801c8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c92:	48 85 c0             	test   %rax,%rax
  801c95:	79 1d                	jns    801cb4 <vprintfmt+0x3bb>
  801c97:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801c9b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801c9f:	48 89 d6             	mov    %rdx,%rsi
  801ca2:	bf 2d 00 00 00       	mov    $0x2d,%edi
  801ca7:	ff d0                	callq  *%rax
  801ca9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801cad:	48 f7 d8             	neg    %rax
  801cb0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801cb4:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  801cbb:	e9 d5 00 00 00       	jmpq   801d95 <vprintfmt+0x49c>
  801cc0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801cc4:	be 03 00 00 00       	mov    $0x3,%esi
  801cc9:	48 89 c7             	mov    %rax,%rdi
  801ccc:	48 b8 d9 16 80 00 00 	movabs $0x8016d9,%rax
  801cd3:	00 00 00 
  801cd6:	ff d0                	callq  *%rax
  801cd8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801cdc:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  801ce3:	e9 ad 00 00 00       	jmpq   801d95 <vprintfmt+0x49c>
  801ce8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801cec:	be 03 00 00 00       	mov    $0x3,%esi
  801cf1:	48 89 c7             	mov    %rax,%rdi
  801cf4:	48 b8 d9 16 80 00 00 	movabs $0x8016d9,%rax
  801cfb:	00 00 00 
  801cfe:	ff d0                	callq  *%rax
  801d00:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801d04:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  801d0b:	e9 85 00 00 00       	jmpq   801d95 <vprintfmt+0x49c>
  801d10:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801d14:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801d18:	48 89 d6             	mov    %rdx,%rsi
  801d1b:	bf 30 00 00 00       	mov    $0x30,%edi
  801d20:	ff d0                	callq  *%rax
  801d22:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801d26:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801d2a:	48 89 d6             	mov    %rdx,%rsi
  801d2d:	bf 78 00 00 00       	mov    $0x78,%edi
  801d32:	ff d0                	callq  *%rax
  801d34:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801d37:	83 f8 30             	cmp    $0x30,%eax
  801d3a:	73 17                	jae    801d53 <vprintfmt+0x45a>
  801d3c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801d40:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801d43:	89 c0                	mov    %eax,%eax
  801d45:	48 01 d0             	add    %rdx,%rax
  801d48:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801d4b:	83 c2 08             	add    $0x8,%edx
  801d4e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801d51:	eb 0f                	jmp    801d62 <vprintfmt+0x469>
  801d53:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801d57:	48 89 d0             	mov    %rdx,%rax
  801d5a:	48 83 c2 08          	add    $0x8,%rdx
  801d5e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801d62:	48 8b 00             	mov    (%rax),%rax
  801d65:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801d69:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801d70:	eb 23                	jmp    801d95 <vprintfmt+0x49c>
  801d72:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801d76:	be 03 00 00 00       	mov    $0x3,%esi
  801d7b:	48 89 c7             	mov    %rax,%rdi
  801d7e:	48 b8 d9 16 80 00 00 	movabs $0x8016d9,%rax
  801d85:	00 00 00 
  801d88:	ff d0                	callq  *%rax
  801d8a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801d8e:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801d95:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  801d9a:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  801d9d:	8b 7d dc             	mov    -0x24(%rbp),%edi
  801da0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801da4:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801da8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801dac:	45 89 c1             	mov    %r8d,%r9d
  801daf:	41 89 f8             	mov    %edi,%r8d
  801db2:	48 89 c7             	mov    %rax,%rdi
  801db5:	48 b8 1e 16 80 00 00 	movabs $0x80161e,%rax
  801dbc:	00 00 00 
  801dbf:	ff d0                	callq  *%rax
  801dc1:	eb 3f                	jmp    801e02 <vprintfmt+0x509>
  801dc3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801dc7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801dcb:	48 89 d6             	mov    %rdx,%rsi
  801dce:	89 df                	mov    %ebx,%edi
  801dd0:	ff d0                	callq  *%rax
  801dd2:	eb 2e                	jmp    801e02 <vprintfmt+0x509>
  801dd4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801dd8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801ddc:	48 89 d6             	mov    %rdx,%rsi
  801ddf:	bf 25 00 00 00       	mov    $0x25,%edi
  801de4:	ff d0                	callq  *%rax
  801de6:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  801deb:	eb 05                	jmp    801df2 <vprintfmt+0x4f9>
  801ded:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  801df2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801df6:	48 83 e8 01          	sub    $0x1,%rax
  801dfa:	0f b6 00             	movzbl (%rax),%eax
  801dfd:	3c 25                	cmp    $0x25,%al
  801dff:	75 ec                	jne    801ded <vprintfmt+0x4f4>
  801e01:	90                   	nop
  801e02:	90                   	nop
  801e03:	e9 43 fb ff ff       	jmpq   80194b <vprintfmt+0x52>
  801e08:	48 83 c4 60          	add    $0x60,%rsp
  801e0c:	5b                   	pop    %rbx
  801e0d:	41 5c                	pop    %r12
  801e0f:	5d                   	pop    %rbp
  801e10:	c3                   	retq   

0000000000801e11 <printfmt>:
  801e11:	55                   	push   %rbp
  801e12:	48 89 e5             	mov    %rsp,%rbp
  801e15:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  801e1c:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801e23:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  801e2a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801e31:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801e38:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801e3f:	84 c0                	test   %al,%al
  801e41:	74 20                	je     801e63 <printfmt+0x52>
  801e43:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801e47:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801e4b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801e4f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801e53:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801e57:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801e5b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801e5f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801e63:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  801e6a:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801e71:	00 00 00 
  801e74:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  801e7b:	00 00 00 
  801e7e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801e82:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801e89:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801e90:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  801e97:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  801e9e:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  801ea5:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  801eac:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  801eb3:	48 89 c7             	mov    %rax,%rdi
  801eb6:	48 b8 f9 18 80 00 00 	movabs $0x8018f9,%rax
  801ebd:	00 00 00 
  801ec0:	ff d0                	callq  *%rax
  801ec2:	c9                   	leaveq 
  801ec3:	c3                   	retq   

0000000000801ec4 <sprintputch>:
  801ec4:	55                   	push   %rbp
  801ec5:	48 89 e5             	mov    %rsp,%rbp
  801ec8:	48 83 ec 10          	sub    $0x10,%rsp
  801ecc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ecf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ed7:	8b 40 10             	mov    0x10(%rax),%eax
  801eda:	8d 50 01             	lea    0x1(%rax),%edx
  801edd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ee1:	89 50 10             	mov    %edx,0x10(%rax)
  801ee4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ee8:	48 8b 10             	mov    (%rax),%rdx
  801eeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801eef:	48 8b 40 08          	mov    0x8(%rax),%rax
  801ef3:	48 39 c2             	cmp    %rax,%rdx
  801ef6:	73 17                	jae    801f0f <sprintputch+0x4b>
  801ef8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801efc:	48 8b 00             	mov    (%rax),%rax
  801eff:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801f03:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f07:	48 89 0a             	mov    %rcx,(%rdx)
  801f0a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f0d:	88 10                	mov    %dl,(%rax)
  801f0f:	c9                   	leaveq 
  801f10:	c3                   	retq   

0000000000801f11 <vsnprintf>:
  801f11:	55                   	push   %rbp
  801f12:	48 89 e5             	mov    %rsp,%rbp
  801f15:	48 83 ec 50          	sub    $0x50,%rsp
  801f19:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801f1d:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801f20:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801f24:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  801f28:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  801f2c:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801f30:	48 8b 0a             	mov    (%rdx),%rcx
  801f33:	48 89 08             	mov    %rcx,(%rax)
  801f36:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801f3a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801f3e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801f42:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801f46:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801f4a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801f4e:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801f51:	48 98                	cltq   
  801f53:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801f57:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801f5b:	48 01 d0             	add    %rdx,%rax
  801f5e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801f62:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801f69:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801f6e:	74 06                	je     801f76 <vsnprintf+0x65>
  801f70:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801f74:	7f 07                	jg     801f7d <vsnprintf+0x6c>
  801f76:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f7b:	eb 2f                	jmp    801fac <vsnprintf+0x9b>
  801f7d:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801f81:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801f85:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801f89:	48 89 c6             	mov    %rax,%rsi
  801f8c:	48 bf c4 1e 80 00 00 	movabs $0x801ec4,%rdi
  801f93:	00 00 00 
  801f96:	48 b8 f9 18 80 00 00 	movabs $0x8018f9,%rax
  801f9d:	00 00 00 
  801fa0:	ff d0                	callq  *%rax
  801fa2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801fa6:	c6 00 00             	movb   $0x0,(%rax)
  801fa9:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801fac:	c9                   	leaveq 
  801fad:	c3                   	retq   

0000000000801fae <snprintf>:
  801fae:	55                   	push   %rbp
  801faf:	48 89 e5             	mov    %rsp,%rbp
  801fb2:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  801fb9:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  801fc0:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  801fc6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801fcd:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801fd4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801fdb:	84 c0                	test   %al,%al
  801fdd:	74 20                	je     801fff <snprintf+0x51>
  801fdf:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801fe3:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801fe7:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801feb:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801fef:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801ff3:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801ff7:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801ffb:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801fff:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  802006:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  80200d:	00 00 00 
  802010:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  802017:	00 00 00 
  80201a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80201e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  802025:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80202c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  802033:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80203a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  802041:	48 8b 0a             	mov    (%rdx),%rcx
  802044:	48 89 08             	mov    %rcx,(%rax)
  802047:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80204b:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80204f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  802053:	48 89 50 10          	mov    %rdx,0x10(%rax)
  802057:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  80205e:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  802065:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80206b:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  802072:	48 89 c7             	mov    %rax,%rdi
  802075:	48 b8 11 1f 80 00 00 	movabs $0x801f11,%rax
  80207c:	00 00 00 
  80207f:	ff d0                	callq  *%rax
  802081:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  802087:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80208d:	c9                   	leaveq 
  80208e:	c3                   	retq   

000000000080208f <readline>:
  80208f:	55                   	push   %rbp
  802090:	48 89 e5             	mov    %rsp,%rbp
  802093:	48 83 ec 20          	sub    $0x20,%rsp
  802097:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80209b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8020a0:	74 27                	je     8020c9 <readline+0x3a>
  8020a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020a6:	48 89 c2             	mov    %rax,%rdx
  8020a9:	48 be c8 70 80 00 00 	movabs $0x8070c8,%rsi
  8020b0:	00 00 00 
  8020b3:	bf 01 00 00 00       	mov    $0x1,%edi
  8020b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8020bd:	48 b9 1f 4a 80 00 00 	movabs $0x804a1f,%rcx
  8020c4:	00 00 00 
  8020c7:	ff d1                	callq  *%rcx
  8020c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8020d0:	bf 00 00 00 00       	mov    $0x0,%edi
  8020d5:	48 b8 28 10 80 00 00 	movabs $0x801028,%rax
  8020dc:	00 00 00 
  8020df:	ff d0                	callq  *%rax
  8020e1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8020e4:	48 b8 df 0f 80 00 00 	movabs $0x800fdf,%rax
  8020eb:	00 00 00 
  8020ee:	ff d0                	callq  *%rax
  8020f0:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8020f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8020f7:	79 30                	jns    802129 <readline+0x9a>
  8020f9:	83 7d f4 f7          	cmpl   $0xfffffff7,-0xc(%rbp)
  8020fd:	74 20                	je     80211f <readline+0x90>
  8020ff:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802102:	89 c6                	mov    %eax,%esi
  802104:	48 bf cb 70 80 00 00 	movabs $0x8070cb,%rdi
  80210b:	00 00 00 
  80210e:	b8 00 00 00 00       	mov    $0x0,%eax
  802113:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  80211a:	00 00 00 
  80211d:	ff d2                	callq  *%rdx
  80211f:	b8 00 00 00 00       	mov    $0x0,%eax
  802124:	e9 be 00 00 00       	jmpq   8021e7 <readline+0x158>
  802129:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
  80212d:	74 06                	je     802135 <readline+0xa6>
  80212f:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%rbp)
  802133:	75 26                	jne    80215b <readline+0xcc>
  802135:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802139:	7e 20                	jle    80215b <readline+0xcc>
  80213b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80213f:	74 11                	je     802152 <readline+0xc3>
  802141:	bf 08 00 00 00       	mov    $0x8,%edi
  802146:	48 b8 b4 0f 80 00 00 	movabs $0x800fb4,%rax
  80214d:	00 00 00 
  802150:	ff d0                	callq  *%rax
  802152:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  802156:	e9 87 00 00 00       	jmpq   8021e2 <readline+0x153>
  80215b:	83 7d f4 1f          	cmpl   $0x1f,-0xc(%rbp)
  80215f:	7e 3f                	jle    8021a0 <readline+0x111>
  802161:	81 7d fc fe 03 00 00 	cmpl   $0x3fe,-0x4(%rbp)
  802168:	7f 36                	jg     8021a0 <readline+0x111>
  80216a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80216e:	74 11                	je     802181 <readline+0xf2>
  802170:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802173:	89 c7                	mov    %eax,%edi
  802175:	48 b8 b4 0f 80 00 00 	movabs $0x800fb4,%rax
  80217c:	00 00 00 
  80217f:	ff d0                	callq  *%rax
  802181:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802184:	8d 50 01             	lea    0x1(%rax),%edx
  802187:	89 55 fc             	mov    %edx,-0x4(%rbp)
  80218a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80218d:	89 d1                	mov    %edx,%ecx
  80218f:	48 ba 20 a0 80 00 00 	movabs $0x80a020,%rdx
  802196:	00 00 00 
  802199:	48 98                	cltq   
  80219b:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
  80219e:	eb 42                	jmp    8021e2 <readline+0x153>
  8021a0:	83 7d f4 0a          	cmpl   $0xa,-0xc(%rbp)
  8021a4:	74 06                	je     8021ac <readline+0x11d>
  8021a6:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
  8021aa:	75 36                	jne    8021e2 <readline+0x153>
  8021ac:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8021b0:	74 11                	je     8021c3 <readline+0x134>
  8021b2:	bf 0a 00 00 00       	mov    $0xa,%edi
  8021b7:	48 b8 b4 0f 80 00 00 	movabs $0x800fb4,%rax
  8021be:	00 00 00 
  8021c1:	ff d0                	callq  *%rax
  8021c3:	48 ba 20 a0 80 00 00 	movabs $0x80a020,%rdx
  8021ca:	00 00 00 
  8021cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021d0:	48 98                	cltq   
  8021d2:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
  8021d6:	48 b8 20 a0 80 00 00 	movabs $0x80a020,%rax
  8021dd:	00 00 00 
  8021e0:	eb 05                	jmp    8021e7 <readline+0x158>
  8021e2:	e9 fd fe ff ff       	jmpq   8020e4 <readline+0x55>
  8021e7:	c9                   	leaveq 
  8021e8:	c3                   	retq   

00000000008021e9 <strlen>:
  8021e9:	55                   	push   %rbp
  8021ea:	48 89 e5             	mov    %rsp,%rbp
  8021ed:	48 83 ec 18          	sub    $0x18,%rsp
  8021f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8021f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8021fc:	eb 09                	jmp    802207 <strlen+0x1e>
  8021fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802202:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  802207:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80220b:	0f b6 00             	movzbl (%rax),%eax
  80220e:	84 c0                	test   %al,%al
  802210:	75 ec                	jne    8021fe <strlen+0x15>
  802212:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802215:	c9                   	leaveq 
  802216:	c3                   	retq   

0000000000802217 <strnlen>:
  802217:	55                   	push   %rbp
  802218:	48 89 e5             	mov    %rsp,%rbp
  80221b:	48 83 ec 20          	sub    $0x20,%rsp
  80221f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802223:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802227:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80222e:	eb 0e                	jmp    80223e <strnlen+0x27>
  802230:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802234:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  802239:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  80223e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802243:	74 0b                	je     802250 <strnlen+0x39>
  802245:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802249:	0f b6 00             	movzbl (%rax),%eax
  80224c:	84 c0                	test   %al,%al
  80224e:	75 e0                	jne    802230 <strnlen+0x19>
  802250:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802253:	c9                   	leaveq 
  802254:	c3                   	retq   

0000000000802255 <strcpy>:
  802255:	55                   	push   %rbp
  802256:	48 89 e5             	mov    %rsp,%rbp
  802259:	48 83 ec 20          	sub    $0x20,%rsp
  80225d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802261:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802265:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802269:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80226d:	90                   	nop
  80226e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802272:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802276:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80227a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80227e:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  802282:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  802286:	0f b6 12             	movzbl (%rdx),%edx
  802289:	88 10                	mov    %dl,(%rax)
  80228b:	0f b6 00             	movzbl (%rax),%eax
  80228e:	84 c0                	test   %al,%al
  802290:	75 dc                	jne    80226e <strcpy+0x19>
  802292:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802296:	c9                   	leaveq 
  802297:	c3                   	retq   

0000000000802298 <strcat>:
  802298:	55                   	push   %rbp
  802299:	48 89 e5             	mov    %rsp,%rbp
  80229c:	48 83 ec 20          	sub    $0x20,%rsp
  8022a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8022a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8022a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022ac:	48 89 c7             	mov    %rax,%rdi
  8022af:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  8022b6:	00 00 00 
  8022b9:	ff d0                	callq  *%rax
  8022bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022be:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022c1:	48 63 d0             	movslq %eax,%rdx
  8022c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022c8:	48 01 c2             	add    %rax,%rdx
  8022cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022cf:	48 89 c6             	mov    %rax,%rsi
  8022d2:	48 89 d7             	mov    %rdx,%rdi
  8022d5:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  8022dc:	00 00 00 
  8022df:	ff d0                	callq  *%rax
  8022e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022e5:	c9                   	leaveq 
  8022e6:	c3                   	retq   

00000000008022e7 <strncpy>:
  8022e7:	55                   	push   %rbp
  8022e8:	48 89 e5             	mov    %rsp,%rbp
  8022eb:	48 83 ec 28          	sub    $0x28,%rsp
  8022ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8022f3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8022f7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8022fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022ff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802303:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80230a:	00 
  80230b:	eb 2a                	jmp    802337 <strncpy+0x50>
  80230d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802311:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802315:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802319:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80231d:	0f b6 12             	movzbl (%rdx),%edx
  802320:	88 10                	mov    %dl,(%rax)
  802322:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802326:	0f b6 00             	movzbl (%rax),%eax
  802329:	84 c0                	test   %al,%al
  80232b:	74 05                	je     802332 <strncpy+0x4b>
  80232d:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  802332:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  802337:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80233b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80233f:	72 cc                	jb     80230d <strncpy+0x26>
  802341:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802345:	c9                   	leaveq 
  802346:	c3                   	retq   

0000000000802347 <strlcpy>:
  802347:	55                   	push   %rbp
  802348:	48 89 e5             	mov    %rsp,%rbp
  80234b:	48 83 ec 28          	sub    $0x28,%rsp
  80234f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802353:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802357:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80235b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80235f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802363:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802368:	74 3d                	je     8023a7 <strlcpy+0x60>
  80236a:	eb 1d                	jmp    802389 <strlcpy+0x42>
  80236c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802370:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802374:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802378:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80237c:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  802380:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  802384:	0f b6 12             	movzbl (%rdx),%edx
  802387:	88 10                	mov    %dl,(%rax)
  802389:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80238e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802393:	74 0b                	je     8023a0 <strlcpy+0x59>
  802395:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802399:	0f b6 00             	movzbl (%rax),%eax
  80239c:	84 c0                	test   %al,%al
  80239e:	75 cc                	jne    80236c <strlcpy+0x25>
  8023a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8023a4:	c6 00 00             	movb   $0x0,(%rax)
  8023a7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8023ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023af:	48 29 c2             	sub    %rax,%rdx
  8023b2:	48 89 d0             	mov    %rdx,%rax
  8023b5:	c9                   	leaveq 
  8023b6:	c3                   	retq   

00000000008023b7 <strcmp>:
  8023b7:	55                   	push   %rbp
  8023b8:	48 89 e5             	mov    %rsp,%rbp
  8023bb:	48 83 ec 10          	sub    $0x10,%rsp
  8023bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8023c3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8023c7:	eb 0a                	jmp    8023d3 <strcmp+0x1c>
  8023c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8023ce:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8023d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023d7:	0f b6 00             	movzbl (%rax),%eax
  8023da:	84 c0                	test   %al,%al
  8023dc:	74 12                	je     8023f0 <strcmp+0x39>
  8023de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023e2:	0f b6 10             	movzbl (%rax),%edx
  8023e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023e9:	0f b6 00             	movzbl (%rax),%eax
  8023ec:	38 c2                	cmp    %al,%dl
  8023ee:	74 d9                	je     8023c9 <strcmp+0x12>
  8023f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023f4:	0f b6 00             	movzbl (%rax),%eax
  8023f7:	0f b6 d0             	movzbl %al,%edx
  8023fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023fe:	0f b6 00             	movzbl (%rax),%eax
  802401:	0f b6 c0             	movzbl %al,%eax
  802404:	29 c2                	sub    %eax,%edx
  802406:	89 d0                	mov    %edx,%eax
  802408:	c9                   	leaveq 
  802409:	c3                   	retq   

000000000080240a <strncmp>:
  80240a:	55                   	push   %rbp
  80240b:	48 89 e5             	mov    %rsp,%rbp
  80240e:	48 83 ec 18          	sub    $0x18,%rsp
  802412:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802416:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80241a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80241e:	eb 0f                	jmp    80242f <strncmp+0x25>
  802420:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  802425:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80242a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80242f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802434:	74 1d                	je     802453 <strncmp+0x49>
  802436:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80243a:	0f b6 00             	movzbl (%rax),%eax
  80243d:	84 c0                	test   %al,%al
  80243f:	74 12                	je     802453 <strncmp+0x49>
  802441:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802445:	0f b6 10             	movzbl (%rax),%edx
  802448:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80244c:	0f b6 00             	movzbl (%rax),%eax
  80244f:	38 c2                	cmp    %al,%dl
  802451:	74 cd                	je     802420 <strncmp+0x16>
  802453:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802458:	75 07                	jne    802461 <strncmp+0x57>
  80245a:	b8 00 00 00 00       	mov    $0x0,%eax
  80245f:	eb 18                	jmp    802479 <strncmp+0x6f>
  802461:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802465:	0f b6 00             	movzbl (%rax),%eax
  802468:	0f b6 d0             	movzbl %al,%edx
  80246b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80246f:	0f b6 00             	movzbl (%rax),%eax
  802472:	0f b6 c0             	movzbl %al,%eax
  802475:	29 c2                	sub    %eax,%edx
  802477:	89 d0                	mov    %edx,%eax
  802479:	c9                   	leaveq 
  80247a:	c3                   	retq   

000000000080247b <strchr>:
  80247b:	55                   	push   %rbp
  80247c:	48 89 e5             	mov    %rsp,%rbp
  80247f:	48 83 ec 0c          	sub    $0xc,%rsp
  802483:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802487:	89 f0                	mov    %esi,%eax
  802489:	88 45 f4             	mov    %al,-0xc(%rbp)
  80248c:	eb 17                	jmp    8024a5 <strchr+0x2a>
  80248e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802492:	0f b6 00             	movzbl (%rax),%eax
  802495:	3a 45 f4             	cmp    -0xc(%rbp),%al
  802498:	75 06                	jne    8024a0 <strchr+0x25>
  80249a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80249e:	eb 15                	jmp    8024b5 <strchr+0x3a>
  8024a0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8024a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024a9:	0f b6 00             	movzbl (%rax),%eax
  8024ac:	84 c0                	test   %al,%al
  8024ae:	75 de                	jne    80248e <strchr+0x13>
  8024b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8024b5:	c9                   	leaveq 
  8024b6:	c3                   	retq   

00000000008024b7 <strfind>:
  8024b7:	55                   	push   %rbp
  8024b8:	48 89 e5             	mov    %rsp,%rbp
  8024bb:	48 83 ec 0c          	sub    $0xc,%rsp
  8024bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024c3:	89 f0                	mov    %esi,%eax
  8024c5:	88 45 f4             	mov    %al,-0xc(%rbp)
  8024c8:	eb 13                	jmp    8024dd <strfind+0x26>
  8024ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024ce:	0f b6 00             	movzbl (%rax),%eax
  8024d1:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8024d4:	75 02                	jne    8024d8 <strfind+0x21>
  8024d6:	eb 10                	jmp    8024e8 <strfind+0x31>
  8024d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8024dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024e1:	0f b6 00             	movzbl (%rax),%eax
  8024e4:	84 c0                	test   %al,%al
  8024e6:	75 e2                	jne    8024ca <strfind+0x13>
  8024e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024ec:	c9                   	leaveq 
  8024ed:	c3                   	retq   

00000000008024ee <memset>:
  8024ee:	55                   	push   %rbp
  8024ef:	48 89 e5             	mov    %rsp,%rbp
  8024f2:	48 83 ec 18          	sub    $0x18,%rsp
  8024f6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024fa:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8024fd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802501:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802506:	75 06                	jne    80250e <memset+0x20>
  802508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80250c:	eb 69                	jmp    802577 <memset+0x89>
  80250e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802512:	83 e0 03             	and    $0x3,%eax
  802515:	48 85 c0             	test   %rax,%rax
  802518:	75 48                	jne    802562 <memset+0x74>
  80251a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80251e:	83 e0 03             	and    $0x3,%eax
  802521:	48 85 c0             	test   %rax,%rax
  802524:	75 3c                	jne    802562 <memset+0x74>
  802526:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80252d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802530:	c1 e0 18             	shl    $0x18,%eax
  802533:	89 c2                	mov    %eax,%edx
  802535:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802538:	c1 e0 10             	shl    $0x10,%eax
  80253b:	09 c2                	or     %eax,%edx
  80253d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802540:	c1 e0 08             	shl    $0x8,%eax
  802543:	09 d0                	or     %edx,%eax
  802545:	09 45 f4             	or     %eax,-0xc(%rbp)
  802548:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80254c:	48 c1 e8 02          	shr    $0x2,%rax
  802550:	48 89 c1             	mov    %rax,%rcx
  802553:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802557:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80255a:	48 89 d7             	mov    %rdx,%rdi
  80255d:	fc                   	cld    
  80255e:	f3 ab                	rep stos %eax,%es:(%rdi)
  802560:	eb 11                	jmp    802573 <memset+0x85>
  802562:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802566:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802569:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80256d:	48 89 d7             	mov    %rdx,%rdi
  802570:	fc                   	cld    
  802571:	f3 aa                	rep stos %al,%es:(%rdi)
  802573:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802577:	c9                   	leaveq 
  802578:	c3                   	retq   

0000000000802579 <memmove>:
  802579:	55                   	push   %rbp
  80257a:	48 89 e5             	mov    %rsp,%rbp
  80257d:	48 83 ec 28          	sub    $0x28,%rsp
  802581:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802585:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802589:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80258d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802591:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802595:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802599:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80259d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025a1:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8025a5:	0f 83 88 00 00 00    	jae    802633 <memmove+0xba>
  8025ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025af:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8025b3:	48 01 d0             	add    %rdx,%rax
  8025b6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8025ba:	76 77                	jbe    802633 <memmove+0xba>
  8025bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025c0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8025c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025c8:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8025cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025d0:	83 e0 03             	and    $0x3,%eax
  8025d3:	48 85 c0             	test   %rax,%rax
  8025d6:	75 3b                	jne    802613 <memmove+0x9a>
  8025d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025dc:	83 e0 03             	and    $0x3,%eax
  8025df:	48 85 c0             	test   %rax,%rax
  8025e2:	75 2f                	jne    802613 <memmove+0x9a>
  8025e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025e8:	83 e0 03             	and    $0x3,%eax
  8025eb:	48 85 c0             	test   %rax,%rax
  8025ee:	75 23                	jne    802613 <memmove+0x9a>
  8025f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025f4:	48 83 e8 04          	sub    $0x4,%rax
  8025f8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8025fc:	48 83 ea 04          	sub    $0x4,%rdx
  802600:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  802604:	48 c1 e9 02          	shr    $0x2,%rcx
  802608:	48 89 c7             	mov    %rax,%rdi
  80260b:	48 89 d6             	mov    %rdx,%rsi
  80260e:	fd                   	std    
  80260f:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  802611:	eb 1d                	jmp    802630 <memmove+0xb7>
  802613:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802617:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80261b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80261f:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  802623:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802627:	48 89 d7             	mov    %rdx,%rdi
  80262a:	48 89 c1             	mov    %rax,%rcx
  80262d:	fd                   	std    
  80262e:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  802630:	fc                   	cld    
  802631:	eb 57                	jmp    80268a <memmove+0x111>
  802633:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802637:	83 e0 03             	and    $0x3,%eax
  80263a:	48 85 c0             	test   %rax,%rax
  80263d:	75 36                	jne    802675 <memmove+0xfc>
  80263f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802643:	83 e0 03             	and    $0x3,%eax
  802646:	48 85 c0             	test   %rax,%rax
  802649:	75 2a                	jne    802675 <memmove+0xfc>
  80264b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80264f:	83 e0 03             	and    $0x3,%eax
  802652:	48 85 c0             	test   %rax,%rax
  802655:	75 1e                	jne    802675 <memmove+0xfc>
  802657:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80265b:	48 c1 e8 02          	shr    $0x2,%rax
  80265f:	48 89 c1             	mov    %rax,%rcx
  802662:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802666:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80266a:	48 89 c7             	mov    %rax,%rdi
  80266d:	48 89 d6             	mov    %rdx,%rsi
  802670:	fc                   	cld    
  802671:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  802673:	eb 15                	jmp    80268a <memmove+0x111>
  802675:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802679:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80267d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  802681:	48 89 c7             	mov    %rax,%rdi
  802684:	48 89 d6             	mov    %rdx,%rsi
  802687:	fc                   	cld    
  802688:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80268a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80268e:	c9                   	leaveq 
  80268f:	c3                   	retq   

0000000000802690 <memcpy>:
  802690:	55                   	push   %rbp
  802691:	48 89 e5             	mov    %rsp,%rbp
  802694:	48 83 ec 18          	sub    $0x18,%rsp
  802698:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80269c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8026a0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8026a4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8026a8:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8026ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8026b0:	48 89 ce             	mov    %rcx,%rsi
  8026b3:	48 89 c7             	mov    %rax,%rdi
  8026b6:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  8026bd:	00 00 00 
  8026c0:	ff d0                	callq  *%rax
  8026c2:	c9                   	leaveq 
  8026c3:	c3                   	retq   

00000000008026c4 <memcmp>:
  8026c4:	55                   	push   %rbp
  8026c5:	48 89 e5             	mov    %rsp,%rbp
  8026c8:	48 83 ec 28          	sub    $0x28,%rsp
  8026cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8026d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8026d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8026d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8026e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8026e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8026e8:	eb 36                	jmp    802720 <memcmp+0x5c>
  8026ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8026ee:	0f b6 10             	movzbl (%rax),%edx
  8026f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8026f5:	0f b6 00             	movzbl (%rax),%eax
  8026f8:	38 c2                	cmp    %al,%dl
  8026fa:	74 1a                	je     802716 <memcmp+0x52>
  8026fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802700:	0f b6 00             	movzbl (%rax),%eax
  802703:	0f b6 d0             	movzbl %al,%edx
  802706:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80270a:	0f b6 00             	movzbl (%rax),%eax
  80270d:	0f b6 c0             	movzbl %al,%eax
  802710:	29 c2                	sub    %eax,%edx
  802712:	89 d0                	mov    %edx,%eax
  802714:	eb 20                	jmp    802736 <memcmp+0x72>
  802716:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80271b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  802720:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802724:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  802728:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80272c:	48 85 c0             	test   %rax,%rax
  80272f:	75 b9                	jne    8026ea <memcmp+0x26>
  802731:	b8 00 00 00 00       	mov    $0x0,%eax
  802736:	c9                   	leaveq 
  802737:	c3                   	retq   

0000000000802738 <memfind>:
  802738:	55                   	push   %rbp
  802739:	48 89 e5             	mov    %rsp,%rbp
  80273c:	48 83 ec 28          	sub    $0x28,%rsp
  802740:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802744:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802747:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80274b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80274f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802753:	48 01 d0             	add    %rdx,%rax
  802756:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80275a:	eb 15                	jmp    802771 <memfind+0x39>
  80275c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802760:	0f b6 10             	movzbl (%rax),%edx
  802763:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802766:	38 c2                	cmp    %al,%dl
  802768:	75 02                	jne    80276c <memfind+0x34>
  80276a:	eb 0f                	jmp    80277b <memfind+0x43>
  80276c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  802771:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802775:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  802779:	72 e1                	jb     80275c <memfind+0x24>
  80277b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80277f:	c9                   	leaveq 
  802780:	c3                   	retq   

0000000000802781 <strtol>:
  802781:	55                   	push   %rbp
  802782:	48 89 e5             	mov    %rsp,%rbp
  802785:	48 83 ec 34          	sub    $0x34,%rsp
  802789:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80278d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802791:	89 55 cc             	mov    %edx,-0x34(%rbp)
  802794:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80279b:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8027a2:	00 
  8027a3:	eb 05                	jmp    8027aa <strtol+0x29>
  8027a5:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8027aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027ae:	0f b6 00             	movzbl (%rax),%eax
  8027b1:	3c 20                	cmp    $0x20,%al
  8027b3:	74 f0                	je     8027a5 <strtol+0x24>
  8027b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027b9:	0f b6 00             	movzbl (%rax),%eax
  8027bc:	3c 09                	cmp    $0x9,%al
  8027be:	74 e5                	je     8027a5 <strtol+0x24>
  8027c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027c4:	0f b6 00             	movzbl (%rax),%eax
  8027c7:	3c 2b                	cmp    $0x2b,%al
  8027c9:	75 07                	jne    8027d2 <strtol+0x51>
  8027cb:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8027d0:	eb 17                	jmp    8027e9 <strtol+0x68>
  8027d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027d6:	0f b6 00             	movzbl (%rax),%eax
  8027d9:	3c 2d                	cmp    $0x2d,%al
  8027db:	75 0c                	jne    8027e9 <strtol+0x68>
  8027dd:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8027e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8027e9:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8027ed:	74 06                	je     8027f5 <strtol+0x74>
  8027ef:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8027f3:	75 28                	jne    80281d <strtol+0x9c>
  8027f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027f9:	0f b6 00             	movzbl (%rax),%eax
  8027fc:	3c 30                	cmp    $0x30,%al
  8027fe:	75 1d                	jne    80281d <strtol+0x9c>
  802800:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802804:	48 83 c0 01          	add    $0x1,%rax
  802808:	0f b6 00             	movzbl (%rax),%eax
  80280b:	3c 78                	cmp    $0x78,%al
  80280d:	75 0e                	jne    80281d <strtol+0x9c>
  80280f:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  802814:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  80281b:	eb 2c                	jmp    802849 <strtol+0xc8>
  80281d:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  802821:	75 19                	jne    80283c <strtol+0xbb>
  802823:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802827:	0f b6 00             	movzbl (%rax),%eax
  80282a:	3c 30                	cmp    $0x30,%al
  80282c:	75 0e                	jne    80283c <strtol+0xbb>
  80282e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  802833:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  80283a:	eb 0d                	jmp    802849 <strtol+0xc8>
  80283c:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  802840:	75 07                	jne    802849 <strtol+0xc8>
  802842:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  802849:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80284d:	0f b6 00             	movzbl (%rax),%eax
  802850:	3c 2f                	cmp    $0x2f,%al
  802852:	7e 1d                	jle    802871 <strtol+0xf0>
  802854:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802858:	0f b6 00             	movzbl (%rax),%eax
  80285b:	3c 39                	cmp    $0x39,%al
  80285d:	7f 12                	jg     802871 <strtol+0xf0>
  80285f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802863:	0f b6 00             	movzbl (%rax),%eax
  802866:	0f be c0             	movsbl %al,%eax
  802869:	83 e8 30             	sub    $0x30,%eax
  80286c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80286f:	eb 4e                	jmp    8028bf <strtol+0x13e>
  802871:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802875:	0f b6 00             	movzbl (%rax),%eax
  802878:	3c 60                	cmp    $0x60,%al
  80287a:	7e 1d                	jle    802899 <strtol+0x118>
  80287c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802880:	0f b6 00             	movzbl (%rax),%eax
  802883:	3c 7a                	cmp    $0x7a,%al
  802885:	7f 12                	jg     802899 <strtol+0x118>
  802887:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80288b:	0f b6 00             	movzbl (%rax),%eax
  80288e:	0f be c0             	movsbl %al,%eax
  802891:	83 e8 57             	sub    $0x57,%eax
  802894:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802897:	eb 26                	jmp    8028bf <strtol+0x13e>
  802899:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80289d:	0f b6 00             	movzbl (%rax),%eax
  8028a0:	3c 40                	cmp    $0x40,%al
  8028a2:	7e 48                	jle    8028ec <strtol+0x16b>
  8028a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028a8:	0f b6 00             	movzbl (%rax),%eax
  8028ab:	3c 5a                	cmp    $0x5a,%al
  8028ad:	7f 3d                	jg     8028ec <strtol+0x16b>
  8028af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028b3:	0f b6 00             	movzbl (%rax),%eax
  8028b6:	0f be c0             	movsbl %al,%eax
  8028b9:	83 e8 37             	sub    $0x37,%eax
  8028bc:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8028bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028c2:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  8028c5:	7c 02                	jl     8028c9 <strtol+0x148>
  8028c7:	eb 23                	jmp    8028ec <strtol+0x16b>
  8028c9:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8028ce:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8028d1:	48 98                	cltq   
  8028d3:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8028d8:	48 89 c2             	mov    %rax,%rdx
  8028db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028de:	48 98                	cltq   
  8028e0:	48 01 d0             	add    %rdx,%rax
  8028e3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8028e7:	e9 5d ff ff ff       	jmpq   802849 <strtol+0xc8>
  8028ec:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8028f1:	74 0b                	je     8028fe <strtol+0x17d>
  8028f3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8028f7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8028fb:	48 89 10             	mov    %rdx,(%rax)
  8028fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802902:	74 09                	je     80290d <strtol+0x18c>
  802904:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802908:	48 f7 d8             	neg    %rax
  80290b:	eb 04                	jmp    802911 <strtol+0x190>
  80290d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802911:	c9                   	leaveq 
  802912:	c3                   	retq   

0000000000802913 <strstr>:
  802913:	55                   	push   %rbp
  802914:	48 89 e5             	mov    %rsp,%rbp
  802917:	48 83 ec 30          	sub    $0x30,%rsp
  80291b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80291f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802923:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802927:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80292b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80292f:	0f b6 00             	movzbl (%rax),%eax
  802932:	88 45 ff             	mov    %al,-0x1(%rbp)
  802935:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  802939:	75 06                	jne    802941 <strstr+0x2e>
  80293b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80293f:	eb 6b                	jmp    8029ac <strstr+0x99>
  802941:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802945:	48 89 c7             	mov    %rax,%rdi
  802948:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  80294f:	00 00 00 
  802952:	ff d0                	callq  *%rax
  802954:	48 98                	cltq   
  802956:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80295a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80295e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802962:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802966:	0f b6 00             	movzbl (%rax),%eax
  802969:	88 45 ef             	mov    %al,-0x11(%rbp)
  80296c:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  802970:	75 07                	jne    802979 <strstr+0x66>
  802972:	b8 00 00 00 00       	mov    $0x0,%eax
  802977:	eb 33                	jmp    8029ac <strstr+0x99>
  802979:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80297d:	3a 45 ff             	cmp    -0x1(%rbp),%al
  802980:	75 d8                	jne    80295a <strstr+0x47>
  802982:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802986:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  80298a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80298e:	48 89 ce             	mov    %rcx,%rsi
  802991:	48 89 c7             	mov    %rax,%rdi
  802994:	48 b8 0a 24 80 00 00 	movabs $0x80240a,%rax
  80299b:	00 00 00 
  80299e:	ff d0                	callq  *%rax
  8029a0:	85 c0                	test   %eax,%eax
  8029a2:	75 b6                	jne    80295a <strstr+0x47>
  8029a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029a8:	48 83 e8 01          	sub    $0x1,%rax
  8029ac:	c9                   	leaveq 
  8029ad:	c3                   	retq   

00000000008029ae <syscall>:
  8029ae:	55                   	push   %rbp
  8029af:	48 89 e5             	mov    %rsp,%rbp
  8029b2:	53                   	push   %rbx
  8029b3:	48 83 ec 48          	sub    $0x48,%rsp
  8029b7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8029ba:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8029bd:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8029c1:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  8029c5:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8029c9:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  8029cd:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8029d0:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8029d4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8029d8:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8029dc:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8029e0:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8029e4:	4c 89 c3             	mov    %r8,%rbx
  8029e7:	cd 30                	int    $0x30
  8029e9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8029ed:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8029f1:	74 3e                	je     802a31 <syscall+0x83>
  8029f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8029f8:	7e 37                	jle    802a31 <syscall+0x83>
  8029fa:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8029fe:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a01:	49 89 d0             	mov    %rdx,%r8
  802a04:	89 c1                	mov    %eax,%ecx
  802a06:	48 ba db 70 80 00 00 	movabs $0x8070db,%rdx
  802a0d:	00 00 00 
  802a10:	be 24 00 00 00       	mov    $0x24,%esi
  802a15:	48 bf f8 70 80 00 00 	movabs $0x8070f8,%rdi
  802a1c:	00 00 00 
  802a1f:	b8 00 00 00 00       	mov    $0x0,%eax
  802a24:	49 b9 0d 13 80 00 00 	movabs $0x80130d,%r9
  802a2b:	00 00 00 
  802a2e:	41 ff d1             	callq  *%r9
  802a31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a35:	48 83 c4 48          	add    $0x48,%rsp
  802a39:	5b                   	pop    %rbx
  802a3a:	5d                   	pop    %rbp
  802a3b:	c3                   	retq   

0000000000802a3c <sys_cputs>:
  802a3c:	55                   	push   %rbp
  802a3d:	48 89 e5             	mov    %rsp,%rbp
  802a40:	48 83 ec 20          	sub    $0x20,%rsp
  802a44:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a48:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a54:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802a5b:	00 
  802a5c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802a62:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802a68:	48 89 d1             	mov    %rdx,%rcx
  802a6b:	48 89 c2             	mov    %rax,%rdx
  802a6e:	be 00 00 00 00       	mov    $0x0,%esi
  802a73:	bf 00 00 00 00       	mov    $0x0,%edi
  802a78:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802a7f:	00 00 00 
  802a82:	ff d0                	callq  *%rax
  802a84:	c9                   	leaveq 
  802a85:	c3                   	retq   

0000000000802a86 <sys_cgetc>:
  802a86:	55                   	push   %rbp
  802a87:	48 89 e5             	mov    %rsp,%rbp
  802a8a:	48 83 ec 10          	sub    $0x10,%rsp
  802a8e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802a95:	00 
  802a96:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802a9c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802aa2:	b9 00 00 00 00       	mov    $0x0,%ecx
  802aa7:	ba 00 00 00 00       	mov    $0x0,%edx
  802aac:	be 00 00 00 00       	mov    $0x0,%esi
  802ab1:	bf 01 00 00 00       	mov    $0x1,%edi
  802ab6:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802abd:	00 00 00 
  802ac0:	ff d0                	callq  *%rax
  802ac2:	c9                   	leaveq 
  802ac3:	c3                   	retq   

0000000000802ac4 <sys_env_destroy>:
  802ac4:	55                   	push   %rbp
  802ac5:	48 89 e5             	mov    %rsp,%rbp
  802ac8:	48 83 ec 10          	sub    $0x10,%rsp
  802acc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802acf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ad2:	48 98                	cltq   
  802ad4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802adb:	00 
  802adc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802ae2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802ae8:	b9 00 00 00 00       	mov    $0x0,%ecx
  802aed:	48 89 c2             	mov    %rax,%rdx
  802af0:	be 01 00 00 00       	mov    $0x1,%esi
  802af5:	bf 03 00 00 00       	mov    $0x3,%edi
  802afa:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802b01:	00 00 00 
  802b04:	ff d0                	callq  *%rax
  802b06:	c9                   	leaveq 
  802b07:	c3                   	retq   

0000000000802b08 <sys_getenvid>:
  802b08:	55                   	push   %rbp
  802b09:	48 89 e5             	mov    %rsp,%rbp
  802b0c:	48 83 ec 10          	sub    $0x10,%rsp
  802b10:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802b17:	00 
  802b18:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802b1e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802b24:	b9 00 00 00 00       	mov    $0x0,%ecx
  802b29:	ba 00 00 00 00       	mov    $0x0,%edx
  802b2e:	be 00 00 00 00       	mov    $0x0,%esi
  802b33:	bf 02 00 00 00       	mov    $0x2,%edi
  802b38:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802b3f:	00 00 00 
  802b42:	ff d0                	callq  *%rax
  802b44:	c9                   	leaveq 
  802b45:	c3                   	retq   

0000000000802b46 <sys_yield>:
  802b46:	55                   	push   %rbp
  802b47:	48 89 e5             	mov    %rsp,%rbp
  802b4a:	48 83 ec 10          	sub    $0x10,%rsp
  802b4e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802b55:	00 
  802b56:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802b5c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802b62:	b9 00 00 00 00       	mov    $0x0,%ecx
  802b67:	ba 00 00 00 00       	mov    $0x0,%edx
  802b6c:	be 00 00 00 00       	mov    $0x0,%esi
  802b71:	bf 0b 00 00 00       	mov    $0xb,%edi
  802b76:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802b7d:	00 00 00 
  802b80:	ff d0                	callq  *%rax
  802b82:	c9                   	leaveq 
  802b83:	c3                   	retq   

0000000000802b84 <sys_page_alloc>:
  802b84:	55                   	push   %rbp
  802b85:	48 89 e5             	mov    %rsp,%rbp
  802b88:	48 83 ec 20          	sub    $0x20,%rsp
  802b8c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802b8f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802b93:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802b96:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b99:	48 63 c8             	movslq %eax,%rcx
  802b9c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802ba0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ba3:	48 98                	cltq   
  802ba5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802bac:	00 
  802bad:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802bb3:	49 89 c8             	mov    %rcx,%r8
  802bb6:	48 89 d1             	mov    %rdx,%rcx
  802bb9:	48 89 c2             	mov    %rax,%rdx
  802bbc:	be 01 00 00 00       	mov    $0x1,%esi
  802bc1:	bf 04 00 00 00       	mov    $0x4,%edi
  802bc6:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802bcd:	00 00 00 
  802bd0:	ff d0                	callq  *%rax
  802bd2:	c9                   	leaveq 
  802bd3:	c3                   	retq   

0000000000802bd4 <sys_page_map>:
  802bd4:	55                   	push   %rbp
  802bd5:	48 89 e5             	mov    %rsp,%rbp
  802bd8:	48 83 ec 30          	sub    $0x30,%rsp
  802bdc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802bdf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802be3:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802be6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  802bea:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802bee:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802bf1:	48 63 c8             	movslq %eax,%rcx
  802bf4:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  802bf8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bfb:	48 63 f0             	movslq %eax,%rsi
  802bfe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c05:	48 98                	cltq   
  802c07:	48 89 0c 24          	mov    %rcx,(%rsp)
  802c0b:	49 89 f9             	mov    %rdi,%r9
  802c0e:	49 89 f0             	mov    %rsi,%r8
  802c11:	48 89 d1             	mov    %rdx,%rcx
  802c14:	48 89 c2             	mov    %rax,%rdx
  802c17:	be 01 00 00 00       	mov    $0x1,%esi
  802c1c:	bf 05 00 00 00       	mov    $0x5,%edi
  802c21:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802c28:	00 00 00 
  802c2b:	ff d0                	callq  *%rax
  802c2d:	c9                   	leaveq 
  802c2e:	c3                   	retq   

0000000000802c2f <sys_page_unmap>:
  802c2f:	55                   	push   %rbp
  802c30:	48 89 e5             	mov    %rsp,%rbp
  802c33:	48 83 ec 20          	sub    $0x20,%rsp
  802c37:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802c3a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802c3e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c42:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c45:	48 98                	cltq   
  802c47:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802c4e:	00 
  802c4f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802c55:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802c5b:	48 89 d1             	mov    %rdx,%rcx
  802c5e:	48 89 c2             	mov    %rax,%rdx
  802c61:	be 01 00 00 00       	mov    $0x1,%esi
  802c66:	bf 06 00 00 00       	mov    $0x6,%edi
  802c6b:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802c72:	00 00 00 
  802c75:	ff d0                	callq  *%rax
  802c77:	c9                   	leaveq 
  802c78:	c3                   	retq   

0000000000802c79 <sys_env_set_status>:
  802c79:	55                   	push   %rbp
  802c7a:	48 89 e5             	mov    %rsp,%rbp
  802c7d:	48 83 ec 10          	sub    $0x10,%rsp
  802c81:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802c84:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802c87:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c8a:	48 63 d0             	movslq %eax,%rdx
  802c8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c90:	48 98                	cltq   
  802c92:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802c99:	00 
  802c9a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802ca0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802ca6:	48 89 d1             	mov    %rdx,%rcx
  802ca9:	48 89 c2             	mov    %rax,%rdx
  802cac:	be 01 00 00 00       	mov    $0x1,%esi
  802cb1:	bf 08 00 00 00       	mov    $0x8,%edi
  802cb6:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802cbd:	00 00 00 
  802cc0:	ff d0                	callq  *%rax
  802cc2:	c9                   	leaveq 
  802cc3:	c3                   	retq   

0000000000802cc4 <sys_env_set_trapframe>:
  802cc4:	55                   	push   %rbp
  802cc5:	48 89 e5             	mov    %rsp,%rbp
  802cc8:	48 83 ec 20          	sub    $0x20,%rsp
  802ccc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802ccf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802cd3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802cd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cda:	48 98                	cltq   
  802cdc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802ce3:	00 
  802ce4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802cea:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802cf0:	48 89 d1             	mov    %rdx,%rcx
  802cf3:	48 89 c2             	mov    %rax,%rdx
  802cf6:	be 01 00 00 00       	mov    $0x1,%esi
  802cfb:	bf 09 00 00 00       	mov    $0x9,%edi
  802d00:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802d07:	00 00 00 
  802d0a:	ff d0                	callq  *%rax
  802d0c:	c9                   	leaveq 
  802d0d:	c3                   	retq   

0000000000802d0e <sys_env_set_pgfault_upcall>:
  802d0e:	55                   	push   %rbp
  802d0f:	48 89 e5             	mov    %rsp,%rbp
  802d12:	48 83 ec 20          	sub    $0x20,%rsp
  802d16:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802d19:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802d1d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802d21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d24:	48 98                	cltq   
  802d26:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802d2d:	00 
  802d2e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802d34:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802d3a:	48 89 d1             	mov    %rdx,%rcx
  802d3d:	48 89 c2             	mov    %rax,%rdx
  802d40:	be 01 00 00 00       	mov    $0x1,%esi
  802d45:	bf 0a 00 00 00       	mov    $0xa,%edi
  802d4a:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802d51:	00 00 00 
  802d54:	ff d0                	callq  *%rax
  802d56:	c9                   	leaveq 
  802d57:	c3                   	retq   

0000000000802d58 <sys_ipc_try_send>:
  802d58:	55                   	push   %rbp
  802d59:	48 89 e5             	mov    %rsp,%rbp
  802d5c:	48 83 ec 20          	sub    $0x20,%rsp
  802d60:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802d63:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802d67:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802d6b:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  802d6e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d71:	48 63 f0             	movslq %eax,%rsi
  802d74:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802d78:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d7b:	48 98                	cltq   
  802d7d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802d81:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802d88:	00 
  802d89:	49 89 f1             	mov    %rsi,%r9
  802d8c:	49 89 c8             	mov    %rcx,%r8
  802d8f:	48 89 d1             	mov    %rdx,%rcx
  802d92:	48 89 c2             	mov    %rax,%rdx
  802d95:	be 00 00 00 00       	mov    $0x0,%esi
  802d9a:	bf 0c 00 00 00       	mov    $0xc,%edi
  802d9f:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802da6:	00 00 00 
  802da9:	ff d0                	callq  *%rax
  802dab:	c9                   	leaveq 
  802dac:	c3                   	retq   

0000000000802dad <sys_ipc_recv>:
  802dad:	55                   	push   %rbp
  802dae:	48 89 e5             	mov    %rsp,%rbp
  802db1:	48 83 ec 10          	sub    $0x10,%rsp
  802db5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802db9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802dbd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802dc4:	00 
  802dc5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802dcb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802dd1:	b9 00 00 00 00       	mov    $0x0,%ecx
  802dd6:	48 89 c2             	mov    %rax,%rdx
  802dd9:	be 01 00 00 00       	mov    $0x1,%esi
  802dde:	bf 0d 00 00 00       	mov    $0xd,%edi
  802de3:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802dea:	00 00 00 
  802ded:	ff d0                	callq  *%rax
  802def:	c9                   	leaveq 
  802df0:	c3                   	retq   

0000000000802df1 <sys_time_msec>:
  802df1:	55                   	push   %rbp
  802df2:	48 89 e5             	mov    %rsp,%rbp
  802df5:	48 83 ec 10          	sub    $0x10,%rsp
  802df9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802e00:	00 
  802e01:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802e07:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802e0d:	b9 00 00 00 00       	mov    $0x0,%ecx
  802e12:	ba 00 00 00 00       	mov    $0x0,%edx
  802e17:	be 00 00 00 00       	mov    $0x0,%esi
  802e1c:	bf 0e 00 00 00       	mov    $0xe,%edi
  802e21:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802e28:	00 00 00 
  802e2b:	ff d0                	callq  *%rax
  802e2d:	c9                   	leaveq 
  802e2e:	c3                   	retq   

0000000000802e2f <sys_net_transmit>:
  802e2f:	55                   	push   %rbp
  802e30:	48 89 e5             	mov    %rsp,%rbp
  802e33:	48 83 ec 20          	sub    $0x20,%rsp
  802e37:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e3b:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802e3e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e45:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802e4c:	00 
  802e4d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802e53:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802e59:	48 89 d1             	mov    %rdx,%rcx
  802e5c:	48 89 c2             	mov    %rax,%rdx
  802e5f:	be 00 00 00 00       	mov    $0x0,%esi
  802e64:	bf 0f 00 00 00       	mov    $0xf,%edi
  802e69:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802e70:	00 00 00 
  802e73:	ff d0                	callq  *%rax
  802e75:	c9                   	leaveq 
  802e76:	c3                   	retq   

0000000000802e77 <sys_net_receive>:
  802e77:	55                   	push   %rbp
  802e78:	48 89 e5             	mov    %rsp,%rbp
  802e7b:	48 83 ec 20          	sub    $0x20,%rsp
  802e7f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e83:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802e86:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e8d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802e94:	00 
  802e95:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802e9b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802ea1:	48 89 d1             	mov    %rdx,%rcx
  802ea4:	48 89 c2             	mov    %rax,%rdx
  802ea7:	be 00 00 00 00       	mov    $0x0,%esi
  802eac:	bf 10 00 00 00       	mov    $0x10,%edi
  802eb1:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802eb8:	00 00 00 
  802ebb:	ff d0                	callq  *%rax
  802ebd:	c9                   	leaveq 
  802ebe:	c3                   	retq   

0000000000802ebf <sys_ept_map>:
  802ebf:	55                   	push   %rbp
  802ec0:	48 89 e5             	mov    %rsp,%rbp
  802ec3:	48 83 ec 30          	sub    $0x30,%rsp
  802ec7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802eca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802ece:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802ed1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  802ed5:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802ed9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802edc:	48 63 c8             	movslq %eax,%rcx
  802edf:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  802ee3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802ee6:	48 63 f0             	movslq %eax,%rsi
  802ee9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802eed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ef0:	48 98                	cltq   
  802ef2:	48 89 0c 24          	mov    %rcx,(%rsp)
  802ef6:	49 89 f9             	mov    %rdi,%r9
  802ef9:	49 89 f0             	mov    %rsi,%r8
  802efc:	48 89 d1             	mov    %rdx,%rcx
  802eff:	48 89 c2             	mov    %rax,%rdx
  802f02:	be 00 00 00 00       	mov    $0x0,%esi
  802f07:	bf 11 00 00 00       	mov    $0x11,%edi
  802f0c:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802f13:	00 00 00 
  802f16:	ff d0                	callq  *%rax
  802f18:	c9                   	leaveq 
  802f19:	c3                   	retq   

0000000000802f1a <sys_env_mkguest>:
  802f1a:	55                   	push   %rbp
  802f1b:	48 89 e5             	mov    %rsp,%rbp
  802f1e:	48 83 ec 20          	sub    $0x20,%rsp
  802f22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802f26:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802f2a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802f2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f32:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802f39:	00 
  802f3a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802f40:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802f46:	48 89 d1             	mov    %rdx,%rcx
  802f49:	48 89 c2             	mov    %rax,%rdx
  802f4c:	be 00 00 00 00       	mov    $0x0,%esi
  802f51:	bf 12 00 00 00       	mov    $0x12,%edi
  802f56:	48 b8 ae 29 80 00 00 	movabs $0x8029ae,%rax
  802f5d:	00 00 00 
  802f60:	ff d0                	callq  *%rax
  802f62:	c9                   	leaveq 
  802f63:	c3                   	retq   

0000000000802f64 <pgfault>:
  802f64:	55                   	push   %rbp
  802f65:	48 89 e5             	mov    %rsp,%rbp
  802f68:	48 83 ec 30          	sub    $0x30,%rsp
  802f6c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802f70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802f74:	48 8b 00             	mov    (%rax),%rax
  802f77:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802f7b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802f7f:	48 8b 40 08          	mov    0x8(%rax),%rax
  802f83:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f86:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f89:	83 e0 02             	and    $0x2,%eax
  802f8c:	85 c0                	test   %eax,%eax
  802f8e:	75 40                	jne    802fd0 <pgfault+0x6c>
  802f90:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802f94:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  802f9b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f9f:	49 89 d0             	mov    %rdx,%r8
  802fa2:	48 89 c1             	mov    %rax,%rcx
  802fa5:	48 ba 10 71 80 00 00 	movabs $0x807110,%rdx
  802fac:	00 00 00 
  802faf:	be 1f 00 00 00       	mov    $0x1f,%esi
  802fb4:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  802fbb:	00 00 00 
  802fbe:	b8 00 00 00 00       	mov    $0x0,%eax
  802fc3:	49 b9 0d 13 80 00 00 	movabs $0x80130d,%r9
  802fca:	00 00 00 
  802fcd:	41 ff d1             	callq  *%r9
  802fd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fd4:	48 c1 e8 0c          	shr    $0xc,%rax
  802fd8:	48 89 c2             	mov    %rax,%rdx
  802fdb:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802fe2:	01 00 00 
  802fe5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802fe9:	25 07 08 00 00       	and    $0x807,%eax
  802fee:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  802ff4:	74 4e                	je     803044 <pgfault+0xe0>
  802ff6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ffa:	48 c1 e8 0c          	shr    $0xc,%rax
  802ffe:	48 89 c2             	mov    %rax,%rdx
  803001:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803008:	01 00 00 
  80300b:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80300f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803013:	49 89 d0             	mov    %rdx,%r8
  803016:	48 89 c1             	mov    %rax,%rcx
  803019:	48 ba 38 71 80 00 00 	movabs $0x807138,%rdx
  803020:	00 00 00 
  803023:	be 22 00 00 00       	mov    $0x22,%esi
  803028:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  80302f:	00 00 00 
  803032:	b8 00 00 00 00       	mov    $0x0,%eax
  803037:	49 b9 0d 13 80 00 00 	movabs $0x80130d,%r9
  80303e:	00 00 00 
  803041:	41 ff d1             	callq  *%r9
  803044:	ba 07 00 00 00       	mov    $0x7,%edx
  803049:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  80304e:	bf 00 00 00 00       	mov    $0x0,%edi
  803053:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  80305a:	00 00 00 
  80305d:	ff d0                	callq  *%rax
  80305f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803062:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803066:	79 30                	jns    803098 <pgfault+0x134>
  803068:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80306b:	89 c1                	mov    %eax,%ecx
  80306d:	48 ba 63 71 80 00 00 	movabs $0x807163,%rdx
  803074:	00 00 00 
  803077:	be 30 00 00 00       	mov    $0x30,%esi
  80307c:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  803083:	00 00 00 
  803086:	b8 00 00 00 00       	mov    $0x0,%eax
  80308b:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  803092:	00 00 00 
  803095:	41 ff d0             	callq  *%r8
  803098:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80309c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8030a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8030a4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8030aa:	ba 00 10 00 00       	mov    $0x1000,%edx
  8030af:	48 89 c6             	mov    %rax,%rsi
  8030b2:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  8030b7:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  8030be:	00 00 00 
  8030c1:	ff d0                	callq  *%rax
  8030c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8030c7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8030cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030cf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8030d5:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  8030db:	48 89 c1             	mov    %rax,%rcx
  8030de:	ba 00 00 00 00       	mov    $0x0,%edx
  8030e3:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8030e8:	bf 00 00 00 00       	mov    $0x0,%edi
  8030ed:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  8030f4:	00 00 00 
  8030f7:	ff d0                	callq  *%rax
  8030f9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8030fc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803100:	79 30                	jns    803132 <pgfault+0x1ce>
  803102:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803105:	89 c1                	mov    %eax,%ecx
  803107:	48 ba 76 71 80 00 00 	movabs $0x807176,%rdx
  80310e:	00 00 00 
  803111:	be 35 00 00 00       	mov    $0x35,%esi
  803116:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  80311d:	00 00 00 
  803120:	b8 00 00 00 00       	mov    $0x0,%eax
  803125:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80312c:	00 00 00 
  80312f:	41 ff d0             	callq  *%r8
  803132:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  803137:	bf 00 00 00 00       	mov    $0x0,%edi
  80313c:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  803143:	00 00 00 
  803146:	ff d0                	callq  *%rax
  803148:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80314b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80314f:	79 30                	jns    803181 <pgfault+0x21d>
  803151:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803154:	89 c1                	mov    %eax,%ecx
  803156:	48 ba 87 71 80 00 00 	movabs $0x807187,%rdx
  80315d:	00 00 00 
  803160:	be 39 00 00 00       	mov    $0x39,%esi
  803165:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  80316c:	00 00 00 
  80316f:	b8 00 00 00 00       	mov    $0x0,%eax
  803174:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80317b:	00 00 00 
  80317e:	41 ff d0             	callq  *%r8
  803181:	c9                   	leaveq 
  803182:	c3                   	retq   

0000000000803183 <duppage>:
  803183:	55                   	push   %rbp
  803184:	48 89 e5             	mov    %rsp,%rbp
  803187:	48 83 ec 30          	sub    $0x30,%rsp
  80318b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80318e:	89 75 d8             	mov    %esi,-0x28(%rbp)
  803191:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803194:	c1 e0 0c             	shl    $0xc,%eax
  803197:	89 c0                	mov    %eax,%eax
  803199:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80319d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8031a4:	01 00 00 
  8031a7:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8031aa:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8031ae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8031b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031b6:	25 02 08 00 00       	and    $0x802,%eax
  8031bb:	48 85 c0             	test   %rax,%rax
  8031be:	74 0e                	je     8031ce <duppage+0x4b>
  8031c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031c4:	25 00 04 00 00       	and    $0x400,%eax
  8031c9:	48 85 c0             	test   %rax,%rax
  8031cc:	74 70                	je     80323e <duppage+0xbb>
  8031ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031d2:	25 07 0e 00 00       	and    $0xe07,%eax
  8031d7:	89 c6                	mov    %eax,%esi
  8031d9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8031dd:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8031e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8031e4:	41 89 f0             	mov    %esi,%r8d
  8031e7:	48 89 c6             	mov    %rax,%rsi
  8031ea:	bf 00 00 00 00       	mov    $0x0,%edi
  8031ef:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  8031f6:	00 00 00 
  8031f9:	ff d0                	callq  *%rax
  8031fb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8031fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803202:	79 30                	jns    803234 <duppage+0xb1>
  803204:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803207:	89 c1                	mov    %eax,%ecx
  803209:	48 ba 76 71 80 00 00 	movabs $0x807176,%rdx
  803210:	00 00 00 
  803213:	be 63 00 00 00       	mov    $0x63,%esi
  803218:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  80321f:	00 00 00 
  803222:	b8 00 00 00 00       	mov    $0x0,%eax
  803227:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80322e:	00 00 00 
  803231:	41 ff d0             	callq  *%r8
  803234:	b8 00 00 00 00       	mov    $0x0,%eax
  803239:	e9 c4 00 00 00       	jmpq   803302 <duppage+0x17f>
  80323e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  803242:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803249:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  80324f:	48 89 c6             	mov    %rax,%rsi
  803252:	bf 00 00 00 00       	mov    $0x0,%edi
  803257:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  80325e:	00 00 00 
  803261:	ff d0                	callq  *%rax
  803263:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803266:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80326a:	79 30                	jns    80329c <duppage+0x119>
  80326c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80326f:	89 c1                	mov    %eax,%ecx
  803271:	48 ba 76 71 80 00 00 	movabs $0x807176,%rdx
  803278:	00 00 00 
  80327b:	be 7e 00 00 00       	mov    $0x7e,%esi
  803280:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  803287:	00 00 00 
  80328a:	b8 00 00 00 00       	mov    $0x0,%eax
  80328f:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  803296:	00 00 00 
  803299:	41 ff d0             	callq  *%r8
  80329c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8032a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032a4:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8032aa:	48 89 d1             	mov    %rdx,%rcx
  8032ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8032b2:	48 89 c6             	mov    %rax,%rsi
  8032b5:	bf 00 00 00 00       	mov    $0x0,%edi
  8032ba:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  8032c1:	00 00 00 
  8032c4:	ff d0                	callq  *%rax
  8032c6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8032c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8032cd:	79 30                	jns    8032ff <duppage+0x17c>
  8032cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8032d2:	89 c1                	mov    %eax,%ecx
  8032d4:	48 ba 76 71 80 00 00 	movabs $0x807176,%rdx
  8032db:	00 00 00 
  8032de:	be 80 00 00 00       	mov    $0x80,%esi
  8032e3:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  8032ea:	00 00 00 
  8032ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8032f2:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8032f9:	00 00 00 
  8032fc:	41 ff d0             	callq  *%r8
  8032ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803302:	c9                   	leaveq 
  803303:	c3                   	retq   

0000000000803304 <fork>:
  803304:	55                   	push   %rbp
  803305:	48 89 e5             	mov    %rsp,%rbp
  803308:	48 83 ec 20          	sub    $0x20,%rsp
  80330c:	48 bf 64 2f 80 00 00 	movabs $0x802f64,%rdi
  803313:	00 00 00 
  803316:	48 b8 61 65 80 00 00 	movabs $0x806561,%rax
  80331d:	00 00 00 
  803320:	ff d0                	callq  *%rax
  803322:	b8 07 00 00 00       	mov    $0x7,%eax
  803327:	cd 30                	int    $0x30
  803329:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80332c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80332f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803332:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803336:	79 08                	jns    803340 <fork+0x3c>
  803338:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80333b:	e9 09 02 00 00       	jmpq   803549 <fork+0x245>
  803340:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803344:	75 3e                	jne    803384 <fork+0x80>
  803346:	48 b8 08 2b 80 00 00 	movabs $0x802b08,%rax
  80334d:	00 00 00 
  803350:	ff d0                	callq  *%rax
  803352:	25 ff 03 00 00       	and    $0x3ff,%eax
  803357:	48 98                	cltq   
  803359:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  803360:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803367:	00 00 00 
  80336a:	48 01 c2             	add    %rax,%rdx
  80336d:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  803374:	00 00 00 
  803377:	48 89 10             	mov    %rdx,(%rax)
  80337a:	b8 00 00 00 00       	mov    $0x0,%eax
  80337f:	e9 c5 01 00 00       	jmpq   803549 <fork+0x245>
  803384:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80338b:	e9 a4 00 00 00       	jmpq   803434 <fork+0x130>
  803390:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803393:	c1 f8 12             	sar    $0x12,%eax
  803396:	89 c2                	mov    %eax,%edx
  803398:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  80339f:	01 00 00 
  8033a2:	48 63 d2             	movslq %edx,%rdx
  8033a5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8033a9:	83 e0 01             	and    $0x1,%eax
  8033ac:	48 85 c0             	test   %rax,%rax
  8033af:	74 21                	je     8033d2 <fork+0xce>
  8033b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033b4:	c1 f8 09             	sar    $0x9,%eax
  8033b7:	89 c2                	mov    %eax,%edx
  8033b9:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8033c0:	01 00 00 
  8033c3:	48 63 d2             	movslq %edx,%rdx
  8033c6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8033ca:	83 e0 01             	and    $0x1,%eax
  8033cd:	48 85 c0             	test   %rax,%rax
  8033d0:	75 09                	jne    8033db <fork+0xd7>
  8033d2:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  8033d9:	eb 59                	jmp    803434 <fork+0x130>
  8033db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033de:	05 00 02 00 00       	add    $0x200,%eax
  8033e3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8033e6:	eb 44                	jmp    80342c <fork+0x128>
  8033e8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8033ef:	01 00 00 
  8033f2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8033f5:	48 63 d2             	movslq %edx,%rdx
  8033f8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8033fc:	83 e0 05             	and    $0x5,%eax
  8033ff:	48 83 f8 05          	cmp    $0x5,%rax
  803403:	74 02                	je     803407 <fork+0x103>
  803405:	eb 21                	jmp    803428 <fork+0x124>
  803407:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  80340e:	75 02                	jne    803412 <fork+0x10e>
  803410:	eb 16                	jmp    803428 <fork+0x124>
  803412:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803415:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803418:	89 d6                	mov    %edx,%esi
  80341a:	89 c7                	mov    %eax,%edi
  80341c:	48 b8 83 31 80 00 00 	movabs $0x803183,%rax
  803423:	00 00 00 
  803426:	ff d0                	callq  *%rax
  803428:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80342c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80342f:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  803432:	7c b4                	jl     8033e8 <fork+0xe4>
  803434:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803437:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  80343c:	0f 86 4e ff ff ff    	jbe    803390 <fork+0x8c>
  803442:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803445:	ba 07 00 00 00       	mov    $0x7,%edx
  80344a:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  80344f:	89 c7                	mov    %eax,%edi
  803451:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  803458:	00 00 00 
  80345b:	ff d0                	callq  *%rax
  80345d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803460:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803464:	79 30                	jns    803496 <fork+0x192>
  803466:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803469:	89 c1                	mov    %eax,%ecx
  80346b:	48 ba a0 71 80 00 00 	movabs $0x8071a0,%rdx
  803472:	00 00 00 
  803475:	be bc 00 00 00       	mov    $0xbc,%esi
  80347a:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  803481:	00 00 00 
  803484:	b8 00 00 00 00       	mov    $0x0,%eax
  803489:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  803490:	00 00 00 
  803493:	41 ff d0             	callq  *%r8
  803496:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  80349d:	00 00 00 
  8034a0:	48 8b 00             	mov    (%rax),%rax
  8034a3:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  8034aa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034ad:	48 89 d6             	mov    %rdx,%rsi
  8034b0:	89 c7                	mov    %eax,%edi
  8034b2:	48 b8 0e 2d 80 00 00 	movabs $0x802d0e,%rax
  8034b9:	00 00 00 
  8034bc:	ff d0                	callq  *%rax
  8034be:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8034c1:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8034c5:	79 30                	jns    8034f7 <fork+0x1f3>
  8034c7:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8034ca:	89 c1                	mov    %eax,%ecx
  8034cc:	48 ba c0 71 80 00 00 	movabs $0x8071c0,%rdx
  8034d3:	00 00 00 
  8034d6:	be c0 00 00 00       	mov    $0xc0,%esi
  8034db:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  8034e2:	00 00 00 
  8034e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8034ea:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8034f1:	00 00 00 
  8034f4:	41 ff d0             	callq  *%r8
  8034f7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034fa:	be 02 00 00 00       	mov    $0x2,%esi
  8034ff:	89 c7                	mov    %eax,%edi
  803501:	48 b8 79 2c 80 00 00 	movabs $0x802c79,%rax
  803508:	00 00 00 
  80350b:	ff d0                	callq  *%rax
  80350d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803510:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803514:	79 30                	jns    803546 <fork+0x242>
  803516:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803519:	89 c1                	mov    %eax,%ecx
  80351b:	48 ba df 71 80 00 00 	movabs $0x8071df,%rdx
  803522:	00 00 00 
  803525:	be c5 00 00 00       	mov    $0xc5,%esi
  80352a:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  803531:	00 00 00 
  803534:	b8 00 00 00 00       	mov    $0x0,%eax
  803539:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  803540:	00 00 00 
  803543:	41 ff d0             	callq  *%r8
  803546:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803549:	c9                   	leaveq 
  80354a:	c3                   	retq   

000000000080354b <sfork>:
  80354b:	55                   	push   %rbp
  80354c:	48 89 e5             	mov    %rsp,%rbp
  80354f:	48 ba f6 71 80 00 00 	movabs $0x8071f6,%rdx
  803556:	00 00 00 
  803559:	be d2 00 00 00       	mov    $0xd2,%esi
  80355e:	48 bf 29 71 80 00 00 	movabs $0x807129,%rdi
  803565:	00 00 00 
  803568:	b8 00 00 00 00       	mov    $0x0,%eax
  80356d:	48 b9 0d 13 80 00 00 	movabs $0x80130d,%rcx
  803574:	00 00 00 
  803577:	ff d1                	callq  *%rcx

0000000000803579 <argstart>:
  803579:	55                   	push   %rbp
  80357a:	48 89 e5             	mov    %rsp,%rbp
  80357d:	48 83 ec 18          	sub    $0x18,%rsp
  803581:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803585:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803589:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80358d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803591:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803595:	48 89 10             	mov    %rdx,(%rax)
  803598:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80359c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8035a0:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8035a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8035a8:	8b 00                	mov    (%rax),%eax
  8035aa:	83 f8 01             	cmp    $0x1,%eax
  8035ad:	7e 13                	jle    8035c2 <argstart+0x49>
  8035af:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
  8035b4:	74 0c                	je     8035c2 <argstart+0x49>
  8035b6:	48 b8 0c 72 80 00 00 	movabs $0x80720c,%rax
  8035bd:	00 00 00 
  8035c0:	eb 05                	jmp    8035c7 <argstart+0x4e>
  8035c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8035c7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8035cb:	48 89 42 10          	mov    %rax,0x10(%rdx)
  8035cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035d3:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  8035da:	00 
  8035db:	c9                   	leaveq 
  8035dc:	c3                   	retq   

00000000008035dd <argnext>:
  8035dd:	55                   	push   %rbp
  8035de:	48 89 e5             	mov    %rsp,%rbp
  8035e1:	48 83 ec 20          	sub    $0x20,%rsp
  8035e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8035e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035ed:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  8035f4:	00 
  8035f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035f9:	48 8b 40 10          	mov    0x10(%rax),%rax
  8035fd:	48 85 c0             	test   %rax,%rax
  803600:	75 0a                	jne    80360c <argnext+0x2f>
  803602:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  803607:	e9 25 01 00 00       	jmpq   803731 <argnext+0x154>
  80360c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803610:	48 8b 40 10          	mov    0x10(%rax),%rax
  803614:	0f b6 00             	movzbl (%rax),%eax
  803617:	84 c0                	test   %al,%al
  803619:	0f 85 d7 00 00 00    	jne    8036f6 <argnext+0x119>
  80361f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803623:	48 8b 00             	mov    (%rax),%rax
  803626:	8b 00                	mov    (%rax),%eax
  803628:	83 f8 01             	cmp    $0x1,%eax
  80362b:	0f 84 ef 00 00 00    	je     803720 <argnext+0x143>
  803631:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803635:	48 8b 40 08          	mov    0x8(%rax),%rax
  803639:	48 83 c0 08          	add    $0x8,%rax
  80363d:	48 8b 00             	mov    (%rax),%rax
  803640:	0f b6 00             	movzbl (%rax),%eax
  803643:	3c 2d                	cmp    $0x2d,%al
  803645:	0f 85 d5 00 00 00    	jne    803720 <argnext+0x143>
  80364b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80364f:	48 8b 40 08          	mov    0x8(%rax),%rax
  803653:	48 83 c0 08          	add    $0x8,%rax
  803657:	48 8b 00             	mov    (%rax),%rax
  80365a:	48 83 c0 01          	add    $0x1,%rax
  80365e:	0f b6 00             	movzbl (%rax),%eax
  803661:	84 c0                	test   %al,%al
  803663:	0f 84 b7 00 00 00    	je     803720 <argnext+0x143>
  803669:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80366d:	48 8b 40 08          	mov    0x8(%rax),%rax
  803671:	48 83 c0 08          	add    $0x8,%rax
  803675:	48 8b 00             	mov    (%rax),%rax
  803678:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80367c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803680:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803684:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803688:	48 8b 00             	mov    (%rax),%rax
  80368b:	8b 00                	mov    (%rax),%eax
  80368d:	83 e8 01             	sub    $0x1,%eax
  803690:	48 98                	cltq   
  803692:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803699:	00 
  80369a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80369e:	48 8b 40 08          	mov    0x8(%rax),%rax
  8036a2:	48 8d 48 10          	lea    0x10(%rax),%rcx
  8036a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036aa:	48 8b 40 08          	mov    0x8(%rax),%rax
  8036ae:	48 83 c0 08          	add    $0x8,%rax
  8036b2:	48 89 ce             	mov    %rcx,%rsi
  8036b5:	48 89 c7             	mov    %rax,%rdi
  8036b8:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  8036bf:	00 00 00 
  8036c2:	ff d0                	callq  *%rax
  8036c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036c8:	48 8b 00             	mov    (%rax),%rax
  8036cb:	8b 10                	mov    (%rax),%edx
  8036cd:	83 ea 01             	sub    $0x1,%edx
  8036d0:	89 10                	mov    %edx,(%rax)
  8036d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036d6:	48 8b 40 10          	mov    0x10(%rax),%rax
  8036da:	0f b6 00             	movzbl (%rax),%eax
  8036dd:	3c 2d                	cmp    $0x2d,%al
  8036df:	75 15                	jne    8036f6 <argnext+0x119>
  8036e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036e5:	48 8b 40 10          	mov    0x10(%rax),%rax
  8036e9:	48 83 c0 01          	add    $0x1,%rax
  8036ed:	0f b6 00             	movzbl (%rax),%eax
  8036f0:	84 c0                	test   %al,%al
  8036f2:	75 02                	jne    8036f6 <argnext+0x119>
  8036f4:	eb 2a                	jmp    803720 <argnext+0x143>
  8036f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036fa:	48 8b 40 10          	mov    0x10(%rax),%rax
  8036fe:	0f b6 00             	movzbl (%rax),%eax
  803701:	0f b6 c0             	movzbl %al,%eax
  803704:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803707:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80370b:	48 8b 40 10          	mov    0x10(%rax),%rax
  80370f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803713:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803717:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80371b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80371e:	eb 11                	jmp    803731 <argnext+0x154>
  803720:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803724:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  80372b:	00 
  80372c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  803731:	c9                   	leaveq 
  803732:	c3                   	retq   

0000000000803733 <argvalue>:
  803733:	55                   	push   %rbp
  803734:	48 89 e5             	mov    %rsp,%rbp
  803737:	48 83 ec 10          	sub    $0x10,%rsp
  80373b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80373f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803743:	48 8b 40 18          	mov    0x18(%rax),%rax
  803747:	48 85 c0             	test   %rax,%rax
  80374a:	74 0a                	je     803756 <argvalue+0x23>
  80374c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803750:	48 8b 40 18          	mov    0x18(%rax),%rax
  803754:	eb 13                	jmp    803769 <argvalue+0x36>
  803756:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80375a:	48 89 c7             	mov    %rax,%rdi
  80375d:	48 b8 6b 37 80 00 00 	movabs $0x80376b,%rax
  803764:	00 00 00 
  803767:	ff d0                	callq  *%rax
  803769:	c9                   	leaveq 
  80376a:	c3                   	retq   

000000000080376b <argnextvalue>:
  80376b:	55                   	push   %rbp
  80376c:	48 89 e5             	mov    %rsp,%rbp
  80376f:	53                   	push   %rbx
  803770:	48 83 ec 18          	sub    $0x18,%rsp
  803774:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803778:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80377c:	48 8b 40 10          	mov    0x10(%rax),%rax
  803780:	48 85 c0             	test   %rax,%rax
  803783:	75 0a                	jne    80378f <argnextvalue+0x24>
  803785:	b8 00 00 00 00       	mov    $0x0,%eax
  80378a:	e9 c8 00 00 00       	jmpq   803857 <argnextvalue+0xec>
  80378f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803793:	48 8b 40 10          	mov    0x10(%rax),%rax
  803797:	0f b6 00             	movzbl (%rax),%eax
  80379a:	84 c0                	test   %al,%al
  80379c:	74 27                	je     8037c5 <argnextvalue+0x5a>
  80379e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037a2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8037a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037aa:	48 89 50 18          	mov    %rdx,0x18(%rax)
  8037ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037b2:	48 bb 0c 72 80 00 00 	movabs $0x80720c,%rbx
  8037b9:	00 00 00 
  8037bc:	48 89 58 10          	mov    %rbx,0x10(%rax)
  8037c0:	e9 8a 00 00 00       	jmpq   80384f <argnextvalue+0xe4>
  8037c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037c9:	48 8b 00             	mov    (%rax),%rax
  8037cc:	8b 00                	mov    (%rax),%eax
  8037ce:	83 f8 01             	cmp    $0x1,%eax
  8037d1:	7e 64                	jle    803837 <argnextvalue+0xcc>
  8037d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037d7:	48 8b 40 08          	mov    0x8(%rax),%rax
  8037db:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8037df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037e3:	48 89 50 18          	mov    %rdx,0x18(%rax)
  8037e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037eb:	48 8b 00             	mov    (%rax),%rax
  8037ee:	8b 00                	mov    (%rax),%eax
  8037f0:	83 e8 01             	sub    $0x1,%eax
  8037f3:	48 98                	cltq   
  8037f5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8037fc:	00 
  8037fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803801:	48 8b 40 08          	mov    0x8(%rax),%rax
  803805:	48 8d 48 10          	lea    0x10(%rax),%rcx
  803809:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80380d:	48 8b 40 08          	mov    0x8(%rax),%rax
  803811:	48 83 c0 08          	add    $0x8,%rax
  803815:	48 89 ce             	mov    %rcx,%rsi
  803818:	48 89 c7             	mov    %rax,%rdi
  80381b:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  803822:	00 00 00 
  803825:	ff d0                	callq  *%rax
  803827:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80382b:	48 8b 00             	mov    (%rax),%rax
  80382e:	8b 10                	mov    (%rax),%edx
  803830:	83 ea 01             	sub    $0x1,%edx
  803833:	89 10                	mov    %edx,(%rax)
  803835:	eb 18                	jmp    80384f <argnextvalue+0xe4>
  803837:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80383b:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  803842:	00 
  803843:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803847:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  80384e:	00 
  80384f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803853:	48 8b 40 18          	mov    0x18(%rax),%rax
  803857:	48 83 c4 18          	add    $0x18,%rsp
  80385b:	5b                   	pop    %rbx
  80385c:	5d                   	pop    %rbp
  80385d:	c3                   	retq   

000000000080385e <fd2num>:
  80385e:	55                   	push   %rbp
  80385f:	48 89 e5             	mov    %rsp,%rbp
  803862:	48 83 ec 08          	sub    $0x8,%rsp
  803866:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80386a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80386e:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  803875:	ff ff ff 
  803878:	48 01 d0             	add    %rdx,%rax
  80387b:	48 c1 e8 0c          	shr    $0xc,%rax
  80387f:	c9                   	leaveq 
  803880:	c3                   	retq   

0000000000803881 <fd2data>:
  803881:	55                   	push   %rbp
  803882:	48 89 e5             	mov    %rsp,%rbp
  803885:	48 83 ec 08          	sub    $0x8,%rsp
  803889:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80388d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803891:	48 89 c7             	mov    %rax,%rdi
  803894:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  80389b:	00 00 00 
  80389e:	ff d0                	callq  *%rax
  8038a0:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  8038a6:	48 c1 e0 0c          	shl    $0xc,%rax
  8038aa:	c9                   	leaveq 
  8038ab:	c3                   	retq   

00000000008038ac <fd_alloc>:
  8038ac:	55                   	push   %rbp
  8038ad:	48 89 e5             	mov    %rsp,%rbp
  8038b0:	48 83 ec 18          	sub    $0x18,%rsp
  8038b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8038b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8038bf:	eb 6b                	jmp    80392c <fd_alloc+0x80>
  8038c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038c4:	48 98                	cltq   
  8038c6:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8038cc:	48 c1 e0 0c          	shl    $0xc,%rax
  8038d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8038d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038d8:	48 c1 e8 15          	shr    $0x15,%rax
  8038dc:	48 89 c2             	mov    %rax,%rdx
  8038df:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8038e6:	01 00 00 
  8038e9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8038ed:	83 e0 01             	and    $0x1,%eax
  8038f0:	48 85 c0             	test   %rax,%rax
  8038f3:	74 21                	je     803916 <fd_alloc+0x6a>
  8038f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038f9:	48 c1 e8 0c          	shr    $0xc,%rax
  8038fd:	48 89 c2             	mov    %rax,%rdx
  803900:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803907:	01 00 00 
  80390a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80390e:	83 e0 01             	and    $0x1,%eax
  803911:	48 85 c0             	test   %rax,%rax
  803914:	75 12                	jne    803928 <fd_alloc+0x7c>
  803916:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80391a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80391e:	48 89 10             	mov    %rdx,(%rax)
  803921:	b8 00 00 00 00       	mov    $0x0,%eax
  803926:	eb 1a                	jmp    803942 <fd_alloc+0x96>
  803928:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80392c:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  803930:	7e 8f                	jle    8038c1 <fd_alloc+0x15>
  803932:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803936:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80393d:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  803942:	c9                   	leaveq 
  803943:	c3                   	retq   

0000000000803944 <fd_lookup>:
  803944:	55                   	push   %rbp
  803945:	48 89 e5             	mov    %rsp,%rbp
  803948:	48 83 ec 20          	sub    $0x20,%rsp
  80394c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80394f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803953:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803957:	78 06                	js     80395f <fd_lookup+0x1b>
  803959:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  80395d:	7e 07                	jle    803966 <fd_lookup+0x22>
  80395f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803964:	eb 6c                	jmp    8039d2 <fd_lookup+0x8e>
  803966:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803969:	48 98                	cltq   
  80396b:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  803971:	48 c1 e0 0c          	shl    $0xc,%rax
  803975:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80397d:	48 c1 e8 15          	shr    $0x15,%rax
  803981:	48 89 c2             	mov    %rax,%rdx
  803984:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80398b:	01 00 00 
  80398e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803992:	83 e0 01             	and    $0x1,%eax
  803995:	48 85 c0             	test   %rax,%rax
  803998:	74 21                	je     8039bb <fd_lookup+0x77>
  80399a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80399e:	48 c1 e8 0c          	shr    $0xc,%rax
  8039a2:	48 89 c2             	mov    %rax,%rdx
  8039a5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8039ac:	01 00 00 
  8039af:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8039b3:	83 e0 01             	and    $0x1,%eax
  8039b6:	48 85 c0             	test   %rax,%rax
  8039b9:	75 07                	jne    8039c2 <fd_lookup+0x7e>
  8039bb:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8039c0:	eb 10                	jmp    8039d2 <fd_lookup+0x8e>
  8039c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8039c6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8039ca:	48 89 10             	mov    %rdx,(%rax)
  8039cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8039d2:	c9                   	leaveq 
  8039d3:	c3                   	retq   

00000000008039d4 <fd_close>:
  8039d4:	55                   	push   %rbp
  8039d5:	48 89 e5             	mov    %rsp,%rbp
  8039d8:	48 83 ec 30          	sub    $0x30,%rsp
  8039dc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8039e0:	89 f0                	mov    %esi,%eax
  8039e2:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8039e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8039e9:	48 89 c7             	mov    %rax,%rdi
  8039ec:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  8039f3:	00 00 00 
  8039f6:	ff d0                	callq  *%rax
  8039f8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8039fc:	48 89 d6             	mov    %rdx,%rsi
  8039ff:	89 c7                	mov    %eax,%edi
  803a01:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803a08:	00 00 00 
  803a0b:	ff d0                	callq  *%rax
  803a0d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a10:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a14:	78 0a                	js     803a20 <fd_close+0x4c>
  803a16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a1a:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  803a1e:	74 12                	je     803a32 <fd_close+0x5e>
  803a20:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  803a24:	74 05                	je     803a2b <fd_close+0x57>
  803a26:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a29:	eb 05                	jmp    803a30 <fd_close+0x5c>
  803a2b:	b8 00 00 00 00       	mov    $0x0,%eax
  803a30:	eb 69                	jmp    803a9b <fd_close+0xc7>
  803a32:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a36:	8b 00                	mov    (%rax),%eax
  803a38:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803a3c:	48 89 d6             	mov    %rdx,%rsi
  803a3f:	89 c7                	mov    %eax,%edi
  803a41:	48 b8 9d 3a 80 00 00 	movabs $0x803a9d,%rax
  803a48:	00 00 00 
  803a4b:	ff d0                	callq  *%rax
  803a4d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a50:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a54:	78 2a                	js     803a80 <fd_close+0xac>
  803a56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a5a:	48 8b 40 20          	mov    0x20(%rax),%rax
  803a5e:	48 85 c0             	test   %rax,%rax
  803a61:	74 16                	je     803a79 <fd_close+0xa5>
  803a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a67:	48 8b 40 20          	mov    0x20(%rax),%rax
  803a6b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803a6f:	48 89 d7             	mov    %rdx,%rdi
  803a72:	ff d0                	callq  *%rax
  803a74:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a77:	eb 07                	jmp    803a80 <fd_close+0xac>
  803a79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803a80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a84:	48 89 c6             	mov    %rax,%rsi
  803a87:	bf 00 00 00 00       	mov    $0x0,%edi
  803a8c:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  803a93:	00 00 00 
  803a96:	ff d0                	callq  *%rax
  803a98:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a9b:	c9                   	leaveq 
  803a9c:	c3                   	retq   

0000000000803a9d <dev_lookup>:
  803a9d:	55                   	push   %rbp
  803a9e:	48 89 e5             	mov    %rsp,%rbp
  803aa1:	48 83 ec 20          	sub    $0x20,%rsp
  803aa5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803aa8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803aac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803ab3:	eb 41                	jmp    803af6 <dev_lookup+0x59>
  803ab5:	48 b8 60 90 80 00 00 	movabs $0x809060,%rax
  803abc:	00 00 00 
  803abf:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ac2:	48 63 d2             	movslq %edx,%rdx
  803ac5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803ac9:	8b 00                	mov    (%rax),%eax
  803acb:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  803ace:	75 22                	jne    803af2 <dev_lookup+0x55>
  803ad0:	48 b8 60 90 80 00 00 	movabs $0x809060,%rax
  803ad7:	00 00 00 
  803ada:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803add:	48 63 d2             	movslq %edx,%rdx
  803ae0:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  803ae4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ae8:	48 89 10             	mov    %rdx,(%rax)
  803aeb:	b8 00 00 00 00       	mov    $0x0,%eax
  803af0:	eb 60                	jmp    803b52 <dev_lookup+0xb5>
  803af2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803af6:	48 b8 60 90 80 00 00 	movabs $0x809060,%rax
  803afd:	00 00 00 
  803b00:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b03:	48 63 d2             	movslq %edx,%rdx
  803b06:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803b0a:	48 85 c0             	test   %rax,%rax
  803b0d:	75 a6                	jne    803ab5 <dev_lookup+0x18>
  803b0f:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  803b16:	00 00 00 
  803b19:	48 8b 00             	mov    (%rax),%rax
  803b1c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803b22:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b25:	89 c6                	mov    %eax,%esi
  803b27:	48 bf 10 72 80 00 00 	movabs $0x807210,%rdi
  803b2e:	00 00 00 
  803b31:	b8 00 00 00 00       	mov    $0x0,%eax
  803b36:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  803b3d:	00 00 00 
  803b40:	ff d1                	callq  *%rcx
  803b42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b46:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  803b4d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803b52:	c9                   	leaveq 
  803b53:	c3                   	retq   

0000000000803b54 <close>:
  803b54:	55                   	push   %rbp
  803b55:	48 89 e5             	mov    %rsp,%rbp
  803b58:	48 83 ec 20          	sub    $0x20,%rsp
  803b5c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b5f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803b63:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b66:	48 89 d6             	mov    %rdx,%rsi
  803b69:	89 c7                	mov    %eax,%edi
  803b6b:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803b72:	00 00 00 
  803b75:	ff d0                	callq  *%rax
  803b77:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b7e:	79 05                	jns    803b85 <close+0x31>
  803b80:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b83:	eb 18                	jmp    803b9d <close+0x49>
  803b85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b89:	be 01 00 00 00       	mov    $0x1,%esi
  803b8e:	48 89 c7             	mov    %rax,%rdi
  803b91:	48 b8 d4 39 80 00 00 	movabs $0x8039d4,%rax
  803b98:	00 00 00 
  803b9b:	ff d0                	callq  *%rax
  803b9d:	c9                   	leaveq 
  803b9e:	c3                   	retq   

0000000000803b9f <close_all>:
  803b9f:	55                   	push   %rbp
  803ba0:	48 89 e5             	mov    %rsp,%rbp
  803ba3:	48 83 ec 10          	sub    $0x10,%rsp
  803ba7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803bae:	eb 15                	jmp    803bc5 <close_all+0x26>
  803bb0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bb3:	89 c7                	mov    %eax,%edi
  803bb5:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  803bbc:	00 00 00 
  803bbf:	ff d0                	callq  *%rax
  803bc1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803bc5:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  803bc9:	7e e5                	jle    803bb0 <close_all+0x11>
  803bcb:	c9                   	leaveq 
  803bcc:	c3                   	retq   

0000000000803bcd <dup>:
  803bcd:	55                   	push   %rbp
  803bce:	48 89 e5             	mov    %rsp,%rbp
  803bd1:	48 83 ec 40          	sub    $0x40,%rsp
  803bd5:	89 7d cc             	mov    %edi,-0x34(%rbp)
  803bd8:	89 75 c8             	mov    %esi,-0x38(%rbp)
  803bdb:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  803bdf:	8b 45 cc             	mov    -0x34(%rbp),%eax
  803be2:	48 89 d6             	mov    %rdx,%rsi
  803be5:	89 c7                	mov    %eax,%edi
  803be7:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803bee:	00 00 00 
  803bf1:	ff d0                	callq  *%rax
  803bf3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bf6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bfa:	79 08                	jns    803c04 <dup+0x37>
  803bfc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bff:	e9 70 01 00 00       	jmpq   803d74 <dup+0x1a7>
  803c04:	8b 45 c8             	mov    -0x38(%rbp),%eax
  803c07:	89 c7                	mov    %eax,%edi
  803c09:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  803c10:	00 00 00 
  803c13:	ff d0                	callq  *%rax
  803c15:	8b 45 c8             	mov    -0x38(%rbp),%eax
  803c18:	48 98                	cltq   
  803c1a:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  803c20:	48 c1 e0 0c          	shl    $0xc,%rax
  803c24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803c28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c2c:	48 89 c7             	mov    %rax,%rdi
  803c2f:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  803c36:	00 00 00 
  803c39:	ff d0                	callq  *%rax
  803c3b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c43:	48 89 c7             	mov    %rax,%rdi
  803c46:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  803c4d:	00 00 00 
  803c50:	ff d0                	callq  *%rax
  803c52:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803c56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803c5a:	48 c1 e8 15          	shr    $0x15,%rax
  803c5e:	48 89 c2             	mov    %rax,%rdx
  803c61:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  803c68:	01 00 00 
  803c6b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803c6f:	83 e0 01             	and    $0x1,%eax
  803c72:	48 85 c0             	test   %rax,%rax
  803c75:	74 73                	je     803cea <dup+0x11d>
  803c77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803c7b:	48 c1 e8 0c          	shr    $0xc,%rax
  803c7f:	48 89 c2             	mov    %rax,%rdx
  803c82:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803c89:	01 00 00 
  803c8c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803c90:	83 e0 01             	and    $0x1,%eax
  803c93:	48 85 c0             	test   %rax,%rax
  803c96:	74 52                	je     803cea <dup+0x11d>
  803c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803c9c:	48 c1 e8 0c          	shr    $0xc,%rax
  803ca0:	48 89 c2             	mov    %rax,%rdx
  803ca3:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803caa:	01 00 00 
  803cad:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803cb1:	25 07 0e 00 00       	and    $0xe07,%eax
  803cb6:	89 c1                	mov    %eax,%ecx
  803cb8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803cbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803cc0:	41 89 c8             	mov    %ecx,%r8d
  803cc3:	48 89 d1             	mov    %rdx,%rcx
  803cc6:	ba 00 00 00 00       	mov    $0x0,%edx
  803ccb:	48 89 c6             	mov    %rax,%rsi
  803cce:	bf 00 00 00 00       	mov    $0x0,%edi
  803cd3:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  803cda:	00 00 00 
  803cdd:	ff d0                	callq  *%rax
  803cdf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ce2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ce6:	79 02                	jns    803cea <dup+0x11d>
  803ce8:	eb 57                	jmp    803d41 <dup+0x174>
  803cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803cee:	48 c1 e8 0c          	shr    $0xc,%rax
  803cf2:	48 89 c2             	mov    %rax,%rdx
  803cf5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803cfc:	01 00 00 
  803cff:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803d03:	25 07 0e 00 00       	and    $0xe07,%eax
  803d08:	89 c1                	mov    %eax,%ecx
  803d0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d0e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803d12:	41 89 c8             	mov    %ecx,%r8d
  803d15:	48 89 d1             	mov    %rdx,%rcx
  803d18:	ba 00 00 00 00       	mov    $0x0,%edx
  803d1d:	48 89 c6             	mov    %rax,%rsi
  803d20:	bf 00 00 00 00       	mov    $0x0,%edi
  803d25:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  803d2c:	00 00 00 
  803d2f:	ff d0                	callq  *%rax
  803d31:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d34:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d38:	79 02                	jns    803d3c <dup+0x16f>
  803d3a:	eb 05                	jmp    803d41 <dup+0x174>
  803d3c:	8b 45 c8             	mov    -0x38(%rbp),%eax
  803d3f:	eb 33                	jmp    803d74 <dup+0x1a7>
  803d41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d45:	48 89 c6             	mov    %rax,%rsi
  803d48:	bf 00 00 00 00       	mov    $0x0,%edi
  803d4d:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  803d54:	00 00 00 
  803d57:	ff d0                	callq  *%rax
  803d59:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803d5d:	48 89 c6             	mov    %rax,%rsi
  803d60:	bf 00 00 00 00       	mov    $0x0,%edi
  803d65:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  803d6c:	00 00 00 
  803d6f:	ff d0                	callq  *%rax
  803d71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d74:	c9                   	leaveq 
  803d75:	c3                   	retq   

0000000000803d76 <read>:
  803d76:	55                   	push   %rbp
  803d77:	48 89 e5             	mov    %rsp,%rbp
  803d7a:	48 83 ec 40          	sub    $0x40,%rsp
  803d7e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803d81:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803d85:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803d89:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803d8d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803d90:	48 89 d6             	mov    %rdx,%rsi
  803d93:	89 c7                	mov    %eax,%edi
  803d95:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803d9c:	00 00 00 
  803d9f:	ff d0                	callq  *%rax
  803da1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803da4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803da8:	78 24                	js     803dce <read+0x58>
  803daa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803dae:	8b 00                	mov    (%rax),%eax
  803db0:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803db4:	48 89 d6             	mov    %rdx,%rsi
  803db7:	89 c7                	mov    %eax,%edi
  803db9:	48 b8 9d 3a 80 00 00 	movabs $0x803a9d,%rax
  803dc0:	00 00 00 
  803dc3:	ff d0                	callq  *%rax
  803dc5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803dc8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803dcc:	79 05                	jns    803dd3 <read+0x5d>
  803dce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dd1:	eb 76                	jmp    803e49 <read+0xd3>
  803dd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803dd7:	8b 40 08             	mov    0x8(%rax),%eax
  803dda:	83 e0 03             	and    $0x3,%eax
  803ddd:	83 f8 01             	cmp    $0x1,%eax
  803de0:	75 3a                	jne    803e1c <read+0xa6>
  803de2:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  803de9:	00 00 00 
  803dec:	48 8b 00             	mov    (%rax),%rax
  803def:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803df5:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803df8:	89 c6                	mov    %eax,%esi
  803dfa:	48 bf 2f 72 80 00 00 	movabs $0x80722f,%rdi
  803e01:	00 00 00 
  803e04:	b8 00 00 00 00       	mov    $0x0,%eax
  803e09:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  803e10:	00 00 00 
  803e13:	ff d1                	callq  *%rcx
  803e15:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803e1a:	eb 2d                	jmp    803e49 <read+0xd3>
  803e1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e20:	48 8b 40 10          	mov    0x10(%rax),%rax
  803e24:	48 85 c0             	test   %rax,%rax
  803e27:	75 07                	jne    803e30 <read+0xba>
  803e29:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803e2e:	eb 19                	jmp    803e49 <read+0xd3>
  803e30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e34:	48 8b 40 10          	mov    0x10(%rax),%rax
  803e38:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803e3c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803e40:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  803e44:	48 89 cf             	mov    %rcx,%rdi
  803e47:	ff d0                	callq  *%rax
  803e49:	c9                   	leaveq 
  803e4a:	c3                   	retq   

0000000000803e4b <readn>:
  803e4b:	55                   	push   %rbp
  803e4c:	48 89 e5             	mov    %rsp,%rbp
  803e4f:	48 83 ec 30          	sub    $0x30,%rsp
  803e53:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e56:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803e5a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803e5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803e65:	eb 49                	jmp    803eb0 <readn+0x65>
  803e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e6a:	48 98                	cltq   
  803e6c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803e70:	48 29 c2             	sub    %rax,%rdx
  803e73:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e76:	48 63 c8             	movslq %eax,%rcx
  803e79:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e7d:	48 01 c1             	add    %rax,%rcx
  803e80:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803e83:	48 89 ce             	mov    %rcx,%rsi
  803e86:	89 c7                	mov    %eax,%edi
  803e88:	48 b8 76 3d 80 00 00 	movabs $0x803d76,%rax
  803e8f:	00 00 00 
  803e92:	ff d0                	callq  *%rax
  803e94:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803e97:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803e9b:	79 05                	jns    803ea2 <readn+0x57>
  803e9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803ea0:	eb 1c                	jmp    803ebe <readn+0x73>
  803ea2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803ea6:	75 02                	jne    803eaa <readn+0x5f>
  803ea8:	eb 11                	jmp    803ebb <readn+0x70>
  803eaa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803ead:	01 45 fc             	add    %eax,-0x4(%rbp)
  803eb0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803eb3:	48 98                	cltq   
  803eb5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  803eb9:	72 ac                	jb     803e67 <readn+0x1c>
  803ebb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ebe:	c9                   	leaveq 
  803ebf:	c3                   	retq   

0000000000803ec0 <write>:
  803ec0:	55                   	push   %rbp
  803ec1:	48 89 e5             	mov    %rsp,%rbp
  803ec4:	48 83 ec 40          	sub    $0x40,%rsp
  803ec8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803ecb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803ecf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803ed3:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803ed7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803eda:	48 89 d6             	mov    %rdx,%rsi
  803edd:	89 c7                	mov    %eax,%edi
  803edf:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803ee6:	00 00 00 
  803ee9:	ff d0                	callq  *%rax
  803eeb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803eee:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ef2:	78 24                	js     803f18 <write+0x58>
  803ef4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803ef8:	8b 00                	mov    (%rax),%eax
  803efa:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803efe:	48 89 d6             	mov    %rdx,%rsi
  803f01:	89 c7                	mov    %eax,%edi
  803f03:	48 b8 9d 3a 80 00 00 	movabs $0x803a9d,%rax
  803f0a:	00 00 00 
  803f0d:	ff d0                	callq  *%rax
  803f0f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f12:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f16:	79 05                	jns    803f1d <write+0x5d>
  803f18:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f1b:	eb 75                	jmp    803f92 <write+0xd2>
  803f1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f21:	8b 40 08             	mov    0x8(%rax),%eax
  803f24:	83 e0 03             	and    $0x3,%eax
  803f27:	85 c0                	test   %eax,%eax
  803f29:	75 3a                	jne    803f65 <write+0xa5>
  803f2b:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  803f32:	00 00 00 
  803f35:	48 8b 00             	mov    (%rax),%rax
  803f38:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f3e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803f41:	89 c6                	mov    %eax,%esi
  803f43:	48 bf 4b 72 80 00 00 	movabs $0x80724b,%rdi
  803f4a:	00 00 00 
  803f4d:	b8 00 00 00 00       	mov    $0x0,%eax
  803f52:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  803f59:	00 00 00 
  803f5c:	ff d1                	callq  *%rcx
  803f5e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803f63:	eb 2d                	jmp    803f92 <write+0xd2>
  803f65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f69:	48 8b 40 18          	mov    0x18(%rax),%rax
  803f6d:	48 85 c0             	test   %rax,%rax
  803f70:	75 07                	jne    803f79 <write+0xb9>
  803f72:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803f77:	eb 19                	jmp    803f92 <write+0xd2>
  803f79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f7d:	48 8b 40 18          	mov    0x18(%rax),%rax
  803f81:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803f85:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803f89:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  803f8d:	48 89 cf             	mov    %rcx,%rdi
  803f90:	ff d0                	callq  *%rax
  803f92:	c9                   	leaveq 
  803f93:	c3                   	retq   

0000000000803f94 <seek>:
  803f94:	55                   	push   %rbp
  803f95:	48 89 e5             	mov    %rsp,%rbp
  803f98:	48 83 ec 18          	sub    $0x18,%rsp
  803f9c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803f9f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803fa2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803fa6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fa9:	48 89 d6             	mov    %rdx,%rsi
  803fac:	89 c7                	mov    %eax,%edi
  803fae:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803fb5:	00 00 00 
  803fb8:	ff d0                	callq  *%rax
  803fba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803fbd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803fc1:	79 05                	jns    803fc8 <seek+0x34>
  803fc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fc6:	eb 0f                	jmp    803fd7 <seek+0x43>
  803fc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803fcc:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803fcf:	89 50 04             	mov    %edx,0x4(%rax)
  803fd2:	b8 00 00 00 00       	mov    $0x0,%eax
  803fd7:	c9                   	leaveq 
  803fd8:	c3                   	retq   

0000000000803fd9 <ftruncate>:
  803fd9:	55                   	push   %rbp
  803fda:	48 89 e5             	mov    %rsp,%rbp
  803fdd:	48 83 ec 30          	sub    $0x30,%rsp
  803fe1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803fe4:	89 75 d8             	mov    %esi,-0x28(%rbp)
  803fe7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803feb:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803fee:	48 89 d6             	mov    %rdx,%rsi
  803ff1:	89 c7                	mov    %eax,%edi
  803ff3:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  803ffa:	00 00 00 
  803ffd:	ff d0                	callq  *%rax
  803fff:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804002:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804006:	78 24                	js     80402c <ftruncate+0x53>
  804008:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80400c:	8b 00                	mov    (%rax),%eax
  80400e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804012:	48 89 d6             	mov    %rdx,%rsi
  804015:	89 c7                	mov    %eax,%edi
  804017:	48 b8 9d 3a 80 00 00 	movabs $0x803a9d,%rax
  80401e:	00 00 00 
  804021:	ff d0                	callq  *%rax
  804023:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804026:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80402a:	79 05                	jns    804031 <ftruncate+0x58>
  80402c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80402f:	eb 72                	jmp    8040a3 <ftruncate+0xca>
  804031:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804035:	8b 40 08             	mov    0x8(%rax),%eax
  804038:	83 e0 03             	and    $0x3,%eax
  80403b:	85 c0                	test   %eax,%eax
  80403d:	75 3a                	jne    804079 <ftruncate+0xa0>
  80403f:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  804046:	00 00 00 
  804049:	48 8b 00             	mov    (%rax),%rax
  80404c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804052:	8b 55 dc             	mov    -0x24(%rbp),%edx
  804055:	89 c6                	mov    %eax,%esi
  804057:	48 bf 68 72 80 00 00 	movabs $0x807268,%rdi
  80405e:	00 00 00 
  804061:	b8 00 00 00 00       	mov    $0x0,%eax
  804066:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  80406d:	00 00 00 
  804070:	ff d1                	callq  *%rcx
  804072:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  804077:	eb 2a                	jmp    8040a3 <ftruncate+0xca>
  804079:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80407d:	48 8b 40 30          	mov    0x30(%rax),%rax
  804081:	48 85 c0             	test   %rax,%rax
  804084:	75 07                	jne    80408d <ftruncate+0xb4>
  804086:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80408b:	eb 16                	jmp    8040a3 <ftruncate+0xca>
  80408d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804091:	48 8b 40 30          	mov    0x30(%rax),%rax
  804095:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804099:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  80409c:	89 ce                	mov    %ecx,%esi
  80409e:	48 89 d7             	mov    %rdx,%rdi
  8040a1:	ff d0                	callq  *%rax
  8040a3:	c9                   	leaveq 
  8040a4:	c3                   	retq   

00000000008040a5 <fstat>:
  8040a5:	55                   	push   %rbp
  8040a6:	48 89 e5             	mov    %rsp,%rbp
  8040a9:	48 83 ec 30          	sub    $0x30,%rsp
  8040ad:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8040b0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8040b4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8040b8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8040bb:	48 89 d6             	mov    %rdx,%rsi
  8040be:	89 c7                	mov    %eax,%edi
  8040c0:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  8040c7:	00 00 00 
  8040ca:	ff d0                	callq  *%rax
  8040cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040d3:	78 24                	js     8040f9 <fstat+0x54>
  8040d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8040d9:	8b 00                	mov    (%rax),%eax
  8040db:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8040df:	48 89 d6             	mov    %rdx,%rsi
  8040e2:	89 c7                	mov    %eax,%edi
  8040e4:	48 b8 9d 3a 80 00 00 	movabs $0x803a9d,%rax
  8040eb:	00 00 00 
  8040ee:	ff d0                	callq  *%rax
  8040f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040f7:	79 05                	jns    8040fe <fstat+0x59>
  8040f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040fc:	eb 5e                	jmp    80415c <fstat+0xb7>
  8040fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804102:	48 8b 40 28          	mov    0x28(%rax),%rax
  804106:	48 85 c0             	test   %rax,%rax
  804109:	75 07                	jne    804112 <fstat+0x6d>
  80410b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  804110:	eb 4a                	jmp    80415c <fstat+0xb7>
  804112:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804116:	c6 00 00             	movb   $0x0,(%rax)
  804119:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80411d:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  804124:	00 00 00 
  804127:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80412b:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804132:	00 00 00 
  804135:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804139:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80413d:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  804144:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804148:	48 8b 40 28          	mov    0x28(%rax),%rax
  80414c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804150:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  804154:	48 89 ce             	mov    %rcx,%rsi
  804157:	48 89 d7             	mov    %rdx,%rdi
  80415a:	ff d0                	callq  *%rax
  80415c:	c9                   	leaveq 
  80415d:	c3                   	retq   

000000000080415e <stat>:
  80415e:	55                   	push   %rbp
  80415f:	48 89 e5             	mov    %rsp,%rbp
  804162:	48 83 ec 20          	sub    $0x20,%rsp
  804166:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80416a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80416e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804172:	be 00 00 00 00       	mov    $0x0,%esi
  804177:	48 89 c7             	mov    %rax,%rdi
  80417a:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  804181:	00 00 00 
  804184:	ff d0                	callq  *%rax
  804186:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804189:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80418d:	79 05                	jns    804194 <stat+0x36>
  80418f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804192:	eb 2f                	jmp    8041c3 <stat+0x65>
  804194:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804198:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80419b:	48 89 d6             	mov    %rdx,%rsi
  80419e:	89 c7                	mov    %eax,%edi
  8041a0:	48 b8 a5 40 80 00 00 	movabs $0x8040a5,%rax
  8041a7:	00 00 00 
  8041aa:	ff d0                	callq  *%rax
  8041ac:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8041af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8041b2:	89 c7                	mov    %eax,%edi
  8041b4:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8041bb:	00 00 00 
  8041be:	ff d0                	callq  *%rax
  8041c0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8041c3:	c9                   	leaveq 
  8041c4:	c3                   	retq   

00000000008041c5 <fsipc>:
  8041c5:	55                   	push   %rbp
  8041c6:	48 89 e5             	mov    %rsp,%rbp
  8041c9:	48 83 ec 10          	sub    $0x10,%rsp
  8041cd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8041d0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8041d4:	48 b8 20 a4 80 00 00 	movabs $0x80a420,%rax
  8041db:	00 00 00 
  8041de:	8b 00                	mov    (%rax),%eax
  8041e0:	85 c0                	test   %eax,%eax
  8041e2:	75 1d                	jne    804201 <fsipc+0x3c>
  8041e4:	bf 01 00 00 00       	mov    $0x1,%edi
  8041e9:	48 b8 55 68 80 00 00 	movabs $0x806855,%rax
  8041f0:	00 00 00 
  8041f3:	ff d0                	callq  *%rax
  8041f5:	48 ba 20 a4 80 00 00 	movabs $0x80a420,%rdx
  8041fc:	00 00 00 
  8041ff:	89 02                	mov    %eax,(%rdx)
  804201:	48 b8 20 a4 80 00 00 	movabs $0x80a420,%rax
  804208:	00 00 00 
  80420b:	8b 00                	mov    (%rax),%eax
  80420d:	8b 75 fc             	mov    -0x4(%rbp),%esi
  804210:	b9 07 00 00 00       	mov    $0x7,%ecx
  804215:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  80421c:	00 00 00 
  80421f:	89 c7                	mov    %eax,%edi
  804221:	48 b8 4a 67 80 00 00 	movabs $0x80674a,%rax
  804228:	00 00 00 
  80422b:	ff d0                	callq  *%rax
  80422d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804231:	ba 00 00 00 00       	mov    $0x0,%edx
  804236:	48 89 c6             	mov    %rax,%rsi
  804239:	bf 00 00 00 00       	mov    $0x0,%edi
  80423e:	48 b8 89 66 80 00 00 	movabs $0x806689,%rax
  804245:	00 00 00 
  804248:	ff d0                	callq  *%rax
  80424a:	c9                   	leaveq 
  80424b:	c3                   	retq   

000000000080424c <open>:
  80424c:	55                   	push   %rbp
  80424d:	48 89 e5             	mov    %rsp,%rbp
  804250:	48 83 ec 20          	sub    $0x20,%rsp
  804254:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804258:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80425b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80425f:	48 89 c7             	mov    %rax,%rdi
  804262:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  804269:	00 00 00 
  80426c:	ff d0                	callq  *%rax
  80426e:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  804273:	7e 0a                	jle    80427f <open+0x33>
  804275:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80427a:	e9 a5 00 00 00       	jmpq   804324 <open+0xd8>
  80427f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804283:	48 89 c7             	mov    %rax,%rdi
  804286:	48 b8 ac 38 80 00 00 	movabs $0x8038ac,%rax
  80428d:	00 00 00 
  804290:	ff d0                	callq  *%rax
  804292:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804295:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804299:	79 08                	jns    8042a3 <open+0x57>
  80429b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80429e:	e9 81 00 00 00       	jmpq   804324 <open+0xd8>
  8042a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042a7:	48 89 c6             	mov    %rax,%rsi
  8042aa:	48 bf 00 b0 80 00 00 	movabs $0x80b000,%rdi
  8042b1:	00 00 00 
  8042b4:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  8042bb:	00 00 00 
  8042be:	ff d0                	callq  *%rax
  8042c0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8042c7:	00 00 00 
  8042ca:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8042cd:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8042d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042d7:	48 89 c6             	mov    %rax,%rsi
  8042da:	bf 01 00 00 00       	mov    $0x1,%edi
  8042df:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  8042e6:	00 00 00 
  8042e9:	ff d0                	callq  *%rax
  8042eb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8042ee:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8042f2:	79 1d                	jns    804311 <open+0xc5>
  8042f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042f8:	be 00 00 00 00       	mov    $0x0,%esi
  8042fd:	48 89 c7             	mov    %rax,%rdi
  804300:	48 b8 d4 39 80 00 00 	movabs $0x8039d4,%rax
  804307:	00 00 00 
  80430a:	ff d0                	callq  *%rax
  80430c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80430f:	eb 13                	jmp    804324 <open+0xd8>
  804311:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804315:	48 89 c7             	mov    %rax,%rdi
  804318:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  80431f:	00 00 00 
  804322:	ff d0                	callq  *%rax
  804324:	c9                   	leaveq 
  804325:	c3                   	retq   

0000000000804326 <devfile_flush>:
  804326:	55                   	push   %rbp
  804327:	48 89 e5             	mov    %rsp,%rbp
  80432a:	48 83 ec 10          	sub    $0x10,%rsp
  80432e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804332:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804336:	8b 50 0c             	mov    0xc(%rax),%edx
  804339:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804340:	00 00 00 
  804343:	89 10                	mov    %edx,(%rax)
  804345:	be 00 00 00 00       	mov    $0x0,%esi
  80434a:	bf 06 00 00 00       	mov    $0x6,%edi
  80434f:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  804356:	00 00 00 
  804359:	ff d0                	callq  *%rax
  80435b:	c9                   	leaveq 
  80435c:	c3                   	retq   

000000000080435d <devfile_read>:
  80435d:	55                   	push   %rbp
  80435e:	48 89 e5             	mov    %rsp,%rbp
  804361:	48 83 ec 30          	sub    $0x30,%rsp
  804365:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804369:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80436d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804375:	8b 50 0c             	mov    0xc(%rax),%edx
  804378:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80437f:	00 00 00 
  804382:	89 10                	mov    %edx,(%rax)
  804384:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80438b:	00 00 00 
  80438e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  804392:	48 89 50 08          	mov    %rdx,0x8(%rax)
  804396:	be 00 00 00 00       	mov    $0x0,%esi
  80439b:	bf 03 00 00 00       	mov    $0x3,%edi
  8043a0:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  8043a7:	00 00 00 
  8043aa:	ff d0                	callq  *%rax
  8043ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8043af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8043b3:	79 08                	jns    8043bd <devfile_read+0x60>
  8043b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8043b8:	e9 a4 00 00 00       	jmpq   804461 <devfile_read+0x104>
  8043bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8043c0:	48 98                	cltq   
  8043c2:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8043c6:	76 35                	jbe    8043fd <devfile_read+0xa0>
  8043c8:	48 b9 8e 72 80 00 00 	movabs $0x80728e,%rcx
  8043cf:	00 00 00 
  8043d2:	48 ba 95 72 80 00 00 	movabs $0x807295,%rdx
  8043d9:	00 00 00 
  8043dc:	be 89 00 00 00       	mov    $0x89,%esi
  8043e1:	48 bf aa 72 80 00 00 	movabs $0x8072aa,%rdi
  8043e8:	00 00 00 
  8043eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8043f0:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8043f7:	00 00 00 
  8043fa:	41 ff d0             	callq  *%r8
  8043fd:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  804404:	7e 35                	jle    80443b <devfile_read+0xde>
  804406:	48 b9 b8 72 80 00 00 	movabs $0x8072b8,%rcx
  80440d:	00 00 00 
  804410:	48 ba 95 72 80 00 00 	movabs $0x807295,%rdx
  804417:	00 00 00 
  80441a:	be 8a 00 00 00       	mov    $0x8a,%esi
  80441f:	48 bf aa 72 80 00 00 	movabs $0x8072aa,%rdi
  804426:	00 00 00 
  804429:	b8 00 00 00 00       	mov    $0x0,%eax
  80442e:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  804435:	00 00 00 
  804438:	41 ff d0             	callq  *%r8
  80443b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80443e:	48 63 d0             	movslq %eax,%rdx
  804441:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804445:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  80444c:	00 00 00 
  80444f:	48 89 c7             	mov    %rax,%rdi
  804452:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  804459:	00 00 00 
  80445c:	ff d0                	callq  *%rax
  80445e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804461:	c9                   	leaveq 
  804462:	c3                   	retq   

0000000000804463 <devfile_write>:
  804463:	55                   	push   %rbp
  804464:	48 89 e5             	mov    %rsp,%rbp
  804467:	48 83 ec 40          	sub    $0x40,%rsp
  80446b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80446f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804473:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804477:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80447b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80447f:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  804486:	00 
  804487:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80448b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  80448f:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  804494:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  804498:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80449c:	8b 50 0c             	mov    0xc(%rax),%edx
  80449f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8044a6:	00 00 00 
  8044a9:	89 10                	mov    %edx,(%rax)
  8044ab:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8044b2:	00 00 00 
  8044b5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8044b9:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8044bd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8044c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8044c5:	48 89 c6             	mov    %rax,%rsi
  8044c8:	48 bf 10 b0 80 00 00 	movabs $0x80b010,%rdi
  8044cf:	00 00 00 
  8044d2:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  8044d9:	00 00 00 
  8044dc:	ff d0                	callq  *%rax
  8044de:	be 00 00 00 00       	mov    $0x0,%esi
  8044e3:	bf 04 00 00 00       	mov    $0x4,%edi
  8044e8:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  8044ef:	00 00 00 
  8044f2:	ff d0                	callq  *%rax
  8044f4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8044f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8044fb:	79 05                	jns    804502 <devfile_write+0x9f>
  8044fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804500:	eb 43                	jmp    804545 <devfile_write+0xe2>
  804502:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804505:	48 98                	cltq   
  804507:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80450b:	76 35                	jbe    804542 <devfile_write+0xdf>
  80450d:	48 b9 8e 72 80 00 00 	movabs $0x80728e,%rcx
  804514:	00 00 00 
  804517:	48 ba 95 72 80 00 00 	movabs $0x807295,%rdx
  80451e:	00 00 00 
  804521:	be a8 00 00 00       	mov    $0xa8,%esi
  804526:	48 bf aa 72 80 00 00 	movabs $0x8072aa,%rdi
  80452d:	00 00 00 
  804530:	b8 00 00 00 00       	mov    $0x0,%eax
  804535:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80453c:	00 00 00 
  80453f:	41 ff d0             	callq  *%r8
  804542:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804545:	c9                   	leaveq 
  804546:	c3                   	retq   

0000000000804547 <devfile_stat>:
  804547:	55                   	push   %rbp
  804548:	48 89 e5             	mov    %rsp,%rbp
  80454b:	48 83 ec 20          	sub    $0x20,%rsp
  80454f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804553:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80455b:	8b 50 0c             	mov    0xc(%rax),%edx
  80455e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804565:	00 00 00 
  804568:	89 10                	mov    %edx,(%rax)
  80456a:	be 00 00 00 00       	mov    $0x0,%esi
  80456f:	bf 05 00 00 00       	mov    $0x5,%edi
  804574:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  80457b:	00 00 00 
  80457e:	ff d0                	callq  *%rax
  804580:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804583:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804587:	79 05                	jns    80458e <devfile_stat+0x47>
  804589:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80458c:	eb 56                	jmp    8045e4 <devfile_stat+0x9d>
  80458e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804592:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  804599:	00 00 00 
  80459c:	48 89 c7             	mov    %rax,%rdi
  80459f:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  8045a6:	00 00 00 
  8045a9:	ff d0                	callq  *%rax
  8045ab:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8045b2:	00 00 00 
  8045b5:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8045bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8045bf:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8045c5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8045cc:	00 00 00 
  8045cf:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  8045d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8045d9:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  8045df:	b8 00 00 00 00       	mov    $0x0,%eax
  8045e4:	c9                   	leaveq 
  8045e5:	c3                   	retq   

00000000008045e6 <devfile_trunc>:
  8045e6:	55                   	push   %rbp
  8045e7:	48 89 e5             	mov    %rsp,%rbp
  8045ea:	48 83 ec 10          	sub    $0x10,%rsp
  8045ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8045f2:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8045f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045f9:	8b 50 0c             	mov    0xc(%rax),%edx
  8045fc:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804603:	00 00 00 
  804606:	89 10                	mov    %edx,(%rax)
  804608:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80460f:	00 00 00 
  804612:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804615:	89 50 04             	mov    %edx,0x4(%rax)
  804618:	be 00 00 00 00       	mov    $0x0,%esi
  80461d:	bf 02 00 00 00       	mov    $0x2,%edi
  804622:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  804629:	00 00 00 
  80462c:	ff d0                	callq  *%rax
  80462e:	c9                   	leaveq 
  80462f:	c3                   	retq   

0000000000804630 <remove>:
  804630:	55                   	push   %rbp
  804631:	48 89 e5             	mov    %rsp,%rbp
  804634:	48 83 ec 10          	sub    $0x10,%rsp
  804638:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80463c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804640:	48 89 c7             	mov    %rax,%rdi
  804643:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  80464a:	00 00 00 
  80464d:	ff d0                	callq  *%rax
  80464f:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  804654:	7e 07                	jle    80465d <remove+0x2d>
  804656:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80465b:	eb 33                	jmp    804690 <remove+0x60>
  80465d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804661:	48 89 c6             	mov    %rax,%rsi
  804664:	48 bf 00 b0 80 00 00 	movabs $0x80b000,%rdi
  80466b:	00 00 00 
  80466e:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  804675:	00 00 00 
  804678:	ff d0                	callq  *%rax
  80467a:	be 00 00 00 00       	mov    $0x0,%esi
  80467f:	bf 07 00 00 00       	mov    $0x7,%edi
  804684:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  80468b:	00 00 00 
  80468e:	ff d0                	callq  *%rax
  804690:	c9                   	leaveq 
  804691:	c3                   	retq   

0000000000804692 <sync>:
  804692:	55                   	push   %rbp
  804693:	48 89 e5             	mov    %rsp,%rbp
  804696:	be 00 00 00 00       	mov    $0x0,%esi
  80469b:	bf 08 00 00 00       	mov    $0x8,%edi
  8046a0:	48 b8 c5 41 80 00 00 	movabs $0x8041c5,%rax
  8046a7:	00 00 00 
  8046aa:	ff d0                	callq  *%rax
  8046ac:	5d                   	pop    %rbp
  8046ad:	c3                   	retq   

00000000008046ae <copy>:
  8046ae:	55                   	push   %rbp
  8046af:	48 89 e5             	mov    %rsp,%rbp
  8046b2:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8046b9:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  8046c0:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  8046c7:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  8046ce:	be 00 00 00 00       	mov    $0x0,%esi
  8046d3:	48 89 c7             	mov    %rax,%rdi
  8046d6:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  8046dd:	00 00 00 
  8046e0:	ff d0                	callq  *%rax
  8046e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046e9:	79 28                	jns    804713 <copy+0x65>
  8046eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046ee:	89 c6                	mov    %eax,%esi
  8046f0:	48 bf c4 72 80 00 00 	movabs $0x8072c4,%rdi
  8046f7:	00 00 00 
  8046fa:	b8 00 00 00 00       	mov    $0x0,%eax
  8046ff:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  804706:	00 00 00 
  804709:	ff d2                	callq  *%rdx
  80470b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80470e:	e9 74 01 00 00       	jmpq   804887 <copy+0x1d9>
  804713:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  80471a:	be 01 01 00 00       	mov    $0x101,%esi
  80471f:	48 89 c7             	mov    %rax,%rdi
  804722:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  804729:	00 00 00 
  80472c:	ff d0                	callq  *%rax
  80472e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804731:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  804735:	79 39                	jns    804770 <copy+0xc2>
  804737:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80473a:	89 c6                	mov    %eax,%esi
  80473c:	48 bf da 72 80 00 00 	movabs $0x8072da,%rdi
  804743:	00 00 00 
  804746:	b8 00 00 00 00       	mov    $0x0,%eax
  80474b:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  804752:	00 00 00 
  804755:	ff d2                	callq  *%rdx
  804757:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80475a:	89 c7                	mov    %eax,%edi
  80475c:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804763:	00 00 00 
  804766:	ff d0                	callq  *%rax
  804768:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80476b:	e9 17 01 00 00       	jmpq   804887 <copy+0x1d9>
  804770:	eb 74                	jmp    8047e6 <copy+0x138>
  804772:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804775:	48 63 d0             	movslq %eax,%rdx
  804778:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80477f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804782:	48 89 ce             	mov    %rcx,%rsi
  804785:	89 c7                	mov    %eax,%edi
  804787:	48 b8 c0 3e 80 00 00 	movabs $0x803ec0,%rax
  80478e:	00 00 00 
  804791:	ff d0                	callq  *%rax
  804793:	89 45 f0             	mov    %eax,-0x10(%rbp)
  804796:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80479a:	79 4a                	jns    8047e6 <copy+0x138>
  80479c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80479f:	89 c6                	mov    %eax,%esi
  8047a1:	48 bf f4 72 80 00 00 	movabs $0x8072f4,%rdi
  8047a8:	00 00 00 
  8047ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8047b0:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  8047b7:	00 00 00 
  8047ba:	ff d2                	callq  *%rdx
  8047bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047bf:	89 c7                	mov    %eax,%edi
  8047c1:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8047c8:	00 00 00 
  8047cb:	ff d0                	callq  *%rax
  8047cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047d0:	89 c7                	mov    %eax,%edi
  8047d2:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  8047d9:	00 00 00 
  8047dc:	ff d0                	callq  *%rax
  8047de:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8047e1:	e9 a1 00 00 00       	jmpq   804887 <copy+0x1d9>
  8047e6:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8047ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047f0:	ba 00 02 00 00       	mov    $0x200,%edx
  8047f5:	48 89 ce             	mov    %rcx,%rsi
  8047f8:	89 c7                	mov    %eax,%edi
  8047fa:	48 b8 76 3d 80 00 00 	movabs $0x803d76,%rax
  804801:	00 00 00 
  804804:	ff d0                	callq  *%rax
  804806:	89 45 f4             	mov    %eax,-0xc(%rbp)
  804809:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80480d:	0f 8f 5f ff ff ff    	jg     804772 <copy+0xc4>
  804813:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  804817:	79 47                	jns    804860 <copy+0x1b2>
  804819:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80481c:	89 c6                	mov    %eax,%esi
  80481e:	48 bf 07 73 80 00 00 	movabs $0x807307,%rdi
  804825:	00 00 00 
  804828:	b8 00 00 00 00       	mov    $0x0,%eax
  80482d:	48 ba 46 15 80 00 00 	movabs $0x801546,%rdx
  804834:	00 00 00 
  804837:	ff d2                	callq  *%rdx
  804839:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80483c:	89 c7                	mov    %eax,%edi
  80483e:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804845:	00 00 00 
  804848:	ff d0                	callq  *%rax
  80484a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80484d:	89 c7                	mov    %eax,%edi
  80484f:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804856:	00 00 00 
  804859:	ff d0                	callq  *%rax
  80485b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80485e:	eb 27                	jmp    804887 <copy+0x1d9>
  804860:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804863:	89 c7                	mov    %eax,%edi
  804865:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  80486c:	00 00 00 
  80486f:	ff d0                	callq  *%rax
  804871:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804874:	89 c7                	mov    %eax,%edi
  804876:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  80487d:	00 00 00 
  804880:	ff d0                	callq  *%rax
  804882:	b8 00 00 00 00       	mov    $0x0,%eax
  804887:	c9                   	leaveq 
  804888:	c3                   	retq   

0000000000804889 <writebuf>:
  804889:	55                   	push   %rbp
  80488a:	48 89 e5             	mov    %rsp,%rbp
  80488d:	48 83 ec 20          	sub    $0x20,%rsp
  804891:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804895:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804899:	8b 40 0c             	mov    0xc(%rax),%eax
  80489c:	85 c0                	test   %eax,%eax
  80489e:	7e 67                	jle    804907 <writebuf+0x7e>
  8048a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048a4:	8b 40 04             	mov    0x4(%rax),%eax
  8048a7:	48 63 d0             	movslq %eax,%rdx
  8048aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048ae:	48 8d 48 10          	lea    0x10(%rax),%rcx
  8048b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048b6:	8b 00                	mov    (%rax),%eax
  8048b8:	48 89 ce             	mov    %rcx,%rsi
  8048bb:	89 c7                	mov    %eax,%edi
  8048bd:	48 b8 c0 3e 80 00 00 	movabs $0x803ec0,%rax
  8048c4:	00 00 00 
  8048c7:	ff d0                	callq  *%rax
  8048c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048d0:	7e 13                	jle    8048e5 <writebuf+0x5c>
  8048d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048d6:	8b 50 08             	mov    0x8(%rax),%edx
  8048d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048dc:	01 c2                	add    %eax,%edx
  8048de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048e2:	89 50 08             	mov    %edx,0x8(%rax)
  8048e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048e9:	8b 40 04             	mov    0x4(%rax),%eax
  8048ec:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  8048ef:	74 16                	je     804907 <writebuf+0x7e>
  8048f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8048f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048fa:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  8048fe:	89 c2                	mov    %eax,%edx
  804900:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804904:	89 50 0c             	mov    %edx,0xc(%rax)
  804907:	c9                   	leaveq 
  804908:	c3                   	retq   

0000000000804909 <putch>:
  804909:	55                   	push   %rbp
  80490a:	48 89 e5             	mov    %rsp,%rbp
  80490d:	48 83 ec 20          	sub    $0x20,%rsp
  804911:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804914:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804918:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80491c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804920:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804924:	8b 40 04             	mov    0x4(%rax),%eax
  804927:	8d 48 01             	lea    0x1(%rax),%ecx
  80492a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80492e:	89 4a 04             	mov    %ecx,0x4(%rdx)
  804931:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804934:	89 d1                	mov    %edx,%ecx
  804936:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80493a:	48 98                	cltq   
  80493c:	88 4c 02 10          	mov    %cl,0x10(%rdx,%rax,1)
  804940:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804944:	8b 40 04             	mov    0x4(%rax),%eax
  804947:	3d 00 01 00 00       	cmp    $0x100,%eax
  80494c:	75 1e                	jne    80496c <putch+0x63>
  80494e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804952:	48 89 c7             	mov    %rax,%rdi
  804955:	48 b8 89 48 80 00 00 	movabs $0x804889,%rax
  80495c:	00 00 00 
  80495f:	ff d0                	callq  *%rax
  804961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804965:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  80496c:	c9                   	leaveq 
  80496d:	c3                   	retq   

000000000080496e <vfprintf>:
  80496e:	55                   	push   %rbp
  80496f:	48 89 e5             	mov    %rsp,%rbp
  804972:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  804979:	89 bd ec fe ff ff    	mov    %edi,-0x114(%rbp)
  80497f:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  804986:	48 89 95 d8 fe ff ff 	mov    %rdx,-0x128(%rbp)
  80498d:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  804993:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%rbp)
  804999:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8049a0:	00 00 00 
  8049a3:	c7 85 f8 fe ff ff 00 	movl   $0x0,-0x108(%rbp)
  8049aa:	00 00 00 
  8049ad:	c7 85 fc fe ff ff 01 	movl   $0x1,-0x104(%rbp)
  8049b4:	00 00 00 
  8049b7:	48 8b 8d d8 fe ff ff 	mov    -0x128(%rbp),%rcx
  8049be:	48 8b 95 e0 fe ff ff 	mov    -0x120(%rbp),%rdx
  8049c5:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8049cc:	48 89 c6             	mov    %rax,%rsi
  8049cf:	48 bf 09 49 80 00 00 	movabs $0x804909,%rdi
  8049d6:	00 00 00 
  8049d9:	48 b8 f9 18 80 00 00 	movabs $0x8018f9,%rax
  8049e0:	00 00 00 
  8049e3:	ff d0                	callq  *%rax
  8049e5:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8049eb:	85 c0                	test   %eax,%eax
  8049ed:	7e 16                	jle    804a05 <vfprintf+0x97>
  8049ef:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8049f6:	48 89 c7             	mov    %rax,%rdi
  8049f9:	48 b8 89 48 80 00 00 	movabs $0x804889,%rax
  804a00:	00 00 00 
  804a03:	ff d0                	callq  *%rax
  804a05:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  804a0b:	85 c0                	test   %eax,%eax
  804a0d:	74 08                	je     804a17 <vfprintf+0xa9>
  804a0f:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  804a15:	eb 06                	jmp    804a1d <vfprintf+0xaf>
  804a17:	8b 85 fc fe ff ff    	mov    -0x104(%rbp),%eax
  804a1d:	c9                   	leaveq 
  804a1e:	c3                   	retq   

0000000000804a1f <fprintf>:
  804a1f:	55                   	push   %rbp
  804a20:	48 89 e5             	mov    %rsp,%rbp
  804a23:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  804a2a:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%rbp)
  804a30:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  804a37:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  804a3e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  804a45:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  804a4c:	84 c0                	test   %al,%al
  804a4e:	74 20                	je     804a70 <fprintf+0x51>
  804a50:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  804a54:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  804a58:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  804a5c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  804a60:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  804a64:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  804a68:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  804a6c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  804a70:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  804a77:	c7 85 30 ff ff ff 10 	movl   $0x10,-0xd0(%rbp)
  804a7e:	00 00 00 
  804a81:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  804a88:	00 00 00 
  804a8b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  804a8f:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  804a96:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  804a9d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  804aa4:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  804aab:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
  804ab2:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  804ab8:	48 89 ce             	mov    %rcx,%rsi
  804abb:	89 c7                	mov    %eax,%edi
  804abd:	48 b8 6e 49 80 00 00 	movabs $0x80496e,%rax
  804ac4:	00 00 00 
  804ac7:	ff d0                	callq  *%rax
  804ac9:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  804acf:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  804ad5:	c9                   	leaveq 
  804ad6:	c3                   	retq   

0000000000804ad7 <printf>:
  804ad7:	55                   	push   %rbp
  804ad8:	48 89 e5             	mov    %rsp,%rbp
  804adb:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  804ae2:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  804ae9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  804af0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  804af7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  804afe:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  804b05:	84 c0                	test   %al,%al
  804b07:	74 20                	je     804b29 <printf+0x52>
  804b09:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  804b0d:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  804b11:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  804b15:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  804b19:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  804b1d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  804b21:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  804b25:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  804b29:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  804b30:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  804b37:	00 00 00 
  804b3a:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  804b41:	00 00 00 
  804b44:	48 8d 45 10          	lea    0x10(%rbp),%rax
  804b48:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  804b4f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  804b56:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  804b5d:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  804b64:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  804b6b:	48 89 c6             	mov    %rax,%rsi
  804b6e:	bf 01 00 00 00       	mov    $0x1,%edi
  804b73:	48 b8 6e 49 80 00 00 	movabs $0x80496e,%rax
  804b7a:	00 00 00 
  804b7d:	ff d0                	callq  *%rax
  804b7f:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  804b85:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  804b8b:	c9                   	leaveq 
  804b8c:	c3                   	retq   

0000000000804b8d <spawn>:
  804b8d:	55                   	push   %rbp
  804b8e:	48 89 e5             	mov    %rsp,%rbp
  804b91:	48 81 ec 10 03 00 00 	sub    $0x310,%rsp
  804b98:	48 89 bd 08 fd ff ff 	mov    %rdi,-0x2f8(%rbp)
  804b9f:	48 89 b5 00 fd ff ff 	mov    %rsi,-0x300(%rbp)
  804ba6:	48 8b 85 08 fd ff ff 	mov    -0x2f8(%rbp),%rax
  804bad:	be 00 00 00 00       	mov    $0x0,%esi
  804bb2:	48 89 c7             	mov    %rax,%rdi
  804bb5:	48 b8 4c 42 80 00 00 	movabs $0x80424c,%rax
  804bbc:	00 00 00 
  804bbf:	ff d0                	callq  *%rax
  804bc1:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804bc4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804bc8:	79 08                	jns    804bd2 <spawn+0x45>
  804bca:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804bcd:	e9 0c 03 00 00       	jmpq   804ede <spawn+0x351>
  804bd2:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804bd5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804bd8:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
  804bdf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  804be3:	48 8d 8d d0 fd ff ff 	lea    -0x230(%rbp),%rcx
  804bea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804bed:	ba 00 02 00 00       	mov    $0x200,%edx
  804bf2:	48 89 ce             	mov    %rcx,%rsi
  804bf5:	89 c7                	mov    %eax,%edi
  804bf7:	48 b8 4b 3e 80 00 00 	movabs $0x803e4b,%rax
  804bfe:	00 00 00 
  804c01:	ff d0                	callq  *%rax
  804c03:	3d 00 02 00 00       	cmp    $0x200,%eax
  804c08:	75 0d                	jne    804c17 <spawn+0x8a>
  804c0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804c0e:	8b 00                	mov    (%rax),%eax
  804c10:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  804c15:	74 43                	je     804c5a <spawn+0xcd>
  804c17:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804c1a:	89 c7                	mov    %eax,%edi
  804c1c:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804c23:	00 00 00 
  804c26:	ff d0                	callq  *%rax
  804c28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804c2c:	8b 00                	mov    (%rax),%eax
  804c2e:	ba 7f 45 4c 46       	mov    $0x464c457f,%edx
  804c33:	89 c6                	mov    %eax,%esi
  804c35:	48 bf 20 73 80 00 00 	movabs $0x807320,%rdi
  804c3c:	00 00 00 
  804c3f:	b8 00 00 00 00       	mov    $0x0,%eax
  804c44:	48 b9 46 15 80 00 00 	movabs $0x801546,%rcx
  804c4b:	00 00 00 
  804c4e:	ff d1                	callq  *%rcx
  804c50:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
  804c55:	e9 84 02 00 00       	jmpq   804ede <spawn+0x351>
  804c5a:	b8 07 00 00 00       	mov    $0x7,%eax
  804c5f:	cd 30                	int    $0x30
  804c61:	89 45 d0             	mov    %eax,-0x30(%rbp)
  804c64:	8b 45 d0             	mov    -0x30(%rbp),%eax
  804c67:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804c6a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804c6e:	79 08                	jns    804c78 <spawn+0xeb>
  804c70:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804c73:	e9 66 02 00 00       	jmpq   804ede <spawn+0x351>
  804c78:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804c7b:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  804c7e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804c81:	25 ff 03 00 00       	and    $0x3ff,%eax
  804c86:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804c8d:	00 00 00 
  804c90:	48 98                	cltq   
  804c92:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804c99:	48 01 d0             	add    %rdx,%rax
  804c9c:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  804ca3:	48 89 c6             	mov    %rax,%rsi
  804ca6:	b8 18 00 00 00       	mov    $0x18,%eax
  804cab:	48 89 d7             	mov    %rdx,%rdi
  804cae:	48 89 c1             	mov    %rax,%rcx
  804cb1:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  804cb4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804cb8:	48 8b 40 18          	mov    0x18(%rax),%rax
  804cbc:	48 89 85 a8 fd ff ff 	mov    %rax,-0x258(%rbp)
  804cc3:	48 8d 85 10 fd ff ff 	lea    -0x2f0(%rbp),%rax
  804cca:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
  804cd1:	48 8b 8d 00 fd ff ff 	mov    -0x300(%rbp),%rcx
  804cd8:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804cdb:	48 89 ce             	mov    %rcx,%rsi
  804cde:	89 c7                	mov    %eax,%edi
  804ce0:	48 b8 48 51 80 00 00 	movabs $0x805148,%rax
  804ce7:	00 00 00 
  804cea:	ff d0                	callq  *%rax
  804cec:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804cef:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804cf3:	79 08                	jns    804cfd <spawn+0x170>
  804cf5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804cf8:	e9 e1 01 00 00       	jmpq   804ede <spawn+0x351>
  804cfd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804d01:	48 8b 40 20          	mov    0x20(%rax),%rax
  804d05:	48 8d 95 d0 fd ff ff 	lea    -0x230(%rbp),%rdx
  804d0c:	48 01 d0             	add    %rdx,%rax
  804d0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804d13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804d1a:	e9 a3 00 00 00       	jmpq   804dc2 <spawn+0x235>
  804d1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d23:	8b 00                	mov    (%rax),%eax
  804d25:	83 f8 01             	cmp    $0x1,%eax
  804d28:	74 05                	je     804d2f <spawn+0x1a2>
  804d2a:	e9 8a 00 00 00       	jmpq   804db9 <spawn+0x22c>
  804d2f:	c7 45 ec 05 00 00 00 	movl   $0x5,-0x14(%rbp)
  804d36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d3a:	8b 40 04             	mov    0x4(%rax),%eax
  804d3d:	83 e0 02             	and    $0x2,%eax
  804d40:	85 c0                	test   %eax,%eax
  804d42:	74 04                	je     804d48 <spawn+0x1bb>
  804d44:	83 4d ec 02          	orl    $0x2,-0x14(%rbp)
  804d48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d4c:	48 8b 40 08          	mov    0x8(%rax),%rax
  804d50:	41 89 c1             	mov    %eax,%r9d
  804d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d57:	4c 8b 40 20          	mov    0x20(%rax),%r8
  804d5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d5f:	48 8b 50 28          	mov    0x28(%rax),%rdx
  804d63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d67:	48 8b 70 10          	mov    0x10(%rax),%rsi
  804d6b:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  804d6e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804d71:	8b 7d ec             	mov    -0x14(%rbp),%edi
  804d74:	89 3c 24             	mov    %edi,(%rsp)
  804d77:	89 c7                	mov    %eax,%edi
  804d79:	48 b8 f1 53 80 00 00 	movabs $0x8053f1,%rax
  804d80:	00 00 00 
  804d83:	ff d0                	callq  *%rax
  804d85:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804d88:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804d8c:	79 2b                	jns    804db9 <spawn+0x22c>
  804d8e:	90                   	nop
  804d8f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804d92:	89 c7                	mov    %eax,%edi
  804d94:	48 b8 c4 2a 80 00 00 	movabs $0x802ac4,%rax
  804d9b:	00 00 00 
  804d9e:	ff d0                	callq  *%rax
  804da0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804da3:	89 c7                	mov    %eax,%edi
  804da5:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804dac:	00 00 00 
  804daf:	ff d0                	callq  *%rax
  804db1:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804db4:	e9 25 01 00 00       	jmpq   804ede <spawn+0x351>
  804db9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804dbd:	48 83 45 f0 38       	addq   $0x38,-0x10(%rbp)
  804dc2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804dc6:	0f b7 40 38          	movzwl 0x38(%rax),%eax
  804dca:	0f b7 c0             	movzwl %ax,%eax
  804dcd:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  804dd0:	0f 8f 49 ff ff ff    	jg     804d1f <spawn+0x192>
  804dd6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  804dd9:	89 c7                	mov    %eax,%edi
  804ddb:	48 b8 54 3b 80 00 00 	movabs $0x803b54,%rax
  804de2:	00 00 00 
  804de5:	ff d0                	callq  *%rax
  804de7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
  804dee:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804df1:	89 c7                	mov    %eax,%edi
  804df3:	48 b8 dd 55 80 00 00 	movabs $0x8055dd,%rax
  804dfa:	00 00 00 
  804dfd:	ff d0                	callq  *%rax
  804dff:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804e02:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804e06:	79 30                	jns    804e38 <spawn+0x2ab>
  804e08:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804e0b:	89 c1                	mov    %eax,%ecx
  804e0d:	48 ba 3a 73 80 00 00 	movabs $0x80733a,%rdx
  804e14:	00 00 00 
  804e17:	be 86 00 00 00       	mov    $0x86,%esi
  804e1c:	48 bf 50 73 80 00 00 	movabs $0x807350,%rdi
  804e23:	00 00 00 
  804e26:	b8 00 00 00 00       	mov    $0x0,%eax
  804e2b:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  804e32:	00 00 00 
  804e35:	41 ff d0             	callq  *%r8
  804e38:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  804e3f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804e42:	48 89 d6             	mov    %rdx,%rsi
  804e45:	89 c7                	mov    %eax,%edi
  804e47:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  804e4e:	00 00 00 
  804e51:	ff d0                	callq  *%rax
  804e53:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804e56:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804e5a:	79 30                	jns    804e8c <spawn+0x2ff>
  804e5c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804e5f:	89 c1                	mov    %eax,%ecx
  804e61:	48 ba 5f 73 80 00 00 	movabs $0x80735f,%rdx
  804e68:	00 00 00 
  804e6b:	be 8a 00 00 00       	mov    $0x8a,%esi
  804e70:	48 bf 50 73 80 00 00 	movabs $0x807350,%rdi
  804e77:	00 00 00 
  804e7a:	b8 00 00 00 00       	mov    $0x0,%eax
  804e7f:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  804e86:	00 00 00 
  804e89:	41 ff d0             	callq  *%r8
  804e8c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804e8f:	be 02 00 00 00       	mov    $0x2,%esi
  804e94:	89 c7                	mov    %eax,%edi
  804e96:	48 b8 79 2c 80 00 00 	movabs $0x802c79,%rax
  804e9d:	00 00 00 
  804ea0:	ff d0                	callq  *%rax
  804ea2:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804ea5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  804ea9:	79 30                	jns    804edb <spawn+0x34e>
  804eab:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804eae:	89 c1                	mov    %eax,%ecx
  804eb0:	48 ba 79 73 80 00 00 	movabs $0x807379,%rdx
  804eb7:	00 00 00 
  804eba:	be 8d 00 00 00       	mov    $0x8d,%esi
  804ebf:	48 bf 50 73 80 00 00 	movabs $0x807350,%rdi
  804ec6:	00 00 00 
  804ec9:	b8 00 00 00 00       	mov    $0x0,%eax
  804ece:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  804ed5:	00 00 00 
  804ed8:	41 ff d0             	callq  *%r8
  804edb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  804ede:	c9                   	leaveq 
  804edf:	c3                   	retq   

0000000000804ee0 <spawnl>:
  804ee0:	55                   	push   %rbp
  804ee1:	48 89 e5             	mov    %rsp,%rbp
  804ee4:	41 55                	push   %r13
  804ee6:	41 54                	push   %r12
  804ee8:	53                   	push   %rbx
  804ee9:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  804ef0:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
  804ef7:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
  804efe:	48 89 8d 48 ff ff ff 	mov    %rcx,-0xb8(%rbp)
  804f05:	4c 89 85 50 ff ff ff 	mov    %r8,-0xb0(%rbp)
  804f0c:	4c 89 8d 58 ff ff ff 	mov    %r9,-0xa8(%rbp)
  804f13:	84 c0                	test   %al,%al
  804f15:	74 26                	je     804f3d <spawnl+0x5d>
  804f17:	0f 29 85 60 ff ff ff 	movaps %xmm0,-0xa0(%rbp)
  804f1e:	0f 29 8d 70 ff ff ff 	movaps %xmm1,-0x90(%rbp)
  804f25:	0f 29 55 80          	movaps %xmm2,-0x80(%rbp)
  804f29:	0f 29 5d 90          	movaps %xmm3,-0x70(%rbp)
  804f2d:	0f 29 65 a0          	movaps %xmm4,-0x60(%rbp)
  804f31:	0f 29 6d b0          	movaps %xmm5,-0x50(%rbp)
  804f35:	0f 29 75 c0          	movaps %xmm6,-0x40(%rbp)
  804f39:	0f 29 7d d0          	movaps %xmm7,-0x30(%rbp)
  804f3d:	48 89 b5 f0 fe ff ff 	mov    %rsi,-0x110(%rbp)
  804f44:	c7 85 2c ff ff ff 00 	movl   $0x0,-0xd4(%rbp)
  804f4b:	00 00 00 
  804f4e:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  804f55:	00 00 00 
  804f58:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  804f5f:	00 00 00 
  804f62:	48 8d 45 10          	lea    0x10(%rbp),%rax
  804f66:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  804f6d:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  804f74:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  804f7b:	eb 07                	jmp    804f84 <spawnl+0xa4>
  804f7d:	83 85 2c ff ff ff 01 	addl   $0x1,-0xd4(%rbp)
  804f84:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  804f8a:	83 f8 30             	cmp    $0x30,%eax
  804f8d:	73 23                	jae    804fb2 <spawnl+0xd2>
  804f8f:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  804f96:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  804f9c:	89 c0                	mov    %eax,%eax
  804f9e:	48 01 d0             	add    %rdx,%rax
  804fa1:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  804fa7:	83 c2 08             	add    $0x8,%edx
  804faa:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  804fb0:	eb 15                	jmp    804fc7 <spawnl+0xe7>
  804fb2:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  804fb9:	48 89 d0             	mov    %rdx,%rax
  804fbc:	48 83 c2 08          	add    $0x8,%rdx
  804fc0:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  804fc7:	48 8b 00             	mov    (%rax),%rax
  804fca:	48 85 c0             	test   %rax,%rax
  804fcd:	75 ae                	jne    804f7d <spawnl+0x9d>
  804fcf:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  804fd5:	83 c0 02             	add    $0x2,%eax
  804fd8:	48 89 e2             	mov    %rsp,%rdx
  804fdb:	48 89 d3             	mov    %rdx,%rbx
  804fde:	48 63 d0             	movslq %eax,%rdx
  804fe1:	48 83 ea 01          	sub    $0x1,%rdx
  804fe5:	48 89 95 20 ff ff ff 	mov    %rdx,-0xe0(%rbp)
  804fec:	48 63 d0             	movslq %eax,%rdx
  804fef:	49 89 d4             	mov    %rdx,%r12
  804ff2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  804ff8:	48 63 d0             	movslq %eax,%rdx
  804ffb:	49 89 d2             	mov    %rdx,%r10
  804ffe:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  805004:	48 98                	cltq   
  805006:	48 c1 e0 03          	shl    $0x3,%rax
  80500a:	48 8d 50 07          	lea    0x7(%rax),%rdx
  80500e:	b8 10 00 00 00       	mov    $0x10,%eax
  805013:	48 83 e8 01          	sub    $0x1,%rax
  805017:	48 01 d0             	add    %rdx,%rax
  80501a:	bf 10 00 00 00       	mov    $0x10,%edi
  80501f:	ba 00 00 00 00       	mov    $0x0,%edx
  805024:	48 f7 f7             	div    %rdi
  805027:	48 6b c0 10          	imul   $0x10,%rax,%rax
  80502b:	48 29 c4             	sub    %rax,%rsp
  80502e:	48 89 e0             	mov    %rsp,%rax
  805031:	48 83 c0 07          	add    $0x7,%rax
  805035:	48 c1 e8 03          	shr    $0x3,%rax
  805039:	48 c1 e0 03          	shl    $0x3,%rax
  80503d:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
  805044:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  80504b:	48 8b 95 f0 fe ff ff 	mov    -0x110(%rbp),%rdx
  805052:	48 89 10             	mov    %rdx,(%rax)
  805055:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  80505b:	8d 50 01             	lea    0x1(%rax),%edx
  80505e:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  805065:	48 63 d2             	movslq %edx,%rdx
  805068:	48 c7 04 d0 00 00 00 	movq   $0x0,(%rax,%rdx,8)
  80506f:	00 
  805070:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  805077:	00 00 00 
  80507a:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  805081:	00 00 00 
  805084:	48 8d 45 10          	lea    0x10(%rbp),%rax
  805088:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  80508f:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  805096:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  80509d:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
  8050a4:	00 00 00 
  8050a7:	eb 63                	jmp    80510c <spawnl+0x22c>
  8050a9:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
  8050af:	8d 70 01             	lea    0x1(%rax),%esi
  8050b2:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8050b8:	83 f8 30             	cmp    $0x30,%eax
  8050bb:	73 23                	jae    8050e0 <spawnl+0x200>
  8050bd:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  8050c4:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8050ca:	89 c0                	mov    %eax,%eax
  8050cc:	48 01 d0             	add    %rdx,%rax
  8050cf:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  8050d5:	83 c2 08             	add    $0x8,%edx
  8050d8:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  8050de:	eb 15                	jmp    8050f5 <spawnl+0x215>
  8050e0:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  8050e7:	48 89 d0             	mov    %rdx,%rax
  8050ea:	48 83 c2 08          	add    $0x8,%rdx
  8050ee:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8050f5:	48 8b 08             	mov    (%rax),%rcx
  8050f8:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  8050ff:	89 f2                	mov    %esi,%edx
  805101:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
  805105:	83 85 28 ff ff ff 01 	addl   $0x1,-0xd8(%rbp)
  80510c:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  805112:	3b 85 28 ff ff ff    	cmp    -0xd8(%rbp),%eax
  805118:	77 8f                	ja     8050a9 <spawnl+0x1c9>
  80511a:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  805121:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
  805128:	48 89 d6             	mov    %rdx,%rsi
  80512b:	48 89 c7             	mov    %rax,%rdi
  80512e:	48 b8 8d 4b 80 00 00 	movabs $0x804b8d,%rax
  805135:	00 00 00 
  805138:	ff d0                	callq  *%rax
  80513a:	48 89 dc             	mov    %rbx,%rsp
  80513d:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
  805141:	5b                   	pop    %rbx
  805142:	41 5c                	pop    %r12
  805144:	41 5d                	pop    %r13
  805146:	5d                   	pop    %rbp
  805147:	c3                   	retq   

0000000000805148 <init_stack>:
  805148:	55                   	push   %rbp
  805149:	48 89 e5             	mov    %rsp,%rbp
  80514c:	48 83 ec 50          	sub    $0x50,%rsp
  805150:	89 7d cc             	mov    %edi,-0x34(%rbp)
  805153:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  805157:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  80515b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  805162:	00 
  805163:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  80516a:	eb 33                	jmp    80519f <init_stack+0x57>
  80516c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80516f:	48 98                	cltq   
  805171:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  805178:	00 
  805179:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  80517d:	48 01 d0             	add    %rdx,%rax
  805180:	48 8b 00             	mov    (%rax),%rax
  805183:	48 89 c7             	mov    %rax,%rdi
  805186:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  80518d:	00 00 00 
  805190:	ff d0                	callq  *%rax
  805192:	83 c0 01             	add    $0x1,%eax
  805195:	48 98                	cltq   
  805197:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80519b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
  80519f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051a2:	48 98                	cltq   
  8051a4:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8051ab:	00 
  8051ac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8051b0:	48 01 d0             	add    %rdx,%rax
  8051b3:	48 8b 00             	mov    (%rax),%rax
  8051b6:	48 85 c0             	test   %rax,%rax
  8051b9:	75 b1                	jne    80516c <init_stack+0x24>
  8051bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8051bf:	48 f7 d8             	neg    %rax
  8051c2:	48 05 00 10 40 00    	add    $0x401000,%rax
  8051c8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8051cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8051d0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8051d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8051d8:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  8051dc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8051df:	83 c2 01             	add    $0x1,%edx
  8051e2:	c1 e2 03             	shl    $0x3,%edx
  8051e5:	48 63 d2             	movslq %edx,%rdx
  8051e8:	48 f7 da             	neg    %rdx
  8051eb:	48 01 d0             	add    %rdx,%rax
  8051ee:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8051f2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8051f6:	48 83 e8 10          	sub    $0x10,%rax
  8051fa:	48 3d ff ff 3f 00    	cmp    $0x3fffff,%rax
  805200:	77 0a                	ja     80520c <init_stack+0xc4>
  805202:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  805207:	e9 e3 01 00 00       	jmpq   8053ef <init_stack+0x2a7>
  80520c:	ba 07 00 00 00       	mov    $0x7,%edx
  805211:	be 00 00 40 00       	mov    $0x400000,%esi
  805216:	bf 00 00 00 00       	mov    $0x0,%edi
  80521b:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  805222:	00 00 00 
  805225:	ff d0                	callq  *%rax
  805227:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80522a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80522e:	79 08                	jns    805238 <init_stack+0xf0>
  805230:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805233:	e9 b7 01 00 00       	jmpq   8053ef <init_stack+0x2a7>
  805238:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  80523f:	e9 8a 00 00 00       	jmpq   8052ce <init_stack+0x186>
  805244:	8b 45 f0             	mov    -0x10(%rbp),%eax
  805247:	48 98                	cltq   
  805249:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  805250:	00 
  805251:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805255:	48 01 c2             	add    %rax,%rdx
  805258:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  80525d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805261:	48 01 c8             	add    %rcx,%rax
  805264:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  80526a:	48 89 02             	mov    %rax,(%rdx)
  80526d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  805270:	48 98                	cltq   
  805272:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  805279:	00 
  80527a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  80527e:	48 01 d0             	add    %rdx,%rax
  805281:	48 8b 10             	mov    (%rax),%rdx
  805284:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805288:	48 89 d6             	mov    %rdx,%rsi
  80528b:	48 89 c7             	mov    %rax,%rdi
  80528e:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  805295:	00 00 00 
  805298:	ff d0                	callq  *%rax
  80529a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80529d:	48 98                	cltq   
  80529f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8052a6:	00 
  8052a7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8052ab:	48 01 d0             	add    %rdx,%rax
  8052ae:	48 8b 00             	mov    (%rax),%rax
  8052b1:	48 89 c7             	mov    %rax,%rdi
  8052b4:	48 b8 e9 21 80 00 00 	movabs $0x8021e9,%rax
  8052bb:	00 00 00 
  8052be:	ff d0                	callq  *%rax
  8052c0:	48 98                	cltq   
  8052c2:	48 83 c0 01          	add    $0x1,%rax
  8052c6:	48 01 45 e0          	add    %rax,-0x20(%rbp)
  8052ca:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  8052ce:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8052d1:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8052d4:	0f 8c 6a ff ff ff    	jl     805244 <init_stack+0xfc>
  8052da:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8052dd:	48 98                	cltq   
  8052df:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8052e6:	00 
  8052e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8052eb:	48 01 d0             	add    %rdx,%rax
  8052ee:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8052f5:	48 81 7d e0 00 10 40 	cmpq   $0x401000,-0x20(%rbp)
  8052fc:	00 
  8052fd:	74 35                	je     805334 <init_stack+0x1ec>
  8052ff:	48 b9 90 73 80 00 00 	movabs $0x807390,%rcx
  805306:	00 00 00 
  805309:	48 ba b6 73 80 00 00 	movabs $0x8073b6,%rdx
  805310:	00 00 00 
  805313:	be f6 00 00 00       	mov    $0xf6,%esi
  805318:	48 bf 50 73 80 00 00 	movabs $0x807350,%rdi
  80531f:	00 00 00 
  805322:	b8 00 00 00 00       	mov    $0x0,%eax
  805327:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80532e:	00 00 00 
  805331:	41 ff d0             	callq  *%r8
  805334:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805338:	48 8d 50 f8          	lea    -0x8(%rax),%rdx
  80533c:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  805341:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805345:	48 01 c8             	add    %rcx,%rax
  805348:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  80534e:	48 89 02             	mov    %rax,(%rdx)
  805351:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805355:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
  805359:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80535c:	48 98                	cltq   
  80535e:	48 89 02             	mov    %rax,(%rdx)
  805361:	ba f0 cf 7f ef       	mov    $0xef7fcff0,%edx
  805366:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80536a:	48 01 d0             	add    %rdx,%rax
  80536d:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  805373:	48 89 c2             	mov    %rax,%rdx
  805376:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  80537a:	48 89 10             	mov    %rdx,(%rax)
  80537d:	8b 45 cc             	mov    -0x34(%rbp),%eax
  805380:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  805386:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  80538b:	89 c2                	mov    %eax,%edx
  80538d:	be 00 00 40 00       	mov    $0x400000,%esi
  805392:	bf 00 00 00 00       	mov    $0x0,%edi
  805397:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  80539e:	00 00 00 
  8053a1:	ff d0                	callq  *%rax
  8053a3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8053a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8053aa:	79 02                	jns    8053ae <init_stack+0x266>
  8053ac:	eb 28                	jmp    8053d6 <init_stack+0x28e>
  8053ae:	be 00 00 40 00       	mov    $0x400000,%esi
  8053b3:	bf 00 00 00 00       	mov    $0x0,%edi
  8053b8:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8053bf:	00 00 00 
  8053c2:	ff d0                	callq  *%rax
  8053c4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8053c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8053cb:	79 02                	jns    8053cf <init_stack+0x287>
  8053cd:	eb 07                	jmp    8053d6 <init_stack+0x28e>
  8053cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8053d4:	eb 19                	jmp    8053ef <init_stack+0x2a7>
  8053d6:	be 00 00 40 00       	mov    $0x400000,%esi
  8053db:	bf 00 00 00 00       	mov    $0x0,%edi
  8053e0:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8053e7:	00 00 00 
  8053ea:	ff d0                	callq  *%rax
  8053ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8053ef:	c9                   	leaveq 
  8053f0:	c3                   	retq   

00000000008053f1 <map_segment>:
  8053f1:	55                   	push   %rbp
  8053f2:	48 89 e5             	mov    %rsp,%rbp
  8053f5:	48 83 ec 50          	sub    $0x50,%rsp
  8053f9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8053fc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  805400:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  805404:	89 4d d8             	mov    %ecx,-0x28(%rbp)
  805407:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80540b:	44 89 4d bc          	mov    %r9d,-0x44(%rbp)
  80540f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805413:	25 ff 0f 00 00       	and    $0xfff,%eax
  805418:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80541b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80541f:	74 21                	je     805442 <map_segment+0x51>
  805421:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805424:	48 98                	cltq   
  805426:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  80542a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80542d:	48 98                	cltq   
  80542f:	48 01 45 c8          	add    %rax,-0x38(%rbp)
  805433:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805436:	48 98                	cltq   
  805438:	48 01 45 c0          	add    %rax,-0x40(%rbp)
  80543c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80543f:	29 45 bc             	sub    %eax,-0x44(%rbp)
  805442:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  805449:	e9 79 01 00 00       	jmpq   8055c7 <map_segment+0x1d6>
  80544e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805451:	48 98                	cltq   
  805453:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
  805457:	72 3c                	jb     805495 <map_segment+0xa4>
  805459:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80545c:	48 63 d0             	movslq %eax,%rdx
  80545f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805463:	48 01 d0             	add    %rdx,%rax
  805466:	48 89 c1             	mov    %rax,%rcx
  805469:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80546c:	8b 55 10             	mov    0x10(%rbp),%edx
  80546f:	48 89 ce             	mov    %rcx,%rsi
  805472:	89 c7                	mov    %eax,%edi
  805474:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  80547b:	00 00 00 
  80547e:	ff d0                	callq  *%rax
  805480:	89 45 f8             	mov    %eax,-0x8(%rbp)
  805483:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  805487:	0f 89 33 01 00 00    	jns    8055c0 <map_segment+0x1cf>
  80548d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  805490:	e9 46 01 00 00       	jmpq   8055db <map_segment+0x1ea>
  805495:	ba 07 00 00 00       	mov    $0x7,%edx
  80549a:	be 00 00 40 00       	mov    $0x400000,%esi
  80549f:	bf 00 00 00 00       	mov    $0x0,%edi
  8054a4:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  8054ab:	00 00 00 
  8054ae:	ff d0                	callq  *%rax
  8054b0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8054b3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8054b7:	79 08                	jns    8054c1 <map_segment+0xd0>
  8054b9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8054bc:	e9 1a 01 00 00       	jmpq   8055db <map_segment+0x1ea>
  8054c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8054c4:	8b 55 bc             	mov    -0x44(%rbp),%edx
  8054c7:	01 c2                	add    %eax,%edx
  8054c9:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8054cc:	89 d6                	mov    %edx,%esi
  8054ce:	89 c7                	mov    %eax,%edi
  8054d0:	48 b8 94 3f 80 00 00 	movabs $0x803f94,%rax
  8054d7:	00 00 00 
  8054da:	ff d0                	callq  *%rax
  8054dc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8054df:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8054e3:	79 08                	jns    8054ed <map_segment+0xfc>
  8054e5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8054e8:	e9 ee 00 00 00       	jmpq   8055db <map_segment+0x1ea>
  8054ed:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%rbp)
  8054f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8054f7:	48 98                	cltq   
  8054f9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8054fd:	48 29 c2             	sub    %rax,%rdx
  805500:	48 89 d0             	mov    %rdx,%rax
  805503:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  805507:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80550a:	48 63 d0             	movslq %eax,%rdx
  80550d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805511:	48 39 c2             	cmp    %rax,%rdx
  805514:	48 0f 47 d0          	cmova  %rax,%rdx
  805518:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80551b:	be 00 00 40 00       	mov    $0x400000,%esi
  805520:	89 c7                	mov    %eax,%edi
  805522:	48 b8 4b 3e 80 00 00 	movabs $0x803e4b,%rax
  805529:	00 00 00 
  80552c:	ff d0                	callq  *%rax
  80552e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  805531:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  805535:	79 08                	jns    80553f <map_segment+0x14e>
  805537:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80553a:	e9 9c 00 00 00       	jmpq   8055db <map_segment+0x1ea>
  80553f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805542:	48 63 d0             	movslq %eax,%rdx
  805545:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805549:	48 01 d0             	add    %rdx,%rax
  80554c:	48 89 c2             	mov    %rax,%rdx
  80554f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  805552:	44 8b 45 10          	mov    0x10(%rbp),%r8d
  805556:	48 89 d1             	mov    %rdx,%rcx
  805559:	89 c2                	mov    %eax,%edx
  80555b:	be 00 00 40 00       	mov    $0x400000,%esi
  805560:	bf 00 00 00 00       	mov    $0x0,%edi
  805565:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  80556c:	00 00 00 
  80556f:	ff d0                	callq  *%rax
  805571:	89 45 f8             	mov    %eax,-0x8(%rbp)
  805574:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  805578:	79 30                	jns    8055aa <map_segment+0x1b9>
  80557a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80557d:	89 c1                	mov    %eax,%ecx
  80557f:	48 ba cb 73 80 00 00 	movabs $0x8073cb,%rdx
  805586:	00 00 00 
  805589:	be 29 01 00 00       	mov    $0x129,%esi
  80558e:	48 bf 50 73 80 00 00 	movabs $0x807350,%rdi
  805595:	00 00 00 
  805598:	b8 00 00 00 00       	mov    $0x0,%eax
  80559d:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8055a4:	00 00 00 
  8055a7:	41 ff d0             	callq  *%r8
  8055aa:	be 00 00 40 00       	mov    $0x400000,%esi
  8055af:	bf 00 00 00 00       	mov    $0x0,%edi
  8055b4:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8055bb:	00 00 00 
  8055be:	ff d0                	callq  *%rax
  8055c0:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
  8055c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8055ca:	48 98                	cltq   
  8055cc:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8055d0:	0f 82 78 fe ff ff    	jb     80544e <map_segment+0x5d>
  8055d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8055db:	c9                   	leaveq 
  8055dc:	c3                   	retq   

00000000008055dd <copy_shared_pages>:
  8055dd:	55                   	push   %rbp
  8055de:	48 89 e5             	mov    %rsp,%rbp
  8055e1:	48 83 ec 30          	sub    $0x30,%rsp
  8055e5:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8055e8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8055ef:	00 
  8055f0:	e9 eb 00 00 00       	jmpq   8056e0 <copy_shared_pages+0x103>
  8055f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8055f9:	48 c1 f8 12          	sar    $0x12,%rax
  8055fd:	48 89 c2             	mov    %rax,%rdx
  805600:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  805607:	01 00 00 
  80560a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80560e:	83 e0 01             	and    $0x1,%eax
  805611:	48 85 c0             	test   %rax,%rax
  805614:	74 21                	je     805637 <copy_shared_pages+0x5a>
  805616:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80561a:	48 c1 f8 09          	sar    $0x9,%rax
  80561e:	48 89 c2             	mov    %rax,%rdx
  805621:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  805628:	01 00 00 
  80562b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80562f:	83 e0 01             	and    $0x1,%eax
  805632:	48 85 c0             	test   %rax,%rax
  805635:	75 0d                	jne    805644 <copy_shared_pages+0x67>
  805637:	48 81 45 f8 00 02 00 	addq   $0x200,-0x8(%rbp)
  80563e:	00 
  80563f:	e9 9c 00 00 00       	jmpq   8056e0 <copy_shared_pages+0x103>
  805644:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805648:	48 05 00 02 00 00    	add    $0x200,%rax
  80564e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  805652:	eb 7e                	jmp    8056d2 <copy_shared_pages+0xf5>
  805654:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80565b:	01 00 00 
  80565e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  805662:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805666:	25 01 04 00 00       	and    $0x401,%eax
  80566b:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  805671:	75 5a                	jne    8056cd <copy_shared_pages+0xf0>
  805673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805677:	48 c1 e0 0c          	shl    $0xc,%rax
  80567b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80567f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  805686:	01 00 00 
  805689:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80568d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805691:	25 07 0e 00 00       	and    $0xe07,%eax
  805696:	89 c6                	mov    %eax,%esi
  805698:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80569c:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80569f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8056a3:	41 89 f0             	mov    %esi,%r8d
  8056a6:	48 89 c6             	mov    %rax,%rsi
  8056a9:	bf 00 00 00 00       	mov    $0x0,%edi
  8056ae:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  8056b5:	00 00 00 
  8056b8:	ff d0                	callq  *%rax
  8056ba:	48 98                	cltq   
  8056bc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8056c0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8056c5:	79 06                	jns    8056cd <copy_shared_pages+0xf0>
  8056c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8056cb:	eb 28                	jmp    8056f5 <copy_shared_pages+0x118>
  8056cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8056d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8056d6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8056da:	0f 8c 74 ff ff ff    	jl     805654 <copy_shared_pages+0x77>
  8056e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8056e4:	48 3d ff 07 00 08    	cmp    $0x80007ff,%rax
  8056ea:	0f 86 05 ff ff ff    	jbe    8055f5 <copy_shared_pages+0x18>
  8056f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8056f5:	c9                   	leaveq 
  8056f6:	c3                   	retq   

00000000008056f7 <fd2sockid>:
  8056f7:	55                   	push   %rbp
  8056f8:	48 89 e5             	mov    %rsp,%rbp
  8056fb:	48 83 ec 20          	sub    $0x20,%rsp
  8056ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805702:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  805706:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805709:	48 89 d6             	mov    %rdx,%rsi
  80570c:	89 c7                	mov    %eax,%edi
  80570e:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  805715:	00 00 00 
  805718:	ff d0                	callq  *%rax
  80571a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80571d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805721:	79 05                	jns    805728 <fd2sockid+0x31>
  805723:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805726:	eb 24                	jmp    80574c <fd2sockid+0x55>
  805728:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80572c:	8b 10                	mov    (%rax),%edx
  80572e:	48 b8 e0 90 80 00 00 	movabs $0x8090e0,%rax
  805735:	00 00 00 
  805738:	8b 00                	mov    (%rax),%eax
  80573a:	39 c2                	cmp    %eax,%edx
  80573c:	74 07                	je     805745 <fd2sockid+0x4e>
  80573e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  805743:	eb 07                	jmp    80574c <fd2sockid+0x55>
  805745:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805749:	8b 40 0c             	mov    0xc(%rax),%eax
  80574c:	c9                   	leaveq 
  80574d:	c3                   	retq   

000000000080574e <alloc_sockfd>:
  80574e:	55                   	push   %rbp
  80574f:	48 89 e5             	mov    %rsp,%rbp
  805752:	48 83 ec 20          	sub    $0x20,%rsp
  805756:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805759:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80575d:	48 89 c7             	mov    %rax,%rdi
  805760:	48 b8 ac 38 80 00 00 	movabs $0x8038ac,%rax
  805767:	00 00 00 
  80576a:	ff d0                	callq  *%rax
  80576c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80576f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805773:	78 26                	js     80579b <alloc_sockfd+0x4d>
  805775:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805779:	ba 07 04 00 00       	mov    $0x407,%edx
  80577e:	48 89 c6             	mov    %rax,%rsi
  805781:	bf 00 00 00 00       	mov    $0x0,%edi
  805786:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  80578d:	00 00 00 
  805790:	ff d0                	callq  *%rax
  805792:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805795:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805799:	79 16                	jns    8057b1 <alloc_sockfd+0x63>
  80579b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80579e:	89 c7                	mov    %eax,%edi
  8057a0:	48 b8 5b 5c 80 00 00 	movabs $0x805c5b,%rax
  8057a7:	00 00 00 
  8057aa:	ff d0                	callq  *%rax
  8057ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8057af:	eb 3a                	jmp    8057eb <alloc_sockfd+0x9d>
  8057b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8057b5:	48 ba e0 90 80 00 00 	movabs $0x8090e0,%rdx
  8057bc:	00 00 00 
  8057bf:	8b 12                	mov    (%rdx),%edx
  8057c1:	89 10                	mov    %edx,(%rax)
  8057c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8057c7:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8057ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8057d2:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8057d5:	89 50 0c             	mov    %edx,0xc(%rax)
  8057d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8057dc:	48 89 c7             	mov    %rax,%rdi
  8057df:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  8057e6:	00 00 00 
  8057e9:	ff d0                	callq  *%rax
  8057eb:	c9                   	leaveq 
  8057ec:	c3                   	retq   

00000000008057ed <accept>:
  8057ed:	55                   	push   %rbp
  8057ee:	48 89 e5             	mov    %rsp,%rbp
  8057f1:	48 83 ec 30          	sub    $0x30,%rsp
  8057f5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8057f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8057fc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  805800:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805803:	89 c7                	mov    %eax,%edi
  805805:	48 b8 f7 56 80 00 00 	movabs $0x8056f7,%rax
  80580c:	00 00 00 
  80580f:	ff d0                	callq  *%rax
  805811:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805814:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805818:	79 05                	jns    80581f <accept+0x32>
  80581a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80581d:	eb 3b                	jmp    80585a <accept+0x6d>
  80581f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  805823:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  805827:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80582a:	48 89 ce             	mov    %rcx,%rsi
  80582d:	89 c7                	mov    %eax,%edi
  80582f:	48 b8 38 5b 80 00 00 	movabs $0x805b38,%rax
  805836:	00 00 00 
  805839:	ff d0                	callq  *%rax
  80583b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80583e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805842:	79 05                	jns    805849 <accept+0x5c>
  805844:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805847:	eb 11                	jmp    80585a <accept+0x6d>
  805849:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80584c:	89 c7                	mov    %eax,%edi
  80584e:	48 b8 4e 57 80 00 00 	movabs $0x80574e,%rax
  805855:	00 00 00 
  805858:	ff d0                	callq  *%rax
  80585a:	c9                   	leaveq 
  80585b:	c3                   	retq   

000000000080585c <bind>:
  80585c:	55                   	push   %rbp
  80585d:	48 89 e5             	mov    %rsp,%rbp
  805860:	48 83 ec 20          	sub    $0x20,%rsp
  805864:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805867:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80586b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80586e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805871:	89 c7                	mov    %eax,%edi
  805873:	48 b8 f7 56 80 00 00 	movabs $0x8056f7,%rax
  80587a:	00 00 00 
  80587d:	ff d0                	callq  *%rax
  80587f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805882:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805886:	79 05                	jns    80588d <bind+0x31>
  805888:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80588b:	eb 1b                	jmp    8058a8 <bind+0x4c>
  80588d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  805890:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  805894:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805897:	48 89 ce             	mov    %rcx,%rsi
  80589a:	89 c7                	mov    %eax,%edi
  80589c:	48 b8 b7 5b 80 00 00 	movabs $0x805bb7,%rax
  8058a3:	00 00 00 
  8058a6:	ff d0                	callq  *%rax
  8058a8:	c9                   	leaveq 
  8058a9:	c3                   	retq   

00000000008058aa <shutdown>:
  8058aa:	55                   	push   %rbp
  8058ab:	48 89 e5             	mov    %rsp,%rbp
  8058ae:	48 83 ec 20          	sub    $0x20,%rsp
  8058b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8058b5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8058b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8058bb:	89 c7                	mov    %eax,%edi
  8058bd:	48 b8 f7 56 80 00 00 	movabs $0x8056f7,%rax
  8058c4:	00 00 00 
  8058c7:	ff d0                	callq  *%rax
  8058c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8058cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8058d0:	79 05                	jns    8058d7 <shutdown+0x2d>
  8058d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8058d5:	eb 16                	jmp    8058ed <shutdown+0x43>
  8058d7:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8058da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8058dd:	89 d6                	mov    %edx,%esi
  8058df:	89 c7                	mov    %eax,%edi
  8058e1:	48 b8 1b 5c 80 00 00 	movabs $0x805c1b,%rax
  8058e8:	00 00 00 
  8058eb:	ff d0                	callq  *%rax
  8058ed:	c9                   	leaveq 
  8058ee:	c3                   	retq   

00000000008058ef <devsock_close>:
  8058ef:	55                   	push   %rbp
  8058f0:	48 89 e5             	mov    %rsp,%rbp
  8058f3:	48 83 ec 10          	sub    $0x10,%rsp
  8058f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8058fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8058ff:	48 89 c7             	mov    %rax,%rdi
  805902:	48 b8 c7 68 80 00 00 	movabs $0x8068c7,%rax
  805909:	00 00 00 
  80590c:	ff d0                	callq  *%rax
  80590e:	83 f8 01             	cmp    $0x1,%eax
  805911:	75 17                	jne    80592a <devsock_close+0x3b>
  805913:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805917:	8b 40 0c             	mov    0xc(%rax),%eax
  80591a:	89 c7                	mov    %eax,%edi
  80591c:	48 b8 5b 5c 80 00 00 	movabs $0x805c5b,%rax
  805923:	00 00 00 
  805926:	ff d0                	callq  *%rax
  805928:	eb 05                	jmp    80592f <devsock_close+0x40>
  80592a:	b8 00 00 00 00       	mov    $0x0,%eax
  80592f:	c9                   	leaveq 
  805930:	c3                   	retq   

0000000000805931 <connect>:
  805931:	55                   	push   %rbp
  805932:	48 89 e5             	mov    %rsp,%rbp
  805935:	48 83 ec 20          	sub    $0x20,%rsp
  805939:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80593c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805940:	89 55 e8             	mov    %edx,-0x18(%rbp)
  805943:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805946:	89 c7                	mov    %eax,%edi
  805948:	48 b8 f7 56 80 00 00 	movabs $0x8056f7,%rax
  80594f:	00 00 00 
  805952:	ff d0                	callq  *%rax
  805954:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805957:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80595b:	79 05                	jns    805962 <connect+0x31>
  80595d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805960:	eb 1b                	jmp    80597d <connect+0x4c>
  805962:	8b 55 e8             	mov    -0x18(%rbp),%edx
  805965:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  805969:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80596c:	48 89 ce             	mov    %rcx,%rsi
  80596f:	89 c7                	mov    %eax,%edi
  805971:	48 b8 88 5c 80 00 00 	movabs $0x805c88,%rax
  805978:	00 00 00 
  80597b:	ff d0                	callq  *%rax
  80597d:	c9                   	leaveq 
  80597e:	c3                   	retq   

000000000080597f <listen>:
  80597f:	55                   	push   %rbp
  805980:	48 89 e5             	mov    %rsp,%rbp
  805983:	48 83 ec 20          	sub    $0x20,%rsp
  805987:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80598a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80598d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805990:	89 c7                	mov    %eax,%edi
  805992:	48 b8 f7 56 80 00 00 	movabs $0x8056f7,%rax
  805999:	00 00 00 
  80599c:	ff d0                	callq  *%rax
  80599e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8059a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8059a5:	79 05                	jns    8059ac <listen+0x2d>
  8059a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8059aa:	eb 16                	jmp    8059c2 <listen+0x43>
  8059ac:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8059af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8059b2:	89 d6                	mov    %edx,%esi
  8059b4:	89 c7                	mov    %eax,%edi
  8059b6:	48 b8 ec 5c 80 00 00 	movabs $0x805cec,%rax
  8059bd:	00 00 00 
  8059c0:	ff d0                	callq  *%rax
  8059c2:	c9                   	leaveq 
  8059c3:	c3                   	retq   

00000000008059c4 <devsock_read>:
  8059c4:	55                   	push   %rbp
  8059c5:	48 89 e5             	mov    %rsp,%rbp
  8059c8:	48 83 ec 20          	sub    $0x20,%rsp
  8059cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8059d0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8059d4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8059d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8059dc:	89 c2                	mov    %eax,%edx
  8059de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8059e2:	8b 40 0c             	mov    0xc(%rax),%eax
  8059e5:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8059e9:	b9 00 00 00 00       	mov    $0x0,%ecx
  8059ee:	89 c7                	mov    %eax,%edi
  8059f0:	48 b8 2c 5d 80 00 00 	movabs $0x805d2c,%rax
  8059f7:	00 00 00 
  8059fa:	ff d0                	callq  *%rax
  8059fc:	c9                   	leaveq 
  8059fd:	c3                   	retq   

00000000008059fe <devsock_write>:
  8059fe:	55                   	push   %rbp
  8059ff:	48 89 e5             	mov    %rsp,%rbp
  805a02:	48 83 ec 20          	sub    $0x20,%rsp
  805a06:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  805a0a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805a0e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  805a12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805a16:	89 c2                	mov    %eax,%edx
  805a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805a1c:	8b 40 0c             	mov    0xc(%rax),%eax
  805a1f:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  805a23:	b9 00 00 00 00       	mov    $0x0,%ecx
  805a28:	89 c7                	mov    %eax,%edi
  805a2a:	48 b8 f8 5d 80 00 00 	movabs $0x805df8,%rax
  805a31:	00 00 00 
  805a34:	ff d0                	callq  *%rax
  805a36:	c9                   	leaveq 
  805a37:	c3                   	retq   

0000000000805a38 <devsock_stat>:
  805a38:	55                   	push   %rbp
  805a39:	48 89 e5             	mov    %rsp,%rbp
  805a3c:	48 83 ec 10          	sub    $0x10,%rsp
  805a40:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  805a44:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805a48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805a4c:	48 be ed 73 80 00 00 	movabs $0x8073ed,%rsi
  805a53:	00 00 00 
  805a56:	48 89 c7             	mov    %rax,%rdi
  805a59:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  805a60:	00 00 00 
  805a63:	ff d0                	callq  *%rax
  805a65:	b8 00 00 00 00       	mov    $0x0,%eax
  805a6a:	c9                   	leaveq 
  805a6b:	c3                   	retq   

0000000000805a6c <socket>:
  805a6c:	55                   	push   %rbp
  805a6d:	48 89 e5             	mov    %rsp,%rbp
  805a70:	48 83 ec 20          	sub    $0x20,%rsp
  805a74:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805a77:	89 75 e8             	mov    %esi,-0x18(%rbp)
  805a7a:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  805a7d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  805a80:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  805a83:	8b 45 ec             	mov    -0x14(%rbp),%eax
  805a86:	89 ce                	mov    %ecx,%esi
  805a88:	89 c7                	mov    %eax,%edi
  805a8a:	48 b8 b0 5e 80 00 00 	movabs $0x805eb0,%rax
  805a91:	00 00 00 
  805a94:	ff d0                	callq  *%rax
  805a96:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805a99:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805a9d:	79 05                	jns    805aa4 <socket+0x38>
  805a9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805aa2:	eb 11                	jmp    805ab5 <socket+0x49>
  805aa4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805aa7:	89 c7                	mov    %eax,%edi
  805aa9:	48 b8 4e 57 80 00 00 	movabs $0x80574e,%rax
  805ab0:	00 00 00 
  805ab3:	ff d0                	callq  *%rax
  805ab5:	c9                   	leaveq 
  805ab6:	c3                   	retq   

0000000000805ab7 <nsipc>:
  805ab7:	55                   	push   %rbp
  805ab8:	48 89 e5             	mov    %rsp,%rbp
  805abb:	48 83 ec 10          	sub    $0x10,%rsp
  805abf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805ac2:	48 b8 24 a4 80 00 00 	movabs $0x80a424,%rax
  805ac9:	00 00 00 
  805acc:	8b 00                	mov    (%rax),%eax
  805ace:	85 c0                	test   %eax,%eax
  805ad0:	75 1d                	jne    805aef <nsipc+0x38>
  805ad2:	bf 02 00 00 00       	mov    $0x2,%edi
  805ad7:	48 b8 55 68 80 00 00 	movabs $0x806855,%rax
  805ade:	00 00 00 
  805ae1:	ff d0                	callq  *%rax
  805ae3:	48 ba 24 a4 80 00 00 	movabs $0x80a424,%rdx
  805aea:	00 00 00 
  805aed:	89 02                	mov    %eax,(%rdx)
  805aef:	48 b8 24 a4 80 00 00 	movabs $0x80a424,%rax
  805af6:	00 00 00 
  805af9:	8b 00                	mov    (%rax),%eax
  805afb:	8b 75 fc             	mov    -0x4(%rbp),%esi
  805afe:	b9 07 00 00 00       	mov    $0x7,%ecx
  805b03:	48 ba 00 d0 80 00 00 	movabs $0x80d000,%rdx
  805b0a:	00 00 00 
  805b0d:	89 c7                	mov    %eax,%edi
  805b0f:	48 b8 4a 67 80 00 00 	movabs $0x80674a,%rax
  805b16:	00 00 00 
  805b19:	ff d0                	callq  *%rax
  805b1b:	ba 00 00 00 00       	mov    $0x0,%edx
  805b20:	be 00 00 00 00       	mov    $0x0,%esi
  805b25:	bf 00 00 00 00       	mov    $0x0,%edi
  805b2a:	48 b8 89 66 80 00 00 	movabs $0x806689,%rax
  805b31:	00 00 00 
  805b34:	ff d0                	callq  *%rax
  805b36:	c9                   	leaveq 
  805b37:	c3                   	retq   

0000000000805b38 <nsipc_accept>:
  805b38:	55                   	push   %rbp
  805b39:	48 89 e5             	mov    %rsp,%rbp
  805b3c:	48 83 ec 30          	sub    $0x30,%rsp
  805b40:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805b43:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805b47:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  805b4b:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805b52:	00 00 00 
  805b55:	8b 55 ec             	mov    -0x14(%rbp),%edx
  805b58:	89 10                	mov    %edx,(%rax)
  805b5a:	bf 01 00 00 00       	mov    $0x1,%edi
  805b5f:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805b66:	00 00 00 
  805b69:	ff d0                	callq  *%rax
  805b6b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805b6e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805b72:	78 3e                	js     805bb2 <nsipc_accept+0x7a>
  805b74:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805b7b:	00 00 00 
  805b7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  805b82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805b86:	8b 40 10             	mov    0x10(%rax),%eax
  805b89:	89 c2                	mov    %eax,%edx
  805b8b:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  805b8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805b93:	48 89 ce             	mov    %rcx,%rsi
  805b96:	48 89 c7             	mov    %rax,%rdi
  805b99:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  805ba0:	00 00 00 
  805ba3:	ff d0                	callq  *%rax
  805ba5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805ba9:	8b 50 10             	mov    0x10(%rax),%edx
  805bac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805bb0:	89 10                	mov    %edx,(%rax)
  805bb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805bb5:	c9                   	leaveq 
  805bb6:	c3                   	retq   

0000000000805bb7 <nsipc_bind>:
  805bb7:	55                   	push   %rbp
  805bb8:	48 89 e5             	mov    %rsp,%rbp
  805bbb:	48 83 ec 10          	sub    $0x10,%rsp
  805bbf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805bc2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805bc6:	89 55 f8             	mov    %edx,-0x8(%rbp)
  805bc9:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805bd0:	00 00 00 
  805bd3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805bd6:	89 10                	mov    %edx,(%rax)
  805bd8:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805bdf:	48 89 c6             	mov    %rax,%rsi
  805be2:	48 bf 04 d0 80 00 00 	movabs $0x80d004,%rdi
  805be9:	00 00 00 
  805bec:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  805bf3:	00 00 00 
  805bf6:	ff d0                	callq  *%rax
  805bf8:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805bff:	00 00 00 
  805c02:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805c05:	89 50 14             	mov    %edx,0x14(%rax)
  805c08:	bf 02 00 00 00       	mov    $0x2,%edi
  805c0d:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805c14:	00 00 00 
  805c17:	ff d0                	callq  *%rax
  805c19:	c9                   	leaveq 
  805c1a:	c3                   	retq   

0000000000805c1b <nsipc_shutdown>:
  805c1b:	55                   	push   %rbp
  805c1c:	48 89 e5             	mov    %rsp,%rbp
  805c1f:	48 83 ec 10          	sub    $0x10,%rsp
  805c23:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805c26:	89 75 f8             	mov    %esi,-0x8(%rbp)
  805c29:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805c30:	00 00 00 
  805c33:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805c36:	89 10                	mov    %edx,(%rax)
  805c38:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805c3f:	00 00 00 
  805c42:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805c45:	89 50 04             	mov    %edx,0x4(%rax)
  805c48:	bf 03 00 00 00       	mov    $0x3,%edi
  805c4d:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805c54:	00 00 00 
  805c57:	ff d0                	callq  *%rax
  805c59:	c9                   	leaveq 
  805c5a:	c3                   	retq   

0000000000805c5b <nsipc_close>:
  805c5b:	55                   	push   %rbp
  805c5c:	48 89 e5             	mov    %rsp,%rbp
  805c5f:	48 83 ec 10          	sub    $0x10,%rsp
  805c63:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805c66:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805c6d:	00 00 00 
  805c70:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805c73:	89 10                	mov    %edx,(%rax)
  805c75:	bf 04 00 00 00       	mov    $0x4,%edi
  805c7a:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805c81:	00 00 00 
  805c84:	ff d0                	callq  *%rax
  805c86:	c9                   	leaveq 
  805c87:	c3                   	retq   

0000000000805c88 <nsipc_connect>:
  805c88:	55                   	push   %rbp
  805c89:	48 89 e5             	mov    %rsp,%rbp
  805c8c:	48 83 ec 10          	sub    $0x10,%rsp
  805c90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805c93:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805c97:	89 55 f8             	mov    %edx,-0x8(%rbp)
  805c9a:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805ca1:	00 00 00 
  805ca4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805ca7:	89 10                	mov    %edx,(%rax)
  805ca9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805cac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805cb0:	48 89 c6             	mov    %rax,%rsi
  805cb3:	48 bf 04 d0 80 00 00 	movabs $0x80d004,%rdi
  805cba:	00 00 00 
  805cbd:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  805cc4:	00 00 00 
  805cc7:	ff d0                	callq  *%rax
  805cc9:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805cd0:	00 00 00 
  805cd3:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805cd6:	89 50 14             	mov    %edx,0x14(%rax)
  805cd9:	bf 05 00 00 00       	mov    $0x5,%edi
  805cde:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805ce5:	00 00 00 
  805ce8:	ff d0                	callq  *%rax
  805cea:	c9                   	leaveq 
  805ceb:	c3                   	retq   

0000000000805cec <nsipc_listen>:
  805cec:	55                   	push   %rbp
  805ced:	48 89 e5             	mov    %rsp,%rbp
  805cf0:	48 83 ec 10          	sub    $0x10,%rsp
  805cf4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805cf7:	89 75 f8             	mov    %esi,-0x8(%rbp)
  805cfa:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805d01:	00 00 00 
  805d04:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805d07:	89 10                	mov    %edx,(%rax)
  805d09:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805d10:	00 00 00 
  805d13:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805d16:	89 50 04             	mov    %edx,0x4(%rax)
  805d19:	bf 06 00 00 00       	mov    $0x6,%edi
  805d1e:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805d25:	00 00 00 
  805d28:	ff d0                	callq  *%rax
  805d2a:	c9                   	leaveq 
  805d2b:	c3                   	retq   

0000000000805d2c <nsipc_recv>:
  805d2c:	55                   	push   %rbp
  805d2d:	48 89 e5             	mov    %rsp,%rbp
  805d30:	48 83 ec 30          	sub    $0x30,%rsp
  805d34:	89 7d ec             	mov    %edi,-0x14(%rbp)
  805d37:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  805d3b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  805d3e:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  805d41:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805d48:	00 00 00 
  805d4b:	8b 55 ec             	mov    -0x14(%rbp),%edx
  805d4e:	89 10                	mov    %edx,(%rax)
  805d50:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805d57:	00 00 00 
  805d5a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  805d5d:	89 50 04             	mov    %edx,0x4(%rax)
  805d60:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805d67:	00 00 00 
  805d6a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  805d6d:	89 50 08             	mov    %edx,0x8(%rax)
  805d70:	bf 07 00 00 00       	mov    $0x7,%edi
  805d75:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805d7c:	00 00 00 
  805d7f:	ff d0                	callq  *%rax
  805d81:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805d84:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  805d88:	78 69                	js     805df3 <nsipc_recv+0xc7>
  805d8a:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  805d91:	7f 08                	jg     805d9b <nsipc_recv+0x6f>
  805d93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805d96:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  805d99:	7e 35                	jle    805dd0 <nsipc_recv+0xa4>
  805d9b:	48 b9 f4 73 80 00 00 	movabs $0x8073f4,%rcx
  805da2:	00 00 00 
  805da5:	48 ba 09 74 80 00 00 	movabs $0x807409,%rdx
  805dac:	00 00 00 
  805daf:	be 62 00 00 00       	mov    $0x62,%esi
  805db4:	48 bf 1e 74 80 00 00 	movabs $0x80741e,%rdi
  805dbb:	00 00 00 
  805dbe:	b8 00 00 00 00       	mov    $0x0,%eax
  805dc3:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  805dca:	00 00 00 
  805dcd:	41 ff d0             	callq  *%r8
  805dd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805dd3:	48 63 d0             	movslq %eax,%rdx
  805dd6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805dda:	48 be 00 d0 80 00 00 	movabs $0x80d000,%rsi
  805de1:	00 00 00 
  805de4:	48 89 c7             	mov    %rax,%rdi
  805de7:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  805dee:	00 00 00 
  805df1:	ff d0                	callq  *%rax
  805df3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805df6:	c9                   	leaveq 
  805df7:	c3                   	retq   

0000000000805df8 <nsipc_send>:
  805df8:	55                   	push   %rbp
  805df9:	48 89 e5             	mov    %rsp,%rbp
  805dfc:	48 83 ec 20          	sub    $0x20,%rsp
  805e00:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805e03:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  805e07:	89 55 f8             	mov    %edx,-0x8(%rbp)
  805e0a:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  805e0d:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805e14:	00 00 00 
  805e17:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805e1a:	89 10                	mov    %edx,(%rax)
  805e1c:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  805e23:	7e 35                	jle    805e5a <nsipc_send+0x62>
  805e25:	48 b9 2d 74 80 00 00 	movabs $0x80742d,%rcx
  805e2c:	00 00 00 
  805e2f:	48 ba 09 74 80 00 00 	movabs $0x807409,%rdx
  805e36:	00 00 00 
  805e39:	be 6d 00 00 00       	mov    $0x6d,%esi
  805e3e:	48 bf 1e 74 80 00 00 	movabs $0x80741e,%rdi
  805e45:	00 00 00 
  805e48:	b8 00 00 00 00       	mov    $0x0,%eax
  805e4d:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  805e54:	00 00 00 
  805e57:	41 ff d0             	callq  *%r8
  805e5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  805e5d:	48 63 d0             	movslq %eax,%rdx
  805e60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  805e64:	48 89 c6             	mov    %rax,%rsi
  805e67:	48 bf 0c d0 80 00 00 	movabs $0x80d00c,%rdi
  805e6e:	00 00 00 
  805e71:	48 b8 79 25 80 00 00 	movabs $0x802579,%rax
  805e78:	00 00 00 
  805e7b:	ff d0                	callq  *%rax
  805e7d:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805e84:	00 00 00 
  805e87:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805e8a:	89 50 04             	mov    %edx,0x4(%rax)
  805e8d:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805e94:	00 00 00 
  805e97:	8b 55 ec             	mov    -0x14(%rbp),%edx
  805e9a:	89 50 08             	mov    %edx,0x8(%rax)
  805e9d:	bf 08 00 00 00       	mov    $0x8,%edi
  805ea2:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805ea9:	00 00 00 
  805eac:	ff d0                	callq  *%rax
  805eae:	c9                   	leaveq 
  805eaf:	c3                   	retq   

0000000000805eb0 <nsipc_socket>:
  805eb0:	55                   	push   %rbp
  805eb1:	48 89 e5             	mov    %rsp,%rbp
  805eb4:	48 83 ec 10          	sub    $0x10,%rsp
  805eb8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805ebb:	89 75 f8             	mov    %esi,-0x8(%rbp)
  805ebe:	89 55 f4             	mov    %edx,-0xc(%rbp)
  805ec1:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805ec8:	00 00 00 
  805ecb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805ece:	89 10                	mov    %edx,(%rax)
  805ed0:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805ed7:	00 00 00 
  805eda:	8b 55 f8             	mov    -0x8(%rbp),%edx
  805edd:	89 50 04             	mov    %edx,0x4(%rax)
  805ee0:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  805ee7:	00 00 00 
  805eea:	8b 55 f4             	mov    -0xc(%rbp),%edx
  805eed:	89 50 08             	mov    %edx,0x8(%rax)
  805ef0:	bf 09 00 00 00       	mov    $0x9,%edi
  805ef5:	48 b8 b7 5a 80 00 00 	movabs $0x805ab7,%rax
  805efc:	00 00 00 
  805eff:	ff d0                	callq  *%rax
  805f01:	c9                   	leaveq 
  805f02:	c3                   	retq   

0000000000805f03 <pipe>:
  805f03:	55                   	push   %rbp
  805f04:	48 89 e5             	mov    %rsp,%rbp
  805f07:	53                   	push   %rbx
  805f08:	48 83 ec 38          	sub    $0x38,%rsp
  805f0c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  805f10:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  805f14:	48 89 c7             	mov    %rax,%rdi
  805f17:	48 b8 ac 38 80 00 00 	movabs $0x8038ac,%rax
  805f1e:	00 00 00 
  805f21:	ff d0                	callq  *%rax
  805f23:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805f26:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805f2a:	0f 88 bf 01 00 00    	js     8060ef <pipe+0x1ec>
  805f30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805f34:	ba 07 04 00 00       	mov    $0x407,%edx
  805f39:	48 89 c6             	mov    %rax,%rsi
  805f3c:	bf 00 00 00 00       	mov    $0x0,%edi
  805f41:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  805f48:	00 00 00 
  805f4b:	ff d0                	callq  *%rax
  805f4d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805f50:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805f54:	0f 88 95 01 00 00    	js     8060ef <pipe+0x1ec>
  805f5a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  805f5e:	48 89 c7             	mov    %rax,%rdi
  805f61:	48 b8 ac 38 80 00 00 	movabs $0x8038ac,%rax
  805f68:	00 00 00 
  805f6b:	ff d0                	callq  *%rax
  805f6d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805f70:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805f74:	0f 88 5d 01 00 00    	js     8060d7 <pipe+0x1d4>
  805f7a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805f7e:	ba 07 04 00 00       	mov    $0x407,%edx
  805f83:	48 89 c6             	mov    %rax,%rsi
  805f86:	bf 00 00 00 00       	mov    $0x0,%edi
  805f8b:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  805f92:	00 00 00 
  805f95:	ff d0                	callq  *%rax
  805f97:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805f9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805f9e:	0f 88 33 01 00 00    	js     8060d7 <pipe+0x1d4>
  805fa4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  805fa8:	48 89 c7             	mov    %rax,%rdi
  805fab:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  805fb2:	00 00 00 
  805fb5:	ff d0                	callq  *%rax
  805fb7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  805fbb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  805fbf:	ba 07 04 00 00       	mov    $0x407,%edx
  805fc4:	48 89 c6             	mov    %rax,%rsi
  805fc7:	bf 00 00 00 00       	mov    $0x0,%edi
  805fcc:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  805fd3:	00 00 00 
  805fd6:	ff d0                	callq  *%rax
  805fd8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  805fdb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  805fdf:	79 05                	jns    805fe6 <pipe+0xe3>
  805fe1:	e9 d9 00 00 00       	jmpq   8060bf <pipe+0x1bc>
  805fe6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  805fea:	48 89 c7             	mov    %rax,%rdi
  805fed:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  805ff4:	00 00 00 
  805ff7:	ff d0                	callq  *%rax
  805ff9:	48 89 c2             	mov    %rax,%rdx
  805ffc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806000:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  806006:	48 89 d1             	mov    %rdx,%rcx
  806009:	ba 00 00 00 00       	mov    $0x0,%edx
  80600e:	48 89 c6             	mov    %rax,%rsi
  806011:	bf 00 00 00 00       	mov    $0x0,%edi
  806016:	48 b8 d4 2b 80 00 00 	movabs $0x802bd4,%rax
  80601d:	00 00 00 
  806020:	ff d0                	callq  *%rax
  806022:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806025:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  806029:	79 1b                	jns    806046 <pipe+0x143>
  80602b:	90                   	nop
  80602c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806030:	48 89 c6             	mov    %rax,%rsi
  806033:	bf 00 00 00 00       	mov    $0x0,%edi
  806038:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  80603f:	00 00 00 
  806042:	ff d0                	callq  *%rax
  806044:	eb 79                	jmp    8060bf <pipe+0x1bc>
  806046:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80604a:	48 ba 20 91 80 00 00 	movabs $0x809120,%rdx
  806051:	00 00 00 
  806054:	8b 12                	mov    (%rdx),%edx
  806056:	89 10                	mov    %edx,(%rax)
  806058:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80605c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  806063:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806067:	48 ba 20 91 80 00 00 	movabs $0x809120,%rdx
  80606e:	00 00 00 
  806071:	8b 12                	mov    (%rdx),%edx
  806073:	89 10                	mov    %edx,(%rax)
  806075:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806079:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  806080:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806084:	48 89 c7             	mov    %rax,%rdi
  806087:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  80608e:	00 00 00 
  806091:	ff d0                	callq  *%rax
  806093:	89 c2                	mov    %eax,%edx
  806095:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  806099:	89 10                	mov    %edx,(%rax)
  80609b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80609f:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8060a3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8060a7:	48 89 c7             	mov    %rax,%rdi
  8060aa:	48 b8 5e 38 80 00 00 	movabs $0x80385e,%rax
  8060b1:	00 00 00 
  8060b4:	ff d0                	callq  *%rax
  8060b6:	89 03                	mov    %eax,(%rbx)
  8060b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8060bd:	eb 33                	jmp    8060f2 <pipe+0x1ef>
  8060bf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8060c3:	48 89 c6             	mov    %rax,%rsi
  8060c6:	bf 00 00 00 00       	mov    $0x0,%edi
  8060cb:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8060d2:	00 00 00 
  8060d5:	ff d0                	callq  *%rax
  8060d7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8060db:	48 89 c6             	mov    %rax,%rsi
  8060de:	bf 00 00 00 00       	mov    $0x0,%edi
  8060e3:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8060ea:	00 00 00 
  8060ed:	ff d0                	callq  *%rax
  8060ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8060f2:	48 83 c4 38          	add    $0x38,%rsp
  8060f6:	5b                   	pop    %rbx
  8060f7:	5d                   	pop    %rbp
  8060f8:	c3                   	retq   

00000000008060f9 <_pipeisclosed>:
  8060f9:	55                   	push   %rbp
  8060fa:	48 89 e5             	mov    %rsp,%rbp
  8060fd:	53                   	push   %rbx
  8060fe:	48 83 ec 28          	sub    $0x28,%rsp
  806102:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  806106:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80610a:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  806111:	00 00 00 
  806114:	48 8b 00             	mov    (%rax),%rax
  806117:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80611d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  806120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806124:	48 89 c7             	mov    %rax,%rdi
  806127:	48 b8 c7 68 80 00 00 	movabs $0x8068c7,%rax
  80612e:	00 00 00 
  806131:	ff d0                	callq  *%rax
  806133:	89 c3                	mov    %eax,%ebx
  806135:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806139:	48 89 c7             	mov    %rax,%rdi
  80613c:	48 b8 c7 68 80 00 00 	movabs $0x8068c7,%rax
  806143:	00 00 00 
  806146:	ff d0                	callq  *%rax
  806148:	39 c3                	cmp    %eax,%ebx
  80614a:	0f 94 c0             	sete   %al
  80614d:	0f b6 c0             	movzbl %al,%eax
  806150:	89 45 e8             	mov    %eax,-0x18(%rbp)
  806153:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  80615a:	00 00 00 
  80615d:	48 8b 00             	mov    (%rax),%rax
  806160:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  806166:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  806169:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80616c:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80616f:	75 05                	jne    806176 <_pipeisclosed+0x7d>
  806171:	8b 45 e8             	mov    -0x18(%rbp),%eax
  806174:	eb 4f                	jmp    8061c5 <_pipeisclosed+0xcc>
  806176:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806179:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80617c:	74 42                	je     8061c0 <_pipeisclosed+0xc7>
  80617e:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  806182:	75 3c                	jne    8061c0 <_pipeisclosed+0xc7>
  806184:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  80618b:	00 00 00 
  80618e:	48 8b 00             	mov    (%rax),%rax
  806191:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  806197:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80619a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80619d:	89 c6                	mov    %eax,%esi
  80619f:	48 bf 3e 74 80 00 00 	movabs $0x80743e,%rdi
  8061a6:	00 00 00 
  8061a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8061ae:	49 b8 46 15 80 00 00 	movabs $0x801546,%r8
  8061b5:	00 00 00 
  8061b8:	41 ff d0             	callq  *%r8
  8061bb:	e9 4a ff ff ff       	jmpq   80610a <_pipeisclosed+0x11>
  8061c0:	e9 45 ff ff ff       	jmpq   80610a <_pipeisclosed+0x11>
  8061c5:	48 83 c4 28          	add    $0x28,%rsp
  8061c9:	5b                   	pop    %rbx
  8061ca:	5d                   	pop    %rbp
  8061cb:	c3                   	retq   

00000000008061cc <pipeisclosed>:
  8061cc:	55                   	push   %rbp
  8061cd:	48 89 e5             	mov    %rsp,%rbp
  8061d0:	48 83 ec 30          	sub    $0x30,%rsp
  8061d4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8061d7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8061db:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8061de:	48 89 d6             	mov    %rdx,%rsi
  8061e1:	89 c7                	mov    %eax,%edi
  8061e3:	48 b8 44 39 80 00 00 	movabs $0x803944,%rax
  8061ea:	00 00 00 
  8061ed:	ff d0                	callq  *%rax
  8061ef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8061f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8061f6:	79 05                	jns    8061fd <pipeisclosed+0x31>
  8061f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8061fb:	eb 31                	jmp    80622e <pipeisclosed+0x62>
  8061fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806201:	48 89 c7             	mov    %rax,%rdi
  806204:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  80620b:	00 00 00 
  80620e:	ff d0                	callq  *%rax
  806210:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  806214:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806218:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80621c:	48 89 d6             	mov    %rdx,%rsi
  80621f:	48 89 c7             	mov    %rax,%rdi
  806222:	48 b8 f9 60 80 00 00 	movabs $0x8060f9,%rax
  806229:	00 00 00 
  80622c:	ff d0                	callq  *%rax
  80622e:	c9                   	leaveq 
  80622f:	c3                   	retq   

0000000000806230 <devpipe_read>:
  806230:	55                   	push   %rbp
  806231:	48 89 e5             	mov    %rsp,%rbp
  806234:	48 83 ec 40          	sub    $0x40,%rsp
  806238:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80623c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  806240:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  806244:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806248:	48 89 c7             	mov    %rax,%rdi
  80624b:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  806252:	00 00 00 
  806255:	ff d0                	callq  *%rax
  806257:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80625b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80625f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  806263:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80626a:	00 
  80626b:	e9 92 00 00 00       	jmpq   806302 <devpipe_read+0xd2>
  806270:	eb 41                	jmp    8062b3 <devpipe_read+0x83>
  806272:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  806277:	74 09                	je     806282 <devpipe_read+0x52>
  806279:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80627d:	e9 92 00 00 00       	jmpq   806314 <devpipe_read+0xe4>
  806282:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  806286:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80628a:	48 89 d6             	mov    %rdx,%rsi
  80628d:	48 89 c7             	mov    %rax,%rdi
  806290:	48 b8 f9 60 80 00 00 	movabs $0x8060f9,%rax
  806297:	00 00 00 
  80629a:	ff d0                	callq  *%rax
  80629c:	85 c0                	test   %eax,%eax
  80629e:	74 07                	je     8062a7 <devpipe_read+0x77>
  8062a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8062a5:	eb 6d                	jmp    806314 <devpipe_read+0xe4>
  8062a7:	48 b8 46 2b 80 00 00 	movabs $0x802b46,%rax
  8062ae:	00 00 00 
  8062b1:	ff d0                	callq  *%rax
  8062b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8062b7:	8b 10                	mov    (%rax),%edx
  8062b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8062bd:	8b 40 04             	mov    0x4(%rax),%eax
  8062c0:	39 c2                	cmp    %eax,%edx
  8062c2:	74 ae                	je     806272 <devpipe_read+0x42>
  8062c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8062c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8062cc:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8062d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8062d4:	8b 00                	mov    (%rax),%eax
  8062d6:	99                   	cltd   
  8062d7:	c1 ea 1b             	shr    $0x1b,%edx
  8062da:	01 d0                	add    %edx,%eax
  8062dc:	83 e0 1f             	and    $0x1f,%eax
  8062df:	29 d0                	sub    %edx,%eax
  8062e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8062e5:	48 98                	cltq   
  8062e7:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8062ec:	88 01                	mov    %al,(%rcx)
  8062ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8062f2:	8b 00                	mov    (%rax),%eax
  8062f4:	8d 50 01             	lea    0x1(%rax),%edx
  8062f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8062fb:	89 10                	mov    %edx,(%rax)
  8062fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  806302:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806306:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80630a:	0f 82 60 ff ff ff    	jb     806270 <devpipe_read+0x40>
  806310:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806314:	c9                   	leaveq 
  806315:	c3                   	retq   

0000000000806316 <devpipe_write>:
  806316:	55                   	push   %rbp
  806317:	48 89 e5             	mov    %rsp,%rbp
  80631a:	48 83 ec 40          	sub    $0x40,%rsp
  80631e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  806322:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  806326:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80632a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80632e:	48 89 c7             	mov    %rax,%rdi
  806331:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  806338:	00 00 00 
  80633b:	ff d0                	callq  *%rax
  80633d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  806341:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  806345:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  806349:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  806350:	00 
  806351:	e9 8e 00 00 00       	jmpq   8063e4 <devpipe_write+0xce>
  806356:	eb 31                	jmp    806389 <devpipe_write+0x73>
  806358:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80635c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806360:	48 89 d6             	mov    %rdx,%rsi
  806363:	48 89 c7             	mov    %rax,%rdi
  806366:	48 b8 f9 60 80 00 00 	movabs $0x8060f9,%rax
  80636d:	00 00 00 
  806370:	ff d0                	callq  *%rax
  806372:	85 c0                	test   %eax,%eax
  806374:	74 07                	je     80637d <devpipe_write+0x67>
  806376:	b8 00 00 00 00       	mov    $0x0,%eax
  80637b:	eb 79                	jmp    8063f6 <devpipe_write+0xe0>
  80637d:	48 b8 46 2b 80 00 00 	movabs $0x802b46,%rax
  806384:	00 00 00 
  806387:	ff d0                	callq  *%rax
  806389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80638d:	8b 40 04             	mov    0x4(%rax),%eax
  806390:	48 63 d0             	movslq %eax,%rdx
  806393:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  806397:	8b 00                	mov    (%rax),%eax
  806399:	48 98                	cltq   
  80639b:	48 83 c0 20          	add    $0x20,%rax
  80639f:	48 39 c2             	cmp    %rax,%rdx
  8063a2:	73 b4                	jae    806358 <devpipe_write+0x42>
  8063a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8063a8:	8b 40 04             	mov    0x4(%rax),%eax
  8063ab:	99                   	cltd   
  8063ac:	c1 ea 1b             	shr    $0x1b,%edx
  8063af:	01 d0                	add    %edx,%eax
  8063b1:	83 e0 1f             	and    $0x1f,%eax
  8063b4:	29 d0                	sub    %edx,%eax
  8063b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8063ba:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8063be:	48 01 ca             	add    %rcx,%rdx
  8063c1:	0f b6 0a             	movzbl (%rdx),%ecx
  8063c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8063c8:	48 98                	cltq   
  8063ca:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8063ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8063d2:	8b 40 04             	mov    0x4(%rax),%eax
  8063d5:	8d 50 01             	lea    0x1(%rax),%edx
  8063d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8063dc:	89 50 04             	mov    %edx,0x4(%rax)
  8063df:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8063e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8063e8:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8063ec:	0f 82 64 ff ff ff    	jb     806356 <devpipe_write+0x40>
  8063f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8063f6:	c9                   	leaveq 
  8063f7:	c3                   	retq   

00000000008063f8 <devpipe_stat>:
  8063f8:	55                   	push   %rbp
  8063f9:	48 89 e5             	mov    %rsp,%rbp
  8063fc:	48 83 ec 20          	sub    $0x20,%rsp
  806400:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  806404:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  806408:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80640c:	48 89 c7             	mov    %rax,%rdi
  80640f:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  806416:	00 00 00 
  806419:	ff d0                	callq  *%rax
  80641b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80641f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806423:	48 be 51 74 80 00 00 	movabs $0x807451,%rsi
  80642a:	00 00 00 
  80642d:	48 89 c7             	mov    %rax,%rdi
  806430:	48 b8 55 22 80 00 00 	movabs $0x802255,%rax
  806437:	00 00 00 
  80643a:	ff d0                	callq  *%rax
  80643c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806440:	8b 50 04             	mov    0x4(%rax),%edx
  806443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806447:	8b 00                	mov    (%rax),%eax
  806449:	29 c2                	sub    %eax,%edx
  80644b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80644f:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  806455:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806459:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  806460:	00 00 00 
  806463:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  806467:	48 b9 20 91 80 00 00 	movabs $0x809120,%rcx
  80646e:	00 00 00 
  806471:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  806478:	b8 00 00 00 00       	mov    $0x0,%eax
  80647d:	c9                   	leaveq 
  80647e:	c3                   	retq   

000000000080647f <devpipe_close>:
  80647f:	55                   	push   %rbp
  806480:	48 89 e5             	mov    %rsp,%rbp
  806483:	48 83 ec 10          	sub    $0x10,%rsp
  806487:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80648b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80648f:	48 89 c6             	mov    %rax,%rsi
  806492:	bf 00 00 00 00       	mov    $0x0,%edi
  806497:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  80649e:	00 00 00 
  8064a1:	ff d0                	callq  *%rax
  8064a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8064a7:	48 89 c7             	mov    %rax,%rdi
  8064aa:	48 b8 81 38 80 00 00 	movabs $0x803881,%rax
  8064b1:	00 00 00 
  8064b4:	ff d0                	callq  *%rax
  8064b6:	48 89 c6             	mov    %rax,%rsi
  8064b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8064be:	48 b8 2f 2c 80 00 00 	movabs $0x802c2f,%rax
  8064c5:	00 00 00 
  8064c8:	ff d0                	callq  *%rax
  8064ca:	c9                   	leaveq 
  8064cb:	c3                   	retq   

00000000008064cc <wait>:
  8064cc:	55                   	push   %rbp
  8064cd:	48 89 e5             	mov    %rsp,%rbp
  8064d0:	48 83 ec 20          	sub    $0x20,%rsp
  8064d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8064d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8064db:	75 35                	jne    806512 <wait+0x46>
  8064dd:	48 b9 58 74 80 00 00 	movabs $0x807458,%rcx
  8064e4:	00 00 00 
  8064e7:	48 ba 63 74 80 00 00 	movabs $0x807463,%rdx
  8064ee:	00 00 00 
  8064f1:	be 0a 00 00 00       	mov    $0xa,%esi
  8064f6:	48 bf 78 74 80 00 00 	movabs $0x807478,%rdi
  8064fd:	00 00 00 
  806500:	b8 00 00 00 00       	mov    $0x0,%eax
  806505:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  80650c:	00 00 00 
  80650f:	41 ff d0             	callq  *%r8
  806512:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806515:	25 ff 03 00 00       	and    $0x3ff,%eax
  80651a:	48 98                	cltq   
  80651c:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  806523:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80652a:	00 00 00 
  80652d:	48 01 d0             	add    %rdx,%rax
  806530:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  806534:	eb 0c                	jmp    806542 <wait+0x76>
  806536:	48 b8 46 2b 80 00 00 	movabs $0x802b46,%rax
  80653d:	00 00 00 
  806540:	ff d0                	callq  *%rax
  806542:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806546:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80654c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80654f:	75 0e                	jne    80655f <wait+0x93>
  806551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  806555:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  80655b:	85 c0                	test   %eax,%eax
  80655d:	75 d7                	jne    806536 <wait+0x6a>
  80655f:	c9                   	leaveq 
  806560:	c3                   	retq   

0000000000806561 <set_pgfault_handler>:
  806561:	55                   	push   %rbp
  806562:	48 89 e5             	mov    %rsp,%rbp
  806565:	48 83 ec 20          	sub    $0x20,%rsp
  806569:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80656d:	48 b8 00 e0 80 00 00 	movabs $0x80e000,%rax
  806574:	00 00 00 
  806577:	48 8b 00             	mov    (%rax),%rax
  80657a:	48 85 c0             	test   %rax,%rax
  80657d:	75 6f                	jne    8065ee <set_pgfault_handler+0x8d>
  80657f:	ba 07 00 00 00       	mov    $0x7,%edx
  806584:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  806589:	bf 00 00 00 00       	mov    $0x0,%edi
  80658e:	48 b8 84 2b 80 00 00 	movabs $0x802b84,%rax
  806595:	00 00 00 
  806598:	ff d0                	callq  *%rax
  80659a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80659d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8065a1:	79 30                	jns    8065d3 <set_pgfault_handler+0x72>
  8065a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8065a6:	89 c1                	mov    %eax,%ecx
  8065a8:	48 ba 88 74 80 00 00 	movabs $0x807488,%rdx
  8065af:	00 00 00 
  8065b2:	be 22 00 00 00       	mov    $0x22,%esi
  8065b7:	48 bf a7 74 80 00 00 	movabs $0x8074a7,%rdi
  8065be:	00 00 00 
  8065c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8065c6:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8065cd:	00 00 00 
  8065d0:	41 ff d0             	callq  *%r8
  8065d3:	48 be 01 66 80 00 00 	movabs $0x806601,%rsi
  8065da:	00 00 00 
  8065dd:	bf 00 00 00 00       	mov    $0x0,%edi
  8065e2:	48 b8 0e 2d 80 00 00 	movabs $0x802d0e,%rax
  8065e9:	00 00 00 
  8065ec:	ff d0                	callq  *%rax
  8065ee:	48 b8 00 e0 80 00 00 	movabs $0x80e000,%rax
  8065f5:	00 00 00 
  8065f8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8065fc:	48 89 10             	mov    %rdx,(%rax)
  8065ff:	c9                   	leaveq 
  806600:	c3                   	retq   

0000000000806601 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  806601:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  806604:	48 a1 00 e0 80 00 00 	movabs 0x80e000,%rax
  80660b:	00 00 00 
call *%rax
  80660e:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  806610:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  806617:	00 08 
    movq 152(%rsp), %rax
  806619:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  806620:	00 
    movq 136(%rsp), %rbx
  806621:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  806628:	00 
movq %rbx, (%rax)
  806629:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  80662c:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  806630:	4c 8b 3c 24          	mov    (%rsp),%r15
  806634:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  806639:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  80663e:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  806643:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  806648:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  80664d:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  806652:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  806657:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  80665c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  806661:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  806666:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  80666b:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  806670:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  806675:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  80667a:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  80667e:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  806682:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  806683:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  806688:	c3                   	retq   

0000000000806689 <ipc_recv>:
  806689:	55                   	push   %rbp
  80668a:	48 89 e5             	mov    %rsp,%rbp
  80668d:	48 83 ec 30          	sub    $0x30,%rsp
  806691:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  806695:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  806699:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80669d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8066a2:	75 0e                	jne    8066b2 <ipc_recv+0x29>
  8066a4:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8066ab:	00 00 00 
  8066ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8066b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8066b6:	48 89 c7             	mov    %rax,%rdi
  8066b9:	48 b8 ad 2d 80 00 00 	movabs $0x802dad,%rax
  8066c0:	00 00 00 
  8066c3:	ff d0                	callq  *%rax
  8066c5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8066c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8066cc:	79 27                	jns    8066f5 <ipc_recv+0x6c>
  8066ce:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8066d3:	74 0a                	je     8066df <ipc_recv+0x56>
  8066d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8066d9:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8066df:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8066e4:	74 0a                	je     8066f0 <ipc_recv+0x67>
  8066e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8066ea:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8066f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8066f3:	eb 53                	jmp    806748 <ipc_recv+0xbf>
  8066f5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8066fa:	74 19                	je     806715 <ipc_recv+0x8c>
  8066fc:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  806703:	00 00 00 
  806706:	48 8b 00             	mov    (%rax),%rax
  806709:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80670f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  806713:	89 10                	mov    %edx,(%rax)
  806715:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80671a:	74 19                	je     806735 <ipc_recv+0xac>
  80671c:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  806723:	00 00 00 
  806726:	48 8b 00             	mov    (%rax),%rax
  806729:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80672f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  806733:	89 10                	mov    %edx,(%rax)
  806735:	48 b8 28 a4 80 00 00 	movabs $0x80a428,%rax
  80673c:	00 00 00 
  80673f:	48 8b 00             	mov    (%rax),%rax
  806742:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  806748:	c9                   	leaveq 
  806749:	c3                   	retq   

000000000080674a <ipc_send>:
  80674a:	55                   	push   %rbp
  80674b:	48 89 e5             	mov    %rsp,%rbp
  80674e:	48 83 ec 30          	sub    $0x30,%rsp
  806752:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806755:	89 75 e8             	mov    %esi,-0x18(%rbp)
  806758:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  80675c:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80675f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  806764:	75 10                	jne    806776 <ipc_send+0x2c>
  806766:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80676d:	00 00 00 
  806770:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  806774:	eb 0e                	jmp    806784 <ipc_send+0x3a>
  806776:	eb 0c                	jmp    806784 <ipc_send+0x3a>
  806778:	48 b8 46 2b 80 00 00 	movabs $0x802b46,%rax
  80677f:	00 00 00 
  806782:	ff d0                	callq  *%rax
  806784:	8b 75 e8             	mov    -0x18(%rbp),%esi
  806787:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  80678a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80678e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  806791:	89 c7                	mov    %eax,%edi
  806793:	48 b8 58 2d 80 00 00 	movabs $0x802d58,%rax
  80679a:	00 00 00 
  80679d:	ff d0                	callq  *%rax
  80679f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8067a2:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8067a6:	74 d0                	je     806778 <ipc_send+0x2e>
  8067a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8067ac:	79 30                	jns    8067de <ipc_send+0x94>
  8067ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8067b1:	89 c1                	mov    %eax,%ecx
  8067b3:	48 ba b8 74 80 00 00 	movabs $0x8074b8,%rdx
  8067ba:	00 00 00 
  8067bd:	be 44 00 00 00       	mov    $0x44,%esi
  8067c2:	48 bf ce 74 80 00 00 	movabs $0x8074ce,%rdi
  8067c9:	00 00 00 
  8067cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8067d1:	49 b8 0d 13 80 00 00 	movabs $0x80130d,%r8
  8067d8:	00 00 00 
  8067db:	41 ff d0             	callq  *%r8
  8067de:	c9                   	leaveq 
  8067df:	c3                   	retq   

00000000008067e0 <ipc_host_recv>:
  8067e0:	55                   	push   %rbp
  8067e1:	48 89 e5             	mov    %rsp,%rbp
  8067e4:	48 83 ec 10          	sub    $0x10,%rsp
  8067e8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8067ec:	48 ba e0 74 80 00 00 	movabs $0x8074e0,%rdx
  8067f3:	00 00 00 
  8067f6:	be 4e 00 00 00       	mov    $0x4e,%esi
  8067fb:	48 bf ce 74 80 00 00 	movabs $0x8074ce,%rdi
  806802:	00 00 00 
  806805:	b8 00 00 00 00       	mov    $0x0,%eax
  80680a:	48 b9 0d 13 80 00 00 	movabs $0x80130d,%rcx
  806811:	00 00 00 
  806814:	ff d1                	callq  *%rcx

0000000000806816 <ipc_host_send>:
  806816:	55                   	push   %rbp
  806817:	48 89 e5             	mov    %rsp,%rbp
  80681a:	48 83 ec 20          	sub    $0x20,%rsp
  80681e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  806821:	89 75 f8             	mov    %esi,-0x8(%rbp)
  806824:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  806828:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80682b:	48 ba 00 75 80 00 00 	movabs $0x807500,%rdx
  806832:	00 00 00 
  806835:	be 67 00 00 00       	mov    $0x67,%esi
  80683a:	48 bf ce 74 80 00 00 	movabs $0x8074ce,%rdi
  806841:	00 00 00 
  806844:	b8 00 00 00 00       	mov    $0x0,%eax
  806849:	48 b9 0d 13 80 00 00 	movabs $0x80130d,%rcx
  806850:	00 00 00 
  806853:	ff d1                	callq  *%rcx

0000000000806855 <ipc_find_env>:
  806855:	55                   	push   %rbp
  806856:	48 89 e5             	mov    %rsp,%rbp
  806859:	48 83 ec 14          	sub    $0x14,%rsp
  80685d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  806860:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  806867:	eb 4e                	jmp    8068b7 <ipc_find_env+0x62>
  806869:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  806870:	00 00 00 
  806873:	8b 45 fc             	mov    -0x4(%rbp),%eax
  806876:	48 98                	cltq   
  806878:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80687f:	48 01 d0             	add    %rdx,%rax
  806882:	48 05 d0 00 00 00    	add    $0xd0,%rax
  806888:	8b 00                	mov    (%rax),%eax
  80688a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80688d:	75 24                	jne    8068b3 <ipc_find_env+0x5e>
  80688f:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  806896:	00 00 00 
  806899:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80689c:	48 98                	cltq   
  80689e:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8068a5:	48 01 d0             	add    %rdx,%rax
  8068a8:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8068ae:	8b 40 08             	mov    0x8(%rax),%eax
  8068b1:	eb 12                	jmp    8068c5 <ipc_find_env+0x70>
  8068b3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8068b7:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8068be:	7e a9                	jle    806869 <ipc_find_env+0x14>
  8068c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8068c5:	c9                   	leaveq 
  8068c6:	c3                   	retq   

00000000008068c7 <pageref>:
  8068c7:	55                   	push   %rbp
  8068c8:	48 89 e5             	mov    %rsp,%rbp
  8068cb:	48 83 ec 18          	sub    $0x18,%rsp
  8068cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8068d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8068d7:	48 c1 e8 15          	shr    $0x15,%rax
  8068db:	48 89 c2             	mov    %rax,%rdx
  8068de:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8068e5:	01 00 00 
  8068e8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8068ec:	83 e0 01             	and    $0x1,%eax
  8068ef:	48 85 c0             	test   %rax,%rax
  8068f2:	75 07                	jne    8068fb <pageref+0x34>
  8068f4:	b8 00 00 00 00       	mov    $0x0,%eax
  8068f9:	eb 53                	jmp    80694e <pageref+0x87>
  8068fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8068ff:	48 c1 e8 0c          	shr    $0xc,%rax
  806903:	48 89 c2             	mov    %rax,%rdx
  806906:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80690d:	01 00 00 
  806910:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  806914:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  806918:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80691c:	83 e0 01             	and    $0x1,%eax
  80691f:	48 85 c0             	test   %rax,%rax
  806922:	75 07                	jne    80692b <pageref+0x64>
  806924:	b8 00 00 00 00       	mov    $0x0,%eax
  806929:	eb 23                	jmp    80694e <pageref+0x87>
  80692b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80692f:	48 c1 e8 0c          	shr    $0xc,%rax
  806933:	48 89 c2             	mov    %rax,%rdx
  806936:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  80693d:	00 00 00 
  806940:	48 c1 e2 04          	shl    $0x4,%rdx
  806944:	48 01 d0             	add    %rdx,%rax
  806947:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  80694b:	0f b7 c0             	movzwl %ax,%eax
  80694e:	c9                   	leaveq 
  80694f:	c3                   	retq   
