
vmm/guest/obj/user/vmm:     file format elf64-x86-64


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
  80003c:	e8 d1 01 00 00       	callq  800212 <libmain>
1:	jmp 1b
  800041:	eb fe                	jmp    800041 <args_exist+0xe>

0000000000800043 <map_in_guest>:
// Return 0 on success, <0 on failure.
//
// Hint: Call sys_ept_map() for mapping page. 
static int
map_in_guest( envid_t guest, uintptr_t gpa, size_t memsz, 
	      int fd, size_t filesz, off_t fileoffset ) {
  800043:	55                   	push   %rbp
  800044:	48 89 e5             	mov    %rsp,%rbp
  800047:	48 83 ec 24          	sub    $0x24,%rsp
  80004b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80004e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800052:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800056:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  800059:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  80005d:	44 89 4d dc          	mov    %r9d,-0x24(%rbp)
	/* Your code here */
	return -E_NO_SYS;
  800061:	b8 f9 ff ff ff       	mov    $0xfffffff9,%eax
} 
  800066:	c9                   	leaveq 
  800067:	c3                   	retq   

0000000000800068 <copy_guest_kern_gpa>:
//
// Return 0 on success, <0 on error
//
// Hint: compare with ELF parsing in env.c, and use map_in_guest for each segment.
static int
copy_guest_kern_gpa( envid_t guest, char* fname ) {
  800068:	55                   	push   %rbp
  800069:	48 89 e5             	mov    %rsp,%rbp
  80006c:	48 83 ec 10          	sub    $0x10,%rsp
  800070:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800073:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	/* Your code here */
	return -E_NO_SYS;
  800077:	b8 f9 ff ff ff       	mov    $0xfffffff9,%eax
}
  80007c:	c9                   	leaveq 
  80007d:	c3                   	retq   

000000000080007e <umain>:

void
umain(int argc, char **argv) {
  80007e:	55                   	push   %rbp
  80007f:	48 89 e5             	mov    %rsp,%rbp
  800082:	48 83 ec 50          	sub    $0x50,%rsp
  800086:	89 7d bc             	mov    %edi,-0x44(%rbp)
  800089:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
	int ret;
	envid_t guest;
	char filename_buffer[50];	//buffer to save the path 
	int vmdisk_number;
	int r;
	if ((ret = sys_env_mkguest( GUEST_MEM_SZ, JOS_ENTRY )) < 0) {
  80008d:	be 00 70 00 00       	mov    $0x7000,%esi
  800092:	bf 00 00 00 01       	mov    $0x1000000,%edi
  800097:	48 b8 57 1c 80 00 00 	movabs $0x801c57,%rax
  80009e:	00 00 00 
  8000a1:	ff d0                	callq  *%rax
  8000a3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8000a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8000aa:	79 2c                	jns    8000d8 <umain+0x5a>
		cprintf("Error creating a guest OS env: %e\n", ret );
  8000ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000af:	89 c6                	mov    %eax,%esi
  8000b1:	48 bf e0 41 80 00 00 	movabs $0x8041e0,%rdi
  8000b8:	00 00 00 
  8000bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c0:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  8000c7:	00 00 00 
  8000ca:	ff d2                	callq  *%rdx
		exit();
  8000cc:	48 b8 95 02 80 00 00 	movabs $0x800295,%rax
  8000d3:	00 00 00 
  8000d6:	ff d0                	callq  *%rax
	}
	guest = ret;
  8000d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8000db:	89 45 f8             	mov    %eax,-0x8(%rbp)

	// Copy the guest kernel code into guest phys mem.
	if((ret = copy_guest_kern_gpa(guest, GUEST_KERN)) < 0) {
  8000de:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8000e1:	48 be 03 42 80 00 00 	movabs $0x804203,%rsi
  8000e8:	00 00 00 
  8000eb:	89 c7                	mov    %eax,%edi
  8000ed:	48 b8 68 00 80 00 00 	movabs $0x800068,%rax
  8000f4:	00 00 00 
  8000f7:	ff d0                	callq  *%rax
  8000f9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8000fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800100:	79 2c                	jns    80012e <umain+0xb0>
		cprintf("Error copying page into the guest - %d\n.", ret);
  800102:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800105:	89 c6                	mov    %eax,%esi
  800107:	48 bf 10 42 80 00 00 	movabs $0x804210,%rdi
  80010e:	00 00 00 
  800111:	b8 00 00 00 00       	mov    $0x0,%eax
  800116:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  80011d:	00 00 00 
  800120:	ff d2                	callq  *%rdx
		exit();
  800122:	48 b8 95 02 80 00 00 	movabs $0x800295,%rax
  800129:	00 00 00 
  80012c:	ff d0                	callq  *%rax
	}

	// Now copy the bootloader.
	int fd;
	if ((fd = open( GUEST_BOOT, O_RDONLY)) < 0 ) {
  80012e:	be 00 00 00 00       	mov    $0x0,%esi
  800133:	48 bf 39 42 80 00 00 	movabs $0x804239,%rdi
  80013a:	00 00 00 
  80013d:	48 b8 8f 26 80 00 00 	movabs $0x80268f,%rax
  800144:	00 00 00 
  800147:	ff d0                	callq  *%rax
  800149:	89 45 f4             	mov    %eax,-0xc(%rbp)
  80014c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  800150:	79 36                	jns    800188 <umain+0x10a>
		cprintf("open %s for read: %e\n", GUEST_BOOT, fd );
  800152:	8b 45 f4             	mov    -0xc(%rbp),%eax
  800155:	89 c2                	mov    %eax,%edx
  800157:	48 be 39 42 80 00 00 	movabs $0x804239,%rsi
  80015e:	00 00 00 
  800161:	48 bf 43 42 80 00 00 	movabs $0x804243,%rdi
  800168:	00 00 00 
  80016b:	b8 00 00 00 00       	mov    $0x0,%eax
  800170:	48 b9 dd 03 80 00 00 	movabs $0x8003dd,%rcx
  800177:	00 00 00 
  80017a:	ff d1                	callq  *%rcx
		exit();
  80017c:	48 b8 95 02 80 00 00 	movabs $0x800295,%rax
  800183:	00 00 00 
  800186:	ff d0                	callq  *%rax
	}

	// sizeof(bootloader) < 512.
	if ((ret = map_in_guest(guest, JOS_ENTRY, 512, fd, 512, 0)) < 0) {
  800188:	8b 55 f4             	mov    -0xc(%rbp),%edx
  80018b:	8b 45 f8             	mov    -0x8(%rbp),%eax
  80018e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  800194:	41 b8 00 02 00 00    	mov    $0x200,%r8d
  80019a:	89 d1                	mov    %edx,%ecx
  80019c:	ba 00 02 00 00       	mov    $0x200,%edx
  8001a1:	be 00 70 00 00       	mov    $0x7000,%esi
  8001a6:	89 c7                	mov    %eax,%edi
  8001a8:	48 b8 43 00 80 00 00 	movabs $0x800043,%rax
  8001af:	00 00 00 
  8001b2:	ff d0                	callq  *%rax
  8001b4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8001b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8001bb:	79 2c                	jns    8001e9 <umain+0x16b>
		cprintf("Error mapping bootloader into the guest - %d\n.", ret);
  8001bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8001c0:	89 c6                	mov    %eax,%esi
  8001c2:	48 bf 60 42 80 00 00 	movabs $0x804260,%rdi
  8001c9:	00 00 00 
  8001cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8001d1:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  8001d8:	00 00 00 
  8001db:	ff d2                	callq  *%rdx
		exit();
  8001dd:	48 b8 95 02 80 00 00 	movabs $0x800295,%rax
  8001e4:	00 00 00 
  8001e7:	ff d0                	callq  *%rax
        }
        
        cprintf("Create VHD finished\n");
#endif
	// Mark the guest as runnable.
	sys_env_set_status(guest, ENV_RUNNABLE);
  8001e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8001ec:	be 02 00 00 00       	mov    $0x2,%esi
  8001f1:	89 c7                	mov    %eax,%edi
  8001f3:	48 b8 b6 19 80 00 00 	movabs $0x8019b6,%rax
  8001fa:	00 00 00 
  8001fd:	ff d0                	callq  *%rax
	wait(guest);
  8001ff:	8b 45 f8             	mov    -0x8(%rbp),%eax
  800202:	89 c7                	mov    %eax,%edi
  800204:	48 b8 a1 3a 80 00 00 	movabs $0x803aa1,%rax
  80020b:	00 00 00 
  80020e:	ff d0                	callq  *%rax
}
  800210:	c9                   	leaveq 
  800211:	c3                   	retq   

0000000000800212 <libmain>:
  800212:	55                   	push   %rbp
  800213:	48 89 e5             	mov    %rsp,%rbp
  800216:	48 83 ec 10          	sub    $0x10,%rsp
  80021a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80021d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800221:	48 b8 45 18 80 00 00 	movabs $0x801845,%rax
  800228:	00 00 00 
  80022b:	ff d0                	callq  *%rax
  80022d:	25 ff 03 00 00       	and    $0x3ff,%eax
  800232:	48 98                	cltq   
  800234:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  80023b:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  800242:	00 00 00 
  800245:	48 01 c2             	add    %rax,%rdx
  800248:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80024f:	00 00 00 
  800252:	48 89 10             	mov    %rdx,(%rax)
  800255:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  800259:	7e 14                	jle    80026f <libmain+0x5d>
  80025b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80025f:	48 8b 10             	mov    (%rax),%rdx
  800262:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  800269:	00 00 00 
  80026c:	48 89 10             	mov    %rdx,(%rax)
  80026f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800273:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800276:	48 89 d6             	mov    %rdx,%rsi
  800279:	89 c7                	mov    %eax,%edi
  80027b:	48 b8 7e 00 80 00 00 	movabs $0x80007e,%rax
  800282:	00 00 00 
  800285:	ff d0                	callq  *%rax
  800287:	48 b8 95 02 80 00 00 	movabs $0x800295,%rax
  80028e:	00 00 00 
  800291:	ff d0                	callq  *%rax
  800293:	c9                   	leaveq 
  800294:	c3                   	retq   

0000000000800295 <exit>:
  800295:	55                   	push   %rbp
  800296:	48 89 e5             	mov    %rsp,%rbp
  800299:	48 b8 e2 1f 80 00 00 	movabs $0x801fe2,%rax
  8002a0:	00 00 00 
  8002a3:	ff d0                	callq  *%rax
  8002a5:	bf 00 00 00 00       	mov    $0x0,%edi
  8002aa:	48 b8 01 18 80 00 00 	movabs $0x801801,%rax
  8002b1:	00 00 00 
  8002b4:	ff d0                	callq  *%rax
  8002b6:	5d                   	pop    %rbp
  8002b7:	c3                   	retq   

00000000008002b8 <putch>:
  8002b8:	55                   	push   %rbp
  8002b9:	48 89 e5             	mov    %rsp,%rbp
  8002bc:	48 83 ec 10          	sub    $0x10,%rsp
  8002c0:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8002c3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8002c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002cb:	8b 00                	mov    (%rax),%eax
  8002cd:	8d 48 01             	lea    0x1(%rax),%ecx
  8002d0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002d4:	89 0a                	mov    %ecx,(%rdx)
  8002d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8002d9:	89 d1                	mov    %edx,%ecx
  8002db:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002df:	48 98                	cltq   
  8002e1:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8002e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002e9:	8b 00                	mov    (%rax),%eax
  8002eb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002f0:	75 2c                	jne    80031e <putch+0x66>
  8002f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8002f6:	8b 00                	mov    (%rax),%eax
  8002f8:	48 98                	cltq   
  8002fa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8002fe:	48 83 c2 08          	add    $0x8,%rdx
  800302:	48 89 c6             	mov    %rax,%rsi
  800305:	48 89 d7             	mov    %rdx,%rdi
  800308:	48 b8 79 17 80 00 00 	movabs $0x801779,%rax
  80030f:	00 00 00 
  800312:	ff d0                	callq  *%rax
  800314:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800318:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  80031e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800322:	8b 40 04             	mov    0x4(%rax),%eax
  800325:	8d 50 01             	lea    0x1(%rax),%edx
  800328:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80032c:	89 50 04             	mov    %edx,0x4(%rax)
  80032f:	c9                   	leaveq 
  800330:	c3                   	retq   

0000000000800331 <vcprintf>:
  800331:	55                   	push   %rbp
  800332:	48 89 e5             	mov    %rsp,%rbp
  800335:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  80033c:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
  800343:	48 89 b5 c0 fe ff ff 	mov    %rsi,-0x140(%rbp)
  80034a:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
  800351:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  800358:	48 8b 0a             	mov    (%rdx),%rcx
  80035b:	48 89 08             	mov    %rcx,(%rax)
  80035e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800362:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800366:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  80036a:	48 89 50 10          	mov    %rdx,0x10(%rax)
  80036e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%rbp)
  800375:	00 00 00 
  800378:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%rbp)
  80037f:	00 00 00 
  800382:	48 8d 8d d8 fe ff ff 	lea    -0x128(%rbp),%rcx
  800389:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
  800390:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
  800397:	48 89 c6             	mov    %rax,%rsi
  80039a:	48 bf b8 02 80 00 00 	movabs $0x8002b8,%rdi
  8003a1:	00 00 00 
  8003a4:	48 b8 90 07 80 00 00 	movabs $0x800790,%rax
  8003ab:	00 00 00 
  8003ae:	ff d0                	callq  *%rax
  8003b0:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
  8003b6:	48 98                	cltq   
  8003b8:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
  8003bf:	48 83 c2 08          	add    $0x8,%rdx
  8003c3:	48 89 c6             	mov    %rax,%rsi
  8003c6:	48 89 d7             	mov    %rdx,%rdi
  8003c9:	48 b8 79 17 80 00 00 	movabs $0x801779,%rax
  8003d0:	00 00 00 
  8003d3:	ff d0                	callq  *%rax
  8003d5:	8b 85 f4 fe ff ff    	mov    -0x10c(%rbp),%eax
  8003db:	c9                   	leaveq 
  8003dc:	c3                   	retq   

00000000008003dd <cprintf>:
  8003dd:	55                   	push   %rbp
  8003de:	48 89 e5             	mov    %rsp,%rbp
  8003e1:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  8003e8:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  8003ef:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8003f6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  8003fd:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800404:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  80040b:	84 c0                	test   %al,%al
  80040d:	74 20                	je     80042f <cprintf+0x52>
  80040f:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800413:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800417:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  80041b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  80041f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800423:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800427:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  80042b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  80042f:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800436:	c7 85 30 ff ff ff 08 	movl   $0x8,-0xd0(%rbp)
  80043d:	00 00 00 
  800440:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800447:	00 00 00 
  80044a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80044e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800455:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  80045c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800463:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  80046a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800471:	48 8b 0a             	mov    (%rdx),%rcx
  800474:	48 89 08             	mov    %rcx,(%rax)
  800477:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  80047b:	48 89 48 08          	mov    %rcx,0x8(%rax)
  80047f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800483:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800487:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
  80048e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800495:	48 89 d6             	mov    %rdx,%rsi
  800498:	48 89 c7             	mov    %rax,%rdi
  80049b:	48 b8 31 03 80 00 00 	movabs $0x800331,%rax
  8004a2:	00 00 00 
  8004a5:	ff d0                	callq  *%rax
  8004a7:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8004ad:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8004b3:	c9                   	leaveq 
  8004b4:	c3                   	retq   

00000000008004b5 <printnum>:
  8004b5:	55                   	push   %rbp
  8004b6:	48 89 e5             	mov    %rsp,%rbp
  8004b9:	53                   	push   %rbx
  8004ba:	48 83 ec 38          	sub    $0x38,%rsp
  8004be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8004c2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8004c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8004ca:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
  8004cd:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  8004d1:	44 89 4d cc          	mov    %r9d,-0x34(%rbp)
  8004d5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  8004d8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8004dc:	77 3b                	ja     800519 <printnum+0x64>
  8004de:	8b 45 d0             	mov    -0x30(%rbp),%eax
  8004e1:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
  8004e5:	8b 5d d4             	mov    -0x2c(%rbp),%ebx
  8004e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8004ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8004f1:	48 f7 f3             	div    %rbx
  8004f4:	48 89 c2             	mov    %rax,%rdx
  8004f7:	8b 7d cc             	mov    -0x34(%rbp),%edi
  8004fa:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8004fd:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  800501:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800505:	41 89 f9             	mov    %edi,%r9d
  800508:	48 89 c7             	mov    %rax,%rdi
  80050b:	48 b8 b5 04 80 00 00 	movabs $0x8004b5,%rax
  800512:	00 00 00 
  800515:	ff d0                	callq  *%rax
  800517:	eb 1e                	jmp    800537 <printnum+0x82>
  800519:	eb 12                	jmp    80052d <printnum+0x78>
  80051b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80051f:	8b 55 cc             	mov    -0x34(%rbp),%edx
  800522:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800526:	48 89 ce             	mov    %rcx,%rsi
  800529:	89 d7                	mov    %edx,%edi
  80052b:	ff d0                	callq  *%rax
  80052d:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
  800531:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  800535:	7f e4                	jg     80051b <printnum+0x66>
  800537:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80053a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80053e:	ba 00 00 00 00       	mov    $0x0,%edx
  800543:	48 f7 f1             	div    %rcx
  800546:	48 89 d0             	mov    %rdx,%rax
  800549:	48 ba 90 44 80 00 00 	movabs $0x804490,%rdx
  800550:	00 00 00 
  800553:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  800557:	0f be d0             	movsbl %al,%edx
  80055a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  80055e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800562:	48 89 ce             	mov    %rcx,%rsi
  800565:	89 d7                	mov    %edx,%edi
  800567:	ff d0                	callq  *%rax
  800569:	48 83 c4 38          	add    $0x38,%rsp
  80056d:	5b                   	pop    %rbx
  80056e:	5d                   	pop    %rbp
  80056f:	c3                   	retq   

0000000000800570 <getuint>:
  800570:	55                   	push   %rbp
  800571:	48 89 e5             	mov    %rsp,%rbp
  800574:	48 83 ec 1c          	sub    $0x1c,%rsp
  800578:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80057c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80057f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800583:	7e 52                	jle    8005d7 <getuint+0x67>
  800585:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800589:	8b 00                	mov    (%rax),%eax
  80058b:	83 f8 30             	cmp    $0x30,%eax
  80058e:	73 24                	jae    8005b4 <getuint+0x44>
  800590:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800594:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800598:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80059c:	8b 00                	mov    (%rax),%eax
  80059e:	89 c0                	mov    %eax,%eax
  8005a0:	48 01 d0             	add    %rdx,%rax
  8005a3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005a7:	8b 12                	mov    (%rdx),%edx
  8005a9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8005ac:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005b0:	89 0a                	mov    %ecx,(%rdx)
  8005b2:	eb 17                	jmp    8005cb <getuint+0x5b>
  8005b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005b8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8005bc:	48 89 d0             	mov    %rdx,%rax
  8005bf:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8005c3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8005cb:	48 8b 00             	mov    (%rax),%rax
  8005ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8005d2:	e9 a3 00 00 00       	jmpq   80067a <getuint+0x10a>
  8005d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8005db:	74 4f                	je     80062c <getuint+0xbc>
  8005dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005e1:	8b 00                	mov    (%rax),%eax
  8005e3:	83 f8 30             	cmp    $0x30,%eax
  8005e6:	73 24                	jae    80060c <getuint+0x9c>
  8005e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8005f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8005f4:	8b 00                	mov    (%rax),%eax
  8005f6:	89 c0                	mov    %eax,%eax
  8005f8:	48 01 d0             	add    %rdx,%rax
  8005fb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8005ff:	8b 12                	mov    (%rdx),%edx
  800601:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800604:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800608:	89 0a                	mov    %ecx,(%rdx)
  80060a:	eb 17                	jmp    800623 <getuint+0xb3>
  80060c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800610:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800614:	48 89 d0             	mov    %rdx,%rax
  800617:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80061b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80061f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800623:	48 8b 00             	mov    (%rax),%rax
  800626:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80062a:	eb 4e                	jmp    80067a <getuint+0x10a>
  80062c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800630:	8b 00                	mov    (%rax),%eax
  800632:	83 f8 30             	cmp    $0x30,%eax
  800635:	73 24                	jae    80065b <getuint+0xeb>
  800637:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80063b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80063f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800643:	8b 00                	mov    (%rax),%eax
  800645:	89 c0                	mov    %eax,%eax
  800647:	48 01 d0             	add    %rdx,%rax
  80064a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80064e:	8b 12                	mov    (%rdx),%edx
  800650:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800653:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800657:	89 0a                	mov    %ecx,(%rdx)
  800659:	eb 17                	jmp    800672 <getuint+0x102>
  80065b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80065f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800663:	48 89 d0             	mov    %rdx,%rax
  800666:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80066a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80066e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800672:	8b 00                	mov    (%rax),%eax
  800674:	89 c0                	mov    %eax,%eax
  800676:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80067a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80067e:	c9                   	leaveq 
  80067f:	c3                   	retq   

0000000000800680 <getint>:
  800680:	55                   	push   %rbp
  800681:	48 89 e5             	mov    %rsp,%rbp
  800684:	48 83 ec 1c          	sub    $0x1c,%rsp
  800688:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80068c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80068f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800693:	7e 52                	jle    8006e7 <getint+0x67>
  800695:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800699:	8b 00                	mov    (%rax),%eax
  80069b:	83 f8 30             	cmp    $0x30,%eax
  80069e:	73 24                	jae    8006c4 <getint+0x44>
  8006a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8006a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006ac:	8b 00                	mov    (%rax),%eax
  8006ae:	89 c0                	mov    %eax,%eax
  8006b0:	48 01 d0             	add    %rdx,%rax
  8006b3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006b7:	8b 12                	mov    (%rdx),%edx
  8006b9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8006bc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006c0:	89 0a                	mov    %ecx,(%rdx)
  8006c2:	eb 17                	jmp    8006db <getint+0x5b>
  8006c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006c8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  8006cc:	48 89 d0             	mov    %rdx,%rax
  8006cf:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  8006d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8006d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8006db:	48 8b 00             	mov    (%rax),%rax
  8006de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8006e2:	e9 a3 00 00 00       	jmpq   80078a <getint+0x10a>
  8006e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8006eb:	74 4f                	je     80073c <getint+0xbc>
  8006ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006f1:	8b 00                	mov    (%rax),%eax
  8006f3:	83 f8 30             	cmp    $0x30,%eax
  8006f6:	73 24                	jae    80071c <getint+0x9c>
  8006f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8006fc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  800700:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800704:	8b 00                	mov    (%rax),%eax
  800706:	89 c0                	mov    %eax,%eax
  800708:	48 01 d0             	add    %rdx,%rax
  80070b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80070f:	8b 12                	mov    (%rdx),%edx
  800711:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800714:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800718:	89 0a                	mov    %ecx,(%rdx)
  80071a:	eb 17                	jmp    800733 <getint+0xb3>
  80071c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800720:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800724:	48 89 d0             	mov    %rdx,%rax
  800727:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80072b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80072f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800733:	48 8b 00             	mov    (%rax),%rax
  800736:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80073a:	eb 4e                	jmp    80078a <getint+0x10a>
  80073c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800740:	8b 00                	mov    (%rax),%eax
  800742:	83 f8 30             	cmp    $0x30,%eax
  800745:	73 24                	jae    80076b <getint+0xeb>
  800747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80074b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80074f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800753:	8b 00                	mov    (%rax),%eax
  800755:	89 c0                	mov    %eax,%eax
  800757:	48 01 d0             	add    %rdx,%rax
  80075a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80075e:	8b 12                	mov    (%rdx),%edx
  800760:	8d 4a 08             	lea    0x8(%rdx),%ecx
  800763:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800767:	89 0a                	mov    %ecx,(%rdx)
  800769:	eb 17                	jmp    800782 <getint+0x102>
  80076b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80076f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  800773:	48 89 d0             	mov    %rdx,%rax
  800776:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  80077a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80077e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  800782:	8b 00                	mov    (%rax),%eax
  800784:	48 98                	cltq   
  800786:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80078a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80078e:	c9                   	leaveq 
  80078f:	c3                   	retq   

