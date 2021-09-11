
vmm/guest/obj/net/testinput:     file format elf64-x86-64


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
  80003c:	e8 0a 0a 00 00       	callq  800a4b <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <announce>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 30          	sub    $0x30,%rsp
  80004b:	c6 45 e0 52          	movb   $0x52,-0x20(%rbp)
  80004f:	c6 45 e1 54          	movb   $0x54,-0x1f(%rbp)
  800053:	c6 45 e2 00          	movb   $0x0,-0x1e(%rbp)
  800057:	c6 45 e3 12          	movb   $0x12,-0x1d(%rbp)
  80005b:	c6 45 e4 34          	movb   $0x34,-0x1c(%rbp)
  80005f:	c6 45 e5 56          	movb   $0x56,-0x1b(%rbp)
  800063:	48 bf 60 55 80 00 00 	movabs $0x805560,%rdi
  80006a:	00 00 00 
  80006d:	48 b8 a5 50 80 00 00 	movabs $0x8050a5,%rax
  800074:	00 00 00 
  800077:	ff d0                	callq  *%rax
  800079:	89 45 dc             	mov    %eax,-0x24(%rbp)
  80007c:	48 bf 6a 55 80 00 00 	movabs $0x80556a,%rdi
  800083:	00 00 00 
  800086:	48 b8 a5 50 80 00 00 	movabs $0x8050a5,%rax
  80008d:	00 00 00 
  800090:	ff d0                	callq  *%rax
  800092:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800095:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80009c:	00 00 00 
  80009f:	48 8b 00             	mov    (%rax),%rax
  8000a2:	ba 07 00 00 00       	mov    $0x7,%edx
  8000a7:	48 89 c6             	mov    %rax,%rsi
  8000aa:	bf 00 00 00 00       	mov    $0x0,%edi
  8000af:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  8000b6:	00 00 00 
  8000b9:	ff d0                	callq  *%rax
  8000bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8000be:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000c2:	79 30                	jns    8000f4 <announce+0xb1>
  8000c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000c7:	89 c1                	mov    %eax,%ecx
  8000c9:	48 ba 73 55 80 00 00 	movabs $0x805573,%rdx
  8000d0:	00 00 00 
  8000d3:	be 1a 00 00 00       	mov    $0x1a,%esi
  8000d8:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  8000df:	00 00 00 
  8000e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e7:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8000ee:	00 00 00 
  8000f1:	41 ff d0             	callq  *%r8
  8000f4:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8000fb:	00 00 00 
  8000fe:	48 8b 00             	mov    (%rax),%rax
  800101:	48 83 c0 04          	add    $0x4,%rax
  800105:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800109:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  800110:	00 00 00 
  800113:	48 8b 00             	mov    (%rax),%rax
  800116:	c7 00 2a 00 00 00    	movl   $0x2a,(%rax)
  80011c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800120:	ba 06 00 00 00       	mov    $0x6,%edx
  800125:	be ff 00 00 00       	mov    $0xff,%esi
  80012a:	48 89 c7             	mov    %rax,%rdi
  80012d:	48 b8 78 1b 80 00 00 	movabs $0x801b78,%rax
  800134:	00 00 00 
  800137:	ff d0                	callq  *%rax
  800139:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80013d:	48 8d 48 06          	lea    0x6(%rax),%rcx
  800141:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  800145:	ba 06 00 00 00       	mov    $0x6,%edx
  80014a:	48 89 c6             	mov    %rax,%rsi
  80014d:	48 89 cf             	mov    %rcx,%rdi
  800150:	48 b8 1a 1d 80 00 00 	movabs $0x801d1a,%rax
  800157:	00 00 00 
  80015a:	ff d0                	callq  *%rax
  80015c:	bf 06 08 00 00       	mov    $0x806,%edi
  800161:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  800168:	00 00 00 
  80016b:	ff d0                	callq  *%rax
  80016d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800171:	66 89 42 0c          	mov    %ax,0xc(%rdx)
  800175:	bf 01 00 00 00       	mov    $0x1,%edi
  80017a:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  800181:	00 00 00 
  800184:	ff d0                	callq  *%rax
  800186:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80018a:	66 89 42 0e          	mov    %ax,0xe(%rdx)
  80018e:	bf 00 08 00 00       	mov    $0x800,%edi
  800193:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  80019a:	00 00 00 
  80019d:	ff d0                	callq  *%rax
  80019f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001a3:	66 89 42 10          	mov    %ax,0x10(%rdx)
  8001a7:	bf 04 06 00 00       	mov    $0x604,%edi
  8001ac:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  8001b3:	00 00 00 
  8001b6:	ff d0                	callq  *%rax
  8001b8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001bc:	66 89 42 12          	mov    %ax,0x12(%rdx)
  8001c0:	bf 01 00 00 00       	mov    $0x1,%edi
  8001c5:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  8001cc:	00 00 00 
  8001cf:	ff d0                	callq  *%rax
  8001d1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001d5:	66 89 42 14          	mov    %ax,0x14(%rdx)
  8001d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8001dd:	48 8d 48 16          	lea    0x16(%rax),%rcx
  8001e1:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  8001e5:	ba 06 00 00 00       	mov    $0x6,%edx
  8001ea:	48 89 c6             	mov    %rax,%rsi
  8001ed:	48 89 cf             	mov    %rcx,%rdi
  8001f0:	48 b8 1a 1d 80 00 00 	movabs $0x801d1a,%rax
  8001f7:	00 00 00 
  8001fa:	ff d0                	callq  *%rax
  8001fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800200:	48 8d 48 1c          	lea    0x1c(%rax),%rcx
  800204:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
  800208:	ba 04 00 00 00       	mov    $0x4,%edx
  80020d:	48 89 c6             	mov    %rax,%rsi
  800210:	48 89 cf             	mov    %rcx,%rdi
  800213:	48 b8 1a 1d 80 00 00 	movabs $0x801d1a,%rax
  80021a:	00 00 00 
  80021d:	ff d0                	callq  *%rax
  80021f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800223:	48 83 c0 20          	add    $0x20,%rax
  800227:	ba 06 00 00 00       	mov    $0x6,%edx
  80022c:	be 00 00 00 00       	mov    $0x0,%esi
  800231:	48 89 c7             	mov    %rax,%rdi
  800234:	48 b8 78 1b 80 00 00 	movabs $0x801b78,%rax
  80023b:	00 00 00 
  80023e:	ff d0                	callq  *%rax
  800240:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800244:	48 8d 48 26          	lea    0x26(%rax),%rcx
  800248:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  80024c:	ba 04 00 00 00       	mov    $0x4,%edx
  800251:	48 89 c6             	mov    %rax,%rsi
  800254:	48 89 cf             	mov    %rcx,%rdi
  800257:	48 b8 1a 1d 80 00 00 	movabs $0x801d1a,%rax
  80025e:	00 00 00 
  800261:	ff d0                	callq  *%rax
  800263:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80026a:	00 00 00 
  80026d:	48 8b 10             	mov    (%rax),%rdx
  800270:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  800277:	00 00 00 
  80027a:	8b 00                	mov    (%rax),%eax
  80027c:	b9 07 00 00 00       	mov    $0x7,%ecx
  800281:	be 0b 00 00 00       	mov    $0xb,%esi
  800286:	89 c7                	mov    %eax,%edi
  800288:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  80028f:	00 00 00 
  800292:	ff d0                	callq  *%rax
  800294:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80029b:	00 00 00 
  80029e:	48 8b 00             	mov    (%rax),%rax
  8002a1:	48 89 c6             	mov    %rax,%rsi
  8002a4:	bf 00 00 00 00       	mov    $0x0,%edi
  8002a9:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  8002b0:	00 00 00 
  8002b3:	ff d0                	callq  *%rax
  8002b5:	c9                   	leaveq 
  8002b6:	c3                   	retq   

00000000008002b7 <hexdump>:
  8002b7:	55                   	push   %rbp
  8002b8:	48 89 e5             	mov    %rsp,%rbp
  8002bb:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  8002c2:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
  8002c6:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
  8002ca:	89 95 7c ff ff ff    	mov    %edx,-0x84(%rbp)
  8002d0:	48 8d 45 90          	lea    -0x70(%rbp),%rax
  8002d4:	48 83 c0 50          	add    $0x50,%rax
  8002d8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8002dc:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8002e3:	00 
  8002e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8002eb:	e9 41 01 00 00       	jmpq   800431 <hexdump+0x17a>
  8002f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8002f3:	83 e0 0f             	and    $0xf,%eax
  8002f6:	85 c0                	test   %eax,%eax
  8002f8:	75 4d                	jne    800347 <hexdump+0x90>
  8002fa:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8002fe:	48 8d 45 90          	lea    -0x70(%rbp),%rax
  800302:	48 29 c2             	sub    %rax,%rdx
  800305:	48 89 d0             	mov    %rdx,%rax
  800308:	89 c6                	mov    %eax,%esi
  80030a:	8b 4d fc             	mov    -0x4(%rbp),%ecx
  80030d:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
  800311:	48 8d 45 90          	lea    -0x70(%rbp),%rax
  800315:	41 89 c8             	mov    %ecx,%r8d
  800318:	48 89 d1             	mov    %rdx,%rcx
  80031b:	48 ba 97 55 80 00 00 	movabs $0x805597,%rdx
  800322:	00 00 00 
  800325:	48 89 c7             	mov    %rax,%rdi
  800328:	b8 00 00 00 00       	mov    $0x0,%eax
  80032d:	49 b9 92 17 80 00 00 	movabs $0x801792,%r9
  800334:	00 00 00 
  800337:	41 ff d1             	callq  *%r9
  80033a:	48 98                	cltq   
  80033c:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
  800340:	48 01 d0             	add    %rdx,%rax
  800343:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800347:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80034a:	48 63 d0             	movslq %eax,%rdx
  80034d:	48 8b 45 80          	mov    -0x80(%rbp),%rax
  800351:	48 01 d0             	add    %rdx,%rax
  800354:	0f b6 00             	movzbl (%rax),%eax
  800357:	0f b6 d0             	movzbl %al,%edx
  80035a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80035e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800362:	48 29 c1             	sub    %rax,%rcx
  800365:	48 89 c8             	mov    %rcx,%rax
  800368:	89 c6                	mov    %eax,%esi
  80036a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80036e:	89 d1                	mov    %edx,%ecx
  800370:	48 ba a1 55 80 00 00 	movabs $0x8055a1,%rdx
  800377:	00 00 00 
  80037a:	48 89 c7             	mov    %rax,%rdi
  80037d:	b8 00 00 00 00       	mov    $0x0,%eax
  800382:	49 b8 92 17 80 00 00 	movabs $0x801792,%r8
  800389:	00 00 00 
  80038c:	41 ff d0             	callq  *%r8
  80038f:	48 98                	cltq   
  800391:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  800395:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800398:	99                   	cltd   
  800399:	c1 ea 1c             	shr    $0x1c,%edx
  80039c:	01 d0                	add    %edx,%eax
  80039e:	83 e0 0f             	and    $0xf,%eax
  8003a1:	29 d0                	sub    %edx,%eax
  8003a3:	83 f8 0f             	cmp    $0xf,%eax
  8003a6:	74 0e                	je     8003b6 <hexdump+0xff>
  8003a8:	8b 85 7c ff ff ff    	mov    -0x84(%rbp),%eax
  8003ae:	83 e8 01             	sub    $0x1,%eax
  8003b1:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  8003b4:	75 33                	jne    8003e9 <hexdump+0x132>
  8003b6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003ba:	48 8d 45 90          	lea    -0x70(%rbp),%rax
  8003be:	48 89 d1             	mov    %rdx,%rcx
  8003c1:	48 29 c1             	sub    %rax,%rcx
  8003c4:	48 8d 45 90          	lea    -0x70(%rbp),%rax
  8003c8:	48 89 c2             	mov    %rax,%rdx
  8003cb:	48 89 ce             	mov    %rcx,%rsi
  8003ce:	48 bf a6 55 80 00 00 	movabs $0x8055a6,%rdi
  8003d5:	00 00 00 
  8003d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8003dd:	48 b9 2a 0d 80 00 00 	movabs $0x800d2a,%rcx
  8003e4:	00 00 00 
  8003e7:	ff d1                	callq  *%rcx
  8003e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003ec:	99                   	cltd   
  8003ed:	c1 ea 1f             	shr    $0x1f,%edx
  8003f0:	01 d0                	add    %edx,%eax
  8003f2:	83 e0 01             	and    $0x1,%eax
  8003f5:	29 d0                	sub    %edx,%eax
  8003f7:	83 f8 01             	cmp    $0x1,%eax
  8003fa:	75 0f                	jne    80040b <hexdump+0x154>
  8003fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800400:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800404:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  800408:	c6 00 20             	movb   $0x20,(%rax)
  80040b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80040e:	99                   	cltd   
  80040f:	c1 ea 1c             	shr    $0x1c,%edx
  800412:	01 d0                	add    %edx,%eax
  800414:	83 e0 0f             	and    $0xf,%eax
  800417:	29 d0                	sub    %edx,%eax
  800419:	83 f8 07             	cmp    $0x7,%eax
  80041c:	75 0f                	jne    80042d <hexdump+0x176>
  80041e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800422:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800426:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80042a:	c6 00 20             	movb   $0x20,(%rax)
  80042d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800431:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800434:	3b 85 7c ff ff ff    	cmp    -0x84(%rbp),%eax
  80043a:	0f 8c b0 fe ff ff    	jl     8002f0 <hexdump+0x39>
  800440:	c9                   	leaveq 
  800441:	c3                   	retq   

0000000000800442 <umain>:
  800442:	55                   	push   %rbp
  800443:	48 89 e5             	mov    %rsp,%rbp
  800446:	53                   	push   %rbx
  800447:	48 83 ec 38          	sub    $0x38,%rsp
  80044b:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80044e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800452:	48 b8 92 21 80 00 00 	movabs $0x802192,%rax
  800459:	00 00 00 
  80045c:	ff d0                	callq  *%rax
  80045e:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800461:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
  800468:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80046f:	00 00 00 
  800472:	48 bb ac 55 80 00 00 	movabs $0x8055ac,%rbx
  800479:	00 00 00 
  80047c:	48 89 18             	mov    %rbx,(%rax)
  80047f:	48 b8 8e 29 80 00 00 	movabs $0x80298e,%rax
  800486:	00 00 00 
  800489:	ff d0                	callq  *%rax
  80048b:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  800492:	00 00 00 
  800495:	89 02                	mov    %eax,(%rdx)
  800497:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  80049e:	00 00 00 
  8004a1:	8b 00                	mov    (%rax),%eax
  8004a3:	85 c0                	test   %eax,%eax
  8004a5:	79 2a                	jns    8004d1 <umain+0x8f>
  8004a7:	48 ba b6 55 80 00 00 	movabs $0x8055b6,%rdx
  8004ae:	00 00 00 
  8004b1:	be 4e 00 00 00       	mov    $0x4e,%esi
  8004b6:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  8004bd:	00 00 00 
  8004c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8004c5:	48 b9 f1 0a 80 00 00 	movabs $0x800af1,%rcx
  8004cc:	00 00 00 
  8004cf:	ff d1                	callq  *%rcx
  8004d1:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8004d8:	00 00 00 
  8004db:	8b 00                	mov    (%rax),%eax
  8004dd:	85 c0                	test   %eax,%eax
  8004df:	75 16                	jne    8004f7 <umain+0xb5>
  8004e1:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8004e4:	89 c7                	mov    %eax,%edi
  8004e6:	48 b8 34 09 80 00 00 	movabs $0x800934,%rax
  8004ed:	00 00 00 
  8004f0:	ff d0                	callq  *%rax
  8004f2:	e9 fb 01 00 00       	jmpq   8006f2 <umain+0x2b0>
  8004f7:	48 b8 8e 29 80 00 00 	movabs $0x80298e,%rax
  8004fe:	00 00 00 
  800501:	ff d0                	callq  *%rax
  800503:	48 ba 04 90 80 00 00 	movabs $0x809004,%rdx
  80050a:	00 00 00 
  80050d:	89 02                	mov    %eax,(%rdx)
  80050f:	48 b8 04 90 80 00 00 	movabs $0x809004,%rax
  800516:	00 00 00 
  800519:	8b 00                	mov    (%rax),%eax
  80051b:	85 c0                	test   %eax,%eax
  80051d:	79 2a                	jns    800549 <umain+0x107>
  80051f:	48 ba b6 55 80 00 00 	movabs $0x8055b6,%rdx
  800526:	00 00 00 
  800529:	be 56 00 00 00       	mov    $0x56,%esi
  80052e:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  800535:	00 00 00 
  800538:	b8 00 00 00 00       	mov    $0x0,%eax
  80053d:	48 b9 f1 0a 80 00 00 	movabs $0x800af1,%rcx
  800544:	00 00 00 
  800547:	ff d1                	callq  *%rcx
  800549:	48 b8 04 90 80 00 00 	movabs $0x809004,%rax
  800550:	00 00 00 
  800553:	8b 00                	mov    (%rax),%eax
  800555:	85 c0                	test   %eax,%eax
  800557:	75 16                	jne    80056f <umain+0x12d>
  800559:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80055c:	89 c7                	mov    %eax,%edi
  80055e:	48 b8 1a 08 80 00 00 	movabs $0x80081a,%rax
  800565:	00 00 00 
  800568:	ff d0                	callq  *%rax
  80056a:	e9 83 01 00 00       	jmpq   8006f2 <umain+0x2b0>
  80056f:	48 bf c4 55 80 00 00 	movabs $0x8055c4,%rdi
  800576:	00 00 00 
  800579:	b8 00 00 00 00       	mov    $0x0,%eax
  80057e:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  800585:	00 00 00 
  800588:	ff d2                	callq  *%rdx
  80058a:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  800591:	00 00 00 
  800594:	ff d0                	callq  *%rax
  800596:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80059d:	00 00 00 
  8005a0:	48 8b 08             	mov    (%rax),%rcx
  8005a3:	48 8d 55 dc          	lea    -0x24(%rbp),%rdx
  8005a7:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  8005ab:	48 89 ce             	mov    %rcx,%rsi
  8005ae:	48 89 c7             	mov    %rax,%rdi
  8005b1:	48 b8 03 2c 80 00 00 	movabs $0x802c03,%rax
  8005b8:	00 00 00 
  8005bb:	ff d0                	callq  *%rax
  8005bd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8005c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8005c4:	79 30                	jns    8005f6 <umain+0x1b4>
  8005c6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8005c9:	89 c1                	mov    %eax,%ecx
  8005cb:	48 ba e1 55 80 00 00 	movabs $0x8055e1,%rdx
  8005d2:	00 00 00 
  8005d5:	be 65 00 00 00       	mov    $0x65,%esi
  8005da:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  8005e1:	00 00 00 
  8005e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8005e9:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8005f0:	00 00 00 
  8005f3:	41 ff d0             	callq  *%r8
  8005f6:	8b 55 e0             	mov    -0x20(%rbp),%edx
  8005f9:	48 b8 04 90 80 00 00 	movabs $0x809004,%rax
  800600:	00 00 00 
  800603:	8b 00                	mov    (%rax),%eax
  800605:	39 c2                	cmp    %eax,%edx
  800607:	74 30                	je     800639 <umain+0x1f7>
  800609:	8b 45 e0             	mov    -0x20(%rbp),%eax
  80060c:	89 c1                	mov    %eax,%ecx
  80060e:	48 ba f0 55 80 00 00 	movabs $0x8055f0,%rdx
  800615:	00 00 00 
  800618:	be 67 00 00 00       	mov    $0x67,%esi
  80061d:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  800624:	00 00 00 
  800627:	b8 00 00 00 00       	mov    $0x0,%eax
  80062c:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  800633:	00 00 00 
  800636:	41 ff d0             	callq  *%r8
  800639:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%rbp)
  80063d:	74 30                	je     80066f <umain+0x22d>
  80063f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800642:	89 c1                	mov    %eax,%ecx
  800644:	48 ba 15 56 80 00 00 	movabs $0x805615,%rdx
  80064b:	00 00 00 
  80064e:	be 69 00 00 00       	mov    $0x69,%esi
  800653:	48 bf 84 55 80 00 00 	movabs $0x805584,%rdi
  80065a:	00 00 00 
  80065d:	b8 00 00 00 00       	mov    $0x0,%eax
  800662:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  800669:	00 00 00 
  80066c:	41 ff d0             	callq  *%r8
  80066f:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  800676:	00 00 00 
  800679:	48 8b 00             	mov    (%rax),%rax
  80067c:	8b 00                	mov    (%rax),%eax
  80067e:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  800685:	00 00 00 
  800688:	48 8b 12             	mov    (%rdx),%rdx
  80068b:	48 8d 4a 04          	lea    0x4(%rdx),%rcx
  80068f:	89 c2                	mov    %eax,%edx
  800691:	48 89 ce             	mov    %rcx,%rsi
  800694:	48 bf 27 56 80 00 00 	movabs $0x805627,%rdi
  80069b:	00 00 00 
  80069e:	48 b8 b7 02 80 00 00 	movabs $0x8002b7,%rax
  8006a5:	00 00 00 
  8006a8:	ff d0                	callq  *%rax
  8006aa:	48 bf 2f 56 80 00 00 	movabs $0x80562f,%rdi
  8006b1:	00 00 00 
  8006b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8006b9:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  8006c0:	00 00 00 
  8006c3:	ff d2                	callq  *%rdx
  8006c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8006c9:	74 1b                	je     8006e6 <umain+0x2a4>
  8006cb:	48 bf 31 56 80 00 00 	movabs $0x805631,%rdi
  8006d2:	00 00 00 
  8006d5:	b8 00 00 00 00       	mov    $0x0,%eax
  8006da:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  8006e1:	00 00 00 
  8006e4:	ff d2                	callq  *%rdx
  8006e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  8006ed:	e9 a4 fe ff ff       	jmpq   800596 <umain+0x154>
  8006f2:	48 83 c4 38          	add    $0x38,%rsp
  8006f6:	5b                   	pop    %rbx
  8006f7:	5d                   	pop    %rbp
  8006f8:	c3                   	retq   

00000000008006f9 <timer>:
  8006f9:	55                   	push   %rbp
  8006fa:	48 89 e5             	mov    %rsp,%rbp
  8006fd:	53                   	push   %rbx
  8006fe:	48 83 ec 28          	sub    $0x28,%rsp
  800702:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800705:	89 75 d8             	mov    %esi,-0x28(%rbp)
  800708:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  80070f:	00 00 00 
  800712:	ff d0                	callq  *%rax
  800714:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800717:	01 d0                	add    %edx,%eax
  800719:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80071c:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800723:	00 00 00 
  800726:	48 bb 50 56 80 00 00 	movabs $0x805650,%rbx
  80072d:	00 00 00 
  800730:	48 89 18             	mov    %rbx,(%rax)
  800733:	eb 0c                	jmp    800741 <timer+0x48>
  800735:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  80073c:	00 00 00 
  80073f:	ff d0                	callq  *%rax
  800741:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  800748:	00 00 00 
  80074b:	ff d0                	callq  *%rax
  80074d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800750:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800753:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  800756:	73 06                	jae    80075e <timer+0x65>
  800758:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80075c:	79 d7                	jns    800735 <timer+0x3c>
  80075e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800762:	79 30                	jns    800794 <timer+0x9b>
  800764:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800767:	89 c1                	mov    %eax,%ecx
  800769:	48 ba 59 56 80 00 00 	movabs $0x805659,%rdx
  800770:	00 00 00 
  800773:	be 10 00 00 00       	mov    $0x10,%esi
  800778:	48 bf 6b 56 80 00 00 	movabs $0x80566b,%rdi
  80077f:	00 00 00 
  800782:	b8 00 00 00 00       	mov    $0x0,%eax
  800787:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  80078e:	00 00 00 
  800791:	41 ff d0             	callq  *%r8
  800794:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800797:	b9 00 00 00 00       	mov    $0x0,%ecx
  80079c:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a1:	be 0c 00 00 00       	mov    $0xc,%esi
  8007a6:	89 c7                	mov    %eax,%edi
  8007a8:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  8007af:	00 00 00 
  8007b2:	ff d0                	callq  *%rax
  8007b4:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  8007b8:	ba 00 00 00 00       	mov    $0x0,%edx
  8007bd:	be 00 00 00 00       	mov    $0x0,%esi
  8007c2:	48 89 c7             	mov    %rax,%rdi
  8007c5:	48 b8 03 2c 80 00 00 	movabs $0x802c03,%rax
  8007cc:	00 00 00 
  8007cf:	ff d0                	callq  *%rax
  8007d1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8007d4:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8007d7:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8007da:	39 c2                	cmp    %eax,%edx
  8007dc:	74 22                	je     800800 <timer+0x107>
  8007de:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8007e1:	89 c6                	mov    %eax,%esi
  8007e3:	48 bf 80 56 80 00 00 	movabs $0x805680,%rdi
  8007ea:	00 00 00 
  8007ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8007f2:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  8007f9:	00 00 00 
  8007fc:	ff d2                	callq  *%rdx
  8007fe:	eb b4                	jmp    8007b4 <timer+0xbb>
  800800:	48 b8 7b 24 80 00 00 	movabs $0x80247b,%rax
  800807:	00 00 00 
  80080a:	ff d0                	callq  *%rax
  80080c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80080f:	01 d0                	add    %edx,%eax
  800811:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800814:	90                   	nop
  800815:	e9 27 ff ff ff       	jmpq   800741 <timer+0x48>

000000000080081a <input>:
  80081a:	55                   	push   %rbp
  80081b:	48 89 e5             	mov    %rsp,%rbp
  80081e:	53                   	push   %rbx
  80081f:	48 83 ec 28          	sub    $0x28,%rsp
  800823:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800826:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  80082d:	00 00 00 
  800830:	48 bb bb 56 80 00 00 	movabs $0x8056bb,%rbx
  800837:	00 00 00 
  80083a:	48 89 18             	mov    %rbx,(%rax)
  80083d:	ba 07 00 00 00       	mov    $0x7,%edx
  800842:	48 be 00 c0 80 00 00 	movabs $0x80c000,%rsi
  800849:	00 00 00 
  80084c:	bf 00 00 00 00       	mov    $0x0,%edi
  800851:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  800858:	00 00 00 
  80085b:	ff d0                	callq  *%rax
  80085d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800860:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800864:	79 30                	jns    800896 <input+0x7c>
  800866:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800869:	89 c1                	mov    %eax,%ecx
  80086b:	48 ba c4 56 80 00 00 	movabs $0x8056c4,%rdx
  800872:	00 00 00 
  800875:	be 0e 00 00 00       	mov    $0xe,%esi
  80087a:	48 bf d7 56 80 00 00 	movabs $0x8056d7,%rdi
  800881:	00 00 00 
  800884:	b8 00 00 00 00       	mov    $0x0,%eax
  800889:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  800890:	00 00 00 
  800893:	41 ff d0             	callq  *%r8
  800896:	be ee 05 00 00       	mov    $0x5ee,%esi
  80089b:	48 bf 04 c0 80 00 00 	movabs $0x80c004,%rdi
  8008a2:	00 00 00 
  8008a5:	48 b8 01 25 80 00 00 	movabs $0x802501,%rax
  8008ac:	00 00 00 
  8008af:	ff d0                	callq  *%rax
  8008b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8008b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8008b8:	75 0e                	jne    8008c8 <input+0xae>
  8008ba:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  8008c1:	00 00 00 
  8008c4:	ff d0                	callq  *%rax
  8008c6:	eb 67                	jmp    80092f <input+0x115>
  8008c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8008cc:	79 22                	jns    8008f0 <input+0xd6>
  8008ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8008d1:	89 c6                	mov    %eax,%esi
  8008d3:	48 bf e6 56 80 00 00 	movabs $0x8056e6,%rdi
  8008da:	00 00 00 
  8008dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8008e2:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  8008e9:	00 00 00 
  8008ec:	ff d2                	callq  *%rdx
  8008ee:	eb 3f                	jmp    80092f <input+0x115>
  8008f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8008f4:	7e 39                	jle    80092f <input+0x115>
  8008f6:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8008fd:	00 00 00 
  800900:	8b 55 ec             	mov    -0x14(%rbp),%edx
  800903:	89 10                	mov    %edx,(%rax)
  800905:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800908:	b9 05 00 00 00       	mov    $0x5,%ecx
  80090d:	48 ba 00 c0 80 00 00 	movabs $0x80c000,%rdx
  800914:	00 00 00 
  800917:	be 0a 00 00 00       	mov    $0xa,%esi
  80091c:	89 c7                	mov    %eax,%edi
  80091e:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  800925:	00 00 00 
  800928:	ff d0                	callq  *%rax
  80092a:	e9 0e ff ff ff       	jmpq   80083d <input+0x23>
  80092f:	e9 09 ff ff ff       	jmpq   80083d <input+0x23>

0000000000800934 <output>:
  800934:	55                   	push   %rbp
  800935:	48 89 e5             	mov    %rsp,%rbp
  800938:	53                   	push   %rbx
  800939:	48 83 ec 28          	sub    $0x28,%rsp
  80093d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800940:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800947:	00 00 00 
  80094a:	48 bb 08 57 80 00 00 	movabs $0x805708,%rbx
  800951:	00 00 00 
  800954:	48 89 18             	mov    %rbx,(%rax)
  800957:	48 8d 45 e4          	lea    -0x1c(%rbp),%rax
  80095b:	ba 00 00 00 00       	mov    $0x0,%edx
  800960:	48 be 00 c0 80 00 00 	movabs $0x80c000,%rsi
  800967:	00 00 00 
  80096a:	48 89 c7             	mov    %rax,%rdi
  80096d:	48 b8 03 2c 80 00 00 	movabs $0x802c03,%rax
  800974:	00 00 00 
  800977:	ff d0                	callq  *%rax
  800979:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80097c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80097f:	3b 45 dc             	cmp    -0x24(%rbp),%eax
  800982:	74 35                	je     8009b9 <output+0x85>
  800984:	48 b9 12 57 80 00 00 	movabs $0x805712,%rcx
  80098b:	00 00 00 
  80098e:	48 ba 23 57 80 00 00 	movabs $0x805723,%rdx
  800995:	00 00 00 
  800998:	be 11 00 00 00       	mov    $0x11,%esi
  80099d:	48 bf 38 57 80 00 00 	movabs $0x805738,%rdi
  8009a4:	00 00 00 
  8009a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8009ac:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8009b3:	00 00 00 
  8009b6:	41 ff d0             	callq  *%r8
  8009b9:	83 7d ec 0b          	cmpl   $0xb,-0x14(%rbp)
  8009bd:	74 35                	je     8009f4 <output+0xc0>
  8009bf:	48 b9 48 57 80 00 00 	movabs $0x805748,%rcx
  8009c6:	00 00 00 
  8009c9:	48 ba 23 57 80 00 00 	movabs $0x805723,%rdx
  8009d0:	00 00 00 
  8009d3:	be 12 00 00 00       	mov    $0x12,%esi
  8009d8:	48 bf 38 57 80 00 00 	movabs $0x805738,%rdi
  8009df:	00 00 00 
  8009e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8009e7:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8009ee:	00 00 00 
  8009f1:	41 ff d0             	callq  *%r8
  8009f4:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8009fb:	00 00 00 
  8009fe:	8b 00                	mov    (%rax),%eax
  800a00:	89 c6                	mov    %eax,%esi
  800a02:	48 bf 04 c0 80 00 00 	movabs $0x80c004,%rdi
  800a09:	00 00 00 
  800a0c:	48 b8 b9 24 80 00 00 	movabs $0x8024b9,%rax
  800a13:	00 00 00 
  800a16:	ff d0                	callq  *%rax
  800a18:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800a1b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800a1f:	79 25                	jns    800a46 <output+0x112>
  800a21:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800a24:	89 c6                	mov    %eax,%esi
  800a26:	48 bf 60 57 80 00 00 	movabs $0x805760,%rdi
  800a2d:	00 00 00 
  800a30:	b8 00 00 00 00       	mov    $0x0,%eax
  800a35:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  800a3c:	00 00 00 
  800a3f:	ff d2                	callq  *%rdx
  800a41:	e9 11 ff ff ff       	jmpq   800957 <output+0x23>
  800a46:	e9 0c ff ff ff       	jmpq   800957 <output+0x23>

0000000000800a4b <libmain>:
  800a4b:	55                   	push   %rbp
  800a4c:	48 89 e5             	mov    %rsp,%rbp
  800a4f:	48 83 ec 10          	sub    $0x10,%rsp
  800a53:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800a56:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800a5a:	48 b8 92 21 80 00 00 	movabs $0x802192,%rax
  800a61:	00 00 00 
  800a64:	ff d0                	callq  *%rax
  800a66:	25 ff 03 00 00       	and    $0x3ff,%eax
  800a6b:	48 98                	cltq   
  800a6d:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  800a74:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800a7b:	00 00 00 
  800a7e:	48 01 c2             	add    %rax,%rdx
  800a81:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  800a88:	00 00 00 
  800a8b:	48 89 10             	mov    %rdx,(%rax)
  800a8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800a92:	7e 14                	jle    800aa8 <libmain+0x5d>
  800a94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800a98:	48 8b 10             	mov    (%rax),%rdx
  800a9b:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800aa2:	00 00 00 
  800aa5:	48 89 10             	mov    %rdx,(%rax)
  800aa8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800aac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800aaf:	48 89 d6             	mov    %rdx,%rsi
  800ab2:	89 c7                	mov    %eax,%edi
  800ab4:	48 b8 42 04 80 00 00 	movabs $0x800442,%rax
  800abb:	00 00 00 
  800abe:	ff d0                	callq  *%rax
  800ac0:	48 b8 ce 0a 80 00 00 	movabs $0x800ace,%rax
  800ac7:	00 00 00 
  800aca:	ff d0                	callq  *%rax
  800acc:	c9                   	leaveq 
  800acd:	c3                   	retq   

