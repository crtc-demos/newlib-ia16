/^#/		{ next; }
$2 ~ /^\+/	{ print "#define __NR_" $1 " " 0 + $2;
		  print "#define __NRargs_" $1 " " $3;
		  print "#define __SYSCALL_for_" $1, " _SYSCALL" $3 }
