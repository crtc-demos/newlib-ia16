/* Linker script for ELKS executables with combined data and text segment.  */

OUTPUT_FORMAT(binary)
ENTRY(_start)
MEMORY
  {
    bseglma (wx) : ORIGIN = 0x00100, LENGTH = 0x10000
    bsegvma (wx) : ORIGIN = 0x00100, LENGTH = 0x10000
  }

SECTIONS
  {
    /* Target text sections.  */
    .text : {
		__stext = .;
		*(.text) *(.text.*)
		__etext = .;

		/* Work around linker bug.  The linker will 4-byte align the VMA
		 * without being asked to do so, but won't do the same for the
		 * LMA.  Result: VMA out of sync with LMA.
		 * GNU ld version 2.17.50.0.12-3 20070128  */
		. = ALIGN(4);
		__etext_padded = .;
	} >bsegvma AT>bseglma
	__ltext = __etext - __stext;
	__ltext_padded = __etext_padded - __stext;

    /* Target data sections.  */
    .data : {
		__sdata = .;

		/* Build lists of constructors and destructors.  */
		___CTOR_LIST__ = .;
		SHORT ((___CTOR_END__ - ___CTOR_LIST__) / 2 - 2);
		*(.ctors) *(SORT_BY_NAME(.ctors.*))
		SHORT (0);
		___CTOR_END__ = .;
		___DTOR_LIST__ = .;
		SHORT ((___DTOR_END__ - ___DTOR_LIST__) / 2 - 2);
		*(.dtors) *(SORT_BY_NAME(.dtors.*))
		SHORT (0);
		___DTOR_END__ = .;

		*(.rodata) *(.rodata.*)
		*(.data) *(.data.*)
		__edata = .;

		__sbss = .;
		*(.bss) *(.bss.*)
		*(COMMON)
		__ebss = .;

		/* Minimum address allowed for sbrk() to use.  */
		_heap_end_minimum = .;
	} >bsegvma AT>bseglma
	__ldata = __edata - __sdata;
	__lbss  = __ebss  - __sbss;

    /DISCARD/ : { *(.*) }
  }
