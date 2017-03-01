	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memcpy
memcpy:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	2(%bx),	%di
	movw	%di,	%ax
	movw	4(%bx),	%si
	movw	6(%bx),	%cx
	shrw	$1,	%cx
	rep	movsw
	adcw	%cx,	%cx
	rep	movsb
	popw	%es
	popw	%di
	popw	%si
	ret
