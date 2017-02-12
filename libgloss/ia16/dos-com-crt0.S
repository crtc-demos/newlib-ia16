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
	rep	stosw

	.section .startupB

	# Find length of environment + progname
	movw	0x2c,	%es
	xorw	%di,	%di
	cld
	xorw	%ax,	%ax
.Lfind_env_end:
	movw	$-1,	%cx
	repne	scasb
	cmpw	$-2,	%cx
	jne	.Lfind_env_end
	incw	%di
	incw	%di
	repne	scasb

	# Copy environment + progname
	pushw	%es
	popw	%ds
	pushw	%ss
	popw	%es
	incw	%di
	andw 	$-2,	%di
	subw	%di,	%sp
	movw	%di,	%cx
	movw	%sp,	%di
	xorw	%si,	%si
	rep	movsb

	# Push pointers to environment + progname
	pushw	%es
	popw	%ds
	movw	%sp,	%di
	pushw	%ax		# envp ends with null pointer
.Lpush_env_pointers:
	pushw	%di
	movw	$-1,	%cx
	repne	scasb
	cmpw	$-2,	%cx
	jne	.Lpush_env_pointers
	popw	%cx		# don't include the final empty string
	movw	%sp,	%bp	# bp is envp
	pushw	%ax		# argv[argc] = null
	lea	2(%di),	%ax
	pushw	%ax		# argb[0] will be first after reversal
	movw	%sp,	%dx	# dx points to last item of argv

	# Parse command tail and push argument pointers
	xorw	%bx,	%bx	# argc
	movw	$0x81,	%si
	movw	%si,	%di
	movw	$1,	%cx

.Lspace:
	movw	%di,	%bx
	lodsb
	cmpb	$' ',	%al
	je	.Lspace
	cmpb	$'\"',	%al
	je	.Linside
	cmpb	$13,	%al
	je	.Lfinish
.Loutside_check_backslash:
	cmpb	$'\\',	%al
	je	.Loutside_backslash
.Loutside_other:
	stosb
.Loutside:
	lodsb
	cmpb	$' ',	%al
	je	.Lend_argument
	cmpb	$'\"',	%al
	je	.Loutside_quote
	cmpb	$13,	%al
	jne	.Loutside_check_backslash
.Largument_finish:
	movb	$0,	%al
	stosb
	pushw	%bx
	incw	%cx
.Lfinish:
	movw	%sp,	%si
	movw	%sp,	%di
	movw	%dx,	%bx
	movw	%cx,	%dx
	shrw	$1,	%cx
	jcxz	.Lno_reverse
.Ldo_reverse:
	lodsw
	xchgw	(%bx),	%ax
	stosw
	decw	%bx
	decw	%bx
	loop	.Ldo_reverse
.Lno_reverse:
	movw	%sp,	%ax
	pushw	%bp		# envp
	pushw	%ax		# argp
	pushw	%dx		# argc
	call	main
	addw	$6,	%sp
	pushw	%ax
	call	exit

.Linside_backslash_other:
	movb	$'\\',	(%di)
	incw	%di
.Linside_other:
	stosb
.Linside:
	lodsb
	cmpb	$'\"',	%al
	je	.Lend_argument
	cmpb	$13,	%al
	je	.Largument_finish
	cmpb	$'\\',	%al
	jne	.Linside_other
.Linside_backslash:
	lodsb
	cmpb	$'\"',	%al
	je	.Linside_backslash_quote
	cmpb	$13,	%al
	je	.Lbackslash_finish
	cmpb	$'\\',	%al
	jne	.Linside_backslash_other
.Linside_backslash_backslash:
	movb	$'\\',	%al
	stosb
	jmp	.Linside_backslash

.Loutside_backslash_backslash:
	movb	$'\\',	%al
	stosb
.Loutside_backslash:
	lodsb
	cmpb	$' ',	%al
	je	.Loutside_backslash_space
	cmpb	$'\"',	%al
	je	.Loutside_backslash_quote
	cmpb	$13,	%al
	je	.Lbackslash_finish
	cmpb	$'\\',	%al
	je	.Loutside_backslash_backslash
.Loutside_backslash_other:
	movb	$'\\',	(%di)
	incw	%di
	jmp	.Loutside_other

.Loutside_backslash_space:
	movb	$'\\',	(%di)
	incw	%di
.Lend_argument:
	movb	$0,	%al
	stosb
	pushw	%bx
	incw	%cx
	jmp	.Lspace

.Loutside_quote:
	mov	$0,	%al
	stosb
	pushw	%bx
	incw	%cx
	movw	%di,	%bx
	jmp	.Linside

.Lbackslash_finish:
	movb	$'\\',	%al
	stosb
	jmp	.Largument_finish

.Linside_backslash_quote:
	movb	$'\"',	%al
	jmp	.Linside_other

.Loutside_backslash_quote:
	movb	$'\"',	%al
	jmp	.Loutside_other


	.global _exit
_exit:

	.section .startupC

	movw	%sp,	%bp
	movw	2(%bp),	%ax
	movb	$0x4c,	%ah
	int	$0x21
