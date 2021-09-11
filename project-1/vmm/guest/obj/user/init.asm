
vmm/guest/obj/user/init:     file format elf64-x86-64


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
  80003c:	e8 69 06 00 00       	callq  8006aa <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <sum>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 1c          	sub    $0x1c,%rsp
  80004b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80004f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800052:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  800059:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800060:	eb 1e                	jmp    800080 <sum+0x3d>
  800062:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800065:	48 63 d0             	movslq %eax,%rdx
  800068:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80006c:	48 01 d0             	add    %rdx,%rax
  80006f:	0f b6 00             	movzbl (%rax),%eax
  800072:	0f be c0             	movsbl %al,%eax
  800075:	0f af 45 fc          	imul   -0x4(%rbp),%eax
  800079:	31 45 f8             	xor    %eax,-0x8(%rbp)
  80007c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800080:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800083:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  800086:	7c da                	jl     800062 <sum+0x1f>
  800088:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80008b:	c9                   	leaveq 
  80008c:	c3                   	retq   

000000000080008d <umain>:
  80008d:	55                   	push   %rbp
  80008e:	48 89 e5             	mov    %rsp,%rbp
  800091:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  800098:	89 bd ec fe ff ff    	mov    %edi,-0x114(%rbp)
  80009e:	48 89 b5 e0 fe ff ff 	mov    %rsi,-0x120(%rbp)
  8000a5:	48 bf 20 4f 80 00 00 	movabs $0x804f20,%rdi
  8000ac:	00 00 00 
  8000af:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b4:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  8000bb:	00 00 00 
  8000be:	ff d2                	callq  *%rdx
  8000c0:	c7 45 f8 9e 98 0f 00 	movl   $0xf989e,-0x8(%rbp)
  8000c7:	be 70 17 00 00       	mov    $0x1770,%esi
  8000cc:	48 bf 00 70 80 00 00 	movabs $0x807000,%rdi
  8000d3:	00 00 00 
  8000d6:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8000dd:	00 00 00 
  8000e0:	ff d0                	callq  *%rax
  8000e2:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8000e5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8000e8:	3b 45 f8             	cmp    -0x8(%rbp),%eax
  8000eb:	74 25                	je     800112 <umain+0x85>
  8000ed:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8000f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8000f3:	89 c6                	mov    %eax,%esi
  8000f5:	48 bf 30 4f 80 00 00 	movabs $0x804f30,%rdi
  8000fc:	00 00 00 
  8000ff:	b8 00 00 00 00       	mov    $0x0,%eax
  800104:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  80010b:	00 00 00 
  80010e:	ff d1                	callq  *%rcx
  800110:	eb 1b                	jmp    80012d <umain+0xa0>
  800112:	48 bf 69 4f 80 00 00 	movabs $0x804f69,%rdi
  800119:	00 00 00 
  80011c:	b8 00 00 00 00       	mov    $0x0,%eax
  800121:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  800128:	00 00 00 
  80012b:	ff d2                	callq  *%rdx
  80012d:	be 70 17 00 00       	mov    $0x1770,%esi
  800132:	48 bf 20 90 80 00 00 	movabs $0x809020,%rdi
  800139:	00 00 00 
  80013c:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800143:	00 00 00 
  800146:	ff d0                	callq  *%rax
  800148:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80014b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80014f:	74 22                	je     800173 <umain+0xe6>
  800151:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800154:	89 c6                	mov    %eax,%esi
  800156:	48 bf 80 4f 80 00 00 	movabs $0x804f80,%rdi
  80015d:	00 00 00 
  800160:	b8 00 00 00 00       	mov    $0x0,%eax
  800165:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  80016c:	00 00 00 
  80016f:	ff d2                	callq  *%rdx
  800171:	eb 1b                	jmp    80018e <umain+0x101>
  800173:	48 bf af 4f 80 00 00 	movabs $0x804faf,%rdi
  80017a:	00 00 00 
  80017d:	b8 00 00 00 00       	mov    $0x0,%eax
  800182:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  800189:	00 00 00 
  80018c:	ff d2                	callq  *%rdx
  80018e:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800195:	48 be c5 4f 80 00 00 	movabs $0x804fc5,%rsi
  80019c:	00 00 00 
  80019f:	48 89 c7             	mov    %rax,%rdi
  8001a2:	48 b8 81 15 80 00 00 	movabs $0x801581,%rax
  8001a9:	00 00 00 
  8001ac:	ff d0                	callq  *%rax
  8001ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8001b5:	eb 77                	jmp    80022e <umain+0x1a1>
  8001b7:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8001be:	48 be d1 4f 80 00 00 	movabs $0x804fd1,%rsi
  8001c5:	00 00 00 
  8001c8:	48 89 c7             	mov    %rax,%rdi
  8001cb:	48 b8 81 15 80 00 00 	movabs $0x801581,%rax
  8001d2:	00 00 00 
  8001d5:	ff d0                	callq  *%rax
  8001d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8001da:	48 98                	cltq   
  8001dc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8001e3:	00 
  8001e4:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
  8001eb:	48 01 d0             	add    %rdx,%rax
  8001ee:	48 8b 10             	mov    (%rax),%rdx
  8001f1:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8001f8:	48 89 d6             	mov    %rdx,%rsi
  8001fb:	48 89 c7             	mov    %rax,%rdi
  8001fe:	48 b8 81 15 80 00 00 	movabs $0x801581,%rax
  800205:	00 00 00 
  800208:	ff d0                	callq  *%rax
  80020a:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800211:	48 be d4 4f 80 00 00 	movabs $0x804fd4,%rsi
  800218:	00 00 00 
  80021b:	48 89 c7             	mov    %rax,%rdi
  80021e:	48 b8 81 15 80 00 00 	movabs $0x801581,%rax
  800225:	00 00 00 
  800228:	ff d0                	callq  *%rax
  80022a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80022e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800231:	3b 85 ec fe ff ff    	cmp    -0x114(%rbp),%eax
  800237:	0f 8c 7a ff ff ff    	jl     8001b7 <umain+0x12a>
  80023d:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800244:	48 89 c6             	mov    %rax,%rsi
  800247:	48 bf d6 4f 80 00 00 	movabs $0x804fd6,%rdi
  80024e:	00 00 00 
  800251:	b8 00 00 00 00       	mov    $0x0,%eax
  800256:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  80025d:	00 00 00 
  800260:	ff d2                	callq  *%rdx
  800262:	48 bf da 4f 80 00 00 	movabs $0x804fda,%rdi
  800269:	00 00 00 
  80026c:	b8 00 00 00 00       	mov    $0x0,%eax
  800271:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  800278:	00 00 00 
  80027b:	ff d2                	callq  *%rdx
  80027d:	bf 00 00 00 00       	mov    $0x0,%edi
  800282:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  800289:	00 00 00 
  80028c:	ff d0                	callq  *%rax
  80028e:	48 b8 b8 04 80 00 00 	movabs $0x8004b8,%rax
  800295:	00 00 00 
  800298:	ff d0                	callq  *%rax
  80029a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80029d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8002a1:	79 30                	jns    8002d3 <umain+0x246>
  8002a3:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002a6:	89 c1                	mov    %eax,%ecx
  8002a8:	48 ba ec 4f 80 00 00 	movabs $0x804fec,%rdx
  8002af:	00 00 00 
  8002b2:	be 39 00 00 00       	mov    $0x39,%esi
  8002b7:	48 bf f9 4f 80 00 00 	movabs $0x804ff9,%rdi
  8002be:	00 00 00 
  8002c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8002c6:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  8002cd:	00 00 00 
  8002d0:	41 ff d0             	callq  *%r8
  8002d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8002d7:	74 30                	je     800309 <umain+0x27c>
  8002d9:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002dc:	89 c1                	mov    %eax,%ecx
  8002de:	48 ba 08 50 80 00 00 	movabs $0x805008,%rdx
  8002e5:	00 00 00 
  8002e8:	be 3b 00 00 00       	mov    $0x3b,%esi
  8002ed:	48 bf f9 4f 80 00 00 	movabs $0x804ff9,%rdi
  8002f4:	00 00 00 
  8002f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8002fc:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  800303:	00 00 00 
  800306:	41 ff d0             	callq  *%r8
  800309:	be 01 00 00 00       	mov    $0x1,%esi
  80030e:	bf 00 00 00 00       	mov    $0x0,%edi
  800313:	48 b8 bc 25 80 00 00 	movabs $0x8025bc,%rax
  80031a:	00 00 00 
  80031d:	ff d0                	callq  *%rax
  80031f:	89 45 f0             	mov    %eax,-0x10(%rbp)
  800322:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  800326:	79 30                	jns    800358 <umain+0x2cb>
  800328:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80032b:	89 c1                	mov    %eax,%ecx
  80032d:	48 ba 22 50 80 00 00 	movabs $0x805022,%rdx
  800334:	00 00 00 
  800337:	be 3d 00 00 00       	mov    $0x3d,%esi
  80033c:	48 bf f9 4f 80 00 00 	movabs $0x804ff9,%rdi
  800343:	00 00 00 
  800346:	b8 00 00 00 00       	mov    $0x0,%eax
  80034b:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  800352:	00 00 00 
  800355:	41 ff d0             	callq  *%r8
  800358:	48 bf 2a 50 80 00 00 	movabs $0x80502a,%rdi
  80035f:	00 00 00 
  800362:	b8 00 00 00 00       	mov    $0x0,%eax
  800367:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  80036e:	00 00 00 
  800371:	ff d2                	callq  *%rdx
  800373:	ba 00 00 00 00       	mov    $0x0,%edx
  800378:	48 be 3d 50 80 00 00 	movabs $0x80503d,%rsi
  80037f:	00 00 00 
  800382:	48 bf 40 50 80 00 00 	movabs $0x805040,%rdi
  800389:	00 00 00 
  80038c:	b8 00 00 00 00       	mov    $0x0,%eax
  800391:	48 b9 cb 35 80 00 00 	movabs $0x8035cb,%rcx
  800398:	00 00 00 
  80039b:	ff d1                	callq  *%rcx
  80039d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8003a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8003a4:	79 22                	jns    8003c8 <umain+0x33b>
  8003a6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8003a9:	89 c6                	mov    %eax,%esi
  8003ab:	48 bf 48 50 80 00 00 	movabs $0x805048,%rdi
  8003b2:	00 00 00 
  8003b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8003ba:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  8003c1:	00 00 00 
  8003c4:	ff d2                	callq  *%rdx
  8003c6:	eb 90                	jmp    800358 <umain+0x2cb>
  8003c8:	48 bf 5c 50 80 00 00 	movabs $0x80505c,%rdi
  8003cf:	00 00 00 
  8003d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8003d7:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  8003de:	00 00 00 
  8003e1:	ff d2                	callq  *%rdx
  8003e3:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8003e6:	89 c7                	mov    %eax,%edi
  8003e8:	48 b8 b7 4b 80 00 00 	movabs $0x804bb7,%rax
  8003ef:	00 00 00 
  8003f2:	ff d0                	callq  *%rax
  8003f4:	90                   	nop
  8003f5:	c9                   	leaveq 
  8003f6:	c3                   	retq   

00000000008003f7 <cputchar>:
  8003f7:	55                   	push   %rbp
  8003f8:	48 89 e5             	mov    %rsp,%rbp
  8003fb:	48 83 ec 20          	sub    $0x20,%rsp
  8003ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800402:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800405:	88 45 ff             	mov    %al,-0x1(%rbp)
  800408:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  80040c:	be 01 00 00 00       	mov    $0x1,%esi
  800411:	48 89 c7             	mov    %rax,%rdi
  800414:	48 b8 25 1d 80 00 00 	movabs $0x801d25,%rax
  80041b:	00 00 00 
  80041e:	ff d0                	callq  *%rax
  800420:	c9                   	leaveq 
  800421:	c3                   	retq   

0000000000800422 <getchar>:
  800422:	55                   	push   %rbp
  800423:	48 89 e5             	mov    %rsp,%rbp
  800426:	48 83 ec 10          	sub    $0x10,%rsp
  80042a:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  80042e:	ba 01 00 00 00       	mov    $0x1,%edx
  800433:	48 89 c6             	mov    %rax,%rsi
  800436:	bf 00 00 00 00       	mov    $0x0,%edi
  80043b:	48 b8 65 27 80 00 00 	movabs $0x802765,%rax
  800442:	00 00 00 
  800445:	ff d0                	callq  *%rax
  800447:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80044a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80044e:	79 05                	jns    800455 <getchar+0x33>
  800450:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800453:	eb 14                	jmp    800469 <getchar+0x47>
  800455:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800459:	7f 07                	jg     800462 <getchar+0x40>
  80045b:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  800460:	eb 07                	jmp    800469 <getchar+0x47>
  800462:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  800466:	0f b6 c0             	movzbl %al,%eax
  800469:	c9                   	leaveq 
  80046a:	c3                   	retq   

000000000080046b <iscons>:
  80046b:	55                   	push   %rbp
  80046c:	48 89 e5             	mov    %rsp,%rbp
  80046f:	48 83 ec 20          	sub    $0x20,%rsp
  800473:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800476:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80047a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80047d:	48 89 d6             	mov    %rdx,%rsi
  800480:	89 c7                	mov    %eax,%edi
  800482:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  800489:	00 00 00 
  80048c:	ff d0                	callq  *%rax
  80048e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800491:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800495:	79 05                	jns    80049c <iscons+0x31>
  800497:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80049a:	eb 1a                	jmp    8004b6 <iscons+0x4b>
  80049c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8004a0:	8b 10                	mov    (%rax),%edx
  8004a2:	48 b8 80 87 80 00 00 	movabs $0x808780,%rax
  8004a9:	00 00 00 
  8004ac:	8b 00                	mov    (%rax),%eax
  8004ae:	39 c2                	cmp    %eax,%edx
  8004b0:	0f 94 c0             	sete   %al
  8004b3:	0f b6 c0             	movzbl %al,%eax
  8004b6:	c9                   	leaveq 
  8004b7:	c3                   	retq   

00000000008004b8 <opencons>:
  8004b8:	55                   	push   %rbp
  8004b9:	48 89 e5             	mov    %rsp,%rbp
  8004bc:	48 83 ec 10          	sub    $0x10,%rsp
  8004c0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8004c4:	48 89 c7             	mov    %rax,%rdi
  8004c7:	48 b8 9b 22 80 00 00 	movabs $0x80229b,%rax
  8004ce:	00 00 00 
  8004d1:	ff d0                	callq  *%rax
  8004d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8004d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8004da:	79 05                	jns    8004e1 <opencons+0x29>
  8004dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8004df:	eb 5b                	jmp    80053c <opencons+0x84>
  8004e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8004e5:	ba 07 04 00 00       	mov    $0x407,%edx
  8004ea:	48 89 c6             	mov    %rax,%rsi
  8004ed:	bf 00 00 00 00       	mov    $0x0,%edi
  8004f2:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  8004f9:	00 00 00 
  8004fc:	ff d0                	callq  *%rax
  8004fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800501:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800505:	79 05                	jns    80050c <opencons+0x54>
  800507:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80050a:	eb 30                	jmp    80053c <opencons+0x84>
  80050c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800510:	48 ba 80 87 80 00 00 	movabs $0x808780,%rdx
  800517:	00 00 00 
  80051a:	8b 12                	mov    (%rdx),%edx
  80051c:	89 10                	mov    %edx,(%rax)
  80051e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800522:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  800529:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80052d:	48 89 c7             	mov    %rax,%rdi
  800530:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  800537:	00 00 00 
  80053a:	ff d0                	callq  *%rax
  80053c:	c9                   	leaveq 
  80053d:	c3                   	retq   

000000000080053e <devcons_read>:
  80053e:	55                   	push   %rbp
  80053f:	48 89 e5             	mov    %rsp,%rbp
  800542:	48 83 ec 30          	sub    $0x30,%rsp
  800546:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80054a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80054e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800552:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800557:	75 07                	jne    800560 <devcons_read+0x22>
  800559:	b8 00 00 00 00       	mov    $0x0,%eax
  80055e:	eb 4b                	jmp    8005ab <devcons_read+0x6d>
  800560:	eb 0c                	jmp    80056e <devcons_read+0x30>
  800562:	48 b8 2f 1e 80 00 00 	movabs $0x801e2f,%rax
  800569:	00 00 00 
  80056c:	ff d0                	callq  *%rax
  80056e:	48 b8 6f 1d 80 00 00 	movabs $0x801d6f,%rax
  800575:	00 00 00 
  800578:	ff d0                	callq  *%rax
  80057a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80057d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800581:	74 df                	je     800562 <devcons_read+0x24>
  800583:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800587:	79 05                	jns    80058e <devcons_read+0x50>
  800589:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80058c:	eb 1d                	jmp    8005ab <devcons_read+0x6d>
  80058e:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  800592:	75 07                	jne    80059b <devcons_read+0x5d>
  800594:	b8 00 00 00 00       	mov    $0x0,%eax
  800599:	eb 10                	jmp    8005ab <devcons_read+0x6d>
  80059b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80059e:	89 c2                	mov    %eax,%edx
  8005a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8005a4:	88 10                	mov    %dl,(%rax)
  8005a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8005ab:	c9                   	leaveq 
  8005ac:	c3                   	retq   

00000000008005ad <devcons_write>:
  8005ad:	55                   	push   %rbp
  8005ae:	48 89 e5             	mov    %rsp,%rbp
  8005b1:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  8005b8:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8005bf:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8005c6:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8005cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8005d4:	eb 76                	jmp    80064c <devcons_write+0x9f>
  8005d6:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8005dd:	89 c2                	mov    %eax,%edx
  8005df:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8005e2:	29 c2                	sub    %eax,%edx
  8005e4:	89 d0                	mov    %edx,%eax
  8005e6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8005e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8005ec:	83 f8 7f             	cmp    $0x7f,%eax
  8005ef:	76 07                	jbe    8005f8 <devcons_write+0x4b>
  8005f1:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8005f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8005fb:	48 63 d0             	movslq %eax,%rdx
  8005fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800601:	48 63 c8             	movslq %eax,%rcx
  800604:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  80060b:	48 01 c1             	add    %rax,%rcx
  80060e:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  800615:	48 89 ce             	mov    %rcx,%rsi
  800618:	48 89 c7             	mov    %rax,%rdi
  80061b:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  800622:	00 00 00 
  800625:	ff d0                	callq  *%rax
  800627:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80062a:	48 63 d0             	movslq %eax,%rdx
  80062d:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  800634:	48 89 d6             	mov    %rdx,%rsi
  800637:	48 89 c7             	mov    %rax,%rdi
  80063a:	48 b8 25 1d 80 00 00 	movabs $0x801d25,%rax
  800641:	00 00 00 
  800644:	ff d0                	callq  *%rax
  800646:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800649:	01 45 fc             	add    %eax,-0x4(%rbp)
  80064c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80064f:	48 98                	cltq   
  800651:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  800658:	0f 82 78 ff ff ff    	jb     8005d6 <devcons_write+0x29>
  80065e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800661:	c9                   	leaveq 
  800662:	c3                   	retq   

0000000000800663 <devcons_close>:
  800663:	55                   	push   %rbp
  800664:	48 89 e5             	mov    %rsp,%rbp
  800667:	48 83 ec 08          	sub    $0x8,%rsp
  80066b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80066f:	b8 00 00 00 00       	mov    $0x0,%eax
  800674:	c9                   	leaveq 
  800675:	c3                   	retq   

0000000000800676 <devcons_stat>:
  800676:	55                   	push   %rbp
  800677:	48 89 e5             	mov    %rsp,%rbp
  80067a:	48 83 ec 10          	sub    $0x10,%rsp
  80067e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800682:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800686:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80068a:	48 be 6f 50 80 00 00 	movabs $0x80506f,%rsi
  800691:	00 00 00 
  800694:	48 89 c7             	mov    %rax,%rdi
  800697:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  80069e:	00 00 00 
  8006a1:	ff d0                	callq  *%rax
  8006a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8006a8:	c9                   	leaveq 
  8006a9:	c3                   	retq   

00000000008006aa <libmain>:
  8006aa:	55                   	push   %rbp
  8006ab:	48 89 e5             	mov    %rsp,%rbp
  8006ae:	48 83 ec 10          	sub    $0x10,%rsp
  8006b2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8006b5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8006b9:	48 b8 f1 1d 80 00 00 	movabs $0x801df1,%rax
  8006c0:	00 00 00 
  8006c3:	ff d0                	callq  *%rax
  8006c5:	25 ff 03 00 00       	and    $0x3ff,%eax
  8006ca:	48 98                	cltq   
  8006cc:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8006d3:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8006da:	00 00 00 
  8006dd:	48 01 c2             	add    %rax,%rdx
  8006e0:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  8006e7:	00 00 00 
  8006ea:	48 89 10             	mov    %rdx,(%rax)
  8006ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8006f1:	7e 14                	jle    800707 <libmain+0x5d>
  8006f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8006f7:	48 8b 10             	mov    (%rax),%rdx
  8006fa:	48 b8 b8 87 80 00 00 	movabs $0x8087b8,%rax
  800701:	00 00 00 
  800704:	48 89 10             	mov    %rdx,(%rax)
  800707:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80070b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80070e:	48 89 d6             	mov    %rdx,%rsi
  800711:	89 c7                	mov    %eax,%edi
  800713:	48 b8 8d 00 80 00 00 	movabs $0x80008d,%rax
  80071a:	00 00 00 
  80071d:	ff d0                	callq  *%rax
  80071f:	48 b8 2d 07 80 00 00 	movabs $0x80072d,%rax
  800726:	00 00 00 
  800729:	ff d0                	callq  *%rax
  80072b:	c9                   	leaveq 
  80072c:	c3                   	retq   

000000000080072d <exit>:
  80072d:	55                   	push   %rbp
  80072e:	48 89 e5             	mov    %rsp,%rbp
  800731:	48 b8 8e 25 80 00 00 	movabs $0x80258e,%rax
  800738:	00 00 00 
  80073b:	ff d0                	callq  *%rax
  80073d:	bf 00 00 00 00       	mov    $0x0,%edi
  800742:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  800749:	00 00 00 
  80074c:	ff d0                	callq  *%rax
  80074e:	5d                   	pop    %rbp
  80074f:	c3                   	retq   

0000000000800750 <_panic>:
  800750:	55                   	push   %rbp
  800751:	48 89 e5             	mov    %rsp,%rbp
  800754:	53                   	push   %rbx
  800755:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  80075c:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800763:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800769:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800770:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800777:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80077e:	84 c0                	test   %al,%al
  800780:	74 23                	je     8007a5 <_panic+0x55>
  800782:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800789:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80078d:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800791:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800795:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800799:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80079d:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  8007a1:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  8007a5:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8007ac:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  8007b3:	00 00 00 
  8007b6:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  8007bd:	00 00 00 
  8007c0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8007c4:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  8007cb:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8007d2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8007d9:	48 b8 b8 87 80 00 00 	movabs $0x8087b8,%rax
  8007e0:	00 00 00 
  8007e3:	48 8b 18             	mov    (%rax),%rbx
  8007e6:	48 b8 f1 1d 80 00 00 	movabs $0x801df1,%rax
  8007ed:	00 00 00 
  8007f0:	ff d0                	callq  *%rax
  8007f2:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8007f8:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8007ff:	41 89 c8             	mov    %ecx,%r8d
  800802:	48 89 d1             	mov    %rdx,%rcx
  800805:	48 89 da             	mov    %rbx,%rdx
  800808:	89 c6                	mov    %eax,%esi
  80080a:	48 bf 80 50 80 00 00 	movabs $0x805080,%rdi
  800811:	00 00 00 
  800814:	b8 00 00 00 00       	mov    $0x0,%eax
  800819:	49 b9 89 09 80 00 00 	movabs $0x800989,%r9
  800820:	00 00 00 
  800823:	41 ff d1             	callq  *%r9
  800826:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  80082d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800834:	48 89 d6             	mov    %rdx,%rsi
  800837:	48 89 c7             	mov    %rax,%rdi
  80083a:	48 b8 dd 08 80 00 00 	movabs $0x8008dd,%rax
  800841:	00 00 00 
  800844:	ff d0                	callq  *%rax
  800846:	48 bf a3 50 80 00 00 	movabs $0x8050a3,%rdi
  80084d:	00 00 00 
  800850:	b8 00 00 00 00       	mov    $0x0,%eax
  800855:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  80085c:	00 00 00 
  80085f:	ff d2                	callq  *%rdx
  800861:	cc                   	int3   
  800862:	eb fd                	jmp    800861 <_panic+0x111>

0000000000800864 <putch>:
  800864:	55                   	push   %rbp
  800865:	48 89 e5             	mov    %rsp,%rbp
  800868:	48 83 ec 10          	sub    $0x10,%rsp
  80086c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80086f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800873:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800877:	8b 00                	mov    (%rax),%eax
  800879:	8d 48 01             	lea    0x1(%rax),%ecx
  80087c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800880:	89 0a                	mov    %ecx,(%rdx)
  800882:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800885:	89 d1                	mov    %edx,%ecx
  800887:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80088b:	48 98                	cltq   
  80088d:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800891:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800895:	8b 00                	mov    (%rax),%eax
  800897:	3d ff 00 00 00       	cmp    $0xff,%eax
  80089c:	75 2c                	jne    8008ca <putch+0x66>
  80089e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8008a2:	8b 00                	mov    (%rax),%eax
  8008a4:	48 98                	cltq   
  8008a6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8008aa:	48 83 c2 08          	add    $0x8,%rdx
  8008ae:	48 89 c6             	mov    %rax,%rsi
  8008b1:	48 89 d7             	mov    %rdx,%rdi
  8008b4:	48 b8 25 1d 80 00 00 	movabs $0x801d25,%rax
  8008bb:	00 00 00 
  8008be:	ff d0                	callq  *%rax
  8008c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8008c4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8008ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8008ce:	8b 40 04             	mov    0x4(%rax),%eax
  8008d1:	8d 50 01             	lea    0x1(%rax),%edx
  8008d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8008d8:	89 50 04             	mov    %edx,0x4(%rax)
  8008db:	c9                   	leaveq 
  8008dc:	c3                   	retq   

00000000008008dd <vcprintf>:
  8008dd:	55                   	push   %rbp
  8008de:	48 89 e5             	mov    %rsp,%rbp
  8008e1:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8008e8:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8008ef:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8008f6:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8008fd:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800904:	48 8b 0a             	mov    (%rdx),%rcx
  800907:	48 89 08             	mov    %rcx,(%rax)
  80090a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80090e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800912:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800916:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80091a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800921:	00 00 00 
  800924:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80092b:	00 00 00 
  80092e:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800935:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  80093c:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800943:	48 89 c6             	mov    %rax,%rsi
  800946:	48 bf 64 08 80 00 00 	movabs $0x800864,%rdi
  80094d:	00 00 00 
  800950:	48 b8 3c 0d 80 00 00 	movabs $0x800d3c,%rax
  800957:	00 00 00 
  80095a:	ff d0                	callq  *%rax
  80095c:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800962:	48 98                	cltq   
  800964:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80096b:	48 83 c2 08          	add    $0x8,%rdx
  80096f:	48 89 c6             	mov    %rax,%rsi
  800972:	48 89 d7             	mov    %rdx,%rdi
  800975:	48 b8 25 1d 80 00 00 	movabs $0x801d25,%rax
  80097c:	00 00 00 
  80097f:	ff d0                	callq  *%rax
  800981:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800987:	c9                   	leaveq 
  800988:	c3                   	retq   

0000000000800989 <cprintf>:
  800989:	55                   	push   %rbp
  80098a:	48 89 e5             	mov    %rsp,%rbp
  80098d:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800994:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80099b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8009a2:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8009a9:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8009b0:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8009b7:	84 c0                	test   %al,%al
  8009b9:	74 20                	je     8009db <cprintf+0x52>
  8009bb:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8009bf:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8009c3:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8009c7:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8009cb:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8009cf:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8009d3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8009d7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8009db:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8009e2:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8009e9:	00 00 00 
  8009ec:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8009f3:	00 00 00 
  8009f6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8009fa:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800a01:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800a08:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800a0f:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800a16:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800a1d:	48 8b 0a             	mov    (%rdx),%rcx
  800a20:	48 89 08             	mov    %rcx,(%rax)
  800a23:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800a27:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800a2b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800a2f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800a33:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800a3a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800a41:	48 89 d6             	mov    %rdx,%rsi
  800a44:	48 89 c7             	mov    %rax,%rdi
  800a47:	48 b8 dd 08 80 00 00 	movabs $0x8008dd,%rax
  800a4e:	00 00 00 
  800a51:	ff d0                	callq  *%rax
  800a53:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800a59:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800a5f:	c9                   	leaveq 
  800a60:	c3                   	retq   

