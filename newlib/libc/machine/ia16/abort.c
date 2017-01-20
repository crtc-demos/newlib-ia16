#include <unistd.h>

void abort(void)
{
  while (1)
    _exit(1);
}
