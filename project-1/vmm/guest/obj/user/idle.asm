
vmm/guest/obj/user/idle:     file format elf64-x86-64


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
  80003c:	e8 36 00 00 00       	callq  800077 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 10          	sub    $0x10,%rsp
  80004b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80004e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800052:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  800059:	00 00 00 
  80005c:	48 ba a0 3f 80 00 00 	movabs $0x803fa0,%rdx
  800063:	00 00 00 
  800066:	48 89 10             	mov    %rdx,(%rax)
  800069:	48 b8 b5 02 80 00 00 	movabs $0x8002b5,%rax
  800070:	00 00 00 
  800073:	ff d0                	callq  *%rax
  800075:	eb f2                	jmp    800069 <umain+0x26>

0000000000800077 <libmain>:
  800077:	55                   	push   %rbp
  800078:	48 89 e5             	mov    %rsp,%rbp
  80007b:	48 83 ec 10          	sub    $0x10,%rsp
  80007f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800082:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800086:	48 b8 77 02 80 00 00 	movabs $0x800277,%rax
  80008d:	00 00 00 
  800090:	ff d0                	callq  *%rax
  800092:	25 ff 03 00 00       	and    $0x3ff,%eax
  800097:	48 98                	cltq   
  800099:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8000a0:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8000a7:	00 00 00 
  8000aa:	48 01 c2             	add    %rax,%rdx
  8000ad:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8000b4:	00 00 00 
  8000b7:	48 89 10             	mov    %rdx,(%rax)
  8000ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000be:	7e 14                	jle    8000d4 <libmain+0x5d>
  8000c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8000c4:	48 8b 10             	mov    (%rax),%rdx
  8000c7:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  8000ce:	00 00 00 
  8000d1:	48 89 10             	mov    %rdx,(%rax)
  8000d4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8000d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000db:	48 89 d6             	mov    %rdx,%rsi
  8000de:	89 c7                	mov    %eax,%edi
  8000e0:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8000e7:	00 00 00 
  8000ea:	ff d0                	callq  *%rax
  8000ec:	48 b8 fa 00 80 00 00 	movabs $0x8000fa,%rax
  8000f3:	00 00 00 
  8000f6:	ff d0                	callq  *%rax
  8000f8:	c9                   	leaveq 
  8000f9:	c3                   	retq   

00000000008000fa <exit>:
  8000fa:	55                   	push   %rbp
  8000fb:	48 89 e5             	mov    %rsp,%rbp
  8000fe:	48 b8 14 0a 80 00 00 	movabs $0x800a14,%rax
  800105:	00 00 00 
  800108:	ff d0                	callq  *%rax
  80010a:	bf 00 00 00 00       	mov    $0x0,%edi
  80010f:	48 b8 33 02 80 00 00 	movabs $0x800233,%rax
  800116:	00 00 00 
  800119:	ff d0                	callq  *%rax
  80011b:	5d                   	pop    %rbp
  80011c:	c3                   	retq   

000000000080011d <syscall>:
  80011d:	55                   	push   %rbp
  80011e:	48 89 e5             	mov    %rsp,%rbp
  800121:	53                   	push   %rbx
  800122:	48 83 ec 48          	sub    $0x48,%rsp
  800126:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800129:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80012c:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  800130:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  800134:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  800138:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  80013c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80013f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  800143:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  800147:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  80014b:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  80014f:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  800153:	4c 89 c3             	mov    %r8,%rbx
  800156:	cd 30                	int    $0x30
  800158:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80015c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800160:	74 3e                	je     8001a0 <syscall+0x83>
  800162:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  800167:	7e 37                	jle    8001a0 <syscall+0x83>
  800169:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80016d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800170:	49 89 d0             	mov    %rdx,%r8
  800173:	89 c1                	mov    %eax,%ecx
  800175:	48 ba af 3f 80 00 00 	movabs $0x803faf,%rdx
  80017c:	00 00 00 
  80017f:	be 24 00 00 00       	mov    $0x24,%esi
  800184:	48 bf cc 3f 80 00 00 	movabs $0x803fcc,%rdi
  80018b:	00 00 00 
  80018e:	b8 00 00 00 00       	mov    $0x0,%eax
  800193:	49 b9 86 27 80 00 00 	movabs $0x802786,%r9
  80019a:	00 00 00 
  80019d:	41 ff d1             	callq  *%r9
  8001a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8001a4:	48 83 c4 48          	add    $0x48,%rsp
  8001a8:	5b                   	pop    %rbx
  8001a9:	5d                   	pop    %rbp
  8001aa:	c3                   	retq   

00000000008001ab <sys_cputs>:
  8001ab:	55                   	push   %rbp
  8001ac:	48 89 e5             	mov    %rsp,%rbp
  8001af:	48 83 ec 20          	sub    $0x20,%rsp
  8001b3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8001b7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8001bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8001bf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8001c3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8001ca:	00 
  8001cb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8001d1:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8001d7:	48 89 d1             	mov    %rdx,%rcx
  8001da:	48 89 c2             	mov    %rax,%rdx
  8001dd:	be 00 00 00 00       	mov    $0x0,%esi
  8001e2:	bf 00 00 00 00       	mov    $0x0,%edi
  8001e7:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8001ee:	00 00 00 
  8001f1:	ff d0                	callq  *%rax
  8001f3:	c9                   	leaveq 
  8001f4:	c3                   	retq   

00000000008001f5 <sys_cgetc>:
  8001f5:	55                   	push   %rbp
  8001f6:	48 89 e5             	mov    %rsp,%rbp
  8001f9:	48 83 ec 10          	sub    $0x10,%rsp
  8001fd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800204:	00 
  800205:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80020b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800211:	b9 00 00 00 00       	mov    $0x0,%ecx
  800216:	ba 00 00 00 00       	mov    $0x0,%edx
  80021b:	be 00 00 00 00       	mov    $0x0,%esi
  800220:	bf 01 00 00 00       	mov    $0x1,%edi
  800225:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  80022c:	00 00 00 
  80022f:	ff d0                	callq  *%rax
  800231:	c9                   	leaveq 
  800232:	c3                   	retq   

0000000000800233 <sys_env_destroy>:
  800233:	55                   	push   %rbp
  800234:	48 89 e5             	mov    %rsp,%rbp
  800237:	48 83 ec 10          	sub    $0x10,%rsp
  80023b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80023e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800241:	48 98                	cltq   
  800243:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80024a:	00 
  80024b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800251:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800257:	b9 00 00 00 00       	mov    $0x0,%ecx
  80025c:	48 89 c2             	mov    %rax,%rdx
  80025f:	be 01 00 00 00       	mov    $0x1,%esi
  800264:	bf 03 00 00 00       	mov    $0x3,%edi
  800269:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800270:	00 00 00 
  800273:	ff d0                	callq  *%rax
  800275:	c9                   	leaveq 
  800276:	c3                   	retq   

0000000000800277 <sys_getenvid>:
  800277:	55                   	push   %rbp
  800278:	48 89 e5             	mov    %rsp,%rbp
  80027b:	48 83 ec 10          	sub    $0x10,%rsp
  80027f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800286:	00 
  800287:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80028d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800293:	b9 00 00 00 00       	mov    $0x0,%ecx
  800298:	ba 00 00 00 00       	mov    $0x0,%edx
  80029d:	be 00 00 00 00       	mov    $0x0,%esi
  8002a2:	bf 02 00 00 00       	mov    $0x2,%edi
  8002a7:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8002ae:	00 00 00 
  8002b1:	ff d0                	callq  *%rax
  8002b3:	c9                   	leaveq 
  8002b4:	c3                   	retq   

00000000008002b5 <sys_yield>:
  8002b5:	55                   	push   %rbp
  8002b6:	48 89 e5             	mov    %rsp,%rbp
  8002b9:	48 83 ec 10          	sub    $0x10,%rsp
  8002bd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8002c4:	00 
  8002c5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8002cb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8002d1:	b9 00 00 00 00       	mov    $0x0,%ecx
  8002d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8002db:	be 00 00 00 00       	mov    $0x0,%esi
  8002e0:	bf 0b 00 00 00       	mov    $0xb,%edi
  8002e5:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8002ec:	00 00 00 
  8002ef:	ff d0                	callq  *%rax
  8002f1:	c9                   	leaveq 
  8002f2:	c3                   	retq   

00000000008002f3 <sys_page_alloc>:
  8002f3:	55                   	push   %rbp
  8002f4:	48 89 e5             	mov    %rsp,%rbp
  8002f7:	48 83 ec 20          	sub    $0x20,%rsp
  8002fb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8002fe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800302:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800305:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800308:	48 63 c8             	movslq %eax,%rcx
  80030b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80030f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800312:	48 98                	cltq   
  800314:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80031b:	00 
  80031c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800322:	49 89 c8             	mov    %rcx,%r8
  800325:	48 89 d1             	mov    %rdx,%rcx
  800328:	48 89 c2             	mov    %rax,%rdx
  80032b:	be 01 00 00 00       	mov    $0x1,%esi
  800330:	bf 04 00 00 00       	mov    $0x4,%edi
  800335:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  80033c:	00 00 00 
  80033f:	ff d0                	callq  *%rax
  800341:	c9                   	leaveq 
  800342:	c3                   	retq   

0000000000800343 <sys_page_map>:
  800343:	55                   	push   %rbp
  800344:	48 89 e5             	mov    %rsp,%rbp
  800347:	48 83 ec 30          	sub    $0x30,%rsp
  80034b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80034e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800352:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800355:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  800359:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  80035d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800360:	48 63 c8             	movslq %eax,%rcx
  800363:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  800367:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80036a:	48 63 f0             	movslq %eax,%rsi
  80036d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800371:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800374:	48 98                	cltq   
  800376:	48 89 0c 24          	mov    %rcx,(%rsp)
  80037a:	49 89 f9             	mov    %rdi,%r9
  80037d:	49 89 f0             	mov    %rsi,%r8
  800380:	48 89 d1             	mov    %rdx,%rcx
  800383:	48 89 c2             	mov    %rax,%rdx
  800386:	be 01 00 00 00       	mov    $0x1,%esi
  80038b:	bf 05 00 00 00       	mov    $0x5,%edi
  800390:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800397:	00 00 00 
  80039a:	ff d0                	callq  *%rax
  80039c:	c9                   	leaveq 
  80039d:	c3                   	retq   

000000000080039e <sys_page_unmap>:
  80039e:	55                   	push   %rbp
  80039f:	48 89 e5             	mov    %rsp,%rbp
  8003a2:	48 83 ec 20          	sub    $0x20,%rsp
  8003a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8003a9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8003ad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8003b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003b4:	48 98                	cltq   
  8003b6:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8003bd:	00 
  8003be:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8003c4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8003ca:	48 89 d1             	mov    %rdx,%rcx
  8003cd:	48 89 c2             	mov    %rax,%rdx
  8003d0:	be 01 00 00 00       	mov    $0x1,%esi
  8003d5:	bf 06 00 00 00       	mov    $0x6,%edi
  8003da:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8003e1:	00 00 00 
  8003e4:	ff d0                	callq  *%rax
  8003e6:	c9                   	leaveq 
  8003e7:	c3                   	retq   

00000000008003e8 <sys_env_set_status>:
  8003e8:	55                   	push   %rbp
  8003e9:	48 89 e5             	mov    %rsp,%rbp
  8003ec:	48 83 ec 10          	sub    $0x10,%rsp
  8003f0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8003f3:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8003f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8003f9:	48 63 d0             	movslq %eax,%rdx
  8003fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8003ff:	48 98                	cltq   
  800401:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800408:	00 
  800409:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80040f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800415:	48 89 d1             	mov    %rdx,%rcx
  800418:	48 89 c2             	mov    %rax,%rdx
  80041b:	be 01 00 00 00       	mov    $0x1,%esi
  800420:	bf 08 00 00 00       	mov    $0x8,%edi
  800425:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  80042c:	00 00 00 
  80042f:	ff d0                	callq  *%rax
  800431:	c9                   	leaveq 
  800432:	c3                   	retq   

0000000000800433 <sys_env_set_trapframe>:
  800433:	55                   	push   %rbp
  800434:	48 89 e5             	mov    %rsp,%rbp
  800437:	48 83 ec 20          	sub    $0x20,%rsp
  80043b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80043e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800442:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800446:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800449:	48 98                	cltq   
  80044b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800452:	00 
  800453:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800459:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80045f:	48 89 d1             	mov    %rdx,%rcx
  800462:	48 89 c2             	mov    %rax,%rdx
  800465:	be 01 00 00 00       	mov    $0x1,%esi
  80046a:	bf 09 00 00 00       	mov    $0x9,%edi
  80046f:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800476:	00 00 00 
  800479:	ff d0                	callq  *%rax
  80047b:	c9                   	leaveq 
  80047c:	c3                   	retq   

000000000080047d <sys_env_set_pgfault_upcall>:
  80047d:	55                   	push   %rbp
  80047e:	48 89 e5             	mov    %rsp,%rbp
  800481:	48 83 ec 20          	sub    $0x20,%rsp
  800485:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800488:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80048c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800490:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800493:	48 98                	cltq   
  800495:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80049c:	00 
  80049d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8004a3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8004a9:	48 89 d1             	mov    %rdx,%rcx
  8004ac:	48 89 c2             	mov    %rax,%rdx
  8004af:	be 01 00 00 00       	mov    $0x1,%esi
  8004b4:	bf 0a 00 00 00       	mov    $0xa,%edi
  8004b9:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8004c0:	00 00 00 
  8004c3:	ff d0                	callq  *%rax
  8004c5:	c9                   	leaveq 
  8004c6:	c3                   	retq   

00000000008004c7 <sys_ipc_try_send>:
  8004c7:	55                   	push   %rbp
  8004c8:	48 89 e5             	mov    %rsp,%rbp
  8004cb:	48 83 ec 20          	sub    $0x20,%rsp
  8004cf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8004d2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8004d6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8004da:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  8004dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8004e0:	48 63 f0             	movslq %eax,%rsi
  8004e3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8004e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8004ea:	48 98                	cltq   
  8004ec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8004f0:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8004f7:	00 
  8004f8:	49 89 f1             	mov    %rsi,%r9
  8004fb:	49 89 c8             	mov    %rcx,%r8
  8004fe:	48 89 d1             	mov    %rdx,%rcx
  800501:	48 89 c2             	mov    %rax,%rdx
  800504:	be 00 00 00 00       	mov    $0x0,%esi
  800509:	bf 0c 00 00 00       	mov    $0xc,%edi
  80050e:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800515:	00 00 00 
  800518:	ff d0                	callq  *%rax
  80051a:	c9                   	leaveq 
  80051b:	c3                   	retq   

000000000080051c <sys_ipc_recv>:
  80051c:	55                   	push   %rbp
  80051d:	48 89 e5             	mov    %rsp,%rbp
  800520:	48 83 ec 10          	sub    $0x10,%rsp
  800524:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800528:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80052c:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800533:	00 
  800534:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80053a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800540:	b9 00 00 00 00       	mov    $0x0,%ecx
  800545:	48 89 c2             	mov    %rax,%rdx
  800548:	be 01 00 00 00       	mov    $0x1,%esi
  80054d:	bf 0d 00 00 00       	mov    $0xd,%edi
  800552:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800559:	00 00 00 
  80055c:	ff d0                	callq  *%rax
  80055e:	c9                   	leaveq 
  80055f:	c3                   	retq   

0000000000800560 <sys_time_msec>:
  800560:	55                   	push   %rbp
  800561:	48 89 e5             	mov    %rsp,%rbp
  800564:	48 83 ec 10          	sub    $0x10,%rsp
  800568:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80056f:	00 
  800570:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800576:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80057c:	b9 00 00 00 00       	mov    $0x0,%ecx
  800581:	ba 00 00 00 00       	mov    $0x0,%edx
  800586:	be 00 00 00 00       	mov    $0x0,%esi
  80058b:	bf 0e 00 00 00       	mov    $0xe,%edi
  800590:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800597:	00 00 00 
  80059a:	ff d0                	callq  *%rax
  80059c:	c9                   	leaveq 
  80059d:	c3                   	retq   

000000000080059e <sys_net_transmit>:
  80059e:	55                   	push   %rbp
  80059f:	48 89 e5             	mov    %rsp,%rbp
  8005a2:	48 83 ec 20          	sub    $0x20,%rsp
  8005a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8005aa:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8005ad:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8005b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005b4:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8005bb:	00 
  8005bc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8005c2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8005c8:	48 89 d1             	mov    %rdx,%rcx
  8005cb:	48 89 c2             	mov    %rax,%rdx
  8005ce:	be 00 00 00 00       	mov    $0x0,%esi
  8005d3:	bf 0f 00 00 00       	mov    $0xf,%edi
  8005d8:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8005df:	00 00 00 
  8005e2:	ff d0                	callq  *%rax
  8005e4:	c9                   	leaveq 
  8005e5:	c3                   	retq   

00000000008005e6 <sys_net_receive>:
  8005e6:	55                   	push   %rbp
  8005e7:	48 89 e5             	mov    %rsp,%rbp
  8005ea:	48 83 ec 20          	sub    $0x20,%rsp
  8005ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8005f2:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8005f5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8005f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8005fc:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  800603:	00 
  800604:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80060a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  800610:	48 89 d1             	mov    %rdx,%rcx
  800613:	48 89 c2             	mov    %rax,%rdx
  800616:	be 00 00 00 00       	mov    $0x0,%esi
  80061b:	bf 10 00 00 00       	mov    $0x10,%edi
  800620:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800627:	00 00 00 
  80062a:	ff d0                	callq  *%rax
  80062c:	c9                   	leaveq 
  80062d:	c3                   	retq   

000000000080062e <sys_ept_map>:
  80062e:	55                   	push   %rbp
  80062f:	48 89 e5             	mov    %rsp,%rbp
  800632:	48 83 ec 30          	sub    $0x30,%rsp
  800636:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800639:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80063d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  800640:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  800644:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  800648:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80064b:	48 63 c8             	movslq %eax,%rcx
  80064e:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  800652:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800655:	48 63 f0             	movslq %eax,%rsi
  800658:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80065c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80065f:	48 98                	cltq   
  800661:	48 89 0c 24          	mov    %rcx,(%rsp)
  800665:	49 89 f9             	mov    %rdi,%r9
  800668:	49 89 f0             	mov    %rsi,%r8
  80066b:	48 89 d1             	mov    %rdx,%rcx
  80066e:	48 89 c2             	mov    %rax,%rdx
  800671:	be 00 00 00 00       	mov    $0x0,%esi
  800676:	bf 11 00 00 00       	mov    $0x11,%edi
  80067b:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  800682:	00 00 00 
  800685:	ff d0                	callq  *%rax
  800687:	c9                   	leaveq 
  800688:	c3                   	retq   

0000000000800689 <sys_env_mkguest>:
  800689:	55                   	push   %rbp
  80068a:	48 89 e5             	mov    %rsp,%rbp
  80068d:	48 83 ec 20          	sub    $0x20,%rsp
  800691:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800695:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800699:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80069d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8006a1:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8006a8:	00 
  8006a9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8006af:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8006b5:	48 89 d1             	mov    %rdx,%rcx
  8006b8:	48 89 c2             	mov    %rax,%rdx
  8006bb:	be 00 00 00 00       	mov    $0x0,%esi
  8006c0:	bf 12 00 00 00       	mov    $0x12,%edi
  8006c5:	48 b8 1d 01 80 00 00 	movabs $0x80011d,%rax
  8006cc:	00 00 00 
  8006cf:	ff d0                	callq  *%rax
  8006d1:	c9                   	leaveq 
  8006d2:	c3                   	retq   

00000000008006d3 <fd2num>:
  8006d3:	55                   	push   %rbp
  8006d4:	48 89 e5             	mov    %rsp,%rbp
  8006d7:	48 83 ec 08          	sub    $0x8,%rsp
  8006db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8006df:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8006e3:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8006ea:	ff ff ff 
  8006ed:	48 01 d0             	add    %rdx,%rax
  8006f0:	48 c1 e8 0c          	shr    $0xc,%rax
  8006f4:	c9                   	leaveq 
  8006f5:	c3                   	retq   

00000000008006f6 <fd2data>:
  8006f6:	55                   	push   %rbp
  8006f7:	48 89 e5             	mov    %rsp,%rbp
  8006fa:	48 83 ec 08          	sub    $0x8,%rsp
  8006fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  800702:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800706:	48 89 c7             	mov    %rax,%rdi
  800709:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  800710:	00 00 00 
  800713:	ff d0                	callq  *%rax
  800715:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  80071b:	48 c1 e0 0c          	shl    $0xc,%rax
  80071f:	c9                   	leaveq 
  800720:	c3                   	retq   

0000000000800721 <fd_alloc>:
  800721:	55                   	push   %rbp
  800722:	48 89 e5             	mov    %rsp,%rbp
  800725:	48 83 ec 18          	sub    $0x18,%rsp
  800729:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80072d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800734:	eb 6b                	jmp    8007a1 <fd_alloc+0x80>
  800736:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800739:	48 98                	cltq   
  80073b:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  800741:	48 c1 e0 0c          	shl    $0xc,%rax
  800745:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800749:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80074d:	48 c1 e8 15          	shr    $0x15,%rax
  800751:	48 89 c2             	mov    %rax,%rdx
  800754:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  80075b:	01 00 00 
  80075e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800762:	83 e0 01             	and    $0x1,%eax
  800765:	48 85 c0             	test   %rax,%rax
  800768:	74 21                	je     80078b <fd_alloc+0x6a>
  80076a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80076e:	48 c1 e8 0c          	shr    $0xc,%rax
  800772:	48 89 c2             	mov    %rax,%rdx
  800775:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80077c:	01 00 00 
  80077f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800783:	83 e0 01             	and    $0x1,%eax
  800786:	48 85 c0             	test   %rax,%rax
  800789:	75 12                	jne    80079d <fd_alloc+0x7c>
  80078b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80078f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800793:	48 89 10             	mov    %rdx,(%rax)
  800796:	b8 00 00 00 00       	mov    $0x0,%eax
  80079b:	eb 1a                	jmp    8007b7 <fd_alloc+0x96>
  80079d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8007a1:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  8007a5:	7e 8f                	jle    800736 <fd_alloc+0x15>
  8007a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8007ab:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8007b2:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  8007b7:	c9                   	leaveq 
  8007b8:	c3                   	retq   

00000000008007b9 <fd_lookup>:
  8007b9:	55                   	push   %rbp
  8007ba:	48 89 e5             	mov    %rsp,%rbp
  8007bd:	48 83 ec 20          	sub    $0x20,%rsp
  8007c1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8007c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8007c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8007cc:	78 06                	js     8007d4 <fd_lookup+0x1b>
  8007ce:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  8007d2:	7e 07                	jle    8007db <fd_lookup+0x22>
  8007d4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8007d9:	eb 6c                	jmp    800847 <fd_lookup+0x8e>
  8007db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8007de:	48 98                	cltq   
  8007e0:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8007e6:	48 c1 e0 0c          	shl    $0xc,%rax
  8007ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8007ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8007f2:	48 c1 e8 15          	shr    $0x15,%rax
  8007f6:	48 89 c2             	mov    %rax,%rdx
  8007f9:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  800800:	01 00 00 
  800803:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800807:	83 e0 01             	and    $0x1,%eax
  80080a:	48 85 c0             	test   %rax,%rax
  80080d:	74 21                	je     800830 <fd_lookup+0x77>
  80080f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800813:	48 c1 e8 0c          	shr    $0xc,%rax
  800817:	48 89 c2             	mov    %rax,%rdx
  80081a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  800821:	01 00 00 
  800824:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800828:	83 e0 01             	and    $0x1,%eax
  80082b:	48 85 c0             	test   %rax,%rax
  80082e:	75 07                	jne    800837 <fd_lookup+0x7e>
  800830:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800835:	eb 10                	jmp    800847 <fd_lookup+0x8e>
  800837:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80083b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80083f:	48 89 10             	mov    %rdx,(%rax)
  800842:	b8 00 00 00 00       	mov    $0x0,%eax
  800847:	c9                   	leaveq 
  800848:	c3                   	retq   

