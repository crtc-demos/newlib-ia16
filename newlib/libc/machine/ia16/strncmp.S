	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strncmp
strncmp:
	pushw	%si
	movw	%sp,	%bx
	movw	4(%bx),	%si
	movw	8(%bx), %cx
	movw	6(%bx),	%bx
	jcxz	.L3
	decw	%bx
.L1:
	lodsb
	incw	%bx
	testb	%al,	%al
	jz	.L2
	cmpb	(%bx),	%al
	loope	.L1
.L2:
	movb	(%bx),	%dl
	xorb	%dh,	%dh
	xorb	%ah,	%ah
	subw	%dx,	%ax
	popw	%si
	ret
.L3:
	xorw	%ax,	%ax
	popw	%si
	ret
