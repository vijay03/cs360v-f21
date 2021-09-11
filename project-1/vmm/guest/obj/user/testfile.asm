
vmm/guest/obj/user/testfile:     file format elf64-x86-64


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
  80003c:	e8 39 0c 00 00       	callq  800c7a <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <xopen>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80004f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800052:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800056:	48 89 c6             	mov    %rax,%rsi
  800059:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  800060:	00 00 00 
  800063:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  80006a:	00 00 00 
  80006d:	ff d0                	callq  *%rax
  80006f:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  800076:	00 00 00 
  800079:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80007c:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  800082:	bf 01 00 00 00       	mov    $0x1,%edi
  800087:	48 b8 e9 29 80 00 00 	movabs $0x8029e9,%rax
  80008e:	00 00 00 
  800091:	ff d0                	callq  *%rax
  800093:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800096:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800099:	b9 07 00 00 00       	mov    $0x7,%ecx
  80009e:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  8000a5:	00 00 00 
  8000a8:	be 01 00 00 00       	mov    $0x1,%esi
  8000ad:	89 c7                	mov    %eax,%edi
  8000af:	48 b8 de 28 80 00 00 	movabs $0x8028de,%rax
  8000b6:	00 00 00 
  8000b9:	ff d0                	callq  *%rax
  8000bb:	ba 00 00 00 00       	mov    $0x0,%edx
  8000c0:	be 00 c0 cc cc       	mov    $0xccccc000,%esi
  8000c5:	bf 00 00 00 00       	mov    $0x0,%edi
  8000ca:	48 b8 1d 28 80 00 00 	movabs $0x80281d,%rax
  8000d1:	00 00 00 
  8000d4:	ff d0                	callq  *%rax
  8000d6:	c9                   	leaveq 
  8000d7:	c3                   	retq   

00000000008000d8 <umain>:
  8000d8:	55                   	push   %rbp
  8000d9:	48 89 e5             	mov    %rsp,%rbp
  8000dc:	53                   	push   %rbx
  8000dd:	48 81 ec 18 03 00 00 	sub    $0x318,%rsp
  8000e4:	89 bd 2c fd ff ff    	mov    %edi,-0x2d4(%rbp)
  8000ea:	48 89 b5 20 fd ff ff 	mov    %rsi,-0x2e0(%rbp)
  8000f1:	be 00 00 00 00       	mov    $0x0,%esi
  8000f6:	48 bf c6 4b 80 00 00 	movabs $0x804bc6,%rdi
  8000fd:	00 00 00 
  800100:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800107:	00 00 00 
  80010a:	ff d0                	callq  *%rax
  80010c:	48 98                	cltq   
  80010e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800112:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800117:	79 39                	jns    800152 <umain+0x7a>
  800119:	48 83 7d e0 f4       	cmpq   $0xfffffffffffffff4,-0x20(%rbp)
  80011e:	74 32                	je     800152 <umain+0x7a>
  800120:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800124:	48 89 c1             	mov    %rax,%rcx
  800127:	48 ba d1 4b 80 00 00 	movabs $0x804bd1,%rdx
  80012e:	00 00 00 
  800131:	be 21 00 00 00       	mov    $0x21,%esi
  800136:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80013d:	00 00 00 
  800140:	b8 00 00 00 00       	mov    $0x0,%eax
  800145:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80014c:	00 00 00 
  80014f:	41 ff d0             	callq  *%r8
  800152:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800157:	78 2a                	js     800183 <umain+0xab>
  800159:	48 ba 00 4c 80 00 00 	movabs $0x804c00,%rdx
  800160:	00 00 00 
  800163:	be 23 00 00 00       	mov    $0x23,%esi
  800168:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80016f:	00 00 00 
  800172:	b8 00 00 00 00       	mov    $0x0,%eax
  800177:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  80017e:	00 00 00 
  800181:	ff d1                	callq  *%rcx
  800183:	be 00 00 00 00       	mov    $0x0,%esi
  800188:	48 bf 21 4c 80 00 00 	movabs $0x804c21,%rdi
  80018f:	00 00 00 
  800192:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800199:	00 00 00 
  80019c:	ff d0                	callq  *%rax
  80019e:	48 98                	cltq   
  8001a0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8001a4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8001a9:	79 32                	jns    8001dd <umain+0x105>
  8001ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8001af:	48 89 c1             	mov    %rax,%rcx
  8001b2:	48 ba 2a 4c 80 00 00 	movabs $0x804c2a,%rdx
  8001b9:	00 00 00 
  8001bc:	be 26 00 00 00       	mov    $0x26,%esi
  8001c1:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8001c8:	00 00 00 
  8001cb:	b8 00 00 00 00       	mov    $0x0,%eax
  8001d0:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8001d7:	00 00 00 
  8001da:	41 ff d0             	callq  *%r8
  8001dd:	b8 00 c0 cc cc       	mov    $0xccccc000,%eax
  8001e2:	8b 00                	mov    (%rax),%eax
  8001e4:	83 f8 66             	cmp    $0x66,%eax
  8001e7:	75 18                	jne    800201 <umain+0x129>
  8001e9:	b8 00 c0 cc cc       	mov    $0xccccc000,%eax
  8001ee:	8b 40 04             	mov    0x4(%rax),%eax
  8001f1:	85 c0                	test   %eax,%eax
  8001f3:	75 0c                	jne    800201 <umain+0x129>
  8001f5:	b8 00 c0 cc cc       	mov    $0xccccc000,%eax
  8001fa:	8b 40 08             	mov    0x8(%rax),%eax
  8001fd:	85 c0                	test   %eax,%eax
  8001ff:	74 2a                	je     80022b <umain+0x153>
  800201:	48 ba 48 4c 80 00 00 	movabs $0x804c48,%rdx
  800208:	00 00 00 
  80020b:	be 28 00 00 00       	mov    $0x28,%esi
  800210:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800217:	00 00 00 
  80021a:	b8 00 00 00 00       	mov    $0x0,%eax
  80021f:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  800226:	00 00 00 
  800229:	ff d1                	callq  *%rcx
  80022b:	48 bf 75 4c 80 00 00 	movabs $0x804c75,%rdi
  800232:	00 00 00 
  800235:	b8 00 00 00 00       	mov    $0x0,%eax
  80023a:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800241:	00 00 00 
  800244:	ff d2                	callq  *%rdx
  800246:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  80024d:	00 00 00 
  800250:	48 8b 40 28          	mov    0x28(%rax),%rax
  800254:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80025b:	48 89 d6             	mov    %rdx,%rsi
  80025e:	bf 00 c0 cc cc       	mov    $0xccccc000,%edi
  800263:	ff d0                	callq  *%rax
  800265:	48 98                	cltq   
  800267:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80026b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800270:	79 32                	jns    8002a4 <umain+0x1cc>
  800272:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800276:	48 89 c1             	mov    %rax,%rcx
  800279:	48 ba 89 4c 80 00 00 	movabs $0x804c89,%rdx
  800280:	00 00 00 
  800283:	be 2c 00 00 00       	mov    $0x2c,%esi
  800288:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80028f:	00 00 00 
  800292:	b8 00 00 00 00       	mov    $0x0,%eax
  800297:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80029e:	00 00 00 
  8002a1:	41 ff d0             	callq  *%r8
  8002a4:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8002ab:	00 00 00 
  8002ae:	48 8b 00             	mov    (%rax),%rax
  8002b1:	48 89 c7             	mov    %rax,%rdi
  8002b4:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  8002bb:	00 00 00 
  8002be:	ff d0                	callq  *%rax
  8002c0:	8b 55 b0             	mov    -0x50(%rbp),%edx
  8002c3:	39 d0                	cmp    %edx,%eax
  8002c5:	74 51                	je     800318 <umain+0x240>
  8002c7:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8002ce:	00 00 00 
  8002d1:	48 8b 00             	mov    (%rax),%rax
  8002d4:	48 89 c7             	mov    %rax,%rdi
  8002d7:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  8002de:	00 00 00 
  8002e1:	ff d0                	callq  *%rax
  8002e3:	89 c2                	mov    %eax,%edx
  8002e5:	8b 45 b0             	mov    -0x50(%rbp),%eax
  8002e8:	41 89 d0             	mov    %edx,%r8d
  8002eb:	89 c1                	mov    %eax,%ecx
  8002ed:	48 ba 98 4c 80 00 00 	movabs $0x804c98,%rdx
  8002f4:	00 00 00 
  8002f7:	be 2e 00 00 00       	mov    $0x2e,%esi
  8002fc:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800303:	00 00 00 
  800306:	b8 00 00 00 00       	mov    $0x0,%eax
  80030b:	49 b9 20 0d 80 00 00 	movabs $0x800d20,%r9
  800312:	00 00 00 
  800315:	41 ff d1             	callq  *%r9
  800318:	48 bf be 4c 80 00 00 	movabs $0x804cbe,%rdi
  80031f:	00 00 00 
  800322:	b8 00 00 00 00       	mov    $0x0,%eax
  800327:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  80032e:	00 00 00 
  800331:	ff d2                	callq  *%rdx
  800333:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  80033a:	ba 00 02 00 00       	mov    $0x200,%edx
  80033f:	be 00 00 00 00       	mov    $0x0,%esi
  800344:	48 89 c7             	mov    %rax,%rdi
  800347:	48 b8 a7 1d 80 00 00 	movabs $0x801da7,%rax
  80034e:	00 00 00 
  800351:	ff d0                	callq  *%rax
  800353:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  80035a:	00 00 00 
  80035d:	48 8b 40 10          	mov    0x10(%rax),%rax
  800361:	48 8d 8d 30 fd ff ff 	lea    -0x2d0(%rbp),%rcx
  800368:	ba 00 02 00 00       	mov    $0x200,%edx
  80036d:	48 89 ce             	mov    %rcx,%rsi
  800370:	bf 00 c0 cc cc       	mov    $0xccccc000,%edi
  800375:	ff d0                	callq  *%rax
  800377:	48 98                	cltq   
  800379:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80037d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800382:	79 32                	jns    8003b6 <umain+0x2de>
  800384:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800388:	48 89 c1             	mov    %rax,%rcx
  80038b:	48 ba d1 4c 80 00 00 	movabs $0x804cd1,%rdx
  800392:	00 00 00 
  800395:	be 33 00 00 00       	mov    $0x33,%esi
  80039a:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8003a1:	00 00 00 
  8003a4:	b8 00 00 00 00       	mov    $0x0,%eax
  8003a9:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8003b0:	00 00 00 
  8003b3:	41 ff d0             	callq  *%r8
  8003b6:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8003bd:	00 00 00 
  8003c0:	48 8b 10             	mov    (%rax),%rdx
  8003c3:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  8003ca:	48 89 d6             	mov    %rdx,%rsi
  8003cd:	48 89 c7             	mov    %rax,%rdi
  8003d0:	48 b8 70 1c 80 00 00 	movabs $0x801c70,%rax
  8003d7:	00 00 00 
  8003da:	ff d0                	callq  *%rax
  8003dc:	85 c0                	test   %eax,%eax
  8003de:	74 2a                	je     80040a <umain+0x332>
  8003e0:	48 ba df 4c 80 00 00 	movabs $0x804cdf,%rdx
  8003e7:	00 00 00 
  8003ea:	be 35 00 00 00       	mov    $0x35,%esi
  8003ef:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8003f6:	00 00 00 
  8003f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8003fe:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  800405:	00 00 00 
  800408:	ff d1                	callq  *%rcx
  80040a:	48 bf fd 4c 80 00 00 	movabs $0x804cfd,%rdi
  800411:	00 00 00 
  800414:	b8 00 00 00 00       	mov    $0x0,%eax
  800419:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800420:	00 00 00 
  800423:	ff d2                	callq  *%rdx
  800425:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  80042c:	00 00 00 
  80042f:	48 8b 40 20          	mov    0x20(%rax),%rax
  800433:	bf 00 c0 cc cc       	mov    $0xccccc000,%edi
  800438:	ff d0                	callq  *%rax
  80043a:	48 98                	cltq   
  80043c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800440:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800445:	79 32                	jns    800479 <umain+0x3a1>
  800447:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80044b:	48 89 c1             	mov    %rax,%rcx
  80044e:	48 ba 10 4d 80 00 00 	movabs $0x804d10,%rdx
  800455:	00 00 00 
  800458:	be 39 00 00 00       	mov    $0x39,%esi
  80045d:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800464:	00 00 00 
  800467:	b8 00 00 00 00       	mov    $0x0,%eax
  80046c:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  800473:	00 00 00 
  800476:	41 ff d0             	callq  *%r8
  800479:	48 bf 1f 4d 80 00 00 	movabs $0x804d1f,%rdi
  800480:	00 00 00 
  800483:	b8 00 00 00 00       	mov    $0x0,%eax
  800488:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  80048f:	00 00 00 
  800492:	ff d2                	callq  *%rdx
  800494:	b8 00 c0 cc cc       	mov    $0xccccc000,%eax
  800499:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80049d:	48 8b 00             	mov    (%rax),%rax
  8004a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  8004a4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8004a8:	be 00 c0 cc cc       	mov    $0xccccc000,%esi
  8004ad:	bf 00 00 00 00       	mov    $0x0,%edi
  8004b2:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  8004b9:	00 00 00 
  8004bc:	ff d0                	callq  *%rax
  8004be:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  8004c5:	00 00 00 
  8004c8:	48 8b 40 10          	mov    0x10(%rax),%rax
  8004cc:	48 8d b5 30 fd ff ff 	lea    -0x2d0(%rbp),%rsi
  8004d3:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
  8004d7:	ba 00 02 00 00       	mov    $0x200,%edx
  8004dc:	48 89 cf             	mov    %rcx,%rdi
  8004df:	ff d0                	callq  *%rax
  8004e1:	48 98                	cltq   
  8004e3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8004e7:	48 83 7d e0 fd       	cmpq   $0xfffffffffffffffd,-0x20(%rbp)
  8004ec:	74 32                	je     800520 <umain+0x448>
  8004ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8004f2:	48 89 c1             	mov    %rax,%rcx
  8004f5:	48 ba 38 4d 80 00 00 	movabs $0x804d38,%rdx
  8004fc:	00 00 00 
  8004ff:	be 44 00 00 00       	mov    $0x44,%esi
  800504:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80050b:	00 00 00 
  80050e:	b8 00 00 00 00       	mov    $0x0,%eax
  800513:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80051a:	00 00 00 
  80051d:	41 ff d0             	callq  *%r8
  800520:	48 bf 6f 4d 80 00 00 	movabs $0x804d6f,%rdi
  800527:	00 00 00 
  80052a:	b8 00 00 00 00       	mov    $0x0,%eax
  80052f:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800536:	00 00 00 
  800539:	ff d2                	callq  *%rdx
  80053b:	be 02 01 00 00       	mov    $0x102,%esi
  800540:	48 bf 85 4d 80 00 00 	movabs $0x804d85,%rdi
  800547:	00 00 00 
  80054a:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800551:	00 00 00 
  800554:	ff d0                	callq  *%rax
  800556:	48 98                	cltq   
  800558:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80055c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800561:	79 32                	jns    800595 <umain+0x4bd>
  800563:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800567:	48 89 c1             	mov    %rax,%rcx
  80056a:	48 ba 8f 4d 80 00 00 	movabs $0x804d8f,%rdx
  800571:	00 00 00 
  800574:	be 49 00 00 00       	mov    $0x49,%esi
  800579:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800580:	00 00 00 
  800583:	b8 00 00 00 00       	mov    $0x0,%eax
  800588:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80058f:	00 00 00 
  800592:	41 ff d0             	callq  *%r8
  800595:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80059c:	00 00 00 
  80059f:	48 8b 10             	mov    (%rax),%rdx
  8005a2:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  8005a9:	00 00 00 
  8005ac:	48 8b 70 18          	mov    0x18(%rax),%rsi
  8005b0:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  8005b7:	00 00 00 
  8005ba:	48 8b 08             	mov    (%rax),%rcx
  8005bd:	48 89 0c 24          	mov    %rcx,(%rsp)
  8005c1:	48 8b 48 08          	mov    0x8(%rax),%rcx
  8005c5:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  8005ca:	48 8b 48 10          	mov    0x10(%rax),%rcx
  8005ce:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  8005d3:	48 8b 48 18          	mov    0x18(%rax),%rcx
  8005d7:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  8005dc:	48 8b 48 20          	mov    0x20(%rax),%rcx
  8005e0:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  8005e5:	48 8b 48 28          	mov    0x28(%rax),%rcx
  8005e9:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
  8005ee:	48 8b 40 30          	mov    0x30(%rax),%rax
  8005f2:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  8005f7:	b9 00 c0 cc cc       	mov    $0xccccc000,%ecx
  8005fc:	48 bf a8 4d 80 00 00 	movabs $0x804da8,%rdi
  800603:	00 00 00 
  800606:	b8 00 00 00 00       	mov    $0x0,%eax
  80060b:	49 b8 59 0f 80 00 00 	movabs $0x800f59,%r8
  800612:	00 00 00 
  800615:	41 ff d0             	callq  *%r8
  800618:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  80061f:	00 00 00 
  800622:	48 8b 58 18          	mov    0x18(%rax),%rbx
  800626:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80062d:	00 00 00 
  800630:	48 8b 00             	mov    (%rax),%rax
  800633:	48 89 c7             	mov    %rax,%rdi
  800636:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  80063d:	00 00 00 
  800640:	ff d0                	callq  *%rax
  800642:	48 63 d0             	movslq %eax,%rdx
  800645:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80064c:	00 00 00 
  80064f:	48 8b 00             	mov    (%rax),%rax
  800652:	48 89 c6             	mov    %rax,%rsi
  800655:	bf 00 c0 cc cc       	mov    $0xccccc000,%edi
  80065a:	ff d3                	callq  *%rbx
  80065c:	48 98                	cltq   
  80065e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800662:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800669:	00 00 00 
  80066c:	48 8b 00             	mov    (%rax),%rax
  80066f:	48 89 c7             	mov    %rax,%rdi
  800672:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  800679:	00 00 00 
  80067c:	ff d0                	callq  *%rax
  80067e:	48 98                	cltq   
  800680:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
  800684:	74 32                	je     8006b8 <umain+0x5e0>
  800686:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80068a:	48 89 c1             	mov    %rax,%rcx
  80068d:	48 ba e8 4d 80 00 00 	movabs $0x804de8,%rdx
  800694:	00 00 00 
  800697:	be 4e 00 00 00       	mov    $0x4e,%esi
  80069c:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8006a3:	00 00 00 
  8006a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8006ab:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8006b2:	00 00 00 
  8006b5:	41 ff d0             	callq  *%r8
  8006b8:	48 bf f7 4d 80 00 00 	movabs $0x804df7,%rdi
  8006bf:	00 00 00 
  8006c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8006c7:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  8006ce:	00 00 00 
  8006d1:	ff d2                	callq  *%rdx
  8006d3:	b8 00 c0 cc cc       	mov    $0xccccc000,%eax
  8006d8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  8006df:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  8006e6:	ba 00 02 00 00       	mov    $0x200,%edx
  8006eb:	be 00 00 00 00       	mov    $0x0,%esi
  8006f0:	48 89 c7             	mov    %rax,%rdi
  8006f3:	48 b8 a7 1d 80 00 00 	movabs $0x801da7,%rax
  8006fa:	00 00 00 
  8006fd:	ff d0                	callq  *%rax
  8006ff:	48 b8 60 70 80 00 00 	movabs $0x807060,%rax
  800706:	00 00 00 
  800709:	48 8b 40 10          	mov    0x10(%rax),%rax
  80070d:	48 8d 8d 30 fd ff ff 	lea    -0x2d0(%rbp),%rcx
  800714:	ba 00 02 00 00       	mov    $0x200,%edx
  800719:	48 89 ce             	mov    %rcx,%rsi
  80071c:	bf 00 c0 cc cc       	mov    $0xccccc000,%edi
  800721:	ff d0                	callq  *%rax
  800723:	48 98                	cltq   
  800725:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800729:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80072e:	79 32                	jns    800762 <umain+0x68a>
  800730:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800734:	48 89 c1             	mov    %rax,%rcx
  800737:	48 ba 10 4e 80 00 00 	movabs $0x804e10,%rdx
  80073e:	00 00 00 
  800741:	be 54 00 00 00       	mov    $0x54,%esi
  800746:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80074d:	00 00 00 
  800750:	b8 00 00 00 00       	mov    $0x0,%eax
  800755:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80075c:	00 00 00 
  80075f:	41 ff d0             	callq  *%r8
  800762:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800769:	00 00 00 
  80076c:	48 8b 00             	mov    (%rax),%rax
  80076f:	48 89 c7             	mov    %rax,%rdi
  800772:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  800779:	00 00 00 
  80077c:	ff d0                	callq  *%rax
  80077e:	48 98                	cltq   
  800780:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  800784:	74 32                	je     8007b8 <umain+0x6e0>
  800786:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80078a:	48 89 c1             	mov    %rax,%rcx
  80078d:	48 ba 30 4e 80 00 00 	movabs $0x804e30,%rdx
  800794:	00 00 00 
  800797:	be 56 00 00 00       	mov    $0x56,%esi
  80079c:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8007a3:	00 00 00 
  8007a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8007ab:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8007b2:	00 00 00 
  8007b5:	41 ff d0             	callq  *%r8
  8007b8:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8007bf:	00 00 00 
  8007c2:	48 8b 10             	mov    (%rax),%rdx
  8007c5:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  8007cc:	48 89 d6             	mov    %rdx,%rsi
  8007cf:	48 89 c7             	mov    %rax,%rdi
  8007d2:	48 b8 70 1c 80 00 00 	movabs $0x801c70,%rax
  8007d9:	00 00 00 
  8007dc:	ff d0                	callq  *%rax
  8007de:	85 c0                	test   %eax,%eax
  8007e0:	74 2a                	je     80080c <umain+0x734>
  8007e2:	48 ba 68 4e 80 00 00 	movabs $0x804e68,%rdx
  8007e9:	00 00 00 
  8007ec:	be 58 00 00 00       	mov    $0x58,%esi
  8007f1:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8007f8:	00 00 00 
  8007fb:	b8 00 00 00 00       	mov    $0x0,%eax
  800800:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  800807:	00 00 00 
  80080a:	ff d1                	callq  *%rcx
  80080c:	48 bf 98 4e 80 00 00 	movabs $0x804e98,%rdi
  800813:	00 00 00 
  800816:	b8 00 00 00 00       	mov    $0x0,%eax
  80081b:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800822:	00 00 00 
  800825:	ff d2                	callq  *%rdx
  800827:	be 00 00 00 00       	mov    $0x0,%esi
  80082c:	48 bf c6 4b 80 00 00 	movabs $0x804bc6,%rdi
  800833:	00 00 00 
  800836:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  80083d:	00 00 00 
  800840:	ff d0                	callq  *%rax
  800842:	48 98                	cltq   
  800844:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800848:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80084d:	79 39                	jns    800888 <umain+0x7b0>
  80084f:	48 83 7d e0 f4       	cmpq   $0xfffffffffffffff4,-0x20(%rbp)
  800854:	74 32                	je     800888 <umain+0x7b0>
  800856:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80085a:	48 89 c1             	mov    %rax,%rcx
  80085d:	48 ba bc 4e 80 00 00 	movabs $0x804ebc,%rdx
  800864:	00 00 00 
  800867:	be 5d 00 00 00       	mov    $0x5d,%esi
  80086c:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800873:	00 00 00 
  800876:	b8 00 00 00 00       	mov    $0x0,%eax
  80087b:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  800882:	00 00 00 
  800885:	41 ff d0             	callq  *%r8
  800888:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80088d:	78 2a                	js     8008b9 <umain+0x7e1>
  80088f:	48 ba d0 4e 80 00 00 	movabs $0x804ed0,%rdx
  800896:	00 00 00 
  800899:	be 5f 00 00 00       	mov    $0x5f,%esi
  80089e:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8008a5:	00 00 00 
  8008a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8008ad:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  8008b4:	00 00 00 
  8008b7:	ff d1                	callq  *%rcx
  8008b9:	be 00 00 00 00       	mov    $0x0,%esi
  8008be:	48 bf 21 4c 80 00 00 	movabs $0x804c21,%rdi
  8008c5:	00 00 00 
  8008c8:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  8008cf:	00 00 00 
  8008d2:	ff d0                	callq  *%rax
  8008d4:	48 98                	cltq   
  8008d6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8008da:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8008df:	79 32                	jns    800913 <umain+0x83b>
  8008e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8008e5:	48 89 c1             	mov    %rax,%rcx
  8008e8:	48 ba eb 4e 80 00 00 	movabs $0x804eeb,%rdx
  8008ef:	00 00 00 
  8008f2:	be 62 00 00 00       	mov    $0x62,%esi
  8008f7:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8008fe:	00 00 00 
  800901:	b8 00 00 00 00       	mov    $0x0,%eax
  800906:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80090d:	00 00 00 
  800910:	41 ff d0             	callq  *%r8
  800913:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800917:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80091d:	48 c1 e0 0c          	shl    $0xc,%rax
  800921:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800925:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800929:	8b 00                	mov    (%rax),%eax
  80092b:	83 f8 66             	cmp    $0x66,%eax
  80092e:	75 16                	jne    800946 <umain+0x86e>
  800930:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800934:	8b 40 04             	mov    0x4(%rax),%eax
  800937:	85 c0                	test   %eax,%eax
  800939:	75 0b                	jne    800946 <umain+0x86e>
  80093b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80093f:	8b 40 08             	mov    0x8(%rax),%eax
  800942:	85 c0                	test   %eax,%eax
  800944:	74 2a                	je     800970 <umain+0x898>
  800946:	48 ba 00 4f 80 00 00 	movabs $0x804f00,%rdx
  80094d:	00 00 00 
  800950:	be 65 00 00 00       	mov    $0x65,%esi
  800955:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  80095c:	00 00 00 
  80095f:	b8 00 00 00 00       	mov    $0x0,%eax
  800964:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  80096b:	00 00 00 
  80096e:	ff d1                	callq  *%rcx
  800970:	48 bf 27 4f 80 00 00 	movabs $0x804f27,%rdi
  800977:	00 00 00 
  80097a:	b8 00 00 00 00       	mov    $0x0,%eax
  80097f:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800986:	00 00 00 
  800989:	ff d2                	callq  *%rdx
  80098b:	be 01 01 00 00       	mov    $0x101,%esi
  800990:	48 bf 35 4f 80 00 00 	movabs $0x804f35,%rdi
  800997:	00 00 00 
  80099a:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  8009a1:	00 00 00 
  8009a4:	ff d0                	callq  *%rax
  8009a6:	48 98                	cltq   
  8009a8:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8009ac:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8009b1:	79 32                	jns    8009e5 <umain+0x90d>
  8009b3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8009b7:	48 89 c1             	mov    %rax,%rcx
  8009ba:	48 ba 3a 4f 80 00 00 	movabs $0x804f3a,%rdx
  8009c1:	00 00 00 
  8009c4:	be 6a 00 00 00       	mov    $0x6a,%esi
  8009c9:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  8009d0:	00 00 00 
  8009d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8009d8:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8009df:	00 00 00 
  8009e2:	41 ff d0             	callq  *%r8
  8009e5:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  8009ec:	ba 00 02 00 00       	mov    $0x200,%edx
  8009f1:	be 00 00 00 00       	mov    $0x0,%esi
  8009f6:	48 89 c7             	mov    %rax,%rdi
  8009f9:	48 b8 a7 1d 80 00 00 	movabs $0x801da7,%rax
  800a00:	00 00 00 
  800a03:	ff d0                	callq  *%rax
  800a05:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  800a0c:	00 
  800a0d:	e9 82 00 00 00       	jmpq   800a94 <umain+0x9bc>
  800a12:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  800a19:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a1d:	89 10                	mov    %edx,(%rax)
  800a1f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800a23:	48 8d 8d 30 fd ff ff 	lea    -0x2d0(%rbp),%rcx
  800a2a:	ba 00 02 00 00       	mov    $0x200,%edx
  800a2f:	48 89 ce             	mov    %rcx,%rsi
  800a32:	89 c7                	mov    %eax,%edi
  800a34:	48 b8 bd 30 80 00 00 	movabs $0x8030bd,%rax
  800a3b:	00 00 00 
  800a3e:	ff d0                	callq  *%rax
  800a40:	48 98                	cltq   
  800a42:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800a46:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800a4b:	79 39                	jns    800a86 <umain+0x9ae>
  800a4d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800a51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a55:	49 89 d0             	mov    %rdx,%r8
  800a58:	48 89 c1             	mov    %rax,%rcx
  800a5b:	48 ba 49 4f 80 00 00 	movabs $0x804f49,%rdx
  800a62:	00 00 00 
  800a65:	be 6f 00 00 00       	mov    $0x6f,%esi
  800a6a:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800a71:	00 00 00 
  800a74:	b8 00 00 00 00       	mov    $0x0,%eax
  800a79:	49 b9 20 0d 80 00 00 	movabs $0x800d20,%r9
  800a80:	00 00 00 
  800a83:	41 ff d1             	callq  *%r9
  800a86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a8a:	48 05 00 02 00 00    	add    $0x200,%rax
  800a90:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800a94:	48 81 7d e8 ff df 01 	cmpq   $0x1dfff,-0x18(%rbp)
  800a9b:	00 
  800a9c:	0f 8e 70 ff ff ff    	jle    800a12 <umain+0x93a>
  800aa2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800aa6:	89 c7                	mov    %eax,%edi
  800aa8:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  800aaf:	00 00 00 
  800ab2:	ff d0                	callq  *%rax
  800ab4:	be 00 00 00 00       	mov    $0x0,%esi
  800ab9:	48 bf 35 4f 80 00 00 	movabs $0x804f35,%rdi
  800ac0:	00 00 00 
  800ac3:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  800aca:	00 00 00 
  800acd:	ff d0                	callq  *%rax
  800acf:	48 98                	cltq   
  800ad1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800ad5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  800ada:	79 32                	jns    800b0e <umain+0xa36>
  800adc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800ae0:	48 89 c1             	mov    %rax,%rcx
  800ae3:	48 ba 5b 4f 80 00 00 	movabs $0x804f5b,%rdx
  800aea:	00 00 00 
  800aed:	be 74 00 00 00       	mov    $0x74,%esi
  800af2:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800af9:	00 00 00 
  800afc:	b8 00 00 00 00       	mov    $0x0,%eax
  800b01:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  800b08:	00 00 00 
  800b0b:	41 ff d0             	callq  *%r8
  800b0e:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  800b15:	00 
  800b16:	e9 1a 01 00 00       	jmpq   800c35 <umain+0xb5d>
  800b1b:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  800b22:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b26:	89 10                	mov    %edx,(%rax)
  800b28:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800b2c:	48 8d 8d 30 fd ff ff 	lea    -0x2d0(%rbp),%rcx
  800b33:	ba 00 02 00 00       	mov    $0x200,%edx
  800b38:	48 89 ce             	mov    %rcx,%rsi
  800b3b:	89 c7                	mov    %eax,%edi
  800b3d:	48 b8 48 30 80 00 00 	movabs $0x803048,%rax
  800b44:	00 00 00 
  800b47:	ff d0                	callq  *%rax
  800b49:	48 98                	cltq   
  800b4b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800b4f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800b54:	79 39                	jns    800b8f <umain+0xab7>
  800b56:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800b5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b5e:	49 89 d0             	mov    %rdx,%r8
  800b61:	48 89 c1             	mov    %rax,%rcx
  800b64:	48 ba 69 4f 80 00 00 	movabs $0x804f69,%rdx
  800b6b:	00 00 00 
  800b6e:	be 78 00 00 00       	mov    $0x78,%esi
  800b73:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800b7a:	00 00 00 
  800b7d:	b8 00 00 00 00       	mov    $0x0,%eax
  800b82:	49 b9 20 0d 80 00 00 	movabs $0x800d20,%r9
  800b89:	00 00 00 
  800b8c:	41 ff d1             	callq  *%r9
  800b8f:	48 81 7d e0 00 02 00 	cmpq   $0x200,-0x20(%rbp)
  800b96:	00 
  800b97:	74 3f                	je     800bd8 <umain+0xb00>
  800b99:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800b9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ba1:	41 b9 00 02 00 00    	mov    $0x200,%r9d
  800ba7:	49 89 d0             	mov    %rdx,%r8
  800baa:	48 89 c1             	mov    %rax,%rcx
  800bad:	48 ba 80 4f 80 00 00 	movabs $0x804f80,%rdx
  800bb4:	00 00 00 
  800bb7:	be 7b 00 00 00       	mov    $0x7b,%esi
  800bbc:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800bc3:	00 00 00 
  800bc6:	b8 00 00 00 00       	mov    $0x0,%eax
  800bcb:	49 ba 20 0d 80 00 00 	movabs $0x800d20,%r10
  800bd2:	00 00 00 
  800bd5:	41 ff d2             	callq  *%r10
  800bd8:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  800bdf:	8b 00                	mov    (%rax),%eax
  800be1:	48 98                	cltq   
  800be3:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
  800be7:	74 3e                	je     800c27 <umain+0xb4f>
  800be9:	48 8d 85 30 fd ff ff 	lea    -0x2d0(%rbp),%rax
  800bf0:	8b 10                	mov    (%rax),%edx
  800bf2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bf6:	41 89 d0             	mov    %edx,%r8d
  800bf9:	48 89 c1             	mov    %rax,%rcx
  800bfc:	48 ba b0 4f 80 00 00 	movabs $0x804fb0,%rdx
  800c03:	00 00 00 
  800c06:	be 7e 00 00 00       	mov    $0x7e,%esi
  800c0b:	48 bf eb 4b 80 00 00 	movabs $0x804beb,%rdi
  800c12:	00 00 00 
  800c15:	b8 00 00 00 00       	mov    $0x0,%eax
  800c1a:	49 b9 20 0d 80 00 00 	movabs $0x800d20,%r9
  800c21:	00 00 00 
  800c24:	41 ff d1             	callq  *%r9
  800c27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c2b:	48 05 00 02 00 00    	add    $0x200,%rax
  800c31:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c35:	48 81 7d e8 ff df 01 	cmpq   $0x1dfff,-0x18(%rbp)
  800c3c:	00 
  800c3d:	0f 8e d8 fe ff ff    	jle    800b1b <umain+0xa43>
  800c43:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800c47:	89 c7                	mov    %eax,%edi
  800c49:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  800c50:	00 00 00 
  800c53:	ff d0                	callq  *%rax
  800c55:	48 bf d7 4f 80 00 00 	movabs $0x804fd7,%rdi
  800c5c:	00 00 00 
  800c5f:	b8 00 00 00 00       	mov    $0x0,%eax
  800c64:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800c6b:	00 00 00 
  800c6e:	ff d2                	callq  *%rdx
  800c70:	48 81 c4 18 03 00 00 	add    $0x318,%rsp
  800c77:	5b                   	pop    %rbx
  800c78:	5d                   	pop    %rbp
  800c79:	c3                   	retq   