0000000000800849 <fd_close>:
  800849:	55                   	push   %rbp
  80084a:	48 89 e5             	mov    %rsp,%rbp
  80084d:	48 83 ec 30          	sub    $0x30,%rsp
  800851:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  800855:	89 f0                	mov    %esi,%eax
  800857:	88 45 d4             	mov    %al,-0x2c(%rbp)
  80085a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80085e:	48 89 c7             	mov    %rax,%rdi
  800861:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  800868:	00 00 00 
  80086b:	ff d0                	callq  *%rax
  80086d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800871:	48 89 d6             	mov    %rdx,%rsi
  800874:	89 c7                	mov    %eax,%edi
  800876:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  80087d:	00 00 00 
  800880:	ff d0                	callq  *%rax
  800882:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800885:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800889:	78 0a                	js     800895 <fd_close+0x4c>
  80088b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80088f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  800893:	74 12                	je     8008a7 <fd_close+0x5e>
  800895:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  800899:	74 05                	je     8008a0 <fd_close+0x57>
  80089b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80089e:	eb 05                	jmp    8008a5 <fd_close+0x5c>
  8008a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8008a5:	eb 69                	jmp    800910 <fd_close+0xc7>
  8008a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008ab:	8b 00                	mov    (%rax),%eax
  8008ad:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8008b1:	48 89 d6             	mov    %rdx,%rsi
  8008b4:	89 c7                	mov    %eax,%edi
  8008b6:	48 b8 12 09 80 00 00 	movabs $0x800912,%rax
  8008bd:	00 00 00 
  8008c0:	ff d0                	callq  *%rax
  8008c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8008c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8008c9:	78 2a                	js     8008f5 <fd_close+0xac>
  8008cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008cf:	48 8b 40 20          	mov    0x20(%rax),%rax
  8008d3:	48 85 c0             	test   %rax,%rax
  8008d6:	74 16                	je     8008ee <fd_close+0xa5>
  8008d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8008dc:	48 8b 40 20          	mov    0x20(%rax),%rax
  8008e0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8008e4:	48 89 d7             	mov    %rdx,%rdi
  8008e7:	ff d0                	callq  *%rax
  8008e9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8008ec:	eb 07                	jmp    8008f5 <fd_close+0xac>
  8008ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8008f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8008f9:	48 89 c6             	mov    %rax,%rsi
  8008fc:	bf 00 00 00 00       	mov    $0x0,%edi
  800901:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  800908:	00 00 00 
  80090b:	ff d0                	callq  *%rax
  80090d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800910:	c9                   	leaveq 
  800911:	c3                   	retq   

0000000000800912 <dev_lookup>:
  800912:	55                   	push   %rbp
  800913:	48 89 e5             	mov    %rsp,%rbp
  800916:	48 83 ec 20          	sub    $0x20,%rsp
  80091a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80091d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800921:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800928:	eb 41                	jmp    80096b <dev_lookup+0x59>
  80092a:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  800931:	00 00 00 
  800934:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800937:	48 63 d2             	movslq %edx,%rdx
  80093a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80093e:	8b 00                	mov    (%rax),%eax
  800940:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  800943:	75 22                	jne    800967 <dev_lookup+0x55>
  800945:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  80094c:	00 00 00 
  80094f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800952:	48 63 d2             	movslq %edx,%rdx
  800955:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  800959:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80095d:	48 89 10             	mov    %rdx,(%rax)
  800960:	b8 00 00 00 00       	mov    $0x0,%eax
  800965:	eb 60                	jmp    8009c7 <dev_lookup+0xb5>
  800967:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80096b:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  800972:	00 00 00 
  800975:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800978:	48 63 d2             	movslq %edx,%rdx
  80097b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  80097f:	48 85 c0             	test   %rax,%rax
  800982:	75 a6                	jne    80092a <dev_lookup+0x18>
  800984:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80098b:	00 00 00 
  80098e:	48 8b 00             	mov    (%rax),%rax
  800991:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800997:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80099a:	89 c6                	mov    %eax,%esi
  80099c:	48 bf e0 3f 80 00 00 	movabs $0x803fe0,%rdi
  8009a3:	00 00 00 
  8009a6:	b8 00 00 00 00       	mov    $0x0,%eax
  8009ab:	48 b9 bf 29 80 00 00 	movabs $0x8029bf,%rcx
  8009b2:	00 00 00 
  8009b5:	ff d1                	callq  *%rcx
  8009b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8009bb:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  8009c2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8009c7:	c9                   	leaveq 
  8009c8:	c3                   	retq   

00000000008009c9 <close>:
  8009c9:	55                   	push   %rbp
  8009ca:	48 89 e5             	mov    %rsp,%rbp
  8009cd:	48 83 ec 20          	sub    $0x20,%rsp
  8009d1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8009d4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8009d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8009db:	48 89 d6             	mov    %rdx,%rsi
  8009de:	89 c7                	mov    %eax,%edi
  8009e0:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  8009e7:	00 00 00 
  8009ea:	ff d0                	callq  *%rax
  8009ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8009ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8009f3:	79 05                	jns    8009fa <close+0x31>
  8009f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8009f8:	eb 18                	jmp    800a12 <close+0x49>
  8009fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8009fe:	be 01 00 00 00       	mov    $0x1,%esi
  800a03:	48 89 c7             	mov    %rax,%rdi
  800a06:	48 b8 49 08 80 00 00 	movabs $0x800849,%rax
  800a0d:	00 00 00 
  800a10:	ff d0                	callq  *%rax
  800a12:	c9                   	leaveq 
  800a13:	c3                   	retq   

0000000000800a14 <close_all>:
  800a14:	55                   	push   %rbp
  800a15:	48 89 e5             	mov    %rsp,%rbp
  800a18:	48 83 ec 10          	sub    $0x10,%rsp
  800a1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800a23:	eb 15                	jmp    800a3a <close_all+0x26>
  800a25:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800a28:	89 c7                	mov    %eax,%edi
  800a2a:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  800a31:	00 00 00 
  800a34:	ff d0                	callq  *%rax
  800a36:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800a3a:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  800a3e:	7e e5                	jle    800a25 <close_all+0x11>
  800a40:	c9                   	leaveq 
  800a41:	c3                   	retq   

0000000000800a42 <dup>:
  800a42:	55                   	push   %rbp
  800a43:	48 89 e5             	mov    %rsp,%rbp
  800a46:	48 83 ec 40          	sub    $0x40,%rsp
  800a4a:	89 7d cc             	mov    %edi,-0x34(%rbp)
  800a4d:	89 75 c8             	mov    %esi,-0x38(%rbp)
  800a50:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  800a54:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800a57:	48 89 d6             	mov    %rdx,%rsi
  800a5a:	89 c7                	mov    %eax,%edi
  800a5c:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800a63:	00 00 00 
  800a66:	ff d0                	callq  *%rax
  800a68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800a6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800a6f:	79 08                	jns    800a79 <dup+0x37>
  800a71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800a74:	e9 70 01 00 00       	jmpq   800be9 <dup+0x1a7>
  800a79:	8b 45 c8             	mov    -0x38(%rbp),%eax
  800a7c:	89 c7                	mov    %eax,%edi
  800a7e:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  800a85:	00 00 00 
  800a88:	ff d0                	callq  *%rax
  800a8a:	8b 45 c8             	mov    -0x38(%rbp),%eax
  800a8d:	48 98                	cltq   
  800a8f:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  800a95:	48 c1 e0 0c          	shl    $0xc,%rax
  800a99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  800a9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800aa1:	48 89 c7             	mov    %rax,%rdi
  800aa4:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  800aab:	00 00 00 
  800aae:	ff d0                	callq  *%rax
  800ab0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800ab4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ab8:	48 89 c7             	mov    %rax,%rdi
  800abb:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  800ac2:	00 00 00 
  800ac5:	ff d0                	callq  *%rax
  800ac7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800acb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800acf:	48 c1 e8 15          	shr    $0x15,%rax
  800ad3:	48 89 c2             	mov    %rax,%rdx
  800ad6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  800add:	01 00 00 
  800ae0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800ae4:	83 e0 01             	and    $0x1,%eax
  800ae7:	48 85 c0             	test   %rax,%rax
  800aea:	74 73                	je     800b5f <dup+0x11d>
  800aec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800af0:	48 c1 e8 0c          	shr    $0xc,%rax
  800af4:	48 89 c2             	mov    %rax,%rdx
  800af7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  800afe:	01 00 00 
  800b01:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800b05:	83 e0 01             	and    $0x1,%eax
  800b08:	48 85 c0             	test   %rax,%rax
  800b0b:	74 52                	je     800b5f <dup+0x11d>
  800b0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b11:	48 c1 e8 0c          	shr    $0xc,%rax
  800b15:	48 89 c2             	mov    %rax,%rdx
  800b18:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  800b1f:	01 00 00 
  800b22:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800b26:	25 07 0e 00 00       	and    $0xe07,%eax
  800b2b:	89 c1                	mov    %eax,%ecx
  800b2d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800b31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b35:	41 89 c8             	mov    %ecx,%r8d
  800b38:	48 89 d1             	mov    %rdx,%rcx
  800b3b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b40:	48 89 c6             	mov    %rax,%rsi
  800b43:	bf 00 00 00 00       	mov    $0x0,%edi
  800b48:	48 b8 43 03 80 00 00 	movabs $0x800343,%rax
  800b4f:	00 00 00 
  800b52:	ff d0                	callq  *%rax
  800b54:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800b57:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800b5b:	79 02                	jns    800b5f <dup+0x11d>
  800b5d:	eb 57                	jmp    800bb6 <dup+0x174>
  800b5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800b63:	48 c1 e8 0c          	shr    $0xc,%rax
  800b67:	48 89 c2             	mov    %rax,%rdx
  800b6a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  800b71:	01 00 00 
  800b74:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  800b78:	25 07 0e 00 00       	and    $0xe07,%eax
  800b7d:	89 c1                	mov    %eax,%ecx
  800b7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800b83:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800b87:	41 89 c8             	mov    %ecx,%r8d
  800b8a:	48 89 d1             	mov    %rdx,%rcx
  800b8d:	ba 00 00 00 00       	mov    $0x0,%edx
  800b92:	48 89 c6             	mov    %rax,%rsi
  800b95:	bf 00 00 00 00       	mov    $0x0,%edi
  800b9a:	48 b8 43 03 80 00 00 	movabs $0x800343,%rax
  800ba1:	00 00 00 
  800ba4:	ff d0                	callq  *%rax
  800ba6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800ba9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800bad:	79 02                	jns    800bb1 <dup+0x16f>
  800baf:	eb 05                	jmp    800bb6 <dup+0x174>
  800bb1:	8b 45 c8             	mov    -0x38(%rbp),%eax
  800bb4:	eb 33                	jmp    800be9 <dup+0x1a7>
  800bb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800bba:	48 89 c6             	mov    %rax,%rsi
  800bbd:	bf 00 00 00 00       	mov    $0x0,%edi
  800bc2:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  800bc9:	00 00 00 
  800bcc:	ff d0                	callq  *%rax
  800bce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800bd2:	48 89 c6             	mov    %rax,%rsi
  800bd5:	bf 00 00 00 00       	mov    $0x0,%edi
  800bda:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  800be1:	00 00 00 
  800be4:	ff d0                	callq  *%rax
  800be6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800be9:	c9                   	leaveq 
  800bea:	c3                   	retq   

0000000000800beb <read>:
  800beb:	55                   	push   %rbp
  800bec:	48 89 e5             	mov    %rsp,%rbp
  800bef:	48 83 ec 40          	sub    $0x40,%rsp
  800bf3:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800bf6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  800bfa:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  800bfe:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  800c02:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800c05:	48 89 d6             	mov    %rdx,%rsi
  800c08:	89 c7                	mov    %eax,%edi
  800c0a:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800c11:	00 00 00 
  800c14:	ff d0                	callq  *%rax
  800c16:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800c19:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800c1d:	78 24                	js     800c43 <read+0x58>
  800c1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c23:	8b 00                	mov    (%rax),%eax
  800c25:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800c29:	48 89 d6             	mov    %rdx,%rsi
  800c2c:	89 c7                	mov    %eax,%edi
  800c2e:	48 b8 12 09 80 00 00 	movabs $0x800912,%rax
  800c35:	00 00 00 
  800c38:	ff d0                	callq  *%rax
  800c3a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800c3d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800c41:	79 05                	jns    800c48 <read+0x5d>
  800c43:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800c46:	eb 76                	jmp    800cbe <read+0xd3>
  800c48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c4c:	8b 40 08             	mov    0x8(%rax),%eax
  800c4f:	83 e0 03             	and    $0x3,%eax
  800c52:	83 f8 01             	cmp    $0x1,%eax
  800c55:	75 3a                	jne    800c91 <read+0xa6>
  800c57:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800c5e:	00 00 00 
  800c61:	48 8b 00             	mov    (%rax),%rax
  800c64:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800c6a:	8b 55 dc             	mov    -0x24(%rbp),%edx
  800c6d:	89 c6                	mov    %eax,%esi
  800c6f:	48 bf ff 3f 80 00 00 	movabs $0x803fff,%rdi
  800c76:	00 00 00 
  800c79:	b8 00 00 00 00       	mov    $0x0,%eax
  800c7e:	48 b9 bf 29 80 00 00 	movabs $0x8029bf,%rcx
  800c85:	00 00 00 
  800c88:	ff d1                	callq  *%rcx
  800c8a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800c8f:	eb 2d                	jmp    800cbe <read+0xd3>
  800c91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800c95:	48 8b 40 10          	mov    0x10(%rax),%rax
  800c99:	48 85 c0             	test   %rax,%rax
  800c9c:	75 07                	jne    800ca5 <read+0xba>
  800c9e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  800ca3:	eb 19                	jmp    800cbe <read+0xd3>
  800ca5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ca9:	48 8b 40 10          	mov    0x10(%rax),%rax
  800cad:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  800cb1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800cb5:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  800cb9:	48 89 cf             	mov    %rcx,%rdi
  800cbc:	ff d0                	callq  *%rax
  800cbe:	c9                   	leaveq 
  800cbf:	c3                   	retq   

0000000000800cc0 <readn>:
  800cc0:	55                   	push   %rbp
  800cc1:	48 89 e5             	mov    %rsp,%rbp
  800cc4:	48 83 ec 30          	sub    $0x30,%rsp
  800cc8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800ccb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800ccf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800cd3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800cda:	eb 49                	jmp    800d25 <readn+0x65>
  800cdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800cdf:	48 98                	cltq   
  800ce1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  800ce5:	48 29 c2             	sub    %rax,%rdx
  800ce8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ceb:	48 63 c8             	movslq %eax,%rcx
  800cee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800cf2:	48 01 c1             	add    %rax,%rcx
  800cf5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800cf8:	48 89 ce             	mov    %rcx,%rsi
  800cfb:	89 c7                	mov    %eax,%edi
  800cfd:	48 b8 eb 0b 80 00 00 	movabs $0x800beb,%rax
  800d04:	00 00 00 
  800d07:	ff d0                	callq  *%rax
  800d09:	89 45 f8             	mov    %eax,-0x8(%rbp)
  800d0c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800d10:	79 05                	jns    800d17 <readn+0x57>
  800d12:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800d15:	eb 1c                	jmp    800d33 <readn+0x73>
  800d17:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  800d1b:	75 02                	jne    800d1f <readn+0x5f>
  800d1d:	eb 11                	jmp    800d30 <readn+0x70>
  800d1f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800d22:	01 45 fc             	add    %eax,-0x4(%rbp)
  800d25:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d28:	48 98                	cltq   
  800d2a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800d2e:	72 ac                	jb     800cdc <readn+0x1c>
  800d30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d33:	c9                   	leaveq 
  800d34:	c3                   	retq   

0000000000800d35 <write>:
  800d35:	55                   	push   %rbp
  800d36:	48 89 e5             	mov    %rsp,%rbp
  800d39:	48 83 ec 40          	sub    $0x40,%rsp
  800d3d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800d40:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  800d44:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  800d48:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  800d4c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800d4f:	48 89 d6             	mov    %rdx,%rsi
  800d52:	89 c7                	mov    %eax,%edi
  800d54:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800d5b:	00 00 00 
  800d5e:	ff d0                	callq  *%rax
  800d60:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800d63:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800d67:	78 24                	js     800d8d <write+0x58>
  800d69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d6d:	8b 00                	mov    (%rax),%eax
  800d6f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800d73:	48 89 d6             	mov    %rdx,%rsi
  800d76:	89 c7                	mov    %eax,%edi
  800d78:	48 b8 12 09 80 00 00 	movabs $0x800912,%rax
  800d7f:	00 00 00 
  800d82:	ff d0                	callq  *%rax
  800d84:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800d87:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800d8b:	79 05                	jns    800d92 <write+0x5d>
  800d8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800d90:	eb 75                	jmp    800e07 <write+0xd2>
  800d92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800d96:	8b 40 08             	mov    0x8(%rax),%eax
  800d99:	83 e0 03             	and    $0x3,%eax
  800d9c:	85 c0                	test   %eax,%eax
  800d9e:	75 3a                	jne    800dda <write+0xa5>
  800da0:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800da7:	00 00 00 
  800daa:	48 8b 00             	mov    (%rax),%rax
  800dad:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800db3:	8b 55 dc             	mov    -0x24(%rbp),%edx
  800db6:	89 c6                	mov    %eax,%esi
  800db8:	48 bf 1b 40 80 00 00 	movabs $0x80401b,%rdi
  800dbf:	00 00 00 
  800dc2:	b8 00 00 00 00       	mov    $0x0,%eax
  800dc7:	48 b9 bf 29 80 00 00 	movabs $0x8029bf,%rcx
  800dce:	00 00 00 
  800dd1:	ff d1                	callq  *%rcx
  800dd3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800dd8:	eb 2d                	jmp    800e07 <write+0xd2>
  800dda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800dde:	48 8b 40 18          	mov    0x18(%rax),%rax
  800de2:	48 85 c0             	test   %rax,%rax
  800de5:	75 07                	jne    800dee <write+0xb9>
  800de7:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  800dec:	eb 19                	jmp    800e07 <write+0xd2>
  800dee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800df2:	48 8b 40 18          	mov    0x18(%rax),%rax
  800df6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  800dfa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800dfe:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  800e02:	48 89 cf             	mov    %rcx,%rdi
  800e05:	ff d0                	callq  *%rax
  800e07:	c9                   	leaveq 
  800e08:	c3                   	retq   

0000000000800e09 <seek>:
  800e09:	55                   	push   %rbp
  800e0a:	48 89 e5             	mov    %rsp,%rbp
  800e0d:	48 83 ec 18          	sub    $0x18,%rsp
  800e11:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800e14:	89 75 e8             	mov    %esi,-0x18(%rbp)
  800e17:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800e1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800e1e:	48 89 d6             	mov    %rdx,%rsi
  800e21:	89 c7                	mov    %eax,%edi
  800e23:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800e2a:	00 00 00 
  800e2d:	ff d0                	callq  *%rax
  800e2f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800e32:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800e36:	79 05                	jns    800e3d <seek+0x34>
  800e38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800e3b:	eb 0f                	jmp    800e4c <seek+0x43>
  800e3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800e41:	8b 55 e8             	mov    -0x18(%rbp),%edx
  800e44:	89 50 04             	mov    %edx,0x4(%rax)
  800e47:	b8 00 00 00 00       	mov    $0x0,%eax
  800e4c:	c9                   	leaveq 
  800e4d:	c3                   	retq   

0000000000800e4e <ftruncate>:
  800e4e:	55                   	push   %rbp
  800e4f:	48 89 e5             	mov    %rsp,%rbp
  800e52:	48 83 ec 30          	sub    $0x30,%rsp
  800e56:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800e59:	89 75 d8             	mov    %esi,-0x28(%rbp)
  800e5c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  800e60:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800e63:	48 89 d6             	mov    %rdx,%rsi
  800e66:	89 c7                	mov    %eax,%edi
  800e68:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800e6f:	00 00 00 
  800e72:	ff d0                	callq  *%rax
  800e74:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800e77:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800e7b:	78 24                	js     800ea1 <ftruncate+0x53>
  800e7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800e81:	8b 00                	mov    (%rax),%eax
  800e83:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800e87:	48 89 d6             	mov    %rdx,%rsi
  800e8a:	89 c7                	mov    %eax,%edi
  800e8c:	48 b8 12 09 80 00 00 	movabs $0x800912,%rax
  800e93:	00 00 00 
  800e96:	ff d0                	callq  *%rax
  800e98:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800e9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800e9f:	79 05                	jns    800ea6 <ftruncate+0x58>
  800ea1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ea4:	eb 72                	jmp    800f18 <ftruncate+0xca>
  800ea6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800eaa:	8b 40 08             	mov    0x8(%rax),%eax
  800ead:	83 e0 03             	and    $0x3,%eax
  800eb0:	85 c0                	test   %eax,%eax
  800eb2:	75 3a                	jne    800eee <ftruncate+0xa0>
  800eb4:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800ebb:	00 00 00 
  800ebe:	48 8b 00             	mov    (%rax),%rax
  800ec1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  800ec7:	8b 55 dc             	mov    -0x24(%rbp),%edx
  800eca:	89 c6                	mov    %eax,%esi
  800ecc:	48 bf 38 40 80 00 00 	movabs $0x804038,%rdi
  800ed3:	00 00 00 
  800ed6:	b8 00 00 00 00       	mov    $0x0,%eax
  800edb:	48 b9 bf 29 80 00 00 	movabs $0x8029bf,%rcx
  800ee2:	00 00 00 
  800ee5:	ff d1                	callq  *%rcx
  800ee7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800eec:	eb 2a                	jmp    800f18 <ftruncate+0xca>
  800eee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800ef2:	48 8b 40 30          	mov    0x30(%rax),%rax
  800ef6:	48 85 c0             	test   %rax,%rax
  800ef9:	75 07                	jne    800f02 <ftruncate+0xb4>
  800efb:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  800f00:	eb 16                	jmp    800f18 <ftruncate+0xca>
  800f02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800f06:	48 8b 40 30          	mov    0x30(%rax),%rax
  800f0a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800f0e:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  800f11:	89 ce                	mov    %ecx,%esi
  800f13:	48 89 d7             	mov    %rdx,%rdi
  800f16:	ff d0                	callq  *%rax
  800f18:	c9                   	leaveq 
  800f19:	c3                   	retq   

0000000000800f1a <fstat>:
  800f1a:	55                   	push   %rbp
  800f1b:	48 89 e5             	mov    %rsp,%rbp
  800f1e:	48 83 ec 30          	sub    $0x30,%rsp
  800f22:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800f25:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  800f29:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  800f2d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800f30:	48 89 d6             	mov    %rdx,%rsi
  800f33:	89 c7                	mov    %eax,%edi
  800f35:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  800f3c:	00 00 00 
  800f3f:	ff d0                	callq  *%rax
  800f41:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800f44:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800f48:	78 24                	js     800f6e <fstat+0x54>
  800f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f4e:	8b 00                	mov    (%rax),%eax
  800f50:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  800f54:	48 89 d6             	mov    %rdx,%rsi
  800f57:	89 c7                	mov    %eax,%edi
  800f59:	48 b8 12 09 80 00 00 	movabs $0x800912,%rax
  800f60:	00 00 00 
  800f63:	ff d0                	callq  *%rax
  800f65:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800f68:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800f6c:	79 05                	jns    800f73 <fstat+0x59>
  800f6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f71:	eb 5e                	jmp    800fd1 <fstat+0xb7>
  800f73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800f77:	48 8b 40 28          	mov    0x28(%rax),%rax
  800f7b:	48 85 c0             	test   %rax,%rax
  800f7e:	75 07                	jne    800f87 <fstat+0x6d>
  800f80:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  800f85:	eb 4a                	jmp    800fd1 <fstat+0xb7>
  800f87:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800f8b:	c6 00 00             	movb   $0x0,(%rax)
  800f8e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800f92:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  800f99:	00 00 00 
  800f9c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800fa0:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  800fa7:	00 00 00 
  800faa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800fae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800fb2:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  800fb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800fbd:	48 8b 40 28          	mov    0x28(%rax),%rax
  800fc1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800fc5:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  800fc9:	48 89 ce             	mov    %rcx,%rsi
  800fcc:	48 89 d7             	mov    %rdx,%rdi
  800fcf:	ff d0                	callq  *%rax
  800fd1:	c9                   	leaveq 
  800fd2:	c3                   	retq   