0000000000800ace <exit>:
  800ace:	55                   	push   %rbp
  800acf:	48 89 e5             	mov    %rsp,%rbp
  800ad2:	48 b8 82 31 80 00 00 	movabs $0x803182,%rax
  800ad9:	00 00 00 
  800adc:	ff d0                	callq  *%rax
  800ade:	bf 00 00 00 00       	mov    $0x0,%edi
  800ae3:	48 b8 4e 21 80 00 00 	movabs $0x80214e,%rax
  800aea:	00 00 00 
  800aed:	ff d0                	callq  *%rax
  800aef:	5d                   	pop    %rbp
  800af0:	c3                   	retq   

0000000000800af1 <_panic>:
  800af1:	55                   	push   %rbp
  800af2:	48 89 e5             	mov    %rsp,%rbp
  800af5:	53                   	push   %rbx
  800af6:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  800afd:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800b04:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800b0a:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800b11:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800b18:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  800b1f:	84 c0                	test   %al,%al
  800b21:	74 23                	je     800b46 <_panic+0x55>
  800b23:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800b2a:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  800b2e:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800b32:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800b36:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800b3a:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  800b3e:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800b42:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800b46:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  800b4d:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  800b54:	00 00 00 
  800b57:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  800b5e:	00 00 00 
  800b61:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800b65:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  800b6c:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  800b73:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800b7a:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  800b81:	00 00 00 
  800b84:	48 8b 18             	mov    (%rax),%rbx
  800b87:	48 b8 92 21 80 00 00 	movabs $0x802192,%rax
  800b8e:	00 00 00 
  800b91:	ff d0                	callq  *%rax
  800b93:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  800b99:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800ba0:	41 89 c8             	mov    %ecx,%r8d
  800ba3:	48 89 d1             	mov    %rdx,%rcx
  800ba6:	48 89 da             	mov    %rbx,%rdx
  800ba9:	89 c6                	mov    %eax,%esi
  800bab:	48 bf 90 57 80 00 00 	movabs $0x805790,%rdi
  800bb2:	00 00 00 
  800bb5:	b8 00 00 00 00       	mov    $0x0,%eax
  800bba:	49 b9 2a 0d 80 00 00 	movabs $0x800d2a,%r9
  800bc1:	00 00 00 
  800bc4:	41 ff d1             	callq  *%r9
  800bc7:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  800bce:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800bd5:	48 89 d6             	mov    %rdx,%rsi
  800bd8:	48 89 c7             	mov    %rax,%rdi
  800bdb:	48 b8 7e 0c 80 00 00 	movabs $0x800c7e,%rax
  800be2:	00 00 00 
  800be5:	ff d0                	callq  *%rax
  800be7:	48 bf b3 57 80 00 00 	movabs $0x8057b3,%rdi
  800bee:	00 00 00 
  800bf1:	b8 00 00 00 00       	mov    $0x0,%eax
  800bf6:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  800bfd:	00 00 00 
  800c00:	ff d2                	callq  *%rdx
  800c02:	cc                   	int3   
  800c03:	eb fd                	jmp    800c02 <_panic+0x111>

0000000000800c05 <putch>:
  800c05:	55                   	push   %rbp
  800c06:	48 89 e5             	mov    %rsp,%rbp
  800c09:	48 83 ec 10          	sub    $0x10,%rsp
  800c0d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800c10:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800c14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c18:	8b 00                	mov    (%rax),%eax
  800c1a:	8d 48 01             	lea    0x1(%rax),%ecx
  800c1d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c21:	89 0a                	mov    %ecx,(%rdx)
  800c23:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800c26:	89 d1                	mov    %edx,%ecx
  800c28:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c2c:	48 98                	cltq   
  800c2e:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800c32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c36:	8b 00                	mov    (%rax),%eax
  800c38:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c3d:	75 2c                	jne    800c6b <putch+0x66>
  800c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c43:	8b 00                	mov    (%rax),%eax
  800c45:	48 98                	cltq   
  800c47:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800c4b:	48 83 c2 08          	add    $0x8,%rdx
  800c4f:	48 89 c6             	mov    %rax,%rsi
  800c52:	48 89 d7             	mov    %rdx,%rdi
  800c55:	48 b8 c6 20 80 00 00 	movabs $0x8020c6,%rax
  800c5c:	00 00 00 
  800c5f:	ff d0                	callq  *%rax
  800c61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c65:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  800c6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c6f:	8b 40 04             	mov    0x4(%rax),%eax
  800c72:	8d 50 01             	lea    0x1(%rax),%edx
  800c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c79:	89 50 04             	mov    %edx,0x4(%rax)
  800c7c:	c9                   	leaveq 
  800c7d:	c3                   	retq   

0000000000800c7e <vcprintf>:
  800c7e:	55                   	push   %rbp
  800c7f:	48 89 e5             	mov    %rsp,%rbp
  800c82:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  800c89:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800c90:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  800c97:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800c9e:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800ca5:	48 8b 0a             	mov    (%rdx),%rcx
  800ca8:	48 89 08             	mov    %rcx,(%rax)
  800cab:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800caf:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800cb3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800cb7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800cbb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800cc2:	00 00 00 
  800cc5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  800ccc:	00 00 00 
  800ccf:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800cd6:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800cdd:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800ce4:	48 89 c6             	mov    %rax,%rsi
  800ce7:	48 bf 05 0c 80 00 00 	movabs $0x800c05,%rdi
  800cee:	00 00 00 
  800cf1:	48 b8 dd 10 80 00 00 	movabs $0x8010dd,%rax
  800cf8:	00 00 00 
  800cfb:	ff d0                	callq  *%rax
  800cfd:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800d03:	48 98                	cltq   
  800d05:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  800d0c:	48 83 c2 08          	add    $0x8,%rdx
  800d10:	48 89 c6             	mov    %rax,%rsi
  800d13:	48 89 d7             	mov    %rdx,%rdi
  800d16:	48 b8 c6 20 80 00 00 	movabs $0x8020c6,%rax
  800d1d:	00 00 00 
  800d20:	ff d0                	callq  *%rax
  800d22:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800d28:	c9                   	leaveq 
  800d29:	c3                   	retq   

0000000000800d2a <cprintf>:
  800d2a:	55                   	push   %rbp
  800d2b:	48 89 e5             	mov    %rsp,%rbp
  800d2e:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800d35:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  800d3c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800d43:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800d4a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800d51:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800d58:	84 c0                	test   %al,%al
  800d5a:	74 20                	je     800d7c <cprintf+0x52>
  800d5c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800d60:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800d64:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800d68:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800d6c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800d70:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800d74:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800d78:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800d7c:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800d83:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  800d8a:	00 00 00 
  800d8d:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800d94:	00 00 00 
  800d97:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800d9b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800da2:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800da9:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800db0:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800db7:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800dbe:	48 8b 0a             	mov    (%rdx),%rcx
  800dc1:	48 89 08             	mov    %rcx,(%rax)
  800dc4:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800dc8:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800dcc:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800dd0:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800dd4:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  800ddb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800de2:	48 89 d6             	mov    %rdx,%rsi
  800de5:	48 89 c7             	mov    %rax,%rdi
  800de8:	48 b8 7e 0c 80 00 00 	movabs $0x800c7e,%rax
  800def:	00 00 00 
  800df2:	ff d0                	callq  *%rax
  800df4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800dfa:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800e00:	c9                   	leaveq 
  800e01:	c3                   	retq   

0000000000800e02 <printnum>:
  800e02:	55                   	push   %rbp
  800e03:	48 89 e5             	mov    %rsp,%rbp
  800e06:	53                   	push   %rbx
  800e07:	48 83 ec 38          	sub    $0x38,%rsp
  800e0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800e0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800e13:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800e17:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800e1a:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  800e1e:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800e22:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800e25:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800e29:	77 3b                	ja     800e66 <printnum+0x64>
  800e2b:	8b 45 d0             	mov    -0x30(%rbp),%eax
  800e2e:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800e32:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800e35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800e39:	ba 00 00 00 00       	mov    $0x0,%edx
  800e3e:	48 f7 f3             	div    %rbx
  800e41:	48 89 c2             	mov    %rax,%rdx
  800e44:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800e47:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800e4a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800e4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e52:	41 89 f9             	mov    %edi,%r9d
  800e55:	48 89 c7             	mov    %rax,%rdi
  800e58:	48 b8 02 0e 80 00 00 	movabs $0x800e02,%rax
  800e5f:	00 00 00 
  800e62:	ff d0                	callq  *%rax
  800e64:	eb 1e                	jmp    800e84 <printnum+0x82>
  800e66:	eb 12                	jmp    800e7a <printnum+0x78>
  800e68:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800e6c:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800e6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e73:	48 89 ce             	mov    %rcx,%rsi
  800e76:	89 d7                	mov    %edx,%edi
  800e78:	ff d0                	callq  *%rax
  800e7a:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800e7e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800e82:	7f e4                	jg     800e68 <printnum+0x66>
  800e84:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800e87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800e8b:	ba 00 00 00 00       	mov    $0x0,%edx
  800e90:	48 f7 f1             	div    %rcx
  800e93:	48 89 d0             	mov    %rdx,%rax
  800e96:	48 ba b0 59 80 00 00 	movabs $0x8059b0,%rdx
  800e9d:	00 00 00 
  800ea0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800ea4:	0f be d0             	movsbl %al,%edx
  800ea7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  800eab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800eaf:	48 89 ce             	mov    %rcx,%rsi
  800eb2:	89 d7                	mov    %edx,%edi
  800eb4:	ff d0                	callq  *%rax
  800eb6:	48 83 c4 38          	add    $0x38,%rsp
  800eba:	5b                   	pop    %rbx
  800ebb:	5d                   	pop    %rbp
  800ebc:	c3                   	retq   

0000000000800ebd <getuint>:
  800ebd:	55                   	push   %rbp
  800ebe:	48 89 e5             	mov    %rsp,%rbp
  800ec1:	48 83 ec 1c          	sub    $0x1c,%rsp
  800ec5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800ec9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800ecc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800ed0:	7e 52                	jle    800f24 <getuint+0x67>
  800ed2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ed6:	8b 00                	mov    (%rax),%eax
  800ed8:	83 f8 30             	cmp    $0x30,%eax
  800edb:	73 24                	jae    800f01 <getuint+0x44>
  800edd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ee1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800ee5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ee9:	8b 00                	mov    (%rax),%eax
  800eeb:	89 c0                	mov    %eax,%eax
  800eed:	48 01 d0             	add    %rdx,%rax
  800ef0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800ef4:	8b 12                	mov    (%rdx),%edx
  800ef6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800ef9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800efd:	89 0a                	mov    %ecx,(%rdx)
  800eff:	eb 17                	jmp    800f18 <getuint+0x5b>
  800f01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f05:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800f09:	48 89 d0             	mov    %rdx,%rax
  800f0c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800f10:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f14:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800f18:	48 8b 00             	mov    (%rax),%rax
  800f1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800f1f:	e9 a3 00 00 00       	jmpq   800fc7 <getuint+0x10a>
  800f24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800f28:	74 4f                	je     800f79 <getuint+0xbc>
  800f2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f2e:	8b 00                	mov    (%rax),%eax
  800f30:	83 f8 30             	cmp    $0x30,%eax
  800f33:	73 24                	jae    800f59 <getuint+0x9c>
  800f35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f39:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800f3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f41:	8b 00                	mov    (%rax),%eax
  800f43:	89 c0                	mov    %eax,%eax
  800f45:	48 01 d0             	add    %rdx,%rax
  800f48:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f4c:	8b 12                	mov    (%rdx),%edx
  800f4e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800f51:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f55:	89 0a                	mov    %ecx,(%rdx)
  800f57:	eb 17                	jmp    800f70 <getuint+0xb3>
  800f59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f5d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800f61:	48 89 d0             	mov    %rdx,%rax
  800f64:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800f68:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f6c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800f70:	48 8b 00             	mov    (%rax),%rax
  800f73:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800f77:	eb 4e                	jmp    800fc7 <getuint+0x10a>
  800f79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f7d:	8b 00                	mov    (%rax),%eax
  800f7f:	83 f8 30             	cmp    $0x30,%eax
  800f82:	73 24                	jae    800fa8 <getuint+0xeb>
  800f84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f88:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f90:	8b 00                	mov    (%rax),%eax
  800f92:	89 c0                	mov    %eax,%eax
  800f94:	48 01 d0             	add    %rdx,%rax
  800f97:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f9b:	8b 12                	mov    (%rdx),%edx
  800f9d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800fa0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800fa4:	89 0a                	mov    %ecx,(%rdx)
  800fa6:	eb 17                	jmp    800fbf <getuint+0x102>
  800fa8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fac:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800fb0:	48 89 d0             	mov    %rdx,%rax
  800fb3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800fb7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800fbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800fbf:	8b 00                	mov    (%rax),%eax
  800fc1:	89 c0                	mov    %eax,%eax
  800fc3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fcb:	c9                   	leaveq 
  800fcc:	c3                   	retq   

0000000000800fcd <getint>:
  800fcd:	55                   	push   %rbp
  800fce:	48 89 e5             	mov    %rsp,%rbp
  800fd1:	48 83 ec 1c          	sub    $0x1c,%rsp
  800fd5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fd9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800fdc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800fe0:	7e 52                	jle    801034 <getint+0x67>
  800fe2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fe6:	8b 00                	mov    (%rax),%eax
  800fe8:	83 f8 30             	cmp    $0x30,%eax
  800feb:	73 24                	jae    801011 <getint+0x44>
  800fed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ff1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800ff5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ff9:	8b 00                	mov    (%rax),%eax
  800ffb:	89 c0                	mov    %eax,%eax
  800ffd:	48 01 d0             	add    %rdx,%rax
  801000:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801004:	8b 12                	mov    (%rdx),%edx
  801006:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801009:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80100d:	89 0a                	mov    %ecx,(%rdx)
  80100f:	eb 17                	jmp    801028 <getint+0x5b>
  801011:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801015:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801019:	48 89 d0             	mov    %rdx,%rax
  80101c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  801020:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801024:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801028:	48 8b 00             	mov    (%rax),%rax
  80102b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80102f:	e9 a3 00 00 00       	jmpq   8010d7 <getint+0x10a>
  801034:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  801038:	74 4f                	je     801089 <getint+0xbc>
  80103a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80103e:	8b 00                	mov    (%rax),%eax
  801040:	83 f8 30             	cmp    $0x30,%eax
  801043:	73 24                	jae    801069 <getint+0x9c>
  801045:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801049:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80104d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801051:	8b 00                	mov    (%rax),%eax
  801053:	89 c0                	mov    %eax,%eax
  801055:	48 01 d0             	add    %rdx,%rax
  801058:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80105c:	8b 12                	mov    (%rdx),%edx
  80105e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801061:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801065:	89 0a                	mov    %ecx,(%rdx)
  801067:	eb 17                	jmp    801080 <getint+0xb3>
  801069:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80106d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  801071:	48 89 d0             	mov    %rdx,%rax
  801074:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  801078:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80107c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801080:	48 8b 00             	mov    (%rax),%rax
  801083:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801087:	eb 4e                	jmp    8010d7 <getint+0x10a>
  801089:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80108d:	8b 00                	mov    (%rax),%eax
  80108f:	83 f8 30             	cmp    $0x30,%eax
  801092:	73 24                	jae    8010b8 <getint+0xeb>
  801094:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801098:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80109c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010a0:	8b 00                	mov    (%rax),%eax
  8010a2:	89 c0                	mov    %eax,%eax
  8010a4:	48 01 d0             	add    %rdx,%rax
  8010a7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010ab:	8b 12                	mov    (%rdx),%edx
  8010ad:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8010b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010b4:	89 0a                	mov    %ecx,(%rdx)
  8010b6:	eb 17                	jmp    8010cf <getint+0x102>
  8010b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010bc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8010c0:	48 89 d0             	mov    %rdx,%rax
  8010c3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8010c7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8010cf:	8b 00                	mov    (%rax),%eax
  8010d1:	48 98                	cltq   
  8010d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8010d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010db:	c9                   	leaveq 
  8010dc:	c3                   	retq   

00000000008010dd <vprintfmt>:
  8010dd:	55                   	push   %rbp
  8010de:	48 89 e5             	mov    %rsp,%rbp
  8010e1:	41 54                	push   %r12
  8010e3:	53                   	push   %rbx
  8010e4:	48 83 ec 60          	sub    $0x60,%rsp
  8010e8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  8010ec:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8010f0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8010f4:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8010f8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8010fc:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  801100:	48 8b 0a             	mov    (%rdx),%rcx
  801103:	48 89 08             	mov    %rcx,(%rax)
  801106:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80110a:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80110e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801112:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801116:	eb 17                	jmp    80112f <vprintfmt+0x52>
  801118:	85 db                	test   %ebx,%ebx
  80111a:	0f 84 cc 04 00 00    	je     8015ec <vprintfmt+0x50f>
  801120:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801124:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801128:	48 89 d6             	mov    %rdx,%rsi
  80112b:	89 df                	mov    %ebx,%edi
  80112d:	ff d0                	callq  *%rax
  80112f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801133:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801137:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  80113b:	0f b6 00             	movzbl (%rax),%eax
  80113e:	0f b6 d8             	movzbl %al,%ebx
  801141:	83 fb 25             	cmp    $0x25,%ebx
  801144:	75 d2                	jne    801118 <vprintfmt+0x3b>
  801146:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  80114a:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  801151:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  801158:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80115f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  801166:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80116a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80116e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  801172:	0f b6 00             	movzbl (%rax),%eax
  801175:	0f b6 d8             	movzbl %al,%ebx
  801178:	8d 43 dd             	lea    -0x23(%rbx),%eax
  80117b:	83 f8 55             	cmp    $0x55,%eax
  80117e:	0f 87 34 04 00 00    	ja     8015b8 <vprintfmt+0x4db>
  801184:	89 c0                	mov    %eax,%eax
  801186:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  80118d:	00 
  80118e:	48 b8 d8 59 80 00 00 	movabs $0x8059d8,%rax
  801195:	00 00 00 
  801198:	48 01 d0             	add    %rdx,%rax
  80119b:	48 8b 00             	mov    (%rax),%rax
  80119e:	ff e0                	jmpq   *%rax
  8011a0:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  8011a4:	eb c0                	jmp    801166 <vprintfmt+0x89>
  8011a6:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  8011aa:	eb ba                	jmp    801166 <vprintfmt+0x89>
  8011ac:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  8011b3:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8011b6:	89 d0                	mov    %edx,%eax
  8011b8:	c1 e0 02             	shl    $0x2,%eax
  8011bb:	01 d0                	add    %edx,%eax
  8011bd:	01 c0                	add    %eax,%eax
  8011bf:	01 d8                	add    %ebx,%eax
  8011c1:	83 e8 30             	sub    $0x30,%eax
  8011c4:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8011c7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8011cb:	0f b6 00             	movzbl (%rax),%eax
  8011ce:	0f be d8             	movsbl %al,%ebx
  8011d1:	83 fb 2f             	cmp    $0x2f,%ebx
  8011d4:	7e 0c                	jle    8011e2 <vprintfmt+0x105>
  8011d6:	83 fb 39             	cmp    $0x39,%ebx
  8011d9:	7f 07                	jg     8011e2 <vprintfmt+0x105>
  8011db:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  8011e0:	eb d1                	jmp    8011b3 <vprintfmt+0xd6>
  8011e2:	eb 58                	jmp    80123c <vprintfmt+0x15f>
  8011e4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8011e7:	83 f8 30             	cmp    $0x30,%eax
  8011ea:	73 17                	jae    801203 <vprintfmt+0x126>
  8011ec:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8011f0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8011f3:	89 c0                	mov    %eax,%eax
  8011f5:	48 01 d0             	add    %rdx,%rax
  8011f8:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8011fb:	83 c2 08             	add    $0x8,%edx
  8011fe:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801201:	eb 0f                	jmp    801212 <vprintfmt+0x135>
  801203:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801207:	48 89 d0             	mov    %rdx,%rax
  80120a:	48 83 c2 08          	add    $0x8,%rdx
  80120e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801212:	8b 00                	mov    (%rax),%eax
  801214:	89 45 d8             	mov    %eax,-0x28(%rbp)
  801217:	eb 23                	jmp    80123c <vprintfmt+0x15f>
  801219:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80121d:	79 0c                	jns    80122b <vprintfmt+0x14e>
  80121f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  801226:	e9 3b ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  80122b:	e9 36 ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  801230:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  801237:	e9 2a ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  80123c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801240:	79 12                	jns    801254 <vprintfmt+0x177>
  801242:	8b 45 d8             	mov    -0x28(%rbp),%eax
  801245:	89 45 dc             	mov    %eax,-0x24(%rbp)
  801248:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80124f:	e9 12 ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  801254:	e9 0d ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  801259:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  80125d:	e9 04 ff ff ff       	jmpq   801166 <vprintfmt+0x89>
  801262:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801265:	83 f8 30             	cmp    $0x30,%eax
  801268:	73 17                	jae    801281 <vprintfmt+0x1a4>
  80126a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80126e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801271:	89 c0                	mov    %eax,%eax
  801273:	48 01 d0             	add    %rdx,%rax
  801276:	8b 55 b8             	mov    -0x48(%rbp),%edx
  801279:	83 c2 08             	add    $0x8,%edx
  80127c:	89 55 b8             	mov    %edx,-0x48(%rbp)
  80127f:	eb 0f                	jmp    801290 <vprintfmt+0x1b3>
  801281:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801285:	48 89 d0             	mov    %rdx,%rax
  801288:	48 83 c2 08          	add    $0x8,%rdx
  80128c:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801290:	8b 10                	mov    (%rax),%edx
  801292:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  801296:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80129a:	48 89 ce             	mov    %rcx,%rsi
  80129d:	89 d7                	mov    %edx,%edi
  80129f:	ff d0                	callq  *%rax
  8012a1:	e9 40 03 00 00       	jmpq   8015e6 <vprintfmt+0x509>
  8012a6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8012a9:	83 f8 30             	cmp    $0x30,%eax
  8012ac:	73 17                	jae    8012c5 <vprintfmt+0x1e8>
  8012ae:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8012b2:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8012b5:	89 c0                	mov    %eax,%eax
  8012b7:	48 01 d0             	add    %rdx,%rax
  8012ba:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8012bd:	83 c2 08             	add    $0x8,%edx
  8012c0:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8012c3:	eb 0f                	jmp    8012d4 <vprintfmt+0x1f7>
  8012c5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8012c9:	48 89 d0             	mov    %rdx,%rax
  8012cc:	48 83 c2 08          	add    $0x8,%rdx
  8012d0:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8012d4:	8b 18                	mov    (%rax),%ebx
  8012d6:	85 db                	test   %ebx,%ebx
  8012d8:	79 02                	jns    8012dc <vprintfmt+0x1ff>
  8012da:	f7 db                	neg    %ebx
  8012dc:	83 fb 15             	cmp    $0x15,%ebx
  8012df:	7f 16                	jg     8012f7 <vprintfmt+0x21a>
  8012e1:	48 b8 00 59 80 00 00 	movabs $0x805900,%rax
  8012e8:	00 00 00 
  8012eb:	48 63 d3             	movslq %ebx,%rdx
  8012ee:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  8012f2:	4d 85 e4             	test   %r12,%r12
  8012f5:	75 2e                	jne    801325 <vprintfmt+0x248>
  8012f7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8012fb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8012ff:	89 d9                	mov    %ebx,%ecx
  801301:	48 ba c1 59 80 00 00 	movabs $0x8059c1,%rdx
  801308:	00 00 00 
  80130b:	48 89 c7             	mov    %rax,%rdi
  80130e:	b8 00 00 00 00       	mov    $0x0,%eax
  801313:	49 b8 f5 15 80 00 00 	movabs $0x8015f5,%r8
  80131a:	00 00 00 
  80131d:	41 ff d0             	callq  *%r8
  801320:	e9 c1 02 00 00       	jmpq   8015e6 <vprintfmt+0x509>
  801325:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  801329:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80132d:	4c 89 e1             	mov    %r12,%rcx
  801330:	48 ba ca 59 80 00 00 	movabs $0x8059ca,%rdx
  801337:	00 00 00 
  80133a:	48 89 c7             	mov    %rax,%rdi
  80133d:	b8 00 00 00 00       	mov    $0x0,%eax
  801342:	49 b8 f5 15 80 00 00 	movabs $0x8015f5,%r8
  801349:	00 00 00 
  80134c:	41 ff d0             	callq  *%r8
  80134f:	e9 92 02 00 00       	jmpq   8015e6 <vprintfmt+0x509>
  801354:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801357:	83 f8 30             	cmp    $0x30,%eax
  80135a:	73 17                	jae    801373 <vprintfmt+0x296>
  80135c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801360:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801363:	89 c0                	mov    %eax,%eax
  801365:	48 01 d0             	add    %rdx,%rax
  801368:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80136b:	83 c2 08             	add    $0x8,%edx
  80136e:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801371:	eb 0f                	jmp    801382 <vprintfmt+0x2a5>
  801373:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  801377:	48 89 d0             	mov    %rdx,%rax
  80137a:	48 83 c2 08          	add    $0x8,%rdx
  80137e:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801382:	4c 8b 20             	mov    (%rax),%r12
  801385:	4d 85 e4             	test   %r12,%r12
  801388:	75 0a                	jne    801394 <vprintfmt+0x2b7>
  80138a:	49 bc cd 59 80 00 00 	movabs $0x8059cd,%r12
  801391:	00 00 00 
  801394:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  801398:	7e 3f                	jle    8013d9 <vprintfmt+0x2fc>
  80139a:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  80139e:	74 39                	je     8013d9 <vprintfmt+0x2fc>
  8013a0:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8013a3:	48 98                	cltq   
  8013a5:	48 89 c6             	mov    %rax,%rsi
  8013a8:	4c 89 e7             	mov    %r12,%rdi
  8013ab:	48 b8 a1 18 80 00 00 	movabs $0x8018a1,%rax
  8013b2:	00 00 00 
  8013b5:	ff d0                	callq  *%rax
  8013b7:	29 45 dc             	sub    %eax,-0x24(%rbp)
  8013ba:	eb 17                	jmp    8013d3 <vprintfmt+0x2f6>
  8013bc:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  8013c0:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  8013c4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8013c8:	48 89 ce             	mov    %rcx,%rsi
  8013cb:	89 d7                	mov    %edx,%edi
  8013cd:	ff d0                	callq  *%rax
  8013cf:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  8013d3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8013d7:	7f e3                	jg     8013bc <vprintfmt+0x2df>
  8013d9:	eb 37                	jmp    801412 <vprintfmt+0x335>
  8013db:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  8013df:	74 1e                	je     8013ff <vprintfmt+0x322>
  8013e1:	83 fb 1f             	cmp    $0x1f,%ebx
  8013e4:	7e 05                	jle    8013eb <vprintfmt+0x30e>
  8013e6:	83 fb 7e             	cmp    $0x7e,%ebx
  8013e9:	7e 14                	jle    8013ff <vprintfmt+0x322>
  8013eb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8013ef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8013f3:	48 89 d6             	mov    %rdx,%rsi
  8013f6:	bf 3f 00 00 00       	mov    $0x3f,%edi
  8013fb:	ff d0                	callq  *%rax
  8013fd:	eb 0f                	jmp    80140e <vprintfmt+0x331>
  8013ff:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801403:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801407:	48 89 d6             	mov    %rdx,%rsi
  80140a:	89 df                	mov    %ebx,%edi
  80140c:	ff d0                	callq  *%rax
  80140e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  801412:	4c 89 e0             	mov    %r12,%rax
  801415:	4c 8d 60 01          	lea    0x1(%rax),%r12
  801419:	0f b6 00             	movzbl (%rax),%eax
  80141c:	0f be d8             	movsbl %al,%ebx
  80141f:	85 db                	test   %ebx,%ebx
  801421:	74 10                	je     801433 <vprintfmt+0x356>
  801423:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801427:	78 b2                	js     8013db <vprintfmt+0x2fe>
  801429:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  80142d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801431:	79 a8                	jns    8013db <vprintfmt+0x2fe>
  801433:	eb 16                	jmp    80144b <vprintfmt+0x36e>
  801435:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801439:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80143d:	48 89 d6             	mov    %rdx,%rsi
  801440:	bf 20 00 00 00       	mov    $0x20,%edi
  801445:	ff d0                	callq  *%rax
  801447:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  80144b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80144f:	7f e4                	jg     801435 <vprintfmt+0x358>
  801451:	e9 90 01 00 00       	jmpq   8015e6 <vprintfmt+0x509>
  801456:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80145a:	be 03 00 00 00       	mov    $0x3,%esi
  80145f:	48 89 c7             	mov    %rax,%rdi
  801462:	48 b8 cd 0f 80 00 00 	movabs $0x800fcd,%rax
  801469:	00 00 00 
  80146c:	ff d0                	callq  *%rax
  80146e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801472:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801476:	48 85 c0             	test   %rax,%rax
  801479:	79 1d                	jns    801498 <vprintfmt+0x3bb>
  80147b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80147f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801483:	48 89 d6             	mov    %rdx,%rsi
  801486:	bf 2d 00 00 00       	mov    $0x2d,%edi
  80148b:	ff d0                	callq  *%rax
  80148d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801491:	48 f7 d8             	neg    %rax
  801494:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801498:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  80149f:	e9 d5 00 00 00       	jmpq   801579 <vprintfmt+0x49c>
  8014a4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8014a8:	be 03 00 00 00       	mov    $0x3,%esi
  8014ad:	48 89 c7             	mov    %rax,%rdi
  8014b0:	48 b8 bd 0e 80 00 00 	movabs $0x800ebd,%rax
  8014b7:	00 00 00 
  8014ba:	ff d0                	callq  *%rax
  8014bc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8014c0:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  8014c7:	e9 ad 00 00 00       	jmpq   801579 <vprintfmt+0x49c>
  8014cc:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8014d0:	be 03 00 00 00       	mov    $0x3,%esi
  8014d5:	48 89 c7             	mov    %rax,%rdi
  8014d8:	48 b8 bd 0e 80 00 00 	movabs $0x800ebd,%rax
  8014df:	00 00 00 
  8014e2:	ff d0                	callq  *%rax
  8014e4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8014e8:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  8014ef:	e9 85 00 00 00       	jmpq   801579 <vprintfmt+0x49c>
  8014f4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8014f8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8014fc:	48 89 d6             	mov    %rdx,%rsi
  8014ff:	bf 30 00 00 00       	mov    $0x30,%edi
  801504:	ff d0                	callq  *%rax
  801506:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80150a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80150e:	48 89 d6             	mov    %rdx,%rsi
  801511:	bf 78 00 00 00       	mov    $0x78,%edi
  801516:	ff d0                	callq  *%rax
  801518:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80151b:	83 f8 30             	cmp    $0x30,%eax
  80151e:	73 17                	jae    801537 <vprintfmt+0x45a>
  801520:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801524:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801527:	89 c0                	mov    %eax,%eax
  801529:	48 01 d0             	add    %rdx,%rax
  80152c:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80152f:	83 c2 08             	add    $0x8,%edx
  801532:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801535:	eb 0f                	jmp    801546 <vprintfmt+0x469>
  801537:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80153b:	48 89 d0             	mov    %rdx,%rax
  80153e:	48 83 c2 08          	add    $0x8,%rdx
  801542:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801546:	48 8b 00             	mov    (%rax),%rax
  801549:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80154d:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801554:	eb 23                	jmp    801579 <vprintfmt+0x49c>
  801556:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80155a:	be 03 00 00 00       	mov    $0x3,%esi
  80155f:	48 89 c7             	mov    %rax,%rdi
  801562:	48 b8 bd 0e 80 00 00 	movabs $0x800ebd,%rax
  801569:	00 00 00 
  80156c:	ff d0                	callq  *%rax
  80156e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801572:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  801579:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  80157e:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  801581:	8b 7d dc             	mov    -0x24(%rbp),%edi
  801584:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801588:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  80158c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801590:	45 89 c1             	mov    %r8d,%r9d
  801593:	41 89 f8             	mov    %edi,%r8d
  801596:	48 89 c7             	mov    %rax,%rdi
  801599:	48 b8 02 0e 80 00 00 	movabs $0x800e02,%rax
  8015a0:	00 00 00 
  8015a3:	ff d0                	callq  *%rax
  8015a5:	eb 3f                	jmp    8015e6 <vprintfmt+0x509>
  8015a7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8015ab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8015af:	48 89 d6             	mov    %rdx,%rsi
  8015b2:	89 df                	mov    %ebx,%edi
  8015b4:	ff d0                	callq  *%rax
  8015b6:	eb 2e                	jmp    8015e6 <vprintfmt+0x509>
  8015b8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8015bc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8015c0:	48 89 d6             	mov    %rdx,%rsi
  8015c3:	bf 25 00 00 00       	mov    $0x25,%edi
  8015c8:	ff d0                	callq  *%rax
  8015ca:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8015cf:	eb 05                	jmp    8015d6 <vprintfmt+0x4f9>
  8015d1:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  8015d6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8015da:	48 83 e8 01          	sub    $0x1,%rax
  8015de:	0f b6 00             	movzbl (%rax),%eax
  8015e1:	3c 25                	cmp    $0x25,%al
  8015e3:	75 ec                	jne    8015d1 <vprintfmt+0x4f4>
  8015e5:	90                   	nop
  8015e6:	90                   	nop
  8015e7:	e9 43 fb ff ff       	jmpq   80112f <vprintfmt+0x52>
  8015ec:	48 83 c4 60          	add    $0x60,%rsp
  8015f0:	5b                   	pop    %rbx
  8015f1:	41 5c                	pop    %r12
  8015f3:	5d                   	pop    %rbp
  8015f4:	c3                   	retq   

