	.arch i8086,jumps
	.code16
	.att_syntax prefix

# Many of the fields of struct stat are not applicable for DOS, or are complex
# to compute. Newlib's makebuf uses fstat to validate file descriptors, so we
# should do that at least. For now we'll just do the "Get Device Information"
# IOCTL call and fill in the fields we can get from that.

	.section	".text"
	.global		_fstat
_fstat:
	pushw	%bp
	movw	%sp,	%bp
	movw	4(%bp),	%bx
	movw	$0x4400,	%ax
	int	$0x21
	jc	.error
	movw	$020777,	%ax  # character device
	testb	$0x80,	%dl
	jnz	.device
	movw	$0100777,	%ax  # regular file
.device:
	movw	6(%bp),	%bx
	movw	%ax,	4(%bx)  # st_mode
	andw	$0x3f,	%dx
	movw	%dx,	(%bx)  # st_dev
	xorw	%ax,	%ax
	popw	%bp
	ret
.error:
	movw	%ax,	errno
	movw	$-1,	%ax
	popw	%bp
	ret
