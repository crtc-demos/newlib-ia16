#include "elks-syscalls.h"

#define _SYSCALL0(NAME, RET) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME));

#define _SYSCALL1(NAME, RET, A1) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME), "b" (A1));

#define _SYSCALL2(NAME, RET, A1, A2) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME), "b" (A1), \
	"c" (A2));

#define _SYSCALL3(NAME, RET, A1, A2, A3) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME), "b" (A1), \
	"c" (A2), "d" (A3));

#define _SYSCALL4(NAME, RET, A1, A2, A3, A4) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME), "b" (A1), \
	"c" (A2), "d" (A3), "D" (A4));

#define _SYSCALL5(NAME, RET, A1, A2, A3, A4, A5) \
__asm__ __volatile__("int\t$0x80" : "=a" (RET) : "0" (__NR_##NAME), "b" (A1), \
	"c" (A2), "d" (A3), "D" (A5), "S" (A6));

extern int errno;

#define SYSCALL_RETVAL	\
  if (ret < 0)		\
    {			\
      errno = -ret;	\
      ret = -1;		\
    }			\
  return ret;		\

/* void func (void) */
#if defined(SYSCALL_sync)
#define SYSCALLvv(L,F,S) \
void L (void) \
{ int dummy;	\
  S (F, dummy);	\
}
SYSCALLvv (LABEL, FUNC, SYSCALL)
#endif

/* int func (void) */
#if defined(SYSCALL_fork) || defined(SYSCALL_vfork) || defined(SYSCALL_setsid)
#define SYSCALLiv(L,F,S) \
int L (void) \
{ int ret;	\
  S (F, ret);	\
  SYSCALL_RETVAL	\
}
SYSCALLiv (LABEL, FUNC, SYSCALL)
#endif

/* void func (int) */
#if defined(SYSCALL_exit)
#define SYSCALLvi(L,F,S) \
void L (int a1) \
{ int dummy;	\
  S (F, dummy, a1);	\
}
SYSCALLvi (LABEL, FUNC, SYSCALL)
#endif

/* int func (void *) */
#if defined(SYSCALL_unlink) || defined(SYSCALL_chdir) || defined(SYSCALL_brk) \
    || defined(SYSCALL_getpid)|| defined(SYSCALL_umount) || defined(SYSCALL_getuid) \
    || defined(SYSCALL_chroot) || defined(SYSCALL_rmdir) || defined(SYSCALL_pipe) \
    || defined(SYSCALL_knlvsn)
#define SYSCALLiV(L,F,S) \
int L (void *a1) \
{ int ret;	\
  S (F, ret, a1);	\
  SYSCALL_RETVAL	\
}
SYSCALLiV (LABEL, FUNC, SYSCALL)
#endif

/* int func (int) */
#if defined(SYSCALL_close) || defined(SYSCALL_setuid) || defined(SYSCALL_dup) \
    || defined(SYSCALL_setgid) || defined(SYSCALL_umask)

#define SYSCALLii(L,F,S) \
int L (int a1) \
{ int ret;	\
  S (F, ret, a1);	\
  SYSCALL_RETVAL	\
}
SYSCALLii (LABEL, FUNC, SYSCALL)
#endif

/* int func (void *, void *) */
#if defined(SYSCALL_link) || defined(SYSCALL_symlink) || defined(SYSCALL_stat) \
    || defined(SYSCALL_utime) || defined(SYSCALL_rename) || defined(SYSCALL_lstat) \
    || defined(SYSCAL_settimeofday) || defined(SYSCALL_gettimeofday) \
    || defined(SYSCALL_dlload)
#define SYSCALLiCV(L,F,S) \
int L (char *a1, void *a2) \
{ int ret;	\
  S (F, ret, a1, a2);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCV (LABEL, FUNC, SYSCALL)
#endif

/* int func (char *, int) */
#if defined(SYSCALL_chnod) || defined(SYSCALL_access) || defined(SYSCALL_mkdir)
#define SYSCALLiCi(L,F,S) \
int L (char *a1, int a2) \
{ int ret;	\
  S (F, ret, a1, a2);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCi (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, int) */
#if defined(SYSCALL_kill) || defined(SYSCALL_dup2) || defined(SYSCALL_listen)
#define SYSCALLiii(L,F,S) \
int L (int a1, int *a2) \
{ int ret;	\
  S (F, ret, a1, a2);	\
  SYSCALL_RETVAL	\
}
SYSCALLiii (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, void *) */
#if defined(SYSCALL_fstat) || defined(SYSCALL_signal)
#define SYSCALLiiV(L,F,S) \
int L (int a1, void *a2) \
{ int ret;	\
  S (F, ret, a1, a2);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiV (LABEL, FUNC, SYSCALL)
#endif

/* int func (char *, char *, char *) */
#if defined(SYSCALL_execve)
#define SYSCALLiCCC(L,F,S) \
int L (char *a1, char *a2, char *a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCCC (LABEL, FUNC, SYSCALL)
#endif

/* int func (char *, char *, int) */
#if defined(SYSCALL_readlink)
#define SYSCALLiCCi(L,F,S) \
int L (char *a1, char *a2, int a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCCi (LABEL, FUNC, SYSCALL)
#endif

/* int func (char *, int, int) */
#if defined(SYSCALL_open) || defined(SYSCALL_mknod) || defined(SYSCALL_chown)
#define SYSCALLiCii(L,F,S) \
int L (char *a1, int a2, int a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCii (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, void *, int) */
#if defined(SYSCALL_read) || defined(SYSCALL_write) || defined(SYSCALL_readdir) \
    || defined(SYSCALL_bind) || defined(SYSCALL_connect)
#define SYSCALLiiVi(L,F,S) \
int L (int a1, char *a2, int a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiVi (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, int, int) */
#if defined(SYSCALL_lseek) || defined(SYSCALL_reboot) || defined(SYSCALL_fchown) \
    || defined(SYSCALL_socket)
#define SYSCALLiiii(L,F,S) \
int L (int a1, int a2, int a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiii (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, int, void *) */
#if defined(SYSCALL_fcntl) || defined(SYSCALL_ioctl)
#define SYSCALLiiiV(L,F,S) \
int L (int a1, int a2, void *a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiiV (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, void *, void *) */
#if defined(SYSCALL_accept)
#define SYSCALLiiVV(L,F,S) \
int L (int a1, void *a2, void *a3) \
{ int ret;	\
  S (F, ret, a1, a2, a3);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiVV (LABEL, FUNC, SYSCALL)
#endif

/* int func(int, int *, int, void *) */
#if defined(SYSCALL_wait4)
#define SYSCALLiiIiV(L,F,S) \
int L (int a1, int *a2, int a3, void *a4) \
{ int ret;	\
  S (F, ret, a1, a2, a3, a4);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiIiV (LABEL, FUNC, SYSCALL)
#endif

/* int func (char *, char *, char *, int, void *) */
#if defined(SYSCALL__mount)
#define SYSCALLiCCCiV(L,F,S) \
int L (char *a1, char *a2, char *a3, int a4, void *a5) \
{ int ret;	\
  S (F, ret, a1, a2, a3, a4, a5);	\
  SYSCALL_RETVAL	\
}
SYSCALLiCCCiV (LABEL, FUNC, SYSCALL)
#endif

/* int func (int, void *, void *, void *, void *) */
#if defined(SYSCALL__mount)
#define SYSCALLiiVVVV(L,F,S) \
int L (int a1, void *a2, void *a3, void *a4, void *a5) \
{ int ret;	\
  S (F, ret, a1, a2, a3, a4, a5);	\
  SYSCALL_RETVAL	\
}
SYSCALLiiVVVV (LABEL, FUNC, SYSCALL)
#endif
