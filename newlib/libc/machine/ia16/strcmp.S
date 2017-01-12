	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strcmp
strcmp:
	pushw	%si
	movw	%sp,	%bx
	movw	4(%bx),	%si
	movw	6(%bx), %bx
	decw	%bx
.L1:
	lodsb
	incw	%bx
	testb	%al,	%al
	jz	.L2
	cmpb	(%bx),	%al
	je	.L1
.L2:
	movb	(%bx),	%dl
	xorb	%dh,	%dh
	xorb	%ah,	%ah
	subw	%dx,	%ax
	popw	%si
	ret
