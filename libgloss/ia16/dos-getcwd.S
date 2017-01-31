	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_getcwd
_getcwd:
	pushw	%si
	movw	%sp,	%bx
	cmpw	$64,	6(%bx)
	movw	$0x101,	%ax  # ERANGE
	jl	.error
	movw	4(%bx),	%si
	movb	$0,	%dl
	movb	$0x47,	%ah
	int	$0x21
	jc	.error
	movw	%si,	%ax
	popw	%si
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	popw	%si
	ret
