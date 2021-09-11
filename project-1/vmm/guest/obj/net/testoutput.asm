
vmm/guest/obj/net/testoutput:     file format elf64-x86-64


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
  80003c:	e8 59 05 00 00       	callq  80059a <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <umain>:
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	53                   	push   %rbx
  800048:	48 83 ec 28          	sub    $0x28,%rsp
  80004c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80004f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  800053:	48 b8 e1 1c 80 00 00 	movabs $0x801ce1,%rax
  80005a:	00 00 00 
  80005d:	ff d0                	callq  *%rax
  80005f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800062:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800069:	00 00 00 
  80006c:	48 bb 00 4c 80 00 00 	movabs $0x804c00,%rbx
  800073:	00 00 00 
  800076:	48 89 18             	mov    %rbx,(%rax)
  800079:	48 b8 dd 24 80 00 00 	movabs $0x8024dd,%rax
  800080:	00 00 00 
  800083:	ff d0                	callq  *%rax
  800085:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  80008c:	00 00 00 
  80008f:	89 02                	mov    %eax,(%rdx)
  800091:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  800098:	00 00 00 
  80009b:	8b 00                	mov    (%rax),%eax
  80009d:	85 c0                	test   %eax,%eax
  80009f:	79 2a                	jns    8000cb <umain+0x88>
  8000a1:	48 ba 0b 4c 80 00 00 	movabs $0x804c0b,%rdx
  8000a8:	00 00 00 
  8000ab:	be 17 00 00 00       	mov    $0x17,%esi
  8000b0:	48 bf 19 4c 80 00 00 	movabs $0x804c19,%rdi
  8000b7:	00 00 00 
  8000ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8000bf:	48 b9 40 06 80 00 00 	movabs $0x800640,%rcx
  8000c6:	00 00 00 
  8000c9:	ff d1                	callq  *%rcx
  8000cb:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8000d2:	00 00 00 
  8000d5:	8b 00                	mov    (%rax),%eax
  8000d7:	85 c0                	test   %eax,%eax
  8000d9:	75 16                	jne    8000f1 <umain+0xae>
  8000db:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8000de:	89 c7                	mov    %eax,%edi
  8000e0:	48 b8 83 04 80 00 00 	movabs $0x800483,%rax
  8000e7:	00 00 00 
  8000ea:	ff d0                	callq  *%rax
  8000ec:	e9 50 01 00 00       	jmpq   800241 <umain+0x1fe>
  8000f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  8000f8:	e9 1b 01 00 00       	jmpq   800218 <umain+0x1d5>
  8000fd:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800104:	00 00 00 
  800107:	48 8b 00             	mov    (%rax),%rax
  80010a:	ba 07 00 00 00       	mov    $0x7,%edx
  80010f:	48 89 c6             	mov    %rax,%rsi
  800112:	bf 00 00 00 00       	mov    $0x0,%edi
  800117:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  80011e:	00 00 00 
  800121:	ff d0                	callq  *%rax
  800123:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  800126:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80012a:	79 30                	jns    80015c <umain+0x119>
  80012c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80012f:	89 c1                	mov    %eax,%ecx
  800131:	48 ba 2d 4c 80 00 00 	movabs $0x804c2d,%rdx
  800138:	00 00 00 
  80013b:	be 1f 00 00 00       	mov    $0x1f,%esi
  800140:	48 bf 19 4c 80 00 00 	movabs $0x804c19,%rdi
  800147:	00 00 00 
  80014a:	b8 00 00 00 00       	mov    $0x0,%eax
  80014f:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  800156:	00 00 00 
  800159:	41 ff d0             	callq  *%r8
  80015c:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800163:	00 00 00 
  800166:	48 8b 18             	mov    (%rax),%rbx
  800169:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  800170:	00 00 00 
  800173:	48 8b 00             	mov    (%rax),%rax
  800176:	48 8d 78 04          	lea    0x4(%rax),%rdi
  80017a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80017d:	89 c1                	mov    %eax,%ecx
  80017f:	48 ba 40 4c 80 00 00 	movabs $0x804c40,%rdx
  800186:	00 00 00 
  800189:	be fc 0f 00 00       	mov    $0xffc,%esi
  80018e:	b8 00 00 00 00       	mov    $0x0,%eax
  800193:	49 b8 e1 12 80 00 00 	movabs $0x8012e1,%r8
  80019a:	00 00 00 
  80019d:	41 ff d0             	callq  *%r8
  8001a0:	89 03                	mov    %eax,(%rbx)
  8001a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8001a5:	89 c6                	mov    %eax,%esi
  8001a7:	48 bf 4c 4c 80 00 00 	movabs $0x804c4c,%rdi
  8001ae:	00 00 00 
  8001b1:	b8 00 00 00 00       	mov    $0x0,%eax
  8001b6:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  8001bd:	00 00 00 
  8001c0:	ff d2                	callq  *%rdx
  8001c2:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8001c9:	00 00 00 
  8001cc:	48 8b 10             	mov    (%rax),%rdx
  8001cf:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8001d6:	00 00 00 
  8001d9:	8b 00                	mov    (%rax),%eax
  8001db:	b9 07 00 00 00       	mov    $0x7,%ecx
  8001e0:	be 0b 00 00 00       	mov    $0xb,%esi
  8001e5:	89 c7                	mov    %eax,%edi
  8001e7:	48 b8 13 28 80 00 00 	movabs $0x802813,%rax
  8001ee:	00 00 00 
  8001f1:	ff d0                	callq  *%rax
  8001f3:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  8001fa:	00 00 00 
  8001fd:	48 8b 00             	mov    (%rax),%rax
  800200:	48 89 c6             	mov    %rax,%rsi
  800203:	bf 00 00 00 00       	mov    $0x0,%edi
  800208:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  80020f:	00 00 00 
  800212:	ff d0                	callq  *%rax
  800214:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  800218:	83 7d ec 09          	cmpl   $0x9,-0x14(%rbp)
  80021c:	0f 8e db fe ff ff    	jle    8000fd <umain+0xba>
  800222:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  800229:	eb 10                	jmp    80023b <umain+0x1f8>
  80022b:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  800232:	00 00 00 
  800235:	ff d0                	callq  *%rax
  800237:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  80023b:	83 7d ec 13          	cmpl   $0x13,-0x14(%rbp)
  80023f:	7e ea                	jle    80022b <umain+0x1e8>
  800241:	48 83 c4 28          	add    $0x28,%rsp
  800245:	5b                   	pop    %rbx
  800246:	5d                   	pop    %rbp
  800247:	c3                   	retq   

0000000000800248 <timer>:
  800248:	55                   	push   %rbp
  800249:	48 89 e5             	mov    %rsp,%rbp
  80024c:	53                   	push   %rbx
  80024d:	48 83 ec 28          	sub    $0x28,%rsp
  800251:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800254:	89 75 d8             	mov    %esi,-0x28(%rbp)
  800257:	48 b8 ca 1f 80 00 00 	movabs $0x801fca,%rax
  80025e:	00 00 00 
  800261:	ff d0                	callq  *%rax
  800263:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800266:	01 d0                	add    %edx,%eax
  800268:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80026b:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800272:	00 00 00 
  800275:	48 bb 68 4c 80 00 00 	movabs $0x804c68,%rbx
  80027c:	00 00 00 
  80027f:	48 89 18             	mov    %rbx,(%rax)
  800282:	eb 0c                	jmp    800290 <timer+0x48>
  800284:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  80028b:	00 00 00 
  80028e:	ff d0                	callq  *%rax
  800290:	48 b8 ca 1f 80 00 00 	movabs $0x801fca,%rax
  800297:	00 00 00 
  80029a:	ff d0                	callq  *%rax
  80029c:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80029f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8002a2:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  8002a5:	73 06                	jae    8002ad <timer+0x65>
  8002a7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8002ab:	79 d7                	jns    800284 <timer+0x3c>
  8002ad:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8002b1:	79 30                	jns    8002e3 <timer+0x9b>
  8002b3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8002b6:	89 c1                	mov    %eax,%ecx
  8002b8:	48 ba 71 4c 80 00 00 	movabs $0x804c71,%rdx
  8002bf:	00 00 00 
  8002c2:	be 10 00 00 00       	mov    $0x10,%esi
  8002c7:	48 bf 83 4c 80 00 00 	movabs $0x804c83,%rdi
  8002ce:	00 00 00 
  8002d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8002d6:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  8002dd:	00 00 00 
  8002e0:	41 ff d0             	callq  *%r8
  8002e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8002e6:	b9 00 00 00 00       	mov    $0x0,%ecx
  8002eb:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f0:	be 0c 00 00 00       	mov    $0xc,%esi
  8002f5:	89 c7                	mov    %eax,%edi
  8002f7:	48 b8 13 28 80 00 00 	movabs $0x802813,%rax
  8002fe:	00 00 00 
  800301:	ff d0                	callq  *%rax
  800303:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  800307:	ba 00 00 00 00       	mov    $0x0,%edx
  80030c:	be 00 00 00 00       	mov    $0x0,%esi
  800311:	48 89 c7             	mov    %rax,%rdi
  800314:	48 b8 52 27 80 00 00 	movabs $0x802752,%rax
  80031b:	00 00 00 
  80031e:	ff d0                	callq  *%rax
  800320:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  800323:	8b 55 dc             	mov    -0x24(%rbp),%edx
  800326:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800329:	39 c2                	cmp    %eax,%edx
  80032b:	74 22                	je     80034f <timer+0x107>
  80032d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800330:	89 c6                	mov    %eax,%esi
  800332:	48 bf 98 4c 80 00 00 	movabs $0x804c98,%rdi
  800339:	00 00 00 
  80033c:	b8 00 00 00 00       	mov    $0x0,%eax
  800341:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  800348:	00 00 00 
  80034b:	ff d2                	callq  *%rdx
  80034d:	eb b4                	jmp    800303 <timer+0xbb>
  80034f:	48 b8 ca 1f 80 00 00 	movabs $0x801fca,%rax
  800356:	00 00 00 
  800359:	ff d0                	callq  *%rax
  80035b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  80035e:	01 d0                	add    %edx,%eax
  800360:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800363:	90                   	nop
  800364:	e9 27 ff ff ff       	jmpq   800290 <timer+0x48>

0000000000800369 <input>:
  800369:	55                   	push   %rbp
  80036a:	48 89 e5             	mov    %rsp,%rbp
  80036d:	53                   	push   %rbx
  80036e:	48 83 ec 28          	sub    $0x28,%rsp
  800372:	89 7d dc             	mov    %edi,-0x24(%rbp)
  800375:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80037c:	00 00 00 
  80037f:	48 bb d3 4c 80 00 00 	movabs $0x804cd3,%rbx
  800386:	00 00 00 
  800389:	48 89 18             	mov    %rbx,(%rax)
  80038c:	ba 07 00 00 00       	mov    $0x7,%edx
  800391:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  800398:	00 00 00 
  80039b:	bf 00 00 00 00       	mov    $0x0,%edi
  8003a0:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  8003a7:	00 00 00 
  8003aa:	ff d0                	callq  *%rax
  8003ac:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8003af:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8003b3:	79 30                	jns    8003e5 <input+0x7c>
  8003b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8003b8:	89 c1                	mov    %eax,%ecx
  8003ba:	48 ba dc 4c 80 00 00 	movabs $0x804cdc,%rdx
  8003c1:	00 00 00 
  8003c4:	be 0e 00 00 00       	mov    $0xe,%esi
  8003c9:	48 bf ef 4c 80 00 00 	movabs $0x804cef,%rdi
  8003d0:	00 00 00 
  8003d3:	b8 00 00 00 00       	mov    $0x0,%eax
  8003d8:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  8003df:	00 00 00 
  8003e2:	41 ff d0             	callq  *%r8
  8003e5:	be ee 05 00 00       	mov    $0x5ee,%esi
  8003ea:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  8003f1:	00 00 00 
  8003f4:	48 b8 50 20 80 00 00 	movabs $0x802050,%rax
  8003fb:	00 00 00 
  8003fe:	ff d0                	callq  *%rax
  800400:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800403:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800407:	75 0e                	jne    800417 <input+0xae>
  800409:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  800410:	00 00 00 
  800413:	ff d0                	callq  *%rax
  800415:	eb 67                	jmp    80047e <input+0x115>
  800417:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80041b:	79 22                	jns    80043f <input+0xd6>
  80041d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800420:	89 c6                	mov    %eax,%esi
  800422:	48 bf fe 4c 80 00 00 	movabs $0x804cfe,%rdi
  800429:	00 00 00 
  80042c:	b8 00 00 00 00       	mov    $0x0,%eax
  800431:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  800438:	00 00 00 
  80043b:	ff d2                	callq  *%rdx
  80043d:	eb 3f                	jmp    80047e <input+0x115>
  80043f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800443:	7e 39                	jle    80047e <input+0x115>
  800445:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80044c:	00 00 00 
  80044f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  800452:	89 10                	mov    %edx,(%rax)
  800454:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800457:	b9 05 00 00 00       	mov    $0x5,%ecx
  80045c:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  800463:	00 00 00 
  800466:	be 0a 00 00 00       	mov    $0xa,%esi
  80046b:	89 c7                	mov    %eax,%edi
  80046d:	48 b8 13 28 80 00 00 	movabs $0x802813,%rax
  800474:	00 00 00 
  800477:	ff d0                	callq  *%rax
  800479:	e9 0e ff ff ff       	jmpq   80038c <input+0x23>
  80047e:	e9 09 ff ff ff       	jmpq   80038c <input+0x23>

0000000000800483 <output>:
  800483:	55                   	push   %rbp
  800484:	48 89 e5             	mov    %rsp,%rbp
  800487:	53                   	push   %rbx
  800488:	48 83 ec 28          	sub    $0x28,%rsp
  80048c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80048f:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  800496:	00 00 00 
  800499:	48 bb 20 4d 80 00 00 	movabs $0x804d20,%rbx
  8004a0:	00 00 00 
  8004a3:	48 89 18             	mov    %rbx,(%rax)
  8004a6:	48 8d 45 e4          	lea    -0x1c(%rbp),%rax
  8004aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8004af:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  8004b6:	00 00 00 
  8004b9:	48 89 c7             	mov    %rax,%rdi
  8004bc:	48 b8 52 27 80 00 00 	movabs $0x802752,%rax
  8004c3:	00 00 00 
  8004c6:	ff d0                	callq  *%rax
  8004c8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8004cb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8004ce:	3b 45 dc             	cmp    -0x24(%rbp),%eax
  8004d1:	74 35                	je     800508 <output+0x85>
  8004d3:	48 b9 2a 4d 80 00 00 	movabs $0x804d2a,%rcx
  8004da:	00 00 00 
  8004dd:	48 ba 3b 4d 80 00 00 	movabs $0x804d3b,%rdx
  8004e4:	00 00 00 
  8004e7:	be 11 00 00 00       	mov    $0x11,%esi
  8004ec:	48 bf 50 4d 80 00 00 	movabs $0x804d50,%rdi
  8004f3:	00 00 00 
  8004f6:	b8 00 00 00 00       	mov    $0x0,%eax
  8004fb:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  800502:	00 00 00 
  800505:	41 ff d0             	callq  *%r8
  800508:	83 7d ec 0b          	cmpl   $0xb,-0x14(%rbp)
  80050c:	74 35                	je     800543 <output+0xc0>
  80050e:	48 b9 60 4d 80 00 00 	movabs $0x804d60,%rcx
  800515:	00 00 00 
  800518:	48 ba 3b 4d 80 00 00 	movabs $0x804d3b,%rdx
  80051f:	00 00 00 
  800522:	be 12 00 00 00       	mov    $0x12,%esi
  800527:	48 bf 50 4d 80 00 00 	movabs $0x804d50,%rdi
  80052e:	00 00 00 
  800531:	b8 00 00 00 00       	mov    $0x0,%eax
  800536:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  80053d:	00 00 00 
  800540:	41 ff d0             	callq  *%r8
  800543:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80054a:	00 00 00 
  80054d:	8b 00                	mov    (%rax),%eax
  80054f:	89 c6                	mov    %eax,%esi
  800551:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  800558:	00 00 00 
  80055b:	48 b8 08 20 80 00 00 	movabs $0x802008,%rax
  800562:	00 00 00 
  800565:	ff d0                	callq  *%rax
  800567:	89 45 e8             	mov    %eax,-0x18(%rbp)
  80056a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  80056e:	79 25                	jns    800595 <output+0x112>
  800570:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800573:	89 c6                	mov    %eax,%esi
  800575:	48 bf 78 4d 80 00 00 	movabs $0x804d78,%rdi
  80057c:	00 00 00 
  80057f:	b8 00 00 00 00       	mov    $0x0,%eax
  800584:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  80058b:	00 00 00 
  80058e:	ff d2                	callq  *%rdx
  800590:	e9 11 ff ff ff       	jmpq   8004a6 <output+0x23>
  800595:	e9 0c ff ff ff       	jmpq   8004a6 <output+0x23>

000000000080059a <libmain>:
  80059a:	55                   	push   %rbp
  80059b:	48 89 e5             	mov    %rsp,%rbp
  80059e:	48 83 ec 10          	sub    $0x10,%rsp
  8005a2:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8005a5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8005a9:	48 b8 e1 1c 80 00 00 	movabs $0x801ce1,%rax
  8005b0:	00 00 00 
  8005b3:	ff d0                	callq  *%rax
  8005b5:	25 ff 03 00 00       	and    $0x3ff,%eax
  8005ba:	48 98                	cltq   
  8005bc:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  8005c3:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  8005ca:	00 00 00 
  8005cd:	48 01 c2             	add    %rax,%rdx
  8005d0:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  8005d7:	00 00 00 
  8005da:	48 89 10             	mov    %rdx,(%rax)
  8005dd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8005e1:	7e 14                	jle    8005f7 <libmain+0x5d>
  8005e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8005e7:	48 8b 10             	mov    (%rax),%rdx
  8005ea:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8005f1:	00 00 00 
  8005f4:	48 89 10             	mov    %rdx,(%rax)
  8005f7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8005fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8005fe:	48 89 d6             	mov    %rdx,%rsi
  800601:	89 c7                	mov    %eax,%edi
  800603:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  80060a:	00 00 00 
  80060d:	ff d0                	callq  *%rax
  80060f:	48 b8 1d 06 80 00 00 	movabs $0x80061d,%rax
  800616:	00 00 00 
  800619:	ff d0                	callq  *%rax
  80061b:	c9                   	leaveq 
  80061c:	c3                   	retq   

000000000080061d <exit>:
  80061d:	55                   	push   %rbp
  80061e:	48 89 e5             	mov    %rsp,%rbp
  800621:	48 b8 d1 2c 80 00 00 	movabs $0x802cd1,%rax
  800628:	00 00 00 
  80062b:	ff d0                	callq  *%rax
  80062d:	bf 00 00 00 00       	mov    $0x0,%edi
  800632:	48 b8 9d 1c 80 00 00 	movabs $0x801c9d,%rax
  800639:	00 00 00 
  80063c:	ff d0                	callq  *%rax
  80063e:	5d                   	pop    %rbp
  80063f:	c3                   	retq   

0000000000800640 <_panic>:
  800640:	55                   	push   %rbp
  800641:	48 89 e5             	mov    %rsp,%rbp
  800644:	53                   	push   %rbx
  800645:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  80064c:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  800653:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  800659:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  800660:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  800667:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  80066e:	84 c0                	test   %al,%al
  800670:	74 23                	je     800695 <_panic+0x55>
  800672:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  800679:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  80067d:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  800681:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  800685:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  800689:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  80068d:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  800691:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  800695:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  80069c:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  8006a3:	00 00 00 
  8006a6:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  8006ad:	00 00 00 
  8006b0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8006b4:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  8006bb:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  8006c2:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8006c9:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8006d0:	00 00 00 
  8006d3:	48 8b 18             	mov    (%rax),%rbx
  8006d6:	48 b8 e1 1c 80 00 00 	movabs $0x801ce1,%rax
  8006dd:	00 00 00 
  8006e0:	ff d0                	callq  *%rax
  8006e2:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  8006e8:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8006ef:	41 89 c8             	mov    %ecx,%r8d
  8006f2:	48 89 d1             	mov    %rdx,%rcx
  8006f5:	48 89 da             	mov    %rbx,%rdx
  8006f8:	89 c6                	mov    %eax,%esi
  8006fa:	48 bf a8 4d 80 00 00 	movabs $0x804da8,%rdi
  800701:	00 00 00 
  800704:	b8 00 00 00 00       	mov    $0x0,%eax
  800709:	49 b9 79 08 80 00 00 	movabs $0x800879,%r9
  800710:	00 00 00 
  800713:	41 ff d1             	callq  *%r9
  800716:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  80071d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800724:	48 89 d6             	mov    %rdx,%rsi
  800727:	48 89 c7             	mov    %rax,%rdi
  80072a:	48 b8 cd 07 80 00 00 	movabs $0x8007cd,%rax
  800731:	00 00 00 
  800734:	ff d0                	callq  *%rax
  800736:	48 bf cb 4d 80 00 00 	movabs $0x804dcb,%rdi
  80073d:	00 00 00 
  800740:	b8 00 00 00 00       	mov    $0x0,%eax
  800745:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  80074c:	00 00 00 
  80074f:	ff d2                	callq  *%rdx
  800751:	cc                   	int3   
  800752:	eb fd                	jmp    800751 <_panic+0x111>

0000000000800754 <putch>:
  800754:	55                   	push   %rbp
  800755:	48 89 e5             	mov    %rsp,%rbp
  800758:	48 83 ec 10          	sub    $0x10,%rsp
  80075c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80075f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800763:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800767:	8b 00                	mov    (%rax),%eax
  800769:	8d 48 01             	lea    0x1(%rax),%ecx
  80076c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800770:	89 0a                	mov    %ecx,(%rdx)
  800772:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800775:	89 d1                	mov    %edx,%ecx
  800777:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80077b:	48 98                	cltq   
  80077d:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  800781:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800785:	8b 00                	mov    (%rax),%eax
  800787:	3d ff 00 00 00       	cmp    $0xff,%eax
  80078c:	75 2c                	jne    8007ba <putch+0x66>
  80078e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800792:	8b 00                	mov    (%rax),%eax
  800794:	48 98                	cltq   
  800796:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80079a:	48 83 c2 08          	add    $0x8,%rdx
  80079e:	48 89 c6             	mov    %rax,%rsi
  8007a1:	48 89 d7             	mov    %rdx,%rdi
  8007a4:	48 b8 15 1c 80 00 00 	movabs $0x801c15,%rax
  8007ab:	00 00 00 
  8007ae:	ff d0                	callq  *%rax
  8007b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8007b4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8007ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8007be:	8b 40 04             	mov    0x4(%rax),%eax
  8007c1:	8d 50 01             	lea    0x1(%rax),%edx
  8007c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8007c8:	89 50 04             	mov    %edx,0x4(%rax)
  8007cb:	c9                   	leaveq 
  8007cc:	c3                   	retq   

00000000008007cd <vcprintf>:
  8007cd:	55                   	push   %rbp
  8007ce:	48 89 e5             	mov    %rsp,%rbp
  8007d1:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  8007d8:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  8007df:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  8007e6:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  8007ed:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8007f4:	48 8b 0a             	mov    (%rdx),%rcx
  8007f7:	48 89 08             	mov    %rcx,(%rax)
  8007fa:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8007fe:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800802:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800806:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80080a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800811:	00 00 00 
  800814:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80081b:	00 00 00 
  80081e:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800825:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  80082c:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800833:	48 89 c6             	mov    %rax,%rsi
  800836:	48 bf 54 07 80 00 00 	movabs $0x800754,%rdi
  80083d:	00 00 00 
  800840:	48 b8 2c 0c 80 00 00 	movabs $0x800c2c,%rax
  800847:	00 00 00 
  80084a:	ff d0                	callq  *%rax
  80084c:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  800852:	48 98                	cltq   
  800854:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  80085b:	48 83 c2 08          	add    $0x8,%rdx
  80085f:	48 89 c6             	mov    %rax,%rsi
  800862:	48 89 d7             	mov    %rdx,%rdi
  800865:	48 b8 15 1c 80 00 00 	movabs $0x801c15,%rax
  80086c:	00 00 00 
  80086f:	ff d0                	callq  *%rax
  800871:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  800877:	c9                   	leaveq 
  800878:	c3                   	retq   

0000000000800879 <cprintf>:
  800879:	55                   	push   %rbp
  80087a:	48 89 e5             	mov    %rsp,%rbp
  80087d:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  800884:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  80088b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  800892:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800899:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  8008a0:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  8008a7:	84 c0                	test   %al,%al
  8008a9:	74 20                	je     8008cb <cprintf+0x52>
  8008ab:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  8008af:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  8008b3:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  8008b7:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  8008bb:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  8008bf:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  8008c3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  8008c7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  8008cb:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8008d2:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  8008d9:	00 00 00 
  8008dc:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  8008e3:	00 00 00 
  8008e6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8008ea:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  8008f1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8008f8:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8008ff:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800906:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  80090d:	48 8b 0a             	mov    (%rdx),%rcx
  800910:	48 89 08             	mov    %rcx,(%rax)
  800913:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800917:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80091b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80091f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800923:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80092a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800931:	48 89 d6             	mov    %rdx,%rsi
  800934:	48 89 c7             	mov    %rax,%rdi
  800937:	48 b8 cd 07 80 00 00 	movabs $0x8007cd,%rax
  80093e:	00 00 00 
  800941:	ff d0                	callq  *%rax
  800943:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800949:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  80094f:	c9                   	leaveq 
  800950:	c3                   	retq   

0000000000800951 <printnum>:
  800951:	55                   	push   %rbp
  800952:	48 89 e5             	mov    %rsp,%rbp
  800955:	53                   	push   %rbx
  800956:	48 83 ec 38          	sub    $0x38,%rsp
  80095a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80095e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800962:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  800966:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  800969:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  80096d:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  800971:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  800974:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  800978:	77 3b                	ja     8009b5 <printnum+0x64>
  80097a:	8b 45 d0             	mov    -0x30(%rbp),%eax
  80097d:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  800981:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  800984:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800988:	ba 00 00 00 00       	mov    $0x0,%edx
  80098d:	48 f7 f3             	div    %rbx
  800990:	48 89 c2             	mov    %rax,%rdx
  800993:	8b 7d cc             	mov    -0x34(%rbp),%edi
  800996:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  800999:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  80099d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009a1:	41 89 f9             	mov    %edi,%r9d
  8009a4:	48 89 c7             	mov    %rax,%rdi
  8009a7:	48 b8 51 09 80 00 00 	movabs $0x800951,%rax
  8009ae:	00 00 00 
  8009b1:	ff d0                	callq  *%rax
  8009b3:	eb 1e                	jmp    8009d3 <printnum+0x82>
  8009b5:	eb 12                	jmp    8009c9 <printnum+0x78>
  8009b7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8009bb:	8b 55 cc             	mov    -0x34(%rbp),%edx
  8009be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009c2:	48 89 ce             	mov    %rcx,%rsi
  8009c5:	89 d7                	mov    %edx,%edi
  8009c7:	ff d0                	callq  *%rax
  8009c9:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  8009cd:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  8009d1:	7f e4                	jg     8009b7 <printnum+0x66>
  8009d3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8009d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8009da:	ba 00 00 00 00       	mov    $0x0,%edx
  8009df:	48 f7 f1             	div    %rcx
  8009e2:	48 89 d0             	mov    %rdx,%rax
  8009e5:	48 ba d0 4f 80 00 00 	movabs $0x804fd0,%rdx
  8009ec:	00 00 00 
  8009ef:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  8009f3:	0f be d0             	movsbl %al,%edx
  8009f6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  8009fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009fe:	48 89 ce             	mov    %rcx,%rsi
  800a01:	89 d7                	mov    %edx,%edi
  800a03:	ff d0                	callq  *%rax
  800a05:	48 83 c4 38          	add    $0x38,%rsp
  800a09:	5b                   	pop    %rbx
  800a0a:	5d                   	pop    %rbp
  800a0b:	c3                   	retq   

