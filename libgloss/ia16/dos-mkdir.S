	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_mkdir
_mkdir:
	movw	%sp,	%bx
	movw	2(%bx),	%dx
	movb	$0x39,	%ah
	int	$0x21
	jc	.error
	xorw	%ax,	%ax
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	ret