0000000000800a61 <printnum>:
  800a61:	55                   	push   %rbp
  800a62:	48 89 e5             	mov    %rsp,%rbp
  800a65:	53                   	push   %rbx
  800a66:	48 83 ec 38          	sub    $0x38,%rsp
  800a6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800a6e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800a72:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800a76:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800a79:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800a7d:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800a81:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800a84:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800a88:	77 3b                	ja     800ac5 <printnum+0x64>
  800a8a:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800a8d:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800a91:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800a94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800a98:	ba 00 00 00 00       	mov    $0x0,%edx
  800a9d:	48 f7 f3             	div    %rbx
  800aa0:	48 89 c2             	mov    %rax,%rdx
  800aa3:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800aa6:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800aa9:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800aad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ab1:	41 89 f9             	mov    %edi,%r9d
  800ab4:	48 89 c7             	mov    %rax,%rdi
  800ab7:	48 b8 61 0a 80 00 00 	movabs $0x800a61,%rax
  800abe:	00 00 00 
  800ac1:	ff d0                	callq  *%rax
  800ac3:	eb 1e                	jmp    800ae3 <printnum+0x82>
  800ac5:	eb 12                	jmp    800ad9 <printnum+0x78>
  800ac7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800acb:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800ace:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ad2:	48 89 ce             	mov    %rcx,%rsi
  800ad5:	89 d7                	mov    %edx,%edi
  800ad7:	ff d0                	callq  *%rax
  800ad9:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800add:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800ae1:	7f e4                	jg     800ac7 <printnum+0x66>
  800ae3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800ae6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800aea:	ba 00 00 00 00       	mov    $0x0,%edx
  800aef:	48 f7 f1             	div    %rcx
  800af2:	48 89 d0             	mov    %rdx,%rax
  800af5:	48 ba b0 52 80 00 00 	movabs $0x8052b0,%rdx
  800afc:	00 00 00 
  800aff:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800b03:	0f be d0             	movsbl %al,%edx
  800b06:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800b0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b0e:	48 89 ce             	mov    %rcx,%rsi
  800b11:	89 d7                	mov    %edx,%edi
  800b13:	ff d0                	callq  *%rax
  800b15:	48 83 c4 38          	add    $0x38,%rsp
  800b19:	5b                   	pop    %rbx
  800b1a:	5d                   	pop    %rbp
  800b1b:	c3                   	retq   

0000000000800b1c <getuint>:
  800b1c:	55                   	push   %rbp
  800b1d:	48 89 e5             	mov    %rsp,%rbp
  800b20:	48 83 ec 1c          	sub    $0x1c,%rsp
  800b24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800b28:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800b2b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800b2f:	7e 52                	jle    800b83 <getuint+0x67>
  800b31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b35:	8b 00                	mov    (%rax),%eax
  800b37:	83 f8 30             	cmp    $0x30,%eax
  800b3a:	73 24                	jae    800b60 <getuint+0x44>
  800b3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b40:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b48:	8b 00                	mov    (%rax),%eax
  800b4a:	89 c0                	mov    %eax,%eax
  800b4c:	48 01 d0             	add    %rdx,%rax
  800b4f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b53:	8b 12                	mov    (%rdx),%edx
  800b55:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800b58:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b5c:	89 0a                	mov    %ecx,(%rdx)
  800b5e:	eb 17                	jmp    800b77 <getuint+0x5b>
  800b60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b64:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b68:	48 89 d0             	mov    %rdx,%rax
  800b6b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b6f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b73:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b77:	48 8b 00             	mov    (%rax),%rax
  800b7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b7e:	e9 a3 00 00 00       	jmpq   800c26 <getuint+0x10a>
  800b83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800b87:	74 4f                	je     800bd8 <getuint+0xbc>
  800b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b8d:	8b 00                	mov    (%rax),%eax
  800b8f:	83 f8 30             	cmp    $0x30,%eax
  800b92:	73 24                	jae    800bb8 <getuint+0x9c>
  800b94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b98:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800b9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ba0:	8b 00                	mov    (%rax),%eax
  800ba2:	89 c0                	mov    %eax,%eax
  800ba4:	48 01 d0             	add    %rdx,%rax
  800ba7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bab:	8b 12                	mov    (%rdx),%edx
  800bad:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800bb0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bb4:	89 0a                	mov    %ecx,(%rdx)
  800bb6:	eb 17                	jmp    800bcf <getuint+0xb3>
  800bb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bbc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800bc0:	48 89 d0             	mov    %rdx,%rax
  800bc3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800bc7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bcb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800bcf:	48 8b 00             	mov    (%rax),%rax
  800bd2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800bd6:	eb 4e                	jmp    800c26 <getuint+0x10a>
  800bd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bdc:	8b 00                	mov    (%rax),%eax
  800bde:	83 f8 30             	cmp    $0x30,%eax
  800be1:	73 24                	jae    800c07 <getuint+0xeb>
  800be3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800be7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800beb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bef:	8b 00                	mov    (%rax),%eax
  800bf1:	89 c0                	mov    %eax,%eax
  800bf3:	48 01 d0             	add    %rdx,%rax
  800bf6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bfa:	8b 12                	mov    (%rdx),%edx
  800bfc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800bff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c03:	89 0a                	mov    %ecx,(%rdx)
  800c05:	eb 17                	jmp    800c1e <getuint+0x102>
  800c07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c0b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800c0f:	48 89 d0             	mov    %rdx,%rax
  800c12:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800c16:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c1a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800c1e:	8b 00                	mov    (%rax),%eax
  800c20:	89 c0                	mov    %eax,%eax
  800c22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800c2a:	c9                   	leaveq 
  800c2b:	c3                   	retq   

0000000000800c2c <getint>:
  800c2c:	55                   	push   %rbp
  800c2d:	48 89 e5             	mov    %rsp,%rbp
  800c30:	48 83 ec 1c          	sub    $0x1c,%rsp
  800c34:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800c38:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800c3b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800c3f:	7e 52                	jle    800c93 <getint+0x67>
  800c41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c45:	8b 00                	mov    (%rax),%eax
  800c47:	83 f8 30             	cmp    $0x30,%eax
  800c4a:	73 24                	jae    800c70 <getint+0x44>
  800c4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c50:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800c54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c58:	8b 00                	mov    (%rax),%eax
  800c5a:	89 c0                	mov    %eax,%eax
  800c5c:	48 01 d0             	add    %rdx,%rax
  800c5f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c63:	8b 12                	mov    (%rdx),%edx
  800c65:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800c68:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c6c:	89 0a                	mov    %ecx,(%rdx)
  800c6e:	eb 17                	jmp    800c87 <getint+0x5b>
  800c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c74:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800c78:	48 89 d0             	mov    %rdx,%rax
  800c7b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800c7f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c83:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800c87:	48 8b 00             	mov    (%rax),%rax
  800c8a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800c8e:	e9 a3 00 00 00       	jmpq   800d36 <getint+0x10a>
  800c93:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800c97:	74 4f                	je     800ce8 <getint+0xbc>
  800c99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c9d:	8b 00                	mov    (%rax),%eax
  800c9f:	83 f8 30             	cmp    $0x30,%eax
  800ca2:	73 24                	jae    800cc8 <getint+0x9c>
  800ca4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ca8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800cac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800cb0:	8b 00                	mov    (%rax),%eax
  800cb2:	89 c0                	mov    %eax,%eax
  800cb4:	48 01 d0             	add    %rdx,%rax
  800cb7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800cbb:	8b 12                	mov    (%rdx),%edx
  800cbd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800cc0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800cc4:	89 0a                	mov    %ecx,(%rdx)
  800cc6:	eb 17                	jmp    800cdf <getint+0xb3>
  800cc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ccc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800cd0:	48 89 d0             	mov    %rdx,%rax
  800cd3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800cd7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800cdb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800cdf:	48 8b 00             	mov    (%rax),%rax
  800ce2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800ce6:	eb 4e                	jmp    800d36 <getint+0x10a>
  800ce8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800cec:	8b 00                	mov    (%rax),%eax
  800cee:	83 f8 30             	cmp    $0x30,%eax
  800cf1:	73 24                	jae    800d17 <getint+0xeb>
  800cf3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800cf7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800cfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800cff:	8b 00                	mov    (%rax),%eax
  800d01:	89 c0                	mov    %eax,%eax
  800d03:	48 01 d0             	add    %rdx,%rax
  800d06:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d0a:	8b 12                	mov    (%rdx),%edx
  800d0c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800d0f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d13:	89 0a                	mov    %ecx,(%rdx)
  800d15:	eb 17                	jmp    800d2e <getint+0x102>
  800d17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d1b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800d1f:	48 89 d0             	mov    %rdx,%rax
  800d22:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800d26:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d2a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800d2e:	8b 00                	mov    (%rax),%eax
  800d30:	48 98                	cltq   
  800d32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800d36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800d3a:	c9                   	leaveq 
  800d3b:	c3                   	retq   

0000000000800d3c <vprintfmt>:
  800d3c:	55                   	push   %rbp
  800d3d:	48 89 e5             	mov    %rsp,%rbp
  800d40:	41 54                	push   %r12
  800d42:	53                   	push   %rbx
  800d43:	48 83 ec 60          	sub    $0x60,%rsp
  800d47:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800d4b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800d4f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800d53:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800d57:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d5b:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800d5f:	48 8b 0a             	mov    (%rdx),%rcx
  800d62:	48 89 08             	mov    %rcx,(%rax)
  800d65:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800d69:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800d6d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800d71:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800d75:	eb 17                	jmp    800d8e <vprintfmt+0x52>
  800d77:	85 db                	test   %ebx,%ebx
  800d79:	0f 84 cc 04 00 00    	je     80124b <vprintfmt+0x50f>
  800d7f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d83:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d87:	48 89 d6             	mov    %rdx,%rsi
  800d8a:	89 df                	mov    %ebx,%edi
  800d8c:	ff d0                	callq  *%rax
  800d8e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800d92:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800d96:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800d9a:	0f b6 00             	movzbl (%rax),%eax
  800d9d:	0f b6 d8             	movzbl %al,%ebx
  800da0:	83 fb 25             	cmp    $0x25,%ebx
  800da3:	75 d2                	jne    800d77 <vprintfmt+0x3b>
  800da5:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800da9:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800db0:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800db7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800dbe:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800dc5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800dc9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800dcd:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800dd1:	0f b6 00             	movzbl (%rax),%eax
  800dd4:	0f b6 d8             	movzbl %al,%ebx
  800dd7:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800dda:	83 f8 55             	cmp    $0x55,%eax
  800ddd:	0f 87 34 04 00 00    	ja     801217 <vprintfmt+0x4db>
  800de3:	89 c0                	mov    %eax,%eax
  800de5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800dec:	00 
  800ded:	48 b8 d8 52 80 00 00 	movabs $0x8052d8,%rax
  800df4:	00 00 00 
  800df7:	48 01 d0             	add    %rdx,%rax
  800dfa:	48 8b 00             	mov    (%rax),%rax
  800dfd:	ff e0                	jmpq   *%rax
  800dff:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800e03:	eb c0                	jmp    800dc5 <vprintfmt+0x89>
  800e05:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800e09:	eb ba                	jmp    800dc5 <vprintfmt+0x89>
  800e0b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800e12:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800e15:	89 d0                	mov    %edx,%eax
  800e17:	c1 e0 02             	shl    $0x2,%eax
  800e1a:	01 d0                	add    %edx,%eax
  800e1c:	01 c0                	add    %eax,%eax
  800e1e:	01 d8                	add    %ebx,%eax
  800e20:	83 e8 30             	sub    $0x30,%eax
  800e23:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800e26:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800e2a:	0f b6 00             	movzbl (%rax),%eax
  800e2d:	0f be d8             	movsbl %al,%ebx
  800e30:	83 fb 2f             	cmp    $0x2f,%ebx
  800e33:	7e 0c                	jle    800e41 <vprintfmt+0x105>
  800e35:	83 fb 39             	cmp    $0x39,%ebx
  800e38:	7f 07                	jg     800e41 <vprintfmt+0x105>
  800e3a:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800e3f:	eb d1                	jmp    800e12 <vprintfmt+0xd6>
  800e41:	eb 58                	jmp    800e9b <vprintfmt+0x15f>
  800e43:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e46:	83 f8 30             	cmp    $0x30,%eax
  800e49:	73 17                	jae    800e62 <vprintfmt+0x126>
  800e4b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e4f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e52:	89 c0                	mov    %eax,%eax
  800e54:	48 01 d0             	add    %rdx,%rax
  800e57:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e5a:	83 c2 08             	add    $0x8,%edx
  800e5d:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e60:	eb 0f                	jmp    800e71 <vprintfmt+0x135>
  800e62:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e66:	48 89 d0             	mov    %rdx,%rax
  800e69:	48 83 c2 08          	add    $0x8,%rdx
  800e6d:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e71:	8b 00                	mov    (%rax),%eax
  800e73:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800e76:	eb 23                	jmp    800e9b <vprintfmt+0x15f>
  800e78:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e7c:	79 0c                	jns    800e8a <vprintfmt+0x14e>
  800e7e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800e85:	e9 3b ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800e8a:	e9 36 ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800e8f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800e96:	e9 2a ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800e9b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e9f:	79 12                	jns    800eb3 <vprintfmt+0x177>
  800ea1:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800ea4:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800ea7:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800eae:	e9 12 ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800eb3:	e9 0d ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800eb8:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800ebc:	e9 04 ff ff ff       	jmpq   800dc5 <vprintfmt+0x89>
  800ec1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ec4:	83 f8 30             	cmp    $0x30,%eax
  800ec7:	73 17                	jae    800ee0 <vprintfmt+0x1a4>
  800ec9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ecd:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ed0:	89 c0                	mov    %eax,%eax
  800ed2:	48 01 d0             	add    %rdx,%rax
  800ed5:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ed8:	83 c2 08             	add    $0x8,%edx
  800edb:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800ede:	eb 0f                	jmp    800eef <vprintfmt+0x1b3>
  800ee0:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ee4:	48 89 d0             	mov    %rdx,%rax
  800ee7:	48 83 c2 08          	add    $0x8,%rdx
  800eeb:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800eef:	8b 10                	mov    (%rax),%edx
  800ef1:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800ef5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ef9:	48 89 ce             	mov    %rcx,%rsi
  800efc:	89 d7                	mov    %edx,%edi
  800efe:	ff d0                	callq  *%rax
  800f00:	e9 40 03 00 00       	jmpq   801245 <vprintfmt+0x509>
  800f05:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800f08:	83 f8 30             	cmp    $0x30,%eax
  800f0b:	73 17                	jae    800f24 <vprintfmt+0x1e8>
  800f0d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800f11:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800f14:	89 c0                	mov    %eax,%eax
  800f16:	48 01 d0             	add    %rdx,%rax
  800f19:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800f1c:	83 c2 08             	add    $0x8,%edx
  800f1f:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800f22:	eb 0f                	jmp    800f33 <vprintfmt+0x1f7>
  800f24:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800f28:	48 89 d0             	mov    %rdx,%rax
  800f2b:	48 83 c2 08          	add    $0x8,%rdx
  800f2f:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800f33:	8b 18                	mov    (%rax),%ebx
  800f35:	85 db                	test   %ebx,%ebx
  800f37:	79 02                	jns    800f3b <vprintfmt+0x1ff>
  800f39:	f7 db                	neg    %ebx
  800f3b:	83 fb 15             	cmp    $0x15,%ebx
  800f3e:	7f 16                	jg     800f56 <vprintfmt+0x21a>
  800f40:	48 b8 00 52 80 00 00 	movabs $0x805200,%rax
  800f47:	00 00 00 
  800f4a:	48 63 d3             	movslq %ebx,%rdx
  800f4d:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800f51:	4d 85 e4             	test   %r12,%r12
  800f54:	75 2e                	jne    800f84 <vprintfmt+0x248>
  800f56:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800f5a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f5e:	89 d9                	mov    %ebx,%ecx
  800f60:	48 ba c1 52 80 00 00 	movabs $0x8052c1,%rdx
  800f67:	00 00 00 
  800f6a:	48 89 c7             	mov    %rax,%rdi
  800f6d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f72:	49 b8 54 12 80 00 00 	movabs $0x801254,%r8
  800f79:	00 00 00 
  800f7c:	41 ff d0             	callq  *%r8
  800f7f:	e9 c1 02 00 00       	jmpq   801245 <vprintfmt+0x509>
  800f84:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800f88:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f8c:	4c 89 e1             	mov    %r12,%rcx
  800f8f:	48 ba ca 52 80 00 00 	movabs $0x8052ca,%rdx
  800f96:	00 00 00 
  800f99:	48 89 c7             	mov    %rax,%rdi
  800f9c:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa1:	49 b8 54 12 80 00 00 	movabs $0x801254,%r8
  800fa8:	00 00 00 
  800fab:	41 ff d0             	callq  *%r8
  800fae:	e9 92 02 00 00       	jmpq   801245 <vprintfmt+0x509>
  800fb3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800fb6:	83 f8 30             	cmp    $0x30,%eax
  800fb9:	73 17                	jae    800fd2 <vprintfmt+0x296>
  800fbb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800fbf:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800fc2:	89 c0                	mov    %eax,%eax
  800fc4:	48 01 d0             	add    %rdx,%rax
  800fc7:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800fca:	83 c2 08             	add    $0x8,%edx
  800fcd:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800fd0:	eb 0f                	jmp    800fe1 <vprintfmt+0x2a5>
  800fd2:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800fd6:	48 89 d0             	mov    %rdx,%rax
  800fd9:	48 83 c2 08          	add    $0x8,%rdx
  800fdd:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800fe1:	4c 8b 20             	mov    (%rax),%r12
  800fe4:	4d 85 e4             	test   %r12,%r12
  800fe7:	75 0a                	jne    800ff3 <vprintfmt+0x2b7>
  800fe9:	49 bc cd 52 80 00 00 	movabs $0x8052cd,%r12
  800ff0:	00 00 00 
  800ff3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800ff7:	7e 3f                	jle    801038 <vprintfmt+0x2fc>
  800ff9:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800ffd:	74 39                	je     801038 <vprintfmt+0x2fc>
  800fff:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801002:	48 98                	cltq   
  801004:	48 89 c6             	mov    %rax,%rsi
  801007:	4c 89 e7             	mov    %r12,%rdi
  80100a:	48 b8 00 15 80 00 00 	movabs $0x801500,%rax
  801011:	00 00 00 
  801014:	ff d0                	callq  *%rax
  801016:	29 45 dc             	sub    %eax,-0x24(%rbp)
  801019:	eb 17                	jmp    801032 <vprintfmt+0x2f6>
  80101b:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  80101f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  801023:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801027:	48 89 ce             	mov    %rcx,%rsi
  80102a:	89 d7                	mov    %edx,%edi
  80102c:	ff d0                	callq  *%rax
  80102e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801032:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801036:	7f e3                	jg     80101b <vprintfmt+0x2df>
  801038:	eb 37                	jmp    801071 <vprintfmt+0x335>
  80103a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  80103e:	74 1e                	je     80105e <vprintfmt+0x322>
  801040:	83 fb 1f             	cmp    $0x1f,%ebx
  801043:	7e 05                	jle    80104a <vprintfmt+0x30e>
  801045:	83 fb 7e             	cmp    $0x7e,%ebx
  801048:	7e 14                	jle    80105e <vprintfmt+0x322>
  80104a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80104e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801052:	48 89 d6             	mov    %rdx,%rsi
  801055:	bf 3f 00 00 00       	mov    $0x3f,%edi
  80105a:	ff d0                	callq  *%rax
  80105c:	eb 0f                	jmp    80106d <vprintfmt+0x331>
  80105e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801062:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801066:	48 89 d6             	mov    %rdx,%rsi
  801069:	89 df                	mov    %ebx,%edi
  80106b:	ff d0                	callq  *%rax
  80106d:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801071:	4c 89 e0             	mov    %r12,%rax
  801074:	4c 8d 60 01          	lea    0x1(%rax),%r12
  801078:	0f b6 00             	movzbl (%rax),%eax
  80107b:	0f be d8             	movsbl %al,%ebx
  80107e:	85 db                	test   %ebx,%ebx
  801080:	74 10                	je     801092 <vprintfmt+0x356>
  801082:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801086:	78 b2                	js     80103a <vprintfmt+0x2fe>
  801088:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  80108c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801090:	79 a8                	jns    80103a <vprintfmt+0x2fe>
  801092:	eb 16                	jmp    8010aa <vprintfmt+0x36e>
  801094:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801098:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80109c:	48 89 d6             	mov    %rdx,%rsi
  80109f:	bf 20 00 00 00       	mov    $0x20,%edi
  8010a4:	ff d0                	callq  *%rax
  8010a6:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  8010aa:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8010ae:	7f e4                	jg     801094 <vprintfmt+0x358>
  8010b0:	e9 90 01 00 00       	jmpq   801245 <vprintfmt+0x509>
  8010b5:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8010b9:	be 03 00 00 00       	mov    $0x3,%esi
  8010be:	48 89 c7             	mov    %rax,%rdi
  8010c1:	48 b8 2c 0c 80 00 00 	movabs $0x800c2c,%rax
  8010c8:	00 00 00 
  8010cb:	ff d0                	callq  *%rax
  8010cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8010d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010d5:	48 85 c0             	test   %rax,%rax
  8010d8:	79 1d                	jns    8010f7 <vprintfmt+0x3bb>
  8010da:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8010de:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8010e2:	48 89 d6             	mov    %rdx,%rsi
  8010e5:	bf 2d 00 00 00       	mov    $0x2d,%edi
  8010ea:	ff d0                	callq  *%rax
  8010ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010f0:	48 f7 d8             	neg    %rax
  8010f3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8010f7:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8010fe:	e9 d5 00 00 00       	jmpq   8011d8 <vprintfmt+0x49c>
  801103:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801107:	be 03 00 00 00       	mov    $0x3,%esi
  80110c:	48 89 c7             	mov    %rax,%rdi
  80110f:	48 b8 1c 0b 80 00 00 	movabs $0x800b1c,%rax
  801116:	00 00 00 
  801119:	ff d0                	callq  *%rax
  80111b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80111f:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  801126:	e9 ad 00 00 00       	jmpq   8011d8 <vprintfmt+0x49c>
  80112b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80112f:	be 03 00 00 00       	mov    $0x3,%esi
  801134:	48 89 c7             	mov    %rax,%rdi
  801137:	48 b8 1c 0b 80 00 00 	movabs $0x800b1c,%rax
  80113e:	00 00 00 
  801141:	ff d0                	callq  *%rax
  801143:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801147:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  80114e:	e9 85 00 00 00       	jmpq   8011d8 <vprintfmt+0x49c>
  801153:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801157:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80115b:	48 89 d6             	mov    %rdx,%rsi
  80115e:	bf 30 00 00 00       	mov    $0x30,%edi
  801163:	ff d0                	callq  *%rax
  801165:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801169:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80116d:	48 89 d6             	mov    %rdx,%rsi
  801170:	bf 78 00 00 00       	mov    $0x78,%edi
  801175:	ff d0                	callq  *%rax
  801177:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80117a:	83 f8 30             	cmp    $0x30,%eax
  80117d:	73 17                	jae    801196 <vprintfmt+0x45a>
  80117f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801183:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801186:	89 c0                	mov    %eax,%eax
  801188:	48 01 d0             	add    %rdx,%rax
  80118b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80118e:	83 c2 08             	add    $0x8,%edx
  801191:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801194:	eb 0f                	jmp    8011a5 <vprintfmt+0x469>
  801196:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80119a:	48 89 d0             	mov    %rdx,%rax
  80119d:	48 83 c2 08          	add    $0x8,%rdx
  8011a1:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8011a5:	48 8b 00             	mov    (%rax),%rax
  8011a8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8011ac:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8011b3:	eb 23                	jmp    8011d8 <vprintfmt+0x49c>
  8011b5:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8011b9:	be 03 00 00 00       	mov    $0x3,%esi
  8011be:	48 89 c7             	mov    %rax,%rdi
  8011c1:	48 b8 1c 0b 80 00 00 	movabs $0x800b1c,%rax
  8011c8:	00 00 00 
  8011cb:	ff d0                	callq  *%rax
  8011cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8011d1:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8011d8:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  8011dd:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  8011e0:	8b 7d dc             	mov    -0x24(%rbp),%edi
  8011e3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011e7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8011eb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8011ef:	45 89 c1             	mov    %r8d,%r9d
  8011f2:	41 89 f8             	mov    %edi,%r8d
  8011f5:	48 89 c7             	mov    %rax,%rdi
  8011f8:	48 b8 61 0a 80 00 00 	movabs $0x800a61,%rax
  8011ff:	00 00 00 
  801202:	ff d0                	callq  *%rax
  801204:	eb 3f                	jmp    801245 <vprintfmt+0x509>
  801206:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80120a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80120e:	48 89 d6             	mov    %rdx,%rsi
  801211:	89 df                	mov    %ebx,%edi
  801213:	ff d0                	callq  *%rax
  801215:	eb 2e                	jmp    801245 <vprintfmt+0x509>
  801217:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80121b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80121f:	48 89 d6             	mov    %rdx,%rsi
  801222:	bf 25 00 00 00       	mov    $0x25,%edi
  801227:	ff d0                	callq  *%rax
  801229:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80122e:	eb 05                	jmp    801235 <vprintfmt+0x4f9>
  801230:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  801235:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801239:	48 83 e8 01          	sub    $0x1,%rax
  80123d:	0f b6 00             	movzbl (%rax),%eax
  801240:	3c 25                	cmp    $0x25,%al
  801242:	75 ec                	jne    801230 <vprintfmt+0x4f4>
  801244:	90                   	nop
  801245:	90                   	nop
  801246:	e9 43 fb ff ff       	jmpq   800d8e <vprintfmt+0x52>
  80124b:	48 83 c4 60          	add    $0x60,%rsp
  80124f:	5b                   	pop    %rbx
  801250:	41 5c                	pop    %r12
  801252:	5d                   	pop    %rbp
  801253:	c3                   	retq   

0000000000801254 <printfmt>:
  801254:	55                   	push   %rbp
  801255:	48 89 e5             	mov    %rsp,%rbp
  801258:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  80125f:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801266:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80126d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801274:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80127b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801282:	84 c0                	test   %al,%al
  801284:	74 20                	je     8012a6 <printfmt+0x52>
  801286:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80128a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80128e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801292:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801296:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80129a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80129e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8012a2:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8012a6:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  8012ad:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  8012b4:	00 00 00 
  8012b7:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  8012be:	00 00 00 
  8012c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8012c5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8012cc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8012d3:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  8012da:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  8012e1:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8012e8:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  8012ef:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  8012f6:	48 89 c7             	mov    %rax,%rdi
  8012f9:	48 b8 3c 0d 80 00 00 	movabs $0x800d3c,%rax
  801300:	00 00 00 
  801303:	ff d0                	callq  *%rax
  801305:	c9                   	leaveq 
  801306:	c3                   	retq   

0000000000801307 <sprintputch>:
  801307:	55                   	push   %rbp
  801308:	48 89 e5             	mov    %rsp,%rbp
  80130b:	48 83 ec 10          	sub    $0x10,%rsp
  80130f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801312:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801316:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80131a:	8b 40 10             	mov    0x10(%rax),%eax
  80131d:	8d 50 01             	lea    0x1(%rax),%edx
  801320:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801324:	89 50 10             	mov    %edx,0x10(%rax)
  801327:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80132b:	48 8b 10             	mov    (%rax),%rdx
  80132e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801332:	48 8b 40 08          	mov    0x8(%rax),%rax
  801336:	48 39 c2             	cmp    %rax,%rdx
  801339:	73 17                	jae    801352 <sprintputch+0x4b>
  80133b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80133f:	48 8b 00             	mov    (%rax),%rax
  801342:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801346:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80134a:	48 89 0a             	mov    %rcx,(%rdx)
  80134d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801350:	88 10                	mov    %dl,(%rax)
  801352:	c9                   	leaveq 
  801353:	c3                   	retq   

0000000000801354 <vsnprintf>:
  801354:	55                   	push   %rbp
  801355:	48 89 e5             	mov    %rsp,%rbp
  801358:	48 83 ec 50          	sub    $0x50,%rsp
  80135c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801360:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801363:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801367:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  80136b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  80136f:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801373:	48 8b 0a             	mov    (%rdx),%rcx
  801376:	48 89 08             	mov    %rcx,(%rax)
  801379:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80137d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801381:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801385:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801389:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80138d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801391:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801394:	48 98                	cltq   
  801396:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80139a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80139e:	48 01 d0             	add    %rdx,%rax
  8013a1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8013a5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8013ac:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  8013b1:	74 06                	je     8013b9 <vsnprintf+0x65>
  8013b3:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  8013b7:	7f 07                	jg     8013c0 <vsnprintf+0x6c>
  8013b9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8013be:	eb 2f                	jmp    8013ef <vsnprintf+0x9b>
  8013c0:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  8013c4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  8013c8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8013cc:	48 89 c6             	mov    %rax,%rsi
  8013cf:	48 bf 07 13 80 00 00 	movabs $0x801307,%rdi
  8013d6:	00 00 00 
  8013d9:	48 b8 3c 0d 80 00 00 	movabs $0x800d3c,%rax
  8013e0:	00 00 00 
  8013e3:	ff d0                	callq  *%rax
  8013e5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8013e9:	c6 00 00             	movb   $0x0,(%rax)
  8013ec:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8013ef:	c9                   	leaveq 
  8013f0:	c3                   	retq   

00000000008013f1 <snprintf>:
  8013f1:	55                   	push   %rbp
  8013f2:	48 89 e5             	mov    %rsp,%rbp
  8013f5:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8013fc:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  801403:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  801409:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801410:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801417:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80141e:	84 c0                	test   %al,%al
  801420:	74 20                	je     801442 <snprintf+0x51>
  801422:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801426:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80142a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80142e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801432:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801436:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80143a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80143e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801442:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801449:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  801450:	00 00 00 
  801453:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80145a:	00 00 00 
  80145d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801461:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801468:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80146f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801476:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80147d:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801484:	48 8b 0a             	mov    (%rdx),%rcx
  801487:	48 89 08             	mov    %rcx,(%rax)
  80148a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80148e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801492:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801496:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80149a:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  8014a1:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  8014a8:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  8014ae:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8014b5:	48 89 c7             	mov    %rax,%rdi
  8014b8:	48 b8 54 13 80 00 00 	movabs $0x801354,%rax
  8014bf:	00 00 00 
  8014c2:	ff d0                	callq  *%rax
  8014c4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8014ca:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8014d0:	c9                   	leaveq 
  8014d1:	c3                   	retq   

