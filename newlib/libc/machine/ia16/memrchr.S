	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memrchr
memrchr:
	pushw	%di
	movw	%sp,	%bx
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	4(%bx),	%di
	movb	6(%bx),	%al
	movw	8(%bx), %cx
	addw	%cx,	%di
	decw	%di
	std
	repne	scasb
	cld
	je	.L1
	xorw	%ax,	%ax
	popw	%es
	popw	%di
	ret
.L1:
	movw	%di,	%ax
	incw	%ax
	popw	%es
	popw	%di
	ret