0000000000800c7a <libmain>:
  800c7a:	55                   	push   %rbp
  800c7b:	48 89 e5             	mov    %rsp,%rbp
  800c7e:	48 83 ec 10          	sub    $0x10,%rsp
  800c82:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800c85:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800c89:	48 b8 c1 23 80 00 00 	movabs $0x8023c1,%rax
  800c90:	00 00 00 
  800c93:	ff d0                	callq  *%rax
  800c95:	25 ff 03 00 00       	and    $0x3ff,%eax
  800c9a:	48 98                	cltq   
  800c9c:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800ca3:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800caa:	00 00 00 
  800cad:	48 01 c2             	add    %rax,%rdx
  800cb0:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800cb7:	00 00 00 
  800cba:	48 89 10             	mov    %rdx,(%rax)
  800cbd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800cc1:	7e 14                	jle    800cd7 <libmain+0x5d>
  800cc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800cc7:	48 8b 10             	mov    (%rax),%rdx
  800cca:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800cd1:	00 00 00 
  800cd4:	48 89 10             	mov    %rdx,(%rax)
  800cd7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800cdb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800cde:	48 89 d6             	mov    %rdx,%rsi
  800ce1:	89 c7                	mov    %eax,%edi
  800ce3:	48 b8 d8 00 80 00 00 	movabs $0x8000d8,%rax
  800cea:	00 00 00 
  800ced:	ff d0                	callq  *%rax
  800cef:	48 b8 fd 0c 80 00 00 	movabs $0x800cfd,%rax
  800cf6:	00 00 00 
  800cf9:	ff d0                	callq  *%rax
  800cfb:	c9                   	leaveq 
  800cfc:	c3                   	retq   

0000000000800cfd <exit>:
  800cfd:	55                   	push   %rbp
  800cfe:	48 89 e5             	mov    %rsp,%rbp
  800d01:	48 b8 9c 2d 80 00 00 	movabs $0x802d9c,%rax
  800d08:	00 00 00 
  800d0b:	ff d0                	callq  *%rax
  800d0d:	bf 00 00 00 00       	mov    $0x0,%edi
  800d12:	48 b8 7d 23 80 00 00 	movabs $0x80237d,%rax
  800d19:	00 00 00 
  800d1c:	ff d0                	callq  *%rax
  800d1e:	5d                   	pop    %rbp
  800d1f:	c3                   	retq   

0000000000800d20 <_panic>:
  800d20:	55                   	push   %rbp
  800d21:	48 89 e5             	mov    %rsp,%rbp
  800d24:	53                   	push   %rbx
  800d25:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800d2c:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800d33:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800d39:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800d40:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800d47:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  800d4e:	84 c0                	test   %al,%al
  800d50:	74 23                	je     800d75 <_panic+0x55>
  800d52:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800d59:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800d5d:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800d61:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800d65:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800d69:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800d6d:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800d71:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800d75:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800d7c:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800d83:	00 00 00 
  800d86:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800d8d:	00 00 00 
  800d90:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800d94:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800d9b:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800da2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800da9:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800db0:	00 00 00 
  800db3:	48 8b 18             	mov    (%rax),%rbx
  800db6:	48 b8 c1 23 80 00 00 	movabs $0x8023c1,%rax
  800dbd:	00 00 00 
  800dc0:	ff d0                	callq  *%rax
  800dc2:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800dc8:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800dcf:	41 89 c8             	mov    %ecx,%r8d
  800dd2:	48 89 d1             	mov    %rdx,%rcx
  800dd5:	48 89 da             	mov    %rbx,%rdx
  800dd8:	89 c6                	mov    %eax,%esi
  800dda:	48 bf f8 4f 80 00 00 	movabs $0x804ff8,%rdi
  800de1:	00 00 00 
  800de4:	b8 00 00 00 00       	mov    $0x0,%eax
  800de9:	49 b9 59 0f 80 00 00 	movabs $0x800f59,%r9
  800df0:	00 00 00 
  800df3:	41 ff d1             	callq  *%r9
  800df6:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  800dfd:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800e04:	48 89 d6             	mov    %rdx,%rsi
  800e07:	48 89 c7             	mov    %rax,%rdi
  800e0a:	48 b8 ad 0e 80 00 00 	movabs $0x800ead,%rax
  800e11:	00 00 00 
  800e14:	ff d0                	callq  *%rax
  800e16:	48 bf 1b 50 80 00 00 	movabs $0x80501b,%rdi
  800e1d:	00 00 00 
  800e20:	b8 00 00 00 00       	mov    $0x0,%eax
  800e25:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  800e2c:	00 00 00 
  800e2f:	ff d2                	callq  *%rdx
  800e31:	cc                   	int3   
  800e32:	eb fd                	jmp    800e31 <_panic+0x111>

0000000000800e34 <putch>:
  800e34:	55                   	push   %rbp
  800e35:	48 89 e5             	mov    %rsp,%rbp
  800e38:	48 83 ec 10          	sub    $0x10,%rsp
  800e3c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800e3f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800e43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e47:	8b 00                	mov    (%rax),%eax
  800e49:	8d 48 01             	lea    0x1(%rax),%ecx
  800e4c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800e50:	89 0a                	mov    %ecx,(%rdx)
  800e52:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800e55:	89 d1                	mov    %edx,%ecx
  800e57:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800e5b:	48 98                	cltq   
  800e5d:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e65:	8b 00                	mov    (%rax),%eax
  800e67:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e6c:	75 2c                	jne    800e9a <putch+0x66>
  800e6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e72:	8b 00                	mov    (%rax),%eax
  800e74:	48 98                	cltq   
  800e76:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800e7a:	48 83 c2 08          	add    $0x8,%rdx
  800e7e:	48 89 c6             	mov    %rax,%rsi
  800e81:	48 89 d7             	mov    %rdx,%rdi
  800e84:	48 b8 f5 22 80 00 00 	movabs $0x8022f5,%rax
  800e8b:	00 00 00 
  800e8e:	ff d0                	callq  *%rax
  800e90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e94:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800e9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e9e:	8b 40 04             	mov    0x4(%rax),%eax
  800ea1:	8d 50 01             	lea    0x1(%rax),%edx
  800ea4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ea8:	89 50 04             	mov    %edx,0x4(%rax)
  800eab:	c9                   	leaveq 
  800eac:	c3                   	retq   

0000000000800ead <vcprintf>:
  800ead:	55                   	push   %rbp
  800eae:	48 89 e5             	mov    %rsp,%rbp
  800eb1:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800eb8:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800ebf:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800ec6:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800ecd:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800ed4:	48 8b 0a             	mov    (%rdx),%rcx
  800ed7:	48 89 08             	mov    %rcx,(%rax)
  800eda:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ede:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ee2:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ee6:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800eea:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800ef1:	00 00 00 
  800ef4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800efb:	00 00 00 
  800efe:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800f05:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800f0c:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800f13:	48 89 c6             	mov    %rax,%rsi
  800f16:	48 bf 34 0e 80 00 00 	movabs $0x800e34,%rdi
  800f1d:	00 00 00 
  800f20:	48 b8 0c 13 80 00 00 	movabs $0x80130c,%rax
  800f27:	00 00 00 
  800f2a:	ff d0                	callq  *%rax
  800f2c:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800f32:	48 98                	cltq   
  800f34:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800f3b:	48 83 c2 08          	add    $0x8,%rdx
  800f3f:	48 89 c6             	mov    %rax,%rsi
  800f42:	48 89 d7             	mov    %rdx,%rdi
  800f45:	48 b8 f5 22 80 00 00 	movabs $0x8022f5,%rax
  800f4c:	00 00 00 
  800f4f:	ff d0                	callq  *%rax
  800f51:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800f57:	c9                   	leaveq 
  800f58:	c3                   	retq   

0000000000800f59 <cprintf>:
  800f59:	55                   	push   %rbp
  800f5a:	48 89 e5             	mov    %rsp,%rbp
  800f5d:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800f64:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800f6b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800f72:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800f79:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800f80:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800f87:	84 c0                	test   %al,%al
  800f89:	74 20                	je     800fab <cprintf+0x52>
  800f8b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f8f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f93:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f97:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f9b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f9f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800fa3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800fa7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800fab:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800fb2:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800fb9:	00 00 00 
  800fbc:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800fc3:	00 00 00 
  800fc6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800fca:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800fd1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800fd8:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800fdf:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800fe6:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800fed:	48 8b 0a             	mov    (%rdx),%rcx
  800ff0:	48 89 08             	mov    %rcx,(%rax)
  800ff3:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ff7:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ffb:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800fff:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801003:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80100a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801011:	48 89 d6             	mov    %rdx,%rsi
  801014:	48 89 c7             	mov    %rax,%rdi
  801017:	48 b8 ad 0e 80 00 00 	movabs $0x800ead,%rax
  80101e:	00 00 00 
  801021:	ff d0                	callq  *%rax
  801023:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801029:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80102f:	c9                   	leaveq 
  801030:	c3                   	retq   

0000000000801031 <printnum>:
  801031:	55                   	push   %rbp
  801032:	48 89 e5             	mov    %rsp,%rbp
  801035:	53                   	push   %rbx
  801036:	48 83 ec 38          	sub    $0x38,%rsp
  80103a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80103e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801042:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801046:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  801049:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80104d:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  801051:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  801054:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801058:	77 3b                	ja     801095 <printnum+0x64>
  80105a:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80105d:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  801061:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  801064:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801068:	ba 00 00 00 00       	mov    $0x0,%edx
  80106d:	48 f7 f3             	div    %rbx
  801070:	48 89 c2             	mov    %rax,%rdx
  801073:	8b 7d cc             	mov    -0x34(%rbp),%edi
  801076:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  801079:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80107d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801081:	41 89 f9             	mov    %edi,%r9d
  801084:	48 89 c7             	mov    %rax,%rdi
  801087:	48 b8 31 10 80 00 00 	movabs $0x801031,%rax
  80108e:	00 00 00 
  801091:	ff d0                	callq  *%rax
  801093:	eb 1e                	jmp    8010b3 <printnum+0x82>
  801095:	eb 12                	jmp    8010a9 <printnum+0x78>
  801097:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80109b:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80109e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010a2:	48 89 ce             	mov    %rcx,%rsi
  8010a5:	89 d7                	mov    %edx,%edi
  8010a7:	ff d0                	callq  *%rax
  8010a9:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8010ad:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8010b1:	7f e4                	jg     801097 <printnum+0x66>
  8010b3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8010b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8010ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8010bf:	48 f7 f1             	div    %rcx
  8010c2:	48 89 d0             	mov    %rdx,%rax
  8010c5:	48 ba 10 52 80 00 00 	movabs $0x805210,%rdx
  8010cc:	00 00 00 
  8010cf:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8010d3:	0f be d0             	movsbl %al,%edx
  8010d6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8010da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010de:	48 89 ce             	mov    %rcx,%rsi
  8010e1:	89 d7                	mov    %edx,%edi
  8010e3:	ff d0                	callq  *%rax
  8010e5:	48 83 c4 38          	add    $0x38,%rsp
  8010e9:	5b                   	pop    %rbx
  8010ea:	5d                   	pop    %rbp
  8010eb:	c3                   	retq   

00000000008010ec <getuint>:
  8010ec:	55                   	push   %rbp
  8010ed:	48 89 e5             	mov    %rsp,%rbp
  8010f0:	48 83 ec 1c          	sub    $0x1c,%rsp
  8010f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010f8:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8010fb:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8010ff:	7e 52                	jle    801153 <getuint+0x67>
  801101:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801105:	8b 00                	mov    (%rax),%eax
  801107:	83 f8 30             	cmp    $0x30,%eax
  80110a:	73 24                	jae    801130 <getuint+0x44>
  80110c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801110:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801118:	8b 00                	mov    (%rax),%eax
  80111a:	89 c0                	mov    %eax,%eax
  80111c:	48 01 d0             	add    %rdx,%rax
  80111f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801123:	8b 12                	mov    (%rdx),%edx
  801125:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801128:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80112c:	89 0a                	mov    %ecx,(%rdx)
  80112e:	eb 17                	jmp    801147 <getuint+0x5b>
  801130:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801134:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801138:	48 89 d0             	mov    %rdx,%rax
  80113b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80113f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801143:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801147:	48 8b 00             	mov    (%rax),%rax
  80114a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80114e:	e9 a3 00 00 00       	jmpq   8011f6 <getuint+0x10a>
  801153:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  801157:	74 4f                	je     8011a8 <getuint+0xbc>
  801159:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80115d:	8b 00                	mov    (%rax),%eax
  80115f:	83 f8 30             	cmp    $0x30,%eax
  801162:	73 24                	jae    801188 <getuint+0x9c>
  801164:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801168:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80116c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801170:	8b 00                	mov    (%rax),%eax
  801172:	89 c0                	mov    %eax,%eax
  801174:	48 01 d0             	add    %rdx,%rax
  801177:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80117b:	8b 12                	mov    (%rdx),%edx
  80117d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801180:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801184:	89 0a                	mov    %ecx,(%rdx)
  801186:	eb 17                	jmp    80119f <getuint+0xb3>
  801188:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80118c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801190:	48 89 d0             	mov    %rdx,%rax
  801193:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  801197:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80119b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80119f:	48 8b 00             	mov    (%rax),%rax
  8011a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8011a6:	eb 4e                	jmp    8011f6 <getuint+0x10a>
  8011a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ac:	8b 00                	mov    (%rax),%eax
  8011ae:	83 f8 30             	cmp    $0x30,%eax
  8011b1:	73 24                	jae    8011d7 <getuint+0xeb>
  8011b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8011bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011bf:	8b 00                	mov    (%rax),%eax
  8011c1:	89 c0                	mov    %eax,%eax
  8011c3:	48 01 d0             	add    %rdx,%rax
  8011c6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011ca:	8b 12                	mov    (%rdx),%edx
  8011cc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8011cf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011d3:	89 0a                	mov    %ecx,(%rdx)
  8011d5:	eb 17                	jmp    8011ee <getuint+0x102>
  8011d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011db:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8011df:	48 89 d0             	mov    %rdx,%rax
  8011e2:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8011e6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8011ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8011ee:	8b 00                	mov    (%rax),%eax
  8011f0:	89 c0                	mov    %eax,%eax
  8011f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8011f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011fa:	c9                   	leaveq 
  8011fb:	c3                   	retq   

00000000008011fc <getint>:
  8011fc:	55                   	push   %rbp
  8011fd:	48 89 e5             	mov    %rsp,%rbp
  801200:	48 83 ec 1c          	sub    $0x1c,%rsp
  801204:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801208:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80120b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80120f:	7e 52                	jle    801263 <getint+0x67>
  801211:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801215:	8b 00                	mov    (%rax),%eax
  801217:	83 f8 30             	cmp    $0x30,%eax
  80121a:	73 24                	jae    801240 <getint+0x44>
  80121c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801220:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801224:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801228:	8b 00                	mov    (%rax),%eax
  80122a:	89 c0                	mov    %eax,%eax
  80122c:	48 01 d0             	add    %rdx,%rax
  80122f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801233:	8b 12                	mov    (%rdx),%edx
  801235:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801238:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80123c:	89 0a                	mov    %ecx,(%rdx)
  80123e:	eb 17                	jmp    801257 <getint+0x5b>
  801240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801244:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801248:	48 89 d0             	mov    %rdx,%rax
  80124b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80124f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801253:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801257:	48 8b 00             	mov    (%rax),%rax
  80125a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80125e:	e9 a3 00 00 00       	jmpq   801306 <getint+0x10a>
  801263:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  801267:	74 4f                	je     8012b8 <getint+0xbc>
  801269:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80126d:	8b 00                	mov    (%rax),%eax
  80126f:	83 f8 30             	cmp    $0x30,%eax
  801272:	73 24                	jae    801298 <getint+0x9c>
  801274:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801278:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80127c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801280:	8b 00                	mov    (%rax),%eax
  801282:	89 c0                	mov    %eax,%eax
  801284:	48 01 d0             	add    %rdx,%rax
  801287:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80128b:	8b 12                	mov    (%rdx),%edx
  80128d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801290:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801294:	89 0a                	mov    %ecx,(%rdx)
  801296:	eb 17                	jmp    8012af <getint+0xb3>
  801298:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80129c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8012a0:	48 89 d0             	mov    %rdx,%rax
  8012a3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8012a7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8012ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8012af:	48 8b 00             	mov    (%rax),%rax
  8012b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012b6:	eb 4e                	jmp    801306 <getint+0x10a>
  8012b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012bc:	8b 00                	mov    (%rax),%eax
  8012be:	83 f8 30             	cmp    $0x30,%eax
  8012c1:	73 24                	jae    8012e7 <getint+0xeb>
  8012c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012c7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8012cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012cf:	8b 00                	mov    (%rax),%eax
  8012d1:	89 c0                	mov    %eax,%eax
  8012d3:	48 01 d0             	add    %rdx,%rax
  8012d6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8012da:	8b 12                	mov    (%rdx),%edx
  8012dc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8012df:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8012e3:	89 0a                	mov    %ecx,(%rdx)
  8012e5:	eb 17                	jmp    8012fe <getint+0x102>
  8012e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012eb:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8012ef:	48 89 d0             	mov    %rdx,%rax
  8012f2:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8012f6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8012fa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8012fe:	8b 00                	mov    (%rax),%eax
  801300:	48 98                	cltq   
  801302:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80130a:	c9                   	leaveq 
  80130b:	c3                   	retq   