0000000000800a0c <getuint>:
  800a0c:	55                   	push   %rbp
  800a0d:	48 89 e5             	mov    %rsp,%rbp
  800a10:	48 83 ec 1c          	sub    $0x1c,%rsp
  800a14:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800a18:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800a1b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800a1f:	7e 52                	jle    800a73 <getuint+0x67>
  800a21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a25:	8b 00                	mov    (%rax),%eax
  800a27:	83 f8 30             	cmp    $0x30,%eax
  800a2a:	73 24                	jae    800a50 <getuint+0x44>
  800a2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a30:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a38:	8b 00                	mov    (%rax),%eax
  800a3a:	89 c0                	mov    %eax,%eax
  800a3c:	48 01 d0             	add    %rdx,%rax
  800a3f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a43:	8b 12                	mov    (%rdx),%edx
  800a45:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800a48:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a4c:	89 0a                	mov    %ecx,(%rdx)
  800a4e:	eb 17                	jmp    800a67 <getuint+0x5b>
  800a50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a54:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800a58:	48 89 d0             	mov    %rdx,%rax
  800a5b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800a5f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a63:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800a67:	48 8b 00             	mov    (%rax),%rax
  800a6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800a6e:	e9 a3 00 00 00       	jmpq   800b16 <getuint+0x10a>
  800a73:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800a77:	74 4f                	je     800ac8 <getuint+0xbc>
  800a79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a7d:	8b 00                	mov    (%rax),%eax
  800a7f:	83 f8 30             	cmp    $0x30,%eax
  800a82:	73 24                	jae    800aa8 <getuint+0x9c>
  800a84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a88:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800a8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800a90:	8b 00                	mov    (%rax),%eax
  800a92:	89 c0                	mov    %eax,%eax
  800a94:	48 01 d0             	add    %rdx,%rax
  800a97:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800a9b:	8b 12                	mov    (%rdx),%edx
  800a9d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800aa0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800aa4:	89 0a                	mov    %ecx,(%rdx)
  800aa6:	eb 17                	jmp    800abf <getuint+0xb3>
  800aa8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800aac:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800ab0:	48 89 d0             	mov    %rdx,%rax
  800ab3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800ab7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800abb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800abf:	48 8b 00             	mov    (%rax),%rax
  800ac2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800ac6:	eb 4e                	jmp    800b16 <getuint+0x10a>
  800ac8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800acc:	8b 00                	mov    (%rax),%eax
  800ace:	83 f8 30             	cmp    $0x30,%eax
  800ad1:	73 24                	jae    800af7 <getuint+0xeb>
  800ad3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800ad7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800adb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800adf:	8b 00                	mov    (%rax),%eax
  800ae1:	89 c0                	mov    %eax,%eax
  800ae3:	48 01 d0             	add    %rdx,%rax
  800ae6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800aea:	8b 12                	mov    (%rdx),%edx
  800aec:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800aef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800af3:	89 0a                	mov    %ecx,(%rdx)
  800af5:	eb 17                	jmp    800b0e <getuint+0x102>
  800af7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800afb:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800aff:	48 89 d0             	mov    %rdx,%rax
  800b02:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b06:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b0a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b0e:	8b 00                	mov    (%rax),%eax
  800b10:	89 c0                	mov    %eax,%eax
  800b12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800b1a:	c9                   	leaveq 
  800b1b:	c3                   	retq   

0000000000800b1c <getint>:
  800b1c:	55                   	push   %rbp
  800b1d:	48 89 e5             	mov    %rsp,%rbp
  800b20:	48 83 ec 1c          	sub    $0x1c,%rsp
  800b24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800b28:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  800b2b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800b2f:	7e 52                	jle    800b83 <getint+0x67>
  800b31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b35:	8b 00                	mov    (%rax),%eax
  800b37:	83 f8 30             	cmp    $0x30,%eax
  800b3a:	73 24                	jae    800b60 <getint+0x44>
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
  800b5e:	eb 17                	jmp    800b77 <getint+0x5b>
  800b60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b64:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800b68:	48 89 d0             	mov    %rdx,%rax
  800b6b:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800b6f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800b73:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800b77:	48 8b 00             	mov    (%rax),%rax
  800b7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800b7e:	e9 a3 00 00 00       	jmpq   800c26 <getint+0x10a>
  800b83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  800b87:	74 4f                	je     800bd8 <getint+0xbc>
  800b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b8d:	8b 00                	mov    (%rax),%eax
  800b8f:	83 f8 30             	cmp    $0x30,%eax
  800b92:	73 24                	jae    800bb8 <getint+0x9c>
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
  800bb6:	eb 17                	jmp    800bcf <getint+0xb3>
  800bb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bbc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800bc0:	48 89 d0             	mov    %rdx,%rax
  800bc3:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800bc7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800bcb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800bcf:	48 8b 00             	mov    (%rax),%rax
  800bd2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800bd6:	eb 4e                	jmp    800c26 <getint+0x10a>
  800bd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800bdc:	8b 00                	mov    (%rax),%eax
  800bde:	83 f8 30             	cmp    $0x30,%eax
  800be1:	73 24                	jae    800c07 <getint+0xeb>
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
  800c05:	eb 17                	jmp    800c1e <getint+0x102>
  800c07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800c0b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800c0f:	48 89 d0             	mov    %rdx,%rax
  800c12:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  800c16:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c1a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800c1e:	8b 00                	mov    (%rax),%eax
  800c20:	48 98                	cltq   
  800c22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800c2a:	c9                   	leaveq 
  800c2b:	c3                   	retq   

0000000000800c2c <vprintfmt>:
  800c2c:	55                   	push   %rbp
  800c2d:	48 89 e5             	mov    %rsp,%rbp
  800c30:	41 54                	push   %r12
  800c32:	53                   	push   %rbx
  800c33:	48 83 ec 60          	sub    $0x60,%rsp
  800c37:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  800c3b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  800c3f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c43:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  800c47:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c4b:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  800c4f:	48 8b 0a             	mov    (%rdx),%rcx
  800c52:	48 89 08             	mov    %rcx,(%rax)
  800c55:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800c59:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800c5d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800c61:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800c65:	eb 17                	jmp    800c7e <vprintfmt+0x52>
  800c67:	85 db                	test   %ebx,%ebx
  800c69:	0f 84 cc 04 00 00    	je     80113b <vprintfmt+0x50f>
  800c6f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c73:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c77:	48 89 d6             	mov    %rdx,%rsi
  800c7a:	89 df                	mov    %ebx,%edi
  800c7c:	ff d0                	callq  *%rax
  800c7e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c82:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800c86:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800c8a:	0f b6 00             	movzbl (%rax),%eax
  800c8d:	0f b6 d8             	movzbl %al,%ebx
  800c90:	83 fb 25             	cmp    $0x25,%ebx
  800c93:	75 d2                	jne    800c67 <vprintfmt+0x3b>
  800c95:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  800c99:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800ca0:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800ca7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800cae:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800cb5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800cb9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800cbd:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800cc1:	0f b6 00             	movzbl (%rax),%eax
  800cc4:	0f b6 d8             	movzbl %al,%ebx
  800cc7:	8d 43 dd             	lea    -0x23(%rbx),%eax
  800cca:	83 f8 55             	cmp    $0x55,%eax
  800ccd:	0f 87 34 04 00 00    	ja     801107 <vprintfmt+0x4db>
  800cd3:	89 c0                	mov    %eax,%eax
  800cd5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800cdc:	00 
  800cdd:	48 b8 f8 4f 80 00 00 	movabs $0x804ff8,%rax
  800ce4:	00 00 00 
  800ce7:	48 01 d0             	add    %rdx,%rax
  800cea:	48 8b 00             	mov    (%rax),%rax
  800ced:	ff e0                	jmpq   *%rax
  800cef:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800cf3:	eb c0                	jmp    800cb5 <vprintfmt+0x89>
  800cf5:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  800cf9:	eb ba                	jmp    800cb5 <vprintfmt+0x89>
  800cfb:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800d02:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800d05:	89 d0                	mov    %edx,%eax
  800d07:	c1 e0 02             	shl    $0x2,%eax
  800d0a:	01 d0                	add    %edx,%eax
  800d0c:	01 c0                	add    %eax,%eax
  800d0e:	01 d8                	add    %ebx,%eax
  800d10:	83 e8 30             	sub    $0x30,%eax
  800d13:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800d16:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800d1a:	0f b6 00             	movzbl (%rax),%eax
  800d1d:	0f be d8             	movsbl %al,%ebx
  800d20:	83 fb 2f             	cmp    $0x2f,%ebx
  800d23:	7e 0c                	jle    800d31 <vprintfmt+0x105>
  800d25:	83 fb 39             	cmp    $0x39,%ebx
  800d28:	7f 07                	jg     800d31 <vprintfmt+0x105>
  800d2a:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800d2f:	eb d1                	jmp    800d02 <vprintfmt+0xd6>
  800d31:	eb 58                	jmp    800d8b <vprintfmt+0x15f>
  800d33:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d36:	83 f8 30             	cmp    $0x30,%eax
  800d39:	73 17                	jae    800d52 <vprintfmt+0x126>
  800d3b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800d3f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800d42:	89 c0                	mov    %eax,%eax
  800d44:	48 01 d0             	add    %rdx,%rax
  800d47:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800d4a:	83 c2 08             	add    $0x8,%edx
  800d4d:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800d50:	eb 0f                	jmp    800d61 <vprintfmt+0x135>
  800d52:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800d56:	48 89 d0             	mov    %rdx,%rax
  800d59:	48 83 c2 08          	add    $0x8,%rdx
  800d5d:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800d61:	8b 00                	mov    (%rax),%eax
  800d63:	89 45 d8             	mov    %eax,-0x28(%rbp)
  800d66:	eb 23                	jmp    800d8b <vprintfmt+0x15f>
  800d68:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d6c:	79 0c                	jns    800d7a <vprintfmt+0x14e>
  800d6e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800d75:	e9 3b ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800d7a:	e9 36 ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800d7f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  800d86:	e9 2a ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800d8b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800d8f:	79 12                	jns    800da3 <vprintfmt+0x177>
  800d91:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800d94:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800d97:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800d9e:	e9 12 ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800da3:	e9 0d ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800da8:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800dac:	e9 04 ff ff ff       	jmpq   800cb5 <vprintfmt+0x89>
  800db1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800db4:	83 f8 30             	cmp    $0x30,%eax
  800db7:	73 17                	jae    800dd0 <vprintfmt+0x1a4>
  800db9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800dbd:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800dc0:	89 c0                	mov    %eax,%eax
  800dc2:	48 01 d0             	add    %rdx,%rax
  800dc5:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800dc8:	83 c2 08             	add    $0x8,%edx
  800dcb:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800dce:	eb 0f                	jmp    800ddf <vprintfmt+0x1b3>
  800dd0:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800dd4:	48 89 d0             	mov    %rdx,%rax
  800dd7:	48 83 c2 08          	add    $0x8,%rdx
  800ddb:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800ddf:	8b 10                	mov    (%rax),%edx
  800de1:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800de5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800de9:	48 89 ce             	mov    %rcx,%rsi
  800dec:	89 d7                	mov    %edx,%edi
  800dee:	ff d0                	callq  *%rax
  800df0:	e9 40 03 00 00       	jmpq   801135 <vprintfmt+0x509>
  800df5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800df8:	83 f8 30             	cmp    $0x30,%eax
  800dfb:	73 17                	jae    800e14 <vprintfmt+0x1e8>
  800dfd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800e01:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800e04:	89 c0                	mov    %eax,%eax
  800e06:	48 01 d0             	add    %rdx,%rax
  800e09:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800e0c:	83 c2 08             	add    $0x8,%edx
  800e0f:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800e12:	eb 0f                	jmp    800e23 <vprintfmt+0x1f7>
  800e14:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800e18:	48 89 d0             	mov    %rdx,%rax
  800e1b:	48 83 c2 08          	add    $0x8,%rdx
  800e1f:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800e23:	8b 18                	mov    (%rax),%ebx
  800e25:	85 db                	test   %ebx,%ebx
  800e27:	79 02                	jns    800e2b <vprintfmt+0x1ff>
  800e29:	f7 db                	neg    %ebx
  800e2b:	83 fb 15             	cmp    $0x15,%ebx
  800e2e:	7f 16                	jg     800e46 <vprintfmt+0x21a>
  800e30:	48 b8 20 4f 80 00 00 	movabs $0x804f20,%rax
  800e37:	00 00 00 
  800e3a:	48 63 d3             	movslq %ebx,%rdx
  800e3d:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  800e41:	4d 85 e4             	test   %r12,%r12
  800e44:	75 2e                	jne    800e74 <vprintfmt+0x248>
  800e46:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800e4a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e4e:	89 d9                	mov    %ebx,%ecx
  800e50:	48 ba e1 4f 80 00 00 	movabs $0x804fe1,%rdx
  800e57:	00 00 00 
  800e5a:	48 89 c7             	mov    %rax,%rdi
  800e5d:	b8 00 00 00 00       	mov    $0x0,%eax
  800e62:	49 b8 44 11 80 00 00 	movabs $0x801144,%r8
  800e69:	00 00 00 
  800e6c:	41 ff d0             	callq  *%r8
  800e6f:	e9 c1 02 00 00       	jmpq   801135 <vprintfmt+0x509>
  800e74:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800e78:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800e7c:	4c 89 e1             	mov    %r12,%rcx
  800e7f:	48 ba ea 4f 80 00 00 	movabs $0x804fea,%rdx
  800e86:	00 00 00 
  800e89:	48 89 c7             	mov    %rax,%rdi
  800e8c:	b8 00 00 00 00       	mov    $0x0,%eax
  800e91:	49 b8 44 11 80 00 00 	movabs $0x801144,%r8
  800e98:	00 00 00 
  800e9b:	41 ff d0             	callq  *%r8
  800e9e:	e9 92 02 00 00       	jmpq   801135 <vprintfmt+0x509>
  800ea3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800ea6:	83 f8 30             	cmp    $0x30,%eax
  800ea9:	73 17                	jae    800ec2 <vprintfmt+0x296>
  800eab:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800eaf:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800eb2:	89 c0                	mov    %eax,%eax
  800eb4:	48 01 d0             	add    %rdx,%rax
  800eb7:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800eba:	83 c2 08             	add    $0x8,%edx
  800ebd:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800ec0:	eb 0f                	jmp    800ed1 <vprintfmt+0x2a5>
  800ec2:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800ec6:	48 89 d0             	mov    %rdx,%rax
  800ec9:	48 83 c2 08          	add    $0x8,%rdx
  800ecd:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800ed1:	4c 8b 20             	mov    (%rax),%r12
  800ed4:	4d 85 e4             	test   %r12,%r12
  800ed7:	75 0a                	jne    800ee3 <vprintfmt+0x2b7>
  800ed9:	49 bc ed 4f 80 00 00 	movabs $0x804fed,%r12
  800ee0:	00 00 00 
  800ee3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800ee7:	7e 3f                	jle    800f28 <vprintfmt+0x2fc>
  800ee9:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800eed:	74 39                	je     800f28 <vprintfmt+0x2fc>
  800eef:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800ef2:	48 98                	cltq   
  800ef4:	48 89 c6             	mov    %rax,%rsi
  800ef7:	4c 89 e7             	mov    %r12,%rdi
  800efa:	48 b8 f0 13 80 00 00 	movabs $0x8013f0,%rax
  800f01:	00 00 00 
  800f04:	ff d0                	callq  *%rax
  800f06:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800f09:	eb 17                	jmp    800f22 <vprintfmt+0x2f6>
  800f0b:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800f0f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800f13:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f17:	48 89 ce             	mov    %rcx,%rsi
  800f1a:	89 d7                	mov    %edx,%edi
  800f1c:	ff d0                	callq  *%rax
  800f1e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f22:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800f26:	7f e3                	jg     800f0b <vprintfmt+0x2df>
  800f28:	eb 37                	jmp    800f61 <vprintfmt+0x335>
  800f2a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800f2e:	74 1e                	je     800f4e <vprintfmt+0x322>
  800f30:	83 fb 1f             	cmp    $0x1f,%ebx
  800f33:	7e 05                	jle    800f3a <vprintfmt+0x30e>
  800f35:	83 fb 7e             	cmp    $0x7e,%ebx
  800f38:	7e 14                	jle    800f4e <vprintfmt+0x322>
  800f3a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f3e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f42:	48 89 d6             	mov    %rdx,%rsi
  800f45:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800f4a:	ff d0                	callq  *%rax
  800f4c:	eb 0f                	jmp    800f5d <vprintfmt+0x331>
  800f4e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f52:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f56:	48 89 d6             	mov    %rdx,%rsi
  800f59:	89 df                	mov    %ebx,%edi
  800f5b:	ff d0                	callq  *%rax
  800f5d:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f61:	4c 89 e0             	mov    %r12,%rax
  800f64:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800f68:	0f b6 00             	movzbl (%rax),%eax
  800f6b:	0f be d8             	movsbl %al,%ebx
  800f6e:	85 db                	test   %ebx,%ebx
  800f70:	74 10                	je     800f82 <vprintfmt+0x356>
  800f72:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800f76:	78 b2                	js     800f2a <vprintfmt+0x2fe>
  800f78:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800f7c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800f80:	79 a8                	jns    800f2a <vprintfmt+0x2fe>
  800f82:	eb 16                	jmp    800f9a <vprintfmt+0x36e>
  800f84:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800f88:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800f8c:	48 89 d6             	mov    %rdx,%rsi
  800f8f:	bf 20 00 00 00       	mov    $0x20,%edi
  800f94:	ff d0                	callq  *%rax
  800f96:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800f9a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800f9e:	7f e4                	jg     800f84 <vprintfmt+0x358>
  800fa0:	e9 90 01 00 00       	jmpq   801135 <vprintfmt+0x509>
  800fa5:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800fa9:	be 03 00 00 00       	mov    $0x3,%esi
  800fae:	48 89 c7             	mov    %rax,%rdi
  800fb1:	48 b8 1c 0b 80 00 00 	movabs $0x800b1c,%rax
  800fb8:	00 00 00 
  800fbb:	ff d0                	callq  *%rax
  800fbd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800fc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fc5:	48 85 c0             	test   %rax,%rax
  800fc8:	79 1d                	jns    800fe7 <vprintfmt+0x3bb>
  800fca:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800fce:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800fd2:	48 89 d6             	mov    %rdx,%rsi
  800fd5:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800fda:	ff d0                	callq  *%rax
  800fdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fe0:	48 f7 d8             	neg    %rax
  800fe3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800fe7:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800fee:	e9 d5 00 00 00       	jmpq   8010c8 <vprintfmt+0x49c>
  800ff3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800ff7:	be 03 00 00 00       	mov    $0x3,%esi
  800ffc:	48 89 c7             	mov    %rax,%rdi
  800fff:	48 b8 0c 0a 80 00 00 	movabs $0x800a0c,%rax
  801006:	00 00 00 
  801009:	ff d0                	callq  *%rax
  80100b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80100f:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  801016:	e9 ad 00 00 00       	jmpq   8010c8 <vprintfmt+0x49c>
  80101b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  80101f:	be 03 00 00 00       	mov    $0x3,%esi
  801024:	48 89 c7             	mov    %rax,%rdi
  801027:	48 b8 0c 0a 80 00 00 	movabs $0x800a0c,%rax
  80102e:	00 00 00 
  801031:	ff d0                	callq  *%rax
  801033:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801037:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  80103e:	e9 85 00 00 00       	jmpq   8010c8 <vprintfmt+0x49c>
  801043:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801047:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80104b:	48 89 d6             	mov    %rdx,%rsi
  80104e:	bf 30 00 00 00       	mov    $0x30,%edi
  801053:	ff d0                	callq  *%rax
  801055:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801059:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80105d:	48 89 d6             	mov    %rdx,%rsi
  801060:	bf 78 00 00 00       	mov    $0x78,%edi
  801065:	ff d0                	callq  *%rax
  801067:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80106a:	83 f8 30             	cmp    $0x30,%eax
  80106d:	73 17                	jae    801086 <vprintfmt+0x45a>
  80106f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  801073:	8b 45 b8             	mov    -0x48(%rbp),%eax
  801076:	89 c0                	mov    %eax,%eax
  801078:	48 01 d0             	add    %rdx,%rax
  80107b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80107e:	83 c2 08             	add    $0x8,%edx
  801081:	89 55 b8             	mov    %edx,-0x48(%rbp)
  801084:	eb 0f                	jmp    801095 <vprintfmt+0x469>
  801086:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80108a:	48 89 d0             	mov    %rdx,%rax
  80108d:	48 83 c2 08          	add    $0x8,%rdx
  801091:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  801095:	48 8b 00             	mov    (%rax),%rax
  801098:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80109c:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8010a3:	eb 23                	jmp    8010c8 <vprintfmt+0x49c>
  8010a5:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8010a9:	be 03 00 00 00       	mov    $0x3,%esi
  8010ae:	48 89 c7             	mov    %rax,%rdi
  8010b1:	48 b8 0c 0a 80 00 00 	movabs $0x800a0c,%rax
  8010b8:	00 00 00 
  8010bb:	ff d0                	callq  *%rax
  8010bd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8010c1:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  8010c8:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  8010cd:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  8010d0:	8b 7d dc             	mov    -0x24(%rbp),%edi
  8010d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010d7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8010db:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8010df:	45 89 c1             	mov    %r8d,%r9d
  8010e2:	41 89 f8             	mov    %edi,%r8d
  8010e5:	48 89 c7             	mov    %rax,%rdi
  8010e8:	48 b8 51 09 80 00 00 	movabs $0x800951,%rax
  8010ef:	00 00 00 
  8010f2:	ff d0                	callq  *%rax
  8010f4:	eb 3f                	jmp    801135 <vprintfmt+0x509>
  8010f6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8010fa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8010fe:	48 89 d6             	mov    %rdx,%rsi
  801101:	89 df                	mov    %ebx,%edi
  801103:	ff d0                	callq  *%rax
  801105:	eb 2e                	jmp    801135 <vprintfmt+0x509>
  801107:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  80110b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80110f:	48 89 d6             	mov    %rdx,%rsi
  801112:	bf 25 00 00 00       	mov    $0x25,%edi
  801117:	ff d0                	callq  *%rax
  801119:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  80111e:	eb 05                	jmp    801125 <vprintfmt+0x4f9>
  801120:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  801125:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801129:	48 83 e8 01          	sub    $0x1,%rax
  80112d:	0f b6 00             	movzbl (%rax),%eax
  801130:	3c 25                	cmp    $0x25,%al
  801132:	75 ec                	jne    801120 <vprintfmt+0x4f4>
  801134:	90                   	nop
  801135:	90                   	nop
  801136:	e9 43 fb ff ff       	jmpq   800c7e <vprintfmt+0x52>
  80113b:	48 83 c4 60          	add    $0x60,%rsp
  80113f:	5b                   	pop    %rbx
  801140:	41 5c                	pop    %r12
  801142:	5d                   	pop    %rbp
  801143:	c3                   	retq   

0000000000801144 <printfmt>:
  801144:	55                   	push   %rbp
  801145:	48 89 e5             	mov    %rsp,%rbp
  801148:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  80114f:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  801156:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  80115d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801164:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80116b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  801172:	84 c0                	test   %al,%al
  801174:	74 20                	je     801196 <printfmt+0x52>
  801176:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80117a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80117e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  801182:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801186:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80118a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80118e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  801192:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801196:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  80119d:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  8011a4:	00 00 00 
  8011a7:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  8011ae:	00 00 00 
  8011b1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  8011b5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  8011bc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  8011c3:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  8011ca:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  8011d1:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  8011d8:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  8011df:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  8011e6:	48 89 c7             	mov    %rax,%rdi
  8011e9:	48 b8 2c 0c 80 00 00 	movabs $0x800c2c,%rax
  8011f0:	00 00 00 
  8011f3:	ff d0                	callq  *%rax
  8011f5:	c9                   	leaveq 
  8011f6:	c3                   	retq   

00000000008011f7 <sprintputch>:
  8011f7:	55                   	push   %rbp
  8011f8:	48 89 e5             	mov    %rsp,%rbp
  8011fb:	48 83 ec 10          	sub    $0x10,%rsp
  8011ff:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801202:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801206:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80120a:	8b 40 10             	mov    0x10(%rax),%eax
  80120d:	8d 50 01             	lea    0x1(%rax),%edx
  801210:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801214:	89 50 10             	mov    %edx,0x10(%rax)
  801217:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80121b:	48 8b 10             	mov    (%rax),%rdx
  80121e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801222:	48 8b 40 08          	mov    0x8(%rax),%rax
  801226:	48 39 c2             	cmp    %rax,%rdx
  801229:	73 17                	jae    801242 <sprintputch+0x4b>
  80122b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80122f:	48 8b 00             	mov    (%rax),%rax
  801232:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801236:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80123a:	48 89 0a             	mov    %rcx,(%rdx)
  80123d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801240:	88 10                	mov    %dl,(%rax)
  801242:	c9                   	leaveq 
  801243:	c3                   	retq   

0000000000801244 <vsnprintf>:
  801244:	55                   	push   %rbp
  801245:	48 89 e5             	mov    %rsp,%rbp
  801248:	48 83 ec 50          	sub    $0x50,%rsp
  80124c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  801250:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  801253:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  801257:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  80125b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  80125f:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  801263:	48 8b 0a             	mov    (%rdx),%rcx
  801266:	48 89 08             	mov    %rcx,(%rax)
  801269:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80126d:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801271:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801275:	48 89 50 10          	mov    %rdx,0x10(%rax)
  801279:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80127d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  801281:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  801284:	48 98                	cltq   
  801286:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80128a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80128e:	48 01 d0             	add    %rdx,%rax
  801291:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  801295:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  80129c:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  8012a1:	74 06                	je     8012a9 <vsnprintf+0x65>
  8012a3:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  8012a7:	7f 07                	jg     8012b0 <vsnprintf+0x6c>
  8012a9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8012ae:	eb 2f                	jmp    8012df <vsnprintf+0x9b>
  8012b0:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  8012b4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  8012b8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  8012bc:	48 89 c6             	mov    %rax,%rsi
  8012bf:	48 bf f7 11 80 00 00 	movabs $0x8011f7,%rdi
  8012c6:	00 00 00 
  8012c9:	48 b8 2c 0c 80 00 00 	movabs $0x800c2c,%rax
  8012d0:	00 00 00 
  8012d3:	ff d0                	callq  *%rax
  8012d5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8012d9:	c6 00 00             	movb   $0x0,(%rax)
  8012dc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8012df:	c9                   	leaveq 
  8012e0:	c3                   	retq   

00000000008012e1 <snprintf>:
  8012e1:	55                   	push   %rbp
  8012e2:	48 89 e5             	mov    %rsp,%rbp
  8012e5:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  8012ec:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  8012f3:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  8012f9:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  801300:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  801307:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80130e:	84 c0                	test   %al,%al
  801310:	74 20                	je     801332 <snprintf+0x51>
  801312:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  801316:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  80131a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80131e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  801322:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  801326:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  80132a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80132e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  801332:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  801339:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  801340:	00 00 00 
  801343:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  80134a:	00 00 00 
  80134d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  801351:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  801358:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80135f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  801366:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80136d:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  801374:	48 8b 0a             	mov    (%rdx),%rcx
  801377:	48 89 08             	mov    %rcx,(%rax)
  80137a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80137e:	48 89 48 08          	mov    %rcx,0x8(%rax)
  801382:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  801386:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80138a:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  801391:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  801398:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  80139e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  8013a5:	48 89 c7             	mov    %rax,%rdi
  8013a8:	48 b8 44 12 80 00 00 	movabs $0x801244,%rax
  8013af:	00 00 00 
  8013b2:	ff d0                	callq  *%rax
  8013b4:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8013ba:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8013c0:	c9                   	leaveq 
  8013c1:	c3                   	retq   

00000000008013c2 <strlen>:
  8013c2:	55                   	push   %rbp
  8013c3:	48 89 e5             	mov    %rsp,%rbp
  8013c6:	48 83 ec 18          	sub    $0x18,%rsp
  8013ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8013d5:	eb 09                	jmp    8013e0 <strlen+0x1e>
  8013d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8013db:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8013e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013e4:	0f b6 00             	movzbl (%rax),%eax
  8013e7:	84 c0                	test   %al,%al
  8013e9:	75 ec                	jne    8013d7 <strlen+0x15>
  8013eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8013ee:	c9                   	leaveq 
  8013ef:	c3                   	retq   

00000000008013f0 <strnlen>:
  8013f0:	55                   	push   %rbp
  8013f1:	48 89 e5             	mov    %rsp,%rbp
  8013f4:	48 83 ec 20          	sub    $0x20,%rsp
  8013f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8013fc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801400:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801407:	eb 0e                	jmp    801417 <strnlen+0x27>
  801409:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80140d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  801412:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  801417:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80141c:	74 0b                	je     801429 <strnlen+0x39>
  80141e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801422:	0f b6 00             	movzbl (%rax),%eax
  801425:	84 c0                	test   %al,%al
  801427:	75 e0                	jne    801409 <strnlen+0x19>
  801429:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80142c:	c9                   	leaveq 
  80142d:	c3                   	retq   

000000000080142e <strcpy>:
  80142e:	55                   	push   %rbp
  80142f:	48 89 e5             	mov    %rsp,%rbp
  801432:	48 83 ec 20          	sub    $0x20,%rsp
  801436:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80143a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80143e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801442:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801446:	90                   	nop
  801447:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80144b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80144f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801453:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801457:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  80145b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80145f:	0f b6 12             	movzbl (%rdx),%edx
  801462:	88 10                	mov    %dl,(%rax)
  801464:	0f b6 00             	movzbl (%rax),%eax
  801467:	84 c0                	test   %al,%al
  801469:	75 dc                	jne    801447 <strcpy+0x19>
  80146b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80146f:	c9                   	leaveq 
  801470:	c3                   	retq   

