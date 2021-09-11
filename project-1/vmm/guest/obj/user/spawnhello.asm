
vmm/guest/obj/user/spawnhello:     file format elf64-x86-64


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
  80003c:	e8 a6 00 00 00       	callq  8000e7 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80004e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800052:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800059:	00 00 00 
  80005c:	48 8b 00             	mov    (%rax),%rax
  80005f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800065:	89 c6                	mov    %eax,%esi
  800067:	48 bf 80 4b 80 00 00 	movabs $0x804b80,%rdi
  80006e:	00 00 00 
  800071:	b8 00 00 00 00       	mov    $0x0,%eax
  800076:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  80007d:	00 00 00 
  800080:	ff d2                	callq  *%rdx
  800082:	ba 00 00 00 00       	mov    $0x0,%edx
  800087:	48 be 9e 4b 80 00 00 	movabs $0x804b9e,%rsi
  80008e:	00 00 00 
  800091:	48 bf a4 4b 80 00 00 	movabs $0x804ba4,%rdi
  800098:	00 00 00 
  80009b:	b8 00 00 00 00       	mov    $0x0,%eax
  8000a0:	48 b9 08 30 80 00 00 	movabs $0x803008,%rcx
  8000a7:	00 00 00 
  8000aa:	ff d1                	callq  *%rcx
  8000ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8000af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000b3:	79 30                	jns    8000e5 <umain+0xa2>
  8000b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000b8:	89 c1                	mov    %eax,%ecx
  8000ba:	48 ba af 4b 80 00 00 	movabs $0x804baf,%rdx
  8000c1:	00 00 00 
  8000c4:	be 0a 00 00 00       	mov    $0xa,%esi
  8000c9:	48 bf c7 4b 80 00 00 	movabs $0x804bc7,%rdi
  8000d0:	00 00 00 
  8000d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8000d8:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  8000df:	00 00 00 
  8000e2:	41 ff d0             	callq  *%r8
  8000e5:	c9                   	leaveq 
  8000e6:	c3                   	retq   

00000000008000e7 <libmain>:
  8000e7:	55                   	push   %rbp
  8000e8:	48 89 e5             	mov    %rsp,%rbp
  8000eb:	48 83 ec 10          	sub    $0x10,%rsp
  8000ef:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8000f2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8000f6:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  8000fd:	00 00 00 
  800100:	ff d0                	callq  *%rax
  800102:	25 ff 03 00 00       	and    $0x3ff,%eax
  800107:	48 98                	cltq   
  800109:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800110:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800117:	00 00 00 
  80011a:	48 01 c2             	add    %rax,%rdx
  80011d:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800124:	00 00 00 
  800127:	48 89 10             	mov    %rdx,(%rax)
  80012a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80012e:	7e 14                	jle    800144 <libmain+0x5d>
  800130:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800134:	48 8b 10             	mov    (%rax),%rdx
  800137:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80013e:	00 00 00 
  800141:	48 89 10             	mov    %rdx,(%rax)
  800144:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800148:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80014b:	48 89 d6             	mov    %rdx,%rsi
  80014e:	89 c7                	mov    %eax,%edi
  800150:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800157:	00 00 00 
  80015a:	ff d0                	callq  *%rax
  80015c:	48 b8 6a 01 80 00 00 	movabs $0x80016a,%rax
  800163:	00 00 00 
  800166:	ff d0                	callq  *%rax
  800168:	c9                   	leaveq 
  800169:	c3                   	retq   

000000000080016a <exit>:
  80016a:	55                   	push   %rbp
  80016b:	48 89 e5             	mov    %rsp,%rbp
  80016e:	48 b8 cb 1f 80 00 00 	movabs $0x801fcb,%rax
  800175:	00 00 00 
  800178:	ff d0                	callq  *%rax
  80017a:	bf 00 00 00 00       	mov    $0x0,%edi
  80017f:	48 b8 ea 17 80 00 00 	movabs $0x8017ea,%rax
  800186:	00 00 00 
  800189:	ff d0                	callq  *%rax
  80018b:	5d                   	pop    %rbp
  80018c:	c3                   	retq   

000000000080018d <_panic>:
  80018d:	55                   	push   %rbp
  80018e:	48 89 e5             	mov    %rsp,%rbp
  800191:	53                   	push   %rbx
  800192:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800199:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8001a0:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8001a6:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8001ad:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8001b4:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8001bb:	84 c0                	test   %al,%al
  8001bd:	74 23                	je     8001e2 <_panic+0x55>
  8001bf:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8001c6:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8001ca:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8001ce:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  8001d2:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  8001d6:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  8001da:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  8001de:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  8001e2:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8001e9:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  8001f0:	00 00 00 
  8001f3:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  8001fa:	00 00 00 
  8001fd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800201:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800208:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80020f:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800216:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80021d:	00 00 00 
  800220:	48 8b 18             	mov    (%rax),%rbx
  800223:	48 b8 2e 18 80 00 00 	movabs $0x80182e,%rax
  80022a:	00 00 00 
  80022d:	ff d0                	callq  *%rax
  80022f:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800235:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80023c:	41 89 c8             	mov    %ecx,%r8d
  80023f:	48 89 d1             	mov    %rdx,%rcx
  800242:	48 89 da             	mov    %rbx,%rdx
  800245:	89 c6                	mov    %eax,%esi
  800247:	48 bf e8 4b 80 00 00 	movabs $0x804be8,%rdi
  80024e:	00 00 00 
  800251:	b8 00 00 00 00       	mov    $0x0,%eax
  800256:	49 b9 c6 03 80 00 00 	movabs $0x8003c6,%r9
  80025d:	00 00 00 
  800260:	41 ff d1             	callq  *%r9
  800263:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  80026a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800271:	48 89 d6             	mov    %rdx,%rsi
  800274:	48 89 c7             	mov    %rax,%rdi
  800277:	48 b8 1a 03 80 00 00 	movabs $0x80031a,%rax
  80027e:	00 00 00 
  800281:	ff d0                	callq  *%rax
  800283:	48 bf 0b 4c 80 00 00 	movabs $0x804c0b,%rdi
  80028a:	00 00 00 
  80028d:	b8 00 00 00 00       	mov    $0x0,%eax
  800292:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  800299:	00 00 00 
  80029c:	ff d2                	callq  *%rdx
  80029e:	cc                   	int3   
  80029f:	eb fd                	jmp    80029e <_panic+0x111>

00000000008002a1 <putch>:
  8002a1:	55                   	push   %rbp
  8002a2:	48 89 e5             	mov    %rsp,%rbp
  8002a5:	48 83 ec 10          	sub    $0x10,%rsp
  8002a9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8002ac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8002b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002b4:	8b 00                	mov    (%rax),%eax
  8002b6:	8d 48 01             	lea    0x1(%rax),%ecx
  8002b9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002bd:	89 0a                	mov    %ecx,(%rdx)
  8002bf:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8002c2:	89 d1                	mov    %edx,%ecx
  8002c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002c8:	48 98                	cltq   
  8002ca:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8002ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002d2:	8b 00                	mov    (%rax),%eax
  8002d4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002d9:	75 2c                	jne    800307 <putch+0x66>
  8002db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002df:	8b 00                	mov    (%rax),%eax
  8002e1:	48 98                	cltq   
  8002e3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002e7:	48 83 c2 08          	add    $0x8,%rdx
  8002eb:	48 89 c6             	mov    %rax,%rsi
  8002ee:	48 89 d7             	mov    %rdx,%rdi
  8002f1:	48 b8 62 17 80 00 00 	movabs $0x801762,%rax
  8002f8:	00 00 00 
  8002fb:	ff d0                	callq  *%rax
  8002fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800301:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800307:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80030b:	8b 40 04             	mov    0x4(%rax),%eax
  80030e:	8d 50 01             	lea    0x1(%rax),%edx
  800311:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800315:	89 50 04             	mov    %edx,0x4(%rax)
  800318:	c9                   	leaveq 
  800319:	c3                   	retq   

000000000080031a <vcprintf>:
  80031a:	55                   	push   %rbp
  80031b:	48 89 e5             	mov    %rsp,%rbp
  80031e:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800325:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  80032c:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800333:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  80033a:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800341:	48 8b 0a             	mov    (%rdx),%rcx
  800344:	48 89 08             	mov    %rcx,(%rax)
  800347:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80034b:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80034f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800353:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800357:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  80035e:	00 00 00 
  800361:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800368:	00 00 00 
  80036b:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800372:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800379:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800380:	48 89 c6             	mov    %rax,%rsi
  800383:	48 bf a1 02 80 00 00 	movabs $0x8002a1,%rdi
  80038a:	00 00 00 
  80038d:	48 b8 79 07 80 00 00 	movabs $0x800779,%rax
  800394:	00 00 00 
  800397:	ff d0                	callq  *%rax
  800399:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  80039f:	48 98                	cltq   
  8003a1:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8003a8:	48 83 c2 08          	add    $0x8,%rdx
  8003ac:	48 89 c6             	mov    %rax,%rsi
  8003af:	48 89 d7             	mov    %rdx,%rdi
  8003b2:	48 b8 62 17 80 00 00 	movabs $0x801762,%rax
  8003b9:	00 00 00 
  8003bc:	ff d0                	callq  *%rax
  8003be:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8003c4:	c9                   	leaveq 
  8003c5:	c3                   	retq   

00000000008003c6 <cprintf>:
  8003c6:	55                   	push   %rbp
  8003c7:	48 89 e5             	mov    %rsp,%rbp
  8003ca:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8003d1:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8003d8:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8003df:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8003e6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8003ed:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8003f4:	84 c0                	test   %al,%al
  8003f6:	74 20                	je     800418 <cprintf+0x52>
  8003f8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8003fc:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800400:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800404:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800408:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80040c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800410:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800414:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800418:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80041f:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800426:	00 00 00 
  800429:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800430:	00 00 00 
  800433:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800437:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80043e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800445:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80044c:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800453:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80045a:	48 8b 0a             	mov    (%rdx),%rcx
  80045d:	48 89 08             	mov    %rcx,(%rax)
  800460:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800464:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800468:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80046c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800470:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800477:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80047e:	48 89 d6             	mov    %rdx,%rsi
  800481:	48 89 c7             	mov    %rax,%rdi
  800484:	48 b8 1a 03 80 00 00 	movabs $0x80031a,%rax
  80048b:	00 00 00 
  80048e:	ff d0                	callq  *%rax
  800490:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800496:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80049c:	c9                   	leaveq 
  80049d:	c3                   	retq   

000000000080049e <printnum>:
  80049e:	55                   	push   %rbp
  80049f:	48 89 e5             	mov    %rsp,%rbp
  8004a2:	53                   	push   %rbx
  8004a3:	48 83 ec 38          	sub    $0x38,%rsp
  8004a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8004ab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8004af:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8004b3:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8004b6:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8004ba:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8004be:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8004c1:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8004c5:	77 3b                	ja     800502 <printnum+0x64>
  8004c7:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8004ca:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8004ce:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8004d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8004d5:	ba 00 00 00 00       	mov    $0x0,%edx
  8004da:	48 f7 f3             	div    %rbx
  8004dd:	48 89 c2             	mov    %rax,%rdx
  8004e0:	8b 7d cc             	mov    -0x34(%rbp),%edi
  8004e3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8004e6:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  8004ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8004ee:	41 89 f9             	mov    %edi,%r9d
  8004f1:	48 89 c7             	mov    %rax,%rdi
  8004f4:	48 b8 9e 04 80 00 00 	movabs $0x80049e,%rax
  8004fb:	00 00 00 
  8004fe:	ff d0                	callq  *%rax
  800500:	eb 1e                	jmp    800520 <printnum+0x82>
  800502:	eb 12                	jmp    800516 <printnum+0x78>
  800504:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800508:	8b 55 cc             	mov    -0x34(%rbp),%edx
  80050b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80050f:	48 89 ce             	mov    %rcx,%rsi
  800512:	89 d7                	mov    %edx,%edi
  800514:	ff d0                	callq  *%rax
  800516:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  80051a:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  80051e:	7f e4                	jg     800504 <printnum+0x66>
  800520:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800523:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800527:	ba 00 00 00 00       	mov    $0x0,%edx
  80052c:	48 f7 f1             	div    %rcx
  80052f:	48 89 d0             	mov    %rdx,%rax
  800532:	48 ba 10 4e 80 00 00 	movabs $0x804e10,%rdx
  800539:	00 00 00 
  80053c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800540:	0f be d0             	movsbl %al,%edx
  800543:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800547:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80054b:	48 89 ce             	mov    %rcx,%rsi
  80054e:	89 d7                	mov    %edx,%edi
  800550:	ff d0                	callq  *%rax
  800552:	48 83 c4 38          	add    $0x38,%rsp
  800556:	5b                   	pop    %rbx
  800557:	5d                   	pop    %rbp
  800558:	c3                   	retq   

0000000000800559 <getuint>:
  800559:	55                   	push   %rbp
  80055a:	48 89 e5             	mov    %rsp,%rbp
  80055d:	48 83 ec 1c          	sub    $0x1c,%rsp
  800561:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800565:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800568:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80056c:	7e 52                	jle    8005c0 <getuint+0x67>
  80056e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800572:	8b 00                	mov    (%rax),%eax
  800574:	83 f8 30             	cmp    $0x30,%eax
  800577:	73 24                	jae    80059d <getuint+0x44>
  800579:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80057d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800581:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800585:	8b 00                	mov    (%rax),%eax
  800587:	89 c0                	mov    %eax,%eax
  800589:	48 01 d0             	add    %rdx,%rax
  80058c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800590:	8b 12                	mov    (%rdx),%edx
  800592:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800595:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800599:	89 0a                	mov    %ecx,(%rdx)
  80059b:	eb 17                	jmp    8005b4 <getuint+0x5b>
  80059d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005a1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005a5:	48 89 d0             	mov    %rdx,%rax
  8005a8:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8005ac:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8005b4:	48 8b 00             	mov    (%rax),%rax
  8005b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005bb:	e9 a3 00 00 00       	jmpq   800663 <getuint+0x10a>
  8005c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8005c4:	74 4f                	je     800615 <getuint+0xbc>
  8005c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ca:	8b 00                	mov    (%rax),%eax
  8005cc:	83 f8 30             	cmp    $0x30,%eax
  8005cf:	73 24                	jae    8005f5 <getuint+0x9c>
  8005d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8005d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005dd:	8b 00                	mov    (%rax),%eax
  8005df:	89 c0                	mov    %eax,%eax
  8005e1:	48 01 d0             	add    %rdx,%rax
  8005e4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005e8:	8b 12                	mov    (%rdx),%edx
  8005ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005ed:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005f1:	89 0a                	mov    %ecx,(%rdx)
  8005f3:	eb 17                	jmp    80060c <getuint+0xb3>
  8005f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005f9:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005fd:	48 89 d0             	mov    %rdx,%rax
  800600:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800604:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800608:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80060c:	48 8b 00             	mov    (%rax),%rax
  80060f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800613:	eb 4e                	jmp    800663 <getuint+0x10a>
  800615:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800619:	8b 00                	mov    (%rax),%eax
  80061b:	83 f8 30             	cmp    $0x30,%eax
  80061e:	73 24                	jae    800644 <getuint+0xeb>
  800620:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800624:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800628:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80062c:	8b 00                	mov    (%rax),%eax
  80062e:	89 c0                	mov    %eax,%eax
  800630:	48 01 d0             	add    %rdx,%rax
  800633:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800637:	8b 12                	mov    (%rdx),%edx
  800639:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80063c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800640:	89 0a                	mov    %ecx,(%rdx)
  800642:	eb 17                	jmp    80065b <getuint+0x102>
  800644:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800648:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80064c:	48 89 d0             	mov    %rdx,%rax
  80064f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800653:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800657:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80065b:	8b 00                	mov    (%rax),%eax
  80065d:	89 c0                	mov    %eax,%eax
  80065f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800663:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800667:	c9                   	leaveq 
  800668:	c3                   	retq   

0000000000800669 <getint>:
  800669:	55                   	push   %rbp
  80066a:	48 89 e5             	mov    %rsp,%rbp
  80066d:	48 83 ec 1c          	sub    $0x1c,%rsp
  800671:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800675:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800678:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  80067c:	7e 52                	jle    8006d0 <getint+0x67>
  80067e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800682:	8b 00                	mov    (%rax),%eax
  800684:	83 f8 30             	cmp    $0x30,%eax
  800687:	73 24                	jae    8006ad <getint+0x44>
  800689:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80068d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800691:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800695:	8b 00                	mov    (%rax),%eax
  800697:	89 c0                	mov    %eax,%eax
  800699:	48 01 d0             	add    %rdx,%rax
  80069c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006a0:	8b 12                	mov    (%rdx),%edx
  8006a2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006a5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006a9:	89 0a                	mov    %ecx,(%rdx)
  8006ab:	eb 17                	jmp    8006c4 <getint+0x5b>
  8006ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006b1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006b5:	48 89 d0             	mov    %rdx,%rax
  8006b8:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006bc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006c0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006c4:	48 8b 00             	mov    (%rax),%rax
  8006c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006cb:	e9 a3 00 00 00       	jmpq   800773 <getint+0x10a>
  8006d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8006d4:	74 4f                	je     800725 <getint+0xbc>
  8006d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006da:	8b 00                	mov    (%rax),%eax
  8006dc:	83 f8 30             	cmp    $0x30,%eax
  8006df:	73 24                	jae    800705 <getint+0x9c>
  8006e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006e5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006ed:	8b 00                	mov    (%rax),%eax
  8006ef:	89 c0                	mov    %eax,%eax
  8006f1:	48 01 d0             	add    %rdx,%rax
  8006f4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006f8:	8b 12                	mov    (%rdx),%edx
  8006fa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006fd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800701:	89 0a                	mov    %ecx,(%rdx)
  800703:	eb 17                	jmp    80071c <getint+0xb3>
  800705:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800709:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80070d:	48 89 d0             	mov    %rdx,%rax
  800710:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800714:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800718:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80071c:	48 8b 00             	mov    (%rax),%rax
  80071f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800723:	eb 4e                	jmp    800773 <getint+0x10a>
  800725:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800729:	8b 00                	mov    (%rax),%eax
  80072b:	83 f8 30             	cmp    $0x30,%eax
  80072e:	73 24                	jae    800754 <getint+0xeb>
  800730:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800734:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800738:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80073c:	8b 00                	mov    (%rax),%eax
  80073e:	89 c0                	mov    %eax,%eax
  800740:	48 01 d0             	add    %rdx,%rax
  800743:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800747:	8b 12                	mov    (%rdx),%edx
  800749:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80074c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800750:	89 0a                	mov    %ecx,(%rdx)
  800752:	eb 17                	jmp    80076b <getint+0x102>
  800754:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800758:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80075c:	48 89 d0             	mov    %rdx,%rax
  80075f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800763:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800767:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80076b:	8b 00                	mov    (%rax),%eax
  80076d:	48 98                	cltq   
  80076f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800777:	c9                   	leaveq 
  800778:	c3                   	retq   

0000000000800779 <vprintfmt>:
  800779:	55                   	push   %rbp
  80077a:	48 89 e5             	mov    %rsp,%rbp
  80077d:	41 54                	push   %r12
  80077f:	53                   	push   %rbx
  800780:	48 83 ec 60          	sub    $0x60,%rsp
  800784:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800788:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  80078c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800790:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800794:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800798:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  80079c:	48 8b 0a             	mov    (%rdx),%rcx
  80079f:	48 89 08             	mov    %rcx,(%rax)
  8007a2:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8007a6:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8007aa:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8007ae:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8007b2:	eb 17                	jmp    8007cb <vprintfmt+0x52>
  8007b4:	85 db                	test   %ebx,%ebx
  8007b6:	0f 84 cc 04 00 00    	je     800c88 <vprintfmt+0x50f>
  8007bc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8007c0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8007c4:	48 89 d6             	mov    %rdx,%rsi
  8007c7:	89 df                	mov    %ebx,%edi
  8007c9:	ff d0                	callq  *%rax
  8007cb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8007cf:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8007d3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8007d7:	0f b6 00             	movzbl (%rax),%eax
  8007da:	0f b6 d8             	movzbl %al,%ebx
  8007dd:	83 fb 25             	cmp    $0x25,%ebx
  8007e0:	75 d2                	jne    8007b4 <vprintfmt+0x3b>
  8007e2:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  8007e6:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  8007ed:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8007f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8007fb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800802:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800806:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80080a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80080e:	0f b6 00             	movzbl (%rax),%eax
  800811:	0f b6 d8             	movzbl %al,%ebx
  800814:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800817:	83 f8 55             	cmp    $0x55,%eax
  80081a:	0f 87 34 04 00 00    	ja     800c54 <vprintfmt+0x4db>
  800820:	89 c0                	mov    %eax,%eax
  800822:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800829:	00 
  80082a:	48 b8 38 4e 80 00 00 	movabs $0x804e38,%rax
  800831:	00 00 00 
  800834:	48 01 d0             	add    %rdx,%rax
  800837:	48 8b 00             	mov    (%rax),%rax
  80083a:	ff e0                	jmpq   *%rax
  80083c:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800840:	eb c0                	jmp    800802 <vprintfmt+0x89>
  800842:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800846:	eb ba                	jmp    800802 <vprintfmt+0x89>
  800848:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  80084f:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800852:	89 d0                	mov    %edx,%eax
  800854:	c1 e0 02             	shl    $0x2,%eax
  800857:	01 d0                	add    %edx,%eax
  800859:	01 c0                	add    %eax,%eax
  80085b:	01 d8                	add    %ebx,%eax
  80085d:	83 e8 30             	sub    $0x30,%eax
  800860:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800863:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800867:	0f b6 00             	movzbl (%rax),%eax
  80086a:	0f be d8             	movsbl %al,%ebx
  80086d:	83 fb 2f             	cmp    $0x2f,%ebx
  800870:	7e 0c                	jle    80087e <vprintfmt+0x105>
  800872:	83 fb 39             	cmp    $0x39,%ebx
  800875:	7f 07                	jg     80087e <vprintfmt+0x105>
  800877:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  80087c:	eb d1                	jmp    80084f <vprintfmt+0xd6>
  80087e:	eb 58                	jmp    8008d8 <vprintfmt+0x15f>
  800880:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800883:	83 f8 30             	cmp    $0x30,%eax
  800886:	73 17                	jae    80089f <vprintfmt+0x126>
  800888:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80088c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80088f:	89 c0                	mov    %eax,%eax
  800891:	48 01 d0             	add    %rdx,%rax
  800894:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800897:	83 c2 08             	add    $0x8,%edx
  80089a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  80089d:	eb 0f                	jmp    8008ae <vprintfmt+0x135>
  80089f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8008a3:	48 89 d0             	mov    %rdx,%rax
  8008a6:	48 83 c2 08          	add    $0x8,%rdx
  8008aa:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8008ae:	8b 00                	mov    (%rax),%eax
  8008b0:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8008b3:	eb 23                	jmp    8008d8 <vprintfmt+0x15f>
  8008b5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8008b9:	79 0c                	jns    8008c7 <vprintfmt+0x14e>
  8008bb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  8008c2:	e9 3b ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008c7:	e9 36 ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008cc:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  8008d3:	e9 2a ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008d8:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8008dc:	79 12                	jns    8008f0 <vprintfmt+0x177>
  8008de:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8008e1:	89 45 dc             	mov    %eax,-0x24(%rbp)
  8008e4:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  8008eb:	e9 12 ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008f0:	e9 0d ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008f5:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  8008f9:	e9 04 ff ff ff       	jmpq   800802 <vprintfmt+0x89>
  8008fe:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800901:	83 f8 30             	cmp    $0x30,%eax
  800904:	73 17                	jae    80091d <vprintfmt+0x1a4>
  800906:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80090a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80090d:	89 c0                	mov    %eax,%eax
  80090f:	48 01 d0             	add    %rdx,%rax
  800912:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800915:	83 c2 08             	add    $0x8,%edx
  800918:	89 55 b8             	mov    %edx,-0x48(%rbp)
  80091b:	eb 0f                	jmp    80092c <vprintfmt+0x1b3>
  80091d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800921:	48 89 d0             	mov    %rdx,%rax
  800924:	48 83 c2 08          	add    $0x8,%rdx
  800928:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  80092c:	8b 10                	mov    (%rax),%edx
  80092e:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800932:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800936:	48 89 ce             	mov    %rcx,%rsi
  800939:	89 d7                	mov    %edx,%edi
  80093b:	ff d0                	callq  *%rax
  80093d:	e9 40 03 00 00       	jmpq   800c82 <vprintfmt+0x509>
  800942:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800945:	83 f8 30             	cmp    $0x30,%eax
  800948:	73 17                	jae    800961 <vprintfmt+0x1e8>
  80094a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80094e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800951:	89 c0                	mov    %eax,%eax
  800953:	48 01 d0             	add    %rdx,%rax
  800956:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800959:	83 c2 08             	add    $0x8,%edx
  80095c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  80095f:	eb 0f                	jmp    800970 <vprintfmt+0x1f7>
  800961:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800965:	48 89 d0             	mov    %rdx,%rax
  800968:	48 83 c2 08          	add    $0x8,%rdx
  80096c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800970:	8b 18                	mov    (%rax),%ebx
  800972:	85 db                	test   %ebx,%ebx
  800974:	79 02                	jns    800978 <vprintfmt+0x1ff>
  800976:	f7 db                	neg    %ebx
  800978:	83 fb 15             	cmp    $0x15,%ebx
  80097b:	7f 16                	jg     800993 <vprintfmt+0x21a>
  80097d:	48 b8 60 4d 80 00 00 	movabs $0x804d60,%rax
  800984:	00 00 00 
  800987:	48 63 d3             	movslq %ebx,%rdx
  80098a:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  80098e:	4d 85 e4             	test   %r12,%r12
  800991:	75 2e                	jne    8009c1 <vprintfmt+0x248>
  800993:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800997:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80099b:	89 d9                	mov    %ebx,%ecx
  80099d:	48 ba 21 4e 80 00 00 	movabs $0x804e21,%rdx
  8009a4:	00 00 00 
  8009a7:	48 89 c7             	mov    %rax,%rdi
  8009aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8009af:	49 b8 91 0c 80 00 00 	movabs $0x800c91,%r8
  8009b6:	00 00 00 
  8009b9:	41 ff d0             	callq  *%r8
  8009bc:	e9 c1 02 00 00       	jmpq   800c82 <vprintfmt+0x509>
  8009c1:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8009c5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009c9:	4c 89 e1             	mov    %r12,%rcx
  8009cc:	48 ba 2a 4e 80 00 00 	movabs $0x804e2a,%rdx
  8009d3:	00 00 00 
  8009d6:	48 89 c7             	mov    %rax,%rdi
  8009d9:	b8 00 00 00 00       	mov    $0x0,%eax
  8009de:	49 b8 91 0c 80 00 00 	movabs $0x800c91,%r8
  8009e5:	00 00 00 
  8009e8:	41 ff d0             	callq  *%r8
  8009eb:	e9 92 02 00 00       	jmpq   800c82 <vprintfmt+0x509>
  8009f0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009f3:	83 f8 30             	cmp    $0x30,%eax
  8009f6:	73 17                	jae    800a0f <vprintfmt+0x296>
  8009f8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8009fc:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8009ff:	89 c0                	mov    %eax,%eax
  800a01:	48 01 d0             	add    %rdx,%rax
  800a04:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a07:	83 c2 08             	add    $0x8,%edx
  800a0a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a0d:	eb 0f                	jmp    800a1e <vprintfmt+0x2a5>
  800a0f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a13:	48 89 d0             	mov    %rdx,%rax
  800a16:	48 83 c2 08          	add    $0x8,%rdx
  800a1a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a1e:	4c 8b 20             	mov    (%rax),%r12
  800a21:	4d 85 e4             	test   %r12,%r12
  800a24:	75 0a                	jne    800a30 <vprintfmt+0x2b7>
  800a26:	49 bc 2d 4e 80 00 00 	movabs $0x804e2d,%r12
  800a2d:	00 00 00 
  800a30:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a34:	7e 3f                	jle    800a75 <vprintfmt+0x2fc>
  800a36:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800a3a:	74 39                	je     800a75 <vprintfmt+0x2fc>
  800a3c:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800a3f:	48 98                	cltq   
  800a41:	48 89 c6             	mov    %rax,%rsi
  800a44:	4c 89 e7             	mov    %r12,%rdi
  800a47:	48 b8 3d 0f 80 00 00 	movabs $0x800f3d,%rax
  800a4e:	00 00 00 
  800a51:	ff d0                	callq  *%rax
  800a53:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800a56:	eb 17                	jmp    800a6f <vprintfmt+0x2f6>
  800a58:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800a5c:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800a60:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a64:	48 89 ce             	mov    %rcx,%rsi
  800a67:	89 d7                	mov    %edx,%edi
  800a69:	ff d0                	callq  *%rax
  800a6b:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a73:	7f e3                	jg     800a58 <vprintfmt+0x2df>
  800a75:	eb 37                	jmp    800aae <vprintfmt+0x335>
  800a77:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800a7b:	74 1e                	je     800a9b <vprintfmt+0x322>
  800a7d:	83 fb 1f             	cmp    $0x1f,%ebx
  800a80:	7e 05                	jle    800a87 <vprintfmt+0x30e>
  800a82:	83 fb 7e             	cmp    $0x7e,%ebx
  800a85:	7e 14                	jle    800a9b <vprintfmt+0x322>
  800a87:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a8b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a8f:	48 89 d6             	mov    %rdx,%rsi
  800a92:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800a97:	ff d0                	callq  *%rax
  800a99:	eb 0f                	jmp    800aaa <vprintfmt+0x331>
  800a9b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800a9f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800aa3:	48 89 d6             	mov    %rdx,%rsi
  800aa6:	89 df                	mov    %ebx,%edi
  800aa8:	ff d0                	callq  *%rax
  800aaa:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800aae:	4c 89 e0             	mov    %r12,%rax
  800ab1:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800ab5:	0f b6 00             	movzbl (%rax),%eax
  800ab8:	0f be d8             	movsbl %al,%ebx
  800abb:	85 db                	test   %ebx,%ebx
  800abd:	74 10                	je     800acf <vprintfmt+0x356>
  800abf:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800ac3:	78 b2                	js     800a77 <vprintfmt+0x2fe>
  800ac5:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800ac9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800acd:	79 a8                	jns    800a77 <vprintfmt+0x2fe>
  800acf:	eb 16                	jmp    800ae7 <vprintfmt+0x36e>
  800ad1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ad5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ad9:	48 89 d6             	mov    %rdx,%rsi
  800adc:	bf 20 00 00 00       	mov    $0x20,%edi
  800ae1:	ff d0                	callq  *%rax
  800ae3:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ae7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800aeb:	7f e4                	jg     800ad1 <vprintfmt+0x358>
  800aed:	e9 90 01 00 00       	jmpq   800c82 <vprintfmt+0x509>
  800af2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800af6:	be 03 00 00 00       	mov    $0x3,%esi
  800afb:	48 89 c7             	mov    %rax,%rdi
  800afe:	48 b8 69 06 80 00 00 	movabs $0x800669,%rax
  800b05:	00 00 00 
  800b08:	ff d0                	callq  *%rax
  800b0a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b12:	48 85 c0             	test   %rax,%rax
  800b15:	79 1d                	jns    800b34 <vprintfmt+0x3bb>
  800b17:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b1b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b1f:	48 89 d6             	mov    %rdx,%rsi
  800b22:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800b27:	ff d0                	callq  *%rax
  800b29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b2d:	48 f7 d8             	neg    %rax
  800b30:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b34:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800b3b:	e9 d5 00 00 00       	jmpq   800c15 <vprintfmt+0x49c>
  800b40:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b44:	be 03 00 00 00       	mov    $0x3,%esi
  800b49:	48 89 c7             	mov    %rax,%rdi
  800b4c:	48 b8 59 05 80 00 00 	movabs $0x800559,%rax
  800b53:	00 00 00 
  800b56:	ff d0                	callq  *%rax
  800b58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b5c:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800b63:	e9 ad 00 00 00       	jmpq   800c15 <vprintfmt+0x49c>
  800b68:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b6c:	be 03 00 00 00       	mov    $0x3,%esi
  800b71:	48 89 c7             	mov    %rax,%rdi
  800b74:	48 b8 59 05 80 00 00 	movabs $0x800559,%rax
  800b7b:	00 00 00 
  800b7e:	ff d0                	callq  *%rax
  800b80:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b84:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800b8b:	e9 85 00 00 00       	jmpq   800c15 <vprintfmt+0x49c>
  800b90:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b94:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b98:	48 89 d6             	mov    %rdx,%rsi
  800b9b:	bf 30 00 00 00       	mov    $0x30,%edi
  800ba0:	ff d0                	callq  *%rax
  800ba2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ba6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800baa:	48 89 d6             	mov    %rdx,%rsi
  800bad:	bf 78 00 00 00       	mov    $0x78,%edi
  800bb2:	ff d0                	callq  *%rax
  800bb4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bb7:	83 f8 30             	cmp    $0x30,%eax
  800bba:	73 17                	jae    800bd3 <vprintfmt+0x45a>
  800bbc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800bc0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bc3:	89 c0                	mov    %eax,%eax
  800bc5:	48 01 d0             	add    %rdx,%rax
  800bc8:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800bcb:	83 c2 08             	add    $0x8,%edx
  800bce:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bd1:	eb 0f                	jmp    800be2 <vprintfmt+0x469>
  800bd3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bd7:	48 89 d0             	mov    %rdx,%rax
  800bda:	48 83 c2 08          	add    $0x8,%rdx
  800bde:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800be2:	48 8b 00             	mov    (%rax),%rax
  800be5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800be9:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800bf0:	eb 23                	jmp    800c15 <vprintfmt+0x49c>
  800bf2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800bf6:	be 03 00 00 00       	mov    $0x3,%esi
  800bfb:	48 89 c7             	mov    %rax,%rdi
  800bfe:	48 b8 59 05 80 00 00 	movabs $0x800559,%rax
  800c05:	00 00 00 
  800c08:	ff d0                	callq  *%rax
  800c0a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c0e:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800c15:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800c1a:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800c1d:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800c20:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c24:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c28:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c2c:	45 89 c1             	mov    %r8d,%r9d
  800c2f:	41 89 f8             	mov    %edi,%r8d
  800c32:	48 89 c7             	mov    %rax,%rdi
  800c35:	48 b8 9e 04 80 00 00 	movabs $0x80049e,%rax
  800c3c:	00 00 00 
  800c3f:	ff d0                	callq  *%rax
  800c41:	eb 3f                	jmp    800c82 <vprintfmt+0x509>
  800c43:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c47:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c4b:	48 89 d6             	mov    %rdx,%rsi
  800c4e:	89 df                	mov    %ebx,%edi
  800c50:	ff d0                	callq  *%rax
  800c52:	eb 2e                	jmp    800c82 <vprintfmt+0x509>
  800c54:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c58:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c5c:	48 89 d6             	mov    %rdx,%rsi
  800c5f:	bf 25 00 00 00       	mov    $0x25,%edi
  800c64:	ff d0                	callq  *%rax
  800c66:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c6b:	eb 05                	jmp    800c72 <vprintfmt+0x4f9>
  800c6d:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c72:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c76:	48 83 e8 01          	sub    $0x1,%rax
  800c7a:	0f b6 00             	movzbl (%rax),%eax
  800c7d:	3c 25                	cmp    $0x25,%al
  800c7f:	75 ec                	jne    800c6d <vprintfmt+0x4f4>
  800c81:	90                   	nop
  800c82:	90                   	nop
  800c83:	e9 43 fb ff ff       	jmpq   8007cb <vprintfmt+0x52>
  800c88:	48 83 c4 60          	add    $0x60,%rsp
  800c8c:	5b                   	pop    %rbx
  800c8d:	41 5c                	pop    %r12
  800c8f:	5d                   	pop    %rbp
  800c90:	c3                   	retq   

