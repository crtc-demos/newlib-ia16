	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strlen
strlen:
	pushw	%si
	movw	%sp,	%bx
	movw	4(%bx),	%si
	movw	%si,	%bx
.L1:
	lodsb
	cmpb	$0,	%al
	jne	.L1

	movw	%si,	%ax
	subw	%bx,	%ax
	decw	%ax
	popw	%si
	ret
