/* Version of sbrk for ELKS.  */
/*
#include "config.h"
*/
#include <_syslist.h>

extern int _brk (char *);

void *
_sbrk (incr)
     int incr;
{ 
   extern char _heap_end_minimum[]; /* Defined by linker script.  */
   static char *heap_end;
   char *prev_heap_end; 

   if (heap_end == 0)
     heap_end = _heap_end_minimum;

   prev_heap_end = heap_end; 
   heap_end += incr; 

   if (heap_end >= _heap_end_minimum
       && (0 == _brk (heap_end)))
     return (void *) prev_heap_end; 

   heap_end = prev_heap_end;
   return ((void *) -1);
} 
