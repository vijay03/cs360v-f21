
vmm/guest/obj/user/echotest:     file format elf64-x86-64


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
  80003c:	e8 d9 02 00 00       	callq  80031a <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <die>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 10          	sub    $0x10,%rsp
  80004b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80004f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800053:	48 89 c6             	mov    %rax,%rsi
  800056:	48 bf 0e 47 80 00 00 	movabs $0x80470e,%rdi
  80005d:	00 00 00 
  800060:	b8 00 00 00 00       	mov    $0x0,%eax
  800065:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  80006c:	00 00 00 
  80006f:	ff d2                	callq  *%rdx
  800071:	48 b8 9d 03 80 00 00 	movabs $0x80039d,%rax
  800078:	00 00 00 
  80007b:	ff d0                	callq  *%rax
  80007d:	c9                   	leaveq 
  80007e:	c3                   	retq   

000000000080007f <umain>:
  80007f:	55                   	push   %rbp
  800080:	48 89 e5             	mov    %rsp,%rbp
  800083:	48 83 ec 50          	sub    $0x50,%rsp
  800087:	89 7d bc             	mov    %edi,-0x44(%rbp)
  80008a:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
  80008e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800095:	48 bf 12 47 80 00 00 	movabs $0x804712,%rdi
  80009c:	00 00 00 
  80009f:	b8 00 00 00 00       	mov    $0x0,%eax
  8000a4:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  8000ab:	00 00 00 
  8000ae:	ff d2                	callq  *%rdx
  8000b0:	48 bf 22 47 80 00 00 	movabs $0x804722,%rdi
  8000b7:	00 00 00 
  8000ba:	48 b8 37 42 80 00 00 	movabs $0x804237,%rax
  8000c1:	00 00 00 
  8000c4:	ff d0                	callq  *%rax
  8000c6:	89 c2                	mov    %eax,%edx
  8000c8:	48 be 22 47 80 00 00 	movabs $0x804722,%rsi
  8000cf:	00 00 00 
  8000d2:	48 bf 2c 47 80 00 00 	movabs $0x80472c,%rdi
  8000d9:	00 00 00 
  8000dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e1:	48 b9 e5 04 80 00 00 	movabs $0x8004e5,%rcx
  8000e8:	00 00 00 
  8000eb:	ff d1                	callq  *%rcx
  8000ed:	ba 06 00 00 00       	mov    $0x6,%edx
  8000f2:	be 01 00 00 00       	mov    $0x1,%esi
  8000f7:	bf 02 00 00 00       	mov    $0x2,%edi
  8000fc:	48 b8 49 31 80 00 00 	movabs $0x803149,%rax
  800103:	00 00 00 
  800106:	ff d0                	callq  *%rax
  800108:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80010b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80010f:	79 16                	jns    800127 <umain+0xa8>
  800111:	48 bf 41 47 80 00 00 	movabs $0x804741,%rdi
  800118:	00 00 00 
  80011b:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800122:	00 00 00 
  800125:	ff d0                	callq  *%rax
  800127:	48 bf 59 47 80 00 00 	movabs $0x804759,%rdi
  80012e:	00 00 00 
  800131:	b8 00 00 00 00       	mov    $0x0,%eax
  800136:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  80013d:	00 00 00 
  800140:	ff d2                	callq  *%rdx
  800142:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  800146:	ba 10 00 00 00       	mov    $0x10,%edx
  80014b:	be 00 00 00 00       	mov    $0x0,%esi
  800150:	48 89 c7             	mov    %rax,%rdi
  800153:	48 b8 33 13 80 00 00 	movabs $0x801333,%rax
  80015a:	00 00 00 
  80015d:	ff d0                	callq  *%rax
  80015f:	c6 45 e1 02          	movb   $0x2,-0x1f(%rbp)
  800163:	48 bf 22 47 80 00 00 	movabs $0x804722,%rdi
  80016a:	00 00 00 
  80016d:	48 b8 37 42 80 00 00 	movabs $0x804237,%rax
  800174:	00 00 00 
  800177:	ff d0                	callq  *%rax
  800179:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80017c:	bf 10 27 00 00       	mov    $0x2710,%edi
  800181:	48 b8 46 46 80 00 00 	movabs $0x804646,%rax
  800188:	00 00 00 
  80018b:	ff d0                	callq  *%rax
  80018d:	66 89 45 e2          	mov    %ax,-0x1e(%rbp)
  800191:	48 bf 68 47 80 00 00 	movabs $0x804768,%rdi
  800198:	00 00 00 
  80019b:	b8 00 00 00 00       	mov    $0x0,%eax
  8001a0:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  8001a7:	00 00 00 
  8001aa:	ff d2                	callq  *%rdx
  8001ac:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
  8001b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001b3:	ba 10 00 00 00       	mov    $0x10,%edx
  8001b8:	48 89 ce             	mov    %rcx,%rsi
  8001bb:	89 c7                	mov    %eax,%edi
  8001bd:	48 b8 0e 30 80 00 00 	movabs $0x80300e,%rax
  8001c4:	00 00 00 
  8001c7:	ff d0                	callq  *%rax
  8001c9:	85 c0                	test   %eax,%eax
  8001cb:	79 16                	jns    8001e3 <umain+0x164>
  8001cd:	48 bf 85 47 80 00 00 	movabs $0x804785,%rdi
  8001d4:	00 00 00 
  8001d7:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8001de:	00 00 00 
  8001e1:	ff d0                	callq  *%rax
  8001e3:	48 bf a3 47 80 00 00 	movabs $0x8047a3,%rdi
  8001ea:	00 00 00 
  8001ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8001f2:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  8001f9:	00 00 00 
  8001fc:	ff d2                	callq  *%rdx
  8001fe:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  800205:	00 00 00 
  800208:	48 8b 00             	mov    (%rax),%rax
  80020b:	48 89 c7             	mov    %rax,%rdi
  80020e:	48 b8 2e 10 80 00 00 	movabs $0x80102e,%rax
  800215:	00 00 00 
  800218:	ff d0                	callq  *%rax
  80021a:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80021d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  800220:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  800227:	00 00 00 
  80022a:	48 8b 08             	mov    (%rax),%rcx
  80022d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800230:	48 89 ce             	mov    %rcx,%rsi
  800233:	89 c7                	mov    %eax,%edi
  800235:	48 b8 0b 24 80 00 00 	movabs $0x80240b,%rax
  80023c:	00 00 00 
  80023f:	ff d0                	callq  *%rax
  800241:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  800244:	74 16                	je     80025c <umain+0x1dd>
  800246:	48 bf b8 47 80 00 00 	movabs $0x8047b8,%rdi
  80024d:	00 00 00 
  800250:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800257:	00 00 00 
  80025a:	ff d0                	callq  *%rax
  80025c:	48 bf d9 47 80 00 00 	movabs $0x8047d9,%rdi
  800263:	00 00 00 
  800266:	b8 00 00 00 00       	mov    $0x0,%eax
  80026b:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  800272:	00 00 00 
  800275:	ff d2                	callq  *%rdx
  800277:	eb 6b                	jmp    8002e4 <umain+0x265>
  800279:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  800280:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
  800284:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800287:	ba 1f 00 00 00       	mov    $0x1f,%edx
  80028c:	48 89 ce             	mov    %rcx,%rsi
  80028f:	89 c7                	mov    %eax,%edi
  800291:	48 b8 c1 22 80 00 00 	movabs $0x8022c1,%rax
  800298:	00 00 00 
  80029b:	ff d0                	callq  *%rax
  80029d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8002a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8002a4:	7f 16                	jg     8002bc <umain+0x23d>
  8002a6:	48 bf e8 47 80 00 00 	movabs $0x8047e8,%rdi
  8002ad:	00 00 00 
  8002b0:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8002b7:	00 00 00 
  8002ba:	ff d0                	callq  *%rax
  8002bc:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002bf:	01 45 fc             	add    %eax,-0x4(%rbp)
  8002c2:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8002c5:	48 98                	cltq   
  8002c7:	c6 44 05 c0 00       	movb   $0x0,-0x40(%rbp,%rax,1)
  8002cc:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  8002d0:	48 89 c7             	mov    %rax,%rdi
  8002d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8002d8:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  8002df:	00 00 00 
  8002e2:	ff d2                	callq  *%rdx
  8002e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002e7:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8002ea:	72 8d                	jb     800279 <umain+0x1fa>
  8002ec:	48 bf 0c 48 80 00 00 	movabs $0x80480c,%rdi
  8002f3:	00 00 00 
  8002f6:	b8 00 00 00 00       	mov    $0x0,%eax
  8002fb:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  800302:	00 00 00 
  800305:	ff d2                	callq  *%rdx
  800307:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80030a:	89 c7                	mov    %eax,%edi
  80030c:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  800313:	00 00 00 
  800316:	ff d0                	callq  *%rax
  800318:	c9                   	leaveq 
  800319:	c3                   	retq   

000000000080031a <libmain>:
  80031a:	55                   	push   %rbp
  80031b:	48 89 e5             	mov    %rsp,%rbp
  80031e:	48 83 ec 10          	sub    $0x10,%rsp
  800322:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800325:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800329:	48 b8 4d 19 80 00 00 	movabs $0x80194d,%rax
  800330:	00 00 00 
  800333:	ff d0                	callq  *%rax
  800335:	25 ff 03 00 00       	and    $0x3ff,%eax
  80033a:	48 98                	cltq   
  80033c:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800343:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80034a:	00 00 00 
  80034d:	48 01 c2             	add    %rax,%rdx
  800350:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  800357:	00 00 00 
  80035a:	48 89 10             	mov    %rdx,(%rax)
  80035d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800361:	7e 14                	jle    800377 <libmain+0x5d>
  800363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800367:	48 8b 10             	mov    (%rax),%rdx
  80036a:	48 b8 08 60 80 00 00 	movabs $0x806008,%rax
  800371:	00 00 00 
  800374:	48 89 10             	mov    %rdx,(%rax)
  800377:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80037b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80037e:	48 89 d6             	mov    %rdx,%rsi
  800381:	89 c7                	mov    %eax,%edi
  800383:	48 b8 7f 00 80 00 00 	movabs $0x80007f,%rax
  80038a:	00 00 00 
  80038d:	ff d0                	callq  *%rax
  80038f:	48 b8 9d 03 80 00 00 	movabs $0x80039d,%rax
  800396:	00 00 00 
  800399:	ff d0                	callq  *%rax
  80039b:	c9                   	leaveq 
  80039c:	c3                   	retq   

000000000080039d <exit>:
  80039d:	55                   	push   %rbp
  80039e:	48 89 e5             	mov    %rsp,%rbp
  8003a1:	48 b8 ea 20 80 00 00 	movabs $0x8020ea,%rax
  8003a8:	00 00 00 
  8003ab:	ff d0                	callq  *%rax
  8003ad:	bf 00 00 00 00       	mov    $0x0,%edi
  8003b2:	48 b8 09 19 80 00 00 	movabs $0x801909,%rax
  8003b9:	00 00 00 
  8003bc:	ff d0                	callq  *%rax
  8003be:	5d                   	pop    %rbp
  8003bf:	c3                   	retq   

00000000008003c0 <putch>:
  8003c0:	55                   	push   %rbp
  8003c1:	48 89 e5             	mov    %rsp,%rbp
  8003c4:	48 83 ec 10          	sub    $0x10,%rsp
  8003c8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8003cb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8003cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003d3:	8b 00                	mov    (%rax),%eax
  8003d5:	8d 48 01             	lea    0x1(%rax),%ecx
  8003d8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003dc:	89 0a                	mov    %ecx,(%rdx)
  8003de:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8003e1:	89 d1                	mov    %edx,%ecx
  8003e3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003e7:	48 98                	cltq   
  8003e9:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8003ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003f1:	8b 00                	mov    (%rax),%eax
  8003f3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003f8:	75 2c                	jne    800426 <putch+0x66>
  8003fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003fe:	8b 00                	mov    (%rax),%eax
  800400:	48 98                	cltq   
  800402:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800406:	48 83 c2 08          	add    $0x8,%rdx
  80040a:	48 89 c6             	mov    %rax,%rsi
  80040d:	48 89 d7             	mov    %rdx,%rdi
  800410:	48 b8 81 18 80 00 00 	movabs $0x801881,%rax
  800417:	00 00 00 
  80041a:	ff d0                	callq  *%rax
  80041c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800420:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800426:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80042a:	8b 40 04             	mov    0x4(%rax),%eax
  80042d:	8d 50 01             	lea    0x1(%rax),%edx
  800430:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800434:	89 50 04             	mov    %edx,0x4(%rax)
  800437:	c9                   	leaveq 
  800438:	c3                   	retq   

0000000000800439 <vcprintf>:
  800439:	55                   	push   %rbp
  80043a:	48 89 e5             	mov    %rsp,%rbp
  80043d:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800444:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  80044b:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800452:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800459:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800460:	48 8b 0a             	mov    (%rdx),%rcx
  800463:	48 89 08             	mov    %rcx,(%rax)
  800466:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80046a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80046e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800472:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800476:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  80047d:	00 00 00 
  800480:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800487:	00 00 00 
  80048a:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800491:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800498:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  80049f:	48 89 c6             	mov    %rax,%rsi
  8004a2:	48 bf c0 03 80 00 00 	movabs $0x8003c0,%rdi
  8004a9:	00 00 00 
  8004ac:	48 b8 98 08 80 00 00 	movabs $0x800898,%rax
  8004b3:	00 00 00 
  8004b6:	ff d0                	callq  *%rax
  8004b8:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8004be:	48 98                	cltq   
  8004c0:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8004c7:	48 83 c2 08          	add    $0x8,%rdx
  8004cb:	48 89 c6             	mov    %rax,%rsi
  8004ce:	48 89 d7             	mov    %rdx,%rdi
  8004d1:	48 b8 81 18 80 00 00 	movabs $0x801881,%rax
  8004d8:	00 00 00 
  8004db:	ff d0                	callq  *%rax
  8004dd:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8004e3:	c9                   	leaveq 
  8004e4:	c3                   	retq   

00000000008004e5 <cprintf>:
  8004e5:	55                   	push   %rbp
  8004e6:	48 89 e5             	mov    %rsp,%rbp
  8004e9:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8004f0:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8004f7:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8004fe:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800505:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80050c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800513:	84 c0                	test   %al,%al
  800515:	74 20                	je     800537 <cprintf+0x52>
  800517:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80051b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80051f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800523:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800527:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80052b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80052f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800533:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800537:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80053e:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800545:	00 00 00 
  800548:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80054f:	00 00 00 
  800552:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800556:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80055d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800564:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80056b:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800572:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800579:	48 8b 0a             	mov    (%rdx),%rcx
  80057c:	48 89 08             	mov    %rcx,(%rax)
  80057f:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800583:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800587:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80058b:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80058f:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800596:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80059d:	48 89 d6             	mov    %rdx,%rsi
  8005a0:	48 89 c7             	mov    %rax,%rdi
  8005a3:	48 b8 39 04 80 00 00 	movabs $0x800439,%rax
  8005aa:	00 00 00 
  8005ad:	ff d0                	callq  *%rax
  8005af:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8005b5:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8005bb:	c9                   	leaveq 
  8005bc:	c3                   	retq   

00000000008005bd <printnum>:
  8005bd:	55                   	push   %rbp
  8005be:	48 89 e5             	mov    %rsp,%rbp
  8005c1:	53                   	push   %rbx
  8005c2:	48 83 ec 38          	sub    $0x38,%rsp
  8005c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8005ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8005ce:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8005d2:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8005d5:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8005d9:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8005dd:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8005e0:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8005e4:	77 3b                	ja     800621 <printnum+0x64>
  8005e6:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8005e9:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8005ed:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8005f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005f4:	ba 00 00 00 00       	mov    $0x0,%edx
  8005f9:	48 f7 f3             	div    %rbx
  8005fc:	48 89 c2             	mov    %rax,%rdx
  8005ff:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800602:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800605:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80060d:	41 89 f9             	mov    %edi,%r9d
  800610:	48 89 c7             	mov    %rax,%rdi
  800613:	48 b8 bd 05 80 00 00 	movabs $0x8005bd,%rax
  80061a:	00 00 00 
  80061d:	ff d0                	callq  *%rax
  80061f:	eb 1e                	jmp    80063f <printnum+0x82>
  800621:	eb 12                	jmp    800635 <printnum+0x78>
  800623:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800627:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80062a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80062e:	48 89 ce             	mov    %rcx,%rsi
  800631:	89 d7                	mov    %edx,%edi
  800633:	ff d0                	callq  *%rax
  800635:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800639:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  80063d:	7f e4                	jg     800623 <printnum+0x66>
  80063f:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800642:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800646:	ba 00 00 00 00       	mov    $0x0,%edx
  80064b:	48 f7 f1             	div    %rcx
  80064e:	48 89 d0             	mov    %rdx,%rax
  800651:	48 ba 10 4a 80 00 00 	movabs $0x804a10,%rdx
  800658:	00 00 00 
  80065b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  80065f:	0f be d0             	movsbl %al,%edx
  800662:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80066a:	48 89 ce             	mov    %rcx,%rsi
  80066d:	89 d7                	mov    %edx,%edi
  80066f:	ff d0                	callq  *%rax
  800671:	48 83 c4 38          	add    $0x38,%rsp
  800675:	5b                   	pop    %rbx
  800676:	5d                   	pop    %rbp
  800677:	c3                   	retq   

0000000000800678 <getuint>:
  800678:	55                   	push   %rbp
  800679:	48 89 e5             	mov    %rsp,%rbp
  80067c:	48 83 ec 1c          	sub    $0x1c,%rsp
  800680:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800684:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800687:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80068b:	7e 52                	jle    8006df <getuint+0x67>
  80068d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800691:	8b 00                	mov    (%rax),%eax
  800693:	83 f8 30             	cmp    $0x30,%eax
  800696:	73 24                	jae    8006bc <getuint+0x44>
  800698:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80069c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006a4:	8b 00                	mov    (%rax),%eax
  8006a6:	89 c0                	mov    %eax,%eax
  8006a8:	48 01 d0             	add    %rdx,%rax
  8006ab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006af:	8b 12                	mov    (%rdx),%edx
  8006b1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006b4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006b8:	89 0a                	mov    %ecx,(%rdx)
  8006ba:	eb 17                	jmp    8006d3 <getuint+0x5b>
  8006bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006c0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006c4:	48 89 d0             	mov    %rdx,%rax
  8006c7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006cb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006cf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006d3:	48 8b 00             	mov    (%rax),%rax
  8006d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006da:	e9 a3 00 00 00       	jmpq   800782 <getuint+0x10a>
  8006df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8006e3:	74 4f                	je     800734 <getuint+0xbc>
  8006e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006e9:	8b 00                	mov    (%rax),%eax
  8006eb:	83 f8 30             	cmp    $0x30,%eax
  8006ee:	73 24                	jae    800714 <getuint+0x9c>
  8006f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006fc:	8b 00                	mov    (%rax),%eax
  8006fe:	89 c0                	mov    %eax,%eax
  800700:	48 01 d0             	add    %rdx,%rax
  800703:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800707:	8b 12                	mov    (%rdx),%edx
  800709:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80070c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800710:	89 0a                	mov    %ecx,(%rdx)
  800712:	eb 17                	jmp    80072b <getuint+0xb3>
  800714:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800718:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80071c:	48 89 d0             	mov    %rdx,%rax
  80071f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800723:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800727:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80072b:	48 8b 00             	mov    (%rax),%rax
  80072e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800732:	eb 4e                	jmp    800782 <getuint+0x10a>
  800734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800738:	8b 00                	mov    (%rax),%eax
  80073a:	83 f8 30             	cmp    $0x30,%eax
  80073d:	73 24                	jae    800763 <getuint+0xeb>
  80073f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800743:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80074b:	8b 00                	mov    (%rax),%eax
  80074d:	89 c0                	mov    %eax,%eax
  80074f:	48 01 d0             	add    %rdx,%rax
  800752:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800756:	8b 12                	mov    (%rdx),%edx
  800758:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80075b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80075f:	89 0a                	mov    %ecx,(%rdx)
  800761:	eb 17                	jmp    80077a <getuint+0x102>
  800763:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800767:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80076b:	48 89 d0             	mov    %rdx,%rax
  80076e:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800772:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800776:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80077a:	8b 00                	mov    (%rax),%eax
  80077c:	89 c0                	mov    %eax,%eax
  80077e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800782:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800786:	c9                   	leaveq 
  800787:	c3                   	retq   

0000000000800788 <getint>:
  800788:	55                   	push   %rbp
  800789:	48 89 e5             	mov    %rsp,%rbp
  80078c:	48 83 ec 1c          	sub    $0x1c,%rsp
  800790:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800794:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800797:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80079b:	7e 52                	jle    8007ef <getint+0x67>
  80079d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007a1:	8b 00                	mov    (%rax),%eax
  8007a3:	83 f8 30             	cmp    $0x30,%eax
  8007a6:	73 24                	jae    8007cc <getint+0x44>
  8007a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8007b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007b4:	8b 00                	mov    (%rax),%eax
  8007b6:	89 c0                	mov    %eax,%eax
  8007b8:	48 01 d0             	add    %rdx,%rax
  8007bb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007bf:	8b 12                	mov    (%rdx),%edx
  8007c1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8007c4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007c8:	89 0a                	mov    %ecx,(%rdx)
  8007ca:	eb 17                	jmp    8007e3 <getint+0x5b>
  8007cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007d0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8007d4:	48 89 d0             	mov    %rdx,%rax
  8007d7:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8007db:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8007e3:	48 8b 00             	mov    (%rax),%rax
  8007e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8007ea:	e9 a3 00 00 00       	jmpq   800892 <getint+0x10a>
  8007ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8007f3:	74 4f                	je     800844 <getint+0xbc>
  8007f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007f9:	8b 00                	mov    (%rax),%eax
  8007fb:	83 f8 30             	cmp    $0x30,%eax
  8007fe:	73 24                	jae    800824 <getint+0x9c>
  800800:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800804:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800808:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80080c:	8b 00                	mov    (%rax),%eax
  80080e:	89 c0                	mov    %eax,%eax
  800810:	48 01 d0             	add    %rdx,%rax
  800813:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800817:	8b 12                	mov    (%rdx),%edx
  800819:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80081c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800820:	89 0a                	mov    %ecx,(%rdx)
  800822:	eb 17                	jmp    80083b <getint+0xb3>
  800824:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800828:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80082c:	48 89 d0             	mov    %rdx,%rax
  80082f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800833:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800837:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80083b:	48 8b 00             	mov    (%rax),%rax
  80083e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800842:	eb 4e                	jmp    800892 <getint+0x10a>
  800844:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800848:	8b 00                	mov    (%rax),%eax
  80084a:	83 f8 30             	cmp    $0x30,%eax
  80084d:	73 24                	jae    800873 <getint+0xeb>
  80084f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800853:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800857:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80085b:	8b 00                	mov    (%rax),%eax
  80085d:	89 c0                	mov    %eax,%eax
  80085f:	48 01 d0             	add    %rdx,%rax
  800862:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800866:	8b 12                	mov    (%rdx),%edx
  800868:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80086b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80086f:	89 0a                	mov    %ecx,(%rdx)
  800871:	eb 17                	jmp    80088a <getint+0x102>
  800873:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800877:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80087b:	48 89 d0             	mov    %rdx,%rax
  80087e:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800882:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800886:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80088a:	8b 00                	mov    (%rax),%eax
  80088c:	48 98                	cltq   
  80088e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800896:	c9                   	leaveq 
  800897:	c3                   	retq   