0000000000800fd3 <stat>:
  800fd3:	55                   	push   %rbp
  800fd4:	48 89 e5             	mov    %rsp,%rbp
  800fd7:	48 83 ec 20          	sub    $0x20,%rsp
  800fdb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fe3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fe7:	be 00 00 00 00       	mov    $0x0,%esi
  800fec:	48 89 c7             	mov    %rax,%rdi
  800fef:	48 b8 c1 10 80 00 00 	movabs $0x8010c1,%rax
  800ff6:	00 00 00 
  800ff9:	ff d0                	callq  *%rax
  800ffb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800ffe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801002:	79 05                	jns    801009 <stat+0x36>
  801004:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801007:	eb 2f                	jmp    801038 <stat+0x65>
  801009:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80100d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801010:	48 89 d6             	mov    %rdx,%rsi
  801013:	89 c7                	mov    %eax,%edi
  801015:	48 b8 1a 0f 80 00 00 	movabs $0x800f1a,%rax
  80101c:	00 00 00 
  80101f:	ff d0                	callq  *%rax
  801021:	89 45 f8             	mov    %eax,-0x8(%rbp)
  801024:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801027:	89 c7                	mov    %eax,%edi
  801029:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  801030:	00 00 00 
  801033:	ff d0                	callq  *%rax
  801035:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801038:	c9                   	leaveq 
  801039:	c3                   	retq   

000000000080103a <fsipc>:
  80103a:	55                   	push   %rbp
  80103b:	48 89 e5             	mov    %rsp,%rbp
  80103e:	48 83 ec 10          	sub    $0x10,%rsp
  801042:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801045:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801049:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  801050:	00 00 00 
  801053:	8b 00                	mov    (%rax),%eax
  801055:	85 c0                	test   %eax,%eax
  801057:	75 1d                	jne    801076 <fsipc+0x3c>
  801059:	bf 01 00 00 00       	mov    $0x1,%edi
  80105e:	48 b8 99 3e 80 00 00 	movabs $0x803e99,%rax
  801065:	00 00 00 
  801068:	ff d0                	callq  *%rax
  80106a:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  801071:	00 00 00 
  801074:	89 02                	mov    %eax,(%rdx)
  801076:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80107d:	00 00 00 
  801080:	8b 00                	mov    (%rax),%eax
  801082:	8b 75 fc             	mov    -0x4(%rbp),%esi
  801085:	b9 07 00 00 00       	mov    $0x7,%ecx
  80108a:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  801091:	00 00 00 
  801094:	89 c7                	mov    %eax,%edi
  801096:	48 b8 8e 3d 80 00 00 	movabs $0x803d8e,%rax
  80109d:	00 00 00 
  8010a0:	ff d0                	callq  *%rax
  8010a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8010a6:	ba 00 00 00 00       	mov    $0x0,%edx
  8010ab:	48 89 c6             	mov    %rax,%rsi
  8010ae:	bf 00 00 00 00       	mov    $0x0,%edi
  8010b3:	48 b8 cd 3c 80 00 00 	movabs $0x803ccd,%rax
  8010ba:	00 00 00 
  8010bd:	ff d0                	callq  *%rax
  8010bf:	c9                   	leaveq 
  8010c0:	c3                   	retq   

00000000008010c1 <open>:
  8010c1:	55                   	push   %rbp
  8010c2:	48 89 e5             	mov    %rsp,%rbp
  8010c5:	48 83 ec 20          	sub    $0x20,%rsp
  8010c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8010cd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  8010d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010d4:	48 89 c7             	mov    %rax,%rdi
  8010d7:	48 b8 08 35 80 00 00 	movabs $0x803508,%rax
  8010de:	00 00 00 
  8010e1:	ff d0                	callq  *%rax
  8010e3:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8010e8:	7e 0a                	jle    8010f4 <open+0x33>
  8010ea:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8010ef:	e9 a5 00 00 00       	jmpq   801199 <open+0xd8>
  8010f4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8010f8:	48 89 c7             	mov    %rax,%rdi
  8010fb:	48 b8 21 07 80 00 00 	movabs $0x800721,%rax
  801102:	00 00 00 
  801105:	ff d0                	callq  *%rax
  801107:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80110a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80110e:	79 08                	jns    801118 <open+0x57>
  801110:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801113:	e9 81 00 00 00       	jmpq   801199 <open+0xd8>
  801118:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80111c:	48 89 c6             	mov    %rax,%rsi
  80111f:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  801126:	00 00 00 
  801129:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  801130:	00 00 00 
  801133:	ff d0                	callq  *%rax
  801135:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80113c:	00 00 00 
  80113f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  801142:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  801148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80114c:	48 89 c6             	mov    %rax,%rsi
  80114f:	bf 01 00 00 00       	mov    $0x1,%edi
  801154:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  80115b:	00 00 00 
  80115e:	ff d0                	callq  *%rax
  801160:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801163:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801167:	79 1d                	jns    801186 <open+0xc5>
  801169:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80116d:	be 00 00 00 00       	mov    $0x0,%esi
  801172:	48 89 c7             	mov    %rax,%rdi
  801175:	48 b8 49 08 80 00 00 	movabs $0x800849,%rax
  80117c:	00 00 00 
  80117f:	ff d0                	callq  *%rax
  801181:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801184:	eb 13                	jmp    801199 <open+0xd8>
  801186:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80118a:	48 89 c7             	mov    %rax,%rdi
  80118d:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  801194:	00 00 00 
  801197:	ff d0                	callq  *%rax
  801199:	c9                   	leaveq 
  80119a:	c3                   	retq   

000000000080119b <devfile_flush>:
  80119b:	55                   	push   %rbp
  80119c:	48 89 e5             	mov    %rsp,%rbp
  80119f:	48 83 ec 10          	sub    $0x10,%rsp
  8011a3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011ab:	8b 50 0c             	mov    0xc(%rax),%edx
  8011ae:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8011b5:	00 00 00 
  8011b8:	89 10                	mov    %edx,(%rax)
  8011ba:	be 00 00 00 00       	mov    $0x0,%esi
  8011bf:	bf 06 00 00 00       	mov    $0x6,%edi
  8011c4:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  8011cb:	00 00 00 
  8011ce:	ff d0                	callq  *%rax
  8011d0:	c9                   	leaveq 
  8011d1:	c3                   	retq   

00000000008011d2 <devfile_read>:
  8011d2:	55                   	push   %rbp
  8011d3:	48 89 e5             	mov    %rsp,%rbp
  8011d6:	48 83 ec 30          	sub    $0x30,%rsp
  8011da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8011de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8011e2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8011e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8011ea:	8b 50 0c             	mov    0xc(%rax),%edx
  8011ed:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8011f4:	00 00 00 
  8011f7:	89 10                	mov    %edx,(%rax)
  8011f9:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801200:	00 00 00 
  801203:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801207:	48 89 50 08          	mov    %rdx,0x8(%rax)
  80120b:	be 00 00 00 00       	mov    $0x0,%esi
  801210:	bf 03 00 00 00       	mov    $0x3,%edi
  801215:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  80121c:	00 00 00 
  80121f:	ff d0                	callq  *%rax
  801221:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801224:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801228:	79 08                	jns    801232 <devfile_read+0x60>
  80122a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80122d:	e9 a4 00 00 00       	jmpq   8012d6 <devfile_read+0x104>
  801232:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801235:	48 98                	cltq   
  801237:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80123b:	76 35                	jbe    801272 <devfile_read+0xa0>
  80123d:	48 b9 5e 40 80 00 00 	movabs $0x80405e,%rcx
  801244:	00 00 00 
  801247:	48 ba 65 40 80 00 00 	movabs $0x804065,%rdx
  80124e:	00 00 00 
  801251:	be 89 00 00 00       	mov    $0x89,%esi
  801256:	48 bf 7a 40 80 00 00 	movabs $0x80407a,%rdi
  80125d:	00 00 00 
  801260:	b8 00 00 00 00       	mov    $0x0,%eax
  801265:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  80126c:	00 00 00 
  80126f:	41 ff d0             	callq  *%r8
  801272:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  801279:	7e 35                	jle    8012b0 <devfile_read+0xde>
  80127b:	48 b9 88 40 80 00 00 	movabs $0x804088,%rcx
  801282:	00 00 00 
  801285:	48 ba 65 40 80 00 00 	movabs $0x804065,%rdx
  80128c:	00 00 00 
  80128f:	be 8a 00 00 00       	mov    $0x8a,%esi
  801294:	48 bf 7a 40 80 00 00 	movabs $0x80407a,%rdi
  80129b:	00 00 00 
  80129e:	b8 00 00 00 00       	mov    $0x0,%eax
  8012a3:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  8012aa:	00 00 00 
  8012ad:	41 ff d0             	callq  *%r8
  8012b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8012b3:	48 63 d0             	movslq %eax,%rdx
  8012b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012ba:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  8012c1:	00 00 00 
  8012c4:	48 89 c7             	mov    %rax,%rdi
  8012c7:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  8012ce:	00 00 00 
  8012d1:	ff d0                	callq  *%rax
  8012d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8012d6:	c9                   	leaveq 
  8012d7:	c3                   	retq   

00000000008012d8 <devfile_write>:
  8012d8:	55                   	push   %rbp
  8012d9:	48 89 e5             	mov    %rsp,%rbp
  8012dc:	48 83 ec 40          	sub    $0x40,%rsp
  8012e0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8012e4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8012e8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8012ec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8012f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012f4:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8012fb:	00 
  8012fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801300:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  801304:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  801309:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  80130d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801311:	8b 50 0c             	mov    0xc(%rax),%edx
  801314:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80131b:	00 00 00 
  80131e:	89 10                	mov    %edx,(%rax)
  801320:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801327:	00 00 00 
  80132a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80132e:	48 89 50 08          	mov    %rdx,0x8(%rax)
  801332:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801336:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80133a:	48 89 c6             	mov    %rax,%rsi
  80133d:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  801344:	00 00 00 
  801347:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  80134e:	00 00 00 
  801351:	ff d0                	callq  *%rax
  801353:	be 00 00 00 00       	mov    $0x0,%esi
  801358:	bf 04 00 00 00       	mov    $0x4,%edi
  80135d:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  801364:	00 00 00 
  801367:	ff d0                	callq  *%rax
  801369:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80136c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801370:	79 05                	jns    801377 <devfile_write+0x9f>
  801372:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801375:	eb 43                	jmp    8013ba <devfile_write+0xe2>
  801377:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80137a:	48 98                	cltq   
  80137c:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  801380:	76 35                	jbe    8013b7 <devfile_write+0xdf>
  801382:	48 b9 5e 40 80 00 00 	movabs $0x80405e,%rcx
  801389:	00 00 00 
  80138c:	48 ba 65 40 80 00 00 	movabs $0x804065,%rdx
  801393:	00 00 00 
  801396:	be a8 00 00 00       	mov    $0xa8,%esi
  80139b:	48 bf 7a 40 80 00 00 	movabs $0x80407a,%rdi
  8013a2:	00 00 00 
  8013a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8013aa:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  8013b1:	00 00 00 
  8013b4:	41 ff d0             	callq  *%r8
  8013b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8013ba:	c9                   	leaveq 
  8013bb:	c3                   	retq   

00000000008013bc <devfile_stat>:
  8013bc:	55                   	push   %rbp
  8013bd:	48 89 e5             	mov    %rsp,%rbp
  8013c0:	48 83 ec 20          	sub    $0x20,%rsp
  8013c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013c8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8013cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013d0:	8b 50 0c             	mov    0xc(%rax),%edx
  8013d3:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8013da:	00 00 00 
  8013dd:	89 10                	mov    %edx,(%rax)
  8013df:	be 00 00 00 00       	mov    $0x0,%esi
  8013e4:	bf 05 00 00 00       	mov    $0x5,%edi
  8013e9:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  8013f0:	00 00 00 
  8013f3:	ff d0                	callq  *%rax
  8013f5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8013f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8013fc:	79 05                	jns    801403 <devfile_stat+0x47>
  8013fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801401:	eb 56                	jmp    801459 <devfile_stat+0x9d>
  801403:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801407:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  80140e:	00 00 00 
  801411:	48 89 c7             	mov    %rax,%rdi
  801414:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  80141b:	00 00 00 
  80141e:	ff d0                	callq  *%rax
  801420:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801427:	00 00 00 
  80142a:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  801430:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801434:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80143a:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801441:	00 00 00 
  801444:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  80144a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80144e:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  801454:	b8 00 00 00 00       	mov    $0x0,%eax
  801459:	c9                   	leaveq 
  80145a:	c3                   	retq   

000000000080145b <devfile_trunc>:
  80145b:	55                   	push   %rbp
  80145c:	48 89 e5             	mov    %rsp,%rbp
  80145f:	48 83 ec 10          	sub    $0x10,%rsp
  801463:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801467:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80146a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80146e:	8b 50 0c             	mov    0xc(%rax),%edx
  801471:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801478:	00 00 00 
  80147b:	89 10                	mov    %edx,(%rax)
  80147d:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  801484:	00 00 00 
  801487:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80148a:	89 50 04             	mov    %edx,0x4(%rax)
  80148d:	be 00 00 00 00       	mov    $0x0,%esi
  801492:	bf 02 00 00 00       	mov    $0x2,%edi
  801497:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  80149e:	00 00 00 
  8014a1:	ff d0                	callq  *%rax
  8014a3:	c9                   	leaveq 
  8014a4:	c3                   	retq   

00000000008014a5 <remove>:
  8014a5:	55                   	push   %rbp
  8014a6:	48 89 e5             	mov    %rsp,%rbp
  8014a9:	48 83 ec 10          	sub    $0x10,%rsp
  8014ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8014b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014b5:	48 89 c7             	mov    %rax,%rdi
  8014b8:	48 b8 08 35 80 00 00 	movabs $0x803508,%rax
  8014bf:	00 00 00 
  8014c2:	ff d0                	callq  *%rax
  8014c4:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8014c9:	7e 07                	jle    8014d2 <remove+0x2d>
  8014cb:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8014d0:	eb 33                	jmp    801505 <remove+0x60>
  8014d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8014d6:	48 89 c6             	mov    %rax,%rsi
  8014d9:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  8014e0:	00 00 00 
  8014e3:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  8014ea:	00 00 00 
  8014ed:	ff d0                	callq  *%rax
  8014ef:	be 00 00 00 00       	mov    $0x0,%esi
  8014f4:	bf 07 00 00 00       	mov    $0x7,%edi
  8014f9:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  801500:	00 00 00 
  801503:	ff d0                	callq  *%rax
  801505:	c9                   	leaveq 
  801506:	c3                   	retq   

0000000000801507 <sync>:
  801507:	55                   	push   %rbp
  801508:	48 89 e5             	mov    %rsp,%rbp
  80150b:	be 00 00 00 00       	mov    $0x0,%esi
  801510:	bf 08 00 00 00       	mov    $0x8,%edi
  801515:	48 b8 3a 10 80 00 00 	movabs $0x80103a,%rax
  80151c:	00 00 00 
  80151f:	ff d0                	callq  *%rax
  801521:	5d                   	pop    %rbp
  801522:	c3                   	retq   

0000000000801523 <copy>:
  801523:	55                   	push   %rbp
  801524:	48 89 e5             	mov    %rsp,%rbp
  801527:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  80152e:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  801535:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  80153c:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  801543:	be 00 00 00 00       	mov    $0x0,%esi
  801548:	48 89 c7             	mov    %rax,%rdi
  80154b:	48 b8 c1 10 80 00 00 	movabs $0x8010c1,%rax
  801552:	00 00 00 
  801555:	ff d0                	callq  *%rax
  801557:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80155a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80155e:	79 28                	jns    801588 <copy+0x65>
  801560:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801563:	89 c6                	mov    %eax,%esi
  801565:	48 bf 94 40 80 00 00 	movabs $0x804094,%rdi
  80156c:	00 00 00 
  80156f:	b8 00 00 00 00       	mov    $0x0,%eax
  801574:	48 ba bf 29 80 00 00 	movabs $0x8029bf,%rdx
  80157b:	00 00 00 
  80157e:	ff d2                	callq  *%rdx
  801580:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801583:	e9 74 01 00 00       	jmpq   8016fc <copy+0x1d9>
  801588:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  80158f:	be 01 01 00 00       	mov    $0x101,%esi
  801594:	48 89 c7             	mov    %rax,%rdi
  801597:	48 b8 c1 10 80 00 00 	movabs $0x8010c1,%rax
  80159e:	00 00 00 
  8015a1:	ff d0                	callq  *%rax
  8015a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8015a6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8015aa:	79 39                	jns    8015e5 <copy+0xc2>
  8015ac:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8015af:	89 c6                	mov    %eax,%esi
  8015b1:	48 bf aa 40 80 00 00 	movabs $0x8040aa,%rdi
  8015b8:	00 00 00 
  8015bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8015c0:	48 ba bf 29 80 00 00 	movabs $0x8029bf,%rdx
  8015c7:	00 00 00 
  8015ca:	ff d2                	callq  *%rdx
  8015cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8015cf:	89 c7                	mov    %eax,%edi
  8015d1:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  8015d8:	00 00 00 
  8015db:	ff d0                	callq  *%rax
  8015dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8015e0:	e9 17 01 00 00       	jmpq   8016fc <copy+0x1d9>
  8015e5:	eb 74                	jmp    80165b <copy+0x138>
  8015e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8015ea:	48 63 d0             	movslq %eax,%rdx
  8015ed:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8015f4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8015f7:	48 89 ce             	mov    %rcx,%rsi
  8015fa:	89 c7                	mov    %eax,%edi
  8015fc:	48 b8 35 0d 80 00 00 	movabs $0x800d35,%rax
  801603:	00 00 00 
  801606:	ff d0                	callq  *%rax
  801608:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80160b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80160f:	79 4a                	jns    80165b <copy+0x138>
  801611:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801614:	89 c6                	mov    %eax,%esi
  801616:	48 bf c4 40 80 00 00 	movabs $0x8040c4,%rdi
  80161d:	00 00 00 
  801620:	b8 00 00 00 00       	mov    $0x0,%eax
  801625:	48 ba bf 29 80 00 00 	movabs $0x8029bf,%rdx
  80162c:	00 00 00 
  80162f:	ff d2                	callq  *%rdx
  801631:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801634:	89 c7                	mov    %eax,%edi
  801636:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  80163d:	00 00 00 
  801640:	ff d0                	callq  *%rax
  801642:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801645:	89 c7                	mov    %eax,%edi
  801647:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  80164e:	00 00 00 
  801651:	ff d0                	callq  *%rax
  801653:	8b 45 f0             	mov    -0x10(%rbp),%eax
  801656:	e9 a1 00 00 00       	jmpq   8016fc <copy+0x1d9>
  80165b:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  801662:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801665:	ba 00 02 00 00       	mov    $0x200,%edx
  80166a:	48 89 ce             	mov    %rcx,%rsi
  80166d:	89 c7                	mov    %eax,%edi
  80166f:	48 b8 eb 0b 80 00 00 	movabs $0x800beb,%rax
  801676:	00 00 00 
  801679:	ff d0                	callq  *%rax
  80167b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80167e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  801682:	0f 8f 5f ff ff ff    	jg     8015e7 <copy+0xc4>
  801688:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80168c:	79 47                	jns    8016d5 <copy+0x1b2>
  80168e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801691:	89 c6                	mov    %eax,%esi
  801693:	48 bf d7 40 80 00 00 	movabs $0x8040d7,%rdi
  80169a:	00 00 00 
  80169d:	b8 00 00 00 00       	mov    $0x0,%eax
  8016a2:	48 ba bf 29 80 00 00 	movabs $0x8029bf,%rdx
  8016a9:	00 00 00 
  8016ac:	ff d2                	callq  *%rdx
  8016ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8016b1:	89 c7                	mov    %eax,%edi
  8016b3:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  8016ba:	00 00 00 
  8016bd:	ff d0                	callq  *%rax
  8016bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8016c2:	89 c7                	mov    %eax,%edi
  8016c4:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  8016cb:	00 00 00 
  8016ce:	ff d0                	callq  *%rax
  8016d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8016d3:	eb 27                	jmp    8016fc <copy+0x1d9>
  8016d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8016d8:	89 c7                	mov    %eax,%edi
  8016da:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  8016e1:	00 00 00 
  8016e4:	ff d0                	callq  *%rax
  8016e6:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8016e9:	89 c7                	mov    %eax,%edi
  8016eb:	48 b8 c9 09 80 00 00 	movabs $0x8009c9,%rax
  8016f2:	00 00 00 
  8016f5:	ff d0                	callq  *%rax
  8016f7:	b8 00 00 00 00       	mov    $0x0,%eax
  8016fc:	c9                   	leaveq 
  8016fd:	c3                   	retq   

00000000008016fe <fd2sockid>:
  8016fe:	55                   	push   %rbp
  8016ff:	48 89 e5             	mov    %rsp,%rbp
  801702:	48 83 ec 20          	sub    $0x20,%rsp
  801706:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801709:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  80170d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801710:	48 89 d6             	mov    %rdx,%rsi
  801713:	89 c7                	mov    %eax,%edi
  801715:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  80171c:	00 00 00 
  80171f:	ff d0                	callq  *%rax
  801721:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801724:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801728:	79 05                	jns    80172f <fd2sockid+0x31>
  80172a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80172d:	eb 24                	jmp    801753 <fd2sockid+0x55>
  80172f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801733:	8b 10                	mov    (%rax),%edx
  801735:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  80173c:	00 00 00 
  80173f:	8b 00                	mov    (%rax),%eax
  801741:	39 c2                	cmp    %eax,%edx
  801743:	74 07                	je     80174c <fd2sockid+0x4e>
  801745:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  80174a:	eb 07                	jmp    801753 <fd2sockid+0x55>
  80174c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801750:	8b 40 0c             	mov    0xc(%rax),%eax
  801753:	c9                   	leaveq 
  801754:	c3                   	retq   

0000000000801755 <alloc_sockfd>:
  801755:	55                   	push   %rbp
  801756:	48 89 e5             	mov    %rsp,%rbp
  801759:	48 83 ec 20          	sub    $0x20,%rsp
  80175d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801760:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  801764:	48 89 c7             	mov    %rax,%rdi
  801767:	48 b8 21 07 80 00 00 	movabs $0x800721,%rax
  80176e:	00 00 00 
  801771:	ff d0                	callq  *%rax
  801773:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801776:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80177a:	78 26                	js     8017a2 <alloc_sockfd+0x4d>
  80177c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801780:	ba 07 04 00 00       	mov    $0x407,%edx
  801785:	48 89 c6             	mov    %rax,%rsi
  801788:	bf 00 00 00 00       	mov    $0x0,%edi
  80178d:	48 b8 f3 02 80 00 00 	movabs $0x8002f3,%rax
  801794:	00 00 00 
  801797:	ff d0                	callq  *%rax
  801799:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80179c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8017a0:	79 16                	jns    8017b8 <alloc_sockfd+0x63>
  8017a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8017a5:	89 c7                	mov    %eax,%edi
  8017a7:	48 b8 62 1c 80 00 00 	movabs $0x801c62,%rax
  8017ae:	00 00 00 
  8017b1:	ff d0                	callq  *%rax
  8017b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8017b6:	eb 3a                	jmp    8017f2 <alloc_sockfd+0x9d>
  8017b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017bc:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  8017c3:	00 00 00 
  8017c6:	8b 12                	mov    (%rdx),%edx
  8017c8:	89 10                	mov    %edx,(%rax)
  8017ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017ce:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8017d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
  8017dc:	89 50 0c             	mov    %edx,0xc(%rax)
  8017df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017e3:	48 89 c7             	mov    %rax,%rdi
  8017e6:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  8017ed:	00 00 00 
  8017f0:	ff d0                	callq  *%rax
  8017f2:	c9                   	leaveq 
  8017f3:	c3                   	retq   

00000000008017f4 <accept>:
  8017f4:	55                   	push   %rbp
  8017f5:	48 89 e5             	mov    %rsp,%rbp
  8017f8:	48 83 ec 30          	sub    $0x30,%rsp
  8017fc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8017ff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801803:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801807:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80180a:	89 c7                	mov    %eax,%edi
  80180c:	48 b8 fe 16 80 00 00 	movabs $0x8016fe,%rax
  801813:	00 00 00 
  801816:	ff d0                	callq  *%rax
  801818:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80181b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80181f:	79 05                	jns    801826 <accept+0x32>
  801821:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801824:	eb 3b                	jmp    801861 <accept+0x6d>
  801826:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  80182a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80182e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801831:	48 89 ce             	mov    %rcx,%rsi
  801834:	89 c7                	mov    %eax,%edi
  801836:	48 b8 3f 1b 80 00 00 	movabs $0x801b3f,%rax
  80183d:	00 00 00 
  801840:	ff d0                	callq  *%rax
  801842:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801845:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801849:	79 05                	jns    801850 <accept+0x5c>
  80184b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80184e:	eb 11                	jmp    801861 <accept+0x6d>
  801850:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801853:	89 c7                	mov    %eax,%edi
  801855:	48 b8 55 17 80 00 00 	movabs $0x801755,%rax
  80185c:	00 00 00 
  80185f:	ff d0                	callq  *%rax
  801861:	c9                   	leaveq 
  801862:	c3                   	retq   

