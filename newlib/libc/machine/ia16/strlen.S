	.arch i8086,jumps
	.code16
	.att_syntax prefix

	.section	".text"
	.global		strlen
strlen:
	pushw   %di
	movw    %sp,    %bx
	pushw   %es
	movw    %ds,    %ax
	movw    %ax,    %es
	movw    4(%bx), %di
	movw	%di,	%bx
	xorb	%ax,	%ax
	movw    $-1,    %cx
	repne   scasb
	movw    %di,    %ax
	subw	%bx,	%ax
	decw    %ax
	popw    %es
	popw    %di
	ret
