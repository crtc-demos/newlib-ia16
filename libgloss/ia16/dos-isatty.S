	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		_isatty
_isatty:
	movw	%sp,	%bx
	movw	2(%bx),	%bx
	movw	$0x4400,	%ax
	jc	.error
	movw	$0x112,	%ax	# ENOTTY
	testb	$0x80,	%dl
	jz	.error
	movw	$1,	%ax
	ret
.error:
	movw	%ax,	errno
	xorw	%ax,	%ax
	ret
