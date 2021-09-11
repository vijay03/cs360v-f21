
vmm/guest/obj/user/echo:     file format elf64-x86-64


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
  80003c:	e8 11 01 00 00       	callq  800152 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 20          	sub    $0x20,%rsp
  80004b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80004e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800052:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  800059:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  80005d:	7e 38                	jle    800097 <umain+0x54>
  80005f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800063:	48 83 c0 08          	add    $0x8,%rax
  800067:	48 8b 00             	mov    (%rax),%rax
  80006a:	48 be 80 40 80 00 00 	movabs $0x804080,%rsi
  800071:	00 00 00 
  800074:	48 89 c7             	mov    %rax,%rdi
  800077:	48 b8 c6 03 80 00 00 	movabs $0x8003c6,%rax
  80007e:	00 00 00 
  800081:	ff d0                	callq  *%rax
  800083:	85 c0                	test   %eax,%eax
  800085:	75 10                	jne    800097 <umain+0x54>
  800087:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
  80008e:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
  800092:	48 83 45 e0 08       	addq   $0x8,-0x20(%rbp)
  800097:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  80009e:	eb 7e                	jmp    80011e <umain+0xdb>
  8000a0:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
  8000a4:	7e 20                	jle    8000c6 <umain+0x83>
  8000a6:	ba 01 00 00 00       	mov    $0x1,%edx
  8000ab:	48 be 83 40 80 00 00 	movabs $0x804083,%rsi
  8000b2:	00 00 00 
  8000b5:	bf 01 00 00 00       	mov    $0x1,%edi
  8000ba:	48 b8 d5 15 80 00 00 	movabs $0x8015d5,%rax
  8000c1:	00 00 00 
  8000c4:	ff d0                	callq  *%rax
  8000c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000c9:	48 98                	cltq   
  8000cb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8000d2:	00 
  8000d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8000d7:	48 01 d0             	add    %rdx,%rax
  8000da:	48 8b 00             	mov    (%rax),%rax
  8000dd:	48 89 c7             	mov    %rax,%rdi
  8000e0:	48 b8 f8 01 80 00 00 	movabs $0x8001f8,%rax
  8000e7:	00 00 00 
  8000ea:	ff d0                	callq  *%rax
  8000ec:	48 63 d0             	movslq %eax,%rdx
  8000ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000f2:	48 98                	cltq   
  8000f4:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
  8000fb:	00 
  8000fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800100:	48 01 c8             	add    %rcx,%rax
  800103:	48 8b 00             	mov    (%rax),%rax
  800106:	48 89 c6             	mov    %rax,%rsi
  800109:	bf 01 00 00 00       	mov    $0x1,%edi
  80010e:	48 b8 d5 15 80 00 00 	movabs $0x8015d5,%rax
  800115:	00 00 00 
  800118:	ff d0                	callq  *%rax
  80011a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80011e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800121:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  800124:	0f 8c 76 ff ff ff    	jl     8000a0 <umain+0x5d>
  80012a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80012e:	75 20                	jne    800150 <umain+0x10d>
  800130:	ba 01 00 00 00       	mov    $0x1,%edx
  800135:	48 be 85 40 80 00 00 	movabs $0x804085,%rsi
  80013c:	00 00 00 
  80013f:	bf 01 00 00 00       	mov    $0x1,%edi
  800144:	48 b8 d5 15 80 00 00 	movabs $0x8015d5,%rax
  80014b:	00 00 00 
  80014e:	ff d0                	callq  *%rax
  800150:	c9                   	leaveq 
  800151:	c3                   	retq   

0000000000800152 <libmain>:
  800152:	55                   	push   %rbp
  800153:	48 89 e5             	mov    %rsp,%rbp
  800156:	48 83 ec 10          	sub    $0x10,%rsp
  80015a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80015d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800161:	48 b8 17 0b 80 00 00 	movabs $0x800b17,%rax
  800168:	00 00 00 
  80016b:	ff d0                	callq  *%rax
  80016d:	25 ff 03 00 00       	and    $0x3ff,%eax
  800172:	48 98                	cltq   
  800174:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80017b:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800182:	00 00 00 
  800185:	48 01 c2             	add    %rax,%rdx
  800188:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80018f:	00 00 00 
  800192:	48 89 10             	mov    %rdx,(%rax)
  800195:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800199:	7e 14                	jle    8001af <libmain+0x5d>
  80019b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80019f:	48 8b 10             	mov    (%rax),%rdx
  8001a2:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8001a9:	00 00 00 
  8001ac:	48 89 10             	mov    %rdx,(%rax)
  8001af:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8001b6:	48 89 d6             	mov    %rdx,%rsi
  8001b9:	89 c7                	mov    %eax,%edi
  8001bb:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8001c2:	00 00 00 
  8001c5:	ff d0                	callq  *%rax
  8001c7:	48 b8 d5 01 80 00 00 	movabs $0x8001d5,%rax
  8001ce:	00 00 00 
  8001d1:	ff d0                	callq  *%rax
  8001d3:	c9                   	leaveq 
  8001d4:	c3                   	retq   

00000000008001d5 <exit>:
  8001d5:	55                   	push   %rbp
  8001d6:	48 89 e5             	mov    %rsp,%rbp
  8001d9:	48 b8 b4 12 80 00 00 	movabs $0x8012b4,%rax
  8001e0:	00 00 00 
  8001e3:	ff d0                	callq  *%rax
  8001e5:	bf 00 00 00 00       	mov    $0x0,%edi
  8001ea:	48 b8 d3 0a 80 00 00 	movabs $0x800ad3,%rax
  8001f1:	00 00 00 
  8001f4:	ff d0                	callq  *%rax
  8001f6:	5d                   	pop    %rbp
  8001f7:	c3                   	retq   

00000000008001f8 <strlen>:
  8001f8:	55                   	push   %rbp
  8001f9:	48 89 e5             	mov    %rsp,%rbp
  8001fc:	48 83 ec 18          	sub    $0x18,%rsp
  800200:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800204:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80020b:	eb 09                	jmp    800216 <strlen+0x1e>
  80020d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800211:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80021a:	0f b6 00             	movzbl (%rax),%eax
  80021d:	84 c0                	test   %al,%al
  80021f:	75 ec                	jne    80020d <strlen+0x15>
  800221:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800224:	c9                   	leaveq 
  800225:	c3                   	retq   

0000000000800226 <strnlen>:
  800226:	55                   	push   %rbp
  800227:	48 89 e5             	mov    %rsp,%rbp
  80022a:	48 83 ec 20          	sub    $0x20,%rsp
  80022e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800232:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800236:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80023d:	eb 0e                	jmp    80024d <strnlen+0x27>
  80023f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800243:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800248:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  80024d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800252:	74 0b                	je     80025f <strnlen+0x39>
  800254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800258:	0f b6 00             	movzbl (%rax),%eax
  80025b:	84 c0                	test   %al,%al
  80025d:	75 e0                	jne    80023f <strnlen+0x19>
  80025f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800262:	c9                   	leaveq 
  800263:	c3                   	retq   

0000000000800264 <strcpy>:
  800264:	55                   	push   %rbp
  800265:	48 89 e5             	mov    %rsp,%rbp
  800268:	48 83 ec 20          	sub    $0x20,%rsp
  80026c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800270:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800274:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800278:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80027c:	90                   	nop
  80027d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800281:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800285:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800289:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80028d:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800291:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800295:	0f b6 12             	movzbl (%rdx),%edx
  800298:	88 10                	mov    %dl,(%rax)
  80029a:	0f b6 00             	movzbl (%rax),%eax
  80029d:	84 c0                	test   %al,%al
  80029f:	75 dc                	jne    80027d <strcpy+0x19>
  8002a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8002a5:	c9                   	leaveq 
  8002a6:	c3                   	retq   

00000000008002a7 <strcat>:
  8002a7:	55                   	push   %rbp
  8002a8:	48 89 e5             	mov    %rsp,%rbp
  8002ab:	48 83 ec 20          	sub    $0x20,%rsp
  8002af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8002b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8002b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8002bb:	48 89 c7             	mov    %rax,%rdi
  8002be:	48 b8 f8 01 80 00 00 	movabs $0x8001f8,%rax
  8002c5:	00 00 00 
  8002c8:	ff d0                	callq  *%rax
  8002ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8002cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002d0:	48 63 d0             	movslq %eax,%rdx
  8002d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8002d7:	48 01 c2             	add    %rax,%rdx
  8002da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8002de:	48 89 c6             	mov    %rax,%rsi
  8002e1:	48 89 d7             	mov    %rdx,%rdi
  8002e4:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  8002eb:	00 00 00 
  8002ee:	ff d0                	callq  *%rax
  8002f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8002f4:	c9                   	leaveq 
  8002f5:	c3                   	retq   

00000000008002f6 <strncpy>:
  8002f6:	55                   	push   %rbp
  8002f7:	48 89 e5             	mov    %rsp,%rbp
  8002fa:	48 83 ec 28          	sub    $0x28,%rsp
  8002fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800302:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800306:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80030a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80030e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800312:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  800319:	00 
  80031a:	eb 2a                	jmp    800346 <strncpy+0x50>
  80031c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800320:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800324:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800328:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80032c:	0f b6 12             	movzbl (%rdx),%edx
  80032f:	88 10                	mov    %dl,(%rax)
  800331:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800335:	0f b6 00             	movzbl (%rax),%eax
  800338:	84 c0                	test   %al,%al
  80033a:	74 05                	je     800341 <strncpy+0x4b>
  80033c:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  800341:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800346:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80034a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80034e:	72 cc                	jb     80031c <strncpy+0x26>
  800350:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800354:	c9                   	leaveq 
  800355:	c3                   	retq   

0000000000800356 <strlcpy>:
  800356:	55                   	push   %rbp
  800357:	48 89 e5             	mov    %rsp,%rbp
  80035a:	48 83 ec 28          	sub    $0x28,%rsp
  80035e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800362:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800366:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80036a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80036e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800372:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  800377:	74 3d                	je     8003b6 <strlcpy+0x60>
  800379:	eb 1d                	jmp    800398 <strlcpy+0x42>
  80037b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80037f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800383:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800387:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80038b:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80038f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800393:	0f b6 12             	movzbl (%rdx),%edx
  800396:	88 10                	mov    %dl,(%rax)
  800398:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  80039d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8003a2:	74 0b                	je     8003af <strlcpy+0x59>
  8003a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8003a8:	0f b6 00             	movzbl (%rax),%eax
  8003ab:	84 c0                	test   %al,%al
  8003ad:	75 cc                	jne    80037b <strlcpy+0x25>
  8003af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8003b3:	c6 00 00             	movb   $0x0,(%rax)
  8003b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8003ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8003be:	48 29 c2             	sub    %rax,%rdx
  8003c1:	48 89 d0             	mov    %rdx,%rax
  8003c4:	c9                   	leaveq 
  8003c5:	c3                   	retq   

00000000008003c6 <strcmp>:
  8003c6:	55                   	push   %rbp
  8003c7:	48 89 e5             	mov    %rsp,%rbp
  8003ca:	48 83 ec 10          	sub    $0x10,%rsp
  8003ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8003d2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8003d6:	eb 0a                	jmp    8003e2 <strcmp+0x1c>
  8003d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8003dd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8003e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8003e6:	0f b6 00             	movzbl (%rax),%eax
  8003e9:	84 c0                	test   %al,%al
  8003eb:	74 12                	je     8003ff <strcmp+0x39>
  8003ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8003f1:	0f b6 10             	movzbl (%rax),%edx
  8003f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8003f8:	0f b6 00             	movzbl (%rax),%eax
  8003fb:	38 c2                	cmp    %al,%dl
  8003fd:	74 d9                	je     8003d8 <strcmp+0x12>
  8003ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800403:	0f b6 00             	movzbl (%rax),%eax
  800406:	0f b6 d0             	movzbl %al,%edx
  800409:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80040d:	0f b6 00             	movzbl (%rax),%eax
  800410:	0f b6 c0             	movzbl %al,%eax
  800413:	29 c2                	sub    %eax,%edx
  800415:	89 d0                	mov    %edx,%eax
  800417:	c9                   	leaveq 
  800418:	c3                   	retq   

0000000000800419 <strncmp>:
  800419:	55                   	push   %rbp
  80041a:	48 89 e5             	mov    %rsp,%rbp
  80041d:	48 83 ec 18          	sub    $0x18,%rsp
  800421:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800425:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800429:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80042d:	eb 0f                	jmp    80043e <strncmp+0x25>
  80042f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  800434:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  800439:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80043e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800443:	74 1d                	je     800462 <strncmp+0x49>
  800445:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800449:	0f b6 00             	movzbl (%rax),%eax
  80044c:	84 c0                	test   %al,%al
  80044e:	74 12                	je     800462 <strncmp+0x49>
  800450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800454:	0f b6 10             	movzbl (%rax),%edx
  800457:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80045b:	0f b6 00             	movzbl (%rax),%eax
  80045e:	38 c2                	cmp    %al,%dl
  800460:	74 cd                	je     80042f <strncmp+0x16>
  800462:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800467:	75 07                	jne    800470 <strncmp+0x57>
  800469:	b8 00 00 00 00       	mov    $0x0,%eax
  80046e:	eb 18                	jmp    800488 <strncmp+0x6f>
  800470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800474:	0f b6 00             	movzbl (%rax),%eax
  800477:	0f b6 d0             	movzbl %al,%edx
  80047a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80047e:	0f b6 00             	movzbl (%rax),%eax
  800481:	0f b6 c0             	movzbl %al,%eax
  800484:	29 c2                	sub    %eax,%edx
  800486:	89 d0                	mov    %edx,%eax
  800488:	c9                   	leaveq 
  800489:	c3                   	retq   

000000000080048a <strchr>:
  80048a:	55                   	push   %rbp
  80048b:	48 89 e5             	mov    %rsp,%rbp
  80048e:	48 83 ec 0c          	sub    $0xc,%rsp
  800492:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800496:	89 f0                	mov    %esi,%eax
  800498:	88 45 f4             	mov    %al,-0xc(%rbp)
  80049b:	eb 17                	jmp    8004b4 <strchr+0x2a>
  80049d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004a1:	0f b6 00             	movzbl (%rax),%eax
  8004a4:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8004a7:	75 06                	jne    8004af <strchr+0x25>
  8004a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004ad:	eb 15                	jmp    8004c4 <strchr+0x3a>
  8004af:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8004b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004b8:	0f b6 00             	movzbl (%rax),%eax
  8004bb:	84 c0                	test   %al,%al
  8004bd:	75 de                	jne    80049d <strchr+0x13>
  8004bf:	b8 00 00 00 00       	mov    $0x0,%eax
  8004c4:	c9                   	leaveq 
  8004c5:	c3                   	retq   

00000000008004c6 <strfind>:
  8004c6:	55                   	push   %rbp
  8004c7:	48 89 e5             	mov    %rsp,%rbp
  8004ca:	48 83 ec 0c          	sub    $0xc,%rsp
  8004ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8004d2:	89 f0                	mov    %esi,%eax
  8004d4:	88 45 f4             	mov    %al,-0xc(%rbp)
  8004d7:	eb 13                	jmp    8004ec <strfind+0x26>
  8004d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004dd:	0f b6 00             	movzbl (%rax),%eax
  8004e0:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8004e3:	75 02                	jne    8004e7 <strfind+0x21>
  8004e5:	eb 10                	jmp    8004f7 <strfind+0x31>
  8004e7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8004ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004f0:	0f b6 00             	movzbl (%rax),%eax
  8004f3:	84 c0                	test   %al,%al
  8004f5:	75 e2                	jne    8004d9 <strfind+0x13>
  8004f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8004fb:	c9                   	leaveq 
  8004fc:	c3                   	retq   

00000000008004fd <memset>:
  8004fd:	55                   	push   %rbp
  8004fe:	48 89 e5             	mov    %rsp,%rbp
  800501:	48 83 ec 18          	sub    $0x18,%rsp
  800505:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800509:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80050c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800510:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800515:	75 06                	jne    80051d <memset+0x20>
  800517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80051b:	eb 69                	jmp    800586 <memset+0x89>
  80051d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800521:	83 e0 03             	and    $0x3,%eax
  800524:	48 85 c0             	test   %rax,%rax
  800527:	75 48                	jne    800571 <memset+0x74>
  800529:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80052d:	83 e0 03             	and    $0x3,%eax
  800530:	48 85 c0             	test   %rax,%rax
  800533:	75 3c                	jne    800571 <memset+0x74>
  800535:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80053c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80053f:	c1 e0 18             	shl    $0x18,%eax
  800542:	89 c2                	mov    %eax,%edx
  800544:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800547:	c1 e0 10             	shl    $0x10,%eax
  80054a:	09 c2                	or     %eax,%edx
  80054c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80054f:	c1 e0 08             	shl    $0x8,%eax
  800552:	09 d0                	or     %edx,%eax
  800554:	09 45 f4             	or     %eax,-0xc(%rbp)
  800557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80055b:	48 c1 e8 02          	shr    $0x2,%rax
  80055f:	48 89 c1             	mov    %rax,%rcx
  800562:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800566:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800569:	48 89 d7             	mov    %rdx,%rdi
  80056c:	fc                   	cld    
  80056d:	f3 ab                	rep stos %eax,%es:(%rdi)
  80056f:	eb 11                	jmp    800582 <memset+0x85>
  800571:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800575:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800578:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80057c:	48 89 d7             	mov    %rdx,%rdi
  80057f:	fc                   	cld    
  800580:	f3 aa                	rep stos %al,%es:(%rdi)
  800582:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800586:	c9                   	leaveq 
  800587:	c3                   	retq   

0000000000800588 <memmove>:
  800588:	55                   	push   %rbp
  800589:	48 89 e5             	mov    %rsp,%rbp
  80058c:	48 83 ec 28          	sub    $0x28,%rsp
  800590:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800594:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800598:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80059c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8005a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8005ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005b0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8005b4:	0f 83 88 00 00 00    	jae    800642 <memmove+0xba>
  8005ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005be:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8005c2:	48 01 d0             	add    %rdx,%rax
  8005c5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8005c9:	76 77                	jbe    800642 <memmove+0xba>
  8005cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005cf:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8005d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005d7:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8005db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005df:	83 e0 03             	and    $0x3,%eax
  8005e2:	48 85 c0             	test   %rax,%rax
  8005e5:	75 3b                	jne    800622 <memmove+0x9a>
  8005e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005eb:	83 e0 03             	and    $0x3,%eax
  8005ee:	48 85 c0             	test   %rax,%rax
  8005f1:	75 2f                	jne    800622 <memmove+0x9a>
  8005f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8005f7:	83 e0 03             	and    $0x3,%eax
  8005fa:	48 85 c0             	test   %rax,%rax
  8005fd:	75 23                	jne    800622 <memmove+0x9a>
  8005ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800603:	48 83 e8 04          	sub    $0x4,%rax
  800607:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80060b:	48 83 ea 04          	sub    $0x4,%rdx
  80060f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  800613:	48 c1 e9 02          	shr    $0x2,%rcx
  800617:	48 89 c7             	mov    %rax,%rdi
  80061a:	48 89 d6             	mov    %rdx,%rsi
  80061d:	fd                   	std    
  80061e:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  800620:	eb 1d                	jmp    80063f <memmove+0xb7>
  800622:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800626:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80062a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80062e:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  800632:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800636:	48 89 d7             	mov    %rdx,%rdi
  800639:	48 89 c1             	mov    %rax,%rcx
  80063c:	fd                   	std    
  80063d:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80063f:	fc                   	cld    
  800640:	eb 57                	jmp    800699 <memmove+0x111>
  800642:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800646:	83 e0 03             	and    $0x3,%eax
  800649:	48 85 c0             	test   %rax,%rax
  80064c:	75 36                	jne    800684 <memmove+0xfc>
  80064e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800652:	83 e0 03             	and    $0x3,%eax
  800655:	48 85 c0             	test   %rax,%rax
  800658:	75 2a                	jne    800684 <memmove+0xfc>
  80065a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80065e:	83 e0 03             	and    $0x3,%eax
  800661:	48 85 c0             	test   %rax,%rax
  800664:	75 1e                	jne    800684 <memmove+0xfc>
  800666:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80066a:	48 c1 e8 02          	shr    $0x2,%rax
  80066e:	48 89 c1             	mov    %rax,%rcx
  800671:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800675:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800679:	48 89 c7             	mov    %rax,%rdi
  80067c:	48 89 d6             	mov    %rdx,%rsi
  80067f:	fc                   	cld    
  800680:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  800682:	eb 15                	jmp    800699 <memmove+0x111>
  800684:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800688:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80068c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  800690:	48 89 c7             	mov    %rax,%rdi
  800693:	48 89 d6             	mov    %rdx,%rsi
  800696:	fc                   	cld    
  800697:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  800699:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80069d:	c9                   	leaveq 
  80069e:	c3                   	retq   

000000000080069f <memcpy>:
  80069f:	55                   	push   %rbp
  8006a0:	48 89 e5             	mov    %rsp,%rbp
  8006a3:	48 83 ec 18          	sub    $0x18,%rsp
  8006a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8006ab:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8006af:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8006b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006b7:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8006bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006bf:	48 89 ce             	mov    %rcx,%rsi
  8006c2:	48 89 c7             	mov    %rax,%rdi
  8006c5:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  8006cc:	00 00 00 
  8006cf:	ff d0                	callq  *%rax
  8006d1:	c9                   	leaveq 
  8006d2:	c3                   	retq   

00000000008006d3 <memcmp>:
  8006d3:	55                   	push   %rbp
  8006d4:	48 89 e5             	mov    %rsp,%rbp
  8006d7:	48 83 ec 28          	sub    $0x28,%rsp
  8006db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8006df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8006e3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8006e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8006f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8006f7:	eb 36                	jmp    80072f <memcmp+0x5c>
  8006f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006fd:	0f b6 10             	movzbl (%rax),%edx
  800700:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800704:	0f b6 00             	movzbl (%rax),%eax
  800707:	38 c2                	cmp    %al,%dl
  800709:	74 1a                	je     800725 <memcmp+0x52>
  80070b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80070f:	0f b6 00             	movzbl (%rax),%eax
  800712:	0f b6 d0             	movzbl %al,%edx
  800715:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800719:	0f b6 00             	movzbl (%rax),%eax
  80071c:	0f b6 c0             	movzbl %al,%eax
  80071f:	29 c2                	sub    %eax,%edx
  800721:	89 d0                	mov    %edx,%eax
  800723:	eb 20                	jmp    800745 <memcmp+0x72>
  800725:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80072a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80072f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800733:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800737:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80073b:	48 85 c0             	test   %rax,%rax
  80073e:	75 b9                	jne    8006f9 <memcmp+0x26>
  800740:	b8 00 00 00 00       	mov    $0x0,%eax
  800745:	c9                   	leaveq 
  800746:	c3                   	retq   

0000000000800747 <memfind>:
  800747:	55                   	push   %rbp
  800748:	48 89 e5             	mov    %rsp,%rbp
  80074b:	48 83 ec 28          	sub    $0x28,%rsp
  80074f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800753:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800756:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80075a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80075e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800762:	48 01 d0             	add    %rdx,%rax
  800765:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800769:	eb 15                	jmp    800780 <memfind+0x39>
  80076b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80076f:	0f b6 10             	movzbl (%rax),%edx
  800772:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800775:	38 c2                	cmp    %al,%dl
  800777:	75 02                	jne    80077b <memfind+0x34>
  800779:	eb 0f                	jmp    80078a <memfind+0x43>
  80077b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800780:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800784:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  800788:	72 e1                	jb     80076b <memfind+0x24>
  80078a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80078e:	c9                   	leaveq 
  80078f:	c3                   	retq   