0000000000801863 <bind>:
  801863:	55                   	push   %rbp
  801864:	48 89 e5             	mov    %rsp,%rbp
  801867:	48 83 ec 20          	sub    $0x20,%rsp
  80186b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80186e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801872:	89 55 e8             	mov    %edx,-0x18(%rbp)
  801875:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801878:	89 c7                	mov    %eax,%edi
  80187a:	48 b8 fe 16 80 00 00 	movabs $0x8016fe,%rax
  801881:	00 00 00 
  801884:	ff d0                	callq  *%rax
  801886:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801889:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80188d:	79 05                	jns    801894 <bind+0x31>
  80188f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801892:	eb 1b                	jmp    8018af <bind+0x4c>
  801894:	8b 55 e8             	mov    -0x18(%rbp),%edx
  801897:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80189b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80189e:	48 89 ce             	mov    %rcx,%rsi
  8018a1:	89 c7                	mov    %eax,%edi
  8018a3:	48 b8 be 1b 80 00 00 	movabs $0x801bbe,%rax
  8018aa:	00 00 00 
  8018ad:	ff d0                	callq  *%rax
  8018af:	c9                   	leaveq 
  8018b0:	c3                   	retq   

00000000008018b1 <shutdown>:
  8018b1:	55                   	push   %rbp
  8018b2:	48 89 e5             	mov    %rsp,%rbp
  8018b5:	48 83 ec 20          	sub    $0x20,%rsp
  8018b9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8018bc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8018bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8018c2:	89 c7                	mov    %eax,%edi
  8018c4:	48 b8 fe 16 80 00 00 	movabs $0x8016fe,%rax
  8018cb:	00 00 00 
  8018ce:	ff d0                	callq  *%rax
  8018d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8018d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8018d7:	79 05                	jns    8018de <shutdown+0x2d>
  8018d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018dc:	eb 16                	jmp    8018f4 <shutdown+0x43>
  8018de:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8018e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018e4:	89 d6                	mov    %edx,%esi
  8018e6:	89 c7                	mov    %eax,%edi
  8018e8:	48 b8 22 1c 80 00 00 	movabs $0x801c22,%rax
  8018ef:	00 00 00 
  8018f2:	ff d0                	callq  *%rax
  8018f4:	c9                   	leaveq 
  8018f5:	c3                   	retq   

00000000008018f6 <devsock_close>:
  8018f6:	55                   	push   %rbp
  8018f7:	48 89 e5             	mov    %rsp,%rbp
  8018fa:	48 83 ec 10          	sub    $0x10,%rsp
  8018fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801906:	48 89 c7             	mov    %rax,%rdi
  801909:	48 b8 0b 3f 80 00 00 	movabs $0x803f0b,%rax
  801910:	00 00 00 
  801913:	ff d0                	callq  *%rax
  801915:	83 f8 01             	cmp    $0x1,%eax
  801918:	75 17                	jne    801931 <devsock_close+0x3b>
  80191a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80191e:	8b 40 0c             	mov    0xc(%rax),%eax
  801921:	89 c7                	mov    %eax,%edi
  801923:	48 b8 62 1c 80 00 00 	movabs $0x801c62,%rax
  80192a:	00 00 00 
  80192d:	ff d0                	callq  *%rax
  80192f:	eb 05                	jmp    801936 <devsock_close+0x40>
  801931:	b8 00 00 00 00       	mov    $0x0,%eax
  801936:	c9                   	leaveq 
  801937:	c3                   	retq   

0000000000801938 <connect>:
  801938:	55                   	push   %rbp
  801939:	48 89 e5             	mov    %rsp,%rbp
  80193c:	48 83 ec 20          	sub    $0x20,%rsp
  801940:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801943:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801947:	89 55 e8             	mov    %edx,-0x18(%rbp)
  80194a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80194d:	89 c7                	mov    %eax,%edi
  80194f:	48 b8 fe 16 80 00 00 	movabs $0x8016fe,%rax
  801956:	00 00 00 
  801959:	ff d0                	callq  *%rax
  80195b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80195e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801962:	79 05                	jns    801969 <connect+0x31>
  801964:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801967:	eb 1b                	jmp    801984 <connect+0x4c>
  801969:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80196c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  801970:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801973:	48 89 ce             	mov    %rcx,%rsi
  801976:	89 c7                	mov    %eax,%edi
  801978:	48 b8 8f 1c 80 00 00 	movabs $0x801c8f,%rax
  80197f:	00 00 00 
  801982:	ff d0                	callq  *%rax
  801984:	c9                   	leaveq 
  801985:	c3                   	retq   

0000000000801986 <listen>:
  801986:	55                   	push   %rbp
  801987:	48 89 e5             	mov    %rsp,%rbp
  80198a:	48 83 ec 20          	sub    $0x20,%rsp
  80198e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801991:	89 75 e8             	mov    %esi,-0x18(%rbp)
  801994:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801997:	89 c7                	mov    %eax,%edi
  801999:	48 b8 fe 16 80 00 00 	movabs $0x8016fe,%rax
  8019a0:	00 00 00 
  8019a3:	ff d0                	callq  *%rax
  8019a5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8019a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8019ac:	79 05                	jns    8019b3 <listen+0x2d>
  8019ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b1:	eb 16                	jmp    8019c9 <listen+0x43>
  8019b3:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8019b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019b9:	89 d6                	mov    %edx,%esi
  8019bb:	89 c7                	mov    %eax,%edi
  8019bd:	48 b8 f3 1c 80 00 00 	movabs $0x801cf3,%rax
  8019c4:	00 00 00 
  8019c7:	ff d0                	callq  *%rax
  8019c9:	c9                   	leaveq 
  8019ca:	c3                   	retq   

00000000008019cb <devsock_read>:
  8019cb:	55                   	push   %rbp
  8019cc:	48 89 e5             	mov    %rsp,%rbp
  8019cf:	48 83 ec 20          	sub    $0x20,%rsp
  8019d3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8019d7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8019db:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8019df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8019e3:	89 c2                	mov    %eax,%edx
  8019e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8019e9:	8b 40 0c             	mov    0xc(%rax),%eax
  8019ec:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  8019f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  8019f5:	89 c7                	mov    %eax,%edi
  8019f7:	48 b8 33 1d 80 00 00 	movabs $0x801d33,%rax
  8019fe:	00 00 00 
  801a01:	ff d0                	callq  *%rax
  801a03:	c9                   	leaveq 
  801a04:	c3                   	retq   

0000000000801a05 <devsock_write>:
  801a05:	55                   	push   %rbp
  801a06:	48 89 e5             	mov    %rsp,%rbp
  801a09:	48 83 ec 20          	sub    $0x20,%rsp
  801a0d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a11:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a15:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801a19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801a1d:	89 c2                	mov    %eax,%edx
  801a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801a23:	8b 40 0c             	mov    0xc(%rax),%eax
  801a26:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  801a2a:	b9 00 00 00 00       	mov    $0x0,%ecx
  801a2f:	89 c7                	mov    %eax,%edi
  801a31:	48 b8 ff 1d 80 00 00 	movabs $0x801dff,%rax
  801a38:	00 00 00 
  801a3b:	ff d0                	callq  *%rax
  801a3d:	c9                   	leaveq 
  801a3e:	c3                   	retq   

0000000000801a3f <devsock_stat>:
  801a3f:	55                   	push   %rbp
  801a40:	48 89 e5             	mov    %rsp,%rbp
  801a43:	48 83 ec 10          	sub    $0x10,%rsp
  801a47:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801a4b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801a53:	48 be f2 40 80 00 00 	movabs $0x8040f2,%rsi
  801a5a:	00 00 00 
  801a5d:	48 89 c7             	mov    %rax,%rdi
  801a60:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  801a67:	00 00 00 
  801a6a:	ff d0                	callq  *%rax
  801a6c:	b8 00 00 00 00       	mov    $0x0,%eax
  801a71:	c9                   	leaveq 
  801a72:	c3                   	retq   

0000000000801a73 <socket>:
  801a73:	55                   	push   %rbp
  801a74:	48 89 e5             	mov    %rsp,%rbp
  801a77:	48 83 ec 20          	sub    $0x20,%rsp
  801a7b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801a7e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  801a81:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  801a84:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  801a87:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  801a8a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a8d:	89 ce                	mov    %ecx,%esi
  801a8f:	89 c7                	mov    %eax,%edi
  801a91:	48 b8 b7 1e 80 00 00 	movabs $0x801eb7,%rax
  801a98:	00 00 00 
  801a9b:	ff d0                	callq  *%rax
  801a9d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801aa0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801aa4:	79 05                	jns    801aab <socket+0x38>
  801aa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801aa9:	eb 11                	jmp    801abc <socket+0x49>
  801aab:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801aae:	89 c7                	mov    %eax,%edi
  801ab0:	48 b8 55 17 80 00 00 	movabs $0x801755,%rax
  801ab7:	00 00 00 
  801aba:	ff d0                	callq  *%rax
  801abc:	c9                   	leaveq 
  801abd:	c3                   	retq   

0000000000801abe <nsipc>:
  801abe:	55                   	push   %rbp
  801abf:	48 89 e5             	mov    %rsp,%rbp
  801ac2:	48 83 ec 10          	sub    $0x10,%rsp
  801ac6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ac9:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  801ad0:	00 00 00 
  801ad3:	8b 00                	mov    (%rax),%eax
  801ad5:	85 c0                	test   %eax,%eax
  801ad7:	75 1d                	jne    801af6 <nsipc+0x38>
  801ad9:	bf 02 00 00 00       	mov    $0x2,%edi
  801ade:	48 b8 99 3e 80 00 00 	movabs $0x803e99,%rax
  801ae5:	00 00 00 
  801ae8:	ff d0                	callq  *%rax
  801aea:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  801af1:	00 00 00 
  801af4:	89 02                	mov    %eax,(%rdx)
  801af6:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  801afd:	00 00 00 
  801b00:	8b 00                	mov    (%rax),%eax
  801b02:	8b 75 fc             	mov    -0x4(%rbp),%esi
  801b05:	b9 07 00 00 00       	mov    $0x7,%ecx
  801b0a:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  801b11:	00 00 00 
  801b14:	89 c7                	mov    %eax,%edi
  801b16:	48 b8 8e 3d 80 00 00 	movabs $0x803d8e,%rax
  801b1d:	00 00 00 
  801b20:	ff d0                	callq  *%rax
  801b22:	ba 00 00 00 00       	mov    $0x0,%edx
  801b27:	be 00 00 00 00       	mov    $0x0,%esi
  801b2c:	bf 00 00 00 00       	mov    $0x0,%edi
  801b31:	48 b8 cd 3c 80 00 00 	movabs $0x803ccd,%rax
  801b38:	00 00 00 
  801b3b:	ff d0                	callq  *%rax
  801b3d:	c9                   	leaveq 
  801b3e:	c3                   	retq   

0000000000801b3f <nsipc_accept>:
  801b3f:	55                   	push   %rbp
  801b40:	48 89 e5             	mov    %rsp,%rbp
  801b43:	48 83 ec 30          	sub    $0x30,%rsp
  801b47:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801b4a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801b4e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801b52:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801b59:	00 00 00 
  801b5c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801b5f:	89 10                	mov    %edx,(%rax)
  801b61:	bf 01 00 00 00       	mov    $0x1,%edi
  801b66:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801b6d:	00 00 00 
  801b70:	ff d0                	callq  *%rax
  801b72:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801b75:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801b79:	78 3e                	js     801bb9 <nsipc_accept+0x7a>
  801b7b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801b82:	00 00 00 
  801b85:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801b89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801b8d:	8b 40 10             	mov    0x10(%rax),%eax
  801b90:	89 c2                	mov    %eax,%edx
  801b92:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801b96:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801b9a:	48 89 ce             	mov    %rcx,%rsi
  801b9d:	48 89 c7             	mov    %rax,%rdi
  801ba0:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  801ba7:	00 00 00 
  801baa:	ff d0                	callq  *%rax
  801bac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801bb0:	8b 50 10             	mov    0x10(%rax),%edx
  801bb3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801bb7:	89 10                	mov    %edx,(%rax)
  801bb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bbc:	c9                   	leaveq 
  801bbd:	c3                   	retq   

0000000000801bbe <nsipc_bind>:
  801bbe:	55                   	push   %rbp
  801bbf:	48 89 e5             	mov    %rsp,%rbp
  801bc2:	48 83 ec 10          	sub    $0x10,%rsp
  801bc6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801bc9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801bcd:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801bd0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801bd7:	00 00 00 
  801bda:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801bdd:	89 10                	mov    %edx,(%rax)
  801bdf:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801be2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801be6:	48 89 c6             	mov    %rax,%rsi
  801be9:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  801bf0:	00 00 00 
  801bf3:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  801bfa:	00 00 00 
  801bfd:	ff d0                	callq  *%rax
  801bff:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801c06:	00 00 00 
  801c09:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801c0c:	89 50 14             	mov    %edx,0x14(%rax)
  801c0f:	bf 02 00 00 00       	mov    $0x2,%edi
  801c14:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801c1b:	00 00 00 
  801c1e:	ff d0                	callq  *%rax
  801c20:	c9                   	leaveq 
  801c21:	c3                   	retq   

0000000000801c22 <nsipc_shutdown>:
  801c22:	55                   	push   %rbp
  801c23:	48 89 e5             	mov    %rsp,%rbp
  801c26:	48 83 ec 10          	sub    $0x10,%rsp
  801c2a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c2d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801c30:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801c37:	00 00 00 
  801c3a:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801c3d:	89 10                	mov    %edx,(%rax)
  801c3f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801c46:	00 00 00 
  801c49:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801c4c:	89 50 04             	mov    %edx,0x4(%rax)
  801c4f:	bf 03 00 00 00       	mov    $0x3,%edi
  801c54:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801c5b:	00 00 00 
  801c5e:	ff d0                	callq  *%rax
  801c60:	c9                   	leaveq 
  801c61:	c3                   	retq   

0000000000801c62 <nsipc_close>:
  801c62:	55                   	push   %rbp
  801c63:	48 89 e5             	mov    %rsp,%rbp
  801c66:	48 83 ec 10          	sub    $0x10,%rsp
  801c6a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c6d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801c74:	00 00 00 
  801c77:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801c7a:	89 10                	mov    %edx,(%rax)
  801c7c:	bf 04 00 00 00       	mov    $0x4,%edi
  801c81:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801c88:	00 00 00 
  801c8b:	ff d0                	callq  *%rax
  801c8d:	c9                   	leaveq 
  801c8e:	c3                   	retq   

0000000000801c8f <nsipc_connect>:
  801c8f:	55                   	push   %rbp
  801c90:	48 89 e5             	mov    %rsp,%rbp
  801c93:	48 83 ec 10          	sub    $0x10,%rsp
  801c97:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c9a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c9e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801ca1:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801ca8:	00 00 00 
  801cab:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801cae:	89 10                	mov    %edx,(%rax)
  801cb0:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801cb7:	48 89 c6             	mov    %rax,%rsi
  801cba:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  801cc1:	00 00 00 
  801cc4:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  801ccb:	00 00 00 
  801cce:	ff d0                	callq  *%rax
  801cd0:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801cd7:	00 00 00 
  801cda:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801cdd:	89 50 14             	mov    %edx,0x14(%rax)
  801ce0:	bf 05 00 00 00       	mov    $0x5,%edi
  801ce5:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801cec:	00 00 00 
  801cef:	ff d0                	callq  *%rax
  801cf1:	c9                   	leaveq 
  801cf2:	c3                   	retq   

0000000000801cf3 <nsipc_listen>:
  801cf3:	55                   	push   %rbp
  801cf4:	48 89 e5             	mov    %rsp,%rbp
  801cf7:	48 83 ec 10          	sub    $0x10,%rsp
  801cfb:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801cfe:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801d01:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801d08:	00 00 00 
  801d0b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801d0e:	89 10                	mov    %edx,(%rax)
  801d10:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801d17:	00 00 00 
  801d1a:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801d1d:	89 50 04             	mov    %edx,0x4(%rax)
  801d20:	bf 06 00 00 00       	mov    $0x6,%edi
  801d25:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801d2c:	00 00 00 
  801d2f:	ff d0                	callq  *%rax
  801d31:	c9                   	leaveq 
  801d32:	c3                   	retq   

0000000000801d33 <nsipc_recv>:
  801d33:	55                   	push   %rbp
  801d34:	48 89 e5             	mov    %rsp,%rbp
  801d37:	48 83 ec 30          	sub    $0x30,%rsp
  801d3b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801d3e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801d42:	89 55 e8             	mov    %edx,-0x18(%rbp)
  801d45:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  801d48:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801d4f:	00 00 00 
  801d52:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801d55:	89 10                	mov    %edx,(%rax)
  801d57:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801d5e:	00 00 00 
  801d61:	8b 55 e8             	mov    -0x18(%rbp),%edx
  801d64:	89 50 04             	mov    %edx,0x4(%rax)
  801d67:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801d6e:	00 00 00 
  801d71:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801d74:	89 50 08             	mov    %edx,0x8(%rax)
  801d77:	bf 07 00 00 00       	mov    $0x7,%edi
  801d7c:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801d83:	00 00 00 
  801d86:	ff d0                	callq  *%rax
  801d88:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801d8b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801d8f:	78 69                	js     801dfa <nsipc_recv+0xc7>
  801d91:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  801d98:	7f 08                	jg     801da2 <nsipc_recv+0x6f>
  801d9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d9d:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  801da0:	7e 35                	jle    801dd7 <nsipc_recv+0xa4>
  801da2:	48 b9 f9 40 80 00 00 	movabs $0x8040f9,%rcx
  801da9:	00 00 00 
  801dac:	48 ba 0e 41 80 00 00 	movabs $0x80410e,%rdx
  801db3:	00 00 00 
  801db6:	be 62 00 00 00       	mov    $0x62,%esi
  801dbb:	48 bf 23 41 80 00 00 	movabs $0x804123,%rdi
  801dc2:	00 00 00 
  801dc5:	b8 00 00 00 00       	mov    $0x0,%eax
  801dca:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  801dd1:	00 00 00 
  801dd4:	41 ff d0             	callq  *%r8
  801dd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dda:	48 63 d0             	movslq %eax,%rdx
  801ddd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801de1:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  801de8:	00 00 00 
  801deb:	48 89 c7             	mov    %rax,%rdi
  801dee:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  801df5:	00 00 00 
  801df8:	ff d0                	callq  *%rax
  801dfa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dfd:	c9                   	leaveq 
  801dfe:	c3                   	retq   

0000000000801dff <nsipc_send>:
  801dff:	55                   	push   %rbp
  801e00:	48 89 e5             	mov    %rsp,%rbp
  801e03:	48 83 ec 20          	sub    $0x20,%rsp
  801e07:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e0a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e0e:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801e11:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  801e14:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801e1b:	00 00 00 
  801e1e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801e21:	89 10                	mov    %edx,(%rax)
  801e23:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  801e2a:	7e 35                	jle    801e61 <nsipc_send+0x62>
  801e2c:	48 b9 32 41 80 00 00 	movabs $0x804132,%rcx
  801e33:	00 00 00 
  801e36:	48 ba 0e 41 80 00 00 	movabs $0x80410e,%rdx
  801e3d:	00 00 00 
  801e40:	be 6d 00 00 00       	mov    $0x6d,%esi
  801e45:	48 bf 23 41 80 00 00 	movabs $0x804123,%rdi
  801e4c:	00 00 00 
  801e4f:	b8 00 00 00 00       	mov    $0x0,%eax
  801e54:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  801e5b:	00 00 00 
  801e5e:	41 ff d0             	callq  *%r8
  801e61:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e64:	48 63 d0             	movslq %eax,%rdx
  801e67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e6b:	48 89 c6             	mov    %rax,%rsi
  801e6e:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  801e75:	00 00 00 
  801e78:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  801e7f:	00 00 00 
  801e82:	ff d0                	callq  *%rax
  801e84:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801e8b:	00 00 00 
  801e8e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801e91:	89 50 04             	mov    %edx,0x4(%rax)
  801e94:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801e9b:	00 00 00 
  801e9e:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801ea1:	89 50 08             	mov    %edx,0x8(%rax)
  801ea4:	bf 08 00 00 00       	mov    $0x8,%edi
  801ea9:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801eb0:	00 00 00 
  801eb3:	ff d0                	callq  *%rax
  801eb5:	c9                   	leaveq 
  801eb6:	c3                   	retq   

0000000000801eb7 <nsipc_socket>:
  801eb7:	55                   	push   %rbp
  801eb8:	48 89 e5             	mov    %rsp,%rbp
  801ebb:	48 83 ec 10          	sub    $0x10,%rsp
  801ebf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ec2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801ec5:	89 55 f4             	mov    %edx,-0xc(%rbp)
  801ec8:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801ecf:	00 00 00 
  801ed2:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801ed5:	89 10                	mov    %edx,(%rax)
  801ed7:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801ede:	00 00 00 
  801ee1:	8b 55 f8             	mov    -0x8(%rbp),%edx
  801ee4:	89 50 04             	mov    %edx,0x4(%rax)
  801ee7:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  801eee:	00 00 00 
  801ef1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801ef4:	89 50 08             	mov    %edx,0x8(%rax)
  801ef7:	bf 09 00 00 00       	mov    $0x9,%edi
  801efc:	48 b8 be 1a 80 00 00 	movabs $0x801abe,%rax
  801f03:	00 00 00 
  801f06:	ff d0                	callq  *%rax
  801f08:	c9                   	leaveq 
  801f09:	c3                   	retq   

