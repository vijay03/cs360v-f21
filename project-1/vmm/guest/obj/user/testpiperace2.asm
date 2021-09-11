
vmm/guest/obj/user/testpiperace2:     file format elf64-x86-64


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
  80003c:	e8 e2 02 00 00       	callq  800323 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 40          	sub    $0x40,%rsp
  80004b:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80004e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800052:	48 bf 80 49 80 00 00 	movabs $0x804980,%rdi
  800059:	00 00 00 
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  800068:	00 00 00 
  80006b:	ff d2                	callq  *%rdx
  80006d:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  800071:	48 89 c7             	mov    %rax,%rdi
  800074:	48 b8 12 3d 80 00 00 	movabs $0x803d12,%rax
  80007b:	00 00 00 
  80007e:	ff d0                	callq  *%rax
  800080:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800083:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800087:	79 30                	jns    8000b9 <umain+0x76>
  800089:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80008c:	89 c1                	mov    %eax,%ecx
  80008e:	48 ba a2 49 80 00 00 	movabs $0x8049a2,%rdx
  800095:	00 00 00 
  800098:	be 0e 00 00 00       	mov    $0xe,%esi
  80009d:	48 bf ab 49 80 00 00 	movabs $0x8049ab,%rdi
  8000a4:	00 00 00 
  8000a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ac:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8000b3:	00 00 00 
  8000b6:	41 ff d0             	callq  *%r8
  8000b9:	48 b8 66 22 80 00 00 	movabs $0x802266,%rax
  8000c0:	00 00 00 
  8000c3:	ff d0                	callq  *%rax
  8000c5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8000c8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8000cc:	79 30                	jns    8000fe <umain+0xbb>
  8000ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000d1:	89 c1                	mov    %eax,%ecx
  8000d3:	48 ba c3 49 80 00 00 	movabs $0x8049c3,%rdx
  8000da:	00 00 00 
  8000dd:	be 10 00 00 00       	mov    $0x10,%esi
  8000e2:	48 bf ab 49 80 00 00 	movabs $0x8049ab,%rdi
  8000e9:	00 00 00 
  8000ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8000f1:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8000f8:	00 00 00 
  8000fb:	41 ff d0             	callq  *%r8
  8000fe:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800102:	0f 85 c0 00 00 00    	jne    8001c8 <umain+0x185>
  800108:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80010b:	89 c7                	mov    %eax,%edi
  80010d:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  800114:	00 00 00 
  800117:	ff d0                	callq  *%rax
  800119:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800120:	e9 8a 00 00 00       	jmpq   8001af <umain+0x16c>
  800125:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  800128:	ba 67 66 66 66       	mov    $0x66666667,%edx
  80012d:	89 c8                	mov    %ecx,%eax
  80012f:	f7 ea                	imul   %edx
  800131:	c1 fa 02             	sar    $0x2,%edx
  800134:	89 c8                	mov    %ecx,%eax
  800136:	c1 f8 1f             	sar    $0x1f,%eax
  800139:	29 c2                	sub    %eax,%edx
  80013b:	89 d0                	mov    %edx,%eax
  80013d:	c1 e0 02             	shl    $0x2,%eax
  800140:	01 d0                	add    %edx,%eax
  800142:	01 c0                	add    %eax,%eax
  800144:	29 c1                	sub    %eax,%ecx
  800146:	89 ca                	mov    %ecx,%edx
  800148:	85 d2                	test   %edx,%edx
  80014a:	75 20                	jne    80016c <umain+0x129>
  80014c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80014f:	89 c6                	mov    %eax,%esi
  800151:	48 bf cc 49 80 00 00 	movabs $0x8049cc,%rdi
  800158:	00 00 00 
  80015b:	b8 00 00 00 00       	mov    $0x0,%eax
  800160:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  800167:	00 00 00 
  80016a:	ff d2                	callq  *%rdx
  80016c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  80016f:	be 0a 00 00 00       	mov    $0xa,%esi
  800174:	89 c7                	mov    %eax,%edi
  800176:	48 b8 4a 28 80 00 00 	movabs $0x80284a,%rax
  80017d:	00 00 00 
  800180:	ff d0                	callq  *%rax
  800182:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  800189:	00 00 00 
  80018c:	ff d0                	callq  *%rax
  80018e:	bf 0a 00 00 00       	mov    $0xa,%edi
  800193:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  80019a:	00 00 00 
  80019d:	ff d0                	callq  *%rax
  80019f:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  8001a6:	00 00 00 
  8001a9:	ff d0                	callq  *%rax
  8001ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8001af:	81 7d fc c7 00 00 00 	cmpl   $0xc7,-0x4(%rbp)
  8001b6:	0f 8e 69 ff ff ff    	jle    800125 <umain+0xe2>
  8001bc:	48 b8 a6 03 80 00 00 	movabs $0x8003a6,%rax
  8001c3:	00 00 00 
  8001c6:	ff d0                	callq  *%rax
  8001c8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001cb:	25 ff 03 00 00       	and    $0x3ff,%eax
  8001d0:	48 98                	cltq   
  8001d2:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8001d9:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8001e0:	00 00 00 
  8001e3:	48 01 d0             	add    %rdx,%rax
  8001e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8001ea:	eb 4d                	jmp    800239 <umain+0x1f6>
  8001ec:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8001ef:	89 c7                	mov    %eax,%edi
  8001f1:	48 b8 db 3f 80 00 00 	movabs $0x803fdb,%rax
  8001f8:	00 00 00 
  8001fb:	ff d0                	callq  *%rax
  8001fd:	85 c0                	test   %eax,%eax
  8001ff:	74 38                	je     800239 <umain+0x1f6>
  800201:	48 bf d0 49 80 00 00 	movabs $0x8049d0,%rdi
  800208:	00 00 00 
  80020b:	b8 00 00 00 00       	mov    $0x0,%eax
  800210:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  800217:	00 00 00 
  80021a:	ff d2                	callq  *%rdx
  80021c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80021f:	89 c7                	mov    %eax,%edi
  800221:	48 b8 26 1a 80 00 00 	movabs $0x801a26,%rax
  800228:	00 00 00 
  80022b:	ff d0                	callq  *%rax
  80022d:	48 b8 a6 03 80 00 00 	movabs $0x8003a6,%rax
  800234:	00 00 00 
  800237:	ff d0                	callq  *%rax
  800239:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80023d:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  800243:	83 f8 02             	cmp    $0x2,%eax
  800246:	74 a4                	je     8001ec <umain+0x1a9>
  800248:	48 bf ec 49 80 00 00 	movabs $0x8049ec,%rdi
  80024f:	00 00 00 
  800252:	b8 00 00 00 00       	mov    $0x0,%eax
  800257:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  80025e:	00 00 00 
  800261:	ff d2                	callq  *%rdx
  800263:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800266:	89 c7                	mov    %eax,%edi
  800268:	48 b8 db 3f 80 00 00 	movabs $0x803fdb,%rax
  80026f:	00 00 00 
  800272:	ff d0                	callq  *%rax
  800274:	85 c0                	test   %eax,%eax
  800276:	74 2a                	je     8002a2 <umain+0x25f>
  800278:	48 ba 08 4a 80 00 00 	movabs $0x804a08,%rdx
  80027f:	00 00 00 
  800282:	be 41 00 00 00       	mov    $0x41,%esi
  800287:	48 bf ab 49 80 00 00 	movabs $0x8049ab,%rdi
  80028e:	00 00 00 
  800291:	b8 00 00 00 00       	mov    $0x0,%eax
  800296:	48 b9 c9 03 80 00 00 	movabs $0x8003c9,%rcx
  80029d:	00 00 00 
  8002a0:	ff d1                	callq  *%rcx
  8002a2:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8002a5:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8002a9:	48 89 d6             	mov    %rdx,%rsi
  8002ac:	89 c7                	mov    %eax,%edi
  8002ae:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  8002b5:	00 00 00 
  8002b8:	ff d0                	callq  *%rax
  8002ba:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8002bd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8002c1:	79 30                	jns    8002f3 <umain+0x2b0>
  8002c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8002c6:	89 c1                	mov    %eax,%ecx
  8002c8:	48 ba 32 4a 80 00 00 	movabs $0x804a32,%rdx
  8002cf:	00 00 00 
  8002d2:	be 43 00 00 00       	mov    $0x43,%esi
  8002d7:	48 bf ab 49 80 00 00 	movabs $0x8049ab,%rdi
  8002de:	00 00 00 
  8002e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8002e6:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8002ed:	00 00 00 
  8002f0:	41 ff d0             	callq  *%r8
  8002f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8002f7:	48 89 c7             	mov    %rax,%rdi
  8002fa:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  800301:	00 00 00 
  800304:	ff d0                	callq  *%rax
  800306:	48 bf 4a 4a 80 00 00 	movabs $0x804a4a,%rdi
  80030d:	00 00 00 
  800310:	b8 00 00 00 00       	mov    $0x0,%eax
  800315:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  80031c:	00 00 00 
  80031f:	ff d2                	callq  *%rdx
  800321:	c9                   	leaveq 
  800322:	c3                   	retq   

0000000000800323 <libmain>:
  800323:	55                   	push   %rbp
  800324:	48 89 e5             	mov    %rsp,%rbp
  800327:	48 83 ec 10          	sub    $0x10,%rsp
  80032b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80032e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800332:	48 b8 6a 1a 80 00 00 	movabs $0x801a6a,%rax
  800339:	00 00 00 
  80033c:	ff d0                	callq  *%rax
  80033e:	25 ff 03 00 00       	and    $0x3ff,%eax
  800343:	48 98                	cltq   
  800345:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80034c:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800353:	00 00 00 
  800356:	48 01 c2             	add    %rax,%rdx
  800359:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800360:	00 00 00 
  800363:	48 89 10             	mov    %rdx,(%rax)
  800366:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80036a:	7e 14                	jle    800380 <libmain+0x5d>
  80036c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800370:	48 8b 10             	mov    (%rax),%rdx
  800373:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80037a:	00 00 00 
  80037d:	48 89 10             	mov    %rdx,(%rax)
  800380:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800384:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800387:	48 89 d6             	mov    %rdx,%rsi
  80038a:	89 c7                	mov    %eax,%edi
  80038c:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800393:	00 00 00 
  800396:	ff d0                	callq  *%rax
  800398:	48 b8 a6 03 80 00 00 	movabs $0x8003a6,%rax
  80039f:	00 00 00 
  8003a2:	ff d0                	callq  *%rax
  8003a4:	c9                   	leaveq 
  8003a5:	c3                   	retq   

00000000008003a6 <exit>:
  8003a6:	55                   	push   %rbp
  8003a7:	48 89 e5             	mov    %rsp,%rbp
  8003aa:	48 b8 1c 28 80 00 00 	movabs $0x80281c,%rax
  8003b1:	00 00 00 
  8003b4:	ff d0                	callq  *%rax
  8003b6:	bf 00 00 00 00       	mov    $0x0,%edi
  8003bb:	48 b8 26 1a 80 00 00 	movabs $0x801a26,%rax
  8003c2:	00 00 00 
  8003c5:	ff d0                	callq  *%rax
  8003c7:	5d                   	pop    %rbp
  8003c8:	c3                   	retq   

00000000008003c9 <_panic>:
  8003c9:	55                   	push   %rbp
  8003ca:	48 89 e5             	mov    %rsp,%rbp
  8003cd:	53                   	push   %rbx
  8003ce:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8003d5:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8003dc:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8003e2:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8003e9:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8003f0:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8003f7:	84 c0                	test   %al,%al
  8003f9:	74 23                	je     80041e <_panic+0x55>
  8003fb:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800402:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800406:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  80040a:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80040e:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800412:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800416:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80041a:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80041e:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800425:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80042c:	00 00 00 
  80042f:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800436:	00 00 00 
  800439:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80043d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800444:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80044b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800452:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800459:	00 00 00 
  80045c:	48 8b 18             	mov    (%rax),%rbx
  80045f:	48 b8 6a 1a 80 00 00 	movabs $0x801a6a,%rax
  800466:	00 00 00 
  800469:	ff d0                	callq  *%rax
  80046b:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800471:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800478:	41 89 c8             	mov    %ecx,%r8d
  80047b:	48 89 d1             	mov    %rdx,%rcx
  80047e:	48 89 da             	mov    %rbx,%rdx
  800481:	89 c6                	mov    %eax,%esi
  800483:	48 bf 68 4a 80 00 00 	movabs $0x804a68,%rdi
  80048a:	00 00 00 
  80048d:	b8 00 00 00 00       	mov    $0x0,%eax
  800492:	49 b9 02 06 80 00 00 	movabs $0x800602,%r9
  800499:	00 00 00 
  80049c:	41 ff d1             	callq  *%r9
  80049f:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  8004a6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8004ad:	48 89 d6             	mov    %rdx,%rsi
  8004b0:	48 89 c7             	mov    %rax,%rdi
  8004b3:	48 b8 56 05 80 00 00 	movabs $0x800556,%rax
  8004ba:	00 00 00 
  8004bd:	ff d0                	callq  *%rax
  8004bf:	48 bf 8b 4a 80 00 00 	movabs $0x804a8b,%rdi
  8004c6:	00 00 00 
  8004c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8004ce:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  8004d5:	00 00 00 
  8004d8:	ff d2                	callq  *%rdx
  8004da:	cc                   	int3   
  8004db:	eb fd                	jmp    8004da <_panic+0x111>

00000000008004dd <putch>:
  8004dd:	55                   	push   %rbp
  8004de:	48 89 e5             	mov    %rsp,%rbp
  8004e1:	48 83 ec 10          	sub    $0x10,%rsp
  8004e5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8004e8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8004ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8004f0:	8b 00                	mov    (%rax),%eax
  8004f2:	8d 48 01             	lea    0x1(%rax),%ecx
  8004f5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8004f9:	89 0a                	mov    %ecx,(%rdx)
  8004fb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8004fe:	89 d1                	mov    %edx,%ecx
  800500:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800504:	48 98                	cltq   
  800506:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  80050a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80050e:	8b 00                	mov    (%rax),%eax
  800510:	3d ff 00 00 00       	cmp    $0xff,%eax
  800515:	75 2c                	jne    800543 <putch+0x66>
  800517:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80051b:	8b 00                	mov    (%rax),%eax
  80051d:	48 98                	cltq   
  80051f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800523:	48 83 c2 08          	add    $0x8,%rdx
  800527:	48 89 c6             	mov    %rax,%rsi
  80052a:	48 89 d7             	mov    %rdx,%rdi
  80052d:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  800534:	00 00 00 
  800537:	ff d0                	callq  *%rax
  800539:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80053d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800543:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800547:	8b 40 04             	mov    0x4(%rax),%eax
  80054a:	8d 50 01             	lea    0x1(%rax),%edx
  80054d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800551:	89 50 04             	mov    %edx,0x4(%rax)
  800554:	c9                   	leaveq 
  800555:	c3                   	retq   

0000000000800556 <vcprintf>:
  800556:	55                   	push   %rbp
  800557:	48 89 e5             	mov    %rsp,%rbp
  80055a:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800561:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800568:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80056f:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800576:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  80057d:	48 8b 0a             	mov    (%rdx),%rcx
  800580:	48 89 08             	mov    %rcx,(%rax)
  800583:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800587:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80058b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80058f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800593:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  80059a:	00 00 00 
  80059d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  8005a4:	00 00 00 
  8005a7:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  8005ae:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8005b5:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8005bc:	48 89 c6             	mov    %rax,%rsi
  8005bf:	48 bf dd 04 80 00 00 	movabs $0x8004dd,%rdi
  8005c6:	00 00 00 
  8005c9:	48 b8 b5 09 80 00 00 	movabs $0x8009b5,%rax
  8005d0:	00 00 00 
  8005d3:	ff d0                	callq  *%rax
  8005d5:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8005db:	48 98                	cltq   
  8005dd:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8005e4:	48 83 c2 08          	add    $0x8,%rdx
  8005e8:	48 89 c6             	mov    %rax,%rsi
  8005eb:	48 89 d7             	mov    %rdx,%rdi
  8005ee:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  8005f5:	00 00 00 
  8005f8:	ff d0                	callq  *%rax
  8005fa:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800600:	c9                   	leaveq 
  800601:	c3                   	retq   

0000000000800602 <cprintf>:
  800602:	55                   	push   %rbp
  800603:	48 89 e5             	mov    %rsp,%rbp
  800606:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  80060d:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800614:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80061b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800622:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800629:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800630:	84 c0                	test   %al,%al
  800632:	74 20                	je     800654 <cprintf+0x52>
  800634:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800638:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80063c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800640:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800644:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800648:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80064c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800650:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800654:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80065b:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800662:	00 00 00 
  800665:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80066c:	00 00 00 
  80066f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800673:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80067a:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800681:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800688:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80068f:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800696:	48 8b 0a             	mov    (%rdx),%rcx
  800699:	48 89 08             	mov    %rcx,(%rax)
  80069c:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8006a0:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8006a4:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8006a8:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8006ac:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8006b3:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8006ba:	48 89 d6             	mov    %rdx,%rsi
  8006bd:	48 89 c7             	mov    %rax,%rdi
  8006c0:	48 b8 56 05 80 00 00 	movabs $0x800556,%rax
  8006c7:	00 00 00 
  8006ca:	ff d0                	callq  *%rax
  8006cc:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8006d2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8006d8:	c9                   	leaveq 
  8006d9:	c3                   	retq   

00000000008006da <printnum>:
  8006da:	55                   	push   %rbp
  8006db:	48 89 e5             	mov    %rsp,%rbp
  8006de:	53                   	push   %rbx
  8006df:	48 83 ec 38          	sub    $0x38,%rsp
  8006e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8006e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8006eb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8006ef:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8006f2:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8006f6:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8006fa:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8006fd:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800701:	77 3b                	ja     80073e <printnum+0x64>
  800703:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800706:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  80070a:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  80070d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800711:	ba 00 00 00 00       	mov    $0x0,%edx
  800716:	48 f7 f3             	div    %rbx
  800719:	48 89 c2             	mov    %rax,%rdx
  80071c:	8b 7d cc             	mov    -0x34(%rbp),%edi
  80071f:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800722:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800726:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80072a:	41 89 f9             	mov    %edi,%r9d
  80072d:	48 89 c7             	mov    %rax,%rdi
  800730:	48 b8 da 06 80 00 00 	movabs $0x8006da,%rax
  800737:	00 00 00 
  80073a:	ff d0                	callq  *%rax
  80073c:	eb 1e                	jmp    80075c <printnum+0x82>
  80073e:	eb 12                	jmp    800752 <printnum+0x78>
  800740:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800744:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80074b:	48 89 ce             	mov    %rcx,%rsi
  80074e:	89 d7                	mov    %edx,%edi
  800750:	ff d0                	callq  *%rax
  800752:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800756:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  80075a:	7f e4                	jg     800740 <printnum+0x66>
  80075c:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80075f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800763:	ba 00 00 00 00       	mov    $0x0,%edx
  800768:	48 f7 f1             	div    %rcx
  80076b:	48 89 d0             	mov    %rdx,%rax
  80076e:	48 ba 90 4c 80 00 00 	movabs $0x804c90,%rdx
  800775:	00 00 00 
  800778:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  80077c:	0f be d0             	movsbl %al,%edx
  80077f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800783:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800787:	48 89 ce             	mov    %rcx,%rsi
  80078a:	89 d7                	mov    %edx,%edi
  80078c:	ff d0                	callq  *%rax
  80078e:	48 83 c4 38          	add    $0x38,%rsp
  800792:	5b                   	pop    %rbx
  800793:	5d                   	pop    %rbp
  800794:	c3                   	retq   

0000000000800795 <getuint>:
  800795:	55                   	push   %rbp
  800796:	48 89 e5             	mov    %rsp,%rbp
  800799:	48 83 ec 1c          	sub    $0x1c,%rsp
  80079d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8007a1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8007a4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8007a8:	7e 52                	jle    8007fc <getuint+0x67>
  8007aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007ae:	8b 00                	mov    (%rax),%eax
  8007b0:	83 f8 30             	cmp    $0x30,%eax
  8007b3:	73 24                	jae    8007d9 <getuint+0x44>
  8007b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007b9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8007bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007c1:	8b 00                	mov    (%rax),%eax
  8007c3:	89 c0                	mov    %eax,%eax
  8007c5:	48 01 d0             	add    %rdx,%rax
  8007c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007cc:	8b 12                	mov    (%rdx),%edx
  8007ce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8007d1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007d5:	89 0a                	mov    %ecx,(%rdx)
  8007d7:	eb 17                	jmp    8007f0 <getuint+0x5b>
  8007d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007dd:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8007e1:	48 89 d0             	mov    %rdx,%rax
  8007e4:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8007e8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8007ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8007f0:	48 8b 00             	mov    (%rax),%rax
  8007f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8007f7:	e9 a3 00 00 00       	jmpq   80089f <getuint+0x10a>
  8007fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800800:	74 4f                	je     800851 <getuint+0xbc>
  800802:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800806:	8b 00                	mov    (%rax),%eax
  800808:	83 f8 30             	cmp    $0x30,%eax
  80080b:	73 24                	jae    800831 <getuint+0x9c>
  80080d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800811:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800815:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800819:	8b 00                	mov    (%rax),%eax
  80081b:	89 c0                	mov    %eax,%eax
  80081d:	48 01 d0             	add    %rdx,%rax
  800820:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800824:	8b 12                	mov    (%rdx),%edx
  800826:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800829:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80082d:	89 0a                	mov    %ecx,(%rdx)
  80082f:	eb 17                	jmp    800848 <getuint+0xb3>
  800831:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800835:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800839:	48 89 d0             	mov    %rdx,%rax
  80083c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800840:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800844:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800848:	48 8b 00             	mov    (%rax),%rax
  80084b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80084f:	eb 4e                	jmp    80089f <getuint+0x10a>
  800851:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800855:	8b 00                	mov    (%rax),%eax
  800857:	83 f8 30             	cmp    $0x30,%eax
  80085a:	73 24                	jae    800880 <getuint+0xeb>
  80085c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800860:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800864:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800868:	8b 00                	mov    (%rax),%eax
  80086a:	89 c0                	mov    %eax,%eax
  80086c:	48 01 d0             	add    %rdx,%rax
  80086f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800873:	8b 12                	mov    (%rdx),%edx
  800875:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800878:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80087c:	89 0a                	mov    %ecx,(%rdx)
  80087e:	eb 17                	jmp    800897 <getuint+0x102>
  800880:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800884:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800888:	48 89 d0             	mov    %rdx,%rax
  80088b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80088f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800893:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800897:	8b 00                	mov    (%rax),%eax
  800899:	89 c0                	mov    %eax,%eax
  80089b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80089f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8008a3:	c9                   	leaveq 
  8008a4:	c3                   	retq   

00000000008008a5 <getint>:
  8008a5:	55                   	push   %rbp
  8008a6:	48 89 e5             	mov    %rsp,%rbp
  8008a9:	48 83 ec 1c          	sub    $0x1c,%rsp
  8008ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8008b1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8008b4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8008b8:	7e 52                	jle    80090c <getint+0x67>
  8008ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008be:	8b 00                	mov    (%rax),%eax
  8008c0:	83 f8 30             	cmp    $0x30,%eax
  8008c3:	73 24                	jae    8008e9 <getint+0x44>
  8008c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008c9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008d1:	8b 00                	mov    (%rax),%eax
  8008d3:	89 c0                	mov    %eax,%eax
  8008d5:	48 01 d0             	add    %rdx,%rax
  8008d8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008dc:	8b 12                	mov    (%rdx),%edx
  8008de:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008e5:	89 0a                	mov    %ecx,(%rdx)
  8008e7:	eb 17                	jmp    800900 <getint+0x5b>
  8008e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008ed:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008f1:	48 89 d0             	mov    %rdx,%rax
  8008f4:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008f8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800900:	48 8b 00             	mov    (%rax),%rax
  800903:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800907:	e9 a3 00 00 00       	jmpq   8009af <getint+0x10a>
  80090c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800910:	74 4f                	je     800961 <getint+0xbc>
  800912:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800916:	8b 00                	mov    (%rax),%eax
  800918:	83 f8 30             	cmp    $0x30,%eax
  80091b:	73 24                	jae    800941 <getint+0x9c>
  80091d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800921:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800925:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800929:	8b 00                	mov    (%rax),%eax
  80092b:	89 c0                	mov    %eax,%eax
  80092d:	48 01 d0             	add    %rdx,%rax
  800930:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800934:	8b 12                	mov    (%rdx),%edx
  800936:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800939:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80093d:	89 0a                	mov    %ecx,(%rdx)
  80093f:	eb 17                	jmp    800958 <getint+0xb3>
  800941:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800945:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800949:	48 89 d0             	mov    %rdx,%rax
  80094c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800950:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800954:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800958:	48 8b 00             	mov    (%rax),%rax
  80095b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80095f:	eb 4e                	jmp    8009af <getint+0x10a>
  800961:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800965:	8b 00                	mov    (%rax),%eax
  800967:	83 f8 30             	cmp    $0x30,%eax
  80096a:	73 24                	jae    800990 <getint+0xeb>
  80096c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800970:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800974:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800978:	8b 00                	mov    (%rax),%eax
  80097a:	89 c0                	mov    %eax,%eax
  80097c:	48 01 d0             	add    %rdx,%rax
  80097f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800983:	8b 12                	mov    (%rdx),%edx
  800985:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800988:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80098c:	89 0a                	mov    %ecx,(%rdx)
  80098e:	eb 17                	jmp    8009a7 <getint+0x102>
  800990:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800994:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800998:	48 89 d0             	mov    %rdx,%rax
  80099b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80099f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009a7:	8b 00                	mov    (%rax),%eax
  8009a9:	48 98                	cltq   
  8009ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8009b3:	c9                   	leaveq 
  8009b4:	c3                   	retq   