0000000000800790 <strtol>:
  800790:	55                   	push   %rbp
  800791:	48 89 e5             	mov    %rsp,%rbp
  800794:	48 83 ec 34          	sub    $0x34,%rsp
  800798:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80079c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8007a0:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8007a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8007aa:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8007b1:	00 
  8007b2:	eb 05                	jmp    8007b9 <strtol+0x29>
  8007b4:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8007b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007bd:	0f b6 00             	movzbl (%rax),%eax
  8007c0:	3c 20                	cmp    $0x20,%al
  8007c2:	74 f0                	je     8007b4 <strtol+0x24>
  8007c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007c8:	0f b6 00             	movzbl (%rax),%eax
  8007cb:	3c 09                	cmp    $0x9,%al
  8007cd:	74 e5                	je     8007b4 <strtol+0x24>
  8007cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007d3:	0f b6 00             	movzbl (%rax),%eax
  8007d6:	3c 2b                	cmp    $0x2b,%al
  8007d8:	75 07                	jne    8007e1 <strtol+0x51>
  8007da:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8007df:	eb 17                	jmp    8007f8 <strtol+0x68>
  8007e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8007e5:	0f b6 00             	movzbl (%rax),%eax
  8007e8:	3c 2d                	cmp    $0x2d,%al
  8007ea:	75 0c                	jne    8007f8 <strtol+0x68>
  8007ec:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8007f1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8007f8:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8007fc:	74 06                	je     800804 <strtol+0x74>
  8007fe:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  800802:	75 28                	jne    80082c <strtol+0x9c>
  800804:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800808:	0f b6 00             	movzbl (%rax),%eax
  80080b:	3c 30                	cmp    $0x30,%al
  80080d:	75 1d                	jne    80082c <strtol+0x9c>
  80080f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800813:	48 83 c0 01          	add    $0x1,%rax
  800817:	0f b6 00             	movzbl (%rax),%eax
  80081a:	3c 78                	cmp    $0x78,%al
  80081c:	75 0e                	jne    80082c <strtol+0x9c>
  80081e:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  800823:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  80082a:	eb 2c                	jmp    800858 <strtol+0xc8>
  80082c:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  800830:	75 19                	jne    80084b <strtol+0xbb>
  800832:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800836:	0f b6 00             	movzbl (%rax),%eax
  800839:	3c 30                	cmp    $0x30,%al
  80083b:	75 0e                	jne    80084b <strtol+0xbb>
  80083d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  800842:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  800849:	eb 0d                	jmp    800858 <strtol+0xc8>
  80084b:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80084f:	75 07                	jne    800858 <strtol+0xc8>
  800851:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  800858:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80085c:	0f b6 00             	movzbl (%rax),%eax
  80085f:	3c 2f                	cmp    $0x2f,%al
  800861:	7e 1d                	jle    800880 <strtol+0xf0>
  800863:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800867:	0f b6 00             	movzbl (%rax),%eax
  80086a:	3c 39                	cmp    $0x39,%al
  80086c:	7f 12                	jg     800880 <strtol+0xf0>
  80086e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800872:	0f b6 00             	movzbl (%rax),%eax
  800875:	0f be c0             	movsbl %al,%eax
  800878:	83 e8 30             	sub    $0x30,%eax
  80087b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80087e:	eb 4e                	jmp    8008ce <strtol+0x13e>
  800880:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800884:	0f b6 00             	movzbl (%rax),%eax
  800887:	3c 60                	cmp    $0x60,%al
  800889:	7e 1d                	jle    8008a8 <strtol+0x118>
  80088b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80088f:	0f b6 00             	movzbl (%rax),%eax
  800892:	3c 7a                	cmp    $0x7a,%al
  800894:	7f 12                	jg     8008a8 <strtol+0x118>
  800896:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80089a:	0f b6 00             	movzbl (%rax),%eax
  80089d:	0f be c0             	movsbl %al,%eax
  8008a0:	83 e8 57             	sub    $0x57,%eax
  8008a3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8008a6:	eb 26                	jmp    8008ce <strtol+0x13e>
  8008a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008ac:	0f b6 00             	movzbl (%rax),%eax
  8008af:	3c 40                	cmp    $0x40,%al
  8008b1:	7e 48                	jle    8008fb <strtol+0x16b>
  8008b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008b7:	0f b6 00             	movzbl (%rax),%eax
  8008ba:	3c 5a                	cmp    $0x5a,%al
  8008bc:	7f 3d                	jg     8008fb <strtol+0x16b>
  8008be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008c2:	0f b6 00             	movzbl (%rax),%eax
  8008c5:	0f be c0             	movsbl %al,%eax
  8008c8:	83 e8 37             	sub    $0x37,%eax
  8008cb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8008ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8008d1:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  8008d4:	7c 02                	jl     8008d8 <strtol+0x148>
  8008d6:	eb 23                	jmp    8008fb <strtol+0x16b>
  8008d8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8008dd:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8008e0:	48 98                	cltq   
  8008e2:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  8008e7:	48 89 c2             	mov    %rax,%rdx
  8008ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8008ed:	48 98                	cltq   
  8008ef:	48 01 d0             	add    %rdx,%rax
  8008f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8008f6:	e9 5d ff ff ff       	jmpq   800858 <strtol+0xc8>
  8008fb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  800900:	74 0b                	je     80090d <strtol+0x17d>
  800902:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800906:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80090a:	48 89 10             	mov    %rdx,(%rax)
  80090d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800911:	74 09                	je     80091c <strtol+0x18c>
  800913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800917:	48 f7 d8             	neg    %rax
  80091a:	eb 04                	jmp    800920 <strtol+0x190>
  80091c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800920:	c9                   	leaveq 
  800921:	c3                   	retq   

0000000000800922 <strstr>:
  800922:	55                   	push   %rbp
  800923:	48 89 e5             	mov    %rsp,%rbp
  800926:	48 83 ec 30          	sub    $0x30,%rsp
  80092a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80092e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  800932:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800936:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80093a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80093e:	0f b6 00             	movzbl (%rax),%eax
  800941:	88 45 ff             	mov    %al,-0x1(%rbp)
  800944:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  800948:	75 06                	jne    800950 <strstr+0x2e>
  80094a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80094e:	eb 6b                	jmp    8009bb <strstr+0x99>
  800950:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800954:	48 89 c7             	mov    %rax,%rdi
  800957:	48 b8 f8 01 80 00 00 	movabs $0x8001f8,%rax
  80095e:	00 00 00 
  800961:	ff d0                	callq  *%rax
  800963:	48 98                	cltq   
  800965:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800969:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80096d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800971:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800975:	0f b6 00             	movzbl (%rax),%eax
  800978:	88 45 ef             	mov    %al,-0x11(%rbp)
  80097b:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  80097f:	75 07                	jne    800988 <strstr+0x66>
  800981:	b8 00 00 00 00       	mov    $0x0,%eax
  800986:	eb 33                	jmp    8009bb <strstr+0x99>
  800988:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80098c:	3a 45 ff             	cmp    -0x1(%rbp),%al
  80098f:	75 d8                	jne    800969 <strstr+0x47>
  800991:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800995:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  800999:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80099d:	48 89 ce             	mov    %rcx,%rsi
  8009a0:	48 89 c7             	mov    %rax,%rdi
  8009a3:	48 b8 19 04 80 00 00 	movabs $0x800419,%rax
  8009aa:	00 00 00 
  8009ad:	ff d0                	callq  *%rax
  8009af:	85 c0                	test   %eax,%eax
  8009b1:	75 b6                	jne    800969 <strstr+0x47>
  8009b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8009b7:	48 83 e8 01          	sub    $0x1,%rax
  8009bb:	c9                   	leaveq 
  8009bc:	c3                   	retq   

00000000008009bd <syscall>:
  8009bd:	55                   	push   %rbp
  8009be:	48 89 e5             	mov    %rsp,%rbp
  8009c1:	53                   	push   %rbx
  8009c2:	48 83 ec 48          	sub    $0x48,%rsp
  8009c6:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8009c9:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8009cc:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8009d0:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  8009d4:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  8009d8:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  8009dc:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8009df:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  8009e3:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  8009e7:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  8009eb:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  8009ef:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  8009f3:	4c 89 c3             	mov    %r8,%rbx
  8009f6:	cd 30                	int    $0x30
  8009f8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8009fc:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800a00:	74 3e                	je     800a40 <syscall+0x83>
  800a02:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800a07:	7e 37                	jle    800a40 <syscall+0x83>
  800a09:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a0d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800a10:	49 89 d0             	mov    %rdx,%r8
  800a13:	89 c1                	mov    %eax,%ecx
  800a15:	48 ba 91 40 80 00 00 	movabs $0x804091,%rdx
  800a1c:	00 00 00 
  800a1f:	be 24 00 00 00       	mov    $0x24,%esi
  800a24:	48 bf ae 40 80 00 00 	movabs $0x8040ae,%rdi
  800a2b:	00 00 00 
  800a2e:	b8 00 00 00 00       	mov    $0x0,%eax
  800a33:	49 b9 26 30 80 00 00 	movabs $0x803026,%r9
  800a3a:	00 00 00 
  800a3d:	41 ff d1             	callq  *%r9
  800a40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a44:	48 83 c4 48          	add    $0x48,%rsp
  800a48:	5b                   	pop    %rbx
  800a49:	5d                   	pop    %rbp
  800a4a:	c3                   	retq   

0000000000800a4b <sys_cputs>:
  800a4b:	55                   	push   %rbp
  800a4c:	48 89 e5             	mov    %rsp,%rbp
  800a4f:	48 83 ec 20          	sub    $0x20,%rsp
  800a53:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800a57:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800a5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800a5f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800a63:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800a6a:	00 
  800a6b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800a71:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800a77:	48 89 d1             	mov    %rdx,%rcx
  800a7a:	48 89 c2             	mov    %rax,%rdx
  800a7d:	be 00 00 00 00       	mov    $0x0,%esi
  800a82:	bf 00 00 00 00       	mov    $0x0,%edi
  800a87:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800a8e:	00 00 00 
  800a91:	ff d0                	callq  *%rax
  800a93:	c9                   	leaveq 
  800a94:	c3                   	retq   

0000000000800a95 <sys_cgetc>:
  800a95:	55                   	push   %rbp
  800a96:	48 89 e5             	mov    %rsp,%rbp
  800a99:	48 83 ec 10          	sub    $0x10,%rsp
  800a9d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800aa4:	00 
  800aa5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800aab:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800ab1:	b9 00 00 00 00       	mov    $0x0,%ecx
  800ab6:	ba 00 00 00 00       	mov    $0x0,%edx
  800abb:	be 00 00 00 00       	mov    $0x0,%esi
  800ac0:	bf 01 00 00 00       	mov    $0x1,%edi
  800ac5:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800acc:	00 00 00 
  800acf:	ff d0                	callq  *%rax
  800ad1:	c9                   	leaveq 
  800ad2:	c3                   	retq   

0000000000800ad3 <sys_env_destroy>:
  800ad3:	55                   	push   %rbp
  800ad4:	48 89 e5             	mov    %rsp,%rbp
  800ad7:	48 83 ec 10          	sub    $0x10,%rsp
  800adb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800ade:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ae1:	48 98                	cltq   
  800ae3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800aea:	00 
  800aeb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800af1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800af7:	b9 00 00 00 00       	mov    $0x0,%ecx
  800afc:	48 89 c2             	mov    %rax,%rdx
  800aff:	be 01 00 00 00       	mov    $0x1,%esi
  800b04:	bf 03 00 00 00       	mov    $0x3,%edi
  800b09:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800b10:	00 00 00 
  800b13:	ff d0                	callq  *%rax
  800b15:	c9                   	leaveq 
  800b16:	c3                   	retq   

0000000000800b17 <sys_getenvid>:
  800b17:	55                   	push   %rbp
  800b18:	48 89 e5             	mov    %rsp,%rbp
  800b1b:	48 83 ec 10          	sub    $0x10,%rsp
  800b1f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800b26:	00 
  800b27:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800b2d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800b33:	b9 00 00 00 00       	mov    $0x0,%ecx
  800b38:	ba 00 00 00 00       	mov    $0x0,%edx
  800b3d:	be 00 00 00 00       	mov    $0x0,%esi
  800b42:	bf 02 00 00 00       	mov    $0x2,%edi
  800b47:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800b4e:	00 00 00 
  800b51:	ff d0                	callq  *%rax
  800b53:	c9                   	leaveq 
  800b54:	c3                   	retq   

0000000000800b55 <sys_yield>:
  800b55:	55                   	push   %rbp
  800b56:	48 89 e5             	mov    %rsp,%rbp
  800b59:	48 83 ec 10          	sub    $0x10,%rsp
  800b5d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800b64:	00 
  800b65:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800b6b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800b71:	b9 00 00 00 00       	mov    $0x0,%ecx
  800b76:	ba 00 00 00 00       	mov    $0x0,%edx
  800b7b:	be 00 00 00 00       	mov    $0x0,%esi
  800b80:	bf 0b 00 00 00       	mov    $0xb,%edi
  800b85:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800b8c:	00 00 00 
  800b8f:	ff d0                	callq  *%rax
  800b91:	c9                   	leaveq 
  800b92:	c3                   	retq   

0000000000800b93 <sys_page_alloc>:
  800b93:	55                   	push   %rbp
  800b94:	48 89 e5             	mov    %rsp,%rbp
  800b97:	48 83 ec 20          	sub    $0x20,%rsp
  800b9b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800b9e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800ba2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800ba5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800ba8:	48 63 c8             	movslq %eax,%rcx
  800bab:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800baf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800bb2:	48 98                	cltq   
  800bb4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800bbb:	00 
  800bbc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800bc2:	49 89 c8             	mov    %rcx,%r8
  800bc5:	48 89 d1             	mov    %rdx,%rcx
  800bc8:	48 89 c2             	mov    %rax,%rdx
  800bcb:	be 01 00 00 00       	mov    $0x1,%esi
  800bd0:	bf 04 00 00 00       	mov    $0x4,%edi
  800bd5:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800bdc:	00 00 00 
  800bdf:	ff d0                	callq  *%rax
  800be1:	c9                   	leaveq 
  800be2:	c3                   	retq   

0000000000800be3 <sys_page_map>:
  800be3:	55                   	push   %rbp
  800be4:	48 89 e5             	mov    %rsp,%rbp
  800be7:	48 83 ec 30          	sub    $0x30,%rsp
  800beb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800bee:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800bf2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800bf5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  800bf9:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  800bfd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800c00:	48 63 c8             	movslq %eax,%rcx
  800c03:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  800c07:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800c0a:	48 63 f0             	movslq %eax,%rsi
  800c0d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c11:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800c14:	48 98                	cltq   
  800c16:	48 89 0c 24          	mov    %rcx,(%rsp)
  800c1a:	49 89 f9             	mov    %rdi,%r9
  800c1d:	49 89 f0             	mov    %rsi,%r8
  800c20:	48 89 d1             	mov    %rdx,%rcx
  800c23:	48 89 c2             	mov    %rax,%rdx
  800c26:	be 01 00 00 00       	mov    $0x1,%esi
  800c2b:	bf 05 00 00 00       	mov    $0x5,%edi
  800c30:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800c37:	00 00 00 
  800c3a:	ff d0                	callq  *%rax
  800c3c:	c9                   	leaveq 
  800c3d:	c3                   	retq   

0000000000800c3e <sys_page_unmap>:
  800c3e:	55                   	push   %rbp
  800c3f:	48 89 e5             	mov    %rsp,%rbp
  800c42:	48 83 ec 20          	sub    $0x20,%rsp
  800c46:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800c49:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800c4d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800c54:	48 98                	cltq   
  800c56:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800c5d:	00 
  800c5e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800c64:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800c6a:	48 89 d1             	mov    %rdx,%rcx
  800c6d:	48 89 c2             	mov    %rax,%rdx
  800c70:	be 01 00 00 00       	mov    $0x1,%esi
  800c75:	bf 06 00 00 00       	mov    $0x6,%edi
  800c7a:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800c81:	00 00 00 
  800c84:	ff d0                	callq  *%rax
  800c86:	c9                   	leaveq 
  800c87:	c3                   	retq   

0000000000800c88 <sys_env_set_status>:
  800c88:	55                   	push   %rbp
  800c89:	48 89 e5             	mov    %rsp,%rbp
  800c8c:	48 83 ec 10          	sub    $0x10,%rsp
  800c90:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800c93:	89 75 f8             	mov    %esi,-0x8(%rbp)
  800c96:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800c99:	48 63 d0             	movslq %eax,%rdx
  800c9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800c9f:	48 98                	cltq   
  800ca1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800ca8:	00 
  800ca9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800caf:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800cb5:	48 89 d1             	mov    %rdx,%rcx
  800cb8:	48 89 c2             	mov    %rax,%rdx
  800cbb:	be 01 00 00 00       	mov    $0x1,%esi
  800cc0:	bf 08 00 00 00       	mov    $0x8,%edi
  800cc5:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800ccc:	00 00 00 
  800ccf:	ff d0                	callq  *%rax
  800cd1:	c9                   	leaveq 
  800cd2:	c3                   	retq   

0000000000800cd3 <sys_env_set_trapframe>:
  800cd3:	55                   	push   %rbp
  800cd4:	48 89 e5             	mov    %rsp,%rbp
  800cd7:	48 83 ec 20          	sub    $0x20,%rsp
  800cdb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800cde:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800ce2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800ce6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ce9:	48 98                	cltq   
  800ceb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800cf2:	00 
  800cf3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800cf9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800cff:	48 89 d1             	mov    %rdx,%rcx
  800d02:	48 89 c2             	mov    %rax,%rdx
  800d05:	be 01 00 00 00       	mov    $0x1,%esi
  800d0a:	bf 09 00 00 00       	mov    $0x9,%edi
  800d0f:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800d16:	00 00 00 
  800d19:	ff d0                	callq  *%rax
  800d1b:	c9                   	leaveq 
  800d1c:	c3                   	retq   

0000000000800d1d <sys_env_set_pgfault_upcall>:
  800d1d:	55                   	push   %rbp
  800d1e:	48 89 e5             	mov    %rsp,%rbp
  800d21:	48 83 ec 20          	sub    $0x20,%rsp
  800d25:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d28:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d2c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800d30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d33:	48 98                	cltq   
  800d35:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800d3c:	00 
  800d3d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800d43:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800d49:	48 89 d1             	mov    %rdx,%rcx
  800d4c:	48 89 c2             	mov    %rax,%rdx
  800d4f:	be 01 00 00 00       	mov    $0x1,%esi
  800d54:	bf 0a 00 00 00       	mov    $0xa,%edi
  800d59:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800d60:	00 00 00 
  800d63:	ff d0                	callq  *%rax
  800d65:	c9                   	leaveq 
  800d66:	c3                   	retq   

0000000000800d67 <sys_ipc_try_send>:
  800d67:	55                   	push   %rbp
  800d68:	48 89 e5             	mov    %rsp,%rbp
  800d6b:	48 83 ec 20          	sub    $0x20,%rsp
  800d6f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d72:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d76:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800d7a:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  800d7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800d80:	48 63 f0             	movslq %eax,%rsi
  800d83:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  800d87:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d8a:	48 98                	cltq   
  800d8c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800d90:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800d97:	00 
  800d98:	49 89 f1             	mov    %rsi,%r9
  800d9b:	49 89 c8             	mov    %rcx,%r8
  800d9e:	48 89 d1             	mov    %rdx,%rcx
  800da1:	48 89 c2             	mov    %rax,%rdx
  800da4:	be 00 00 00 00       	mov    $0x0,%esi
  800da9:	bf 0c 00 00 00       	mov    $0xc,%edi
  800dae:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800db5:	00 00 00 
  800db8:	ff d0                	callq  *%rax
  800dba:	c9                   	leaveq 
  800dbb:	c3                   	retq   

0000000000800dbc <sys_ipc_recv>:
  800dbc:	55                   	push   %rbp
  800dbd:	48 89 e5             	mov    %rsp,%rbp
  800dc0:	48 83 ec 10          	sub    $0x10,%rsp
  800dc4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800dc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800dcc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800dd3:	00 
  800dd4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800dda:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800de0:	b9 00 00 00 00       	mov    $0x0,%ecx
  800de5:	48 89 c2             	mov    %rax,%rdx
  800de8:	be 01 00 00 00       	mov    $0x1,%esi
  800ded:	bf 0d 00 00 00       	mov    $0xd,%edi
  800df2:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800df9:	00 00 00 
  800dfc:	ff d0                	callq  *%rax
  800dfe:	c9                   	leaveq 
  800dff:	c3                   	retq   

0000000000800e00 <sys_time_msec>:
  800e00:	55                   	push   %rbp
  800e01:	48 89 e5             	mov    %rsp,%rbp
  800e04:	48 83 ec 10          	sub    $0x10,%rsp
  800e08:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800e0f:	00 
  800e10:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800e16:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800e1c:	b9 00 00 00 00       	mov    $0x0,%ecx
  800e21:	ba 00 00 00 00       	mov    $0x0,%edx
  800e26:	be 00 00 00 00       	mov    $0x0,%esi
  800e2b:	bf 0e 00 00 00       	mov    $0xe,%edi
  800e30:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800e37:	00 00 00 
  800e3a:	ff d0                	callq  *%rax
  800e3c:	c9                   	leaveq 
  800e3d:	c3                   	retq   

0000000000800e3e <sys_net_transmit>:
  800e3e:	55                   	push   %rbp
  800e3f:	48 89 e5             	mov    %rsp,%rbp
  800e42:	48 83 ec 20          	sub    $0x20,%rsp
  800e46:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800e4a:	89 75 f4             	mov    %esi,-0xc(%rbp)
  800e4d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  800e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800e54:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800e5b:	00 
  800e5c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800e62:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800e68:	48 89 d1             	mov    %rdx,%rcx
  800e6b:	48 89 c2             	mov    %rax,%rdx
  800e6e:	be 00 00 00 00       	mov    $0x0,%esi
  800e73:	bf 0f 00 00 00       	mov    $0xf,%edi
  800e78:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800e7f:	00 00 00 
  800e82:	ff d0                	callq  *%rax
  800e84:	c9                   	leaveq 
  800e85:	c3                   	retq   

0000000000800e86 <sys_net_receive>:
  800e86:	55                   	push   %rbp
  800e87:	48 89 e5             	mov    %rsp,%rbp
  800e8a:	48 83 ec 20          	sub    $0x20,%rsp
  800e8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800e92:	89 75 f4             	mov    %esi,-0xc(%rbp)
  800e95:	8b 55 f4             	mov    -0xc(%rbp),%edx
  800e98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800e9c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800ea3:	00 
  800ea4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800eaa:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800eb0:	48 89 d1             	mov    %rdx,%rcx
  800eb3:	48 89 c2             	mov    %rax,%rdx
  800eb6:	be 00 00 00 00       	mov    $0x0,%esi
  800ebb:	bf 10 00 00 00       	mov    $0x10,%edi
  800ec0:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800ec7:	00 00 00 
  800eca:	ff d0                	callq  *%rax
  800ecc:	c9                   	leaveq 
  800ecd:	c3                   	retq   

0000000000800ece <sys_ept_map>:
  800ece:	55                   	push   %rbp
  800ecf:	48 89 e5             	mov    %rsp,%rbp
  800ed2:	48 83 ec 30          	sub    $0x30,%rsp
  800ed6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800ed9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800edd:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800ee0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  800ee4:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  800ee8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800eeb:	48 63 c8             	movslq %eax,%rcx
  800eee:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  800ef2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800ef5:	48 63 f0             	movslq %eax,%rsi
  800ef8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800efc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800eff:	48 98                	cltq   
  800f01:	48 89 0c 24          	mov    %rcx,(%rsp)
  800f05:	49 89 f9             	mov    %rdi,%r9
  800f08:	49 89 f0             	mov    %rsi,%r8
  800f0b:	48 89 d1             	mov    %rdx,%rcx
  800f0e:	48 89 c2             	mov    %rax,%rdx
  800f11:	be 00 00 00 00       	mov    $0x0,%esi
  800f16:	bf 11 00 00 00       	mov    $0x11,%edi
  800f1b:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800f22:	00 00 00 
  800f25:	ff d0                	callq  *%rax
  800f27:	c9                   	leaveq 
  800f28:	c3                   	retq   

0000000000800f29 <sys_env_mkguest>:
  800f29:	55                   	push   %rbp
  800f2a:	48 89 e5             	mov    %rsp,%rbp
  800f2d:	48 83 ec 20          	sub    $0x20,%rsp
  800f31:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800f35:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800f39:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800f3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800f41:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800f48:	00 
  800f49:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800f4f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800f55:	48 89 d1             	mov    %rdx,%rcx
  800f58:	48 89 c2             	mov    %rax,%rdx
  800f5b:	be 00 00 00 00       	mov    $0x0,%esi
  800f60:	bf 12 00 00 00       	mov    $0x12,%edi
  800f65:	48 b8 bd 09 80 00 00 	movabs $0x8009bd,%rax
  800f6c:	00 00 00 
  800f6f:	ff d0                	callq  *%rax
  800f71:	c9                   	leaveq 
  800f72:	c3                   	retq   

0000000000800f73 <fd2num>:
  800f73:	55                   	push   %rbp
  800f74:	48 89 e5             	mov    %rsp,%rbp
  800f77:	48 83 ec 08          	sub    $0x8,%rsp
  800f7b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800f7f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  800f83:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  800f8a:	ff ff ff 
  800f8d:	48 01 d0             	add    %rdx,%rax
  800f90:	48 c1 e8 0c          	shr    $0xc,%rax
  800f94:	c9                   	leaveq 
  800f95:	c3                   	retq   

