	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_rmdir
_rmdir:
	movw	%sp,	%bx
	movw	2(%bx),	%dx
	movb	$0x3a,	%ah
	int	$0x21
	jc	.error
	xorw	%ax,	%ax
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	ret