00000000008009b5 <vprintfmt>:
  8009b5:	55                   	push   %rbp
  8009b6:	48 89 e5             	mov    %rsp,%rbp
  8009b9:	41 54                	push   %r12
  8009bb:	53                   	push   %rbx
  8009bc:	48 83 ec 60          	sub    $0x60,%rsp
  8009c0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  8009c4:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8009c8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8009cc:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8009d0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8009d4:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  8009d8:	48 8b 0a             	mov    (%rdx),%rcx
  8009db:	48 89 08             	mov    %rcx,(%rax)
  8009de:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8009e2:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8009e6:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8009ea:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8009ee:	eb 17                	jmp    800a07 <vprintfmt+0x52>
  8009f0:	85 db                	test   %ebx,%ebx
  8009f2:	0f 84 cc 04 00 00    	je     800ec4 <vprintfmt+0x50f>
  8009f8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8009fc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a00:	48 89 d6             	mov    %rdx,%rsi
  800a03:	89 df                	mov    %ebx,%edi
  800a05:	ff d0                	callq  *%rax
  800a07:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a0b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a0f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a13:	0f b6 00             	movzbl (%rax),%eax
  800a16:	0f b6 d8             	movzbl %al,%ebx
  800a19:	83 fb 25             	cmp    $0x25,%ebx
  800a1c:	75 d2                	jne    8009f0 <vprintfmt+0x3b>
  800a1e:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800a22:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800a29:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800a30:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800a37:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800a3e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800a42:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800a46:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800a4a:	0f b6 00             	movzbl (%rax),%eax
  800a4d:	0f b6 d8             	movzbl %al,%ebx
  800a50:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800a53:	83 f8 55             	cmp    $0x55,%eax
  800a56:	0f 87 34 04 00 00    	ja     800e90 <vprintfmt+0x4db>
  800a5c:	89 c0                	mov    %eax,%eax
  800a5e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800a65:	00 
  800a66:	48 b8 b8 4c 80 00 00 	movabs $0x804cb8,%rax
  800a6d:	00 00 00 
  800a70:	48 01 d0             	add    %rdx,%rax
  800a73:	48 8b 00             	mov    (%rax),%rax
  800a76:	ff e0                	jmpq   *%rax
  800a78:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800a7c:	eb c0                	jmp    800a3e <vprintfmt+0x89>
  800a7e:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800a82:	eb ba                	jmp    800a3e <vprintfmt+0x89>
  800a84:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800a8b:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800a8e:	89 d0                	mov    %edx,%eax
  800a90:	c1 e0 02             	shl    $0x2,%eax
  800a93:	01 d0                	add    %edx,%eax
  800a95:	01 c0                	add    %eax,%eax
  800a97:	01 d8                	add    %ebx,%eax
  800a99:	83 e8 30             	sub    $0x30,%eax
  800a9c:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800a9f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800aa3:	0f b6 00             	movzbl (%rax),%eax
  800aa6:	0f be d8             	movsbl %al,%ebx
  800aa9:	83 fb 2f             	cmp    $0x2f,%ebx
  800aac:	7e 0c                	jle    800aba <vprintfmt+0x105>
  800aae:	83 fb 39             	cmp    $0x39,%ebx
  800ab1:	7f 07                	jg     800aba <vprintfmt+0x105>
  800ab3:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800ab8:	eb d1                	jmp    800a8b <vprintfmt+0xd6>
  800aba:	eb 58                	jmp    800b14 <vprintfmt+0x15f>
  800abc:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800abf:	83 f8 30             	cmp    $0x30,%eax
  800ac2:	73 17                	jae    800adb <vprintfmt+0x126>
  800ac4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800ac8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800acb:	89 c0                	mov    %eax,%eax
  800acd:	48 01 d0             	add    %rdx,%rax
  800ad0:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ad3:	83 c2 08             	add    $0x8,%edx
  800ad6:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800ad9:	eb 0f                	jmp    800aea <vprintfmt+0x135>
  800adb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800adf:	48 89 d0             	mov    %rdx,%rax
  800ae2:	48 83 c2 08          	add    $0x8,%rdx
  800ae6:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800aea:	8b 00                	mov    (%rax),%eax
  800aec:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800aef:	eb 23                	jmp    800b14 <vprintfmt+0x15f>
  800af1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800af5:	79 0c                	jns    800b03 <vprintfmt+0x14e>
  800af7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800afe:	e9 3b ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b03:	e9 36 ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b08:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800b0f:	e9 2a ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b14:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b18:	79 12                	jns    800b2c <vprintfmt+0x177>
  800b1a:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800b1d:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800b20:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b27:	e9 12 ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b2c:	e9 0d ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b31:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800b35:	e9 04 ff ff ff       	jmpq   800a3e <vprintfmt+0x89>
  800b3a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b3d:	83 f8 30             	cmp    $0x30,%eax
  800b40:	73 17                	jae    800b59 <vprintfmt+0x1a4>
  800b42:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b46:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b49:	89 c0                	mov    %eax,%eax
  800b4b:	48 01 d0             	add    %rdx,%rax
  800b4e:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b51:	83 c2 08             	add    $0x8,%edx
  800b54:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b57:	eb 0f                	jmp    800b68 <vprintfmt+0x1b3>
  800b59:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800b5d:	48 89 d0             	mov    %rdx,%rax
  800b60:	48 83 c2 08          	add    $0x8,%rdx
  800b64:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800b68:	8b 10                	mov    (%rax),%edx
  800b6a:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800b6e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b72:	48 89 ce             	mov    %rcx,%rsi
  800b75:	89 d7                	mov    %edx,%edi
  800b77:	ff d0                	callq  *%rax
  800b79:	e9 40 03 00 00       	jmpq   800ebe <vprintfmt+0x509>
  800b7e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b81:	83 f8 30             	cmp    $0x30,%eax
  800b84:	73 17                	jae    800b9d <vprintfmt+0x1e8>
  800b86:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800b8a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800b8d:	89 c0                	mov    %eax,%eax
  800b8f:	48 01 d0             	add    %rdx,%rax
  800b92:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800b95:	83 c2 08             	add    $0x8,%edx
  800b98:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800b9b:	eb 0f                	jmp    800bac <vprintfmt+0x1f7>
  800b9d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ba1:	48 89 d0             	mov    %rdx,%rax
  800ba4:	48 83 c2 08          	add    $0x8,%rdx
  800ba8:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bac:	8b 18                	mov    (%rax),%ebx
  800bae:	85 db                	test   %ebx,%ebx
  800bb0:	79 02                	jns    800bb4 <vprintfmt+0x1ff>
  800bb2:	f7 db                	neg    %ebx
  800bb4:	83 fb 15             	cmp    $0x15,%ebx
  800bb7:	7f 16                	jg     800bcf <vprintfmt+0x21a>
  800bb9:	48 b8 e0 4b 80 00 00 	movabs $0x804be0,%rax
  800bc0:	00 00 00 
  800bc3:	48 63 d3             	movslq %ebx,%rdx
  800bc6:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800bca:	4d 85 e4             	test   %r12,%r12
  800bcd:	75 2e                	jne    800bfd <vprintfmt+0x248>
  800bcf:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800bd3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bd7:	89 d9                	mov    %ebx,%ecx
  800bd9:	48 ba a1 4c 80 00 00 	movabs $0x804ca1,%rdx
  800be0:	00 00 00 
  800be3:	48 89 c7             	mov    %rax,%rdi
  800be6:	b8 00 00 00 00       	mov    $0x0,%eax
  800beb:	49 b8 cd 0e 80 00 00 	movabs $0x800ecd,%r8
  800bf2:	00 00 00 
  800bf5:	41 ff d0             	callq  *%r8
  800bf8:	e9 c1 02 00 00       	jmpq   800ebe <vprintfmt+0x509>
  800bfd:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c01:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c05:	4c 89 e1             	mov    %r12,%rcx
  800c08:	48 ba aa 4c 80 00 00 	movabs $0x804caa,%rdx
  800c0f:	00 00 00 
  800c12:	48 89 c7             	mov    %rax,%rdi
  800c15:	b8 00 00 00 00       	mov    $0x0,%eax
  800c1a:	49 b8 cd 0e 80 00 00 	movabs $0x800ecd,%r8
  800c21:	00 00 00 
  800c24:	41 ff d0             	callq  *%r8
  800c27:	e9 92 02 00 00       	jmpq   800ebe <vprintfmt+0x509>
  800c2c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c2f:	83 f8 30             	cmp    $0x30,%eax
  800c32:	73 17                	jae    800c4b <vprintfmt+0x296>
  800c34:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c38:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c3b:	89 c0                	mov    %eax,%eax
  800c3d:	48 01 d0             	add    %rdx,%rax
  800c40:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c43:	83 c2 08             	add    $0x8,%edx
  800c46:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c49:	eb 0f                	jmp    800c5a <vprintfmt+0x2a5>
  800c4b:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c4f:	48 89 d0             	mov    %rdx,%rax
  800c52:	48 83 c2 08          	add    $0x8,%rdx
  800c56:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c5a:	4c 8b 20             	mov    (%rax),%r12
  800c5d:	4d 85 e4             	test   %r12,%r12
  800c60:	75 0a                	jne    800c6c <vprintfmt+0x2b7>
  800c62:	49 bc ad 4c 80 00 00 	movabs $0x804cad,%r12
  800c69:	00 00 00 
  800c6c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c70:	7e 3f                	jle    800cb1 <vprintfmt+0x2fc>
  800c72:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800c76:	74 39                	je     800cb1 <vprintfmt+0x2fc>
  800c78:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800c7b:	48 98                	cltq   
  800c7d:	48 89 c6             	mov    %rax,%rsi
  800c80:	4c 89 e7             	mov    %r12,%rdi
  800c83:	48 b8 79 11 80 00 00 	movabs $0x801179,%rax
  800c8a:	00 00 00 
  800c8d:	ff d0                	callq  *%rax
  800c8f:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800c92:	eb 17                	jmp    800cab <vprintfmt+0x2f6>
  800c94:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800c98:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800c9c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ca0:	48 89 ce             	mov    %rcx,%rsi
  800ca3:	89 d7                	mov    %edx,%edi
  800ca5:	ff d0                	callq  *%rax
  800ca7:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800cab:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800caf:	7f e3                	jg     800c94 <vprintfmt+0x2df>
  800cb1:	eb 37                	jmp    800cea <vprintfmt+0x335>
  800cb3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800cb7:	74 1e                	je     800cd7 <vprintfmt+0x322>
  800cb9:	83 fb 1f             	cmp    $0x1f,%ebx
  800cbc:	7e 05                	jle    800cc3 <vprintfmt+0x30e>
  800cbe:	83 fb 7e             	cmp    $0x7e,%ebx
  800cc1:	7e 14                	jle    800cd7 <vprintfmt+0x322>
  800cc3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cc7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ccb:	48 89 d6             	mov    %rdx,%rsi
  800cce:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800cd3:	ff d0                	callq  *%rax
  800cd5:	eb 0f                	jmp    800ce6 <vprintfmt+0x331>
  800cd7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800cdb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cdf:	48 89 d6             	mov    %rdx,%rsi
  800ce2:	89 df                	mov    %ebx,%edi
  800ce4:	ff d0                	callq  *%rax
  800ce6:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800cea:	4c 89 e0             	mov    %r12,%rax
  800ced:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800cf1:	0f b6 00             	movzbl (%rax),%eax
  800cf4:	0f be d8             	movsbl %al,%ebx
  800cf7:	85 db                	test   %ebx,%ebx
  800cf9:	74 10                	je     800d0b <vprintfmt+0x356>
  800cfb:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800cff:	78 b2                	js     800cb3 <vprintfmt+0x2fe>
  800d01:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800d05:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800d09:	79 a8                	jns    800cb3 <vprintfmt+0x2fe>
  800d0b:	eb 16                	jmp    800d23 <vprintfmt+0x36e>
  800d0d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d11:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d15:	48 89 d6             	mov    %rdx,%rsi
  800d18:	bf 20 00 00 00       	mov    $0x20,%edi
  800d1d:	ff d0                	callq  *%rax
  800d1f:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d23:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d27:	7f e4                	jg     800d0d <vprintfmt+0x358>
  800d29:	e9 90 01 00 00       	jmpq   800ebe <vprintfmt+0x509>
  800d2e:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d32:	be 03 00 00 00       	mov    $0x3,%esi
  800d37:	48 89 c7             	mov    %rax,%rdi
  800d3a:	48 b8 a5 08 80 00 00 	movabs $0x8008a5,%rax
  800d41:	00 00 00 
  800d44:	ff d0                	callq  *%rax
  800d46:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d4e:	48 85 c0             	test   %rax,%rax
  800d51:	79 1d                	jns    800d70 <vprintfmt+0x3bb>
  800d53:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800d57:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d5b:	48 89 d6             	mov    %rdx,%rsi
  800d5e:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800d63:	ff d0                	callq  *%rax
  800d65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d69:	48 f7 d8             	neg    %rax
  800d6c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d70:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800d77:	e9 d5 00 00 00       	jmpq   800e51 <vprintfmt+0x49c>
  800d7c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800d80:	be 03 00 00 00       	mov    $0x3,%esi
  800d85:	48 89 c7             	mov    %rax,%rdi
  800d88:	48 b8 95 07 80 00 00 	movabs $0x800795,%rax
  800d8f:	00 00 00 
  800d92:	ff d0                	callq  *%rax
  800d94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800d98:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800d9f:	e9 ad 00 00 00       	jmpq   800e51 <vprintfmt+0x49c>
  800da4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800da8:	be 03 00 00 00       	mov    $0x3,%esi
  800dad:	48 89 c7             	mov    %rax,%rdi
  800db0:	48 b8 95 07 80 00 00 	movabs $0x800795,%rax
  800db7:	00 00 00 
  800dba:	ff d0                	callq  *%rax
  800dbc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800dc0:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800dc7:	e9 85 00 00 00       	jmpq   800e51 <vprintfmt+0x49c>
  800dcc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dd0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dd4:	48 89 d6             	mov    %rdx,%rsi
  800dd7:	bf 30 00 00 00       	mov    $0x30,%edi
  800ddc:	ff d0                	callq  *%rax
  800dde:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800de2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800de6:	48 89 d6             	mov    %rdx,%rsi
  800de9:	bf 78 00 00 00       	mov    $0x78,%edi
  800dee:	ff d0                	callq  *%rax
  800df0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800df3:	83 f8 30             	cmp    $0x30,%eax
  800df6:	73 17                	jae    800e0f <vprintfmt+0x45a>
  800df8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800dfc:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800dff:	89 c0                	mov    %eax,%eax
  800e01:	48 01 d0             	add    %rdx,%rax
  800e04:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e07:	83 c2 08             	add    $0x8,%edx
  800e0a:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e0d:	eb 0f                	jmp    800e1e <vprintfmt+0x469>
  800e0f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e13:	48 89 d0             	mov    %rdx,%rax
  800e16:	48 83 c2 08          	add    $0x8,%rdx
  800e1a:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e1e:	48 8b 00             	mov    (%rax),%rax
  800e21:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e25:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e2c:	eb 23                	jmp    800e51 <vprintfmt+0x49c>
  800e2e:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e32:	be 03 00 00 00       	mov    $0x3,%esi
  800e37:	48 89 c7             	mov    %rax,%rdi
  800e3a:	48 b8 95 07 80 00 00 	movabs $0x800795,%rax
  800e41:	00 00 00 
  800e44:	ff d0                	callq  *%rax
  800e46:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e4a:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800e51:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800e56:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800e59:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800e5c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800e60:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800e64:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e68:	45 89 c1             	mov    %r8d,%r9d
  800e6b:	41 89 f8             	mov    %edi,%r8d
  800e6e:	48 89 c7             	mov    %rax,%rdi
  800e71:	48 b8 da 06 80 00 00 	movabs $0x8006da,%rax
  800e78:	00 00 00 
  800e7b:	ff d0                	callq  *%rax
  800e7d:	eb 3f                	jmp    800ebe <vprintfmt+0x509>
  800e7f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e83:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e87:	48 89 d6             	mov    %rdx,%rsi
  800e8a:	89 df                	mov    %ebx,%edi
  800e8c:	ff d0                	callq  *%rax
  800e8e:	eb 2e                	jmp    800ebe <vprintfmt+0x509>
  800e90:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e94:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e98:	48 89 d6             	mov    %rdx,%rsi
  800e9b:	bf 25 00 00 00       	mov    $0x25,%edi
  800ea0:	ff d0                	callq  *%rax
  800ea2:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800ea7:	eb 05                	jmp    800eae <vprintfmt+0x4f9>
  800ea9:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800eae:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800eb2:	48 83 e8 01          	sub    $0x1,%rax
  800eb6:	0f b6 00             	movzbl (%rax),%eax
  800eb9:	3c 25                	cmp    $0x25,%al
  800ebb:	75 ec                	jne    800ea9 <vprintfmt+0x4f4>
  800ebd:	90                   	nop
  800ebe:	90                   	nop
  800ebf:	e9 43 fb ff ff       	jmpq   800a07 <vprintfmt+0x52>
  800ec4:	48 83 c4 60          	add    $0x60,%rsp
  800ec8:	5b                   	pop    %rbx
  800ec9:	41 5c                	pop    %r12
  800ecb:	5d                   	pop    %rbp
  800ecc:	c3                   	retq   

0000000000800ecd <printfmt>:
  800ecd:	55                   	push   %rbp
  800ece:	48 89 e5             	mov    %rsp,%rbp
  800ed1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800ed8:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800edf:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800ee6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800eed:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800ef4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800efb:	84 c0                	test   %al,%al
  800efd:	74 20                	je     800f1f <printfmt+0x52>
  800eff:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800f03:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800f07:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800f0b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800f0f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800f13:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800f17:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800f1b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800f1f:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800f26:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800f2d:	00 00 00 
  800f30:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800f37:	00 00 00 
  800f3a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800f3e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800f45:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800f4c:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800f53:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800f5a:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800f61:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800f68:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800f6f:	48 89 c7             	mov    %rax,%rdi
  800f72:	48 b8 b5 09 80 00 00 	movabs $0x8009b5,%rax
  800f79:	00 00 00 
  800f7c:	ff d0                	callq  *%rax
  800f7e:	c9                   	leaveq 
  800f7f:	c3                   	retq   

0000000000800f80 <sprintputch>:
  800f80:	55                   	push   %rbp
  800f81:	48 89 e5             	mov    %rsp,%rbp
  800f84:	48 83 ec 10          	sub    $0x10,%rsp
  800f88:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800f8b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800f8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800f93:	8b 40 10             	mov    0x10(%rax),%eax
  800f96:	8d 50 01             	lea    0x1(%rax),%edx
  800f99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800f9d:	89 50 10             	mov    %edx,0x10(%rax)
  800fa0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fa4:	48 8b 10             	mov    (%rax),%rdx
  800fa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fab:	48 8b 40 08          	mov    0x8(%rax),%rax
  800faf:	48 39 c2             	cmp    %rax,%rdx
  800fb2:	73 17                	jae    800fcb <sprintputch+0x4b>
  800fb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fb8:	48 8b 00             	mov    (%rax),%rax
  800fbb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800fbf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800fc3:	48 89 0a             	mov    %rcx,(%rdx)
  800fc6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800fc9:	88 10                	mov    %dl,(%rax)
  800fcb:	c9                   	leaveq 
  800fcc:	c3                   	retq   

0000000000800fcd <vsnprintf>:
  800fcd:	55                   	push   %rbp
  800fce:	48 89 e5             	mov    %rsp,%rbp
  800fd1:	48 83 ec 50          	sub    $0x50,%rsp
  800fd5:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800fd9:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800fdc:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800fe0:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800fe4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800fe8:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800fec:	48 8b 0a             	mov    (%rdx),%rcx
  800fef:	48 89 08             	mov    %rcx,(%rax)
  800ff2:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ff6:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ffa:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800ffe:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801002:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801006:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  80100a:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  80100d:	48 98                	cltq   
  80100f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801013:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801017:	48 01 d0             	add    %rdx,%rax
  80101a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  80101e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801025:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  80102a:	74 06                	je     801032 <vsnprintf+0x65>
  80102c:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801030:	7f 07                	jg     801039 <vsnprintf+0x6c>
  801032:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801037:	eb 2f                	jmp    801068 <vsnprintf+0x9b>
  801039:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  80103d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801041:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801045:	48 89 c6             	mov    %rax,%rsi
  801048:	48 bf 80 0f 80 00 00 	movabs $0x800f80,%rdi
  80104f:	00 00 00 
  801052:	48 b8 b5 09 80 00 00 	movabs $0x8009b5,%rax
  801059:	00 00 00 
  80105c:	ff d0                	callq  *%rax
  80105e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801062:	c6 00 00             	movb   $0x0,(%rax)
  801065:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801068:	c9                   	leaveq 
  801069:	c3                   	retq   

000000000080106a <snprintf>:
  80106a:	55                   	push   %rbp
  80106b:	48 89 e5             	mov    %rsp,%rbp
  80106e:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  801075:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80107c:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  801082:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801089:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801090:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801097:	84 c0                	test   %al,%al
  801099:	74 20                	je     8010bb <snprintf+0x51>
  80109b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80109f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8010a3:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8010a7:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8010ab:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8010af:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8010b3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8010b7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8010bb:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8010c2:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8010c9:	00 00 00 
  8010cc:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8010d3:	00 00 00 
  8010d6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8010da:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8010e1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8010e8:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8010ef:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8010f6:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8010fd:	48 8b 0a             	mov    (%rdx),%rcx
  801100:	48 89 08             	mov    %rcx,(%rax)
  801103:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  801107:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80110b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80110f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801113:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  80111a:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801121:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801127:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80112e:	48 89 c7             	mov    %rax,%rdi
  801131:	48 b8 cd 0f 80 00 00 	movabs $0x800fcd,%rax
  801138:	00 00 00 
  80113b:	ff d0                	callq  *%rax
  80113d:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801143:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801149:	c9                   	leaveq 
  80114a:	c3                   	retq   

000000000080114b <strlen>:
  80114b:	55                   	push   %rbp
  80114c:	48 89 e5             	mov    %rsp,%rbp
  80114f:	48 83 ec 18          	sub    $0x18,%rsp
  801153:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801157:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80115e:	eb 09                	jmp    801169 <strlen+0x1e>
  801160:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801164:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801169:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80116d:	0f b6 00             	movzbl (%rax),%eax
  801170:	84 c0                	test   %al,%al
  801172:	75 ec                	jne    801160 <strlen+0x15>
  801174:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801177:	c9                   	leaveq 
  801178:	c3                   	retq   

0000000000801179 <strnlen>:
  801179:	55                   	push   %rbp
  80117a:	48 89 e5             	mov    %rsp,%rbp
  80117d:	48 83 ec 20          	sub    $0x20,%rsp
  801181:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801185:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801189:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801190:	eb 0e                	jmp    8011a0 <strnlen+0x27>
  801192:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801196:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80119b:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8011a0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8011a5:	74 0b                	je     8011b2 <strnlen+0x39>
  8011a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ab:	0f b6 00             	movzbl (%rax),%eax
  8011ae:	84 c0                	test   %al,%al
  8011b0:	75 e0                	jne    801192 <strnlen+0x19>
  8011b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011b5:	c9                   	leaveq 
  8011b6:	c3                   	retq   

00000000008011b7 <strcpy>:
  8011b7:	55                   	push   %rbp
  8011b8:	48 89 e5             	mov    %rsp,%rbp
  8011bb:	48 83 ec 20          	sub    $0x20,%rsp
  8011bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011c3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8011cf:	90                   	nop
  8011d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011d4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8011d8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8011dc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8011e0:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8011e4:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8011e8:	0f b6 12             	movzbl (%rdx),%edx
  8011eb:	88 10                	mov    %dl,(%rax)
  8011ed:	0f b6 00             	movzbl (%rax),%eax
  8011f0:	84 c0                	test   %al,%al
  8011f2:	75 dc                	jne    8011d0 <strcpy+0x19>
  8011f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011f8:	c9                   	leaveq 
  8011f9:	c3                   	retq   

00000000008011fa <strcat>:
  8011fa:	55                   	push   %rbp
  8011fb:	48 89 e5             	mov    %rsp,%rbp
  8011fe:	48 83 ec 20          	sub    $0x20,%rsp
  801202:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801206:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80120a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80120e:	48 89 c7             	mov    %rax,%rdi
  801211:	48 b8 4b 11 80 00 00 	movabs $0x80114b,%rax
  801218:	00 00 00 
  80121b:	ff d0                	callq  *%rax
  80121d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801220:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801223:	48 63 d0             	movslq %eax,%rdx
  801226:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80122a:	48 01 c2             	add    %rax,%rdx
  80122d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801231:	48 89 c6             	mov    %rax,%rsi
  801234:	48 89 d7             	mov    %rdx,%rdi
  801237:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  80123e:	00 00 00 
  801241:	ff d0                	callq  *%rax
  801243:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801247:	c9                   	leaveq 
  801248:	c3                   	retq   

0000000000801249 <strncpy>:
  801249:	55                   	push   %rbp
  80124a:	48 89 e5             	mov    %rsp,%rbp
  80124d:	48 83 ec 28          	sub    $0x28,%rsp
  801251:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801255:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801259:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80125d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801261:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801265:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80126c:	00 
  80126d:	eb 2a                	jmp    801299 <strncpy+0x50>
  80126f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801273:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801277:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80127b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80127f:	0f b6 12             	movzbl (%rdx),%edx
  801282:	88 10                	mov    %dl,(%rax)
  801284:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801288:	0f b6 00             	movzbl (%rax),%eax
  80128b:	84 c0                	test   %al,%al
  80128d:	74 05                	je     801294 <strncpy+0x4b>
  80128f:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801294:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801299:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80129d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8012a1:	72 cc                	jb     80126f <strncpy+0x26>
  8012a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8012a7:	c9                   	leaveq 
  8012a8:	c3                   	retq   

00000000008012a9 <strlcpy>:
  8012a9:	55                   	push   %rbp
  8012aa:	48 89 e5             	mov    %rsp,%rbp
  8012ad:	48 83 ec 28          	sub    $0x28,%rsp
  8012b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012b9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012c5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8012ca:	74 3d                	je     801309 <strlcpy+0x60>
  8012cc:	eb 1d                	jmp    8012eb <strlcpy+0x42>
  8012ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012d2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8012d6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012da:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8012de:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8012e2:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8012e6:	0f b6 12             	movzbl (%rdx),%edx
  8012e9:	88 10                	mov    %dl,(%rax)
  8012eb:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8012f0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8012f5:	74 0b                	je     801302 <strlcpy+0x59>
  8012f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012fb:	0f b6 00             	movzbl (%rax),%eax
  8012fe:	84 c0                	test   %al,%al
  801300:	75 cc                	jne    8012ce <strlcpy+0x25>
  801302:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801306:	c6 00 00             	movb   $0x0,(%rax)
  801309:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80130d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801311:	48 29 c2             	sub    %rax,%rdx
  801314:	48 89 d0             	mov    %rdx,%rax
  801317:	c9                   	leaveq 
  801318:	c3                   	retq   

0000000000801319 <strcmp>:
  801319:	55                   	push   %rbp
  80131a:	48 89 e5             	mov    %rsp,%rbp
  80131d:	48 83 ec 10          	sub    $0x10,%rsp
  801321:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801325:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801329:	eb 0a                	jmp    801335 <strcmp+0x1c>
  80132b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801330:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801335:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801339:	0f b6 00             	movzbl (%rax),%eax
  80133c:	84 c0                	test   %al,%al
  80133e:	74 12                	je     801352 <strcmp+0x39>
  801340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801344:	0f b6 10             	movzbl (%rax),%edx
  801347:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80134b:	0f b6 00             	movzbl (%rax),%eax
  80134e:	38 c2                	cmp    %al,%dl
  801350:	74 d9                	je     80132b <strcmp+0x12>
  801352:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801356:	0f b6 00             	movzbl (%rax),%eax
  801359:	0f b6 d0             	movzbl %al,%edx
  80135c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801360:	0f b6 00             	movzbl (%rax),%eax
  801363:	0f b6 c0             	movzbl %al,%eax
  801366:	29 c2                	sub    %eax,%edx
  801368:	89 d0                	mov    %edx,%eax
  80136a:	c9                   	leaveq 
  80136b:	c3                   	retq   

