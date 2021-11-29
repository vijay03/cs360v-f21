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
- How does Firecracker simplify the virtual machine monitor?
- Describe how a lambda function is executed inside AWS, and Firecracker's place in that architecture 

Unikernels
- What is the main idea behind a unikernel?
- In terms of generality, performance, and isolation, how does a unikernel compare to VMs and containers?

Serverless
- What is the main idea behind serverless functions?
- Why do serverless functions make sense from the service provider's perspective?
- What kind of applications are a good fit for the serverless paradigm? What kind of applications are a bad fit?
- What is the main limitation when writing a serverless function?
- What is an example for something that triggers the execution of a serverless function?
- What is the cold start problem with serverless?
- What is one way to deal with the cold start problem?
- Can serverless functions communicate with each other?

gg
- What is the main idea behind gg?
- What are applications that gg is not good for?
- What is a thunk?
- How does gg ensure that communication between the user and the executing serverless functions is low?

SAND
- How does SAND achieve isolation between i) different serverless functions ii) different users?
- How does the Hierarchical Message Queueing in SAND reduce latency for serverless functions?

Storage Functions
- What is the main idea behind storage functions?
- How does Shredder achieve isolation among storage functions?