0000000000800f96 <fd2data>:
  800f96:	55                   	push   %rbp
  800f97:	48 89 e5             	mov    %rsp,%rbp
  800f9a:	48 83 ec 08          	sub    $0x8,%rsp
  800f9e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800fa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fa6:	48 89 c7             	mov    %rax,%rdi
  800fa9:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  800fb0:	00 00 00 
  800fb3:	ff d0                	callq  *%rax
  800fb5:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  800fbb:	48 c1 e0 0c          	shl    $0xc,%rax
  800fbf:	c9                   	leaveq 
  800fc0:	c3                   	retq   

0000000000800fc1 <fd_alloc>:
  800fc1:	55                   	push   %rbp
  800fc2:	48 89 e5             	mov    %rsp,%rbp
  800fc5:	48 83 ec 18          	sub    $0x18,%rsp
  800fc9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800fd4:	eb 6b                	jmp    801041 <fd_alloc+0x80>
  800fd6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800fd9:	48 98                	cltq   
  800fdb:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  800fe1:	48 c1 e0 0c          	shl    $0xc,%rax
  800fe5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800fe9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fed:	48 c1 e8 15          	shr    $0x15,%rax
  800ff1:	48 89 c2             	mov    %rax,%rdx
  800ff4:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  800ffb:	01 00 00 
  800ffe:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801002:	83 e0 01             	and    $0x1,%eax
  801005:	48 85 c0             	test   %rax,%rax
  801008:	74 21                	je     80102b <fd_alloc+0x6a>
  80100a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80100e:	48 c1 e8 0c          	shr    $0xc,%rax
  801012:	48 89 c2             	mov    %rax,%rdx
  801015:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80101c:	01 00 00 
  80101f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801023:	83 e0 01             	and    $0x1,%eax
  801026:	48 85 c0             	test   %rax,%rax
  801029:	75 12                	jne    80103d <fd_alloc+0x7c>
  80102b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80102f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801033:	48 89 10             	mov    %rdx,(%rax)
  801036:	b8 00 00 00 00       	mov    $0x0,%eax
  80103b:	eb 1a                	jmp    801057 <fd_alloc+0x96>
  80103d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801041:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801045:	7e 8f                	jle    800fd6 <fd_alloc+0x15>
  801047:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80104b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801052:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801057:	c9                   	leaveq 
  801058:	c3                   	retq   

0000000000801059 <fd_lookup>:
  801059:	55                   	push   %rbp
  80105a:	48 89 e5             	mov    %rsp,%rbp
  80105d:	48 83 ec 20          	sub    $0x20,%rsp
  801061:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801064:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801068:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80106c:	78 06                	js     801074 <fd_lookup+0x1b>
  80106e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801072:	7e 07                	jle    80107b <fd_lookup+0x22>
  801074:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801079:	eb 6c                	jmp    8010e7 <fd_lookup+0x8e>
  80107b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80107e:	48 98                	cltq   
  801080:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801086:	48 c1 e0 0c          	shl    $0xc,%rax
  80108a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80108e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801092:	48 c1 e8 15          	shr    $0x15,%rax
  801096:	48 89 c2             	mov    %rax,%rdx
  801099:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8010a0:	01 00 00 
  8010a3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8010a7:	83 e0 01             	and    $0x1,%eax
  8010aa:	48 85 c0             	test   %rax,%rax
  8010ad:	74 21                	je     8010d0 <fd_lookup+0x77>
  8010af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010b3:	48 c1 e8 0c          	shr    $0xc,%rax
  8010b7:	48 89 c2             	mov    %rax,%rdx
  8010ba:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8010c1:	01 00 00 
  8010c4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8010c8:	83 e0 01             	and    $0x1,%eax
  8010cb:	48 85 c0             	test   %rax,%rax
  8010ce:	75 07                	jne    8010d7 <fd_lookup+0x7e>
  8010d0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8010d5:	eb 10                	jmp    8010e7 <fd_lookup+0x8e>
  8010d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8010db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8010df:	48 89 10             	mov    %rdx,(%rax)
  8010e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8010e7:	c9                   	leaveq 
  8010e8:	c3                   	retq   

00000000008010e9 <fd_close>:
  8010e9:	55                   	push   %rbp
  8010ea:	48 89 e5             	mov    %rsp,%rbp
  8010ed:	48 83 ec 30          	sub    $0x30,%rsp
  8010f1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8010f5:	89 f0                	mov    %esi,%eax
  8010f7:	88 45 d4             	mov    %al,-0x2c(%rbp)
  8010fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8010fe:	48 89 c7             	mov    %rax,%rdi
  801101:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  801108:	00 00 00 
  80110b:	ff d0                	callq  *%rax
  80110d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801111:	48 89 d6             	mov    %rdx,%rsi
  801114:	89 c7                	mov    %eax,%edi
  801116:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  80111d:	00 00 00 
  801120:	ff d0                	callq  *%rax
  801122:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801125:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801129:	78 0a                	js     801135 <fd_close+0x4c>
  80112b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80112f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801133:	74 12                	je     801147 <fd_close+0x5e>
  801135:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801139:	74 05                	je     801140 <fd_close+0x57>
  80113b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80113e:	eb 05                	jmp    801145 <fd_close+0x5c>
  801140:	b8 00 00 00 00       	mov    $0x0,%eax
  801145:	eb 69                	jmp    8011b0 <fd_close+0xc7>
  801147:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80114b:	8b 00                	mov    (%rax),%eax
  80114d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801151:	48 89 d6             	mov    %rdx,%rsi
  801154:	89 c7                	mov    %eax,%edi
  801156:	48 b8 b2 11 80 00 00 	movabs $0x8011b2,%rax
  80115d:	00 00 00 
  801160:	ff d0                	callq  *%rax
  801162:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801165:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801169:	78 2a                	js     801195 <fd_close+0xac>
  80116b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80116f:	48 8b 40 20          	mov    0x20(%rax),%rax
  801173:	48 85 c0             	test   %rax,%rax
  801176:	74 16                	je     80118e <fd_close+0xa5>
  801178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80117c:	48 8b 40 20          	mov    0x20(%rax),%rax
  801180:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801184:	48 89 d7             	mov    %rdx,%rdi
  801187:	ff d0                	callq  *%rax
  801189:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80118c:	eb 07                	jmp    801195 <fd_close+0xac>
  80118e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801195:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801199:	48 89 c6             	mov    %rax,%rsi
  80119c:	bf 00 00 00 00       	mov    $0x0,%edi
  8011a1:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  8011a8:	00 00 00 
  8011ab:	ff d0                	callq  *%rax
  8011ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8011b0:	c9                   	leaveq 
  8011b1:	c3                   	retq   

00000000008011b2 <dev_lookup>:
  8011b2:	55                   	push   %rbp
  8011b3:	48 89 e5             	mov    %rsp,%rbp
  8011b6:	48 83 ec 20          	sub    $0x20,%rsp
  8011ba:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8011bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8011c8:	eb 41                	jmp    80120b <dev_lookup+0x59>
  8011ca:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  8011d1:	00 00 00 
  8011d4:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8011d7:	48 63 d2             	movslq %edx,%rdx
  8011da:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8011de:	8b 00                	mov    (%rax),%eax
  8011e0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8011e3:	75 22                	jne    801207 <dev_lookup+0x55>
  8011e5:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  8011ec:	00 00 00 
  8011ef:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8011f2:	48 63 d2             	movslq %edx,%rdx
  8011f5:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8011f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8011fd:	48 89 10             	mov    %rdx,(%rax)
  801200:	b8 00 00 00 00       	mov    $0x0,%eax
  801205:	eb 60                	jmp    801267 <dev_lookup+0xb5>
  801207:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80120b:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801212:	00 00 00 
  801215:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801218:	48 63 d2             	movslq %edx,%rdx
  80121b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80121f:	48 85 c0             	test   %rax,%rax
  801222:	75 a6                	jne    8011ca <dev_lookup+0x18>
  801224:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80122b:	00 00 00 
  80122e:	48 8b 00             	mov    (%rax),%rax
  801231:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801237:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80123a:	89 c6                	mov    %eax,%esi
  80123c:	48 bf c0 40 80 00 00 	movabs $0x8040c0,%rdi
  801243:	00 00 00 
  801246:	b8 00 00 00 00       	mov    $0x0,%eax
  80124b:	48 b9 5f 32 80 00 00 	movabs $0x80325f,%rcx
  801252:	00 00 00 
  801255:	ff d1                	callq  *%rcx
  801257:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80125b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801262:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801267:	c9                   	leaveq 
  801268:	c3                   	retq   

0000000000801269 <close>:
  801269:	55                   	push   %rbp
  80126a:	48 89 e5             	mov    %rsp,%rbp
  80126d:	48 83 ec 20          	sub    $0x20,%rsp
  801271:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801274:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801278:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80127b:	48 89 d6             	mov    %rdx,%rsi
  80127e:	89 c7                	mov    %eax,%edi
  801280:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  801287:	00 00 00 
  80128a:	ff d0                	callq  *%rax
  80128c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80128f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801293:	79 05                	jns    80129a <close+0x31>
  801295:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801298:	eb 18                	jmp    8012b2 <close+0x49>
  80129a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80129e:	be 01 00 00 00       	mov    $0x1,%esi
  8012a3:	48 89 c7             	mov    %rax,%rdi
  8012a6:	48 b8 e9 10 80 00 00 	movabs $0x8010e9,%rax
  8012ad:	00 00 00 
  8012b0:	ff d0                	callq  *%rax
  8012b2:	c9                   	leaveq 
  8012b3:	c3                   	retq   

00000000008012b4 <close_all>:
  8012b4:	55                   	push   %rbp
  8012b5:	48 89 e5             	mov    %rsp,%rbp
  8012b8:	48 83 ec 10          	sub    $0x10,%rsp
  8012bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8012c3:	eb 15                	jmp    8012da <close_all+0x26>
  8012c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8012c8:	89 c7                	mov    %eax,%edi
  8012ca:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  8012d1:	00 00 00 
  8012d4:	ff d0                	callq  *%rax
  8012d6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8012da:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8012de:	7e e5                	jle    8012c5 <close_all+0x11>
  8012e0:	c9                   	leaveq 
  8012e1:	c3                   	retq   

00000000008012e2 <dup>:
  8012e2:	55                   	push   %rbp
  8012e3:	48 89 e5             	mov    %rsp,%rbp
  8012e6:	48 83 ec 40          	sub    $0x40,%rsp
  8012ea:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8012ed:	89 75 c8             	mov    %esi,-0x38(%rbp)
  8012f0:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8012f4:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8012f7:	48 89 d6             	mov    %rdx,%rsi
  8012fa:	89 c7                	mov    %eax,%edi
  8012fc:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  801303:	00 00 00 
  801306:	ff d0                	callq  *%rax
  801308:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80130b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80130f:	79 08                	jns    801319 <dup+0x37>
  801311:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801314:	e9 70 01 00 00       	jmpq   801489 <dup+0x1a7>
  801319:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80131c:	89 c7                	mov    %eax,%edi
  80131e:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801325:	00 00 00 
  801328:	ff d0                	callq  *%rax
  80132a:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80132d:	48 98                	cltq   
  80132f:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801335:	48 c1 e0 0c          	shl    $0xc,%rax
  801339:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80133d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801341:	48 89 c7             	mov    %rax,%rdi
  801344:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  80134b:	00 00 00 
  80134e:	ff d0                	callq  *%rax
  801350:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801354:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801358:	48 89 c7             	mov    %rax,%rdi
  80135b:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  801362:	00 00 00 
  801365:	ff d0                	callq  *%rax
  801367:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80136b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80136f:	48 c1 e8 15          	shr    $0x15,%rax
  801373:	48 89 c2             	mov    %rax,%rdx
  801376:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80137d:	01 00 00 
  801380:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801384:	83 e0 01             	and    $0x1,%eax
  801387:	48 85 c0             	test   %rax,%rax
  80138a:	74 73                	je     8013ff <dup+0x11d>
  80138c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801390:	48 c1 e8 0c          	shr    $0xc,%rax
  801394:	48 89 c2             	mov    %rax,%rdx
  801397:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80139e:	01 00 00 
  8013a1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8013a5:	83 e0 01             	and    $0x1,%eax
  8013a8:	48 85 c0             	test   %rax,%rax
  8013ab:	74 52                	je     8013ff <dup+0x11d>
  8013ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013b1:	48 c1 e8 0c          	shr    $0xc,%rax
  8013b5:	48 89 c2             	mov    %rax,%rdx
  8013b8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8013bf:	01 00 00 
  8013c2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8013c6:	25 07 0e 00 00       	and    $0xe07,%eax
  8013cb:	89 c1                	mov    %eax,%ecx
  8013cd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8013d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013d5:	41 89 c8             	mov    %ecx,%r8d
  8013d8:	48 89 d1             	mov    %rdx,%rcx
  8013db:	ba 00 00 00 00       	mov    $0x0,%edx
  8013e0:	48 89 c6             	mov    %rax,%rsi
  8013e3:	bf 00 00 00 00       	mov    $0x0,%edi
  8013e8:	48 b8 e3 0b 80 00 00 	movabs $0x800be3,%rax
  8013ef:	00 00 00 
  8013f2:	ff d0                	callq  *%rax
  8013f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8013f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8013fb:	79 02                	jns    8013ff <dup+0x11d>
  8013fd:	eb 57                	jmp    801456 <dup+0x174>
  8013ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801403:	48 c1 e8 0c          	shr    $0xc,%rax
  801407:	48 89 c2             	mov    %rax,%rdx
  80140a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801411:	01 00 00 
  801414:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801418:	25 07 0e 00 00       	and    $0xe07,%eax
  80141d:	89 c1                	mov    %eax,%ecx
  80141f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801423:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801427:	41 89 c8             	mov    %ecx,%r8d
  80142a:	48 89 d1             	mov    %rdx,%rcx
  80142d:	ba 00 00 00 00       	mov    $0x0,%edx
  801432:	48 89 c6             	mov    %rax,%rsi
  801435:	bf 00 00 00 00       	mov    $0x0,%edi
  80143a:	48 b8 e3 0b 80 00 00 	movabs $0x800be3,%rax
  801441:	00 00 00 
  801444:	ff d0                	callq  *%rax
  801446:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801449:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80144d:	79 02                	jns    801451 <dup+0x16f>
  80144f:	eb 05                	jmp    801456 <dup+0x174>
  801451:	8b 45 c8             	mov    -0x38(%rbp),%eax
  801454:	eb 33                	jmp    801489 <dup+0x1a7>
  801456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80145a:	48 89 c6             	mov    %rax,%rsi
  80145d:	bf 00 00 00 00       	mov    $0x0,%edi
  801462:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  801469:	00 00 00 
  80146c:	ff d0                	callq  *%rax
  80146e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801472:	48 89 c6             	mov    %rax,%rsi
  801475:	bf 00 00 00 00       	mov    $0x0,%edi
  80147a:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  801481:	00 00 00 
  801484:	ff d0                	callq  *%rax
  801486:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801489:	c9                   	leaveq 
  80148a:	c3                   	retq   

000000000080148b <read>:
  80148b:	55                   	push   %rbp
  80148c:	48 89 e5             	mov    %rsp,%rbp
  80148f:	48 83 ec 40          	sub    $0x40,%rsp
  801493:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801496:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80149a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80149e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8014a2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8014a5:	48 89 d6             	mov    %rdx,%rsi
  8014a8:	89 c7                	mov    %eax,%edi
  8014aa:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  8014b1:	00 00 00 
  8014b4:	ff d0                	callq  *%rax
  8014b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8014b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8014bd:	78 24                	js     8014e3 <read+0x58>
  8014bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014c3:	8b 00                	mov    (%rax),%eax
  8014c5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8014c9:	48 89 d6             	mov    %rdx,%rsi
  8014cc:	89 c7                	mov    %eax,%edi
  8014ce:	48 b8 b2 11 80 00 00 	movabs $0x8011b2,%rax
  8014d5:	00 00 00 
  8014d8:	ff d0                	callq  *%rax
  8014da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8014dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8014e1:	79 05                	jns    8014e8 <read+0x5d>
  8014e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8014e6:	eb 76                	jmp    80155e <read+0xd3>
  8014e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014ec:	8b 40 08             	mov    0x8(%rax),%eax
  8014ef:	83 e0 03             	and    $0x3,%eax
  8014f2:	83 f8 01             	cmp    $0x1,%eax
  8014f5:	75 3a                	jne    801531 <read+0xa6>
  8014f7:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8014fe:	00 00 00 
  801501:	48 8b 00             	mov    (%rax),%rax
  801504:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80150a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80150d:	89 c6                	mov    %eax,%esi
  80150f:	48 bf df 40 80 00 00 	movabs $0x8040df,%rdi
  801516:	00 00 00 
  801519:	b8 00 00 00 00       	mov    $0x0,%eax
  80151e:	48 b9 5f 32 80 00 00 	movabs $0x80325f,%rcx
  801525:	00 00 00 
  801528:	ff d1                	callq  *%rcx
  80152a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80152f:	eb 2d                	jmp    80155e <read+0xd3>
  801531:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801535:	48 8b 40 10          	mov    0x10(%rax),%rax
  801539:	48 85 c0             	test   %rax,%rax
  80153c:	75 07                	jne    801545 <read+0xba>
  80153e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  801543:	eb 19                	jmp    80155e <read+0xd3>
  801545:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801549:	48 8b 40 10          	mov    0x10(%rax),%rax
  80154d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801551:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801555:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  801559:	48 89 cf             	mov    %rcx,%rdi
  80155c:	ff d0                	callq  *%rax
  80155e:	c9                   	leaveq 
  80155f:	c3                   	retq   

0000000000801560 <readn>:
  801560:	55                   	push   %rbp
  801561:	48 89 e5             	mov    %rsp,%rbp
  801564:	48 83 ec 30          	sub    $0x30,%rsp
  801568:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80156b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80156f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801573:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80157a:	eb 49                	jmp    8015c5 <readn+0x65>
  80157c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80157f:	48 98                	cltq   
  801581:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801585:	48 29 c2             	sub    %rax,%rdx
  801588:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80158b:	48 63 c8             	movslq %eax,%rcx
  80158e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801592:	48 01 c1             	add    %rax,%rcx
  801595:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801598:	48 89 ce             	mov    %rcx,%rsi
  80159b:	89 c7                	mov    %eax,%edi
  80159d:	48 b8 8b 14 80 00 00 	movabs $0x80148b,%rax
  8015a4:	00 00 00 
  8015a7:	ff d0                	callq  *%rax
  8015a9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8015ac:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8015b0:	79 05                	jns    8015b7 <readn+0x57>
  8015b2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8015b5:	eb 1c                	jmp    8015d3 <readn+0x73>
  8015b7:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8015bb:	75 02                	jne    8015bf <readn+0x5f>
  8015bd:	eb 11                	jmp    8015d0 <readn+0x70>
  8015bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8015c2:	01 45 fc             	add    %eax,-0x4(%rbp)
  8015c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8015c8:	48 98                	cltq   
  8015ca:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8015ce:	72 ac                	jb     80157c <readn+0x1c>
  8015d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8015d3:	c9                   	leaveq 
  8015d4:	c3                   	retq   

00000000008015d5 <write>:
  8015d5:	55                   	push   %rbp
  8015d6:	48 89 e5             	mov    %rsp,%rbp
  8015d9:	48 83 ec 40          	sub    $0x40,%rsp
  8015dd:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8015e0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8015e4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8015e8:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8015ec:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8015ef:	48 89 d6             	mov    %rdx,%rsi
  8015f2:	89 c7                	mov    %eax,%edi
  8015f4:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  8015fb:	00 00 00 
  8015fe:	ff d0                	callq  *%rax
  801600:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801603:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801607:	78 24                	js     80162d <write+0x58>
  801609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80160d:	8b 00                	mov    (%rax),%eax
  80160f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801613:	48 89 d6             	mov    %rdx,%rsi
  801616:	89 c7                	mov    %eax,%edi
  801618:	48 b8 b2 11 80 00 00 	movabs $0x8011b2,%rax
  80161f:	00 00 00 
  801622:	ff d0                	callq  *%rax
  801624:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801627:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80162b:	79 05                	jns    801632 <write+0x5d>
  80162d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801630:	eb 75                	jmp    8016a7 <write+0xd2>
  801632:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801636:	8b 40 08             	mov    0x8(%rax),%eax
  801639:	83 e0 03             	and    $0x3,%eax
  80163c:	85 c0                	test   %eax,%eax
  80163e:	75 3a                	jne    80167a <write+0xa5>
  801640:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  801647:	00 00 00 
  80164a:	48 8b 00             	mov    (%rax),%rax
  80164d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801653:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801656:	89 c6                	mov    %eax,%esi
  801658:	48 bf fb 40 80 00 00 	movabs $0x8040fb,%rdi
  80165f:	00 00 00 
  801662:	b8 00 00 00 00       	mov    $0x0,%eax
  801667:	48 b9 5f 32 80 00 00 	movabs $0x80325f,%rcx
  80166e:	00 00 00 
  801671:	ff d1                	callq  *%rcx
  801673:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801678:	eb 2d                	jmp    8016a7 <write+0xd2>
  80167a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80167e:	48 8b 40 18          	mov    0x18(%rax),%rax
  801682:	48 85 c0             	test   %rax,%rax
  801685:	75 07                	jne    80168e <write+0xb9>
  801687:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80168c:	eb 19                	jmp    8016a7 <write+0xd2>
  80168e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801692:	48 8b 40 18          	mov    0x18(%rax),%rax
  801696:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80169a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80169e:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8016a2:	48 89 cf             	mov    %rcx,%rdi
  8016a5:	ff d0                	callq  *%rax
  8016a7:	c9                   	leaveq 
  8016a8:	c3                   	retq   

00000000008016a9 <seek>:
  8016a9:	55                   	push   %rbp
  8016aa:	48 89 e5             	mov    %rsp,%rbp
  8016ad:	48 83 ec 18          	sub    $0x18,%rsp
  8016b1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8016b4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8016b7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8016bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016be:	48 89 d6             	mov    %rdx,%rsi
  8016c1:	89 c7                	mov    %eax,%edi
  8016c3:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  8016ca:	00 00 00 
  8016cd:	ff d0                	callq  *%rax
  8016cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8016d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8016d6:	79 05                	jns    8016dd <seek+0x34>
  8016d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8016db:	eb 0f                	jmp    8016ec <seek+0x43>
  8016dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016e1:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8016e4:	89 50 04             	mov    %edx,0x4(%rax)
  8016e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8016ec:	c9                   	leaveq 
  8016ed:	c3                   	retq   

00000000008016ee <ftruncate>:
  8016ee:	55                   	push   %rbp
  8016ef:	48 89 e5             	mov    %rsp,%rbp
  8016f2:	48 83 ec 30          	sub    $0x30,%rsp
  8016f6:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8016f9:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8016fc:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801700:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801703:	48 89 d6             	mov    %rdx,%rsi
  801706:	89 c7                	mov    %eax,%edi
  801708:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  80170f:	00 00 00 
  801712:	ff d0                	callq  *%rax
  801714:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801717:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80171b:	78 24                	js     801741 <ftruncate+0x53>
  80171d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801721:	8b 00                	mov    (%rax),%eax
  801723:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801727:	48 89 d6             	mov    %rdx,%rsi
  80172a:	89 c7                	mov    %eax,%edi
  80172c:	48 b8 b2 11 80 00 00 	movabs $0x8011b2,%rax
  801733:	00 00 00 
  801736:	ff d0                	callq  *%rax
  801738:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80173b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80173f:	79 05                	jns    801746 <ftruncate+0x58>
  801741:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801744:	eb 72                	jmp    8017b8 <ftruncate+0xca>
  801746:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80174a:	8b 40 08             	mov    0x8(%rax),%eax
  80174d:	83 e0 03             	and    $0x3,%eax
  801750:	85 c0                	test   %eax,%eax
  801752:	75 3a                	jne    80178e <ftruncate+0xa0>
  801754:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80175b:	00 00 00 
  80175e:	48 8b 00             	mov    (%rax),%rax
  801761:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801767:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80176a:	89 c6                	mov    %eax,%esi
  80176c:	48 bf 18 41 80 00 00 	movabs $0x804118,%rdi
  801773:	00 00 00 
  801776:	b8 00 00 00 00       	mov    $0x0,%eax
  80177b:	48 b9 5f 32 80 00 00 	movabs $0x80325f,%rcx
  801782:	00 00 00 
  801785:	ff d1                	callq  *%rcx
  801787:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80178c:	eb 2a                	jmp    8017b8 <ftruncate+0xca>
  80178e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801792:	48 8b 40 30          	mov    0x30(%rax),%rax
  801796:	48 85 c0             	test   %rax,%rax
  801799:	75 07                	jne    8017a2 <ftruncate+0xb4>
  80179b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8017a0:	eb 16                	jmp    8017b8 <ftruncate+0xca>
  8017a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017a6:	48 8b 40 30          	mov    0x30(%rax),%rax
  8017aa:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8017ae:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8017b1:	89 ce                	mov    %ecx,%esi
  8017b3:	48 89 d7             	mov    %rdx,%rdi
  8017b6:	ff d0                	callq  *%rax
  8017b8:	c9                   	leaveq 
  8017b9:	c3                   	retq   