000000000080136c <strncmp>:
  80136c:	55                   	push   %rbp
  80136d:	48 89 e5             	mov    %rsp,%rbp
  801370:	48 83 ec 18          	sub    $0x18,%rsp
  801374:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801378:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80137c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801380:	eb 0f                	jmp    801391 <strncmp+0x25>
  801382:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801387:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80138c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801391:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801396:	74 1d                	je     8013b5 <strncmp+0x49>
  801398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80139c:	0f b6 00             	movzbl (%rax),%eax
  80139f:	84 c0                	test   %al,%al
  8013a1:	74 12                	je     8013b5 <strncmp+0x49>
  8013a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013a7:	0f b6 10             	movzbl (%rax),%edx
  8013aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013ae:	0f b6 00             	movzbl (%rax),%eax
  8013b1:	38 c2                	cmp    %al,%dl
  8013b3:	74 cd                	je     801382 <strncmp+0x16>
  8013b5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8013ba:	75 07                	jne    8013c3 <strncmp+0x57>
  8013bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c1:	eb 18                	jmp    8013db <strncmp+0x6f>
  8013c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013c7:	0f b6 00             	movzbl (%rax),%eax
  8013ca:	0f b6 d0             	movzbl %al,%edx
  8013cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013d1:	0f b6 00             	movzbl (%rax),%eax
  8013d4:	0f b6 c0             	movzbl %al,%eax
  8013d7:	29 c2                	sub    %eax,%edx
  8013d9:	89 d0                	mov    %edx,%eax
  8013db:	c9                   	leaveq 
  8013dc:	c3                   	retq   

00000000008013dd <strchr>:
  8013dd:	55                   	push   %rbp
  8013de:	48 89 e5             	mov    %rsp,%rbp
  8013e1:	48 83 ec 0c          	sub    $0xc,%rsp
  8013e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8013e9:	89 f0                	mov    %esi,%eax
  8013eb:	88 45 f4             	mov    %al,-0xc(%rbp)
  8013ee:	eb 17                	jmp    801407 <strchr+0x2a>
  8013f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013f4:	0f b6 00             	movzbl (%rax),%eax
  8013f7:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8013fa:	75 06                	jne    801402 <strchr+0x25>
  8013fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801400:	eb 15                	jmp    801417 <strchr+0x3a>
  801402:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80140b:	0f b6 00             	movzbl (%rax),%eax
  80140e:	84 c0                	test   %al,%al
  801410:	75 de                	jne    8013f0 <strchr+0x13>
  801412:	b8 00 00 00 00       	mov    $0x0,%eax
  801417:	c9                   	leaveq 
  801418:	c3                   	retq   

0000000000801419 <strfind>:
  801419:	55                   	push   %rbp
  80141a:	48 89 e5             	mov    %rsp,%rbp
  80141d:	48 83 ec 0c          	sub    $0xc,%rsp
  801421:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801425:	89 f0                	mov    %esi,%eax
  801427:	88 45 f4             	mov    %al,-0xc(%rbp)
  80142a:	eb 13                	jmp    80143f <strfind+0x26>
  80142c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801430:	0f b6 00             	movzbl (%rax),%eax
  801433:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801436:	75 02                	jne    80143a <strfind+0x21>
  801438:	eb 10                	jmp    80144a <strfind+0x31>
  80143a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80143f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801443:	0f b6 00             	movzbl (%rax),%eax
  801446:	84 c0                	test   %al,%al
  801448:	75 e2                	jne    80142c <strfind+0x13>
  80144a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80144e:	c9                   	leaveq 
  80144f:	c3                   	retq   

0000000000801450 <memset>:
  801450:	55                   	push   %rbp
  801451:	48 89 e5             	mov    %rsp,%rbp
  801454:	48 83 ec 18          	sub    $0x18,%rsp
  801458:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80145c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80145f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801463:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801468:	75 06                	jne    801470 <memset+0x20>
  80146a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80146e:	eb 69                	jmp    8014d9 <memset+0x89>
  801470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801474:	83 e0 03             	and    $0x3,%eax
  801477:	48 85 c0             	test   %rax,%rax
  80147a:	75 48                	jne    8014c4 <memset+0x74>
  80147c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801480:	83 e0 03             	and    $0x3,%eax
  801483:	48 85 c0             	test   %rax,%rax
  801486:	75 3c                	jne    8014c4 <memset+0x74>
  801488:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80148f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801492:	c1 e0 18             	shl    $0x18,%eax
  801495:	89 c2                	mov    %eax,%edx
  801497:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80149a:	c1 e0 10             	shl    $0x10,%eax
  80149d:	09 c2                	or     %eax,%edx
  80149f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014a2:	c1 e0 08             	shl    $0x8,%eax
  8014a5:	09 d0                	or     %edx,%eax
  8014a7:	09 45 f4             	or     %eax,-0xc(%rbp)
  8014aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014ae:	48 c1 e8 02          	shr    $0x2,%rax
  8014b2:	48 89 c1             	mov    %rax,%rcx
  8014b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014b9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014bc:	48 89 d7             	mov    %rdx,%rdi
  8014bf:	fc                   	cld    
  8014c0:	f3 ab                	rep stos %eax,%es:(%rdi)
  8014c2:	eb 11                	jmp    8014d5 <memset+0x85>
  8014c4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8014c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8014cb:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8014cf:	48 89 d7             	mov    %rdx,%rdi
  8014d2:	fc                   	cld    
  8014d3:	f3 aa                	rep stos %al,%es:(%rdi)
  8014d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d9:	c9                   	leaveq 
  8014da:	c3                   	retq   

00000000008014db <memmove>:
  8014db:	55                   	push   %rbp
  8014dc:	48 89 e5             	mov    %rsp,%rbp
  8014df:	48 83 ec 28          	sub    $0x28,%rsp
  8014e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014eb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8014f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014fb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8014ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801503:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801507:	0f 83 88 00 00 00    	jae    801595 <memmove+0xba>
  80150d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801511:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801515:	48 01 d0             	add    %rdx,%rax
  801518:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80151c:	76 77                	jbe    801595 <memmove+0xba>
  80151e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801522:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801526:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80152a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  80152e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801532:	83 e0 03             	and    $0x3,%eax
  801535:	48 85 c0             	test   %rax,%rax
  801538:	75 3b                	jne    801575 <memmove+0x9a>
  80153a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80153e:	83 e0 03             	and    $0x3,%eax
  801541:	48 85 c0             	test   %rax,%rax
  801544:	75 2f                	jne    801575 <memmove+0x9a>
  801546:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80154a:	83 e0 03             	and    $0x3,%eax
  80154d:	48 85 c0             	test   %rax,%rax
  801550:	75 23                	jne    801575 <memmove+0x9a>
  801552:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801556:	48 83 e8 04          	sub    $0x4,%rax
  80155a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80155e:	48 83 ea 04          	sub    $0x4,%rdx
  801562:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801566:	48 c1 e9 02          	shr    $0x2,%rcx
  80156a:	48 89 c7             	mov    %rax,%rdi
  80156d:	48 89 d6             	mov    %rdx,%rsi
  801570:	fd                   	std    
  801571:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801573:	eb 1d                	jmp    801592 <memmove+0xb7>
  801575:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801579:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80157d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801581:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801585:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801589:	48 89 d7             	mov    %rdx,%rdi
  80158c:	48 89 c1             	mov    %rax,%rcx
  80158f:	fd                   	std    
  801590:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801592:	fc                   	cld    
  801593:	eb 57                	jmp    8015ec <memmove+0x111>
  801595:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801599:	83 e0 03             	and    $0x3,%eax
  80159c:	48 85 c0             	test   %rax,%rax
  80159f:	75 36                	jne    8015d7 <memmove+0xfc>
  8015a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015a5:	83 e0 03             	and    $0x3,%eax
  8015a8:	48 85 c0             	test   %rax,%rax
  8015ab:	75 2a                	jne    8015d7 <memmove+0xfc>
  8015ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015b1:	83 e0 03             	and    $0x3,%eax
  8015b4:	48 85 c0             	test   %rax,%rax
  8015b7:	75 1e                	jne    8015d7 <memmove+0xfc>
  8015b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015bd:	48 c1 e8 02          	shr    $0x2,%rax
  8015c1:	48 89 c1             	mov    %rax,%rcx
  8015c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015c8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015cc:	48 89 c7             	mov    %rax,%rdi
  8015cf:	48 89 d6             	mov    %rdx,%rsi
  8015d2:	fc                   	cld    
  8015d3:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8015d5:	eb 15                	jmp    8015ec <memmove+0x111>
  8015d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015df:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8015e3:	48 89 c7             	mov    %rax,%rdi
  8015e6:	48 89 d6             	mov    %rdx,%rsi
  8015e9:	fc                   	cld    
  8015ea:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8015ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015f0:	c9                   	leaveq 
  8015f1:	c3                   	retq   

00000000008015f2 <memcpy>:
  8015f2:	55                   	push   %rbp
  8015f3:	48 89 e5             	mov    %rsp,%rbp
  8015f6:	48 83 ec 18          	sub    $0x18,%rsp
  8015fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8015fe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801602:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801606:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80160a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80160e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801612:	48 89 ce             	mov    %rcx,%rsi
  801615:	48 89 c7             	mov    %rax,%rdi
  801618:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  80161f:	00 00 00 
  801622:	ff d0                	callq  *%rax
  801624:	c9                   	leaveq 
  801625:	c3                   	retq   

0000000000801626 <memcmp>:
  801626:	55                   	push   %rbp
  801627:	48 89 e5             	mov    %rsp,%rbp
  80162a:	48 83 ec 28          	sub    $0x28,%rsp
  80162e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801632:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801636:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80163a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80163e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801642:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801646:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80164a:	eb 36                	jmp    801682 <memcmp+0x5c>
  80164c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801650:	0f b6 10             	movzbl (%rax),%edx
  801653:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801657:	0f b6 00             	movzbl (%rax),%eax
  80165a:	38 c2                	cmp    %al,%dl
  80165c:	74 1a                	je     801678 <memcmp+0x52>
  80165e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801662:	0f b6 00             	movzbl (%rax),%eax
  801665:	0f b6 d0             	movzbl %al,%edx
  801668:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80166c:	0f b6 00             	movzbl (%rax),%eax
  80166f:	0f b6 c0             	movzbl %al,%eax
  801672:	29 c2                	sub    %eax,%edx
  801674:	89 d0                	mov    %edx,%eax
  801676:	eb 20                	jmp    801698 <memcmp+0x72>
  801678:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80167d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801682:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801686:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80168a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80168e:	48 85 c0             	test   %rax,%rax
  801691:	75 b9                	jne    80164c <memcmp+0x26>
  801693:	b8 00 00 00 00       	mov    $0x0,%eax
  801698:	c9                   	leaveq 
  801699:	c3                   	retq   

000000000080169a <memfind>:
  80169a:	55                   	push   %rbp
  80169b:	48 89 e5             	mov    %rsp,%rbp
  80169e:	48 83 ec 28          	sub    $0x28,%rsp
  8016a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8016a6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8016a9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016b1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8016b5:	48 01 d0             	add    %rdx,%rax
  8016b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8016bc:	eb 15                	jmp    8016d3 <memfind+0x39>
  8016be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016c2:	0f b6 10             	movzbl (%rax),%edx
  8016c5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8016c8:	38 c2                	cmp    %al,%dl
  8016ca:	75 02                	jne    8016ce <memfind+0x34>
  8016cc:	eb 0f                	jmp    8016dd <memfind+0x43>
  8016ce:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8016d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016d7:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8016db:	72 e1                	jb     8016be <memfind+0x24>
  8016dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016e1:	c9                   	leaveq 
  8016e2:	c3                   	retq   

00000000008016e3 <strtol>:
  8016e3:	55                   	push   %rbp
  8016e4:	48 89 e5             	mov    %rsp,%rbp
  8016e7:	48 83 ec 34          	sub    $0x34,%rsp
  8016eb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8016ef:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8016f3:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8016f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8016fd:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801704:	00 
  801705:	eb 05                	jmp    80170c <strtol+0x29>
  801707:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80170c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801710:	0f b6 00             	movzbl (%rax),%eax
  801713:	3c 20                	cmp    $0x20,%al
  801715:	74 f0                	je     801707 <strtol+0x24>
  801717:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80171b:	0f b6 00             	movzbl (%rax),%eax
  80171e:	3c 09                	cmp    $0x9,%al
  801720:	74 e5                	je     801707 <strtol+0x24>
  801722:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801726:	0f b6 00             	movzbl (%rax),%eax
  801729:	3c 2b                	cmp    $0x2b,%al
  80172b:	75 07                	jne    801734 <strtol+0x51>
  80172d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801732:	eb 17                	jmp    80174b <strtol+0x68>
  801734:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801738:	0f b6 00             	movzbl (%rax),%eax
  80173b:	3c 2d                	cmp    $0x2d,%al
  80173d:	75 0c                	jne    80174b <strtol+0x68>
  80173f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801744:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80174b:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80174f:	74 06                	je     801757 <strtol+0x74>
  801751:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801755:	75 28                	jne    80177f <strtol+0x9c>
  801757:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80175b:	0f b6 00             	movzbl (%rax),%eax
  80175e:	3c 30                	cmp    $0x30,%al
  801760:	75 1d                	jne    80177f <strtol+0x9c>
  801762:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801766:	48 83 c0 01          	add    $0x1,%rax
  80176a:	0f b6 00             	movzbl (%rax),%eax
  80176d:	3c 78                	cmp    $0x78,%al
  80176f:	75 0e                	jne    80177f <strtol+0x9c>
  801771:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801776:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  80177d:	eb 2c                	jmp    8017ab <strtol+0xc8>
  80177f:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801783:	75 19                	jne    80179e <strtol+0xbb>
  801785:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801789:	0f b6 00             	movzbl (%rax),%eax
  80178c:	3c 30                	cmp    $0x30,%al
  80178e:	75 0e                	jne    80179e <strtol+0xbb>
  801790:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801795:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  80179c:	eb 0d                	jmp    8017ab <strtol+0xc8>
  80179e:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8017a2:	75 07                	jne    8017ab <strtol+0xc8>
  8017a4:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  8017ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017af:	0f b6 00             	movzbl (%rax),%eax
  8017b2:	3c 2f                	cmp    $0x2f,%al
  8017b4:	7e 1d                	jle    8017d3 <strtol+0xf0>
  8017b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ba:	0f b6 00             	movzbl (%rax),%eax
  8017bd:	3c 39                	cmp    $0x39,%al
  8017bf:	7f 12                	jg     8017d3 <strtol+0xf0>
  8017c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017c5:	0f b6 00             	movzbl (%rax),%eax
  8017c8:	0f be c0             	movsbl %al,%eax
  8017cb:	83 e8 30             	sub    $0x30,%eax
  8017ce:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8017d1:	eb 4e                	jmp    801821 <strtol+0x13e>
  8017d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017d7:	0f b6 00             	movzbl (%rax),%eax
  8017da:	3c 60                	cmp    $0x60,%al
  8017dc:	7e 1d                	jle    8017fb <strtol+0x118>
  8017de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017e2:	0f b6 00             	movzbl (%rax),%eax
  8017e5:	3c 7a                	cmp    $0x7a,%al
  8017e7:	7f 12                	jg     8017fb <strtol+0x118>
  8017e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ed:	0f b6 00             	movzbl (%rax),%eax
  8017f0:	0f be c0             	movsbl %al,%eax
  8017f3:	83 e8 57             	sub    $0x57,%eax
  8017f6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8017f9:	eb 26                	jmp    801821 <strtol+0x13e>
  8017fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017ff:	0f b6 00             	movzbl (%rax),%eax
  801802:	3c 40                	cmp    $0x40,%al
  801804:	7e 48                	jle    80184e <strtol+0x16b>
  801806:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80180a:	0f b6 00             	movzbl (%rax),%eax
  80180d:	3c 5a                	cmp    $0x5a,%al
  80180f:	7f 3d                	jg     80184e <strtol+0x16b>
  801811:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801815:	0f b6 00             	movzbl (%rax),%eax
  801818:	0f be c0             	movsbl %al,%eax
  80181b:	83 e8 37             	sub    $0x37,%eax
  80181e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801821:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801824:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801827:	7c 02                	jl     80182b <strtol+0x148>
  801829:	eb 23                	jmp    80184e <strtol+0x16b>
  80182b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801830:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801833:	48 98                	cltq   
  801835:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  80183a:	48 89 c2             	mov    %rax,%rdx
  80183d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801840:	48 98                	cltq   
  801842:	48 01 d0             	add    %rdx,%rax
  801845:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801849:	e9 5d ff ff ff       	jmpq   8017ab <strtol+0xc8>
  80184e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801853:	74 0b                	je     801860 <strtol+0x17d>
  801855:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801859:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80185d:	48 89 10             	mov    %rdx,(%rax)
  801860:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801864:	74 09                	je     80186f <strtol+0x18c>
  801866:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80186a:	48 f7 d8             	neg    %rax
  80186d:	eb 04                	jmp    801873 <strtol+0x190>
  80186f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801873:	c9                   	leaveq 
  801874:	c3                   	retq   

0000000000801875 <strstr>:
  801875:	55                   	push   %rbp
  801876:	48 89 e5             	mov    %rsp,%rbp
  801879:	48 83 ec 30          	sub    $0x30,%rsp
  80187d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801881:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801885:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801889:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80188d:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801891:	0f b6 00             	movzbl (%rax),%eax
  801894:	88 45 ff             	mov    %al,-0x1(%rbp)
  801897:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  80189b:	75 06                	jne    8018a3 <strstr+0x2e>
  80189d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018a1:	eb 6b                	jmp    80190e <strstr+0x99>
  8018a3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018a7:	48 89 c7             	mov    %rax,%rdi
  8018aa:	48 b8 4b 11 80 00 00 	movabs $0x80114b,%rax
  8018b1:	00 00 00 
  8018b4:	ff d0                	callq  *%rax
  8018b6:	48 98                	cltq   
  8018b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8018bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018c0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8018c4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018c8:	0f b6 00             	movzbl (%rax),%eax
  8018cb:	88 45 ef             	mov    %al,-0x11(%rbp)
  8018ce:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8018d2:	75 07                	jne    8018db <strstr+0x66>
  8018d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8018d9:	eb 33                	jmp    80190e <strstr+0x99>
  8018db:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8018df:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8018e2:	75 d8                	jne    8018bc <strstr+0x47>
  8018e4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018e8:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8018ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018f0:	48 89 ce             	mov    %rcx,%rsi
  8018f3:	48 89 c7             	mov    %rax,%rdi
  8018f6:	48 b8 6c 13 80 00 00 	movabs $0x80136c,%rax
  8018fd:	00 00 00 
  801900:	ff d0                	callq  *%rax
  801902:	85 c0                	test   %eax,%eax
  801904:	75 b6                	jne    8018bc <strstr+0x47>
  801906:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80190a:	48 83 e8 01          	sub    $0x1,%rax
  80190e:	c9                   	leaveq 
  80190f:	c3                   	retq   

0000000000801910 <syscall>:
  801910:	55                   	push   %rbp
  801911:	48 89 e5             	mov    %rsp,%rbp
  801914:	53                   	push   %rbx
  801915:	48 83 ec 48          	sub    $0x48,%rsp
  801919:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80191c:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80191f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801923:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801927:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  80192b:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  80192f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801932:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801936:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  80193a:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  80193e:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801942:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801946:	4c 89 c3             	mov    %r8,%rbx
  801949:	cd 30                	int    $0x30
  80194b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80194f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801953:	74 3e                	je     801993 <syscall+0x83>
  801955:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80195a:	7e 37                	jle    801993 <syscall+0x83>
  80195c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801960:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801963:	49 89 d0             	mov    %rdx,%r8
  801966:	89 c1                	mov    %eax,%ecx
  801968:	48 ba 68 4f 80 00 00 	movabs $0x804f68,%rdx
  80196f:	00 00 00 
  801972:	be 24 00 00 00       	mov    $0x24,%esi
  801977:	48 bf 85 4f 80 00 00 	movabs $0x804f85,%rdi
  80197e:	00 00 00 
  801981:	b8 00 00 00 00       	mov    $0x0,%eax
  801986:	49 b9 c9 03 80 00 00 	movabs $0x8003c9,%r9
  80198d:	00 00 00 
  801990:	41 ff d1             	callq  *%r9
  801993:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801997:	48 83 c4 48          	add    $0x48,%rsp
  80199b:	5b                   	pop    %rbx
  80199c:	5d                   	pop    %rbp
  80199d:	c3                   	retq   

000000000080199e <sys_cputs>:
  80199e:	55                   	push   %rbp
  80199f:	48 89 e5             	mov    %rsp,%rbp
  8019a2:	48 83 ec 20          	sub    $0x20,%rsp
  8019a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8019aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019b2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019b6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019bd:	00 
  8019be:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019c4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019ca:	48 89 d1             	mov    %rdx,%rcx
  8019cd:	48 89 c2             	mov    %rax,%rdx
  8019d0:	be 00 00 00 00       	mov    $0x0,%esi
  8019d5:	bf 00 00 00 00       	mov    $0x0,%edi
  8019da:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  8019e1:	00 00 00 
  8019e4:	ff d0                	callq  *%rax
  8019e6:	c9                   	leaveq 
  8019e7:	c3                   	retq   

00000000008019e8 <sys_cgetc>:
  8019e8:	55                   	push   %rbp
  8019e9:	48 89 e5             	mov    %rsp,%rbp
  8019ec:	48 83 ec 10          	sub    $0x10,%rsp
  8019f0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019f7:	00 
  8019f8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019fe:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a04:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a09:	ba 00 00 00 00       	mov    $0x0,%edx
  801a0e:	be 00 00 00 00       	mov    $0x0,%esi
  801a13:	bf 01 00 00 00       	mov    $0x1,%edi
  801a18:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801a1f:	00 00 00 
  801a22:	ff d0                	callq  *%rax
  801a24:	c9                   	leaveq 
  801a25:	c3                   	retq   

0000000000801a26 <sys_env_destroy>:
  801a26:	55                   	push   %rbp
  801a27:	48 89 e5             	mov    %rsp,%rbp
  801a2a:	48 83 ec 10          	sub    $0x10,%rsp
  801a2e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a31:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a34:	48 98                	cltq   
  801a36:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a3d:	00 
  801a3e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a44:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a4a:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a4f:	48 89 c2             	mov    %rax,%rdx
  801a52:	be 01 00 00 00       	mov    $0x1,%esi
  801a57:	bf 03 00 00 00       	mov    $0x3,%edi
  801a5c:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801a63:	00 00 00 
  801a66:	ff d0                	callq  *%rax
  801a68:	c9                   	leaveq 
  801a69:	c3                   	retq   

0000000000801a6a <sys_getenvid>:
  801a6a:	55                   	push   %rbp
  801a6b:	48 89 e5             	mov    %rsp,%rbp
  801a6e:	48 83 ec 10          	sub    $0x10,%rsp
  801a72:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a79:	00 
  801a7a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a80:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a86:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a8b:	ba 00 00 00 00       	mov    $0x0,%edx
  801a90:	be 00 00 00 00       	mov    $0x0,%esi
  801a95:	bf 02 00 00 00       	mov    $0x2,%edi
  801a9a:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801aa1:	00 00 00 
  801aa4:	ff d0                	callq  *%rax
  801aa6:	c9                   	leaveq 
  801aa7:	c3                   	retq   

0000000000801aa8 <sys_yield>:
  801aa8:	55                   	push   %rbp
  801aa9:	48 89 e5             	mov    %rsp,%rbp
  801aac:	48 83 ec 10          	sub    $0x10,%rsp
  801ab0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ab7:	00 
  801ab8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801abe:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ac4:	b9 00 00 00 00       	mov    $0x0,%ecx
  801ac9:	ba 00 00 00 00       	mov    $0x0,%edx
  801ace:	be 00 00 00 00       	mov    $0x0,%esi
  801ad3:	bf 0b 00 00 00       	mov    $0xb,%edi
  801ad8:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801adf:	00 00 00 
  801ae2:	ff d0                	callq  *%rax
  801ae4:	c9                   	leaveq 
  801ae5:	c3                   	retq   

0000000000801ae6 <sys_page_alloc>:
  801ae6:	55                   	push   %rbp
  801ae7:	48 89 e5             	mov    %rsp,%rbp
  801aea:	48 83 ec 20          	sub    $0x20,%rsp
  801aee:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801af1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801af5:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801af8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801afb:	48 63 c8             	movslq %eax,%rcx
  801afe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b05:	48 98                	cltq   
  801b07:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b0e:	00 
  801b0f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b15:	49 89 c8             	mov    %rcx,%r8
  801b18:	48 89 d1             	mov    %rdx,%rcx
  801b1b:	48 89 c2             	mov    %rax,%rdx
  801b1e:	be 01 00 00 00       	mov    $0x1,%esi
  801b23:	bf 04 00 00 00       	mov    $0x4,%edi
  801b28:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801b2f:	00 00 00 
  801b32:	ff d0                	callq  *%rax
  801b34:	c9                   	leaveq 
  801b35:	c3                   	retq   

0000000000801b36 <sys_page_map>:
  801b36:	55                   	push   %rbp
  801b37:	48 89 e5             	mov    %rsp,%rbp
  801b3a:	48 83 ec 30          	sub    $0x30,%rsp
  801b3e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b41:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801b45:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801b48:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801b4c:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801b50:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801b53:	48 63 c8             	movslq %eax,%rcx
  801b56:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801b5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801b5d:	48 63 f0             	movslq %eax,%rsi
  801b60:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b64:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b67:	48 98                	cltq   
  801b69:	48 89 0c 24          	mov    %rcx,(%rsp)
  801b6d:	49 89 f9             	mov    %rdi,%r9
  801b70:	49 89 f0             	mov    %rsi,%r8
  801b73:	48 89 d1             	mov    %rdx,%rcx
  801b76:	48 89 c2             	mov    %rax,%rdx
  801b79:	be 01 00 00 00       	mov    $0x1,%esi
  801b7e:	bf 05 00 00 00       	mov    $0x5,%edi
  801b83:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801b8a:	00 00 00 
  801b8d:	ff d0                	callq  *%rax
  801b8f:	c9                   	leaveq 
  801b90:	c3                   	retq   

0000000000801b91 <sys_page_unmap>:
  801b91:	55                   	push   %rbp
  801b92:	48 89 e5             	mov    %rsp,%rbp
  801b95:	48 83 ec 20          	sub    $0x20,%rsp
  801b99:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b9c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ba0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ba4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ba7:	48 98                	cltq   
  801ba9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bb0:	00 
  801bb1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bb7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bbd:	48 89 d1             	mov    %rdx,%rcx
  801bc0:	48 89 c2             	mov    %rax,%rdx
  801bc3:	be 01 00 00 00       	mov    $0x1,%esi
  801bc8:	bf 06 00 00 00       	mov    $0x6,%edi
  801bcd:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801bd4:	00 00 00 
  801bd7:	ff d0                	callq  *%rax
  801bd9:	c9                   	leaveq 
  801bda:	c3                   	retq   