0000000000800790 <vprintfmt>:
  800790:	55                   	push   %rbp
  800791:	48 89 e5             	mov    %rsp,%rbp
  800794:	41 54                	push   %r12
  800796:	53                   	push   %rbx
  800797:	48 83 ec 60          	sub    $0x60,%rsp
  80079b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  80079f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  8007a3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8007a7:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
  8007ab:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  8007af:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
  8007b3:	48 8b 0a             	mov    (%rdx),%rcx
  8007b6:	48 89 08             	mov    %rcx,(%rax)
  8007b9:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  8007bd:	48 89 48 08          	mov    %rcx,0x8(%rax)
  8007c1:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  8007c5:	48 89 50 10          	mov    %rdx,0x10(%rax)
  8007c9:	eb 17                	jmp    8007e2 <vprintfmt+0x52>
  8007cb:	85 db                	test   %ebx,%ebx
  8007cd:	0f 84 cc 04 00 00    	je     800c9f <vprintfmt+0x50f>
  8007d3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  8007d7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8007db:	48 89 d6             	mov    %rdx,%rsi
  8007de:	89 df                	mov    %ebx,%edi
  8007e0:	ff d0                	callq  *%rax
  8007e2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8007e6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8007ea:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  8007ee:	0f b6 00             	movzbl (%rax),%eax
  8007f1:	0f b6 d8             	movzbl %al,%ebx
  8007f4:	83 fb 25             	cmp    $0x25,%ebx
  8007f7:	75 d2                	jne    8007cb <vprintfmt+0x3b>
  8007f9:	c6 45 d3 20          	movb   $0x20,-0x2d(%rbp)
  8007fd:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%rbp)
  800804:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  80080b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800812:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  800819:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80081d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800821:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  800825:	0f b6 00             	movzbl (%rax),%eax
  800828:	0f b6 d8             	movzbl %al,%ebx
  80082b:	8d 43 dd             	lea    -0x23(%rbx),%eax
  80082e:	83 f8 55             	cmp    $0x55,%eax
  800831:	0f 87 34 04 00 00    	ja     800c6b <vprintfmt+0x4db>
  800837:	89 c0                	mov    %eax,%eax
  800839:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800840:	00 
  800841:	48 b8 b8 44 80 00 00 	movabs $0x8044b8,%rax
  800848:	00 00 00 
  80084b:	48 01 d0             	add    %rdx,%rax
  80084e:	48 8b 00             	mov    (%rax),%rax
  800851:	ff e0                	jmpq   *%rax
  800853:	c6 45 d3 2d          	movb   $0x2d,-0x2d(%rbp)
  800857:	eb c0                	jmp    800819 <vprintfmt+0x89>
  800859:	c6 45 d3 30          	movb   $0x30,-0x2d(%rbp)
  80085d:	eb ba                	jmp    800819 <vprintfmt+0x89>
  80085f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
  800866:	8b 55 d8             	mov    -0x28(%rbp),%edx
  800869:	89 d0                	mov    %edx,%eax
  80086b:	c1 e0 02             	shl    $0x2,%eax
  80086e:	01 d0                	add    %edx,%eax
  800870:	01 c0                	add    %eax,%eax
  800872:	01 d8                	add    %ebx,%eax
  800874:	83 e8 30             	sub    $0x30,%eax
  800877:	89 45 d8             	mov    %eax,-0x28(%rbp)
  80087a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80087e:	0f b6 00             	movzbl (%rax),%eax
  800881:	0f be d8             	movsbl %al,%ebx
  800884:	83 fb 2f             	cmp    $0x2f,%ebx
  800887:	7e 0c                	jle    800895 <vprintfmt+0x105>
  800889:	83 fb 39             	cmp    $0x39,%ebx
  80088c:	7f 07                	jg     800895 <vprintfmt+0x105>
  80088e:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
  800893:	eb d1                	jmp    800866 <vprintfmt+0xd6>
  800895:	eb 58                	jmp    8008ef <vprintfmt+0x15f>
  800897:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80089a:	83 f8 30             	cmp    $0x30,%eax
  80089d:	73 17                	jae    8008b6 <vprintfmt+0x126>
  80089f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8008a3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  8008a6:	89 c0                	mov    %eax,%eax
  8008a8:	48 01 d0             	add    %rdx,%rax
  8008ab:	8b 55 b8             	mov    -0x48(%rbp),%edx
  8008ae:	83 c2 08             	add    $0x8,%edx
  8008b1:	89 55 b8             	mov    %edx,-0x48(%rbp)
  8008b4:	eb 0f                	jmp    8008c5 <vprintfmt+0x135>
  8008b6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  8008ba:	48 89 d0             	mov    %rdx,%rax
  8008bd:	48 83 c2 08          	add    $0x8,%rdx
  8008c1:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  8008c5:	8b 00                	mov    (%rax),%eax
  8008c7:	89 45 d8             	mov    %eax,-0x28(%rbp)
  8008ca:	eb 23                	jmp    8008ef <vprintfmt+0x15f>
  8008cc:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8008d0:	79 0c                	jns    8008de <vprintfmt+0x14e>
  8008d2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  8008d9:	e9 3b ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  8008de:	e9 36 ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  8008e3:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
  8008ea:	e9 2a ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  8008ef:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  8008f3:	79 12                	jns    800907 <vprintfmt+0x177>
  8008f5:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8008f8:	89 45 dc             	mov    %eax,-0x24(%rbp)
  8008fb:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  800902:	e9 12 ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  800907:	e9 0d ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  80090c:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  800910:	e9 04 ff ff ff       	jmpq   800819 <vprintfmt+0x89>
  800915:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800918:	83 f8 30             	cmp    $0x30,%eax
  80091b:	73 17                	jae    800934 <vprintfmt+0x1a4>
  80091d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800921:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800924:	89 c0                	mov    %eax,%eax
  800926:	48 01 d0             	add    %rdx,%rax
  800929:	8b 55 b8             	mov    -0x48(%rbp),%edx
  80092c:	83 c2 08             	add    $0x8,%edx
  80092f:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800932:	eb 0f                	jmp    800943 <vprintfmt+0x1b3>
  800934:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800938:	48 89 d0             	mov    %rdx,%rax
  80093b:	48 83 c2 08          	add    $0x8,%rdx
  80093f:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800943:	8b 10                	mov    (%rax),%edx
  800945:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800949:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  80094d:	48 89 ce             	mov    %rcx,%rsi
  800950:	89 d7                	mov    %edx,%edi
  800952:	ff d0                	callq  *%rax
  800954:	e9 40 03 00 00       	jmpq   800c99 <vprintfmt+0x509>
  800959:	8b 45 b8             	mov    -0x48(%rbp),%eax
  80095c:	83 f8 30             	cmp    $0x30,%eax
  80095f:	73 17                	jae    800978 <vprintfmt+0x1e8>
  800961:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800965:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800968:	89 c0                	mov    %eax,%eax
  80096a:	48 01 d0             	add    %rdx,%rax
  80096d:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800970:	83 c2 08             	add    $0x8,%edx
  800973:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800976:	eb 0f                	jmp    800987 <vprintfmt+0x1f7>
  800978:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  80097c:	48 89 d0             	mov    %rdx,%rax
  80097f:	48 83 c2 08          	add    $0x8,%rdx
  800983:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800987:	8b 18                	mov    (%rax),%ebx
  800989:	85 db                	test   %ebx,%ebx
  80098b:	79 02                	jns    80098f <vprintfmt+0x1ff>
  80098d:	f7 db                	neg    %ebx
  80098f:	83 fb 15             	cmp    $0x15,%ebx
  800992:	7f 16                	jg     8009aa <vprintfmt+0x21a>
  800994:	48 b8 e0 43 80 00 00 	movabs $0x8043e0,%rax
  80099b:	00 00 00 
  80099e:	48 63 d3             	movslq %ebx,%rdx
  8009a1:	4c 8b 24 d0          	mov    (%rax,%rdx,8),%r12
  8009a5:	4d 85 e4             	test   %r12,%r12
  8009a8:	75 2e                	jne    8009d8 <vprintfmt+0x248>
  8009aa:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8009ae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009b2:	89 d9                	mov    %ebx,%ecx
  8009b4:	48 ba a1 44 80 00 00 	movabs $0x8044a1,%rdx
  8009bb:	00 00 00 
  8009be:	48 89 c7             	mov    %rax,%rdi
  8009c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8009c6:	49 b8 a8 0c 80 00 00 	movabs $0x800ca8,%r8
  8009cd:	00 00 00 
  8009d0:	41 ff d0             	callq  *%r8
  8009d3:	e9 c1 02 00 00       	jmpq   800c99 <vprintfmt+0x509>
  8009d8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  8009dc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  8009e0:	4c 89 e1             	mov    %r12,%rcx
  8009e3:	48 ba aa 44 80 00 00 	movabs $0x8044aa,%rdx
  8009ea:	00 00 00 
  8009ed:	48 89 c7             	mov    %rax,%rdi
  8009f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8009f5:	49 b8 a8 0c 80 00 00 	movabs $0x800ca8,%r8
  8009fc:	00 00 00 
  8009ff:	41 ff d0             	callq  *%r8
  800a02:	e9 92 02 00 00       	jmpq   800c99 <vprintfmt+0x509>
  800a07:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a0a:	83 f8 30             	cmp    $0x30,%eax
  800a0d:	73 17                	jae    800a26 <vprintfmt+0x296>
  800a0f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800a13:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800a16:	89 c0                	mov    %eax,%eax
  800a18:	48 01 d0             	add    %rdx,%rax
  800a1b:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800a1e:	83 c2 08             	add    $0x8,%edx
  800a21:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800a24:	eb 0f                	jmp    800a35 <vprintfmt+0x2a5>
  800a26:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800a2a:	48 89 d0             	mov    %rdx,%rax
  800a2d:	48 83 c2 08          	add    $0x8,%rdx
  800a31:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800a35:	4c 8b 20             	mov    (%rax),%r12
  800a38:	4d 85 e4             	test   %r12,%r12
  800a3b:	75 0a                	jne    800a47 <vprintfmt+0x2b7>
  800a3d:	49 bc ad 44 80 00 00 	movabs $0x8044ad,%r12
  800a44:	00 00 00 
  800a47:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a4b:	7e 3f                	jle    800a8c <vprintfmt+0x2fc>
  800a4d:	80 7d d3 2d          	cmpb   $0x2d,-0x2d(%rbp)
  800a51:	74 39                	je     800a8c <vprintfmt+0x2fc>
  800a53:	8b 45 d8             	mov    -0x28(%rbp),%eax
  800a56:	48 98                	cltq   
  800a58:	48 89 c6             	mov    %rax,%rsi
  800a5b:	4c 89 e7             	mov    %r12,%rdi
  800a5e:	48 b8 54 0f 80 00 00 	movabs $0x800f54,%rax
  800a65:	00 00 00 
  800a68:	ff d0                	callq  *%rax
  800a6a:	29 45 dc             	sub    %eax,-0x24(%rbp)
  800a6d:	eb 17                	jmp    800a86 <vprintfmt+0x2f6>
  800a6f:	0f be 55 d3          	movsbl -0x2d(%rbp),%edx
  800a73:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  800a77:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800a7b:	48 89 ce             	mov    %rcx,%rsi
  800a7e:	89 d7                	mov    %edx,%edi
  800a80:	ff d0                	callq  *%rax
  800a82:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800a86:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800a8a:	7f e3                	jg     800a6f <vprintfmt+0x2df>
  800a8c:	eb 37                	jmp    800ac5 <vprintfmt+0x335>
  800a8e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  800a92:	74 1e                	je     800ab2 <vprintfmt+0x322>
  800a94:	83 fb 1f             	cmp    $0x1f,%ebx
  800a97:	7e 05                	jle    800a9e <vprintfmt+0x30e>
  800a99:	83 fb 7e             	cmp    $0x7e,%ebx
  800a9c:	7e 14                	jle    800ab2 <vprintfmt+0x322>
  800a9e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800aa2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800aa6:	48 89 d6             	mov    %rdx,%rsi
  800aa9:	bf 3f 00 00 00       	mov    $0x3f,%edi
  800aae:	ff d0                	callq  *%rax
  800ab0:	eb 0f                	jmp    800ac1 <vprintfmt+0x331>
  800ab2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800ab6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800aba:	48 89 d6             	mov    %rdx,%rsi
  800abd:	89 df                	mov    %ebx,%edi
  800abf:	ff d0                	callq  *%rax
  800ac1:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800ac5:	4c 89 e0             	mov    %r12,%rax
  800ac8:	4c 8d 60 01          	lea    0x1(%rax),%r12
  800acc:	0f b6 00             	movzbl (%rax),%eax
  800acf:	0f be d8             	movsbl %al,%ebx
  800ad2:	85 db                	test   %ebx,%ebx
  800ad4:	74 10                	je     800ae6 <vprintfmt+0x356>
  800ad6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800ada:	78 b2                	js     800a8e <vprintfmt+0x2fe>
  800adc:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  800ae0:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  800ae4:	79 a8                	jns    800a8e <vprintfmt+0x2fe>
  800ae6:	eb 16                	jmp    800afe <vprintfmt+0x36e>
  800ae8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800aec:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800af0:	48 89 d6             	mov    %rdx,%rsi
  800af3:	bf 20 00 00 00       	mov    $0x20,%edi
  800af8:	ff d0                	callq  *%rax
  800afa:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
  800afe:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800b02:	7f e4                	jg     800ae8 <vprintfmt+0x358>
  800b04:	e9 90 01 00 00       	jmpq   800c99 <vprintfmt+0x509>
  800b09:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b0d:	be 03 00 00 00       	mov    $0x3,%esi
  800b12:	48 89 c7             	mov    %rax,%rdi
  800b15:	48 b8 80 06 80 00 00 	movabs $0x800680,%rax
  800b1c:	00 00 00 
  800b1f:	ff d0                	callq  *%rax
  800b21:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b29:	48 85 c0             	test   %rax,%rax
  800b2c:	79 1d                	jns    800b4b <vprintfmt+0x3bb>
  800b2e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800b32:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800b36:	48 89 d6             	mov    %rdx,%rsi
  800b39:	bf 2d 00 00 00       	mov    $0x2d,%edi
  800b3e:	ff d0                	callq  *%rax
  800b40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800b44:	48 f7 d8             	neg    %rax
  800b47:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b4b:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800b52:	e9 d5 00 00 00       	jmpq   800c2c <vprintfmt+0x49c>
  800b57:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b5b:	be 03 00 00 00       	mov    $0x3,%esi
  800b60:	48 89 c7             	mov    %rax,%rdi
  800b63:	48 b8 70 05 80 00 00 	movabs $0x800570,%rax
  800b6a:	00 00 00 
  800b6d:	ff d0                	callq  *%rax
  800b6f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b73:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%rbp)
  800b7a:	e9 ad 00 00 00       	jmpq   800c2c <vprintfmt+0x49c>
  800b7f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800b83:	be 03 00 00 00       	mov    $0x3,%esi
  800b88:	48 89 c7             	mov    %rax,%rdi
  800b8b:	48 b8 70 05 80 00 00 	movabs $0x800570,%rax
  800b92:	00 00 00 
  800b95:	ff d0                	callq  *%rax
  800b97:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800b9b:	c7 45 e4 08 00 00 00 	movl   $0x8,-0x1c(%rbp)
  800ba2:	e9 85 00 00 00       	jmpq   800c2c <vprintfmt+0x49c>
  800ba7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800baf:	48 89 d6             	mov    %rdx,%rsi
  800bb2:	bf 30 00 00 00       	mov    $0x30,%edi
  800bb7:	ff d0                	callq  *%rax
  800bb9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800bbd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800bc1:	48 89 d6             	mov    %rdx,%rsi
  800bc4:	bf 78 00 00 00       	mov    $0x78,%edi
  800bc9:	ff d0                	callq  *%rax
  800bcb:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bce:	83 f8 30             	cmp    $0x30,%eax
  800bd1:	73 17                	jae    800bea <vprintfmt+0x45a>
  800bd3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  800bd7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  800bda:	89 c0                	mov    %eax,%eax
  800bdc:	48 01 d0             	add    %rdx,%rax
  800bdf:	8b 55 b8             	mov    -0x48(%rbp),%edx
  800be2:	83 c2 08             	add    $0x8,%edx
  800be5:	89 55 b8             	mov    %edx,-0x48(%rbp)
  800be8:	eb 0f                	jmp    800bf9 <vprintfmt+0x469>
  800bea:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
  800bee:	48 89 d0             	mov    %rdx,%rax
  800bf1:	48 83 c2 08          	add    $0x8,%rdx
  800bf5:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
  800bf9:	48 8b 00             	mov    (%rax),%rax
  800bfc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c00:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800c07:	eb 23                	jmp    800c2c <vprintfmt+0x49c>
  800c09:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
  800c0d:	be 03 00 00 00       	mov    $0x3,%esi
  800c12:	48 89 c7             	mov    %rax,%rdi
  800c15:	48 b8 70 05 80 00 00 	movabs $0x800570,%rax
  800c1c:	00 00 00 
  800c1f:	ff d0                	callq  *%rax
  800c21:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800c25:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%rbp)
  800c2c:	44 0f be 45 d3       	movsbl -0x2d(%rbp),%r8d
  800c31:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  800c34:	8b 7d dc             	mov    -0x24(%rbp),%edi
  800c37:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  800c3b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  800c3f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c43:	45 89 c1             	mov    %r8d,%r9d
  800c46:	41 89 f8             	mov    %edi,%r8d
  800c49:	48 89 c7             	mov    %rax,%rdi
  800c4c:	48 b8 b5 04 80 00 00 	movabs $0x8004b5,%rax
  800c53:	00 00 00 
  800c56:	ff d0                	callq  *%rax
  800c58:	eb 3f                	jmp    800c99 <vprintfmt+0x509>
  800c5a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c5e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c62:	48 89 d6             	mov    %rdx,%rsi
  800c65:	89 df                	mov    %ebx,%edi
  800c67:	ff d0                	callq  *%rax
  800c69:	eb 2e                	jmp    800c99 <vprintfmt+0x509>
  800c6b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  800c6f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  800c73:	48 89 d6             	mov    %rdx,%rsi
  800c76:	bf 25 00 00 00       	mov    $0x25,%edi
  800c7b:	ff d0                	callq  *%rax
  800c7d:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c82:	eb 05                	jmp    800c89 <vprintfmt+0x4f9>
  800c84:	48 83 6d 98 01       	subq   $0x1,-0x68(%rbp)
  800c89:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  800c8d:	48 83 e8 01          	sub    $0x1,%rax
  800c91:	0f b6 00             	movzbl (%rax),%eax
  800c94:	3c 25                	cmp    $0x25,%al
  800c96:	75 ec                	jne    800c84 <vprintfmt+0x4f4>
  800c98:	90                   	nop
  800c99:	90                   	nop
  800c9a:	e9 43 fb ff ff       	jmpq   8007e2 <vprintfmt+0x52>
  800c9f:	48 83 c4 60          	add    $0x60,%rsp
  800ca3:	5b                   	pop    %rbx
  800ca4:	41 5c                	pop    %r12
  800ca6:	5d                   	pop    %rbp
  800ca7:	c3                   	retq   

0000000000800ca8 <printfmt>:
  800ca8:	55                   	push   %rbp
  800ca9:	48 89 e5             	mov    %rsp,%rbp
  800cac:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  800cb3:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  800cba:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  800cc1:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800cc8:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800ccf:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800cd6:	84 c0                	test   %al,%al
  800cd8:	74 20                	je     800cfa <printfmt+0x52>
  800cda:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800cde:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800ce2:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800ce6:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800cea:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800cee:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800cf2:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800cf6:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800cfa:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
  800d01:	c7 85 38 ff ff ff 18 	movl   $0x18,-0xc8(%rbp)
  800d08:	00 00 00 
  800d0b:	c7 85 3c ff ff ff 30 	movl   $0x30,-0xc4(%rbp)
  800d12:	00 00 00 
  800d15:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800d19:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800d20:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800d27:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
  800d2e:	48 8d 8d 38 ff ff ff 	lea    -0xc8(%rbp),%rcx
  800d35:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  800d3c:	48 8b b5 20 ff ff ff 	mov    -0xe0(%rbp),%rsi
  800d43:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  800d4a:	48 89 c7             	mov    %rax,%rdi
  800d4d:	48 b8 90 07 80 00 00 	movabs $0x800790,%rax
  800d54:	00 00 00 
  800d57:	ff d0                	callq  *%rax
  800d59:	c9                   	leaveq 
  800d5a:	c3                   	retq   

0000000000800d5b <sprintputch>:
  800d5b:	55                   	push   %rbp
  800d5c:	48 89 e5             	mov    %rsp,%rbp
  800d5f:	48 83 ec 10          	sub    $0x10,%rsp
  800d63:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d66:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d6e:	8b 40 10             	mov    0x10(%rax),%eax
  800d71:	8d 50 01             	lea    0x1(%rax),%edx
  800d74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d78:	89 50 10             	mov    %edx,0x10(%rax)
  800d7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d7f:	48 8b 10             	mov    (%rax),%rdx
  800d82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d86:	48 8b 40 08          	mov    0x8(%rax),%rax
  800d8a:	48 39 c2             	cmp    %rax,%rdx
  800d8d:	73 17                	jae    800da6 <sprintputch+0x4b>
  800d8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  800d93:	48 8b 00             	mov    (%rax),%rax
  800d96:	48 8d 48 01          	lea    0x1(%rax),%rcx
  800d9a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  800d9e:	48 89 0a             	mov    %rcx,(%rdx)
  800da1:	8b 55 fc             	mov    -0x4(%rbp),%edx
  800da4:	88 10                	mov    %dl,(%rax)
  800da6:	c9                   	leaveq 
  800da7:	c3                   	retq   

0000000000800da8 <vsnprintf>:
  800da8:	55                   	push   %rbp
  800da9:	48 89 e5             	mov    %rsp,%rbp
  800dac:	48 83 ec 50          	sub    $0x50,%rsp
  800db0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  800db4:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  800db7:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
  800dbb:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
  800dbf:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  800dc3:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
  800dc7:	48 8b 0a             	mov    (%rdx),%rcx
  800dca:	48 89 08             	mov    %rcx,(%rax)
  800dcd:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800dd1:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800dd5:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800dd9:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800ddd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800de1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800de5:	8b 45 c4             	mov    -0x3c(%rbp),%eax
  800de8:	48 98                	cltq   
  800dea:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800dee:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  800df2:	48 01 d0             	add    %rdx,%rax
  800df5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800df9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  800e00:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
  800e05:	74 06                	je     800e0d <vsnprintf+0x65>
  800e07:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
  800e0b:	7f 07                	jg     800e14 <vsnprintf+0x6c>
  800e0d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800e12:	eb 2f                	jmp    800e43 <vsnprintf+0x9b>
  800e14:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
  800e18:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  800e1c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  800e20:	48 89 c6             	mov    %rax,%rsi
  800e23:	48 bf 5b 0d 80 00 00 	movabs $0x800d5b,%rdi
  800e2a:	00 00 00 
  800e2d:	48 b8 90 07 80 00 00 	movabs $0x800790,%rax
  800e34:	00 00 00 
  800e37:	ff d0                	callq  *%rax
  800e39:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800e3d:	c6 00 00             	movb   $0x0,(%rax)
  800e40:	8b 45 e0             	mov    -0x20(%rbp),%eax
  800e43:	c9                   	leaveq 
  800e44:	c3                   	retq   

0000000000800e45 <snprintf>:
  800e45:	55                   	push   %rbp
  800e46:	48 89 e5             	mov    %rsp,%rbp
  800e49:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  800e50:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
  800e57:	89 b5 04 ff ff ff    	mov    %esi,-0xfc(%rbp)
  800e5d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  800e64:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  800e6b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  800e72:	84 c0                	test   %al,%al
  800e74:	74 20                	je     800e96 <snprintf+0x51>
  800e76:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  800e7a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  800e7e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  800e82:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  800e86:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  800e8a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  800e8e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  800e92:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  800e96:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
  800e9d:	c7 85 30 ff ff ff 18 	movl   $0x18,-0xd0(%rbp)
  800ea4:	00 00 00 
  800ea7:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  800eae:	00 00 00 
  800eb1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  800eb5:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  800ebc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  800ec3:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  800eca:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
  800ed1:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  800ed8:	48 8b 0a             	mov    (%rdx),%rcx
  800edb:	48 89 08             	mov    %rcx,(%rax)
  800ede:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  800ee2:	48 89 48 08          	mov    %rcx,0x8(%rax)
  800ee6:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  800eea:	48 89 50 10          	mov    %rdx,0x10(%rax)
  800eee:	48 8d 8d 18 ff ff ff 	lea    -0xe8(%rbp),%rcx
  800ef5:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
  800efc:	8b b5 04 ff ff ff    	mov    -0xfc(%rbp),%esi
  800f02:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  800f09:	48 89 c7             	mov    %rax,%rdi
  800f0c:	48 b8 a8 0d 80 00 00 	movabs $0x800da8,%rax
  800f13:	00 00 00 
  800f16:	ff d0                	callq  *%rax
  800f18:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  800f1e:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  800f24:	c9                   	leaveq 
  800f25:	c3                   	retq   

0000000000800f26 <strlen>:
  800f26:	55                   	push   %rbp
  800f27:	48 89 e5             	mov    %rsp,%rbp
  800f2a:	48 83 ec 18          	sub    $0x18,%rsp
  800f2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800f39:	eb 09                	jmp    800f44 <strlen+0x1e>
  800f3b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f3f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800f44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f48:	0f b6 00             	movzbl (%rax),%eax
  800f4b:	84 c0                	test   %al,%al
  800f4d:	75 ec                	jne    800f3b <strlen+0x15>
  800f4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f52:	c9                   	leaveq 
  800f53:	c3                   	retq   

0000000000800f54 <strnlen>:
  800f54:	55                   	push   %rbp
  800f55:	48 89 e5             	mov    %rsp,%rbp
  800f58:	48 83 ec 20          	sub    $0x20,%rsp
  800f5c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f60:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800f64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  800f6b:	eb 0e                	jmp    800f7b <strnlen+0x27>
  800f6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  800f71:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  800f76:	48 83 6d e0 01       	subq   $0x1,-0x20(%rbp)
  800f7b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800f80:	74 0b                	je     800f8d <strnlen+0x39>
  800f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800f86:	0f b6 00             	movzbl (%rax),%eax
  800f89:	84 c0                	test   %al,%al
  800f8b:	75 e0                	jne    800f6d <strnlen+0x19>
  800f8d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800f90:	c9                   	leaveq 
  800f91:	c3                   	retq   

0000000000800f92 <strcpy>:
  800f92:	55                   	push   %rbp
  800f93:	48 89 e5             	mov    %rsp,%rbp
  800f96:	48 83 ec 20          	sub    $0x20,%rsp
  800f9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800f9e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fa6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  800faa:	90                   	nop
  800fab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800faf:	48 8d 50 01          	lea    0x1(%rax),%rdx
  800fb3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  800fb7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  800fbb:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  800fbf:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  800fc3:	0f b6 12             	movzbl (%rdx),%edx
  800fc6:	88 10                	mov    %dl,(%rax)
  800fc8:	0f b6 00             	movzbl (%rax),%eax
  800fcb:	84 c0                	test   %al,%al
  800fcd:	75 dc                	jne    800fab <strcpy+0x19>
  800fcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  800fd3:	c9                   	leaveq 
  800fd4:	c3                   	retq   

0000000000800fd5 <strcat>:
  800fd5:	55                   	push   %rbp
  800fd6:	48 89 e5             	mov    %rsp,%rbp
  800fd9:	48 83 ec 20          	sub    $0x20,%rsp
  800fdd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  800fe1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800fe5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800fe9:	48 89 c7             	mov    %rax,%rdi
  800fec:	48 b8 26 0f 80 00 00 	movabs $0x800f26,%rax
  800ff3:	00 00 00 
  800ff6:	ff d0                	callq  *%rax
  800ff8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  800ffb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  800ffe:	48 63 d0             	movslq %eax,%rdx
  801001:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801005:	48 01 c2             	add    %rax,%rdx
  801008:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80100c:	48 89 c6             	mov    %rax,%rsi
  80100f:	48 89 d7             	mov    %rdx,%rdi
  801012:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  801019:	00 00 00 
  80101c:	ff d0                	callq  *%rax
  80101e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801022:	c9                   	leaveq 
  801023:	c3                   	retq   

0000000000801024 <strncpy>:
  801024:	55                   	push   %rbp
  801025:	48 89 e5             	mov    %rsp,%rbp
  801028:	48 83 ec 28          	sub    $0x28,%rsp
  80102c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801030:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801034:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801038:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80103c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801040:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  801047:	00 
  801048:	eb 2a                	jmp    801074 <strncpy+0x50>
  80104a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80104e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801052:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801056:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80105a:	0f b6 12             	movzbl (%rdx),%edx
  80105d:	88 10                	mov    %dl,(%rax)
  80105f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801063:	0f b6 00             	movzbl (%rax),%eax
  801066:	84 c0                	test   %al,%al
  801068:	74 05                	je     80106f <strncpy+0x4b>
  80106a:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
  80106f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801074:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801078:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  80107c:	72 cc                	jb     80104a <strncpy+0x26>
  80107e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801082:	c9                   	leaveq 
  801083:	c3                   	retq   

0000000000801084 <strlcpy>:
  801084:	55                   	push   %rbp
  801085:	48 89 e5             	mov    %rsp,%rbp
  801088:	48 83 ec 28          	sub    $0x28,%rsp
  80108c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801090:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801094:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801098:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80109c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8010a0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8010a5:	74 3d                	je     8010e4 <strlcpy+0x60>
  8010a7:	eb 1d                	jmp    8010c6 <strlcpy+0x42>
  8010a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010ad:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8010b1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8010b5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8010b9:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  8010bd:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
  8010c1:	0f b6 12             	movzbl (%rdx),%edx
  8010c4:	88 10                	mov    %dl,(%rax)
  8010c6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  8010cb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8010d0:	74 0b                	je     8010dd <strlcpy+0x59>
  8010d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8010d6:	0f b6 00             	movzbl (%rax),%eax
  8010d9:	84 c0                	test   %al,%al
  8010db:	75 cc                	jne    8010a9 <strlcpy+0x25>
  8010dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8010e1:	c6 00 00             	movb   $0x0,(%rax)
  8010e4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8010e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8010ec:	48 29 c2             	sub    %rax,%rdx
  8010ef:	48 89 d0             	mov    %rdx,%rax
  8010f2:	c9                   	leaveq 
  8010f3:	c3                   	retq   

