	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memccpy
memccpy:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	2(%bx),	%di
	movw	4(%bx),	%si
	movb	6(%bx),	%ah
	movw	8(%bx),	%cx
	jcxz	.L2
.L1:
	lodsb
	stosb
	cmpb	%al,	%ah
	loopne	.L1
	jne	.L2
	movw	%di,	%ax
	decw	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
.L2:
	xorw	%ax,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