0000000000801bdb <sys_env_set_status>:
  801bdb:	55                   	push   %rbp
  801bdc:	48 89 e5             	mov    %rsp,%rbp
  801bdf:	48 83 ec 10          	sub    $0x10,%rsp
  801be3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801be6:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801be9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bec:	48 63 d0             	movslq %eax,%rdx
  801bef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bf2:	48 98                	cltq   
  801bf4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bfb:	00 
  801bfc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c02:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c08:	48 89 d1             	mov    %rdx,%rcx
  801c0b:	48 89 c2             	mov    %rax,%rdx
  801c0e:	be 01 00 00 00       	mov    $0x1,%esi
  801c13:	bf 08 00 00 00       	mov    $0x8,%edi
  801c18:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801c1f:	00 00 00 
  801c22:	ff d0                	callq  *%rax
  801c24:	c9                   	leaveq 
  801c25:	c3                   	retq   

0000000000801c26 <sys_env_set_trapframe>:
  801c26:	55                   	push   %rbp
  801c27:	48 89 e5             	mov    %rsp,%rbp
  801c2a:	48 83 ec 20          	sub    $0x20,%rsp
  801c2e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c31:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c35:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c39:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c3c:	48 98                	cltq   
  801c3e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c45:	00 
  801c46:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c4c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c52:	48 89 d1             	mov    %rdx,%rcx
  801c55:	48 89 c2             	mov    %rax,%rdx
  801c58:	be 01 00 00 00       	mov    $0x1,%esi
  801c5d:	bf 09 00 00 00       	mov    $0x9,%edi
  801c62:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801c69:	00 00 00 
  801c6c:	ff d0                	callq  *%rax
  801c6e:	c9                   	leaveq 
  801c6f:	c3                   	retq   

0000000000801c70 <sys_env_set_pgfault_upcall>:
  801c70:	55                   	push   %rbp
  801c71:	48 89 e5             	mov    %rsp,%rbp
  801c74:	48 83 ec 20          	sub    $0x20,%rsp
  801c78:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c7b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c7f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c83:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c86:	48 98                	cltq   
  801c88:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c8f:	00 
  801c90:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c96:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c9c:	48 89 d1             	mov    %rdx,%rcx
  801c9f:	48 89 c2             	mov    %rax,%rdx
  801ca2:	be 01 00 00 00       	mov    $0x1,%esi
  801ca7:	bf 0a 00 00 00       	mov    $0xa,%edi
  801cac:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801cb3:	00 00 00 
  801cb6:	ff d0                	callq  *%rax
  801cb8:	c9                   	leaveq 
  801cb9:	c3                   	retq   

0000000000801cba <sys_ipc_try_send>:
  801cba:	55                   	push   %rbp
  801cbb:	48 89 e5             	mov    %rsp,%rbp
  801cbe:	48 83 ec 20          	sub    $0x20,%rsp
  801cc2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cc5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801cc9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801ccd:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801cd0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801cd3:	48 63 f0             	movslq %eax,%rsi
  801cd6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801cda:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cdd:	48 98                	cltq   
  801cdf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ce3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cea:	00 
  801ceb:	49 89 f1             	mov    %rsi,%r9
  801cee:	49 89 c8             	mov    %rcx,%r8
  801cf1:	48 89 d1             	mov    %rdx,%rcx
  801cf4:	48 89 c2             	mov    %rax,%rdx
  801cf7:	be 00 00 00 00       	mov    $0x0,%esi
  801cfc:	bf 0c 00 00 00       	mov    $0xc,%edi
  801d01:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801d08:	00 00 00 
  801d0b:	ff d0                	callq  *%rax
  801d0d:	c9                   	leaveq 
  801d0e:	c3                   	retq   

0000000000801d0f <sys_ipc_recv>:
  801d0f:	55                   	push   %rbp
  801d10:	48 89 e5             	mov    %rsp,%rbp
  801d13:	48 83 ec 10          	sub    $0x10,%rsp
  801d17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d1f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d26:	00 
  801d27:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d2d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d33:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d38:	48 89 c2             	mov    %rax,%rdx
  801d3b:	be 01 00 00 00       	mov    $0x1,%esi
  801d40:	bf 0d 00 00 00       	mov    $0xd,%edi
  801d45:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801d4c:	00 00 00 
  801d4f:	ff d0                	callq  *%rax
  801d51:	c9                   	leaveq 
  801d52:	c3                   	retq   

0000000000801d53 <sys_time_msec>:
  801d53:	55                   	push   %rbp
  801d54:	48 89 e5             	mov    %rsp,%rbp
  801d57:	48 83 ec 10          	sub    $0x10,%rsp
  801d5b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d62:	00 
  801d63:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d69:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d6f:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d74:	ba 00 00 00 00       	mov    $0x0,%edx
  801d79:	be 00 00 00 00       	mov    $0x0,%esi
  801d7e:	bf 0e 00 00 00       	mov    $0xe,%edi
  801d83:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801d8a:	00 00 00 
  801d8d:	ff d0                	callq  *%rax
  801d8f:	c9                   	leaveq 
  801d90:	c3                   	retq   

0000000000801d91 <sys_net_transmit>:
  801d91:	55                   	push   %rbp
  801d92:	48 89 e5             	mov    %rsp,%rbp
  801d95:	48 83 ec 20          	sub    $0x20,%rsp
  801d99:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d9d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801da0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801da3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801da7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801dae:	00 
  801daf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801db5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801dbb:	48 89 d1             	mov    %rdx,%rcx
  801dbe:	48 89 c2             	mov    %rax,%rdx
  801dc1:	be 00 00 00 00       	mov    $0x0,%esi
  801dc6:	bf 0f 00 00 00       	mov    $0xf,%edi
  801dcb:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801dd2:	00 00 00 
  801dd5:	ff d0                	callq  *%rax
  801dd7:	c9                   	leaveq 
  801dd8:	c3                   	retq   

0000000000801dd9 <sys_net_receive>:
  801dd9:	55                   	push   %rbp
  801dda:	48 89 e5             	mov    %rsp,%rbp
  801ddd:	48 83 ec 20          	sub    $0x20,%rsp
  801de1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801de5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801de8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801def:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801df6:	00 
  801df7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801dfd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e03:	48 89 d1             	mov    %rdx,%rcx
  801e06:	48 89 c2             	mov    %rax,%rdx
  801e09:	be 00 00 00 00       	mov    $0x0,%esi
  801e0e:	bf 10 00 00 00       	mov    $0x10,%edi
  801e13:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801e1a:	00 00 00 
  801e1d:	ff d0                	callq  *%rax
  801e1f:	c9                   	leaveq 
  801e20:	c3                   	retq   

0000000000801e21 <sys_ept_map>:
  801e21:	55                   	push   %rbp
  801e22:	48 89 e5             	mov    %rsp,%rbp
  801e25:	48 83 ec 30          	sub    $0x30,%rsp
  801e29:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e2c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e30:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e33:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801e37:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801e3b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801e3e:	48 63 c8             	movslq %eax,%rcx
  801e41:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801e45:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e48:	48 63 f0             	movslq %eax,%rsi
  801e4b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e52:	48 98                	cltq   
  801e54:	48 89 0c 24          	mov    %rcx,(%rsp)
  801e58:	49 89 f9             	mov    %rdi,%r9
  801e5b:	49 89 f0             	mov    %rsi,%r8
  801e5e:	48 89 d1             	mov    %rdx,%rcx
  801e61:	48 89 c2             	mov    %rax,%rdx
  801e64:	be 00 00 00 00       	mov    $0x0,%esi
  801e69:	bf 11 00 00 00       	mov    $0x11,%edi
  801e6e:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801e75:	00 00 00 
  801e78:	ff d0                	callq  *%rax
  801e7a:	c9                   	leaveq 
  801e7b:	c3                   	retq   

0000000000801e7c <sys_env_mkguest>:
  801e7c:	55                   	push   %rbp
  801e7d:	48 89 e5             	mov    %rsp,%rbp
  801e80:	48 83 ec 20          	sub    $0x20,%rsp
  801e84:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e88:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e8c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e94:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e9b:	00 
  801e9c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ea2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ea8:	48 89 d1             	mov    %rdx,%rcx
  801eab:	48 89 c2             	mov    %rax,%rdx
  801eae:	be 00 00 00 00       	mov    $0x0,%esi
  801eb3:	bf 12 00 00 00       	mov    $0x12,%edi
  801eb8:	48 b8 10 19 80 00 00 	movabs $0x801910,%rax
  801ebf:	00 00 00 
  801ec2:	ff d0                	callq  *%rax
  801ec4:	c9                   	leaveq 
  801ec5:	c3                   	retq   

0000000000801ec6 <pgfault>:
  801ec6:	55                   	push   %rbp
  801ec7:	48 89 e5             	mov    %rsp,%rbp
  801eca:	48 83 ec 30          	sub    $0x30,%rsp
  801ece:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801ed2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ed6:	48 8b 00             	mov    (%rax),%rax
  801ed9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801edd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ee1:	48 8b 40 08          	mov    0x8(%rax),%rax
  801ee5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ee8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801eeb:	83 e0 02             	and    $0x2,%eax
  801eee:	85 c0                	test   %eax,%eax
  801ef0:	75 40                	jne    801f32 <pgfault+0x6c>
  801ef2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ef6:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801efd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f01:	49 89 d0             	mov    %rdx,%r8
  801f04:	48 89 c1             	mov    %rax,%rcx
  801f07:	48 ba 98 4f 80 00 00 	movabs $0x804f98,%rdx
  801f0e:	00 00 00 
  801f11:	be 1f 00 00 00       	mov    $0x1f,%esi
  801f16:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  801f1d:	00 00 00 
  801f20:	b8 00 00 00 00       	mov    $0x0,%eax
  801f25:	49 b9 c9 03 80 00 00 	movabs $0x8003c9,%r9
  801f2c:	00 00 00 
  801f2f:	41 ff d1             	callq  *%r9
  801f32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f36:	48 c1 e8 0c          	shr    $0xc,%rax
  801f3a:	48 89 c2             	mov    %rax,%rdx
  801f3d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f44:	01 00 00 
  801f47:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f4b:	25 07 08 00 00       	and    $0x807,%eax
  801f50:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  801f56:	74 4e                	je     801fa6 <pgfault+0xe0>
  801f58:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f5c:	48 c1 e8 0c          	shr    $0xc,%rax
  801f60:	48 89 c2             	mov    %rax,%rdx
  801f63:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801f6a:	01 00 00 
  801f6d:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801f71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f75:	49 89 d0             	mov    %rdx,%r8
  801f78:	48 89 c1             	mov    %rax,%rcx
  801f7b:	48 ba c0 4f 80 00 00 	movabs $0x804fc0,%rdx
  801f82:	00 00 00 
  801f85:	be 22 00 00 00       	mov    $0x22,%esi
  801f8a:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  801f91:	00 00 00 
  801f94:	b8 00 00 00 00       	mov    $0x0,%eax
  801f99:	49 b9 c9 03 80 00 00 	movabs $0x8003c9,%r9
  801fa0:	00 00 00 
  801fa3:	41 ff d1             	callq  *%r9
  801fa6:	ba 07 00 00 00       	mov    $0x7,%edx
  801fab:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  801fb0:	bf 00 00 00 00       	mov    $0x0,%edi
  801fb5:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  801fbc:	00 00 00 
  801fbf:	ff d0                	callq  *%rax
  801fc1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801fc4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801fc8:	79 30                	jns    801ffa <pgfault+0x134>
  801fca:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801fcd:	89 c1                	mov    %eax,%ecx
  801fcf:	48 ba eb 4f 80 00 00 	movabs $0x804feb,%rdx
  801fd6:	00 00 00 
  801fd9:	be 30 00 00 00       	mov    $0x30,%esi
  801fde:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  801fe5:	00 00 00 
  801fe8:	b8 00 00 00 00       	mov    $0x0,%eax
  801fed:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  801ff4:	00 00 00 
  801ff7:	41 ff d0             	callq  *%r8
  801ffa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ffe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802002:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802006:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  80200c:	ba 00 10 00 00       	mov    $0x1000,%edx
  802011:	48 89 c6             	mov    %rax,%rsi
  802014:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  802019:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  802020:	00 00 00 
  802023:	ff d0                	callq  *%rax
  802025:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802029:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80202d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802031:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802037:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  80203d:	48 89 c1             	mov    %rax,%rcx
  802040:	ba 00 00 00 00       	mov    $0x0,%edx
  802045:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  80204a:	bf 00 00 00 00       	mov    $0x0,%edi
  80204f:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  802056:	00 00 00 
  802059:	ff d0                	callq  *%rax
  80205b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80205e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802062:	79 30                	jns    802094 <pgfault+0x1ce>
  802064:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802067:	89 c1                	mov    %eax,%ecx
  802069:	48 ba fe 4f 80 00 00 	movabs $0x804ffe,%rdx
  802070:	00 00 00 
  802073:	be 35 00 00 00       	mov    $0x35,%esi
  802078:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  80207f:	00 00 00 
  802082:	b8 00 00 00 00       	mov    $0x0,%eax
  802087:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  80208e:	00 00 00 
  802091:	41 ff d0             	callq  *%r8
  802094:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802099:	bf 00 00 00 00       	mov    $0x0,%edi
  80209e:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  8020a5:	00 00 00 
  8020a8:	ff d0                	callq  *%rax
  8020aa:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8020ad:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8020b1:	79 30                	jns    8020e3 <pgfault+0x21d>
  8020b3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020b6:	89 c1                	mov    %eax,%ecx
  8020b8:	48 ba 0f 50 80 00 00 	movabs $0x80500f,%rdx
  8020bf:	00 00 00 
  8020c2:	be 39 00 00 00       	mov    $0x39,%esi
  8020c7:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  8020ce:	00 00 00 
  8020d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8020d6:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8020dd:	00 00 00 
  8020e0:	41 ff d0             	callq  *%r8
  8020e3:	c9                   	leaveq 
  8020e4:	c3                   	retq   

00000000008020e5 <duppage>:
  8020e5:	55                   	push   %rbp
  8020e6:	48 89 e5             	mov    %rsp,%rbp
  8020e9:	48 83 ec 30          	sub    $0x30,%rsp
  8020ed:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8020f0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8020f3:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8020f6:	c1 e0 0c             	shl    $0xc,%eax
  8020f9:	89 c0                	mov    %eax,%eax
  8020fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8020ff:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802106:	01 00 00 
  802109:	8b 55 d8             	mov    -0x28(%rbp),%edx
  80210c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802110:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802114:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802118:	25 02 08 00 00       	and    $0x802,%eax
  80211d:	48 85 c0             	test   %rax,%rax
  802120:	74 0e                	je     802130 <duppage+0x4b>
  802122:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802126:	25 00 04 00 00       	and    $0x400,%eax
  80212b:	48 85 c0             	test   %rax,%rax
  80212e:	74 70                	je     8021a0 <duppage+0xbb>
  802130:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802134:	25 07 0e 00 00       	and    $0xe07,%eax
  802139:	89 c6                	mov    %eax,%esi
  80213b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  80213f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802142:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802146:	41 89 f0             	mov    %esi,%r8d
  802149:	48 89 c6             	mov    %rax,%rsi
  80214c:	bf 00 00 00 00       	mov    $0x0,%edi
  802151:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  802158:	00 00 00 
  80215b:	ff d0                	callq  *%rax
  80215d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802160:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802164:	79 30                	jns    802196 <duppage+0xb1>
  802166:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802169:	89 c1                	mov    %eax,%ecx
  80216b:	48 ba fe 4f 80 00 00 	movabs $0x804ffe,%rdx
  802172:	00 00 00 
  802175:	be 63 00 00 00       	mov    $0x63,%esi
  80217a:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  802181:	00 00 00 
  802184:	b8 00 00 00 00       	mov    $0x0,%eax
  802189:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  802190:	00 00 00 
  802193:	41 ff d0             	callq  *%r8
  802196:	b8 00 00 00 00       	mov    $0x0,%eax
  80219b:	e9 c4 00 00 00       	jmpq   802264 <duppage+0x17f>
  8021a0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8021a4:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8021a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8021ab:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8021b1:	48 89 c6             	mov    %rax,%rsi
  8021b4:	bf 00 00 00 00       	mov    $0x0,%edi
  8021b9:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  8021c0:	00 00 00 
  8021c3:	ff d0                	callq  *%rax
  8021c5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8021c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8021cc:	79 30                	jns    8021fe <duppage+0x119>
  8021ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8021d1:	89 c1                	mov    %eax,%ecx
  8021d3:	48 ba fe 4f 80 00 00 	movabs $0x804ffe,%rdx
  8021da:	00 00 00 
  8021dd:	be 7e 00 00 00       	mov    $0x7e,%esi
  8021e2:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  8021e9:	00 00 00 
  8021ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8021f1:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8021f8:	00 00 00 
  8021fb:	41 ff d0             	callq  *%r8
  8021fe:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802206:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  80220c:	48 89 d1             	mov    %rdx,%rcx
  80220f:	ba 00 00 00 00       	mov    $0x0,%edx
  802214:	48 89 c6             	mov    %rax,%rsi
  802217:	bf 00 00 00 00       	mov    $0x0,%edi
  80221c:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  802223:	00 00 00 
  802226:	ff d0                	callq  *%rax
  802228:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80222b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80222f:	79 30                	jns    802261 <duppage+0x17c>
  802231:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802234:	89 c1                	mov    %eax,%ecx
  802236:	48 ba fe 4f 80 00 00 	movabs $0x804ffe,%rdx
  80223d:	00 00 00 
  802240:	be 80 00 00 00       	mov    $0x80,%esi
  802245:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  80224c:	00 00 00 
  80224f:	b8 00 00 00 00       	mov    $0x0,%eax
  802254:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  80225b:	00 00 00 
  80225e:	41 ff d0             	callq  *%r8
  802261:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802264:	c9                   	leaveq 
  802265:	c3                   	retq   

0000000000802266 <fork>:
  802266:	55                   	push   %rbp
  802267:	48 89 e5             	mov    %rsp,%rbp
  80226a:	48 83 ec 20          	sub    $0x20,%rsp
  80226e:	48 bf c6 1e 80 00 00 	movabs $0x801ec6,%rdi
  802275:	00 00 00 
  802278:	48 b8 8e 45 80 00 00 	movabs $0x80458e,%rax
  80227f:	00 00 00 
  802282:	ff d0                	callq  *%rax
  802284:	b8 07 00 00 00       	mov    $0x7,%eax
  802289:	cd 30                	int    $0x30
  80228b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80228e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802291:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802294:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802298:	79 08                	jns    8022a2 <fork+0x3c>
  80229a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80229d:	e9 09 02 00 00       	jmpq   8024ab <fork+0x245>
  8022a2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022a6:	75 3e                	jne    8022e6 <fork+0x80>
  8022a8:	48 b8 6a 1a 80 00 00 	movabs $0x801a6a,%rax
  8022af:	00 00 00 
  8022b2:	ff d0                	callq  *%rax
  8022b4:	25 ff 03 00 00       	and    $0x3ff,%eax
  8022b9:	48 98                	cltq   
  8022bb:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8022c2:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8022c9:	00 00 00 
  8022cc:	48 01 c2             	add    %rax,%rdx
  8022cf:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8022d6:	00 00 00 
  8022d9:	48 89 10             	mov    %rdx,(%rax)
  8022dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8022e1:	e9 c5 01 00 00       	jmpq   8024ab <fork+0x245>
  8022e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8022ed:	e9 a4 00 00 00       	jmpq   802396 <fork+0x130>
  8022f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022f5:	c1 f8 12             	sar    $0x12,%eax
  8022f8:	89 c2                	mov    %eax,%edx
  8022fa:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  802301:	01 00 00 
  802304:	48 63 d2             	movslq %edx,%rdx
  802307:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80230b:	83 e0 01             	and    $0x1,%eax
  80230e:	48 85 c0             	test   %rax,%rax
  802311:	74 21                	je     802334 <fork+0xce>
  802313:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802316:	c1 f8 09             	sar    $0x9,%eax
  802319:	89 c2                	mov    %eax,%edx
  80231b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802322:	01 00 00 
  802325:	48 63 d2             	movslq %edx,%rdx
  802328:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80232c:	83 e0 01             	and    $0x1,%eax
  80232f:	48 85 c0             	test   %rax,%rax
  802332:	75 09                	jne    80233d <fork+0xd7>
  802334:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  80233b:	eb 59                	jmp    802396 <fork+0x130>
  80233d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802340:	05 00 02 00 00       	add    $0x200,%eax
  802345:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802348:	eb 44                	jmp    80238e <fork+0x128>
  80234a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802351:	01 00 00 
  802354:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802357:	48 63 d2             	movslq %edx,%rdx
  80235a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80235e:	83 e0 05             	and    $0x5,%eax
  802361:	48 83 f8 05          	cmp    $0x5,%rax
  802365:	74 02                	je     802369 <fork+0x103>
  802367:	eb 21                	jmp    80238a <fork+0x124>
  802369:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  802370:	75 02                	jne    802374 <fork+0x10e>
  802372:	eb 16                	jmp    80238a <fork+0x124>
  802374:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802377:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80237a:	89 d6                	mov    %edx,%esi
  80237c:	89 c7                	mov    %eax,%edi
  80237e:	48 b8 e5 20 80 00 00 	movabs $0x8020e5,%rax
  802385:	00 00 00 
  802388:	ff d0                	callq  *%rax
  80238a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80238e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802391:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  802394:	7c b4                	jl     80234a <fork+0xe4>
  802396:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802399:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  80239e:	0f 86 4e ff ff ff    	jbe    8022f2 <fork+0x8c>
  8023a4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023a7:	ba 07 00 00 00       	mov    $0x7,%edx
  8023ac:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8023b1:	89 c7                	mov    %eax,%edi
  8023b3:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  8023ba:	00 00 00 
  8023bd:	ff d0                	callq  *%rax
  8023bf:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8023c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8023c6:	79 30                	jns    8023f8 <fork+0x192>
  8023c8:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8023cb:	89 c1                	mov    %eax,%ecx
  8023cd:	48 ba 28 50 80 00 00 	movabs $0x805028,%rdx
  8023d4:	00 00 00 
  8023d7:	be bc 00 00 00       	mov    $0xbc,%esi
  8023dc:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  8023e3:	00 00 00 
  8023e6:	b8 00 00 00 00       	mov    $0x0,%eax
  8023eb:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8023f2:	00 00 00 
  8023f5:	41 ff d0             	callq  *%r8
  8023f8:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8023ff:	00 00 00 
  802402:	48 8b 00             	mov    (%rax),%rax
  802405:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  80240c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80240f:	48 89 d6             	mov    %rdx,%rsi
  802412:	89 c7                	mov    %eax,%edi
  802414:	48 b8 70 1c 80 00 00 	movabs $0x801c70,%rax
  80241b:	00 00 00 
  80241e:	ff d0                	callq  *%rax
  802420:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802423:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802427:	79 30                	jns    802459 <fork+0x1f3>
  802429:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80242c:	89 c1                	mov    %eax,%ecx
  80242e:	48 ba 48 50 80 00 00 	movabs $0x805048,%rdx
  802435:	00 00 00 
  802438:	be c0 00 00 00       	mov    $0xc0,%esi
  80243d:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  802444:	00 00 00 
  802447:	b8 00 00 00 00       	mov    $0x0,%eax
  80244c:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  802453:	00 00 00 
  802456:	41 ff d0             	callq  *%r8
  802459:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80245c:	be 02 00 00 00       	mov    $0x2,%esi
  802461:	89 c7                	mov    %eax,%edi
  802463:	48 b8 db 1b 80 00 00 	movabs $0x801bdb,%rax
  80246a:	00 00 00 
  80246d:	ff d0                	callq  *%rax
  80246f:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802472:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802476:	79 30                	jns    8024a8 <fork+0x242>
  802478:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80247b:	89 c1                	mov    %eax,%ecx
  80247d:	48 ba 67 50 80 00 00 	movabs $0x805067,%rdx
  802484:	00 00 00 
  802487:	be c5 00 00 00       	mov    $0xc5,%esi
  80248c:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  802493:	00 00 00 
  802496:	b8 00 00 00 00       	mov    $0x0,%eax
  80249b:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8024a2:	00 00 00 
  8024a5:	41 ff d0             	callq  *%r8
  8024a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8024ab:	c9                   	leaveq 
  8024ac:	c3                   	retq   

00000000008024ad <sfork>:
  8024ad:	55                   	push   %rbp
  8024ae:	48 89 e5             	mov    %rsp,%rbp
  8024b1:	48 ba 7e 50 80 00 00 	movabs $0x80507e,%rdx
  8024b8:	00 00 00 
  8024bb:	be d2 00 00 00       	mov    $0xd2,%esi
  8024c0:	48 bf b1 4f 80 00 00 	movabs $0x804fb1,%rdi
  8024c7:	00 00 00 
  8024ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8024cf:	48 b9 c9 03 80 00 00 	movabs $0x8003c9,%rcx
  8024d6:	00 00 00 
  8024d9:	ff d1                	callq  *%rcx

00000000008024db <fd2num>:
  8024db:	55                   	push   %rbp
  8024dc:	48 89 e5             	mov    %rsp,%rbp
  8024df:	48 83 ec 08          	sub    $0x8,%rsp
  8024e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024e7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8024eb:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8024f2:	ff ff ff 
  8024f5:	48 01 d0             	add    %rdx,%rax
  8024f8:	48 c1 e8 0c          	shr    $0xc,%rax
  8024fc:	c9                   	leaveq 
  8024fd:	c3                   	retq   

00000000008024fe <fd2data>:
  8024fe:	55                   	push   %rbp
  8024ff:	48 89 e5             	mov    %rsp,%rbp
  802502:	48 83 ec 08          	sub    $0x8,%rsp
  802506:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80250a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80250e:	48 89 c7             	mov    %rax,%rdi
  802511:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  802518:	00 00 00 
  80251b:	ff d0                	callq  *%rax
  80251d:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802523:	48 c1 e0 0c          	shl    $0xc,%rax
  802527:	c9                   	leaveq 
  802528:	c3                   	retq   

