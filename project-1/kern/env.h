#line 2 "../kern/env.h"
/* See COPYRIGHT for copyright information. */

#ifndef JOS_KERN_ENV_H
#define JOS_KERN_ENV_H

#include <inc/env.h>
#line 9 "../kern/env.h"
#include <kern/cpu.h>
#line 11 "../kern/env.h"

extern struct Env *envs;		// All environments
#line 14 "../kern/env.h"
#define curenv (thiscpu->cpu_env)		// Current environment
#line 18 "../kern/env.h"
extern struct Segdesc gdt[];

void	env_init(void);
void	env_init_percpu(void);
int	env_alloc(struct Env **e, envid_t parent_id);
void	env_free(struct Env *e);
void	env_create(uint8_t *binary, enum EnvType type);
void	env_destroy(struct Env *e);	// Does not return if e == curenv

int	envid2env(envid_t envid, struct Env **env_store, bool checkperm);
// The following two functions do not return
void	env_run(struct Env *e) __attribute__((noreturn));
void	env_pop_tf(struct Trapframe *tf) __attribute__((noreturn));

#line 33 "../kern/env.h"
int env_guest_alloc(struct Env **newenv_store, envid_t parent_id);
#line 35 "../kern/env.h"

// Without this extra macro, we couldn't pass macros like TEST to
// ENV_CREATE because of the C pre-processor's argument prescan rule.
#define ENV_PASTE3(x, y, z) x ## y ## z

#line 41 "../kern/env.h"
#ifndef VMM_GUEST
#define ENV_CREATE(x, type)						\
	do {								\
		extern uint8_t ENV_PASTE3(_binary_obj_, x, _start)[];	\
		env_create(ENV_PASTE3(_binary_obj_, x, _start),		\
			   type);					\
	} while (0)
#else
#define ENV_CREATE(x, type)						\
	do {								\
		extern uint8_t ENV_PASTE3(_binary_vmm_guest_obj_, x, _start)[];	\
		env_create(ENV_PASTE3(_binary_vmm_guest_obj_, x, _start),		\
			   type);					\
	} while (0)
#endif //!VMM_GUEST
#line 64 "../kern/env.h"

#endif // !JOS_KERN_ENV_H