0000000000800c91 <printfmt>:
  800c91:	55                   	push   %rbp
  800c92:	48 89 e5             	mov    %rsp,%rbp
  800c95:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800c9c:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800ca3:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800caa:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800cb1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800cb8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800cbf:	84 c0                	test   %al,%al
  800cc1:	74 20                	je     800ce3 <printfmt+0x52>
  800cc3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800cc7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800ccb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800ccf:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800cd3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800cd7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800cdb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800cdf:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800ce3:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800cea:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800cf1:	00 00 00 
  800cf4:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800cfb:	00 00 00 
  800cfe:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800d02:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800d09:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800d10:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800d17:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800d1e:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800d25:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800d2c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800d33:	48 89 c7             	mov    %rax,%rdi
  800d36:	48 b8 79 07 80 00 00 	movabs $0x800779,%rax
  800d3d:	00 00 00 
  800d40:	ff d0                	callq  *%rax
  800d42:	c9                   	leaveq 
  800d43:	c3                   	retq   

0000000000800d44 <sprintputch>:
  800d44:	55                   	push   %rbp
  800d45:	48 89 e5             	mov    %rsp,%rbp
  800d48:	48 83 ec 10          	sub    $0x10,%rsp
  800d4c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d4f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d57:	8b 40 10             	mov    0x10(%rax),%eax
  800d5a:	8d 50 01             	lea    0x1(%rax),%edx
  800d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d61:	89 50 10             	mov    %edx,0x10(%rax)
  800d64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d68:	48 8b 10             	mov    (%rax),%rdx
  800d6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d6f:	48 8b 40 08          	mov    0x8(%rax),%rax
  800d73:	48 39 c2             	cmp    %rax,%rdx
  800d76:	73 17                	jae    800d8f <sprintputch+0x4b>
  800d78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d7c:	48 8b 00             	mov    (%rax),%rax
  800d7f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800d83:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800d87:	48 89 0a             	mov    %rcx,(%rdx)
  800d8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800d8d:	88 10                	mov    %dl,(%rax)
  800d8f:	c9                   	leaveq 
  800d90:	c3                   	retq   

0000000000800d91 <vsnprintf>:
  800d91:	55                   	push   %rbp
  800d92:	48 89 e5             	mov    %rsp,%rbp
  800d95:	48 83 ec 50          	sub    $0x50,%rsp
  800d99:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800d9d:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800da0:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800da4:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800da8:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800dac:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800db0:	48 8b 0a             	mov    (%rdx),%rcx
  800db3:	48 89 08             	mov    %rcx,(%rax)
  800db6:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800dba:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800dbe:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800dc2:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800dc6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800dca:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800dce:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800dd1:	48 98                	cltq   
  800dd3:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800dd7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800ddb:	48 01 d0             	add    %rdx,%rax
  800dde:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800de2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800de9:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800dee:	74 06                	je     800df6 <vsnprintf+0x65>
  800df0:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800df4:	7f 07                	jg     800dfd <vsnprintf+0x6c>
  800df6:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800dfb:	eb 2f                	jmp    800e2c <vsnprintf+0x9b>
  800dfd:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800e01:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800e05:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800e09:	48 89 c6             	mov    %rax,%rsi
  800e0c:	48 bf 44 0d 80 00 00 	movabs $0x800d44,%rdi
  800e13:	00 00 00 
  800e16:	48 b8 79 07 80 00 00 	movabs $0x800779,%rax
  800e1d:	00 00 00 
  800e20:	ff d0                	callq  *%rax
  800e22:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800e26:	c6 00 00             	movb   $0x0,(%rax)
  800e29:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800e2c:	c9                   	leaveq 
  800e2d:	c3                   	retq   

0000000000800e2e <snprintf>:
  800e2e:	55                   	push   %rbp
  800e2f:	48 89 e5             	mov    %rsp,%rbp
  800e32:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800e39:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800e40:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800e46:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800e4d:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800e54:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800e5b:	84 c0                	test   %al,%al
  800e5d:	74 20                	je     800e7f <snprintf+0x51>
  800e5f:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800e63:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800e67:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800e6b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800e6f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800e73:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800e77:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800e7b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800e7f:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800e86:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800e8d:	00 00 00 
  800e90:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800e97:	00 00 00 
  800e9a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800e9e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800ea5:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800eac:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800eb3:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800eba:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800ec1:	48 8b 0a             	mov    (%rdx),%rcx
  800ec4:	48 89 08             	mov    %rcx,(%rax)
  800ec7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ecb:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ecf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ed3:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800ed7:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800ede:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800ee5:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800eeb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800ef2:	48 89 c7             	mov    %rax,%rdi
  800ef5:	48 b8 91 0d 80 00 00 	movabs $0x800d91,%rax
  800efc:	00 00 00 
  800eff:	ff d0                	callq  *%rax
  800f01:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800f07:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800f0d:	c9                   	leaveq 
  800f0e:	c3                   	retq   

0000000000800f0f <strlen>:
  800f0f:	55                   	push   %rbp
  800f10:	48 89 e5             	mov    %rsp,%rbp
  800f13:	48 83 ec 18          	sub    $0x18,%rsp
  800f17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800f22:	eb 09                	jmp    800f2d <strlen+0x1e>
  800f24:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f28:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800f2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f31:	0f b6 00             	movzbl (%rax),%eax
  800f34:	84 c0                	test   %al,%al
  800f36:	75 ec                	jne    800f24 <strlen+0x15>
  800f38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f3b:	c9                   	leaveq 
  800f3c:	c3                   	retq   

0000000000800f3d <strnlen>:
  800f3d:	55                   	push   %rbp
  800f3e:	48 89 e5             	mov    %rsp,%rbp
  800f41:	48 83 ec 20          	sub    $0x20,%rsp
  800f45:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f49:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800f54:	eb 0e                	jmp    800f64 <strnlen+0x27>
  800f56:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f5a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800f5f:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  800f64:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800f69:	74 0b                	je     800f76 <strnlen+0x39>
  800f6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f6f:	0f b6 00             	movzbl (%rax),%eax
  800f72:	84 c0                	test   %al,%al
  800f74:	75 e0                	jne    800f56 <strnlen+0x19>
  800f76:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f79:	c9                   	leaveq 
  800f7a:	c3                   	retq   

0000000000800f7b <strcpy>:
  800f7b:	55                   	push   %rbp
  800f7c:	48 89 e5             	mov    %rsp,%rbp
  800f7f:	48 83 ec 20          	sub    $0x20,%rsp
  800f83:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f87:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800f93:	90                   	nop
  800f94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f98:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800f9c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800fa0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800fa4:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800fa8:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800fac:	0f b6 12             	movzbl (%rdx),%edx
  800faf:	88 10                	mov    %dl,(%rax)
  800fb1:	0f b6 00             	movzbl (%rax),%eax
  800fb4:	84 c0                	test   %al,%al
  800fb6:	75 dc                	jne    800f94 <strcpy+0x19>
  800fb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fbc:	c9                   	leaveq 
  800fbd:	c3                   	retq   

0000000000800fbe <strcat>:
  800fbe:	55                   	push   %rbp
  800fbf:	48 89 e5             	mov    %rsp,%rbp
  800fc2:	48 83 ec 20          	sub    $0x20,%rsp
  800fc6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fd2:	48 89 c7             	mov    %rax,%rdi
  800fd5:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  800fdc:	00 00 00 
  800fdf:	ff d0                	callq  *%rax
  800fe1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800fe4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800fe7:	48 63 d0             	movslq %eax,%rdx
  800fea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fee:	48 01 c2             	add    %rax,%rdx
  800ff1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800ff5:	48 89 c6             	mov    %rax,%rsi
  800ff8:	48 89 d7             	mov    %rdx,%rdi
  800ffb:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  801002:	00 00 00 
  801005:	ff d0                	callq  *%rax
  801007:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80100b:	c9                   	leaveq 
  80100c:	c3                   	retq   

000000000080100d <strncpy>:
  80100d:	55                   	push   %rbp
  80100e:	48 89 e5             	mov    %rsp,%rbp
  801011:	48 83 ec 28          	sub    $0x28,%rsp
  801015:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801019:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80101d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801021:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801025:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801029:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801030:	00 
  801031:	eb 2a                	jmp    80105d <strncpy+0x50>
  801033:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801037:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80103b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80103f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801043:	0f b6 12             	movzbl (%rdx),%edx
  801046:	88 10                	mov    %dl,(%rax)
  801048:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80104c:	0f b6 00             	movzbl (%rax),%eax
  80104f:	84 c0                	test   %al,%al
  801051:	74 05                	je     801058 <strncpy+0x4b>
  801053:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801058:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80105d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801061:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801065:	72 cc                	jb     801033 <strncpy+0x26>
  801067:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80106b:	c9                   	leaveq 
  80106c:	c3                   	retq   

000000000080106d <strlcpy>:
  80106d:	55                   	push   %rbp
  80106e:	48 89 e5             	mov    %rsp,%rbp
  801071:	48 83 ec 28          	sub    $0x28,%rsp
  801075:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801079:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80107d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801085:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801089:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80108e:	74 3d                	je     8010cd <strlcpy+0x60>
  801090:	eb 1d                	jmp    8010af <strlcpy+0x42>
  801092:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801096:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80109a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80109e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8010a2:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8010a6:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8010aa:	0f b6 12             	movzbl (%rdx),%edx
  8010ad:	88 10                	mov    %dl,(%rax)
  8010af:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8010b4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8010b9:	74 0b                	je     8010c6 <strlcpy+0x59>
  8010bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8010bf:	0f b6 00             	movzbl (%rax),%eax
  8010c2:	84 c0                	test   %al,%al
  8010c4:	75 cc                	jne    801092 <strlcpy+0x25>
  8010c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ca:	c6 00 00             	movb   $0x0,(%rax)
  8010cd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010d5:	48 29 c2             	sub    %rax,%rdx
  8010d8:	48 89 d0             	mov    %rdx,%rax
  8010db:	c9                   	leaveq 
  8010dc:	c3                   	retq   

00000000008010dd <strcmp>:
  8010dd:	55                   	push   %rbp
  8010de:	48 89 e5             	mov    %rsp,%rbp
  8010e1:	48 83 ec 10          	sub    $0x10,%rsp
  8010e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8010e9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8010ed:	eb 0a                	jmp    8010f9 <strcmp+0x1c>
  8010ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8010f4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8010f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010fd:	0f b6 00             	movzbl (%rax),%eax
  801100:	84 c0                	test   %al,%al
  801102:	74 12                	je     801116 <strcmp+0x39>
  801104:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801108:	0f b6 10             	movzbl (%rax),%edx
  80110b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80110f:	0f b6 00             	movzbl (%rax),%eax
  801112:	38 c2                	cmp    %al,%dl
  801114:	74 d9                	je     8010ef <strcmp+0x12>
  801116:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80111a:	0f b6 00             	movzbl (%rax),%eax
  80111d:	0f b6 d0             	movzbl %al,%edx
  801120:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801124:	0f b6 00             	movzbl (%rax),%eax
  801127:	0f b6 c0             	movzbl %al,%eax
  80112a:	29 c2                	sub    %eax,%edx
  80112c:	89 d0                	mov    %edx,%eax
  80112e:	c9                   	leaveq 
  80112f:	c3                   	retq   

0000000000801130 <strncmp>:
  801130:	55                   	push   %rbp
  801131:	48 89 e5             	mov    %rsp,%rbp
  801134:	48 83 ec 18          	sub    $0x18,%rsp
  801138:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80113c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801140:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801144:	eb 0f                	jmp    801155 <strncmp+0x25>
  801146:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  80114b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801150:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801155:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80115a:	74 1d                	je     801179 <strncmp+0x49>
  80115c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801160:	0f b6 00             	movzbl (%rax),%eax
  801163:	84 c0                	test   %al,%al
  801165:	74 12                	je     801179 <strncmp+0x49>
  801167:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80116b:	0f b6 10             	movzbl (%rax),%edx
  80116e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801172:	0f b6 00             	movzbl (%rax),%eax
  801175:	38 c2                	cmp    %al,%dl
  801177:	74 cd                	je     801146 <strncmp+0x16>
  801179:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80117e:	75 07                	jne    801187 <strncmp+0x57>
  801180:	b8 00 00 00 00       	mov    $0x0,%eax
  801185:	eb 18                	jmp    80119f <strncmp+0x6f>
  801187:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80118b:	0f b6 00             	movzbl (%rax),%eax
  80118e:	0f b6 d0             	movzbl %al,%edx
  801191:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801195:	0f b6 00             	movzbl (%rax),%eax
  801198:	0f b6 c0             	movzbl %al,%eax
  80119b:	29 c2                	sub    %eax,%edx
  80119d:	89 d0                	mov    %edx,%eax
  80119f:	c9                   	leaveq 
  8011a0:	c3                   	retq   

00000000008011a1 <strchr>:
  8011a1:	55                   	push   %rbp
  8011a2:	48 89 e5             	mov    %rsp,%rbp
  8011a5:	48 83 ec 0c          	sub    $0xc,%rsp
  8011a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011ad:	89 f0                	mov    %esi,%eax
  8011af:	88 45 f4             	mov    %al,-0xc(%rbp)
  8011b2:	eb 17                	jmp    8011cb <strchr+0x2a>
  8011b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011b8:	0f b6 00             	movzbl (%rax),%eax
  8011bb:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8011be:	75 06                	jne    8011c6 <strchr+0x25>
  8011c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011c4:	eb 15                	jmp    8011db <strchr+0x3a>
  8011c6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8011cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011cf:	0f b6 00             	movzbl (%rax),%eax
  8011d2:	84 c0                	test   %al,%al
  8011d4:	75 de                	jne    8011b4 <strchr+0x13>
  8011d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8011db:	c9                   	leaveq 
  8011dc:	c3                   	retq   

00000000008011dd <strfind>:
  8011dd:	55                   	push   %rbp
  8011de:	48 89 e5             	mov    %rsp,%rbp
  8011e1:	48 83 ec 0c          	sub    $0xc,%rsp
  8011e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011e9:	89 f0                	mov    %esi,%eax
  8011eb:	88 45 f4             	mov    %al,-0xc(%rbp)
  8011ee:	eb 13                	jmp    801203 <strfind+0x26>
  8011f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011f4:	0f b6 00             	movzbl (%rax),%eax
  8011f7:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8011fa:	75 02                	jne    8011fe <strfind+0x21>
  8011fc:	eb 10                	jmp    80120e <strfind+0x31>
  8011fe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801207:	0f b6 00             	movzbl (%rax),%eax
  80120a:	84 c0                	test   %al,%al
  80120c:	75 e2                	jne    8011f0 <strfind+0x13>
  80120e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801212:	c9                   	leaveq 
  801213:	c3                   	retq   

0000000000801214 <memset>:
  801214:	55                   	push   %rbp
  801215:	48 89 e5             	mov    %rsp,%rbp
  801218:	48 83 ec 18          	sub    $0x18,%rsp
  80121c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801220:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801223:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801227:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80122c:	75 06                	jne    801234 <memset+0x20>
  80122e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801232:	eb 69                	jmp    80129d <memset+0x89>
  801234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801238:	83 e0 03             	and    $0x3,%eax
  80123b:	48 85 c0             	test   %rax,%rax
  80123e:	75 48                	jne    801288 <memset+0x74>
  801240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801244:	83 e0 03             	and    $0x3,%eax
  801247:	48 85 c0             	test   %rax,%rax
  80124a:	75 3c                	jne    801288 <memset+0x74>
  80124c:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801253:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801256:	c1 e0 18             	shl    $0x18,%eax
  801259:	89 c2                	mov    %eax,%edx
  80125b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80125e:	c1 e0 10             	shl    $0x10,%eax
  801261:	09 c2                	or     %eax,%edx
  801263:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801266:	c1 e0 08             	shl    $0x8,%eax
  801269:	09 d0                	or     %edx,%eax
  80126b:	09 45 f4             	or     %eax,-0xc(%rbp)
  80126e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801272:	48 c1 e8 02          	shr    $0x2,%rax
  801276:	48 89 c1             	mov    %rax,%rcx
  801279:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80127d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801280:	48 89 d7             	mov    %rdx,%rdi
  801283:	fc                   	cld    
  801284:	f3 ab                	rep stos %eax,%es:(%rdi)
  801286:	eb 11                	jmp    801299 <memset+0x85>
  801288:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80128c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80128f:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801293:	48 89 d7             	mov    %rdx,%rdi
  801296:	fc                   	cld    
  801297:	f3 aa                	rep stos %al,%es:(%rdi)
  801299:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80129d:	c9                   	leaveq 
  80129e:	c3                   	retq   

000000000080129f <memmove>:
  80129f:	55                   	push   %rbp
  8012a0:	48 89 e5             	mov    %rsp,%rbp
  8012a3:	48 83 ec 28          	sub    $0x28,%rsp
  8012a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012ab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012af:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8012c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012c7:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8012cb:	0f 83 88 00 00 00    	jae    801359 <memmove+0xba>
  8012d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012d5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8012d9:	48 01 d0             	add    %rdx,%rax
  8012dc:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8012e0:	76 77                	jbe    801359 <memmove+0xba>
  8012e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012e6:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8012ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012ee:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8012f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012f6:	83 e0 03             	and    $0x3,%eax
  8012f9:	48 85 c0             	test   %rax,%rax
  8012fc:	75 3b                	jne    801339 <memmove+0x9a>
  8012fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801302:	83 e0 03             	and    $0x3,%eax
  801305:	48 85 c0             	test   %rax,%rax
  801308:	75 2f                	jne    801339 <memmove+0x9a>
  80130a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80130e:	83 e0 03             	and    $0x3,%eax
  801311:	48 85 c0             	test   %rax,%rax
  801314:	75 23                	jne    801339 <memmove+0x9a>
  801316:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80131a:	48 83 e8 04          	sub    $0x4,%rax
  80131e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801322:	48 83 ea 04          	sub    $0x4,%rdx
  801326:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80132a:	48 c1 e9 02          	shr    $0x2,%rcx
  80132e:	48 89 c7             	mov    %rax,%rdi
  801331:	48 89 d6             	mov    %rdx,%rsi
  801334:	fd                   	std    
  801335:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801337:	eb 1d                	jmp    801356 <memmove+0xb7>
  801339:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80133d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801341:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801345:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801349:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80134d:	48 89 d7             	mov    %rdx,%rdi
  801350:	48 89 c1             	mov    %rax,%rcx
  801353:	fd                   	std    
  801354:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801356:	fc                   	cld    
  801357:	eb 57                	jmp    8013b0 <memmove+0x111>
  801359:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80135d:	83 e0 03             	and    $0x3,%eax
  801360:	48 85 c0             	test   %rax,%rax
  801363:	75 36                	jne    80139b <memmove+0xfc>
  801365:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801369:	83 e0 03             	and    $0x3,%eax
  80136c:	48 85 c0             	test   %rax,%rax
  80136f:	75 2a                	jne    80139b <memmove+0xfc>
  801371:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801375:	83 e0 03             	and    $0x3,%eax
  801378:	48 85 c0             	test   %rax,%rax
  80137b:	75 1e                	jne    80139b <memmove+0xfc>
  80137d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801381:	48 c1 e8 02          	shr    $0x2,%rax
  801385:	48 89 c1             	mov    %rax,%rcx
  801388:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80138c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801390:	48 89 c7             	mov    %rax,%rdi
  801393:	48 89 d6             	mov    %rdx,%rsi
  801396:	fc                   	cld    
  801397:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801399:	eb 15                	jmp    8013b0 <memmove+0x111>
  80139b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80139f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013a3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8013a7:	48 89 c7             	mov    %rax,%rdi
  8013aa:	48 89 d6             	mov    %rdx,%rsi
  8013ad:	fc                   	cld    
  8013ae:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8013b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013b4:	c9                   	leaveq 
  8013b5:	c3                   	retq   

00000000008013b6 <memcpy>:
  8013b6:	55                   	push   %rbp
  8013b7:	48 89 e5             	mov    %rsp,%rbp
  8013ba:	48 83 ec 18          	sub    $0x18,%rsp
  8013be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8013c2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8013c6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013ca:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8013ce:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8013d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013d6:	48 89 ce             	mov    %rcx,%rsi
  8013d9:	48 89 c7             	mov    %rax,%rdi
  8013dc:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  8013e3:	00 00 00 
  8013e6:	ff d0                	callq  *%rax
  8013e8:	c9                   	leaveq 
  8013e9:	c3                   	retq   