0000000000801f0a <pipe>:
  801f0a:	55                   	push   %rbp
  801f0b:	48 89 e5             	mov    %rsp,%rbp
  801f0e:	53                   	push   %rbx
  801f0f:	48 83 ec 38          	sub    $0x38,%rsp
  801f13:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801f17:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  801f1b:	48 89 c7             	mov    %rax,%rdi
  801f1e:	48 b8 21 07 80 00 00 	movabs $0x800721,%rax
  801f25:	00 00 00 
  801f28:	ff d0                	callq  *%rax
  801f2a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f2d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801f31:	0f 88 bf 01 00 00    	js     8020f6 <pipe+0x1ec>
  801f37:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801f3b:	ba 07 04 00 00       	mov    $0x407,%edx
  801f40:	48 89 c6             	mov    %rax,%rsi
  801f43:	bf 00 00 00 00       	mov    $0x0,%edi
  801f48:	48 b8 f3 02 80 00 00 	movabs $0x8002f3,%rax
  801f4f:	00 00 00 
  801f52:	ff d0                	callq  *%rax
  801f54:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f57:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801f5b:	0f 88 95 01 00 00    	js     8020f6 <pipe+0x1ec>
  801f61:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  801f65:	48 89 c7             	mov    %rax,%rdi
  801f68:	48 b8 21 07 80 00 00 	movabs $0x800721,%rax
  801f6f:	00 00 00 
  801f72:	ff d0                	callq  *%rax
  801f74:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801f77:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801f7b:	0f 88 5d 01 00 00    	js     8020de <pipe+0x1d4>
  801f81:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801f85:	ba 07 04 00 00       	mov    $0x407,%edx
  801f8a:	48 89 c6             	mov    %rax,%rsi
  801f8d:	bf 00 00 00 00       	mov    $0x0,%edi
  801f92:	48 b8 f3 02 80 00 00 	movabs $0x8002f3,%rax
  801f99:	00 00 00 
  801f9c:	ff d0                	callq  *%rax
  801f9e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801fa1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801fa5:	0f 88 33 01 00 00    	js     8020de <pipe+0x1d4>
  801fab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801faf:	48 89 c7             	mov    %rax,%rdi
  801fb2:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  801fb9:	00 00 00 
  801fbc:	ff d0                	callq  *%rax
  801fbe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  801fc2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801fc6:	ba 07 04 00 00       	mov    $0x407,%edx
  801fcb:	48 89 c6             	mov    %rax,%rsi
  801fce:	bf 00 00 00 00       	mov    $0x0,%edi
  801fd3:	48 b8 f3 02 80 00 00 	movabs $0x8002f3,%rax
  801fda:	00 00 00 
  801fdd:	ff d0                	callq  *%rax
  801fdf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801fe2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801fe6:	79 05                	jns    801fed <pipe+0xe3>
  801fe8:	e9 d9 00 00 00       	jmpq   8020c6 <pipe+0x1bc>
  801fed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801ff1:	48 89 c7             	mov    %rax,%rdi
  801ff4:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  801ffb:	00 00 00 
  801ffe:	ff d0                	callq  *%rax
  802000:	48 89 c2             	mov    %rax,%rdx
  802003:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802007:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  80200d:	48 89 d1             	mov    %rdx,%rcx
  802010:	ba 00 00 00 00       	mov    $0x0,%edx
  802015:	48 89 c6             	mov    %rax,%rsi
  802018:	bf 00 00 00 00       	mov    $0x0,%edi
  80201d:	48 b8 43 03 80 00 00 	movabs $0x800343,%rax
  802024:	00 00 00 
  802027:	ff d0                	callq  *%rax
  802029:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80202c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802030:	79 1b                	jns    80204d <pipe+0x143>
  802032:	90                   	nop
  802033:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802037:	48 89 c6             	mov    %rax,%rsi
  80203a:	bf 00 00 00 00       	mov    $0x0,%edi
  80203f:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  802046:	00 00 00 
  802049:	ff d0                	callq  *%rax
  80204b:	eb 79                	jmp    8020c6 <pipe+0x1bc>
  80204d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802051:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  802058:	00 00 00 
  80205b:	8b 12                	mov    (%rdx),%edx
  80205d:	89 10                	mov    %edx,(%rax)
  80205f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802063:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  80206a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80206e:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  802075:	00 00 00 
  802078:	8b 12                	mov    (%rdx),%edx
  80207a:	89 10                	mov    %edx,(%rax)
  80207c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802080:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  802087:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80208b:	48 89 c7             	mov    %rax,%rdi
  80208e:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  802095:	00 00 00 
  802098:	ff d0                	callq  *%rax
  80209a:	89 c2                	mov    %eax,%edx
  80209c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8020a0:	89 10                	mov    %edx,(%rax)
  8020a2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8020a6:	48 8d 58 04          	lea    0x4(%rax),%rbx
  8020aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8020ae:	48 89 c7             	mov    %rax,%rdi
  8020b1:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  8020b8:	00 00 00 
  8020bb:	ff d0                	callq  *%rax
  8020bd:	89 03                	mov    %eax,(%rbx)
  8020bf:	b8 00 00 00 00       	mov    $0x0,%eax
  8020c4:	eb 33                	jmp    8020f9 <pipe+0x1ef>
  8020c6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8020ca:	48 89 c6             	mov    %rax,%rsi
  8020cd:	bf 00 00 00 00       	mov    $0x0,%edi
  8020d2:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  8020d9:	00 00 00 
  8020dc:	ff d0                	callq  *%rax
  8020de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8020e2:	48 89 c6             	mov    %rax,%rsi
  8020e5:	bf 00 00 00 00       	mov    $0x0,%edi
  8020ea:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  8020f1:	00 00 00 
  8020f4:	ff d0                	callq  *%rax
  8020f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8020f9:	48 83 c4 38          	add    $0x38,%rsp
  8020fd:	5b                   	pop    %rbx
  8020fe:	5d                   	pop    %rbp
  8020ff:	c3                   	retq   

0000000000802100 <_pipeisclosed>:
  802100:	55                   	push   %rbp
  802101:	48 89 e5             	mov    %rsp,%rbp
  802104:	53                   	push   %rbx
  802105:	48 83 ec 28          	sub    $0x28,%rsp
  802109:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80210d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802111:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802118:	00 00 00 
  80211b:	48 8b 00             	mov    (%rax),%rax
  80211e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802124:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802127:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80212b:	48 89 c7             	mov    %rax,%rdi
  80212e:	48 b8 0b 3f 80 00 00 	movabs $0x803f0b,%rax
  802135:	00 00 00 
  802138:	ff d0                	callq  *%rax
  80213a:	89 c3                	mov    %eax,%ebx
  80213c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802140:	48 89 c7             	mov    %rax,%rdi
  802143:	48 b8 0b 3f 80 00 00 	movabs $0x803f0b,%rax
  80214a:	00 00 00 
  80214d:	ff d0                	callq  *%rax
  80214f:	39 c3                	cmp    %eax,%ebx
  802151:	0f 94 c0             	sete   %al
  802154:	0f b6 c0             	movzbl %al,%eax
  802157:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80215a:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802161:	00 00 00 
  802164:	48 8b 00             	mov    (%rax),%rax
  802167:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80216d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  802170:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802173:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  802176:	75 05                	jne    80217d <_pipeisclosed+0x7d>
  802178:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80217b:	eb 4f                	jmp    8021cc <_pipeisclosed+0xcc>
  80217d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802180:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  802183:	74 42                	je     8021c7 <_pipeisclosed+0xc7>
  802185:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  802189:	75 3c                	jne    8021c7 <_pipeisclosed+0xc7>
  80218b:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802192:	00 00 00 
  802195:	48 8b 00             	mov    (%rax),%rax
  802198:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80219e:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  8021a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8021a4:	89 c6                	mov    %eax,%esi
  8021a6:	48 bf 43 41 80 00 00 	movabs $0x804143,%rdi
  8021ad:	00 00 00 
  8021b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8021b5:	49 b8 bf 29 80 00 00 	movabs $0x8029bf,%r8
  8021bc:	00 00 00 
  8021bf:	41 ff d0             	callq  *%r8
  8021c2:	e9 4a ff ff ff       	jmpq   802111 <_pipeisclosed+0x11>
  8021c7:	e9 45 ff ff ff       	jmpq   802111 <_pipeisclosed+0x11>
  8021cc:	48 83 c4 28          	add    $0x28,%rsp
  8021d0:	5b                   	pop    %rbx
  8021d1:	5d                   	pop    %rbp
  8021d2:	c3                   	retq   

00000000008021d3 <pipeisclosed>:
  8021d3:	55                   	push   %rbp
  8021d4:	48 89 e5             	mov    %rsp,%rbp
  8021d7:	48 83 ec 30          	sub    $0x30,%rsp
  8021db:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8021de:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8021e2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8021e5:	48 89 d6             	mov    %rdx,%rsi
  8021e8:	89 c7                	mov    %eax,%edi
  8021ea:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  8021f1:	00 00 00 
  8021f4:	ff d0                	callq  *%rax
  8021f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021f9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021fd:	79 05                	jns    802204 <pipeisclosed+0x31>
  8021ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802202:	eb 31                	jmp    802235 <pipeisclosed+0x62>
  802204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802208:	48 89 c7             	mov    %rax,%rdi
  80220b:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  802212:	00 00 00 
  802215:	ff d0                	callq  *%rax
  802217:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80221b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80221f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802223:	48 89 d6             	mov    %rdx,%rsi
  802226:	48 89 c7             	mov    %rax,%rdi
  802229:	48 b8 00 21 80 00 00 	movabs $0x802100,%rax
  802230:	00 00 00 
  802233:	ff d0                	callq  *%rax
  802235:	c9                   	leaveq 
  802236:	c3                   	retq   

0000000000802237 <devpipe_read>:
  802237:	55                   	push   %rbp
  802238:	48 89 e5             	mov    %rsp,%rbp
  80223b:	48 83 ec 40          	sub    $0x40,%rsp
  80223f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802243:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802247:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80224b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80224f:	48 89 c7             	mov    %rax,%rdi
  802252:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  802259:	00 00 00 
  80225c:	ff d0                	callq  *%rax
  80225e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802262:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802266:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80226a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  802271:	00 
  802272:	e9 92 00 00 00       	jmpq   802309 <devpipe_read+0xd2>
  802277:	eb 41                	jmp    8022ba <devpipe_read+0x83>
  802279:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80227e:	74 09                	je     802289 <devpipe_read+0x52>
  802280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802284:	e9 92 00 00 00       	jmpq   80231b <devpipe_read+0xe4>
  802289:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80228d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802291:	48 89 d6             	mov    %rdx,%rsi
  802294:	48 89 c7             	mov    %rax,%rdi
  802297:	48 b8 00 21 80 00 00 	movabs $0x802100,%rax
  80229e:	00 00 00 
  8022a1:	ff d0                	callq  *%rax
  8022a3:	85 c0                	test   %eax,%eax
  8022a5:	74 07                	je     8022ae <devpipe_read+0x77>
  8022a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8022ac:	eb 6d                	jmp    80231b <devpipe_read+0xe4>
  8022ae:	48 b8 b5 02 80 00 00 	movabs $0x8002b5,%rax
  8022b5:	00 00 00 
  8022b8:	ff d0                	callq  *%rax
  8022ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022be:	8b 10                	mov    (%rax),%edx
  8022c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022c4:	8b 40 04             	mov    0x4(%rax),%eax
  8022c7:	39 c2                	cmp    %eax,%edx
  8022c9:	74 ae                	je     802279 <devpipe_read+0x42>
  8022cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8022cf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8022d3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8022d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022db:	8b 00                	mov    (%rax),%eax
  8022dd:	99                   	cltd   
  8022de:	c1 ea 1b             	shr    $0x1b,%edx
  8022e1:	01 d0                	add    %edx,%eax
  8022e3:	83 e0 1f             	and    $0x1f,%eax
  8022e6:	29 d0                	sub    %edx,%eax
  8022e8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8022ec:	48 98                	cltq   
  8022ee:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8022f3:	88 01                	mov    %al,(%rcx)
  8022f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8022f9:	8b 00                	mov    (%rax),%eax
  8022fb:	8d 50 01             	lea    0x1(%rax),%edx
  8022fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802302:	89 10                	mov    %edx,(%rax)
  802304:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  802309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80230d:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  802311:	0f 82 60 ff ff ff    	jb     802277 <devpipe_read+0x40>
  802317:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80231b:	c9                   	leaveq 
  80231c:	c3                   	retq   

000000000080231d <devpipe_write>:
  80231d:	55                   	push   %rbp
  80231e:	48 89 e5             	mov    %rsp,%rbp
  802321:	48 83 ec 40          	sub    $0x40,%rsp
  802325:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802329:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80232d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802331:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802335:	48 89 c7             	mov    %rax,%rdi
  802338:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  80233f:	00 00 00 
  802342:	ff d0                	callq  *%rax
  802344:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802348:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80234c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802350:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  802357:	00 
  802358:	e9 8e 00 00 00       	jmpq   8023eb <devpipe_write+0xce>
  80235d:	eb 31                	jmp    802390 <devpipe_write+0x73>
  80235f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802363:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802367:	48 89 d6             	mov    %rdx,%rsi
  80236a:	48 89 c7             	mov    %rax,%rdi
  80236d:	48 b8 00 21 80 00 00 	movabs $0x802100,%rax
  802374:	00 00 00 
  802377:	ff d0                	callq  *%rax
  802379:	85 c0                	test   %eax,%eax
  80237b:	74 07                	je     802384 <devpipe_write+0x67>
  80237d:	b8 00 00 00 00       	mov    $0x0,%eax
  802382:	eb 79                	jmp    8023fd <devpipe_write+0xe0>
  802384:	48 b8 b5 02 80 00 00 	movabs $0x8002b5,%rax
  80238b:	00 00 00 
  80238e:	ff d0                	callq  *%rax
  802390:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802394:	8b 40 04             	mov    0x4(%rax),%eax
  802397:	48 63 d0             	movslq %eax,%rdx
  80239a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80239e:	8b 00                	mov    (%rax),%eax
  8023a0:	48 98                	cltq   
  8023a2:	48 83 c0 20          	add    $0x20,%rax
  8023a6:	48 39 c2             	cmp    %rax,%rdx
  8023a9:	73 b4                	jae    80235f <devpipe_write+0x42>
  8023ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023af:	8b 40 04             	mov    0x4(%rax),%eax
  8023b2:	99                   	cltd   
  8023b3:	c1 ea 1b             	shr    $0x1b,%edx
  8023b6:	01 d0                	add    %edx,%eax
  8023b8:	83 e0 1f             	and    $0x1f,%eax
  8023bb:	29 d0                	sub    %edx,%eax
  8023bd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8023c1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8023c5:	48 01 ca             	add    %rcx,%rdx
  8023c8:	0f b6 0a             	movzbl (%rdx),%ecx
  8023cb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8023cf:	48 98                	cltq   
  8023d1:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8023d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023d9:	8b 40 04             	mov    0x4(%rax),%eax
  8023dc:	8d 50 01             	lea    0x1(%rax),%edx
  8023df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023e3:	89 50 04             	mov    %edx,0x4(%rax)
  8023e6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8023eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023ef:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8023f3:	0f 82 64 ff ff ff    	jb     80235d <devpipe_write+0x40>
  8023f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023fd:	c9                   	leaveq 
  8023fe:	c3                   	retq   

00000000008023ff <devpipe_stat>:
  8023ff:	55                   	push   %rbp
  802400:	48 89 e5             	mov    %rsp,%rbp
  802403:	48 83 ec 20          	sub    $0x20,%rsp
  802407:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80240b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80240f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802413:	48 89 c7             	mov    %rax,%rdi
  802416:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  80241d:	00 00 00 
  802420:	ff d0                	callq  *%rax
  802422:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802426:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80242a:	48 be 56 41 80 00 00 	movabs $0x804156,%rsi
  802431:	00 00 00 
  802434:	48 89 c7             	mov    %rax,%rdi
  802437:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  80243e:	00 00 00 
  802441:	ff d0                	callq  *%rax
  802443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802447:	8b 50 04             	mov    0x4(%rax),%edx
  80244a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80244e:	8b 00                	mov    (%rax),%eax
  802450:	29 c2                	sub    %eax,%edx
  802452:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802456:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  80245c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802460:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802467:	00 00 00 
  80246a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80246e:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  802475:	00 00 00 
  802478:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  80247f:	b8 00 00 00 00       	mov    $0x0,%eax
  802484:	c9                   	leaveq 
  802485:	c3                   	retq   

0000000000802486 <devpipe_close>:
  802486:	55                   	push   %rbp
  802487:	48 89 e5             	mov    %rsp,%rbp
  80248a:	48 83 ec 10          	sub    $0x10,%rsp
  80248e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802492:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802496:	48 89 c6             	mov    %rax,%rsi
  802499:	bf 00 00 00 00       	mov    $0x0,%edi
  80249e:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  8024a5:	00 00 00 
  8024a8:	ff d0                	callq  *%rax
  8024aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8024ae:	48 89 c7             	mov    %rax,%rdi
  8024b1:	48 b8 f6 06 80 00 00 	movabs $0x8006f6,%rax
  8024b8:	00 00 00 
  8024bb:	ff d0                	callq  *%rax
  8024bd:	48 89 c6             	mov    %rax,%rsi
  8024c0:	bf 00 00 00 00       	mov    $0x0,%edi
  8024c5:	48 b8 9e 03 80 00 00 	movabs $0x80039e,%rax
  8024cc:	00 00 00 
  8024cf:	ff d0                	callq  *%rax
  8024d1:	c9                   	leaveq 
  8024d2:	c3                   	retq   

00000000008024d3 <cputchar>:
  8024d3:	55                   	push   %rbp
  8024d4:	48 89 e5             	mov    %rsp,%rbp
  8024d7:	48 83 ec 20          	sub    $0x20,%rsp
  8024db:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8024de:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024e1:	88 45 ff             	mov    %al,-0x1(%rbp)
  8024e4:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8024e8:	be 01 00 00 00       	mov    $0x1,%esi
  8024ed:	48 89 c7             	mov    %rax,%rdi
  8024f0:	48 b8 ab 01 80 00 00 	movabs $0x8001ab,%rax
  8024f7:	00 00 00 
  8024fa:	ff d0                	callq  *%rax
  8024fc:	c9                   	leaveq 
  8024fd:	c3                   	retq   

00000000008024fe <getchar>:
  8024fe:	55                   	push   %rbp
  8024ff:	48 89 e5             	mov    %rsp,%rbp
  802502:	48 83 ec 10          	sub    $0x10,%rsp
  802506:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  80250a:	ba 01 00 00 00       	mov    $0x1,%edx
  80250f:	48 89 c6             	mov    %rax,%rsi
  802512:	bf 00 00 00 00       	mov    $0x0,%edi
  802517:	48 b8 eb 0b 80 00 00 	movabs $0x800beb,%rax
  80251e:	00 00 00 
  802521:	ff d0                	callq  *%rax
  802523:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80252a:	79 05                	jns    802531 <getchar+0x33>
  80252c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80252f:	eb 14                	jmp    802545 <getchar+0x47>
  802531:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802535:	7f 07                	jg     80253e <getchar+0x40>
  802537:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  80253c:	eb 07                	jmp    802545 <getchar+0x47>
  80253e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  802542:	0f b6 c0             	movzbl %al,%eax
  802545:	c9                   	leaveq 
  802546:	c3                   	retq   

0000000000802547 <iscons>:
  802547:	55                   	push   %rbp
  802548:	48 89 e5             	mov    %rsp,%rbp
  80254b:	48 83 ec 20          	sub    $0x20,%rsp
  80254f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802552:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802556:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802559:	48 89 d6             	mov    %rdx,%rsi
  80255c:	89 c7                	mov    %eax,%edi
  80255e:	48 b8 b9 07 80 00 00 	movabs $0x8007b9,%rax
  802565:	00 00 00 
  802568:	ff d0                	callq  *%rax
  80256a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80256d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802571:	79 05                	jns    802578 <iscons+0x31>
  802573:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802576:	eb 1a                	jmp    802592 <iscons+0x4b>
  802578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80257c:	8b 10                	mov    (%rax),%edx
  80257e:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  802585:	00 00 00 
  802588:	8b 00                	mov    (%rax),%eax
  80258a:	39 c2                	cmp    %eax,%edx
  80258c:	0f 94 c0             	sete   %al
  80258f:	0f b6 c0             	movzbl %al,%eax
  802592:	c9                   	leaveq 
  802593:	c3                   	retq   

0000000000802594 <opencons>:
  802594:	55                   	push   %rbp
  802595:	48 89 e5             	mov    %rsp,%rbp
  802598:	48 83 ec 10          	sub    $0x10,%rsp
  80259c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8025a0:	48 89 c7             	mov    %rax,%rdi
  8025a3:	48 b8 21 07 80 00 00 	movabs $0x800721,%rax
  8025aa:	00 00 00 
  8025ad:	ff d0                	callq  *%rax
  8025af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025b6:	79 05                	jns    8025bd <opencons+0x29>
  8025b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025bb:	eb 5b                	jmp    802618 <opencons+0x84>
  8025bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025c1:	ba 07 04 00 00       	mov    $0x407,%edx
  8025c6:	48 89 c6             	mov    %rax,%rsi
  8025c9:	bf 00 00 00 00       	mov    $0x0,%edi
  8025ce:	48 b8 f3 02 80 00 00 	movabs $0x8002f3,%rax
  8025d5:	00 00 00 
  8025d8:	ff d0                	callq  *%rax
  8025da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025e1:	79 05                	jns    8025e8 <opencons+0x54>
  8025e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025e6:	eb 30                	jmp    802618 <opencons+0x84>
  8025e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025ec:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  8025f3:	00 00 00 
  8025f6:	8b 12                	mov    (%rdx),%edx
  8025f8:	89 10                	mov    %edx,(%rax)
  8025fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8025fe:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802605:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802609:	48 89 c7             	mov    %rax,%rdi
  80260c:	48 b8 d3 06 80 00 00 	movabs $0x8006d3,%rax
  802613:	00 00 00 
  802616:	ff d0                	callq  *%rax
  802618:	c9                   	leaveq 
  802619:	c3                   	retq   

000000000080261a <devcons_read>:
  80261a:	55                   	push   %rbp
  80261b:	48 89 e5             	mov    %rsp,%rbp
  80261e:	48 83 ec 30          	sub    $0x30,%rsp
  802622:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802626:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80262a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80262e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  802633:	75 07                	jne    80263c <devcons_read+0x22>
  802635:	b8 00 00 00 00       	mov    $0x0,%eax
  80263a:	eb 4b                	jmp    802687 <devcons_read+0x6d>
  80263c:	eb 0c                	jmp    80264a <devcons_read+0x30>
  80263e:	48 b8 b5 02 80 00 00 	movabs $0x8002b5,%rax
  802645:	00 00 00 
  802648:	ff d0                	callq  *%rax
  80264a:	48 b8 f5 01 80 00 00 	movabs $0x8001f5,%rax
  802651:	00 00 00 
  802654:	ff d0                	callq  *%rax
  802656:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802659:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80265d:	74 df                	je     80263e <devcons_read+0x24>
  80265f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802663:	79 05                	jns    80266a <devcons_read+0x50>
  802665:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802668:	eb 1d                	jmp    802687 <devcons_read+0x6d>
  80266a:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80266e:	75 07                	jne    802677 <devcons_read+0x5d>
  802670:	b8 00 00 00 00       	mov    $0x0,%eax
  802675:	eb 10                	jmp    802687 <devcons_read+0x6d>
  802677:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80267a:	89 c2                	mov    %eax,%edx
  80267c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802680:	88 10                	mov    %dl,(%rax)
  802682:	b8 01 00 00 00       	mov    $0x1,%eax
  802687:	c9                   	leaveq 
  802688:	c3                   	retq   

0000000000802689 <devcons_write>:
  802689:	55                   	push   %rbp
  80268a:	48 89 e5             	mov    %rsp,%rbp
  80268d:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  802694:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  80269b:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  8026a2:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  8026a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8026b0:	eb 76                	jmp    802728 <devcons_write+0x9f>
  8026b2:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  8026b9:	89 c2                	mov    %eax,%edx
  8026bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026be:	29 c2                	sub    %eax,%edx
  8026c0:	89 d0                	mov    %edx,%eax
  8026c2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8026c5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8026c8:	83 f8 7f             	cmp    $0x7f,%eax
  8026cb:	76 07                	jbe    8026d4 <devcons_write+0x4b>
  8026cd:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  8026d4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8026d7:	48 63 d0             	movslq %eax,%rdx
  8026da:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026dd:	48 63 c8             	movslq %eax,%rcx
  8026e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8026e7:	48 01 c1             	add    %rax,%rcx
  8026ea:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8026f1:	48 89 ce             	mov    %rcx,%rsi
  8026f4:	48 89 c7             	mov    %rax,%rdi
  8026f7:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  8026fe:	00 00 00 
  802701:	ff d0                	callq  *%rax
  802703:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802706:	48 63 d0             	movslq %eax,%rdx
  802709:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  802710:	48 89 d6             	mov    %rdx,%rsi
  802713:	48 89 c7             	mov    %rax,%rdi
  802716:	48 b8 ab 01 80 00 00 	movabs $0x8001ab,%rax
  80271d:	00 00 00 
  802720:	ff d0                	callq  *%rax
  802722:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802725:	01 45 fc             	add    %eax,-0x4(%rbp)
  802728:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80272b:	48 98                	cltq   
  80272d:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  802734:	0f 82 78 ff ff ff    	jb     8026b2 <devcons_write+0x29>
  80273a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80273d:	c9                   	leaveq 
  80273e:	c3                   	retq   

000000000080273f <devcons_close>:
  80273f:	55                   	push   %rbp
  802740:	48 89 e5             	mov    %rsp,%rbp
  802743:	48 83 ec 08          	sub    $0x8,%rsp
  802747:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80274b:	b8 00 00 00 00       	mov    $0x0,%eax
  802750:	c9                   	leaveq 
  802751:	c3                   	retq   

0000000000802752 <devcons_stat>:
  802752:	55                   	push   %rbp
  802753:	48 89 e5             	mov    %rsp,%rbp
  802756:	48 83 ec 10          	sub    $0x10,%rsp
  80275a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80275e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802762:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802766:	48 be 62 41 80 00 00 	movabs $0x804162,%rsi
  80276d:	00 00 00 
  802770:	48 89 c7             	mov    %rax,%rdi
  802773:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  80277a:	00 00 00 
  80277d:	ff d0                	callq  *%rax
  80277f:	b8 00 00 00 00       	mov    $0x0,%eax
  802784:	c9                   	leaveq 
  802785:	c3                   	retq   