0000000000802529 <fd_alloc>:
  802529:	55                   	push   %rbp
  80252a:	48 89 e5             	mov    %rsp,%rbp
  80252d:	48 83 ec 18          	sub    $0x18,%rsp
  802531:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802535:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80253c:	eb 6b                	jmp    8025a9 <fd_alloc+0x80>
  80253e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802541:	48 98                	cltq   
  802543:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802549:	48 c1 e0 0c          	shl    $0xc,%rax
  80254d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802555:	48 c1 e8 15          	shr    $0x15,%rax
  802559:	48 89 c2             	mov    %rax,%rdx
  80255c:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802563:	01 00 00 
  802566:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80256a:	83 e0 01             	and    $0x1,%eax
  80256d:	48 85 c0             	test   %rax,%rax
  802570:	74 21                	je     802593 <fd_alloc+0x6a>
  802572:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802576:	48 c1 e8 0c          	shr    $0xc,%rax
  80257a:	48 89 c2             	mov    %rax,%rdx
  80257d:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802584:	01 00 00 
  802587:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80258b:	83 e0 01             	and    $0x1,%eax
  80258e:	48 85 c0             	test   %rax,%rax
  802591:	75 12                	jne    8025a5 <fd_alloc+0x7c>
  802593:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802597:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80259b:	48 89 10             	mov    %rdx,(%rax)
  80259e:	b8 00 00 00 00       	mov    $0x0,%eax
  8025a3:	eb 1a                	jmp    8025bf <fd_alloc+0x96>
  8025a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8025a9:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8025ad:	7e 8f                	jle    80253e <fd_alloc+0x15>
  8025af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025b3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8025ba:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8025bf:	c9                   	leaveq 
  8025c0:	c3                   	retq   

00000000008025c1 <fd_lookup>:
  8025c1:	55                   	push   %rbp
  8025c2:	48 89 e5             	mov    %rsp,%rbp
  8025c5:	48 83 ec 20          	sub    $0x20,%rsp
  8025c9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8025cc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8025d4:	78 06                	js     8025dc <fd_lookup+0x1b>
  8025d6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8025da:	7e 07                	jle    8025e3 <fd_lookup+0x22>
  8025dc:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8025e1:	eb 6c                	jmp    80264f <fd_lookup+0x8e>
  8025e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8025e6:	48 98                	cltq   
  8025e8:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8025ee:	48 c1 e0 0c          	shl    $0xc,%rax
  8025f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8025f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025fa:	48 c1 e8 15          	shr    $0x15,%rax
  8025fe:	48 89 c2             	mov    %rax,%rdx
  802601:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802608:	01 00 00 
  80260b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80260f:	83 e0 01             	and    $0x1,%eax
  802612:	48 85 c0             	test   %rax,%rax
  802615:	74 21                	je     802638 <fd_lookup+0x77>
  802617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80261b:	48 c1 e8 0c          	shr    $0xc,%rax
  80261f:	48 89 c2             	mov    %rax,%rdx
  802622:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802629:	01 00 00 
  80262c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802630:	83 e0 01             	and    $0x1,%eax
  802633:	48 85 c0             	test   %rax,%rax
  802636:	75 07                	jne    80263f <fd_lookup+0x7e>
  802638:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80263d:	eb 10                	jmp    80264f <fd_lookup+0x8e>
  80263f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802643:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802647:	48 89 10             	mov    %rdx,(%rax)
  80264a:	b8 00 00 00 00       	mov    $0x0,%eax
  80264f:	c9                   	leaveq 
  802650:	c3                   	retq   

0000000000802651 <fd_close>:
  802651:	55                   	push   %rbp
  802652:	48 89 e5             	mov    %rsp,%rbp
  802655:	48 83 ec 30          	sub    $0x30,%rsp
  802659:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80265d:	89 f0                	mov    %esi,%eax
  80265f:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802662:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802666:	48 89 c7             	mov    %rax,%rdi
  802669:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  802670:	00 00 00 
  802673:	ff d0                	callq  *%rax
  802675:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802679:	48 89 d6             	mov    %rdx,%rsi
  80267c:	89 c7                	mov    %eax,%edi
  80267e:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802685:	00 00 00 
  802688:	ff d0                	callq  *%rax
  80268a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80268d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802691:	78 0a                	js     80269d <fd_close+0x4c>
  802693:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802697:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  80269b:	74 12                	je     8026af <fd_close+0x5e>
  80269d:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  8026a1:	74 05                	je     8026a8 <fd_close+0x57>
  8026a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026a6:	eb 05                	jmp    8026ad <fd_close+0x5c>
  8026a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8026ad:	eb 69                	jmp    802718 <fd_close+0xc7>
  8026af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8026b3:	8b 00                	mov    (%rax),%eax
  8026b5:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8026b9:	48 89 d6             	mov    %rdx,%rsi
  8026bc:	89 c7                	mov    %eax,%edi
  8026be:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  8026c5:	00 00 00 
  8026c8:	ff d0                	callq  *%rax
  8026ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026d1:	78 2a                	js     8026fd <fd_close+0xac>
  8026d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026d7:	48 8b 40 20          	mov    0x20(%rax),%rax
  8026db:	48 85 c0             	test   %rax,%rax
  8026de:	74 16                	je     8026f6 <fd_close+0xa5>
  8026e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026e4:	48 8b 40 20          	mov    0x20(%rax),%rax
  8026e8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8026ec:	48 89 d7             	mov    %rdx,%rdi
  8026ef:	ff d0                	callq  *%rax
  8026f1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026f4:	eb 07                	jmp    8026fd <fd_close+0xac>
  8026f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8026fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802701:	48 89 c6             	mov    %rax,%rsi
  802704:	bf 00 00 00 00       	mov    $0x0,%edi
  802709:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  802710:	00 00 00 
  802713:	ff d0                	callq  *%rax
  802715:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802718:	c9                   	leaveq 
  802719:	c3                   	retq   

000000000080271a <dev_lookup>:
  80271a:	55                   	push   %rbp
  80271b:	48 89 e5             	mov    %rsp,%rbp
  80271e:	48 83 ec 20          	sub    $0x20,%rsp
  802722:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802725:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802729:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802730:	eb 41                	jmp    802773 <dev_lookup+0x59>
  802732:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802739:	00 00 00 
  80273c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80273f:	48 63 d2             	movslq %edx,%rdx
  802742:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802746:	8b 00                	mov    (%rax),%eax
  802748:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80274b:	75 22                	jne    80276f <dev_lookup+0x55>
  80274d:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802754:	00 00 00 
  802757:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80275a:	48 63 d2             	movslq %edx,%rdx
  80275d:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802761:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802765:	48 89 10             	mov    %rdx,(%rax)
  802768:	b8 00 00 00 00       	mov    $0x0,%eax
  80276d:	eb 60                	jmp    8027cf <dev_lookup+0xb5>
  80276f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802773:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80277a:	00 00 00 
  80277d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802780:	48 63 d2             	movslq %edx,%rdx
  802783:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802787:	48 85 c0             	test   %rax,%rax
  80278a:	75 a6                	jne    802732 <dev_lookup+0x18>
  80278c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802793:	00 00 00 
  802796:	48 8b 00             	mov    (%rax),%rax
  802799:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80279f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8027a2:	89 c6                	mov    %eax,%esi
  8027a4:	48 bf 98 50 80 00 00 	movabs $0x805098,%rdi
  8027ab:	00 00 00 
  8027ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8027b3:	48 b9 02 06 80 00 00 	movabs $0x800602,%rcx
  8027ba:	00 00 00 
  8027bd:	ff d1                	callq  *%rcx
  8027bf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8027c3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8027ca:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8027cf:	c9                   	leaveq 
  8027d0:	c3                   	retq   

00000000008027d1 <close>:
  8027d1:	55                   	push   %rbp
  8027d2:	48 89 e5             	mov    %rsp,%rbp
  8027d5:	48 83 ec 20          	sub    $0x20,%rsp
  8027d9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8027dc:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8027e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8027e3:	48 89 d6             	mov    %rdx,%rsi
  8027e6:	89 c7                	mov    %eax,%edi
  8027e8:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  8027ef:	00 00 00 
  8027f2:	ff d0                	callq  *%rax
  8027f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027fb:	79 05                	jns    802802 <close+0x31>
  8027fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802800:	eb 18                	jmp    80281a <close+0x49>
  802802:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802806:	be 01 00 00 00       	mov    $0x1,%esi
  80280b:	48 89 c7             	mov    %rax,%rdi
  80280e:	48 b8 51 26 80 00 00 	movabs $0x802651,%rax
  802815:	00 00 00 
  802818:	ff d0                	callq  *%rax
  80281a:	c9                   	leaveq 
  80281b:	c3                   	retq   

000000000080281c <close_all>:
  80281c:	55                   	push   %rbp
  80281d:	48 89 e5             	mov    %rsp,%rbp
  802820:	48 83 ec 10          	sub    $0x10,%rsp
  802824:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80282b:	eb 15                	jmp    802842 <close_all+0x26>
  80282d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802830:	89 c7                	mov    %eax,%edi
  802832:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  802839:	00 00 00 
  80283c:	ff d0                	callq  *%rax
  80283e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802842:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802846:	7e e5                	jle    80282d <close_all+0x11>
  802848:	c9                   	leaveq 
  802849:	c3                   	retq   

000000000080284a <dup>:
  80284a:	55                   	push   %rbp
  80284b:	48 89 e5             	mov    %rsp,%rbp
  80284e:	48 83 ec 40          	sub    $0x40,%rsp
  802852:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802855:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802858:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80285c:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80285f:	48 89 d6             	mov    %rdx,%rsi
  802862:	89 c7                	mov    %eax,%edi
  802864:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  80286b:	00 00 00 
  80286e:	ff d0                	callq  *%rax
  802870:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802873:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802877:	79 08                	jns    802881 <dup+0x37>
  802879:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80287c:	e9 70 01 00 00       	jmpq   8029f1 <dup+0x1a7>
  802881:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802884:	89 c7                	mov    %eax,%edi
  802886:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  80288d:	00 00 00 
  802890:	ff d0                	callq  *%rax
  802892:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802895:	48 98                	cltq   
  802897:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80289d:	48 c1 e0 0c          	shl    $0xc,%rax
  8028a1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8028a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028a9:	48 89 c7             	mov    %rax,%rdi
  8028ac:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  8028b3:	00 00 00 
  8028b6:	ff d0                	callq  *%rax
  8028b8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8028bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028c0:	48 89 c7             	mov    %rax,%rdi
  8028c3:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  8028ca:	00 00 00 
  8028cd:	ff d0                	callq  *%rax
  8028cf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8028d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028d7:	48 c1 e8 15          	shr    $0x15,%rax
  8028db:	48 89 c2             	mov    %rax,%rdx
  8028de:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8028e5:	01 00 00 
  8028e8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8028ec:	83 e0 01             	and    $0x1,%eax
  8028ef:	48 85 c0             	test   %rax,%rax
  8028f2:	74 73                	je     802967 <dup+0x11d>
  8028f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8028f8:	48 c1 e8 0c          	shr    $0xc,%rax
  8028fc:	48 89 c2             	mov    %rax,%rdx
  8028ff:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802906:	01 00 00 
  802909:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80290d:	83 e0 01             	and    $0x1,%eax
  802910:	48 85 c0             	test   %rax,%rax
  802913:	74 52                	je     802967 <dup+0x11d>
  802915:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802919:	48 c1 e8 0c          	shr    $0xc,%rax
  80291d:	48 89 c2             	mov    %rax,%rdx
  802920:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802927:	01 00 00 
  80292a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80292e:	25 07 0e 00 00       	and    $0xe07,%eax
  802933:	89 c1                	mov    %eax,%ecx
  802935:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802939:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80293d:	41 89 c8             	mov    %ecx,%r8d
  802940:	48 89 d1             	mov    %rdx,%rcx
  802943:	ba 00 00 00 00       	mov    $0x0,%edx
  802948:	48 89 c6             	mov    %rax,%rsi
  80294b:	bf 00 00 00 00       	mov    $0x0,%edi
  802950:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  802957:	00 00 00 
  80295a:	ff d0                	callq  *%rax
  80295c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80295f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802963:	79 02                	jns    802967 <dup+0x11d>
  802965:	eb 57                	jmp    8029be <dup+0x174>
  802967:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80296b:	48 c1 e8 0c          	shr    $0xc,%rax
  80296f:	48 89 c2             	mov    %rax,%rdx
  802972:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802979:	01 00 00 
  80297c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802980:	25 07 0e 00 00       	and    $0xe07,%eax
  802985:	89 c1                	mov    %eax,%ecx
  802987:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80298b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80298f:	41 89 c8             	mov    %ecx,%r8d
  802992:	48 89 d1             	mov    %rdx,%rcx
  802995:	ba 00 00 00 00       	mov    $0x0,%edx
  80299a:	48 89 c6             	mov    %rax,%rsi
  80299d:	bf 00 00 00 00       	mov    $0x0,%edi
  8029a2:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  8029a9:	00 00 00 
  8029ac:	ff d0                	callq  *%rax
  8029ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029b5:	79 02                	jns    8029b9 <dup+0x16f>
  8029b7:	eb 05                	jmp    8029be <dup+0x174>
  8029b9:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8029bc:	eb 33                	jmp    8029f1 <dup+0x1a7>
  8029be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029c2:	48 89 c6             	mov    %rax,%rsi
  8029c5:	bf 00 00 00 00       	mov    $0x0,%edi
  8029ca:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  8029d1:	00 00 00 
  8029d4:	ff d0                	callq  *%rax
  8029d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029da:	48 89 c6             	mov    %rax,%rsi
  8029dd:	bf 00 00 00 00       	mov    $0x0,%edi
  8029e2:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  8029e9:	00 00 00 
  8029ec:	ff d0                	callq  *%rax
  8029ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029f1:	c9                   	leaveq 
  8029f2:	c3                   	retq   

00000000008029f3 <read>:
  8029f3:	55                   	push   %rbp
  8029f4:	48 89 e5             	mov    %rsp,%rbp
  8029f7:	48 83 ec 40          	sub    $0x40,%rsp
  8029fb:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8029fe:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802a02:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802a06:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802a0a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a0d:	48 89 d6             	mov    %rdx,%rsi
  802a10:	89 c7                	mov    %eax,%edi
  802a12:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802a19:	00 00 00 
  802a1c:	ff d0                	callq  *%rax
  802a1e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a21:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a25:	78 24                	js     802a4b <read+0x58>
  802a27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a2b:	8b 00                	mov    (%rax),%eax
  802a2d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802a31:	48 89 d6             	mov    %rdx,%rsi
  802a34:	89 c7                	mov    %eax,%edi
  802a36:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802a3d:	00 00 00 
  802a40:	ff d0                	callq  *%rax
  802a42:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a45:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a49:	79 05                	jns    802a50 <read+0x5d>
  802a4b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a4e:	eb 76                	jmp    802ac6 <read+0xd3>
  802a50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a54:	8b 40 08             	mov    0x8(%rax),%eax
  802a57:	83 e0 03             	and    $0x3,%eax
  802a5a:	83 f8 01             	cmp    $0x1,%eax
  802a5d:	75 3a                	jne    802a99 <read+0xa6>
  802a5f:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802a66:	00 00 00 
  802a69:	48 8b 00             	mov    (%rax),%rax
  802a6c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a72:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802a75:	89 c6                	mov    %eax,%esi
  802a77:	48 bf b7 50 80 00 00 	movabs $0x8050b7,%rdi
  802a7e:	00 00 00 
  802a81:	b8 00 00 00 00       	mov    $0x0,%eax
  802a86:	48 b9 02 06 80 00 00 	movabs $0x800602,%rcx
  802a8d:	00 00 00 
  802a90:	ff d1                	callq  *%rcx
  802a92:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802a97:	eb 2d                	jmp    802ac6 <read+0xd3>
  802a99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a9d:	48 8b 40 10          	mov    0x10(%rax),%rax
  802aa1:	48 85 c0             	test   %rax,%rax
  802aa4:	75 07                	jne    802aad <read+0xba>
  802aa6:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802aab:	eb 19                	jmp    802ac6 <read+0xd3>
  802aad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ab1:	48 8b 40 10          	mov    0x10(%rax),%rax
  802ab5:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ab9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802abd:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802ac1:	48 89 cf             	mov    %rcx,%rdi
  802ac4:	ff d0                	callq  *%rax
  802ac6:	c9                   	leaveq 
  802ac7:	c3                   	retq   

0000000000802ac8 <readn>:
  802ac8:	55                   	push   %rbp
  802ac9:	48 89 e5             	mov    %rsp,%rbp
  802acc:	48 83 ec 30          	sub    $0x30,%rsp
  802ad0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ad3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802ad7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802adb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802ae2:	eb 49                	jmp    802b2d <readn+0x65>
  802ae4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ae7:	48 98                	cltq   
  802ae9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802aed:	48 29 c2             	sub    %rax,%rdx
  802af0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802af3:	48 63 c8             	movslq %eax,%rcx
  802af6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802afa:	48 01 c1             	add    %rax,%rcx
  802afd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802b00:	48 89 ce             	mov    %rcx,%rsi
  802b03:	89 c7                	mov    %eax,%edi
  802b05:	48 b8 f3 29 80 00 00 	movabs $0x8029f3,%rax
  802b0c:	00 00 00 
  802b0f:	ff d0                	callq  *%rax
  802b11:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b14:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b18:	79 05                	jns    802b1f <readn+0x57>
  802b1a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b1d:	eb 1c                	jmp    802b3b <readn+0x73>
  802b1f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b23:	75 02                	jne    802b27 <readn+0x5f>
  802b25:	eb 11                	jmp    802b38 <readn+0x70>
  802b27:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b2a:	01 45 fc             	add    %eax,-0x4(%rbp)
  802b2d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b30:	48 98                	cltq   
  802b32:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802b36:	72 ac                	jb     802ae4 <readn+0x1c>
  802b38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b3b:	c9                   	leaveq 
  802b3c:	c3                   	retq   

0000000000802b3d <write>:
  802b3d:	55                   	push   %rbp
  802b3e:	48 89 e5             	mov    %rsp,%rbp
  802b41:	48 83 ec 40          	sub    $0x40,%rsp
  802b45:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802b48:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802b4c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802b50:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802b54:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802b57:	48 89 d6             	mov    %rdx,%rsi
  802b5a:	89 c7                	mov    %eax,%edi
  802b5c:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802b63:	00 00 00 
  802b66:	ff d0                	callq  *%rax
  802b68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b6f:	78 24                	js     802b95 <write+0x58>
  802b71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b75:	8b 00                	mov    (%rax),%eax
  802b77:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b7b:	48 89 d6             	mov    %rdx,%rsi
  802b7e:	89 c7                	mov    %eax,%edi
  802b80:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802b87:	00 00 00 
  802b8a:	ff d0                	callq  *%rax
  802b8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b93:	79 05                	jns    802b9a <write+0x5d>
  802b95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b98:	eb 75                	jmp    802c0f <write+0xd2>
  802b9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b9e:	8b 40 08             	mov    0x8(%rax),%eax
  802ba1:	83 e0 03             	and    $0x3,%eax
  802ba4:	85 c0                	test   %eax,%eax
  802ba6:	75 3a                	jne    802be2 <write+0xa5>
  802ba8:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802baf:	00 00 00 
  802bb2:	48 8b 00             	mov    (%rax),%rax
  802bb5:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802bbb:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802bbe:	89 c6                	mov    %eax,%esi
  802bc0:	48 bf d3 50 80 00 00 	movabs $0x8050d3,%rdi
  802bc7:	00 00 00 
  802bca:	b8 00 00 00 00       	mov    $0x0,%eax
  802bcf:	48 b9 02 06 80 00 00 	movabs $0x800602,%rcx
  802bd6:	00 00 00 
  802bd9:	ff d1                	callq  *%rcx
  802bdb:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802be0:	eb 2d                	jmp    802c0f <write+0xd2>
  802be2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802be6:	48 8b 40 18          	mov    0x18(%rax),%rax
  802bea:	48 85 c0             	test   %rax,%rax
  802bed:	75 07                	jne    802bf6 <write+0xb9>
  802bef:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802bf4:	eb 19                	jmp    802c0f <write+0xd2>
  802bf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802bfa:	48 8b 40 18          	mov    0x18(%rax),%rax
  802bfe:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802c02:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802c06:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802c0a:	48 89 cf             	mov    %rcx,%rdi
  802c0d:	ff d0                	callq  *%rax
  802c0f:	c9                   	leaveq 
  802c10:	c3                   	retq   

0000000000802c11 <seek>:
  802c11:	55                   	push   %rbp
  802c12:	48 89 e5             	mov    %rsp,%rbp
  802c15:	48 83 ec 18          	sub    $0x18,%rsp
  802c19:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802c1c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802c1f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c23:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c26:	48 89 d6             	mov    %rdx,%rsi
  802c29:	89 c7                	mov    %eax,%edi
  802c2b:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802c32:	00 00 00 
  802c35:	ff d0                	callq  *%rax
  802c37:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c3a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c3e:	79 05                	jns    802c45 <seek+0x34>
  802c40:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c43:	eb 0f                	jmp    802c54 <seek+0x43>
  802c45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c49:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802c4c:	89 50 04             	mov    %edx,0x4(%rax)
  802c4f:	b8 00 00 00 00       	mov    $0x0,%eax
  802c54:	c9                   	leaveq 
  802c55:	c3                   	retq   

0000000000802c56 <ftruncate>:
  802c56:	55                   	push   %rbp
  802c57:	48 89 e5             	mov    %rsp,%rbp
  802c5a:	48 83 ec 30          	sub    $0x30,%rsp
  802c5e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c61:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802c64:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c68:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c6b:	48 89 d6             	mov    %rdx,%rsi
  802c6e:	89 c7                	mov    %eax,%edi
  802c70:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802c77:	00 00 00 
  802c7a:	ff d0                	callq  *%rax
  802c7c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c83:	78 24                	js     802ca9 <ftruncate+0x53>
  802c85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c89:	8b 00                	mov    (%rax),%eax
  802c8b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c8f:	48 89 d6             	mov    %rdx,%rsi
  802c92:	89 c7                	mov    %eax,%edi
  802c94:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802c9b:	00 00 00 
  802c9e:	ff d0                	callq  *%rax
  802ca0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ca3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ca7:	79 05                	jns    802cae <ftruncate+0x58>
  802ca9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cac:	eb 72                	jmp    802d20 <ftruncate+0xca>
  802cae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cb2:	8b 40 08             	mov    0x8(%rax),%eax
  802cb5:	83 e0 03             	and    $0x3,%eax
  802cb8:	85 c0                	test   %eax,%eax
  802cba:	75 3a                	jne    802cf6 <ftruncate+0xa0>
  802cbc:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802cc3:	00 00 00 
  802cc6:	48 8b 00             	mov    (%rax),%rax
  802cc9:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802ccf:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802cd2:	89 c6                	mov    %eax,%esi
  802cd4:	48 bf f0 50 80 00 00 	movabs $0x8050f0,%rdi
  802cdb:	00 00 00 
  802cde:	b8 00 00 00 00       	mov    $0x0,%eax
  802ce3:	48 b9 02 06 80 00 00 	movabs $0x800602,%rcx
  802cea:	00 00 00 
  802ced:	ff d1                	callq  *%rcx
  802cef:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802cf4:	eb 2a                	jmp    802d20 <ftruncate+0xca>
  802cf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cfa:	48 8b 40 30          	mov    0x30(%rax),%rax
  802cfe:	48 85 c0             	test   %rax,%rax
  802d01:	75 07                	jne    802d0a <ftruncate+0xb4>
  802d03:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802d08:	eb 16                	jmp    802d20 <ftruncate+0xca>
  802d0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d0e:	48 8b 40 30          	mov    0x30(%rax),%rax
  802d12:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d16:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802d19:	89 ce                	mov    %ecx,%esi
  802d1b:	48 89 d7             	mov    %rdx,%rdi
  802d1e:	ff d0                	callq  *%rax
  802d20:	c9                   	leaveq 
  802d21:	c3                   	retq   

0000000000802d22 <fstat>:
  802d22:	55                   	push   %rbp
  802d23:	48 89 e5             	mov    %rsp,%rbp
  802d26:	48 83 ec 30          	sub    $0x30,%rsp
  802d2a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802d2d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802d31:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802d35:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802d38:	48 89 d6             	mov    %rdx,%rsi
  802d3b:	89 c7                	mov    %eax,%edi
  802d3d:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  802d44:	00 00 00 
  802d47:	ff d0                	callq  *%rax
  802d49:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d50:	78 24                	js     802d76 <fstat+0x54>
  802d52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d56:	8b 00                	mov    (%rax),%eax
  802d58:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d5c:	48 89 d6             	mov    %rdx,%rsi
  802d5f:	89 c7                	mov    %eax,%edi
  802d61:	48 b8 1a 27 80 00 00 	movabs $0x80271a,%rax
  802d68:	00 00 00 
  802d6b:	ff d0                	callq  *%rax
  802d6d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d70:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d74:	79 05                	jns    802d7b <fstat+0x59>
  802d76:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d79:	eb 5e                	jmp    802dd9 <fstat+0xb7>
  802d7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d7f:	48 8b 40 28          	mov    0x28(%rax),%rax
  802d83:	48 85 c0             	test   %rax,%rax
  802d86:	75 07                	jne    802d8f <fstat+0x6d>
  802d88:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802d8d:	eb 4a                	jmp    802dd9 <fstat+0xb7>
  802d8f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802d93:	c6 00 00             	movb   $0x0,(%rax)
  802d96:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802d9a:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802da1:	00 00 00 
  802da4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802da8:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802daf:	00 00 00 
  802db2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802db6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802dba:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802dc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802dc5:	48 8b 40 28          	mov    0x28(%rax),%rax
  802dc9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802dcd:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802dd1:	48 89 ce             	mov    %rcx,%rsi
  802dd4:	48 89 d7             	mov    %rdx,%rdi
  802dd7:	ff d0                	callq  *%rax
  802dd9:	c9                   	leaveq 
  802dda:	c3                   	retq   

0000000000802ddb <stat>:
  802ddb:	55                   	push   %rbp
  802ddc:	48 89 e5             	mov    %rsp,%rbp
  802ddf:	48 83 ec 20          	sub    $0x20,%rsp
  802de3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802de7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802deb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802def:	be 00 00 00 00       	mov    $0x0,%esi
  802df4:	48 89 c7             	mov    %rax,%rdi
  802df7:	48 b8 c9 2e 80 00 00 	movabs $0x802ec9,%rax
  802dfe:	00 00 00 
  802e01:	ff d0                	callq  *%rax
  802e03:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e06:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e0a:	79 05                	jns    802e11 <stat+0x36>
  802e0c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e0f:	eb 2f                	jmp    802e40 <stat+0x65>
  802e11:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802e15:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e18:	48 89 d6             	mov    %rdx,%rsi
  802e1b:	89 c7                	mov    %eax,%edi
  802e1d:	48 b8 22 2d 80 00 00 	movabs $0x802d22,%rax
  802e24:	00 00 00 
  802e27:	ff d0                	callq  *%rax
  802e29:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802e2c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e2f:	89 c7                	mov    %eax,%edi
  802e31:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  802e38:	00 00 00 
  802e3b:	ff d0                	callq  *%rax
  802e3d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802e40:	c9                   	leaveq 
  802e41:	c3                   	retq   