00000000008013ea <memcmp>:
  8013ea:	55                   	push   %rbp
  8013eb:	48 89 e5             	mov    %rsp,%rbp
  8013ee:	48 83 ec 28          	sub    $0x28,%rsp
  8013f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013fa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801402:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801406:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80140a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80140e:	eb 36                	jmp    801446 <memcmp+0x5c>
  801410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801414:	0f b6 10             	movzbl (%rax),%edx
  801417:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80141b:	0f b6 00             	movzbl (%rax),%eax
  80141e:	38 c2                	cmp    %al,%dl
  801420:	74 1a                	je     80143c <memcmp+0x52>
  801422:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801426:	0f b6 00             	movzbl (%rax),%eax
  801429:	0f b6 d0             	movzbl %al,%edx
  80142c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801430:	0f b6 00             	movzbl (%rax),%eax
  801433:	0f b6 c0             	movzbl %al,%eax
  801436:	29 c2                	sub    %eax,%edx
  801438:	89 d0                	mov    %edx,%eax
  80143a:	eb 20                	jmp    80145c <memcmp+0x72>
  80143c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801441:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801446:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80144a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80144e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801452:	48 85 c0             	test   %rax,%rax
  801455:	75 b9                	jne    801410 <memcmp+0x26>
  801457:	b8 00 00 00 00       	mov    $0x0,%eax
  80145c:	c9                   	leaveq 
  80145d:	c3                   	retq   

000000000080145e <memfind>:
  80145e:	55                   	push   %rbp
  80145f:	48 89 e5             	mov    %rsp,%rbp
  801462:	48 83 ec 28          	sub    $0x28,%rsp
  801466:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80146a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80146d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801471:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801475:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801479:	48 01 d0             	add    %rdx,%rax
  80147c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801480:	eb 15                	jmp    801497 <memfind+0x39>
  801482:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801486:	0f b6 10             	movzbl (%rax),%edx
  801489:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80148c:	38 c2                	cmp    %al,%dl
  80148e:	75 02                	jne    801492 <memfind+0x34>
  801490:	eb 0f                	jmp    8014a1 <memfind+0x43>
  801492:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801497:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80149b:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  80149f:	72 e1                	jb     801482 <memfind+0x24>
  8014a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014a5:	c9                   	leaveq 
  8014a6:	c3                   	retq   

00000000008014a7 <strtol>:
  8014a7:	55                   	push   %rbp
  8014a8:	48 89 e5             	mov    %rsp,%rbp
  8014ab:	48 83 ec 34          	sub    $0x34,%rsp
  8014af:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8014b3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8014b7:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8014ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8014c1:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8014c8:	00 
  8014c9:	eb 05                	jmp    8014d0 <strtol+0x29>
  8014cb:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014d4:	0f b6 00             	movzbl (%rax),%eax
  8014d7:	3c 20                	cmp    $0x20,%al
  8014d9:	74 f0                	je     8014cb <strtol+0x24>
  8014db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014df:	0f b6 00             	movzbl (%rax),%eax
  8014e2:	3c 09                	cmp    $0x9,%al
  8014e4:	74 e5                	je     8014cb <strtol+0x24>
  8014e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014ea:	0f b6 00             	movzbl (%rax),%eax
  8014ed:	3c 2b                	cmp    $0x2b,%al
  8014ef:	75 07                	jne    8014f8 <strtol+0x51>
  8014f1:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014f6:	eb 17                	jmp    80150f <strtol+0x68>
  8014f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014fc:	0f b6 00             	movzbl (%rax),%eax
  8014ff:	3c 2d                	cmp    $0x2d,%al
  801501:	75 0c                	jne    80150f <strtol+0x68>
  801503:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801508:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80150f:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801513:	74 06                	je     80151b <strtol+0x74>
  801515:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801519:	75 28                	jne    801543 <strtol+0x9c>
  80151b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80151f:	0f b6 00             	movzbl (%rax),%eax
  801522:	3c 30                	cmp    $0x30,%al
  801524:	75 1d                	jne    801543 <strtol+0x9c>
  801526:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80152a:	48 83 c0 01          	add    $0x1,%rax
  80152e:	0f b6 00             	movzbl (%rax),%eax
  801531:	3c 78                	cmp    $0x78,%al
  801533:	75 0e                	jne    801543 <strtol+0x9c>
  801535:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  80153a:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801541:	eb 2c                	jmp    80156f <strtol+0xc8>
  801543:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801547:	75 19                	jne    801562 <strtol+0xbb>
  801549:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80154d:	0f b6 00             	movzbl (%rax),%eax
  801550:	3c 30                	cmp    $0x30,%al
  801552:	75 0e                	jne    801562 <strtol+0xbb>
  801554:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801559:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801560:	eb 0d                	jmp    80156f <strtol+0xc8>
  801562:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801566:	75 07                	jne    80156f <strtol+0xc8>
  801568:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  80156f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801573:	0f b6 00             	movzbl (%rax),%eax
  801576:	3c 2f                	cmp    $0x2f,%al
  801578:	7e 1d                	jle    801597 <strtol+0xf0>
  80157a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80157e:	0f b6 00             	movzbl (%rax),%eax
  801581:	3c 39                	cmp    $0x39,%al
  801583:	7f 12                	jg     801597 <strtol+0xf0>
  801585:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801589:	0f b6 00             	movzbl (%rax),%eax
  80158c:	0f be c0             	movsbl %al,%eax
  80158f:	83 e8 30             	sub    $0x30,%eax
  801592:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801595:	eb 4e                	jmp    8015e5 <strtol+0x13e>
  801597:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80159b:	0f b6 00             	movzbl (%rax),%eax
  80159e:	3c 60                	cmp    $0x60,%al
  8015a0:	7e 1d                	jle    8015bf <strtol+0x118>
  8015a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015a6:	0f b6 00             	movzbl (%rax),%eax
  8015a9:	3c 7a                	cmp    $0x7a,%al
  8015ab:	7f 12                	jg     8015bf <strtol+0x118>
  8015ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015b1:	0f b6 00             	movzbl (%rax),%eax
  8015b4:	0f be c0             	movsbl %al,%eax
  8015b7:	83 e8 57             	sub    $0x57,%eax
  8015ba:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015bd:	eb 26                	jmp    8015e5 <strtol+0x13e>
  8015bf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015c3:	0f b6 00             	movzbl (%rax),%eax
  8015c6:	3c 40                	cmp    $0x40,%al
  8015c8:	7e 48                	jle    801612 <strtol+0x16b>
  8015ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015ce:	0f b6 00             	movzbl (%rax),%eax
  8015d1:	3c 5a                	cmp    $0x5a,%al
  8015d3:	7f 3d                	jg     801612 <strtol+0x16b>
  8015d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015d9:	0f b6 00             	movzbl (%rax),%eax
  8015dc:	0f be c0             	movsbl %al,%eax
  8015df:	83 e8 37             	sub    $0x37,%eax
  8015e2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8015e8:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  8015eb:	7c 02                	jl     8015ef <strtol+0x148>
  8015ed:	eb 23                	jmp    801612 <strtol+0x16b>
  8015ef:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8015f4:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8015f7:	48 98                	cltq   
  8015f9:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8015fe:	48 89 c2             	mov    %rax,%rdx
  801601:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801604:	48 98                	cltq   
  801606:	48 01 d0             	add    %rdx,%rax
  801609:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80160d:	e9 5d ff ff ff       	jmpq   80156f <strtol+0xc8>
  801612:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801617:	74 0b                	je     801624 <strtol+0x17d>
  801619:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80161d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801621:	48 89 10             	mov    %rdx,(%rax)
  801624:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801628:	74 09                	je     801633 <strtol+0x18c>
  80162a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80162e:	48 f7 d8             	neg    %rax
  801631:	eb 04                	jmp    801637 <strtol+0x190>
  801633:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801637:	c9                   	leaveq 
  801638:	c3                   	retq   

0000000000801639 <strstr>:
  801639:	55                   	push   %rbp
  80163a:	48 89 e5             	mov    %rsp,%rbp
  80163d:	48 83 ec 30          	sub    $0x30,%rsp
  801641:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801645:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801649:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80164d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801651:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801655:	0f b6 00             	movzbl (%rax),%eax
  801658:	88 45 ff             	mov    %al,-0x1(%rbp)
  80165b:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  80165f:	75 06                	jne    801667 <strstr+0x2e>
  801661:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801665:	eb 6b                	jmp    8016d2 <strstr+0x99>
  801667:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80166b:	48 89 c7             	mov    %rax,%rdi
  80166e:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  801675:	00 00 00 
  801678:	ff d0                	callq  *%rax
  80167a:	48 98                	cltq   
  80167c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801680:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801684:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801688:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80168c:	0f b6 00             	movzbl (%rax),%eax
  80168f:	88 45 ef             	mov    %al,-0x11(%rbp)
  801692:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801696:	75 07                	jne    80169f <strstr+0x66>
  801698:	b8 00 00 00 00       	mov    $0x0,%eax
  80169d:	eb 33                	jmp    8016d2 <strstr+0x99>
  80169f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8016a3:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8016a6:	75 d8                	jne    801680 <strstr+0x47>
  8016a8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8016ac:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8016b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016b4:	48 89 ce             	mov    %rcx,%rsi
  8016b7:	48 89 c7             	mov    %rax,%rdi
  8016ba:	48 b8 30 11 80 00 00 	movabs $0x801130,%rax
  8016c1:	00 00 00 
  8016c4:	ff d0                	callq  *%rax
  8016c6:	85 c0                	test   %eax,%eax
  8016c8:	75 b6                	jne    801680 <strstr+0x47>
  8016ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016ce:	48 83 e8 01          	sub    $0x1,%rax
  8016d2:	c9                   	leaveq 
  8016d3:	c3                   	retq   

00000000008016d4 <syscall>:
  8016d4:	55                   	push   %rbp
  8016d5:	48 89 e5             	mov    %rsp,%rbp
  8016d8:	53                   	push   %rbx
  8016d9:	48 83 ec 48          	sub    $0x48,%rsp
  8016dd:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8016e0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8016e3:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8016e7:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  8016eb:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8016ef:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  8016f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8016f6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8016fa:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8016fe:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801702:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801706:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  80170a:	4c 89 c3             	mov    %r8,%rbx
  80170d:	cd 30                	int    $0x30
  80170f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801713:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801717:	74 3e                	je     801757 <syscall+0x83>
  801719:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80171e:	7e 37                	jle    801757 <syscall+0x83>
  801720:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801724:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801727:	49 89 d0             	mov    %rdx,%r8
  80172a:	89 c1                	mov    %eax,%ecx
  80172c:	48 ba e8 50 80 00 00 	movabs $0x8050e8,%rdx
  801733:	00 00 00 
  801736:	be 24 00 00 00       	mov    $0x24,%esi
  80173b:	48 bf 05 51 80 00 00 	movabs $0x805105,%rdi
  801742:	00 00 00 
  801745:	b8 00 00 00 00       	mov    $0x0,%eax
  80174a:	49 b9 8d 01 80 00 00 	movabs $0x80018d,%r9
  801751:	00 00 00 
  801754:	41 ff d1             	callq  *%r9
  801757:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80175b:	48 83 c4 48          	add    $0x48,%rsp
  80175f:	5b                   	pop    %rbx
  801760:	5d                   	pop    %rbp
  801761:	c3                   	retq   

0000000000801762 <sys_cputs>:
  801762:	55                   	push   %rbp
  801763:	48 89 e5             	mov    %rsp,%rbp
  801766:	48 83 ec 20          	sub    $0x20,%rsp
  80176a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80176e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801776:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80177a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801781:	00 
  801782:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801788:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80178e:	48 89 d1             	mov    %rdx,%rcx
  801791:	48 89 c2             	mov    %rax,%rdx
  801794:	be 00 00 00 00       	mov    $0x0,%esi
  801799:	bf 00 00 00 00       	mov    $0x0,%edi
  80179e:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  8017a5:	00 00 00 
  8017a8:	ff d0                	callq  *%rax
  8017aa:	c9                   	leaveq 
  8017ab:	c3                   	retq   

00000000008017ac <sys_cgetc>:
  8017ac:	55                   	push   %rbp
  8017ad:	48 89 e5             	mov    %rsp,%rbp
  8017b0:	48 83 ec 10          	sub    $0x10,%rsp
  8017b4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017bb:	00 
  8017bc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8017c2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017c8:	b9 00 00 00 00       	mov    $0x0,%ecx
  8017cd:	ba 00 00 00 00       	mov    $0x0,%edx
  8017d2:	be 00 00 00 00       	mov    $0x0,%esi
  8017d7:	bf 01 00 00 00       	mov    $0x1,%edi
  8017dc:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  8017e3:	00 00 00 
  8017e6:	ff d0                	callq  *%rax
  8017e8:	c9                   	leaveq 
  8017e9:	c3                   	retq   

00000000008017ea <sys_env_destroy>:
  8017ea:	55                   	push   %rbp
  8017eb:	48 89 e5             	mov    %rsp,%rbp
  8017ee:	48 83 ec 10          	sub    $0x10,%rsp
  8017f2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8017f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8017f8:	48 98                	cltq   
  8017fa:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801801:	00 
  801802:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80180e:	b9 00 00 00 00       	mov    $0x0,%ecx
  801813:	48 89 c2             	mov    %rax,%rdx
  801816:	be 01 00 00 00       	mov    $0x1,%esi
  80181b:	bf 03 00 00 00       	mov    $0x3,%edi
  801820:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801827:	00 00 00 
  80182a:	ff d0                	callq  *%rax
  80182c:	c9                   	leaveq 
  80182d:	c3                   	retq   

000000000080182e <sys_getenvid>:
  80182e:	55                   	push   %rbp
  80182f:	48 89 e5             	mov    %rsp,%rbp
  801832:	48 83 ec 10          	sub    $0x10,%rsp
  801836:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80183d:	00 
  80183e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801844:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80184a:	b9 00 00 00 00       	mov    $0x0,%ecx
  80184f:	ba 00 00 00 00       	mov    $0x0,%edx
  801854:	be 00 00 00 00       	mov    $0x0,%esi
  801859:	bf 02 00 00 00       	mov    $0x2,%edi
  80185e:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801865:	00 00 00 
  801868:	ff d0                	callq  *%rax
  80186a:	c9                   	leaveq 
  80186b:	c3                   	retq   

000000000080186c <sys_yield>:
  80186c:	55                   	push   %rbp
  80186d:	48 89 e5             	mov    %rsp,%rbp
  801870:	48 83 ec 10          	sub    $0x10,%rsp
  801874:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80187b:	00 
  80187c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801882:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801888:	b9 00 00 00 00       	mov    $0x0,%ecx
  80188d:	ba 00 00 00 00       	mov    $0x0,%edx
  801892:	be 00 00 00 00       	mov    $0x0,%esi
  801897:	bf 0b 00 00 00       	mov    $0xb,%edi
  80189c:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  8018a3:	00 00 00 
  8018a6:	ff d0                	callq  *%rax
  8018a8:	c9                   	leaveq 
  8018a9:	c3                   	retq   

00000000008018aa <sys_page_alloc>:
  8018aa:	55                   	push   %rbp
  8018ab:	48 89 e5             	mov    %rsp,%rbp
  8018ae:	48 83 ec 20          	sub    $0x20,%rsp
  8018b2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018b5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018b9:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8018bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8018bf:	48 63 c8             	movslq %eax,%rcx
  8018c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018c9:	48 98                	cltq   
  8018cb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018d2:	00 
  8018d3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018d9:	49 89 c8             	mov    %rcx,%r8
  8018dc:	48 89 d1             	mov    %rdx,%rcx
  8018df:	48 89 c2             	mov    %rax,%rdx
  8018e2:	be 01 00 00 00       	mov    $0x1,%esi
  8018e7:	bf 04 00 00 00       	mov    $0x4,%edi
  8018ec:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  8018f3:	00 00 00 
  8018f6:	ff d0                	callq  *%rax
  8018f8:	c9                   	leaveq 
  8018f9:	c3                   	retq   

00000000008018fa <sys_page_map>:
  8018fa:	55                   	push   %rbp
  8018fb:	48 89 e5             	mov    %rsp,%rbp
  8018fe:	48 83 ec 30          	sub    $0x30,%rsp
  801902:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801905:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801909:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80190c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801910:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801914:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801917:	48 63 c8             	movslq %eax,%rcx
  80191a:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  80191e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801921:	48 63 f0             	movslq %eax,%rsi
  801924:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801928:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80192b:	48 98                	cltq   
  80192d:	48 89 0c 24          	mov    %rcx,(%rsp)
  801931:	49 89 f9             	mov    %rdi,%r9
  801934:	49 89 f0             	mov    %rsi,%r8
  801937:	48 89 d1             	mov    %rdx,%rcx
  80193a:	48 89 c2             	mov    %rax,%rdx
  80193d:	be 01 00 00 00       	mov    $0x1,%esi
  801942:	bf 05 00 00 00       	mov    $0x5,%edi
  801947:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  80194e:	00 00 00 
  801951:	ff d0                	callq  *%rax
  801953:	c9                   	leaveq 
  801954:	c3                   	retq   

0000000000801955 <sys_page_unmap>:
  801955:	55                   	push   %rbp
  801956:	48 89 e5             	mov    %rsp,%rbp
  801959:	48 83 ec 20          	sub    $0x20,%rsp
  80195d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801960:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801964:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801968:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80196b:	48 98                	cltq   
  80196d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801974:	00 
  801975:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80197b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801981:	48 89 d1             	mov    %rdx,%rcx
  801984:	48 89 c2             	mov    %rax,%rdx
  801987:	be 01 00 00 00       	mov    $0x1,%esi
  80198c:	bf 06 00 00 00       	mov    $0x6,%edi
  801991:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801998:	00 00 00 
  80199b:	ff d0                	callq  *%rax
  80199d:	c9                   	leaveq 
  80199e:	c3                   	retq   

000000000080199f <sys_env_set_status>:
  80199f:	55                   	push   %rbp
  8019a0:	48 89 e5             	mov    %rsp,%rbp
  8019a3:	48 83 ec 10          	sub    $0x10,%rsp
  8019a7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019aa:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8019ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8019b0:	48 63 d0             	movslq %eax,%rdx
  8019b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b6:	48 98                	cltq   
  8019b8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019bf:	00 
  8019c0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019c6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019cc:	48 89 d1             	mov    %rdx,%rcx
  8019cf:	48 89 c2             	mov    %rax,%rdx
  8019d2:	be 01 00 00 00       	mov    $0x1,%esi
  8019d7:	bf 08 00 00 00       	mov    $0x8,%edi
  8019dc:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  8019e3:	00 00 00 
  8019e6:	ff d0                	callq  *%rax
  8019e8:	c9                   	leaveq 
  8019e9:	c3                   	retq   

00000000008019ea <sys_env_set_trapframe>:
  8019ea:	55                   	push   %rbp
  8019eb:	48 89 e5             	mov    %rsp,%rbp
  8019ee:	48 83 ec 20          	sub    $0x20,%rsp
  8019f2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019f5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019f9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a00:	48 98                	cltq   
  801a02:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a09:	00 
  801a0a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a10:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a16:	48 89 d1             	mov    %rdx,%rcx
  801a19:	48 89 c2             	mov    %rax,%rdx
  801a1c:	be 01 00 00 00       	mov    $0x1,%esi
  801a21:	bf 09 00 00 00       	mov    $0x9,%edi
  801a26:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801a2d:	00 00 00 
  801a30:	ff d0                	callq  *%rax
  801a32:	c9                   	leaveq 
  801a33:	c3                   	retq   

0000000000801a34 <sys_env_set_pgfault_upcall>:
  801a34:	55                   	push   %rbp
  801a35:	48 89 e5             	mov    %rsp,%rbp
  801a38:	48 83 ec 20          	sub    $0x20,%rsp
  801a3c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a3f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a43:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a47:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a4a:	48 98                	cltq   
  801a4c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a53:	00 
  801a54:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a5a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a60:	48 89 d1             	mov    %rdx,%rcx
  801a63:	48 89 c2             	mov    %rax,%rdx
  801a66:	be 01 00 00 00       	mov    $0x1,%esi
  801a6b:	bf 0a 00 00 00       	mov    $0xa,%edi
  801a70:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801a77:	00 00 00 
  801a7a:	ff d0                	callq  *%rax
  801a7c:	c9                   	leaveq 
  801a7d:	c3                   	retq   

0000000000801a7e <sys_ipc_try_send>:
  801a7e:	55                   	push   %rbp
  801a7f:	48 89 e5             	mov    %rsp,%rbp
  801a82:	48 83 ec 20          	sub    $0x20,%rsp
  801a86:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a89:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a8d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801a91:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801a94:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801a97:	48 63 f0             	movslq %eax,%rsi
  801a9a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801a9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801aa1:	48 98                	cltq   
  801aa3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801aa7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aae:	00 
  801aaf:	49 89 f1             	mov    %rsi,%r9
  801ab2:	49 89 c8             	mov    %rcx,%r8
  801ab5:	48 89 d1             	mov    %rdx,%rcx
  801ab8:	48 89 c2             	mov    %rax,%rdx
  801abb:	be 00 00 00 00       	mov    $0x0,%esi
  801ac0:	bf 0c 00 00 00       	mov    $0xc,%edi
  801ac5:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801acc:	00 00 00 
  801acf:	ff d0                	callq  *%rax
  801ad1:	c9                   	leaveq 
  801ad2:	c3                   	retq   

0000000000801ad3 <sys_ipc_recv>:
  801ad3:	55                   	push   %rbp
  801ad4:	48 89 e5             	mov    %rsp,%rbp
  801ad7:	48 83 ec 10          	sub    $0x10,%rsp
  801adb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ae3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aea:	00 
  801aeb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801af1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801af7:	b9 00 00 00 00       	mov    $0x0,%ecx
  801afc:	48 89 c2             	mov    %rax,%rdx
  801aff:	be 01 00 00 00       	mov    $0x1,%esi
  801b04:	bf 0d 00 00 00       	mov    $0xd,%edi
  801b09:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801b10:	00 00 00 
  801b13:	ff d0                	callq  *%rax
  801b15:	c9                   	leaveq 
  801b16:	c3                   	retq   

0000000000801b17 <sys_time_msec>:
  801b17:	55                   	push   %rbp
  801b18:	48 89 e5             	mov    %rsp,%rbp
  801b1b:	48 83 ec 10          	sub    $0x10,%rsp
  801b1f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b26:	00 
  801b27:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b2d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b33:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b38:	ba 00 00 00 00       	mov    $0x0,%edx
  801b3d:	be 00 00 00 00       	mov    $0x0,%esi
  801b42:	bf 0e 00 00 00       	mov    $0xe,%edi
  801b47:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801b4e:	00 00 00 
  801b51:	ff d0                	callq  *%rax
  801b53:	c9                   	leaveq 
  801b54:	c3                   	retq   

0000000000801b55 <sys_net_transmit>:
  801b55:	55                   	push   %rbp
  801b56:	48 89 e5             	mov    %rsp,%rbp
  801b59:	48 83 ec 20          	sub    $0x20,%rsp
  801b5d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b61:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b64:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b6b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b72:	00 
  801b73:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b79:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b7f:	48 89 d1             	mov    %rdx,%rcx
  801b82:	48 89 c2             	mov    %rax,%rdx
  801b85:	be 00 00 00 00       	mov    $0x0,%esi
  801b8a:	bf 0f 00 00 00       	mov    $0xf,%edi
  801b8f:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801b96:	00 00 00 
  801b99:	ff d0                	callq  *%rax
  801b9b:	c9                   	leaveq 
  801b9c:	c3                   	retq   

0000000000801b9d <sys_net_receive>:
  801b9d:	55                   	push   %rbp
  801b9e:	48 89 e5             	mov    %rsp,%rbp
  801ba1:	48 83 ec 20          	sub    $0x20,%rsp
  801ba5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801ba9:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801bac:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801baf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bb3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bba:	00 
  801bbb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bc1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bc7:	48 89 d1             	mov    %rdx,%rcx
  801bca:	48 89 c2             	mov    %rax,%rdx
  801bcd:	be 00 00 00 00       	mov    $0x0,%esi
  801bd2:	bf 10 00 00 00       	mov    $0x10,%edi
  801bd7:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801bde:	00 00 00 
  801be1:	ff d0                	callq  *%rax
  801be3:	c9                   	leaveq 
  801be4:	c3                   	retq   

0000000000801be5 <sys_ept_map>:
  801be5:	55                   	push   %rbp
  801be6:	48 89 e5             	mov    %rsp,%rbp
  801be9:	48 83 ec 30          	sub    $0x30,%rsp
  801bed:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bf0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bf4:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801bf7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801bfb:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801bff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801c02:	48 63 c8             	movslq %eax,%rcx
  801c05:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801c09:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c0c:	48 63 f0             	movslq %eax,%rsi
  801c0f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c16:	48 98                	cltq   
  801c18:	48 89 0c 24          	mov    %rcx,(%rsp)
  801c1c:	49 89 f9             	mov    %rdi,%r9
  801c1f:	49 89 f0             	mov    %rsi,%r8
  801c22:	48 89 d1             	mov    %rdx,%rcx
  801c25:	48 89 c2             	mov    %rax,%rdx
  801c28:	be 00 00 00 00       	mov    $0x0,%esi
  801c2d:	bf 11 00 00 00       	mov    $0x11,%edi
  801c32:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801c39:	00 00 00 
  801c3c:	ff d0                	callq  *%rax
  801c3e:	c9                   	leaveq 
  801c3f:	c3                   	retq   

0000000000801c40 <sys_env_mkguest>:
  801c40:	55                   	push   %rbp
  801c41:	48 89 e5             	mov    %rsp,%rbp
  801c44:	48 83 ec 20          	sub    $0x20,%rsp
  801c48:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c4c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c58:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c5f:	00 
  801c60:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c66:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c6c:	48 89 d1             	mov    %rdx,%rcx
  801c6f:	48 89 c2             	mov    %rax,%rdx
  801c72:	be 00 00 00 00       	mov    $0x0,%esi
  801c77:	bf 12 00 00 00       	mov    $0x12,%edi
  801c7c:	48 b8 d4 16 80 00 00 	movabs $0x8016d4,%rax
  801c83:	00 00 00 
  801c86:	ff d0                	callq  *%rax
  801c88:	c9                   	leaveq 
  801c89:	c3                   	retq   

0000000000801c8a <fd2num>:
  801c8a:	55                   	push   %rbp
  801c8b:	48 89 e5             	mov    %rsp,%rbp
  801c8e:	48 83 ec 08          	sub    $0x8,%rsp
  801c92:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c96:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801c9a:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801ca1:	ff ff ff 
  801ca4:	48 01 d0             	add    %rdx,%rax
  801ca7:	48 c1 e8 0c          	shr    $0xc,%rax
  801cab:	c9                   	leaveq 
  801cac:	c3                   	retq   

0000000000801cad <fd2data>:
  801cad:	55                   	push   %rbp
  801cae:	48 89 e5             	mov    %rsp,%rbp
  801cb1:	48 83 ec 08          	sub    $0x8,%rsp
  801cb5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801cb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cbd:	48 89 c7             	mov    %rax,%rdi
  801cc0:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  801cc7:	00 00 00 
  801cca:	ff d0                	callq  *%rax
  801ccc:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801cd2:	48 c1 e0 0c          	shl    $0xc,%rax
  801cd6:	c9                   	leaveq 
  801cd7:	c3                   	retq   

