
vmm/guest/obj/user/testkbd:     file format elf64-x86-64


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
  80003c:	e8 2a 04 00 00       	callq  80046b <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80004e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800052:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800059:	eb 10                	jmp    80006b <umain+0x28>
  80005b:	48 b8 4a 1d 80 00 00 	movabs $0x801d4a,%rax
  800062:	00 00 00 
  800065:	ff d0                	callq  *%rax
  800067:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80006b:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
  80006f:	7e ea                	jle    80005b <umain+0x18>
  800071:	bf 00 00 00 00       	mov    $0x0,%edi
  800076:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  80007d:	00 00 00 
  800080:	ff d0                	callq  *%rax
  800082:	48 b8 79 02 80 00 00 	movabs $0x800279,%rax
  800089:	00 00 00 
  80008c:	ff d0                	callq  *%rax
  80008e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800091:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800095:	79 30                	jns    8000c7 <umain+0x84>
  800097:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80009a:	89 c1                	mov    %eax,%ecx
  80009c:	48 ba 40 45 80 00 00 	movabs $0x804540,%rdx
  8000a3:	00 00 00 
  8000a6:	be 10 00 00 00       	mov    $0x10,%esi
  8000ab:	48 bf 4d 45 80 00 00 	movabs $0x80454d,%rdi
  8000b2:	00 00 00 
  8000b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ba:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  8000c1:	00 00 00 
  8000c4:	41 ff d0             	callq  *%r8
  8000c7:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000cb:	74 30                	je     8000fd <umain+0xba>
  8000cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000d0:	89 c1                	mov    %eax,%ecx
  8000d2:	48 ba 5f 45 80 00 00 	movabs $0x80455f,%rdx
  8000d9:	00 00 00 
  8000dc:	be 12 00 00 00       	mov    $0x12,%esi
  8000e1:	48 bf 4d 45 80 00 00 	movabs $0x80454d,%rdi
  8000e8:	00 00 00 
  8000eb:	b8 00 00 00 00       	mov    $0x0,%eax
  8000f0:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  8000f7:	00 00 00 
  8000fa:	41 ff d0             	callq  *%r8
  8000fd:	be 01 00 00 00       	mov    $0x1,%esi
  800102:	bf 00 00 00 00       	mov    $0x0,%edi
  800107:	48 b8 d7 24 80 00 00 	movabs $0x8024d7,%rax
  80010e:	00 00 00 
  800111:	ff d0                	callq  *%rax
  800113:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800116:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80011a:	79 30                	jns    80014c <umain+0x109>
  80011c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80011f:	89 c1                	mov    %eax,%ecx
  800121:	48 ba 79 45 80 00 00 	movabs $0x804579,%rdx
  800128:	00 00 00 
  80012b:	be 14 00 00 00       	mov    $0x14,%esi
  800130:	48 bf 4d 45 80 00 00 	movabs $0x80454d,%rdi
  800137:	00 00 00 
  80013a:	b8 00 00 00 00       	mov    $0x0,%eax
  80013f:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  800146:	00 00 00 
  800149:	41 ff d0             	callq  *%r8
  80014c:	48 bf 81 45 80 00 00 	movabs $0x804581,%rdi
  800153:	00 00 00 
  800156:	48 b8 93 12 80 00 00 	movabs $0x801293,%rax
  80015d:	00 00 00 
  800160:	ff d0                	callq  *%rax
  800162:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800166:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
  80016b:	74 29                	je     800196 <umain+0x153>
  80016d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800171:	48 89 c2             	mov    %rax,%rdx
  800174:	48 be 8f 45 80 00 00 	movabs $0x80458f,%rsi
  80017b:	00 00 00 
  80017e:	bf 01 00 00 00       	mov    $0x1,%edi
  800183:	b8 00 00 00 00       	mov    $0x0,%eax
  800188:	48 b9 29 33 80 00 00 	movabs $0x803329,%rcx
  80018f:	00 00 00 
  800192:	ff d1                	callq  *%rcx
  800194:	eb b6                	jmp    80014c <umain+0x109>
  800196:	48 be 93 45 80 00 00 	movabs $0x804593,%rsi
  80019d:	00 00 00 
  8001a0:	bf 01 00 00 00       	mov    $0x1,%edi
  8001a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8001aa:	48 ba 29 33 80 00 00 	movabs $0x803329,%rdx
  8001b1:	00 00 00 
  8001b4:	ff d2                	callq  *%rdx
  8001b6:	eb 94                	jmp    80014c <umain+0x109>

00000000008001b8 <cputchar>:
  8001b8:	55                   	push   %rbp
  8001b9:	48 89 e5             	mov    %rsp,%rbp
  8001bc:	48 83 ec 20          	sub    $0x20,%rsp
  8001c0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8001c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001c6:	88 45 ff             	mov    %al,-0x1(%rbp)
  8001c9:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8001cd:	be 01 00 00 00       	mov    $0x1,%esi
  8001d2:	48 89 c7             	mov    %rax,%rdi
  8001d5:	48 b8 40 1c 80 00 00 	movabs $0x801c40,%rax
  8001dc:	00 00 00 
  8001df:	ff d0                	callq  *%rax
  8001e1:	c9                   	leaveq 
  8001e2:	c3                   	retq   

00000000008001e3 <getchar>:
  8001e3:	55                   	push   %rbp
  8001e4:	48 89 e5             	mov    %rsp,%rbp
  8001e7:	48 83 ec 10          	sub    $0x10,%rsp
  8001eb:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8001ef:	ba 01 00 00 00       	mov    $0x1,%edx
  8001f4:	48 89 c6             	mov    %rax,%rsi
  8001f7:	bf 00 00 00 00       	mov    $0x0,%edi
  8001fc:	48 b8 80 26 80 00 00 	movabs $0x802680,%rax
  800203:	00 00 00 
  800206:	ff d0                	callq  *%rax
  800208:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80020b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80020f:	79 05                	jns    800216 <getchar+0x33>
  800211:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800214:	eb 14                	jmp    80022a <getchar+0x47>
  800216:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80021a:	7f 07                	jg     800223 <getchar+0x40>
  80021c:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  800221:	eb 07                	jmp    80022a <getchar+0x47>
  800223:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  800227:	0f b6 c0             	movzbl %al,%eax
  80022a:	c9                   	leaveq 
  80022b:	c3                   	retq   

000000000080022c <iscons>:
  80022c:	55                   	push   %rbp
  80022d:	48 89 e5             	mov    %rsp,%rbp
  800230:	48 83 ec 20          	sub    $0x20,%rsp
  800234:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800237:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80023b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80023e:	48 89 d6             	mov    %rdx,%rsi
  800241:	89 c7                	mov    %eax,%edi
  800243:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  80024a:	00 00 00 
  80024d:	ff d0                	callq  *%rax
  80024f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800252:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800256:	79 05                	jns    80025d <iscons+0x31>
  800258:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80025b:	eb 1a                	jmp    800277 <iscons+0x4b>
  80025d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800261:	8b 10                	mov    (%rax),%edx
  800263:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  80026a:	00 00 00 
  80026d:	8b 00                	mov    (%rax),%eax
  80026f:	39 c2                	cmp    %eax,%edx
  800271:	0f 94 c0             	sete   %al
  800274:	0f b6 c0             	movzbl %al,%eax
  800277:	c9                   	leaveq 
  800278:	c3                   	retq   

0000000000800279 <opencons>:
  800279:	55                   	push   %rbp
  80027a:	48 89 e5             	mov    %rsp,%rbp
  80027d:	48 83 ec 10          	sub    $0x10,%rsp
  800281:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  800285:	48 89 c7             	mov    %rax,%rdi
  800288:	48 b8 b6 21 80 00 00 	movabs $0x8021b6,%rax
  80028f:	00 00 00 
  800292:	ff d0                	callq  *%rax
  800294:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800297:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80029b:	79 05                	jns    8002a2 <opencons+0x29>
  80029d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002a0:	eb 5b                	jmp    8002fd <opencons+0x84>
  8002a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002a6:	ba 07 04 00 00       	mov    $0x407,%edx
  8002ab:	48 89 c6             	mov    %rax,%rsi
  8002ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8002b3:	48 b8 88 1d 80 00 00 	movabs $0x801d88,%rax
  8002ba:	00 00 00 
  8002bd:	ff d0                	callq  *%rax
  8002bf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8002c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8002c6:	79 05                	jns    8002cd <opencons+0x54>
  8002c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002cb:	eb 30                	jmp    8002fd <opencons+0x84>
  8002cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002d1:	48 ba 00 60 80 00 00 	movabs $0x806000,%rdx
  8002d8:	00 00 00 
  8002db:	8b 12                	mov    (%rdx),%edx
  8002dd:	89 10                	mov    %edx,(%rax)
  8002df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002e3:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8002ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002ee:	48 89 c7             	mov    %rax,%rdi
  8002f1:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  8002f8:	00 00 00 
  8002fb:	ff d0                	callq  *%rax
  8002fd:	c9                   	leaveq 
  8002fe:	c3                   	retq   

00000000008002ff <devcons_read>:
  8002ff:	55                   	push   %rbp
  800300:	48 89 e5             	mov    %rsp,%rbp
  800303:	48 83 ec 30          	sub    $0x30,%rsp
  800307:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80030b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80030f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800313:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800318:	75 07                	jne    800321 <devcons_read+0x22>
  80031a:	b8 00 00 00 00       	mov    $0x0,%eax
  80031f:	eb 4b                	jmp    80036c <devcons_read+0x6d>
  800321:	eb 0c                	jmp    80032f <devcons_read+0x30>
  800323:	48 b8 4a 1d 80 00 00 	movabs $0x801d4a,%rax
  80032a:	00 00 00 
  80032d:	ff d0                	callq  *%rax
  80032f:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  800336:	00 00 00 
  800339:	ff d0                	callq  *%rax
  80033b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80033e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800342:	74 df                	je     800323 <devcons_read+0x24>
  800344:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800348:	79 05                	jns    80034f <devcons_read+0x50>
  80034a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80034d:	eb 1d                	jmp    80036c <devcons_read+0x6d>
  80034f:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  800353:	75 07                	jne    80035c <devcons_read+0x5d>
  800355:	b8 00 00 00 00       	mov    $0x0,%eax
  80035a:	eb 10                	jmp    80036c <devcons_read+0x6d>
  80035c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80035f:	89 c2                	mov    %eax,%edx
  800361:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800365:	88 10                	mov    %dl,(%rax)
  800367:	b8 01 00 00 00       	mov    $0x1,%eax
  80036c:	c9                   	leaveq 
  80036d:	c3                   	retq   

000000000080036e <devcons_write>:
  80036e:	55                   	push   %rbp
  80036f:	48 89 e5             	mov    %rsp,%rbp
  800372:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  800379:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  800380:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  800387:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  80038e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800395:	eb 76                	jmp    80040d <devcons_write+0x9f>
  800397:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  80039e:	89 c2                	mov    %eax,%edx
  8003a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003a3:	29 c2                	sub    %eax,%edx
  8003a5:	89 d0                	mov    %edx,%eax
  8003a7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8003aa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8003ad:	83 f8 7f             	cmp    $0x7f,%eax
  8003b0:	76 07                	jbe    8003b9 <devcons_write+0x4b>
  8003b2:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8003b9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8003bc:	48 63 d0             	movslq %eax,%rdx
  8003bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003c2:	48 63 c8             	movslq %eax,%rcx
  8003c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8003cc:	48 01 c1             	add    %rax,%rcx
  8003cf:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8003d6:	48 89 ce             	mov    %rcx,%rsi
  8003d9:	48 89 c7             	mov    %rax,%rdi
  8003dc:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  8003e3:	00 00 00 
  8003e6:	ff d0                	callq  *%rax
  8003e8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8003eb:	48 63 d0             	movslq %eax,%rdx
  8003ee:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8003f5:	48 89 d6             	mov    %rdx,%rsi
  8003f8:	48 89 c7             	mov    %rax,%rdi
  8003fb:	48 b8 40 1c 80 00 00 	movabs $0x801c40,%rax
  800402:	00 00 00 
  800405:	ff d0                	callq  *%rax
  800407:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80040a:	01 45 fc             	add    %eax,-0x4(%rbp)
  80040d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800410:	48 98                	cltq   
  800412:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  800419:	0f 82 78 ff ff ff    	jb     800397 <devcons_write+0x29>
  80041f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800422:	c9                   	leaveq 
  800423:	c3                   	retq   

0000000000800424 <devcons_close>:
  800424:	55                   	push   %rbp
  800425:	48 89 e5             	mov    %rsp,%rbp
  800428:	48 83 ec 08          	sub    $0x8,%rsp
  80042c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800430:	b8 00 00 00 00       	mov    $0x0,%eax
  800435:	c9                   	leaveq 
  800436:	c3                   	retq   

0000000000800437 <devcons_stat>:
  800437:	55                   	push   %rbp
  800438:	48 89 e5             	mov    %rsp,%rbp
  80043b:	48 83 ec 10          	sub    $0x10,%rsp
  80043f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800443:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800447:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80044b:	48 be b0 45 80 00 00 	movabs $0x8045b0,%rsi
  800452:	00 00 00 
  800455:	48 89 c7             	mov    %rax,%rdi
  800458:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  80045f:	00 00 00 
  800462:	ff d0                	callq  *%rax
  800464:	b8 00 00 00 00       	mov    $0x0,%eax
  800469:	c9                   	leaveq 
  80046a:	c3                   	retq   

000000000080046b <libmain>:
  80046b:	55                   	push   %rbp
  80046c:	48 89 e5             	mov    %rsp,%rbp
  80046f:	48 83 ec 10          	sub    $0x10,%rsp
  800473:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800476:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80047a:	48 b8 0c 1d 80 00 00 	movabs $0x801d0c,%rax
  800481:	00 00 00 
  800484:	ff d0                	callq  *%rax
  800486:	25 ff 03 00 00       	and    $0x3ff,%eax
  80048b:	48 98                	cltq   
  80048d:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800494:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80049b:	00 00 00 
  80049e:	48 01 c2             	add    %rax,%rdx
  8004a1:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  8004a8:	00 00 00 
  8004ab:	48 89 10             	mov    %rdx,(%rax)
  8004ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8004b2:	7e 14                	jle    8004c8 <libmain+0x5d>
  8004b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8004b8:	48 8b 10             	mov    (%rax),%rdx
  8004bb:	48 b8 38 60 80 00 00 	movabs $0x806038,%rax
  8004c2:	00 00 00 
  8004c5:	48 89 10             	mov    %rdx,(%rax)
  8004c8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8004cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8004cf:	48 89 d6             	mov    %rdx,%rsi
  8004d2:	89 c7                	mov    %eax,%edi
  8004d4:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8004db:	00 00 00 
  8004de:	ff d0                	callq  *%rax
  8004e0:	48 b8 ee 04 80 00 00 	movabs $0x8004ee,%rax
  8004e7:	00 00 00 
  8004ea:	ff d0                	callq  *%rax
  8004ec:	c9                   	leaveq 
  8004ed:	c3                   	retq   

00000000008004ee <exit>:
  8004ee:	55                   	push   %rbp
  8004ef:	48 89 e5             	mov    %rsp,%rbp
  8004f2:	48 b8 a9 24 80 00 00 	movabs $0x8024a9,%rax
  8004f9:	00 00 00 
  8004fc:	ff d0                	callq  *%rax
  8004fe:	bf 00 00 00 00       	mov    $0x0,%edi
  800503:	48 b8 c8 1c 80 00 00 	movabs $0x801cc8,%rax
  80050a:	00 00 00 
  80050d:	ff d0                	callq  *%rax
  80050f:	5d                   	pop    %rbp
  800510:	c3                   	retq   

0000000000800511 <_panic>:
  800511:	55                   	push   %rbp
  800512:	48 89 e5             	mov    %rsp,%rbp
  800515:	53                   	push   %rbx
  800516:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  80051d:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800524:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  80052a:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800531:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800538:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80053f:	84 c0                	test   %al,%al
  800541:	74 23                	je     800566 <_panic+0x55>
  800543:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  80054a:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80054e:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800552:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800556:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  80055a:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80055e:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800562:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800566:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80056d:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800574:	00 00 00 
  800577:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  80057e:	00 00 00 
  800581:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800585:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  80058c:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800593:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80059a:	48 b8 38 60 80 00 00 	movabs $0x806038,%rax
  8005a1:	00 00 00 
  8005a4:	48 8b 18             	mov    (%rax),%rbx
  8005a7:	48 b8 0c 1d 80 00 00 	movabs $0x801d0c,%rax
  8005ae:	00 00 00 
  8005b1:	ff d0                	callq  *%rax
  8005b3:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8005b9:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8005c0:	41 89 c8             	mov    %ecx,%r8d
  8005c3:	48 89 d1             	mov    %rdx,%rcx
  8005c6:	48 89 da             	mov    %rbx,%rdx
  8005c9:	89 c6                	mov    %eax,%esi
  8005cb:	48 bf c8 45 80 00 00 	movabs $0x8045c8,%rdi
  8005d2:	00 00 00 
  8005d5:	b8 00 00 00 00       	mov    $0x0,%eax
  8005da:	49 b9 4a 07 80 00 00 	movabs $0x80074a,%r9
  8005e1:	00 00 00 
  8005e4:	41 ff d1             	callq  *%r9
  8005e7:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8005ee:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8005f5:	48 89 d6             	mov    %rdx,%rsi
  8005f8:	48 89 c7             	mov    %rax,%rdi
  8005fb:	48 b8 9e 06 80 00 00 	movabs $0x80069e,%rax
  800602:	00 00 00 
  800605:	ff d0                	callq  *%rax
  800607:	48 bf eb 45 80 00 00 	movabs $0x8045eb,%rdi
  80060e:	00 00 00 
  800611:	b8 00 00 00 00       	mov    $0x0,%eax
  800616:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  80061d:	00 00 00 
  800620:	ff d2                	callq  *%rdx
  800622:	cc                   	int3   
  800623:	eb fd                	jmp    800622 <_panic+0x111>

0000000000800625 <putch>:
  800625:	55                   	push   %rbp
  800626:	48 89 e5             	mov    %rsp,%rbp
  800629:	48 83 ec 10          	sub    $0x10,%rsp
  80062d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800630:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800634:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800638:	8b 00                	mov    (%rax),%eax
  80063a:	8d 48 01             	lea    0x1(%rax),%ecx
  80063d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800641:	89 0a                	mov    %ecx,(%rdx)
  800643:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800646:	89 d1                	mov    %edx,%ecx
  800648:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80064c:	48 98                	cltq   
  80064e:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800652:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800656:	8b 00                	mov    (%rax),%eax
  800658:	3d ff 00 00 00       	cmp    $0xff,%eax
  80065d:	75 2c                	jne    80068b <putch+0x66>
  80065f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800663:	8b 00                	mov    (%rax),%eax
  800665:	48 98                	cltq   
  800667:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80066b:	48 83 c2 08          	add    $0x8,%rdx
  80066f:	48 89 c6             	mov    %rax,%rsi
  800672:	48 89 d7             	mov    %rdx,%rdi
  800675:	48 b8 40 1c 80 00 00 	movabs $0x801c40,%rax
  80067c:	00 00 00 
  80067f:	ff d0                	callq  *%rax
  800681:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800685:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80068b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80068f:	8b 40 04             	mov    0x4(%rax),%eax
  800692:	8d 50 01             	lea    0x1(%rax),%edx
  800695:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800699:	89 50 04             	mov    %edx,0x4(%rax)
  80069c:	c9                   	leaveq 
  80069d:	c3                   	retq   

000000000080069e <vcprintf>:
  80069e:	55                   	push   %rbp
  80069f:	48 89 e5             	mov    %rsp,%rbp
  8006a2:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8006a9:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8006b0:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8006b7:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8006be:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8006c5:	48 8b 0a             	mov    (%rdx),%rcx
  8006c8:	48 89 08             	mov    %rcx,(%rax)
  8006cb:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8006cf:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8006d3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8006d7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8006db:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8006e2:	00 00 00 
  8006e5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8006ec:	00 00 00 
  8006ef:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8006f6:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8006fd:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800704:	48 89 c6             	mov    %rax,%rsi
  800707:	48 bf 25 06 80 00 00 	movabs $0x800625,%rdi
  80070e:	00 00 00 
  800711:	48 b8 fd 0a 80 00 00 	movabs $0x800afd,%rax
  800718:	00 00 00 
  80071b:	ff d0                	callq  *%rax
  80071d:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800723:	48 98                	cltq   
  800725:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80072c:	48 83 c2 08          	add    $0x8,%rdx
  800730:	48 89 c6             	mov    %rax,%rsi
  800733:	48 89 d7             	mov    %rdx,%rdi
  800736:	48 b8 40 1c 80 00 00 	movabs $0x801c40,%rax
  80073d:	00 00 00 
  800740:	ff d0                	callq  *%rax
  800742:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800748:	c9                   	leaveq 
  800749:	c3                   	retq   

000000000080074a <cprintf>:
  80074a:	55                   	push   %rbp
  80074b:	48 89 e5             	mov    %rsp,%rbp
  80074e:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800755:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80075c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800763:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80076a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800771:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800778:	84 c0                	test   %al,%al
  80077a:	74 20                	je     80079c <cprintf+0x52>
  80077c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800780:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800784:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800788:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80078c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800790:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800794:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800798:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80079c:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8007a3:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8007aa:	00 00 00 
  8007ad:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8007b4:	00 00 00 
  8007b7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8007bb:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8007c2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8007c9:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8007d0:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8007d7:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8007de:	48 8b 0a             	mov    (%rdx),%rcx
  8007e1:	48 89 08             	mov    %rcx,(%rax)
  8007e4:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8007e8:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8007ec:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8007f0:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8007f4:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8007fb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800802:	48 89 d6             	mov    %rdx,%rsi
  800805:	48 89 c7             	mov    %rax,%rdi
  800808:	48 b8 9e 06 80 00 00 	movabs $0x80069e,%rax
  80080f:	00 00 00 
  800812:	ff d0                	callq  *%rax
  800814:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80081a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800820:	c9                   	leaveq 
  800821:	c3                   	retq   

0000000000800822 <printnum>:
  800822:	55                   	push   %rbp
  800823:	48 89 e5             	mov    %rsp,%rbp
  800826:	53                   	push   %rbx
  800827:	48 83 ec 38          	sub    $0x38,%rsp
  80082b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80082f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800833:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800837:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80083a:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80083e:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800842:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800845:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800849:	77 3b                	ja     800886 <printnum+0x64>
  80084b:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80084e:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800852:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800855:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800859:	ba 00 00 00 00       	mov    $0x0,%edx
  80085e:	48 f7 f3             	div    %rbx
  800861:	48 89 c2             	mov    %rax,%rdx
  800864:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800867:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80086a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80086e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800872:	41 89 f9             	mov    %edi,%r9d
  800875:	48 89 c7             	mov    %rax,%rdi
  800878:	48 b8 22 08 80 00 00 	movabs $0x800822,%rax
  80087f:	00 00 00 
  800882:	ff d0                	callq  *%rax
  800884:	eb 1e                	jmp    8008a4 <printnum+0x82>
  800886:	eb 12                	jmp    80089a <printnum+0x78>
  800888:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80088c:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80088f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800893:	48 89 ce             	mov    %rcx,%rsi
  800896:	89 d7                	mov    %edx,%edi
  800898:	ff d0                	callq  *%rax
  80089a:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80089e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8008a2:	7f e4                	jg     800888 <printnum+0x66>
  8008a4:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8008a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8008b0:	48 f7 f1             	div    %rcx
  8008b3:	48 89 d0             	mov    %rdx,%rax
  8008b6:	48 ba f0 47 80 00 00 	movabs $0x8047f0,%rdx
  8008bd:	00 00 00 
  8008c0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8008c4:	0f be d0             	movsbl %al,%edx
  8008c7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8008cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008cf:	48 89 ce             	mov    %rcx,%rsi
  8008d2:	89 d7                	mov    %edx,%edi
  8008d4:	ff d0                	callq  *%rax
  8008d6:	48 83 c4 38          	add    $0x38,%rsp
  8008da:	5b                   	pop    %rbx
  8008db:	5d                   	pop    %rbp
  8008dc:	c3                   	retq   

00000000008008dd <getuint>:
  8008dd:	55                   	push   %rbp
  8008de:	48 89 e5             	mov    %rsp,%rbp
  8008e1:	48 83 ec 1c          	sub    $0x1c,%rsp
  8008e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8008e9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8008ec:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8008f0:	7e 52                	jle    800944 <getuint+0x67>
  8008f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008f6:	8b 00                	mov    (%rax),%eax
  8008f8:	83 f8 30             	cmp    $0x30,%eax
  8008fb:	73 24                	jae    800921 <getuint+0x44>
  8008fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800901:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800905:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800909:	8b 00                	mov    (%rax),%eax
  80090b:	89 c0                	mov    %eax,%eax
  80090d:	48 01 d0             	add    %rdx,%rax
  800910:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800914:	8b 12                	mov    (%rdx),%edx
  800916:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800919:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80091d:	89 0a                	mov    %ecx,(%rdx)
  80091f:	eb 17                	jmp    800938 <getuint+0x5b>
  800921:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800925:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800929:	48 89 d0             	mov    %rdx,%rax
  80092c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800930:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800934:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800938:	48 8b 00             	mov    (%rax),%rax
  80093b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80093f:	e9 a3 00 00 00       	jmpq   8009e7 <getuint+0x10a>
  800944:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800948:	74 4f                	je     800999 <getuint+0xbc>
  80094a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80094e:	8b 00                	mov    (%rax),%eax
  800950:	83 f8 30             	cmp    $0x30,%eax
  800953:	73 24                	jae    800979 <getuint+0x9c>
  800955:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800959:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80095d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800961:	8b 00                	mov    (%rax),%eax
  800963:	89 c0                	mov    %eax,%eax
  800965:	48 01 d0             	add    %rdx,%rax
  800968:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80096c:	8b 12                	mov    (%rdx),%edx
  80096e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800971:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800975:	89 0a                	mov    %ecx,(%rdx)
  800977:	eb 17                	jmp    800990 <getuint+0xb3>
  800979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80097d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800981:	48 89 d0             	mov    %rdx,%rax
  800984:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800988:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80098c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800990:	48 8b 00             	mov    (%rax),%rax
  800993:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800997:	eb 4e                	jmp    8009e7 <getuint+0x10a>
  800999:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80099d:	8b 00                	mov    (%rax),%eax
  80099f:	83 f8 30             	cmp    $0x30,%eax
  8009a2:	73 24                	jae    8009c8 <getuint+0xeb>
  8009a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009a8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b0:	8b 00                	mov    (%rax),%eax
  8009b2:	89 c0                	mov    %eax,%eax
  8009b4:	48 01 d0             	add    %rdx,%rax
  8009b7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009bb:	8b 12                	mov    (%rdx),%edx
  8009bd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009c0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009c4:	89 0a                	mov    %ecx,(%rdx)
  8009c6:	eb 17                	jmp    8009df <getuint+0x102>
  8009c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009cc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009d0:	48 89 d0             	mov    %rdx,%rax
  8009d3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009d7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009df:	8b 00                	mov    (%rax),%eax
  8009e1:	89 c0                	mov    %eax,%eax
  8009e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8009eb:	c9                   	leaveq 
  8009ec:	c3                   	retq   