0000000000802786 <_panic>:
  802786:	55                   	push   %rbp
  802787:	48 89 e5             	mov    %rsp,%rbp
  80278a:	53                   	push   %rbx
  80278b:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  802792:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  802799:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  80279f:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8027a6:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8027ad:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8027b4:	84 c0                	test   %al,%al
  8027b6:	74 23                	je     8027db <_panic+0x55>
  8027b8:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  8027bf:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  8027c3:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  8027c7:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  8027cb:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  8027cf:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  8027d3:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  8027d7:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  8027db:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  8027e2:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  8027e9:	00 00 00 
  8027ec:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  8027f3:	00 00 00 
  8027f6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8027fa:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  802801:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  802808:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80280f:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  802816:	00 00 00 
  802819:	48 8b 18             	mov    (%rax),%rbx
  80281c:	48 b8 77 02 80 00 00 	movabs $0x800277,%rax
  802823:	00 00 00 
  802826:	ff d0                	callq  *%rax
  802828:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  80282e:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  802835:	41 89 c8             	mov    %ecx,%r8d
  802838:	48 89 d1             	mov    %rdx,%rcx
  80283b:	48 89 da             	mov    %rbx,%rdx
  80283e:	89 c6                	mov    %eax,%esi
  802840:	48 bf 70 41 80 00 00 	movabs $0x804170,%rdi
  802847:	00 00 00 
  80284a:	b8 00 00 00 00       	mov    $0x0,%eax
  80284f:	49 b9 bf 29 80 00 00 	movabs $0x8029bf,%r9
  802856:	00 00 00 
  802859:	41 ff d1             	callq  *%r9
  80285c:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  802863:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  80286a:	48 89 d6             	mov    %rdx,%rsi
  80286d:	48 89 c7             	mov    %rax,%rdi
  802870:	48 b8 13 29 80 00 00 	movabs $0x802913,%rax
  802877:	00 00 00 
  80287a:	ff d0                	callq  *%rax
  80287c:	48 bf 93 41 80 00 00 	movabs $0x804193,%rdi
  802883:	00 00 00 
  802886:	b8 00 00 00 00       	mov    $0x0,%eax
  80288b:	48 ba bf 29 80 00 00 	movabs $0x8029bf,%rdx
  802892:	00 00 00 
  802895:	ff d2                	callq  *%rdx
  802897:	cc                   	int3   
  802898:	eb fd                	jmp    802897 <_panic+0x111>

000000000080289a <putch>:
  80289a:	55                   	push   %rbp
  80289b:	48 89 e5             	mov    %rsp,%rbp
  80289e:	48 83 ec 10          	sub    $0x10,%rsp
  8028a2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8028a5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8028a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028ad:	8b 00                	mov    (%rax),%eax
  8028af:	8d 48 01             	lea    0x1(%rax),%ecx
  8028b2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8028b6:	89 0a                	mov    %ecx,(%rdx)
  8028b8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8028bb:	89 d1                	mov    %edx,%ecx
  8028bd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8028c1:	48 98                	cltq   
  8028c3:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8028c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028cb:	8b 00                	mov    (%rax),%eax
  8028cd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8028d2:	75 2c                	jne    802900 <putch+0x66>
  8028d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028d8:	8b 00                	mov    (%rax),%eax
  8028da:	48 98                	cltq   
  8028dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8028e0:	48 83 c2 08          	add    $0x8,%rdx
  8028e4:	48 89 c6             	mov    %rax,%rsi
  8028e7:	48 89 d7             	mov    %rdx,%rdi
  8028ea:	48 b8 ab 01 80 00 00 	movabs $0x8001ab,%rax
  8028f1:	00 00 00 
  8028f4:	ff d0                	callq  *%rax
  8028f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028fa:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  802900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802904:	8b 40 04             	mov    0x4(%rax),%eax
  802907:	8d 50 01             	lea    0x1(%rax),%edx
  80290a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80290e:	89 50 04             	mov    %edx,0x4(%rax)
  802911:	c9                   	leaveq 
  802912:	c3                   	retq   

0000000000802913 <vcprintf>:
  802913:	55                   	push   %rbp
  802914:	48 89 e5             	mov    %rsp,%rbp
  802917:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80291e:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  802925:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80292c:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  802933:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  80293a:	48 8b 0a             	mov    (%rdx),%rcx
  80293d:	48 89 08             	mov    %rcx,(%rax)
  802940:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  802944:	48 89 48 08          	mov    %rcx,0x8(%rax)
  802948:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80294c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  802950:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  802957:	00 00 00 
  80295a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  802961:	00 00 00 
  802964:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  80296b:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  802972:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  802979:	48 89 c6             	mov    %rax,%rsi
  80297c:	48 bf 9a 28 80 00 00 	movabs $0x80289a,%rdi
  802983:	00 00 00 
  802986:	48 b8 72 2d 80 00 00 	movabs $0x802d72,%rax
  80298d:	00 00 00 
  802990:	ff d0                	callq  *%rax
  802992:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  802998:	48 98                	cltq   
  80299a:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8029a1:	48 83 c2 08          	add    $0x8,%rdx
  8029a5:	48 89 c6             	mov    %rax,%rsi
  8029a8:	48 89 d7             	mov    %rdx,%rdi
  8029ab:	48 b8 ab 01 80 00 00 	movabs $0x8001ab,%rax
  8029b2:	00 00 00 
  8029b5:	ff d0                	callq  *%rax
  8029b7:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8029bd:	c9                   	leaveq 
  8029be:	c3                   	retq   

00000000008029bf <cprintf>:
  8029bf:	55                   	push   %rbp
  8029c0:	48 89 e5             	mov    %rsp,%rbp
  8029c3:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8029ca:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8029d1:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8029d8:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8029df:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8029e6:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8029ed:	84 c0                	test   %al,%al
  8029ef:	74 20                	je     802a11 <cprintf+0x52>
  8029f1:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8029f5:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8029f9:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8029fd:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  802a01:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  802a05:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  802a09:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  802a0d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  802a11:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  802a18:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  802a1f:	00 00 00 
  802a22:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  802a29:	00 00 00 
  802a2c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  802a30:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  802a37:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  802a3e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  802a45:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  802a4c:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  802a53:	48 8b 0a             	mov    (%rdx),%rcx
  802a56:	48 89 08             	mov    %rcx,(%rax)
  802a59:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  802a5d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  802a61:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  802a65:	48 89 50 10          	mov    %rdx,0x10(%rax)
  802a69:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  802a70:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  802a77:	48 89 d6             	mov    %rdx,%rsi
  802a7a:	48 89 c7             	mov    %rax,%rdi
  802a7d:	48 b8 13 29 80 00 00 	movabs $0x802913,%rax
  802a84:	00 00 00 
  802a87:	ff d0                	callq  *%rax
  802a89:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  802a8f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  802a95:	c9                   	leaveq 
  802a96:	c3                   	retq   

0000000000802a97 <printnum>:
  802a97:	55                   	push   %rbp
  802a98:	48 89 e5             	mov    %rsp,%rbp
  802a9b:	53                   	push   %rbx
  802a9c:	48 83 ec 38          	sub    $0x38,%rsp
  802aa0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802aa4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802aa8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802aac:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  802aaf:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  802ab3:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  802ab7:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802aba:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802abe:	77 3b                	ja     802afb <printnum+0x64>
  802ac0:	8b 45 d0             	mov    -0x30(%rbp),%eax
  802ac3:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  802ac7:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  802aca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802ace:	ba 00 00 00 00       	mov    $0x0,%edx
  802ad3:	48 f7 f3             	div    %rbx
  802ad6:	48 89 c2             	mov    %rax,%rdx
  802ad9:	8b 7d cc             	mov    -0x34(%rbp),%edi
  802adc:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  802adf:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  802ae3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ae7:	41 89 f9             	mov    %edi,%r9d
  802aea:	48 89 c7             	mov    %rax,%rdi
  802aed:	48 b8 97 2a 80 00 00 	movabs $0x802a97,%rax
  802af4:	00 00 00 
  802af7:	ff d0                	callq  *%rax
  802af9:	eb 1e                	jmp    802b19 <printnum+0x82>
  802afb:	eb 12                	jmp    802b0f <printnum+0x78>
  802afd:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802b01:	8b 55 cc             	mov    -0x34(%rbp),%edx
  802b04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b08:	48 89 ce             	mov    %rcx,%rsi
  802b0b:	89 d7                	mov    %edx,%edi
  802b0d:	ff d0                	callq  *%rax
  802b0f:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  802b13:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  802b17:	7f e4                	jg     802afd <printnum+0x66>
  802b19:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  802b1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b20:	ba 00 00 00 00       	mov    $0x0,%edx
  802b25:	48 f7 f1             	div    %rcx
  802b28:	48 89 d0             	mov    %rdx,%rax
  802b2b:	48 ba 90 43 80 00 00 	movabs $0x804390,%rdx
  802b32:	00 00 00 
  802b35:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  802b39:	0f be d0             	movsbl %al,%edx
  802b3c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802b40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b44:	48 89 ce             	mov    %rcx,%rsi
  802b47:	89 d7                	mov    %edx,%edi
  802b49:	ff d0                	callq  *%rax
  802b4b:	48 83 c4 38          	add    $0x38,%rsp
  802b4f:	5b                   	pop    %rbx
  802b50:	5d                   	pop    %rbp
  802b51:	c3                   	retq   

0000000000802b52 <getuint>:
  802b52:	55                   	push   %rbp
  802b53:	48 89 e5             	mov    %rsp,%rbp
  802b56:	48 83 ec 1c          	sub    $0x1c,%rsp
  802b5a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802b5e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802b61:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  802b65:	7e 52                	jle    802bb9 <getuint+0x67>
  802b67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b6b:	8b 00                	mov    (%rax),%eax
  802b6d:	83 f8 30             	cmp    $0x30,%eax
  802b70:	73 24                	jae    802b96 <getuint+0x44>
  802b72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b76:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802b7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b7e:	8b 00                	mov    (%rax),%eax
  802b80:	89 c0                	mov    %eax,%eax
  802b82:	48 01 d0             	add    %rdx,%rax
  802b85:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802b89:	8b 12                	mov    (%rdx),%edx
  802b8b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802b8e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802b92:	89 0a                	mov    %ecx,(%rdx)
  802b94:	eb 17                	jmp    802bad <getuint+0x5b>
  802b96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b9a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802b9e:	48 89 d0             	mov    %rdx,%rax
  802ba1:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802ba5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802ba9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802bad:	48 8b 00             	mov    (%rax),%rax
  802bb0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802bb4:	e9 a3 00 00 00       	jmpq   802c5c <getuint+0x10a>
  802bb9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  802bbd:	74 4f                	je     802c0e <getuint+0xbc>
  802bbf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bc3:	8b 00                	mov    (%rax),%eax
  802bc5:	83 f8 30             	cmp    $0x30,%eax
  802bc8:	73 24                	jae    802bee <getuint+0x9c>
  802bca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bce:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802bd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bd6:	8b 00                	mov    (%rax),%eax
  802bd8:	89 c0                	mov    %eax,%eax
  802bda:	48 01 d0             	add    %rdx,%rax
  802bdd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802be1:	8b 12                	mov    (%rdx),%edx
  802be3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802be6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802bea:	89 0a                	mov    %ecx,(%rdx)
  802bec:	eb 17                	jmp    802c05 <getuint+0xb3>
  802bee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802bf2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802bf6:	48 89 d0             	mov    %rdx,%rax
  802bf9:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802bfd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c01:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802c05:	48 8b 00             	mov    (%rax),%rax
  802c08:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802c0c:	eb 4e                	jmp    802c5c <getuint+0x10a>
  802c0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c12:	8b 00                	mov    (%rax),%eax
  802c14:	83 f8 30             	cmp    $0x30,%eax
  802c17:	73 24                	jae    802c3d <getuint+0xeb>
  802c19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802c21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c25:	8b 00                	mov    (%rax),%eax
  802c27:	89 c0                	mov    %eax,%eax
  802c29:	48 01 d0             	add    %rdx,%rax
  802c2c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c30:	8b 12                	mov    (%rdx),%edx
  802c32:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802c35:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c39:	89 0a                	mov    %ecx,(%rdx)
  802c3b:	eb 17                	jmp    802c54 <getuint+0x102>
  802c3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c41:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802c45:	48 89 d0             	mov    %rdx,%rax
  802c48:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802c4c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802c54:	8b 00                	mov    (%rax),%eax
  802c56:	89 c0                	mov    %eax,%eax
  802c58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802c5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802c60:	c9                   	leaveq 
  802c61:	c3                   	retq   

0000000000802c62 <getint>:
  802c62:	55                   	push   %rbp
  802c63:	48 89 e5             	mov    %rsp,%rbp
  802c66:	48 83 ec 1c          	sub    $0x1c,%rsp
  802c6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802c6e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  802c71:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  802c75:	7e 52                	jle    802cc9 <getint+0x67>
  802c77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c7b:	8b 00                	mov    (%rax),%eax
  802c7d:	83 f8 30             	cmp    $0x30,%eax
  802c80:	73 24                	jae    802ca6 <getint+0x44>
  802c82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c86:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802c8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802c8e:	8b 00                	mov    (%rax),%eax
  802c90:	89 c0                	mov    %eax,%eax
  802c92:	48 01 d0             	add    %rdx,%rax
  802c95:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c99:	8b 12                	mov    (%rdx),%edx
  802c9b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802c9e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802ca2:	89 0a                	mov    %ecx,(%rdx)
  802ca4:	eb 17                	jmp    802cbd <getint+0x5b>
  802ca6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802caa:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802cae:	48 89 d0             	mov    %rdx,%rax
  802cb1:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802cb5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802cb9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802cbd:	48 8b 00             	mov    (%rax),%rax
  802cc0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802cc4:	e9 a3 00 00 00       	jmpq   802d6c <getint+0x10a>
  802cc9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  802ccd:	74 4f                	je     802d1e <getint+0xbc>
  802ccf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cd3:	8b 00                	mov    (%rax),%eax
  802cd5:	83 f8 30             	cmp    $0x30,%eax
  802cd8:	73 24                	jae    802cfe <getint+0x9c>
  802cda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802cde:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802ce2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ce6:	8b 00                	mov    (%rax),%eax
  802ce8:	89 c0                	mov    %eax,%eax
  802cea:	48 01 d0             	add    %rdx,%rax
  802ced:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802cf1:	8b 12                	mov    (%rdx),%edx
  802cf3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802cf6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802cfa:	89 0a                	mov    %ecx,(%rdx)
  802cfc:	eb 17                	jmp    802d15 <getint+0xb3>
  802cfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d02:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802d06:	48 89 d0             	mov    %rdx,%rax
  802d09:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802d0d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802d15:	48 8b 00             	mov    (%rax),%rax
  802d18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802d1c:	eb 4e                	jmp    802d6c <getint+0x10a>
  802d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d22:	8b 00                	mov    (%rax),%eax
  802d24:	83 f8 30             	cmp    $0x30,%eax
  802d27:	73 24                	jae    802d4d <getint+0xeb>
  802d29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d2d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802d31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d35:	8b 00                	mov    (%rax),%eax
  802d37:	89 c0                	mov    %eax,%eax
  802d39:	48 01 d0             	add    %rdx,%rax
  802d3c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d40:	8b 12                	mov    (%rdx),%edx
  802d42:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802d45:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d49:	89 0a                	mov    %ecx,(%rdx)
  802d4b:	eb 17                	jmp    802d64 <getint+0x102>
  802d4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d51:	48 8b 50 08          	mov    0x8(%rax),%rdx
  802d55:	48 89 d0             	mov    %rdx,%rax
  802d58:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  802d5c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802d60:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802d64:	8b 00                	mov    (%rax),%eax
  802d66:	48 98                	cltq   
  802d68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802d6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802d70:	c9                   	leaveq 
  802d71:	c3                   	retq   

0000000000802d72 <vprintfmt>:
  802d72:	55                   	push   %rbp
  802d73:	48 89 e5             	mov    %rsp,%rbp
  802d76:	41 54                	push   %r12
  802d78:	53                   	push   %rbx
  802d79:	48 83 ec 60          	sub    $0x60,%rsp
  802d7d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  802d81:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  802d85:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  802d89:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  802d8d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  802d91:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  802d95:	48 8b 0a             	mov    (%rdx),%rcx
  802d98:	48 89 08             	mov    %rcx,(%rax)
  802d9b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  802d9f:	48 89 48 08          	mov    %rcx,0x8(%rax)
  802da3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  802da7:	48 89 50 10          	mov    %rdx,0x10(%rax)
  802dab:	eb 17                	jmp    802dc4 <vprintfmt+0x52>
  802dad:	85 db                	test   %ebx,%ebx
  802daf:	0f 84 cc 04 00 00    	je     803281 <vprintfmt+0x50f>
  802db5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  802db9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  802dbd:	48 89 d6             	mov    %rdx,%rsi
  802dc0:	89 df                	mov    %ebx,%edi
  802dc2:	ff d0                	callq  *%rax
  802dc4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802dc8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802dcc:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  802dd0:	0f b6 00             	movzbl (%rax),%eax
  802dd3:	0f b6 d8             	movzbl %al,%ebx
  802dd6:	83 fb 25             	cmp    $0x25,%ebx
  802dd9:	75 d2                	jne    802dad <vprintfmt+0x3b>
  802ddb:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  802ddf:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  802de6:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  802ded:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  802df4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  802dfb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802dff:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802e03:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  802e07:	0f b6 00             	movzbl (%rax),%eax
  802e0a:	0f b6 d8             	movzbl %al,%ebx
  802e0d:	8d 43 dd             	lea    -0x23(%rbx),%eax
  802e10:	83 f8 55             	cmp    $0x55,%eax
  802e13:	0f 87 34 04 00 00    	ja     80324d <vprintfmt+0x4db>
  802e19:	89 c0                	mov    %eax,%eax
  802e1b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  802e22:	00 
  802e23:	48 b8 b8 43 80 00 00 	movabs $0x8043b8,%rax
  802e2a:	00 00 00 
  802e2d:	48 01 d0             	add    %rdx,%rax
  802e30:	48 8b 00             	mov    (%rax),%rax
  802e33:	ff e0                	jmpq   *%rax
  802e35:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  802e39:	eb c0                	jmp    802dfb <vprintfmt+0x89>
  802e3b:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  802e3f:	eb ba                	jmp    802dfb <vprintfmt+0x89>
  802e41:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  802e48:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802e4b:	89 d0                	mov    %edx,%eax
  802e4d:	c1 e0 02             	shl    $0x2,%eax
  802e50:	01 d0                	add    %edx,%eax
  802e52:	01 c0                	add    %eax,%eax
  802e54:	01 d8                	add    %ebx,%eax
  802e56:	83 e8 30             	sub    $0x30,%eax
  802e59:	89 45 d8             	mov    %eax,-0x28(%rbp)
  802e5c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802e60:	0f b6 00             	movzbl (%rax),%eax
  802e63:	0f be d8             	movsbl %al,%ebx
  802e66:	83 fb 2f             	cmp    $0x2f,%ebx
  802e69:	7e 0c                	jle    802e77 <vprintfmt+0x105>
  802e6b:	83 fb 39             	cmp    $0x39,%ebx
  802e6e:	7f 07                	jg     802e77 <vprintfmt+0x105>
  802e70:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  802e75:	eb d1                	jmp    802e48 <vprintfmt+0xd6>
  802e77:	eb 58                	jmp    802ed1 <vprintfmt+0x15f>
  802e79:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802e7c:	83 f8 30             	cmp    $0x30,%eax
  802e7f:	73 17                	jae    802e98 <vprintfmt+0x126>
  802e81:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802e85:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802e88:	89 c0                	mov    %eax,%eax
  802e8a:	48 01 d0             	add    %rdx,%rax
  802e8d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  802e90:	83 c2 08             	add    $0x8,%edx
  802e93:	89 55 b8             	mov    %edx,-0x48(%rbp)
  802e96:	eb 0f                	jmp    802ea7 <vprintfmt+0x135>
  802e98:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  802e9c:	48 89 d0             	mov    %rdx,%rax
  802e9f:	48 83 c2 08          	add    $0x8,%rdx
  802ea3:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  802ea7:	8b 00                	mov    (%rax),%eax
  802ea9:	89 45 d8             	mov    %eax,-0x28(%rbp)
  802eac:	eb 23                	jmp    802ed1 <vprintfmt+0x15f>
  802eae:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  802eb2:	79 0c                	jns    802ec0 <vprintfmt+0x14e>
  802eb4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  802ebb:	e9 3b ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802ec0:	e9 36 ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802ec5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  802ecc:	e9 2a ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802ed1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  802ed5:	79 12                	jns    802ee9 <vprintfmt+0x177>
  802ed7:	8b 45 d8             	mov    -0x28(%rbp),%eax
  802eda:	89 45 dc             	mov    %eax,-0x24(%rbp)
  802edd:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  802ee4:	e9 12 ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802ee9:	e9 0d ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802eee:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  802ef2:	e9 04 ff ff ff       	jmpq   802dfb <vprintfmt+0x89>
  802ef7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802efa:	83 f8 30             	cmp    $0x30,%eax
  802efd:	73 17                	jae    802f16 <vprintfmt+0x1a4>
  802eff:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802f03:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802f06:	89 c0                	mov    %eax,%eax
  802f08:	48 01 d0             	add    %rdx,%rax
  802f0b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  802f0e:	83 c2 08             	add    $0x8,%edx
  802f11:	89 55 b8             	mov    %edx,-0x48(%rbp)
  802f14:	eb 0f                	jmp    802f25 <vprintfmt+0x1b3>
  802f16:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  802f1a:	48 89 d0             	mov    %rdx,%rax
  802f1d:	48 83 c2 08          	add    $0x8,%rdx
  802f21:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  802f25:	8b 10                	mov    (%rax),%edx
  802f27:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  802f2b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  802f2f:	48 89 ce             	mov    %rcx,%rsi
  802f32:	89 d7                	mov    %edx,%edi
  802f34:	ff d0                	callq  *%rax
  802f36:	e9 40 03 00 00       	jmpq   80327b <vprintfmt+0x509>
  802f3b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802f3e:	83 f8 30             	cmp    $0x30,%eax
  802f41:	73 17                	jae    802f5a <vprintfmt+0x1e8>
  802f43:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802f47:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802f4a:	89 c0                	mov    %eax,%eax
  802f4c:	48 01 d0             	add    %rdx,%rax
  802f4f:	8b 55 b8             	mov    -0x48(%rbp),%edx
  802f52:	83 c2 08             	add    $0x8,%edx
  802f55:	89 55 b8             	mov    %edx,-0x48(%rbp)
  802f58:	eb 0f                	jmp    802f69 <vprintfmt+0x1f7>
  802f5a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  802f5e:	48 89 d0             	mov    %rdx,%rax
  802f61:	48 83 c2 08          	add    $0x8,%rdx
  802f65:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  802f69:	8b 18                	mov    (%rax),%ebx
  802f6b:	85 db                	test   %ebx,%ebx
  802f6d:	79 02                	jns    802f71 <vprintfmt+0x1ff>
  802f6f:	f7 db                	neg    %ebx
  802f71:	83 fb 15             	cmp    $0x15,%ebx
  802f74:	7f 16                	jg     802f8c <vprintfmt+0x21a>
  802f76:	48 b8 e0 42 80 00 00 	movabs $0x8042e0,%rax
  802f7d:	00 00 00 
  802f80:	48 63 d3             	movslq %ebx,%rdx
  802f83:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  802f87:	4d 85 e4             	test   %r12,%r12
  802f8a:	75 2e                	jne    802fba <vprintfmt+0x248>
  802f8c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  802f90:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  802f94:	89 d9                	mov    %ebx,%ecx
  802f96:	48 ba a1 43 80 00 00 	movabs $0x8043a1,%rdx
  802f9d:	00 00 00 
  802fa0:	48 89 c7             	mov    %rax,%rdi
  802fa3:	b8 00 00 00 00       	mov    $0x0,%eax
  802fa8:	49 b8 8a 32 80 00 00 	movabs $0x80328a,%r8
  802faf:	00 00 00 
  802fb2:	41 ff d0             	callq  *%r8
  802fb5:	e9 c1 02 00 00       	jmpq   80327b <vprintfmt+0x509>
  802fba:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  802fbe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  802fc2:	4c 89 e1             	mov    %r12,%rcx
  802fc5:	48 ba aa 43 80 00 00 	movabs $0x8043aa,%rdx
  802fcc:	00 00 00 
  802fcf:	48 89 c7             	mov    %rax,%rdi
  802fd2:	b8 00 00 00 00       	mov    $0x0,%eax
  802fd7:	49 b8 8a 32 80 00 00 	movabs $0x80328a,%r8
  802fde:	00 00 00 
  802fe1:	41 ff d0             	callq  *%r8
  802fe4:	e9 92 02 00 00       	jmpq   80327b <vprintfmt+0x509>
  802fe9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802fec:	83 f8 30             	cmp    $0x30,%eax
  802fef:	73 17                	jae    803008 <vprintfmt+0x296>
  802ff1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802ff5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  802ff8:	89 c0                	mov    %eax,%eax
  802ffa:	48 01 d0             	add    %rdx,%rax
  802ffd:	8b 55 b8             	mov    -0x48(%rbp),%edx
  803000:	83 c2 08             	add    $0x8,%edx
  803003:	89 55 b8             	mov    %edx,-0x48(%rbp)
  803006:	eb 0f                	jmp    803017 <vprintfmt+0x2a5>
  803008:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80300c:	48 89 d0             	mov    %rdx,%rax
  80300f:	48 83 c2 08          	add    $0x8,%rdx
  803013:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  803017:	4c 8b 20             	mov    (%rax),%r12
  80301a:	4d 85 e4             	test   %r12,%r12
  80301d:	75 0a                	jne    803029 <vprintfmt+0x2b7>
  80301f:	49 bc ad 43 80 00 00 	movabs $0x8043ad,%r12
  803026:	00 00 00 
  803029:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80302d:	7e 3f                	jle    80306e <vprintfmt+0x2fc>
  80302f:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  803033:	74 39                	je     80306e <vprintfmt+0x2fc>
  803035:	8b 45 d8             	mov    -0x28(%rbp),%eax
  803038:	48 98                	cltq   
  80303a:	48 89 c6             	mov    %rax,%rsi
  80303d:	4c 89 e7             	mov    %r12,%rdi
  803040:	48 b8 36 35 80 00 00 	movabs $0x803536,%rax
  803047:	00 00 00 
  80304a:	ff d0                	callq  *%rax
  80304c:	29 45 dc             	sub    %eax,-0x24(%rbp)
  80304f:	eb 17                	jmp    803068 <vprintfmt+0x2f6>
  803051:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  803055:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  803059:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80305d:	48 89 ce             	mov    %rcx,%rsi
  803060:	89 d7                	mov    %edx,%edi
  803062:	ff d0                	callq  *%rax
  803064:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  803068:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80306c:	7f e3                	jg     803051 <vprintfmt+0x2df>
  80306e:	eb 37                	jmp    8030a7 <vprintfmt+0x335>
  803070:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  803074:	74 1e                	je     803094 <vprintfmt+0x322>
  803076:	83 fb 1f             	cmp    $0x1f,%ebx
  803079:	7e 05                	jle    803080 <vprintfmt+0x30e>
  80307b:	83 fb 7e             	cmp    $0x7e,%ebx
  80307e:	7e 14                	jle    803094 <vprintfmt+0x322>
  803080:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803084:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803088:	48 89 d6             	mov    %rdx,%rsi
  80308b:	bf 3f 00 00 00       	mov    $0x3f,%edi
  803090:	ff d0                	callq  *%rax
  803092:	eb 0f                	jmp    8030a3 <vprintfmt+0x331>
  803094:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803098:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80309c:	48 89 d6             	mov    %rdx,%rsi
  80309f:	89 df                	mov    %ebx,%edi
  8030a1:	ff d0                	callq  *%rax
  8030a3:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  8030a7:	4c 89 e0             	mov    %r12,%rax
  8030aa:	4c 8d 60 01          	lea    0x1(%rax),%r12
  8030ae:	0f b6 00             	movzbl (%rax),%eax
  8030b1:	0f be d8             	movsbl %al,%ebx
  8030b4:	85 db                	test   %ebx,%ebx
  8030b6:	74 10                	je     8030c8 <vprintfmt+0x356>
  8030b8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8030bc:	78 b2                	js     803070 <vprintfmt+0x2fe>
  8030be:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  8030c2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8030c6:	79 a8                	jns    803070 <vprintfmt+0x2fe>
  8030c8:	eb 16                	jmp    8030e0 <vprintfmt+0x36e>
  8030ca:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8030ce:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8030d2:	48 89 d6             	mov    %rdx,%rsi
  8030d5:	bf 20 00 00 00       	mov    $0x20,%edi
  8030da:	ff d0                	callq  *%rax
  8030dc:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  8030e0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8030e4:	7f e4                	jg     8030ca <vprintfmt+0x358>
  8030e6:	e9 90 01 00 00       	jmpq   80327b <vprintfmt+0x509>
  8030eb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8030ef:	be 03 00 00 00       	mov    $0x3,%esi
  8030f4:	48 89 c7             	mov    %rax,%rdi
  8030f7:	48 b8 62 2c 80 00 00 	movabs $0x802c62,%rax
  8030fe:	00 00 00 
  803101:	ff d0                	callq  *%rax
  803103:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803107:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80310b:	48 85 c0             	test   %rax,%rax
  80310e:	79 1d                	jns    80312d <vprintfmt+0x3bb>
  803110:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803114:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803118:	48 89 d6             	mov    %rdx,%rsi
  80311b:	bf 2d 00 00 00       	mov    $0x2d,%edi
  803120:	ff d0                	callq  *%rax
  803122:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803126:	48 f7 d8             	neg    %rax
  803129:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80312d:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  803134:	e9 d5 00 00 00       	jmpq   80320e <vprintfmt+0x49c>
  803139:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80313d:	be 03 00 00 00       	mov    $0x3,%esi
  803142:	48 89 c7             	mov    %rax,%rdi
  803145:	48 b8 52 2b 80 00 00 	movabs $0x802b52,%rax
  80314c:	00 00 00 
  80314f:	ff d0                	callq  *%rax
  803151:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803155:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  80315c:	e9 ad 00 00 00       	jmpq   80320e <vprintfmt+0x49c>
  803161:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  803165:	be 03 00 00 00       	mov    $0x3,%esi
  80316a:	48 89 c7             	mov    %rax,%rdi
  80316d:	48 b8 52 2b 80 00 00 	movabs $0x802b52,%rax
  803174:	00 00 00 
  803177:	ff d0                	callq  *%rax
  803179:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80317d:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  803184:	e9 85 00 00 00       	jmpq   80320e <vprintfmt+0x49c>
  803189:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80318d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803191:	48 89 d6             	mov    %rdx,%rsi
  803194:	bf 30 00 00 00       	mov    $0x30,%edi
  803199:	ff d0                	callq  *%rax
  80319b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80319f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8031a3:	48 89 d6             	mov    %rdx,%rsi
  8031a6:	bf 78 00 00 00       	mov    $0x78,%edi
  8031ab:	ff d0                	callq  *%rax
  8031ad:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8031b0:	83 f8 30             	cmp    $0x30,%eax
  8031b3:	73 17                	jae    8031cc <vprintfmt+0x45a>
  8031b5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8031b9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8031bc:	89 c0                	mov    %eax,%eax
  8031be:	48 01 d0             	add    %rdx,%rax
  8031c1:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8031c4:	83 c2 08             	add    $0x8,%edx
  8031c7:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8031ca:	eb 0f                	jmp    8031db <vprintfmt+0x469>
  8031cc:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8031d0:	48 89 d0             	mov    %rdx,%rax
  8031d3:	48 83 c2 08          	add    $0x8,%rdx
  8031d7:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8031db:	48 8b 00             	mov    (%rax),%rax
  8031de:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8031e2:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8031e9:	eb 23                	jmp    80320e <vprintfmt+0x49c>
  8031eb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8031ef:	be 03 00 00 00       	mov    $0x3,%esi
  8031f4:	48 89 c7             	mov    %rax,%rdi
  8031f7:	48 b8 52 2b 80 00 00 	movabs $0x802b52,%rax
  8031fe:	00 00 00 
  803201:	ff d0                	callq  *%rax
  803203:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803207:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  80320e:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  803213:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  803216:	8b 7d dc             	mov    -0x24(%rbp),%edi
  803219:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80321d:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  803221:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803225:	45 89 c1             	mov    %r8d,%r9d
  803228:	41 89 f8             	mov    %edi,%r8d
  80322b:	48 89 c7             	mov    %rax,%rdi
  80322e:	48 b8 97 2a 80 00 00 	movabs $0x802a97,%rax
  803235:	00 00 00 
  803238:	ff d0                	callq  *%rax
  80323a:	eb 3f                	jmp    80327b <vprintfmt+0x509>
  80323c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803240:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803244:	48 89 d6             	mov    %rdx,%rsi
  803247:	89 df                	mov    %ebx,%edi
  803249:	ff d0                	callq  *%rax
  80324b:	eb 2e                	jmp    80327b <vprintfmt+0x509>
  80324d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  803251:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  803255:	48 89 d6             	mov    %rdx,%rsi
  803258:	bf 25 00 00 00       	mov    $0x25,%edi
  80325d:	ff d0                	callq  *%rax
  80325f:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  803264:	eb 05                	jmp    80326b <vprintfmt+0x4f9>
  803266:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80326b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80326f:	48 83 e8 01          	sub    $0x1,%rax
  803273:	0f b6 00             	movzbl (%rax),%eax
  803276:	3c 25                	cmp    $0x25,%al
  803278:	75 ec                	jne    803266 <vprintfmt+0x4f4>
  80327a:	90                   	nop
  80327b:	90                   	nop
  80327c:	e9 43 fb ff ff       	jmpq   802dc4 <vprintfmt+0x52>
  803281:	48 83 c4 60          	add    $0x60,%rsp
  803285:	5b                   	pop    %rbx
  803286:	41 5c                	pop    %r12
  803288:	5d                   	pop    %rbp
  803289:	c3                   	retq   