0000000000801471 <strcat>:
  801471:	55                   	push   %rbp
  801472:	48 89 e5             	mov    %rsp,%rbp
  801475:	48 83 ec 20          	sub    $0x20,%rsp
  801479:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80147d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801481:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801485:	48 89 c7             	mov    %rax,%rdi
  801488:	48 b8 c2 13 80 00 00 	movabs $0x8013c2,%rax
  80148f:	00 00 00 
  801492:	ff d0                	callq  *%rax
  801494:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801497:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80149a:	48 63 d0             	movslq %eax,%rdx
  80149d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014a1:	48 01 c2             	add    %rax,%rdx
  8014a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014a8:	48 89 c6             	mov    %rax,%rsi
  8014ab:	48 89 d7             	mov    %rdx,%rdi
  8014ae:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  8014b5:	00 00 00 
  8014b8:	ff d0                	callq  *%rax
  8014ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014be:	c9                   	leaveq 
  8014bf:	c3                   	retq   

00000000008014c0 <strncpy>:
  8014c0:	55                   	push   %rbp
  8014c1:	48 89 e5             	mov    %rsp,%rbp
  8014c4:	48 83 ec 28          	sub    $0x28,%rsp
  8014c8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8014cc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8014d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8014d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8014dc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  8014e3:	00 
  8014e4:	eb 2a                	jmp    801510 <strncpy+0x50>
  8014e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014ea:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8014ee:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8014f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8014f6:	0f b6 12             	movzbl (%rdx),%edx
  8014f9:	88 10                	mov    %dl,(%rax)
  8014fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8014ff:	0f b6 00             	movzbl (%rax),%eax
  801502:	84 c0                	test   %al,%al
  801504:	74 05                	je     80150b <strncpy+0x4b>
  801506:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80150b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801510:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801514:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  801518:	72 cc                	jb     8014e6 <strncpy+0x26>
  80151a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80151e:	c9                   	leaveq 
  80151f:	c3                   	retq   

0000000000801520 <strlcpy>:
  801520:	55                   	push   %rbp
  801521:	48 89 e5             	mov    %rsp,%rbp
  801524:	48 83 ec 28          	sub    $0x28,%rsp
  801528:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80152c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801530:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801534:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801538:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80153c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  801541:	74 3d                	je     801580 <strlcpy+0x60>
  801543:	eb 1d                	jmp    801562 <strlcpy+0x42>
  801545:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801549:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80154d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801551:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  801555:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  801559:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  80155d:	0f b6 12             	movzbl (%rdx),%edx
  801560:	88 10                	mov    %dl,(%rax)
  801562:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  801567:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  80156c:	74 0b                	je     801579 <strlcpy+0x59>
  80156e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801572:	0f b6 00             	movzbl (%rax),%eax
  801575:	84 c0                	test   %al,%al
  801577:	75 cc                	jne    801545 <strlcpy+0x25>
  801579:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80157d:	c6 00 00             	movb   $0x0,(%rax)
  801580:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801588:	48 29 c2             	sub    %rax,%rdx
  80158b:	48 89 d0             	mov    %rdx,%rax
  80158e:	c9                   	leaveq 
  80158f:	c3                   	retq   

0000000000801590 <strcmp>:
  801590:	55                   	push   %rbp
  801591:	48 89 e5             	mov    %rsp,%rbp
  801594:	48 83 ec 10          	sub    $0x10,%rsp
  801598:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80159c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8015a0:	eb 0a                	jmp    8015ac <strcmp+0x1c>
  8015a2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8015a7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8015ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015b0:	0f b6 00             	movzbl (%rax),%eax
  8015b3:	84 c0                	test   %al,%al
  8015b5:	74 12                	je     8015c9 <strcmp+0x39>
  8015b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015bb:	0f b6 10             	movzbl (%rax),%edx
  8015be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015c2:	0f b6 00             	movzbl (%rax),%eax
  8015c5:	38 c2                	cmp    %al,%dl
  8015c7:	74 d9                	je     8015a2 <strcmp+0x12>
  8015c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8015cd:	0f b6 00             	movzbl (%rax),%eax
  8015d0:	0f b6 d0             	movzbl %al,%edx
  8015d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8015d7:	0f b6 00             	movzbl (%rax),%eax
  8015da:	0f b6 c0             	movzbl %al,%eax
  8015dd:	29 c2                	sub    %eax,%edx
  8015df:	89 d0                	mov    %edx,%eax
  8015e1:	c9                   	leaveq 
  8015e2:	c3                   	retq   

00000000008015e3 <strncmp>:
  8015e3:	55                   	push   %rbp
  8015e4:	48 89 e5             	mov    %rsp,%rbp
  8015e7:	48 83 ec 18          	sub    $0x18,%rsp
  8015eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8015ef:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8015f3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8015f7:	eb 0f                	jmp    801608 <strncmp+0x25>
  8015f9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  8015fe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801603:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801608:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80160d:	74 1d                	je     80162c <strncmp+0x49>
  80160f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801613:	0f b6 00             	movzbl (%rax),%eax
  801616:	84 c0                	test   %al,%al
  801618:	74 12                	je     80162c <strncmp+0x49>
  80161a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80161e:	0f b6 10             	movzbl (%rax),%edx
  801621:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801625:	0f b6 00             	movzbl (%rax),%eax
  801628:	38 c2                	cmp    %al,%dl
  80162a:	74 cd                	je     8015f9 <strncmp+0x16>
  80162c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801631:	75 07                	jne    80163a <strncmp+0x57>
  801633:	b8 00 00 00 00       	mov    $0x0,%eax
  801638:	eb 18                	jmp    801652 <strncmp+0x6f>
  80163a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80163e:	0f b6 00             	movzbl (%rax),%eax
  801641:	0f b6 d0             	movzbl %al,%edx
  801644:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801648:	0f b6 00             	movzbl (%rax),%eax
  80164b:	0f b6 c0             	movzbl %al,%eax
  80164e:	29 c2                	sub    %eax,%edx
  801650:	89 d0                	mov    %edx,%eax
  801652:	c9                   	leaveq 
  801653:	c3                   	retq   

0000000000801654 <strchr>:
  801654:	55                   	push   %rbp
  801655:	48 89 e5             	mov    %rsp,%rbp
  801658:	48 83 ec 0c          	sub    $0xc,%rsp
  80165c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801660:	89 f0                	mov    %esi,%eax
  801662:	88 45 f4             	mov    %al,-0xc(%rbp)
  801665:	eb 17                	jmp    80167e <strchr+0x2a>
  801667:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80166b:	0f b6 00             	movzbl (%rax),%eax
  80166e:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801671:	75 06                	jne    801679 <strchr+0x25>
  801673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801677:	eb 15                	jmp    80168e <strchr+0x3a>
  801679:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80167e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801682:	0f b6 00             	movzbl (%rax),%eax
  801685:	84 c0                	test   %al,%al
  801687:	75 de                	jne    801667 <strchr+0x13>
  801689:	b8 00 00 00 00       	mov    $0x0,%eax
  80168e:	c9                   	leaveq 
  80168f:	c3                   	retq   

0000000000801690 <strfind>:
  801690:	55                   	push   %rbp
  801691:	48 89 e5             	mov    %rsp,%rbp
  801694:	48 83 ec 0c          	sub    $0xc,%rsp
  801698:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80169c:	89 f0                	mov    %esi,%eax
  80169e:	88 45 f4             	mov    %al,-0xc(%rbp)
  8016a1:	eb 13                	jmp    8016b6 <strfind+0x26>
  8016a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016a7:	0f b6 00             	movzbl (%rax),%eax
  8016aa:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8016ad:	75 02                	jne    8016b1 <strfind+0x21>
  8016af:	eb 10                	jmp    8016c1 <strfind+0x31>
  8016b1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8016b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016ba:	0f b6 00             	movzbl (%rax),%eax
  8016bd:	84 c0                	test   %al,%al
  8016bf:	75 e2                	jne    8016a3 <strfind+0x13>
  8016c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016c5:	c9                   	leaveq 
  8016c6:	c3                   	retq   

00000000008016c7 <memset>:
  8016c7:	55                   	push   %rbp
  8016c8:	48 89 e5             	mov    %rsp,%rbp
  8016cb:	48 83 ec 18          	sub    $0x18,%rsp
  8016cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8016d3:	89 75 f4             	mov    %esi,-0xc(%rbp)
  8016d6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8016da:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8016df:	75 06                	jne    8016e7 <memset+0x20>
  8016e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016e5:	eb 69                	jmp    801750 <memset+0x89>
  8016e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8016eb:	83 e0 03             	and    $0x3,%eax
  8016ee:	48 85 c0             	test   %rax,%rax
  8016f1:	75 48                	jne    80173b <memset+0x74>
  8016f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8016f7:	83 e0 03             	and    $0x3,%eax
  8016fa:	48 85 c0             	test   %rax,%rax
  8016fd:	75 3c                	jne    80173b <memset+0x74>
  8016ff:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  801706:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801709:	c1 e0 18             	shl    $0x18,%eax
  80170c:	89 c2                	mov    %eax,%edx
  80170e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801711:	c1 e0 10             	shl    $0x10,%eax
  801714:	09 c2                	or     %eax,%edx
  801716:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801719:	c1 e0 08             	shl    $0x8,%eax
  80171c:	09 d0                	or     %edx,%eax
  80171e:	09 45 f4             	or     %eax,-0xc(%rbp)
  801721:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801725:	48 c1 e8 02          	shr    $0x2,%rax
  801729:	48 89 c1             	mov    %rax,%rcx
  80172c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801730:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801733:	48 89 d7             	mov    %rdx,%rdi
  801736:	fc                   	cld    
  801737:	f3 ab                	rep stos %eax,%es:(%rdi)
  801739:	eb 11                	jmp    80174c <memset+0x85>
  80173b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80173f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801742:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801746:	48 89 d7             	mov    %rdx,%rdi
  801749:	fc                   	cld    
  80174a:	f3 aa                	rep stos %al,%es:(%rdi)
  80174c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801750:	c9                   	leaveq 
  801751:	c3                   	retq   

0000000000801752 <memmove>:
  801752:	55                   	push   %rbp
  801753:	48 89 e5             	mov    %rsp,%rbp
  801756:	48 83 ec 28          	sub    $0x28,%rsp
  80175a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80175e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801762:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801766:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80176a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80176e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801772:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80177a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  80177e:	0f 83 88 00 00 00    	jae    80180c <memmove+0xba>
  801784:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801788:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80178c:	48 01 d0             	add    %rdx,%rax
  80178f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  801793:	76 77                	jbe    80180c <memmove+0xba>
  801795:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801799:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  80179d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  8017a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017a9:	83 e0 03             	and    $0x3,%eax
  8017ac:	48 85 c0             	test   %rax,%rax
  8017af:	75 3b                	jne    8017ec <memmove+0x9a>
  8017b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017b5:	83 e0 03             	and    $0x3,%eax
  8017b8:	48 85 c0             	test   %rax,%rax
  8017bb:	75 2f                	jne    8017ec <memmove+0x9a>
  8017bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017c1:	83 e0 03             	and    $0x3,%eax
  8017c4:	48 85 c0             	test   %rax,%rax
  8017c7:	75 23                	jne    8017ec <memmove+0x9a>
  8017c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017cd:	48 83 e8 04          	sub    $0x4,%rax
  8017d1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8017d5:	48 83 ea 04          	sub    $0x4,%rdx
  8017d9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8017dd:	48 c1 e9 02          	shr    $0x2,%rcx
  8017e1:	48 89 c7             	mov    %rax,%rdi
  8017e4:	48 89 d6             	mov    %rdx,%rsi
  8017e7:	fd                   	std    
  8017e8:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8017ea:	eb 1d                	jmp    801809 <memmove+0xb7>
  8017ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8017f0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8017f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8017f8:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  8017fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801800:	48 89 d7             	mov    %rdx,%rdi
  801803:	48 89 c1             	mov    %rax,%rcx
  801806:	fd                   	std    
  801807:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801809:	fc                   	cld    
  80180a:	eb 57                	jmp    801863 <memmove+0x111>
  80180c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801810:	83 e0 03             	and    $0x3,%eax
  801813:	48 85 c0             	test   %rax,%rax
  801816:	75 36                	jne    80184e <memmove+0xfc>
  801818:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80181c:	83 e0 03             	and    $0x3,%eax
  80181f:	48 85 c0             	test   %rax,%rax
  801822:	75 2a                	jne    80184e <memmove+0xfc>
  801824:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801828:	83 e0 03             	and    $0x3,%eax
  80182b:	48 85 c0             	test   %rax,%rax
  80182e:	75 1e                	jne    80184e <memmove+0xfc>
  801830:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801834:	48 c1 e8 02          	shr    $0x2,%rax
  801838:	48 89 c1             	mov    %rax,%rcx
  80183b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80183f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801843:	48 89 c7             	mov    %rax,%rdi
  801846:	48 89 d6             	mov    %rdx,%rsi
  801849:	fc                   	cld    
  80184a:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80184c:	eb 15                	jmp    801863 <memmove+0x111>
  80184e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801852:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801856:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  80185a:	48 89 c7             	mov    %rax,%rdi
  80185d:	48 89 d6             	mov    %rdx,%rsi
  801860:	fc                   	cld    
  801861:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  801863:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801867:	c9                   	leaveq 
  801868:	c3                   	retq   

0000000000801869 <memcpy>:
  801869:	55                   	push   %rbp
  80186a:	48 89 e5             	mov    %rsp,%rbp
  80186d:	48 83 ec 18          	sub    $0x18,%rsp
  801871:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801875:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801879:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80187d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801881:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  801885:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801889:	48 89 ce             	mov    %rcx,%rsi
  80188c:	48 89 c7             	mov    %rax,%rdi
  80188f:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  801896:	00 00 00 
  801899:	ff d0                	callq  *%rax
  80189b:	c9                   	leaveq 
  80189c:	c3                   	retq   

000000000080189d <memcmp>:
  80189d:	55                   	push   %rbp
  80189e:	48 89 e5             	mov    %rsp,%rbp
  8018a1:	48 83 ec 28          	sub    $0x28,%rsp
  8018a5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8018a9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8018ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8018b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8018b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8018b9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8018bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8018c1:	eb 36                	jmp    8018f9 <memcmp+0x5c>
  8018c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018c7:	0f b6 10             	movzbl (%rax),%edx
  8018ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018ce:	0f b6 00             	movzbl (%rax),%eax
  8018d1:	38 c2                	cmp    %al,%dl
  8018d3:	74 1a                	je     8018ef <memcmp+0x52>
  8018d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8018d9:	0f b6 00             	movzbl (%rax),%eax
  8018dc:	0f b6 d0             	movzbl %al,%edx
  8018df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8018e3:	0f b6 00             	movzbl (%rax),%eax
  8018e6:	0f b6 c0             	movzbl %al,%eax
  8018e9:	29 c2                	sub    %eax,%edx
  8018eb:	89 d0                	mov    %edx,%eax
  8018ed:	eb 20                	jmp    80190f <memcmp+0x72>
  8018ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8018f4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  8018f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018fd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801901:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801905:	48 85 c0             	test   %rax,%rax
  801908:	75 b9                	jne    8018c3 <memcmp+0x26>
  80190a:	b8 00 00 00 00       	mov    $0x0,%eax
  80190f:	c9                   	leaveq 
  801910:	c3                   	retq   

0000000000801911 <memfind>:
  801911:	55                   	push   %rbp
  801912:	48 89 e5             	mov    %rsp,%rbp
  801915:	48 83 ec 28          	sub    $0x28,%rsp
  801919:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80191d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801920:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801924:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801928:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80192c:	48 01 d0             	add    %rdx,%rax
  80192f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801933:	eb 15                	jmp    80194a <memfind+0x39>
  801935:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801939:	0f b6 10             	movzbl (%rax),%edx
  80193c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80193f:	38 c2                	cmp    %al,%dl
  801941:	75 02                	jne    801945 <memfind+0x34>
  801943:	eb 0f                	jmp    801954 <memfind+0x43>
  801945:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  80194a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80194e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  801952:	72 e1                	jb     801935 <memfind+0x24>
  801954:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801958:	c9                   	leaveq 
  801959:	c3                   	retq   

000000000080195a <strtol>:
  80195a:	55                   	push   %rbp
  80195b:	48 89 e5             	mov    %rsp,%rbp
  80195e:	48 83 ec 34          	sub    $0x34,%rsp
  801962:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801966:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80196a:	89 55 cc             	mov    %edx,-0x34(%rbp)
  80196d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801974:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  80197b:	00 
  80197c:	eb 05                	jmp    801983 <strtol+0x29>
  80197e:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801983:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801987:	0f b6 00             	movzbl (%rax),%eax
  80198a:	3c 20                	cmp    $0x20,%al
  80198c:	74 f0                	je     80197e <strtol+0x24>
  80198e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801992:	0f b6 00             	movzbl (%rax),%eax
  801995:	3c 09                	cmp    $0x9,%al
  801997:	74 e5                	je     80197e <strtol+0x24>
  801999:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80199d:	0f b6 00             	movzbl (%rax),%eax
  8019a0:	3c 2b                	cmp    $0x2b,%al
  8019a2:	75 07                	jne    8019ab <strtol+0x51>
  8019a4:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019a9:	eb 17                	jmp    8019c2 <strtol+0x68>
  8019ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019af:	0f b6 00             	movzbl (%rax),%eax
  8019b2:	3c 2d                	cmp    $0x2d,%al
  8019b4:	75 0c                	jne    8019c2 <strtol+0x68>
  8019b6:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8019bb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  8019c2:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8019c6:	74 06                	je     8019ce <strtol+0x74>
  8019c8:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  8019cc:	75 28                	jne    8019f6 <strtol+0x9c>
  8019ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019d2:	0f b6 00             	movzbl (%rax),%eax
  8019d5:	3c 30                	cmp    $0x30,%al
  8019d7:	75 1d                	jne    8019f6 <strtol+0x9c>
  8019d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8019dd:	48 83 c0 01          	add    $0x1,%rax
  8019e1:	0f b6 00             	movzbl (%rax),%eax
  8019e4:	3c 78                	cmp    $0x78,%al
  8019e6:	75 0e                	jne    8019f6 <strtol+0x9c>
  8019e8:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  8019ed:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  8019f4:	eb 2c                	jmp    801a22 <strtol+0xc8>
  8019f6:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  8019fa:	75 19                	jne    801a15 <strtol+0xbb>
  8019fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a00:	0f b6 00             	movzbl (%rax),%eax
  801a03:	3c 30                	cmp    $0x30,%al
  801a05:	75 0e                	jne    801a15 <strtol+0xbb>
  801a07:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801a0c:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801a13:	eb 0d                	jmp    801a22 <strtol+0xc8>
  801a15:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  801a19:	75 07                	jne    801a22 <strtol+0xc8>
  801a1b:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801a22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a26:	0f b6 00             	movzbl (%rax),%eax
  801a29:	3c 2f                	cmp    $0x2f,%al
  801a2b:	7e 1d                	jle    801a4a <strtol+0xf0>
  801a2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a31:	0f b6 00             	movzbl (%rax),%eax
  801a34:	3c 39                	cmp    $0x39,%al
  801a36:	7f 12                	jg     801a4a <strtol+0xf0>
  801a38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a3c:	0f b6 00             	movzbl (%rax),%eax
  801a3f:	0f be c0             	movsbl %al,%eax
  801a42:	83 e8 30             	sub    $0x30,%eax
  801a45:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a48:	eb 4e                	jmp    801a98 <strtol+0x13e>
  801a4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a4e:	0f b6 00             	movzbl (%rax),%eax
  801a51:	3c 60                	cmp    $0x60,%al
  801a53:	7e 1d                	jle    801a72 <strtol+0x118>
  801a55:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a59:	0f b6 00             	movzbl (%rax),%eax
  801a5c:	3c 7a                	cmp    $0x7a,%al
  801a5e:	7f 12                	jg     801a72 <strtol+0x118>
  801a60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a64:	0f b6 00             	movzbl (%rax),%eax
  801a67:	0f be c0             	movsbl %al,%eax
  801a6a:	83 e8 57             	sub    $0x57,%eax
  801a6d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a70:	eb 26                	jmp    801a98 <strtol+0x13e>
  801a72:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a76:	0f b6 00             	movzbl (%rax),%eax
  801a79:	3c 40                	cmp    $0x40,%al
  801a7b:	7e 48                	jle    801ac5 <strtol+0x16b>
  801a7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a81:	0f b6 00             	movzbl (%rax),%eax
  801a84:	3c 5a                	cmp    $0x5a,%al
  801a86:	7f 3d                	jg     801ac5 <strtol+0x16b>
  801a88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a8c:	0f b6 00             	movzbl (%rax),%eax
  801a8f:	0f be c0             	movsbl %al,%eax
  801a92:	83 e8 37             	sub    $0x37,%eax
  801a95:	89 45 ec             	mov    %eax,-0x14(%rbp)
  801a98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801a9b:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801a9e:	7c 02                	jl     801aa2 <strtol+0x148>
  801aa0:	eb 23                	jmp    801ac5 <strtol+0x16b>
  801aa2:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801aa7:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801aaa:	48 98                	cltq   
  801aac:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801ab1:	48 89 c2             	mov    %rax,%rdx
  801ab4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801ab7:	48 98                	cltq   
  801ab9:	48 01 d0             	add    %rdx,%rax
  801abc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801ac0:	e9 5d ff ff ff       	jmpq   801a22 <strtol+0xc8>
  801ac5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  801aca:	74 0b                	je     801ad7 <strtol+0x17d>
  801acc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801ad0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801ad4:	48 89 10             	mov    %rdx,(%rax)
  801ad7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801adb:	74 09                	je     801ae6 <strtol+0x18c>
  801add:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801ae1:	48 f7 d8             	neg    %rax
  801ae4:	eb 04                	jmp    801aea <strtol+0x190>
  801ae6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801aea:	c9                   	leaveq 
  801aeb:	c3                   	retq   

0000000000801aec <strstr>:
  801aec:	55                   	push   %rbp
  801aed:	48 89 e5             	mov    %rsp,%rbp
  801af0:	48 83 ec 30          	sub    $0x30,%rsp
  801af4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801af8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801afc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801b00:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801b04:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801b08:	0f b6 00             	movzbl (%rax),%eax
  801b0b:	88 45 ff             	mov    %al,-0x1(%rbp)
  801b0e:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801b12:	75 06                	jne    801b1a <strstr+0x2e>
  801b14:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b18:	eb 6b                	jmp    801b85 <strstr+0x99>
  801b1a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801b1e:	48 89 c7             	mov    %rax,%rdi
  801b21:	48 b8 c2 13 80 00 00 	movabs $0x8013c2,%rax
  801b28:	00 00 00 
  801b2b:	ff d0                	callq  *%rax
  801b2d:	48 98                	cltq   
  801b2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801b33:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b37:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801b3b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801b3f:	0f b6 00             	movzbl (%rax),%eax
  801b42:	88 45 ef             	mov    %al,-0x11(%rbp)
  801b45:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  801b49:	75 07                	jne    801b52 <strstr+0x66>
  801b4b:	b8 00 00 00 00       	mov    $0x0,%eax
  801b50:	eb 33                	jmp    801b85 <strstr+0x99>
  801b52:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801b56:	3a 45 ff             	cmp    -0x1(%rbp),%al
  801b59:	75 d8                	jne    801b33 <strstr+0x47>
  801b5b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801b5f:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  801b63:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b67:	48 89 ce             	mov    %rcx,%rsi
  801b6a:	48 89 c7             	mov    %rax,%rdi
  801b6d:	48 b8 e3 15 80 00 00 	movabs $0x8015e3,%rax
  801b74:	00 00 00 
  801b77:	ff d0                	callq  *%rax
  801b79:	85 c0                	test   %eax,%eax
  801b7b:	75 b6                	jne    801b33 <strstr+0x47>
  801b7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b81:	48 83 e8 01          	sub    $0x1,%rax
  801b85:	c9                   	leaveq 
  801b86:	c3                   	retq   

0000000000801b87 <syscall>:
  801b87:	55                   	push   %rbp
  801b88:	48 89 e5             	mov    %rsp,%rbp
  801b8b:	53                   	push   %rbx
  801b8c:	48 83 ec 48          	sub    $0x48,%rsp
  801b90:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801b93:	89 75 d8             	mov    %esi,-0x28(%rbp)
  801b96:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  801b9a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801b9e:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801ba2:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  801ba6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801ba9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801bad:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801bb1:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801bb5:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  801bb9:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801bbd:	4c 89 c3             	mov    %r8,%rbx
  801bc0:	cd 30                	int    $0x30
  801bc2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801bc6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801bca:	74 3e                	je     801c0a <syscall+0x83>
  801bcc:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801bd1:	7e 37                	jle    801c0a <syscall+0x83>
  801bd3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801bd7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  801bda:	49 89 d0             	mov    %rdx,%r8
  801bdd:	89 c1                	mov    %eax,%ecx
  801bdf:	48 ba a8 52 80 00 00 	movabs $0x8052a8,%rdx
  801be6:	00 00 00 
  801be9:	be 24 00 00 00       	mov    $0x24,%esi
  801bee:	48 bf c5 52 80 00 00 	movabs $0x8052c5,%rdi
  801bf5:	00 00 00 
  801bf8:	b8 00 00 00 00       	mov    $0x0,%eax
  801bfd:	49 b9 40 06 80 00 00 	movabs $0x800640,%r9
  801c04:	00 00 00 
  801c07:	41 ff d1             	callq  *%r9
  801c0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801c0e:	48 83 c4 48          	add    $0x48,%rsp
  801c12:	5b                   	pop    %rbx
  801c13:	5d                   	pop    %rbp
  801c14:	c3                   	retq   

0000000000801c15 <sys_cputs>:
  801c15:	55                   	push   %rbp
  801c16:	48 89 e5             	mov    %rsp,%rbp
  801c19:	48 83 ec 20          	sub    $0x20,%rsp
  801c1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c21:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c29:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c2d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c34:	00 
  801c35:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c3b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c41:	48 89 d1             	mov    %rdx,%rcx
  801c44:	48 89 c2             	mov    %rax,%rdx
  801c47:	be 00 00 00 00       	mov    $0x0,%esi
  801c4c:	bf 00 00 00 00       	mov    $0x0,%edi
  801c51:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801c58:	00 00 00 
  801c5b:	ff d0                	callq  *%rax
  801c5d:	c9                   	leaveq 
  801c5e:	c3                   	retq   

0000000000801c5f <sys_cgetc>:
  801c5f:	55                   	push   %rbp
  801c60:	48 89 e5             	mov    %rsp,%rbp
  801c63:	48 83 ec 10          	sub    $0x10,%rsp
  801c67:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c6e:	00 
  801c6f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c75:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c7b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801c80:	ba 00 00 00 00       	mov    $0x0,%edx
  801c85:	be 00 00 00 00       	mov    $0x0,%esi
  801c8a:	bf 01 00 00 00       	mov    $0x1,%edi
  801c8f:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801c96:	00 00 00 
  801c99:	ff d0                	callq  *%rax
  801c9b:	c9                   	leaveq 
  801c9c:	c3                   	retq   

0000000000801c9d <sys_env_destroy>:
  801c9d:	55                   	push   %rbp
  801c9e:	48 89 e5             	mov    %rsp,%rbp
  801ca1:	48 83 ec 10          	sub    $0x10,%rsp
  801ca5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ca8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801cab:	48 98                	cltq   
  801cad:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cb4:	00 
  801cb5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cbb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cc1:	b9 00 00 00 00       	mov    $0x0,%ecx
  801cc6:	48 89 c2             	mov    %rax,%rdx
  801cc9:	be 01 00 00 00       	mov    $0x1,%esi
  801cce:	bf 03 00 00 00       	mov    $0x3,%edi
  801cd3:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801cda:	00 00 00 
  801cdd:	ff d0                	callq  *%rax
  801cdf:	c9                   	leaveq 
  801ce0:	c3                   	retq   

0000000000801ce1 <sys_getenvid>:
  801ce1:	55                   	push   %rbp
  801ce2:	48 89 e5             	mov    %rsp,%rbp
  801ce5:	48 83 ec 10          	sub    $0x10,%rsp
  801ce9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801cf0:	00 
  801cf1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801cf7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801cfd:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d02:	ba 00 00 00 00       	mov    $0x0,%edx
  801d07:	be 00 00 00 00       	mov    $0x0,%esi
  801d0c:	bf 02 00 00 00       	mov    $0x2,%edi
  801d11:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801d18:	00 00 00 
  801d1b:	ff d0                	callq  *%rax
  801d1d:	c9                   	leaveq 
  801d1e:	c3                   	retq   

0000000000801d1f <sys_yield>:
  801d1f:	55                   	push   %rbp
  801d20:	48 89 e5             	mov    %rsp,%rbp
  801d23:	48 83 ec 10          	sub    $0x10,%rsp
  801d27:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d2e:	00 
  801d2f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d35:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801d3b:	b9 00 00 00 00       	mov    $0x0,%ecx
  801d40:	ba 00 00 00 00       	mov    $0x0,%edx
  801d45:	be 00 00 00 00       	mov    $0x0,%esi
  801d4a:	bf 0b 00 00 00       	mov    $0xb,%edi
  801d4f:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801d56:	00 00 00 
  801d59:	ff d0                	callq  *%rax
  801d5b:	c9                   	leaveq 
  801d5c:	c3                   	retq   

