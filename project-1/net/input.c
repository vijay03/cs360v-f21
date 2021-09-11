#line 2 "../net/input.c"
#include "ns.h"

extern union Nsipc nsipcbuf;

    void
input(envid_t ns_envid)
{
    binaryname = "ns_input";
#line 11 "../net/input.c"
    while (1) {
        int r;
        if ((r = sys_page_alloc(0, &nsipcbuf, PTE_P|PTE_U|PTE_W)) < 0)
            panic("sys_page_alloc: %e", r);
        r = sys_net_receive(nsipcbuf.pkt.jp_data, 1518);
        if (r == 0) {
            sys_yield();
        } else if (r < 0) {
            cprintf("Failed to receive packet: %e\n", r);
        } else if (r > 0) {
            nsipcbuf.pkt.jp_len = r;
            ipc_send(ns_envid, NSREQ_INPUT, &nsipcbuf, PTE_U|PTE_P);
        }
    }
#line 26 "../net/input.c"

    // LAB 6: Your code here:
    // 	- read a packet from the device driver
    //	- send it to the network server
    // Hint: When you IPC a page to the network server, it will be
    // reading from it for a while, so don't immediately receive
    // another packet in to the same physical page.
}