00000000008009ed <getint>:
  8009ed:	55                   	push   %rbp
  8009ee:	48 89 e5             	mov    %rsp,%rbp
  8009f1:	48 83 ec 1c          	sub    $0x1c,%rsp
  8009f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8009f9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8009fc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800a00:	7e 52                	jle    800a54 <getint+0x67>
  800a02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a06:	8b 00                	mov    (%rax),%eax
  800a08:	83 f8 30             	cmp    $0x30,%eax
  800a0b:	73 24                	jae    800a31 <getint+0x44>
  800a0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a11:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a19:	8b 00                	mov    (%rax),%eax
  800a1b:	89 c0                	mov    %eax,%eax
  800a1d:	48 01 d0             	add    %rdx,%rax
  800a20:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a24:	8b 12                	mov    (%rdx),%edx
  800a26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a29:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a2d:	89 0a                	mov    %ecx,(%rdx)
  800a2f:	eb 17                	jmp    800a48 <getint+0x5b>
  800a31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a35:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a39:	48 89 d0             	mov    %rdx,%rax
  800a3c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a40:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a44:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a48:	48 8b 00             	mov    (%rax),%rax
  800a4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a4f:	e9 a3 00 00 00       	jmpq   800af7 <getint+0x10a>
  800a54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800a58:	74 4f                	je     800aa9 <getint+0xbc>
  800a5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a5e:	8b 00                	mov    (%rax),%eax
  800a60:	83 f8 30             	cmp    $0x30,%eax
  800a63:	73 24                	jae    800a89 <getint+0x9c>
  800a65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a69:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a71:	8b 00                	mov    (%rax),%eax
  800a73:	89 c0                	mov    %eax,%eax
  800a75:	48 01 d0             	add    %rdx,%rax
  800a78:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a7c:	8b 12                	mov    (%rdx),%edx
  800a7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a81:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a85:	89 0a                	mov    %ecx,(%rdx)
  800a87:	eb 17                	jmp    800aa0 <getint+0xb3>
  800a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a8d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a91:	48 89 d0             	mov    %rdx,%rax
  800a94:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a98:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800aa0:	48 8b 00             	mov    (%rax),%rax
  800aa3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800aa7:	eb 4e                	jmp    800af7 <getint+0x10a>
  800aa9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800aad:	8b 00                	mov    (%rax),%eax
  800aaf:	83 f8 30             	cmp    $0x30,%eax
  800ab2:	73 24                	jae    800ad8 <getint+0xeb>
  800ab4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ab8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800abc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ac0:	8b 00                	mov    (%rax),%eax
  800ac2:	89 c0                	mov    %eax,%eax
  800ac4:	48 01 d0             	add    %rdx,%rax
  800ac7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800acb:	8b 12                	mov    (%rdx),%edx
  800acd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800ad0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ad4:	89 0a                	mov    %ecx,(%rdx)
  800ad6:	eb 17                	jmp    800aef <getint+0x102>
  800ad8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800adc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800ae0:	48 89 d0             	mov    %rdx,%rax
  800ae3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800ae7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800aeb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800aef:	8b 00                	mov    (%rax),%eax
  800af1:	48 98                	cltq   
  800af3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800afb:	c9                   	leaveq 
  800afc:	c3                   	retq   

0000000000800afd <vprintfmt>:
  800afd:	55                   	push   %rbp
  800afe:	48 89 e5             	mov    %rsp,%rbp
  800b01:	41 54                	push   %r12
  800b03:	53                   	push   %rbx
  800b04:	48 83 ec 60          	sub    $0x60,%rsp
  800b08:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800b0c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800b10:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800b14:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800b18:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b1c:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800b20:	48 8b 0a             	mov    (%rdx),%rcx
  800b23:	48 89 08             	mov    %rcx,(%rax)
  800b26:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800b2a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800b2e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800b32:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800b36:	eb 17                	jmp    800b4f <vprintfmt+0x52>
  800b38:	85 db                	test   %ebx,%ebx
  800b3a:	0f 84 cc 04 00 00    	je     80100c <vprintfmt+0x50f>
  800b40:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b44:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b48:	48 89 d6             	mov    %rdx,%rsi
  800b4b:	89 df                	mov    %ebx,%edi
  800b4d:	ff d0                	callq  *%rax
  800b4f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b53:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800b57:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800b5b:	0f b6 00             	movzbl (%rax),%eax
  800b5e:	0f b6 d8             	movzbl %al,%ebx
  800b61:	83 fb 25             	cmp    $0x25,%ebx
  800b64:	75 d2                	jne    800b38 <vprintfmt+0x3b>
  800b66:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800b6a:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800b71:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b78:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800b7f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800b86:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b8a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800b8e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800b92:	0f b6 00             	movzbl (%rax),%eax
  800b95:	0f b6 d8             	movzbl %al,%ebx
  800b98:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800b9b:	83 f8 55             	cmp    $0x55,%eax
  800b9e:	0f 87 34 04 00 00    	ja     800fd8 <vprintfmt+0x4db>
  800ba4:	89 c0                	mov    %eax,%eax
  800ba6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800bad:	00 
  800bae:	48 b8 18 48 80 00 00 	movabs $0x804818,%rax
  800bb5:	00 00 00 
  800bb8:	48 01 d0             	add    %rdx,%rax
  800bbb:	48 8b 00             	mov    (%rax),%rax
  800bbe:	ff e0                	jmpq   *%rax
  800bc0:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800bc4:	eb c0                	jmp    800b86 <vprintfmt+0x89>
  800bc6:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800bca:	eb ba                	jmp    800b86 <vprintfmt+0x89>
  800bcc:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800bd3:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800bd6:	89 d0                	mov    %edx,%eax
  800bd8:	c1 e0 02             	shl    $0x2,%eax
  800bdb:	01 d0                	add    %edx,%eax
  800bdd:	01 c0                	add    %eax,%eax
  800bdf:	01 d8                	add    %ebx,%eax
  800be1:	83 e8 30             	sub    $0x30,%eax
  800be4:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800be7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800beb:	0f b6 00             	movzbl (%rax),%eax
  800bee:	0f be d8             	movsbl %al,%ebx
  800bf1:	83 fb 2f             	cmp    $0x2f,%ebx
  800bf4:	7e 0c                	jle    800c02 <vprintfmt+0x105>
  800bf6:	83 fb 39             	cmp    $0x39,%ebx
  800bf9:	7f 07                	jg     800c02 <vprintfmt+0x105>
  800bfb:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800c00:	eb d1                	jmp    800bd3 <vprintfmt+0xd6>
  800c02:	eb 58                	jmp    800c5c <vprintfmt+0x15f>
  800c04:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c07:	83 f8 30             	cmp    $0x30,%eax
  800c0a:	73 17                	jae    800c23 <vprintfmt+0x126>
  800c0c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c10:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c13:	89 c0                	mov    %eax,%eax
  800c15:	48 01 d0             	add    %rdx,%rax
  800c18:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c1b:	83 c2 08             	add    $0x8,%edx
  800c1e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c21:	eb 0f                	jmp    800c32 <vprintfmt+0x135>
  800c23:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c27:	48 89 d0             	mov    %rdx,%rax
  800c2a:	48 83 c2 08          	add    $0x8,%rdx
  800c2e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c32:	8b 00                	mov    (%rax),%eax
  800c34:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800c37:	eb 23                	jmp    800c5c <vprintfmt+0x15f>
  800c39:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c3d:	79 0c                	jns    800c4b <vprintfmt+0x14e>
  800c3f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800c46:	e9 3b ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c4b:	e9 36 ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c50:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800c57:	e9 2a ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c5c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c60:	79 12                	jns    800c74 <vprintfmt+0x177>
  800c62:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800c65:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800c68:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800c6f:	e9 12 ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c74:	e9 0d ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c79:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800c7d:	e9 04 ff ff ff       	jmpq   800b86 <vprintfmt+0x89>
  800c82:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c85:	83 f8 30             	cmp    $0x30,%eax
  800c88:	73 17                	jae    800ca1 <vprintfmt+0x1a4>
  800c8a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c8e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c91:	89 c0                	mov    %eax,%eax
  800c93:	48 01 d0             	add    %rdx,%rax
  800c96:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c99:	83 c2 08             	add    $0x8,%edx
  800c9c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c9f:	eb 0f                	jmp    800cb0 <vprintfmt+0x1b3>
  800ca1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ca5:	48 89 d0             	mov    %rdx,%rax
  800ca8:	48 83 c2 08          	add    $0x8,%rdx
  800cac:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800cb0:	8b 10                	mov    (%rax),%edx
  800cb2:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800cb6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cba:	48 89 ce             	mov    %rcx,%rsi
  800cbd:	89 d7                	mov    %edx,%edi
  800cbf:	ff d0                	callq  *%rax
  800cc1:	e9 40 03 00 00       	jmpq   801006 <vprintfmt+0x509>
  800cc6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cc9:	83 f8 30             	cmp    $0x30,%eax
  800ccc:	73 17                	jae    800ce5 <vprintfmt+0x1e8>
  800cce:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800cd2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cd5:	89 c0                	mov    %eax,%eax
  800cd7:	48 01 d0             	add    %rdx,%rax
  800cda:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800cdd:	83 c2 08             	add    $0x8,%edx
  800ce0:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800ce3:	eb 0f                	jmp    800cf4 <vprintfmt+0x1f7>
  800ce5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ce9:	48 89 d0             	mov    %rdx,%rax
  800cec:	48 83 c2 08          	add    $0x8,%rdx
  800cf0:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800cf4:	8b 18                	mov    (%rax),%ebx
  800cf6:	85 db                	test   %ebx,%ebx
  800cf8:	79 02                	jns    800cfc <vprintfmt+0x1ff>
  800cfa:	f7 db                	neg    %ebx
  800cfc:	83 fb 15             	cmp    $0x15,%ebx
  800cff:	7f 16                	jg     800d17 <vprintfmt+0x21a>
  800d01:	48 b8 40 47 80 00 00 	movabs $0x804740,%rax
  800d08:	00 00 00 
  800d0b:	48 63 d3             	movslq %ebx,%rdx
  800d0e:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800d12:	4d 85 e4             	test   %r12,%r12
  800d15:	75 2e                	jne    800d45 <vprintfmt+0x248>
  800d17:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800d1b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d1f:	89 d9                	mov    %ebx,%ecx
  800d21:	48 ba 01 48 80 00 00 	movabs $0x804801,%rdx
  800d28:	00 00 00 
  800d2b:	48 89 c7             	mov    %rax,%rdi
  800d2e:	b8 00 00 00 00       	mov    $0x0,%eax
  800d33:	49 b8 15 10 80 00 00 	movabs $0x801015,%r8
  800d3a:	00 00 00 
  800d3d:	41 ff d0             	callq  *%r8
  800d40:	e9 c1 02 00 00       	jmpq   801006 <vprintfmt+0x509>
  800d45:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800d49:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d4d:	4c 89 e1             	mov    %r12,%rcx
  800d50:	48 ba 0a 48 80 00 00 	movabs $0x80480a,%rdx
  800d57:	00 00 00 
  800d5a:	48 89 c7             	mov    %rax,%rdi
  800d5d:	b8 00 00 00 00       	mov    $0x0,%eax
  800d62:	49 b8 15 10 80 00 00 	movabs $0x801015,%r8
  800d69:	00 00 00 
  800d6c:	41 ff d0             	callq  *%r8
  800d6f:	e9 92 02 00 00       	jmpq   801006 <vprintfmt+0x509>
  800d74:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d77:	83 f8 30             	cmp    $0x30,%eax
  800d7a:	73 17                	jae    800d93 <vprintfmt+0x296>
  800d7c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d80:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d83:	89 c0                	mov    %eax,%eax
  800d85:	48 01 d0             	add    %rdx,%rax
  800d88:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d8b:	83 c2 08             	add    $0x8,%edx
  800d8e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d91:	eb 0f                	jmp    800da2 <vprintfmt+0x2a5>
  800d93:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d97:	48 89 d0             	mov    %rdx,%rax
  800d9a:	48 83 c2 08          	add    $0x8,%rdx
  800d9e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800da2:	4c 8b 20             	mov    (%rax),%r12
  800da5:	4d 85 e4             	test   %r12,%r12
  800da8:	75 0a                	jne    800db4 <vprintfmt+0x2b7>
  800daa:	49 bc 0d 48 80 00 00 	movabs $0x80480d,%r12
  800db1:	00 00 00 
  800db4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800db8:	7e 3f                	jle    800df9 <vprintfmt+0x2fc>
  800dba:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800dbe:	74 39                	je     800df9 <vprintfmt+0x2fc>
  800dc0:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800dc3:	48 98                	cltq   
  800dc5:	48 89 c6             	mov    %rax,%rsi
  800dc8:	4c 89 e7             	mov    %r12,%rdi
  800dcb:	48 b8 1b 14 80 00 00 	movabs $0x80141b,%rax
  800dd2:	00 00 00 
  800dd5:	ff d0                	callq  *%rax
  800dd7:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800dda:	eb 17                	jmp    800df3 <vprintfmt+0x2f6>
  800ddc:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800de0:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800de4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800de8:	48 89 ce             	mov    %rcx,%rsi
  800deb:	89 d7                	mov    %edx,%edi
  800ded:	ff d0                	callq  *%rax
  800def:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800df3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800df7:	7f e3                	jg     800ddc <vprintfmt+0x2df>
  800df9:	eb 37                	jmp    800e32 <vprintfmt+0x335>
  800dfb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800dff:	74 1e                	je     800e1f <vprintfmt+0x322>
  800e01:	83 fb 1f             	cmp    $0x1f,%ebx
  800e04:	7e 05                	jle    800e0b <vprintfmt+0x30e>
  800e06:	83 fb 7e             	cmp    $0x7e,%ebx
  800e09:	7e 14                	jle    800e1f <vprintfmt+0x322>
  800e0b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e0f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e13:	48 89 d6             	mov    %rdx,%rsi
  800e16:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800e1b:	ff d0                	callq  *%rax
  800e1d:	eb 0f                	jmp    800e2e <vprintfmt+0x331>
  800e1f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e23:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e27:	48 89 d6             	mov    %rdx,%rsi
  800e2a:	89 df                	mov    %ebx,%edi
  800e2c:	ff d0                	callq  *%rax
  800e2e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800e32:	4c 89 e0             	mov    %r12,%rax
  800e35:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800e39:	0f b6 00             	movzbl (%rax),%eax
  800e3c:	0f be d8             	movsbl %al,%ebx
  800e3f:	85 db                	test   %ebx,%ebx
  800e41:	74 10                	je     800e53 <vprintfmt+0x356>
  800e43:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800e47:	78 b2                	js     800dfb <vprintfmt+0x2fe>
  800e49:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800e4d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800e51:	79 a8                	jns    800dfb <vprintfmt+0x2fe>
  800e53:	eb 16                	jmp    800e6b <vprintfmt+0x36e>
  800e55:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e59:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e5d:	48 89 d6             	mov    %rdx,%rsi
  800e60:	bf 20 00 00 00       	mov    $0x20,%edi
  800e65:	ff d0                	callq  *%rax
  800e67:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800e6b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e6f:	7f e4                	jg     800e55 <vprintfmt+0x358>
  800e71:	e9 90 01 00 00       	jmpq   801006 <vprintfmt+0x509>
  800e76:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e7a:	be 03 00 00 00       	mov    $0x3,%esi
  800e7f:	48 89 c7             	mov    %rax,%rdi
  800e82:	48 b8 ed 09 80 00 00 	movabs $0x8009ed,%rax
  800e89:	00 00 00 
  800e8c:	ff d0                	callq  *%rax
  800e8e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e96:	48 85 c0             	test   %rax,%rax
  800e99:	79 1d                	jns    800eb8 <vprintfmt+0x3bb>
  800e9b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e9f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ea3:	48 89 d6             	mov    %rdx,%rsi
  800ea6:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800eab:	ff d0                	callq  *%rax
  800ead:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800eb1:	48 f7 d8             	neg    %rax
  800eb4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800eb8:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800ebf:	e9 d5 00 00 00       	jmpq   800f99 <vprintfmt+0x49c>
  800ec4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ec8:	be 03 00 00 00       	mov    $0x3,%esi
  800ecd:	48 89 c7             	mov    %rax,%rdi
  800ed0:	48 b8 dd 08 80 00 00 	movabs $0x8008dd,%rax
  800ed7:	00 00 00 
  800eda:	ff d0                	callq  *%rax
  800edc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ee0:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800ee7:	e9 ad 00 00 00       	jmpq   800f99 <vprintfmt+0x49c>
  800eec:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ef0:	be 03 00 00 00       	mov    $0x3,%esi
  800ef5:	48 89 c7             	mov    %rax,%rdi
  800ef8:	48 b8 dd 08 80 00 00 	movabs $0x8008dd,%rax
  800eff:	00 00 00 
  800f02:	ff d0                	callq  *%rax
  800f04:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f08:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800f0f:	e9 85 00 00 00       	jmpq   800f99 <vprintfmt+0x49c>
  800f14:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f18:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f1c:	48 89 d6             	mov    %rdx,%rsi
  800f1f:	bf 30 00 00 00       	mov    $0x30,%edi
  800f24:	ff d0                	callq  *%rax
  800f26:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f2a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f2e:	48 89 d6             	mov    %rdx,%rsi
  800f31:	bf 78 00 00 00       	mov    $0x78,%edi
  800f36:	ff d0                	callq  *%rax
  800f38:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800f3b:	83 f8 30             	cmp    $0x30,%eax
  800f3e:	73 17                	jae    800f57 <vprintfmt+0x45a>
  800f40:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800f44:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800f47:	89 c0                	mov    %eax,%eax
  800f49:	48 01 d0             	add    %rdx,%rax
  800f4c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800f4f:	83 c2 08             	add    $0x8,%edx
  800f52:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800f55:	eb 0f                	jmp    800f66 <vprintfmt+0x469>
  800f57:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800f5b:	48 89 d0             	mov    %rdx,%rax
  800f5e:	48 83 c2 08          	add    $0x8,%rdx
  800f62:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800f66:	48 8b 00             	mov    (%rax),%rax
  800f69:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f6d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800f74:	eb 23                	jmp    800f99 <vprintfmt+0x49c>
  800f76:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f7a:	be 03 00 00 00       	mov    $0x3,%esi
  800f7f:	48 89 c7             	mov    %rax,%rdi
  800f82:	48 b8 dd 08 80 00 00 	movabs $0x8008dd,%rax
  800f89:	00 00 00 
  800f8c:	ff d0                	callq  *%rax
  800f8e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f92:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800f99:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800f9e:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800fa1:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800fa4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800fa8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800fac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fb0:	45 89 c1             	mov    %r8d,%r9d
  800fb3:	41 89 f8             	mov    %edi,%r8d
  800fb6:	48 89 c7             	mov    %rax,%rdi
  800fb9:	48 b8 22 08 80 00 00 	movabs $0x800822,%rax
  800fc0:	00 00 00 
  800fc3:	ff d0                	callq  *%rax
  800fc5:	eb 3f                	jmp    801006 <vprintfmt+0x509>
  800fc7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fcf:	48 89 d6             	mov    %rdx,%rsi
  800fd2:	89 df                	mov    %ebx,%edi
  800fd4:	ff d0                	callq  *%rax
  800fd6:	eb 2e                	jmp    801006 <vprintfmt+0x509>
  800fd8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fdc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fe0:	48 89 d6             	mov    %rdx,%rsi
  800fe3:	bf 25 00 00 00       	mov    $0x25,%edi
  800fe8:	ff d0                	callq  *%rax
  800fea:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800fef:	eb 05                	jmp    800ff6 <vprintfmt+0x4f9>
  800ff1:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800ff6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800ffa:	48 83 e8 01          	sub    $0x1,%rax
  800ffe:	0f b6 00             	movzbl (%rax),%eax
  801001:	3c 25                	cmp    $0x25,%al
  801003:	75 ec                	jne    800ff1 <vprintfmt+0x4f4>
  801005:	90                   	nop
  801006:	90                   	nop
  801007:	e9 43 fb ff ff       	jmpq   800b4f <vprintfmt+0x52>
  80100c:	48 83 c4 60          	add    $0x60,%rsp
  801010:	5b                   	pop    %rbx
  801011:	41 5c                	pop    %r12
  801013:	5d                   	pop    %rbp
  801014:	c3                   	retq   

0000000000801015 <printfmt>:
  801015:	55                   	push   %rbp
  801016:	48 89 e5             	mov    %rsp,%rbp
  801019:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  801020:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801027:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80102e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801035:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80103c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801043:	84 c0                	test   %al,%al
  801045:	74 20                	je     801067 <printfmt+0x52>
  801047:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80104b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80104f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801053:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801057:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80105b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80105f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801063:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801067:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80106e:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801075:	00 00 00 
  801078:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  80107f:	00 00 00 
  801082:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801086:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80108d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801094:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80109b:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  8010a2:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8010a9:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  8010b0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  8010b7:	48 89 c7             	mov    %rax,%rdi
  8010ba:	48 b8 fd 0a 80 00 00 	movabs $0x800afd,%rax
  8010c1:	00 00 00 
  8010c4:	ff d0                	callq  *%rax
  8010c6:	c9                   	leaveq 
  8010c7:	c3                   	retq   

00000000008010c8 <sprintputch>:
  8010c8:	55                   	push   %rbp
  8010c9:	48 89 e5             	mov    %rsp,%rbp
  8010cc:	48 83 ec 10          	sub    $0x10,%rsp
  8010d0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8010d3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8010d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010db:	8b 40 10             	mov    0x10(%rax),%eax
  8010de:	8d 50 01             	lea    0x1(%rax),%edx
  8010e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010e5:	89 50 10             	mov    %edx,0x10(%rax)
  8010e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010ec:	48 8b 10             	mov    (%rax),%rdx
  8010ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  8010f7:	48 39 c2             	cmp    %rax,%rdx
  8010fa:	73 17                	jae    801113 <sprintputch+0x4b>
  8010fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801100:	48 8b 00             	mov    (%rax),%rax
  801103:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801107:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80110b:	48 89 0a             	mov    %rcx,(%rdx)
  80110e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801111:	88 10                	mov    %dl,(%rax)
  801113:	c9                   	leaveq 
  801114:	c3                   	retq   

0000000000801115 <vsnprintf>:
  801115:	55                   	push   %rbp
  801116:	48 89 e5             	mov    %rsp,%rbp
  801119:	48 83 ec 50          	sub    $0x50,%rsp
  80111d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801121:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801124:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801128:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  80112c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  801130:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801134:	48 8b 0a             	mov    (%rdx),%rcx
  801137:	48 89 08             	mov    %rcx,(%rax)
  80113a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80113e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801142:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801146:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80114a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80114e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801152:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801155:	48 98                	cltq   
  801157:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80115b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80115f:	48 01 d0             	add    %rdx,%rax
  801162:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80116d:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801172:	74 06                	je     80117a <vsnprintf+0x65>
  801174:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801178:	7f 07                	jg     801181 <vsnprintf+0x6c>
  80117a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80117f:	eb 2f                	jmp    8011b0 <vsnprintf+0x9b>
  801181:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801185:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801189:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80118d:	48 89 c6             	mov    %rax,%rsi
  801190:	48 bf c8 10 80 00 00 	movabs $0x8010c8,%rdi
  801197:	00 00 00 
  80119a:	48 b8 fd 0a 80 00 00 	movabs $0x800afd,%rax
  8011a1:	00 00 00 
  8011a4:	ff d0                	callq  *%rax
  8011a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8011aa:	c6 00 00             	movb   $0x0,(%rax)
  8011ad:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8011b0:	c9                   	leaveq 
  8011b1:	c3                   	retq   

00000000008011b2 <snprintf>:
  8011b2:	55                   	push   %rbp
  8011b3:	48 89 e5             	mov    %rsp,%rbp
  8011b6:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8011bd:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8011c4:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8011ca:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8011d1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8011d8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8011df:	84 c0                	test   %al,%al
  8011e1:	74 20                	je     801203 <snprintf+0x51>
  8011e3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8011e7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8011eb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8011ef:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8011f3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8011f7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8011fb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8011ff:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801203:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  80120a:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  801211:	00 00 00 
  801214:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80121b:	00 00 00 
  80121e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801222:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801229:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801230:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801237:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80123e:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801245:	48 8b 0a             	mov    (%rdx),%rcx
  801248:	48 89 08             	mov    %rcx,(%rax)
  80124b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80124f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801253:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801257:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80125b:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801262:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801269:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80126f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801276:	48 89 c7             	mov    %rax,%rdi
  801279:	48 b8 15 11 80 00 00 	movabs $0x801115,%rax
  801280:	00 00 00 
  801283:	ff d0                	callq  *%rax
  801285:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80128b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801291:	c9                   	leaveq 
  801292:	c3                   	retq   

