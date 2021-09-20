
vmm/guest/obj/boot/boot.out:     file format elf32-i386


Disassembly of section .text:

00007000 <gboot_start>:
.set CR0_PE_ON,      0x1         # protected mode enable flag

.globl gboot_start
gboot_start:
.code16                     # Assemble for 16-bit mode
cli                         # Disable interrupts
    7000:	fa                   	cli    
cld                         # String operations increment
    7001:	fc                   	cld    

# Set up the important data segment registers (DS, ES, SS).
xorw    %ax,%ax             # Segment number zero
    7002:	31 c0                	xor    %eax,%eax
movw    %ax,%ds             # -> Data Segment
    7004:	8e d8                	mov    %eax,%ds
movw    %ax,%es             # -> Extra Segment
    7006:	8e c0                	mov    %eax,%es
movw    %ax,%ss             # -> Stack Segment
    7008:	8e d0                	mov    %eax,%ss

# Switch from real to protected mode, using a bootstrap GDT
# and segment translation that makes virtual addresses 
# identical to their physical addresses, so that the 
# effective memory map does not change during the switch.
lgdt    gdtdesc
    700a:	0f 01 16             	lgdtl  (%esi)
    700d:	50                   	push   %eax
    700e:	70 0f                	jo     701f <protcseg+0x1>
movl    %cr0, %eax
    7010:	20 c0                	and    %al,%al
orl     $CR0_PE_ON, %eax
    7012:	66 83 c8 01          	or     $0x1,%ax
movl    %eax, %cr0
    7016:	0f 22 c0             	mov    %eax,%cr0

# Jump to next instruction, but in 32-bit code segment.
# Switches processor into 32-bit mode.
ljmp    $PROT_MODE_CSEG, $protcseg
    7019:	ea                   	.byte 0xea
    701a:	1e                   	push   %ds
    701b:	70 08                	jo     7025 <protcseg+0x7>
	...

0000701e <protcseg>:

.code32                     # Assemble for 32-bit mode
protcseg:
# Set up the protected-mode data segment registers
movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
    701e:	66 b8 10 00          	mov    $0x10,%ax
movw    %ax, %ds                # -> DS: Data Segment
    7022:	8e d8                	mov    %eax,%ds
movw    %ax, %es                # -> ES: Extra Segment
    7024:	8e c0                	mov    %eax,%es
movw    %ax, %fs                # -> FS
    7026:	8e e0                	mov    %eax,%fs
movw    %ax, %gs                # -> GS
    7028:	8e e8                	mov    %eax,%gs
movw    %ax, %ss                # -> SS: Stack Segment
    702a:	8e d0                	mov    %eax,%ss

mov $0x100000,%eax
    702c:	b8 00 00 10 00       	mov    $0x100000,%eax
jmp *%eax
    7031:	ff e0                	jmp    *%eax

00007033 <spin>:

# If bootmain returns (it shouldn't), loop.
spin:
jmp spin
    7033:	eb fe                	jmp    7033 <spin>
    7035:	8d 76 00             	lea    0x0(%esi),%esi

00007038 <gdt>:
	...
    7040:	ff                   	(bad)  
    7041:	ff 00                	incl   (%eax)
    7043:	00 00                	add    %al,(%eax)
    7045:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    704c:	00                   	.byte 0x0
    704d:	92                   	xchg   %eax,%edx
    704e:	cf                   	iret   
	...

00007050 <gdtdesc>:
    7050:	17                   	pop    %ss
    7051:	00 38                	add    %bh,(%eax)
    7053:	70 00                	jo     7055 <gdtdesc+0x5>
	...
