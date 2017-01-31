	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_read
_read:
	movw	%sp,	%bx
	movw	4(%bx),	%dx
	movw	6(%bx),	%cx
	movw	2(%bx),	%bx
	movb	$0x3f,	%ah
	int	$0x21
	jnc	.noerror
	movw	%ax,	errno
	movw	$-1,	%ax
.noerror:
	ret
