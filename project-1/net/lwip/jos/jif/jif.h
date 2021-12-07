#line 2 "../net/lwip/jos/jif/jif.h"
#include <lwip/netif.h>

void	jif_input(struct netif *netif, void *va);
err_t	jif_init(struct netif *netif);