0000000000800898 <vprintfmt>:
  800898:	55                   	push   %rbp
  800899:	48 89 e5             	mov    %rsp,%rbp
  80089c:	41 54                	push   %r12
  80089e:	53                   	push   %rbx
  80089f:	48 83 ec 60          	sub    $0x60,%rsp
  8008a3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  8008a7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8008ab:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8008af:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8008b3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8008b7:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  8008bb:	48 8b 0a             	mov    (%rdx),%rcx
  8008be:	48 89 08             	mov    %rcx,(%rax)
  8008c1:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8008c5:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8008c9:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8008cd:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8008d1:	eb 17                	jmp    8008ea <vprintfmt+0x52>
  8008d3:	85 db                	test   %ebx,%ebx
  8008d5:	0f 84 cc 04 00 00    	je     800da7 <vprintfmt+0x50f>
  8008db:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8008df:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8008e3:	48 89 d6             	mov    %rdx,%rsi
  8008e6:	89 df                	mov    %ebx,%edi
  8008e8:	ff d0                	callq  *%rax
  8008ea:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8008ee:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8008f2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8008f6:	0f b6 00             	movzbl (%rax),%eax
  8008f9:	0f b6 d8             	movzbl %al,%ebx
  8008fc:	83 fb 25             	cmp    $0x25,%ebx
  8008ff:	75 d2                	jne    8008d3 <vprintfmt+0x3b>
  800901:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800905:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  80090c:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800913:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80091a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800921:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800925:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800929:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80092d:	0f b6 00             	movzbl (%rax),%eax
  800930:	0f b6 d8             	movzbl %al,%ebx
  800933:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800936:	83 f8 55             	cmp    $0x55,%eax
  800939:	0f 87 34 04 00 00    	ja     800d73 <vprintfmt+0x4db>
  80093f:	89 c0                	mov    %eax,%eax
  800941:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800948:	00 
  800949:	48 b8 38 4a 80 00 00 	movabs $0x804a38,%rax
  800950:	00 00 00 
  800953:	48 01 d0             	add    %rdx,%rax
  800956:	48 8b 00             	mov    (%rax),%rax
  800959:	ff e0                	jmpq   *%rax
  80095b:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  80095f:	eb c0                	jmp    800921 <vprintfmt+0x89>
  800961:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800965:	eb ba                	jmp    800921 <vprintfmt+0x89>
  800967:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  80096e:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800971:	89 d0                	mov    %edx,%eax
  800973:	c1 e0 02             	shl    $0x2,%eax
  800976:	01 d0                	add    %edx,%eax
  800978:	01 c0                	add    %eax,%eax
  80097a:	01 d8                	add    %ebx,%eax
  80097c:	83 e8 30             	sub    $0x30,%eax
  80097f:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800982:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800986:	0f b6 00             	movzbl (%rax),%eax
  800989:	0f be d8             	movsbl %al,%ebx
  80098c:	83 fb 2f             	cmp    $0x2f,%ebx
  80098f:	7e 0c                	jle    80099d <vprintfmt+0x105>
  800991:	83 fb 39             	cmp    $0x39,%ebx
  800994:	7f 07                	jg     80099d <vprintfmt+0x105>
  800996:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  80099b:	eb d1                	jmp    80096e <vprintfmt+0xd6>
  80099d:	eb 58                	jmp    8009f7 <vprintfmt+0x15f>
  80099f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009a2:	83 f8 30             	cmp    $0x30,%eax
  8009a5:	73 17                	jae    8009be <vprintfmt+0x126>
  8009a7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8009ab:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009ae:	89 c0                	mov    %eax,%eax
  8009b0:	48 01 d0             	add    %rdx,%rax
  8009b3:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8009b6:	83 c2 08             	add    $0x8,%edx
  8009b9:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8009bc:	eb 0f                	jmp    8009cd <vprintfmt+0x135>
  8009be:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8009c2:	48 89 d0             	mov    %rdx,%rax
  8009c5:	48 83 c2 08          	add    $0x8,%rdx
  8009c9:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8009cd:	8b 00                	mov    (%rax),%eax
  8009cf:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8009d2:	eb 23                	jmp    8009f7 <vprintfmt+0x15f>
  8009d4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009d8:	79 0c                	jns    8009e6 <vprintfmt+0x14e>
  8009da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  8009e1:	e9 3b ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  8009e6:	e9 36 ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  8009eb:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  8009f2:	e9 2a ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  8009f7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8009fb:	79 12                	jns    800a0f <vprintfmt+0x177>
  8009fd:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800a00:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800a03:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a0a:	e9 12 ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  800a0f:	e9 0d ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  800a14:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800a18:	e9 04 ff ff ff       	jmpq   800921 <vprintfmt+0x89>
  800a1d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a20:	83 f8 30             	cmp    $0x30,%eax
  800a23:	73 17                	jae    800a3c <vprintfmt+0x1a4>
  800a25:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a29:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a2c:	89 c0                	mov    %eax,%eax
  800a2e:	48 01 d0             	add    %rdx,%rax
  800a31:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a34:	83 c2 08             	add    $0x8,%edx
  800a37:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a3a:	eb 0f                	jmp    800a4b <vprintfmt+0x1b3>
  800a3c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a40:	48 89 d0             	mov    %rdx,%rax
  800a43:	48 83 c2 08          	add    $0x8,%rdx
  800a47:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a4b:	8b 10                	mov    (%rax),%edx
  800a4d:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800a51:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a55:	48 89 ce             	mov    %rcx,%rsi
  800a58:	89 d7                	mov    %edx,%edi
  800a5a:	ff d0                	callq  *%rax
  800a5c:	e9 40 03 00 00       	jmpq   800da1 <vprintfmt+0x509>
  800a61:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a64:	83 f8 30             	cmp    $0x30,%eax
  800a67:	73 17                	jae    800a80 <vprintfmt+0x1e8>
  800a69:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a6d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a70:	89 c0                	mov    %eax,%eax
  800a72:	48 01 d0             	add    %rdx,%rax
  800a75:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a78:	83 c2 08             	add    $0x8,%edx
  800a7b:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a7e:	eb 0f                	jmp    800a8f <vprintfmt+0x1f7>
  800a80:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a84:	48 89 d0             	mov    %rdx,%rax
  800a87:	48 83 c2 08          	add    $0x8,%rdx
  800a8b:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a8f:	8b 18                	mov    (%rax),%ebx
  800a91:	85 db                	test   %ebx,%ebx
  800a93:	79 02                	jns    800a97 <vprintfmt+0x1ff>
  800a95:	f7 db                	neg    %ebx
  800a97:	83 fb 15             	cmp    $0x15,%ebx
  800a9a:	7f 16                	jg     800ab2 <vprintfmt+0x21a>
  800a9c:	48 b8 60 49 80 00 00 	movabs $0x804960,%rax
  800aa3:	00 00 00 
  800aa6:	48 63 d3             	movslq %ebx,%rdx
  800aa9:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800aad:	4d 85 e4             	test   %r12,%r12
  800ab0:	75 2e                	jne    800ae0 <vprintfmt+0x248>
  800ab2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800ab6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800aba:	89 d9                	mov    %ebx,%ecx
  800abc:	48 ba 21 4a 80 00 00 	movabs $0x804a21,%rdx
  800ac3:	00 00 00 
  800ac6:	48 89 c7             	mov    %rax,%rdi
  800ac9:	b8 00 00 00 00       	mov    $0x0,%eax
  800ace:	49 b8 b0 0d 80 00 00 	movabs $0x800db0,%r8
  800ad5:	00 00 00 
  800ad8:	41 ff d0             	callq  *%r8
  800adb:	e9 c1 02 00 00       	jmpq   800da1 <vprintfmt+0x509>
  800ae0:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800ae4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ae8:	4c 89 e1             	mov    %r12,%rcx
  800aeb:	48 ba 2a 4a 80 00 00 	movabs $0x804a2a,%rdx
  800af2:	00 00 00 
  800af5:	48 89 c7             	mov    %rax,%rdi
  800af8:	b8 00 00 00 00       	mov    $0x0,%eax
  800afd:	49 b8 b0 0d 80 00 00 	movabs $0x800db0,%r8
  800b04:	00 00 00 
  800b07:	41 ff d0             	callq  *%r8
  800b0a:	e9 92 02 00 00       	jmpq   800da1 <vprintfmt+0x509>
  800b0f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b12:	83 f8 30             	cmp    $0x30,%eax
  800b15:	73 17                	jae    800b2e <vprintfmt+0x296>
  800b17:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b1b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b1e:	89 c0                	mov    %eax,%eax
  800b20:	48 01 d0             	add    %rdx,%rax
  800b23:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b26:	83 c2 08             	add    $0x8,%edx
  800b29:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b2c:	eb 0f                	jmp    800b3d <vprintfmt+0x2a5>
  800b2e:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b32:	48 89 d0             	mov    %rdx,%rax
  800b35:	48 83 c2 08          	add    $0x8,%rdx
  800b39:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b3d:	4c 8b 20             	mov    (%rax),%r12
  800b40:	4d 85 e4             	test   %r12,%r12
  800b43:	75 0a                	jne    800b4f <vprintfmt+0x2b7>
  800b45:	49 bc 2d 4a 80 00 00 	movabs $0x804a2d,%r12
  800b4c:	00 00 00 
  800b4f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b53:	7e 3f                	jle    800b94 <vprintfmt+0x2fc>
  800b55:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800b59:	74 39                	je     800b94 <vprintfmt+0x2fc>
  800b5b:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b5e:	48 98                	cltq   
  800b60:	48 89 c6             	mov    %rax,%rsi
  800b63:	4c 89 e7             	mov    %r12,%rdi
  800b66:	48 b8 5c 10 80 00 00 	movabs $0x80105c,%rax
  800b6d:	00 00 00 
  800b70:	ff d0                	callq  *%rax
  800b72:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800b75:	eb 17                	jmp    800b8e <vprintfmt+0x2f6>
  800b77:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800b7b:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800b7f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b83:	48 89 ce             	mov    %rcx,%rsi
  800b86:	89 d7                	mov    %edx,%edi
  800b88:	ff d0                	callq  *%rax
  800b8a:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800b8e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b92:	7f e3                	jg     800b77 <vprintfmt+0x2df>
  800b94:	eb 37                	jmp    800bcd <vprintfmt+0x335>
  800b96:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800b9a:	74 1e                	je     800bba <vprintfmt+0x322>
  800b9c:	83 fb 1f             	cmp    $0x1f,%ebx
  800b9f:	7e 05                	jle    800ba6 <vprintfmt+0x30e>
  800ba1:	83 fb 7e             	cmp    $0x7e,%ebx
  800ba4:	7e 14                	jle    800bba <vprintfmt+0x322>
  800ba6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800baa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bae:	48 89 d6             	mov    %rdx,%rsi
  800bb1:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800bb6:	ff d0                	callq  *%rax
  800bb8:	eb 0f                	jmp    800bc9 <vprintfmt+0x331>
  800bba:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bbe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bc2:	48 89 d6             	mov    %rdx,%rsi
  800bc5:	89 df                	mov    %ebx,%edi
  800bc7:	ff d0                	callq  *%rax
  800bc9:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800bcd:	4c 89 e0             	mov    %r12,%rax
  800bd0:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800bd4:	0f b6 00             	movzbl (%rax),%eax
  800bd7:	0f be d8             	movsbl %al,%ebx
  800bda:	85 db                	test   %ebx,%ebx
  800bdc:	74 10                	je     800bee <vprintfmt+0x356>
  800bde:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800be2:	78 b2                	js     800b96 <vprintfmt+0x2fe>
  800be4:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800be8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800bec:	79 a8                	jns    800b96 <vprintfmt+0x2fe>
  800bee:	eb 16                	jmp    800c06 <vprintfmt+0x36e>
  800bf0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bf4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bf8:	48 89 d6             	mov    %rdx,%rsi
  800bfb:	bf 20 00 00 00       	mov    $0x20,%edi
  800c00:	ff d0                	callq  *%rax
  800c02:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800c06:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c0a:	7f e4                	jg     800bf0 <vprintfmt+0x358>
  800c0c:	e9 90 01 00 00       	jmpq   800da1 <vprintfmt+0x509>
  800c11:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c15:	be 03 00 00 00       	mov    $0x3,%esi
  800c1a:	48 89 c7             	mov    %rax,%rdi
  800c1d:	48 b8 88 07 80 00 00 	movabs $0x800788,%rax
  800c24:	00 00 00 
  800c27:	ff d0                	callq  *%rax
  800c29:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c31:	48 85 c0             	test   %rax,%rax
  800c34:	79 1d                	jns    800c53 <vprintfmt+0x3bb>
  800c36:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c3a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c3e:	48 89 d6             	mov    %rdx,%rsi
  800c41:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800c46:	ff d0                	callq  *%rax
  800c48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c4c:	48 f7 d8             	neg    %rax
  800c4f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c53:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800c5a:	e9 d5 00 00 00       	jmpq   800d34 <vprintfmt+0x49c>
  800c5f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c63:	be 03 00 00 00       	mov    $0x3,%esi
  800c68:	48 89 c7             	mov    %rax,%rdi
  800c6b:	48 b8 78 06 80 00 00 	movabs $0x800678,%rax
  800c72:	00 00 00 
  800c75:	ff d0                	callq  *%rax
  800c77:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c7b:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800c82:	e9 ad 00 00 00       	jmpq   800d34 <vprintfmt+0x49c>
  800c87:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c8b:	be 03 00 00 00       	mov    $0x3,%esi
  800c90:	48 89 c7             	mov    %rax,%rdi
  800c93:	48 b8 78 06 80 00 00 	movabs $0x800678,%rax
  800c9a:	00 00 00 
  800c9d:	ff d0                	callq  *%rax
  800c9f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ca3:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800caa:	e9 85 00 00 00       	jmpq   800d34 <vprintfmt+0x49c>
  800caf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cb3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cb7:	48 89 d6             	mov    %rdx,%rsi
  800cba:	bf 30 00 00 00       	mov    $0x30,%edi
  800cbf:	ff d0                	callq  *%rax
  800cc1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cc5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cc9:	48 89 d6             	mov    %rdx,%rsi
  800ccc:	bf 78 00 00 00       	mov    $0x78,%edi
  800cd1:	ff d0                	callq  *%rax
  800cd3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800cd6:	83 f8 30             	cmp    $0x30,%eax
  800cd9:	73 17                	jae    800cf2 <vprintfmt+0x45a>
  800cdb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800cdf:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ce2:	89 c0                	mov    %eax,%eax
  800ce4:	48 01 d0             	add    %rdx,%rax
  800ce7:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800cea:	83 c2 08             	add    $0x8,%edx
  800ced:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800cf0:	eb 0f                	jmp    800d01 <vprintfmt+0x469>
  800cf2:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800cf6:	48 89 d0             	mov    %rdx,%rax
  800cf9:	48 83 c2 08          	add    $0x8,%rdx
  800cfd:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d01:	48 8b 00             	mov    (%rax),%rax
  800d04:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d08:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800d0f:	eb 23                	jmp    800d34 <vprintfmt+0x49c>
  800d11:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d15:	be 03 00 00 00       	mov    $0x3,%esi
  800d1a:	48 89 c7             	mov    %rax,%rdi
  800d1d:	48 b8 78 06 80 00 00 	movabs $0x800678,%rax
  800d24:	00 00 00 
  800d27:	ff d0                	callq  *%rax
  800d29:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d2d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800d34:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800d39:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800d3c:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800d3f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800d43:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800d47:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d4b:	45 89 c1             	mov    %r8d,%r9d
  800d4e:	41 89 f8             	mov    %edi,%r8d
  800d51:	48 89 c7             	mov    %rax,%rdi
  800d54:	48 b8 bd 05 80 00 00 	movabs $0x8005bd,%rax
  800d5b:	00 00 00 
  800d5e:	ff d0                	callq  *%rax
  800d60:	eb 3f                	jmp    800da1 <vprintfmt+0x509>
  800d62:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d66:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d6a:	48 89 d6             	mov    %rdx,%rsi
  800d6d:	89 df                	mov    %ebx,%edi
  800d6f:	ff d0                	callq  *%rax
  800d71:	eb 2e                	jmp    800da1 <vprintfmt+0x509>
  800d73:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d77:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d7b:	48 89 d6             	mov    %rdx,%rsi
  800d7e:	bf 25 00 00 00       	mov    $0x25,%edi
  800d83:	ff d0                	callq  *%rax
  800d85:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800d8a:	eb 05                	jmp    800d91 <vprintfmt+0x4f9>
  800d8c:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800d91:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800d95:	48 83 e8 01          	sub    $0x1,%rax
  800d99:	0f b6 00             	movzbl (%rax),%eax
  800d9c:	3c 25                	cmp    $0x25,%al
  800d9e:	75 ec                	jne    800d8c <vprintfmt+0x4f4>
  800da0:	90                   	nop
  800da1:	90                   	nop
  800da2:	e9 43 fb ff ff       	jmpq   8008ea <vprintfmt+0x52>
  800da7:	48 83 c4 60          	add    $0x60,%rsp
  800dab:	5b                   	pop    %rbx
  800dac:	41 5c                	pop    %r12
  800dae:	5d                   	pop    %rbp
  800daf:	c3                   	retq   

0000000000800db0 <printfmt>:
  800db0:	55                   	push   %rbp
  800db1:	48 89 e5             	mov    %rsp,%rbp
  800db4:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800dbb:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800dc2:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800dc9:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800dd0:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800dd7:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800dde:	84 c0                	test   %al,%al
  800de0:	74 20                	je     800e02 <printfmt+0x52>
  800de2:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800de6:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800dea:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800dee:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800df2:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800df6:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800dfa:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800dfe:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800e02:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800e09:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800e10:	00 00 00 
  800e13:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800e1a:	00 00 00 
  800e1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800e21:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800e28:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800e2f:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800e36:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800e3d:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800e44:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800e4b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800e52:	48 89 c7             	mov    %rax,%rdi
  800e55:	48 b8 98 08 80 00 00 	movabs $0x800898,%rax
  800e5c:	00 00 00 
  800e5f:	ff d0                	callq  *%rax
  800e61:	c9                   	leaveq 
  800e62:	c3                   	retq   

0000000000800e63 <sprintputch>:
  800e63:	55                   	push   %rbp
  800e64:	48 89 e5             	mov    %rsp,%rbp
  800e67:	48 83 ec 10          	sub    $0x10,%rsp
  800e6b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800e6e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800e72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e76:	8b 40 10             	mov    0x10(%rax),%eax
  800e79:	8d 50 01             	lea    0x1(%rax),%edx
  800e7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e80:	89 50 10             	mov    %edx,0x10(%rax)
  800e83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e87:	48 8b 10             	mov    (%rax),%rdx
  800e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  800e92:	48 39 c2             	cmp    %rax,%rdx
  800e95:	73 17                	jae    800eae <sprintputch+0x4b>
  800e97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e9b:	48 8b 00             	mov    (%rax),%rax
  800e9e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800ea2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800ea6:	48 89 0a             	mov    %rcx,(%rdx)
  800ea9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800eac:	88 10                	mov    %dl,(%rax)
  800eae:	c9                   	leaveq 
  800eaf:	c3                   	retq   

0000000000800eb0 <vsnprintf>:
  800eb0:	55                   	push   %rbp
  800eb1:	48 89 e5             	mov    %rsp,%rbp
  800eb4:	48 83 ec 50          	sub    $0x50,%rsp
  800eb8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800ebc:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800ebf:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800ec3:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800ec7:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800ecb:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800ecf:	48 8b 0a             	mov    (%rdx),%rcx
  800ed2:	48 89 08             	mov    %rcx,(%rax)
  800ed5:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ed9:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800edd:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ee1:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800ee5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800ee9:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800eed:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800ef0:	48 98                	cltq   
  800ef2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800ef6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800efa:	48 01 d0             	add    %rdx,%rax
  800efd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800f01:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800f08:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800f0d:	74 06                	je     800f15 <vsnprintf+0x65>
  800f0f:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800f13:	7f 07                	jg     800f1c <vsnprintf+0x6c>
  800f15:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800f1a:	eb 2f                	jmp    800f4b <vsnprintf+0x9b>
  800f1c:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800f20:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800f24:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800f28:	48 89 c6             	mov    %rax,%rsi
  800f2b:	48 bf 63 0e 80 00 00 	movabs $0x800e63,%rdi
  800f32:	00 00 00 
  800f35:	48 b8 98 08 80 00 00 	movabs $0x800898,%rax
  800f3c:	00 00 00 
  800f3f:	ff d0                	callq  *%rax
  800f41:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800f45:	c6 00 00             	movb   $0x0,(%rax)
  800f48:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800f4b:	c9                   	leaveq 
  800f4c:	c3                   	retq   

0000000000800f4d <snprintf>:
  800f4d:	55                   	push   %rbp
  800f4e:	48 89 e5             	mov    %rsp,%rbp
  800f51:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800f58:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800f5f:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800f65:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f6c:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f73:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f7a:	84 c0                	test   %al,%al
  800f7c:	74 20                	je     800f9e <snprintf+0x51>
  800f7e:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f82:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f86:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f8a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f8e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f92:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f96:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f9a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f9e:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800fa5:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800fac:	00 00 00 
  800faf:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800fb6:	00 00 00 
  800fb9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800fbd:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800fc4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800fcb:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800fd2:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800fd9:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800fe0:	48 8b 0a             	mov    (%rdx),%rcx
  800fe3:	48 89 08             	mov    %rcx,(%rax)
  800fe6:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800fea:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800fee:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ff2:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800ff6:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800ffd:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801004:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80100a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801011:	48 89 c7             	mov    %rax,%rdi
  801014:	48 b8 b0 0e 80 00 00 	movabs $0x800eb0,%rax
  80101b:	00 00 00 
  80101e:	ff d0                	callq  *%rax
  801020:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801026:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80102c:	c9                   	leaveq 
  80102d:	c3                   	retq   

000000000080102e <strlen>:
  80102e:	55                   	push   %rbp
  80102f:	48 89 e5             	mov    %rsp,%rbp
  801032:	48 83 ec 18          	sub    $0x18,%rsp
  801036:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80103a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801041:	eb 09                	jmp    80104c <strlen+0x1e>
  801043:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801047:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80104c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801050:	0f b6 00             	movzbl (%rax),%eax
  801053:	84 c0                	test   %al,%al
  801055:	75 ec                	jne    801043 <strlen+0x15>
  801057:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80105a:	c9                   	leaveq 
  80105b:	c3                   	retq   

000000000080105c <strnlen>:
  80105c:	55                   	push   %rbp
  80105d:	48 89 e5             	mov    %rsp,%rbp
  801060:	48 83 ec 20          	sub    $0x20,%rsp
  801064:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801068:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80106c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801073:	eb 0e                	jmp    801083 <strnlen+0x27>
  801075:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801079:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80107e:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801083:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801088:	74 0b                	je     801095 <strnlen+0x39>
  80108a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80108e:	0f b6 00             	movzbl (%rax),%eax
  801091:	84 c0                	test   %al,%al
  801093:	75 e0                	jne    801075 <strnlen+0x19>
  801095:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801098:	c9                   	leaveq 
  801099:	c3                   	retq   

000000000080109a <strcpy>:
  80109a:	55                   	push   %rbp
  80109b:	48 89 e5             	mov    %rsp,%rbp
  80109e:	48 83 ec 20          	sub    $0x20,%rsp
  8010a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010a6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8010aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8010b2:	90                   	nop
  8010b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010b7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8010bb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8010bf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8010c3:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8010c7:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8010cb:	0f b6 12             	movzbl (%rdx),%edx
  8010ce:	88 10                	mov    %dl,(%rax)
  8010d0:	0f b6 00             	movzbl (%rax),%eax
  8010d3:	84 c0                	test   %al,%al
  8010d5:	75 dc                	jne    8010b3 <strcpy+0x19>
  8010d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010db:	c9                   	leaveq 
  8010dc:	c3                   	retq   

00000000008010dd <strcat>:
  8010dd:	55                   	push   %rbp
  8010de:	48 89 e5             	mov    %rsp,%rbp
  8010e1:	48 83 ec 20          	sub    $0x20,%rsp
  8010e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010e9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8010ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010f1:	48 89 c7             	mov    %rax,%rdi
  8010f4:	48 b8 2e 10 80 00 00 	movabs $0x80102e,%rax
  8010fb:	00 00 00 
  8010fe:	ff d0                	callq  *%rax
  801100:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801103:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801106:	48 63 d0             	movslq %eax,%rdx
  801109:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80110d:	48 01 c2             	add    %rax,%rdx
  801110:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801114:	48 89 c6             	mov    %rax,%rsi
  801117:	48 89 d7             	mov    %rdx,%rdi
  80111a:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  801121:	00 00 00 
  801124:	ff d0                	callq  *%rax
  801126:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80112a:	c9                   	leaveq 
  80112b:	c3                   	retq   

000000000080112c <strncpy>:
  80112c:	55                   	push   %rbp
  80112d:	48 89 e5             	mov    %rsp,%rbp
  801130:	48 83 ec 28          	sub    $0x28,%rsp
  801134:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801138:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80113c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801140:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801144:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801148:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80114f:	00 
  801150:	eb 2a                	jmp    80117c <strncpy+0x50>
  801152:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801156:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80115a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80115e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801162:	0f b6 12             	movzbl (%rdx),%edx
  801165:	88 10                	mov    %dl,(%rax)
  801167:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80116b:	0f b6 00             	movzbl (%rax),%eax
  80116e:	84 c0                	test   %al,%al
  801170:	74 05                	je     801177 <strncpy+0x4b>
  801172:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801177:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80117c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801180:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801184:	72 cc                	jb     801152 <strncpy+0x26>
  801186:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80118a:	c9                   	leaveq 
  80118b:	c3                   	retq   

000000000080118c <strlcpy>:
  80118c:	55                   	push   %rbp
  80118d:	48 89 e5             	mov    %rsp,%rbp
  801190:	48 83 ec 28          	sub    $0x28,%rsp
  801194:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801198:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80119c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8011a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8011a8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8011ad:	74 3d                	je     8011ec <strlcpy+0x60>
  8011af:	eb 1d                	jmp    8011ce <strlcpy+0x42>
  8011b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011b5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8011b9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8011bd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8011c1:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8011c5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8011c9:	0f b6 12             	movzbl (%rdx),%edx
  8011cc:	88 10                	mov    %dl,(%rax)
  8011ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8011d3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8011d8:	74 0b                	je     8011e5 <strlcpy+0x59>
  8011da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8011de:	0f b6 00             	movzbl (%rax),%eax
  8011e1:	84 c0                	test   %al,%al
  8011e3:	75 cc                	jne    8011b1 <strlcpy+0x25>
  8011e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011e9:	c6 00 00             	movb   $0x0,(%rax)
  8011ec:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011f4:	48 29 c2             	sub    %rax,%rdx
  8011f7:	48 89 d0             	mov    %rdx,%rax
  8011fa:	c9                   	leaveq 
  8011fb:	c3                   	retq   

00000000008011fc <strcmp>:
  8011fc:	55                   	push   %rbp
  8011fd:	48 89 e5             	mov    %rsp,%rbp
  801200:	48 83 ec 10          	sub    $0x10,%rsp
  801204:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801208:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80120c:	eb 0a                	jmp    801218 <strcmp+0x1c>
  80120e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801213:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801218:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80121c:	0f b6 00             	movzbl (%rax),%eax
  80121f:	84 c0                	test   %al,%al
  801221:	74 12                	je     801235 <strcmp+0x39>
  801223:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801227:	0f b6 10             	movzbl (%rax),%edx
  80122a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80122e:	0f b6 00             	movzbl (%rax),%eax
  801231:	38 c2                	cmp    %al,%dl
  801233:	74 d9                	je     80120e <strcmp+0x12>
  801235:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801239:	0f b6 00             	movzbl (%rax),%eax
  80123c:	0f b6 d0             	movzbl %al,%edx
  80123f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801243:	0f b6 00             	movzbl (%rax),%eax
  801246:	0f b6 c0             	movzbl %al,%eax
  801249:	29 c2                	sub    %eax,%edx
  80124b:	89 d0                	mov    %edx,%eax
  80124d:	c9                   	leaveq 
  80124e:	c3                   	retq   

000000000080124f <strncmp>:
  80124f:	55                   	push   %rbp
  801250:	48 89 e5             	mov    %rsp,%rbp
  801253:	48 83 ec 18          	sub    $0x18,%rsp
  801257:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80125b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80125f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801263:	eb 0f                	jmp    801274 <strncmp+0x25>
  801265:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80126a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80126f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801274:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801279:	74 1d                	je     801298 <strncmp+0x49>
  80127b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80127f:	0f b6 00             	movzbl (%rax),%eax
  801282:	84 c0                	test   %al,%al
  801284:	74 12                	je     801298 <strncmp+0x49>
  801286:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80128a:	0f b6 10             	movzbl (%rax),%edx
  80128d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801291:	0f b6 00             	movzbl (%rax),%eax
  801294:	38 c2                	cmp    %al,%dl
  801296:	74 cd                	je     801265 <strncmp+0x16>
  801298:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80129d:	75 07                	jne    8012a6 <strncmp+0x57>
  80129f:	b8 00 00 00 00       	mov    $0x0,%eax
  8012a4:	eb 18                	jmp    8012be <strncmp+0x6f>
  8012a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012aa:	0f b6 00             	movzbl (%rax),%eax
  8012ad:	0f b6 d0             	movzbl %al,%edx
  8012b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012b4:	0f b6 00             	movzbl (%rax),%eax
  8012b7:	0f b6 c0             	movzbl %al,%eax
  8012ba:	29 c2                	sub    %eax,%edx
  8012bc:	89 d0                	mov    %edx,%eax
  8012be:	c9                   	leaveq 
  8012bf:	c3                   	retq   

00000000008012c0 <strchr>:
  8012c0:	55                   	push   %rbp
  8012c1:	48 89 e5             	mov    %rsp,%rbp
  8012c4:	48 83 ec 0c          	sub    $0xc,%rsp
  8012c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8012cc:	89 f0                	mov    %esi,%eax
  8012ce:	88 45 f4             	mov    %al,-0xc(%rbp)
  8012d1:	eb 17                	jmp    8012ea <strchr+0x2a>
  8012d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012d7:	0f b6 00             	movzbl (%rax),%eax
  8012da:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8012dd:	75 06                	jne    8012e5 <strchr+0x25>
  8012df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012e3:	eb 15                	jmp    8012fa <strchr+0x3a>
  8012e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8012ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012ee:	0f b6 00             	movzbl (%rax),%eax
  8012f1:	84 c0                	test   %al,%al
  8012f3:	75 de                	jne    8012d3 <strchr+0x13>
  8012f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8012fa:	c9                   	leaveq 
  8012fb:	c3                   	retq   