00000000008015f5 <printfmt>:
  8015f5:	55                   	push   %rbp
  8015f6:	48 89 e5             	mov    %rsp,%rbp
  8015f9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  801600:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801607:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80160e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801615:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80161c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801623:	84 c0                	test   %al,%al
  801625:	74 20                	je     801647 <printfmt+0x52>
  801627:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80162b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80162f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801633:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801637:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80163b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80163f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801643:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801647:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80164e:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  801655:	00 00 00 
  801658:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  80165f:	00 00 00 
  801662:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801666:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80166d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801674:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  80167b:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  801682:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  801689:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  801690:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  801697:	48 89 c7             	mov    %rax,%rdi
  80169a:	48 b8 dd 10 80 00 00 	movabs $0x8010dd,%rax
  8016a1:	00 00 00 
  8016a4:	ff d0                	callq  *%rax
  8016a6:	c9                   	leaveq 
  8016a7:	c3                   	retq   

00000000008016a8 <sprintputch>:
  8016a8:	55                   	push   %rbp
  8016a9:	48 89 e5             	mov    %rsp,%rbp
  8016ac:	48 83 ec 10          	sub    $0x10,%rsp
  8016b0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8016b3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8016b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016bb:	8b 40 10             	mov    0x10(%rax),%eax
  8016be:	8d 50 01             	lea    0x1(%rax),%edx
  8016c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016c5:	89 50 10             	mov    %edx,0x10(%rax)
  8016c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016cc:	48 8b 10             	mov    (%rax),%rdx
  8016cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016d3:	48 8b 40 08          	mov    0x8(%rax),%rax
  8016d7:	48 39 c2             	cmp    %rax,%rdx
  8016da:	73 17                	jae    8016f3 <sprintputch+0x4b>
  8016dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8016e0:	48 8b 00             	mov    (%rax),%rax
  8016e3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  8016e7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8016eb:	48 89 0a             	mov    %rcx,(%rdx)
  8016ee:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8016f1:	88 10                	mov    %dl,(%rax)
  8016f3:	c9                   	leaveq 
  8016f4:	c3                   	retq   

00000000008016f5 <vsnprintf>:
  8016f5:	55                   	push   %rbp
  8016f6:	48 89 e5             	mov    %rsp,%rbp
  8016f9:	48 83 ec 50          	sub    $0x50,%rsp
  8016fd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801701:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801704:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801708:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  80170c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  801710:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801714:	48 8b 0a             	mov    (%rdx),%rcx
  801717:	48 89 08             	mov    %rcx,(%rax)
  80171a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80171e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801722:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801726:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80172a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80172e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801732:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801735:	48 98                	cltq   
  801737:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80173b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80173f:	48 01 d0             	add    %rdx,%rax
  801742:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801746:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80174d:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  801752:	74 06                	je     80175a <vsnprintf+0x65>
  801754:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  801758:	7f 07                	jg     801761 <vsnprintf+0x6c>
  80175a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80175f:	eb 2f                	jmp    801790 <vsnprintf+0x9b>
  801761:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  801765:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  801769:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  80176d:	48 89 c6             	mov    %rax,%rsi
  801770:	48 bf a8 16 80 00 00 	movabs $0x8016a8,%rdi
  801777:	00 00 00 
  80177a:	48 b8 dd 10 80 00 00 	movabs $0x8010dd,%rax
  801781:	00 00 00 
  801784:	ff d0                	callq  *%rax
  801786:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80178a:	c6 00 00             	movb   $0x0,(%rax)
  80178d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  801790:	c9                   	leaveq 
  801791:	c3                   	retq   

0000000000801792 <snprintf>:
  801792:	55                   	push   %rbp
  801793:	48 89 e5             	mov    %rsp,%rbp
  801796:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  80179d:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8017a4:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8017aa:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8017b1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8017b8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8017bf:	84 c0                	test   %al,%al
  8017c1:	74 20                	je     8017e3 <snprintf+0x51>
  8017c3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8017c7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8017cb:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8017cf:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8017d3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8017d7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8017db:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8017df:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8017e3:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  8017ea:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  8017f1:	00 00 00 
  8017f4:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8017fb:	00 00 00 
  8017fe:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801802:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801809:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  801810:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801817:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80181e:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801825:	48 8b 0a             	mov    (%rdx),%rcx
  801828:	48 89 08             	mov    %rcx,(%rax)
  80182b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80182f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801833:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801837:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80183b:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801842:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801849:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80184f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  801856:	48 89 c7             	mov    %rax,%rdi
  801859:	48 b8 f5 16 80 00 00 	movabs $0x8016f5,%rax
  801860:	00 00 00 
  801863:	ff d0                	callq  *%rax
  801865:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  80186b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  801871:	c9                   	leaveq 
  801872:	c3                   	retq   

0000000000801873 <strlen>:
  801873:	55                   	push   %rbp
  801874:	48 89 e5             	mov    %rsp,%rbp
  801877:	48 83 ec 18          	sub    $0x18,%rsp
  80187b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80187f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801886:	eb 09                	jmp    801891 <strlen+0x1e>
  801888:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80188c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801891:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801895:	0f b6 00             	movzbl (%rax),%eax
  801898:	84 c0                	test   %al,%al
  80189a:	75 ec                	jne    801888 <strlen+0x15>
  80189c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80189f:	c9                   	leaveq 
  8018a0:	c3                   	retq   

00000000008018a1 <strnlen>:
  8018a1:	55                   	push   %rbp
  8018a2:	48 89 e5             	mov    %rsp,%rbp
  8018a5:	48 83 ec 20          	sub    $0x20,%rsp
  8018a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8018ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8018b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8018b8:	eb 0e                	jmp    8018c8 <strnlen+0x27>
  8018ba:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8018be:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8018c3:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  8018c8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  8018cd:	74 0b                	je     8018da <strnlen+0x39>
  8018cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018d3:	0f b6 00             	movzbl (%rax),%eax
  8018d6:	84 c0                	test   %al,%al
  8018d8:	75 e0                	jne    8018ba <strnlen+0x19>
  8018da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018dd:	c9                   	leaveq 
  8018de:	c3                   	retq   

00000000008018df <strcpy>:
  8018df:	55                   	push   %rbp
  8018e0:	48 89 e5             	mov    %rsp,%rbp
  8018e3:	48 83 ec 20          	sub    $0x20,%rsp
  8018e7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8018eb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8018ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018f7:	90                   	nop
  8018f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018fc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801900:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801904:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801908:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80190c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801910:	0f b6 12             	movzbl (%rdx),%edx
  801913:	88 10                	mov    %dl,(%rax)
  801915:	0f b6 00             	movzbl (%rax),%eax
  801918:	84 c0                	test   %al,%al
  80191a:	75 dc                	jne    8018f8 <strcpy+0x19>
  80191c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801920:	c9                   	leaveq 
  801921:	c3                   	retq   

0000000000801922 <strcat>:
  801922:	55                   	push   %rbp
  801923:	48 89 e5             	mov    %rsp,%rbp
  801926:	48 83 ec 20          	sub    $0x20,%rsp
  80192a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80192e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801932:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801936:	48 89 c7             	mov    %rax,%rdi
  801939:	48 b8 73 18 80 00 00 	movabs $0x801873,%rax
  801940:	00 00 00 
  801943:	ff d0                	callq  *%rax
  801945:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801948:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80194b:	48 63 d0             	movslq %eax,%rdx
  80194e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801952:	48 01 c2             	add    %rax,%rdx
  801955:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801959:	48 89 c6             	mov    %rax,%rsi
  80195c:	48 89 d7             	mov    %rdx,%rdi
  80195f:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  801966:	00 00 00 
  801969:	ff d0                	callq  *%rax
  80196b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80196f:	c9                   	leaveq 
  801970:	c3                   	retq   

0000000000801971 <strncpy>:
  801971:	55                   	push   %rbp
  801972:	48 89 e5             	mov    %rsp,%rbp
  801975:	48 83 ec 28          	sub    $0x28,%rsp
  801979:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80197d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801981:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801985:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801989:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80198d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801994:	00 
  801995:	eb 2a                	jmp    8019c1 <strncpy+0x50>
  801997:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80199b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80199f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8019a3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8019a7:	0f b6 12             	movzbl (%rdx),%edx
  8019aa:	88 10                	mov    %dl,(%rax)
  8019ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8019b0:	0f b6 00             	movzbl (%rax),%eax
  8019b3:	84 c0                	test   %al,%al
  8019b5:	74 05                	je     8019bc <strncpy+0x4b>
  8019b7:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  8019bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8019c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019c5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8019c9:	72 cc                	jb     801997 <strncpy+0x26>
  8019cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8019cf:	c9                   	leaveq 
  8019d0:	c3                   	retq   

00000000008019d1 <strlcpy>:
  8019d1:	55                   	push   %rbp
  8019d2:	48 89 e5             	mov    %rsp,%rbp
  8019d5:	48 83 ec 28          	sub    $0x28,%rsp
  8019d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8019dd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8019e1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8019e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8019ed:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8019f2:	74 3d                	je     801a31 <strlcpy+0x60>
  8019f4:	eb 1d                	jmp    801a13 <strlcpy+0x42>
  8019f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019fa:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8019fe:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801a02:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801a06:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801a0a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  801a0e:	0f b6 12             	movzbl (%rdx),%edx
  801a11:	88 10                	mov    %dl,(%rax)
  801a13:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801a18:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801a1d:	74 0b                	je     801a2a <strlcpy+0x59>
  801a1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801a23:	0f b6 00             	movzbl (%rax),%eax
  801a26:	84 c0                	test   %al,%al
  801a28:	75 cc                	jne    8019f6 <strlcpy+0x25>
  801a2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a2e:	c6 00 00             	movb   $0x0,(%rax)
  801a31:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a39:	48 29 c2             	sub    %rax,%rdx
  801a3c:	48 89 d0             	mov    %rdx,%rax
  801a3f:	c9                   	leaveq 
  801a40:	c3                   	retq   

0000000000801a41 <strcmp>:
  801a41:	55                   	push   %rbp
  801a42:	48 89 e5             	mov    %rsp,%rbp
  801a45:	48 83 ec 10          	sub    $0x10,%rsp
  801a49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a4d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a51:	eb 0a                	jmp    801a5d <strcmp+0x1c>
  801a53:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801a58:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801a5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a61:	0f b6 00             	movzbl (%rax),%eax
  801a64:	84 c0                	test   %al,%al
  801a66:	74 12                	je     801a7a <strcmp+0x39>
  801a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a6c:	0f b6 10             	movzbl (%rax),%edx
  801a6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a73:	0f b6 00             	movzbl (%rax),%eax
  801a76:	38 c2                	cmp    %al,%dl
  801a78:	74 d9                	je     801a53 <strcmp+0x12>
  801a7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a7e:	0f b6 00             	movzbl (%rax),%eax
  801a81:	0f b6 d0             	movzbl %al,%edx
  801a84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a88:	0f b6 00             	movzbl (%rax),%eax
  801a8b:	0f b6 c0             	movzbl %al,%eax
  801a8e:	29 c2                	sub    %eax,%edx
  801a90:	89 d0                	mov    %edx,%eax
  801a92:	c9                   	leaveq 
  801a93:	c3                   	retq   

0000000000801a94 <strncmp>:
  801a94:	55                   	push   %rbp
  801a95:	48 89 e5             	mov    %rsp,%rbp
  801a98:	48 83 ec 18          	sub    $0x18,%rsp
  801a9c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801aa0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801aa4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801aa8:	eb 0f                	jmp    801ab9 <strncmp+0x25>
  801aaa:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801aaf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801ab4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801ab9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801abe:	74 1d                	je     801add <strncmp+0x49>
  801ac0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ac4:	0f b6 00             	movzbl (%rax),%eax
  801ac7:	84 c0                	test   %al,%al
  801ac9:	74 12                	je     801add <strncmp+0x49>
  801acb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801acf:	0f b6 10             	movzbl (%rax),%edx
  801ad2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ad6:	0f b6 00             	movzbl (%rax),%eax
  801ad9:	38 c2                	cmp    %al,%dl
  801adb:	74 cd                	je     801aaa <strncmp+0x16>
  801add:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801ae2:	75 07                	jne    801aeb <strncmp+0x57>
  801ae4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ae9:	eb 18                	jmp    801b03 <strncmp+0x6f>
  801aeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801aef:	0f b6 00             	movzbl (%rax),%eax
  801af2:	0f b6 d0             	movzbl %al,%edx
  801af5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801af9:	0f b6 00             	movzbl (%rax),%eax
  801afc:	0f b6 c0             	movzbl %al,%eax
  801aff:	29 c2                	sub    %eax,%edx
  801b01:	89 d0                	mov    %edx,%eax
  801b03:	c9                   	leaveq 
  801b04:	c3                   	retq   

0000000000801b05 <strchr>:
  801b05:	55                   	push   %rbp
  801b06:	48 89 e5             	mov    %rsp,%rbp
  801b09:	48 83 ec 0c          	sub    $0xc,%rsp
  801b0d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b11:	89 f0                	mov    %esi,%eax
  801b13:	88 45 f4             	mov    %al,-0xc(%rbp)
  801b16:	eb 17                	jmp    801b2f <strchr+0x2a>
  801b18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b1c:	0f b6 00             	movzbl (%rax),%eax
  801b1f:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801b22:	75 06                	jne    801b2a <strchr+0x25>
  801b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b28:	eb 15                	jmp    801b3f <strchr+0x3a>
  801b2a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801b2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b33:	0f b6 00             	movzbl (%rax),%eax
  801b36:	84 c0                	test   %al,%al
  801b38:	75 de                	jne    801b18 <strchr+0x13>
  801b3a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b3f:	c9                   	leaveq 
  801b40:	c3                   	retq   

0000000000801b41 <strfind>:
  801b41:	55                   	push   %rbp
  801b42:	48 89 e5             	mov    %rsp,%rbp
  801b45:	48 83 ec 0c          	sub    $0xc,%rsp
  801b49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b4d:	89 f0                	mov    %esi,%eax
  801b4f:	88 45 f4             	mov    %al,-0xc(%rbp)
  801b52:	eb 13                	jmp    801b67 <strfind+0x26>
  801b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b58:	0f b6 00             	movzbl (%rax),%eax
  801b5b:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801b5e:	75 02                	jne    801b62 <strfind+0x21>
  801b60:	eb 10                	jmp    801b72 <strfind+0x31>
  801b62:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b6b:	0f b6 00             	movzbl (%rax),%eax
  801b6e:	84 c0                	test   %al,%al
  801b70:	75 e2                	jne    801b54 <strfind+0x13>
  801b72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b76:	c9                   	leaveq 
  801b77:	c3                   	retq   

0000000000801b78 <memset>:
  801b78:	55                   	push   %rbp
  801b79:	48 89 e5             	mov    %rsp,%rbp
  801b7c:	48 83 ec 18          	sub    $0x18,%rsp
  801b80:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b84:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b87:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801b8b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801b90:	75 06                	jne    801b98 <memset+0x20>
  801b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b96:	eb 69                	jmp    801c01 <memset+0x89>
  801b98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b9c:	83 e0 03             	and    $0x3,%eax
  801b9f:	48 85 c0             	test   %rax,%rax
  801ba2:	75 48                	jne    801bec <memset+0x74>
  801ba4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ba8:	83 e0 03             	and    $0x3,%eax
  801bab:	48 85 c0             	test   %rax,%rax
  801bae:	75 3c                	jne    801bec <memset+0x74>
  801bb0:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801bb7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801bba:	c1 e0 18             	shl    $0x18,%eax
  801bbd:	89 c2                	mov    %eax,%edx
  801bbf:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801bc2:	c1 e0 10             	shl    $0x10,%eax
  801bc5:	09 c2                	or     %eax,%edx
  801bc7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801bca:	c1 e0 08             	shl    $0x8,%eax
  801bcd:	09 d0                	or     %edx,%eax
  801bcf:	09 45 f4             	or     %eax,-0xc(%rbp)
  801bd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bd6:	48 c1 e8 02          	shr    $0x2,%rax
  801bda:	48 89 c1             	mov    %rax,%rcx
  801bdd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801be1:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801be4:	48 89 d7             	mov    %rdx,%rdi
  801be7:	fc                   	cld    
  801be8:	f3 ab                	rep stos %eax,%es:(%rdi)
  801bea:	eb 11                	jmp    801bfd <memset+0x85>
  801bec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801bf0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801bf3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801bf7:	48 89 d7             	mov    %rdx,%rdi
  801bfa:	fc                   	cld    
  801bfb:	f3 aa                	rep stos %al,%es:(%rdi)
  801bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c01:	c9                   	leaveq 
  801c02:	c3                   	retq   

0000000000801c03 <memmove>:
  801c03:	55                   	push   %rbp
  801c04:	48 89 e5             	mov    %rsp,%rbp
  801c07:	48 83 ec 28          	sub    $0x28,%rsp
  801c0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801c0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801c13:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801c17:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801c1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801c1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c23:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c2b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801c2f:	0f 83 88 00 00 00    	jae    801cbd <memmove+0xba>
  801c35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c39:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801c3d:	48 01 d0             	add    %rdx,%rax
  801c40:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801c44:	76 77                	jbe    801cbd <memmove+0xba>
  801c46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c4a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801c4e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c52:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c5a:	83 e0 03             	and    $0x3,%eax
  801c5d:	48 85 c0             	test   %rax,%rax
  801c60:	75 3b                	jne    801c9d <memmove+0x9a>
  801c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801c66:	83 e0 03             	and    $0x3,%eax
  801c69:	48 85 c0             	test   %rax,%rax
  801c6c:	75 2f                	jne    801c9d <memmove+0x9a>
  801c6e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801c72:	83 e0 03             	and    $0x3,%eax
  801c75:	48 85 c0             	test   %rax,%rax
  801c78:	75 23                	jne    801c9d <memmove+0x9a>
  801c7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801c7e:	48 83 e8 04          	sub    $0x4,%rax
  801c82:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801c86:	48 83 ea 04          	sub    $0x4,%rdx
  801c8a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801c8e:	48 c1 e9 02          	shr    $0x2,%rcx
  801c92:	48 89 c7             	mov    %rax,%rdi
  801c95:	48 89 d6             	mov    %rdx,%rsi
  801c98:	fd                   	std    
  801c99:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801c9b:	eb 1d                	jmp    801cba <memmove+0xb7>
  801c9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ca1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801ca5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801ca9:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801cad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801cb1:	48 89 d7             	mov    %rdx,%rdi
  801cb4:	48 89 c1             	mov    %rax,%rcx
  801cb7:	fd                   	std    
  801cb8:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801cba:	fc                   	cld    
  801cbb:	eb 57                	jmp    801d14 <memmove+0x111>
  801cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cc1:	83 e0 03             	and    $0x3,%eax
  801cc4:	48 85 c0             	test   %rax,%rax
  801cc7:	75 36                	jne    801cff <memmove+0xfc>
  801cc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ccd:	83 e0 03             	and    $0x3,%eax
  801cd0:	48 85 c0             	test   %rax,%rax
  801cd3:	75 2a                	jne    801cff <memmove+0xfc>
  801cd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801cd9:	83 e0 03             	and    $0x3,%eax
  801cdc:	48 85 c0             	test   %rax,%rax
  801cdf:	75 1e                	jne    801cff <memmove+0xfc>
  801ce1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ce5:	48 c1 e8 02          	shr    $0x2,%rax
  801ce9:	48 89 c1             	mov    %rax,%rcx
  801cec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cf0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801cf4:	48 89 c7             	mov    %rax,%rdi
  801cf7:	48 89 d6             	mov    %rdx,%rsi
  801cfa:	fc                   	cld    
  801cfb:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  801cfd:	eb 15                	jmp    801d14 <memmove+0x111>
  801cff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d03:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801d07:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801d0b:	48 89 c7             	mov    %rax,%rdi
  801d0e:	48 89 d6             	mov    %rdx,%rsi
  801d11:	fc                   	cld    
  801d12:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801d14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d18:	c9                   	leaveq 
  801d19:	c3                   	retq   

0000000000801d1a <memcpy>:
  801d1a:	55                   	push   %rbp
  801d1b:	48 89 e5             	mov    %rsp,%rbp
  801d1e:	48 83 ec 18          	sub    $0x18,%rsp
  801d22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801d26:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d2a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801d2e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801d32:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801d36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d3a:	48 89 ce             	mov    %rcx,%rsi
  801d3d:	48 89 c7             	mov    %rax,%rdi
  801d40:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  801d47:	00 00 00 
  801d4a:	ff d0                	callq  *%rax
  801d4c:	c9                   	leaveq 
  801d4d:	c3                   	retq   

0000000000801d4e <memcmp>:
  801d4e:	55                   	push   %rbp
  801d4f:	48 89 e5             	mov    %rsp,%rbp
  801d52:	48 83 ec 28          	sub    $0x28,%rsp
  801d56:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801d5a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801d5e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801d62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801d6a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801d6e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801d72:	eb 36                	jmp    801daa <memcmp+0x5c>
  801d74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d78:	0f b6 10             	movzbl (%rax),%edx
  801d7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d7f:	0f b6 00             	movzbl (%rax),%eax
  801d82:	38 c2                	cmp    %al,%dl
  801d84:	74 1a                	je     801da0 <memcmp+0x52>
  801d86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801d8a:	0f b6 00             	movzbl (%rax),%eax
  801d8d:	0f b6 d0             	movzbl %al,%edx
  801d90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d94:	0f b6 00             	movzbl (%rax),%eax
  801d97:	0f b6 c0             	movzbl %al,%eax
  801d9a:	29 c2                	sub    %eax,%edx
  801d9c:	89 d0                	mov    %edx,%eax
  801d9e:	eb 20                	jmp    801dc0 <memcmp+0x72>
  801da0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801da5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801daa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801dae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801db2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801db6:	48 85 c0             	test   %rax,%rax
  801db9:	75 b9                	jne    801d74 <memcmp+0x26>
  801dbb:	b8 00 00 00 00       	mov    $0x0,%eax
  801dc0:	c9                   	leaveq 
  801dc1:	c3                   	retq   

0000000000801dc2 <memfind>:
  801dc2:	55                   	push   %rbp
  801dc3:	48 89 e5             	mov    %rsp,%rbp
  801dc6:	48 83 ec 28          	sub    $0x28,%rsp
  801dca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801dce:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801dd1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801dd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801dd9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801ddd:	48 01 d0             	add    %rdx,%rax
  801de0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801de4:	eb 15                	jmp    801dfb <memfind+0x39>
  801de6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dea:	0f b6 10             	movzbl (%rax),%edx
  801ded:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801df0:	38 c2                	cmp    %al,%dl
  801df2:	75 02                	jne    801df6 <memfind+0x34>
  801df4:	eb 0f                	jmp    801e05 <memfind+0x43>
  801df6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801dff:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801e03:	72 e1                	jb     801de6 <memfind+0x24>
  801e05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e09:	c9                   	leaveq 
  801e0a:	c3                   	retq   

0000000000801e0b <strtol>:
  801e0b:	55                   	push   %rbp
  801e0c:	48 89 e5             	mov    %rsp,%rbp
  801e0f:	48 83 ec 34          	sub    $0x34,%rsp
  801e13:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801e17:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801e1b:	89 55 cc             	mov    %edx,-0x34(%rbp)
  801e1e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801e25:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  801e2c:	00 
  801e2d:	eb 05                	jmp    801e34 <strtol+0x29>
  801e2f:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801e34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e38:	0f b6 00             	movzbl (%rax),%eax
  801e3b:	3c 20                	cmp    $0x20,%al
  801e3d:	74 f0                	je     801e2f <strtol+0x24>
  801e3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e43:	0f b6 00             	movzbl (%rax),%eax
  801e46:	3c 09                	cmp    $0x9,%al
  801e48:	74 e5                	je     801e2f <strtol+0x24>
  801e4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e4e:	0f b6 00             	movzbl (%rax),%eax
  801e51:	3c 2b                	cmp    $0x2b,%al
  801e53:	75 07                	jne    801e5c <strtol+0x51>
  801e55:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801e5a:	eb 17                	jmp    801e73 <strtol+0x68>
  801e5c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e60:	0f b6 00             	movzbl (%rax),%eax
  801e63:	3c 2d                	cmp    $0x2d,%al
  801e65:	75 0c                	jne    801e73 <strtol+0x68>
  801e67:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801e6c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801e73:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801e77:	74 06                	je     801e7f <strtol+0x74>
  801e79:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801e7d:	75 28                	jne    801ea7 <strtol+0x9c>
  801e7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e83:	0f b6 00             	movzbl (%rax),%eax
  801e86:	3c 30                	cmp    $0x30,%al
  801e88:	75 1d                	jne    801ea7 <strtol+0x9c>
  801e8a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e8e:	48 83 c0 01          	add    $0x1,%rax
  801e92:	0f b6 00             	movzbl (%rax),%eax
  801e95:	3c 78                	cmp    $0x78,%al
  801e97:	75 0e                	jne    801ea7 <strtol+0x9c>
  801e99:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801e9e:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801ea5:	eb 2c                	jmp    801ed3 <strtol+0xc8>
  801ea7:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801eab:	75 19                	jne    801ec6 <strtol+0xbb>
  801ead:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801eb1:	0f b6 00             	movzbl (%rax),%eax
  801eb4:	3c 30                	cmp    $0x30,%al
  801eb6:	75 0e                	jne    801ec6 <strtol+0xbb>
  801eb8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801ebd:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801ec4:	eb 0d                	jmp    801ed3 <strtol+0xc8>
  801ec6:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801eca:	75 07                	jne    801ed3 <strtol+0xc8>
  801ecc:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801ed3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ed7:	0f b6 00             	movzbl (%rax),%eax
  801eda:	3c 2f                	cmp    $0x2f,%al
  801edc:	7e 1d                	jle    801efb <strtol+0xf0>
  801ede:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ee2:	0f b6 00             	movzbl (%rax),%eax
  801ee5:	3c 39                	cmp    $0x39,%al
  801ee7:	7f 12                	jg     801efb <strtol+0xf0>
  801ee9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801eed:	0f b6 00             	movzbl (%rax),%eax
  801ef0:	0f be c0             	movsbl %al,%eax
  801ef3:	83 e8 30             	sub    $0x30,%eax
  801ef6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801ef9:	eb 4e                	jmp    801f49 <strtol+0x13e>
  801efb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801eff:	0f b6 00             	movzbl (%rax),%eax
  801f02:	3c 60                	cmp    $0x60,%al
  801f04:	7e 1d                	jle    801f23 <strtol+0x118>
  801f06:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f0a:	0f b6 00             	movzbl (%rax),%eax
  801f0d:	3c 7a                	cmp    $0x7a,%al
  801f0f:	7f 12                	jg     801f23 <strtol+0x118>
  801f11:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f15:	0f b6 00             	movzbl (%rax),%eax
  801f18:	0f be c0             	movsbl %al,%eax
  801f1b:	83 e8 57             	sub    $0x57,%eax
  801f1e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f21:	eb 26                	jmp    801f49 <strtol+0x13e>
  801f23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f27:	0f b6 00             	movzbl (%rax),%eax
  801f2a:	3c 40                	cmp    $0x40,%al
  801f2c:	7e 48                	jle    801f76 <strtol+0x16b>
  801f2e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f32:	0f b6 00             	movzbl (%rax),%eax
  801f35:	3c 5a                	cmp    $0x5a,%al
  801f37:	7f 3d                	jg     801f76 <strtol+0x16b>
  801f39:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f3d:	0f b6 00             	movzbl (%rax),%eax
  801f40:	0f be c0             	movsbl %al,%eax
  801f43:	83 e8 37             	sub    $0x37,%eax
  801f46:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f4c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801f4f:	7c 02                	jl     801f53 <strtol+0x148>
  801f51:	eb 23                	jmp    801f76 <strtol+0x16b>
  801f53:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801f58:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801f5b:	48 98                	cltq   
  801f5d:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801f62:	48 89 c2             	mov    %rax,%rdx
  801f65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801f68:	48 98                	cltq   
  801f6a:	48 01 d0             	add    %rdx,%rax
  801f6d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801f71:	e9 5d ff ff ff       	jmpq   801ed3 <strtol+0xc8>
  801f76:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801f7b:	74 0b                	je     801f88 <strtol+0x17d>
  801f7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801f81:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801f85:	48 89 10             	mov    %rdx,(%rax)
  801f88:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801f8c:	74 09                	je     801f97 <strtol+0x18c>
  801f8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f92:	48 f7 d8             	neg    %rax
  801f95:	eb 04                	jmp    801f9b <strtol+0x190>
  801f97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801f9b:	c9                   	leaveq 
  801f9c:	c3                   	retq   

0000000000801f9d <strstr>:
  801f9d:	55                   	push   %rbp
  801f9e:	48 89 e5             	mov    %rsp,%rbp
  801fa1:	48 83 ec 30          	sub    $0x30,%rsp
  801fa5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801fa9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801fad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801fb1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801fb5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801fb9:	0f b6 00             	movzbl (%rax),%eax
  801fbc:	88 45 ff             	mov    %al,-0x1(%rbp)
  801fbf:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801fc3:	75 06                	jne    801fcb <strstr+0x2e>
  801fc5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fc9:	eb 6b                	jmp    802036 <strstr+0x99>
  801fcb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801fcf:	48 89 c7             	mov    %rax,%rdi
  801fd2:	48 b8 73 18 80 00 00 	movabs $0x801873,%rax
  801fd9:	00 00 00 
  801fdc:	ff d0                	callq  *%rax
  801fde:	48 98                	cltq   
  801fe0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801fe4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801fe8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801fec:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801ff0:	0f b6 00             	movzbl (%rax),%eax
  801ff3:	88 45 ef             	mov    %al,-0x11(%rbp)
  801ff6:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801ffa:	75 07                	jne    802003 <strstr+0x66>
  801ffc:	b8 00 00 00 00       	mov    $0x0,%eax
  802001:	eb 33                	jmp    802036 <strstr+0x99>
  802003:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  802007:	3a 45 ff             	cmp    -0x1(%rbp),%al
  80200a:	75 d8                	jne    801fe4 <strstr+0x47>
  80200c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802010:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802014:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802018:	48 89 ce             	mov    %rcx,%rsi
  80201b:	48 89 c7             	mov    %rax,%rdi
  80201e:	48 b8 94 1a 80 00 00 	movabs $0x801a94,%rax
  802025:	00 00 00 
  802028:	ff d0                	callq  *%rax
  80202a:	85 c0                	test   %eax,%eax
  80202c:	75 b6                	jne    801fe4 <strstr+0x47>
  80202e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802032:	48 83 e8 01          	sub    $0x1,%rax
  802036:	c9                   	leaveq 
  802037:	c3                   	retq   

0000000000802038 <syscall>:
  802038:	55                   	push   %rbp
  802039:	48 89 e5             	mov    %rsp,%rbp
  80203c:	53                   	push   %rbx
  80203d:	48 83 ec 48          	sub    $0x48,%rsp
  802041:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802044:	89 75 d8             	mov    %esi,-0x28(%rbp)
  802047:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80204b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  80204f:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  802053:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  802057:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80205a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  80205e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  802062:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  802066:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  80206a:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  80206e:	4c 89 c3             	mov    %r8,%rbx
  802071:	cd 30                	int    $0x30
  802073:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802077:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  80207b:	74 3e                	je     8020bb <syscall+0x83>
  80207d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802082:	7e 37                	jle    8020bb <syscall+0x83>
  802084:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802088:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80208b:	49 89 d0             	mov    %rdx,%r8
  80208e:	89 c1                	mov    %eax,%ecx
  802090:	48 ba 88 5c 80 00 00 	movabs $0x805c88,%rdx
  802097:	00 00 00 
  80209a:	be 24 00 00 00       	mov    $0x24,%esi
  80209f:	48 bf a5 5c 80 00 00 	movabs $0x805ca5,%rdi
  8020a6:	00 00 00 
  8020a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8020ae:	49 b9 f1 0a 80 00 00 	movabs $0x800af1,%r9
  8020b5:	00 00 00 
  8020b8:	41 ff d1             	callq  *%r9
  8020bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020bf:	48 83 c4 48          	add    $0x48,%rsp
  8020c3:	5b                   	pop    %rbx
  8020c4:	5d                   	pop    %rbp
  8020c5:	c3                   	retq   

