#line 2 "../kern/trap.c"
#include <inc/mmu.h>
#include <inc/x86.h>
#include <inc/assert.h>

#include <kern/pmap.h>
#include <kern/trap.h>
#include <kern/console.h>
#include <kern/monitor.h>
#line 11 "../kern/trap.c"
#include <kern/env.h>
#include <kern/syscall.h>
#line 15 "../kern/trap.c"
#include <kern/sched.h>
#include <kern/kclock.h>
#include <kern/picirq.h>
#include <kern/cpu.h>
#include <kern/spinlock.h>
#line 22 "../kern/trap.c"
#include <kern/time.h>
#line 25 "../kern/trap.c"
#include <inc/vmx.h>
#line 27 "../kern/trap.c"

extern uintptr_t gdtdesc_64;
struct Taskstate ts;
extern struct Segdesc gdt[];
extern long gdt_pd;

/* For debugging, so print_trapframe can distinguish between printing
 * a saved trapframe and printing the current trapframe and print some
 * additional information in the latter case.
 */
static struct Trapframe *last_tf;

/* Interrupt descriptor table.  (Must be built at run time because
 * shifted function addresses can't be represented in relocation records.)
 */
struct Gatedesc idt[256] = { { 0 } };
struct Pseudodesc idt_pd = {0,0};


static const char *trapname(int trapno)
{
	static const char * const excnames[] = {
		"Divide error",
		"Debug",
		"Non-Maskable Interrupt",
		"Breakpoint",
		"Overflow",
		"BOUND Range Exceeded",
		"Invalid Opcode",
		"Device Not Available",
		"Double Fault",
		"Coprocessor Segment Overrun",
		"Invalid TSS",
		"Segment Not Present",
		"Stack Fault",
		"General Protection",
		"Page Fault",
		"(unknown trap)",
		"x87 FPU Floating-Point Error",
		"Alignment Check",
		"Machine-Check",
		"SIMD Floating-Point Exception"
	};

	if (trapno < sizeof(excnames)/sizeof(excnames[0]))
		return excnames[trapno];
	if (trapno == T_SYSCALL)
		return "System call";
#line 76 "../kern/trap.c"
	if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16)
		return "Hardware Interrupt";
#line 79 "../kern/trap.c"
	return "(unknown trap)";
}


void
trap_init(void)
{
	extern struct Segdesc gdt[];
#line 88 "../kern/trap.c"
	extern char
		Xdivide,Xdebug,Xnmi,Xbrkpt,Xoflow,Xbound,
		Xillop,Xdevice,Xdblflt,Xtss,Xsegnp,Xstack,
		Xgpflt,Xpgflt,Xfperr,Xalign,Xmchk,Xdefault,Xsyscall;
#line 93 "../kern/trap.c"
	extern char
		Xirq0,Xirq1,Xirq2,Xirq3,Xirq4,Xirq5,
		Xirq6,Xirq7,Xirq8,Xirq9,Xirq10,Xirq11,
		Xirq12,Xirq13,Xirq14,Xirq15;
#line 98 "../kern/trap.c"
	int i;

#line 101 "../kern/trap.c"
	// check that IRQ_OFFSET is a multiple of 8
	static_assert((IRQ_OFFSET & 7) == 0);
#line 104 "../kern/trap.c"

	// install a default handler
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, GD_KT, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE], 0, GD_KT, &Xdivide, 0);
	SETGATE(idt[T_DEBUG],  0, GD_KT, &Xdebug,  0);
	SETGATE(idt[T_NMI],    0, GD_KT, &Xnmi,    0);
	SETGATE(idt[T_BRKPT],  0, GD_KT, &Xbrkpt,  3);
	SETGATE(idt[T_OFLOW],  0, GD_KT, &Xoflow,  0);
	SETGATE(idt[T_BOUND],  0, GD_KT, &Xbound,  0);
	SETGATE(idt[T_ILLOP],  0, GD_KT, &Xillop,  0);
	SETGATE(idt[T_DEVICE], 0, GD_KT, &Xdevice, 0);
	SETGATE(idt[T_DBLFLT], 0, GD_KT, &Xdblflt, 0);
	SETGATE(idt[T_TSS],    0, GD_KT, &Xtss,    0);
	SETGATE(idt[T_SEGNP],  0, GD_KT, &Xsegnp,  0);
	SETGATE(idt[T_STACK],  0, GD_KT, &Xstack,  0);
	SETGATE(idt[T_GPFLT],  0, GD_KT, &Xgpflt,  0);
	SETGATE(idt[T_PGFLT],  0, GD_KT, &Xpgflt,  0);
	SETGATE(idt[T_FPERR],  0, GD_KT, &Xfperr,  0);
	SETGATE(idt[T_ALIGN],  0, GD_KT, &Xalign,  0);
	SETGATE(idt[T_MCHK],   0, GD_KT, &Xmchk,   0);

