	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_close
_close:
	movw	%sp,	%bx
	movw	2(%bx),	%bx
	movb	$0x3e,	%ah
	int	$0x21
	jc	.error
	xorw	%ax,	%ax
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	ret