00000000008017ba <fstat>:
  8017ba:	55                   	push   %rbp
  8017bb:	48 89 e5             	mov    %rsp,%rbp
  8017be:	48 83 ec 30          	sub    $0x30,%rsp
  8017c2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8017c5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8017c9:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8017cd:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8017d0:	48 89 d6             	mov    %rdx,%rsi
  8017d3:	89 c7                	mov    %eax,%edi
  8017d5:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  8017dc:	00 00 00 
  8017df:	ff d0                	callq  *%rax
  8017e1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8017e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8017e8:	78 24                	js     80180e <fstat+0x54>
  8017ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8017ee:	8b 00                	mov    (%rax),%eax
  8017f0:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8017f4:	48 89 d6             	mov    %rdx,%rsi
  8017f7:	89 c7                	mov    %eax,%edi
  8017f9:	48 b8 b2 11 80 00 00 	movabs $0x8011b2,%rax
  801800:	00 00 00 
  801803:	ff d0                	callq  *%rax
  801805:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801808:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80180c:	79 05                	jns    801813 <fstat+0x59>
  80180e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801811:	eb 5e                	jmp    801871 <fstat+0xb7>
  801813:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801817:	48 8b 40 28          	mov    0x28(%rax),%rax
  80181b:	48 85 c0             	test   %rax,%rax
  80181e:	75 07                	jne    801827 <fstat+0x6d>
  801820:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  801825:	eb 4a                	jmp    801871 <fstat+0xb7>
  801827:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80182b:	c6 00 00             	movb   $0x0,(%rax)
  80182e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801832:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  801839:	00 00 00 
  80183c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801840:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  801847:	00 00 00 
  80184a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80184e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801852:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  801859:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80185d:	48 8b 40 28          	mov    0x28(%rax),%rax
  801861:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801865:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801869:	48 89 ce             	mov    %rcx,%rsi
  80186c:	48 89 d7             	mov    %rdx,%rdi
  80186f:	ff d0                	callq  *%rax
  801871:	c9                   	leaveq 
  801872:	c3                   	retq   

0000000000801873 <stat>:
  801873:	55                   	push   %rbp
  801874:	48 89 e5             	mov    %rsp,%rbp
  801877:	48 83 ec 20          	sub    $0x20,%rsp
  80187b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80187f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801883:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801887:	be 00 00 00 00       	mov    $0x0,%esi
  80188c:	48 89 c7             	mov    %rax,%rdi
  80188f:	48 b8 61 19 80 00 00 	movabs $0x801961,%rax
  801896:	00 00 00 
  801899:	ff d0                	callq  *%rax
  80189b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80189e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8018a2:	79 05                	jns    8018a9 <stat+0x36>
  8018a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018a7:	eb 2f                	jmp    8018d8 <stat+0x65>
  8018a9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8018ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018b0:	48 89 d6             	mov    %rdx,%rsi
  8018b3:	89 c7                	mov    %eax,%edi
  8018b5:	48 b8 ba 17 80 00 00 	movabs $0x8017ba,%rax
  8018bc:	00 00 00 
  8018bf:	ff d0                	callq  *%rax
  8018c1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8018c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018c7:	89 c7                	mov    %eax,%edi
  8018c9:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  8018d0:	00 00 00 
  8018d3:	ff d0                	callq  *%rax
  8018d5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8018d8:	c9                   	leaveq 
  8018d9:	c3                   	retq   

00000000008018da <fsipc>:
  8018da:	55                   	push   %rbp
  8018db:	48 89 e5             	mov    %rsp,%rbp
  8018de:	48 83 ec 10          	sub    $0x10,%rsp
  8018e2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018e5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018e9:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8018f0:	00 00 00 
  8018f3:	8b 00                	mov    (%rax),%eax
  8018f5:	85 c0                	test   %eax,%eax
  8018f7:	75 1d                	jne    801916 <fsipc+0x3c>
  8018f9:	bf 01 00 00 00       	mov    $0x1,%edi
  8018fe:	48 b8 74 3f 80 00 00 	movabs $0x803f74,%rax
  801905:	00 00 00 
  801908:	ff d0                	callq  *%rax
  80190a:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  801911:	00 00 00 
  801914:	89 02                	mov    %eax,(%rdx)
  801916:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80191d:	00 00 00 
  801920:	8b 00                	mov    (%rax),%eax
  801922:	8b 75 fc             	mov    -0x4(%rbp),%esi
  801925:	b9 07 00 00 00       	mov    $0x7,%ecx
  80192a:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  801931:	00 00 00 
  801934:	89 c7                	mov    %eax,%edi
  801936:	48 b8 69 3e 80 00 00 	movabs $0x803e69,%rax
  80193d:	00 00 00 
  801940:	ff d0                	callq  *%rax
  801942:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801946:	ba 00 00 00 00       	mov    $0x0,%edx
  80194b:	48 89 c6             	mov    %rax,%rsi
  80194e:	bf 00 00 00 00       	mov    $0x0,%edi
  801953:	48 b8 a8 3d 80 00 00 	movabs $0x803da8,%rax
  80195a:	00 00 00 
  80195d:	ff d0                	callq  *%rax
  80195f:	c9                   	leaveq 
  801960:	c3                   	retq   

0000000000801961 <open>:
  801961:	55                   	push   %rbp
  801962:	48 89 e5             	mov    %rsp,%rbp
  801965:	48 83 ec 20          	sub    $0x20,%rsp
  801969:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80196d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801970:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801974:	48 89 c7             	mov    %rax,%rdi
  801977:	48 b8 f8 01 80 00 00 	movabs $0x8001f8,%rax
  80197e:	00 00 00 
  801981:	ff d0                	callq  *%rax
  801983:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  801988:	7e 0a                	jle    801994 <open+0x33>
  80198a:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80198f:	e9 a5 00 00 00       	jmpq   801a39 <open+0xd8>
  801994:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  801998:	48 89 c7             	mov    %rax,%rdi
  80199b:	48 b8 c1 0f 80 00 00 	movabs $0x800fc1,%rax
  8019a2:	00 00 00 
  8019a5:	ff d0                	callq  *%rax
  8019a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8019aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8019ae:	79 08                	jns    8019b8 <open+0x57>
  8019b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b3:	e9 81 00 00 00       	jmpq   801a39 <open+0xd8>
  8019b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019bc:	48 89 c6             	mov    %rax,%rsi
  8019bf:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  8019c6:	00 00 00 
  8019c9:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  8019d0:	00 00 00 
  8019d3:	ff d0                	callq  *%rax
  8019d5:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8019dc:	00 00 00 
  8019df:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8019e2:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8019e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8019ec:	48 89 c6             	mov    %rax,%rsi
  8019ef:	bf 01 00 00 00       	mov    $0x1,%edi
  8019f4:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  8019fb:	00 00 00 
  8019fe:	ff d0                	callq  *%rax
  801a00:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801a03:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801a07:	79 1d                	jns    801a26 <open+0xc5>
  801a09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a0d:	be 00 00 00 00       	mov    $0x0,%esi
  801a12:	48 89 c7             	mov    %rax,%rdi
  801a15:	48 b8 e9 10 80 00 00 	movabs $0x8010e9,%rax
  801a1c:	00 00 00 
  801a1f:	ff d0                	callq  *%rax
  801a21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a24:	eb 13                	jmp    801a39 <open+0xd8>
  801a26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a2a:	48 89 c7             	mov    %rax,%rdi
  801a2d:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  801a34:	00 00 00 
  801a37:	ff d0                	callq  *%rax
  801a39:	c9                   	leaveq 
  801a3a:	c3                   	retq   

0000000000801a3b <devfile_flush>:
  801a3b:	55                   	push   %rbp
  801a3c:	48 89 e5             	mov    %rsp,%rbp
  801a3f:	48 83 ec 10          	sub    $0x10,%rsp
  801a43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a4b:	8b 50 0c             	mov    0xc(%rax),%edx
  801a4e:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801a55:	00 00 00 
  801a58:	89 10                	mov    %edx,(%rax)
  801a5a:	be 00 00 00 00       	mov    $0x0,%esi
  801a5f:	bf 06 00 00 00       	mov    $0x6,%edi
  801a64:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801a6b:	00 00 00 
  801a6e:	ff d0                	callq  *%rax
  801a70:	c9                   	leaveq 
  801a71:	c3                   	retq   

0000000000801a72 <devfile_read>:
  801a72:	55                   	push   %rbp
  801a73:	48 89 e5             	mov    %rsp,%rbp
  801a76:	48 83 ec 30          	sub    $0x30,%rsp
  801a7a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801a7e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801a82:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801a86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a8a:	8b 50 0c             	mov    0xc(%rax),%edx
  801a8d:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801a94:	00 00 00 
  801a97:	89 10                	mov    %edx,(%rax)
  801a99:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801aa0:	00 00 00 
  801aa3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801aa7:	48 89 50 08          	mov    %rdx,0x8(%rax)
  801aab:	be 00 00 00 00       	mov    $0x0,%esi
  801ab0:	bf 03 00 00 00       	mov    $0x3,%edi
  801ab5:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801abc:	00 00 00 
  801abf:	ff d0                	callq  *%rax
  801ac1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801ac4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801ac8:	79 08                	jns    801ad2 <devfile_read+0x60>
  801aca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801acd:	e9 a4 00 00 00       	jmpq   801b76 <devfile_read+0x104>
  801ad2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ad5:	48 98                	cltq   
  801ad7:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801adb:	76 35                	jbe    801b12 <devfile_read+0xa0>
  801add:	48 b9 3e 41 80 00 00 	movabs $0x80413e,%rcx
  801ae4:	00 00 00 
  801ae7:	48 ba 45 41 80 00 00 	movabs $0x804145,%rdx
  801aee:	00 00 00 
  801af1:	be 89 00 00 00       	mov    $0x89,%esi
  801af6:	48 bf 5a 41 80 00 00 	movabs $0x80415a,%rdi
  801afd:	00 00 00 
  801b00:	b8 00 00 00 00       	mov    $0x0,%eax
  801b05:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  801b0c:	00 00 00 
  801b0f:	41 ff d0             	callq  *%r8
  801b12:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  801b19:	7e 35                	jle    801b50 <devfile_read+0xde>
  801b1b:	48 b9 68 41 80 00 00 	movabs $0x804168,%rcx
  801b22:	00 00 00 
  801b25:	48 ba 45 41 80 00 00 	movabs $0x804145,%rdx
  801b2c:	00 00 00 
  801b2f:	be 8a 00 00 00       	mov    $0x8a,%esi
  801b34:	48 bf 5a 41 80 00 00 	movabs $0x80415a,%rdi
  801b3b:	00 00 00 
  801b3e:	b8 00 00 00 00       	mov    $0x0,%eax
  801b43:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  801b4a:	00 00 00 
  801b4d:	41 ff d0             	callq  *%r8
  801b50:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b53:	48 63 d0             	movslq %eax,%rdx
  801b56:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801b5a:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  801b61:	00 00 00 
  801b64:	48 89 c7             	mov    %rax,%rdi
  801b67:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  801b6e:	00 00 00 
  801b71:	ff d0                	callq  *%rax
  801b73:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801b76:	c9                   	leaveq 
  801b77:	c3                   	retq   

0000000000801b78 <devfile_write>:
  801b78:	55                   	push   %rbp
  801b79:	48 89 e5             	mov    %rsp,%rbp
  801b7c:	48 83 ec 40          	sub    $0x40,%rsp
  801b80:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801b84:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801b88:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  801b8c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801b90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801b94:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  801b9b:	00 
  801b9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ba0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  801ba4:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  801ba9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  801bad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801bb1:	8b 50 0c             	mov    0xc(%rax),%edx
  801bb4:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801bbb:	00 00 00 
  801bbe:	89 10                	mov    %edx,(%rax)
  801bc0:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801bc7:	00 00 00 
  801bca:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801bce:	48 89 50 08          	mov    %rdx,0x8(%rax)
  801bd2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801bd6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801bda:	48 89 c6             	mov    %rax,%rsi
  801bdd:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  801be4:	00 00 00 
  801be7:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  801bee:	00 00 00 
  801bf1:	ff d0                	callq  *%rax
  801bf3:	be 00 00 00 00       	mov    $0x0,%esi
  801bf8:	bf 04 00 00 00       	mov    $0x4,%edi
  801bfd:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801c04:	00 00 00 
  801c07:	ff d0                	callq  *%rax
  801c09:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801c0c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801c10:	79 05                	jns    801c17 <devfile_write+0x9f>
  801c12:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801c15:	eb 43                	jmp    801c5a <devfile_write+0xe2>
  801c17:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801c1a:	48 98                	cltq   
  801c1c:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  801c20:	76 35                	jbe    801c57 <devfile_write+0xdf>
  801c22:	48 b9 3e 41 80 00 00 	movabs $0x80413e,%rcx
  801c29:	00 00 00 
  801c2c:	48 ba 45 41 80 00 00 	movabs $0x804145,%rdx
  801c33:	00 00 00 
  801c36:	be a8 00 00 00       	mov    $0xa8,%esi
  801c3b:	48 bf 5a 41 80 00 00 	movabs $0x80415a,%rdi
  801c42:	00 00 00 
  801c45:	b8 00 00 00 00       	mov    $0x0,%eax
  801c4a:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  801c51:	00 00 00 
  801c54:	41 ff d0             	callq  *%r8
  801c57:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801c5a:	c9                   	leaveq 
  801c5b:	c3                   	retq   

0000000000801c5c <devfile_stat>:
  801c5c:	55                   	push   %rbp
  801c5d:	48 89 e5             	mov    %rsp,%rbp
  801c60:	48 83 ec 20          	sub    $0x20,%rsp
  801c64:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801c68:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801c6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c70:	8b 50 0c             	mov    0xc(%rax),%edx
  801c73:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801c7a:	00 00 00 
  801c7d:	89 10                	mov    %edx,(%rax)
  801c7f:	be 00 00 00 00       	mov    $0x0,%esi
  801c84:	bf 05 00 00 00       	mov    $0x5,%edi
  801c89:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801c90:	00 00 00 
  801c93:	ff d0                	callq  *%rax
  801c95:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801c98:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801c9c:	79 05                	jns    801ca3 <devfile_stat+0x47>
  801c9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ca1:	eb 56                	jmp    801cf9 <devfile_stat+0x9d>
  801ca3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801ca7:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  801cae:	00 00 00 
  801cb1:	48 89 c7             	mov    %rax,%rdi
  801cb4:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  801cbb:	00 00 00 
  801cbe:	ff d0                	callq  *%rax
  801cc0:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801cc7:	00 00 00 
  801cca:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  801cd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801cd4:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  801cda:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801ce1:	00 00 00 
  801ce4:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  801cea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801cee:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  801cf4:	b8 00 00 00 00       	mov    $0x0,%eax
  801cf9:	c9                   	leaveq 
  801cfa:	c3                   	retq   

0000000000801cfb <devfile_trunc>:
  801cfb:	55                   	push   %rbp
  801cfc:	48 89 e5             	mov    %rsp,%rbp
  801cff:	48 83 ec 10          	sub    $0x10,%rsp
  801d03:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d07:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d0e:	8b 50 0c             	mov    0xc(%rax),%edx
  801d11:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801d18:	00 00 00 
  801d1b:	89 10                	mov    %edx,(%rax)
  801d1d:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801d24:	00 00 00 
  801d27:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801d2a:	89 50 04             	mov    %edx,0x4(%rax)
  801d2d:	be 00 00 00 00       	mov    $0x0,%esi
  801d32:	bf 02 00 00 00       	mov    $0x2,%edi
  801d37:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801d3e:	00 00 00 
  801d41:	ff d0                	callq  *%rax
  801d43:	c9                   	leaveq 
  801d44:	c3                   	retq   

0000000000801d45 <remove>:
  801d45:	55                   	push   %rbp
  801d46:	48 89 e5             	mov    %rsp,%rbp
  801d49:	48 83 ec 10          	sub    $0x10,%rsp
  801d4d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d55:	48 89 c7             	mov    %rax,%rdi
  801d58:	48 b8 f8 01 80 00 00 	movabs $0x8001f8,%rax
  801d5f:	00 00 00 
  801d62:	ff d0                	callq  *%rax
  801d64:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  801d69:	7e 07                	jle    801d72 <remove+0x2d>
  801d6b:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  801d70:	eb 33                	jmp    801da5 <remove+0x60>
  801d72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d76:	48 89 c6             	mov    %rax,%rsi
  801d79:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  801d80:	00 00 00 
  801d83:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  801d8a:	00 00 00 
  801d8d:	ff d0                	callq  *%rax
  801d8f:	be 00 00 00 00       	mov    $0x0,%esi
  801d94:	bf 07 00 00 00       	mov    $0x7,%edi
  801d99:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801da0:	00 00 00 
  801da3:	ff d0                	callq  *%rax
  801da5:	c9                   	leaveq 
  801da6:	c3                   	retq   

0000000000801da7 <sync>:
  801da7:	55                   	push   %rbp
  801da8:	48 89 e5             	mov    %rsp,%rbp
  801dab:	be 00 00 00 00       	mov    $0x0,%esi
  801db0:	bf 08 00 00 00       	mov    $0x8,%edi
  801db5:	48 b8 da 18 80 00 00 	movabs $0x8018da,%rax
  801dbc:	00 00 00 
  801dbf:	ff d0                	callq  *%rax
  801dc1:	5d                   	pop    %rbp
  801dc2:	c3                   	retq   

0000000000801dc3 <copy>:
  801dc3:	55                   	push   %rbp
  801dc4:	48 89 e5             	mov    %rsp,%rbp
  801dc7:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  801dce:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  801dd5:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  801ddc:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  801de3:	be 00 00 00 00       	mov    $0x0,%esi
  801de8:	48 89 c7             	mov    %rax,%rdi
  801deb:	48 b8 61 19 80 00 00 	movabs $0x801961,%rax
  801df2:	00 00 00 
  801df5:	ff d0                	callq  *%rax
  801df7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801dfa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801dfe:	79 28                	jns    801e28 <copy+0x65>
  801e00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e03:	89 c6                	mov    %eax,%esi
  801e05:	48 bf 74 41 80 00 00 	movabs $0x804174,%rdi
  801e0c:	00 00 00 
  801e0f:	b8 00 00 00 00       	mov    $0x0,%eax
  801e14:	48 ba 5f 32 80 00 00 	movabs $0x80325f,%rdx
  801e1b:	00 00 00 
  801e1e:	ff d2                	callq  *%rdx
  801e20:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e23:	e9 74 01 00 00       	jmpq   801f9c <copy+0x1d9>
  801e28:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  801e2f:	be 01 01 00 00       	mov    $0x101,%esi
  801e34:	48 89 c7             	mov    %rax,%rdi
  801e37:	48 b8 61 19 80 00 00 	movabs $0x801961,%rax
  801e3e:	00 00 00 
  801e41:	ff d0                	callq  *%rax
  801e43:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801e46:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  801e4a:	79 39                	jns    801e85 <copy+0xc2>
  801e4c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e4f:	89 c6                	mov    %eax,%esi
  801e51:	48 bf 8a 41 80 00 00 	movabs $0x80418a,%rdi
  801e58:	00 00 00 
  801e5b:	b8 00 00 00 00       	mov    $0x0,%eax
  801e60:	48 ba 5f 32 80 00 00 	movabs $0x80325f,%rdx
  801e67:	00 00 00 
  801e6a:	ff d2                	callq  *%rdx
  801e6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e6f:	89 c7                	mov    %eax,%edi
  801e71:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801e78:	00 00 00 
  801e7b:	ff d0                	callq  *%rax
  801e7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e80:	e9 17 01 00 00       	jmpq   801f9c <copy+0x1d9>
  801e85:	eb 74                	jmp    801efb <copy+0x138>
  801e87:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801e8a:	48 63 d0             	movslq %eax,%rdx
  801e8d:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  801e94:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e97:	48 89 ce             	mov    %rcx,%rsi
  801e9a:	89 c7                	mov    %eax,%edi
  801e9c:	48 b8 d5 15 80 00 00 	movabs $0x8015d5,%rax
  801ea3:	00 00 00 
  801ea6:	ff d0                	callq  *%rax
  801ea8:	89 45 f0             	mov    %eax,-0x10(%rbp)
  801eab:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  801eaf:	79 4a                	jns    801efb <copy+0x138>
  801eb1:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801eb4:	89 c6                	mov    %eax,%esi
  801eb6:	48 bf a4 41 80 00 00 	movabs $0x8041a4,%rdi
  801ebd:	00 00 00 
  801ec0:	b8 00 00 00 00       	mov    $0x0,%eax
  801ec5:	48 ba 5f 32 80 00 00 	movabs $0x80325f,%rdx
  801ecc:	00 00 00 
  801ecf:	ff d2                	callq  *%rdx
  801ed1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ed4:	89 c7                	mov    %eax,%edi
  801ed6:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801edd:	00 00 00 
  801ee0:	ff d0                	callq  *%rax
  801ee2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801ee5:	89 c7                	mov    %eax,%edi
  801ee7:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801eee:	00 00 00 
  801ef1:	ff d0                	callq  *%rax
  801ef3:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801ef6:	e9 a1 00 00 00       	jmpq   801f9c <copy+0x1d9>
  801efb:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  801f02:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f05:	ba 00 02 00 00       	mov    $0x200,%edx
  801f0a:	48 89 ce             	mov    %rcx,%rsi
  801f0d:	89 c7                	mov    %eax,%edi
  801f0f:	48 b8 8b 14 80 00 00 	movabs $0x80148b,%rax
  801f16:	00 00 00 
  801f19:	ff d0                	callq  *%rax
  801f1b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  801f1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  801f22:	0f 8f 5f ff ff ff    	jg     801e87 <copy+0xc4>
  801f28:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  801f2c:	79 47                	jns    801f75 <copy+0x1b2>
  801f2e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801f31:	89 c6                	mov    %eax,%esi
  801f33:	48 bf b7 41 80 00 00 	movabs $0x8041b7,%rdi
  801f3a:	00 00 00 
  801f3d:	b8 00 00 00 00       	mov    $0x0,%eax
  801f42:	48 ba 5f 32 80 00 00 	movabs $0x80325f,%rdx
  801f49:	00 00 00 
  801f4c:	ff d2                	callq  *%rdx
  801f4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f51:	89 c7                	mov    %eax,%edi
  801f53:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801f5a:	00 00 00 
  801f5d:	ff d0                	callq  *%rax
  801f5f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f62:	89 c7                	mov    %eax,%edi
  801f64:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801f6b:	00 00 00 
  801f6e:	ff d0                	callq  *%rax
  801f70:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801f73:	eb 27                	jmp    801f9c <copy+0x1d9>
  801f75:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f78:	89 c7                	mov    %eax,%edi
  801f7a:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801f81:	00 00 00 
  801f84:	ff d0                	callq  *%rax
  801f86:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f89:	89 c7                	mov    %eax,%edi
  801f8b:	48 b8 69 12 80 00 00 	movabs $0x801269,%rax
  801f92:	00 00 00 
  801f95:	ff d0                	callq  *%rax
  801f97:	b8 00 00 00 00       	mov    $0x0,%eax
  801f9c:	c9                   	leaveq 
  801f9d:	c3                   	retq   

0000000000801f9e <fd2sockid>:
  801f9e:	55                   	push   %rbp
  801f9f:	48 89 e5             	mov    %rsp,%rbp
  801fa2:	48 83 ec 20          	sub    $0x20,%rsp
  801fa6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801fa9:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801fad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801fb0:	48 89 d6             	mov    %rdx,%rsi
  801fb3:	89 c7                	mov    %eax,%edi
  801fb5:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  801fbc:	00 00 00 
  801fbf:	ff d0                	callq  *%rax
  801fc1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fc4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801fc8:	79 05                	jns    801fcf <fd2sockid+0x31>
  801fca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fcd:	eb 24                	jmp    801ff3 <fd2sockid+0x55>
  801fcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fd3:	8b 10                	mov    (%rax),%edx
  801fd5:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  801fdc:	00 00 00 
  801fdf:	8b 00                	mov    (%rax),%eax
  801fe1:	39 c2                	cmp    %eax,%edx
  801fe3:	74 07                	je     801fec <fd2sockid+0x4e>
  801fe5:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  801fea:	eb 07                	jmp    801ff3 <fd2sockid+0x55>
  801fec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ff0:	8b 40 0c             	mov    0xc(%rax),%eax
  801ff3:	c9                   	leaveq 
  801ff4:	c3                   	retq   

