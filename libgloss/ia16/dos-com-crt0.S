# Startup code for a DOS .com file.

	.arch i8086
	.code16

	.section .startupA
	.global _start
_start:
	xorw	%ax, %ax
	movw	$__sbss, %di
	movw	$__lbss, %cx
	cld
	rep stosw

	.section .startupB

	xorw	%ax, %ax
	pushw	%ax
	pushw	%ax
	pushw	%ax
	call	main
	addw	$6, %sp

	pushw	%ax
	call	exit

	.global _exit
_exit:

	.section .startupC

	movw	%sp, %bp
	movw	2(%bp), %ax
	movb	$0x4c, %ah
	int	$0x21