00000000008010f4 <strcmp>:
  8010f4:	55                   	push   %rbp
  8010f5:	48 89 e5             	mov    %rsp,%rbp
  8010f8:	48 83 ec 10          	sub    $0x10,%rsp
  8010fc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801100:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801104:	eb 0a                	jmp    801110 <strcmp+0x1c>
  801106:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80110b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  801110:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801114:	0f b6 00             	movzbl (%rax),%eax
  801117:	84 c0                	test   %al,%al
  801119:	74 12                	je     80112d <strcmp+0x39>
  80111b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80111f:	0f b6 10             	movzbl (%rax),%edx
  801122:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801126:	0f b6 00             	movzbl (%rax),%eax
  801129:	38 c2                	cmp    %al,%dl
  80112b:	74 d9                	je     801106 <strcmp+0x12>
  80112d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801131:	0f b6 00             	movzbl (%rax),%eax
  801134:	0f b6 d0             	movzbl %al,%edx
  801137:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80113b:	0f b6 00             	movzbl (%rax),%eax
  80113e:	0f b6 c0             	movzbl %al,%eax
  801141:	29 c2                	sub    %eax,%edx
  801143:	89 d0                	mov    %edx,%eax
  801145:	c9                   	leaveq 
  801146:	c3                   	retq   

0000000000801147 <strncmp>:
  801147:	55                   	push   %rbp
  801148:	48 89 e5             	mov    %rsp,%rbp
  80114b:	48 83 ec 18          	sub    $0x18,%rsp
  80114f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801153:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801157:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80115b:	eb 0f                	jmp    80116c <strncmp+0x25>
  80115d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  801162:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801167:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80116c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801171:	74 1d                	je     801190 <strncmp+0x49>
  801173:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801177:	0f b6 00             	movzbl (%rax),%eax
  80117a:	84 c0                	test   %al,%al
  80117c:	74 12                	je     801190 <strncmp+0x49>
  80117e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801182:	0f b6 10             	movzbl (%rax),%edx
  801185:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801189:	0f b6 00             	movzbl (%rax),%eax
  80118c:	38 c2                	cmp    %al,%dl
  80118e:	74 cd                	je     80115d <strncmp+0x16>
  801190:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801195:	75 07                	jne    80119e <strncmp+0x57>
  801197:	b8 00 00 00 00       	mov    $0x0,%eax
  80119c:	eb 18                	jmp    8011b6 <strncmp+0x6f>
  80119e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011a2:	0f b6 00             	movzbl (%rax),%eax
  8011a5:	0f b6 d0             	movzbl %al,%edx
  8011a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8011ac:	0f b6 00             	movzbl (%rax),%eax
  8011af:	0f b6 c0             	movzbl %al,%eax
  8011b2:	29 c2                	sub    %eax,%edx
  8011b4:	89 d0                	mov    %edx,%eax
  8011b6:	c9                   	leaveq 
  8011b7:	c3                   	retq   

00000000008011b8 <strchr>:
  8011b8:	55                   	push   %rbp
  8011b9:	48 89 e5             	mov    %rsp,%rbp
  8011bc:	48 83 ec 0c          	sub    $0xc,%rsp
  8011c0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8011c4:	89 f0                	mov    %esi,%eax
  8011c6:	88 45 f4             	mov    %al,-0xc(%rbp)
  8011c9:	eb 17                	jmp    8011e2 <strchr+0x2a>
  8011cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011cf:	0f b6 00             	movzbl (%rax),%eax
  8011d2:	3a 45 f4             	cmp    -0xc(%rbp),%al
  8011d5:	75 06                	jne    8011dd <strchr+0x25>
  8011d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011db:	eb 15                	jmp    8011f2 <strchr+0x3a>
  8011dd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8011e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8011e6:	0f b6 00             	movzbl (%rax),%eax
  8011e9:	84 c0                	test   %al,%al
  8011eb:	75 de                	jne    8011cb <strchr+0x13>
  8011ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f2:	c9                   	leaveq 
  8011f3:	c3                   	retq   

00000000008011f4 <strfind>:
  8011f4:	55                   	push   %rbp
  8011f5:	48 89 e5             	mov    %rsp,%rbp
  8011f8:	48 83 ec 0c          	sub    $0xc,%rsp
  8011fc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801200:	89 f0                	mov    %esi,%eax
  801202:	88 45 f4             	mov    %al,-0xc(%rbp)
  801205:	eb 13                	jmp    80121a <strfind+0x26>
  801207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80120b:	0f b6 00             	movzbl (%rax),%eax
  80120e:	3a 45 f4             	cmp    -0xc(%rbp),%al
  801211:	75 02                	jne    801215 <strfind+0x21>
  801213:	eb 10                	jmp    801225 <strfind+0x31>
  801215:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  80121a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80121e:	0f b6 00             	movzbl (%rax),%eax
  801221:	84 c0                	test   %al,%al
  801223:	75 e2                	jne    801207 <strfind+0x13>
  801225:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801229:	c9                   	leaveq 
  80122a:	c3                   	retq   

000000000080122b <memset>:
  80122b:	55                   	push   %rbp
  80122c:	48 89 e5             	mov    %rsp,%rbp
  80122f:	48 83 ec 18          	sub    $0x18,%rsp
  801233:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801237:	89 75 f4             	mov    %esi,-0xc(%rbp)
  80123a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80123e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801243:	75 06                	jne    80124b <memset+0x20>
  801245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801249:	eb 69                	jmp    8012b4 <memset+0x89>
  80124b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80124f:	83 e0 03             	and    $0x3,%eax
  801252:	48 85 c0             	test   %rax,%rax
  801255:	75 48                	jne    80129f <memset+0x74>
  801257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80125b:	83 e0 03             	and    $0x3,%eax
  80125e:	48 85 c0             	test   %rax,%rax
  801261:	75 3c                	jne    80129f <memset+0x74>
  801263:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
  80126a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80126d:	c1 e0 18             	shl    $0x18,%eax
  801270:	89 c2                	mov    %eax,%edx
  801272:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801275:	c1 e0 10             	shl    $0x10,%eax
  801278:	09 c2                	or     %eax,%edx
  80127a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  80127d:	c1 e0 08             	shl    $0x8,%eax
  801280:	09 d0                	or     %edx,%eax
  801282:	09 45 f4             	or     %eax,-0xc(%rbp)
  801285:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801289:	48 c1 e8 02          	shr    $0x2,%rax
  80128d:	48 89 c1             	mov    %rax,%rcx
  801290:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801294:	8b 45 f4             	mov    -0xc(%rbp),%eax
  801297:	48 89 d7             	mov    %rdx,%rdi
  80129a:	fc                   	cld    
  80129b:	f3 ab                	rep stos %eax,%es:(%rdi)
  80129d:	eb 11                	jmp    8012b0 <memset+0x85>
  80129f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8012a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8012a6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8012aa:	48 89 d7             	mov    %rdx,%rdi
  8012ad:	fc                   	cld    
  8012ae:	f3 aa                	rep stos %al,%es:(%rdi)
  8012b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012b4:	c9                   	leaveq 
  8012b5:	c3                   	retq   

00000000008012b6 <memmove>:
  8012b6:	55                   	push   %rbp
  8012b7:	48 89 e5             	mov    %rsp,%rbp
  8012ba:	48 83 ec 28          	sub    $0x28,%rsp
  8012be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8012c2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8012c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8012ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8012ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8012d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8012d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8012da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8012de:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8012e2:	0f 83 88 00 00 00    	jae    801370 <memmove+0xba>
  8012e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8012f0:	48 01 d0             	add    %rdx,%rax
  8012f3:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  8012f7:	76 77                	jbe    801370 <memmove+0xba>
  8012f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8012fd:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  801301:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801305:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  801309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80130d:	83 e0 03             	and    $0x3,%eax
  801310:	48 85 c0             	test   %rax,%rax
  801313:	75 3b                	jne    801350 <memmove+0x9a>
  801315:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801319:	83 e0 03             	and    $0x3,%eax
  80131c:	48 85 c0             	test   %rax,%rax
  80131f:	75 2f                	jne    801350 <memmove+0x9a>
  801321:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801325:	83 e0 03             	and    $0x3,%eax
  801328:	48 85 c0             	test   %rax,%rax
  80132b:	75 23                	jne    801350 <memmove+0x9a>
  80132d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801331:	48 83 e8 04          	sub    $0x4,%rax
  801335:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801339:	48 83 ea 04          	sub    $0x4,%rdx
  80133d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  801341:	48 c1 e9 02          	shr    $0x2,%rcx
  801345:	48 89 c7             	mov    %rax,%rdi
  801348:	48 89 d6             	mov    %rdx,%rsi
  80134b:	fd                   	std    
  80134c:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  80134e:	eb 1d                	jmp    80136d <memmove+0xb7>
  801350:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801354:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801358:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80135c:	48 8d 70 ff          	lea    -0x1(%rax),%rsi
  801360:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801364:	48 89 d7             	mov    %rdx,%rdi
  801367:	48 89 c1             	mov    %rax,%rcx
  80136a:	fd                   	std    
  80136b:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  80136d:	fc                   	cld    
  80136e:	eb 57                	jmp    8013c7 <memmove+0x111>
  801370:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801374:	83 e0 03             	and    $0x3,%eax
  801377:	48 85 c0             	test   %rax,%rax
  80137a:	75 36                	jne    8013b2 <memmove+0xfc>
  80137c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801380:	83 e0 03             	and    $0x3,%eax
  801383:	48 85 c0             	test   %rax,%rax
  801386:	75 2a                	jne    8013b2 <memmove+0xfc>
  801388:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80138c:	83 e0 03             	and    $0x3,%eax
  80138f:	48 85 c0             	test   %rax,%rax
  801392:	75 1e                	jne    8013b2 <memmove+0xfc>
  801394:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801398:	48 c1 e8 02          	shr    $0x2,%rax
  80139c:	48 89 c1             	mov    %rax,%rcx
  80139f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013a3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013a7:	48 89 c7             	mov    %rax,%rdi
  8013aa:	48 89 d6             	mov    %rdx,%rsi
  8013ad:	fc                   	cld    
  8013ae:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  8013b0:	eb 15                	jmp    8013c7 <memmove+0x111>
  8013b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8013b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  8013ba:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  8013be:	48 89 c7             	mov    %rax,%rdi
  8013c1:	48 89 d6             	mov    %rdx,%rsi
  8013c4:	fc                   	cld    
  8013c5:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
  8013c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8013cb:	c9                   	leaveq 
  8013cc:	c3                   	retq   

00000000008013cd <memcpy>:
  8013cd:	55                   	push   %rbp
  8013ce:	48 89 e5             	mov    %rsp,%rbp
  8013d1:	48 83 ec 18          	sub    $0x18,%rsp
  8013d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  8013d9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8013dd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8013e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8013e5:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  8013e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8013ed:	48 89 ce             	mov    %rcx,%rsi
  8013f0:	48 89 c7             	mov    %rax,%rdi
  8013f3:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  8013fa:	00 00 00 
  8013fd:	ff d0                	callq  *%rax
  8013ff:	c9                   	leaveq 
  801400:	c3                   	retq   

0000000000801401 <memcmp>:
  801401:	55                   	push   %rbp
  801402:	48 89 e5             	mov    %rsp,%rbp
  801405:	48 83 ec 28          	sub    $0x28,%rsp
  801409:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80140d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801411:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801415:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801419:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80141d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801421:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801425:	eb 36                	jmp    80145d <memcmp+0x5c>
  801427:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80142b:	0f b6 10             	movzbl (%rax),%edx
  80142e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801432:	0f b6 00             	movzbl (%rax),%eax
  801435:	38 c2                	cmp    %al,%dl
  801437:	74 1a                	je     801453 <memcmp+0x52>
  801439:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80143d:	0f b6 00             	movzbl (%rax),%eax
  801440:	0f b6 d0             	movzbl %al,%edx
  801443:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801447:	0f b6 00             	movzbl (%rax),%eax
  80144a:	0f b6 c0             	movzbl %al,%eax
  80144d:	29 c2                	sub    %eax,%edx
  80144f:	89 d0                	mov    %edx,%eax
  801451:	eb 20                	jmp    801473 <memcmp+0x72>
  801453:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  801458:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  80145d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801461:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  801465:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801469:	48 85 c0             	test   %rax,%rax
  80146c:	75 b9                	jne    801427 <memcmp+0x26>
  80146e:	b8 00 00 00 00       	mov    $0x0,%eax
  801473:	c9                   	leaveq 
  801474:	c3                   	retq   

0000000000801475 <memfind>:
  801475:	55                   	push   %rbp
  801476:	48 89 e5             	mov    %rsp,%rbp
  801479:	48 83 ec 28          	sub    $0x28,%rsp
  80147d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801481:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  801484:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  801488:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80148c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801490:	48 01 d0             	add    %rdx,%rax
  801493:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801497:	eb 15                	jmp    8014ae <memfind+0x39>
  801499:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80149d:	0f b6 10             	movzbl (%rax),%edx
  8014a0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  8014a3:	38 c2                	cmp    %al,%dl
  8014a5:	75 02                	jne    8014a9 <memfind+0x34>
  8014a7:	eb 0f                	jmp    8014b8 <memfind+0x43>
  8014a9:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  8014ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014b2:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  8014b6:	72 e1                	jb     801499 <memfind+0x24>
  8014b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8014bc:	c9                   	leaveq 
  8014bd:	c3                   	retq   

00000000008014be <strtol>:
  8014be:	55                   	push   %rbp
  8014bf:	48 89 e5             	mov    %rsp,%rbp
  8014c2:	48 83 ec 34          	sub    $0x34,%rsp
  8014c6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8014ca:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8014ce:	89 55 cc             	mov    %edx,-0x34(%rbp)
  8014d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8014d8:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
  8014df:	00 
  8014e0:	eb 05                	jmp    8014e7 <strtol+0x29>
  8014e2:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  8014e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014eb:	0f b6 00             	movzbl (%rax),%eax
  8014ee:	3c 20                	cmp    $0x20,%al
  8014f0:	74 f0                	je     8014e2 <strtol+0x24>
  8014f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8014f6:	0f b6 00             	movzbl (%rax),%eax
  8014f9:	3c 09                	cmp    $0x9,%al
  8014fb:	74 e5                	je     8014e2 <strtol+0x24>
  8014fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801501:	0f b6 00             	movzbl (%rax),%eax
  801504:	3c 2b                	cmp    $0x2b,%al
  801506:	75 07                	jne    80150f <strtol+0x51>
  801508:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80150d:	eb 17                	jmp    801526 <strtol+0x68>
  80150f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801513:	0f b6 00             	movzbl (%rax),%eax
  801516:	3c 2d                	cmp    $0x2d,%al
  801518:	75 0c                	jne    801526 <strtol+0x68>
  80151a:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80151f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  801526:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80152a:	74 06                	je     801532 <strtol+0x74>
  80152c:	83 7d cc 10          	cmpl   $0x10,-0x34(%rbp)
  801530:	75 28                	jne    80155a <strtol+0x9c>
  801532:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801536:	0f b6 00             	movzbl (%rax),%eax
  801539:	3c 30                	cmp    $0x30,%al
  80153b:	75 1d                	jne    80155a <strtol+0x9c>
  80153d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801541:	48 83 c0 01          	add    $0x1,%rax
  801545:	0f b6 00             	movzbl (%rax),%eax
  801548:	3c 78                	cmp    $0x78,%al
  80154a:	75 0e                	jne    80155a <strtol+0x9c>
  80154c:	48 83 45 d8 02       	addq   $0x2,-0x28(%rbp)
  801551:	c7 45 cc 10 00 00 00 	movl   $0x10,-0x34(%rbp)
  801558:	eb 2c                	jmp    801586 <strtol+0xc8>
  80155a:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80155e:	75 19                	jne    801579 <strtol+0xbb>
  801560:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801564:	0f b6 00             	movzbl (%rax),%eax
  801567:	3c 30                	cmp    $0x30,%al
  801569:	75 0e                	jne    801579 <strtol+0xbb>
  80156b:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  801570:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%rbp)
  801577:	eb 0d                	jmp    801586 <strtol+0xc8>
  801579:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
  80157d:	75 07                	jne    801586 <strtol+0xc8>
  80157f:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%rbp)
  801586:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80158a:	0f b6 00             	movzbl (%rax),%eax
  80158d:	3c 2f                	cmp    $0x2f,%al
  80158f:	7e 1d                	jle    8015ae <strtol+0xf0>
  801591:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801595:	0f b6 00             	movzbl (%rax),%eax
  801598:	3c 39                	cmp    $0x39,%al
  80159a:	7f 12                	jg     8015ae <strtol+0xf0>
  80159c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015a0:	0f b6 00             	movzbl (%rax),%eax
  8015a3:	0f be c0             	movsbl %al,%eax
  8015a6:	83 e8 30             	sub    $0x30,%eax
  8015a9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015ac:	eb 4e                	jmp    8015fc <strtol+0x13e>
  8015ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015b2:	0f b6 00             	movzbl (%rax),%eax
  8015b5:	3c 60                	cmp    $0x60,%al
  8015b7:	7e 1d                	jle    8015d6 <strtol+0x118>
  8015b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015bd:	0f b6 00             	movzbl (%rax),%eax
  8015c0:	3c 7a                	cmp    $0x7a,%al
  8015c2:	7f 12                	jg     8015d6 <strtol+0x118>
  8015c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015c8:	0f b6 00             	movzbl (%rax),%eax
  8015cb:	0f be c0             	movsbl %al,%eax
  8015ce:	83 e8 57             	sub    $0x57,%eax
  8015d1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015d4:	eb 26                	jmp    8015fc <strtol+0x13e>
  8015d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015da:	0f b6 00             	movzbl (%rax),%eax
  8015dd:	3c 40                	cmp    $0x40,%al
  8015df:	7e 48                	jle    801629 <strtol+0x16b>
  8015e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015e5:	0f b6 00             	movzbl (%rax),%eax
  8015e8:	3c 5a                	cmp    $0x5a,%al
  8015ea:	7f 3d                	jg     801629 <strtol+0x16b>
  8015ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8015f0:	0f b6 00             	movzbl (%rax),%eax
  8015f3:	0f be c0             	movsbl %al,%eax
  8015f6:	83 e8 37             	sub    $0x37,%eax
  8015f9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8015fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8015ff:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801602:	7c 02                	jl     801606 <strtol+0x148>
  801604:	eb 23                	jmp    801629 <strtol+0x16b>
  801606:	48 83 45 d8 01       	addq   $0x1,-0x28(%rbp)
  80160b:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80160e:	48 98                	cltq   
  801610:	48 0f af 45 f0       	imul   -0x10(%rbp),%rax
  801615:	48 89 c2             	mov    %rax,%rdx
  801618:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80161b:	48 98                	cltq   
  80161d:	48 01 d0             	add    %rdx,%rax
  801620:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801624:	e9 5d ff ff ff       	jmpq   801586 <strtol+0xc8>
  801629:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  80162e:	74 0b                	je     80163b <strtol+0x17d>
  801630:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801634:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801638:	48 89 10             	mov    %rdx,(%rax)
  80163b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80163f:	74 09                	je     80164a <strtol+0x18c>
  801641:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801645:	48 f7 d8             	neg    %rax
  801648:	eb 04                	jmp    80164e <strtol+0x190>
  80164a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80164e:	c9                   	leaveq 
  80164f:	c3                   	retq   

0000000000801650 <strstr>:
  801650:	55                   	push   %rbp
  801651:	48 89 e5             	mov    %rsp,%rbp
  801654:	48 83 ec 30          	sub    $0x30,%rsp
  801658:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  80165c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801660:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801664:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801668:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  80166c:	0f b6 00             	movzbl (%rax),%eax
  80166f:	88 45 ff             	mov    %al,-0x1(%rbp)
  801672:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801676:	75 06                	jne    80167e <strstr+0x2e>
  801678:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80167c:	eb 6b                	jmp    8016e9 <strstr+0x99>
  80167e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801682:	48 89 c7             	mov    %rax,%rdi
  801685:	48 b8 26 0f 80 00 00 	movabs $0x800f26,%rax
  80168c:	00 00 00 
  80168f:	ff d0                	callq  *%rax
  801691:	48 98                	cltq   
  801693:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801697:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80169b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80169f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8016a3:	0f b6 00             	movzbl (%rax),%eax
  8016a6:	88 45 ef             	mov    %al,-0x11(%rbp)
  8016a9:	80 7d ef 00          	cmpb   $0x0,-0x11(%rbp)
  8016ad:	75 07                	jne    8016b6 <strstr+0x66>
  8016af:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b4:	eb 33                	jmp    8016e9 <strstr+0x99>
  8016b6:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8016ba:	3a 45 ff             	cmp    -0x1(%rbp),%al
  8016bd:	75 d8                	jne    801697 <strstr+0x47>
  8016bf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8016c3:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  8016c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016cb:	48 89 ce             	mov    %rcx,%rsi
  8016ce:	48 89 c7             	mov    %rax,%rdi
  8016d1:	48 b8 47 11 80 00 00 	movabs $0x801147,%rax
  8016d8:	00 00 00 
  8016db:	ff d0                	callq  *%rax
  8016dd:	85 c0                	test   %eax,%eax
  8016df:	75 b6                	jne    801697 <strstr+0x47>
  8016e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8016e5:	48 83 e8 01          	sub    $0x1,%rax
  8016e9:	c9                   	leaveq 
  8016ea:	c3                   	retq   

00000000008016eb <syscall>:
  8016eb:	55                   	push   %rbp
  8016ec:	48 89 e5             	mov    %rsp,%rbp
  8016ef:	53                   	push   %rbx
  8016f0:	48 83 ec 48          	sub    $0x48,%rsp
  8016f4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8016f7:	89 75 d8             	mov    %esi,-0x28(%rbp)
  8016fa:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  8016fe:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  801702:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
  801706:	4c 89 4d b8          	mov    %r9,-0x48(%rbp)
  80170a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80170d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  801711:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
  801715:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  801719:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  80171d:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  801721:	4c 89 c3             	mov    %r8,%rbx
  801724:	cd 30                	int    $0x30
  801726:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80172a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  80172e:	74 3e                	je     80176e <syscall+0x83>
  801730:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  801735:	7e 37                	jle    80176e <syscall+0x83>
  801737:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  80173b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80173e:	49 89 d0             	mov    %rdx,%r8
  801741:	89 c1                	mov    %eax,%ecx
  801743:	48 ba 68 47 80 00 00 	movabs $0x804768,%rdx
  80174a:	00 00 00 
  80174d:	be 24 00 00 00       	mov    $0x24,%esi
  801752:	48 bf 85 47 80 00 00 	movabs $0x804785,%rdi
  801759:	00 00 00 
  80175c:	b8 00 00 00 00       	mov    $0x0,%eax
  801761:	49 b9 e9 3d 80 00 00 	movabs $0x803de9,%r9
  801768:	00 00 00 
  80176b:	41 ff d1             	callq  *%r9
  80176e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801772:	48 83 c4 48          	add    $0x48,%rsp
  801776:	5b                   	pop    %rbx
  801777:	5d                   	pop    %rbp
  801778:	c3                   	retq   

0000000000801779 <sys_cputs>:
  801779:	55                   	push   %rbp
  80177a:	48 89 e5             	mov    %rsp,%rbp
  80177d:	48 83 ec 20          	sub    $0x20,%rsp
  801781:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801785:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80178d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801791:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801798:	00 
  801799:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80179f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017a5:	48 89 d1             	mov    %rdx,%rcx
  8017a8:	48 89 c2             	mov    %rax,%rdx
  8017ab:	be 00 00 00 00       	mov    $0x0,%esi
  8017b0:	bf 00 00 00 00       	mov    $0x0,%edi
  8017b5:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  8017bc:	00 00 00 
  8017bf:	ff d0                	callq  *%rax
  8017c1:	c9                   	leaveq 
  8017c2:	c3                   	retq   

00000000008017c3 <sys_cgetc>:
  8017c3:	55                   	push   %rbp
  8017c4:	48 89 e5             	mov    %rsp,%rbp
  8017c7:	48 83 ec 10          	sub    $0x10,%rsp
  8017cb:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8017d2:	00 
  8017d3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8017d9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8017df:	b9 00 00 00 00       	mov    $0x0,%ecx
  8017e4:	ba 00 00 00 00       	mov    $0x0,%edx
  8017e9:	be 00 00 00 00       	mov    $0x0,%esi
  8017ee:	bf 01 00 00 00       	mov    $0x1,%edi
  8017f3:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  8017fa:	00 00 00 
  8017fd:	ff d0                	callq  *%rax
  8017ff:	c9                   	leaveq 
  801800:	c3                   	retq   

0000000000801801 <sys_env_destroy>:
  801801:	55                   	push   %rbp
  801802:	48 89 e5             	mov    %rsp,%rbp
  801805:	48 83 ec 10          	sub    $0x10,%rsp
  801809:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80180c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80180f:	48 98                	cltq   
  801811:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801818:	00 
  801819:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80181f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801825:	b9 00 00 00 00       	mov    $0x0,%ecx
  80182a:	48 89 c2             	mov    %rax,%rdx
  80182d:	be 01 00 00 00       	mov    $0x1,%esi
  801832:	bf 03 00 00 00       	mov    $0x3,%edi
  801837:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  80183e:	00 00 00 
  801841:	ff d0                	callq  *%rax
  801843:	c9                   	leaveq 
  801844:	c3                   	retq   

0000000000801845 <sys_getenvid>:
  801845:	55                   	push   %rbp
  801846:	48 89 e5             	mov    %rsp,%rbp
  801849:	48 83 ec 10          	sub    $0x10,%rsp
  80184d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801854:	00 
  801855:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  80185b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801861:	b9 00 00 00 00       	mov    $0x0,%ecx
  801866:	ba 00 00 00 00       	mov    $0x0,%edx
  80186b:	be 00 00 00 00       	mov    $0x0,%esi
  801870:	bf 02 00 00 00       	mov    $0x2,%edi
  801875:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  80187c:	00 00 00 
  80187f:	ff d0                	callq  *%rax
  801881:	c9                   	leaveq 
  801882:	c3                   	retq   

0000000000801883 <sys_yield>:
  801883:	55                   	push   %rbp
  801884:	48 89 e5             	mov    %rsp,%rbp
  801887:	48 83 ec 10          	sub    $0x10,%rsp
  80188b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801892:	00 
  801893:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801899:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  80189f:	b9 00 00 00 00       	mov    $0x0,%ecx
  8018a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8018a9:	be 00 00 00 00       	mov    $0x0,%esi
  8018ae:	bf 0b 00 00 00       	mov    $0xb,%edi
  8018b3:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  8018ba:	00 00 00 
  8018bd:	ff d0                	callq  *%rax
  8018bf:	c9                   	leaveq 
  8018c0:	c3                   	retq   

