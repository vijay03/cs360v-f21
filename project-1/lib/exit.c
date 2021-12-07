#line 2 "../lib/exit.c"

#include <inc/lib.h>

void
exit(void)
{
#line 9 "../lib/exit.c"
	close_all();
#line 11 "../lib/exit.c"
	sys_env_destroy(0);
}