0000000000801cd8 <fd_alloc>:
  801cd8:	55                   	push   %rbp
  801cd9:	48 89 e5             	mov    %rsp,%rbp
  801cdc:	48 83 ec 18          	sub    $0x18,%rsp
  801ce0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801ce4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ceb:	eb 6b                	jmp    801d58 <fd_alloc+0x80>
  801ced:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cf0:	48 98                	cltq   
  801cf2:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801cf8:	48 c1 e0 0c          	shl    $0xc,%rax
  801cfc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d04:	48 c1 e8 15          	shr    $0x15,%rax
  801d08:	48 89 c2             	mov    %rax,%rdx
  801d0b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801d12:	01 00 00 
  801d15:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801d19:	83 e0 01             	and    $0x1,%eax
  801d1c:	48 85 c0             	test   %rax,%rax
  801d1f:	74 21                	je     801d42 <fd_alloc+0x6a>
  801d21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d25:	48 c1 e8 0c          	shr    $0xc,%rax
  801d29:	48 89 c2             	mov    %rax,%rdx
  801d2c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801d33:	01 00 00 
  801d36:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801d3a:	83 e0 01             	and    $0x1,%eax
  801d3d:	48 85 c0             	test   %rax,%rax
  801d40:	75 12                	jne    801d54 <fd_alloc+0x7c>
  801d42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d46:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d4a:	48 89 10             	mov    %rdx,(%rax)
  801d4d:	b8 00 00 00 00       	mov    $0x0,%eax
  801d52:	eb 1a                	jmp    801d6e <fd_alloc+0x96>
  801d54:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801d58:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801d5c:	7e 8f                	jle    801ced <fd_alloc+0x15>
  801d5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d62:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801d69:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801d6e:	c9                   	leaveq 
  801d6f:	c3                   	retq   

0000000000801d70 <fd_lookup>:
  801d70:	55                   	push   %rbp
  801d71:	48 89 e5             	mov    %rsp,%rbp
  801d74:	48 83 ec 20          	sub    $0x20,%rsp
  801d78:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801d7b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801d7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801d83:	78 06                	js     801d8b <fd_lookup+0x1b>
  801d85:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801d89:	7e 07                	jle    801d92 <fd_lookup+0x22>
  801d8b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801d90:	eb 6c                	jmp    801dfe <fd_lookup+0x8e>
  801d92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801d95:	48 98                	cltq   
  801d97:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801d9d:	48 c1 e0 0c          	shl    $0xc,%rax
  801da1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801da9:	48 c1 e8 15          	shr    $0x15,%rax
  801dad:	48 89 c2             	mov    %rax,%rdx
  801db0:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801db7:	01 00 00 
  801dba:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801dbe:	83 e0 01             	and    $0x1,%eax
  801dc1:	48 85 c0             	test   %rax,%rax
  801dc4:	74 21                	je     801de7 <fd_lookup+0x77>
  801dc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dca:	48 c1 e8 0c          	shr    $0xc,%rax
  801dce:	48 89 c2             	mov    %rax,%rdx
  801dd1:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801dd8:	01 00 00 
  801ddb:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801ddf:	83 e0 01             	and    $0x1,%eax
  801de2:	48 85 c0             	test   %rax,%rax
  801de5:	75 07                	jne    801dee <fd_lookup+0x7e>
  801de7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801dec:	eb 10                	jmp    801dfe <fd_lookup+0x8e>
  801dee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801df2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801df6:	48 89 10             	mov    %rdx,(%rax)
  801df9:	b8 00 00 00 00       	mov    $0x0,%eax
  801dfe:	c9                   	leaveq 
  801dff:	c3                   	retq   

0000000000801e00 <fd_close>:
  801e00:	55                   	push   %rbp
  801e01:	48 89 e5             	mov    %rsp,%rbp
  801e04:	48 83 ec 30          	sub    $0x30,%rsp
  801e08:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801e0c:	89 f0                	mov    %esi,%eax
  801e0e:	88 45 d4             	mov    %al,-0x2c(%rbp)
  801e11:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e15:	48 89 c7             	mov    %rax,%rdi
  801e18:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  801e1f:	00 00 00 
  801e22:	ff d0                	callq  *%rax
  801e24:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801e28:	48 89 d6             	mov    %rdx,%rsi
  801e2b:	89 c7                	mov    %eax,%edi
  801e2d:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  801e34:	00 00 00 
  801e37:	ff d0                	callq  *%rax
  801e39:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801e3c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801e40:	78 0a                	js     801e4c <fd_close+0x4c>
  801e42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e46:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801e4a:	74 12                	je     801e5e <fd_close+0x5e>
  801e4c:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801e50:	74 05                	je     801e57 <fd_close+0x57>
  801e52:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e55:	eb 05                	jmp    801e5c <fd_close+0x5c>
  801e57:	b8 00 00 00 00       	mov    $0x0,%eax
  801e5c:	eb 69                	jmp    801ec7 <fd_close+0xc7>
  801e5e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e62:	8b 00                	mov    (%rax),%eax
  801e64:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801e68:	48 89 d6             	mov    %rdx,%rsi
  801e6b:	89 c7                	mov    %eax,%edi
  801e6d:	48 b8 c9 1e 80 00 00 	movabs $0x801ec9,%rax
  801e74:	00 00 00 
  801e77:	ff d0                	callq  *%rax
  801e79:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801e7c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801e80:	78 2a                	js     801eac <fd_close+0xac>
  801e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e86:	48 8b 40 20          	mov    0x20(%rax),%rax
  801e8a:	48 85 c0             	test   %rax,%rax
  801e8d:	74 16                	je     801ea5 <fd_close+0xa5>
  801e8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e93:	48 8b 40 20          	mov    0x20(%rax),%rax
  801e97:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801e9b:	48 89 d7             	mov    %rdx,%rdi
  801e9e:	ff d0                	callq  *%rax
  801ea0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ea3:	eb 07                	jmp    801eac <fd_close+0xac>
  801ea5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801eac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801eb0:	48 89 c6             	mov    %rax,%rsi
  801eb3:	bf 00 00 00 00       	mov    $0x0,%edi
  801eb8:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  801ebf:	00 00 00 
  801ec2:	ff d0                	callq  *%rax
  801ec4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ec7:	c9                   	leaveq 
  801ec8:	c3                   	retq   

0000000000801ec9 <dev_lookup>:
  801ec9:	55                   	push   %rbp
  801eca:	48 89 e5             	mov    %rsp,%rbp
  801ecd:	48 83 ec 20          	sub    $0x20,%rsp
  801ed1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801ed4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801edf:	eb 41                	jmp    801f22 <dev_lookup+0x59>
  801ee1:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  801ee8:	00 00 00 
  801eeb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801eee:	48 63 d2             	movslq %edx,%rdx
  801ef1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801ef5:	8b 00                	mov    (%rax),%eax
  801ef7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  801efa:	75 22                	jne    801f1e <dev_lookup+0x55>
  801efc:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  801f03:	00 00 00 
  801f06:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f09:	48 63 d2             	movslq %edx,%rdx
  801f0c:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801f10:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f14:	48 89 10             	mov    %rdx,(%rax)
  801f17:	b8 00 00 00 00       	mov    $0x0,%eax
  801f1c:	eb 60                	jmp    801f7e <dev_lookup+0xb5>
  801f1e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801f22:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  801f29:	00 00 00 
  801f2c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f2f:	48 63 d2             	movslq %edx,%rdx
  801f32:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f36:	48 85 c0             	test   %rax,%rax
  801f39:	75 a6                	jne    801ee1 <dev_lookup+0x18>
  801f3b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  801f42:	00 00 00 
  801f45:	48 8b 00             	mov    (%rax),%rax
  801f48:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801f4e:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801f51:	89 c6                	mov    %eax,%esi
  801f53:	48 bf 18 51 80 00 00 	movabs $0x805118,%rdi
  801f5a:	00 00 00 
  801f5d:	b8 00 00 00 00       	mov    $0x0,%eax
  801f62:	48 b9 c6 03 80 00 00 	movabs $0x8003c6,%rcx
  801f69:	00 00 00 
  801f6c:	ff d1                	callq  *%rcx
  801f6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f72:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801f79:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f7e:	c9                   	leaveq 
  801f7f:	c3                   	retq   

0000000000801f80 <close>:
  801f80:	55                   	push   %rbp
  801f81:	48 89 e5             	mov    %rsp,%rbp
  801f84:	48 83 ec 20          	sub    $0x20,%rsp
  801f88:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801f8b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801f8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f92:	48 89 d6             	mov    %rdx,%rsi
  801f95:	89 c7                	mov    %eax,%edi
  801f97:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  801f9e:	00 00 00 
  801fa1:	ff d0                	callq  *%rax
  801fa3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fa6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801faa:	79 05                	jns    801fb1 <close+0x31>
  801fac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801faf:	eb 18                	jmp    801fc9 <close+0x49>
  801fb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fb5:	be 01 00 00 00       	mov    $0x1,%esi
  801fba:	48 89 c7             	mov    %rax,%rdi
  801fbd:	48 b8 00 1e 80 00 00 	movabs $0x801e00,%rax
  801fc4:	00 00 00 
  801fc7:	ff d0                	callq  *%rax
  801fc9:	c9                   	leaveq 
  801fca:	c3                   	retq   

0000000000801fcb <close_all>:
  801fcb:	55                   	push   %rbp
  801fcc:	48 89 e5             	mov    %rsp,%rbp
  801fcf:	48 83 ec 10          	sub    $0x10,%rsp
  801fd3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801fda:	eb 15                	jmp    801ff1 <close_all+0x26>
  801fdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fdf:	89 c7                	mov    %eax,%edi
  801fe1:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  801fe8:	00 00 00 
  801feb:	ff d0                	callq  *%rax
  801fed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801ff1:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801ff5:	7e e5                	jle    801fdc <close_all+0x11>
  801ff7:	c9                   	leaveq 
  801ff8:	c3                   	retq   

0000000000801ff9 <dup>:
  801ff9:	55                   	push   %rbp
  801ffa:	48 89 e5             	mov    %rsp,%rbp
  801ffd:	48 83 ec 40          	sub    $0x40,%rsp
  802001:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802004:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802007:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80200b:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80200e:	48 89 d6             	mov    %rdx,%rsi
  802011:	89 c7                	mov    %eax,%edi
  802013:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  80201a:	00 00 00 
  80201d:	ff d0                	callq  *%rax
  80201f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802022:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802026:	79 08                	jns    802030 <dup+0x37>
  802028:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80202b:	e9 70 01 00 00       	jmpq   8021a0 <dup+0x1a7>
  802030:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802033:	89 c7                	mov    %eax,%edi
  802035:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  80203c:	00 00 00 
  80203f:	ff d0                	callq  *%rax
  802041:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802044:	48 98                	cltq   
  802046:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80204c:	48 c1 e0 0c          	shl    $0xc,%rax
  802050:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802054:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802058:	48 89 c7             	mov    %rax,%rdi
  80205b:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  802062:	00 00 00 
  802065:	ff d0                	callq  *%rax
  802067:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80206b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80206f:	48 89 c7             	mov    %rax,%rdi
  802072:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  802079:	00 00 00 
  80207c:	ff d0                	callq  *%rax
  80207e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802082:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802086:	48 c1 e8 15          	shr    $0x15,%rax
  80208a:	48 89 c2             	mov    %rax,%rdx
  80208d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802094:	01 00 00 
  802097:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80209b:	83 e0 01             	and    $0x1,%eax
  80209e:	48 85 c0             	test   %rax,%rax
  8020a1:	74 73                	je     802116 <dup+0x11d>
  8020a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020a7:	48 c1 e8 0c          	shr    $0xc,%rax
  8020ab:	48 89 c2             	mov    %rax,%rdx
  8020ae:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8020b5:	01 00 00 
  8020b8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020bc:	83 e0 01             	and    $0x1,%eax
  8020bf:	48 85 c0             	test   %rax,%rax
  8020c2:	74 52                	je     802116 <dup+0x11d>
  8020c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020c8:	48 c1 e8 0c          	shr    $0xc,%rax
  8020cc:	48 89 c2             	mov    %rax,%rdx
  8020cf:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8020d6:	01 00 00 
  8020d9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020dd:	25 07 0e 00 00       	and    $0xe07,%eax
  8020e2:	89 c1                	mov    %eax,%ecx
  8020e4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8020e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020ec:	41 89 c8             	mov    %ecx,%r8d
  8020ef:	48 89 d1             	mov    %rdx,%rcx
  8020f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8020f7:	48 89 c6             	mov    %rax,%rsi
  8020fa:	bf 00 00 00 00       	mov    $0x0,%edi
  8020ff:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  802106:	00 00 00 
  802109:	ff d0                	callq  *%rax
  80210b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80210e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802112:	79 02                	jns    802116 <dup+0x11d>
  802114:	eb 57                	jmp    80216d <dup+0x174>
  802116:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80211a:	48 c1 e8 0c          	shr    $0xc,%rax
  80211e:	48 89 c2             	mov    %rax,%rdx
  802121:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802128:	01 00 00 
  80212b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80212f:	25 07 0e 00 00       	and    $0xe07,%eax
  802134:	89 c1                	mov    %eax,%ecx
  802136:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80213a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80213e:	41 89 c8             	mov    %ecx,%r8d
  802141:	48 89 d1             	mov    %rdx,%rcx
  802144:	ba 00 00 00 00       	mov    $0x0,%edx
  802149:	48 89 c6             	mov    %rax,%rsi
  80214c:	bf 00 00 00 00       	mov    $0x0,%edi
  802151:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  802158:	00 00 00 
  80215b:	ff d0                	callq  *%rax
  80215d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802160:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802164:	79 02                	jns    802168 <dup+0x16f>
  802166:	eb 05                	jmp    80216d <dup+0x174>
  802168:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80216b:	eb 33                	jmp    8021a0 <dup+0x1a7>
  80216d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802171:	48 89 c6             	mov    %rax,%rsi
  802174:	bf 00 00 00 00       	mov    $0x0,%edi
  802179:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  802180:	00 00 00 
  802183:	ff d0                	callq  *%rax
  802185:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802189:	48 89 c6             	mov    %rax,%rsi
  80218c:	bf 00 00 00 00       	mov    $0x0,%edi
  802191:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  802198:	00 00 00 
  80219b:	ff d0                	callq  *%rax
  80219d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021a0:	c9                   	leaveq 
  8021a1:	c3                   	retq   

00000000008021a2 <read>:
  8021a2:	55                   	push   %rbp
  8021a3:	48 89 e5             	mov    %rsp,%rbp
  8021a6:	48 83 ec 40          	sub    $0x40,%rsp
  8021aa:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8021ad:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8021b1:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8021b5:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8021b9:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8021bc:	48 89 d6             	mov    %rdx,%rsi
  8021bf:	89 c7                	mov    %eax,%edi
  8021c1:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  8021c8:	00 00 00 
  8021cb:	ff d0                	callq  *%rax
  8021cd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021d4:	78 24                	js     8021fa <read+0x58>
  8021d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021da:	8b 00                	mov    (%rax),%eax
  8021dc:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8021e0:	48 89 d6             	mov    %rdx,%rsi
  8021e3:	89 c7                	mov    %eax,%edi
  8021e5:	48 b8 c9 1e 80 00 00 	movabs $0x801ec9,%rax
  8021ec:	00 00 00 
  8021ef:	ff d0                	callq  *%rax
  8021f1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021f8:	79 05                	jns    8021ff <read+0x5d>
  8021fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021fd:	eb 76                	jmp    802275 <read+0xd3>
  8021ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802203:	8b 40 08             	mov    0x8(%rax),%eax
  802206:	83 e0 03             	and    $0x3,%eax
  802209:	83 f8 01             	cmp    $0x1,%eax
  80220c:	75 3a                	jne    802248 <read+0xa6>
  80220e:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802215:	00 00 00 
  802218:	48 8b 00             	mov    (%rax),%rax
  80221b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802221:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802224:	89 c6                	mov    %eax,%esi
  802226:	48 bf 37 51 80 00 00 	movabs $0x805137,%rdi
  80222d:	00 00 00 
  802230:	b8 00 00 00 00       	mov    $0x0,%eax
  802235:	48 b9 c6 03 80 00 00 	movabs $0x8003c6,%rcx
  80223c:	00 00 00 
  80223f:	ff d1                	callq  *%rcx
  802241:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802246:	eb 2d                	jmp    802275 <read+0xd3>
  802248:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80224c:	48 8b 40 10          	mov    0x10(%rax),%rax
  802250:	48 85 c0             	test   %rax,%rax
  802253:	75 07                	jne    80225c <read+0xba>
  802255:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80225a:	eb 19                	jmp    802275 <read+0xd3>
  80225c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802260:	48 8b 40 10          	mov    0x10(%rax),%rax
  802264:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802268:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80226c:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802270:	48 89 cf             	mov    %rcx,%rdi
  802273:	ff d0                	callq  *%rax
  802275:	c9                   	leaveq 
  802276:	c3                   	retq   

0000000000802277 <readn>:
  802277:	55                   	push   %rbp
  802278:	48 89 e5             	mov    %rsp,%rbp
  80227b:	48 83 ec 30          	sub    $0x30,%rsp
  80227f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802282:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802286:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80228a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802291:	eb 49                	jmp    8022dc <readn+0x65>
  802293:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802296:	48 98                	cltq   
  802298:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80229c:	48 29 c2             	sub    %rax,%rdx
  80229f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022a2:	48 63 c8             	movslq %eax,%rcx
  8022a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022a9:	48 01 c1             	add    %rax,%rcx
  8022ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022af:	48 89 ce             	mov    %rcx,%rsi
  8022b2:	89 c7                	mov    %eax,%edi
  8022b4:	48 b8 a2 21 80 00 00 	movabs $0x8021a2,%rax
  8022bb:	00 00 00 
  8022be:	ff d0                	callq  *%rax
  8022c0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022c3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022c7:	79 05                	jns    8022ce <readn+0x57>
  8022c9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022cc:	eb 1c                	jmp    8022ea <readn+0x73>
  8022ce:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022d2:	75 02                	jne    8022d6 <readn+0x5f>
  8022d4:	eb 11                	jmp    8022e7 <readn+0x70>
  8022d6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022d9:	01 45 fc             	add    %eax,-0x4(%rbp)
  8022dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022df:	48 98                	cltq   
  8022e1:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8022e5:	72 ac                	jb     802293 <readn+0x1c>
  8022e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022ea:	c9                   	leaveq 
  8022eb:	c3                   	retq   

00000000008022ec <write>:
  8022ec:	55                   	push   %rbp
  8022ed:	48 89 e5             	mov    %rsp,%rbp
  8022f0:	48 83 ec 40          	sub    $0x40,%rsp
  8022f4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8022f7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8022fb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8022ff:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802303:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802306:	48 89 d6             	mov    %rdx,%rsi
  802309:	89 c7                	mov    %eax,%edi
  80230b:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  802312:	00 00 00 
  802315:	ff d0                	callq  *%rax
  802317:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80231a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80231e:	78 24                	js     802344 <write+0x58>
  802320:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802324:	8b 00                	mov    (%rax),%eax
  802326:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80232a:	48 89 d6             	mov    %rdx,%rsi
  80232d:	89 c7                	mov    %eax,%edi
  80232f:	48 b8 c9 1e 80 00 00 	movabs $0x801ec9,%rax
  802336:	00 00 00 
  802339:	ff d0                	callq  *%rax
  80233b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80233e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802342:	79 05                	jns    802349 <write+0x5d>
  802344:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802347:	eb 75                	jmp    8023be <write+0xd2>
  802349:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80234d:	8b 40 08             	mov    0x8(%rax),%eax
  802350:	83 e0 03             	and    $0x3,%eax
  802353:	85 c0                	test   %eax,%eax
  802355:	75 3a                	jne    802391 <write+0xa5>
  802357:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80235e:	00 00 00 
  802361:	48 8b 00             	mov    (%rax),%rax
  802364:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80236a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80236d:	89 c6                	mov    %eax,%esi
  80236f:	48 bf 53 51 80 00 00 	movabs $0x805153,%rdi
  802376:	00 00 00 
  802379:	b8 00 00 00 00       	mov    $0x0,%eax
  80237e:	48 b9 c6 03 80 00 00 	movabs $0x8003c6,%rcx
  802385:	00 00 00 
  802388:	ff d1                	callq  *%rcx
  80238a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80238f:	eb 2d                	jmp    8023be <write+0xd2>
  802391:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802395:	48 8b 40 18          	mov    0x18(%rax),%rax
  802399:	48 85 c0             	test   %rax,%rax
  80239c:	75 07                	jne    8023a5 <write+0xb9>
  80239e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8023a3:	eb 19                	jmp    8023be <write+0xd2>
  8023a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023a9:	48 8b 40 18          	mov    0x18(%rax),%rax
  8023ad:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8023b1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8023b5:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8023b9:	48 89 cf             	mov    %rcx,%rdi
  8023bc:	ff d0                	callq  *%rax
  8023be:	c9                   	leaveq 
  8023bf:	c3                   	retq   

00000000008023c0 <seek>:
  8023c0:	55                   	push   %rbp
  8023c1:	48 89 e5             	mov    %rsp,%rbp
  8023c4:	48 83 ec 18          	sub    $0x18,%rsp
  8023c8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023cb:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8023ce:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8023d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8023d5:	48 89 d6             	mov    %rdx,%rsi
  8023d8:	89 c7                	mov    %eax,%edi
  8023da:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  8023e1:	00 00 00 
  8023e4:	ff d0                	callq  *%rax
  8023e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8023e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8023ed:	79 05                	jns    8023f4 <seek+0x34>
  8023ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023f2:	eb 0f                	jmp    802403 <seek+0x43>
  8023f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023f8:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8023fb:	89 50 04             	mov    %edx,0x4(%rax)
  8023fe:	b8 00 00 00 00       	mov    $0x0,%eax
  802403:	c9                   	leaveq 
  802404:	c3                   	retq   

0000000000802405 <ftruncate>:
  802405:	55                   	push   %rbp
  802406:	48 89 e5             	mov    %rsp,%rbp
  802409:	48 83 ec 30          	sub    $0x30,%rsp
  80240d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802410:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802413:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802417:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80241a:	48 89 d6             	mov    %rdx,%rsi
  80241d:	89 c7                	mov    %eax,%edi
  80241f:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  802426:	00 00 00 
  802429:	ff d0                	callq  *%rax
  80242b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80242e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802432:	78 24                	js     802458 <ftruncate+0x53>
  802434:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802438:	8b 00                	mov    (%rax),%eax
  80243a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80243e:	48 89 d6             	mov    %rdx,%rsi
  802441:	89 c7                	mov    %eax,%edi
  802443:	48 b8 c9 1e 80 00 00 	movabs $0x801ec9,%rax
  80244a:	00 00 00 
  80244d:	ff d0                	callq  *%rax
  80244f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802452:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802456:	79 05                	jns    80245d <ftruncate+0x58>
  802458:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80245b:	eb 72                	jmp    8024cf <ftruncate+0xca>
  80245d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802461:	8b 40 08             	mov    0x8(%rax),%eax
  802464:	83 e0 03             	and    $0x3,%eax
  802467:	85 c0                	test   %eax,%eax
  802469:	75 3a                	jne    8024a5 <ftruncate+0xa0>
  80246b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802472:	00 00 00 
  802475:	48 8b 00             	mov    (%rax),%rax
  802478:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80247e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802481:	89 c6                	mov    %eax,%esi
  802483:	48 bf 70 51 80 00 00 	movabs $0x805170,%rdi
  80248a:	00 00 00 
  80248d:	b8 00 00 00 00       	mov    $0x0,%eax
  802492:	48 b9 c6 03 80 00 00 	movabs $0x8003c6,%rcx
  802499:	00 00 00 
  80249c:	ff d1                	callq  *%rcx
  80249e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024a3:	eb 2a                	jmp    8024cf <ftruncate+0xca>
  8024a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024a9:	48 8b 40 30          	mov    0x30(%rax),%rax
  8024ad:	48 85 c0             	test   %rax,%rax
  8024b0:	75 07                	jne    8024b9 <ftruncate+0xb4>
  8024b2:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8024b7:	eb 16                	jmp    8024cf <ftruncate+0xca>
  8024b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024bd:	48 8b 40 30          	mov    0x30(%rax),%rax
  8024c1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8024c5:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8024c8:	89 ce                	mov    %ecx,%esi
  8024ca:	48 89 d7             	mov    %rdx,%rdi
  8024cd:	ff d0                	callq  *%rax
  8024cf:	c9                   	leaveq 
  8024d0:	c3                   	retq   

00000000008024d1 <fstat>:
  8024d1:	55                   	push   %rbp
  8024d2:	48 89 e5             	mov    %rsp,%rbp
  8024d5:	48 83 ec 30          	sub    $0x30,%rsp
  8024d9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8024dc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8024e0:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8024e4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8024e7:	48 89 d6             	mov    %rdx,%rsi
  8024ea:	89 c7                	mov    %eax,%edi
  8024ec:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  8024f3:	00 00 00 
  8024f6:	ff d0                	callq  *%rax
  8024f8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8024fb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8024ff:	78 24                	js     802525 <fstat+0x54>
  802501:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802505:	8b 00                	mov    (%rax),%eax
  802507:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80250b:	48 89 d6             	mov    %rdx,%rsi
  80250e:	89 c7                	mov    %eax,%edi
  802510:	48 b8 c9 1e 80 00 00 	movabs $0x801ec9,%rax
  802517:	00 00 00 
  80251a:	ff d0                	callq  *%rax
  80251c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80251f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802523:	79 05                	jns    80252a <fstat+0x59>
  802525:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802528:	eb 5e                	jmp    802588 <fstat+0xb7>
  80252a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80252e:	48 8b 40 28          	mov    0x28(%rax),%rax
  802532:	48 85 c0             	test   %rax,%rax
  802535:	75 07                	jne    80253e <fstat+0x6d>
  802537:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80253c:	eb 4a                	jmp    802588 <fstat+0xb7>
  80253e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802542:	c6 00 00             	movb   $0x0,(%rax)
  802545:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802549:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802550:	00 00 00 
  802553:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802557:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80255e:	00 00 00 
  802561:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802565:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802569:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802570:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802574:	48 8b 40 28          	mov    0x28(%rax),%rax
  802578:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80257c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802580:	48 89 ce             	mov    %rcx,%rsi
  802583:	48 89 d7             	mov    %rdx,%rdi
  802586:	ff d0                	callq  *%rax
  802588:	c9                   	leaveq 
  802589:	c3                   	retq   

000000000080258a <stat>:
  80258a:	55                   	push   %rbp
  80258b:	48 89 e5             	mov    %rsp,%rbp
  80258e:	48 83 ec 20          	sub    $0x20,%rsp
  802592:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802596:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80259a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80259e:	be 00 00 00 00       	mov    $0x0,%esi
  8025a3:	48 89 c7             	mov    %rax,%rdi
  8025a6:	48 b8 78 26 80 00 00 	movabs $0x802678,%rax
  8025ad:	00 00 00 
  8025b0:	ff d0                	callq  *%rax
  8025b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025b9:	79 05                	jns    8025c0 <stat+0x36>
  8025bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025be:	eb 2f                	jmp    8025ef <stat+0x65>
  8025c0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8025c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025c7:	48 89 d6             	mov    %rdx,%rsi
  8025ca:	89 c7                	mov    %eax,%edi
  8025cc:	48 b8 d1 24 80 00 00 	movabs $0x8024d1,%rax
  8025d3:	00 00 00 
  8025d6:	ff d0                	callq  *%rax
  8025d8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8025db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025de:	89 c7                	mov    %eax,%edi
  8025e0:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  8025e7:	00 00 00 
  8025ea:	ff d0                	callq  *%rax
  8025ec:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8025ef:	c9                   	leaveq 
  8025f0:	c3                   	retq   

