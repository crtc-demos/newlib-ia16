/* Linker script for ELKS executables with combined data and text segment.  */

OUTPUT_FORMAT(binary)
ENTRY(_start)
INPUT(crtbegin.o crtend.o dos-com-crt0.o)
GROUP(-lc -lgcc -ldos-com -lm)

SECTIONS
  {
    . = 0x100;
    /* Target text sections.  */
    .text : {
		__stext = .;
		*(.startupA)
		*(.init)
		*(.startupB)
		*(.fini)
		*(.startupC)
		*(.text) *(.text.*)
		__etext = .;
	}
	__ltext = __etext - __stext;

    /* Target data sections.  */
    .data : {
		__sdata = .;

		/* Build lists of constructors and destructors.  */
		KEEP (*crtbegin*.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend*.o ) .ctors))
		KEEP (*(SORT(.ctors.*)))
		KEEP (*(.ctors))

		KEEP (*crtbegin*.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend*.o ) .dtors))
		KEEP (*(SORT(.dtors.*)))
		KEEP (*(.dtors))

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
                __heap_end_minimum = ALIGN(8);
    	}

	__ldata = __edata - __sdata;
	__lbss0 = __ebss - __sbss;
	__lbss1 = __lbss0 + 1;
	__lbss = __lbss1 / 2;

    ASSERT(. <= 0xfff8, "Error: too large for a .com file.")

    /DISCARD/ : { *(.*) }
  }
