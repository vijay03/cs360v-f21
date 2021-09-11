#line 2 "../kern/cpu.h"

#ifndef JOS_INC_CPU_H
#define JOS_INC_CPU_H

#include <inc/types.h>
#include <inc/memlayout.h>
#include <inc/mmu.h>
#include <inc/env.h>

#line 15 "../kern/cpu.h"
#define NCPU  4
#line 17 "../kern/cpu.h"



// Values of status in struct Cpu
enum {
	CPU_UNUSED = 0,
	CPU_STARTED,
	CPU_HALTED,
};

// Per-CPU state
struct CpuInfo {
	uint8_t cpu_id;                 // Local APIC ID; index into cpus[] below
	volatile unsigned cpu_status;   // The status of the CPU
	struct Env *cpu_env;            // The currently-running environment.
	struct Taskstate cpu_ts;        // Used by x86 to find stack for interrupt
#line 34 "../kern/cpu.h"
    bool is_vmx_root;               // Is the CPU in VMX root mode?
    uintptr_t vmxon_region;         // KVA of vmxon region.
#line 37 "../kern/cpu.h"
};

// Initialized in mpconfig.c
extern struct CpuInfo cpus[NCPU];
extern int ncpu;                    // Total number of CPUs in the system
extern struct CpuInfo *bootcpu;     // The boot-strap processor (BSP)
extern physaddr_t lapicaddr;        // Physical MMIO address of the local APIC

// Per-CPU kernel stacks
extern unsigned char percpu_kstacks[NCPU][KSTKSIZE];

int cpunum(void);
#define thiscpu (&cpus[cpunum()])

void mp_init(void);
void lapic_init(void);
void lapic_startap(uint8_t apicid, uint32_t addr);
void lapic_eoi(void);
void lapic_ipi(int vector);

#endif