00000000008020c6 <sys_cputs>:
  8020c6:	55                   	push   %rbp
  8020c7:	48 89 e5             	mov    %rsp,%rbp
  8020ca:	48 83 ec 20          	sub    $0x20,%rsp
  8020ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8020d2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8020d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8020da:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8020de:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8020e5:	00 
  8020e6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8020ec:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8020f2:	48 89 d1             	mov    %rdx,%rcx
  8020f5:	48 89 c2             	mov    %rax,%rdx
  8020f8:	be 00 00 00 00       	mov    $0x0,%esi
  8020fd:	bf 00 00 00 00       	mov    $0x0,%edi
  802102:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802109:	00 00 00 
  80210c:	ff d0                	callq  *%rax
  80210e:	c9                   	leaveq 
  80210f:	c3                   	retq   

0000000000802110 <sys_cgetc>:
  802110:	55                   	push   %rbp
  802111:	48 89 e5             	mov    %rsp,%rbp
  802114:	48 83 ec 10          	sub    $0x10,%rsp
  802118:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80211f:	00 
  802120:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802126:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80212c:	b9 00 00 00 00       	mov    $0x0,%ecx
  802131:	ba 00 00 00 00       	mov    $0x0,%edx
  802136:	be 00 00 00 00       	mov    $0x0,%esi
  80213b:	bf 01 00 00 00       	mov    $0x1,%edi
  802140:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802147:	00 00 00 
  80214a:	ff d0                	callq  *%rax
  80214c:	c9                   	leaveq 
  80214d:	c3                   	retq   

000000000080214e <sys_env_destroy>:
  80214e:	55                   	push   %rbp
  80214f:	48 89 e5             	mov    %rsp,%rbp
  802152:	48 83 ec 10          	sub    $0x10,%rsp
  802156:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802159:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80215c:	48 98                	cltq   
  80215e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802165:	00 
  802166:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80216c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802172:	b9 00 00 00 00       	mov    $0x0,%ecx
  802177:	48 89 c2             	mov    %rax,%rdx
  80217a:	be 01 00 00 00       	mov    $0x1,%esi
  80217f:	bf 03 00 00 00       	mov    $0x3,%edi
  802184:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  80218b:	00 00 00 
  80218e:	ff d0                	callq  *%rax
  802190:	c9                   	leaveq 
  802191:	c3                   	retq   

0000000000802192 <sys_getenvid>:
  802192:	55                   	push   %rbp
  802193:	48 89 e5             	mov    %rsp,%rbp
  802196:	48 83 ec 10          	sub    $0x10,%rsp
  80219a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8021a1:	00 
  8021a2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8021a8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8021ae:	b9 00 00 00 00       	mov    $0x0,%ecx
  8021b3:	ba 00 00 00 00       	mov    $0x0,%edx
  8021b8:	be 00 00 00 00       	mov    $0x0,%esi
  8021bd:	bf 02 00 00 00       	mov    $0x2,%edi
  8021c2:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8021c9:	00 00 00 
  8021cc:	ff d0                	callq  *%rax
  8021ce:	c9                   	leaveq 
  8021cf:	c3                   	retq   

00000000008021d0 <sys_yield>:
  8021d0:	55                   	push   %rbp
  8021d1:	48 89 e5             	mov    %rsp,%rbp
  8021d4:	48 83 ec 10          	sub    $0x10,%rsp
  8021d8:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8021df:	00 
  8021e0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8021e6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8021ec:	b9 00 00 00 00       	mov    $0x0,%ecx
  8021f1:	ba 00 00 00 00       	mov    $0x0,%edx
  8021f6:	be 00 00 00 00       	mov    $0x0,%esi
  8021fb:	bf 0b 00 00 00       	mov    $0xb,%edi
  802200:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802207:	00 00 00 
  80220a:	ff d0                	callq  *%rax
  80220c:	c9                   	leaveq 
  80220d:	c3                   	retq   

000000000080220e <sys_page_alloc>:
  80220e:	55                   	push   %rbp
  80220f:	48 89 e5             	mov    %rsp,%rbp
  802212:	48 83 ec 20          	sub    $0x20,%rsp
  802216:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802219:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80221d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802220:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802223:	48 63 c8             	movslq %eax,%rcx
  802226:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80222a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80222d:	48 98                	cltq   
  80222f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802236:	00 
  802237:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80223d:	49 89 c8             	mov    %rcx,%r8
  802240:	48 89 d1             	mov    %rdx,%rcx
  802243:	48 89 c2             	mov    %rax,%rdx
  802246:	be 01 00 00 00       	mov    $0x1,%esi
  80224b:	bf 04 00 00 00       	mov    $0x4,%edi
  802250:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802257:	00 00 00 
  80225a:	ff d0                	callq  *%rax
  80225c:	c9                   	leaveq 
  80225d:	c3                   	retq   

000000000080225e <sys_page_map>:
  80225e:	55                   	push   %rbp
  80225f:	48 89 e5             	mov    %rsp,%rbp
  802262:	48 83 ec 30          	sub    $0x30,%rsp
  802266:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802269:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80226d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  802270:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  802274:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802278:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80227b:	48 63 c8             	movslq %eax,%rcx
  80227e:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  802282:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802285:	48 63 f0             	movslq %eax,%rsi
  802288:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80228c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80228f:	48 98                	cltq   
  802291:	48 89 0c 24          	mov    %rcx,(%rsp)
  802295:	49 89 f9             	mov    %rdi,%r9
  802298:	49 89 f0             	mov    %rsi,%r8
  80229b:	48 89 d1             	mov    %rdx,%rcx
  80229e:	48 89 c2             	mov    %rax,%rdx
  8022a1:	be 01 00 00 00       	mov    $0x1,%esi
  8022a6:	bf 05 00 00 00       	mov    $0x5,%edi
  8022ab:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8022b2:	00 00 00 
  8022b5:	ff d0                	callq  *%rax
  8022b7:	c9                   	leaveq 
  8022b8:	c3                   	retq   

00000000008022b9 <sys_page_unmap>:
  8022b9:	55                   	push   %rbp
  8022ba:	48 89 e5             	mov    %rsp,%rbp
  8022bd:	48 83 ec 20          	sub    $0x20,%rsp
  8022c1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8022c4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8022c8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8022cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022cf:	48 98                	cltq   
  8022d1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8022d8:	00 
  8022d9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8022df:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8022e5:	48 89 d1             	mov    %rdx,%rcx
  8022e8:	48 89 c2             	mov    %rax,%rdx
  8022eb:	be 01 00 00 00       	mov    $0x1,%esi
  8022f0:	bf 06 00 00 00       	mov    $0x6,%edi
  8022f5:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8022fc:	00 00 00 
  8022ff:	ff d0                	callq  *%rax
  802301:	c9                   	leaveq 
  802302:	c3                   	retq   

0000000000802303 <sys_env_set_status>:
  802303:	55                   	push   %rbp
  802304:	48 89 e5             	mov    %rsp,%rbp
  802307:	48 83 ec 10          	sub    $0x10,%rsp
  80230b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80230e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802311:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802314:	48 63 d0             	movslq %eax,%rdx
  802317:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80231a:	48 98                	cltq   
  80231c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802323:	00 
  802324:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80232a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802330:	48 89 d1             	mov    %rdx,%rcx
  802333:	48 89 c2             	mov    %rax,%rdx
  802336:	be 01 00 00 00       	mov    $0x1,%esi
  80233b:	bf 08 00 00 00       	mov    $0x8,%edi
  802340:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802347:	00 00 00 
  80234a:	ff d0                	callq  *%rax
  80234c:	c9                   	leaveq 
  80234d:	c3                   	retq   

000000000080234e <sys_env_set_trapframe>:
  80234e:	55                   	push   %rbp
  80234f:	48 89 e5             	mov    %rsp,%rbp
  802352:	48 83 ec 20          	sub    $0x20,%rsp
  802356:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802359:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80235d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802361:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802364:	48 98                	cltq   
  802366:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80236d:	00 
  80236e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802374:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80237a:	48 89 d1             	mov    %rdx,%rcx
  80237d:	48 89 c2             	mov    %rax,%rdx
  802380:	be 01 00 00 00       	mov    $0x1,%esi
  802385:	bf 09 00 00 00       	mov    $0x9,%edi
  80238a:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802391:	00 00 00 
  802394:	ff d0                	callq  *%rax
  802396:	c9                   	leaveq 
  802397:	c3                   	retq   

0000000000802398 <sys_env_set_pgfault_upcall>:
  802398:	55                   	push   %rbp
  802399:	48 89 e5             	mov    %rsp,%rbp
  80239c:	48 83 ec 20          	sub    $0x20,%rsp
  8023a0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8023a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8023a7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8023ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8023ae:	48 98                	cltq   
  8023b0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8023b7:	00 
  8023b8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8023be:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8023c4:	48 89 d1             	mov    %rdx,%rcx
  8023c7:	48 89 c2             	mov    %rax,%rdx
  8023ca:	be 01 00 00 00       	mov    $0x1,%esi
  8023cf:	bf 0a 00 00 00       	mov    $0xa,%edi
  8023d4:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8023db:	00 00 00 
  8023de:	ff d0                	callq  *%rax
  8023e0:	c9                   	leaveq 
  8023e1:	c3                   	retq   

00000000008023e2 <sys_ipc_try_send>:
  8023e2:	55                   	push   %rbp
  8023e3:	48 89 e5             	mov    %rsp,%rbp
  8023e6:	48 83 ec 20          	sub    $0x20,%rsp
  8023ea:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8023ed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8023f1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8023f5:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  8023f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8023fb:	48 63 f0             	movslq %eax,%rsi
  8023fe:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802402:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802405:	48 98                	cltq   
  802407:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80240b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802412:	00 
  802413:	49 89 f1             	mov    %rsi,%r9
  802416:	49 89 c8             	mov    %rcx,%r8
  802419:	48 89 d1             	mov    %rdx,%rcx
  80241c:	48 89 c2             	mov    %rax,%rdx
  80241f:	be 00 00 00 00       	mov    $0x0,%esi
  802424:	bf 0c 00 00 00       	mov    $0xc,%edi
  802429:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802430:	00 00 00 
  802433:	ff d0                	callq  *%rax
  802435:	c9                   	leaveq 
  802436:	c3                   	retq   

0000000000802437 <sys_ipc_recv>:
  802437:	55                   	push   %rbp
  802438:	48 89 e5             	mov    %rsp,%rbp
  80243b:	48 83 ec 10          	sub    $0x10,%rsp
  80243f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802447:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80244e:	00 
  80244f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802455:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80245b:	b9 00 00 00 00       	mov    $0x0,%ecx
  802460:	48 89 c2             	mov    %rax,%rdx
  802463:	be 01 00 00 00       	mov    $0x1,%esi
  802468:	bf 0d 00 00 00       	mov    $0xd,%edi
  80246d:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802474:	00 00 00 
  802477:	ff d0                	callq  *%rax
  802479:	c9                   	leaveq 
  80247a:	c3                   	retq   

000000000080247b <sys_time_msec>:
  80247b:	55                   	push   %rbp
  80247c:	48 89 e5             	mov    %rsp,%rbp
  80247f:	48 83 ec 10          	sub    $0x10,%rsp
  802483:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80248a:	00 
  80248b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802491:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802497:	b9 00 00 00 00       	mov    $0x0,%ecx
  80249c:	ba 00 00 00 00       	mov    $0x0,%edx
  8024a1:	be 00 00 00 00       	mov    $0x0,%esi
  8024a6:	bf 0e 00 00 00       	mov    $0xe,%edi
  8024ab:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8024b2:	00 00 00 
  8024b5:	ff d0                	callq  *%rax
  8024b7:	c9                   	leaveq 
  8024b8:	c3                   	retq   

00000000008024b9 <sys_net_transmit>:
  8024b9:	55                   	push   %rbp
  8024ba:	48 89 e5             	mov    %rsp,%rbp
  8024bd:	48 83 ec 20          	sub    $0x20,%rsp
  8024c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8024c5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8024c8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8024cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024cf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8024d6:	00 
  8024d7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8024dd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8024e3:	48 89 d1             	mov    %rdx,%rcx
  8024e6:	48 89 c2             	mov    %rax,%rdx
  8024e9:	be 00 00 00 00       	mov    $0x0,%esi
  8024ee:	bf 0f 00 00 00       	mov    $0xf,%edi
  8024f3:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8024fa:	00 00 00 
  8024fd:	ff d0                	callq  *%rax
  8024ff:	c9                   	leaveq 
  802500:	c3                   	retq   

0000000000802501 <sys_net_receive>:
  802501:	55                   	push   %rbp
  802502:	48 89 e5             	mov    %rsp,%rbp
  802505:	48 83 ec 20          	sub    $0x20,%rsp
  802509:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80250d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802510:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802513:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802517:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80251e:	00 
  80251f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802525:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80252b:	48 89 d1             	mov    %rdx,%rcx
  80252e:	48 89 c2             	mov    %rax,%rdx
  802531:	be 00 00 00 00       	mov    $0x0,%esi
  802536:	bf 10 00 00 00       	mov    $0x10,%edi
  80253b:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  802542:	00 00 00 
  802545:	ff d0                	callq  *%rax
  802547:	c9                   	leaveq 
  802548:	c3                   	retq   

0000000000802549 <sys_ept_map>:
  802549:	55                   	push   %rbp
  80254a:	48 89 e5             	mov    %rsp,%rbp
  80254d:	48 83 ec 30          	sub    $0x30,%rsp
  802551:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802554:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802558:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80255b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80255f:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  802563:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  802566:	48 63 c8             	movslq %eax,%rcx
  802569:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  80256d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802570:	48 63 f0             	movslq %eax,%rsi
  802573:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802577:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80257a:	48 98                	cltq   
  80257c:	48 89 0c 24          	mov    %rcx,(%rsp)
  802580:	49 89 f9             	mov    %rdi,%r9
  802583:	49 89 f0             	mov    %rsi,%r8
  802586:	48 89 d1             	mov    %rdx,%rcx
  802589:	48 89 c2             	mov    %rax,%rdx
  80258c:	be 00 00 00 00       	mov    $0x0,%esi
  802591:	bf 11 00 00 00       	mov    $0x11,%edi
  802596:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  80259d:	00 00 00 
  8025a0:	ff d0                	callq  *%rax
  8025a2:	c9                   	leaveq 
  8025a3:	c3                   	retq   

00000000008025a4 <sys_env_mkguest>:
  8025a4:	55                   	push   %rbp
  8025a5:	48 89 e5             	mov    %rsp,%rbp
  8025a8:	48 83 ec 20          	sub    $0x20,%rsp
  8025ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8025b0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8025b4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8025b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8025bc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8025c3:	00 
  8025c4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8025ca:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8025d0:	48 89 d1             	mov    %rdx,%rcx
  8025d3:	48 89 c2             	mov    %rax,%rdx
  8025d6:	be 00 00 00 00       	mov    $0x0,%esi
  8025db:	bf 12 00 00 00       	mov    $0x12,%edi
  8025e0:	48 b8 38 20 80 00 00 	movabs $0x802038,%rax
  8025e7:	00 00 00 
  8025ea:	ff d0                	callq  *%rax
  8025ec:	c9                   	leaveq 
  8025ed:	c3                   	retq   

00000000008025ee <pgfault>:
  8025ee:	55                   	push   %rbp
  8025ef:	48 89 e5             	mov    %rsp,%rbp
  8025f2:	48 83 ec 30          	sub    $0x30,%rsp
  8025f6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8025fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8025fe:	48 8b 00             	mov    (%rax),%rax
  802601:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802605:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802609:	48 8b 40 08          	mov    0x8(%rax),%rax
  80260d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802610:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802613:	83 e0 02             	and    $0x2,%eax
  802616:	85 c0                	test   %eax,%eax
  802618:	75 40                	jne    80265a <pgfault+0x6c>
  80261a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80261e:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  802625:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802629:	49 89 d0             	mov    %rdx,%r8
  80262c:	48 89 c1             	mov    %rax,%rcx
  80262f:	48 ba b8 5c 80 00 00 	movabs $0x805cb8,%rdx
  802636:	00 00 00 
  802639:	be 1f 00 00 00       	mov    $0x1f,%esi
  80263e:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802645:	00 00 00 
  802648:	b8 00 00 00 00       	mov    $0x0,%eax
  80264d:	49 b9 f1 0a 80 00 00 	movabs $0x800af1,%r9
  802654:	00 00 00 
  802657:	41 ff d1             	callq  *%r9
  80265a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80265e:	48 c1 e8 0c          	shr    $0xc,%rax
  802662:	48 89 c2             	mov    %rax,%rdx
  802665:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80266c:	01 00 00 
  80266f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802673:	25 07 08 00 00       	and    $0x807,%eax
  802678:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  80267e:	74 4e                	je     8026ce <pgfault+0xe0>
  802680:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802684:	48 c1 e8 0c          	shr    $0xc,%rax
  802688:	48 89 c2             	mov    %rax,%rdx
  80268b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802692:	01 00 00 
  802695:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802699:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80269d:	49 89 d0             	mov    %rdx,%r8
  8026a0:	48 89 c1             	mov    %rax,%rcx
  8026a3:	48 ba e0 5c 80 00 00 	movabs $0x805ce0,%rdx
  8026aa:	00 00 00 
  8026ad:	be 22 00 00 00       	mov    $0x22,%esi
  8026b2:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  8026b9:	00 00 00 
  8026bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8026c1:	49 b9 f1 0a 80 00 00 	movabs $0x800af1,%r9
  8026c8:	00 00 00 
  8026cb:	41 ff d1             	callq  *%r9
  8026ce:	ba 07 00 00 00       	mov    $0x7,%edx
  8026d3:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8026d8:	bf 00 00 00 00       	mov    $0x0,%edi
  8026dd:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  8026e4:	00 00 00 
  8026e7:	ff d0                	callq  *%rax
  8026e9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8026ec:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8026f0:	79 30                	jns    802722 <pgfault+0x134>
  8026f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8026f5:	89 c1                	mov    %eax,%ecx
  8026f7:	48 ba 0b 5d 80 00 00 	movabs $0x805d0b,%rdx
  8026fe:	00 00 00 
  802701:	be 30 00 00 00       	mov    $0x30,%esi
  802706:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  80270d:	00 00 00 
  802710:	b8 00 00 00 00       	mov    $0x0,%eax
  802715:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  80271c:	00 00 00 
  80271f:	41 ff d0             	callq  *%r8
  802722:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802726:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80272a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80272e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802734:	ba 00 10 00 00       	mov    $0x1000,%edx
  802739:	48 89 c6             	mov    %rax,%rsi
  80273c:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  802741:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  802748:	00 00 00 
  80274b:	ff d0                	callq  *%rax
  80274d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802751:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802755:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802759:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  80275f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  802765:	48 89 c1             	mov    %rax,%rcx
  802768:	ba 00 00 00 00       	mov    $0x0,%edx
  80276d:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802772:	bf 00 00 00 00       	mov    $0x0,%edi
  802777:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  80277e:	00 00 00 
  802781:	ff d0                	callq  *%rax
  802783:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802786:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80278a:	79 30                	jns    8027bc <pgfault+0x1ce>
  80278c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80278f:	89 c1                	mov    %eax,%ecx
  802791:	48 ba 1e 5d 80 00 00 	movabs $0x805d1e,%rdx
  802798:	00 00 00 
  80279b:	be 35 00 00 00       	mov    $0x35,%esi
  8027a0:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  8027a7:	00 00 00 
  8027aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8027af:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8027b6:	00 00 00 
  8027b9:	41 ff d0             	callq  *%r8
  8027bc:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8027c1:	bf 00 00 00 00       	mov    $0x0,%edi
  8027c6:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  8027cd:	00 00 00 
  8027d0:	ff d0                	callq  *%rax
  8027d2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8027d5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8027d9:	79 30                	jns    80280b <pgfault+0x21d>
  8027db:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8027de:	89 c1                	mov    %eax,%ecx
  8027e0:	48 ba 2f 5d 80 00 00 	movabs $0x805d2f,%rdx
  8027e7:	00 00 00 
  8027ea:	be 39 00 00 00       	mov    $0x39,%esi
  8027ef:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  8027f6:	00 00 00 
  8027f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8027fe:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802805:	00 00 00 
  802808:	41 ff d0             	callq  *%r8
  80280b:	c9                   	leaveq 
  80280c:	c3                   	retq   

000000000080280d <duppage>:
  80280d:	55                   	push   %rbp
  80280e:	48 89 e5             	mov    %rsp,%rbp
  802811:	48 83 ec 30          	sub    $0x30,%rsp
  802815:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802818:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80281b:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80281e:	c1 e0 0c             	shl    $0xc,%eax
  802821:	89 c0                	mov    %eax,%eax
  802823:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802827:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80282e:	01 00 00 
  802831:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802834:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802838:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80283c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802840:	25 02 08 00 00       	and    $0x802,%eax
  802845:	48 85 c0             	test   %rax,%rax
  802848:	74 0e                	je     802858 <duppage+0x4b>
  80284a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80284e:	25 00 04 00 00       	and    $0x400,%eax
  802853:	48 85 c0             	test   %rax,%rax
  802856:	74 70                	je     8028c8 <duppage+0xbb>
  802858:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80285c:	25 07 0e 00 00       	and    $0xe07,%eax
  802861:	89 c6                	mov    %eax,%esi
  802863:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802867:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80286a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80286e:	41 89 f0             	mov    %esi,%r8d
  802871:	48 89 c6             	mov    %rax,%rsi
  802874:	bf 00 00 00 00       	mov    $0x0,%edi
  802879:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  802880:	00 00 00 
  802883:	ff d0                	callq  *%rax
  802885:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802888:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80288c:	79 30                	jns    8028be <duppage+0xb1>
  80288e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802891:	89 c1                	mov    %eax,%ecx
  802893:	48 ba 1e 5d 80 00 00 	movabs $0x805d1e,%rdx
  80289a:	00 00 00 
  80289d:	be 63 00 00 00       	mov    $0x63,%esi
  8028a2:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  8028a9:	00 00 00 
  8028ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8028b1:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8028b8:	00 00 00 
  8028bb:	41 ff d0             	callq  *%r8
  8028be:	b8 00 00 00 00       	mov    $0x0,%eax
  8028c3:	e9 c4 00 00 00       	jmpq   80298c <duppage+0x17f>
  8028c8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8028cc:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8028cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8028d3:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  8028d9:	48 89 c6             	mov    %rax,%rsi
  8028dc:	bf 00 00 00 00       	mov    $0x0,%edi
  8028e1:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  8028e8:	00 00 00 
  8028eb:	ff d0                	callq  *%rax
  8028ed:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8028f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8028f4:	79 30                	jns    802926 <duppage+0x119>
  8028f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8028f9:	89 c1                	mov    %eax,%ecx
  8028fb:	48 ba 1e 5d 80 00 00 	movabs $0x805d1e,%rdx
  802902:	00 00 00 
  802905:	be 7e 00 00 00       	mov    $0x7e,%esi
  80290a:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802911:	00 00 00 
  802914:	b8 00 00 00 00       	mov    $0x0,%eax
  802919:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802920:	00 00 00 
  802923:	41 ff d0             	callq  *%r8
  802926:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80292a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80292e:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802934:	48 89 d1             	mov    %rdx,%rcx
  802937:	ba 00 00 00 00       	mov    $0x0,%edx
  80293c:	48 89 c6             	mov    %rax,%rsi
  80293f:	bf 00 00 00 00       	mov    $0x0,%edi
  802944:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  80294b:	00 00 00 
  80294e:	ff d0                	callq  *%rax
  802950:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802953:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802957:	79 30                	jns    802989 <duppage+0x17c>
  802959:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80295c:	89 c1                	mov    %eax,%ecx
  80295e:	48 ba 1e 5d 80 00 00 	movabs $0x805d1e,%rdx
  802965:	00 00 00 
  802968:	be 80 00 00 00       	mov    $0x80,%esi
  80296d:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802974:	00 00 00 
  802977:	b8 00 00 00 00       	mov    $0x0,%eax
  80297c:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802983:	00 00 00 
  802986:	41 ff d0             	callq  *%r8
  802989:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80298c:	c9                   	leaveq 
  80298d:	c3                   	retq   

000000000080298e <fork>:
  80298e:	55                   	push   %rbp
  80298f:	48 89 e5             	mov    %rsp,%rbp
  802992:	48 83 ec 20          	sub    $0x20,%rsp
  802996:	48 bf ee 25 80 00 00 	movabs $0x8025ee,%rdi
  80299d:	00 00 00 
  8029a0:	48 b8 f4 4e 80 00 00 	movabs $0x804ef4,%rax
  8029a7:	00 00 00 
  8029aa:	ff d0                	callq  *%rax
  8029ac:	b8 07 00 00 00       	mov    $0x7,%eax
  8029b1:	cd 30                	int    $0x30
  8029b3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8029b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8029b9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8029bc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8029c0:	79 08                	jns    8029ca <fork+0x3c>
  8029c2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8029c5:	e9 09 02 00 00       	jmpq   802bd3 <fork+0x245>
  8029ca:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8029ce:	75 3e                	jne    802a0e <fork+0x80>
  8029d0:	48 b8 92 21 80 00 00 	movabs $0x802192,%rax
  8029d7:	00 00 00 
  8029da:	ff d0                	callq  *%rax
  8029dc:	25 ff 03 00 00       	and    $0x3ff,%eax
  8029e1:	48 98                	cltq   
  8029e3:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8029ea:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8029f1:	00 00 00 
  8029f4:	48 01 c2             	add    %rax,%rdx
  8029f7:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  8029fe:	00 00 00 
  802a01:	48 89 10             	mov    %rdx,(%rax)
  802a04:	b8 00 00 00 00       	mov    $0x0,%eax
  802a09:	e9 c5 01 00 00       	jmpq   802bd3 <fork+0x245>
  802a0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802a15:	e9 a4 00 00 00       	jmpq   802abe <fork+0x130>
  802a1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a1d:	c1 f8 12             	sar    $0x12,%eax
  802a20:	89 c2                	mov    %eax,%edx
  802a22:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  802a29:	01 00 00 
  802a2c:	48 63 d2             	movslq %edx,%rdx
  802a2f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a33:	83 e0 01             	and    $0x1,%eax
  802a36:	48 85 c0             	test   %rax,%rax
  802a39:	74 21                	je     802a5c <fork+0xce>
  802a3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a3e:	c1 f8 09             	sar    $0x9,%eax
  802a41:	89 c2                	mov    %eax,%edx
  802a43:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802a4a:	01 00 00 
  802a4d:	48 63 d2             	movslq %edx,%rdx
  802a50:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a54:	83 e0 01             	and    $0x1,%eax
  802a57:	48 85 c0             	test   %rax,%rax
  802a5a:	75 09                	jne    802a65 <fork+0xd7>
  802a5c:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  802a63:	eb 59                	jmp    802abe <fork+0x130>
  802a65:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802a68:	05 00 02 00 00       	add    $0x200,%eax
  802a6d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802a70:	eb 44                	jmp    802ab6 <fork+0x128>
  802a72:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a79:	01 00 00 
  802a7c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802a7f:	48 63 d2             	movslq %edx,%rdx
  802a82:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a86:	83 e0 05             	and    $0x5,%eax
  802a89:	48 83 f8 05          	cmp    $0x5,%rax
  802a8d:	74 02                	je     802a91 <fork+0x103>
  802a8f:	eb 21                	jmp    802ab2 <fork+0x124>
  802a91:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  802a98:	75 02                	jne    802a9c <fork+0x10e>
  802a9a:	eb 16                	jmp    802ab2 <fork+0x124>
  802a9c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802a9f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802aa2:	89 d6                	mov    %edx,%esi
  802aa4:	89 c7                	mov    %eax,%edi
  802aa6:	48 b8 0d 28 80 00 00 	movabs $0x80280d,%rax
  802aad:	00 00 00 
  802ab0:	ff d0                	callq  *%rax
  802ab2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802ab6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ab9:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  802abc:	7c b4                	jl     802a72 <fork+0xe4>
  802abe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ac1:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  802ac6:	0f 86 4e ff ff ff    	jbe    802a1a <fork+0x8c>
  802acc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802acf:	ba 07 00 00 00       	mov    $0x7,%edx
  802ad4:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  802ad9:	89 c7                	mov    %eax,%edi
  802adb:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  802ae2:	00 00 00 
  802ae5:	ff d0                	callq  *%rax
  802ae7:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802aea:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802aee:	79 30                	jns    802b20 <fork+0x192>
  802af0:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802af3:	89 c1                	mov    %eax,%ecx
  802af5:	48 ba 48 5d 80 00 00 	movabs $0x805d48,%rdx
  802afc:	00 00 00 
  802aff:	be bc 00 00 00       	mov    $0xbc,%esi
  802b04:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802b0b:	00 00 00 
  802b0e:	b8 00 00 00 00       	mov    $0x0,%eax
  802b13:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802b1a:	00 00 00 
  802b1d:	41 ff d0             	callq  *%r8
  802b20:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  802b27:	00 00 00 
  802b2a:	48 8b 00             	mov    (%rax),%rax
  802b2d:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  802b34:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b37:	48 89 d6             	mov    %rdx,%rsi
  802b3a:	89 c7                	mov    %eax,%edi
  802b3c:	48 b8 98 23 80 00 00 	movabs $0x802398,%rax
  802b43:	00 00 00 
  802b46:	ff d0                	callq  *%rax
  802b48:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802b4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802b4f:	79 30                	jns    802b81 <fork+0x1f3>
  802b51:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802b54:	89 c1                	mov    %eax,%ecx
  802b56:	48 ba 68 5d 80 00 00 	movabs $0x805d68,%rdx
  802b5d:	00 00 00 
  802b60:	be c0 00 00 00       	mov    $0xc0,%esi
  802b65:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802b6c:	00 00 00 
  802b6f:	b8 00 00 00 00       	mov    $0x0,%eax
  802b74:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802b7b:	00 00 00 
  802b7e:	41 ff d0             	callq  *%r8
  802b81:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b84:	be 02 00 00 00       	mov    $0x2,%esi
  802b89:	89 c7                	mov    %eax,%edi
  802b8b:	48 b8 03 23 80 00 00 	movabs $0x802303,%rax
  802b92:	00 00 00 
  802b95:	ff d0                	callq  *%rax
  802b97:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802b9a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802b9e:	79 30                	jns    802bd0 <fork+0x242>
  802ba0:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802ba3:	89 c1                	mov    %eax,%ecx
  802ba5:	48 ba 87 5d 80 00 00 	movabs $0x805d87,%rdx
  802bac:	00 00 00 
  802baf:	be c5 00 00 00       	mov    $0xc5,%esi
  802bb4:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802bbb:	00 00 00 
  802bbe:	b8 00 00 00 00       	mov    $0x0,%eax
  802bc3:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802bca:	00 00 00 
  802bcd:	41 ff d0             	callq  *%r8
  802bd0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bd3:	c9                   	leaveq 
  802bd4:	c3                   	retq   

0000000000802bd5 <sfork>:
  802bd5:	55                   	push   %rbp
  802bd6:	48 89 e5             	mov    %rsp,%rbp
  802bd9:	48 ba 9e 5d 80 00 00 	movabs $0x805d9e,%rdx
  802be0:	00 00 00 
  802be3:	be d2 00 00 00       	mov    $0xd2,%esi
  802be8:	48 bf d1 5c 80 00 00 	movabs $0x805cd1,%rdi
  802bef:	00 00 00 
  802bf2:	b8 00 00 00 00       	mov    $0x0,%eax
  802bf7:	48 b9 f1 0a 80 00 00 	movabs $0x800af1,%rcx
  802bfe:	00 00 00 
  802c01:	ff d1                	callq  *%rcx

0000000000802c03 <ipc_recv>:
  802c03:	55                   	push   %rbp
  802c04:	48 89 e5             	mov    %rsp,%rbp
  802c07:	48 83 ec 30          	sub    $0x30,%rsp
  802c0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802c13:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802c17:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802c1c:	75 0e                	jne    802c2c <ipc_recv+0x29>
  802c1e:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802c25:	00 00 00 
  802c28:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802c2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c30:	48 89 c7             	mov    %rax,%rdi
  802c33:	48 b8 37 24 80 00 00 	movabs $0x802437,%rax
  802c3a:	00 00 00 
  802c3d:	ff d0                	callq  *%rax
  802c3f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802c42:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802c46:	79 27                	jns    802c6f <ipc_recv+0x6c>
  802c48:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802c4d:	74 0a                	je     802c59 <ipc_recv+0x56>
  802c4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c53:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802c59:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802c5e:	74 0a                	je     802c6a <ipc_recv+0x67>
  802c60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802c64:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802c6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c6d:	eb 53                	jmp    802cc2 <ipc_recv+0xbf>
  802c6f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  802c74:	74 19                	je     802c8f <ipc_recv+0x8c>
  802c76:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  802c7d:	00 00 00 
  802c80:	48 8b 00             	mov    (%rax),%rax
  802c83:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  802c89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c8d:	89 10                	mov    %edx,(%rax)
  802c8f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802c94:	74 19                	je     802caf <ipc_recv+0xac>
  802c96:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  802c9d:	00 00 00 
  802ca0:	48 8b 00             	mov    (%rax),%rax
  802ca3:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  802ca9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802cad:	89 10                	mov    %edx,(%rax)
  802caf:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  802cb6:	00 00 00 
  802cb9:	48 8b 00             	mov    (%rax),%rax
  802cbc:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  802cc2:	c9                   	leaveq 
  802cc3:	c3                   	retq   

