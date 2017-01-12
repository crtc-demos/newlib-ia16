	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memset
memset:
	movw	%sp,	%bx
	pushw	%di
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	2(%bx),	%di
	movb	4(%bx),	%al
	movw	6(%bx),	%cx
	movb	%al,	%ah
	shrw	$1,	%cx
	rep	stosw
	jnc	.L1
	stosb
.L1:
	movw	2(%bx),	%ax
	popw	%es
	popw	%di
	ret