000000000080130c <vprintfmt>:
  80130c:	55                   	push   %rbp
  80130d:	48 89 e5             	mov    %rsp,%rbp
  801310:	41 54                	push   %r12
  801312:	53                   	push   %rbx
  801313:	48 83 ec 60          	sub    $0x60,%rsp
  801317:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  80131b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  80131f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  801323:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  801327:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80132b:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  80132f:	48 8b 0a             	mov    (%rdx),%rcx
  801332:	48 89 08             	mov    %rcx,(%rax)
  801335:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801339:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80133d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801341:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801345:	eb 17                	jmp    80135e <vprintfmt+0x52>
  801347:	85 db                	test   %ebx,%ebx
  801349:	0f 84 cc 04 00 00    	je     80181b <vprintfmt+0x50f>
  80134f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801353:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801357:	48 89 d6             	mov    %rdx,%rsi
  80135a:	89 df                	mov    %ebx,%edi
  80135c:	ff d0                	callq  *%rax
  80135e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801362:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801366:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80136a:	0f b6 00             	movzbl (%rax),%eax
  80136d:	0f b6 d8             	movzbl %al,%ebx
  801370:	83 fb 25             	cmp    $0x25,%ebx
  801373:	75 d2                	jne    801347 <vprintfmt+0x3b>
  801375:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  801379:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  801380:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  801387:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80138e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  801395:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801399:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80139d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8013a1:	0f b6 00             	movzbl (%rax),%eax
  8013a4:	0f b6 d8             	movzbl %al,%ebx
  8013a7:	8d 43 dd             	lea    -0x23(%rbx),%eax
  8013aa:	83 f8 55             	cmp    $0x55,%eax
  8013ad:	0f 87 34 04 00 00    	ja     8017e7 <vprintfmt+0x4db>
  8013b3:	89 c0                	mov    %eax,%eax
  8013b5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8013bc:	00 
  8013bd:	48 b8 38 52 80 00 00 	movabs $0x805238,%rax
  8013c4:	00 00 00 
  8013c7:	48 01 d0             	add    %rdx,%rax
  8013ca:	48 8b 00             	mov    (%rax),%rax
  8013cd:	ff e0                	jmpq   *%rax
  8013cf:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8013d3:	eb c0                	jmp    801395 <vprintfmt+0x89>
  8013d5:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8013d9:	eb ba                	jmp    801395 <vprintfmt+0x89>
  8013db:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8013e2:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8013e5:	89 d0                	mov    %edx,%eax
  8013e7:	c1 e0 02             	shl    $0x2,%eax
  8013ea:	01 d0                	add    %edx,%eax
  8013ec:	01 c0                	add    %eax,%eax
  8013ee:	01 d8                	add    %ebx,%eax
  8013f0:	83 e8 30             	sub    $0x30,%eax
  8013f3:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8013f6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8013fa:	0f b6 00             	movzbl (%rax),%eax
  8013fd:	0f be d8             	movsbl %al,%ebx
  801400:	83 fb 2f             	cmp    $0x2f,%ebx
  801403:	7e 0c                	jle    801411 <vprintfmt+0x105>
  801405:	83 fb 39             	cmp    $0x39,%ebx
  801408:	7f 07                	jg     801411 <vprintfmt+0x105>
  80140a:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  80140f:	eb d1                	jmp    8013e2 <vprintfmt+0xd6>
  801411:	eb 58                	jmp    80146b <vprintfmt+0x15f>
  801413:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801416:	83 f8 30             	cmp    $0x30,%eax
  801419:	73 17                	jae    801432 <vprintfmt+0x126>
  80141b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80141f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801422:	89 c0                	mov    %eax,%eax
  801424:	48 01 d0             	add    %rdx,%rax
  801427:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80142a:	83 c2 08             	add    $0x8,%edx
  80142d:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801430:	eb 0f                	jmp    801441 <vprintfmt+0x135>
  801432:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801436:	48 89 d0             	mov    %rdx,%rax
  801439:	48 83 c2 08          	add    $0x8,%rdx
  80143d:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801441:	8b 00                	mov    (%rax),%eax
  801443:	89 45 d8             	mov    %eax,-0x28(%rbp)
  801446:	eb 23                	jmp    80146b <vprintfmt+0x15f>
  801448:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80144c:	79 0c                	jns    80145a <vprintfmt+0x14e>
  80144e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  801455:	e9 3b ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  80145a:	e9 36 ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  80145f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  801466:	e9 2a ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  80146b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80146f:	79 12                	jns    801483 <vprintfmt+0x177>
  801471:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801474:	89 45 dc             	mov    %eax,-0x24(%rbp)
  801477:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80147e:	e9 12 ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  801483:	e9 0d ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  801488:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  80148c:	e9 04 ff ff ff       	jmpq   801395 <vprintfmt+0x89>
  801491:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801494:	83 f8 30             	cmp    $0x30,%eax
  801497:	73 17                	jae    8014b0 <vprintfmt+0x1a4>
  801499:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80149d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8014a0:	89 c0                	mov    %eax,%eax
  8014a2:	48 01 d0             	add    %rdx,%rax
  8014a5:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8014a8:	83 c2 08             	add    $0x8,%edx
  8014ab:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8014ae:	eb 0f                	jmp    8014bf <vprintfmt+0x1b3>
  8014b0:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8014b4:	48 89 d0             	mov    %rdx,%rax
  8014b7:	48 83 c2 08          	add    $0x8,%rdx
  8014bb:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8014bf:	8b 10                	mov    (%rax),%edx
  8014c1:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8014c5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8014c9:	48 89 ce             	mov    %rcx,%rsi
  8014cc:	89 d7                	mov    %edx,%edi
  8014ce:	ff d0                	callq  *%rax
  8014d0:	e9 40 03 00 00       	jmpq   801815 <vprintfmt+0x509>
  8014d5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8014d8:	83 f8 30             	cmp    $0x30,%eax
  8014db:	73 17                	jae    8014f4 <vprintfmt+0x1e8>
  8014dd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8014e1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8014e4:	89 c0                	mov    %eax,%eax
  8014e6:	48 01 d0             	add    %rdx,%rax
  8014e9:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8014ec:	83 c2 08             	add    $0x8,%edx
  8014ef:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8014f2:	eb 0f                	jmp    801503 <vprintfmt+0x1f7>
  8014f4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8014f8:	48 89 d0             	mov    %rdx,%rax
  8014fb:	48 83 c2 08          	add    $0x8,%rdx
  8014ff:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801503:	8b 18                	mov    (%rax),%ebx
  801505:	85 db                	test   %ebx,%ebx
  801507:	79 02                	jns    80150b <vprintfmt+0x1ff>
  801509:	f7 db                	neg    %ebx
  80150b:	83 fb 15             	cmp    $0x15,%ebx
  80150e:	7f 16                	jg     801526 <vprintfmt+0x21a>
  801510:	48 b8 60 51 80 00 00 	movabs $0x805160,%rax
  801517:	00 00 00 
  80151a:	48 63 d3             	movslq %ebx,%rdx
  80151d:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  801521:	4d 85 e4             	test   %r12,%r12
  801524:	75 2e                	jne    801554 <vprintfmt+0x248>
  801526:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80152a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80152e:	89 d9                	mov    %ebx,%ecx
  801530:	48 ba 21 52 80 00 00 	movabs $0x805221,%rdx
  801537:	00 00 00 
  80153a:	48 89 c7             	mov    %rax,%rdi
  80153d:	b8 00 00 00 00       	mov    $0x0,%eax
  801542:	49 b8 24 18 80 00 00 	movabs $0x801824,%r8
  801549:	00 00 00 
  80154c:	41 ff d0             	callq  *%r8
  80154f:	e9 c1 02 00 00       	jmpq   801815 <vprintfmt+0x509>
  801554:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801558:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80155c:	4c 89 e1             	mov    %r12,%rcx
  80155f:	48 ba 2a 52 80 00 00 	movabs $0x80522a,%rdx
  801566:	00 00 00 
  801569:	48 89 c7             	mov    %rax,%rdi
  80156c:	b8 00 00 00 00       	mov    $0x0,%eax
  801571:	49 b8 24 18 80 00 00 	movabs $0x801824,%r8
  801578:	00 00 00 
  80157b:	41 ff d0             	callq  *%r8
  80157e:	e9 92 02 00 00       	jmpq   801815 <vprintfmt+0x509>
  801583:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801586:	83 f8 30             	cmp    $0x30,%eax
  801589:	73 17                	jae    8015a2 <vprintfmt+0x296>
  80158b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80158f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801592:	89 c0                	mov    %eax,%eax
  801594:	48 01 d0             	add    %rdx,%rax
  801597:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80159a:	83 c2 08             	add    $0x8,%edx
  80159d:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8015a0:	eb 0f                	jmp    8015b1 <vprintfmt+0x2a5>
  8015a2:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8015a6:	48 89 d0             	mov    %rdx,%rax
  8015a9:	48 83 c2 08          	add    $0x8,%rdx
  8015ad:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8015b1:	4c 8b 20             	mov    (%rax),%r12
  8015b4:	4d 85 e4             	test   %r12,%r12
  8015b7:	75 0a                	jne    8015c3 <vprintfmt+0x2b7>
  8015b9:	49 bc 2d 52 80 00 00 	movabs $0x80522d,%r12
  8015c0:	00 00 00 
  8015c3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8015c7:	7e 3f                	jle    801608 <vprintfmt+0x2fc>
  8015c9:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  8015cd:	74 39                	je     801608 <vprintfmt+0x2fc>
  8015cf:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8015d2:	48 98                	cltq   
  8015d4:	48 89 c6             	mov    %rax,%rsi
  8015d7:	4c 89 e7             	mov    %r12,%rdi
  8015da:	48 b8 d0 1a 80 00 00 	movabs $0x801ad0,%rax
  8015e1:	00 00 00 
  8015e4:	ff d0                	callq  *%rax
  8015e6:	29 45 dc             	sub    %eax,-0x24(%rbp)
  8015e9:	eb 17                	jmp    801602 <vprintfmt+0x2f6>
  8015eb:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  8015ef:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8015f3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8015f7:	48 89 ce             	mov    %rcx,%rsi
  8015fa:	89 d7                	mov    %edx,%edi
  8015fc:	ff d0                	callq  *%rax
  8015fe:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801602:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801606:	7f e3                	jg     8015eb <vprintfmt+0x2df>
  801608:	eb 37                	jmp    801641 <vprintfmt+0x335>
  80160a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  80160e:	74 1e                	je     80162e <vprintfmt+0x322>
  801610:	83 fb 1f             	cmp    $0x1f,%ebx
  801613:	7e 05                	jle    80161a <vprintfmt+0x30e>
  801615:	83 fb 7e             	cmp    $0x7e,%ebx
  801618:	7e 14                	jle    80162e <vprintfmt+0x322>
  80161a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80161e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801622:	48 89 d6             	mov    %rdx,%rsi
  801625:	bf 3f 00 00 00       	mov    $0x3f,%edi
  80162a:	ff d0                	callq  *%rax
  80162c:	eb 0f                	jmp    80163d <vprintfmt+0x331>
  80162e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801632:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801636:	48 89 d6             	mov    %rdx,%rsi
  801639:	89 df                	mov    %ebx,%edi
  80163b:	ff d0                	callq  *%rax
  80163d:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801641:	4c 89 e0             	mov    %r12,%rax
  801644:	4c 8d 60 01          	lea    0x1(%rax),%r12
  801648:	0f b6 00             	movzbl (%rax),%eax
  80164b:	0f be d8             	movsbl %al,%ebx
  80164e:	85 db                	test   %ebx,%ebx
  801650:	74 10                	je     801662 <vprintfmt+0x356>
  801652:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801656:	78 b2                	js     80160a <vprintfmt+0x2fe>
  801658:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  80165c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801660:	79 a8                	jns    80160a <vprintfmt+0x2fe>
  801662:	eb 16                	jmp    80167a <vprintfmt+0x36e>
  801664:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801668:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80166c:	48 89 d6             	mov    %rdx,%rsi
  80166f:	bf 20 00 00 00       	mov    $0x20,%edi
  801674:	ff d0                	callq  *%rax
  801676:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  80167a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80167e:	7f e4                	jg     801664 <vprintfmt+0x358>
  801680:	e9 90 01 00 00       	jmpq   801815 <vprintfmt+0x509>
  801685:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801689:	be 03 00 00 00       	mov    $0x3,%esi
  80168e:	48 89 c7             	mov    %rax,%rdi
  801691:	48 b8 fc 11 80 00 00 	movabs $0x8011fc,%rax
  801698:	00 00 00 
  80169b:	ff d0                	callq  *%rax
  80169d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8016a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016a5:	48 85 c0             	test   %rax,%rax
  8016a8:	79 1d                	jns    8016c7 <vprintfmt+0x3bb>
  8016aa:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8016ae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8016b2:	48 89 d6             	mov    %rdx,%rsi
  8016b5:	bf 2d 00 00 00       	mov    $0x2d,%edi
  8016ba:	ff d0                	callq  *%rax
  8016bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016c0:	48 f7 d8             	neg    %rax
  8016c3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8016c7:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8016ce:	e9 d5 00 00 00       	jmpq   8017a8 <vprintfmt+0x49c>
  8016d3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8016d7:	be 03 00 00 00       	mov    $0x3,%esi
  8016dc:	48 89 c7             	mov    %rax,%rdi
  8016df:	48 b8 ec 10 80 00 00 	movabs $0x8010ec,%rax
  8016e6:	00 00 00 
  8016e9:	ff d0                	callq  *%rax
  8016eb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8016ef:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8016f6:	e9 ad 00 00 00       	jmpq   8017a8 <vprintfmt+0x49c>
  8016fb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8016ff:	be 03 00 00 00       	mov    $0x3,%esi
  801704:	48 89 c7             	mov    %rax,%rdi
  801707:	48 b8 ec 10 80 00 00 	movabs $0x8010ec,%rax
  80170e:	00 00 00 
  801711:	ff d0                	callq  *%rax
  801713:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801717:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  80171e:	e9 85 00 00 00       	jmpq   8017a8 <vprintfmt+0x49c>
  801723:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801727:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80172b:	48 89 d6             	mov    %rdx,%rsi
  80172e:	bf 30 00 00 00       	mov    $0x30,%edi
  801733:	ff d0                	callq  *%rax
  801735:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801739:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80173d:	48 89 d6             	mov    %rdx,%rsi
  801740:	bf 78 00 00 00       	mov    $0x78,%edi
  801745:	ff d0                	callq  *%rax
  801747:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80174a:	83 f8 30             	cmp    $0x30,%eax
  80174d:	73 17                	jae    801766 <vprintfmt+0x45a>
  80174f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801753:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801756:	89 c0                	mov    %eax,%eax
  801758:	48 01 d0             	add    %rdx,%rax
  80175b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80175e:	83 c2 08             	add    $0x8,%edx
  801761:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801764:	eb 0f                	jmp    801775 <vprintfmt+0x469>
  801766:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80176a:	48 89 d0             	mov    %rdx,%rax
  80176d:	48 83 c2 08          	add    $0x8,%rdx
  801771:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801775:	48 8b 00             	mov    (%rax),%rax
  801778:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80177c:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801783:	eb 23                	jmp    8017a8 <vprintfmt+0x49c>
  801785:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  801789:	be 03 00 00 00       	mov    $0x3,%esi
  80178e:	48 89 c7             	mov    %rax,%rdi
  801791:	48 b8 ec 10 80 00 00 	movabs $0x8010ec,%rax
  801798:	00 00 00 
  80179b:	ff d0                	callq  *%rax
  80179d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8017a1:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8017a8:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  8017ad:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  8017b0:	8b 7d dc             	mov    -0x24(%rbp),%edi
  8017b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017b7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8017bb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8017bf:	45 89 c1             	mov    %r8d,%r9d
  8017c2:	41 89 f8             	mov    %edi,%r8d
  8017c5:	48 89 c7             	mov    %rax,%rdi
  8017c8:	48 b8 31 10 80 00 00 	movabs $0x801031,%rax
  8017cf:	00 00 00 
  8017d2:	ff d0                	callq  *%rax
  8017d4:	eb 3f                	jmp    801815 <vprintfmt+0x509>
  8017d6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8017da:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8017de:	48 89 d6             	mov    %rdx,%rsi
  8017e1:	89 df                	mov    %ebx,%edi
  8017e3:	ff d0                	callq  *%rax
  8017e5:	eb 2e                	jmp    801815 <vprintfmt+0x509>
  8017e7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8017eb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8017ef:	48 89 d6             	mov    %rdx,%rsi
  8017f2:	bf 25 00 00 00       	mov    $0x25,%edi
  8017f7:	ff d0                	callq  *%rax
  8017f9:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8017fe:	eb 05                	jmp    801805 <vprintfmt+0x4f9>
  801800:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  801805:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801809:	48 83 e8 01          	sub    $0x1,%rax
  80180d:	0f b6 00             	movzbl (%rax),%eax
  801810:	3c 25                	cmp    $0x25,%al
  801812:	75 ec                	jne    801800 <vprintfmt+0x4f4>
  801814:	90                   	nop
  801815:	90                   	nop
  801816:	e9 43 fb ff ff       	jmpq   80135e <vprintfmt+0x52>
  80181b:	48 83 c4 60          	add    $0x60,%rsp
  80181f:	5b                   	pop    %rbx
  801820:	41 5c                	pop    %r12
  801822:	5d                   	pop    %rbp
  801823:	c3                   	retq   

0000000000801824 <printfmt>:
  801824:	55                   	push   %rbp
  801825:	48 89 e5             	mov    %rsp,%rbp
  801828:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  80182f:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801836:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80183d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801844:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80184b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801852:	84 c0                	test   %al,%al
  801854:	74 20                	je     801876 <printfmt+0x52>
  801856:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80185a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80185e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801862:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801866:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80186a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80186e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801872:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801876:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80187d:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801884:	00 00 00 
  801887:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  80188e:	00 00 00 
  801891:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801895:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80189c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8018a3:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  8018aa:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  8018b1:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8018b8:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  8018bf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  8018c6:	48 89 c7             	mov    %rax,%rdi
  8018c9:	48 b8 0c 13 80 00 00 	movabs $0x80130c,%rax
  8018d0:	00 00 00 
  8018d3:	ff d0                	callq  *%rax
  8018d5:	c9                   	leaveq 
  8018d6:	c3                   	retq   

00000000008018d7 <sprintputch>:
  8018d7:	55                   	push   %rbp
  8018d8:	48 89 e5             	mov    %rsp,%rbp
  8018db:	48 83 ec 10          	sub    $0x10,%rsp
  8018df:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018e2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018ea:	8b 40 10             	mov    0x10(%rax),%eax
  8018ed:	8d 50 01             	lea    0x1(%rax),%edx
  8018f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018f4:	89 50 10             	mov    %edx,0x10(%rax)
  8018f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018fb:	48 8b 10             	mov    (%rax),%rdx
  8018fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801902:	48 8b 40 08          	mov    0x8(%rax),%rax
  801906:	48 39 c2             	cmp    %rax,%rdx
  801909:	73 17                	jae    801922 <sprintputch+0x4b>
  80190b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80190f:	48 8b 00             	mov    (%rax),%rax
  801912:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801916:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80191a:	48 89 0a             	mov    %rcx,(%rdx)
  80191d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801920:	88 10                	mov    %dl,(%rax)
  801922:	c9                   	leaveq 
  801923:	c3                   	retq   

0000000000801924 <vsnprintf>:
  801924:	55                   	push   %rbp
  801925:	48 89 e5             	mov    %rsp,%rbp
  801928:	48 83 ec 50          	sub    $0x50,%rsp
  80192c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801930:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801933:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801937:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  80193b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  80193f:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801943:	48 8b 0a             	mov    (%rdx),%rcx
  801946:	48 89 08             	mov    %rcx,(%rax)
  801949:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80194d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801951:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801955:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801959:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80195d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801961:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801964:	48 98                	cltq   
  801966:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80196a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80196e:	48 01 d0             	add    %rdx,%rax
  801971:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801975:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80197c:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801981:	74 06                	je     801989 <vsnprintf+0x65>
  801983:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801987:	7f 07                	jg     801990 <vsnprintf+0x6c>
  801989:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80198e:	eb 2f                	jmp    8019bf <vsnprintf+0x9b>
  801990:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801994:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801998:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80199c:	48 89 c6             	mov    %rax,%rsi
  80199f:	48 bf d7 18 80 00 00 	movabs $0x8018d7,%rdi
  8019a6:	00 00 00 
  8019a9:	48 b8 0c 13 80 00 00 	movabs $0x80130c,%rax
  8019b0:	00 00 00 
  8019b3:	ff d0                	callq  *%rax
  8019b5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8019b9:	c6 00 00             	movb   $0x0,(%rax)
  8019bc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8019bf:	c9                   	leaveq 
  8019c0:	c3                   	retq   

00000000008019c1 <snprintf>:
  8019c1:	55                   	push   %rbp
  8019c2:	48 89 e5             	mov    %rsp,%rbp
  8019c5:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8019cc:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8019d3:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8019d9:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8019e0:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8019e7:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8019ee:	84 c0                	test   %al,%al
  8019f0:	74 20                	je     801a12 <snprintf+0x51>
  8019f2:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8019f6:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8019fa:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8019fe:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801a02:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801a06:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801a0a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801a0e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801a12:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801a19:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  801a20:	00 00 00 
  801a23:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  801a2a:	00 00 00 
  801a2d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801a31:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801a38:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801a3f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801a46:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  801a4d:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801a54:	48 8b 0a             	mov    (%rdx),%rcx
  801a57:	48 89 08             	mov    %rcx,(%rax)
  801a5a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801a5e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801a62:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801a66:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801a6a:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801a71:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801a78:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801a7e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801a85:	48 89 c7             	mov    %rax,%rdi
  801a88:	48 b8 24 19 80 00 00 	movabs $0x801924,%rax
  801a8f:	00 00 00 
  801a92:	ff d0                	callq  *%rax
  801a94:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801a9a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801aa0:	c9                   	leaveq 
  801aa1:	c3                   	retq   

0000000000801aa2 <strlen>:
  801aa2:	55                   	push   %rbp
  801aa3:	48 89 e5             	mov    %rsp,%rbp
  801aa6:	48 83 ec 18          	sub    $0x18,%rsp
  801aaa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801aae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ab5:	eb 09                	jmp    801ac0 <strlen+0x1e>
  801ab7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801abb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801ac0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ac4:	0f b6 00             	movzbl (%rax),%eax
  801ac7:	84 c0                	test   %al,%al
  801ac9:	75 ec                	jne    801ab7 <strlen+0x15>
  801acb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ace:	c9                   	leaveq 
  801acf:	c3                   	retq   

0000000000801ad0 <strnlen>:
  801ad0:	55                   	push   %rbp
  801ad1:	48 89 e5             	mov    %rsp,%rbp
  801ad4:	48 83 ec 20          	sub    $0x20,%rsp
  801ad8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801adc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801ae0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ae7:	eb 0e                	jmp    801af7 <strnlen+0x27>
  801ae9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801aed:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801af2:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801af7:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801afc:	74 0b                	je     801b09 <strnlen+0x39>
  801afe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b02:	0f b6 00             	movzbl (%rax),%eax
  801b05:	84 c0                	test   %al,%al
  801b07:	75 e0                	jne    801ae9 <strnlen+0x19>
  801b09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b0c:	c9                   	leaveq 
  801b0d:	c3                   	retq   

0000000000801b0e <strcpy>:
  801b0e:	55                   	push   %rbp
  801b0f:	48 89 e5             	mov    %rsp,%rbp
  801b12:	48 83 ec 20          	sub    $0x20,%rsp
  801b16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b1a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801b1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801b26:	90                   	nop
  801b27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801b2f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801b33:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801b37:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801b3b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801b3f:	0f b6 12             	movzbl (%rdx),%edx
  801b42:	88 10                	mov    %dl,(%rax)
  801b44:	0f b6 00             	movzbl (%rax),%eax
  801b47:	84 c0                	test   %al,%al
  801b49:	75 dc                	jne    801b27 <strcpy+0x19>
  801b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b4f:	c9                   	leaveq 
  801b50:	c3                   	retq   

0000000000801b51 <strcat>:
  801b51:	55                   	push   %rbp
  801b52:	48 89 e5             	mov    %rsp,%rbp
  801b55:	48 83 ec 20          	sub    $0x20,%rsp
  801b59:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b5d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801b61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b65:	48 89 c7             	mov    %rax,%rdi
  801b68:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  801b6f:	00 00 00 
  801b72:	ff d0                	callq  *%rax
  801b74:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801b77:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b7a:	48 63 d0             	movslq %eax,%rdx
  801b7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b81:	48 01 c2             	add    %rax,%rdx
  801b84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801b88:	48 89 c6             	mov    %rax,%rsi
  801b8b:	48 89 d7             	mov    %rdx,%rdi
  801b8e:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  801b95:	00 00 00 
  801b98:	ff d0                	callq  *%rax
  801b9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b9e:	c9                   	leaveq 
  801b9f:	c3                   	retq   

0000000000801ba0 <strncpy>:
  801ba0:	55                   	push   %rbp
  801ba1:	48 89 e5             	mov    %rsp,%rbp
  801ba4:	48 83 ec 28          	sub    $0x28,%rsp
  801ba8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801bac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801bb0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801bb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bb8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801bbc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801bc3:	00 
  801bc4:	eb 2a                	jmp    801bf0 <strncpy+0x50>
  801bc6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bca:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801bce:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801bd2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801bd6:	0f b6 12             	movzbl (%rdx),%edx
  801bd9:	88 10                	mov    %dl,(%rax)
  801bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801bdf:	0f b6 00             	movzbl (%rax),%eax
  801be2:	84 c0                	test   %al,%al
  801be4:	74 05                	je     801beb <strncpy+0x4b>
  801be6:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801beb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bf4:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801bf8:	72 cc                	jb     801bc6 <strncpy+0x26>
  801bfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801bfe:	c9                   	leaveq 
  801bff:	c3                   	retq   

0000000000801c00 <strlcpy>:
  801c00:	55                   	push   %rbp
  801c01:	48 89 e5             	mov    %rsp,%rbp
  801c04:	48 83 ec 28          	sub    $0x28,%rsp
  801c08:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801c0c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801c10:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801c14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801c1c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801c21:	74 3d                	je     801c60 <strlcpy+0x60>
  801c23:	eb 1d                	jmp    801c42 <strlcpy+0x42>
  801c25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c29:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801c2d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801c31:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801c35:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801c39:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801c3d:	0f b6 12             	movzbl (%rdx),%edx
  801c40:	88 10                	mov    %dl,(%rax)
  801c42:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801c47:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801c4c:	74 0b                	je     801c59 <strlcpy+0x59>
  801c4e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c52:	0f b6 00             	movzbl (%rax),%eax
  801c55:	84 c0                	test   %al,%al
  801c57:	75 cc                	jne    801c25 <strlcpy+0x25>
  801c59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c5d:	c6 00 00             	movb   $0x0,(%rax)
  801c60:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c68:	48 29 c2             	sub    %rax,%rdx
  801c6b:	48 89 d0             	mov    %rdx,%rax
  801c6e:	c9                   	leaveq 
  801c6f:	c3                   	retq   

0000000000801c70 <strcmp>:
  801c70:	55                   	push   %rbp
  801c71:	48 89 e5             	mov    %rsp,%rbp
  801c74:	48 83 ec 10          	sub    $0x10,%rsp
  801c78:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c7c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c80:	eb 0a                	jmp    801c8c <strcmp+0x1c>
  801c82:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801c87:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c90:	0f b6 00             	movzbl (%rax),%eax
  801c93:	84 c0                	test   %al,%al
  801c95:	74 12                	je     801ca9 <strcmp+0x39>
  801c97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c9b:	0f b6 10             	movzbl (%rax),%edx
  801c9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ca2:	0f b6 00             	movzbl (%rax),%eax
  801ca5:	38 c2                	cmp    %al,%dl
  801ca7:	74 d9                	je     801c82 <strcmp+0x12>
  801ca9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cad:	0f b6 00             	movzbl (%rax),%eax
  801cb0:	0f b6 d0             	movzbl %al,%edx
  801cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cb7:	0f b6 00             	movzbl (%rax),%eax
  801cba:	0f b6 c0             	movzbl %al,%eax
  801cbd:	29 c2                	sub    %eax,%edx
  801cbf:	89 d0                	mov    %edx,%eax
  801cc1:	c9                   	leaveq 
  801cc2:	c3                   	retq   

0000000000801cc3 <strncmp>:
  801cc3:	55                   	push   %rbp
  801cc4:	48 89 e5             	mov    %rsp,%rbp
  801cc7:	48 83 ec 18          	sub    $0x18,%rsp
  801ccb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801ccf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801cd3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801cd7:	eb 0f                	jmp    801ce8 <strncmp+0x25>
  801cd9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801cde:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801ce3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801ce8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801ced:	74 1d                	je     801d0c <strncmp+0x49>
  801cef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cf3:	0f b6 00             	movzbl (%rax),%eax
  801cf6:	84 c0                	test   %al,%al
  801cf8:	74 12                	je     801d0c <strncmp+0x49>
  801cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cfe:	0f b6 10             	movzbl (%rax),%edx
  801d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d05:	0f b6 00             	movzbl (%rax),%eax
  801d08:	38 c2                	cmp    %al,%dl
  801d0a:	74 cd                	je     801cd9 <strncmp+0x16>
  801d0c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801d11:	75 07                	jne    801d1a <strncmp+0x57>
  801d13:	b8 00 00 00 00       	mov    $0x0,%eax
  801d18:	eb 18                	jmp    801d32 <strncmp+0x6f>
  801d1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d1e:	0f b6 00             	movzbl (%rax),%eax
  801d21:	0f b6 d0             	movzbl %al,%edx
  801d24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d28:	0f b6 00             	movzbl (%rax),%eax
  801d2b:	0f b6 c0             	movzbl %al,%eax
  801d2e:	29 c2                	sub    %eax,%edx
  801d30:	89 d0                	mov    %edx,%eax
  801d32:	c9                   	leaveq 
  801d33:	c3                   	retq   

0000000000801d34 <strchr>:
  801d34:	55                   	push   %rbp
  801d35:	48 89 e5             	mov    %rsp,%rbp
  801d38:	48 83 ec 0c          	sub    $0xc,%rsp
  801d3c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d40:	89 f0                	mov    %esi,%eax
  801d42:	88 45 f4             	mov    %al,-0xc(%rbp)
  801d45:	eb 17                	jmp    801d5e <strchr+0x2a>
  801d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d4b:	0f b6 00             	movzbl (%rax),%eax
  801d4e:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801d51:	75 06                	jne    801d59 <strchr+0x25>
  801d53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d57:	eb 15                	jmp    801d6e <strchr+0x3a>
  801d59:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801d5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d62:	0f b6 00             	movzbl (%rax),%eax
  801d65:	84 c0                	test   %al,%al
  801d67:	75 de                	jne    801d47 <strchr+0x13>
  801d69:	b8 00 00 00 00       	mov    $0x0,%eax
  801d6e:	c9                   	leaveq 
  801d6f:	c3                   	retq   

0000000000801d70 <strfind>:
  801d70:	55                   	push   %rbp
  801d71:	48 89 e5             	mov    %rsp,%rbp
  801d74:	48 83 ec 0c          	sub    $0xc,%rsp
  801d78:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d7c:	89 f0                	mov    %esi,%eax
  801d7e:	88 45 f4             	mov    %al,-0xc(%rbp)
  801d81:	eb 13                	jmp    801d96 <strfind+0x26>
  801d83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d87:	0f b6 00             	movzbl (%rax),%eax
  801d8a:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801d8d:	75 02                	jne    801d91 <strfind+0x21>
  801d8f:	eb 10                	jmp    801da1 <strfind+0x31>
  801d91:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801d96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d9a:	0f b6 00             	movzbl (%rax),%eax
  801d9d:	84 c0                	test   %al,%al
  801d9f:	75 e2                	jne    801d83 <strfind+0x13>
  801da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801da5:	c9                   	leaveq 
  801da6:	c3                   	retq   

