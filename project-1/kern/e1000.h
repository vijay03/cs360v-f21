#line 2 "../kern/e1000.h"
#ifndef JOS_KERN_E1000_H
#define JOS_KERN_E1000_H
#line 5 "../kern/e1000.h"

#include <kern/pci.h>

int e1000_attach(struct pci_func *pcif);
int e1000_transmit(const char *buf, unsigned int len);
int e1000_receive(char *buf, unsigned int len);

#line 13 "../kern/e1000.h"

#endif	// JOS_KERN_E1000_H