000000000080328a <printfmt>:
  80328a:	55                   	push   %rbp
  80328b:	48 89 e5             	mov    %rsp,%rbp
  80328e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  803295:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  80329c:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  8032a3:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8032aa:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8032b1:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8032b8:	84 c0                	test   %al,%al
  8032ba:	74 20                	je     8032dc <printfmt+0x52>
  8032bc:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8032c0:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8032c4:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8032c8:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8032cc:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8032d0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8032d4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8032d8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8032dc:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  8032e3:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  8032ea:	00 00 00 
  8032ed:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  8032f4:	00 00 00 
  8032f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8032fb:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  803302:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  803309:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  803310:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  803317:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  80331e:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  803325:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  80332c:	48 89 c7             	mov    %rax,%rdi
  80332f:	48 b8 72 2d 80 00 00 	movabs $0x802d72,%rax
  803336:	00 00 00 
  803339:	ff d0                	callq  *%rax
  80333b:	c9                   	leaveq 
  80333c:	c3                   	retq   

000000000080333d <sprintputch>:
  80333d:	55                   	push   %rbp
  80333e:	48 89 e5             	mov    %rsp,%rbp
  803341:	48 83 ec 10          	sub    $0x10,%rsp
  803345:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803348:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80334c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803350:	8b 40 10             	mov    0x10(%rax),%eax
  803353:	8d 50 01             	lea    0x1(%rax),%edx
  803356:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80335a:	89 50 10             	mov    %edx,0x10(%rax)
  80335d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803361:	48 8b 10             	mov    (%rax),%rdx
  803364:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803368:	48 8b 40 08          	mov    0x8(%rax),%rax
  80336c:	48 39 c2             	cmp    %rax,%rdx
  80336f:	73 17                	jae    803388 <sprintputch+0x4b>
  803371:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803375:	48 8b 00             	mov    (%rax),%rax
  803378:	48 8d 48 01          	lea    0x1(%rax),%rcx
  80337c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803380:	48 89 0a             	mov    %rcx,(%rdx)
  803383:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803386:	88 10                	mov    %dl,(%rax)
  803388:	c9                   	leaveq 
  803389:	c3                   	retq   

000000000080338a <vsnprintf>:
  80338a:	55                   	push   %rbp
  80338b:	48 89 e5             	mov    %rsp,%rbp
  80338e:	48 83 ec 50          	sub    $0x50,%rsp
  803392:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  803396:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  803399:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  80339d:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  8033a1:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  8033a5:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  8033a9:	48 8b 0a             	mov    (%rdx),%rcx
  8033ac:	48 89 08             	mov    %rcx,(%rax)
  8033af:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8033b3:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8033b7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8033bb:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8033bf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8033c3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  8033c7:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  8033ca:	48 98                	cltq   
  8033cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8033d0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8033d4:	48 01 d0             	add    %rdx,%rax
  8033d7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  8033db:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8033e2:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  8033e7:	74 06                	je     8033ef <vsnprintf+0x65>
  8033e9:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  8033ed:	7f 07                	jg     8033f6 <vsnprintf+0x6c>
  8033ef:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8033f4:	eb 2f                	jmp    803425 <vsnprintf+0x9b>
  8033f6:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  8033fa:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  8033fe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803402:	48 89 c6             	mov    %rax,%rsi
  803405:	48 bf 3d 33 80 00 00 	movabs $0x80333d,%rdi
  80340c:	00 00 00 
  80340f:	48 b8 72 2d 80 00 00 	movabs $0x802d72,%rax
  803416:	00 00 00 
  803419:	ff d0                	callq  *%rax
  80341b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80341f:	c6 00 00             	movb   $0x0,(%rax)
  803422:	8b 45 e0             	mov    -0x20(%rbp),%eax
  803425:	c9                   	leaveq 
  803426:	c3                   	retq   

0000000000803427 <snprintf>:
  803427:	55                   	push   %rbp
  803428:	48 89 e5             	mov    %rsp,%rbp
  80342b:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  803432:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  803439:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  80343f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  803446:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80344d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  803454:	84 c0                	test   %al,%al
  803456:	74 20                	je     803478 <snprintf+0x51>
  803458:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80345c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  803460:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  803464:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  803468:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80346c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  803470:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  803474:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  803478:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  80347f:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  803486:	00 00 00 
  803489:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  803490:	00 00 00 
  803493:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803497:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  80349e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8034a5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8034ac:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  8034b3:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  8034ba:	48 8b 0a             	mov    (%rdx),%rcx
  8034bd:	48 89 08             	mov    %rcx,(%rax)
  8034c0:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8034c4:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8034c8:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8034cc:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8034d0:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  8034d7:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  8034de:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  8034e4:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8034eb:	48 89 c7             	mov    %rax,%rdi
  8034ee:	48 b8 8a 33 80 00 00 	movabs $0x80338a,%rax
  8034f5:	00 00 00 
  8034f8:	ff d0                	callq  *%rax
  8034fa:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  803500:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  803506:	c9                   	leaveq 
  803507:	c3                   	retq   

0000000000803508 <strlen>:
  803508:	55                   	push   %rbp
  803509:	48 89 e5             	mov    %rsp,%rbp
  80350c:	48 83 ec 18          	sub    $0x18,%rsp
  803510:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803514:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80351b:	eb 09                	jmp    803526 <strlen+0x1e>
  80351d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803521:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  803526:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80352a:	0f b6 00             	movzbl (%rax),%eax
  80352d:	84 c0                	test   %al,%al
  80352f:	75 ec                	jne    80351d <strlen+0x15>
  803531:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803534:	c9                   	leaveq 
  803535:	c3                   	retq   

0000000000803536 <strnlen>:
  803536:	55                   	push   %rbp
  803537:	48 89 e5             	mov    %rsp,%rbp
  80353a:	48 83 ec 20          	sub    $0x20,%rsp
  80353e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803542:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80354d:	eb 0e                	jmp    80355d <strnlen+0x27>
  80354f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803553:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  803558:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  80355d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803562:	74 0b                	je     80356f <strnlen+0x39>
  803564:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803568:	0f b6 00             	movzbl (%rax),%eax
  80356b:	84 c0                	test   %al,%al
  80356d:	75 e0                	jne    80354f <strnlen+0x19>
  80356f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803572:	c9                   	leaveq 
  803573:	c3                   	retq   

0000000000803574 <strcpy>:
  803574:	55                   	push   %rbp
  803575:	48 89 e5             	mov    %rsp,%rbp
  803578:	48 83 ec 20          	sub    $0x20,%rsp
  80357c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803580:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803584:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803588:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80358c:	90                   	nop
  80358d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803591:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803595:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803599:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80359d:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8035a1:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8035a5:	0f b6 12             	movzbl (%rdx),%edx
  8035a8:	88 10                	mov    %dl,(%rax)
  8035aa:	0f b6 00             	movzbl (%rax),%eax
  8035ad:	84 c0                	test   %al,%al
  8035af:	75 dc                	jne    80358d <strcpy+0x19>
  8035b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8035b5:	c9                   	leaveq 
  8035b6:	c3                   	retq   

00000000008035b7 <strcat>:
  8035b7:	55                   	push   %rbp
  8035b8:	48 89 e5             	mov    %rsp,%rbp
  8035bb:	48 83 ec 20          	sub    $0x20,%rsp
  8035bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8035c3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8035c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035cb:	48 89 c7             	mov    %rax,%rdi
  8035ce:	48 b8 08 35 80 00 00 	movabs $0x803508,%rax
  8035d5:	00 00 00 
  8035d8:	ff d0                	callq  *%rax
  8035da:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8035dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8035e0:	48 63 d0             	movslq %eax,%rdx
  8035e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8035e7:	48 01 c2             	add    %rax,%rdx
  8035ea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8035ee:	48 89 c6             	mov    %rax,%rsi
  8035f1:	48 89 d7             	mov    %rdx,%rdi
  8035f4:	48 b8 74 35 80 00 00 	movabs $0x803574,%rax
  8035fb:	00 00 00 
  8035fe:	ff d0                	callq  *%rax
  803600:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803604:	c9                   	leaveq 
  803605:	c3                   	retq   

0000000000803606 <strncpy>:
  803606:	55                   	push   %rbp
  803607:	48 89 e5             	mov    %rsp,%rbp
  80360a:	48 83 ec 28          	sub    $0x28,%rsp
  80360e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803612:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803616:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80361a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80361e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803622:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803629:	00 
  80362a:	eb 2a                	jmp    803656 <strncpy+0x50>
  80362c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803630:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803634:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803638:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80363c:	0f b6 12             	movzbl (%rdx),%edx
  80363f:	88 10                	mov    %dl,(%rax)
  803641:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803645:	0f b6 00             	movzbl (%rax),%eax
  803648:	84 c0                	test   %al,%al
  80364a:	74 05                	je     803651 <strncpy+0x4b>
  80364c:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  803651:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803656:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80365a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80365e:	72 cc                	jb     80362c <strncpy+0x26>
  803660:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803664:	c9                   	leaveq 
  803665:	c3                   	retq   

0000000000803666 <strlcpy>:
  803666:	55                   	push   %rbp
  803667:	48 89 e5             	mov    %rsp,%rbp
  80366a:	48 83 ec 28          	sub    $0x28,%rsp
  80366e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803672:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803676:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  80367a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80367e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803682:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803687:	74 3d                	je     8036c6 <strlcpy+0x60>
  803689:	eb 1d                	jmp    8036a8 <strlcpy+0x42>
  80368b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80368f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803693:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803697:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80369b:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80369f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8036a3:	0f b6 12             	movzbl (%rdx),%edx
  8036a6:	88 10                	mov    %dl,(%rax)
  8036a8:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8036ad:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8036b2:	74 0b                	je     8036bf <strlcpy+0x59>
  8036b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036b8:	0f b6 00             	movzbl (%rax),%eax
  8036bb:	84 c0                	test   %al,%al
  8036bd:	75 cc                	jne    80368b <strlcpy+0x25>
  8036bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8036c3:	c6 00 00             	movb   $0x0,(%rax)
  8036c6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8036ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8036ce:	48 29 c2             	sub    %rax,%rdx
  8036d1:	48 89 d0             	mov    %rdx,%rax
  8036d4:	c9                   	leaveq 
  8036d5:	c3                   	retq   

00000000008036d6 <strcmp>:
  8036d6:	55                   	push   %rbp
  8036d7:	48 89 e5             	mov    %rsp,%rbp
  8036da:	48 83 ec 10          	sub    $0x10,%rsp
  8036de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8036e2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8036e6:	eb 0a                	jmp    8036f2 <strcmp+0x1c>
  8036e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8036ed:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8036f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8036f6:	0f b6 00             	movzbl (%rax),%eax
  8036f9:	84 c0                	test   %al,%al
  8036fb:	74 12                	je     80370f <strcmp+0x39>
  8036fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803701:	0f b6 10             	movzbl (%rax),%edx
  803704:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803708:	0f b6 00             	movzbl (%rax),%eax
  80370b:	38 c2                	cmp    %al,%dl
  80370d:	74 d9                	je     8036e8 <strcmp+0x12>
  80370f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803713:	0f b6 00             	movzbl (%rax),%eax
  803716:	0f b6 d0             	movzbl %al,%edx
  803719:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80371d:	0f b6 00             	movzbl (%rax),%eax
  803720:	0f b6 c0             	movzbl %al,%eax
  803723:	29 c2                	sub    %eax,%edx
  803725:	89 d0                	mov    %edx,%eax
  803727:	c9                   	leaveq 
  803728:	c3                   	retq   

0000000000803729 <strncmp>:
  803729:	55                   	push   %rbp
  80372a:	48 89 e5             	mov    %rsp,%rbp
  80372d:	48 83 ec 18          	sub    $0x18,%rsp
  803731:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803735:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803739:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80373d:	eb 0f                	jmp    80374e <strncmp+0x25>
  80373f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  803744:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803749:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80374e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803753:	74 1d                	je     803772 <strncmp+0x49>
  803755:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803759:	0f b6 00             	movzbl (%rax),%eax
  80375c:	84 c0                	test   %al,%al
  80375e:	74 12                	je     803772 <strncmp+0x49>
  803760:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803764:	0f b6 10             	movzbl (%rax),%edx
  803767:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80376b:	0f b6 00             	movzbl (%rax),%eax
  80376e:	38 c2                	cmp    %al,%dl
  803770:	74 cd                	je     80373f <strncmp+0x16>
  803772:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803777:	75 07                	jne    803780 <strncmp+0x57>
  803779:	b8 00 00 00 00       	mov    $0x0,%eax
  80377e:	eb 18                	jmp    803798 <strncmp+0x6f>
  803780:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803784:	0f b6 00             	movzbl (%rax),%eax
  803787:	0f b6 d0             	movzbl %al,%edx
  80378a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80378e:	0f b6 00             	movzbl (%rax),%eax
  803791:	0f b6 c0             	movzbl %al,%eax
  803794:	29 c2                	sub    %eax,%edx
  803796:	89 d0                	mov    %edx,%eax
  803798:	c9                   	leaveq 
  803799:	c3                   	retq   

000000000080379a <strchr>:
  80379a:	55                   	push   %rbp
  80379b:	48 89 e5             	mov    %rsp,%rbp
  80379e:	48 83 ec 0c          	sub    $0xc,%rsp
  8037a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037a6:	89 f0                	mov    %esi,%eax
  8037a8:	88 45 f4             	mov    %al,-0xc(%rbp)
  8037ab:	eb 17                	jmp    8037c4 <strchr+0x2a>
  8037ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037b1:	0f b6 00             	movzbl (%rax),%eax
  8037b4:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8037b7:	75 06                	jne    8037bf <strchr+0x25>
  8037b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037bd:	eb 15                	jmp    8037d4 <strchr+0x3a>
  8037bf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8037c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037c8:	0f b6 00             	movzbl (%rax),%eax
  8037cb:	84 c0                	test   %al,%al
  8037cd:	75 de                	jne    8037ad <strchr+0x13>
  8037cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8037d4:	c9                   	leaveq 
  8037d5:	c3                   	retq   

00000000008037d6 <strfind>:
  8037d6:	55                   	push   %rbp
  8037d7:	48 89 e5             	mov    %rsp,%rbp
  8037da:	48 83 ec 0c          	sub    $0xc,%rsp
  8037de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8037e2:	89 f0                	mov    %esi,%eax
  8037e4:	88 45 f4             	mov    %al,-0xc(%rbp)
  8037e7:	eb 13                	jmp    8037fc <strfind+0x26>
  8037e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8037ed:	0f b6 00             	movzbl (%rax),%eax
  8037f0:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8037f3:	75 02                	jne    8037f7 <strfind+0x21>
  8037f5:	eb 10                	jmp    803807 <strfind+0x31>
  8037f7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8037fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803800:	0f b6 00             	movzbl (%rax),%eax
  803803:	84 c0                	test   %al,%al
  803805:	75 e2                	jne    8037e9 <strfind+0x13>
  803807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80380b:	c9                   	leaveq 
  80380c:	c3                   	retq   

