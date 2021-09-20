#line 2 "../lib/ipc.c"
// User-level IPC library routines

#include <inc/lib.h>
#line 6 "../lib/ipc.c"
#ifdef VMM_GUEST
#include <inc/vmx.h>
#endif
#line 10 "../lib/ipc.c"

// Receive a value via IPC and return it.
// If 'pg' is nonnull, then any page sent by the sender will be mapped at
//	that address.
// If 'from_env_store' is nonnull, then store the IPC sender's envid in
//	*from_env_store.
// If 'perm_store' is nonnull, then store the IPC sender's page permission
//	in *perm_store (this is nonzero iff a page was successfully
//	transferred to 'pg').
// If the system call fails, then store 0 in *fromenv and *perm (if
//	they're nonnull) and return the error.
// Otherwise, return the value sent by the sender
//
// Hint:
//   Use 'thisenv' to discover the value and who sent it.
//   If 'pg' is null, pass sys_ipc_recv a value that it will understand
//   as meaning "no page".  (Zero is not the right value, since that's
//   a perfectly valid place to map a page.)
int32_t
ipc_recv(envid_t *from_env_store, void *pg, int *perm_store)
{
	int r;

	if (!pg)
		pg = (void*) UTOP;
	if ((r = sys_ipc_recv(pg)) < 0) {
		if (from_env_store)
			*from_env_store = 0;
		if (perm_store)
			*perm_store = 0;
		return r;
	}
	if (from_env_store)
		*from_env_store = thisenv->env_ipc_from;
	if (perm_store)
		*perm_store = thisenv->env_ipc_perm;
	return thisenv->env_ipc_value;
}

// Send 'val' (and 'pg' with 'perm', if 'pg' is nonnull) to 'toenv'.
// This function keeps trying until it succeeds.
// It should panic() on any error other than -E_IPC_NOT_RECV.
//
// Hint:
//   Use sys_yield() to be CPU-friendly.
//   If 'pg' is null, pass sys_ipc_recv a value that it will understand
//   as meaning "no page".  (Zero is not the right value.)
void
ipc_send(envid_t to_env, uint32_t val, void *pg, int perm)
{
	int r;

	if (!pg)
		pg = (void*) UTOP;
	while ((r = sys_ipc_try_send(to_env, val, pg, perm)) == -E_IPC_NOT_RECV) {
		sys_yield();
	}
	if (r < 0)
		panic("error in ipc_send: %e", r);
}

#ifdef VMM_GUEST

// Access to host IPC interface through VMCALL.
// Should behave similarly to ipc_recv, except replacing the system call with a vmcall.
int32_t
ipc_host_recv(void *pg) {
    /* Your code here */
    panic("ipc_host_recv not implemented\n");
    // r stores the return of the vmcall
    int r = 0, val = 0;
    if (!pg)
    	pg = (void*) UTOP;

    sys_page_alloc(0, pg, PTE_U|PTE_P|PTE_W);
    physaddr_t pa = PTE_ADDR(uvpt[PGNUM(pg)]);

    // ISSUE VMCALL

    if (r < 0) {
		return r;
	}

}

// Access to host IPC interface through VMCALL.
// Should behave similarly to ipc_send, except replacing the system call with a vmcall.
// This function should also convert pg from guest virtual to guest physical for the IPC call
void
ipc_host_send(envid_t to_env, uint32_t val, void *pg, int perm)
{
    /* Your code here */
    // r stores the return of the vmcall
    panic("ipc_host_send not implemented\n");
    int r = 0;
    if (!pg)
    	pg = (void*) UTOP;

    physaddr_t pa = PTE_ADDR(uvpt[PGNUM(pg)]);

    // ISSUE FIRST VMCALL
    while(r == -E_IPC_NOT_RECV) {
		sys_yield();
		// TRY VMCALL REPEATEDLY UNTIL YOU GET A RESPONSE
	}
	if (r < 0)
		panic("error in ipc_send: %e", r);

}

#endif // VMM_GUEST

// Find the first environment of the given type.  We'll use this to
// find special environments.
// Returns 0 if no such environment exists.
envid_t
ipc_find_env(enum EnvType type)
{
	int i;
	for (i = 0; i < NENV; i++) {
		if (envs[i].env_type == type)
			return envs[i].env_id;
	}
	return 0;
}