00000000008025f1 <fsipc>:
  8025f1:	55                   	push   %rbp
  8025f2:	48 89 e5             	mov    %rsp,%rbp
  8025f5:	48 83 ec 10          	sub    $0x10,%rsp
  8025f9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8025fc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802600:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802607:	00 00 00 
  80260a:	8b 00                	mov    (%rax),%eax
  80260c:	85 c0                	test   %eax,%eax
  80260e:	75 1d                	jne    80262d <fsipc+0x3c>
  802610:	bf 01 00 00 00       	mov    $0x1,%edi
  802615:	48 b8 73 4a 80 00 00 	movabs $0x804a73,%rax
  80261c:	00 00 00 
  80261f:	ff d0                	callq  *%rax
  802621:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802628:	00 00 00 
  80262b:	89 02                	mov    %eax,(%rdx)
  80262d:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802634:	00 00 00 
  802637:	8b 00                	mov    (%rax),%eax
  802639:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80263c:	b9 07 00 00 00       	mov    $0x7,%ecx
  802641:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802648:	00 00 00 
  80264b:	89 c7                	mov    %eax,%edi
  80264d:	48 b8 68 49 80 00 00 	movabs $0x804968,%rax
  802654:	00 00 00 
  802657:	ff d0                	callq  *%rax
  802659:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80265d:	ba 00 00 00 00       	mov    $0x0,%edx
  802662:	48 89 c6             	mov    %rax,%rsi
  802665:	bf 00 00 00 00       	mov    $0x0,%edi
  80266a:	48 b8 a7 48 80 00 00 	movabs $0x8048a7,%rax
  802671:	00 00 00 
  802674:	ff d0                	callq  *%rax
  802676:	c9                   	leaveq 
  802677:	c3                   	retq   

0000000000802678 <open>:
  802678:	55                   	push   %rbp
  802679:	48 89 e5             	mov    %rsp,%rbp
  80267c:	48 83 ec 20          	sub    $0x20,%rsp
  802680:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802684:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80268b:	48 89 c7             	mov    %rax,%rdi
  80268e:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  802695:	00 00 00 
  802698:	ff d0                	callq  *%rax
  80269a:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  80269f:	7e 0a                	jle    8026ab <open+0x33>
  8026a1:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8026a6:	e9 a5 00 00 00       	jmpq   802750 <open+0xd8>
  8026ab:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8026af:	48 89 c7             	mov    %rax,%rdi
  8026b2:	48 b8 d8 1c 80 00 00 	movabs $0x801cd8,%rax
  8026b9:	00 00 00 
  8026bc:	ff d0                	callq  *%rax
  8026be:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026c5:	79 08                	jns    8026cf <open+0x57>
  8026c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026ca:	e9 81 00 00 00       	jmpq   802750 <open+0xd8>
  8026cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026d3:	48 89 c6             	mov    %rax,%rsi
  8026d6:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8026dd:	00 00 00 
  8026e0:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  8026e7:	00 00 00 
  8026ea:	ff d0                	callq  *%rax
  8026ec:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8026f3:	00 00 00 
  8026f6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8026f9:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8026ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802703:	48 89 c6             	mov    %rax,%rsi
  802706:	bf 01 00 00 00       	mov    $0x1,%edi
  80270b:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  802712:	00 00 00 
  802715:	ff d0                	callq  *%rax
  802717:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80271a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80271e:	79 1d                	jns    80273d <open+0xc5>
  802720:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802724:	be 00 00 00 00       	mov    $0x0,%esi
  802729:	48 89 c7             	mov    %rax,%rdi
  80272c:	48 b8 00 1e 80 00 00 	movabs $0x801e00,%rax
  802733:	00 00 00 
  802736:	ff d0                	callq  *%rax
  802738:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80273b:	eb 13                	jmp    802750 <open+0xd8>
  80273d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802741:	48 89 c7             	mov    %rax,%rdi
  802744:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  80274b:	00 00 00 
  80274e:	ff d0                	callq  *%rax
  802750:	c9                   	leaveq 
  802751:	c3                   	retq   

0000000000802752 <devfile_flush>:
  802752:	55                   	push   %rbp
  802753:	48 89 e5             	mov    %rsp,%rbp
  802756:	48 83 ec 10          	sub    $0x10,%rsp
  80275a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80275e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802762:	8b 50 0c             	mov    0xc(%rax),%edx
  802765:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80276c:	00 00 00 
  80276f:	89 10                	mov    %edx,(%rax)
  802771:	be 00 00 00 00       	mov    $0x0,%esi
  802776:	bf 06 00 00 00       	mov    $0x6,%edi
  80277b:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  802782:	00 00 00 
  802785:	ff d0                	callq  *%rax
  802787:	c9                   	leaveq 
  802788:	c3                   	retq   

0000000000802789 <devfile_read>:
  802789:	55                   	push   %rbp
  80278a:	48 89 e5             	mov    %rsp,%rbp
  80278d:	48 83 ec 30          	sub    $0x30,%rsp
  802791:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802795:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802799:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80279d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027a1:	8b 50 0c             	mov    0xc(%rax),%edx
  8027a4:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8027ab:	00 00 00 
  8027ae:	89 10                	mov    %edx,(%rax)
  8027b0:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8027b7:	00 00 00 
  8027ba:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8027be:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8027c2:	be 00 00 00 00       	mov    $0x0,%esi
  8027c7:	bf 03 00 00 00       	mov    $0x3,%edi
  8027cc:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  8027d3:	00 00 00 
  8027d6:	ff d0                	callq  *%rax
  8027d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027df:	79 08                	jns    8027e9 <devfile_read+0x60>
  8027e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027e4:	e9 a4 00 00 00       	jmpq   80288d <devfile_read+0x104>
  8027e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027ec:	48 98                	cltq   
  8027ee:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8027f2:	76 35                	jbe    802829 <devfile_read+0xa0>
  8027f4:	48 b9 96 51 80 00 00 	movabs $0x805196,%rcx
  8027fb:	00 00 00 
  8027fe:	48 ba 9d 51 80 00 00 	movabs $0x80519d,%rdx
  802805:	00 00 00 
  802808:	be 89 00 00 00       	mov    $0x89,%esi
  80280d:	48 bf b2 51 80 00 00 	movabs $0x8051b2,%rdi
  802814:	00 00 00 
  802817:	b8 00 00 00 00       	mov    $0x0,%eax
  80281c:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802823:	00 00 00 
  802826:	41 ff d0             	callq  *%r8
  802829:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802830:	7e 35                	jle    802867 <devfile_read+0xde>
  802832:	48 b9 c0 51 80 00 00 	movabs $0x8051c0,%rcx
  802839:	00 00 00 
  80283c:	48 ba 9d 51 80 00 00 	movabs $0x80519d,%rdx
  802843:	00 00 00 
  802846:	be 8a 00 00 00       	mov    $0x8a,%esi
  80284b:	48 bf b2 51 80 00 00 	movabs $0x8051b2,%rdi
  802852:	00 00 00 
  802855:	b8 00 00 00 00       	mov    $0x0,%eax
  80285a:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802861:	00 00 00 
  802864:	41 ff d0             	callq  *%r8
  802867:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80286a:	48 63 d0             	movslq %eax,%rdx
  80286d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802871:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  802878:	00 00 00 
  80287b:	48 89 c7             	mov    %rax,%rdi
  80287e:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  802885:	00 00 00 
  802888:	ff d0                	callq  *%rax
  80288a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80288d:	c9                   	leaveq 
  80288e:	c3                   	retq   

000000000080288f <devfile_write>:
  80288f:	55                   	push   %rbp
  802890:	48 89 e5             	mov    %rsp,%rbp
  802893:	48 83 ec 40          	sub    $0x40,%rsp
  802897:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80289b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80289f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8028a3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8028a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8028ab:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8028b2:	00 
  8028b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028b7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8028bb:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8028c0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8028c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028c8:	8b 50 0c             	mov    0xc(%rax),%edx
  8028cb:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8028d2:	00 00 00 
  8028d5:	89 10                	mov    %edx,(%rax)
  8028d7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8028de:	00 00 00 
  8028e1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8028e5:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8028e9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8028ed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8028f1:	48 89 c6             	mov    %rax,%rsi
  8028f4:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  8028fb:	00 00 00 
  8028fe:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  802905:	00 00 00 
  802908:	ff d0                	callq  *%rax
  80290a:	be 00 00 00 00       	mov    $0x0,%esi
  80290f:	bf 04 00 00 00       	mov    $0x4,%edi
  802914:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  80291b:	00 00 00 
  80291e:	ff d0                	callq  *%rax
  802920:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802923:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802927:	79 05                	jns    80292e <devfile_write+0x9f>
  802929:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80292c:	eb 43                	jmp    802971 <devfile_write+0xe2>
  80292e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802931:	48 98                	cltq   
  802933:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802937:	76 35                	jbe    80296e <devfile_write+0xdf>
  802939:	48 b9 96 51 80 00 00 	movabs $0x805196,%rcx
  802940:	00 00 00 
  802943:	48 ba 9d 51 80 00 00 	movabs $0x80519d,%rdx
  80294a:	00 00 00 
  80294d:	be a8 00 00 00       	mov    $0xa8,%esi
  802952:	48 bf b2 51 80 00 00 	movabs $0x8051b2,%rdi
  802959:	00 00 00 
  80295c:	b8 00 00 00 00       	mov    $0x0,%eax
  802961:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802968:	00 00 00 
  80296b:	41 ff d0             	callq  *%r8
  80296e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802971:	c9                   	leaveq 
  802972:	c3                   	retq   

0000000000802973 <devfile_stat>:
  802973:	55                   	push   %rbp
  802974:	48 89 e5             	mov    %rsp,%rbp
  802977:	48 83 ec 20          	sub    $0x20,%rsp
  80297b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80297f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802983:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802987:	8b 50 0c             	mov    0xc(%rax),%edx
  80298a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802991:	00 00 00 
  802994:	89 10                	mov    %edx,(%rax)
  802996:	be 00 00 00 00       	mov    $0x0,%esi
  80299b:	bf 05 00 00 00       	mov    $0x5,%edi
  8029a0:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  8029a7:	00 00 00 
  8029aa:	ff d0                	callq  *%rax
  8029ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029af:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029b3:	79 05                	jns    8029ba <devfile_stat+0x47>
  8029b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029b8:	eb 56                	jmp    802a10 <devfile_stat+0x9d>
  8029ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029be:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8029c5:	00 00 00 
  8029c8:	48 89 c7             	mov    %rax,%rdi
  8029cb:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  8029d2:	00 00 00 
  8029d5:	ff d0                	callq  *%rax
  8029d7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8029de:	00 00 00 
  8029e1:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8029e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029eb:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8029f1:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8029f8:	00 00 00 
  8029fb:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802a01:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a05:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802a0b:	b8 00 00 00 00       	mov    $0x0,%eax
  802a10:	c9                   	leaveq 
  802a11:	c3                   	retq   

0000000000802a12 <devfile_trunc>:
  802a12:	55                   	push   %rbp
  802a13:	48 89 e5             	mov    %rsp,%rbp
  802a16:	48 83 ec 10          	sub    $0x10,%rsp
  802a1a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a1e:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a25:	8b 50 0c             	mov    0xc(%rax),%edx
  802a28:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802a2f:	00 00 00 
  802a32:	89 10                	mov    %edx,(%rax)
  802a34:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802a3b:	00 00 00 
  802a3e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802a41:	89 50 04             	mov    %edx,0x4(%rax)
  802a44:	be 00 00 00 00       	mov    $0x0,%esi
  802a49:	bf 02 00 00 00       	mov    $0x2,%edi
  802a4e:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  802a55:	00 00 00 
  802a58:	ff d0                	callq  *%rax
  802a5a:	c9                   	leaveq 
  802a5b:	c3                   	retq   

0000000000802a5c <remove>:
  802a5c:	55                   	push   %rbp
  802a5d:	48 89 e5             	mov    %rsp,%rbp
  802a60:	48 83 ec 10          	sub    $0x10,%rsp
  802a64:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a6c:	48 89 c7             	mov    %rax,%rdi
  802a6f:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  802a76:	00 00 00 
  802a79:	ff d0                	callq  *%rax
  802a7b:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802a80:	7e 07                	jle    802a89 <remove+0x2d>
  802a82:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802a87:	eb 33                	jmp    802abc <remove+0x60>
  802a89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a8d:	48 89 c6             	mov    %rax,%rsi
  802a90:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802a97:	00 00 00 
  802a9a:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  802aa1:	00 00 00 
  802aa4:	ff d0                	callq  *%rax
  802aa6:	be 00 00 00 00       	mov    $0x0,%esi
  802aab:	bf 07 00 00 00       	mov    $0x7,%edi
  802ab0:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  802ab7:	00 00 00 
  802aba:	ff d0                	callq  *%rax
  802abc:	c9                   	leaveq 
  802abd:	c3                   	retq   

0000000000802abe <sync>:
  802abe:	55                   	push   %rbp
  802abf:	48 89 e5             	mov    %rsp,%rbp
  802ac2:	be 00 00 00 00       	mov    $0x0,%esi
  802ac7:	bf 08 00 00 00       	mov    $0x8,%edi
  802acc:	48 b8 f1 25 80 00 00 	movabs $0x8025f1,%rax
  802ad3:	00 00 00 
  802ad6:	ff d0                	callq  *%rax
  802ad8:	5d                   	pop    %rbp
  802ad9:	c3                   	retq   

0000000000802ada <copy>:
  802ada:	55                   	push   %rbp
  802adb:	48 89 e5             	mov    %rsp,%rbp
  802ade:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802ae5:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802aec:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802af3:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802afa:	be 00 00 00 00       	mov    $0x0,%esi
  802aff:	48 89 c7             	mov    %rax,%rdi
  802b02:	48 b8 78 26 80 00 00 	movabs $0x802678,%rax
  802b09:	00 00 00 
  802b0c:	ff d0                	callq  *%rax
  802b0e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b11:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b15:	79 28                	jns    802b3f <copy+0x65>
  802b17:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b1a:	89 c6                	mov    %eax,%esi
  802b1c:	48 bf cc 51 80 00 00 	movabs $0x8051cc,%rdi
  802b23:	00 00 00 
  802b26:	b8 00 00 00 00       	mov    $0x0,%eax
  802b2b:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  802b32:	00 00 00 
  802b35:	ff d2                	callq  *%rdx
  802b37:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b3a:	e9 74 01 00 00       	jmpq   802cb3 <copy+0x1d9>
  802b3f:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802b46:	be 01 01 00 00       	mov    $0x101,%esi
  802b4b:	48 89 c7             	mov    %rax,%rdi
  802b4e:	48 b8 78 26 80 00 00 	movabs $0x802678,%rax
  802b55:	00 00 00 
  802b58:	ff d0                	callq  *%rax
  802b5a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b5d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b61:	79 39                	jns    802b9c <copy+0xc2>
  802b63:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b66:	89 c6                	mov    %eax,%esi
  802b68:	48 bf e2 51 80 00 00 	movabs $0x8051e2,%rdi
  802b6f:	00 00 00 
  802b72:	b8 00 00 00 00       	mov    $0x0,%eax
  802b77:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  802b7e:	00 00 00 
  802b81:	ff d2                	callq  *%rdx
  802b83:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b86:	89 c7                	mov    %eax,%edi
  802b88:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802b8f:	00 00 00 
  802b92:	ff d0                	callq  *%rax
  802b94:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b97:	e9 17 01 00 00       	jmpq   802cb3 <copy+0x1d9>
  802b9c:	eb 74                	jmp    802c12 <copy+0x138>
  802b9e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802ba1:	48 63 d0             	movslq %eax,%rdx
  802ba4:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802bab:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bae:	48 89 ce             	mov    %rcx,%rsi
  802bb1:	89 c7                	mov    %eax,%edi
  802bb3:	48 b8 ec 22 80 00 00 	movabs $0x8022ec,%rax
  802bba:	00 00 00 
  802bbd:	ff d0                	callq  *%rax
  802bbf:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802bc2:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802bc6:	79 4a                	jns    802c12 <copy+0x138>
  802bc8:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802bcb:	89 c6                	mov    %eax,%esi
  802bcd:	48 bf fc 51 80 00 00 	movabs $0x8051fc,%rdi
  802bd4:	00 00 00 
  802bd7:	b8 00 00 00 00       	mov    $0x0,%eax
  802bdc:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  802be3:	00 00 00 
  802be6:	ff d2                	callq  *%rdx
  802be8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802beb:	89 c7                	mov    %eax,%edi
  802bed:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802bf4:	00 00 00 
  802bf7:	ff d0                	callq  *%rax
  802bf9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bfc:	89 c7                	mov    %eax,%edi
  802bfe:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802c05:	00 00 00 
  802c08:	ff d0                	callq  *%rax
  802c0a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802c0d:	e9 a1 00 00 00       	jmpq   802cb3 <copy+0x1d9>
  802c12:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802c19:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c1c:	ba 00 02 00 00       	mov    $0x200,%edx
  802c21:	48 89 ce             	mov    %rcx,%rsi
  802c24:	89 c7                	mov    %eax,%edi
  802c26:	48 b8 a2 21 80 00 00 	movabs $0x8021a2,%rax
  802c2d:	00 00 00 
  802c30:	ff d0                	callq  *%rax
  802c32:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802c35:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802c39:	0f 8f 5f ff ff ff    	jg     802b9e <copy+0xc4>
  802c3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802c43:	79 47                	jns    802c8c <copy+0x1b2>
  802c45:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802c48:	89 c6                	mov    %eax,%esi
  802c4a:	48 bf 0f 52 80 00 00 	movabs $0x80520f,%rdi
  802c51:	00 00 00 
  802c54:	b8 00 00 00 00       	mov    $0x0,%eax
  802c59:	48 ba c6 03 80 00 00 	movabs $0x8003c6,%rdx
  802c60:	00 00 00 
  802c63:	ff d2                	callq  *%rdx
  802c65:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c68:	89 c7                	mov    %eax,%edi
  802c6a:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802c71:	00 00 00 
  802c74:	ff d0                	callq  *%rax
  802c76:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c79:	89 c7                	mov    %eax,%edi
  802c7b:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802c82:	00 00 00 
  802c85:	ff d0                	callq  *%rax
  802c87:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802c8a:	eb 27                	jmp    802cb3 <copy+0x1d9>
  802c8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c8f:	89 c7                	mov    %eax,%edi
  802c91:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802c98:	00 00 00 
  802c9b:	ff d0                	callq  *%rax
  802c9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802ca0:	89 c7                	mov    %eax,%edi
  802ca2:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802ca9:	00 00 00 
  802cac:	ff d0                	callq  *%rax
  802cae:	b8 00 00 00 00       	mov    $0x0,%eax
  802cb3:	c9                   	leaveq 
  802cb4:	c3                   	retq   

0000000000802cb5 <spawn>:
  802cb5:	55                   	push   %rbp
  802cb6:	48 89 e5             	mov    %rsp,%rbp
  802cb9:	48 81 ec 10 03 00 00 	sub    $0x310,%rsp
  802cc0:	48 89 bd 08 fd ff ff 	mov    %rdi,-0x2f8(%rbp)
  802cc7:	48 89 b5 00 fd ff ff 	mov    %rsi,-0x300(%rbp)
  802cce:	48 8b 85 08 fd ff ff 	mov    -0x2f8(%rbp),%rax
  802cd5:	be 00 00 00 00       	mov    $0x0,%esi
  802cda:	48 89 c7             	mov    %rax,%rdi
  802cdd:	48 b8 78 26 80 00 00 	movabs $0x802678,%rax
  802ce4:	00 00 00 
  802ce7:	ff d0                	callq  *%rax
  802ce9:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802cec:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802cf0:	79 08                	jns    802cfa <spawn+0x45>
  802cf2:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802cf5:	e9 0c 03 00 00       	jmpq   803006 <spawn+0x351>
  802cfa:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802cfd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  802d00:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
  802d07:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  802d0b:	48 8d 8d d0 fd ff ff 	lea    -0x230(%rbp),%rcx
  802d12:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802d15:	ba 00 02 00 00       	mov    $0x200,%edx
  802d1a:	48 89 ce             	mov    %rcx,%rsi
  802d1d:	89 c7                	mov    %eax,%edi
  802d1f:	48 b8 77 22 80 00 00 	movabs $0x802277,%rax
  802d26:	00 00 00 
  802d29:	ff d0                	callq  *%rax
  802d2b:	3d 00 02 00 00       	cmp    $0x200,%eax
  802d30:	75 0d                	jne    802d3f <spawn+0x8a>
  802d32:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802d36:	8b 00                	mov    (%rax),%eax
  802d38:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  802d3d:	74 43                	je     802d82 <spawn+0xcd>
  802d3f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802d42:	89 c7                	mov    %eax,%edi
  802d44:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802d4b:	00 00 00 
  802d4e:	ff d0                	callq  *%rax
  802d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802d54:	8b 00                	mov    (%rax),%eax
  802d56:	ba 7f 45 4c 46       	mov    $0x464c457f,%edx
  802d5b:	89 c6                	mov    %eax,%esi
  802d5d:	48 bf 28 52 80 00 00 	movabs $0x805228,%rdi
  802d64:	00 00 00 
  802d67:	b8 00 00 00 00       	mov    $0x0,%eax
  802d6c:	48 b9 c6 03 80 00 00 	movabs $0x8003c6,%rcx
  802d73:	00 00 00 
  802d76:	ff d1                	callq  *%rcx
  802d78:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
  802d7d:	e9 84 02 00 00       	jmpq   803006 <spawn+0x351>
  802d82:	b8 07 00 00 00       	mov    $0x7,%eax
  802d87:	cd 30                	int    $0x30
  802d89:	89 45 d0             	mov    %eax,-0x30(%rbp)
  802d8c:	8b 45 d0             	mov    -0x30(%rbp),%eax
  802d8f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802d92:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802d96:	79 08                	jns    802da0 <spawn+0xeb>
  802d98:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802d9b:	e9 66 02 00 00       	jmpq   803006 <spawn+0x351>
  802da0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802da3:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  802da6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802da9:	25 ff 03 00 00       	and    $0x3ff,%eax
  802dae:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802db5:	00 00 00 
  802db8:	48 98                	cltq   
  802dba:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802dc1:	48 01 d0             	add    %rdx,%rax
  802dc4:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  802dcb:	48 89 c6             	mov    %rax,%rsi
  802dce:	b8 18 00 00 00       	mov    $0x18,%eax
  802dd3:	48 89 d7             	mov    %rdx,%rdi
  802dd6:	48 89 c1             	mov    %rax,%rcx
  802dd9:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  802ddc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802de0:	48 8b 40 18          	mov    0x18(%rax),%rax
  802de4:	48 89 85 a8 fd ff ff 	mov    %rax,-0x258(%rbp)
  802deb:	48 8d 85 10 fd ff ff 	lea    -0x2f0(%rbp),%rax
  802df2:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
  802df9:	48 8b 8d 00 fd ff ff 	mov    -0x300(%rbp),%rcx
  802e00:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802e03:	48 89 ce             	mov    %rcx,%rsi
  802e06:	89 c7                	mov    %eax,%edi
  802e08:	48 b8 70 32 80 00 00 	movabs $0x803270,%rax
  802e0f:	00 00 00 
  802e12:	ff d0                	callq  *%rax
  802e14:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802e17:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802e1b:	79 08                	jns    802e25 <spawn+0x170>
  802e1d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802e20:	e9 e1 01 00 00       	jmpq   803006 <spawn+0x351>
  802e25:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e29:	48 8b 40 20          	mov    0x20(%rax),%rax
  802e2d:	48 8d 95 d0 fd ff ff 	lea    -0x230(%rbp),%rdx
  802e34:	48 01 d0             	add    %rdx,%rax
  802e37:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802e3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802e42:	e9 a3 00 00 00       	jmpq   802eea <spawn+0x235>
  802e47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e4b:	8b 00                	mov    (%rax),%eax
  802e4d:	83 f8 01             	cmp    $0x1,%eax
  802e50:	74 05                	je     802e57 <spawn+0x1a2>
  802e52:	e9 8a 00 00 00       	jmpq   802ee1 <spawn+0x22c>
  802e57:	c7 45 ec 05 00 00 00 	movl   $0x5,-0x14(%rbp)
  802e5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e62:	8b 40 04             	mov    0x4(%rax),%eax
  802e65:	83 e0 02             	and    $0x2,%eax
  802e68:	85 c0                	test   %eax,%eax
  802e6a:	74 04                	je     802e70 <spawn+0x1bb>
  802e6c:	83 4d ec 02          	orl    $0x2,-0x14(%rbp)
  802e70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e74:	48 8b 40 08          	mov    0x8(%rax),%rax
  802e78:	41 89 c1             	mov    %eax,%r9d
  802e7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e7f:	4c 8b 40 20          	mov    0x20(%rax),%r8
  802e83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e87:	48 8b 50 28          	mov    0x28(%rax),%rdx
  802e8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e8f:	48 8b 70 10          	mov    0x10(%rax),%rsi
  802e93:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  802e96:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802e99:	8b 7d ec             	mov    -0x14(%rbp),%edi
  802e9c:	89 3c 24             	mov    %edi,(%rsp)
  802e9f:	89 c7                	mov    %eax,%edi
  802ea1:	48 b8 19 35 80 00 00 	movabs $0x803519,%rax
  802ea8:	00 00 00 
  802eab:	ff d0                	callq  *%rax
  802ead:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802eb0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802eb4:	79 2b                	jns    802ee1 <spawn+0x22c>
  802eb6:	90                   	nop
  802eb7:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802eba:	89 c7                	mov    %eax,%edi
  802ebc:	48 b8 ea 17 80 00 00 	movabs $0x8017ea,%rax
  802ec3:	00 00 00 
  802ec6:	ff d0                	callq  *%rax
  802ec8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802ecb:	89 c7                	mov    %eax,%edi
  802ecd:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802ed4:	00 00 00 
  802ed7:	ff d0                	callq  *%rax
  802ed9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802edc:	e9 25 01 00 00       	jmpq   803006 <spawn+0x351>
  802ee1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802ee5:	48 83 45 f0 38       	addq   $0x38,-0x10(%rbp)
  802eea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802eee:	0f b7 40 38          	movzwl 0x38(%rax),%eax
  802ef2:	0f b7 c0             	movzwl %ax,%eax
  802ef5:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  802ef8:	0f 8f 49 ff ff ff    	jg     802e47 <spawn+0x192>
  802efe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802f01:	89 c7                	mov    %eax,%edi
  802f03:	48 b8 80 1f 80 00 00 	movabs $0x801f80,%rax
  802f0a:	00 00 00 
  802f0d:	ff d0                	callq  *%rax
  802f0f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
  802f16:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802f19:	89 c7                	mov    %eax,%edi
  802f1b:	48 b8 05 37 80 00 00 	movabs $0x803705,%rax
  802f22:	00 00 00 
  802f25:	ff d0                	callq  *%rax
  802f27:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802f2a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802f2e:	79 30                	jns    802f60 <spawn+0x2ab>
  802f30:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802f33:	89 c1                	mov    %eax,%ecx
  802f35:	48 ba 42 52 80 00 00 	movabs $0x805242,%rdx
  802f3c:	00 00 00 
  802f3f:	be 86 00 00 00       	mov    $0x86,%esi
  802f44:	48 bf 58 52 80 00 00 	movabs $0x805258,%rdi
  802f4b:	00 00 00 
  802f4e:	b8 00 00 00 00       	mov    $0x0,%eax
  802f53:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802f5a:	00 00 00 
  802f5d:	41 ff d0             	callq  *%r8
  802f60:	48 8d 95 10 fd ff ff 	lea    -0x2f0(%rbp),%rdx
  802f67:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802f6a:	48 89 d6             	mov    %rdx,%rsi
  802f6d:	89 c7                	mov    %eax,%edi
  802f6f:	48 b8 ea 19 80 00 00 	movabs $0x8019ea,%rax
  802f76:	00 00 00 
  802f79:	ff d0                	callq  *%rax
  802f7b:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802f7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802f82:	79 30                	jns    802fb4 <spawn+0x2ff>
  802f84:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802f87:	89 c1                	mov    %eax,%ecx
  802f89:	48 ba 67 52 80 00 00 	movabs $0x805267,%rdx
  802f90:	00 00 00 
  802f93:	be 8a 00 00 00       	mov    $0x8a,%esi
  802f98:	48 bf 58 52 80 00 00 	movabs $0x805258,%rdi
  802f9f:	00 00 00 
  802fa2:	b8 00 00 00 00       	mov    $0x0,%eax
  802fa7:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802fae:	00 00 00 
  802fb1:	41 ff d0             	callq  *%r8
  802fb4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802fb7:	be 02 00 00 00       	mov    $0x2,%esi
  802fbc:	89 c7                	mov    %eax,%edi
  802fbe:	48 b8 9f 19 80 00 00 	movabs $0x80199f,%rax
  802fc5:	00 00 00 
  802fc8:	ff d0                	callq  *%rax
  802fca:	89 45 e8             	mov    %eax,-0x18(%rbp)
  802fcd:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  802fd1:	79 30                	jns    803003 <spawn+0x34e>
  802fd3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802fd6:	89 c1                	mov    %eax,%ecx
  802fd8:	48 ba 81 52 80 00 00 	movabs $0x805281,%rdx
  802fdf:	00 00 00 
  802fe2:	be 8d 00 00 00       	mov    $0x8d,%esi
  802fe7:	48 bf 58 52 80 00 00 	movabs $0x805258,%rdi
  802fee:	00 00 00 
  802ff1:	b8 00 00 00 00       	mov    $0x0,%eax
  802ff6:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  802ffd:	00 00 00 
  803000:	41 ff d0             	callq  *%r8
  803003:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  803006:	c9                   	leaveq 
  803007:	c3                   	retq   