0000000000801293 <readline>:
  801293:	55                   	push   %rbp
  801294:	48 89 e5             	mov    %rsp,%rbp
  801297:	48 83 ec 20          	sub    $0x20,%rsp
  80129b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80129f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8012a4:	74 27                	je     8012cd <readline+0x3a>
  8012a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012aa:	48 89 c2             	mov    %rax,%rdx
  8012ad:	48 be c8 4a 80 00 00 	movabs $0x804ac8,%rsi
  8012b4:	00 00 00 
  8012b7:	bf 01 00 00 00       	mov    $0x1,%edi
  8012bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8012c1:	48 b9 29 33 80 00 00 	movabs $0x803329,%rcx
  8012c8:	00 00 00 
  8012cb:	ff d1                	callq  *%rcx
  8012cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8012d4:	bf 00 00 00 00       	mov    $0x0,%edi
  8012d9:	48 b8 2c 02 80 00 00 	movabs $0x80022c,%rax
  8012e0:	00 00 00 
  8012e3:	ff d0                	callq  *%rax
  8012e5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8012e8:	48 b8 e3 01 80 00 00 	movabs $0x8001e3,%rax
  8012ef:	00 00 00 
  8012f2:	ff d0                	callq  *%rax
  8012f4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8012f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8012fb:	79 30                	jns    80132d <readline+0x9a>
  8012fd:	83 7d f4 f7          	cmpl   $0xfffffff7,-0xc(%rbp)
  801301:	74 20                	je     801323 <readline+0x90>
  801303:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801306:	89 c6                	mov    %eax,%esi
  801308:	48 bf cb 4a 80 00 00 	movabs $0x804acb,%rdi
  80130f:	00 00 00 
  801312:	b8 00 00 00 00       	mov    $0x0,%eax
  801317:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  80131e:	00 00 00 
  801321:	ff d2                	callq  *%rdx
  801323:	b8 00 00 00 00       	mov    $0x0,%eax
  801328:	e9 be 00 00 00       	jmpq   8013eb <readline+0x158>
  80132d:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
  801331:	74 06                	je     801339 <readline+0xa6>
  801333:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%rbp)
  801337:	75 26                	jne    80135f <readline+0xcc>
  801339:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80133d:	7e 20                	jle    80135f <readline+0xcc>
  80133f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801343:	74 11                	je     801356 <readline+0xc3>
  801345:	bf 08 00 00 00       	mov    $0x8,%edi
  80134a:	48 b8 b8 01 80 00 00 	movabs $0x8001b8,%rax
  801351:	00 00 00 
  801354:	ff d0                	callq  *%rax
  801356:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  80135a:	e9 87 00 00 00       	jmpq   8013e6 <readline+0x153>
  80135f:	83 7d f4 1f          	cmpl   $0x1f,-0xc(%rbp)
  801363:	7e 3f                	jle    8013a4 <readline+0x111>
  801365:	81 7d fc fe 03 00 00 	cmpl   $0x3fe,-0x4(%rbp)
  80136c:	7f 36                	jg     8013a4 <readline+0x111>
  80136e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801372:	74 11                	je     801385 <readline+0xf2>
  801374:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801377:	89 c7                	mov    %eax,%edi
  801379:	48 b8 b8 01 80 00 00 	movabs $0x8001b8,%rax
  801380:	00 00 00 
  801383:	ff d0                	callq  *%rax
  801385:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801388:	8d 50 01             	lea    0x1(%rax),%edx
  80138b:	89 55 fc             	mov    %edx,-0x4(%rbp)
  80138e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801391:	89 d1                	mov    %edx,%ecx
  801393:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  80139a:	00 00 00 
  80139d:	48 98                	cltq   
  80139f:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
  8013a2:	eb 42                	jmp    8013e6 <readline+0x153>
  8013a4:	83 7d f4 0a          	cmpl   $0xa,-0xc(%rbp)
  8013a8:	74 06                	je     8013b0 <readline+0x11d>
  8013aa:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
  8013ae:	75 36                	jne    8013e6 <readline+0x153>
  8013b0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8013b4:	74 11                	je     8013c7 <readline+0x134>
  8013b6:	bf 0a 00 00 00       	mov    $0xa,%edi
  8013bb:	48 b8 b8 01 80 00 00 	movabs $0x8001b8,%rax
  8013c2:	00 00 00 
  8013c5:	ff d0                	callq  *%rax
  8013c7:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  8013ce:	00 00 00 
  8013d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8013d4:	48 98                	cltq   
  8013d6:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
  8013da:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8013e1:	00 00 00 
  8013e4:	eb 05                	jmp    8013eb <readline+0x158>
  8013e6:	e9 fd fe ff ff       	jmpq   8012e8 <readline+0x55>
  8013eb:	c9                   	leaveq 
  8013ec:	c3                   	retq   

00000000008013ed <strlen>:
  8013ed:	55                   	push   %rbp
  8013ee:	48 89 e5             	mov    %rsp,%rbp
  8013f1:	48 83 ec 18          	sub    $0x18,%rsp
  8013f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801400:	eb 09                	jmp    80140b <strlen+0x1e>
  801402:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801406:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80140b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80140f:	0f b6 00             	movzbl (%rax),%eax
  801412:	84 c0                	test   %al,%al
  801414:	75 ec                	jne    801402 <strlen+0x15>
  801416:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801419:	c9                   	leaveq 
  80141a:	c3                   	retq   

000000000080141b <strnlen>:
  80141b:	55                   	push   %rbp
  80141c:	48 89 e5             	mov    %rsp,%rbp
  80141f:	48 83 ec 20          	sub    $0x20,%rsp
  801423:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801427:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80142b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801432:	eb 0e                	jmp    801442 <strnlen+0x27>
  801434:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801438:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80143d:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801442:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801447:	74 0b                	je     801454 <strnlen+0x39>
  801449:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80144d:	0f b6 00             	movzbl (%rax),%eax
  801450:	84 c0                	test   %al,%al
  801452:	75 e0                	jne    801434 <strnlen+0x19>
  801454:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801457:	c9                   	leaveq 
  801458:	c3                   	retq   

0000000000801459 <strcpy>:
  801459:	55                   	push   %rbp
  80145a:	48 89 e5             	mov    %rsp,%rbp
  80145d:	48 83 ec 20          	sub    $0x20,%rsp
  801461:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801465:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801469:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80146d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801471:	90                   	nop
  801472:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801476:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80147a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80147e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801482:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801486:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80148a:	0f b6 12             	movzbl (%rdx),%edx
  80148d:	88 10                	mov    %dl,(%rax)
  80148f:	0f b6 00             	movzbl (%rax),%eax
  801492:	84 c0                	test   %al,%al
  801494:	75 dc                	jne    801472 <strcpy+0x19>
  801496:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80149a:	c9                   	leaveq 
  80149b:	c3                   	retq   

000000000080149c <strcat>:
  80149c:	55                   	push   %rbp
  80149d:	48 89 e5             	mov    %rsp,%rbp
  8014a0:	48 83 ec 20          	sub    $0x20,%rsp
  8014a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014a8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014b0:	48 89 c7             	mov    %rax,%rdi
  8014b3:	48 b8 ed 13 80 00 00 	movabs $0x8013ed,%rax
  8014ba:	00 00 00 
  8014bd:	ff d0                	callq  *%rax
  8014bf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8014c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8014c5:	48 63 d0             	movslq %eax,%rdx
  8014c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014cc:	48 01 c2             	add    %rax,%rdx
  8014cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014d3:	48 89 c6             	mov    %rax,%rsi
  8014d6:	48 89 d7             	mov    %rdx,%rdi
  8014d9:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  8014e0:	00 00 00 
  8014e3:	ff d0                	callq  *%rax
  8014e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014e9:	c9                   	leaveq 
  8014ea:	c3                   	retq   

00000000008014eb <strncpy>:
  8014eb:	55                   	push   %rbp
  8014ec:	48 89 e5             	mov    %rsp,%rbp
  8014ef:	48 83 ec 28          	sub    $0x28,%rsp
  8014f3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014f7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014fb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801503:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801507:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80150e:	00 
  80150f:	eb 2a                	jmp    80153b <strncpy+0x50>
  801511:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801515:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801519:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80151d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801521:	0f b6 12             	movzbl (%rdx),%edx
  801524:	88 10                	mov    %dl,(%rax)
  801526:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80152a:	0f b6 00             	movzbl (%rax),%eax
  80152d:	84 c0                	test   %al,%al
  80152f:	74 05                	je     801536 <strncpy+0x4b>
  801531:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801536:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80153b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80153f:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801543:	72 cc                	jb     801511 <strncpy+0x26>
  801545:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801549:	c9                   	leaveq 
  80154a:	c3                   	retq   

000000000080154b <strlcpy>:
  80154b:	55                   	push   %rbp
  80154c:	48 89 e5             	mov    %rsp,%rbp
  80154f:	48 83 ec 28          	sub    $0x28,%rsp
  801553:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801557:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80155b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80155f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801563:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801567:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80156c:	74 3d                	je     8015ab <strlcpy+0x60>
  80156e:	eb 1d                	jmp    80158d <strlcpy+0x42>
  801570:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801574:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801578:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80157c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801580:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801584:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801588:	0f b6 12             	movzbl (%rdx),%edx
  80158b:	88 10                	mov    %dl,(%rax)
  80158d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801592:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801597:	74 0b                	je     8015a4 <strlcpy+0x59>
  801599:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80159d:	0f b6 00             	movzbl (%rax),%eax
  8015a0:	84 c0                	test   %al,%al
  8015a2:	75 cc                	jne    801570 <strlcpy+0x25>
  8015a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015a8:	c6 00 00             	movb   $0x0,(%rax)
  8015ab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8015af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015b3:	48 29 c2             	sub    %rax,%rdx
  8015b6:	48 89 d0             	mov    %rdx,%rax
  8015b9:	c9                   	leaveq 
  8015ba:	c3                   	retq   

00000000008015bb <strcmp>:
  8015bb:	55                   	push   %rbp
  8015bc:	48 89 e5             	mov    %rsp,%rbp
  8015bf:	48 83 ec 10          	sub    $0x10,%rsp
  8015c3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8015c7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8015cb:	eb 0a                	jmp    8015d7 <strcmp+0x1c>
  8015cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8015d2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8015d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015db:	0f b6 00             	movzbl (%rax),%eax
  8015de:	84 c0                	test   %al,%al
  8015e0:	74 12                	je     8015f4 <strcmp+0x39>
  8015e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015e6:	0f b6 10             	movzbl (%rax),%edx
  8015e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015ed:	0f b6 00             	movzbl (%rax),%eax
  8015f0:	38 c2                	cmp    %al,%dl
  8015f2:	74 d9                	je     8015cd <strcmp+0x12>
  8015f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015f8:	0f b6 00             	movzbl (%rax),%eax
  8015fb:	0f b6 d0             	movzbl %al,%edx
  8015fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801602:	0f b6 00             	movzbl (%rax),%eax
  801605:	0f b6 c0             	movzbl %al,%eax
  801608:	29 c2                	sub    %eax,%edx
  80160a:	89 d0                	mov    %edx,%eax
  80160c:	c9                   	leaveq 
  80160d:	c3                   	retq   

000000000080160e <strncmp>:
  80160e:	55                   	push   %rbp
  80160f:	48 89 e5             	mov    %rsp,%rbp
  801612:	48 83 ec 18          	sub    $0x18,%rsp
  801616:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80161a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80161e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801622:	eb 0f                	jmp    801633 <strncmp+0x25>
  801624:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801629:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80162e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801633:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801638:	74 1d                	je     801657 <strncmp+0x49>
  80163a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80163e:	0f b6 00             	movzbl (%rax),%eax
  801641:	84 c0                	test   %al,%al
  801643:	74 12                	je     801657 <strncmp+0x49>
  801645:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801649:	0f b6 10             	movzbl (%rax),%edx
  80164c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801650:	0f b6 00             	movzbl (%rax),%eax
  801653:	38 c2                	cmp    %al,%dl
  801655:	74 cd                	je     801624 <strncmp+0x16>
  801657:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80165c:	75 07                	jne    801665 <strncmp+0x57>
  80165e:	b8 00 00 00 00       	mov    $0x0,%eax
  801663:	eb 18                	jmp    80167d <strncmp+0x6f>
  801665:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801669:	0f b6 00             	movzbl (%rax),%eax
  80166c:	0f b6 d0             	movzbl %al,%edx
  80166f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801673:	0f b6 00             	movzbl (%rax),%eax
  801676:	0f b6 c0             	movzbl %al,%eax
  801679:	29 c2                	sub    %eax,%edx
  80167b:	89 d0                	mov    %edx,%eax
  80167d:	c9                   	leaveq 
  80167e:	c3                   	retq   

000000000080167f <strchr>:
  80167f:	55                   	push   %rbp
  801680:	48 89 e5             	mov    %rsp,%rbp
  801683:	48 83 ec 0c          	sub    $0xc,%rsp
  801687:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80168b:	89 f0                	mov    %esi,%eax
  80168d:	88 45 f4             	mov    %al,-0xc(%rbp)
  801690:	eb 17                	jmp    8016a9 <strchr+0x2a>
  801692:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801696:	0f b6 00             	movzbl (%rax),%eax
  801699:	3a 45 f4             	cmp    -0xc(%rbp),%al
  80169c:	75 06                	jne    8016a4 <strchr+0x25>
  80169e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016a2:	eb 15                	jmp    8016b9 <strchr+0x3a>
  8016a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016ad:	0f b6 00             	movzbl (%rax),%eax
  8016b0:	84 c0                	test   %al,%al
  8016b2:	75 de                	jne    801692 <strchr+0x13>
  8016b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b9:	c9                   	leaveq 
  8016ba:	c3                   	retq   

00000000008016bb <strfind>:
  8016bb:	55                   	push   %rbp
  8016bc:	48 89 e5             	mov    %rsp,%rbp
  8016bf:	48 83 ec 0c          	sub    $0xc,%rsp
  8016c3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016c7:	89 f0                	mov    %esi,%eax
  8016c9:	88 45 f4             	mov    %al,-0xc(%rbp)
  8016cc:	eb 13                	jmp    8016e1 <strfind+0x26>
  8016ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016d2:	0f b6 00             	movzbl (%rax),%eax
  8016d5:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8016d8:	75 02                	jne    8016dc <strfind+0x21>
  8016da:	eb 10                	jmp    8016ec <strfind+0x31>
  8016dc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016e5:	0f b6 00             	movzbl (%rax),%eax
  8016e8:	84 c0                	test   %al,%al
  8016ea:	75 e2                	jne    8016ce <strfind+0x13>
  8016ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016f0:	c9                   	leaveq 
  8016f1:	c3                   	retq   

00000000008016f2 <memset>:
  8016f2:	55                   	push   %rbp
  8016f3:	48 89 e5             	mov    %rsp,%rbp
  8016f6:	48 83 ec 18          	sub    $0x18,%rsp
  8016fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016fe:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801701:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801705:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80170a:	75 06                	jne    801712 <memset+0x20>
  80170c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801710:	eb 69                	jmp    80177b <memset+0x89>
  801712:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801716:	83 e0 03             	and    $0x3,%eax
  801719:	48 85 c0             	test   %rax,%rax
  80171c:	75 48                	jne    801766 <memset+0x74>
  80171e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801722:	83 e0 03             	and    $0x3,%eax
  801725:	48 85 c0             	test   %rax,%rax
  801728:	75 3c                	jne    801766 <memset+0x74>
  80172a:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801731:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801734:	c1 e0 18             	shl    $0x18,%eax
  801737:	89 c2                	mov    %eax,%edx
  801739:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80173c:	c1 e0 10             	shl    $0x10,%eax
  80173f:	09 c2                	or     %eax,%edx
  801741:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801744:	c1 e0 08             	shl    $0x8,%eax
  801747:	09 d0                	or     %edx,%eax
  801749:	09 45 f4             	or     %eax,-0xc(%rbp)
  80174c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801750:	48 c1 e8 02          	shr    $0x2,%rax
  801754:	48 89 c1             	mov    %rax,%rcx
  801757:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80175b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80175e:	48 89 d7             	mov    %rdx,%rdi
  801761:	fc                   	cld    
  801762:	f3 ab                	rep stos %eax,%es:(%rdi)
  801764:	eb 11                	jmp    801777 <memset+0x85>
  801766:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80176a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80176d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801771:	48 89 d7             	mov    %rdx,%rdi
  801774:	fc                   	cld    
  801775:	f3 aa                	rep stos %al,%es:(%rdi)
  801777:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80177b:	c9                   	leaveq 
  80177c:	c3                   	retq   

000000000080177d <memmove>:
  80177d:	55                   	push   %rbp
  80177e:	48 89 e5             	mov    %rsp,%rbp
  801781:	48 83 ec 28          	sub    $0x28,%rsp
  801785:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801789:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80178d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801791:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801795:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80179d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8017a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017a5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8017a9:	0f 83 88 00 00 00    	jae    801837 <memmove+0xba>
  8017af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017b7:	48 01 d0             	add    %rdx,%rax
  8017ba:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8017be:	76 77                	jbe    801837 <memmove+0xba>
  8017c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017c4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8017c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017cc:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8017d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017d4:	83 e0 03             	and    $0x3,%eax
  8017d7:	48 85 c0             	test   %rax,%rax
  8017da:	75 3b                	jne    801817 <memmove+0x9a>
  8017dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017e0:	83 e0 03             	and    $0x3,%eax
  8017e3:	48 85 c0             	test   %rax,%rax
  8017e6:	75 2f                	jne    801817 <memmove+0x9a>
  8017e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ec:	83 e0 03             	and    $0x3,%eax
  8017ef:	48 85 c0             	test   %rax,%rax
  8017f2:	75 23                	jne    801817 <memmove+0x9a>
  8017f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017f8:	48 83 e8 04          	sub    $0x4,%rax
  8017fc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801800:	48 83 ea 04          	sub    $0x4,%rdx
  801804:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801808:	48 c1 e9 02          	shr    $0x2,%rcx
  80180c:	48 89 c7             	mov    %rax,%rdi
  80180f:	48 89 d6             	mov    %rdx,%rsi
  801812:	fd                   	std    
  801813:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801815:	eb 1d                	jmp    801834 <memmove+0xb7>
  801817:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80181b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80181f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801823:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801827:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80182b:	48 89 d7             	mov    %rdx,%rdi
  80182e:	48 89 c1             	mov    %rax,%rcx
  801831:	fd                   	std    
  801832:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801834:	fc                   	cld    
  801835:	eb 57                	jmp    80188e <memmove+0x111>
  801837:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80183b:	83 e0 03             	and    $0x3,%eax
  80183e:	48 85 c0             	test   %rax,%rax
  801841:	75 36                	jne    801879 <memmove+0xfc>
  801843:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801847:	83 e0 03             	and    $0x3,%eax
  80184a:	48 85 c0             	test   %rax,%rax
  80184d:	75 2a                	jne    801879 <memmove+0xfc>
  80184f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801853:	83 e0 03             	and    $0x3,%eax
  801856:	48 85 c0             	test   %rax,%rax
  801859:	75 1e                	jne    801879 <memmove+0xfc>
  80185b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80185f:	48 c1 e8 02          	shr    $0x2,%rax
  801863:	48 89 c1             	mov    %rax,%rcx
  801866:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80186a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80186e:	48 89 c7             	mov    %rax,%rdi
  801871:	48 89 d6             	mov    %rdx,%rsi
  801874:	fc                   	cld    
  801875:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801877:	eb 15                	jmp    80188e <memmove+0x111>
  801879:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80187d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801881:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801885:	48 89 c7             	mov    %rax,%rdi
  801888:	48 89 d6             	mov    %rdx,%rsi
  80188b:	fc                   	cld    
  80188c:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80188e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801892:	c9                   	leaveq 
  801893:	c3                   	retq   

0000000000801894 <memcpy>:
  801894:	55                   	push   %rbp
  801895:	48 89 e5             	mov    %rsp,%rbp
  801898:	48 83 ec 18          	sub    $0x18,%rsp
  80189c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8018a0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018a4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8018a8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8018ac:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8018b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018b4:	48 89 ce             	mov    %rcx,%rsi
  8018b7:	48 89 c7             	mov    %rax,%rdi
  8018ba:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  8018c1:	00 00 00 
  8018c4:	ff d0                	callq  *%rax
  8018c6:	c9                   	leaveq 
  8018c7:	c3                   	retq   

00000000008018c8 <memcmp>:
  8018c8:	55                   	push   %rbp
  8018c9:	48 89 e5             	mov    %rsp,%rbp
  8018cc:	48 83 ec 28          	sub    $0x28,%rsp
  8018d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8018d4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8018d8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018e4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8018e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8018ec:	eb 36                	jmp    801924 <memcmp+0x5c>
  8018ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018f2:	0f b6 10             	movzbl (%rax),%edx
  8018f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018f9:	0f b6 00             	movzbl (%rax),%eax
  8018fc:	38 c2                	cmp    %al,%dl
  8018fe:	74 1a                	je     80191a <memcmp+0x52>
  801900:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801904:	0f b6 00             	movzbl (%rax),%eax
  801907:	0f b6 d0             	movzbl %al,%edx
  80190a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80190e:	0f b6 00             	movzbl (%rax),%eax
  801911:	0f b6 c0             	movzbl %al,%eax
  801914:	29 c2                	sub    %eax,%edx
  801916:	89 d0                	mov    %edx,%eax
  801918:	eb 20                	jmp    80193a <memcmp+0x72>
  80191a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80191f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801924:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801928:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80192c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801930:	48 85 c0             	test   %rax,%rax
  801933:	75 b9                	jne    8018ee <memcmp+0x26>
  801935:	b8 00 00 00 00       	mov    $0x0,%eax
  80193a:	c9                   	leaveq 
  80193b:	c3                   	retq   

000000000080193c <memfind>:
  80193c:	55                   	push   %rbp
  80193d:	48 89 e5             	mov    %rsp,%rbp
  801940:	48 83 ec 28          	sub    $0x28,%rsp
  801944:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801948:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80194b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80194f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801953:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801957:	48 01 d0             	add    %rdx,%rax
  80195a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80195e:	eb 15                	jmp    801975 <memfind+0x39>
  801960:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801964:	0f b6 10             	movzbl (%rax),%edx
  801967:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80196a:	38 c2                	cmp    %al,%dl
  80196c:	75 02                	jne    801970 <memfind+0x34>
  80196e:	eb 0f                	jmp    80197f <memfind+0x43>
  801970:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801975:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801979:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  80197d:	72 e1                	jb     801960 <memfind+0x24>
  80197f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801983:	c9                   	leaveq 
  801984:	c3                   	retq   

