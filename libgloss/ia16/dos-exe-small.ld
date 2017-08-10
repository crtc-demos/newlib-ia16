/* Linker script for DOS executables with separate data and text segments.
   Partly derived from elks-separate.ld .  */

OUTPUT_FORMAT(binary)
ENTRY(_start)
INPUT(crtbegin.o crtend.o dos-exe-small-crt0.o)
GROUP(-lc -lgcc -ldos-exe-small -lm)

MEMORY
  {
    hdrlma  (r)  : ORIGIN = 0x00000, LENGTH = 32
    hdrvma  (r)  : ORIGIN = 0x00000, LENGTH = 32

    /* Account for the 32-byte header.  */
    bseglma (wx) : ORIGIN = 0x00020, LENGTH = 0x20000
    csegvma (wx) : ORIGIN = 0x00020, LENGTH = 0x10000
    dsegvma (wx) : ORIGIN = 0x00020, LENGTH = 0x10000
  }

SECTIONS
  {
    /* Fabricate a .exe header here.  Although libbfd does have an
       "i386msdos" back-end which produces an "MZ" exe header, it cannot do
       certain things (yet).  In particular, we would like to use the .exe
       header to point %ss to the separate data segment right at startup.  */
    .hdr : {
		/* Signature.  */
		SHORT (0x5a4d)
		/* Bytes in last 512-byte page.  */
		SHORT ((LOADADDR (.data) + SIZEOF (.data)) % 512)
		/* Total number of 512-byte pages.  */
		SHORT ((LOADADDR (.data) + SIZEOF (.data) + 511) / 512)
		/* Relocation entries.  */
		SHORT (0)
		/* Header size in paragraphs.  */
		SHORT (2)
		/* Minimum extra paragraphs.  */
		SHORT ((0x10000 - SIZEOF (.data) - ADDR (.data)) / 16)
		/* Maximum extra paragraphs.  Instead of setting this to
		   0xffff so that the program hogs up all remaining
		   conventional memory, just let the program have memory up
		   to the end of the data segment, and ask for more memory
		   from DOS if it really needs it.  */
		SHORT ((0x10000 - SIZEOF (.data) - ADDR (.data)) / 16)
		/* Initial %ss.  */
		SHORT (LOADADDR (.data) / 16 - ADDR (.data) / 16
		    + 0x10000 - ORIGIN (bseglma) / 16)
		/* Initial %sp.  Let it wrap around from 0.  */
		SHORT (0)
		/* Checksum (unused).  */
		SHORT (0)
		/* Initial %cs:%ip.  */
		SHORT (_start)
		SHORT (LOADADDR (.text) / 16 - ADDR (.text) / 16
		    + 0x10000 - ORIGIN (bseglma) / 16)
		/* Relocation table offset.  */
		SHORT (0x1c)
		/* Overlay number.  */
		SHORT (0)
    } >hdrvma AT>hdrlma

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

		/* Make the data segment start on a paragraph boundary.  */
		. = ALIGN (16);
		__etext_padded = .;

		ASSERT(. <= 0x10000,
		    "Error: too large for a small-model .exe file.");

	} >csegvma AT >bseglma
	__ltext = __etext - __stext;
	__ltext_padded = __etext_padded - __stext;

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

    	 	 __sbss = .;
                *(.bss) *(.bss.*)
                *(COMMON)
                __ebss = .;

                /* Minimum address allowed for sbrk() to use.  */
                __heap_end_minimum = ALIGN(8);

		ASSERT(. <= 0xfff8,
		    "Error: too large for a small-model .exe file.");
    	} >dsegvma AT >bseglma

	__ldata = __edata - __sdata;
	__lbss0 = __ebss - __sbss;
	__lbss1 = __lbss0 + 1;
	__lbss = __lbss1 / 2;

    /DISCARD/ : { *(.*) }
  }