0000000000803008 <spawnl>:
  803008:	55                   	push   %rbp
  803009:	48 89 e5             	mov    %rsp,%rbp
  80300c:	41 55                	push   %r13
  80300e:	41 54                	push   %r12
  803010:	53                   	push   %rbx
  803011:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803018:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
  80301f:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
  803026:	48 89 8d 48 ff ff ff 	mov    %rcx,-0xb8(%rbp)
  80302d:	4c 89 85 50 ff ff ff 	mov    %r8,-0xb0(%rbp)
  803034:	4c 89 8d 58 ff ff ff 	mov    %r9,-0xa8(%rbp)
  80303b:	84 c0                	test   %al,%al
  80303d:	74 26                	je     803065 <spawnl+0x5d>
  80303f:	0f 29 85 60 ff ff ff 	movaps %xmm0,-0xa0(%rbp)
  803046:	0f 29 8d 70 ff ff ff 	movaps %xmm1,-0x90(%rbp)
  80304d:	0f 29 55 80          	movaps %xmm2,-0x80(%rbp)
  803051:	0f 29 5d 90          	movaps %xmm3,-0x70(%rbp)
  803055:	0f 29 65 a0          	movaps %xmm4,-0x60(%rbp)
  803059:	0f 29 6d b0          	movaps %xmm5,-0x50(%rbp)
  80305d:	0f 29 75 c0          	movaps %xmm6,-0x40(%rbp)
  803061:	0f 29 7d d0          	movaps %xmm7,-0x30(%rbp)
  803065:	48 89 b5 f0 fe ff ff 	mov    %rsi,-0x110(%rbp)
  80306c:	c7 85 2c ff ff ff 00 	movl   $0x0,-0xd4(%rbp)
  803073:	00 00 00 
  803076:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  80307d:	00 00 00 
  803080:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  803087:	00 00 00 
  80308a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80308e:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  803095:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  80309c:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  8030a3:	eb 07                	jmp    8030ac <spawnl+0xa4>
  8030a5:	83 85 2c ff ff ff 01 	addl   $0x1,-0xd4(%rbp)
  8030ac:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8030b2:	83 f8 30             	cmp    $0x30,%eax
  8030b5:	73 23                	jae    8030da <spawnl+0xd2>
  8030b7:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  8030be:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8030c4:	89 c0                	mov    %eax,%eax
  8030c6:	48 01 d0             	add    %rdx,%rax
  8030c9:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  8030cf:	83 c2 08             	add    $0x8,%edx
  8030d2:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  8030d8:	eb 15                	jmp    8030ef <spawnl+0xe7>
  8030da:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  8030e1:	48 89 d0             	mov    %rdx,%rax
  8030e4:	48 83 c2 08          	add    $0x8,%rdx
  8030e8:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8030ef:	48 8b 00             	mov    (%rax),%rax
  8030f2:	48 85 c0             	test   %rax,%rax
  8030f5:	75 ae                	jne    8030a5 <spawnl+0x9d>
  8030f7:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  8030fd:	83 c0 02             	add    $0x2,%eax
  803100:	48 89 e2             	mov    %rsp,%rdx
  803103:	48 89 d3             	mov    %rdx,%rbx
  803106:	48 63 d0             	movslq %eax,%rdx
  803109:	48 83 ea 01          	sub    $0x1,%rdx
  80310d:	48 89 95 20 ff ff ff 	mov    %rdx,-0xe0(%rbp)
  803114:	48 63 d0             	movslq %eax,%rdx
  803117:	49 89 d4             	mov    %rdx,%r12
  80311a:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  803120:	48 63 d0             	movslq %eax,%rdx
  803123:	49 89 d2             	mov    %rdx,%r10
  803126:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  80312c:	48 98                	cltq   
  80312e:	48 c1 e0 03          	shl    $0x3,%rax
  803132:	48 8d 50 07          	lea    0x7(%rax),%rdx
  803136:	b8 10 00 00 00       	mov    $0x10,%eax
  80313b:	48 83 e8 01          	sub    $0x1,%rax
  80313f:	48 01 d0             	add    %rdx,%rax
  803142:	bf 10 00 00 00       	mov    $0x10,%edi
  803147:	ba 00 00 00 00       	mov    $0x0,%edx
  80314c:	48 f7 f7             	div    %rdi
  80314f:	48 6b c0 10          	imul   $0x10,%rax,%rax
  803153:	48 29 c4             	sub    %rax,%rsp
  803156:	48 89 e0             	mov    %rsp,%rax
  803159:	48 83 c0 07          	add    $0x7,%rax
  80315d:	48 c1 e8 03          	shr    $0x3,%rax
  803161:	48 c1 e0 03          	shl    $0x3,%rax
  803165:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
  80316c:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  803173:	48 8b 95 f0 fe ff ff 	mov    -0x110(%rbp),%rdx
  80317a:	48 89 10             	mov    %rdx,(%rax)
  80317d:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  803183:	8d 50 01             	lea    0x1(%rax),%edx
  803186:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  80318d:	48 63 d2             	movslq %edx,%rdx
  803190:	48 c7 04 d0 00 00 00 	movq   $0x0,(%rax,%rdx,8)
  803197:	00 
  803198:	c7 85 00 ff ff ff 10 	movl   $0x10,-0x100(%rbp)
  80319f:	00 00 00 
  8031a2:	c7 85 04 ff ff ff 30 	movl   $0x30,-0xfc(%rbp)
  8031a9:	00 00 00 
  8031ac:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8031b0:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
  8031b7:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  8031be:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
  8031c5:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
  8031cc:	00 00 00 
  8031cf:	eb 63                	jmp    803234 <spawnl+0x22c>
  8031d1:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
  8031d7:	8d 70 01             	lea    0x1(%rax),%esi
  8031da:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8031e0:	83 f8 30             	cmp    $0x30,%eax
  8031e3:	73 23                	jae    803208 <spawnl+0x200>
  8031e5:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
  8031ec:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
  8031f2:	89 c0                	mov    %eax,%eax
  8031f4:	48 01 d0             	add    %rdx,%rax
  8031f7:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
  8031fd:	83 c2 08             	add    $0x8,%edx
  803200:	89 95 00 ff ff ff    	mov    %edx,-0x100(%rbp)
  803206:	eb 15                	jmp    80321d <spawnl+0x215>
  803208:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
  80320f:	48 89 d0             	mov    %rdx,%rax
  803212:	48 83 c2 08          	add    $0x8,%rdx
  803216:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80321d:	48 8b 08             	mov    (%rax),%rcx
  803220:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
  803227:	89 f2                	mov    %esi,%edx
  803229:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
  80322d:	83 85 28 ff ff ff 01 	addl   $0x1,-0xd8(%rbp)
  803234:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
  80323a:	3b 85 28 ff ff ff    	cmp    -0xd8(%rbp),%eax
  803240:	77 8f                	ja     8031d1 <spawnl+0x1c9>
  803242:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803249:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
  803250:	48 89 d6             	mov    %rdx,%rsi
  803253:	48 89 c7             	mov    %rax,%rdi
  803256:	48 b8 b5 2c 80 00 00 	movabs $0x802cb5,%rax
  80325d:	00 00 00 
  803260:	ff d0                	callq  *%rax
  803262:	48 89 dc             	mov    %rbx,%rsp
  803265:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
  803269:	5b                   	pop    %rbx
  80326a:	41 5c                	pop    %r12
  80326c:	41 5d                	pop    %r13
  80326e:	5d                   	pop    %rbp
  80326f:	c3                   	retq   

0000000000803270 <init_stack>:
  803270:	55                   	push   %rbp
  803271:	48 89 e5             	mov    %rsp,%rbp
  803274:	48 83 ec 50          	sub    $0x50,%rsp
  803278:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80327b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  80327f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  803283:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80328a:	00 
  80328b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  803292:	eb 33                	jmp    8032c7 <init_stack+0x57>
  803294:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803297:	48 98                	cltq   
  803299:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8032a0:	00 
  8032a1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8032a5:	48 01 d0             	add    %rdx,%rax
  8032a8:	48 8b 00             	mov    (%rax),%rax
  8032ab:	48 89 c7             	mov    %rax,%rdi
  8032ae:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  8032b5:	00 00 00 
  8032b8:	ff d0                	callq  *%rax
  8032ba:	83 c0 01             	add    $0x1,%eax
  8032bd:	48 98                	cltq   
  8032bf:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8032c3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
  8032c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8032ca:	48 98                	cltq   
  8032cc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8032d3:	00 
  8032d4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8032d8:	48 01 d0             	add    %rdx,%rax
  8032db:	48 8b 00             	mov    (%rax),%rax
  8032de:	48 85 c0             	test   %rax,%rax
  8032e1:	75 b1                	jne    803294 <init_stack+0x24>
  8032e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032e7:	48 f7 d8             	neg    %rax
  8032ea:	48 05 00 10 40 00    	add    $0x401000,%rax
  8032f0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8032f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8032f8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8032fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803300:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  803304:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803307:	83 c2 01             	add    $0x1,%edx
  80330a:	c1 e2 03             	shl    $0x3,%edx
  80330d:	48 63 d2             	movslq %edx,%rdx
  803310:	48 f7 da             	neg    %rdx
  803313:	48 01 d0             	add    %rdx,%rax
  803316:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  80331a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80331e:	48 83 e8 10          	sub    $0x10,%rax
  803322:	48 3d ff ff 3f 00    	cmp    $0x3fffff,%rax
  803328:	77 0a                	ja     803334 <init_stack+0xc4>
  80332a:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  80332f:	e9 e3 01 00 00       	jmpq   803517 <init_stack+0x2a7>
  803334:	ba 07 00 00 00       	mov    $0x7,%edx
  803339:	be 00 00 40 00       	mov    $0x400000,%esi
  80333e:	bf 00 00 00 00       	mov    $0x0,%edi
  803343:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  80334a:	00 00 00 
  80334d:	ff d0                	callq  *%rax
  80334f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803352:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803356:	79 08                	jns    803360 <init_stack+0xf0>
  803358:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80335b:	e9 b7 01 00 00       	jmpq   803517 <init_stack+0x2a7>
  803360:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  803367:	e9 8a 00 00 00       	jmpq   8033f6 <init_stack+0x186>
  80336c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80336f:	48 98                	cltq   
  803371:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  803378:	00 
  803379:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80337d:	48 01 c2             	add    %rax,%rdx
  803380:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803385:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803389:	48 01 c8             	add    %rcx,%rax
  80338c:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803392:	48 89 02             	mov    %rax,(%rdx)
  803395:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803398:	48 98                	cltq   
  80339a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8033a1:	00 
  8033a2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8033a6:	48 01 d0             	add    %rdx,%rax
  8033a9:	48 8b 10             	mov    (%rax),%rdx
  8033ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8033b0:	48 89 d6             	mov    %rdx,%rsi
  8033b3:	48 89 c7             	mov    %rax,%rdi
  8033b6:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  8033bd:	00 00 00 
  8033c0:	ff d0                	callq  *%rax
  8033c2:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8033c5:	48 98                	cltq   
  8033c7:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8033ce:	00 
  8033cf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  8033d3:	48 01 d0             	add    %rdx,%rax
  8033d6:	48 8b 00             	mov    (%rax),%rax
  8033d9:	48 89 c7             	mov    %rax,%rdi
  8033dc:	48 b8 0f 0f 80 00 00 	movabs $0x800f0f,%rax
  8033e3:	00 00 00 
  8033e6:	ff d0                	callq  *%rax
  8033e8:	48 98                	cltq   
  8033ea:	48 83 c0 01          	add    $0x1,%rax
  8033ee:	48 01 45 e0          	add    %rax,-0x20(%rbp)
  8033f2:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  8033f6:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8033f9:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  8033fc:	0f 8c 6a ff ff ff    	jl     80336c <init_stack+0xfc>
  803402:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803405:	48 98                	cltq   
  803407:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80340e:	00 
  80340f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803413:	48 01 d0             	add    %rdx,%rax
  803416:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  80341d:	48 81 7d e0 00 10 40 	cmpq   $0x401000,-0x20(%rbp)
  803424:	00 
  803425:	74 35                	je     80345c <init_stack+0x1ec>
  803427:	48 b9 98 52 80 00 00 	movabs $0x805298,%rcx
  80342e:	00 00 00 
  803431:	48 ba be 52 80 00 00 	movabs $0x8052be,%rdx
  803438:	00 00 00 
  80343b:	be f6 00 00 00       	mov    $0xf6,%esi
  803440:	48 bf 58 52 80 00 00 	movabs $0x805258,%rdi
  803447:	00 00 00 
  80344a:	b8 00 00 00 00       	mov    $0x0,%eax
  80344f:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  803456:	00 00 00 
  803459:	41 ff d0             	callq  *%r8
  80345c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803460:	48 8d 50 f8          	lea    -0x8(%rax),%rdx
  803464:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  803469:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80346d:	48 01 c8             	add    %rcx,%rax
  803470:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  803476:	48 89 02             	mov    %rax,(%rdx)
  803479:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80347d:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
  803481:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803484:	48 98                	cltq   
  803486:	48 89 02             	mov    %rax,(%rdx)
  803489:	ba f0 cf 7f ef       	mov    $0xef7fcff0,%edx
  80348e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803492:	48 01 d0             	add    %rdx,%rax
  803495:	48 2d 00 00 40 00    	sub    $0x400000,%rax
  80349b:	48 89 c2             	mov    %rax,%rdx
  80349e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  8034a2:	48 89 10             	mov    %rdx,(%rax)
  8034a5:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8034a8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  8034ae:	b9 00 d0 7f ef       	mov    $0xef7fd000,%ecx
  8034b3:	89 c2                	mov    %eax,%edx
  8034b5:	be 00 00 40 00       	mov    $0x400000,%esi
  8034ba:	bf 00 00 00 00       	mov    $0x0,%edi
  8034bf:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  8034c6:	00 00 00 
  8034c9:	ff d0                	callq  *%rax
  8034cb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8034ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8034d2:	79 02                	jns    8034d6 <init_stack+0x266>
  8034d4:	eb 28                	jmp    8034fe <init_stack+0x28e>
  8034d6:	be 00 00 40 00       	mov    $0x400000,%esi
  8034db:	bf 00 00 00 00       	mov    $0x0,%edi
  8034e0:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  8034e7:	00 00 00 
  8034ea:	ff d0                	callq  *%rax
  8034ec:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8034ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8034f3:	79 02                	jns    8034f7 <init_stack+0x287>
  8034f5:	eb 07                	jmp    8034fe <init_stack+0x28e>
  8034f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8034fc:	eb 19                	jmp    803517 <init_stack+0x2a7>
  8034fe:	be 00 00 40 00       	mov    $0x400000,%esi
  803503:	bf 00 00 00 00       	mov    $0x0,%edi
  803508:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  80350f:	00 00 00 
  803512:	ff d0                	callq  *%rax
  803514:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803517:	c9                   	leaveq 
  803518:	c3                   	retq   

0000000000803519 <map_segment>:
  803519:	55                   	push   %rbp
  80351a:	48 89 e5             	mov    %rsp,%rbp
  80351d:	48 83 ec 50          	sub    $0x50,%rsp
  803521:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803524:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803528:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80352c:	89 4d d8             	mov    %ecx,-0x28(%rbp)
  80352f:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  803533:	44 89 4d bc          	mov    %r9d,-0x44(%rbp)
  803537:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80353b:	25 ff 0f 00 00       	and    $0xfff,%eax
  803540:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803543:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803547:	74 21                	je     80356a <map_segment+0x51>
  803549:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80354c:	48 98                	cltq   
  80354e:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  803552:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803555:	48 98                	cltq   
  803557:	48 01 45 c8          	add    %rax,-0x38(%rbp)
  80355b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80355e:	48 98                	cltq   
  803560:	48 01 45 c0          	add    %rax,-0x40(%rbp)
  803564:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803567:	29 45 bc             	sub    %eax,-0x44(%rbp)
  80356a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803571:	e9 79 01 00 00       	jmpq   8036ef <map_segment+0x1d6>
  803576:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803579:	48 98                	cltq   
  80357b:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
  80357f:	72 3c                	jb     8035bd <map_segment+0xa4>
  803581:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803584:	48 63 d0             	movslq %eax,%rdx
  803587:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80358b:	48 01 d0             	add    %rdx,%rax
  80358e:	48 89 c1             	mov    %rax,%rcx
  803591:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803594:	8b 55 10             	mov    0x10(%rbp),%edx
  803597:	48 89 ce             	mov    %rcx,%rsi
  80359a:	89 c7                	mov    %eax,%edi
  80359c:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8035a3:	00 00 00 
  8035a6:	ff d0                	callq  *%rax
  8035a8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8035ab:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8035af:	0f 89 33 01 00 00    	jns    8036e8 <map_segment+0x1cf>
  8035b5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035b8:	e9 46 01 00 00       	jmpq   803703 <map_segment+0x1ea>
  8035bd:	ba 07 00 00 00       	mov    $0x7,%edx
  8035c2:	be 00 00 40 00       	mov    $0x400000,%esi
  8035c7:	bf 00 00 00 00       	mov    $0x0,%edi
  8035cc:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8035d3:	00 00 00 
  8035d6:	ff d0                	callq  *%rax
  8035d8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8035db:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8035df:	79 08                	jns    8035e9 <map_segment+0xd0>
  8035e1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035e4:	e9 1a 01 00 00       	jmpq   803703 <map_segment+0x1ea>
  8035e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035ec:	8b 55 bc             	mov    -0x44(%rbp),%edx
  8035ef:	01 c2                	add    %eax,%edx
  8035f1:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8035f4:	89 d6                	mov    %edx,%esi
  8035f6:	89 c7                	mov    %eax,%edi
  8035f8:	48 b8 c0 23 80 00 00 	movabs $0x8023c0,%rax
  8035ff:	00 00 00 
  803602:	ff d0                	callq  *%rax
  803604:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803607:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80360b:	79 08                	jns    803615 <map_segment+0xfc>
  80360d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803610:	e9 ee 00 00 00       	jmpq   803703 <map_segment+0x1ea>
  803615:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%rbp)
  80361c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80361f:	48 98                	cltq   
  803621:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803625:	48 29 c2             	sub    %rax,%rdx
  803628:	48 89 d0             	mov    %rdx,%rax
  80362b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80362f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803632:	48 63 d0             	movslq %eax,%rdx
  803635:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803639:	48 39 c2             	cmp    %rax,%rdx
  80363c:	48 0f 47 d0          	cmova  %rax,%rdx
  803640:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803643:	be 00 00 40 00       	mov    $0x400000,%esi
  803648:	89 c7                	mov    %eax,%edi
  80364a:	48 b8 77 22 80 00 00 	movabs $0x802277,%rax
  803651:	00 00 00 
  803654:	ff d0                	callq  *%rax
  803656:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803659:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80365d:	79 08                	jns    803667 <map_segment+0x14e>
  80365f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803662:	e9 9c 00 00 00       	jmpq   803703 <map_segment+0x1ea>
  803667:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80366a:	48 63 d0             	movslq %eax,%rdx
  80366d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803671:	48 01 d0             	add    %rdx,%rax
  803674:	48 89 c2             	mov    %rax,%rdx
  803677:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80367a:	44 8b 45 10          	mov    0x10(%rbp),%r8d
  80367e:	48 89 d1             	mov    %rdx,%rcx
  803681:	89 c2                	mov    %eax,%edx
  803683:	be 00 00 40 00       	mov    $0x400000,%esi
  803688:	bf 00 00 00 00       	mov    $0x0,%edi
  80368d:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  803694:	00 00 00 
  803697:	ff d0                	callq  *%rax
  803699:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80369c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8036a0:	79 30                	jns    8036d2 <map_segment+0x1b9>
  8036a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8036a5:	89 c1                	mov    %eax,%ecx
  8036a7:	48 ba d3 52 80 00 00 	movabs $0x8052d3,%rdx
  8036ae:	00 00 00 
  8036b1:	be 29 01 00 00       	mov    $0x129,%esi
  8036b6:	48 bf 58 52 80 00 00 	movabs $0x805258,%rdi
  8036bd:	00 00 00 
  8036c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8036c5:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  8036cc:	00 00 00 
  8036cf:	41 ff d0             	callq  *%r8
  8036d2:	be 00 00 40 00       	mov    $0x400000,%esi
  8036d7:	bf 00 00 00 00       	mov    $0x0,%edi
  8036dc:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  8036e3:	00 00 00 
  8036e6:	ff d0                	callq  *%rax
  8036e8:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
  8036ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036f2:	48 98                	cltq   
  8036f4:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8036f8:	0f 82 78 fe ff ff    	jb     803576 <map_segment+0x5d>
  8036fe:	b8 00 00 00 00       	mov    $0x0,%eax
  803703:	c9                   	leaveq 
  803704:	c3                   	retq   

0000000000803705 <copy_shared_pages>:
  803705:	55                   	push   %rbp
  803706:	48 89 e5             	mov    %rsp,%rbp
  803709:	48 83 ec 30          	sub    $0x30,%rsp
  80370d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803710:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803717:	00 
  803718:	e9 eb 00 00 00       	jmpq   803808 <copy_shared_pages+0x103>
  80371d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803721:	48 c1 f8 12          	sar    $0x12,%rax
  803725:	48 89 c2             	mov    %rax,%rdx
  803728:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  80372f:	01 00 00 
  803732:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803736:	83 e0 01             	and    $0x1,%eax
  803739:	48 85 c0             	test   %rax,%rax
  80373c:	74 21                	je     80375f <copy_shared_pages+0x5a>
  80373e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803742:	48 c1 f8 09          	sar    $0x9,%rax
  803746:	48 89 c2             	mov    %rax,%rdx
  803749:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  803750:	01 00 00 
  803753:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803757:	83 e0 01             	and    $0x1,%eax
  80375a:	48 85 c0             	test   %rax,%rax
  80375d:	75 0d                	jne    80376c <copy_shared_pages+0x67>
  80375f:	48 81 45 f8 00 02 00 	addq   $0x200,-0x8(%rbp)
  803766:	00 
  803767:	e9 9c 00 00 00       	jmpq   803808 <copy_shared_pages+0x103>
  80376c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803770:	48 05 00 02 00 00    	add    $0x200,%rax
  803776:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80377a:	eb 7e                	jmp    8037fa <copy_shared_pages+0xf5>
  80377c:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803783:	01 00 00 
  803786:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80378a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80378e:	25 01 04 00 00       	and    $0x401,%eax
  803793:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  803799:	75 5a                	jne    8037f5 <copy_shared_pages+0xf0>
  80379b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80379f:	48 c1 e0 0c          	shl    $0xc,%rax
  8037a3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8037a7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8037ae:	01 00 00 
  8037b1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8037b5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8037b9:	25 07 0e 00 00       	and    $0xe07,%eax
  8037be:	89 c6                	mov    %eax,%esi
  8037c0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8037c4:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8037c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037cb:	41 89 f0             	mov    %esi,%r8d
  8037ce:	48 89 c6             	mov    %rax,%rsi
  8037d1:	bf 00 00 00 00       	mov    $0x0,%edi
  8037d6:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  8037dd:	00 00 00 
  8037e0:	ff d0                	callq  *%rax
  8037e2:	48 98                	cltq   
  8037e4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8037e8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8037ed:	79 06                	jns    8037f5 <copy_shared_pages+0xf0>
  8037ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8037f3:	eb 28                	jmp    80381d <copy_shared_pages+0x118>
  8037f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8037fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037fe:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  803802:	0f 8c 74 ff ff ff    	jl     80377c <copy_shared_pages+0x77>
  803808:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80380c:	48 3d ff 07 00 08    	cmp    $0x80007ff,%rax
  803812:	0f 86 05 ff ff ff    	jbe    80371d <copy_shared_pages+0x18>
  803818:	b8 00 00 00 00       	mov    $0x0,%eax
  80381d:	c9                   	leaveq 
  80381e:	c3                   	retq   

000000000080381f <fd2sockid>:
  80381f:	55                   	push   %rbp
  803820:	48 89 e5             	mov    %rsp,%rbp
  803823:	48 83 ec 20          	sub    $0x20,%rsp
  803827:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80382a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80382e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803831:	48 89 d6             	mov    %rdx,%rsi
  803834:	89 c7                	mov    %eax,%edi
  803836:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  80383d:	00 00 00 
  803840:	ff d0                	callq  *%rax
  803842:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803845:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803849:	79 05                	jns    803850 <fd2sockid+0x31>
  80384b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80384e:	eb 24                	jmp    803874 <fd2sockid+0x55>
  803850:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803854:	8b 10                	mov    (%rax),%edx
  803856:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  80385d:	00 00 00 
  803860:	8b 00                	mov    (%rax),%eax
  803862:	39 c2                	cmp    %eax,%edx
  803864:	74 07                	je     80386d <fd2sockid+0x4e>
  803866:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80386b:	eb 07                	jmp    803874 <fd2sockid+0x55>
  80386d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803871:	8b 40 0c             	mov    0xc(%rax),%eax
  803874:	c9                   	leaveq 
  803875:	c3                   	retq   

0000000000803876 <alloc_sockfd>:
  803876:	55                   	push   %rbp
  803877:	48 89 e5             	mov    %rsp,%rbp
  80387a:	48 83 ec 20          	sub    $0x20,%rsp
  80387e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803881:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803885:	48 89 c7             	mov    %rax,%rdi
  803888:	48 b8 d8 1c 80 00 00 	movabs $0x801cd8,%rax
  80388f:	00 00 00 
  803892:	ff d0                	callq  *%rax
  803894:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803897:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80389b:	78 26                	js     8038c3 <alloc_sockfd+0x4d>
  80389d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038a1:	ba 07 04 00 00       	mov    $0x407,%edx
  8038a6:	48 89 c6             	mov    %rax,%rsi
  8038a9:	bf 00 00 00 00       	mov    $0x0,%edi
  8038ae:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8038b5:	00 00 00 
  8038b8:	ff d0                	callq  *%rax
  8038ba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038c1:	79 16                	jns    8038d9 <alloc_sockfd+0x63>
  8038c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8038c6:	89 c7                	mov    %eax,%edi
  8038c8:	48 b8 83 3d 80 00 00 	movabs $0x803d83,%rax
  8038cf:	00 00 00 
  8038d2:	ff d0                	callq  *%rax
  8038d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038d7:	eb 3a                	jmp    803913 <alloc_sockfd+0x9d>
  8038d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038dd:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8038e4:	00 00 00 
  8038e7:	8b 12                	mov    (%rdx),%edx
  8038e9:	89 10                	mov    %edx,(%rax)
  8038eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038ef:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8038f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038fa:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8038fd:	89 50 0c             	mov    %edx,0xc(%rax)
  803900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803904:	48 89 c7             	mov    %rax,%rdi
  803907:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  80390e:	00 00 00 
  803911:	ff d0                	callq  *%rax
  803913:	c9                   	leaveq 
  803914:	c3                   	retq   