00000000008012fc <strfind>:
  8012fc:	55                   	push   %rbp
  8012fd:	48 89 e5             	mov    %rsp,%rbp
  801300:	48 83 ec 0c          	sub    $0xc,%rsp
  801304:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801308:	89 f0                	mov    %esi,%eax
  80130a:	88 45 f4             	mov    %al,-0xc(%rbp)
  80130d:	eb 13                	jmp    801322 <strfind+0x26>
  80130f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801313:	0f b6 00             	movzbl (%rax),%eax
  801316:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801319:	75 02                	jne    80131d <strfind+0x21>
  80131b:	eb 10                	jmp    80132d <strfind+0x31>
  80131d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801322:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801326:	0f b6 00             	movzbl (%rax),%eax
  801329:	84 c0                	test   %al,%al
  80132b:	75 e2                	jne    80130f <strfind+0x13>
  80132d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801331:	c9                   	leaveq 
  801332:	c3                   	retq   

0000000000801333 <memset>:
  801333:	55                   	push   %rbp
  801334:	48 89 e5             	mov    %rsp,%rbp
  801337:	48 83 ec 18          	sub    $0x18,%rsp
  80133b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80133f:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801342:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801346:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80134b:	75 06                	jne    801353 <memset+0x20>
  80134d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801351:	eb 69                	jmp    8013bc <memset+0x89>
  801353:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801357:	83 e0 03             	and    $0x3,%eax
  80135a:	48 85 c0             	test   %rax,%rax
  80135d:	75 48                	jne    8013a7 <memset+0x74>
  80135f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801363:	83 e0 03             	and    $0x3,%eax
  801366:	48 85 c0             	test   %rax,%rax
  801369:	75 3c                	jne    8013a7 <memset+0x74>
  80136b:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801372:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801375:	c1 e0 18             	shl    $0x18,%eax
  801378:	89 c2                	mov    %eax,%edx
  80137a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80137d:	c1 e0 10             	shl    $0x10,%eax
  801380:	09 c2                	or     %eax,%edx
  801382:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801385:	c1 e0 08             	shl    $0x8,%eax
  801388:	09 d0                	or     %edx,%eax
  80138a:	09 45 f4             	or     %eax,-0xc(%rbp)
  80138d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801391:	48 c1 e8 02          	shr    $0x2,%rax
  801395:	48 89 c1             	mov    %rax,%rcx
  801398:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80139c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80139f:	48 89 d7             	mov    %rdx,%rdi
  8013a2:	fc                   	cld    
  8013a3:	f3 ab                	rep stos %eax,%es:(%rdi)
  8013a5:	eb 11                	jmp    8013b8 <memset+0x85>
  8013a7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8013ae:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8013b2:	48 89 d7             	mov    %rdx,%rdi
  8013b5:	fc                   	cld    
  8013b6:	f3 aa                	rep stos %al,%es:(%rdi)
  8013b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013bc:	c9                   	leaveq 
  8013bd:	c3                   	retq   

00000000008013be <memmove>:
  8013be:	55                   	push   %rbp
  8013bf:	48 89 e5             	mov    %rsp,%rbp
  8013c2:	48 83 ec 28          	sub    $0x28,%rsp
  8013c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013ce:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8013d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013de:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8013e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013e6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8013ea:	0f 83 88 00 00 00    	jae    801478 <memmove+0xba>
  8013f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8013f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013f8:	48 01 d0             	add    %rdx,%rax
  8013fb:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8013ff:	76 77                	jbe    801478 <memmove+0xba>
  801401:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801405:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801409:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80140d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801411:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801415:	83 e0 03             	and    $0x3,%eax
  801418:	48 85 c0             	test   %rax,%rax
  80141b:	75 3b                	jne    801458 <memmove+0x9a>
  80141d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801421:	83 e0 03             	and    $0x3,%eax
  801424:	48 85 c0             	test   %rax,%rax
  801427:	75 2f                	jne    801458 <memmove+0x9a>
  801429:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80142d:	83 e0 03             	and    $0x3,%eax
  801430:	48 85 c0             	test   %rax,%rax
  801433:	75 23                	jne    801458 <memmove+0x9a>
  801435:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801439:	48 83 e8 04          	sub    $0x4,%rax
  80143d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801441:	48 83 ea 04          	sub    $0x4,%rdx
  801445:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801449:	48 c1 e9 02          	shr    $0x2,%rcx
  80144d:	48 89 c7             	mov    %rax,%rdi
  801450:	48 89 d6             	mov    %rdx,%rsi
  801453:	fd                   	std    
  801454:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801456:	eb 1d                	jmp    801475 <memmove+0xb7>
  801458:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80145c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801464:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801468:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80146c:	48 89 d7             	mov    %rdx,%rdi
  80146f:	48 89 c1             	mov    %rax,%rcx
  801472:	fd                   	std    
  801473:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801475:	fc                   	cld    
  801476:	eb 57                	jmp    8014cf <memmove+0x111>
  801478:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80147c:	83 e0 03             	and    $0x3,%eax
  80147f:	48 85 c0             	test   %rax,%rax
  801482:	75 36                	jne    8014ba <memmove+0xfc>
  801484:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801488:	83 e0 03             	and    $0x3,%eax
  80148b:	48 85 c0             	test   %rax,%rax
  80148e:	75 2a                	jne    8014ba <memmove+0xfc>
  801490:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801494:	83 e0 03             	and    $0x3,%eax
  801497:	48 85 c0             	test   %rax,%rax
  80149a:	75 1e                	jne    8014ba <memmove+0xfc>
  80149c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014a0:	48 c1 e8 02          	shr    $0x2,%rax
  8014a4:	48 89 c1             	mov    %rax,%rcx
  8014a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014ab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014af:	48 89 c7             	mov    %rax,%rdi
  8014b2:	48 89 d6             	mov    %rdx,%rsi
  8014b5:	fc                   	cld    
  8014b6:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8014b8:	eb 15                	jmp    8014cf <memmove+0x111>
  8014ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014be:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014c2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8014c6:	48 89 c7             	mov    %rax,%rdi
  8014c9:	48 89 d6             	mov    %rdx,%rsi
  8014cc:	fc                   	cld    
  8014cd:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8014cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014d3:	c9                   	leaveq 
  8014d4:	c3                   	retq   

00000000008014d5 <memcpy>:
  8014d5:	55                   	push   %rbp
  8014d6:	48 89 e5             	mov    %rsp,%rbp
  8014d9:	48 83 ec 18          	sub    $0x18,%rsp
  8014dd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014e1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8014e5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014e9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8014ed:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8014f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014f5:	48 89 ce             	mov    %rcx,%rsi
  8014f8:	48 89 c7             	mov    %rax,%rdi
  8014fb:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  801502:	00 00 00 
  801505:	ff d0                	callq  *%rax
  801507:	c9                   	leaveq 
  801508:	c3                   	retq   

0000000000801509 <memcmp>:
  801509:	55                   	push   %rbp
  80150a:	48 89 e5             	mov    %rsp,%rbp
  80150d:	48 83 ec 28          	sub    $0x28,%rsp
  801511:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801515:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801519:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80151d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801521:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801525:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801529:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80152d:	eb 36                	jmp    801565 <memcmp+0x5c>
  80152f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801533:	0f b6 10             	movzbl (%rax),%edx
  801536:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80153a:	0f b6 00             	movzbl (%rax),%eax
  80153d:	38 c2                	cmp    %al,%dl
  80153f:	74 1a                	je     80155b <memcmp+0x52>
  801541:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801545:	0f b6 00             	movzbl (%rax),%eax
  801548:	0f b6 d0             	movzbl %al,%edx
  80154b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80154f:	0f b6 00             	movzbl (%rax),%eax
  801552:	0f b6 c0             	movzbl %al,%eax
  801555:	29 c2                	sub    %eax,%edx
  801557:	89 d0                	mov    %edx,%eax
  801559:	eb 20                	jmp    80157b <memcmp+0x72>
  80155b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801560:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801565:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801569:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80156d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801571:	48 85 c0             	test   %rax,%rax
  801574:	75 b9                	jne    80152f <memcmp+0x26>
  801576:	b8 00 00 00 00       	mov    $0x0,%eax
  80157b:	c9                   	leaveq 
  80157c:	c3                   	retq   

000000000080157d <memfind>:
  80157d:	55                   	push   %rbp
  80157e:	48 89 e5             	mov    %rsp,%rbp
  801581:	48 83 ec 28          	sub    $0x28,%rsp
  801585:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801589:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80158c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801590:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801594:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801598:	48 01 d0             	add    %rdx,%rax
  80159b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80159f:	eb 15                	jmp    8015b6 <memfind+0x39>
  8015a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015a5:	0f b6 10             	movzbl (%rax),%edx
  8015a8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8015ab:	38 c2                	cmp    %al,%dl
  8015ad:	75 02                	jne    8015b1 <memfind+0x34>
  8015af:	eb 0f                	jmp    8015c0 <memfind+0x43>
  8015b1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8015b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015ba:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8015be:	72 e1                	jb     8015a1 <memfind+0x24>
  8015c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015c4:	c9                   	leaveq 
  8015c5:	c3                   	retq   

00000000008015c6 <strtol>:
  8015c6:	55                   	push   %rbp
  8015c7:	48 89 e5             	mov    %rsp,%rbp
  8015ca:	48 83 ec 34          	sub    $0x34,%rsp
  8015ce:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8015d2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8015d6:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8015d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8015e0:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8015e7:	00 
  8015e8:	eb 05                	jmp    8015ef <strtol+0x29>
  8015ea:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015f3:	0f b6 00             	movzbl (%rax),%eax
  8015f6:	3c 20                	cmp    $0x20,%al
  8015f8:	74 f0                	je     8015ea <strtol+0x24>
  8015fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015fe:	0f b6 00             	movzbl (%rax),%eax
  801601:	3c 09                	cmp    $0x9,%al
  801603:	74 e5                	je     8015ea <strtol+0x24>
  801605:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801609:	0f b6 00             	movzbl (%rax),%eax
  80160c:	3c 2b                	cmp    $0x2b,%al
  80160e:	75 07                	jne    801617 <strtol+0x51>
  801610:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801615:	eb 17                	jmp    80162e <strtol+0x68>
  801617:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80161b:	0f b6 00             	movzbl (%rax),%eax
  80161e:	3c 2d                	cmp    $0x2d,%al
  801620:	75 0c                	jne    80162e <strtol+0x68>
  801622:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801627:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80162e:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801632:	74 06                	je     80163a <strtol+0x74>
  801634:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801638:	75 28                	jne    801662 <strtol+0x9c>
  80163a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80163e:	0f b6 00             	movzbl (%rax),%eax
  801641:	3c 30                	cmp    $0x30,%al
  801643:	75 1d                	jne    801662 <strtol+0x9c>
  801645:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801649:	48 83 c0 01          	add    $0x1,%rax
  80164d:	0f b6 00             	movzbl (%rax),%eax
  801650:	3c 78                	cmp    $0x78,%al
  801652:	75 0e                	jne    801662 <strtol+0x9c>
  801654:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801659:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801660:	eb 2c                	jmp    80168e <strtol+0xc8>
  801662:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801666:	75 19                	jne    801681 <strtol+0xbb>
  801668:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80166c:	0f b6 00             	movzbl (%rax),%eax
  80166f:	3c 30                	cmp    $0x30,%al
  801671:	75 0e                	jne    801681 <strtol+0xbb>
  801673:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801678:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  80167f:	eb 0d                	jmp    80168e <strtol+0xc8>
  801681:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801685:	75 07                	jne    80168e <strtol+0xc8>
  801687:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  80168e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801692:	0f b6 00             	movzbl (%rax),%eax
  801695:	3c 2f                	cmp    $0x2f,%al
  801697:	7e 1d                	jle    8016b6 <strtol+0xf0>
  801699:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80169d:	0f b6 00             	movzbl (%rax),%eax
  8016a0:	3c 39                	cmp    $0x39,%al
  8016a2:	7f 12                	jg     8016b6 <strtol+0xf0>
  8016a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016a8:	0f b6 00             	movzbl (%rax),%eax
  8016ab:	0f be c0             	movsbl %al,%eax
  8016ae:	83 e8 30             	sub    $0x30,%eax
  8016b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8016b4:	eb 4e                	jmp    801704 <strtol+0x13e>
  8016b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016ba:	0f b6 00             	movzbl (%rax),%eax
  8016bd:	3c 60                	cmp    $0x60,%al
  8016bf:	7e 1d                	jle    8016de <strtol+0x118>
  8016c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016c5:	0f b6 00             	movzbl (%rax),%eax
  8016c8:	3c 7a                	cmp    $0x7a,%al
  8016ca:	7f 12                	jg     8016de <strtol+0x118>
  8016cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016d0:	0f b6 00             	movzbl (%rax),%eax
  8016d3:	0f be c0             	movsbl %al,%eax
  8016d6:	83 e8 57             	sub    $0x57,%eax
  8016d9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8016dc:	eb 26                	jmp    801704 <strtol+0x13e>
  8016de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016e2:	0f b6 00             	movzbl (%rax),%eax
  8016e5:	3c 40                	cmp    $0x40,%al
  8016e7:	7e 48                	jle    801731 <strtol+0x16b>
  8016e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016ed:	0f b6 00             	movzbl (%rax),%eax
  8016f0:	3c 5a                	cmp    $0x5a,%al
  8016f2:	7f 3d                	jg     801731 <strtol+0x16b>
  8016f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016f8:	0f b6 00             	movzbl (%rax),%eax
  8016fb:	0f be c0             	movsbl %al,%eax
  8016fe:	83 e8 37             	sub    $0x37,%eax
  801701:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801704:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801707:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  80170a:	7c 02                	jl     80170e <strtol+0x148>
  80170c:	eb 23                	jmp    801731 <strtol+0x16b>
  80170e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801713:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801716:	48 98                	cltq   
  801718:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  80171d:	48 89 c2             	mov    %rax,%rdx
  801720:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801723:	48 98                	cltq   
  801725:	48 01 d0             	add    %rdx,%rax
  801728:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80172c:	e9 5d ff ff ff       	jmpq   80168e <strtol+0xc8>
  801731:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801736:	74 0b                	je     801743 <strtol+0x17d>
  801738:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80173c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801740:	48 89 10             	mov    %rdx,(%rax)
  801743:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801747:	74 09                	je     801752 <strtol+0x18c>
  801749:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80174d:	48 f7 d8             	neg    %rax
  801750:	eb 04                	jmp    801756 <strtol+0x190>
  801752:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801756:	c9                   	leaveq 
  801757:	c3                   	retq   

0000000000801758 <strstr>:
  801758:	55                   	push   %rbp
  801759:	48 89 e5             	mov    %rsp,%rbp
  80175c:	48 83 ec 30          	sub    $0x30,%rsp
  801760:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801764:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801768:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80176c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801770:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801774:	0f b6 00             	movzbl (%rax),%eax
  801777:	88 45 ff             	mov    %al,-0x1(%rbp)
  80177a:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  80177e:	75 06                	jne    801786 <strstr+0x2e>
  801780:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801784:	eb 6b                	jmp    8017f1 <strstr+0x99>
  801786:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80178a:	48 89 c7             	mov    %rax,%rdi
  80178d:	48 b8 2e 10 80 00 00 	movabs $0x80102e,%rax
  801794:	00 00 00 
  801797:	ff d0                	callq  *%rax
  801799:	48 98                	cltq   
  80179b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80179f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8017a7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8017ab:	0f b6 00             	movzbl (%rax),%eax
  8017ae:	88 45 ef             	mov    %al,-0x11(%rbp)
  8017b1:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8017b5:	75 07                	jne    8017be <strstr+0x66>
  8017b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8017bc:	eb 33                	jmp    8017f1 <strstr+0x99>
  8017be:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8017c2:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8017c5:	75 d8                	jne    80179f <strstr+0x47>
  8017c7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8017cb:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8017cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017d3:	48 89 ce             	mov    %rcx,%rsi
  8017d6:	48 89 c7             	mov    %rax,%rdi
  8017d9:	48 b8 4f 12 80 00 00 	movabs $0x80124f,%rax
  8017e0:	00 00 00 
  8017e3:	ff d0                	callq  *%rax
  8017e5:	85 c0                	test   %eax,%eax
  8017e7:	75 b6                	jne    80179f <strstr+0x47>
  8017e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ed:	48 83 e8 01          	sub    $0x1,%rax
  8017f1:	c9                   	leaveq 
  8017f2:	c3                   	retq   

00000000008017f3 <syscall>:
  8017f3:	55                   	push   %rbp
  8017f4:	48 89 e5             	mov    %rsp,%rbp
  8017f7:	53                   	push   %rbx
  8017f8:	48 83 ec 48          	sub    $0x48,%rsp
  8017fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8017ff:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801802:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801806:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80180a:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80180e:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801812:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801815:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801819:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  80181d:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801821:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801825:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801829:	4c 89 c3             	mov    %r8,%rbx
  80182c:	cd 30                	int    $0x30
  80182e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801832:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801836:	74 3e                	je     801876 <syscall+0x83>
  801838:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80183d:	7e 37                	jle    801876 <syscall+0x83>
  80183f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801843:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801846:	49 89 d0             	mov    %rdx,%r8
  801849:	89 c1                	mov    %eax,%ecx
  80184b:	48 ba e8 4c 80 00 00 	movabs $0x804ce8,%rdx
  801852:	00 00 00 
  801855:	be 24 00 00 00       	mov    $0x24,%esi
  80185a:	48 bf 05 4d 80 00 00 	movabs $0x804d05,%rdi
  801861:	00 00 00 
  801864:	b8 00 00 00 00       	mov    $0x0,%eax
  801869:	49 b9 5c 3e 80 00 00 	movabs $0x803e5c,%r9
  801870:	00 00 00 
  801873:	41 ff d1             	callq  *%r9
  801876:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80187a:	48 83 c4 48          	add    $0x48,%rsp
  80187e:	5b                   	pop    %rbx
  80187f:	5d                   	pop    %rbp
  801880:	c3                   	retq   

0000000000801881 <sys_cputs>:
  801881:	55                   	push   %rbp
  801882:	48 89 e5             	mov    %rsp,%rbp
  801885:	48 83 ec 20          	sub    $0x20,%rsp
  801889:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80188d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801891:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801895:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801899:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018a0:	00 
  8018a1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018a7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018ad:	48 89 d1             	mov    %rdx,%rcx
  8018b0:	48 89 c2             	mov    %rax,%rdx
  8018b3:	be 00 00 00 00       	mov    $0x0,%esi
  8018b8:	bf 00 00 00 00       	mov    $0x0,%edi
  8018bd:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  8018c4:	00 00 00 
  8018c7:	ff d0                	callq  *%rax
  8018c9:	c9                   	leaveq 
  8018ca:	c3                   	retq   

00000000008018cb <sys_cgetc>:
  8018cb:	55                   	push   %rbp
  8018cc:	48 89 e5             	mov    %rsp,%rbp
  8018cf:	48 83 ec 10          	sub    $0x10,%rsp
  8018d3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018da:	00 
  8018db:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018e1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8018e7:	b9 00 00 00 00       	mov    $0x0,%ecx
  8018ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8018f1:	be 00 00 00 00       	mov    $0x0,%esi
  8018f6:	bf 01 00 00 00       	mov    $0x1,%edi
  8018fb:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801902:	00 00 00 
  801905:	ff d0                	callq  *%rax
  801907:	c9                   	leaveq 
  801908:	c3                   	retq   

0000000000801909 <sys_env_destroy>:
  801909:	55                   	push   %rbp
  80190a:	48 89 e5             	mov    %rsp,%rbp
  80190d:	48 83 ec 10          	sub    $0x10,%rsp
  801911:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801914:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801917:	48 98                	cltq   
  801919:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801920:	00 
  801921:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801927:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80192d:	b9 00 00 00 00       	mov    $0x0,%ecx
  801932:	48 89 c2             	mov    %rax,%rdx
  801935:	be 01 00 00 00       	mov    $0x1,%esi
  80193a:	bf 03 00 00 00       	mov    $0x3,%edi
  80193f:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801946:	00 00 00 
  801949:	ff d0                	callq  *%rax
  80194b:	c9                   	leaveq 
  80194c:	c3                   	retq   

000000000080194d <sys_getenvid>:
  80194d:	55                   	push   %rbp
  80194e:	48 89 e5             	mov    %rsp,%rbp
  801951:	48 83 ec 10          	sub    $0x10,%rsp
  801955:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80195c:	00 
  80195d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801963:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801969:	b9 00 00 00 00       	mov    $0x0,%ecx
  80196e:	ba 00 00 00 00       	mov    $0x0,%edx
  801973:	be 00 00 00 00       	mov    $0x0,%esi
  801978:	bf 02 00 00 00       	mov    $0x2,%edi
  80197d:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801984:	00 00 00 
  801987:	ff d0                	callq  *%rax
  801989:	c9                   	leaveq 
  80198a:	c3                   	retq   

000000000080198b <sys_yield>:
  80198b:	55                   	push   %rbp
  80198c:	48 89 e5             	mov    %rsp,%rbp
  80198f:	48 83 ec 10          	sub    $0x10,%rsp
  801993:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80199a:	00 
  80199b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019a1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019a7:	b9 00 00 00 00       	mov    $0x0,%ecx
  8019ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8019b1:	be 00 00 00 00       	mov    $0x0,%esi
  8019b6:	bf 0b 00 00 00       	mov    $0xb,%edi
  8019bb:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  8019c2:	00 00 00 
  8019c5:	ff d0                	callq  *%rax
  8019c7:	c9                   	leaveq 
  8019c8:	c3                   	retq   

00000000008019c9 <sys_page_alloc>:
  8019c9:	55                   	push   %rbp
  8019ca:	48 89 e5             	mov    %rsp,%rbp
  8019cd:	48 83 ec 20          	sub    $0x20,%rsp
  8019d1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019d4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019d8:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8019db:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8019de:	48 63 c8             	movslq %eax,%rcx
  8019e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019e8:	48 98                	cltq   
  8019ea:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019f1:	00 
  8019f2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019f8:	49 89 c8             	mov    %rcx,%r8
  8019fb:	48 89 d1             	mov    %rdx,%rcx
  8019fe:	48 89 c2             	mov    %rax,%rdx
  801a01:	be 01 00 00 00       	mov    $0x1,%esi
  801a06:	bf 04 00 00 00       	mov    $0x4,%edi
  801a0b:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801a12:	00 00 00 
  801a15:	ff d0                	callq  *%rax
  801a17:	c9                   	leaveq 
  801a18:	c3                   	retq   

0000000000801a19 <sys_page_map>:
  801a19:	55                   	push   %rbp
  801a1a:	48 89 e5             	mov    %rsp,%rbp
  801a1d:	48 83 ec 30          	sub    $0x30,%rsp
  801a21:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a24:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a28:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801a2b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801a2f:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801a33:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801a36:	48 63 c8             	movslq %eax,%rcx
  801a39:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801a3d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a40:	48 63 f0             	movslq %eax,%rsi
  801a43:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a47:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a4a:	48 98                	cltq   
  801a4c:	48 89 0c 24          	mov    %rcx,(%rsp)
  801a50:	49 89 f9             	mov    %rdi,%r9
  801a53:	49 89 f0             	mov    %rsi,%r8
  801a56:	48 89 d1             	mov    %rdx,%rcx
  801a59:	48 89 c2             	mov    %rax,%rdx
  801a5c:	be 01 00 00 00       	mov    $0x1,%esi
  801a61:	bf 05 00 00 00       	mov    $0x5,%edi
  801a66:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801a6d:	00 00 00 
  801a70:	ff d0                	callq  *%rax
  801a72:	c9                   	leaveq 
  801a73:	c3                   	retq   

0000000000801a74 <sys_page_unmap>:
  801a74:	55                   	push   %rbp
  801a75:	48 89 e5             	mov    %rsp,%rbp
  801a78:	48 83 ec 20          	sub    $0x20,%rsp
  801a7c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a7f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a83:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a87:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a8a:	48 98                	cltq   
  801a8c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a93:	00 
  801a94:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a9a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801aa0:	48 89 d1             	mov    %rdx,%rcx
  801aa3:	48 89 c2             	mov    %rax,%rdx
  801aa6:	be 01 00 00 00       	mov    $0x1,%esi
  801aab:	bf 06 00 00 00       	mov    $0x6,%edi
  801ab0:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801ab7:	00 00 00 
  801aba:	ff d0                	callq  *%rax
  801abc:	c9                   	leaveq 
  801abd:	c3                   	retq   

0000000000801abe <sys_env_set_status>:
  801abe:	55                   	push   %rbp
  801abf:	48 89 e5             	mov    %rsp,%rbp
  801ac2:	48 83 ec 10          	sub    $0x10,%rsp
  801ac6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ac9:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801acc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801acf:	48 63 d0             	movslq %eax,%rdx
  801ad2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ad5:	48 98                	cltq   
  801ad7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ade:	00 
  801adf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ae5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801aeb:	48 89 d1             	mov    %rdx,%rcx
  801aee:	48 89 c2             	mov    %rax,%rdx
  801af1:	be 01 00 00 00       	mov    $0x1,%esi
  801af6:	bf 08 00 00 00       	mov    $0x8,%edi
  801afb:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801b02:	00 00 00 
  801b05:	ff d0                	callq  *%rax
  801b07:	c9                   	leaveq 
  801b08:	c3                   	retq   

0000000000801b09 <sys_env_set_trapframe>:
  801b09:	55                   	push   %rbp
  801b0a:	48 89 e5             	mov    %rsp,%rbp
  801b0d:	48 83 ec 20          	sub    $0x20,%rsp
  801b11:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b14:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b18:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b1f:	48 98                	cltq   
  801b21:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b28:	00 
  801b29:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b2f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b35:	48 89 d1             	mov    %rdx,%rcx
  801b38:	48 89 c2             	mov    %rax,%rdx
  801b3b:	be 01 00 00 00       	mov    $0x1,%esi
  801b40:	bf 09 00 00 00       	mov    $0x9,%edi
  801b45:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801b4c:	00 00 00 
  801b4f:	ff d0                	callq  *%rax
  801b51:	c9                   	leaveq 
  801b52:	c3                   	retq   

0000000000801b53 <sys_env_set_pgfault_upcall>:
  801b53:	55                   	push   %rbp
  801b54:	48 89 e5             	mov    %rsp,%rbp
  801b57:	48 83 ec 20          	sub    $0x20,%rsp
  801b5b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b5e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b62:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b66:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b69:	48 98                	cltq   
  801b6b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b72:	00 
  801b73:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b79:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b7f:	48 89 d1             	mov    %rdx,%rcx
  801b82:	48 89 c2             	mov    %rax,%rdx
  801b85:	be 01 00 00 00       	mov    $0x1,%esi
  801b8a:	bf 0a 00 00 00       	mov    $0xa,%edi
  801b8f:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801b96:	00 00 00 
  801b99:	ff d0                	callq  *%rax
  801b9b:	c9                   	leaveq 
  801b9c:	c3                   	retq   