0000000000801985 <strtol>:
  801985:	55                   	push   %rbp
  801986:	48 89 e5             	mov    %rsp,%rbp
  801989:	48 83 ec 34          	sub    $0x34,%rsp
  80198d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801991:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801995:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801998:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80199f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8019a6:	00 
  8019a7:	eb 05                	jmp    8019ae <strtol+0x29>
  8019a9:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019b2:	0f b6 00             	movzbl (%rax),%eax
  8019b5:	3c 20                	cmp    $0x20,%al
  8019b7:	74 f0                	je     8019a9 <strtol+0x24>
  8019b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019bd:	0f b6 00             	movzbl (%rax),%eax
  8019c0:	3c 09                	cmp    $0x9,%al
  8019c2:	74 e5                	je     8019a9 <strtol+0x24>
  8019c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019c8:	0f b6 00             	movzbl (%rax),%eax
  8019cb:	3c 2b                	cmp    $0x2b,%al
  8019cd:	75 07                	jne    8019d6 <strtol+0x51>
  8019cf:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019d4:	eb 17                	jmp    8019ed <strtol+0x68>
  8019d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019da:	0f b6 00             	movzbl (%rax),%eax
  8019dd:	3c 2d                	cmp    $0x2d,%al
  8019df:	75 0c                	jne    8019ed <strtol+0x68>
  8019e1:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019e6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8019ed:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8019f1:	74 06                	je     8019f9 <strtol+0x74>
  8019f3:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8019f7:	75 28                	jne    801a21 <strtol+0x9c>
  8019f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019fd:	0f b6 00             	movzbl (%rax),%eax
  801a00:	3c 30                	cmp    $0x30,%al
  801a02:	75 1d                	jne    801a21 <strtol+0x9c>
  801a04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a08:	48 83 c0 01          	add    $0x1,%rax
  801a0c:	0f b6 00             	movzbl (%rax),%eax
  801a0f:	3c 78                	cmp    $0x78,%al
  801a11:	75 0e                	jne    801a21 <strtol+0x9c>
  801a13:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801a18:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801a1f:	eb 2c                	jmp    801a4d <strtol+0xc8>
  801a21:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801a25:	75 19                	jne    801a40 <strtol+0xbb>
  801a27:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a2b:	0f b6 00             	movzbl (%rax),%eax
  801a2e:	3c 30                	cmp    $0x30,%al
  801a30:	75 0e                	jne    801a40 <strtol+0xbb>
  801a32:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801a37:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801a3e:	eb 0d                	jmp    801a4d <strtol+0xc8>
  801a40:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801a44:	75 07                	jne    801a4d <strtol+0xc8>
  801a46:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801a4d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a51:	0f b6 00             	movzbl (%rax),%eax
  801a54:	3c 2f                	cmp    $0x2f,%al
  801a56:	7e 1d                	jle    801a75 <strtol+0xf0>
  801a58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a5c:	0f b6 00             	movzbl (%rax),%eax
  801a5f:	3c 39                	cmp    $0x39,%al
  801a61:	7f 12                	jg     801a75 <strtol+0xf0>
  801a63:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a67:	0f b6 00             	movzbl (%rax),%eax
  801a6a:	0f be c0             	movsbl %al,%eax
  801a6d:	83 e8 30             	sub    $0x30,%eax
  801a70:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a73:	eb 4e                	jmp    801ac3 <strtol+0x13e>
  801a75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a79:	0f b6 00             	movzbl (%rax),%eax
  801a7c:	3c 60                	cmp    $0x60,%al
  801a7e:	7e 1d                	jle    801a9d <strtol+0x118>
  801a80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a84:	0f b6 00             	movzbl (%rax),%eax
  801a87:	3c 7a                	cmp    $0x7a,%al
  801a89:	7f 12                	jg     801a9d <strtol+0x118>
  801a8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a8f:	0f b6 00             	movzbl (%rax),%eax
  801a92:	0f be c0             	movsbl %al,%eax
  801a95:	83 e8 57             	sub    $0x57,%eax
  801a98:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a9b:	eb 26                	jmp    801ac3 <strtol+0x13e>
  801a9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801aa1:	0f b6 00             	movzbl (%rax),%eax
  801aa4:	3c 40                	cmp    $0x40,%al
  801aa6:	7e 48                	jle    801af0 <strtol+0x16b>
  801aa8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801aac:	0f b6 00             	movzbl (%rax),%eax
  801aaf:	3c 5a                	cmp    $0x5a,%al
  801ab1:	7f 3d                	jg     801af0 <strtol+0x16b>
  801ab3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ab7:	0f b6 00             	movzbl (%rax),%eax
  801aba:	0f be c0             	movsbl %al,%eax
  801abd:	83 e8 37             	sub    $0x37,%eax
  801ac0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801ac3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801ac6:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801ac9:	7c 02                	jl     801acd <strtol+0x148>
  801acb:	eb 23                	jmp    801af0 <strtol+0x16b>
  801acd:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801ad2:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801ad5:	48 98                	cltq   
  801ad7:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801adc:	48 89 c2             	mov    %rax,%rdx
  801adf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801ae2:	48 98                	cltq   
  801ae4:	48 01 d0             	add    %rdx,%rax
  801ae7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801aeb:	e9 5d ff ff ff       	jmpq   801a4d <strtol+0xc8>
  801af0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801af5:	74 0b                	je     801b02 <strtol+0x17d>
  801af7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801afb:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801aff:	48 89 10             	mov    %rdx,(%rax)
  801b02:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801b06:	74 09                	je     801b11 <strtol+0x18c>
  801b08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b0c:	48 f7 d8             	neg    %rax
  801b0f:	eb 04                	jmp    801b15 <strtol+0x190>
  801b11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b15:	c9                   	leaveq 
  801b16:	c3                   	retq   

0000000000801b17 <strstr>:
  801b17:	55                   	push   %rbp
  801b18:	48 89 e5             	mov    %rsp,%rbp
  801b1b:	48 83 ec 30          	sub    $0x30,%rsp
  801b1f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801b23:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801b27:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801b2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801b2f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801b33:	0f b6 00             	movzbl (%rax),%eax
  801b36:	88 45 ff             	mov    %al,-0x1(%rbp)
  801b39:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801b3d:	75 06                	jne    801b45 <strstr+0x2e>
  801b3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b43:	eb 6b                	jmp    801bb0 <strstr+0x99>
  801b45:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801b49:	48 89 c7             	mov    %rax,%rdi
  801b4c:	48 b8 ed 13 80 00 00 	movabs $0x8013ed,%rax
  801b53:	00 00 00 
  801b56:	ff d0                	callq  *%rax
  801b58:	48 98                	cltq   
  801b5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801b5e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b62:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801b66:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801b6a:	0f b6 00             	movzbl (%rax),%eax
  801b6d:	88 45 ef             	mov    %al,-0x11(%rbp)
  801b70:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801b74:	75 07                	jne    801b7d <strstr+0x66>
  801b76:	b8 00 00 00 00       	mov    $0x0,%eax
  801b7b:	eb 33                	jmp    801bb0 <strstr+0x99>
  801b7d:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801b81:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801b84:	75 d8                	jne    801b5e <strstr+0x47>
  801b86:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b8a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801b8e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b92:	48 89 ce             	mov    %rcx,%rsi
  801b95:	48 89 c7             	mov    %rax,%rdi
  801b98:	48 b8 0e 16 80 00 00 	movabs $0x80160e,%rax
  801b9f:	00 00 00 
  801ba2:	ff d0                	callq  *%rax
  801ba4:	85 c0                	test   %eax,%eax
  801ba6:	75 b6                	jne    801b5e <strstr+0x47>
  801ba8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801bac:	48 83 e8 01          	sub    $0x1,%rax
  801bb0:	c9                   	leaveq 
  801bb1:	c3                   	retq   

0000000000801bb2 <syscall>:
  801bb2:	55                   	push   %rbp
  801bb3:	48 89 e5             	mov    %rsp,%rbp
  801bb6:	53                   	push   %rbx
  801bb7:	48 83 ec 48          	sub    $0x48,%rsp
  801bbb:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801bbe:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801bc1:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801bc5:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801bc9:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801bcd:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801bd1:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801bd4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801bd8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801bdc:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801be0:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801be4:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801be8:	4c 89 c3             	mov    %r8,%rbx
  801beb:	cd 30                	int    $0x30
  801bed:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801bf1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801bf5:	74 3e                	je     801c35 <syscall+0x83>
  801bf7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801bfc:	7e 37                	jle    801c35 <syscall+0x83>
  801bfe:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801c02:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801c05:	49 89 d0             	mov    %rdx,%r8
  801c08:	89 c1                	mov    %eax,%ecx
  801c0a:	48 ba db 4a 80 00 00 	movabs $0x804adb,%rdx
  801c11:	00 00 00 
  801c14:	be 24 00 00 00       	mov    $0x24,%esi
  801c19:	48 bf f8 4a 80 00 00 	movabs $0x804af8,%rdi
  801c20:	00 00 00 
  801c23:	b8 00 00 00 00       	mov    $0x0,%eax
  801c28:	49 b9 11 05 80 00 00 	movabs $0x800511,%r9
  801c2f:	00 00 00 
  801c32:	41 ff d1             	callq  *%r9
  801c35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c39:	48 83 c4 48          	add    $0x48,%rsp
  801c3d:	5b                   	pop    %rbx
  801c3e:	5d                   	pop    %rbp
  801c3f:	c3                   	retq   

0000000000801c40 <sys_cputs>:
  801c40:	55                   	push   %rbp
  801c41:	48 89 e5             	mov    %rsp,%rbp
  801c44:	48 83 ec 20          	sub    $0x20,%rsp
  801c48:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c4c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c54:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c58:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c5f:	00 
  801c60:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c66:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c6c:	48 89 d1             	mov    %rdx,%rcx
  801c6f:	48 89 c2             	mov    %rax,%rdx
  801c72:	be 00 00 00 00       	mov    $0x0,%esi
  801c77:	bf 00 00 00 00       	mov    $0x0,%edi
  801c7c:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801c83:	00 00 00 
  801c86:	ff d0                	callq  *%rax
  801c88:	c9                   	leaveq 
  801c89:	c3                   	retq   

0000000000801c8a <sys_cgetc>:
  801c8a:	55                   	push   %rbp
  801c8b:	48 89 e5             	mov    %rsp,%rbp
  801c8e:	48 83 ec 10          	sub    $0x10,%rsp
  801c92:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c99:	00 
  801c9a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ca0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ca6:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cab:	ba 00 00 00 00       	mov    $0x0,%edx
  801cb0:	be 00 00 00 00       	mov    $0x0,%esi
  801cb5:	bf 01 00 00 00       	mov    $0x1,%edi
  801cba:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801cc1:	00 00 00 
  801cc4:	ff d0                	callq  *%rax
  801cc6:	c9                   	leaveq 
  801cc7:	c3                   	retq   

0000000000801cc8 <sys_env_destroy>:
  801cc8:	55                   	push   %rbp
  801cc9:	48 89 e5             	mov    %rsp,%rbp
  801ccc:	48 83 ec 10          	sub    $0x10,%rsp
  801cd0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cd3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cd6:	48 98                	cltq   
  801cd8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cdf:	00 
  801ce0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ce6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cec:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cf1:	48 89 c2             	mov    %rax,%rdx
  801cf4:	be 01 00 00 00       	mov    $0x1,%esi
  801cf9:	bf 03 00 00 00       	mov    $0x3,%edi
  801cfe:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801d05:	00 00 00 
  801d08:	ff d0                	callq  *%rax
  801d0a:	c9                   	leaveq 
  801d0b:	c3                   	retq   

0000000000801d0c <sys_getenvid>:
  801d0c:	55                   	push   %rbp
  801d0d:	48 89 e5             	mov    %rsp,%rbp
  801d10:	48 83 ec 10          	sub    $0x10,%rsp
  801d14:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d1b:	00 
  801d1c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d22:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d28:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d2d:	ba 00 00 00 00       	mov    $0x0,%edx
  801d32:	be 00 00 00 00       	mov    $0x0,%esi
  801d37:	bf 02 00 00 00       	mov    $0x2,%edi
  801d3c:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801d43:	00 00 00 
  801d46:	ff d0                	callq  *%rax
  801d48:	c9                   	leaveq 
  801d49:	c3                   	retq   

0000000000801d4a <sys_yield>:
  801d4a:	55                   	push   %rbp
  801d4b:	48 89 e5             	mov    %rsp,%rbp
  801d4e:	48 83 ec 10          	sub    $0x10,%rsp
  801d52:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d59:	00 
  801d5a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d60:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d66:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d6b:	ba 00 00 00 00       	mov    $0x0,%edx
  801d70:	be 00 00 00 00       	mov    $0x0,%esi
  801d75:	bf 0b 00 00 00       	mov    $0xb,%edi
  801d7a:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801d81:	00 00 00 
  801d84:	ff d0                	callq  *%rax
  801d86:	c9                   	leaveq 
  801d87:	c3                   	retq   

0000000000801d88 <sys_page_alloc>:
  801d88:	55                   	push   %rbp
  801d89:	48 89 e5             	mov    %rsp,%rbp
  801d8c:	48 83 ec 20          	sub    $0x20,%rsp
  801d90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d93:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d97:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d9a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d9d:	48 63 c8             	movslq %eax,%rcx
  801da0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801da4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801da7:	48 98                	cltq   
  801da9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801db0:	00 
  801db1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801db7:	49 89 c8             	mov    %rcx,%r8
  801dba:	48 89 d1             	mov    %rdx,%rcx
  801dbd:	48 89 c2             	mov    %rax,%rdx
  801dc0:	be 01 00 00 00       	mov    $0x1,%esi
  801dc5:	bf 04 00 00 00       	mov    $0x4,%edi
  801dca:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801dd1:	00 00 00 
  801dd4:	ff d0                	callq  *%rax
  801dd6:	c9                   	leaveq 
  801dd7:	c3                   	retq   

0000000000801dd8 <sys_page_map>:
  801dd8:	55                   	push   %rbp
  801dd9:	48 89 e5             	mov    %rsp,%rbp
  801ddc:	48 83 ec 30          	sub    $0x30,%rsp
  801de0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801de3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801de7:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801dea:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801dee:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801df2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801df5:	48 63 c8             	movslq %eax,%rcx
  801df8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801dfc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801dff:	48 63 f0             	movslq %eax,%rsi
  801e02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e09:	48 98                	cltq   
  801e0b:	48 89 0c 24          	mov    %rcx,(%rsp)
  801e0f:	49 89 f9             	mov    %rdi,%r9
  801e12:	49 89 f0             	mov    %rsi,%r8
  801e15:	48 89 d1             	mov    %rdx,%rcx
  801e18:	48 89 c2             	mov    %rax,%rdx
  801e1b:	be 01 00 00 00       	mov    $0x1,%esi
  801e20:	bf 05 00 00 00       	mov    $0x5,%edi
  801e25:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801e2c:	00 00 00 
  801e2f:	ff d0                	callq  *%rax
  801e31:	c9                   	leaveq 
  801e32:	c3                   	retq   

0000000000801e33 <sys_page_unmap>:
  801e33:	55                   	push   %rbp
  801e34:	48 89 e5             	mov    %rsp,%rbp
  801e37:	48 83 ec 20          	sub    $0x20,%rsp
  801e3b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e3e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e42:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e46:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e49:	48 98                	cltq   
  801e4b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e52:	00 
  801e53:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e59:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e5f:	48 89 d1             	mov    %rdx,%rcx
  801e62:	48 89 c2             	mov    %rax,%rdx
  801e65:	be 01 00 00 00       	mov    $0x1,%esi
  801e6a:	bf 06 00 00 00       	mov    $0x6,%edi
  801e6f:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801e76:	00 00 00 
  801e79:	ff d0                	callq  *%rax
  801e7b:	c9                   	leaveq 
  801e7c:	c3                   	retq   

0000000000801e7d <sys_env_set_status>:
  801e7d:	55                   	push   %rbp
  801e7e:	48 89 e5             	mov    %rsp,%rbp
  801e81:	48 83 ec 10          	sub    $0x10,%rsp
  801e85:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e88:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801e8b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e8e:	48 63 d0             	movslq %eax,%rdx
  801e91:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e94:	48 98                	cltq   
  801e96:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e9d:	00 
  801e9e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ea4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801eaa:	48 89 d1             	mov    %rdx,%rcx
  801ead:	48 89 c2             	mov    %rax,%rdx
  801eb0:	be 01 00 00 00       	mov    $0x1,%esi
  801eb5:	bf 08 00 00 00       	mov    $0x8,%edi
  801eba:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801ec1:	00 00 00 
  801ec4:	ff d0                	callq  *%rax
  801ec6:	c9                   	leaveq 
  801ec7:	c3                   	retq   

0000000000801ec8 <sys_env_set_trapframe>:
  801ec8:	55                   	push   %rbp
  801ec9:	48 89 e5             	mov    %rsp,%rbp
  801ecc:	48 83 ec 20          	sub    $0x20,%rsp
  801ed0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ed3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ed7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801edb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ede:	48 98                	cltq   
  801ee0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ee7:	00 
  801ee8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801eee:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ef4:	48 89 d1             	mov    %rdx,%rcx
  801ef7:	48 89 c2             	mov    %rax,%rdx
  801efa:	be 01 00 00 00       	mov    $0x1,%esi
  801eff:	bf 09 00 00 00       	mov    $0x9,%edi
  801f04:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801f0b:	00 00 00 
  801f0e:	ff d0                	callq  *%rax
  801f10:	c9                   	leaveq 
  801f11:	c3                   	retq   

0000000000801f12 <sys_env_set_pgfault_upcall>:
  801f12:	55                   	push   %rbp
  801f13:	48 89 e5             	mov    %rsp,%rbp
  801f16:	48 83 ec 20          	sub    $0x20,%rsp
  801f1a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f1d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f21:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f25:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f28:	48 98                	cltq   
  801f2a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f31:	00 
  801f32:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f38:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f3e:	48 89 d1             	mov    %rdx,%rcx
  801f41:	48 89 c2             	mov    %rax,%rdx
  801f44:	be 01 00 00 00       	mov    $0x1,%esi
  801f49:	bf 0a 00 00 00       	mov    $0xa,%edi
  801f4e:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801f55:	00 00 00 
  801f58:	ff d0                	callq  *%rax
  801f5a:	c9                   	leaveq 
  801f5b:	c3                   	retq   

0000000000801f5c <sys_ipc_try_send>:
  801f5c:	55                   	push   %rbp
  801f5d:	48 89 e5             	mov    %rsp,%rbp
  801f60:	48 83 ec 20          	sub    $0x20,%rsp
  801f64:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f67:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f6b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801f6f:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801f72:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f75:	48 63 f0             	movslq %eax,%rsi
  801f78:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801f7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f7f:	48 98                	cltq   
  801f81:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f85:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f8c:	00 
  801f8d:	49 89 f1             	mov    %rsi,%r9
  801f90:	49 89 c8             	mov    %rcx,%r8
  801f93:	48 89 d1             	mov    %rdx,%rcx
  801f96:	48 89 c2             	mov    %rax,%rdx
  801f99:	be 00 00 00 00       	mov    $0x0,%esi
  801f9e:	bf 0c 00 00 00       	mov    $0xc,%edi
  801fa3:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801faa:	00 00 00 
  801fad:	ff d0                	callq  *%rax
  801faf:	c9                   	leaveq 
  801fb0:	c3                   	retq   

0000000000801fb1 <sys_ipc_recv>:
  801fb1:	55                   	push   %rbp
  801fb2:	48 89 e5             	mov    %rsp,%rbp
  801fb5:	48 83 ec 10          	sub    $0x10,%rsp
  801fb9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801fbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801fc1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fc8:	00 
  801fc9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fcf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801fd5:	b9 00 00 00 00       	mov    $0x0,%ecx
  801fda:	48 89 c2             	mov    %rax,%rdx
  801fdd:	be 01 00 00 00       	mov    $0x1,%esi
  801fe2:	bf 0d 00 00 00       	mov    $0xd,%edi
  801fe7:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  801fee:	00 00 00 
  801ff1:	ff d0                	callq  *%rax
  801ff3:	c9                   	leaveq 
  801ff4:	c3                   	retq   

0000000000801ff5 <sys_time_msec>:
  801ff5:	55                   	push   %rbp
  801ff6:	48 89 e5             	mov    %rsp,%rbp
  801ff9:	48 83 ec 10          	sub    $0x10,%rsp
  801ffd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802004:	00 
  802005:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80200b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802011:	b9 00 00 00 00       	mov    $0x0,%ecx
  802016:	ba 00 00 00 00       	mov    $0x0,%edx
  80201b:	be 00 00 00 00       	mov    $0x0,%esi
  802020:	bf 0e 00 00 00       	mov    $0xe,%edi
  802025:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  80202c:	00 00 00 
  80202f:	ff d0                	callq  *%rax
  802031:	c9                   	leaveq 
  802032:	c3                   	retq   

0000000000802033 <sys_net_transmit>:
  802033:	55                   	push   %rbp
  802034:	48 89 e5             	mov    %rsp,%rbp
  802037:	48 83 ec 20          	sub    $0x20,%rsp
  80203b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80203f:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802042:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802045:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802049:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802050:	00 
  802051:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802057:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80205d:	48 89 d1             	mov    %rdx,%rcx
  802060:	48 89 c2             	mov    %rax,%rdx
  802063:	be 00 00 00 00       	mov    $0x0,%esi
  802068:	bf 0f 00 00 00       	mov    $0xf,%edi
  80206d:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  802074:	00 00 00 
  802077:	ff d0                	callq  *%rax
  802079:	c9                   	leaveq 
  80207a:	c3                   	retq   

000000000080207b <sys_net_receive>:
  80207b:	55                   	push   %rbp
  80207c:	48 89 e5             	mov    %rsp,%rbp
  80207f:	48 83 ec 20          	sub    $0x20,%rsp
  802083:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802087:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80208a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80208d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802091:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802098:	00 
  802099:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80209f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020a5:	48 89 d1             	mov    %rdx,%rcx
  8020a8:	48 89 c2             	mov    %rax,%rdx
  8020ab:	be 00 00 00 00       	mov    $0x0,%esi
  8020b0:	bf 10 00 00 00       	mov    $0x10,%edi
  8020b5:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  8020bc:	00 00 00 
  8020bf:	ff d0                	callq  *%rax
  8020c1:	c9                   	leaveq 
  8020c2:	c3                   	retq   

00000000008020c3 <sys_ept_map>:
  8020c3:	55                   	push   %rbp
  8020c4:	48 89 e5             	mov    %rsp,%rbp
  8020c7:	48 83 ec 30          	sub    $0x30,%rsp
  8020cb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8020ce:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8020d2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8020d5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8020d9:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8020dd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8020e0:	48 63 c8             	movslq %eax,%rcx
  8020e3:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8020e7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020ea:	48 63 f0             	movslq %eax,%rsi
  8020ed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8020f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020f4:	48 98                	cltq   
  8020f6:	48 89 0c 24          	mov    %rcx,(%rsp)
  8020fa:	49 89 f9             	mov    %rdi,%r9
  8020fd:	49 89 f0             	mov    %rsi,%r8
  802100:	48 89 d1             	mov    %rdx,%rcx
  802103:	48 89 c2             	mov    %rax,%rdx
  802106:	be 00 00 00 00       	mov    $0x0,%esi
  80210b:	bf 11 00 00 00       	mov    $0x11,%edi
  802110:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  802117:	00 00 00 
  80211a:	ff d0                	callq  *%rax
  80211c:	c9                   	leaveq 
  80211d:	c3                   	retq   

000000000080211e <sys_env_mkguest>:
  80211e:	55                   	push   %rbp
  80211f:	48 89 e5             	mov    %rsp,%rbp
  802122:	48 83 ec 20          	sub    $0x20,%rsp
  802126:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80212a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80212e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802132:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802136:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80213d:	00 
  80213e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802144:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80214a:	48 89 d1             	mov    %rdx,%rcx
  80214d:	48 89 c2             	mov    %rax,%rdx
  802150:	be 00 00 00 00       	mov    $0x0,%esi
  802155:	bf 12 00 00 00       	mov    $0x12,%edi
  80215a:	48 b8 b2 1b 80 00 00 	movabs $0x801bb2,%rax
  802161:	00 00 00 
  802164:	ff d0                	callq  *%rax
  802166:	c9                   	leaveq 
  802167:	c3                   	retq   

0000000000802168 <fd2num>:
  802168:	55                   	push   %rbp
  802169:	48 89 e5             	mov    %rsp,%rbp
  80216c:	48 83 ec 08          	sub    $0x8,%rsp
  802170:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802174:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802178:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  80217f:	ff ff ff 
  802182:	48 01 d0             	add    %rdx,%rax
  802185:	48 c1 e8 0c          	shr    $0xc,%rax
  802189:	c9                   	leaveq 
  80218a:	c3                   	retq   

000000000080218b <fd2data>:
  80218b:	55                   	push   %rbp
  80218c:	48 89 e5             	mov    %rsp,%rbp
  80218f:	48 83 ec 08          	sub    $0x8,%rsp
  802193:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802197:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80219b:	48 89 c7             	mov    %rax,%rdi
  80219e:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  8021a5:	00 00 00 
  8021a8:	ff d0                	callq  *%rax
  8021aa:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  8021b0:	48 c1 e0 0c          	shl    $0xc,%rax
  8021b4:	c9                   	leaveq 
  8021b5:	c3                   	retq   

00000000008021b6 <fd_alloc>:
  8021b6:	55                   	push   %rbp
  8021b7:	48 89 e5             	mov    %rsp,%rbp
  8021ba:	48 83 ec 18          	sub    $0x18,%rsp
  8021be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8021c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8021c9:	eb 6b                	jmp    802236 <fd_alloc+0x80>
  8021cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021ce:	48 98                	cltq   
  8021d0:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8021d6:	48 c1 e0 0c          	shl    $0xc,%rax
  8021da:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8021de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8021e2:	48 c1 e8 15          	shr    $0x15,%rax
  8021e6:	48 89 c2             	mov    %rax,%rdx
  8021e9:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8021f0:	01 00 00 
  8021f3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021f7:	83 e0 01             	and    $0x1,%eax
  8021fa:	48 85 c0             	test   %rax,%rax
  8021fd:	74 21                	je     802220 <fd_alloc+0x6a>
  8021ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802203:	48 c1 e8 0c          	shr    $0xc,%rax
  802207:	48 89 c2             	mov    %rax,%rdx
  80220a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802211:	01 00 00 
  802214:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802218:	83 e0 01             	and    $0x1,%eax
  80221b:	48 85 c0             	test   %rax,%rax
  80221e:	75 12                	jne    802232 <fd_alloc+0x7c>
  802220:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802224:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802228:	48 89 10             	mov    %rdx,(%rax)
  80222b:	b8 00 00 00 00       	mov    $0x0,%eax
  802230:	eb 1a                	jmp    80224c <fd_alloc+0x96>
  802232:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802236:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80223a:	7e 8f                	jle    8021cb <fd_alloc+0x15>
  80223c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802240:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802247:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  80224c:	c9                   	leaveq 
  80224d:	c3                   	retq   

000000000080224e <fd_lookup>:
  80224e:	55                   	push   %rbp
  80224f:	48 89 e5             	mov    %rsp,%rbp
  802252:	48 83 ec 20          	sub    $0x20,%rsp
  802256:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802259:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80225d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802261:	78 06                	js     802269 <fd_lookup+0x1b>
  802263:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802267:	7e 07                	jle    802270 <fd_lookup+0x22>
  802269:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80226e:	eb 6c                	jmp    8022dc <fd_lookup+0x8e>
  802270:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802273:	48 98                	cltq   
  802275:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80227b:	48 c1 e0 0c          	shl    $0xc,%rax
  80227f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802283:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802287:	48 c1 e8 15          	shr    $0x15,%rax
  80228b:	48 89 c2             	mov    %rax,%rdx
  80228e:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802295:	01 00 00 
  802298:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80229c:	83 e0 01             	and    $0x1,%eax
  80229f:	48 85 c0             	test   %rax,%rax
  8022a2:	74 21                	je     8022c5 <fd_lookup+0x77>
  8022a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8022a8:	48 c1 e8 0c          	shr    $0xc,%rax
  8022ac:	48 89 c2             	mov    %rax,%rdx
  8022af:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8022b6:	01 00 00 
  8022b9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8022bd:	83 e0 01             	and    $0x1,%eax
  8022c0:	48 85 c0             	test   %rax,%rax
  8022c3:	75 07                	jne    8022cc <fd_lookup+0x7e>
  8022c5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8022ca:	eb 10                	jmp    8022dc <fd_lookup+0x8e>
  8022cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022d0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8022d4:	48 89 10             	mov    %rdx,(%rax)
  8022d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8022dc:	c9                   	leaveq 
  8022dd:	c3                   	retq   