#line 128 "../kern/trap.c"
	SETGATE(idt[IRQ_OFFSET + 0], 0, GD_KT, &Xirq0, 0);
	SETGATE(idt[IRQ_OFFSET + 1], 0, GD_KT, &Xirq1, 0);
	SETGATE(idt[IRQ_OFFSET + 2], 0, GD_KT, &Xirq2, 0);
	SETGATE(idt[IRQ_OFFSET + 3], 0, GD_KT, &Xirq3, 0);
	SETGATE(idt[IRQ_OFFSET + 4], 0, GD_KT, &Xirq4, 0);
	SETGATE(idt[IRQ_OFFSET + 5], 0, GD_KT, &Xirq5, 0);
	SETGATE(idt[IRQ_OFFSET + 6], 0, GD_KT, &Xirq6, 0);
	SETGATE(idt[IRQ_OFFSET + 7], 0, GD_KT, &Xirq7, 0);
	SETGATE(idt[IRQ_OFFSET + 8], 0, GD_KT, &Xirq8, 0);
	SETGATE(idt[IRQ_OFFSET + 9], 0, GD_KT, &Xirq9, 0);
	SETGATE(idt[IRQ_OFFSET + 10], 0, GD_KT, &Xirq10, 0);
	SETGATE(idt[IRQ_OFFSET + 11], 0, GD_KT, &Xirq11, 0);
	SETGATE(idt[IRQ_OFFSET + 12], 0, GD_KT, &Xirq12, 0);
	SETGATE(idt[IRQ_OFFSET + 13], 0, GD_KT, &Xirq13, 0);
	SETGATE(idt[IRQ_OFFSET + 14], 0, GD_KT, &Xirq14, 0);
	SETGATE(idt[IRQ_OFFSET + 15], 0, GD_KT, &Xirq15, 0);
#line 145 "../kern/trap.c"

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL], 0, GD_KT, &Xsyscall, 3);
#line 153 "../kern/trap.c"
	idt_pd.pd_lim = sizeof(idt)-1;
	idt_pd.pd_base = (uint64_t)idt;
	// Per-CPU setup
	trap_init_percpu();
}