0000000000801b9d <sys_ipc_try_send>:
  801b9d:	55                   	push   %rbp
  801b9e:	48 89 e5             	mov    %rsp,%rbp
  801ba1:	48 83 ec 20          	sub    $0x20,%rsp
  801ba5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ba8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bac:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801bb0:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801bb3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bb6:	48 63 f0             	movslq %eax,%rsi
  801bb9:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801bbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bc0:	48 98                	cltq   
  801bc2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bc6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bcd:	00 
  801bce:	49 89 f1             	mov    %rsi,%r9
  801bd1:	49 89 c8             	mov    %rcx,%r8
  801bd4:	48 89 d1             	mov    %rdx,%rcx
  801bd7:	48 89 c2             	mov    %rax,%rdx
  801bda:	be 00 00 00 00       	mov    $0x0,%esi
  801bdf:	bf 0c 00 00 00       	mov    $0xc,%edi
  801be4:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801beb:	00 00 00 
  801bee:	ff d0                	callq  *%rax
  801bf0:	c9                   	leaveq 
  801bf1:	c3                   	retq   

0000000000801bf2 <sys_ipc_recv>:
  801bf2:	55                   	push   %rbp
  801bf3:	48 89 e5             	mov    %rsp,%rbp
  801bf6:	48 83 ec 10          	sub    $0x10,%rsp
  801bfa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c02:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c09:	00 
  801c0a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c10:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c16:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c1b:	48 89 c2             	mov    %rax,%rdx
  801c1e:	be 01 00 00 00       	mov    $0x1,%esi
  801c23:	bf 0d 00 00 00       	mov    $0xd,%edi
  801c28:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801c2f:	00 00 00 
  801c32:	ff d0                	callq  *%rax
  801c34:	c9                   	leaveq 
  801c35:	c3                   	retq   

0000000000801c36 <sys_time_msec>:
  801c36:	55                   	push   %rbp
  801c37:	48 89 e5             	mov    %rsp,%rbp
  801c3a:	48 83 ec 10          	sub    $0x10,%rsp
  801c3e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c45:	00 
  801c46:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c4c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c52:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c57:	ba 00 00 00 00       	mov    $0x0,%edx
  801c5c:	be 00 00 00 00       	mov    $0x0,%esi
  801c61:	bf 0e 00 00 00       	mov    $0xe,%edi
  801c66:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801c6d:	00 00 00 
  801c70:	ff d0                	callq  *%rax
  801c72:	c9                   	leaveq 
  801c73:	c3                   	retq   

0000000000801c74 <sys_net_transmit>:
  801c74:	55                   	push   %rbp
  801c75:	48 89 e5             	mov    %rsp,%rbp
  801c78:	48 83 ec 20          	sub    $0x20,%rsp
  801c7c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c80:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801c83:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801c86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c8a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c91:	00 
  801c92:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c98:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c9e:	48 89 d1             	mov    %rdx,%rcx
  801ca1:	48 89 c2             	mov    %rax,%rdx
  801ca4:	be 00 00 00 00       	mov    $0x0,%esi
  801ca9:	bf 0f 00 00 00       	mov    $0xf,%edi
  801cae:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801cb5:	00 00 00 
  801cb8:	ff d0                	callq  *%rax
  801cba:	c9                   	leaveq 
  801cbb:	c3                   	retq   

0000000000801cbc <sys_net_receive>:
  801cbc:	55                   	push   %rbp
  801cbd:	48 89 e5             	mov    %rsp,%rbp
  801cc0:	48 83 ec 20          	sub    $0x20,%rsp
  801cc4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801cc8:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801ccb:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801cce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cd2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cd9:	00 
  801cda:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ce0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ce6:	48 89 d1             	mov    %rdx,%rcx
  801ce9:	48 89 c2             	mov    %rax,%rdx
  801cec:	be 00 00 00 00       	mov    $0x0,%esi
  801cf1:	bf 10 00 00 00       	mov    $0x10,%edi
  801cf6:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801cfd:	00 00 00 
  801d00:	ff d0                	callq  *%rax
  801d02:	c9                   	leaveq 
  801d03:	c3                   	retq   

0000000000801d04 <sys_ept_map>:
  801d04:	55                   	push   %rbp
  801d05:	48 89 e5             	mov    %rsp,%rbp
  801d08:	48 83 ec 30          	sub    $0x30,%rsp
  801d0c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d0f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d13:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d16:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801d1a:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801d1e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801d21:	48 63 c8             	movslq %eax,%rcx
  801d24:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801d28:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d2b:	48 63 f0             	movslq %eax,%rsi
  801d2e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d32:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d35:	48 98                	cltq   
  801d37:	48 89 0c 24          	mov    %rcx,(%rsp)
  801d3b:	49 89 f9             	mov    %rdi,%r9
  801d3e:	49 89 f0             	mov    %rsi,%r8
  801d41:	48 89 d1             	mov    %rdx,%rcx
  801d44:	48 89 c2             	mov    %rax,%rdx
  801d47:	be 00 00 00 00       	mov    $0x0,%esi
  801d4c:	bf 11 00 00 00       	mov    $0x11,%edi
  801d51:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801d58:	00 00 00 
  801d5b:	ff d0                	callq  *%rax
  801d5d:	c9                   	leaveq 
  801d5e:	c3                   	retq   

0000000000801d5f <sys_env_mkguest>:
  801d5f:	55                   	push   %rbp
  801d60:	48 89 e5             	mov    %rsp,%rbp
  801d63:	48 83 ec 20          	sub    $0x20,%rsp
  801d67:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d6b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d6f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d77:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d7e:	00 
  801d7f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d85:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d8b:	48 89 d1             	mov    %rdx,%rcx
  801d8e:	48 89 c2             	mov    %rax,%rdx
  801d91:	be 00 00 00 00       	mov    $0x0,%esi
  801d96:	bf 12 00 00 00       	mov    $0x12,%edi
  801d9b:	48 b8 f3 17 80 00 00 	movabs $0x8017f3,%rax
  801da2:	00 00 00 
  801da5:	ff d0                	callq  *%rax
  801da7:	c9                   	leaveq 
  801da8:	c3                   	retq   

0000000000801da9 <fd2num>:
  801da9:	55                   	push   %rbp
  801daa:	48 89 e5             	mov    %rsp,%rbp
  801dad:	48 83 ec 08          	sub    $0x8,%rsp
  801db1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801db5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801db9:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801dc0:	ff ff ff 
  801dc3:	48 01 d0             	add    %rdx,%rax
  801dc6:	48 c1 e8 0c          	shr    $0xc,%rax
  801dca:	c9                   	leaveq 
  801dcb:	c3                   	retq   

0000000000801dcc <fd2data>:
  801dcc:	55                   	push   %rbp
  801dcd:	48 89 e5             	mov    %rsp,%rbp
  801dd0:	48 83 ec 08          	sub    $0x8,%rsp
  801dd4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801dd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ddc:	48 89 c7             	mov    %rax,%rdi
  801ddf:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  801de6:	00 00 00 
  801de9:	ff d0                	callq  *%rax
  801deb:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801df1:	48 c1 e0 0c          	shl    $0xc,%rax
  801df5:	c9                   	leaveq 
  801df6:	c3                   	retq   

0000000000801df7 <fd_alloc>:
  801df7:	55                   	push   %rbp
  801df8:	48 89 e5             	mov    %rsp,%rbp
  801dfb:	48 83 ec 18          	sub    $0x18,%rsp
  801dff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801e03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801e0a:	eb 6b                	jmp    801e77 <fd_alloc+0x80>
  801e0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e0f:	48 98                	cltq   
  801e11:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801e17:	48 c1 e0 0c          	shl    $0xc,%rax
  801e1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801e1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e23:	48 c1 e8 15          	shr    $0x15,%rax
  801e27:	48 89 c2             	mov    %rax,%rdx
  801e2a:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801e31:	01 00 00 
  801e34:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801e38:	83 e0 01             	and    $0x1,%eax
  801e3b:	48 85 c0             	test   %rax,%rax
  801e3e:	74 21                	je     801e61 <fd_alloc+0x6a>
  801e40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e44:	48 c1 e8 0c          	shr    $0xc,%rax
  801e48:	48 89 c2             	mov    %rax,%rdx
  801e4b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801e52:	01 00 00 
  801e55:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801e59:	83 e0 01             	and    $0x1,%eax
  801e5c:	48 85 c0             	test   %rax,%rax
  801e5f:	75 12                	jne    801e73 <fd_alloc+0x7c>
  801e61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e65:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e69:	48 89 10             	mov    %rdx,(%rax)
  801e6c:	b8 00 00 00 00       	mov    $0x0,%eax
  801e71:	eb 1a                	jmp    801e8d <fd_alloc+0x96>
  801e73:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801e77:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801e7b:	7e 8f                	jle    801e0c <fd_alloc+0x15>
  801e7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e81:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801e88:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801e8d:	c9                   	leaveq 
  801e8e:	c3                   	retq   

0000000000801e8f <fd_lookup>:
  801e8f:	55                   	push   %rbp
  801e90:	48 89 e5             	mov    %rsp,%rbp
  801e93:	48 83 ec 20          	sub    $0x20,%rsp
  801e97:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801e9a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801e9e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801ea2:	78 06                	js     801eaa <fd_lookup+0x1b>
  801ea4:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801ea8:	7e 07                	jle    801eb1 <fd_lookup+0x22>
  801eaa:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801eaf:	eb 6c                	jmp    801f1d <fd_lookup+0x8e>
  801eb1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801eb4:	48 98                	cltq   
  801eb6:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801ebc:	48 c1 e0 0c          	shl    $0xc,%rax
  801ec0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801ec4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ec8:	48 c1 e8 15          	shr    $0x15,%rax
  801ecc:	48 89 c2             	mov    %rax,%rdx
  801ecf:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801ed6:	01 00 00 
  801ed9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801edd:	83 e0 01             	and    $0x1,%eax
  801ee0:	48 85 c0             	test   %rax,%rax
  801ee3:	74 21                	je     801f06 <fd_lookup+0x77>
  801ee5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ee9:	48 c1 e8 0c          	shr    $0xc,%rax
  801eed:	48 89 c2             	mov    %rax,%rdx
  801ef0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801ef7:	01 00 00 
  801efa:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801efe:	83 e0 01             	and    $0x1,%eax
  801f01:	48 85 c0             	test   %rax,%rax
  801f04:	75 07                	jne    801f0d <fd_lookup+0x7e>
  801f06:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f0b:	eb 10                	jmp    801f1d <fd_lookup+0x8e>
  801f0d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f11:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f15:	48 89 10             	mov    %rdx,(%rax)
  801f18:	b8 00 00 00 00       	mov    $0x0,%eax
  801f1d:	c9                   	leaveq 
  801f1e:	c3                   	retq   

0000000000801f1f <fd_close>:
  801f1f:	55                   	push   %rbp
  801f20:	48 89 e5             	mov    %rsp,%rbp
  801f23:	48 83 ec 30          	sub    $0x30,%rsp
  801f27:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801f2b:	89 f0                	mov    %esi,%eax
  801f2d:	88 45 d4             	mov    %al,-0x2c(%rbp)
  801f30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f34:	48 89 c7             	mov    %rax,%rdi
  801f37:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  801f3e:	00 00 00 
  801f41:	ff d0                	callq  *%rax
  801f43:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801f47:	48 89 d6             	mov    %rdx,%rsi
  801f4a:	89 c7                	mov    %eax,%edi
  801f4c:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  801f53:	00 00 00 
  801f56:	ff d0                	callq  *%rax
  801f58:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801f5b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801f5f:	78 0a                	js     801f6b <fd_close+0x4c>
  801f61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f65:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801f69:	74 12                	je     801f7d <fd_close+0x5e>
  801f6b:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801f6f:	74 05                	je     801f76 <fd_close+0x57>
  801f71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f74:	eb 05                	jmp    801f7b <fd_close+0x5c>
  801f76:	b8 00 00 00 00       	mov    $0x0,%eax
  801f7b:	eb 69                	jmp    801fe6 <fd_close+0xc7>
  801f7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f81:	8b 00                	mov    (%rax),%eax
  801f83:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801f87:	48 89 d6             	mov    %rdx,%rsi
  801f8a:	89 c7                	mov    %eax,%edi
  801f8c:	48 b8 e8 1f 80 00 00 	movabs $0x801fe8,%rax
  801f93:	00 00 00 
  801f96:	ff d0                	callq  *%rax
  801f98:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801f9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801f9f:	78 2a                	js     801fcb <fd_close+0xac>
  801fa1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801fa5:	48 8b 40 20          	mov    0x20(%rax),%rax
  801fa9:	48 85 c0             	test   %rax,%rax
  801fac:	74 16                	je     801fc4 <fd_close+0xa5>
  801fae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801fb2:	48 8b 40 20          	mov    0x20(%rax),%rax
  801fb6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801fba:	48 89 d7             	mov    %rdx,%rdi
  801fbd:	ff d0                	callq  *%rax
  801fbf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fc2:	eb 07                	jmp    801fcb <fd_close+0xac>
  801fc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801fcb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fcf:	48 89 c6             	mov    %rax,%rsi
  801fd2:	bf 00 00 00 00       	mov    $0x0,%edi
  801fd7:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  801fde:	00 00 00 
  801fe1:	ff d0                	callq  *%rax
  801fe3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fe6:	c9                   	leaveq 
  801fe7:	c3                   	retq   

0000000000801fe8 <dev_lookup>:
  801fe8:	55                   	push   %rbp
  801fe9:	48 89 e5             	mov    %rsp,%rbp
  801fec:	48 83 ec 20          	sub    $0x20,%rsp
  801ff0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801ff3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801ff7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ffe:	eb 41                	jmp    802041 <dev_lookup+0x59>
  802000:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  802007:	00 00 00 
  80200a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80200d:	48 63 d2             	movslq %edx,%rdx
  802010:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802014:	8b 00                	mov    (%rax),%eax
  802016:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802019:	75 22                	jne    80203d <dev_lookup+0x55>
  80201b:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  802022:	00 00 00 
  802025:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802028:	48 63 d2             	movslq %edx,%rdx
  80202b:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  80202f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802033:	48 89 10             	mov    %rdx,(%rax)
  802036:	b8 00 00 00 00       	mov    $0x0,%eax
  80203b:	eb 60                	jmp    80209d <dev_lookup+0xb5>
  80203d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802041:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  802048:	00 00 00 
  80204b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80204e:	48 63 d2             	movslq %edx,%rdx
  802051:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802055:	48 85 c0             	test   %rax,%rax
  802058:	75 a6                	jne    802000 <dev_lookup+0x18>
  80205a:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802061:	00 00 00 
  802064:	48 8b 00             	mov    (%rax),%rax
  802067:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80206d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802070:	89 c6                	mov    %eax,%esi
  802072:	48 bf 18 4d 80 00 00 	movabs $0x804d18,%rdi
  802079:	00 00 00 
  80207c:	b8 00 00 00 00       	mov    $0x0,%eax
  802081:	48 b9 e5 04 80 00 00 	movabs $0x8004e5,%rcx
  802088:	00 00 00 
  80208b:	ff d1                	callq  *%rcx
  80208d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802091:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802098:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80209d:	c9                   	leaveq 
  80209e:	c3                   	retq   

000000000080209f <close>:
  80209f:	55                   	push   %rbp
  8020a0:	48 89 e5             	mov    %rsp,%rbp
  8020a3:	48 83 ec 20          	sub    $0x20,%rsp
  8020a7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8020aa:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8020ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8020b1:	48 89 d6             	mov    %rdx,%rsi
  8020b4:	89 c7                	mov    %eax,%edi
  8020b6:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  8020bd:	00 00 00 
  8020c0:	ff d0                	callq  *%rax
  8020c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8020c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8020c9:	79 05                	jns    8020d0 <close+0x31>
  8020cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020ce:	eb 18                	jmp    8020e8 <close+0x49>
  8020d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8020d4:	be 01 00 00 00       	mov    $0x1,%esi
  8020d9:	48 89 c7             	mov    %rax,%rdi
  8020dc:	48 b8 1f 1f 80 00 00 	movabs $0x801f1f,%rax
  8020e3:	00 00 00 
  8020e6:	ff d0                	callq  *%rax
  8020e8:	c9                   	leaveq 
  8020e9:	c3                   	retq   

00000000008020ea <close_all>:
  8020ea:	55                   	push   %rbp
  8020eb:	48 89 e5             	mov    %rsp,%rbp
  8020ee:	48 83 ec 10          	sub    $0x10,%rsp
  8020f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8020f9:	eb 15                	jmp    802110 <close_all+0x26>
  8020fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020fe:	89 c7                	mov    %eax,%edi
  802100:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802107:	00 00 00 
  80210a:	ff d0                	callq  *%rax
  80210c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802110:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802114:	7e e5                	jle    8020fb <close_all+0x11>
  802116:	c9                   	leaveq 
  802117:	c3                   	retq   

0000000000802118 <dup>:
  802118:	55                   	push   %rbp
  802119:	48 89 e5             	mov    %rsp,%rbp
  80211c:	48 83 ec 40          	sub    $0x40,%rsp
  802120:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802123:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802126:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80212a:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80212d:	48 89 d6             	mov    %rdx,%rsi
  802130:	89 c7                	mov    %eax,%edi
  802132:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802139:	00 00 00 
  80213c:	ff d0                	callq  *%rax
  80213e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802141:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802145:	79 08                	jns    80214f <dup+0x37>
  802147:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80214a:	e9 70 01 00 00       	jmpq   8022bf <dup+0x1a7>
  80214f:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802152:	89 c7                	mov    %eax,%edi
  802154:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  80215b:	00 00 00 
  80215e:	ff d0                	callq  *%rax
  802160:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802163:	48 98                	cltq   
  802165:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80216b:	48 c1 e0 0c          	shl    $0xc,%rax
  80216f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802173:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802177:	48 89 c7             	mov    %rax,%rdi
  80217a:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  802181:	00 00 00 
  802184:	ff d0                	callq  *%rax
  802186:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80218a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80218e:	48 89 c7             	mov    %rax,%rdi
  802191:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  802198:	00 00 00 
  80219b:	ff d0                	callq  *%rax
  80219d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8021a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021a5:	48 c1 e8 15          	shr    $0x15,%rax
  8021a9:	48 89 c2             	mov    %rax,%rdx
  8021ac:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8021b3:	01 00 00 
  8021b6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021ba:	83 e0 01             	and    $0x1,%eax
  8021bd:	48 85 c0             	test   %rax,%rax
  8021c0:	74 73                	je     802235 <dup+0x11d>
  8021c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021c6:	48 c1 e8 0c          	shr    $0xc,%rax
  8021ca:	48 89 c2             	mov    %rax,%rdx
  8021cd:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021d4:	01 00 00 
  8021d7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021db:	83 e0 01             	and    $0x1,%eax
  8021de:	48 85 c0             	test   %rax,%rax
  8021e1:	74 52                	je     802235 <dup+0x11d>
  8021e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021e7:	48 c1 e8 0c          	shr    $0xc,%rax
  8021eb:	48 89 c2             	mov    %rax,%rdx
  8021ee:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021f5:	01 00 00 
  8021f8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021fc:	25 07 0e 00 00       	and    $0xe07,%eax
  802201:	89 c1                	mov    %eax,%ecx
  802203:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802207:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80220b:	41 89 c8             	mov    %ecx,%r8d
  80220e:	48 89 d1             	mov    %rdx,%rcx
  802211:	ba 00 00 00 00       	mov    $0x0,%edx
  802216:	48 89 c6             	mov    %rax,%rsi
  802219:	bf 00 00 00 00       	mov    $0x0,%edi
  80221e:	48 b8 19 1a 80 00 00 	movabs $0x801a19,%rax
  802225:	00 00 00 
  802228:	ff d0                	callq  *%rax
  80222a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80222d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802231:	79 02                	jns    802235 <dup+0x11d>
  802233:	eb 57                	jmp    80228c <dup+0x174>
  802235:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802239:	48 c1 e8 0c          	shr    $0xc,%rax
  80223d:	48 89 c2             	mov    %rax,%rdx
  802240:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802247:	01 00 00 
  80224a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80224e:	25 07 0e 00 00       	and    $0xe07,%eax
  802253:	89 c1                	mov    %eax,%ecx
  802255:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802259:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80225d:	41 89 c8             	mov    %ecx,%r8d
  802260:	48 89 d1             	mov    %rdx,%rcx
  802263:	ba 00 00 00 00       	mov    $0x0,%edx
  802268:	48 89 c6             	mov    %rax,%rsi
  80226b:	bf 00 00 00 00       	mov    $0x0,%edi
  802270:	48 b8 19 1a 80 00 00 	movabs $0x801a19,%rax
  802277:	00 00 00 
  80227a:	ff d0                	callq  *%rax
  80227c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80227f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802283:	79 02                	jns    802287 <dup+0x16f>
  802285:	eb 05                	jmp    80228c <dup+0x174>
  802287:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80228a:	eb 33                	jmp    8022bf <dup+0x1a7>
  80228c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802290:	48 89 c6             	mov    %rax,%rsi
  802293:	bf 00 00 00 00       	mov    $0x0,%edi
  802298:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  80229f:	00 00 00 
  8022a2:	ff d0                	callq  *%rax
  8022a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022a8:	48 89 c6             	mov    %rax,%rsi
  8022ab:	bf 00 00 00 00       	mov    $0x0,%edi
  8022b0:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  8022b7:	00 00 00 
  8022ba:	ff d0                	callq  *%rax
  8022bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022bf:	c9                   	leaveq 
  8022c0:	c3                   	retq   

00000000008022c1 <read>:
  8022c1:	55                   	push   %rbp
  8022c2:	48 89 e5             	mov    %rsp,%rbp
  8022c5:	48 83 ec 40          	sub    $0x40,%rsp
  8022c9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8022cc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8022d0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8022d4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8022d8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8022db:	48 89 d6             	mov    %rdx,%rsi
  8022de:	89 c7                	mov    %eax,%edi
  8022e0:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  8022e7:	00 00 00 
  8022ea:	ff d0                	callq  *%rax
  8022ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8022ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8022f3:	78 24                	js     802319 <read+0x58>
  8022f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022f9:	8b 00                	mov    (%rax),%eax
  8022fb:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8022ff:	48 89 d6             	mov    %rdx,%rsi
  802302:	89 c7                	mov    %eax,%edi
  802304:	48 b8 e8 1f 80 00 00 	movabs $0x801fe8,%rax
  80230b:	00 00 00 
  80230e:	ff d0                	callq  *%rax
  802310:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802313:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802317:	79 05                	jns    80231e <read+0x5d>
  802319:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80231c:	eb 76                	jmp    802394 <read+0xd3>
  80231e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802322:	8b 40 08             	mov    0x8(%rax),%eax
  802325:	83 e0 03             	and    $0x3,%eax
  802328:	83 f8 01             	cmp    $0x1,%eax
  80232b:	75 3a                	jne    802367 <read+0xa6>
  80232d:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802334:	00 00 00 
  802337:	48 8b 00             	mov    (%rax),%rax
  80233a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802340:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802343:	89 c6                	mov    %eax,%esi
  802345:	48 bf 37 4d 80 00 00 	movabs $0x804d37,%rdi
  80234c:	00 00 00 
  80234f:	b8 00 00 00 00       	mov    $0x0,%eax
  802354:	48 b9 e5 04 80 00 00 	movabs $0x8004e5,%rcx
  80235b:	00 00 00 
  80235e:	ff d1                	callq  *%rcx
  802360:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802365:	eb 2d                	jmp    802394 <read+0xd3>
  802367:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80236b:	48 8b 40 10          	mov    0x10(%rax),%rax
  80236f:	48 85 c0             	test   %rax,%rax
  802372:	75 07                	jne    80237b <read+0xba>
  802374:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802379:	eb 19                	jmp    802394 <read+0xd3>
  80237b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80237f:	48 8b 40 10          	mov    0x10(%rax),%rax
  802383:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802387:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80238b:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  80238f:	48 89 cf             	mov    %rcx,%rdi
  802392:	ff d0                	callq  *%rax
  802394:	c9                   	leaveq 
  802395:	c3                   	retq   

0000000000802396 <readn>:
  802396:	55                   	push   %rbp
  802397:	48 89 e5             	mov    %rsp,%rbp
  80239a:	48 83 ec 30          	sub    $0x30,%rsp
  80239e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8023a5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8023a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8023b0:	eb 49                	jmp    8023fb <readn+0x65>
  8023b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023b5:	48 98                	cltq   
  8023b7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8023bb:	48 29 c2             	sub    %rax,%rdx
  8023be:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023c1:	48 63 c8             	movslq %eax,%rcx
  8023c4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8023c8:	48 01 c1             	add    %rax,%rcx
  8023cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8023ce:	48 89 ce             	mov    %rcx,%rsi
  8023d1:	89 c7                	mov    %eax,%edi
  8023d3:	48 b8 c1 22 80 00 00 	movabs $0x8022c1,%rax
  8023da:	00 00 00 
  8023dd:	ff d0                	callq  *%rax
  8023df:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8023e2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8023e6:	79 05                	jns    8023ed <readn+0x57>
  8023e8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023eb:	eb 1c                	jmp    802409 <readn+0x73>
  8023ed:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8023f1:	75 02                	jne    8023f5 <readn+0x5f>
  8023f3:	eb 11                	jmp    802406 <readn+0x70>
  8023f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023f8:	01 45 fc             	add    %eax,-0x4(%rbp)
  8023fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023fe:	48 98                	cltq   
  802400:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802404:	72 ac                	jb     8023b2 <readn+0x1c>
  802406:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802409:	c9                   	leaveq 
  80240a:	c3                   	retq   

000000000080240b <write>:
  80240b:	55                   	push   %rbp
  80240c:	48 89 e5             	mov    %rsp,%rbp
  80240f:	48 83 ec 40          	sub    $0x40,%rsp
  802413:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802416:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80241a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80241e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802422:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802425:	48 89 d6             	mov    %rdx,%rsi
  802428:	89 c7                	mov    %eax,%edi
  80242a:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802431:	00 00 00 
  802434:	ff d0                	callq  *%rax
  802436:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802439:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80243d:	78 24                	js     802463 <write+0x58>
  80243f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802443:	8b 00                	mov    (%rax),%eax
  802445:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802449:	48 89 d6             	mov    %rdx,%rsi
  80244c:	89 c7                	mov    %eax,%edi
  80244e:	48 b8 e8 1f 80 00 00 	movabs $0x801fe8,%rax
  802455:	00 00 00 
  802458:	ff d0                	callq  *%rax
  80245a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80245d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802461:	79 05                	jns    802468 <write+0x5d>
  802463:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802466:	eb 75                	jmp    8024dd <write+0xd2>
  802468:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80246c:	8b 40 08             	mov    0x8(%rax),%eax
  80246f:	83 e0 03             	and    $0x3,%eax
  802472:	85 c0                	test   %eax,%eax
  802474:	75 3a                	jne    8024b0 <write+0xa5>
  802476:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80247d:	00 00 00 
  802480:	48 8b 00             	mov    (%rax),%rax
  802483:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802489:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80248c:	89 c6                	mov    %eax,%esi
  80248e:	48 bf 53 4d 80 00 00 	movabs $0x804d53,%rdi
  802495:	00 00 00 
  802498:	b8 00 00 00 00       	mov    $0x0,%eax
  80249d:	48 b9 e5 04 80 00 00 	movabs $0x8004e5,%rcx
  8024a4:	00 00 00 
  8024a7:	ff d1                	callq  *%rcx
  8024a9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024ae:	eb 2d                	jmp    8024dd <write+0xd2>
  8024b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024b4:	48 8b 40 18          	mov    0x18(%rax),%rax
  8024b8:	48 85 c0             	test   %rax,%rax
  8024bb:	75 07                	jne    8024c4 <write+0xb9>
  8024bd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8024c2:	eb 19                	jmp    8024dd <write+0xd2>
  8024c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024c8:	48 8b 40 18          	mov    0x18(%rax),%rax
  8024cc:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8024d0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8024d4:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8024d8:	48 89 cf             	mov    %rcx,%rdi
  8024db:	ff d0                	callq  *%rax
  8024dd:	c9                   	leaveq 
  8024de:	c3                   	retq   