00000000008014d2 <strlen>:
  8014d2:	55                   	push   %rbp
  8014d3:	48 89 e5             	mov    %rsp,%rbp
  8014d6:	48 83 ec 18          	sub    $0x18,%rsp
  8014da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8014e5:	eb 09                	jmp    8014f0 <strlen+0x1e>
  8014e7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8014eb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8014f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014f4:	0f b6 00             	movzbl (%rax),%eax
  8014f7:	84 c0                	test   %al,%al
  8014f9:	75 ec                	jne    8014e7 <strlen+0x15>
  8014fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8014fe:	c9                   	leaveq 
  8014ff:	c3                   	retq   

0000000000801500 <strnlen>:
  801500:	55                   	push   %rbp
  801501:	48 89 e5             	mov    %rsp,%rbp
  801504:	48 83 ec 20          	sub    $0x20,%rsp
  801508:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80150c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801510:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801517:	eb 0e                	jmp    801527 <strnlen+0x27>
  801519:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80151d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801522:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801527:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80152c:	74 0b                	je     801539 <strnlen+0x39>
  80152e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801532:	0f b6 00             	movzbl (%rax),%eax
  801535:	84 c0                	test   %al,%al
  801537:	75 e0                	jne    801519 <strnlen+0x19>
  801539:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80153c:	c9                   	leaveq 
  80153d:	c3                   	retq   

000000000080153e <strcpy>:
  80153e:	55                   	push   %rbp
  80153f:	48 89 e5             	mov    %rsp,%rbp
  801542:	48 83 ec 20          	sub    $0x20,%rsp
  801546:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80154a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80154e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801552:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801556:	90                   	nop
  801557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80155b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80155f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801563:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801567:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80156b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80156f:	0f b6 12             	movzbl (%rdx),%edx
  801572:	88 10                	mov    %dl,(%rax)
  801574:	0f b6 00             	movzbl (%rax),%eax
  801577:	84 c0                	test   %al,%al
  801579:	75 dc                	jne    801557 <strcpy+0x19>
  80157b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80157f:	c9                   	leaveq 
  801580:	c3                   	retq   

0000000000801581 <strcat>:
  801581:	55                   	push   %rbp
  801582:	48 89 e5             	mov    %rsp,%rbp
  801585:	48 83 ec 20          	sub    $0x20,%rsp
  801589:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80158d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801591:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801595:	48 89 c7             	mov    %rax,%rdi
  801598:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  80159f:	00 00 00 
  8015a2:	ff d0                	callq  *%rax
  8015a4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8015a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8015aa:	48 63 d0             	movslq %eax,%rdx
  8015ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015b1:	48 01 c2             	add    %rax,%rdx
  8015b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8015b8:	48 89 c6             	mov    %rax,%rsi
  8015bb:	48 89 d7             	mov    %rdx,%rdi
  8015be:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  8015c5:	00 00 00 
  8015c8:	ff d0                	callq  *%rax
  8015ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015ce:	c9                   	leaveq 
  8015cf:	c3                   	retq   

00000000008015d0 <strncpy>:
  8015d0:	55                   	push   %rbp
  8015d1:	48 89 e5             	mov    %rsp,%rbp
  8015d4:	48 83 ec 28          	sub    $0x28,%rsp
  8015d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8015dc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8015e0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8015e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8015ec:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8015f3:	00 
  8015f4:	eb 2a                	jmp    801620 <strncpy+0x50>
  8015f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015fa:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8015fe:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801602:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801606:	0f b6 12             	movzbl (%rdx),%edx
  801609:	88 10                	mov    %dl,(%rax)
  80160b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80160f:	0f b6 00             	movzbl (%rax),%eax
  801612:	84 c0                	test   %al,%al
  801614:	74 05                	je     80161b <strncpy+0x4b>
  801616:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80161b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801620:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801624:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801628:	72 cc                	jb     8015f6 <strncpy+0x26>
  80162a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80162e:	c9                   	leaveq 
  80162f:	c3                   	retq   

0000000000801630 <strlcpy>:
  801630:	55                   	push   %rbp
  801631:	48 89 e5             	mov    %rsp,%rbp
  801634:	48 83 ec 28          	sub    $0x28,%rsp
  801638:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80163c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801640:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801644:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801648:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80164c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801651:	74 3d                	je     801690 <strlcpy+0x60>
  801653:	eb 1d                	jmp    801672 <strlcpy+0x42>
  801655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801659:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80165d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801661:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801665:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801669:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80166d:	0f b6 12             	movzbl (%rdx),%edx
  801670:	88 10                	mov    %dl,(%rax)
  801672:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801677:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80167c:	74 0b                	je     801689 <strlcpy+0x59>
  80167e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801682:	0f b6 00             	movzbl (%rax),%eax
  801685:	84 c0                	test   %al,%al
  801687:	75 cc                	jne    801655 <strlcpy+0x25>
  801689:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80168d:	c6 00 00             	movb   $0x0,(%rax)
  801690:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801694:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801698:	48 29 c2             	sub    %rax,%rdx
  80169b:	48 89 d0             	mov    %rdx,%rax
  80169e:	c9                   	leaveq 
  80169f:	c3                   	retq   

00000000008016a0 <strcmp>:
  8016a0:	55                   	push   %rbp
  8016a1:	48 89 e5             	mov    %rsp,%rbp
  8016a4:	48 83 ec 10          	sub    $0x10,%rsp
  8016a8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016ac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8016b0:	eb 0a                	jmp    8016bc <strcmp+0x1c>
  8016b2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016b7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8016bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016c0:	0f b6 00             	movzbl (%rax),%eax
  8016c3:	84 c0                	test   %al,%al
  8016c5:	74 12                	je     8016d9 <strcmp+0x39>
  8016c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016cb:	0f b6 10             	movzbl (%rax),%edx
  8016ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016d2:	0f b6 00             	movzbl (%rax),%eax
  8016d5:	38 c2                	cmp    %al,%dl
  8016d7:	74 d9                	je     8016b2 <strcmp+0x12>
  8016d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016dd:	0f b6 00             	movzbl (%rax),%eax
  8016e0:	0f b6 d0             	movzbl %al,%edx
  8016e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016e7:	0f b6 00             	movzbl (%rax),%eax
  8016ea:	0f b6 c0             	movzbl %al,%eax
  8016ed:	29 c2                	sub    %eax,%edx
  8016ef:	89 d0                	mov    %edx,%eax
  8016f1:	c9                   	leaveq 
  8016f2:	c3                   	retq   

00000000008016f3 <strncmp>:
  8016f3:	55                   	push   %rbp
  8016f4:	48 89 e5             	mov    %rsp,%rbp
  8016f7:	48 83 ec 18          	sub    $0x18,%rsp
  8016fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016ff:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801703:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801707:	eb 0f                	jmp    801718 <strncmp+0x25>
  801709:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80170e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801713:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801718:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80171d:	74 1d                	je     80173c <strncmp+0x49>
  80171f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801723:	0f b6 00             	movzbl (%rax),%eax
  801726:	84 c0                	test   %al,%al
  801728:	74 12                	je     80173c <strncmp+0x49>
  80172a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80172e:	0f b6 10             	movzbl (%rax),%edx
  801731:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801735:	0f b6 00             	movzbl (%rax),%eax
  801738:	38 c2                	cmp    %al,%dl
  80173a:	74 cd                	je     801709 <strncmp+0x16>
  80173c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801741:	75 07                	jne    80174a <strncmp+0x57>
  801743:	b8 00 00 00 00       	mov    $0x0,%eax
  801748:	eb 18                	jmp    801762 <strncmp+0x6f>
  80174a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80174e:	0f b6 00             	movzbl (%rax),%eax
  801751:	0f b6 d0             	movzbl %al,%edx
  801754:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801758:	0f b6 00             	movzbl (%rax),%eax
  80175b:	0f b6 c0             	movzbl %al,%eax
  80175e:	29 c2                	sub    %eax,%edx
  801760:	89 d0                	mov    %edx,%eax
  801762:	c9                   	leaveq 
  801763:	c3                   	retq   

0000000000801764 <strchr>:
  801764:	55                   	push   %rbp
  801765:	48 89 e5             	mov    %rsp,%rbp
  801768:	48 83 ec 0c          	sub    $0xc,%rsp
  80176c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801770:	89 f0                	mov    %esi,%eax
  801772:	88 45 f4             	mov    %al,-0xc(%rbp)
  801775:	eb 17                	jmp    80178e <strchr+0x2a>
  801777:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80177b:	0f b6 00             	movzbl (%rax),%eax
  80177e:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801781:	75 06                	jne    801789 <strchr+0x25>
  801783:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801787:	eb 15                	jmp    80179e <strchr+0x3a>
  801789:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80178e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801792:	0f b6 00             	movzbl (%rax),%eax
  801795:	84 c0                	test   %al,%al
  801797:	75 de                	jne    801777 <strchr+0x13>
  801799:	b8 00 00 00 00       	mov    $0x0,%eax
  80179e:	c9                   	leaveq 
  80179f:	c3                   	retq   

00000000008017a0 <strfind>:
  8017a0:	55                   	push   %rbp
  8017a1:	48 89 e5             	mov    %rsp,%rbp
  8017a4:	48 83 ec 0c          	sub    $0xc,%rsp
  8017a8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8017ac:	89 f0                	mov    %esi,%eax
  8017ae:	88 45 f4             	mov    %al,-0xc(%rbp)
  8017b1:	eb 13                	jmp    8017c6 <strfind+0x26>
  8017b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017b7:	0f b6 00             	movzbl (%rax),%eax
  8017ba:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8017bd:	75 02                	jne    8017c1 <strfind+0x21>
  8017bf:	eb 10                	jmp    8017d1 <strfind+0x31>
  8017c1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8017c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017ca:	0f b6 00             	movzbl (%rax),%eax
  8017cd:	84 c0                	test   %al,%al
  8017cf:	75 e2                	jne    8017b3 <strfind+0x13>
  8017d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017d5:	c9                   	leaveq 
  8017d6:	c3                   	retq   

00000000008017d7 <memset>:
  8017d7:	55                   	push   %rbp
  8017d8:	48 89 e5             	mov    %rsp,%rbp
  8017db:	48 83 ec 18          	sub    $0x18,%rsp
  8017df:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8017e3:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8017e6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8017ea:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8017ef:	75 06                	jne    8017f7 <memset+0x20>
  8017f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017f5:	eb 69                	jmp    801860 <memset+0x89>
  8017f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017fb:	83 e0 03             	and    $0x3,%eax
  8017fe:	48 85 c0             	test   %rax,%rax
  801801:	75 48                	jne    80184b <memset+0x74>
  801803:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801807:	83 e0 03             	and    $0x3,%eax
  80180a:	48 85 c0             	test   %rax,%rax
  80180d:	75 3c                	jne    80184b <memset+0x74>
  80180f:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801816:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801819:	c1 e0 18             	shl    $0x18,%eax
  80181c:	89 c2                	mov    %eax,%edx
  80181e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801821:	c1 e0 10             	shl    $0x10,%eax
  801824:	09 c2                	or     %eax,%edx
  801826:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801829:	c1 e0 08             	shl    $0x8,%eax
  80182c:	09 d0                	or     %edx,%eax
  80182e:	09 45 f4             	or     %eax,-0xc(%rbp)
  801831:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801835:	48 c1 e8 02          	shr    $0x2,%rax
  801839:	48 89 c1             	mov    %rax,%rcx
  80183c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801840:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801843:	48 89 d7             	mov    %rdx,%rdi
  801846:	fc                   	cld    
  801847:	f3 ab                	rep stos %eax,%es:(%rdi)
  801849:	eb 11                	jmp    80185c <memset+0x85>
  80184b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80184f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801852:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801856:	48 89 d7             	mov    %rdx,%rdi
  801859:	fc                   	cld    
  80185a:	f3 aa                	rep stos %al,%es:(%rdi)
  80185c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801860:	c9                   	leaveq 
  801861:	c3                   	retq   

0000000000801862 <memmove>:
  801862:	55                   	push   %rbp
  801863:	48 89 e5             	mov    %rsp,%rbp
  801866:	48 83 ec 28          	sub    $0x28,%rsp
  80186a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80186e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801872:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801876:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80187a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80187e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801882:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80188a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80188e:	0f 83 88 00 00 00    	jae    80191c <memmove+0xba>
  801894:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801898:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80189c:	48 01 d0             	add    %rdx,%rax
  80189f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8018a3:	76 77                	jbe    80191c <memmove+0xba>
  8018a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018a9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8018ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018b1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8018b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018b9:	83 e0 03             	and    $0x3,%eax
  8018bc:	48 85 c0             	test   %rax,%rax
  8018bf:	75 3b                	jne    8018fc <memmove+0x9a>
  8018c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018c5:	83 e0 03             	and    $0x3,%eax
  8018c8:	48 85 c0             	test   %rax,%rax
  8018cb:	75 2f                	jne    8018fc <memmove+0x9a>
  8018cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018d1:	83 e0 03             	and    $0x3,%eax
  8018d4:	48 85 c0             	test   %rax,%rax
  8018d7:	75 23                	jne    8018fc <memmove+0x9a>
  8018d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018dd:	48 83 e8 04          	sub    $0x4,%rax
  8018e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8018e5:	48 83 ea 04          	sub    $0x4,%rdx
  8018e9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8018ed:	48 c1 e9 02          	shr    $0x2,%rcx
  8018f1:	48 89 c7             	mov    %rax,%rdi
  8018f4:	48 89 d6             	mov    %rdx,%rsi
  8018f7:	fd                   	std    
  8018f8:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8018fa:	eb 1d                	jmp    801919 <memmove+0xb7>
  8018fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801900:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801908:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  80190c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801910:	48 89 d7             	mov    %rdx,%rdi
  801913:	48 89 c1             	mov    %rax,%rcx
  801916:	fd                   	std    
  801917:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801919:	fc                   	cld    
  80191a:	eb 57                	jmp    801973 <memmove+0x111>
  80191c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801920:	83 e0 03             	and    $0x3,%eax
  801923:	48 85 c0             	test   %rax,%rax
  801926:	75 36                	jne    80195e <memmove+0xfc>
  801928:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80192c:	83 e0 03             	and    $0x3,%eax
  80192f:	48 85 c0             	test   %rax,%rax
  801932:	75 2a                	jne    80195e <memmove+0xfc>
  801934:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801938:	83 e0 03             	and    $0x3,%eax
  80193b:	48 85 c0             	test   %rax,%rax
  80193e:	75 1e                	jne    80195e <memmove+0xfc>
  801940:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801944:	48 c1 e8 02          	shr    $0x2,%rax
  801948:	48 89 c1             	mov    %rax,%rcx
  80194b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80194f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801953:	48 89 c7             	mov    %rax,%rdi
  801956:	48 89 d6             	mov    %rdx,%rsi
  801959:	fc                   	cld    
  80195a:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80195c:	eb 15                	jmp    801973 <memmove+0x111>
  80195e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801962:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801966:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80196a:	48 89 c7             	mov    %rax,%rdi
  80196d:	48 89 d6             	mov    %rdx,%rsi
  801970:	fc                   	cld    
  801971:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801973:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801977:	c9                   	leaveq 
  801978:	c3                   	retq   

0000000000801979 <memcpy>:
  801979:	55                   	push   %rbp
  80197a:	48 89 e5             	mov    %rsp,%rbp
  80197d:	48 83 ec 18          	sub    $0x18,%rsp
  801981:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801985:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801989:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80198d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801991:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801999:	48 89 ce             	mov    %rcx,%rsi
  80199c:	48 89 c7             	mov    %rax,%rdi
  80199f:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  8019a6:	00 00 00 
  8019a9:	ff d0                	callq  *%rax
  8019ab:	c9                   	leaveq 
  8019ac:	c3                   	retq   

00000000008019ad <memcmp>:
  8019ad:	55                   	push   %rbp
  8019ae:	48 89 e5             	mov    %rsp,%rbp
  8019b1:	48 83 ec 28          	sub    $0x28,%rsp
  8019b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8019b9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8019bd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8019c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8019c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8019cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8019d1:	eb 36                	jmp    801a09 <memcmp+0x5c>
  8019d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019d7:	0f b6 10             	movzbl (%rax),%edx
  8019da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8019de:	0f b6 00             	movzbl (%rax),%eax
  8019e1:	38 c2                	cmp    %al,%dl
  8019e3:	74 1a                	je     8019ff <memcmp+0x52>
  8019e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019e9:	0f b6 00             	movzbl (%rax),%eax
  8019ec:	0f b6 d0             	movzbl %al,%edx
  8019ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8019f3:	0f b6 00             	movzbl (%rax),%eax
  8019f6:	0f b6 c0             	movzbl %al,%eax
  8019f9:	29 c2                	sub    %eax,%edx
  8019fb:	89 d0                	mov    %edx,%eax
  8019fd:	eb 20                	jmp    801a1f <memcmp+0x72>
  8019ff:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801a04:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801a09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a0d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801a11:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801a15:	48 85 c0             	test   %rax,%rax
  801a18:	75 b9                	jne    8019d3 <memcmp+0x26>
  801a1a:	b8 00 00 00 00       	mov    $0x0,%eax
  801a1f:	c9                   	leaveq 
  801a20:	c3                   	retq   

0000000000801a21 <memfind>:
  801a21:	55                   	push   %rbp
  801a22:	48 89 e5             	mov    %rsp,%rbp
  801a25:	48 83 ec 28          	sub    $0x28,%rsp
  801a29:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801a2d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801a30:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801a34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a38:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801a3c:	48 01 d0             	add    %rdx,%rax
  801a3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801a43:	eb 15                	jmp    801a5a <memfind+0x39>
  801a45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a49:	0f b6 10             	movzbl (%rax),%edx
  801a4c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801a4f:	38 c2                	cmp    %al,%dl
  801a51:	75 02                	jne    801a55 <memfind+0x34>
  801a53:	eb 0f                	jmp    801a64 <memfind+0x43>
  801a55:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801a5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a5e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801a62:	72 e1                	jb     801a45 <memfind+0x24>
  801a64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a68:	c9                   	leaveq 
  801a69:	c3                   	retq   

0000000000801a6a <strtol>:
  801a6a:	55                   	push   %rbp
  801a6b:	48 89 e5             	mov    %rsp,%rbp
  801a6e:	48 83 ec 34          	sub    $0x34,%rsp
  801a72:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801a76:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801a7a:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801a7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801a84:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801a8b:	00 
  801a8c:	eb 05                	jmp    801a93 <strtol+0x29>
  801a8e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801a93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a97:	0f b6 00             	movzbl (%rax),%eax
  801a9a:	3c 20                	cmp    $0x20,%al
  801a9c:	74 f0                	je     801a8e <strtol+0x24>
  801a9e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801aa2:	0f b6 00             	movzbl (%rax),%eax
  801aa5:	3c 09                	cmp    $0x9,%al
  801aa7:	74 e5                	je     801a8e <strtol+0x24>
  801aa9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801aad:	0f b6 00             	movzbl (%rax),%eax
  801ab0:	3c 2b                	cmp    $0x2b,%al
  801ab2:	75 07                	jne    801abb <strtol+0x51>
  801ab4:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801ab9:	eb 17                	jmp    801ad2 <strtol+0x68>
  801abb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801abf:	0f b6 00             	movzbl (%rax),%eax
  801ac2:	3c 2d                	cmp    $0x2d,%al
  801ac4:	75 0c                	jne    801ad2 <strtol+0x68>
  801ac6:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801acb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801ad2:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801ad6:	74 06                	je     801ade <strtol+0x74>
  801ad8:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801adc:	75 28                	jne    801b06 <strtol+0x9c>
  801ade:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ae2:	0f b6 00             	movzbl (%rax),%eax
  801ae5:	3c 30                	cmp    $0x30,%al
  801ae7:	75 1d                	jne    801b06 <strtol+0x9c>
  801ae9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801aed:	48 83 c0 01          	add    $0x1,%rax
  801af1:	0f b6 00             	movzbl (%rax),%eax
  801af4:	3c 78                	cmp    $0x78,%al
  801af6:	75 0e                	jne    801b06 <strtol+0x9c>
  801af8:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801afd:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801b04:	eb 2c                	jmp    801b32 <strtol+0xc8>
  801b06:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801b0a:	75 19                	jne    801b25 <strtol+0xbb>
  801b0c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b10:	0f b6 00             	movzbl (%rax),%eax
  801b13:	3c 30                	cmp    $0x30,%al
  801b15:	75 0e                	jne    801b25 <strtol+0xbb>
  801b17:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801b1c:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801b23:	eb 0d                	jmp    801b32 <strtol+0xc8>
  801b25:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801b29:	75 07                	jne    801b32 <strtol+0xc8>
  801b2b:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801b32:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b36:	0f b6 00             	movzbl (%rax),%eax
  801b39:	3c 2f                	cmp    $0x2f,%al
  801b3b:	7e 1d                	jle    801b5a <strtol+0xf0>
  801b3d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b41:	0f b6 00             	movzbl (%rax),%eax
  801b44:	3c 39                	cmp    $0x39,%al
  801b46:	7f 12                	jg     801b5a <strtol+0xf0>
  801b48:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b4c:	0f b6 00             	movzbl (%rax),%eax
  801b4f:	0f be c0             	movsbl %al,%eax
  801b52:	83 e8 30             	sub    $0x30,%eax
  801b55:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801b58:	eb 4e                	jmp    801ba8 <strtol+0x13e>
  801b5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b5e:	0f b6 00             	movzbl (%rax),%eax
  801b61:	3c 60                	cmp    $0x60,%al
  801b63:	7e 1d                	jle    801b82 <strtol+0x118>
  801b65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b69:	0f b6 00             	movzbl (%rax),%eax
  801b6c:	3c 7a                	cmp    $0x7a,%al
  801b6e:	7f 12                	jg     801b82 <strtol+0x118>
  801b70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b74:	0f b6 00             	movzbl (%rax),%eax
  801b77:	0f be c0             	movsbl %al,%eax
  801b7a:	83 e8 57             	sub    $0x57,%eax
  801b7d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801b80:	eb 26                	jmp    801ba8 <strtol+0x13e>
  801b82:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b86:	0f b6 00             	movzbl (%rax),%eax
  801b89:	3c 40                	cmp    $0x40,%al
  801b8b:	7e 48                	jle    801bd5 <strtol+0x16b>
  801b8d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b91:	0f b6 00             	movzbl (%rax),%eax
  801b94:	3c 5a                	cmp    $0x5a,%al
  801b96:	7f 3d                	jg     801bd5 <strtol+0x16b>
  801b98:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b9c:	0f b6 00             	movzbl (%rax),%eax
  801b9f:	0f be c0             	movsbl %al,%eax
  801ba2:	83 e8 37             	sub    $0x37,%eax
  801ba5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801ba8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801bab:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801bae:	7c 02                	jl     801bb2 <strtol+0x148>
  801bb0:	eb 23                	jmp    801bd5 <strtol+0x16b>
  801bb2:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801bb7:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801bba:	48 98                	cltq   
  801bbc:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801bc1:	48 89 c2             	mov    %rax,%rdx
  801bc4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801bc7:	48 98                	cltq   
  801bc9:	48 01 d0             	add    %rdx,%rax
  801bcc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801bd0:	e9 5d ff ff ff       	jmpq   801b32 <strtol+0xc8>
  801bd5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801bda:	74 0b                	je     801be7 <strtol+0x17d>
  801bdc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801be0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801be4:	48 89 10             	mov    %rdx,(%rax)
  801be7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801beb:	74 09                	je     801bf6 <strtol+0x18c>
  801bed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801bf1:	48 f7 d8             	neg    %rax
  801bf4:	eb 04                	jmp    801bfa <strtol+0x190>
  801bf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801bfa:	c9                   	leaveq 
  801bfb:	c3                   	retq   

0000000000801bfc <strstr>:
  801bfc:	55                   	push   %rbp
  801bfd:	48 89 e5             	mov    %rsp,%rbp
  801c00:	48 83 ec 30          	sub    $0x30,%rsp
  801c04:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801c08:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801c0c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801c10:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801c14:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801c18:	0f b6 00             	movzbl (%rax),%eax
  801c1b:	88 45 ff             	mov    %al,-0x1(%rbp)
  801c1e:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801c22:	75 06                	jne    801c2a <strstr+0x2e>
  801c24:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c28:	eb 6b                	jmp    801c95 <strstr+0x99>
  801c2a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801c2e:	48 89 c7             	mov    %rax,%rdi
  801c31:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  801c38:	00 00 00 
  801c3b:	ff d0                	callq  *%rax
  801c3d:	48 98                	cltq   
  801c3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801c43:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c47:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801c4b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801c4f:	0f b6 00             	movzbl (%rax),%eax
  801c52:	88 45 ef             	mov    %al,-0x11(%rbp)
  801c55:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801c59:	75 07                	jne    801c62 <strstr+0x66>
  801c5b:	b8 00 00 00 00       	mov    $0x0,%eax
  801c60:	eb 33                	jmp    801c95 <strstr+0x99>
  801c62:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801c66:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801c69:	75 d8                	jne    801c43 <strstr+0x47>
  801c6b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c6f:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801c73:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c77:	48 89 ce             	mov    %rcx,%rsi
  801c7a:	48 89 c7             	mov    %rax,%rdi
  801c7d:	48 b8 f3 16 80 00 00 	movabs $0x8016f3,%rax
  801c84:	00 00 00 
  801c87:	ff d0                	callq  *%rax
  801c89:	85 c0                	test   %eax,%eax
  801c8b:	75 b6                	jne    801c43 <strstr+0x47>
  801c8d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c91:	48 83 e8 01          	sub    $0x1,%rax
  801c95:	c9                   	leaveq 
  801c96:	c3                   	retq   

0000000000801c97 <syscall>:
  801c97:	55                   	push   %rbp
  801c98:	48 89 e5             	mov    %rsp,%rbp
  801c9b:	53                   	push   %rbx
  801c9c:	48 83 ec 48          	sub    $0x48,%rsp
  801ca0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801ca3:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801ca6:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801caa:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801cae:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801cb2:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801cb6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801cb9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801cbd:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801cc1:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801cc5:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801cc9:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801ccd:	4c 89 c3             	mov    %r8,%rbx
  801cd0:	cd 30                	int    $0x30
  801cd2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801cd6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801cda:	74 3e                	je     801d1a <syscall+0x83>
  801cdc:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801ce1:	7e 37                	jle    801d1a <syscall+0x83>
  801ce3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801ce7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801cea:	49 89 d0             	mov    %rdx,%r8
  801ced:	89 c1                	mov    %eax,%ecx
  801cef:	48 ba 88 55 80 00 00 	movabs $0x805588,%rdx
  801cf6:	00 00 00 
  801cf9:	be 24 00 00 00       	mov    $0x24,%esi
  801cfe:	48 bf a5 55 80 00 00 	movabs $0x8055a5,%rdi
  801d05:	00 00 00 
  801d08:	b8 00 00 00 00       	mov    $0x0,%eax
  801d0d:	49 b9 50 07 80 00 00 	movabs $0x800750,%r9
  801d14:	00 00 00 
  801d17:	41 ff d1             	callq  *%r9
  801d1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d1e:	48 83 c4 48          	add    $0x48,%rsp
  801d22:	5b                   	pop    %rbx
  801d23:	5d                   	pop    %rbp
  801d24:	c3                   	retq   

0000000000801d25 <sys_cputs>:
  801d25:	55                   	push   %rbp
  801d26:	48 89 e5             	mov    %rsp,%rbp
  801d29:	48 83 ec 20          	sub    $0x20,%rsp
  801d2d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d31:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d39:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d3d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d44:	00 
  801d45:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d4b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d51:	48 89 d1             	mov    %rdx,%rcx
  801d54:	48 89 c2             	mov    %rax,%rdx
  801d57:	be 00 00 00 00       	mov    $0x0,%esi
  801d5c:	bf 00 00 00 00       	mov    $0x0,%edi
  801d61:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801d68:	00 00 00 
  801d6b:	ff d0                	callq  *%rax
  801d6d:	c9                   	leaveq 
  801d6e:	c3                   	retq   

0000000000801d6f <sys_cgetc>:
  801d6f:	55                   	push   %rbp
  801d70:	48 89 e5             	mov    %rsp,%rbp
  801d73:	48 83 ec 10          	sub    $0x10,%rsp
  801d77:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d7e:	00 
  801d7f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d85:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d8b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d90:	ba 00 00 00 00       	mov    $0x0,%edx
  801d95:	be 00 00 00 00       	mov    $0x0,%esi
  801d9a:	bf 01 00 00 00       	mov    $0x1,%edi
  801d9f:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801da6:	00 00 00 
  801da9:	ff d0                	callq  *%rax
  801dab:	c9                   	leaveq 
  801dac:	c3                   	retq   

0000000000801dad <sys_env_destroy>:
  801dad:	55                   	push   %rbp
  801dae:	48 89 e5             	mov    %rsp,%rbp
  801db1:	48 83 ec 10          	sub    $0x10,%rsp
  801db5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801db8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dbb:	48 98                	cltq   
  801dbd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dc4:	00 
  801dc5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dcb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dd1:	b9 00 00 00 00       	mov    $0x0,%ecx
  801dd6:	48 89 c2             	mov    %rax,%rdx
  801dd9:	be 01 00 00 00       	mov    $0x1,%esi
  801dde:	bf 03 00 00 00       	mov    $0x3,%edi
  801de3:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801dea:	00 00 00 
  801ded:	ff d0                	callq  *%rax
  801def:	c9                   	leaveq 
  801df0:	c3                   	retq   

0000000000801df1 <sys_getenvid>:
  801df1:	55                   	push   %rbp
  801df2:	48 89 e5             	mov    %rsp,%rbp
  801df5:	48 83 ec 10          	sub    $0x10,%rsp
  801df9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e00:	00 
  801e01:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e07:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e0d:	b9 00 00 00 00       	mov    $0x0,%ecx
  801e12:	ba 00 00 00 00       	mov    $0x0,%edx
  801e17:	be 00 00 00 00       	mov    $0x0,%esi
  801e1c:	bf 02 00 00 00       	mov    $0x2,%edi
  801e21:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801e28:	00 00 00 
  801e2b:	ff d0                	callq  *%rax
  801e2d:	c9                   	leaveq 
  801e2e:	c3                   	retq   