00000000008022de <fd_close>:
  8022de:	55                   	push   %rbp
  8022df:	48 89 e5             	mov    %rsp,%rbp
  8022e2:	48 83 ec 30          	sub    $0x30,%rsp
  8022e6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8022ea:	89 f0                	mov    %esi,%eax
  8022ec:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8022ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8022f3:	48 89 c7             	mov    %rax,%rdi
  8022f6:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  8022fd:	00 00 00 
  802300:	ff d0                	callq  *%rax
  802302:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802306:	48 89 d6             	mov    %rdx,%rsi
  802309:	89 c7                	mov    %eax,%edi
  80230b:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  802312:	00 00 00 
  802315:	ff d0                	callq  *%rax
  802317:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80231a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80231e:	78 0a                	js     80232a <fd_close+0x4c>
  802320:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802324:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  802328:	74 12                	je     80233c <fd_close+0x5e>
  80232a:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  80232e:	74 05                	je     802335 <fd_close+0x57>
  802330:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802333:	eb 05                	jmp    80233a <fd_close+0x5c>
  802335:	b8 00 00 00 00       	mov    $0x0,%eax
  80233a:	eb 69                	jmp    8023a5 <fd_close+0xc7>
  80233c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802340:	8b 00                	mov    (%rax),%eax
  802342:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802346:	48 89 d6             	mov    %rdx,%rsi
  802349:	89 c7                	mov    %eax,%edi
  80234b:	48 b8 a7 23 80 00 00 	movabs $0x8023a7,%rax
  802352:	00 00 00 
  802355:	ff d0                	callq  *%rax
  802357:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80235a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80235e:	78 2a                	js     80238a <fd_close+0xac>
  802360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802364:	48 8b 40 20          	mov    0x20(%rax),%rax
  802368:	48 85 c0             	test   %rax,%rax
  80236b:	74 16                	je     802383 <fd_close+0xa5>
  80236d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802371:	48 8b 40 20          	mov    0x20(%rax),%rax
  802375:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802379:	48 89 d7             	mov    %rdx,%rdi
  80237c:	ff d0                	callq  *%rax
  80237e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802381:	eb 07                	jmp    80238a <fd_close+0xac>
  802383:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80238a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80238e:	48 89 c6             	mov    %rax,%rsi
  802391:	bf 00 00 00 00       	mov    $0x0,%edi
  802396:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  80239d:	00 00 00 
  8023a0:	ff d0                	callq  *%rax
  8023a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023a5:	c9                   	leaveq 
  8023a6:	c3                   	retq   

00000000008023a7 <dev_lookup>:
  8023a7:	55                   	push   %rbp
  8023a8:	48 89 e5             	mov    %rsp,%rbp
  8023ab:	48 83 ec 20          	sub    $0x20,%rsp
  8023af:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023b2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8023b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8023bd:	eb 41                	jmp    802400 <dev_lookup+0x59>
  8023bf:	48 b8 40 60 80 00 00 	movabs $0x806040,%rax
  8023c6:	00 00 00 
  8023c9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8023cc:	48 63 d2             	movslq %edx,%rdx
  8023cf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023d3:	8b 00                	mov    (%rax),%eax
  8023d5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8023d8:	75 22                	jne    8023fc <dev_lookup+0x55>
  8023da:	48 b8 40 60 80 00 00 	movabs $0x806040,%rax
  8023e1:	00 00 00 
  8023e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8023e7:	48 63 d2             	movslq %edx,%rdx
  8023ea:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8023ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8023f2:	48 89 10             	mov    %rdx,(%rax)
  8023f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8023fa:	eb 60                	jmp    80245c <dev_lookup+0xb5>
  8023fc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802400:	48 b8 40 60 80 00 00 	movabs $0x806040,%rax
  802407:	00 00 00 
  80240a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80240d:	48 63 d2             	movslq %edx,%rdx
  802410:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802414:	48 85 c0             	test   %rax,%rax
  802417:	75 a6                	jne    8023bf <dev_lookup+0x18>
  802419:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  802420:	00 00 00 
  802423:	48 8b 00             	mov    (%rax),%rax
  802426:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80242c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80242f:	89 c6                	mov    %eax,%esi
  802431:	48 bf 10 4b 80 00 00 	movabs $0x804b10,%rdi
  802438:	00 00 00 
  80243b:	b8 00 00 00 00       	mov    $0x0,%eax
  802440:	48 b9 4a 07 80 00 00 	movabs $0x80074a,%rcx
  802447:	00 00 00 
  80244a:	ff d1                	callq  *%rcx
  80244c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802450:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802457:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80245c:	c9                   	leaveq 
  80245d:	c3                   	retq   

000000000080245e <close>:
  80245e:	55                   	push   %rbp
  80245f:	48 89 e5             	mov    %rsp,%rbp
  802462:	48 83 ec 20          	sub    $0x20,%rsp
  802466:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802469:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80246d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802470:	48 89 d6             	mov    %rdx,%rsi
  802473:	89 c7                	mov    %eax,%edi
  802475:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  80247c:	00 00 00 
  80247f:	ff d0                	callq  *%rax
  802481:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802484:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802488:	79 05                	jns    80248f <close+0x31>
  80248a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80248d:	eb 18                	jmp    8024a7 <close+0x49>
  80248f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802493:	be 01 00 00 00       	mov    $0x1,%esi
  802498:	48 89 c7             	mov    %rax,%rdi
  80249b:	48 b8 de 22 80 00 00 	movabs $0x8022de,%rax
  8024a2:	00 00 00 
  8024a5:	ff d0                	callq  *%rax
  8024a7:	c9                   	leaveq 
  8024a8:	c3                   	retq   

00000000008024a9 <close_all>:
  8024a9:	55                   	push   %rbp
  8024aa:	48 89 e5             	mov    %rsp,%rbp
  8024ad:	48 83 ec 10          	sub    $0x10,%rsp
  8024b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8024b8:	eb 15                	jmp    8024cf <close_all+0x26>
  8024ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024bd:	89 c7                	mov    %eax,%edi
  8024bf:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  8024c6:	00 00 00 
  8024c9:	ff d0                	callq  *%rax
  8024cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8024cf:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8024d3:	7e e5                	jle    8024ba <close_all+0x11>
  8024d5:	c9                   	leaveq 
  8024d6:	c3                   	retq   

00000000008024d7 <dup>:
  8024d7:	55                   	push   %rbp
  8024d8:	48 89 e5             	mov    %rsp,%rbp
  8024db:	48 83 ec 40          	sub    $0x40,%rsp
  8024df:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8024e2:	89 75 c8             	mov    %esi,-0x38(%rbp)
  8024e5:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8024e9:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8024ec:	48 89 d6             	mov    %rdx,%rsi
  8024ef:	89 c7                	mov    %eax,%edi
  8024f1:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8024f8:	00 00 00 
  8024fb:	ff d0                	callq  *%rax
  8024fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802500:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802504:	79 08                	jns    80250e <dup+0x37>
  802506:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802509:	e9 70 01 00 00       	jmpq   80267e <dup+0x1a7>
  80250e:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802511:	89 c7                	mov    %eax,%edi
  802513:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  80251a:	00 00 00 
  80251d:	ff d0                	callq  *%rax
  80251f:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802522:	48 98                	cltq   
  802524:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80252a:	48 c1 e0 0c          	shl    $0xc,%rax
  80252e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802532:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802536:	48 89 c7             	mov    %rax,%rdi
  802539:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  802540:	00 00 00 
  802543:	ff d0                	callq  *%rax
  802545:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802549:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80254d:	48 89 c7             	mov    %rax,%rdi
  802550:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  802557:	00 00 00 
  80255a:	ff d0                	callq  *%rax
  80255c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802560:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802564:	48 c1 e8 15          	shr    $0x15,%rax
  802568:	48 89 c2             	mov    %rax,%rdx
  80256b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802572:	01 00 00 
  802575:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802579:	83 e0 01             	and    $0x1,%eax
  80257c:	48 85 c0             	test   %rax,%rax
  80257f:	74 73                	je     8025f4 <dup+0x11d>
  802581:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802585:	48 c1 e8 0c          	shr    $0xc,%rax
  802589:	48 89 c2             	mov    %rax,%rdx
  80258c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802593:	01 00 00 
  802596:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80259a:	83 e0 01             	and    $0x1,%eax
  80259d:	48 85 c0             	test   %rax,%rax
  8025a0:	74 52                	je     8025f4 <dup+0x11d>
  8025a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025a6:	48 c1 e8 0c          	shr    $0xc,%rax
  8025aa:	48 89 c2             	mov    %rax,%rdx
  8025ad:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8025b4:	01 00 00 
  8025b7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8025bb:	25 07 0e 00 00       	and    $0xe07,%eax
  8025c0:	89 c1                	mov    %eax,%ecx
  8025c2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8025c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025ca:	41 89 c8             	mov    %ecx,%r8d
  8025cd:	48 89 d1             	mov    %rdx,%rcx
  8025d0:	ba 00 00 00 00       	mov    $0x0,%edx
  8025d5:	48 89 c6             	mov    %rax,%rsi
  8025d8:	bf 00 00 00 00       	mov    $0x0,%edi
  8025dd:	48 b8 d8 1d 80 00 00 	movabs $0x801dd8,%rax
  8025e4:	00 00 00 
  8025e7:	ff d0                	callq  *%rax
  8025e9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025f0:	79 02                	jns    8025f4 <dup+0x11d>
  8025f2:	eb 57                	jmp    80264b <dup+0x174>
  8025f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025f8:	48 c1 e8 0c          	shr    $0xc,%rax
  8025fc:	48 89 c2             	mov    %rax,%rdx
  8025ff:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802606:	01 00 00 
  802609:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80260d:	25 07 0e 00 00       	and    $0xe07,%eax
  802612:	89 c1                	mov    %eax,%ecx
  802614:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802618:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80261c:	41 89 c8             	mov    %ecx,%r8d
  80261f:	48 89 d1             	mov    %rdx,%rcx
  802622:	ba 00 00 00 00       	mov    $0x0,%edx
  802627:	48 89 c6             	mov    %rax,%rsi
  80262a:	bf 00 00 00 00       	mov    $0x0,%edi
  80262f:	48 b8 d8 1d 80 00 00 	movabs $0x801dd8,%rax
  802636:	00 00 00 
  802639:	ff d0                	callq  *%rax
  80263b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80263e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802642:	79 02                	jns    802646 <dup+0x16f>
  802644:	eb 05                	jmp    80264b <dup+0x174>
  802646:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802649:	eb 33                	jmp    80267e <dup+0x1a7>
  80264b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80264f:	48 89 c6             	mov    %rax,%rsi
  802652:	bf 00 00 00 00       	mov    $0x0,%edi
  802657:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  80265e:	00 00 00 
  802661:	ff d0                	callq  *%rax
  802663:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802667:	48 89 c6             	mov    %rax,%rsi
  80266a:	bf 00 00 00 00       	mov    $0x0,%edi
  80266f:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  802676:	00 00 00 
  802679:	ff d0                	callq  *%rax
  80267b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80267e:	c9                   	leaveq 
  80267f:	c3                   	retq   

0000000000802680 <read>:
  802680:	55                   	push   %rbp
  802681:	48 89 e5             	mov    %rsp,%rbp
  802684:	48 83 ec 40          	sub    $0x40,%rsp
  802688:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80268b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80268f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802693:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802697:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80269a:	48 89 d6             	mov    %rdx,%rsi
  80269d:	89 c7                	mov    %eax,%edi
  80269f:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8026a6:	00 00 00 
  8026a9:	ff d0                	callq  *%rax
  8026ab:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026b2:	78 24                	js     8026d8 <read+0x58>
  8026b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026b8:	8b 00                	mov    (%rax),%eax
  8026ba:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8026be:	48 89 d6             	mov    %rdx,%rsi
  8026c1:	89 c7                	mov    %eax,%edi
  8026c3:	48 b8 a7 23 80 00 00 	movabs $0x8023a7,%rax
  8026ca:	00 00 00 
  8026cd:	ff d0                	callq  *%rax
  8026cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026d6:	79 05                	jns    8026dd <read+0x5d>
  8026d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026db:	eb 76                	jmp    802753 <read+0xd3>
  8026dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026e1:	8b 40 08             	mov    0x8(%rax),%eax
  8026e4:	83 e0 03             	and    $0x3,%eax
  8026e7:	83 f8 01             	cmp    $0x1,%eax
  8026ea:	75 3a                	jne    802726 <read+0xa6>
  8026ec:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  8026f3:	00 00 00 
  8026f6:	48 8b 00             	mov    (%rax),%rax
  8026f9:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8026ff:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802702:	89 c6                	mov    %eax,%esi
  802704:	48 bf 2f 4b 80 00 00 	movabs $0x804b2f,%rdi
  80270b:	00 00 00 
  80270e:	b8 00 00 00 00       	mov    $0x0,%eax
  802713:	48 b9 4a 07 80 00 00 	movabs $0x80074a,%rcx
  80271a:	00 00 00 
  80271d:	ff d1                	callq  *%rcx
  80271f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802724:	eb 2d                	jmp    802753 <read+0xd3>
  802726:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80272a:	48 8b 40 10          	mov    0x10(%rax),%rax
  80272e:	48 85 c0             	test   %rax,%rax
  802731:	75 07                	jne    80273a <read+0xba>
  802733:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802738:	eb 19                	jmp    802753 <read+0xd3>
  80273a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80273e:	48 8b 40 10          	mov    0x10(%rax),%rax
  802742:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802746:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80274a:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  80274e:	48 89 cf             	mov    %rcx,%rdi
  802751:	ff d0                	callq  *%rax
  802753:	c9                   	leaveq 
  802754:	c3                   	retq   

0000000000802755 <readn>:
  802755:	55                   	push   %rbp
  802756:	48 89 e5             	mov    %rsp,%rbp
  802759:	48 83 ec 30          	sub    $0x30,%rsp
  80275d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802760:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802764:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802768:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80276f:	eb 49                	jmp    8027ba <readn+0x65>
  802771:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802774:	48 98                	cltq   
  802776:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80277a:	48 29 c2             	sub    %rax,%rdx
  80277d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802780:	48 63 c8             	movslq %eax,%rcx
  802783:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802787:	48 01 c1             	add    %rax,%rcx
  80278a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80278d:	48 89 ce             	mov    %rcx,%rsi
  802790:	89 c7                	mov    %eax,%edi
  802792:	48 b8 80 26 80 00 00 	movabs $0x802680,%rax
  802799:	00 00 00 
  80279c:	ff d0                	callq  *%rax
  80279e:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8027a1:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8027a5:	79 05                	jns    8027ac <readn+0x57>
  8027a7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8027aa:	eb 1c                	jmp    8027c8 <readn+0x73>
  8027ac:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8027b0:	75 02                	jne    8027b4 <readn+0x5f>
  8027b2:	eb 11                	jmp    8027c5 <readn+0x70>
  8027b4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8027b7:	01 45 fc             	add    %eax,-0x4(%rbp)
  8027ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027bd:	48 98                	cltq   
  8027bf:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8027c3:	72 ac                	jb     802771 <readn+0x1c>
  8027c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027c8:	c9                   	leaveq 
  8027c9:	c3                   	retq   

00000000008027ca <write>:
  8027ca:	55                   	push   %rbp
  8027cb:	48 89 e5             	mov    %rsp,%rbp
  8027ce:	48 83 ec 40          	sub    $0x40,%rsp
  8027d2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8027d5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8027d9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8027dd:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8027e1:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8027e4:	48 89 d6             	mov    %rdx,%rsi
  8027e7:	89 c7                	mov    %eax,%edi
  8027e9:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8027f0:	00 00 00 
  8027f3:	ff d0                	callq  *%rax
  8027f5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027fc:	78 24                	js     802822 <write+0x58>
  8027fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802802:	8b 00                	mov    (%rax),%eax
  802804:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802808:	48 89 d6             	mov    %rdx,%rsi
  80280b:	89 c7                	mov    %eax,%edi
  80280d:	48 b8 a7 23 80 00 00 	movabs $0x8023a7,%rax
  802814:	00 00 00 
  802817:	ff d0                	callq  *%rax
  802819:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80281c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802820:	79 05                	jns    802827 <write+0x5d>
  802822:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802825:	eb 75                	jmp    80289c <write+0xd2>
  802827:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80282b:	8b 40 08             	mov    0x8(%rax),%eax
  80282e:	83 e0 03             	and    $0x3,%eax
  802831:	85 c0                	test   %eax,%eax
  802833:	75 3a                	jne    80286f <write+0xa5>
  802835:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  80283c:	00 00 00 
  80283f:	48 8b 00             	mov    (%rax),%rax
  802842:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802848:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80284b:	89 c6                	mov    %eax,%esi
  80284d:	48 bf 4b 4b 80 00 00 	movabs $0x804b4b,%rdi
  802854:	00 00 00 
  802857:	b8 00 00 00 00       	mov    $0x0,%eax
  80285c:	48 b9 4a 07 80 00 00 	movabs $0x80074a,%rcx
  802863:	00 00 00 
  802866:	ff d1                	callq  *%rcx
  802868:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80286d:	eb 2d                	jmp    80289c <write+0xd2>
  80286f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802873:	48 8b 40 18          	mov    0x18(%rax),%rax
  802877:	48 85 c0             	test   %rax,%rax
  80287a:	75 07                	jne    802883 <write+0xb9>
  80287c:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802881:	eb 19                	jmp    80289c <write+0xd2>
  802883:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802887:	48 8b 40 18          	mov    0x18(%rax),%rax
  80288b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80288f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802893:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802897:	48 89 cf             	mov    %rcx,%rdi
  80289a:	ff d0                	callq  *%rax
  80289c:	c9                   	leaveq 
  80289d:	c3                   	retq   

000000000080289e <seek>:
  80289e:	55                   	push   %rbp
  80289f:	48 89 e5             	mov    %rsp,%rbp
  8028a2:	48 83 ec 18          	sub    $0x18,%rsp
  8028a6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8028a9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8028ac:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028b3:	48 89 d6             	mov    %rdx,%rsi
  8028b6:	89 c7                	mov    %eax,%edi
  8028b8:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8028bf:	00 00 00 
  8028c2:	ff d0                	callq  *%rax
  8028c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028cb:	79 05                	jns    8028d2 <seek+0x34>
  8028cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028d0:	eb 0f                	jmp    8028e1 <seek+0x43>
  8028d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028d6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8028d9:	89 50 04             	mov    %edx,0x4(%rax)
  8028dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8028e1:	c9                   	leaveq 
  8028e2:	c3                   	retq   

00000000008028e3 <ftruncate>:
  8028e3:	55                   	push   %rbp
  8028e4:	48 89 e5             	mov    %rsp,%rbp
  8028e7:	48 83 ec 30          	sub    $0x30,%rsp
  8028eb:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8028ee:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8028f1:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8028f5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8028f8:	48 89 d6             	mov    %rdx,%rsi
  8028fb:	89 c7                	mov    %eax,%edi
  8028fd:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  802904:	00 00 00 
  802907:	ff d0                	callq  *%rax
  802909:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80290c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802910:	78 24                	js     802936 <ftruncate+0x53>
  802912:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802916:	8b 00                	mov    (%rax),%eax
  802918:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80291c:	48 89 d6             	mov    %rdx,%rsi
  80291f:	89 c7                	mov    %eax,%edi
  802921:	48 b8 a7 23 80 00 00 	movabs $0x8023a7,%rax
  802928:	00 00 00 
  80292b:	ff d0                	callq  *%rax
  80292d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802930:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802934:	79 05                	jns    80293b <ftruncate+0x58>
  802936:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802939:	eb 72                	jmp    8029ad <ftruncate+0xca>
  80293b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80293f:	8b 40 08             	mov    0x8(%rax),%eax
  802942:	83 e0 03             	and    $0x3,%eax
  802945:	85 c0                	test   %eax,%eax
  802947:	75 3a                	jne    802983 <ftruncate+0xa0>
  802949:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  802950:	00 00 00 
  802953:	48 8b 00             	mov    (%rax),%rax
  802956:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80295c:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80295f:	89 c6                	mov    %eax,%esi
  802961:	48 bf 68 4b 80 00 00 	movabs $0x804b68,%rdi
  802968:	00 00 00 
  80296b:	b8 00 00 00 00       	mov    $0x0,%eax
  802970:	48 b9 4a 07 80 00 00 	movabs $0x80074a,%rcx
  802977:	00 00 00 
  80297a:	ff d1                	callq  *%rcx
  80297c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802981:	eb 2a                	jmp    8029ad <ftruncate+0xca>
  802983:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802987:	48 8b 40 30          	mov    0x30(%rax),%rax
  80298b:	48 85 c0             	test   %rax,%rax
  80298e:	75 07                	jne    802997 <ftruncate+0xb4>
  802990:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802995:	eb 16                	jmp    8029ad <ftruncate+0xca>
  802997:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80299b:	48 8b 40 30          	mov    0x30(%rax),%rax
  80299f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8029a3:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8029a6:	89 ce                	mov    %ecx,%esi
  8029a8:	48 89 d7             	mov    %rdx,%rdi
  8029ab:	ff d0                	callq  *%rax
  8029ad:	c9                   	leaveq 
  8029ae:	c3                   	retq   

00000000008029af <fstat>:
  8029af:	55                   	push   %rbp
  8029b0:	48 89 e5             	mov    %rsp,%rbp
  8029b3:	48 83 ec 30          	sub    $0x30,%rsp
  8029b7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8029ba:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8029be:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8029c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8029c5:	48 89 d6             	mov    %rdx,%rsi
  8029c8:	89 c7                	mov    %eax,%edi
  8029ca:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8029d1:	00 00 00 
  8029d4:	ff d0                	callq  *%rax
  8029d6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029d9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029dd:	78 24                	js     802a03 <fstat+0x54>
  8029df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029e3:	8b 00                	mov    (%rax),%eax
  8029e5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8029e9:	48 89 d6             	mov    %rdx,%rsi
  8029ec:	89 c7                	mov    %eax,%edi
  8029ee:	48 b8 a7 23 80 00 00 	movabs $0x8023a7,%rax
  8029f5:	00 00 00 
  8029f8:	ff d0                	callq  *%rax
  8029fa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029fd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a01:	79 05                	jns    802a08 <fstat+0x59>
  802a03:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a06:	eb 5e                	jmp    802a66 <fstat+0xb7>
  802a08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a0c:	48 8b 40 28          	mov    0x28(%rax),%rax
  802a10:	48 85 c0             	test   %rax,%rax
  802a13:	75 07                	jne    802a1c <fstat+0x6d>
  802a15:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802a1a:	eb 4a                	jmp    802a66 <fstat+0xb7>
  802a1c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a20:	c6 00 00             	movb   $0x0,(%rax)
  802a23:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a27:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802a2e:	00 00 00 
  802a31:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a35:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802a3c:	00 00 00 
  802a3f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a43:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a47:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a52:	48 8b 40 28          	mov    0x28(%rax),%rax
  802a56:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802a5a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802a5e:	48 89 ce             	mov    %rcx,%rsi
  802a61:	48 89 d7             	mov    %rdx,%rdi
  802a64:	ff d0                	callq  *%rax
  802a66:	c9                   	leaveq 
  802a67:	c3                   	retq   

0000000000802a68 <stat>:
  802a68:	55                   	push   %rbp
  802a69:	48 89 e5             	mov    %rsp,%rbp
  802a6c:	48 83 ec 20          	sub    $0x20,%rsp
  802a70:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802a74:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802a78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a7c:	be 00 00 00 00       	mov    $0x0,%esi
  802a81:	48 89 c7             	mov    %rax,%rdi
  802a84:	48 b8 56 2b 80 00 00 	movabs $0x802b56,%rax
  802a8b:	00 00 00 
  802a8e:	ff d0                	callq  *%rax
  802a90:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a93:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a97:	79 05                	jns    802a9e <stat+0x36>
  802a99:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a9c:	eb 2f                	jmp    802acd <stat+0x65>
  802a9e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802aa2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aa5:	48 89 d6             	mov    %rdx,%rsi
  802aa8:	89 c7                	mov    %eax,%edi
  802aaa:	48 b8 af 29 80 00 00 	movabs $0x8029af,%rax
  802ab1:	00 00 00 
  802ab4:	ff d0                	callq  *%rax
  802ab6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802ab9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802abc:	89 c7                	mov    %eax,%edi
  802abe:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  802ac5:	00 00 00 
  802ac8:	ff d0                	callq  *%rax
  802aca:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802acd:	c9                   	leaveq 
  802ace:	c3                   	retq   

0000000000802acf <fsipc>:
  802acf:	55                   	push   %rbp
  802ad0:	48 89 e5             	mov    %rsp,%rbp
  802ad3:	48 83 ec 10          	sub    $0x10,%rsp
  802ad7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802ada:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802ade:	48 b8 00 74 80 00 00 	movabs $0x807400,%rax
  802ae5:	00 00 00 
  802ae8:	8b 00                	mov    (%rax),%eax
  802aea:	85 c0                	test   %eax,%eax
  802aec:	75 1d                	jne    802b0b <fsipc+0x3c>
  802aee:	bf 01 00 00 00       	mov    $0x1,%edi
  802af3:	48 b8 38 44 80 00 00 	movabs $0x804438,%rax
  802afa:	00 00 00 
  802afd:	ff d0                	callq  *%rax
  802aff:	48 ba 00 74 80 00 00 	movabs $0x807400,%rdx
  802b06:	00 00 00 
  802b09:	89 02                	mov    %eax,(%rdx)
  802b0b:	48 b8 00 74 80 00 00 	movabs $0x807400,%rax
  802b12:	00 00 00 
  802b15:	8b 00                	mov    (%rax),%eax
  802b17:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802b1a:	b9 07 00 00 00       	mov    $0x7,%ecx
  802b1f:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802b26:	00 00 00 
  802b29:	89 c7                	mov    %eax,%edi
  802b2b:	48 b8 2d 43 80 00 00 	movabs $0x80432d,%rax
  802b32:	00 00 00 
  802b35:	ff d0                	callq  *%rax
  802b37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b3b:	ba 00 00 00 00       	mov    $0x0,%edx
  802b40:	48 89 c6             	mov    %rax,%rsi
  802b43:	bf 00 00 00 00       	mov    $0x0,%edi
  802b48:	48 b8 6c 42 80 00 00 	movabs $0x80426c,%rax
  802b4f:	00 00 00 
  802b52:	ff d0                	callq  *%rax
  802b54:	c9                   	leaveq 
  802b55:	c3                   	retq   

