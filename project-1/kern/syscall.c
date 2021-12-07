#include <inc/types.h>
#include <inc/assert.h>
#include <inc/error.h>

/* See COPYRIGHT for copyright information. */

#include <inc/x86.h>
#include <inc/error.h>
#include <inc/string.h>
#include <inc/assert.h>

#include <kern/env.h>
#include <kern/pmap.h>
#include <kern/trap.h>
#include <kern/syscall.h>
#include <kern/console.h>
#include <kern/sched.h>
#include <kern/time.h>
#include <kern/e1000.h>
#ifndef VMM_GUEST
#include <vmm/ept.h>
#include <vmm/vmx.h>
#endif

// Print a string to the system console.
// The string is exactly 'len' characters long.
// Destroys the environment on memory errors.
static void
sys_cputs(const char *s, size_t len)
{
	// Check that the user has permission to read memory [s, s+len).
	// Destroy the environment if not.

	// LAB 3: Your code here.
	user_mem_assert(curenv, s, len, PTE_U);

	// Print the string supplied by the user.
	cprintf("%.*s", len, s);
}

// Read a character from the system console without blocking.
// Returns the character, or 0 if there is no input waiting.
static int
sys_cgetc(void)
{
	return cons_getc();
}

// Returns the current environment's envid.
static envid_t
sys_getenvid(void)
{
	return curenv->env_id;
}

// Destroy a given environment (possibly the currently running environment).
//
// Returns 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
static int
sys_env_destroy(envid_t envid)
{
	int r;
	struct Env *e;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	env_destroy(e);
	return 0;
}

// Deschedule current environment and pick a different one to run.
static void
sys_yield(void)
{
	sched_yield();
}

// Allocate a new environment.
// Returns envid of new environment, or < 0 on error.  Errors are:
//	-E_NO_FREE_ENV if no free environment is available.
//	-E_NO_MEM on memory exhaustion.
static envid_t
sys_exofork(void)
{
	int r;
	struct Env *e;

	if ((r = env_alloc(&e, curenv->env_id)) < 0)
		return r;
	e->env_status = ENV_NOT_RUNNABLE;
	e->env_tf = curenv->env_tf;
	e->env_tf.tf_regs.reg_rax = 0;
	return e->env_id;
}

// Set envid's env_status to status, which must be ENV_RUNNABLE
// or ENV_NOT_RUNNABLE.
//
// Returns 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
//	-E_INVAL if status is not a valid status for an environment.
static int
sys_env_set_status(envid_t envid, int status)
{
	struct Env *e;
	int r;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	if (status != ENV_RUNNABLE && status != ENV_NOT_RUNNABLE)
		return -E_INVAL;
	e->env_status = status;
	return 0;
}

// Set envid's trap frame to 'tf'.
// tf is modified to make sure that user environments always run at code
// protection level 3 (CPL 3) with interrupts enabled.
//
// Returns 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
static int
sys_env_set_trapframe(envid_t envid, struct Trapframe *tf)
{
	int r;
	struct Env *e;
	struct Trapframe ltf;

	user_mem_assert(curenv, tf, sizeof(struct Trapframe), PTE_U);
	ltf = *tf;
	ltf.tf_eflags |= FL_IF;
	ltf.tf_cs |= 3;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	e->env_tf = ltf;
	return 0;
}

// Set the page fault upcall for 'envid' by modifying the corresponding struct
// Env's 'env_pgfault_upcall' field.  When 'envid' causes a page fault, the
// kernel will push a fault record onto the exception stack, then branch to
// 'func'.
//
// Returns 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
static int
sys_env_set_pgfault_upcall(envid_t envid, void *func)
{
	int r;
	struct Env *e;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	e->env_pgfault_upcall = func;
	return 0;
}

// Allocate a page of memory and map it at 'va' with permission
// 'perm' in the address space of 'envid'.
// The page's contents are set to 0.
// If a page is already mapped at 'va', that page is unmapped as a
// side effect.
//
// perm -- PTE_U | PTE_P must be set, PTE_AVAIL | PTE_W may or may not be set,
//         but no other bits may be set.  See PTE_SYSCALL in inc/mmu.h.
//
// Return 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
//	-E_INVAL if va >= UTOP, or va is not page-aligned.
//	-E_INVAL if perm is inappropriate (see above).
//	-E_NO_MEM if there's no memory to allocate the new page,
//		or to allocate any necessary page tables.
static int
sys_page_alloc(envid_t envid, void *va, int perm)
{
	int r;
	struct Env *e;
	struct PageInfo *pp;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	if ((~perm & (PTE_U|PTE_P)) || (perm & ~PTE_SYSCALL))
		return -E_INVAL;
	if (va >= (void*) UTOP)
		return -E_INVAL;
	if (!(pp = page_alloc(ALLOC_ZERO)))
		return -E_NO_MEM;
	if ((r = page_insert(e->env_pml4e, pp, va, perm)) < 0) {
		page_free(pp);
		return r;
	}
	return 0;
}

