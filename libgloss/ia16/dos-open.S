	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_open
_open:
	movw	%sp,	%bx
	movw	2(%bx),	%dx
	movb	4(%bx),	%al
	andb	$3,	%al
	movb	$0x3d,	%ah
	int	$0x21
	jnc	.noerror
	movw	%ax,	errno
	movw	$-1,	%ax
.noerror:
	ret