0000000000802b56 <open>:
  802b56:	55                   	push   %rbp
  802b57:	48 89 e5             	mov    %rsp,%rbp
  802b5a:	48 83 ec 20          	sub    $0x20,%rsp
  802b5e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802b62:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802b65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b69:	48 89 c7             	mov    %rax,%rdi
  802b6c:	48 b8 ed 13 80 00 00 	movabs $0x8013ed,%rax
  802b73:	00 00 00 
  802b76:	ff d0                	callq  *%rax
  802b78:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802b7d:	7e 0a                	jle    802b89 <open+0x33>
  802b7f:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802b84:	e9 a5 00 00 00       	jmpq   802c2e <open+0xd8>
  802b89:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802b8d:	48 89 c7             	mov    %rax,%rdi
  802b90:	48 b8 b6 21 80 00 00 	movabs $0x8021b6,%rax
  802b97:	00 00 00 
  802b9a:	ff d0                	callq  *%rax
  802b9c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b9f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ba3:	79 08                	jns    802bad <open+0x57>
  802ba5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ba8:	e9 81 00 00 00       	jmpq   802c2e <open+0xd8>
  802bad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bb1:	48 89 c6             	mov    %rax,%rsi
  802bb4:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802bbb:	00 00 00 
  802bbe:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  802bc5:	00 00 00 
  802bc8:	ff d0                	callq  *%rax
  802bca:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802bd1:	00 00 00 
  802bd4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802bd7:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802bdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802be1:	48 89 c6             	mov    %rax,%rsi
  802be4:	bf 01 00 00 00       	mov    $0x1,%edi
  802be9:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802bf0:	00 00 00 
  802bf3:	ff d0                	callq  *%rax
  802bf5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802bf8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802bfc:	79 1d                	jns    802c1b <open+0xc5>
  802bfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c02:	be 00 00 00 00       	mov    $0x0,%esi
  802c07:	48 89 c7             	mov    %rax,%rdi
  802c0a:	48 b8 de 22 80 00 00 	movabs $0x8022de,%rax
  802c11:	00 00 00 
  802c14:	ff d0                	callq  *%rax
  802c16:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c19:	eb 13                	jmp    802c2e <open+0xd8>
  802c1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c1f:	48 89 c7             	mov    %rax,%rdi
  802c22:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  802c29:	00 00 00 
  802c2c:	ff d0                	callq  *%rax
  802c2e:	c9                   	leaveq 
  802c2f:	c3                   	retq   

0000000000802c30 <devfile_flush>:
  802c30:	55                   	push   %rbp
  802c31:	48 89 e5             	mov    %rsp,%rbp
  802c34:	48 83 ec 10          	sub    $0x10,%rsp
  802c38:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802c40:	8b 50 0c             	mov    0xc(%rax),%edx
  802c43:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c4a:	00 00 00 
  802c4d:	89 10                	mov    %edx,(%rax)
  802c4f:	be 00 00 00 00       	mov    $0x0,%esi
  802c54:	bf 06 00 00 00       	mov    $0x6,%edi
  802c59:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802c60:	00 00 00 
  802c63:	ff d0                	callq  *%rax
  802c65:	c9                   	leaveq 
  802c66:	c3                   	retq   

0000000000802c67 <devfile_read>:
  802c67:	55                   	push   %rbp
  802c68:	48 89 e5             	mov    %rsp,%rbp
  802c6b:	48 83 ec 30          	sub    $0x30,%rsp
  802c6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c73:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802c77:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802c7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c7f:	8b 50 0c             	mov    0xc(%rax),%edx
  802c82:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c89:	00 00 00 
  802c8c:	89 10                	mov    %edx,(%rax)
  802c8e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802c95:	00 00 00 
  802c98:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802c9c:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802ca0:	be 00 00 00 00       	mov    $0x0,%esi
  802ca5:	bf 03 00 00 00       	mov    $0x3,%edi
  802caa:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802cb1:	00 00 00 
  802cb4:	ff d0                	callq  *%rax
  802cb6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cb9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cbd:	79 08                	jns    802cc7 <devfile_read+0x60>
  802cbf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cc2:	e9 a4 00 00 00       	jmpq   802d6b <devfile_read+0x104>
  802cc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cca:	48 98                	cltq   
  802ccc:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802cd0:	76 35                	jbe    802d07 <devfile_read+0xa0>
  802cd2:	48 b9 8e 4b 80 00 00 	movabs $0x804b8e,%rcx
  802cd9:	00 00 00 
  802cdc:	48 ba 95 4b 80 00 00 	movabs $0x804b95,%rdx
  802ce3:	00 00 00 
  802ce6:	be 89 00 00 00       	mov    $0x89,%esi
  802ceb:	48 bf aa 4b 80 00 00 	movabs $0x804baa,%rdi
  802cf2:	00 00 00 
  802cf5:	b8 00 00 00 00       	mov    $0x0,%eax
  802cfa:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  802d01:	00 00 00 
  802d04:	41 ff d0             	callq  *%r8
  802d07:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802d0e:	7e 35                	jle    802d45 <devfile_read+0xde>
  802d10:	48 b9 b8 4b 80 00 00 	movabs $0x804bb8,%rcx
  802d17:	00 00 00 
  802d1a:	48 ba 95 4b 80 00 00 	movabs $0x804b95,%rdx
  802d21:	00 00 00 
  802d24:	be 8a 00 00 00       	mov    $0x8a,%esi
  802d29:	48 bf aa 4b 80 00 00 	movabs $0x804baa,%rdi
  802d30:	00 00 00 
  802d33:	b8 00 00 00 00       	mov    $0x0,%eax
  802d38:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  802d3f:	00 00 00 
  802d42:	41 ff d0             	callq  *%r8
  802d45:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d48:	48 63 d0             	movslq %eax,%rdx
  802d4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d4f:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802d56:	00 00 00 
  802d59:	48 89 c7             	mov    %rax,%rdi
  802d5c:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  802d63:	00 00 00 
  802d66:	ff d0                	callq  *%rax
  802d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d6b:	c9                   	leaveq 
  802d6c:	c3                   	retq   

0000000000802d6d <devfile_write>:
  802d6d:	55                   	push   %rbp
  802d6e:	48 89 e5             	mov    %rsp,%rbp
  802d71:	48 83 ec 40          	sub    $0x40,%rsp
  802d75:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802d79:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802d7d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802d81:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802d85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802d89:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802d90:	00 
  802d91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d95:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802d99:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802d9e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802da2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802da6:	8b 50 0c             	mov    0xc(%rax),%edx
  802da9:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802db0:	00 00 00 
  802db3:	89 10                	mov    %edx,(%rax)
  802db5:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802dbc:	00 00 00 
  802dbf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802dc3:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802dc7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802dcb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802dcf:	48 89 c6             	mov    %rax,%rsi
  802dd2:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  802dd9:	00 00 00 
  802ddc:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  802de3:	00 00 00 
  802de6:	ff d0                	callq  *%rax
  802de8:	be 00 00 00 00       	mov    $0x0,%esi
  802ded:	bf 04 00 00 00       	mov    $0x4,%edi
  802df2:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802df9:	00 00 00 
  802dfc:	ff d0                	callq  *%rax
  802dfe:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802e01:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802e05:	79 05                	jns    802e0c <devfile_write+0x9f>
  802e07:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e0a:	eb 43                	jmp    802e4f <devfile_write+0xe2>
  802e0c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e0f:	48 98                	cltq   
  802e11:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802e15:	76 35                	jbe    802e4c <devfile_write+0xdf>
  802e17:	48 b9 8e 4b 80 00 00 	movabs $0x804b8e,%rcx
  802e1e:	00 00 00 
  802e21:	48 ba 95 4b 80 00 00 	movabs $0x804b95,%rdx
  802e28:	00 00 00 
  802e2b:	be a8 00 00 00       	mov    $0xa8,%esi
  802e30:	48 bf aa 4b 80 00 00 	movabs $0x804baa,%rdi
  802e37:	00 00 00 
  802e3a:	b8 00 00 00 00       	mov    $0x0,%eax
  802e3f:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  802e46:	00 00 00 
  802e49:	41 ff d0             	callq  *%r8
  802e4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e4f:	c9                   	leaveq 
  802e50:	c3                   	retq   

0000000000802e51 <devfile_stat>:
  802e51:	55                   	push   %rbp
  802e52:	48 89 e5             	mov    %rsp,%rbp
  802e55:	48 83 ec 20          	sub    $0x20,%rsp
  802e59:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802e5d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802e61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e65:	8b 50 0c             	mov    0xc(%rax),%edx
  802e68:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802e6f:	00 00 00 
  802e72:	89 10                	mov    %edx,(%rax)
  802e74:	be 00 00 00 00       	mov    $0x0,%esi
  802e79:	bf 05 00 00 00       	mov    $0x5,%edi
  802e7e:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802e85:	00 00 00 
  802e88:	ff d0                	callq  *%rax
  802e8a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e8d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e91:	79 05                	jns    802e98 <devfile_stat+0x47>
  802e93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e96:	eb 56                	jmp    802eee <devfile_stat+0x9d>
  802e98:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802e9c:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802ea3:	00 00 00 
  802ea6:	48 89 c7             	mov    %rax,%rdi
  802ea9:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  802eb0:	00 00 00 
  802eb3:	ff d0                	callq  *%rax
  802eb5:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802ebc:	00 00 00 
  802ebf:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802ec5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ec9:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802ecf:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802ed6:	00 00 00 
  802ed9:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802edf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ee3:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802ee9:	b8 00 00 00 00       	mov    $0x0,%eax
  802eee:	c9                   	leaveq 
  802eef:	c3                   	retq   

0000000000802ef0 <devfile_trunc>:
  802ef0:	55                   	push   %rbp
  802ef1:	48 89 e5             	mov    %rsp,%rbp
  802ef4:	48 83 ec 10          	sub    $0x10,%rsp
  802ef8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802efc:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802eff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f03:	8b 50 0c             	mov    0xc(%rax),%edx
  802f06:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f0d:	00 00 00 
  802f10:	89 10                	mov    %edx,(%rax)
  802f12:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f19:	00 00 00 
  802f1c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802f1f:	89 50 04             	mov    %edx,0x4(%rax)
  802f22:	be 00 00 00 00       	mov    $0x0,%esi
  802f27:	bf 02 00 00 00       	mov    $0x2,%edi
  802f2c:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802f33:	00 00 00 
  802f36:	ff d0                	callq  *%rax
  802f38:	c9                   	leaveq 
  802f39:	c3                   	retq   

0000000000802f3a <remove>:
  802f3a:	55                   	push   %rbp
  802f3b:	48 89 e5             	mov    %rsp,%rbp
  802f3e:	48 83 ec 10          	sub    $0x10,%rsp
  802f42:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802f46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f4a:	48 89 c7             	mov    %rax,%rdi
  802f4d:	48 b8 ed 13 80 00 00 	movabs $0x8013ed,%rax
  802f54:	00 00 00 
  802f57:	ff d0                	callq  *%rax
  802f59:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802f5e:	7e 07                	jle    802f67 <remove+0x2d>
  802f60:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802f65:	eb 33                	jmp    802f9a <remove+0x60>
  802f67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f6b:	48 89 c6             	mov    %rax,%rsi
  802f6e:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802f75:	00 00 00 
  802f78:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  802f7f:	00 00 00 
  802f82:	ff d0                	callq  *%rax
  802f84:	be 00 00 00 00       	mov    $0x0,%esi
  802f89:	bf 07 00 00 00       	mov    $0x7,%edi
  802f8e:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802f95:	00 00 00 
  802f98:	ff d0                	callq  *%rax
  802f9a:	c9                   	leaveq 
  802f9b:	c3                   	retq   

0000000000802f9c <sync>:
  802f9c:	55                   	push   %rbp
  802f9d:	48 89 e5             	mov    %rsp,%rbp
  802fa0:	be 00 00 00 00       	mov    $0x0,%esi
  802fa5:	bf 08 00 00 00       	mov    $0x8,%edi
  802faa:	48 b8 cf 2a 80 00 00 	movabs $0x802acf,%rax
  802fb1:	00 00 00 
  802fb4:	ff d0                	callq  *%rax
  802fb6:	5d                   	pop    %rbp
  802fb7:	c3                   	retq   

0000000000802fb8 <copy>:
  802fb8:	55                   	push   %rbp
  802fb9:	48 89 e5             	mov    %rsp,%rbp
  802fbc:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802fc3:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802fca:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802fd1:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802fd8:	be 00 00 00 00       	mov    $0x0,%esi
  802fdd:	48 89 c7             	mov    %rax,%rdi
  802fe0:	48 b8 56 2b 80 00 00 	movabs $0x802b56,%rax
  802fe7:	00 00 00 
  802fea:	ff d0                	callq  *%rax
  802fec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ff3:	79 28                	jns    80301d <copy+0x65>
  802ff5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ff8:	89 c6                	mov    %eax,%esi
  802ffa:	48 bf c4 4b 80 00 00 	movabs $0x804bc4,%rdi
  803001:	00 00 00 
  803004:	b8 00 00 00 00       	mov    $0x0,%eax
  803009:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  803010:	00 00 00 
  803013:	ff d2                	callq  *%rdx
  803015:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803018:	e9 74 01 00 00       	jmpq   803191 <copy+0x1d9>
  80301d:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803024:	be 01 01 00 00       	mov    $0x101,%esi
  803029:	48 89 c7             	mov    %rax,%rdi
  80302c:	48 b8 56 2b 80 00 00 	movabs $0x802b56,%rax
  803033:	00 00 00 
  803036:	ff d0                	callq  *%rax
  803038:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80303b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80303f:	79 39                	jns    80307a <copy+0xc2>
  803041:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803044:	89 c6                	mov    %eax,%esi
  803046:	48 bf da 4b 80 00 00 	movabs $0x804bda,%rdi
  80304d:	00 00 00 
  803050:	b8 00 00 00 00       	mov    $0x0,%eax
  803055:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  80305c:	00 00 00 
  80305f:	ff d2                	callq  *%rdx
  803061:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803064:	89 c7                	mov    %eax,%edi
  803066:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  80306d:	00 00 00 
  803070:	ff d0                	callq  *%rax
  803072:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803075:	e9 17 01 00 00       	jmpq   803191 <copy+0x1d9>
  80307a:	eb 74                	jmp    8030f0 <copy+0x138>
  80307c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80307f:	48 63 d0             	movslq %eax,%rdx
  803082:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803089:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80308c:	48 89 ce             	mov    %rcx,%rsi
  80308f:	89 c7                	mov    %eax,%edi
  803091:	48 b8 ca 27 80 00 00 	movabs $0x8027ca,%rax
  803098:	00 00 00 
  80309b:	ff d0                	callq  *%rax
  80309d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8030a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8030a4:	79 4a                	jns    8030f0 <copy+0x138>
  8030a6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8030a9:	89 c6                	mov    %eax,%esi
  8030ab:	48 bf f4 4b 80 00 00 	movabs $0x804bf4,%rdi
  8030b2:	00 00 00 
  8030b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8030ba:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  8030c1:	00 00 00 
  8030c4:	ff d2                	callq  *%rdx
  8030c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030c9:	89 c7                	mov    %eax,%edi
  8030cb:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  8030d2:	00 00 00 
  8030d5:	ff d0                	callq  *%rax
  8030d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8030da:	89 c7                	mov    %eax,%edi
  8030dc:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  8030e3:	00 00 00 
  8030e6:	ff d0                	callq  *%rax
  8030e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8030eb:	e9 a1 00 00 00       	jmpq   803191 <copy+0x1d9>
  8030f0:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8030f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030fa:	ba 00 02 00 00       	mov    $0x200,%edx
  8030ff:	48 89 ce             	mov    %rcx,%rsi
  803102:	89 c7                	mov    %eax,%edi
  803104:	48 b8 80 26 80 00 00 	movabs $0x802680,%rax
  80310b:	00 00 00 
  80310e:	ff d0                	callq  *%rax
  803110:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803113:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803117:	0f 8f 5f ff ff ff    	jg     80307c <copy+0xc4>
  80311d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803121:	79 47                	jns    80316a <copy+0x1b2>
  803123:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803126:	89 c6                	mov    %eax,%esi
  803128:	48 bf 07 4c 80 00 00 	movabs $0x804c07,%rdi
  80312f:	00 00 00 
  803132:	b8 00 00 00 00       	mov    $0x0,%eax
  803137:	48 ba 4a 07 80 00 00 	movabs $0x80074a,%rdx
  80313e:	00 00 00 
  803141:	ff d2                	callq  *%rdx
  803143:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803146:	89 c7                	mov    %eax,%edi
  803148:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  80314f:	00 00 00 
  803152:	ff d0                	callq  *%rax
  803154:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803157:	89 c7                	mov    %eax,%edi
  803159:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  803160:	00 00 00 
  803163:	ff d0                	callq  *%rax
  803165:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803168:	eb 27                	jmp    803191 <copy+0x1d9>
  80316a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80316d:	89 c7                	mov    %eax,%edi
  80316f:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  803176:	00 00 00 
  803179:	ff d0                	callq  *%rax
  80317b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80317e:	89 c7                	mov    %eax,%edi
  803180:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  803187:	00 00 00 
  80318a:	ff d0                	callq  *%rax
  80318c:	b8 00 00 00 00       	mov    $0x0,%eax
  803191:	c9                   	leaveq 
  803192:	c3                   	retq   

0000000000803193 <writebuf>:
  803193:	55                   	push   %rbp
  803194:	48 89 e5             	mov    %rsp,%rbp
  803197:	48 83 ec 20          	sub    $0x20,%rsp
  80319b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80319f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031a3:	8b 40 0c             	mov    0xc(%rax),%eax
  8031a6:	85 c0                	test   %eax,%eax
  8031a8:	7e 67                	jle    803211 <writebuf+0x7e>
  8031aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031ae:	8b 40 04             	mov    0x4(%rax),%eax
  8031b1:	48 63 d0             	movslq %eax,%rdx
  8031b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031b8:	48 8d 48 10          	lea    0x10(%rax),%rcx
  8031bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031c0:	8b 00                	mov    (%rax),%eax
  8031c2:	48 89 ce             	mov    %rcx,%rsi
  8031c5:	89 c7                	mov    %eax,%edi
  8031c7:	48 b8 ca 27 80 00 00 	movabs $0x8027ca,%rax
  8031ce:	00 00 00 
  8031d1:	ff d0                	callq  *%rax
  8031d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031da:	7e 13                	jle    8031ef <writebuf+0x5c>
  8031dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031e0:	8b 50 08             	mov    0x8(%rax),%edx
  8031e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031e6:	01 c2                	add    %eax,%edx
  8031e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031ec:	89 50 08             	mov    %edx,0x8(%rax)
  8031ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031f3:	8b 40 04             	mov    0x4(%rax),%eax
  8031f6:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  8031f9:	74 16                	je     803211 <writebuf+0x7e>
  8031fb:	b8 00 00 00 00       	mov    $0x0,%eax
  803200:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803204:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  803208:	89 c2                	mov    %eax,%edx
  80320a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80320e:	89 50 0c             	mov    %edx,0xc(%rax)
  803211:	c9                   	leaveq 
  803212:	c3                   	retq   

0000000000803213 <putch>:
  803213:	55                   	push   %rbp
  803214:	48 89 e5             	mov    %rsp,%rbp
  803217:	48 83 ec 20          	sub    $0x20,%rsp
  80321b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80321e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803222:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803226:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80322a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80322e:	8b 40 04             	mov    0x4(%rax),%eax
  803231:	8d 48 01             	lea    0x1(%rax),%ecx
  803234:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803238:	89 4a 04             	mov    %ecx,0x4(%rdx)
  80323b:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80323e:	89 d1                	mov    %edx,%ecx
  803240:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803244:	48 98                	cltq   
  803246:	88 4c 02 10          	mov    %cl,0x10(%rdx,%rax,1)
  80324a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80324e:	8b 40 04             	mov    0x4(%rax),%eax
  803251:	3d 00 01 00 00       	cmp    $0x100,%eax
  803256:	75 1e                	jne    803276 <putch+0x63>
  803258:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80325c:	48 89 c7             	mov    %rax,%rdi
  80325f:	48 b8 93 31 80 00 00 	movabs $0x803193,%rax
  803266:	00 00 00 
  803269:	ff d0                	callq  *%rax
  80326b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80326f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  803276:	c9                   	leaveq 
  803277:	c3                   	retq   

0000000000803278 <vfprintf>:
  803278:	55                   	push   %rbp
  803279:	48 89 e5             	mov    %rsp,%rbp
  80327c:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  803283:	89 bd ec fe ff ff    	mov    %edi,-0x114(%rbp)
  803289:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  803290:	48 89 95 d8 fe ff ff 	mov    %rdx,-0x128(%rbp)
  803297:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  80329d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%rbp)
  8032a3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8032aa:	00 00 00 
  8032ad:	c7 85 f8 fe ff ff 00 	movl   $0x0,-0x108(%rbp)
  8032b4:	00 00 00 
  8032b7:	c7 85 fc fe ff ff 01 	movl   $0x1,-0x104(%rbp)
  8032be:	00 00 00 
  8032c1:	48 8b 8d d8 fe ff ff 	mov    -0x128(%rbp),%rcx
  8032c8:	48 8b 95 e0 fe ff ff 	mov    -0x120(%rbp),%rdx
  8032cf:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8032d6:	48 89 c6             	mov    %rax,%rsi
  8032d9:	48 bf 13 32 80 00 00 	movabs $0x803213,%rdi
  8032e0:	00 00 00 
  8032e3:	48 b8 fd 0a 80 00 00 	movabs $0x800afd,%rax
  8032ea:	00 00 00 
  8032ed:	ff d0                	callq  *%rax
  8032ef:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8032f5:	85 c0                	test   %eax,%eax
  8032f7:	7e 16                	jle    80330f <vfprintf+0x97>
  8032f9:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  803300:	48 89 c7             	mov    %rax,%rdi
  803303:	48 b8 93 31 80 00 00 	movabs $0x803193,%rax
  80330a:	00 00 00 
  80330d:	ff d0                	callq  *%rax
  80330f:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  803315:	85 c0                	test   %eax,%eax
  803317:	74 08                	je     803321 <vfprintf+0xa9>
  803319:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
  80331f:	eb 06                	jmp    803327 <vfprintf+0xaf>
  803321:	8b 85 fc fe ff ff    	mov    -0x104(%rbp),%eax
  803327:	c9                   	leaveq 
  803328:	c3                   	retq   

0000000000803329 <fprintf>:
  803329:	55                   	push   %rbp
  80332a:	48 89 e5             	mov    %rsp,%rbp
  80332d:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  803334:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%rbp)
  80333a:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  803341:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803348:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80334f:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803356:	84 c0                	test   %al,%al
  803358:	74 20                	je     80337a <fprintf+0x51>
  80335a:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80335e:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803362:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803366:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80336a:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80336e:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803372:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  803376:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80337a:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  803381:	c7 85 30 ff ff ff 10 	movl   $0x10,-0xd0(%rbp)
  803388:	00 00 00 
  80338b:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803392:	00 00 00 
  803395:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803399:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8033a0:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8033a7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8033ae:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8033b5:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
  8033bc:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8033c2:	48 89 ce             	mov    %rcx,%rsi
  8033c5:	89 c7                	mov    %eax,%edi
  8033c7:	48 b8 78 32 80 00 00 	movabs $0x803278,%rax
  8033ce:	00 00 00 
  8033d1:	ff d0                	callq  *%rax
  8033d3:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8033d9:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8033df:	c9                   	leaveq 
  8033e0:	c3                   	retq   

00000000008033e1 <printf>:
  8033e1:	55                   	push   %rbp
  8033e2:	48 89 e5             	mov    %rsp,%rbp
  8033e5:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  8033ec:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8033f3:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8033fa:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803401:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803408:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80340f:	84 c0                	test   %al,%al
  803411:	74 20                	je     803433 <printf+0x52>
  803413:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803417:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80341b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80341f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803423:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803427:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80342b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80342f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  803433:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  80343a:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  803441:	00 00 00 
  803444:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80344b:	00 00 00 
  80344e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803452:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803459:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803460:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803467:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80346e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  803475:	48 89 c6             	mov    %rax,%rsi
  803478:	bf 01 00 00 00       	mov    $0x1,%edi
  80347d:	48 b8 78 32 80 00 00 	movabs $0x803278,%rax
  803484:	00 00 00 
  803487:	ff d0                	callq  *%rax
  803489:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80348f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  803495:	c9                   	leaveq 
  803496:	c3                   	retq   

