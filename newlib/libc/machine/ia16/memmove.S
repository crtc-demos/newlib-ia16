	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		memmove
memmove:
	movw	%sp,	%bx
	pushw	%si
	pushw	%di
	pushw	%es
	movw	%ds,	%ax
	movw	%ax,	%es
	movw	2(%bx),	%di
	movw	4(%bx),	%si
	movw	6(%bx), %cx
	movw	%di,	%ax
	cmpw	%di,	%si
	ja	.L1
	# dest > src => copy backwards
	addw	%cx,	%si
	addw	%cx,	%di
	decw	%di
	std
	cmpw	%si,	%di
	jne	.L2
	# dest == src + 1 => copy backwards a byte at a time
	decw	%si
	rep	movsb
	cld
	popw	%es
	popw	%di
	popw	%si
	ret
.L2:
	# dest > src + 1 => copy backwards two bytes at a time
	decw	%di
	decw	%si
	decw	%si
	shrw	$1,	%cx
	rep	movsw
	jnc	.L3
	incw	%si
	incw	%di
	movsb
.L3:
	cld
	popw	%es
	popw	%di
	popw	%si
	ret
.L1:
	# dest < src => copy forwards
	incw	%di
	cmpw	%si,	%di
	jne	.L4
	# dest == src - 1 => copy forwards a byte at a time
	decw	%di
	rep	movsb
	popw	%es
	popw	%di
	popw	%si
	ret
.L4:
	# dest < src - 1 => copy forwards two bytes at a time
	decw	%di
	shrw	$1,	%cx
	rep	movsw
	adcw	%cx,	%cx
	rep	movsb
	popw	%es
	popw	%di
	popw	%si
	ret
