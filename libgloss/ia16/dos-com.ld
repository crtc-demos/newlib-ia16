/* Linker script for ELKS executables with combined data and text segment.  */

OUTPUT_FORMAT(binary)
ENTRY(_start)
STARTUP(dos-com-crt0.o)
GROUP(-lc -lgcc -ldos-com -lnosys -lm)

SECTIONS
  {
    . = 0x100;
    /* Target text sections.  */
    .text : {
		__stext = .;
		*(.text) *(.text.*)
		__etext = .;
	}
	__ltext = __etext - __stext;

    /* Target data sections.  */
    .data : {
		__sdata = .;

		/* Build lists of constructors and destructors.  */
		__CTOR_LIST__ = .;
		SHORT ((__CTOR_END__ - __CTOR_LIST__) / 2 - 2);
		*(.ctors) *(SORT_BY_NAME(.ctors.*))
		SHORT (0);
		__CTOR_END__ = .;
		__DTOR_LIST__ = .;
		SHORT ((__DTOR_END__ - __DTOR_LIST__) / 2 - 2);
		*(.dtors) *(SORT_BY_NAME(.dtors.*))
		SHORT (0);
		__DTOR_END__ = .;

		*(.rodata) *(.rodata.*)
		*(.data) *(.data.*)
		*(.gcc_except_table)
		__edata = .;
	}

    .bss (NOLOAD) : {
    	 	 __sbss = .;
                *(.bss) *(.bss.*)
                *(COMMON)
                __ebss = .;

                /* Minimum address allowed for sbrk() to use.  */
                __heap_end_minimum = .;
    	}

	__ldata = __edata - __sdata;
	__lbss  = __ebss  - __sbss;

    ASSERT(. <= 0xfff8, "Error: too large for a .com file.")

    /DISCARD/ : { *(.*) }
  }
