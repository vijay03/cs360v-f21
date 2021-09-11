// Simple command-line kernel monitor useful for
// controlling the kernel and exploring the system interactively.

#include <inc/stdio.h>
#include <inc/string.h>
#include <inc/memlayout.h>
#include <inc/assert.h>
#include <inc/x86.h>

#include <kern/console.h>
#include <kern/monitor.h>
#include <kern/dwarf.h>
#include <kern/kdebug.h>
#include <kern/dwarf_api.h>
#line 16 "../kern/monitor.c"
#include <kern/trap.h>
#line 18 "../kern/monitor.c"

#define CMDBUF_SIZE	80	// enough for one VGA text line

#line 22 "../kern/monitor.c"
static int mon_exit(int argc, char** argv, struct Trapframe* tf);
#line 24 "../kern/monitor.c"

struct Command {
	const char *name;
	const char *desc;
	// return -1 to force monitor to exit
	int (*func)(int argc, char** argv, struct Trapframe* tf);
};

static struct Command commands[] = {
	{ "help", "Display this list of commands", mon_help },
	{ "kerninfo", "Display information about the kernel", mon_kerninfo },
#line 36 "../kern/monitor.c"
	{ "backtrace", "Display a stack backtrace", mon_backtrace },
#line 39 "../kern/monitor.c"
#ifdef VMM_GUEST
	{ "exit", "Exit VMM guest", mon_exit },
#else
	{ "exit", "Exit the kernel monitor", mon_exit },
#endif
#line 45 "../kern/monitor.c"
};
#define NCOMMANDS (sizeof(commands)/sizeof(commands[0]))

/***** Implementations of basic kernel monitor commands *****/

int
mon_help(int argc, char **argv, struct Trapframe *tf)
{
	int i;

	for (i = 0; i < NCOMMANDS; i++)
		cprintf("%s - %s\n", commands[i].name, commands[i].desc);
	return 0;
}

int
mon_kerninfo(int argc, char **argv, struct Trapframe *tf)
{
	extern char _start[], entry[], etext[], edata[], end[];

	cprintf("Special kernel symbols:\n");
	cprintf("  _start                  %08x (phys)\n", _start);
	cprintf("  entry  %08x (virt)  %08x (phys)\n", entry, entry - KERNBASE);
	cprintf("  etext  %08x (virt)  %08x (phys)\n", etext, etext - KERNBASE);
	cprintf("  edata  %08x (virt)  %08x (phys)\n", edata, edata - KERNBASE);
	cprintf("  end    %08x (virt)  %08x (phys)\n", end, end - KERNBASE);
	cprintf("Kernel executable memory footprint: %dKB\n",
		ROUNDUP(end - entry, 1024) / 1024);
	return 0;
}

int
mon_backtrace(int argc, char **argv, struct Trapframe *tf)
{
#line 80 "../kern/monitor.c"
	int i;
	const uint64_t *rbp;
	uint64_t rip;
	uint64_t rsp;
	uint64_t offset;
	struct Ripdebuginfo info;

	rbp = (const uint64_t*)read_rbp();
	rsp = read_rsp();
#line 90 "../kern/monitor.c"
	if (tf) {
		rbp = (const uint64_t*)tf->tf_regs.reg_rbp;
		rsp = tf->tf_rsp;
	}
#line 95 "../kern/monitor.c"
	read_rip(rip);

	cprintf("Stack backtrace:\n");
	while (rbp) {
		// print this stack frame
		cprintf("  rbp %016llx  rip %016llx\n", rbp, rip);
		if (debuginfo_rip(rip, &info) >= 0){
			Dwarf_Regtable_Entry *cfa_rule = &info.reg_table.cfa_rule;
			uint64_t cfa;

			cprintf("       %s:%d: %.*s+%016llx", info.rip_file, info.rip_line, 
				info.rip_fn_namelen, info.rip_fn_name, rip - info.rip_fn_addr);

			if (cfa_rule->dw_regnum == 6) { /* 6: rbp */
				cfa = (uint64_t)rbp + cfa_rule->dw_offset;
			} else if (cfa_rule->dw_regnum == 7) { /* 7: rsp */
				cfa = rsp + cfa_rule->dw_offset;
			} else {
				goto unknown_cfa;
			}

			cprintf("  args:%d ", info.rip_fn_narg);
			for (i = 0; i < info.rip_fn_narg ; i++)
			{
				uint64_t val;
				assert(info.offset_fn_arg[i]);
				offset = cfa + info.offset_fn_arg[i];
				switch(info.size_fn_arg[i]) {
					case 8:
						val = *(uint64_t *) offset;
						break;
					case 4:
						val = *(uint32_t *) offset;
						break;
					case 2:
						val = *(uint16_t *) offset;
						break;
					case 1:
						val = *(uint8_t *) offset;
						break;
				}
				cprintf(" %016x", val);
			}

			switch(info.reg_table.rules[6].dw_regnum) { /* 6: rbp */
				case DW_FRAME_SAME_VAL:
					break;
				case DW_FRAME_CFA_COL3:
					rbp = (const uint64_t *)*(uint64_t *)(cfa + info.reg_table.rules[6].dw_offset);
					break;
				default:
					panic("unknown reg rule");
					break;
			}

			switch(info.reg_table.rules[16].dw_regnum) { /* 16: rip */
				case DW_FRAME_SAME_VAL:
					break;
				case DW_FRAME_CFA_COL3:
					rip = *(uint64_t *)(cfa + info.reg_table.rules[16].dw_offset);
					break;
				default:
					panic("unknown reg rule");
					break;
			}

			rsp = cfa;
		} else {
unknown_cfa:
			// move to next lower stack frame
			rip = rbp[1];
			rbp = (const uint64_t*) rbp[0];
		}
		cprintf("\n");
	}
#line 173 "../kern/monitor.c"
	return 0;
}

#line 177 "../kern/monitor.c"
int
mon_exit(int argc, char** argv, struct Trapframe* tf)
{
#ifdef VMM_GUEST
	asm("hlt");
#endif
	return -1;
}
#line 186 "../kern/monitor.c"


/***** Kernel monitor command interpreter *****/

#define WHITESPACE "\t\r\n "
#define MAXARGS 16

static int
runcmd(char *buf, struct Trapframe *tf)
{
	int argc;
	char *argv[MAXARGS];
	int i;

	// Parse the command buffer into whitespace-separated arguments
	argc = 0;
	argv[argc] = 0;
	while (1) {
		// gobble whitespace
		while (*buf && strchr(WHITESPACE, *buf))
			*buf++ = 0;
		if (*buf == 0)
			break;

		// save and scan past next arg
		if (argc == MAXARGS-1) {
			cprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
		while (*buf && !strchr(WHITESPACE, *buf))
			buf++;
	}
	argv[argc] = 0;

	// Lookup and invoke the command
	if (argc == 0)
		return 0;
	for (i = 0; i < NCOMMANDS; i++) {
		if (strcmp(argv[0], commands[i].name) == 0)
			return commands[i].func(argc, argv, tf);
	}
	cprintf("Unknown command '%s'\n", argv[0]);
	return 0;
}

void
monitor(struct Trapframe *tf)
{
	char *buf;

	cprintf("Welcome to the JOS kernel monitor!\n");
	cprintf("Type 'help' for a list of commands.\n");

#line 241 "../kern/monitor.c"
	if (tf != NULL)
		print_trapframe(tf);
#line 244 "../kern/monitor.c"

	while (1) {
		buf = readline("K> ");
		if (buf != NULL)
			if (runcmd(buf, tf) < 0)
				break;
	}
}