0000000000801e2f <sys_yield>:
  801e2f:	55                   	push   %rbp
  801e30:	48 89 e5             	mov    %rsp,%rbp
  801e33:	48 83 ec 10          	sub    $0x10,%rsp
  801e37:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e3e:	00 
  801e3f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e45:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e4b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801e50:	ba 00 00 00 00       	mov    $0x0,%edx
  801e55:	be 00 00 00 00       	mov    $0x0,%esi
  801e5a:	bf 0b 00 00 00       	mov    $0xb,%edi
  801e5f:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801e66:	00 00 00 
  801e69:	ff d0                	callq  *%rax
  801e6b:	c9                   	leaveq 
  801e6c:	c3                   	retq   

0000000000801e6d <sys_page_alloc>:
  801e6d:	55                   	push   %rbp
  801e6e:	48 89 e5             	mov    %rsp,%rbp
  801e71:	48 83 ec 20          	sub    $0x20,%rsp
  801e75:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e78:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e7c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e7f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e82:	48 63 c8             	movslq %eax,%rcx
  801e85:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e89:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e8c:	48 98                	cltq   
  801e8e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e95:	00 
  801e96:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e9c:	49 89 c8             	mov    %rcx,%r8
  801e9f:	48 89 d1             	mov    %rdx,%rcx
  801ea2:	48 89 c2             	mov    %rax,%rdx
  801ea5:	be 01 00 00 00       	mov    $0x1,%esi
  801eaa:	bf 04 00 00 00       	mov    $0x4,%edi
  801eaf:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801eb6:	00 00 00 
  801eb9:	ff d0                	callq  *%rax
  801ebb:	c9                   	leaveq 
  801ebc:	c3                   	retq   

0000000000801ebd <sys_page_map>:
  801ebd:	55                   	push   %rbp
  801ebe:	48 89 e5             	mov    %rsp,%rbp
  801ec1:	48 83 ec 30          	sub    $0x30,%rsp
  801ec5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ec8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ecc:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801ecf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801ed3:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801ed7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801eda:	48 63 c8             	movslq %eax,%rcx
  801edd:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801ee1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801ee4:	48 63 f0             	movslq %eax,%rsi
  801ee7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801eeb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801eee:	48 98                	cltq   
  801ef0:	48 89 0c 24          	mov    %rcx,(%rsp)
  801ef4:	49 89 f9             	mov    %rdi,%r9
  801ef7:	49 89 f0             	mov    %rsi,%r8
  801efa:	48 89 d1             	mov    %rdx,%rcx
  801efd:	48 89 c2             	mov    %rax,%rdx
  801f00:	be 01 00 00 00       	mov    $0x1,%esi
  801f05:	bf 05 00 00 00       	mov    $0x5,%edi
  801f0a:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801f11:	00 00 00 
  801f14:	ff d0                	callq  *%rax
  801f16:	c9                   	leaveq 
  801f17:	c3                   	retq   

0000000000801f18 <sys_page_unmap>:
  801f18:	55                   	push   %rbp
  801f19:	48 89 e5             	mov    %rsp,%rbp
  801f1c:	48 83 ec 20          	sub    $0x20,%rsp
  801f20:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f23:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f27:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f2e:	48 98                	cltq   
  801f30:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f37:	00 
  801f38:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f3e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f44:	48 89 d1             	mov    %rdx,%rcx
  801f47:	48 89 c2             	mov    %rax,%rdx
  801f4a:	be 01 00 00 00       	mov    $0x1,%esi
  801f4f:	bf 06 00 00 00       	mov    $0x6,%edi
  801f54:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801f5b:	00 00 00 
  801f5e:	ff d0                	callq  *%rax
  801f60:	c9                   	leaveq 
  801f61:	c3                   	retq   

0000000000801f62 <sys_env_set_status>:
  801f62:	55                   	push   %rbp
  801f63:	48 89 e5             	mov    %rsp,%rbp
  801f66:	48 83 ec 10          	sub    $0x10,%rsp
  801f6a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f6d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801f70:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f73:	48 63 d0             	movslq %eax,%rdx
  801f76:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f79:	48 98                	cltq   
  801f7b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f82:	00 
  801f83:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f89:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f8f:	48 89 d1             	mov    %rdx,%rcx
  801f92:	48 89 c2             	mov    %rax,%rdx
  801f95:	be 01 00 00 00       	mov    $0x1,%esi
  801f9a:	bf 08 00 00 00       	mov    $0x8,%edi
  801f9f:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801fa6:	00 00 00 
  801fa9:	ff d0                	callq  *%rax
  801fab:	c9                   	leaveq 
  801fac:	c3                   	retq   

0000000000801fad <sys_env_set_trapframe>:
  801fad:	55                   	push   %rbp
  801fae:	48 89 e5             	mov    %rsp,%rbp
  801fb1:	48 83 ec 20          	sub    $0x20,%rsp
  801fb5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801fb8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801fbc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801fc0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fc3:	48 98                	cltq   
  801fc5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fcc:	00 
  801fcd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fd3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801fd9:	48 89 d1             	mov    %rdx,%rcx
  801fdc:	48 89 c2             	mov    %rax,%rdx
  801fdf:	be 01 00 00 00       	mov    $0x1,%esi
  801fe4:	bf 09 00 00 00       	mov    $0x9,%edi
  801fe9:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  801ff0:	00 00 00 
  801ff3:	ff d0                	callq  *%rax
  801ff5:	c9                   	leaveq 
  801ff6:	c3                   	retq   

0000000000801ff7 <sys_env_set_pgfault_upcall>:
  801ff7:	55                   	push   %rbp
  801ff8:	48 89 e5             	mov    %rsp,%rbp
  801ffb:	48 83 ec 20          	sub    $0x20,%rsp
  801fff:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802002:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802006:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80200a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80200d:	48 98                	cltq   
  80200f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802016:	00 
  802017:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80201d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802023:	48 89 d1             	mov    %rdx,%rcx
  802026:	48 89 c2             	mov    %rax,%rdx
  802029:	be 01 00 00 00       	mov    $0x1,%esi
  80202e:	bf 0a 00 00 00       	mov    $0xa,%edi
  802033:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  80203a:	00 00 00 
  80203d:	ff d0                	callq  *%rax
  80203f:	c9                   	leaveq 
  802040:	c3                   	retq   

0000000000802041 <sys_ipc_try_send>:
  802041:	55                   	push   %rbp
  802042:	48 89 e5             	mov    %rsp,%rbp
  802045:	48 83 ec 20          	sub    $0x20,%rsp
  802049:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80204c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802050:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802054:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  802057:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80205a:	48 63 f0             	movslq %eax,%rsi
  80205d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802061:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802064:	48 98                	cltq   
  802066:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80206a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802071:	00 
  802072:	49 89 f1             	mov    %rsi,%r9
  802075:	49 89 c8             	mov    %rcx,%r8
  802078:	48 89 d1             	mov    %rdx,%rcx
  80207b:	48 89 c2             	mov    %rax,%rdx
  80207e:	be 00 00 00 00       	mov    $0x0,%esi
  802083:	bf 0c 00 00 00       	mov    $0xc,%edi
  802088:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  80208f:	00 00 00 
  802092:	ff d0                	callq  *%rax
  802094:	c9                   	leaveq 
  802095:	c3                   	retq   

0000000000802096 <sys_ipc_recv>:
  802096:	55                   	push   %rbp
  802097:	48 89 e5             	mov    %rsp,%rbp
  80209a:	48 83 ec 10          	sub    $0x10,%rsp
  80209e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8020a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8020a6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8020ad:	00 
  8020ae:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8020b4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020ba:	b9 00 00 00 00       	mov    $0x0,%ecx
  8020bf:	48 89 c2             	mov    %rax,%rdx
  8020c2:	be 01 00 00 00       	mov    $0x1,%esi
  8020c7:	bf 0d 00 00 00       	mov    $0xd,%edi
  8020cc:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  8020d3:	00 00 00 
  8020d6:	ff d0                	callq  *%rax
  8020d8:	c9                   	leaveq 
  8020d9:	c3                   	retq   

00000000008020da <sys_time_msec>:
  8020da:	55                   	push   %rbp
  8020db:	48 89 e5             	mov    %rsp,%rbp
  8020de:	48 83 ec 10          	sub    $0x10,%rsp
  8020e2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8020e9:	00 
  8020ea:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8020f0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020f6:	b9 00 00 00 00       	mov    $0x0,%ecx
  8020fb:	ba 00 00 00 00       	mov    $0x0,%edx
  802100:	be 00 00 00 00       	mov    $0x0,%esi
  802105:	bf 0e 00 00 00       	mov    $0xe,%edi
  80210a:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  802111:	00 00 00 
  802114:	ff d0                	callq  *%rax
  802116:	c9                   	leaveq 
  802117:	c3                   	retq   

0000000000802118 <sys_net_transmit>:
  802118:	55                   	push   %rbp
  802119:	48 89 e5             	mov    %rsp,%rbp
  80211c:	48 83 ec 20          	sub    $0x20,%rsp
  802120:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802124:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802127:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80212a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80212e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802135:	00 
  802136:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80213c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802142:	48 89 d1             	mov    %rdx,%rcx
  802145:	48 89 c2             	mov    %rax,%rdx
  802148:	be 00 00 00 00       	mov    $0x0,%esi
  80214d:	bf 0f 00 00 00       	mov    $0xf,%edi
  802152:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  802159:	00 00 00 
  80215c:	ff d0                	callq  *%rax
  80215e:	c9                   	leaveq 
  80215f:	c3                   	retq   

0000000000802160 <sys_net_receive>:
  802160:	55                   	push   %rbp
  802161:	48 89 e5             	mov    %rsp,%rbp
  802164:	48 83 ec 20          	sub    $0x20,%rsp
  802168:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80216c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80216f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802172:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802176:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80217d:	00 
  80217e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802184:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80218a:	48 89 d1             	mov    %rdx,%rcx
  80218d:	48 89 c2             	mov    %rax,%rdx
  802190:	be 00 00 00 00       	mov    $0x0,%esi
  802195:	bf 10 00 00 00       	mov    $0x10,%edi
  80219a:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  8021a1:	00 00 00 
  8021a4:	ff d0                	callq  *%rax
  8021a6:	c9                   	leaveq 
  8021a7:	c3                   	retq   

00000000008021a8 <sys_ept_map>:
  8021a8:	55                   	push   %rbp
  8021a9:	48 89 e5             	mov    %rsp,%rbp
  8021ac:	48 83 ec 30          	sub    $0x30,%rsp
  8021b0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8021b3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8021b7:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8021ba:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8021be:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8021c2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8021c5:	48 63 c8             	movslq %eax,%rcx
  8021c8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8021cc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8021cf:	48 63 f0             	movslq %eax,%rsi
  8021d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8021d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021d9:	48 98                	cltq   
  8021db:	48 89 0c 24          	mov    %rcx,(%rsp)
  8021df:	49 89 f9             	mov    %rdi,%r9
  8021e2:	49 89 f0             	mov    %rsi,%r8
  8021e5:	48 89 d1             	mov    %rdx,%rcx
  8021e8:	48 89 c2             	mov    %rax,%rdx
  8021eb:	be 00 00 00 00       	mov    $0x0,%esi
  8021f0:	bf 11 00 00 00       	mov    $0x11,%edi
  8021f5:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  8021fc:	00 00 00 
  8021ff:	ff d0                	callq  *%rax
  802201:	c9                   	leaveq 
  802202:	c3                   	retq   

0000000000802203 <sys_env_mkguest>:
  802203:	55                   	push   %rbp
  802204:	48 89 e5             	mov    %rsp,%rbp
  802207:	48 83 ec 20          	sub    $0x20,%rsp
  80220b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80220f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802213:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802217:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80221b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802222:	00 
  802223:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802229:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80222f:	48 89 d1             	mov    %rdx,%rcx
  802232:	48 89 c2             	mov    %rax,%rdx
  802235:	be 00 00 00 00       	mov    $0x0,%esi
  80223a:	bf 12 00 00 00       	mov    $0x12,%edi
  80223f:	48 b8 97 1c 80 00 00 	movabs $0x801c97,%rax
  802246:	00 00 00 
  802249:	ff d0                	callq  *%rax
  80224b:	c9                   	leaveq 
  80224c:	c3                   	retq   

000000000080224d <fd2num>:
  80224d:	55                   	push   %rbp
  80224e:	48 89 e5             	mov    %rsp,%rbp
  802251:	48 83 ec 08          	sub    $0x8,%rsp
  802255:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802259:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80225d:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  802264:	ff ff ff 
  802267:	48 01 d0             	add    %rdx,%rax
  80226a:	48 c1 e8 0c          	shr    $0xc,%rax
  80226e:	c9                   	leaveq 
  80226f:	c3                   	retq   

0000000000802270 <fd2data>:
  802270:	55                   	push   %rbp
  802271:	48 89 e5             	mov    %rsp,%rbp
  802274:	48 83 ec 08          	sub    $0x8,%rsp
  802278:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80227c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802280:	48 89 c7             	mov    %rax,%rdi
  802283:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  80228a:	00 00 00 
  80228d:	ff d0                	callq  *%rax
  80228f:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802295:	48 c1 e0 0c          	shl    $0xc,%rax
  802299:	c9                   	leaveq 
  80229a:	c3                   	retq   

000000000080229b <fd_alloc>:
  80229b:	55                   	push   %rbp
  80229c:	48 89 e5             	mov    %rsp,%rbp
  80229f:	48 83 ec 18          	sub    $0x18,%rsp
  8022a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8022a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8022ae:	eb 6b                	jmp    80231b <fd_alloc+0x80>
  8022b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022b3:	48 98                	cltq   
  8022b5:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8022bb:	48 c1 e0 0c          	shl    $0xc,%rax
  8022bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8022c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022c7:	48 c1 e8 15          	shr    $0x15,%rax
  8022cb:	48 89 c2             	mov    %rax,%rdx
  8022ce:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8022d5:	01 00 00 
  8022d8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8022dc:	83 e0 01             	and    $0x1,%eax
  8022df:	48 85 c0             	test   %rax,%rax
  8022e2:	74 21                	je     802305 <fd_alloc+0x6a>
  8022e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022e8:	48 c1 e8 0c          	shr    $0xc,%rax
  8022ec:	48 89 c2             	mov    %rax,%rdx
  8022ef:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8022f6:	01 00 00 
  8022f9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8022fd:	83 e0 01             	and    $0x1,%eax
  802300:	48 85 c0             	test   %rax,%rax
  802303:	75 12                	jne    802317 <fd_alloc+0x7c>
  802305:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802309:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80230d:	48 89 10             	mov    %rdx,(%rax)
  802310:	b8 00 00 00 00       	mov    $0x0,%eax
  802315:	eb 1a                	jmp    802331 <fd_alloc+0x96>
  802317:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80231b:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80231f:	7e 8f                	jle    8022b0 <fd_alloc+0x15>
  802321:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802325:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80232c:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802331:	c9                   	leaveq 
  802332:	c3                   	retq   

0000000000802333 <fd_lookup>:
  802333:	55                   	push   %rbp
  802334:	48 89 e5             	mov    %rsp,%rbp
  802337:	48 83 ec 20          	sub    $0x20,%rsp
  80233b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80233e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802342:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802346:	78 06                	js     80234e <fd_lookup+0x1b>
  802348:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  80234c:	7e 07                	jle    802355 <fd_lookup+0x22>
  80234e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802353:	eb 6c                	jmp    8023c1 <fd_lookup+0x8e>
  802355:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802358:	48 98                	cltq   
  80235a:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802360:	48 c1 e0 0c          	shl    $0xc,%rax
  802364:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80236c:	48 c1 e8 15          	shr    $0x15,%rax
  802370:	48 89 c2             	mov    %rax,%rdx
  802373:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80237a:	01 00 00 
  80237d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802381:	83 e0 01             	and    $0x1,%eax
  802384:	48 85 c0             	test   %rax,%rax
  802387:	74 21                	je     8023aa <fd_lookup+0x77>
  802389:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80238d:	48 c1 e8 0c          	shr    $0xc,%rax
  802391:	48 89 c2             	mov    %rax,%rdx
  802394:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80239b:	01 00 00 
  80239e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023a2:	83 e0 01             	and    $0x1,%eax
  8023a5:	48 85 c0             	test   %rax,%rax
  8023a8:	75 07                	jne    8023b1 <fd_lookup+0x7e>
  8023aa:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8023af:	eb 10                	jmp    8023c1 <fd_lookup+0x8e>
  8023b1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8023b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8023b9:	48 89 10             	mov    %rdx,(%rax)
  8023bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8023c1:	c9                   	leaveq 
  8023c2:	c3                   	retq   

00000000008023c3 <fd_close>:
  8023c3:	55                   	push   %rbp
  8023c4:	48 89 e5             	mov    %rsp,%rbp
  8023c7:	48 83 ec 30          	sub    $0x30,%rsp
  8023cb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8023cf:	89 f0                	mov    %esi,%eax
  8023d1:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8023d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8023d8:	48 89 c7             	mov    %rax,%rdi
  8023db:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  8023e2:	00 00 00 
  8023e5:	ff d0                	callq  *%rax
  8023e7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8023eb:	48 89 d6             	mov    %rdx,%rsi
  8023ee:	89 c7                	mov    %eax,%edi
  8023f0:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8023f7:	00 00 00 
  8023fa:	ff d0                	callq  *%rax
  8023fc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023ff:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802403:	78 0a                	js     80240f <fd_close+0x4c>
  802405:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802409:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  80240d:	74 12                	je     802421 <fd_close+0x5e>
  80240f:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802413:	74 05                	je     80241a <fd_close+0x57>
  802415:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802418:	eb 05                	jmp    80241f <fd_close+0x5c>
  80241a:	b8 00 00 00 00       	mov    $0x0,%eax
  80241f:	eb 69                	jmp    80248a <fd_close+0xc7>
  802421:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802425:	8b 00                	mov    (%rax),%eax
  802427:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80242b:	48 89 d6             	mov    %rdx,%rsi
  80242e:	89 c7                	mov    %eax,%edi
  802430:	48 b8 8c 24 80 00 00 	movabs $0x80248c,%rax
  802437:	00 00 00 
  80243a:	ff d0                	callq  *%rax
  80243c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80243f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802443:	78 2a                	js     80246f <fd_close+0xac>
  802445:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802449:	48 8b 40 20          	mov    0x20(%rax),%rax
  80244d:	48 85 c0             	test   %rax,%rax
  802450:	74 16                	je     802468 <fd_close+0xa5>
  802452:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802456:	48 8b 40 20          	mov    0x20(%rax),%rax
  80245a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80245e:	48 89 d7             	mov    %rdx,%rdi
  802461:	ff d0                	callq  *%rax
  802463:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802466:	eb 07                	jmp    80246f <fd_close+0xac>
  802468:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80246f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802473:	48 89 c6             	mov    %rax,%rsi
  802476:	bf 00 00 00 00       	mov    $0x0,%edi
  80247b:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  802482:	00 00 00 
  802485:	ff d0                	callq  *%rax
  802487:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80248a:	c9                   	leaveq 
  80248b:	c3                   	retq   

000000000080248c <dev_lookup>:
  80248c:	55                   	push   %rbp
  80248d:	48 89 e5             	mov    %rsp,%rbp
  802490:	48 83 ec 20          	sub    $0x20,%rsp
  802494:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802497:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80249b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8024a2:	eb 41                	jmp    8024e5 <dev_lookup+0x59>
  8024a4:	48 b8 c0 87 80 00 00 	movabs $0x8087c0,%rax
  8024ab:	00 00 00 
  8024ae:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8024b1:	48 63 d2             	movslq %edx,%rdx
  8024b4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8024b8:	8b 00                	mov    (%rax),%eax
  8024ba:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8024bd:	75 22                	jne    8024e1 <dev_lookup+0x55>
  8024bf:	48 b8 c0 87 80 00 00 	movabs $0x8087c0,%rax
  8024c6:	00 00 00 
  8024c9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8024cc:	48 63 d2             	movslq %edx,%rdx
  8024cf:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8024d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8024d7:	48 89 10             	mov    %rdx,(%rax)
  8024da:	b8 00 00 00 00       	mov    $0x0,%eax
  8024df:	eb 60                	jmp    802541 <dev_lookup+0xb5>
  8024e1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8024e5:	48 b8 c0 87 80 00 00 	movabs $0x8087c0,%rax
  8024ec:	00 00 00 
  8024ef:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8024f2:	48 63 d2             	movslq %edx,%rdx
  8024f5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8024f9:	48 85 c0             	test   %rax,%rax
  8024fc:	75 a6                	jne    8024a4 <dev_lookup+0x18>
  8024fe:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  802505:	00 00 00 
  802508:	48 8b 00             	mov    (%rax),%rax
  80250b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802511:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802514:	89 c6                	mov    %eax,%esi
  802516:	48 bf b8 55 80 00 00 	movabs $0x8055b8,%rdi
  80251d:	00 00 00 
  802520:	b8 00 00 00 00       	mov    $0x0,%eax
  802525:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  80252c:	00 00 00 
  80252f:	ff d1                	callq  *%rcx
  802531:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802535:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80253c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802541:	c9                   	leaveq 
  802542:	c3                   	retq   

0000000000802543 <close>:
  802543:	55                   	push   %rbp
  802544:	48 89 e5             	mov    %rsp,%rbp
  802547:	48 83 ec 20          	sub    $0x20,%rsp
  80254b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80254e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802552:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802555:	48 89 d6             	mov    %rdx,%rsi
  802558:	89 c7                	mov    %eax,%edi
  80255a:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  802561:	00 00 00 
  802564:	ff d0                	callq  *%rax
  802566:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802569:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80256d:	79 05                	jns    802574 <close+0x31>
  80256f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802572:	eb 18                	jmp    80258c <close+0x49>
  802574:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802578:	be 01 00 00 00       	mov    $0x1,%esi
  80257d:	48 89 c7             	mov    %rax,%rdi
  802580:	48 b8 c3 23 80 00 00 	movabs $0x8023c3,%rax
  802587:	00 00 00 
  80258a:	ff d0                	callq  *%rax
  80258c:	c9                   	leaveq 
  80258d:	c3                   	retq   

000000000080258e <close_all>:
  80258e:	55                   	push   %rbp
  80258f:	48 89 e5             	mov    %rsp,%rbp
  802592:	48 83 ec 10          	sub    $0x10,%rsp
  802596:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80259d:	eb 15                	jmp    8025b4 <close_all+0x26>
  80259f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025a2:	89 c7                	mov    %eax,%edi
  8025a4:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  8025ab:	00 00 00 
  8025ae:	ff d0                	callq  *%rax
  8025b0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8025b4:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8025b8:	7e e5                	jle    80259f <close_all+0x11>
  8025ba:	c9                   	leaveq 
  8025bb:	c3                   	retq   

00000000008025bc <dup>:
  8025bc:	55                   	push   %rbp
  8025bd:	48 89 e5             	mov    %rsp,%rbp
  8025c0:	48 83 ec 40          	sub    $0x40,%rsp
  8025c4:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8025c7:	89 75 c8             	mov    %esi,-0x38(%rbp)
  8025ca:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8025ce:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8025d1:	48 89 d6             	mov    %rdx,%rsi
  8025d4:	89 c7                	mov    %eax,%edi
  8025d6:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8025dd:	00 00 00 
  8025e0:	ff d0                	callq  *%rax
  8025e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025e9:	79 08                	jns    8025f3 <dup+0x37>
  8025eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025ee:	e9 70 01 00 00       	jmpq   802763 <dup+0x1a7>
  8025f3:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8025f6:	89 c7                	mov    %eax,%edi
  8025f8:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  8025ff:	00 00 00 
  802602:	ff d0                	callq  *%rax
  802604:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802607:	48 98                	cltq   
  802609:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80260f:	48 c1 e0 0c          	shl    $0xc,%rax
  802613:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802617:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80261b:	48 89 c7             	mov    %rax,%rdi
  80261e:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  802625:	00 00 00 
  802628:	ff d0                	callq  *%rax
  80262a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80262e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802632:	48 89 c7             	mov    %rax,%rdi
  802635:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  80263c:	00 00 00 
  80263f:	ff d0                	callq  *%rax
  802641:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802645:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802649:	48 c1 e8 15          	shr    $0x15,%rax
  80264d:	48 89 c2             	mov    %rax,%rdx
  802650:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802657:	01 00 00 
  80265a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80265e:	83 e0 01             	and    $0x1,%eax
  802661:	48 85 c0             	test   %rax,%rax
  802664:	74 73                	je     8026d9 <dup+0x11d>
  802666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80266a:	48 c1 e8 0c          	shr    $0xc,%rax
  80266e:	48 89 c2             	mov    %rax,%rdx
  802671:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802678:	01 00 00 
  80267b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80267f:	83 e0 01             	and    $0x1,%eax
  802682:	48 85 c0             	test   %rax,%rax
  802685:	74 52                	je     8026d9 <dup+0x11d>
  802687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80268b:	48 c1 e8 0c          	shr    $0xc,%rax
  80268f:	48 89 c2             	mov    %rax,%rdx
  802692:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802699:	01 00 00 
  80269c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8026a0:	25 07 0e 00 00       	and    $0xe07,%eax
  8026a5:	89 c1                	mov    %eax,%ecx
  8026a7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8026ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026af:	41 89 c8             	mov    %ecx,%r8d
  8026b2:	48 89 d1             	mov    %rdx,%rcx
  8026b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8026ba:	48 89 c6             	mov    %rax,%rsi
  8026bd:	bf 00 00 00 00       	mov    $0x0,%edi
  8026c2:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  8026c9:	00 00 00 
  8026cc:	ff d0                	callq  *%rax
  8026ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026d5:	79 02                	jns    8026d9 <dup+0x11d>
  8026d7:	eb 57                	jmp    802730 <dup+0x174>
  8026d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8026dd:	48 c1 e8 0c          	shr    $0xc,%rax
  8026e1:	48 89 c2             	mov    %rax,%rdx
  8026e4:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8026eb:	01 00 00 
  8026ee:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8026f2:	25 07 0e 00 00       	and    $0xe07,%eax
  8026f7:	89 c1                	mov    %eax,%ecx
  8026f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8026fd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802701:	41 89 c8             	mov    %ecx,%r8d
  802704:	48 89 d1             	mov    %rdx,%rcx
  802707:	ba 00 00 00 00       	mov    $0x0,%edx
  80270c:	48 89 c6             	mov    %rax,%rsi
  80270f:	bf 00 00 00 00       	mov    $0x0,%edi
  802714:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  80271b:	00 00 00 
  80271e:	ff d0                	callq  *%rax
  802720:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802723:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802727:	79 02                	jns    80272b <dup+0x16f>
  802729:	eb 05                	jmp    802730 <dup+0x174>
  80272b:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80272e:	eb 33                	jmp    802763 <dup+0x1a7>
  802730:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802734:	48 89 c6             	mov    %rax,%rsi
  802737:	bf 00 00 00 00       	mov    $0x0,%edi
  80273c:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  802743:	00 00 00 
  802746:	ff d0                	callq  *%rax
  802748:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80274c:	48 89 c6             	mov    %rax,%rsi
  80274f:	bf 00 00 00 00       	mov    $0x0,%edi
  802754:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  80275b:	00 00 00 
  80275e:	ff d0                	callq  *%rax
  802760:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802763:	c9                   	leaveq 
  802764:	c3                   	retq   

0000000000802765 <read>:
  802765:	55                   	push   %rbp
  802766:	48 89 e5             	mov    %rsp,%rbp
  802769:	48 83 ec 40          	sub    $0x40,%rsp
  80276d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802770:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802774:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802778:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80277c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80277f:	48 89 d6             	mov    %rdx,%rsi
  802782:	89 c7                	mov    %eax,%edi
  802784:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  80278b:	00 00 00 
  80278e:	ff d0                	callq  *%rax
  802790:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802793:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802797:	78 24                	js     8027bd <read+0x58>
  802799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80279d:	8b 00                	mov    (%rax),%eax
  80279f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8027a3:	48 89 d6             	mov    %rdx,%rsi
  8027a6:	89 c7                	mov    %eax,%edi
  8027a8:	48 b8 8c 24 80 00 00 	movabs $0x80248c,%rax
  8027af:	00 00 00 
  8027b2:	ff d0                	callq  *%rax
  8027b4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027bb:	79 05                	jns    8027c2 <read+0x5d>
  8027bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027c0:	eb 76                	jmp    802838 <read+0xd3>
  8027c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027c6:	8b 40 08             	mov    0x8(%rax),%eax
  8027c9:	83 e0 03             	and    $0x3,%eax
  8027cc:	83 f8 01             	cmp    $0x1,%eax
  8027cf:	75 3a                	jne    80280b <read+0xa6>
  8027d1:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  8027d8:	00 00 00 
  8027db:	48 8b 00             	mov    (%rax),%rax
  8027de:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8027e4:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8027e7:	89 c6                	mov    %eax,%esi
  8027e9:	48 bf d7 55 80 00 00 	movabs $0x8055d7,%rdi
  8027f0:	00 00 00 
  8027f3:	b8 00 00 00 00       	mov    $0x0,%eax
  8027f8:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  8027ff:	00 00 00 
  802802:	ff d1                	callq  *%rcx
  802804:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802809:	eb 2d                	jmp    802838 <read+0xd3>
  80280b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80280f:	48 8b 40 10          	mov    0x10(%rax),%rax
  802813:	48 85 c0             	test   %rax,%rax
  802816:	75 07                	jne    80281f <read+0xba>
  802818:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80281d:	eb 19                	jmp    802838 <read+0xd3>
  80281f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802823:	48 8b 40 10          	mov    0x10(%rax),%rax
  802827:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80282b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80282f:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802833:	48 89 cf             	mov    %rcx,%rdi
  802836:	ff d0                	callq  *%rax
  802838:	c9                   	leaveq 
  802839:	c3                   	retq   