// Map the page of memory at 'srcva' in srcenvid's address space
// at 'dstva' in dstenvid's address space with permission 'perm'.
// Perm has the same restrictions as in sys_page_alloc, except
// that it also must not grant write access to a read-only
// page.
//
// Return 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if srcenvid and/or dstenvid doesn't currently exist,
//		or the caller doesn't have permission to change one of them.
//	-E_INVAL if srcva >= UTOP or srcva is not page-aligned,
//		or dstva >= UTOP or dstva is not page-aligned.
//	-E_INVAL is srcva is not mapped in srcenvid's address space.
//	-E_INVAL if perm is inappropriate (see sys_page_alloc).
//	-E_INVAL if (perm & PTE_W), but srcva is read-only in srcenvid's
//		address space.
//	-E_NO_MEM if there's no memory to allocate any necessary page tables.
static int
sys_page_map(envid_t srcenvid, void *srcva,
	     envid_t dstenvid, void *dstva, int perm)
{
	int r;
	struct Env *es, *ed;
	struct PageInfo *pp;
	pte_t *ppte;

	if (srcva >= (void*) UTOP || dstva >= (void*) UTOP)
		return -E_INVAL;
	if (srcva != ROUNDDOWN(srcva, PGSIZE) || dstva != ROUNDDOWN(dstva, PGSIZE))
		return -E_INVAL;

	if ((r = envid2env(srcenvid, &es, 1)) < 0
            || (r = envid2env(dstenvid, &ed, 1)) < 0)
		return r;
	if ((~perm & (PTE_U|PTE_P)) || (perm & ~PTE_SYSCALL))
		return -E_INVAL;
	if ((pp = page_lookup(es->env_pml4e, srcva, &ppte)) == 0)
		return -E_INVAL;
	if ((perm & PTE_W) && !(*ppte & PTE_W))
		return -E_INVAL;
	if ((r = page_insert(ed->env_pml4e, pp, dstva, perm)) < 0)
		return r;
	return 0;
}

// Unmap the page of memory at 'va' in the address space of 'envid'.
// If no page is mapped, the function silently succeeds.
//
// Return 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist,
//		or the caller doesn't have permission to change envid.
//	-E_INVAL if va >= UTOP, or va is not page-aligned.
static int
sys_page_unmap(envid_t envid, void *va)
{
	int r;
	struct Env *e;

	if ((r = envid2env(envid, &e, 1)) < 0)
		return r;
	if (va >= (void*) UTOP || PGOFF(va))
		return -E_INVAL;
	page_remove(e->env_pml4e, va);
	return 0;
}