0000000000801da7 <memset>:
  801da7:	55                   	push   %rbp
  801da8:	48 89 e5             	mov    %rsp,%rbp
  801dab:	48 83 ec 18          	sub    $0x18,%rsp
  801daf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801db3:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801db6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801dba:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801dbf:	75 06                	jne    801dc7 <memset+0x20>
  801dc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dc5:	eb 69                	jmp    801e30 <memset+0x89>
  801dc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dcb:	83 e0 03             	and    $0x3,%eax
  801dce:	48 85 c0             	test   %rax,%rax
  801dd1:	75 48                	jne    801e1b <memset+0x74>
  801dd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dd7:	83 e0 03             	and    $0x3,%eax
  801dda:	48 85 c0             	test   %rax,%rax
  801ddd:	75 3c                	jne    801e1b <memset+0x74>
  801ddf:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801de6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801de9:	c1 e0 18             	shl    $0x18,%eax
  801dec:	89 c2                	mov    %eax,%edx
  801dee:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801df1:	c1 e0 10             	shl    $0x10,%eax
  801df4:	09 c2                	or     %eax,%edx
  801df6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801df9:	c1 e0 08             	shl    $0x8,%eax
  801dfc:	09 d0                	or     %edx,%eax
  801dfe:	09 45 f4             	or     %eax,-0xc(%rbp)
  801e01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e05:	48 c1 e8 02          	shr    $0x2,%rax
  801e09:	48 89 c1             	mov    %rax,%rcx
  801e0c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801e10:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801e13:	48 89 d7             	mov    %rdx,%rdi
  801e16:	fc                   	cld    
  801e17:	f3 ab                	rep stos %eax,%es:(%rdi)
  801e19:	eb 11                	jmp    801e2c <memset+0x85>
  801e1b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801e1f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801e22:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801e26:	48 89 d7             	mov    %rdx,%rdi
  801e29:	fc                   	cld    
  801e2a:	f3 aa                	rep stos %al,%es:(%rdi)
  801e2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e30:	c9                   	leaveq 
  801e31:	c3                   	retq   

0000000000801e32 <memmove>:
  801e32:	55                   	push   %rbp
  801e33:	48 89 e5             	mov    %rsp,%rbp
  801e36:	48 83 ec 28          	sub    $0x28,%rsp
  801e3a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801e3e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801e42:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801e46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801e4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801e4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e52:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801e56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e5a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801e5e:	0f 83 88 00 00 00    	jae    801eec <memmove+0xba>
  801e64:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e68:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801e6c:	48 01 d0             	add    %rdx,%rax
  801e6f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801e73:	76 77                	jbe    801eec <memmove+0xba>
  801e75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e79:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801e7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e81:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801e85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e89:	83 e0 03             	and    $0x3,%eax
  801e8c:	48 85 c0             	test   %rax,%rax
  801e8f:	75 3b                	jne    801ecc <memmove+0x9a>
  801e91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e95:	83 e0 03             	and    $0x3,%eax
  801e98:	48 85 c0             	test   %rax,%rax
  801e9b:	75 2f                	jne    801ecc <memmove+0x9a>
  801e9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ea1:	83 e0 03             	and    $0x3,%eax
  801ea4:	48 85 c0             	test   %rax,%rax
  801ea7:	75 23                	jne    801ecc <memmove+0x9a>
  801ea9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ead:	48 83 e8 04          	sub    $0x4,%rax
  801eb1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801eb5:	48 83 ea 04          	sub    $0x4,%rdx
  801eb9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801ebd:	48 c1 e9 02          	shr    $0x2,%rcx
  801ec1:	48 89 c7             	mov    %rax,%rdi
  801ec4:	48 89 d6             	mov    %rdx,%rsi
  801ec7:	fd                   	std    
  801ec8:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801eca:	eb 1d                	jmp    801ee9 <memmove+0xb7>
  801ecc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ed0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ed8:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801edc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ee0:	48 89 d7             	mov    %rdx,%rdi
  801ee3:	48 89 c1             	mov    %rax,%rcx
  801ee6:	fd                   	std    
  801ee7:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801ee9:	fc                   	cld    
  801eea:	eb 57                	jmp    801f43 <memmove+0x111>
  801eec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ef0:	83 e0 03             	and    $0x3,%eax
  801ef3:	48 85 c0             	test   %rax,%rax
  801ef6:	75 36                	jne    801f2e <memmove+0xfc>
  801ef8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801efc:	83 e0 03             	and    $0x3,%eax
  801eff:	48 85 c0             	test   %rax,%rax
  801f02:	75 2a                	jne    801f2e <memmove+0xfc>
  801f04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f08:	83 e0 03             	and    $0x3,%eax
  801f0b:	48 85 c0             	test   %rax,%rax
  801f0e:	75 1e                	jne    801f2e <memmove+0xfc>
  801f10:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f14:	48 c1 e8 02          	shr    $0x2,%rax
  801f18:	48 89 c1             	mov    %rax,%rcx
  801f1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f23:	48 89 c7             	mov    %rax,%rdi
  801f26:	48 89 d6             	mov    %rdx,%rsi
  801f29:	fc                   	cld    
  801f2a:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801f2c:	eb 15                	jmp    801f43 <memmove+0x111>
  801f2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f32:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801f36:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801f3a:	48 89 c7             	mov    %rax,%rdi
  801f3d:	48 89 d6             	mov    %rdx,%rsi
  801f40:	fc                   	cld    
  801f41:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801f43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f47:	c9                   	leaveq 
  801f48:	c3                   	retq   

0000000000801f49 <memcpy>:
  801f49:	55                   	push   %rbp
  801f4a:	48 89 e5             	mov    %rsp,%rbp
  801f4d:	48 83 ec 18          	sub    $0x18,%rsp
  801f51:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f55:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f59:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801f5d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801f61:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801f65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f69:	48 89 ce             	mov    %rcx,%rsi
  801f6c:	48 89 c7             	mov    %rax,%rdi
  801f6f:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  801f76:	00 00 00 
  801f79:	ff d0                	callq  *%rax
  801f7b:	c9                   	leaveq 
  801f7c:	c3                   	retq   

0000000000801f7d <memcmp>:
  801f7d:	55                   	push   %rbp
  801f7e:	48 89 e5             	mov    %rsp,%rbp
  801f81:	48 83 ec 28          	sub    $0x28,%rsp
  801f85:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801f89:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801f8d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801f91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801f95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801f99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801fa1:	eb 36                	jmp    801fd9 <memcmp+0x5c>
  801fa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801fa7:	0f b6 10             	movzbl (%rax),%edx
  801faa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fae:	0f b6 00             	movzbl (%rax),%eax
  801fb1:	38 c2                	cmp    %al,%dl
  801fb3:	74 1a                	je     801fcf <memcmp+0x52>
  801fb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801fb9:	0f b6 00             	movzbl (%rax),%eax
  801fbc:	0f b6 d0             	movzbl %al,%edx
  801fbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fc3:	0f b6 00             	movzbl (%rax),%eax
  801fc6:	0f b6 c0             	movzbl %al,%eax
  801fc9:	29 c2                	sub    %eax,%edx
  801fcb:	89 d0                	mov    %edx,%eax
  801fcd:	eb 20                	jmp    801fef <memcmp+0x72>
  801fcf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801fd4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801fd9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fdd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801fe1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801fe5:	48 85 c0             	test   %rax,%rax
  801fe8:	75 b9                	jne    801fa3 <memcmp+0x26>
  801fea:	b8 00 00 00 00       	mov    $0x0,%eax
  801fef:	c9                   	leaveq 
  801ff0:	c3                   	retq   

0000000000801ff1 <memfind>:
  801ff1:	55                   	push   %rbp
  801ff2:	48 89 e5             	mov    %rsp,%rbp
  801ff5:	48 83 ec 28          	sub    $0x28,%rsp
  801ff9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801ffd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802000:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802004:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802008:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80200c:	48 01 d0             	add    %rdx,%rax
  80200f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802013:	eb 15                	jmp    80202a <memfind+0x39>
  802015:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802019:	0f b6 10             	movzbl (%rax),%edx
  80201c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80201f:	38 c2                	cmp    %al,%dl
  802021:	75 02                	jne    802025 <memfind+0x34>
  802023:	eb 0f                	jmp    802034 <memfind+0x43>
  802025:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80202a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80202e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  802032:	72 e1                	jb     802015 <memfind+0x24>
  802034:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802038:	c9                   	leaveq 
  802039:	c3                   	retq   

000000000080203a <strtol>:
  80203a:	55                   	push   %rbp
  80203b:	48 89 e5             	mov    %rsp,%rbp
  80203e:	48 83 ec 34          	sub    $0x34,%rsp
  802042:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802046:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80204a:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80204d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802054:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  80205b:	00 
  80205c:	eb 05                	jmp    802063 <strtol+0x29>
  80205e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  802063:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802067:	0f b6 00             	movzbl (%rax),%eax
  80206a:	3c 20                	cmp    $0x20,%al
  80206c:	74 f0                	je     80205e <strtol+0x24>
  80206e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802072:	0f b6 00             	movzbl (%rax),%eax
  802075:	3c 09                	cmp    $0x9,%al
  802077:	74 e5                	je     80205e <strtol+0x24>
  802079:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80207d:	0f b6 00             	movzbl (%rax),%eax
  802080:	3c 2b                	cmp    $0x2b,%al
  802082:	75 07                	jne    80208b <strtol+0x51>
  802084:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  802089:	eb 17                	jmp    8020a2 <strtol+0x68>
  80208b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80208f:	0f b6 00             	movzbl (%rax),%eax
  802092:	3c 2d                	cmp    $0x2d,%al
  802094:	75 0c                	jne    8020a2 <strtol+0x68>
  802096:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80209b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8020a2:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8020a6:	74 06                	je     8020ae <strtol+0x74>
  8020a8:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8020ac:	75 28                	jne    8020d6 <strtol+0x9c>
  8020ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020b2:	0f b6 00             	movzbl (%rax),%eax
  8020b5:	3c 30                	cmp    $0x30,%al
  8020b7:	75 1d                	jne    8020d6 <strtol+0x9c>
  8020b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020bd:	48 83 c0 01          	add    $0x1,%rax
  8020c1:	0f b6 00             	movzbl (%rax),%eax
  8020c4:	3c 78                	cmp    $0x78,%al
  8020c6:	75 0e                	jne    8020d6 <strtol+0x9c>
  8020c8:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8020cd:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8020d4:	eb 2c                	jmp    802102 <strtol+0xc8>
  8020d6:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8020da:	75 19                	jne    8020f5 <strtol+0xbb>
  8020dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020e0:	0f b6 00             	movzbl (%rax),%eax
  8020e3:	3c 30                	cmp    $0x30,%al
  8020e5:	75 0e                	jne    8020f5 <strtol+0xbb>
  8020e7:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8020ec:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  8020f3:	eb 0d                	jmp    802102 <strtol+0xc8>
  8020f5:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8020f9:	75 07                	jne    802102 <strtol+0xc8>
  8020fb:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  802102:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802106:	0f b6 00             	movzbl (%rax),%eax
  802109:	3c 2f                	cmp    $0x2f,%al
  80210b:	7e 1d                	jle    80212a <strtol+0xf0>
  80210d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802111:	0f b6 00             	movzbl (%rax),%eax
  802114:	3c 39                	cmp    $0x39,%al
  802116:	7f 12                	jg     80212a <strtol+0xf0>
  802118:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80211c:	0f b6 00             	movzbl (%rax),%eax
  80211f:	0f be c0             	movsbl %al,%eax
  802122:	83 e8 30             	sub    $0x30,%eax
  802125:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802128:	eb 4e                	jmp    802178 <strtol+0x13e>
  80212a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80212e:	0f b6 00             	movzbl (%rax),%eax
  802131:	3c 60                	cmp    $0x60,%al
  802133:	7e 1d                	jle    802152 <strtol+0x118>
  802135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802139:	0f b6 00             	movzbl (%rax),%eax
  80213c:	3c 7a                	cmp    $0x7a,%al
  80213e:	7f 12                	jg     802152 <strtol+0x118>
  802140:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802144:	0f b6 00             	movzbl (%rax),%eax
  802147:	0f be c0             	movsbl %al,%eax
  80214a:	83 e8 57             	sub    $0x57,%eax
  80214d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802150:	eb 26                	jmp    802178 <strtol+0x13e>
  802152:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802156:	0f b6 00             	movzbl (%rax),%eax
  802159:	3c 40                	cmp    $0x40,%al
  80215b:	7e 48                	jle    8021a5 <strtol+0x16b>
  80215d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802161:	0f b6 00             	movzbl (%rax),%eax
  802164:	3c 5a                	cmp    $0x5a,%al
  802166:	7f 3d                	jg     8021a5 <strtol+0x16b>
  802168:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80216c:	0f b6 00             	movzbl (%rax),%eax
  80216f:	0f be c0             	movsbl %al,%eax
  802172:	83 e8 37             	sub    $0x37,%eax
  802175:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802178:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80217b:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  80217e:	7c 02                	jl     802182 <strtol+0x148>
  802180:	eb 23                	jmp    8021a5 <strtol+0x16b>
  802182:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  802187:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80218a:	48 98                	cltq   
  80218c:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  802191:	48 89 c2             	mov    %rax,%rdx
  802194:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802197:	48 98                	cltq   
  802199:	48 01 d0             	add    %rdx,%rax
  80219c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8021a0:	e9 5d ff ff ff       	jmpq   802102 <strtol+0xc8>
  8021a5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  8021aa:	74 0b                	je     8021b7 <strtol+0x17d>
  8021ac:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8021b0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8021b4:	48 89 10             	mov    %rdx,(%rax)
  8021b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021bb:	74 09                	je     8021c6 <strtol+0x18c>
  8021bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8021c1:	48 f7 d8             	neg    %rax
  8021c4:	eb 04                	jmp    8021ca <strtol+0x190>
  8021c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8021ca:	c9                   	leaveq 
  8021cb:	c3                   	retq   

00000000008021cc <strstr>:
  8021cc:	55                   	push   %rbp
  8021cd:	48 89 e5             	mov    %rsp,%rbp
  8021d0:	48 83 ec 30          	sub    $0x30,%rsp
  8021d4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8021d8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8021dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8021e0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8021e4:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8021e8:	0f b6 00             	movzbl (%rax),%eax
  8021eb:	88 45 ff             	mov    %al,-0x1(%rbp)
  8021ee:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  8021f2:	75 06                	jne    8021fa <strstr+0x2e>
  8021f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8021f8:	eb 6b                	jmp    802265 <strstr+0x99>
  8021fa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8021fe:	48 89 c7             	mov    %rax,%rdi
  802201:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  802208:	00 00 00 
  80220b:	ff d0                	callq  *%rax
  80220d:	48 98                	cltq   
  80220f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802213:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802217:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80221b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80221f:	0f b6 00             	movzbl (%rax),%eax
  802222:	88 45 ef             	mov    %al,-0x11(%rbp)
  802225:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  802229:	75 07                	jne    802232 <strstr+0x66>
  80222b:	b8 00 00 00 00       	mov    $0x0,%eax
  802230:	eb 33                	jmp    802265 <strstr+0x99>
  802232:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  802236:	3a 45 ff             	cmp    -0x1(%rbp),%al
  802239:	75 d8                	jne    802213 <strstr+0x47>
  80223b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80223f:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802243:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802247:	48 89 ce             	mov    %rcx,%rsi
  80224a:	48 89 c7             	mov    %rax,%rdi
  80224d:	48 b8 c3 1c 80 00 00 	movabs $0x801cc3,%rax
  802254:	00 00 00 
  802257:	ff d0                	callq  *%rax
  802259:	85 c0                	test   %eax,%eax
  80225b:	75 b6                	jne    802213 <strstr+0x47>
  80225d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802261:	48 83 e8 01          	sub    $0x1,%rax
  802265:	c9                   	leaveq 
  802266:	c3                   	retq   

0000000000802267 <syscall>:
  802267:	55                   	push   %rbp
  802268:	48 89 e5             	mov    %rsp,%rbp
  80226b:	53                   	push   %rbx
  80226c:	48 83 ec 48          	sub    $0x48,%rsp
  802270:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802273:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802276:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80227a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80227e:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  802282:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  802286:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802289:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80228d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  802291:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  802295:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  802299:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  80229d:	4c 89 c3             	mov    %r8,%rbx
  8022a0:	cd 30                	int    $0x30
  8022a2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8022a6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8022aa:	74 3e                	je     8022ea <syscall+0x83>
  8022ac:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8022b1:	7e 37                	jle    8022ea <syscall+0x83>
  8022b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8022b7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8022ba:	49 89 d0             	mov    %rdx,%r8
  8022bd:	89 c1                	mov    %eax,%ecx
  8022bf:	48 ba e8 54 80 00 00 	movabs $0x8054e8,%rdx
  8022c6:	00 00 00 
  8022c9:	be 24 00 00 00       	mov    $0x24,%esi
  8022ce:	48 bf 05 55 80 00 00 	movabs $0x805505,%rdi
  8022d5:	00 00 00 
  8022d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8022dd:	49 b9 20 0d 80 00 00 	movabs $0x800d20,%r9
  8022e4:	00 00 00 
  8022e7:	41 ff d1             	callq  *%r9
  8022ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022ee:	48 83 c4 48          	add    $0x48,%rsp
  8022f2:	5b                   	pop    %rbx
  8022f3:	5d                   	pop    %rbp
  8022f4:	c3                   	retq   

00000000008022f5 <sys_cputs>:
  8022f5:	55                   	push   %rbp
  8022f6:	48 89 e5             	mov    %rsp,%rbp
  8022f9:	48 83 ec 20          	sub    $0x20,%rsp
  8022fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802301:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802305:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802309:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80230d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802314:	00 
  802315:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80231b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802321:	48 89 d1             	mov    %rdx,%rcx
  802324:	48 89 c2             	mov    %rax,%rdx
  802327:	be 00 00 00 00       	mov    $0x0,%esi
  80232c:	bf 00 00 00 00       	mov    $0x0,%edi
  802331:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802338:	00 00 00 
  80233b:	ff d0                	callq  *%rax
  80233d:	c9                   	leaveq 
  80233e:	c3                   	retq   

000000000080233f <sys_cgetc>:
  80233f:	55                   	push   %rbp
  802340:	48 89 e5             	mov    %rsp,%rbp
  802343:	48 83 ec 10          	sub    $0x10,%rsp
  802347:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80234e:	00 
  80234f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802355:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80235b:	b9 00 00 00 00       	mov    $0x0,%ecx
  802360:	ba 00 00 00 00       	mov    $0x0,%edx
  802365:	be 00 00 00 00       	mov    $0x0,%esi
  80236a:	bf 01 00 00 00       	mov    $0x1,%edi
  80236f:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802376:	00 00 00 
  802379:	ff d0                	callq  *%rax
  80237b:	c9                   	leaveq 
  80237c:	c3                   	retq   

000000000080237d <sys_env_destroy>:
  80237d:	55                   	push   %rbp
  80237e:	48 89 e5             	mov    %rsp,%rbp
  802381:	48 83 ec 10          	sub    $0x10,%rsp
  802385:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802388:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80238b:	48 98                	cltq   
  80238d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802394:	00 
  802395:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80239b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8023a1:	b9 00 00 00 00       	mov    $0x0,%ecx
  8023a6:	48 89 c2             	mov    %rax,%rdx
  8023a9:	be 01 00 00 00       	mov    $0x1,%esi
  8023ae:	bf 03 00 00 00       	mov    $0x3,%edi
  8023b3:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8023ba:	00 00 00 
  8023bd:	ff d0                	callq  *%rax
  8023bf:	c9                   	leaveq 
  8023c0:	c3                   	retq   

00000000008023c1 <sys_getenvid>:
  8023c1:	55                   	push   %rbp
  8023c2:	48 89 e5             	mov    %rsp,%rbp
  8023c5:	48 83 ec 10          	sub    $0x10,%rsp
  8023c9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8023d0:	00 
  8023d1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8023d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8023dd:	b9 00 00 00 00       	mov    $0x0,%ecx
  8023e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8023e7:	be 00 00 00 00       	mov    $0x0,%esi
  8023ec:	bf 02 00 00 00       	mov    $0x2,%edi
  8023f1:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8023f8:	00 00 00 
  8023fb:	ff d0                	callq  *%rax
  8023fd:	c9                   	leaveq 
  8023fe:	c3                   	retq   

00000000008023ff <sys_yield>:
  8023ff:	55                   	push   %rbp
  802400:	48 89 e5             	mov    %rsp,%rbp
  802403:	48 83 ec 10          	sub    $0x10,%rsp
  802407:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80240e:	00 
  80240f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802415:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80241b:	b9 00 00 00 00       	mov    $0x0,%ecx
  802420:	ba 00 00 00 00       	mov    $0x0,%edx
  802425:	be 00 00 00 00       	mov    $0x0,%esi
  80242a:	bf 0b 00 00 00       	mov    $0xb,%edi
  80242f:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802436:	00 00 00 
  802439:	ff d0                	callq  *%rax
  80243b:	c9                   	leaveq 
  80243c:	c3                   	retq   

000000000080243d <sys_page_alloc>:
  80243d:	55                   	push   %rbp
  80243e:	48 89 e5             	mov    %rsp,%rbp
  802441:	48 83 ec 20          	sub    $0x20,%rsp
  802445:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802448:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80244c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80244f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802452:	48 63 c8             	movslq %eax,%rcx
  802455:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802459:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80245c:	48 98                	cltq   
  80245e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802465:	00 
  802466:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80246c:	49 89 c8             	mov    %rcx,%r8
  80246f:	48 89 d1             	mov    %rdx,%rcx
  802472:	48 89 c2             	mov    %rax,%rdx
  802475:	be 01 00 00 00       	mov    $0x1,%esi
  80247a:	bf 04 00 00 00       	mov    $0x4,%edi
  80247f:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802486:	00 00 00 
  802489:	ff d0                	callq  *%rax
  80248b:	c9                   	leaveq 
  80248c:	c3                   	retq   

000000000080248d <sys_page_map>:
  80248d:	55                   	push   %rbp
  80248e:	48 89 e5             	mov    %rsp,%rbp
  802491:	48 83 ec 30          	sub    $0x30,%rsp
  802495:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802498:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80249c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80249f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8024a3:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8024a7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8024aa:	48 63 c8             	movslq %eax,%rcx
  8024ad:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8024b1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8024b4:	48 63 f0             	movslq %eax,%rsi
  8024b7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8024bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024be:	48 98                	cltq   
  8024c0:	48 89 0c 24          	mov    %rcx,(%rsp)
  8024c4:	49 89 f9             	mov    %rdi,%r9
  8024c7:	49 89 f0             	mov    %rsi,%r8
  8024ca:	48 89 d1             	mov    %rdx,%rcx
  8024cd:	48 89 c2             	mov    %rax,%rdx
  8024d0:	be 01 00 00 00       	mov    $0x1,%esi
  8024d5:	bf 05 00 00 00       	mov    $0x5,%edi
  8024da:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8024e1:	00 00 00 
  8024e4:	ff d0                	callq  *%rax
  8024e6:	c9                   	leaveq 
  8024e7:	c3                   	retq   

00000000008024e8 <sys_page_unmap>:
  8024e8:	55                   	push   %rbp
  8024e9:	48 89 e5             	mov    %rsp,%rbp
  8024ec:	48 83 ec 20          	sub    $0x20,%rsp
  8024f0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8024f3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8024f7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8024fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8024fe:	48 98                	cltq   
  802500:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802507:	00 
  802508:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80250e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802514:	48 89 d1             	mov    %rdx,%rcx
  802517:	48 89 c2             	mov    %rax,%rdx
  80251a:	be 01 00 00 00       	mov    $0x1,%esi
  80251f:	bf 06 00 00 00       	mov    $0x6,%edi
  802524:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  80252b:	00 00 00 
  80252e:	ff d0                	callq  *%rax
  802530:	c9                   	leaveq 
  802531:	c3                   	retq   

0000000000802532 <sys_env_set_status>:
  802532:	55                   	push   %rbp
  802533:	48 89 e5             	mov    %rsp,%rbp
  802536:	48 83 ec 10          	sub    $0x10,%rsp
  80253a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80253d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802540:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802543:	48 63 d0             	movslq %eax,%rdx
  802546:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802549:	48 98                	cltq   
  80254b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802552:	00 
  802553:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802559:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80255f:	48 89 d1             	mov    %rdx,%rcx
  802562:	48 89 c2             	mov    %rax,%rdx
  802565:	be 01 00 00 00       	mov    $0x1,%esi
  80256a:	bf 08 00 00 00       	mov    $0x8,%edi
  80256f:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802576:	00 00 00 
  802579:	ff d0                	callq  *%rax
  80257b:	c9                   	leaveq 
  80257c:	c3                   	retq   

000000000080257d <sys_env_set_trapframe>:
  80257d:	55                   	push   %rbp
  80257e:	48 89 e5             	mov    %rsp,%rbp
  802581:	48 83 ec 20          	sub    $0x20,%rsp
  802585:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802588:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80258c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802590:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802593:	48 98                	cltq   
  802595:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80259c:	00 
  80259d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8025a3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8025a9:	48 89 d1             	mov    %rdx,%rcx
  8025ac:	48 89 c2             	mov    %rax,%rdx
  8025af:	be 01 00 00 00       	mov    $0x1,%esi
  8025b4:	bf 09 00 00 00       	mov    $0x9,%edi
  8025b9:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8025c0:	00 00 00 
  8025c3:	ff d0                	callq  *%rax
  8025c5:	c9                   	leaveq 
  8025c6:	c3                   	retq   

00000000008025c7 <sys_env_set_pgfault_upcall>:
  8025c7:	55                   	push   %rbp
  8025c8:	48 89 e5             	mov    %rsp,%rbp
  8025cb:	48 83 ec 20          	sub    $0x20,%rsp
  8025cf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8025d2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8025d6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8025da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025dd:	48 98                	cltq   
  8025df:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8025e6:	00 
  8025e7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8025ed:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8025f3:	48 89 d1             	mov    %rdx,%rcx
  8025f6:	48 89 c2             	mov    %rax,%rdx
  8025f9:	be 01 00 00 00       	mov    $0x1,%esi
  8025fe:	bf 0a 00 00 00       	mov    $0xa,%edi
  802603:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  80260a:	00 00 00 
  80260d:	ff d0                	callq  *%rax
  80260f:	c9                   	leaveq 
  802610:	c3                   	retq   

0000000000802611 <sys_ipc_try_send>:
  802611:	55                   	push   %rbp
  802612:	48 89 e5             	mov    %rsp,%rbp
  802615:	48 83 ec 20          	sub    $0x20,%rsp
  802619:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80261c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802620:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802624:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  802627:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80262a:	48 63 f0             	movslq %eax,%rsi
  80262d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802631:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802634:	48 98                	cltq   
  802636:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80263a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802641:	00 
  802642:	49 89 f1             	mov    %rsi,%r9
  802645:	49 89 c8             	mov    %rcx,%r8
  802648:	48 89 d1             	mov    %rdx,%rcx
  80264b:	48 89 c2             	mov    %rax,%rdx
  80264e:	be 00 00 00 00       	mov    $0x0,%esi
  802653:	bf 0c 00 00 00       	mov    $0xc,%edi
  802658:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  80265f:	00 00 00 
  802662:	ff d0                	callq  *%rax
  802664:	c9                   	leaveq 
  802665:	c3                   	retq   

0000000000802666 <sys_ipc_recv>:
  802666:	55                   	push   %rbp
  802667:	48 89 e5             	mov    %rsp,%rbp
  80266a:	48 83 ec 10          	sub    $0x10,%rsp
  80266e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802672:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802676:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80267d:	00 
  80267e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802684:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80268a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80268f:	48 89 c2             	mov    %rax,%rdx
  802692:	be 01 00 00 00       	mov    $0x1,%esi
  802697:	bf 0d 00 00 00       	mov    $0xd,%edi
  80269c:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8026a3:	00 00 00 
  8026a6:	ff d0                	callq  *%rax
  8026a8:	c9                   	leaveq 
  8026a9:	c3                   	retq   

