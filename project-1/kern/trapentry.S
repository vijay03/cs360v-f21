/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>
#include <kern/macro.h>

#include <kern/picirq.h>


###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushq $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushq $0;							\
	pushq $(num);							\
	jmp _alltraps

.text


/* CPU traps */
TRAPHANDLER_NOEC(Xdivide, T_DIVIDE)
TRAPHANDLER_NOEC(Xdebug,  T_DEBUG)
TRAPHANDLER_NOEC(Xnmi,    T_NMI)
TRAPHANDLER_NOEC(Xbrkpt,  T_BRKPT)
TRAPHANDLER_NOEC(Xoflow,  T_OFLOW)
TRAPHANDLER_NOEC(Xbound,  T_BOUND)
TRAPHANDLER_NOEC(Xillop,  T_ILLOP)
TRAPHANDLER_NOEC(Xdevice, T_DEVICE)
TRAPHANDLER     (Xdblflt, T_DBLFLT)
TRAPHANDLER     (Xtss,    T_TSS)
TRAPHANDLER     (Xsegnp,  T_SEGNP)
TRAPHANDLER     (Xstack,  T_STACK)
TRAPHANDLER     (Xgpflt,  T_GPFLT)
TRAPHANDLER     (Xpgflt,  T_PGFLT)
TRAPHANDLER_NOEC(Xfperr,  T_FPERR)
TRAPHANDLER     (Xalign,  T_ALIGN)
TRAPHANDLER_NOEC(Xmchk,   T_MCHK)

/* the external device interrupts */
TRAPHANDLER_NOEC(Xirq0,   IRQ_OFFSET+0)
TRAPHANDLER_NOEC(Xirq1,   IRQ_OFFSET+1)
TRAPHANDLER_NOEC(Xirq2,   IRQ_OFFSET+2)
TRAPHANDLER_NOEC(Xirq3,   IRQ_OFFSET+3)
TRAPHANDLER_NOEC(Xirq4,   IRQ_OFFSET+4)
TRAPHANDLER_NOEC(Xirq5,   IRQ_OFFSET+5)
TRAPHANDLER_NOEC(Xirq6,   IRQ_OFFSET+6)
TRAPHANDLER_NOEC(Xirq7,   IRQ_OFFSET+7)
TRAPHANDLER_NOEC(Xirq8,   IRQ_OFFSET+8)
TRAPHANDLER_NOEC(Xirq9,   IRQ_OFFSET+9)
TRAPHANDLER_NOEC(Xirq10,  IRQ_OFFSET+10)
TRAPHANDLER_NOEC(Xirq11,  IRQ_OFFSET+11)
TRAPHANDLER_NOEC(Xirq12,  IRQ_OFFSET+12)
TRAPHANDLER_NOEC(Xirq13,  IRQ_OFFSET+13)
TRAPHANDLER_NOEC(Xirq14,  IRQ_OFFSET+14)
TRAPHANDLER_NOEC(Xirq15,  IRQ_OFFSET+15)

/* system call entry point */
TRAPHANDLER_NOEC(Xsyscall, T_SYSCALL)

/* default handler -- not for any specific trap */
TRAPHANDLER     (Xdefault, T_DEFAULT)



.globl	_alltraps
.type	_alltraps,@function
.p2align 4, 0x90		/* 16-byte alignment, nop filled */
_alltraps:
    subq $16,%rsp
    movw %ds,8(%rsp)
    movw %es,0(%rsp)
    PUSHA
    movl $GD_KD, %eax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw %ax, %fs
    movw %ax, %gs
    movq %rsp,%rdi
    call trap   # never returns 
spin:	jmp spin
