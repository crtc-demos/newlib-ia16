	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strchr
strchr:
	pushw	%si
	movw	%sp,	%bx
	movw	4(%bx),	%si
	movb	6(%bx), %ah
.L1:
	lodsb
	cmp	%al,	%ah
	jz	.L2
	testb	%al,	%al
	jnz	.L1

	xorw	%ax,	%ax
	popw	%si
	ret
.L2:
	movw	%si,	%ax
	decw	%ax
	popw	%si
	ret