00000000008026aa <sys_time_msec>:
  8026aa:	55                   	push   %rbp
  8026ab:	48 89 e5             	mov    %rsp,%rbp
  8026ae:	48 83 ec 10          	sub    $0x10,%rsp
  8026b2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8026b9:	00 
  8026ba:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8026c0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8026c6:	b9 00 00 00 00       	mov    $0x0,%ecx
  8026cb:	ba 00 00 00 00       	mov    $0x0,%edx
  8026d0:	be 00 00 00 00       	mov    $0x0,%esi
  8026d5:	bf 0e 00 00 00       	mov    $0xe,%edi
  8026da:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8026e1:	00 00 00 
  8026e4:	ff d0                	callq  *%rax
  8026e6:	c9                   	leaveq 
  8026e7:	c3                   	retq   

00000000008026e8 <sys_net_transmit>:
  8026e8:	55                   	push   %rbp
  8026e9:	48 89 e5             	mov    %rsp,%rbp
  8026ec:	48 83 ec 20          	sub    $0x20,%rsp
  8026f0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8026f4:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8026f7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8026fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8026fe:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802705:	00 
  802706:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80270c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802712:	48 89 d1             	mov    %rdx,%rcx
  802715:	48 89 c2             	mov    %rax,%rdx
  802718:	be 00 00 00 00       	mov    $0x0,%esi
  80271d:	bf 0f 00 00 00       	mov    $0xf,%edi
  802722:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802729:	00 00 00 
  80272c:	ff d0                	callq  *%rax
  80272e:	c9                   	leaveq 
  80272f:	c3                   	retq   

0000000000802730 <sys_net_receive>:
  802730:	55                   	push   %rbp
  802731:	48 89 e5             	mov    %rsp,%rbp
  802734:	48 83 ec 20          	sub    $0x20,%rsp
  802738:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80273c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80273f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802742:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802746:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80274d:	00 
  80274e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802754:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80275a:	48 89 d1             	mov    %rdx,%rcx
  80275d:	48 89 c2             	mov    %rax,%rdx
  802760:	be 00 00 00 00       	mov    $0x0,%esi
  802765:	bf 10 00 00 00       	mov    $0x10,%edi
  80276a:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802771:	00 00 00 
  802774:	ff d0                	callq  *%rax
  802776:	c9                   	leaveq 
  802777:	c3                   	retq   

0000000000802778 <sys_ept_map>:
  802778:	55                   	push   %rbp
  802779:	48 89 e5             	mov    %rsp,%rbp
  80277c:	48 83 ec 30          	sub    $0x30,%rsp
  802780:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802783:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802787:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80278a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80278e:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802792:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802795:	48 63 c8             	movslq %eax,%rcx
  802798:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  80279c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80279f:	48 63 f0             	movslq %eax,%rsi
  8027a2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8027a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027a9:	48 98                	cltq   
  8027ab:	48 89 0c 24          	mov    %rcx,(%rsp)
  8027af:	49 89 f9             	mov    %rdi,%r9
  8027b2:	49 89 f0             	mov    %rsi,%r8
  8027b5:	48 89 d1             	mov    %rdx,%rcx
  8027b8:	48 89 c2             	mov    %rax,%rdx
  8027bb:	be 00 00 00 00       	mov    $0x0,%esi
  8027c0:	bf 11 00 00 00       	mov    $0x11,%edi
  8027c5:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  8027cc:	00 00 00 
  8027cf:	ff d0                	callq  *%rax
  8027d1:	c9                   	leaveq 
  8027d2:	c3                   	retq   

00000000008027d3 <sys_env_mkguest>:
  8027d3:	55                   	push   %rbp
  8027d4:	48 89 e5             	mov    %rsp,%rbp
  8027d7:	48 83 ec 20          	sub    $0x20,%rsp
  8027db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8027df:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8027e3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8027e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8027eb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8027f2:	00 
  8027f3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8027f9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8027ff:	48 89 d1             	mov    %rdx,%rcx
  802802:	48 89 c2             	mov    %rax,%rdx
  802805:	be 00 00 00 00       	mov    $0x0,%esi
  80280a:	bf 12 00 00 00       	mov    $0x12,%edi
  80280f:	48 b8 67 22 80 00 00 	movabs $0x802267,%rax
  802816:	00 00 00 
  802819:	ff d0                	callq  *%rax
  80281b:	c9                   	leaveq 
  80281c:	c3                   	retq   

000000000080281d <ipc_recv>:
  80281d:	55                   	push   %rbp
  80281e:	48 89 e5             	mov    %rsp,%rbp
  802821:	48 83 ec 30          	sub    $0x30,%rsp
  802825:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802829:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80282d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802831:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802836:	75 0e                	jne    802846 <ipc_recv+0x29>
  802838:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80283f:	00 00 00 
  802842:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802846:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80284a:	48 89 c7             	mov    %rax,%rdi
  80284d:	48 b8 66 26 80 00 00 	movabs $0x802666,%rax
  802854:	00 00 00 
  802857:	ff d0                	callq  *%rax
  802859:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80285c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802860:	79 27                	jns    802889 <ipc_recv+0x6c>
  802862:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802867:	74 0a                	je     802873 <ipc_recv+0x56>
  802869:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80286d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802873:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802878:	74 0a                	je     802884 <ipc_recv+0x67>
  80287a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80287e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802884:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802887:	eb 53                	jmp    8028dc <ipc_recv+0xbf>
  802889:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80288e:	74 19                	je     8028a9 <ipc_recv+0x8c>
  802890:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802897:	00 00 00 
  80289a:	48 8b 00             	mov    (%rax),%rax
  80289d:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8028a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028a7:	89 10                	mov    %edx,(%rax)
  8028a9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8028ae:	74 19                	je     8028c9 <ipc_recv+0xac>
  8028b0:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8028b7:	00 00 00 
  8028ba:	48 8b 00             	mov    (%rax),%rax
  8028bd:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  8028c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028c7:	89 10                	mov    %edx,(%rax)
  8028c9:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8028d0:	00 00 00 
  8028d3:	48 8b 00             	mov    (%rax),%rax
  8028d6:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  8028dc:	c9                   	leaveq 
  8028dd:	c3                   	retq   

00000000008028de <ipc_send>:
  8028de:	55                   	push   %rbp
  8028df:	48 89 e5             	mov    %rsp,%rbp
  8028e2:	48 83 ec 30          	sub    $0x30,%rsp
  8028e6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8028e9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8028ec:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8028f0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8028f3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8028f8:	75 10                	jne    80290a <ipc_send+0x2c>
  8028fa:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802901:	00 00 00 
  802904:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802908:	eb 0e                	jmp    802918 <ipc_send+0x3a>
  80290a:	eb 0c                	jmp    802918 <ipc_send+0x3a>
  80290c:	48 b8 ff 23 80 00 00 	movabs $0x8023ff,%rax
  802913:	00 00 00 
  802916:	ff d0                	callq  *%rax
  802918:	8b 75 e8             	mov    -0x18(%rbp),%esi
  80291b:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  80291e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802922:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802925:	89 c7                	mov    %eax,%edi
  802927:	48 b8 11 26 80 00 00 	movabs $0x802611,%rax
  80292e:	00 00 00 
  802931:	ff d0                	callq  *%rax
  802933:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802936:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  80293a:	74 d0                	je     80290c <ipc_send+0x2e>
  80293c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802940:	79 30                	jns    802972 <ipc_send+0x94>
  802942:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802945:	89 c1                	mov    %eax,%ecx
  802947:	48 ba 18 55 80 00 00 	movabs $0x805518,%rdx
  80294e:	00 00 00 
  802951:	be 44 00 00 00       	mov    $0x44,%esi
  802956:	48 bf 2e 55 80 00 00 	movabs $0x80552e,%rdi
  80295d:	00 00 00 
  802960:	b8 00 00 00 00       	mov    $0x0,%eax
  802965:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  80296c:	00 00 00 
  80296f:	41 ff d0             	callq  *%r8
  802972:	c9                   	leaveq 
  802973:	c3                   	retq   

0000000000802974 <ipc_host_recv>:
  802974:	55                   	push   %rbp
  802975:	48 89 e5             	mov    %rsp,%rbp
  802978:	48 83 ec 10          	sub    $0x10,%rsp
  80297c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802980:	48 ba 40 55 80 00 00 	movabs $0x805540,%rdx
  802987:	00 00 00 
  80298a:	be 4e 00 00 00       	mov    $0x4e,%esi
  80298f:	48 bf 2e 55 80 00 00 	movabs $0x80552e,%rdi
  802996:	00 00 00 
  802999:	b8 00 00 00 00       	mov    $0x0,%eax
  80299e:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  8029a5:	00 00 00 
  8029a8:	ff d1                	callq  *%rcx

00000000008029aa <ipc_host_send>:
  8029aa:	55                   	push   %rbp
  8029ab:	48 89 e5             	mov    %rsp,%rbp
  8029ae:	48 83 ec 20          	sub    $0x20,%rsp
  8029b2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8029b5:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8029b8:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  8029bc:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8029bf:	48 ba 60 55 80 00 00 	movabs $0x805560,%rdx
  8029c6:	00 00 00 
  8029c9:	be 67 00 00 00       	mov    $0x67,%esi
  8029ce:	48 bf 2e 55 80 00 00 	movabs $0x80552e,%rdi
  8029d5:	00 00 00 
  8029d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8029dd:	48 b9 20 0d 80 00 00 	movabs $0x800d20,%rcx
  8029e4:	00 00 00 
  8029e7:	ff d1                	callq  *%rcx

00000000008029e9 <ipc_find_env>:
  8029e9:	55                   	push   %rbp
  8029ea:	48 89 e5             	mov    %rsp,%rbp
  8029ed:	48 83 ec 14          	sub    $0x14,%rsp
  8029f1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8029f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8029fb:	eb 4e                	jmp    802a4b <ipc_find_env+0x62>
  8029fd:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802a04:	00 00 00 
  802a07:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a0a:	48 98                	cltq   
  802a0c:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802a13:	48 01 d0             	add    %rdx,%rax
  802a16:	48 05 d0 00 00 00    	add    $0xd0,%rax
  802a1c:	8b 00                	mov    (%rax),%eax
  802a1e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802a21:	75 24                	jne    802a47 <ipc_find_env+0x5e>
  802a23:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802a2a:	00 00 00 
  802a2d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a30:	48 98                	cltq   
  802a32:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802a39:	48 01 d0             	add    %rdx,%rax
  802a3c:	48 05 c0 00 00 00    	add    $0xc0,%rax
  802a42:	8b 40 08             	mov    0x8(%rax),%eax
  802a45:	eb 12                	jmp    802a59 <ipc_find_env+0x70>
  802a47:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802a4b:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  802a52:	7e a9                	jle    8029fd <ipc_find_env+0x14>
  802a54:	b8 00 00 00 00       	mov    $0x0,%eax
  802a59:	c9                   	leaveq 
  802a5a:	c3                   	retq   

0000000000802a5b <fd2num>:
  802a5b:	55                   	push   %rbp
  802a5c:	48 89 e5             	mov    %rsp,%rbp
  802a5f:	48 83 ec 08          	sub    $0x8,%rsp
  802a63:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a67:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802a6b:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  802a72:	ff ff ff 
  802a75:	48 01 d0             	add    %rdx,%rax
  802a78:	48 c1 e8 0c          	shr    $0xc,%rax
  802a7c:	c9                   	leaveq 
  802a7d:	c3                   	retq   

0000000000802a7e <fd2data>:
  802a7e:	55                   	push   %rbp
  802a7f:	48 89 e5             	mov    %rsp,%rbp
  802a82:	48 83 ec 08          	sub    $0x8,%rsp
  802a86:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a8e:	48 89 c7             	mov    %rax,%rdi
  802a91:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  802a98:	00 00 00 
  802a9b:	ff d0                	callq  *%rax
  802a9d:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802aa3:	48 c1 e0 0c          	shl    $0xc,%rax
  802aa7:	c9                   	leaveq 
  802aa8:	c3                   	retq   

0000000000802aa9 <fd_alloc>:
  802aa9:	55                   	push   %rbp
  802aaa:	48 89 e5             	mov    %rsp,%rbp
  802aad:	48 83 ec 18          	sub    $0x18,%rsp
  802ab1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ab5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802abc:	eb 6b                	jmp    802b29 <fd_alloc+0x80>
  802abe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ac1:	48 98                	cltq   
  802ac3:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802ac9:	48 c1 e0 0c          	shl    $0xc,%rax
  802acd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802ad1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ad5:	48 c1 e8 15          	shr    $0x15,%rax
  802ad9:	48 89 c2             	mov    %rax,%rdx
  802adc:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802ae3:	01 00 00 
  802ae6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802aea:	83 e0 01             	and    $0x1,%eax
  802aed:	48 85 c0             	test   %rax,%rax
  802af0:	74 21                	je     802b13 <fd_alloc+0x6a>
  802af2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802af6:	48 c1 e8 0c          	shr    $0xc,%rax
  802afa:	48 89 c2             	mov    %rax,%rdx
  802afd:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802b04:	01 00 00 
  802b07:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b0b:	83 e0 01             	and    $0x1,%eax
  802b0e:	48 85 c0             	test   %rax,%rax
  802b11:	75 12                	jne    802b25 <fd_alloc+0x7c>
  802b13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b17:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b1b:	48 89 10             	mov    %rdx,(%rax)
  802b1e:	b8 00 00 00 00       	mov    $0x0,%eax
  802b23:	eb 1a                	jmp    802b3f <fd_alloc+0x96>
  802b25:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802b29:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802b2d:	7e 8f                	jle    802abe <fd_alloc+0x15>
  802b2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b33:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802b3a:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802b3f:	c9                   	leaveq 
  802b40:	c3                   	retq   

0000000000802b41 <fd_lookup>:
  802b41:	55                   	push   %rbp
  802b42:	48 89 e5             	mov    %rsp,%rbp
  802b45:	48 83 ec 20          	sub    $0x20,%rsp
  802b49:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802b4c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802b50:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802b54:	78 06                	js     802b5c <fd_lookup+0x1b>
  802b56:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802b5a:	7e 07                	jle    802b63 <fd_lookup+0x22>
  802b5c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802b61:	eb 6c                	jmp    802bcf <fd_lookup+0x8e>
  802b63:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802b66:	48 98                	cltq   
  802b68:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802b6e:	48 c1 e0 0c          	shl    $0xc,%rax
  802b72:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802b76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b7a:	48 c1 e8 15          	shr    $0x15,%rax
  802b7e:	48 89 c2             	mov    %rax,%rdx
  802b81:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802b88:	01 00 00 
  802b8b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802b8f:	83 e0 01             	and    $0x1,%eax
  802b92:	48 85 c0             	test   %rax,%rax
  802b95:	74 21                	je     802bb8 <fd_lookup+0x77>
  802b97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b9b:	48 c1 e8 0c          	shr    $0xc,%rax
  802b9f:	48 89 c2             	mov    %rax,%rdx
  802ba2:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ba9:	01 00 00 
  802bac:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802bb0:	83 e0 01             	and    $0x1,%eax
  802bb3:	48 85 c0             	test   %rax,%rax
  802bb6:	75 07                	jne    802bbf <fd_lookup+0x7e>
  802bb8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802bbd:	eb 10                	jmp    802bcf <fd_lookup+0x8e>
  802bbf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802bc3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802bc7:	48 89 10             	mov    %rdx,(%rax)
  802bca:	b8 00 00 00 00       	mov    $0x0,%eax
  802bcf:	c9                   	leaveq 
  802bd0:	c3                   	retq   

0000000000802bd1 <fd_close>:
  802bd1:	55                   	push   %rbp
  802bd2:	48 89 e5             	mov    %rsp,%rbp
  802bd5:	48 83 ec 30          	sub    $0x30,%rsp
  802bd9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802bdd:	89 f0                	mov    %esi,%eax
  802bdf:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802be2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802be6:	48 89 c7             	mov    %rax,%rdi
  802be9:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  802bf0:	00 00 00 
  802bf3:	ff d0                	callq  *%rax
  802bf5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802bf9:	48 89 d6             	mov    %rdx,%rsi
  802bfc:	89 c7                	mov    %eax,%edi
  802bfe:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  802c05:	00 00 00 
  802c08:	ff d0                	callq  *%rax
  802c0a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c0d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c11:	78 0a                	js     802c1d <fd_close+0x4c>
  802c13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c17:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  802c1b:	74 12                	je     802c2f <fd_close+0x5e>
  802c1d:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802c21:	74 05                	je     802c28 <fd_close+0x57>
  802c23:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c26:	eb 05                	jmp    802c2d <fd_close+0x5c>
  802c28:	b8 00 00 00 00       	mov    $0x0,%eax
  802c2d:	eb 69                	jmp    802c98 <fd_close+0xc7>
  802c2f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c33:	8b 00                	mov    (%rax),%eax
  802c35:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c39:	48 89 d6             	mov    %rdx,%rsi
  802c3c:	89 c7                	mov    %eax,%edi
  802c3e:	48 b8 9a 2c 80 00 00 	movabs $0x802c9a,%rax
  802c45:	00 00 00 
  802c48:	ff d0                	callq  *%rax
  802c4a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c4d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c51:	78 2a                	js     802c7d <fd_close+0xac>
  802c53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c57:	48 8b 40 20          	mov    0x20(%rax),%rax
  802c5b:	48 85 c0             	test   %rax,%rax
  802c5e:	74 16                	je     802c76 <fd_close+0xa5>
  802c60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c64:	48 8b 40 20          	mov    0x20(%rax),%rax
  802c68:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802c6c:	48 89 d7             	mov    %rdx,%rdi
  802c6f:	ff d0                	callq  *%rax
  802c71:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c74:	eb 07                	jmp    802c7d <fd_close+0xac>
  802c76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802c7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c81:	48 89 c6             	mov    %rax,%rsi
  802c84:	bf 00 00 00 00       	mov    $0x0,%edi
  802c89:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  802c90:	00 00 00 
  802c93:	ff d0                	callq  *%rax
  802c95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c98:	c9                   	leaveq 
  802c99:	c3                   	retq   

0000000000802c9a <dev_lookup>:
  802c9a:	55                   	push   %rbp
  802c9b:	48 89 e5             	mov    %rsp,%rbp
  802c9e:	48 83 ec 20          	sub    $0x20,%rsp
  802ca2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ca5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802ca9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802cb0:	eb 41                	jmp    802cf3 <dev_lookup+0x59>
  802cb2:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802cb9:	00 00 00 
  802cbc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802cbf:	48 63 d2             	movslq %edx,%rdx
  802cc2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802cc6:	8b 00                	mov    (%rax),%eax
  802cc8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802ccb:	75 22                	jne    802cef <dev_lookup+0x55>
  802ccd:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802cd4:	00 00 00 
  802cd7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802cda:	48 63 d2             	movslq %edx,%rdx
  802cdd:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802ce1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802ce5:	48 89 10             	mov    %rdx,(%rax)
  802ce8:	b8 00 00 00 00       	mov    $0x0,%eax
  802ced:	eb 60                	jmp    802d4f <dev_lookup+0xb5>
  802cef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802cf3:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802cfa:	00 00 00 
  802cfd:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802d00:	48 63 d2             	movslq %edx,%rdx
  802d03:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802d07:	48 85 c0             	test   %rax,%rax
  802d0a:	75 a6                	jne    802cb2 <dev_lookup+0x18>
  802d0c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802d13:	00 00 00 
  802d16:	48 8b 00             	mov    (%rax),%rax
  802d19:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802d1f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802d22:	89 c6                	mov    %eax,%esi
  802d24:	48 bf 80 55 80 00 00 	movabs $0x805580,%rdi
  802d2b:	00 00 00 
  802d2e:	b8 00 00 00 00       	mov    $0x0,%eax
  802d33:	48 b9 59 0f 80 00 00 	movabs $0x800f59,%rcx
  802d3a:	00 00 00 
  802d3d:	ff d1                	callq  *%rcx
  802d3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d43:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802d4a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802d4f:	c9                   	leaveq 
  802d50:	c3                   	retq   

0000000000802d51 <close>:
  802d51:	55                   	push   %rbp
  802d52:	48 89 e5             	mov    %rsp,%rbp
  802d55:	48 83 ec 20          	sub    $0x20,%rsp
  802d59:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d5c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d60:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d63:	48 89 d6             	mov    %rdx,%rsi
  802d66:	89 c7                	mov    %eax,%edi
  802d68:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  802d6f:	00 00 00 
  802d72:	ff d0                	callq  *%rax
  802d74:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d77:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d7b:	79 05                	jns    802d82 <close+0x31>
  802d7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d80:	eb 18                	jmp    802d9a <close+0x49>
  802d82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d86:	be 01 00 00 00       	mov    $0x1,%esi
  802d8b:	48 89 c7             	mov    %rax,%rdi
  802d8e:	48 b8 d1 2b 80 00 00 	movabs $0x802bd1,%rax
  802d95:	00 00 00 
  802d98:	ff d0                	callq  *%rax
  802d9a:	c9                   	leaveq 
  802d9b:	c3                   	retq   

0000000000802d9c <close_all>:
  802d9c:	55                   	push   %rbp
  802d9d:	48 89 e5             	mov    %rsp,%rbp
  802da0:	48 83 ec 10          	sub    $0x10,%rsp
  802da4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802dab:	eb 15                	jmp    802dc2 <close_all+0x26>
  802dad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802db0:	89 c7                	mov    %eax,%edi
  802db2:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  802db9:	00 00 00 
  802dbc:	ff d0                	callq  *%rax
  802dbe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802dc2:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802dc6:	7e e5                	jle    802dad <close_all+0x11>
  802dc8:	c9                   	leaveq 
  802dc9:	c3                   	retq   

0000000000802dca <dup>:
  802dca:	55                   	push   %rbp
  802dcb:	48 89 e5             	mov    %rsp,%rbp
  802dce:	48 83 ec 40          	sub    $0x40,%rsp
  802dd2:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802dd5:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802dd8:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802ddc:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802ddf:	48 89 d6             	mov    %rdx,%rsi
  802de2:	89 c7                	mov    %eax,%edi
  802de4:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  802deb:	00 00 00 
  802dee:	ff d0                	callq  *%rax
  802df0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802df3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802df7:	79 08                	jns    802e01 <dup+0x37>
  802df9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dfc:	e9 70 01 00 00       	jmpq   802f71 <dup+0x1a7>
  802e01:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802e04:	89 c7                	mov    %eax,%edi
  802e06:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  802e0d:	00 00 00 
  802e10:	ff d0                	callq  *%rax
  802e12:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802e15:	48 98                	cltq   
  802e17:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802e1d:	48 c1 e0 0c          	shl    $0xc,%rax
  802e21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802e25:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e29:	48 89 c7             	mov    %rax,%rdi
  802e2c:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  802e33:	00 00 00 
  802e36:	ff d0                	callq  *%rax
  802e38:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802e3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e40:	48 89 c7             	mov    %rax,%rdi
  802e43:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  802e4a:	00 00 00 
  802e4d:	ff d0                	callq  *%rax
  802e4f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802e53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e57:	48 c1 e8 15          	shr    $0x15,%rax
  802e5b:	48 89 c2             	mov    %rax,%rdx
  802e5e:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802e65:	01 00 00 
  802e68:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802e6c:	83 e0 01             	and    $0x1,%eax
  802e6f:	48 85 c0             	test   %rax,%rax
  802e72:	74 73                	je     802ee7 <dup+0x11d>
  802e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e78:	48 c1 e8 0c          	shr    $0xc,%rax
  802e7c:	48 89 c2             	mov    %rax,%rdx
  802e7f:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802e86:	01 00 00 
  802e89:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802e8d:	83 e0 01             	and    $0x1,%eax
  802e90:	48 85 c0             	test   %rax,%rax
  802e93:	74 52                	je     802ee7 <dup+0x11d>
  802e95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e99:	48 c1 e8 0c          	shr    $0xc,%rax
  802e9d:	48 89 c2             	mov    %rax,%rdx
  802ea0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ea7:	01 00 00 
  802eaa:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802eae:	25 07 0e 00 00       	and    $0xe07,%eax
  802eb3:	89 c1                	mov    %eax,%ecx
  802eb5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802eb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ebd:	41 89 c8             	mov    %ecx,%r8d
  802ec0:	48 89 d1             	mov    %rdx,%rcx
  802ec3:	ba 00 00 00 00       	mov    $0x0,%edx
  802ec8:	48 89 c6             	mov    %rax,%rsi
  802ecb:	bf 00 00 00 00       	mov    $0x0,%edi
  802ed0:	48 b8 8d 24 80 00 00 	movabs $0x80248d,%rax
  802ed7:	00 00 00 
  802eda:	ff d0                	callq  *%rax
  802edc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802edf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ee3:	79 02                	jns    802ee7 <dup+0x11d>
  802ee5:	eb 57                	jmp    802f3e <dup+0x174>
  802ee7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802eeb:	48 c1 e8 0c          	shr    $0xc,%rax
  802eef:	48 89 c2             	mov    %rax,%rdx
  802ef2:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ef9:	01 00 00 
  802efc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802f00:	25 07 0e 00 00       	and    $0xe07,%eax
  802f05:	89 c1                	mov    %eax,%ecx
  802f07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802f0b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802f0f:	41 89 c8             	mov    %ecx,%r8d
  802f12:	48 89 d1             	mov    %rdx,%rcx
  802f15:	ba 00 00 00 00       	mov    $0x0,%edx
  802f1a:	48 89 c6             	mov    %rax,%rsi
  802f1d:	bf 00 00 00 00       	mov    $0x0,%edi
  802f22:	48 b8 8d 24 80 00 00 	movabs $0x80248d,%rax
  802f29:	00 00 00 
  802f2c:	ff d0                	callq  *%rax
  802f2e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f31:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f35:	79 02                	jns    802f39 <dup+0x16f>
  802f37:	eb 05                	jmp    802f3e <dup+0x174>
  802f39:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802f3c:	eb 33                	jmp    802f71 <dup+0x1a7>
  802f3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f42:	48 89 c6             	mov    %rax,%rsi
  802f45:	bf 00 00 00 00       	mov    $0x0,%edi
  802f4a:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  802f51:	00 00 00 
  802f54:	ff d0                	callq  *%rax
  802f56:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f5a:	48 89 c6             	mov    %rax,%rsi
  802f5d:	bf 00 00 00 00       	mov    $0x0,%edi
  802f62:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  802f69:	00 00 00 
  802f6c:	ff d0                	callq  *%rax
  802f6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f71:	c9                   	leaveq 
  802f72:	c3                   	retq   

0000000000802f73 <read>:
  802f73:	55                   	push   %rbp
  802f74:	48 89 e5             	mov    %rsp,%rbp
  802f77:	48 83 ec 40          	sub    $0x40,%rsp
  802f7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802f7e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802f82:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802f86:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802f8a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802f8d:	48 89 d6             	mov    %rdx,%rsi
  802f90:	89 c7                	mov    %eax,%edi
  802f92:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  802f99:	00 00 00 
  802f9c:	ff d0                	callq  *%rax
  802f9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fa1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fa5:	78 24                	js     802fcb <read+0x58>
  802fa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fab:	8b 00                	mov    (%rax),%eax
  802fad:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802fb1:	48 89 d6             	mov    %rdx,%rsi
  802fb4:	89 c7                	mov    %eax,%edi
  802fb6:	48 b8 9a 2c 80 00 00 	movabs $0x802c9a,%rax
  802fbd:	00 00 00 
  802fc0:	ff d0                	callq  *%rax
  802fc2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802fc5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802fc9:	79 05                	jns    802fd0 <read+0x5d>
  802fcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fce:	eb 76                	jmp    803046 <read+0xd3>
  802fd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fd4:	8b 40 08             	mov    0x8(%rax),%eax
  802fd7:	83 e0 03             	and    $0x3,%eax
  802fda:	83 f8 01             	cmp    $0x1,%eax
  802fdd:	75 3a                	jne    803019 <read+0xa6>
  802fdf:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802fe6:	00 00 00 
  802fe9:	48 8b 00             	mov    (%rax),%rax
  802fec:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802ff2:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802ff5:	89 c6                	mov    %eax,%esi
  802ff7:	48 bf 9f 55 80 00 00 	movabs $0x80559f,%rdi
  802ffe:	00 00 00 
  803001:	b8 00 00 00 00       	mov    $0x0,%eax
  803006:	48 b9 59 0f 80 00 00 	movabs $0x800f59,%rcx
  80300d:	00 00 00 
  803010:	ff d1                	callq  *%rcx
  803012:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803017:	eb 2d                	jmp    803046 <read+0xd3>
  803019:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80301d:	48 8b 40 10          	mov    0x10(%rax),%rax
  803021:	48 85 c0             	test   %rax,%rax
  803024:	75 07                	jne    80302d <read+0xba>
  803026:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80302b:	eb 19                	jmp    803046 <read+0xd3>
  80302d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803031:	48 8b 40 10          	mov    0x10(%rax),%rax
  803035:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803039:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80303d:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  803041:	48 89 cf             	mov    %rcx,%rdi
  803044:	ff d0                	callq  *%rax
  803046:	c9                   	leaveq 
  803047:	c3                   	retq   