00000000008024df <seek>:
  8024df:	55                   	push   %rbp
  8024e0:	48 89 e5             	mov    %rsp,%rbp
  8024e3:	48 83 ec 18          	sub    $0x18,%rsp
  8024e7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8024ea:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8024ed:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8024f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024f4:	48 89 d6             	mov    %rdx,%rsi
  8024f7:	89 c7                	mov    %eax,%edi
  8024f9:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802500:	00 00 00 
  802503:	ff d0                	callq  *%rax
  802505:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802508:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80250c:	79 05                	jns    802513 <seek+0x34>
  80250e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802511:	eb 0f                	jmp    802522 <seek+0x43>
  802513:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802517:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80251a:	89 50 04             	mov    %edx,0x4(%rax)
  80251d:	b8 00 00 00 00       	mov    $0x0,%eax
  802522:	c9                   	leaveq 
  802523:	c3                   	retq   

0000000000802524 <ftruncate>:
  802524:	55                   	push   %rbp
  802525:	48 89 e5             	mov    %rsp,%rbp
  802528:	48 83 ec 30          	sub    $0x30,%rsp
  80252c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80252f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802532:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802536:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802539:	48 89 d6             	mov    %rdx,%rsi
  80253c:	89 c7                	mov    %eax,%edi
  80253e:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802545:	00 00 00 
  802548:	ff d0                	callq  *%rax
  80254a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80254d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802551:	78 24                	js     802577 <ftruncate+0x53>
  802553:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802557:	8b 00                	mov    (%rax),%eax
  802559:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80255d:	48 89 d6             	mov    %rdx,%rsi
  802560:	89 c7                	mov    %eax,%edi
  802562:	48 b8 e8 1f 80 00 00 	movabs $0x801fe8,%rax
  802569:	00 00 00 
  80256c:	ff d0                	callq  *%rax
  80256e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802571:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802575:	79 05                	jns    80257c <ftruncate+0x58>
  802577:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80257a:	eb 72                	jmp    8025ee <ftruncate+0xca>
  80257c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802580:	8b 40 08             	mov    0x8(%rax),%eax
  802583:	83 e0 03             	and    $0x3,%eax
  802586:	85 c0                	test   %eax,%eax
  802588:	75 3a                	jne    8025c4 <ftruncate+0xa0>
  80258a:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802591:	00 00 00 
  802594:	48 8b 00             	mov    (%rax),%rax
  802597:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80259d:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8025a0:	89 c6                	mov    %eax,%esi
  8025a2:	48 bf 70 4d 80 00 00 	movabs $0x804d70,%rdi
  8025a9:	00 00 00 
  8025ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8025b1:	48 b9 e5 04 80 00 00 	movabs $0x8004e5,%rcx
  8025b8:	00 00 00 
  8025bb:	ff d1                	callq  *%rcx
  8025bd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8025c2:	eb 2a                	jmp    8025ee <ftruncate+0xca>
  8025c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025c8:	48 8b 40 30          	mov    0x30(%rax),%rax
  8025cc:	48 85 c0             	test   %rax,%rax
  8025cf:	75 07                	jne    8025d8 <ftruncate+0xb4>
  8025d1:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8025d6:	eb 16                	jmp    8025ee <ftruncate+0xca>
  8025d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025dc:	48 8b 40 30          	mov    0x30(%rax),%rax
  8025e0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8025e4:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8025e7:	89 ce                	mov    %ecx,%esi
  8025e9:	48 89 d7             	mov    %rdx,%rdi
  8025ec:	ff d0                	callq  *%rax
  8025ee:	c9                   	leaveq 
  8025ef:	c3                   	retq   

00000000008025f0 <fstat>:
  8025f0:	55                   	push   %rbp
  8025f1:	48 89 e5             	mov    %rsp,%rbp
  8025f4:	48 83 ec 30          	sub    $0x30,%rsp
  8025f8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8025fb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8025ff:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802603:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802606:	48 89 d6             	mov    %rdx,%rsi
  802609:	89 c7                	mov    %eax,%edi
  80260b:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802612:	00 00 00 
  802615:	ff d0                	callq  *%rax
  802617:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80261a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80261e:	78 24                	js     802644 <fstat+0x54>
  802620:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802624:	8b 00                	mov    (%rax),%eax
  802626:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80262a:	48 89 d6             	mov    %rdx,%rsi
  80262d:	89 c7                	mov    %eax,%edi
  80262f:	48 b8 e8 1f 80 00 00 	movabs $0x801fe8,%rax
  802636:	00 00 00 
  802639:	ff d0                	callq  *%rax
  80263b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80263e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802642:	79 05                	jns    802649 <fstat+0x59>
  802644:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802647:	eb 5e                	jmp    8026a7 <fstat+0xb7>
  802649:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80264d:	48 8b 40 28          	mov    0x28(%rax),%rax
  802651:	48 85 c0             	test   %rax,%rax
  802654:	75 07                	jne    80265d <fstat+0x6d>
  802656:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80265b:	eb 4a                	jmp    8026a7 <fstat+0xb7>
  80265d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802661:	c6 00 00             	movb   $0x0,(%rax)
  802664:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802668:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  80266f:	00 00 00 
  802672:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802676:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80267d:	00 00 00 
  802680:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802684:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802688:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  80268f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802693:	48 8b 40 28          	mov    0x28(%rax),%rax
  802697:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80269b:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  80269f:	48 89 ce             	mov    %rcx,%rsi
  8026a2:	48 89 d7             	mov    %rdx,%rdi
  8026a5:	ff d0                	callq  *%rax
  8026a7:	c9                   	leaveq 
  8026a8:	c3                   	retq   

00000000008026a9 <stat>:
  8026a9:	55                   	push   %rbp
  8026aa:	48 89 e5             	mov    %rsp,%rbp
  8026ad:	48 83 ec 20          	sub    $0x20,%rsp
  8026b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8026b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8026b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026bd:	be 00 00 00 00       	mov    $0x0,%esi
  8026c2:	48 89 c7             	mov    %rax,%rdi
  8026c5:	48 b8 97 27 80 00 00 	movabs $0x802797,%rax
  8026cc:	00 00 00 
  8026cf:	ff d0                	callq  *%rax
  8026d1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026d4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026d8:	79 05                	jns    8026df <stat+0x36>
  8026da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026dd:	eb 2f                	jmp    80270e <stat+0x65>
  8026df:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8026e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026e6:	48 89 d6             	mov    %rdx,%rsi
  8026e9:	89 c7                	mov    %eax,%edi
  8026eb:	48 b8 f0 25 80 00 00 	movabs $0x8025f0,%rax
  8026f2:	00 00 00 
  8026f5:	ff d0                	callq  *%rax
  8026f7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8026fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026fd:	89 c7                	mov    %eax,%edi
  8026ff:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802706:	00 00 00 
  802709:	ff d0                	callq  *%rax
  80270b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80270e:	c9                   	leaveq 
  80270f:	c3                   	retq   

0000000000802710 <fsipc>:
  802710:	55                   	push   %rbp
  802711:	48 89 e5             	mov    %rsp,%rbp
  802714:	48 83 ec 10          	sub    $0x10,%rsp
  802718:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80271b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80271f:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  802726:	00 00 00 
  802729:	8b 00                	mov    (%rax),%eax
  80272b:	85 c0                	test   %eax,%eax
  80272d:	75 1d                	jne    80274c <fsipc+0x3c>
  80272f:	bf 01 00 00 00       	mov    $0x1,%edi
  802734:	48 b8 3c 41 80 00 00 	movabs $0x80413c,%rax
  80273b:	00 00 00 
  80273e:	ff d0                	callq  *%rax
  802740:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  802747:	00 00 00 
  80274a:	89 02                	mov    %eax,(%rdx)
  80274c:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  802753:	00 00 00 
  802756:	8b 00                	mov    (%rax),%eax
  802758:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80275b:	b9 07 00 00 00       	mov    $0x7,%ecx
  802760:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802767:	00 00 00 
  80276a:	89 c7                	mov    %eax,%edi
  80276c:	48 b8 31 40 80 00 00 	movabs $0x804031,%rax
  802773:	00 00 00 
  802776:	ff d0                	callq  *%rax
  802778:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80277c:	ba 00 00 00 00       	mov    $0x0,%edx
  802781:	48 89 c6             	mov    %rax,%rsi
  802784:	bf 00 00 00 00       	mov    $0x0,%edi
  802789:	48 b8 70 3f 80 00 00 	movabs $0x803f70,%rax
  802790:	00 00 00 
  802793:	ff d0                	callq  *%rax
  802795:	c9                   	leaveq 
  802796:	c3                   	retq   

0000000000802797 <open>:
  802797:	55                   	push   %rbp
  802798:	48 89 e5             	mov    %rsp,%rbp
  80279b:	48 83 ec 20          	sub    $0x20,%rsp
  80279f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8027a3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8027a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027aa:	48 89 c7             	mov    %rax,%rdi
  8027ad:	48 b8 2e 10 80 00 00 	movabs $0x80102e,%rax
  8027b4:	00 00 00 
  8027b7:	ff d0                	callq  *%rax
  8027b9:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8027be:	7e 0a                	jle    8027ca <open+0x33>
  8027c0:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8027c5:	e9 a5 00 00 00       	jmpq   80286f <open+0xd8>
  8027ca:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8027ce:	48 89 c7             	mov    %rax,%rdi
  8027d1:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  8027d8:	00 00 00 
  8027db:	ff d0                	callq  *%rax
  8027dd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027e4:	79 08                	jns    8027ee <open+0x57>
  8027e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027e9:	e9 81 00 00 00       	jmpq   80286f <open+0xd8>
  8027ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027f2:	48 89 c6             	mov    %rax,%rsi
  8027f5:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  8027fc:	00 00 00 
  8027ff:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  802806:	00 00 00 
  802809:	ff d0                	callq  *%rax
  80280b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802812:	00 00 00 
  802815:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802818:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  80281e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802822:	48 89 c6             	mov    %rax,%rsi
  802825:	bf 01 00 00 00       	mov    $0x1,%edi
  80282a:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802831:	00 00 00 
  802834:	ff d0                	callq  *%rax
  802836:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802839:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80283d:	79 1d                	jns    80285c <open+0xc5>
  80283f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802843:	be 00 00 00 00       	mov    $0x0,%esi
  802848:	48 89 c7             	mov    %rax,%rdi
  80284b:	48 b8 1f 1f 80 00 00 	movabs $0x801f1f,%rax
  802852:	00 00 00 
  802855:	ff d0                	callq  *%rax
  802857:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80285a:	eb 13                	jmp    80286f <open+0xd8>
  80285c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802860:	48 89 c7             	mov    %rax,%rdi
  802863:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  80286a:	00 00 00 
  80286d:	ff d0                	callq  *%rax
  80286f:	c9                   	leaveq 
  802870:	c3                   	retq   

0000000000802871 <devfile_flush>:
  802871:	55                   	push   %rbp
  802872:	48 89 e5             	mov    %rsp,%rbp
  802875:	48 83 ec 10          	sub    $0x10,%rsp
  802879:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80287d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802881:	8b 50 0c             	mov    0xc(%rax),%edx
  802884:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80288b:	00 00 00 
  80288e:	89 10                	mov    %edx,(%rax)
  802890:	be 00 00 00 00       	mov    $0x0,%esi
  802895:	bf 06 00 00 00       	mov    $0x6,%edi
  80289a:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  8028a1:	00 00 00 
  8028a4:	ff d0                	callq  *%rax
  8028a6:	c9                   	leaveq 
  8028a7:	c3                   	retq   

00000000008028a8 <devfile_read>:
  8028a8:	55                   	push   %rbp
  8028a9:	48 89 e5             	mov    %rsp,%rbp
  8028ac:	48 83 ec 30          	sub    $0x30,%rsp
  8028b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8028b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8028b8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8028bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028c0:	8b 50 0c             	mov    0xc(%rax),%edx
  8028c3:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028ca:	00 00 00 
  8028cd:	89 10                	mov    %edx,(%rax)
  8028cf:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028d6:	00 00 00 
  8028d9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8028dd:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8028e1:	be 00 00 00 00       	mov    $0x0,%esi
  8028e6:	bf 03 00 00 00       	mov    $0x3,%edi
  8028eb:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  8028f2:	00 00 00 
  8028f5:	ff d0                	callq  *%rax
  8028f7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028fa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028fe:	79 08                	jns    802908 <devfile_read+0x60>
  802900:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802903:	e9 a4 00 00 00       	jmpq   8029ac <devfile_read+0x104>
  802908:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80290b:	48 98                	cltq   
  80290d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802911:	76 35                	jbe    802948 <devfile_read+0xa0>
  802913:	48 b9 96 4d 80 00 00 	movabs $0x804d96,%rcx
  80291a:	00 00 00 
  80291d:	48 ba 9d 4d 80 00 00 	movabs $0x804d9d,%rdx
  802924:	00 00 00 
  802927:	be 89 00 00 00       	mov    $0x89,%esi
  80292c:	48 bf b2 4d 80 00 00 	movabs $0x804db2,%rdi
  802933:	00 00 00 
  802936:	b8 00 00 00 00       	mov    $0x0,%eax
  80293b:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  802942:	00 00 00 
  802945:	41 ff d0             	callq  *%r8
  802948:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  80294f:	7e 35                	jle    802986 <devfile_read+0xde>
  802951:	48 b9 c0 4d 80 00 00 	movabs $0x804dc0,%rcx
  802958:	00 00 00 
  80295b:	48 ba 9d 4d 80 00 00 	movabs $0x804d9d,%rdx
  802962:	00 00 00 
  802965:	be 8a 00 00 00       	mov    $0x8a,%esi
  80296a:	48 bf b2 4d 80 00 00 	movabs $0x804db2,%rdi
  802971:	00 00 00 
  802974:	b8 00 00 00 00       	mov    $0x0,%eax
  802979:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  802980:	00 00 00 
  802983:	41 ff d0             	callq  *%r8
  802986:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802989:	48 63 d0             	movslq %eax,%rdx
  80298c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802990:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802997:	00 00 00 
  80299a:	48 89 c7             	mov    %rax,%rdi
  80299d:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  8029a4:	00 00 00 
  8029a7:	ff d0                	callq  *%rax
  8029a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029ac:	c9                   	leaveq 
  8029ad:	c3                   	retq   

00000000008029ae <devfile_write>:
  8029ae:	55                   	push   %rbp
  8029af:	48 89 e5             	mov    %rsp,%rbp
  8029b2:	48 83 ec 40          	sub    $0x40,%rsp
  8029b6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8029ba:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8029be:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8029c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8029c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8029ca:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8029d1:	00 
  8029d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029d6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8029da:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8029df:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8029e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029e7:	8b 50 0c             	mov    0xc(%rax),%edx
  8029ea:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8029f1:	00 00 00 
  8029f4:	89 10                	mov    %edx,(%rax)
  8029f6:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8029fd:	00 00 00 
  802a00:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802a04:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802a08:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802a0c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802a10:	48 89 c6             	mov    %rax,%rsi
  802a13:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  802a1a:	00 00 00 
  802a1d:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  802a24:	00 00 00 
  802a27:	ff d0                	callq  *%rax
  802a29:	be 00 00 00 00       	mov    $0x0,%esi
  802a2e:	bf 04 00 00 00       	mov    $0x4,%edi
  802a33:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802a3a:	00 00 00 
  802a3d:	ff d0                	callq  *%rax
  802a3f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802a42:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802a46:	79 05                	jns    802a4d <devfile_write+0x9f>
  802a48:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a4b:	eb 43                	jmp    802a90 <devfile_write+0xe2>
  802a4d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a50:	48 98                	cltq   
  802a52:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802a56:	76 35                	jbe    802a8d <devfile_write+0xdf>
  802a58:	48 b9 96 4d 80 00 00 	movabs $0x804d96,%rcx
  802a5f:	00 00 00 
  802a62:	48 ba 9d 4d 80 00 00 	movabs $0x804d9d,%rdx
  802a69:	00 00 00 
  802a6c:	be a8 00 00 00       	mov    $0xa8,%esi
  802a71:	48 bf b2 4d 80 00 00 	movabs $0x804db2,%rdi
  802a78:	00 00 00 
  802a7b:	b8 00 00 00 00       	mov    $0x0,%eax
  802a80:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  802a87:	00 00 00 
  802a8a:	41 ff d0             	callq  *%r8
  802a8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a90:	c9                   	leaveq 
  802a91:	c3                   	retq   

0000000000802a92 <devfile_stat>:
  802a92:	55                   	push   %rbp
  802a93:	48 89 e5             	mov    %rsp,%rbp
  802a96:	48 83 ec 20          	sub    $0x20,%rsp
  802a9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802a9e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802aa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802aa6:	8b 50 0c             	mov    0xc(%rax),%edx
  802aa9:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802ab0:	00 00 00 
  802ab3:	89 10                	mov    %edx,(%rax)
  802ab5:	be 00 00 00 00       	mov    $0x0,%esi
  802aba:	bf 05 00 00 00       	mov    $0x5,%edi
  802abf:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802ac6:	00 00 00 
  802ac9:	ff d0                	callq  *%rax
  802acb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ace:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ad2:	79 05                	jns    802ad9 <devfile_stat+0x47>
  802ad4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ad7:	eb 56                	jmp    802b2f <devfile_stat+0x9d>
  802ad9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802add:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  802ae4:	00 00 00 
  802ae7:	48 89 c7             	mov    %rax,%rdi
  802aea:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  802af1:	00 00 00 
  802af4:	ff d0                	callq  *%rax
  802af6:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802afd:	00 00 00 
  802b00:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  802b06:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b0a:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802b10:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b17:	00 00 00 
  802b1a:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802b20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802b24:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802b2a:	b8 00 00 00 00       	mov    $0x0,%eax
  802b2f:	c9                   	leaveq 
  802b30:	c3                   	retq   

0000000000802b31 <devfile_trunc>:
  802b31:	55                   	push   %rbp
  802b32:	48 89 e5             	mov    %rsp,%rbp
  802b35:	48 83 ec 10          	sub    $0x10,%rsp
  802b39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802b3d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b44:	8b 50 0c             	mov    0xc(%rax),%edx
  802b47:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b4e:	00 00 00 
  802b51:	89 10                	mov    %edx,(%rax)
  802b53:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802b5a:	00 00 00 
  802b5d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802b60:	89 50 04             	mov    %edx,0x4(%rax)
  802b63:	be 00 00 00 00       	mov    $0x0,%esi
  802b68:	bf 02 00 00 00       	mov    $0x2,%edi
  802b6d:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802b74:	00 00 00 
  802b77:	ff d0                	callq  *%rax
  802b79:	c9                   	leaveq 
  802b7a:	c3                   	retq   

0000000000802b7b <remove>:
  802b7b:	55                   	push   %rbp
  802b7c:	48 89 e5             	mov    %rsp,%rbp
  802b7f:	48 83 ec 10          	sub    $0x10,%rsp
  802b83:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b8b:	48 89 c7             	mov    %rax,%rdi
  802b8e:	48 b8 2e 10 80 00 00 	movabs $0x80102e,%rax
  802b95:	00 00 00 
  802b98:	ff d0                	callq  *%rax
  802b9a:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802b9f:	7e 07                	jle    802ba8 <remove+0x2d>
  802ba1:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802ba6:	eb 33                	jmp    802bdb <remove+0x60>
  802ba8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802bac:	48 89 c6             	mov    %rax,%rsi
  802baf:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802bb6:	00 00 00 
  802bb9:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  802bc0:	00 00 00 
  802bc3:	ff d0                	callq  *%rax
  802bc5:	be 00 00 00 00       	mov    $0x0,%esi
  802bca:	bf 07 00 00 00       	mov    $0x7,%edi
  802bcf:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802bd6:	00 00 00 
  802bd9:	ff d0                	callq  *%rax
  802bdb:	c9                   	leaveq 
  802bdc:	c3                   	retq   

0000000000802bdd <sync>:
  802bdd:	55                   	push   %rbp
  802bde:	48 89 e5             	mov    %rsp,%rbp
  802be1:	be 00 00 00 00       	mov    $0x0,%esi
  802be6:	bf 08 00 00 00       	mov    $0x8,%edi
  802beb:	48 b8 10 27 80 00 00 	movabs $0x802710,%rax
  802bf2:	00 00 00 
  802bf5:	ff d0                	callq  *%rax
  802bf7:	5d                   	pop    %rbp
  802bf8:	c3                   	retq   

0000000000802bf9 <copy>:
  802bf9:	55                   	push   %rbp
  802bfa:	48 89 e5             	mov    %rsp,%rbp
  802bfd:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802c04:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802c0b:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802c12:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802c19:	be 00 00 00 00       	mov    $0x0,%esi
  802c1e:	48 89 c7             	mov    %rax,%rdi
  802c21:	48 b8 97 27 80 00 00 	movabs $0x802797,%rax
  802c28:	00 00 00 
  802c2b:	ff d0                	callq  *%rax
  802c2d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c30:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c34:	79 28                	jns    802c5e <copy+0x65>
  802c36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c39:	89 c6                	mov    %eax,%esi
  802c3b:	48 bf cc 4d 80 00 00 	movabs $0x804dcc,%rdi
  802c42:	00 00 00 
  802c45:	b8 00 00 00 00       	mov    $0x0,%eax
  802c4a:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  802c51:	00 00 00 
  802c54:	ff d2                	callq  *%rdx
  802c56:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c59:	e9 74 01 00 00       	jmpq   802dd2 <copy+0x1d9>
  802c5e:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802c65:	be 01 01 00 00       	mov    $0x101,%esi
  802c6a:	48 89 c7             	mov    %rax,%rdi
  802c6d:	48 b8 97 27 80 00 00 	movabs $0x802797,%rax
  802c74:	00 00 00 
  802c77:	ff d0                	callq  *%rax
  802c79:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802c7c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802c80:	79 39                	jns    802cbb <copy+0xc2>
  802c82:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c85:	89 c6                	mov    %eax,%esi
  802c87:	48 bf e2 4d 80 00 00 	movabs $0x804de2,%rdi
  802c8e:	00 00 00 
  802c91:	b8 00 00 00 00       	mov    $0x0,%eax
  802c96:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  802c9d:	00 00 00 
  802ca0:	ff d2                	callq  *%rdx
  802ca2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ca5:	89 c7                	mov    %eax,%edi
  802ca7:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802cae:	00 00 00 
  802cb1:	ff d0                	callq  *%rax
  802cb3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802cb6:	e9 17 01 00 00       	jmpq   802dd2 <copy+0x1d9>
  802cbb:	eb 74                	jmp    802d31 <copy+0x138>
  802cbd:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802cc0:	48 63 d0             	movslq %eax,%rdx
  802cc3:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802cca:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802ccd:	48 89 ce             	mov    %rcx,%rsi
  802cd0:	89 c7                	mov    %eax,%edi
  802cd2:	48 b8 0b 24 80 00 00 	movabs $0x80240b,%rax
  802cd9:	00 00 00 
  802cdc:	ff d0                	callq  *%rax
  802cde:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802ce1:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802ce5:	79 4a                	jns    802d31 <copy+0x138>
  802ce7:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802cea:	89 c6                	mov    %eax,%esi
  802cec:	48 bf fc 4d 80 00 00 	movabs $0x804dfc,%rdi
  802cf3:	00 00 00 
  802cf6:	b8 00 00 00 00       	mov    $0x0,%eax
  802cfb:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  802d02:	00 00 00 
  802d05:	ff d2                	callq  *%rdx
  802d07:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d0a:	89 c7                	mov    %eax,%edi
  802d0c:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802d13:	00 00 00 
  802d16:	ff d0                	callq  *%rax
  802d18:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d1b:	89 c7                	mov    %eax,%edi
  802d1d:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802d24:	00 00 00 
  802d27:	ff d0                	callq  *%rax
  802d29:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802d2c:	e9 a1 00 00 00       	jmpq   802dd2 <copy+0x1d9>
  802d31:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802d38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d3b:	ba 00 02 00 00       	mov    $0x200,%edx
  802d40:	48 89 ce             	mov    %rcx,%rsi
  802d43:	89 c7                	mov    %eax,%edi
  802d45:	48 b8 c1 22 80 00 00 	movabs $0x8022c1,%rax
  802d4c:	00 00 00 
  802d4f:	ff d0                	callq  *%rax
  802d51:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802d54:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802d58:	0f 8f 5f ff ff ff    	jg     802cbd <copy+0xc4>
  802d5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802d62:	79 47                	jns    802dab <copy+0x1b2>
  802d64:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802d67:	89 c6                	mov    %eax,%esi
  802d69:	48 bf 0f 4e 80 00 00 	movabs $0x804e0f,%rdi
  802d70:	00 00 00 
  802d73:	b8 00 00 00 00       	mov    $0x0,%eax
  802d78:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  802d7f:	00 00 00 
  802d82:	ff d2                	callq  *%rdx
  802d84:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d87:	89 c7                	mov    %eax,%edi
  802d89:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802d90:	00 00 00 
  802d93:	ff d0                	callq  *%rax
  802d95:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802d98:	89 c7                	mov    %eax,%edi
  802d9a:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802da1:	00 00 00 
  802da4:	ff d0                	callq  *%rax
  802da6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802da9:	eb 27                	jmp    802dd2 <copy+0x1d9>
  802dab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dae:	89 c7                	mov    %eax,%edi
  802db0:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802db7:	00 00 00 
  802dba:	ff d0                	callq  *%rax
  802dbc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802dbf:	89 c7                	mov    %eax,%edi
  802dc1:	48 b8 9f 20 80 00 00 	movabs $0x80209f,%rax
  802dc8:	00 00 00 
  802dcb:	ff d0                	callq  *%rax
  802dcd:	b8 00 00 00 00       	mov    $0x0,%eax
  802dd2:	c9                   	leaveq 
  802dd3:	c3                   	retq   

0000000000802dd4 <fd2sockid>:
  802dd4:	55                   	push   %rbp
  802dd5:	48 89 e5             	mov    %rsp,%rbp
  802dd8:	48 83 ec 20          	sub    $0x20,%rsp
  802ddc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ddf:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802de3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802de6:	48 89 d6             	mov    %rdx,%rsi
  802de9:	89 c7                	mov    %eax,%edi
  802deb:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  802df2:	00 00 00 
  802df5:	ff d0                	callq  *%rax
  802df7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802dfa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dfe:	79 05                	jns    802e05 <fd2sockid+0x31>
  802e00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e03:	eb 24                	jmp    802e29 <fd2sockid+0x55>
  802e05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e09:	8b 10                	mov    (%rax),%edx
  802e0b:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  802e12:	00 00 00 
  802e15:	8b 00                	mov    (%rax),%eax
  802e17:	39 c2                	cmp    %eax,%edx
  802e19:	74 07                	je     802e22 <fd2sockid+0x4e>
  802e1b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802e20:	eb 07                	jmp    802e29 <fd2sockid+0x55>
  802e22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e26:	8b 40 0c             	mov    0xc(%rax),%eax
  802e29:	c9                   	leaveq 
  802e2a:	c3                   	retq   

