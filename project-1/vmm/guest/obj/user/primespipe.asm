
vmm/guest/obj/user/primespipe:     file format elf64-x86-64


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
  80003c:	e8 d3 03 00 00       	callq  800414 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <primeproc>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 30          	sub    $0x30,%rsp
  80004b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80004e:	48 8d 4d ec          	lea    -0x14(%rbp),%rcx
  800052:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800055:	ba 04 00 00 00       	mov    $0x4,%edx
  80005a:	48 89 ce             	mov    %rcx,%rsi
  80005d:	89 c7                	mov    %eax,%edi
  80005f:	48 b8 b9 2b 80 00 00 	movabs $0x802bb9,%rax
  800066:	00 00 00 
  800069:	ff d0                	callq  *%rax
  80006b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80006e:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  800072:	74 42                	je     8000b6 <primeproc+0x73>
  800074:	b8 00 00 00 00       	mov    $0x0,%eax
  800079:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80007d:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  800081:	89 c2                	mov    %eax,%edx
  800083:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800086:	41 89 d0             	mov    %edx,%r8d
  800089:	89 c1                	mov    %eax,%ecx
  80008b:	48 ba 80 4a 80 00 00 	movabs $0x804a80,%rdx
  800092:	00 00 00 
  800095:	be 16 00 00 00       	mov    $0x16,%esi
  80009a:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  8000a1:	00 00 00 
  8000a4:	b8 00 00 00 00       	mov    $0x0,%eax
  8000a9:	49 b9 ba 04 80 00 00 	movabs $0x8004ba,%r9
  8000b0:	00 00 00 
  8000b3:	41 ff d1             	callq  *%r9
  8000b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8000b9:	89 c6                	mov    %eax,%esi
  8000bb:	48 bf c4 4a 80 00 00 	movabs $0x804ac4,%rdi
  8000c2:	00 00 00 
  8000c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ca:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  8000d1:	00 00 00 
  8000d4:	ff d2                	callq  *%rdx
  8000d6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  8000da:	48 89 c7             	mov    %rax,%rdi
  8000dd:	48 b8 03 3e 80 00 00 	movabs $0x803e03,%rax
  8000e4:	00 00 00 
  8000e7:	ff d0                	callq  *%rax
  8000e9:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8000ec:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8000ef:	85 c0                	test   %eax,%eax
  8000f1:	79 30                	jns    800123 <primeproc+0xe0>
  8000f3:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8000f6:	89 c1                	mov    %eax,%ecx
  8000f8:	48 ba c8 4a 80 00 00 	movabs $0x804ac8,%rdx
  8000ff:	00 00 00 
  800102:	be 1c 00 00 00       	mov    $0x1c,%esi
  800107:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  80010e:	00 00 00 
  800111:	b8 00 00 00 00       	mov    $0x0,%eax
  800116:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  80011d:	00 00 00 
  800120:	41 ff d0             	callq  *%r8
  800123:	48 b8 57 23 80 00 00 	movabs $0x802357,%rax
  80012a:	00 00 00 
  80012d:	ff d0                	callq  *%rax
  80012f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800132:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800136:	79 30                	jns    800168 <primeproc+0x125>
  800138:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80013b:	89 c1                	mov    %eax,%ecx
  80013d:	48 ba d1 4a 80 00 00 	movabs $0x804ad1,%rdx
  800144:	00 00 00 
  800147:	be 1e 00 00 00       	mov    $0x1e,%esi
  80014c:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  800153:	00 00 00 
  800156:	b8 00 00 00 00       	mov    $0x0,%eax
  80015b:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  800162:	00 00 00 
  800165:	41 ff d0             	callq  *%r8
  800168:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80016c:	75 2d                	jne    80019b <primeproc+0x158>
  80016e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800171:	89 c7                	mov    %eax,%edi
  800173:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  80017a:	00 00 00 
  80017d:	ff d0                	callq  *%rax
  80017f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800182:	89 c7                	mov    %eax,%edi
  800184:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  80018b:	00 00 00 
  80018e:	ff d0                	callq  *%rax
  800190:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800193:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800196:	e9 b3 fe ff ff       	jmpq   80004e <primeproc+0xb>
  80019b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  80019e:	89 c7                	mov    %eax,%edi
  8001a0:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8001a7:	00 00 00 
  8001aa:	ff d0                	callq  *%rax
  8001ac:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8001af:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8001b2:	48 8d 4d f0          	lea    -0x10(%rbp),%rcx
  8001b6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8001b9:	ba 04 00 00 00       	mov    $0x4,%edx
  8001be:	48 89 ce             	mov    %rcx,%rsi
  8001c1:	89 c7                	mov    %eax,%edi
  8001c3:	48 b8 b9 2b 80 00 00 	movabs $0x802bb9,%rax
  8001ca:	00 00 00 
  8001cd:	ff d0                	callq  *%rax
  8001cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8001d2:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  8001d6:	74 4e                	je     800226 <primeproc+0x1e3>
  8001d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8001dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8001e1:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  8001e5:	89 c2                	mov    %eax,%edx
  8001e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001ea:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8001ed:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8001f0:	89 14 24             	mov    %edx,(%rsp)
  8001f3:	41 89 f1             	mov    %esi,%r9d
  8001f6:	41 89 c8             	mov    %ecx,%r8d
  8001f9:	89 c1                	mov    %eax,%ecx
  8001fb:	48 ba da 4a 80 00 00 	movabs $0x804ada,%rdx
  800202:	00 00 00 
  800205:	be 2c 00 00 00       	mov    $0x2c,%esi
  80020a:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  800211:	00 00 00 
  800214:	b8 00 00 00 00       	mov    $0x0,%eax
  800219:	49 ba ba 04 80 00 00 	movabs $0x8004ba,%r10
  800220:	00 00 00 
  800223:	41 ff d2             	callq  *%r10
  800226:	8b 45 f0             	mov    -0x10(%rbp),%eax
  800229:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  80022c:	99                   	cltd   
  80022d:	f7 f9                	idiv   %ecx
  80022f:	89 d0                	mov    %edx,%eax
  800231:	85 c0                	test   %eax,%eax
  800233:	74 6e                	je     8002a3 <primeproc+0x260>
  800235:	48 8d 4d f0          	lea    -0x10(%rbp),%rcx
  800239:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80023c:	ba 04 00 00 00       	mov    $0x4,%edx
  800241:	48 89 ce             	mov    %rcx,%rsi
  800244:	89 c7                	mov    %eax,%edi
  800246:	48 b8 2e 2c 80 00 00 	movabs $0x802c2e,%rax
  80024d:	00 00 00 
  800250:	ff d0                	callq  *%rax
  800252:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800255:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  800259:	74 48                	je     8002a3 <primeproc+0x260>
  80025b:	b8 00 00 00 00       	mov    $0x0,%eax
  800260:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800264:	0f 4e 45 fc          	cmovle -0x4(%rbp),%eax
  800268:	89 c1                	mov    %eax,%ecx
  80026a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80026d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800270:	41 89 c9             	mov    %ecx,%r9d
  800273:	41 89 d0             	mov    %edx,%r8d
  800276:	89 c1                	mov    %eax,%ecx
  800278:	48 ba f6 4a 80 00 00 	movabs $0x804af6,%rdx
  80027f:	00 00 00 
  800282:	be 2f 00 00 00       	mov    $0x2f,%esi
  800287:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  80028e:	00 00 00 
  800291:	b8 00 00 00 00       	mov    $0x0,%eax
  800296:	49 ba ba 04 80 00 00 	movabs $0x8004ba,%r10
  80029d:	00 00 00 
  8002a0:	41 ff d2             	callq  *%r10
  8002a3:	e9 0a ff ff ff       	jmpq   8001b2 <primeproc+0x16f>

00000000008002a8 <umain>:
  8002a8:	55                   	push   %rbp
  8002a9:	48 89 e5             	mov    %rsp,%rbp
  8002ac:	53                   	push   %rbx
  8002ad:	48 83 ec 38          	sub    $0x38,%rsp
  8002b1:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8002b4:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  8002b8:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8002bf:	00 00 00 
  8002c2:	48 bb 10 4b 80 00 00 	movabs $0x804b10,%rbx
  8002c9:	00 00 00 
  8002cc:	48 89 18             	mov    %rbx,(%rax)
  8002cf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8002d3:	48 89 c7             	mov    %rax,%rdi
  8002d6:	48 b8 03 3e 80 00 00 	movabs $0x803e03,%rax
  8002dd:	00 00 00 
  8002e0:	ff d0                	callq  *%rax
  8002e2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8002e5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8002e8:	85 c0                	test   %eax,%eax
  8002ea:	79 30                	jns    80031c <umain+0x74>
  8002ec:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8002ef:	89 c1                	mov    %eax,%ecx
  8002f1:	48 ba c8 4a 80 00 00 	movabs $0x804ac8,%rdx
  8002f8:	00 00 00 
  8002fb:	be 3b 00 00 00       	mov    $0x3b,%esi
  800300:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  800307:	00 00 00 
  80030a:	b8 00 00 00 00       	mov    $0x0,%eax
  80030f:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  800316:	00 00 00 
  800319:	41 ff d0             	callq  *%r8
  80031c:	48 b8 57 23 80 00 00 	movabs $0x802357,%rax
  800323:	00 00 00 
  800326:	ff d0                	callq  *%rax
  800328:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80032b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80032f:	79 30                	jns    800361 <umain+0xb9>
  800331:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800334:	89 c1                	mov    %eax,%ecx
  800336:	48 ba d1 4a 80 00 00 	movabs $0x804ad1,%rdx
  80033d:	00 00 00 
  800340:	be 3f 00 00 00       	mov    $0x3f,%esi
  800345:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  80034c:	00 00 00 
  80034f:	b8 00 00 00 00       	mov    $0x0,%eax
  800354:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  80035b:	00 00 00 
  80035e:	41 ff d0             	callq  *%r8
  800361:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800365:	75 22                	jne    800389 <umain+0xe1>
  800367:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80036a:	89 c7                	mov    %eax,%edi
  80036c:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  800373:	00 00 00 
  800376:	ff d0                	callq  *%rax
  800378:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80037b:	89 c7                	mov    %eax,%edi
  80037d:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800384:	00 00 00 
  800387:	ff d0                	callq  *%rax
  800389:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80038c:	89 c7                	mov    %eax,%edi
  80038e:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  800395:	00 00 00 
  800398:	ff d0                	callq  *%rax
  80039a:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%rbp)
  8003a1:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8003a4:	48 8d 4d e4          	lea    -0x1c(%rbp),%rcx
  8003a8:	ba 04 00 00 00       	mov    $0x4,%edx
  8003ad:	48 89 ce             	mov    %rcx,%rsi
  8003b0:	89 c7                	mov    %eax,%edi
  8003b2:	48 b8 2e 2c 80 00 00 	movabs $0x802c2e,%rax
  8003b9:	00 00 00 
  8003bc:	ff d0                	callq  *%rax
  8003be:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8003c1:	83 7d e8 04          	cmpl   $0x4,-0x18(%rbp)
  8003c5:	74 42                	je     800409 <umain+0x161>
  8003c7:	b8 00 00 00 00       	mov    $0x0,%eax
  8003cc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8003d0:	0f 4e 45 e8          	cmovle -0x18(%rbp),%eax
  8003d4:	89 c2                	mov    %eax,%edx
  8003d6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8003d9:	41 89 d0             	mov    %edx,%r8d
  8003dc:	89 c1                	mov    %eax,%ecx
  8003de:	48 ba 1b 4b 80 00 00 	movabs $0x804b1b,%rdx
  8003e5:	00 00 00 
  8003e8:	be 4b 00 00 00       	mov    $0x4b,%esi
  8003ed:	48 bf af 4a 80 00 00 	movabs $0x804aaf,%rdi
  8003f4:	00 00 00 
  8003f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8003fc:	49 b9 ba 04 80 00 00 	movabs $0x8004ba,%r9
  800403:	00 00 00 
  800406:	41 ff d1             	callq  *%r9
  800409:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80040c:	83 c0 01             	add    $0x1,%eax
  80040f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  800412:	eb 8d                	jmp    8003a1 <umain+0xf9>

0000000000800414 <libmain>:
  800414:	55                   	push   %rbp
  800415:	48 89 e5             	mov    %rsp,%rbp
  800418:	48 83 ec 10          	sub    $0x10,%rsp
  80041c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80041f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800423:	48 b8 5b 1b 80 00 00 	movabs $0x801b5b,%rax
  80042a:	00 00 00 
  80042d:	ff d0                	callq  *%rax
  80042f:	25 ff 03 00 00       	and    $0x3ff,%eax
  800434:	48 98                	cltq   
  800436:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80043d:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800444:	00 00 00 
  800447:	48 01 c2             	add    %rax,%rdx
  80044a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800451:	00 00 00 
  800454:	48 89 10             	mov    %rdx,(%rax)
  800457:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80045b:	7e 14                	jle    800471 <libmain+0x5d>
  80045d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800461:	48 8b 10             	mov    (%rax),%rdx
  800464:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80046b:	00 00 00 
  80046e:	48 89 10             	mov    %rdx,(%rax)
  800471:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800475:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800478:	48 89 d6             	mov    %rdx,%rsi
  80047b:	89 c7                	mov    %eax,%edi
  80047d:	48 b8 a8 02 80 00 00 	movabs $0x8002a8,%rax
  800484:	00 00 00 
  800487:	ff d0                	callq  *%rax
  800489:	48 b8 97 04 80 00 00 	movabs $0x800497,%rax
  800490:	00 00 00 
  800493:	ff d0                	callq  *%rax
  800495:	c9                   	leaveq 
  800496:	c3                   	retq   

0000000000800497 <exit>:
  800497:	55                   	push   %rbp
  800498:	48 89 e5             	mov    %rsp,%rbp
  80049b:	48 b8 0d 29 80 00 00 	movabs $0x80290d,%rax
  8004a2:	00 00 00 
  8004a5:	ff d0                	callq  *%rax
  8004a7:	bf 00 00 00 00       	mov    $0x0,%edi
  8004ac:	48 b8 17 1b 80 00 00 	movabs $0x801b17,%rax
  8004b3:	00 00 00 
  8004b6:	ff d0                	callq  *%rax
  8004b8:	5d                   	pop    %rbp
  8004b9:	c3                   	retq   

00000000008004ba <_panic>:
  8004ba:	55                   	push   %rbp
  8004bb:	48 89 e5             	mov    %rsp,%rbp
  8004be:	53                   	push   %rbx
  8004bf:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  8004c6:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  8004cd:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  8004d3:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8004da:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8004e1:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8004e8:	84 c0                	test   %al,%al
  8004ea:	74 23                	je     80050f <_panic+0x55>
  8004ec:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8004f3:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8004f7:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8004fb:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  8004ff:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800503:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800507:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80050b:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80050f:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800516:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  80051d:	00 00 00 
  800520:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800527:	00 00 00 
  80052a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80052e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800535:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80053c:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800543:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80054a:	00 00 00 
  80054d:	48 8b 18             	mov    (%rax),%rbx
  800550:	48 b8 5b 1b 80 00 00 	movabs $0x801b5b,%rax
  800557:	00 00 00 
  80055a:	ff d0                	callq  *%rax
  80055c:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800562:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800569:	41 89 c8             	mov    %ecx,%r8d
  80056c:	48 89 d1             	mov    %rdx,%rcx
  80056f:	48 89 da             	mov    %rbx,%rdx
  800572:	89 c6                	mov    %eax,%esi
  800574:	48 bf 40 4b 80 00 00 	movabs $0x804b40,%rdi
  80057b:	00 00 00 
  80057e:	b8 00 00 00 00       	mov    $0x0,%eax
  800583:	49 b9 f3 06 80 00 00 	movabs $0x8006f3,%r9
  80058a:	00 00 00 
  80058d:	41 ff d1             	callq  *%r9
  800590:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  800597:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80059e:	48 89 d6             	mov    %rdx,%rsi
  8005a1:	48 89 c7             	mov    %rax,%rdi
  8005a4:	48 b8 47 06 80 00 00 	movabs $0x800647,%rax
  8005ab:	00 00 00 
  8005ae:	ff d0                	callq  *%rax
  8005b0:	48 bf 63 4b 80 00 00 	movabs $0x804b63,%rdi
  8005b7:	00 00 00 
  8005ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8005bf:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  8005c6:	00 00 00 
  8005c9:	ff d2                	callq  *%rdx
  8005cb:	cc                   	int3   
  8005cc:	eb fd                	jmp    8005cb <_panic+0x111>

00000000008005ce <putch>:
  8005ce:	55                   	push   %rbp
  8005cf:	48 89 e5             	mov    %rsp,%rbp
  8005d2:	48 83 ec 10          	sub    $0x10,%rsp
  8005d6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8005d9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8005dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005e1:	8b 00                	mov    (%rax),%eax
  8005e3:	8d 48 01             	lea    0x1(%rax),%ecx
  8005e6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8005ea:	89 0a                	mov    %ecx,(%rdx)
  8005ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8005ef:	89 d1                	mov    %edx,%ecx
  8005f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8005f5:	48 98                	cltq   
  8005f7:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8005fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005ff:	8b 00                	mov    (%rax),%eax
  800601:	3d ff 00 00 00       	cmp    $0xff,%eax
  800606:	75 2c                	jne    800634 <putch+0x66>
  800608:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80060c:	8b 00                	mov    (%rax),%eax
  80060e:	48 98                	cltq   
  800610:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800614:	48 83 c2 08          	add    $0x8,%rdx
  800618:	48 89 c6             	mov    %rax,%rsi
  80061b:	48 89 d7             	mov    %rdx,%rdi
  80061e:	48 b8 8f 1a 80 00 00 	movabs $0x801a8f,%rax
  800625:	00 00 00 
  800628:	ff d0                	callq  *%rax
  80062a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80062e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800634:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800638:	8b 40 04             	mov    0x4(%rax),%eax
  80063b:	8d 50 01             	lea    0x1(%rax),%edx
  80063e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800642:	89 50 04             	mov    %edx,0x4(%rax)
  800645:	c9                   	leaveq 
  800646:	c3                   	retq   

0000000000800647 <vcprintf>:
  800647:	55                   	push   %rbp
  800648:	48 89 e5             	mov    %rsp,%rbp
  80064b:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800652:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800659:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800660:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800667:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  80066e:	48 8b 0a             	mov    (%rdx),%rcx
  800671:	48 89 08             	mov    %rcx,(%rax)
  800674:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800678:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80067c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800680:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800684:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  80068b:	00 00 00 
  80068e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800695:	00 00 00 
  800698:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  80069f:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  8006a6:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  8006ad:	48 89 c6             	mov    %rax,%rsi
  8006b0:	48 bf ce 05 80 00 00 	movabs $0x8005ce,%rdi
  8006b7:	00 00 00 
  8006ba:	48 b8 a6 0a 80 00 00 	movabs $0x800aa6,%rax
  8006c1:	00 00 00 
  8006c4:	ff d0                	callq  *%rax
  8006c6:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8006cc:	48 98                	cltq   
  8006ce:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8006d5:	48 83 c2 08          	add    $0x8,%rdx
  8006d9:	48 89 c6             	mov    %rax,%rsi
  8006dc:	48 89 d7             	mov    %rdx,%rdi
  8006df:	48 b8 8f 1a 80 00 00 	movabs $0x801a8f,%rax
  8006e6:	00 00 00 
  8006e9:	ff d0                	callq  *%rax
  8006eb:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8006f1:	c9                   	leaveq 
  8006f2:	c3                   	retq   

00000000008006f3 <cprintf>:
  8006f3:	55                   	push   %rbp
  8006f4:	48 89 e5             	mov    %rsp,%rbp
  8006f7:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8006fe:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800705:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  80070c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800713:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80071a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800721:	84 c0                	test   %al,%al
  800723:	74 20                	je     800745 <cprintf+0x52>
  800725:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800729:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80072d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800731:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800735:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800739:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80073d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800741:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800745:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80074c:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800753:	00 00 00 
  800756:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80075d:	00 00 00 
  800760:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800764:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80076b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800772:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800779:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800780:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800787:	48 8b 0a             	mov    (%rdx),%rcx
  80078a:	48 89 08             	mov    %rcx,(%rax)
  80078d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800791:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800795:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800799:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80079d:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  8007a4:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8007ab:	48 89 d6             	mov    %rdx,%rsi
  8007ae:	48 89 c7             	mov    %rax,%rdi
  8007b1:	48 b8 47 06 80 00 00 	movabs $0x800647,%rax
  8007b8:	00 00 00 
  8007bb:	ff d0                	callq  *%rax
  8007bd:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8007c3:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8007c9:	c9                   	leaveq 
  8007ca:	c3                   	retq   

00000000008007cb <printnum>:
  8007cb:	55                   	push   %rbp
  8007cc:	48 89 e5             	mov    %rsp,%rbp
  8007cf:	53                   	push   %rbx
  8007d0:	48 83 ec 38          	sub    $0x38,%rsp
  8007d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8007d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8007dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8007e0:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8007e3:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8007e7:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8007eb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8007ee:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8007f2:	77 3b                	ja     80082f <printnum+0x64>
  8007f4:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8007f7:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8007fb:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8007fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800802:	ba 00 00 00 00       	mov    $0x0,%edx
  800807:	48 f7 f3             	div    %rbx
  80080a:	48 89 c2             	mov    %rax,%rdx
  80080d:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800810:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800813:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800817:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80081b:	41 89 f9             	mov    %edi,%r9d
  80081e:	48 89 c7             	mov    %rax,%rdi
  800821:	48 b8 cb 07 80 00 00 	movabs $0x8007cb,%rax
  800828:	00 00 00 
  80082b:	ff d0                	callq  *%rax
  80082d:	eb 1e                	jmp    80084d <printnum+0x82>
  80082f:	eb 12                	jmp    800843 <printnum+0x78>
  800831:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800835:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800838:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80083c:	48 89 ce             	mov    %rcx,%rsi
  80083f:	89 d7                	mov    %edx,%edi
  800841:	ff d0                	callq  *%rax
  800843:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800847:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  80084b:	7f e4                	jg     800831 <printnum+0x66>
  80084d:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800850:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800854:	ba 00 00 00 00       	mov    $0x0,%edx
  800859:	48 f7 f1             	div    %rcx
  80085c:	48 89 d0             	mov    %rdx,%rax
  80085f:	48 ba 70 4d 80 00 00 	movabs $0x804d70,%rdx
  800866:	00 00 00 
  800869:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  80086d:	0f be d0             	movsbl %al,%edx
  800870:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800874:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800878:	48 89 ce             	mov    %rcx,%rsi
  80087b:	89 d7                	mov    %edx,%edi
  80087d:	ff d0                	callq  *%rax
  80087f:	48 83 c4 38          	add    $0x38,%rsp
  800883:	5b                   	pop    %rbx
  800884:	5d                   	pop    %rbp
  800885:	c3                   	retq   

0000000000800886 <getuint>:
  800886:	55                   	push   %rbp
  800887:	48 89 e5             	mov    %rsp,%rbp
  80088a:	48 83 ec 1c          	sub    $0x1c,%rsp
  80088e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800892:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800895:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800899:	7e 52                	jle    8008ed <getuint+0x67>
  80089b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80089f:	8b 00                	mov    (%rax),%eax
  8008a1:	83 f8 30             	cmp    $0x30,%eax
  8008a4:	73 24                	jae    8008ca <getuint+0x44>
  8008a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008aa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8008ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008b2:	8b 00                	mov    (%rax),%eax
  8008b4:	89 c0                	mov    %eax,%eax
  8008b6:	48 01 d0             	add    %rdx,%rax
  8008b9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008bd:	8b 12                	mov    (%rdx),%edx
  8008bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8008c2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008c6:	89 0a                	mov    %ecx,(%rdx)
  8008c8:	eb 17                	jmp    8008e1 <getuint+0x5b>
  8008ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008ce:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8008d2:	48 89 d0             	mov    %rdx,%rax
  8008d5:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8008d9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8008dd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8008e1:	48 8b 00             	mov    (%rax),%rax
  8008e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8008e8:	e9 a3 00 00 00       	jmpq   800990 <getuint+0x10a>
  8008ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8008f1:	74 4f                	je     800942 <getuint+0xbc>
  8008f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008f7:	8b 00                	mov    (%rax),%eax
  8008f9:	83 f8 30             	cmp    $0x30,%eax
  8008fc:	73 24                	jae    800922 <getuint+0x9c>
  8008fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800902:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800906:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80090a:	8b 00                	mov    (%rax),%eax
  80090c:	89 c0                	mov    %eax,%eax
  80090e:	48 01 d0             	add    %rdx,%rax
  800911:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800915:	8b 12                	mov    (%rdx),%edx
  800917:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80091a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80091e:	89 0a                	mov    %ecx,(%rdx)
  800920:	eb 17                	jmp    800939 <getuint+0xb3>
  800922:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800926:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80092a:	48 89 d0             	mov    %rdx,%rax
  80092d:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800931:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800935:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800939:	48 8b 00             	mov    (%rax),%rax
  80093c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800940:	eb 4e                	jmp    800990 <getuint+0x10a>
  800942:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800946:	8b 00                	mov    (%rax),%eax
  800948:	83 f8 30             	cmp    $0x30,%eax
  80094b:	73 24                	jae    800971 <getuint+0xeb>
  80094d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800951:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800955:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800959:	8b 00                	mov    (%rax),%eax
  80095b:	89 c0                	mov    %eax,%eax
  80095d:	48 01 d0             	add    %rdx,%rax
  800960:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800964:	8b 12                	mov    (%rdx),%edx
  800966:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800969:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80096d:	89 0a                	mov    %ecx,(%rdx)
  80096f:	eb 17                	jmp    800988 <getuint+0x102>
  800971:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800975:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800979:	48 89 d0             	mov    %rdx,%rax
  80097c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800980:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800984:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800988:	8b 00                	mov    (%rax),%eax
  80098a:	89 c0                	mov    %eax,%eax
  80098c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800990:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800994:	c9                   	leaveq 
  800995:	c3                   	retq   