0000000000803048 <readn>:
  803048:	55                   	push   %rbp
  803049:	48 89 e5             	mov    %rsp,%rbp
  80304c:	48 83 ec 30          	sub    $0x30,%rsp
  803050:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803053:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803057:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80305b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803062:	eb 49                	jmp    8030ad <readn+0x65>
  803064:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803067:	48 98                	cltq   
  803069:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80306d:	48 29 c2             	sub    %rax,%rdx
  803070:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803073:	48 63 c8             	movslq %eax,%rcx
  803076:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80307a:	48 01 c1             	add    %rax,%rcx
  80307d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803080:	48 89 ce             	mov    %rcx,%rsi
  803083:	89 c7                	mov    %eax,%edi
  803085:	48 b8 73 2f 80 00 00 	movabs $0x802f73,%rax
  80308c:	00 00 00 
  80308f:	ff d0                	callq  *%rax
  803091:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803094:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803098:	79 05                	jns    80309f <readn+0x57>
  80309a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80309d:	eb 1c                	jmp    8030bb <readn+0x73>
  80309f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8030a3:	75 02                	jne    8030a7 <readn+0x5f>
  8030a5:	eb 11                	jmp    8030b8 <readn+0x70>
  8030a7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8030aa:	01 45 fc             	add    %eax,-0x4(%rbp)
  8030ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030b0:	48 98                	cltq   
  8030b2:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8030b6:	72 ac                	jb     803064 <readn+0x1c>
  8030b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030bb:	c9                   	leaveq 
  8030bc:	c3                   	retq   

00000000008030bd <write>:
  8030bd:	55                   	push   %rbp
  8030be:	48 89 e5             	mov    %rsp,%rbp
  8030c1:	48 83 ec 40          	sub    $0x40,%rsp
  8030c5:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8030c8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8030cc:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8030d0:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8030d4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8030d7:	48 89 d6             	mov    %rdx,%rsi
  8030da:	89 c7                	mov    %eax,%edi
  8030dc:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  8030e3:	00 00 00 
  8030e6:	ff d0                	callq  *%rax
  8030e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030ef:	78 24                	js     803115 <write+0x58>
  8030f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030f5:	8b 00                	mov    (%rax),%eax
  8030f7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8030fb:	48 89 d6             	mov    %rdx,%rsi
  8030fe:	89 c7                	mov    %eax,%edi
  803100:	48 b8 9a 2c 80 00 00 	movabs $0x802c9a,%rax
  803107:	00 00 00 
  80310a:	ff d0                	callq  *%rax
  80310c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80310f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803113:	79 05                	jns    80311a <write+0x5d>
  803115:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803118:	eb 75                	jmp    80318f <write+0xd2>
  80311a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80311e:	8b 40 08             	mov    0x8(%rax),%eax
  803121:	83 e0 03             	and    $0x3,%eax
  803124:	85 c0                	test   %eax,%eax
  803126:	75 3a                	jne    803162 <write+0xa5>
  803128:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80312f:	00 00 00 
  803132:	48 8b 00             	mov    (%rax),%rax
  803135:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80313b:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80313e:	89 c6                	mov    %eax,%esi
  803140:	48 bf bb 55 80 00 00 	movabs $0x8055bb,%rdi
  803147:	00 00 00 
  80314a:	b8 00 00 00 00       	mov    $0x0,%eax
  80314f:	48 b9 59 0f 80 00 00 	movabs $0x800f59,%rcx
  803156:	00 00 00 
  803159:	ff d1                	callq  *%rcx
  80315b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803160:	eb 2d                	jmp    80318f <write+0xd2>
  803162:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803166:	48 8b 40 18          	mov    0x18(%rax),%rax
  80316a:	48 85 c0             	test   %rax,%rax
  80316d:	75 07                	jne    803176 <write+0xb9>
  80316f:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803174:	eb 19                	jmp    80318f <write+0xd2>
  803176:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80317a:	48 8b 40 18          	mov    0x18(%rax),%rax
  80317e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803182:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803186:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  80318a:	48 89 cf             	mov    %rcx,%rdi
  80318d:	ff d0                	callq  *%rax
  80318f:	c9                   	leaveq 
  803190:	c3                   	retq   

0000000000803191 <seek>:
  803191:	55                   	push   %rbp
  803192:	48 89 e5             	mov    %rsp,%rbp
  803195:	48 83 ec 18          	sub    $0x18,%rsp
  803199:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80319c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80319f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8031a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8031a6:	48 89 d6             	mov    %rdx,%rsi
  8031a9:	89 c7                	mov    %eax,%edi
  8031ab:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  8031b2:	00 00 00 
  8031b5:	ff d0                	callq  *%rax
  8031b7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031be:	79 05                	jns    8031c5 <seek+0x34>
  8031c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031c3:	eb 0f                	jmp    8031d4 <seek+0x43>
  8031c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031c9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8031cc:	89 50 04             	mov    %edx,0x4(%rax)
  8031cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8031d4:	c9                   	leaveq 
  8031d5:	c3                   	retq   

00000000008031d6 <ftruncate>:
  8031d6:	55                   	push   %rbp
  8031d7:	48 89 e5             	mov    %rsp,%rbp
  8031da:	48 83 ec 30          	sub    $0x30,%rsp
  8031de:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8031e1:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8031e4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8031e8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8031eb:	48 89 d6             	mov    %rdx,%rsi
  8031ee:	89 c7                	mov    %eax,%edi
  8031f0:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  8031f7:	00 00 00 
  8031fa:	ff d0                	callq  *%rax
  8031fc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031ff:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803203:	78 24                	js     803229 <ftruncate+0x53>
  803205:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803209:	8b 00                	mov    (%rax),%eax
  80320b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80320f:	48 89 d6             	mov    %rdx,%rsi
  803212:	89 c7                	mov    %eax,%edi
  803214:	48 b8 9a 2c 80 00 00 	movabs $0x802c9a,%rax
  80321b:	00 00 00 
  80321e:	ff d0                	callq  *%rax
  803220:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803223:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803227:	79 05                	jns    80322e <ftruncate+0x58>
  803229:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80322c:	eb 72                	jmp    8032a0 <ftruncate+0xca>
  80322e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803232:	8b 40 08             	mov    0x8(%rax),%eax
  803235:	83 e0 03             	and    $0x3,%eax
  803238:	85 c0                	test   %eax,%eax
  80323a:	75 3a                	jne    803276 <ftruncate+0xa0>
  80323c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803243:	00 00 00 
  803246:	48 8b 00             	mov    (%rax),%rax
  803249:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80324f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803252:	89 c6                	mov    %eax,%esi
  803254:	48 bf d8 55 80 00 00 	movabs $0x8055d8,%rdi
  80325b:	00 00 00 
  80325e:	b8 00 00 00 00       	mov    $0x0,%eax
  803263:	48 b9 59 0f 80 00 00 	movabs $0x800f59,%rcx
  80326a:	00 00 00 
  80326d:	ff d1                	callq  *%rcx
  80326f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803274:	eb 2a                	jmp    8032a0 <ftruncate+0xca>
  803276:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80327a:	48 8b 40 30          	mov    0x30(%rax),%rax
  80327e:	48 85 c0             	test   %rax,%rax
  803281:	75 07                	jne    80328a <ftruncate+0xb4>
  803283:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803288:	eb 16                	jmp    8032a0 <ftruncate+0xca>
  80328a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80328e:	48 8b 40 30          	mov    0x30(%rax),%rax
  803292:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803296:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  803299:	89 ce                	mov    %ecx,%esi
  80329b:	48 89 d7             	mov    %rdx,%rdi
  80329e:	ff d0                	callq  *%rax
  8032a0:	c9                   	leaveq 
  8032a1:	c3                   	retq   

00000000008032a2 <fstat>:
  8032a2:	55                   	push   %rbp
  8032a3:	48 89 e5             	mov    %rsp,%rbp
  8032a6:	48 83 ec 30          	sub    $0x30,%rsp
  8032aa:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8032ad:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8032b1:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8032b5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8032b8:	48 89 d6             	mov    %rdx,%rsi
  8032bb:	89 c7                	mov    %eax,%edi
  8032bd:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  8032c4:	00 00 00 
  8032c7:	ff d0                	callq  *%rax
  8032c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032d0:	78 24                	js     8032f6 <fstat+0x54>
  8032d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8032d6:	8b 00                	mov    (%rax),%eax
  8032d8:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8032dc:	48 89 d6             	mov    %rdx,%rsi
  8032df:	89 c7                	mov    %eax,%edi
  8032e1:	48 b8 9a 2c 80 00 00 	movabs $0x802c9a,%rax
  8032e8:	00 00 00 
  8032eb:	ff d0                	callq  *%rax
  8032ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032f4:	79 05                	jns    8032fb <fstat+0x59>
  8032f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032f9:	eb 5e                	jmp    803359 <fstat+0xb7>
  8032fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8032ff:	48 8b 40 28          	mov    0x28(%rax),%rax
  803303:	48 85 c0             	test   %rax,%rax
  803306:	75 07                	jne    80330f <fstat+0x6d>
  803308:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80330d:	eb 4a                	jmp    803359 <fstat+0xb7>
  80330f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803313:	c6 00 00             	movb   $0x0,(%rax)
  803316:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80331a:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  803321:	00 00 00 
  803324:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803328:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80332f:	00 00 00 
  803332:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803336:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80333a:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  803341:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803345:	48 8b 40 28          	mov    0x28(%rax),%rax
  803349:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80334d:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  803351:	48 89 ce             	mov    %rcx,%rsi
  803354:	48 89 d7             	mov    %rdx,%rdi
  803357:	ff d0                	callq  *%rax
  803359:	c9                   	leaveq 
  80335a:	c3                   	retq   

000000000080335b <stat>:
  80335b:	55                   	push   %rbp
  80335c:	48 89 e5             	mov    %rsp,%rbp
  80335f:	48 83 ec 20          	sub    $0x20,%rsp
  803363:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803367:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80336b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80336f:	be 00 00 00 00       	mov    $0x0,%esi
  803374:	48 89 c7             	mov    %rax,%rdi
  803377:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  80337e:	00 00 00 
  803381:	ff d0                	callq  *%rax
  803383:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803386:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80338a:	79 05                	jns    803391 <stat+0x36>
  80338c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80338f:	eb 2f                	jmp    8033c0 <stat+0x65>
  803391:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803395:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803398:	48 89 d6             	mov    %rdx,%rsi
  80339b:	89 c7                	mov    %eax,%edi
  80339d:	48 b8 a2 32 80 00 00 	movabs $0x8032a2,%rax
  8033a4:	00 00 00 
  8033a7:	ff d0                	callq  *%rax
  8033a9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8033ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033af:	89 c7                	mov    %eax,%edi
  8033b1:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  8033b8:	00 00 00 
  8033bb:	ff d0                	callq  *%rax
  8033bd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033c0:	c9                   	leaveq 
  8033c1:	c3                   	retq   

00000000008033c2 <fsipc>:
  8033c2:	55                   	push   %rbp
  8033c3:	48 89 e5             	mov    %rsp,%rbp
  8033c6:	48 83 ec 10          	sub    $0x10,%rsp
  8033ca:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8033cd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8033d1:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8033d8:	00 00 00 
  8033db:	8b 00                	mov    (%rax),%eax
  8033dd:	85 c0                	test   %eax,%eax
  8033df:	75 1d                	jne    8033fe <fsipc+0x3c>
  8033e1:	bf 01 00 00 00       	mov    $0x1,%edi
  8033e6:	48 b8 e9 29 80 00 00 	movabs $0x8029e9,%rax
  8033ed:	00 00 00 
  8033f0:	ff d0                	callq  *%rax
  8033f2:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  8033f9:	00 00 00 
  8033fc:	89 02                	mov    %eax,(%rdx)
  8033fe:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  803405:	00 00 00 
  803408:	8b 00                	mov    (%rax),%eax
  80340a:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80340d:	b9 07 00 00 00       	mov    $0x7,%ecx
  803412:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  803419:	00 00 00 
  80341c:	89 c7                	mov    %eax,%edi
  80341e:	48 b8 de 28 80 00 00 	movabs $0x8028de,%rax
  803425:	00 00 00 
  803428:	ff d0                	callq  *%rax
  80342a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80342e:	ba 00 00 00 00       	mov    $0x0,%edx
  803433:	48 89 c6             	mov    %rax,%rsi
  803436:	bf 00 00 00 00       	mov    $0x0,%edi
  80343b:	48 b8 1d 28 80 00 00 	movabs $0x80281d,%rax
  803442:	00 00 00 
  803445:	ff d0                	callq  *%rax
  803447:	c9                   	leaveq 
  803448:	c3                   	retq   

0000000000803449 <open>:
  803449:	55                   	push   %rbp
  80344a:	48 89 e5             	mov    %rsp,%rbp
  80344d:	48 83 ec 20          	sub    $0x20,%rsp
  803451:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803455:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  803458:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80345c:	48 89 c7             	mov    %rax,%rdi
  80345f:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  803466:	00 00 00 
  803469:	ff d0                	callq  *%rax
  80346b:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803470:	7e 0a                	jle    80347c <open+0x33>
  803472:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803477:	e9 a5 00 00 00       	jmpq   803521 <open+0xd8>
  80347c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803480:	48 89 c7             	mov    %rax,%rdi
  803483:	48 b8 a9 2a 80 00 00 	movabs $0x802aa9,%rax
  80348a:	00 00 00 
  80348d:	ff d0                	callq  *%rax
  80348f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803492:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803496:	79 08                	jns    8034a0 <open+0x57>
  803498:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80349b:	e9 81 00 00 00       	jmpq   803521 <open+0xd8>
  8034a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034a4:	48 89 c6             	mov    %rax,%rsi
  8034a7:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8034ae:	00 00 00 
  8034b1:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  8034b8:	00 00 00 
  8034bb:	ff d0                	callq  *%rax
  8034bd:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034c4:	00 00 00 
  8034c7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8034ca:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8034d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8034d4:	48 89 c6             	mov    %rax,%rsi
  8034d7:	bf 01 00 00 00       	mov    $0x1,%edi
  8034dc:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  8034e3:	00 00 00 
  8034e6:	ff d0                	callq  *%rax
  8034e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034ef:	79 1d                	jns    80350e <open+0xc5>
  8034f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8034f5:	be 00 00 00 00       	mov    $0x0,%esi
  8034fa:	48 89 c7             	mov    %rax,%rdi
  8034fd:	48 b8 d1 2b 80 00 00 	movabs $0x802bd1,%rax
  803504:	00 00 00 
  803507:	ff d0                	callq  *%rax
  803509:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80350c:	eb 13                	jmp    803521 <open+0xd8>
  80350e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803512:	48 89 c7             	mov    %rax,%rdi
  803515:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  80351c:	00 00 00 
  80351f:	ff d0                	callq  *%rax
  803521:	c9                   	leaveq 
  803522:	c3                   	retq   

0000000000803523 <devfile_flush>:
  803523:	55                   	push   %rbp
  803524:	48 89 e5             	mov    %rsp,%rbp
  803527:	48 83 ec 10          	sub    $0x10,%rsp
  80352b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80352f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803533:	8b 50 0c             	mov    0xc(%rax),%edx
  803536:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80353d:	00 00 00 
  803540:	89 10                	mov    %edx,(%rax)
  803542:	be 00 00 00 00       	mov    $0x0,%esi
  803547:	bf 06 00 00 00       	mov    $0x6,%edi
  80354c:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  803553:	00 00 00 
  803556:	ff d0                	callq  *%rax
  803558:	c9                   	leaveq 
  803559:	c3                   	retq   

000000000080355a <devfile_read>:
  80355a:	55                   	push   %rbp
  80355b:	48 89 e5             	mov    %rsp,%rbp
  80355e:	48 83 ec 30          	sub    $0x30,%rsp
  803562:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803566:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80356a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80356e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803572:	8b 50 0c             	mov    0xc(%rax),%edx
  803575:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80357c:	00 00 00 
  80357f:	89 10                	mov    %edx,(%rax)
  803581:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803588:	00 00 00 
  80358b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80358f:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803593:	be 00 00 00 00       	mov    $0x0,%esi
  803598:	bf 03 00 00 00       	mov    $0x3,%edi
  80359d:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  8035a4:	00 00 00 
  8035a7:	ff d0                	callq  *%rax
  8035a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035b0:	79 08                	jns    8035ba <devfile_read+0x60>
  8035b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035b5:	e9 a4 00 00 00       	jmpq   80365e <devfile_read+0x104>
  8035ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035bd:	48 98                	cltq   
  8035bf:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8035c3:	76 35                	jbe    8035fa <devfile_read+0xa0>
  8035c5:	48 b9 fe 55 80 00 00 	movabs $0x8055fe,%rcx
  8035cc:	00 00 00 
  8035cf:	48 ba 05 56 80 00 00 	movabs $0x805605,%rdx
  8035d6:	00 00 00 
  8035d9:	be 89 00 00 00       	mov    $0x89,%esi
  8035de:	48 bf 1a 56 80 00 00 	movabs $0x80561a,%rdi
  8035e5:	00 00 00 
  8035e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8035ed:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8035f4:	00 00 00 
  8035f7:	41 ff d0             	callq  *%r8
  8035fa:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803601:	7e 35                	jle    803638 <devfile_read+0xde>
  803603:	48 b9 28 56 80 00 00 	movabs $0x805628,%rcx
  80360a:	00 00 00 
  80360d:	48 ba 05 56 80 00 00 	movabs $0x805605,%rdx
  803614:	00 00 00 
  803617:	be 8a 00 00 00       	mov    $0x8a,%esi
  80361c:	48 bf 1a 56 80 00 00 	movabs $0x80561a,%rdi
  803623:	00 00 00 
  803626:	b8 00 00 00 00       	mov    $0x0,%eax
  80362b:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  803632:	00 00 00 
  803635:	41 ff d0             	callq  *%r8
  803638:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80363b:	48 63 d0             	movslq %eax,%rdx
  80363e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803642:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803649:	00 00 00 
  80364c:	48 89 c7             	mov    %rax,%rdi
  80364f:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  803656:	00 00 00 
  803659:	ff d0                	callq  *%rax
  80365b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80365e:	c9                   	leaveq 
  80365f:	c3                   	retq   

0000000000803660 <devfile_write>:
  803660:	55                   	push   %rbp
  803661:	48 89 e5             	mov    %rsp,%rbp
  803664:	48 83 ec 40          	sub    $0x40,%rsp
  803668:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80366c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803670:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803674:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803678:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80367c:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  803683:	00 
  803684:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803688:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  80368c:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  803691:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  803695:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803699:	8b 50 0c             	mov    0xc(%rax),%edx
  80369c:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8036a3:	00 00 00 
  8036a6:	89 10                	mov    %edx,(%rax)
  8036a8:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8036af:	00 00 00 
  8036b2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8036b6:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8036ba:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8036be:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8036c2:	48 89 c6             	mov    %rax,%rsi
  8036c5:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  8036cc:	00 00 00 
  8036cf:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  8036d6:	00 00 00 
  8036d9:	ff d0                	callq  *%rax
  8036db:	be 00 00 00 00       	mov    $0x0,%esi
  8036e0:	bf 04 00 00 00       	mov    $0x4,%edi
  8036e5:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  8036ec:	00 00 00 
  8036ef:	ff d0                	callq  *%rax
  8036f1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8036f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8036f8:	79 05                	jns    8036ff <devfile_write+0x9f>
  8036fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036fd:	eb 43                	jmp    803742 <devfile_write+0xe2>
  8036ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803702:	48 98                	cltq   
  803704:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803708:	76 35                	jbe    80373f <devfile_write+0xdf>
  80370a:	48 b9 fe 55 80 00 00 	movabs $0x8055fe,%rcx
  803711:	00 00 00 
  803714:	48 ba 05 56 80 00 00 	movabs $0x805605,%rdx
  80371b:	00 00 00 
  80371e:	be a8 00 00 00       	mov    $0xa8,%esi
  803723:	48 bf 1a 56 80 00 00 	movabs $0x80561a,%rdi
  80372a:	00 00 00 
  80372d:	b8 00 00 00 00       	mov    $0x0,%eax
  803732:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  803739:	00 00 00 
  80373c:	41 ff d0             	callq  *%r8
  80373f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803742:	c9                   	leaveq 
  803743:	c3                   	retq   

0000000000803744 <devfile_stat>:
  803744:	55                   	push   %rbp
  803745:	48 89 e5             	mov    %rsp,%rbp
  803748:	48 83 ec 20          	sub    $0x20,%rsp
  80374c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803750:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803754:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803758:	8b 50 0c             	mov    0xc(%rax),%edx
  80375b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803762:	00 00 00 
  803765:	89 10                	mov    %edx,(%rax)
  803767:	be 00 00 00 00       	mov    $0x0,%esi
  80376c:	bf 05 00 00 00       	mov    $0x5,%edi
  803771:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  803778:	00 00 00 
  80377b:	ff d0                	callq  *%rax
  80377d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803780:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803784:	79 05                	jns    80378b <devfile_stat+0x47>
  803786:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803789:	eb 56                	jmp    8037e1 <devfile_stat+0x9d>
  80378b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80378f:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803796:	00 00 00 
  803799:	48 89 c7             	mov    %rax,%rdi
  80379c:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  8037a3:	00 00 00 
  8037a6:	ff d0                	callq  *%rax
  8037a8:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8037af:	00 00 00 
  8037b2:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8037b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8037bc:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8037c2:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8037c9:	00 00 00 
  8037cc:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  8037d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8037d6:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  8037dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8037e1:	c9                   	leaveq 
  8037e2:	c3                   	retq   

00000000008037e3 <devfile_trunc>:
  8037e3:	55                   	push   %rbp
  8037e4:	48 89 e5             	mov    %rsp,%rbp
  8037e7:	48 83 ec 10          	sub    $0x10,%rsp
  8037eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037ef:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8037f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037f6:	8b 50 0c             	mov    0xc(%rax),%edx
  8037f9:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803800:	00 00 00 
  803803:	89 10                	mov    %edx,(%rax)
  803805:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80380c:	00 00 00 
  80380f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803812:	89 50 04             	mov    %edx,0x4(%rax)
  803815:	be 00 00 00 00       	mov    $0x0,%esi
  80381a:	bf 02 00 00 00       	mov    $0x2,%edi
  80381f:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  803826:	00 00 00 
  803829:	ff d0                	callq  *%rax
  80382b:	c9                   	leaveq 
  80382c:	c3                   	retq   

000000000080382d <remove>:
  80382d:	55                   	push   %rbp
  80382e:	48 89 e5             	mov    %rsp,%rbp
  803831:	48 83 ec 10          	sub    $0x10,%rsp
  803835:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803839:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80383d:	48 89 c7             	mov    %rax,%rdi
  803840:	48 b8 a2 1a 80 00 00 	movabs $0x801aa2,%rax
  803847:	00 00 00 
  80384a:	ff d0                	callq  *%rax
  80384c:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803851:	7e 07                	jle    80385a <remove+0x2d>
  803853:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803858:	eb 33                	jmp    80388d <remove+0x60>
  80385a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80385e:	48 89 c6             	mov    %rax,%rsi
  803861:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  803868:	00 00 00 
  80386b:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  803872:	00 00 00 
  803875:	ff d0                	callq  *%rax
  803877:	be 00 00 00 00       	mov    $0x0,%esi
  80387c:	bf 07 00 00 00       	mov    $0x7,%edi
  803881:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  803888:	00 00 00 
  80388b:	ff d0                	callq  *%rax
  80388d:	c9                   	leaveq 
  80388e:	c3                   	retq   

000000000080388f <sync>:
  80388f:	55                   	push   %rbp
  803890:	48 89 e5             	mov    %rsp,%rbp
  803893:	be 00 00 00 00       	mov    $0x0,%esi
  803898:	bf 08 00 00 00       	mov    $0x8,%edi
  80389d:	48 b8 c2 33 80 00 00 	movabs $0x8033c2,%rax
  8038a4:	00 00 00 
  8038a7:	ff d0                	callq  *%rax
  8038a9:	5d                   	pop    %rbp
  8038aa:	c3                   	retq   

00000000008038ab <copy>:
  8038ab:	55                   	push   %rbp
  8038ac:	48 89 e5             	mov    %rsp,%rbp
  8038af:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8038b6:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  8038bd:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  8038c4:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  8038cb:	be 00 00 00 00       	mov    $0x0,%esi
  8038d0:	48 89 c7             	mov    %rax,%rdi
  8038d3:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  8038da:	00 00 00 
  8038dd:	ff d0                	callq  *%rax
  8038df:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038e6:	79 28                	jns    803910 <copy+0x65>
  8038e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038eb:	89 c6                	mov    %eax,%esi
  8038ed:	48 bf 34 56 80 00 00 	movabs $0x805634,%rdi
  8038f4:	00 00 00 
  8038f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8038fc:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  803903:	00 00 00 
  803906:	ff d2                	callq  *%rdx
  803908:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80390b:	e9 74 01 00 00       	jmpq   803a84 <copy+0x1d9>
  803910:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803917:	be 01 01 00 00       	mov    $0x101,%esi
  80391c:	48 89 c7             	mov    %rax,%rdi
  80391f:	48 b8 49 34 80 00 00 	movabs $0x803449,%rax
  803926:	00 00 00 
  803929:	ff d0                	callq  *%rax
  80392b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80392e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803932:	79 39                	jns    80396d <copy+0xc2>
  803934:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803937:	89 c6                	mov    %eax,%esi
  803939:	48 bf 4a 56 80 00 00 	movabs $0x80564a,%rdi
  803940:	00 00 00 
  803943:	b8 00 00 00 00       	mov    $0x0,%eax
  803948:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  80394f:	00 00 00 
  803952:	ff d2                	callq  *%rdx
  803954:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803957:	89 c7                	mov    %eax,%edi
  803959:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  803960:	00 00 00 
  803963:	ff d0                	callq  *%rax
  803965:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803968:	e9 17 01 00 00       	jmpq   803a84 <copy+0x1d9>
  80396d:	eb 74                	jmp    8039e3 <copy+0x138>
  80396f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803972:	48 63 d0             	movslq %eax,%rdx
  803975:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80397c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80397f:	48 89 ce             	mov    %rcx,%rsi
  803982:	89 c7                	mov    %eax,%edi
  803984:	48 b8 bd 30 80 00 00 	movabs $0x8030bd,%rax
  80398b:	00 00 00 
  80398e:	ff d0                	callq  *%rax
  803990:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803993:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803997:	79 4a                	jns    8039e3 <copy+0x138>
  803999:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80399c:	89 c6                	mov    %eax,%esi
  80399e:	48 bf 64 56 80 00 00 	movabs $0x805664,%rdi
  8039a5:	00 00 00 
  8039a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8039ad:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  8039b4:	00 00 00 
  8039b7:	ff d2                	callq  *%rdx
  8039b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039bc:	89 c7                	mov    %eax,%edi
  8039be:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  8039c5:	00 00 00 
  8039c8:	ff d0                	callq  *%rax
  8039ca:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8039cd:	89 c7                	mov    %eax,%edi
  8039cf:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  8039d6:	00 00 00 
  8039d9:	ff d0                	callq  *%rax
  8039db:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8039de:	e9 a1 00 00 00       	jmpq   803a84 <copy+0x1d9>
  8039e3:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8039ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039ed:	ba 00 02 00 00       	mov    $0x200,%edx
  8039f2:	48 89 ce             	mov    %rcx,%rsi
  8039f5:	89 c7                	mov    %eax,%edi
  8039f7:	48 b8 73 2f 80 00 00 	movabs $0x802f73,%rax
  8039fe:	00 00 00 
  803a01:	ff d0                	callq  *%rax
  803a03:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803a06:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803a0a:	0f 8f 5f ff ff ff    	jg     80396f <copy+0xc4>
  803a10:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803a14:	79 47                	jns    803a5d <copy+0x1b2>
  803a16:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803a19:	89 c6                	mov    %eax,%esi
  803a1b:	48 bf 77 56 80 00 00 	movabs $0x805677,%rdi
  803a22:	00 00 00 
  803a25:	b8 00 00 00 00       	mov    $0x0,%eax
  803a2a:	48 ba 59 0f 80 00 00 	movabs $0x800f59,%rdx
  803a31:	00 00 00 
  803a34:	ff d2                	callq  *%rdx
  803a36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a39:	89 c7                	mov    %eax,%edi
  803a3b:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  803a42:	00 00 00 
  803a45:	ff d0                	callq  *%rax
  803a47:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803a4a:	89 c7                	mov    %eax,%edi
  803a4c:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  803a53:	00 00 00 
  803a56:	ff d0                	callq  *%rax
  803a58:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803a5b:	eb 27                	jmp    803a84 <copy+0x1d9>
  803a5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a60:	89 c7                	mov    %eax,%edi
  803a62:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  803a69:	00 00 00 
  803a6c:	ff d0                	callq  *%rax
  803a6e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803a71:	89 c7                	mov    %eax,%edi
  803a73:	48 b8 51 2d 80 00 00 	movabs $0x802d51,%rax
  803a7a:	00 00 00 
  803a7d:	ff d0                	callq  *%rax
  803a7f:	b8 00 00 00 00       	mov    $0x0,%eax
  803a84:	c9                   	leaveq 
  803a85:	c3                   	retq   

