#line 2 "../user/icode.c"
#include <inc/lib.h>

#line 5 "../user/icode.c"
#ifdef VMM_GUEST
#define MOTD "/motd_guest"
#else
#define MOTD "/motd"
#endif
#line 13 "../user/icode.c"

void
umain(int argc, char **argv)
{
	int fd, n, r;
	char buf[512+1];

	binaryname = "icode";

	cprintf("icode startup\n");

	cprintf("icode: open /motd\n");
	if ((fd = open(MOTD, O_RDONLY)) < 0)
		panic("icode: open /motd: %e", fd);

	cprintf("icode: read /motd\n");
	while ((n = read(fd, buf, sizeof buf-1)) > 0) {
		cprintf("Writing MOTD\n");
		sys_cputs(buf, n);
	}

	cprintf("icode: close /motd\n");
	close(fd);

#line 38 "../user/icode.c"
	cprintf("icode: spawn /sbin/init\n");
	if ((r = spawnl("/sbin/init", "init", "initarg1", "initarg2", (char*)0)) < 0)
		panic("icode: spawn /sbin/init: %e", r);
#line 46 "../user/icode.c"
	cprintf("icode: exiting\n");
}
