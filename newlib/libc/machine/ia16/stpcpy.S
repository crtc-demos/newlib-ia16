	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		stpcpy
stpcpy:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	2(%bx), %di
	movw	4(%bx), %si
	movw	%ds,	%ax
	movw	%ax,	%es
.L1:
	lodsb
	stosb
	testb	%al,	%al
	jnz	.L1

	movw	%di,	%ax
	decw	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