0000000000800996 <getint>:
  800996:	55                   	push   %rbp
  800997:	48 89 e5             	mov    %rsp,%rbp
  80099a:	48 83 ec 1c          	sub    $0x1c,%rsp
  80099e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8009a2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8009a5:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  8009a9:	7e 52                	jle    8009fd <getint+0x67>
  8009ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009af:	8b 00                	mov    (%rax),%eax
  8009b1:	83 f8 30             	cmp    $0x30,%eax
  8009b4:	73 24                	jae    8009da <getint+0x44>
  8009b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009ba:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8009be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009c2:	8b 00                	mov    (%rax),%eax
  8009c4:	89 c0                	mov    %eax,%eax
  8009c6:	48 01 d0             	add    %rdx,%rax
  8009c9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009cd:	8b 12                	mov    (%rdx),%edx
  8009cf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8009d2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009d6:	89 0a                	mov    %ecx,(%rdx)
  8009d8:	eb 17                	jmp    8009f1 <getint+0x5b>
  8009da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009de:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8009e2:	48 89 d0             	mov    %rdx,%rax
  8009e5:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8009e9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8009ed:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8009f1:	48 8b 00             	mov    (%rax),%rax
  8009f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8009f8:	e9 a3 00 00 00       	jmpq   800aa0 <getint+0x10a>
  8009fd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800a01:	74 4f                	je     800a52 <getint+0xbc>
  800a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a07:	8b 00                	mov    (%rax),%eax
  800a09:	83 f8 30             	cmp    $0x30,%eax
  800a0c:	73 24                	jae    800a32 <getint+0x9c>
  800a0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a12:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a16:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a1a:	8b 00                	mov    (%rax),%eax
  800a1c:	89 c0                	mov    %eax,%eax
  800a1e:	48 01 d0             	add    %rdx,%rax
  800a21:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a25:	8b 12                	mov    (%rdx),%edx
  800a27:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a2a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a2e:	89 0a                	mov    %ecx,(%rdx)
  800a30:	eb 17                	jmp    800a49 <getint+0xb3>
  800a32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a36:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a3a:	48 89 d0             	mov    %rdx,%rax
  800a3d:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a41:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a49:	48 8b 00             	mov    (%rax),%rax
  800a4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a50:	eb 4e                	jmp    800aa0 <getint+0x10a>
  800a52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a56:	8b 00                	mov    (%rax),%eax
  800a58:	83 f8 30             	cmp    $0x30,%eax
  800a5b:	73 24                	jae    800a81 <getint+0xeb>
  800a5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a61:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a69:	8b 00                	mov    (%rax),%eax
  800a6b:	89 c0                	mov    %eax,%eax
  800a6d:	48 01 d0             	add    %rdx,%rax
  800a70:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a74:	8b 12                	mov    (%rdx),%edx
  800a76:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a79:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a7d:	89 0a                	mov    %ecx,(%rdx)
  800a7f:	eb 17                	jmp    800a98 <getint+0x102>
  800a81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a85:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a89:	48 89 d0             	mov    %rdx,%rax
  800a8c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a90:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a94:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a98:	8b 00                	mov    (%rax),%eax
  800a9a:	48 98                	cltq   
  800a9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800aa4:	c9                   	leaveq 
  800aa5:	c3                   	retq   

0000000000800aa6 <vprintfmt>:
  800aa6:	55                   	push   %rbp
  800aa7:	48 89 e5             	mov    %rsp,%rbp
  800aaa:	41 54                	push   %r12
  800aac:	53                   	push   %rbx
  800aad:	48 83 ec 60          	sub    $0x60,%rsp
  800ab1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800ab5:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800ab9:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800abd:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800ac1:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ac5:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800ac9:	48 8b 0a             	mov    (%rdx),%rcx
  800acc:	48 89 08             	mov    %rcx,(%rax)
  800acf:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ad3:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ad7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800adb:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800adf:	eb 17                	jmp    800af8 <vprintfmt+0x52>
  800ae1:	85 db                	test   %ebx,%ebx
  800ae3:	0f 84 cc 04 00 00    	je     800fb5 <vprintfmt+0x50f>
  800ae9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800aed:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800af1:	48 89 d6             	mov    %rdx,%rsi
  800af4:	89 df                	mov    %ebx,%edi
  800af6:	ff d0                	callq  *%rax
  800af8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800afc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800b00:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800b04:	0f b6 00             	movzbl (%rax),%eax
  800b07:	0f b6 d8             	movzbl %al,%ebx
  800b0a:	83 fb 25             	cmp    $0x25,%ebx
  800b0d:	75 d2                	jne    800ae1 <vprintfmt+0x3b>
  800b0f:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800b13:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800b1a:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800b21:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800b28:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800b2f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b33:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800b37:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800b3b:	0f b6 00             	movzbl (%rax),%eax
  800b3e:	0f b6 d8             	movzbl %al,%ebx
  800b41:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800b44:	83 f8 55             	cmp    $0x55,%eax
  800b47:	0f 87 34 04 00 00    	ja     800f81 <vprintfmt+0x4db>
  800b4d:	89 c0                	mov    %eax,%eax
  800b4f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800b56:	00 
  800b57:	48 b8 98 4d 80 00 00 	movabs $0x804d98,%rax
  800b5e:	00 00 00 
  800b61:	48 01 d0             	add    %rdx,%rax
  800b64:	48 8b 00             	mov    (%rax),%rax
  800b67:	ff e0                	jmpq   *%rax
  800b69:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800b6d:	eb c0                	jmp    800b2f <vprintfmt+0x89>
  800b6f:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800b73:	eb ba                	jmp    800b2f <vprintfmt+0x89>
  800b75:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800b7c:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800b7f:	89 d0                	mov    %edx,%eax
  800b81:	c1 e0 02             	shl    $0x2,%eax
  800b84:	01 d0                	add    %edx,%eax
  800b86:	01 c0                	add    %eax,%eax
  800b88:	01 d8                	add    %ebx,%eax
  800b8a:	83 e8 30             	sub    $0x30,%eax
  800b8d:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800b90:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800b94:	0f b6 00             	movzbl (%rax),%eax
  800b97:	0f be d8             	movsbl %al,%ebx
  800b9a:	83 fb 2f             	cmp    $0x2f,%ebx
  800b9d:	7e 0c                	jle    800bab <vprintfmt+0x105>
  800b9f:	83 fb 39             	cmp    $0x39,%ebx
  800ba2:	7f 07                	jg     800bab <vprintfmt+0x105>
  800ba4:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800ba9:	eb d1                	jmp    800b7c <vprintfmt+0xd6>
  800bab:	eb 58                	jmp    800c05 <vprintfmt+0x15f>
  800bad:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bb0:	83 f8 30             	cmp    $0x30,%eax
  800bb3:	73 17                	jae    800bcc <vprintfmt+0x126>
  800bb5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800bb9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bbc:	89 c0                	mov    %eax,%eax
  800bbe:	48 01 d0             	add    %rdx,%rax
  800bc1:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800bc4:	83 c2 08             	add    $0x8,%edx
  800bc7:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800bca:	eb 0f                	jmp    800bdb <vprintfmt+0x135>
  800bcc:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bd0:	48 89 d0             	mov    %rdx,%rax
  800bd3:	48 83 c2 08          	add    $0x8,%rdx
  800bd7:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bdb:	8b 00                	mov    (%rax),%eax
  800bdd:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800be0:	eb 23                	jmp    800c05 <vprintfmt+0x15f>
  800be2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800be6:	79 0c                	jns    800bf4 <vprintfmt+0x14e>
  800be8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800bef:	e9 3b ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800bf4:	e9 36 ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800bf9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800c00:	e9 2a ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800c05:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800c09:	79 12                	jns    800c1d <vprintfmt+0x177>
  800c0b:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800c0e:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800c11:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800c18:	e9 12 ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800c1d:	e9 0d ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800c22:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800c26:	e9 04 ff ff ff       	jmpq   800b2f <vprintfmt+0x89>
  800c2b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c2e:	83 f8 30             	cmp    $0x30,%eax
  800c31:	73 17                	jae    800c4a <vprintfmt+0x1a4>
  800c33:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c37:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c3a:	89 c0                	mov    %eax,%eax
  800c3c:	48 01 d0             	add    %rdx,%rax
  800c3f:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c42:	83 c2 08             	add    $0x8,%edx
  800c45:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c48:	eb 0f                	jmp    800c59 <vprintfmt+0x1b3>
  800c4a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c4e:	48 89 d0             	mov    %rdx,%rax
  800c51:	48 83 c2 08          	add    $0x8,%rdx
  800c55:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c59:	8b 10                	mov    (%rax),%edx
  800c5b:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800c5f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c63:	48 89 ce             	mov    %rcx,%rsi
  800c66:	89 d7                	mov    %edx,%edi
  800c68:	ff d0                	callq  *%rax
  800c6a:	e9 40 03 00 00       	jmpq   800faf <vprintfmt+0x509>
  800c6f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c72:	83 f8 30             	cmp    $0x30,%eax
  800c75:	73 17                	jae    800c8e <vprintfmt+0x1e8>
  800c77:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800c7b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800c7e:	89 c0                	mov    %eax,%eax
  800c80:	48 01 d0             	add    %rdx,%rax
  800c83:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800c86:	83 c2 08             	add    $0x8,%edx
  800c89:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800c8c:	eb 0f                	jmp    800c9d <vprintfmt+0x1f7>
  800c8e:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800c92:	48 89 d0             	mov    %rdx,%rax
  800c95:	48 83 c2 08          	add    $0x8,%rdx
  800c99:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800c9d:	8b 18                	mov    (%rax),%ebx
  800c9f:	85 db                	test   %ebx,%ebx
  800ca1:	79 02                	jns    800ca5 <vprintfmt+0x1ff>
  800ca3:	f7 db                	neg    %ebx
  800ca5:	83 fb 15             	cmp    $0x15,%ebx
  800ca8:	7f 16                	jg     800cc0 <vprintfmt+0x21a>
  800caa:	48 b8 c0 4c 80 00 00 	movabs $0x804cc0,%rax
  800cb1:	00 00 00 
  800cb4:	48 63 d3             	movslq %ebx,%rdx
  800cb7:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800cbb:	4d 85 e4             	test   %r12,%r12
  800cbe:	75 2e                	jne    800cee <vprintfmt+0x248>
  800cc0:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800cc4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cc8:	89 d9                	mov    %ebx,%ecx
  800cca:	48 ba 81 4d 80 00 00 	movabs $0x804d81,%rdx
  800cd1:	00 00 00 
  800cd4:	48 89 c7             	mov    %rax,%rdi
  800cd7:	b8 00 00 00 00       	mov    $0x0,%eax
  800cdc:	49 b8 be 0f 80 00 00 	movabs $0x800fbe,%r8
  800ce3:	00 00 00 
  800ce6:	41 ff d0             	callq  *%r8
  800ce9:	e9 c1 02 00 00       	jmpq   800faf <vprintfmt+0x509>
  800cee:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800cf2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800cf6:	4c 89 e1             	mov    %r12,%rcx
  800cf9:	48 ba 8a 4d 80 00 00 	movabs $0x804d8a,%rdx
  800d00:	00 00 00 
  800d03:	48 89 c7             	mov    %rax,%rdi
  800d06:	b8 00 00 00 00       	mov    $0x0,%eax
  800d0b:	49 b8 be 0f 80 00 00 	movabs $0x800fbe,%r8
  800d12:	00 00 00 
  800d15:	41 ff d0             	callq  *%r8
  800d18:	e9 92 02 00 00       	jmpq   800faf <vprintfmt+0x509>
  800d1d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d20:	83 f8 30             	cmp    $0x30,%eax
  800d23:	73 17                	jae    800d3c <vprintfmt+0x296>
  800d25:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d29:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d2c:	89 c0                	mov    %eax,%eax
  800d2e:	48 01 d0             	add    %rdx,%rax
  800d31:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d34:	83 c2 08             	add    $0x8,%edx
  800d37:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d3a:	eb 0f                	jmp    800d4b <vprintfmt+0x2a5>
  800d3c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d40:	48 89 d0             	mov    %rdx,%rax
  800d43:	48 83 c2 08          	add    $0x8,%rdx
  800d47:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d4b:	4c 8b 20             	mov    (%rax),%r12
  800d4e:	4d 85 e4             	test   %r12,%r12
  800d51:	75 0a                	jne    800d5d <vprintfmt+0x2b7>
  800d53:	49 bc 8d 4d 80 00 00 	movabs $0x804d8d,%r12
  800d5a:	00 00 00 
  800d5d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d61:	7e 3f                	jle    800da2 <vprintfmt+0x2fc>
  800d63:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800d67:	74 39                	je     800da2 <vprintfmt+0x2fc>
  800d69:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800d6c:	48 98                	cltq   
  800d6e:	48 89 c6             	mov    %rax,%rsi
  800d71:	4c 89 e7             	mov    %r12,%rdi
  800d74:	48 b8 6a 12 80 00 00 	movabs $0x80126a,%rax
  800d7b:	00 00 00 
  800d7e:	ff d0                	callq  *%rax
  800d80:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800d83:	eb 17                	jmp    800d9c <vprintfmt+0x2f6>
  800d85:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800d89:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800d8d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800d91:	48 89 ce             	mov    %rcx,%rsi
  800d94:	89 d7                	mov    %edx,%edi
  800d96:	ff d0                	callq  *%rax
  800d98:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800d9c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800da0:	7f e3                	jg     800d85 <vprintfmt+0x2df>
  800da2:	eb 37                	jmp    800ddb <vprintfmt+0x335>
  800da4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800da8:	74 1e                	je     800dc8 <vprintfmt+0x322>
  800daa:	83 fb 1f             	cmp    $0x1f,%ebx
  800dad:	7e 05                	jle    800db4 <vprintfmt+0x30e>
  800daf:	83 fb 7e             	cmp    $0x7e,%ebx
  800db2:	7e 14                	jle    800dc8 <vprintfmt+0x322>
  800db4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800db8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dbc:	48 89 d6             	mov    %rdx,%rsi
  800dbf:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800dc4:	ff d0                	callq  *%rax
  800dc6:	eb 0f                	jmp    800dd7 <vprintfmt+0x331>
  800dc8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800dcc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800dd0:	48 89 d6             	mov    %rdx,%rsi
  800dd3:	89 df                	mov    %ebx,%edi
  800dd5:	ff d0                	callq  *%rax
  800dd7:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ddb:	4c 89 e0             	mov    %r12,%rax
  800dde:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800de2:	0f b6 00             	movzbl (%rax),%eax
  800de5:	0f be d8             	movsbl %al,%ebx
  800de8:	85 db                	test   %ebx,%ebx
  800dea:	74 10                	je     800dfc <vprintfmt+0x356>
  800dec:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800df0:	78 b2                	js     800da4 <vprintfmt+0x2fe>
  800df2:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800df6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800dfa:	79 a8                	jns    800da4 <vprintfmt+0x2fe>
  800dfc:	eb 16                	jmp    800e14 <vprintfmt+0x36e>
  800dfe:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e02:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e06:	48 89 d6             	mov    %rdx,%rsi
  800e09:	bf 20 00 00 00       	mov    $0x20,%edi
  800e0e:	ff d0                	callq  *%rax
  800e10:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800e14:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800e18:	7f e4                	jg     800dfe <vprintfmt+0x358>
  800e1a:	e9 90 01 00 00       	jmpq   800faf <vprintfmt+0x509>
  800e1f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e23:	be 03 00 00 00       	mov    $0x3,%esi
  800e28:	48 89 c7             	mov    %rax,%rdi
  800e2b:	48 b8 96 09 80 00 00 	movabs $0x800996,%rax
  800e32:	00 00 00 
  800e35:	ff d0                	callq  *%rax
  800e37:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e3f:	48 85 c0             	test   %rax,%rax
  800e42:	79 1d                	jns    800e61 <vprintfmt+0x3bb>
  800e44:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800e48:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e4c:	48 89 d6             	mov    %rdx,%rsi
  800e4f:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800e54:	ff d0                	callq  *%rax
  800e56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e5a:	48 f7 d8             	neg    %rax
  800e5d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e61:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800e68:	e9 d5 00 00 00       	jmpq   800f42 <vprintfmt+0x49c>
  800e6d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e71:	be 03 00 00 00       	mov    $0x3,%esi
  800e76:	48 89 c7             	mov    %rax,%rdi
  800e79:	48 b8 86 08 80 00 00 	movabs $0x800886,%rax
  800e80:	00 00 00 
  800e83:	ff d0                	callq  *%rax
  800e85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800e89:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800e90:	e9 ad 00 00 00       	jmpq   800f42 <vprintfmt+0x49c>
  800e95:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800e99:	be 03 00 00 00       	mov    $0x3,%esi
  800e9e:	48 89 c7             	mov    %rax,%rdi
  800ea1:	48 b8 86 08 80 00 00 	movabs $0x800886,%rax
  800ea8:	00 00 00 
  800eab:	ff d0                	callq  *%rax
  800ead:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800eb1:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800eb8:	e9 85 00 00 00       	jmpq   800f42 <vprintfmt+0x49c>
  800ebd:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ec1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ec5:	48 89 d6             	mov    %rdx,%rsi
  800ec8:	bf 30 00 00 00       	mov    $0x30,%edi
  800ecd:	ff d0                	callq  *%rax
  800ecf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ed3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800ed7:	48 89 d6             	mov    %rdx,%rsi
  800eda:	bf 78 00 00 00       	mov    $0x78,%edi
  800edf:	ff d0                	callq  *%rax
  800ee1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ee4:	83 f8 30             	cmp    $0x30,%eax
  800ee7:	73 17                	jae    800f00 <vprintfmt+0x45a>
  800ee9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800eed:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ef0:	89 c0                	mov    %eax,%eax
  800ef2:	48 01 d0             	add    %rdx,%rax
  800ef5:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800ef8:	83 c2 08             	add    $0x8,%edx
  800efb:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800efe:	eb 0f                	jmp    800f0f <vprintfmt+0x469>
  800f00:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800f04:	48 89 d0             	mov    %rdx,%rax
  800f07:	48 83 c2 08          	add    $0x8,%rdx
  800f0b:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800f0f:	48 8b 00             	mov    (%rax),%rax
  800f12:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f16:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800f1d:	eb 23                	jmp    800f42 <vprintfmt+0x49c>
  800f1f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800f23:	be 03 00 00 00       	mov    $0x3,%esi
  800f28:	48 89 c7             	mov    %rax,%rdi
  800f2b:	48 b8 86 08 80 00 00 	movabs $0x800886,%rax
  800f32:	00 00 00 
  800f35:	ff d0                	callq  *%rax
  800f37:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800f3b:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800f42:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800f47:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800f4a:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800f4d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f51:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800f55:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f59:	45 89 c1             	mov    %r8d,%r9d
  800f5c:	41 89 f8             	mov    %edi,%r8d
  800f5f:	48 89 c7             	mov    %rax,%rdi
  800f62:	48 b8 cb 07 80 00 00 	movabs $0x8007cb,%rax
  800f69:	00 00 00 
  800f6c:	ff d0                	callq  *%rax
  800f6e:	eb 3f                	jmp    800faf <vprintfmt+0x509>
  800f70:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f74:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f78:	48 89 d6             	mov    %rdx,%rsi
  800f7b:	89 df                	mov    %ebx,%edi
  800f7d:	ff d0                	callq  *%rax
  800f7f:	eb 2e                	jmp    800faf <vprintfmt+0x509>
  800f81:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f85:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f89:	48 89 d6             	mov    %rdx,%rsi
  800f8c:	bf 25 00 00 00       	mov    $0x25,%edi
  800f91:	ff d0                	callq  *%rax
  800f93:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800f98:	eb 05                	jmp    800f9f <vprintfmt+0x4f9>
  800f9a:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800f9f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800fa3:	48 83 e8 01          	sub    $0x1,%rax
  800fa7:	0f b6 00             	movzbl (%rax),%eax
  800faa:	3c 25                	cmp    $0x25,%al
  800fac:	75 ec                	jne    800f9a <vprintfmt+0x4f4>
  800fae:	90                   	nop
  800faf:	90                   	nop
  800fb0:	e9 43 fb ff ff       	jmpq   800af8 <vprintfmt+0x52>
  800fb5:	48 83 c4 60          	add    $0x60,%rsp
  800fb9:	5b                   	pop    %rbx
  800fba:	41 5c                	pop    %r12
  800fbc:	5d                   	pop    %rbp
  800fbd:	c3                   	retq   

0000000000800fbe <printfmt>:
  800fbe:	55                   	push   %rbp
  800fbf:	48 89 e5             	mov    %rsp,%rbp
  800fc2:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800fc9:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800fd0:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800fd7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800fde:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800fe5:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800fec:	84 c0                	test   %al,%al
  800fee:	74 20                	je     801010 <printfmt+0x52>
  800ff0:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800ff4:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800ff8:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800ffc:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801000:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801004:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  801008:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80100c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801010:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  801017:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  80101e:	00 00 00 
  801021:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  801028:	00 00 00 
  80102b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80102f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801036:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80103d:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  801044:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  80104b:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  801052:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  801059:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  801060:	48 89 c7             	mov    %rax,%rdi
  801063:	48 b8 a6 0a 80 00 00 	movabs $0x800aa6,%rax
  80106a:	00 00 00 
  80106d:	ff d0                	callq  *%rax
  80106f:	c9                   	leaveq 
  801070:	c3                   	retq   

0000000000801071 <sprintputch>:
  801071:	55                   	push   %rbp
  801072:	48 89 e5             	mov    %rsp,%rbp
  801075:	48 83 ec 10          	sub    $0x10,%rsp
  801079:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80107c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801080:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801084:	8b 40 10             	mov    0x10(%rax),%eax
  801087:	8d 50 01             	lea    0x1(%rax),%edx
  80108a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80108e:	89 50 10             	mov    %edx,0x10(%rax)
  801091:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801095:	48 8b 10             	mov    (%rax),%rdx
  801098:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80109c:	48 8b 40 08          	mov    0x8(%rax),%rax
  8010a0:	48 39 c2             	cmp    %rax,%rdx
  8010a3:	73 17                	jae    8010bc <sprintputch+0x4b>
  8010a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010a9:	48 8b 00             	mov    (%rax),%rax
  8010ac:	48 8d 48 01          	lea    0x1(%rax),%rcx
  8010b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8010b4:	48 89 0a             	mov    %rcx,(%rdx)
  8010b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8010ba:	88 10                	mov    %dl,(%rax)
  8010bc:	c9                   	leaveq 
  8010bd:	c3                   	retq   

00000000008010be <vsnprintf>:
  8010be:	55                   	push   %rbp
  8010bf:	48 89 e5             	mov    %rsp,%rbp
  8010c2:	48 83 ec 50          	sub    $0x50,%rsp
  8010c6:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8010ca:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  8010cd:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  8010d1:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  8010d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  8010d9:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  8010dd:	48 8b 0a             	mov    (%rdx),%rcx
  8010e0:	48 89 08             	mov    %rcx,(%rax)
  8010e3:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8010e7:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8010eb:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8010ef:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8010f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8010f7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8010fb:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  8010fe:	48 98                	cltq   
  801100:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801104:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801108:	48 01 d0             	add    %rdx,%rax
  80110b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  80110f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801116:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  80111b:	74 06                	je     801123 <vsnprintf+0x65>
  80111d:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801121:	7f 07                	jg     80112a <vsnprintf+0x6c>
  801123:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801128:	eb 2f                	jmp    801159 <vsnprintf+0x9b>
  80112a:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  80112e:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801132:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801136:	48 89 c6             	mov    %rax,%rsi
  801139:	48 bf 71 10 80 00 00 	movabs $0x801071,%rdi
  801140:	00 00 00 
  801143:	48 b8 a6 0a 80 00 00 	movabs $0x800aa6,%rax
  80114a:	00 00 00 
  80114d:	ff d0                	callq  *%rax
  80114f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801153:	c6 00 00             	movb   $0x0,(%rax)
  801156:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801159:	c9                   	leaveq 
  80115a:	c3                   	retq   

000000000080115b <snprintf>:
  80115b:	55                   	push   %rbp
  80115c:	48 89 e5             	mov    %rsp,%rbp
  80115f:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  801166:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  80116d:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  801173:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80117a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801181:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801188:	84 c0                	test   %al,%al
  80118a:	74 20                	je     8011ac <snprintf+0x51>
  80118c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801190:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  801194:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801198:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80119c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8011a0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8011a4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8011a8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8011ac:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8011b3:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8011ba:	00 00 00 
  8011bd:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8011c4:	00 00 00 
  8011c7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8011cb:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8011d2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8011d9:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8011e0:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8011e7:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8011ee:	48 8b 0a             	mov    (%rdx),%rcx
  8011f1:	48 89 08             	mov    %rcx,(%rax)
  8011f4:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8011f8:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8011fc:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801200:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801204:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  80120b:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801212:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  801218:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80121f:	48 89 c7             	mov    %rax,%rdi
  801222:	48 b8 be 10 80 00 00 	movabs $0x8010be,%rax
  801229:	00 00 00 
  80122c:	ff d0                	callq  *%rax
  80122e:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  801234:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80123a:	c9                   	leaveq 
  80123b:	c3                   	retq   

000000000080123c <strlen>:
  80123c:	55                   	push   %rbp
  80123d:	48 89 e5             	mov    %rsp,%rbp
  801240:	48 83 ec 18          	sub    $0x18,%rsp
  801244:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80124f:	eb 09                	jmp    80125a <strlen+0x1e>
  801251:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801255:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80125a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80125e:	0f b6 00             	movzbl (%rax),%eax
  801261:	84 c0                	test   %al,%al
  801263:	75 ec                	jne    801251 <strlen+0x15>
  801265:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801268:	c9                   	leaveq 
  801269:	c3                   	retq   

000000000080126a <strnlen>:
  80126a:	55                   	push   %rbp
  80126b:	48 89 e5             	mov    %rsp,%rbp
  80126e:	48 83 ec 20          	sub    $0x20,%rsp
  801272:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801276:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80127a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801281:	eb 0e                	jmp    801291 <strnlen+0x27>
  801283:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801287:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80128c:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801291:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  801296:	74 0b                	je     8012a3 <strnlen+0x39>
  801298:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80129c:	0f b6 00             	movzbl (%rax),%eax
  80129f:	84 c0                	test   %al,%al
  8012a1:	75 e0                	jne    801283 <strnlen+0x19>
  8012a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8012a6:	c9                   	leaveq 
  8012a7:	c3                   	retq   

00000000008012a8 <strcpy>:
  8012a8:	55                   	push   %rbp
  8012a9:	48 89 e5             	mov    %rsp,%rbp
  8012ac:	48 83 ec 20          	sub    $0x20,%rsp
  8012b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012c0:	90                   	nop
  8012c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012c5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8012c9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8012cd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8012d1:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8012d5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8012d9:	0f b6 12             	movzbl (%rdx),%edx
  8012dc:	88 10                	mov    %dl,(%rax)
  8012de:	0f b6 00             	movzbl (%rax),%eax
  8012e1:	84 c0                	test   %al,%al
  8012e3:	75 dc                	jne    8012c1 <strcpy+0x19>
  8012e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012e9:	c9                   	leaveq 
  8012ea:	c3                   	retq   

00000000008012eb <strcat>:
  8012eb:	55                   	push   %rbp
  8012ec:	48 89 e5             	mov    %rsp,%rbp
  8012ef:	48 83 ec 20          	sub    $0x20,%rsp
  8012f3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012f7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012ff:	48 89 c7             	mov    %rax,%rdi
  801302:	48 b8 3c 12 80 00 00 	movabs $0x80123c,%rax
  801309:	00 00 00 
  80130c:	ff d0                	callq  *%rax
  80130e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801311:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801314:	48 63 d0             	movslq %eax,%rdx
  801317:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80131b:	48 01 c2             	add    %rax,%rdx
  80131e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801322:	48 89 c6             	mov    %rax,%rsi
  801325:	48 89 d7             	mov    %rdx,%rdi
  801328:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  80132f:	00 00 00 
  801332:	ff d0                	callq  *%rax
  801334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801338:	c9                   	leaveq 
  801339:	c3                   	retq   

000000000080133a <strncpy>:
  80133a:	55                   	push   %rbp
  80133b:	48 89 e5             	mov    %rsp,%rbp
  80133e:	48 83 ec 28          	sub    $0x28,%rsp
  801342:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801346:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80134a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80134e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801352:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801356:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80135d:	00 
  80135e:	eb 2a                	jmp    80138a <strncpy+0x50>
  801360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801364:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801368:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80136c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801370:	0f b6 12             	movzbl (%rdx),%edx
  801373:	88 10                	mov    %dl,(%rax)
  801375:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801379:	0f b6 00             	movzbl (%rax),%eax
  80137c:	84 c0                	test   %al,%al
  80137e:	74 05                	je     801385 <strncpy+0x4b>
  801380:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  801385:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80138a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80138e:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801392:	72 cc                	jb     801360 <strncpy+0x26>
  801394:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801398:	c9                   	leaveq 
  801399:	c3                   	retq   