0000000000802e2b <alloc_sockfd>:
  802e2b:	55                   	push   %rbp
  802e2c:	48 89 e5             	mov    %rsp,%rbp
  802e2f:	48 83 ec 20          	sub    $0x20,%rsp
  802e33:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802e36:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802e3a:	48 89 c7             	mov    %rax,%rdi
  802e3d:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  802e44:	00 00 00 
  802e47:	ff d0                	callq  *%rax
  802e49:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e50:	78 26                	js     802e78 <alloc_sockfd+0x4d>
  802e52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e56:	ba 07 04 00 00       	mov    $0x407,%edx
  802e5b:	48 89 c6             	mov    %rax,%rsi
  802e5e:	bf 00 00 00 00       	mov    $0x0,%edi
  802e63:	48 b8 c9 19 80 00 00 	movabs $0x8019c9,%rax
  802e6a:	00 00 00 
  802e6d:	ff d0                	callq  *%rax
  802e6f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e72:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e76:	79 16                	jns    802e8e <alloc_sockfd+0x63>
  802e78:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e7b:	89 c7                	mov    %eax,%edi
  802e7d:	48 b8 38 33 80 00 00 	movabs $0x803338,%rax
  802e84:	00 00 00 
  802e87:	ff d0                	callq  *%rax
  802e89:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e8c:	eb 3a                	jmp    802ec8 <alloc_sockfd+0x9d>
  802e8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e92:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  802e99:	00 00 00 
  802e9c:	8b 12                	mov    (%rdx),%edx
  802e9e:	89 10                	mov    %edx,(%rax)
  802ea0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ea4:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802eab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eaf:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802eb2:	89 50 0c             	mov    %edx,0xc(%rax)
  802eb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eb9:	48 89 c7             	mov    %rax,%rdi
  802ebc:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  802ec3:	00 00 00 
  802ec6:	ff d0                	callq  *%rax
  802ec8:	c9                   	leaveq 
  802ec9:	c3                   	retq   

0000000000802eca <accept>:
  802eca:	55                   	push   %rbp
  802ecb:	48 89 e5             	mov    %rsp,%rbp
  802ece:	48 83 ec 30          	sub    $0x30,%rsp
  802ed2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ed5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802ed9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802edd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802ee0:	89 c7                	mov    %eax,%edi
  802ee2:	48 b8 d4 2d 80 00 00 	movabs $0x802dd4,%rax
  802ee9:	00 00 00 
  802eec:	ff d0                	callq  *%rax
  802eee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ef1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ef5:	79 05                	jns    802efc <accept+0x32>
  802ef7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802efa:	eb 3b                	jmp    802f37 <accept+0x6d>
  802efc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802f00:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802f04:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f07:	48 89 ce             	mov    %rcx,%rsi
  802f0a:	89 c7                	mov    %eax,%edi
  802f0c:	48 b8 15 32 80 00 00 	movabs $0x803215,%rax
  802f13:	00 00 00 
  802f16:	ff d0                	callq  *%rax
  802f18:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f1b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f1f:	79 05                	jns    802f26 <accept+0x5c>
  802f21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f24:	eb 11                	jmp    802f37 <accept+0x6d>
  802f26:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f29:	89 c7                	mov    %eax,%edi
  802f2b:	48 b8 2b 2e 80 00 00 	movabs $0x802e2b,%rax
  802f32:	00 00 00 
  802f35:	ff d0                	callq  *%rax
  802f37:	c9                   	leaveq 
  802f38:	c3                   	retq   

0000000000802f39 <bind>:
  802f39:	55                   	push   %rbp
  802f3a:	48 89 e5             	mov    %rsp,%rbp
  802f3d:	48 83 ec 20          	sub    $0x20,%rsp
  802f41:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f44:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f48:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802f4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f4e:	89 c7                	mov    %eax,%edi
  802f50:	48 b8 d4 2d 80 00 00 	movabs $0x802dd4,%rax
  802f57:	00 00 00 
  802f5a:	ff d0                	callq  *%rax
  802f5c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f5f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f63:	79 05                	jns    802f6a <bind+0x31>
  802f65:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f68:	eb 1b                	jmp    802f85 <bind+0x4c>
  802f6a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802f6d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802f71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f74:	48 89 ce             	mov    %rcx,%rsi
  802f77:	89 c7                	mov    %eax,%edi
  802f79:	48 b8 94 32 80 00 00 	movabs $0x803294,%rax
  802f80:	00 00 00 
  802f83:	ff d0                	callq  *%rax
  802f85:	c9                   	leaveq 
  802f86:	c3                   	retq   

0000000000802f87 <shutdown>:
  802f87:	55                   	push   %rbp
  802f88:	48 89 e5             	mov    %rsp,%rbp
  802f8b:	48 83 ec 20          	sub    $0x20,%rsp
  802f8f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f92:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802f95:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f98:	89 c7                	mov    %eax,%edi
  802f9a:	48 b8 d4 2d 80 00 00 	movabs $0x802dd4,%rax
  802fa1:	00 00 00 
  802fa4:	ff d0                	callq  *%rax
  802fa6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fa9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fad:	79 05                	jns    802fb4 <shutdown+0x2d>
  802faf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fb2:	eb 16                	jmp    802fca <shutdown+0x43>
  802fb4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802fb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fba:	89 d6                	mov    %edx,%esi
  802fbc:	89 c7                	mov    %eax,%edi
  802fbe:	48 b8 f8 32 80 00 00 	movabs $0x8032f8,%rax
  802fc5:	00 00 00 
  802fc8:	ff d0                	callq  *%rax
  802fca:	c9                   	leaveq 
  802fcb:	c3                   	retq   

0000000000802fcc <devsock_close>:
  802fcc:	55                   	push   %rbp
  802fcd:	48 89 e5             	mov    %rsp,%rbp
  802fd0:	48 83 ec 10          	sub    $0x10,%rsp
  802fd4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fdc:	48 89 c7             	mov    %rax,%rdi
  802fdf:	48 b8 ae 41 80 00 00 	movabs $0x8041ae,%rax
  802fe6:	00 00 00 
  802fe9:	ff d0                	callq  *%rax
  802feb:	83 f8 01             	cmp    $0x1,%eax
  802fee:	75 17                	jne    803007 <devsock_close+0x3b>
  802ff0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ff4:	8b 40 0c             	mov    0xc(%rax),%eax
  802ff7:	89 c7                	mov    %eax,%edi
  802ff9:	48 b8 38 33 80 00 00 	movabs $0x803338,%rax
  803000:	00 00 00 
  803003:	ff d0                	callq  *%rax
  803005:	eb 05                	jmp    80300c <devsock_close+0x40>
  803007:	b8 00 00 00 00       	mov    $0x0,%eax
  80300c:	c9                   	leaveq 
  80300d:	c3                   	retq   

000000000080300e <connect>:
  80300e:	55                   	push   %rbp
  80300f:	48 89 e5             	mov    %rsp,%rbp
  803012:	48 83 ec 20          	sub    $0x20,%rsp
  803016:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803019:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80301d:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803020:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803023:	89 c7                	mov    %eax,%edi
  803025:	48 b8 d4 2d 80 00 00 	movabs $0x802dd4,%rax
  80302c:	00 00 00 
  80302f:	ff d0                	callq  *%rax
  803031:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803034:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803038:	79 05                	jns    80303f <connect+0x31>
  80303a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80303d:	eb 1b                	jmp    80305a <connect+0x4c>
  80303f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803042:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803046:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803049:	48 89 ce             	mov    %rcx,%rsi
  80304c:	89 c7                	mov    %eax,%edi
  80304e:	48 b8 65 33 80 00 00 	movabs $0x803365,%rax
  803055:	00 00 00 
  803058:	ff d0                	callq  *%rax
  80305a:	c9                   	leaveq 
  80305b:	c3                   	retq   

000000000080305c <listen>:
  80305c:	55                   	push   %rbp
  80305d:	48 89 e5             	mov    %rsp,%rbp
  803060:	48 83 ec 20          	sub    $0x20,%rsp
  803064:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803067:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80306a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80306d:	89 c7                	mov    %eax,%edi
  80306f:	48 b8 d4 2d 80 00 00 	movabs $0x802dd4,%rax
  803076:	00 00 00 
  803079:	ff d0                	callq  *%rax
  80307b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80307e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803082:	79 05                	jns    803089 <listen+0x2d>
  803084:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803087:	eb 16                	jmp    80309f <listen+0x43>
  803089:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80308c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80308f:	89 d6                	mov    %edx,%esi
  803091:	89 c7                	mov    %eax,%edi
  803093:	48 b8 c9 33 80 00 00 	movabs $0x8033c9,%rax
  80309a:	00 00 00 
  80309d:	ff d0                	callq  *%rax
  80309f:	c9                   	leaveq 
  8030a0:	c3                   	retq   

00000000008030a1 <devsock_read>:
  8030a1:	55                   	push   %rbp
  8030a2:	48 89 e5             	mov    %rsp,%rbp
  8030a5:	48 83 ec 20          	sub    $0x20,%rsp
  8030a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8030ad:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8030b1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8030b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030b9:	89 c2                	mov    %eax,%edx
  8030bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8030bf:	8b 40 0c             	mov    0xc(%rax),%eax
  8030c2:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8030c6:	b9 00 00 00 00       	mov    $0x0,%ecx
  8030cb:	89 c7                	mov    %eax,%edi
  8030cd:	48 b8 09 34 80 00 00 	movabs $0x803409,%rax
  8030d4:	00 00 00 
  8030d7:	ff d0                	callq  *%rax
  8030d9:	c9                   	leaveq 
  8030da:	c3                   	retq   

00000000008030db <devsock_write>:
  8030db:	55                   	push   %rbp
  8030dc:	48 89 e5             	mov    %rsp,%rbp
  8030df:	48 83 ec 20          	sub    $0x20,%rsp
  8030e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8030e7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8030eb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8030ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030f3:	89 c2                	mov    %eax,%edx
  8030f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8030f9:	8b 40 0c             	mov    0xc(%rax),%eax
  8030fc:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803100:	b9 00 00 00 00       	mov    $0x0,%ecx
  803105:	89 c7                	mov    %eax,%edi
  803107:	48 b8 d5 34 80 00 00 	movabs $0x8034d5,%rax
  80310e:	00 00 00 
  803111:	ff d0                	callq  *%rax
  803113:	c9                   	leaveq 
  803114:	c3                   	retq   

0000000000803115 <devsock_stat>:
  803115:	55                   	push   %rbp
  803116:	48 89 e5             	mov    %rsp,%rbp
  803119:	48 83 ec 10          	sub    $0x10,%rsp
  80311d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803121:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803125:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803129:	48 be 2a 4e 80 00 00 	movabs $0x804e2a,%rsi
  803130:	00 00 00 
  803133:	48 89 c7             	mov    %rax,%rdi
  803136:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  80313d:	00 00 00 
  803140:	ff d0                	callq  *%rax
  803142:	b8 00 00 00 00       	mov    $0x0,%eax
  803147:	c9                   	leaveq 
  803148:	c3                   	retq   

0000000000803149 <socket>:
  803149:	55                   	push   %rbp
  80314a:	48 89 e5             	mov    %rsp,%rbp
  80314d:	48 83 ec 20          	sub    $0x20,%rsp
  803151:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803154:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803157:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80315a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80315d:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803160:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803163:	89 ce                	mov    %ecx,%esi
  803165:	89 c7                	mov    %eax,%edi
  803167:	48 b8 8d 35 80 00 00 	movabs $0x80358d,%rax
  80316e:	00 00 00 
  803171:	ff d0                	callq  *%rax
  803173:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803176:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80317a:	79 05                	jns    803181 <socket+0x38>
  80317c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80317f:	eb 11                	jmp    803192 <socket+0x49>
  803181:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803184:	89 c7                	mov    %eax,%edi
  803186:	48 b8 2b 2e 80 00 00 	movabs $0x802e2b,%rax
  80318d:	00 00 00 
  803190:	ff d0                	callq  *%rax
  803192:	c9                   	leaveq 
  803193:	c3                   	retq   

0000000000803194 <nsipc>:
  803194:	55                   	push   %rbp
  803195:	48 89 e5             	mov    %rsp,%rbp
  803198:	48 83 ec 10          	sub    $0x10,%rsp
  80319c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80319f:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  8031a6:	00 00 00 
  8031a9:	8b 00                	mov    (%rax),%eax
  8031ab:	85 c0                	test   %eax,%eax
  8031ad:	75 1d                	jne    8031cc <nsipc+0x38>
  8031af:	bf 02 00 00 00       	mov    $0x2,%edi
  8031b4:	48 b8 3c 41 80 00 00 	movabs $0x80413c,%rax
  8031bb:	00 00 00 
  8031be:	ff d0                	callq  *%rax
  8031c0:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  8031c7:	00 00 00 
  8031ca:	89 02                	mov    %eax,(%rdx)
  8031cc:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  8031d3:	00 00 00 
  8031d6:	8b 00                	mov    (%rax),%eax
  8031d8:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8031db:	b9 07 00 00 00       	mov    $0x7,%ecx
  8031e0:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  8031e7:	00 00 00 
  8031ea:	89 c7                	mov    %eax,%edi
  8031ec:	48 b8 31 40 80 00 00 	movabs $0x804031,%rax
  8031f3:	00 00 00 
  8031f6:	ff d0                	callq  *%rax
  8031f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8031fd:	be 00 00 00 00       	mov    $0x0,%esi
  803202:	bf 00 00 00 00       	mov    $0x0,%edi
  803207:	48 b8 70 3f 80 00 00 	movabs $0x803f70,%rax
  80320e:	00 00 00 
  803211:	ff d0                	callq  *%rax
  803213:	c9                   	leaveq 
  803214:	c3                   	retq   

0000000000803215 <nsipc_accept>:
  803215:	55                   	push   %rbp
  803216:	48 89 e5             	mov    %rsp,%rbp
  803219:	48 83 ec 30          	sub    $0x30,%rsp
  80321d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803220:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803224:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803228:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80322f:	00 00 00 
  803232:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803235:	89 10                	mov    %edx,(%rax)
  803237:	bf 01 00 00 00       	mov    $0x1,%edi
  80323c:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  803243:	00 00 00 
  803246:	ff d0                	callq  *%rax
  803248:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80324b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80324f:	78 3e                	js     80328f <nsipc_accept+0x7a>
  803251:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803258:	00 00 00 
  80325b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80325f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803263:	8b 40 10             	mov    0x10(%rax),%eax
  803266:	89 c2                	mov    %eax,%edx
  803268:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80326c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803270:	48 89 ce             	mov    %rcx,%rsi
  803273:	48 89 c7             	mov    %rax,%rdi
  803276:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  80327d:	00 00 00 
  803280:	ff d0                	callq  *%rax
  803282:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803286:	8b 50 10             	mov    0x10(%rax),%edx
  803289:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80328d:	89 10                	mov    %edx,(%rax)
  80328f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803292:	c9                   	leaveq 
  803293:	c3                   	retq   

0000000000803294 <nsipc_bind>:
  803294:	55                   	push   %rbp
  803295:	48 89 e5             	mov    %rsp,%rbp
  803298:	48 83 ec 10          	sub    $0x10,%rsp
  80329c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80329f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8032a3:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8032a6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032ad:	00 00 00 
  8032b0:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8032b3:	89 10                	mov    %edx,(%rax)
  8032b5:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8032b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032bc:	48 89 c6             	mov    %rax,%rsi
  8032bf:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  8032c6:	00 00 00 
  8032c9:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  8032d0:	00 00 00 
  8032d3:	ff d0                	callq  *%rax
  8032d5:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032dc:	00 00 00 
  8032df:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8032e2:	89 50 14             	mov    %edx,0x14(%rax)
  8032e5:	bf 02 00 00 00       	mov    $0x2,%edi
  8032ea:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  8032f1:	00 00 00 
  8032f4:	ff d0                	callq  *%rax
  8032f6:	c9                   	leaveq 
  8032f7:	c3                   	retq   

00000000008032f8 <nsipc_shutdown>:
  8032f8:	55                   	push   %rbp
  8032f9:	48 89 e5             	mov    %rsp,%rbp
  8032fc:	48 83 ec 10          	sub    $0x10,%rsp
  803300:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803303:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803306:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80330d:	00 00 00 
  803310:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803313:	89 10                	mov    %edx,(%rax)
  803315:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80331c:	00 00 00 
  80331f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803322:	89 50 04             	mov    %edx,0x4(%rax)
  803325:	bf 03 00 00 00       	mov    $0x3,%edi
  80332a:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  803331:	00 00 00 
  803334:	ff d0                	callq  *%rax
  803336:	c9                   	leaveq 
  803337:	c3                   	retq   

0000000000803338 <nsipc_close>:
  803338:	55                   	push   %rbp
  803339:	48 89 e5             	mov    %rsp,%rbp
  80333c:	48 83 ec 10          	sub    $0x10,%rsp
  803340:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803343:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80334a:	00 00 00 
  80334d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803350:	89 10                	mov    %edx,(%rax)
  803352:	bf 04 00 00 00       	mov    $0x4,%edi
  803357:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  80335e:	00 00 00 
  803361:	ff d0                	callq  *%rax
  803363:	c9                   	leaveq 
  803364:	c3                   	retq   

0000000000803365 <nsipc_connect>:
  803365:	55                   	push   %rbp
  803366:	48 89 e5             	mov    %rsp,%rbp
  803369:	48 83 ec 10          	sub    $0x10,%rsp
  80336d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803370:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803374:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803377:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80337e:	00 00 00 
  803381:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803384:	89 10                	mov    %edx,(%rax)
  803386:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80338d:	48 89 c6             	mov    %rax,%rsi
  803390:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  803397:	00 00 00 
  80339a:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  8033a1:	00 00 00 
  8033a4:	ff d0                	callq  *%rax
  8033a6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033ad:	00 00 00 
  8033b0:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8033b3:	89 50 14             	mov    %edx,0x14(%rax)
  8033b6:	bf 05 00 00 00       	mov    $0x5,%edi
  8033bb:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  8033c2:	00 00 00 
  8033c5:	ff d0                	callq  *%rax
  8033c7:	c9                   	leaveq 
  8033c8:	c3                   	retq   

00000000008033c9 <nsipc_listen>:
  8033c9:	55                   	push   %rbp
  8033ca:	48 89 e5             	mov    %rsp,%rbp
  8033cd:	48 83 ec 10          	sub    $0x10,%rsp
  8033d1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8033d4:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8033d7:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033de:	00 00 00 
  8033e1:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8033e4:	89 10                	mov    %edx,(%rax)
  8033e6:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033ed:	00 00 00 
  8033f0:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8033f3:	89 50 04             	mov    %edx,0x4(%rax)
  8033f6:	bf 06 00 00 00       	mov    $0x6,%edi
  8033fb:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  803402:	00 00 00 
  803405:	ff d0                	callq  *%rax
  803407:	c9                   	leaveq 
  803408:	c3                   	retq   

0000000000803409 <nsipc_recv>:
  803409:	55                   	push   %rbp
  80340a:	48 89 e5             	mov    %rsp,%rbp
  80340d:	48 83 ec 30          	sub    $0x30,%rsp
  803411:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803414:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803418:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80341b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80341e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803425:	00 00 00 
  803428:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80342b:	89 10                	mov    %edx,(%rax)
  80342d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803434:	00 00 00 
  803437:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80343a:	89 50 04             	mov    %edx,0x4(%rax)
  80343d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803444:	00 00 00 
  803447:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80344a:	89 50 08             	mov    %edx,0x8(%rax)
  80344d:	bf 07 00 00 00       	mov    $0x7,%edi
  803452:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  803459:	00 00 00 
  80345c:	ff d0                	callq  *%rax
  80345e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803461:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803465:	78 69                	js     8034d0 <nsipc_recv+0xc7>
  803467:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  80346e:	7f 08                	jg     803478 <nsipc_recv+0x6f>
  803470:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803473:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803476:	7e 35                	jle    8034ad <nsipc_recv+0xa4>
  803478:	48 b9 31 4e 80 00 00 	movabs $0x804e31,%rcx
  80347f:	00 00 00 
  803482:	48 ba 46 4e 80 00 00 	movabs $0x804e46,%rdx
  803489:	00 00 00 
  80348c:	be 62 00 00 00       	mov    $0x62,%esi
  803491:	48 bf 5b 4e 80 00 00 	movabs $0x804e5b,%rdi
  803498:	00 00 00 
  80349b:	b8 00 00 00 00       	mov    $0x0,%eax
  8034a0:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  8034a7:	00 00 00 
  8034aa:	41 ff d0             	callq  *%r8
  8034ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034b0:	48 63 d0             	movslq %eax,%rdx
  8034b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8034b7:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  8034be:	00 00 00 
  8034c1:	48 89 c7             	mov    %rax,%rdi
  8034c4:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  8034cb:	00 00 00 
  8034ce:	ff d0                	callq  *%rax
  8034d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034d3:	c9                   	leaveq 
  8034d4:	c3                   	retq   

00000000008034d5 <nsipc_send>:
  8034d5:	55                   	push   %rbp
  8034d6:	48 89 e5             	mov    %rsp,%rbp
  8034d9:	48 83 ec 20          	sub    $0x20,%rsp
  8034dd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8034e0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8034e4:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8034e7:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8034ea:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8034f1:	00 00 00 
  8034f4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8034f7:	89 10                	mov    %edx,(%rax)
  8034f9:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803500:	7e 35                	jle    803537 <nsipc_send+0x62>
  803502:	48 b9 6a 4e 80 00 00 	movabs $0x804e6a,%rcx
  803509:	00 00 00 
  80350c:	48 ba 46 4e 80 00 00 	movabs $0x804e46,%rdx
  803513:	00 00 00 
  803516:	be 6d 00 00 00       	mov    $0x6d,%esi
  80351b:	48 bf 5b 4e 80 00 00 	movabs $0x804e5b,%rdi
  803522:	00 00 00 
  803525:	b8 00 00 00 00       	mov    $0x0,%eax
  80352a:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  803531:	00 00 00 
  803534:	41 ff d0             	callq  *%r8
  803537:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80353a:	48 63 d0             	movslq %eax,%rdx
  80353d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803541:	48 89 c6             	mov    %rax,%rsi
  803544:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  80354b:	00 00 00 
  80354e:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  803555:	00 00 00 
  803558:	ff d0                	callq  *%rax
  80355a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803561:	00 00 00 
  803564:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803567:	89 50 04             	mov    %edx,0x4(%rax)
  80356a:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803571:	00 00 00 
  803574:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803577:	89 50 08             	mov    %edx,0x8(%rax)
  80357a:	bf 08 00 00 00       	mov    $0x8,%edi
  80357f:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  803586:	00 00 00 
  803589:	ff d0                	callq  *%rax
  80358b:	c9                   	leaveq 
  80358c:	c3                   	retq   

000000000080358d <nsipc_socket>:
  80358d:	55                   	push   %rbp
  80358e:	48 89 e5             	mov    %rsp,%rbp
  803591:	48 83 ec 10          	sub    $0x10,%rsp
  803595:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803598:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80359b:	89 55 f4             	mov    %edx,-0xc(%rbp)
  80359e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8035a5:	00 00 00 
  8035a8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8035ab:	89 10                	mov    %edx,(%rax)
  8035ad:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8035b4:	00 00 00 
  8035b7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8035ba:	89 50 04             	mov    %edx,0x4(%rax)
  8035bd:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8035c4:	00 00 00 
  8035c7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8035ca:	89 50 08             	mov    %edx,0x8(%rax)
  8035cd:	bf 09 00 00 00       	mov    $0x9,%edi
  8035d2:	48 b8 94 31 80 00 00 	movabs $0x803194,%rax
  8035d9:	00 00 00 
  8035dc:	ff d0                	callq  *%rax
  8035de:	c9                   	leaveq 
  8035df:	c3                   	retq   

00000000008035e0 <pipe>:
  8035e0:	55                   	push   %rbp
  8035e1:	48 89 e5             	mov    %rsp,%rbp
  8035e4:	53                   	push   %rbx
  8035e5:	48 83 ec 38          	sub    $0x38,%rsp
  8035e9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8035ed:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8035f1:	48 89 c7             	mov    %rax,%rdi
  8035f4:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  8035fb:	00 00 00 
  8035fe:	ff d0                	callq  *%rax
  803600:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803603:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803607:	0f 88 bf 01 00 00    	js     8037cc <pipe+0x1ec>
  80360d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803611:	ba 07 04 00 00       	mov    $0x407,%edx
  803616:	48 89 c6             	mov    %rax,%rsi
  803619:	bf 00 00 00 00       	mov    $0x0,%edi
  80361e:	48 b8 c9 19 80 00 00 	movabs $0x8019c9,%rax
  803625:	00 00 00 
  803628:	ff d0                	callq  *%rax
  80362a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80362d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803631:	0f 88 95 01 00 00    	js     8037cc <pipe+0x1ec>
  803637:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80363b:	48 89 c7             	mov    %rax,%rdi
  80363e:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  803645:	00 00 00 
  803648:	ff d0                	callq  *%rax
  80364a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80364d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803651:	0f 88 5d 01 00 00    	js     8037b4 <pipe+0x1d4>
  803657:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80365b:	ba 07 04 00 00       	mov    $0x407,%edx
  803660:	48 89 c6             	mov    %rax,%rsi
  803663:	bf 00 00 00 00       	mov    $0x0,%edi
  803668:	48 b8 c9 19 80 00 00 	movabs $0x8019c9,%rax
  80366f:	00 00 00 
  803672:	ff d0                	callq  *%rax
  803674:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803677:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80367b:	0f 88 33 01 00 00    	js     8037b4 <pipe+0x1d4>
  803681:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803685:	48 89 c7             	mov    %rax,%rdi
  803688:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  80368f:	00 00 00 
  803692:	ff d0                	callq  *%rax
  803694:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803698:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80369c:	ba 07 04 00 00       	mov    $0x407,%edx
  8036a1:	48 89 c6             	mov    %rax,%rsi
  8036a4:	bf 00 00 00 00       	mov    $0x0,%edi
  8036a9:	48 b8 c9 19 80 00 00 	movabs $0x8019c9,%rax
  8036b0:	00 00 00 
  8036b3:	ff d0                	callq  *%rax
  8036b5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8036b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8036bc:	79 05                	jns    8036c3 <pipe+0xe3>
  8036be:	e9 d9 00 00 00       	jmpq   80379c <pipe+0x1bc>
  8036c3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8036c7:	48 89 c7             	mov    %rax,%rdi
  8036ca:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  8036d1:	00 00 00 
  8036d4:	ff d0                	callq  *%rax
  8036d6:	48 89 c2             	mov    %rax,%rdx
  8036d9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036dd:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8036e3:	48 89 d1             	mov    %rdx,%rcx
  8036e6:	ba 00 00 00 00       	mov    $0x0,%edx
  8036eb:	48 89 c6             	mov    %rax,%rsi
  8036ee:	bf 00 00 00 00       	mov    $0x0,%edi
  8036f3:	48 b8 19 1a 80 00 00 	movabs $0x801a19,%rax
  8036fa:	00 00 00 
  8036fd:	ff d0                	callq  *%rax
  8036ff:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803702:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803706:	79 1b                	jns    803723 <pipe+0x143>
  803708:	90                   	nop
  803709:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80370d:	48 89 c6             	mov    %rax,%rsi
  803710:	bf 00 00 00 00       	mov    $0x0,%edi
  803715:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  80371c:	00 00 00 
  80371f:	ff d0                	callq  *%rax
  803721:	eb 79                	jmp    80379c <pipe+0x1bc>
  803723:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803727:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  80372e:	00 00 00 
  803731:	8b 12                	mov    (%rdx),%edx
  803733:	89 10                	mov    %edx,(%rax)
  803735:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803739:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803740:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803744:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  80374b:	00 00 00 
  80374e:	8b 12                	mov    (%rdx),%edx
  803750:	89 10                	mov    %edx,(%rax)
  803752:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803756:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  80375d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803761:	48 89 c7             	mov    %rax,%rdi
  803764:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  80376b:	00 00 00 
  80376e:	ff d0                	callq  *%rax
  803770:	89 c2                	mov    %eax,%edx
  803772:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803776:	89 10                	mov    %edx,(%rax)
  803778:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80377c:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803780:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803784:	48 89 c7             	mov    %rax,%rdi
  803787:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  80378e:	00 00 00 
  803791:	ff d0                	callq  *%rax
  803793:	89 03                	mov    %eax,(%rbx)
  803795:	b8 00 00 00 00       	mov    $0x0,%eax
  80379a:	eb 33                	jmp    8037cf <pipe+0x1ef>
  80379c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8037a0:	48 89 c6             	mov    %rax,%rsi
  8037a3:	bf 00 00 00 00       	mov    $0x0,%edi
  8037a8:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  8037af:	00 00 00 
  8037b2:	ff d0                	callq  *%rax
  8037b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8037b8:	48 89 c6             	mov    %rax,%rsi
  8037bb:	bf 00 00 00 00       	mov    $0x0,%edi
  8037c0:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  8037c7:	00 00 00 
  8037ca:	ff d0                	callq  *%rax
  8037cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037cf:	48 83 c4 38          	add    $0x38,%rsp
  8037d3:	5b                   	pop    %rbx
  8037d4:	5d                   	pop    %rbp
  8037d5:	c3                   	retq   

