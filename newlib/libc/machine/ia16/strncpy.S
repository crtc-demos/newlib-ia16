	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strncpy
strncpy:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	2(%bx), %di
	movw	4(%bx), %si
	movw	6(%bx), %cx
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	%di,	%bx
	jcxz	.L2
.L1:
	lodsb
	stosb
	testb	%al,	%al
	loopnz	.L1

	xorw	%ax,	%ax
	shrw	$1,	%cx
	rep	stosw
	adcw	%cx,	%cx
	rep	stosb
.L2:
	movw	%bx,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
