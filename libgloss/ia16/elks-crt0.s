# Startup code for ELKS systems.

	.arch	i8086
	.code16

# We're started with a stack that looks like this:
#	0
#	envp[n-1]
#	...
#	envp[0]
#	0
#	argv[argc-1]
#	...
#	argv[0]
#	argc

	.text
	.global		startup
startup:
	popw	%di		# Get argc.
	movw	%sp, %bx	# Get argv.
	leaw	(%bx,%di),%bp
	leaw	2(%bp,%di),%cx	# Envp = %bx + %di + %di + 2.
	pushw	%cx
	pushw	%bx
	pushw	%di
	call	_main
	pushw	%ax
	call	_exit