// Initialize and load the per-CPU TSS and IDT
void
trap_init_percpu(void)
{
#line 164 "../kern/trap.c"
	// The example code here sets up the Task State Segment (TSS) and
	// the TSS descriptor for CPU 0. But it is incorrect if we are
	// running on other CPUs because each CPU has its own kernel stack.
	// Fix the code so that it works for all CPUs.
	//
	// Hints:
	//   - The macro "thiscpu" always refers to the current CPU's
	//     struct CpuInfo;
	//   - The ID of the current CPU is given by cpunum() or
	//     thiscpu->cpu_id;
	//   - Use "thiscpu->cpu_ts" as the TSS for the current CPU,
	//     rather than the global "ts" variable;
	//   - Use gdt[(GD_TSS0 >> 3) + 2*i] for CPU i's TSS descriptor;
	//   - You mapped the per-CPU kernel stacks in mem_init_mp()
	//
	// ltr sets a 'busy' flag in the TSS selector, so if you
	// accidentally load the same TSS on more than one CPU, you'll
	// get a triple fault.  If you set up an individual CPU's TSS
	// wrong, you may not get a fault until you try to return from
	// user space on that CPU.
	//
	// LAB 4: Your code here:

#line 188 "../kern/trap.c"

#line 190 "../kern/trap.c"
	int gd_tss = (GD_TSS0 >> 3) + cpunum()*2;

	thiscpu->cpu_ts.ts_esp0 = KSTACKTOP 
		- (KSTKSIZE + KSTKGAP) * cpunum();

	SETTSS((struct SystemSegdesc64 *)((gdt_pd>>16)+40+cpunum()*16),STS_T64A, (uint64_t) (&thiscpu->cpu_ts),sizeof(struct Taskstate), 0);

	// Load the TSS
	ltr(gd_tss << 3);
#line 222 "../kern/trap.c"

	// Load the IDT
	lidt(&idt_pd);
}

void
print_trapframe(struct Trapframe *tf)
{
#line 231 "../kern/trap.c"
	cprintf("TRAP frame at %p from CPU %d\n", tf, cpunum());
#line 235 "../kern/trap.c"
	print_regs(&tf->tf_regs);
	cprintf("  es   0x----%04x\n", tf->tf_es);
	cprintf("  ds   0x----%04x\n", tf->tf_ds);
	cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
	// If this trap was a page fault that just happened
	// (so %cr2 is meaningful), print the faulting linear address.
	if (tf == last_tf && tf->tf_trapno == T_PGFLT)
		cprintf("  cr2  0x%08x\n", rcr2());
	cprintf("  err  0x%08x", tf->tf_err);
	// For page faults, print decoded fault error code:
	// U/K=fault occurred in user/kernel mode
	// W/R=a write/read caused the fault
	// PR=a protection violation caused the fault (NP=page not present).
	if (tf->tf_trapno == T_PGFLT)
		cprintf(" [%s, %s, %s]\n",
			tf->tf_err & 4 ? "user" : "kernel",
			tf->tf_err & 2 ? "write" : "read",
			tf->tf_err & 1 ? "protection" : "not-present");
	else
		cprintf("\n");
	cprintf("  rip  0x%08x\n", tf->tf_rip);
	cprintf("  cs   0x----%04x\n", tf->tf_cs);
	cprintf("  flag 0x%08x\n", tf->tf_eflags);
	if ((tf->tf_cs & 3) != 0) {
		cprintf("  rsp  0x%08x\n", tf->tf_rsp);
		cprintf("  ss   0x----%04x\n", tf->tf_ss);
	}
}

void
print_regs(struct PushRegs *regs)
{
	cprintf("  r15  0x%08x\n", regs->reg_r15);
	cprintf("  r14  0x%08x\n", regs->reg_r14);
	cprintf("  r13  0x%08x\n", regs->reg_r13);
	cprintf("  r12  0x%08x\n", regs->reg_r12);
	cprintf("  r11  0x%08x\n", regs->reg_r11);
	cprintf("  r10  0x%08x\n", regs->reg_r10);
	cprintf("  r9  0x%08x\n", regs->reg_r9);
	cprintf("  r8  0x%08x\n", regs->reg_r8);
	cprintf("  rdi  0x%08x\n", regs->reg_rdi);
	cprintf("  rsi  0x%08x\n", regs->reg_rsi);
	cprintf("  rbp  0x%08x\n", regs->reg_rbp);
	cprintf("  rbx  0x%08x\n", regs->reg_rbx);
	cprintf("  rdx  0x%08x\n", regs->reg_rdx);
	cprintf("  rcx  0x%08x\n", regs->reg_rcx);
	cprintf("  rax  0x%08x\n", regs->reg_rax);
}