000000000080283a <readn>:
  80283a:	55                   	push   %rbp
  80283b:	48 89 e5             	mov    %rsp,%rbp
  80283e:	48 83 ec 30          	sub    $0x30,%rsp
  802842:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802845:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802849:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80284d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802854:	eb 49                	jmp    80289f <readn+0x65>
  802856:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802859:	48 98                	cltq   
  80285b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80285f:	48 29 c2             	sub    %rax,%rdx
  802862:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802865:	48 63 c8             	movslq %eax,%rcx
  802868:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80286c:	48 01 c1             	add    %rax,%rcx
  80286f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802872:	48 89 ce             	mov    %rcx,%rsi
  802875:	89 c7                	mov    %eax,%edi
  802877:	48 b8 65 27 80 00 00 	movabs $0x802765,%rax
  80287e:	00 00 00 
  802881:	ff d0                	callq  *%rax
  802883:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802886:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80288a:	79 05                	jns    802891 <readn+0x57>
  80288c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80288f:	eb 1c                	jmp    8028ad <readn+0x73>
  802891:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802895:	75 02                	jne    802899 <readn+0x5f>
  802897:	eb 11                	jmp    8028aa <readn+0x70>
  802899:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80289c:	01 45 fc             	add    %eax,-0x4(%rbp)
  80289f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028a2:	48 98                	cltq   
  8028a4:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8028a8:	72 ac                	jb     802856 <readn+0x1c>
  8028aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028ad:	c9                   	leaveq 
  8028ae:	c3                   	retq   

00000000008028af <write>:
  8028af:	55                   	push   %rbp
  8028b0:	48 89 e5             	mov    %rsp,%rbp
  8028b3:	48 83 ec 40          	sub    $0x40,%rsp
  8028b7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8028ba:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8028be:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8028c2:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8028c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8028c9:	48 89 d6             	mov    %rdx,%rsi
  8028cc:	89 c7                	mov    %eax,%edi
  8028ce:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8028d5:	00 00 00 
  8028d8:	ff d0                	callq  *%rax
  8028da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028e1:	78 24                	js     802907 <write+0x58>
  8028e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028e7:	8b 00                	mov    (%rax),%eax
  8028e9:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028ed:	48 89 d6             	mov    %rdx,%rsi
  8028f0:	89 c7                	mov    %eax,%edi
  8028f2:	48 b8 8c 24 80 00 00 	movabs $0x80248c,%rax
  8028f9:	00 00 00 
  8028fc:	ff d0                	callq  *%rax
  8028fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802901:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802905:	79 05                	jns    80290c <write+0x5d>
  802907:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80290a:	eb 75                	jmp    802981 <write+0xd2>
  80290c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802910:	8b 40 08             	mov    0x8(%rax),%eax
  802913:	83 e0 03             	and    $0x3,%eax
  802916:	85 c0                	test   %eax,%eax
  802918:	75 3a                	jne    802954 <write+0xa5>
  80291a:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  802921:	00 00 00 
  802924:	48 8b 00             	mov    (%rax),%rax
  802927:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80292d:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802930:	89 c6                	mov    %eax,%esi
  802932:	48 bf f3 55 80 00 00 	movabs $0x8055f3,%rdi
  802939:	00 00 00 
  80293c:	b8 00 00 00 00       	mov    $0x0,%eax
  802941:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  802948:	00 00 00 
  80294b:	ff d1                	callq  *%rcx
  80294d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802952:	eb 2d                	jmp    802981 <write+0xd2>
  802954:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802958:	48 8b 40 18          	mov    0x18(%rax),%rax
  80295c:	48 85 c0             	test   %rax,%rax
  80295f:	75 07                	jne    802968 <write+0xb9>
  802961:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802966:	eb 19                	jmp    802981 <write+0xd2>
  802968:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80296c:	48 8b 40 18          	mov    0x18(%rax),%rax
  802970:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802974:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802978:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  80297c:	48 89 cf             	mov    %rcx,%rdi
  80297f:	ff d0                	callq  *%rax
  802981:	c9                   	leaveq 
  802982:	c3                   	retq   

0000000000802983 <seek>:
  802983:	55                   	push   %rbp
  802984:	48 89 e5             	mov    %rsp,%rbp
  802987:	48 83 ec 18          	sub    $0x18,%rsp
  80298b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80298e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802991:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802995:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802998:	48 89 d6             	mov    %rdx,%rsi
  80299b:	89 c7                	mov    %eax,%edi
  80299d:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8029a4:	00 00 00 
  8029a7:	ff d0                	callq  *%rax
  8029a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029b0:	79 05                	jns    8029b7 <seek+0x34>
  8029b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029b5:	eb 0f                	jmp    8029c6 <seek+0x43>
  8029b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029bb:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8029be:	89 50 04             	mov    %edx,0x4(%rax)
  8029c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8029c6:	c9                   	leaveq 
  8029c7:	c3                   	retq   

00000000008029c8 <ftruncate>:
  8029c8:	55                   	push   %rbp
  8029c9:	48 89 e5             	mov    %rsp,%rbp
  8029cc:	48 83 ec 30          	sub    $0x30,%rsp
  8029d0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8029d3:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8029d6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8029da:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8029dd:	48 89 d6             	mov    %rdx,%rsi
  8029e0:	89 c7                	mov    %eax,%edi
  8029e2:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8029e9:	00 00 00 
  8029ec:	ff d0                	callq  *%rax
  8029ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029f5:	78 24                	js     802a1b <ftruncate+0x53>
  8029f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029fb:	8b 00                	mov    (%rax),%eax
  8029fd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a01:	48 89 d6             	mov    %rdx,%rsi
  802a04:	89 c7                	mov    %eax,%edi
  802a06:	48 b8 8c 24 80 00 00 	movabs $0x80248c,%rax
  802a0d:	00 00 00 
  802a10:	ff d0                	callq  *%rax
  802a12:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a15:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a19:	79 05                	jns    802a20 <ftruncate+0x58>
  802a1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a1e:	eb 72                	jmp    802a92 <ftruncate+0xca>
  802a20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a24:	8b 40 08             	mov    0x8(%rax),%eax
  802a27:	83 e0 03             	and    $0x3,%eax
  802a2a:	85 c0                	test   %eax,%eax
  802a2c:	75 3a                	jne    802a68 <ftruncate+0xa0>
  802a2e:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  802a35:	00 00 00 
  802a38:	48 8b 00             	mov    (%rax),%rax
  802a3b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a41:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802a44:	89 c6                	mov    %eax,%esi
  802a46:	48 bf 10 56 80 00 00 	movabs $0x805610,%rdi
  802a4d:	00 00 00 
  802a50:	b8 00 00 00 00       	mov    $0x0,%eax
  802a55:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  802a5c:	00 00 00 
  802a5f:	ff d1                	callq  *%rcx
  802a61:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802a66:	eb 2a                	jmp    802a92 <ftruncate+0xca>
  802a68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a6c:	48 8b 40 30          	mov    0x30(%rax),%rax
  802a70:	48 85 c0             	test   %rax,%rax
  802a73:	75 07                	jne    802a7c <ftruncate+0xb4>
  802a75:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802a7a:	eb 16                	jmp    802a92 <ftruncate+0xca>
  802a7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a80:	48 8b 40 30          	mov    0x30(%rax),%rax
  802a84:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802a88:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802a8b:	89 ce                	mov    %ecx,%esi
  802a8d:	48 89 d7             	mov    %rdx,%rdi
  802a90:	ff d0                	callq  *%rax
  802a92:	c9                   	leaveq 
  802a93:	c3                   	retq   

0000000000802a94 <fstat>:
  802a94:	55                   	push   %rbp
  802a95:	48 89 e5             	mov    %rsp,%rbp
  802a98:	48 83 ec 30          	sub    $0x30,%rsp
  802a9c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802a9f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802aa3:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802aa7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802aaa:	48 89 d6             	mov    %rdx,%rsi
  802aad:	89 c7                	mov    %eax,%edi
  802aaf:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  802ab6:	00 00 00 
  802ab9:	ff d0                	callq  *%rax
  802abb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802abe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ac2:	78 24                	js     802ae8 <fstat+0x54>
  802ac4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ac8:	8b 00                	mov    (%rax),%eax
  802aca:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802ace:	48 89 d6             	mov    %rdx,%rsi
  802ad1:	89 c7                	mov    %eax,%edi
  802ad3:	48 b8 8c 24 80 00 00 	movabs $0x80248c,%rax
  802ada:	00 00 00 
  802add:	ff d0                	callq  *%rax
  802adf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ae2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ae6:	79 05                	jns    802aed <fstat+0x59>
  802ae8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aeb:	eb 5e                	jmp    802b4b <fstat+0xb7>
  802aed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802af1:	48 8b 40 28          	mov    0x28(%rax),%rax
  802af5:	48 85 c0             	test   %rax,%rax
  802af8:	75 07                	jne    802b01 <fstat+0x6d>
  802afa:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802aff:	eb 4a                	jmp    802b4b <fstat+0xb7>
  802b01:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b05:	c6 00 00             	movb   $0x0,(%rax)
  802b08:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b0c:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802b13:	00 00 00 
  802b16:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b1a:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802b21:	00 00 00 
  802b24:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b28:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b2c:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802b33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b37:	48 8b 40 28          	mov    0x28(%rax),%rax
  802b3b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802b3f:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802b43:	48 89 ce             	mov    %rcx,%rsi
  802b46:	48 89 d7             	mov    %rdx,%rdi
  802b49:	ff d0                	callq  *%rax
  802b4b:	c9                   	leaveq 
  802b4c:	c3                   	retq   

0000000000802b4d <stat>:
  802b4d:	55                   	push   %rbp
  802b4e:	48 89 e5             	mov    %rsp,%rbp
  802b51:	48 83 ec 20          	sub    $0x20,%rsp
  802b55:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802b59:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802b5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b61:	be 00 00 00 00       	mov    $0x0,%esi
  802b66:	48 89 c7             	mov    %rax,%rdi
  802b69:	48 b8 3b 2c 80 00 00 	movabs $0x802c3b,%rax
  802b70:	00 00 00 
  802b73:	ff d0                	callq  *%rax
  802b75:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b78:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b7c:	79 05                	jns    802b83 <stat+0x36>
  802b7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b81:	eb 2f                	jmp    802bb2 <stat+0x65>
  802b83:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802b87:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b8a:	48 89 d6             	mov    %rdx,%rsi
  802b8d:	89 c7                	mov    %eax,%edi
  802b8f:	48 b8 94 2a 80 00 00 	movabs $0x802a94,%rax
  802b96:	00 00 00 
  802b99:	ff d0                	callq  *%rax
  802b9b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ba1:	89 c7                	mov    %eax,%edi
  802ba3:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  802baa:	00 00 00 
  802bad:	ff d0                	callq  *%rax
  802baf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bb2:	c9                   	leaveq 
  802bb3:	c3                   	retq   

0000000000802bb4 <fsipc>:
  802bb4:	55                   	push   %rbp
  802bb5:	48 89 e5             	mov    %rsp,%rbp
  802bb8:	48 83 ec 10          	sub    $0x10,%rsp
  802bbc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802bbf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802bc3:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802bca:	00 00 00 
  802bcd:	8b 00                	mov    (%rax),%eax
  802bcf:	85 c0                	test   %eax,%eax
  802bd1:	75 1d                	jne    802bf0 <fsipc+0x3c>
  802bd3:	bf 01 00 00 00       	mov    $0x1,%edi
  802bd8:	48 b8 18 4e 80 00 00 	movabs $0x804e18,%rax
  802bdf:	00 00 00 
  802be2:	ff d0                	callq  *%rax
  802be4:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802beb:	00 00 00 
  802bee:	89 02                	mov    %eax,(%rdx)
  802bf0:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802bf7:	00 00 00 
  802bfa:	8b 00                	mov    (%rax),%eax
  802bfc:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802bff:	b9 07 00 00 00       	mov    $0x7,%ecx
  802c04:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  802c0b:	00 00 00 
  802c0e:	89 c7                	mov    %eax,%edi
  802c10:	48 b8 0d 4d 80 00 00 	movabs $0x804d0d,%rax
  802c17:	00 00 00 
  802c1a:	ff d0                	callq  *%rax
  802c1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c20:	ba 00 00 00 00       	mov    $0x0,%edx
  802c25:	48 89 c6             	mov    %rax,%rsi
  802c28:	bf 00 00 00 00       	mov    $0x0,%edi
  802c2d:	48 b8 4c 4c 80 00 00 	movabs $0x804c4c,%rax
  802c34:	00 00 00 
  802c37:	ff d0                	callq  *%rax
  802c39:	c9                   	leaveq 
  802c3a:	c3                   	retq   

0000000000802c3b <open>:
  802c3b:	55                   	push   %rbp
  802c3c:	48 89 e5             	mov    %rsp,%rbp
  802c3f:	48 83 ec 20          	sub    $0x20,%rsp
  802c43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c47:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802c4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c4e:	48 89 c7             	mov    %rax,%rdi
  802c51:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  802c58:	00 00 00 
  802c5b:	ff d0                	callq  *%rax
  802c5d:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802c62:	7e 0a                	jle    802c6e <open+0x33>
  802c64:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802c69:	e9 a5 00 00 00       	jmpq   802d13 <open+0xd8>
  802c6e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802c72:	48 89 c7             	mov    %rax,%rdi
  802c75:	48 b8 9b 22 80 00 00 	movabs $0x80229b,%rax
  802c7c:	00 00 00 
  802c7f:	ff d0                	callq  *%rax
  802c81:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c84:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c88:	79 08                	jns    802c92 <open+0x57>
  802c8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c8d:	e9 81 00 00 00       	jmpq   802d13 <open+0xd8>
  802c92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c96:	48 89 c6             	mov    %rax,%rsi
  802c99:	48 bf 00 b0 80 00 00 	movabs $0x80b000,%rdi
  802ca0:	00 00 00 
  802ca3:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  802caa:	00 00 00 
  802cad:	ff d0                	callq  *%rax
  802caf:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802cb6:	00 00 00 
  802cb9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802cbc:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cc6:	48 89 c6             	mov    %rax,%rsi
  802cc9:	bf 01 00 00 00       	mov    $0x1,%edi
  802cce:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  802cd5:	00 00 00 
  802cd8:	ff d0                	callq  *%rax
  802cda:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cdd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ce1:	79 1d                	jns    802d00 <open+0xc5>
  802ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ce7:	be 00 00 00 00       	mov    $0x0,%esi
  802cec:	48 89 c7             	mov    %rax,%rdi
  802cef:	48 b8 c3 23 80 00 00 	movabs $0x8023c3,%rax
  802cf6:	00 00 00 
  802cf9:	ff d0                	callq  *%rax
  802cfb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cfe:	eb 13                	jmp    802d13 <open+0xd8>
  802d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d04:	48 89 c7             	mov    %rax,%rdi
  802d07:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  802d0e:	00 00 00 
  802d11:	ff d0                	callq  *%rax
  802d13:	c9                   	leaveq 
  802d14:	c3                   	retq   

0000000000802d15 <devfile_flush>:
  802d15:	55                   	push   %rbp
  802d16:	48 89 e5             	mov    %rsp,%rbp
  802d19:	48 83 ec 10          	sub    $0x10,%rsp
  802d1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d25:	8b 50 0c             	mov    0xc(%rax),%edx
  802d28:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802d2f:	00 00 00 
  802d32:	89 10                	mov    %edx,(%rax)
  802d34:	be 00 00 00 00       	mov    $0x0,%esi
  802d39:	bf 06 00 00 00       	mov    $0x6,%edi
  802d3e:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  802d45:	00 00 00 
  802d48:	ff d0                	callq  *%rax
  802d4a:	c9                   	leaveq 
  802d4b:	c3                   	retq   

0000000000802d4c <devfile_read>:
  802d4c:	55                   	push   %rbp
  802d4d:	48 89 e5             	mov    %rsp,%rbp
  802d50:	48 83 ec 30          	sub    $0x30,%rsp
  802d54:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802d58:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802d5c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802d60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d64:	8b 50 0c             	mov    0xc(%rax),%edx
  802d67:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802d6e:	00 00 00 
  802d71:	89 10                	mov    %edx,(%rax)
  802d73:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802d7a:	00 00 00 
  802d7d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802d81:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802d85:	be 00 00 00 00       	mov    $0x0,%esi
  802d8a:	bf 03 00 00 00       	mov    $0x3,%edi
  802d8f:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  802d96:	00 00 00 
  802d99:	ff d0                	callq  *%rax
  802d9b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802da2:	79 08                	jns    802dac <devfile_read+0x60>
  802da4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802da7:	e9 a4 00 00 00       	jmpq   802e50 <devfile_read+0x104>
  802dac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802daf:	48 98                	cltq   
  802db1:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802db5:	76 35                	jbe    802dec <devfile_read+0xa0>
  802db7:	48 b9 36 56 80 00 00 	movabs $0x805636,%rcx
  802dbe:	00 00 00 
  802dc1:	48 ba 3d 56 80 00 00 	movabs $0x80563d,%rdx
  802dc8:	00 00 00 
  802dcb:	be 89 00 00 00       	mov    $0x89,%esi
  802dd0:	48 bf 52 56 80 00 00 	movabs $0x805652,%rdi
  802dd7:	00 00 00 
  802dda:	b8 00 00 00 00       	mov    $0x0,%eax
  802ddf:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  802de6:	00 00 00 
  802de9:	41 ff d0             	callq  *%r8
  802dec:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802df3:	7e 35                	jle    802e2a <devfile_read+0xde>
  802df5:	48 b9 60 56 80 00 00 	movabs $0x805660,%rcx
  802dfc:	00 00 00 
  802dff:	48 ba 3d 56 80 00 00 	movabs $0x80563d,%rdx
  802e06:	00 00 00 
  802e09:	be 8a 00 00 00       	mov    $0x8a,%esi
  802e0e:	48 bf 52 56 80 00 00 	movabs $0x805652,%rdi
  802e15:	00 00 00 
  802e18:	b8 00 00 00 00       	mov    $0x0,%eax
  802e1d:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  802e24:	00 00 00 
  802e27:	41 ff d0             	callq  *%r8
  802e2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e2d:	48 63 d0             	movslq %eax,%rdx
  802e30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802e34:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  802e3b:	00 00 00 
  802e3e:	48 89 c7             	mov    %rax,%rdi
  802e41:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  802e48:	00 00 00 
  802e4b:	ff d0                	callq  *%rax
  802e4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e50:	c9                   	leaveq 
  802e51:	c3                   	retq   

0000000000802e52 <devfile_write>:
  802e52:	55                   	push   %rbp
  802e53:	48 89 e5             	mov    %rsp,%rbp
  802e56:	48 83 ec 40          	sub    $0x40,%rsp
  802e5a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802e5e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802e62:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802e66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802e6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802e6e:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  802e75:	00 
  802e76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e7a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  802e7e:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  802e83:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  802e87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e8b:	8b 50 0c             	mov    0xc(%rax),%edx
  802e8e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802e95:	00 00 00 
  802e98:	89 10                	mov    %edx,(%rax)
  802e9a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802ea1:	00 00 00 
  802ea4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ea8:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802eac:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802eb0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802eb4:	48 89 c6             	mov    %rax,%rsi
  802eb7:	48 bf 10 b0 80 00 00 	movabs $0x80b010,%rdi
  802ebe:	00 00 00 
  802ec1:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  802ec8:	00 00 00 
  802ecb:	ff d0                	callq  *%rax
  802ecd:	be 00 00 00 00       	mov    $0x0,%esi
  802ed2:	bf 04 00 00 00       	mov    $0x4,%edi
  802ed7:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  802ede:	00 00 00 
  802ee1:	ff d0                	callq  *%rax
  802ee3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802ee6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802eea:	79 05                	jns    802ef1 <devfile_write+0x9f>
  802eec:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802eef:	eb 43                	jmp    802f34 <devfile_write+0xe2>
  802ef1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802ef4:	48 98                	cltq   
  802ef6:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802efa:	76 35                	jbe    802f31 <devfile_write+0xdf>
  802efc:	48 b9 36 56 80 00 00 	movabs $0x805636,%rcx
  802f03:	00 00 00 
  802f06:	48 ba 3d 56 80 00 00 	movabs $0x80563d,%rdx
  802f0d:	00 00 00 
  802f10:	be a8 00 00 00       	mov    $0xa8,%esi
  802f15:	48 bf 52 56 80 00 00 	movabs $0x805652,%rdi
  802f1c:	00 00 00 
  802f1f:	b8 00 00 00 00       	mov    $0x0,%eax
  802f24:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  802f2b:	00 00 00 
  802f2e:	41 ff d0             	callq  *%r8
  802f31:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f34:	c9                   	leaveq 
  802f35:	c3                   	retq   

0000000000802f36 <devfile_stat>:
  802f36:	55                   	push   %rbp
  802f37:	48 89 e5             	mov    %rsp,%rbp
  802f3a:	48 83 ec 20          	sub    $0x20,%rsp
  802f3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802f42:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f4a:	8b 50 0c             	mov    0xc(%rax),%edx
  802f4d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802f54:	00 00 00 
  802f57:	89 10                	mov    %edx,(%rax)
  802f59:	be 00 00 00 00       	mov    $0x0,%esi
  802f5e:	bf 05 00 00 00       	mov    $0x5,%edi
  802f63:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  802f6a:	00 00 00 
  802f6d:	ff d0                	callq  *%rax
  802f6f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f72:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f76:	79 05                	jns    802f7d <devfile_stat+0x47>
  802f78:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f7b:	eb 56                	jmp    802fd3 <devfile_stat+0x9d>
  802f7d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f81:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  802f88:	00 00 00 
  802f8b:	48 89 c7             	mov    %rax,%rdi
  802f8e:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  802f95:	00 00 00 
  802f98:	ff d0                	callq  *%rax
  802f9a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802fa1:	00 00 00 
  802fa4:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802faa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fae:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802fb4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802fbb:	00 00 00 
  802fbe:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802fc4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fc8:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802fce:	b8 00 00 00 00       	mov    $0x0,%eax
  802fd3:	c9                   	leaveq 
  802fd4:	c3                   	retq   

0000000000802fd5 <devfile_trunc>:
  802fd5:	55                   	push   %rbp
  802fd6:	48 89 e5             	mov    %rsp,%rbp
  802fd9:	48 83 ec 10          	sub    $0x10,%rsp
  802fdd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fe1:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fe8:	8b 50 0c             	mov    0xc(%rax),%edx
  802feb:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802ff2:	00 00 00 
  802ff5:	89 10                	mov    %edx,(%rax)
  802ff7:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  802ffe:	00 00 00 
  803001:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803004:	89 50 04             	mov    %edx,0x4(%rax)
  803007:	be 00 00 00 00       	mov    $0x0,%esi
  80300c:	bf 02 00 00 00       	mov    $0x2,%edi
  803011:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  803018:	00 00 00 
  80301b:	ff d0                	callq  *%rax
  80301d:	c9                   	leaveq 
  80301e:	c3                   	retq   

000000000080301f <remove>:
  80301f:	55                   	push   %rbp
  803020:	48 89 e5             	mov    %rsp,%rbp
  803023:	48 83 ec 10          	sub    $0x10,%rsp
  803027:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80302b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80302f:	48 89 c7             	mov    %rax,%rdi
  803032:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  803039:	00 00 00 
  80303c:	ff d0                	callq  *%rax
  80303e:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803043:	7e 07                	jle    80304c <remove+0x2d>
  803045:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80304a:	eb 33                	jmp    80307f <remove+0x60>
  80304c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803050:	48 89 c6             	mov    %rax,%rsi
  803053:	48 bf 00 b0 80 00 00 	movabs $0x80b000,%rdi
  80305a:	00 00 00 
  80305d:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  803064:	00 00 00 
  803067:	ff d0                	callq  *%rax
  803069:	be 00 00 00 00       	mov    $0x0,%esi
  80306e:	bf 07 00 00 00       	mov    $0x7,%edi
  803073:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  80307a:	00 00 00 
  80307d:	ff d0                	callq  *%rax
  80307f:	c9                   	leaveq 
  803080:	c3                   	retq   

0000000000803081 <sync>:
  803081:	55                   	push   %rbp
  803082:	48 89 e5             	mov    %rsp,%rbp
  803085:	be 00 00 00 00       	mov    $0x0,%esi
  80308a:	bf 08 00 00 00       	mov    $0x8,%edi
  80308f:	48 b8 b4 2b 80 00 00 	movabs $0x802bb4,%rax
  803096:	00 00 00 
  803099:	ff d0                	callq  *%rax
  80309b:	5d                   	pop    %rbp
  80309c:	c3                   	retq   

000000000080309d <copy>:
  80309d:	55                   	push   %rbp
  80309e:	48 89 e5             	mov    %rsp,%rbp
  8030a1:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8030a8:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  8030af:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  8030b6:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  8030bd:	be 00 00 00 00       	mov    $0x0,%esi
  8030c2:	48 89 c7             	mov    %rax,%rdi
  8030c5:	48 b8 3b 2c 80 00 00 	movabs $0x802c3b,%rax
  8030cc:	00 00 00 
  8030cf:	ff d0                	callq  *%rax
  8030d1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030d4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030d8:	79 28                	jns    803102 <copy+0x65>
  8030da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030dd:	89 c6                	mov    %eax,%esi
  8030df:	48 bf 6c 56 80 00 00 	movabs $0x80566c,%rdi
  8030e6:	00 00 00 
  8030e9:	b8 00 00 00 00       	mov    $0x0,%eax
  8030ee:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  8030f5:	00 00 00 
  8030f8:	ff d2                	callq  *%rdx
  8030fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030fd:	e9 74 01 00 00       	jmpq   803276 <copy+0x1d9>
  803102:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803109:	be 01 01 00 00       	mov    $0x101,%esi
  80310e:	48 89 c7             	mov    %rax,%rdi
  803111:	48 b8 3b 2c 80 00 00 	movabs $0x802c3b,%rax
  803118:	00 00 00 
  80311b:	ff d0                	callq  *%rax
  80311d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803120:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803124:	79 39                	jns    80315f <copy+0xc2>
  803126:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803129:	89 c6                	mov    %eax,%esi
  80312b:	48 bf 82 56 80 00 00 	movabs $0x805682,%rdi
  803132:	00 00 00 
  803135:	b8 00 00 00 00       	mov    $0x0,%eax
  80313a:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  803141:	00 00 00 
  803144:	ff d2                	callq  *%rdx
  803146:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803149:	89 c7                	mov    %eax,%edi
  80314b:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  803152:	00 00 00 
  803155:	ff d0                	callq  *%rax
  803157:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80315a:	e9 17 01 00 00       	jmpq   803276 <copy+0x1d9>
  80315f:	eb 74                	jmp    8031d5 <copy+0x138>
  803161:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803164:	48 63 d0             	movslq %eax,%rdx
  803167:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80316e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803171:	48 89 ce             	mov    %rcx,%rsi
  803174:	89 c7                	mov    %eax,%edi
  803176:	48 b8 af 28 80 00 00 	movabs $0x8028af,%rax
  80317d:	00 00 00 
  803180:	ff d0                	callq  *%rax
  803182:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803185:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803189:	79 4a                	jns    8031d5 <copy+0x138>
  80318b:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80318e:	89 c6                	mov    %eax,%esi
  803190:	48 bf 9c 56 80 00 00 	movabs $0x80569c,%rdi
  803197:	00 00 00 
  80319a:	b8 00 00 00 00       	mov    $0x0,%eax
  80319f:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  8031a6:	00 00 00 
  8031a9:	ff d2                	callq  *%rdx
  8031ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031ae:	89 c7                	mov    %eax,%edi
  8031b0:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  8031b7:	00 00 00 
  8031ba:	ff d0                	callq  *%rax
  8031bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8031bf:	89 c7                	mov    %eax,%edi
  8031c1:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  8031c8:	00 00 00 
  8031cb:	ff d0                	callq  *%rax
  8031cd:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8031d0:	e9 a1 00 00 00       	jmpq   803276 <copy+0x1d9>
  8031d5:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8031dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031df:	ba 00 02 00 00       	mov    $0x200,%edx
  8031e4:	48 89 ce             	mov    %rcx,%rsi
  8031e7:	89 c7                	mov    %eax,%edi
  8031e9:	48 b8 65 27 80 00 00 	movabs $0x802765,%rax
  8031f0:	00 00 00 
  8031f3:	ff d0                	callq  *%rax
  8031f5:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8031f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8031fc:	0f 8f 5f ff ff ff    	jg     803161 <copy+0xc4>
  803202:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803206:	79 47                	jns    80324f <copy+0x1b2>
  803208:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80320b:	89 c6                	mov    %eax,%esi
  80320d:	48 bf af 56 80 00 00 	movabs $0x8056af,%rdi
  803214:	00 00 00 
  803217:	b8 00 00 00 00       	mov    $0x0,%eax
  80321c:	48 ba 89 09 80 00 00 	movabs $0x800989,%rdx
  803223:	00 00 00 
  803226:	ff d2                	callq  *%rdx
  803228:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80322b:	89 c7                	mov    %eax,%edi
  80322d:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  803234:	00 00 00 
  803237:	ff d0                	callq  *%rax
  803239:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80323c:	89 c7                	mov    %eax,%edi
  80323e:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  803245:	00 00 00 
  803248:	ff d0                	callq  *%rax
  80324a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80324d:	eb 27                	jmp    803276 <copy+0x1d9>
  80324f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803252:	89 c7                	mov    %eax,%edi
  803254:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  80325b:	00 00 00 
  80325e:	ff d0                	callq  *%rax
  803260:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803263:	89 c7                	mov    %eax,%edi
  803265:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  80326c:	00 00 00 
  80326f:	ff d0                	callq  *%rax
  803271:	b8 00 00 00 00       	mov    $0x0,%eax
  803276:	c9                   	leaveq 
  803277:	c3                   	retq   