00000000008037d6 <_pipeisclosed>:
  8037d6:	55                   	push   %rbp
  8037d7:	48 89 e5             	mov    %rsp,%rbp
  8037da:	53                   	push   %rbx
  8037db:	48 83 ec 28          	sub    $0x28,%rsp
  8037df:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8037e3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8037e7:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  8037ee:	00 00 00 
  8037f1:	48 8b 00             	mov    (%rax),%rax
  8037f4:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8037fa:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8037fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803801:	48 89 c7             	mov    %rax,%rdi
  803804:	48 b8 ae 41 80 00 00 	movabs $0x8041ae,%rax
  80380b:	00 00 00 
  80380e:	ff d0                	callq  *%rax
  803810:	89 c3                	mov    %eax,%ebx
  803812:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803816:	48 89 c7             	mov    %rax,%rdi
  803819:	48 b8 ae 41 80 00 00 	movabs $0x8041ae,%rax
  803820:	00 00 00 
  803823:	ff d0                	callq  *%rax
  803825:	39 c3                	cmp    %eax,%ebx
  803827:	0f 94 c0             	sete   %al
  80382a:	0f b6 c0             	movzbl %al,%eax
  80382d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803830:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  803837:	00 00 00 
  80383a:	48 8b 00             	mov    (%rax),%rax
  80383d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803843:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803846:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803849:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80384c:	75 05                	jne    803853 <_pipeisclosed+0x7d>
  80384e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803851:	eb 4f                	jmp    8038a2 <_pipeisclosed+0xcc>
  803853:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803856:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803859:	74 42                	je     80389d <_pipeisclosed+0xc7>
  80385b:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  80385f:	75 3c                	jne    80389d <_pipeisclosed+0xc7>
  803861:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  803868:	00 00 00 
  80386b:	48 8b 00             	mov    (%rax),%rax
  80386e:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803874:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803877:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80387a:	89 c6                	mov    %eax,%esi
  80387c:	48 bf 7b 4e 80 00 00 	movabs $0x804e7b,%rdi
  803883:	00 00 00 
  803886:	b8 00 00 00 00       	mov    $0x0,%eax
  80388b:	49 b8 e5 04 80 00 00 	movabs $0x8004e5,%r8
  803892:	00 00 00 
  803895:	41 ff d0             	callq  *%r8
  803898:	e9 4a ff ff ff       	jmpq   8037e7 <_pipeisclosed+0x11>
  80389d:	e9 45 ff ff ff       	jmpq   8037e7 <_pipeisclosed+0x11>
  8038a2:	48 83 c4 28          	add    $0x28,%rsp
  8038a6:	5b                   	pop    %rbx
  8038a7:	5d                   	pop    %rbp
  8038a8:	c3                   	retq   

00000000008038a9 <pipeisclosed>:
  8038a9:	55                   	push   %rbp
  8038aa:	48 89 e5             	mov    %rsp,%rbp
  8038ad:	48 83 ec 30          	sub    $0x30,%rsp
  8038b1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8038b4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8038b8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8038bb:	48 89 d6             	mov    %rdx,%rsi
  8038be:	89 c7                	mov    %eax,%edi
  8038c0:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  8038c7:	00 00 00 
  8038ca:	ff d0                	callq  *%rax
  8038cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038d3:	79 05                	jns    8038da <pipeisclosed+0x31>
  8038d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038d8:	eb 31                	jmp    80390b <pipeisclosed+0x62>
  8038da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038de:	48 89 c7             	mov    %rax,%rdi
  8038e1:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  8038e8:	00 00 00 
  8038eb:	ff d0                	callq  *%rax
  8038ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8038f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038f5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8038f9:	48 89 d6             	mov    %rdx,%rsi
  8038fc:	48 89 c7             	mov    %rax,%rdi
  8038ff:	48 b8 d6 37 80 00 00 	movabs $0x8037d6,%rax
  803906:	00 00 00 
  803909:	ff d0                	callq  *%rax
  80390b:	c9                   	leaveq 
  80390c:	c3                   	retq   

000000000080390d <devpipe_read>:
  80390d:	55                   	push   %rbp
  80390e:	48 89 e5             	mov    %rsp,%rbp
  803911:	48 83 ec 40          	sub    $0x40,%rsp
  803915:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803919:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80391d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803921:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803925:	48 89 c7             	mov    %rax,%rdi
  803928:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  80392f:	00 00 00 
  803932:	ff d0                	callq  *%rax
  803934:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803938:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80393c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803940:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803947:	00 
  803948:	e9 92 00 00 00       	jmpq   8039df <devpipe_read+0xd2>
  80394d:	eb 41                	jmp    803990 <devpipe_read+0x83>
  80394f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  803954:	74 09                	je     80395f <devpipe_read+0x52>
  803956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80395a:	e9 92 00 00 00       	jmpq   8039f1 <devpipe_read+0xe4>
  80395f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803963:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803967:	48 89 d6             	mov    %rdx,%rsi
  80396a:	48 89 c7             	mov    %rax,%rdi
  80396d:	48 b8 d6 37 80 00 00 	movabs $0x8037d6,%rax
  803974:	00 00 00 
  803977:	ff d0                	callq  *%rax
  803979:	85 c0                	test   %eax,%eax
  80397b:	74 07                	je     803984 <devpipe_read+0x77>
  80397d:	b8 00 00 00 00       	mov    $0x0,%eax
  803982:	eb 6d                	jmp    8039f1 <devpipe_read+0xe4>
  803984:	48 b8 8b 19 80 00 00 	movabs $0x80198b,%rax
  80398b:	00 00 00 
  80398e:	ff d0                	callq  *%rax
  803990:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803994:	8b 10                	mov    (%rax),%edx
  803996:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80399a:	8b 40 04             	mov    0x4(%rax),%eax
  80399d:	39 c2                	cmp    %eax,%edx
  80399f:	74 ae                	je     80394f <devpipe_read+0x42>
  8039a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039a5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8039a9:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8039ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039b1:	8b 00                	mov    (%rax),%eax
  8039b3:	99                   	cltd   
  8039b4:	c1 ea 1b             	shr    $0x1b,%edx
  8039b7:	01 d0                	add    %edx,%eax
  8039b9:	83 e0 1f             	and    $0x1f,%eax
  8039bc:	29 d0                	sub    %edx,%eax
  8039be:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8039c2:	48 98                	cltq   
  8039c4:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8039c9:	88 01                	mov    %al,(%rcx)
  8039cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039cf:	8b 00                	mov    (%rax),%eax
  8039d1:	8d 50 01             	lea    0x1(%rax),%edx
  8039d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039d8:	89 10                	mov    %edx,(%rax)
  8039da:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8039df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039e3:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8039e7:	0f 82 60 ff ff ff    	jb     80394d <devpipe_read+0x40>
  8039ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039f1:	c9                   	leaveq 
  8039f2:	c3                   	retq   

00000000008039f3 <devpipe_write>:
  8039f3:	55                   	push   %rbp
  8039f4:	48 89 e5             	mov    %rsp,%rbp
  8039f7:	48 83 ec 40          	sub    $0x40,%rsp
  8039fb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8039ff:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803a03:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803a07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a0b:	48 89 c7             	mov    %rax,%rdi
  803a0e:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  803a15:	00 00 00 
  803a18:	ff d0                	callq  *%rax
  803a1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803a1e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803a22:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803a26:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803a2d:	00 
  803a2e:	e9 8e 00 00 00       	jmpq   803ac1 <devpipe_write+0xce>
  803a33:	eb 31                	jmp    803a66 <devpipe_write+0x73>
  803a35:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803a39:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a3d:	48 89 d6             	mov    %rdx,%rsi
  803a40:	48 89 c7             	mov    %rax,%rdi
  803a43:	48 b8 d6 37 80 00 00 	movabs $0x8037d6,%rax
  803a4a:	00 00 00 
  803a4d:	ff d0                	callq  *%rax
  803a4f:	85 c0                	test   %eax,%eax
  803a51:	74 07                	je     803a5a <devpipe_write+0x67>
  803a53:	b8 00 00 00 00       	mov    $0x0,%eax
  803a58:	eb 79                	jmp    803ad3 <devpipe_write+0xe0>
  803a5a:	48 b8 8b 19 80 00 00 	movabs $0x80198b,%rax
  803a61:	00 00 00 
  803a64:	ff d0                	callq  *%rax
  803a66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a6a:	8b 40 04             	mov    0x4(%rax),%eax
  803a6d:	48 63 d0             	movslq %eax,%rdx
  803a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a74:	8b 00                	mov    (%rax),%eax
  803a76:	48 98                	cltq   
  803a78:	48 83 c0 20          	add    $0x20,%rax
  803a7c:	48 39 c2             	cmp    %rax,%rdx
  803a7f:	73 b4                	jae    803a35 <devpipe_write+0x42>
  803a81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a85:	8b 40 04             	mov    0x4(%rax),%eax
  803a88:	99                   	cltd   
  803a89:	c1 ea 1b             	shr    $0x1b,%edx
  803a8c:	01 d0                	add    %edx,%eax
  803a8e:	83 e0 1f             	and    $0x1f,%eax
  803a91:	29 d0                	sub    %edx,%eax
  803a93:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803a97:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803a9b:	48 01 ca             	add    %rcx,%rdx
  803a9e:	0f b6 0a             	movzbl (%rdx),%ecx
  803aa1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803aa5:	48 98                	cltq   
  803aa7:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803aab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803aaf:	8b 40 04             	mov    0x4(%rax),%eax
  803ab2:	8d 50 01             	lea    0x1(%rax),%edx
  803ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ab9:	89 50 04             	mov    %edx,0x4(%rax)
  803abc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ac5:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803ac9:	0f 82 64 ff ff ff    	jb     803a33 <devpipe_write+0x40>
  803acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ad3:	c9                   	leaveq 
  803ad4:	c3                   	retq   

0000000000803ad5 <devpipe_stat>:
  803ad5:	55                   	push   %rbp
  803ad6:	48 89 e5             	mov    %rsp,%rbp
  803ad9:	48 83 ec 20          	sub    $0x20,%rsp
  803add:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803ae1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803ae5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803ae9:	48 89 c7             	mov    %rax,%rdi
  803aec:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  803af3:	00 00 00 
  803af6:	ff d0                	callq  *%rax
  803af8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803afc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b00:	48 be 8e 4e 80 00 00 	movabs $0x804e8e,%rsi
  803b07:	00 00 00 
  803b0a:	48 89 c7             	mov    %rax,%rdi
  803b0d:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  803b14:	00 00 00 
  803b17:	ff d0                	callq  *%rax
  803b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b1d:	8b 50 04             	mov    0x4(%rax),%edx
  803b20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b24:	8b 00                	mov    (%rax),%eax
  803b26:	29 c2                	sub    %eax,%edx
  803b28:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b2c:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803b32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b36:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803b3d:	00 00 00 
  803b40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b44:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  803b4b:	00 00 00 
  803b4e:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  803b55:	b8 00 00 00 00       	mov    $0x0,%eax
  803b5a:	c9                   	leaveq 
  803b5b:	c3                   	retq   

0000000000803b5c <devpipe_close>:
  803b5c:	55                   	push   %rbp
  803b5d:	48 89 e5             	mov    %rsp,%rbp
  803b60:	48 83 ec 10          	sub    $0x10,%rsp
  803b64:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b6c:	48 89 c6             	mov    %rax,%rsi
  803b6f:	bf 00 00 00 00       	mov    $0x0,%edi
  803b74:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  803b7b:	00 00 00 
  803b7e:	ff d0                	callq  *%rax
  803b80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b84:	48 89 c7             	mov    %rax,%rdi
  803b87:	48 b8 cc 1d 80 00 00 	movabs $0x801dcc,%rax
  803b8e:	00 00 00 
  803b91:	ff d0                	callq  *%rax
  803b93:	48 89 c6             	mov    %rax,%rsi
  803b96:	bf 00 00 00 00       	mov    $0x0,%edi
  803b9b:	48 b8 74 1a 80 00 00 	movabs $0x801a74,%rax
  803ba2:	00 00 00 
  803ba5:	ff d0                	callq  *%rax
  803ba7:	c9                   	leaveq 
  803ba8:	c3                   	retq   

0000000000803ba9 <cputchar>:
  803ba9:	55                   	push   %rbp
  803baa:	48 89 e5             	mov    %rsp,%rbp
  803bad:	48 83 ec 20          	sub    $0x20,%rsp
  803bb1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803bb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803bb7:	88 45 ff             	mov    %al,-0x1(%rbp)
  803bba:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  803bbe:	be 01 00 00 00       	mov    $0x1,%esi
  803bc3:	48 89 c7             	mov    %rax,%rdi
  803bc6:	48 b8 81 18 80 00 00 	movabs $0x801881,%rax
  803bcd:	00 00 00 
  803bd0:	ff d0                	callq  *%rax
  803bd2:	c9                   	leaveq 
  803bd3:	c3                   	retq   

0000000000803bd4 <getchar>:
  803bd4:	55                   	push   %rbp
  803bd5:	48 89 e5             	mov    %rsp,%rbp
  803bd8:	48 83 ec 10          	sub    $0x10,%rsp
  803bdc:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  803be0:	ba 01 00 00 00       	mov    $0x1,%edx
  803be5:	48 89 c6             	mov    %rax,%rsi
  803be8:	bf 00 00 00 00       	mov    $0x0,%edi
  803bed:	48 b8 c1 22 80 00 00 	movabs $0x8022c1,%rax
  803bf4:	00 00 00 
  803bf7:	ff d0                	callq  *%rax
  803bf9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bfc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c00:	79 05                	jns    803c07 <getchar+0x33>
  803c02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c05:	eb 14                	jmp    803c1b <getchar+0x47>
  803c07:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c0b:	7f 07                	jg     803c14 <getchar+0x40>
  803c0d:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  803c12:	eb 07                	jmp    803c1b <getchar+0x47>
  803c14:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  803c18:	0f b6 c0             	movzbl %al,%eax
  803c1b:	c9                   	leaveq 
  803c1c:	c3                   	retq   

0000000000803c1d <iscons>:
  803c1d:	55                   	push   %rbp
  803c1e:	48 89 e5             	mov    %rsp,%rbp
  803c21:	48 83 ec 20          	sub    $0x20,%rsp
  803c25:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c28:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803c2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c2f:	48 89 d6             	mov    %rdx,%rsi
  803c32:	89 c7                	mov    %eax,%edi
  803c34:	48 b8 8f 1e 80 00 00 	movabs $0x801e8f,%rax
  803c3b:	00 00 00 
  803c3e:	ff d0                	callq  *%rax
  803c40:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c43:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c47:	79 05                	jns    803c4e <iscons+0x31>
  803c49:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c4c:	eb 1a                	jmp    803c68 <iscons+0x4b>
  803c4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c52:	8b 10                	mov    (%rax),%edx
  803c54:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  803c5b:	00 00 00 
  803c5e:	8b 00                	mov    (%rax),%eax
  803c60:	39 c2                	cmp    %eax,%edx
  803c62:	0f 94 c0             	sete   %al
  803c65:	0f b6 c0             	movzbl %al,%eax
  803c68:	c9                   	leaveq 
  803c69:	c3                   	retq   

0000000000803c6a <opencons>:
  803c6a:	55                   	push   %rbp
  803c6b:	48 89 e5             	mov    %rsp,%rbp
  803c6e:	48 83 ec 10          	sub    $0x10,%rsp
  803c72:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803c76:	48 89 c7             	mov    %rax,%rdi
  803c79:	48 b8 f7 1d 80 00 00 	movabs $0x801df7,%rax
  803c80:	00 00 00 
  803c83:	ff d0                	callq  *%rax
  803c85:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c88:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c8c:	79 05                	jns    803c93 <opencons+0x29>
  803c8e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c91:	eb 5b                	jmp    803cee <opencons+0x84>
  803c93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c97:	ba 07 04 00 00       	mov    $0x407,%edx
  803c9c:	48 89 c6             	mov    %rax,%rsi
  803c9f:	bf 00 00 00 00       	mov    $0x0,%edi
  803ca4:	48 b8 c9 19 80 00 00 	movabs $0x8019c9,%rax
  803cab:	00 00 00 
  803cae:	ff d0                	callq  *%rax
  803cb0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803cb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803cb7:	79 05                	jns    803cbe <opencons+0x54>
  803cb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cbc:	eb 30                	jmp    803cee <opencons+0x84>
  803cbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cc2:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  803cc9:	00 00 00 
  803ccc:	8b 12                	mov    (%rdx),%edx
  803cce:	89 10                	mov    %edx,(%rax)
  803cd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cd4:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803cdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cdf:	48 89 c7             	mov    %rax,%rdi
  803ce2:	48 b8 a9 1d 80 00 00 	movabs $0x801da9,%rax
  803ce9:	00 00 00 
  803cec:	ff d0                	callq  *%rax
  803cee:	c9                   	leaveq 
  803cef:	c3                   	retq   

0000000000803cf0 <devcons_read>:
  803cf0:	55                   	push   %rbp
  803cf1:	48 89 e5             	mov    %rsp,%rbp
  803cf4:	48 83 ec 30          	sub    $0x30,%rsp
  803cf8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803cfc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803d00:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803d04:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803d09:	75 07                	jne    803d12 <devcons_read+0x22>
  803d0b:	b8 00 00 00 00       	mov    $0x0,%eax
  803d10:	eb 4b                	jmp    803d5d <devcons_read+0x6d>
  803d12:	eb 0c                	jmp    803d20 <devcons_read+0x30>
  803d14:	48 b8 8b 19 80 00 00 	movabs $0x80198b,%rax
  803d1b:	00 00 00 
  803d1e:	ff d0                	callq  *%rax
  803d20:	48 b8 cb 18 80 00 00 	movabs $0x8018cb,%rax
  803d27:	00 00 00 
  803d2a:	ff d0                	callq  *%rax
  803d2c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d2f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d33:	74 df                	je     803d14 <devcons_read+0x24>
  803d35:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d39:	79 05                	jns    803d40 <devcons_read+0x50>
  803d3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d3e:	eb 1d                	jmp    803d5d <devcons_read+0x6d>
  803d40:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  803d44:	75 07                	jne    803d4d <devcons_read+0x5d>
  803d46:	b8 00 00 00 00       	mov    $0x0,%eax
  803d4b:	eb 10                	jmp    803d5d <devcons_read+0x6d>
  803d4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d50:	89 c2                	mov    %eax,%edx
  803d52:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803d56:	88 10                	mov    %dl,(%rax)
  803d58:	b8 01 00 00 00       	mov    $0x1,%eax
  803d5d:	c9                   	leaveq 
  803d5e:	c3                   	retq   

0000000000803d5f <devcons_write>:
  803d5f:	55                   	push   %rbp
  803d60:	48 89 e5             	mov    %rsp,%rbp
  803d63:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  803d6a:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  803d71:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  803d78:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  803d7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803d86:	eb 76                	jmp    803dfe <devcons_write+0x9f>
  803d88:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  803d8f:	89 c2                	mov    %eax,%edx
  803d91:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d94:	29 c2                	sub    %eax,%edx
  803d96:	89 d0                	mov    %edx,%eax
  803d98:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803d9b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d9e:	83 f8 7f             	cmp    $0x7f,%eax
  803da1:	76 07                	jbe    803daa <devcons_write+0x4b>
  803da3:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  803daa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803dad:	48 63 d0             	movslq %eax,%rdx
  803db0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803db3:	48 63 c8             	movslq %eax,%rcx
  803db6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  803dbd:	48 01 c1             	add    %rax,%rcx
  803dc0:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803dc7:	48 89 ce             	mov    %rcx,%rsi
  803dca:	48 89 c7             	mov    %rax,%rdi
  803dcd:	48 b8 be 13 80 00 00 	movabs $0x8013be,%rax
  803dd4:	00 00 00 
  803dd7:	ff d0                	callq  *%rax
  803dd9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803ddc:	48 63 d0             	movslq %eax,%rdx
  803ddf:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803de6:	48 89 d6             	mov    %rdx,%rsi
  803de9:	48 89 c7             	mov    %rax,%rdi
  803dec:	48 b8 81 18 80 00 00 	movabs $0x801881,%rax
  803df3:	00 00 00 
  803df6:	ff d0                	callq  *%rax
  803df8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803dfb:	01 45 fc             	add    %eax,-0x4(%rbp)
  803dfe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e01:	48 98                	cltq   
  803e03:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  803e0a:	0f 82 78 ff ff ff    	jb     803d88 <devcons_write+0x29>
  803e10:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e13:	c9                   	leaveq 
  803e14:	c3                   	retq   

0000000000803e15 <devcons_close>:
  803e15:	55                   	push   %rbp
  803e16:	48 89 e5             	mov    %rsp,%rbp
  803e19:	48 83 ec 08          	sub    $0x8,%rsp
  803e1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803e21:	b8 00 00 00 00       	mov    $0x0,%eax
  803e26:	c9                   	leaveq 
  803e27:	c3                   	retq   

0000000000803e28 <devcons_stat>:
  803e28:	55                   	push   %rbp
  803e29:	48 89 e5             	mov    %rsp,%rbp
  803e2c:	48 83 ec 10          	sub    $0x10,%rsp
  803e30:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803e34:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803e38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e3c:	48 be 9a 4e 80 00 00 	movabs $0x804e9a,%rsi
  803e43:	00 00 00 
  803e46:	48 89 c7             	mov    %rax,%rdi
  803e49:	48 b8 9a 10 80 00 00 	movabs $0x80109a,%rax
  803e50:	00 00 00 
  803e53:	ff d0                	callq  *%rax
  803e55:	b8 00 00 00 00       	mov    $0x0,%eax
  803e5a:	c9                   	leaveq 
  803e5b:	c3                   	retq   

0000000000803e5c <_panic>:
  803e5c:	55                   	push   %rbp
  803e5d:	48 89 e5             	mov    %rsp,%rbp
  803e60:	53                   	push   %rbx
  803e61:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803e68:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  803e6f:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  803e75:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  803e7c:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  803e83:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  803e8a:	84 c0                	test   %al,%al
  803e8c:	74 23                	je     803eb1 <_panic+0x55>
  803e8e:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  803e95:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  803e99:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  803e9d:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  803ea1:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  803ea5:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  803ea9:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  803ead:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  803eb1:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  803eb8:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  803ebf:	00 00 00 
  803ec2:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  803ec9:	00 00 00 
  803ecc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803ed0:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  803ed7:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  803ede:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803ee5:	48 b8 08 60 80 00 00 	movabs $0x806008,%rax
  803eec:	00 00 00 
  803eef:	48 8b 18             	mov    (%rax),%rbx
  803ef2:	48 b8 4d 19 80 00 00 	movabs $0x80194d,%rax
  803ef9:	00 00 00 
  803efc:	ff d0                	callq  *%rax
  803efe:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  803f04:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803f0b:	41 89 c8             	mov    %ecx,%r8d
  803f0e:	48 89 d1             	mov    %rdx,%rcx
  803f11:	48 89 da             	mov    %rbx,%rdx
  803f14:	89 c6                	mov    %eax,%esi
  803f16:	48 bf a8 4e 80 00 00 	movabs $0x804ea8,%rdi
  803f1d:	00 00 00 
  803f20:	b8 00 00 00 00       	mov    $0x0,%eax
  803f25:	49 b9 e5 04 80 00 00 	movabs $0x8004e5,%r9
  803f2c:	00 00 00 
  803f2f:	41 ff d1             	callq  *%r9
  803f32:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  803f39:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803f40:	48 89 d6             	mov    %rdx,%rsi
  803f43:	48 89 c7             	mov    %rax,%rdi
  803f46:	48 b8 39 04 80 00 00 	movabs $0x800439,%rax
  803f4d:	00 00 00 
  803f50:	ff d0                	callq  *%rax
  803f52:	48 bf cb 4e 80 00 00 	movabs $0x804ecb,%rdi
  803f59:	00 00 00 
  803f5c:	b8 00 00 00 00       	mov    $0x0,%eax
  803f61:	48 ba e5 04 80 00 00 	movabs $0x8004e5,%rdx
  803f68:	00 00 00 
  803f6b:	ff d2                	callq  *%rdx
  803f6d:	cc                   	int3   
  803f6e:	eb fd                	jmp    803f6d <_panic+0x111>