0000000000802e42 <fsipc>:
  802e42:	55                   	push   %rbp
  802e43:	48 89 e5             	mov    %rsp,%rbp
  802e46:	48 83 ec 10          	sub    $0x10,%rsp
  802e4a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802e4d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802e51:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802e58:	00 00 00 
  802e5b:	8b 00                	mov    (%rax),%eax
  802e5d:	85 c0                	test   %eax,%eax
  802e5f:	75 1d                	jne    802e7e <fsipc+0x3c>
  802e61:	bf 01 00 00 00       	mov    $0x1,%edi
  802e66:	48 b8 82 48 80 00 00 	movabs $0x804882,%rax
  802e6d:	00 00 00 
  802e70:	ff d0                	callq  *%rax
  802e72:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802e79:	00 00 00 
  802e7c:	89 02                	mov    %eax,(%rdx)
  802e7e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802e85:	00 00 00 
  802e88:	8b 00                	mov    (%rax),%eax
  802e8a:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802e8d:	b9 07 00 00 00       	mov    $0x7,%ecx
  802e92:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802e99:	00 00 00 
  802e9c:	89 c7                	mov    %eax,%edi
  802e9e:	48 b8 77 47 80 00 00 	movabs $0x804777,%rax
  802ea5:	00 00 00 
  802ea8:	ff d0                	callq  *%rax
  802eaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eae:	ba 00 00 00 00       	mov    $0x0,%edx
  802eb3:	48 89 c6             	mov    %rax,%rsi
  802eb6:	bf 00 00 00 00       	mov    $0x0,%edi
  802ebb:	48 b8 b6 46 80 00 00 	movabs $0x8046b6,%rax
  802ec2:	00 00 00 
  802ec5:	ff d0                	callq  *%rax
  802ec7:	c9                   	leaveq 
  802ec8:	c3                   	retq   

0000000000802ec9 <open>:
  802ec9:	55                   	push   %rbp
  802eca:	48 89 e5             	mov    %rsp,%rbp
  802ecd:	48 83 ec 20          	sub    $0x20,%rsp
  802ed1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ed5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802ed8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802edc:	48 89 c7             	mov    %rax,%rdi
  802edf:	48 b8 4b 11 80 00 00 	movabs $0x80114b,%rax
  802ee6:	00 00 00 
  802ee9:	ff d0                	callq  *%rax
  802eeb:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802ef0:	7e 0a                	jle    802efc <open+0x33>
  802ef2:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802ef7:	e9 a5 00 00 00       	jmpq   802fa1 <open+0xd8>
  802efc:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802f00:	48 89 c7             	mov    %rax,%rdi
  802f03:	48 b8 29 25 80 00 00 	movabs $0x802529,%rax
  802f0a:	00 00 00 
  802f0d:	ff d0                	callq  *%rax
  802f0f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f12:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f16:	79 08                	jns    802f20 <open+0x57>
  802f18:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f1b:	e9 81 00 00 00       	jmpq   802fa1 <open+0xd8>
  802f20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f24:	48 89 c6             	mov    %rax,%rsi
  802f27:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  802f2e:	00 00 00 
  802f31:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  802f38:	00 00 00 
  802f3b:	ff d0                	callq  *%rax
  802f3d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802f44:	00 00 00 
  802f47:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802f4a:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802f50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f54:	48 89 c6             	mov    %rax,%rsi
  802f57:	bf 01 00 00 00       	mov    $0x1,%edi
  802f5c:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  802f63:	00 00 00 
  802f66:	ff d0                	callq  *%rax
  802f68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f6f:	79 1d                	jns    802f8e <open+0xc5>
  802f71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f75:	be 00 00 00 00       	mov    $0x0,%esi
  802f7a:	48 89 c7             	mov    %rax,%rdi
  802f7d:	48 b8 51 26 80 00 00 	movabs $0x802651,%rax
  802f84:	00 00 00 
  802f87:	ff d0                	callq  *%rax
  802f89:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f8c:	eb 13                	jmp    802fa1 <open+0xd8>
  802f8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f92:	48 89 c7             	mov    %rax,%rdi
  802f95:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  802f9c:	00 00 00 
  802f9f:	ff d0                	callq  *%rax
  802fa1:	c9                   	leaveq 
  802fa2:	c3                   	retq   

0000000000802fa3 <devfile_flush>:
  802fa3:	55                   	push   %rbp
  802fa4:	48 89 e5             	mov    %rsp,%rbp
  802fa7:	48 83 ec 10          	sub    $0x10,%rsp
  802fab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802faf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fb3:	8b 50 0c             	mov    0xc(%rax),%edx
  802fb6:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802fbd:	00 00 00 
  802fc0:	89 10                	mov    %edx,(%rax)
  802fc2:	be 00 00 00 00       	mov    $0x0,%esi
  802fc7:	bf 06 00 00 00       	mov    $0x6,%edi
  802fcc:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  802fd3:	00 00 00 
  802fd6:	ff d0                	callq  *%rax
  802fd8:	c9                   	leaveq 
  802fd9:	c3                   	retq   

0000000000802fda <devfile_read>:
  802fda:	55                   	push   %rbp
  802fdb:	48 89 e5             	mov    %rsp,%rbp
  802fde:	48 83 ec 30          	sub    $0x30,%rsp
  802fe2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802fe6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802fea:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802fee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ff2:	8b 50 0c             	mov    0xc(%rax),%edx
  802ff5:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  802ffc:	00 00 00 
  802fff:	89 10                	mov    %edx,(%rax)
  803001:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803008:	00 00 00 
  80300b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80300f:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803013:	be 00 00 00 00       	mov    $0x0,%esi
  803018:	bf 03 00 00 00       	mov    $0x3,%edi
  80301d:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  803024:	00 00 00 
  803027:	ff d0                	callq  *%rax
  803029:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80302c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803030:	79 08                	jns    80303a <devfile_read+0x60>
  803032:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803035:	e9 a4 00 00 00       	jmpq   8030de <devfile_read+0x104>
  80303a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80303d:	48 98                	cltq   
  80303f:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  803043:	76 35                	jbe    80307a <devfile_read+0xa0>
  803045:	48 b9 16 51 80 00 00 	movabs $0x805116,%rcx
  80304c:	00 00 00 
  80304f:	48 ba 1d 51 80 00 00 	movabs $0x80511d,%rdx
  803056:	00 00 00 
  803059:	be 89 00 00 00       	mov    $0x89,%esi
  80305e:	48 bf 32 51 80 00 00 	movabs $0x805132,%rdi
  803065:	00 00 00 
  803068:	b8 00 00 00 00       	mov    $0x0,%eax
  80306d:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  803074:	00 00 00 
  803077:	41 ff d0             	callq  *%r8
  80307a:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803081:	7e 35                	jle    8030b8 <devfile_read+0xde>
  803083:	48 b9 40 51 80 00 00 	movabs $0x805140,%rcx
  80308a:	00 00 00 
  80308d:	48 ba 1d 51 80 00 00 	movabs $0x80511d,%rdx
  803094:	00 00 00 
  803097:	be 8a 00 00 00       	mov    $0x8a,%esi
  80309c:	48 bf 32 51 80 00 00 	movabs $0x805132,%rdi
  8030a3:	00 00 00 
  8030a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8030ab:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8030b2:	00 00 00 
  8030b5:	41 ff d0             	callq  *%r8
  8030b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030bb:	48 63 d0             	movslq %eax,%rdx
  8030be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8030c2:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8030c9:	00 00 00 
  8030cc:	48 89 c7             	mov    %rax,%rdi
  8030cf:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  8030d6:	00 00 00 
  8030d9:	ff d0                	callq  *%rax
  8030db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030de:	c9                   	leaveq 
  8030df:	c3                   	retq   

00000000008030e0 <devfile_write>:
  8030e0:	55                   	push   %rbp
  8030e1:	48 89 e5             	mov    %rsp,%rbp
  8030e4:	48 83 ec 40          	sub    $0x40,%rsp
  8030e8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8030ec:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8030f0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8030f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8030f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8030fc:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  803103:	00 
  803104:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803108:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  80310c:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  803111:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  803115:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803119:	8b 50 0c             	mov    0xc(%rax),%edx
  80311c:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803123:	00 00 00 
  803126:	89 10                	mov    %edx,(%rax)
  803128:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80312f:	00 00 00 
  803132:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803136:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80313a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80313e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803142:	48 89 c6             	mov    %rax,%rsi
  803145:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  80314c:	00 00 00 
  80314f:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  803156:	00 00 00 
  803159:	ff d0                	callq  *%rax
  80315b:	be 00 00 00 00       	mov    $0x0,%esi
  803160:	bf 04 00 00 00       	mov    $0x4,%edi
  803165:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  80316c:	00 00 00 
  80316f:	ff d0                	callq  *%rax
  803171:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803174:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803178:	79 05                	jns    80317f <devfile_write+0x9f>
  80317a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80317d:	eb 43                	jmp    8031c2 <devfile_write+0xe2>
  80317f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803182:	48 98                	cltq   
  803184:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803188:	76 35                	jbe    8031bf <devfile_write+0xdf>
  80318a:	48 b9 16 51 80 00 00 	movabs $0x805116,%rcx
  803191:	00 00 00 
  803194:	48 ba 1d 51 80 00 00 	movabs $0x80511d,%rdx
  80319b:	00 00 00 
  80319e:	be a8 00 00 00       	mov    $0xa8,%esi
  8031a3:	48 bf 32 51 80 00 00 	movabs $0x805132,%rdi
  8031aa:	00 00 00 
  8031ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8031b2:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8031b9:	00 00 00 
  8031bc:	41 ff d0             	callq  *%r8
  8031bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8031c2:	c9                   	leaveq 
  8031c3:	c3                   	retq   

00000000008031c4 <devfile_stat>:
  8031c4:	55                   	push   %rbp
  8031c5:	48 89 e5             	mov    %rsp,%rbp
  8031c8:	48 83 ec 20          	sub    $0x20,%rsp
  8031cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8031d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8031d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8031d8:	8b 50 0c             	mov    0xc(%rax),%edx
  8031db:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8031e2:	00 00 00 
  8031e5:	89 10                	mov    %edx,(%rax)
  8031e7:	be 00 00 00 00       	mov    $0x0,%esi
  8031ec:	bf 05 00 00 00       	mov    $0x5,%edi
  8031f1:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  8031f8:	00 00 00 
  8031fb:	ff d0                	callq  *%rax
  8031fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803200:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803204:	79 05                	jns    80320b <devfile_stat+0x47>
  803206:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803209:	eb 56                	jmp    803261 <devfile_stat+0x9d>
  80320b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80320f:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803216:	00 00 00 
  803219:	48 89 c7             	mov    %rax,%rdi
  80321c:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  803223:	00 00 00 
  803226:	ff d0                	callq  *%rax
  803228:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80322f:	00 00 00 
  803232:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803238:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80323c:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803242:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803249:	00 00 00 
  80324c:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  803252:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803256:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  80325c:	b8 00 00 00 00       	mov    $0x0,%eax
  803261:	c9                   	leaveq 
  803262:	c3                   	retq   

0000000000803263 <devfile_trunc>:
  803263:	55                   	push   %rbp
  803264:	48 89 e5             	mov    %rsp,%rbp
  803267:	48 83 ec 10          	sub    $0x10,%rsp
  80326b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80326f:	89 75 f4             	mov    %esi,-0xc(%rbp)
  803272:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803276:	8b 50 0c             	mov    0xc(%rax),%edx
  803279:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803280:	00 00 00 
  803283:	89 10                	mov    %edx,(%rax)
  803285:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80328c:	00 00 00 
  80328f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803292:	89 50 04             	mov    %edx,0x4(%rax)
  803295:	be 00 00 00 00       	mov    $0x0,%esi
  80329a:	bf 02 00 00 00       	mov    $0x2,%edi
  80329f:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  8032a6:	00 00 00 
  8032a9:	ff d0                	callq  *%rax
  8032ab:	c9                   	leaveq 
  8032ac:	c3                   	retq   

00000000008032ad <remove>:
  8032ad:	55                   	push   %rbp
  8032ae:	48 89 e5             	mov    %rsp,%rbp
  8032b1:	48 83 ec 10          	sub    $0x10,%rsp
  8032b5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8032b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032bd:	48 89 c7             	mov    %rax,%rdi
  8032c0:	48 b8 4b 11 80 00 00 	movabs $0x80114b,%rax
  8032c7:	00 00 00 
  8032ca:	ff d0                	callq  *%rax
  8032cc:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8032d1:	7e 07                	jle    8032da <remove+0x2d>
  8032d3:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8032d8:	eb 33                	jmp    80330d <remove+0x60>
  8032da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8032de:	48 89 c6             	mov    %rax,%rsi
  8032e1:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8032e8:	00 00 00 
  8032eb:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  8032f2:	00 00 00 
  8032f5:	ff d0                	callq  *%rax
  8032f7:	be 00 00 00 00       	mov    $0x0,%esi
  8032fc:	bf 07 00 00 00       	mov    $0x7,%edi
  803301:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  803308:	00 00 00 
  80330b:	ff d0                	callq  *%rax
  80330d:	c9                   	leaveq 
  80330e:	c3                   	retq   

000000000080330f <sync>:
  80330f:	55                   	push   %rbp
  803310:	48 89 e5             	mov    %rsp,%rbp
  803313:	be 00 00 00 00       	mov    $0x0,%esi
  803318:	bf 08 00 00 00       	mov    $0x8,%edi
  80331d:	48 b8 42 2e 80 00 00 	movabs $0x802e42,%rax
  803324:	00 00 00 
  803327:	ff d0                	callq  *%rax
  803329:	5d                   	pop    %rbp
  80332a:	c3                   	retq   

000000000080332b <copy>:
  80332b:	55                   	push   %rbp
  80332c:	48 89 e5             	mov    %rsp,%rbp
  80332f:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  803336:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  80333d:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  803344:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  80334b:	be 00 00 00 00       	mov    $0x0,%esi
  803350:	48 89 c7             	mov    %rax,%rdi
  803353:	48 b8 c9 2e 80 00 00 	movabs $0x802ec9,%rax
  80335a:	00 00 00 
  80335d:	ff d0                	callq  *%rax
  80335f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803362:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803366:	79 28                	jns    803390 <copy+0x65>
  803368:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80336b:	89 c6                	mov    %eax,%esi
  80336d:	48 bf 4c 51 80 00 00 	movabs $0x80514c,%rdi
  803374:	00 00 00 
  803377:	b8 00 00 00 00       	mov    $0x0,%eax
  80337c:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  803383:	00 00 00 
  803386:	ff d2                	callq  *%rdx
  803388:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80338b:	e9 74 01 00 00       	jmpq   803504 <copy+0x1d9>
  803390:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803397:	be 01 01 00 00       	mov    $0x101,%esi
  80339c:	48 89 c7             	mov    %rax,%rdi
  80339f:	48 b8 c9 2e 80 00 00 	movabs $0x802ec9,%rax
  8033a6:	00 00 00 
  8033a9:	ff d0                	callq  *%rax
  8033ab:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8033ae:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8033b2:	79 39                	jns    8033ed <copy+0xc2>
  8033b4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033b7:	89 c6                	mov    %eax,%esi
  8033b9:	48 bf 62 51 80 00 00 	movabs $0x805162,%rdi
  8033c0:	00 00 00 
  8033c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8033c8:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  8033cf:	00 00 00 
  8033d2:	ff d2                	callq  *%rdx
  8033d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033d7:	89 c7                	mov    %eax,%edi
  8033d9:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  8033e0:	00 00 00 
  8033e3:	ff d0                	callq  *%rax
  8033e5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033e8:	e9 17 01 00 00       	jmpq   803504 <copy+0x1d9>
  8033ed:	eb 74                	jmp    803463 <copy+0x138>
  8033ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8033f2:	48 63 d0             	movslq %eax,%rdx
  8033f5:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8033fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8033ff:	48 89 ce             	mov    %rcx,%rsi
  803402:	89 c7                	mov    %eax,%edi
  803404:	48 b8 3d 2b 80 00 00 	movabs $0x802b3d,%rax
  80340b:	00 00 00 
  80340e:	ff d0                	callq  *%rax
  803410:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803413:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803417:	79 4a                	jns    803463 <copy+0x138>
  803419:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80341c:	89 c6                	mov    %eax,%esi
  80341e:	48 bf 7c 51 80 00 00 	movabs $0x80517c,%rdi
  803425:	00 00 00 
  803428:	b8 00 00 00 00       	mov    $0x0,%eax
  80342d:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  803434:	00 00 00 
  803437:	ff d2                	callq  *%rdx
  803439:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80343c:	89 c7                	mov    %eax,%edi
  80343e:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  803445:	00 00 00 
  803448:	ff d0                	callq  *%rax
  80344a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80344d:	89 c7                	mov    %eax,%edi
  80344f:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  803456:	00 00 00 
  803459:	ff d0                	callq  *%rax
  80345b:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80345e:	e9 a1 00 00 00       	jmpq   803504 <copy+0x1d9>
  803463:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80346a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80346d:	ba 00 02 00 00       	mov    $0x200,%edx
  803472:	48 89 ce             	mov    %rcx,%rsi
  803475:	89 c7                	mov    %eax,%edi
  803477:	48 b8 f3 29 80 00 00 	movabs $0x8029f3,%rax
  80347e:	00 00 00 
  803481:	ff d0                	callq  *%rax
  803483:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803486:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80348a:	0f 8f 5f ff ff ff    	jg     8033ef <copy+0xc4>
  803490:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803494:	79 47                	jns    8034dd <copy+0x1b2>
  803496:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803499:	89 c6                	mov    %eax,%esi
  80349b:	48 bf 8f 51 80 00 00 	movabs $0x80518f,%rdi
  8034a2:	00 00 00 
  8034a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8034aa:	48 ba 02 06 80 00 00 	movabs $0x800602,%rdx
  8034b1:	00 00 00 
  8034b4:	ff d2                	callq  *%rdx
  8034b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034b9:	89 c7                	mov    %eax,%edi
  8034bb:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  8034c2:	00 00 00 
  8034c5:	ff d0                	callq  *%rax
  8034c7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034ca:	89 c7                	mov    %eax,%edi
  8034cc:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  8034d3:	00 00 00 
  8034d6:	ff d0                	callq  *%rax
  8034d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8034db:	eb 27                	jmp    803504 <copy+0x1d9>
  8034dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034e0:	89 c7                	mov    %eax,%edi
  8034e2:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  8034e9:	00 00 00 
  8034ec:	ff d0                	callq  *%rax
  8034ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034f1:	89 c7                	mov    %eax,%edi
  8034f3:	48 b8 d1 27 80 00 00 	movabs $0x8027d1,%rax
  8034fa:	00 00 00 
  8034fd:	ff d0                	callq  *%rax
  8034ff:	b8 00 00 00 00       	mov    $0x0,%eax
  803504:	c9                   	leaveq 
  803505:	c3                   	retq   

0000000000803506 <fd2sockid>:
  803506:	55                   	push   %rbp
  803507:	48 89 e5             	mov    %rsp,%rbp
  80350a:	48 83 ec 20          	sub    $0x20,%rsp
  80350e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803511:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803515:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803518:	48 89 d6             	mov    %rdx,%rsi
  80351b:	89 c7                	mov    %eax,%edi
  80351d:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  803524:	00 00 00 
  803527:	ff d0                	callq  *%rax
  803529:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80352c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803530:	79 05                	jns    803537 <fd2sockid+0x31>
  803532:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803535:	eb 24                	jmp    80355b <fd2sockid+0x55>
  803537:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80353b:	8b 10                	mov    (%rax),%edx
  80353d:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803544:	00 00 00 
  803547:	8b 00                	mov    (%rax),%eax
  803549:	39 c2                	cmp    %eax,%edx
  80354b:	74 07                	je     803554 <fd2sockid+0x4e>
  80354d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803552:	eb 07                	jmp    80355b <fd2sockid+0x55>
  803554:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803558:	8b 40 0c             	mov    0xc(%rax),%eax
  80355b:	c9                   	leaveq 
  80355c:	c3                   	retq   

000000000080355d <alloc_sockfd>:
  80355d:	55                   	push   %rbp
  80355e:	48 89 e5             	mov    %rsp,%rbp
  803561:	48 83 ec 20          	sub    $0x20,%rsp
  803565:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803568:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80356c:	48 89 c7             	mov    %rax,%rdi
  80356f:	48 b8 29 25 80 00 00 	movabs $0x802529,%rax
  803576:	00 00 00 
  803579:	ff d0                	callq  *%rax
  80357b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80357e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803582:	78 26                	js     8035aa <alloc_sockfd+0x4d>
  803584:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803588:	ba 07 04 00 00       	mov    $0x407,%edx
  80358d:	48 89 c6             	mov    %rax,%rsi
  803590:	bf 00 00 00 00       	mov    $0x0,%edi
  803595:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  80359c:	00 00 00 
  80359f:	ff d0                	callq  *%rax
  8035a1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035a8:	79 16                	jns    8035c0 <alloc_sockfd+0x63>
  8035aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8035ad:	89 c7                	mov    %eax,%edi
  8035af:	48 b8 6a 3a 80 00 00 	movabs $0x803a6a,%rax
  8035b6:	00 00 00 
  8035b9:	ff d0                	callq  *%rax
  8035bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035be:	eb 3a                	jmp    8035fa <alloc_sockfd+0x9d>
  8035c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035c4:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8035cb:	00 00 00 
  8035ce:	8b 12                	mov    (%rdx),%edx
  8035d0:	89 10                	mov    %edx,(%rax)
  8035d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035d6:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8035dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035e1:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8035e4:	89 50 0c             	mov    %edx,0xc(%rax)
  8035e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035eb:	48 89 c7             	mov    %rax,%rdi
  8035ee:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  8035f5:	00 00 00 
  8035f8:	ff d0                	callq  *%rax
  8035fa:	c9                   	leaveq 
  8035fb:	c3                   	retq   

00000000008035fc <accept>:
  8035fc:	55                   	push   %rbp
  8035fd:	48 89 e5             	mov    %rsp,%rbp
  803600:	48 83 ec 30          	sub    $0x30,%rsp
  803604:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803607:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80360b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80360f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803612:	89 c7                	mov    %eax,%edi
  803614:	48 b8 06 35 80 00 00 	movabs $0x803506,%rax
  80361b:	00 00 00 
  80361e:	ff d0                	callq  *%rax
  803620:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803623:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803627:	79 05                	jns    80362e <accept+0x32>
  803629:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80362c:	eb 3b                	jmp    803669 <accept+0x6d>
  80362e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803632:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803636:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803639:	48 89 ce             	mov    %rcx,%rsi
  80363c:	89 c7                	mov    %eax,%edi
  80363e:	48 b8 47 39 80 00 00 	movabs $0x803947,%rax
  803645:	00 00 00 
  803648:	ff d0                	callq  *%rax
  80364a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80364d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803651:	79 05                	jns    803658 <accept+0x5c>
  803653:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803656:	eb 11                	jmp    803669 <accept+0x6d>
  803658:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80365b:	89 c7                	mov    %eax,%edi
  80365d:	48 b8 5d 35 80 00 00 	movabs $0x80355d,%rax
  803664:	00 00 00 
  803667:	ff d0                	callq  *%rax
  803669:	c9                   	leaveq 
  80366a:	c3                   	retq   

000000000080366b <bind>:
  80366b:	55                   	push   %rbp
  80366c:	48 89 e5             	mov    %rsp,%rbp
  80366f:	48 83 ec 20          	sub    $0x20,%rsp
  803673:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803676:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80367a:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80367d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803680:	89 c7                	mov    %eax,%edi
  803682:	48 b8 06 35 80 00 00 	movabs $0x803506,%rax
  803689:	00 00 00 
  80368c:	ff d0                	callq  *%rax
  80368e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803691:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803695:	79 05                	jns    80369c <bind+0x31>
  803697:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80369a:	eb 1b                	jmp    8036b7 <bind+0x4c>
  80369c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80369f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8036a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036a6:	48 89 ce             	mov    %rcx,%rsi
  8036a9:	89 c7                	mov    %eax,%edi
  8036ab:	48 b8 c6 39 80 00 00 	movabs $0x8039c6,%rax
  8036b2:	00 00 00 
  8036b5:	ff d0                	callq  *%rax
  8036b7:	c9                   	leaveq 
  8036b8:	c3                   	retq   

00000000008036b9 <shutdown>:
  8036b9:	55                   	push   %rbp
  8036ba:	48 89 e5             	mov    %rsp,%rbp
  8036bd:	48 83 ec 20          	sub    $0x20,%rsp
  8036c1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036c4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8036c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036ca:	89 c7                	mov    %eax,%edi
  8036cc:	48 b8 06 35 80 00 00 	movabs $0x803506,%rax
  8036d3:	00 00 00 
  8036d6:	ff d0                	callq  *%rax
  8036d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036df:	79 05                	jns    8036e6 <shutdown+0x2d>
  8036e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036e4:	eb 16                	jmp    8036fc <shutdown+0x43>
  8036e6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8036e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036ec:	89 d6                	mov    %edx,%esi
  8036ee:	89 c7                	mov    %eax,%edi
  8036f0:	48 b8 2a 3a 80 00 00 	movabs $0x803a2a,%rax
  8036f7:	00 00 00 
  8036fa:	ff d0                	callq  *%rax
  8036fc:	c9                   	leaveq 
  8036fd:	c3                   	retq   

00000000008036fe <devsock_close>:
  8036fe:	55                   	push   %rbp
  8036ff:	48 89 e5             	mov    %rsp,%rbp
  803702:	48 83 ec 10          	sub    $0x10,%rsp
  803706:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80370a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80370e:	48 89 c7             	mov    %rax,%rdi
  803711:	48 b8 f4 48 80 00 00 	movabs $0x8048f4,%rax
  803718:	00 00 00 
  80371b:	ff d0                	callq  *%rax
  80371d:	83 f8 01             	cmp    $0x1,%eax
  803720:	75 17                	jne    803739 <devsock_close+0x3b>
  803722:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803726:	8b 40 0c             	mov    0xc(%rax),%eax
  803729:	89 c7                	mov    %eax,%edi
  80372b:	48 b8 6a 3a 80 00 00 	movabs $0x803a6a,%rax
  803732:	00 00 00 
  803735:	ff d0                	callq  *%rax
  803737:	eb 05                	jmp    80373e <devsock_close+0x40>
  803739:	b8 00 00 00 00       	mov    $0x0,%eax
  80373e:	c9                   	leaveq 
  80373f:	c3                   	retq   

0000000000803740 <connect>:
  803740:	55                   	push   %rbp
  803741:	48 89 e5             	mov    %rsp,%rbp
  803744:	48 83 ec 20          	sub    $0x20,%rsp
  803748:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80374b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80374f:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803752:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803755:	89 c7                	mov    %eax,%edi
  803757:	48 b8 06 35 80 00 00 	movabs $0x803506,%rax
  80375e:	00 00 00 
  803761:	ff d0                	callq  *%rax
  803763:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803766:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80376a:	79 05                	jns    803771 <connect+0x31>
  80376c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80376f:	eb 1b                	jmp    80378c <connect+0x4c>
  803771:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803774:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803778:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80377b:	48 89 ce             	mov    %rcx,%rsi
  80377e:	89 c7                	mov    %eax,%edi
  803780:	48 b8 97 3a 80 00 00 	movabs $0x803a97,%rax
  803787:	00 00 00 
  80378a:	ff d0                	callq  *%rax
  80378c:	c9                   	leaveq 
  80378d:	c3                   	retq   