00000000008018c1 <sys_page_alloc>:
  8018c1:	55                   	push   %rbp
  8018c2:	48 89 e5             	mov    %rsp,%rbp
  8018c5:	48 83 ec 20          	sub    $0x20,%rsp
  8018c9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8018cc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8018d0:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8018d3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8018d6:	48 63 c8             	movslq %eax,%rcx
  8018d9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8018dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8018e0:	48 98                	cltq   
  8018e2:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8018e9:	00 
  8018ea:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8018f0:	49 89 c8             	mov    %rcx,%r8
  8018f3:	48 89 d1             	mov    %rdx,%rcx
  8018f6:	48 89 c2             	mov    %rax,%rdx
  8018f9:	be 01 00 00 00       	mov    $0x1,%esi
  8018fe:	bf 04 00 00 00       	mov    $0x4,%edi
  801903:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  80190a:	00 00 00 
  80190d:	ff d0                	callq  *%rax
  80190f:	c9                   	leaveq 
  801910:	c3                   	retq   

0000000000801911 <sys_page_map>:
  801911:	55                   	push   %rbp
  801912:	48 89 e5             	mov    %rsp,%rbp
  801915:	48 83 ec 30          	sub    $0x30,%rsp
  801919:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80191c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801920:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801923:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801927:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  80192b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80192e:	48 63 c8             	movslq %eax,%rcx
  801931:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801935:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801938:	48 63 f0             	movslq %eax,%rsi
  80193b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80193f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801942:	48 98                	cltq   
  801944:	48 89 0c 24          	mov    %rcx,(%rsp)
  801948:	49 89 f9             	mov    %rdi,%r9
  80194b:	49 89 f0             	mov    %rsi,%r8
  80194e:	48 89 d1             	mov    %rdx,%rcx
  801951:	48 89 c2             	mov    %rax,%rdx
  801954:	be 01 00 00 00       	mov    $0x1,%esi
  801959:	bf 05 00 00 00       	mov    $0x5,%edi
  80195e:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801965:	00 00 00 
  801968:	ff d0                	callq  *%rax
  80196a:	c9                   	leaveq 
  80196b:	c3                   	retq   

000000000080196c <sys_page_unmap>:
  80196c:	55                   	push   %rbp
  80196d:	48 89 e5             	mov    %rsp,%rbp
  801970:	48 83 ec 20          	sub    $0x20,%rsp
  801974:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801977:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80197b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80197f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801982:	48 98                	cltq   
  801984:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  80198b:	00 
  80198c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801992:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801998:	48 89 d1             	mov    %rdx,%rcx
  80199b:	48 89 c2             	mov    %rax,%rdx
  80199e:	be 01 00 00 00       	mov    $0x1,%esi
  8019a3:	bf 06 00 00 00       	mov    $0x6,%edi
  8019a8:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  8019af:	00 00 00 
  8019b2:	ff d0                	callq  *%rax
  8019b4:	c9                   	leaveq 
  8019b5:	c3                   	retq   

00000000008019b6 <sys_env_set_status>:
  8019b6:	55                   	push   %rbp
  8019b7:	48 89 e5             	mov    %rsp,%rbp
  8019ba:	48 83 ec 10          	sub    $0x10,%rsp
  8019be:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8019c1:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8019c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8019c7:	48 63 d0             	movslq %eax,%rdx
  8019ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8019cd:	48 98                	cltq   
  8019cf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  8019d6:	00 
  8019d7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  8019dd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  8019e3:	48 89 d1             	mov    %rdx,%rcx
  8019e6:	48 89 c2             	mov    %rax,%rdx
  8019e9:	be 01 00 00 00       	mov    $0x1,%esi
  8019ee:	bf 08 00 00 00       	mov    $0x8,%edi
  8019f3:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  8019fa:	00 00 00 
  8019fd:	ff d0                	callq  *%rax
  8019ff:	c9                   	leaveq 
  801a00:	c3                   	retq   

0000000000801a01 <sys_env_set_trapframe>:
  801a01:	55                   	push   %rbp
  801a02:	48 89 e5             	mov    %rsp,%rbp
  801a05:	48 83 ec 20          	sub    $0x20,%rsp
  801a09:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a0c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a10:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a14:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a17:	48 98                	cltq   
  801a19:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a20:	00 
  801a21:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a27:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a2d:	48 89 d1             	mov    %rdx,%rcx
  801a30:	48 89 c2             	mov    %rax,%rdx
  801a33:	be 01 00 00 00       	mov    $0x1,%esi
  801a38:	bf 09 00 00 00       	mov    $0x9,%edi
  801a3d:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801a44:	00 00 00 
  801a47:	ff d0                	callq  *%rax
  801a49:	c9                   	leaveq 
  801a4a:	c3                   	retq   

0000000000801a4b <sys_env_set_pgfault_upcall>:
  801a4b:	55                   	push   %rbp
  801a4c:	48 89 e5             	mov    %rsp,%rbp
  801a4f:	48 83 ec 20          	sub    $0x20,%rsp
  801a53:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801a56:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801a5a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801a5e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801a61:	48 98                	cltq   
  801a63:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801a6a:	00 
  801a6b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801a71:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801a77:	48 89 d1             	mov    %rdx,%rcx
  801a7a:	48 89 c2             	mov    %rax,%rdx
  801a7d:	be 01 00 00 00       	mov    $0x1,%esi
  801a82:	bf 0a 00 00 00       	mov    $0xa,%edi
  801a87:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801a8e:	00 00 00 
  801a91:	ff d0                	callq  *%rax
  801a93:	c9                   	leaveq 
  801a94:	c3                   	retq   

0000000000801a95 <sys_ipc_try_send>:
  801a95:	55                   	push   %rbp
  801a96:	48 89 e5             	mov    %rsp,%rbp
  801a99:	48 83 ec 20          	sub    $0x20,%rsp
  801a9d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801aa0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801aa4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  801aa8:	89 4d f8             	mov    %ecx,-0x8(%rbp)
  801aab:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801aae:	48 63 f0             	movslq %eax,%rsi
  801ab1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  801ab5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ab8:	48 98                	cltq   
  801aba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801abe:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801ac5:	00 
  801ac6:	49 89 f1             	mov    %rsi,%r9
  801ac9:	49 89 c8             	mov    %rcx,%r8
  801acc:	48 89 d1             	mov    %rdx,%rcx
  801acf:	48 89 c2             	mov    %rax,%rdx
  801ad2:	be 00 00 00 00       	mov    $0x0,%esi
  801ad7:	bf 0c 00 00 00       	mov    $0xc,%edi
  801adc:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801ae3:	00 00 00 
  801ae6:	ff d0                	callq  *%rax
  801ae8:	c9                   	leaveq 
  801ae9:	c3                   	retq   

0000000000801aea <sys_ipc_recv>:
  801aea:	55                   	push   %rbp
  801aeb:	48 89 e5             	mov    %rsp,%rbp
  801aee:	48 83 ec 10          	sub    $0x10,%rsp
  801af2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801af6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801afa:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b01:	00 
  801b02:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b08:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b0e:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b13:	48 89 c2             	mov    %rax,%rdx
  801b16:	be 01 00 00 00       	mov    $0x1,%esi
  801b1b:	bf 0d 00 00 00       	mov    $0xd,%edi
  801b20:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801b27:	00 00 00 
  801b2a:	ff d0                	callq  *%rax
  801b2c:	c9                   	leaveq 
  801b2d:	c3                   	retq   

0000000000801b2e <sys_time_msec>:
  801b2e:	55                   	push   %rbp
  801b2f:	48 89 e5             	mov    %rsp,%rbp
  801b32:	48 83 ec 10          	sub    $0x10,%rsp
  801b36:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b3d:	00 
  801b3e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b44:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b4a:	b9 00 00 00 00       	mov    $0x0,%ecx
  801b4f:	ba 00 00 00 00       	mov    $0x0,%edx
  801b54:	be 00 00 00 00       	mov    $0x0,%esi
  801b59:	bf 0e 00 00 00       	mov    $0xe,%edi
  801b5e:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801b65:	00 00 00 
  801b68:	ff d0                	callq  *%rax
  801b6a:	c9                   	leaveq 
  801b6b:	c3                   	retq   

0000000000801b6c <sys_net_transmit>:
  801b6c:	55                   	push   %rbp
  801b6d:	48 89 e5             	mov    %rsp,%rbp
  801b70:	48 83 ec 20          	sub    $0x20,%rsp
  801b74:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b78:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801b7b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801b82:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801b89:	00 
  801b8a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801b90:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801b96:	48 89 d1             	mov    %rdx,%rcx
  801b99:	48 89 c2             	mov    %rax,%rdx
  801b9c:	be 00 00 00 00       	mov    $0x0,%esi
  801ba1:	bf 0f 00 00 00       	mov    $0xf,%edi
  801ba6:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801bad:	00 00 00 
  801bb0:	ff d0                	callq  *%rax
  801bb2:	c9                   	leaveq 
  801bb3:	c3                   	retq   

0000000000801bb4 <sys_net_receive>:
  801bb4:	55                   	push   %rbp
  801bb5:	48 89 e5             	mov    %rsp,%rbp
  801bb8:	48 83 ec 20          	sub    $0x20,%rsp
  801bbc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801bc0:	89 75 f4             	mov    %esi,-0xc(%rbp)
  801bc3:	8b 55 f4             	mov    -0xc(%rbp),%edx
  801bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801bca:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801bd1:	00 
  801bd2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801bd8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801bde:	48 89 d1             	mov    %rdx,%rcx
  801be1:	48 89 c2             	mov    %rax,%rdx
  801be4:	be 00 00 00 00       	mov    $0x0,%esi
  801be9:	bf 10 00 00 00       	mov    $0x10,%edi
  801bee:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801bf5:	00 00 00 
  801bf8:	ff d0                	callq  *%rax
  801bfa:	c9                   	leaveq 
  801bfb:	c3                   	retq   

0000000000801bfc <sys_ept_map>:
  801bfc:	55                   	push   %rbp
  801bfd:	48 89 e5             	mov    %rsp,%rbp
  801c00:	48 83 ec 30          	sub    $0x30,%rsp
  801c04:	89 7d fc             	mov    %edi,-0x4(%rbp)
  801c07:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c0b:	89 55 f8             	mov    %edx,-0x8(%rbp)
  801c0e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801c12:	44 89 45 e4          	mov    %r8d,-0x1c(%rbp)
  801c16:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801c19:	48 63 c8             	movslq %eax,%rcx
  801c1c:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
  801c20:	8b 45 f8             	mov    -0x8(%rbp),%eax
  801c23:	48 63 f0             	movslq %eax,%rsi
  801c26:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801c2d:	48 98                	cltq   
  801c2f:	48 89 0c 24          	mov    %rcx,(%rsp)
  801c33:	49 89 f9             	mov    %rdi,%r9
  801c36:	49 89 f0             	mov    %rsi,%r8
  801c39:	48 89 d1             	mov    %rdx,%rcx
  801c3c:	48 89 c2             	mov    %rax,%rdx
  801c3f:	be 00 00 00 00       	mov    $0x0,%esi
  801c44:	bf 11 00 00 00       	mov    $0x11,%edi
  801c49:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801c50:	00 00 00 
  801c53:	ff d0                	callq  *%rax
  801c55:	c9                   	leaveq 
  801c56:	c3                   	retq   

0000000000801c57 <sys_env_mkguest>:
  801c57:	55                   	push   %rbp
  801c58:	48 89 e5             	mov    %rsp,%rbp
  801c5b:	48 83 ec 20          	sub    $0x20,%rsp
  801c5f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801c63:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  801c67:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801c6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801c6f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  801c76:	00 
  801c77:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  801c7d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  801c83:	48 89 d1             	mov    %rdx,%rcx
  801c86:	48 89 c2             	mov    %rax,%rdx
  801c89:	be 00 00 00 00       	mov    $0x0,%esi
  801c8e:	bf 12 00 00 00       	mov    $0x12,%edi
  801c93:	48 b8 eb 16 80 00 00 	movabs $0x8016eb,%rax
  801c9a:	00 00 00 
  801c9d:	ff d0                	callq  *%rax
  801c9f:	c9                   	leaveq 
  801ca0:	c3                   	retq   

0000000000801ca1 <fd2num>:
  801ca1:	55                   	push   %rbp
  801ca2:	48 89 e5             	mov    %rsp,%rbp
  801ca5:	48 83 ec 08          	sub    $0x8,%rsp
  801ca9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801cad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801cb1:	48 b8 00 00 00 30 ff 	movabs $0xffffffff30000000,%rax
  801cb8:	ff ff ff 
  801cbb:	48 01 d0             	add    %rdx,%rax
  801cbe:	48 c1 e8 0c          	shr    $0xc,%rax
  801cc2:	c9                   	leaveq 
  801cc3:	c3                   	retq   

0000000000801cc4 <fd2data>:
  801cc4:	55                   	push   %rbp
  801cc5:	48 89 e5             	mov    %rsp,%rbp
  801cc8:	48 83 ec 08          	sub    $0x8,%rsp
  801ccc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801cd4:	48 89 c7             	mov    %rax,%rdi
  801cd7:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  801cde:	00 00 00 
  801ce1:	ff d0                	callq  *%rax
  801ce3:	48 05 20 00 0d 00    	add    $0xd0020,%rax
  801ce9:	48 c1 e0 0c          	shl    $0xc,%rax
  801ced:	c9                   	leaveq 
  801cee:	c3                   	retq   

0000000000801cef <fd_alloc>:
  801cef:	55                   	push   %rbp
  801cf0:	48 89 e5             	mov    %rsp,%rbp
  801cf3:	48 83 ec 18          	sub    $0x18,%rsp
  801cf7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801cfb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801d02:	eb 6b                	jmp    801d6f <fd_alloc+0x80>
  801d04:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801d07:	48 98                	cltq   
  801d09:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801d0f:	48 c1 e0 0c          	shl    $0xc,%rax
  801d13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801d17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d1b:	48 c1 e8 15          	shr    $0x15,%rax
  801d1f:	48 89 c2             	mov    %rax,%rdx
  801d22:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801d29:	01 00 00 
  801d2c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801d30:	83 e0 01             	and    $0x1,%eax
  801d33:	48 85 c0             	test   %rax,%rax
  801d36:	74 21                	je     801d59 <fd_alloc+0x6a>
  801d38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d3c:	48 c1 e8 0c          	shr    $0xc,%rax
  801d40:	48 89 c2             	mov    %rax,%rdx
  801d43:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801d4a:	01 00 00 
  801d4d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801d51:	83 e0 01             	and    $0x1,%eax
  801d54:	48 85 c0             	test   %rax,%rax
  801d57:	75 12                	jne    801d6b <fd_alloc+0x7c>
  801d59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d5d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  801d61:	48 89 10             	mov    %rdx,(%rax)
  801d64:	b8 00 00 00 00       	mov    $0x0,%eax
  801d69:	eb 1a                	jmp    801d85 <fd_alloc+0x96>
  801d6b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801d6f:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  801d73:	7e 8f                	jle    801d04 <fd_alloc+0x15>
  801d75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801d79:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801d80:	b8 f5 ff ff ff       	mov    $0xfffffff5,%eax
  801d85:	c9                   	leaveq 
  801d86:	c3                   	retq   

0000000000801d87 <fd_lookup>:
  801d87:	55                   	push   %rbp
  801d88:	48 89 e5             	mov    %rsp,%rbp
  801d8b:	48 83 ec 20          	sub    $0x20,%rsp
  801d8f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801d92:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801d96:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  801d9a:	78 06                	js     801da2 <fd_lookup+0x1b>
  801d9c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%rbp)
  801da0:	7e 07                	jle    801da9 <fd_lookup+0x22>
  801da2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801da7:	eb 6c                	jmp    801e15 <fd_lookup+0x8e>
  801da9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801dac:	48 98                	cltq   
  801dae:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  801db4:	48 c1 e0 0c          	shl    $0xc,%rax
  801db8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  801dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801dc0:	48 c1 e8 15          	shr    $0x15,%rax
  801dc4:	48 89 c2             	mov    %rax,%rdx
  801dc7:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  801dce:	01 00 00 
  801dd1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801dd5:	83 e0 01             	and    $0x1,%eax
  801dd8:	48 85 c0             	test   %rax,%rax
  801ddb:	74 21                	je     801dfe <fd_lookup+0x77>
  801ddd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  801de1:	48 c1 e8 0c          	shr    $0xc,%rax
  801de5:	48 89 c2             	mov    %rax,%rdx
  801de8:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  801def:	01 00 00 
  801df2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801df6:	83 e0 01             	and    $0x1,%eax
  801df9:	48 85 c0             	test   %rax,%rax
  801dfc:	75 07                	jne    801e05 <fd_lookup+0x7e>
  801dfe:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801e03:	eb 10                	jmp    801e15 <fd_lookup+0x8e>
  801e05:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801e09:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  801e0d:	48 89 10             	mov    %rdx,(%rax)
  801e10:	b8 00 00 00 00       	mov    $0x0,%eax
  801e15:	c9                   	leaveq 
  801e16:	c3                   	retq   

0000000000801e17 <fd_close>:
  801e17:	55                   	push   %rbp
  801e18:	48 89 e5             	mov    %rsp,%rbp
  801e1b:	48 83 ec 30          	sub    $0x30,%rsp
  801e1f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801e23:	89 f0                	mov    %esi,%eax
  801e25:	88 45 d4             	mov    %al,-0x2c(%rbp)
  801e28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e2c:	48 89 c7             	mov    %rax,%rdi
  801e2f:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  801e36:	00 00 00 
  801e39:	ff d0                	callq  *%rax
  801e3b:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801e3f:	48 89 d6             	mov    %rdx,%rsi
  801e42:	89 c7                	mov    %eax,%edi
  801e44:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  801e4b:	00 00 00 
  801e4e:	ff d0                	callq  *%rax
  801e50:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801e53:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801e57:	78 0a                	js     801e63 <fd_close+0x4c>
  801e59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801e5d:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  801e61:	74 12                	je     801e75 <fd_close+0x5e>
  801e63:	80 7d d4 00          	cmpb   $0x0,-0x2c(%rbp)
  801e67:	74 05                	je     801e6e <fd_close+0x57>
  801e69:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801e6c:	eb 05                	jmp    801e73 <fd_close+0x5c>
  801e6e:	b8 00 00 00 00       	mov    $0x0,%eax
  801e73:	eb 69                	jmp    801ede <fd_close+0xc7>
  801e75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801e79:	8b 00                	mov    (%rax),%eax
  801e7b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  801e7f:	48 89 d6             	mov    %rdx,%rsi
  801e82:	89 c7                	mov    %eax,%edi
  801e84:	48 b8 e0 1e 80 00 00 	movabs $0x801ee0,%rax
  801e8b:	00 00 00 
  801e8e:	ff d0                	callq  *%rax
  801e90:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801e93:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801e97:	78 2a                	js     801ec3 <fd_close+0xac>
  801e99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801e9d:	48 8b 40 20          	mov    0x20(%rax),%rax
  801ea1:	48 85 c0             	test   %rax,%rax
  801ea4:	74 16                	je     801ebc <fd_close+0xa5>
  801ea6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801eaa:	48 8b 40 20          	mov    0x20(%rax),%rax
  801eae:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801eb2:	48 89 d7             	mov    %rdx,%rdi
  801eb5:	ff d0                	callq  *%rax
  801eb7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801eba:	eb 07                	jmp    801ec3 <fd_close+0xac>
  801ebc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ec3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ec7:	48 89 c6             	mov    %rax,%rsi
  801eca:	bf 00 00 00 00       	mov    $0x0,%edi
  801ecf:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  801ed6:	00 00 00 
  801ed9:	ff d0                	callq  *%rax
  801edb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ede:	c9                   	leaveq 
  801edf:	c3                   	retq   

0000000000801ee0 <dev_lookup>:
  801ee0:	55                   	push   %rbp
  801ee1:	48 89 e5             	mov    %rsp,%rbp
  801ee4:	48 83 ec 20          	sub    $0x20,%rsp
  801ee8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801eeb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  801eef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ef6:	eb 41                	jmp    801f39 <dev_lookup+0x59>
  801ef8:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801eff:	00 00 00 
  801f02:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f05:	48 63 d2             	movslq %edx,%rdx
  801f08:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f0c:	8b 00                	mov    (%rax),%eax
  801f0e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  801f11:	75 22                	jne    801f35 <dev_lookup+0x55>
  801f13:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801f1a:	00 00 00 
  801f1d:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f20:	48 63 d2             	movslq %edx,%rdx
  801f23:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
  801f27:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f2b:	48 89 10             	mov    %rdx,(%rax)
  801f2e:	b8 00 00 00 00       	mov    $0x0,%eax
  801f33:	eb 60                	jmp    801f95 <dev_lookup+0xb5>
  801f35:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  801f39:	48 b8 20 60 80 00 00 	movabs $0x806020,%rax
  801f40:	00 00 00 
  801f43:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801f46:	48 63 d2             	movslq %edx,%rdx
  801f49:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  801f4d:	48 85 c0             	test   %rax,%rax
  801f50:	75 a6                	jne    801ef8 <dev_lookup+0x18>
  801f52:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  801f59:	00 00 00 
  801f5c:	48 8b 00             	mov    (%rax),%rax
  801f5f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  801f65:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801f68:	89 c6                	mov    %eax,%esi
  801f6a:	48 bf 98 47 80 00 00 	movabs $0x804798,%rdi
  801f71:	00 00 00 
  801f74:	b8 00 00 00 00       	mov    $0x0,%eax
  801f79:	48 b9 dd 03 80 00 00 	movabs $0x8003dd,%rcx
  801f80:	00 00 00 
  801f83:	ff d1                	callq  *%rcx
  801f85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  801f89:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  801f90:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801f95:	c9                   	leaveq 
  801f96:	c3                   	retq   

0000000000801f97 <close>:
  801f97:	55                   	push   %rbp
  801f98:	48 89 e5             	mov    %rsp,%rbp
  801f9b:	48 83 ec 20          	sub    $0x20,%rsp
  801f9f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801fa2:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  801fa6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801fa9:	48 89 d6             	mov    %rdx,%rsi
  801fac:	89 c7                	mov    %eax,%edi
  801fae:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  801fb5:	00 00 00 
  801fb8:	ff d0                	callq  *%rax
  801fba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801fbd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  801fc1:	79 05                	jns    801fc8 <close+0x31>
  801fc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801fc6:	eb 18                	jmp    801fe0 <close+0x49>
  801fc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801fcc:	be 01 00 00 00       	mov    $0x1,%esi
  801fd1:	48 89 c7             	mov    %rax,%rdi
  801fd4:	48 b8 17 1e 80 00 00 	movabs $0x801e17,%rax
  801fdb:	00 00 00 
  801fde:	ff d0                	callq  *%rax
  801fe0:	c9                   	leaveq 
  801fe1:	c3                   	retq   

0000000000801fe2 <close_all>:
  801fe2:	55                   	push   %rbp
  801fe3:	48 89 e5             	mov    %rsp,%rbp
  801fe6:	48 83 ec 10          	sub    $0x10,%rsp
  801fea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801ff1:	eb 15                	jmp    802008 <close_all+0x26>
  801ff3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801ff6:	89 c7                	mov    %eax,%edi
  801ff8:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  801fff:	00 00 00 
  802002:	ff d0                	callq  *%rax
  802004:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  802008:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
  80200c:	7e e5                	jle    801ff3 <close_all+0x11>
  80200e:	c9                   	leaveq 
  80200f:	c3                   	retq   

0000000000802010 <dup>:
  802010:	55                   	push   %rbp
  802011:	48 89 e5             	mov    %rsp,%rbp
  802014:	48 83 ec 40          	sub    $0x40,%rsp
  802018:	89 7d cc             	mov    %edi,-0x34(%rbp)
  80201b:	89 75 c8             	mov    %esi,-0x38(%rbp)
  80201e:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
  802022:	8b 45 cc             	mov    -0x34(%rbp),%eax
  802025:	48 89 d6             	mov    %rdx,%rsi
  802028:	89 c7                	mov    %eax,%edi
  80202a:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  802031:	00 00 00 
  802034:	ff d0                	callq  *%rax
  802036:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802039:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80203d:	79 08                	jns    802047 <dup+0x37>
  80203f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802042:	e9 70 01 00 00       	jmpq   8021b7 <dup+0x1a7>
  802047:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80204a:	89 c7                	mov    %eax,%edi
  80204c:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802053:	00 00 00 
  802056:	ff d0                	callq  *%rax
  802058:	8b 45 c8             	mov    -0x38(%rbp),%eax
  80205b:	48 98                	cltq   
  80205d:	48 05 00 00 0d 00    	add    $0xd0000,%rax
  802063:	48 c1 e0 0c          	shl    $0xc,%rax
  802067:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  80206b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80206f:	48 89 c7             	mov    %rax,%rdi
  802072:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  802079:	00 00 00 
  80207c:	ff d0                	callq  *%rax
  80207e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802082:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802086:	48 89 c7             	mov    %rax,%rdi
  802089:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  802090:	00 00 00 
  802093:	ff d0                	callq  *%rax
  802095:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802099:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80209d:	48 c1 e8 15          	shr    $0x15,%rax
  8020a1:	48 89 c2             	mov    %rax,%rdx
  8020a4:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  8020ab:	01 00 00 
  8020ae:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020b2:	83 e0 01             	and    $0x1,%eax
  8020b5:	48 85 c0             	test   %rax,%rax
  8020b8:	74 73                	je     80212d <dup+0x11d>
  8020ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020be:	48 c1 e8 0c          	shr    $0xc,%rax
  8020c2:	48 89 c2             	mov    %rax,%rdx
  8020c5:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8020cc:	01 00 00 
  8020cf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020d3:	83 e0 01             	and    $0x1,%eax
  8020d6:	48 85 c0             	test   %rax,%rax
  8020d9:	74 52                	je     80212d <dup+0x11d>
  8020db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8020df:	48 c1 e8 0c          	shr    $0xc,%rax
  8020e3:	48 89 c2             	mov    %rax,%rdx
  8020e6:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  8020ed:	01 00 00 
  8020f0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  8020f4:	25 07 0e 00 00       	and    $0xe07,%eax
  8020f9:	89 c1                	mov    %eax,%ecx
  8020fb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8020ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802103:	41 89 c8             	mov    %ecx,%r8d
  802106:	48 89 d1             	mov    %rdx,%rcx
  802109:	ba 00 00 00 00       	mov    $0x0,%edx
  80210e:	48 89 c6             	mov    %rax,%rsi
  802111:	bf 00 00 00 00       	mov    $0x0,%edi
  802116:	48 b8 11 19 80 00 00 	movabs $0x801911,%rax
  80211d:	00 00 00 
  802120:	ff d0                	callq  *%rax
  802122:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802125:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802129:	79 02                	jns    80212d <dup+0x11d>
  80212b:	eb 57                	jmp    802184 <dup+0x174>
  80212d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802131:	48 c1 e8 0c          	shr    $0xc,%rax
  802135:	48 89 c2             	mov    %rax,%rdx
  802138:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  80213f:	01 00 00 
  802142:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  802146:	25 07 0e 00 00       	and    $0xe07,%eax
  80214b:	89 c1                	mov    %eax,%ecx
  80214d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802151:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802155:	41 89 c8             	mov    %ecx,%r8d
  802158:	48 89 d1             	mov    %rdx,%rcx
  80215b:	ba 00 00 00 00       	mov    $0x0,%edx
  802160:	48 89 c6             	mov    %rax,%rsi
  802163:	bf 00 00 00 00       	mov    $0x0,%edi
  802168:	48 b8 11 19 80 00 00 	movabs $0x801911,%rax
  80216f:	00 00 00 
  802172:	ff d0                	callq  *%rax
  802174:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802177:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80217b:	79 02                	jns    80217f <dup+0x16f>
  80217d:	eb 05                	jmp    802184 <dup+0x174>
  80217f:	8b 45 c8             	mov    -0x38(%rbp),%eax
  802182:	eb 33                	jmp    8021b7 <dup+0x1a7>
  802184:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802188:	48 89 c6             	mov    %rax,%rsi
  80218b:	bf 00 00 00 00       	mov    $0x0,%edi
  802190:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  802197:	00 00 00 
  80219a:	ff d0                	callq  *%rax
  80219c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8021a0:	48 89 c6             	mov    %rax,%rsi
  8021a3:	bf 00 00 00 00       	mov    $0x0,%edi
  8021a8:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  8021af:	00 00 00 
  8021b2:	ff d0                	callq  *%rax
  8021b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8021b7:	c9                   	leaveq 
  8021b8:	c3                   	retq   