0000000000801d5d <sys_page_alloc>:
  801d5d:	55                   	push   %rbp
  801d5e:	48 89 e5             	mov    %rsp,%rbp
  801d61:	48 83 ec 20          	sub    $0x20,%rsp
  801d65:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801d68:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801d6c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801d6f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801d72:	48 63 c8             	movslq %eax,%rcx
  801d75:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d79:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d7c:	48 98                	cltq   
  801d7e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801d85:	00 
  801d86:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801d8c:	49 89 c8             	mov    %rcx,%r8
  801d8f:	48 89 d1             	mov    %rdx,%rcx
  801d92:	48 89 c2             	mov    %rax,%rdx
  801d95:	be 01 00 00 00       	mov    $0x1,%esi
  801d9a:	bf 04 00 00 00       	mov    $0x4,%edi
  801d9f:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801da6:	00 00 00 
  801da9:	ff d0                	callq  *%rax
  801dab:	c9                   	leaveq 
  801dac:	c3                   	retq   

0000000000801dad <sys_page_map>:
  801dad:	55                   	push   %rbp
  801dae:	48 89 e5             	mov    %rsp,%rbp
  801db1:	48 83 ec 30          	sub    $0x30,%rsp
  801db5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801db8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801dbc:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801dbf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801dc3:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801dc7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801dca:	48 63 c8             	movslq %eax,%rcx
  801dcd:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801dd1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801dd4:	48 63 f0             	movslq %eax,%rsi
  801dd7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801ddb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801dde:	48 98                	cltq   
  801de0:	48 89 0c 24          	mov    %rcx,(%rsp)
  801de4:	49 89 f9             	mov    %rdi,%r9
  801de7:	49 89 f0             	mov    %rsi,%r8
  801dea:	48 89 d1             	mov    %rdx,%rcx
  801ded:	48 89 c2             	mov    %rax,%rdx
  801df0:	be 01 00 00 00       	mov    $0x1,%esi
  801df5:	bf 05 00 00 00       	mov    $0x5,%edi
  801dfa:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801e01:	00 00 00 
  801e04:	ff d0                	callq  *%rax
  801e06:	c9                   	leaveq 
  801e07:	c3                   	retq   

0000000000801e08 <sys_page_unmap>:
  801e08:	55                   	push   %rbp
  801e09:	48 89 e5             	mov    %rsp,%rbp
  801e0c:	48 83 ec 20          	sub    $0x20,%rsp
  801e10:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e13:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801e17:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801e1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e1e:	48 98                	cltq   
  801e20:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e27:	00 
  801e28:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e2e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e34:	48 89 d1             	mov    %rdx,%rcx
  801e37:	48 89 c2             	mov    %rax,%rdx
  801e3a:	be 01 00 00 00       	mov    $0x1,%esi
  801e3f:	bf 06 00 00 00       	mov    $0x6,%edi
  801e44:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801e4b:	00 00 00 
  801e4e:	ff d0                	callq  *%rax
  801e50:	c9                   	leaveq 
  801e51:	c3                   	retq   

0000000000801e52 <sys_env_set_status>:
  801e52:	55                   	push   %rbp
  801e53:	48 89 e5             	mov    %rsp,%rbp
  801e56:	48 83 ec 10          	sub    $0x10,%rsp
  801e5a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801e5d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  801e60:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801e63:	48 63 d0             	movslq %eax,%rdx
  801e66:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e69:	48 98                	cltq   
  801e6b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801e72:	00 
  801e73:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801e79:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801e7f:	48 89 d1             	mov    %rdx,%rcx
  801e82:	48 89 c2             	mov    %rax,%rdx
  801e85:	be 01 00 00 00       	mov    $0x1,%esi
  801e8a:	bf 08 00 00 00       	mov    $0x8,%edi
  801e8f:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801e96:	00 00 00 
  801e99:	ff d0                	callq  *%rax
  801e9b:	c9                   	leaveq 
  801e9c:	c3                   	retq   

0000000000801e9d <sys_env_set_trapframe>:
  801e9d:	55                   	push   %rbp
  801e9e:	48 89 e5             	mov    %rsp,%rbp
  801ea1:	48 83 ec 20          	sub    $0x20,%rsp
  801ea5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ea8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801eac:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801eb0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801eb3:	48 98                	cltq   
  801eb5:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ebc:	00 
  801ebd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801ec3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801ec9:	48 89 d1             	mov    %rdx,%rcx
  801ecc:	48 89 c2             	mov    %rax,%rdx
  801ecf:	be 01 00 00 00       	mov    $0x1,%esi
  801ed4:	bf 09 00 00 00       	mov    $0x9,%edi
  801ed9:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801ee0:	00 00 00 
  801ee3:	ff d0                	callq  *%rax
  801ee5:	c9                   	leaveq 
  801ee6:	c3                   	retq   

0000000000801ee7 <sys_env_set_pgfault_upcall>:
  801ee7:	55                   	push   %rbp
  801ee8:	48 89 e5             	mov    %rsp,%rbp
  801eeb:	48 83 ec 20          	sub    $0x20,%rsp
  801eef:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801ef2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801ef6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801efa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801efd:	48 98                	cltq   
  801eff:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f06:	00 
  801f07:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801f0d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801f13:	48 89 d1             	mov    %rdx,%rcx
  801f16:	48 89 c2             	mov    %rax,%rdx
  801f19:	be 01 00 00 00       	mov    $0x1,%esi
  801f1e:	bf 0a 00 00 00       	mov    $0xa,%edi
  801f23:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801f2a:	00 00 00 
  801f2d:	ff d0                	callq  *%rax
  801f2f:	c9                   	leaveq 
  801f30:	c3                   	retq   

0000000000801f31 <sys_ipc_try_send>:
  801f31:	55                   	push   %rbp
  801f32:	48 89 e5             	mov    %rsp,%rbp
  801f35:	48 83 ec 20          	sub    $0x20,%rsp
  801f39:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801f3c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801f40:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801f44:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801f47:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801f4a:	48 63 f0             	movslq %eax,%rsi
  801f4d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801f51:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801f54:	48 98                	cltq   
  801f56:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801f5a:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f61:	00 
  801f62:	49 89 f1             	mov    %rsi,%r9
  801f65:	49 89 c8             	mov    %rcx,%r8
  801f68:	48 89 d1             	mov    %rdx,%rcx
  801f6b:	48 89 c2             	mov    %rax,%rdx
  801f6e:	be 00 00 00 00       	mov    $0x0,%esi
  801f73:	bf 0c 00 00 00       	mov    $0xc,%edi
  801f78:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801f7f:	00 00 00 
  801f82:	ff d0                	callq  *%rax
  801f84:	c9                   	leaveq 
  801f85:	c3                   	retq   

0000000000801f86 <sys_ipc_recv>:
  801f86:	55                   	push   %rbp
  801f87:	48 89 e5             	mov    %rsp,%rbp
  801f8a:	48 83 ec 10          	sub    $0x10,%rsp
  801f8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801f92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801f96:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801f9d:	00 
  801f9e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fa4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801faa:	b9 00 00 00 00       	mov    $0x0,%ecx
  801faf:	48 89 c2             	mov    %rax,%rdx
  801fb2:	be 01 00 00 00       	mov    $0x1,%esi
  801fb7:	bf 0d 00 00 00       	mov    $0xd,%edi
  801fbc:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  801fc3:	00 00 00 
  801fc6:	ff d0                	callq  *%rax
  801fc8:	c9                   	leaveq 
  801fc9:	c3                   	retq   

0000000000801fca <sys_time_msec>:
  801fca:	55                   	push   %rbp
  801fcb:	48 89 e5             	mov    %rsp,%rbp
  801fce:	48 83 ec 10          	sub    $0x10,%rsp
  801fd2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801fd9:	00 
  801fda:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801fe0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801fe6:	b9 00 00 00 00       	mov    $0x0,%ecx
  801feb:	ba 00 00 00 00       	mov    $0x0,%edx
  801ff0:	be 00 00 00 00       	mov    $0x0,%esi
  801ff5:	bf 0e 00 00 00       	mov    $0xe,%edi
  801ffa:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  802001:	00 00 00 
  802004:	ff d0                	callq  *%rax
  802006:	c9                   	leaveq 
  802007:	c3                   	retq   

0000000000802008 <sys_net_transmit>:
  802008:	55                   	push   %rbp
  802009:	48 89 e5             	mov    %rsp,%rbp
  80200c:	48 83 ec 20          	sub    $0x20,%rsp
  802010:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802014:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802017:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80201a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80201e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802025:	00 
  802026:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80202c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  802032:	48 89 d1             	mov    %rdx,%rcx
  802035:	48 89 c2             	mov    %rax,%rdx
  802038:	be 00 00 00 00       	mov    $0x0,%esi
  80203d:	bf 0f 00 00 00       	mov    $0xf,%edi
  802042:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  802049:	00 00 00 
  80204c:	ff d0                	callq  *%rax
  80204e:	c9                   	leaveq 
  80204f:	c3                   	retq   

0000000000802050 <sys_net_receive>:
  802050:	55                   	push   %rbp
  802051:	48 89 e5             	mov    %rsp,%rbp
  802054:	48 83 ec 20          	sub    $0x20,%rsp
  802058:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80205c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80205f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802062:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802066:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80206d:	00 
  80206e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802074:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80207a:	48 89 d1             	mov    %rdx,%rcx
  80207d:	48 89 c2             	mov    %rax,%rdx
  802080:	be 00 00 00 00       	mov    $0x0,%esi
  802085:	bf 10 00 00 00       	mov    $0x10,%edi
  80208a:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  802091:	00 00 00 
  802094:	ff d0                	callq  *%rax
  802096:	c9                   	leaveq 
  802097:	c3                   	retq   

0000000000802098 <sys_ept_map>:
  802098:	55                   	push   %rbp
  802099:	48 89 e5             	mov    %rsp,%rbp
  80209c:	48 83 ec 30          	sub    $0x30,%rsp
  8020a0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8020a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8020a7:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8020aa:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  8020ae:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  8020b2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8020b5:	48 63 c8             	movslq %eax,%rcx
  8020b8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  8020bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8020bf:	48 63 f0             	movslq %eax,%rsi
  8020c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8020c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8020c9:	48 98                	cltq   
  8020cb:	48 89 0c 24          	mov    %rcx,(%rsp)
  8020cf:	49 89 f9             	mov    %rdi,%r9
  8020d2:	49 89 f0             	mov    %rsi,%r8
  8020d5:	48 89 d1             	mov    %rdx,%rcx
  8020d8:	48 89 c2             	mov    %rax,%rdx
  8020db:	be 00 00 00 00       	mov    $0x0,%esi
  8020e0:	bf 11 00 00 00       	mov    $0x11,%edi
  8020e5:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  8020ec:	00 00 00 
  8020ef:	ff d0                	callq  *%rax
  8020f1:	c9                   	leaveq 
  8020f2:	c3                   	retq   

00000000008020f3 <sys_env_mkguest>:
  8020f3:	55                   	push   %rbp
  8020f4:	48 89 e5             	mov    %rsp,%rbp
  8020f7:	48 83 ec 20          	sub    $0x20,%rsp
  8020fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8020ff:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802103:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802107:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80210b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  802112:	00 
  802113:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  802119:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80211f:	48 89 d1             	mov    %rdx,%rcx
  802122:	48 89 c2             	mov    %rax,%rdx
  802125:	be 00 00 00 00       	mov    $0x0,%esi
  80212a:	bf 12 00 00 00       	mov    $0x12,%edi
  80212f:	48 b8 87 1b 80 00 00 	movabs $0x801b87,%rax
  802136:	00 00 00 
  802139:	ff d0                	callq  *%rax
  80213b:	c9                   	leaveq 
  80213c:	c3                   	retq   

000000000080213d <pgfault>:
  80213d:	55                   	push   %rbp
  80213e:	48 89 e5             	mov    %rsp,%rbp
  802141:	48 83 ec 30          	sub    $0x30,%rsp
  802145:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802149:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80214d:	48 8b 00             	mov    (%rax),%rax
  802150:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802154:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802158:	48 8b 40 08          	mov    0x8(%rax),%rax
  80215c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80215f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802162:	83 e0 02             	and    $0x2,%eax
  802165:	85 c0                	test   %eax,%eax
  802167:	75 40                	jne    8021a9 <pgfault+0x6c>
  802169:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80216d:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  802174:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802178:	49 89 d0             	mov    %rdx,%r8
  80217b:	48 89 c1             	mov    %rax,%rcx
  80217e:	48 ba d8 52 80 00 00 	movabs $0x8052d8,%rdx
  802185:	00 00 00 
  802188:	be 1f 00 00 00       	mov    $0x1f,%esi
  80218d:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802194:	00 00 00 
  802197:	b8 00 00 00 00       	mov    $0x0,%eax
  80219c:	49 b9 40 06 80 00 00 	movabs $0x800640,%r9
  8021a3:	00 00 00 
  8021a6:	41 ff d1             	callq  *%r9
  8021a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021ad:	48 c1 e8 0c          	shr    $0xc,%rax
  8021b1:	48 89 c2             	mov    %rax,%rdx
  8021b4:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021bb:	01 00 00 
  8021be:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8021c2:	25 07 08 00 00       	and    $0x807,%eax
  8021c7:	48 3d 05 08 00 00    	cmp    $0x805,%rax
  8021cd:	74 4e                	je     80221d <pgfault+0xe0>
  8021cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021d3:	48 c1 e8 0c          	shr    $0xc,%rax
  8021d7:	48 89 c2             	mov    %rax,%rdx
  8021da:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8021e1:	01 00 00 
  8021e4:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  8021e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021ec:	49 89 d0             	mov    %rdx,%r8
  8021ef:	48 89 c1             	mov    %rax,%rcx
  8021f2:	48 ba 00 53 80 00 00 	movabs $0x805300,%rdx
  8021f9:	00 00 00 
  8021fc:	be 22 00 00 00       	mov    $0x22,%esi
  802201:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802208:	00 00 00 
  80220b:	b8 00 00 00 00       	mov    $0x0,%eax
  802210:	49 b9 40 06 80 00 00 	movabs $0x800640,%r9
  802217:	00 00 00 
  80221a:	41 ff d1             	callq  *%r9
  80221d:	ba 07 00 00 00       	mov    $0x7,%edx
  802222:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802227:	bf 00 00 00 00       	mov    $0x0,%edi
  80222c:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  802233:	00 00 00 
  802236:	ff d0                	callq  *%rax
  802238:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80223b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80223f:	79 30                	jns    802271 <pgfault+0x134>
  802241:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802244:	89 c1                	mov    %eax,%ecx
  802246:	48 ba 2b 53 80 00 00 	movabs $0x80532b,%rdx
  80224d:	00 00 00 
  802250:	be 30 00 00 00       	mov    $0x30,%esi
  802255:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80225c:	00 00 00 
  80225f:	b8 00 00 00 00       	mov    $0x0,%eax
  802264:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  80226b:	00 00 00 
  80226e:	41 ff d0             	callq  *%r8
  802271:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802275:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802279:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80227d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  802283:	ba 00 10 00 00       	mov    $0x1000,%edx
  802288:	48 89 c6             	mov    %rax,%rsi
  80228b:	bf 00 f0 5f 00       	mov    $0x5ff000,%edi
  802290:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  802297:	00 00 00 
  80229a:	ff d0                	callq  *%rax
  80229c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022a0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8022a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022a8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  8022ae:	41 b8 07 00 00 00    	mov    $0x7,%r8d
  8022b4:	48 89 c1             	mov    %rax,%rcx
  8022b7:	ba 00 00 00 00       	mov    $0x0,%edx
  8022bc:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  8022c1:	bf 00 00 00 00       	mov    $0x0,%edi
  8022c6:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8022cd:	00 00 00 
  8022d0:	ff d0                	callq  *%rax
  8022d2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022d5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022d9:	79 30                	jns    80230b <pgfault+0x1ce>
  8022db:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022de:	89 c1                	mov    %eax,%ecx
  8022e0:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  8022e7:	00 00 00 
  8022ea:	be 35 00 00 00       	mov    $0x35,%esi
  8022ef:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8022f6:	00 00 00 
  8022f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8022fe:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  802305:	00 00 00 
  802308:	41 ff d0             	callq  *%r8
  80230b:	be 00 f0 5f 00       	mov    $0x5ff000,%esi
  802310:	bf 00 00 00 00       	mov    $0x0,%edi
  802315:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  80231c:	00 00 00 
  80231f:	ff d0                	callq  *%rax
  802321:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802324:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802328:	79 30                	jns    80235a <pgfault+0x21d>
  80232a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80232d:	89 c1                	mov    %eax,%ecx
  80232f:	48 ba 4f 53 80 00 00 	movabs $0x80534f,%rdx
  802336:	00 00 00 
  802339:	be 39 00 00 00       	mov    $0x39,%esi
  80233e:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802345:	00 00 00 
  802348:	b8 00 00 00 00       	mov    $0x0,%eax
  80234d:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  802354:	00 00 00 
  802357:	41 ff d0             	callq  *%r8
  80235a:	c9                   	leaveq 
  80235b:	c3                   	retq   

000000000080235c <duppage>:
  80235c:	55                   	push   %rbp
  80235d:	48 89 e5             	mov    %rsp,%rbp
  802360:	48 83 ec 30          	sub    $0x30,%rsp
  802364:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802367:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80236a:	8b 45 d8             	mov    -0x28(%rbp),%eax
  80236d:	c1 e0 0c             	shl    $0xc,%eax
  802370:	89 c0                	mov    %eax,%eax
  802372:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802376:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80237d:	01 00 00 
  802380:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802383:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802387:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80238b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80238f:	25 02 08 00 00       	and    $0x802,%eax
  802394:	48 85 c0             	test   %rax,%rax
  802397:	74 0e                	je     8023a7 <duppage+0x4b>
  802399:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80239d:	25 00 04 00 00       	and    $0x400,%eax
  8023a2:	48 85 c0             	test   %rax,%rax
  8023a5:	74 70                	je     802417 <duppage+0xbb>
  8023a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023ab:	25 07 0e 00 00       	and    $0xe07,%eax
  8023b0:	89 c6                	mov    %eax,%esi
  8023b2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8023b6:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8023b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8023bd:	41 89 f0             	mov    %esi,%r8d
  8023c0:	48 89 c6             	mov    %rax,%rsi
  8023c3:	bf 00 00 00 00       	mov    $0x0,%edi
  8023c8:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8023cf:	00 00 00 
  8023d2:	ff d0                	callq  *%rax
  8023d4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8023d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8023db:	79 30                	jns    80240d <duppage+0xb1>
  8023dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8023e0:	89 c1                	mov    %eax,%ecx
  8023e2:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  8023e9:	00 00 00 
  8023ec:	be 63 00 00 00       	mov    $0x63,%esi
  8023f1:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8023f8:	00 00 00 
  8023fb:	b8 00 00 00 00       	mov    $0x0,%eax
  802400:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  802407:	00 00 00 
  80240a:	41 ff d0             	callq  *%r8
  80240d:	b8 00 00 00 00       	mov    $0x0,%eax
  802412:	e9 c4 00 00 00       	jmpq   8024db <duppage+0x17f>
  802417:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  80241b:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80241e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802422:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802428:	48 89 c6             	mov    %rax,%rsi
  80242b:	bf 00 00 00 00       	mov    $0x0,%edi
  802430:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  802437:	00 00 00 
  80243a:	ff d0                	callq  *%rax
  80243c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80243f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802443:	79 30                	jns    802475 <duppage+0x119>
  802445:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802448:	89 c1                	mov    %eax,%ecx
  80244a:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  802451:	00 00 00 
  802454:	be 7e 00 00 00       	mov    $0x7e,%esi
  802459:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  802460:	00 00 00 
  802463:	b8 00 00 00 00       	mov    $0x0,%eax
  802468:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  80246f:	00 00 00 
  802472:	41 ff d0             	callq  *%r8
  802475:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80247d:	41 b8 05 08 00 00    	mov    $0x805,%r8d
  802483:	48 89 d1             	mov    %rdx,%rcx
  802486:	ba 00 00 00 00       	mov    $0x0,%edx
  80248b:	48 89 c6             	mov    %rax,%rsi
  80248e:	bf 00 00 00 00       	mov    $0x0,%edi
  802493:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  80249a:	00 00 00 
  80249d:	ff d0                	callq  *%rax
  80249f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8024a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8024a6:	79 30                	jns    8024d8 <duppage+0x17c>
  8024a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024ab:	89 c1                	mov    %eax,%ecx
  8024ad:	48 ba 3e 53 80 00 00 	movabs $0x80533e,%rdx
  8024b4:	00 00 00 
  8024b7:	be 80 00 00 00       	mov    $0x80,%esi
  8024bc:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8024c3:	00 00 00 
  8024c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8024cb:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  8024d2:	00 00 00 
  8024d5:	41 ff d0             	callq  *%r8
  8024d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8024db:	c9                   	leaveq 
  8024dc:	c3                   	retq   

00000000008024dd <fork>:
  8024dd:	55                   	push   %rbp
  8024de:	48 89 e5             	mov    %rsp,%rbp
  8024e1:	48 83 ec 20          	sub    $0x20,%rsp
  8024e5:	48 bf 3d 21 80 00 00 	movabs $0x80213d,%rdi
  8024ec:	00 00 00 
  8024ef:	48 b8 43 4a 80 00 00 	movabs $0x804a43,%rax
  8024f6:	00 00 00 
  8024f9:	ff d0                	callq  *%rax
  8024fb:	b8 07 00 00 00       	mov    $0x7,%eax
  802500:	cd 30                	int    $0x30
  802502:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802505:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802508:	89 45 f8             	mov    %eax,-0x8(%rbp)
  80250b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80250f:	79 08                	jns    802519 <fork+0x3c>
  802511:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802514:	e9 09 02 00 00       	jmpq   802722 <fork+0x245>
  802519:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  80251d:	75 3e                	jne    80255d <fork+0x80>
  80251f:	48 b8 e1 1c 80 00 00 	movabs $0x801ce1,%rax
  802526:	00 00 00 
  802529:	ff d0                	callq  *%rax
  80252b:	25 ff 03 00 00       	and    $0x3ff,%eax
  802530:	48 98                	cltq   
  802532:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  802539:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802540:	00 00 00 
  802543:	48 01 c2             	add    %rax,%rdx
  802546:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  80254d:	00 00 00 
  802550:	48 89 10             	mov    %rdx,(%rax)
  802553:	b8 00 00 00 00       	mov    $0x0,%eax
  802558:	e9 c5 01 00 00       	jmpq   802722 <fork+0x245>
  80255d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802564:	e9 a4 00 00 00       	jmpq   80260d <fork+0x130>
  802569:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80256c:	c1 f8 12             	sar    $0x12,%eax
  80256f:	89 c2                	mov    %eax,%edx
  802571:	48 b8 00 00 40 80 00 	movabs $0x10080400000,%rax
  802578:	01 00 00 
  80257b:	48 63 d2             	movslq %edx,%rdx
  80257e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802582:	83 e0 01             	and    $0x1,%eax
  802585:	48 85 c0             	test   %rax,%rax
  802588:	74 21                	je     8025ab <fork+0xce>
  80258a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80258d:	c1 f8 09             	sar    $0x9,%eax
  802590:	89 c2                	mov    %eax,%edx
  802592:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802599:	01 00 00 
  80259c:	48 63 d2             	movslq %edx,%rdx
  80259f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8025a3:	83 e0 01             	and    $0x1,%eax
  8025a6:	48 85 c0             	test   %rax,%rax
  8025a9:	75 09                	jne    8025b4 <fork+0xd7>
  8025ab:	81 45 fc 00 02 00 00 	addl   $0x200,-0x4(%rbp)
  8025b2:	eb 59                	jmp    80260d <fork+0x130>
  8025b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025b7:	05 00 02 00 00       	add    $0x200,%eax
  8025bc:	89 45 f4             	mov    %eax,-0xc(%rbp)
  8025bf:	eb 44                	jmp    802605 <fork+0x128>
  8025c1:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8025c8:	01 00 00 
  8025cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8025ce:	48 63 d2             	movslq %edx,%rdx
  8025d1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8025d5:	83 e0 05             	and    $0x5,%eax
  8025d8:	48 83 f8 05          	cmp    $0x5,%rax
  8025dc:	74 02                	je     8025e0 <fork+0x103>
  8025de:	eb 21                	jmp    802601 <fork+0x124>
  8025e0:	81 7d fc ff f7 0e 00 	cmpl   $0xef7ff,-0x4(%rbp)
  8025e7:	75 02                	jne    8025eb <fork+0x10e>
  8025e9:	eb 16                	jmp    802601 <fork+0x124>
  8025eb:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8025ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8025f1:	89 d6                	mov    %edx,%esi
  8025f3:	89 c7                	mov    %eax,%edi
  8025f5:	48 b8 5c 23 80 00 00 	movabs $0x80235c,%rax
  8025fc:	00 00 00 
  8025ff:	ff d0                	callq  *%rax
  802601:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802605:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802608:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  80260b:	7c b4                	jl     8025c1 <fork+0xe4>
  80260d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802610:	3d ff 07 00 08       	cmp    $0x80007ff,%eax
  802615:	0f 86 4e ff ff ff    	jbe    802569 <fork+0x8c>
  80261b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80261e:	ba 07 00 00 00       	mov    $0x7,%edx
  802623:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  802628:	89 c7                	mov    %eax,%edi
  80262a:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  802631:	00 00 00 
  802634:	ff d0                	callq  *%rax
  802636:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802639:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80263d:	79 30                	jns    80266f <fork+0x192>
  80263f:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802642:	89 c1                	mov    %eax,%ecx
  802644:	48 ba 68 53 80 00 00 	movabs $0x805368,%rdx
  80264b:	00 00 00 
  80264e:	be bc 00 00 00       	mov    $0xbc,%esi
  802653:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80265a:	00 00 00 
  80265d:	b8 00 00 00 00       	mov    $0x0,%eax
  802662:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  802669:	00 00 00 
  80266c:	41 ff d0             	callq  *%r8
  80266f:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  802676:	00 00 00 
  802679:	48 8b 00             	mov    (%rax),%rax
  80267c:	48 8b 90 f0 00 00 00 	mov    0xf0(%rax),%rdx
  802683:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802686:	48 89 d6             	mov    %rdx,%rsi
  802689:	89 c7                	mov    %eax,%edi
  80268b:	48 b8 e7 1e 80 00 00 	movabs $0x801ee7,%rax
  802692:	00 00 00 
  802695:	ff d0                	callq  *%rax
  802697:	89 45 f0             	mov    %eax,-0x10(%rbp)
  80269a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  80269e:	79 30                	jns    8026d0 <fork+0x1f3>
  8026a0:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8026a3:	89 c1                	mov    %eax,%ecx
  8026a5:	48 ba 88 53 80 00 00 	movabs $0x805388,%rdx
  8026ac:	00 00 00 
  8026af:	be c0 00 00 00       	mov    $0xc0,%esi
  8026b4:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  8026bb:	00 00 00 
  8026be:	b8 00 00 00 00       	mov    $0x0,%eax
  8026c3:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  8026ca:	00 00 00 
  8026cd:	41 ff d0             	callq  *%r8
  8026d0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8026d3:	be 02 00 00 00       	mov    $0x2,%esi
  8026d8:	89 c7                	mov    %eax,%edi
  8026da:	48 b8 52 1e 80 00 00 	movabs $0x801e52,%rax
  8026e1:	00 00 00 
  8026e4:	ff d0                	callq  *%rax
  8026e6:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8026e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8026ed:	79 30                	jns    80271f <fork+0x242>
  8026ef:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8026f2:	89 c1                	mov    %eax,%ecx
  8026f4:	48 ba a7 53 80 00 00 	movabs $0x8053a7,%rdx
  8026fb:	00 00 00 
  8026fe:	be c5 00 00 00       	mov    $0xc5,%esi
  802703:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80270a:	00 00 00 
  80270d:	b8 00 00 00 00       	mov    $0x0,%eax
  802712:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  802719:	00 00 00 
  80271c:	41 ff d0             	callq  *%r8
  80271f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802722:	c9                   	leaveq 
  802723:	c3                   	retq   

0000000000802724 <sfork>:
  802724:	55                   	push   %rbp
  802725:	48 89 e5             	mov    %rsp,%rbp
  802728:	48 ba be 53 80 00 00 	movabs $0x8053be,%rdx
  80272f:	00 00 00 
  802732:	be d2 00 00 00       	mov    $0xd2,%esi
  802737:	48 bf f1 52 80 00 00 	movabs $0x8052f1,%rdi
  80273e:	00 00 00 
  802741:	b8 00 00 00 00       	mov    $0x0,%eax
  802746:	48 b9 40 06 80 00 00 	movabs $0x800640,%rcx
  80274d:	00 00 00 
  802750:	ff d1                	callq  *%rcx