000000000080378e <listen>:
  80378e:	55                   	push   %rbp
  80378f:	48 89 e5             	mov    %rsp,%rbp
  803792:	48 83 ec 20          	sub    $0x20,%rsp
  803796:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803799:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80379c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80379f:	89 c7                	mov    %eax,%edi
  8037a1:	48 b8 06 35 80 00 00 	movabs $0x803506,%rax
  8037a8:	00 00 00 
  8037ab:	ff d0                	callq  *%rax
  8037ad:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037b0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037b4:	79 05                	jns    8037bb <listen+0x2d>
  8037b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037b9:	eb 16                	jmp    8037d1 <listen+0x43>
  8037bb:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8037be:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037c1:	89 d6                	mov    %edx,%esi
  8037c3:	89 c7                	mov    %eax,%edi
  8037c5:	48 b8 fb 3a 80 00 00 	movabs $0x803afb,%rax
  8037cc:	00 00 00 
  8037cf:	ff d0                	callq  *%rax
  8037d1:	c9                   	leaveq 
  8037d2:	c3                   	retq   

00000000008037d3 <devsock_read>:
  8037d3:	55                   	push   %rbp
  8037d4:	48 89 e5             	mov    %rsp,%rbp
  8037d7:	48 83 ec 20          	sub    $0x20,%rsp
  8037db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037df:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037e3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8037e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037eb:	89 c2                	mov    %eax,%edx
  8037ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037f1:	8b 40 0c             	mov    0xc(%rax),%eax
  8037f4:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8037f8:	b9 00 00 00 00       	mov    $0x0,%ecx
  8037fd:	89 c7                	mov    %eax,%edi
  8037ff:	48 b8 3b 3b 80 00 00 	movabs $0x803b3b,%rax
  803806:	00 00 00 
  803809:	ff d0                	callq  *%rax
  80380b:	c9                   	leaveq 
  80380c:	c3                   	retq   

000000000080380d <devsock_write>:
  80380d:	55                   	push   %rbp
  80380e:	48 89 e5             	mov    %rsp,%rbp
  803811:	48 83 ec 20          	sub    $0x20,%rsp
  803815:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803819:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80381d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803821:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803825:	89 c2                	mov    %eax,%edx
  803827:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80382b:	8b 40 0c             	mov    0xc(%rax),%eax
  80382e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803832:	b9 00 00 00 00       	mov    $0x0,%ecx
  803837:	89 c7                	mov    %eax,%edi
  803839:	48 b8 07 3c 80 00 00 	movabs $0x803c07,%rax
  803840:	00 00 00 
  803843:	ff d0                	callq  *%rax
  803845:	c9                   	leaveq 
  803846:	c3                   	retq   

0000000000803847 <devsock_stat>:
  803847:	55                   	push   %rbp
  803848:	48 89 e5             	mov    %rsp,%rbp
  80384b:	48 83 ec 10          	sub    $0x10,%rsp
  80384f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803853:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803857:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80385b:	48 be aa 51 80 00 00 	movabs $0x8051aa,%rsi
  803862:	00 00 00 
  803865:	48 89 c7             	mov    %rax,%rdi
  803868:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  80386f:	00 00 00 
  803872:	ff d0                	callq  *%rax
  803874:	b8 00 00 00 00       	mov    $0x0,%eax
  803879:	c9                   	leaveq 
  80387a:	c3                   	retq   

000000000080387b <socket>:
  80387b:	55                   	push   %rbp
  80387c:	48 89 e5             	mov    %rsp,%rbp
  80387f:	48 83 ec 20          	sub    $0x20,%rsp
  803883:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803886:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803889:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80388c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80388f:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803892:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803895:	89 ce                	mov    %ecx,%esi
  803897:	89 c7                	mov    %eax,%edi
  803899:	48 b8 bf 3c 80 00 00 	movabs $0x803cbf,%rax
  8038a0:	00 00 00 
  8038a3:	ff d0                	callq  *%rax
  8038a5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038ac:	79 05                	jns    8038b3 <socket+0x38>
  8038ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b1:	eb 11                	jmp    8038c4 <socket+0x49>
  8038b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b6:	89 c7                	mov    %eax,%edi
  8038b8:	48 b8 5d 35 80 00 00 	movabs $0x80355d,%rax
  8038bf:	00 00 00 
  8038c2:	ff d0                	callq  *%rax
  8038c4:	c9                   	leaveq 
  8038c5:	c3                   	retq   

00000000008038c6 <nsipc>:
  8038c6:	55                   	push   %rbp
  8038c7:	48 89 e5             	mov    %rsp,%rbp
  8038ca:	48 83 ec 10          	sub    $0x10,%rsp
  8038ce:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8038d1:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8038d8:	00 00 00 
  8038db:	8b 00                	mov    (%rax),%eax
  8038dd:	85 c0                	test   %eax,%eax
  8038df:	75 1d                	jne    8038fe <nsipc+0x38>
  8038e1:	bf 02 00 00 00       	mov    $0x2,%edi
  8038e6:	48 b8 82 48 80 00 00 	movabs $0x804882,%rax
  8038ed:	00 00 00 
  8038f0:	ff d0                	callq  *%rax
  8038f2:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  8038f9:	00 00 00 
  8038fc:	89 02                	mov    %eax,(%rdx)
  8038fe:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  803905:	00 00 00 
  803908:	8b 00                	mov    (%rax),%eax
  80390a:	8b 75 fc             	mov    -0x4(%rbp),%esi
  80390d:	b9 07 00 00 00       	mov    $0x7,%ecx
  803912:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803919:	00 00 00 
  80391c:	89 c7                	mov    %eax,%edi
  80391e:	48 b8 77 47 80 00 00 	movabs $0x804777,%rax
  803925:	00 00 00 
  803928:	ff d0                	callq  *%rax
  80392a:	ba 00 00 00 00       	mov    $0x0,%edx
  80392f:	be 00 00 00 00       	mov    $0x0,%esi
  803934:	bf 00 00 00 00       	mov    $0x0,%edi
  803939:	48 b8 b6 46 80 00 00 	movabs $0x8046b6,%rax
  803940:	00 00 00 
  803943:	ff d0                	callq  *%rax
  803945:	c9                   	leaveq 
  803946:	c3                   	retq   

0000000000803947 <nsipc_accept>:
  803947:	55                   	push   %rbp
  803948:	48 89 e5             	mov    %rsp,%rbp
  80394b:	48 83 ec 30          	sub    $0x30,%rsp
  80394f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803952:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803956:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80395a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803961:	00 00 00 
  803964:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803967:	89 10                	mov    %edx,(%rax)
  803969:	bf 01 00 00 00       	mov    $0x1,%edi
  80396e:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803975:	00 00 00 
  803978:	ff d0                	callq  *%rax
  80397a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80397d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803981:	78 3e                	js     8039c1 <nsipc_accept+0x7a>
  803983:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80398a:	00 00 00 
  80398d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803995:	8b 40 10             	mov    0x10(%rax),%eax
  803998:	89 c2                	mov    %eax,%edx
  80399a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  80399e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8039a2:	48 89 ce             	mov    %rcx,%rsi
  8039a5:	48 89 c7             	mov    %rax,%rdi
  8039a8:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  8039af:	00 00 00 
  8039b2:	ff d0                	callq  *%rax
  8039b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039b8:	8b 50 10             	mov    0x10(%rax),%edx
  8039bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8039bf:	89 10                	mov    %edx,(%rax)
  8039c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039c4:	c9                   	leaveq 
  8039c5:	c3                   	retq   

00000000008039c6 <nsipc_bind>:
  8039c6:	55                   	push   %rbp
  8039c7:	48 89 e5             	mov    %rsp,%rbp
  8039ca:	48 83 ec 10          	sub    $0x10,%rsp
  8039ce:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039d1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039d5:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8039d8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8039df:	00 00 00 
  8039e2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8039e5:	89 10                	mov    %edx,(%rax)
  8039e7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8039ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039ee:	48 89 c6             	mov    %rax,%rsi
  8039f1:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  8039f8:	00 00 00 
  8039fb:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  803a02:	00 00 00 
  803a05:	ff d0                	callq  *%rax
  803a07:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a0e:	00 00 00 
  803a11:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a14:	89 50 14             	mov    %edx,0x14(%rax)
  803a17:	bf 02 00 00 00       	mov    $0x2,%edi
  803a1c:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803a23:	00 00 00 
  803a26:	ff d0                	callq  *%rax
  803a28:	c9                   	leaveq 
  803a29:	c3                   	retq   

0000000000803a2a <nsipc_shutdown>:
  803a2a:	55                   	push   %rbp
  803a2b:	48 89 e5             	mov    %rsp,%rbp
  803a2e:	48 83 ec 10          	sub    $0x10,%rsp
  803a32:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a35:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803a38:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a3f:	00 00 00 
  803a42:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a45:	89 10                	mov    %edx,(%rax)
  803a47:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a4e:	00 00 00 
  803a51:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803a54:	89 50 04             	mov    %edx,0x4(%rax)
  803a57:	bf 03 00 00 00       	mov    $0x3,%edi
  803a5c:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803a63:	00 00 00 
  803a66:	ff d0                	callq  *%rax
  803a68:	c9                   	leaveq 
  803a69:	c3                   	retq   

0000000000803a6a <nsipc_close>:
  803a6a:	55                   	push   %rbp
  803a6b:	48 89 e5             	mov    %rsp,%rbp
  803a6e:	48 83 ec 10          	sub    $0x10,%rsp
  803a72:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803a75:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a7c:	00 00 00 
  803a7f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803a82:	89 10                	mov    %edx,(%rax)
  803a84:	bf 04 00 00 00       	mov    $0x4,%edi
  803a89:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803a90:	00 00 00 
  803a93:	ff d0                	callq  *%rax
  803a95:	c9                   	leaveq 
  803a96:	c3                   	retq   

0000000000803a97 <nsipc_connect>:
  803a97:	55                   	push   %rbp
  803a98:	48 89 e5             	mov    %rsp,%rbp
  803a9b:	48 83 ec 10          	sub    $0x10,%rsp
  803a9f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803aa2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803aa6:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803aa9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ab0:	00 00 00 
  803ab3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ab6:	89 10                	mov    %edx,(%rax)
  803ab8:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803abb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803abf:	48 89 c6             	mov    %rax,%rsi
  803ac2:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803ac9:	00 00 00 
  803acc:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  803ad3:	00 00 00 
  803ad6:	ff d0                	callq  *%rax
  803ad8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803adf:	00 00 00 
  803ae2:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ae5:	89 50 14             	mov    %edx,0x14(%rax)
  803ae8:	bf 05 00 00 00       	mov    $0x5,%edi
  803aed:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803af4:	00 00 00 
  803af7:	ff d0                	callq  *%rax
  803af9:	c9                   	leaveq 
  803afa:	c3                   	retq   

0000000000803afb <nsipc_listen>:
  803afb:	55                   	push   %rbp
  803afc:	48 89 e5             	mov    %rsp,%rbp
  803aff:	48 83 ec 10          	sub    $0x10,%rsp
  803b03:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b06:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803b09:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b10:	00 00 00 
  803b13:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b16:	89 10                	mov    %edx,(%rax)
  803b18:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b1f:	00 00 00 
  803b22:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803b25:	89 50 04             	mov    %edx,0x4(%rax)
  803b28:	bf 06 00 00 00       	mov    $0x6,%edi
  803b2d:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803b34:	00 00 00 
  803b37:	ff d0                	callq  *%rax
  803b39:	c9                   	leaveq 
  803b3a:	c3                   	retq   

0000000000803b3b <nsipc_recv>:
  803b3b:	55                   	push   %rbp
  803b3c:	48 89 e5             	mov    %rsp,%rbp
  803b3f:	48 83 ec 30          	sub    $0x30,%rsp
  803b43:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b46:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b4a:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803b4d:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803b50:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b57:	00 00 00 
  803b5a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803b5d:	89 10                	mov    %edx,(%rax)
  803b5f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b66:	00 00 00 
  803b69:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b6c:	89 50 04             	mov    %edx,0x4(%rax)
  803b6f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b76:	00 00 00 
  803b79:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803b7c:	89 50 08             	mov    %edx,0x8(%rax)
  803b7f:	bf 07 00 00 00       	mov    $0x7,%edi
  803b84:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803b8b:	00 00 00 
  803b8e:	ff d0                	callq  *%rax
  803b90:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b93:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b97:	78 69                	js     803c02 <nsipc_recv+0xc7>
  803b99:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803ba0:	7f 08                	jg     803baa <nsipc_recv+0x6f>
  803ba2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ba5:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803ba8:	7e 35                	jle    803bdf <nsipc_recv+0xa4>
  803baa:	48 b9 b1 51 80 00 00 	movabs $0x8051b1,%rcx
  803bb1:	00 00 00 
  803bb4:	48 ba c6 51 80 00 00 	movabs $0x8051c6,%rdx
  803bbb:	00 00 00 
  803bbe:	be 62 00 00 00       	mov    $0x62,%esi
  803bc3:	48 bf db 51 80 00 00 	movabs $0x8051db,%rdi
  803bca:	00 00 00 
  803bcd:	b8 00 00 00 00       	mov    $0x0,%eax
  803bd2:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  803bd9:	00 00 00 
  803bdc:	41 ff d0             	callq  *%r8
  803bdf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803be2:	48 63 d0             	movslq %eax,%rdx
  803be5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803be9:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803bf0:	00 00 00 
  803bf3:	48 89 c7             	mov    %rax,%rdi
  803bf6:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  803bfd:	00 00 00 
  803c00:	ff d0                	callq  *%rax
  803c02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c05:	c9                   	leaveq 
  803c06:	c3                   	retq   

0000000000803c07 <nsipc_send>:
  803c07:	55                   	push   %rbp
  803c08:	48 89 e5             	mov    %rsp,%rbp
  803c0b:	48 83 ec 20          	sub    $0x20,%rsp
  803c0f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803c12:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803c16:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803c19:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803c1c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c23:	00 00 00 
  803c26:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c29:	89 10                	mov    %edx,(%rax)
  803c2b:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803c32:	7e 35                	jle    803c69 <nsipc_send+0x62>
  803c34:	48 b9 ea 51 80 00 00 	movabs $0x8051ea,%rcx
  803c3b:	00 00 00 
  803c3e:	48 ba c6 51 80 00 00 	movabs $0x8051c6,%rdx
  803c45:	00 00 00 
  803c48:	be 6d 00 00 00       	mov    $0x6d,%esi
  803c4d:	48 bf db 51 80 00 00 	movabs $0x8051db,%rdi
  803c54:	00 00 00 
  803c57:	b8 00 00 00 00       	mov    $0x0,%eax
  803c5c:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  803c63:	00 00 00 
  803c66:	41 ff d0             	callq  *%r8
  803c69:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803c6c:	48 63 d0             	movslq %eax,%rdx
  803c6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c73:	48 89 c6             	mov    %rax,%rsi
  803c76:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803c7d:	00 00 00 
  803c80:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  803c87:	00 00 00 
  803c8a:	ff d0                	callq  *%rax
  803c8c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c93:	00 00 00 
  803c96:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c99:	89 50 04             	mov    %edx,0x4(%rax)
  803c9c:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ca3:	00 00 00 
  803ca6:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803ca9:	89 50 08             	mov    %edx,0x8(%rax)
  803cac:	bf 08 00 00 00       	mov    $0x8,%edi
  803cb1:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803cb8:	00 00 00 
  803cbb:	ff d0                	callq  *%rax
  803cbd:	c9                   	leaveq 
  803cbe:	c3                   	retq   

0000000000803cbf <nsipc_socket>:
  803cbf:	55                   	push   %rbp
  803cc0:	48 89 e5             	mov    %rsp,%rbp
  803cc3:	48 83 ec 10          	sub    $0x10,%rsp
  803cc7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803cca:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803ccd:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803cd0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cd7:	00 00 00 
  803cda:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803cdd:	89 10                	mov    %edx,(%rax)
  803cdf:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ce6:	00 00 00 
  803ce9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803cec:	89 50 04             	mov    %edx,0x4(%rax)
  803cef:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803cf6:	00 00 00 
  803cf9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803cfc:	89 50 08             	mov    %edx,0x8(%rax)
  803cff:	bf 09 00 00 00       	mov    $0x9,%edi
  803d04:	48 b8 c6 38 80 00 00 	movabs $0x8038c6,%rax
  803d0b:	00 00 00 
  803d0e:	ff d0                	callq  *%rax
  803d10:	c9                   	leaveq 
  803d11:	c3                   	retq   

0000000000803d12 <pipe>:
  803d12:	55                   	push   %rbp
  803d13:	48 89 e5             	mov    %rsp,%rbp
  803d16:	53                   	push   %rbx
  803d17:	48 83 ec 38          	sub    $0x38,%rsp
  803d1b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803d1f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803d23:	48 89 c7             	mov    %rax,%rdi
  803d26:	48 b8 29 25 80 00 00 	movabs $0x802529,%rax
  803d2d:	00 00 00 
  803d30:	ff d0                	callq  *%rax
  803d32:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d35:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d39:	0f 88 bf 01 00 00    	js     803efe <pipe+0x1ec>
  803d3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d43:	ba 07 04 00 00       	mov    $0x407,%edx
  803d48:	48 89 c6             	mov    %rax,%rsi
  803d4b:	bf 00 00 00 00       	mov    $0x0,%edi
  803d50:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  803d57:	00 00 00 
  803d5a:	ff d0                	callq  *%rax
  803d5c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d5f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d63:	0f 88 95 01 00 00    	js     803efe <pipe+0x1ec>
  803d69:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803d6d:	48 89 c7             	mov    %rax,%rdi
  803d70:	48 b8 29 25 80 00 00 	movabs $0x802529,%rax
  803d77:	00 00 00 
  803d7a:	ff d0                	callq  *%rax
  803d7c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803d7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803d83:	0f 88 5d 01 00 00    	js     803ee6 <pipe+0x1d4>
  803d89:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803d8d:	ba 07 04 00 00       	mov    $0x407,%edx
  803d92:	48 89 c6             	mov    %rax,%rsi
  803d95:	bf 00 00 00 00       	mov    $0x0,%edi
  803d9a:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  803da1:	00 00 00 
  803da4:	ff d0                	callq  *%rax
  803da6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803da9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803dad:	0f 88 33 01 00 00    	js     803ee6 <pipe+0x1d4>
  803db3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803db7:	48 89 c7             	mov    %rax,%rdi
  803dba:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  803dc1:	00 00 00 
  803dc4:	ff d0                	callq  *%rax
  803dc6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803dca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803dce:	ba 07 04 00 00       	mov    $0x407,%edx
  803dd3:	48 89 c6             	mov    %rax,%rsi
  803dd6:	bf 00 00 00 00       	mov    $0x0,%edi
  803ddb:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  803de2:	00 00 00 
  803de5:	ff d0                	callq  *%rax
  803de7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803dea:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803dee:	79 05                	jns    803df5 <pipe+0xe3>
  803df0:	e9 d9 00 00 00       	jmpq   803ece <pipe+0x1bc>
  803df5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803df9:	48 89 c7             	mov    %rax,%rdi
  803dfc:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  803e03:	00 00 00 
  803e06:	ff d0                	callq  *%rax
  803e08:	48 89 c2             	mov    %rax,%rdx
  803e0b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e0f:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803e15:	48 89 d1             	mov    %rdx,%rcx
  803e18:	ba 00 00 00 00       	mov    $0x0,%edx
  803e1d:	48 89 c6             	mov    %rax,%rsi
  803e20:	bf 00 00 00 00       	mov    $0x0,%edi
  803e25:	48 b8 36 1b 80 00 00 	movabs $0x801b36,%rax
  803e2c:	00 00 00 
  803e2f:	ff d0                	callq  *%rax
  803e31:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e34:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e38:	79 1b                	jns    803e55 <pipe+0x143>
  803e3a:	90                   	nop
  803e3b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e3f:	48 89 c6             	mov    %rax,%rsi
  803e42:	bf 00 00 00 00       	mov    $0x0,%edi
  803e47:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  803e4e:	00 00 00 
  803e51:	ff d0                	callq  *%rax
  803e53:	eb 79                	jmp    803ece <pipe+0x1bc>
  803e55:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e59:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803e60:	00 00 00 
  803e63:	8b 12                	mov    (%rdx),%edx
  803e65:	89 10                	mov    %edx,(%rax)
  803e67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e6b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803e72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e76:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803e7d:	00 00 00 
  803e80:	8b 12                	mov    (%rdx),%edx
  803e82:	89 10                	mov    %edx,(%rax)
  803e84:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e88:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803e8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e93:	48 89 c7             	mov    %rax,%rdi
  803e96:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  803e9d:	00 00 00 
  803ea0:	ff d0                	callq  *%rax
  803ea2:	89 c2                	mov    %eax,%edx
  803ea4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803ea8:	89 10                	mov    %edx,(%rax)
  803eaa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803eae:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803eb2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803eb6:	48 89 c7             	mov    %rax,%rdi
  803eb9:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  803ec0:	00 00 00 
  803ec3:	ff d0                	callq  *%rax
  803ec5:	89 03                	mov    %eax,(%rbx)
  803ec7:	b8 00 00 00 00       	mov    $0x0,%eax
  803ecc:	eb 33                	jmp    803f01 <pipe+0x1ef>
  803ece:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803ed2:	48 89 c6             	mov    %rax,%rsi
  803ed5:	bf 00 00 00 00       	mov    $0x0,%edi
  803eda:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  803ee1:	00 00 00 
  803ee4:	ff d0                	callq  *%rax
  803ee6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803eea:	48 89 c6             	mov    %rax,%rsi
  803eed:	bf 00 00 00 00       	mov    $0x0,%edi
  803ef2:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  803ef9:	00 00 00 
  803efc:	ff d0                	callq  *%rax
  803efe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f01:	48 83 c4 38          	add    $0x38,%rsp
  803f05:	5b                   	pop    %rbx
  803f06:	5d                   	pop    %rbp
  803f07:	c3                   	retq   

0000000000803f08 <_pipeisclosed>:
  803f08:	55                   	push   %rbp
  803f09:	48 89 e5             	mov    %rsp,%rbp
  803f0c:	53                   	push   %rbx
  803f0d:	48 83 ec 28          	sub    $0x28,%rsp
  803f11:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803f15:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803f19:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803f20:	00 00 00 
  803f23:	48 8b 00             	mov    (%rax),%rax
  803f26:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f2c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f2f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f33:	48 89 c7             	mov    %rax,%rdi
  803f36:	48 b8 f4 48 80 00 00 	movabs $0x8048f4,%rax
  803f3d:	00 00 00 
  803f40:	ff d0                	callq  *%rax
  803f42:	89 c3                	mov    %eax,%ebx
  803f44:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f48:	48 89 c7             	mov    %rax,%rdi
  803f4b:	48 b8 f4 48 80 00 00 	movabs $0x8048f4,%rax
  803f52:	00 00 00 
  803f55:	ff d0                	callq  *%rax
  803f57:	39 c3                	cmp    %eax,%ebx
  803f59:	0f 94 c0             	sete   %al
  803f5c:	0f b6 c0             	movzbl %al,%eax
  803f5f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803f62:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803f69:	00 00 00 
  803f6c:	48 8b 00             	mov    (%rax),%rax
  803f6f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803f75:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  803f78:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f7b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803f7e:	75 05                	jne    803f85 <_pipeisclosed+0x7d>
  803f80:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803f83:	eb 4f                	jmp    803fd4 <_pipeisclosed+0xcc>
  803f85:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f88:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803f8b:	74 42                	je     803fcf <_pipeisclosed+0xc7>
  803f8d:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803f91:	75 3c                	jne    803fcf <_pipeisclosed+0xc7>
  803f93:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803f9a:	00 00 00 
  803f9d:	48 8b 00             	mov    (%rax),%rax
  803fa0:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  803fa6:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803fa9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fac:	89 c6                	mov    %eax,%esi
  803fae:	48 bf fb 51 80 00 00 	movabs $0x8051fb,%rdi
  803fb5:	00 00 00 
  803fb8:	b8 00 00 00 00       	mov    $0x0,%eax
  803fbd:	49 b8 02 06 80 00 00 	movabs $0x800602,%r8
  803fc4:	00 00 00 
  803fc7:	41 ff d0             	callq  *%r8
  803fca:	e9 4a ff ff ff       	jmpq   803f19 <_pipeisclosed+0x11>
  803fcf:	e9 45 ff ff ff       	jmpq   803f19 <_pipeisclosed+0x11>
  803fd4:	48 83 c4 28          	add    $0x28,%rsp
  803fd8:	5b                   	pop    %rbx
  803fd9:	5d                   	pop    %rbp
  803fda:	c3                   	retq   

0000000000803fdb <pipeisclosed>:
  803fdb:	55                   	push   %rbp
  803fdc:	48 89 e5             	mov    %rsp,%rbp
  803fdf:	48 83 ec 30          	sub    $0x30,%rsp
  803fe3:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803fe6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803fea:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803fed:	48 89 d6             	mov    %rdx,%rsi
  803ff0:	89 c7                	mov    %eax,%edi
  803ff2:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  803ff9:	00 00 00 
  803ffc:	ff d0                	callq  *%rax
  803ffe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804001:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804005:	79 05                	jns    80400c <pipeisclosed+0x31>
  804007:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80400a:	eb 31                	jmp    80403d <pipeisclosed+0x62>
  80400c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804010:	48 89 c7             	mov    %rax,%rdi
  804013:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  80401a:	00 00 00 
  80401d:	ff d0                	callq  *%rax
  80401f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804023:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804027:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80402b:	48 89 d6             	mov    %rdx,%rsi
  80402e:	48 89 c7             	mov    %rax,%rdi
  804031:	48 b8 08 3f 80 00 00 	movabs $0x803f08,%rax
  804038:	00 00 00 
  80403b:	ff d0                	callq  *%rax
  80403d:	c9                   	leaveq 
  80403e:	c3                   	retq   