00000000008021b9 <read>:
  8021b9:	55                   	push   %rbp
  8021ba:	48 89 e5             	mov    %rsp,%rbp
  8021bd:	48 83 ec 40          	sub    $0x40,%rsp
  8021c1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8021c4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8021c8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8021cc:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8021d0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8021d3:	48 89 d6             	mov    %rdx,%rsi
  8021d6:	89 c7                	mov    %eax,%edi
  8021d8:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  8021df:	00 00 00 
  8021e2:	ff d0                	callq  *%rax
  8021e4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8021e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8021eb:	78 24                	js     802211 <read+0x58>
  8021ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021f1:	8b 00                	mov    (%rax),%eax
  8021f3:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8021f7:	48 89 d6             	mov    %rdx,%rsi
  8021fa:	89 c7                	mov    %eax,%edi
  8021fc:	48 b8 e0 1e 80 00 00 	movabs $0x801ee0,%rax
  802203:	00 00 00 
  802206:	ff d0                	callq  *%rax
  802208:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80220b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80220f:	79 05                	jns    802216 <read+0x5d>
  802211:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802214:	eb 76                	jmp    80228c <read+0xd3>
  802216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80221a:	8b 40 08             	mov    0x8(%rax),%eax
  80221d:	83 e0 03             	and    $0x3,%eax
  802220:	83 f8 01             	cmp    $0x1,%eax
  802223:	75 3a                	jne    80225f <read+0xa6>
  802225:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80222c:	00 00 00 
  80222f:	48 8b 00             	mov    (%rax),%rax
  802232:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802238:	8b 55 dc             	mov    -0x24(%rbp),%edx
  80223b:	89 c6                	mov    %eax,%esi
  80223d:	48 bf b7 47 80 00 00 	movabs $0x8047b7,%rdi
  802244:	00 00 00 
  802247:	b8 00 00 00 00       	mov    $0x0,%eax
  80224c:	48 b9 dd 03 80 00 00 	movabs $0x8003dd,%rcx
  802253:	00 00 00 
  802256:	ff d1                	callq  *%rcx
  802258:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80225d:	eb 2d                	jmp    80228c <read+0xd3>
  80225f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802263:	48 8b 40 10          	mov    0x10(%rax),%rax
  802267:	48 85 c0             	test   %rax,%rax
  80226a:	75 07                	jne    802273 <read+0xba>
  80226c:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802271:	eb 19                	jmp    80228c <read+0xd3>
  802273:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802277:	48 8b 40 10          	mov    0x10(%rax),%rax
  80227b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  80227f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802283:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  802287:	48 89 cf             	mov    %rcx,%rdi
  80228a:	ff d0                	callq  *%rax
  80228c:	c9                   	leaveq 
  80228d:	c3                   	retq   

000000000080228e <readn>:
  80228e:	55                   	push   %rbp
  80228f:	48 89 e5             	mov    %rsp,%rbp
  802292:	48 83 ec 30          	sub    $0x30,%rsp
  802296:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802299:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80229d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8022a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8022a8:	eb 49                	jmp    8022f3 <readn+0x65>
  8022aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022ad:	48 98                	cltq   
  8022af:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8022b3:	48 29 c2             	sub    %rax,%rdx
  8022b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022b9:	48 63 c8             	movslq %eax,%rcx
  8022bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8022c0:	48 01 c1             	add    %rax,%rcx
  8022c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8022c6:	48 89 ce             	mov    %rcx,%rsi
  8022c9:	89 c7                	mov    %eax,%edi
  8022cb:	48 b8 b9 21 80 00 00 	movabs $0x8021b9,%rax
  8022d2:	00 00 00 
  8022d5:	ff d0                	callq  *%rax
  8022d7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8022da:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022de:	79 05                	jns    8022e5 <readn+0x57>
  8022e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022e3:	eb 1c                	jmp    802301 <readn+0x73>
  8022e5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  8022e9:	75 02                	jne    8022ed <readn+0x5f>
  8022eb:	eb 11                	jmp    8022fe <readn+0x70>
  8022ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
  8022f0:	01 45 fc             	add    %eax,-0x4(%rbp)
  8022f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8022f6:	48 98                	cltq   
  8022f8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  8022fc:	72 ac                	jb     8022aa <readn+0x1c>
  8022fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802301:	c9                   	leaveq 
  802302:	c3                   	retq   

0000000000802303 <write>:
  802303:	55                   	push   %rbp
  802304:	48 89 e5             	mov    %rsp,%rbp
  802307:	48 83 ec 40          	sub    $0x40,%rsp
  80230b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  80230e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  802312:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  802316:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80231a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80231d:	48 89 d6             	mov    %rdx,%rsi
  802320:	89 c7                	mov    %eax,%edi
  802322:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  802329:	00 00 00 
  80232c:	ff d0                	callq  *%rax
  80232e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802331:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802335:	78 24                	js     80235b <write+0x58>
  802337:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80233b:	8b 00                	mov    (%rax),%eax
  80233d:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802341:	48 89 d6             	mov    %rdx,%rsi
  802344:	89 c7                	mov    %eax,%edi
  802346:	48 b8 e0 1e 80 00 00 	movabs $0x801ee0,%rax
  80234d:	00 00 00 
  802350:	ff d0                	callq  *%rax
  802352:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802355:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802359:	79 05                	jns    802360 <write+0x5d>
  80235b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80235e:	eb 75                	jmp    8023d5 <write+0xd2>
  802360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802364:	8b 40 08             	mov    0x8(%rax),%eax
  802367:	83 e0 03             	and    $0x3,%eax
  80236a:	85 c0                	test   %eax,%eax
  80236c:	75 3a                	jne    8023a8 <write+0xa5>
  80236e:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802375:	00 00 00 
  802378:	48 8b 00             	mov    (%rax),%rax
  80237b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802381:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802384:	89 c6                	mov    %eax,%esi
  802386:	48 bf d3 47 80 00 00 	movabs $0x8047d3,%rdi
  80238d:	00 00 00 
  802390:	b8 00 00 00 00       	mov    $0x0,%eax
  802395:	48 b9 dd 03 80 00 00 	movabs $0x8003dd,%rcx
  80239c:	00 00 00 
  80239f:	ff d1                	callq  *%rcx
  8023a1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8023a6:	eb 2d                	jmp    8023d5 <write+0xd2>
  8023a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023ac:	48 8b 40 18          	mov    0x18(%rax),%rax
  8023b0:	48 85 c0             	test   %rax,%rax
  8023b3:	75 07                	jne    8023bc <write+0xb9>
  8023b5:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8023ba:	eb 19                	jmp    8023d5 <write+0xd2>
  8023bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8023c0:	48 8b 40 18          	mov    0x18(%rax),%rax
  8023c4:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  8023c8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8023cc:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  8023d0:	48 89 cf             	mov    %rcx,%rdi
  8023d3:	ff d0                	callq  *%rax
  8023d5:	c9                   	leaveq 
  8023d6:	c3                   	retq   

00000000008023d7 <seek>:
  8023d7:	55                   	push   %rbp
  8023d8:	48 89 e5             	mov    %rsp,%rbp
  8023db:	48 83 ec 18          	sub    $0x18,%rsp
  8023df:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8023e2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8023e5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  8023e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8023ec:	48 89 d6             	mov    %rdx,%rsi
  8023ef:	89 c7                	mov    %eax,%edi
  8023f1:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  8023f8:	00 00 00 
  8023fb:	ff d0                	callq  *%rax
  8023fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802400:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802404:	79 05                	jns    80240b <seek+0x34>
  802406:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802409:	eb 0f                	jmp    80241a <seek+0x43>
  80240b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80240f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802412:	89 50 04             	mov    %edx,0x4(%rax)
  802415:	b8 00 00 00 00       	mov    $0x0,%eax
  80241a:	c9                   	leaveq 
  80241b:	c3                   	retq   

000000000080241c <ftruncate>:
  80241c:	55                   	push   %rbp
  80241d:	48 89 e5             	mov    %rsp,%rbp
  802420:	48 83 ec 30          	sub    $0x30,%rsp
  802424:	89 7d dc             	mov    %edi,-0x24(%rbp)
  802427:	89 75 d8             	mov    %esi,-0x28(%rbp)
  80242a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  80242e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802431:	48 89 d6             	mov    %rdx,%rsi
  802434:	89 c7                	mov    %eax,%edi
  802436:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  80243d:	00 00 00 
  802440:	ff d0                	callq  *%rax
  802442:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802445:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802449:	78 24                	js     80246f <ftruncate+0x53>
  80244b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80244f:	8b 00                	mov    (%rax),%eax
  802451:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802455:	48 89 d6             	mov    %rdx,%rsi
  802458:	89 c7                	mov    %eax,%edi
  80245a:	48 b8 e0 1e 80 00 00 	movabs $0x801ee0,%rax
  802461:	00 00 00 
  802464:	ff d0                	callq  *%rax
  802466:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802469:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80246d:	79 05                	jns    802474 <ftruncate+0x58>
  80246f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802472:	eb 72                	jmp    8024e6 <ftruncate+0xca>
  802474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802478:	8b 40 08             	mov    0x8(%rax),%eax
  80247b:	83 e0 03             	and    $0x3,%eax
  80247e:	85 c0                	test   %eax,%eax
  802480:	75 3a                	jne    8024bc <ftruncate+0xa0>
  802482:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  802489:	00 00 00 
  80248c:	48 8b 00             	mov    (%rax),%rax
  80248f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  802495:	8b 55 dc             	mov    -0x24(%rbp),%edx
  802498:	89 c6                	mov    %eax,%esi
  80249a:	48 bf f0 47 80 00 00 	movabs $0x8047f0,%rdi
  8024a1:	00 00 00 
  8024a4:	b8 00 00 00 00       	mov    $0x0,%eax
  8024a9:	48 b9 dd 03 80 00 00 	movabs $0x8003dd,%rcx
  8024b0:	00 00 00 
  8024b3:	ff d1                	callq  *%rcx
  8024b5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8024ba:	eb 2a                	jmp    8024e6 <ftruncate+0xca>
  8024bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024c0:	48 8b 40 30          	mov    0x30(%rax),%rax
  8024c4:	48 85 c0             	test   %rax,%rax
  8024c7:	75 07                	jne    8024d0 <ftruncate+0xb4>
  8024c9:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  8024ce:	eb 16                	jmp    8024e6 <ftruncate+0xca>
  8024d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8024d4:	48 8b 40 30          	mov    0x30(%rax),%rax
  8024d8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8024dc:	8b 4d d8             	mov    -0x28(%rbp),%ecx
  8024df:	89 ce                	mov    %ecx,%esi
  8024e1:	48 89 d7             	mov    %rdx,%rdi
  8024e4:	ff d0                	callq  *%rax
  8024e6:	c9                   	leaveq 
  8024e7:	c3                   	retq   

00000000008024e8 <fstat>:
  8024e8:	55                   	push   %rbp
  8024e9:	48 89 e5             	mov    %rsp,%rbp
  8024ec:	48 83 ec 30          	sub    $0x30,%rsp
  8024f0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8024f3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8024f7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8024fb:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8024fe:	48 89 d6             	mov    %rdx,%rsi
  802501:	89 c7                	mov    %eax,%edi
  802503:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  80250a:	00 00 00 
  80250d:	ff d0                	callq  *%rax
  80250f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802512:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802516:	78 24                	js     80253c <fstat+0x54>
  802518:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80251c:	8b 00                	mov    (%rax),%eax
  80251e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802522:	48 89 d6             	mov    %rdx,%rsi
  802525:	89 c7                	mov    %eax,%edi
  802527:	48 b8 e0 1e 80 00 00 	movabs $0x801ee0,%rax
  80252e:	00 00 00 
  802531:	ff d0                	callq  *%rax
  802533:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802536:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80253a:	79 05                	jns    802541 <fstat+0x59>
  80253c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80253f:	eb 5e                	jmp    80259f <fstat+0xb7>
  802541:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802545:	48 8b 40 28          	mov    0x28(%rax),%rax
  802549:	48 85 c0             	test   %rax,%rax
  80254c:	75 07                	jne    802555 <fstat+0x6d>
  80254e:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802553:	eb 4a                	jmp    80259f <fstat+0xb7>
  802555:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802559:	c6 00 00             	movb   $0x0,(%rax)
  80255c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802560:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%rax)
  802567:	00 00 00 
  80256a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80256e:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  802575:	00 00 00 
  802578:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80257c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802580:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  802587:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80258b:	48 8b 40 28          	mov    0x28(%rax),%rax
  80258f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802593:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  802597:	48 89 ce             	mov    %rcx,%rsi
  80259a:	48 89 d7             	mov    %rdx,%rdi
  80259d:	ff d0                	callq  *%rax
  80259f:	c9                   	leaveq 
  8025a0:	c3                   	retq   

00000000008025a1 <stat>:
  8025a1:	55                   	push   %rbp
  8025a2:	48 89 e5             	mov    %rsp,%rbp
  8025a5:	48 83 ec 20          	sub    $0x20,%rsp
  8025a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8025ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8025b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025b5:	be 00 00 00 00       	mov    $0x0,%esi
  8025ba:	48 89 c7             	mov    %rax,%rdi
  8025bd:	48 b8 8f 26 80 00 00 	movabs $0x80268f,%rax
  8025c4:	00 00 00 
  8025c7:	ff d0                	callq  *%rax
  8025c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8025cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8025d0:	79 05                	jns    8025d7 <stat+0x36>
  8025d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025d5:	eb 2f                	jmp    802606 <stat+0x65>
  8025d7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8025db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025de:	48 89 d6             	mov    %rdx,%rsi
  8025e1:	89 c7                	mov    %eax,%edi
  8025e3:	48 b8 e8 24 80 00 00 	movabs $0x8024e8,%rax
  8025ea:	00 00 00 
  8025ed:	ff d0                	callq  *%rax
  8025ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
  8025f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8025f5:	89 c7                	mov    %eax,%edi
  8025f7:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  8025fe:	00 00 00 
  802601:	ff d0                	callq  *%rax
  802603:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802606:	c9                   	leaveq 
  802607:	c3                   	retq   

0000000000802608 <fsipc>:
  802608:	55                   	push   %rbp
  802609:	48 89 e5             	mov    %rsp,%rbp
  80260c:	48 83 ec 10          	sub    $0x10,%rsp
  802610:	89 7d fc             	mov    %edi,-0x4(%rbp)
  802613:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802617:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80261e:	00 00 00 
  802621:	8b 00                	mov    (%rax),%eax
  802623:	85 c0                	test   %eax,%eax
  802625:	75 1d                	jne    802644 <fsipc+0x3c>
  802627:	bf 01 00 00 00       	mov    $0x1,%edi
  80262c:	48 b8 c9 40 80 00 00 	movabs $0x8040c9,%rax
  802633:	00 00 00 
  802636:	ff d0                	callq  *%rax
  802638:	48 ba 00 70 80 00 00 	movabs $0x807000,%rdx
  80263f:	00 00 00 
  802642:	89 02                	mov    %eax,(%rdx)
  802644:	48 b8 00 70 80 00 00 	movabs $0x807000,%rax
  80264b:	00 00 00 
  80264e:	8b 00                	mov    (%rax),%eax
  802650:	8b 75 fc             	mov    -0x4(%rbp),%esi
  802653:	b9 07 00 00 00       	mov    $0x7,%ecx
  802658:	48 ba 00 80 80 00 00 	movabs $0x808000,%rdx
  80265f:	00 00 00 
  802662:	89 c7                	mov    %eax,%edi
  802664:	48 b8 be 3f 80 00 00 	movabs $0x803fbe,%rax
  80266b:	00 00 00 
  80266e:	ff d0                	callq  *%rax
  802670:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802674:	ba 00 00 00 00       	mov    $0x0,%edx
  802679:	48 89 c6             	mov    %rax,%rsi
  80267c:	bf 00 00 00 00       	mov    $0x0,%edi
  802681:	48 b8 fd 3e 80 00 00 	movabs $0x803efd,%rax
  802688:	00 00 00 
  80268b:	ff d0                	callq  *%rax
  80268d:	c9                   	leaveq 
  80268e:	c3                   	retq   

000000000080268f <open>:
  80268f:	55                   	push   %rbp
  802690:	48 89 e5             	mov    %rsp,%rbp
  802693:	48 83 ec 20          	sub    $0x20,%rsp
  802697:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  80269b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  80269e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026a2:	48 89 c7             	mov    %rax,%rdi
  8026a5:	48 b8 26 0f 80 00 00 	movabs $0x800f26,%rax
  8026ac:	00 00 00 
  8026af:	ff d0                	callq  *%rax
  8026b1:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8026b6:	7e 0a                	jle    8026c2 <open+0x33>
  8026b8:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  8026bd:	e9 a5 00 00 00       	jmpq   802767 <open+0xd8>
  8026c2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  8026c6:	48 89 c7             	mov    %rax,%rdi
  8026c9:	48 b8 ef 1c 80 00 00 	movabs $0x801cef,%rax
  8026d0:	00 00 00 
  8026d3:	ff d0                	callq  *%rax
  8026d5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8026d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8026dc:	79 08                	jns    8026e6 <open+0x57>
  8026de:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8026e1:	e9 81 00 00 00       	jmpq   802767 <open+0xd8>
  8026e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026ea:	48 89 c6             	mov    %rax,%rsi
  8026ed:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  8026f4:	00 00 00 
  8026f7:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  8026fe:	00 00 00 
  802701:	ff d0                	callq  *%rax
  802703:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  80270a:	00 00 00 
  80270d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  802710:	89 90 00 04 00 00    	mov    %edx,0x400(%rax)
  802716:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80271a:	48 89 c6             	mov    %rax,%rsi
  80271d:	bf 01 00 00 00       	mov    $0x1,%edi
  802722:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802729:	00 00 00 
  80272c:	ff d0                	callq  *%rax
  80272e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802731:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802735:	79 1d                	jns    802754 <open+0xc5>
  802737:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80273b:	be 00 00 00 00       	mov    $0x0,%esi
  802740:	48 89 c7             	mov    %rax,%rdi
  802743:	48 b8 17 1e 80 00 00 	movabs $0x801e17,%rax
  80274a:	00 00 00 
  80274d:	ff d0                	callq  *%rax
  80274f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802752:	eb 13                	jmp    802767 <open+0xd8>
  802754:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802758:	48 89 c7             	mov    %rax,%rdi
  80275b:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  802762:	00 00 00 
  802765:	ff d0                	callq  *%rax
  802767:	c9                   	leaveq 
  802768:	c3                   	retq   

0000000000802769 <devfile_flush>:
  802769:	55                   	push   %rbp
  80276a:	48 89 e5             	mov    %rsp,%rbp
  80276d:	48 83 ec 10          	sub    $0x10,%rsp
  802771:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802775:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802779:	8b 50 0c             	mov    0xc(%rax),%edx
  80277c:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802783:	00 00 00 
  802786:	89 10                	mov    %edx,(%rax)
  802788:	be 00 00 00 00       	mov    $0x0,%esi
  80278d:	bf 06 00 00 00       	mov    $0x6,%edi
  802792:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802799:	00 00 00 
  80279c:	ff d0                	callq  *%rax
  80279e:	c9                   	leaveq 
  80279f:	c3                   	retq   

00000000008027a0 <devfile_read>:
  8027a0:	55                   	push   %rbp
  8027a1:	48 89 e5             	mov    %rsp,%rbp
  8027a4:	48 83 ec 30          	sub    $0x30,%rsp
  8027a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8027ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8027b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8027b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027b8:	8b 50 0c             	mov    0xc(%rax),%edx
  8027bb:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8027c2:	00 00 00 
  8027c5:	89 10                	mov    %edx,(%rax)
  8027c7:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8027ce:	00 00 00 
  8027d1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  8027d5:	48 89 50 08          	mov    %rdx,0x8(%rax)
  8027d9:	be 00 00 00 00       	mov    $0x0,%esi
  8027de:	bf 03 00 00 00       	mov    $0x3,%edi
  8027e3:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  8027ea:	00 00 00 
  8027ed:	ff d0                	callq  *%rax
  8027ef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8027f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8027f6:	79 08                	jns    802800 <devfile_read+0x60>
  8027f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8027fb:	e9 a4 00 00 00       	jmpq   8028a4 <devfile_read+0x104>
  802800:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802803:	48 98                	cltq   
  802805:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  802809:	76 35                	jbe    802840 <devfile_read+0xa0>
  80280b:	48 b9 16 48 80 00 00 	movabs $0x804816,%rcx
  802812:	00 00 00 
  802815:	48 ba 1d 48 80 00 00 	movabs $0x80481d,%rdx
  80281c:	00 00 00 
  80281f:	be 89 00 00 00       	mov    $0x89,%esi
  802824:	48 bf 32 48 80 00 00 	movabs $0x804832,%rdi
  80282b:	00 00 00 
  80282e:	b8 00 00 00 00       	mov    $0x0,%eax
  802833:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  80283a:	00 00 00 
  80283d:	41 ff d0             	callq  *%r8
  802840:	81 7d fc 00 10 00 00 	cmpl   $0x1000,-0x4(%rbp)
  802847:	7e 35                	jle    80287e <devfile_read+0xde>
  802849:	48 b9 40 48 80 00 00 	movabs $0x804840,%rcx
  802850:	00 00 00 
  802853:	48 ba 1d 48 80 00 00 	movabs $0x80481d,%rdx
  80285a:	00 00 00 
  80285d:	be 8a 00 00 00       	mov    $0x8a,%esi
  802862:	48 bf 32 48 80 00 00 	movabs $0x804832,%rdi
  802869:	00 00 00 
  80286c:	b8 00 00 00 00       	mov    $0x0,%eax
  802871:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  802878:	00 00 00 
  80287b:	41 ff d0             	callq  *%r8
  80287e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802881:	48 63 d0             	movslq %eax,%rdx
  802884:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802888:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  80288f:	00 00 00 
  802892:	48 89 c7             	mov    %rax,%rdi
  802895:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  80289c:	00 00 00 
  80289f:	ff d0                	callq  *%rax
  8028a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8028a4:	c9                   	leaveq 
  8028a5:	c3                   	retq   

00000000008028a6 <devfile_write>:
  8028a6:	55                   	push   %rbp
  8028a7:	48 89 e5             	mov    %rsp,%rbp
  8028aa:	48 83 ec 40          	sub    $0x40,%rsp
  8028ae:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8028b2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8028b6:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8028ba:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8028be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8028c2:	48 c7 45 f0 f4 0f 00 	movq   $0xff4,-0x10(%rbp)
  8028c9:	00 
  8028ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8028ce:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
  8028d2:	48 0f 46 45 f8       	cmovbe -0x8(%rbp),%rax
  8028d7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  8028db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8028df:	8b 50 0c             	mov    0xc(%rax),%edx
  8028e2:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028e9:	00 00 00 
  8028ec:	89 10                	mov    %edx,(%rax)
  8028ee:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8028f5:	00 00 00 
  8028f8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  8028fc:	48 89 50 08          	mov    %rdx,0x8(%rax)
  802900:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  802904:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  802908:	48 89 c6             	mov    %rax,%rsi
  80290b:	48 bf 10 80 80 00 00 	movabs $0x808010,%rdi
  802912:	00 00 00 
  802915:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  80291c:	00 00 00 
  80291f:	ff d0                	callq  *%rax
  802921:	be 00 00 00 00       	mov    $0x0,%esi
  802926:	bf 04 00 00 00       	mov    $0x4,%edi
  80292b:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802932:	00 00 00 
  802935:	ff d0                	callq  *%rax
  802937:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80293a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  80293e:	79 05                	jns    802945 <devfile_write+0x9f>
  802940:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802943:	eb 43                	jmp    802988 <devfile_write+0xe2>
  802945:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802948:	48 98                	cltq   
  80294a:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  80294e:	76 35                	jbe    802985 <devfile_write+0xdf>
  802950:	48 b9 16 48 80 00 00 	movabs $0x804816,%rcx
  802957:	00 00 00 
  80295a:	48 ba 1d 48 80 00 00 	movabs $0x80481d,%rdx
  802961:	00 00 00 
  802964:	be a8 00 00 00       	mov    $0xa8,%esi
  802969:	48 bf 32 48 80 00 00 	movabs $0x804832,%rdi
  802970:	00 00 00 
  802973:	b8 00 00 00 00       	mov    $0x0,%eax
  802978:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  80297f:	00 00 00 
  802982:	41 ff d0             	callq  *%r8
  802985:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802988:	c9                   	leaveq 
  802989:	c3                   	retq   

000000000080298a <devfile_stat>:
  80298a:	55                   	push   %rbp
  80298b:	48 89 e5             	mov    %rsp,%rbp
  80298e:	48 83 ec 20          	sub    $0x20,%rsp
  802992:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802996:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80299a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80299e:	8b 50 0c             	mov    0xc(%rax),%edx
  8029a1:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8029a8:	00 00 00 
  8029ab:	89 10                	mov    %edx,(%rax)
  8029ad:	be 00 00 00 00       	mov    $0x0,%esi
  8029b2:	bf 05 00 00 00       	mov    $0x5,%edi
  8029b7:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  8029be:	00 00 00 
  8029c1:	ff d0                	callq  *%rax
  8029c3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8029c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8029ca:	79 05                	jns    8029d1 <devfile_stat+0x47>
  8029cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8029cf:	eb 56                	jmp    802a27 <devfile_stat+0x9d>
  8029d1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8029d5:	48 be 00 80 80 00 00 	movabs $0x808000,%rsi
  8029dc:	00 00 00 
  8029df:	48 89 c7             	mov    %rax,%rdi
  8029e2:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  8029e9:	00 00 00 
  8029ec:	ff d0                	callq  *%rax
  8029ee:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  8029f5:	00 00 00 
  8029f8:	8b 90 80 00 00 00    	mov    0x80(%rax),%edx
  8029fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a02:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  802a08:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a0f:	00 00 00 
  802a12:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
  802a18:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a1c:	89 90 84 00 00 00    	mov    %edx,0x84(%rax)
  802a22:	b8 00 00 00 00       	mov    $0x0,%eax
  802a27:	c9                   	leaveq 
  802a28:	c3                   	retq   