000000000080139a <strlcpy>:
  80139a:	55                   	push   %rbp
  80139b:	48 89 e5             	mov    %rsp,%rbp
  80139e:	48 83 ec 28          	sub    $0x28,%rsp
  8013a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013a6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013aa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8013ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8013b6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8013bb:	74 3d                	je     8013fa <strlcpy+0x60>
  8013bd:	eb 1d                	jmp    8013dc <strlcpy+0x42>
  8013bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013c3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8013c7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013cb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8013cf:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8013d3:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8013d7:	0f b6 12             	movzbl (%rdx),%edx
  8013da:	88 10                	mov    %dl,(%rax)
  8013dc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8013e1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8013e6:	74 0b                	je     8013f3 <strlcpy+0x59>
  8013e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8013ec:	0f b6 00             	movzbl (%rax),%eax
  8013ef:	84 c0                	test   %al,%al
  8013f1:	75 cc                	jne    8013bf <strlcpy+0x25>
  8013f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013f7:	c6 00 00             	movb   $0x0,(%rax)
  8013fa:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8013fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801402:	48 29 c2             	sub    %rax,%rdx
  801405:	48 89 d0             	mov    %rdx,%rax
  801408:	c9                   	leaveq 
  801409:	c3                   	retq   

000000000080140a <strcmp>:
  80140a:	55                   	push   %rbp
  80140b:	48 89 e5             	mov    %rsp,%rbp
  80140e:	48 83 ec 10          	sub    $0x10,%rsp
  801412:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801416:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80141a:	eb 0a                	jmp    801426 <strcmp+0x1c>
  80141c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801421:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80142a:	0f b6 00             	movzbl (%rax),%eax
  80142d:	84 c0                	test   %al,%al
  80142f:	74 12                	je     801443 <strcmp+0x39>
  801431:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801435:	0f b6 10             	movzbl (%rax),%edx
  801438:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80143c:	0f b6 00             	movzbl (%rax),%eax
  80143f:	38 c2                	cmp    %al,%dl
  801441:	74 d9                	je     80141c <strcmp+0x12>
  801443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801447:	0f b6 00             	movzbl (%rax),%eax
  80144a:	0f b6 d0             	movzbl %al,%edx
  80144d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801451:	0f b6 00             	movzbl (%rax),%eax
  801454:	0f b6 c0             	movzbl %al,%eax
  801457:	29 c2                	sub    %eax,%edx
  801459:	89 d0                	mov    %edx,%eax
  80145b:	c9                   	leaveq 
  80145c:	c3                   	retq   

000000000080145d <strncmp>:
  80145d:	55                   	push   %rbp
  80145e:	48 89 e5             	mov    %rsp,%rbp
  801461:	48 83 ec 18          	sub    $0x18,%rsp
  801465:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801469:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80146d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801471:	eb 0f                	jmp    801482 <strncmp+0x25>
  801473:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801478:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80147d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801482:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801487:	74 1d                	je     8014a6 <strncmp+0x49>
  801489:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80148d:	0f b6 00             	movzbl (%rax),%eax
  801490:	84 c0                	test   %al,%al
  801492:	74 12                	je     8014a6 <strncmp+0x49>
  801494:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801498:	0f b6 10             	movzbl (%rax),%edx
  80149b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80149f:	0f b6 00             	movzbl (%rax),%eax
  8014a2:	38 c2                	cmp    %al,%dl
  8014a4:	74 cd                	je     801473 <strncmp+0x16>
  8014a6:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8014ab:	75 07                	jne    8014b4 <strncmp+0x57>
  8014ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b2:	eb 18                	jmp    8014cc <strncmp+0x6f>
  8014b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014b8:	0f b6 00             	movzbl (%rax),%eax
  8014bb:	0f b6 d0             	movzbl %al,%edx
  8014be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8014c2:	0f b6 00             	movzbl (%rax),%eax
  8014c5:	0f b6 c0             	movzbl %al,%eax
  8014c8:	29 c2                	sub    %eax,%edx
  8014ca:	89 d0                	mov    %edx,%eax
  8014cc:	c9                   	leaveq 
  8014cd:	c3                   	retq   

00000000008014ce <strchr>:
  8014ce:	55                   	push   %rbp
  8014cf:	48 89 e5             	mov    %rsp,%rbp
  8014d2:	48 83 ec 0c          	sub    $0xc,%rsp
  8014d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014da:	89 f0                	mov    %esi,%eax
  8014dc:	88 45 f4             	mov    %al,-0xc(%rbp)
  8014df:	eb 17                	jmp    8014f8 <strchr+0x2a>
  8014e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014e5:	0f b6 00             	movzbl (%rax),%eax
  8014e8:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8014eb:	75 06                	jne    8014f3 <strchr+0x25>
  8014ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014f1:	eb 15                	jmp    801508 <strchr+0x3a>
  8014f3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8014f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014fc:	0f b6 00             	movzbl (%rax),%eax
  8014ff:	84 c0                	test   %al,%al
  801501:	75 de                	jne    8014e1 <strchr+0x13>
  801503:	b8 00 00 00 00       	mov    $0x0,%eax
  801508:	c9                   	leaveq 
  801509:	c3                   	retq   

000000000080150a <strfind>:
  80150a:	55                   	push   %rbp
  80150b:	48 89 e5             	mov    %rsp,%rbp
  80150e:	48 83 ec 0c          	sub    $0xc,%rsp
  801512:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801516:	89 f0                	mov    %esi,%eax
  801518:	88 45 f4             	mov    %al,-0xc(%rbp)
  80151b:	eb 13                	jmp    801530 <strfind+0x26>
  80151d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801521:	0f b6 00             	movzbl (%rax),%eax
  801524:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801527:	75 02                	jne    80152b <strfind+0x21>
  801529:	eb 10                	jmp    80153b <strfind+0x31>
  80152b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801530:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801534:	0f b6 00             	movzbl (%rax),%eax
  801537:	84 c0                	test   %al,%al
  801539:	75 e2                	jne    80151d <strfind+0x13>
  80153b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80153f:	c9                   	leaveq 
  801540:	c3                   	retq   

0000000000801541 <memset>:
  801541:	55                   	push   %rbp
  801542:	48 89 e5             	mov    %rsp,%rbp
  801545:	48 83 ec 18          	sub    $0x18,%rsp
  801549:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80154d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801550:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801554:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801559:	75 06                	jne    801561 <memset+0x20>
  80155b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80155f:	eb 69                	jmp    8015ca <memset+0x89>
  801561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801565:	83 e0 03             	and    $0x3,%eax
  801568:	48 85 c0             	test   %rax,%rax
  80156b:	75 48                	jne    8015b5 <memset+0x74>
  80156d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801571:	83 e0 03             	and    $0x3,%eax
  801574:	48 85 c0             	test   %rax,%rax
  801577:	75 3c                	jne    8015b5 <memset+0x74>
  801579:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801580:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801583:	c1 e0 18             	shl    $0x18,%eax
  801586:	89 c2                	mov    %eax,%edx
  801588:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80158b:	c1 e0 10             	shl    $0x10,%eax
  80158e:	09 c2                	or     %eax,%edx
  801590:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801593:	c1 e0 08             	shl    $0x8,%eax
  801596:	09 d0                	or     %edx,%eax
  801598:	09 45 f4             	or     %eax,-0xc(%rbp)
  80159b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80159f:	48 c1 e8 02          	shr    $0x2,%rax
  8015a3:	48 89 c1             	mov    %rax,%rcx
  8015a6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8015ad:	48 89 d7             	mov    %rdx,%rdi
  8015b0:	fc                   	cld    
  8015b1:	f3 ab                	rep stos %eax,%es:(%rdi)
  8015b3:	eb 11                	jmp    8015c6 <memset+0x85>
  8015b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8015b9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8015bc:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8015c0:	48 89 d7             	mov    %rdx,%rdi
  8015c3:	fc                   	cld    
  8015c4:	f3 aa                	rep stos %al,%es:(%rdi)
  8015c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015ca:	c9                   	leaveq 
  8015cb:	c3                   	retq   

00000000008015cc <memmove>:
  8015cc:	55                   	push   %rbp
  8015cd:	48 89 e5             	mov    %rsp,%rbp
  8015d0:	48 83 ec 28          	sub    $0x28,%rsp
  8015d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8015d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8015dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8015e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8015e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8015e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8015ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8015f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015f4:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8015f8:	0f 83 88 00 00 00    	jae    801686 <memmove+0xba>
  8015fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801602:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801606:	48 01 d0             	add    %rdx,%rax
  801609:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80160d:	76 77                	jbe    801686 <memmove+0xba>
  80160f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801613:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801617:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80161b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  80161f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801623:	83 e0 03             	and    $0x3,%eax
  801626:	48 85 c0             	test   %rax,%rax
  801629:	75 3b                	jne    801666 <memmove+0x9a>
  80162b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80162f:	83 e0 03             	and    $0x3,%eax
  801632:	48 85 c0             	test   %rax,%rax
  801635:	75 2f                	jne    801666 <memmove+0x9a>
  801637:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80163b:	83 e0 03             	and    $0x3,%eax
  80163e:	48 85 c0             	test   %rax,%rax
  801641:	75 23                	jne    801666 <memmove+0x9a>
  801643:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801647:	48 83 e8 04          	sub    $0x4,%rax
  80164b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80164f:	48 83 ea 04          	sub    $0x4,%rdx
  801653:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801657:	48 c1 e9 02          	shr    $0x2,%rcx
  80165b:	48 89 c7             	mov    %rax,%rdi
  80165e:	48 89 d6             	mov    %rdx,%rsi
  801661:	fd                   	std    
  801662:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801664:	eb 1d                	jmp    801683 <memmove+0xb7>
  801666:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80166a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80166e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801672:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801676:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80167a:	48 89 d7             	mov    %rdx,%rdi
  80167d:	48 89 c1             	mov    %rax,%rcx
  801680:	fd                   	std    
  801681:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801683:	fc                   	cld    
  801684:	eb 57                	jmp    8016dd <memmove+0x111>
  801686:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80168a:	83 e0 03             	and    $0x3,%eax
  80168d:	48 85 c0             	test   %rax,%rax
  801690:	75 36                	jne    8016c8 <memmove+0xfc>
  801692:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801696:	83 e0 03             	and    $0x3,%eax
  801699:	48 85 c0             	test   %rax,%rax
  80169c:	75 2a                	jne    8016c8 <memmove+0xfc>
  80169e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016a2:	83 e0 03             	and    $0x3,%eax
  8016a5:	48 85 c0             	test   %rax,%rax
  8016a8:	75 1e                	jne    8016c8 <memmove+0xfc>
  8016aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016ae:	48 c1 e8 02          	shr    $0x2,%rax
  8016b2:	48 89 c1             	mov    %rax,%rcx
  8016b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016b9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016bd:	48 89 c7             	mov    %rax,%rdi
  8016c0:	48 89 d6             	mov    %rdx,%rsi
  8016c3:	fc                   	cld    
  8016c4:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8016c6:	eb 15                	jmp    8016dd <memmove+0x111>
  8016c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016cc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8016d0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8016d4:	48 89 c7             	mov    %rax,%rdi
  8016d7:	48 89 d6             	mov    %rdx,%rsi
  8016da:	fc                   	cld    
  8016db:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8016dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016e1:	c9                   	leaveq 
  8016e2:	c3                   	retq   

00000000008016e3 <memcpy>:
  8016e3:	55                   	push   %rbp
  8016e4:	48 89 e5             	mov    %rsp,%rbp
  8016e7:	48 83 ec 18          	sub    $0x18,%rsp
  8016eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016ef:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8016f3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8016f7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8016fb:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8016ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801703:	48 89 ce             	mov    %rcx,%rsi
  801706:	48 89 c7             	mov    %rax,%rdi
  801709:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  801710:	00 00 00 
  801713:	ff d0                	callq  *%rax
  801715:	c9                   	leaveq 
  801716:	c3                   	retq   

0000000000801717 <memcmp>:
  801717:	55                   	push   %rbp
  801718:	48 89 e5             	mov    %rsp,%rbp
  80171b:	48 83 ec 28          	sub    $0x28,%rsp
  80171f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801723:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801727:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80172b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80172f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801733:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801737:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80173b:	eb 36                	jmp    801773 <memcmp+0x5c>
  80173d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801741:	0f b6 10             	movzbl (%rax),%edx
  801744:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801748:	0f b6 00             	movzbl (%rax),%eax
  80174b:	38 c2                	cmp    %al,%dl
  80174d:	74 1a                	je     801769 <memcmp+0x52>
  80174f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801753:	0f b6 00             	movzbl (%rax),%eax
  801756:	0f b6 d0             	movzbl %al,%edx
  801759:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80175d:	0f b6 00             	movzbl (%rax),%eax
  801760:	0f b6 c0             	movzbl %al,%eax
  801763:	29 c2                	sub    %eax,%edx
  801765:	89 d0                	mov    %edx,%eax
  801767:	eb 20                	jmp    801789 <memcmp+0x72>
  801769:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80176e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801773:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801777:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80177b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80177f:	48 85 c0             	test   %rax,%rax
  801782:	75 b9                	jne    80173d <memcmp+0x26>
  801784:	b8 00 00 00 00       	mov    $0x0,%eax
  801789:	c9                   	leaveq 
  80178a:	c3                   	retq   

000000000080178b <memfind>:
  80178b:	55                   	push   %rbp
  80178c:	48 89 e5             	mov    %rsp,%rbp
  80178f:	48 83 ec 28          	sub    $0x28,%rsp
  801793:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801797:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80179a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80179e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017a6:	48 01 d0             	add    %rdx,%rax
  8017a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8017ad:	eb 15                	jmp    8017c4 <memfind+0x39>
  8017af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017b3:	0f b6 10             	movzbl (%rax),%edx
  8017b6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8017b9:	38 c2                	cmp    %al,%dl
  8017bb:	75 02                	jne    8017bf <memfind+0x34>
  8017bd:	eb 0f                	jmp    8017ce <memfind+0x43>
  8017bf:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8017c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017c8:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8017cc:	72 e1                	jb     8017af <memfind+0x24>
  8017ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017d2:	c9                   	leaveq 
  8017d3:	c3                   	retq   

00000000008017d4 <strtol>:
  8017d4:	55                   	push   %rbp
  8017d5:	48 89 e5             	mov    %rsp,%rbp
  8017d8:	48 83 ec 34          	sub    $0x34,%rsp
  8017dc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8017e0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8017e4:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8017ee:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8017f5:	00 
  8017f6:	eb 05                	jmp    8017fd <strtol+0x29>
  8017f8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8017fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801801:	0f b6 00             	movzbl (%rax),%eax
  801804:	3c 20                	cmp    $0x20,%al
  801806:	74 f0                	je     8017f8 <strtol+0x24>
  801808:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80180c:	0f b6 00             	movzbl (%rax),%eax
  80180f:	3c 09                	cmp    $0x9,%al
  801811:	74 e5                	je     8017f8 <strtol+0x24>
  801813:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801817:	0f b6 00             	movzbl (%rax),%eax
  80181a:	3c 2b                	cmp    $0x2b,%al
  80181c:	75 07                	jne    801825 <strtol+0x51>
  80181e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801823:	eb 17                	jmp    80183c <strtol+0x68>
  801825:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801829:	0f b6 00             	movzbl (%rax),%eax
  80182c:	3c 2d                	cmp    $0x2d,%al
  80182e:	75 0c                	jne    80183c <strtol+0x68>
  801830:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801835:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80183c:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801840:	74 06                	je     801848 <strtol+0x74>
  801842:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801846:	75 28                	jne    801870 <strtol+0x9c>
  801848:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80184c:	0f b6 00             	movzbl (%rax),%eax
  80184f:	3c 30                	cmp    $0x30,%al
  801851:	75 1d                	jne    801870 <strtol+0x9c>
  801853:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801857:	48 83 c0 01          	add    $0x1,%rax
  80185b:	0f b6 00             	movzbl (%rax),%eax
  80185e:	3c 78                	cmp    $0x78,%al
  801860:	75 0e                	jne    801870 <strtol+0x9c>
  801862:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801867:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  80186e:	eb 2c                	jmp    80189c <strtol+0xc8>
  801870:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801874:	75 19                	jne    80188f <strtol+0xbb>
  801876:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80187a:	0f b6 00             	movzbl (%rax),%eax
  80187d:	3c 30                	cmp    $0x30,%al
  80187f:	75 0e                	jne    80188f <strtol+0xbb>
  801881:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801886:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  80188d:	eb 0d                	jmp    80189c <strtol+0xc8>
  80188f:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801893:	75 07                	jne    80189c <strtol+0xc8>
  801895:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  80189c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018a0:	0f b6 00             	movzbl (%rax),%eax
  8018a3:	3c 2f                	cmp    $0x2f,%al
  8018a5:	7e 1d                	jle    8018c4 <strtol+0xf0>
  8018a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018ab:	0f b6 00             	movzbl (%rax),%eax
  8018ae:	3c 39                	cmp    $0x39,%al
  8018b0:	7f 12                	jg     8018c4 <strtol+0xf0>
  8018b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018b6:	0f b6 00             	movzbl (%rax),%eax
  8018b9:	0f be c0             	movsbl %al,%eax
  8018bc:	83 e8 30             	sub    $0x30,%eax
  8018bf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8018c2:	eb 4e                	jmp    801912 <strtol+0x13e>
  8018c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018c8:	0f b6 00             	movzbl (%rax),%eax
  8018cb:	3c 60                	cmp    $0x60,%al
  8018cd:	7e 1d                	jle    8018ec <strtol+0x118>
  8018cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018d3:	0f b6 00             	movzbl (%rax),%eax
  8018d6:	3c 7a                	cmp    $0x7a,%al
  8018d8:	7f 12                	jg     8018ec <strtol+0x118>
  8018da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018de:	0f b6 00             	movzbl (%rax),%eax
  8018e1:	0f be c0             	movsbl %al,%eax
  8018e4:	83 e8 57             	sub    $0x57,%eax
  8018e7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8018ea:	eb 26                	jmp    801912 <strtol+0x13e>
  8018ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018f0:	0f b6 00             	movzbl (%rax),%eax
  8018f3:	3c 40                	cmp    $0x40,%al
  8018f5:	7e 48                	jle    80193f <strtol+0x16b>
  8018f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018fb:	0f b6 00             	movzbl (%rax),%eax
  8018fe:	3c 5a                	cmp    $0x5a,%al
  801900:	7f 3d                	jg     80193f <strtol+0x16b>
  801902:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801906:	0f b6 00             	movzbl (%rax),%eax
  801909:	0f be c0             	movsbl %al,%eax
  80190c:	83 e8 37             	sub    $0x37,%eax
  80190f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801912:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801915:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801918:	7c 02                	jl     80191c <strtol+0x148>
  80191a:	eb 23                	jmp    80193f <strtol+0x16b>
  80191c:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801921:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801924:	48 98                	cltq   
  801926:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  80192b:	48 89 c2             	mov    %rax,%rdx
  80192e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801931:	48 98                	cltq   
  801933:	48 01 d0             	add    %rdx,%rax
  801936:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80193a:	e9 5d ff ff ff       	jmpq   80189c <strtol+0xc8>
  80193f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801944:	74 0b                	je     801951 <strtol+0x17d>
  801946:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80194a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80194e:	48 89 10             	mov    %rdx,(%rax)
  801951:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801955:	74 09                	je     801960 <strtol+0x18c>
  801957:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80195b:	48 f7 d8             	neg    %rax
  80195e:	eb 04                	jmp    801964 <strtol+0x190>
  801960:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801964:	c9                   	leaveq 
  801965:	c3                   	retq   

0000000000801966 <strstr>:
  801966:	55                   	push   %rbp
  801967:	48 89 e5             	mov    %rsp,%rbp
  80196a:	48 83 ec 30          	sub    $0x30,%rsp
  80196e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801972:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801976:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80197a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80197e:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801982:	0f b6 00             	movzbl (%rax),%eax
  801985:	88 45 ff             	mov    %al,-0x1(%rbp)
  801988:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  80198c:	75 06                	jne    801994 <strstr+0x2e>
  80198e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801992:	eb 6b                	jmp    8019ff <strstr+0x99>
  801994:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801998:	48 89 c7             	mov    %rax,%rdi
  80199b:	48 b8 3c 12 80 00 00 	movabs $0x80123c,%rax
  8019a2:	00 00 00 
  8019a5:	ff d0                	callq  *%rax
  8019a7:	48 98                	cltq   
  8019a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8019ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019b1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8019b5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8019b9:	0f b6 00             	movzbl (%rax),%eax
  8019bc:	88 45 ef             	mov    %al,-0x11(%rbp)
  8019bf:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8019c3:	75 07                	jne    8019cc <strstr+0x66>
  8019c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8019ca:	eb 33                	jmp    8019ff <strstr+0x99>
  8019cc:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8019d0:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8019d3:	75 d8                	jne    8019ad <strstr+0x47>
  8019d5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8019d9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8019dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019e1:	48 89 ce             	mov    %rcx,%rsi
  8019e4:	48 89 c7             	mov    %rax,%rdi
  8019e7:	48 b8 5d 14 80 00 00 	movabs $0x80145d,%rax
  8019ee:	00 00 00 
  8019f1:	ff d0                	callq  *%rax
  8019f3:	85 c0                	test   %eax,%eax
  8019f5:	75 b6                	jne    8019ad <strstr+0x47>
  8019f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019fb:	48 83 e8 01          	sub    $0x1,%rax
  8019ff:	c9                   	leaveq 
  801a00:	c3                   	retq   

0000000000801a01 <syscall>:
  801a01:	55                   	push   %rbp
  801a02:	48 89 e5             	mov    %rsp,%rbp
  801a05:	53                   	push   %rbx
  801a06:	48 83 ec 48          	sub    $0x48,%rsp
  801a0a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801a0d:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801a10:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801a14:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801a18:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801a1c:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801a20:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801a23:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801a27:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801a2b:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801a2f:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801a33:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801a37:	4c 89 c3             	mov    %r8,%rbx
  801a3a:	cd 30                	int    $0x30
  801a3c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801a40:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801a44:	74 3e                	je     801a84 <syscall+0x83>
  801a46:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801a4b:	7e 37                	jle    801a84 <syscall+0x83>
  801a4d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801a51:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801a54:	49 89 d0             	mov    %rdx,%r8
  801a57:	89 c1                	mov    %eax,%ecx
  801a59:	48 ba 48 50 80 00 00 	movabs $0x805048,%rdx
  801a60:	00 00 00 
  801a63:	be 24 00 00 00       	mov    $0x24,%esi
  801a68:	48 bf 65 50 80 00 00 	movabs $0x805065,%rdi
  801a6f:	00 00 00 
  801a72:	b8 00 00 00 00       	mov    $0x0,%eax
  801a77:	49 b9 ba 04 80 00 00 	movabs $0x8004ba,%r9
  801a7e:	00 00 00 
  801a81:	41 ff d1             	callq  *%r9
  801a84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a88:	48 83 c4 48          	add    $0x48,%rsp
  801a8c:	5b                   	pop    %rbx
  801a8d:	5d                   	pop    %rbp
  801a8e:	c3                   	retq   

0000000000801a8f <sys_cputs>:
  801a8f:	55                   	push   %rbp
  801a90:	48 89 e5             	mov    %rsp,%rbp
  801a93:	48 83 ec 20          	sub    $0x20,%rsp
  801a97:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a9b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801aa3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801aa7:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801aae:	00 
  801aaf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ab5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801abb:	48 89 d1             	mov    %rdx,%rcx
  801abe:	48 89 c2             	mov    %rax,%rdx
  801ac1:	be 00 00 00 00       	mov    $0x0,%esi
  801ac6:	bf 00 00 00 00       	mov    $0x0,%edi
  801acb:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801ad2:	00 00 00 
  801ad5:	ff d0                	callq  *%rax
  801ad7:	c9                   	leaveq 
  801ad8:	c3                   	retq   

0000000000801ad9 <sys_cgetc>:
  801ad9:	55                   	push   %rbp
  801ada:	48 89 e5             	mov    %rsp,%rbp
  801add:	48 83 ec 10          	sub    $0x10,%rsp
  801ae1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ae8:	00 
  801ae9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801aef:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801af5:	b9 00 00 00 00       	mov    $0x0,%ecx
  801afa:	ba 00 00 00 00       	mov    $0x0,%edx
  801aff:	be 00 00 00 00       	mov    $0x0,%esi
  801b04:	bf 01 00 00 00       	mov    $0x1,%edi
  801b09:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801b10:	00 00 00 
  801b13:	ff d0                	callq  *%rax
  801b15:	c9                   	leaveq 
  801b16:	c3                   	retq   

0000000000801b17 <sys_env_destroy>:
  801b17:	55                   	push   %rbp
  801b18:	48 89 e5             	mov    %rsp,%rbp
  801b1b:	48 83 ec 10          	sub    $0x10,%rsp
  801b1f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801b22:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b25:	48 98                	cltq   
  801b27:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b2e:	00 
  801b2f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b35:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b3b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b40:	48 89 c2             	mov    %rax,%rdx
  801b43:	be 01 00 00 00       	mov    $0x1,%esi
  801b48:	bf 03 00 00 00       	mov    $0x3,%edi
  801b4d:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801b54:	00 00 00 
  801b57:	ff d0                	callq  *%rax
  801b59:	c9                   	leaveq 
  801b5a:	c3                   	retq   

0000000000801b5b <sys_getenvid>:
  801b5b:	55                   	push   %rbp
  801b5c:	48 89 e5             	mov    %rsp,%rbp
  801b5f:	48 83 ec 10          	sub    $0x10,%rsp
  801b63:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b6a:	00 
  801b6b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b71:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b77:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b7c:	ba 00 00 00 00       	mov    $0x0,%edx
  801b81:	be 00 00 00 00       	mov    $0x0,%esi
  801b86:	bf 02 00 00 00       	mov    $0x2,%edi
  801b8b:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801b92:	00 00 00 
  801b95:	ff d0                	callq  *%rax
  801b97:	c9                   	leaveq 
  801b98:	c3                   	retq   

0000000000801b99 <sys_yield>:
  801b99:	55                   	push   %rbp
  801b9a:	48 89 e5             	mov    %rsp,%rbp
  801b9d:	48 83 ec 10          	sub    $0x10,%rsp
  801ba1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ba8:	00 
  801ba9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801baf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bb5:	b9 00 00 00 00       	mov    $0x0,%ecx
  801bba:	ba 00 00 00 00       	mov    $0x0,%edx
  801bbf:	be 00 00 00 00       	mov    $0x0,%esi
  801bc4:	bf 0b 00 00 00       	mov    $0xb,%edi
  801bc9:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801bd0:	00 00 00 
  801bd3:	ff d0                	callq  *%rax
  801bd5:	c9                   	leaveq 
  801bd6:	c3                   	retq   

0000000000801bd7 <sys_page_alloc>:
  801bd7:	55                   	push   %rbp
  801bd8:	48 89 e5             	mov    %rsp,%rbp
  801bdb:	48 83 ec 20          	sub    $0x20,%rsp
  801bdf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801be2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801be6:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801be9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801bec:	48 63 c8             	movslq %eax,%rcx
  801bef:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801bf3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bf6:	48 98                	cltq   
  801bf8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bff:	00 
  801c00:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c06:	49 89 c8             	mov    %rcx,%r8
  801c09:	48 89 d1             	mov    %rdx,%rcx
  801c0c:	48 89 c2             	mov    %rax,%rdx
  801c0f:	be 01 00 00 00       	mov    $0x1,%esi
  801c14:	bf 04 00 00 00       	mov    $0x4,%edi
  801c19:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801c20:	00 00 00 
  801c23:	ff d0                	callq  *%rax
  801c25:	c9                   	leaveq 
  801c26:	c3                   	retq   