static void
trap_dispatch(struct Trapframe *tf)
{
#line 288 "../kern/trap.c"
	int r;
#line 290 "../kern/trap.c"
	// Handle processor exceptions.
	// LAB 3: Your code here.
#line 293 "../kern/trap.c"
	if (tf->tf_trapno == T_PGFLT) {
		page_fault_handler(tf);
		return;
	}
	if (tf->tf_trapno == T_SYSCALL) {
		// handle system call
		tf->tf_regs.reg_rax =
			syscall(tf->tf_regs.reg_rax,
				tf->tf_regs.reg_rdx,
				tf->tf_regs.reg_rcx,
				tf->tf_regs.reg_rbx,
				tf->tf_regs.reg_rdi,
				tf->tf_regs.reg_rsi);
		return;
	}
	if (tf->tf_trapno == T_BRKPT) {
		// Invoke the kernel monitor.
		monitor(tf);
		return;
	}
#line 314 "../kern/trap.c"

#line 316 "../kern/trap.c"
	// Handle spurious interrupts
	// The hardware sometimes raises these because of noise on the
	// IRQ line or other reasons. We don't care.
	if (tf->tf_trapno == IRQ_OFFSET + IRQ_SPURIOUS) {
		cprintf("Spurious interrupt on irq 7\n");
		print_trapframe(tf);
		return;
	}

	// Handle clock interrupts. Don't forget to acknowledge the
	// interrupt using lapic_eoi() before calling the scheduler!
	// LAB 4: Your code here.
#line 329 "../kern/trap.c"

	// Add time tick increment to clock interrupts.
	// Be careful! In multiprocessors, clock interrupts are
	// triggered on every CPU.
	// LAB 6: Your code here.

#line 337 "../kern/trap.c"
	if (tf->tf_trapno == IRQ_OFFSET + IRQ_TIMER) {
		// irq 0 -- clock interrupt
#line 340 "../kern/trap.c"
		if (cpunum() == 0)
			time_tick();
#line 344 "../kern/trap.c"
		#ifndef VMM_GUEST
		lapic_eoi();
		#else
		asm("vmcall":"=a"(r): "0"(VMX_VMCALL_LAPICEOI));
		#endif
#line 352 "../kern/trap.c"
		sched_yield();
	}
#line 355 "../kern/trap.c"

#line 358 "../kern/trap.c"
	// Handle keyboard and serial interrupts.
	// LAB 5: Your code here.
#line 361 "../kern/trap.c"
	if (tf->tf_trapno == IRQ_OFFSET + IRQ_KBD) {
		kbd_intr();
		return;
	}
	if (tf->tf_trapno == IRQ_OFFSET + IRQ_SERIAL) {
		serial_intr();
		return;
	}
#line 370 "../kern/trap.c"

#line 372 "../kern/trap.c"
	// Unexpected trap: The user process or the kernel has a bug.
	print_trapframe(tf);
	if (tf->tf_cs == GD_KT)
		panic("unhandled trap in kernel");
	else {
		env_destroy(curenv);
		return;
	}
}

