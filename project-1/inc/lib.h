#line 2 "../inc/lib.h"
// Main public header file for our user-land support library,
// whose code lives in the lib directory.
// This library is roughly our OS's version of a standard C library,
// and is intended to be linked into all user-mode applications
// (NOT the kernel or boot loader).

#ifndef JOS_INC_LIB_H
#define JOS_INC_LIB_H 1

#include <inc/types.h>
#include <inc/stdio.h>
#include <inc/stdarg.h>
#include <inc/string.h>
#include <inc/error.h>
#include <inc/assert.h>
#include <inc/env.h>
#include <inc/memlayout.h>
#include <inc/syscall.h>
#line 21 "../inc/lib.h"
#include <inc/trap.h>
#line 24 "../inc/lib.h"
#include <inc/fs.h>
#include <inc/fd.h>
#include <inc/args.h>
#line 29 "../inc/lib.h"
#include <inc/malloc.h>
#include <inc/ns.h>
#line 33 "../inc/lib.h"
#include <inc/vmx.h>
#line 35 "../inc/lib.h"

#define USED(x)		(void)(x)

// main user program
void	umain(int argc, char **argv);

// libmain.c or entry.S
extern const char *binaryname;
extern const volatile struct Env *thisenv;
extern const volatile struct Env envs[NENV];
extern const volatile struct PageInfo pages[];

// exit.c
void	exit(void);

#line 51 "../inc/lib.h"
// pgfault.c
void	set_pgfault_handler(void (*handler)(struct UTrapframe *utf));

#line 55 "../inc/lib.h"
// readline.c
char*	readline(const char *buf);

// syscall.c
void	sys_cputs(const char *string, size_t len);
int	sys_cgetc(void);
envid_t	sys_getenvid(void);
int	sys_env_destroy(envid_t);
#line 64 "../inc/lib.h"
void	sys_yield(void);
static envid_t sys_exofork(void);
int	sys_env_set_status(envid_t env, int status);
#line 68 "../inc/lib.h"
int	sys_env_set_trapframe(envid_t env, struct Trapframe *tf);
#line 70 "../inc/lib.h"
int	sys_env_set_pgfault_upcall(envid_t env, void *upcall);
int	sys_page_alloc(envid_t env, void *pg, int perm);
int	sys_page_map(envid_t src_env, void *src_pg,
		     envid_t dst_env, void *dst_pg, int perm);
int	sys_page_unmap(envid_t env, void *pg);
int	sys_ipc_try_send(envid_t to_env, uint64_t value, void *pg, int perm);
int	sys_ipc_recv(void *rcv_pg);
#line 78 "../inc/lib.h"
unsigned int sys_time_msec(void);
#line 80 "../inc/lib.h"
int	sys_net_transmit(const char *data, unsigned int len);
int	sys_net_receive(char *buf, unsigned int len);
#line 85 "../inc/lib.h"
int sys_ept_map(envid_t srcenvid, void *srcva, envid_t guest, void* guest_pa, int perm);
envid_t sys_env_mkguest(uint64_t gphysz, uint64_t gRIP);
#ifndef VMM_GUEST
void	sys_vmx_list_vms();
int	sys_vmx_sel_resume(int i);
int	sys_vmx_get_vmdisk_number();
void	sys_vmx_incr_vmdisk_number();
#endif
#line 94 "../inc/lib.h"

// This must be inlined.  Exercise for reader: why?
static __inline envid_t __attribute__((always_inline))
sys_exofork(void)
{
	envid_t ret;
	__asm __volatile("int %2"
		: "=a" (ret)
		: "a" (SYS_exofork),
		  "i" (T_SYSCALL)
	);
	return ret;
}

// ipc.c
void	ipc_send(envid_t to_env, uint32_t value, void *pg, int perm);
int32_t ipc_recv(envid_t *from_env_store, void *pg, int *perm_store);
envid_t	ipc_find_env(enum EnvType type);

#line 114 "../inc/lib.h"
#ifdef VMM_GUEST
void	ipc_host_send(envid_t to_env, uint32_t value, void *pg, int perm);
int32_t ipc_host_recv(void *pg);
#endif
#line 119 "../inc/lib.h"

// fork.c
#define	PTE_SHARE	0x400
envid_t	fork(void);
envid_t	sfork(void);	// Challenge!
#line 125 "../inc/lib.h"

#line 127 "../inc/lib.h"
// fd.c
int	close(int fd);
ssize_t	read(int fd, void *buf, size_t nbytes);
ssize_t	write(int fd, const void *buf, size_t nbytes);
int	seek(int fd, off_t offset);
void	close_all(void);
ssize_t	readn(int fd, void *buf, size_t nbytes);
int	dup(int oldfd, int newfd);
int	fstat(int fd, struct Stat *statbuf);
int	stat(const char *path, struct Stat *statbuf);

// file.c
int	open(const char *path, int mode);
int	ftruncate(int fd, off_t size);
int	remove(const char *path);
int	sync(void);
#line 144 "../inc/lib.h"
int	copy(char *src, char *dest);
#line 146 "../inc/lib.h"


// pageref.c
int	pageref(void *addr);

#line 152 "../inc/lib.h"
// sockets.c
int     accept(int s, struct sockaddr *addr, socklen_t *addrlen);
int     bind(int s, struct sockaddr *name, socklen_t namelen);
int     shutdown(int s, int how);
int     connect(int s, const struct sockaddr *name, socklen_t namelen);
int     listen(int s, int backlog);
int     socket(int domain, int type, int protocol);

// nsipc.c
int     nsipc_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
int     nsipc_bind(int s, struct sockaddr *name, socklen_t namelen);
int     nsipc_shutdown(int s, int how);
int     nsipc_close(int s);
int     nsipc_connect(int s, const struct sockaddr *name, socklen_t namelen);
int     nsipc_listen(int s, int backlog);
int     nsipc_recv(int s, void *mem, int len, unsigned int flags);
int     nsipc_send(int s, const void *buf, int size, unsigned int flags);
int     nsipc_socket(int domain, int type, int protocol);
#line 171 "../inc/lib.h"

// spawn.c
envid_t	spawn(const char *program, const char **argv);
envid_t	spawnl(const char *program, const char *arg0, ...);
#line 176 "../inc/lib.h"

#line 178 "../inc/lib.h"
// console.c
void	cputchar(int c);
int	getchar(void);
int	iscons(int fd);
int	opencons(void);

// pipe.c
int	pipe(int pipefds[2]);
int	pipeisclosed(int pipefd);

// wait.c
void	wait(envid_t env);
#line 191 "../inc/lib.h"

/* File open modes */
#define	O_RDONLY	0x0000		/* open for reading only */
#define	O_WRONLY	0x0001		/* open for writing only */
#define	O_RDWR		0x0002		/* open for reading and writing */
#define	O_ACCMODE	0x0003		/* mask for above modes */

#define	O_CREAT		0x0100		/* create if nonexistent */
#define	O_TRUNC		0x0200		/* truncate to zero length */
#define	O_EXCL		0x0400		/* error if already exists */
#define O_MKDIR		0x0800		/* create directory, not regular file */

#endif	// !JOS_INC_LIB_H