0000000000802752 <ipc_recv>:
  802752:	55                   	push   %rbp
  802753:	48 89 e5             	mov    %rsp,%rbp
  802756:	48 83 ec 30          	sub    $0x30,%rsp
  80275a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80275e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802762:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802766:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80276b:	75 0e                	jne    80277b <ipc_recv+0x29>
  80276d:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802774:	00 00 00 
  802777:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80277b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80277f:	48 89 c7             	mov    %rax,%rdi
  802782:	48 b8 86 1f 80 00 00 	movabs $0x801f86,%rax
  802789:	00 00 00 
  80278c:	ff d0                	callq  *%rax
  80278e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802791:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802795:	79 27                	jns    8027be <ipc_recv+0x6c>
  802797:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  80279c:	74 0a                	je     8027a8 <ipc_recv+0x56>
  80279e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027a2:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8027a8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8027ad:	74 0a                	je     8027b9 <ipc_recv+0x67>
  8027af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027b3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8027b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027bc:	eb 53                	jmp    802811 <ipc_recv+0xbf>
  8027be:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  8027c3:	74 19                	je     8027de <ipc_recv+0x8c>
  8027c5:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  8027cc:	00 00 00 
  8027cf:	48 8b 00             	mov    (%rax),%rax
  8027d2:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  8027d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027dc:	89 10                	mov    %edx,(%rax)
  8027de:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8027e3:	74 19                	je     8027fe <ipc_recv+0xac>
  8027e5:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  8027ec:	00 00 00 
  8027ef:	48 8b 00             	mov    (%rax),%rax
  8027f2:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  8027f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8027fc:	89 10                	mov    %edx,(%rax)
  8027fe:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  802805:	00 00 00 
  802808:	48 8b 00             	mov    (%rax),%rax
  80280b:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  802811:	c9                   	leaveq 
  802812:	c3                   	retq   

0000000000802813 <ipc_send>:
  802813:	55                   	push   %rbp
  802814:	48 89 e5             	mov    %rsp,%rbp
  802817:	48 83 ec 30          	sub    $0x30,%rsp
  80281b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80281e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802821:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802825:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  802828:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  80282d:	75 10                	jne    80283f <ipc_send+0x2c>
  80282f:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  802836:	00 00 00 
  802839:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80283d:	eb 0e                	jmp    80284d <ipc_send+0x3a>
  80283f:	eb 0c                	jmp    80284d <ipc_send+0x3a>
  802841:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  802848:	00 00 00 
  80284b:	ff d0                	callq  *%rax
  80284d:	8b 75 e8             	mov    -0x18(%rbp),%esi
  802850:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  802853:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802857:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80285a:	89 c7                	mov    %eax,%edi
  80285c:	48 b8 31 1f 80 00 00 	movabs $0x801f31,%rax
  802863:	00 00 00 
  802866:	ff d0                	callq  *%rax
  802868:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80286b:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  80286f:	74 d0                	je     802841 <ipc_send+0x2e>
  802871:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802875:	79 30                	jns    8028a7 <ipc_send+0x94>
  802877:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80287a:	89 c1                	mov    %eax,%ecx
  80287c:	48 ba d8 53 80 00 00 	movabs $0x8053d8,%rdx
  802883:	00 00 00 
  802886:	be 44 00 00 00       	mov    $0x44,%esi
  80288b:	48 bf ee 53 80 00 00 	movabs $0x8053ee,%rdi
  802892:	00 00 00 
  802895:	b8 00 00 00 00       	mov    $0x0,%eax
  80289a:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  8028a1:	00 00 00 
  8028a4:	41 ff d0             	callq  *%r8
  8028a7:	c9                   	leaveq 
  8028a8:	c3                   	retq   

00000000008028a9 <ipc_host_recv>:
  8028a9:	55                   	push   %rbp
  8028aa:	48 89 e5             	mov    %rsp,%rbp
  8028ad:	48 83 ec 10          	sub    $0x10,%rsp
  8028b1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8028b5:	48 ba 00 54 80 00 00 	movabs $0x805400,%rdx
  8028bc:	00 00 00 
  8028bf:	be 4e 00 00 00       	mov    $0x4e,%esi
  8028c4:	48 bf ee 53 80 00 00 	movabs $0x8053ee,%rdi
  8028cb:	00 00 00 
  8028ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8028d3:	48 b9 40 06 80 00 00 	movabs $0x800640,%rcx
  8028da:	00 00 00 
  8028dd:	ff d1                	callq  *%rcx

00000000008028df <ipc_host_send>:
  8028df:	55                   	push   %rbp
  8028e0:	48 89 e5             	mov    %rsp,%rbp
  8028e3:	48 83 ec 20          	sub    $0x20,%rsp
  8028e7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8028ea:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8028ed:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  8028f1:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8028f4:	48 ba 20 54 80 00 00 	movabs $0x805420,%rdx
  8028fb:	00 00 00 
  8028fe:	be 67 00 00 00       	mov    $0x67,%esi
  802903:	48 bf ee 53 80 00 00 	movabs $0x8053ee,%rdi
  80290a:	00 00 00 
  80290d:	b8 00 00 00 00       	mov    $0x0,%eax
  802912:	48 b9 40 06 80 00 00 	movabs $0x800640,%rcx
  802919:	00 00 00 
  80291c:	ff d1                	callq  *%rcx

000000000080291e <ipc_find_env>:
  80291e:	55                   	push   %rbp
  80291f:	48 89 e5             	mov    %rsp,%rbp
  802922:	48 83 ec 14          	sub    $0x14,%rsp
  802926:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802929:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802930:	eb 4e                	jmp    802980 <ipc_find_env+0x62>
  802932:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  802939:	00 00 00 
  80293c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80293f:	48 98                	cltq   
  802941:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  802948:	48 01 d0             	add    %rdx,%rax
  80294b:	48 05 d0 00 00 00    	add    $0xd0,%rax
  802951:	8b 00                	mov    (%rax),%eax
  802953:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802956:	75 24                	jne    80297c <ipc_find_env+0x5e>
  802958:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80295f:	00 00 00 
  802962:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802965:	48 98                	cltq   
  802967:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  80296e:	48 01 d0             	add    %rdx,%rax
  802971:	48 05 c0 00 00 00    	add    $0xc0,%rax
  802977:	8b 40 08             	mov    0x8(%rax),%eax
  80297a:	eb 12                	jmp    80298e <ipc_find_env+0x70>
  80297c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802980:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  802987:	7e a9                	jle    802932 <ipc_find_env+0x14>
  802989:	b8 00 00 00 00       	mov    $0x0,%eax
  80298e:	c9                   	leaveq 
  80298f:	c3                   	retq   

0000000000802990 <fd2num>:
  802990:	55                   	push   %rbp
  802991:	48 89 e5             	mov    %rsp,%rbp
  802994:	48 83 ec 08          	sub    $0x8,%rsp
  802998:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80299c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8029a0:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  8029a7:	ff ff ff 
  8029aa:	48 01 d0             	add    %rdx,%rax
  8029ad:	48 c1 e8 0c          	shr    $0xc,%rax
  8029b1:	c9                   	leaveq 
  8029b2:	c3                   	retq   

00000000008029b3 <fd2data>:
  8029b3:	55                   	push   %rbp
  8029b4:	48 89 e5             	mov    %rsp,%rbp
  8029b7:	48 83 ec 08          	sub    $0x8,%rsp
  8029bb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8029bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8029c3:	48 89 c7             	mov    %rax,%rdi
  8029c6:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  8029cd:	00 00 00 
  8029d0:	ff d0                	callq  *%rax
  8029d2:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  8029d8:	48 c1 e0 0c          	shl    $0xc,%rax
  8029dc:	c9                   	leaveq 
  8029dd:	c3                   	retq   

00000000008029de <fd_alloc>:
  8029de:	55                   	push   %rbp
  8029df:	48 89 e5             	mov    %rsp,%rbp
  8029e2:	48 83 ec 18          	sub    $0x18,%rsp
  8029e6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8029ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8029f1:	eb 6b                	jmp    802a5e <fd_alloc+0x80>
  8029f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029f6:	48 98                	cltq   
  8029f8:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  8029fe:	48 c1 e0 0c          	shl    $0xc,%rax
  802a02:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802a06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a0a:	48 c1 e8 15          	shr    $0x15,%rax
  802a0e:	48 89 c2             	mov    %rax,%rdx
  802a11:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802a18:	01 00 00 
  802a1b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a1f:	83 e0 01             	and    $0x1,%eax
  802a22:	48 85 c0             	test   %rax,%rax
  802a25:	74 21                	je     802a48 <fd_alloc+0x6a>
  802a27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802a2b:	48 c1 e8 0c          	shr    $0xc,%rax
  802a2f:	48 89 c2             	mov    %rax,%rdx
  802a32:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802a39:	01 00 00 
  802a3c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802a40:	83 e0 01             	and    $0x1,%eax
  802a43:	48 85 c0             	test   %rax,%rax
  802a46:	75 12                	jne    802a5a <fd_alloc+0x7c>
  802a48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a4c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a50:	48 89 10             	mov    %rdx,(%rax)
  802a53:	b8 00 00 00 00       	mov    $0x0,%eax
  802a58:	eb 1a                	jmp    802a74 <fd_alloc+0x96>
  802a5a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802a5e:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802a62:	7e 8f                	jle    8029f3 <fd_alloc+0x15>
  802a64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802a68:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802a6f:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  802a74:	c9                   	leaveq 
  802a75:	c3                   	retq   

0000000000802a76 <fd_lookup>:
  802a76:	55                   	push   %rbp
  802a77:	48 89 e5             	mov    %rsp,%rbp
  802a7a:	48 83 ec 20          	sub    $0x20,%rsp
  802a7e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802a81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802a85:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802a89:	78 06                	js     802a91 <fd_lookup+0x1b>
  802a8b:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  802a8f:	7e 07                	jle    802a98 <fd_lookup+0x22>
  802a91:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802a96:	eb 6c                	jmp    802b04 <fd_lookup+0x8e>
  802a98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802a9b:	48 98                	cltq   
  802a9d:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802aa3:	48 c1 e0 0c          	shl    $0xc,%rax
  802aa7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802aaf:	48 c1 e8 15          	shr    $0x15,%rax
  802ab3:	48 89 c2             	mov    %rax,%rdx
  802ab6:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802abd:	01 00 00 
  802ac0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802ac4:	83 e0 01             	and    $0x1,%eax
  802ac7:	48 85 c0             	test   %rax,%rax
  802aca:	74 21                	je     802aed <fd_lookup+0x77>
  802acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ad0:	48 c1 e8 0c          	shr    $0xc,%rax
  802ad4:	48 89 c2             	mov    %rax,%rdx
  802ad7:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ade:	01 00 00 
  802ae1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802ae5:	83 e0 01             	and    $0x1,%eax
  802ae8:	48 85 c0             	test   %rax,%rax
  802aeb:	75 07                	jne    802af4 <fd_lookup+0x7e>
  802aed:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802af2:	eb 10                	jmp    802b04 <fd_lookup+0x8e>
  802af4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802af8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  802afc:	48 89 10             	mov    %rdx,(%rax)
  802aff:	b8 00 00 00 00       	mov    $0x0,%eax
  802b04:	c9                   	leaveq 
  802b05:	c3                   	retq   

0000000000802b06 <fd_close>:
  802b06:	55                   	push   %rbp
  802b07:	48 89 e5             	mov    %rsp,%rbp
  802b0a:	48 83 ec 30          	sub    $0x30,%rsp
  802b0e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802b12:	89 f0                	mov    %esi,%eax
  802b14:	88 45 d4             	mov    %al,-0x2c(%rbp)
  802b17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b1b:	48 89 c7             	mov    %rax,%rdi
  802b1e:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  802b25:	00 00 00 
  802b28:	ff d0                	callq  *%rax
  802b2a:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802b2e:	48 89 d6             	mov    %rdx,%rsi
  802b31:	89 c7                	mov    %eax,%edi
  802b33:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  802b3a:	00 00 00 
  802b3d:	ff d0                	callq  *%rax
  802b3f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b42:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b46:	78 0a                	js     802b52 <fd_close+0x4c>
  802b48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802b4c:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  802b50:	74 12                	je     802b64 <fd_close+0x5e>
  802b52:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  802b56:	74 05                	je     802b5d <fd_close+0x57>
  802b58:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b5b:	eb 05                	jmp    802b62 <fd_close+0x5c>
  802b5d:	b8 00 00 00 00       	mov    $0x0,%eax
  802b62:	eb 69                	jmp    802bcd <fd_close+0xc7>
  802b64:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802b68:	8b 00                	mov    (%rax),%eax
  802b6a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802b6e:	48 89 d6             	mov    %rdx,%rsi
  802b71:	89 c7                	mov    %eax,%edi
  802b73:	48 b8 cf 2b 80 00 00 	movabs $0x802bcf,%rax
  802b7a:	00 00 00 
  802b7d:	ff d0                	callq  *%rax
  802b7f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b82:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b86:	78 2a                	js     802bb2 <fd_close+0xac>
  802b88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b8c:	48 8b 40 20          	mov    0x20(%rax),%rax
  802b90:	48 85 c0             	test   %rax,%rax
  802b93:	74 16                	je     802bab <fd_close+0xa5>
  802b95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b99:	48 8b 40 20          	mov    0x20(%rax),%rax
  802b9d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802ba1:	48 89 d7             	mov    %rdx,%rdi
  802ba4:	ff d0                	callq  *%rax
  802ba6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ba9:	eb 07                	jmp    802bb2 <fd_close+0xac>
  802bab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802bb2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802bb6:	48 89 c6             	mov    %rax,%rsi
  802bb9:	bf 00 00 00 00       	mov    $0x0,%edi
  802bbe:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  802bc5:	00 00 00 
  802bc8:	ff d0                	callq  *%rax
  802bca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802bcd:	c9                   	leaveq 
  802bce:	c3                   	retq   

0000000000802bcf <dev_lookup>:
  802bcf:	55                   	push   %rbp
  802bd0:	48 89 e5             	mov    %rsp,%rbp
  802bd3:	48 83 ec 20          	sub    $0x20,%rsp
  802bd7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802bda:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802bde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802be5:	eb 41                	jmp    802c28 <dev_lookup+0x59>
  802be7:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802bee:	00 00 00 
  802bf1:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802bf4:	48 63 d2             	movslq %edx,%rdx
  802bf7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802bfb:	8b 00                	mov    (%rax),%eax
  802bfd:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  802c00:	75 22                	jne    802c24 <dev_lookup+0x55>
  802c02:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802c09:	00 00 00 
  802c0c:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802c0f:	48 63 d2             	movslq %edx,%rdx
  802c12:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  802c16:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c1a:	48 89 10             	mov    %rdx,(%rax)
  802c1d:	b8 00 00 00 00       	mov    $0x0,%eax
  802c22:	eb 60                	jmp    802c84 <dev_lookup+0xb5>
  802c24:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802c28:	48 b8 20 70 80 00 00 	movabs $0x807020,%rax
  802c2f:	00 00 00 
  802c32:	8b 55 fc             	mov    -0x4(%rbp),%edx
  802c35:	48 63 d2             	movslq %edx,%rdx
  802c38:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802c3c:	48 85 c0             	test   %rax,%rax
  802c3f:	75 a6                	jne    802be7 <dev_lookup+0x18>
  802c41:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  802c48:	00 00 00 
  802c4b:	48 8b 00             	mov    (%rax),%rax
  802c4e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802c54:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802c57:	89 c6                	mov    %eax,%esi
  802c59:	48 bf 40 54 80 00 00 	movabs $0x805440,%rdi
  802c60:	00 00 00 
  802c63:	b8 00 00 00 00       	mov    $0x0,%eax
  802c68:	48 b9 79 08 80 00 00 	movabs $0x800879,%rcx
  802c6f:	00 00 00 
  802c72:	ff d1                	callq  *%rcx
  802c74:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802c78:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  802c7f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802c84:	c9                   	leaveq 
  802c85:	c3                   	retq   

0000000000802c86 <close>:
  802c86:	55                   	push   %rbp
  802c87:	48 89 e5             	mov    %rsp,%rbp
  802c8a:	48 83 ec 20          	sub    $0x20,%rsp
  802c8e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802c91:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802c95:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802c98:	48 89 d6             	mov    %rdx,%rsi
  802c9b:	89 c7                	mov    %eax,%edi
  802c9d:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  802ca4:	00 00 00 
  802ca7:	ff d0                	callq  *%rax
  802ca9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cb0:	79 05                	jns    802cb7 <close+0x31>
  802cb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cb5:	eb 18                	jmp    802ccf <close+0x49>
  802cb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802cbb:	be 01 00 00 00       	mov    $0x1,%esi
  802cc0:	48 89 c7             	mov    %rax,%rdi
  802cc3:	48 b8 06 2b 80 00 00 	movabs $0x802b06,%rax
  802cca:	00 00 00 
  802ccd:	ff d0                	callq  *%rax
  802ccf:	c9                   	leaveq 
  802cd0:	c3                   	retq   

0000000000802cd1 <close_all>:
  802cd1:	55                   	push   %rbp
  802cd2:	48 89 e5             	mov    %rsp,%rbp
  802cd5:	48 83 ec 10          	sub    $0x10,%rsp
  802cd9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802ce0:	eb 15                	jmp    802cf7 <close_all+0x26>
  802ce2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ce5:	89 c7                	mov    %eax,%edi
  802ce7:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  802cee:	00 00 00 
  802cf1:	ff d0                	callq  *%rax
  802cf3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802cf7:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  802cfb:	7e e5                	jle    802ce2 <close_all+0x11>
  802cfd:	c9                   	leaveq 
  802cfe:	c3                   	retq   

0000000000802cff <dup>:
  802cff:	55                   	push   %rbp
  802d00:	48 89 e5             	mov    %rsp,%rbp
  802d03:	48 83 ec 40          	sub    $0x40,%rsp
  802d07:	89 7d cc             	mov    %edi,-0x34(%rbp)
  802d0a:	89 75 c8             	mov    %esi,-0x38(%rbp)
  802d0d:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802d11:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802d14:	48 89 d6             	mov    %rdx,%rsi
  802d17:	89 c7                	mov    %eax,%edi
  802d19:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  802d20:	00 00 00 
  802d23:	ff d0                	callq  *%rax
  802d25:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d28:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d2c:	79 08                	jns    802d36 <dup+0x37>
  802d2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d31:	e9 70 01 00 00       	jmpq   802ea6 <dup+0x1a7>
  802d36:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802d39:	89 c7                	mov    %eax,%edi
  802d3b:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  802d42:	00 00 00 
  802d45:	ff d0                	callq  *%rax
  802d47:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802d4a:	48 98                	cltq   
  802d4c:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802d52:	48 c1 e0 0c          	shl    $0xc,%rax
  802d56:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  802d5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802d5e:	48 89 c7             	mov    %rax,%rdi
  802d61:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  802d68:	00 00 00 
  802d6b:	ff d0                	callq  *%rax
  802d6d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802d71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d75:	48 89 c7             	mov    %rax,%rdi
  802d78:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  802d7f:	00 00 00 
  802d82:	ff d0                	callq  *%rax
  802d84:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802d88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802d8c:	48 c1 e8 15          	shr    $0x15,%rax
  802d90:	48 89 c2             	mov    %rax,%rdx
  802d93:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  802d9a:	01 00 00 
  802d9d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802da1:	83 e0 01             	and    $0x1,%eax
  802da4:	48 85 c0             	test   %rax,%rax
  802da7:	74 73                	je     802e1c <dup+0x11d>
  802da9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dad:	48 c1 e8 0c          	shr    $0xc,%rax
  802db1:	48 89 c2             	mov    %rax,%rdx
  802db4:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802dbb:	01 00 00 
  802dbe:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802dc2:	83 e0 01             	and    $0x1,%eax
  802dc5:	48 85 c0             	test   %rax,%rax
  802dc8:	74 52                	je     802e1c <dup+0x11d>
  802dca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dce:	48 c1 e8 0c          	shr    $0xc,%rax
  802dd2:	48 89 c2             	mov    %rax,%rdx
  802dd5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802ddc:	01 00 00 
  802ddf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802de3:	25 07 0e 00 00       	and    $0xe07,%eax
  802de8:	89 c1                	mov    %eax,%ecx
  802dea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802dee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802df2:	41 89 c8             	mov    %ecx,%r8d
  802df5:	48 89 d1             	mov    %rdx,%rcx
  802df8:	ba 00 00 00 00       	mov    $0x0,%edx
  802dfd:	48 89 c6             	mov    %rax,%rsi
  802e00:	bf 00 00 00 00       	mov    $0x0,%edi
  802e05:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  802e0c:	00 00 00 
  802e0f:	ff d0                	callq  *%rax
  802e11:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e14:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e18:	79 02                	jns    802e1c <dup+0x11d>
  802e1a:	eb 57                	jmp    802e73 <dup+0x174>
  802e1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e20:	48 c1 e8 0c          	shr    $0xc,%rax
  802e24:	48 89 c2             	mov    %rax,%rdx
  802e27:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  802e2e:	01 00 00 
  802e31:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802e35:	25 07 0e 00 00       	and    $0xe07,%eax
  802e3a:	89 c1                	mov    %eax,%ecx
  802e3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e40:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802e44:	41 89 c8             	mov    %ecx,%r8d
  802e47:	48 89 d1             	mov    %rdx,%rcx
  802e4a:	ba 00 00 00 00       	mov    $0x0,%edx
  802e4f:	48 89 c6             	mov    %rax,%rsi
  802e52:	bf 00 00 00 00       	mov    $0x0,%edi
  802e57:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  802e5e:	00 00 00 
  802e61:	ff d0                	callq  *%rax
  802e63:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e66:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e6a:	79 02                	jns    802e6e <dup+0x16f>
  802e6c:	eb 05                	jmp    802e73 <dup+0x174>
  802e6e:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802e71:	eb 33                	jmp    802ea6 <dup+0x1a7>
  802e73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802e77:	48 89 c6             	mov    %rax,%rsi
  802e7a:	bf 00 00 00 00       	mov    $0x0,%edi
  802e7f:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  802e86:	00 00 00 
  802e89:	ff d0                	callq  *%rax
  802e8b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802e8f:	48 89 c6             	mov    %rax,%rsi
  802e92:	bf 00 00 00 00       	mov    $0x0,%edi
  802e97:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  802e9e:	00 00 00 
  802ea1:	ff d0                	callq  *%rax
  802ea3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ea6:	c9                   	leaveq 
  802ea7:	c3                   	retq   

0000000000802ea8 <read>:
  802ea8:	55                   	push   %rbp
  802ea9:	48 89 e5             	mov    %rsp,%rbp
  802eac:	48 83 ec 40          	sub    $0x40,%rsp
  802eb0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802eb3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802eb7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802ebb:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  802ebf:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802ec2:	48 89 d6             	mov    %rdx,%rsi
  802ec5:	89 c7                	mov    %eax,%edi
  802ec7:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  802ece:	00 00 00 
  802ed1:	ff d0                	callq  *%rax
  802ed3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ed6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802eda:	78 24                	js     802f00 <read+0x58>
  802edc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802ee0:	8b 00                	mov    (%rax),%eax
  802ee2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802ee6:	48 89 d6             	mov    %rdx,%rsi
  802ee9:	89 c7                	mov    %eax,%edi
  802eeb:	48 b8 cf 2b 80 00 00 	movabs $0x802bcf,%rax
  802ef2:	00 00 00 
  802ef5:	ff d0                	callq  *%rax
  802ef7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802efa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802efe:	79 05                	jns    802f05 <read+0x5d>
  802f00:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f03:	eb 76                	jmp    802f7b <read+0xd3>
  802f05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802f09:	8b 40 08             	mov    0x8(%rax),%eax
  802f0c:	83 e0 03             	and    $0x3,%eax
  802f0f:	83 f8 01             	cmp    $0x1,%eax
  802f12:	75 3a                	jne    802f4e <read+0xa6>
  802f14:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  802f1b:	00 00 00 
  802f1e:	48 8b 00             	mov    (%rax),%rax
  802f21:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802f27:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802f2a:	89 c6                	mov    %eax,%esi
  802f2c:	48 bf 5f 54 80 00 00 	movabs $0x80545f,%rdi
  802f33:	00 00 00 
  802f36:	b8 00 00 00 00       	mov    $0x0,%eax
  802f3b:	48 b9 79 08 80 00 00 	movabs $0x800879,%rcx
  802f42:	00 00 00 
  802f45:	ff d1                	callq  *%rcx
  802f47:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  802f4c:	eb 2d                	jmp    802f7b <read+0xd3>
  802f4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f52:	48 8b 40 10          	mov    0x10(%rax),%rax
  802f56:	48 85 c0             	test   %rax,%rax
  802f59:	75 07                	jne    802f62 <read+0xba>
  802f5b:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802f60:	eb 19                	jmp    802f7b <read+0xd3>
  802f62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802f66:	48 8b 40 10          	mov    0x10(%rax),%rax
  802f6a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802f6e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802f72:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802f76:	48 89 cf             	mov    %rcx,%rdi
  802f79:	ff d0                	callq  *%rax
  802f7b:	c9                   	leaveq 
  802f7c:	c3                   	retq   

0000000000802f7d <readn>:
  802f7d:	55                   	push   %rbp
  802f7e:	48 89 e5             	mov    %rsp,%rbp
  802f81:	48 83 ec 30          	sub    $0x30,%rsp
  802f85:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f88:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f8c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802f90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  802f97:	eb 49                	jmp    802fe2 <readn+0x65>
  802f99:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f9c:	48 98                	cltq   
  802f9e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802fa2:	48 29 c2             	sub    %rax,%rdx
  802fa5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fa8:	48 63 c8             	movslq %eax,%rcx
  802fab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802faf:	48 01 c1             	add    %rax,%rcx
  802fb2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802fb5:	48 89 ce             	mov    %rcx,%rsi
  802fb8:	89 c7                	mov    %eax,%edi
  802fba:	48 b8 a8 2e 80 00 00 	movabs $0x802ea8,%rax
  802fc1:	00 00 00 
  802fc4:	ff d0                	callq  *%rax
  802fc6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802fc9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802fcd:	79 05                	jns    802fd4 <readn+0x57>
  802fcf:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802fd2:	eb 1c                	jmp    802ff0 <readn+0x73>
  802fd4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802fd8:	75 02                	jne    802fdc <readn+0x5f>
  802fda:	eb 11                	jmp    802fed <readn+0x70>
  802fdc:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802fdf:	01 45 fc             	add    %eax,-0x4(%rbp)
  802fe2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802fe5:	48 98                	cltq   
  802fe7:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802feb:	72 ac                	jb     802f99 <readn+0x1c>
  802fed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ff0:	c9                   	leaveq 
  802ff1:	c3                   	retq   

0000000000802ff2 <write>:
  802ff2:	55                   	push   %rbp
  802ff3:	48 89 e5             	mov    %rsp,%rbp
  802ff6:	48 83 ec 40          	sub    $0x40,%rsp
  802ffa:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802ffd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803001:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803005:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  803009:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80300c:	48 89 d6             	mov    %rdx,%rsi
  80300f:	89 c7                	mov    %eax,%edi
  803011:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  803018:	00 00 00 
  80301b:	ff d0                	callq  *%rax
  80301d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803020:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803024:	78 24                	js     80304a <write+0x58>
  803026:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80302a:	8b 00                	mov    (%rax),%eax
  80302c:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803030:	48 89 d6             	mov    %rdx,%rsi
  803033:	89 c7                	mov    %eax,%edi
  803035:	48 b8 cf 2b 80 00 00 	movabs $0x802bcf,%rax
  80303c:	00 00 00 
  80303f:	ff d0                	callq  *%rax
  803041:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803044:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803048:	79 05                	jns    80304f <write+0x5d>
  80304a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80304d:	eb 75                	jmp    8030c4 <write+0xd2>
  80304f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803053:	8b 40 08             	mov    0x8(%rax),%eax
  803056:	83 e0 03             	and    $0x3,%eax
  803059:	85 c0                	test   %eax,%eax
  80305b:	75 3a                	jne    803097 <write+0xa5>
  80305d:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  803064:	00 00 00 
  803067:	48 8b 00             	mov    (%rax),%rax
  80306a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803070:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803073:	89 c6                	mov    %eax,%esi
  803075:	48 bf 7b 54 80 00 00 	movabs $0x80547b,%rdi
  80307c:	00 00 00 
  80307f:	b8 00 00 00 00       	mov    $0x0,%eax
  803084:	48 b9 79 08 80 00 00 	movabs $0x800879,%rcx
  80308b:	00 00 00 
  80308e:	ff d1                	callq  *%rcx
  803090:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  803095:	eb 2d                	jmp    8030c4 <write+0xd2>
  803097:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80309b:	48 8b 40 18          	mov    0x18(%rax),%rax
  80309f:	48 85 c0             	test   %rax,%rax
  8030a2:	75 07                	jne    8030ab <write+0xb9>
  8030a4:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8030a9:	eb 19                	jmp    8030c4 <write+0xd2>
  8030ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8030af:	48 8b 40 18          	mov    0x18(%rax),%rax
  8030b3:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8030b7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8030bb:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8030bf:	48 89 cf             	mov    %rcx,%rdi
  8030c2:	ff d0                	callq  *%rax
  8030c4:	c9                   	leaveq 
  8030c5:	c3                   	retq   