// Try to send 'value' to the target env 'envid'.
// If srcva < UTOP, then also send page currently mapped at 'srcva',
// so that receiver gets a duplicate mapping of the same page.
//
// The send fails with a return value of -E_IPC_NOT_RECV if the
// target is not blocked, waiting for an IPC.
//
// The send also can fail for the other reasons listed below.
//
// Otherwise, the send succeeds, and the target's ipc fields are
// updated as follows:
//    env_ipc_recving is set to 0 to block future sends;
//    env_ipc_from is set to the sending envid;
//    env_ipc_value is set to the 'value' parameter;
//    env_ipc_perm is set to 'perm' if a page was transferred, 0 otherwise.
// The target environment is marked runnable again, returning 0
// from the paused sys_ipc_recv system call.  (Hint: does the
// sys_ipc_recv function ever actually return?)
//
// If the sender wants to send a page but the receiver isn't asking for one,
// then no page mapping is transferred, but no error occurs.
// The ipc only happens when no errors occur.
//
// When the environment is a guest (Lab 8, aka the VMM assignment only),
// srcva should be assumed to be converted to a host virtual address (in
// the kernel address range).  You will need to add a special case to allow
// accesses from ENV_TYPE_GUEST when srcva > UTOP.
//
// Returns 0 on success, < 0 on error.
// Errors are:
//	-E_BAD_ENV if environment envid doesn't currently exist.
//		(No need to check permissions.)
//	-E_IPC_NOT_RECV if envid is not currently blocked in sys_ipc_recv,
//		or another environment managed to send first.
//	-E_INVAL if srcva < UTOP but srcva is not page-aligned.
//	-E_INVAL if srcva < UTOP and perm is inappropriate
//		(see sys_page_alloc).
//	-E_INVAL if srcva < UTOP but srcva is not mapped in the caller's
//		address space.
//	-E_INVAL if (perm & PTE_W), but srcva is read-only in the
//		current environment's address space.
//	-E_NO_MEM if there's not enough memory to map srcva in envid's
//		address space.
static int
sys_ipc_try_send(envid_t envid, uint32_t value, void *srcva, unsigned perm)
{
    int r;
    struct Env *e;
    struct PageInfo *pp;
    pte_t *ppte;
    if ((r = envid2env(envid, &e, 0)) < 0)
        return r;
    if (!e->env_ipc_recving) {
        /* cprintf("[%08x] not recieving!\n", e->env_id); */
        return -E_IPC_NOT_RECV;
    }

    /*  Hint: check if environment is ENV_TYPE_GUEST or not, and if the source or destination 
     *  is using normal page, use page_insert. Use ept_page_insert() wherever possible. */
    /* Your code here */

    if (srcva < (void*) UTOP && e->env_ipc_dstva < (void*) UTOP) {
        if ((~perm & (PTE_U|PTE_P)) || (perm & ~PTE_SYSCALL)) {
            cprintf("[%08x] bad perm %x in sys_ipc_try_send\n", curenv->env_id, perm);
            return -E_INVAL;
        }

        pp = page_lookup(curenv->env_pml4e, srcva, &ppte);
        if (pp == 0) {
            cprintf("[%08x] page_lookup %08x failed in sys_ipc_try_send\n", curenv->env_id, srcva);
            return -E_INVAL;
        }

        if ((perm & PTE_W) && !(*ppte & PTE_W)) {
            cprintf("[%08x] attempt to send read-only page read-write in sys_ipc_try_send\n", curenv->env_id);
            return -E_INVAL;
        }

        r = page_insert(e->env_pml4e, pp, e->env_ipc_dstva, perm);
        if (r < 0) {
            cprintf("[%08x] page_insert %08x failed in sys_ipc_try_send (%e)\n", curenv->env_id, srcva, r);
            return r;
        }

        e->env_ipc_perm = perm;
    } else {
        e->env_ipc_perm = 0;
    }

    e->env_ipc_recving = 0;
    e->env_ipc_from = curenv->env_id;
    e->env_ipc_value = value;
    e->env_tf.tf_regs.reg_rax = 0;
    e->env_status = ENV_RUNNABLE;
    return 0;
}

// Block until a value is ready.  Record that you want to receive
// using the env_ipc_recving and env_ipc_dstva fields of struct Env,
// mark yourself not runnable, and then give up the CPU.
//
// If 'dstva' is < UTOP, then you are willing to receive a page of data.
// 'dstva' is the virtual address at which the sent page should be mapped.
//
// This function only returns on error, but the system call will eventually
// return 0 on success.
// Return < 0 on error.  Errors are:
//	-E_INVAL if dstva < UTOP but dstva is not page-aligned.
static int
sys_ipc_recv(void *dstva)
{
	if (curenv->env_ipc_recving)
		panic("already recving!");

	curenv->env_ipc_recving = 1;
	curenv->env_ipc_dstva = dstva;
	curenv->env_status = ENV_NOT_RUNNABLE;
	sched_yield();
	return 0;
}


// Return the current time.
static int
sys_time_msec(void)
{
	return (int) time_msec();
}

static int
sys_net_transmit(const void *data, size_t len)
{
	user_mem_assert(curenv, data, len, 0);
	return e1000_transmit(data, len);
}

static int
sys_net_receive(void *buf, size_t len)
{
	user_mem_assert(curenv, buf, len, PTE_W);
	return e1000_receive(buf, len);
}

#ifndef VMM_GUEST
static void
sys_vmx_list_vms() {
	vmx_list_vms();
}

static bool
sys_vmx_sel_resume(int i) {
	return vmx_sel_resume(i);
}

static int
sys_vmx_get_vmdisk_number() {
	return vmx_get_vmdisk_number();
}

static void
sys_vmx_incr_vmdisk_number() {
	vmx_incr_vmdisk_number();
}