0000000000803497 <fd2sockid>:
  803497:	55                   	push   %rbp
  803498:	48 89 e5             	mov    %rsp,%rbp
  80349b:	48 83 ec 20          	sub    $0x20,%rsp
  80349f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8034a2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8034a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8034a9:	48 89 d6             	mov    %rdx,%rsi
  8034ac:	89 c7                	mov    %eax,%edi
  8034ae:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  8034b5:	00 00 00 
  8034b8:	ff d0                	callq  *%rax
  8034ba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034c1:	79 05                	jns    8034c8 <fd2sockid+0x31>
  8034c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034c6:	eb 24                	jmp    8034ec <fd2sockid+0x55>
  8034c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8034cc:	8b 10                	mov    (%rax),%edx
  8034ce:	48 b8 c0 60 80 00 00 	movabs $0x8060c0,%rax
  8034d5:	00 00 00 
  8034d8:	8b 00                	mov    (%rax),%eax
  8034da:	39 c2                	cmp    %eax,%edx
  8034dc:	74 07                	je     8034e5 <fd2sockid+0x4e>
  8034de:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8034e3:	eb 07                	jmp    8034ec <fd2sockid+0x55>
  8034e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8034e9:	8b 40 0c             	mov    0xc(%rax),%eax
  8034ec:	c9                   	leaveq 
  8034ed:	c3                   	retq   

00000000008034ee <alloc_sockfd>:
  8034ee:	55                   	push   %rbp
  8034ef:	48 89 e5             	mov    %rsp,%rbp
  8034f2:	48 83 ec 20          	sub    $0x20,%rsp
  8034f6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8034f9:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8034fd:	48 89 c7             	mov    %rax,%rdi
  803500:	48 b8 b6 21 80 00 00 	movabs $0x8021b6,%rax
  803507:	00 00 00 
  80350a:	ff d0                	callq  *%rax
  80350c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80350f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803513:	78 26                	js     80353b <alloc_sockfd+0x4d>
  803515:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803519:	ba 07 04 00 00       	mov    $0x407,%edx
  80351e:	48 89 c6             	mov    %rax,%rsi
  803521:	bf 00 00 00 00       	mov    $0x0,%edi
  803526:	48 b8 88 1d 80 00 00 	movabs $0x801d88,%rax
  80352d:	00 00 00 
  803530:	ff d0                	callq  *%rax
  803532:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803535:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803539:	79 16                	jns    803551 <alloc_sockfd+0x63>
  80353b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80353e:	89 c7                	mov    %eax,%edi
  803540:	48 b8 fb 39 80 00 00 	movabs $0x8039fb,%rax
  803547:	00 00 00 
  80354a:	ff d0                	callq  *%rax
  80354c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80354f:	eb 3a                	jmp    80358b <alloc_sockfd+0x9d>
  803551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803555:	48 ba c0 60 80 00 00 	movabs $0x8060c0,%rdx
  80355c:	00 00 00 
  80355f:	8b 12                	mov    (%rdx),%edx
  803561:	89 10                	mov    %edx,(%rax)
  803563:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803567:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80356e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803572:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803575:	89 50 0c             	mov    %edx,0xc(%rax)
  803578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80357c:	48 89 c7             	mov    %rax,%rdi
  80357f:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  803586:	00 00 00 
  803589:	ff d0                	callq  *%rax
  80358b:	c9                   	leaveq 
  80358c:	c3                   	retq   

000000000080358d <accept>:
  80358d:	55                   	push   %rbp
  80358e:	48 89 e5             	mov    %rsp,%rbp
  803591:	48 83 ec 30          	sub    $0x30,%rsp
  803595:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803598:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80359c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8035a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035a3:	89 c7                	mov    %eax,%edi
  8035a5:	48 b8 97 34 80 00 00 	movabs $0x803497,%rax
  8035ac:	00 00 00 
  8035af:	ff d0                	callq  *%rax
  8035b1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035b8:	79 05                	jns    8035bf <accept+0x32>
  8035ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035bd:	eb 3b                	jmp    8035fa <accept+0x6d>
  8035bf:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8035c3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8035c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035ca:	48 89 ce             	mov    %rcx,%rsi
  8035cd:	89 c7                	mov    %eax,%edi
  8035cf:	48 b8 d8 38 80 00 00 	movabs $0x8038d8,%rax
  8035d6:	00 00 00 
  8035d9:	ff d0                	callq  *%rax
  8035db:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035de:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035e2:	79 05                	jns    8035e9 <accept+0x5c>
  8035e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035e7:	eb 11                	jmp    8035fa <accept+0x6d>
  8035e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035ec:	89 c7                	mov    %eax,%edi
  8035ee:	48 b8 ee 34 80 00 00 	movabs $0x8034ee,%rax
  8035f5:	00 00 00 
  8035f8:	ff d0                	callq  *%rax
  8035fa:	c9                   	leaveq 
  8035fb:	c3                   	retq   

00000000008035fc <bind>:
  8035fc:	55                   	push   %rbp
  8035fd:	48 89 e5             	mov    %rsp,%rbp
  803600:	48 83 ec 20          	sub    $0x20,%rsp
  803604:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803607:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80360b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80360e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803611:	89 c7                	mov    %eax,%edi
  803613:	48 b8 97 34 80 00 00 	movabs $0x803497,%rax
  80361a:	00 00 00 
  80361d:	ff d0                	callq  *%rax
  80361f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803622:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803626:	79 05                	jns    80362d <bind+0x31>
  803628:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80362b:	eb 1b                	jmp    803648 <bind+0x4c>
  80362d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803630:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803634:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803637:	48 89 ce             	mov    %rcx,%rsi
  80363a:	89 c7                	mov    %eax,%edi
  80363c:	48 b8 57 39 80 00 00 	movabs $0x803957,%rax
  803643:	00 00 00 
  803646:	ff d0                	callq  *%rax
  803648:	c9                   	leaveq 
  803649:	c3                   	retq   

000000000080364a <shutdown>:
  80364a:	55                   	push   %rbp
  80364b:	48 89 e5             	mov    %rsp,%rbp
  80364e:	48 83 ec 20          	sub    $0x20,%rsp
  803652:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803655:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803658:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80365b:	89 c7                	mov    %eax,%edi
  80365d:	48 b8 97 34 80 00 00 	movabs $0x803497,%rax
  803664:	00 00 00 
  803667:	ff d0                	callq  *%rax
  803669:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80366c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803670:	79 05                	jns    803677 <shutdown+0x2d>
  803672:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803675:	eb 16                	jmp    80368d <shutdown+0x43>
  803677:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80367a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80367d:	89 d6                	mov    %edx,%esi
  80367f:	89 c7                	mov    %eax,%edi
  803681:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803688:	00 00 00 
  80368b:	ff d0                	callq  *%rax
  80368d:	c9                   	leaveq 
  80368e:	c3                   	retq   

000000000080368f <devsock_close>:
  80368f:	55                   	push   %rbp
  803690:	48 89 e5             	mov    %rsp,%rbp
  803693:	48 83 ec 10          	sub    $0x10,%rsp
  803697:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80369b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80369f:	48 89 c7             	mov    %rax,%rdi
  8036a2:	48 b8 aa 44 80 00 00 	movabs $0x8044aa,%rax
  8036a9:	00 00 00 
  8036ac:	ff d0                	callq  *%rax
  8036ae:	83 f8 01             	cmp    $0x1,%eax
  8036b1:	75 17                	jne    8036ca <devsock_close+0x3b>
  8036b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8036b7:	8b 40 0c             	mov    0xc(%rax),%eax
  8036ba:	89 c7                	mov    %eax,%edi
  8036bc:	48 b8 fb 39 80 00 00 	movabs $0x8039fb,%rax
  8036c3:	00 00 00 
  8036c6:	ff d0                	callq  *%rax
  8036c8:	eb 05                	jmp    8036cf <devsock_close+0x40>
  8036ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8036cf:	c9                   	leaveq 
  8036d0:	c3                   	retq   

00000000008036d1 <connect>:
  8036d1:	55                   	push   %rbp
  8036d2:	48 89 e5             	mov    %rsp,%rbp
  8036d5:	48 83 ec 20          	sub    $0x20,%rsp
  8036d9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036dc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8036e0:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8036e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036e6:	89 c7                	mov    %eax,%edi
  8036e8:	48 b8 97 34 80 00 00 	movabs $0x803497,%rax
  8036ef:	00 00 00 
  8036f2:	ff d0                	callq  *%rax
  8036f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036fb:	79 05                	jns    803702 <connect+0x31>
  8036fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803700:	eb 1b                	jmp    80371d <connect+0x4c>
  803702:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803705:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803709:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80370c:	48 89 ce             	mov    %rcx,%rsi
  80370f:	89 c7                	mov    %eax,%edi
  803711:	48 b8 28 3a 80 00 00 	movabs $0x803a28,%rax
  803718:	00 00 00 
  80371b:	ff d0                	callq  *%rax
  80371d:	c9                   	leaveq 
  80371e:	c3                   	retq   

000000000080371f <listen>:
  80371f:	55                   	push   %rbp
  803720:	48 89 e5             	mov    %rsp,%rbp
  803723:	48 83 ec 20          	sub    $0x20,%rsp
  803727:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80372a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80372d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803730:	89 c7                	mov    %eax,%edi
  803732:	48 b8 97 34 80 00 00 	movabs $0x803497,%rax
  803739:	00 00 00 
  80373c:	ff d0                	callq  *%rax
  80373e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803741:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803745:	79 05                	jns    80374c <listen+0x2d>
  803747:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80374a:	eb 16                	jmp    803762 <listen+0x43>
  80374c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80374f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803752:	89 d6                	mov    %edx,%esi
  803754:	89 c7                	mov    %eax,%edi
  803756:	48 b8 8c 3a 80 00 00 	movabs $0x803a8c,%rax
  80375d:	00 00 00 
  803760:	ff d0                	callq  *%rax
  803762:	c9                   	leaveq 
  803763:	c3                   	retq   

0000000000803764 <devsock_read>:
  803764:	55                   	push   %rbp
  803765:	48 89 e5             	mov    %rsp,%rbp
  803768:	48 83 ec 20          	sub    $0x20,%rsp
  80376c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803770:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803774:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803778:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80377c:	89 c2                	mov    %eax,%edx
  80377e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803782:	8b 40 0c             	mov    0xc(%rax),%eax
  803785:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803789:	b9 00 00 00 00       	mov    $0x0,%ecx
  80378e:	89 c7                	mov    %eax,%edi
  803790:	48 b8 cc 3a 80 00 00 	movabs $0x803acc,%rax
  803797:	00 00 00 
  80379a:	ff d0                	callq  *%rax
  80379c:	c9                   	leaveq 
  80379d:	c3                   	retq   

000000000080379e <devsock_write>:
  80379e:	55                   	push   %rbp
  80379f:	48 89 e5             	mov    %rsp,%rbp
  8037a2:	48 83 ec 20          	sub    $0x20,%rsp
  8037a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037ae:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8037b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037b6:	89 c2                	mov    %eax,%edx
  8037b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037bc:	8b 40 0c             	mov    0xc(%rax),%eax
  8037bf:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8037c3:	b9 00 00 00 00       	mov    $0x0,%ecx
  8037c8:	89 c7                	mov    %eax,%edi
  8037ca:	48 b8 98 3b 80 00 00 	movabs $0x803b98,%rax
  8037d1:	00 00 00 
  8037d4:	ff d0                	callq  *%rax
  8037d6:	c9                   	leaveq 
  8037d7:	c3                   	retq   

00000000008037d8 <devsock_stat>:
  8037d8:	55                   	push   %rbp
  8037d9:	48 89 e5             	mov    %rsp,%rbp
  8037dc:	48 83 ec 10          	sub    $0x10,%rsp
  8037e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037e4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8037ec:	48 be 22 4c 80 00 00 	movabs $0x804c22,%rsi
  8037f3:	00 00 00 
  8037f6:	48 89 c7             	mov    %rax,%rdi
  8037f9:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  803800:	00 00 00 
  803803:	ff d0                	callq  *%rax
  803805:	b8 00 00 00 00       	mov    $0x0,%eax
  80380a:	c9                   	leaveq 
  80380b:	c3                   	retq   

000000000080380c <socket>:
  80380c:	55                   	push   %rbp
  80380d:	48 89 e5             	mov    %rsp,%rbp
  803810:	48 83 ec 20          	sub    $0x20,%rsp
  803814:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803817:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80381a:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80381d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803820:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803823:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803826:	89 ce                	mov    %ecx,%esi
  803828:	89 c7                	mov    %eax,%edi
  80382a:	48 b8 50 3c 80 00 00 	movabs $0x803c50,%rax
  803831:	00 00 00 
  803834:	ff d0                	callq  *%rax
  803836:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803839:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80383d:	79 05                	jns    803844 <socket+0x38>
  80383f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803842:	eb 11                	jmp    803855 <socket+0x49>
  803844:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803847:	89 c7                	mov    %eax,%edi
  803849:	48 b8 ee 34 80 00 00 	movabs $0x8034ee,%rax
  803850:	00 00 00 
  803853:	ff d0                	callq  *%rax
  803855:	c9                   	leaveq 
  803856:	c3                   	retq   

0000000000803857 <nsipc>:
  803857:	55                   	push   %rbp
  803858:	48 89 e5             	mov    %rsp,%rbp
  80385b:	48 83 ec 10          	sub    $0x10,%rsp
  80385f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803862:	48 b8 04 74 80 00 00 	movabs $0x807404,%rax
  803869:	00 00 00 
  80386c:	8b 00                	mov    (%rax),%eax
  80386e:	85 c0                	test   %eax,%eax
  803870:	75 1d                	jne    80388f <nsipc+0x38>
  803872:	bf 02 00 00 00       	mov    $0x2,%edi
  803877:	48 b8 38 44 80 00 00 	movabs $0x804438,%rax
  80387e:	00 00 00 
  803881:	ff d0                	callq  *%rax
  803883:	48 ba 04 74 80 00 00 	movabs $0x807404,%rdx
  80388a:	00 00 00 
  80388d:	89 02                	mov    %eax,(%rdx)
  80388f:	48 b8 04 74 80 00 00 	movabs $0x807404,%rax
  803896:	00 00 00 
  803899:	8b 00                	mov    (%rax),%eax
  80389b:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80389e:	b9 07 00 00 00       	mov    $0x7,%ecx
  8038a3:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  8038aa:	00 00 00 
  8038ad:	89 c7                	mov    %eax,%edi
  8038af:	48 b8 2d 43 80 00 00 	movabs $0x80432d,%rax
  8038b6:	00 00 00 
  8038b9:	ff d0                	callq  *%rax
  8038bb:	ba 00 00 00 00       	mov    $0x0,%edx
  8038c0:	be 00 00 00 00       	mov    $0x0,%esi
  8038c5:	bf 00 00 00 00       	mov    $0x0,%edi
  8038ca:	48 b8 6c 42 80 00 00 	movabs $0x80426c,%rax
  8038d1:	00 00 00 
  8038d4:	ff d0                	callq  *%rax
  8038d6:	c9                   	leaveq 
  8038d7:	c3                   	retq   

00000000008038d8 <nsipc_accept>:
  8038d8:	55                   	push   %rbp
  8038d9:	48 89 e5             	mov    %rsp,%rbp
  8038dc:	48 83 ec 30          	sub    $0x30,%rsp
  8038e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8038e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8038e7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8038eb:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8038f2:	00 00 00 
  8038f5:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8038f8:	89 10                	mov    %edx,(%rax)
  8038fa:	bf 01 00 00 00       	mov    $0x1,%edi
  8038ff:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803906:	00 00 00 
  803909:	ff d0                	callq  *%rax
  80390b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80390e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803912:	78 3e                	js     803952 <nsipc_accept+0x7a>
  803914:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80391b:	00 00 00 
  80391e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803922:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803926:	8b 40 10             	mov    0x10(%rax),%eax
  803929:	89 c2                	mov    %eax,%edx
  80392b:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80392f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803933:	48 89 ce             	mov    %rcx,%rsi
  803936:	48 89 c7             	mov    %rax,%rdi
  803939:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  803940:	00 00 00 
  803943:	ff d0                	callq  *%rax
  803945:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803949:	8b 50 10             	mov    0x10(%rax),%edx
  80394c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803950:	89 10                	mov    %edx,(%rax)
  803952:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803955:	c9                   	leaveq 
  803956:	c3                   	retq   

0000000000803957 <nsipc_bind>:
  803957:	55                   	push   %rbp
  803958:	48 89 e5             	mov    %rsp,%rbp
  80395b:	48 83 ec 10          	sub    $0x10,%rsp
  80395f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803962:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803966:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803969:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803970:	00 00 00 
  803973:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803976:	89 10                	mov    %edx,(%rax)
  803978:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80397b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80397f:	48 89 c6             	mov    %rax,%rsi
  803982:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803989:	00 00 00 
  80398c:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  803993:	00 00 00 
  803996:	ff d0                	callq  *%rax
  803998:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80399f:	00 00 00 
  8039a2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8039a5:	89 50 14             	mov    %edx,0x14(%rax)
  8039a8:	bf 02 00 00 00       	mov    $0x2,%edi
  8039ad:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  8039b4:	00 00 00 
  8039b7:	ff d0                	callq  *%rax
  8039b9:	c9                   	leaveq 
  8039ba:	c3                   	retq   

00000000008039bb <nsipc_shutdown>:
  8039bb:	55                   	push   %rbp
  8039bc:	48 89 e5             	mov    %rsp,%rbp
  8039bf:	48 83 ec 10          	sub    $0x10,%rsp
  8039c3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039c6:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8039c9:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8039d0:	00 00 00 
  8039d3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8039d6:	89 10                	mov    %edx,(%rax)
  8039d8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8039df:	00 00 00 
  8039e2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8039e5:	89 50 04             	mov    %edx,0x4(%rax)
  8039e8:	bf 03 00 00 00       	mov    $0x3,%edi
  8039ed:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  8039f4:	00 00 00 
  8039f7:	ff d0                	callq  *%rax
  8039f9:	c9                   	leaveq 
  8039fa:	c3                   	retq   

00000000008039fb <nsipc_close>:
  8039fb:	55                   	push   %rbp
  8039fc:	48 89 e5             	mov    %rsp,%rbp
  8039ff:	48 83 ec 10          	sub    $0x10,%rsp
  803a03:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a06:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a0d:	00 00 00 
  803a10:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a13:	89 10                	mov    %edx,(%rax)
  803a15:	bf 04 00 00 00       	mov    $0x4,%edi
  803a1a:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803a21:	00 00 00 
  803a24:	ff d0                	callq  *%rax
  803a26:	c9                   	leaveq 
  803a27:	c3                   	retq   

0000000000803a28 <nsipc_connect>:
  803a28:	55                   	push   %rbp
  803a29:	48 89 e5             	mov    %rsp,%rbp
  803a2c:	48 83 ec 10          	sub    $0x10,%rsp
  803a30:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a33:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803a37:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803a3a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a41:	00 00 00 
  803a44:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a47:	89 10                	mov    %edx,(%rax)
  803a49:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a50:	48 89 c6             	mov    %rax,%rsi
  803a53:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803a5a:	00 00 00 
  803a5d:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  803a64:	00 00 00 
  803a67:	ff d0                	callq  *%rax
  803a69:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a70:	00 00 00 
  803a73:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a76:	89 50 14             	mov    %edx,0x14(%rax)
  803a79:	bf 05 00 00 00       	mov    $0x5,%edi
  803a7e:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803a85:	00 00 00 
  803a88:	ff d0                	callq  *%rax
  803a8a:	c9                   	leaveq 
  803a8b:	c3                   	retq   

0000000000803a8c <nsipc_listen>:
  803a8c:	55                   	push   %rbp
  803a8d:	48 89 e5             	mov    %rsp,%rbp
  803a90:	48 83 ec 10          	sub    $0x10,%rsp
  803a94:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a97:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803a9a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803aa1:	00 00 00 
  803aa4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803aa7:	89 10                	mov    %edx,(%rax)
  803aa9:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803ab0:	00 00 00 
  803ab3:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ab6:	89 50 04             	mov    %edx,0x4(%rax)
  803ab9:	bf 06 00 00 00       	mov    $0x6,%edi
  803abe:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803ac5:	00 00 00 
  803ac8:	ff d0                	callq  *%rax
  803aca:	c9                   	leaveq 
  803acb:	c3                   	retq   

0000000000803acc <nsipc_recv>:
  803acc:	55                   	push   %rbp
  803acd:	48 89 e5             	mov    %rsp,%rbp
  803ad0:	48 83 ec 30          	sub    $0x30,%rsp
  803ad4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ad7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803adb:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803ade:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803ae1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803ae8:	00 00 00 
  803aeb:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803aee:	89 10                	mov    %edx,(%rax)
  803af0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803af7:	00 00 00 
  803afa:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803afd:	89 50 04             	mov    %edx,0x4(%rax)
  803b00:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803b07:	00 00 00 
  803b0a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803b0d:	89 50 08             	mov    %edx,0x8(%rax)
  803b10:	bf 07 00 00 00       	mov    $0x7,%edi
  803b15:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803b1c:	00 00 00 
  803b1f:	ff d0                	callq  *%rax
  803b21:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b24:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b28:	78 69                	js     803b93 <nsipc_recv+0xc7>
  803b2a:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803b31:	7f 08                	jg     803b3b <nsipc_recv+0x6f>
  803b33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b36:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803b39:	7e 35                	jle    803b70 <nsipc_recv+0xa4>
  803b3b:	48 b9 29 4c 80 00 00 	movabs $0x804c29,%rcx
  803b42:	00 00 00 
  803b45:	48 ba 3e 4c 80 00 00 	movabs $0x804c3e,%rdx
  803b4c:	00 00 00 
  803b4f:	be 62 00 00 00       	mov    $0x62,%esi
  803b54:	48 bf 53 4c 80 00 00 	movabs $0x804c53,%rdi
  803b5b:	00 00 00 
  803b5e:	b8 00 00 00 00       	mov    $0x0,%eax
  803b63:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  803b6a:	00 00 00 
  803b6d:	41 ff d0             	callq  *%r8
  803b70:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b73:	48 63 d0             	movslq %eax,%rdx
  803b76:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b7a:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  803b81:	00 00 00 
  803b84:	48 89 c7             	mov    %rax,%rdi
  803b87:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  803b8e:	00 00 00 
  803b91:	ff d0                	callq  *%rax
  803b93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b96:	c9                   	leaveq 
  803b97:	c3                   	retq   

0000000000803b98 <nsipc_send>:
  803b98:	55                   	push   %rbp
  803b99:	48 89 e5             	mov    %rsp,%rbp
  803b9c:	48 83 ec 20          	sub    $0x20,%rsp
  803ba0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ba3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803ba7:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803baa:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803bad:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803bb4:	00 00 00 
  803bb7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803bba:	89 10                	mov    %edx,(%rax)
  803bbc:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803bc3:	7e 35                	jle    803bfa <nsipc_send+0x62>
  803bc5:	48 b9 62 4c 80 00 00 	movabs $0x804c62,%rcx
  803bcc:	00 00 00 
  803bcf:	48 ba 3e 4c 80 00 00 	movabs $0x804c3e,%rdx
  803bd6:	00 00 00 
  803bd9:	be 6d 00 00 00       	mov    $0x6d,%esi
  803bde:	48 bf 53 4c 80 00 00 	movabs $0x804c53,%rdi
  803be5:	00 00 00 
  803be8:	b8 00 00 00 00       	mov    $0x0,%eax
  803bed:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  803bf4:	00 00 00 
  803bf7:	41 ff d0             	callq  *%r8
  803bfa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803bfd:	48 63 d0             	movslq %eax,%rdx
  803c00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c04:	48 89 c6             	mov    %rax,%rsi
  803c07:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  803c0e:	00 00 00 
  803c11:	48 b8 7d 17 80 00 00 	movabs $0x80177d,%rax
  803c18:	00 00 00 
  803c1b:	ff d0                	callq  *%rax
  803c1d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803c24:	00 00 00 
  803c27:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c2a:	89 50 04             	mov    %edx,0x4(%rax)
  803c2d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803c34:	00 00 00 
  803c37:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803c3a:	89 50 08             	mov    %edx,0x8(%rax)
  803c3d:	bf 08 00 00 00       	mov    $0x8,%edi
  803c42:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803c49:	00 00 00 
  803c4c:	ff d0                	callq  *%rax
  803c4e:	c9                   	leaveq 
  803c4f:	c3                   	retq   

0000000000803c50 <nsipc_socket>:
  803c50:	55                   	push   %rbp
  803c51:	48 89 e5             	mov    %rsp,%rbp
  803c54:	48 83 ec 10          	sub    $0x10,%rsp
  803c58:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c5b:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803c5e:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803c61:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803c68:	00 00 00 
  803c6b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c6e:	89 10                	mov    %edx,(%rax)
  803c70:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803c77:	00 00 00 
  803c7a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c7d:	89 50 04             	mov    %edx,0x4(%rax)
  803c80:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803c87:	00 00 00 
  803c8a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803c8d:	89 50 08             	mov    %edx,0x8(%rax)
  803c90:	bf 09 00 00 00       	mov    $0x9,%edi
  803c95:	48 b8 57 38 80 00 00 	movabs $0x803857,%rax
  803c9c:	00 00 00 
  803c9f:	ff d0                	callq  *%rax
  803ca1:	c9                   	leaveq 
  803ca2:	c3                   	retq   

