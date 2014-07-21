/* Linker script for ELKS executables with combined data and text segment.  */

OUTPUT_FORMAT(binary)
ENTRY(startup)
MEMORY
  {
    /* Place header VMA outside of program address space.  */
    hdrlma  (r)	 : ORIGIN = 0x00000, LENGTH = 32
    hdrvma  (r)  : ORIGIN = 0x10000, LENGTH = 32

    /* Account for the 32-byte header.  */
    bseglma (wx) : ORIGIN = 0x00020, LENGTH = 0x10000
    bsegvma (wx) : ORIGIN = 0x00000, LENGTH = 0x10000
  }

SECTIONS
  {
    /* There's no binutils configuration which directly supports the ELKS
       binary format, but's it's easy to create the necessary header.  */
    .hdr : {
		LONG (0x04100301);	/* Magic.  */
		LONG (32);		/* Header length.  */
		LONG (__ltext_padded);
		LONG (__ldata);
		LONG (__lbss);
		LONG (0);
		LONG (0);		/* chmem field.  */
		LONG (0);
	} >hdrvma AT>hdrlma

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
		__heap_end_minimum = .;
	} >bsegvma AT>bseglma
	__ldata = __edata - __sdata;
	__lbss  = __ebss  - __sbss;

    /DISCARD/ : { *(.*) }
  }
