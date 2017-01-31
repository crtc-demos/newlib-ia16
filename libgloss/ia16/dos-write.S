	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_write
_write:
	movw	%sp,	%bx
	movw	4(%bx),	%dx
	movw	6(%bx),	%cx
	movw	2(%bx),	%bx
	movb	$0x40,	%ah
	int	$0x21
	jnc	.noerror
	movw	%ax,	errno
	movw	$-1,	%ax
.noerror:
	ret
