/* Version of sbrk for linuxvm86 simulator.  */
/*
#include "config.h"
*/
#include <_syslist.h>

void *
sbrk (incr)
     int incr;
{ 
   extern char * _heap_end_minimum; /* Set by startup code.  */
   static char * heap_end; 
   char *        prev_heap_end; 

   if (heap_end == 0)
     heap_end = _heap_end_minimum; 

   prev_heap_end = heap_end; 
   heap_end += incr; 

   return (void *) prev_heap_end; 
} 