0000000000802cc4 <ipc_send>:
  802cc4:	55                   	push   %rbp
  802cc5:	48 89 e5             	mov    %rsp,%rbp
  802cc8:	48 83 ec 30          	sub    $0x30,%rsp
  802ccc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802ccf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802cd2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802cd6:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  802cd9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802cde:	75 10                	jne    802cf0 <ipc_send+0x2c>
  802ce0:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802ce7:	00 00 00 
  802cea:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802cee:	eb 0e                	jmp    802cfe <ipc_send+0x3a>
  802cf0:	eb 0c                	jmp    802cfe <ipc_send+0x3a>
  802cf2:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  802cf9:	00 00 00 
  802cfc:	ff d0                	callq  *%rax
  802cfe:	8b 75 e8             	mov    -0x18(%rbp),%esi
  802d01:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  802d04:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802d08:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d0b:	89 c7                	mov    %eax,%edi
  802d0d:	48 b8 e2 23 80 00 00 	movabs $0x8023e2,%rax
  802d14:	00 00 00 
  802d17:	ff d0                	callq  *%rax
  802d19:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d1c:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  802d20:	74 d0                	je     802cf2 <ipc_send+0x2e>
  802d22:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d26:	79 30                	jns    802d58 <ipc_send+0x94>
  802d28:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d2b:	89 c1                	mov    %eax,%ecx
  802d2d:	48 ba b8 5d 80 00 00 	movabs $0x805db8,%rdx
  802d34:	00 00 00 
  802d37:	be 44 00 00 00       	mov    $0x44,%esi
  802d3c:	48 bf ce 5d 80 00 00 	movabs $0x805dce,%rdi
  802d43:	00 00 00 
  802d46:	b8 00 00 00 00       	mov    $0x0,%eax
  802d4b:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  802d52:	00 00 00 
  802d55:	41 ff d0             	callq  *%r8
  802d58:	c9                   	leaveq 
  802d59:	c3                   	retq   

0000000000802d5a <ipc_host_recv>:
  802d5a:	55                   	push   %rbp
  802d5b:	48 89 e5             	mov    %rsp,%rbp
  802d5e:	48 83 ec 10          	sub    $0x10,%rsp
  802d62:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802d66:	48 ba e0 5d 80 00 00 	movabs $0x805de0,%rdx
  802d6d:	00 00 00 
  802d70:	be 4e 00 00 00       	mov    $0x4e,%esi
  802d75:	48 bf ce 5d 80 00 00 	movabs $0x805dce,%rdi
  802d7c:	00 00 00 
  802d7f:	b8 00 00 00 00       	mov    $0x0,%eax
  802d84:	48 b9 f1 0a 80 00 00 	movabs $0x800af1,%rcx
  802d8b:	00 00 00 
  802d8e:	ff d1                	callq  *%rcx

0000000000802d90 <ipc_host_send>:
  802d90:	55                   	push   %rbp
  802d91:	48 89 e5             	mov    %rsp,%rbp
  802d94:	48 83 ec 20          	sub    $0x20,%rsp
  802d98:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802d9b:	89 75 f8             	mov    %esi,-0x8(%rbp)
  802d9e:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  802da2:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  802da5:	48 ba 00 5e 80 00 00 	movabs $0x805e00,%rdx
  802dac:	00 00 00 
  802daf:	be 67 00 00 00       	mov    $0x67,%esi
  802db4:	48 bf ce 5d 80 00 00 	movabs $0x805dce,%rdi
  802dbb:	00 00 00 
  802dbe:	b8 00 00 00 00       	mov    $0x0,%eax
  802dc3:	48 b9 f1 0a 80 00 00 	movabs $0x800af1,%rcx
  802dca:	00 00 00 
  802dcd:	ff d1                	callq  *%rcx

0000000000802dcf <ipc_find_env>:
  802dcf:	55                   	push   %rbp
  802dd0:	48 89 e5             	mov    %rsp,%rbp
  802dd3:	48 83 ec 14          	sub    $0x14,%rsp
  802dd7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802dda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802de1:	eb 4e                	jmp    802e31 <ipc_find_env+0x62>
  802de3:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802dea:	00 00 00 
  802ded:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802df0:	48 98                	cltq   
  802df2:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802df9:	48 01 d0             	add    %rdx,%rax
  802dfc:	48 05 d0 00 00 00    	add    $0xd0,%rax
  802e02:	8b 00                	mov    (%rax),%eax
  802e04:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802e07:	75 24                	jne    802e2d <ipc_find_env+0x5e>
  802e09:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802e10:	00 00 00 
  802e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e16:	48 98                	cltq   
  802e18:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802e1f:	48 01 d0             	add    %rdx,%rax
  802e22:	48 05 c0 00 00 00    	add    $0xc0,%rax
  802e28:	8b 40 08             	mov    0x8(%rax),%eax
  802e2b:	eb 12                	jmp    802e3f <ipc_find_env+0x70>
  802e2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802e31:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  802e38:	7e a9                	jle    802de3 <ipc_find_env+0x14>
  802e3a:	b8 00 00 00 00       	mov    $0x0,%eax
  802e3f:	c9                   	leaveq 
  802e40:	c3                   	retq   

0000000000802e41 <fd2num>:
  802e41:	55                   	push   %rbp
  802e42:	48 89 e5             	mov    %rsp,%rbp
  802e45:	48 83 ec 08          	sub    $0x8,%rsp
  802e49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e4d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802e51:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  802e58:	ff ff ff 
  802e5b:	48 01 d0             	add    %rdx,%rax
  802e5e:	48 c1 e8 0c          	shr    $0xc,%rax
  802e62:	c9                   	leaveq 
  802e63:	c3                   	retq   

0000000000802e64 <fd2data>:
  802e64:	55                   	push   %rbp
  802e65:	48 89 e5             	mov    %rsp,%rbp
  802e68:	48 83 ec 08          	sub    $0x8,%rsp
  802e6c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802e74:	48 89 c7             	mov    %rax,%rdi
  802e77:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  802e7e:	00 00 00 
  802e81:	ff d0                	callq  *%rax
  802e83:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  802e89:	48 c1 e0 0c          	shl    $0xc,%rax
  802e8d:	c9                   	leaveq 
  802e8e:	c3                   	retq   

0000000000802e8f <fd_alloc>:
  802e8f:	55                   	push   %rbp
  802e90:	48 89 e5             	mov    %rsp,%rbp
  802e93:	48 83 ec 18          	sub    $0x18,%rsp
  802e97:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802e9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802ea2:	eb 6b                	jmp    802f0f <fd_alloc+0x80>
  802ea4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ea7:	48 98                	cltq   
  802ea9:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802eaf:	48 c1 e0 0c          	shl    $0xc,%rax
  802eb3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ebb:	48 c1 e8 15          	shr    $0x15,%rax
  802ebf:	48 89 c2             	mov    %rax,%rdx
  802ec2:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802ec9:	01 00 00 
  802ecc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802ed0:	83 e0 01             	and    $0x1,%eax
  802ed3:	48 85 c0             	test   %rax,%rax
  802ed6:	74 21                	je     802ef9 <fd_alloc+0x6a>
  802ed8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802edc:	48 c1 e8 0c          	shr    $0xc,%rax
  802ee0:	48 89 c2             	mov    %rax,%rdx
  802ee3:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802eea:	01 00 00 
  802eed:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802ef1:	83 e0 01             	and    $0x1,%eax
  802ef4:	48 85 c0             	test   %rax,%rax
  802ef7:	75 12                	jne    802f0b <fd_alloc+0x7c>
  802ef9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802efd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802f01:	48 89 10             	mov    %rdx,(%rax)
  802f04:	b8 00 00 00 00       	mov    $0x0,%eax
  802f09:	eb 1a                	jmp    802f25 <fd_alloc+0x96>
  802f0b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802f0f:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802f13:	7e 8f                	jle    802ea4 <fd_alloc+0x15>
  802f15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f19:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802f20:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802f25:	c9                   	leaveq 
  802f26:	c3                   	retq   

0000000000802f27 <fd_lookup>:
  802f27:	55                   	push   %rbp
  802f28:	48 89 e5             	mov    %rsp,%rbp
  802f2b:	48 83 ec 20          	sub    $0x20,%rsp
  802f2f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f32:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f36:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802f3a:	78 06                	js     802f42 <fd_lookup+0x1b>
  802f3c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802f40:	7e 07                	jle    802f49 <fd_lookup+0x22>
  802f42:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802f47:	eb 6c                	jmp    802fb5 <fd_lookup+0x8e>
  802f49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f4c:	48 98                	cltq   
  802f4e:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802f54:	48 c1 e0 0c          	shl    $0xc,%rax
  802f58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802f5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f60:	48 c1 e8 15          	shr    $0x15,%rax
  802f64:	48 89 c2             	mov    %rax,%rdx
  802f67:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802f6e:	01 00 00 
  802f71:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802f75:	83 e0 01             	and    $0x1,%eax
  802f78:	48 85 c0             	test   %rax,%rax
  802f7b:	74 21                	je     802f9e <fd_lookup+0x77>
  802f7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802f81:	48 c1 e8 0c          	shr    $0xc,%rax
  802f85:	48 89 c2             	mov    %rax,%rdx
  802f88:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802f8f:	01 00 00 
  802f92:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802f96:	83 e0 01             	and    $0x1,%eax
  802f99:	48 85 c0             	test   %rax,%rax
  802f9c:	75 07                	jne    802fa5 <fd_lookup+0x7e>
  802f9e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802fa3:	eb 10                	jmp    802fb5 <fd_lookup+0x8e>
  802fa5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802fa9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802fad:	48 89 10             	mov    %rdx,(%rax)
  802fb0:	b8 00 00 00 00       	mov    $0x0,%eax
  802fb5:	c9                   	leaveq 
  802fb6:	c3                   	retq   

0000000000802fb7 <fd_close>:
  802fb7:	55                   	push   %rbp
  802fb8:	48 89 e5             	mov    %rsp,%rbp
  802fbb:	48 83 ec 30          	sub    $0x30,%rsp
  802fbf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802fc3:	89 f0                	mov    %esi,%eax
  802fc5:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802fc8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802fcc:	48 89 c7             	mov    %rax,%rdi
  802fcf:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  802fd6:	00 00 00 
  802fd9:	ff d0                	callq  *%rax
  802fdb:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802fdf:	48 89 d6             	mov    %rdx,%rsi
  802fe2:	89 c7                	mov    %eax,%edi
  802fe4:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  802feb:	00 00 00 
  802fee:	ff d0                	callq  *%rax
  802ff0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ff3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ff7:	78 0a                	js     803003 <fd_close+0x4c>
  802ff9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802ffd:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  803001:	74 12                	je     803015 <fd_close+0x5e>
  803003:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  803007:	74 05                	je     80300e <fd_close+0x57>
  803009:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80300c:	eb 05                	jmp    803013 <fd_close+0x5c>
  80300e:	b8 00 00 00 00       	mov    $0x0,%eax
  803013:	eb 69                	jmp    80307e <fd_close+0xc7>
  803015:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803019:	8b 00                	mov    (%rax),%eax
  80301b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80301f:	48 89 d6             	mov    %rdx,%rsi
  803022:	89 c7                	mov    %eax,%edi
  803024:	48 b8 80 30 80 00 00 	movabs $0x803080,%rax
  80302b:	00 00 00 
  80302e:	ff d0                	callq  *%rax
  803030:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803033:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803037:	78 2a                	js     803063 <fd_close+0xac>
  803039:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80303d:	48 8b 40 20          	mov    0x20(%rax),%rax
  803041:	48 85 c0             	test   %rax,%rax
  803044:	74 16                	je     80305c <fd_close+0xa5>
  803046:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80304a:	48 8b 40 20          	mov    0x20(%rax),%rax
  80304e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803052:	48 89 d7             	mov    %rdx,%rdi
  803055:	ff d0                	callq  *%rax
  803057:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80305a:	eb 07                	jmp    803063 <fd_close+0xac>
  80305c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803063:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803067:	48 89 c6             	mov    %rax,%rsi
  80306a:	bf 00 00 00 00       	mov    $0x0,%edi
  80306f:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  803076:	00 00 00 
  803079:	ff d0                	callq  *%rax
  80307b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80307e:	c9                   	leaveq 
  80307f:	c3                   	retq   

0000000000803080 <dev_lookup>:
  803080:	55                   	push   %rbp
  803081:	48 89 e5             	mov    %rsp,%rbp
  803084:	48 83 ec 20          	sub    $0x20,%rsp
  803088:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80308b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80308f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803096:	eb 41                	jmp    8030d9 <dev_lookup+0x59>
  803098:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  80309f:	00 00 00 
  8030a2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8030a5:	48 63 d2             	movslq %edx,%rdx
  8030a8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8030ac:	8b 00                	mov    (%rax),%eax
  8030ae:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8030b1:	75 22                	jne    8030d5 <dev_lookup+0x55>
  8030b3:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  8030ba:	00 00 00 
  8030bd:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8030c0:	48 63 d2             	movslq %edx,%rdx
  8030c3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8030c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8030cb:	48 89 10             	mov    %rdx,(%rax)
  8030ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8030d3:	eb 60                	jmp    803135 <dev_lookup+0xb5>
  8030d5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8030d9:	48 b8 20 80 80 00 00 	movabs $0x808020,%rax
  8030e0:	00 00 00 
  8030e3:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8030e6:	48 63 d2             	movslq %edx,%rdx
  8030e9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8030ed:	48 85 c0             	test   %rax,%rax
  8030f0:	75 a6                	jne    803098 <dev_lookup+0x18>
  8030f2:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  8030f9:	00 00 00 
  8030fc:	48 8b 00             	mov    (%rax),%rax
  8030ff:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803105:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803108:	89 c6                	mov    %eax,%esi
  80310a:	48 bf 20 5e 80 00 00 	movabs $0x805e20,%rdi
  803111:	00 00 00 
  803114:	b8 00 00 00 00       	mov    $0x0,%eax
  803119:	48 b9 2a 0d 80 00 00 	movabs $0x800d2a,%rcx
  803120:	00 00 00 
  803123:	ff d1                	callq  *%rcx
  803125:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803129:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  803130:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803135:	c9                   	leaveq 
  803136:	c3                   	retq   

0000000000803137 <close>:
  803137:	55                   	push   %rbp
  803138:	48 89 e5             	mov    %rsp,%rbp
  80313b:	48 83 ec 20          	sub    $0x20,%rsp
  80313f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803142:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803146:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803149:	48 89 d6             	mov    %rdx,%rsi
  80314c:	89 c7                	mov    %eax,%edi
  80314e:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  803155:	00 00 00 
  803158:	ff d0                	callq  *%rax
  80315a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80315d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803161:	79 05                	jns    803168 <close+0x31>
  803163:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803166:	eb 18                	jmp    803180 <close+0x49>
  803168:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80316c:	be 01 00 00 00       	mov    $0x1,%esi
  803171:	48 89 c7             	mov    %rax,%rdi
  803174:	48 b8 b7 2f 80 00 00 	movabs $0x802fb7,%rax
  80317b:	00 00 00 
  80317e:	ff d0                	callq  *%rax
  803180:	c9                   	leaveq 
  803181:	c3                   	retq   

0000000000803182 <close_all>:
  803182:	55                   	push   %rbp
  803183:	48 89 e5             	mov    %rsp,%rbp
  803186:	48 83 ec 10          	sub    $0x10,%rsp
  80318a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803191:	eb 15                	jmp    8031a8 <close_all+0x26>
  803193:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803196:	89 c7                	mov    %eax,%edi
  803198:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  80319f:	00 00 00 
  8031a2:	ff d0                	callq  *%rax
  8031a4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8031a8:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8031ac:	7e e5                	jle    803193 <close_all+0x11>
  8031ae:	c9                   	leaveq 
  8031af:	c3                   	retq   

00000000008031b0 <dup>:
  8031b0:	55                   	push   %rbp
  8031b1:	48 89 e5             	mov    %rsp,%rbp
  8031b4:	48 83 ec 40          	sub    $0x40,%rsp
  8031b8:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8031bb:	89 75 c8             	mov    %esi,-0x38(%rbp)
  8031be:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  8031c2:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8031c5:	48 89 d6             	mov    %rdx,%rsi
  8031c8:	89 c7                	mov    %eax,%edi
  8031ca:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  8031d1:	00 00 00 
  8031d4:	ff d0                	callq  *%rax
  8031d6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8031d9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8031dd:	79 08                	jns    8031e7 <dup+0x37>
  8031df:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8031e2:	e9 70 01 00 00       	jmpq   803357 <dup+0x1a7>
  8031e7:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8031ea:	89 c7                	mov    %eax,%edi
  8031ec:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  8031f3:	00 00 00 
  8031f6:	ff d0                	callq  *%rax
  8031f8:	8b 45 c8             	mov    -0x38(%rbp),%eax
  8031fb:	48 98                	cltq   
  8031fd:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  803203:	48 c1 e0 0c          	shl    $0xc,%rax
  803207:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80320b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80320f:	48 89 c7             	mov    %rax,%rdi
  803212:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  803219:	00 00 00 
  80321c:	ff d0                	callq  *%rax
  80321e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803222:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803226:	48 89 c7             	mov    %rax,%rdi
  803229:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  803230:	00 00 00 
  803233:	ff d0                	callq  *%rax
  803235:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803239:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80323d:	48 c1 e8 15          	shr    $0x15,%rax
  803241:	48 89 c2             	mov    %rax,%rdx
  803244:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80324b:	01 00 00 
  80324e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803252:	83 e0 01             	and    $0x1,%eax
  803255:	48 85 c0             	test   %rax,%rax
  803258:	74 73                	je     8032cd <dup+0x11d>
  80325a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80325e:	48 c1 e8 0c          	shr    $0xc,%rax
  803262:	48 89 c2             	mov    %rax,%rdx
  803265:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80326c:	01 00 00 
  80326f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803273:	83 e0 01             	and    $0x1,%eax
  803276:	48 85 c0             	test   %rax,%rax
  803279:	74 52                	je     8032cd <dup+0x11d>
  80327b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80327f:	48 c1 e8 0c          	shr    $0xc,%rax
  803283:	48 89 c2             	mov    %rax,%rdx
  803286:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80328d:	01 00 00 
  803290:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803294:	25 07 0e 00 00       	and    $0xe07,%eax
  803299:	89 c1                	mov    %eax,%ecx
  80329b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80329f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8032a3:	41 89 c8             	mov    %ecx,%r8d
  8032a6:	48 89 d1             	mov    %rdx,%rcx
  8032a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8032ae:	48 89 c6             	mov    %rax,%rsi
  8032b1:	bf 00 00 00 00       	mov    $0x0,%edi
  8032b6:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  8032bd:	00 00 00 
  8032c0:	ff d0                	callq  *%rax
  8032c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032c9:	79 02                	jns    8032cd <dup+0x11d>
  8032cb:	eb 57                	jmp    803324 <dup+0x174>
  8032cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8032d1:	48 c1 e8 0c          	shr    $0xc,%rax
  8032d5:	48 89 c2             	mov    %rax,%rdx
  8032d8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8032df:	01 00 00 
  8032e2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8032e6:	25 07 0e 00 00       	and    $0xe07,%eax
  8032eb:	89 c1                	mov    %eax,%ecx
  8032ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8032f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8032f5:	41 89 c8             	mov    %ecx,%r8d
  8032f8:	48 89 d1             	mov    %rdx,%rcx
  8032fb:	ba 00 00 00 00       	mov    $0x0,%edx
  803300:	48 89 c6             	mov    %rax,%rsi
  803303:	bf 00 00 00 00       	mov    $0x0,%edi
  803308:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  80330f:	00 00 00 
  803312:	ff d0                	callq  *%rax
  803314:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803317:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80331b:	79 02                	jns    80331f <dup+0x16f>
  80331d:	eb 05                	jmp    803324 <dup+0x174>
  80331f:	8b 45 c8             	mov    -0x38(%rbp),%eax
  803322:	eb 33                	jmp    803357 <dup+0x1a7>
  803324:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803328:	48 89 c6             	mov    %rax,%rsi
  80332b:	bf 00 00 00 00       	mov    $0x0,%edi
  803330:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  803337:	00 00 00 
  80333a:	ff d0                	callq  *%rax
  80333c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803340:	48 89 c6             	mov    %rax,%rsi
  803343:	bf 00 00 00 00       	mov    $0x0,%edi
  803348:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  80334f:	00 00 00 
  803352:	ff d0                	callq  *%rax
  803354:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803357:	c9                   	leaveq 
  803358:	c3                   	retq   

0000000000803359 <read>:
  803359:	55                   	push   %rbp
  80335a:	48 89 e5             	mov    %rsp,%rbp
  80335d:	48 83 ec 40          	sub    $0x40,%rsp
  803361:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803364:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803368:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80336c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803370:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803373:	48 89 d6             	mov    %rdx,%rsi
  803376:	89 c7                	mov    %eax,%edi
  803378:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  80337f:	00 00 00 
  803382:	ff d0                	callq  *%rax
  803384:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803387:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80338b:	78 24                	js     8033b1 <read+0x58>
  80338d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803391:	8b 00                	mov    (%rax),%eax
  803393:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803397:	48 89 d6             	mov    %rdx,%rsi
  80339a:	89 c7                	mov    %eax,%edi
  80339c:	48 b8 80 30 80 00 00 	movabs $0x803080,%rax
  8033a3:	00 00 00 
  8033a6:	ff d0                	callq  *%rax
  8033a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033af:	79 05                	jns    8033b6 <read+0x5d>
  8033b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033b4:	eb 76                	jmp    80342c <read+0xd3>
  8033b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033ba:	8b 40 08             	mov    0x8(%rax),%eax
  8033bd:	83 e0 03             	and    $0x3,%eax
  8033c0:	83 f8 01             	cmp    $0x1,%eax
  8033c3:	75 3a                	jne    8033ff <read+0xa6>
  8033c5:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  8033cc:	00 00 00 
  8033cf:	48 8b 00             	mov    (%rax),%rax
  8033d2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8033d8:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8033db:	89 c6                	mov    %eax,%esi
  8033dd:	48 bf 3f 5e 80 00 00 	movabs $0x805e3f,%rdi
  8033e4:	00 00 00 
  8033e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8033ec:	48 b9 2a 0d 80 00 00 	movabs $0x800d2a,%rcx
  8033f3:	00 00 00 
  8033f6:	ff d1                	callq  *%rcx
  8033f8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8033fd:	eb 2d                	jmp    80342c <read+0xd3>
  8033ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803403:	48 8b 40 10          	mov    0x10(%rax),%rax
  803407:	48 85 c0             	test   %rax,%rax
  80340a:	75 07                	jne    803413 <read+0xba>
  80340c:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803411:	eb 19                	jmp    80342c <read+0xd3>
  803413:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803417:	48 8b 40 10          	mov    0x10(%rax),%rax
  80341b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80341f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803423:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  803427:	48 89 cf             	mov    %rcx,%rdi
  80342a:	ff d0                	callq  *%rax
  80342c:	c9                   	leaveq 
  80342d:	c3                   	retq   

000000000080342e <readn>:
  80342e:	55                   	push   %rbp
  80342f:	48 89 e5             	mov    %rsp,%rbp
  803432:	48 83 ec 30          	sub    $0x30,%rsp
  803436:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803439:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80343d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803441:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803448:	eb 49                	jmp    803493 <readn+0x65>
  80344a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80344d:	48 98                	cltq   
  80344f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803453:	48 29 c2             	sub    %rax,%rdx
  803456:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803459:	48 63 c8             	movslq %eax,%rcx
  80345c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803460:	48 01 c1             	add    %rax,%rcx
  803463:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803466:	48 89 ce             	mov    %rcx,%rsi
  803469:	89 c7                	mov    %eax,%edi
  80346b:	48 b8 59 33 80 00 00 	movabs $0x803359,%rax
  803472:	00 00 00 
  803475:	ff d0                	callq  *%rax
  803477:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80347a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80347e:	79 05                	jns    803485 <readn+0x57>
  803480:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803483:	eb 1c                	jmp    8034a1 <readn+0x73>
  803485:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803489:	75 02                	jne    80348d <readn+0x5f>
  80348b:	eb 11                	jmp    80349e <readn+0x70>
  80348d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803490:	01 45 fc             	add    %eax,-0x4(%rbp)
  803493:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803496:	48 98                	cltq   
  803498:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80349c:	72 ac                	jb     80344a <readn+0x1c>
  80349e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034a1:	c9                   	leaveq 
  8034a2:	c3                   	retq   

00000000008034a3 <write>:
  8034a3:	55                   	push   %rbp
  8034a4:	48 89 e5             	mov    %rsp,%rbp
  8034a7:	48 83 ec 40          	sub    $0x40,%rsp
  8034ab:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8034ae:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8034b2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8034b6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8034ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8034bd:	48 89 d6             	mov    %rdx,%rsi
  8034c0:	89 c7                	mov    %eax,%edi
  8034c2:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  8034c9:	00 00 00 
  8034cc:	ff d0                	callq  *%rax
  8034ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034d5:	78 24                	js     8034fb <write+0x58>
  8034d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034db:	8b 00                	mov    (%rax),%eax
  8034dd:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8034e1:	48 89 d6             	mov    %rdx,%rsi
  8034e4:	89 c7                	mov    %eax,%edi
  8034e6:	48 b8 80 30 80 00 00 	movabs $0x803080,%rax
  8034ed:	00 00 00 
  8034f0:	ff d0                	callq  *%rax
  8034f2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034f9:	79 05                	jns    803500 <write+0x5d>
  8034fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034fe:	eb 75                	jmp    803575 <write+0xd2>
  803500:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803504:	8b 40 08             	mov    0x8(%rax),%eax
  803507:	83 e0 03             	and    $0x3,%eax
  80350a:	85 c0                	test   %eax,%eax
  80350c:	75 3a                	jne    803548 <write+0xa5>
  80350e:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  803515:	00 00 00 
  803518:	48 8b 00             	mov    (%rax),%rax
  80351b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803521:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803524:	89 c6                	mov    %eax,%esi
  803526:	48 bf 5b 5e 80 00 00 	movabs $0x805e5b,%rdi
  80352d:	00 00 00 
  803530:	b8 00 00 00 00       	mov    $0x0,%eax
  803535:	48 b9 2a 0d 80 00 00 	movabs $0x800d2a,%rcx
  80353c:	00 00 00 
  80353f:	ff d1                	callq  *%rcx
  803541:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803546:	eb 2d                	jmp    803575 <write+0xd2>
  803548:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80354c:	48 8b 40 18          	mov    0x18(%rax),%rax
  803550:	48 85 c0             	test   %rax,%rax
  803553:	75 07                	jne    80355c <write+0xb9>
  803555:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80355a:	eb 19                	jmp    803575 <write+0xd2>
  80355c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803560:	48 8b 40 18          	mov    0x18(%rax),%rax
  803564:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803568:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80356c:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  803570:	48 89 cf             	mov    %rcx,%rdi
  803573:	ff d0                	callq  *%rax
  803575:	c9                   	leaveq 
  803576:	c3                   	retq   

0000000000803577 <seek>:
  803577:	55                   	push   %rbp
  803578:	48 89 e5             	mov    %rsp,%rbp
  80357b:	48 83 ec 18          	sub    $0x18,%rsp
  80357f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803582:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803585:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803589:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80358c:	48 89 d6             	mov    %rdx,%rsi
  80358f:	89 c7                	mov    %eax,%edi
  803591:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  803598:	00 00 00 
  80359b:	ff d0                	callq  *%rax
  80359d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035a0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035a4:	79 05                	jns    8035ab <seek+0x34>
  8035a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035a9:	eb 0f                	jmp    8035ba <seek+0x43>
  8035ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035af:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8035b2:	89 50 04             	mov    %edx,0x4(%rax)
  8035b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8035ba:	c9                   	leaveq 
  8035bb:	c3                   	retq   

00000000008035bc <ftruncate>:
  8035bc:	55                   	push   %rbp
  8035bd:	48 89 e5             	mov    %rsp,%rbp
  8035c0:	48 83 ec 30          	sub    $0x30,%rsp
  8035c4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8035c7:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8035ca:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8035ce:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8035d1:	48 89 d6             	mov    %rdx,%rsi
  8035d4:	89 c7                	mov    %eax,%edi
  8035d6:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  8035dd:	00 00 00 
  8035e0:	ff d0                	callq  *%rax
  8035e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8035e9:	78 24                	js     80360f <ftruncate+0x53>
  8035eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035ef:	8b 00                	mov    (%rax),%eax
  8035f1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8035f5:	48 89 d6             	mov    %rdx,%rsi
  8035f8:	89 c7                	mov    %eax,%edi
  8035fa:	48 b8 80 30 80 00 00 	movabs $0x803080,%rax
  803601:	00 00 00 
  803604:	ff d0                	callq  *%rax
  803606:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803609:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80360d:	79 05                	jns    803614 <ftruncate+0x58>
  80360f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803612:	eb 72                	jmp    803686 <ftruncate+0xca>
  803614:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803618:	8b 40 08             	mov    0x8(%rax),%eax
  80361b:	83 e0 03             	and    $0x3,%eax
  80361e:	85 c0                	test   %eax,%eax
  803620:	75 3a                	jne    80365c <ftruncate+0xa0>
  803622:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  803629:	00 00 00 
  80362c:	48 8b 00             	mov    (%rax),%rax
  80362f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803635:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803638:	89 c6                	mov    %eax,%esi
  80363a:	48 bf 78 5e 80 00 00 	movabs $0x805e78,%rdi
  803641:	00 00 00 
  803644:	b8 00 00 00 00       	mov    $0x0,%eax
  803649:	48 b9 2a 0d 80 00 00 	movabs $0x800d2a,%rcx
  803650:	00 00 00 
  803653:	ff d1                	callq  *%rcx
  803655:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80365a:	eb 2a                	jmp    803686 <ftruncate+0xca>
  80365c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803660:	48 8b 40 30          	mov    0x30(%rax),%rax
  803664:	48 85 c0             	test   %rax,%rax
  803667:	75 07                	jne    803670 <ftruncate+0xb4>
  803669:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80366e:	eb 16                	jmp    803686 <ftruncate+0xca>
  803670:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803674:	48 8b 40 30          	mov    0x30(%rax),%rax
  803678:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80367c:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  80367f:	89 ce                	mov    %ecx,%esi
  803681:	48 89 d7             	mov    %rdx,%rdi
  803684:	ff d0                	callq  *%rax
  803686:	c9                   	leaveq 
  803687:	c3                   	retq   

0000000000803688 <fstat>:
  803688:	55                   	push   %rbp
  803689:	48 89 e5             	mov    %rsp,%rbp
  80368c:	48 83 ec 30          	sub    $0x30,%rsp
  803690:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803693:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803697:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80369b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80369e:	48 89 d6             	mov    %rdx,%rsi
  8036a1:	89 c7                	mov    %eax,%edi
  8036a3:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  8036aa:	00 00 00 
  8036ad:	ff d0                	callq  *%rax
  8036af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036b6:	78 24                	js     8036dc <fstat+0x54>
  8036b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036bc:	8b 00                	mov    (%rax),%eax
  8036be:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8036c2:	48 89 d6             	mov    %rdx,%rsi
  8036c5:	89 c7                	mov    %eax,%edi
  8036c7:	48 b8 80 30 80 00 00 	movabs $0x803080,%rax
  8036ce:	00 00 00 
  8036d1:	ff d0                	callq  *%rax
  8036d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036da:	79 05                	jns    8036e1 <fstat+0x59>
  8036dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036df:	eb 5e                	jmp    80373f <fstat+0xb7>
  8036e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8036e5:	48 8b 40 28          	mov    0x28(%rax),%rax
  8036e9:	48 85 c0             	test   %rax,%rax
  8036ec:	75 07                	jne    8036f5 <fstat+0x6d>
  8036ee:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8036f3:	eb 4a                	jmp    80373f <fstat+0xb7>
  8036f5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8036f9:	c6 00 00             	movb   $0x0,(%rax)
  8036fc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803700:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  803707:	00 00 00 
  80370a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80370e:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803715:	00 00 00 
  803718:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80371c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803720:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  803727:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80372b:	48 8b 40 28          	mov    0x28(%rax),%rax
  80372f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803733:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  803737:	48 89 ce             	mov    %rcx,%rsi
  80373a:	48 89 d7             	mov    %rdx,%rdi
  80373d:	ff d0                	callq  *%rax
  80373f:	c9                   	leaveq 
  803740:	c3                   	retq   