0000000000801ff5 <alloc_sockfd>:
  801ff5:	55                   	push   %rbp
  801ff6:	48 89 e5             	mov    %rsp,%rbp
  801ff9:	48 83 ec 20          	sub    $0x20,%rsp
  801ffd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802000:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802004:	48 89 c7             	mov    %rax,%rdi
  802007:	48 b8 c1 0f 80 00 00 	movabs $0x800fc1,%rax
  80200e:	00 00 00 
  802011:	ff d0                	callq  *%rax
  802013:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802016:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80201a:	78 26                	js     802042 <alloc_sockfd+0x4d>
  80201c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802020:	ba 07 04 00 00       	mov    $0x407,%edx
  802025:	48 89 c6             	mov    %rax,%rsi
  802028:	bf 00 00 00 00       	mov    $0x0,%edi
  80202d:	48 b8 93 0b 80 00 00 	movabs $0x800b93,%rax
  802034:	00 00 00 
  802037:	ff d0                	callq  *%rax
  802039:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80203c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802040:	79 16                	jns    802058 <alloc_sockfd+0x63>
  802042:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802045:	89 c7                	mov    %eax,%edi
  802047:	48 b8 02 25 80 00 00 	movabs $0x802502,%rax
  80204e:	00 00 00 
  802051:	ff d0                	callq  *%rax
  802053:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802056:	eb 3a                	jmp    802092 <alloc_sockfd+0x9d>
  802058:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80205c:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  802063:	00 00 00 
  802066:	8b 12                	mov    (%rdx),%edx
  802068:	89 10                	mov    %edx,(%rax)
  80206a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80206e:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802075:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802079:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80207c:	89 50 0c             	mov    %edx,0xc(%rax)
  80207f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802083:	48 89 c7             	mov    %rax,%rdi
  802086:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  80208d:	00 00 00 
  802090:	ff d0                	callq  *%rax
  802092:	c9                   	leaveq 
  802093:	c3                   	retq   

0000000000802094 <accept>:
  802094:	55                   	push   %rbp
  802095:	48 89 e5             	mov    %rsp,%rbp
  802098:	48 83 ec 30          	sub    $0x30,%rsp
  80209c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80209f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8020a3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8020a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8020aa:	89 c7                	mov    %eax,%edi
  8020ac:	48 b8 9e 1f 80 00 00 	movabs $0x801f9e,%rax
  8020b3:	00 00 00 
  8020b6:	ff d0                	callq  *%rax
  8020b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8020bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8020bf:	79 05                	jns    8020c6 <accept+0x32>
  8020c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020c4:	eb 3b                	jmp    802101 <accept+0x6d>
  8020c6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8020ca:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8020ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020d1:	48 89 ce             	mov    %rcx,%rsi
  8020d4:	89 c7                	mov    %eax,%edi
  8020d6:	48 b8 df 23 80 00 00 	movabs $0x8023df,%rax
  8020dd:	00 00 00 
  8020e0:	ff d0                	callq  *%rax
  8020e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8020e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8020e9:	79 05                	jns    8020f0 <accept+0x5c>
  8020eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020ee:	eb 11                	jmp    802101 <accept+0x6d>
  8020f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020f3:	89 c7                	mov    %eax,%edi
  8020f5:	48 b8 f5 1f 80 00 00 	movabs $0x801ff5,%rax
  8020fc:	00 00 00 
  8020ff:	ff d0                	callq  *%rax
  802101:	c9                   	leaveq 
  802102:	c3                   	retq   

0000000000802103 <bind>:
  802103:	55                   	push   %rbp
  802104:	48 89 e5             	mov    %rsp,%rbp
  802107:	48 83 ec 20          	sub    $0x20,%rsp
  80210b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80210e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802112:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802115:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802118:	89 c7                	mov    %eax,%edi
  80211a:	48 b8 9e 1f 80 00 00 	movabs $0x801f9e,%rax
  802121:	00 00 00 
  802124:	ff d0                	callq  *%rax
  802126:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802129:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80212d:	79 05                	jns    802134 <bind+0x31>
  80212f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802132:	eb 1b                	jmp    80214f <bind+0x4c>
  802134:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802137:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80213b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80213e:	48 89 ce             	mov    %rcx,%rsi
  802141:	89 c7                	mov    %eax,%edi
  802143:	48 b8 5e 24 80 00 00 	movabs $0x80245e,%rax
  80214a:	00 00 00 
  80214d:	ff d0                	callq  *%rax
  80214f:	c9                   	leaveq 
  802150:	c3                   	retq   

0000000000802151 <shutdown>:
  802151:	55                   	push   %rbp
  802152:	48 89 e5             	mov    %rsp,%rbp
  802155:	48 83 ec 20          	sub    $0x20,%rsp
  802159:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80215c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80215f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802162:	89 c7                	mov    %eax,%edi
  802164:	48 b8 9e 1f 80 00 00 	movabs $0x801f9e,%rax
  80216b:	00 00 00 
  80216e:	ff d0                	callq  *%rax
  802170:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802173:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802177:	79 05                	jns    80217e <shutdown+0x2d>
  802179:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80217c:	eb 16                	jmp    802194 <shutdown+0x43>
  80217e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802181:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802184:	89 d6                	mov    %edx,%esi
  802186:	89 c7                	mov    %eax,%edi
  802188:	48 b8 c2 24 80 00 00 	movabs $0x8024c2,%rax
  80218f:	00 00 00 
  802192:	ff d0                	callq  *%rax
  802194:	c9                   	leaveq 
  802195:	c3                   	retq   

0000000000802196 <devsock_close>:
  802196:	55                   	push   %rbp
  802197:	48 89 e5             	mov    %rsp,%rbp
  80219a:	48 83 ec 10          	sub    $0x10,%rsp
  80219e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8021a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8021a6:	48 89 c7             	mov    %rax,%rdi
  8021a9:	48 b8 e6 3f 80 00 00 	movabs $0x803fe6,%rax
  8021b0:	00 00 00 
  8021b3:	ff d0                	callq  *%rax
  8021b5:	83 f8 01             	cmp    $0x1,%eax
  8021b8:	75 17                	jne    8021d1 <devsock_close+0x3b>
  8021ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8021be:	8b 40 0c             	mov    0xc(%rax),%eax
  8021c1:	89 c7                	mov    %eax,%edi
  8021c3:	48 b8 02 25 80 00 00 	movabs $0x802502,%rax
  8021ca:	00 00 00 
  8021cd:	ff d0                	callq  *%rax
  8021cf:	eb 05                	jmp    8021d6 <devsock_close+0x40>
  8021d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8021d6:	c9                   	leaveq 
  8021d7:	c3                   	retq   

00000000008021d8 <connect>:
  8021d8:	55                   	push   %rbp
  8021d9:	48 89 e5             	mov    %rsp,%rbp
  8021dc:	48 83 ec 20          	sub    $0x20,%rsp
  8021e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8021e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8021e7:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8021ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8021ed:	89 c7                	mov    %eax,%edi
  8021ef:	48 b8 9e 1f 80 00 00 	movabs $0x801f9e,%rax
  8021f6:	00 00 00 
  8021f9:	ff d0                	callq  *%rax
  8021fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802202:	79 05                	jns    802209 <connect+0x31>
  802204:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802207:	eb 1b                	jmp    802224 <connect+0x4c>
  802209:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80220c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802210:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802213:	48 89 ce             	mov    %rcx,%rsi
  802216:	89 c7                	mov    %eax,%edi
  802218:	48 b8 2f 25 80 00 00 	movabs $0x80252f,%rax
  80221f:	00 00 00 
  802222:	ff d0                	callq  *%rax
  802224:	c9                   	leaveq 
  802225:	c3                   	retq   

0000000000802226 <listen>:
  802226:	55                   	push   %rbp
  802227:	48 89 e5             	mov    %rsp,%rbp
  80222a:	48 83 ec 20          	sub    $0x20,%rsp
  80222e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802231:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802234:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802237:	89 c7                	mov    %eax,%edi
  802239:	48 b8 9e 1f 80 00 00 	movabs $0x801f9e,%rax
  802240:	00 00 00 
  802243:	ff d0                	callq  *%rax
  802245:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802248:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80224c:	79 05                	jns    802253 <listen+0x2d>
  80224e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802251:	eb 16                	jmp    802269 <listen+0x43>
  802253:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802256:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802259:	89 d6                	mov    %edx,%esi
  80225b:	89 c7                	mov    %eax,%edi
  80225d:	48 b8 93 25 80 00 00 	movabs $0x802593,%rax
  802264:	00 00 00 
  802267:	ff d0                	callq  *%rax
  802269:	c9                   	leaveq 
  80226a:	c3                   	retq   

000000000080226b <devsock_read>:
  80226b:	55                   	push   %rbp
  80226c:	48 89 e5             	mov    %rsp,%rbp
  80226f:	48 83 ec 20          	sub    $0x20,%rsp
  802273:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802277:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80227b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80227f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802283:	89 c2                	mov    %eax,%edx
  802285:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802289:	8b 40 0c             	mov    0xc(%rax),%eax
  80228c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802290:	b9 00 00 00 00       	mov    $0x0,%ecx
  802295:	89 c7                	mov    %eax,%edi
  802297:	48 b8 d3 25 80 00 00 	movabs $0x8025d3,%rax
  80229e:	00 00 00 
  8022a1:	ff d0                	callq  *%rax
  8022a3:	c9                   	leaveq 
  8022a4:	c3                   	retq   

00000000008022a5 <devsock_write>:
  8022a5:	55                   	push   %rbp
  8022a6:	48 89 e5             	mov    %rsp,%rbp
  8022a9:	48 83 ec 20          	sub    $0x20,%rsp
  8022ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8022b1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8022b5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8022b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022bd:	89 c2                	mov    %eax,%edx
  8022bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8022c3:	8b 40 0c             	mov    0xc(%rax),%eax
  8022c6:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8022ca:	b9 00 00 00 00       	mov    $0x0,%ecx
  8022cf:	89 c7                	mov    %eax,%edi
  8022d1:	48 b8 9f 26 80 00 00 	movabs $0x80269f,%rax
  8022d8:	00 00 00 
  8022db:	ff d0                	callq  *%rax
  8022dd:	c9                   	leaveq 
  8022de:	c3                   	retq   

00000000008022df <devsock_stat>:
  8022df:	55                   	push   %rbp
  8022e0:	48 89 e5             	mov    %rsp,%rbp
  8022e3:	48 83 ec 10          	sub    $0x10,%rsp
  8022e7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8022eb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8022ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022f3:	48 be d2 41 80 00 00 	movabs $0x8041d2,%rsi
  8022fa:	00 00 00 
  8022fd:	48 89 c7             	mov    %rax,%rdi
  802300:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  802307:	00 00 00 
  80230a:	ff d0                	callq  *%rax
  80230c:	b8 00 00 00 00       	mov    $0x0,%eax
  802311:	c9                   	leaveq 
  802312:	c3                   	retq   

0000000000802313 <socket>:
  802313:	55                   	push   %rbp
  802314:	48 89 e5             	mov    %rsp,%rbp
  802317:	48 83 ec 20          	sub    $0x20,%rsp
  80231b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80231e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802321:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  802324:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802327:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80232a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80232d:	89 ce                	mov    %ecx,%esi
  80232f:	89 c7                	mov    %eax,%edi
  802331:	48 b8 57 27 80 00 00 	movabs $0x802757,%rax
  802338:	00 00 00 
  80233b:	ff d0                	callq  *%rax
  80233d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802340:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802344:	79 05                	jns    80234b <socket+0x38>
  802346:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802349:	eb 11                	jmp    80235c <socket+0x49>
  80234b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80234e:	89 c7                	mov    %eax,%edi
  802350:	48 b8 f5 1f 80 00 00 	movabs $0x801ff5,%rax
  802357:	00 00 00 
  80235a:	ff d0                	callq  *%rax
  80235c:	c9                   	leaveq 
  80235d:	c3                   	retq   

000000000080235e <nsipc>:
  80235e:	55                   	push   %rbp
  80235f:	48 89 e5             	mov    %rsp,%rbp
  802362:	48 83 ec 10          	sub    $0x10,%rsp
  802366:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802369:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  802370:	00 00 00 
  802373:	8b 00                	mov    (%rax),%eax
  802375:	85 c0                	test   %eax,%eax
  802377:	75 1d                	jne    802396 <nsipc+0x38>
  802379:	bf 02 00 00 00       	mov    $0x2,%edi
  80237e:	48 b8 74 3f 80 00 00 	movabs $0x803f74,%rax
  802385:	00 00 00 
  802388:	ff d0                	callq  *%rax
  80238a:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  802391:	00 00 00 
  802394:	89 02                	mov    %eax,(%rdx)
  802396:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  80239d:	00 00 00 
  8023a0:	8b 00                	mov    (%rax),%eax
  8023a2:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8023a5:	b9 07 00 00 00       	mov    $0x7,%ecx
  8023aa:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  8023b1:	00 00 00 
  8023b4:	89 c7                	mov    %eax,%edi
  8023b6:	48 b8 69 3e 80 00 00 	movabs $0x803e69,%rax
  8023bd:	00 00 00 
  8023c0:	ff d0                	callq  *%rax
  8023c2:	ba 00 00 00 00       	mov    $0x0,%edx
  8023c7:	be 00 00 00 00       	mov    $0x0,%esi
  8023cc:	bf 00 00 00 00       	mov    $0x0,%edi
  8023d1:	48 b8 a8 3d 80 00 00 	movabs $0x803da8,%rax
  8023d8:	00 00 00 
  8023db:	ff d0                	callq  *%rax
  8023dd:	c9                   	leaveq 
  8023de:	c3                   	retq   

00000000008023df <nsipc_accept>:
  8023df:	55                   	push   %rbp
  8023e0:	48 89 e5             	mov    %rsp,%rbp
  8023e3:	48 83 ec 30          	sub    $0x30,%rsp
  8023e7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023ea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8023ee:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8023f2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8023f9:	00 00 00 
  8023fc:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8023ff:	89 10                	mov    %edx,(%rax)
  802401:	bf 01 00 00 00       	mov    $0x1,%edi
  802406:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  80240d:	00 00 00 
  802410:	ff d0                	callq  *%rax
  802412:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802415:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802419:	78 3e                	js     802459 <nsipc_accept+0x7a>
  80241b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802422:	00 00 00 
  802425:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802429:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80242d:	8b 40 10             	mov    0x10(%rax),%eax
  802430:	89 c2                	mov    %eax,%edx
  802432:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  802436:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80243a:	48 89 ce             	mov    %rcx,%rsi
  80243d:	48 89 c7             	mov    %rax,%rdi
  802440:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  802447:	00 00 00 
  80244a:	ff d0                	callq  *%rax
  80244c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802450:	8b 50 10             	mov    0x10(%rax),%edx
  802453:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802457:	89 10                	mov    %edx,(%rax)
  802459:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80245c:	c9                   	leaveq 
  80245d:	c3                   	retq   

000000000080245e <nsipc_bind>:
  80245e:	55                   	push   %rbp
  80245f:	48 89 e5             	mov    %rsp,%rbp
  802462:	48 83 ec 10          	sub    $0x10,%rsp
  802466:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802469:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80246d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802470:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802477:	00 00 00 
  80247a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80247d:	89 10                	mov    %edx,(%rax)
  80247f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  802482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802486:	48 89 c6             	mov    %rax,%rsi
  802489:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  802490:	00 00 00 
  802493:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  80249a:	00 00 00 
  80249d:	ff d0                	callq  *%rax
  80249f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8024a6:	00 00 00 
  8024a9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8024ac:	89 50 14             	mov    %edx,0x14(%rax)
  8024af:	bf 02 00 00 00       	mov    $0x2,%edi
  8024b4:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  8024bb:	00 00 00 
  8024be:	ff d0                	callq  *%rax
  8024c0:	c9                   	leaveq 
  8024c1:	c3                   	retq   

00000000008024c2 <nsipc_shutdown>:
  8024c2:	55                   	push   %rbp
  8024c3:	48 89 e5             	mov    %rsp,%rbp
  8024c6:	48 83 ec 10          	sub    $0x10,%rsp
  8024ca:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8024cd:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8024d0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8024d7:	00 00 00 
  8024da:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8024dd:	89 10                	mov    %edx,(%rax)
  8024df:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8024e6:	00 00 00 
  8024e9:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8024ec:	89 50 04             	mov    %edx,0x4(%rax)
  8024ef:	bf 03 00 00 00       	mov    $0x3,%edi
  8024f4:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  8024fb:	00 00 00 
  8024fe:	ff d0                	callq  *%rax
  802500:	c9                   	leaveq 
  802501:	c3                   	retq   

0000000000802502 <nsipc_close>:
  802502:	55                   	push   %rbp
  802503:	48 89 e5             	mov    %rsp,%rbp
  802506:	48 83 ec 10          	sub    $0x10,%rsp
  80250a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80250d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802514:	00 00 00 
  802517:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80251a:	89 10                	mov    %edx,(%rax)
  80251c:	bf 04 00 00 00       	mov    $0x4,%edi
  802521:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  802528:	00 00 00 
  80252b:	ff d0                	callq  *%rax
  80252d:	c9                   	leaveq 
  80252e:	c3                   	retq   

000000000080252f <nsipc_connect>:
  80252f:	55                   	push   %rbp
  802530:	48 89 e5             	mov    %rsp,%rbp
  802533:	48 83 ec 10          	sub    $0x10,%rsp
  802537:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80253a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80253e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802541:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802548:	00 00 00 
  80254b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80254e:	89 10                	mov    %edx,(%rax)
  802550:	8b 55 f8             	mov    -0x8(%rbp),%edx
  802553:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802557:	48 89 c6             	mov    %rax,%rsi
  80255a:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  802561:	00 00 00 
  802564:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  80256b:	00 00 00 
  80256e:	ff d0                	callq  *%rax
  802570:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  802577:	00 00 00 
  80257a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80257d:	89 50 14             	mov    %edx,0x14(%rax)
  802580:	bf 05 00 00 00       	mov    $0x5,%edi
  802585:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  80258c:	00 00 00 
  80258f:	ff d0                	callq  *%rax
  802591:	c9                   	leaveq 
  802592:	c3                   	retq   

0000000000802593 <nsipc_listen>:
  802593:	55                   	push   %rbp
  802594:	48 89 e5             	mov    %rsp,%rbp
  802597:	48 83 ec 10          	sub    $0x10,%rsp
  80259b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80259e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8025a1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8025a8:	00 00 00 
  8025ab:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8025ae:	89 10                	mov    %edx,(%rax)
  8025b0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8025b7:	00 00 00 
  8025ba:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8025bd:	89 50 04             	mov    %edx,0x4(%rax)
  8025c0:	bf 06 00 00 00       	mov    $0x6,%edi
  8025c5:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  8025cc:	00 00 00 
  8025cf:	ff d0                	callq  *%rax
  8025d1:	c9                   	leaveq 
  8025d2:	c3                   	retq   

00000000008025d3 <nsipc_recv>:
  8025d3:	55                   	push   %rbp
  8025d4:	48 89 e5             	mov    %rsp,%rbp
  8025d7:	48 83 ec 30          	sub    $0x30,%rsp
  8025db:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8025de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025e2:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8025e5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8025e8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8025ef:	00 00 00 
  8025f2:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8025f5:	89 10                	mov    %edx,(%rax)
  8025f7:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8025fe:	00 00 00 
  802601:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802604:	89 50 04             	mov    %edx,0x4(%rax)
  802607:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80260e:	00 00 00 
  802611:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802614:	89 50 08             	mov    %edx,0x8(%rax)
  802617:	bf 07 00 00 00       	mov    $0x7,%edi
  80261c:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  802623:	00 00 00 
  802626:	ff d0                	callq  *%rax
  802628:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80262b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80262f:	78 69                	js     80269a <nsipc_recv+0xc7>
  802631:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  802638:	7f 08                	jg     802642 <nsipc_recv+0x6f>
  80263a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80263d:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  802640:	7e 35                	jle    802677 <nsipc_recv+0xa4>
  802642:	48 b9 d9 41 80 00 00 	movabs $0x8041d9,%rcx
  802649:	00 00 00 
  80264c:	48 ba ee 41 80 00 00 	movabs $0x8041ee,%rdx
  802653:	00 00 00 
  802656:	be 62 00 00 00       	mov    $0x62,%esi
  80265b:	48 bf 03 42 80 00 00 	movabs $0x804203,%rdi
  802662:	00 00 00 
  802665:	b8 00 00 00 00       	mov    $0x0,%eax
  80266a:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  802671:	00 00 00 
  802674:	41 ff d0             	callq  *%r8
  802677:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80267a:	48 63 d0             	movslq %eax,%rdx
  80267d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802681:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  802688:	00 00 00 
  80268b:	48 89 c7             	mov    %rax,%rdi
  80268e:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  802695:	00 00 00 
  802698:	ff d0                	callq  *%rax
  80269a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80269d:	c9                   	leaveq 
  80269e:	c3                   	retq   

000000000080269f <nsipc_send>:
  80269f:	55                   	push   %rbp
  8026a0:	48 89 e5             	mov    %rsp,%rbp
  8026a3:	48 83 ec 20          	sub    $0x20,%rsp
  8026a7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8026aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8026ae:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8026b1:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8026b4:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8026bb:	00 00 00 
  8026be:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8026c1:	89 10                	mov    %edx,(%rax)
  8026c3:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  8026ca:	7e 35                	jle    802701 <nsipc_send+0x62>
  8026cc:	48 b9 12 42 80 00 00 	movabs $0x804212,%rcx
  8026d3:	00 00 00 
  8026d6:	48 ba ee 41 80 00 00 	movabs $0x8041ee,%rdx
  8026dd:	00 00 00 
  8026e0:	be 6d 00 00 00       	mov    $0x6d,%esi
  8026e5:	48 bf 03 42 80 00 00 	movabs $0x804203,%rdi
  8026ec:	00 00 00 
  8026ef:	b8 00 00 00 00       	mov    $0x0,%eax
  8026f4:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  8026fb:	00 00 00 
  8026fe:	41 ff d0             	callq  *%r8
  802701:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802704:	48 63 d0             	movslq %eax,%rdx
  802707:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80270b:	48 89 c6             	mov    %rax,%rsi
  80270e:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  802715:	00 00 00 
  802718:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  80271f:	00 00 00 
  802722:	ff d0                	callq  *%rax
  802724:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80272b:	00 00 00 
  80272e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  802731:	89 50 04             	mov    %edx,0x4(%rax)
  802734:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80273b:	00 00 00 
  80273e:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802741:	89 50 08             	mov    %edx,0x8(%rax)
  802744:	bf 08 00 00 00       	mov    $0x8,%edi
  802749:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  802750:	00 00 00 
  802753:	ff d0                	callq  *%rax
  802755:	c9                   	leaveq 
  802756:	c3                   	retq   

0000000000802757 <nsipc_socket>:
  802757:	55                   	push   %rbp
  802758:	48 89 e5             	mov    %rsp,%rbp
  80275b:	48 83 ec 10          	sub    $0x10,%rsp
  80275f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802762:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802765:	89 55 f4             	mov    %edx,-0xc(%rbp)
  802768:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80276f:	00 00 00 
  802772:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802775:	89 10                	mov    %edx,(%rax)
  802777:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80277e:	00 00 00 
  802781:	8b 55 f8             	mov    -0x8(%rbp),%edx
  802784:	89 50 04             	mov    %edx,0x4(%rax)
  802787:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80278e:	00 00 00 
  802791:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802794:	89 50 08             	mov    %edx,0x8(%rax)
  802797:	bf 09 00 00 00       	mov    $0x9,%edi
  80279c:	48 b8 5e 23 80 00 00 	movabs $0x80235e,%rax
  8027a3:	00 00 00 
  8027a6:	ff d0                	callq  *%rax
  8027a8:	c9                   	leaveq 
  8027a9:	c3                   	retq   