0000000000803278 <spawn>:
  803278:	55                   	push   %rbp
  803279:	48 89 e5             	mov    %rsp,%rbp
  80327c:	48 81 ec 10 03 00 00 	sub    $0x310,%rsp
  803283:	48 89 bd 08 fd ff ff 	mov    %rdi,-0x2f8(%rbp)
  80328a:	48 89 b5 00 fd ff ff 	mov    %rsi,-0x300(%rbp)
  803291:	48 8b 85 08 fd ff ff 	mov    -0x2f8(%rbp),%rax
  803298:	be 00 00 00 00       	mov    $0x0,%esi
  80329d:	48 89 c7             	mov    %rax,%rdi
  8032a0:	48 b8 3b 2c 80 00 00 	movabs $0x802c3b,%rax
  8032a7:	00 00 00 
  8032aa:	ff d0                	callq  *%rax
  8032ac:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8032af:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8032b3:	79 08                	jns    8032bd <spawn+0x45>
  8032b5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8032b8:	e9 0c 03 00 00       	jmpq   8035c9 <spawn+0x351>
  8032bd:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8032c0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8032c3:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
  8032ca:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8032ce:	48 8d 8d d0 fd ff ff 	lea    -0x230(%rbp),%rcx
  8032d5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8032d8:	ba 00 02 00 00       	mov    $0x200,%edx
  8032dd:	48 89 ce             	mov    %rcx,%rsi
  8032e0:	89 c7                	mov    %eax,%edi
  8032e2:	48 b8 3a 28 80 00 00 	movabs $0x80283a,%rax
  8032e9:	00 00 00 
  8032ec:	ff d0                	callq  *%rax
  8032ee:	3d 00 02 00 00       	cmp    $0x200,%eax
  8032f3:	75 0d                	jne    803302 <spawn+0x8a>
  8032f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8032f9:	8b 00                	mov    (%rax),%eax
  8032fb:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  803300:	74 43                	je     803345 <spawn+0xcd>
  803302:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  803305:	89 c7                	mov    %eax,%edi
  803307:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  80330e:	00 00 00 
  803311:	ff d0                	callq  *%rax
  803313:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803317:	8b 00                	mov    (%rax),%eax
  803319:	ba 7f 45 4c 46       	mov    $0x464c457f,%edx
  80331e:	89 c6                	mov    %eax,%esi
  803320:	48 bf c8 56 80 00 00 	movabs $0x8056c8,%rdi
  803327:	00 00 00 
  80332a:	b8 00 00 00 00       	mov    $0x0,%eax
  80332f:	48 b9 89 09 80 00 00 	movabs $0x800989,%rcx
  803336:	00 00 00 
  803339:	ff d1                	callq  *%rcx
  80333b:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
  803340:	e9 84 02 00 00       	jmpq   8035c9 <spawn+0x351>
  803345:	b8 07 00 00 00       	mov    $0x7,%eax
  80334a:	cd 30                	int    $0x30
  80334c:	89 45 d0             	mov    %eax,-0x30(%rbp)
  80334f:	8b 45 d0             	mov    -0x30(%rbp),%eax
  803352:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803355:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  803359:	79 08                	jns    803363 <spawn+0xeb>
  80335b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80335e:	e9 66 02 00 00       	jmpq   8035c9 <spawn+0x351>
  803363:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803366:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  803369:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80336c:	25 ff 03 00 00       	and    $0x3ff,%eax
  803371:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803378:	00 00 00 
  80337b:	48 98                	cltq   
  80337d:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803384:	48 01 d0             	add    %rdx,%rax
  803387:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  80338e:	48 89 c6             	mov    %rax,%rsi
  803391:	b8 18 00 00 00       	mov    $0x18,%eax
  803396:	48 89 d7             	mov    %rdx,%rdi
  803399:	48 89 c1             	mov    %rax,%rcx
  80339c:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  80339f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8033a3:	48 8b 40 18          	mov    0x18(%rax),%rax
  8033a7:	48 89 85 a8 fd ff ff 	mov    %rax,-0x258(%rbp)
  8033ae:	48 8d 85 10 fd ff ff 	lea    -0x2f0(%rbp),%rax
  8033b5:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
  8033bc:	48 8b 8d 00 fd ff ff 	mov    -0x300(%rbp),%rcx
  8033c3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8033c6:	48 89 ce             	mov    %rcx,%rsi
  8033c9:	89 c7                	mov    %eax,%edi
  8033cb:	48 b8 33 38 80 00 00 	movabs $0x803833,%rax
  8033d2:	00 00 00 
  8033d5:	ff d0                	callq  *%rax
  8033d7:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8033da:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8033de:	79 08                	jns    8033e8 <spawn+0x170>
  8033e0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8033e3:	e9 e1 01 00 00       	jmpq   8035c9 <spawn+0x351>
  8033e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8033ec:	48 8b 40 20          	mov    0x20(%rax),%rax
  8033f0:	48 8d 95 d0 fd ff ff 	lea    -0x230(%rbp),%rdx
  8033f7:	48 01 d0             	add    %rdx,%rax
  8033fa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8033fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803405:	e9 a3 00 00 00       	jmpq   8034ad <spawn+0x235>
  80340a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80340e:	8b 00                	mov    (%rax),%eax
  803410:	83 f8 01             	cmp    $0x1,%eax
  803413:	74 05                	je     80341a <spawn+0x1a2>
  803415:	e9 8a 00 00 00       	jmpq   8034a4 <spawn+0x22c>
  80341a:	c7 45 ec 05 00 00 00 	movl   $0x5,-0x14(%rbp)
  803421:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803425:	8b 40 04             	mov    0x4(%rax),%eax
  803428:	83 e0 02             	and    $0x2,%eax
  80342b:	85 c0                	test   %eax,%eax
  80342d:	74 04                	je     803433 <spawn+0x1bb>
  80342f:	83 4d ec 02          	orl    $0x2,-0x14(%rbp)
  803433:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803437:	48 8b 40 08          	mov    0x8(%rax),%rax
  80343b:	41 89 c1             	mov    %eax,%r9d
  80343e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803442:	4c 8b 40 20          	mov    0x20(%rax),%r8
  803446:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80344a:	48 8b 50 28          	mov    0x28(%rax),%rdx
  80344e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803452:	48 8b 70 10          	mov    0x10(%rax),%rsi
  803456:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  803459:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80345c:	8b 7d ec             	mov    -0x14(%rbp),%edi
  80345f:	89 3c 24             	mov    %edi,(%rsp)
  803462:	89 c7                	mov    %eax,%edi
  803464:	48 b8 dc 3a 80 00 00 	movabs $0x803adc,%rax
  80346b:	00 00 00 
  80346e:	ff d0                	callq  *%rax
  803470:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803473:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  803477:	79 2b                	jns    8034a4 <spawn+0x22c>
  803479:	90                   	nop
  80347a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80347d:	89 c7                	mov    %eax,%edi
  80347f:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  803486:	00 00 00 
  803489:	ff d0                	callq  *%rax
  80348b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80348e:	89 c7                	mov    %eax,%edi
  803490:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  803497:	00 00 00 
  80349a:	ff d0                	callq  *%rax
  80349c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80349f:	e9 25 01 00 00       	jmpq   8035c9 <spawn+0x351>
  8034a4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8034a8:	48 83 45 f0 38       	addq   $0x38,-0x10(%rbp)
  8034ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8034b1:	0f b7 40 38          	movzwl 0x38(%rax),%eax
  8034b5:	0f b7 c0             	movzwl %ax,%eax
  8034b8:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  8034bb:	0f 8f 49 ff ff ff    	jg     80340a <spawn+0x192>
  8034c1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8034c4:	89 c7                	mov    %eax,%edi
  8034c6:	48 b8 43 25 80 00 00 	movabs $0x802543,%rax
  8034cd:	00 00 00 
  8034d0:	ff d0                	callq  *%rax
  8034d2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
  8034d9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8034dc:	89 c7                	mov    %eax,%edi
  8034de:	48 b8 c8 3c 80 00 00 	movabs $0x803cc8,%rax
  8034e5:	00 00 00 
  8034e8:	ff d0                	callq  *%rax
  8034ea:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8034ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8034f1:	79 30                	jns    803523 <spawn+0x2ab>
  8034f3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8034f6:	89 c1                	mov    %eax,%ecx
  8034f8:	48 ba e2 56 80 00 00 	movabs $0x8056e2,%rdx
  8034ff:	00 00 00 
  803502:	be 86 00 00 00       	mov    $0x86,%esi
  803507:	48 bf f8 56 80 00 00 	movabs $0x8056f8,%rdi
  80350e:	00 00 00 
  803511:	b8 00 00 00 00       	mov    $0x0,%eax
  803516:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  80351d:	00 00 00 
  803520:	41 ff d0             	callq  *%r8
  803523:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  80352a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80352d:	48 89 d6             	mov    %rdx,%rsi
  803530:	89 c7                	mov    %eax,%edi
  803532:	48 b8 ad 1f 80 00 00 	movabs $0x801fad,%rax
  803539:	00 00 00 
  80353c:	ff d0                	callq  *%rax
  80353e:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803541:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  803545:	79 30                	jns    803577 <spawn+0x2ff>
  803547:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80354a:	89 c1                	mov    %eax,%ecx
  80354c:	48 ba 07 57 80 00 00 	movabs $0x805707,%rdx
  803553:	00 00 00 
  803556:	be 8a 00 00 00       	mov    $0x8a,%esi
  80355b:	48 bf f8 56 80 00 00 	movabs $0x8056f8,%rdi
  803562:	00 00 00 
  803565:	b8 00 00 00 00       	mov    $0x0,%eax
  80356a:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  803571:	00 00 00 
  803574:	41 ff d0             	callq  *%r8
  803577:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80357a:	be 02 00 00 00       	mov    $0x2,%esi
  80357f:	89 c7                	mov    %eax,%edi
  803581:	48 b8 62 1f 80 00 00 	movabs $0x801f62,%rax
  803588:	00 00 00 
  80358b:	ff d0                	callq  *%rax
  80358d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803590:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  803594:	79 30                	jns    8035c6 <spawn+0x34e>
  803596:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803599:	89 c1                	mov    %eax,%ecx
  80359b:	48 ba 21 57 80 00 00 	movabs $0x805721,%rdx
  8035a2:	00 00 00 
  8035a5:	be 8d 00 00 00       	mov    $0x8d,%esi
  8035aa:	48 bf f8 56 80 00 00 	movabs $0x8056f8,%rdi
  8035b1:	00 00 00 
  8035b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8035b9:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  8035c0:	00 00 00 
  8035c3:	41 ff d0             	callq  *%r8
  8035c6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8035c9:	c9                   	leaveq 
  8035ca:	c3                   	retq   

00000000008035cb <spawnl>:
  8035cb:	55                   	push   %rbp
  8035cc:	48 89 e5             	mov    %rsp,%rbp
  8035cf:	41 55                	push   %r13
  8035d1:	41 54                	push   %r12
  8035d3:	53                   	push   %rbx
  8035d4:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8035db:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
  8035e2:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
  8035e9:	48 89 8d 48 ff ff ff 	mov    %rcx,-0xb8(%rbp)
  8035f0:	4c 89 85 50 ff ff ff 	mov    %r8,-0xb0(%rbp)
  8035f7:	4c 89 8d 58 ff ff ff 	mov    %r9,-0xa8(%rbp)
  8035fe:	84 c0                	test   %al,%al
  803600:	74 26                	je     803628 <spawnl+0x5d>
  803602:	0f 29 85 60 ff ff ff 	movaps %xmm0,-0xa0(%rbp)
  803609:	0f 29 8d 70 ff ff ff 	movaps %xmm1,-0x90(%rbp)
  803610:	0f 29 55 80          	movaps %xmm2,-0x80(%rbp)
  803614:	0f 29 5d 90          	movaps %xmm3,-0x70(%rbp)
  803618:	0f 29 65 a0          	movaps %xmm4,-0x60(%rbp)
  80361c:	0f 29 6d b0          	movaps %xmm5,-0x50(%rbp)
  803620:	0f 29 75 c0          	movaps %xmm6,-0x40(%rbp)
  803624:	0f 29 7d d0          	movaps %xmm7,-0x30(%rbp)
  803628:	48 89 b5 f0 fe ff ff 	mov    %rsi,-0x110(%rbp)
  80362f:	c7 85 2c ff ff ff 00 	movl   $0x0,-0xd4(%rbp)
  803636:	00 00 00 
  803639:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  803640:	00 00 00 
  803643:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  80364a:	00 00 00 
  80364d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803651:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  803658:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  80365f:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  803666:	eb 07                	jmp    80366f <spawnl+0xa4>
  803668:	83 85 2c ff ff ff 01 	addl   $0x1,-0xd4(%rbp)
  80366f:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  803675:	83 f8 30             	cmp    $0x30,%eax
  803678:	73 23                	jae    80369d <spawnl+0xd2>
  80367a:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  803681:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  803687:	89 c0                	mov    %eax,%eax
  803689:	48 01 d0             	add    %rdx,%rax
  80368c:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  803692:	83 c2 08             	add    $0x8,%edx
  803695:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  80369b:	eb 15                	jmp    8036b2 <spawnl+0xe7>
  80369d:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  8036a4:	48 89 d0             	mov    %rdx,%rax
  8036a7:	48 83 c2 08          	add    $0x8,%rdx
  8036ab:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8036b2:	48 8b 00             	mov    (%rax),%rax
  8036b5:	48 85 c0             	test   %rax,%rax
  8036b8:	75 ae                	jne    803668 <spawnl+0x9d>
  8036ba:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8036c0:	83 c0 02             	add    $0x2,%eax
  8036c3:	48 89 e2             	mov    %rsp,%rdx
  8036c6:	48 89 d3             	mov    %rdx,%rbx
  8036c9:	48 63 d0             	movslq %eax,%rdx
  8036cc:	48 83 ea 01          	sub    $0x1,%rdx
  8036d0:	48 89 95 20 ff ff ff 	mov    %rdx,-0xe0(%rbp)
  8036d7:	48 63 d0             	movslq %eax,%rdx
  8036da:	49 89 d4             	mov    %rdx,%r12
  8036dd:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  8036e3:	48 63 d0             	movslq %eax,%rdx
  8036e6:	49 89 d2             	mov    %rdx,%r10
  8036e9:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  8036ef:	48 98                	cltq   
  8036f1:	48 c1 e0 03          	shl    $0x3,%rax
  8036f5:	48 8d 50 07          	lea    0x7(%rax),%rdx
  8036f9:	b8 10 00 00 00       	mov    $0x10,%eax
  8036fe:	48 83 e8 01          	sub    $0x1,%rax
  803702:	48 01 d0             	add    %rdx,%rax
  803705:	bf 10 00 00 00       	mov    $0x10,%edi
  80370a:	ba 00 00 00 00       	mov    $0x0,%edx
  80370f:	48 f7 f7             	div    %rdi
  803712:	48 6b c0 10          	imul   $0x10,%rax,%rax
  803716:	48 29 c4             	sub    %rax,%rsp
  803719:	48 89 e0             	mov    %rsp,%rax
  80371c:	48 83 c0 07          	add    $0x7,%rax
  803720:	48 c1 e8 03          	shr    $0x3,%rax
  803724:	48 c1 e0 03          	shl    $0x3,%rax
  803728:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
  80372f:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  803736:	48 8b 95 f0 fe ff ff 	mov    -0x110(%rbp),%rdx
  80373d:	48 89 10             	mov    %rdx,(%rax)
  803740:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  803746:	8d 50 01             	lea    0x1(%rax),%edx
  803749:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  803750:	48 63 d2             	movslq %edx,%rdx
  803753:	48 c7 04 d0 00 00 00 	movq   $0x0,(%rax,%rdx,8)
  80375a:	00 
  80375b:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  803762:	00 00 00 
  803765:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  80376c:	00 00 00 
  80376f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803773:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  80377a:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  803781:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  803788:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
  80378f:	00 00 00 
  803792:	eb 63                	jmp    8037f7 <spawnl+0x22c>
  803794:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
  80379a:	8d 70 01             	lea    0x1(%rax),%esi
  80379d:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8037a3:	83 f8 30             	cmp    $0x30,%eax
  8037a6:	73 23                	jae    8037cb <spawnl+0x200>
  8037a8:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  8037af:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8037b5:	89 c0                	mov    %eax,%eax
  8037b7:	48 01 d0             	add    %rdx,%rax
  8037ba:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  8037c0:	83 c2 08             	add    $0x8,%edx
  8037c3:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  8037c9:	eb 15                	jmp    8037e0 <spawnl+0x215>
  8037cb:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  8037d2:	48 89 d0             	mov    %rdx,%rax
  8037d5:	48 83 c2 08          	add    $0x8,%rdx
  8037d9:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8037e0:	48 8b 08             	mov    (%rax),%rcx
  8037e3:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  8037ea:	89 f2                	mov    %esi,%edx
  8037ec:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
  8037f0:	83 85 28 ff ff ff 01 	addl   $0x1,-0xd8(%rbp)
  8037f7:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8037fd:	3b 85 28 ff ff ff    	cmp    -0xd8(%rbp),%eax
  803803:	77 8f                	ja     803794 <spawnl+0x1c9>
  803805:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80380c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
  803813:	48 89 d6             	mov    %rdx,%rsi
  803816:	48 89 c7             	mov    %rax,%rdi
  803819:	48 b8 78 32 80 00 00 	movabs $0x803278,%rax
  803820:	00 00 00 
  803823:	ff d0                	callq  *%rax
  803825:	48 89 dc             	mov    %rbx,%rsp
  803828:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
  80382c:	5b                   	pop    %rbx
  80382d:	41 5c                	pop    %r12
  80382f:	41 5d                	pop    %r13
  803831:	5d                   	pop    %rbp
  803832:	c3                   	retq   

0000000000803833 <init_stack>:
  803833:	55                   	push   %rbp
  803834:	48 89 e5             	mov    %rsp,%rbp
  803837:	48 83 ec 50          	sub    $0x50,%rsp
  80383b:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80383e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  803842:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  803846:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80384d:	00 
  80384e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  803855:	eb 33                	jmp    80388a <init_stack+0x57>
  803857:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80385a:	48 98                	cltq   
  80385c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803863:	00 
  803864:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803868:	48 01 d0             	add    %rdx,%rax
  80386b:	48 8b 00             	mov    (%rax),%rax
  80386e:	48 89 c7             	mov    %rax,%rdi
  803871:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  803878:	00 00 00 
  80387b:	ff d0                	callq  *%rax
  80387d:	83 c0 01             	add    $0x1,%eax
  803880:	48 98                	cltq   
  803882:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  803886:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
  80388a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80388d:	48 98                	cltq   
  80388f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803896:	00 
  803897:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  80389b:	48 01 d0             	add    %rdx,%rax
  80389e:	48 8b 00             	mov    (%rax),%rax
  8038a1:	48 85 c0             	test   %rax,%rax
  8038a4:	75 b1                	jne    803857 <init_stack+0x24>
  8038a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038aa:	48 f7 d8             	neg    %rax
  8038ad:	48 05 00 10 40 00    	add    $0x401000,%rax
  8038b3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8038b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8038bb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8038bf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038c3:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  8038c7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8038ca:	83 c2 01             	add    $0x1,%edx
  8038cd:	c1 e2 03             	shl    $0x3,%edx
  8038d0:	48 63 d2             	movslq %edx,%rdx
  8038d3:	48 f7 da             	neg    %rdx
  8038d6:	48 01 d0             	add    %rdx,%rax
  8038d9:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8038dd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8038e1:	48 83 e8 10          	sub    $0x10,%rax
  8038e5:	48 3d ff ff 3f 00    	cmp    $0x3fffff,%rax
  8038eb:	77 0a                	ja     8038f7 <init_stack+0xc4>
  8038ed:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  8038f2:	e9 e3 01 00 00       	jmpq   803ada <init_stack+0x2a7>
  8038f7:	ba 07 00 00 00       	mov    $0x7,%edx
  8038fc:	be 00 00 40 00       	mov    $0x400000,%esi
  803901:	bf 00 00 00 00       	mov    $0x0,%edi
  803906:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  80390d:	00 00 00 
  803910:	ff d0                	callq  *%rax
  803912:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803915:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803919:	79 08                	jns    803923 <init_stack+0xf0>
  80391b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80391e:	e9 b7 01 00 00       	jmpq   803ada <init_stack+0x2a7>
  803923:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  80392a:	e9 8a 00 00 00       	jmpq   8039b9 <init_stack+0x186>
  80392f:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803932:	48 98                	cltq   
  803934:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80393b:	00 
  80393c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803940:	48 01 c2             	add    %rax,%rdx
  803943:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803948:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80394c:	48 01 c8             	add    %rcx,%rax
  80394f:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803955:	48 89 02             	mov    %rax,(%rdx)
  803958:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80395b:	48 98                	cltq   
  80395d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803964:	00 
  803965:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803969:	48 01 d0             	add    %rdx,%rax
  80396c:	48 8b 10             	mov    (%rax),%rdx
  80396f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803973:	48 89 d6             	mov    %rdx,%rsi
  803976:	48 89 c7             	mov    %rax,%rdi
  803979:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  803980:	00 00 00 
  803983:	ff d0                	callq  *%rax
  803985:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803988:	48 98                	cltq   
  80398a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803991:	00 
  803992:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  803996:	48 01 d0             	add    %rdx,%rax
  803999:	48 8b 00             	mov    (%rax),%rax
  80399c:	48 89 c7             	mov    %rax,%rdi
  80399f:	48 b8 d2 14 80 00 00 	movabs $0x8014d2,%rax
  8039a6:	00 00 00 
  8039a9:	ff d0                	callq  *%rax
  8039ab:	48 98                	cltq   
  8039ad:	48 83 c0 01          	add    $0x1,%rax
  8039b1:	48 01 45 e0          	add    %rax,-0x20(%rbp)
  8039b5:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  8039b9:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8039bc:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8039bf:	0f 8c 6a ff ff ff    	jl     80392f <init_stack+0xfc>
  8039c5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8039c8:	48 98                	cltq   
  8039ca:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8039d1:	00 
  8039d2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8039d6:	48 01 d0             	add    %rdx,%rax
  8039d9:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8039e0:	48 81 7d e0 00 10 40 	cmpq   $0x401000,-0x20(%rbp)
  8039e7:	00 
  8039e8:	74 35                	je     803a1f <init_stack+0x1ec>
  8039ea:	48 b9 38 57 80 00 00 	movabs $0x805738,%rcx
  8039f1:	00 00 00 
  8039f4:	48 ba 5e 57 80 00 00 	movabs $0x80575e,%rdx
  8039fb:	00 00 00 
  8039fe:	be f6 00 00 00       	mov    $0xf6,%esi
  803a03:	48 bf f8 56 80 00 00 	movabs $0x8056f8,%rdi
  803a0a:	00 00 00 
  803a0d:	b8 00 00 00 00       	mov    $0x0,%eax
  803a12:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  803a19:	00 00 00 
  803a1c:	41 ff d0             	callq  *%r8
  803a1f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803a23:	48 8d 50 f8          	lea    -0x8(%rax),%rdx
  803a27:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803a2c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803a30:	48 01 c8             	add    %rcx,%rax
  803a33:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803a39:	48 89 02             	mov    %rax,(%rdx)
  803a3c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803a40:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
  803a44:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803a47:	48 98                	cltq   
  803a49:	48 89 02             	mov    %rax,(%rdx)
  803a4c:	ba f0 cf 7f ef       	mov    $0xef7fcff0,%edx
  803a51:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803a55:	48 01 d0             	add    %rdx,%rax
  803a58:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803a5e:	48 89 c2             	mov    %rax,%rdx
  803a61:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  803a65:	48 89 10             	mov    %rdx,(%rax)
  803a68:	8b 45 cc             	mov    -0x34(%rbp),%eax
  803a6b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  803a71:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803a76:	89 c2                	mov    %eax,%edx
  803a78:	be 00 00 40 00       	mov    $0x400000,%esi
  803a7d:	bf 00 00 00 00       	mov    $0x0,%edi
  803a82:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  803a89:	00 00 00 
  803a8c:	ff d0                	callq  *%rax
  803a8e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803a91:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803a95:	79 02                	jns    803a99 <init_stack+0x266>
  803a97:	eb 28                	jmp    803ac1 <init_stack+0x28e>
  803a99:	be 00 00 40 00       	mov    $0x400000,%esi
  803a9e:	bf 00 00 00 00       	mov    $0x0,%edi
  803aa3:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  803aaa:	00 00 00 
  803aad:	ff d0                	callq  *%rax
  803aaf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ab2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803ab6:	79 02                	jns    803aba <init_stack+0x287>
  803ab8:	eb 07                	jmp    803ac1 <init_stack+0x28e>
  803aba:	b8 00 00 00 00       	mov    $0x0,%eax
  803abf:	eb 19                	jmp    803ada <init_stack+0x2a7>
  803ac1:	be 00 00 40 00       	mov    $0x400000,%esi
  803ac6:	bf 00 00 00 00       	mov    $0x0,%edi
  803acb:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  803ad2:	00 00 00 
  803ad5:	ff d0                	callq  *%rax
  803ad7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ada:	c9                   	leaveq 
  803adb:	c3                   	retq   

0000000000803adc <map_segment>:
  803adc:	55                   	push   %rbp
  803add:	48 89 e5             	mov    %rsp,%rbp
  803ae0:	48 83 ec 50          	sub    $0x50,%rsp
  803ae4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803ae7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803aeb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803aef:	89 4d d8             	mov    %ecx,-0x28(%rbp)
  803af2:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  803af6:	44 89 4d bc          	mov    %r9d,-0x44(%rbp)
  803afa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803afe:	25 ff 0f 00 00       	and    $0xfff,%eax
  803b03:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b06:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b0a:	74 21                	je     803b2d <map_segment+0x51>
  803b0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b0f:	48 98                	cltq   
  803b11:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  803b15:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b18:	48 98                	cltq   
  803b1a:	48 01 45 c8          	add    %rax,-0x38(%rbp)
  803b1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b21:	48 98                	cltq   
  803b23:	48 01 45 c0          	add    %rax,-0x40(%rbp)
  803b27:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b2a:	29 45 bc             	sub    %eax,-0x44(%rbp)
  803b2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803b34:	e9 79 01 00 00       	jmpq   803cb2 <map_segment+0x1d6>
  803b39:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b3c:	48 98                	cltq   
  803b3e:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
  803b42:	72 3c                	jb     803b80 <map_segment+0xa4>
  803b44:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b47:	48 63 d0             	movslq %eax,%rdx
  803b4a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803b4e:	48 01 d0             	add    %rdx,%rax
  803b51:	48 89 c1             	mov    %rax,%rcx
  803b54:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803b57:	8b 55 10             	mov    0x10(%rbp),%edx
  803b5a:	48 89 ce             	mov    %rcx,%rsi
  803b5d:	89 c7                	mov    %eax,%edi
  803b5f:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  803b66:	00 00 00 
  803b69:	ff d0                	callq  *%rax
  803b6b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803b6e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803b72:	0f 89 33 01 00 00    	jns    803cab <map_segment+0x1cf>
  803b78:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803b7b:	e9 46 01 00 00       	jmpq   803cc6 <map_segment+0x1ea>
  803b80:	ba 07 00 00 00       	mov    $0x7,%edx
  803b85:	be 00 00 40 00       	mov    $0x400000,%esi
  803b8a:	bf 00 00 00 00       	mov    $0x0,%edi
  803b8f:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  803b96:	00 00 00 
  803b99:	ff d0                	callq  *%rax
  803b9b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803b9e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803ba2:	79 08                	jns    803bac <map_segment+0xd0>
  803ba4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803ba7:	e9 1a 01 00 00       	jmpq   803cc6 <map_segment+0x1ea>
  803bac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803baf:	8b 55 bc             	mov    -0x44(%rbp),%edx
  803bb2:	01 c2                	add    %eax,%edx
  803bb4:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803bb7:	89 d6                	mov    %edx,%esi
  803bb9:	89 c7                	mov    %eax,%edi
  803bbb:	48 b8 83 29 80 00 00 	movabs $0x802983,%rax
  803bc2:	00 00 00 
  803bc5:	ff d0                	callq  *%rax
  803bc7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803bca:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803bce:	79 08                	jns    803bd8 <map_segment+0xfc>
  803bd0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803bd3:	e9 ee 00 00 00       	jmpq   803cc6 <map_segment+0x1ea>
  803bd8:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%rbp)
  803bdf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803be2:	48 98                	cltq   
  803be4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803be8:	48 29 c2             	sub    %rax,%rdx
  803beb:	48 89 d0             	mov    %rdx,%rax
  803bee:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803bf2:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803bf5:	48 63 d0             	movslq %eax,%rdx
  803bf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803bfc:	48 39 c2             	cmp    %rax,%rdx
  803bff:	48 0f 47 d0          	cmova  %rax,%rdx
  803c03:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803c06:	be 00 00 40 00       	mov    $0x400000,%esi
  803c0b:	89 c7                	mov    %eax,%edi
  803c0d:	48 b8 3a 28 80 00 00 	movabs $0x80283a,%rax
  803c14:	00 00 00 
  803c17:	ff d0                	callq  *%rax
  803c19:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803c1c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803c20:	79 08                	jns    803c2a <map_segment+0x14e>
  803c22:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803c25:	e9 9c 00 00 00       	jmpq   803cc6 <map_segment+0x1ea>
  803c2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c2d:	48 63 d0             	movslq %eax,%rdx
  803c30:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c34:	48 01 d0             	add    %rdx,%rax
  803c37:	48 89 c2             	mov    %rax,%rdx
  803c3a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803c3d:	44 8b 45 10          	mov    0x10(%rbp),%r8d
  803c41:	48 89 d1             	mov    %rdx,%rcx
  803c44:	89 c2                	mov    %eax,%edx
  803c46:	be 00 00 40 00       	mov    $0x400000,%esi
  803c4b:	bf 00 00 00 00       	mov    $0x0,%edi
  803c50:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  803c57:	00 00 00 
  803c5a:	ff d0                	callq  *%rax
  803c5c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803c5f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803c63:	79 30                	jns    803c95 <map_segment+0x1b9>
  803c65:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803c68:	89 c1                	mov    %eax,%ecx
  803c6a:	48 ba 73 57 80 00 00 	movabs $0x805773,%rdx
  803c71:	00 00 00 
  803c74:	be 29 01 00 00       	mov    $0x129,%esi
  803c79:	48 bf f8 56 80 00 00 	movabs $0x8056f8,%rdi
  803c80:	00 00 00 
  803c83:	b8 00 00 00 00       	mov    $0x0,%eax
  803c88:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  803c8f:	00 00 00 
  803c92:	41 ff d0             	callq  *%r8
  803c95:	be 00 00 40 00       	mov    $0x400000,%esi
  803c9a:	bf 00 00 00 00       	mov    $0x0,%edi
  803c9f:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  803ca6:	00 00 00 
  803ca9:	ff d0                	callq  *%rax
  803cab:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
  803cb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cb5:	48 98                	cltq   
  803cb7:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803cbb:	0f 82 78 fe ff ff    	jb     803b39 <map_segment+0x5d>
  803cc1:	b8 00 00 00 00       	mov    $0x0,%eax
  803cc6:	c9                   	leaveq 
  803cc7:	c3                   	retq   