0000000000803741 <stat>:
  803741:	55                   	push   %rbp
  803742:	48 89 e5             	mov    %rsp,%rbp
  803745:	48 83 ec 20          	sub    $0x20,%rsp
  803749:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80374d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803751:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803755:	be 00 00 00 00       	mov    $0x0,%esi
  80375a:	48 89 c7             	mov    %rax,%rdi
  80375d:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803764:	00 00 00 
  803767:	ff d0                	callq  *%rax
  803769:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80376c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803770:	79 05                	jns    803777 <stat+0x36>
  803772:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803775:	eb 2f                	jmp    8037a6 <stat+0x65>
  803777:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80377b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80377e:	48 89 d6             	mov    %rdx,%rsi
  803781:	89 c7                	mov    %eax,%edi
  803783:	48 b8 88 36 80 00 00 	movabs $0x803688,%rax
  80378a:	00 00 00 
  80378d:	ff d0                	callq  *%rax
  80378f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803792:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803795:	89 c7                	mov    %eax,%edi
  803797:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  80379e:	00 00 00 
  8037a1:	ff d0                	callq  *%rax
  8037a3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8037a6:	c9                   	leaveq 
  8037a7:	c3                   	retq   

00000000008037a8 <fsipc>:
  8037a8:	55                   	push   %rbp
  8037a9:	48 89 e5             	mov    %rsp,%rbp
  8037ac:	48 83 ec 10          	sub    $0x10,%rsp
  8037b0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8037b3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8037b7:	48 b8 08 90 80 00 00 	movabs $0x809008,%rax
  8037be:	00 00 00 
  8037c1:	8b 00                	mov    (%rax),%eax
  8037c3:	85 c0                	test   %eax,%eax
  8037c5:	75 1d                	jne    8037e4 <fsipc+0x3c>
  8037c7:	bf 01 00 00 00       	mov    $0x1,%edi
  8037cc:	48 b8 cf 2d 80 00 00 	movabs $0x802dcf,%rax
  8037d3:	00 00 00 
  8037d6:	ff d0                	callq  *%rax
  8037d8:	48 ba 08 90 80 00 00 	movabs $0x809008,%rdx
  8037df:	00 00 00 
  8037e2:	89 02                	mov    %eax,(%rdx)
  8037e4:	48 b8 08 90 80 00 00 	movabs $0x809008,%rax
  8037eb:	00 00 00 
  8037ee:	8b 00                	mov    (%rax),%eax
  8037f0:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8037f3:	b9 07 00 00 00       	mov    $0x7,%ecx
  8037f8:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  8037ff:	00 00 00 
  803802:	89 c7                	mov    %eax,%edi
  803804:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  80380b:	00 00 00 
  80380e:	ff d0                	callq  *%rax
  803810:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803814:	ba 00 00 00 00       	mov    $0x0,%edx
  803819:	48 89 c6             	mov    %rax,%rsi
  80381c:	bf 00 00 00 00       	mov    $0x0,%edi
  803821:	48 b8 03 2c 80 00 00 	movabs $0x802c03,%rax
  803828:	00 00 00 
  80382b:	ff d0                	callq  *%rax
  80382d:	c9                   	leaveq 
  80382e:	c3                   	retq   

000000000080382f <open>:
  80382f:	55                   	push   %rbp
  803830:	48 89 e5             	mov    %rsp,%rbp
  803833:	48 83 ec 20          	sub    $0x20,%rsp
  803837:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80383b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80383e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803842:	48 89 c7             	mov    %rax,%rdi
  803845:	48 b8 73 18 80 00 00 	movabs $0x801873,%rax
  80384c:	00 00 00 
  80384f:	ff d0                	callq  *%rax
  803851:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803856:	7e 0a                	jle    803862 <open+0x33>
  803858:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80385d:	e9 a5 00 00 00       	jmpq   803907 <open+0xd8>
  803862:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803866:	48 89 c7             	mov    %rax,%rdi
  803869:	48 b8 8f 2e 80 00 00 	movabs $0x802e8f,%rax
  803870:	00 00 00 
  803873:	ff d0                	callq  *%rax
  803875:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803878:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80387c:	79 08                	jns    803886 <open+0x57>
  80387e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803881:	e9 81 00 00 00       	jmpq   803907 <open+0xd8>
  803886:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80388a:	48 89 c6             	mov    %rax,%rsi
  80388d:	48 bf 00 a0 80 00 00 	movabs $0x80a000,%rdi
  803894:	00 00 00 
  803897:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  80389e:	00 00 00 
  8038a1:	ff d0                	callq  *%rax
  8038a3:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8038aa:	00 00 00 
  8038ad:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8038b0:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  8038b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038ba:	48 89 c6             	mov    %rax,%rsi
  8038bd:	bf 01 00 00 00       	mov    $0x1,%edi
  8038c2:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  8038c9:	00 00 00 
  8038cc:	ff d0                	callq  *%rax
  8038ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8038d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8038d5:	79 1d                	jns    8038f4 <open+0xc5>
  8038d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038db:	be 00 00 00 00       	mov    $0x0,%esi
  8038e0:	48 89 c7             	mov    %rax,%rdi
  8038e3:	48 b8 b7 2f 80 00 00 	movabs $0x802fb7,%rax
  8038ea:	00 00 00 
  8038ed:	ff d0                	callq  *%rax
  8038ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038f2:	eb 13                	jmp    803907 <open+0xd8>
  8038f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038f8:	48 89 c7             	mov    %rax,%rdi
  8038fb:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  803902:	00 00 00 
  803905:	ff d0                	callq  *%rax
  803907:	c9                   	leaveq 
  803908:	c3                   	retq   

0000000000803909 <devfile_flush>:
  803909:	55                   	push   %rbp
  80390a:	48 89 e5             	mov    %rsp,%rbp
  80390d:	48 83 ec 10          	sub    $0x10,%rsp
  803911:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803915:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803919:	8b 50 0c             	mov    0xc(%rax),%edx
  80391c:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803923:	00 00 00 
  803926:	89 10                	mov    %edx,(%rax)
  803928:	be 00 00 00 00       	mov    $0x0,%esi
  80392d:	bf 06 00 00 00       	mov    $0x6,%edi
  803932:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803939:	00 00 00 
  80393c:	ff d0                	callq  *%rax
  80393e:	c9                   	leaveq 
  80393f:	c3                   	retq   

0000000000803940 <devfile_read>:
  803940:	55                   	push   %rbp
  803941:	48 89 e5             	mov    %rsp,%rbp
  803944:	48 83 ec 30          	sub    $0x30,%rsp
  803948:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80394c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803950:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803954:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803958:	8b 50 0c             	mov    0xc(%rax),%edx
  80395b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803962:	00 00 00 
  803965:	89 10                	mov    %edx,(%rax)
  803967:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80396e:	00 00 00 
  803971:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803975:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803979:	be 00 00 00 00       	mov    $0x0,%esi
  80397e:	bf 03 00 00 00       	mov    $0x3,%edi
  803983:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  80398a:	00 00 00 
  80398d:	ff d0                	callq  *%rax
  80398f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803992:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803996:	79 08                	jns    8039a0 <devfile_read+0x60>
  803998:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80399b:	e9 a4 00 00 00       	jmpq   803a44 <devfile_read+0x104>
  8039a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039a3:	48 98                	cltq   
  8039a5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8039a9:	76 35                	jbe    8039e0 <devfile_read+0xa0>
  8039ab:	48 b9 9e 5e 80 00 00 	movabs $0x805e9e,%rcx
  8039b2:	00 00 00 
  8039b5:	48 ba a5 5e 80 00 00 	movabs $0x805ea5,%rdx
  8039bc:	00 00 00 
  8039bf:	be 89 00 00 00       	mov    $0x89,%esi
  8039c4:	48 bf ba 5e 80 00 00 	movabs $0x805eba,%rdi
  8039cb:	00 00 00 
  8039ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8039d3:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8039da:	00 00 00 
  8039dd:	41 ff d0             	callq  *%r8
  8039e0:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  8039e7:	7e 35                	jle    803a1e <devfile_read+0xde>
  8039e9:	48 b9 c8 5e 80 00 00 	movabs $0x805ec8,%rcx
  8039f0:	00 00 00 
  8039f3:	48 ba a5 5e 80 00 00 	movabs $0x805ea5,%rdx
  8039fa:	00 00 00 
  8039fd:	be 8a 00 00 00       	mov    $0x8a,%esi
  803a02:	48 bf ba 5e 80 00 00 	movabs $0x805eba,%rdi
  803a09:	00 00 00 
  803a0c:	b8 00 00 00 00       	mov    $0x0,%eax
  803a11:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  803a18:	00 00 00 
  803a1b:	41 ff d0             	callq  *%r8
  803a1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a21:	48 63 d0             	movslq %eax,%rdx
  803a24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a28:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  803a2f:	00 00 00 
  803a32:	48 89 c7             	mov    %rax,%rdi
  803a35:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  803a3c:	00 00 00 
  803a3f:	ff d0                	callq  *%rax
  803a41:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a44:	c9                   	leaveq 
  803a45:	c3                   	retq   

0000000000803a46 <devfile_write>:
  803a46:	55                   	push   %rbp
  803a47:	48 89 e5             	mov    %rsp,%rbp
  803a4a:	48 83 ec 40          	sub    $0x40,%rsp
  803a4e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803a52:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803a56:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803a5a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803a5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803a62:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  803a69:	00 
  803a6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a6e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  803a72:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  803a77:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  803a7b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a7f:	8b 50 0c             	mov    0xc(%rax),%edx
  803a82:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a89:	00 00 00 
  803a8c:	89 10                	mov    %edx,(%rax)
  803a8e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803a95:	00 00 00 
  803a98:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803a9c:	48 89 50 08          	mov    %rdx,0x8(%rax)
  803aa0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  803aa4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803aa8:	48 89 c6             	mov    %rax,%rsi
  803aab:	48 bf 10 a0 80 00 00 	movabs $0x80a010,%rdi
  803ab2:	00 00 00 
  803ab5:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  803abc:	00 00 00 
  803abf:	ff d0                	callq  *%rax
  803ac1:	be 00 00 00 00       	mov    $0x0,%esi
  803ac6:	bf 04 00 00 00       	mov    $0x4,%edi
  803acb:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803ad2:	00 00 00 
  803ad5:	ff d0                	callq  *%rax
  803ad7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803ada:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803ade:	79 05                	jns    803ae5 <devfile_write+0x9f>
  803ae0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ae3:	eb 43                	jmp    803b28 <devfile_write+0xe2>
  803ae5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ae8:	48 98                	cltq   
  803aea:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  803aee:	76 35                	jbe    803b25 <devfile_write+0xdf>
  803af0:	48 b9 9e 5e 80 00 00 	movabs $0x805e9e,%rcx
  803af7:	00 00 00 
  803afa:	48 ba a5 5e 80 00 00 	movabs $0x805ea5,%rdx
  803b01:	00 00 00 
  803b04:	be a8 00 00 00       	mov    $0xa8,%esi
  803b09:	48 bf ba 5e 80 00 00 	movabs $0x805eba,%rdi
  803b10:	00 00 00 
  803b13:	b8 00 00 00 00       	mov    $0x0,%eax
  803b18:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  803b1f:	00 00 00 
  803b22:	41 ff d0             	callq  *%r8
  803b25:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b28:	c9                   	leaveq 
  803b29:	c3                   	retq   

0000000000803b2a <devfile_stat>:
  803b2a:	55                   	push   %rbp
  803b2b:	48 89 e5             	mov    %rsp,%rbp
  803b2e:	48 83 ec 20          	sub    $0x20,%rsp
  803b32:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803b36:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803b3e:	8b 50 0c             	mov    0xc(%rax),%edx
  803b41:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803b48:	00 00 00 
  803b4b:	89 10                	mov    %edx,(%rax)
  803b4d:	be 00 00 00 00       	mov    $0x0,%esi
  803b52:	bf 05 00 00 00       	mov    $0x5,%edi
  803b57:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803b5e:	00 00 00 
  803b61:	ff d0                	callq  *%rax
  803b63:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b66:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b6a:	79 05                	jns    803b71 <devfile_stat+0x47>
  803b6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b6f:	eb 56                	jmp    803bc7 <devfile_stat+0x9d>
  803b71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803b75:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  803b7c:	00 00 00 
  803b7f:	48 89 c7             	mov    %rax,%rdi
  803b82:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  803b89:	00 00 00 
  803b8c:	ff d0                	callq  *%rax
  803b8e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803b95:	00 00 00 
  803b98:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  803b9e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ba2:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803ba8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803baf:	00 00 00 
  803bb2:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  803bb8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803bbc:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803bc2:	b8 00 00 00 00       	mov    $0x0,%eax
  803bc7:	c9                   	leaveq 
  803bc8:	c3                   	retq   

0000000000803bc9 <devfile_trunc>:
  803bc9:	55                   	push   %rbp
  803bca:	48 89 e5             	mov    %rsp,%rbp
  803bcd:	48 83 ec 10          	sub    $0x10,%rsp
  803bd1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803bd5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  803bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803bdc:	8b 50 0c             	mov    0xc(%rax),%edx
  803bdf:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803be6:	00 00 00 
  803be9:	89 10                	mov    %edx,(%rax)
  803beb:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803bf2:	00 00 00 
  803bf5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803bf8:	89 50 04             	mov    %edx,0x4(%rax)
  803bfb:	be 00 00 00 00       	mov    $0x0,%esi
  803c00:	bf 02 00 00 00       	mov    $0x2,%edi
  803c05:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803c0c:	00 00 00 
  803c0f:	ff d0                	callq  *%rax
  803c11:	c9                   	leaveq 
  803c12:	c3                   	retq   

0000000000803c13 <remove>:
  803c13:	55                   	push   %rbp
  803c14:	48 89 e5             	mov    %rsp,%rbp
  803c17:	48 83 ec 10          	sub    $0x10,%rsp
  803c1b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803c1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c23:	48 89 c7             	mov    %rax,%rdi
  803c26:	48 b8 73 18 80 00 00 	movabs $0x801873,%rax
  803c2d:	00 00 00 
  803c30:	ff d0                	callq  *%rax
  803c32:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803c37:	7e 07                	jle    803c40 <remove+0x2d>
  803c39:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  803c3e:	eb 33                	jmp    803c73 <remove+0x60>
  803c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803c44:	48 89 c6             	mov    %rax,%rsi
  803c47:	48 bf 00 a0 80 00 00 	movabs $0x80a000,%rdi
  803c4e:	00 00 00 
  803c51:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  803c58:	00 00 00 
  803c5b:	ff d0                	callq  *%rax
  803c5d:	be 00 00 00 00       	mov    $0x0,%esi
  803c62:	bf 07 00 00 00       	mov    $0x7,%edi
  803c67:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803c6e:	00 00 00 
  803c71:	ff d0                	callq  *%rax
  803c73:	c9                   	leaveq 
  803c74:	c3                   	retq   

0000000000803c75 <sync>:
  803c75:	55                   	push   %rbp
  803c76:	48 89 e5             	mov    %rsp,%rbp
  803c79:	be 00 00 00 00       	mov    $0x0,%esi
  803c7e:	bf 08 00 00 00       	mov    $0x8,%edi
  803c83:	48 b8 a8 37 80 00 00 	movabs $0x8037a8,%rax
  803c8a:	00 00 00 
  803c8d:	ff d0                	callq  *%rax
  803c8f:	5d                   	pop    %rbp
  803c90:	c3                   	retq   

0000000000803c91 <copy>:
  803c91:	55                   	push   %rbp
  803c92:	48 89 e5             	mov    %rsp,%rbp
  803c95:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  803c9c:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  803ca3:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  803caa:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803cb1:	be 00 00 00 00       	mov    $0x0,%esi
  803cb6:	48 89 c7             	mov    %rax,%rdi
  803cb9:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803cc0:	00 00 00 
  803cc3:	ff d0                	callq  *%rax
  803cc5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803cc8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ccc:	79 28                	jns    803cf6 <copy+0x65>
  803cce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cd1:	89 c6                	mov    %eax,%esi
  803cd3:	48 bf d4 5e 80 00 00 	movabs $0x805ed4,%rdi
  803cda:	00 00 00 
  803cdd:	b8 00 00 00 00       	mov    $0x0,%eax
  803ce2:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  803ce9:	00 00 00 
  803cec:	ff d2                	callq  *%rdx
  803cee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cf1:	e9 74 01 00 00       	jmpq   803e6a <copy+0x1d9>
  803cf6:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  803cfd:	be 01 01 00 00       	mov    $0x101,%esi
  803d02:	48 89 c7             	mov    %rax,%rdi
  803d05:	48 b8 2f 38 80 00 00 	movabs $0x80382f,%rax
  803d0c:	00 00 00 
  803d0f:	ff d0                	callq  *%rax
  803d11:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803d14:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803d18:	79 39                	jns    803d53 <copy+0xc2>
  803d1a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d1d:	89 c6                	mov    %eax,%esi
  803d1f:	48 bf ea 5e 80 00 00 	movabs $0x805eea,%rdi
  803d26:	00 00 00 
  803d29:	b8 00 00 00 00       	mov    $0x0,%eax
  803d2e:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  803d35:	00 00 00 
  803d38:	ff d2                	callq  *%rdx
  803d3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d3d:	89 c7                	mov    %eax,%edi
  803d3f:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803d46:	00 00 00 
  803d49:	ff d0                	callq  *%rax
  803d4b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d4e:	e9 17 01 00 00       	jmpq   803e6a <copy+0x1d9>
  803d53:	eb 74                	jmp    803dc9 <copy+0x138>
  803d55:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803d58:	48 63 d0             	movslq %eax,%rdx
  803d5b:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803d62:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d65:	48 89 ce             	mov    %rcx,%rsi
  803d68:	89 c7                	mov    %eax,%edi
  803d6a:	48 b8 a3 34 80 00 00 	movabs $0x8034a3,%rax
  803d71:	00 00 00 
  803d74:	ff d0                	callq  *%rax
  803d76:	89 45 f0             	mov    %eax,-0x10(%rbp)
  803d79:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  803d7d:	79 4a                	jns    803dc9 <copy+0x138>
  803d7f:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803d82:	89 c6                	mov    %eax,%esi
  803d84:	48 bf 04 5f 80 00 00 	movabs $0x805f04,%rdi
  803d8b:	00 00 00 
  803d8e:	b8 00 00 00 00       	mov    $0x0,%eax
  803d93:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  803d9a:	00 00 00 
  803d9d:	ff d2                	callq  *%rdx
  803d9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803da2:	89 c7                	mov    %eax,%edi
  803da4:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803dab:	00 00 00 
  803dae:	ff d0                	callq  *%rax
  803db0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803db3:	89 c7                	mov    %eax,%edi
  803db5:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803dbc:	00 00 00 
  803dbf:	ff d0                	callq  *%rax
  803dc1:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803dc4:	e9 a1 00 00 00       	jmpq   803e6a <copy+0x1d9>
  803dc9:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  803dd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803dd3:	ba 00 02 00 00       	mov    $0x200,%edx
  803dd8:	48 89 ce             	mov    %rcx,%rsi
  803ddb:	89 c7                	mov    %eax,%edi
  803ddd:	48 b8 59 33 80 00 00 	movabs $0x803359,%rax
  803de4:	00 00 00 
  803de7:	ff d0                	callq  *%rax
  803de9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  803dec:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803df0:	0f 8f 5f ff ff ff    	jg     803d55 <copy+0xc4>
  803df6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803dfa:	79 47                	jns    803e43 <copy+0x1b2>
  803dfc:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803dff:	89 c6                	mov    %eax,%esi
  803e01:	48 bf 17 5f 80 00 00 	movabs $0x805f17,%rdi
  803e08:	00 00 00 
  803e0b:	b8 00 00 00 00       	mov    $0x0,%eax
  803e10:	48 ba 2a 0d 80 00 00 	movabs $0x800d2a,%rdx
  803e17:	00 00 00 
  803e1a:	ff d2                	callq  *%rdx
  803e1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e1f:	89 c7                	mov    %eax,%edi
  803e21:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803e28:	00 00 00 
  803e2b:	ff d0                	callq  *%rax
  803e2d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803e30:	89 c7                	mov    %eax,%edi
  803e32:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803e39:	00 00 00 
  803e3c:	ff d0                	callq  *%rax
  803e3e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803e41:	eb 27                	jmp    803e6a <copy+0x1d9>
  803e43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e46:	89 c7                	mov    %eax,%edi
  803e48:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803e4f:	00 00 00 
  803e52:	ff d0                	callq  *%rax
  803e54:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803e57:	89 c7                	mov    %eax,%edi
  803e59:	48 b8 37 31 80 00 00 	movabs $0x803137,%rax
  803e60:	00 00 00 
  803e63:	ff d0                	callq  *%rax
  803e65:	b8 00 00 00 00       	mov    $0x0,%eax
  803e6a:	c9                   	leaveq 
  803e6b:	c3                   	retq   

0000000000803e6c <fd2sockid>:
  803e6c:	55                   	push   %rbp
  803e6d:	48 89 e5             	mov    %rsp,%rbp
  803e70:	48 83 ec 20          	sub    $0x20,%rsp
  803e74:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e77:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803e7b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803e7e:	48 89 d6             	mov    %rdx,%rsi
  803e81:	89 c7                	mov    %eax,%edi
  803e83:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  803e8a:	00 00 00 
  803e8d:	ff d0                	callq  *%rax
  803e8f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e92:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e96:	79 05                	jns    803e9d <fd2sockid+0x31>
  803e98:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e9b:	eb 24                	jmp    803ec1 <fd2sockid+0x55>
  803e9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ea1:	8b 10                	mov    (%rax),%edx
  803ea3:	48 b8 a0 80 80 00 00 	movabs $0x8080a0,%rax
  803eaa:	00 00 00 
  803ead:	8b 00                	mov    (%rax),%eax
  803eaf:	39 c2                	cmp    %eax,%edx
  803eb1:	74 07                	je     803eba <fd2sockid+0x4e>
  803eb3:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803eb8:	eb 07                	jmp    803ec1 <fd2sockid+0x55>
  803eba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ebe:	8b 40 0c             	mov    0xc(%rax),%eax
  803ec1:	c9                   	leaveq 
  803ec2:	c3                   	retq   

0000000000803ec3 <alloc_sockfd>:
  803ec3:	55                   	push   %rbp
  803ec4:	48 89 e5             	mov    %rsp,%rbp
  803ec7:	48 83 ec 20          	sub    $0x20,%rsp
  803ecb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ece:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803ed2:	48 89 c7             	mov    %rax,%rdi
  803ed5:	48 b8 8f 2e 80 00 00 	movabs $0x802e8f,%rax
  803edc:	00 00 00 
  803edf:	ff d0                	callq  *%rax
  803ee1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ee4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ee8:	78 26                	js     803f10 <alloc_sockfd+0x4d>
  803eea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803eee:	ba 07 04 00 00       	mov    $0x407,%edx
  803ef3:	48 89 c6             	mov    %rax,%rsi
  803ef6:	bf 00 00 00 00       	mov    $0x0,%edi
  803efb:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  803f02:	00 00 00 
  803f05:	ff d0                	callq  *%rax
  803f07:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f0a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f0e:	79 16                	jns    803f26 <alloc_sockfd+0x63>
  803f10:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f13:	89 c7                	mov    %eax,%edi
  803f15:	48 b8 d0 43 80 00 00 	movabs $0x8043d0,%rax
  803f1c:	00 00 00 
  803f1f:	ff d0                	callq  *%rax
  803f21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f24:	eb 3a                	jmp    803f60 <alloc_sockfd+0x9d>
  803f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f2a:	48 ba a0 80 80 00 00 	movabs $0x8080a0,%rdx
  803f31:	00 00 00 
  803f34:	8b 12                	mov    (%rdx),%edx
  803f36:	89 10                	mov    %edx,(%rax)
  803f38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f3c:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803f43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f47:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803f4a:	89 50 0c             	mov    %edx,0xc(%rax)
  803f4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f51:	48 89 c7             	mov    %rax,%rdi
  803f54:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  803f5b:	00 00 00 
  803f5e:	ff d0                	callq  *%rax
  803f60:	c9                   	leaveq 
  803f61:	c3                   	retq   

0000000000803f62 <accept>:
  803f62:	55                   	push   %rbp
  803f63:	48 89 e5             	mov    %rsp,%rbp
  803f66:	48 83 ec 30          	sub    $0x30,%rsp
  803f6a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803f6d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f71:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803f75:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803f78:	89 c7                	mov    %eax,%edi
  803f7a:	48 b8 6c 3e 80 00 00 	movabs $0x803e6c,%rax
  803f81:	00 00 00 
  803f84:	ff d0                	callq  *%rax
  803f86:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f89:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f8d:	79 05                	jns    803f94 <accept+0x32>
  803f8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f92:	eb 3b                	jmp    803fcf <accept+0x6d>
  803f94:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803f98:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803f9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f9f:	48 89 ce             	mov    %rcx,%rsi
  803fa2:	89 c7                	mov    %eax,%edi
  803fa4:	48 b8 ad 42 80 00 00 	movabs $0x8042ad,%rax
  803fab:	00 00 00 
  803fae:	ff d0                	callq  *%rax
  803fb0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803fb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803fb7:	79 05                	jns    803fbe <accept+0x5c>
  803fb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fbc:	eb 11                	jmp    803fcf <accept+0x6d>
  803fbe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803fc1:	89 c7                	mov    %eax,%edi
  803fc3:	48 b8 c3 3e 80 00 00 	movabs $0x803ec3,%rax
  803fca:	00 00 00 
  803fcd:	ff d0                	callq  *%rax
  803fcf:	c9                   	leaveq 
  803fd0:	c3                   	retq   

0000000000803fd1 <bind>:
  803fd1:	55                   	push   %rbp
  803fd2:	48 89 e5             	mov    %rsp,%rbp
  803fd5:	48 83 ec 20          	sub    $0x20,%rsp
  803fd9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803fdc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803fe0:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803fe3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803fe6:	89 c7                	mov    %eax,%edi
  803fe8:	48 b8 6c 3e 80 00 00 	movabs $0x803e6c,%rax
  803fef:	00 00 00 
  803ff2:	ff d0                	callq  *%rax
  803ff4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ff7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803ffb:	79 05                	jns    804002 <bind+0x31>
  803ffd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804000:	eb 1b                	jmp    80401d <bind+0x4c>
  804002:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804005:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  804009:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80400c:	48 89 ce             	mov    %rcx,%rsi
  80400f:	89 c7                	mov    %eax,%edi
  804011:	48 b8 2c 43 80 00 00 	movabs $0x80432c,%rax
  804018:	00 00 00 
  80401b:	ff d0                	callq  *%rax
  80401d:	c9                   	leaveq 
  80401e:	c3                   	retq   

000000000080401f <shutdown>:
  80401f:	55                   	push   %rbp
  804020:	48 89 e5             	mov    %rsp,%rbp
  804023:	48 83 ec 20          	sub    $0x20,%rsp
  804027:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80402a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80402d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804030:	89 c7                	mov    %eax,%edi
  804032:	48 b8 6c 3e 80 00 00 	movabs $0x803e6c,%rax
  804039:	00 00 00 
  80403c:	ff d0                	callq  *%rax
  80403e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804041:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804045:	79 05                	jns    80404c <shutdown+0x2d>
  804047:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80404a:	eb 16                	jmp    804062 <shutdown+0x43>
  80404c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80404f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804052:	89 d6                	mov    %edx,%esi
  804054:	89 c7                	mov    %eax,%edi
  804056:	48 b8 90 43 80 00 00 	movabs $0x804390,%rax
  80405d:	00 00 00 
  804060:	ff d0                	callq  *%rax
  804062:	c9                   	leaveq 
  804063:	c3                   	retq   

0000000000804064 <devsock_close>:
  804064:	55                   	push   %rbp
  804065:	48 89 e5             	mov    %rsp,%rbp
  804068:	48 83 ec 10          	sub    $0x10,%rsp
  80406c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804070:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804074:	48 89 c7             	mov    %rax,%rdi
  804077:	48 b8 1c 50 80 00 00 	movabs $0x80501c,%rax
  80407e:	00 00 00 
  804081:	ff d0                	callq  *%rax
  804083:	83 f8 01             	cmp    $0x1,%eax
  804086:	75 17                	jne    80409f <devsock_close+0x3b>
  804088:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80408c:	8b 40 0c             	mov    0xc(%rax),%eax
  80408f:	89 c7                	mov    %eax,%edi
  804091:	48 b8 d0 43 80 00 00 	movabs $0x8043d0,%rax
  804098:	00 00 00 
  80409b:	ff d0                	callq  *%rax
  80409d:	eb 05                	jmp    8040a4 <devsock_close+0x40>
  80409f:	b8 00 00 00 00       	mov    $0x0,%eax
  8040a4:	c9                   	leaveq 
  8040a5:	c3                   	retq   

00000000008040a6 <connect>:
  8040a6:	55                   	push   %rbp
  8040a7:	48 89 e5             	mov    %rsp,%rbp
  8040aa:	48 83 ec 20          	sub    $0x20,%rsp
  8040ae:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8040b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8040b5:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8040b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8040bb:	89 c7                	mov    %eax,%edi
  8040bd:	48 b8 6c 3e 80 00 00 	movabs $0x803e6c,%rax
  8040c4:	00 00 00 
  8040c7:	ff d0                	callq  *%rax
  8040c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8040cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8040d0:	79 05                	jns    8040d7 <connect+0x31>
  8040d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040d5:	eb 1b                	jmp    8040f2 <connect+0x4c>
  8040d7:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8040da:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8040de:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040e1:	48 89 ce             	mov    %rcx,%rsi
  8040e4:	89 c7                	mov    %eax,%edi
  8040e6:	48 b8 fd 43 80 00 00 	movabs $0x8043fd,%rax
  8040ed:	00 00 00 
  8040f0:	ff d0                	callq  *%rax
  8040f2:	c9                   	leaveq 
  8040f3:	c3                   	retq   

00000000008040f4 <listen>:
  8040f4:	55                   	push   %rbp
  8040f5:	48 89 e5             	mov    %rsp,%rbp
  8040f8:	48 83 ec 20          	sub    $0x20,%rsp
  8040fc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8040ff:	89 75 e8             	mov    %esi,-0x18(%rbp)
  804102:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804105:	89 c7                	mov    %eax,%edi
  804107:	48 b8 6c 3e 80 00 00 	movabs $0x803e6c,%rax
  80410e:	00 00 00 
  804111:	ff d0                	callq  *%rax
  804113:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804116:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80411a:	79 05                	jns    804121 <listen+0x2d>
  80411c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80411f:	eb 16                	jmp    804137 <listen+0x43>
  804121:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804124:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804127:	89 d6                	mov    %edx,%esi
  804129:	89 c7                	mov    %eax,%edi
  80412b:	48 b8 61 44 80 00 00 	movabs $0x804461,%rax
  804132:	00 00 00 
  804135:	ff d0                	callq  *%rax
  804137:	c9                   	leaveq 
  804138:	c3                   	retq   

0000000000804139 <devsock_read>:
  804139:	55                   	push   %rbp
  80413a:	48 89 e5             	mov    %rsp,%rbp
  80413d:	48 83 ec 20          	sub    $0x20,%rsp
  804141:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804145:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804149:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80414d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804151:	89 c2                	mov    %eax,%edx
  804153:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804157:	8b 40 0c             	mov    0xc(%rax),%eax
  80415a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  80415e:	b9 00 00 00 00       	mov    $0x0,%ecx
  804163:	89 c7                	mov    %eax,%edi
  804165:	48 b8 a1 44 80 00 00 	movabs $0x8044a1,%rax
  80416c:	00 00 00 
  80416f:	ff d0                	callq  *%rax
  804171:	c9                   	leaveq 
  804172:	c3                   	retq   

0000000000804173 <devsock_write>:
  804173:	55                   	push   %rbp
  804174:	48 89 e5             	mov    %rsp,%rbp
  804177:	48 83 ec 20          	sub    $0x20,%rsp
  80417b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80417f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804183:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  804187:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80418b:	89 c2                	mov    %eax,%edx
  80418d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804191:	8b 40 0c             	mov    0xc(%rax),%eax
  804194:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  804198:	b9 00 00 00 00       	mov    $0x0,%ecx
  80419d:	89 c7                	mov    %eax,%edi
  80419f:	48 b8 6d 45 80 00 00 	movabs $0x80456d,%rax
  8041a6:	00 00 00 
  8041a9:	ff d0                	callq  *%rax
  8041ab:	c9                   	leaveq 
  8041ac:	c3                   	retq   

00000000008041ad <devsock_stat>:
  8041ad:	55                   	push   %rbp
  8041ae:	48 89 e5             	mov    %rsp,%rbp
  8041b1:	48 83 ec 10          	sub    $0x10,%rsp
  8041b5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8041b9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8041bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8041c1:	48 be 32 5f 80 00 00 	movabs $0x805f32,%rsi
  8041c8:	00 00 00 
  8041cb:	48 89 c7             	mov    %rax,%rdi
  8041ce:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  8041d5:	00 00 00 
  8041d8:	ff d0                	callq  *%rax
  8041da:	b8 00 00 00 00       	mov    $0x0,%eax
  8041df:	c9                   	leaveq 
  8041e0:	c3                   	retq   