0000000000802a29 <devfile_trunc>:
  802a29:	55                   	push   %rbp
  802a2a:	48 89 e5             	mov    %rsp,%rbp
  802a2d:	48 83 ec 10          	sub    $0x10,%rsp
  802a31:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a35:	89 75 f4             	mov    %esi,-0xc(%rbp)
  802a38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a3c:	8b 50 0c             	mov    0xc(%rax),%edx
  802a3f:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a46:	00 00 00 
  802a49:	89 10                	mov    %edx,(%rax)
  802a4b:	48 b8 00 80 80 00 00 	movabs $0x808000,%rax
  802a52:	00 00 00 
  802a55:	8b 55 f4             	mov    -0xc(%rbp),%edx
  802a58:	89 50 04             	mov    %edx,0x4(%rax)
  802a5b:	be 00 00 00 00       	mov    $0x0,%esi
  802a60:	bf 02 00 00 00       	mov    $0x2,%edi
  802a65:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802a6c:	00 00 00 
  802a6f:	ff d0                	callq  *%rax
  802a71:	c9                   	leaveq 
  802a72:	c3                   	retq   

0000000000802a73 <remove>:
  802a73:	55                   	push   %rbp
  802a74:	48 89 e5             	mov    %rsp,%rbp
  802a77:	48 83 ec 10          	sub    $0x10,%rsp
  802a7b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802a7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802a83:	48 89 c7             	mov    %rax,%rdi
  802a86:	48 b8 26 0f 80 00 00 	movabs $0x800f26,%rax
  802a8d:	00 00 00 
  802a90:	ff d0                	callq  *%rax
  802a92:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  802a97:	7e 07                	jle    802aa0 <remove+0x2d>
  802a99:	b8 f3 ff ff ff       	mov    $0xfffffff3,%eax
  802a9e:	eb 33                	jmp    802ad3 <remove+0x60>
  802aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802aa4:	48 89 c6             	mov    %rax,%rsi
  802aa7:	48 bf 00 80 80 00 00 	movabs $0x808000,%rdi
  802aae:	00 00 00 
  802ab1:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  802ab8:	00 00 00 
  802abb:	ff d0                	callq  *%rax
  802abd:	be 00 00 00 00       	mov    $0x0,%esi
  802ac2:	bf 07 00 00 00       	mov    $0x7,%edi
  802ac7:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802ace:	00 00 00 
  802ad1:	ff d0                	callq  *%rax
  802ad3:	c9                   	leaveq 
  802ad4:	c3                   	retq   

0000000000802ad5 <sync>:
  802ad5:	55                   	push   %rbp
  802ad6:	48 89 e5             	mov    %rsp,%rbp
  802ad9:	be 00 00 00 00       	mov    $0x0,%esi
  802ade:	bf 08 00 00 00       	mov    $0x8,%edi
  802ae3:	48 b8 08 26 80 00 00 	movabs $0x802608,%rax
  802aea:	00 00 00 
  802aed:	ff d0                	callq  *%rax
  802aef:	5d                   	pop    %rbp
  802af0:	c3                   	retq   

0000000000802af1 <copy>:
  802af1:	55                   	push   %rbp
  802af2:	48 89 e5             	mov    %rsp,%rbp
  802af5:	48 81 ec 20 02 00 00 	sub    $0x220,%rsp
  802afc:	48 89 bd e8 fd ff ff 	mov    %rdi,-0x218(%rbp)
  802b03:	48 89 b5 e0 fd ff ff 	mov    %rsi,-0x220(%rbp)
  802b0a:	48 8b 85 e8 fd ff ff 	mov    -0x218(%rbp),%rax
  802b11:	be 00 00 00 00       	mov    $0x0,%esi
  802b16:	48 89 c7             	mov    %rax,%rdi
  802b19:	48 b8 8f 26 80 00 00 	movabs $0x80268f,%rax
  802b20:	00 00 00 
  802b23:	ff d0                	callq  *%rax
  802b25:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802b28:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802b2c:	79 28                	jns    802b56 <copy+0x65>
  802b2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b31:	89 c6                	mov    %eax,%esi
  802b33:	48 bf 4c 48 80 00 00 	movabs $0x80484c,%rdi
  802b3a:	00 00 00 
  802b3d:	b8 00 00 00 00       	mov    $0x0,%eax
  802b42:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  802b49:	00 00 00 
  802b4c:	ff d2                	callq  *%rdx
  802b4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b51:	e9 74 01 00 00       	jmpq   802cca <copy+0x1d9>
  802b56:	48 8b 85 e0 fd ff ff 	mov    -0x220(%rbp),%rax
  802b5d:	be 01 01 00 00       	mov    $0x101,%esi
  802b62:	48 89 c7             	mov    %rax,%rdi
  802b65:	48 b8 8f 26 80 00 00 	movabs $0x80268f,%rax
  802b6c:	00 00 00 
  802b6f:	ff d0                	callq  *%rax
  802b71:	89 45 f8             	mov    %eax,-0x8(%rbp)
  802b74:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  802b78:	79 39                	jns    802bb3 <copy+0xc2>
  802b7a:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802b7d:	89 c6                	mov    %eax,%esi
  802b7f:	48 bf 62 48 80 00 00 	movabs $0x804862,%rdi
  802b86:	00 00 00 
  802b89:	b8 00 00 00 00       	mov    $0x0,%eax
  802b8e:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  802b95:	00 00 00 
  802b98:	ff d2                	callq  *%rdx
  802b9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802b9d:	89 c7                	mov    %eax,%edi
  802b9f:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802ba6:	00 00 00 
  802ba9:	ff d0                	callq  *%rax
  802bab:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bae:	e9 17 01 00 00       	jmpq   802cca <copy+0x1d9>
  802bb3:	eb 74                	jmp    802c29 <copy+0x138>
  802bb5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802bb8:	48 63 d0             	movslq %eax,%rdx
  802bbb:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802bc2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802bc5:	48 89 ce             	mov    %rcx,%rsi
  802bc8:	89 c7                	mov    %eax,%edi
  802bca:	48 b8 03 23 80 00 00 	movabs $0x802303,%rax
  802bd1:	00 00 00 
  802bd4:	ff d0                	callq  *%rax
  802bd6:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802bd9:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
  802bdd:	79 4a                	jns    802c29 <copy+0x138>
  802bdf:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802be2:	89 c6                	mov    %eax,%esi
  802be4:	48 bf 7c 48 80 00 00 	movabs $0x80487c,%rdi
  802beb:	00 00 00 
  802bee:	b8 00 00 00 00       	mov    $0x0,%eax
  802bf3:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  802bfa:	00 00 00 
  802bfd:	ff d2                	callq  *%rdx
  802bff:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c02:	89 c7                	mov    %eax,%edi
  802c04:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802c0b:	00 00 00 
  802c0e:	ff d0                	callq  *%rax
  802c10:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c13:	89 c7                	mov    %eax,%edi
  802c15:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802c1c:	00 00 00 
  802c1f:	ff d0                	callq  *%rax
  802c21:	8b 45 f0             	mov    -0x10(%rbp),%eax
  802c24:	e9 a1 00 00 00       	jmpq   802cca <copy+0x1d9>
  802c29:	48 8d 8d f0 fd ff ff 	lea    -0x210(%rbp),%rcx
  802c30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c33:	ba 00 02 00 00       	mov    $0x200,%edx
  802c38:	48 89 ce             	mov    %rcx,%rsi
  802c3b:	89 c7                	mov    %eax,%edi
  802c3d:	48 b8 b9 21 80 00 00 	movabs $0x8021b9,%rax
  802c44:	00 00 00 
  802c47:	ff d0                	callq  *%rax
  802c49:	89 45 f4             	mov    %eax,-0xc(%rbp)
  802c4c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802c50:	0f 8f 5f ff ff ff    	jg     802bb5 <copy+0xc4>
  802c56:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
  802c5a:	79 47                	jns    802ca3 <copy+0x1b2>
  802c5c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802c5f:	89 c6                	mov    %eax,%esi
  802c61:	48 bf 8f 48 80 00 00 	movabs $0x80488f,%rdi
  802c68:	00 00 00 
  802c6b:	b8 00 00 00 00       	mov    $0x0,%eax
  802c70:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  802c77:	00 00 00 
  802c7a:	ff d2                	callq  *%rdx
  802c7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802c7f:	89 c7                	mov    %eax,%edi
  802c81:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802c88:	00 00 00 
  802c8b:	ff d0                	callq  *%rax
  802c8d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802c90:	89 c7                	mov    %eax,%edi
  802c92:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802c99:	00 00 00 
  802c9c:	ff d0                	callq  *%rax
  802c9e:	8b 45 f4             	mov    -0xc(%rbp),%eax
  802ca1:	eb 27                	jmp    802cca <copy+0x1d9>
  802ca3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802ca6:	89 c7                	mov    %eax,%edi
  802ca8:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802caf:	00 00 00 
  802cb2:	ff d0                	callq  *%rax
  802cb4:	8b 45 f8             	mov    -0x8(%rbp),%eax
  802cb7:	89 c7                	mov    %eax,%edi
  802cb9:	48 b8 97 1f 80 00 00 	movabs $0x801f97,%rax
  802cc0:	00 00 00 
  802cc3:	ff d0                	callq  *%rax
  802cc5:	b8 00 00 00 00       	mov    $0x0,%eax
  802cca:	c9                   	leaveq 
  802ccb:	c3                   	retq   

0000000000802ccc <fd2sockid>:
  802ccc:	55                   	push   %rbp
  802ccd:	48 89 e5             	mov    %rsp,%rbp
  802cd0:	48 83 ec 20          	sub    $0x20,%rsp
  802cd4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802cd7:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  802cdb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802cde:	48 89 d6             	mov    %rdx,%rsi
  802ce1:	89 c7                	mov    %eax,%edi
  802ce3:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  802cea:	00 00 00 
  802ced:	ff d0                	callq  *%rax
  802cef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802cf2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802cf6:	79 05                	jns    802cfd <fd2sockid+0x31>
  802cf8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802cfb:	eb 24                	jmp    802d21 <fd2sockid+0x55>
  802cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d01:	8b 10                	mov    (%rax),%edx
  802d03:	48 b8 a0 60 80 00 00 	movabs $0x8060a0,%rax
  802d0a:	00 00 00 
  802d0d:	8b 00                	mov    (%rax),%eax
  802d0f:	39 c2                	cmp    %eax,%edx
  802d11:	74 07                	je     802d1a <fd2sockid+0x4e>
  802d13:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  802d18:	eb 07                	jmp    802d21 <fd2sockid+0x55>
  802d1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d1e:	8b 40 0c             	mov    0xc(%rax),%eax
  802d21:	c9                   	leaveq 
  802d22:	c3                   	retq   

0000000000802d23 <alloc_sockfd>:
  802d23:	55                   	push   %rbp
  802d24:	48 89 e5             	mov    %rsp,%rbp
  802d27:	48 83 ec 20          	sub    $0x20,%rsp
  802d2b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802d2e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  802d32:	48 89 c7             	mov    %rax,%rdi
  802d35:	48 b8 ef 1c 80 00 00 	movabs $0x801cef,%rax
  802d3c:	00 00 00 
  802d3f:	ff d0                	callq  *%rax
  802d41:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d44:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d48:	78 26                	js     802d70 <alloc_sockfd+0x4d>
  802d4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d4e:	ba 07 04 00 00       	mov    $0x407,%edx
  802d53:	48 89 c6             	mov    %rax,%rsi
  802d56:	bf 00 00 00 00       	mov    $0x0,%edi
  802d5b:	48 b8 c1 18 80 00 00 	movabs $0x8018c1,%rax
  802d62:	00 00 00 
  802d65:	ff d0                	callq  *%rax
  802d67:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802d6a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802d6e:	79 16                	jns    802d86 <alloc_sockfd+0x63>
  802d70:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802d73:	89 c7                	mov    %eax,%edi
  802d75:	48 b8 30 32 80 00 00 	movabs $0x803230,%rax
  802d7c:	00 00 00 
  802d7f:	ff d0                	callq  *%rax
  802d81:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802d84:	eb 3a                	jmp    802dc0 <alloc_sockfd+0x9d>
  802d86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d8a:	48 ba a0 60 80 00 00 	movabs $0x8060a0,%rdx
  802d91:	00 00 00 
  802d94:	8b 12                	mov    (%rdx),%edx
  802d96:	89 10                	mov    %edx,(%rax)
  802d98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802d9c:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  802da3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802da7:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802daa:	89 50 0c             	mov    %edx,0xc(%rax)
  802dad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802db1:	48 89 c7             	mov    %rax,%rdi
  802db4:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  802dbb:	00 00 00 
  802dbe:	ff d0                	callq  *%rax
  802dc0:	c9                   	leaveq 
  802dc1:	c3                   	retq   

0000000000802dc2 <accept>:
  802dc2:	55                   	push   %rbp
  802dc3:	48 89 e5             	mov    %rsp,%rbp
  802dc6:	48 83 ec 30          	sub    $0x30,%rsp
  802dca:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802dcd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802dd1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802dd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802dd8:	89 c7                	mov    %eax,%edi
  802dda:	48 b8 cc 2c 80 00 00 	movabs $0x802ccc,%rax
  802de1:	00 00 00 
  802de4:	ff d0                	callq  *%rax
  802de6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802de9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ded:	79 05                	jns    802df4 <accept+0x32>
  802def:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802df2:	eb 3b                	jmp    802e2f <accept+0x6d>
  802df4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  802df8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802dfc:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802dff:	48 89 ce             	mov    %rcx,%rsi
  802e02:	89 c7                	mov    %eax,%edi
  802e04:	48 b8 0d 31 80 00 00 	movabs $0x80310d,%rax
  802e0b:	00 00 00 
  802e0e:	ff d0                	callq  *%rax
  802e10:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e13:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e17:	79 05                	jns    802e1e <accept+0x5c>
  802e19:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e1c:	eb 11                	jmp    802e2f <accept+0x6d>
  802e1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e21:	89 c7                	mov    %eax,%edi
  802e23:	48 b8 23 2d 80 00 00 	movabs $0x802d23,%rax
  802e2a:	00 00 00 
  802e2d:	ff d0                	callq  *%rax
  802e2f:	c9                   	leaveq 
  802e30:	c3                   	retq   

0000000000802e31 <bind>:
  802e31:	55                   	push   %rbp
  802e32:	48 89 e5             	mov    %rsp,%rbp
  802e35:	48 83 ec 20          	sub    $0x20,%rsp
  802e39:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802e3c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802e40:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802e43:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e46:	89 c7                	mov    %eax,%edi
  802e48:	48 b8 cc 2c 80 00 00 	movabs $0x802ccc,%rax
  802e4f:	00 00 00 
  802e52:	ff d0                	callq  *%rax
  802e54:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802e57:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802e5b:	79 05                	jns    802e62 <bind+0x31>
  802e5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e60:	eb 1b                	jmp    802e7d <bind+0x4c>
  802e62:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802e65:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802e69:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802e6c:	48 89 ce             	mov    %rcx,%rsi
  802e6f:	89 c7                	mov    %eax,%edi
  802e71:	48 b8 8c 31 80 00 00 	movabs $0x80318c,%rax
  802e78:	00 00 00 
  802e7b:	ff d0                	callq  *%rax
  802e7d:	c9                   	leaveq 
  802e7e:	c3                   	retq   

0000000000802e7f <shutdown>:
  802e7f:	55                   	push   %rbp
  802e80:	48 89 e5             	mov    %rsp,%rbp
  802e83:	48 83 ec 20          	sub    $0x20,%rsp
  802e87:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802e8a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802e8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802e90:	89 c7                	mov    %eax,%edi
  802e92:	48 b8 cc 2c 80 00 00 	movabs $0x802ccc,%rax
  802e99:	00 00 00 
  802e9c:	ff d0                	callq  *%rax
  802e9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802ea1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802ea5:	79 05                	jns    802eac <shutdown+0x2d>
  802ea7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802eaa:	eb 16                	jmp    802ec2 <shutdown+0x43>
  802eac:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802eaf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802eb2:	89 d6                	mov    %edx,%esi
  802eb4:	89 c7                	mov    %eax,%edi
  802eb6:	48 b8 f0 31 80 00 00 	movabs $0x8031f0,%rax
  802ebd:	00 00 00 
  802ec0:	ff d0                	callq  *%rax
  802ec2:	c9                   	leaveq 
  802ec3:	c3                   	retq   

0000000000802ec4 <devsock_close>:
  802ec4:	55                   	push   %rbp
  802ec5:	48 89 e5             	mov    %rsp,%rbp
  802ec8:	48 83 ec 10          	sub    $0x10,%rsp
  802ecc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802ed0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ed4:	48 89 c7             	mov    %rax,%rdi
  802ed7:	48 b8 3b 41 80 00 00 	movabs $0x80413b,%rax
  802ede:	00 00 00 
  802ee1:	ff d0                	callq  *%rax
  802ee3:	83 f8 01             	cmp    $0x1,%eax
  802ee6:	75 17                	jne    802eff <devsock_close+0x3b>
  802ee8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802eec:	8b 40 0c             	mov    0xc(%rax),%eax
  802eef:	89 c7                	mov    %eax,%edi
  802ef1:	48 b8 30 32 80 00 00 	movabs $0x803230,%rax
  802ef8:	00 00 00 
  802efb:	ff d0                	callq  *%rax
  802efd:	eb 05                	jmp    802f04 <devsock_close+0x40>
  802eff:	b8 00 00 00 00       	mov    $0x0,%eax
  802f04:	c9                   	leaveq 
  802f05:	c3                   	retq   

0000000000802f06 <connect>:
  802f06:	55                   	push   %rbp
  802f07:	48 89 e5             	mov    %rsp,%rbp
  802f0a:	48 83 ec 20          	sub    $0x20,%rsp
  802f0e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f11:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f15:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802f18:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f1b:	89 c7                	mov    %eax,%edi
  802f1d:	48 b8 cc 2c 80 00 00 	movabs $0x802ccc,%rax
  802f24:	00 00 00 
  802f27:	ff d0                	callq  *%rax
  802f29:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f2c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f30:	79 05                	jns    802f37 <connect+0x31>
  802f32:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f35:	eb 1b                	jmp    802f52 <connect+0x4c>
  802f37:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802f3a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802f3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f41:	48 89 ce             	mov    %rcx,%rsi
  802f44:	89 c7                	mov    %eax,%edi
  802f46:	48 b8 5d 32 80 00 00 	movabs $0x80325d,%rax
  802f4d:	00 00 00 
  802f50:	ff d0                	callq  *%rax
  802f52:	c9                   	leaveq 
  802f53:	c3                   	retq   

0000000000802f54 <listen>:
  802f54:	55                   	push   %rbp
  802f55:	48 89 e5             	mov    %rsp,%rbp
  802f58:	48 83 ec 20          	sub    $0x20,%rsp
  802f5c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f5f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  802f62:	8b 45 ec             	mov    -0x14(%rbp),%eax
  802f65:	89 c7                	mov    %eax,%edi
  802f67:	48 b8 cc 2c 80 00 00 	movabs $0x802ccc,%rax
  802f6e:	00 00 00 
  802f71:	ff d0                	callq  *%rax
  802f73:	89 45 fc             	mov    %eax,-0x4(%rbp)
  802f76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  802f7a:	79 05                	jns    802f81 <listen+0x2d>
  802f7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f7f:	eb 16                	jmp    802f97 <listen+0x43>
  802f81:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802f84:	8b 45 fc             	mov    -0x4(%rbp),%eax
  802f87:	89 d6                	mov    %edx,%esi
  802f89:	89 c7                	mov    %eax,%edi
  802f8b:	48 b8 c1 32 80 00 00 	movabs $0x8032c1,%rax
  802f92:	00 00 00 
  802f95:	ff d0                	callq  *%rax
  802f97:	c9                   	leaveq 
  802f98:	c3                   	retq   

0000000000802f99 <devsock_read>:
  802f99:	55                   	push   %rbp
  802f9a:	48 89 e5             	mov    %rsp,%rbp
  802f9d:	48 83 ec 20          	sub    $0x20,%rsp
  802fa1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fa5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802fa9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802fad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802fb1:	89 c2                	mov    %eax,%edx
  802fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802fb7:	8b 40 0c             	mov    0xc(%rax),%eax
  802fba:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802fbe:	b9 00 00 00 00       	mov    $0x0,%ecx
  802fc3:	89 c7                	mov    %eax,%edi
  802fc5:	48 b8 01 33 80 00 00 	movabs $0x803301,%rax
  802fcc:	00 00 00 
  802fcf:	ff d0                	callq  *%rax
  802fd1:	c9                   	leaveq 
  802fd2:	c3                   	retq   

0000000000802fd3 <devsock_write>:
  802fd3:	55                   	push   %rbp
  802fd4:	48 89 e5             	mov    %rsp,%rbp
  802fd7:	48 83 ec 20          	sub    $0x20,%rsp
  802fdb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802fdf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802fe3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802fe7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802feb:	89 c2                	mov    %eax,%edx
  802fed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ff1:	8b 40 0c             	mov    0xc(%rax),%eax
  802ff4:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802ff8:	b9 00 00 00 00       	mov    $0x0,%ecx
  802ffd:	89 c7                	mov    %eax,%edi
  802fff:	48 b8 cd 33 80 00 00 	movabs $0x8033cd,%rax
  803006:	00 00 00 
  803009:	ff d0                	callq  *%rax
  80300b:	c9                   	leaveq 
  80300c:	c3                   	retq   

000000000080300d <devsock_stat>:
  80300d:	55                   	push   %rbp
  80300e:	48 89 e5             	mov    %rsp,%rbp
  803011:	48 83 ec 10          	sub    $0x10,%rsp
  803015:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803019:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80301d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803021:	48 be aa 48 80 00 00 	movabs $0x8048aa,%rsi
  803028:	00 00 00 
  80302b:	48 89 c7             	mov    %rax,%rdi
  80302e:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  803035:	00 00 00 
  803038:	ff d0                	callq  *%rax
  80303a:	b8 00 00 00 00       	mov    $0x0,%eax
  80303f:	c9                   	leaveq 
  803040:	c3                   	retq   

0000000000803041 <socket>:
  803041:	55                   	push   %rbp
  803042:	48 89 e5             	mov    %rsp,%rbp
  803045:	48 83 ec 20          	sub    $0x20,%rsp
  803049:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80304c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  80304f:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  803052:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  803055:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  803058:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80305b:	89 ce                	mov    %ecx,%esi
  80305d:	89 c7                	mov    %eax,%edi
  80305f:	48 b8 85 34 80 00 00 	movabs $0x803485,%rax
  803066:	00 00 00 
  803069:	ff d0                	callq  *%rax
  80306b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  80306e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803072:	79 05                	jns    803079 <socket+0x38>
  803074:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803077:	eb 11                	jmp    80308a <socket+0x49>
  803079:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80307c:	89 c7                	mov    %eax,%edi
  80307e:	48 b8 23 2d 80 00 00 	movabs $0x802d23,%rax
  803085:	00 00 00 
  803088:	ff d0                	callq  *%rax
  80308a:	c9                   	leaveq 
  80308b:	c3                   	retq   

000000000080308c <nsipc>:
  80308c:	55                   	push   %rbp
  80308d:	48 89 e5             	mov    %rsp,%rbp
  803090:	48 83 ec 10          	sub    $0x10,%rsp
  803094:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803097:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  80309e:	00 00 00 
  8030a1:	8b 00                	mov    (%rax),%eax
  8030a3:	85 c0                	test   %eax,%eax
  8030a5:	75 1d                	jne    8030c4 <nsipc+0x38>
  8030a7:	bf 02 00 00 00       	mov    $0x2,%edi
  8030ac:	48 b8 c9 40 80 00 00 	movabs $0x8040c9,%rax
  8030b3:	00 00 00 
  8030b6:	ff d0                	callq  *%rax
  8030b8:	48 ba 04 70 80 00 00 	movabs $0x807004,%rdx
  8030bf:	00 00 00 
  8030c2:	89 02                	mov    %eax,(%rdx)
  8030c4:	48 b8 04 70 80 00 00 	movabs $0x807004,%rax
  8030cb:	00 00 00 
  8030ce:	8b 00                	mov    (%rax),%eax
  8030d0:	8b 75 fc             	mov    -0x4(%rbp),%esi
  8030d3:	b9 07 00 00 00       	mov    $0x7,%ecx
  8030d8:	48 ba 00 a0 80 00 00 	movabs $0x80a000,%rdx
  8030df:	00 00 00 
  8030e2:	89 c7                	mov    %eax,%edi
  8030e4:	48 b8 be 3f 80 00 00 	movabs $0x803fbe,%rax
  8030eb:	00 00 00 
  8030ee:	ff d0                	callq  *%rax
  8030f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8030f5:	be 00 00 00 00       	mov    $0x0,%esi
  8030fa:	bf 00 00 00 00       	mov    $0x0,%edi
  8030ff:	48 b8 fd 3e 80 00 00 	movabs $0x803efd,%rax
  803106:	00 00 00 
  803109:	ff d0                	callq  *%rax
  80310b:	c9                   	leaveq 
  80310c:	c3                   	retq   

000000000080310d <nsipc_accept>:
  80310d:	55                   	push   %rbp
  80310e:	48 89 e5             	mov    %rsp,%rbp
  803111:	48 83 ec 30          	sub    $0x30,%rsp
  803115:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803118:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80311c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803120:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803127:	00 00 00 
  80312a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80312d:	89 10                	mov    %edx,(%rax)
  80312f:	bf 01 00 00 00       	mov    $0x1,%edi
  803134:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  80313b:	00 00 00 
  80313e:	ff d0                	callq  *%rax
  803140:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803143:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803147:	78 3e                	js     803187 <nsipc_accept+0x7a>
  803149:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803150:	00 00 00 
  803153:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803157:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80315b:	8b 40 10             	mov    0x10(%rax),%eax
  80315e:	89 c2                	mov    %eax,%edx
  803160:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  803164:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803168:	48 89 ce             	mov    %rcx,%rsi
  80316b:	48 89 c7             	mov    %rax,%rdi
  80316e:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  803175:	00 00 00 
  803178:	ff d0                	callq  *%rax
  80317a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80317e:	8b 50 10             	mov    0x10(%rax),%edx
  803181:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803185:	89 10                	mov    %edx,(%rax)
  803187:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80318a:	c9                   	leaveq 
  80318b:	c3                   	retq   