0000000000803915 <accept>:
  803915:	55                   	push   %rbp
  803916:	48 89 e5             	mov    %rsp,%rbp
  803919:	48 83 ec 30          	sub    $0x30,%rsp
  80391d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803920:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803924:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803928:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80392b:	89 c7                	mov    %eax,%edi
  80392d:	48 b8 1f 38 80 00 00 	movabs $0x80381f,%rax
  803934:	00 00 00 
  803937:	ff d0                	callq  *%rax
  803939:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80393c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803940:	79 05                	jns    803947 <accept+0x32>
  803942:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803945:	eb 3b                	jmp    803982 <accept+0x6d>
  803947:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80394b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80394f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803952:	48 89 ce             	mov    %rcx,%rsi
  803955:	89 c7                	mov    %eax,%edi
  803957:	48 b8 60 3c 80 00 00 	movabs $0x803c60,%rax
  80395e:	00 00 00 
  803961:	ff d0                	callq  *%rax
  803963:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803966:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80396a:	79 05                	jns    803971 <accept+0x5c>
  80396c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80396f:	eb 11                	jmp    803982 <accept+0x6d>
  803971:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803974:	89 c7                	mov    %eax,%edi
  803976:	48 b8 76 38 80 00 00 	movabs $0x803876,%rax
  80397d:	00 00 00 
  803980:	ff d0                	callq  *%rax
  803982:	c9                   	leaveq 
  803983:	c3                   	retq   

0000000000803984 <bind>:
  803984:	55                   	push   %rbp
  803985:	48 89 e5             	mov    %rsp,%rbp
  803988:	48 83 ec 20          	sub    $0x20,%rsp
  80398c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80398f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803993:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803996:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803999:	89 c7                	mov    %eax,%edi
  80399b:	48 b8 1f 38 80 00 00 	movabs $0x80381f,%rax
  8039a2:	00 00 00 
  8039a5:	ff d0                	callq  *%rax
  8039a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039ae:	79 05                	jns    8039b5 <bind+0x31>
  8039b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039b3:	eb 1b                	jmp    8039d0 <bind+0x4c>
  8039b5:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8039b8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8039bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039bf:	48 89 ce             	mov    %rcx,%rsi
  8039c2:	89 c7                	mov    %eax,%edi
  8039c4:	48 b8 df 3c 80 00 00 	movabs $0x803cdf,%rax
  8039cb:	00 00 00 
  8039ce:	ff d0                	callq  *%rax
  8039d0:	c9                   	leaveq 
  8039d1:	c3                   	retq   

00000000008039d2 <shutdown>:
  8039d2:	55                   	push   %rbp
  8039d3:	48 89 e5             	mov    %rsp,%rbp
  8039d6:	48 83 ec 20          	sub    $0x20,%rsp
  8039da:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039dd:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8039e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039e3:	89 c7                	mov    %eax,%edi
  8039e5:	48 b8 1f 38 80 00 00 	movabs $0x80381f,%rax
  8039ec:	00 00 00 
  8039ef:	ff d0                	callq  *%rax
  8039f1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039f8:	79 05                	jns    8039ff <shutdown+0x2d>
  8039fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039fd:	eb 16                	jmp    803a15 <shutdown+0x43>
  8039ff:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803a02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a05:	89 d6                	mov    %edx,%esi
  803a07:	89 c7                	mov    %eax,%edi
  803a09:	48 b8 43 3d 80 00 00 	movabs $0x803d43,%rax
  803a10:	00 00 00 
  803a13:	ff d0                	callq  *%rax
  803a15:	c9                   	leaveq 
  803a16:	c3                   	retq   

0000000000803a17 <devsock_close>:
  803a17:	55                   	push   %rbp
  803a18:	48 89 e5             	mov    %rsp,%rbp
  803a1b:	48 83 ec 10          	sub    $0x10,%rsp
  803a1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a27:	48 89 c7             	mov    %rax,%rdi
  803a2a:	48 b8 e5 4a 80 00 00 	movabs $0x804ae5,%rax
  803a31:	00 00 00 
  803a34:	ff d0                	callq  *%rax
  803a36:	83 f8 01             	cmp    $0x1,%eax
  803a39:	75 17                	jne    803a52 <devsock_close+0x3b>
  803a3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a3f:	8b 40 0c             	mov    0xc(%rax),%eax
  803a42:	89 c7                	mov    %eax,%edi
  803a44:	48 b8 83 3d 80 00 00 	movabs $0x803d83,%rax
  803a4b:	00 00 00 
  803a4e:	ff d0                	callq  *%rax
  803a50:	eb 05                	jmp    803a57 <devsock_close+0x40>
  803a52:	b8 00 00 00 00       	mov    $0x0,%eax
  803a57:	c9                   	leaveq 
  803a58:	c3                   	retq   

0000000000803a59 <connect>:
  803a59:	55                   	push   %rbp
  803a5a:	48 89 e5             	mov    %rsp,%rbp
  803a5d:	48 83 ec 20          	sub    $0x20,%rsp
  803a61:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a64:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a68:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803a6b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a6e:	89 c7                	mov    %eax,%edi
  803a70:	48 b8 1f 38 80 00 00 	movabs $0x80381f,%rax
  803a77:	00 00 00 
  803a7a:	ff d0                	callq  *%rax
  803a7c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a83:	79 05                	jns    803a8a <connect+0x31>
  803a85:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a88:	eb 1b                	jmp    803aa5 <connect+0x4c>
  803a8a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803a8d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803a91:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a94:	48 89 ce             	mov    %rcx,%rsi
  803a97:	89 c7                	mov    %eax,%edi
  803a99:	48 b8 b0 3d 80 00 00 	movabs $0x803db0,%rax
  803aa0:	00 00 00 
  803aa3:	ff d0                	callq  *%rax
  803aa5:	c9                   	leaveq 
  803aa6:	c3                   	retq   

0000000000803aa7 <listen>:
  803aa7:	55                   	push   %rbp
  803aa8:	48 89 e5             	mov    %rsp,%rbp
  803aab:	48 83 ec 20          	sub    $0x20,%rsp
  803aaf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ab2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803ab5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ab8:	89 c7                	mov    %eax,%edi
  803aba:	48 b8 1f 38 80 00 00 	movabs $0x80381f,%rax
  803ac1:	00 00 00 
  803ac4:	ff d0                	callq  *%rax
  803ac6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ac9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803acd:	79 05                	jns    803ad4 <listen+0x2d>
  803acf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ad2:	eb 16                	jmp    803aea <listen+0x43>
  803ad4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803ad7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ada:	89 d6                	mov    %edx,%esi
  803adc:	89 c7                	mov    %eax,%edi
  803ade:	48 b8 14 3e 80 00 00 	movabs $0x803e14,%rax
  803ae5:	00 00 00 
  803ae8:	ff d0                	callq  *%rax
  803aea:	c9                   	leaveq 
  803aeb:	c3                   	retq   

0000000000803aec <devsock_read>:
  803aec:	55                   	push   %rbp
  803aed:	48 89 e5             	mov    %rsp,%rbp
  803af0:	48 83 ec 20          	sub    $0x20,%rsp
  803af4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803af8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803afc:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803b04:	89 c2                	mov    %eax,%edx
  803b06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b0a:	8b 40 0c             	mov    0xc(%rax),%eax
  803b0d:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803b11:	b9 00 00 00 00       	mov    $0x0,%ecx
  803b16:	89 c7                	mov    %eax,%edi
  803b18:	48 b8 54 3e 80 00 00 	movabs $0x803e54,%rax
  803b1f:	00 00 00 
  803b22:	ff d0                	callq  *%rax
  803b24:	c9                   	leaveq 
  803b25:	c3                   	retq   

0000000000803b26 <devsock_write>:
  803b26:	55                   	push   %rbp
  803b27:	48 89 e5             	mov    %rsp,%rbp
  803b2a:	48 83 ec 20          	sub    $0x20,%rsp
  803b2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b32:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b36:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803b3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803b3e:	89 c2                	mov    %eax,%edx
  803b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b44:	8b 40 0c             	mov    0xc(%rax),%eax
  803b47:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803b4b:	b9 00 00 00 00       	mov    $0x0,%ecx
  803b50:	89 c7                	mov    %eax,%edi
  803b52:	48 b8 20 3f 80 00 00 	movabs $0x803f20,%rax
  803b59:	00 00 00 
  803b5c:	ff d0                	callq  *%rax
  803b5e:	c9                   	leaveq 
  803b5f:	c3                   	retq   

0000000000803b60 <devsock_stat>:
  803b60:	55                   	push   %rbp
  803b61:	48 89 e5             	mov    %rsp,%rbp
  803b64:	48 83 ec 10          	sub    $0x10,%rsp
  803b68:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803b6c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803b74:	48 be f5 52 80 00 00 	movabs $0x8052f5,%rsi
  803b7b:	00 00 00 
  803b7e:	48 89 c7             	mov    %rax,%rdi
  803b81:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  803b88:	00 00 00 
  803b8b:	ff d0                	callq  *%rax
  803b8d:	b8 00 00 00 00       	mov    $0x0,%eax
  803b92:	c9                   	leaveq 
  803b93:	c3                   	retq   

0000000000803b94 <socket>:
  803b94:	55                   	push   %rbp
  803b95:	48 89 e5             	mov    %rsp,%rbp
  803b98:	48 83 ec 20          	sub    $0x20,%rsp
  803b9c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b9f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803ba2:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803ba5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803ba8:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803bab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803bae:	89 ce                	mov    %ecx,%esi
  803bb0:	89 c7                	mov    %eax,%edi
  803bb2:	48 b8 d8 3f 80 00 00 	movabs $0x803fd8,%rax
  803bb9:	00 00 00 
  803bbc:	ff d0                	callq  *%rax
  803bbe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bc1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bc5:	79 05                	jns    803bcc <socket+0x38>
  803bc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bca:	eb 11                	jmp    803bdd <socket+0x49>
  803bcc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bcf:	89 c7                	mov    %eax,%edi
  803bd1:	48 b8 76 38 80 00 00 	movabs $0x803876,%rax
  803bd8:	00 00 00 
  803bdb:	ff d0                	callq  *%rax
  803bdd:	c9                   	leaveq 
  803bde:	c3                   	retq   

0000000000803bdf <nsipc>:
  803bdf:	55                   	push   %rbp
  803be0:	48 89 e5             	mov    %rsp,%rbp
  803be3:	48 83 ec 10          	sub    $0x10,%rsp
  803be7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803bea:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803bf1:	00 00 00 
  803bf4:	8b 00                	mov    (%rax),%eax
  803bf6:	85 c0                	test   %eax,%eax
  803bf8:	75 1d                	jne    803c17 <nsipc+0x38>
  803bfa:	bf 02 00 00 00       	mov    $0x2,%edi
  803bff:	48 b8 73 4a 80 00 00 	movabs $0x804a73,%rax
  803c06:	00 00 00 
  803c09:	ff d0                	callq  *%rax
  803c0b:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  803c12:	00 00 00 
  803c15:	89 02                	mov    %eax,(%rdx)
  803c17:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803c1e:	00 00 00 
  803c21:	8b 00                	mov    (%rax),%eax
  803c23:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803c26:	b9 07 00 00 00       	mov    $0x7,%ecx
  803c2b:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803c32:	00 00 00 
  803c35:	89 c7                	mov    %eax,%edi
  803c37:	48 b8 68 49 80 00 00 	movabs $0x804968,%rax
  803c3e:	00 00 00 
  803c41:	ff d0                	callq  *%rax
  803c43:	ba 00 00 00 00       	mov    $0x0,%edx
  803c48:	be 00 00 00 00       	mov    $0x0,%esi
  803c4d:	bf 00 00 00 00       	mov    $0x0,%edi
  803c52:	48 b8 a7 48 80 00 00 	movabs $0x8048a7,%rax
  803c59:	00 00 00 
  803c5c:	ff d0                	callq  *%rax
  803c5e:	c9                   	leaveq 
  803c5f:	c3                   	retq   

0000000000803c60 <nsipc_accept>:
  803c60:	55                   	push   %rbp
  803c61:	48 89 e5             	mov    %rsp,%rbp
  803c64:	48 83 ec 30          	sub    $0x30,%rsp
  803c68:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c6b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c6f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803c73:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c7a:	00 00 00 
  803c7d:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803c80:	89 10                	mov    %edx,(%rax)
  803c82:	bf 01 00 00 00       	mov    $0x1,%edi
  803c87:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803c8e:	00 00 00 
  803c91:	ff d0                	callq  *%rax
  803c93:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c96:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c9a:	78 3e                	js     803cda <nsipc_accept+0x7a>
  803c9c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ca3:	00 00 00 
  803ca6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cae:	8b 40 10             	mov    0x10(%rax),%eax
  803cb1:	89 c2                	mov    %eax,%edx
  803cb3:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803cb7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803cbb:	48 89 ce             	mov    %rcx,%rsi
  803cbe:	48 89 c7             	mov    %rax,%rdi
  803cc1:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  803cc8:	00 00 00 
  803ccb:	ff d0                	callq  *%rax
  803ccd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803cd1:	8b 50 10             	mov    0x10(%rax),%edx
  803cd4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803cd8:	89 10                	mov    %edx,(%rax)
  803cda:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cdd:	c9                   	leaveq 
  803cde:	c3                   	retq   

0000000000803cdf <nsipc_bind>:
  803cdf:	55                   	push   %rbp
  803ce0:	48 89 e5             	mov    %rsp,%rbp
  803ce3:	48 83 ec 10          	sub    $0x10,%rsp
  803ce7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cea:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cee:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803cf1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cf8:	00 00 00 
  803cfb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803cfe:	89 10                	mov    %edx,(%rax)
  803d00:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d07:	48 89 c6             	mov    %rax,%rsi
  803d0a:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803d11:	00 00 00 
  803d14:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  803d1b:	00 00 00 
  803d1e:	ff d0                	callq  *%rax
  803d20:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d27:	00 00 00 
  803d2a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d2d:	89 50 14             	mov    %edx,0x14(%rax)
  803d30:	bf 02 00 00 00       	mov    $0x2,%edi
  803d35:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803d3c:	00 00 00 
  803d3f:	ff d0                	callq  *%rax
  803d41:	c9                   	leaveq 
  803d42:	c3                   	retq   

0000000000803d43 <nsipc_shutdown>:
  803d43:	55                   	push   %rbp
  803d44:	48 89 e5             	mov    %rsp,%rbp
  803d47:	48 83 ec 10          	sub    $0x10,%rsp
  803d4b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d4e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803d51:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d58:	00 00 00 
  803d5b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d5e:	89 10                	mov    %edx,(%rax)
  803d60:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d67:	00 00 00 
  803d6a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d6d:	89 50 04             	mov    %edx,0x4(%rax)
  803d70:	bf 03 00 00 00       	mov    $0x3,%edi
  803d75:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803d7c:	00 00 00 
  803d7f:	ff d0                	callq  *%rax
  803d81:	c9                   	leaveq 
  803d82:	c3                   	retq   

0000000000803d83 <nsipc_close>:
  803d83:	55                   	push   %rbp
  803d84:	48 89 e5             	mov    %rsp,%rbp
  803d87:	48 83 ec 10          	sub    $0x10,%rsp
  803d8b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d8e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d95:	00 00 00 
  803d98:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d9b:	89 10                	mov    %edx,(%rax)
  803d9d:	bf 04 00 00 00       	mov    $0x4,%edi
  803da2:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803da9:	00 00 00 
  803dac:	ff d0                	callq  *%rax
  803dae:	c9                   	leaveq 
  803daf:	c3                   	retq   

0000000000803db0 <nsipc_connect>:
  803db0:	55                   	push   %rbp
  803db1:	48 89 e5             	mov    %rsp,%rbp
  803db4:	48 83 ec 10          	sub    $0x10,%rsp
  803db8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803dbb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803dbf:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803dc2:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dc9:	00 00 00 
  803dcc:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803dcf:	89 10                	mov    %edx,(%rax)
  803dd1:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803dd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803dd8:	48 89 c6             	mov    %rax,%rsi
  803ddb:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803de2:	00 00 00 
  803de5:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  803dec:	00 00 00 
  803def:	ff d0                	callq  *%rax
  803df1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803df8:	00 00 00 
  803dfb:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803dfe:	89 50 14             	mov    %edx,0x14(%rax)
  803e01:	bf 05 00 00 00       	mov    $0x5,%edi
  803e06:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803e0d:	00 00 00 
  803e10:	ff d0                	callq  *%rax
  803e12:	c9                   	leaveq 
  803e13:	c3                   	retq   

0000000000803e14 <nsipc_listen>:
  803e14:	55                   	push   %rbp
  803e15:	48 89 e5             	mov    %rsp,%rbp
  803e18:	48 83 ec 10          	sub    $0x10,%rsp
  803e1c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e1f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803e22:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e29:	00 00 00 
  803e2c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803e2f:	89 10                	mov    %edx,(%rax)
  803e31:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e38:	00 00 00 
  803e3b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e3e:	89 50 04             	mov    %edx,0x4(%rax)
  803e41:	bf 06 00 00 00       	mov    $0x6,%edi
  803e46:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803e4d:	00 00 00 
  803e50:	ff d0                	callq  *%rax
  803e52:	c9                   	leaveq 
  803e53:	c3                   	retq   

0000000000803e54 <nsipc_recv>:
  803e54:	55                   	push   %rbp
  803e55:	48 89 e5             	mov    %rsp,%rbp
  803e58:	48 83 ec 30          	sub    $0x30,%rsp
  803e5c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e5f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803e63:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803e66:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803e69:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e70:	00 00 00 
  803e73:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803e76:	89 10                	mov    %edx,(%rax)
  803e78:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e7f:	00 00 00 
  803e82:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803e85:	89 50 04             	mov    %edx,0x4(%rax)
  803e88:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e8f:	00 00 00 
  803e92:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803e95:	89 50 08             	mov    %edx,0x8(%rax)
  803e98:	bf 07 00 00 00       	mov    $0x7,%edi
  803e9d:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803ea4:	00 00 00 
  803ea7:	ff d0                	callq  *%rax
  803ea9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803eac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803eb0:	78 69                	js     803f1b <nsipc_recv+0xc7>
  803eb2:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803eb9:	7f 08                	jg     803ec3 <nsipc_recv+0x6f>
  803ebb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ebe:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803ec1:	7e 35                	jle    803ef8 <nsipc_recv+0xa4>
  803ec3:	48 b9 fc 52 80 00 00 	movabs $0x8052fc,%rcx
  803eca:	00 00 00 
  803ecd:	48 ba 11 53 80 00 00 	movabs $0x805311,%rdx
  803ed4:	00 00 00 
  803ed7:	be 62 00 00 00       	mov    $0x62,%esi
  803edc:	48 bf 26 53 80 00 00 	movabs $0x805326,%rdi
  803ee3:	00 00 00 
  803ee6:	b8 00 00 00 00       	mov    $0x0,%eax
  803eeb:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  803ef2:	00 00 00 
  803ef5:	41 ff d0             	callq  *%r8
  803ef8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803efb:	48 63 d0             	movslq %eax,%rdx
  803efe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f02:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803f09:	00 00 00 
  803f0c:	48 89 c7             	mov    %rax,%rdi
  803f0f:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  803f16:	00 00 00 
  803f19:	ff d0                	callq  *%rax
  803f1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f1e:	c9                   	leaveq 
  803f1f:	c3                   	retq   

0000000000803f20 <nsipc_send>:
  803f20:	55                   	push   %rbp
  803f21:	48 89 e5             	mov    %rsp,%rbp
  803f24:	48 83 ec 20          	sub    $0x20,%rsp
  803f28:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f2b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803f2f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803f32:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803f35:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f3c:	00 00 00 
  803f3f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f42:	89 10                	mov    %edx,(%rax)
  803f44:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803f4b:	7e 35                	jle    803f82 <nsipc_send+0x62>
  803f4d:	48 b9 35 53 80 00 00 	movabs $0x805335,%rcx
  803f54:	00 00 00 
  803f57:	48 ba 11 53 80 00 00 	movabs $0x805311,%rdx
  803f5e:	00 00 00 
  803f61:	be 6d 00 00 00       	mov    $0x6d,%esi
  803f66:	48 bf 26 53 80 00 00 	movabs $0x805326,%rdi
  803f6d:	00 00 00 
  803f70:	b8 00 00 00 00       	mov    $0x0,%eax
  803f75:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  803f7c:	00 00 00 
  803f7f:	41 ff d0             	callq  *%r8
  803f82:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803f85:	48 63 d0             	movslq %eax,%rdx
  803f88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f8c:	48 89 c6             	mov    %rax,%rsi
  803f8f:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803f96:	00 00 00 
  803f99:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  803fa0:	00 00 00 
  803fa3:	ff d0                	callq  *%rax
  803fa5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fac:	00 00 00 
  803faf:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803fb2:	89 50 04             	mov    %edx,0x4(%rax)
  803fb5:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fbc:	00 00 00 
  803fbf:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803fc2:	89 50 08             	mov    %edx,0x8(%rax)
  803fc5:	bf 08 00 00 00       	mov    $0x8,%edi
  803fca:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  803fd1:	00 00 00 
  803fd4:	ff d0                	callq  *%rax
  803fd6:	c9                   	leaveq 
  803fd7:	c3                   	retq   

0000000000803fd8 <nsipc_socket>:
  803fd8:	55                   	push   %rbp
  803fd9:	48 89 e5             	mov    %rsp,%rbp
  803fdc:	48 83 ec 10          	sub    $0x10,%rsp
  803fe0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803fe3:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803fe6:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803fe9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ff0:	00 00 00 
  803ff3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ff6:	89 10                	mov    %edx,(%rax)
  803ff8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fff:	00 00 00 
  804002:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804005:	89 50 04             	mov    %edx,0x4(%rax)
  804008:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80400f:	00 00 00 
  804012:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804015:	89 50 08             	mov    %edx,0x8(%rax)
  804018:	bf 09 00 00 00       	mov    $0x9,%edi
  80401d:	48 b8 df 3b 80 00 00 	movabs $0x803bdf,%rax
  804024:	00 00 00 
  804027:	ff d0                	callq  *%rax
  804029:	c9                   	leaveq 
  80402a:	c3                   	retq   

000000000080402b <pipe>:
  80402b:	55                   	push   %rbp
  80402c:	48 89 e5             	mov    %rsp,%rbp
  80402f:	53                   	push   %rbx
  804030:	48 83 ec 38          	sub    $0x38,%rsp
  804034:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  804038:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  80403c:	48 89 c7             	mov    %rax,%rdi
  80403f:	48 b8 d8 1c 80 00 00 	movabs $0x801cd8,%rax
  804046:	00 00 00 
  804049:	ff d0                	callq  *%rax
  80404b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80404e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804052:	0f 88 bf 01 00 00    	js     804217 <pipe+0x1ec>
  804058:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80405c:	ba 07 04 00 00       	mov    $0x407,%edx
  804061:	48 89 c6             	mov    %rax,%rsi
  804064:	bf 00 00 00 00       	mov    $0x0,%edi
  804069:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  804070:	00 00 00 
  804073:	ff d0                	callq  *%rax
  804075:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804078:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80407c:	0f 88 95 01 00 00    	js     804217 <pipe+0x1ec>
  804082:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804086:	48 89 c7             	mov    %rax,%rdi
  804089:	48 b8 d8 1c 80 00 00 	movabs $0x801cd8,%rax
  804090:	00 00 00 
  804093:	ff d0                	callq  *%rax
  804095:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804098:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80409c:	0f 88 5d 01 00 00    	js     8041ff <pipe+0x1d4>
  8040a2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8040a6:	ba 07 04 00 00       	mov    $0x407,%edx
  8040ab:	48 89 c6             	mov    %rax,%rsi
  8040ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8040b3:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8040ba:	00 00 00 
  8040bd:	ff d0                	callq  *%rax
  8040bf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8040c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8040c6:	0f 88 33 01 00 00    	js     8041ff <pipe+0x1d4>
  8040cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8040d0:	48 89 c7             	mov    %rax,%rdi
  8040d3:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  8040da:	00 00 00 
  8040dd:	ff d0                	callq  *%rax
  8040df:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8040e3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8040e7:	ba 07 04 00 00       	mov    $0x407,%edx
  8040ec:	48 89 c6             	mov    %rax,%rsi
  8040ef:	bf 00 00 00 00       	mov    $0x0,%edi
  8040f4:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8040fb:	00 00 00 
  8040fe:	ff d0                	callq  *%rax
  804100:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804103:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804107:	79 05                	jns    80410e <pipe+0xe3>
  804109:	e9 d9 00 00 00       	jmpq   8041e7 <pipe+0x1bc>
  80410e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804112:	48 89 c7             	mov    %rax,%rdi
  804115:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  80411c:	00 00 00 
  80411f:	ff d0                	callq  *%rax
  804121:	48 89 c2             	mov    %rax,%rdx
  804124:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804128:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  80412e:	48 89 d1             	mov    %rdx,%rcx
  804131:	ba 00 00 00 00       	mov    $0x0,%edx
  804136:	48 89 c6             	mov    %rax,%rsi
  804139:	bf 00 00 00 00       	mov    $0x0,%edi
  80413e:	48 b8 fa 18 80 00 00 	movabs $0x8018fa,%rax
  804145:	00 00 00 
  804148:	ff d0                	callq  *%rax
  80414a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80414d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804151:	79 1b                	jns    80416e <pipe+0x143>
  804153:	90                   	nop
  804154:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804158:	48 89 c6             	mov    %rax,%rsi
  80415b:	bf 00 00 00 00       	mov    $0x0,%edi
  804160:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  804167:	00 00 00 
  80416a:	ff d0                	callq  *%rax
  80416c:	eb 79                	jmp    8041e7 <pipe+0x1bc>
  80416e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804172:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804179:	00 00 00 
  80417c:	8b 12                	mov    (%rdx),%edx
  80417e:	89 10                	mov    %edx,(%rax)
  804180:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804184:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80418b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80418f:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804196:	00 00 00 
  804199:	8b 12                	mov    (%rdx),%edx
  80419b:	89 10                	mov    %edx,(%rax)
  80419d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041a1:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8041a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8041ac:	48 89 c7             	mov    %rax,%rdi
  8041af:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  8041b6:	00 00 00 
  8041b9:	ff d0                	callq  *%rax
  8041bb:	89 c2                	mov    %eax,%edx
  8041bd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8041c1:	89 10                	mov    %edx,(%rax)
  8041c3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8041c7:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8041cb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041cf:	48 89 c7             	mov    %rax,%rdi
  8041d2:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  8041d9:	00 00 00 
  8041dc:	ff d0                	callq  *%rax
  8041de:	89 03                	mov    %eax,(%rbx)
  8041e0:	b8 00 00 00 00       	mov    $0x0,%eax
  8041e5:	eb 33                	jmp    80421a <pipe+0x1ef>
  8041e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8041eb:	48 89 c6             	mov    %rax,%rsi
  8041ee:	bf 00 00 00 00       	mov    $0x0,%edi
  8041f3:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  8041fa:	00 00 00 
  8041fd:	ff d0                	callq  *%rax
  8041ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804203:	48 89 c6             	mov    %rax,%rsi
  804206:	bf 00 00 00 00       	mov    $0x0,%edi
  80420b:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  804212:	00 00 00 
  804215:	ff d0                	callq  *%rax
  804217:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80421a:	48 83 c4 38          	add    $0x38,%rsp
  80421e:	5b                   	pop    %rbx
  80421f:	5d                   	pop    %rbp
  804220:	c3                   	retq   

