	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_rename
_rename:
	pushw	%es
	pushw	%di
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	%sp,	%bx
	movw	6(%bx),	%dx
	movw	8(%bx),	%di
	movb	$0x56,	%ah
	int	$0x21
	jc	.error
	xorw	%ax,	%ax
	popw	%di
	popw	%es
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	popw	%di
	popw	%es
	ret