000000000080318c <nsipc_bind>:
  80318c:	55                   	push   %rbp
  80318d:	48 89 e5             	mov    %rsp,%rbp
  803190:	48 83 ec 10          	sub    $0x10,%rsp
  803194:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803197:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80319b:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80319e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8031a5:	00 00 00 
  8031a8:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8031ab:	89 10                	mov    %edx,(%rax)
  8031ad:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8031b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8031b4:	48 89 c6             	mov    %rax,%rsi
  8031b7:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  8031be:	00 00 00 
  8031c1:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  8031c8:	00 00 00 
  8031cb:	ff d0                	callq  *%rax
  8031cd:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8031d4:	00 00 00 
  8031d7:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8031da:	89 50 14             	mov    %edx,0x14(%rax)
  8031dd:	bf 02 00 00 00       	mov    $0x2,%edi
  8031e2:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  8031e9:	00 00 00 
  8031ec:	ff d0                	callq  *%rax
  8031ee:	c9                   	leaveq 
  8031ef:	c3                   	retq   

00000000008031f0 <nsipc_shutdown>:
  8031f0:	55                   	push   %rbp
  8031f1:	48 89 e5             	mov    %rsp,%rbp
  8031f4:	48 83 ec 10          	sub    $0x10,%rsp
  8031f8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8031fb:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8031fe:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803205:	00 00 00 
  803208:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80320b:	89 10                	mov    %edx,(%rax)
  80320d:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803214:	00 00 00 
  803217:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80321a:	89 50 04             	mov    %edx,0x4(%rax)
  80321d:	bf 03 00 00 00       	mov    $0x3,%edi
  803222:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  803229:	00 00 00 
  80322c:	ff d0                	callq  *%rax
  80322e:	c9                   	leaveq 
  80322f:	c3                   	retq   

0000000000803230 <nsipc_close>:
  803230:	55                   	push   %rbp
  803231:	48 89 e5             	mov    %rsp,%rbp
  803234:	48 83 ec 10          	sub    $0x10,%rsp
  803238:	89 7d fc             	mov    %edi,-0x4(%rbp)
  80323b:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803242:	00 00 00 
  803245:	8b 55 fc             	mov    -0x4(%rbp),%edx
  803248:	89 10                	mov    %edx,(%rax)
  80324a:	bf 04 00 00 00       	mov    $0x4,%edi
  80324f:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  803256:	00 00 00 
  803259:	ff d0                	callq  *%rax
  80325b:	c9                   	leaveq 
  80325c:	c3                   	retq   

000000000080325d <nsipc_connect>:
  80325d:	55                   	push   %rbp
  80325e:	48 89 e5             	mov    %rsp,%rbp
  803261:	48 83 ec 10          	sub    $0x10,%rsp
  803265:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803268:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  80326c:	89 55 f8             	mov    %edx,-0x8(%rbp)
  80326f:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803276:	00 00 00 
  803279:	8b 55 fc             	mov    -0x4(%rbp),%edx
  80327c:	89 10                	mov    %edx,(%rax)
  80327e:	8b 55 f8             	mov    -0x8(%rbp),%edx
  803281:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803285:	48 89 c6             	mov    %rax,%rsi
  803288:	48 bf 04 a0 80 00 00 	movabs $0x80a004,%rdi
  80328f:	00 00 00 
  803292:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  803299:	00 00 00 
  80329c:	ff d0                	callq  *%rax
  80329e:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032a5:	00 00 00 
  8032a8:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8032ab:	89 50 14             	mov    %edx,0x14(%rax)
  8032ae:	bf 05 00 00 00       	mov    $0x5,%edi
  8032b3:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  8032ba:	00 00 00 
  8032bd:	ff d0                	callq  *%rax
  8032bf:	c9                   	leaveq 
  8032c0:	c3                   	retq   

00000000008032c1 <nsipc_listen>:
  8032c1:	55                   	push   %rbp
  8032c2:	48 89 e5             	mov    %rsp,%rbp
  8032c5:	48 83 ec 10          	sub    $0x10,%rsp
  8032c9:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8032cc:	89 75 f8             	mov    %esi,-0x8(%rbp)
  8032cf:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032d6:	00 00 00 
  8032d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8032dc:	89 10                	mov    %edx,(%rax)
  8032de:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8032e5:	00 00 00 
  8032e8:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8032eb:	89 50 04             	mov    %edx,0x4(%rax)
  8032ee:	bf 06 00 00 00       	mov    $0x6,%edi
  8032f3:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  8032fa:	00 00 00 
  8032fd:	ff d0                	callq  *%rax
  8032ff:	c9                   	leaveq 
  803300:	c3                   	retq   

0000000000803301 <nsipc_recv>:
  803301:	55                   	push   %rbp
  803302:	48 89 e5             	mov    %rsp,%rbp
  803305:	48 83 ec 30          	sub    $0x30,%rsp
  803309:	89 7d ec             	mov    %edi,-0x14(%rbp)
  80330c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803310:	89 55 e8             	mov    %edx,-0x18(%rbp)
  803313:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803316:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80331d:	00 00 00 
  803320:	8b 55 ec             	mov    -0x14(%rbp),%edx
  803323:	89 10                	mov    %edx,(%rax)
  803325:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80332c:	00 00 00 
  80332f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  803332:	89 50 04             	mov    %edx,0x4(%rax)
  803335:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80333c:	00 00 00 
  80333f:	8b 55 dc             	mov    -0x24(%rbp),%edx
  803342:	89 50 08             	mov    %edx,0x8(%rax)
  803345:	bf 07 00 00 00       	mov    $0x7,%edi
  80334a:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  803351:	00 00 00 
  803354:	ff d0                	callq  *%rax
  803356:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803359:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  80335d:	78 69                	js     8033c8 <nsipc_recv+0xc7>
  80335f:	81 7d fc 3f 06 00 00 	cmpl   $0x63f,-0x4(%rbp)
  803366:	7f 08                	jg     803370 <nsipc_recv+0x6f>
  803368:	8b 45 fc             	mov    -0x4(%rbp),%eax
  80336b:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  80336e:	7e 35                	jle    8033a5 <nsipc_recv+0xa4>
  803370:	48 b9 b1 48 80 00 00 	movabs $0x8048b1,%rcx
  803377:	00 00 00 
  80337a:	48 ba c6 48 80 00 00 	movabs $0x8048c6,%rdx
  803381:	00 00 00 
  803384:	be 62 00 00 00       	mov    $0x62,%esi
  803389:	48 bf db 48 80 00 00 	movabs $0x8048db,%rdi
  803390:	00 00 00 
  803393:	b8 00 00 00 00       	mov    $0x0,%eax
  803398:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  80339f:	00 00 00 
  8033a2:	41 ff d0             	callq  *%r8
  8033a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033a8:	48 63 d0             	movslq %eax,%rdx
  8033ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8033af:	48 be 00 a0 80 00 00 	movabs $0x80a000,%rsi
  8033b6:	00 00 00 
  8033b9:	48 89 c7             	mov    %rax,%rdi
  8033bc:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  8033c3:	00 00 00 
  8033c6:	ff d0                	callq  *%rax
  8033c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8033cb:	c9                   	leaveq 
  8033cc:	c3                   	retq   

00000000008033cd <nsipc_send>:
  8033cd:	55                   	push   %rbp
  8033ce:	48 89 e5             	mov    %rsp,%rbp
  8033d1:	48 83 ec 20          	sub    $0x20,%rsp
  8033d5:	89 7d fc             	mov    %edi,-0x4(%rbp)
  8033d8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  8033dc:	89 55 f8             	mov    %edx,-0x8(%rbp)
  8033df:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  8033e2:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8033e9:	00 00 00 
  8033ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8033ef:	89 10                	mov    %edx,(%rax)
  8033f1:	81 7d f8 3f 06 00 00 	cmpl   $0x63f,-0x8(%rbp)
  8033f8:	7e 35                	jle    80342f <nsipc_send+0x62>
  8033fa:	48 b9 ea 48 80 00 00 	movabs $0x8048ea,%rcx
  803401:	00 00 00 
  803404:	48 ba c6 48 80 00 00 	movabs $0x8048c6,%rdx
  80340b:	00 00 00 
  80340e:	be 6d 00 00 00       	mov    $0x6d,%esi
  803413:	48 bf db 48 80 00 00 	movabs $0x8048db,%rdi
  80341a:	00 00 00 
  80341d:	b8 00 00 00 00       	mov    $0x0,%eax
  803422:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  803429:	00 00 00 
  80342c:	41 ff d0             	callq  *%r8
  80342f:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803432:	48 63 d0             	movslq %eax,%rdx
  803435:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803439:	48 89 c6             	mov    %rax,%rsi
  80343c:	48 bf 0c a0 80 00 00 	movabs $0x80a00c,%rdi
  803443:	00 00 00 
  803446:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  80344d:	00 00 00 
  803450:	ff d0                	callq  *%rax
  803452:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803459:	00 00 00 
  80345c:	8b 55 f8             	mov    -0x8(%rbp),%edx
  80345f:	89 50 04             	mov    %edx,0x4(%rax)
  803462:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  803469:	00 00 00 
  80346c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  80346f:	89 50 08             	mov    %edx,0x8(%rax)
  803472:	bf 08 00 00 00       	mov    $0x8,%edi
  803477:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  80347e:	00 00 00 
  803481:	ff d0                	callq  *%rax
  803483:	c9                   	leaveq 
  803484:	c3                   	retq   

0000000000803485 <nsipc_socket>:
  803485:	55                   	push   %rbp
  803486:	48 89 e5             	mov    %rsp,%rbp
  803489:	48 83 ec 10          	sub    $0x10,%rsp
  80348d:	89 7d fc             	mov    %edi,-0x4(%rbp)
  803490:	89 75 f8             	mov    %esi,-0x8(%rbp)
  803493:	89 55 f4             	mov    %edx,-0xc(%rbp)
  803496:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  80349d:	00 00 00 
  8034a0:	8b 55 fc             	mov    -0x4(%rbp),%edx
  8034a3:	89 10                	mov    %edx,(%rax)
  8034a5:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8034ac:	00 00 00 
  8034af:	8b 55 f8             	mov    -0x8(%rbp),%edx
  8034b2:	89 50 04             	mov    %edx,0x4(%rax)
  8034b5:	48 b8 00 a0 80 00 00 	movabs $0x80a000,%rax
  8034bc:	00 00 00 
  8034bf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8034c2:	89 50 08             	mov    %edx,0x8(%rax)
  8034c5:	bf 09 00 00 00       	mov    $0x9,%edi
  8034ca:	48 b8 8c 30 80 00 00 	movabs $0x80308c,%rax
  8034d1:	00 00 00 
  8034d4:	ff d0                	callq  *%rax
  8034d6:	c9                   	leaveq 
  8034d7:	c3                   	retq   

00000000008034d8 <pipe>:
  8034d8:	55                   	push   %rbp
  8034d9:	48 89 e5             	mov    %rsp,%rbp
  8034dc:	53                   	push   %rbx
  8034dd:	48 83 ec 38          	sub    $0x38,%rsp
  8034e1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  8034e5:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  8034e9:	48 89 c7             	mov    %rax,%rdi
  8034ec:	48 b8 ef 1c 80 00 00 	movabs $0x801cef,%rax
  8034f3:	00 00 00 
  8034f6:	ff d0                	callq  *%rax
  8034f8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8034fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8034ff:	0f 88 bf 01 00 00    	js     8036c4 <pipe+0x1ec>
  803505:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803509:	ba 07 04 00 00       	mov    $0x407,%edx
  80350e:	48 89 c6             	mov    %rax,%rsi
  803511:	bf 00 00 00 00       	mov    $0x0,%edi
  803516:	48 b8 c1 18 80 00 00 	movabs $0x8018c1,%rax
  80351d:	00 00 00 
  803520:	ff d0                	callq  *%rax
  803522:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803525:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803529:	0f 88 95 01 00 00    	js     8036c4 <pipe+0x1ec>
  80352f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  803533:	48 89 c7             	mov    %rax,%rdi
  803536:	48 b8 ef 1c 80 00 00 	movabs $0x801cef,%rax
  80353d:	00 00 00 
  803540:	ff d0                	callq  *%rax
  803542:	89 45 ec             	mov    %eax,-0x14(%rbp)
  803545:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803549:	0f 88 5d 01 00 00    	js     8036ac <pipe+0x1d4>
  80354f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803553:	ba 07 04 00 00       	mov    $0x407,%edx
  803558:	48 89 c6             	mov    %rax,%rsi
  80355b:	bf 00 00 00 00       	mov    $0x0,%edi
  803560:	48 b8 c1 18 80 00 00 	movabs $0x8018c1,%rax
  803567:	00 00 00 
  80356a:	ff d0                	callq  *%rax
  80356c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80356f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803573:	0f 88 33 01 00 00    	js     8036ac <pipe+0x1d4>
  803579:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80357d:	48 89 c7             	mov    %rax,%rdi
  803580:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  803587:	00 00 00 
  80358a:	ff d0                	callq  *%rax
  80358c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803590:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803594:	ba 07 04 00 00       	mov    $0x407,%edx
  803599:	48 89 c6             	mov    %rax,%rsi
  80359c:	bf 00 00 00 00       	mov    $0x0,%edi
  8035a1:	48 b8 c1 18 80 00 00 	movabs $0x8018c1,%rax
  8035a8:	00 00 00 
  8035ab:	ff d0                	callq  *%rax
  8035ad:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8035b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8035b4:	79 05                	jns    8035bb <pipe+0xe3>
  8035b6:	e9 d9 00 00 00       	jmpq   803694 <pipe+0x1bc>
  8035bb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8035bf:	48 89 c7             	mov    %rax,%rdi
  8035c2:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8035c9:	00 00 00 
  8035cc:	ff d0                	callq  *%rax
  8035ce:	48 89 c2             	mov    %rax,%rdx
  8035d1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8035d5:	41 b8 07 04 00 00    	mov    $0x407,%r8d
  8035db:	48 89 d1             	mov    %rdx,%rcx
  8035de:	ba 00 00 00 00       	mov    $0x0,%edx
  8035e3:	48 89 c6             	mov    %rax,%rsi
  8035e6:	bf 00 00 00 00       	mov    $0x0,%edi
  8035eb:	48 b8 11 19 80 00 00 	movabs $0x801911,%rax
  8035f2:	00 00 00 
  8035f5:	ff d0                	callq  *%rax
  8035f7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8035fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  8035fe:	79 1b                	jns    80361b <pipe+0x143>
  803600:	90                   	nop
  803601:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803605:	48 89 c6             	mov    %rax,%rsi
  803608:	bf 00 00 00 00       	mov    $0x0,%edi
  80360d:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  803614:	00 00 00 
  803617:	ff d0                	callq  *%rax
  803619:	eb 79                	jmp    803694 <pipe+0x1bc>
  80361b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80361f:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  803626:	00 00 00 
  803629:	8b 12                	mov    (%rdx),%edx
  80362b:	89 10                	mov    %edx,(%rax)
  80362d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803631:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  803638:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80363c:	48 ba e0 60 80 00 00 	movabs $0x8060e0,%rdx
  803643:	00 00 00 
  803646:	8b 12                	mov    (%rdx),%edx
  803648:	89 10                	mov    %edx,(%rax)
  80364a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80364e:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  803655:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803659:	48 89 c7             	mov    %rax,%rdi
  80365c:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  803663:	00 00 00 
  803666:	ff d0                	callq  *%rax
  803668:	89 c2                	mov    %eax,%edx
  80366a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  80366e:	89 10                	mov    %edx,(%rax)
  803670:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  803674:	48 8d 58 04          	lea    0x4(%rax),%rbx
  803678:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80367c:	48 89 c7             	mov    %rax,%rdi
  80367f:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  803686:	00 00 00 
  803689:	ff d0                	callq  *%rax
  80368b:	89 03                	mov    %eax,(%rbx)
  80368d:	b8 00 00 00 00       	mov    $0x0,%eax
  803692:	eb 33                	jmp    8036c7 <pipe+0x1ef>
  803694:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803698:	48 89 c6             	mov    %rax,%rsi
  80369b:	bf 00 00 00 00       	mov    $0x0,%edi
  8036a0:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  8036a7:	00 00 00 
  8036aa:	ff d0                	callq  *%rax
  8036ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8036b0:	48 89 c6             	mov    %rax,%rsi
  8036b3:	bf 00 00 00 00       	mov    $0x0,%edi
  8036b8:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  8036bf:	00 00 00 
  8036c2:	ff d0                	callq  *%rax
  8036c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8036c7:	48 83 c4 38          	add    $0x38,%rsp
  8036cb:	5b                   	pop    %rbx
  8036cc:	5d                   	pop    %rbp
  8036cd:	c3                   	retq   

00000000008036ce <_pipeisclosed>:
  8036ce:	55                   	push   %rbp
  8036cf:	48 89 e5             	mov    %rsp,%rbp
  8036d2:	53                   	push   %rbx
  8036d3:	48 83 ec 28          	sub    $0x28,%rsp
  8036d7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8036db:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8036df:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  8036e6:	00 00 00 
  8036e9:	48 8b 00             	mov    (%rax),%rax
  8036ec:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  8036f2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8036f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8036f9:	48 89 c7             	mov    %rax,%rdi
  8036fc:	48 b8 3b 41 80 00 00 	movabs $0x80413b,%rax
  803703:	00 00 00 
  803706:	ff d0                	callq  *%rax
  803708:	89 c3                	mov    %eax,%ebx
  80370a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80370e:	48 89 c7             	mov    %rax,%rdi
  803711:	48 b8 3b 41 80 00 00 	movabs $0x80413b,%rax
  803718:	00 00 00 
  80371b:	ff d0                	callq  *%rax
  80371d:	39 c3                	cmp    %eax,%ebx
  80371f:	0f 94 c0             	sete   %al
  803722:	0f b6 c0             	movzbl %al,%eax
  803725:	89 45 e8             	mov    %eax,-0x18(%rbp)
  803728:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  80372f:	00 00 00 
  803732:	48 8b 00             	mov    (%rax),%rax
  803735:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  80373b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  80373e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803741:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803744:	75 05                	jne    80374b <_pipeisclosed+0x7d>
  803746:	8b 45 e8             	mov    -0x18(%rbp),%eax
  803749:	eb 4f                	jmp    80379a <_pipeisclosed+0xcc>
  80374b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  80374e:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  803751:	74 42                	je     803795 <_pipeisclosed+0xc7>
  803753:	83 7d e8 01          	cmpl   $0x1,-0x18(%rbp)
  803757:	75 3c                	jne    803795 <_pipeisclosed+0xc7>
  803759:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803760:	00 00 00 
  803763:	48 8b 00             	mov    (%rax),%rax
  803766:	8b 90 d8 00 00 00    	mov    0xd8(%rax),%edx
  80376c:	8b 4d e8             	mov    -0x18(%rbp),%ecx
  80376f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803772:	89 c6                	mov    %eax,%esi
  803774:	48 bf fb 48 80 00 00 	movabs $0x8048fb,%rdi
  80377b:	00 00 00 
  80377e:	b8 00 00 00 00       	mov    $0x0,%eax
  803783:	49 b8 dd 03 80 00 00 	movabs $0x8003dd,%r8
  80378a:	00 00 00 
  80378d:	41 ff d0             	callq  *%r8
  803790:	e9 4a ff ff ff       	jmpq   8036df <_pipeisclosed+0x11>
  803795:	e9 45 ff ff ff       	jmpq   8036df <_pipeisclosed+0x11>
  80379a:	48 83 c4 28          	add    $0x28,%rsp
  80379e:	5b                   	pop    %rbx
  80379f:	5d                   	pop    %rbp
  8037a0:	c3                   	retq   

00000000008037a1 <pipeisclosed>:
  8037a1:	55                   	push   %rbp
  8037a2:	48 89 e5             	mov    %rsp,%rbp
  8037a5:	48 83 ec 30          	sub    $0x30,%rsp
  8037a9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8037ac:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
  8037b0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8037b3:	48 89 d6             	mov    %rdx,%rsi
  8037b6:	89 c7                	mov    %eax,%edi
  8037b8:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  8037bf:	00 00 00 
  8037c2:	ff d0                	callq  *%rax
  8037c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  8037c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  8037cb:	79 05                	jns    8037d2 <pipeisclosed+0x31>
  8037cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8037d0:	eb 31                	jmp    803803 <pipeisclosed+0x62>
  8037d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037d6:	48 89 c7             	mov    %rax,%rdi
  8037d9:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8037e0:	00 00 00 
  8037e3:	ff d0                	callq  *%rax
  8037e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  8037e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8037ed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8037f1:	48 89 d6             	mov    %rdx,%rsi
  8037f4:	48 89 c7             	mov    %rax,%rdi
  8037f7:	48 b8 ce 36 80 00 00 	movabs $0x8036ce,%rax
  8037fe:	00 00 00 
  803801:	ff d0                	callq  *%rax
  803803:	c9                   	leaveq 
  803804:	c3                   	retq   

0000000000803805 <devpipe_read>:
  803805:	55                   	push   %rbp
  803806:	48 89 e5             	mov    %rsp,%rbp
  803809:	48 83 ec 40          	sub    $0x40,%rsp
  80380d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  803811:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  803815:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  803819:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80381d:	48 89 c7             	mov    %rax,%rdi
  803820:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  803827:	00 00 00 
  80382a:	ff d0                	callq  *%rax
  80382c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803830:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  803834:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  803838:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  80383f:	00 
  803840:	e9 92 00 00 00       	jmpq   8038d7 <devpipe_read+0xd2>
  803845:	eb 41                	jmp    803888 <devpipe_read+0x83>
  803847:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  80384c:	74 09                	je     803857 <devpipe_read+0x52>
  80384e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803852:	e9 92 00 00 00       	jmpq   8038e9 <devpipe_read+0xe4>
  803857:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80385b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80385f:	48 89 d6             	mov    %rdx,%rsi
  803862:	48 89 c7             	mov    %rax,%rdi
  803865:	48 b8 ce 36 80 00 00 	movabs $0x8036ce,%rax
  80386c:	00 00 00 
  80386f:	ff d0                	callq  *%rax
  803871:	85 c0                	test   %eax,%eax
  803873:	74 07                	je     80387c <devpipe_read+0x77>
  803875:	b8 00 00 00 00       	mov    $0x0,%eax
  80387a:	eb 6d                	jmp    8038e9 <devpipe_read+0xe4>
  80387c:	48 b8 83 18 80 00 00 	movabs $0x801883,%rax
  803883:	00 00 00 
  803886:	ff d0                	callq  *%rax
  803888:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80388c:	8b 10                	mov    (%rax),%edx
  80388e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803892:	8b 40 04             	mov    0x4(%rax),%eax
  803895:	39 c2                	cmp    %eax,%edx
  803897:	74 ae                	je     803847 <devpipe_read+0x42>
  803899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  80389d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  8038a1:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  8038a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038a9:	8b 00                	mov    (%rax),%eax
  8038ab:	99                   	cltd   
  8038ac:	c1 ea 1b             	shr    $0x1b,%edx
  8038af:	01 d0                	add    %edx,%eax
  8038b1:	83 e0 1f             	and    $0x1f,%eax
  8038b4:	29 d0                	sub    %edx,%eax
  8038b6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  8038ba:	48 98                	cltq   
  8038bc:	0f b6 44 02 08       	movzbl 0x8(%rdx,%rax,1),%eax
  8038c1:	88 01                	mov    %al,(%rcx)
  8038c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038c7:	8b 00                	mov    (%rax),%eax
  8038c9:	8d 50 01             	lea    0x1(%rax),%edx
  8038cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8038d0:	89 10                	mov    %edx,(%rax)
  8038d2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8038d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038db:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8038df:	0f 82 60 ff ff ff    	jb     803845 <devpipe_read+0x40>
  8038e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8038e9:	c9                   	leaveq 
  8038ea:	c3                   	retq   

00000000008038eb <devpipe_write>:
  8038eb:	55                   	push   %rbp
  8038ec:	48 89 e5             	mov    %rsp,%rbp
  8038ef:	48 83 ec 40          	sub    $0x40,%rsp
  8038f3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8038f7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8038fb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  8038ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803903:	48 89 c7             	mov    %rax,%rdi
  803906:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  80390d:	00 00 00 
  803910:	ff d0                	callq  *%rax
  803912:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  803916:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  80391a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80391e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  803925:	00 
  803926:	e9 8e 00 00 00       	jmpq   8039b9 <devpipe_write+0xce>
  80392b:	eb 31                	jmp    80395e <devpipe_write+0x73>
  80392d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  803931:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803935:	48 89 d6             	mov    %rdx,%rsi
  803938:	48 89 c7             	mov    %rax,%rdi
  80393b:	48 b8 ce 36 80 00 00 	movabs $0x8036ce,%rax
  803942:	00 00 00 
  803945:	ff d0                	callq  *%rax
  803947:	85 c0                	test   %eax,%eax
  803949:	74 07                	je     803952 <devpipe_write+0x67>
  80394b:	b8 00 00 00 00       	mov    $0x0,%eax
  803950:	eb 79                	jmp    8039cb <devpipe_write+0xe0>
  803952:	48 b8 83 18 80 00 00 	movabs $0x801883,%rax
  803959:	00 00 00 
  80395c:	ff d0                	callq  *%rax
  80395e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803962:	8b 40 04             	mov    0x4(%rax),%eax
  803965:	48 63 d0             	movslq %eax,%rdx
  803968:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80396c:	8b 00                	mov    (%rax),%eax
  80396e:	48 98                	cltq   
  803970:	48 83 c0 20          	add    $0x20,%rax
  803974:	48 39 c2             	cmp    %rax,%rdx
  803977:	73 b4                	jae    80392d <devpipe_write+0x42>
  803979:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  80397d:	8b 40 04             	mov    0x4(%rax),%eax
  803980:	99                   	cltd   
  803981:	c1 ea 1b             	shr    $0x1b,%edx
  803984:	01 d0                	add    %edx,%eax
  803986:	83 e0 1f             	and    $0x1f,%eax
  803989:	29 d0                	sub    %edx,%eax
  80398b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  80398f:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  803993:	48 01 ca             	add    %rcx,%rdx
  803996:	0f b6 0a             	movzbl (%rdx),%ecx
  803999:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  80399d:	48 98                	cltq   
  80399f:	88 4c 02 08          	mov    %cl,0x8(%rdx,%rax,1)
  8039a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039a7:	8b 40 04             	mov    0x4(%rax),%eax
  8039aa:	8d 50 01             	lea    0x1(%rax),%edx
  8039ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  8039b1:	89 50 04             	mov    %edx,0x4(%rax)
  8039b4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  8039b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039bd:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
  8039c1:	0f 82 64 ff ff ff    	jb     80392b <devpipe_write+0x40>
  8039c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8039cb:	c9                   	leaveq 
  8039cc:	c3                   	retq   