0000000000804221 <_pipeisclosed>:
  804221:	55                   	push   %rbp
  804222:	48 89 e5             	mov    %rsp,%rbp
  804225:	53                   	push   %rbx
  804226:	48 83 ec 28          	sub    $0x28,%rsp
  80422a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80422e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804232:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804239:	00 00 00 
  80423c:	48 8b 00             	mov    (%rax),%rax
  80423f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804245:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804248:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80424c:	48 89 c7             	mov    %rax,%rdi
  80424f:	48 b8 e5 4a 80 00 00 	movabs $0x804ae5,%rax
  804256:	00 00 00 
  804259:	ff d0                	callq  *%rax
  80425b:	89 c3                	mov    %eax,%ebx
  80425d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804261:	48 89 c7             	mov    %rax,%rdi
  804264:	48 b8 e5 4a 80 00 00 	movabs $0x804ae5,%rax
  80426b:	00 00 00 
  80426e:	ff d0                	callq  *%rax
  804270:	39 c3                	cmp    %eax,%ebx
  804272:	0f 94 c0             	sete   %al
  804275:	0f b6 c0             	movzbl %al,%eax
  804278:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80427b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804282:	00 00 00 
  804285:	48 8b 00             	mov    (%rax),%rax
  804288:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80428e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804291:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804294:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804297:	75 05                	jne    80429e <_pipeisclosed+0x7d>
  804299:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80429c:	eb 4f                	jmp    8042ed <_pipeisclosed+0xcc>
  80429e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042a1:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8042a4:	74 42                	je     8042e8 <_pipeisclosed+0xc7>
  8042a6:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8042aa:	75 3c                	jne    8042e8 <_pipeisclosed+0xc7>
  8042ac:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8042b3:	00 00 00 
  8042b6:	48 8b 00             	mov    (%rax),%rax
  8042b9:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  8042bf:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8042c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042c5:	89 c6                	mov    %eax,%esi
  8042c7:	48 bf 46 53 80 00 00 	movabs $0x805346,%rdi
  8042ce:	00 00 00 
  8042d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8042d6:	49 b8 c6 03 80 00 00 	movabs $0x8003c6,%r8
  8042dd:	00 00 00 
  8042e0:	41 ff d0             	callq  *%r8
  8042e3:	e9 4a ff ff ff       	jmpq   804232 <_pipeisclosed+0x11>
  8042e8:	e9 45 ff ff ff       	jmpq   804232 <_pipeisclosed+0x11>
  8042ed:	48 83 c4 28          	add    $0x28,%rsp
  8042f1:	5b                   	pop    %rbx
  8042f2:	5d                   	pop    %rbp
  8042f3:	c3                   	retq   

00000000008042f4 <pipeisclosed>:
  8042f4:	55                   	push   %rbp
  8042f5:	48 89 e5             	mov    %rsp,%rbp
  8042f8:	48 83 ec 30          	sub    $0x30,%rsp
  8042fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8042ff:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  804303:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804306:	48 89 d6             	mov    %rdx,%rsi
  804309:	89 c7                	mov    %eax,%edi
  80430b:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  804312:	00 00 00 
  804315:	ff d0                	callq  *%rax
  804317:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80431a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80431e:	79 05                	jns    804325 <pipeisclosed+0x31>
  804320:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804323:	eb 31                	jmp    804356 <pipeisclosed+0x62>
  804325:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804329:	48 89 c7             	mov    %rax,%rdi
  80432c:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  804333:	00 00 00 
  804336:	ff d0                	callq  *%rax
  804338:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80433c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804340:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804344:	48 89 d6             	mov    %rdx,%rsi
  804347:	48 89 c7             	mov    %rax,%rdi
  80434a:	48 b8 21 42 80 00 00 	movabs $0x804221,%rax
  804351:	00 00 00 
  804354:	ff d0                	callq  *%rax
  804356:	c9                   	leaveq 
  804357:	c3                   	retq   

0000000000804358 <devpipe_read>:
  804358:	55                   	push   %rbp
  804359:	48 89 e5             	mov    %rsp,%rbp
  80435c:	48 83 ec 40          	sub    $0x40,%rsp
  804360:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804364:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804368:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80436c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804370:	48 89 c7             	mov    %rax,%rdi
  804373:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  80437a:	00 00 00 
  80437d:	ff d0                	callq  *%rax
  80437f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804383:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804387:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80438b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804392:	00 
  804393:	e9 92 00 00 00       	jmpq   80442a <devpipe_read+0xd2>
  804398:	eb 41                	jmp    8043db <devpipe_read+0x83>
  80439a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80439f:	74 09                	je     8043aa <devpipe_read+0x52>
  8043a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043a5:	e9 92 00 00 00       	jmpq   80443c <devpipe_read+0xe4>
  8043aa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8043ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043b2:	48 89 d6             	mov    %rdx,%rsi
  8043b5:	48 89 c7             	mov    %rax,%rdi
  8043b8:	48 b8 21 42 80 00 00 	movabs $0x804221,%rax
  8043bf:	00 00 00 
  8043c2:	ff d0                	callq  *%rax
  8043c4:	85 c0                	test   %eax,%eax
  8043c6:	74 07                	je     8043cf <devpipe_read+0x77>
  8043c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8043cd:	eb 6d                	jmp    80443c <devpipe_read+0xe4>
  8043cf:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  8043d6:	00 00 00 
  8043d9:	ff d0                	callq  *%rax
  8043db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043df:	8b 10                	mov    (%rax),%edx
  8043e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043e5:	8b 40 04             	mov    0x4(%rax),%eax
  8043e8:	39 c2                	cmp    %eax,%edx
  8043ea:	74 ae                	je     80439a <devpipe_read+0x42>
  8043ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043f0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8043f4:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8043f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043fc:	8b 00                	mov    (%rax),%eax
  8043fe:	99                   	cltd   
  8043ff:	c1 ea 1b             	shr    $0x1b,%edx
  804402:	01 d0                	add    %edx,%eax
  804404:	83 e0 1f             	and    $0x1f,%eax
  804407:	29 d0                	sub    %edx,%eax
  804409:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80440d:	48 98                	cltq   
  80440f:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  804414:	88 01                	mov    %al,(%rcx)
  804416:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80441a:	8b 00                	mov    (%rax),%eax
  80441c:	8d 50 01             	lea    0x1(%rax),%edx
  80441f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804423:	89 10                	mov    %edx,(%rax)
  804425:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80442a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80442e:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804432:	0f 82 60 ff ff ff    	jb     804398 <devpipe_read+0x40>
  804438:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80443c:	c9                   	leaveq 
  80443d:	c3                   	retq   

000000000080443e <devpipe_write>:
  80443e:	55                   	push   %rbp
  80443f:	48 89 e5             	mov    %rsp,%rbp
  804442:	48 83 ec 40          	sub    $0x40,%rsp
  804446:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80444a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80444e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804452:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804456:	48 89 c7             	mov    %rax,%rdi
  804459:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  804460:	00 00 00 
  804463:	ff d0                	callq  *%rax
  804465:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804469:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80446d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804471:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804478:	00 
  804479:	e9 8e 00 00 00       	jmpq   80450c <devpipe_write+0xce>
  80447e:	eb 31                	jmp    8044b1 <devpipe_write+0x73>
  804480:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804484:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804488:	48 89 d6             	mov    %rdx,%rsi
  80448b:	48 89 c7             	mov    %rax,%rdi
  80448e:	48 b8 21 42 80 00 00 	movabs $0x804221,%rax
  804495:	00 00 00 
  804498:	ff d0                	callq  *%rax
  80449a:	85 c0                	test   %eax,%eax
  80449c:	74 07                	je     8044a5 <devpipe_write+0x67>
  80449e:	b8 00 00 00 00       	mov    $0x0,%eax
  8044a3:	eb 79                	jmp    80451e <devpipe_write+0xe0>
  8044a5:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  8044ac:	00 00 00 
  8044af:	ff d0                	callq  *%rax
  8044b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044b5:	8b 40 04             	mov    0x4(%rax),%eax
  8044b8:	48 63 d0             	movslq %eax,%rdx
  8044bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044bf:	8b 00                	mov    (%rax),%eax
  8044c1:	48 98                	cltq   
  8044c3:	48 83 c0 20          	add    $0x20,%rax
  8044c7:	48 39 c2             	cmp    %rax,%rdx
  8044ca:	73 b4                	jae    804480 <devpipe_write+0x42>
  8044cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044d0:	8b 40 04             	mov    0x4(%rax),%eax
  8044d3:	99                   	cltd   
  8044d4:	c1 ea 1b             	shr    $0x1b,%edx
  8044d7:	01 d0                	add    %edx,%eax
  8044d9:	83 e0 1f             	and    $0x1f,%eax
  8044dc:	29 d0                	sub    %edx,%eax
  8044de:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8044e2:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8044e6:	48 01 ca             	add    %rcx,%rdx
  8044e9:	0f b6 0a             	movzbl (%rdx),%ecx
  8044ec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8044f0:	48 98                	cltq   
  8044f2:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8044f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044fa:	8b 40 04             	mov    0x4(%rax),%eax
  8044fd:	8d 50 01             	lea    0x1(%rax),%edx
  804500:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804504:	89 50 04             	mov    %edx,0x4(%rax)
  804507:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80450c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804510:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804514:	0f 82 64 ff ff ff    	jb     80447e <devpipe_write+0x40>
  80451a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80451e:	c9                   	leaveq 
  80451f:	c3                   	retq   

0000000000804520 <devpipe_stat>:
  804520:	55                   	push   %rbp
  804521:	48 89 e5             	mov    %rsp,%rbp
  804524:	48 83 ec 20          	sub    $0x20,%rsp
  804528:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80452c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804530:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804534:	48 89 c7             	mov    %rax,%rdi
  804537:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  80453e:	00 00 00 
  804541:	ff d0                	callq  *%rax
  804543:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804547:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80454b:	48 be 59 53 80 00 00 	movabs $0x805359,%rsi
  804552:	00 00 00 
  804555:	48 89 c7             	mov    %rax,%rdi
  804558:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  80455f:	00 00 00 
  804562:	ff d0                	callq  *%rax
  804564:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804568:	8b 50 04             	mov    0x4(%rax),%edx
  80456b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80456f:	8b 00                	mov    (%rax),%eax
  804571:	29 c2                	sub    %eax,%edx
  804573:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804577:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80457d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804581:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804588:	00 00 00 
  80458b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80458f:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804596:	00 00 00 
  804599:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  8045a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8045a5:	c9                   	leaveq 
  8045a6:	c3                   	retq   

00000000008045a7 <devpipe_close>:
  8045a7:	55                   	push   %rbp
  8045a8:	48 89 e5             	mov    %rsp,%rbp
  8045ab:	48 83 ec 10          	sub    $0x10,%rsp
  8045af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8045b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045b7:	48 89 c6             	mov    %rax,%rsi
  8045ba:	bf 00 00 00 00       	mov    $0x0,%edi
  8045bf:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  8045c6:	00 00 00 
  8045c9:	ff d0                	callq  *%rax
  8045cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045cf:	48 89 c7             	mov    %rax,%rdi
  8045d2:	48 b8 ad 1c 80 00 00 	movabs $0x801cad,%rax
  8045d9:	00 00 00 
  8045dc:	ff d0                	callq  *%rax
  8045de:	48 89 c6             	mov    %rax,%rsi
  8045e1:	bf 00 00 00 00       	mov    $0x0,%edi
  8045e6:	48 b8 55 19 80 00 00 	movabs $0x801955,%rax
  8045ed:	00 00 00 
  8045f0:	ff d0                	callq  *%rax
  8045f2:	c9                   	leaveq 
  8045f3:	c3                   	retq   

00000000008045f4 <cputchar>:
  8045f4:	55                   	push   %rbp
  8045f5:	48 89 e5             	mov    %rsp,%rbp
  8045f8:	48 83 ec 20          	sub    $0x20,%rsp
  8045fc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8045ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804602:	88 45 ff             	mov    %al,-0x1(%rbp)
  804605:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  804609:	be 01 00 00 00       	mov    $0x1,%esi
  80460e:	48 89 c7             	mov    %rax,%rdi
  804611:	48 b8 62 17 80 00 00 	movabs $0x801762,%rax
  804618:	00 00 00 
  80461b:	ff d0                	callq  *%rax
  80461d:	c9                   	leaveq 
  80461e:	c3                   	retq   

000000000080461f <getchar>:
  80461f:	55                   	push   %rbp
  804620:	48 89 e5             	mov    %rsp,%rbp
  804623:	48 83 ec 10          	sub    $0x10,%rsp
  804627:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  80462b:	ba 01 00 00 00       	mov    $0x1,%edx
  804630:	48 89 c6             	mov    %rax,%rsi
  804633:	bf 00 00 00 00       	mov    $0x0,%edi
  804638:	48 b8 a2 21 80 00 00 	movabs $0x8021a2,%rax
  80463f:	00 00 00 
  804642:	ff d0                	callq  *%rax
  804644:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804647:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80464b:	79 05                	jns    804652 <getchar+0x33>
  80464d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804650:	eb 14                	jmp    804666 <getchar+0x47>
  804652:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804656:	7f 07                	jg     80465f <getchar+0x40>
  804658:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80465d:	eb 07                	jmp    804666 <getchar+0x47>
  80465f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804663:	0f b6 c0             	movzbl %al,%eax
  804666:	c9                   	leaveq 
  804667:	c3                   	retq   

0000000000804668 <iscons>:
  804668:	55                   	push   %rbp
  804669:	48 89 e5             	mov    %rsp,%rbp
  80466c:	48 83 ec 20          	sub    $0x20,%rsp
  804670:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804673:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804677:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80467a:	48 89 d6             	mov    %rdx,%rsi
  80467d:	89 c7                	mov    %eax,%edi
  80467f:	48 b8 70 1d 80 00 00 	movabs $0x801d70,%rax
  804686:	00 00 00 
  804689:	ff d0                	callq  *%rax
  80468b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80468e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804692:	79 05                	jns    804699 <iscons+0x31>
  804694:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804697:	eb 1a                	jmp    8046b3 <iscons+0x4b>
  804699:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80469d:	8b 10                	mov    (%rax),%edx
  80469f:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  8046a6:	00 00 00 
  8046a9:	8b 00                	mov    (%rax),%eax
  8046ab:	39 c2                	cmp    %eax,%edx
  8046ad:	0f 94 c0             	sete   %al
  8046b0:	0f b6 c0             	movzbl %al,%eax
  8046b3:	c9                   	leaveq 
  8046b4:	c3                   	retq   

00000000008046b5 <opencons>:
  8046b5:	55                   	push   %rbp
  8046b6:	48 89 e5             	mov    %rsp,%rbp
  8046b9:	48 83 ec 10          	sub    $0x10,%rsp
  8046bd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8046c1:	48 89 c7             	mov    %rax,%rdi
  8046c4:	48 b8 d8 1c 80 00 00 	movabs $0x801cd8,%rax
  8046cb:	00 00 00 
  8046ce:	ff d0                	callq  *%rax
  8046d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046d7:	79 05                	jns    8046de <opencons+0x29>
  8046d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046dc:	eb 5b                	jmp    804739 <opencons+0x84>
  8046de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046e2:	ba 07 04 00 00       	mov    $0x407,%edx
  8046e7:	48 89 c6             	mov    %rax,%rsi
  8046ea:	bf 00 00 00 00       	mov    $0x0,%edi
  8046ef:	48 b8 aa 18 80 00 00 	movabs $0x8018aa,%rax
  8046f6:	00 00 00 
  8046f9:	ff d0                	callq  *%rax
  8046fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804702:	79 05                	jns    804709 <opencons+0x54>
  804704:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804707:	eb 30                	jmp    804739 <opencons+0x84>
  804709:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80470d:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  804714:	00 00 00 
  804717:	8b 12                	mov    (%rdx),%edx
  804719:	89 10                	mov    %edx,(%rax)
  80471b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80471f:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  804726:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80472a:	48 89 c7             	mov    %rax,%rdi
  80472d:	48 b8 8a 1c 80 00 00 	movabs $0x801c8a,%rax
  804734:	00 00 00 
  804737:	ff d0                	callq  *%rax
  804739:	c9                   	leaveq 
  80473a:	c3                   	retq   

000000000080473b <devcons_read>:
  80473b:	55                   	push   %rbp
  80473c:	48 89 e5             	mov    %rsp,%rbp
  80473f:	48 83 ec 30          	sub    $0x30,%rsp
  804743:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804747:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80474b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80474f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804754:	75 07                	jne    80475d <devcons_read+0x22>
  804756:	b8 00 00 00 00       	mov    $0x0,%eax
  80475b:	eb 4b                	jmp    8047a8 <devcons_read+0x6d>
  80475d:	eb 0c                	jmp    80476b <devcons_read+0x30>
  80475f:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  804766:	00 00 00 
  804769:	ff d0                	callq  *%rax
  80476b:	48 b8 ac 17 80 00 00 	movabs $0x8017ac,%rax
  804772:	00 00 00 
  804775:	ff d0                	callq  *%rax
  804777:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80477a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80477e:	74 df                	je     80475f <devcons_read+0x24>
  804780:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804784:	79 05                	jns    80478b <devcons_read+0x50>
  804786:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804789:	eb 1d                	jmp    8047a8 <devcons_read+0x6d>
  80478b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80478f:	75 07                	jne    804798 <devcons_read+0x5d>
  804791:	b8 00 00 00 00       	mov    $0x0,%eax
  804796:	eb 10                	jmp    8047a8 <devcons_read+0x6d>
  804798:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80479b:	89 c2                	mov    %eax,%edx
  80479d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047a1:	88 10                	mov    %dl,(%rax)
  8047a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8047a8:	c9                   	leaveq 
  8047a9:	c3                   	retq   

00000000008047aa <devcons_write>:
  8047aa:	55                   	push   %rbp
  8047ab:	48 89 e5             	mov    %rsp,%rbp
  8047ae:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  8047b5:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8047bc:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8047c3:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8047ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8047d1:	eb 76                	jmp    804849 <devcons_write+0x9f>
  8047d3:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8047da:	89 c2                	mov    %eax,%edx
  8047dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047df:	29 c2                	sub    %eax,%edx
  8047e1:	89 d0                	mov    %edx,%eax
  8047e3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8047e6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047e9:	83 f8 7f             	cmp    $0x7f,%eax
  8047ec:	76 07                	jbe    8047f5 <devcons_write+0x4b>
  8047ee:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8047f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8047f8:	48 63 d0             	movslq %eax,%rdx
  8047fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047fe:	48 63 c8             	movslq %eax,%rcx
  804801:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804808:	48 01 c1             	add    %rax,%rcx
  80480b:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804812:	48 89 ce             	mov    %rcx,%rsi
  804815:	48 89 c7             	mov    %rax,%rdi
  804818:	48 b8 9f 12 80 00 00 	movabs $0x80129f,%rax
  80481f:	00 00 00 
  804822:	ff d0                	callq  *%rax
  804824:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804827:	48 63 d0             	movslq %eax,%rdx
  80482a:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804831:	48 89 d6             	mov    %rdx,%rsi
  804834:	48 89 c7             	mov    %rax,%rdi
  804837:	48 b8 62 17 80 00 00 	movabs $0x801762,%rax
  80483e:	00 00 00 
  804841:	ff d0                	callq  *%rax
  804843:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804846:	01 45 fc             	add    %eax,-0x4(%rbp)
  804849:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80484c:	48 98                	cltq   
  80484e:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804855:	0f 82 78 ff ff ff    	jb     8047d3 <devcons_write+0x29>
  80485b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80485e:	c9                   	leaveq 
  80485f:	c3                   	retq   

0000000000804860 <devcons_close>:
  804860:	55                   	push   %rbp
  804861:	48 89 e5             	mov    %rsp,%rbp
  804864:	48 83 ec 08          	sub    $0x8,%rsp
  804868:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80486c:	b8 00 00 00 00       	mov    $0x0,%eax
  804871:	c9                   	leaveq 
  804872:	c3                   	retq   

0000000000804873 <devcons_stat>:
  804873:	55                   	push   %rbp
  804874:	48 89 e5             	mov    %rsp,%rbp
  804877:	48 83 ec 10          	sub    $0x10,%rsp
  80487b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80487f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804883:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804887:	48 be 65 53 80 00 00 	movabs $0x805365,%rsi
  80488e:	00 00 00 
  804891:	48 89 c7             	mov    %rax,%rdi
  804894:	48 b8 7b 0f 80 00 00 	movabs $0x800f7b,%rax
  80489b:	00 00 00 
  80489e:	ff d0                	callq  *%rax
  8048a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8048a5:	c9                   	leaveq 
  8048a6:	c3                   	retq   

00000000008048a7 <ipc_recv>:
  8048a7:	55                   	push   %rbp
  8048a8:	48 89 e5             	mov    %rsp,%rbp
  8048ab:	48 83 ec 30          	sub    $0x30,%rsp
  8048af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8048b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8048b7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8048bb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8048c0:	75 0e                	jne    8048d0 <ipc_recv+0x29>
  8048c2:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8048c9:	00 00 00 
  8048cc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8048d0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8048d4:	48 89 c7             	mov    %rax,%rdi
  8048d7:	48 b8 d3 1a 80 00 00 	movabs $0x801ad3,%rax
  8048de:	00 00 00 
  8048e1:	ff d0                	callq  *%rax
  8048e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048ea:	79 27                	jns    804913 <ipc_recv+0x6c>
  8048ec:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8048f1:	74 0a                	je     8048fd <ipc_recv+0x56>
  8048f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8048f7:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8048fd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804902:	74 0a                	je     80490e <ipc_recv+0x67>
  804904:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804908:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80490e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804911:	eb 53                	jmp    804966 <ipc_recv+0xbf>
  804913:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804918:	74 19                	je     804933 <ipc_recv+0x8c>
  80491a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804921:	00 00 00 
  804924:	48 8b 00             	mov    (%rax),%rax
  804927:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80492d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804931:	89 10                	mov    %edx,(%rax)
  804933:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804938:	74 19                	je     804953 <ipc_recv+0xac>
  80493a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804941:	00 00 00 
  804944:	48 8b 00             	mov    (%rax),%rax
  804947:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80494d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804951:	89 10                	mov    %edx,(%rax)
  804953:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80495a:	00 00 00 
  80495d:	48 8b 00             	mov    (%rax),%rax
  804960:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804966:	c9                   	leaveq 
  804967:	c3                   	retq   

0000000000804968 <ipc_send>:
  804968:	55                   	push   %rbp
  804969:	48 89 e5             	mov    %rsp,%rbp
  80496c:	48 83 ec 30          	sub    $0x30,%rsp
  804970:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804973:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804976:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  80497a:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80497d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804982:	75 10                	jne    804994 <ipc_send+0x2c>
  804984:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80498b:	00 00 00 
  80498e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804992:	eb 0e                	jmp    8049a2 <ipc_send+0x3a>
  804994:	eb 0c                	jmp    8049a2 <ipc_send+0x3a>
  804996:	48 b8 6c 18 80 00 00 	movabs $0x80186c,%rax
  80499d:	00 00 00 
  8049a0:	ff d0                	callq  *%rax
  8049a2:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8049a5:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8049a8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8049ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8049af:	89 c7                	mov    %eax,%edi
  8049b1:	48 b8 7e 1a 80 00 00 	movabs $0x801a7e,%rax
  8049b8:	00 00 00 
  8049bb:	ff d0                	callq  *%rax
  8049bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8049c0:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8049c4:	74 d0                	je     804996 <ipc_send+0x2e>
  8049c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8049ca:	79 30                	jns    8049fc <ipc_send+0x94>
  8049cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049cf:	89 c1                	mov    %eax,%ecx
  8049d1:	48 ba 70 53 80 00 00 	movabs $0x805370,%rdx
  8049d8:	00 00 00 
  8049db:	be 44 00 00 00       	mov    $0x44,%esi
  8049e0:	48 bf 86 53 80 00 00 	movabs $0x805386,%rdi
  8049e7:	00 00 00 
  8049ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8049ef:	49 b8 8d 01 80 00 00 	movabs $0x80018d,%r8
  8049f6:	00 00 00 
  8049f9:	41 ff d0             	callq  *%r8
  8049fc:	c9                   	leaveq 
  8049fd:	c3                   	retq   

00000000008049fe <ipc_host_recv>:
  8049fe:	55                   	push   %rbp
  8049ff:	48 89 e5             	mov    %rsp,%rbp
  804a02:	48 83 ec 10          	sub    $0x10,%rsp
  804a06:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804a0a:	48 ba 98 53 80 00 00 	movabs $0x805398,%rdx
  804a11:	00 00 00 
  804a14:	be 4e 00 00 00       	mov    $0x4e,%esi
  804a19:	48 bf 86 53 80 00 00 	movabs $0x805386,%rdi
  804a20:	00 00 00 
  804a23:	b8 00 00 00 00       	mov    $0x0,%eax
  804a28:	48 b9 8d 01 80 00 00 	movabs $0x80018d,%rcx
  804a2f:	00 00 00 
  804a32:	ff d1                	callq  *%rcx

0000000000804a34 <ipc_host_send>:
  804a34:	55                   	push   %rbp
  804a35:	48 89 e5             	mov    %rsp,%rbp
  804a38:	48 83 ec 20          	sub    $0x20,%rsp
  804a3c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804a3f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804a42:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804a46:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804a49:	48 ba b8 53 80 00 00 	movabs $0x8053b8,%rdx
  804a50:	00 00 00 
  804a53:	be 67 00 00 00       	mov    $0x67,%esi
  804a58:	48 bf 86 53 80 00 00 	movabs $0x805386,%rdi
  804a5f:	00 00 00 
  804a62:	b8 00 00 00 00       	mov    $0x0,%eax
  804a67:	48 b9 8d 01 80 00 00 	movabs $0x80018d,%rcx
  804a6e:	00 00 00 
  804a71:	ff d1                	callq  *%rcx

0000000000804a73 <ipc_find_env>:
  804a73:	55                   	push   %rbp
  804a74:	48 89 e5             	mov    %rsp,%rbp
  804a77:	48 83 ec 14          	sub    $0x14,%rsp
  804a7b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804a7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804a85:	eb 4e                	jmp    804ad5 <ipc_find_env+0x62>
  804a87:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804a8e:	00 00 00 
  804a91:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a94:	48 98                	cltq   
  804a96:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804a9d:	48 01 d0             	add    %rdx,%rax
  804aa0:	48 05 d0 00 00 00    	add    $0xd0,%rax
  804aa6:	8b 00                	mov    (%rax),%eax
  804aa8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804aab:	75 24                	jne    804ad1 <ipc_find_env+0x5e>
  804aad:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  804ab4:	00 00 00 
  804ab7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804aba:	48 98                	cltq   
  804abc:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804ac3:	48 01 d0             	add    %rdx,%rax
  804ac6:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804acc:	8b 40 08             	mov    0x8(%rax),%eax
  804acf:	eb 12                	jmp    804ae3 <ipc_find_env+0x70>
  804ad1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  804ad5:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804adc:	7e a9                	jle    804a87 <ipc_find_env+0x14>
  804ade:	b8 00 00 00 00       	mov    $0x0,%eax
  804ae3:	c9                   	leaveq 
  804ae4:	c3                   	retq   

0000000000804ae5 <pageref>:
  804ae5:	55                   	push   %rbp
  804ae6:	48 89 e5             	mov    %rsp,%rbp
  804ae9:	48 83 ec 18          	sub    $0x18,%rsp
  804aed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804af1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804af5:	48 c1 e8 15          	shr    $0x15,%rax
  804af9:	48 89 c2             	mov    %rax,%rdx
  804afc:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804b03:	01 00 00 
  804b06:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804b0a:	83 e0 01             	and    $0x1,%eax
  804b0d:	48 85 c0             	test   %rax,%rax
  804b10:	75 07                	jne    804b19 <pageref+0x34>
  804b12:	b8 00 00 00 00       	mov    $0x0,%eax
  804b17:	eb 53                	jmp    804b6c <pageref+0x87>
  804b19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804b1d:	48 c1 e8 0c          	shr    $0xc,%rax
  804b21:	48 89 c2             	mov    %rax,%rdx
  804b24:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804b2b:	01 00 00 
  804b2e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804b32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804b36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b3a:	83 e0 01             	and    $0x1,%eax
  804b3d:	48 85 c0             	test   %rax,%rax
  804b40:	75 07                	jne    804b49 <pageref+0x64>
  804b42:	b8 00 00 00 00       	mov    $0x0,%eax
  804b47:	eb 23                	jmp    804b6c <pageref+0x87>
  804b49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b4d:	48 c1 e8 0c          	shr    $0xc,%rax
  804b51:	48 89 c2             	mov    %rax,%rdx
  804b54:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804b5b:	00 00 00 
  804b5e:	48 c1 e2 04          	shl    $0x4,%rdx
  804b62:	48 01 d0             	add    %rdx,%rax
  804b65:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804b69:	0f b7 c0             	movzwl %ax,%eax
  804b6c:	c9                   	leaveq 
  804b6d:	c3                   	retq   
