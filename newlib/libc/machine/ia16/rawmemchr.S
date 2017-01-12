	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		rawmemchr
rawmemchr:
	pushw	%di
	movw	%sp,	%bx
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	4(%bx),	%di
	movb	6(%bx),	%al
	movw	$-1,	%cx
	repne	scasb
	movw	%di,	%ax
	decw	%ax
	popw	%es
	popw	%di
	ret