0000000000801c27 <sys_page_map>:
  801c27:	55                   	push   %rbp
  801c28:	48 89 e5             	mov    %rsp,%rbp
  801c2b:	48 83 ec 30          	sub    $0x30,%rsp
  801c2f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c32:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c36:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801c39:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801c3d:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801c41:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801c44:	48 63 c8             	movslq %eax,%rcx
  801c47:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801c4b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c4e:	48 63 f0             	movslq %eax,%rsi
  801c51:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c55:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c58:	48 98                	cltq   
  801c5a:	48 89 0c 24          	mov    %rcx,(%rsp)
  801c5e:	49 89 f9             	mov    %rdi,%r9
  801c61:	49 89 f0             	mov    %rsi,%r8
  801c64:	48 89 d1             	mov    %rdx,%rcx
  801c67:	48 89 c2             	mov    %rax,%rdx
  801c6a:	be 01 00 00 00       	mov    $0x1,%esi
  801c6f:	bf 05 00 00 00       	mov    $0x5,%edi
  801c74:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801c7b:	00 00 00 
  801c7e:	ff d0                	callq  *%rax
  801c80:	c9                   	leaveq 
  801c81:	c3                   	retq   

0000000000801c82 <sys_page_unmap>:
  801c82:	55                   	push   %rbp
  801c83:	48 89 e5             	mov    %rsp,%rbp
  801c86:	48 83 ec 20          	sub    $0x20,%rsp
  801c8a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c8d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c91:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c98:	48 98                	cltq   
  801c9a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ca1:	00 
  801ca2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ca8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cae:	48 89 d1             	mov    %rdx,%rcx
  801cb1:	48 89 c2             	mov    %rax,%rdx
  801cb4:	be 01 00 00 00       	mov    $0x1,%esi
  801cb9:	bf 06 00 00 00       	mov    $0x6,%edi
  801cbe:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801cc5:	00 00 00 
  801cc8:	ff d0                	callq  *%rax
  801cca:	c9                   	leaveq 
  801ccb:	c3                   	retq   

0000000000801ccc <sys_env_set_status>:
  801ccc:	55                   	push   %rbp
  801ccd:	48 89 e5             	mov    %rsp,%rbp
  801cd0:	48 83 ec 10          	sub    $0x10,%rsp
  801cd4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cd7:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801cda:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801cdd:	48 63 d0             	movslq %eax,%rdx
  801ce0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ce3:	48 98                	cltq   
  801ce5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cec:	00 
  801ced:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cf3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cf9:	48 89 d1             	mov    %rdx,%rcx
  801cfc:	48 89 c2             	mov    %rax,%rdx
  801cff:	be 01 00 00 00       	mov    $0x1,%esi
  801d04:	bf 08 00 00 00       	mov    $0x8,%edi
  801d09:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801d10:	00 00 00 
  801d13:	ff d0                	callq  *%rax
  801d15:	c9                   	leaveq 
  801d16:	c3                   	retq   

0000000000801d17 <sys_env_set_trapframe>:
  801d17:	55                   	push   %rbp
  801d18:	48 89 e5             	mov    %rsp,%rbp
  801d1b:	48 83 ec 20          	sub    $0x20,%rsp
  801d1f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d22:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d26:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d2d:	48 98                	cltq   
  801d2f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d36:	00 
  801d37:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d3d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d43:	48 89 d1             	mov    %rdx,%rcx
  801d46:	48 89 c2             	mov    %rax,%rdx
  801d49:	be 01 00 00 00       	mov    $0x1,%esi
  801d4e:	bf 09 00 00 00       	mov    $0x9,%edi
  801d53:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801d5a:	00 00 00 
  801d5d:	ff d0                	callq  *%rax
  801d5f:	c9                   	leaveq 
  801d60:	c3                   	retq   

0000000000801d61 <sys_env_set_pgfault_upcall>:
  801d61:	55                   	push   %rbp
  801d62:	48 89 e5             	mov    %rsp,%rbp
  801d65:	48 83 ec 20          	sub    $0x20,%rsp
  801d69:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d6c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d70:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d74:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d77:	48 98                	cltq   
  801d79:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d80:	00 
  801d81:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d87:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d8d:	48 89 d1             	mov    %rdx,%rcx
  801d90:	48 89 c2             	mov    %rax,%rdx
  801d93:	be 01 00 00 00       	mov    $0x1,%esi
  801d98:	bf 0a 00 00 00       	mov    $0xa,%edi
  801d9d:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801da4:	00 00 00 
  801da7:	ff d0                	callq  *%rax
  801da9:	c9                   	leaveq 
  801daa:	c3                   	retq   

0000000000801dab <sys_ipc_try_send>:
  801dab:	55                   	push   %rbp
  801dac:	48 89 e5             	mov    %rsp,%rbp
  801daf:	48 83 ec 20          	sub    $0x20,%rsp
  801db3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801db6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801dba:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801dbe:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801dc1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801dc4:	48 63 f0             	movslq %eax,%rsi
  801dc7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801dcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dce:	48 98                	cltq   
  801dd0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801dd4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ddb:	00 
  801ddc:	49 89 f1             	mov    %rsi,%r9
  801ddf:	49 89 c8             	mov    %rcx,%r8
  801de2:	48 89 d1             	mov    %rdx,%rcx
  801de5:	48 89 c2             	mov    %rax,%rdx
  801de8:	be 00 00 00 00       	mov    $0x0,%esi
  801ded:	bf 0c 00 00 00       	mov    $0xc,%edi
  801df2:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801df9:	00 00 00 
  801dfc:	ff d0                	callq  *%rax
  801dfe:	c9                   	leaveq 
  801dff:	c3                   	retq   

0000000000801e00 <sys_ipc_recv>:
  801e00:	55                   	push   %rbp
  801e01:	48 89 e5             	mov    %rsp,%rbp
  801e04:	48 83 ec 10          	sub    $0x10,%rsp
  801e08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e10:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e17:	00 
  801e18:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e1e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e24:	b9 00 00 00 00       	mov    $0x0,%ecx
  801e29:	48 89 c2             	mov    %rax,%rdx
  801e2c:	be 01 00 00 00       	mov    $0x1,%esi
  801e31:	bf 0d 00 00 00       	mov    $0xd,%edi
  801e36:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801e3d:	00 00 00 
  801e40:	ff d0                	callq  *%rax
  801e42:	c9                   	leaveq 
  801e43:	c3                   	retq   

0000000000801e44 <sys_time_msec>:
  801e44:	55                   	push   %rbp
  801e45:	48 89 e5             	mov    %rsp,%rbp
  801e48:	48 83 ec 10          	sub    $0x10,%rsp
  801e4c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e53:	00 
  801e54:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e5a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e60:	b9 00 00 00 00       	mov    $0x0,%ecx
  801e65:	ba 00 00 00 00       	mov    $0x0,%edx
  801e6a:	be 00 00 00 00       	mov    $0x0,%esi
  801e6f:	bf 0e 00 00 00       	mov    $0xe,%edi
  801e74:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801e7b:	00 00 00 
  801e7e:	ff d0                	callq  *%rax
  801e80:	c9                   	leaveq 
  801e81:	c3                   	retq   

0000000000801e82 <sys_net_transmit>:
  801e82:	55                   	push   %rbp
  801e83:	48 89 e5             	mov    %rsp,%rbp
  801e86:	48 83 ec 20          	sub    $0x20,%rsp
  801e8a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801e8e:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801e91:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801e94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801e98:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e9f:	00 
  801ea0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ea6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801eac:	48 89 d1             	mov    %rdx,%rcx
  801eaf:	48 89 c2             	mov    %rax,%rdx
  801eb2:	be 00 00 00 00       	mov    $0x0,%esi
  801eb7:	bf 0f 00 00 00       	mov    $0xf,%edi
  801ebc:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801ec3:	00 00 00 
  801ec6:	ff d0                	callq  *%rax
  801ec8:	c9                   	leaveq 
  801ec9:	c3                   	retq   

0000000000801eca <sys_net_receive>:
  801eca:	55                   	push   %rbp
  801ecb:	48 89 e5             	mov    %rsp,%rbp
  801ece:	48 83 ec 20          	sub    $0x20,%rsp
  801ed2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801ed6:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801ed9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801edc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ee0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ee7:	00 
  801ee8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801eee:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ef4:	48 89 d1             	mov    %rdx,%rcx
  801ef7:	48 89 c2             	mov    %rax,%rdx
  801efa:	be 00 00 00 00       	mov    $0x0,%esi
  801eff:	bf 10 00 00 00       	mov    $0x10,%edi
  801f04:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801f0b:	00 00 00 
  801f0e:	ff d0                	callq  *%rax
  801f10:	c9                   	leaveq 
  801f11:	c3                   	retq   

0000000000801f12 <sys_ept_map>:
  801f12:	55                   	push   %rbp
  801f13:	48 89 e5             	mov    %rsp,%rbp
  801f16:	48 83 ec 30          	sub    $0x30,%rsp
  801f1a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f1d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f21:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801f24:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801f28:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801f2c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801f2f:	48 63 c8             	movslq %eax,%rcx
  801f32:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801f36:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f39:	48 63 f0             	movslq %eax,%rsi
  801f3c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f40:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f43:	48 98                	cltq   
  801f45:	48 89 0c 24          	mov    %rcx,(%rsp)
  801f49:	49 89 f9             	mov    %rdi,%r9
  801f4c:	49 89 f0             	mov    %rsi,%r8
  801f4f:	48 89 d1             	mov    %rdx,%rcx
  801f52:	48 89 c2             	mov    %rax,%rdx
  801f55:	be 00 00 00 00       	mov    $0x0,%esi
  801f5a:	bf 11 00 00 00       	mov    $0x11,%edi
  801f5f:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801f66:	00 00 00 
  801f69:	ff d0                	callq  *%rax
  801f6b:	c9                   	leaveq 
  801f6c:	c3                   	retq   

0000000000801f6d <sys_env_mkguest>:
  801f6d:	55                   	push   %rbp
  801f6e:	48 89 e5             	mov    %rsp,%rbp
  801f71:	48 83 ec 20          	sub    $0x20,%rsp
  801f75:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f79:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f7d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f85:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f8c:	00 
  801f8d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f93:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f99:	48 89 d1             	mov    %rdx,%rcx
  801f9c:	48 89 c2             	mov    %rax,%rdx
  801f9f:	be 00 00 00 00       	mov    $0x0,%esi
  801fa4:	bf 12 00 00 00       	mov    $0x12,%edi
  801fa9:	48 b8 01 1a 80 00 00 	movabs $0x801a01,%rax
  801fb0:	00 00 00 
  801fb3:	ff d0                	callq  *%rax
  801fb5:	c9                   	leaveq 
  801fb6:	c3                   	retq   

0000000000801fb7 <pgfault>:
  801fb7:	55                   	push   %rbp
  801fb8:	48 89 e5             	mov    %rsp,%rbp
  801fbb:	48 83 ec 30          	sub    $0x30,%rsp
  801fbf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801fc3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fc7:	48 8b 00             	mov    (%rax),%rax
  801fca:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801fce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fd2:	48 8b 40 08          	mov    0x8(%rax),%rax
  801fd6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fd9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fdc:	83 e0 02             	and    $0x2,%eax
  801fdf:	85 c0                	test   %eax,%eax
  801fe1:	75 40                	jne    802023 <pgfault+0x6c>
  801fe3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fe7:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  801fee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ff2:	49 89 d0             	mov    %rdx,%r8
  801ff5:	48 89 c1             	mov    %rax,%rcx
  801ff8:	48 ba 78 50 80 00 00 	movabs $0x805078,%rdx
  801fff:	00 00 00 
  802002:	be 1f 00 00 00       	mov    $0x1f,%esi
  802007:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  80200e:	00 00 00 
  802011:	b8 00 00 00 00       	mov    $0x0,%eax
  802016:	49 b9 ba 04 80 00 00 	movabs $0x8004ba,%r9
  80201d:	00 00 00 
  802020:	41 ff d1             	callq  *%r9
  802023:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802027:	48 c1 e8 0c          	shr    $0xc,%rax
  80202b:	48 89 c2             	mov    %rax,%rdx
  80202e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802035:	01 00 00 
  802038:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80203c:	25 07 08 00 00       	and    $0x807,%eax
  802041:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  802047:	74 4e                	je     802097 <pgfault+0xe0>
  802049:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80204d:	48 c1 e8 0c          	shr    $0xc,%rax
  802051:	48 89 c2             	mov    %rax,%rdx
  802054:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80205b:	01 00 00 
  80205e:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802062:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802066:	49 89 d0             	mov    %rdx,%r8
  802069:	48 89 c1             	mov    %rax,%rcx
  80206c:	48 ba a0 50 80 00 00 	movabs $0x8050a0,%rdx
  802073:	00 00 00 
  802076:	be 22 00 00 00       	mov    $0x22,%esi
  80207b:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  802082:	00 00 00 
  802085:	b8 00 00 00 00       	mov    $0x0,%eax
  80208a:	49 b9 ba 04 80 00 00 	movabs $0x8004ba,%r9
  802091:	00 00 00 
  802094:	41 ff d1             	callq  *%r9
  802097:	ba 07 00 00 00       	mov    $0x7,%edx
  80209c:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8020a1:	bf 00 00 00 00       	mov    $0x0,%edi
  8020a6:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  8020ad:	00 00 00 
  8020b0:	ff d0                	callq  *%rax
  8020b2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8020b5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8020b9:	79 30                	jns    8020eb <pgfault+0x134>
  8020bb:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020be:	89 c1                	mov    %eax,%ecx
  8020c0:	48 ba cb 50 80 00 00 	movabs $0x8050cb,%rdx
  8020c7:	00 00 00 
  8020ca:	be 30 00 00 00       	mov    $0x30,%esi
  8020cf:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  8020d6:	00 00 00 
  8020d9:	b8 00 00 00 00       	mov    $0x0,%eax
  8020de:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8020e5:	00 00 00 
  8020e8:	41 ff d0             	callq  *%r8
  8020eb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8020ef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8020f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8020f7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8020fd:	ba 00 10 00 00       	mov    $0x1000,%edx
  802102:	48 89 c6             	mov    %rax,%rsi
  802105:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  80210a:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  802111:	00 00 00 
  802114:	ff d0                	callq  *%rax
  802116:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80211a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80211e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802122:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802128:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  80212e:	48 89 c1             	mov    %rax,%rcx
  802131:	ba 00 00 00 00       	mov    $0x0,%edx
  802136:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  80213b:	bf 00 00 00 00       	mov    $0x0,%edi
  802140:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  802147:	00 00 00 
  80214a:	ff d0                	callq  *%rax
  80214c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80214f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802153:	79 30                	jns    802185 <pgfault+0x1ce>
  802155:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802158:	89 c1                	mov    %eax,%ecx
  80215a:	48 ba de 50 80 00 00 	movabs $0x8050de,%rdx
  802161:	00 00 00 
  802164:	be 35 00 00 00       	mov    $0x35,%esi
  802169:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  802170:	00 00 00 
  802173:	b8 00 00 00 00       	mov    $0x0,%eax
  802178:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  80217f:	00 00 00 
  802182:	41 ff d0             	callq  *%r8
  802185:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  80218a:	bf 00 00 00 00       	mov    $0x0,%edi
  80218f:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  802196:	00 00 00 
  802199:	ff d0                	callq  *%rax
  80219b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80219e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8021a2:	79 30                	jns    8021d4 <pgfault+0x21d>
  8021a4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8021a7:	89 c1                	mov    %eax,%ecx
  8021a9:	48 ba ef 50 80 00 00 	movabs $0x8050ef,%rdx
  8021b0:	00 00 00 
  8021b3:	be 39 00 00 00       	mov    $0x39,%esi
  8021b8:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  8021bf:	00 00 00 
  8021c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8021c7:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8021ce:	00 00 00 
  8021d1:	41 ff d0             	callq  *%r8
  8021d4:	c9                   	leaveq 
  8021d5:	c3                   	retq   

00000000008021d6 <duppage>:
  8021d6:	55                   	push   %rbp
  8021d7:	48 89 e5             	mov    %rsp,%rbp
  8021da:	48 83 ec 30          	sub    $0x30,%rsp
  8021de:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8021e1:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8021e4:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8021e7:	c1 e0 0c             	shl    $0xc,%eax
  8021ea:	89 c0                	mov    %eax,%eax
  8021ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8021f0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021f7:	01 00 00 
  8021fa:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8021fd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802201:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802205:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802209:	25 02 08 00 00       	and    $0x802,%eax
  80220e:	48 85 c0             	test   %rax,%rax
  802211:	74 0e                	je     802221 <duppage+0x4b>
  802213:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802217:	25 00 04 00 00       	and    $0x400,%eax
  80221c:	48 85 c0             	test   %rax,%rax
  80221f:	74 70                	je     802291 <duppage+0xbb>
  802221:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802225:	25 07 0e 00 00       	and    $0xe07,%eax
  80222a:	89 c6                	mov    %eax,%esi
  80222c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802230:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802237:	41 89 f0             	mov    %esi,%r8d
  80223a:	48 89 c6             	mov    %rax,%rsi
  80223d:	bf 00 00 00 00       	mov    $0x0,%edi
  802242:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  802249:	00 00 00 
  80224c:	ff d0                	callq  *%rax
  80224e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802251:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802255:	79 30                	jns    802287 <duppage+0xb1>
  802257:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80225a:	89 c1                	mov    %eax,%ecx
  80225c:	48 ba de 50 80 00 00 	movabs $0x8050de,%rdx
  802263:	00 00 00 
  802266:	be 63 00 00 00       	mov    $0x63,%esi
  80226b:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  802272:	00 00 00 
  802275:	b8 00 00 00 00       	mov    $0x0,%eax
  80227a:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  802281:	00 00 00 
  802284:	41 ff d0             	callq  *%r8
  802287:	b8 00 00 00 00       	mov    $0x0,%eax
  80228c:	e9 c4 00 00 00       	jmpq   802355 <duppage+0x17f>
  802291:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802295:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802298:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80229c:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8022a2:	48 89 c6             	mov    %rax,%rsi
  8022a5:	bf 00 00 00 00       	mov    $0x0,%edi
  8022aa:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  8022b1:	00 00 00 
  8022b4:	ff d0                	callq  *%rax
  8022b6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8022b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8022bd:	79 30                	jns    8022ef <duppage+0x119>
  8022bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022c2:	89 c1                	mov    %eax,%ecx
  8022c4:	48 ba de 50 80 00 00 	movabs $0x8050de,%rdx
  8022cb:	00 00 00 
  8022ce:	be 7e 00 00 00       	mov    $0x7e,%esi
  8022d3:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  8022da:	00 00 00 
  8022dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8022e2:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8022e9:	00 00 00 
  8022ec:	41 ff d0             	callq  *%r8
  8022ef:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8022f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8022f7:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8022fd:	48 89 d1             	mov    %rdx,%rcx
  802300:	ba 00 00 00 00       	mov    $0x0,%edx
  802305:	48 89 c6             	mov    %rax,%rsi
  802308:	bf 00 00 00 00       	mov    $0x0,%edi
  80230d:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  802314:	00 00 00 
  802317:	ff d0                	callq  *%rax
  802319:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80231c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802320:	79 30                	jns    802352 <duppage+0x17c>
  802322:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802325:	89 c1                	mov    %eax,%ecx
  802327:	48 ba de 50 80 00 00 	movabs $0x8050de,%rdx
  80232e:	00 00 00 
  802331:	be 80 00 00 00       	mov    $0x80,%esi
  802336:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  80233d:	00 00 00 
  802340:	b8 00 00 00 00       	mov    $0x0,%eax
  802345:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  80234c:	00 00 00 
  80234f:	41 ff d0             	callq  *%r8
  802352:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802355:	c9                   	leaveq 
  802356:	c3                   	retq   

0000000000802357 <fork>:
  802357:	55                   	push   %rbp
  802358:	48 89 e5             	mov    %rsp,%rbp
  80235b:	48 83 ec 20          	sub    $0x20,%rsp
  80235f:	48 bf b7 1f 80 00 00 	movabs $0x801fb7,%rdi
  802366:	00 00 00 
  802369:	48 b8 7f 46 80 00 00 	movabs $0x80467f,%rax
  802370:	00 00 00 
  802373:	ff d0                	callq  *%rax
  802375:	b8 07 00 00 00       	mov    $0x7,%eax
  80237a:	cd 30                	int    $0x30
  80237c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80237f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802382:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802385:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802389:	79 08                	jns    802393 <fork+0x3c>
  80238b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80238e:	e9 09 02 00 00       	jmpq   80259c <fork+0x245>
  802393:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802397:	75 3e                	jne    8023d7 <fork+0x80>
  802399:	48 b8 5b 1b 80 00 00 	movabs $0x801b5b,%rax
  8023a0:	00 00 00 
  8023a3:	ff d0                	callq  *%rax
  8023a5:	25 ff 03 00 00       	and    $0x3ff,%eax
  8023aa:	48 98                	cltq   
  8023ac:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8023b3:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8023ba:	00 00 00 
  8023bd:	48 01 c2             	add    %rax,%rdx
  8023c0:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8023c7:	00 00 00 
  8023ca:	48 89 10             	mov    %rdx,(%rax)
  8023cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8023d2:	e9 c5 01 00 00       	jmpq   80259c <fork+0x245>
  8023d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8023de:	e9 a4 00 00 00       	jmpq   802487 <fork+0x130>
  8023e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023e6:	c1 f8 12             	sar    $0x12,%eax
  8023e9:	89 c2                	mov    %eax,%edx
  8023eb:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  8023f2:	01 00 00 
  8023f5:	48 63 d2             	movslq %edx,%rdx
  8023f8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8023fc:	83 e0 01             	and    $0x1,%eax
  8023ff:	48 85 c0             	test   %rax,%rax
  802402:	74 21                	je     802425 <fork+0xce>
  802404:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802407:	c1 f8 09             	sar    $0x9,%eax
  80240a:	89 c2                	mov    %eax,%edx
  80240c:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802413:	01 00 00 
  802416:	48 63 d2             	movslq %edx,%rdx
  802419:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80241d:	83 e0 01             	and    $0x1,%eax
  802420:	48 85 c0             	test   %rax,%rax
  802423:	75 09                	jne    80242e <fork+0xd7>
  802425:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  80242c:	eb 59                	jmp    802487 <fork+0x130>
  80242e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802431:	05 00 02 00 00       	add    $0x200,%eax
  802436:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802439:	eb 44                	jmp    80247f <fork+0x128>
  80243b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802442:	01 00 00 
  802445:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802448:	48 63 d2             	movslq %edx,%rdx
  80244b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80244f:	83 e0 05             	and    $0x5,%eax
  802452:	48 83 f8 05          	cmp    $0x5,%rax
  802456:	74 02                	je     80245a <fork+0x103>
  802458:	eb 21                	jmp    80247b <fork+0x124>
  80245a:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  802461:	75 02                	jne    802465 <fork+0x10e>
  802463:	eb 16                	jmp    80247b <fork+0x124>
  802465:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802468:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80246b:	89 d6                	mov    %edx,%esi
  80246d:	89 c7                	mov    %eax,%edi
  80246f:	48 b8 d6 21 80 00 00 	movabs $0x8021d6,%rax
  802476:	00 00 00 
  802479:	ff d0                	callq  *%rax
  80247b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80247f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802482:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  802485:	7c b4                	jl     80243b <fork+0xe4>
  802487:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80248a:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  80248f:	0f 86 4e ff ff ff    	jbe    8023e3 <fork+0x8c>
  802495:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802498:	ba 07 00 00 00       	mov    $0x7,%edx
  80249d:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8024a2:	89 c7                	mov    %eax,%edi
  8024a4:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  8024ab:	00 00 00 
  8024ae:	ff d0                	callq  *%rax
  8024b0:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8024b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8024b7:	79 30                	jns    8024e9 <fork+0x192>
  8024b9:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8024bc:	89 c1                	mov    %eax,%ecx
  8024be:	48 ba 08 51 80 00 00 	movabs $0x805108,%rdx
  8024c5:	00 00 00 
  8024c8:	be bc 00 00 00       	mov    $0xbc,%esi
  8024cd:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  8024d4:	00 00 00 
  8024d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8024dc:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8024e3:	00 00 00 
  8024e6:	41 ff d0             	callq  *%r8
  8024e9:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  8024f0:	00 00 00 
  8024f3:	48 8b 00             	mov    (%rax),%rax
  8024f6:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  8024fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802500:	48 89 d6             	mov    %rdx,%rsi
  802503:	89 c7                	mov    %eax,%edi
  802505:	48 b8 61 1d 80 00 00 	movabs $0x801d61,%rax
  80250c:	00 00 00 
  80250f:	ff d0                	callq  *%rax
  802511:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802514:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802518:	79 30                	jns    80254a <fork+0x1f3>
  80251a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80251d:	89 c1                	mov    %eax,%ecx
  80251f:	48 ba 28 51 80 00 00 	movabs $0x805128,%rdx
  802526:	00 00 00 
  802529:	be c0 00 00 00       	mov    $0xc0,%esi
  80252e:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  802535:	00 00 00 
  802538:	b8 00 00 00 00       	mov    $0x0,%eax
  80253d:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  802544:	00 00 00 
  802547:	41 ff d0             	callq  *%r8
  80254a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80254d:	be 02 00 00 00       	mov    $0x2,%esi
  802552:	89 c7                	mov    %eax,%edi
  802554:	48 b8 cc 1c 80 00 00 	movabs $0x801ccc,%rax
  80255b:	00 00 00 
  80255e:	ff d0                	callq  *%rax
  802560:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802563:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802567:	79 30                	jns    802599 <fork+0x242>
  802569:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80256c:	89 c1                	mov    %eax,%ecx
  80256e:	48 ba 47 51 80 00 00 	movabs $0x805147,%rdx
  802575:	00 00 00 
  802578:	be c5 00 00 00       	mov    $0xc5,%esi
  80257d:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  802584:	00 00 00 
  802587:	b8 00 00 00 00       	mov    $0x0,%eax
  80258c:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  802593:	00 00 00 
  802596:	41 ff d0             	callq  *%r8
  802599:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80259c:	c9                   	leaveq 
  80259d:	c3                   	retq   

000000000080259e <sfork>:
  80259e:	55                   	push   %rbp
  80259f:	48 89 e5             	mov    %rsp,%rbp
  8025a2:	48 ba 5e 51 80 00 00 	movabs $0x80515e,%rdx
  8025a9:	00 00 00 
  8025ac:	be d2 00 00 00       	mov    $0xd2,%esi
  8025b1:	48 bf 91 50 80 00 00 	movabs $0x805091,%rdi
  8025b8:	00 00 00 
  8025bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8025c0:	48 b9 ba 04 80 00 00 	movabs $0x8004ba,%rcx
  8025c7:	00 00 00 
  8025ca:	ff d1                	callq  *%rcx

00000000008025cc <fd2num>:
  8025cc:	55                   	push   %rbp
  8025cd:	48 89 e5             	mov    %rsp,%rbp
  8025d0:	48 83 ec 08          	sub    $0x8,%rsp
  8025d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8025d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8025dc:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8025e3:	ff ff ff 
  8025e6:	48 01 d0             	add    %rdx,%rax
  8025e9:	48 c1 e8 0c          	shr    $0xc,%rax
  8025ed:	c9                   	leaveq 
  8025ee:	c3                   	retq   