00000000008027aa <pipe>:
  8027aa:	55                   	push   %rbp
  8027ab:	48 89 e5             	mov    %rsp,%rbp
  8027ae:	53                   	push   %rbx
  8027af:	48 83 ec 38          	sub    $0x38,%rsp
  8027b3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8027b7:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8027bb:	48 89 c7             	mov    %rax,%rdi
  8027be:	48 b8 c1 0f 80 00 00 	movabs $0x800fc1,%rax
  8027c5:	00 00 00 
  8027c8:	ff d0                	callq  *%rax
  8027ca:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8027cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8027d1:	0f 88 bf 01 00 00    	js     802996 <pipe+0x1ec>
  8027d7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027db:	ba 07 04 00 00       	mov    $0x407,%edx
  8027e0:	48 89 c6             	mov    %rax,%rsi
  8027e3:	bf 00 00 00 00       	mov    $0x0,%edi
  8027e8:	48 b8 93 0b 80 00 00 	movabs $0x800b93,%rax
  8027ef:	00 00 00 
  8027f2:	ff d0                	callq  *%rax
  8027f4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8027f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8027fb:	0f 88 95 01 00 00    	js     802996 <pipe+0x1ec>
  802801:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  802805:	48 89 c7             	mov    %rax,%rdi
  802808:	48 b8 c1 0f 80 00 00 	movabs $0x800fc1,%rax
  80280f:	00 00 00 
  802812:	ff d0                	callq  *%rax
  802814:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802817:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80281b:	0f 88 5d 01 00 00    	js     80297e <pipe+0x1d4>
  802821:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802825:	ba 07 04 00 00       	mov    $0x407,%edx
  80282a:	48 89 c6             	mov    %rax,%rsi
  80282d:	bf 00 00 00 00       	mov    $0x0,%edi
  802832:	48 b8 93 0b 80 00 00 	movabs $0x800b93,%rax
  802839:	00 00 00 
  80283c:	ff d0                	callq  *%rax
  80283e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802841:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802845:	0f 88 33 01 00 00    	js     80297e <pipe+0x1d4>
  80284b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80284f:	48 89 c7             	mov    %rax,%rdi
  802852:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802859:	00 00 00 
  80285c:	ff d0                	callq  *%rax
  80285e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802862:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802866:	ba 07 04 00 00       	mov    $0x407,%edx
  80286b:	48 89 c6             	mov    %rax,%rsi
  80286e:	bf 00 00 00 00       	mov    $0x0,%edi
  802873:	48 b8 93 0b 80 00 00 	movabs $0x800b93,%rax
  80287a:	00 00 00 
  80287d:	ff d0                	callq  *%rax
  80287f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802882:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802886:	79 05                	jns    80288d <pipe+0xe3>
  802888:	e9 d9 00 00 00       	jmpq   802966 <pipe+0x1bc>
  80288d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802891:	48 89 c7             	mov    %rax,%rdi
  802894:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  80289b:	00 00 00 
  80289e:	ff d0                	callq  *%rax
  8028a0:	48 89 c2             	mov    %rax,%rdx
  8028a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028a7:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8028ad:	48 89 d1             	mov    %rdx,%rcx
  8028b0:	ba 00 00 00 00       	mov    $0x0,%edx
  8028b5:	48 89 c6             	mov    %rax,%rsi
  8028b8:	bf 00 00 00 00       	mov    $0x0,%edi
  8028bd:	48 b8 e3 0b 80 00 00 	movabs $0x800be3,%rax
  8028c4:	00 00 00 
  8028c7:	ff d0                	callq  *%rax
  8028c9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8028cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8028d0:	79 1b                	jns    8028ed <pipe+0x143>
  8028d2:	90                   	nop
  8028d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8028d7:	48 89 c6             	mov    %rax,%rsi
  8028da:	bf 00 00 00 00       	mov    $0x0,%edi
  8028df:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  8028e6:	00 00 00 
  8028e9:	ff d0                	callq  *%rax
  8028eb:	eb 79                	jmp    802966 <pipe+0x1bc>
  8028ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028f1:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  8028f8:	00 00 00 
  8028fb:	8b 12                	mov    (%rdx),%edx
  8028fd:	89 10                	mov    %edx,(%rax)
  8028ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802903:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80290a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80290e:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  802915:	00 00 00 
  802918:	8b 12                	mov    (%rdx),%edx
  80291a:	89 10                	mov    %edx,(%rax)
  80291c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802920:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  802927:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80292b:	48 89 c7             	mov    %rax,%rdi
  80292e:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  802935:	00 00 00 
  802938:	ff d0                	callq  *%rax
  80293a:	89 c2                	mov    %eax,%edx
  80293c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802940:	89 10                	mov    %edx,(%rax)
  802942:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  802946:	48 8d 58 04          	lea    0x4(%rax),%rbx
  80294a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80294e:	48 89 c7             	mov    %rax,%rdi
  802951:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  802958:	00 00 00 
  80295b:	ff d0                	callq  *%rax
  80295d:	89 03                	mov    %eax,(%rbx)
  80295f:	b8 00 00 00 00       	mov    $0x0,%eax
  802964:	eb 33                	jmp    802999 <pipe+0x1ef>
  802966:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80296a:	48 89 c6             	mov    %rax,%rsi
  80296d:	bf 00 00 00 00       	mov    $0x0,%edi
  802972:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  802979:	00 00 00 
  80297c:	ff d0                	callq  *%rax
  80297e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802982:	48 89 c6             	mov    %rax,%rsi
  802985:	bf 00 00 00 00       	mov    $0x0,%edi
  80298a:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  802991:	00 00 00 
  802994:	ff d0                	callq  *%rax
  802996:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802999:	48 83 c4 38          	add    $0x38,%rsp
  80299d:	5b                   	pop    %rbx
  80299e:	5d                   	pop    %rbp
  80299f:	c3                   	retq   

00000000008029a0 <_pipeisclosed>:
  8029a0:	55                   	push   %rbp
  8029a1:	48 89 e5             	mov    %rsp,%rbp
  8029a4:	53                   	push   %rbx
  8029a5:	48 83 ec 28          	sub    $0x28,%rsp
  8029a9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8029ad:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8029b1:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8029b8:	00 00 00 
  8029bb:	48 8b 00             	mov    (%rax),%rax
  8029be:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8029c4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8029c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029cb:	48 89 c7             	mov    %rax,%rdi
  8029ce:	48 b8 e6 3f 80 00 00 	movabs $0x803fe6,%rax
  8029d5:	00 00 00 
  8029d8:	ff d0                	callq  *%rax
  8029da:	89 c3                	mov    %eax,%ebx
  8029dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8029e0:	48 89 c7             	mov    %rax,%rdi
  8029e3:	48 b8 e6 3f 80 00 00 	movabs $0x803fe6,%rax
  8029ea:	00 00 00 
  8029ed:	ff d0                	callq  *%rax
  8029ef:	39 c3                	cmp    %eax,%ebx
  8029f1:	0f 94 c0             	sete   %al
  8029f4:	0f b6 c0             	movzbl %al,%eax
  8029f7:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8029fa:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802a01:	00 00 00 
  802a04:	48 8b 00             	mov    (%rax),%rax
  802a07:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802a0d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  802a10:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a13:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  802a16:	75 05                	jne    802a1d <_pipeisclosed+0x7d>
  802a18:	8b 45 e8             	mov    -0x18(%rbp),%eax
  802a1b:	eb 4f                	jmp    802a6c <_pipeisclosed+0xcc>
  802a1d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a20:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  802a23:	74 42                	je     802a67 <_pipeisclosed+0xc7>
  802a25:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  802a29:	75 3c                	jne    802a67 <_pipeisclosed+0xc7>
  802a2b:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802a32:	00 00 00 
  802a35:	48 8b 00             	mov    (%rax),%rax
  802a38:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  802a3e:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  802a41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a44:	89 c6                	mov    %eax,%esi
  802a46:	48 bf 23 42 80 00 00 	movabs $0x804223,%rdi
  802a4d:	00 00 00 
  802a50:	b8 00 00 00 00       	mov    $0x0,%eax
  802a55:	49 b8 5f 32 80 00 00 	movabs $0x80325f,%r8
  802a5c:	00 00 00 
  802a5f:	41 ff d0             	callq  *%r8
  802a62:	e9 4a ff ff ff       	jmpq   8029b1 <_pipeisclosed+0x11>
  802a67:	e9 45 ff ff ff       	jmpq   8029b1 <_pipeisclosed+0x11>
  802a6c:	48 83 c4 28          	add    $0x28,%rsp
  802a70:	5b                   	pop    %rbx
  802a71:	5d                   	pop    %rbp
  802a72:	c3                   	retq   

0000000000802a73 <pipeisclosed>:
  802a73:	55                   	push   %rbp
  802a74:	48 89 e5             	mov    %rsp,%rbp
  802a77:	48 83 ec 30          	sub    $0x30,%rsp
  802a7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802a7e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802a82:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802a85:	48 89 d6             	mov    %rdx,%rsi
  802a88:	89 c7                	mov    %eax,%edi
  802a8a:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  802a91:	00 00 00 
  802a94:	ff d0                	callq  *%rax
  802a96:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802a99:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802a9d:	79 05                	jns    802aa4 <pipeisclosed+0x31>
  802a9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802aa2:	eb 31                	jmp    802ad5 <pipeisclosed+0x62>
  802aa4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802aa8:	48 89 c7             	mov    %rax,%rdi
  802aab:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802ab2:	00 00 00 
  802ab5:	ff d0                	callq  *%rax
  802ab7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802abb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802abf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802ac3:	48 89 d6             	mov    %rdx,%rsi
  802ac6:	48 89 c7             	mov    %rax,%rdi
  802ac9:	48 b8 a0 29 80 00 00 	movabs $0x8029a0,%rax
  802ad0:	00 00 00 
  802ad3:	ff d0                	callq  *%rax
  802ad5:	c9                   	leaveq 
  802ad6:	c3                   	retq   

0000000000802ad7 <devpipe_read>:
  802ad7:	55                   	push   %rbp
  802ad8:	48 89 e5             	mov    %rsp,%rbp
  802adb:	48 83 ec 40          	sub    $0x40,%rsp
  802adf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802ae3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802ae7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802aeb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802aef:	48 89 c7             	mov    %rax,%rdi
  802af2:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802af9:	00 00 00 
  802afc:	ff d0                	callq  *%rax
  802afe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802b02:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802b06:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802b0a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  802b11:	00 
  802b12:	e9 92 00 00 00       	jmpq   802ba9 <devpipe_read+0xd2>
  802b17:	eb 41                	jmp    802b5a <devpipe_read+0x83>
  802b19:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  802b1e:	74 09                	je     802b29 <devpipe_read+0x52>
  802b20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b24:	e9 92 00 00 00       	jmpq   802bbb <devpipe_read+0xe4>
  802b29:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b31:	48 89 d6             	mov    %rdx,%rsi
  802b34:	48 89 c7             	mov    %rax,%rdi
  802b37:	48 b8 a0 29 80 00 00 	movabs $0x8029a0,%rax
  802b3e:	00 00 00 
  802b41:	ff d0                	callq  *%rax
  802b43:	85 c0                	test   %eax,%eax
  802b45:	74 07                	je     802b4e <devpipe_read+0x77>
  802b47:	b8 00 00 00 00       	mov    $0x0,%eax
  802b4c:	eb 6d                	jmp    802bbb <devpipe_read+0xe4>
  802b4e:	48 b8 55 0b 80 00 00 	movabs $0x800b55,%rax
  802b55:	00 00 00 
  802b58:	ff d0                	callq  *%rax
  802b5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b5e:	8b 10                	mov    (%rax),%edx
  802b60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b64:	8b 40 04             	mov    0x4(%rax),%eax
  802b67:	39 c2                	cmp    %eax,%edx
  802b69:	74 ae                	je     802b19 <devpipe_read+0x42>
  802b6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b6f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802b73:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  802b77:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b7b:	8b 00                	mov    (%rax),%eax
  802b7d:	99                   	cltd   
  802b7e:	c1 ea 1b             	shr    $0x1b,%edx
  802b81:	01 d0                	add    %edx,%eax
  802b83:	83 e0 1f             	and    $0x1f,%eax
  802b86:	29 d0                	sub    %edx,%eax
  802b88:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b8c:	48 98                	cltq   
  802b8e:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  802b93:	88 01                	mov    %al,(%rcx)
  802b95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b99:	8b 00                	mov    (%rax),%eax
  802b9b:	8d 50 01             	lea    0x1(%rax),%edx
  802b9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ba2:	89 10                	mov    %edx,(%rax)
  802ba4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  802ba9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802bad:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802bb1:	0f 82 60 ff ff ff    	jb     802b17 <devpipe_read+0x40>
  802bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802bbb:	c9                   	leaveq 
  802bbc:	c3                   	retq   

0000000000802bbd <devpipe_write>:
  802bbd:	55                   	push   %rbp
  802bbe:	48 89 e5             	mov    %rsp,%rbp
  802bc1:	48 83 ec 40          	sub    $0x40,%rsp
  802bc5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802bc9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802bcd:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802bd1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802bd5:	48 89 c7             	mov    %rax,%rdi
  802bd8:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802bdf:	00 00 00 
  802be2:	ff d0                	callq  *%rax
  802be4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802be8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802bec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802bf0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  802bf7:	00 
  802bf8:	e9 8e 00 00 00       	jmpq   802c8b <devpipe_write+0xce>
  802bfd:	eb 31                	jmp    802c30 <devpipe_write+0x73>
  802bff:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c03:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c07:	48 89 d6             	mov    %rdx,%rsi
  802c0a:	48 89 c7             	mov    %rax,%rdi
  802c0d:	48 b8 a0 29 80 00 00 	movabs $0x8029a0,%rax
  802c14:	00 00 00 
  802c17:	ff d0                	callq  *%rax
  802c19:	85 c0                	test   %eax,%eax
  802c1b:	74 07                	je     802c24 <devpipe_write+0x67>
  802c1d:	b8 00 00 00 00       	mov    $0x0,%eax
  802c22:	eb 79                	jmp    802c9d <devpipe_write+0xe0>
  802c24:	48 b8 55 0b 80 00 00 	movabs $0x800b55,%rax
  802c2b:	00 00 00 
  802c2e:	ff d0                	callq  *%rax
  802c30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c34:	8b 40 04             	mov    0x4(%rax),%eax
  802c37:	48 63 d0             	movslq %eax,%rdx
  802c3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c3e:	8b 00                	mov    (%rax),%eax
  802c40:	48 98                	cltq   
  802c42:	48 83 c0 20          	add    $0x20,%rax
  802c46:	48 39 c2             	cmp    %rax,%rdx
  802c49:	73 b4                	jae    802bff <devpipe_write+0x42>
  802c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c4f:	8b 40 04             	mov    0x4(%rax),%eax
  802c52:	99                   	cltd   
  802c53:	c1 ea 1b             	shr    $0x1b,%edx
  802c56:	01 d0                	add    %edx,%eax
  802c58:	83 e0 1f             	and    $0x1f,%eax
  802c5b:	29 d0                	sub    %edx,%eax
  802c5d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802c61:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802c65:	48 01 ca             	add    %rcx,%rdx
  802c68:	0f b6 0a             	movzbl (%rdx),%ecx
  802c6b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802c6f:	48 98                	cltq   
  802c71:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  802c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c79:	8b 40 04             	mov    0x4(%rax),%eax
  802c7c:	8d 50 01             	lea    0x1(%rax),%edx
  802c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c83:	89 50 04             	mov    %edx,0x4(%rax)
  802c86:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  802c8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802c8f:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802c93:	0f 82 64 ff ff ff    	jb     802bfd <devpipe_write+0x40>
  802c99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802c9d:	c9                   	leaveq 
  802c9e:	c3                   	retq   

0000000000802c9f <devpipe_stat>:
  802c9f:	55                   	push   %rbp
  802ca0:	48 89 e5             	mov    %rsp,%rbp
  802ca3:	48 83 ec 20          	sub    $0x20,%rsp
  802ca7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802cab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802caf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cb3:	48 89 c7             	mov    %rax,%rdi
  802cb6:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802cbd:	00 00 00 
  802cc0:	ff d0                	callq  *%rax
  802cc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802cc6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802cca:	48 be 36 42 80 00 00 	movabs $0x804236,%rsi
  802cd1:	00 00 00 
  802cd4:	48 89 c7             	mov    %rax,%rdi
  802cd7:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  802cde:	00 00 00 
  802ce1:	ff d0                	callq  *%rax
  802ce3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ce7:	8b 50 04             	mov    0x4(%rax),%edx
  802cea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802cee:	8b 00                	mov    (%rax),%eax
  802cf0:	29 c2                	sub    %eax,%edx
  802cf2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802cf6:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802cfc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d00:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802d07:	00 00 00 
  802d0a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d0e:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  802d15:	00 00 00 
  802d18:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  802d1f:	b8 00 00 00 00       	mov    $0x0,%eax
  802d24:	c9                   	leaveq 
  802d25:	c3                   	retq   

0000000000802d26 <devpipe_close>:
  802d26:	55                   	push   %rbp
  802d27:	48 89 e5             	mov    %rsp,%rbp
  802d2a:	48 83 ec 10          	sub    $0x10,%rsp
  802d2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d36:	48 89 c6             	mov    %rax,%rsi
  802d39:	bf 00 00 00 00       	mov    $0x0,%edi
  802d3e:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  802d45:	00 00 00 
  802d48:	ff d0                	callq  *%rax
  802d4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d4e:	48 89 c7             	mov    %rax,%rdi
  802d51:	48 b8 96 0f 80 00 00 	movabs $0x800f96,%rax
  802d58:	00 00 00 
  802d5b:	ff d0                	callq  *%rax
  802d5d:	48 89 c6             	mov    %rax,%rsi
  802d60:	bf 00 00 00 00       	mov    $0x0,%edi
  802d65:	48 b8 3e 0c 80 00 00 	movabs $0x800c3e,%rax
  802d6c:	00 00 00 
  802d6f:	ff d0                	callq  *%rax
  802d71:	c9                   	leaveq 
  802d72:	c3                   	retq   

0000000000802d73 <cputchar>:
  802d73:	55                   	push   %rbp
  802d74:	48 89 e5             	mov    %rsp,%rbp
  802d77:	48 83 ec 20          	sub    $0x20,%rsp
  802d7b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d81:	88 45 ff             	mov    %al,-0x1(%rbp)
  802d84:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  802d88:	be 01 00 00 00       	mov    $0x1,%esi
  802d8d:	48 89 c7             	mov    %rax,%rdi
  802d90:	48 b8 4b 0a 80 00 00 	movabs $0x800a4b,%rax
  802d97:	00 00 00 
  802d9a:	ff d0                	callq  *%rax
  802d9c:	c9                   	leaveq 
  802d9d:	c3                   	retq   

0000000000802d9e <getchar>:
  802d9e:	55                   	push   %rbp
  802d9f:	48 89 e5             	mov    %rsp,%rbp
  802da2:	48 83 ec 10          	sub    $0x10,%rsp
  802da6:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  802daa:	ba 01 00 00 00       	mov    $0x1,%edx
  802daf:	48 89 c6             	mov    %rax,%rsi
  802db2:	bf 00 00 00 00       	mov    $0x0,%edi
  802db7:	48 b8 8b 14 80 00 00 	movabs $0x80148b,%rax
  802dbe:	00 00 00 
  802dc1:	ff d0                	callq  *%rax
  802dc3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802dc6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dca:	79 05                	jns    802dd1 <getchar+0x33>
  802dcc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dcf:	eb 14                	jmp    802de5 <getchar+0x47>
  802dd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802dd5:	7f 07                	jg     802dde <getchar+0x40>
  802dd7:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  802ddc:	eb 07                	jmp    802de5 <getchar+0x47>
  802dde:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  802de2:	0f b6 c0             	movzbl %al,%eax
  802de5:	c9                   	leaveq 
  802de6:	c3                   	retq   

0000000000802de7 <iscons>:
  802de7:	55                   	push   %rbp
  802de8:	48 89 e5             	mov    %rsp,%rbp
  802deb:	48 83 ec 20          	sub    $0x20,%rsp
  802def:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802df2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802df6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802df9:	48 89 d6             	mov    %rdx,%rsi
  802dfc:	89 c7                	mov    %eax,%edi
  802dfe:	48 b8 59 10 80 00 00 	movabs $0x801059,%rax
  802e05:	00 00 00 
  802e08:	ff d0                	callq  *%rax
  802e0a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e0d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e11:	79 05                	jns    802e18 <iscons+0x31>
  802e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e16:	eb 1a                	jmp    802e32 <iscons+0x4b>
  802e18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e1c:	8b 10                	mov    (%rax),%edx
  802e1e:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  802e25:	00 00 00 
  802e28:	8b 00                	mov    (%rax),%eax
  802e2a:	39 c2                	cmp    %eax,%edx
  802e2c:	0f 94 c0             	sete   %al
  802e2f:	0f b6 c0             	movzbl %al,%eax
  802e32:	c9                   	leaveq 
  802e33:	c3                   	retq   

0000000000802e34 <opencons>:
  802e34:	55                   	push   %rbp
  802e35:	48 89 e5             	mov    %rsp,%rbp
  802e38:	48 83 ec 10          	sub    $0x10,%rsp
  802e3c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802e40:	48 89 c7             	mov    %rax,%rdi
  802e43:	48 b8 c1 0f 80 00 00 	movabs $0x800fc1,%rax
  802e4a:	00 00 00 
  802e4d:	ff d0                	callq  *%rax
  802e4f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e52:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e56:	79 05                	jns    802e5d <opencons+0x29>
  802e58:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e5b:	eb 5b                	jmp    802eb8 <opencons+0x84>
  802e5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e61:	ba 07 04 00 00       	mov    $0x407,%edx
  802e66:	48 89 c6             	mov    %rax,%rsi
  802e69:	bf 00 00 00 00       	mov    $0x0,%edi
  802e6e:	48 b8 93 0b 80 00 00 	movabs $0x800b93,%rax
  802e75:	00 00 00 
  802e78:	ff d0                	callq  *%rax
  802e7a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e7d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e81:	79 05                	jns    802e88 <opencons+0x54>
  802e83:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e86:	eb 30                	jmp    802eb8 <opencons+0x84>
  802e88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e8c:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  802e93:	00 00 00 
  802e96:	8b 12                	mov    (%rdx),%edx
  802e98:	89 10                	mov    %edx,(%rax)
  802e9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e9e:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ea9:	48 89 c7             	mov    %rax,%rdi
  802eac:	48 b8 73 0f 80 00 00 	movabs $0x800f73,%rax
  802eb3:	00 00 00 
  802eb6:	ff d0                	callq  *%rax
  802eb8:	c9                   	leaveq 
  802eb9:	c3                   	retq   

0000000000802eba <devcons_read>:
  802eba:	55                   	push   %rbp
  802ebb:	48 89 e5             	mov    %rsp,%rbp
  802ebe:	48 83 ec 30          	sub    $0x30,%rsp
  802ec2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ec6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802eca:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802ece:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802ed3:	75 07                	jne    802edc <devcons_read+0x22>
  802ed5:	b8 00 00 00 00       	mov    $0x0,%eax
  802eda:	eb 4b                	jmp    802f27 <devcons_read+0x6d>
  802edc:	eb 0c                	jmp    802eea <devcons_read+0x30>
  802ede:	48 b8 55 0b 80 00 00 	movabs $0x800b55,%rax
  802ee5:	00 00 00 
  802ee8:	ff d0                	callq  *%rax
  802eea:	48 b8 95 0a 80 00 00 	movabs $0x800a95,%rax
  802ef1:	00 00 00 
  802ef4:	ff d0                	callq  *%rax
  802ef6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ef9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802efd:	74 df                	je     802ede <devcons_read+0x24>
  802eff:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f03:	79 05                	jns    802f0a <devcons_read+0x50>
  802f05:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f08:	eb 1d                	jmp    802f27 <devcons_read+0x6d>
  802f0a:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  802f0e:	75 07                	jne    802f17 <devcons_read+0x5d>
  802f10:	b8 00 00 00 00       	mov    $0x0,%eax
  802f15:	eb 10                	jmp    802f27 <devcons_read+0x6d>
  802f17:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f1a:	89 c2                	mov    %eax,%edx
  802f1c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802f20:	88 10                	mov    %dl,(%rax)
  802f22:	b8 01 00 00 00       	mov    $0x1,%eax
  802f27:	c9                   	leaveq 
  802f28:	c3                   	retq   