0000000000803cc8 <copy_shared_pages>:
  803cc8:	55                   	push   %rbp
  803cc9:	48 89 e5             	mov    %rsp,%rbp
  803ccc:	48 83 ec 30          	sub    $0x30,%rsp
  803cd0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803cd3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803cda:	00 
  803cdb:	e9 eb 00 00 00       	jmpq   803dcb <copy_shared_pages+0x103>
  803ce0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ce4:	48 c1 f8 12          	sar    $0x12,%rax
  803ce8:	48 89 c2             	mov    %rax,%rdx
  803ceb:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  803cf2:	01 00 00 
  803cf5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803cf9:	83 e0 01             	and    $0x1,%eax
  803cfc:	48 85 c0             	test   %rax,%rax
  803cff:	74 21                	je     803d22 <copy_shared_pages+0x5a>
  803d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803d05:	48 c1 f8 09          	sar    $0x9,%rax
  803d09:	48 89 c2             	mov    %rax,%rdx
  803d0c:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  803d13:	01 00 00 
  803d16:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803d1a:	83 e0 01             	and    $0x1,%eax
  803d1d:	48 85 c0             	test   %rax,%rax
  803d20:	75 0d                	jne    803d2f <copy_shared_pages+0x67>
  803d22:	48 81 45 f8 00 02 00 	addq   $0x200,-0x8(%rbp)
  803d29:	00 
  803d2a:	e9 9c 00 00 00       	jmpq   803dcb <copy_shared_pages+0x103>
  803d2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803d33:	48 05 00 02 00 00    	add    $0x200,%rax
  803d39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803d3d:	eb 7e                	jmp    803dbd <copy_shared_pages+0xf5>
  803d3f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803d46:	01 00 00 
  803d49:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803d4d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803d51:	25 01 04 00 00       	and    $0x401,%eax
  803d56:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  803d5c:	75 5a                	jne    803db8 <copy_shared_pages+0xf0>
  803d5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803d62:	48 c1 e0 0c          	shl    $0xc,%rax
  803d66:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803d6a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803d71:	01 00 00 
  803d74:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803d78:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803d7c:	25 07 0e 00 00       	and    $0xe07,%eax
  803d81:	89 c6                	mov    %eax,%esi
  803d83:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803d87:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803d8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d8e:	41 89 f0             	mov    %esi,%r8d
  803d91:	48 89 c6             	mov    %rax,%rsi
  803d94:	bf 00 00 00 00       	mov    $0x0,%edi
  803d99:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  803da0:	00 00 00 
  803da3:	ff d0                	callq  *%rax
  803da5:	48 98                	cltq   
  803da7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803dab:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803db0:	79 06                	jns    803db8 <copy_shared_pages+0xf0>
  803db2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803db6:	eb 28                	jmp    803de0 <copy_shared_pages+0x118>
  803db8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803dbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803dc1:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  803dc5:	0f 8c 74 ff ff ff    	jl     803d3f <copy_shared_pages+0x77>
  803dcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803dcf:	48 3d ff 07 00 08    	cmp    $0x80007ff,%rax
  803dd5:	0f 86 05 ff ff ff    	jbe    803ce0 <copy_shared_pages+0x18>
  803ddb:	b8 00 00 00 00       	mov    $0x0,%eax
  803de0:	c9                   	leaveq 
  803de1:	c3                   	retq   

0000000000803de2 <fd2sockid>:
  803de2:	55                   	push   %rbp
  803de3:	48 89 e5             	mov    %rsp,%rbp
  803de6:	48 83 ec 20          	sub    $0x20,%rsp
  803dea:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ded:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803df1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803df4:	48 89 d6             	mov    %rdx,%rsi
  803df7:	89 c7                	mov    %eax,%edi
  803df9:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  803e00:	00 00 00 
  803e03:	ff d0                	callq  *%rax
  803e05:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e08:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e0c:	79 05                	jns    803e13 <fd2sockid+0x31>
  803e0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e11:	eb 24                	jmp    803e37 <fd2sockid+0x55>
  803e13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e17:	8b 10                	mov    (%rax),%edx
  803e19:	48 b8 40 88 80 00 00 	movabs $0x808840,%rax
  803e20:	00 00 00 
  803e23:	8b 00                	mov    (%rax),%eax
  803e25:	39 c2                	cmp    %eax,%edx
  803e27:	74 07                	je     803e30 <fd2sockid+0x4e>
  803e29:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803e2e:	eb 07                	jmp    803e37 <fd2sockid+0x55>
  803e30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e34:	8b 40 0c             	mov    0xc(%rax),%eax
  803e37:	c9                   	leaveq 
  803e38:	c3                   	retq   

0000000000803e39 <alloc_sockfd>:
  803e39:	55                   	push   %rbp
  803e3a:	48 89 e5             	mov    %rsp,%rbp
  803e3d:	48 83 ec 20          	sub    $0x20,%rsp
  803e41:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e44:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803e48:	48 89 c7             	mov    %rax,%rdi
  803e4b:	48 b8 9b 22 80 00 00 	movabs $0x80229b,%rax
  803e52:	00 00 00 
  803e55:	ff d0                	callq  *%rax
  803e57:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e5a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e5e:	78 26                	js     803e86 <alloc_sockfd+0x4d>
  803e60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e64:	ba 07 04 00 00       	mov    $0x407,%edx
  803e69:	48 89 c6             	mov    %rax,%rsi
  803e6c:	bf 00 00 00 00       	mov    $0x0,%edi
  803e71:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  803e78:	00 00 00 
  803e7b:	ff d0                	callq  *%rax
  803e7d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e80:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e84:	79 16                	jns    803e9c <alloc_sockfd+0x63>
  803e86:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803e89:	89 c7                	mov    %eax,%edi
  803e8b:	48 b8 46 43 80 00 00 	movabs $0x804346,%rax
  803e92:	00 00 00 
  803e95:	ff d0                	callq  *%rax
  803e97:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e9a:	eb 3a                	jmp    803ed6 <alloc_sockfd+0x9d>
  803e9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ea0:	48 ba 40 88 80 00 00 	movabs $0x808840,%rdx
  803ea7:	00 00 00 
  803eaa:	8b 12                	mov    (%rdx),%edx
  803eac:	89 10                	mov    %edx,(%rax)
  803eae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803eb2:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803eb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ebd:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803ec0:	89 50 0c             	mov    %edx,0xc(%rax)
  803ec3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ec7:	48 89 c7             	mov    %rax,%rdi
  803eca:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  803ed1:	00 00 00 
  803ed4:	ff d0                	callq  *%rax
  803ed6:	c9                   	leaveq 
  803ed7:	c3                   	retq   

0000000000803ed8 <accept>:
  803ed8:	55                   	push   %rbp
  803ed9:	48 89 e5             	mov    %rsp,%rbp
  803edc:	48 83 ec 30          	sub    $0x30,%rsp
  803ee0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ee3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803ee7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803eeb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803eee:	89 c7                	mov    %eax,%edi
  803ef0:	48 b8 e2 3d 80 00 00 	movabs $0x803de2,%rax
  803ef7:	00 00 00 
  803efa:	ff d0                	callq  *%rax
  803efc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803eff:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f03:	79 05                	jns    803f0a <accept+0x32>
  803f05:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f08:	eb 3b                	jmp    803f45 <accept+0x6d>
  803f0a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803f0e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803f12:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f15:	48 89 ce             	mov    %rcx,%rsi
  803f18:	89 c7                	mov    %eax,%edi
  803f1a:	48 b8 23 42 80 00 00 	movabs $0x804223,%rax
  803f21:	00 00 00 
  803f24:	ff d0                	callq  *%rax
  803f26:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f29:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f2d:	79 05                	jns    803f34 <accept+0x5c>
  803f2f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f32:	eb 11                	jmp    803f45 <accept+0x6d>
  803f34:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f37:	89 c7                	mov    %eax,%edi
  803f39:	48 b8 39 3e 80 00 00 	movabs $0x803e39,%rax
  803f40:	00 00 00 
  803f43:	ff d0                	callq  *%rax
  803f45:	c9                   	leaveq 
  803f46:	c3                   	retq   

0000000000803f47 <bind>:
  803f47:	55                   	push   %rbp
  803f48:	48 89 e5             	mov    %rsp,%rbp
  803f4b:	48 83 ec 20          	sub    $0x20,%rsp
  803f4f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803f52:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f56:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803f59:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f5c:	89 c7                	mov    %eax,%edi
  803f5e:	48 b8 e2 3d 80 00 00 	movabs $0x803de2,%rax
  803f65:	00 00 00 
  803f68:	ff d0                	callq  *%rax
  803f6a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f6d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f71:	79 05                	jns    803f78 <bind+0x31>
  803f73:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f76:	eb 1b                	jmp    803f93 <bind+0x4c>
  803f78:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803f7b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803f7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f82:	48 89 ce             	mov    %rcx,%rsi
  803f85:	89 c7                	mov    %eax,%edi
  803f87:	48 b8 a2 42 80 00 00 	movabs $0x8042a2,%rax
  803f8e:	00 00 00 
  803f91:	ff d0                	callq  *%rax
  803f93:	c9                   	leaveq 
  803f94:	c3                   	retq   

0000000000803f95 <shutdown>:
  803f95:	55                   	push   %rbp
  803f96:	48 89 e5             	mov    %rsp,%rbp
  803f99:	48 83 ec 20          	sub    $0x20,%rsp
  803f9d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803fa0:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803fa3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fa6:	89 c7                	mov    %eax,%edi
  803fa8:	48 b8 e2 3d 80 00 00 	movabs $0x803de2,%rax
  803faf:	00 00 00 
  803fb2:	ff d0                	callq  *%rax
  803fb4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803fb7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803fbb:	79 05                	jns    803fc2 <shutdown+0x2d>
  803fbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fc0:	eb 16                	jmp    803fd8 <shutdown+0x43>
  803fc2:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803fc5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fc8:	89 d6                	mov    %edx,%esi
  803fca:	89 c7                	mov    %eax,%edi
  803fcc:	48 b8 06 43 80 00 00 	movabs $0x804306,%rax
  803fd3:	00 00 00 
  803fd6:	ff d0                	callq  *%rax
  803fd8:	c9                   	leaveq 
  803fd9:	c3                   	retq   

0000000000803fda <devsock_close>:
  803fda:	55                   	push   %rbp
  803fdb:	48 89 e5             	mov    %rsp,%rbp
  803fde:	48 83 ec 10          	sub    $0x10,%rsp
  803fe2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803fe6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803fea:	48 89 c7             	mov    %rax,%rdi
  803fed:	48 b8 8a 4e 80 00 00 	movabs $0x804e8a,%rax
  803ff4:	00 00 00 
  803ff7:	ff d0                	callq  *%rax
  803ff9:	83 f8 01             	cmp    $0x1,%eax
  803ffc:	75 17                	jne    804015 <devsock_close+0x3b>
  803ffe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804002:	8b 40 0c             	mov    0xc(%rax),%eax
  804005:	89 c7                	mov    %eax,%edi
  804007:	48 b8 46 43 80 00 00 	movabs $0x804346,%rax
  80400e:	00 00 00 
  804011:	ff d0                	callq  *%rax
  804013:	eb 05                	jmp    80401a <devsock_close+0x40>
  804015:	b8 00 00 00 00       	mov    $0x0,%eax
  80401a:	c9                   	leaveq 
  80401b:	c3                   	retq   

000000000080401c <connect>:
  80401c:	55                   	push   %rbp
  80401d:	48 89 e5             	mov    %rsp,%rbp
  804020:	48 83 ec 20          	sub    $0x20,%rsp
  804024:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804027:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80402b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80402e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804031:	89 c7                	mov    %eax,%edi
  804033:	48 b8 e2 3d 80 00 00 	movabs $0x803de2,%rax
  80403a:	00 00 00 
  80403d:	ff d0                	callq  *%rax
  80403f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804042:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804046:	79 05                	jns    80404d <connect+0x31>
  804048:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80404b:	eb 1b                	jmp    804068 <connect+0x4c>
  80404d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804050:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  804054:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804057:	48 89 ce             	mov    %rcx,%rsi
  80405a:	89 c7                	mov    %eax,%edi
  80405c:	48 b8 73 43 80 00 00 	movabs $0x804373,%rax
  804063:	00 00 00 
  804066:	ff d0                	callq  *%rax
  804068:	c9                   	leaveq 
  804069:	c3                   	retq   

000000000080406a <listen>:
  80406a:	55                   	push   %rbp
  80406b:	48 89 e5             	mov    %rsp,%rbp
  80406e:	48 83 ec 20          	sub    $0x20,%rsp
  804072:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804075:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804078:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80407b:	89 c7                	mov    %eax,%edi
  80407d:	48 b8 e2 3d 80 00 00 	movabs $0x803de2,%rax
  804084:	00 00 00 
  804087:	ff d0                	callq  *%rax
  804089:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80408c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804090:	79 05                	jns    804097 <listen+0x2d>
  804092:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804095:	eb 16                	jmp    8040ad <listen+0x43>
  804097:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80409a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80409d:	89 d6                	mov    %edx,%esi
  80409f:	89 c7                	mov    %eax,%edi
  8040a1:	48 b8 d7 43 80 00 00 	movabs $0x8043d7,%rax
  8040a8:	00 00 00 
  8040ab:	ff d0                	callq  *%rax
  8040ad:	c9                   	leaveq 
  8040ae:	c3                   	retq   

00000000008040af <devsock_read>:
  8040af:	55                   	push   %rbp
  8040b0:	48 89 e5             	mov    %rsp,%rbp
  8040b3:	48 83 ec 20          	sub    $0x20,%rsp
  8040b7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8040bb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8040bf:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8040c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8040c7:	89 c2                	mov    %eax,%edx
  8040c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040cd:	8b 40 0c             	mov    0xc(%rax),%eax
  8040d0:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8040d4:	b9 00 00 00 00       	mov    $0x0,%ecx
  8040d9:	89 c7                	mov    %eax,%edi
  8040db:	48 b8 17 44 80 00 00 	movabs $0x804417,%rax
  8040e2:	00 00 00 
  8040e5:	ff d0                	callq  *%rax
  8040e7:	c9                   	leaveq 
  8040e8:	c3                   	retq   

00000000008040e9 <devsock_write>:
  8040e9:	55                   	push   %rbp
  8040ea:	48 89 e5             	mov    %rsp,%rbp
  8040ed:	48 83 ec 20          	sub    $0x20,%rsp
  8040f1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8040f5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8040f9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8040fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804101:	89 c2                	mov    %eax,%edx
  804103:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804107:	8b 40 0c             	mov    0xc(%rax),%eax
  80410a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80410e:	b9 00 00 00 00       	mov    $0x0,%ecx
  804113:	89 c7                	mov    %eax,%edi
  804115:	48 b8 e3 44 80 00 00 	movabs $0x8044e3,%rax
  80411c:	00 00 00 
  80411f:	ff d0                	callq  *%rax
  804121:	c9                   	leaveq 
  804122:	c3                   	retq   

0000000000804123 <devsock_stat>:
  804123:	55                   	push   %rbp
  804124:	48 89 e5             	mov    %rsp,%rbp
  804127:	48 83 ec 10          	sub    $0x10,%rsp
  80412b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80412f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804133:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804137:	48 be 95 57 80 00 00 	movabs $0x805795,%rsi
  80413e:	00 00 00 
  804141:	48 89 c7             	mov    %rax,%rdi
  804144:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  80414b:	00 00 00 
  80414e:	ff d0                	callq  *%rax
  804150:	b8 00 00 00 00       	mov    $0x0,%eax
  804155:	c9                   	leaveq 
  804156:	c3                   	retq   

0000000000804157 <socket>:
  804157:	55                   	push   %rbp
  804158:	48 89 e5             	mov    %rsp,%rbp
  80415b:	48 83 ec 20          	sub    $0x20,%rsp
  80415f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804162:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804165:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  804168:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80416b:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80416e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804171:	89 ce                	mov    %ecx,%esi
  804173:	89 c7                	mov    %eax,%edi
  804175:	48 b8 9b 45 80 00 00 	movabs $0x80459b,%rax
  80417c:	00 00 00 
  80417f:	ff d0                	callq  *%rax
  804181:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804184:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804188:	79 05                	jns    80418f <socket+0x38>
  80418a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80418d:	eb 11                	jmp    8041a0 <socket+0x49>
  80418f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804192:	89 c7                	mov    %eax,%edi
  804194:	48 b8 39 3e 80 00 00 	movabs $0x803e39,%rax
  80419b:	00 00 00 
  80419e:	ff d0                	callq  *%rax
  8041a0:	c9                   	leaveq 
  8041a1:	c3                   	retq   

00000000008041a2 <nsipc>:
  8041a2:	55                   	push   %rbp
  8041a3:	48 89 e5             	mov    %rsp,%rbp
  8041a6:	48 83 ec 10          	sub    $0x10,%rsp
  8041aa:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8041ad:	48 b8 04 90 80 00 00 	movabs $0x809004,%rax
  8041b4:	00 00 00 
  8041b7:	8b 00                	mov    (%rax),%eax
  8041b9:	85 c0                	test   %eax,%eax
  8041bb:	75 1d                	jne    8041da <nsipc+0x38>
  8041bd:	bf 02 00 00 00       	mov    $0x2,%edi
  8041c2:	48 b8 18 4e 80 00 00 	movabs $0x804e18,%rax
  8041c9:	00 00 00 
  8041cc:	ff d0                	callq  *%rax
  8041ce:	48 ba 04 90 80 00 00 	movabs $0x809004,%rdx
  8041d5:	00 00 00 
  8041d8:	89 02                	mov    %eax,(%rdx)
  8041da:	48 b8 04 90 80 00 00 	movabs $0x809004,%rax
  8041e1:	00 00 00 
  8041e4:	8b 00                	mov    (%rax),%eax
  8041e6:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8041e9:	b9 07 00 00 00       	mov    $0x7,%ecx
  8041ee:	48 ba 00 d0 80 00 00 	movabs $0x80d000,%rdx
  8041f5:	00 00 00 
  8041f8:	89 c7                	mov    %eax,%edi
  8041fa:	48 b8 0d 4d 80 00 00 	movabs $0x804d0d,%rax
  804201:	00 00 00 
  804204:	ff d0                	callq  *%rax
  804206:	ba 00 00 00 00       	mov    $0x0,%edx
  80420b:	be 00 00 00 00       	mov    $0x0,%esi
  804210:	bf 00 00 00 00       	mov    $0x0,%edi
  804215:	48 b8 4c 4c 80 00 00 	movabs $0x804c4c,%rax
  80421c:	00 00 00 
  80421f:	ff d0                	callq  *%rax
  804221:	c9                   	leaveq 
  804222:	c3                   	retq   

0000000000804223 <nsipc_accept>:
  804223:	55                   	push   %rbp
  804224:	48 89 e5             	mov    %rsp,%rbp
  804227:	48 83 ec 30          	sub    $0x30,%rsp
  80422b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80422e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804232:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804236:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80423d:	00 00 00 
  804240:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804243:	89 10                	mov    %edx,(%rax)
  804245:	bf 01 00 00 00       	mov    $0x1,%edi
  80424a:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  804251:	00 00 00 
  804254:	ff d0                	callq  *%rax
  804256:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804259:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80425d:	78 3e                	js     80429d <nsipc_accept+0x7a>
  80425f:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804266:	00 00 00 
  804269:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80426d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804271:	8b 40 10             	mov    0x10(%rax),%eax
  804274:	89 c2                	mov    %eax,%edx
  804276:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80427a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80427e:	48 89 ce             	mov    %rcx,%rsi
  804281:	48 89 c7             	mov    %rax,%rdi
  804284:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  80428b:	00 00 00 
  80428e:	ff d0                	callq  *%rax
  804290:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804294:	8b 50 10             	mov    0x10(%rax),%edx
  804297:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80429b:	89 10                	mov    %edx,(%rax)
  80429d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8042a0:	c9                   	leaveq 
  8042a1:	c3                   	retq   

00000000008042a2 <nsipc_bind>:
  8042a2:	55                   	push   %rbp
  8042a3:	48 89 e5             	mov    %rsp,%rbp
  8042a6:	48 83 ec 10          	sub    $0x10,%rsp
  8042aa:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8042ad:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8042b1:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8042b4:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8042bb:	00 00 00 
  8042be:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8042c1:	89 10                	mov    %edx,(%rax)
  8042c3:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8042c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042ca:	48 89 c6             	mov    %rax,%rsi
  8042cd:	48 bf 04 d0 80 00 00 	movabs $0x80d004,%rdi
  8042d4:	00 00 00 
  8042d7:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  8042de:	00 00 00 
  8042e1:	ff d0                	callq  *%rax
  8042e3:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8042ea:	00 00 00 
  8042ed:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8042f0:	89 50 14             	mov    %edx,0x14(%rax)
  8042f3:	bf 02 00 00 00       	mov    $0x2,%edi
  8042f8:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  8042ff:	00 00 00 
  804302:	ff d0                	callq  *%rax
  804304:	c9                   	leaveq 
  804305:	c3                   	retq   

0000000000804306 <nsipc_shutdown>:
  804306:	55                   	push   %rbp
  804307:	48 89 e5             	mov    %rsp,%rbp
  80430a:	48 83 ec 10          	sub    $0x10,%rsp
  80430e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804311:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804314:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80431b:	00 00 00 
  80431e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804321:	89 10                	mov    %edx,(%rax)
  804323:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80432a:	00 00 00 
  80432d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804330:	89 50 04             	mov    %edx,0x4(%rax)
  804333:	bf 03 00 00 00       	mov    $0x3,%edi
  804338:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  80433f:	00 00 00 
  804342:	ff d0                	callq  *%rax
  804344:	c9                   	leaveq 
  804345:	c3                   	retq   

0000000000804346 <nsipc_close>:
  804346:	55                   	push   %rbp
  804347:	48 89 e5             	mov    %rsp,%rbp
  80434a:	48 83 ec 10          	sub    $0x10,%rsp
  80434e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804351:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804358:	00 00 00 
  80435b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80435e:	89 10                	mov    %edx,(%rax)
  804360:	bf 04 00 00 00       	mov    $0x4,%edi
  804365:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  80436c:	00 00 00 
  80436f:	ff d0                	callq  *%rax
  804371:	c9                   	leaveq 
  804372:	c3                   	retq   

0000000000804373 <nsipc_connect>:
  804373:	55                   	push   %rbp
  804374:	48 89 e5             	mov    %rsp,%rbp
  804377:	48 83 ec 10          	sub    $0x10,%rsp
  80437b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80437e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804382:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804385:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80438c:	00 00 00 
  80438f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804392:	89 10                	mov    %edx,(%rax)
  804394:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804397:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80439b:	48 89 c6             	mov    %rax,%rsi
  80439e:	48 bf 04 d0 80 00 00 	movabs $0x80d004,%rdi
  8043a5:	00 00 00 
  8043a8:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  8043af:	00 00 00 
  8043b2:	ff d0                	callq  *%rax
  8043b4:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8043bb:	00 00 00 
  8043be:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8043c1:	89 50 14             	mov    %edx,0x14(%rax)
  8043c4:	bf 05 00 00 00       	mov    $0x5,%edi
  8043c9:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  8043d0:	00 00 00 
  8043d3:	ff d0                	callq  *%rax
  8043d5:	c9                   	leaveq 
  8043d6:	c3                   	retq   

00000000008043d7 <nsipc_listen>:
  8043d7:	55                   	push   %rbp
  8043d8:	48 89 e5             	mov    %rsp,%rbp
  8043db:	48 83 ec 10          	sub    $0x10,%rsp
  8043df:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8043e2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8043e5:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8043ec:	00 00 00 
  8043ef:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8043f2:	89 10                	mov    %edx,(%rax)
  8043f4:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8043fb:	00 00 00 
  8043fe:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804401:	89 50 04             	mov    %edx,0x4(%rax)
  804404:	bf 06 00 00 00       	mov    $0x6,%edi
  804409:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  804410:	00 00 00 
  804413:	ff d0                	callq  *%rax
  804415:	c9                   	leaveq 
  804416:	c3                   	retq   

0000000000804417 <nsipc_recv>:
  804417:	55                   	push   %rbp
  804418:	48 89 e5             	mov    %rsp,%rbp
  80441b:	48 83 ec 30          	sub    $0x30,%rsp
  80441f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804422:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804426:	89 55 e8             	mov    %edx,-0x18(%rbp)
  804429:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80442c:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804433:	00 00 00 
  804436:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804439:	89 10                	mov    %edx,(%rax)
  80443b:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804442:	00 00 00 
  804445:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804448:	89 50 04             	mov    %edx,0x4(%rax)
  80444b:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804452:	00 00 00 
  804455:	8b 55 dc             	mov    -0x24(%rbp),%edx
  804458:	89 50 08             	mov    %edx,0x8(%rax)
  80445b:	bf 07 00 00 00       	mov    $0x7,%edi
  804460:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  804467:	00 00 00 
  80446a:	ff d0                	callq  *%rax
  80446c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80446f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804473:	78 69                	js     8044de <nsipc_recv+0xc7>
  804475:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  80447c:	7f 08                	jg     804486 <nsipc_recv+0x6f>
  80447e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804481:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  804484:	7e 35                	jle    8044bb <nsipc_recv+0xa4>
  804486:	48 b9 9c 57 80 00 00 	movabs $0x80579c,%rcx
  80448d:	00 00 00 
  804490:	48 ba b1 57 80 00 00 	movabs $0x8057b1,%rdx
  804497:	00 00 00 
  80449a:	be 62 00 00 00       	mov    $0x62,%esi
  80449f:	48 bf c6 57 80 00 00 	movabs $0x8057c6,%rdi
  8044a6:	00 00 00 
  8044a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8044ae:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  8044b5:	00 00 00 
  8044b8:	41 ff d0             	callq  *%r8
  8044bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044be:	48 63 d0             	movslq %eax,%rdx
  8044c1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8044c5:	48 be 00 d0 80 00 00 	movabs $0x80d000,%rsi
  8044cc:	00 00 00 
  8044cf:	48 89 c7             	mov    %rax,%rdi
  8044d2:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  8044d9:	00 00 00 
  8044dc:	ff d0                	callq  *%rax
  8044de:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044e1:	c9                   	leaveq 
  8044e2:	c3                   	retq   

00000000008044e3 <nsipc_send>:
  8044e3:	55                   	push   %rbp
  8044e4:	48 89 e5             	mov    %rsp,%rbp
  8044e7:	48 83 ec 20          	sub    $0x20,%rsp
  8044eb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8044ee:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8044f2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8044f5:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8044f8:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8044ff:	00 00 00 
  804502:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804505:	89 10                	mov    %edx,(%rax)
  804507:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  80450e:	7e 35                	jle    804545 <nsipc_send+0x62>
  804510:	48 b9 d5 57 80 00 00 	movabs $0x8057d5,%rcx
  804517:	00 00 00 
  80451a:	48 ba b1 57 80 00 00 	movabs $0x8057b1,%rdx
  804521:	00 00 00 
  804524:	be 6d 00 00 00       	mov    $0x6d,%esi
  804529:	48 bf c6 57 80 00 00 	movabs $0x8057c6,%rdi
  804530:	00 00 00 
  804533:	b8 00 00 00 00       	mov    $0x0,%eax
  804538:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  80453f:	00 00 00 
  804542:	41 ff d0             	callq  *%r8
  804545:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804548:	48 63 d0             	movslq %eax,%rdx
  80454b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80454f:	48 89 c6             	mov    %rax,%rsi
  804552:	48 bf 0c d0 80 00 00 	movabs $0x80d00c,%rdi
  804559:	00 00 00 
  80455c:	48 b8 62 18 80 00 00 	movabs $0x801862,%rax
  804563:	00 00 00 
  804566:	ff d0                	callq  *%rax
  804568:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80456f:	00 00 00 
  804572:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804575:	89 50 04             	mov    %edx,0x4(%rax)
  804578:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  80457f:	00 00 00 
  804582:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804585:	89 50 08             	mov    %edx,0x8(%rax)
  804588:	bf 08 00 00 00       	mov    $0x8,%edi
  80458d:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  804594:	00 00 00 
  804597:	ff d0                	callq  *%rax
  804599:	c9                   	leaveq 
  80459a:	c3                   	retq   