00000000008025ef <fd2data>:
  8025ef:	55                   	push   %rbp
  8025f0:	48 89 e5             	mov    %rsp,%rbp
  8025f3:	48 83 ec 08          	sub    $0x8,%rsp
  8025f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8025fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025ff:	48 89 c7             	mov    %rax,%rdi
  802602:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  802609:	00 00 00 
  80260c:	ff d0                	callq  *%rax
  80260e:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802614:	48 c1 e0 0c          	shl    $0xc,%rax
  802618:	c9                   	leaveq 
  802619:	c3                   	retq   

000000000080261a <fd_alloc>:
  80261a:	55                   	push   %rbp
  80261b:	48 89 e5             	mov    %rsp,%rbp
  80261e:	48 83 ec 18          	sub    $0x18,%rsp
  802622:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802626:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80262d:	eb 6b                	jmp    80269a <fd_alloc+0x80>
  80262f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802632:	48 98                	cltq   
  802634:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80263a:	48 c1 e0 0c          	shl    $0xc,%rax
  80263e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802642:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802646:	48 c1 e8 15          	shr    $0x15,%rax
  80264a:	48 89 c2             	mov    %rax,%rdx
  80264d:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802654:	01 00 00 
  802657:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80265b:	83 e0 01             	and    $0x1,%eax
  80265e:	48 85 c0             	test   %rax,%rax
  802661:	74 21                	je     802684 <fd_alloc+0x6a>
  802663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802667:	48 c1 e8 0c          	shr    $0xc,%rax
  80266b:	48 89 c2             	mov    %rax,%rdx
  80266e:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802675:	01 00 00 
  802678:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80267c:	83 e0 01             	and    $0x1,%eax
  80267f:	48 85 c0             	test   %rax,%rax
  802682:	75 12                	jne    802696 <fd_alloc+0x7c>
  802684:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802688:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80268c:	48 89 10             	mov    %rdx,(%rax)
  80268f:	b8 00 00 00 00       	mov    $0x0,%eax
  802694:	eb 1a                	jmp    8026b0 <fd_alloc+0x96>
  802696:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80269a:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80269e:	7e 8f                	jle    80262f <fd_alloc+0x15>
  8026a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026a4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8026ab:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8026b0:	c9                   	leaveq 
  8026b1:	c3                   	retq   

00000000008026b2 <fd_lookup>:
  8026b2:	55                   	push   %rbp
  8026b3:	48 89 e5             	mov    %rsp,%rbp
  8026b6:	48 83 ec 20          	sub    $0x20,%rsp
  8026ba:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8026bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8026c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8026c5:	78 06                	js     8026cd <fd_lookup+0x1b>
  8026c7:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8026cb:	7e 07                	jle    8026d4 <fd_lookup+0x22>
  8026cd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8026d2:	eb 6c                	jmp    802740 <fd_lookup+0x8e>
  8026d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8026d7:	48 98                	cltq   
  8026d9:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8026df:	48 c1 e0 0c          	shl    $0xc,%rax
  8026e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8026e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8026eb:	48 c1 e8 15          	shr    $0x15,%rax
  8026ef:	48 89 c2             	mov    %rax,%rdx
  8026f2:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8026f9:	01 00 00 
  8026fc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802700:	83 e0 01             	and    $0x1,%eax
  802703:	48 85 c0             	test   %rax,%rax
  802706:	74 21                	je     802729 <fd_lookup+0x77>
  802708:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80270c:	48 c1 e8 0c          	shr    $0xc,%rax
  802710:	48 89 c2             	mov    %rax,%rdx
  802713:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80271a:	01 00 00 
  80271d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802721:	83 e0 01             	and    $0x1,%eax
  802724:	48 85 c0             	test   %rax,%rax
  802727:	75 07                	jne    802730 <fd_lookup+0x7e>
  802729:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80272e:	eb 10                	jmp    802740 <fd_lookup+0x8e>
  802730:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802734:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802738:	48 89 10             	mov    %rdx,(%rax)
  80273b:	b8 00 00 00 00       	mov    $0x0,%eax
  802740:	c9                   	leaveq 
  802741:	c3                   	retq   

0000000000802742 <fd_close>:
  802742:	55                   	push   %rbp
  802743:	48 89 e5             	mov    %rsp,%rbp
  802746:	48 83 ec 30          	sub    $0x30,%rsp
  80274a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80274e:	89 f0                	mov    %esi,%eax
  802750:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802753:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802757:	48 89 c7             	mov    %rax,%rdi
  80275a:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  802761:	00 00 00 
  802764:	ff d0                	callq  *%rax
  802766:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80276a:	48 89 d6             	mov    %rdx,%rsi
  80276d:	89 c7                	mov    %eax,%edi
  80276f:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802776:	00 00 00 
  802779:	ff d0                	callq  *%rax
  80277b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80277e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802782:	78 0a                	js     80278e <fd_close+0x4c>
  802784:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802788:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  80278c:	74 12                	je     8027a0 <fd_close+0x5e>
  80278e:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802792:	74 05                	je     802799 <fd_close+0x57>
  802794:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802797:	eb 05                	jmp    80279e <fd_close+0x5c>
  802799:	b8 00 00 00 00       	mov    $0x0,%eax
  80279e:	eb 69                	jmp    802809 <fd_close+0xc7>
  8027a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027a4:	8b 00                	mov    (%rax),%eax
  8027a6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8027aa:	48 89 d6             	mov    %rdx,%rsi
  8027ad:	89 c7                	mov    %eax,%edi
  8027af:	48 b8 0b 28 80 00 00 	movabs $0x80280b,%rax
  8027b6:	00 00 00 
  8027b9:	ff d0                	callq  *%rax
  8027bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027c2:	78 2a                	js     8027ee <fd_close+0xac>
  8027c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027c8:	48 8b 40 20          	mov    0x20(%rax),%rax
  8027cc:	48 85 c0             	test   %rax,%rax
  8027cf:	74 16                	je     8027e7 <fd_close+0xa5>
  8027d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027d5:	48 8b 40 20          	mov    0x20(%rax),%rax
  8027d9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8027dd:	48 89 d7             	mov    %rdx,%rdi
  8027e0:	ff d0                	callq  *%rax
  8027e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027e5:	eb 07                	jmp    8027ee <fd_close+0xac>
  8027e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8027ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027f2:	48 89 c6             	mov    %rax,%rsi
  8027f5:	bf 00 00 00 00       	mov    $0x0,%edi
  8027fa:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  802801:	00 00 00 
  802804:	ff d0                	callq  *%rax
  802806:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802809:	c9                   	leaveq 
  80280a:	c3                   	retq   

000000000080280b <dev_lookup>:
  80280b:	55                   	push   %rbp
  80280c:	48 89 e5             	mov    %rsp,%rbp
  80280f:	48 83 ec 20          	sub    $0x20,%rsp
  802813:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802816:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80281a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802821:	eb 41                	jmp    802864 <dev_lookup+0x59>
  802823:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80282a:	00 00 00 
  80282d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802830:	48 63 d2             	movslq %edx,%rdx
  802833:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802837:	8b 00                	mov    (%rax),%eax
  802839:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  80283c:	75 22                	jne    802860 <dev_lookup+0x55>
  80283e:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802845:	00 00 00 
  802848:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80284b:	48 63 d2             	movslq %edx,%rdx
  80284e:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802852:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802856:	48 89 10             	mov    %rdx,(%rax)
  802859:	b8 00 00 00 00       	mov    $0x0,%eax
  80285e:	eb 60                	jmp    8028c0 <dev_lookup+0xb5>
  802860:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802864:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  80286b:	00 00 00 
  80286e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802871:	48 63 d2             	movslq %edx,%rdx
  802874:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802878:	48 85 c0             	test   %rax,%rax
  80287b:	75 a6                	jne    802823 <dev_lookup+0x18>
  80287d:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802884:	00 00 00 
  802887:	48 8b 00             	mov    (%rax),%rax
  80288a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802890:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802893:	89 c6                	mov    %eax,%esi
  802895:	48 bf 78 51 80 00 00 	movabs $0x805178,%rdi
  80289c:	00 00 00 
  80289f:	b8 00 00 00 00       	mov    $0x0,%eax
  8028a4:	48 b9 f3 06 80 00 00 	movabs $0x8006f3,%rcx
  8028ab:	00 00 00 
  8028ae:	ff d1                	callq  *%rcx
  8028b0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028b4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8028bb:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8028c0:	c9                   	leaveq 
  8028c1:	c3                   	retq   

00000000008028c2 <close>:
  8028c2:	55                   	push   %rbp
  8028c3:	48 89 e5             	mov    %rsp,%rbp
  8028c6:	48 83 ec 20          	sub    $0x20,%rsp
  8028ca:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8028cd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8028d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028d4:	48 89 d6             	mov    %rdx,%rsi
  8028d7:	89 c7                	mov    %eax,%edi
  8028d9:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  8028e0:	00 00 00 
  8028e3:	ff d0                	callq  *%rax
  8028e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8028e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8028ec:	79 05                	jns    8028f3 <close+0x31>
  8028ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028f1:	eb 18                	jmp    80290b <close+0x49>
  8028f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028f7:	be 01 00 00 00       	mov    $0x1,%esi
  8028fc:	48 89 c7             	mov    %rax,%rdi
  8028ff:	48 b8 42 27 80 00 00 	movabs $0x802742,%rax
  802906:	00 00 00 
  802909:	ff d0                	callq  *%rax
  80290b:	c9                   	leaveq 
  80290c:	c3                   	retq   

000000000080290d <close_all>:
  80290d:	55                   	push   %rbp
  80290e:	48 89 e5             	mov    %rsp,%rbp
  802911:	48 83 ec 10          	sub    $0x10,%rsp
  802915:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80291c:	eb 15                	jmp    802933 <close_all+0x26>
  80291e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802921:	89 c7                	mov    %eax,%edi
  802923:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  80292a:	00 00 00 
  80292d:	ff d0                	callq  *%rax
  80292f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802933:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802937:	7e e5                	jle    80291e <close_all+0x11>
  802939:	c9                   	leaveq 
  80293a:	c3                   	retq   

000000000080293b <dup>:
  80293b:	55                   	push   %rbp
  80293c:	48 89 e5             	mov    %rsp,%rbp
  80293f:	48 83 ec 40          	sub    $0x40,%rsp
  802943:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802946:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802949:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  80294d:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802950:	48 89 d6             	mov    %rdx,%rsi
  802953:	89 c7                	mov    %eax,%edi
  802955:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  80295c:	00 00 00 
  80295f:	ff d0                	callq  *%rax
  802961:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802964:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802968:	79 08                	jns    802972 <dup+0x37>
  80296a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80296d:	e9 70 01 00 00       	jmpq   802ae2 <dup+0x1a7>
  802972:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802975:	89 c7                	mov    %eax,%edi
  802977:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  80297e:	00 00 00 
  802981:	ff d0                	callq  *%rax
  802983:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802986:	48 98                	cltq   
  802988:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  80298e:	48 c1 e0 0c          	shl    $0xc,%rax
  802992:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802996:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80299a:	48 89 c7             	mov    %rax,%rdi
  80299d:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  8029a4:	00 00 00 
  8029a7:	ff d0                	callq  *%rax
  8029a9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8029ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8029b1:	48 89 c7             	mov    %rax,%rdi
  8029b4:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  8029bb:	00 00 00 
  8029be:	ff d0                	callq  *%rax
  8029c0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8029c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029c8:	48 c1 e8 15          	shr    $0x15,%rax
  8029cc:	48 89 c2             	mov    %rax,%rdx
  8029cf:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8029d6:	01 00 00 
  8029d9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029dd:	83 e0 01             	and    $0x1,%eax
  8029e0:	48 85 c0             	test   %rax,%rax
  8029e3:	74 73                	je     802a58 <dup+0x11d>
  8029e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8029e9:	48 c1 e8 0c          	shr    $0xc,%rax
  8029ed:	48 89 c2             	mov    %rax,%rdx
  8029f0:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8029f7:	01 00 00 
  8029fa:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8029fe:	83 e0 01             	and    $0x1,%eax
  802a01:	48 85 c0             	test   %rax,%rax
  802a04:	74 52                	je     802a58 <dup+0x11d>
  802a06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a0a:	48 c1 e8 0c          	shr    $0xc,%rax
  802a0e:	48 89 c2             	mov    %rax,%rdx
  802a11:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a18:	01 00 00 
  802a1b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a1f:	25 07 0e 00 00       	and    $0xe07,%eax
  802a24:	89 c1                	mov    %eax,%ecx
  802a26:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802a2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a2e:	41 89 c8             	mov    %ecx,%r8d
  802a31:	48 89 d1             	mov    %rdx,%rcx
  802a34:	ba 00 00 00 00       	mov    $0x0,%edx
  802a39:	48 89 c6             	mov    %rax,%rsi
  802a3c:	bf 00 00 00 00       	mov    $0x0,%edi
  802a41:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  802a48:	00 00 00 
  802a4b:	ff d0                	callq  *%rax
  802a4d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a50:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a54:	79 02                	jns    802a58 <dup+0x11d>
  802a56:	eb 57                	jmp    802aaf <dup+0x174>
  802a58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802a5c:	48 c1 e8 0c          	shr    $0xc,%rax
  802a60:	48 89 c2             	mov    %rax,%rdx
  802a63:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a6a:	01 00 00 
  802a6d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a71:	25 07 0e 00 00       	and    $0xe07,%eax
  802a76:	89 c1                	mov    %eax,%ecx
  802a78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802a7c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a80:	41 89 c8             	mov    %ecx,%r8d
  802a83:	48 89 d1             	mov    %rdx,%rcx
  802a86:	ba 00 00 00 00       	mov    $0x0,%edx
  802a8b:	48 89 c6             	mov    %rax,%rsi
  802a8e:	bf 00 00 00 00       	mov    $0x0,%edi
  802a93:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  802a9a:	00 00 00 
  802a9d:	ff d0                	callq  *%rax
  802a9f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802aa2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802aa6:	79 02                	jns    802aaa <dup+0x16f>
  802aa8:	eb 05                	jmp    802aaf <dup+0x174>
  802aaa:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802aad:	eb 33                	jmp    802ae2 <dup+0x1a7>
  802aaf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ab3:	48 89 c6             	mov    %rax,%rsi
  802ab6:	bf 00 00 00 00       	mov    $0x0,%edi
  802abb:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  802ac2:	00 00 00 
  802ac5:	ff d0                	callq  *%rax
  802ac7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802acb:	48 89 c6             	mov    %rax,%rsi
  802ace:	bf 00 00 00 00       	mov    $0x0,%edi
  802ad3:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  802ada:	00 00 00 
  802add:	ff d0                	callq  *%rax
  802adf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ae2:	c9                   	leaveq 
  802ae3:	c3                   	retq   

0000000000802ae4 <read>:
  802ae4:	55                   	push   %rbp
  802ae5:	48 89 e5             	mov    %rsp,%rbp
  802ae8:	48 83 ec 40          	sub    $0x40,%rsp
  802aec:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802aef:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802af3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802af7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802afb:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802afe:	48 89 d6             	mov    %rdx,%rsi
  802b01:	89 c7                	mov    %eax,%edi
  802b03:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802b0a:	00 00 00 
  802b0d:	ff d0                	callq  *%rax
  802b0f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b12:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b16:	78 24                	js     802b3c <read+0x58>
  802b18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b1c:	8b 00                	mov    (%rax),%eax
  802b1e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b22:	48 89 d6             	mov    %rdx,%rsi
  802b25:	89 c7                	mov    %eax,%edi
  802b27:	48 b8 0b 28 80 00 00 	movabs $0x80280b,%rax
  802b2e:	00 00 00 
  802b31:	ff d0                	callq  *%rax
  802b33:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b36:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b3a:	79 05                	jns    802b41 <read+0x5d>
  802b3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b3f:	eb 76                	jmp    802bb7 <read+0xd3>
  802b41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b45:	8b 40 08             	mov    0x8(%rax),%eax
  802b48:	83 e0 03             	and    $0x3,%eax
  802b4b:	83 f8 01             	cmp    $0x1,%eax
  802b4e:	75 3a                	jne    802b8a <read+0xa6>
  802b50:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802b57:	00 00 00 
  802b5a:	48 8b 00             	mov    (%rax),%rax
  802b5d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802b63:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802b66:	89 c6                	mov    %eax,%esi
  802b68:	48 bf 97 51 80 00 00 	movabs $0x805197,%rdi
  802b6f:	00 00 00 
  802b72:	b8 00 00 00 00       	mov    $0x0,%eax
  802b77:	48 b9 f3 06 80 00 00 	movabs $0x8006f3,%rcx
  802b7e:	00 00 00 
  802b81:	ff d1                	callq  *%rcx
  802b83:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802b88:	eb 2d                	jmp    802bb7 <read+0xd3>
  802b8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b8e:	48 8b 40 10          	mov    0x10(%rax),%rax
  802b92:	48 85 c0             	test   %rax,%rax
  802b95:	75 07                	jne    802b9e <read+0xba>
  802b97:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802b9c:	eb 19                	jmp    802bb7 <read+0xd3>
  802b9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ba2:	48 8b 40 10          	mov    0x10(%rax),%rax
  802ba6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802baa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802bae:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802bb2:	48 89 cf             	mov    %rcx,%rdi
  802bb5:	ff d0                	callq  *%rax
  802bb7:	c9                   	leaveq 
  802bb8:	c3                   	retq   

0000000000802bb9 <readn>:
  802bb9:	55                   	push   %rbp
  802bba:	48 89 e5             	mov    %rsp,%rbp
  802bbd:	48 83 ec 30          	sub    $0x30,%rsp
  802bc1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802bc4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802bc8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802bcc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802bd3:	eb 49                	jmp    802c1e <readn+0x65>
  802bd5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802bd8:	48 98                	cltq   
  802bda:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802bde:	48 29 c2             	sub    %rax,%rdx
  802be1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802be4:	48 63 c8             	movslq %eax,%rcx
  802be7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802beb:	48 01 c1             	add    %rax,%rcx
  802bee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802bf1:	48 89 ce             	mov    %rcx,%rsi
  802bf4:	89 c7                	mov    %eax,%edi
  802bf6:	48 b8 e4 2a 80 00 00 	movabs $0x802ae4,%rax
  802bfd:	00 00 00 
  802c00:	ff d0                	callq  *%rax
  802c02:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802c05:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802c09:	79 05                	jns    802c10 <readn+0x57>
  802c0b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c0e:	eb 1c                	jmp    802c2c <readn+0x73>
  802c10:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802c14:	75 02                	jne    802c18 <readn+0x5f>
  802c16:	eb 11                	jmp    802c29 <readn+0x70>
  802c18:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c1b:	01 45 fc             	add    %eax,-0x4(%rbp)
  802c1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c21:	48 98                	cltq   
  802c23:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802c27:	72 ac                	jb     802bd5 <readn+0x1c>
  802c29:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c2c:	c9                   	leaveq 
  802c2d:	c3                   	retq   

0000000000802c2e <write>:
  802c2e:	55                   	push   %rbp
  802c2f:	48 89 e5             	mov    %rsp,%rbp
  802c32:	48 83 ec 40          	sub    $0x40,%rsp
  802c36:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802c39:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802c3d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802c41:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802c45:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802c48:	48 89 d6             	mov    %rdx,%rsi
  802c4b:	89 c7                	mov    %eax,%edi
  802c4d:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802c54:	00 00 00 
  802c57:	ff d0                	callq  *%rax
  802c59:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c5c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c60:	78 24                	js     802c86 <write+0x58>
  802c62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c66:	8b 00                	mov    (%rax),%eax
  802c68:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c6c:	48 89 d6             	mov    %rdx,%rsi
  802c6f:	89 c7                	mov    %eax,%edi
  802c71:	48 b8 0b 28 80 00 00 	movabs $0x80280b,%rax
  802c78:	00 00 00 
  802c7b:	ff d0                	callq  *%rax
  802c7d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c80:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c84:	79 05                	jns    802c8b <write+0x5d>
  802c86:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c89:	eb 75                	jmp    802d00 <write+0xd2>
  802c8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c8f:	8b 40 08             	mov    0x8(%rax),%eax
  802c92:	83 e0 03             	and    $0x3,%eax
  802c95:	85 c0                	test   %eax,%eax
  802c97:	75 3a                	jne    802cd3 <write+0xa5>
  802c99:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802ca0:	00 00 00 
  802ca3:	48 8b 00             	mov    (%rax),%rax
  802ca6:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802cac:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802caf:	89 c6                	mov    %eax,%esi
  802cb1:	48 bf b3 51 80 00 00 	movabs $0x8051b3,%rdi
  802cb8:	00 00 00 
  802cbb:	b8 00 00 00 00       	mov    $0x0,%eax
  802cc0:	48 b9 f3 06 80 00 00 	movabs $0x8006f3,%rcx
  802cc7:	00 00 00 
  802cca:	ff d1                	callq  *%rcx
  802ccc:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802cd1:	eb 2d                	jmp    802d00 <write+0xd2>
  802cd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cd7:	48 8b 40 18          	mov    0x18(%rax),%rax
  802cdb:	48 85 c0             	test   %rax,%rax
  802cde:	75 07                	jne    802ce7 <write+0xb9>
  802ce0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802ce5:	eb 19                	jmp    802d00 <write+0xd2>
  802ce7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ceb:	48 8b 40 18          	mov    0x18(%rax),%rax
  802cef:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802cf3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802cf7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802cfb:	48 89 cf             	mov    %rcx,%rdi
  802cfe:	ff d0                	callq  *%rax
  802d00:	c9                   	leaveq 
  802d01:	c3                   	retq   

0000000000802d02 <seek>:
  802d02:	55                   	push   %rbp
  802d03:	48 89 e5             	mov    %rsp,%rbp
  802d06:	48 83 ec 18          	sub    $0x18,%rsp
  802d0a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d0d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802d10:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d14:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d17:	48 89 d6             	mov    %rdx,%rsi
  802d1a:	89 c7                	mov    %eax,%edi
  802d1c:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802d23:	00 00 00 
  802d26:	ff d0                	callq  *%rax
  802d28:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d2b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d2f:	79 05                	jns    802d36 <seek+0x34>
  802d31:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d34:	eb 0f                	jmp    802d45 <seek+0x43>
  802d36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d3a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802d3d:	89 50 04             	mov    %edx,0x4(%rax)
  802d40:	b8 00 00 00 00       	mov    $0x0,%eax
  802d45:	c9                   	leaveq 
  802d46:	c3                   	retq   

0000000000802d47 <ftruncate>:
  802d47:	55                   	push   %rbp
  802d48:	48 89 e5             	mov    %rsp,%rbp
  802d4b:	48 83 ec 30          	sub    $0x30,%rsp
  802d4f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802d52:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802d55:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802d59:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802d5c:	48 89 d6             	mov    %rdx,%rsi
  802d5f:	89 c7                	mov    %eax,%edi
  802d61:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802d68:	00 00 00 
  802d6b:	ff d0                	callq  *%rax
  802d6d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d70:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d74:	78 24                	js     802d9a <ftruncate+0x53>
  802d76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d7a:	8b 00                	mov    (%rax),%eax
  802d7c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802d80:	48 89 d6             	mov    %rdx,%rsi
  802d83:	89 c7                	mov    %eax,%edi
  802d85:	48 b8 0b 28 80 00 00 	movabs $0x80280b,%rax
  802d8c:	00 00 00 
  802d8f:	ff d0                	callq  *%rax
  802d91:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d94:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d98:	79 05                	jns    802d9f <ftruncate+0x58>
  802d9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d9d:	eb 72                	jmp    802e11 <ftruncate+0xca>
  802d9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802da3:	8b 40 08             	mov    0x8(%rax),%eax
  802da6:	83 e0 03             	and    $0x3,%eax
  802da9:	85 c0                	test   %eax,%eax
  802dab:	75 3a                	jne    802de7 <ftruncate+0xa0>
  802dad:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  802db4:	00 00 00 
  802db7:	48 8b 00             	mov    (%rax),%rax
  802dba:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802dc0:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802dc3:	89 c6                	mov    %eax,%esi
  802dc5:	48 bf d0 51 80 00 00 	movabs $0x8051d0,%rdi
  802dcc:	00 00 00 
  802dcf:	b8 00 00 00 00       	mov    $0x0,%eax
  802dd4:	48 b9 f3 06 80 00 00 	movabs $0x8006f3,%rcx
  802ddb:	00 00 00 
  802dde:	ff d1                	callq  *%rcx
  802de0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802de5:	eb 2a                	jmp    802e11 <ftruncate+0xca>
  802de7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802deb:	48 8b 40 30          	mov    0x30(%rax),%rax
  802def:	48 85 c0             	test   %rax,%rax
  802df2:	75 07                	jne    802dfb <ftruncate+0xb4>
  802df4:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802df9:	eb 16                	jmp    802e11 <ftruncate+0xca>
  802dfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802dff:	48 8b 40 30          	mov    0x30(%rax),%rax
  802e03:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802e07:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  802e0a:	89 ce                	mov    %ecx,%esi
  802e0c:	48 89 d7             	mov    %rdx,%rdi
  802e0f:	ff d0                	callq  *%rax
  802e11:	c9                   	leaveq 
  802e12:	c3                   	retq   

0000000000802e13 <fstat>:
  802e13:	55                   	push   %rbp
  802e14:	48 89 e5             	mov    %rsp,%rbp
  802e17:	48 83 ec 30          	sub    $0x30,%rsp
  802e1b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802e1e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802e22:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802e26:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802e29:	48 89 d6             	mov    %rdx,%rsi
  802e2c:	89 c7                	mov    %eax,%edi
  802e2e:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  802e35:	00 00 00 
  802e38:	ff d0                	callq  *%rax
  802e3a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e3d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e41:	78 24                	js     802e67 <fstat+0x54>
  802e43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802e47:	8b 00                	mov    (%rax),%eax
  802e49:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802e4d:	48 89 d6             	mov    %rdx,%rsi
  802e50:	89 c7                	mov    %eax,%edi
  802e52:	48 b8 0b 28 80 00 00 	movabs $0x80280b,%rax
  802e59:	00 00 00 
  802e5c:	ff d0                	callq  *%rax
  802e5e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e61:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e65:	79 05                	jns    802e6c <fstat+0x59>
  802e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e6a:	eb 5e                	jmp    802eca <fstat+0xb7>
  802e6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e70:	48 8b 40 28          	mov    0x28(%rax),%rax
  802e74:	48 85 c0             	test   %rax,%rax
  802e77:	75 07                	jne    802e80 <fstat+0x6d>
  802e79:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802e7e:	eb 4a                	jmp    802eca <fstat+0xb7>
  802e80:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e84:	c6 00 00             	movb   $0x0,(%rax)
  802e87:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e8b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802e92:	00 00 00 
  802e95:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802e99:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802ea0:	00 00 00 
  802ea3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802ea7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802eab:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802eb2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802eb6:	48 8b 40 28          	mov    0x28(%rax),%rax
  802eba:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802ebe:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802ec2:	48 89 ce             	mov    %rcx,%rsi
  802ec5:	48 89 d7             	mov    %rdx,%rdi
  802ec8:	ff d0                	callq  *%rax
  802eca:	c9                   	leaveq 
  802ecb:	c3                   	retq   

