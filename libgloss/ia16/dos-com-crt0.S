# Startup code for a DOS .com file.

	.arch i8086
	.code16

	.text
	.global _start
_start:
	xorw	%ax, %ax
	movw	$__sbss, %di
	movw	$__lbss, %cx
	cld
	rep stosb

	pushw	%ax
	pushw	%ax
	pushw	%ax
	call	main
	addw	$6, %sp

	pushw	%ax
	call	exit

	// We should never reach here.
crash:	jmp	crash

	.global _exit
_exit:
	movw	%sp, %bp
	movw	2(%bp), %ax
	movb	$0x4c, %ah
	int	$0x21
	jmp	crash
