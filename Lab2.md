## Guest Bootloader and Kernel; Understanding vmlaunch and vmresume

In this lab assignment you will be completing the Guest bootloader and kernel code.
You will be implementing the memory manipulation code to copy the guest kernel and bootloader into the VM.
You will also familiarize yourself with the assembly code that helps launch/resume the JOS VM.

Before beginning this lab assignment, read [bootloader.md](https://github.com/vijay03/cs360v-f20/blob/master/bootloader.md).

### Mapping in the guest bootloader and kernel

In user/vmm.c we have provided the structure of the code to set up the guest and bootloader.
In this lab assignment, you will be implementing the functions `copy_guest_kern_gpa` that copies the guest kernel code into the guest physical address (gpa).
You will also implement the function `map_in_guest` that copies the bootloader into the guest.

Like any other user application in JOS, the vmm has the ability to open files, read pages, and map pages into other environments via IPC.
For supporting this, we have added a new system call `sys_ept_map`, which you must implement in kern/syscall.c.
The high-level difference between `sys_ept_map` and `sys_page_map` is whether the page is added using extended page tables or regular page tables.

Skim Chapter 28.2 of the [Intel manual](http://www.cs.utexas.edu/~vijay/cs378-f17/projects/64-ia-32-architectures-software-developer-vol-3c-part-3-manual.pdf)
to familiarize yourself with low-level EPT programming. Several helpful definitions have been provided in vmm/ept.h.

### Part-1 Pre-lab Questions 
1. What does it mean for there to be EPT support, vs. software driven virtualization? 
How do we know our VM has EPT support? 

2. ELF Headers:  
What is an ELF header? 
What does it do? 

3. Set a breakpoint at the function `load_icode()` in env.c
What do you notice about the Proghdr object? 
What kinds of metadata does the object have? 
What is this function doing? It is described in the function header, but try to put it in your own words. 

4. In our codebase, load_icode() does the work of loading the ELF binary image into the environment's user memory. Looking at this function, where does the memory for the Env get allocated? Where does the memory for the ELF header get allocated? Hint: you may have to check out what some constant values mean. 

5. The first function you implement in this project will have you check many errors, prior to the actual function logic. What are some of the reasons why we must do this in OS level code that the user never sees? 

Recommended files to look through before starting:

`inc/memlayout.h` describes and provides an ASCII image of the virtual memory map. 

`inc/mmu.h` describes how to parse information about a page from the address itself 

`vmm/ept.h` has function declarations that will be helpful throughout, and a macro for page table walks 

`lib/fd.c` has system calls that can be used to read files 

### Part-2 Coding Assignment

Implement `sys_ept_map()` in kern/syscall.c, as well as `ept_lookup_gpa()` and `ept_map_hva2gpa()` in vmm/ept.c.
Once this is complete, you should have complete support for nested paging.
The hints for implementing these functions are present as comments in the code.

Don't forget to error check! 

You should not implement `ept_page_insert()` as part of this lab; it will be implemented in a later lab.

At this point, you have enough host-level support function to map the guest bootloader and kernel into the guest VM.
For mapping the guest bootloader and kernel, you will need to read the kernel's ELF headers and copy the segments into the guest.

### Part-3 Coding Assignment

Implement `copy_guest_kern_gpa()` and `map_in_guest()` in user/vmm.c.

On a high level, in this section, each page of the kernel as well as the bootloader is mapped from the host
to the guest at particular physical addresses, and thus the kernel and the bootloader becomes available to the guest for when the guest is launched.

Here is a graphic of the workflow, with descriptions below: 
![Image of Workflow](https://github.com/abbykrish/cs360v-f21/blob/main/figures/workflow.jpg)

For the bootloader, we use map_in_guest directly, since the bootloader is only 512 bytes,
whereas the kernel's ELF header must be read by copy_guest_kern_gpa, which should then call map_in_guest for each segment.

The workflow (and hints) for this part is as follows:
1. `copy_guest_kern_gpa()` reads the ELF header from the kernel executable into the struct Elf. 
The kernel ELF contains multiple segments which must be copied from the host to the guest. This function is similar to the one observed in the prelab but has to call something other than memcpy() to map the memory because we are in the virtual guest. 

2. `map_in_guest()` breaks down each segment in number of pages, and calls `sys_ept_map()` for each page. You cannot pass in the page directly, but rather will have to use a TEMP variable. This is defined as a macro in `memlayout.h`

3. `sys_ept_map()` first walks the page table levels at the host (given the srcva), and then gets
the physical page corresponding to the virtual address srcva (i.e. it returns the struct PageInfo).
The corresponding virtual address of this page is then computed using `page2kva()`, which basically acts as the hva in the call to `ept_map_hva2gpa()`.

4. `ept_map_hva2gpa()` does a walk on the page table levels at the guest (given the gpa) using `ept_lookup_gpa()` and then gets a page table entry at level 0 corresponding to the gpa. This function then inserts the physical address corresponding to the hva, in the page table entry returned by `ept_lookup_gpa()`.

5. `ept_lookup_gpa()` does the walk on the page table hierarchy at the guest and returns the page table entry
corresponding to a gpa. It calculates the next index using the address and iterates until it reaches the page table entry at level 0 which points to the actual page.

Once this is complete, the kernel will attempt to run the guest, and will panic because asm_vmrun is incomplete. This error looks like:
```
kernel panic on CPU 0 at ../vmm/vmx.c:637: asm_vmrun is incomplete
```

### Part-4 vmlaunch and vmresume

### NOTE: this section is only required for in-person sections of the class. If you are in the online Master's program, see Piazza for the implementation for this section.

In this exercise, you will use the assembly code below to complete the `asm_vmrun()` that launches the VM.
The code below will help you use the vmwrite instruction to set the host stack pointer,
as well as the vmlaunch and vmresume instructions to start the VM.

In order to facilitate interaction between the guest and the JOS host kernel, we copy the guest register state into the environment's Trapframe structure.
Thus, you will also write assembly to copy the relevant guest registers to and from this trapframe struct.

Please remember, prior to starting this section, that your code from Lab 0 that implemented env-runs is correct and complete. Please refer to the TA if you did not recieve full points. 

Skim Chapter 26 of the [Intel manual](http://www.cs.utexas.edu/~vijay/cs378-f17/projects/64-ia-32-architectures-software-developer-vol-3c-part-3-manual.pdf)
to familiarize yourself with the vmlaunch and vmresume instructions. 
Remove the panic in the call to `asm_vmrun()`. There are instructions in the code of what lines you must add or fix. 

There are several places you need to add to in this function. All are labeled in the codebase with "Your code here". Do not modify any of the provided assembly code.

1. The first instruction can be found in the Intel manual, linked above. The instruction needs to set the VMCS rsp to the current top of the frame. 
2. The second instruction needs to check if vmlaunch (env-runs = 1) or vmresume (env-runs > 1) is needed, set the condition code appropriately for use below.
3. Write a set of instructions to load in guest general purpose registers from the trap frame. Be careful not to overwrite the condition code you set in the previous step.
4. Write a set of instructions to check the result of the condition flag you set in step 2, and execute either the vmlaunch or the vmresume. This will require making use of conditional jumps. 
5. Write a set of instructions to write general purpose guest registers and cr2 register from the guest to the trapframe. In this part, be careful that the total number of pushes and pops in the inline assembly here are equal; you may need to add pop(s) to make sure this holds.

Once this is complete, you should be able to run the VM until the guest attempts a vmcall instruction, which traps to the host kernel.
Because the host isn't handling traps from the guest yet, the VM will be terminated. You should see an error like:

```
Unhandled VMEXIT, aborting guest.
```

## Hints

In all lab assignments in project-1, the functions you will be implementing might have hints on how to implement them as comments above. So please pay attention to the comments in the code.

## FAQ

1. Is srcva a kernel virtual address? - No. The srcva that is passed into `sys_ept_map()` is not a kernel virtual address. If you want to get the kernel virtual address associated with a srcva, you can look up the PageInfo struct associated with srcva, then look up the kernel virtual address for that PageInfo struct.
2. How can I check if srcva is read-only? - Permissions are set on page table (or extended page table) entries by bitwise AND-ing the entry with some permission bits. There are constants defined in inc/mmu.h and inc/ept.h that correspond to different permissions settings for page table and extended page table entries respectively. You can look up the page table entry for srcva and check its permissions using bitwise operations on the permissions constants and the page table entry. This is also how to work with permissions on extended page table entries
3. How do I check if an address is page-aligned? - An address is page-aligned when it is a multiple of the page size. There are macros and constants defined in inc/mmu.h and inc/types.h that will help you check if an address is a multiple of the page size.
4. What are the possible values of `perm`? - The possible values of perm (for `sys_ept_map()`; other permissions may be set for other situations in the codebase) are defined in inc/ept.h.
5. How are `EPTE_ADDR` and `EPTE_FLAGS` used? - `EPTE_ADDR` and `EPTE_FLAGS` are used in the first few functions defined in vmm/ept.c, which are used to convert EPT entries to their corresponding physical or virtual addresses or to get the flags of an EPT entry. The `epte_addr()` and `epte_page_vaddr()` functions will be useful for this lab; you shouldn't have to deal with EPT entry flags here.
6. What does `ADDR_TO_IDX(pa, n)` do and what is the `n` parameter? - `ADDR_TO_IDX(pa, n)` returns the index corresponding to physical address pa in the nth level of the page table. You can get an idea of how it can be used by looking in the `test_ept_map()` function at the bottom of vmm/ept.c. We suggest using this macro over adapting existing page table walk logic; it will require a lot less code (and thus there is a lower likelihood of mistakes).

## Deadline

The deadline is **Sep 30** for on-campus students, and **Oct 24** for online masters students.

## Submission Details

Submit a zip of your files via Canvas. If you have changed the directory structure, add a README explaining where we can find your code. Add a text file or a PDF file explaining your answers to the pre-lab questions. Optionally, you can add a text file explaining how you modified the code. 

## Grading Rubric

Total: 20 points

Rubric for on-campus students:
- Each part 5 points, total of 4 parts. 

Rubric for Online Masters students:
- 5 points for prelab
- 8 points for part 2
- 7 points for part 3

## Contact Details

Reach out to the TA in case of any difficulties. You can post a public question on Piazza: chances are, your fellow students have already seen it and can help you. If you want to share code with the TAs, use a private Piazza question.

