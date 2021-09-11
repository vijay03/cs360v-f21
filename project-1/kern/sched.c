#line 2 "../kern/sched.c"
#include <inc/assert.h>
#include <inc/x86.h>
#include <kern/spinlock.h>
#include <kern/env.h>
#include <kern/pmap.h>
#include <kern/monitor.h>

void sched_halt(void);


#line 13 "../kern/sched.c"
#ifndef VMM_GUEST
#include <vmm/vmx.h>
static int
vmxon() {
	int r;
	if(!thiscpu->is_vmx_root) {
		r = vmx_init_vmxon();
		if(r < 0) {
			cprintf("Error executing VMXON: %e\n", r);
			return r;
		}
		cprintf("VMXON\n");
	}
	return 0;
}
#endif
#line 30 "../kern/sched.c"

// Choose a user environment to run and run it.
void
sched_yield(void)
{
	struct Env *idle;
	int i, j, k;

	// Determine the starting point for the search.
	if (curenv)
		i = curenv-envs;
	else
		i = NENV-1;
	//cprintf("sched_yield searching from %d\n", i);

	// Loop through all the environments at most once.
	for (j = 1; j <= NENV; j++) {
		k = (j + i) % NENV;
		// If this environment is runnable, run it.
		if (envs[k].env_status == ENV_RUNNABLE) {
            /* Your code here */
			env_run(&envs[k]);
		}
	}

	if (curenv && curenv->env_status == ENV_RUNNING) {
        /* Your code here */
		env_run(curenv);
	}

	// sched_halt never returns
	sched_halt();
}



// Halt this CPU when there is nothing to do. Wait until the
// timer interrupt wakes it up. This function never returns.
//
void
sched_halt(void)
{
	int i;

	// For debugging and testing purposes, if there are no runnable
	// environments in the system, then drop into the kernel monitor.
	for (i = 0; i < NENV; i++) {
		if ((envs[i].env_status == ENV_RUNNABLE ||
		     envs[i].env_status == ENV_RUNNING ||
		     envs[i].env_status == ENV_DYING))
			break;
	}
	if (i == NENV) {
		cprintf("No runnable environments in the system!\n");
		while (1)
			monitor(NULL);
	}

	// Mark that no environment is running on this CPU
	curenv = NULL;
	lcr3(PADDR(boot_pml4e));

	// Mark that this CPU is in the HALT state, so that when
	// timer interupts come in, we know we should re-acquire the
	// big kernel lock
	xchg(&thiscpu->cpu_status, CPU_HALTED);

	// Release the big kernel lock as if we were "leaving" the kernel
	unlock_kernel();

	// Reset stack pointer, enable interrupts and then halt.
	asm volatile (
		"movq $0, %%rbp\n"
		"movq %0, %%rsp\n"
		"pushq $0\n"
		"pushq $0\n"
		"sti\n"
		"hlt\n"
		: : "a" (thiscpu->cpu_ts.ts_esp0));
}