0000000000802f29 <devcons_write>:
  802f29:	55                   	push   %rbp
  802f2a:	48 89 e5             	mov    %rsp,%rbp
  802f2d:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  802f34:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  802f3b:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  802f42:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  802f49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802f50:	eb 76                	jmp    802fc8 <devcons_write+0x9f>
  802f52:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  802f59:	89 c2                	mov    %eax,%edx
  802f5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f5e:	29 c2                	sub    %eax,%edx
  802f60:	89 d0                	mov    %edx,%eax
  802f62:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802f65:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f68:	83 f8 7f             	cmp    $0x7f,%eax
  802f6b:	76 07                	jbe    802f74 <devcons_write+0x4b>
  802f6d:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  802f74:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802f77:	48 63 d0             	movslq %eax,%rdx
  802f7a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f7d:	48 63 c8             	movslq %eax,%rcx
  802f80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  802f87:	48 01 c1             	add    %rax,%rcx
  802f8a:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  802f91:	48 89 ce             	mov    %rcx,%rsi
  802f94:	48 89 c7             	mov    %rax,%rdi
  802f97:	48 b8 88 05 80 00 00 	movabs $0x800588,%rax
  802f9e:	00 00 00 
  802fa1:	ff d0                	callq  *%rax
  802fa3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802fa6:	48 63 d0             	movslq %eax,%rdx
  802fa9:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  802fb0:	48 89 d6             	mov    %rdx,%rsi
  802fb3:	48 89 c7             	mov    %rax,%rdi
  802fb6:	48 b8 4b 0a 80 00 00 	movabs $0x800a4b,%rax
  802fbd:	00 00 00 
  802fc0:	ff d0                	callq  *%rax
  802fc2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802fc5:	01 45 fc             	add    %eax,-0x4(%rbp)
  802fc8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fcb:	48 98                	cltq   
  802fcd:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  802fd4:	0f 82 78 ff ff ff    	jb     802f52 <devcons_write+0x29>
  802fda:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fdd:	c9                   	leaveq 
  802fde:	c3                   	retq   

0000000000802fdf <devcons_close>:
  802fdf:	55                   	push   %rbp
  802fe0:	48 89 e5             	mov    %rsp,%rbp
  802fe3:	48 83 ec 08          	sub    $0x8,%rsp
  802fe7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802feb:	b8 00 00 00 00       	mov    $0x0,%eax
  802ff0:	c9                   	leaveq 
  802ff1:	c3                   	retq   

0000000000802ff2 <devcons_stat>:
  802ff2:	55                   	push   %rbp
  802ff3:	48 89 e5             	mov    %rsp,%rbp
  802ff6:	48 83 ec 10          	sub    $0x10,%rsp
  802ffa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802ffe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803002:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803006:	48 be 42 42 80 00 00 	movabs $0x804242,%rsi
  80300d:	00 00 00 
  803010:	48 89 c7             	mov    %rax,%rdi
  803013:	48 b8 64 02 80 00 00 	movabs $0x800264,%rax
  80301a:	00 00 00 
  80301d:	ff d0                	callq  *%rax
  80301f:	b8 00 00 00 00       	mov    $0x0,%eax
  803024:	c9                   	leaveq 
  803025:	c3                   	retq   

0000000000803026 <_panic>:
  803026:	55                   	push   %rbp
  803027:	48 89 e5             	mov    %rsp,%rbp
  80302a:	53                   	push   %rbx
  80302b:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803032:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  803039:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  80303f:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  803046:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  80304d:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  803054:	84 c0                	test   %al,%al
  803056:	74 23                	je     80307b <_panic+0x55>
  803058:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  80305f:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  803063:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  803067:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80306b:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  80306f:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  803073:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  803077:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80307b:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  803082:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  803089:	00 00 00 
  80308c:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  803093:	00 00 00 
  803096:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80309a:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  8030a1:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8030a8:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8030af:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8030b6:	00 00 00 
  8030b9:	48 8b 18             	mov    (%rax),%rbx
  8030bc:	48 b8 17 0b 80 00 00 	movabs $0x800b17,%rax
  8030c3:	00 00 00 
  8030c6:	ff d0                	callq  *%rax
  8030c8:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8030ce:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8030d5:	41 89 c8             	mov    %ecx,%r8d
  8030d8:	48 89 d1             	mov    %rdx,%rcx
  8030db:	48 89 da             	mov    %rbx,%rdx
  8030de:	89 c6                	mov    %eax,%esi
  8030e0:	48 bf 50 42 80 00 00 	movabs $0x804250,%rdi
  8030e7:	00 00 00 
  8030ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8030ef:	49 b9 5f 32 80 00 00 	movabs $0x80325f,%r9
  8030f6:	00 00 00 
  8030f9:	41 ff d1             	callq  *%r9
  8030fc:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  803103:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80310a:	48 89 d6             	mov    %rdx,%rsi
  80310d:	48 89 c7             	mov    %rax,%rdi
  803110:	48 b8 b3 31 80 00 00 	movabs $0x8031b3,%rax
  803117:	00 00 00 
  80311a:	ff d0                	callq  *%rax
  80311c:	48 bf 73 42 80 00 00 	movabs $0x804273,%rdi
  803123:	00 00 00 
  803126:	b8 00 00 00 00       	mov    $0x0,%eax
  80312b:	48 ba 5f 32 80 00 00 	movabs $0x80325f,%rdx
  803132:	00 00 00 
  803135:	ff d2                	callq  *%rdx
  803137:	cc                   	int3   
  803138:	eb fd                	jmp    803137 <_panic+0x111>

000000000080313a <putch>:
  80313a:	55                   	push   %rbp
  80313b:	48 89 e5             	mov    %rsp,%rbp
  80313e:	48 83 ec 10          	sub    $0x10,%rsp
  803142:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803145:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803149:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80314d:	8b 00                	mov    (%rax),%eax
  80314f:	8d 48 01             	lea    0x1(%rax),%ecx
  803152:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803156:	89 0a                	mov    %ecx,(%rdx)
  803158:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80315b:	89 d1                	mov    %edx,%ecx
  80315d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803161:	48 98                	cltq   
  803163:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  803167:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80316b:	8b 00                	mov    (%rax),%eax
  80316d:	3d ff 00 00 00       	cmp    $0xff,%eax
  803172:	75 2c                	jne    8031a0 <putch+0x66>
  803174:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803178:	8b 00                	mov    (%rax),%eax
  80317a:	48 98                	cltq   
  80317c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803180:	48 83 c2 08          	add    $0x8,%rdx
  803184:	48 89 c6             	mov    %rax,%rsi
  803187:	48 89 d7             	mov    %rdx,%rdi
  80318a:	48 b8 4b 0a 80 00 00 	movabs $0x800a4b,%rax
  803191:	00 00 00 
  803194:	ff d0                	callq  *%rax
  803196:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80319a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8031a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031a4:	8b 40 04             	mov    0x4(%rax),%eax
  8031a7:	8d 50 01             	lea    0x1(%rax),%edx
  8031aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031ae:	89 50 04             	mov    %edx,0x4(%rax)
  8031b1:	c9                   	leaveq 
  8031b2:	c3                   	retq   

00000000008031b3 <vcprintf>:
  8031b3:	55                   	push   %rbp
  8031b4:	48 89 e5             	mov    %rsp,%rbp
  8031b7:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8031be:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8031c5:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8031cc:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8031d3:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8031da:	48 8b 0a             	mov    (%rdx),%rcx
  8031dd:	48 89 08             	mov    %rcx,(%rax)
  8031e0:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8031e4:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8031e8:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8031ec:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8031f0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  8031f7:	00 00 00 
  8031fa:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  803201:	00 00 00 
  803204:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  80320b:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  803212:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  803219:	48 89 c6             	mov    %rax,%rsi
  80321c:	48 bf 3a 31 80 00 00 	movabs $0x80313a,%rdi
  803223:	00 00 00 
  803226:	48 b8 12 36 80 00 00 	movabs $0x803612,%rax
  80322d:	00 00 00 
  803230:	ff d0                	callq  *%rax
  803232:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  803238:	48 98                	cltq   
  80323a:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  803241:	48 83 c2 08          	add    $0x8,%rdx
  803245:	48 89 c6             	mov    %rax,%rsi
  803248:	48 89 d7             	mov    %rdx,%rdi
  80324b:	48 b8 4b 0a 80 00 00 	movabs $0x800a4b,%rax
  803252:	00 00 00 
  803255:	ff d0                	callq  *%rax
  803257:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  80325d:	c9                   	leaveq 
  80325e:	c3                   	retq   

000000000080325f <cprintf>:
  80325f:	55                   	push   %rbp
  803260:	48 89 e5             	mov    %rsp,%rbp
  803263:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  80326a:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  803271:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  803278:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  80327f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803286:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80328d:	84 c0                	test   %al,%al
  80328f:	74 20                	je     8032b1 <cprintf+0x52>
  803291:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803295:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803299:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80329d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8032a1:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8032a5:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8032a9:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8032ad:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8032b1:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8032b8:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8032bf:	00 00 00 
  8032c2:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8032c9:	00 00 00 
  8032cc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8032d0:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8032d7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8032de:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8032e5:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8032ec:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8032f3:	48 8b 0a             	mov    (%rdx),%rcx
  8032f6:	48 89 08             	mov    %rcx,(%rax)
  8032f9:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8032fd:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803301:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803305:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803309:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  803310:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803317:	48 89 d6             	mov    %rdx,%rsi
  80331a:	48 89 c7             	mov    %rax,%rdi
  80331d:	48 b8 b3 31 80 00 00 	movabs $0x8031b3,%rax
  803324:	00 00 00 
  803327:	ff d0                	callq  *%rax
  803329:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80332f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  803335:	c9                   	leaveq 
  803336:	c3                   	retq   

0000000000803337 <printnum>:
  803337:	55                   	push   %rbp
  803338:	48 89 e5             	mov    %rsp,%rbp
  80333b:	53                   	push   %rbx
  80333c:	48 83 ec 38          	sub    $0x38,%rsp
  803340:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803344:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803348:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80334c:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  80334f:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  803353:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  803357:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80335a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80335e:	77 3b                	ja     80339b <printnum+0x64>
  803360:	8b 45 d0             	mov    -0x30(%rbp),%eax
  803363:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  803367:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  80336a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80336e:	ba 00 00 00 00       	mov    $0x0,%edx
  803373:	48 f7 f3             	div    %rbx
  803376:	48 89 c2             	mov    %rax,%rdx
  803379:	8b 7d cc             	mov    -0x34(%rbp),%edi
  80337c:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80337f:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  803383:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803387:	41 89 f9             	mov    %edi,%r9d
  80338a:	48 89 c7             	mov    %rax,%rdi
  80338d:	48 b8 37 33 80 00 00 	movabs $0x803337,%rax
  803394:	00 00 00 
  803397:	ff d0                	callq  *%rax
  803399:	eb 1e                	jmp    8033b9 <printnum+0x82>
  80339b:	eb 12                	jmp    8033af <printnum+0x78>
  80339d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8033a1:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8033a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033a8:	48 89 ce             	mov    %rcx,%rsi
  8033ab:	89 d7                	mov    %edx,%edi
  8033ad:	ff d0                	callq  *%rax
  8033af:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8033b3:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8033b7:	7f e4                	jg     80339d <printnum+0x66>
  8033b9:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8033bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8033c0:	ba 00 00 00 00       	mov    $0x0,%edx
  8033c5:	48 f7 f1             	div    %rcx
  8033c8:	48 89 d0             	mov    %rdx,%rax
  8033cb:	48 ba 70 44 80 00 00 	movabs $0x804470,%rdx
  8033d2:	00 00 00 
  8033d5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8033d9:	0f be d0             	movsbl %al,%edx
  8033dc:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8033e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033e4:	48 89 ce             	mov    %rcx,%rsi
  8033e7:	89 d7                	mov    %edx,%edi
  8033e9:	ff d0                	callq  *%rax
  8033eb:	48 83 c4 38          	add    $0x38,%rsp
  8033ef:	5b                   	pop    %rbx
  8033f0:	5d                   	pop    %rbp
  8033f1:	c3                   	retq   

00000000008033f2 <getuint>:
  8033f2:	55                   	push   %rbp
  8033f3:	48 89 e5             	mov    %rsp,%rbp
  8033f6:	48 83 ec 1c          	sub    $0x1c,%rsp
  8033fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8033fe:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  803401:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  803405:	7e 52                	jle    803459 <getuint+0x67>
  803407:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80340b:	8b 00                	mov    (%rax),%eax
  80340d:	83 f8 30             	cmp    $0x30,%eax
  803410:	73 24                	jae    803436 <getuint+0x44>
  803412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803416:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80341a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80341e:	8b 00                	mov    (%rax),%eax
  803420:	89 c0                	mov    %eax,%eax
  803422:	48 01 d0             	add    %rdx,%rax
  803425:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803429:	8b 12                	mov    (%rdx),%edx
  80342b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80342e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803432:	89 0a                	mov    %ecx,(%rdx)
  803434:	eb 17                	jmp    80344d <getuint+0x5b>
  803436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80343a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80343e:	48 89 d0             	mov    %rdx,%rax
  803441:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803445:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803449:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80344d:	48 8b 00             	mov    (%rax),%rax
  803450:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803454:	e9 a3 00 00 00       	jmpq   8034fc <getuint+0x10a>
  803459:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80345d:	74 4f                	je     8034ae <getuint+0xbc>
  80345f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803463:	8b 00                	mov    (%rax),%eax
  803465:	83 f8 30             	cmp    $0x30,%eax
  803468:	73 24                	jae    80348e <getuint+0x9c>
  80346a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80346e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  803472:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803476:	8b 00                	mov    (%rax),%eax
  803478:	89 c0                	mov    %eax,%eax
  80347a:	48 01 d0             	add    %rdx,%rax
  80347d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803481:	8b 12                	mov    (%rdx),%edx
  803483:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803486:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80348a:	89 0a                	mov    %ecx,(%rdx)
  80348c:	eb 17                	jmp    8034a5 <getuint+0xb3>
  80348e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803492:	48 8b 50 08          	mov    0x8(%rax),%rdx
  803496:	48 89 d0             	mov    %rdx,%rax
  803499:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80349d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8034a1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8034a5:	48 8b 00             	mov    (%rax),%rax
  8034a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8034ac:	eb 4e                	jmp    8034fc <getuint+0x10a>
  8034ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034b2:	8b 00                	mov    (%rax),%eax
  8034b4:	83 f8 30             	cmp    $0x30,%eax
  8034b7:	73 24                	jae    8034dd <getuint+0xeb>
  8034b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8034c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034c5:	8b 00                	mov    (%rax),%eax
  8034c7:	89 c0                	mov    %eax,%eax
  8034c9:	48 01 d0             	add    %rdx,%rax
  8034cc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8034d0:	8b 12                	mov    (%rdx),%edx
  8034d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8034d5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8034d9:	89 0a                	mov    %ecx,(%rdx)
  8034db:	eb 17                	jmp    8034f4 <getuint+0x102>
  8034dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034e1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8034e5:	48 89 d0             	mov    %rdx,%rax
  8034e8:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8034ec:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8034f0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8034f4:	8b 00                	mov    (%rax),%eax
  8034f6:	89 c0                	mov    %eax,%eax
  8034f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8034fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803500:	c9                   	leaveq 
  803501:	c3                   	retq   

0000000000803502 <getint>:
  803502:	55                   	push   %rbp
  803503:	48 89 e5             	mov    %rsp,%rbp
  803506:	48 83 ec 1c          	sub    $0x1c,%rsp
  80350a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80350e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  803511:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  803515:	7e 52                	jle    803569 <getint+0x67>
  803517:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80351b:	8b 00                	mov    (%rax),%eax
  80351d:	83 f8 30             	cmp    $0x30,%eax
  803520:	73 24                	jae    803546 <getint+0x44>
  803522:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803526:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80352a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80352e:	8b 00                	mov    (%rax),%eax
  803530:	89 c0                	mov    %eax,%eax
  803532:	48 01 d0             	add    %rdx,%rax
  803535:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803539:	8b 12                	mov    (%rdx),%edx
  80353b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80353e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803542:	89 0a                	mov    %ecx,(%rdx)
  803544:	eb 17                	jmp    80355d <getint+0x5b>
  803546:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80354a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  80354e:	48 89 d0             	mov    %rdx,%rax
  803551:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  803555:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803559:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80355d:	48 8b 00             	mov    (%rax),%rax
  803560:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803564:	e9 a3 00 00 00       	jmpq   80360c <getint+0x10a>
  803569:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80356d:	74 4f                	je     8035be <getint+0xbc>
  80356f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803573:	8b 00                	mov    (%rax),%eax
  803575:	83 f8 30             	cmp    $0x30,%eax
  803578:	73 24                	jae    80359e <getint+0x9c>
  80357a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80357e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  803582:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803586:	8b 00                	mov    (%rax),%eax
  803588:	89 c0                	mov    %eax,%eax
  80358a:	48 01 d0             	add    %rdx,%rax
  80358d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803591:	8b 12                	mov    (%rdx),%edx
  803593:	8d 4a 08             	lea    0x8(%rdx),%ecx
  803596:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80359a:	89 0a                	mov    %ecx,(%rdx)
  80359c:	eb 17                	jmp    8035b5 <getint+0xb3>
  80359e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035a2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8035a6:	48 89 d0             	mov    %rdx,%rax
  8035a9:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8035ad:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8035b1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8035b5:	48 8b 00             	mov    (%rax),%rax
  8035b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8035bc:	eb 4e                	jmp    80360c <getint+0x10a>
  8035be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035c2:	8b 00                	mov    (%rax),%eax
  8035c4:	83 f8 30             	cmp    $0x30,%eax
  8035c7:	73 24                	jae    8035ed <getint+0xeb>
  8035c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8035d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035d5:	8b 00                	mov    (%rax),%eax
  8035d7:	89 c0                	mov    %eax,%eax
  8035d9:	48 01 d0             	add    %rdx,%rax
  8035dc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8035e0:	8b 12                	mov    (%rdx),%edx
  8035e2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8035e5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8035e9:	89 0a                	mov    %ecx,(%rdx)
  8035eb:	eb 17                	jmp    803604 <getint+0x102>
  8035ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035f1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8035f5:	48 89 d0             	mov    %rdx,%rax
  8035f8:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8035fc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803600:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  803604:	8b 00                	mov    (%rax),%eax
  803606:	48 98                	cltq   
  803608:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80360c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803610:	c9                   	leaveq 
  803611:	c3                   	retq   