0000000000802ecc <stat>:
  802ecc:	55                   	push   %rbp
  802ecd:	48 89 e5             	mov    %rsp,%rbp
  802ed0:	48 83 ec 20          	sub    $0x20,%rsp
  802ed4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ed8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802edc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ee0:	be 00 00 00 00       	mov    $0x0,%esi
  802ee5:	48 89 c7             	mov    %rax,%rdi
  802ee8:	48 b8 ba 2f 80 00 00 	movabs $0x802fba,%rax
  802eef:	00 00 00 
  802ef2:	ff d0                	callq  *%rax
  802ef4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ef7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802efb:	79 05                	jns    802f02 <stat+0x36>
  802efd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f00:	eb 2f                	jmp    802f31 <stat+0x65>
  802f02:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802f06:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f09:	48 89 d6             	mov    %rdx,%rsi
  802f0c:	89 c7                	mov    %eax,%edi
  802f0e:	48 b8 13 2e 80 00 00 	movabs $0x802e13,%rax
  802f15:	00 00 00 
  802f18:	ff d0                	callq  *%rax
  802f1a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802f1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f20:	89 c7                	mov    %eax,%edi
  802f22:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  802f29:	00 00 00 
  802f2c:	ff d0                	callq  *%rax
  802f2e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f31:	c9                   	leaveq 
  802f32:	c3                   	retq   

0000000000802f33 <fsipc>:
  802f33:	55                   	push   %rbp
  802f34:	48 89 e5             	mov    %rsp,%rbp
  802f37:	48 83 ec 10          	sub    $0x10,%rsp
  802f3b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802f3e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802f42:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f49:	00 00 00 
  802f4c:	8b 00                	mov    (%rax),%eax
  802f4e:	85 c0                	test   %eax,%eax
  802f50:	75 1d                	jne    802f6f <fsipc+0x3c>
  802f52:	bf 01 00 00 00       	mov    $0x1,%edi
  802f57:	48 b8 73 49 80 00 00 	movabs $0x804973,%rax
  802f5e:	00 00 00 
  802f61:	ff d0                	callq  *%rax
  802f63:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  802f6a:	00 00 00 
  802f6d:	89 02                	mov    %eax,(%rdx)
  802f6f:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802f76:	00 00 00 
  802f79:	8b 00                	mov    (%rax),%eax
  802f7b:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802f7e:	b9 07 00 00 00       	mov    $0x7,%ecx
  802f83:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  802f8a:	00 00 00 
  802f8d:	89 c7                	mov    %eax,%edi
  802f8f:	48 b8 68 48 80 00 00 	movabs $0x804868,%rax
  802f96:	00 00 00 
  802f99:	ff d0                	callq  *%rax
  802f9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f9f:	ba 00 00 00 00       	mov    $0x0,%edx
  802fa4:	48 89 c6             	mov    %rax,%rsi
  802fa7:	bf 00 00 00 00       	mov    $0x0,%edi
  802fac:	48 b8 a7 47 80 00 00 	movabs $0x8047a7,%rax
  802fb3:	00 00 00 
  802fb6:	ff d0                	callq  *%rax
  802fb8:	c9                   	leaveq 
  802fb9:	c3                   	retq   

0000000000802fba <open>:
  802fba:	55                   	push   %rbp
  802fbb:	48 89 e5             	mov    %rsp,%rbp
  802fbe:	48 83 ec 20          	sub    $0x20,%rsp
  802fc2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802fc6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802fc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fcd:	48 89 c7             	mov    %rax,%rdi
  802fd0:	48 b8 3c 12 80 00 00 	movabs $0x80123c,%rax
  802fd7:	00 00 00 
  802fda:	ff d0                	callq  *%rax
  802fdc:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802fe1:	7e 0a                	jle    802fed <open+0x33>
  802fe3:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802fe8:	e9 a5 00 00 00       	jmpq   803092 <open+0xd8>
  802fed:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802ff1:	48 89 c7             	mov    %rax,%rdi
  802ff4:	48 b8 1a 26 80 00 00 	movabs $0x80261a,%rax
  802ffb:	00 00 00 
  802ffe:	ff d0                	callq  *%rax
  803000:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803003:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803007:	79 08                	jns    803011 <open+0x57>
  803009:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80300c:	e9 81 00 00 00       	jmpq   803092 <open+0xd8>
  803011:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803015:	48 89 c6             	mov    %rax,%rsi
  803018:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  80301f:	00 00 00 
  803022:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  803029:	00 00 00 
  80302c:	ff d0                	callq  *%rax
  80302e:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803035:	00 00 00 
  803038:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80303b:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  803041:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803045:	48 89 c6             	mov    %rax,%rsi
  803048:	bf 01 00 00 00       	mov    $0x1,%edi
  80304d:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  803054:	00 00 00 
  803057:	ff d0                	callq  *%rax
  803059:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80305c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803060:	79 1d                	jns    80307f <open+0xc5>
  803062:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803066:	be 00 00 00 00       	mov    $0x0,%esi
  80306b:	48 89 c7             	mov    %rax,%rdi
  80306e:	48 b8 42 27 80 00 00 	movabs $0x802742,%rax
  803075:	00 00 00 
  803078:	ff d0                	callq  *%rax
  80307a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80307d:	eb 13                	jmp    803092 <open+0xd8>
  80307f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803083:	48 89 c7             	mov    %rax,%rdi
  803086:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  80308d:	00 00 00 
  803090:	ff d0                	callq  *%rax
  803092:	c9                   	leaveq 
  803093:	c3                   	retq   

0000000000803094 <devfile_flush>:
  803094:	55                   	push   %rbp
  803095:	48 89 e5             	mov    %rsp,%rbp
  803098:	48 83 ec 10          	sub    $0x10,%rsp
  80309c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8030a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8030a4:	8b 50 0c             	mov    0xc(%rax),%edx
  8030a7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030ae:	00 00 00 
  8030b1:	89 10                	mov    %edx,(%rax)
  8030b3:	be 00 00 00 00       	mov    $0x0,%esi
  8030b8:	bf 06 00 00 00       	mov    $0x6,%edi
  8030bd:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  8030c4:	00 00 00 
  8030c7:	ff d0                	callq  *%rax
  8030c9:	c9                   	leaveq 
  8030ca:	c3                   	retq   

00000000008030cb <devfile_read>:
  8030cb:	55                   	push   %rbp
  8030cc:	48 89 e5             	mov    %rsp,%rbp
  8030cf:	48 83 ec 30          	sub    $0x30,%rsp
  8030d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8030d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8030db:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8030df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8030e3:	8b 50 0c             	mov    0xc(%rax),%edx
  8030e6:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030ed:	00 00 00 
  8030f0:	89 10                	mov    %edx,(%rax)
  8030f2:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8030f9:	00 00 00 
  8030fc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803100:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803104:	be 00 00 00 00       	mov    $0x0,%esi
  803109:	bf 03 00 00 00       	mov    $0x3,%edi
  80310e:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  803115:	00 00 00 
  803118:	ff d0                	callq  *%rax
  80311a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80311d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803121:	79 08                	jns    80312b <devfile_read+0x60>
  803123:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803126:	e9 a4 00 00 00       	jmpq   8031cf <devfile_read+0x104>
  80312b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80312e:	48 98                	cltq   
  803130:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  803134:	76 35                	jbe    80316b <devfile_read+0xa0>
  803136:	48 b9 f6 51 80 00 00 	movabs $0x8051f6,%rcx
  80313d:	00 00 00 
  803140:	48 ba fd 51 80 00 00 	movabs $0x8051fd,%rdx
  803147:	00 00 00 
  80314a:	be 89 00 00 00       	mov    $0x89,%esi
  80314f:	48 bf 12 52 80 00 00 	movabs $0x805212,%rdi
  803156:	00 00 00 
  803159:	b8 00 00 00 00       	mov    $0x0,%eax
  80315e:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  803165:	00 00 00 
  803168:	41 ff d0             	callq  *%r8
  80316b:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803172:	7e 35                	jle    8031a9 <devfile_read+0xde>
  803174:	48 b9 20 52 80 00 00 	movabs $0x805220,%rcx
  80317b:	00 00 00 
  80317e:	48 ba fd 51 80 00 00 	movabs $0x8051fd,%rdx
  803185:	00 00 00 
  803188:	be 8a 00 00 00       	mov    $0x8a,%esi
  80318d:	48 bf 12 52 80 00 00 	movabs $0x805212,%rdi
  803194:	00 00 00 
  803197:	b8 00 00 00 00       	mov    $0x0,%eax
  80319c:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8031a3:	00 00 00 
  8031a6:	41 ff d0             	callq  *%r8
  8031a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031ac:	48 63 d0             	movslq %eax,%rdx
  8031af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8031b3:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8031ba:	00 00 00 
  8031bd:	48 89 c7             	mov    %rax,%rdi
  8031c0:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  8031c7:	00 00 00 
  8031ca:	ff d0                	callq  *%rax
  8031cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031cf:	c9                   	leaveq 
  8031d0:	c3                   	retq   

00000000008031d1 <devfile_write>:
  8031d1:	55                   	push   %rbp
  8031d2:	48 89 e5             	mov    %rsp,%rbp
  8031d5:	48 83 ec 40          	sub    $0x40,%rsp
  8031d9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8031dd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8031e1:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8031e5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8031e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8031ed:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8031f4:	00 
  8031f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031f9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8031fd:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  803202:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  803206:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80320a:	8b 50 0c             	mov    0xc(%rax),%edx
  80320d:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803214:	00 00 00 
  803217:	89 10                	mov    %edx,(%rax)
  803219:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803220:	00 00 00 
  803223:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803227:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80322b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80322f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803233:	48 89 c6             	mov    %rax,%rsi
  803236:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  80323d:	00 00 00 
  803240:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803247:	00 00 00 
  80324a:	ff d0                	callq  *%rax
  80324c:	be 00 00 00 00       	mov    $0x0,%esi
  803251:	bf 04 00 00 00       	mov    $0x4,%edi
  803256:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  80325d:	00 00 00 
  803260:	ff d0                	callq  *%rax
  803262:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803265:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803269:	79 05                	jns    803270 <devfile_write+0x9f>
  80326b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80326e:	eb 43                	jmp    8032b3 <devfile_write+0xe2>
  803270:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803273:	48 98                	cltq   
  803275:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803279:	76 35                	jbe    8032b0 <devfile_write+0xdf>
  80327b:	48 b9 f6 51 80 00 00 	movabs $0x8051f6,%rcx
  803282:	00 00 00 
  803285:	48 ba fd 51 80 00 00 	movabs $0x8051fd,%rdx
  80328c:	00 00 00 
  80328f:	be a8 00 00 00       	mov    $0xa8,%esi
  803294:	48 bf 12 52 80 00 00 	movabs $0x805212,%rdi
  80329b:	00 00 00 
  80329e:	b8 00 00 00 00       	mov    $0x0,%eax
  8032a3:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8032aa:	00 00 00 
  8032ad:	41 ff d0             	callq  *%r8
  8032b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8032b3:	c9                   	leaveq 
  8032b4:	c3                   	retq   

00000000008032b5 <devfile_stat>:
  8032b5:	55                   	push   %rbp
  8032b6:	48 89 e5             	mov    %rsp,%rbp
  8032b9:	48 83 ec 20          	sub    $0x20,%rsp
  8032bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8032c1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8032c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8032c9:	8b 50 0c             	mov    0xc(%rax),%edx
  8032cc:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8032d3:	00 00 00 
  8032d6:	89 10                	mov    %edx,(%rax)
  8032d8:	be 00 00 00 00       	mov    $0x0,%esi
  8032dd:	bf 05 00 00 00       	mov    $0x5,%edi
  8032e2:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  8032e9:	00 00 00 
  8032ec:	ff d0                	callq  *%rax
  8032ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032f5:	79 05                	jns    8032fc <devfile_stat+0x47>
  8032f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032fa:	eb 56                	jmp    803352 <devfile_stat+0x9d>
  8032fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803300:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  803307:	00 00 00 
  80330a:	48 89 c7             	mov    %rax,%rdi
  80330d:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  803314:	00 00 00 
  803317:	ff d0                	callq  *%rax
  803319:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803320:	00 00 00 
  803323:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803329:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80332d:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803333:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80333a:	00 00 00 
  80333d:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  803343:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803347:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  80334d:	b8 00 00 00 00       	mov    $0x0,%eax
  803352:	c9                   	leaveq 
  803353:	c3                   	retq   

0000000000803354 <devfile_trunc>:
  803354:	55                   	push   %rbp
  803355:	48 89 e5             	mov    %rsp,%rbp
  803358:	48 83 ec 10          	sub    $0x10,%rsp
  80335c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803360:	89 75 f4             	mov    %esi,-0xc(%rbp)
  803363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803367:	8b 50 0c             	mov    0xc(%rax),%edx
  80336a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803371:	00 00 00 
  803374:	89 10                	mov    %edx,(%rax)
  803376:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80337d:	00 00 00 
  803380:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803383:	89 50 04             	mov    %edx,0x4(%rax)
  803386:	be 00 00 00 00       	mov    $0x0,%esi
  80338b:	bf 02 00 00 00       	mov    $0x2,%edi
  803390:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  803397:	00 00 00 
  80339a:	ff d0                	callq  *%rax
  80339c:	c9                   	leaveq 
  80339d:	c3                   	retq   

000000000080339e <remove>:
  80339e:	55                   	push   %rbp
  80339f:	48 89 e5             	mov    %rsp,%rbp
  8033a2:	48 83 ec 10          	sub    $0x10,%rsp
  8033a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8033aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8033ae:	48 89 c7             	mov    %rax,%rdi
  8033b1:	48 b8 3c 12 80 00 00 	movabs $0x80123c,%rax
  8033b8:	00 00 00 
  8033bb:	ff d0                	callq  *%rax
  8033bd:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8033c2:	7e 07                	jle    8033cb <remove+0x2d>
  8033c4:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8033c9:	eb 33                	jmp    8033fe <remove+0x60>
  8033cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8033cf:	48 89 c6             	mov    %rax,%rsi
  8033d2:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8033d9:	00 00 00 
  8033dc:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  8033e3:	00 00 00 
  8033e6:	ff d0                	callq  *%rax
  8033e8:	be 00 00 00 00       	mov    $0x0,%esi
  8033ed:	bf 07 00 00 00       	mov    $0x7,%edi
  8033f2:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  8033f9:	00 00 00 
  8033fc:	ff d0                	callq  *%rax
  8033fe:	c9                   	leaveq 
  8033ff:	c3                   	retq   

0000000000803400 <sync>:
  803400:	55                   	push   %rbp
  803401:	48 89 e5             	mov    %rsp,%rbp
  803404:	be 00 00 00 00       	mov    $0x0,%esi
  803409:	bf 08 00 00 00       	mov    $0x8,%edi
  80340e:	48 b8 33 2f 80 00 00 	movabs $0x802f33,%rax
  803415:	00 00 00 
  803418:	ff d0                	callq  *%rax
  80341a:	5d                   	pop    %rbp
  80341b:	c3                   	retq   

000000000080341c <copy>:
  80341c:	55                   	push   %rbp
  80341d:	48 89 e5             	mov    %rsp,%rbp
  803420:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  803427:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  80342e:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  803435:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  80343c:	be 00 00 00 00       	mov    $0x0,%esi
  803441:	48 89 c7             	mov    %rax,%rdi
  803444:	48 b8 ba 2f 80 00 00 	movabs $0x802fba,%rax
  80344b:	00 00 00 
  80344e:	ff d0                	callq  *%rax
  803450:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803453:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803457:	79 28                	jns    803481 <copy+0x65>
  803459:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80345c:	89 c6                	mov    %eax,%esi
  80345e:	48 bf 2c 52 80 00 00 	movabs $0x80522c,%rdi
  803465:	00 00 00 
  803468:	b8 00 00 00 00       	mov    $0x0,%eax
  80346d:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  803474:	00 00 00 
  803477:	ff d2                	callq  *%rdx
  803479:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80347c:	e9 74 01 00 00       	jmpq   8035f5 <copy+0x1d9>
  803481:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803488:	be 01 01 00 00       	mov    $0x101,%esi
  80348d:	48 89 c7             	mov    %rax,%rdi
  803490:	48 b8 ba 2f 80 00 00 	movabs $0x802fba,%rax
  803497:	00 00 00 
  80349a:	ff d0                	callq  *%rax
  80349c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80349f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8034a3:	79 39                	jns    8034de <copy+0xc2>
  8034a5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034a8:	89 c6                	mov    %eax,%esi
  8034aa:	48 bf 42 52 80 00 00 	movabs $0x805242,%rdi
  8034b1:	00 00 00 
  8034b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8034b9:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  8034c0:	00 00 00 
  8034c3:	ff d2                	callq  *%rdx
  8034c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034c8:	89 c7                	mov    %eax,%edi
  8034ca:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8034d1:	00 00 00 
  8034d4:	ff d0                	callq  *%rax
  8034d6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034d9:	e9 17 01 00 00       	jmpq   8035f5 <copy+0x1d9>
  8034de:	eb 74                	jmp    803554 <copy+0x138>
  8034e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8034e3:	48 63 d0             	movslq %eax,%rdx
  8034e6:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8034ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8034f0:	48 89 ce             	mov    %rcx,%rsi
  8034f3:	89 c7                	mov    %eax,%edi
  8034f5:	48 b8 2e 2c 80 00 00 	movabs $0x802c2e,%rax
  8034fc:	00 00 00 
  8034ff:	ff d0                	callq  *%rax
  803501:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803504:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803508:	79 4a                	jns    803554 <copy+0x138>
  80350a:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80350d:	89 c6                	mov    %eax,%esi
  80350f:	48 bf 5c 52 80 00 00 	movabs $0x80525c,%rdi
  803516:	00 00 00 
  803519:	b8 00 00 00 00       	mov    $0x0,%eax
  80351e:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  803525:	00 00 00 
  803528:	ff d2                	callq  *%rdx
  80352a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80352d:	89 c7                	mov    %eax,%edi
  80352f:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  803536:	00 00 00 
  803539:	ff d0                	callq  *%rax
  80353b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80353e:	89 c7                	mov    %eax,%edi
  803540:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  803547:	00 00 00 
  80354a:	ff d0                	callq  *%rax
  80354c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  80354f:	e9 a1 00 00 00       	jmpq   8035f5 <copy+0x1d9>
  803554:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80355b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80355e:	ba 00 02 00 00       	mov    $0x200,%edx
  803563:	48 89 ce             	mov    %rcx,%rsi
  803566:	89 c7                	mov    %eax,%edi
  803568:	48 b8 e4 2a 80 00 00 	movabs $0x802ae4,%rax
  80356f:	00 00 00 
  803572:	ff d0                	callq  *%rax
  803574:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803577:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80357b:	0f 8f 5f ff ff ff    	jg     8034e0 <copy+0xc4>
  803581:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803585:	79 47                	jns    8035ce <copy+0x1b2>
  803587:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80358a:	89 c6                	mov    %eax,%esi
  80358c:	48 bf 6f 52 80 00 00 	movabs $0x80526f,%rdi
  803593:	00 00 00 
  803596:	b8 00 00 00 00       	mov    $0x0,%eax
  80359b:	48 ba f3 06 80 00 00 	movabs $0x8006f3,%rdx
  8035a2:	00 00 00 
  8035a5:	ff d2                	callq  *%rdx
  8035a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035aa:	89 c7                	mov    %eax,%edi
  8035ac:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8035b3:	00 00 00 
  8035b6:	ff d0                	callq  *%rax
  8035b8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035bb:	89 c7                	mov    %eax,%edi
  8035bd:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8035c4:	00 00 00 
  8035c7:	ff d0                	callq  *%rax
  8035c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8035cc:	eb 27                	jmp    8035f5 <copy+0x1d9>
  8035ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035d1:	89 c7                	mov    %eax,%edi
  8035d3:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8035da:	00 00 00 
  8035dd:	ff d0                	callq  *%rax
  8035df:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8035e2:	89 c7                	mov    %eax,%edi
  8035e4:	48 b8 c2 28 80 00 00 	movabs $0x8028c2,%rax
  8035eb:	00 00 00 
  8035ee:	ff d0                	callq  *%rax
  8035f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8035f5:	c9                   	leaveq 
  8035f6:	c3                   	retq   

00000000008035f7 <fd2sockid>:
  8035f7:	55                   	push   %rbp
  8035f8:	48 89 e5             	mov    %rsp,%rbp
  8035fb:	48 83 ec 20          	sub    $0x20,%rsp
  8035ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803602:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803606:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803609:	48 89 d6             	mov    %rdx,%rsi
  80360c:	89 c7                	mov    %eax,%edi
  80360e:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  803615:	00 00 00 
  803618:	ff d0                	callq  *%rax
  80361a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80361d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803621:	79 05                	jns    803628 <fd2sockid+0x31>
  803623:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803626:	eb 24                	jmp    80364c <fd2sockid+0x55>
  803628:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80362c:	8b 10                	mov    (%rax),%edx
  80362e:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  803635:	00 00 00 
  803638:	8b 00                	mov    (%rax),%eax
  80363a:	39 c2                	cmp    %eax,%edx
  80363c:	74 07                	je     803645 <fd2sockid+0x4e>
  80363e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803643:	eb 07                	jmp    80364c <fd2sockid+0x55>
  803645:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803649:	8b 40 0c             	mov    0xc(%rax),%eax
  80364c:	c9                   	leaveq 
  80364d:	c3                   	retq   

000000000080364e <alloc_sockfd>:
  80364e:	55                   	push   %rbp
  80364f:	48 89 e5             	mov    %rsp,%rbp
  803652:	48 83 ec 20          	sub    $0x20,%rsp
  803656:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803659:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80365d:	48 89 c7             	mov    %rax,%rdi
  803660:	48 b8 1a 26 80 00 00 	movabs $0x80261a,%rax
  803667:	00 00 00 
  80366a:	ff d0                	callq  *%rax
  80366c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80366f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803673:	78 26                	js     80369b <alloc_sockfd+0x4d>
  803675:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803679:	ba 07 04 00 00       	mov    $0x407,%edx
  80367e:	48 89 c6             	mov    %rax,%rsi
  803681:	bf 00 00 00 00       	mov    $0x0,%edi
  803686:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  80368d:	00 00 00 
  803690:	ff d0                	callq  *%rax
  803692:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803695:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803699:	79 16                	jns    8036b1 <alloc_sockfd+0x63>
  80369b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80369e:	89 c7                	mov    %eax,%edi
  8036a0:	48 b8 5b 3b 80 00 00 	movabs $0x803b5b,%rax
  8036a7:	00 00 00 
  8036aa:	ff d0                	callq  *%rax
  8036ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036af:	eb 3a                	jmp    8036eb <alloc_sockfd+0x9d>
  8036b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036b5:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  8036bc:	00 00 00 
  8036bf:	8b 12                	mov    (%rdx),%edx
  8036c1:	89 10                	mov    %edx,(%rax)
  8036c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036c7:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8036ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036d2:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8036d5:	89 50 0c             	mov    %edx,0xc(%rax)
  8036d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036dc:	48 89 c7             	mov    %rax,%rdi
  8036df:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  8036e6:	00 00 00 
  8036e9:	ff d0                	callq  *%rax
  8036eb:	c9                   	leaveq 
  8036ec:	c3                   	retq   

00000000008036ed <accept>:
  8036ed:	55                   	push   %rbp
  8036ee:	48 89 e5             	mov    %rsp,%rbp
  8036f1:	48 83 ec 30          	sub    $0x30,%rsp
  8036f5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8036f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8036fc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803700:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803703:	89 c7                	mov    %eax,%edi
  803705:	48 b8 f7 35 80 00 00 	movabs $0x8035f7,%rax
  80370c:	00 00 00 
  80370f:	ff d0                	callq  *%rax
  803711:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803714:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803718:	79 05                	jns    80371f <accept+0x32>
  80371a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80371d:	eb 3b                	jmp    80375a <accept+0x6d>
  80371f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803723:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803727:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80372a:	48 89 ce             	mov    %rcx,%rsi
  80372d:	89 c7                	mov    %eax,%edi
  80372f:	48 b8 38 3a 80 00 00 	movabs $0x803a38,%rax
  803736:	00 00 00 
  803739:	ff d0                	callq  *%rax
  80373b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80373e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803742:	79 05                	jns    803749 <accept+0x5c>
  803744:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803747:	eb 11                	jmp    80375a <accept+0x6d>
  803749:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80374c:	89 c7                	mov    %eax,%edi
  80374e:	48 b8 4e 36 80 00 00 	movabs $0x80364e,%rax
  803755:	00 00 00 
  803758:	ff d0                	callq  *%rax
  80375a:	c9                   	leaveq 
  80375b:	c3                   	retq   

000000000080375c <bind>:
  80375c:	55                   	push   %rbp
  80375d:	48 89 e5             	mov    %rsp,%rbp
  803760:	48 83 ec 20          	sub    $0x20,%rsp
  803764:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803767:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80376b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80376e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803771:	89 c7                	mov    %eax,%edi
  803773:	48 b8 f7 35 80 00 00 	movabs $0x8035f7,%rax
  80377a:	00 00 00 
  80377d:	ff d0                	callq  *%rax
  80377f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803782:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803786:	79 05                	jns    80378d <bind+0x31>
  803788:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80378b:	eb 1b                	jmp    8037a8 <bind+0x4c>
  80378d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803790:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803794:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803797:	48 89 ce             	mov    %rcx,%rsi
  80379a:	89 c7                	mov    %eax,%edi
  80379c:	48 b8 b7 3a 80 00 00 	movabs $0x803ab7,%rax
  8037a3:	00 00 00 
  8037a6:	ff d0                	callq  *%rax
  8037a8:	c9                   	leaveq 
  8037a9:	c3                   	retq   

00000000008037aa <shutdown>:
  8037aa:	55                   	push   %rbp
  8037ab:	48 89 e5             	mov    %rsp,%rbp
  8037ae:	48 83 ec 20          	sub    $0x20,%rsp
  8037b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8037b5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8037b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8037bb:	89 c7                	mov    %eax,%edi
  8037bd:	48 b8 f7 35 80 00 00 	movabs $0x8035f7,%rax
  8037c4:	00 00 00 
  8037c7:	ff d0                	callq  *%rax
  8037c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037d0:	79 05                	jns    8037d7 <shutdown+0x2d>
  8037d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037d5:	eb 16                	jmp    8037ed <shutdown+0x43>
  8037d7:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8037da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037dd:	89 d6                	mov    %edx,%esi
  8037df:	89 c7                	mov    %eax,%edi
  8037e1:	48 b8 1b 3b 80 00 00 	movabs $0x803b1b,%rax
  8037e8:	00 00 00 
  8037eb:	ff d0                	callq  *%rax
  8037ed:	c9                   	leaveq 
  8037ee:	c3                   	retq   

00000000008037ef <devsock_close>:
  8037ef:	55                   	push   %rbp
  8037f0:	48 89 e5             	mov    %rsp,%rbp
  8037f3:	48 83 ec 10          	sub    $0x10,%rsp
  8037f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037ff:	48 89 c7             	mov    %rax,%rdi
  803802:	48 b8 e5 49 80 00 00 	movabs $0x8049e5,%rax
  803809:	00 00 00 
  80380c:	ff d0                	callq  *%rax
  80380e:	83 f8 01             	cmp    $0x1,%eax
  803811:	75 17                	jne    80382a <devsock_close+0x3b>
  803813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803817:	8b 40 0c             	mov    0xc(%rax),%eax
  80381a:	89 c7                	mov    %eax,%edi
  80381c:	48 b8 5b 3b 80 00 00 	movabs $0x803b5b,%rax
  803823:	00 00 00 
  803826:	ff d0                	callq  *%rax
  803828:	eb 05                	jmp    80382f <devsock_close+0x40>
  80382a:	b8 00 00 00 00       	mov    $0x0,%eax
  80382f:	c9                   	leaveq 
  803830:	c3                   	retq   