void
trap(struct Trapframe *tf)
{
	//struct Trapframe *tf = &tf_;
	// The environment may have set DF and some versions
	// of GCC rely on DF being clear
	asm volatile("cld" ::: "cc");

#line 391 "../kern/trap.c"
	// Halt the CPU if some other CPU has called panic()
	extern char *panicstr;
	if (panicstr)
		asm volatile("hlt");

	// Re-acqurie the big kernel lock if we were halted in
	// sched_yield()
	if (xchg(&thiscpu->cpu_status, CPU_STARTED) == CPU_HALTED)
		lock_kernel();
#line 401 "../kern/trap.c"
	// Check that interrupts are disabled.  If this assertion
	// fails, DO NOT be tempted to fix it by inserting a "cli" in
	// the interrupt path.
	assert(!(read_eflags() & FL_IF));

#line 411 "../kern/trap.c"
	if ((tf->tf_cs & 3) == 3) {
		// Trapped from user mode.
#line 414 "../kern/trap.c"
		// Acquire the big kernel lock before doing any
		// serious kernel work.
		// LAB 4: Your code here.
#line 418 "../kern/trap.c"
		lock_kernel();
#line 421 "../kern/trap.c"
		assert(curenv);
#line 423 "../kern/trap.c"

		// Garbage collect if current enviroment is a zombie
		if (curenv->env_status == ENV_DYING) {
			env_free(curenv);
			curenv = NULL;
			sched_yield();
		}
#line 431 "../kern/trap.c"

		// Copy trap frame (which is currently on the stack)
		// into 'curenv->env_tf', so that running the environment
		// will restart at the trap point.
		curenv->env_tf = *tf;
		// The trapframe on the stack should be ignored from here on.
		tf = &curenv->env_tf;
	}

#line 441 "../kern/trap.c"
	// Record that tf is the last real trapframe so
	// print_trapframe can print some additional information.
	last_tf = tf;

	// Dispatch based on what type of trap occurred
	trap_dispatch(tf);

#line 449 "../kern/trap.c"
	// If we made it to this point, then no other environment was
	// scheduled, so we should return to the current environment
	// if doing so makes sense.
	if (curenv && curenv->env_status == ENV_RUNNING)
		env_run(curenv);
	else
		sched_yield();
#line 461 "../kern/trap.c"
}


void
page_fault_handler(struct Trapframe *tf)
{
	uint64_t fault_va;
#line 469 "../kern/trap.c"
	struct UTrapframe *utf;
#line 471 "../kern/trap.c"

	// Read processor's CR2 register to find the faulting address
	fault_va = rcr2();

#line 476 "../kern/trap.c"
	if ((tf->tf_cs & 3) == 0) {
		print_trapframe(tf);
		panic("page fault");
	}
#line 485 "../kern/trap.c"

#line 487 "../kern/trap.c"
	// See if the environment has installed a user page fault handler.
	if (curenv->env_pgfault_upcall == 0) {
		cprintf("[%08x] user fault va %08x ip %08x\n",
			curenv->env_id, fault_va, tf->tf_rip);
		print_trapframe(tf);
		env_destroy(curenv);
	}

	// Decide where to push our exception stack frame.
	if (tf->tf_rsp >= UXSTACKTOP - PGSIZE && tf->tf_rsp < UXSTACKTOP) {
		// The user's ESP is ALREADY in the user exception stack area,
		// so push the new frame on the exception stack,
		// preserving the existing exception stack contents.
		utf = (struct UTrapframe*)(tf->tf_rsp
					   - sizeof(struct UTrapframe)
					   // Save a spare word for return
					   - 8);
	} else {
		// The user's ESP is NOT in the user exception stack area,
		// so it's presumably pointing to a normal user stack
		// and the user exception stack is not in use.
		// Therefore, switch the user's ESP onto the exception stack
		// and push the new frame at the top of the exception stack.
		utf = (struct UTrapframe*)(UXSTACKTOP
					   - sizeof(struct UTrapframe));
	}

	// If we can't write to the exception stack,
	// it means the user environment is seriously screwed up,
	// so just terminate it.
	user_mem_assert(curenv, utf, sizeof(struct UTrapframe), PTE_U | PTE_W);

	// fill utf
	utf->utf_fault_va = fault_va;
	utf->utf_err = tf->tf_err;
	utf->utf_regs = tf->tf_regs;
	utf->utf_rip = tf->tf_rip;
	utf->utf_eflags = tf->tf_eflags;
	utf->utf_rsp = tf->tf_rsp;

 	// set user registers so that env_run switches to fault handler
	tf->tf_rsp = (uintptr_t) utf;
 	tf->tf_rip = (uintptr_t) curenv->env_pgfault_upcall;

	env_run(curenv);
#line 575 "../kern/trap.c"
}

