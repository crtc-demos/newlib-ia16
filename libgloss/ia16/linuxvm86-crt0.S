# Startup code for bare-metal systems.

	.arch i8086
	.code16

	.text
	.global _start
_start:
	xorw	%ax, %ax
	movw	__bss_start__, %si
	movw	__bss_end__, %cx
	subw	%si, %cx
	cld
	rep stosb

	pushw	%ax
	pushw	%ax
	pushw	%ax
	call	main
	addw	6, %sp

	xorw	%ax, %ax
	pushw	%ax
	call	exit

	// We should never reach here.
crash:	jmp	crash