0000000000803831 <connect>:
  803831:	55                   	push   %rbp
  803832:	48 89 e5             	mov    %rsp,%rbp
  803835:	48 83 ec 20          	sub    $0x20,%rsp
  803839:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80383c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803840:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803843:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803846:	89 c7                	mov    %eax,%edi
  803848:	48 b8 f7 35 80 00 00 	movabs $0x8035f7,%rax
  80384f:	00 00 00 
  803852:	ff d0                	callq  *%rax
  803854:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803857:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80385b:	79 05                	jns    803862 <connect+0x31>
  80385d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803860:	eb 1b                	jmp    80387d <connect+0x4c>
  803862:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803865:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803869:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80386c:	48 89 ce             	mov    %rcx,%rsi
  80386f:	89 c7                	mov    %eax,%edi
  803871:	48 b8 88 3b 80 00 00 	movabs $0x803b88,%rax
  803878:	00 00 00 
  80387b:	ff d0                	callq  *%rax
  80387d:	c9                   	leaveq 
  80387e:	c3                   	retq   

000000000080387f <listen>:
  80387f:	55                   	push   %rbp
  803880:	48 89 e5             	mov    %rsp,%rbp
  803883:	48 83 ec 20          	sub    $0x20,%rsp
  803887:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80388a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80388d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803890:	89 c7                	mov    %eax,%edi
  803892:	48 b8 f7 35 80 00 00 	movabs $0x8035f7,%rax
  803899:	00 00 00 
  80389c:	ff d0                	callq  *%rax
  80389e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038a5:	79 05                	jns    8038ac <listen+0x2d>
  8038a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038aa:	eb 16                	jmp    8038c2 <listen+0x43>
  8038ac:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8038af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038b2:	89 d6                	mov    %edx,%esi
  8038b4:	89 c7                	mov    %eax,%edi
  8038b6:	48 b8 ec 3b 80 00 00 	movabs $0x803bec,%rax
  8038bd:	00 00 00 
  8038c0:	ff d0                	callq  *%rax
  8038c2:	c9                   	leaveq 
  8038c3:	c3                   	retq   

00000000008038c4 <devsock_read>:
  8038c4:	55                   	push   %rbp
  8038c5:	48 89 e5             	mov    %rsp,%rbp
  8038c8:	48 83 ec 20          	sub    $0x20,%rsp
  8038cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8038d0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8038d4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8038d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038dc:	89 c2                	mov    %eax,%edx
  8038de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038e2:	8b 40 0c             	mov    0xc(%rax),%eax
  8038e5:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8038e9:	b9 00 00 00 00       	mov    $0x0,%ecx
  8038ee:	89 c7                	mov    %eax,%edi
  8038f0:	48 b8 2c 3c 80 00 00 	movabs $0x803c2c,%rax
  8038f7:	00 00 00 
  8038fa:	ff d0                	callq  *%rax
  8038fc:	c9                   	leaveq 
  8038fd:	c3                   	retq   

00000000008038fe <devsock_write>:
  8038fe:	55                   	push   %rbp
  8038ff:	48 89 e5             	mov    %rsp,%rbp
  803902:	48 83 ec 20          	sub    $0x20,%rsp
  803906:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80390a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80390e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803912:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803916:	89 c2                	mov    %eax,%edx
  803918:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80391c:	8b 40 0c             	mov    0xc(%rax),%eax
  80391f:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803923:	b9 00 00 00 00       	mov    $0x0,%ecx
  803928:	89 c7                	mov    %eax,%edi
  80392a:	48 b8 f8 3c 80 00 00 	movabs $0x803cf8,%rax
  803931:	00 00 00 
  803934:	ff d0                	callq  *%rax
  803936:	c9                   	leaveq 
  803937:	c3                   	retq   

0000000000803938 <devsock_stat>:
  803938:	55                   	push   %rbp
  803939:	48 89 e5             	mov    %rsp,%rbp
  80393c:	48 83 ec 10          	sub    $0x10,%rsp
  803940:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803944:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803948:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80394c:	48 be 8a 52 80 00 00 	movabs $0x80528a,%rsi
  803953:	00 00 00 
  803956:	48 89 c7             	mov    %rax,%rdi
  803959:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  803960:	00 00 00 
  803963:	ff d0                	callq  *%rax
  803965:	b8 00 00 00 00       	mov    $0x0,%eax
  80396a:	c9                   	leaveq 
  80396b:	c3                   	retq   

000000000080396c <socket>:
  80396c:	55                   	push   %rbp
  80396d:	48 89 e5             	mov    %rsp,%rbp
  803970:	48 83 ec 20          	sub    $0x20,%rsp
  803974:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803977:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80397a:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80397d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803980:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803983:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803986:	89 ce                	mov    %ecx,%esi
  803988:	89 c7                	mov    %eax,%edi
  80398a:	48 b8 b0 3d 80 00 00 	movabs $0x803db0,%rax
  803991:	00 00 00 
  803994:	ff d0                	callq  *%rax
  803996:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803999:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80399d:	79 05                	jns    8039a4 <socket+0x38>
  80399f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039a2:	eb 11                	jmp    8039b5 <socket+0x49>
  8039a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039a7:	89 c7                	mov    %eax,%edi
  8039a9:	48 b8 4e 36 80 00 00 	movabs $0x80364e,%rax
  8039b0:	00 00 00 
  8039b3:	ff d0                	callq  *%rax
  8039b5:	c9                   	leaveq 
  8039b6:	c3                   	retq   

00000000008039b7 <nsipc>:
  8039b7:	55                   	push   %rbp
  8039b8:	48 89 e5             	mov    %rsp,%rbp
  8039bb:	48 83 ec 10          	sub    $0x10,%rsp
  8039bf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8039c2:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8039c9:	00 00 00 
  8039cc:	8b 00                	mov    (%rax),%eax
  8039ce:	85 c0                	test   %eax,%eax
  8039d0:	75 1d                	jne    8039ef <nsipc+0x38>
  8039d2:	bf 02 00 00 00       	mov    $0x2,%edi
  8039d7:	48 b8 73 49 80 00 00 	movabs $0x804973,%rax
  8039de:	00 00 00 
  8039e1:	ff d0                	callq  *%rax
  8039e3:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  8039ea:	00 00 00 
  8039ed:	89 02                	mov    %eax,(%rdx)
  8039ef:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  8039f6:	00 00 00 
  8039f9:	8b 00                	mov    (%rax),%eax
  8039fb:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8039fe:	b9 07 00 00 00       	mov    $0x7,%ecx
  803a03:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803a0a:	00 00 00 
  803a0d:	89 c7                	mov    %eax,%edi
  803a0f:	48 b8 68 48 80 00 00 	movabs $0x804868,%rax
  803a16:	00 00 00 
  803a19:	ff d0                	callq  *%rax
  803a1b:	ba 00 00 00 00       	mov    $0x0,%edx
  803a20:	be 00 00 00 00       	mov    $0x0,%esi
  803a25:	bf 00 00 00 00       	mov    $0x0,%edi
  803a2a:	48 b8 a7 47 80 00 00 	movabs $0x8047a7,%rax
  803a31:	00 00 00 
  803a34:	ff d0                	callq  *%rax
  803a36:	c9                   	leaveq 
  803a37:	c3                   	retq   

0000000000803a38 <nsipc_accept>:
  803a38:	55                   	push   %rbp
  803a39:	48 89 e5             	mov    %rsp,%rbp
  803a3c:	48 83 ec 30          	sub    $0x30,%rsp
  803a40:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a43:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803a47:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803a4b:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a52:	00 00 00 
  803a55:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803a58:	89 10                	mov    %edx,(%rax)
  803a5a:	bf 01 00 00 00       	mov    $0x1,%edi
  803a5f:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803a66:	00 00 00 
  803a69:	ff d0                	callq  *%rax
  803a6b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a6e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a72:	78 3e                	js     803ab2 <nsipc_accept+0x7a>
  803a74:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803a7b:	00 00 00 
  803a7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803a82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a86:	8b 40 10             	mov    0x10(%rax),%eax
  803a89:	89 c2                	mov    %eax,%edx
  803a8b:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803a8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a93:	48 89 ce             	mov    %rcx,%rsi
  803a96:	48 89 c7             	mov    %rax,%rdi
  803a99:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803aa0:	00 00 00 
  803aa3:	ff d0                	callq  *%rax
  803aa5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803aa9:	8b 50 10             	mov    0x10(%rax),%edx
  803aac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ab0:	89 10                	mov    %edx,(%rax)
  803ab2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ab5:	c9                   	leaveq 
  803ab6:	c3                   	retq   

0000000000803ab7 <nsipc_bind>:
  803ab7:	55                   	push   %rbp
  803ab8:	48 89 e5             	mov    %rsp,%rbp
  803abb:	48 83 ec 10          	sub    $0x10,%rsp
  803abf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803ac2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803ac6:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803ac9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ad0:	00 00 00 
  803ad3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ad6:	89 10                	mov    %edx,(%rax)
  803ad8:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803adb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803adf:	48 89 c6             	mov    %rax,%rsi
  803ae2:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803ae9:	00 00 00 
  803aec:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803af3:	00 00 00 
  803af6:	ff d0                	callq  *%rax
  803af8:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803aff:	00 00 00 
  803b02:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803b05:	89 50 14             	mov    %edx,0x14(%rax)
  803b08:	bf 02 00 00 00       	mov    $0x2,%edi
  803b0d:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803b14:	00 00 00 
  803b17:	ff d0                	callq  *%rax
  803b19:	c9                   	leaveq 
  803b1a:	c3                   	retq   

0000000000803b1b <nsipc_shutdown>:
  803b1b:	55                   	push   %rbp
  803b1c:	48 89 e5             	mov    %rsp,%rbp
  803b1f:	48 83 ec 10          	sub    $0x10,%rsp
  803b23:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b26:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803b29:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b30:	00 00 00 
  803b33:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b36:	89 10                	mov    %edx,(%rax)
  803b38:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b3f:	00 00 00 
  803b42:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803b45:	89 50 04             	mov    %edx,0x4(%rax)
  803b48:	bf 03 00 00 00       	mov    $0x3,%edi
  803b4d:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803b54:	00 00 00 
  803b57:	ff d0                	callq  *%rax
  803b59:	c9                   	leaveq 
  803b5a:	c3                   	retq   

0000000000803b5b <nsipc_close>:
  803b5b:	55                   	push   %rbp
  803b5c:	48 89 e5             	mov    %rsp,%rbp
  803b5f:	48 83 ec 10          	sub    $0x10,%rsp
  803b63:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b66:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803b6d:	00 00 00 
  803b70:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803b73:	89 10                	mov    %edx,(%rax)
  803b75:	bf 04 00 00 00       	mov    $0x4,%edi
  803b7a:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803b81:	00 00 00 
  803b84:	ff d0                	callq  *%rax
  803b86:	c9                   	leaveq 
  803b87:	c3                   	retq   

0000000000803b88 <nsipc_connect>:
  803b88:	55                   	push   %rbp
  803b89:	48 89 e5             	mov    %rsp,%rbp
  803b8c:	48 83 ec 10          	sub    $0x10,%rsp
  803b90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803b93:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803b97:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803b9a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ba1:	00 00 00 
  803ba4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803ba7:	89 10                	mov    %edx,(%rax)
  803ba9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803bac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bb0:	48 89 c6             	mov    %rax,%rsi
  803bb3:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803bba:	00 00 00 
  803bbd:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803bc4:	00 00 00 
  803bc7:	ff d0                	callq  *%rax
  803bc9:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803bd0:	00 00 00 
  803bd3:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803bd6:	89 50 14             	mov    %edx,0x14(%rax)
  803bd9:	bf 05 00 00 00       	mov    $0x5,%edi
  803bde:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803be5:	00 00 00 
  803be8:	ff d0                	callq  *%rax
  803bea:	c9                   	leaveq 
  803beb:	c3                   	retq   

0000000000803bec <nsipc_listen>:
  803bec:	55                   	push   %rbp
  803bed:	48 89 e5             	mov    %rsp,%rbp
  803bf0:	48 83 ec 10          	sub    $0x10,%rsp
  803bf4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803bf7:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803bfa:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c01:	00 00 00 
  803c04:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c07:	89 10                	mov    %edx,(%rax)
  803c09:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c10:	00 00 00 
  803c13:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803c16:	89 50 04             	mov    %edx,0x4(%rax)
  803c19:	bf 06 00 00 00       	mov    $0x6,%edi
  803c1e:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803c25:	00 00 00 
  803c28:	ff d0                	callq  *%rax
  803c2a:	c9                   	leaveq 
  803c2b:	c3                   	retq   

0000000000803c2c <nsipc_recv>:
  803c2c:	55                   	push   %rbp
  803c2d:	48 89 e5             	mov    %rsp,%rbp
  803c30:	48 83 ec 30          	sub    $0x30,%rsp
  803c34:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c37:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c3b:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803c3e:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803c41:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c48:	00 00 00 
  803c4b:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803c4e:	89 10                	mov    %edx,(%rax)
  803c50:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c57:	00 00 00 
  803c5a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c5d:	89 50 04             	mov    %edx,0x4(%rax)
  803c60:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803c67:	00 00 00 
  803c6a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803c6d:	89 50 08             	mov    %edx,0x8(%rax)
  803c70:	bf 07 00 00 00       	mov    $0x7,%edi
  803c75:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803c7c:	00 00 00 
  803c7f:	ff d0                	callq  *%rax
  803c81:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c84:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c88:	78 69                	js     803cf3 <nsipc_recv+0xc7>
  803c8a:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803c91:	7f 08                	jg     803c9b <nsipc_recv+0x6f>
  803c93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c96:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  803c99:	7e 35                	jle    803cd0 <nsipc_recv+0xa4>
  803c9b:	48 b9 91 52 80 00 00 	movabs $0x805291,%rcx
  803ca2:	00 00 00 
  803ca5:	48 ba a6 52 80 00 00 	movabs $0x8052a6,%rdx
  803cac:	00 00 00 
  803caf:	be 62 00 00 00       	mov    $0x62,%esi
  803cb4:	48 bf bb 52 80 00 00 	movabs $0x8052bb,%rdi
  803cbb:	00 00 00 
  803cbe:	b8 00 00 00 00       	mov    $0x0,%eax
  803cc3:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  803cca:	00 00 00 
  803ccd:	41 ff d0             	callq  *%r8
  803cd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cd3:	48 63 d0             	movslq %eax,%rdx
  803cd6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803cda:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  803ce1:	00 00 00 
  803ce4:	48 89 c7             	mov    %rax,%rdi
  803ce7:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803cee:	00 00 00 
  803cf1:	ff d0                	callq  *%rax
  803cf3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cf6:	c9                   	leaveq 
  803cf7:	c3                   	retq   

0000000000803cf8 <nsipc_send>:
  803cf8:	55                   	push   %rbp
  803cf9:	48 89 e5             	mov    %rsp,%rbp
  803cfc:	48 83 ec 20          	sub    $0x20,%rsp
  803d00:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d03:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803d07:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803d0a:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803d0d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d14:	00 00 00 
  803d17:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803d1a:	89 10                	mov    %edx,(%rax)
  803d1c:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  803d23:	7e 35                	jle    803d5a <nsipc_send+0x62>
  803d25:	48 b9 ca 52 80 00 00 	movabs $0x8052ca,%rcx
  803d2c:	00 00 00 
  803d2f:	48 ba a6 52 80 00 00 	movabs $0x8052a6,%rdx
  803d36:	00 00 00 
  803d39:	be 6d 00 00 00       	mov    $0x6d,%esi
  803d3e:	48 bf bb 52 80 00 00 	movabs $0x8052bb,%rdi
  803d45:	00 00 00 
  803d48:	b8 00 00 00 00       	mov    $0x0,%eax
  803d4d:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  803d54:	00 00 00 
  803d57:	41 ff d0             	callq  *%r8
  803d5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d5d:	48 63 d0             	movslq %eax,%rdx
  803d60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d64:	48 89 c6             	mov    %rax,%rsi
  803d67:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  803d6e:	00 00 00 
  803d71:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  803d78:	00 00 00 
  803d7b:	ff d0                	callq  *%rax
  803d7d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d84:	00 00 00 
  803d87:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803d8a:	89 50 04             	mov    %edx,0x4(%rax)
  803d8d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803d94:	00 00 00 
  803d97:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803d9a:	89 50 08             	mov    %edx,0x8(%rax)
  803d9d:	bf 08 00 00 00       	mov    $0x8,%edi
  803da2:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803da9:	00 00 00 
  803dac:	ff d0                	callq  *%rax
  803dae:	c9                   	leaveq 
  803daf:	c3                   	retq   

0000000000803db0 <nsipc_socket>:
  803db0:	55                   	push   %rbp
  803db1:	48 89 e5             	mov    %rsp,%rbp
  803db4:	48 83 ec 10          	sub    $0x10,%rsp
  803db8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803dbb:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803dbe:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803dc1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dc8:	00 00 00 
  803dcb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803dce:	89 10                	mov    %edx,(%rax)
  803dd0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803dd7:	00 00 00 
  803dda:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ddd:	89 50 04             	mov    %edx,0x4(%rax)
  803de0:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803de7:	00 00 00 
  803dea:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803ded:	89 50 08             	mov    %edx,0x8(%rax)
  803df0:	bf 09 00 00 00       	mov    $0x9,%edi
  803df5:	48 b8 b7 39 80 00 00 	movabs $0x8039b7,%rax
  803dfc:	00 00 00 
  803dff:	ff d0                	callq  *%rax
  803e01:	c9                   	leaveq 
  803e02:	c3                   	retq   

0000000000803e03 <pipe>:
  803e03:	55                   	push   %rbp
  803e04:	48 89 e5             	mov    %rsp,%rbp
  803e07:	53                   	push   %rbx
  803e08:	48 83 ec 38          	sub    $0x38,%rsp
  803e0c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803e10:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  803e14:	48 89 c7             	mov    %rax,%rdi
  803e17:	48 b8 1a 26 80 00 00 	movabs $0x80261a,%rax
  803e1e:	00 00 00 
  803e21:	ff d0                	callq  *%rax
  803e23:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e26:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e2a:	0f 88 bf 01 00 00    	js     803fef <pipe+0x1ec>
  803e30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e34:	ba 07 04 00 00       	mov    $0x407,%edx
  803e39:	48 89 c6             	mov    %rax,%rsi
  803e3c:	bf 00 00 00 00       	mov    $0x0,%edi
  803e41:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  803e48:	00 00 00 
  803e4b:	ff d0                	callq  *%rax
  803e4d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e50:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e54:	0f 88 95 01 00 00    	js     803fef <pipe+0x1ec>
  803e5a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803e5e:	48 89 c7             	mov    %rax,%rdi
  803e61:	48 b8 1a 26 80 00 00 	movabs $0x80261a,%rax
  803e68:	00 00 00 
  803e6b:	ff d0                	callq  *%rax
  803e6d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e70:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e74:	0f 88 5d 01 00 00    	js     803fd7 <pipe+0x1d4>
  803e7a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803e7e:	ba 07 04 00 00       	mov    $0x407,%edx
  803e83:	48 89 c6             	mov    %rax,%rsi
  803e86:	bf 00 00 00 00       	mov    $0x0,%edi
  803e8b:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  803e92:	00 00 00 
  803e95:	ff d0                	callq  *%rax
  803e97:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803e9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803e9e:	0f 88 33 01 00 00    	js     803fd7 <pipe+0x1d4>
  803ea4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ea8:	48 89 c7             	mov    %rax,%rdi
  803eab:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  803eb2:	00 00 00 
  803eb5:	ff d0                	callq  *%rax
  803eb7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803ebb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ebf:	ba 07 04 00 00       	mov    $0x407,%edx
  803ec4:	48 89 c6             	mov    %rax,%rsi
  803ec7:	bf 00 00 00 00       	mov    $0x0,%edi
  803ecc:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  803ed3:	00 00 00 
  803ed6:	ff d0                	callq  *%rax
  803ed8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803edb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803edf:	79 05                	jns    803ee6 <pipe+0xe3>
  803ee1:	e9 d9 00 00 00       	jmpq   803fbf <pipe+0x1bc>
  803ee6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803eea:	48 89 c7             	mov    %rax,%rdi
  803eed:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  803ef4:	00 00 00 
  803ef7:	ff d0                	callq  *%rax
  803ef9:	48 89 c2             	mov    %rax,%rdx
  803efc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f00:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  803f06:	48 89 d1             	mov    %rdx,%rcx
  803f09:	ba 00 00 00 00       	mov    $0x0,%edx
  803f0e:	48 89 c6             	mov    %rax,%rsi
  803f11:	bf 00 00 00 00       	mov    $0x0,%edi
  803f16:	48 b8 27 1c 80 00 00 	movabs $0x801c27,%rax
  803f1d:	00 00 00 
  803f20:	ff d0                	callq  *%rax
  803f22:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803f25:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803f29:	79 1b                	jns    803f46 <pipe+0x143>
  803f2b:	90                   	nop
  803f2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f30:	48 89 c6             	mov    %rax,%rsi
  803f33:	bf 00 00 00 00       	mov    $0x0,%edi
  803f38:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  803f3f:	00 00 00 
  803f42:	ff d0                	callq  *%rax
  803f44:	eb 79                	jmp    803fbf <pipe+0x1bc>
  803f46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f4a:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803f51:	00 00 00 
  803f54:	8b 12                	mov    (%rdx),%edx
  803f56:	89 10                	mov    %edx,(%rax)
  803f58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f5c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803f63:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f67:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  803f6e:	00 00 00 
  803f71:	8b 12                	mov    (%rdx),%edx
  803f73:	89 10                	mov    %edx,(%rax)
  803f75:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803f79:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803f80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f84:	48 89 c7             	mov    %rax,%rdi
  803f87:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  803f8e:	00 00 00 
  803f91:	ff d0                	callq  *%rax
  803f93:	89 c2                	mov    %eax,%edx
  803f95:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803f99:	89 10                	mov    %edx,(%rax)
  803f9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803f9f:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803fa3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fa7:	48 89 c7             	mov    %rax,%rdi
  803faa:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  803fb1:	00 00 00 
  803fb4:	ff d0                	callq  *%rax
  803fb6:	89 03                	mov    %eax,(%rbx)
  803fb8:	b8 00 00 00 00       	mov    $0x0,%eax
  803fbd:	eb 33                	jmp    803ff2 <pipe+0x1ef>
  803fbf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803fc3:	48 89 c6             	mov    %rax,%rsi
  803fc6:	bf 00 00 00 00       	mov    $0x0,%edi
  803fcb:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  803fd2:	00 00 00 
  803fd5:	ff d0                	callq  *%rax
  803fd7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fdb:	48 89 c6             	mov    %rax,%rsi
  803fde:	bf 00 00 00 00       	mov    $0x0,%edi
  803fe3:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  803fea:	00 00 00 
  803fed:	ff d0                	callq  *%rax
  803fef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ff2:	48 83 c4 38          	add    $0x38,%rsp
  803ff6:	5b                   	pop    %rbx
  803ff7:	5d                   	pop    %rbp
  803ff8:	c3                   	retq   

0000000000803ff9 <_pipeisclosed>:
  803ff9:	55                   	push   %rbp
  803ffa:	48 89 e5             	mov    %rsp,%rbp
  803ffd:	53                   	push   %rbx
  803ffe:	48 83 ec 28          	sub    $0x28,%rsp
  804002:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804006:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80400a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804011:	00 00 00 
  804014:	48 8b 00             	mov    (%rax),%rax
  804017:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80401d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804020:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804024:	48 89 c7             	mov    %rax,%rdi
  804027:	48 b8 e5 49 80 00 00 	movabs $0x8049e5,%rax
  80402e:	00 00 00 
  804031:	ff d0                	callq  *%rax
  804033:	89 c3                	mov    %eax,%ebx
  804035:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804039:	48 89 c7             	mov    %rax,%rdi
  80403c:	48 b8 e5 49 80 00 00 	movabs $0x8049e5,%rax
  804043:	00 00 00 
  804046:	ff d0                	callq  *%rax
  804048:	39 c3                	cmp    %eax,%ebx
  80404a:	0f 94 c0             	sete   %al
  80404d:	0f b6 c0             	movzbl %al,%eax
  804050:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804053:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80405a:	00 00 00 
  80405d:	48 8b 00             	mov    (%rax),%rax
  804060:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804066:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  804069:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80406c:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80406f:	75 05                	jne    804076 <_pipeisclosed+0x7d>
  804071:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804074:	eb 4f                	jmp    8040c5 <_pipeisclosed+0xcc>
  804076:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804079:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  80407c:	74 42                	je     8040c0 <_pipeisclosed+0xc7>
  80407e:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  804082:	75 3c                	jne    8040c0 <_pipeisclosed+0xc7>
  804084:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80408b:	00 00 00 
  80408e:	48 8b 00             	mov    (%rax),%rax
  804091:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  804097:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80409a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80409d:	89 c6                	mov    %eax,%esi
  80409f:	48 bf db 52 80 00 00 	movabs $0x8052db,%rdi
  8040a6:	00 00 00 
  8040a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8040ae:	49 b8 f3 06 80 00 00 	movabs $0x8006f3,%r8
  8040b5:	00 00 00 
  8040b8:	41 ff d0             	callq  *%r8
  8040bb:	e9 4a ff ff ff       	jmpq   80400a <_pipeisclosed+0x11>
  8040c0:	e9 45 ff ff ff       	jmpq   80400a <_pipeisclosed+0x11>
  8040c5:	48 83 c4 28          	add    $0x28,%rsp
  8040c9:	5b                   	pop    %rbx
  8040ca:	5d                   	pop    %rbp
  8040cb:	c3                   	retq   

00000000008040cc <pipeisclosed>:
  8040cc:	55                   	push   %rbp
  8040cd:	48 89 e5             	mov    %rsp,%rbp
  8040d0:	48 83 ec 30          	sub    $0x30,%rsp
  8040d4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8040d7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8040db:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8040de:	48 89 d6             	mov    %rdx,%rsi
  8040e1:	89 c7                	mov    %eax,%edi
  8040e3:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  8040ea:	00 00 00 
  8040ed:	ff d0                	callq  *%rax
  8040ef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040f6:	79 05                	jns    8040fd <pipeisclosed+0x31>
  8040f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040fb:	eb 31                	jmp    80412e <pipeisclosed+0x62>
  8040fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804101:	48 89 c7             	mov    %rax,%rdi
  804104:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  80410b:	00 00 00 
  80410e:	ff d0                	callq  *%rax
  804110:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804118:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80411c:	48 89 d6             	mov    %rdx,%rsi
  80411f:	48 89 c7             	mov    %rax,%rdi
  804122:	48 b8 f9 3f 80 00 00 	movabs $0x803ff9,%rax
  804129:	00 00 00 
  80412c:	ff d0                	callq  *%rax
  80412e:	c9                   	leaveq 
  80412f:	c3                   	retq   

