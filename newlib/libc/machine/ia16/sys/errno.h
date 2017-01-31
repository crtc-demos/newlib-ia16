/* This file is to be kept in sync with newlib/libc/include/sys/errno.h
   on which it is based, except values used or returned by syscalls must
   be those of DOS.  */

/* errno is not a global variable, because that would make using it
   non-reentrant.  Instead, its address is returned by the function
   __errno.  */

#ifndef _SYS_ERRNO_H_
#ifdef __cplusplus
extern "C" {
#endif
#define _SYS_ERRNO_H_

#include <sys/reent.h>

#ifndef _REENT_ONLY
#define errno (*__errno())
extern int *__errno _PARAMS ((void));
#endif

/* Please don't use these variables directly.
   Use strerror instead. */
extern _CONST char * _CONST _sys_errlist[];
extern int _sys_nerr;

#define __errno_r(ptr) ((ptr)->_errno)

/* Only define entries where the DOS error corresponds closely to a POSIX one.
   If we define our own macros for the other DOS errors they might collide
   with identifiers in the user program.
   Use of a POSIX error macro that doesn't happen in DOS should yield an error
   in order to make it easier to find code that isn't portable to DOS.  */

#define ENOSYS		 1	/* Invalid function */
#define ENOENT		 2	/* File not found */
  /*			 3	   Path not found */
#define ENFILE		 4	/* Too many open files */
#define EACCES		 5	/* Access denied */
#define EBADF		 6	/* Invalid handle */
  /*			 7	   Arena trashed */
#define ENOMEM		 8	/* Not enough memory */
  /*			 9	   Invalid block */
  /*			10	   Bad environment */
  /*			11	   Bad format */
  /*			12	   Invalid access */
  /*			13	   Invalid data */
  /*			14	   (unused) */
  /*			15	   Invalid drive */
  /*			16	   Current directory */
  /*			17	   Not same device */
  /*			18	   No more files */

/* Non-DOS errors */

#define EPERM		0x100	/* Not owner */
#define ESRCH		0x101	/* No such process */
#define EINTR		0x102	/* Interrupted system call */
#define EIO		0x103	/* I/O error */
#define ENXIO		0x104	/* No such device or address */
#define E2BIG		0x105	/* Arg list too long */
#define ENOEXEC		0x106	/* Exec format error */
#define ECHILD		0x107	/* No children */
#define EAGAIN		0x108	/* No more processes */
#define EFAULT		0x109	/* Bad address */
#define EBUSY		0x10a	/* Device or resource busy */
#define EEXIST		0x10b	/* File exists */
#define EXDEV		0x10c	/* Cross-device link */
#define ENODEV		0x10d	/* No such device */
#define ENOTDIR		0x10e	/* Not a directory */
#define EISDIR		0x10f	/* Is a directory */
#define EINVAL		0x110	/* Invalid argument */
#define EMFILE		0x111	/* File descriptor value too large */
#define ENOTTY		0x112	/* Not a character device */
#define EFBIG		0x113	/* File too large */
#define ENOSPC		0x114	/* No space left on device */
#define ESPIPE		0x115	/* Illegal seek */
#define EROFS		0x116	/* Read-only file system */
#define EMLINK		0x117	/* Too many links */
#define EPIPE		0x118	/* Broken pipe */
#define EDOM		0x119	/* Mathematics argument out of domain of function */
#define ERANGE		0x11a	/* Result too large */
#define ENOMSG		0x11b	/* No message of desired type */
#define EDEADLK		0x11c	/* Deadlock */
#define ENOLCK		0x11d	/* No lock */
#define EFTYPE		0x11e	/* Inappropriate file type or format */
#define ENOTEMPTY	0x11f	/* Directory not empty */
#define ENAMETOOLONG	0x120	/* File or path name too long */
#define ELOOP		0x121	/* Too many symbolic links */
#define EOPNOTSUPP	0x122	/* Operation not supported on socket */
#define ECONNRESET	0x123	/* Connection reset by peer */
#define ENOBUFS		0x124	/* No buffer space available */
#define EAFNOSUPPORT	0x125	/* Address family not supported by protocol family */
#define EPROTOTYPE	0x126	/* Protocol wrong type for socket */
#define ENOTSOCK	0x127	/* Socket operation on non-socket */
#define ENOPROTOOPT	0x128	/* Protocol not available */
#define ECONNREFUSED	0x129	/* Connection refused */
#define EADDRINUSE	0x12a	/* Address already in use */
#define ECONNABORTED	0x12b	/* Software caused connection abort */
#define ENETUNREACH	0x12c	/* Network is unreachable */
#define ENETDOWN	0x12d	/* Network interface is not configured */
#define ETIMEDOUT	0x12e	/* Connection timed out */
#define EADDRNOTAVAIL	0x12f	/* Address not available */
#define EHOSTUNREACH	0x130	/* Host is unreachable */
#define EINPROGRESS	0x131	/* Connection already in progress */
#define EALREADY	0x132	/* Socket already connected */
#define EDESTADDRREQ	0x133	/* Destination address required */
#define EMSGSIZE	0x134	/* Message too long */
#define EPROTONOSUPPORT	0x135	/* Unknown protocol */
#define EADDRNOTAVAIL	0x136	/* Address not available */
#define ENETRESET	0x137	/* Connection aborted by network */
#define EISCONN		0x138	/* Socket is already connected */
#define ENOTCONN	0x139	/* Socket is not connected */
#define EILSEQ		0x13a	/* Illegal byte sequence */
#define EOVERFLOW	0x13b	/* Value too large for defined data type */
#define EWOULDBLOCK	EAGAIN	/* Operation would block */

#ifdef __cplusplus
}
#endif
#endif /* _SYS_ERRNO_H */