00000000008041e1 <socket>:
  8041e1:	55                   	push   %rbp
  8041e2:	48 89 e5             	mov    %rsp,%rbp
  8041e5:	48 83 ec 20          	sub    $0x20,%rsp
  8041e9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8041ec:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8041ef:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  8041f2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8041f5:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8041f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8041fb:	89 ce                	mov    %ecx,%esi
  8041fd:	89 c7                	mov    %eax,%edi
  8041ff:	48 b8 25 46 80 00 00 	movabs $0x804625,%rax
  804206:	00 00 00 
  804209:	ff d0                	callq  *%rax
  80420b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80420e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804212:	79 05                	jns    804219 <socket+0x38>
  804214:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804217:	eb 11                	jmp    80422a <socket+0x49>
  804219:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80421c:	89 c7                	mov    %eax,%edi
  80421e:	48 b8 c3 3e 80 00 00 	movabs $0x803ec3,%rax
  804225:	00 00 00 
  804228:	ff d0                	callq  *%rax
  80422a:	c9                   	leaveq 
  80422b:	c3                   	retq   

000000000080422c <nsipc>:
  80422c:	55                   	push   %rbp
  80422d:	48 89 e5             	mov    %rsp,%rbp
  804230:	48 83 ec 10          	sub    $0x10,%rsp
  804234:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804237:	48 b8 0c 90 80 00 00 	movabs $0x80900c,%rax
  80423e:	00 00 00 
  804241:	8b 00                	mov    (%rax),%eax
  804243:	85 c0                	test   %eax,%eax
  804245:	75 1d                	jne    804264 <nsipc+0x38>
  804247:	bf 02 00 00 00       	mov    $0x2,%edi
  80424c:	48 b8 cf 2d 80 00 00 	movabs $0x802dcf,%rax
  804253:	00 00 00 
  804256:	ff d0                	callq  *%rax
  804258:	48 ba 0c 90 80 00 00 	movabs $0x80900c,%rdx
  80425f:	00 00 00 
  804262:	89 02                	mov    %eax,(%rdx)
  804264:	48 b8 0c 90 80 00 00 	movabs $0x80900c,%rax
  80426b:	00 00 00 
  80426e:	8b 00                	mov    (%rax),%eax
  804270:	8b 75 fc             	mov    -0x4(%rbp),%esi
  804273:	b9 07 00 00 00       	mov    $0x7,%ecx
  804278:	48 ba 00 c0 80 00 00 	movabs $0x80c000,%rdx
  80427f:	00 00 00 
  804282:	89 c7                	mov    %eax,%edi
  804284:	48 b8 c4 2c 80 00 00 	movabs $0x802cc4,%rax
  80428b:	00 00 00 
  80428e:	ff d0                	callq  *%rax
  804290:	ba 00 00 00 00       	mov    $0x0,%edx
  804295:	be 00 00 00 00       	mov    $0x0,%esi
  80429a:	bf 00 00 00 00       	mov    $0x0,%edi
  80429f:	48 b8 03 2c 80 00 00 	movabs $0x802c03,%rax
  8042a6:	00 00 00 
  8042a9:	ff d0                	callq  *%rax
  8042ab:	c9                   	leaveq 
  8042ac:	c3                   	retq   

00000000008042ad <nsipc_accept>:
  8042ad:	55                   	push   %rbp
  8042ae:	48 89 e5             	mov    %rsp,%rbp
  8042b1:	48 83 ec 30          	sub    $0x30,%rsp
  8042b5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8042b8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8042bc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8042c0:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8042c7:	00 00 00 
  8042ca:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8042cd:	89 10                	mov    %edx,(%rax)
  8042cf:	bf 01 00 00 00       	mov    $0x1,%edi
  8042d4:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  8042db:	00 00 00 
  8042de:	ff d0                	callq  *%rax
  8042e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8042e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8042e7:	78 3e                	js     804327 <nsipc_accept+0x7a>
  8042e9:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8042f0:	00 00 00 
  8042f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8042f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8042fb:	8b 40 10             	mov    0x10(%rax),%eax
  8042fe:	89 c2                	mov    %eax,%edx
  804300:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  804304:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804308:	48 89 ce             	mov    %rcx,%rsi
  80430b:	48 89 c7             	mov    %rax,%rdi
  80430e:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  804315:	00 00 00 
  804318:	ff d0                	callq  *%rax
  80431a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80431e:	8b 50 10             	mov    0x10(%rax),%edx
  804321:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804325:	89 10                	mov    %edx,(%rax)
  804327:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80432a:	c9                   	leaveq 
  80432b:	c3                   	retq   

000000000080432c <nsipc_bind>:
  80432c:	55                   	push   %rbp
  80432d:	48 89 e5             	mov    %rsp,%rbp
  804330:	48 83 ec 10          	sub    $0x10,%rsp
  804334:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804337:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80433b:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80433e:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804345:	00 00 00 
  804348:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80434b:	89 10                	mov    %edx,(%rax)
  80434d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804350:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804354:	48 89 c6             	mov    %rax,%rsi
  804357:	48 bf 04 c0 80 00 00 	movabs $0x80c004,%rdi
  80435e:	00 00 00 
  804361:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  804368:	00 00 00 
  80436b:	ff d0                	callq  *%rax
  80436d:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804374:	00 00 00 
  804377:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80437a:	89 50 14             	mov    %edx,0x14(%rax)
  80437d:	bf 02 00 00 00       	mov    $0x2,%edi
  804382:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  804389:	00 00 00 
  80438c:	ff d0                	callq  *%rax
  80438e:	c9                   	leaveq 
  80438f:	c3                   	retq   

0000000000804390 <nsipc_shutdown>:
  804390:	55                   	push   %rbp
  804391:	48 89 e5             	mov    %rsp,%rbp
  804394:	48 83 ec 10          	sub    $0x10,%rsp
  804398:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80439b:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80439e:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8043a5:	00 00 00 
  8043a8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8043ab:	89 10                	mov    %edx,(%rax)
  8043ad:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8043b4:	00 00 00 
  8043b7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8043ba:	89 50 04             	mov    %edx,0x4(%rax)
  8043bd:	bf 03 00 00 00       	mov    $0x3,%edi
  8043c2:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  8043c9:	00 00 00 
  8043cc:	ff d0                	callq  *%rax
  8043ce:	c9                   	leaveq 
  8043cf:	c3                   	retq   

00000000008043d0 <nsipc_close>:
  8043d0:	55                   	push   %rbp
  8043d1:	48 89 e5             	mov    %rsp,%rbp
  8043d4:	48 83 ec 10          	sub    $0x10,%rsp
  8043d8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8043db:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8043e2:	00 00 00 
  8043e5:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8043e8:	89 10                	mov    %edx,(%rax)
  8043ea:	bf 04 00 00 00       	mov    $0x4,%edi
  8043ef:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  8043f6:	00 00 00 
  8043f9:	ff d0                	callq  *%rax
  8043fb:	c9                   	leaveq 
  8043fc:	c3                   	retq   

00000000008043fd <nsipc_connect>:
  8043fd:	55                   	push   %rbp
  8043fe:	48 89 e5             	mov    %rsp,%rbp
  804401:	48 83 ec 10          	sub    $0x10,%rsp
  804405:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804408:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80440c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80440f:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804416:	00 00 00 
  804419:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80441c:	89 10                	mov    %edx,(%rax)
  80441e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804421:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804425:	48 89 c6             	mov    %rax,%rsi
  804428:	48 bf 04 c0 80 00 00 	movabs $0x80c004,%rdi
  80442f:	00 00 00 
  804432:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  804439:	00 00 00 
  80443c:	ff d0                	callq  *%rax
  80443e:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804445:	00 00 00 
  804448:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80444b:	89 50 14             	mov    %edx,0x14(%rax)
  80444e:	bf 05 00 00 00       	mov    $0x5,%edi
  804453:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  80445a:	00 00 00 
  80445d:	ff d0                	callq  *%rax
  80445f:	c9                   	leaveq 
  804460:	c3                   	retq   

0000000000804461 <nsipc_listen>:
  804461:	55                   	push   %rbp
  804462:	48 89 e5             	mov    %rsp,%rbp
  804465:	48 83 ec 10          	sub    $0x10,%rsp
  804469:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80446c:	89 75 f8             	mov    %esi,-0x8(%rbp)
  80446f:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804476:	00 00 00 
  804479:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80447c:	89 10                	mov    %edx,(%rax)
  80447e:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804485:	00 00 00 
  804488:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80448b:	89 50 04             	mov    %edx,0x4(%rax)
  80448e:	bf 06 00 00 00       	mov    $0x6,%edi
  804493:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  80449a:	00 00 00 
  80449d:	ff d0                	callq  *%rax
  80449f:	c9                   	leaveq 
  8044a0:	c3                   	retq   

00000000008044a1 <nsipc_recv>:
  8044a1:	55                   	push   %rbp
  8044a2:	48 89 e5             	mov    %rsp,%rbp
  8044a5:	48 83 ec 30          	sub    $0x30,%rsp
  8044a9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8044ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8044b0:	89 55 e8             	mov    %edx,-0x18(%rbp)
  8044b3:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  8044b6:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8044bd:	00 00 00 
  8044c0:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8044c3:	89 10                	mov    %edx,(%rax)
  8044c5:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8044cc:	00 00 00 
  8044cf:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8044d2:	89 50 04             	mov    %edx,0x4(%rax)
  8044d5:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8044dc:	00 00 00 
  8044df:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8044e2:	89 50 08             	mov    %edx,0x8(%rax)
  8044e5:	bf 07 00 00 00       	mov    $0x7,%edi
  8044ea:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  8044f1:	00 00 00 
  8044f4:	ff d0                	callq  *%rax
  8044f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044f9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044fd:	78 69                	js     804568 <nsipc_recv+0xc7>
  8044ff:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  804506:	7f 08                	jg     804510 <nsipc_recv+0x6f>
  804508:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80450b:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  80450e:	7e 35                	jle    804545 <nsipc_recv+0xa4>
  804510:	48 b9 39 5f 80 00 00 	movabs $0x805f39,%rcx
  804517:	00 00 00 
  80451a:	48 ba 4e 5f 80 00 00 	movabs $0x805f4e,%rdx
  804521:	00 00 00 
  804524:	be 62 00 00 00       	mov    $0x62,%esi
  804529:	48 bf 63 5f 80 00 00 	movabs $0x805f63,%rdi
  804530:	00 00 00 
  804533:	b8 00 00 00 00       	mov    $0x0,%eax
  804538:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  80453f:	00 00 00 
  804542:	41 ff d0             	callq  *%r8
  804545:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804548:	48 63 d0             	movslq %eax,%rdx
  80454b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80454f:	48 be 00 c0 80 00 00 	movabs $0x80c000,%rsi
  804556:	00 00 00 
  804559:	48 89 c7             	mov    %rax,%rdi
  80455c:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  804563:	00 00 00 
  804566:	ff d0                	callq  *%rax
  804568:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80456b:	c9                   	leaveq 
  80456c:	c3                   	retq   

000000000080456d <nsipc_send>:
  80456d:	55                   	push   %rbp
  80456e:	48 89 e5             	mov    %rsp,%rbp
  804571:	48 83 ec 20          	sub    $0x20,%rsp
  804575:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804578:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80457c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80457f:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  804582:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804589:	00 00 00 
  80458c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80458f:	89 10                	mov    %edx,(%rax)
  804591:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  804598:	7e 35                	jle    8045cf <nsipc_send+0x62>
  80459a:	48 b9 72 5f 80 00 00 	movabs $0x805f72,%rcx
  8045a1:	00 00 00 
  8045a4:	48 ba 4e 5f 80 00 00 	movabs $0x805f4e,%rdx
  8045ab:	00 00 00 
  8045ae:	be 6d 00 00 00       	mov    $0x6d,%esi
  8045b3:	48 bf 63 5f 80 00 00 	movabs $0x805f63,%rdi
  8045ba:	00 00 00 
  8045bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8045c2:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  8045c9:	00 00 00 
  8045cc:	41 ff d0             	callq  *%r8
  8045cf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8045d2:	48 63 d0             	movslq %eax,%rdx
  8045d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045d9:	48 89 c6             	mov    %rax,%rsi
  8045dc:	48 bf 0c c0 80 00 00 	movabs $0x80c00c,%rdi
  8045e3:	00 00 00 
  8045e6:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  8045ed:	00 00 00 
  8045f0:	ff d0                	callq  *%rax
  8045f2:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  8045f9:	00 00 00 
  8045fc:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8045ff:	89 50 04             	mov    %edx,0x4(%rax)
  804602:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804609:	00 00 00 
  80460c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80460f:	89 50 08             	mov    %edx,0x8(%rax)
  804612:	bf 08 00 00 00       	mov    $0x8,%edi
  804617:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  80461e:	00 00 00 
  804621:	ff d0                	callq  *%rax
  804623:	c9                   	leaveq 
  804624:	c3                   	retq   

0000000000804625 <nsipc_socket>:
  804625:	55                   	push   %rbp
  804626:	48 89 e5             	mov    %rsp,%rbp
  804629:	48 83 ec 10          	sub    $0x10,%rsp
  80462d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804630:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804633:	89 55 f4             	mov    %edx,-0xc(%rbp)
  804636:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80463d:	00 00 00 
  804640:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804643:	89 10                	mov    %edx,(%rax)
  804645:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80464c:	00 00 00 
  80464f:	8b 55 f8             	mov    -0x8(%rbp),%edx
  804652:	89 50 04             	mov    %edx,0x4(%rax)
  804655:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  80465c:	00 00 00 
  80465f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  804662:	89 50 08             	mov    %edx,0x8(%rax)
  804665:	bf 09 00 00 00       	mov    $0x9,%edi
  80466a:	48 b8 2c 42 80 00 00 	movabs $0x80422c,%rax
  804671:	00 00 00 
  804674:	ff d0                	callq  *%rax
  804676:	c9                   	leaveq 
  804677:	c3                   	retq   

0000000000804678 <pipe>:
  804678:	55                   	push   %rbp
  804679:	48 89 e5             	mov    %rsp,%rbp
  80467c:	53                   	push   %rbx
  80467d:	48 83 ec 38          	sub    $0x38,%rsp
  804681:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  804685:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  804689:	48 89 c7             	mov    %rax,%rdi
  80468c:	48 b8 8f 2e 80 00 00 	movabs $0x802e8f,%rax
  804693:	00 00 00 
  804696:	ff d0                	callq  *%rax
  804698:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80469b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80469f:	0f 88 bf 01 00 00    	js     804864 <pipe+0x1ec>
  8046a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8046a9:	ba 07 04 00 00       	mov    $0x407,%edx
  8046ae:	48 89 c6             	mov    %rax,%rsi
  8046b1:	bf 00 00 00 00       	mov    $0x0,%edi
  8046b6:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  8046bd:	00 00 00 
  8046c0:	ff d0                	callq  *%rax
  8046c2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8046c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8046c9:	0f 88 95 01 00 00    	js     804864 <pipe+0x1ec>
  8046cf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8046d3:	48 89 c7             	mov    %rax,%rdi
  8046d6:	48 b8 8f 2e 80 00 00 	movabs $0x802e8f,%rax
  8046dd:	00 00 00 
  8046e0:	ff d0                	callq  *%rax
  8046e2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8046e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8046e9:	0f 88 5d 01 00 00    	js     80484c <pipe+0x1d4>
  8046ef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8046f3:	ba 07 04 00 00       	mov    $0x407,%edx
  8046f8:	48 89 c6             	mov    %rax,%rsi
  8046fb:	bf 00 00 00 00       	mov    $0x0,%edi
  804700:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  804707:	00 00 00 
  80470a:	ff d0                	callq  *%rax
  80470c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80470f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804713:	0f 88 33 01 00 00    	js     80484c <pipe+0x1d4>
  804719:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80471d:	48 89 c7             	mov    %rax,%rdi
  804720:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804727:	00 00 00 
  80472a:	ff d0                	callq  *%rax
  80472c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  804730:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804734:	ba 07 04 00 00       	mov    $0x407,%edx
  804739:	48 89 c6             	mov    %rax,%rsi
  80473c:	bf 00 00 00 00       	mov    $0x0,%edi
  804741:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  804748:	00 00 00 
  80474b:	ff d0                	callq  *%rax
  80474d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804750:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804754:	79 05                	jns    80475b <pipe+0xe3>
  804756:	e9 d9 00 00 00       	jmpq   804834 <pipe+0x1bc>
  80475b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80475f:	48 89 c7             	mov    %rax,%rdi
  804762:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804769:	00 00 00 
  80476c:	ff d0                	callq  *%rax
  80476e:	48 89 c2             	mov    %rax,%rdx
  804771:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804775:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  80477b:	48 89 d1             	mov    %rdx,%rcx
  80477e:	ba 00 00 00 00       	mov    $0x0,%edx
  804783:	48 89 c6             	mov    %rax,%rsi
  804786:	bf 00 00 00 00       	mov    $0x0,%edi
  80478b:	48 b8 5e 22 80 00 00 	movabs $0x80225e,%rax
  804792:	00 00 00 
  804795:	ff d0                	callq  *%rax
  804797:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80479a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80479e:	79 1b                	jns    8047bb <pipe+0x143>
  8047a0:	90                   	nop
  8047a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8047a5:	48 89 c6             	mov    %rax,%rsi
  8047a8:	bf 00 00 00 00       	mov    $0x0,%edi
  8047ad:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  8047b4:	00 00 00 
  8047b7:	ff d0                	callq  *%rax
  8047b9:	eb 79                	jmp    804834 <pipe+0x1bc>
  8047bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047bf:	48 ba e0 80 80 00 00 	movabs $0x8080e0,%rdx
  8047c6:	00 00 00 
  8047c9:	8b 12                	mov    (%rdx),%edx
  8047cb:	89 10                	mov    %edx,(%rax)
  8047cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047d1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  8047d8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8047dc:	48 ba e0 80 80 00 00 	movabs $0x8080e0,%rdx
  8047e3:	00 00 00 
  8047e6:	8b 12                	mov    (%rdx),%edx
  8047e8:	89 10                	mov    %edx,(%rax)
  8047ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8047ee:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  8047f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8047f9:	48 89 c7             	mov    %rax,%rdi
  8047fc:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  804803:	00 00 00 
  804806:	ff d0                	callq  *%rax
  804808:	89 c2                	mov    %eax,%edx
  80480a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80480e:	89 10                	mov    %edx,(%rax)
  804810:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804814:	48 8d 58 04          	lea    0x4(%rax),%rbx
  804818:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80481c:	48 89 c7             	mov    %rax,%rdi
  80481f:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  804826:	00 00 00 
  804829:	ff d0                	callq  *%rax
  80482b:	89 03                	mov    %eax,(%rbx)
  80482d:	b8 00 00 00 00       	mov    $0x0,%eax
  804832:	eb 33                	jmp    804867 <pipe+0x1ef>
  804834:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804838:	48 89 c6             	mov    %rax,%rsi
  80483b:	bf 00 00 00 00       	mov    $0x0,%edi
  804840:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  804847:	00 00 00 
  80484a:	ff d0                	callq  *%rax
  80484c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804850:	48 89 c6             	mov    %rax,%rsi
  804853:	bf 00 00 00 00       	mov    $0x0,%edi
  804858:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  80485f:	00 00 00 
  804862:	ff d0                	callq  *%rax
  804864:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804867:	48 83 c4 38          	add    $0x38,%rsp
  80486b:	5b                   	pop    %rbx
  80486c:	5d                   	pop    %rbp
  80486d:	c3                   	retq   

000000000080486e <_pipeisclosed>:
  80486e:	55                   	push   %rbp
  80486f:	48 89 e5             	mov    %rsp,%rbp
  804872:	53                   	push   %rbx
  804873:	48 83 ec 28          	sub    $0x28,%rsp
  804877:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80487b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80487f:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  804886:	00 00 00 
  804889:	48 8b 00             	mov    (%rax),%rax
  80488c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  804892:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804895:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804899:	48 89 c7             	mov    %rax,%rdi
  80489c:	48 b8 1c 50 80 00 00 	movabs $0x80501c,%rax
  8048a3:	00 00 00 
  8048a6:	ff d0                	callq  *%rax
  8048a8:	89 c3                	mov    %eax,%ebx
  8048aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8048ae:	48 89 c7             	mov    %rax,%rdi
  8048b1:	48 b8 1c 50 80 00 00 	movabs $0x80501c,%rax
  8048b8:	00 00 00 
  8048bb:	ff d0                	callq  *%rax
  8048bd:	39 c3                	cmp    %eax,%ebx
  8048bf:	0f 94 c0             	sete   %al
  8048c2:	0f b6 c0             	movzbl %al,%eax
  8048c5:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8048c8:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  8048cf:	00 00 00 
  8048d2:	48 8b 00             	mov    (%rax),%rax
  8048d5:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8048db:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8048de:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8048e1:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8048e4:	75 05                	jne    8048eb <_pipeisclosed+0x7d>
  8048e6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8048e9:	eb 4f                	jmp    80493a <_pipeisclosed+0xcc>
  8048eb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8048ee:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8048f1:	74 42                	je     804935 <_pipeisclosed+0xc7>
  8048f3:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  8048f7:	75 3c                	jne    804935 <_pipeisclosed+0xc7>
  8048f9:	48 b8 20 90 80 00 00 	movabs $0x809020,%rax
  804900:	00 00 00 
  804903:	48 8b 00             	mov    (%rax),%rax
  804906:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80490c:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80490f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804912:	89 c6                	mov    %eax,%esi
  804914:	48 bf 83 5f 80 00 00 	movabs $0x805f83,%rdi
  80491b:	00 00 00 
  80491e:	b8 00 00 00 00       	mov    $0x0,%eax
  804923:	49 b8 2a 0d 80 00 00 	movabs $0x800d2a,%r8
  80492a:	00 00 00 
  80492d:	41 ff d0             	callq  *%r8
  804930:	e9 4a ff ff ff       	jmpq   80487f <_pipeisclosed+0x11>
  804935:	e9 45 ff ff ff       	jmpq   80487f <_pipeisclosed+0x11>
  80493a:	48 83 c4 28          	add    $0x28,%rsp
  80493e:	5b                   	pop    %rbx
  80493f:	5d                   	pop    %rbp
  804940:	c3                   	retq   

0000000000804941 <pipeisclosed>:
  804941:	55                   	push   %rbp
  804942:	48 89 e5             	mov    %rsp,%rbp
  804945:	48 83 ec 30          	sub    $0x30,%rsp
  804949:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80494c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  804950:	8b 45 dc             	mov    -0x24(%rbp),%eax
  804953:	48 89 d6             	mov    %rdx,%rsi
  804956:	89 c7                	mov    %eax,%edi
  804958:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  80495f:	00 00 00 
  804962:	ff d0                	callq  *%rax
  804964:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804967:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80496b:	79 05                	jns    804972 <pipeisclosed+0x31>
  80496d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804970:	eb 31                	jmp    8049a3 <pipeisclosed+0x62>
  804972:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804976:	48 89 c7             	mov    %rax,%rdi
  804979:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804980:	00 00 00 
  804983:	ff d0                	callq  *%rax
  804985:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804989:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80498d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804991:	48 89 d6             	mov    %rdx,%rsi
  804994:	48 89 c7             	mov    %rax,%rdi
  804997:	48 b8 6e 48 80 00 00 	movabs $0x80486e,%rax
  80499e:	00 00 00 
  8049a1:	ff d0                	callq  *%rax
  8049a3:	c9                   	leaveq 
  8049a4:	c3                   	retq   

00000000008049a5 <devpipe_read>:
  8049a5:	55                   	push   %rbp
  8049a6:	48 89 e5             	mov    %rsp,%rbp
  8049a9:	48 83 ec 40          	sub    $0x40,%rsp
  8049ad:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8049b1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8049b5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8049b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049bd:	48 89 c7             	mov    %rax,%rdi
  8049c0:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  8049c7:	00 00 00 
  8049ca:	ff d0                	callq  *%rax
  8049cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8049d0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8049d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8049d8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8049df:	00 
  8049e0:	e9 92 00 00 00       	jmpq   804a77 <devpipe_read+0xd2>
  8049e5:	eb 41                	jmp    804a28 <devpipe_read+0x83>
  8049e7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  8049ec:	74 09                	je     8049f7 <devpipe_read+0x52>
  8049ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8049f2:	e9 92 00 00 00       	jmpq   804a89 <devpipe_read+0xe4>
  8049f7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8049fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8049ff:	48 89 d6             	mov    %rdx,%rsi
  804a02:	48 89 c7             	mov    %rax,%rdi
  804a05:	48 b8 6e 48 80 00 00 	movabs $0x80486e,%rax
  804a0c:	00 00 00 
  804a0f:	ff d0                	callq  *%rax
  804a11:	85 c0                	test   %eax,%eax
  804a13:	74 07                	je     804a1c <devpipe_read+0x77>
  804a15:	b8 00 00 00 00       	mov    $0x0,%eax
  804a1a:	eb 6d                	jmp    804a89 <devpipe_read+0xe4>
  804a1c:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  804a23:	00 00 00 
  804a26:	ff d0                	callq  *%rax
  804a28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a2c:	8b 10                	mov    (%rax),%edx
  804a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a32:	8b 40 04             	mov    0x4(%rax),%eax
  804a35:	39 c2                	cmp    %eax,%edx
  804a37:	74 ae                	je     8049e7 <devpipe_read+0x42>
  804a39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a3d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804a41:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  804a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a49:	8b 00                	mov    (%rax),%eax
  804a4b:	99                   	cltd   
  804a4c:	c1 ea 1b             	shr    $0x1b,%edx
  804a4f:	01 d0                	add    %edx,%eax
  804a51:	83 e0 1f             	and    $0x1f,%eax
  804a54:	29 d0                	sub    %edx,%eax
  804a56:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804a5a:	48 98                	cltq   
  804a5c:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  804a61:	88 01                	mov    %al,(%rcx)
  804a63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a67:	8b 00                	mov    (%rax),%eax
  804a69:	8d 50 01             	lea    0x1(%rax),%edx
  804a6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a70:	89 10                	mov    %edx,(%rax)
  804a72:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804a77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a7b:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804a7f:	0f 82 60 ff ff ff    	jb     8049e5 <devpipe_read+0x40>
  804a85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804a89:	c9                   	leaveq 
  804a8a:	c3                   	retq   

0000000000804a8b <devpipe_write>:
  804a8b:	55                   	push   %rbp
  804a8c:	48 89 e5             	mov    %rsp,%rbp
  804a8f:	48 83 ec 40          	sub    $0x40,%rsp
  804a93:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804a97:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804a9b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804a9f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804aa3:	48 89 c7             	mov    %rax,%rdi
  804aa6:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804aad:	00 00 00 
  804ab0:	ff d0                	callq  *%rax
  804ab2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804ab6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804aba:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804abe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804ac5:	00 
  804ac6:	e9 8e 00 00 00       	jmpq   804b59 <devpipe_write+0xce>
  804acb:	eb 31                	jmp    804afe <devpipe_write+0x73>
  804acd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804ad1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804ad5:	48 89 d6             	mov    %rdx,%rsi
  804ad8:	48 89 c7             	mov    %rax,%rdi
  804adb:	48 b8 6e 48 80 00 00 	movabs $0x80486e,%rax
  804ae2:	00 00 00 
  804ae5:	ff d0                	callq  *%rax
  804ae7:	85 c0                	test   %eax,%eax
  804ae9:	74 07                	je     804af2 <devpipe_write+0x67>
  804aeb:	b8 00 00 00 00       	mov    $0x0,%eax
  804af0:	eb 79                	jmp    804b6b <devpipe_write+0xe0>
  804af2:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  804af9:	00 00 00 
  804afc:	ff d0                	callq  *%rax
  804afe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804b02:	8b 40 04             	mov    0x4(%rax),%eax
  804b05:	48 63 d0             	movslq %eax,%rdx
  804b08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804b0c:	8b 00                	mov    (%rax),%eax
  804b0e:	48 98                	cltq   
  804b10:	48 83 c0 20          	add    $0x20,%rax
  804b14:	48 39 c2             	cmp    %rax,%rdx
  804b17:	73 b4                	jae    804acd <devpipe_write+0x42>
  804b19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804b1d:	8b 40 04             	mov    0x4(%rax),%eax
  804b20:	99                   	cltd   
  804b21:	c1 ea 1b             	shr    $0x1b,%edx
  804b24:	01 d0                	add    %edx,%eax
  804b26:	83 e0 1f             	and    $0x1f,%eax
  804b29:	29 d0                	sub    %edx,%eax
  804b2b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  804b2f:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804b33:	48 01 ca             	add    %rcx,%rdx
  804b36:	0f b6 0a             	movzbl (%rdx),%ecx
  804b39:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804b3d:	48 98                	cltq   
  804b3f:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  804b43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804b47:	8b 40 04             	mov    0x4(%rax),%eax
  804b4a:	8d 50 01             	lea    0x1(%rax),%edx
  804b4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804b51:	89 50 04             	mov    %edx,0x4(%rax)
  804b54:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  804b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b5d:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  804b61:	0f 82 64 ff ff ff    	jb     804acb <devpipe_write+0x40>
  804b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804b6b:	c9                   	leaveq 
  804b6c:	c3                   	retq   

0000000000804b6d <devpipe_stat>:
  804b6d:	55                   	push   %rbp
  804b6e:	48 89 e5             	mov    %rsp,%rbp
  804b71:	48 83 ec 20          	sub    $0x20,%rsp
  804b75:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804b79:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804b7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804b81:	48 89 c7             	mov    %rax,%rdi
  804b84:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804b8b:	00 00 00 
  804b8e:	ff d0                	callq  *%rax
  804b90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804b94:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804b98:	48 be 96 5f 80 00 00 	movabs $0x805f96,%rsi
  804b9f:	00 00 00 
  804ba2:	48 89 c7             	mov    %rax,%rdi
  804ba5:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  804bac:	00 00 00 
  804baf:	ff d0                	callq  *%rax
  804bb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804bb5:	8b 50 04             	mov    0x4(%rax),%edx
  804bb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804bbc:	8b 00                	mov    (%rax),%eax
  804bbe:	29 c2                	sub    %eax,%edx
  804bc0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804bc4:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804bca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804bce:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804bd5:	00 00 00 
  804bd8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804bdc:	48 b9 e0 80 80 00 00 	movabs $0x8080e0,%rcx
  804be3:	00 00 00 
  804be6:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  804bed:	b8 00 00 00 00       	mov    $0x0,%eax
  804bf2:	c9                   	leaveq 
  804bf3:	c3                   	retq   

0000000000804bf4 <devpipe_close>:
  804bf4:	55                   	push   %rbp
  804bf5:	48 89 e5             	mov    %rsp,%rbp
  804bf8:	48 83 ec 10          	sub    $0x10,%rsp
  804bfc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804c00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804c04:	48 89 c6             	mov    %rax,%rsi
  804c07:	bf 00 00 00 00       	mov    $0x0,%edi
  804c0c:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  804c13:	00 00 00 
  804c16:	ff d0                	callq  *%rax
  804c18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804c1c:	48 89 c7             	mov    %rax,%rdi
  804c1f:	48 b8 64 2e 80 00 00 	movabs $0x802e64,%rax
  804c26:	00 00 00 
  804c29:	ff d0                	callq  *%rax
  804c2b:	48 89 c6             	mov    %rax,%rsi
  804c2e:	bf 00 00 00 00       	mov    $0x0,%edi
  804c33:	48 b8 b9 22 80 00 00 	movabs $0x8022b9,%rax
  804c3a:	00 00 00 
  804c3d:	ff d0                	callq  *%rax
  804c3f:	c9                   	leaveq 
  804c40:	c3                   	retq   

0000000000804c41 <cputchar>:
  804c41:	55                   	push   %rbp
  804c42:	48 89 e5             	mov    %rsp,%rbp
  804c45:	48 83 ec 20          	sub    $0x20,%rsp
  804c49:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804c4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804c4f:	88 45 ff             	mov    %al,-0x1(%rbp)
  804c52:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  804c56:	be 01 00 00 00       	mov    $0x1,%esi
  804c5b:	48 89 c7             	mov    %rax,%rdi
  804c5e:	48 b8 c6 20 80 00 00 	movabs $0x8020c6,%rax
  804c65:	00 00 00 
  804c68:	ff d0                	callq  *%rax
  804c6a:	c9                   	leaveq 
  804c6b:	c3                   	retq   

0000000000804c6c <getchar>:
  804c6c:	55                   	push   %rbp
  804c6d:	48 89 e5             	mov    %rsp,%rbp
  804c70:	48 83 ec 10          	sub    $0x10,%rsp
  804c74:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  804c78:	ba 01 00 00 00       	mov    $0x1,%edx
  804c7d:	48 89 c6             	mov    %rax,%rsi
  804c80:	bf 00 00 00 00       	mov    $0x0,%edi
  804c85:	48 b8 59 33 80 00 00 	movabs $0x803359,%rax
  804c8c:	00 00 00 
  804c8f:	ff d0                	callq  *%rax
  804c91:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804c94:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804c98:	79 05                	jns    804c9f <getchar+0x33>
  804c9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804c9d:	eb 14                	jmp    804cb3 <getchar+0x47>
  804c9f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804ca3:	7f 07                	jg     804cac <getchar+0x40>
  804ca5:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  804caa:	eb 07                	jmp    804cb3 <getchar+0x47>
  804cac:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  804cb0:	0f b6 c0             	movzbl %al,%eax
  804cb3:	c9                   	leaveq 
  804cb4:	c3                   	retq   