0000000000804130 <devpipe_read>:
  804130:	55                   	push   %rbp
  804131:	48 89 e5             	mov    %rsp,%rbp
  804134:	48 83 ec 40          	sub    $0x40,%rsp
  804138:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80413c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804140:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804144:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804148:	48 89 c7             	mov    %rax,%rdi
  80414b:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  804152:	00 00 00 
  804155:	ff d0                	callq  *%rax
  804157:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80415b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80415f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804163:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80416a:	00 
  80416b:	e9 92 00 00 00       	jmpq   804202 <devpipe_read+0xd2>
  804170:	eb 41                	jmp    8041b3 <devpipe_read+0x83>
  804172:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  804177:	74 09                	je     804182 <devpipe_read+0x52>
  804179:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80417d:	e9 92 00 00 00       	jmpq   804214 <devpipe_read+0xe4>
  804182:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80418a:	48 89 d6             	mov    %rdx,%rsi
  80418d:	48 89 c7             	mov    %rax,%rdi
  804190:	48 b8 f9 3f 80 00 00 	movabs $0x803ff9,%rax
  804197:	00 00 00 
  80419a:	ff d0                	callq  *%rax
  80419c:	85 c0                	test   %eax,%eax
  80419e:	74 07                	je     8041a7 <devpipe_read+0x77>
  8041a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8041a5:	eb 6d                	jmp    804214 <devpipe_read+0xe4>
  8041a7:	48 b8 99 1b 80 00 00 	movabs $0x801b99,%rax
  8041ae:	00 00 00 
  8041b1:	ff d0                	callq  *%rax
  8041b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041b7:	8b 10                	mov    (%rax),%edx
  8041b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041bd:	8b 40 04             	mov    0x4(%rax),%eax
  8041c0:	39 c2                	cmp    %eax,%edx
  8041c2:	74 ae                	je     804172 <devpipe_read+0x42>
  8041c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8041cc:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8041d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041d4:	8b 00                	mov    (%rax),%eax
  8041d6:	99                   	cltd   
  8041d7:	c1 ea 1b             	shr    $0x1b,%edx
  8041da:	01 d0                	add    %edx,%eax
  8041dc:	83 e0 1f             	and    $0x1f,%eax
  8041df:	29 d0                	sub    %edx,%eax
  8041e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8041e5:	48 98                	cltq   
  8041e7:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8041ec:	88 01                	mov    %al,(%rcx)
  8041ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041f2:	8b 00                	mov    (%rax),%eax
  8041f4:	8d 50 01             	lea    0x1(%rax),%edx
  8041f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041fb:	89 10                	mov    %edx,(%rax)
  8041fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804206:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80420a:	0f 82 60 ff ff ff    	jb     804170 <devpipe_read+0x40>
  804210:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804214:	c9                   	leaveq 
  804215:	c3                   	retq   

0000000000804216 <devpipe_write>:
  804216:	55                   	push   %rbp
  804217:	48 89 e5             	mov    %rsp,%rbp
  80421a:	48 83 ec 40          	sub    $0x40,%rsp
  80421e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804222:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804226:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80422a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80422e:	48 89 c7             	mov    %rax,%rdi
  804231:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  804238:	00 00 00 
  80423b:	ff d0                	callq  *%rax
  80423d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804241:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804245:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804249:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804250:	00 
  804251:	e9 8e 00 00 00       	jmpq   8042e4 <devpipe_write+0xce>
  804256:	eb 31                	jmp    804289 <devpipe_write+0x73>
  804258:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80425c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804260:	48 89 d6             	mov    %rdx,%rsi
  804263:	48 89 c7             	mov    %rax,%rdi
  804266:	48 b8 f9 3f 80 00 00 	movabs $0x803ff9,%rax
  80426d:	00 00 00 
  804270:	ff d0                	callq  *%rax
  804272:	85 c0                	test   %eax,%eax
  804274:	74 07                	je     80427d <devpipe_write+0x67>
  804276:	b8 00 00 00 00       	mov    $0x0,%eax
  80427b:	eb 79                	jmp    8042f6 <devpipe_write+0xe0>
  80427d:	48 b8 99 1b 80 00 00 	movabs $0x801b99,%rax
  804284:	00 00 00 
  804287:	ff d0                	callq  *%rax
  804289:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80428d:	8b 40 04             	mov    0x4(%rax),%eax
  804290:	48 63 d0             	movslq %eax,%rdx
  804293:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804297:	8b 00                	mov    (%rax),%eax
  804299:	48 98                	cltq   
  80429b:	48 83 c0 20          	add    $0x20,%rax
  80429f:	48 39 c2             	cmp    %rax,%rdx
  8042a2:	73 b4                	jae    804258 <devpipe_write+0x42>
  8042a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042a8:	8b 40 04             	mov    0x4(%rax),%eax
  8042ab:	99                   	cltd   
  8042ac:	c1 ea 1b             	shr    $0x1b,%edx
  8042af:	01 d0                	add    %edx,%eax
  8042b1:	83 e0 1f             	and    $0x1f,%eax
  8042b4:	29 d0                	sub    %edx,%eax
  8042b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8042ba:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8042be:	48 01 ca             	add    %rcx,%rdx
  8042c1:	0f b6 0a             	movzbl (%rdx),%ecx
  8042c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8042c8:	48 98                	cltq   
  8042ca:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8042ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042d2:	8b 40 04             	mov    0x4(%rax),%eax
  8042d5:	8d 50 01             	lea    0x1(%rax),%edx
  8042d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042dc:	89 50 04             	mov    %edx,0x4(%rax)
  8042df:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8042e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042e8:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8042ec:	0f 82 64 ff ff ff    	jb     804256 <devpipe_write+0x40>
  8042f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8042f6:	c9                   	leaveq 
  8042f7:	c3                   	retq   

00000000008042f8 <devpipe_stat>:
  8042f8:	55                   	push   %rbp
  8042f9:	48 89 e5             	mov    %rsp,%rbp
  8042fc:	48 83 ec 20          	sub    $0x20,%rsp
  804300:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804304:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804308:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80430c:	48 89 c7             	mov    %rax,%rdi
  80430f:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  804316:	00 00 00 
  804319:	ff d0                	callq  *%rax
  80431b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80431f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804323:	48 be ee 52 80 00 00 	movabs $0x8052ee,%rsi
  80432a:	00 00 00 
  80432d:	48 89 c7             	mov    %rax,%rdi
  804330:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  804337:	00 00 00 
  80433a:	ff d0                	callq  *%rax
  80433c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804340:	8b 50 04             	mov    0x4(%rax),%edx
  804343:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804347:	8b 00                	mov    (%rax),%eax
  804349:	29 c2                	sub    %eax,%edx
  80434b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80434f:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804355:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804359:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804360:	00 00 00 
  804363:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804367:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  80436e:	00 00 00 
  804371:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804378:	b8 00 00 00 00       	mov    $0x0,%eax
  80437d:	c9                   	leaveq 
  80437e:	c3                   	retq   

000000000080437f <devpipe_close>:
  80437f:	55                   	push   %rbp
  804380:	48 89 e5             	mov    %rsp,%rbp
  804383:	48 83 ec 10          	sub    $0x10,%rsp
  804387:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80438b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80438f:	48 89 c6             	mov    %rax,%rsi
  804392:	bf 00 00 00 00       	mov    $0x0,%edi
  804397:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  80439e:	00 00 00 
  8043a1:	ff d0                	callq  *%rax
  8043a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8043a7:	48 89 c7             	mov    %rax,%rdi
  8043aa:	48 b8 ef 25 80 00 00 	movabs $0x8025ef,%rax
  8043b1:	00 00 00 
  8043b4:	ff d0                	callq  *%rax
  8043b6:	48 89 c6             	mov    %rax,%rsi
  8043b9:	bf 00 00 00 00       	mov    $0x0,%edi
  8043be:	48 b8 82 1c 80 00 00 	movabs $0x801c82,%rax
  8043c5:	00 00 00 
  8043c8:	ff d0                	callq  *%rax
  8043ca:	c9                   	leaveq 
  8043cb:	c3                   	retq   

00000000008043cc <cputchar>:
  8043cc:	55                   	push   %rbp
  8043cd:	48 89 e5             	mov    %rsp,%rbp
  8043d0:	48 83 ec 20          	sub    $0x20,%rsp
  8043d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8043d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8043da:	88 45 ff             	mov    %al,-0x1(%rbp)
  8043dd:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8043e1:	be 01 00 00 00       	mov    $0x1,%esi
  8043e6:	48 89 c7             	mov    %rax,%rdi
  8043e9:	48 b8 8f 1a 80 00 00 	movabs $0x801a8f,%rax
  8043f0:	00 00 00 
  8043f3:	ff d0                	callq  *%rax
  8043f5:	c9                   	leaveq 
  8043f6:	c3                   	retq   

00000000008043f7 <getchar>:
  8043f7:	55                   	push   %rbp
  8043f8:	48 89 e5             	mov    %rsp,%rbp
  8043fb:	48 83 ec 10          	sub    $0x10,%rsp
  8043ff:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  804403:	ba 01 00 00 00       	mov    $0x1,%edx
  804408:	48 89 c6             	mov    %rax,%rsi
  80440b:	bf 00 00 00 00       	mov    $0x0,%edi
  804410:	48 b8 e4 2a 80 00 00 	movabs $0x802ae4,%rax
  804417:	00 00 00 
  80441a:	ff d0                	callq  *%rax
  80441c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80441f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804423:	79 05                	jns    80442a <getchar+0x33>
  804425:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804428:	eb 14                	jmp    80443e <getchar+0x47>
  80442a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80442e:	7f 07                	jg     804437 <getchar+0x40>
  804430:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  804435:	eb 07                	jmp    80443e <getchar+0x47>
  804437:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  80443b:	0f b6 c0             	movzbl %al,%eax
  80443e:	c9                   	leaveq 
  80443f:	c3                   	retq   

0000000000804440 <iscons>:
  804440:	55                   	push   %rbp
  804441:	48 89 e5             	mov    %rsp,%rbp
  804444:	48 83 ec 20          	sub    $0x20,%rsp
  804448:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80444b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80444f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804452:	48 89 d6             	mov    %rdx,%rsi
  804455:	89 c7                	mov    %eax,%edi
  804457:	48 b8 b2 26 80 00 00 	movabs $0x8026b2,%rax
  80445e:	00 00 00 
  804461:	ff d0                	callq  *%rax
  804463:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804466:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80446a:	79 05                	jns    804471 <iscons+0x31>
  80446c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80446f:	eb 1a                	jmp    80448b <iscons+0x4b>
  804471:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804475:	8b 10                	mov    (%rax),%edx
  804477:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  80447e:	00 00 00 
  804481:	8b 00                	mov    (%rax),%eax
  804483:	39 c2                	cmp    %eax,%edx
  804485:	0f 94 c0             	sete   %al
  804488:	0f b6 c0             	movzbl %al,%eax
  80448b:	c9                   	leaveq 
  80448c:	c3                   	retq   

000000000080448d <opencons>:
  80448d:	55                   	push   %rbp
  80448e:	48 89 e5             	mov    %rsp,%rbp
  804491:	48 83 ec 10          	sub    $0x10,%rsp
  804495:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804499:	48 89 c7             	mov    %rax,%rdi
  80449c:	48 b8 1a 26 80 00 00 	movabs $0x80261a,%rax
  8044a3:	00 00 00 
  8044a6:	ff d0                	callq  *%rax
  8044a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044af:	79 05                	jns    8044b6 <opencons+0x29>
  8044b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044b4:	eb 5b                	jmp    804511 <opencons+0x84>
  8044b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044ba:	ba 07 04 00 00       	mov    $0x407,%edx
  8044bf:	48 89 c6             	mov    %rax,%rsi
  8044c2:	bf 00 00 00 00       	mov    $0x0,%edi
  8044c7:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  8044ce:	00 00 00 
  8044d1:	ff d0                	callq  *%rax
  8044d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044da:	79 05                	jns    8044e1 <opencons+0x54>
  8044dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044df:	eb 30                	jmp    804511 <opencons+0x84>
  8044e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044e5:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8044ec:	00 00 00 
  8044ef:	8b 12                	mov    (%rdx),%edx
  8044f1:	89 10                	mov    %edx,(%rax)
  8044f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8044f7:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8044fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804502:	48 89 c7             	mov    %rax,%rdi
  804505:	48 b8 cc 25 80 00 00 	movabs $0x8025cc,%rax
  80450c:	00 00 00 
  80450f:	ff d0                	callq  *%rax
  804511:	c9                   	leaveq 
  804512:	c3                   	retq   

0000000000804513 <devcons_read>:
  804513:	55                   	push   %rbp
  804514:	48 89 e5             	mov    %rsp,%rbp
  804517:	48 83 ec 30          	sub    $0x30,%rsp
  80451b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80451f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804523:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804527:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80452c:	75 07                	jne    804535 <devcons_read+0x22>
  80452e:	b8 00 00 00 00       	mov    $0x0,%eax
  804533:	eb 4b                	jmp    804580 <devcons_read+0x6d>
  804535:	eb 0c                	jmp    804543 <devcons_read+0x30>
  804537:	48 b8 99 1b 80 00 00 	movabs $0x801b99,%rax
  80453e:	00 00 00 
  804541:	ff d0                	callq  *%rax
  804543:	48 b8 d9 1a 80 00 00 	movabs $0x801ad9,%rax
  80454a:	00 00 00 
  80454d:	ff d0                	callq  *%rax
  80454f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804552:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804556:	74 df                	je     804537 <devcons_read+0x24>
  804558:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80455c:	79 05                	jns    804563 <devcons_read+0x50>
  80455e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804561:	eb 1d                	jmp    804580 <devcons_read+0x6d>
  804563:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804567:	75 07                	jne    804570 <devcons_read+0x5d>
  804569:	b8 00 00 00 00       	mov    $0x0,%eax
  80456e:	eb 10                	jmp    804580 <devcons_read+0x6d>
  804570:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804573:	89 c2                	mov    %eax,%edx
  804575:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804579:	88 10                	mov    %dl,(%rax)
  80457b:	b8 01 00 00 00       	mov    $0x1,%eax
  804580:	c9                   	leaveq 
  804581:	c3                   	retq   

0000000000804582 <devcons_write>:
  804582:	55                   	push   %rbp
  804583:	48 89 e5             	mov    %rsp,%rbp
  804586:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  80458d:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804594:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80459b:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8045a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8045a9:	eb 76                	jmp    804621 <devcons_write+0x9f>
  8045ab:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8045b2:	89 c2                	mov    %eax,%edx
  8045b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045b7:	29 c2                	sub    %eax,%edx
  8045b9:	89 d0                	mov    %edx,%eax
  8045bb:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8045be:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045c1:	83 f8 7f             	cmp    $0x7f,%eax
  8045c4:	76 07                	jbe    8045cd <devcons_write+0x4b>
  8045c6:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8045cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045d0:	48 63 d0             	movslq %eax,%rdx
  8045d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8045d6:	48 63 c8             	movslq %eax,%rcx
  8045d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8045e0:	48 01 c1             	add    %rax,%rcx
  8045e3:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8045ea:	48 89 ce             	mov    %rcx,%rsi
  8045ed:	48 89 c7             	mov    %rax,%rdi
  8045f0:	48 b8 cc 15 80 00 00 	movabs $0x8015cc,%rax
  8045f7:	00 00 00 
  8045fa:	ff d0                	callq  *%rax
  8045fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045ff:	48 63 d0             	movslq %eax,%rdx
  804602:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804609:	48 89 d6             	mov    %rdx,%rsi
  80460c:	48 89 c7             	mov    %rax,%rdi
  80460f:	48 b8 8f 1a 80 00 00 	movabs $0x801a8f,%rax
  804616:	00 00 00 
  804619:	ff d0                	callq  *%rax
  80461b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80461e:	01 45 fc             	add    %eax,-0x4(%rbp)
  804621:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804624:	48 98                	cltq   
  804626:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  80462d:	0f 82 78 ff ff ff    	jb     8045ab <devcons_write+0x29>
  804633:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804636:	c9                   	leaveq 
  804637:	c3                   	retq   

0000000000804638 <devcons_close>:
  804638:	55                   	push   %rbp
  804639:	48 89 e5             	mov    %rsp,%rbp
  80463c:	48 83 ec 08          	sub    $0x8,%rsp
  804640:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804644:	b8 00 00 00 00       	mov    $0x0,%eax
  804649:	c9                   	leaveq 
  80464a:	c3                   	retq   

000000000080464b <devcons_stat>:
  80464b:	55                   	push   %rbp
  80464c:	48 89 e5             	mov    %rsp,%rbp
  80464f:	48 83 ec 10          	sub    $0x10,%rsp
  804653:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804657:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80465b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80465f:	48 be fa 52 80 00 00 	movabs $0x8052fa,%rsi
  804666:	00 00 00 
  804669:	48 89 c7             	mov    %rax,%rdi
  80466c:	48 b8 a8 12 80 00 00 	movabs $0x8012a8,%rax
  804673:	00 00 00 
  804676:	ff d0                	callq  *%rax
  804678:	b8 00 00 00 00       	mov    $0x0,%eax
  80467d:	c9                   	leaveq 
  80467e:	c3                   	retq   

000000000080467f <set_pgfault_handler>:
  80467f:	55                   	push   %rbp
  804680:	48 89 e5             	mov    %rsp,%rbp
  804683:	48 83 ec 20          	sub    $0x20,%rsp
  804687:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80468b:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804692:	00 00 00 
  804695:	48 8b 00             	mov    (%rax),%rax
  804698:	48 85 c0             	test   %rax,%rax
  80469b:	75 6f                	jne    80470c <set_pgfault_handler+0x8d>
  80469d:	ba 07 00 00 00       	mov    $0x7,%edx
  8046a2:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  8046a7:	bf 00 00 00 00       	mov    $0x0,%edi
  8046ac:	48 b8 d7 1b 80 00 00 	movabs $0x801bd7,%rax
  8046b3:	00 00 00 
  8046b6:	ff d0                	callq  *%rax
  8046b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8046bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8046bf:	79 30                	jns    8046f1 <set_pgfault_handler+0x72>
  8046c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8046c4:	89 c1                	mov    %eax,%ecx
  8046c6:	48 ba 08 53 80 00 00 	movabs $0x805308,%rdx
  8046cd:	00 00 00 
  8046d0:	be 22 00 00 00       	mov    $0x22,%esi
  8046d5:	48 bf 27 53 80 00 00 	movabs $0x805327,%rdi
  8046dc:	00 00 00 
  8046df:	b8 00 00 00 00       	mov    $0x0,%eax
  8046e4:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8046eb:	00 00 00 
  8046ee:	41 ff d0             	callq  *%r8
  8046f1:	48 be 1f 47 80 00 00 	movabs $0x80471f,%rsi
  8046f8:	00 00 00 
  8046fb:	bf 00 00 00 00       	mov    $0x0,%edi
  804700:	48 b8 61 1d 80 00 00 	movabs $0x801d61,%rax
  804707:	00 00 00 
  80470a:	ff d0                	callq  *%rax
  80470c:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804713:	00 00 00 
  804716:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80471a:	48 89 10             	mov    %rdx,(%rax)
  80471d:	c9                   	leaveq 
  80471e:	c3                   	retq   

000000000080471f <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  80471f:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  804722:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  804729:	00 00 00 
call *%rax
  80472c:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  80472e:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  804735:	00 08 
    movq 152(%rsp), %rax
  804737:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  80473e:	00 
    movq 136(%rsp), %rbx
  80473f:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804746:	00 
movq %rbx, (%rax)
  804747:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  80474a:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  80474e:	4c 8b 3c 24          	mov    (%rsp),%r15
  804752:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804757:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  80475c:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804761:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804766:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  80476b:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  804770:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804775:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  80477a:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  80477f:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804784:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804789:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  80478e:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  804793:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  804798:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  80479c:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  8047a0:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  8047a1:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  8047a6:	c3                   	retq   

00000000008047a7 <ipc_recv>:
  8047a7:	55                   	push   %rbp
  8047a8:	48 89 e5             	mov    %rsp,%rbp
  8047ab:	48 83 ec 30          	sub    $0x30,%rsp
  8047af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8047b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8047b7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8047bb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8047c0:	75 0e                	jne    8047d0 <ipc_recv+0x29>
  8047c2:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8047c9:	00 00 00 
  8047cc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8047d0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047d4:	48 89 c7             	mov    %rax,%rdi
  8047d7:	48 b8 00 1e 80 00 00 	movabs $0x801e00,%rax
  8047de:	00 00 00 
  8047e1:	ff d0                	callq  *%rax
  8047e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8047e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047ea:	79 27                	jns    804813 <ipc_recv+0x6c>
  8047ec:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8047f1:	74 0a                	je     8047fd <ipc_recv+0x56>
  8047f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8047f7:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8047fd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804802:	74 0a                	je     80480e <ipc_recv+0x67>
  804804:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804808:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80480e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804811:	eb 53                	jmp    804866 <ipc_recv+0xbf>
  804813:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  804818:	74 19                	je     804833 <ipc_recv+0x8c>
  80481a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804821:	00 00 00 
  804824:	48 8b 00             	mov    (%rax),%rax
  804827:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  80482d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804831:	89 10                	mov    %edx,(%rax)
  804833:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804838:	74 19                	je     804853 <ipc_recv+0xac>
  80483a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  804841:	00 00 00 
  804844:	48 8b 00             	mov    (%rax),%rax
  804847:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  80484d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804851:	89 10                	mov    %edx,(%rax)
  804853:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80485a:	00 00 00 
  80485d:	48 8b 00             	mov    (%rax),%rax
  804860:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  804866:	c9                   	leaveq 
  804867:	c3                   	retq   

0000000000804868 <ipc_send>:
  804868:	55                   	push   %rbp
  804869:	48 89 e5             	mov    %rsp,%rbp
  80486c:	48 83 ec 30          	sub    $0x30,%rsp
  804870:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804873:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804876:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  80487a:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  80487d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  804882:	75 10                	jne    804894 <ipc_send+0x2c>
  804884:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  80488b:	00 00 00 
  80488e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804892:	eb 0e                	jmp    8048a2 <ipc_send+0x3a>
  804894:	eb 0c                	jmp    8048a2 <ipc_send+0x3a>
  804896:	48 b8 99 1b 80 00 00 	movabs $0x801b99,%rax
  80489d:	00 00 00 
  8048a0:	ff d0                	callq  *%rax
  8048a2:	8b 75 e8             	mov    -0x18(%rbp),%esi
  8048a5:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8048a8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8048ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8048af:	89 c7                	mov    %eax,%edi
  8048b1:	48 b8 ab 1d 80 00 00 	movabs $0x801dab,%rax
  8048b8:	00 00 00 
  8048bb:	ff d0                	callq  *%rax
  8048bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8048c0:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  8048c4:	74 d0                	je     804896 <ipc_send+0x2e>
  8048c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8048ca:	79 30                	jns    8048fc <ipc_send+0x94>
  8048cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048cf:	89 c1                	mov    %eax,%ecx
  8048d1:	48 ba 38 53 80 00 00 	movabs $0x805338,%rdx
  8048d8:	00 00 00 
  8048db:	be 44 00 00 00       	mov    $0x44,%esi
  8048e0:	48 bf 4e 53 80 00 00 	movabs $0x80534e,%rdi
  8048e7:	00 00 00 
  8048ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8048ef:	49 b8 ba 04 80 00 00 	movabs $0x8004ba,%r8
  8048f6:	00 00 00 
  8048f9:	41 ff d0             	callq  *%r8
  8048fc:	c9                   	leaveq 
  8048fd:	c3                   	retq   

00000000008048fe <ipc_host_recv>:
  8048fe:	55                   	push   %rbp
  8048ff:	48 89 e5             	mov    %rsp,%rbp
  804902:	48 83 ec 10          	sub    $0x10,%rsp
  804906:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80490a:	48 ba 60 53 80 00 00 	movabs $0x805360,%rdx
  804911:	00 00 00 
  804914:	be 4e 00 00 00       	mov    $0x4e,%esi
  804919:	48 bf 4e 53 80 00 00 	movabs $0x80534e,%rdi
  804920:	00 00 00 
  804923:	b8 00 00 00 00       	mov    $0x0,%eax
  804928:	48 b9 ba 04 80 00 00 	movabs $0x8004ba,%rcx
  80492f:	00 00 00 
  804932:	ff d1                	callq  *%rcx

0000000000804934 <ipc_host_send>:
  804934:	55                   	push   %rbp
  804935:	48 89 e5             	mov    %rsp,%rbp
  804938:	48 83 ec 20          	sub    $0x20,%rsp
  80493c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80493f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804942:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  804946:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804949:	48 ba 80 53 80 00 00 	movabs $0x805380,%rdx
  804950:	00 00 00 
  804953:	be 67 00 00 00       	mov    $0x67,%esi
  804958:	48 bf 4e 53 80 00 00 	movabs $0x80534e,%rdi
  80495f:	00 00 00 
  804962:	b8 00 00 00 00       	mov    $0x0,%eax
  804967:	48 b9 ba 04 80 00 00 	movabs $0x8004ba,%rcx
  80496e:	00 00 00 
  804971:	ff d1                	callq  *%rcx

0000000000804973 <ipc_find_env>:
  804973:	55                   	push   %rbp
  804974:	48 89 e5             	mov    %rsp,%rbp
  804977:	48 83 ec 14          	sub    $0x14,%rsp
  80497b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80497e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804985:	eb 4e                	jmp    8049d5 <ipc_find_env+0x62>
  804987:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80498e:	00 00 00 
  804991:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804994:	48 98                	cltq   
  804996:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80499d:	48 01 d0             	add    %rdx,%rax
  8049a0:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8049a6:	8b 00                	mov    (%rax),%eax
  8049a8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8049ab:	75 24                	jne    8049d1 <ipc_find_env+0x5e>
  8049ad:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8049b4:	00 00 00 
  8049b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049ba:	48 98                	cltq   
  8049bc:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8049c3:	48 01 d0             	add    %rdx,%rax
  8049c6:	48 05 c0 00 00 00    	add    $0xc0,%rax
  8049cc:	8b 40 08             	mov    0x8(%rax),%eax
  8049cf:	eb 12                	jmp    8049e3 <ipc_find_env+0x70>
  8049d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8049d5:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  8049dc:	7e a9                	jle    804987 <ipc_find_env+0x14>
  8049de:	b8 00 00 00 00       	mov    $0x0,%eax
  8049e3:	c9                   	leaveq 
  8049e4:	c3                   	retq   

00000000008049e5 <pageref>:
  8049e5:	55                   	push   %rbp
  8049e6:	48 89 e5             	mov    %rsp,%rbp
  8049e9:	48 83 ec 18          	sub    $0x18,%rsp
  8049ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8049f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8049f5:	48 c1 e8 15          	shr    $0x15,%rax
  8049f9:	48 89 c2             	mov    %rax,%rdx
  8049fc:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804a03:	01 00 00 
  804a06:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804a0a:	83 e0 01             	and    $0x1,%eax
  804a0d:	48 85 c0             	test   %rax,%rax
  804a10:	75 07                	jne    804a19 <pageref+0x34>
  804a12:	b8 00 00 00 00       	mov    $0x0,%eax
  804a17:	eb 53                	jmp    804a6c <pageref+0x87>
  804a19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804a1d:	48 c1 e8 0c          	shr    $0xc,%rax
  804a21:	48 89 c2             	mov    %rax,%rdx
  804a24:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804a2b:	01 00 00 
  804a2e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804a32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804a36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a3a:	83 e0 01             	and    $0x1,%eax
  804a3d:	48 85 c0             	test   %rax,%rax
  804a40:	75 07                	jne    804a49 <pageref+0x64>
  804a42:	b8 00 00 00 00       	mov    $0x0,%eax
  804a47:	eb 23                	jmp    804a6c <pageref+0x87>
  804a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a4d:	48 c1 e8 0c          	shr    $0xc,%rax
  804a51:	48 89 c2             	mov    %rax,%rdx
  804a54:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804a5b:	00 00 00 
  804a5e:	48 c1 e2 04          	shl    $0x4,%rdx
  804a62:	48 01 d0             	add    %rdx,%rax
  804a65:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804a69:	0f b7 c0             	movzwl %ax,%eax
  804a6c:	c9                   	leaveq 
  804a6d:	c3                   	retq   