000000000080403f <devpipe_read>:
  80403f:	55                   	push   %rbp
  804040:	48 89 e5             	mov    %rsp,%rbp
  804043:	48 83 ec 40          	sub    $0x40,%rsp
  804047:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80404b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80404f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804053:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804057:	48 89 c7             	mov    %rax,%rdi
  80405a:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  804061:	00 00 00 
  804064:	ff d0                	callq  *%rax
  804066:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80406a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80406e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804072:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804079:	00 
  80407a:	e9 92 00 00 00       	jmpq   804111 <devpipe_read+0xd2>
  80407f:	eb 41                	jmp    8040c2 <devpipe_read+0x83>
  804081:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804086:	74 09                	je     804091 <devpipe_read+0x52>
  804088:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80408c:	e9 92 00 00 00       	jmpq   804123 <devpipe_read+0xe4>
  804091:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804095:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804099:	48 89 d6             	mov    %rdx,%rsi
  80409c:	48 89 c7             	mov    %rax,%rdi
  80409f:	48 b8 08 3f 80 00 00 	movabs $0x803f08,%rax
  8040a6:	00 00 00 
  8040a9:	ff d0                	callq  *%rax
  8040ab:	85 c0                	test   %eax,%eax
  8040ad:	74 07                	je     8040b6 <devpipe_read+0x77>
  8040af:	b8 00 00 00 00       	mov    $0x0,%eax
  8040b4:	eb 6d                	jmp    804123 <devpipe_read+0xe4>
  8040b6:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  8040bd:	00 00 00 
  8040c0:	ff d0                	callq  *%rax
  8040c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040c6:	8b 10                	mov    (%rax),%edx
  8040c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040cc:	8b 40 04             	mov    0x4(%rax),%eax
  8040cf:	39 c2                	cmp    %eax,%edx
  8040d1:	74 ae                	je     804081 <devpipe_read+0x42>
  8040d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8040d7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8040db:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8040df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8040e3:	8b 00                	mov    (%rax),%eax
  8040e5:	99                   	cltd   
  8040e6:	c1 ea 1b             	shr    $0x1b,%edx
  8040e9:	01 d0                	add    %edx,%eax
  8040eb:	83 e0 1f             	and    $0x1f,%eax
  8040ee:	29 d0                	sub    %edx,%eax
  8040f0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8040f4:	48 98                	cltq   
  8040f6:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8040fb:	88 01                	mov    %al,(%rcx)
  8040fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804101:	8b 00                	mov    (%rax),%eax
  804103:	8d 50 01             	lea    0x1(%rax),%edx
  804106:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80410a:	89 10                	mov    %edx,(%rax)
  80410c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804111:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804115:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804119:	0f 82 60 ff ff ff    	jb     80407f <devpipe_read+0x40>
  80411f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804123:	c9                   	leaveq 
  804124:	c3                   	retq   

0000000000804125 <devpipe_write>:
  804125:	55                   	push   %rbp
  804126:	48 89 e5             	mov    %rsp,%rbp
  804129:	48 83 ec 40          	sub    $0x40,%rsp
  80412d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804131:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804135:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804139:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80413d:	48 89 c7             	mov    %rax,%rdi
  804140:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  804147:	00 00 00 
  80414a:	ff d0                	callq  *%rax
  80414c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804150:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804154:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804158:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80415f:	00 
  804160:	e9 8e 00 00 00       	jmpq   8041f3 <devpipe_write+0xce>
  804165:	eb 31                	jmp    804198 <devpipe_write+0x73>
  804167:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80416b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80416f:	48 89 d6             	mov    %rdx,%rsi
  804172:	48 89 c7             	mov    %rax,%rdi
  804175:	48 b8 08 3f 80 00 00 	movabs $0x803f08,%rax
  80417c:	00 00 00 
  80417f:	ff d0                	callq  *%rax
  804181:	85 c0                	test   %eax,%eax
  804183:	74 07                	je     80418c <devpipe_write+0x67>
  804185:	b8 00 00 00 00       	mov    $0x0,%eax
  80418a:	eb 79                	jmp    804205 <devpipe_write+0xe0>
  80418c:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  804193:	00 00 00 
  804196:	ff d0                	callq  *%rax
  804198:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80419c:	8b 40 04             	mov    0x4(%rax),%eax
  80419f:	48 63 d0             	movslq %eax,%rdx
  8041a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041a6:	8b 00                	mov    (%rax),%eax
  8041a8:	48 98                	cltq   
  8041aa:	48 83 c0 20          	add    $0x20,%rax
  8041ae:	48 39 c2             	cmp    %rax,%rdx
  8041b1:	73 b4                	jae    804167 <devpipe_write+0x42>
  8041b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041b7:	8b 40 04             	mov    0x4(%rax),%eax
  8041ba:	99                   	cltd   
  8041bb:	c1 ea 1b             	shr    $0x1b,%edx
  8041be:	01 d0                	add    %edx,%eax
  8041c0:	83 e0 1f             	and    $0x1f,%eax
  8041c3:	29 d0                	sub    %edx,%eax
  8041c5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8041c9:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8041cd:	48 01 ca             	add    %rcx,%rdx
  8041d0:	0f b6 0a             	movzbl (%rdx),%ecx
  8041d3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8041d7:	48 98                	cltq   
  8041d9:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8041dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041e1:	8b 40 04             	mov    0x4(%rax),%eax
  8041e4:	8d 50 01             	lea    0x1(%rax),%edx
  8041e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041eb:	89 50 04             	mov    %edx,0x4(%rax)
  8041ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8041f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041f7:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8041fb:	0f 82 64 ff ff ff    	jb     804165 <devpipe_write+0x40>
  804201:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804205:	c9                   	leaveq 
  804206:	c3                   	retq   

0000000000804207 <devpipe_stat>:
  804207:	55                   	push   %rbp
  804208:	48 89 e5             	mov    %rsp,%rbp
  80420b:	48 83 ec 20          	sub    $0x20,%rsp
  80420f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804213:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804217:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80421b:	48 89 c7             	mov    %rax,%rdi
  80421e:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  804225:	00 00 00 
  804228:	ff d0                	callq  *%rax
  80422a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80422e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804232:	48 be 0e 52 80 00 00 	movabs $0x80520e,%rsi
  804239:	00 00 00 
  80423c:	48 89 c7             	mov    %rax,%rdi
  80423f:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  804246:	00 00 00 
  804249:	ff d0                	callq  *%rax
  80424b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80424f:	8b 50 04             	mov    0x4(%rax),%edx
  804252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804256:	8b 00                	mov    (%rax),%eax
  804258:	29 c2                	sub    %eax,%edx
  80425a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80425e:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804264:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804268:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  80426f:	00 00 00 
  804272:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804276:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  80427d:	00 00 00 
  804280:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804287:	b8 00 00 00 00       	mov    $0x0,%eax
  80428c:	c9                   	leaveq 
  80428d:	c3                   	retq   

000000000080428e <devpipe_close>:
  80428e:	55                   	push   %rbp
  80428f:	48 89 e5             	mov    %rsp,%rbp
  804292:	48 83 ec 10          	sub    $0x10,%rsp
  804296:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80429a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80429e:	48 89 c6             	mov    %rax,%rsi
  8042a1:	bf 00 00 00 00       	mov    $0x0,%edi
  8042a6:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  8042ad:	00 00 00 
  8042b0:	ff d0                	callq  *%rax
  8042b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042b6:	48 89 c7             	mov    %rax,%rdi
  8042b9:	48 b8 fe 24 80 00 00 	movabs $0x8024fe,%rax
  8042c0:	00 00 00 
  8042c3:	ff d0                	callq  *%rax
  8042c5:	48 89 c6             	mov    %rax,%rsi
  8042c8:	bf 00 00 00 00       	mov    $0x0,%edi
  8042cd:	48 b8 91 1b 80 00 00 	movabs $0x801b91,%rax
  8042d4:	00 00 00 
  8042d7:	ff d0                	callq  *%rax
  8042d9:	c9                   	leaveq 
  8042da:	c3                   	retq   

00000000008042db <cputchar>:
  8042db:	55                   	push   %rbp
  8042dc:	48 89 e5             	mov    %rsp,%rbp
  8042df:	48 83 ec 20          	sub    $0x20,%rsp
  8042e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8042e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8042e9:	88 45 ff             	mov    %al,-0x1(%rbp)
  8042ec:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8042f0:	be 01 00 00 00       	mov    $0x1,%esi
  8042f5:	48 89 c7             	mov    %rax,%rdi
  8042f8:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  8042ff:	00 00 00 
  804302:	ff d0                	callq  *%rax
  804304:	c9                   	leaveq 
  804305:	c3                   	retq   

0000000000804306 <getchar>:
  804306:	55                   	push   %rbp
  804307:	48 89 e5             	mov    %rsp,%rbp
  80430a:	48 83 ec 10          	sub    $0x10,%rsp
  80430e:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  804312:	ba 01 00 00 00       	mov    $0x1,%edx
  804317:	48 89 c6             	mov    %rax,%rsi
  80431a:	bf 00 00 00 00       	mov    $0x0,%edi
  80431f:	48 b8 f3 29 80 00 00 	movabs $0x8029f3,%rax
  804326:	00 00 00 
  804329:	ff d0                	callq  *%rax
  80432b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80432e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804332:	79 05                	jns    804339 <getchar+0x33>
  804334:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804337:	eb 14                	jmp    80434d <getchar+0x47>
  804339:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80433d:	7f 07                	jg     804346 <getchar+0x40>
  80433f:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  804344:	eb 07                	jmp    80434d <getchar+0x47>
  804346:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  80434a:	0f b6 c0             	movzbl %al,%eax
  80434d:	c9                   	leaveq 
  80434e:	c3                   	retq   

000000000080434f <iscons>:
  80434f:	55                   	push   %rbp
  804350:	48 89 e5             	mov    %rsp,%rbp
  804353:	48 83 ec 20          	sub    $0x20,%rsp
  804357:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80435a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80435e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804361:	48 89 d6             	mov    %rdx,%rsi
  804364:	89 c7                	mov    %eax,%edi
  804366:	48 b8 c1 25 80 00 00 	movabs $0x8025c1,%rax
  80436d:	00 00 00 
  804370:	ff d0                	callq  *%rax
  804372:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804375:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804379:	79 05                	jns    804380 <iscons+0x31>
  80437b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80437e:	eb 1a                	jmp    80439a <iscons+0x4b>
  804380:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804384:	8b 10                	mov    (%rax),%edx
  804386:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  80438d:	00 00 00 
  804390:	8b 00                	mov    (%rax),%eax
  804392:	39 c2                	cmp    %eax,%edx
  804394:	0f 94 c0             	sete   %al
  804397:	0f b6 c0             	movzbl %al,%eax
  80439a:	c9                   	leaveq 
  80439b:	c3                   	retq   

000000000080439c <opencons>:
  80439c:	55                   	push   %rbp
  80439d:	48 89 e5             	mov    %rsp,%rbp
  8043a0:	48 83 ec 10          	sub    $0x10,%rsp
  8043a4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8043a8:	48 89 c7             	mov    %rax,%rdi
  8043ab:	48 b8 29 25 80 00 00 	movabs $0x802529,%rax
  8043b2:	00 00 00 
  8043b5:	ff d0                	callq  *%rax
  8043b7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8043ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8043be:	79 05                	jns    8043c5 <opencons+0x29>
  8043c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8043c3:	eb 5b                	jmp    804420 <opencons+0x84>
  8043c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043c9:	ba 07 04 00 00       	mov    $0x407,%edx
  8043ce:	48 89 c6             	mov    %rax,%rsi
  8043d1:	bf 00 00 00 00       	mov    $0x0,%edi
  8043d6:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  8043dd:	00 00 00 
  8043e0:	ff d0                	callq  *%rax
  8043e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8043e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8043e9:	79 05                	jns    8043f0 <opencons+0x54>
  8043eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8043ee:	eb 30                	jmp    804420 <opencons+0x84>
  8043f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8043f4:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8043fb:	00 00 00 
  8043fe:	8b 12                	mov    (%rdx),%edx
  804400:	89 10                	mov    %edx,(%rax)
  804402:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804406:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  80440d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804411:	48 89 c7             	mov    %rax,%rdi
  804414:	48 b8 db 24 80 00 00 	movabs $0x8024db,%rax
  80441b:	00 00 00 
  80441e:	ff d0                	callq  *%rax
  804420:	c9                   	leaveq 
  804421:	c3                   	retq   

0000000000804422 <devcons_read>:
  804422:	55                   	push   %rbp
  804423:	48 89 e5             	mov    %rsp,%rbp
  804426:	48 83 ec 30          	sub    $0x30,%rsp
  80442a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80442e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804432:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804436:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80443b:	75 07                	jne    804444 <devcons_read+0x22>
  80443d:	b8 00 00 00 00       	mov    $0x0,%eax
  804442:	eb 4b                	jmp    80448f <devcons_read+0x6d>
  804444:	eb 0c                	jmp    804452 <devcons_read+0x30>
  804446:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  80444d:	00 00 00 
  804450:	ff d0                	callq  *%rax
  804452:	48 b8 e8 19 80 00 00 	movabs $0x8019e8,%rax
  804459:	00 00 00 
  80445c:	ff d0                	callq  *%rax
  80445e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804461:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804465:	74 df                	je     804446 <devcons_read+0x24>
  804467:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80446b:	79 05                	jns    804472 <devcons_read+0x50>
  80446d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804470:	eb 1d                	jmp    80448f <devcons_read+0x6d>
  804472:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804476:	75 07                	jne    80447f <devcons_read+0x5d>
  804478:	b8 00 00 00 00       	mov    $0x0,%eax
  80447d:	eb 10                	jmp    80448f <devcons_read+0x6d>
  80447f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804482:	89 c2                	mov    %eax,%edx
  804484:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804488:	88 10                	mov    %dl,(%rax)
  80448a:	b8 01 00 00 00       	mov    $0x1,%eax
  80448f:	c9                   	leaveq 
  804490:	c3                   	retq   

0000000000804491 <devcons_write>:
  804491:	55                   	push   %rbp
  804492:	48 89 e5             	mov    %rsp,%rbp
  804495:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80449c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  8044a3:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8044aa:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8044b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8044b8:	eb 76                	jmp    804530 <devcons_write+0x9f>
  8044ba:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8044c1:	89 c2                	mov    %eax,%edx
  8044c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044c6:	29 c2                	sub    %eax,%edx
  8044c8:	89 d0                	mov    %edx,%eax
  8044ca:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8044cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8044d0:	83 f8 7f             	cmp    $0x7f,%eax
  8044d3:	76 07                	jbe    8044dc <devcons_write+0x4b>
  8044d5:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8044dc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8044df:	48 63 d0             	movslq %eax,%rdx
  8044e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044e5:	48 63 c8             	movslq %eax,%rcx
  8044e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8044ef:	48 01 c1             	add    %rax,%rcx
  8044f2:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8044f9:	48 89 ce             	mov    %rcx,%rsi
  8044fc:	48 89 c7             	mov    %rax,%rdi
  8044ff:	48 b8 db 14 80 00 00 	movabs $0x8014db,%rax
  804506:	00 00 00 
  804509:	ff d0                	callq  *%rax
  80450b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80450e:	48 63 d0             	movslq %eax,%rdx
  804511:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804518:	48 89 d6             	mov    %rdx,%rsi
  80451b:	48 89 c7             	mov    %rax,%rdi
  80451e:	48 b8 9e 19 80 00 00 	movabs $0x80199e,%rax
  804525:	00 00 00 
  804528:	ff d0                	callq  *%rax
  80452a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80452d:	01 45 fc             	add    %eax,-0x4(%rbp)
  804530:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804533:	48 98                	cltq   
  804535:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  80453c:	0f 82 78 ff ff ff    	jb     8044ba <devcons_write+0x29>
  804542:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804545:	c9                   	leaveq 
  804546:	c3                   	retq   

0000000000804547 <devcons_close>:
  804547:	55                   	push   %rbp
  804548:	48 89 e5             	mov    %rsp,%rbp
  80454b:	48 83 ec 08          	sub    $0x8,%rsp
  80454f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804553:	b8 00 00 00 00       	mov    $0x0,%eax
  804558:	c9                   	leaveq 
  804559:	c3                   	retq   

000000000080455a <devcons_stat>:
  80455a:	55                   	push   %rbp
  80455b:	48 89 e5             	mov    %rsp,%rbp
  80455e:	48 83 ec 10          	sub    $0x10,%rsp
  804562:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804566:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80456a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80456e:	48 be 1a 52 80 00 00 	movabs $0x80521a,%rsi
  804575:	00 00 00 
  804578:	48 89 c7             	mov    %rax,%rdi
  80457b:	48 b8 b7 11 80 00 00 	movabs $0x8011b7,%rax
  804582:	00 00 00 
  804585:	ff d0                	callq  *%rax
  804587:	b8 00 00 00 00       	mov    $0x0,%eax
  80458c:	c9                   	leaveq 
  80458d:	c3                   	retq   

000000000080458e <set_pgfault_handler>:
  80458e:	55                   	push   %rbp
  80458f:	48 89 e5             	mov    %rsp,%rbp
  804592:	48 83 ec 20          	sub    $0x20,%rsp
  804596:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80459a:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8045a1:	00 00 00 
  8045a4:	48 8b 00             	mov    (%rax),%rax
  8045a7:	48 85 c0             	test   %rax,%rax
  8045aa:	75 6f                	jne    80461b <set_pgfault_handler+0x8d>
  8045ac:	ba 07 00 00 00       	mov    $0x7,%edx
  8045b1:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8045b6:	bf 00 00 00 00       	mov    $0x0,%edi
  8045bb:	48 b8 e6 1a 80 00 00 	movabs $0x801ae6,%rax
  8045c2:	00 00 00 
  8045c5:	ff d0                	callq  *%rax
  8045c7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8045ca:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8045ce:	79 30                	jns    804600 <set_pgfault_handler+0x72>
  8045d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045d3:	89 c1                	mov    %eax,%ecx
  8045d5:	48 ba 28 52 80 00 00 	movabs $0x805228,%rdx
  8045dc:	00 00 00 
  8045df:	be 22 00 00 00       	mov    $0x22,%esi
  8045e4:	48 bf 47 52 80 00 00 	movabs $0x805247,%rdi
  8045eb:	00 00 00 
  8045ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8045f3:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  8045fa:	00 00 00 
  8045fd:	41 ff d0             	callq  *%r8
  804600:	48 be 2e 46 80 00 00 	movabs $0x80462e,%rsi
  804607:	00 00 00 
  80460a:	bf 00 00 00 00       	mov    $0x0,%edi
  80460f:	48 b8 70 1c 80 00 00 	movabs $0x801c70,%rax
  804616:	00 00 00 
  804619:	ff d0                	callq  *%rax
  80461b:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804622:	00 00 00 
  804625:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804629:	48 89 10             	mov    %rdx,(%rax)
  80462c:	c9                   	leaveq 
  80462d:	c3                   	retq   

000000000080462e <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  80462e:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  804631:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  804638:	00 00 00 
call *%rax
  80463b:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  80463d:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  804644:	00 08 
    movq 152(%rsp), %rax
  804646:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  80464d:	00 
    movq 136(%rsp), %rbx
  80464e:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804655:	00 
movq %rbx, (%rax)
  804656:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804659:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80465d:	4c 8b 3c 24          	mov    (%rsp),%r15
  804661:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804666:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  80466b:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804670:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804675:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  80467a:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  80467f:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804684:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  804689:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  80468e:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804693:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804698:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  80469d:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  8046a2:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  8046a7:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  8046ab:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  8046af:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  8046b0:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  8046b5:	c3                   	retq   

00000000008046b6 <ipc_recv>:
  8046b6:	55                   	push   %rbp
  8046b7:	48 89 e5             	mov    %rsp,%rbp
  8046ba:	48 83 ec 30          	sub    $0x30,%rsp
  8046be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8046c2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8046c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8046ca:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8046cf:	75 0e                	jne    8046df <ipc_recv+0x29>
  8046d1:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8046d8:	00 00 00 
  8046db:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8046df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046e3:	48 89 c7             	mov    %rax,%rdi
  8046e6:	48 b8 0f 1d 80 00 00 	movabs $0x801d0f,%rax
  8046ed:	00 00 00 
  8046f0:	ff d0                	callq  *%rax
  8046f2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046f9:	79 27                	jns    804722 <ipc_recv+0x6c>
  8046fb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804700:	74 0a                	je     80470c <ipc_recv+0x56>
  804702:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804706:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80470c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804711:	74 0a                	je     80471d <ipc_recv+0x67>
  804713:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804717:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80471d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804720:	eb 53                	jmp    804775 <ipc_recv+0xbf>
  804722:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804727:	74 19                	je     804742 <ipc_recv+0x8c>
  804729:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804730:	00 00 00 
  804733:	48 8b 00             	mov    (%rax),%rax
  804736:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80473c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804740:	89 10                	mov    %edx,(%rax)
  804742:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804747:	74 19                	je     804762 <ipc_recv+0xac>
  804749:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804750:	00 00 00 
  804753:	48 8b 00             	mov    (%rax),%rax
  804756:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80475c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804760:	89 10                	mov    %edx,(%rax)
  804762:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804769:	00 00 00 
  80476c:	48 8b 00             	mov    (%rax),%rax
  80476f:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804775:	c9                   	leaveq 
  804776:	c3                   	retq   

0000000000804777 <ipc_send>:
  804777:	55                   	push   %rbp
  804778:	48 89 e5             	mov    %rsp,%rbp
  80477b:	48 83 ec 30          	sub    $0x30,%rsp
  80477f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804782:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804785:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  804789:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80478c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804791:	75 10                	jne    8047a3 <ipc_send+0x2c>
  804793:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80479a:	00 00 00 
  80479d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8047a1:	eb 0e                	jmp    8047b1 <ipc_send+0x3a>
  8047a3:	eb 0c                	jmp    8047b1 <ipc_send+0x3a>
  8047a5:	48 b8 a8 1a 80 00 00 	movabs $0x801aa8,%rax
  8047ac:	00 00 00 
  8047af:	ff d0                	callq  *%rax
  8047b1:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8047b4:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8047b7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8047bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8047be:	89 c7                	mov    %eax,%edi
  8047c0:	48 b8 ba 1c 80 00 00 	movabs $0x801cba,%rax
  8047c7:	00 00 00 
  8047ca:	ff d0                	callq  *%rax
  8047cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8047cf:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8047d3:	74 d0                	je     8047a5 <ipc_send+0x2e>
  8047d5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047d9:	79 30                	jns    80480b <ipc_send+0x94>
  8047db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047de:	89 c1                	mov    %eax,%ecx
  8047e0:	48 ba 58 52 80 00 00 	movabs $0x805258,%rdx
  8047e7:	00 00 00 
  8047ea:	be 44 00 00 00       	mov    $0x44,%esi
  8047ef:	48 bf 6e 52 80 00 00 	movabs $0x80526e,%rdi
  8047f6:	00 00 00 
  8047f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8047fe:	49 b8 c9 03 80 00 00 	movabs $0x8003c9,%r8
  804805:	00 00 00 
  804808:	41 ff d0             	callq  *%r8
  80480b:	c9                   	leaveq 
  80480c:	c3                   	retq   

000000000080480d <ipc_host_recv>:
  80480d:	55                   	push   %rbp
  80480e:	48 89 e5             	mov    %rsp,%rbp
  804811:	48 83 ec 10          	sub    $0x10,%rsp
  804815:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804819:	48 ba 80 52 80 00 00 	movabs $0x805280,%rdx
  804820:	00 00 00 
  804823:	be 4e 00 00 00       	mov    $0x4e,%esi
  804828:	48 bf 6e 52 80 00 00 	movabs $0x80526e,%rdi
  80482f:	00 00 00 
  804832:	b8 00 00 00 00       	mov    $0x0,%eax
  804837:	48 b9 c9 03 80 00 00 	movabs $0x8003c9,%rcx
  80483e:	00 00 00 
  804841:	ff d1                	callq  *%rcx

0000000000804843 <ipc_host_send>:
  804843:	55                   	push   %rbp
  804844:	48 89 e5             	mov    %rsp,%rbp
  804847:	48 83 ec 20          	sub    $0x20,%rsp
  80484b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80484e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804851:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804855:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804858:	48 ba a0 52 80 00 00 	movabs $0x8052a0,%rdx
  80485f:	00 00 00 
  804862:	be 67 00 00 00       	mov    $0x67,%esi
  804867:	48 bf 6e 52 80 00 00 	movabs $0x80526e,%rdi
  80486e:	00 00 00 
  804871:	b8 00 00 00 00       	mov    $0x0,%eax
  804876:	48 b9 c9 03 80 00 00 	movabs $0x8003c9,%rcx
  80487d:	00 00 00 
  804880:	ff d1                	callq  *%rcx

0000000000804882 <ipc_find_env>:
  804882:	55                   	push   %rbp
  804883:	48 89 e5             	mov    %rsp,%rbp
  804886:	48 83 ec 14          	sub    $0x14,%rsp
  80488a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80488d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804894:	eb 4e                	jmp    8048e4 <ipc_find_env+0x62>
  804896:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80489d:	00 00 00 
  8048a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048a3:	48 98                	cltq   
  8048a5:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8048ac:	48 01 d0             	add    %rdx,%rax
  8048af:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8048b5:	8b 00                	mov    (%rax),%eax
  8048b7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8048ba:	75 24                	jne    8048e0 <ipc_find_env+0x5e>
  8048bc:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8048c3:	00 00 00 
  8048c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048c9:	48 98                	cltq   
  8048cb:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8048d2:	48 01 d0             	add    %rdx,%rax
  8048d5:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8048db:	8b 40 08             	mov    0x8(%rax),%eax
  8048de:	eb 12                	jmp    8048f2 <ipc_find_env+0x70>
  8048e0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8048e4:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8048eb:	7e a9                	jle    804896 <ipc_find_env+0x14>
  8048ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8048f2:	c9                   	leaveq 
  8048f3:	c3                   	retq   

00000000008048f4 <pageref>:
  8048f4:	55                   	push   %rbp
  8048f5:	48 89 e5             	mov    %rsp,%rbp
  8048f8:	48 83 ec 18          	sub    $0x18,%rsp
  8048fc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804900:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804904:	48 c1 e8 15          	shr    $0x15,%rax
  804908:	48 89 c2             	mov    %rax,%rdx
  80490b:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804912:	01 00 00 
  804915:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804919:	83 e0 01             	and    $0x1,%eax
  80491c:	48 85 c0             	test   %rax,%rax
  80491f:	75 07                	jne    804928 <pageref+0x34>
  804921:	b8 00 00 00 00       	mov    $0x0,%eax
  804926:	eb 53                	jmp    80497b <pageref+0x87>
  804928:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80492c:	48 c1 e8 0c          	shr    $0xc,%rax
  804930:	48 89 c2             	mov    %rax,%rdx
  804933:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80493a:	01 00 00 
  80493d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804941:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804945:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804949:	83 e0 01             	and    $0x1,%eax
  80494c:	48 85 c0             	test   %rax,%rax
  80494f:	75 07                	jne    804958 <pageref+0x64>
  804951:	b8 00 00 00 00       	mov    $0x0,%eax
  804956:	eb 23                	jmp    80497b <pageref+0x87>
  804958:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80495c:	48 c1 e8 0c          	shr    $0xc,%rax
  804960:	48 89 c2             	mov    %rax,%rdx
  804963:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  80496a:	00 00 00 
  80496d:	48 c1 e2 04          	shl    $0x4,%rdx
  804971:	48 01 d0             	add    %rdx,%rax
  804974:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804978:	0f b7 c0             	movzwl %ax,%eax
  80497b:	c9                   	leaveq 
  80497c:	c3                   	retq   
