## Lab 0 Intro
In this lab, you will implement a few features to become familar with the environment and the system that you will work with for the rest of the course. For Lab-0, you will first set up your working environment and then implement code to demonstrate understanding of the codebase. 

Throughout these labs, you will gradually build all of the pieces required to build a hypervisor. Hypervisors provide the means of running multiple OSes managed by just one entity, a single machine. We must make sure our hypervisor does several things, such as provide OS-level isolation for users and allocating and switching out resources efficiently. 

You will use the JOS operating system running on QEMU for this project. Check the [tools page](https://github.com/vijay03/cs360v-f21/blob/main/tools.md) for an overview on JOS and useful commands of QEMU. You will work on them over the next 3 or 4 lab assignments and at the end, you will launch a JOS-in-JOS environment. You will cover many tasks, such as interfacing with the hardware with system calls, handling vmexits (similar to a context switch), and mapping the bootloader in memory.  

### Background

This README series contains some background related to project-1. Reading this document will help you understand the pieces you will be implementing on a high level as you work on project-1.

The README series is broken down into 4 parts:
1. [Bootloader and Kernel](https://github.com/vijay03/cs360v-f21/blob/main/bootloader.md) which will help you in the understanding first part of the project, namely what happens when you boot up your PC (in our case, create or boot the guest).
2. [Virtual Memory](https://github.com/vijay03/cs360v-f21/blob/main/virtual_memory.md) which will help you in understanding the second part - where we transfer the multiboot structure from the host to the guest, for the guest to understand how much memory it is allocated and how much it can use. This part also contains details about segmentation and paging, which are a good background for the project in general.
3. [Environments](https://github.com/vijay03/cs360v-f21/blob/main/environments.md) which will help you in understanding what exactly is an environment, and some details about the environment structure which is used in sys_ept_map() and the trapframe structure.
4. [File System](https://github.com/vijay03/cs360v-f21/blob/main/file_system.md) which will help you in understanding the second part of the lab, where we handle vmcalls related to reading and writing of data to a disk.

## Part 1: Setup and Getting Started

You will need to use your laptop for this project. Because the lab computers do not have easy root access, and we are trying to write a hypervisor, it is easiest to use a class VM for a standardized project experience. 

For lab-0, you will use a virtual machine with the Debian Jessie operating system. Follow the instructions below for
1. Setting up a VM and other essentials
2. Running JOS code for project-1

You need to use Virtual Machine software: VMWare Fusion [here for students](https://my.vmware.com/web/vmware/evalcenter?p=fusion-player-personal) or [Virtual Box](https://www.virtualbox.org/). We **strongly recommend** using VirtualBox, as this is what the instructors use. We would not be able to help you with problems running on VMware Fusion. 

**Note**: You need to use Virtualbox 6.1. VirtualBox 6.0 does not have nested virtualization support needed for the lab.

We are providing the virtual machine in two formats. You can use either for the class. 
1. A zip file for a VirtualBox virtual machine. This has all the components required for the virtual machine to be run on Virtualbox. You might need to customize it to run correctly on your laptop. Link: https://utexas.box.com/s/nkwnzmqwnpo8m9jf1m4m82p351b4rb6o. This has the host-only networking adaptor setup, but you have to use VirtualBox to run this virtual machine.
2. An OVA file: https://utexas.box.com/s/evzdr3ov7y1r6cpy5wm1epn97p2v1mfq. You must setup a VM using this OVA file. You can use either VirtualBox or VMware Fusion. We are providing this OVA for compatibility, but it requires you to setup a lot of stuff that comes pre-configured on the VirtualBox. We strongly recommend using the VirtualBox VM. 

To successfully run JOS inside the VM, you need to ensure that Virtualization hardware support (VMX) is enabled for the virtual machine, and KVM is installed in the virtual machine. Both these steps are done in the VirtualBox, but you will have to configure it yourself when using the OVA. 

**Important**: You need to customize the networking on the virtual machine for your machine. Right now, it is configured to use a Bridged Adaptor connected to Vijay's Thunderbolt Ethernet. This should change based on your host machine to whatever network (wifi/ethernet) that you are using. You only need to change ``Adapter 1`` in the VM's networking settings. Either ``NAT`` or ``Bridged`` setting should allow you to get internet access in the VM.

#### Setting up networking in the Virtualbox VM

The VirtualBox VM we provide has two network adaptors. Adaptor 1 is for connecting the VM to the internet. It is a `bridged` adaptor. You should set this to either `NAT` or `bridged` depending upon your host networking. 

Adaptor 2 is used to connect the host and the VM. You need this to work to `ssh` into the VM from the host. It uses a `host-only` network adaptor. You need to configure Virtualbox to setup a host-only network (typically `vboxnet0`) and then connect it to the host-only adaptor used in the VM. See instructions [here](https://condor.depaul.edu/glancast/443class/docs/vbox_host-only_setup.html). 

#### Setting up a Virtual Machine and Other Essentials

1. If you are not using the VM we provide, you need to setup networking on the virtual machine so that you can communicate with your host machine. This will involve setting up the host networking and providing a static IP to your virtual machine. See [this](https://marcus.4christies.com/2019/01/how-to-create-a-virtualbox-vm-with-a-static-ip-and-internet-access/) article. You might need to setup a second host-only networking adaptor on the virtual machine if you are using the OVA. 
2.  Begin running VM. To log into the VM, you can use
`
username: osboxes
password: user
`

5.  Run `ip addr` to retrieve the IP address of the machine. This will be the static IP address you set in step 1. If you are using the VM we provided, it will be `192.168.56.101`
6.  Open a new terminal tab on your computer, and ssh into the machine. You can do this with `ssh -p 22 osboxes@IP_ADDRESS`
7.  You can locate into the project folder `/home/osboxes/cs360v-f21/project-1` now. It should be available on your VM, with the necessary libraries. 

#### Running JOS VMM

Compile the code using the command:
```
$ make clean
$ make
```
Please note that the compilation works with gcc version <= 5.0.0. The Makefile uses gcc 4.8.0, which is present in the gilligan lab machines. Please install gcc-4.8 if you don't have it installed already.

You can run the vmm from the shell by typing:
```
$ make run-vmm-nox
```
You should see something like this
```
kernel panic on CPU 0 at ../vmm/vmx.c:65: vmx_check_support not implemented

Welcome to the JOS kernel monitor!
Type 'help' for a list of commands.
K>
```
To exit JOS press ```Ctrl-A``` followed by ```X```. Press ``Ctrl`` and ``A`` at the same time, release, then press ``X``.

Next, we will start gdb. We will be using GDB a lot throughout these labs. It is an indispensible tool for systems programming and debugging. This lab will help introduce you to it. Here is a helpful reference sheet for [GDB commands](https://users.ece.utexas.edu/~adnan/gdb-refcard.pdf)

You need to use a **patched** version of GDB for the project. We have already set up gdb for you in the VM at `~/gdb_7.7/`. Please use this version of the GDB. You will get an error (`packet too long`) if you use the default GDB.

Here is a way to set up GDB if you are not using the VM: [GDB setup](https://github.com/vijay03/cs360v-f21/blob/main/tools.md). 

To start gdb, run
```
cd /home/osboxes/cs360v-f21/project-1
~/gdb_7.7/usr/bin/gdb
```
in the command prompt. If the gdb_7.7 directory is not already on the VM, see [here](https://github.com/vijay03/cs360v-f20/blob/master/tools.md#patched-gdb) for instructions on installing it.

Note: you get subtle errors if you use a different version of gdb or if you run it from a dir other than `project-1`. 

Normally, you would specify the executable, but because this is a VM, for this lab, you have to use REMOTE DEBUGGING via GDB. Run this command on the gdb prompt:
```
(gdb) target remote localhost:25000
```
It will appear like the command is hanging, but it is simply waiting for the process to start.

In order to run JOS in GDB, there are specialized make commands in order to attach GDB to the process. Run this on another terminal:

```
make run-vmm-nox-gdb
```
The terminal where you are running JOS with GDB will seem like its hanging. This is expected. It is waiting for input from GDB.

After this, you should see the following on the terminal running GDB:

```
warning: A handler for the OS ABI "GNU/Linux" is not built into this configuration
of GDB.  Attempting to continue with the default i8086 settings.

The target architecture is assumed to be i8086
[f000:fff0]    0xffff0:	ljmp   $0xf000,$0xe05b
0x0000fff0 in ?? ()
+ symbol-file obj/kern/kernel
Hardware assisted breakpoint 1 at 0x1000e5: file kern/bootstrap.S, line 147.
```

You can then proceed to continue the executable with c (continue) or stepi (executes next instruction)


## Part 2: Pre-lab Questions

To begin, we'd like you to get familar with using GDB. GDB is a great tool for debugging system level programs because it gives you the ability to see what is happening at a low level. 

First, place a breakpoint at `env_pop_tf(struct Trapframe *tf)` in `kern/env.c`

This function restores the register values in the Trapframe with the 'iret' instruction.

An IRET instruction returns from the OS to the application program which made the system call. The IRET also makes a change back to User Mode.

Now, when you continue execution with `c` in gdb, your new breakpoint will be hit. You can now examine the registers with `info registers`. 

Observe the register values, and note them down. You might want to take a look at this [blog post](https://arvindsraj.wordpress.com/2013/01/12/x86-registers-register-conventions-and-calling-conventions/) about registers. For more background on x86 assembly, check out Lecture [10](https://web.stanford.edu/class/archive/cs/cs107/cs107.1218/lectures/10/Lecture10.pdf) and following lectures in the [Stanford Computer Organization class](https://web.stanford.edu/class/cs107/).

1. Which register contains the return value of the function? What is the value you see? Is this an address or a constant value? 

2. Which register contains the next assembly instruction to execute? What is the value you see? Is this an address or a constant value? 

3. Using the answer from the previous question, what are the next 5 instructions that will be executed? What are the hex codes of those functions? (hint: see `display` in gdb)

As you may notice, the function calls a c function `__asm __volatile()`. The asm statement allows you to include assembly instructions directly within C code. The `volatile` keyword simply tells the assembler not to optimize this instruction away. 

4. Explain what the following assembly instructions are doing, line by line. 
```
push   %rbp

mov    %rsp,%rbp

push   %rbx

sub    $0x18,%rsp
```

5. Using the stepi functionality in GDB, which will execute one instruction at a time, what do the registers look like after the above instructions are executed?

<!-- 6. If you continue to step through the execution, you will hit this instruction:

```
movq 0, %rsp
```

What is this instruction doing? Why might this throw an error the next time ``rsp`` is used? GDB will warn about this, but you won't get an actual error when the program is run, because `rsp` is overwritten by the `POPA` instruction (overwrites all registers with values from the stack). 

Try removing the `POPA` instruction after this in `kern/env.c` and see what happens. -->

6. Notice that the first line of assembly in the `__asm__volatile()` call is `movq %0,%%rsp`. If you were to change this line to `movq $0,%%rsp` (notice the $), you would see an error in GDB the next time `rsp` is used. Why would this change introduce an error? 

That's it for the pre-lab! The next section will be on the coding section. 

Please include a .txt or PDF document of your answers with the codebase.  

## Part 3: Coding Exercise 

### Track number of runs for an env

NOTE: All Lab 0 hints are in the codebase `Hint, Lab 0`. It is important to visit each one, for they all indicate a place where you must make an edit. 

In JOS the terms "environment" and "process" are interchangeable - they roughly have the same meaning. We introduce the term "environment" instead of the traditional term "process" in order to stress the point that JOS environments do not provide the same semantics as UNIX processes, even though they are roughly comparable.

[This guide](https://github.com/vijay03/cs360v-f21/blob/main/environments.md), linked at the beginning of the project, provides an in depth introduction into environments. 

In this part of the project, we want to be able to keep track of number of times environment has run, as an important piece of metadata. 

We have added a new field to the struct declaration of `Env` called `env_runs` in order to track this information. Your task is to ensure `env_runs` is updated correctly.

Again, check all of the `Hint, Lab 0` places to update and use the `env_runs` variable!

### Fix implementation of envid2env() in kern/env.c

Throughout these Labs in project_1, you will have to use a helper function, envid2env, to retrieve the Env struct, that contains metadata about an environment. 

Right now, this function has a few bugs in it. 
1. If envid is zero, the function should return the current environment.
2. It incorrectly looks up the env in the envs array. 
3. It incorrectly fills the **env_store with a null value. 

Using env macros and information in inc/env.h and your knowledge of C references, fix these three bugs. 

## Hints

In all lab assignments in project-1, the functions you will be implementing might have hints on how to implement them as comments above. So please pay attention to the comments in the code.

## Grading Rubric

Total points: 20

6 Pre-lab questions: each 2 points (total of 12 points)
Coding questions: 3 points, 3 points, and 2 points (total of 8 points)

## Submission Details

Submit a zip of your files via Canvas. If you have changed the directory structure, add a README explaining where we can find your code. Add a text file or a PDF file explaining your answers to the pre-lab questions.

## Contact Details

Reach out to the TA in case of any difficulties. You can post a public question on Piazza: chances are, your fellow students have already seen it and can help you. If you want to share code with the TAs, use a private Piazza question.