0000000000803ca3 <pipe>:
  803ca3:	55                   	push   %rbp
  803ca4:	48 89 e5             	mov    %rsp,%rbp
  803ca7:	53                   	push   %rbx
  803ca8:	48 83 ec 38          	sub    $0x38,%rsp
  803cac:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803cb0:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803cb4:	48 89 c7             	mov    %rax,%rdi
  803cb7:	48 b8 b6 21 80 00 00 	movabs $0x8021b6,%rax
  803cbe:	00 00 00 
  803cc1:	ff d0                	callq  *%rax
  803cc3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803cc6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803cca:	0f 88 bf 01 00 00    	js     803e8f <pipe+0x1ec>
  803cd0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803cd4:	ba 07 04 00 00       	mov    $0x407,%edx
  803cd9:	48 89 c6             	mov    %rax,%rsi
  803cdc:	bf 00 00 00 00       	mov    $0x0,%edi
  803ce1:	48 b8 88 1d 80 00 00 	movabs $0x801d88,%rax
  803ce8:	00 00 00 
  803ceb:	ff d0                	callq  *%rax
  803ced:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803cf0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803cf4:	0f 88 95 01 00 00    	js     803e8f <pipe+0x1ec>
  803cfa:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803cfe:	48 89 c7             	mov    %rax,%rdi
  803d01:	48 b8 b6 21 80 00 00 	movabs $0x8021b6,%rax
  803d08:	00 00 00 
  803d0b:	ff d0                	callq  *%rax
  803d0d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d10:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d14:	0f 88 5d 01 00 00    	js     803e77 <pipe+0x1d4>
  803d1a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803d1e:	ba 07 04 00 00       	mov    $0x407,%edx
  803d23:	48 89 c6             	mov    %rax,%rsi
  803d26:	bf 00 00 00 00       	mov    $0x0,%edi
  803d2b:	48 b8 88 1d 80 00 00 	movabs $0x801d88,%rax
  803d32:	00 00 00 
  803d35:	ff d0                	callq  *%rax
  803d37:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d3a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d3e:	0f 88 33 01 00 00    	js     803e77 <pipe+0x1d4>
  803d44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d48:	48 89 c7             	mov    %rax,%rdi
  803d4b:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  803d52:	00 00 00 
  803d55:	ff d0                	callq  *%rax
  803d57:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803d5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803d5f:	ba 07 04 00 00       	mov    $0x407,%edx
  803d64:	48 89 c6             	mov    %rax,%rsi
  803d67:	bf 00 00 00 00       	mov    $0x0,%edi
  803d6c:	48 b8 88 1d 80 00 00 	movabs $0x801d88,%rax
  803d73:	00 00 00 
  803d76:	ff d0                	callq  *%rax
  803d78:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d7f:	79 05                	jns    803d86 <pipe+0xe3>
  803d81:	e9 d9 00 00 00       	jmpq   803e5f <pipe+0x1bc>
  803d86:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803d8a:	48 89 c7             	mov    %rax,%rdi
  803d8d:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  803d94:	00 00 00 
  803d97:	ff d0                	callq  *%rax
  803d99:	48 89 c2             	mov    %rax,%rdx
  803d9c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803da0:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803da6:	48 89 d1             	mov    %rdx,%rcx
  803da9:	ba 00 00 00 00       	mov    $0x0,%edx
  803dae:	48 89 c6             	mov    %rax,%rsi
  803db1:	bf 00 00 00 00       	mov    $0x0,%edi
  803db6:	48 b8 d8 1d 80 00 00 	movabs $0x801dd8,%rax
  803dbd:	00 00 00 
  803dc0:	ff d0                	callq  *%rax
  803dc2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803dc5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803dc9:	79 1b                	jns    803de6 <pipe+0x143>
  803dcb:	90                   	nop
  803dcc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803dd0:	48 89 c6             	mov    %rax,%rsi
  803dd3:	bf 00 00 00 00       	mov    $0x0,%edi
  803dd8:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  803ddf:	00 00 00 
  803de2:	ff d0                	callq  *%rax
  803de4:	eb 79                	jmp    803e5f <pipe+0x1bc>
  803de6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803dea:	48 ba 00 61 80 00 00 	movabs $0x806100,%rdx
  803df1:	00 00 00 
  803df4:	8b 12                	mov    (%rdx),%edx
  803df6:	89 10                	mov    %edx,(%rax)
  803df8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803dfc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803e03:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e07:	48 ba 00 61 80 00 00 	movabs $0x806100,%rdx
  803e0e:	00 00 00 
  803e11:	8b 12                	mov    (%rdx),%edx
  803e13:	89 10                	mov    %edx,(%rax)
  803e15:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e19:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803e20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e24:	48 89 c7             	mov    %rax,%rdi
  803e27:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  803e2e:	00 00 00 
  803e31:	ff d0                	callq  *%rax
  803e33:	89 c2                	mov    %eax,%edx
  803e35:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803e39:	89 10                	mov    %edx,(%rax)
  803e3b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803e3f:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803e43:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e47:	48 89 c7             	mov    %rax,%rdi
  803e4a:	48 b8 68 21 80 00 00 	movabs $0x802168,%rax
  803e51:	00 00 00 
  803e54:	ff d0                	callq  *%rax
  803e56:	89 03                	mov    %eax,(%rbx)
  803e58:	b8 00 00 00 00       	mov    $0x0,%eax
  803e5d:	eb 33                	jmp    803e92 <pipe+0x1ef>
  803e5f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e63:	48 89 c6             	mov    %rax,%rsi
  803e66:	bf 00 00 00 00       	mov    $0x0,%edi
  803e6b:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  803e72:	00 00 00 
  803e75:	ff d0                	callq  *%rax
  803e77:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e7b:	48 89 c6             	mov    %rax,%rsi
  803e7e:	bf 00 00 00 00       	mov    $0x0,%edi
  803e83:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  803e8a:	00 00 00 
  803e8d:	ff d0                	callq  *%rax
  803e8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803e92:	48 83 c4 38          	add    $0x38,%rsp
  803e96:	5b                   	pop    %rbx
  803e97:	5d                   	pop    %rbp
  803e98:	c3                   	retq   

0000000000803e99 <_pipeisclosed>:
  803e99:	55                   	push   %rbp
  803e9a:	48 89 e5             	mov    %rsp,%rbp
  803e9d:	53                   	push   %rbx
  803e9e:	48 83 ec 28          	sub    $0x28,%rsp
  803ea2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803ea6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803eaa:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  803eb1:	00 00 00 
  803eb4:	48 8b 00             	mov    (%rax),%rax
  803eb7:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803ebd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ec0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ec4:	48 89 c7             	mov    %rax,%rdi
  803ec7:	48 b8 aa 44 80 00 00 	movabs $0x8044aa,%rax
  803ece:	00 00 00 
  803ed1:	ff d0                	callq  *%rax
  803ed3:	89 c3                	mov    %eax,%ebx
  803ed5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ed9:	48 89 c7             	mov    %rax,%rdi
  803edc:	48 b8 aa 44 80 00 00 	movabs $0x8044aa,%rax
  803ee3:	00 00 00 
  803ee6:	ff d0                	callq  *%rax
  803ee8:	39 c3                	cmp    %eax,%ebx
  803eea:	0f 94 c0             	sete   %al
  803eed:	0f b6 c0             	movzbl %al,%eax
  803ef0:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803ef3:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  803efa:	00 00 00 
  803efd:	48 8b 00             	mov    (%rax),%rax
  803f00:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f06:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803f09:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f0c:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803f0f:	75 05                	jne    803f16 <_pipeisclosed+0x7d>
  803f11:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803f14:	eb 4f                	jmp    803f65 <_pipeisclosed+0xcc>
  803f16:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f19:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803f1c:	74 42                	je     803f60 <_pipeisclosed+0xc7>
  803f1e:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803f22:	75 3c                	jne    803f60 <_pipeisclosed+0xc7>
  803f24:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  803f2b:	00 00 00 
  803f2e:	48 8b 00             	mov    (%rax),%rax
  803f31:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803f37:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803f3a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f3d:	89 c6                	mov    %eax,%esi
  803f3f:	48 bf 73 4c 80 00 00 	movabs $0x804c73,%rdi
  803f46:	00 00 00 
  803f49:	b8 00 00 00 00       	mov    $0x0,%eax
  803f4e:	49 b8 4a 07 80 00 00 	movabs $0x80074a,%r8
  803f55:	00 00 00 
  803f58:	41 ff d0             	callq  *%r8
  803f5b:	e9 4a ff ff ff       	jmpq   803eaa <_pipeisclosed+0x11>
  803f60:	e9 45 ff ff ff       	jmpq   803eaa <_pipeisclosed+0x11>
  803f65:	48 83 c4 28          	add    $0x28,%rsp
  803f69:	5b                   	pop    %rbx
  803f6a:	5d                   	pop    %rbp
  803f6b:	c3                   	retq   

0000000000803f6c <pipeisclosed>:
  803f6c:	55                   	push   %rbp
  803f6d:	48 89 e5             	mov    %rsp,%rbp
  803f70:	48 83 ec 30          	sub    $0x30,%rsp
  803f74:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803f77:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803f7b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803f7e:	48 89 d6             	mov    %rdx,%rsi
  803f81:	89 c7                	mov    %eax,%edi
  803f83:	48 b8 4e 22 80 00 00 	movabs $0x80224e,%rax
  803f8a:	00 00 00 
  803f8d:	ff d0                	callq  *%rax
  803f8f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f92:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f96:	79 05                	jns    803f9d <pipeisclosed+0x31>
  803f98:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f9b:	eb 31                	jmp    803fce <pipeisclosed+0x62>
  803f9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803fa1:	48 89 c7             	mov    %rax,%rdi
  803fa4:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  803fab:	00 00 00 
  803fae:	ff d0                	callq  *%rax
  803fb0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803fb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803fb8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803fbc:	48 89 d6             	mov    %rdx,%rsi
  803fbf:	48 89 c7             	mov    %rax,%rdi
  803fc2:	48 b8 99 3e 80 00 00 	movabs $0x803e99,%rax
  803fc9:	00 00 00 
  803fcc:	ff d0                	callq  *%rax
  803fce:	c9                   	leaveq 
  803fcf:	c3                   	retq   

0000000000803fd0 <devpipe_read>:
  803fd0:	55                   	push   %rbp
  803fd1:	48 89 e5             	mov    %rsp,%rbp
  803fd4:	48 83 ec 40          	sub    $0x40,%rsp
  803fd8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803fdc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803fe0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803fe4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fe8:	48 89 c7             	mov    %rax,%rdi
  803feb:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  803ff2:	00 00 00 
  803ff5:	ff d0                	callq  *%rax
  803ff7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803ffb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fff:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804003:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80400a:	00 
  80400b:	e9 92 00 00 00       	jmpq   8040a2 <devpipe_read+0xd2>
  804010:	eb 41                	jmp    804053 <devpipe_read+0x83>
  804012:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804017:	74 09                	je     804022 <devpipe_read+0x52>
  804019:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80401d:	e9 92 00 00 00       	jmpq   8040b4 <devpipe_read+0xe4>
  804022:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804026:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80402a:	48 89 d6             	mov    %rdx,%rsi
  80402d:	48 89 c7             	mov    %rax,%rdi
  804030:	48 b8 99 3e 80 00 00 	movabs $0x803e99,%rax
  804037:	00 00 00 
  80403a:	ff d0                	callq  *%rax
  80403c:	85 c0                	test   %eax,%eax
  80403e:	74 07                	je     804047 <devpipe_read+0x77>
  804040:	b8 00 00 00 00       	mov    $0x0,%eax
  804045:	eb 6d                	jmp    8040b4 <devpipe_read+0xe4>
  804047:	48 b8 4a 1d 80 00 00 	movabs $0x801d4a,%rax
  80404e:	00 00 00 
  804051:	ff d0                	callq  *%rax
  804053:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804057:	8b 10                	mov    (%rax),%edx
  804059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80405d:	8b 40 04             	mov    0x4(%rax),%eax
  804060:	39 c2                	cmp    %eax,%edx
  804062:	74 ae                	je     804012 <devpipe_read+0x42>
  804064:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804068:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80406c:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  804070:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804074:	8b 00                	mov    (%rax),%eax
  804076:	99                   	cltd   
  804077:	c1 ea 1b             	shr    $0x1b,%edx
  80407a:	01 d0                	add    %edx,%eax
  80407c:	83 e0 1f             	and    $0x1f,%eax
  80407f:	29 d0                	sub    %edx,%eax
  804081:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804085:	48 98                	cltq   
  804087:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  80408c:	88 01                	mov    %al,(%rcx)
  80408e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804092:	8b 00                	mov    (%rax),%eax
  804094:	8d 50 01             	lea    0x1(%rax),%edx
  804097:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80409b:	89 10                	mov    %edx,(%rax)
  80409d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8040a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040a6:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8040aa:	0f 82 60 ff ff ff    	jb     804010 <devpipe_read+0x40>
  8040b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040b4:	c9                   	leaveq 
  8040b5:	c3                   	retq   

00000000008040b6 <devpipe_write>:
  8040b6:	55                   	push   %rbp
  8040b7:	48 89 e5             	mov    %rsp,%rbp
  8040ba:	48 83 ec 40          	sub    $0x40,%rsp
  8040be:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8040c2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8040c6:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8040ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040ce:	48 89 c7             	mov    %rax,%rdi
  8040d1:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  8040d8:	00 00 00 
  8040db:	ff d0                	callq  *%rax
  8040dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8040e1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040e5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8040e9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8040f0:	00 
  8040f1:	e9 8e 00 00 00       	jmpq   804184 <devpipe_write+0xce>
  8040f6:	eb 31                	jmp    804129 <devpipe_write+0x73>
  8040f8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8040fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804100:	48 89 d6             	mov    %rdx,%rsi
  804103:	48 89 c7             	mov    %rax,%rdi
  804106:	48 b8 99 3e 80 00 00 	movabs $0x803e99,%rax
  80410d:	00 00 00 
  804110:	ff d0                	callq  *%rax
  804112:	85 c0                	test   %eax,%eax
  804114:	74 07                	je     80411d <devpipe_write+0x67>
  804116:	b8 00 00 00 00       	mov    $0x0,%eax
  80411b:	eb 79                	jmp    804196 <devpipe_write+0xe0>
  80411d:	48 b8 4a 1d 80 00 00 	movabs $0x801d4a,%rax
  804124:	00 00 00 
  804127:	ff d0                	callq  *%rax
  804129:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80412d:	8b 40 04             	mov    0x4(%rax),%eax
  804130:	48 63 d0             	movslq %eax,%rdx
  804133:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804137:	8b 00                	mov    (%rax),%eax
  804139:	48 98                	cltq   
  80413b:	48 83 c0 20          	add    $0x20,%rax
  80413f:	48 39 c2             	cmp    %rax,%rdx
  804142:	73 b4                	jae    8040f8 <devpipe_write+0x42>
  804144:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804148:	8b 40 04             	mov    0x4(%rax),%eax
  80414b:	99                   	cltd   
  80414c:	c1 ea 1b             	shr    $0x1b,%edx
  80414f:	01 d0                	add    %edx,%eax
  804151:	83 e0 1f             	and    $0x1f,%eax
  804154:	29 d0                	sub    %edx,%eax
  804156:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80415a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80415e:	48 01 ca             	add    %rcx,%rdx
  804161:	0f b6 0a             	movzbl (%rdx),%ecx
  804164:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804168:	48 98                	cltq   
  80416a:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80416e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804172:	8b 40 04             	mov    0x4(%rax),%eax
  804175:	8d 50 01             	lea    0x1(%rax),%edx
  804178:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80417c:	89 50 04             	mov    %edx,0x4(%rax)
  80417f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804184:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804188:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80418c:	0f 82 64 ff ff ff    	jb     8040f6 <devpipe_write+0x40>
  804192:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804196:	c9                   	leaveq 
  804197:	c3                   	retq   

0000000000804198 <devpipe_stat>:
  804198:	55                   	push   %rbp
  804199:	48 89 e5             	mov    %rsp,%rbp
  80419c:	48 83 ec 20          	sub    $0x20,%rsp
  8041a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8041a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8041a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8041ac:	48 89 c7             	mov    %rax,%rdi
  8041af:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  8041b6:	00 00 00 
  8041b9:	ff d0                	callq  *%rax
  8041bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8041bf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8041c3:	48 be 86 4c 80 00 00 	movabs $0x804c86,%rsi
  8041ca:	00 00 00 
  8041cd:	48 89 c7             	mov    %rax,%rdi
  8041d0:	48 b8 59 14 80 00 00 	movabs $0x801459,%rax
  8041d7:	00 00 00 
  8041da:	ff d0                	callq  *%rax
  8041dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041e0:	8b 50 04             	mov    0x4(%rax),%edx
  8041e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041e7:	8b 00                	mov    (%rax),%eax
  8041e9:	29 c2                	sub    %eax,%edx
  8041eb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8041ef:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8041f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8041f9:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804200:	00 00 00 
  804203:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804207:	48 b9 00 61 80 00 00 	movabs $0x806100,%rcx
  80420e:	00 00 00 
  804211:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804218:	b8 00 00 00 00       	mov    $0x0,%eax
  80421d:	c9                   	leaveq 
  80421e:	c3                   	retq   

000000000080421f <devpipe_close>:
  80421f:	55                   	push   %rbp
  804220:	48 89 e5             	mov    %rsp,%rbp
  804223:	48 83 ec 10          	sub    $0x10,%rsp
  804227:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80422b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80422f:	48 89 c6             	mov    %rax,%rsi
  804232:	bf 00 00 00 00       	mov    $0x0,%edi
  804237:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  80423e:	00 00 00 
  804241:	ff d0                	callq  *%rax
  804243:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804247:	48 89 c7             	mov    %rax,%rdi
  80424a:	48 b8 8b 21 80 00 00 	movabs $0x80218b,%rax
  804251:	00 00 00 
  804254:	ff d0                	callq  *%rax
  804256:	48 89 c6             	mov    %rax,%rsi
  804259:	bf 00 00 00 00       	mov    $0x0,%edi
  80425e:	48 b8 33 1e 80 00 00 	movabs $0x801e33,%rax
  804265:	00 00 00 
  804268:	ff d0                	callq  *%rax
  80426a:	c9                   	leaveq 
  80426b:	c3                   	retq   

000000000080426c <ipc_recv>:
  80426c:	55                   	push   %rbp
  80426d:	48 89 e5             	mov    %rsp,%rbp
  804270:	48 83 ec 30          	sub    $0x30,%rsp
  804274:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804278:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80427c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804280:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804285:	75 0e                	jne    804295 <ipc_recv+0x29>
  804287:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80428e:	00 00 00 
  804291:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804295:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804299:	48 89 c7             	mov    %rax,%rdi
  80429c:	48 b8 b1 1f 80 00 00 	movabs $0x801fb1,%rax
  8042a3:	00 00 00 
  8042a6:	ff d0                	callq  *%rax
  8042a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8042ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8042af:	79 27                	jns    8042d8 <ipc_recv+0x6c>
  8042b1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8042b6:	74 0a                	je     8042c2 <ipc_recv+0x56>
  8042b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042bc:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8042c2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8042c7:	74 0a                	je     8042d3 <ipc_recv+0x67>
  8042c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8042cd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8042d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8042d6:	eb 53                	jmp    80432b <ipc_recv+0xbf>
  8042d8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8042dd:	74 19                	je     8042f8 <ipc_recv+0x8c>
  8042df:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  8042e6:	00 00 00 
  8042e9:	48 8b 00             	mov    (%rax),%rax
  8042ec:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8042f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8042f6:	89 10                	mov    %edx,(%rax)
  8042f8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8042fd:	74 19                	je     804318 <ipc_recv+0xac>
  8042ff:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  804306:	00 00 00 
  804309:	48 8b 00             	mov    (%rax),%rax
  80430c:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804312:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804316:	89 10                	mov    %edx,(%rax)
  804318:	48 b8 08 74 80 00 00 	movabs $0x807408,%rax
  80431f:	00 00 00 
  804322:	48 8b 00             	mov    (%rax),%rax
  804325:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  80432b:	c9                   	leaveq 
  80432c:	c3                   	retq   

000000000080432d <ipc_send>:
  80432d:	55                   	push   %rbp
  80432e:	48 89 e5             	mov    %rsp,%rbp
  804331:	48 83 ec 30          	sub    $0x30,%rsp
  804335:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804338:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80433b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  80433f:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804342:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804347:	75 10                	jne    804359 <ipc_send+0x2c>
  804349:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804350:	00 00 00 
  804353:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804357:	eb 0e                	jmp    804367 <ipc_send+0x3a>
  804359:	eb 0c                	jmp    804367 <ipc_send+0x3a>
  80435b:	48 b8 4a 1d 80 00 00 	movabs $0x801d4a,%rax
  804362:	00 00 00 
  804365:	ff d0                	callq  *%rax
  804367:	8b 75 e8             	mov    -0x18(%rbp),%esi
  80436a:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  80436d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804371:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804374:	89 c7                	mov    %eax,%edi
  804376:	48 b8 5c 1f 80 00 00 	movabs $0x801f5c,%rax
  80437d:	00 00 00 
  804380:	ff d0                	callq  *%rax
  804382:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804385:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804389:	74 d0                	je     80435b <ipc_send+0x2e>
  80438b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80438f:	79 30                	jns    8043c1 <ipc_send+0x94>
  804391:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804394:	89 c1                	mov    %eax,%ecx
  804396:	48 ba 90 4c 80 00 00 	movabs $0x804c90,%rdx
  80439d:	00 00 00 
  8043a0:	be 44 00 00 00       	mov    $0x44,%esi
  8043a5:	48 bf a6 4c 80 00 00 	movabs $0x804ca6,%rdi
  8043ac:	00 00 00 
  8043af:	b8 00 00 00 00       	mov    $0x0,%eax
  8043b4:	49 b8 11 05 80 00 00 	movabs $0x800511,%r8
  8043bb:	00 00 00 
  8043be:	41 ff d0             	callq  *%r8
  8043c1:	c9                   	leaveq 
  8043c2:	c3                   	retq   

00000000008043c3 <ipc_host_recv>:
  8043c3:	55                   	push   %rbp
  8043c4:	48 89 e5             	mov    %rsp,%rbp
  8043c7:	48 83 ec 10          	sub    $0x10,%rsp
  8043cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8043cf:	48 ba b8 4c 80 00 00 	movabs $0x804cb8,%rdx
  8043d6:	00 00 00 
  8043d9:	be 4e 00 00 00       	mov    $0x4e,%esi
  8043de:	48 bf a6 4c 80 00 00 	movabs $0x804ca6,%rdi
  8043e5:	00 00 00 
  8043e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8043ed:	48 b9 11 05 80 00 00 	movabs $0x800511,%rcx
  8043f4:	00 00 00 
  8043f7:	ff d1                	callq  *%rcx

00000000008043f9 <ipc_host_send>:
  8043f9:	55                   	push   %rbp
  8043fa:	48 89 e5             	mov    %rsp,%rbp
  8043fd:	48 83 ec 20          	sub    $0x20,%rsp
  804401:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804404:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804407:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80440b:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80440e:	48 ba d8 4c 80 00 00 	movabs $0x804cd8,%rdx
  804415:	00 00 00 
  804418:	be 67 00 00 00       	mov    $0x67,%esi
  80441d:	48 bf a6 4c 80 00 00 	movabs $0x804ca6,%rdi
  804424:	00 00 00 
  804427:	b8 00 00 00 00       	mov    $0x0,%eax
  80442c:	48 b9 11 05 80 00 00 	movabs $0x800511,%rcx
  804433:	00 00 00 
  804436:	ff d1                	callq  *%rcx

0000000000804438 <ipc_find_env>:
  804438:	55                   	push   %rbp
  804439:	48 89 e5             	mov    %rsp,%rbp
  80443c:	48 83 ec 14          	sub    $0x14,%rsp
  804440:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804443:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80444a:	eb 4e                	jmp    80449a <ipc_find_env+0x62>
  80444c:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804453:	00 00 00 
  804456:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804459:	48 98                	cltq   
  80445b:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804462:	48 01 d0             	add    %rdx,%rax
  804465:	48 05 d0 00 00 00    	add    $0xd0,%rax
  80446b:	8b 00                	mov    (%rax),%eax
  80446d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804470:	75 24                	jne    804496 <ipc_find_env+0x5e>
  804472:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804479:	00 00 00 
  80447c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80447f:	48 98                	cltq   
  804481:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804488:	48 01 d0             	add    %rdx,%rax
  80448b:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804491:	8b 40 08             	mov    0x8(%rax),%eax
  804494:	eb 12                	jmp    8044a8 <ipc_find_env+0x70>
  804496:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80449a:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8044a1:	7e a9                	jle    80444c <ipc_find_env+0x14>
  8044a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8044a8:	c9                   	leaveq 
  8044a9:	c3                   	retq   

00000000008044aa <pageref>:
  8044aa:	55                   	push   %rbp
  8044ab:	48 89 e5             	mov    %rsp,%rbp
  8044ae:	48 83 ec 18          	sub    $0x18,%rsp
  8044b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8044b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044ba:	48 c1 e8 15          	shr    $0x15,%rax
  8044be:	48 89 c2             	mov    %rax,%rdx
  8044c1:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8044c8:	01 00 00 
  8044cb:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8044cf:	83 e0 01             	and    $0x1,%eax
  8044d2:	48 85 c0             	test   %rax,%rax
  8044d5:	75 07                	jne    8044de <pageref+0x34>
  8044d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8044dc:	eb 53                	jmp    804531 <pageref+0x87>
  8044de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044e2:	48 c1 e8 0c          	shr    $0xc,%rax
  8044e6:	48 89 c2             	mov    %rax,%rdx
  8044e9:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8044f0:	01 00 00 
  8044f3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8044f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8044fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8044ff:	83 e0 01             	and    $0x1,%eax
  804502:	48 85 c0             	test   %rax,%rax
  804505:	75 07                	jne    80450e <pageref+0x64>
  804507:	b8 00 00 00 00       	mov    $0x0,%eax
  80450c:	eb 23                	jmp    804531 <pageref+0x87>
  80450e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804512:	48 c1 e8 0c          	shr    $0xc,%rax
  804516:	48 89 c2             	mov    %rax,%rdx
  804519:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804520:	00 00 00 
  804523:	48 c1 e2 04          	shl    $0x4,%rdx
  804527:	48 01 d0             	add    %rdx,%rax
  80452a:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  80452e:	0f b7 c0             	movzwl %ax,%eax
  804531:	c9                   	leaveq 
  804532:	c3                   	retq   