00000000008030c6 <seek>:
  8030c6:	55                   	push   %rbp
  8030c7:	48 89 e5             	mov    %rsp,%rbp
  8030ca:	48 83 ec 18          	sub    $0x18,%rsp
  8030ce:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8030d1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8030d4:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8030d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8030db:	48 89 d6             	mov    %rdx,%rsi
  8030de:	89 c7                	mov    %eax,%edi
  8030e0:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  8030e7:	00 00 00 
  8030ea:	ff d0                	callq  *%rax
  8030ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8030ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8030f3:	79 05                	jns    8030fa <seek+0x34>
  8030f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8030f8:	eb 0f                	jmp    803109 <seek+0x43>
  8030fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8030fe:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803101:	89 50 04             	mov    %edx,0x4(%rax)
  803104:	b8 00 00 00 00       	mov    $0x0,%eax
  803109:	c9                   	leaveq 
  80310a:	c3                   	retq   

000000000080310b <ftruncate>:
  80310b:	55                   	push   %rbp
  80310c:	48 89 e5             	mov    %rsp,%rbp
  80310f:	48 83 ec 30          	sub    $0x30,%rsp
  803113:	89 7d dc             	mov    %edi,-0x24(%rbp)
  803116:	89 75 d8             	mov    %esi,-0x28(%rbp)
  803119:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80311d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  803120:	48 89 d6             	mov    %rdx,%rsi
  803123:	89 c7                	mov    %eax,%edi
  803125:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  80312c:	00 00 00 
  80312f:	ff d0                	callq  *%rax
  803131:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803134:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803138:	78 24                	js     80315e <ftruncate+0x53>
  80313a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80313e:	8b 00                	mov    (%rax),%eax
  803140:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803144:	48 89 d6             	mov    %rdx,%rsi
  803147:	89 c7                	mov    %eax,%edi
  803149:	48 b8 cf 2b 80 00 00 	movabs $0x802bcf,%rax
  803150:	00 00 00 
  803153:	ff d0                	callq  *%rax
  803155:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803158:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80315c:	79 05                	jns    803163 <ftruncate+0x58>
  80315e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803161:	eb 72                	jmp    8031d5 <ftruncate+0xca>
  803163:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803167:	8b 40 08             	mov    0x8(%rax),%eax
  80316a:	83 e0 03             	and    $0x3,%eax
  80316d:	85 c0                	test   %eax,%eax
  80316f:	75 3a                	jne    8031ab <ftruncate+0xa0>
  803171:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  803178:	00 00 00 
  80317b:	48 8b 00             	mov    (%rax),%rax
  80317e:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803184:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803187:	89 c6                	mov    %eax,%esi
  803189:	48 bf 98 54 80 00 00 	movabs $0x805498,%rdi
  803190:	00 00 00 
  803193:	b8 00 00 00 00       	mov    $0x0,%eax
  803198:	48 b9 79 08 80 00 00 	movabs $0x800879,%rcx
  80319f:	00 00 00 
  8031a2:	ff d1                	callq  *%rcx
  8031a4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8031a9:	eb 2a                	jmp    8031d5 <ftruncate+0xca>
  8031ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031af:	48 8b 40 30          	mov    0x30(%rax),%rax
  8031b3:	48 85 c0             	test   %rax,%rax
  8031b6:	75 07                	jne    8031bf <ftruncate+0xb4>
  8031b8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8031bd:	eb 16                	jmp    8031d5 <ftruncate+0xca>
  8031bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031c3:	48 8b 40 30          	mov    0x30(%rax),%rax
  8031c7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8031cb:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8031ce:	89 ce                	mov    %ecx,%esi
  8031d0:	48 89 d7             	mov    %rdx,%rdi
  8031d3:	ff d0                	callq  *%rax
  8031d5:	c9                   	leaveq 
  8031d6:	c3                   	retq   

00000000008031d7 <fstat>:
  8031d7:	55                   	push   %rbp
  8031d8:	48 89 e5             	mov    %rsp,%rbp
  8031db:	48 83 ec 30          	sub    $0x30,%rsp
  8031df:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8031e2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8031e6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8031ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8031ed:	48 89 d6             	mov    %rdx,%rsi
  8031f0:	89 c7                	mov    %eax,%edi
  8031f2:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  8031f9:	00 00 00 
  8031fc:	ff d0                	callq  *%rax
  8031fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803201:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803205:	78 24                	js     80322b <fstat+0x54>
  803207:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80320b:	8b 00                	mov    (%rax),%eax
  80320d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803211:	48 89 d6             	mov    %rdx,%rsi
  803214:	89 c7                	mov    %eax,%edi
  803216:	48 b8 cf 2b 80 00 00 	movabs $0x802bcf,%rax
  80321d:	00 00 00 
  803220:	ff d0                	callq  *%rax
  803222:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803225:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803229:	79 05                	jns    803230 <fstat+0x59>
  80322b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80322e:	eb 5e                	jmp    80328e <fstat+0xb7>
  803230:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803234:	48 8b 40 28          	mov    0x28(%rax),%rax
  803238:	48 85 c0             	test   %rax,%rax
  80323b:	75 07                	jne    803244 <fstat+0x6d>
  80323d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803242:	eb 4a                	jmp    80328e <fstat+0xb7>
  803244:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803248:	c6 00 00             	movb   $0x0,(%rax)
  80324b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80324f:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  803256:	00 00 00 
  803259:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80325d:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803264:	00 00 00 
  803267:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80326b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80326f:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  803276:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80327a:	48 8b 40 28          	mov    0x28(%rax),%rax
  80327e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  803282:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  803286:	48 89 ce             	mov    %rcx,%rsi
  803289:	48 89 d7             	mov    %rdx,%rdi
  80328c:	ff d0                	callq  *%rax
  80328e:	c9                   	leaveq 
  80328f:	c3                   	retq   

0000000000803290 <stat>:
  803290:	55                   	push   %rbp
  803291:	48 89 e5             	mov    %rsp,%rbp
  803294:	48 83 ec 20          	sub    $0x20,%rsp
  803298:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80329c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8032a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8032a4:	be 00 00 00 00       	mov    $0x0,%esi
  8032a9:	48 89 c7             	mov    %rax,%rdi
  8032ac:	48 b8 7e 33 80 00 00 	movabs $0x80337e,%rax
  8032b3:	00 00 00 
  8032b6:	ff d0                	callq  *%rax
  8032b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8032bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8032bf:	79 05                	jns    8032c6 <stat+0x36>
  8032c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032c4:	eb 2f                	jmp    8032f5 <stat+0x65>
  8032c6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8032ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032cd:	48 89 d6             	mov    %rdx,%rsi
  8032d0:	89 c7                	mov    %eax,%edi
  8032d2:	48 b8 d7 31 80 00 00 	movabs $0x8031d7,%rax
  8032d9:	00 00 00 
  8032dc:	ff d0                	callq  *%rax
  8032de:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8032e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8032e4:	89 c7                	mov    %eax,%edi
  8032e6:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  8032ed:	00 00 00 
  8032f0:	ff d0                	callq  *%rax
  8032f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8032f5:	c9                   	leaveq 
  8032f6:	c3                   	retq   

00000000008032f7 <fsipc>:
  8032f7:	55                   	push   %rbp
  8032f8:	48 89 e5             	mov    %rsp,%rbp
  8032fb:	48 83 ec 10          	sub    $0x10,%rsp
  8032ff:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803302:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803306:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  80330d:	00 00 00 
  803310:	8b 00                	mov    (%rax),%eax
  803312:	85 c0                	test   %eax,%eax
  803314:	75 1d                	jne    803333 <fsipc+0x3c>
  803316:	bf 01 00 00 00       	mov    $0x1,%edi
  80331b:	48 b8 1e 29 80 00 00 	movabs $0x80291e,%rax
  803322:	00 00 00 
  803325:	ff d0                	callq  *%rax
  803327:	48 ba 04 80 80 00 00 	movabs $0x808004,%rdx
  80332e:	00 00 00 
  803331:	89 02                	mov    %eax,(%rdx)
  803333:	48 b8 04 80 80 00 00 	movabs $0x808004,%rax
  80333a:	00 00 00 
  80333d:	8b 00                	mov    (%rax),%eax
  80333f:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803342:	b9 07 00 00 00       	mov    $0x7,%ecx
  803347:	48 ba 00 90 80 00 00 	movabs $0x809000,%rdx
  80334e:	00 00 00 
  803351:	89 c7                	mov    %eax,%edi
  803353:	48 b8 13 28 80 00 00 	movabs $0x802813,%rax
  80335a:	00 00 00 
  80335d:	ff d0                	callq  *%rax
  80335f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803363:	ba 00 00 00 00       	mov    $0x0,%edx
  803368:	48 89 c6             	mov    %rax,%rsi
  80336b:	bf 00 00 00 00       	mov    $0x0,%edi
  803370:	48 b8 52 27 80 00 00 	movabs $0x802752,%rax
  803377:	00 00 00 
  80337a:	ff d0                	callq  *%rax
  80337c:	c9                   	leaveq 
  80337d:	c3                   	retq   

000000000080337e <open>:
  80337e:	55                   	push   %rbp
  80337f:	48 89 e5             	mov    %rsp,%rbp
  803382:	48 83 ec 20          	sub    $0x20,%rsp
  803386:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80338a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80338d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803391:	48 89 c7             	mov    %rax,%rdi
  803394:	48 b8 c2 13 80 00 00 	movabs $0x8013c2,%rax
  80339b:	00 00 00 
  80339e:	ff d0                	callq  *%rax
  8033a0:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8033a5:	7e 0a                	jle    8033b1 <open+0x33>
  8033a7:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8033ac:	e9 a5 00 00 00       	jmpq   803456 <open+0xd8>
  8033b1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8033b5:	48 89 c7             	mov    %rax,%rdi
  8033b8:	48 b8 de 29 80 00 00 	movabs $0x8029de,%rax
  8033bf:	00 00 00 
  8033c2:	ff d0                	callq  *%rax
  8033c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8033c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8033cb:	79 08                	jns    8033d5 <open+0x57>
  8033cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033d0:	e9 81 00 00 00       	jmpq   803456 <open+0xd8>
  8033d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8033d9:	48 89 c6             	mov    %rax,%rsi
  8033dc:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  8033e3:	00 00 00 
  8033e6:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  8033ed:	00 00 00 
  8033f0:	ff d0                	callq  *%rax
  8033f2:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8033f9:	00 00 00 
  8033fc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  8033ff:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  803405:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803409:	48 89 c6             	mov    %rax,%rsi
  80340c:	bf 01 00 00 00       	mov    $0x1,%edi
  803411:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  803418:	00 00 00 
  80341b:	ff d0                	callq  *%rax
  80341d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803420:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803424:	79 1d                	jns    803443 <open+0xc5>
  803426:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80342a:	be 00 00 00 00       	mov    $0x0,%esi
  80342f:	48 89 c7             	mov    %rax,%rdi
  803432:	48 b8 06 2b 80 00 00 	movabs $0x802b06,%rax
  803439:	00 00 00 
  80343c:	ff d0                	callq  *%rax
  80343e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803441:	eb 13                	jmp    803456 <open+0xd8>
  803443:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803447:	48 89 c7             	mov    %rax,%rdi
  80344a:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  803451:	00 00 00 
  803454:	ff d0                	callq  *%rax
  803456:	c9                   	leaveq 
  803457:	c3                   	retq   

0000000000803458 <devfile_flush>:
  803458:	55                   	push   %rbp
  803459:	48 89 e5             	mov    %rsp,%rbp
  80345c:	48 83 ec 10          	sub    $0x10,%rsp
  803460:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803464:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803468:	8b 50 0c             	mov    0xc(%rax),%edx
  80346b:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803472:	00 00 00 
  803475:	89 10                	mov    %edx,(%rax)
  803477:	be 00 00 00 00       	mov    $0x0,%esi
  80347c:	bf 06 00 00 00       	mov    $0x6,%edi
  803481:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  803488:	00 00 00 
  80348b:	ff d0                	callq  *%rax
  80348d:	c9                   	leaveq 
  80348e:	c3                   	retq   

000000000080348f <devfile_read>:
  80348f:	55                   	push   %rbp
  803490:	48 89 e5             	mov    %rsp,%rbp
  803493:	48 83 ec 30          	sub    $0x30,%rsp
  803497:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80349b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80349f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8034a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8034a7:	8b 50 0c             	mov    0xc(%rax),%edx
  8034aa:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034b1:	00 00 00 
  8034b4:	89 10                	mov    %edx,(%rax)
  8034b6:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8034bd:	00 00 00 
  8034c0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8034c4:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8034c8:	be 00 00 00 00       	mov    $0x0,%esi
  8034cd:	bf 03 00 00 00       	mov    $0x3,%edi
  8034d2:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  8034d9:	00 00 00 
  8034dc:	ff d0                	callq  *%rax
  8034de:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8034e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8034e5:	79 08                	jns    8034ef <devfile_read+0x60>
  8034e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034ea:	e9 a4 00 00 00       	jmpq   803593 <devfile_read+0x104>
  8034ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8034f2:	48 98                	cltq   
  8034f4:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8034f8:	76 35                	jbe    80352f <devfile_read+0xa0>
  8034fa:	48 b9 be 54 80 00 00 	movabs $0x8054be,%rcx
  803501:	00 00 00 
  803504:	48 ba c5 54 80 00 00 	movabs $0x8054c5,%rdx
  80350b:	00 00 00 
  80350e:	be 89 00 00 00       	mov    $0x89,%esi
  803513:	48 bf da 54 80 00 00 	movabs $0x8054da,%rdi
  80351a:	00 00 00 
  80351d:	b8 00 00 00 00       	mov    $0x0,%eax
  803522:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  803529:	00 00 00 
  80352c:	41 ff d0             	callq  *%r8
  80352f:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  803536:	7e 35                	jle    80356d <devfile_read+0xde>
  803538:	48 b9 e8 54 80 00 00 	movabs $0x8054e8,%rcx
  80353f:	00 00 00 
  803542:	48 ba c5 54 80 00 00 	movabs $0x8054c5,%rdx
  803549:	00 00 00 
  80354c:	be 8a 00 00 00       	mov    $0x8a,%esi
  803551:	48 bf da 54 80 00 00 	movabs $0x8054da,%rdi
  803558:	00 00 00 
  80355b:	b8 00 00 00 00       	mov    $0x0,%eax
  803560:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  803567:	00 00 00 
  80356a:	41 ff d0             	callq  *%r8
  80356d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803570:	48 63 d0             	movslq %eax,%rdx
  803573:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803577:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  80357e:	00 00 00 
  803581:	48 89 c7             	mov    %rax,%rdi
  803584:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  80358b:	00 00 00 
  80358e:	ff d0                	callq  *%rax
  803590:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803593:	c9                   	leaveq 
  803594:	c3                   	retq   

0000000000803595 <devfile_write>:
  803595:	55                   	push   %rbp
  803596:	48 89 e5             	mov    %rsp,%rbp
  803599:	48 83 ec 40          	sub    $0x40,%rsp
  80359d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8035a1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8035a5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8035a9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8035ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8035b1:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8035b8:	00 
  8035b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8035bd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8035c1:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8035c6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8035ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8035ce:	8b 50 0c             	mov    0xc(%rax),%edx
  8035d1:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8035d8:	00 00 00 
  8035db:	89 10                	mov    %edx,(%rax)
  8035dd:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8035e4:	00 00 00 
  8035e7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8035eb:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8035ef:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8035f3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8035f7:	48 89 c6             	mov    %rax,%rsi
  8035fa:	48 bf 10 90 80 00 00 	movabs $0x809010,%rdi
  803601:	00 00 00 
  803604:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  80360b:	00 00 00 
  80360e:	ff d0                	callq  *%rax
  803610:	be 00 00 00 00       	mov    $0x0,%esi
  803615:	bf 04 00 00 00       	mov    $0x4,%edi
  80361a:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  803621:	00 00 00 
  803624:	ff d0                	callq  *%rax
  803626:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803629:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80362d:	79 05                	jns    803634 <devfile_write+0x9f>
  80362f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803632:	eb 43                	jmp    803677 <devfile_write+0xe2>
  803634:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803637:	48 98                	cltq   
  803639:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80363d:	76 35                	jbe    803674 <devfile_write+0xdf>
  80363f:	48 b9 be 54 80 00 00 	movabs $0x8054be,%rcx
  803646:	00 00 00 
  803649:	48 ba c5 54 80 00 00 	movabs $0x8054c5,%rdx
  803650:	00 00 00 
  803653:	be a8 00 00 00       	mov    $0xa8,%esi
  803658:	48 bf da 54 80 00 00 	movabs $0x8054da,%rdi
  80365f:	00 00 00 
  803662:	b8 00 00 00 00       	mov    $0x0,%eax
  803667:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  80366e:	00 00 00 
  803671:	41 ff d0             	callq  *%r8
  803674:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803677:	c9                   	leaveq 
  803678:	c3                   	retq   

0000000000803679 <devfile_stat>:
  803679:	55                   	push   %rbp
  80367a:	48 89 e5             	mov    %rsp,%rbp
  80367d:	48 83 ec 20          	sub    $0x20,%rsp
  803681:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803685:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803689:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80368d:	8b 50 0c             	mov    0xc(%rax),%edx
  803690:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803697:	00 00 00 
  80369a:	89 10                	mov    %edx,(%rax)
  80369c:	be 00 00 00 00       	mov    $0x0,%esi
  8036a1:	bf 05 00 00 00       	mov    $0x5,%edi
  8036a6:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  8036ad:	00 00 00 
  8036b0:	ff d0                	callq  *%rax
  8036b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8036b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8036b9:	79 05                	jns    8036c0 <devfile_stat+0x47>
  8036bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8036be:	eb 56                	jmp    803716 <devfile_stat+0x9d>
  8036c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036c4:	48 be 00 90 80 00 00 	movabs $0x809000,%rsi
  8036cb:	00 00 00 
  8036ce:	48 89 c7             	mov    %rax,%rdi
  8036d1:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  8036d8:	00 00 00 
  8036db:	ff d0                	callq  *%rax
  8036dd:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8036e4:	00 00 00 
  8036e7:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8036ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8036f1:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  8036f7:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  8036fe:	00 00 00 
  803701:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  803707:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80370b:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  803711:	b8 00 00 00 00       	mov    $0x0,%eax
  803716:	c9                   	leaveq 
  803717:	c3                   	retq   

0000000000803718 <devfile_trunc>:
  803718:	55                   	push   %rbp
  803719:	48 89 e5             	mov    %rsp,%rbp
  80371c:	48 83 ec 10          	sub    $0x10,%rsp
  803720:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803724:	89 75 f4             	mov    %esi,-0xc(%rbp)
  803727:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80372b:	8b 50 0c             	mov    0xc(%rax),%edx
  80372e:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803735:	00 00 00 
  803738:	89 10                	mov    %edx,(%rax)
  80373a:	48 b8 00 90 80 00 00 	movabs $0x809000,%rax
  803741:	00 00 00 
  803744:	8b 55 f4             	mov    -0xc(%rbp),%edx
  803747:	89 50 04             	mov    %edx,0x4(%rax)
  80374a:	be 00 00 00 00       	mov    $0x0,%esi
  80374f:	bf 02 00 00 00       	mov    $0x2,%edi
  803754:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  80375b:	00 00 00 
  80375e:	ff d0                	callq  *%rax
  803760:	c9                   	leaveq 
  803761:	c3                   	retq   

0000000000803762 <remove>:
  803762:	55                   	push   %rbp
  803763:	48 89 e5             	mov    %rsp,%rbp
  803766:	48 83 ec 10          	sub    $0x10,%rsp
  80376a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80376e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803772:	48 89 c7             	mov    %rax,%rdi
  803775:	48 b8 c2 13 80 00 00 	movabs $0x8013c2,%rax
  80377c:	00 00 00 
  80377f:	ff d0                	callq  *%rax
  803781:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  803786:	7e 07                	jle    80378f <remove+0x2d>
  803788:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  80378d:	eb 33                	jmp    8037c2 <remove+0x60>
  80378f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803793:	48 89 c6             	mov    %rax,%rsi
  803796:	48 bf 00 90 80 00 00 	movabs $0x809000,%rdi
  80379d:	00 00 00 
  8037a0:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  8037a7:	00 00 00 
  8037aa:	ff d0                	callq  *%rax
  8037ac:	be 00 00 00 00       	mov    $0x0,%esi
  8037b1:	bf 07 00 00 00       	mov    $0x7,%edi
  8037b6:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  8037bd:	00 00 00 
  8037c0:	ff d0                	callq  *%rax
  8037c2:	c9                   	leaveq 
  8037c3:	c3                   	retq   

00000000008037c4 <sync>:
  8037c4:	55                   	push   %rbp
  8037c5:	48 89 e5             	mov    %rsp,%rbp
  8037c8:	be 00 00 00 00       	mov    $0x0,%esi
  8037cd:	bf 08 00 00 00       	mov    $0x8,%edi
  8037d2:	48 b8 f7 32 80 00 00 	movabs $0x8032f7,%rax
  8037d9:	00 00 00 
  8037dc:	ff d0                	callq  *%rax
  8037de:	5d                   	pop    %rbp
  8037df:	c3                   	retq   

00000000008037e0 <copy>:
  8037e0:	55                   	push   %rbp
  8037e1:	48 89 e5             	mov    %rsp,%rbp
  8037e4:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  8037eb:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  8037f2:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  8037f9:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  803800:	be 00 00 00 00       	mov    $0x0,%esi
  803805:	48 89 c7             	mov    %rax,%rdi
  803808:	48 b8 7e 33 80 00 00 	movabs $0x80337e,%rax
  80380f:	00 00 00 
  803812:	ff d0                	callq  *%rax
  803814:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803817:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80381b:	79 28                	jns    803845 <copy+0x65>
  80381d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803820:	89 c6                	mov    %eax,%esi
  803822:	48 bf f4 54 80 00 00 	movabs $0x8054f4,%rdi
  803829:	00 00 00 
  80382c:	b8 00 00 00 00       	mov    $0x0,%eax
  803831:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  803838:	00 00 00 
  80383b:	ff d2                	callq  *%rdx
  80383d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803840:	e9 74 01 00 00       	jmpq   8039b9 <copy+0x1d9>
  803845:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  80384c:	be 01 01 00 00       	mov    $0x101,%esi
  803851:	48 89 c7             	mov    %rax,%rdi
  803854:	48 b8 7e 33 80 00 00 	movabs $0x80337e,%rax
  80385b:	00 00 00 
  80385e:	ff d0                	callq  *%rax
  803860:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803863:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  803867:	79 39                	jns    8038a2 <copy+0xc2>
  803869:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80386c:	89 c6                	mov    %eax,%esi
  80386e:	48 bf 0a 55 80 00 00 	movabs $0x80550a,%rdi
  803875:	00 00 00 
  803878:	b8 00 00 00 00       	mov    $0x0,%eax
  80387d:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  803884:	00 00 00 
  803887:	ff d2                	callq  *%rdx
  803889:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80388c:	89 c7                	mov    %eax,%edi
  80388e:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  803895:	00 00 00 
  803898:	ff d0                	callq  *%rax
  80389a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80389d:	e9 17 01 00 00       	jmpq   8039b9 <copy+0x1d9>
  8038a2:	eb 74                	jmp    803918 <copy+0x138>
  8038a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8038a7:	48 63 d0             	movslq %eax,%rdx
  8038aa:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  8038b1:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8038b4:	48 89 ce             	mov    %rcx,%rsi
  8038b7:	89 c7                	mov    %eax,%edi
  8038b9:	48 b8 f2 2f 80 00 00 	movabs $0x802ff2,%rax
  8038c0:	00 00 00 
  8038c3:	ff d0                	callq  *%rax
  8038c5:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8038c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  8038cc:	79 4a                	jns    803918 <copy+0x138>
  8038ce:	8b 45 f0             	mov    -0x10(%rbp),%eax
  8038d1:	89 c6                	mov    %eax,%esi
  8038d3:	48 bf 24 55 80 00 00 	movabs $0x805524,%rdi
  8038da:	00 00 00 
  8038dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8038e2:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  8038e9:	00 00 00 
  8038ec:	ff d2                	callq  *%rdx
  8038ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8038f1:	89 c7                	mov    %eax,%edi
  8038f3:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  8038fa:	00 00 00 
  8038fd:	ff d0                	callq  *%rax
  8038ff:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803902:	89 c7                	mov    %eax,%edi
  803904:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  80390b:	00 00 00 
  80390e:	ff d0                	callq  *%rax
  803910:	8b 45 f0             	mov    -0x10(%rbp),%eax
  803913:	e9 a1 00 00 00       	jmpq   8039b9 <copy+0x1d9>
  803918:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  80391f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803922:	ba 00 02 00 00       	mov    $0x200,%edx
  803927:	48 89 ce             	mov    %rcx,%rsi
  80392a:	89 c7                	mov    %eax,%edi
  80392c:	48 b8 a8 2e 80 00 00 	movabs $0x802ea8,%rax
  803933:	00 00 00 
  803936:	ff d0                	callq  *%rax
  803938:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80393b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  80393f:	0f 8f 5f ff ff ff    	jg     8038a4 <copy+0xc4>
  803945:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  803949:	79 47                	jns    803992 <copy+0x1b2>
  80394b:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80394e:	89 c6                	mov    %eax,%esi
  803950:	48 bf 37 55 80 00 00 	movabs $0x805537,%rdi
  803957:	00 00 00 
  80395a:	b8 00 00 00 00       	mov    $0x0,%eax
  80395f:	48 ba 79 08 80 00 00 	movabs $0x800879,%rdx
  803966:	00 00 00 
  803969:	ff d2                	callq  *%rdx
  80396b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80396e:	89 c7                	mov    %eax,%edi
  803970:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  803977:	00 00 00 
  80397a:	ff d0                	callq  *%rax
  80397c:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80397f:	89 c7                	mov    %eax,%edi
  803981:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  803988:	00 00 00 
  80398b:	ff d0                	callq  *%rax
  80398d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  803990:	eb 27                	jmp    8039b9 <copy+0x1d9>
  803992:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803995:	89 c7                	mov    %eax,%edi
  803997:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  80399e:	00 00 00 
  8039a1:	ff d0                	callq  *%rax
  8039a3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8039a6:	89 c7                	mov    %eax,%edi
  8039a8:	48 b8 86 2c 80 00 00 	movabs $0x802c86,%rax
  8039af:	00 00 00 
  8039b2:	ff d0                	callq  *%rax
  8039b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8039b9:	c9                   	leaveq 
  8039ba:	c3                   	retq   

00000000008039bb <fd2sockid>:
  8039bb:	55                   	push   %rbp
  8039bc:	48 89 e5             	mov    %rsp,%rbp
  8039bf:	48 83 ec 20          	sub    $0x20,%rsp
  8039c3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8039c6:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8039ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8039cd:	48 89 d6             	mov    %rdx,%rsi
  8039d0:	89 c7                	mov    %eax,%edi
  8039d2:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  8039d9:	00 00 00 
  8039dc:	ff d0                	callq  *%rax
  8039de:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8039e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8039e5:	79 05                	jns    8039ec <fd2sockid+0x31>
  8039e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8039ea:	eb 24                	jmp    803a10 <fd2sockid+0x55>
  8039ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039f0:	8b 10                	mov    (%rax),%edx
  8039f2:	48 b8 a0 70 80 00 00 	movabs $0x8070a0,%rax
  8039f9:	00 00 00 
  8039fc:	8b 00                	mov    (%rax),%eax
  8039fe:	39 c2                	cmp    %eax,%edx
  803a00:	74 07                	je     803a09 <fd2sockid+0x4e>
  803a02:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  803a07:	eb 07                	jmp    803a10 <fd2sockid+0x55>
  803a09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a0d:	8b 40 0c             	mov    0xc(%rax),%eax
  803a10:	c9                   	leaveq 
  803a11:	c3                   	retq   