0000000000803f70 <ipc_recv>:
  803f70:	55                   	push   %rbp
  803f71:	48 89 e5             	mov    %rsp,%rbp
  803f74:	48 83 ec 30          	sub    $0x30,%rsp
  803f78:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f7c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f80:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803f84:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803f89:	75 0e                	jne    803f99 <ipc_recv+0x29>
  803f8b:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803f92:	00 00 00 
  803f95:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803f99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f9d:	48 89 c7             	mov    %rax,%rdi
  803fa0:	48 b8 f2 1b 80 00 00 	movabs $0x801bf2,%rax
  803fa7:	00 00 00 
  803faa:	ff d0                	callq  *%rax
  803fac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803faf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803fb3:	79 27                	jns    803fdc <ipc_recv+0x6c>
  803fb5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803fba:	74 0a                	je     803fc6 <ipc_recv+0x56>
  803fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803fc0:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803fc6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803fcb:	74 0a                	je     803fd7 <ipc_recv+0x67>
  803fcd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fd1:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803fd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fda:	eb 53                	jmp    80402f <ipc_recv+0xbf>
  803fdc:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803fe1:	74 19                	je     803ffc <ipc_recv+0x8c>
  803fe3:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  803fea:	00 00 00 
  803fed:	48 8b 00             	mov    (%rax),%rax
  803ff0:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  803ff6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803ffa:	89 10                	mov    %edx,(%rax)
  803ffc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804001:	74 19                	je     80401c <ipc_recv+0xac>
  804003:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80400a:	00 00 00 
  80400d:	48 8b 00             	mov    (%rax),%rax
  804010:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  804016:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80401a:	89 10                	mov    %edx,(%rax)
  80401c:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  804023:	00 00 00 
  804026:	48 8b 00             	mov    (%rax),%rax
  804029:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  80402f:	c9                   	leaveq 
  804030:	c3                   	retq   

0000000000804031 <ipc_send>:
  804031:	55                   	push   %rbp
  804032:	48 89 e5             	mov    %rsp,%rbp
  804035:	48 83 ec 30          	sub    $0x30,%rsp
  804039:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80403c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80403f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804043:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804046:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80404b:	75 10                	jne    80405d <ipc_send+0x2c>
  80404d:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  804054:	00 00 00 
  804057:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80405b:	eb 0e                	jmp    80406b <ipc_send+0x3a>
  80405d:	eb 0c                	jmp    80406b <ipc_send+0x3a>
  80405f:	48 b8 8b 19 80 00 00 	movabs $0x80198b,%rax
  804066:	00 00 00 
  804069:	ff d0                	callq  *%rax
  80406b:	8b 75 e8             	mov    -0x18(%rbp),%esi
  80406e:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  804071:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804075:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804078:	89 c7                	mov    %eax,%edi
  80407a:	48 b8 9d 1b 80 00 00 	movabs $0x801b9d,%rax
  804081:	00 00 00 
  804084:	ff d0                	callq  *%rax
  804086:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804089:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  80408d:	74 d0                	je     80405f <ipc_send+0x2e>
  80408f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804093:	79 30                	jns    8040c5 <ipc_send+0x94>
  804095:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804098:	89 c1                	mov    %eax,%ecx
  80409a:	48 ba d0 4e 80 00 00 	movabs $0x804ed0,%rdx
  8040a1:	00 00 00 
  8040a4:	be 44 00 00 00       	mov    $0x44,%esi
  8040a9:	48 bf e6 4e 80 00 00 	movabs $0x804ee6,%rdi
  8040b0:	00 00 00 
  8040b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8040b8:	49 b8 5c 3e 80 00 00 	movabs $0x803e5c,%r8
  8040bf:	00 00 00 
  8040c2:	41 ff d0             	callq  *%r8
  8040c5:	c9                   	leaveq 
  8040c6:	c3                   	retq   

00000000008040c7 <ipc_host_recv>:
  8040c7:	55                   	push   %rbp
  8040c8:	48 89 e5             	mov    %rsp,%rbp
  8040cb:	48 83 ec 10          	sub    $0x10,%rsp
  8040cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8040d3:	48 ba f8 4e 80 00 00 	movabs $0x804ef8,%rdx
  8040da:	00 00 00 
  8040dd:	be 4e 00 00 00       	mov    $0x4e,%esi
  8040e2:	48 bf e6 4e 80 00 00 	movabs $0x804ee6,%rdi
  8040e9:	00 00 00 
  8040ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8040f1:	48 b9 5c 3e 80 00 00 	movabs $0x803e5c,%rcx
  8040f8:	00 00 00 
  8040fb:	ff d1                	callq  *%rcx

00000000008040fd <ipc_host_send>:
  8040fd:	55                   	push   %rbp
  8040fe:	48 89 e5             	mov    %rsp,%rbp
  804101:	48 83 ec 20          	sub    $0x20,%rsp
  804105:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804108:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80410b:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80410f:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804112:	48 ba 18 4f 80 00 00 	movabs $0x804f18,%rdx
  804119:	00 00 00 
  80411c:	be 67 00 00 00       	mov    $0x67,%esi
  804121:	48 bf e6 4e 80 00 00 	movabs $0x804ee6,%rdi
  804128:	00 00 00 
  80412b:	b8 00 00 00 00       	mov    $0x0,%eax
  804130:	48 b9 5c 3e 80 00 00 	movabs $0x803e5c,%rcx
  804137:	00 00 00 
  80413a:	ff d1                	callq  *%rcx

000000000080413c <ipc_find_env>:
  80413c:	55                   	push   %rbp
  80413d:	48 89 e5             	mov    %rsp,%rbp
  804140:	48 83 ec 14          	sub    $0x14,%rsp
  804144:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804147:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80414e:	eb 4e                	jmp    80419e <ipc_find_env+0x62>
  804150:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804157:	00 00 00 
  80415a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80415d:	48 98                	cltq   
  80415f:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804166:	48 01 d0             	add    %rdx,%rax
  804169:	48 05 d0 00 00 00    	add    $0xd0,%rax
  80416f:	8b 00                	mov    (%rax),%eax
  804171:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804174:	75 24                	jne    80419a <ipc_find_env+0x5e>
  804176:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80417d:	00 00 00 
  804180:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804183:	48 98                	cltq   
  804185:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80418c:	48 01 d0             	add    %rdx,%rax
  80418f:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804195:	8b 40 08             	mov    0x8(%rax),%eax
  804198:	eb 12                	jmp    8041ac <ipc_find_env+0x70>
  80419a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80419e:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8041a5:	7e a9                	jle    804150 <ipc_find_env+0x14>
  8041a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8041ac:	c9                   	leaveq 
  8041ad:	c3                   	retq   

00000000008041ae <pageref>:
  8041ae:	55                   	push   %rbp
  8041af:	48 89 e5             	mov    %rsp,%rbp
  8041b2:	48 83 ec 18          	sub    $0x18,%rsp
  8041b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8041ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8041be:	48 c1 e8 15          	shr    $0x15,%rax
  8041c2:	48 89 c2             	mov    %rax,%rdx
  8041c5:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8041cc:	01 00 00 
  8041cf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8041d3:	83 e0 01             	and    $0x1,%eax
  8041d6:	48 85 c0             	test   %rax,%rax
  8041d9:	75 07                	jne    8041e2 <pageref+0x34>
  8041db:	b8 00 00 00 00       	mov    $0x0,%eax
  8041e0:	eb 53                	jmp    804235 <pageref+0x87>
  8041e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8041e6:	48 c1 e8 0c          	shr    $0xc,%rax
  8041ea:	48 89 c2             	mov    %rax,%rdx
  8041ed:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8041f4:	01 00 00 
  8041f7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8041fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8041ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804203:	83 e0 01             	and    $0x1,%eax
  804206:	48 85 c0             	test   %rax,%rax
  804209:	75 07                	jne    804212 <pageref+0x64>
  80420b:	b8 00 00 00 00       	mov    $0x0,%eax
  804210:	eb 23                	jmp    804235 <pageref+0x87>
  804212:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804216:	48 c1 e8 0c          	shr    $0xc,%rax
  80421a:	48 89 c2             	mov    %rax,%rdx
  80421d:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804224:	00 00 00 
  804227:	48 c1 e2 04          	shl    $0x4,%rdx
  80422b:	48 01 d0             	add    %rdx,%rax
  80422e:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804232:	0f b7 c0             	movzwl %ax,%eax
  804235:	c9                   	leaveq 
  804236:	c3                   	retq   

0000000000804237 <inet_addr>:
  804237:	55                   	push   %rbp
  804238:	48 89 e5             	mov    %rsp,%rbp
  80423b:	48 83 ec 20          	sub    $0x20,%rsp
  80423f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804243:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804247:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80424b:	48 89 d6             	mov    %rdx,%rsi
  80424e:	48 89 c7             	mov    %rax,%rdi
  804251:	48 b8 6d 42 80 00 00 	movabs $0x80426d,%rax
  804258:	00 00 00 
  80425b:	ff d0                	callq  *%rax
  80425d:	85 c0                	test   %eax,%eax
  80425f:	74 05                	je     804266 <inet_addr+0x2f>
  804261:	8b 45 f0             	mov    -0x10(%rbp),%eax
  804264:	eb 05                	jmp    80426b <inet_addr+0x34>
  804266:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  80426b:	c9                   	leaveq 
  80426c:	c3                   	retq   

000000000080426d <inet_aton>:
  80426d:	55                   	push   %rbp
  80426e:	48 89 e5             	mov    %rsp,%rbp
  804271:	48 83 ec 40          	sub    $0x40,%rsp
  804275:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  804279:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  80427d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804281:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804285:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804289:	0f b6 00             	movzbl (%rax),%eax
  80428c:	0f be c0             	movsbl %al,%eax
  80428f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  804292:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804295:	3c 2f                	cmp    $0x2f,%al
  804297:	76 07                	jbe    8042a0 <inet_aton+0x33>
  804299:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80429c:	3c 39                	cmp    $0x39,%al
  80429e:	76 0a                	jbe    8042aa <inet_aton+0x3d>
  8042a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8042a5:	e9 68 02 00 00       	jmpq   804512 <inet_aton+0x2a5>
  8042aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8042b1:	c7 45 f8 0a 00 00 00 	movl   $0xa,-0x8(%rbp)
  8042b8:	83 7d f4 30          	cmpl   $0x30,-0xc(%rbp)
  8042bc:	75 40                	jne    8042fe <inet_aton+0x91>
  8042be:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  8042c3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8042c7:	0f b6 00             	movzbl (%rax),%eax
  8042ca:	0f be c0             	movsbl %al,%eax
  8042cd:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8042d0:	83 7d f4 78          	cmpl   $0x78,-0xc(%rbp)
  8042d4:	74 06                	je     8042dc <inet_aton+0x6f>
  8042d6:	83 7d f4 58          	cmpl   $0x58,-0xc(%rbp)
  8042da:	75 1b                	jne    8042f7 <inet_aton+0x8a>
  8042dc:	c7 45 f8 10 00 00 00 	movl   $0x10,-0x8(%rbp)
  8042e3:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  8042e8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8042ec:	0f b6 00             	movzbl (%rax),%eax
  8042ef:	0f be c0             	movsbl %al,%eax
  8042f2:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8042f5:	eb 07                	jmp    8042fe <inet_aton+0x91>
  8042f7:	c7 45 f8 08 00 00 00 	movl   $0x8,-0x8(%rbp)
  8042fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804301:	3c 2f                	cmp    $0x2f,%al
  804303:	76 2f                	jbe    804334 <inet_aton+0xc7>
  804305:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804308:	3c 39                	cmp    $0x39,%al
  80430a:	77 28                	ja     804334 <inet_aton+0xc7>
  80430c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80430f:	0f af 45 fc          	imul   -0x4(%rbp),%eax
  804313:	89 c2                	mov    %eax,%edx
  804315:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804318:	01 d0                	add    %edx,%eax
  80431a:	83 e8 30             	sub    $0x30,%eax
  80431d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804320:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  804325:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804329:	0f b6 00             	movzbl (%rax),%eax
  80432c:	0f be c0             	movsbl %al,%eax
  80432f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  804332:	eb ca                	jmp    8042fe <inet_aton+0x91>
  804334:	83 7d f8 10          	cmpl   $0x10,-0x8(%rbp)
  804338:	75 72                	jne    8043ac <inet_aton+0x13f>
  80433a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80433d:	3c 2f                	cmp    $0x2f,%al
  80433f:	76 07                	jbe    804348 <inet_aton+0xdb>
  804341:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804344:	3c 39                	cmp    $0x39,%al
  804346:	76 1c                	jbe    804364 <inet_aton+0xf7>
  804348:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80434b:	3c 60                	cmp    $0x60,%al
  80434d:	76 07                	jbe    804356 <inet_aton+0xe9>
  80434f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804352:	3c 66                	cmp    $0x66,%al
  804354:	76 0e                	jbe    804364 <inet_aton+0xf7>
  804356:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804359:	3c 40                	cmp    $0x40,%al
  80435b:	76 4f                	jbe    8043ac <inet_aton+0x13f>
  80435d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804360:	3c 46                	cmp    $0x46,%al
  804362:	77 48                	ja     8043ac <inet_aton+0x13f>
  804364:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804367:	c1 e0 04             	shl    $0x4,%eax
  80436a:	89 c2                	mov    %eax,%edx
  80436c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80436f:	8d 48 0a             	lea    0xa(%rax),%ecx
  804372:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804375:	3c 60                	cmp    $0x60,%al
  804377:	76 0e                	jbe    804387 <inet_aton+0x11a>
  804379:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80437c:	3c 7a                	cmp    $0x7a,%al
  80437e:	77 07                	ja     804387 <inet_aton+0x11a>
  804380:	b8 61 00 00 00       	mov    $0x61,%eax
  804385:	eb 05                	jmp    80438c <inet_aton+0x11f>
  804387:	b8 41 00 00 00       	mov    $0x41,%eax
  80438c:	29 c1                	sub    %eax,%ecx
  80438e:	89 c8                	mov    %ecx,%eax
  804390:	09 d0                	or     %edx,%eax
  804392:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804395:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  80439a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80439e:	0f b6 00             	movzbl (%rax),%eax
  8043a1:	0f be c0             	movsbl %al,%eax
  8043a4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8043a7:	e9 52 ff ff ff       	jmpq   8042fe <inet_aton+0x91>
  8043ac:	83 7d f4 2e          	cmpl   $0x2e,-0xc(%rbp)
  8043b0:	75 40                	jne    8043f2 <inet_aton+0x185>
  8043b2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8043b6:	48 83 c0 0c          	add    $0xc,%rax
  8043ba:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
  8043be:	72 0a                	jb     8043ca <inet_aton+0x15d>
  8043c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8043c5:	e9 48 01 00 00       	jmpq   804512 <inet_aton+0x2a5>
  8043ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8043ce:	48 8d 50 04          	lea    0x4(%rax),%rdx
  8043d2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8043d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8043d9:	89 10                	mov    %edx,(%rax)
  8043db:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  8043e0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8043e4:	0f b6 00             	movzbl (%rax),%eax
  8043e7:	0f be c0             	movsbl %al,%eax
  8043ea:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8043ed:	e9 a0 fe ff ff       	jmpq   804292 <inet_aton+0x25>
  8043f2:	90                   	nop
  8043f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  8043f7:	74 3c                	je     804435 <inet_aton+0x1c8>
  8043f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8043fc:	3c 1f                	cmp    $0x1f,%al
  8043fe:	76 2b                	jbe    80442b <inet_aton+0x1be>
  804400:	8b 45 f4             	mov    -0xc(%rbp),%eax
  804403:	84 c0                	test   %al,%al
  804405:	78 24                	js     80442b <inet_aton+0x1be>
  804407:	83 7d f4 20          	cmpl   $0x20,-0xc(%rbp)
  80440b:	74 28                	je     804435 <inet_aton+0x1c8>
  80440d:	83 7d f4 0c          	cmpl   $0xc,-0xc(%rbp)
  804411:	74 22                	je     804435 <inet_aton+0x1c8>
  804413:	83 7d f4 0a          	cmpl   $0xa,-0xc(%rbp)
  804417:	74 1c                	je     804435 <inet_aton+0x1c8>
  804419:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
  80441d:	74 16                	je     804435 <inet_aton+0x1c8>
  80441f:	83 7d f4 09          	cmpl   $0x9,-0xc(%rbp)
  804423:	74 10                	je     804435 <inet_aton+0x1c8>
  804425:	83 7d f4 0b          	cmpl   $0xb,-0xc(%rbp)
  804429:	74 0a                	je     804435 <inet_aton+0x1c8>
  80442b:	b8 00 00 00 00       	mov    $0x0,%eax
  804430:	e9 dd 00 00 00       	jmpq   804512 <inet_aton+0x2a5>
  804435:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804439:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80443d:	48 29 c2             	sub    %rax,%rdx
  804440:	48 89 d0             	mov    %rdx,%rax
  804443:	48 c1 f8 02          	sar    $0x2,%rax
  804447:	83 c0 01             	add    $0x1,%eax
  80444a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80444d:	83 7d e4 04          	cmpl   $0x4,-0x1c(%rbp)
  804451:	0f 87 98 00 00 00    	ja     8044ef <inet_aton+0x282>
  804457:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80445a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  804461:	00 
  804462:	48 b8 38 4f 80 00 00 	movabs $0x804f38,%rax
  804469:	00 00 00 
  80446c:	48 01 d0             	add    %rdx,%rax
  80446f:	48 8b 00             	mov    (%rax),%rax
  804472:	ff e0                	jmpq   *%rax
  804474:	b8 00 00 00 00       	mov    $0x0,%eax
  804479:	e9 94 00 00 00       	jmpq   804512 <inet_aton+0x2a5>
  80447e:	81 7d fc ff ff ff 00 	cmpl   $0xffffff,-0x4(%rbp)
  804485:	76 0a                	jbe    804491 <inet_aton+0x224>
  804487:	b8 00 00 00 00       	mov    $0x0,%eax
  80448c:	e9 81 00 00 00       	jmpq   804512 <inet_aton+0x2a5>
  804491:	8b 45 d0             	mov    -0x30(%rbp),%eax
  804494:	c1 e0 18             	shl    $0x18,%eax
  804497:	09 45 fc             	or     %eax,-0x4(%rbp)
  80449a:	eb 53                	jmp    8044ef <inet_aton+0x282>
  80449c:	81 7d fc ff ff 00 00 	cmpl   $0xffff,-0x4(%rbp)
  8044a3:	76 07                	jbe    8044ac <inet_aton+0x23f>
  8044a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8044aa:	eb 66                	jmp    804512 <inet_aton+0x2a5>
  8044ac:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8044af:	c1 e0 18             	shl    $0x18,%eax
  8044b2:	89 c2                	mov    %eax,%edx
  8044b4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8044b7:	c1 e0 10             	shl    $0x10,%eax
  8044ba:	09 d0                	or     %edx,%eax
  8044bc:	09 45 fc             	or     %eax,-0x4(%rbp)
  8044bf:	eb 2e                	jmp    8044ef <inet_aton+0x282>
  8044c1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
  8044c8:	76 07                	jbe    8044d1 <inet_aton+0x264>
  8044ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8044cf:	eb 41                	jmp    804512 <inet_aton+0x2a5>
  8044d1:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8044d4:	c1 e0 18             	shl    $0x18,%eax
  8044d7:	89 c2                	mov    %eax,%edx
  8044d9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8044dc:	c1 e0 10             	shl    $0x10,%eax
  8044df:	09 c2                	or     %eax,%edx
  8044e1:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8044e4:	c1 e0 08             	shl    $0x8,%eax
  8044e7:	09 d0                	or     %edx,%eax
  8044e9:	09 45 fc             	or     %eax,-0x4(%rbp)
  8044ec:	eb 01                	jmp    8044ef <inet_aton+0x282>
  8044ee:	90                   	nop
  8044ef:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  8044f4:	74 17                	je     80450d <inet_aton+0x2a0>
  8044f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044f9:	89 c7                	mov    %eax,%edi
  8044fb:	48 b8 8b 46 80 00 00 	movabs $0x80468b,%rax
  804502:	00 00 00 
  804505:	ff d0                	callq  *%rax
  804507:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80450b:	89 02                	mov    %eax,(%rdx)
  80450d:	b8 01 00 00 00       	mov    $0x1,%eax
  804512:	c9                   	leaveq 
  804513:	c3                   	retq   

0000000000804514 <inet_ntoa>:
  804514:	55                   	push   %rbp
  804515:	48 89 e5             	mov    %rsp,%rbp
  804518:	48 83 ec 30          	sub    $0x30,%rsp
  80451c:	89 7d d0             	mov    %edi,-0x30(%rbp)
  80451f:	8b 45 d0             	mov    -0x30(%rbp),%eax
  804522:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804525:	48 b8 10 70 80 00 00 	movabs $0x807010,%rax
  80452c:	00 00 00 
  80452f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804533:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  804537:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80453b:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  80453f:	e9 e0 00 00 00       	jmpq   804624 <inet_ntoa+0x110>
  804544:	c6 45 ee 00          	movb   $0x0,-0x12(%rbp)
  804548:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80454c:	0f b6 08             	movzbl (%rax),%ecx
  80454f:	0f b6 d1             	movzbl %cl,%edx
  804552:	89 d0                	mov    %edx,%eax
  804554:	c1 e0 02             	shl    $0x2,%eax
  804557:	01 d0                	add    %edx,%eax
  804559:	c1 e0 03             	shl    $0x3,%eax
  80455c:	01 d0                	add    %edx,%eax
  80455e:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
  804565:	01 d0                	add    %edx,%eax
  804567:	66 c1 e8 08          	shr    $0x8,%ax
  80456b:	c0 e8 03             	shr    $0x3,%al
  80456e:	88 45 ed             	mov    %al,-0x13(%rbp)
  804571:	0f b6 55 ed          	movzbl -0x13(%rbp),%edx
  804575:	89 d0                	mov    %edx,%eax
  804577:	c1 e0 02             	shl    $0x2,%eax
  80457a:	01 d0                	add    %edx,%eax
  80457c:	01 c0                	add    %eax,%eax
  80457e:	29 c1                	sub    %eax,%ecx
  804580:	89 c8                	mov    %ecx,%eax
  804582:	88 45 ed             	mov    %al,-0x13(%rbp)
  804585:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804589:	0f b6 00             	movzbl (%rax),%eax
  80458c:	0f b6 d0             	movzbl %al,%edx
  80458f:	89 d0                	mov    %edx,%eax
  804591:	c1 e0 02             	shl    $0x2,%eax
  804594:	01 d0                	add    %edx,%eax
  804596:	c1 e0 03             	shl    $0x3,%eax
  804599:	01 d0                	add    %edx,%eax
  80459b:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
  8045a2:	01 d0                	add    %edx,%eax
  8045a4:	66 c1 e8 08          	shr    $0x8,%ax
  8045a8:	89 c2                	mov    %eax,%edx
  8045aa:	c0 ea 03             	shr    $0x3,%dl
  8045ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045b1:	88 10                	mov    %dl,(%rax)
  8045b3:	0f b6 45 ee          	movzbl -0x12(%rbp),%eax
  8045b7:	8d 50 01             	lea    0x1(%rax),%edx
  8045ba:	88 55 ee             	mov    %dl,-0x12(%rbp)
  8045bd:	0f b6 c0             	movzbl %al,%eax
  8045c0:	0f b6 55 ed          	movzbl -0x13(%rbp),%edx
  8045c4:	83 c2 30             	add    $0x30,%edx
  8045c7:	48 98                	cltq   
  8045c9:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  8045cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045d1:	0f b6 00             	movzbl (%rax),%eax
  8045d4:	84 c0                	test   %al,%al
  8045d6:	0f 85 6c ff ff ff    	jne    804548 <inet_ntoa+0x34>
  8045dc:	eb 1a                	jmp    8045f8 <inet_ntoa+0xe4>
  8045de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045e2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8045e6:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
  8045ea:	0f b6 55 ee          	movzbl -0x12(%rbp),%edx
  8045ee:	48 63 d2             	movslq %edx,%rdx
  8045f1:	0f b6 54 15 e0       	movzbl -0x20(%rbp,%rdx,1),%edx
  8045f6:	88 10                	mov    %dl,(%rax)
  8045f8:	0f b6 45 ee          	movzbl -0x12(%rbp),%eax
  8045fc:	8d 50 ff             	lea    -0x1(%rax),%edx
  8045ff:	88 55 ee             	mov    %dl,-0x12(%rbp)
  804602:	84 c0                	test   %al,%al
  804604:	75 d8                	jne    8045de <inet_ntoa+0xca>
  804606:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80460a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80460e:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
  804612:	c6 00 2e             	movb   $0x2e,(%rax)
  804615:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80461a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80461e:	83 c0 01             	add    $0x1,%eax
  804621:	88 45 ef             	mov    %al,-0x11(%rbp)
  804624:	80 7d ef 03          	cmpb   $0x3,-0x11(%rbp)
  804628:	0f 86 16 ff ff ff    	jbe    804544 <inet_ntoa+0x30>
  80462e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  804633:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804637:	c6 00 00             	movb   $0x0,(%rax)
  80463a:	48 b8 10 70 80 00 00 	movabs $0x807010,%rax
  804641:	00 00 00 
  804644:	c9                   	leaveq 
  804645:	c3                   	retq   

0000000000804646 <htons>:
  804646:	55                   	push   %rbp
  804647:	48 89 e5             	mov    %rsp,%rbp
  80464a:	48 83 ec 04          	sub    $0x4,%rsp
  80464e:	89 f8                	mov    %edi,%eax
  804650:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  804654:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  804658:	c1 e0 08             	shl    $0x8,%eax
  80465b:	89 c2                	mov    %eax,%edx
  80465d:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  804661:	66 c1 e8 08          	shr    $0x8,%ax
  804665:	09 d0                	or     %edx,%eax
  804667:	c9                   	leaveq 
  804668:	c3                   	retq   

0000000000804669 <ntohs>:
  804669:	55                   	push   %rbp
  80466a:	48 89 e5             	mov    %rsp,%rbp
  80466d:	48 83 ec 08          	sub    $0x8,%rsp
  804671:	89 f8                	mov    %edi,%eax
  804673:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  804677:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  80467b:	89 c7                	mov    %eax,%edi
  80467d:	48 b8 46 46 80 00 00 	movabs $0x804646,%rax
  804684:	00 00 00 
  804687:	ff d0                	callq  *%rax
  804689:	c9                   	leaveq 
  80468a:	c3                   	retq   

000000000080468b <htonl>:
  80468b:	55                   	push   %rbp
  80468c:	48 89 e5             	mov    %rsp,%rbp
  80468f:	48 83 ec 04          	sub    $0x4,%rsp
  804693:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804696:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804699:	c1 e0 18             	shl    $0x18,%eax
  80469c:	89 c2                	mov    %eax,%edx
  80469e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046a1:	25 00 ff 00 00       	and    $0xff00,%eax
  8046a6:	c1 e0 08             	shl    $0x8,%eax
  8046a9:	09 c2                	or     %eax,%edx
  8046ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046ae:	25 00 00 ff 00       	and    $0xff0000,%eax
  8046b3:	48 c1 e8 08          	shr    $0x8,%rax
  8046b7:	09 c2                	or     %eax,%edx
  8046b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046bc:	c1 e8 18             	shr    $0x18,%eax
  8046bf:	09 d0                	or     %edx,%eax
  8046c1:	c9                   	leaveq 
  8046c2:	c3                   	retq   

00000000008046c3 <ntohl>:
  8046c3:	55                   	push   %rbp
  8046c4:	48 89 e5             	mov    %rsp,%rbp
  8046c7:	48 83 ec 08          	sub    $0x8,%rsp
  8046cb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8046ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046d1:	89 c7                	mov    %eax,%edi
  8046d3:	48 b8 8b 46 80 00 00 	movabs $0x80468b,%rax
  8046da:	00 00 00 
  8046dd:	ff d0                	callq  *%rax
  8046df:	c9                   	leaveq 
  8046e0:	c3                   	retq   