0000000000803612 <vprintfmt>:
  803612:	55                   	push   %rbp
  803613:	48 89 e5             	mov    %rsp,%rbp
  803616:	41 54                	push   %r12
  803618:	53                   	push   %rbx
  803619:	48 83 ec 60          	sub    $0x60,%rsp
  80361d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  803621:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  803625:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  803629:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  80362d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803631:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  803635:	48 8b 0a             	mov    (%rdx),%rcx
  803638:	48 89 08             	mov    %rcx,(%rax)
  80363b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80363f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803643:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803647:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80364b:	eb 17                	jmp    803664 <vprintfmt+0x52>
  80364d:	85 db                	test   %ebx,%ebx
  80364f:	0f 84 cc 04 00 00    	je     803b21 <vprintfmt+0x50f>
  803655:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803659:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80365d:	48 89 d6             	mov    %rdx,%rsi
  803660:	89 df                	mov    %ebx,%edi
  803662:	ff d0                	callq  *%rax
  803664:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803668:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80366c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  803670:	0f b6 00             	movzbl (%rax),%eax
  803673:	0f b6 d8             	movzbl %al,%ebx
  803676:	83 fb 25             	cmp    $0x25,%ebx
  803679:	75 d2                	jne    80364d <vprintfmt+0x3b>
  80367b:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  80367f:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  803686:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80368d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  803694:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  80369b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80369f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8036a3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8036a7:	0f b6 00             	movzbl (%rax),%eax
  8036aa:	0f b6 d8             	movzbl %al,%ebx
  8036ad:	8d 43 dd             	lea    -0x23(%rbx),%eax
  8036b0:	83 f8 55             	cmp    $0x55,%eax
  8036b3:	0f 87 34 04 00 00    	ja     803aed <vprintfmt+0x4db>
  8036b9:	89 c0                	mov    %eax,%eax
  8036bb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8036c2:	00 
  8036c3:	48 b8 98 44 80 00 00 	movabs $0x804498,%rax
  8036ca:	00 00 00 
  8036cd:	48 01 d0             	add    %rdx,%rax
  8036d0:	48 8b 00             	mov    (%rax),%rax
  8036d3:	ff e0                	jmpq   *%rax
  8036d5:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8036d9:	eb c0                	jmp    80369b <vprintfmt+0x89>
  8036db:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8036df:	eb ba                	jmp    80369b <vprintfmt+0x89>
  8036e1:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8036e8:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8036eb:	89 d0                	mov    %edx,%eax
  8036ed:	c1 e0 02             	shl    $0x2,%eax
  8036f0:	01 d0                	add    %edx,%eax
  8036f2:	01 c0                	add    %eax,%eax
  8036f4:	01 d8                	add    %ebx,%eax
  8036f6:	83 e8 30             	sub    $0x30,%eax
  8036f9:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8036fc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803700:	0f b6 00             	movzbl (%rax),%eax
  803703:	0f be d8             	movsbl %al,%ebx
  803706:	83 fb 2f             	cmp    $0x2f,%ebx
  803709:	7e 0c                	jle    803717 <vprintfmt+0x105>
  80370b:	83 fb 39             	cmp    $0x39,%ebx
  80370e:	7f 07                	jg     803717 <vprintfmt+0x105>
  803710:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  803715:	eb d1                	jmp    8036e8 <vprintfmt+0xd6>
  803717:	eb 58                	jmp    803771 <vprintfmt+0x15f>
  803719:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80371c:	83 f8 30             	cmp    $0x30,%eax
  80371f:	73 17                	jae    803738 <vprintfmt+0x126>
  803721:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803725:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803728:	89 c0                	mov    %eax,%eax
  80372a:	48 01 d0             	add    %rdx,%rax
  80372d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803730:	83 c2 08             	add    $0x8,%edx
  803733:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803736:	eb 0f                	jmp    803747 <vprintfmt+0x135>
  803738:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80373c:	48 89 d0             	mov    %rdx,%rax
  80373f:	48 83 c2 08          	add    $0x8,%rdx
  803743:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803747:	8b 00                	mov    (%rax),%eax
  803749:	89 45 d8             	mov    %eax,-0x28(%rbp)
  80374c:	eb 23                	jmp    803771 <vprintfmt+0x15f>
  80374e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803752:	79 0c                	jns    803760 <vprintfmt+0x14e>
  803754:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  80375b:	e9 3b ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  803760:	e9 36 ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  803765:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  80376c:	e9 2a ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  803771:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803775:	79 12                	jns    803789 <vprintfmt+0x177>
  803777:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80377a:	89 45 dc             	mov    %eax,-0x24(%rbp)
  80377d:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  803784:	e9 12 ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  803789:	e9 0d ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  80378e:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  803792:	e9 04 ff ff ff       	jmpq   80369b <vprintfmt+0x89>
  803797:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80379a:	83 f8 30             	cmp    $0x30,%eax
  80379d:	73 17                	jae    8037b6 <vprintfmt+0x1a4>
  80379f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8037a3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8037a6:	89 c0                	mov    %eax,%eax
  8037a8:	48 01 d0             	add    %rdx,%rax
  8037ab:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8037ae:	83 c2 08             	add    $0x8,%edx
  8037b1:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8037b4:	eb 0f                	jmp    8037c5 <vprintfmt+0x1b3>
  8037b6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8037ba:	48 89 d0             	mov    %rdx,%rax
  8037bd:	48 83 c2 08          	add    $0x8,%rdx
  8037c1:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8037c5:	8b 10                	mov    (%rax),%edx
  8037c7:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8037cb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8037cf:	48 89 ce             	mov    %rcx,%rsi
  8037d2:	89 d7                	mov    %edx,%edi
  8037d4:	ff d0                	callq  *%rax
  8037d6:	e9 40 03 00 00       	jmpq   803b1b <vprintfmt+0x509>
  8037db:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8037de:	83 f8 30             	cmp    $0x30,%eax
  8037e1:	73 17                	jae    8037fa <vprintfmt+0x1e8>
  8037e3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8037e7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8037ea:	89 c0                	mov    %eax,%eax
  8037ec:	48 01 d0             	add    %rdx,%rax
  8037ef:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8037f2:	83 c2 08             	add    $0x8,%edx
  8037f5:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8037f8:	eb 0f                	jmp    803809 <vprintfmt+0x1f7>
  8037fa:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8037fe:	48 89 d0             	mov    %rdx,%rax
  803801:	48 83 c2 08          	add    $0x8,%rdx
  803805:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803809:	8b 18                	mov    (%rax),%ebx
  80380b:	85 db                	test   %ebx,%ebx
  80380d:	79 02                	jns    803811 <vprintfmt+0x1ff>
  80380f:	f7 db                	neg    %ebx
  803811:	83 fb 15             	cmp    $0x15,%ebx
  803814:	7f 16                	jg     80382c <vprintfmt+0x21a>
  803816:	48 b8 c0 43 80 00 00 	movabs $0x8043c0,%rax
  80381d:	00 00 00 
  803820:	48 63 d3             	movslq %ebx,%rdx
  803823:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  803827:	4d 85 e4             	test   %r12,%r12
  80382a:	75 2e                	jne    80385a <vprintfmt+0x248>
  80382c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803830:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803834:	89 d9                	mov    %ebx,%ecx
  803836:	48 ba 81 44 80 00 00 	movabs $0x804481,%rdx
  80383d:	00 00 00 
  803840:	48 89 c7             	mov    %rax,%rdi
  803843:	b8 00 00 00 00       	mov    $0x0,%eax
  803848:	49 b8 2a 3b 80 00 00 	movabs $0x803b2a,%r8
  80384f:	00 00 00 
  803852:	41 ff d0             	callq  *%r8
  803855:	e9 c1 02 00 00       	jmpq   803b1b <vprintfmt+0x509>
  80385a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80385e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803862:	4c 89 e1             	mov    %r12,%rcx
  803865:	48 ba 8a 44 80 00 00 	movabs $0x80448a,%rdx
  80386c:	00 00 00 
  80386f:	48 89 c7             	mov    %rax,%rdi
  803872:	b8 00 00 00 00       	mov    $0x0,%eax
  803877:	49 b8 2a 3b 80 00 00 	movabs $0x803b2a,%r8
  80387e:	00 00 00 
  803881:	41 ff d0             	callq  *%r8
  803884:	e9 92 02 00 00       	jmpq   803b1b <vprintfmt+0x509>
  803889:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80388c:	83 f8 30             	cmp    $0x30,%eax
  80388f:	73 17                	jae    8038a8 <vprintfmt+0x296>
  803891:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803895:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803898:	89 c0                	mov    %eax,%eax
  80389a:	48 01 d0             	add    %rdx,%rax
  80389d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8038a0:	83 c2 08             	add    $0x8,%edx
  8038a3:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8038a6:	eb 0f                	jmp    8038b7 <vprintfmt+0x2a5>
  8038a8:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8038ac:	48 89 d0             	mov    %rdx,%rax
  8038af:	48 83 c2 08          	add    $0x8,%rdx
  8038b3:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8038b7:	4c 8b 20             	mov    (%rax),%r12
  8038ba:	4d 85 e4             	test   %r12,%r12
  8038bd:	75 0a                	jne    8038c9 <vprintfmt+0x2b7>
  8038bf:	49 bc 8d 44 80 00 00 	movabs $0x80448d,%r12
  8038c6:	00 00 00 
  8038c9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8038cd:	7e 3f                	jle    80390e <vprintfmt+0x2fc>
  8038cf:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  8038d3:	74 39                	je     80390e <vprintfmt+0x2fc>
  8038d5:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8038d8:	48 98                	cltq   
  8038da:	48 89 c6             	mov    %rax,%rsi
  8038dd:	4c 89 e7             	mov    %r12,%rdi
  8038e0:	48 b8 26 02 80 00 00 	movabs $0x800226,%rax
  8038e7:	00 00 00 
  8038ea:	ff d0                	callq  *%rax
  8038ec:	29 45 dc             	sub    %eax,-0x24(%rbp)
  8038ef:	eb 17                	jmp    803908 <vprintfmt+0x2f6>
  8038f1:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  8038f5:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8038f9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8038fd:	48 89 ce             	mov    %rcx,%rsi
  803900:	89 d7                	mov    %edx,%edi
  803902:	ff d0                	callq  *%rax
  803904:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803908:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80390c:	7f e3                	jg     8038f1 <vprintfmt+0x2df>
  80390e:	eb 37                	jmp    803947 <vprintfmt+0x335>
  803910:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  803914:	74 1e                	je     803934 <vprintfmt+0x322>
  803916:	83 fb 1f             	cmp    $0x1f,%ebx
  803919:	7e 05                	jle    803920 <vprintfmt+0x30e>
  80391b:	83 fb 7e             	cmp    $0x7e,%ebx
  80391e:	7e 14                	jle    803934 <vprintfmt+0x322>
  803920:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803924:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803928:	48 89 d6             	mov    %rdx,%rsi
  80392b:	bf 3f 00 00 00       	mov    $0x3f,%edi
  803930:	ff d0                	callq  *%rax
  803932:	eb 0f                	jmp    803943 <vprintfmt+0x331>
  803934:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803938:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80393c:	48 89 d6             	mov    %rdx,%rsi
  80393f:	89 df                	mov    %ebx,%edi
  803941:	ff d0                	callq  *%rax
  803943:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803947:	4c 89 e0             	mov    %r12,%rax
  80394a:	4c 8d 60 01          	lea    0x1(%rax),%r12
  80394e:	0f b6 00             	movzbl (%rax),%eax
  803951:	0f be d8             	movsbl %al,%ebx
  803954:	85 db                	test   %ebx,%ebx
  803956:	74 10                	je     803968 <vprintfmt+0x356>
  803958:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  80395c:	78 b2                	js     803910 <vprintfmt+0x2fe>
  80395e:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  803962:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  803966:	79 a8                	jns    803910 <vprintfmt+0x2fe>
  803968:	eb 16                	jmp    803980 <vprintfmt+0x36e>
  80396a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80396e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803972:	48 89 d6             	mov    %rdx,%rsi
  803975:	bf 20 00 00 00       	mov    $0x20,%edi
  80397a:	ff d0                	callq  *%rax
  80397c:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803980:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  803984:	7f e4                	jg     80396a <vprintfmt+0x358>
  803986:	e9 90 01 00 00       	jmpq   803b1b <vprintfmt+0x509>
  80398b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80398f:	be 03 00 00 00       	mov    $0x3,%esi
  803994:	48 89 c7             	mov    %rax,%rdi
  803997:	48 b8 02 35 80 00 00 	movabs $0x803502,%rax
  80399e:	00 00 00 
  8039a1:	ff d0                	callq  *%rax
  8039a3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8039a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039ab:	48 85 c0             	test   %rax,%rax
  8039ae:	79 1d                	jns    8039cd <vprintfmt+0x3bb>
  8039b0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8039b4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8039b8:	48 89 d6             	mov    %rdx,%rsi
  8039bb:	bf 2d 00 00 00       	mov    $0x2d,%edi
  8039c0:	ff d0                	callq  *%rax
  8039c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039c6:	48 f7 d8             	neg    %rax
  8039c9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8039cd:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8039d4:	e9 d5 00 00 00       	jmpq   803aae <vprintfmt+0x49c>
  8039d9:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8039dd:	be 03 00 00 00       	mov    $0x3,%esi
  8039e2:	48 89 c7             	mov    %rax,%rdi
  8039e5:	48 b8 f2 33 80 00 00 	movabs $0x8033f2,%rax
  8039ec:	00 00 00 
  8039ef:	ff d0                	callq  *%rax
  8039f1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8039f5:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8039fc:	e9 ad 00 00 00       	jmpq   803aae <vprintfmt+0x49c>
  803a01:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803a05:	be 03 00 00 00       	mov    $0x3,%esi
  803a0a:	48 89 c7             	mov    %rax,%rdi
  803a0d:	48 b8 f2 33 80 00 00 	movabs $0x8033f2,%rax
  803a14:	00 00 00 
  803a17:	ff d0                	callq  *%rax
  803a19:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803a1d:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  803a24:	e9 85 00 00 00       	jmpq   803aae <vprintfmt+0x49c>
  803a29:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803a2d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803a31:	48 89 d6             	mov    %rdx,%rsi
  803a34:	bf 30 00 00 00       	mov    $0x30,%edi
  803a39:	ff d0                	callq  *%rax
  803a3b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803a3f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803a43:	48 89 d6             	mov    %rdx,%rsi
  803a46:	bf 78 00 00 00       	mov    $0x78,%edi
  803a4b:	ff d0                	callq  *%rax
  803a4d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803a50:	83 f8 30             	cmp    $0x30,%eax
  803a53:	73 17                	jae    803a6c <vprintfmt+0x45a>
  803a55:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803a59:	8b 45 b8             	mov    -0x48(%rbp),%eax
  803a5c:	89 c0                	mov    %eax,%eax
  803a5e:	48 01 d0             	add    %rdx,%rax
  803a61:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803a64:	83 c2 08             	add    $0x8,%edx
  803a67:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803a6a:	eb 0f                	jmp    803a7b <vprintfmt+0x469>
  803a6c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  803a70:	48 89 d0             	mov    %rdx,%rax
  803a73:	48 83 c2 08          	add    $0x8,%rdx
  803a77:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803a7b:	48 8b 00             	mov    (%rax),%rax
  803a7e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803a82:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  803a89:	eb 23                	jmp    803aae <vprintfmt+0x49c>
  803a8b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803a8f:	be 03 00 00 00       	mov    $0x3,%esi
  803a94:	48 89 c7             	mov    %rax,%rdi
  803a97:	48 b8 f2 33 80 00 00 	movabs $0x8033f2,%rax
  803a9e:	00 00 00 
  803aa1:	ff d0                	callq  *%rax
  803aa3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803aa7:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  803aae:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  803ab3:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  803ab6:	8b 7d dc             	mov    -0x24(%rbp),%edi
  803ab9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803abd:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803ac1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803ac5:	45 89 c1             	mov    %r8d,%r9d
  803ac8:	41 89 f8             	mov    %edi,%r8d
  803acb:	48 89 c7             	mov    %rax,%rdi
  803ace:	48 b8 37 33 80 00 00 	movabs $0x803337,%rax
  803ad5:	00 00 00 
  803ad8:	ff d0                	callq  *%rax
  803ada:	eb 3f                	jmp    803b1b <vprintfmt+0x509>
  803adc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803ae0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803ae4:	48 89 d6             	mov    %rdx,%rsi
  803ae7:	89 df                	mov    %ebx,%edi
  803ae9:	ff d0                	callq  *%rax
  803aeb:	eb 2e                	jmp    803b1b <vprintfmt+0x509>
  803aed:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803af1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803af5:	48 89 d6             	mov    %rdx,%rsi
  803af8:	bf 25 00 00 00       	mov    $0x25,%edi
  803afd:	ff d0                	callq  *%rax
  803aff:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  803b04:	eb 05                	jmp    803b0b <vprintfmt+0x4f9>
  803b06:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  803b0b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  803b0f:	48 83 e8 01          	sub    $0x1,%rax
  803b13:	0f b6 00             	movzbl (%rax),%eax
  803b16:	3c 25                	cmp    $0x25,%al
  803b18:	75 ec                	jne    803b06 <vprintfmt+0x4f4>
  803b1a:	90                   	nop
  803b1b:	90                   	nop
  803b1c:	e9 43 fb ff ff       	jmpq   803664 <vprintfmt+0x52>
  803b21:	48 83 c4 60          	add    $0x60,%rsp
  803b25:	5b                   	pop    %rbx
  803b26:	41 5c                	pop    %r12
  803b28:	5d                   	pop    %rbp
  803b29:	c3                   	retq   

0000000000803b2a <printfmt>:
  803b2a:	55                   	push   %rbp
  803b2b:	48 89 e5             	mov    %rsp,%rbp
  803b2e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  803b35:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  803b3c:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  803b43:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803b4a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803b51:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803b58:	84 c0                	test   %al,%al
  803b5a:	74 20                	je     803b7c <printfmt+0x52>
  803b5c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803b60:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803b64:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803b68:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803b6c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803b70:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803b74:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  803b78:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  803b7c:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  803b83:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  803b8a:	00 00 00 
  803b8d:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  803b94:	00 00 00 
  803b97:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803b9b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803ba2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803ba9:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  803bb0:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  803bb7:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803bbe:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  803bc5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  803bcc:	48 89 c7             	mov    %rax,%rdi
  803bcf:	48 b8 12 36 80 00 00 	movabs $0x803612,%rax
  803bd6:	00 00 00 
  803bd9:	ff d0                	callq  *%rax
  803bdb:	c9                   	leaveq 
  803bdc:	c3                   	retq   

0000000000803bdd <sprintputch>:
  803bdd:	55                   	push   %rbp
  803bde:	48 89 e5             	mov    %rsp,%rbp
  803be1:	48 83 ec 10          	sub    $0x10,%rsp
  803be5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803be8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803bec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bf0:	8b 40 10             	mov    0x10(%rax),%eax
  803bf3:	8d 50 01             	lea    0x1(%rax),%edx
  803bf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bfa:	89 50 10             	mov    %edx,0x10(%rax)
  803bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c01:	48 8b 10             	mov    (%rax),%rdx
  803c04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c08:	48 8b 40 08          	mov    0x8(%rax),%rax
  803c0c:	48 39 c2             	cmp    %rax,%rdx
  803c0f:	73 17                	jae    803c28 <sprintputch+0x4b>
  803c11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c15:	48 8b 00             	mov    (%rax),%rax
  803c18:	48 8d 48 01          	lea    0x1(%rax),%rcx
  803c1c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803c20:	48 89 0a             	mov    %rcx,(%rdx)
  803c23:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803c26:	88 10                	mov    %dl,(%rax)
  803c28:	c9                   	leaveq 
  803c29:	c3                   	retq   

0000000000803c2a <vsnprintf>:
  803c2a:	55                   	push   %rbp
  803c2b:	48 89 e5             	mov    %rsp,%rbp
  803c2e:	48 83 ec 50          	sub    $0x50,%rsp
  803c32:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803c36:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  803c39:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  803c3d:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  803c41:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  803c45:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  803c49:	48 8b 0a             	mov    (%rdx),%rcx
  803c4c:	48 89 08             	mov    %rcx,(%rax)
  803c4f:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  803c53:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803c57:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803c5b:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803c5f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803c63:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  803c67:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  803c6a:	48 98                	cltq   
  803c6c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  803c70:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803c74:	48 01 d0             	add    %rdx,%rax
  803c77:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  803c7b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  803c82:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  803c87:	74 06                	je     803c8f <vsnprintf+0x65>
  803c89:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  803c8d:	7f 07                	jg     803c96 <vsnprintf+0x6c>
  803c8f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803c94:	eb 2f                	jmp    803cc5 <vsnprintf+0x9b>
  803c96:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  803c9a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  803c9e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803ca2:	48 89 c6             	mov    %rax,%rsi
  803ca5:	48 bf dd 3b 80 00 00 	movabs $0x803bdd,%rdi
  803cac:	00 00 00 
  803caf:	48 b8 12 36 80 00 00 	movabs $0x803612,%rax
  803cb6:	00 00 00 
  803cb9:	ff d0                	callq  *%rax
  803cbb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803cbf:	c6 00 00             	movb   $0x0,(%rax)
  803cc2:	8b 45 e0             	mov    -0x20(%rbp),%eax
  803cc5:	c9                   	leaveq 
  803cc6:	c3                   	retq   

0000000000803cc7 <snprintf>:
  803cc7:	55                   	push   %rbp
  803cc8:	48 89 e5             	mov    %rsp,%rbp
  803ccb:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  803cd2:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  803cd9:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  803cdf:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803ce6:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  803ced:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803cf4:	84 c0                	test   %al,%al
  803cf6:	74 20                	je     803d18 <snprintf+0x51>
  803cf8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  803cfc:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803d00:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803d04:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803d08:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  803d0c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803d10:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  803d14:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  803d18:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  803d1f:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  803d26:	00 00 00 
  803d29:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803d30:	00 00 00 
  803d33:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803d37:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803d3e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803d45:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803d4c:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  803d53:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  803d5a:	48 8b 0a             	mov    (%rdx),%rcx
  803d5d:	48 89 08             	mov    %rcx,(%rax)
  803d60:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  803d64:	48 89 48 08          	mov    %rcx,0x8(%rax)
  803d68:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  803d6c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  803d70:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  803d77:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  803d7e:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  803d84:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803d8b:	48 89 c7             	mov    %rax,%rdi
  803d8e:	48 b8 2a 3c 80 00 00 	movabs $0x803c2a,%rax
  803d95:	00 00 00 
  803d98:	ff d0                	callq  *%rax
  803d9a:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  803da0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  803da6:	c9                   	leaveq 
  803da7:	c3                   	retq   

0000000000803da8 <ipc_recv>:
  803da8:	55                   	push   %rbp
  803da9:	48 89 e5             	mov    %rsp,%rbp
  803dac:	48 83 ec 30          	sub    $0x30,%rsp
  803db0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803db4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803db8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803dbc:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803dc1:	75 0e                	jne    803dd1 <ipc_recv+0x29>
  803dc3:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803dca:	00 00 00 
  803dcd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803dd1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803dd5:	48 89 c7             	mov    %rax,%rdi
  803dd8:	48 b8 bc 0d 80 00 00 	movabs $0x800dbc,%rax
  803ddf:	00 00 00 
  803de2:	ff d0                	callq  *%rax
  803de4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803de7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803deb:	79 27                	jns    803e14 <ipc_recv+0x6c>
  803ded:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803df2:	74 0a                	je     803dfe <ipc_recv+0x56>
  803df4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803df8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803dfe:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803e03:	74 0a                	je     803e0f <ipc_recv+0x67>
  803e05:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e09:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803e0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e12:	eb 53                	jmp    803e67 <ipc_recv+0xbf>
  803e14:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803e19:	74 19                	je     803e34 <ipc_recv+0x8c>
  803e1b:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803e22:	00 00 00 
  803e25:	48 8b 00             	mov    (%rax),%rax
  803e28:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  803e2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803e32:	89 10                	mov    %edx,(%rax)
  803e34:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803e39:	74 19                	je     803e54 <ipc_recv+0xac>
  803e3b:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803e42:	00 00 00 
  803e45:	48 8b 00             	mov    (%rax),%rax
  803e48:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  803e4e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e52:	89 10                	mov    %edx,(%rax)
  803e54:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803e5b:	00 00 00 
  803e5e:	48 8b 00             	mov    (%rax),%rax
  803e61:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  803e67:	c9                   	leaveq 
  803e68:	c3                   	retq   

0000000000803e69 <ipc_send>:
  803e69:	55                   	push   %rbp
  803e6a:	48 89 e5             	mov    %rsp,%rbp
  803e6d:	48 83 ec 30          	sub    $0x30,%rsp
  803e71:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e74:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803e77:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  803e7b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803e7e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803e83:	75 10                	jne    803e95 <ipc_send+0x2c>
  803e85:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803e8c:	00 00 00 
  803e8f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803e93:	eb 0e                	jmp    803ea3 <ipc_send+0x3a>
  803e95:	eb 0c                	jmp    803ea3 <ipc_send+0x3a>
  803e97:	48 b8 55 0b 80 00 00 	movabs $0x800b55,%rax
  803e9e:	00 00 00 
  803ea1:	ff d0                	callq  *%rax
  803ea3:	8b 75 e8             	mov    -0x18(%rbp),%esi
  803ea6:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  803ea9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803ead:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803eb0:	89 c7                	mov    %eax,%edi
  803eb2:	48 b8 67 0d 80 00 00 	movabs $0x800d67,%rax
  803eb9:	00 00 00 
  803ebc:	ff d0                	callq  *%rax
  803ebe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ec1:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  803ec5:	74 d0                	je     803e97 <ipc_send+0x2e>
  803ec7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ecb:	79 30                	jns    803efd <ipc_send+0x94>
  803ecd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ed0:	89 c1                	mov    %eax,%ecx
  803ed2:	48 ba 48 47 80 00 00 	movabs $0x804748,%rdx
  803ed9:	00 00 00 
  803edc:	be 44 00 00 00       	mov    $0x44,%esi
  803ee1:	48 bf 5e 47 80 00 00 	movabs $0x80475e,%rdi
  803ee8:	00 00 00 
  803eeb:	b8 00 00 00 00       	mov    $0x0,%eax
  803ef0:	49 b8 26 30 80 00 00 	movabs $0x803026,%r8
  803ef7:	00 00 00 
  803efa:	41 ff d0             	callq  *%r8
  803efd:	c9                   	leaveq 
  803efe:	c3                   	retq   

0000000000803eff <ipc_host_recv>:
  803eff:	55                   	push   %rbp
  803f00:	48 89 e5             	mov    %rsp,%rbp
  803f03:	48 83 ec 10          	sub    $0x10,%rsp
  803f07:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803f0b:	48 ba 70 47 80 00 00 	movabs $0x804770,%rdx
  803f12:	00 00 00 
  803f15:	be 4e 00 00 00       	mov    $0x4e,%esi
  803f1a:	48 bf 5e 47 80 00 00 	movabs $0x80475e,%rdi
  803f21:	00 00 00 
  803f24:	b8 00 00 00 00       	mov    $0x0,%eax
  803f29:	48 b9 26 30 80 00 00 	movabs $0x803026,%rcx
  803f30:	00 00 00 
  803f33:	ff d1                	callq  *%rcx

0000000000803f35 <ipc_host_send>:
  803f35:	55                   	push   %rbp
  803f36:	48 89 e5             	mov    %rsp,%rbp
  803f39:	48 83 ec 20          	sub    $0x20,%rsp
  803f3d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f40:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803f43:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  803f47:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803f4a:	48 ba 90 47 80 00 00 	movabs $0x804790,%rdx
  803f51:	00 00 00 
  803f54:	be 67 00 00 00       	mov    $0x67,%esi
  803f59:	48 bf 5e 47 80 00 00 	movabs $0x80475e,%rdi
  803f60:	00 00 00 
  803f63:	b8 00 00 00 00       	mov    $0x0,%eax
  803f68:	48 b9 26 30 80 00 00 	movabs $0x803026,%rcx
  803f6f:	00 00 00 
  803f72:	ff d1                	callq  *%rcx

0000000000803f74 <ipc_find_env>:
  803f74:	55                   	push   %rbp
  803f75:	48 89 e5             	mov    %rsp,%rbp
  803f78:	48 83 ec 14          	sub    $0x14,%rsp
  803f7c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803f7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803f86:	eb 4e                	jmp    803fd6 <ipc_find_env+0x62>
  803f88:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803f8f:	00 00 00 
  803f92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f95:	48 98                	cltq   
  803f97:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803f9e:	48 01 d0             	add    %rdx,%rax
  803fa1:	48 05 d0 00 00 00    	add    $0xd0,%rax
  803fa7:	8b 00                	mov    (%rax),%eax
  803fa9:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  803fac:	75 24                	jne    803fd2 <ipc_find_env+0x5e>
  803fae:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803fb5:	00 00 00 
  803fb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fbb:	48 98                	cltq   
  803fbd:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803fc4:	48 01 d0             	add    %rdx,%rax
  803fc7:	48 05 c0 00 00 00    	add    $0xc0,%rax
  803fcd:	8b 40 08             	mov    0x8(%rax),%eax
  803fd0:	eb 12                	jmp    803fe4 <ipc_find_env+0x70>
  803fd2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803fd6:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  803fdd:	7e a9                	jle    803f88 <ipc_find_env+0x14>
  803fdf:	b8 00 00 00 00       	mov    $0x0,%eax
  803fe4:	c9                   	leaveq 
  803fe5:	c3                   	retq   

0000000000803fe6 <pageref>:
  803fe6:	55                   	push   %rbp
  803fe7:	48 89 e5             	mov    %rsp,%rbp
  803fea:	48 83 ec 18          	sub    $0x18,%rsp
  803fee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803ff6:	48 c1 e8 15          	shr    $0x15,%rax
  803ffa:	48 89 c2             	mov    %rax,%rdx
  803ffd:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804004:	01 00 00 
  804007:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80400b:	83 e0 01             	and    $0x1,%eax
  80400e:	48 85 c0             	test   %rax,%rax
  804011:	75 07                	jne    80401a <pageref+0x34>
  804013:	b8 00 00 00 00       	mov    $0x0,%eax
  804018:	eb 53                	jmp    80406d <pageref+0x87>
  80401a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80401e:	48 c1 e8 0c          	shr    $0xc,%rax
  804022:	48 89 c2             	mov    %rax,%rdx
  804025:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80402c:	01 00 00 
  80402f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804033:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804037:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80403b:	83 e0 01             	and    $0x1,%eax
  80403e:	48 85 c0             	test   %rax,%rax
  804041:	75 07                	jne    80404a <pageref+0x64>
  804043:	b8 00 00 00 00       	mov    $0x0,%eax
  804048:	eb 23                	jmp    80406d <pageref+0x87>
  80404a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80404e:	48 c1 e8 0c          	shr    $0xc,%rax
  804052:	48 89 c2             	mov    %rax,%rdx
  804055:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  80405c:	00 00 00 
  80405f:	48 c1 e2 04          	shl    $0x4,%rdx
  804063:	48 01 d0             	add    %rdx,%rax
  804066:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  80406a:	0f b7 c0             	movzwl %ax,%eax
  80406d:	c9                   	leaveq 
  80406e:	c3                   	retq   