000000000080380d <memset>:
  80380d:	55                   	push   %rbp
  80380e:	48 89 e5             	mov    %rsp,%rbp
  803811:	48 83 ec 18          	sub    $0x18,%rsp
  803815:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803819:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80381c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803820:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803825:	75 06                	jne    80382d <memset+0x20>
  803827:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80382b:	eb 69                	jmp    803896 <memset+0x89>
  80382d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803831:	83 e0 03             	and    $0x3,%eax
  803834:	48 85 c0             	test   %rax,%rax
  803837:	75 48                	jne    803881 <memset+0x74>
  803839:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80383d:	83 e0 03             	and    $0x3,%eax
  803840:	48 85 c0             	test   %rax,%rax
  803843:	75 3c                	jne    803881 <memset+0x74>
  803845:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80384c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80384f:	c1 e0 18             	shl    $0x18,%eax
  803852:	89 c2                	mov    %eax,%edx
  803854:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803857:	c1 e0 10             	shl    $0x10,%eax
  80385a:	09 c2                	or     %eax,%edx
  80385c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80385f:	c1 e0 08             	shl    $0x8,%eax
  803862:	09 d0                	or     %edx,%eax
  803864:	09 45 f4             	or     %eax,-0xc(%rbp)
  803867:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80386b:	48 c1 e8 02          	shr    $0x2,%rax
  80386f:	48 89 c1             	mov    %rax,%rcx
  803872:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803876:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803879:	48 89 d7             	mov    %rdx,%rdi
  80387c:	fc                   	cld    
  80387d:	f3 ab                	rep stos %eax,%es:(%rdi)
  80387f:	eb 11                	jmp    803892 <memset+0x85>
  803881:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803885:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803888:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80388c:	48 89 d7             	mov    %rdx,%rdi
  80388f:	fc                   	cld    
  803890:	f3 aa                	rep stos %al,%es:(%rdi)
  803892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803896:	c9                   	leaveq 
  803897:	c3                   	retq   

0000000000803898 <memmove>:
  803898:	55                   	push   %rbp
  803899:	48 89 e5             	mov    %rsp,%rbp
  80389c:	48 83 ec 28          	sub    $0x28,%rsp
  8038a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8038a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8038a8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8038ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8038b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8038b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8038b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8038bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038c0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8038c4:	0f 83 88 00 00 00    	jae    803952 <memmove+0xba>
  8038ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8038d2:	48 01 d0             	add    %rdx,%rax
  8038d5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8038d9:	76 77                	jbe    803952 <memmove+0xba>
  8038db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038df:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  8038e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8038e7:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8038eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038ef:	83 e0 03             	and    $0x3,%eax
  8038f2:	48 85 c0             	test   %rax,%rax
  8038f5:	75 3b                	jne    803932 <memmove+0x9a>
  8038f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038fb:	83 e0 03             	and    $0x3,%eax
  8038fe:	48 85 c0             	test   %rax,%rax
  803901:	75 2f                	jne    803932 <memmove+0x9a>
  803903:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803907:	83 e0 03             	and    $0x3,%eax
  80390a:	48 85 c0             	test   %rax,%rax
  80390d:	75 23                	jne    803932 <memmove+0x9a>
  80390f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803913:	48 83 e8 04          	sub    $0x4,%rax
  803917:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80391b:	48 83 ea 04          	sub    $0x4,%rdx
  80391f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  803923:	48 c1 e9 02          	shr    $0x2,%rcx
  803927:	48 89 c7             	mov    %rax,%rdi
  80392a:	48 89 d6             	mov    %rdx,%rsi
  80392d:	fd                   	std    
  80392e:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  803930:	eb 1d                	jmp    80394f <memmove+0xb7>
  803932:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803936:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80393a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80393e:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  803942:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803946:	48 89 d7             	mov    %rdx,%rdi
  803949:	48 89 c1             	mov    %rax,%rcx
  80394c:	fd                   	std    
  80394d:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80394f:	fc                   	cld    
  803950:	eb 57                	jmp    8039a9 <memmove+0x111>
  803952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803956:	83 e0 03             	and    $0x3,%eax
  803959:	48 85 c0             	test   %rax,%rax
  80395c:	75 36                	jne    803994 <memmove+0xfc>
  80395e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803962:	83 e0 03             	and    $0x3,%eax
  803965:	48 85 c0             	test   %rax,%rax
  803968:	75 2a                	jne    803994 <memmove+0xfc>
  80396a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80396e:	83 e0 03             	and    $0x3,%eax
  803971:	48 85 c0             	test   %rax,%rax
  803974:	75 1e                	jne    803994 <memmove+0xfc>
  803976:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80397a:	48 c1 e8 02          	shr    $0x2,%rax
  80397e:	48 89 c1             	mov    %rax,%rcx
  803981:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803985:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  803989:	48 89 c7             	mov    %rax,%rdi
  80398c:	48 89 d6             	mov    %rdx,%rsi
  80398f:	fc                   	cld    
  803990:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  803992:	eb 15                	jmp    8039a9 <memmove+0x111>
  803994:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803998:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80399c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8039a0:	48 89 c7             	mov    %rax,%rdi
  8039a3:	48 89 d6             	mov    %rdx,%rsi
  8039a6:	fc                   	cld    
  8039a7:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8039a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039ad:	c9                   	leaveq 
  8039ae:	c3                   	retq   

00000000008039af <memcpy>:
  8039af:	55                   	push   %rbp
  8039b0:	48 89 e5             	mov    %rsp,%rbp
  8039b3:	48 83 ec 18          	sub    $0x18,%rsp
  8039b7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8039bb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8039bf:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8039c3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8039c7:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8039cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039cf:	48 89 ce             	mov    %rcx,%rsi
  8039d2:	48 89 c7             	mov    %rax,%rdi
  8039d5:	48 b8 98 38 80 00 00 	movabs $0x803898,%rax
  8039dc:	00 00 00 
  8039df:	ff d0                	callq  *%rax
  8039e1:	c9                   	leaveq 
  8039e2:	c3                   	retq   

00000000008039e3 <memcmp>:
  8039e3:	55                   	push   %rbp
  8039e4:	48 89 e5             	mov    %rsp,%rbp
  8039e7:	48 83 ec 28          	sub    $0x28,%rsp
  8039eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8039ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8039f3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8039f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8039ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803a07:	eb 36                	jmp    803a3f <memcmp+0x5c>
  803a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a0d:	0f b6 10             	movzbl (%rax),%edx
  803a10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a14:	0f b6 00             	movzbl (%rax),%eax
  803a17:	38 c2                	cmp    %al,%dl
  803a19:	74 1a                	je     803a35 <memcmp+0x52>
  803a1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a1f:	0f b6 00             	movzbl (%rax),%eax
  803a22:	0f b6 d0             	movzbl %al,%edx
  803a25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a29:	0f b6 00             	movzbl (%rax),%eax
  803a2c:	0f b6 c0             	movzbl %al,%eax
  803a2f:	29 c2                	sub    %eax,%edx
  803a31:	89 d0                	mov    %edx,%eax
  803a33:	eb 20                	jmp    803a55 <memcmp+0x72>
  803a35:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  803a3a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  803a3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a43:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  803a47:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803a4b:	48 85 c0             	test   %rax,%rax
  803a4e:	75 b9                	jne    803a09 <memcmp+0x26>
  803a50:	b8 00 00 00 00       	mov    $0x0,%eax
  803a55:	c9                   	leaveq 
  803a56:	c3                   	retq   

0000000000803a57 <memfind>:
  803a57:	55                   	push   %rbp
  803a58:	48 89 e5             	mov    %rsp,%rbp
  803a5b:	48 83 ec 28          	sub    $0x28,%rsp
  803a5f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803a63:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  803a66:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803a6a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803a6e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803a72:	48 01 d0             	add    %rdx,%rax
  803a75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803a79:	eb 15                	jmp    803a90 <memfind+0x39>
  803a7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a7f:	0f b6 10             	movzbl (%rax),%edx
  803a82:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  803a85:	38 c2                	cmp    %al,%dl
  803a87:	75 02                	jne    803a8b <memfind+0x34>
  803a89:	eb 0f                	jmp    803a9a <memfind+0x43>
  803a8b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  803a90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a94:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  803a98:	72 e1                	jb     803a7b <memfind+0x24>
  803a9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803a9e:	c9                   	leaveq 
  803a9f:	c3                   	retq   

0000000000803aa0 <strtol>:
  803aa0:	55                   	push   %rbp
  803aa1:	48 89 e5             	mov    %rsp,%rbp
  803aa4:	48 83 ec 34          	sub    $0x34,%rsp
  803aa8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803aac:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803ab0:	89 55 cc             	mov    %edx,-0x34(%rbp)
  803ab3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803aba:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  803ac1:	00 
  803ac2:	eb 05                	jmp    803ac9 <strtol+0x29>
  803ac4:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  803ac9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803acd:	0f b6 00             	movzbl (%rax),%eax
  803ad0:	3c 20                	cmp    $0x20,%al
  803ad2:	74 f0                	je     803ac4 <strtol+0x24>
  803ad4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ad8:	0f b6 00             	movzbl (%rax),%eax
  803adb:	3c 09                	cmp    $0x9,%al
  803add:	74 e5                	je     803ac4 <strtol+0x24>
  803adf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803ae3:	0f b6 00             	movzbl (%rax),%eax
  803ae6:	3c 2b                	cmp    $0x2b,%al
  803ae8:	75 07                	jne    803af1 <strtol+0x51>
  803aea:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  803aef:	eb 17                	jmp    803b08 <strtol+0x68>
  803af1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803af5:	0f b6 00             	movzbl (%rax),%eax
  803af8:	3c 2d                	cmp    $0x2d,%al
  803afa:	75 0c                	jne    803b08 <strtol+0x68>
  803afc:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  803b01:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  803b08:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  803b0c:	74 06                	je     803b14 <strtol+0x74>
  803b0e:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  803b12:	75 28                	jne    803b3c <strtol+0x9c>
  803b14:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b18:	0f b6 00             	movzbl (%rax),%eax
  803b1b:	3c 30                	cmp    $0x30,%al
  803b1d:	75 1d                	jne    803b3c <strtol+0x9c>
  803b1f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b23:	48 83 c0 01          	add    $0x1,%rax
  803b27:	0f b6 00             	movzbl (%rax),%eax
  803b2a:	3c 78                	cmp    $0x78,%al
  803b2c:	75 0e                	jne    803b3c <strtol+0x9c>
  803b2e:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  803b33:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  803b3a:	eb 2c                	jmp    803b68 <strtol+0xc8>
  803b3c:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  803b40:	75 19                	jne    803b5b <strtol+0xbb>
  803b42:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b46:	0f b6 00             	movzbl (%rax),%eax
  803b49:	3c 30                	cmp    $0x30,%al
  803b4b:	75 0e                	jne    803b5b <strtol+0xbb>
  803b4d:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  803b52:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  803b59:	eb 0d                	jmp    803b68 <strtol+0xc8>
  803b5b:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  803b5f:	75 07                	jne    803b68 <strtol+0xc8>
  803b61:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  803b68:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b6c:	0f b6 00             	movzbl (%rax),%eax
  803b6f:	3c 2f                	cmp    $0x2f,%al
  803b71:	7e 1d                	jle    803b90 <strtol+0xf0>
  803b73:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b77:	0f b6 00             	movzbl (%rax),%eax
  803b7a:	3c 39                	cmp    $0x39,%al
  803b7c:	7f 12                	jg     803b90 <strtol+0xf0>
  803b7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b82:	0f b6 00             	movzbl (%rax),%eax
  803b85:	0f be c0             	movsbl %al,%eax
  803b88:	83 e8 30             	sub    $0x30,%eax
  803b8b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803b8e:	eb 4e                	jmp    803bde <strtol+0x13e>
  803b90:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b94:	0f b6 00             	movzbl (%rax),%eax
  803b97:	3c 60                	cmp    $0x60,%al
  803b99:	7e 1d                	jle    803bb8 <strtol+0x118>
  803b9b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803b9f:	0f b6 00             	movzbl (%rax),%eax
  803ba2:	3c 7a                	cmp    $0x7a,%al
  803ba4:	7f 12                	jg     803bb8 <strtol+0x118>
  803ba6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803baa:	0f b6 00             	movzbl (%rax),%eax
  803bad:	0f be c0             	movsbl %al,%eax
  803bb0:	83 e8 57             	sub    $0x57,%eax
  803bb3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803bb6:	eb 26                	jmp    803bde <strtol+0x13e>
  803bb8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bbc:	0f b6 00             	movzbl (%rax),%eax
  803bbf:	3c 40                	cmp    $0x40,%al
  803bc1:	7e 48                	jle    803c0b <strtol+0x16b>
  803bc3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bc7:	0f b6 00             	movzbl (%rax),%eax
  803bca:	3c 5a                	cmp    $0x5a,%al
  803bcc:	7f 3d                	jg     803c0b <strtol+0x16b>
  803bce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803bd2:	0f b6 00             	movzbl (%rax),%eax
  803bd5:	0f be c0             	movsbl %al,%eax
  803bd8:	83 e8 37             	sub    $0x37,%eax
  803bdb:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803bde:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803be1:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  803be4:	7c 02                	jl     803be8 <strtol+0x148>
  803be6:	eb 23                	jmp    803c0b <strtol+0x16b>
  803be8:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  803bed:	8b 45 cc             	mov    -0x34(%rbp),%eax
  803bf0:	48 98                	cltq   
  803bf2:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  803bf7:	48 89 c2             	mov    %rax,%rdx
  803bfa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803bfd:	48 98                	cltq   
  803bff:	48 01 d0             	add    %rdx,%rax
  803c02:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803c06:	e9 5d ff ff ff       	jmpq   803b68 <strtol+0xc8>
  803c0b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  803c10:	74 0b                	je     803c1d <strtol+0x17d>
  803c12:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c16:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803c1a:	48 89 10             	mov    %rdx,(%rax)
  803c1d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c21:	74 09                	je     803c2c <strtol+0x18c>
  803c23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c27:	48 f7 d8             	neg    %rax
  803c2a:	eb 04                	jmp    803c30 <strtol+0x190>
  803c2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c30:	c9                   	leaveq 
  803c31:	c3                   	retq   

0000000000803c32 <strstr>:
  803c32:	55                   	push   %rbp
  803c33:	48 89 e5             	mov    %rsp,%rbp
  803c36:	48 83 ec 30          	sub    $0x30,%rsp
  803c3a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803c3e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803c42:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c46:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803c4a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  803c4e:	0f b6 00             	movzbl (%rax),%eax
  803c51:	88 45 ff             	mov    %al,-0x1(%rbp)
  803c54:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  803c58:	75 06                	jne    803c60 <strstr+0x2e>
  803c5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c5e:	eb 6b                	jmp    803ccb <strstr+0x99>
  803c60:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803c64:	48 89 c7             	mov    %rax,%rdi
  803c67:	48 b8 08 35 80 00 00 	movabs $0x803508,%rax
  803c6e:	00 00 00 
  803c71:	ff d0                	callq  *%rax
  803c73:	48 98                	cltq   
  803c75:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803c79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803c7d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  803c81:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803c85:	0f b6 00             	movzbl (%rax),%eax
  803c88:	88 45 ef             	mov    %al,-0x11(%rbp)
  803c8b:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  803c8f:	75 07                	jne    803c98 <strstr+0x66>
  803c91:	b8 00 00 00 00       	mov    $0x0,%eax
  803c96:	eb 33                	jmp    803ccb <strstr+0x99>
  803c98:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  803c9c:	3a 45 ff             	cmp    -0x1(%rbp),%al
  803c9f:	75 d8                	jne    803c79 <strstr+0x47>
  803ca1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803ca5:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  803ca9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803cad:	48 89 ce             	mov    %rcx,%rsi
  803cb0:	48 89 c7             	mov    %rax,%rdi
  803cb3:	48 b8 29 37 80 00 00 	movabs $0x803729,%rax
  803cba:	00 00 00 
  803cbd:	ff d0                	callq  *%rax
  803cbf:	85 c0                	test   %eax,%eax
  803cc1:	75 b6                	jne    803c79 <strstr+0x47>
  803cc3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803cc7:	48 83 e8 01          	sub    $0x1,%rax
  803ccb:	c9                   	leaveq 
  803ccc:	c3                   	retq   

0000000000803ccd <ipc_recv>:
  803ccd:	55                   	push   %rbp
  803cce:	48 89 e5             	mov    %rsp,%rbp
  803cd1:	48 83 ec 30          	sub    $0x30,%rsp
  803cd5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803cd9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803cdd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803ce1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803ce6:	75 0e                	jne    803cf6 <ipc_recv+0x29>
  803ce8:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803cef:	00 00 00 
  803cf2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803cf6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803cfa:	48 89 c7             	mov    %rax,%rdi
  803cfd:	48 b8 1c 05 80 00 00 	movabs $0x80051c,%rax
  803d04:	00 00 00 
  803d07:	ff d0                	callq  *%rax
  803d09:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d10:	79 27                	jns    803d39 <ipc_recv+0x6c>
  803d12:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803d17:	74 0a                	je     803d23 <ipc_recv+0x56>
  803d19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d1d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803d23:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803d28:	74 0a                	je     803d34 <ipc_recv+0x67>
  803d2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d2e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803d34:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d37:	eb 53                	jmp    803d8c <ipc_recv+0xbf>
  803d39:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803d3e:	74 19                	je     803d59 <ipc_recv+0x8c>
  803d40:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803d47:	00 00 00 
  803d4a:	48 8b 00             	mov    (%rax),%rax
  803d4d:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  803d53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803d57:	89 10                	mov    %edx,(%rax)
  803d59:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803d5e:	74 19                	je     803d79 <ipc_recv+0xac>
  803d60:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803d67:	00 00 00 
  803d6a:	48 8b 00             	mov    (%rax),%rax
  803d6d:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  803d73:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803d77:	89 10                	mov    %edx,(%rax)
  803d79:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803d80:	00 00 00 
  803d83:	48 8b 00             	mov    (%rax),%rax
  803d86:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  803d8c:	c9                   	leaveq 
  803d8d:	c3                   	retq   

0000000000803d8e <ipc_send>:
  803d8e:	55                   	push   %rbp
  803d8f:	48 89 e5             	mov    %rsp,%rbp
  803d92:	48 83 ec 30          	sub    $0x30,%rsp
  803d96:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d99:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803d9c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  803da0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803da3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803da8:	75 10                	jne    803dba <ipc_send+0x2c>
  803daa:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803db1:	00 00 00 
  803db4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803db8:	eb 0e                	jmp    803dc8 <ipc_send+0x3a>
  803dba:	eb 0c                	jmp    803dc8 <ipc_send+0x3a>
  803dbc:	48 b8 b5 02 80 00 00 	movabs $0x8002b5,%rax
  803dc3:	00 00 00 
  803dc6:	ff d0                	callq  *%rax
  803dc8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  803dcb:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  803dce:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  803dd2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803dd5:	89 c7                	mov    %eax,%edi
  803dd7:	48 b8 c7 04 80 00 00 	movabs $0x8004c7,%rax
  803dde:	00 00 00 
  803de1:	ff d0                	callq  *%rax
  803de3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803de6:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  803dea:	74 d0                	je     803dbc <ipc_send+0x2e>
  803dec:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803df0:	79 30                	jns    803e22 <ipc_send+0x94>
  803df2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803df5:	89 c1                	mov    %eax,%ecx
  803df7:	48 ba 68 46 80 00 00 	movabs $0x804668,%rdx
  803dfe:	00 00 00 
  803e01:	be 44 00 00 00       	mov    $0x44,%esi
  803e06:	48 bf 7e 46 80 00 00 	movabs $0x80467e,%rdi
  803e0d:	00 00 00 
  803e10:	b8 00 00 00 00       	mov    $0x0,%eax
  803e15:	49 b8 86 27 80 00 00 	movabs $0x802786,%r8
  803e1c:	00 00 00 
  803e1f:	41 ff d0             	callq  *%r8
  803e22:	c9                   	leaveq 
  803e23:	c3                   	retq   

0000000000803e24 <ipc_host_recv>:
  803e24:	55                   	push   %rbp
  803e25:	48 89 e5             	mov    %rsp,%rbp
  803e28:	48 83 ec 10          	sub    $0x10,%rsp
  803e2c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803e30:	48 ba 90 46 80 00 00 	movabs $0x804690,%rdx
  803e37:	00 00 00 
  803e3a:	be 4e 00 00 00       	mov    $0x4e,%esi
  803e3f:	48 bf 7e 46 80 00 00 	movabs $0x80467e,%rdi
  803e46:	00 00 00 
  803e49:	b8 00 00 00 00       	mov    $0x0,%eax
  803e4e:	48 b9 86 27 80 00 00 	movabs $0x802786,%rcx
  803e55:	00 00 00 
  803e58:	ff d1                	callq  *%rcx

0000000000803e5a <ipc_host_send>:
  803e5a:	55                   	push   %rbp
  803e5b:	48 89 e5             	mov    %rsp,%rbp
  803e5e:	48 83 ec 20          	sub    $0x20,%rsp
  803e62:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e65:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803e68:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  803e6c:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  803e6f:	48 ba b0 46 80 00 00 	movabs $0x8046b0,%rdx
  803e76:	00 00 00 
  803e79:	be 67 00 00 00       	mov    $0x67,%esi
  803e7e:	48 bf 7e 46 80 00 00 	movabs $0x80467e,%rdi
  803e85:	00 00 00 
  803e88:	b8 00 00 00 00       	mov    $0x0,%eax
  803e8d:	48 b9 86 27 80 00 00 	movabs $0x802786,%rcx
  803e94:	00 00 00 
  803e97:	ff d1                	callq  *%rcx

0000000000803e99 <ipc_find_env>:
  803e99:	55                   	push   %rbp
  803e9a:	48 89 e5             	mov    %rsp,%rbp
  803e9d:	48 83 ec 14          	sub    $0x14,%rsp
  803ea1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ea4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803eab:	eb 4e                	jmp    803efb <ipc_find_env+0x62>
  803ead:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803eb4:	00 00 00 
  803eb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803eba:	48 98                	cltq   
  803ebc:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803ec3:	48 01 d0             	add    %rdx,%rax
  803ec6:	48 05 d0 00 00 00    	add    $0xd0,%rax
  803ecc:	8b 00                	mov    (%rax),%eax
  803ece:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  803ed1:	75 24                	jne    803ef7 <ipc_find_env+0x5e>
  803ed3:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  803eda:	00 00 00 
  803edd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ee0:	48 98                	cltq   
  803ee2:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  803ee9:	48 01 d0             	add    %rdx,%rax
  803eec:	48 05 c0 00 00 00    	add    $0xc0,%rax
  803ef2:	8b 40 08             	mov    0x8(%rax),%eax
  803ef5:	eb 12                	jmp    803f09 <ipc_find_env+0x70>
  803ef7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  803efb:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  803f02:	7e a9                	jle    803ead <ipc_find_env+0x14>
  803f04:	b8 00 00 00 00       	mov    $0x0,%eax
  803f09:	c9                   	leaveq 
  803f0a:	c3                   	retq   

0000000000803f0b <pageref>:
  803f0b:	55                   	push   %rbp
  803f0c:	48 89 e5             	mov    %rsp,%rbp
  803f0f:	48 83 ec 18          	sub    $0x18,%rsp
  803f13:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f1b:	48 c1 e8 15          	shr    $0x15,%rax
  803f1f:	48 89 c2             	mov    %rax,%rdx
  803f22:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  803f29:	01 00 00 
  803f2c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803f30:	83 e0 01             	and    $0x1,%eax
  803f33:	48 85 c0             	test   %rax,%rax
  803f36:	75 07                	jne    803f3f <pageref+0x34>
  803f38:	b8 00 00 00 00       	mov    $0x0,%eax
  803f3d:	eb 53                	jmp    803f92 <pageref+0x87>
  803f3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f43:	48 c1 e8 0c          	shr    $0xc,%rax
  803f47:	48 89 c2             	mov    %rax,%rdx
  803f4a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  803f51:	01 00 00 
  803f54:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  803f58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803f5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f60:	83 e0 01             	and    $0x1,%eax
  803f63:	48 85 c0             	test   %rax,%rax
  803f66:	75 07                	jne    803f6f <pageref+0x64>
  803f68:	b8 00 00 00 00       	mov    $0x0,%eax
  803f6d:	eb 23                	jmp    803f92 <pageref+0x87>
  803f6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803f73:	48 c1 e8 0c          	shr    $0xc,%rax
  803f77:	48 89 c2             	mov    %rax,%rdx
  803f7a:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  803f81:	00 00 00 
  803f84:	48 c1 e2 04          	shl    $0x4,%rdx
  803f88:	48 01 d0             	add    %rdx,%rax
  803f8b:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  803f8f:	0f b7 c0             	movzwl %ax,%eax
  803f92:	c9                   	leaveq 
  803f93:	c3                   	retq   