0000000000803a86 <fd2sockid>:
  803a86:	55                   	push   %rbp
  803a87:	48 89 e5             	mov    %rsp,%rbp
  803a8a:	48 83 ec 20          	sub    $0x20,%rsp
  803a8e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a91:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803a95:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a98:	48 89 d6             	mov    %rdx,%rsi
  803a9b:	89 c7                	mov    %eax,%edi
  803a9d:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  803aa4:	00 00 00 
  803aa7:	ff d0                	callq  *%rax
  803aa9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803aac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ab0:	79 05                	jns    803ab7 <fd2sockid+0x31>
  803ab2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ab5:	eb 24                	jmp    803adb <fd2sockid+0x55>
  803ab7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803abb:	8b 10                	mov    (%rax),%edx
  803abd:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803ac4:	00 00 00 
  803ac7:	8b 00                	mov    (%rax),%eax
  803ac9:	39 c2                	cmp    %eax,%edx
  803acb:	74 07                	je     803ad4 <fd2sockid+0x4e>
  803acd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803ad2:	eb 07                	jmp    803adb <fd2sockid+0x55>
  803ad4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ad8:	8b 40 0c             	mov    0xc(%rax),%eax
  803adb:	c9                   	leaveq 
  803adc:	c3                   	retq   

0000000000803add <alloc_sockfd>:
  803add:	55                   	push   %rbp
  803ade:	48 89 e5             	mov    %rsp,%rbp
  803ae1:	48 83 ec 20          	sub    $0x20,%rsp
  803ae5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ae8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803aec:	48 89 c7             	mov    %rax,%rdi
  803aef:	48 b8 a9 2a 80 00 00 	movabs $0x802aa9,%rax
  803af6:	00 00 00 
  803af9:	ff d0                	callq  *%rax
  803afb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803afe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b02:	78 26                	js     803b2a <alloc_sockfd+0x4d>
  803b04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b08:	ba 07 04 00 00       	mov    $0x407,%edx
  803b0d:	48 89 c6             	mov    %rax,%rsi
  803b10:	bf 00 00 00 00       	mov    $0x0,%edi
  803b15:	48 b8 3d 24 80 00 00 	movabs $0x80243d,%rax
  803b1c:	00 00 00 
  803b1f:	ff d0                	callq  *%rax
  803b21:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b24:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b28:	79 16                	jns    803b40 <alloc_sockfd+0x63>
  803b2a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b2d:	89 c7                	mov    %eax,%edi
  803b2f:	48 b8 ea 3f 80 00 00 	movabs $0x803fea,%rax
  803b36:	00 00 00 
  803b39:	ff d0                	callq  *%rax
  803b3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b3e:	eb 3a                	jmp    803b7a <alloc_sockfd+0x9d>
  803b40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b44:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  803b4b:	00 00 00 
  803b4e:	8b 12                	mov    (%rdx),%edx
  803b50:	89 10                	mov    %edx,(%rax)
  803b52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b56:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803b5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b61:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b64:	89 50 0c             	mov    %edx,0xc(%rax)
  803b67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b6b:	48 89 c7             	mov    %rax,%rdi
  803b6e:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  803b75:	00 00 00 
  803b78:	ff d0                	callq  *%rax
  803b7a:	c9                   	leaveq 
  803b7b:	c3                   	retq   

0000000000803b7c <accept>:
  803b7c:	55                   	push   %rbp
  803b7d:	48 89 e5             	mov    %rsp,%rbp
  803b80:	48 83 ec 30          	sub    $0x30,%rsp
  803b84:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b87:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b8b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803b8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b92:	89 c7                	mov    %eax,%edi
  803b94:	48 b8 86 3a 80 00 00 	movabs $0x803a86,%rax
  803b9b:	00 00 00 
  803b9e:	ff d0                	callq  *%rax
  803ba0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ba3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ba7:	79 05                	jns    803bae <accept+0x32>
  803ba9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bac:	eb 3b                	jmp    803be9 <accept+0x6d>
  803bae:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803bb2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803bb6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bb9:	48 89 ce             	mov    %rcx,%rsi
  803bbc:	89 c7                	mov    %eax,%edi
  803bbe:	48 b8 c7 3e 80 00 00 	movabs $0x803ec7,%rax
  803bc5:	00 00 00 
  803bc8:	ff d0                	callq  *%rax
  803bca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bcd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bd1:	79 05                	jns    803bd8 <accept+0x5c>
  803bd3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bd6:	eb 11                	jmp    803be9 <accept+0x6d>
  803bd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bdb:	89 c7                	mov    %eax,%edi
  803bdd:	48 b8 dd 3a 80 00 00 	movabs $0x803add,%rax
  803be4:	00 00 00 
  803be7:	ff d0                	callq  *%rax
  803be9:	c9                   	leaveq 
  803bea:	c3                   	retq   

0000000000803beb <bind>:
  803beb:	55                   	push   %rbp
  803bec:	48 89 e5             	mov    %rsp,%rbp
  803bef:	48 83 ec 20          	sub    $0x20,%rsp
  803bf3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803bf6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803bfa:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803bfd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c00:	89 c7                	mov    %eax,%edi
  803c02:	48 b8 86 3a 80 00 00 	movabs $0x803a86,%rax
  803c09:	00 00 00 
  803c0c:	ff d0                	callq  *%rax
  803c0e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c11:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c15:	79 05                	jns    803c1c <bind+0x31>
  803c17:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c1a:	eb 1b                	jmp    803c37 <bind+0x4c>
  803c1c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c1f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803c23:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c26:	48 89 ce             	mov    %rcx,%rsi
  803c29:	89 c7                	mov    %eax,%edi
  803c2b:	48 b8 46 3f 80 00 00 	movabs $0x803f46,%rax
  803c32:	00 00 00 
  803c35:	ff d0                	callq  *%rax
  803c37:	c9                   	leaveq 
  803c38:	c3                   	retq   

0000000000803c39 <shutdown>:
  803c39:	55                   	push   %rbp
  803c3a:	48 89 e5             	mov    %rsp,%rbp
  803c3d:	48 83 ec 20          	sub    $0x20,%rsp
  803c41:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c44:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803c47:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c4a:	89 c7                	mov    %eax,%edi
  803c4c:	48 b8 86 3a 80 00 00 	movabs $0x803a86,%rax
  803c53:	00 00 00 
  803c56:	ff d0                	callq  *%rax
  803c58:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c5b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c5f:	79 05                	jns    803c66 <shutdown+0x2d>
  803c61:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c64:	eb 16                	jmp    803c7c <shutdown+0x43>
  803c66:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c69:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c6c:	89 d6                	mov    %edx,%esi
  803c6e:	89 c7                	mov    %eax,%edi
  803c70:	48 b8 aa 3f 80 00 00 	movabs $0x803faa,%rax
  803c77:	00 00 00 
  803c7a:	ff d0                	callq  *%rax
  803c7c:	c9                   	leaveq 
  803c7d:	c3                   	retq   

0000000000803c7e <devsock_close>:
  803c7e:	55                   	push   %rbp
  803c7f:	48 89 e5             	mov    %rsp,%rbp
  803c82:	48 83 ec 10          	sub    $0x10,%rsp
  803c86:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803c8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c8e:	48 89 c7             	mov    %rax,%rdi
  803c91:	48 b8 0e 4b 80 00 00 	movabs $0x804b0e,%rax
  803c98:	00 00 00 
  803c9b:	ff d0                	callq  *%rax
  803c9d:	83 f8 01             	cmp    $0x1,%eax
  803ca0:	75 17                	jne    803cb9 <devsock_close+0x3b>
  803ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ca6:	8b 40 0c             	mov    0xc(%rax),%eax
  803ca9:	89 c7                	mov    %eax,%edi
  803cab:	48 b8 ea 3f 80 00 00 	movabs $0x803fea,%rax
  803cb2:	00 00 00 
  803cb5:	ff d0                	callq  *%rax
  803cb7:	eb 05                	jmp    803cbe <devsock_close+0x40>
  803cb9:	b8 00 00 00 00       	mov    $0x0,%eax
  803cbe:	c9                   	leaveq 
  803cbf:	c3                   	retq   

0000000000803cc0 <connect>:
  803cc0:	55                   	push   %rbp
  803cc1:	48 89 e5             	mov    %rsp,%rbp
  803cc4:	48 83 ec 20          	sub    $0x20,%rsp
  803cc8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ccb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803ccf:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803cd2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803cd5:	89 c7                	mov    %eax,%edi
  803cd7:	48 b8 86 3a 80 00 00 	movabs $0x803a86,%rax
  803cde:	00 00 00 
  803ce1:	ff d0                	callq  *%rax
  803ce3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ce6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803cea:	79 05                	jns    803cf1 <connect+0x31>
  803cec:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cef:	eb 1b                	jmp    803d0c <connect+0x4c>
  803cf1:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803cf4:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803cf8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cfb:	48 89 ce             	mov    %rcx,%rsi
  803cfe:	89 c7                	mov    %eax,%edi
  803d00:	48 b8 17 40 80 00 00 	movabs $0x804017,%rax
  803d07:	00 00 00 
  803d0a:	ff d0                	callq  *%rax
  803d0c:	c9                   	leaveq 
  803d0d:	c3                   	retq   

0000000000803d0e <listen>:
  803d0e:	55                   	push   %rbp
  803d0f:	48 89 e5             	mov    %rsp,%rbp
  803d12:	48 83 ec 20          	sub    $0x20,%rsp
  803d16:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d19:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803d1c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803d1f:	89 c7                	mov    %eax,%edi
  803d21:	48 b8 86 3a 80 00 00 	movabs $0x803a86,%rax
  803d28:	00 00 00 
  803d2b:	ff d0                	callq  *%rax
  803d2d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d30:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d34:	79 05                	jns    803d3b <listen+0x2d>
  803d36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d39:	eb 16                	jmp    803d51 <listen+0x43>
  803d3b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803d3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d41:	89 d6                	mov    %edx,%esi
  803d43:	89 c7                	mov    %eax,%edi
  803d45:	48 b8 7b 40 80 00 00 	movabs $0x80407b,%rax
  803d4c:	00 00 00 
  803d4f:	ff d0                	callq  *%rax
  803d51:	c9                   	leaveq 
  803d52:	c3                   	retq   

0000000000803d53 <devsock_read>:
  803d53:	55                   	push   %rbp
  803d54:	48 89 e5             	mov    %rsp,%rbp
  803d57:	48 83 ec 20          	sub    $0x20,%rsp
  803d5b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803d5f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803d63:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803d67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d6b:	89 c2                	mov    %eax,%edx
  803d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803d71:	8b 40 0c             	mov    0xc(%rax),%eax
  803d74:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803d78:	b9 00 00 00 00       	mov    $0x0,%ecx
  803d7d:	89 c7                	mov    %eax,%edi
  803d7f:	48 b8 bb 40 80 00 00 	movabs $0x8040bb,%rax
  803d86:	00 00 00 
  803d89:	ff d0                	callq  *%rax
  803d8b:	c9                   	leaveq 
  803d8c:	c3                   	retq   

0000000000803d8d <devsock_write>:
  803d8d:	55                   	push   %rbp
  803d8e:	48 89 e5             	mov    %rsp,%rbp
  803d91:	48 83 ec 20          	sub    $0x20,%rsp
  803d95:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803d99:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803d9d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803da1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803da5:	89 c2                	mov    %eax,%edx
  803da7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803dab:	8b 40 0c             	mov    0xc(%rax),%eax
  803dae:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803db2:	b9 00 00 00 00       	mov    $0x0,%ecx
  803db7:	89 c7                	mov    %eax,%edi
  803db9:	48 b8 87 41 80 00 00 	movabs $0x804187,%rax
  803dc0:	00 00 00 
  803dc3:	ff d0                	callq  *%rax
  803dc5:	c9                   	leaveq 
  803dc6:	c3                   	retq   

0000000000803dc7 <devsock_stat>:
  803dc7:	55                   	push   %rbp
  803dc8:	48 89 e5             	mov    %rsp,%rbp
  803dcb:	48 83 ec 10          	sub    $0x10,%rsp
  803dcf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803dd3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ddb:	48 be 92 56 80 00 00 	movabs $0x805692,%rsi
  803de2:	00 00 00 
  803de5:	48 89 c7             	mov    %rax,%rdi
  803de8:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  803def:	00 00 00 
  803df2:	ff d0                	callq  *%rax
  803df4:	b8 00 00 00 00       	mov    $0x0,%eax
  803df9:	c9                   	leaveq 
  803dfa:	c3                   	retq   

0000000000803dfb <socket>:
  803dfb:	55                   	push   %rbp
  803dfc:	48 89 e5             	mov    %rsp,%rbp
  803dff:	48 83 ec 20          	sub    $0x20,%rsp
  803e03:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e06:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803e09:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803e0c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803e0f:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803e12:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803e15:	89 ce                	mov    %ecx,%esi
  803e17:	89 c7                	mov    %eax,%edi
  803e19:	48 b8 3f 42 80 00 00 	movabs $0x80423f,%rax
  803e20:	00 00 00 
  803e23:	ff d0                	callq  *%rax
  803e25:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e28:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e2c:	79 05                	jns    803e33 <socket+0x38>
  803e2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e31:	eb 11                	jmp    803e44 <socket+0x49>
  803e33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e36:	89 c7                	mov    %eax,%edi
  803e38:	48 b8 dd 3a 80 00 00 	movabs $0x803add,%rax
  803e3f:	00 00 00 
  803e42:	ff d0                	callq  *%rax
  803e44:	c9                   	leaveq 
  803e45:	c3                   	retq   

0000000000803e46 <nsipc>:
  803e46:	55                   	push   %rbp
  803e47:	48 89 e5             	mov    %rsp,%rbp
  803e4a:	48 83 ec 10          	sub    $0x10,%rsp
  803e4e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e51:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803e58:	00 00 00 
  803e5b:	8b 00                	mov    (%rax),%eax
  803e5d:	85 c0                	test   %eax,%eax
  803e5f:	75 1d                	jne    803e7e <nsipc+0x38>
  803e61:	bf 02 00 00 00       	mov    $0x2,%edi
  803e66:	48 b8 e9 29 80 00 00 	movabs $0x8029e9,%rax
  803e6d:	00 00 00 
  803e70:	ff d0                	callq  *%rax
  803e72:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803e79:	00 00 00 
  803e7c:	89 02                	mov    %eax,(%rdx)
  803e7e:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803e85:	00 00 00 
  803e88:	8b 00                	mov    (%rax),%eax
  803e8a:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803e8d:	b9 07 00 00 00       	mov    $0x7,%ecx
  803e92:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803e99:	00 00 00 
  803e9c:	89 c7                	mov    %eax,%edi
  803e9e:	48 b8 de 28 80 00 00 	movabs $0x8028de,%rax
  803ea5:	00 00 00 
  803ea8:	ff d0                	callq  *%rax
  803eaa:	ba 00 00 00 00       	mov    $0x0,%edx
  803eaf:	be 00 00 00 00       	mov    $0x0,%esi
  803eb4:	bf 00 00 00 00       	mov    $0x0,%edi
  803eb9:	48 b8 1d 28 80 00 00 	movabs $0x80281d,%rax
  803ec0:	00 00 00 
  803ec3:	ff d0                	callq  *%rax
  803ec5:	c9                   	leaveq 
  803ec6:	c3                   	retq   

0000000000803ec7 <nsipc_accept>:
  803ec7:	55                   	push   %rbp
  803ec8:	48 89 e5             	mov    %rsp,%rbp
  803ecb:	48 83 ec 30          	sub    $0x30,%rsp
  803ecf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ed2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803ed6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803eda:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ee1:	00 00 00 
  803ee4:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803ee7:	89 10                	mov    %edx,(%rax)
  803ee9:	bf 01 00 00 00       	mov    $0x1,%edi
  803eee:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  803ef5:	00 00 00 
  803ef8:	ff d0                	callq  *%rax
  803efa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803efd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f01:	78 3e                	js     803f41 <nsipc_accept+0x7a>
  803f03:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f0a:	00 00 00 
  803f0d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803f11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f15:	8b 40 10             	mov    0x10(%rax),%eax
  803f18:	89 c2                	mov    %eax,%edx
  803f1a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803f1e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f22:	48 89 ce             	mov    %rcx,%rsi
  803f25:	48 89 c7             	mov    %rax,%rdi
  803f28:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  803f2f:	00 00 00 
  803f32:	ff d0                	callq  *%rax
  803f34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f38:	8b 50 10             	mov    0x10(%rax),%edx
  803f3b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f3f:	89 10                	mov    %edx,(%rax)
  803f41:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f44:	c9                   	leaveq 
  803f45:	c3                   	retq   

0000000000803f46 <nsipc_bind>:
  803f46:	55                   	push   %rbp
  803f47:	48 89 e5             	mov    %rsp,%rbp
  803f4a:	48 83 ec 10          	sub    $0x10,%rsp
  803f4e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f51:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803f55:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803f58:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f5f:	00 00 00 
  803f62:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f65:	89 10                	mov    %edx,(%rax)
  803f67:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f6e:	48 89 c6             	mov    %rax,%rsi
  803f71:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803f78:	00 00 00 
  803f7b:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  803f82:	00 00 00 
  803f85:	ff d0                	callq  *%rax
  803f87:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f8e:	00 00 00 
  803f91:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f94:	89 50 14             	mov    %edx,0x14(%rax)
  803f97:	bf 02 00 00 00       	mov    $0x2,%edi
  803f9c:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  803fa3:	00 00 00 
  803fa6:	ff d0                	callq  *%rax
  803fa8:	c9                   	leaveq 
  803fa9:	c3                   	retq   

0000000000803faa <nsipc_shutdown>:
  803faa:	55                   	push   %rbp
  803fab:	48 89 e5             	mov    %rsp,%rbp
  803fae:	48 83 ec 10          	sub    $0x10,%rsp
  803fb2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803fb5:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803fb8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fbf:	00 00 00 
  803fc2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803fc5:	89 10                	mov    %edx,(%rax)
  803fc7:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fce:	00 00 00 
  803fd1:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803fd4:	89 50 04             	mov    %edx,0x4(%rax)
  803fd7:	bf 03 00 00 00       	mov    $0x3,%edi
  803fdc:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  803fe3:	00 00 00 
  803fe6:	ff d0                	callq  *%rax
  803fe8:	c9                   	leaveq 
  803fe9:	c3                   	retq   

0000000000803fea <nsipc_close>:
  803fea:	55                   	push   %rbp
  803feb:	48 89 e5             	mov    %rsp,%rbp
  803fee:	48 83 ec 10          	sub    $0x10,%rsp
  803ff2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ff5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ffc:	00 00 00 
  803fff:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804002:	89 10                	mov    %edx,(%rax)
  804004:	bf 04 00 00 00       	mov    $0x4,%edi
  804009:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  804010:	00 00 00 
  804013:	ff d0                	callq  *%rax
  804015:	c9                   	leaveq 
  804016:	c3                   	retq   

0000000000804017 <nsipc_connect>:
  804017:	55                   	push   %rbp
  804018:	48 89 e5             	mov    %rsp,%rbp
  80401b:	48 83 ec 10          	sub    $0x10,%rsp
  80401f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804022:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804026:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804029:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804030:	00 00 00 
  804033:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804036:	89 10                	mov    %edx,(%rax)
  804038:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80403b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80403f:	48 89 c6             	mov    %rax,%rsi
  804042:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  804049:	00 00 00 
  80404c:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  804053:	00 00 00 
  804056:	ff d0                	callq  *%rax
  804058:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80405f:	00 00 00 
  804062:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804065:	89 50 14             	mov    %edx,0x14(%rax)
  804068:	bf 05 00 00 00       	mov    $0x5,%edi
  80406d:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  804074:	00 00 00 
  804077:	ff d0                	callq  *%rax
  804079:	c9                   	leaveq 
  80407a:	c3                   	retq   

000000000080407b <nsipc_listen>:
  80407b:	55                   	push   %rbp
  80407c:	48 89 e5             	mov    %rsp,%rbp
  80407f:	48 83 ec 10          	sub    $0x10,%rsp
  804083:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804086:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804089:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804090:	00 00 00 
  804093:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804096:	89 10                	mov    %edx,(%rax)
  804098:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80409f:	00 00 00 
  8040a2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8040a5:	89 50 04             	mov    %edx,0x4(%rax)
  8040a8:	bf 06 00 00 00       	mov    $0x6,%edi
  8040ad:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  8040b4:	00 00 00 
  8040b7:	ff d0                	callq  *%rax
  8040b9:	c9                   	leaveq 
  8040ba:	c3                   	retq   

00000000008040bb <nsipc_recv>:
  8040bb:	55                   	push   %rbp
  8040bc:	48 89 e5             	mov    %rsp,%rbp
  8040bf:	48 83 ec 30          	sub    $0x30,%rsp
  8040c3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8040c6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8040ca:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8040cd:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8040d0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8040d7:	00 00 00 
  8040da:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8040dd:	89 10                	mov    %edx,(%rax)
  8040df:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8040e6:	00 00 00 
  8040e9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8040ec:	89 50 04             	mov    %edx,0x4(%rax)
  8040ef:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8040f6:	00 00 00 
  8040f9:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8040fc:	89 50 08             	mov    %edx,0x8(%rax)
  8040ff:	bf 07 00 00 00       	mov    $0x7,%edi
  804104:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  80410b:	00 00 00 
  80410e:	ff d0                	callq  *%rax
  804110:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804113:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804117:	78 69                	js     804182 <nsipc_recv+0xc7>
  804119:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  804120:	7f 08                	jg     80412a <nsipc_recv+0x6f>
  804122:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804125:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  804128:	7e 35                	jle    80415f <nsipc_recv+0xa4>
  80412a:	48 b9 99 56 80 00 00 	movabs $0x805699,%rcx
  804131:	00 00 00 
  804134:	48 ba ae 56 80 00 00 	movabs $0x8056ae,%rdx
  80413b:	00 00 00 
  80413e:	be 62 00 00 00       	mov    $0x62,%esi
  804143:	48 bf c3 56 80 00 00 	movabs $0x8056c3,%rdi
  80414a:	00 00 00 
  80414d:	b8 00 00 00 00       	mov    $0x0,%eax
  804152:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  804159:	00 00 00 
  80415c:	41 ff d0             	callq  *%r8
  80415f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804162:	48 63 d0             	movslq %eax,%rdx
  804165:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804169:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  804170:	00 00 00 
  804173:	48 89 c7             	mov    %rax,%rdi
  804176:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  80417d:	00 00 00 
  804180:	ff d0                	callq  *%rax
  804182:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804185:	c9                   	leaveq 
  804186:	c3                   	retq   

0000000000804187 <nsipc_send>:
  804187:	55                   	push   %rbp
  804188:	48 89 e5             	mov    %rsp,%rbp
  80418b:	48 83 ec 20          	sub    $0x20,%rsp
  80418f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804192:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804196:	89 55 f8             	mov    %edx,-0x8(%rbp)
  804199:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80419c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8041a3:	00 00 00 
  8041a6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8041a9:	89 10                	mov    %edx,(%rax)
  8041ab:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  8041b2:	7e 35                	jle    8041e9 <nsipc_send+0x62>
  8041b4:	48 b9 d2 56 80 00 00 	movabs $0x8056d2,%rcx
  8041bb:	00 00 00 
  8041be:	48 ba ae 56 80 00 00 	movabs $0x8056ae,%rdx
  8041c5:	00 00 00 
  8041c8:	be 6d 00 00 00       	mov    $0x6d,%esi
  8041cd:	48 bf c3 56 80 00 00 	movabs $0x8056c3,%rdi
  8041d4:	00 00 00 
  8041d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8041dc:	49 b8 20 0d 80 00 00 	movabs $0x800d20,%r8
  8041e3:	00 00 00 
  8041e6:	41 ff d0             	callq  *%r8
  8041e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8041ec:	48 63 d0             	movslq %eax,%rdx
  8041ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041f3:	48 89 c6             	mov    %rax,%rsi
  8041f6:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  8041fd:	00 00 00 
  804200:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  804207:	00 00 00 
  80420a:	ff d0                	callq  *%rax
  80420c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804213:	00 00 00 
  804216:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804219:	89 50 04             	mov    %edx,0x4(%rax)
  80421c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804223:	00 00 00 
  804226:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804229:	89 50 08             	mov    %edx,0x8(%rax)
  80422c:	bf 08 00 00 00       	mov    $0x8,%edi
  804231:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  804238:	00 00 00 
  80423b:	ff d0                	callq  *%rax
  80423d:	c9                   	leaveq 
  80423e:	c3                   	retq   

000000000080423f <nsipc_socket>:
  80423f:	55                   	push   %rbp
  804240:	48 89 e5             	mov    %rsp,%rbp
  804243:	48 83 ec 10          	sub    $0x10,%rsp
  804247:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80424a:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80424d:	89 55 f4             	mov    %edx,-0xc(%rbp)
  804250:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804257:	00 00 00 
  80425a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80425d:	89 10                	mov    %edx,(%rax)
  80425f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804266:	00 00 00 
  804269:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80426c:	89 50 04             	mov    %edx,0x4(%rax)
  80426f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804276:	00 00 00 
  804279:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80427c:	89 50 08             	mov    %edx,0x8(%rax)
  80427f:	bf 09 00 00 00       	mov    $0x9,%edi
  804284:	48 b8 46 3e 80 00 00 	movabs $0x803e46,%rax
  80428b:	00 00 00 
  80428e:	ff d0                	callq  *%rax
  804290:	c9                   	leaveq 
  804291:	c3                   	retq   