0000000000803a12 <alloc_sockfd>:
  803a12:	55                   	push   %rbp
  803a13:	48 89 e5             	mov    %rsp,%rbp
  803a16:	48 83 ec 20          	sub    $0x20,%rsp
  803a1a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803a1d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803a21:	48 89 c7             	mov    %rax,%rdi
  803a24:	48 b8 de 29 80 00 00 	movabs $0x8029de,%rax
  803a2b:	00 00 00 
  803a2e:	ff d0                	callq  *%rax
  803a30:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a33:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a37:	78 26                	js     803a5f <alloc_sockfd+0x4d>
  803a39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a3d:	ba 07 04 00 00       	mov    $0x407,%edx
  803a42:	48 89 c6             	mov    %rax,%rsi
  803a45:	bf 00 00 00 00       	mov    $0x0,%edi
  803a4a:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  803a51:	00 00 00 
  803a54:	ff d0                	callq  *%rax
  803a56:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803a59:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803a5d:	79 16                	jns    803a75 <alloc_sockfd+0x63>
  803a5f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803a62:	89 c7                	mov    %eax,%edi
  803a64:	48 b8 1f 3f 80 00 00 	movabs $0x803f1f,%rax
  803a6b:	00 00 00 
  803a6e:	ff d0                	callq  *%rax
  803a70:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803a73:	eb 3a                	jmp    803aaf <alloc_sockfd+0x9d>
  803a75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a79:	48 ba a0 70 80 00 00 	movabs $0x8070a0,%rdx
  803a80:	00 00 00 
  803a83:	8b 12                	mov    (%rdx),%edx
  803a85:	89 10                	mov    %edx,(%rax)
  803a87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a8b:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803a92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803a96:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803a99:	89 50 0c             	mov    %edx,0xc(%rax)
  803a9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803aa0:	48 89 c7             	mov    %rax,%rdi
  803aa3:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  803aaa:	00 00 00 
  803aad:	ff d0                	callq  *%rax
  803aaf:	c9                   	leaveq 
  803ab0:	c3                   	retq   

0000000000803ab1 <accept>:
  803ab1:	55                   	push   %rbp
  803ab2:	48 89 e5             	mov    %rsp,%rbp
  803ab5:	48 83 ec 30          	sub    $0x30,%rsp
  803ab9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803abc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803ac0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803ac4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803ac7:	89 c7                	mov    %eax,%edi
  803ac9:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803ad0:	00 00 00 
  803ad3:	ff d0                	callq  *%rax
  803ad5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803ad8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803adc:	79 05                	jns    803ae3 <accept+0x32>
  803ade:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ae1:	eb 3b                	jmp    803b1e <accept+0x6d>
  803ae3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  803ae7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803aeb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803aee:	48 89 ce             	mov    %rcx,%rsi
  803af1:	89 c7                	mov    %eax,%edi
  803af3:	48 b8 fc 3d 80 00 00 	movabs $0x803dfc,%rax
  803afa:	00 00 00 
  803afd:	ff d0                	callq  *%rax
  803aff:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b02:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b06:	79 05                	jns    803b0d <accept+0x5c>
  803b08:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b0b:	eb 11                	jmp    803b1e <accept+0x6d>
  803b0d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b10:	89 c7                	mov    %eax,%edi
  803b12:	48 b8 12 3a 80 00 00 	movabs $0x803a12,%rax
  803b19:	00 00 00 
  803b1c:	ff d0                	callq  *%rax
  803b1e:	c9                   	leaveq 
  803b1f:	c3                   	retq   

0000000000803b20 <bind>:
  803b20:	55                   	push   %rbp
  803b21:	48 89 e5             	mov    %rsp,%rbp
  803b24:	48 83 ec 20          	sub    $0x20,%rsp
  803b28:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b2b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803b2f:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803b32:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b35:	89 c7                	mov    %eax,%edi
  803b37:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803b3e:	00 00 00 
  803b41:	ff d0                	callq  *%rax
  803b43:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b46:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b4a:	79 05                	jns    803b51 <bind+0x31>
  803b4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b4f:	eb 1b                	jmp    803b6c <bind+0x4c>
  803b51:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b54:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803b58:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b5b:	48 89 ce             	mov    %rcx,%rsi
  803b5e:	89 c7                	mov    %eax,%edi
  803b60:	48 b8 7b 3e 80 00 00 	movabs $0x803e7b,%rax
  803b67:	00 00 00 
  803b6a:	ff d0                	callq  *%rax
  803b6c:	c9                   	leaveq 
  803b6d:	c3                   	retq   

0000000000803b6e <shutdown>:
  803b6e:	55                   	push   %rbp
  803b6f:	48 89 e5             	mov    %rsp,%rbp
  803b72:	48 83 ec 20          	sub    $0x20,%rsp
  803b76:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b79:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803b7c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b7f:	89 c7                	mov    %eax,%edi
  803b81:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803b88:	00 00 00 
  803b8b:	ff d0                	callq  *%rax
  803b8d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b90:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b94:	79 05                	jns    803b9b <shutdown+0x2d>
  803b96:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b99:	eb 16                	jmp    803bb1 <shutdown+0x43>
  803b9b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803b9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ba1:	89 d6                	mov    %edx,%esi
  803ba3:	89 c7                	mov    %eax,%edi
  803ba5:	48 b8 df 3e 80 00 00 	movabs $0x803edf,%rax
  803bac:	00 00 00 
  803baf:	ff d0                	callq  *%rax
  803bb1:	c9                   	leaveq 
  803bb2:	c3                   	retq   

0000000000803bb3 <devsock_close>:
  803bb3:	55                   	push   %rbp
  803bb4:	48 89 e5             	mov    %rsp,%rbp
  803bb7:	48 83 ec 10          	sub    $0x10,%rsp
  803bbb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803bc3:	48 89 c7             	mov    %rax,%rdi
  803bc6:	48 b8 6b 4b 80 00 00 	movabs $0x804b6b,%rax
  803bcd:	00 00 00 
  803bd0:	ff d0                	callq  *%rax
  803bd2:	83 f8 01             	cmp    $0x1,%eax
  803bd5:	75 17                	jne    803bee <devsock_close+0x3b>
  803bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803bdb:	8b 40 0c             	mov    0xc(%rax),%eax
  803bde:	89 c7                	mov    %eax,%edi
  803be0:	48 b8 1f 3f 80 00 00 	movabs $0x803f1f,%rax
  803be7:	00 00 00 
  803bea:	ff d0                	callq  *%rax
  803bec:	eb 05                	jmp    803bf3 <devsock_close+0x40>
  803bee:	b8 00 00 00 00       	mov    $0x0,%eax
  803bf3:	c9                   	leaveq 
  803bf4:	c3                   	retq   

0000000000803bf5 <connect>:
  803bf5:	55                   	push   %rbp
  803bf6:	48 89 e5             	mov    %rsp,%rbp
  803bf9:	48 83 ec 20          	sub    $0x20,%rsp
  803bfd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c00:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c04:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803c07:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c0a:	89 c7                	mov    %eax,%edi
  803c0c:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803c13:	00 00 00 
  803c16:	ff d0                	callq  *%rax
  803c18:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c1b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c1f:	79 05                	jns    803c26 <connect+0x31>
  803c21:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c24:	eb 1b                	jmp    803c41 <connect+0x4c>
  803c26:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c29:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  803c2d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c30:	48 89 ce             	mov    %rcx,%rsi
  803c33:	89 c7                	mov    %eax,%edi
  803c35:	48 b8 4c 3f 80 00 00 	movabs $0x803f4c,%rax
  803c3c:	00 00 00 
  803c3f:	ff d0                	callq  *%rax
  803c41:	c9                   	leaveq 
  803c42:	c3                   	retq   

0000000000803c43 <listen>:
  803c43:	55                   	push   %rbp
  803c44:	48 89 e5             	mov    %rsp,%rbp
  803c47:	48 83 ec 20          	sub    $0x20,%rsp
  803c4b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803c4e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803c51:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803c54:	89 c7                	mov    %eax,%edi
  803c56:	48 b8 bb 39 80 00 00 	movabs $0x8039bb,%rax
  803c5d:	00 00 00 
  803c60:	ff d0                	callq  *%rax
  803c62:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c65:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c69:	79 05                	jns    803c70 <listen+0x2d>
  803c6b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c6e:	eb 16                	jmp    803c86 <listen+0x43>
  803c70:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803c73:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c76:	89 d6                	mov    %edx,%esi
  803c78:	89 c7                	mov    %eax,%edi
  803c7a:	48 b8 b0 3f 80 00 00 	movabs $0x803fb0,%rax
  803c81:	00 00 00 
  803c84:	ff d0                	callq  *%rax
  803c86:	c9                   	leaveq 
  803c87:	c3                   	retq   

0000000000803c88 <devsock_read>:
  803c88:	55                   	push   %rbp
  803c89:	48 89 e5             	mov    %rsp,%rbp
  803c8c:	48 83 ec 20          	sub    $0x20,%rsp
  803c90:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803c94:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803c98:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803c9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803ca0:	89 c2                	mov    %eax,%edx
  803ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ca6:	8b 40 0c             	mov    0xc(%rax),%eax
  803ca9:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803cad:	b9 00 00 00 00       	mov    $0x0,%ecx
  803cb2:	89 c7                	mov    %eax,%edi
  803cb4:	48 b8 f0 3f 80 00 00 	movabs $0x803ff0,%rax
  803cbb:	00 00 00 
  803cbe:	ff d0                	callq  *%rax
  803cc0:	c9                   	leaveq 
  803cc1:	c3                   	retq   

0000000000803cc2 <devsock_write>:
  803cc2:	55                   	push   %rbp
  803cc3:	48 89 e5             	mov    %rsp,%rbp
  803cc6:	48 83 ec 20          	sub    $0x20,%rsp
  803cca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803cce:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803cd2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  803cd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803cda:	89 c2                	mov    %eax,%edx
  803cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803ce0:	8b 40 0c             	mov    0xc(%rax),%eax
  803ce3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  803ce7:	b9 00 00 00 00       	mov    $0x0,%ecx
  803cec:	89 c7                	mov    %eax,%edi
  803cee:	48 b8 bc 40 80 00 00 	movabs $0x8040bc,%rax
  803cf5:	00 00 00 
  803cf8:	ff d0                	callq  *%rax
  803cfa:	c9                   	leaveq 
  803cfb:	c3                   	retq   

0000000000803cfc <devsock_stat>:
  803cfc:	55                   	push   %rbp
  803cfd:	48 89 e5             	mov    %rsp,%rbp
  803d00:	48 83 ec 10          	sub    $0x10,%rsp
  803d04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803d08:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803d0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803d10:	48 be 52 55 80 00 00 	movabs $0x805552,%rsi
  803d17:	00 00 00 
  803d1a:	48 89 c7             	mov    %rax,%rdi
  803d1d:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  803d24:	00 00 00 
  803d27:	ff d0                	callq  *%rax
  803d29:	b8 00 00 00 00       	mov    $0x0,%eax
  803d2e:	c9                   	leaveq 
  803d2f:	c3                   	retq   

0000000000803d30 <socket>:
  803d30:	55                   	push   %rbp
  803d31:	48 89 e5             	mov    %rsp,%rbp
  803d34:	48 83 ec 20          	sub    $0x20,%rsp
  803d38:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803d3b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803d3e:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803d41:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803d44:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803d47:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803d4a:	89 ce                	mov    %ecx,%esi
  803d4c:	89 c7                	mov    %eax,%edi
  803d4e:	48 b8 74 41 80 00 00 	movabs $0x804174,%rax
  803d55:	00 00 00 
  803d58:	ff d0                	callq  *%rax
  803d5a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803d5d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803d61:	79 05                	jns    803d68 <socket+0x38>
  803d63:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d66:	eb 11                	jmp    803d79 <socket+0x49>
  803d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d6b:	89 c7                	mov    %eax,%edi
  803d6d:	48 b8 12 3a 80 00 00 	movabs $0x803a12,%rax
  803d74:	00 00 00 
  803d77:	ff d0                	callq  *%rax
  803d79:	c9                   	leaveq 
  803d7a:	c3                   	retq   

0000000000803d7b <nsipc>:
  803d7b:	55                   	push   %rbp
  803d7c:	48 89 e5             	mov    %rsp,%rbp
  803d7f:	48 83 ec 10          	sub    $0x10,%rsp
  803d83:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803d86:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803d8d:	00 00 00 
  803d90:	8b 00                	mov    (%rax),%eax
  803d92:	85 c0                	test   %eax,%eax
  803d94:	75 1d                	jne    803db3 <nsipc+0x38>
  803d96:	bf 02 00 00 00       	mov    $0x2,%edi
  803d9b:	48 b8 1e 29 80 00 00 	movabs $0x80291e,%rax
  803da2:	00 00 00 
  803da5:	ff d0                	callq  *%rax
  803da7:	48 ba 08 80 80 00 00 	movabs $0x808008,%rdx
  803dae:	00 00 00 
  803db1:	89 02                	mov    %eax,(%rdx)
  803db3:	48 b8 08 80 80 00 00 	movabs $0x808008,%rax
  803dba:	00 00 00 
  803dbd:	8b 00                	mov    (%rax),%eax
  803dbf:	8b 75 fc             	mov    -0x4(%rbp),%esi
  803dc2:	b9 07 00 00 00       	mov    $0x7,%ecx
  803dc7:	48 ba 00 b0 80 00 00 	movabs $0x80b000,%rdx
  803dce:	00 00 00 
  803dd1:	89 c7                	mov    %eax,%edi
  803dd3:	48 b8 13 28 80 00 00 	movabs $0x802813,%rax
  803dda:	00 00 00 
  803ddd:	ff d0                	callq  *%rax
  803ddf:	ba 00 00 00 00       	mov    $0x0,%edx
  803de4:	be 00 00 00 00       	mov    $0x0,%esi
  803de9:	bf 00 00 00 00       	mov    $0x0,%edi
  803dee:	48 b8 52 27 80 00 00 	movabs $0x802752,%rax
  803df5:	00 00 00 
  803df8:	ff d0                	callq  *%rax
  803dfa:	c9                   	leaveq 
  803dfb:	c3                   	retq   

0000000000803dfc <nsipc_accept>:
  803dfc:	55                   	push   %rbp
  803dfd:	48 89 e5             	mov    %rsp,%rbp
  803e00:	48 83 ec 30          	sub    $0x30,%rsp
  803e04:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803e07:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803e0b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803e0f:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e16:	00 00 00 
  803e19:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803e1c:	89 10                	mov    %edx,(%rax)
  803e1e:	bf 01 00 00 00       	mov    $0x1,%edi
  803e23:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803e2a:	00 00 00 
  803e2d:	ff d0                	callq  *%rax
  803e2f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803e32:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803e36:	78 3e                	js     803e76 <nsipc_accept+0x7a>
  803e38:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e3f:	00 00 00 
  803e42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e4a:	8b 40 10             	mov    0x10(%rax),%eax
  803e4d:	89 c2                	mov    %eax,%edx
  803e4f:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803e53:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803e57:	48 89 ce             	mov    %rcx,%rsi
  803e5a:	48 89 c7             	mov    %rax,%rdi
  803e5d:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  803e64:	00 00 00 
  803e67:	ff d0                	callq  *%rax
  803e69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803e6d:	8b 50 10             	mov    0x10(%rax),%edx
  803e70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803e74:	89 10                	mov    %edx,(%rax)
  803e76:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803e79:	c9                   	leaveq 
  803e7a:	c3                   	retq   

0000000000803e7b <nsipc_bind>:
  803e7b:	55                   	push   %rbp
  803e7c:	48 89 e5             	mov    %rsp,%rbp
  803e7f:	48 83 ec 10          	sub    $0x10,%rsp
  803e83:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803e86:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803e8a:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803e8d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803e94:	00 00 00 
  803e97:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803e9a:	89 10                	mov    %edx,(%rax)
  803e9c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803e9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803ea3:	48 89 c6             	mov    %rax,%rsi
  803ea6:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803ead:	00 00 00 
  803eb0:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  803eb7:	00 00 00 
  803eba:	ff d0                	callq  *%rax
  803ebc:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ec3:	00 00 00 
  803ec6:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803ec9:	89 50 14             	mov    %edx,0x14(%rax)
  803ecc:	bf 02 00 00 00       	mov    $0x2,%edi
  803ed1:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803ed8:	00 00 00 
  803edb:	ff d0                	callq  *%rax
  803edd:	c9                   	leaveq 
  803ede:	c3                   	retq   

0000000000803edf <nsipc_shutdown>:
  803edf:	55                   	push   %rbp
  803ee0:	48 89 e5             	mov    %rsp,%rbp
  803ee3:	48 83 ec 10          	sub    $0x10,%rsp
  803ee7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803eea:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803eed:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803ef4:	00 00 00 
  803ef7:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803efa:	89 10                	mov    %edx,(%rax)
  803efc:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f03:	00 00 00 
  803f06:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f09:	89 50 04             	mov    %edx,0x4(%rax)
  803f0c:	bf 03 00 00 00       	mov    $0x3,%edi
  803f11:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803f18:	00 00 00 
  803f1b:	ff d0                	callq  *%rax
  803f1d:	c9                   	leaveq 
  803f1e:	c3                   	retq   

0000000000803f1f <nsipc_close>:
  803f1f:	55                   	push   %rbp
  803f20:	48 89 e5             	mov    %rsp,%rbp
  803f23:	48 83 ec 10          	sub    $0x10,%rsp
  803f27:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f2a:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f31:	00 00 00 
  803f34:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f37:	89 10                	mov    %edx,(%rax)
  803f39:	bf 04 00 00 00       	mov    $0x4,%edi
  803f3e:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803f45:	00 00 00 
  803f48:	ff d0                	callq  *%rax
  803f4a:	c9                   	leaveq 
  803f4b:	c3                   	retq   

0000000000803f4c <nsipc_connect>:
  803f4c:	55                   	push   %rbp
  803f4d:	48 89 e5             	mov    %rsp,%rbp
  803f50:	48 83 ec 10          	sub    $0x10,%rsp
  803f54:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803f57:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803f5b:	89 55 f8             	mov    %edx,-0x8(%rbp)
  803f5e:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f65:	00 00 00 
  803f68:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803f6b:	89 10                	mov    %edx,(%rax)
  803f6d:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803f74:	48 89 c6             	mov    %rax,%rsi
  803f77:	48 bf 04 b0 80 00 00 	movabs $0x80b004,%rdi
  803f7e:	00 00 00 
  803f81:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  803f88:	00 00 00 
  803f8b:	ff d0                	callq  *%rax
  803f8d:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803f94:	00 00 00 
  803f97:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803f9a:	89 50 14             	mov    %edx,0x14(%rax)
  803f9d:	bf 05 00 00 00       	mov    $0x5,%edi
  803fa2:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803fa9:	00 00 00 
  803fac:	ff d0                	callq  *%rax
  803fae:	c9                   	leaveq 
  803faf:	c3                   	retq   

0000000000803fb0 <nsipc_listen>:
  803fb0:	55                   	push   %rbp
  803fb1:	48 89 e5             	mov    %rsp,%rbp
  803fb4:	48 83 ec 10          	sub    $0x10,%rsp
  803fb8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803fbb:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803fbe:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fc5:	00 00 00 
  803fc8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803fcb:	89 10                	mov    %edx,(%rax)
  803fcd:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  803fd4:	00 00 00 
  803fd7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803fda:	89 50 04             	mov    %edx,0x4(%rax)
  803fdd:	bf 06 00 00 00       	mov    $0x6,%edi
  803fe2:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  803fe9:	00 00 00 
  803fec:	ff d0                	callq  *%rax
  803fee:	c9                   	leaveq 
  803fef:	c3                   	retq   

0000000000803ff0 <nsipc_recv>:
  803ff0:	55                   	push   %rbp
  803ff1:	48 89 e5             	mov    %rsp,%rbp
  803ff4:	48 83 ec 30          	sub    $0x30,%rsp
  803ff8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803ffb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803fff:	89 55 e8             	mov    %edx,-0x18(%rbp)
  804002:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  804005:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80400c:	00 00 00 
  80400f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  804012:	89 10                	mov    %edx,(%rax)
  804014:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80401b:	00 00 00 
  80401e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  804021:	89 50 04             	mov    %edx,0x4(%rax)
  804024:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80402b:	00 00 00 
  80402e:	8b 55 dc             	mov    -0x24(%rbp),%edx
  804031:	89 50 08             	mov    %edx,0x8(%rax)
  804034:	bf 07 00 00 00       	mov    $0x7,%edi
  804039:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  804040:	00 00 00 
  804043:	ff d0                	callq  *%rax
  804045:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804048:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80404c:	78 69                	js     8040b7 <nsipc_recv+0xc7>
  80404e:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  804055:	7f 08                	jg     80405f <nsipc_recv+0x6f>
  804057:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80405a:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  80405d:	7e 35                	jle    804094 <nsipc_recv+0xa4>
  80405f:	48 b9 59 55 80 00 00 	movabs $0x805559,%rcx
  804066:	00 00 00 
  804069:	48 ba 6e 55 80 00 00 	movabs $0x80556e,%rdx
  804070:	00 00 00 
  804073:	be 62 00 00 00       	mov    $0x62,%esi
  804078:	48 bf 83 55 80 00 00 	movabs $0x805583,%rdi
  80407f:	00 00 00 
  804082:	b8 00 00 00 00       	mov    $0x0,%eax
  804087:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  80408e:	00 00 00 
  804091:	41 ff d0             	callq  *%r8
  804094:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804097:	48 63 d0             	movslq %eax,%rdx
  80409a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80409e:	48 be 00 b0 80 00 00 	movabs $0x80b000,%rsi
  8040a5:	00 00 00 
  8040a8:	48 89 c7             	mov    %rax,%rdi
  8040ab:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  8040b2:	00 00 00 
  8040b5:	ff d0                	callq  *%rax
  8040b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040ba:	c9                   	leaveq 
  8040bb:	c3                   	retq   

00000000008040bc <nsipc_send>:
  8040bc:	55                   	push   %rbp
  8040bd:	48 89 e5             	mov    %rsp,%rbp
  8040c0:	48 83 ec 20          	sub    $0x20,%rsp
  8040c4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8040c7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8040cb:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8040ce:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8040d1:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8040d8:	00 00 00 
  8040db:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8040de:	89 10                	mov    %edx,(%rax)
  8040e0:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  8040e7:	7e 35                	jle    80411e <nsipc_send+0x62>
  8040e9:	48 b9 92 55 80 00 00 	movabs $0x805592,%rcx
  8040f0:	00 00 00 
  8040f3:	48 ba 6e 55 80 00 00 	movabs $0x80556e,%rdx
  8040fa:	00 00 00 
  8040fd:	be 6d 00 00 00       	mov    $0x6d,%esi
  804102:	48 bf 83 55 80 00 00 	movabs $0x805583,%rdi
  804109:	00 00 00 
  80410c:	b8 00 00 00 00       	mov    $0x0,%eax
  804111:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  804118:	00 00 00 
  80411b:	41 ff d0             	callq  *%r8
  80411e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804121:	48 63 d0             	movslq %eax,%rdx
  804124:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804128:	48 89 c6             	mov    %rax,%rsi
  80412b:	48 bf 0c b0 80 00 00 	movabs $0x80b00c,%rdi
  804132:	00 00 00 
  804135:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  80413c:	00 00 00 
  80413f:	ff d0                	callq  *%rax
  804141:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804148:	00 00 00 
  80414b:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80414e:	89 50 04             	mov    %edx,0x4(%rax)
  804151:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  804158:	00 00 00 
  80415b:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80415e:	89 50 08             	mov    %edx,0x8(%rax)
  804161:	bf 08 00 00 00       	mov    $0x8,%edi
  804166:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  80416d:	00 00 00 
  804170:	ff d0                	callq  *%rax
  804172:	c9                   	leaveq 
  804173:	c3                   	retq   

0000000000804174 <nsipc_socket>:
  804174:	55                   	push   %rbp
  804175:	48 89 e5             	mov    %rsp,%rbp
  804178:	48 83 ec 10          	sub    $0x10,%rsp
  80417c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80417f:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804182:	89 55 f4             	mov    %edx,-0xc(%rbp)
  804185:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80418c:	00 00 00 
  80418f:	8b 55 fc             	mov    -0x4(%rbp),%edx
  804192:	89 10                	mov    %edx,(%rax)
  804194:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  80419b:	00 00 00 
  80419e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8041a1:	89 50 04             	mov    %edx,0x4(%rax)
  8041a4:	48 b8 00 b0 80 00 00 	movabs $0x80b000,%rax
  8041ab:	00 00 00 
  8041ae:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8041b1:	89 50 08             	mov    %edx,0x8(%rax)
  8041b4:	bf 09 00 00 00       	mov    $0x9,%edi
  8041b9:	48 b8 7b 3d 80 00 00 	movabs $0x803d7b,%rax
  8041c0:	00 00 00 
  8041c3:	ff d0                	callq  *%rax
  8041c5:	c9                   	leaveq 
  8041c6:	c3                   	retq   

00000000008041c7 <pipe>:
  8041c7:	55                   	push   %rbp
  8041c8:	48 89 e5             	mov    %rsp,%rbp
  8041cb:	53                   	push   %rbx
  8041cc:	48 83 ec 38          	sub    $0x38,%rsp
  8041d0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8041d4:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8041d8:	48 89 c7             	mov    %rax,%rdi
  8041db:	48 b8 de 29 80 00 00 	movabs $0x8029de,%rax
  8041e2:	00 00 00 
  8041e5:	ff d0                	callq  *%rax
  8041e7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8041ea:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8041ee:	0f 88 bf 01 00 00    	js     8043b3 <pipe+0x1ec>
  8041f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8041f8:	ba 07 04 00 00       	mov    $0x407,%edx
  8041fd:	48 89 c6             	mov    %rax,%rsi
  804200:	bf 00 00 00 00       	mov    $0x0,%edi
  804205:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  80420c:	00 00 00 
  80420f:	ff d0                	callq  *%rax
  804211:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804214:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804218:	0f 88 95 01 00 00    	js     8043b3 <pipe+0x1ec>
  80421e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  804222:	48 89 c7             	mov    %rax,%rdi
  804225:	48 b8 de 29 80 00 00 	movabs $0x8029de,%rax
  80422c:	00 00 00 
  80422f:	ff d0                	callq  *%rax
  804231:	89 45 ec             	mov    %eax,-0x14(%rbp)
  804234:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804238:	0f 88 5d 01 00 00    	js     80439b <pipe+0x1d4>
  80423e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804242:	ba 07 04 00 00       	mov    $0x407,%edx
  804247:	48 89 c6             	mov    %rax,%rsi
  80424a:	bf 00 00 00 00       	mov    $0x0,%edi
  80424f:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  804256:	00 00 00 
  804259:	ff d0                	callq  *%rax
  80425b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80425e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  804262:	0f 88 33 01 00 00    	js     80439b <pipe+0x1d4>
  804268:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80426c:	48 89 c7             	mov    %rax,%rdi
  80426f:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  804276:	00 00 00 
  804279:	ff d0                	callq  *%rax
  80427b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80427f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804283:	ba 07 04 00 00       	mov    $0x407,%edx
  804288:	48 89 c6             	mov    %rax,%rsi
  80428b:	bf 00 00 00 00       	mov    $0x0,%edi
  804290:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  804297:	00 00 00 
  80429a:	ff d0                	callq  *%rax
  80429c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80429f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8042a3:	79 05                	jns    8042aa <pipe+0xe3>
  8042a5:	e9 d9 00 00 00       	jmpq   804383 <pipe+0x1bc>
  8042aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8042ae:	48 89 c7             	mov    %rax,%rdi
  8042b1:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  8042b8:	00 00 00 
  8042bb:	ff d0                	callq  *%rax
  8042bd:	48 89 c2             	mov    %rax,%rdx
  8042c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8042c4:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8042ca:	48 89 d1             	mov    %rdx,%rcx
  8042cd:	ba 00 00 00 00       	mov    $0x0,%edx
  8042d2:	48 89 c6             	mov    %rax,%rsi
  8042d5:	bf 00 00 00 00       	mov    $0x0,%edi
  8042da:	48 b8 ad 1d 80 00 00 	movabs $0x801dad,%rax
  8042e1:	00 00 00 
  8042e4:	ff d0                	callq  *%rax
  8042e6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8042e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8042ed:	79 1b                	jns    80430a <pipe+0x143>
  8042ef:	90                   	nop
  8042f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8042f4:	48 89 c6             	mov    %rax,%rsi
  8042f7:	bf 00 00 00 00       	mov    $0x0,%edi
  8042fc:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  804303:	00 00 00 
  804306:	ff d0                	callq  *%rax
  804308:	eb 79                	jmp    804383 <pipe+0x1bc>
  80430a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80430e:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804315:	00 00 00 
  804318:	8b 12                	mov    (%rdx),%edx
  80431a:	89 10                	mov    %edx,(%rax)
  80431c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804320:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  804327:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80432b:	48 ba e0 70 80 00 00 	movabs $0x8070e0,%rdx
  804332:	00 00 00 
  804335:	8b 12                	mov    (%rdx),%edx
  804337:	89 10                	mov    %edx,(%rax)
  804339:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80433d:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  804344:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804348:	48 89 c7             	mov    %rax,%rdi
  80434b:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  804352:	00 00 00 
  804355:	ff d0                	callq  *%rax
  804357:	89 c2                	mov    %eax,%edx
  804359:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80435d:	89 10                	mov    %edx,(%rax)
  80435f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  804363:	48 8d 58 04          	lea    0x4(%rax),%rbx
  804367:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80436b:	48 89 c7             	mov    %rax,%rdi
  80436e:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  804375:	00 00 00 
  804378:	ff d0                	callq  *%rax
  80437a:	89 03                	mov    %eax,(%rbx)
  80437c:	b8 00 00 00 00       	mov    $0x0,%eax
  804381:	eb 33                	jmp    8043b6 <pipe+0x1ef>
  804383:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804387:	48 89 c6             	mov    %rax,%rsi
  80438a:	bf 00 00 00 00       	mov    $0x0,%edi
  80438f:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  804396:	00 00 00 
  804399:	ff d0                	callq  *%rax
  80439b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80439f:	48 89 c6             	mov    %rax,%rsi
  8043a2:	bf 00 00 00 00       	mov    $0x0,%edi
  8043a7:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  8043ae:	00 00 00 
  8043b1:	ff d0                	callq  *%rax
  8043b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8043b6:	48 83 c4 38          	add    $0x38,%rsp
  8043ba:	5b                   	pop    %rbx
  8043bb:	5d                   	pop    %rbp
  8043bc:	c3                   	retq   