0000000000804cb5 <iscons>:
  804cb5:	55                   	push   %rbp
  804cb6:	48 89 e5             	mov    %rsp,%rbp
  804cb9:	48 83 ec 20          	sub    $0x20,%rsp
  804cbd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  804cc0:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804cc4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804cc7:	48 89 d6             	mov    %rdx,%rsi
  804cca:	89 c7                	mov    %eax,%edi
  804ccc:	48 b8 27 2f 80 00 00 	movabs $0x802f27,%rax
  804cd3:	00 00 00 
  804cd6:	ff d0                	callq  *%rax
  804cd8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804cdb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804cdf:	79 05                	jns    804ce6 <iscons+0x31>
  804ce1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804ce4:	eb 1a                	jmp    804d00 <iscons+0x4b>
  804ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804cea:	8b 10                	mov    (%rax),%edx
  804cec:	48 b8 20 81 80 00 00 	movabs $0x808120,%rax
  804cf3:	00 00 00 
  804cf6:	8b 00                	mov    (%rax),%eax
  804cf8:	39 c2                	cmp    %eax,%edx
  804cfa:	0f 94 c0             	sete   %al
  804cfd:	0f b6 c0             	movzbl %al,%eax
  804d00:	c9                   	leaveq 
  804d01:	c3                   	retq   

0000000000804d02 <opencons>:
  804d02:	55                   	push   %rbp
  804d03:	48 89 e5             	mov    %rsp,%rbp
  804d06:	48 83 ec 10          	sub    $0x10,%rsp
  804d0a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  804d0e:	48 89 c7             	mov    %rax,%rdi
  804d11:	48 b8 8f 2e 80 00 00 	movabs $0x802e8f,%rax
  804d18:	00 00 00 
  804d1b:	ff d0                	callq  *%rax
  804d1d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804d20:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804d24:	79 05                	jns    804d2b <opencons+0x29>
  804d26:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804d29:	eb 5b                	jmp    804d86 <opencons+0x84>
  804d2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d2f:	ba 07 04 00 00       	mov    $0x407,%edx
  804d34:	48 89 c6             	mov    %rax,%rsi
  804d37:	bf 00 00 00 00       	mov    $0x0,%edi
  804d3c:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  804d43:	00 00 00 
  804d46:	ff d0                	callq  *%rax
  804d48:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804d4b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804d4f:	79 05                	jns    804d56 <opencons+0x54>
  804d51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804d54:	eb 30                	jmp    804d86 <opencons+0x84>
  804d56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d5a:	48 ba 20 81 80 00 00 	movabs $0x808120,%rdx
  804d61:	00 00 00 
  804d64:	8b 12                	mov    (%rdx),%edx
  804d66:	89 10                	mov    %edx,(%rax)
  804d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d6c:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  804d73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804d77:	48 89 c7             	mov    %rax,%rdi
  804d7a:	48 b8 41 2e 80 00 00 	movabs $0x802e41,%rax
  804d81:	00 00 00 
  804d84:	ff d0                	callq  *%rax
  804d86:	c9                   	leaveq 
  804d87:	c3                   	retq   

0000000000804d88 <devcons_read>:
  804d88:	55                   	push   %rbp
  804d89:	48 89 e5             	mov    %rsp,%rbp
  804d8c:	48 83 ec 30          	sub    $0x30,%rsp
  804d90:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804d94:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  804d98:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  804d9c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  804da1:	75 07                	jne    804daa <devcons_read+0x22>
  804da3:	b8 00 00 00 00       	mov    $0x0,%eax
  804da8:	eb 4b                	jmp    804df5 <devcons_read+0x6d>
  804daa:	eb 0c                	jmp    804db8 <devcons_read+0x30>
  804dac:	48 b8 d0 21 80 00 00 	movabs $0x8021d0,%rax
  804db3:	00 00 00 
  804db6:	ff d0                	callq  *%rax
  804db8:	48 b8 10 21 80 00 00 	movabs $0x802110,%rax
  804dbf:	00 00 00 
  804dc2:	ff d0                	callq  *%rax
  804dc4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804dc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804dcb:	74 df                	je     804dac <devcons_read+0x24>
  804dcd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804dd1:	79 05                	jns    804dd8 <devcons_read+0x50>
  804dd3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804dd6:	eb 1d                	jmp    804df5 <devcons_read+0x6d>
  804dd8:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  804ddc:	75 07                	jne    804de5 <devcons_read+0x5d>
  804dde:	b8 00 00 00 00       	mov    $0x0,%eax
  804de3:	eb 10                	jmp    804df5 <devcons_read+0x6d>
  804de5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804de8:	89 c2                	mov    %eax,%edx
  804dea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804dee:	88 10                	mov    %dl,(%rax)
  804df0:	b8 01 00 00 00       	mov    $0x1,%eax
  804df5:	c9                   	leaveq 
  804df6:	c3                   	retq   

0000000000804df7 <devcons_write>:
  804df7:	55                   	push   %rbp
  804df8:	48 89 e5             	mov    %rsp,%rbp
  804dfb:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804e02:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804e09:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  804e10:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  804e17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  804e1e:	eb 76                	jmp    804e96 <devcons_write+0x9f>
  804e20:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  804e27:	89 c2                	mov    %eax,%edx
  804e29:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804e2c:	29 c2                	sub    %eax,%edx
  804e2e:	89 d0                	mov    %edx,%eax
  804e30:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804e33:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804e36:	83 f8 7f             	cmp    $0x7f,%eax
  804e39:	76 07                	jbe    804e42 <devcons_write+0x4b>
  804e3b:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804e42:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804e45:	48 63 d0             	movslq %eax,%rdx
  804e48:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804e4b:	48 63 c8             	movslq %eax,%rcx
  804e4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  804e55:	48 01 c1             	add    %rax,%rcx
  804e58:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804e5f:	48 89 ce             	mov    %rcx,%rsi
  804e62:	48 89 c7             	mov    %rax,%rdi
  804e65:	48 b8 03 1c 80 00 00 	movabs $0x801c03,%rax
  804e6c:	00 00 00 
  804e6f:	ff d0                	callq  *%rax
  804e71:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804e74:	48 63 d0             	movslq %eax,%rdx
  804e77:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  804e7e:	48 89 d6             	mov    %rdx,%rsi
  804e81:	48 89 c7             	mov    %rax,%rdi
  804e84:	48 b8 c6 20 80 00 00 	movabs $0x8020c6,%rax
  804e8b:	00 00 00 
  804e8e:	ff d0                	callq  *%rax
  804e90:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804e93:	01 45 fc             	add    %eax,-0x4(%rbp)
  804e96:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804e99:	48 98                	cltq   
  804e9b:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  804ea2:	0f 82 78 ff ff ff    	jb     804e20 <devcons_write+0x29>
  804ea8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804eab:	c9                   	leaveq 
  804eac:	c3                   	retq   

0000000000804ead <devcons_close>:
  804ead:	55                   	push   %rbp
  804eae:	48 89 e5             	mov    %rsp,%rbp
  804eb1:	48 83 ec 08          	sub    $0x8,%rsp
  804eb5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804eb9:	b8 00 00 00 00       	mov    $0x0,%eax
  804ebe:	c9                   	leaveq 
  804ebf:	c3                   	retq   

0000000000804ec0 <devcons_stat>:
  804ec0:	55                   	push   %rbp
  804ec1:	48 89 e5             	mov    %rsp,%rbp
  804ec4:	48 83 ec 10          	sub    $0x10,%rsp
  804ec8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804ecc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804ed0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804ed4:	48 be a2 5f 80 00 00 	movabs $0x805fa2,%rsi
  804edb:	00 00 00 
  804ede:	48 89 c7             	mov    %rax,%rdi
  804ee1:	48 b8 df 18 80 00 00 	movabs $0x8018df,%rax
  804ee8:	00 00 00 
  804eeb:	ff d0                	callq  *%rax
  804eed:	b8 00 00 00 00       	mov    $0x0,%eax
  804ef2:	c9                   	leaveq 
  804ef3:	c3                   	retq   

0000000000804ef4 <set_pgfault_handler>:
  804ef4:	55                   	push   %rbp
  804ef5:	48 89 e5             	mov    %rsp,%rbp
  804ef8:	48 83 ec 20          	sub    $0x20,%rsp
  804efc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804f00:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804f07:	00 00 00 
  804f0a:	48 8b 00             	mov    (%rax),%rax
  804f0d:	48 85 c0             	test   %rax,%rax
  804f10:	75 6f                	jne    804f81 <set_pgfault_handler+0x8d>
  804f12:	ba 07 00 00 00       	mov    $0x7,%edx
  804f17:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  804f1c:	bf 00 00 00 00       	mov    $0x0,%edi
  804f21:	48 b8 0e 22 80 00 00 	movabs $0x80220e,%rax
  804f28:	00 00 00 
  804f2b:	ff d0                	callq  *%rax
  804f2d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804f30:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804f34:	79 30                	jns    804f66 <set_pgfault_handler+0x72>
  804f36:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804f39:	89 c1                	mov    %eax,%ecx
  804f3b:	48 ba b0 5f 80 00 00 	movabs $0x805fb0,%rdx
  804f42:	00 00 00 
  804f45:	be 22 00 00 00       	mov    $0x22,%esi
  804f4a:	48 bf cf 5f 80 00 00 	movabs $0x805fcf,%rdi
  804f51:	00 00 00 
  804f54:	b8 00 00 00 00       	mov    $0x0,%eax
  804f59:	49 b8 f1 0a 80 00 00 	movabs $0x800af1,%r8
  804f60:	00 00 00 
  804f63:	41 ff d0             	callq  *%r8
  804f66:	48 be 94 4f 80 00 00 	movabs $0x804f94,%rsi
  804f6d:	00 00 00 
  804f70:	bf 00 00 00 00       	mov    $0x0,%edi
  804f75:	48 b8 98 23 80 00 00 	movabs $0x802398,%rax
  804f7c:	00 00 00 
  804f7f:	ff d0                	callq  *%rax
  804f81:	48 b8 00 d0 80 00 00 	movabs $0x80d000,%rax
  804f88:	00 00 00 
  804f8b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804f8f:	48 89 10             	mov    %rdx,(%rax)
  804f92:	c9                   	leaveq 
  804f93:	c3                   	retq   

0000000000804f94 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  804f94:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  804f97:	48 a1 00 d0 80 00 00 	movabs 0x80d000,%rax
  804f9e:	00 00 00 
call *%rax
  804fa1:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  804fa3:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  804faa:	00 08 
    movq 152(%rsp), %rax
  804fac:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  804fb3:	00 
    movq 136(%rsp), %rbx
  804fb4:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804fbb:	00 
movq %rbx, (%rax)
  804fbc:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804fbf:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  804fc3:	4c 8b 3c 24          	mov    (%rsp),%r15
  804fc7:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804fcc:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  804fd1:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804fd6:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804fdb:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  804fe0:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  804fe5:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804fea:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  804fef:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  804ff4:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804ff9:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804ffe:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  805003:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  805008:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  80500d:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  805011:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  805015:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  805016:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  80501b:	c3                   	retq   

000000000080501c <pageref>:
  80501c:	55                   	push   %rbp
  80501d:	48 89 e5             	mov    %rsp,%rbp
  805020:	48 83 ec 18          	sub    $0x18,%rsp
  805024:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  805028:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80502c:	48 c1 e8 15          	shr    $0x15,%rax
  805030:	48 89 c2             	mov    %rax,%rdx
  805033:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80503a:	01 00 00 
  80503d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805041:	83 e0 01             	and    $0x1,%eax
  805044:	48 85 c0             	test   %rax,%rax
  805047:	75 07                	jne    805050 <pageref+0x34>
  805049:	b8 00 00 00 00       	mov    $0x0,%eax
  80504e:	eb 53                	jmp    8050a3 <pageref+0x87>
  805050:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  805054:	48 c1 e8 0c          	shr    $0xc,%rax
  805058:	48 89 c2             	mov    %rax,%rdx
  80505b:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  805062:	01 00 00 
  805065:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  805069:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80506d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805071:	83 e0 01             	and    $0x1,%eax
  805074:	48 85 c0             	test   %rax,%rax
  805077:	75 07                	jne    805080 <pageref+0x64>
  805079:	b8 00 00 00 00       	mov    $0x0,%eax
  80507e:	eb 23                	jmp    8050a3 <pageref+0x87>
  805080:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805084:	48 c1 e8 0c          	shr    $0xc,%rax
  805088:	48 89 c2             	mov    %rax,%rdx
  80508b:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  805092:	00 00 00 
  805095:	48 c1 e2 04          	shl    $0x4,%rdx
  805099:	48 01 d0             	add    %rdx,%rax
  80509c:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  8050a0:	0f b7 c0             	movzwl %ax,%eax
  8050a3:	c9                   	leaveq 
  8050a4:	c3                   	retq   

00000000008050a5 <inet_addr>:
  8050a5:	55                   	push   %rbp
  8050a6:	48 89 e5             	mov    %rsp,%rbp
  8050a9:	48 83 ec 20          	sub    $0x20,%rsp
  8050ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8050b1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8050b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8050b9:	48 89 d6             	mov    %rdx,%rsi
  8050bc:	48 89 c7             	mov    %rax,%rdi
  8050bf:	48 b8 db 50 80 00 00 	movabs $0x8050db,%rax
  8050c6:	00 00 00 
  8050c9:	ff d0                	callq  *%rax
  8050cb:	85 c0                	test   %eax,%eax
  8050cd:	74 05                	je     8050d4 <inet_addr+0x2f>
  8050cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8050d2:	eb 05                	jmp    8050d9 <inet_addr+0x34>
  8050d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  8050d9:	c9                   	leaveq 
  8050da:	c3                   	retq   

00000000008050db <inet_aton>:
  8050db:	55                   	push   %rbp
  8050dc:	48 89 e5             	mov    %rsp,%rbp
  8050df:	48 83 ec 40          	sub    $0x40,%rsp
  8050e3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8050e7:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  8050eb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8050ef:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8050f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8050f7:	0f b6 00             	movzbl (%rax),%eax
  8050fa:	0f be c0             	movsbl %al,%eax
  8050fd:	89 45 f4             	mov    %eax,-0xc(%rbp)
  805100:	8b 45 f4             	mov    -0xc(%rbp),%eax
  805103:	3c 2f                	cmp    $0x2f,%al
  805105:	76 07                	jbe    80510e <inet_aton+0x33>
  805107:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80510a:	3c 39                	cmp    $0x39,%al
  80510c:	76 0a                	jbe    805118 <inet_aton+0x3d>
  80510e:	b8 00 00 00 00       	mov    $0x0,%eax
  805113:	e9 68 02 00 00       	jmpq   805380 <inet_aton+0x2a5>
  805118:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80511f:	c7 45 f8 0a 00 00 00 	movl   $0xa,-0x8(%rbp)
  805126:	83 7d f4 30          	cmpl   $0x30,-0xc(%rbp)
  80512a:	75 40                	jne    80516c <inet_aton+0x91>
  80512c:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  805131:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  805135:	0f b6 00             	movzbl (%rax),%eax
  805138:	0f be c0             	movsbl %al,%eax
  80513b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80513e:	83 7d f4 78          	cmpl   $0x78,-0xc(%rbp)
  805142:	74 06                	je     80514a <inet_aton+0x6f>
  805144:	83 7d f4 58          	cmpl   $0x58,-0xc(%rbp)
  805148:	75 1b                	jne    805165 <inet_aton+0x8a>
  80514a:	c7 45 f8 10 00 00 00 	movl   $0x10,-0x8(%rbp)
  805151:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  805156:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80515a:	0f b6 00             	movzbl (%rax),%eax
  80515d:	0f be c0             	movsbl %al,%eax
  805160:	89 45 f4             	mov    %eax,-0xc(%rbp)
  805163:	eb 07                	jmp    80516c <inet_aton+0x91>
  805165:	c7 45 f8 08 00 00 00 	movl   $0x8,-0x8(%rbp)
  80516c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80516f:	3c 2f                	cmp    $0x2f,%al
  805171:	76 2f                	jbe    8051a2 <inet_aton+0xc7>
  805173:	8b 45 f4             	mov    -0xc(%rbp),%eax
  805176:	3c 39                	cmp    $0x39,%al
  805178:	77 28                	ja     8051a2 <inet_aton+0xc7>
  80517a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80517d:	0f af 45 fc          	imul   -0x4(%rbp),%eax
  805181:	89 c2                	mov    %eax,%edx
  805183:	8b 45 f4             	mov    -0xc(%rbp),%eax
  805186:	01 d0                	add    %edx,%eax
  805188:	83 e8 30             	sub    $0x30,%eax
  80518b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80518e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  805193:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  805197:	0f b6 00             	movzbl (%rax),%eax
  80519a:	0f be c0             	movsbl %al,%eax
  80519d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8051a0:	eb ca                	jmp    80516c <inet_aton+0x91>
  8051a2:	83 7d f8 10          	cmpl   $0x10,-0x8(%rbp)
  8051a6:	75 72                	jne    80521a <inet_aton+0x13f>
  8051a8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051ab:	3c 2f                	cmp    $0x2f,%al
  8051ad:	76 07                	jbe    8051b6 <inet_aton+0xdb>
  8051af:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051b2:	3c 39                	cmp    $0x39,%al
  8051b4:	76 1c                	jbe    8051d2 <inet_aton+0xf7>
  8051b6:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051b9:	3c 60                	cmp    $0x60,%al
  8051bb:	76 07                	jbe    8051c4 <inet_aton+0xe9>
  8051bd:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051c0:	3c 66                	cmp    $0x66,%al
  8051c2:	76 0e                	jbe    8051d2 <inet_aton+0xf7>
  8051c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051c7:	3c 40                	cmp    $0x40,%al
  8051c9:	76 4f                	jbe    80521a <inet_aton+0x13f>
  8051cb:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051ce:	3c 46                	cmp    $0x46,%al
  8051d0:	77 48                	ja     80521a <inet_aton+0x13f>
  8051d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8051d5:	c1 e0 04             	shl    $0x4,%eax
  8051d8:	89 c2                	mov    %eax,%edx
  8051da:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051dd:	8d 48 0a             	lea    0xa(%rax),%ecx
  8051e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051e3:	3c 60                	cmp    $0x60,%al
  8051e5:	76 0e                	jbe    8051f5 <inet_aton+0x11a>
  8051e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8051ea:	3c 7a                	cmp    $0x7a,%al
  8051ec:	77 07                	ja     8051f5 <inet_aton+0x11a>
  8051ee:	b8 61 00 00 00       	mov    $0x61,%eax
  8051f3:	eb 05                	jmp    8051fa <inet_aton+0x11f>
  8051f5:	b8 41 00 00 00       	mov    $0x41,%eax
  8051fa:	29 c1                	sub    %eax,%ecx
  8051fc:	89 c8                	mov    %ecx,%eax
  8051fe:	09 d0                	or     %edx,%eax
  805200:	89 45 fc             	mov    %eax,-0x4(%rbp)
  805203:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  805208:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80520c:	0f b6 00             	movzbl (%rax),%eax
  80520f:	0f be c0             	movsbl %al,%eax
  805212:	89 45 f4             	mov    %eax,-0xc(%rbp)
  805215:	e9 52 ff ff ff       	jmpq   80516c <inet_aton+0x91>
  80521a:	83 7d f4 2e          	cmpl   $0x2e,-0xc(%rbp)
  80521e:	75 40                	jne    805260 <inet_aton+0x185>
  805220:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  805224:	48 83 c0 0c          	add    $0xc,%rax
  805228:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
  80522c:	72 0a                	jb     805238 <inet_aton+0x15d>
  80522e:	b8 00 00 00 00       	mov    $0x0,%eax
  805233:	e9 48 01 00 00       	jmpq   805380 <inet_aton+0x2a5>
  805238:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80523c:	48 8d 50 04          	lea    0x4(%rax),%rdx
  805240:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  805244:	8b 55 fc             	mov    -0x4(%rbp),%edx
  805247:	89 10                	mov    %edx,(%rax)
  805249:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  80524e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  805252:	0f b6 00             	movzbl (%rax),%eax
  805255:	0f be c0             	movsbl %al,%eax
  805258:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80525b:	e9 a0 fe ff ff       	jmpq   805100 <inet_aton+0x25>
  805260:	90                   	nop
  805261:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  805265:	74 3c                	je     8052a3 <inet_aton+0x1c8>
  805267:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80526a:	3c 1f                	cmp    $0x1f,%al
  80526c:	76 2b                	jbe    805299 <inet_aton+0x1be>
  80526e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  805271:	84 c0                	test   %al,%al
  805273:	78 24                	js     805299 <inet_aton+0x1be>
  805275:	83 7d f4 20          	cmpl   $0x20,-0xc(%rbp)
  805279:	74 28                	je     8052a3 <inet_aton+0x1c8>
  80527b:	83 7d f4 0c          	cmpl   $0xc,-0xc(%rbp)
  80527f:	74 22                	je     8052a3 <inet_aton+0x1c8>
  805281:	83 7d f4 0a          	cmpl   $0xa,-0xc(%rbp)
  805285:	74 1c                	je     8052a3 <inet_aton+0x1c8>
  805287:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
  80528b:	74 16                	je     8052a3 <inet_aton+0x1c8>
  80528d:	83 7d f4 09          	cmpl   $0x9,-0xc(%rbp)
  805291:	74 10                	je     8052a3 <inet_aton+0x1c8>
  805293:	83 7d f4 0b          	cmpl   $0xb,-0xc(%rbp)
  805297:	74 0a                	je     8052a3 <inet_aton+0x1c8>
  805299:	b8 00 00 00 00       	mov    $0x0,%eax
  80529e:	e9 dd 00 00 00       	jmpq   805380 <inet_aton+0x2a5>
  8052a3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8052a7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8052ab:	48 29 c2             	sub    %rax,%rdx
  8052ae:	48 89 d0             	mov    %rdx,%rax
  8052b1:	48 c1 f8 02          	sar    $0x2,%rax
  8052b5:	83 c0 01             	add    $0x1,%eax
  8052b8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8052bb:	83 7d e4 04          	cmpl   $0x4,-0x1c(%rbp)
  8052bf:	0f 87 98 00 00 00    	ja     80535d <inet_aton+0x282>
  8052c5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8052c8:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  8052cf:	00 
  8052d0:	48 b8 e0 5f 80 00 00 	movabs $0x805fe0,%rax
  8052d7:	00 00 00 
  8052da:	48 01 d0             	add    %rdx,%rax
  8052dd:	48 8b 00             	mov    (%rax),%rax
  8052e0:	ff e0                	jmpq   *%rax
  8052e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8052e7:	e9 94 00 00 00       	jmpq   805380 <inet_aton+0x2a5>
  8052ec:	81 7d fc ff ff ff 00 	cmpl   $0xffffff,-0x4(%rbp)
  8052f3:	76 0a                	jbe    8052ff <inet_aton+0x224>
  8052f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8052fa:	e9 81 00 00 00       	jmpq   805380 <inet_aton+0x2a5>
  8052ff:	8b 45 d0             	mov    -0x30(%rbp),%eax
  805302:	c1 e0 18             	shl    $0x18,%eax
  805305:	09 45 fc             	or     %eax,-0x4(%rbp)
  805308:	eb 53                	jmp    80535d <inet_aton+0x282>
  80530a:	81 7d fc ff ff 00 00 	cmpl   $0xffff,-0x4(%rbp)
  805311:	76 07                	jbe    80531a <inet_aton+0x23f>
  805313:	b8 00 00 00 00       	mov    $0x0,%eax
  805318:	eb 66                	jmp    805380 <inet_aton+0x2a5>
  80531a:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80531d:	c1 e0 18             	shl    $0x18,%eax
  805320:	89 c2                	mov    %eax,%edx
  805322:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  805325:	c1 e0 10             	shl    $0x10,%eax
  805328:	09 d0                	or     %edx,%eax
  80532a:	09 45 fc             	or     %eax,-0x4(%rbp)
  80532d:	eb 2e                	jmp    80535d <inet_aton+0x282>
  80532f:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
  805336:	76 07                	jbe    80533f <inet_aton+0x264>
  805338:	b8 00 00 00 00       	mov    $0x0,%eax
  80533d:	eb 41                	jmp    805380 <inet_aton+0x2a5>
  80533f:	8b 45 d0             	mov    -0x30(%rbp),%eax
  805342:	c1 e0 18             	shl    $0x18,%eax
  805345:	89 c2                	mov    %eax,%edx
  805347:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  80534a:	c1 e0 10             	shl    $0x10,%eax
  80534d:	09 c2                	or     %eax,%edx
  80534f:	8b 45 d8             	mov    -0x28(%rbp),%eax
  805352:	c1 e0 08             	shl    $0x8,%eax
  805355:	09 d0                	or     %edx,%eax
  805357:	09 45 fc             	or     %eax,-0x4(%rbp)
  80535a:	eb 01                	jmp    80535d <inet_aton+0x282>
  80535c:	90                   	nop
  80535d:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  805362:	74 17                	je     80537b <inet_aton+0x2a0>
  805364:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805367:	89 c7                	mov    %eax,%edi
  805369:	48 b8 f9 54 80 00 00 	movabs $0x8054f9,%rax
  805370:	00 00 00 
  805373:	ff d0                	callq  *%rax
  805375:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  805379:	89 02                	mov    %eax,(%rdx)
  80537b:	b8 01 00 00 00       	mov    $0x1,%eax
  805380:	c9                   	leaveq 
  805381:	c3                   	retq   

0000000000805382 <inet_ntoa>:
  805382:	55                   	push   %rbp
  805383:	48 89 e5             	mov    %rsp,%rbp
  805386:	48 83 ec 30          	sub    $0x30,%rsp
  80538a:	89 7d d0             	mov    %edi,-0x30(%rbp)
  80538d:	8b 45 d0             	mov    -0x30(%rbp),%eax
  805390:	89 45 e8             	mov    %eax,-0x18(%rbp)
  805393:	48 b8 10 90 80 00 00 	movabs $0x809010,%rax
  80539a:	00 00 00 
  80539d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8053a1:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  8053a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8053a9:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  8053ad:	e9 e0 00 00 00       	jmpq   805492 <inet_ntoa+0x110>
  8053b2:	c6 45 ee 00          	movb   $0x0,-0x12(%rbp)
  8053b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8053ba:	0f b6 08             	movzbl (%rax),%ecx
  8053bd:	0f b6 d1             	movzbl %cl,%edx
  8053c0:	89 d0                	mov    %edx,%eax
  8053c2:	c1 e0 02             	shl    $0x2,%eax
  8053c5:	01 d0                	add    %edx,%eax
  8053c7:	c1 e0 03             	shl    $0x3,%eax
  8053ca:	01 d0                	add    %edx,%eax
  8053cc:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
  8053d3:	01 d0                	add    %edx,%eax
  8053d5:	66 c1 e8 08          	shr    $0x8,%ax
  8053d9:	c0 e8 03             	shr    $0x3,%al
  8053dc:	88 45 ed             	mov    %al,-0x13(%rbp)
  8053df:	0f b6 55 ed          	movzbl -0x13(%rbp),%edx
  8053e3:	89 d0                	mov    %edx,%eax
  8053e5:	c1 e0 02             	shl    $0x2,%eax
  8053e8:	01 d0                	add    %edx,%eax
  8053ea:	01 c0                	add    %eax,%eax
  8053ec:	29 c1                	sub    %eax,%ecx
  8053ee:	89 c8                	mov    %ecx,%eax
  8053f0:	88 45 ed             	mov    %al,-0x13(%rbp)
  8053f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8053f7:	0f b6 00             	movzbl (%rax),%eax
  8053fa:	0f b6 d0             	movzbl %al,%edx
  8053fd:	89 d0                	mov    %edx,%eax
  8053ff:	c1 e0 02             	shl    $0x2,%eax
  805402:	01 d0                	add    %edx,%eax
  805404:	c1 e0 03             	shl    $0x3,%eax
  805407:	01 d0                	add    %edx,%eax
  805409:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
  805410:	01 d0                	add    %edx,%eax
  805412:	66 c1 e8 08          	shr    $0x8,%ax
  805416:	89 c2                	mov    %eax,%edx
  805418:	c0 ea 03             	shr    $0x3,%dl
  80541b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80541f:	88 10                	mov    %dl,(%rax)
  805421:	0f b6 45 ee          	movzbl -0x12(%rbp),%eax
  805425:	8d 50 01             	lea    0x1(%rax),%edx
  805428:	88 55 ee             	mov    %dl,-0x12(%rbp)
  80542b:	0f b6 c0             	movzbl %al,%eax
  80542e:	0f b6 55 ed          	movzbl -0x13(%rbp),%edx
  805432:	83 c2 30             	add    $0x30,%edx
  805435:	48 98                	cltq   
  805437:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  80543b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80543f:	0f b6 00             	movzbl (%rax),%eax
  805442:	84 c0                	test   %al,%al
  805444:	0f 85 6c ff ff ff    	jne    8053b6 <inet_ntoa+0x34>
  80544a:	eb 1a                	jmp    805466 <inet_ntoa+0xe4>
  80544c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805450:	48 8d 50 01          	lea    0x1(%rax),%rdx
  805454:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
  805458:	0f b6 55 ee          	movzbl -0x12(%rbp),%edx
  80545c:	48 63 d2             	movslq %edx,%rdx
  80545f:	0f b6 54 15 e0       	movzbl -0x20(%rbp,%rdx,1),%edx
  805464:	88 10                	mov    %dl,(%rax)
  805466:	0f b6 45 ee          	movzbl -0x12(%rbp),%eax
  80546a:	8d 50 ff             	lea    -0x1(%rax),%edx
  80546d:	88 55 ee             	mov    %dl,-0x12(%rbp)
  805470:	84 c0                	test   %al,%al
  805472:	75 d8                	jne    80544c <inet_ntoa+0xca>
  805474:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  805478:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80547c:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
  805480:	c6 00 2e             	movb   $0x2e,(%rax)
  805483:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  805488:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  80548c:	83 c0 01             	add    $0x1,%eax
  80548f:	88 45 ef             	mov    %al,-0x11(%rbp)
  805492:	80 7d ef 03          	cmpb   $0x3,-0x11(%rbp)
  805496:	0f 86 16 ff ff ff    	jbe    8053b2 <inet_ntoa+0x30>
  80549c:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  8054a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8054a5:	c6 00 00             	movb   $0x0,(%rax)
  8054a8:	48 b8 10 90 80 00 00 	movabs $0x809010,%rax
  8054af:	00 00 00 
  8054b2:	c9                   	leaveq 
  8054b3:	c3                   	retq   

00000000008054b4 <htons>:
  8054b4:	55                   	push   %rbp
  8054b5:	48 89 e5             	mov    %rsp,%rbp
  8054b8:	48 83 ec 04          	sub    $0x4,%rsp
  8054bc:	89 f8                	mov    %edi,%eax
  8054be:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  8054c2:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  8054c6:	c1 e0 08             	shl    $0x8,%eax
  8054c9:	89 c2                	mov    %eax,%edx
  8054cb:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  8054cf:	66 c1 e8 08          	shr    $0x8,%ax
  8054d3:	09 d0                	or     %edx,%eax
  8054d5:	c9                   	leaveq 
  8054d6:	c3                   	retq   

00000000008054d7 <ntohs>:
  8054d7:	55                   	push   %rbp
  8054d8:	48 89 e5             	mov    %rsp,%rbp
  8054db:	48 83 ec 08          	sub    $0x8,%rsp
  8054df:	89 f8                	mov    %edi,%eax
  8054e1:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  8054e5:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
  8054e9:	89 c7                	mov    %eax,%edi
  8054eb:	48 b8 b4 54 80 00 00 	movabs $0x8054b4,%rax
  8054f2:	00 00 00 
  8054f5:	ff d0                	callq  *%rax
  8054f7:	c9                   	leaveq 
  8054f8:	c3                   	retq   

00000000008054f9 <htonl>:
  8054f9:	55                   	push   %rbp
  8054fa:	48 89 e5             	mov    %rsp,%rbp
  8054fd:	48 83 ec 04          	sub    $0x4,%rsp
  805501:	89 7d fc             	mov    %edi,-0x4(%rbp)
  805504:	8b 45 fc             	mov    -0x4(%rbp),%eax
  805507:	c1 e0 18             	shl    $0x18,%eax
  80550a:	89 c2                	mov    %eax,%edx
  80550c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80550f:	25 00 ff 00 00       	and    $0xff00,%eax
  805514:	c1 e0 08             	shl    $0x8,%eax
  805517:	09 c2                	or     %eax,%edx
  805519:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80551c:	25 00 00 ff 00       	and    $0xff0000,%eax
  805521:	48 c1 e8 08          	shr    $0x8,%rax
  805525:	09 c2                	or     %eax,%edx
  805527:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80552a:	c1 e8 18             	shr    $0x18,%eax
  80552d:	09 d0                	or     %edx,%eax
  80552f:	c9                   	leaveq 
  805530:	c3                   	retq   

0000000000805531 <ntohl>:
  805531:	55                   	push   %rbp
  805532:	48 89 e5             	mov    %rsp,%rbp
  805535:	48 83 ec 08          	sub    $0x8,%rsp
  805539:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80553c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80553f:	89 c7                	mov    %eax,%edi
  805541:	48 b8 f9 54 80 00 00 	movabs $0x8054f9,%rax
  805548:	00 00 00 
  80554b:	ff d0                	callq  *%rax
  80554d:	c9                   	leaveq 
  80554e:	c3                   	retq   