0000000000804292 <pipe>:
  804292:	55                   	push   %rbp
  804293:	48 89 e5             	mov    %rsp,%rbp
  804296:	53                   	push   %rbx
  804297:	48 83 ec 38          	sub    $0x38,%rsp
  80429b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  80429f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8042a3:	48 89 c7             	mov    %rax,%rdi
  8042a6:	48 b8 a9 2a 80 00 00 	movabs $0x802aa9,%rax
  8042ad:	00 00 00 
  8042b0:	ff d0                	callq  *%rax
  8042b2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8042b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8042b9:	0f 88 bf 01 00 00    	js     80447e <pipe+0x1ec>
  8042bf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8042c3:	ba 07 04 00 00       	mov    $0x407,%edx
  8042c8:	48 89 c6             	mov    %rax,%rsi
  8042cb:	bf 00 00 00 00       	mov    $0x0,%edi
  8042d0:	48 b8 3d 24 80 00 00 	movabs $0x80243d,%rax
  8042d7:	00 00 00 
  8042da:	ff d0                	callq  *%rax
  8042dc:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8042df:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8042e3:	0f 88 95 01 00 00    	js     80447e <pipe+0x1ec>
  8042e9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8042ed:	48 89 c7             	mov    %rax,%rdi
  8042f0:	48 b8 a9 2a 80 00 00 	movabs $0x802aa9,%rax
  8042f7:	00 00 00 
  8042fa:	ff d0                	callq  *%rax
  8042fc:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8042ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804303:	0f 88 5d 01 00 00    	js     804466 <pipe+0x1d4>
  804309:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80430d:	ba 07 04 00 00       	mov    $0x407,%edx
  804312:	48 89 c6             	mov    %rax,%rsi
  804315:	bf 00 00 00 00       	mov    $0x0,%edi
  80431a:	48 b8 3d 24 80 00 00 	movabs $0x80243d,%rax
  804321:	00 00 00 
  804324:	ff d0                	callq  *%rax
  804326:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804329:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80432d:	0f 88 33 01 00 00    	js     804466 <pipe+0x1d4>
  804333:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804337:	48 89 c7             	mov    %rax,%rdi
  80433a:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  804341:	00 00 00 
  804344:	ff d0                	callq  *%rax
  804346:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80434a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80434e:	ba 07 04 00 00       	mov    $0x407,%edx
  804353:	48 89 c6             	mov    %rax,%rsi
  804356:	bf 00 00 00 00       	mov    $0x0,%edi
  80435b:	48 b8 3d 24 80 00 00 	movabs $0x80243d,%rax
  804362:	00 00 00 
  804365:	ff d0                	callq  *%rax
  804367:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80436a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80436e:	79 05                	jns    804375 <pipe+0xe3>
  804370:	e9 d9 00 00 00       	jmpq   80444e <pipe+0x1bc>
  804375:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804379:	48 89 c7             	mov    %rax,%rdi
  80437c:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  804383:	00 00 00 
  804386:	ff d0                	callq  *%rax
  804388:	48 89 c2             	mov    %rax,%rdx
  80438b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80438f:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  804395:	48 89 d1             	mov    %rdx,%rcx
  804398:	ba 00 00 00 00       	mov    $0x0,%edx
  80439d:	48 89 c6             	mov    %rax,%rsi
  8043a0:	bf 00 00 00 00       	mov    $0x0,%edi
  8043a5:	48 b8 8d 24 80 00 00 	movabs $0x80248d,%rax
  8043ac:	00 00 00 
  8043af:	ff d0                	callq  *%rax
  8043b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8043b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8043b8:	79 1b                	jns    8043d5 <pipe+0x143>
  8043ba:	90                   	nop
  8043bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8043bf:	48 89 c6             	mov    %rax,%rsi
  8043c2:	bf 00 00 00 00       	mov    $0x0,%edi
  8043c7:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  8043ce:	00 00 00 
  8043d1:	ff d0                	callq  *%rax
  8043d3:	eb 79                	jmp    80444e <pipe+0x1bc>
  8043d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043d9:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  8043e0:	00 00 00 
  8043e3:	8b 12                	mov    (%rdx),%edx
  8043e5:	89 10                	mov    %edx,(%rax)
  8043e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043eb:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  8043f2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8043f6:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  8043fd:	00 00 00 
  804400:	8b 12                	mov    (%rdx),%edx
  804402:	89 10                	mov    %edx,(%rax)
  804404:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804408:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  80440f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804413:	48 89 c7             	mov    %rax,%rdi
  804416:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  80441d:	00 00 00 
  804420:	ff d0                	callq  *%rax
  804422:	89 c2                	mov    %eax,%edx
  804424:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804428:	89 10                	mov    %edx,(%rax)
  80442a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80442e:	48 8d 58 04          	lea    0x4(%rax),%rbx
  804432:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804436:	48 89 c7             	mov    %rax,%rdi
  804439:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  804440:	00 00 00 
  804443:	ff d0                	callq  *%rax
  804445:	89 03                	mov    %eax,(%rbx)
  804447:	b8 00 00 00 00       	mov    $0x0,%eax
  80444c:	eb 33                	jmp    804481 <pipe+0x1ef>
  80444e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804452:	48 89 c6             	mov    %rax,%rsi
  804455:	bf 00 00 00 00       	mov    $0x0,%edi
  80445a:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  804461:	00 00 00 
  804464:	ff d0                	callq  *%rax
  804466:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80446a:	48 89 c6             	mov    %rax,%rsi
  80446d:	bf 00 00 00 00       	mov    $0x0,%edi
  804472:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  804479:	00 00 00 
  80447c:	ff d0                	callq  *%rax
  80447e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804481:	48 83 c4 38          	add    $0x38,%rsp
  804485:	5b                   	pop    %rbx
  804486:	5d                   	pop    %rbp
  804487:	c3                   	retq   

0000000000804488 <_pipeisclosed>:
  804488:	55                   	push   %rbp
  804489:	48 89 e5             	mov    %rsp,%rbp
  80448c:	53                   	push   %rbx
  80448d:	48 83 ec 28          	sub    $0x28,%rsp
  804491:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804495:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804499:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8044a0:	00 00 00 
  8044a3:	48 8b 00             	mov    (%rax),%rax
  8044a6:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8044ac:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8044af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8044b3:	48 89 c7             	mov    %rax,%rdi
  8044b6:	48 b8 0e 4b 80 00 00 	movabs $0x804b0e,%rax
  8044bd:	00 00 00 
  8044c0:	ff d0                	callq  *%rax
  8044c2:	89 c3                	mov    %eax,%ebx
  8044c4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8044c8:	48 89 c7             	mov    %rax,%rdi
  8044cb:	48 b8 0e 4b 80 00 00 	movabs $0x804b0e,%rax
  8044d2:	00 00 00 
  8044d5:	ff d0                	callq  *%rax
  8044d7:	39 c3                	cmp    %eax,%ebx
  8044d9:	0f 94 c0             	sete   %al
  8044dc:	0f b6 c0             	movzbl %al,%eax
  8044df:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8044e2:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8044e9:	00 00 00 
  8044ec:	48 8b 00             	mov    (%rax),%rax
  8044ef:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8044f5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8044f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8044fb:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8044fe:	75 05                	jne    804505 <_pipeisclosed+0x7d>
  804500:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804503:	eb 4f                	jmp    804554 <_pipeisclosed+0xcc>
  804505:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804508:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80450b:	74 42                	je     80454f <_pipeisclosed+0xc7>
  80450d:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  804511:	75 3c                	jne    80454f <_pipeisclosed+0xc7>
  804513:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80451a:	00 00 00 
  80451d:	48 8b 00             	mov    (%rax),%rax
  804520:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  804526:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  804529:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80452c:	89 c6                	mov    %eax,%esi
  80452e:	48 bf e3 56 80 00 00 	movabs $0x8056e3,%rdi
  804535:	00 00 00 
  804538:	b8 00 00 00 00       	mov    $0x0,%eax
  80453d:	49 b8 59 0f 80 00 00 	movabs $0x800f59,%r8
  804544:	00 00 00 
  804547:	41 ff d0             	callq  *%r8
  80454a:	e9 4a ff ff ff       	jmpq   804499 <_pipeisclosed+0x11>
  80454f:	e9 45 ff ff ff       	jmpq   804499 <_pipeisclosed+0x11>
  804554:	48 83 c4 28          	add    $0x28,%rsp
  804558:	5b                   	pop    %rbx
  804559:	5d                   	pop    %rbp
  80455a:	c3                   	retq   

000000000080455b <pipeisclosed>:
  80455b:	55                   	push   %rbp
  80455c:	48 89 e5             	mov    %rsp,%rbp
  80455f:	48 83 ec 30          	sub    $0x30,%rsp
  804563:	89 7d dc             	mov    %edi,-0x24(%rbp)
  804566:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80456a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80456d:	48 89 d6             	mov    %rdx,%rsi
  804570:	89 c7                	mov    %eax,%edi
  804572:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  804579:	00 00 00 
  80457c:	ff d0                	callq  *%rax
  80457e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804581:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804585:	79 05                	jns    80458c <pipeisclosed+0x31>
  804587:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80458a:	eb 31                	jmp    8045bd <pipeisclosed+0x62>
  80458c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804590:	48 89 c7             	mov    %rax,%rdi
  804593:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  80459a:	00 00 00 
  80459d:	ff d0                	callq  *%rax
  80459f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8045a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8045a7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8045ab:	48 89 d6             	mov    %rdx,%rsi
  8045ae:	48 89 c7             	mov    %rax,%rdi
  8045b1:	48 b8 88 44 80 00 00 	movabs $0x804488,%rax
  8045b8:	00 00 00 
  8045bb:	ff d0                	callq  *%rax
  8045bd:	c9                   	leaveq 
  8045be:	c3                   	retq   

00000000008045bf <devpipe_read>:
  8045bf:	55                   	push   %rbp
  8045c0:	48 89 e5             	mov    %rsp,%rbp
  8045c3:	48 83 ec 40          	sub    $0x40,%rsp
  8045c7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8045cb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8045cf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8045d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8045d7:	48 89 c7             	mov    %rax,%rdi
  8045da:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  8045e1:	00 00 00 
  8045e4:	ff d0                	callq  *%rax
  8045e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8045ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8045ee:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8045f2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8045f9:	00 
  8045fa:	e9 92 00 00 00       	jmpq   804691 <devpipe_read+0xd2>
  8045ff:	eb 41                	jmp    804642 <devpipe_read+0x83>
  804601:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804606:	74 09                	je     804611 <devpipe_read+0x52>
  804608:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80460c:	e9 92 00 00 00       	jmpq   8046a3 <devpipe_read+0xe4>
  804611:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804615:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804619:	48 89 d6             	mov    %rdx,%rsi
  80461c:	48 89 c7             	mov    %rax,%rdi
  80461f:	48 b8 88 44 80 00 00 	movabs $0x804488,%rax
  804626:	00 00 00 
  804629:	ff d0                	callq  *%rax
  80462b:	85 c0                	test   %eax,%eax
  80462d:	74 07                	je     804636 <devpipe_read+0x77>
  80462f:	b8 00 00 00 00       	mov    $0x0,%eax
  804634:	eb 6d                	jmp    8046a3 <devpipe_read+0xe4>
  804636:	48 b8 ff 23 80 00 00 	movabs $0x8023ff,%rax
  80463d:	00 00 00 
  804640:	ff d0                	callq  *%rax
  804642:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804646:	8b 10                	mov    (%rax),%edx
  804648:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80464c:	8b 40 04             	mov    0x4(%rax),%eax
  80464f:	39 c2                	cmp    %eax,%edx
  804651:	74 ae                	je     804601 <devpipe_read+0x42>
  804653:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804657:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80465b:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  80465f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804663:	8b 00                	mov    (%rax),%eax
  804665:	99                   	cltd   
  804666:	c1 ea 1b             	shr    $0x1b,%edx
  804669:	01 d0                	add    %edx,%eax
  80466b:	83 e0 1f             	and    $0x1f,%eax
  80466e:	29 d0                	sub    %edx,%eax
  804670:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804674:	48 98                	cltq   
  804676:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  80467b:	88 01                	mov    %al,(%rcx)
  80467d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804681:	8b 00                	mov    (%rax),%eax
  804683:	8d 50 01             	lea    0x1(%rax),%edx
  804686:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80468a:	89 10                	mov    %edx,(%rax)
  80468c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804691:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804695:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804699:	0f 82 60 ff ff ff    	jb     8045ff <devpipe_read+0x40>
  80469f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046a3:	c9                   	leaveq 
  8046a4:	c3                   	retq   

00000000008046a5 <devpipe_write>:
  8046a5:	55                   	push   %rbp
  8046a6:	48 89 e5             	mov    %rsp,%rbp
  8046a9:	48 83 ec 40          	sub    $0x40,%rsp
  8046ad:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8046b1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8046b5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8046b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8046bd:	48 89 c7             	mov    %rax,%rdi
  8046c0:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  8046c7:	00 00 00 
  8046ca:	ff d0                	callq  *%rax
  8046cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8046d0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8046d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8046d8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8046df:	00 
  8046e0:	e9 8e 00 00 00       	jmpq   804773 <devpipe_write+0xce>
  8046e5:	eb 31                	jmp    804718 <devpipe_write+0x73>
  8046e7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8046eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8046ef:	48 89 d6             	mov    %rdx,%rsi
  8046f2:	48 89 c7             	mov    %rax,%rdi
  8046f5:	48 b8 88 44 80 00 00 	movabs $0x804488,%rax
  8046fc:	00 00 00 
  8046ff:	ff d0                	callq  *%rax
  804701:	85 c0                	test   %eax,%eax
  804703:	74 07                	je     80470c <devpipe_write+0x67>
  804705:	b8 00 00 00 00       	mov    $0x0,%eax
  80470a:	eb 79                	jmp    804785 <devpipe_write+0xe0>
  80470c:	48 b8 ff 23 80 00 00 	movabs $0x8023ff,%rax
  804713:	00 00 00 
  804716:	ff d0                	callq  *%rax
  804718:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80471c:	8b 40 04             	mov    0x4(%rax),%eax
  80471f:	48 63 d0             	movslq %eax,%rdx
  804722:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804726:	8b 00                	mov    (%rax),%eax
  804728:	48 98                	cltq   
  80472a:	48 83 c0 20          	add    $0x20,%rax
  80472e:	48 39 c2             	cmp    %rax,%rdx
  804731:	73 b4                	jae    8046e7 <devpipe_write+0x42>
  804733:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804737:	8b 40 04             	mov    0x4(%rax),%eax
  80473a:	99                   	cltd   
  80473b:	c1 ea 1b             	shr    $0x1b,%edx
  80473e:	01 d0                	add    %edx,%eax
  804740:	83 e0 1f             	and    $0x1f,%eax
  804743:	29 d0                	sub    %edx,%eax
  804745:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  804749:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80474d:	48 01 ca             	add    %rcx,%rdx
  804750:	0f b6 0a             	movzbl (%rdx),%ecx
  804753:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804757:	48 98                	cltq   
  804759:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80475d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804761:	8b 40 04             	mov    0x4(%rax),%eax
  804764:	8d 50 01             	lea    0x1(%rax),%edx
  804767:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80476b:	89 50 04             	mov    %edx,0x4(%rax)
  80476e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804777:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80477b:	0f 82 64 ff ff ff    	jb     8046e5 <devpipe_write+0x40>
  804781:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804785:	c9                   	leaveq 
  804786:	c3                   	retq   

0000000000804787 <devpipe_stat>:
  804787:	55                   	push   %rbp
  804788:	48 89 e5             	mov    %rsp,%rbp
  80478b:	48 83 ec 20          	sub    $0x20,%rsp
  80478f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804793:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804797:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80479b:	48 89 c7             	mov    %rax,%rdi
  80479e:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  8047a5:	00 00 00 
  8047a8:	ff d0                	callq  *%rax
  8047aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8047ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047b2:	48 be f6 56 80 00 00 	movabs $0x8056f6,%rsi
  8047b9:	00 00 00 
  8047bc:	48 89 c7             	mov    %rax,%rdi
  8047bf:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  8047c6:	00 00 00 
  8047c9:	ff d0                	callq  *%rax
  8047cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8047cf:	8b 50 04             	mov    0x4(%rax),%edx
  8047d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8047d6:	8b 00                	mov    (%rax),%eax
  8047d8:	29 c2                	sub    %eax,%edx
  8047da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047de:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8047e4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047e8:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  8047ef:	00 00 00 
  8047f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047f6:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  8047fd:	00 00 00 
  804800:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804807:	b8 00 00 00 00       	mov    $0x0,%eax
  80480c:	c9                   	leaveq 
  80480d:	c3                   	retq   

000000000080480e <devpipe_close>:
  80480e:	55                   	push   %rbp
  80480f:	48 89 e5             	mov    %rsp,%rbp
  804812:	48 83 ec 10          	sub    $0x10,%rsp
  804816:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80481a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80481e:	48 89 c6             	mov    %rax,%rsi
  804821:	bf 00 00 00 00       	mov    $0x0,%edi
  804826:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  80482d:	00 00 00 
  804830:	ff d0                	callq  *%rax
  804832:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804836:	48 89 c7             	mov    %rax,%rdi
  804839:	48 b8 7e 2a 80 00 00 	movabs $0x802a7e,%rax
  804840:	00 00 00 
  804843:	ff d0                	callq  *%rax
  804845:	48 89 c6             	mov    %rax,%rsi
  804848:	bf 00 00 00 00       	mov    $0x0,%edi
  80484d:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  804854:	00 00 00 
  804857:	ff d0                	callq  *%rax
  804859:	c9                   	leaveq 
  80485a:	c3                   	retq   

000000000080485b <cputchar>:
  80485b:	55                   	push   %rbp
  80485c:	48 89 e5             	mov    %rsp,%rbp
  80485f:	48 83 ec 20          	sub    $0x20,%rsp
  804863:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804866:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804869:	88 45 ff             	mov    %al,-0x1(%rbp)
  80486c:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  804870:	be 01 00 00 00       	mov    $0x1,%esi
  804875:	48 89 c7             	mov    %rax,%rdi
  804878:	48 b8 f5 22 80 00 00 	movabs $0x8022f5,%rax
  80487f:	00 00 00 
  804882:	ff d0                	callq  *%rax
  804884:	c9                   	leaveq 
  804885:	c3                   	retq   

0000000000804886 <getchar>:
  804886:	55                   	push   %rbp
  804887:	48 89 e5             	mov    %rsp,%rbp
  80488a:	48 83 ec 10          	sub    $0x10,%rsp
  80488e:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  804892:	ba 01 00 00 00       	mov    $0x1,%edx
  804897:	48 89 c6             	mov    %rax,%rsi
  80489a:	bf 00 00 00 00       	mov    $0x0,%edi
  80489f:	48 b8 73 2f 80 00 00 	movabs $0x802f73,%rax
  8048a6:	00 00 00 
  8048a9:	ff d0                	callq  *%rax
  8048ab:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048b2:	79 05                	jns    8048b9 <getchar+0x33>
  8048b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048b7:	eb 14                	jmp    8048cd <getchar+0x47>
  8048b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048bd:	7f 07                	jg     8048c6 <getchar+0x40>
  8048bf:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  8048c4:	eb 07                	jmp    8048cd <getchar+0x47>
  8048c6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8048ca:	0f b6 c0             	movzbl %al,%eax
  8048cd:	c9                   	leaveq 
  8048ce:	c3                   	retq   

00000000008048cf <iscons>:
  8048cf:	55                   	push   %rbp
  8048d0:	48 89 e5             	mov    %rsp,%rbp
  8048d3:	48 83 ec 20          	sub    $0x20,%rsp
  8048d7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8048da:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8048de:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8048e1:	48 89 d6             	mov    %rdx,%rsi
  8048e4:	89 c7                	mov    %eax,%edi
  8048e6:	48 b8 41 2b 80 00 00 	movabs $0x802b41,%rax
  8048ed:	00 00 00 
  8048f0:	ff d0                	callq  *%rax
  8048f2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048f9:	79 05                	jns    804900 <iscons+0x31>
  8048fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048fe:	eb 1a                	jmp    80491a <iscons+0x4b>
  804900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804904:	8b 10                	mov    (%rax),%edx
  804906:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  80490d:	00 00 00 
  804910:	8b 00                	mov    (%rax),%eax
  804912:	39 c2                	cmp    %eax,%edx
  804914:	0f 94 c0             	sete   %al
  804917:	0f b6 c0             	movzbl %al,%eax
  80491a:	c9                   	leaveq 
  80491b:	c3                   	retq   

000000000080491c <opencons>:
  80491c:	55                   	push   %rbp
  80491d:	48 89 e5             	mov    %rsp,%rbp
  804920:	48 83 ec 10          	sub    $0x10,%rsp
  804924:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804928:	48 89 c7             	mov    %rax,%rdi
  80492b:	48 b8 a9 2a 80 00 00 	movabs $0x802aa9,%rax
  804932:	00 00 00 
  804935:	ff d0                	callq  *%rax
  804937:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80493a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80493e:	79 05                	jns    804945 <opencons+0x29>
  804940:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804943:	eb 5b                	jmp    8049a0 <opencons+0x84>
  804945:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804949:	ba 07 04 00 00       	mov    $0x407,%edx
  80494e:	48 89 c6             	mov    %rax,%rsi
  804951:	bf 00 00 00 00       	mov    $0x0,%edi
  804956:	48 b8 3d 24 80 00 00 	movabs $0x80243d,%rax
  80495d:	00 00 00 
  804960:	ff d0                	callq  *%rax
  804962:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804965:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804969:	79 05                	jns    804970 <opencons+0x54>
  80496b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80496e:	eb 30                	jmp    8049a0 <opencons+0x84>
  804970:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804974:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  80497b:	00 00 00 
  80497e:	8b 12                	mov    (%rdx),%edx
  804980:	89 10                	mov    %edx,(%rax)
  804982:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804986:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80498d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804991:	48 89 c7             	mov    %rax,%rdi
  804994:	48 b8 5b 2a 80 00 00 	movabs $0x802a5b,%rax
  80499b:	00 00 00 
  80499e:	ff d0                	callq  *%rax
  8049a0:	c9                   	leaveq 
  8049a1:	c3                   	retq   

00000000008049a2 <devcons_read>:
  8049a2:	55                   	push   %rbp
  8049a3:	48 89 e5             	mov    %rsp,%rbp
  8049a6:	48 83 ec 30          	sub    $0x30,%rsp
  8049aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8049ae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8049b2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8049b6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8049bb:	75 07                	jne    8049c4 <devcons_read+0x22>
  8049bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8049c2:	eb 4b                	jmp    804a0f <devcons_read+0x6d>
  8049c4:	eb 0c                	jmp    8049d2 <devcons_read+0x30>
  8049c6:	48 b8 ff 23 80 00 00 	movabs $0x8023ff,%rax
  8049cd:	00 00 00 
  8049d0:	ff d0                	callq  *%rax
  8049d2:	48 b8 3f 23 80 00 00 	movabs $0x80233f,%rax
  8049d9:	00 00 00 
  8049dc:	ff d0                	callq  *%rax
  8049de:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8049e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8049e5:	74 df                	je     8049c6 <devcons_read+0x24>
  8049e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8049eb:	79 05                	jns    8049f2 <devcons_read+0x50>
  8049ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049f0:	eb 1d                	jmp    804a0f <devcons_read+0x6d>
  8049f2:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  8049f6:	75 07                	jne    8049ff <devcons_read+0x5d>
  8049f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8049fd:	eb 10                	jmp    804a0f <devcons_read+0x6d>
  8049ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a02:	89 c2                	mov    %eax,%edx
  804a04:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804a08:	88 10                	mov    %dl,(%rax)
  804a0a:	b8 01 00 00 00       	mov    $0x1,%eax
  804a0f:	c9                   	leaveq 
  804a10:	c3                   	retq   

0000000000804a11 <devcons_write>:
  804a11:	55                   	push   %rbp
  804a12:	48 89 e5             	mov    %rsp,%rbp
  804a15:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804a1c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804a23:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804a2a:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  804a31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804a38:	eb 76                	jmp    804ab0 <devcons_write+0x9f>
  804a3a:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  804a41:	89 c2                	mov    %eax,%edx
  804a43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a46:	29 c2                	sub    %eax,%edx
  804a48:	89 d0                	mov    %edx,%eax
  804a4a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804a4d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804a50:	83 f8 7f             	cmp    $0x7f,%eax
  804a53:	76 07                	jbe    804a5c <devcons_write+0x4b>
  804a55:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804a5c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804a5f:	48 63 d0             	movslq %eax,%rdx
  804a62:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a65:	48 63 c8             	movslq %eax,%rcx
  804a68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804a6f:	48 01 c1             	add    %rax,%rcx
  804a72:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804a79:	48 89 ce             	mov    %rcx,%rsi
  804a7c:	48 89 c7             	mov    %rax,%rdi
  804a7f:	48 b8 32 1e 80 00 00 	movabs $0x801e32,%rax
  804a86:	00 00 00 
  804a89:	ff d0                	callq  *%rax
  804a8b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804a8e:	48 63 d0             	movslq %eax,%rdx
  804a91:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804a98:	48 89 d6             	mov    %rdx,%rsi
  804a9b:	48 89 c7             	mov    %rax,%rdi
  804a9e:	48 b8 f5 22 80 00 00 	movabs $0x8022f5,%rax
  804aa5:	00 00 00 
  804aa8:	ff d0                	callq  *%rax
  804aaa:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804aad:	01 45 fc             	add    %eax,-0x4(%rbp)
  804ab0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804ab3:	48 98                	cltq   
  804ab5:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804abc:	0f 82 78 ff ff ff    	jb     804a3a <devcons_write+0x29>
  804ac2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804ac5:	c9                   	leaveq 
  804ac6:	c3                   	retq   

0000000000804ac7 <devcons_close>:
  804ac7:	55                   	push   %rbp
  804ac8:	48 89 e5             	mov    %rsp,%rbp
  804acb:	48 83 ec 08          	sub    $0x8,%rsp
  804acf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804ad3:	b8 00 00 00 00       	mov    $0x0,%eax
  804ad8:	c9                   	leaveq 
  804ad9:	c3                   	retq   

0000000000804ada <devcons_stat>:
  804ada:	55                   	push   %rbp
  804adb:	48 89 e5             	mov    %rsp,%rbp
  804ade:	48 83 ec 10          	sub    $0x10,%rsp
  804ae2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804ae6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804aea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804aee:	48 be 02 57 80 00 00 	movabs $0x805702,%rsi
  804af5:	00 00 00 
  804af8:	48 89 c7             	mov    %rax,%rdi
  804afb:	48 b8 0e 1b 80 00 00 	movabs $0x801b0e,%rax
  804b02:	00 00 00 
  804b05:	ff d0                	callq  *%rax
  804b07:	b8 00 00 00 00       	mov    $0x0,%eax
  804b0c:	c9                   	leaveq 
  804b0d:	c3                   	retq   

0000000000804b0e <pageref>:
  804b0e:	55                   	push   %rbp
  804b0f:	48 89 e5             	mov    %rsp,%rbp
  804b12:	48 83 ec 18          	sub    $0x18,%rsp
  804b16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804b1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804b1e:	48 c1 e8 15          	shr    $0x15,%rax
  804b22:	48 89 c2             	mov    %rax,%rdx
  804b25:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804b2c:	01 00 00 
  804b2f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804b33:	83 e0 01             	and    $0x1,%eax
  804b36:	48 85 c0             	test   %rax,%rax
  804b39:	75 07                	jne    804b42 <pageref+0x34>
  804b3b:	b8 00 00 00 00       	mov    $0x0,%eax
  804b40:	eb 53                	jmp    804b95 <pageref+0x87>
  804b42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804b46:	48 c1 e8 0c          	shr    $0xc,%rax
  804b4a:	48 89 c2             	mov    %rax,%rdx
  804b4d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804b54:	01 00 00 
  804b57:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b63:	83 e0 01             	and    $0x1,%eax
  804b66:	48 85 c0             	test   %rax,%rax
  804b69:	75 07                	jne    804b72 <pageref+0x64>
  804b6b:	b8 00 00 00 00       	mov    $0x0,%eax
  804b70:	eb 23                	jmp    804b95 <pageref+0x87>
  804b72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b76:	48 c1 e8 0c          	shr    $0xc,%rax
  804b7a:	48 89 c2             	mov    %rax,%rdx
  804b7d:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804b84:	00 00 00 
  804b87:	48 c1 e2 04          	shl    $0x4,%rdx
  804b8b:	48 01 d0             	add    %rdx,%rax
  804b8e:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804b92:	0f b7 c0             	movzwl %ax,%eax
  804b95:	c9                   	leaveq 
  804b96:	c3                   	retq   