00000000008043bd <_pipeisclosed>:
  8043bd:	55                   	push   %rbp
  8043be:	48 89 e5             	mov    %rsp,%rbp
  8043c1:	53                   	push   %rbx
  8043c2:	48 83 ec 28          	sub    $0x28,%rsp
  8043c6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8043ca:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8043ce:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  8043d5:	00 00 00 
  8043d8:	48 8b 00             	mov    (%rax),%rax
  8043db:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8043e1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8043e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8043e8:	48 89 c7             	mov    %rax,%rdi
  8043eb:	48 b8 6b 4b 80 00 00 	movabs $0x804b6b,%rax
  8043f2:	00 00 00 
  8043f5:	ff d0                	callq  *%rax
  8043f7:	89 c3                	mov    %eax,%ebx
  8043f9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8043fd:	48 89 c7             	mov    %rax,%rdi
  804400:	48 b8 6b 4b 80 00 00 	movabs $0x804b6b,%rax
  804407:	00 00 00 
  80440a:	ff d0                	callq  *%rax
  80440c:	39 c3                	cmp    %eax,%ebx
  80440e:	0f 94 c0             	sete   %al
  804411:	0f b6 c0             	movzbl %al,%eax
  804414:	89 45 e8             	mov    %eax,-0x18(%rbp)
  804417:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  80441e:	00 00 00 
  804421:	48 8b 00             	mov    (%rax),%rax
  804424:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80442a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80442d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804430:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804433:	75 05                	jne    80443a <_pipeisclosed+0x7d>
  804435:	8b 45 e8             	mov    -0x18(%rbp),%eax
  804438:	eb 4f                	jmp    804489 <_pipeisclosed+0xcc>
  80443a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80443d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  804440:	74 42                	je     804484 <_pipeisclosed+0xc7>
  804442:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  804446:	75 3c                	jne    804484 <_pipeisclosed+0xc7>
  804448:	48 b8 10 80 80 00 00 	movabs $0x808010,%rax
  80444f:	00 00 00 
  804452:	48 8b 00             	mov    (%rax),%rax
  804455:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80445b:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80445e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804461:	89 c6                	mov    %eax,%esi
  804463:	48 bf a3 55 80 00 00 	movabs $0x8055a3,%rdi
  80446a:	00 00 00 
  80446d:	b8 00 00 00 00       	mov    $0x0,%eax
  804472:	49 b8 79 08 80 00 00 	movabs $0x800879,%r8
  804479:	00 00 00 
  80447c:	41 ff d0             	callq  *%r8
  80447f:	e9 4a ff ff ff       	jmpq   8043ce <_pipeisclosed+0x11>
  804484:	e9 45 ff ff ff       	jmpq   8043ce <_pipeisclosed+0x11>
  804489:	48 83 c4 28          	add    $0x28,%rsp
  80448d:	5b                   	pop    %rbx
  80448e:	5d                   	pop    %rbp
  80448f:	c3                   	retq   

0000000000804490 <pipeisclosed>:
  804490:	55                   	push   %rbp
  804491:	48 89 e5             	mov    %rsp,%rbp
  804494:	48 83 ec 30          	sub    $0x30,%rsp
  804498:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80449b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80449f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8044a2:	48 89 d6             	mov    %rdx,%rsi
  8044a5:	89 c7                	mov    %eax,%edi
  8044a7:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  8044ae:	00 00 00 
  8044b1:	ff d0                	callq  *%rax
  8044b3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8044b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8044ba:	79 05                	jns    8044c1 <pipeisclosed+0x31>
  8044bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8044bf:	eb 31                	jmp    8044f2 <pipeisclosed+0x62>
  8044c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044c5:	48 89 c7             	mov    %rax,%rdi
  8044c8:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  8044cf:	00 00 00 
  8044d2:	ff d0                	callq  *%rax
  8044d4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8044d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8044dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8044e0:	48 89 d6             	mov    %rdx,%rsi
  8044e3:	48 89 c7             	mov    %rax,%rdi
  8044e6:	48 b8 bd 43 80 00 00 	movabs $0x8043bd,%rax
  8044ed:	00 00 00 
  8044f0:	ff d0                	callq  *%rax
  8044f2:	c9                   	leaveq 
  8044f3:	c3                   	retq   

00000000008044f4 <devpipe_read>:
  8044f4:	55                   	push   %rbp
  8044f5:	48 89 e5             	mov    %rsp,%rbp
  8044f8:	48 83 ec 40          	sub    $0x40,%rsp
  8044fc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  804500:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  804504:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  804508:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80450c:	48 89 c7             	mov    %rax,%rdi
  80450f:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  804516:	00 00 00 
  804519:	ff d0                	callq  *%rax
  80451b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80451f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804523:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  804527:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80452e:	00 
  80452f:	e9 92 00 00 00       	jmpq   8045c6 <devpipe_read+0xd2>
  804534:	eb 41                	jmp    804577 <devpipe_read+0x83>
  804536:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80453b:	74 09                	je     804546 <devpipe_read+0x52>
  80453d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804541:	e9 92 00 00 00       	jmpq   8045d8 <devpipe_read+0xe4>
  804546:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80454a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80454e:	48 89 d6             	mov    %rdx,%rsi
  804551:	48 89 c7             	mov    %rax,%rdi
  804554:	48 b8 bd 43 80 00 00 	movabs $0x8043bd,%rax
  80455b:	00 00 00 
  80455e:	ff d0                	callq  *%rax
  804560:	85 c0                	test   %eax,%eax
  804562:	74 07                	je     80456b <devpipe_read+0x77>
  804564:	b8 00 00 00 00       	mov    $0x0,%eax
  804569:	eb 6d                	jmp    8045d8 <devpipe_read+0xe4>
  80456b:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  804572:	00 00 00 
  804575:	ff d0                	callq  *%rax
  804577:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80457b:	8b 10                	mov    (%rax),%edx
  80457d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804581:	8b 40 04             	mov    0x4(%rax),%eax
  804584:	39 c2                	cmp    %eax,%edx
  804586:	74 ae                	je     804536 <devpipe_read+0x42>
  804588:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80458c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804590:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  804594:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804598:	8b 00                	mov    (%rax),%eax
  80459a:	99                   	cltd   
  80459b:	c1 ea 1b             	shr    $0x1b,%edx
  80459e:	01 d0                	add    %edx,%eax
  8045a0:	83 e0 1f             	and    $0x1f,%eax
  8045a3:	29 d0                	sub    %edx,%eax
  8045a5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8045a9:	48 98                	cltq   
  8045ab:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8045b0:	88 01                	mov    %al,(%rcx)
  8045b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045b6:	8b 00                	mov    (%rax),%eax
  8045b8:	8d 50 01             	lea    0x1(%rax),%edx
  8045bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8045bf:	89 10                	mov    %edx,(%rax)
  8045c1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8045c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045ca:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8045ce:	0f 82 60 ff ff ff    	jb     804534 <devpipe_read+0x40>
  8045d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8045d8:	c9                   	leaveq 
  8045d9:	c3                   	retq   

00000000008045da <devpipe_write>:
  8045da:	55                   	push   %rbp
  8045db:	48 89 e5             	mov    %rsp,%rbp
  8045de:	48 83 ec 40          	sub    $0x40,%rsp
  8045e2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8045e6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8045ea:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8045ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8045f2:	48 89 c7             	mov    %rax,%rdi
  8045f5:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  8045fc:	00 00 00 
  8045ff:	ff d0                	callq  *%rax
  804601:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  804605:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  804609:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80460d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  804614:	00 
  804615:	e9 8e 00 00 00       	jmpq   8046a8 <devpipe_write+0xce>
  80461a:	eb 31                	jmp    80464d <devpipe_write+0x73>
  80461c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  804620:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  804624:	48 89 d6             	mov    %rdx,%rsi
  804627:	48 89 c7             	mov    %rax,%rdi
  80462a:	48 b8 bd 43 80 00 00 	movabs $0x8043bd,%rax
  804631:	00 00 00 
  804634:	ff d0                	callq  *%rax
  804636:	85 c0                	test   %eax,%eax
  804638:	74 07                	je     804641 <devpipe_write+0x67>
  80463a:	b8 00 00 00 00       	mov    $0x0,%eax
  80463f:	eb 79                	jmp    8046ba <devpipe_write+0xe0>
  804641:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  804648:	00 00 00 
  80464b:	ff d0                	callq  *%rax
  80464d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804651:	8b 40 04             	mov    0x4(%rax),%eax
  804654:	48 63 d0             	movslq %eax,%rdx
  804657:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80465b:	8b 00                	mov    (%rax),%eax
  80465d:	48 98                	cltq   
  80465f:	48 83 c0 20          	add    $0x20,%rax
  804663:	48 39 c2             	cmp    %rax,%rdx
  804666:	73 b4                	jae    80461c <devpipe_write+0x42>
  804668:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80466c:	8b 40 04             	mov    0x4(%rax),%eax
  80466f:	99                   	cltd   
  804670:	c1 ea 1b             	shr    $0x1b,%edx
  804673:	01 d0                	add    %edx,%eax
  804675:	83 e0 1f             	and    $0x1f,%eax
  804678:	29 d0                	sub    %edx,%eax
  80467a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80467e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  804682:	48 01 ca             	add    %rcx,%rdx
  804685:	0f b6 0a             	movzbl (%rdx),%ecx
  804688:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80468c:	48 98                	cltq   
  80468e:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  804692:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804696:	8b 40 04             	mov    0x4(%rax),%eax
  804699:	8d 50 01             	lea    0x1(%rax),%edx
  80469c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8046a0:	89 50 04             	mov    %edx,0x4(%rax)
  8046a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8046a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046ac:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8046b0:	0f 82 64 ff ff ff    	jb     80461a <devpipe_write+0x40>
  8046b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8046ba:	c9                   	leaveq 
  8046bb:	c3                   	retq   

00000000008046bc <devpipe_stat>:
  8046bc:	55                   	push   %rbp
  8046bd:	48 89 e5             	mov    %rsp,%rbp
  8046c0:	48 83 ec 20          	sub    $0x20,%rsp
  8046c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8046c8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8046cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8046d0:	48 89 c7             	mov    %rax,%rdi
  8046d3:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  8046da:	00 00 00 
  8046dd:	ff d0                	callq  *%rax
  8046df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8046e3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8046e7:	48 be b6 55 80 00 00 	movabs $0x8055b6,%rsi
  8046ee:	00 00 00 
  8046f1:	48 89 c7             	mov    %rax,%rdi
  8046f4:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  8046fb:	00 00 00 
  8046fe:	ff d0                	callq  *%rax
  804700:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804704:	8b 50 04             	mov    0x4(%rax),%edx
  804707:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80470b:	8b 00                	mov    (%rax),%eax
  80470d:	29 c2                	sub    %eax,%edx
  80470f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  804713:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  804719:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80471d:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  804724:	00 00 00 
  804727:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80472b:	48 b9 e0 70 80 00 00 	movabs $0x8070e0,%rcx
  804732:	00 00 00 
  804735:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  80473c:	b8 00 00 00 00       	mov    $0x0,%eax
  804741:	c9                   	leaveq 
  804742:	c3                   	retq   

0000000000804743 <devpipe_close>:
  804743:	55                   	push   %rbp
  804744:	48 89 e5             	mov    %rsp,%rbp
  804747:	48 83 ec 10          	sub    $0x10,%rsp
  80474b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80474f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804753:	48 89 c6             	mov    %rax,%rsi
  804756:	bf 00 00 00 00       	mov    $0x0,%edi
  80475b:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  804762:	00 00 00 
  804765:	ff d0                	callq  *%rax
  804767:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80476b:	48 89 c7             	mov    %rax,%rdi
  80476e:	48 b8 b3 29 80 00 00 	movabs $0x8029b3,%rax
  804775:	00 00 00 
  804778:	ff d0                	callq  *%rax
  80477a:	48 89 c6             	mov    %rax,%rsi
  80477d:	bf 00 00 00 00       	mov    $0x0,%edi
  804782:	48 b8 08 1e 80 00 00 	movabs $0x801e08,%rax
  804789:	00 00 00 
  80478c:	ff d0                	callq  *%rax
  80478e:	c9                   	leaveq 
  80478f:	c3                   	retq   

0000000000804790 <cputchar>:
  804790:	55                   	push   %rbp
  804791:	48 89 e5             	mov    %rsp,%rbp
  804794:	48 83 ec 20          	sub    $0x20,%rsp
  804798:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80479b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80479e:	88 45 ff             	mov    %al,-0x1(%rbp)
  8047a1:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  8047a5:	be 01 00 00 00       	mov    $0x1,%esi
  8047aa:	48 89 c7             	mov    %rax,%rdi
  8047ad:	48 b8 15 1c 80 00 00 	movabs $0x801c15,%rax
  8047b4:	00 00 00 
  8047b7:	ff d0                	callq  *%rax
  8047b9:	c9                   	leaveq 
  8047ba:	c3                   	retq   

00000000008047bb <getchar>:
  8047bb:	55                   	push   %rbp
  8047bc:	48 89 e5             	mov    %rsp,%rbp
  8047bf:	48 83 ec 10          	sub    $0x10,%rsp
  8047c3:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  8047c7:	ba 01 00 00 00       	mov    $0x1,%edx
  8047cc:	48 89 c6             	mov    %rax,%rsi
  8047cf:	bf 00 00 00 00       	mov    $0x0,%edi
  8047d4:	48 b8 a8 2e 80 00 00 	movabs $0x802ea8,%rax
  8047db:	00 00 00 
  8047de:	ff d0                	callq  *%rax
  8047e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8047e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047e7:	79 05                	jns    8047ee <getchar+0x33>
  8047e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8047ec:	eb 14                	jmp    804802 <getchar+0x47>
  8047ee:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8047f2:	7f 07                	jg     8047fb <getchar+0x40>
  8047f4:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  8047f9:	eb 07                	jmp    804802 <getchar+0x47>
  8047fb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  8047ff:	0f b6 c0             	movzbl %al,%eax
  804802:	c9                   	leaveq 
  804803:	c3                   	retq   

0000000000804804 <iscons>:
  804804:	55                   	push   %rbp
  804805:	48 89 e5             	mov    %rsp,%rbp
  804808:	48 83 ec 20          	sub    $0x20,%rsp
  80480c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80480f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  804813:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804816:	48 89 d6             	mov    %rdx,%rsi
  804819:	89 c7                	mov    %eax,%edi
  80481b:	48 b8 76 2a 80 00 00 	movabs $0x802a76,%rax
  804822:	00 00 00 
  804825:	ff d0                	callq  *%rax
  804827:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80482a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80482e:	79 05                	jns    804835 <iscons+0x31>
  804830:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804833:	eb 1a                	jmp    80484f <iscons+0x4b>
  804835:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804839:	8b 10                	mov    (%rax),%edx
  80483b:	48 b8 20 71 80 00 00 	movabs $0x807120,%rax
  804842:	00 00 00 
  804845:	8b 00                	mov    (%rax),%eax
  804847:	39 c2                	cmp    %eax,%edx
  804849:	0f 94 c0             	sete   %al
  80484c:	0f b6 c0             	movzbl %al,%eax
  80484f:	c9                   	leaveq 
  804850:	c3                   	retq   

0000000000804851 <opencons>:
  804851:	55                   	push   %rbp
  804852:	48 89 e5             	mov    %rsp,%rbp
  804855:	48 83 ec 10          	sub    $0x10,%rsp
  804859:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  80485d:	48 89 c7             	mov    %rax,%rdi
  804860:	48 b8 de 29 80 00 00 	movabs $0x8029de,%rax
  804867:	00 00 00 
  80486a:	ff d0                	callq  *%rax
  80486c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80486f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804873:	79 05                	jns    80487a <opencons+0x29>
  804875:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804878:	eb 5b                	jmp    8048d5 <opencons+0x84>
  80487a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80487e:	ba 07 04 00 00       	mov    $0x407,%edx
  804883:	48 89 c6             	mov    %rax,%rsi
  804886:	bf 00 00 00 00       	mov    $0x0,%edi
  80488b:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  804892:	00 00 00 
  804895:	ff d0                	callq  *%rax
  804897:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80489a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80489e:	79 05                	jns    8048a5 <opencons+0x54>
  8048a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8048a3:	eb 30                	jmp    8048d5 <opencons+0x84>
  8048a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8048a9:	48 ba 20 71 80 00 00 	movabs $0x807120,%rdx
  8048b0:	00 00 00 
  8048b3:	8b 12                	mov    (%rdx),%edx
  8048b5:	89 10                	mov    %edx,(%rax)
  8048b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8048bb:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  8048c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8048c6:	48 89 c7             	mov    %rax,%rdi
  8048c9:	48 b8 90 29 80 00 00 	movabs $0x802990,%rax
  8048d0:	00 00 00 
  8048d3:	ff d0                	callq  *%rax
  8048d5:	c9                   	leaveq 
  8048d6:	c3                   	retq   

00000000008048d7 <devcons_read>:
  8048d7:	55                   	push   %rbp
  8048d8:	48 89 e5             	mov    %rsp,%rbp
  8048db:	48 83 ec 30          	sub    $0x30,%rsp
  8048df:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8048e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8048e7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8048eb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8048f0:	75 07                	jne    8048f9 <devcons_read+0x22>
  8048f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8048f7:	eb 4b                	jmp    804944 <devcons_read+0x6d>
  8048f9:	eb 0c                	jmp    804907 <devcons_read+0x30>
  8048fb:	48 b8 1f 1d 80 00 00 	movabs $0x801d1f,%rax
  804902:	00 00 00 
  804905:	ff d0                	callq  *%rax
  804907:	48 b8 5f 1c 80 00 00 	movabs $0x801c5f,%rax
  80490e:	00 00 00 
  804911:	ff d0                	callq  *%rax
  804913:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804916:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80491a:	74 df                	je     8048fb <devcons_read+0x24>
  80491c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804920:	79 05                	jns    804927 <devcons_read+0x50>
  804922:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804925:	eb 1d                	jmp    804944 <devcons_read+0x6d>
  804927:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  80492b:	75 07                	jne    804934 <devcons_read+0x5d>
  80492d:	b8 00 00 00 00       	mov    $0x0,%eax
  804932:	eb 10                	jmp    804944 <devcons_read+0x6d>
  804934:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804937:	89 c2                	mov    %eax,%edx
  804939:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80493d:	88 10                	mov    %dl,(%rax)
  80493f:	b8 01 00 00 00       	mov    $0x1,%eax
  804944:	c9                   	leaveq 
  804945:	c3                   	retq   

0000000000804946 <devcons_write>:
  804946:	55                   	push   %rbp
  804947:	48 89 e5             	mov    %rsp,%rbp
  80494a:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  804951:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  804958:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  80495f:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  804966:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  80496d:	eb 76                	jmp    8049e5 <devcons_write+0x9f>
  80496f:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  804976:	89 c2                	mov    %eax,%edx
  804978:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80497b:	29 c2                	sub    %eax,%edx
  80497d:	89 d0                	mov    %edx,%eax
  80497f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  804982:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804985:	83 f8 7f             	cmp    $0x7f,%eax
  804988:	76 07                	jbe    804991 <devcons_write+0x4b>
  80498a:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  804991:	8b 45 f8             	mov    -0x8(%rbp),%eax
  804994:	48 63 d0             	movslq %eax,%rdx
  804997:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80499a:	48 63 c8             	movslq %eax,%rcx
  80499d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  8049a4:	48 01 c1             	add    %rax,%rcx
  8049a7:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8049ae:	48 89 ce             	mov    %rcx,%rsi
  8049b1:	48 89 c7             	mov    %rax,%rdi
  8049b4:	48 b8 52 17 80 00 00 	movabs $0x801752,%rax
  8049bb:	00 00 00 
  8049be:	ff d0                	callq  *%rax
  8049c0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8049c3:	48 63 d0             	movslq %eax,%rdx
  8049c6:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  8049cd:	48 89 d6             	mov    %rdx,%rsi
  8049d0:	48 89 c7             	mov    %rax,%rdi
  8049d3:	48 b8 15 1c 80 00 00 	movabs $0x801c15,%rax
  8049da:	00 00 00 
  8049dd:	ff d0                	callq  *%rax
  8049df:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8049e2:	01 45 fc             	add    %eax,-0x4(%rbp)
  8049e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049e8:	48 98                	cltq   
  8049ea:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  8049f1:	0f 82 78 ff ff ff    	jb     80496f <devcons_write+0x29>
  8049f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8049fa:	c9                   	leaveq 
  8049fb:	c3                   	retq   

00000000008049fc <devcons_close>:
  8049fc:	55                   	push   %rbp
  8049fd:	48 89 e5             	mov    %rsp,%rbp
  804a00:	48 83 ec 08          	sub    $0x8,%rsp
  804a04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804a08:	b8 00 00 00 00       	mov    $0x0,%eax
  804a0d:	c9                   	leaveq 
  804a0e:	c3                   	retq   

0000000000804a0f <devcons_stat>:
  804a0f:	55                   	push   %rbp
  804a10:	48 89 e5             	mov    %rsp,%rbp
  804a13:	48 83 ec 10          	sub    $0x10,%rsp
  804a17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804a1b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  804a1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  804a23:	48 be c2 55 80 00 00 	movabs $0x8055c2,%rsi
  804a2a:	00 00 00 
  804a2d:	48 89 c7             	mov    %rax,%rdi
  804a30:	48 b8 2e 14 80 00 00 	movabs $0x80142e,%rax
  804a37:	00 00 00 
  804a3a:	ff d0                	callq  *%rax
  804a3c:	b8 00 00 00 00       	mov    $0x0,%eax
  804a41:	c9                   	leaveq 
  804a42:	c3                   	retq   

0000000000804a43 <set_pgfault_handler>:
  804a43:	55                   	push   %rbp
  804a44:	48 89 e5             	mov    %rsp,%rbp
  804a47:	48 83 ec 20          	sub    $0x20,%rsp
  804a4b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804a4f:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804a56:	00 00 00 
  804a59:	48 8b 00             	mov    (%rax),%rax
  804a5c:	48 85 c0             	test   %rax,%rax
  804a5f:	75 6f                	jne    804ad0 <set_pgfault_handler+0x8d>
  804a61:	ba 07 00 00 00       	mov    $0x7,%edx
  804a66:	be 00 f0 7f ef       	mov    $0xef7ff000,%esi
  804a6b:	bf 00 00 00 00       	mov    $0x0,%edi
  804a70:	48 b8 5d 1d 80 00 00 	movabs $0x801d5d,%rax
  804a77:	00 00 00 
  804a7a:	ff d0                	callq  *%rax
  804a7c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804a7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804a83:	79 30                	jns    804ab5 <set_pgfault_handler+0x72>
  804a85:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804a88:	89 c1                	mov    %eax,%ecx
  804a8a:	48 ba d0 55 80 00 00 	movabs $0x8055d0,%rdx
  804a91:	00 00 00 
  804a94:	be 22 00 00 00       	mov    $0x22,%esi
  804a99:	48 bf ef 55 80 00 00 	movabs $0x8055ef,%rdi
  804aa0:	00 00 00 
  804aa3:	b8 00 00 00 00       	mov    $0x0,%eax
  804aa8:	49 b8 40 06 80 00 00 	movabs $0x800640,%r8
  804aaf:	00 00 00 
  804ab2:	41 ff d0             	callq  *%r8
  804ab5:	48 be e3 4a 80 00 00 	movabs $0x804ae3,%rsi
  804abc:	00 00 00 
  804abf:	bf 00 00 00 00       	mov    $0x0,%edi
  804ac4:	48 b8 e7 1e 80 00 00 	movabs $0x801ee7,%rax
  804acb:	00 00 00 
  804ace:	ff d0                	callq  *%rax
  804ad0:	48 b8 00 c0 80 00 00 	movabs $0x80c000,%rax
  804ad7:	00 00 00 
  804ada:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  804ade:	48 89 10             	mov    %rdx,(%rax)
  804ae1:	c9                   	leaveq 
  804ae2:	c3                   	retq   

0000000000804ae3 <_pgfault_upcall>:
.globl _pgfault_upcall
_pgfault_upcall:
// Call the C page fault handler.
// function argument: pointer to UTF

movq  %rsp,%rdi                // passing the function argument in rdi
  804ae3:	48 89 e7             	mov    %rsp,%rdi
movabs _pgfault_handler, %rax
  804ae6:	48 a1 00 c0 80 00 00 	movabs 0x80c000,%rax
  804aed:	00 00 00 
call *%rax
  804af0:	ff d0                	callq  *%rax
// registers are available for intermediate calculations.  You
// may find that you have to rearrange your code in non-obvious
// ways as registers become unavailable as scratch space.
//
// LAB 4: Your code here.
subq $8, 152(%rsp)
  804af2:	48 83 ac 24 98 00 00 	subq   $0x8,0x98(%rsp)
  804af9:	00 08 
    movq 152(%rsp), %rax
  804afb:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  804b02:	00 
    movq 136(%rsp), %rbx
  804b03:	48 8b 9c 24 88 00 00 	mov    0x88(%rsp),%rbx
  804b0a:	00 
movq %rbx, (%rax)
  804b0b:	48 89 18             	mov    %rbx,(%rax)

    // Restore the trap-time registers.  After you do this, you
    // can no longer modify any general-purpose registers.
    // LAB 4: Your code here.
    addq $16, %rsp
  804b0e:	48 83 c4 10          	add    $0x10,%rsp
    POPA_
  804b12:	4c 8b 3c 24          	mov    (%rsp),%r15
  804b16:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  804b1b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
  804b20:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  804b25:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  804b2a:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
  804b2f:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
  804b34:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
  804b39:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  804b3e:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  804b43:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
  804b48:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
  804b4d:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
  804b52:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
  804b57:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  804b5c:	48 83 c4 78          	add    $0x78,%rsp

    // Restore eflags from the stack.  After you do this, you can
    // no longer use arithmetic operations or anything else that
    // modifies eflags.
    // LAB 4: Your code here.
pushq 8(%rsp)
  804b60:	ff 74 24 08          	pushq  0x8(%rsp)
    popfq
  804b64:	9d                   	popfq  

    // Switch back to the adjusted trap-time stack.
    // LAB 4: Your code here.
    movq 16(%rsp), %rsp
  804b65:	48 8b 64 24 10       	mov    0x10(%rsp),%rsp

    // Return to re-execute the instruction that faulted.
    // LAB 4: Your code here.
    retq
  804b6a:	c3                   	retq   

0000000000804b6b <pageref>:
  804b6b:	55                   	push   %rbp
  804b6c:	48 89 e5             	mov    %rsp,%rbp
  804b6f:	48 83 ec 18          	sub    $0x18,%rsp
  804b73:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804b77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804b7b:	48 c1 e8 15          	shr    $0x15,%rax
  804b7f:	48 89 c2             	mov    %rax,%rdx
  804b82:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804b89:	01 00 00 
  804b8c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804b90:	83 e0 01             	and    $0x1,%eax
  804b93:	48 85 c0             	test   %rax,%rax
  804b96:	75 07                	jne    804b9f <pageref+0x34>
  804b98:	b8 00 00 00 00       	mov    $0x0,%eax
  804b9d:	eb 53                	jmp    804bf2 <pageref+0x87>
  804b9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804ba3:	48 c1 e8 0c          	shr    $0xc,%rax
  804ba7:	48 89 c2             	mov    %rax,%rdx
  804baa:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804bb1:	01 00 00 
  804bb4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804bb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  804bbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804bc0:	83 e0 01             	and    $0x1,%eax
  804bc3:	48 85 c0             	test   %rax,%rax
  804bc6:	75 07                	jne    804bcf <pageref+0x64>
  804bc8:	b8 00 00 00 00       	mov    $0x0,%eax
  804bcd:	eb 23                	jmp    804bf2 <pageref+0x87>
  804bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804bd3:	48 c1 e8 0c          	shr    $0xc,%rax
  804bd7:	48 89 c2             	mov    %rax,%rdx
  804bda:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  804be1:	00 00 00 
  804be4:	48 c1 e2 04          	shl    $0x4,%rdx
  804be8:	48 01 d0             	add    %rdx,%rax
  804beb:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  804bef:	0f b7 c0             	movzwl %ax,%eax
  804bf2:	c9                   	leaveq 
  804bf3:	c3                   	retq   
