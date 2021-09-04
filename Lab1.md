## Project-1

In this project, you will implement a few exciting pieces of a paravirtual hypervisor. You will use the JOS operating system running on QEMU for this project. Check the [tools page](https://github.com/vijay03/cs360v-f20/blob/master/tools.md) for an overview on JOS and useful commands of QEMU. The project covers bootstrapping a guest OS, programming extended page tables, emulating privileged instructions, and using hypercalls to implement hard drive emulation over a disk image file. You will work on them over the next 3 or 4 lab assignments and at the end, you will launch a JOS-in-JOS environment. 

### Background

This README series contains some background related to project-1. Reading this document will help you understand the pieces you will be implementing on a high level as you work on project-1.

The README series is broken down into 4 parts:
1. [Bootloader and Kernel](https://github.com/vijay03/cs360v-f20/blob/master/bootloader.md) which will help you in the understanding first part of the project, namely what happens when you boot up your PC (in our case, create or boot the guest).
2. [Virtual Memory](https://github.com/vijay03/cs360v-f20/blob/master/virtual_memory.md) which will help you in understanding the second part - where we transfer the multiboot structure from the host to the guest, for the guest to understand how much memory it is allocated and how much it can use. This part also contains details about segmentation and paging, which are a good background for the project in general.
3. [Environments](https://github.com/vijay03/cs360v-f20/blob/master/environments.md) which will help you in understanding what exactly is an environment, and some details about the environment structure which is used in sys_ept_map() and the trapframe structure.
4. [File System](https://github.com/vijay03/cs360v-f20/blob/master/file_system.md) which will help you in understanding the second part of the lab, where we handle vmcalls related to reading and writing of data to a disk.

## Lab-1
Deadline: **Sep 21**

## Getting started 

Your environment should be set up from Lab 0. We will making changes in the same codebase. If you did not recieve full marks for the previous lab, please reach out to the TA to get the correct implementation of the previous files.

## Part-1 Pre-lab Questions 

Before starting the coding portion of this assignment, we are going to observe certain things about the code base first.

The first thing you should do is look through the helper functions in `inc/x86.h`, `inc/vmx.h`, and `vmm/vmx.h`

The first method you will be editing is `vmx_check_support()` in `vmm/vmx.c`. The function currently calls the `cpuid` function. The parameters to the function are the addresses of the integers initialized in the line before. Set a breakpoint at the `cpuid()`function call, and step through the function. 

1. What does the `cpuid` assembly instruction do in this function? 

2. How is the function providing values back to you to use? 

3. What are the results of eax, ecx, and ebx values in hexadecimal? Hint: [you can print program variables from GDB](https://sourceware.org/gdb/current/onlinedocs/gdb/Variables.html)

4. Now examine the values of these variables as strings. Hint: look at the values in hexadecimal and translate them to strings, in the order `ebx, ecx, edx`. What do you observe? The [Wikipedia page](https://en.wikipedia.org/wiki/CPUID) for the `cpuid` instruction may help you interpret this output.

There is a reference in each Env struct for another struct called VmxGuestInfo. 

5. What kind of information does this struct hold? 

6. From [this Intel guide](https://www.cs.utexas.edu/~vijay/cs378-f17/projects/64-ia-32-architectures-software-developer-vol-3c-part-3-manual.pdf), find out what the vmcs pointer in this struct stands for, and what it purpose it serves. 

7. What assembly instruction initializes the vmcs pointer? 

## Part-2 Coding Assignment (Making a Guest Environment)

Currently, `make run-vmm-nox` will panic the kernel as the code that detects support for vmx and extended page table support is not yet implemented. You will see the following error and you will fix this in Lab-1:
```
kernel panic on CPU 0 at ../vmm/vmx.c:65: vmx_check_support not implemented
```

Background:
The JOS VMM is launched by a fairly simple program in user/vmm.c. This program,
- Calls a new system call to create an environment (similar to a process) that runs in guest mode (sys_env_mkguest).
- Once the guest is created, the VMM then copies the bootloader and kernel into the guest's physical address space.
- Then, it marks the environment as runnable, and waits for the guest to exit.

You will be implementing key pieces of the supporting system calls for the JOS VMM, as well as some of the copying functionality.

Before diving into the implementation details, You may want to skim the 
- JOS bookkeeping code for sys_env_mkguest that is already provided for you in kern/syscall.c
- Code in kern/env.h to understand how guest/regular environments are managed. You should have become acquainted with this implementation in Lab 0.

Note that a major difference between a guest and a regular environment is that a guest has its type set to ENV_TYPE_GUEST. Additionally guest has a VmxGuestInfo structure and a vmcs structure associated with it.

The vmm directory includes the kernel-level support needed for the VMM--primarily extended page table support. In lab-1, you have two tasks at hand:
1. Checking support for vmx and extended paging
2. Running a guest environment

#### Checking Support for VMX and Extended Paging

Your first task will be to implement detection that the CPU supports vmx and extended paging. Remember how in the pre-lab, we used the `cpuid()` function to obtain information about the processor. You will use this function to check whether the CPU supports vmx and extended paging. To understand how to implement the checks for the vmx and extended paging support, read Chapters 23.6, 24.6.2, and Appendices A.3.2-3 from the [Intel Manual](http://www.cs.utexas.edu/~vijay/cs378-f17/projects/64-ia-32-architectures-software-developer-vol-3c-part-3-manual.pdf). Chapter 1 of [this other manual](https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.html) provides some information about how to read Intel manuals that may be helpful.

Once you have read these sections, you will understand how to check support for vmx and extended paging. Now, implement the vmx_check_support() and vmx_check_ept() functions in vmm/vmx.c. Please read the hints above these functions to spot code that is already provided, for example, to read MSRs.

#### Running a Guest Environment

Your second task will be to add support to sched_yield() in kern/sched.c to call vmxon() when launching a guest environment.

If these functions are properly implemented, an attempt to start the VMM will not panic the kernel, but will fail because the vmm can't map guest bootloader and kernel into the VM. The error will look something like this:
```
Error copying page into the guest - 4294967289
```

## Hints

In all lab assignments in project-1, the functions you will be implementing might have hints on how to implement them as comments above. So please pay attention to the comments in the code.

## Submission Details

Submissions will be handled through gitolite.
Commits made until midnight on the day of the submission deadline will be used for grading.

## Contact Details

Reach out to the TAs in case of any difficulties.