000000000080459b <nsipc_socket>:
  80459b:	55                   	push   %rbp
  80459c:	48 89 e5             	mov    %rsp,%rbp
  80459f:	48 83 ec 10          	sub    $0x10,%rsp
  8045a3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8045a6:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8045a9:	89 55 f4             	mov    %edx,-0xc(%rbp)
  8045ac:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8045b3:	00 00 00 
  8045b6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8045b9:	89 10                	mov    %edx,(%rax)
  8045bb:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8045c2:	00 00 00 
  8045c5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8045c8:	89 50 04             	mov    %edx,0x4(%rax)
  8045cb:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  8045d2:	00 00 00 
  8045d5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8045d8:	89 50 08             	mov    %edx,0x8(%rax)
  8045db:	bf 09 00 00 00       	mov    $0x9,%edi
  8045e0:	48 b8 a2 41 80 00 00 	movabs $0x8041a2,%rax
  8045e7:	00 00 00 
  8045ea:	ff d0                	callq  *%rax
  8045ec:	c9                   	leaveq 
  8045ed:	c3                   	retq   

00000000008045ee <pipe>:
  8045ee:	55                   	push   %rbp
  8045ef:	48 89 e5             	mov    %rsp,%rbp
  8045f2:	53                   	push   %rbx
  8045f3:	48 83 ec 38          	sub    $0x38,%rsp
  8045f7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8045fb:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8045ff:	48 89 c7             	mov    %rax,%rdi
  804602:	48 b8 9b 22 80 00 00 	movabs $0x80229b,%rax
  804609:	00 00 00 
  80460c:	ff d0                	callq  *%rax
  80460e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804611:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804615:	0f 88 bf 01 00 00    	js     8047da <pipe+0x1ec>
  80461b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80461f:	ba 07 04 00 00       	mov    $0x407,%edx
  804624:	48 89 c6             	mov    %rax,%rsi
  804627:	bf 00 00 00 00       	mov    $0x0,%edi
  80462c:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  804633:	00 00 00 
  804636:	ff d0                	callq  *%rax
  804638:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80463b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80463f:	0f 88 95 01 00 00    	js     8047da <pipe+0x1ec>
  804645:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804649:	48 89 c7             	mov    %rax,%rdi
  80464c:	48 b8 9b 22 80 00 00 	movabs $0x80229b,%rax
  804653:	00 00 00 
  804656:	ff d0                	callq  *%rax
  804658:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80465b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80465f:	0f 88 5d 01 00 00    	js     8047c2 <pipe+0x1d4>
  804665:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804669:	ba 07 04 00 00       	mov    $0x407,%edx
  80466e:	48 89 c6             	mov    %rax,%rsi
  804671:	bf 00 00 00 00       	mov    $0x0,%edi
  804676:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  80467d:	00 00 00 
  804680:	ff d0                	callq  *%rax
  804682:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804685:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804689:	0f 88 33 01 00 00    	js     8047c2 <pipe+0x1d4>
  80468f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804693:	48 89 c7             	mov    %rax,%rdi
  804696:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  80469d:	00 00 00 
  8046a0:	ff d0                	callq  *%rax
  8046a2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8046a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046aa:	ba 07 04 00 00       	mov    $0x407,%edx
  8046af:	48 89 c6             	mov    %rax,%rsi
  8046b2:	bf 00 00 00 00       	mov    $0x0,%edi
  8046b7:	48 b8 6d 1e 80 00 00 	movabs $0x801e6d,%rax
  8046be:	00 00 00 
  8046c1:	ff d0                	callq  *%rax
  8046c3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8046c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8046ca:	79 05                	jns    8046d1 <pipe+0xe3>
  8046cc:	e9 d9 00 00 00       	jmpq   8047aa <pipe+0x1bc>
  8046d1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8046d5:	48 89 c7             	mov    %rax,%rdi
  8046d8:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  8046df:	00 00 00 
  8046e2:	ff d0                	callq  *%rax
  8046e4:	48 89 c2             	mov    %rax,%rdx
  8046e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046eb:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8046f1:	48 89 d1             	mov    %rdx,%rcx
  8046f4:	ba 00 00 00 00       	mov    $0x0,%edx
  8046f9:	48 89 c6             	mov    %rax,%rsi
  8046fc:	bf 00 00 00 00       	mov    $0x0,%edi
  804701:	48 b8 bd 1e 80 00 00 	movabs $0x801ebd,%rax
  804708:	00 00 00 
  80470b:	ff d0                	callq  *%rax
  80470d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804710:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804714:	79 1b                	jns    804731 <pipe+0x143>
  804716:	90                   	nop
  804717:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80471b:	48 89 c6             	mov    %rax,%rsi
  80471e:	bf 00 00 00 00       	mov    $0x0,%edi
  804723:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  80472a:	00 00 00 
  80472d:	ff d0                	callq  *%rax
  80472f:	eb 79                	jmp    8047aa <pipe+0x1bc>
  804731:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804735:	48 ba 80 88 80 00 00 	movabs $0x808880,%rdx
  80473c:	00 00 00 
  80473f:	8b 12                	mov    (%rdx),%edx
  804741:	89 10                	mov    %edx,(%rax)
  804743:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804747:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80474e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804752:	48 ba 80 88 80 00 00 	movabs $0x808880,%rdx
  804759:	00 00 00 
  80475c:	8b 12                	mov    (%rdx),%edx
  80475e:	89 10                	mov    %edx,(%rax)
  804760:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804764:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  80476b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80476f:	48 89 c7             	mov    %rax,%rdi
  804772:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  804779:	00 00 00 
  80477c:	ff d0                	callq  *%rax
  80477e:	89 c2                	mov    %eax,%edx
  804780:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804784:	89 10                	mov    %edx,(%rax)
  804786:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80478a:	48 8d 58 04          	lea    0x4(%rax),%rbx
  80478e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804792:	48 89 c7             	mov    %rax,%rdi
  804795:	48 b8 4d 22 80 00 00 	movabs $0x80224d,%rax
  80479c:	00 00 00 
  80479f:	ff d0                	callq  *%rax
  8047a1:	89 03                	mov    %eax,(%rbx)
  8047a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8047a8:	eb 33                	jmp    8047dd <pipe+0x1ef>
  8047aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8047ae:	48 89 c6             	mov    %rax,%rsi
  8047b1:	bf 00 00 00 00       	mov    $0x0,%edi
  8047b6:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  8047bd:	00 00 00 
  8047c0:	ff d0                	callq  *%rax
  8047c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047c6:	48 89 c6             	mov    %rax,%rsi
  8047c9:	bf 00 00 00 00       	mov    $0x0,%edi
  8047ce:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  8047d5:	00 00 00 
  8047d8:	ff d0                	callq  *%rax
  8047da:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8047dd:	48 83 c4 38          	add    $0x38,%rsp
  8047e1:	5b                   	pop    %rbx
  8047e2:	5d                   	pop    %rbp
  8047e3:	c3                   	retq   

00000000008047e4 <_pipeisclosed>:
  8047e4:	55                   	push   %rbp
  8047e5:	48 89 e5             	mov    %rsp,%rbp
  8047e8:	53                   	push   %rbx
  8047e9:	48 83 ec 28          	sub    $0x28,%rsp
  8047ed:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8047f1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8047f5:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  8047fc:	00 00 00 
  8047ff:	48 8b 00             	mov    (%rax),%rax
  804802:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804808:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80480b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80480f:	48 89 c7             	mov    %rax,%rdi
  804812:	48 b8 8a 4e 80 00 00 	movabs $0x804e8a,%rax
  804819:	00 00 00 
  80481c:	ff d0                	callq  *%rax
  80481e:	89 c3                	mov    %eax,%ebx
  804820:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804824:	48 89 c7             	mov    %rax,%rdi
  804827:	48 b8 8a 4e 80 00 00 	movabs $0x804e8a,%rax
  80482e:	00 00 00 
  804831:	ff d0                	callq  *%rax
  804833:	39 c3                	cmp    %eax,%ebx
  804835:	0f 94 c0             	sete   %al
  804838:	0f b6 c0             	movzbl %al,%eax
  80483b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80483e:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  804845:	00 00 00 
  804848:	48 8b 00             	mov    (%rax),%rax
  80484b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804851:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804854:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804857:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80485a:	75 05                	jne    804861 <_pipeisclosed+0x7d>
  80485c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80485f:	eb 4f                	jmp    8048b0 <_pipeisclosed+0xcc>
  804861:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804864:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804867:	74 42                	je     8048ab <_pipeisclosed+0xc7>
  804869:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  80486d:	75 3c                	jne    8048ab <_pipeisclosed+0xc7>
  80486f:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  804876:	00 00 00 
  804879:	48 8b 00             	mov    (%rax),%rax
  80487c:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  804882:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  804885:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804888:	89 c6                	mov    %eax,%esi
  80488a:	48 bf e6 57 80 00 00 	movabs $0x8057e6,%rdi
  804891:	00 00 00 
  804894:	b8 00 00 00 00       	mov    $0x0,%eax
  804899:	49 b8 89 09 80 00 00 	movabs $0x800989,%r8
  8048a0:	00 00 00 
  8048a3:	41 ff d0             	callq  *%r8
  8048a6:	e9 4a ff ff ff       	jmpq   8047f5 <_pipeisclosed+0x11>
  8048ab:	e9 45 ff ff ff       	jmpq   8047f5 <_pipeisclosed+0x11>
  8048b0:	48 83 c4 28          	add    $0x28,%rsp
  8048b4:	5b                   	pop    %rbx
  8048b5:	5d                   	pop    %rbp
  8048b6:	c3                   	retq   

00000000008048b7 <pipeisclosed>:
  8048b7:	55                   	push   %rbp
  8048b8:	48 89 e5             	mov    %rsp,%rbp
  8048bb:	48 83 ec 30          	sub    $0x30,%rsp
  8048bf:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8048c2:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8048c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8048c9:	48 89 d6             	mov    %rdx,%rsi
  8048cc:	89 c7                	mov    %eax,%edi
  8048ce:	48 b8 33 23 80 00 00 	movabs $0x802333,%rax
  8048d5:	00 00 00 
  8048d8:	ff d0                	callq  *%rax
  8048da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048e1:	79 05                	jns    8048e8 <pipeisclosed+0x31>
  8048e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048e6:	eb 31                	jmp    804919 <pipeisclosed+0x62>
  8048e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048ec:	48 89 c7             	mov    %rax,%rdi
  8048ef:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  8048f6:	00 00 00 
  8048f9:	ff d0                	callq  *%rax
  8048fb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8048ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804903:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804907:	48 89 d6             	mov    %rdx,%rsi
  80490a:	48 89 c7             	mov    %rax,%rdi
  80490d:	48 b8 e4 47 80 00 00 	movabs $0x8047e4,%rax
  804914:	00 00 00 
  804917:	ff d0                	callq  *%rax
  804919:	c9                   	leaveq 
  80491a:	c3                   	retq   

000000000080491b <devpipe_read>:
  80491b:	55                   	push   %rbp
  80491c:	48 89 e5             	mov    %rsp,%rbp
  80491f:	48 83 ec 40          	sub    $0x40,%rsp
  804923:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804927:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80492b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80492f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804933:	48 89 c7             	mov    %rax,%rdi
  804936:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  80493d:	00 00 00 
  804940:	ff d0                	callq  *%rax
  804942:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804946:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80494a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80494e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804955:	00 
  804956:	e9 92 00 00 00       	jmpq   8049ed <devpipe_read+0xd2>
  80495b:	eb 41                	jmp    80499e <devpipe_read+0x83>
  80495d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804962:	74 09                	je     80496d <devpipe_read+0x52>
  804964:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804968:	e9 92 00 00 00       	jmpq   8049ff <devpipe_read+0xe4>
  80496d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804971:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804975:	48 89 d6             	mov    %rdx,%rsi
  804978:	48 89 c7             	mov    %rax,%rdi
  80497b:	48 b8 e4 47 80 00 00 	movabs $0x8047e4,%rax
  804982:	00 00 00 
  804985:	ff d0                	callq  *%rax
  804987:	85 c0                	test   %eax,%eax
  804989:	74 07                	je     804992 <devpipe_read+0x77>
  80498b:	b8 00 00 00 00       	mov    $0x0,%eax
  804990:	eb 6d                	jmp    8049ff <devpipe_read+0xe4>
  804992:	48 b8 2f 1e 80 00 00 	movabs $0x801e2f,%rax
  804999:	00 00 00 
  80499c:	ff d0                	callq  *%rax
  80499e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8049a2:	8b 10                	mov    (%rax),%edx
  8049a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8049a8:	8b 40 04             	mov    0x4(%rax),%eax
  8049ab:	39 c2                	cmp    %eax,%edx
  8049ad:	74 ae                	je     80495d <devpipe_read+0x42>
  8049af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8049b7:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8049bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8049bf:	8b 00                	mov    (%rax),%eax
  8049c1:	99                   	cltd   
  8049c2:	c1 ea 1b             	shr    $0x1b,%edx
  8049c5:	01 d0                	add    %edx,%eax
  8049c7:	83 e0 1f             	and    $0x1f,%eax
  8049ca:	29 d0                	sub    %edx,%eax
  8049cc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8049d0:	48 98                	cltq   
  8049d2:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8049d7:	88 01                	mov    %al,(%rcx)
  8049d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8049dd:	8b 00                	mov    (%rax),%eax
  8049df:	8d 50 01             	lea    0x1(%rax),%edx
  8049e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8049e6:	89 10                	mov    %edx,(%rax)
  8049e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8049ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049f1:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8049f5:	0f 82 60 ff ff ff    	jb     80495b <devpipe_read+0x40>
  8049fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049ff:	c9                   	leaveq 
  804a00:	c3                   	retq   

0000000000804a01 <devpipe_write>:
  804a01:	55                   	push   %rbp
  804a02:	48 89 e5             	mov    %rsp,%rbp
  804a05:	48 83 ec 40          	sub    $0x40,%rsp
  804a09:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804a0d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804a11:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804a15:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804a19:	48 89 c7             	mov    %rax,%rdi
  804a1c:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  804a23:	00 00 00 
  804a26:	ff d0                	callq  *%rax
  804a28:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804a2c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804a30:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804a34:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804a3b:	00 
  804a3c:	e9 8e 00 00 00       	jmpq   804acf <devpipe_write+0xce>
  804a41:	eb 31                	jmp    804a74 <devpipe_write+0x73>
  804a43:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804a47:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804a4b:	48 89 d6             	mov    %rdx,%rsi
  804a4e:	48 89 c7             	mov    %rax,%rdi
  804a51:	48 b8 e4 47 80 00 00 	movabs $0x8047e4,%rax
  804a58:	00 00 00 
  804a5b:	ff d0                	callq  *%rax
  804a5d:	85 c0                	test   %eax,%eax
  804a5f:	74 07                	je     804a68 <devpipe_write+0x67>
  804a61:	b8 00 00 00 00       	mov    $0x0,%eax
  804a66:	eb 79                	jmp    804ae1 <devpipe_write+0xe0>
  804a68:	48 b8 2f 1e 80 00 00 	movabs $0x801e2f,%rax
  804a6f:	00 00 00 
  804a72:	ff d0                	callq  *%rax
  804a74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a78:	8b 40 04             	mov    0x4(%rax),%eax
  804a7b:	48 63 d0             	movslq %eax,%rdx
  804a7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a82:	8b 00                	mov    (%rax),%eax
  804a84:	48 98                	cltq   
  804a86:	48 83 c0 20          	add    $0x20,%rax
  804a8a:	48 39 c2             	cmp    %rax,%rdx
  804a8d:	73 b4                	jae    804a43 <devpipe_write+0x42>
  804a8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a93:	8b 40 04             	mov    0x4(%rax),%eax
  804a96:	99                   	cltd   
  804a97:	c1 ea 1b             	shr    $0x1b,%edx
  804a9a:	01 d0                	add    %edx,%eax
  804a9c:	83 e0 1f             	and    $0x1f,%eax
  804a9f:	29 d0                	sub    %edx,%eax
  804aa1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  804aa5:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804aa9:	48 01 ca             	add    %rcx,%rdx
  804aac:	0f b6 0a             	movzbl (%rdx),%ecx
  804aaf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804ab3:	48 98                	cltq   
  804ab5:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  804ab9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804abd:	8b 40 04             	mov    0x4(%rax),%eax
  804ac0:	8d 50 01             	lea    0x1(%rax),%edx
  804ac3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804ac7:	89 50 04             	mov    %edx,0x4(%rax)
  804aca:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804ad3:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804ad7:	0f 82 64 ff ff ff    	jb     804a41 <devpipe_write+0x40>
  804add:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804ae1:	c9                   	leaveq 
  804ae2:	c3                   	retq   

0000000000804ae3 <devpipe_stat>:
  804ae3:	55                   	push   %rbp
  804ae4:	48 89 e5             	mov    %rsp,%rbp
  804ae7:	48 83 ec 20          	sub    $0x20,%rsp
  804aeb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804aef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804af3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804af7:	48 89 c7             	mov    %rax,%rdi
  804afa:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  804b01:	00 00 00 
  804b04:	ff d0                	callq  *%rax
  804b06:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804b0a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804b0e:	48 be f9 57 80 00 00 	movabs $0x8057f9,%rsi
  804b15:	00 00 00 
  804b18:	48 89 c7             	mov    %rax,%rdi
  804b1b:	48 b8 3e 15 80 00 00 	movabs $0x80153e,%rax
  804b22:	00 00 00 
  804b25:	ff d0                	callq  *%rax
  804b27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b2b:	8b 50 04             	mov    0x4(%rax),%edx
  804b2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b32:	8b 00                	mov    (%rax),%eax
  804b34:	29 c2                	sub    %eax,%edx
  804b36:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804b3a:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804b40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804b44:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804b4b:	00 00 00 
  804b4e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804b52:	48 b9 80 88 80 00 00 	movabs $0x808880,%rcx
  804b59:	00 00 00 
  804b5c:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804b63:	b8 00 00 00 00       	mov    $0x0,%eax
  804b68:	c9                   	leaveq 
  804b69:	c3                   	retq   

0000000000804b6a <devpipe_close>:
  804b6a:	55                   	push   %rbp
  804b6b:	48 89 e5             	mov    %rsp,%rbp
  804b6e:	48 83 ec 10          	sub    $0x10,%rsp
  804b72:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804b76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b7a:	48 89 c6             	mov    %rax,%rsi
  804b7d:	bf 00 00 00 00       	mov    $0x0,%edi
  804b82:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  804b89:	00 00 00 
  804b8c:	ff d0                	callq  *%rax
  804b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b92:	48 89 c7             	mov    %rax,%rdi
  804b95:	48 b8 70 22 80 00 00 	movabs $0x802270,%rax
  804b9c:	00 00 00 
  804b9f:	ff d0                	callq  *%rax
  804ba1:	48 89 c6             	mov    %rax,%rsi
  804ba4:	bf 00 00 00 00       	mov    $0x0,%edi
  804ba9:	48 b8 18 1f 80 00 00 	movabs $0x801f18,%rax
  804bb0:	00 00 00 
  804bb3:	ff d0                	callq  *%rax
  804bb5:	c9                   	leaveq 
  804bb6:	c3                   	retq   

0000000000804bb7 <wait>:
  804bb7:	55                   	push   %rbp
  804bb8:	48 89 e5             	mov    %rsp,%rbp
  804bbb:	48 83 ec 20          	sub    $0x20,%rsp
  804bbf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804bc2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804bc6:	75 35                	jne    804bfd <wait+0x46>
  804bc8:	48 b9 00 58 80 00 00 	movabs $0x805800,%rcx
  804bcf:	00 00 00 
  804bd2:	48 ba 0b 58 80 00 00 	movabs $0x80580b,%rdx
  804bd9:	00 00 00 
  804bdc:	be 0a 00 00 00       	mov    $0xa,%esi
  804be1:	48 bf 20 58 80 00 00 	movabs $0x805820,%rdi
  804be8:	00 00 00 
  804beb:	b8 00 00 00 00       	mov    $0x0,%eax
  804bf0:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  804bf7:	00 00 00 
  804bfa:	41 ff d0             	callq  *%r8
  804bfd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804c00:	25 ff 03 00 00       	and    $0x3ff,%eax
  804c05:	48 98                	cltq   
  804c07:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  804c0e:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804c15:	00 00 00 
  804c18:	48 01 d0             	add    %rdx,%rax
  804c1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804c1f:	eb 0c                	jmp    804c2d <wait+0x76>
  804c21:	48 b8 2f 1e 80 00 00 	movabs $0x801e2f,%rax
  804c28:	00 00 00 
  804c2b:	ff d0                	callq  *%rax
  804c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804c31:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804c37:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804c3a:	75 0e                	jne    804c4a <wait+0x93>
  804c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804c40:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  804c46:	85 c0                	test   %eax,%eax
  804c48:	75 d7                	jne    804c21 <wait+0x6a>
  804c4a:	c9                   	leaveq 
  804c4b:	c3                   	retq   

0000000000804c4c <ipc_recv>:
  804c4c:	55                   	push   %rbp
  804c4d:	48 89 e5             	mov    %rsp,%rbp
  804c50:	48 83 ec 30          	sub    $0x30,%rsp
  804c54:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804c58:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804c5c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804c60:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804c65:	75 0e                	jne    804c75 <ipc_recv+0x29>
  804c67:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804c6e:	00 00 00 
  804c71:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804c75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804c79:	48 89 c7             	mov    %rax,%rdi
  804c7c:	48 b8 96 20 80 00 00 	movabs $0x802096,%rax
  804c83:	00 00 00 
  804c86:	ff d0                	callq  *%rax
  804c88:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804c8b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804c8f:	79 27                	jns    804cb8 <ipc_recv+0x6c>
  804c91:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804c96:	74 0a                	je     804ca2 <ipc_recv+0x56>
  804c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804c9c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804ca2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804ca7:	74 0a                	je     804cb3 <ipc_recv+0x67>
  804ca9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804cad:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  804cb3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804cb6:	eb 53                	jmp    804d0b <ipc_recv+0xbf>
  804cb8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804cbd:	74 19                	je     804cd8 <ipc_recv+0x8c>
  804cbf:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  804cc6:	00 00 00 
  804cc9:	48 8b 00             	mov    (%rax),%rax
  804ccc:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  804cd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804cd6:	89 10                	mov    %edx,(%rax)
  804cd8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804cdd:	74 19                	je     804cf8 <ipc_recv+0xac>
  804cdf:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  804ce6:	00 00 00 
  804ce9:	48 8b 00             	mov    (%rax),%rax
  804cec:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804cf2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804cf6:	89 10                	mov    %edx,(%rax)
  804cf8:	48 b8 90 a7 80 00 00 	movabs $0x80a790,%rax
  804cff:	00 00 00 
  804d02:	48 8b 00             	mov    (%rax),%rax
  804d05:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804d0b:	c9                   	leaveq 
  804d0c:	c3                   	retq   

0000000000804d0d <ipc_send>:
  804d0d:	55                   	push   %rbp
  804d0e:	48 89 e5             	mov    %rsp,%rbp
  804d11:	48 83 ec 30          	sub    $0x30,%rsp
  804d15:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804d18:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804d1b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804d1f:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804d22:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804d27:	75 10                	jne    804d39 <ipc_send+0x2c>
  804d29:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804d30:	00 00 00 
  804d33:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804d37:	eb 0e                	jmp    804d47 <ipc_send+0x3a>
  804d39:	eb 0c                	jmp    804d47 <ipc_send+0x3a>
  804d3b:	48 b8 2f 1e 80 00 00 	movabs $0x801e2f,%rax
  804d42:	00 00 00 
  804d45:	ff d0                	callq  *%rax
  804d47:	8b 75 e8             	mov    -0x18(%rbp),%esi
  804d4a:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  804d4d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804d51:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804d54:	89 c7                	mov    %eax,%edi
  804d56:	48 b8 41 20 80 00 00 	movabs $0x802041,%rax
  804d5d:	00 00 00 
  804d60:	ff d0                	callq  *%rax
  804d62:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804d65:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  804d69:	74 d0                	je     804d3b <ipc_send+0x2e>
  804d6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804d6f:	79 30                	jns    804da1 <ipc_send+0x94>
  804d71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804d74:	89 c1                	mov    %eax,%ecx
  804d76:	48 ba 30 58 80 00 00 	movabs $0x805830,%rdx
  804d7d:	00 00 00 
  804d80:	be 44 00 00 00       	mov    $0x44,%esi
  804d85:	48 bf 46 58 80 00 00 	movabs $0x805846,%rdi
  804d8c:	00 00 00 
  804d8f:	b8 00 00 00 00       	mov    $0x0,%eax
  804d94:	49 b8 50 07 80 00 00 	movabs $0x800750,%r8
  804d9b:	00 00 00 
  804d9e:	41 ff d0             	callq  *%r8
  804da1:	c9                   	leaveq 
  804da2:	c3                   	retq   

0000000000804da3 <ipc_host_recv>:
  804da3:	55                   	push   %rbp
  804da4:	48 89 e5             	mov    %rsp,%rbp
  804da7:	48 83 ec 10          	sub    $0x10,%rsp
  804dab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804daf:	48 ba 58 58 80 00 00 	movabs $0x805858,%rdx
  804db6:	00 00 00 
  804db9:	be 4e 00 00 00       	mov    $0x4e,%esi
  804dbe:	48 bf 46 58 80 00 00 	movabs $0x805846,%rdi
  804dc5:	00 00 00 
  804dc8:	b8 00 00 00 00       	mov    $0x0,%eax
  804dcd:	48 b9 50 07 80 00 00 	movabs $0x800750,%rcx
  804dd4:	00 00 00 
  804dd7:	ff d1                	callq  *%rcx

0000000000804dd9 <ipc_host_send>:
  804dd9:	55                   	push   %rbp
  804dda:	48 89 e5             	mov    %rsp,%rbp
  804ddd:	48 83 ec 20          	sub    $0x20,%rsp
  804de1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804de4:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804de7:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804deb:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804dee:	48 ba 78 58 80 00 00 	movabs $0x805878,%rdx
  804df5:	00 00 00 
  804df8:	be 67 00 00 00       	mov    $0x67,%esi
  804dfd:	48 bf 46 58 80 00 00 	movabs $0x805846,%rdi
  804e04:	00 00 00 
  804e07:	b8 00 00 00 00       	mov    $0x0,%eax
  804e0c:	48 b9 50 07 80 00 00 	movabs $0x800750,%rcx
  804e13:	00 00 00 
  804e16:	ff d1                	callq  *%rcx

0000000000804e18 <ipc_find_env>:
  804e18:	55                   	push   %rbp
  804e19:	48 89 e5             	mov    %rsp,%rbp
  804e1c:	48 83 ec 14          	sub    $0x14,%rsp
  804e20:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804e23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804e2a:	eb 4e                	jmp    804e7a <ipc_find_env+0x62>
  804e2c:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804e33:	00 00 00 
  804e36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804e39:	48 98                	cltq   
  804e3b:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804e42:	48 01 d0             	add    %rdx,%rax
  804e45:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804e4b:	8b 00                	mov    (%rax),%eax
  804e4d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804e50:	75 24                	jne    804e76 <ipc_find_env+0x5e>
  804e52:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804e59:	00 00 00 
  804e5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804e5f:	48 98                	cltq   
  804e61:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804e68:	48 01 d0             	add    %rdx,%rax
  804e6b:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804e71:	8b 40 08             	mov    0x8(%rax),%eax
  804e74:	eb 12                	jmp    804e88 <ipc_find_env+0x70>
  804e76:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804e7a:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804e81:	7e a9                	jle    804e2c <ipc_find_env+0x14>
  804e83:	b8 00 00 00 00       	mov    $0x0,%eax
  804e88:	c9                   	leaveq 
  804e89:	c3                   	retq   

0000000000804e8a <pageref>:
  804e8a:	55                   	push   %rbp
  804e8b:	48 89 e5             	mov    %rsp,%rbp
  804e8e:	48 83 ec 18          	sub    $0x18,%rsp
  804e92:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804e96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804e9a:	48 c1 e8 15          	shr    $0x15,%rax
  804e9e:	48 89 c2             	mov    %rax,%rdx
  804ea1:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804ea8:	01 00 00 
  804eab:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804eaf:	83 e0 01             	and    $0x1,%eax
  804eb2:	48 85 c0             	test   %rax,%rax
  804eb5:	75 07                	jne    804ebe <pageref+0x34>
  804eb7:	b8 00 00 00 00       	mov    $0x0,%eax
  804ebc:	eb 53                	jmp    804f11 <pageref+0x87>
  804ebe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804ec2:	48 c1 e8 0c          	shr    $0xc,%rax
  804ec6:	48 89 c2             	mov    %rax,%rdx
  804ec9:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804ed0:	01 00 00 
  804ed3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804ed7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804edb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804edf:	83 e0 01             	and    $0x1,%eax
  804ee2:	48 85 c0             	test   %rax,%rax
  804ee5:	75 07                	jne    804eee <pageref+0x64>
  804ee7:	b8 00 00 00 00       	mov    $0x0,%eax
  804eec:	eb 23                	jmp    804f11 <pageref+0x87>
  804eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804ef2:	48 c1 e8 0c          	shr    $0xc,%rax
  804ef6:	48 89 c2             	mov    %rax,%rdx
  804ef9:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804f00:	00 00 00 
  804f03:	48 c1 e2 04          	shl    $0x4,%rdx
  804f07:	48 01 d0             	add    %rdx,%rax
  804f0a:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804f0e:	0f b7 c0             	movzwl %ax,%eax
  804f11:	c9                   	leaveq 
  804f12:	c3                   	retq   
