	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memcmp
memcmp:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	2(%bx),	%si
	movw	4(%bx),	%di
	movw	6(%bx), %cx
	movw	%cx,	%dx
	shrw	$1,	%cx
	repe	cmpsw
	jne	.L1
	testb	$1,	%dl
	jz	.L2
	cmpsb
	jne	.L3
.L2:
	xorw	%ax,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
.L3:
	movb	-1(%si),	%al
	xorb	%ah,	%ah
	movb	-1(%di),	%dl
	xorb	%dh,	%dh
	subw	%dx,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
.L1:
	movb	-2(%si),	%ax
	movb	-2(%di),	%dx
	cmpb	%al,	%dl
	je	.L4
	xorb	%ah,	%ah
	xorb	%dh,	%dh
	subw	%dx,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
.L4:
	movb	%ah,	%al
	movb	%dh,	%dl
	xorb	%ah,	%ah
	xorb	%dh,	%dh
	subw	%dx,	%ax
	popw	%es
	popw	%di
	popw	%si
	ret
