Review
======

*This is review for the second half of the semester, for the online masters class following the schedule [here](https://github.com/vijay03/cs360v-f20/blob/master/schedule.md)*.
*See [here](https://github.com/vijay03/cs360v-f21/blob/main/review-questions.md) for review questions about first half of the semeester.*

Containers
- What motivated the creation of containers?
- What are the underlying technologies that make up a container?
- What is the purpose of kernel namespaces in a container? 
- What is the purpose of cgroups in a container? 
- What would happen if containers did not use AUFS? 
- What would be the problem with running each container in its own virtual machine?
- How does chroot work?
- How is a container different from a FreeBSD jail?
- Can namespaces exist indepdent of containers? 
- Can a container be associated with multiple namespaces?
- Can different containers have processes with the same process ID? If so, how?
- Why do containers need capabilities? 

Container orchestration frameworks
- What differentiates a pod from a container?
- What does Kubernetes provide for a user over manually deploying containers?
- How would two containers communicate with each other? What changes if there are both within the same pod? 

LightVM
- How does LightVM startup time compare to that of containers?
- What are the main techniques used by LightVM to reduce VM startup time? 
- Do you think the techniques used in LightVM are portable to VMware ESX Server or Virtualbox? Why or why not?
- How does a LightVM virtual machine compare with a unikernel in terms of generality, performance, and isolation?
- How does Tinyx work in LightVM?

Cntr + Slacker
- What is the main idea behind Cntr?
- What is the main idea behind Slacker?

SCONE
- What is the main idea behind Intel SGX?
- What are the limitations of execution inside an enclave?
- What would the drawback of just running a container inside an enclave? Think about both the performance and the size of the Trusted Computing Base?
- What is the SCONE architecture?
- SCONE implements its own threading -- what is the motivation behind this?

Firecracker


Unikernels

Serverless

gg

SAND

Shredder