00000000008039cd <devpipe_stat>:
  8039cd:	55                   	push   %rbp
  8039ce:	48 89 e5             	mov    %rsp,%rbp
  8039d1:	48 83 ec 20          	sub    $0x20,%rsp
  8039d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8039d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8039dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8039e1:	48 89 c7             	mov    %rax,%rdi
  8039e4:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  8039eb:	00 00 00 
  8039ee:	ff d0                	callq  *%rax
  8039f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  8039f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  8039f8:	48 be 0e 49 80 00 00 	movabs $0x80490e,%rsi
  8039ff:	00 00 00 
  803a02:	48 89 c7             	mov    %rax,%rdi
  803a05:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  803a0c:	00 00 00 
  803a0f:	ff d0                	callq  *%rax
  803a11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a15:	8b 50 04             	mov    0x4(%rax),%edx
  803a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a1c:	8b 00                	mov    (%rax),%eax
  803a1e:	29 c2                	sub    %eax,%edx
  803a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a24:	89 90 80 00 00 00    	mov    %edx,0x80(%rax)
  803a2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a2e:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%rax)
  803a35:	00 00 00 
  803a38:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803a3c:	48 b9 e0 60 80 00 00 	movabs $0x8060e0,%rcx
  803a43:	00 00 00 
  803a46:	48 89 88 88 00 00 00 	mov    %rcx,0x88(%rax)
  803a4d:	b8 00 00 00 00       	mov    $0x0,%eax
  803a52:	c9                   	leaveq 
  803a53:	c3                   	retq   

0000000000803a54 <devpipe_close>:
  803a54:	55                   	push   %rbp
  803a55:	48 89 e5             	mov    %rsp,%rbp
  803a58:	48 83 ec 10          	sub    $0x10,%rsp
  803a5c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a64:	48 89 c6             	mov    %rax,%rsi
  803a67:	bf 00 00 00 00       	mov    $0x0,%edi
  803a6c:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  803a73:	00 00 00 
  803a76:	ff d0                	callq  *%rax
  803a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803a7c:	48 89 c7             	mov    %rax,%rdi
  803a7f:	48 b8 c4 1c 80 00 00 	movabs $0x801cc4,%rax
  803a86:	00 00 00 
  803a89:	ff d0                	callq  *%rax
  803a8b:	48 89 c6             	mov    %rax,%rsi
  803a8e:	bf 00 00 00 00       	mov    $0x0,%edi
  803a93:	48 b8 6c 19 80 00 00 	movabs $0x80196c,%rax
  803a9a:	00 00 00 
  803a9d:	ff d0                	callq  *%rax
  803a9f:	c9                   	leaveq 
  803aa0:	c3                   	retq   

0000000000803aa1 <wait>:
  803aa1:	55                   	push   %rbp
  803aa2:	48 89 e5             	mov    %rsp,%rbp
  803aa5:	48 83 ec 20          	sub    $0x20,%rsp
  803aa9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803aac:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  803ab0:	75 35                	jne    803ae7 <wait+0x46>
  803ab2:	48 b9 15 49 80 00 00 	movabs $0x804915,%rcx
  803ab9:	00 00 00 
  803abc:	48 ba 20 49 80 00 00 	movabs $0x804920,%rdx
  803ac3:	00 00 00 
  803ac6:	be 0a 00 00 00       	mov    $0xa,%esi
  803acb:	48 bf 35 49 80 00 00 	movabs $0x804935,%rdi
  803ad2:	00 00 00 
  803ad5:	b8 00 00 00 00       	mov    $0x0,%eax
  803ada:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  803ae1:	00 00 00 
  803ae4:	41 ff d0             	callq  *%r8
  803ae7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803aea:	25 ff 03 00 00       	and    $0x3ff,%eax
  803aef:	48 98                	cltq   
  803af1:	48 69 d0 68 01 00 00 	imul   $0x168,%rax,%rdx
  803af8:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803aff:	00 00 00 
  803b02:	48 01 d0             	add    %rdx,%rax
  803b05:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  803b09:	eb 0c                	jmp    803b17 <wait+0x76>
  803b0b:	48 b8 83 18 80 00 00 	movabs $0x801883,%rax
  803b12:	00 00 00 
  803b15:	ff d0                	callq  *%rax
  803b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b1b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
  803b21:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  803b24:	75 0e                	jne    803b34 <wait+0x93>
  803b26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  803b2a:	8b 80 d4 00 00 00    	mov    0xd4(%rax),%eax
  803b30:	85 c0                	test   %eax,%eax
  803b32:	75 d7                	jne    803b0b <wait+0x6a>
  803b34:	c9                   	leaveq 
  803b35:	c3                   	retq   

0000000000803b36 <cputchar>:
  803b36:	55                   	push   %rbp
  803b37:	48 89 e5             	mov    %rsp,%rbp
  803b3a:	48 83 ec 20          	sub    $0x20,%rsp
  803b3e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803b41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803b44:	88 45 ff             	mov    %al,-0x1(%rbp)
  803b47:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  803b4b:	be 01 00 00 00       	mov    $0x1,%esi
  803b50:	48 89 c7             	mov    %rax,%rdi
  803b53:	48 b8 79 17 80 00 00 	movabs $0x801779,%rax
  803b5a:	00 00 00 
  803b5d:	ff d0                	callq  *%rax
  803b5f:	c9                   	leaveq 
  803b60:	c3                   	retq   

0000000000803b61 <getchar>:
  803b61:	55                   	push   %rbp
  803b62:	48 89 e5             	mov    %rsp,%rbp
  803b65:	48 83 ec 10          	sub    $0x10,%rsp
  803b69:	48 8d 45 fb          	lea    -0x5(%rbp),%rax
  803b6d:	ba 01 00 00 00       	mov    $0x1,%edx
  803b72:	48 89 c6             	mov    %rax,%rsi
  803b75:	bf 00 00 00 00       	mov    $0x0,%edi
  803b7a:	48 b8 b9 21 80 00 00 	movabs $0x8021b9,%rax
  803b81:	00 00 00 
  803b84:	ff d0                	callq  *%rax
  803b86:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803b89:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b8d:	79 05                	jns    803b94 <getchar+0x33>
  803b8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803b92:	eb 14                	jmp    803ba8 <getchar+0x47>
  803b94:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803b98:	7f 07                	jg     803ba1 <getchar+0x40>
  803b9a:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  803b9f:	eb 07                	jmp    803ba8 <getchar+0x47>
  803ba1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
  803ba5:	0f b6 c0             	movzbl %al,%eax
  803ba8:	c9                   	leaveq 
  803ba9:	c3                   	retq   

0000000000803baa <iscons>:
  803baa:	55                   	push   %rbp
  803bab:	48 89 e5             	mov    %rsp,%rbp
  803bae:	48 83 ec 20          	sub    $0x20,%rsp
  803bb2:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803bb5:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
  803bb9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  803bbc:	48 89 d6             	mov    %rdx,%rsi
  803bbf:	89 c7                	mov    %eax,%edi
  803bc1:	48 b8 87 1d 80 00 00 	movabs $0x801d87,%rax
  803bc8:	00 00 00 
  803bcb:	ff d0                	callq  *%rax
  803bcd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803bd0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803bd4:	79 05                	jns    803bdb <iscons+0x31>
  803bd6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803bd9:	eb 1a                	jmp    803bf5 <iscons+0x4b>
  803bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803bdf:	8b 10                	mov    (%rax),%edx
  803be1:	48 b8 20 61 80 00 00 	movabs $0x806120,%rax
  803be8:	00 00 00 
  803beb:	8b 00                	mov    (%rax),%eax
  803bed:	39 c2                	cmp    %eax,%edx
  803bef:	0f 94 c0             	sete   %al
  803bf2:	0f b6 c0             	movzbl %al,%eax
  803bf5:	c9                   	leaveq 
  803bf6:	c3                   	retq   

0000000000803bf7 <opencons>:
  803bf7:	55                   	push   %rbp
  803bf8:	48 89 e5             	mov    %rsp,%rbp
  803bfb:	48 83 ec 10          	sub    $0x10,%rsp
  803bff:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  803c03:	48 89 c7             	mov    %rax,%rdi
  803c06:	48 b8 ef 1c 80 00 00 	movabs $0x801cef,%rax
  803c0d:	00 00 00 
  803c10:	ff d0                	callq  *%rax
  803c12:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c15:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c19:	79 05                	jns    803c20 <opencons+0x29>
  803c1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c1e:	eb 5b                	jmp    803c7b <opencons+0x84>
  803c20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c24:	ba 07 04 00 00       	mov    $0x407,%edx
  803c29:	48 89 c6             	mov    %rax,%rsi
  803c2c:	bf 00 00 00 00       	mov    $0x0,%edi
  803c31:	48 b8 c1 18 80 00 00 	movabs $0x8018c1,%rax
  803c38:	00 00 00 
  803c3b:	ff d0                	callq  *%rax
  803c3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803c40:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803c44:	79 05                	jns    803c4b <opencons+0x54>
  803c46:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803c49:	eb 30                	jmp    803c7b <opencons+0x84>
  803c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c4f:	48 ba 20 61 80 00 00 	movabs $0x806120,%rdx
  803c56:	00 00 00 
  803c59:	8b 12                	mov    (%rdx),%edx
  803c5b:	89 10                	mov    %edx,(%rax)
  803c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c61:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%rax)
  803c68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803c6c:	48 89 c7             	mov    %rax,%rdi
  803c6f:	48 b8 a1 1c 80 00 00 	movabs $0x801ca1,%rax
  803c76:	00 00 00 
  803c79:	ff d0                	callq  *%rax
  803c7b:	c9                   	leaveq 
  803c7c:	c3                   	retq   

0000000000803c7d <devcons_read>:
  803c7d:	55                   	push   %rbp
  803c7e:	48 89 e5             	mov    %rsp,%rbp
  803c81:	48 83 ec 30          	sub    $0x30,%rsp
  803c85:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803c89:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803c8d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803c91:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803c96:	75 07                	jne    803c9f <devcons_read+0x22>
  803c98:	b8 00 00 00 00       	mov    $0x0,%eax
  803c9d:	eb 4b                	jmp    803cea <devcons_read+0x6d>
  803c9f:	eb 0c                	jmp    803cad <devcons_read+0x30>
  803ca1:	48 b8 83 18 80 00 00 	movabs $0x801883,%rax
  803ca8:	00 00 00 
  803cab:	ff d0                	callq  *%rax
  803cad:	48 b8 c3 17 80 00 00 	movabs $0x8017c3,%rax
  803cb4:	00 00 00 
  803cb7:	ff d0                	callq  *%rax
  803cb9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803cbc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803cc0:	74 df                	je     803ca1 <devcons_read+0x24>
  803cc2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803cc6:	79 05                	jns    803ccd <devcons_read+0x50>
  803cc8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803ccb:	eb 1d                	jmp    803cea <devcons_read+0x6d>
  803ccd:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
  803cd1:	75 07                	jne    803cda <devcons_read+0x5d>
  803cd3:	b8 00 00 00 00       	mov    $0x0,%eax
  803cd8:	eb 10                	jmp    803cea <devcons_read+0x6d>
  803cda:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803cdd:	89 c2                	mov    %eax,%edx
  803cdf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803ce3:	88 10                	mov    %dl,(%rax)
  803ce5:	b8 01 00 00 00       	mov    $0x1,%eax
  803cea:	c9                   	leaveq 
  803ceb:	c3                   	retq   

0000000000803cec <devcons_write>:
  803cec:	55                   	push   %rbp
  803ced:	48 89 e5             	mov    %rsp,%rbp
  803cf0:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  803cf7:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
  803cfe:	48 89 b5 60 ff ff ff 	mov    %rsi,-0xa0(%rbp)
  803d05:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
  803d0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  803d13:	eb 76                	jmp    803d8b <devcons_write+0x9f>
  803d15:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
  803d1c:	89 c2                	mov    %eax,%edx
  803d1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d21:	29 c2                	sub    %eax,%edx
  803d23:	89 d0                	mov    %edx,%eax
  803d25:	89 45 f8             	mov    %eax,-0x8(%rbp)
  803d28:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d2b:	83 f8 7f             	cmp    $0x7f,%eax
  803d2e:	76 07                	jbe    803d37 <devcons_write+0x4b>
  803d30:	c7 45 f8 7f 00 00 00 	movl   $0x7f,-0x8(%rbp)
  803d37:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d3a:	48 63 d0             	movslq %eax,%rdx
  803d3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d40:	48 63 c8             	movslq %eax,%rcx
  803d43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  803d4a:	48 01 c1             	add    %rax,%rcx
  803d4d:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803d54:	48 89 ce             	mov    %rcx,%rsi
  803d57:	48 89 c7             	mov    %rax,%rdi
  803d5a:	48 b8 b6 12 80 00 00 	movabs $0x8012b6,%rax
  803d61:	00 00 00 
  803d64:	ff d0                	callq  *%rax
  803d66:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d69:	48 63 d0             	movslq %eax,%rdx
  803d6c:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
  803d73:	48 89 d6             	mov    %rdx,%rsi
  803d76:	48 89 c7             	mov    %rax,%rdi
  803d79:	48 b8 79 17 80 00 00 	movabs $0x801779,%rax
  803d80:	00 00 00 
  803d83:	ff d0                	callq  *%rax
  803d85:	8b 45 f8             	mov    -0x8(%rbp),%eax
  803d88:	01 45 fc             	add    %eax,-0x4(%rbp)
  803d8b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803d8e:	48 98                	cltq   
  803d90:	48 3b 85 58 ff ff ff 	cmp    -0xa8(%rbp),%rax
  803d97:	0f 82 78 ff ff ff    	jb     803d15 <devcons_write+0x29>
  803d9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803da0:	c9                   	leaveq 
  803da1:	c3                   	retq   

0000000000803da2 <devcons_close>:
  803da2:	55                   	push   %rbp
  803da3:	48 89 e5             	mov    %rsp,%rbp
  803da6:	48 83 ec 08          	sub    $0x8,%rsp
  803daa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803dae:	b8 00 00 00 00       	mov    $0x0,%eax
  803db3:	c9                   	leaveq 
  803db4:	c3                   	retq   

0000000000803db5 <devcons_stat>:
  803db5:	55                   	push   %rbp
  803db6:	48 89 e5             	mov    %rsp,%rbp
  803db9:	48 83 ec 10          	sub    $0x10,%rsp
  803dbd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  803dc1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  803dc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  803dc9:	48 be 48 49 80 00 00 	movabs $0x804948,%rsi
  803dd0:	00 00 00 
  803dd3:	48 89 c7             	mov    %rax,%rdi
  803dd6:	48 b8 92 0f 80 00 00 	movabs $0x800f92,%rax
  803ddd:	00 00 00 
  803de0:	ff d0                	callq  *%rax
  803de2:	b8 00 00 00 00       	mov    $0x0,%eax
  803de7:	c9                   	leaveq 
  803de8:	c3                   	retq   

0000000000803de9 <_panic>:
  803de9:	55                   	push   %rbp
  803dea:	48 89 e5             	mov    %rsp,%rbp
  803ded:	53                   	push   %rbx
  803dee:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  803df5:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
  803dfc:	89 b5 14 ff ff ff    	mov    %esi,-0xec(%rbp)
  803e02:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  803e09:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  803e10:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  803e17:	84 c0                	test   %al,%al
  803e19:	74 23                	je     803e3e <_panic+0x55>
  803e1b:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  803e22:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  803e26:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  803e2a:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  803e2e:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  803e32:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  803e36:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  803e3a:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  803e3e:	48 89 95 08 ff ff ff 	mov    %rdx,-0xf8(%rbp)
  803e45:	c7 85 28 ff ff ff 18 	movl   $0x18,-0xd8(%rbp)
  803e4c:	00 00 00 
  803e4f:	c7 85 2c ff ff ff 30 	movl   $0x30,-0xd4(%rbp)
  803e56:	00 00 00 
  803e59:	48 8d 45 10          	lea    0x10(%rbp),%rax
  803e5d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  803e64:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  803e6b:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  803e72:	48 b8 00 60 80 00 00 	movabs $0x806000,%rax
  803e79:	00 00 00 
  803e7c:	48 8b 18             	mov    (%rax),%rbx
  803e7f:	48 b8 45 18 80 00 00 	movabs $0x801845,%rax
  803e86:	00 00 00 
  803e89:	ff d0                	callq  *%rax
  803e8b:	8b 8d 14 ff ff ff    	mov    -0xec(%rbp),%ecx
  803e91:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
  803e98:	41 89 c8             	mov    %ecx,%r8d
  803e9b:	48 89 d1             	mov    %rdx,%rcx
  803e9e:	48 89 da             	mov    %rbx,%rdx
  803ea1:	89 c6                	mov    %eax,%esi
  803ea3:	48 bf 50 49 80 00 00 	movabs $0x804950,%rdi
  803eaa:	00 00 00 
  803ead:	b8 00 00 00 00       	mov    $0x0,%eax
  803eb2:	49 b9 dd 03 80 00 00 	movabs $0x8003dd,%r9
  803eb9:	00 00 00 
  803ebc:	41 ff d1             	callq  *%r9
  803ebf:	48 8d 95 28 ff ff ff 	lea    -0xd8(%rbp),%rdx
  803ec6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
  803ecd:	48 89 d6             	mov    %rdx,%rsi
  803ed0:	48 89 c7             	mov    %rax,%rdi
  803ed3:	48 b8 31 03 80 00 00 	movabs $0x800331,%rax
  803eda:	00 00 00 
  803edd:	ff d0                	callq  *%rax
  803edf:	48 bf 73 49 80 00 00 	movabs $0x804973,%rdi
  803ee6:	00 00 00 
  803ee9:	b8 00 00 00 00       	mov    $0x0,%eax
  803eee:	48 ba dd 03 80 00 00 	movabs $0x8003dd,%rdx
  803ef5:	00 00 00 
  803ef8:	ff d2                	callq  *%rdx
  803efa:	cc                   	int3   
  803efb:	eb fd                	jmp    803efa <_panic+0x111>

0000000000803efd <ipc_recv>:
  803efd:	55                   	push   %rbp
  803efe:	48 89 e5             	mov    %rsp,%rbp
  803f01:	48 83 ec 30          	sub    $0x30,%rsp
  803f05:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  803f09:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  803f0d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  803f11:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803f16:	75 0e                	jne    803f26 <ipc_recv+0x29>
  803f18:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803f1f:	00 00 00 
  803f22:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803f26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  803f2a:	48 89 c7             	mov    %rax,%rdi
  803f2d:	48 b8 ea 1a 80 00 00 	movabs $0x801aea,%rax
  803f34:	00 00 00 
  803f37:	ff d0                	callq  *%rax
  803f39:	89 45 fc             	mov    %eax,-0x4(%rbp)
  803f3c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  803f40:	79 27                	jns    803f69 <ipc_recv+0x6c>
  803f42:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803f47:	74 0a                	je     803f53 <ipc_recv+0x56>
  803f49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f4d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803f53:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803f58:	74 0a                	je     803f64 <ipc_recv+0x67>
  803f5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803f5e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  803f64:	8b 45 fc             	mov    -0x4(%rbp),%eax
  803f67:	eb 53                	jmp    803fbc <ipc_recv+0xbf>
  803f69:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
  803f6e:	74 19                	je     803f89 <ipc_recv+0x8c>
  803f70:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803f77:	00 00 00 
  803f7a:	48 8b 00             	mov    (%rax),%rax
  803f7d:	8b 90 0c 01 00 00    	mov    0x10c(%rax),%edx
  803f83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  803f87:	89 10                	mov    %edx,(%rax)
  803f89:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  803f8e:	74 19                	je     803fa9 <ipc_recv+0xac>
  803f90:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803f97:	00 00 00 
  803f9a:	48 8b 00             	mov    (%rax),%rax
  803f9d:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
  803fa3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  803fa7:	89 10                	mov    %edx,(%rax)
  803fa9:	48 b8 08 70 80 00 00 	movabs $0x807008,%rax
  803fb0:	00 00 00 
  803fb3:	48 8b 00             	mov    (%rax),%rax
  803fb6:	8b 80 08 01 00 00    	mov    0x108(%rax),%eax
  803fbc:	c9                   	leaveq 
  803fbd:	c3                   	retq   

0000000000803fbe <ipc_send>:
  803fbe:	55                   	push   %rbp
  803fbf:	48 89 e5             	mov    %rsp,%rbp
  803fc2:	48 83 ec 30          	sub    $0x30,%rsp
  803fc6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  803fc9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  803fcc:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  803fd0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  803fd3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  803fd8:	75 10                	jne    803fea <ipc_send+0x2c>
  803fda:	48 b8 00 00 80 00 80 	movabs $0x8000800000,%rax
  803fe1:	00 00 00 
  803fe4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  803fe8:	eb 0e                	jmp    803ff8 <ipc_send+0x3a>
  803fea:	eb 0c                	jmp    803ff8 <ipc_send+0x3a>
  803fec:	48 b8 83 18 80 00 00 	movabs $0x801883,%rax
  803ff3:	00 00 00 
  803ff6:	ff d0                	callq  *%rax
  803ff8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  803ffb:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  803ffe:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  804002:	8b 45 ec             	mov    -0x14(%rbp),%eax
  804005:	89 c7                	mov    %eax,%edi
  804007:	48 b8 95 1a 80 00 00 	movabs $0x801a95,%rax
  80400e:	00 00 00 
  804011:	ff d0                	callq  *%rax
  804013:	89 45 fc             	mov    %eax,-0x4(%rbp)
  804016:	83 7d fc f8          	cmpl   $0xfffffff8,-0x4(%rbp)
  80401a:	74 d0                	je     803fec <ipc_send+0x2e>
  80401c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  804020:	79 30                	jns    804052 <ipc_send+0x94>
  804022:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804025:	89 c1                	mov    %eax,%ecx
  804027:	48 ba 78 49 80 00 00 	movabs $0x804978,%rdx
  80402e:	00 00 00 
  804031:	be 44 00 00 00       	mov    $0x44,%esi
  804036:	48 bf 8e 49 80 00 00 	movabs $0x80498e,%rdi
  80403d:	00 00 00 
  804040:	b8 00 00 00 00       	mov    $0x0,%eax
  804045:	49 b8 e9 3d 80 00 00 	movabs $0x803de9,%r8
  80404c:	00 00 00 
  80404f:	41 ff d0             	callq  *%r8
  804052:	c9                   	leaveq 
  804053:	c3                   	retq   

0000000000804054 <ipc_host_recv>:
  804054:	55                   	push   %rbp
  804055:	48 89 e5             	mov    %rsp,%rbp
  804058:	48 83 ec 10          	sub    $0x10,%rsp
  80405c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  804060:	48 ba a0 49 80 00 00 	movabs $0x8049a0,%rdx
  804067:	00 00 00 
  80406a:	be 4e 00 00 00       	mov    $0x4e,%esi
  80406f:	48 bf 8e 49 80 00 00 	movabs $0x80498e,%rdi
  804076:	00 00 00 
  804079:	b8 00 00 00 00       	mov    $0x0,%eax
  80407e:	48 b9 e9 3d 80 00 00 	movabs $0x803de9,%rcx
  804085:	00 00 00 
  804088:	ff d1                	callq  *%rcx

000000000080408a <ipc_host_send>:
  80408a:	55                   	push   %rbp
  80408b:	48 89 e5             	mov    %rsp,%rbp
  80408e:	48 83 ec 20          	sub    $0x20,%rsp
  804092:	89 7d fc             	mov    %edi,-0x4(%rbp)
  804095:	89 75 f8             	mov    %esi,-0x8(%rbp)
  804098:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  80409c:	89 4d ec             	mov    %ecx,-0x14(%rbp)
  80409f:	48 ba c0 49 80 00 00 	movabs $0x8049c0,%rdx
  8040a6:	00 00 00 
  8040a9:	be 67 00 00 00       	mov    $0x67,%esi
  8040ae:	48 bf 8e 49 80 00 00 	movabs $0x80498e,%rdi
  8040b5:	00 00 00 
  8040b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8040bd:	48 b9 e9 3d 80 00 00 	movabs $0x803de9,%rcx
  8040c4:	00 00 00 
  8040c7:	ff d1                	callq  *%rcx

00000000008040c9 <ipc_find_env>:
  8040c9:	55                   	push   %rbp
  8040ca:	48 89 e5             	mov    %rsp,%rbp
  8040cd:	48 83 ec 14          	sub    $0x14,%rsp
  8040d1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8040d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  8040db:	eb 4e                	jmp    80412b <ipc_find_env+0x62>
  8040dd:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  8040e4:	00 00 00 
  8040e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8040ea:	48 98                	cltq   
  8040ec:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  8040f3:	48 01 d0             	add    %rdx,%rax
  8040f6:	48 05 d0 00 00 00    	add    $0xd0,%rax
  8040fc:	8b 00                	mov    (%rax),%eax
  8040fe:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  804101:	75 24                	jne    804127 <ipc_find_env+0x5e>
  804103:	48 ba 00 00 80 00 80 	movabs $0x8000800000,%rdx
  80410a:	00 00 00 
  80410d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  804110:	48 98                	cltq   
  804112:	48 69 c0 68 01 00 00 	imul   $0x168,%rax,%rax
  804119:	48 01 d0             	add    %rdx,%rax
  80411c:	48 05 c0 00 00 00    	add    $0xc0,%rax
  804122:	8b 40 08             	mov    0x8(%rax),%eax
  804125:	eb 12                	jmp    804139 <ipc_find_env+0x70>
  804127:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  80412b:	81 7d fc ff 03 00 00 	cmpl   $0x3ff,-0x4(%rbp)
  804132:	7e a9                	jle    8040dd <ipc_find_env+0x14>
  804134:	b8 00 00 00 00       	mov    $0x0,%eax
  804139:	c9                   	leaveq 
  80413a:	c3                   	retq   

000000000080413b <pageref>:
  80413b:	55                   	push   %rbp
  80413c:	48 89 e5             	mov    %rsp,%rbp
  80413f:	48 83 ec 18          	sub    $0x18,%rsp
  804143:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  804147:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80414b:	48 c1 e8 15          	shr    $0x15,%rax
  80414f:	48 89 c2             	mov    %rax,%rdx
  804152:	48 b8 00 00 00 80 00 	movabs $0x10080000000,%rax
  804159:	01 00 00 
  80415c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804160:	83 e0 01             	and    $0x1,%eax
  804163:	48 85 c0             	test   %rax,%rax
  804166:	75 07                	jne    80416f <pageref+0x34>
  804168:	b8 00 00 00 00       	mov    $0x0,%eax
  80416d:	eb 53                	jmp    8041c2 <pageref+0x87>
  80416f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  804173:	48 c1 e8 0c          	shr    $0xc,%rax
  804177:	48 89 c2             	mov    %rax,%rdx
  80417a:	48 b8 00 00 00 00 00 	movabs $0x10000000000,%rax
  804181:	01 00 00 
  804184:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
  804188:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  80418c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  804190:	83 e0 01             	and    $0x1,%eax
  804193:	48 85 c0             	test   %rax,%rax
  804196:	75 07                	jne    80419f <pageref+0x64>
  804198:	b8 00 00 00 00       	mov    $0x0,%eax
  80419d:	eb 23                	jmp    8041c2 <pageref+0x87>
  80419f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8041a3:	48 c1 e8 0c          	shr    $0xc,%rax
  8041a7:	48 89 c2             	mov    %rax,%rdx
  8041aa:	48 b8 00 00 a0 00 80 	movabs $0x8000a00000,%rax
  8041b1:	00 00 00 
  8041b4:	48 c1 e2 04          	shl    $0x4,%rdx
  8041b8:	48 01 d0             	add    %rdx,%rax
  8041bb:	0f b7 40 08          	movzwl 0x8(%rax),%eax
  8041bf:	0f b7 c0             	movzwl %ax,%eax
  8041c2:	c9                   	leaveq 
  8041c3:	c3                   	retq   