// Maps a page from the evnironment corresponding to envid into the guest vm 
// environments phys addr space.  Assuming the mapping is successful, this should
// also increment the reference count of the mapped page.
//
//
// Return 0 on success, < 0 on error.  Errors are:
//	-E_BAD_ENV if srcenvid and/or guest doesn't currently exist,
//		or the caller doesn't have permission to change one of them.
//	-E_INVAL if srcva >= UTOP or srcva is not page-aligned,
//		or guest_pa >= guest physical size or guest_pa is not page-aligned.
//	-E_INVAL is srcva is not mapped in srcenvid's address space.
//	-E_INVAL if perm is inappropriate 
//	-E_INVAL if (perm & PTE_W), but srcva is read-only in srcenvid's
//		address space.
//	-E_NO_MEM if there's no memory to allocate any necessary page tables. 
//
// Hint: Use ept_map_hva2gpa().  A guest environment uses 
//       env_pml4e to store the root of the extended page tables.
//       This function is similar to sys_page_map(). It uses Extended Page Table 
//       instead of the normal page table. 
// 
static int
sys_ept_map(envid_t srcenvid, void *srcva,
	    envid_t guest, void* guest_pa, int perm)
{
    /* Your code here */
    return 0;
}

static envid_t
	sys_env_mkguest(uint64_t gphysz, uint64_t gRIP) {
	int r;
	struct Env *e;

	// Check if the processor has VMX support.
	if ( !vmx_check_support() ) {
		return -E_NO_VMX;
	} else if ( !vmx_check_ept() ) {
		return -E_NO_EPT;
	} 
	if ((r = env_guest_alloc(&e, curenv->env_id)) < 0)
		return r;
	e->env_status = ENV_NOT_RUNNABLE;
	e->env_vmxinfo.phys_sz = gphysz;
	e->env_tf.tf_rip = gRIP;
	return e->env_id;
}
#endif //!VMM_GUEST

// Dispatches to the correct kernel function, passing the arguments.
int64_t
syscall(uint64_t syscallno, uint64_t a1, uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5)
{
	switch (syscallno) {
	case SYS_cputs:
		sys_cputs((const char*) a1, a2);
		return 0;
	case SYS_cgetc:
		return sys_cgetc();
	case SYS_getenvid:
		return sys_getenvid();
	case SYS_env_destroy:
		return sys_env_destroy(a1);
	case SYS_page_alloc:
		return sys_page_alloc(a1, (void*) a2, a3);
	case SYS_page_map:
		return sys_page_map(a1, (void*) a2, a3, (void*) a4, a5);
	case SYS_page_unmap:
		return sys_page_unmap(a1, (void*) a2);
	case SYS_exofork:
		return sys_exofork();
	case SYS_env_set_status:
		return sys_env_set_status(a1, a2);
	case SYS_env_set_trapframe:
		return sys_env_set_trapframe(a1, (struct Trapframe*) a2);
	case SYS_env_set_pgfault_upcall:
		return sys_env_set_pgfault_upcall(a1, (void*) a2);
	case SYS_yield:
		sys_yield();
		return 0;
	case SYS_ipc_try_send:
		return sys_ipc_try_send(a1, a2, (void*) a3, a4);
	case SYS_ipc_recv:
		sys_ipc_recv((void*) a1);
		return 0;
	case SYS_time_msec:
		return sys_time_msec();
	case SYS_net_transmit:
		return sys_net_transmit((const void*)a1, a2);
	case SYS_net_receive:
		return sys_net_receive((void*)a1, a2);
#ifndef VMM_GUEST
	case SYS_ept_map:
		return sys_ept_map(a1, (void*) a2, a3, (void*) a4, a5);
	case SYS_env_mkguest:
		return sys_env_mkguest(a1, a2);
	case SYS_vmx_list_vms:
		sys_vmx_list_vms();
		return 0;
	case SYS_vmx_sel_resume:
		return sys_vmx_sel_resume(a1);
	case SYS_vmx_get_vmdisk_number:
		return sys_vmx_get_vmdisk_number();
	case SYS_vmx_incr_vmdisk_number:
		sys_vmx_incr_vmdisk_number();
		return 0;
#endif

	default:
		return -E_NO_SYS;
	}
}

#ifdef TEST_EPT_MAP
int
_export_sys_ept_map(envid_t srcenvid, void *srcva,
		    envid_t guest, void* guest_pa, int perm)
{
	return sys_ept_map(srcenvid, srcva, guest, guest_pa, perm);
}
#endif
