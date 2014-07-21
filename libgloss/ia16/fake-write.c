/* This is a fake; it pretends to succeed although it always fails.
   Several GCC tests check that printf() and friends output the correct
   number of bytes. All those tests will fail if write() returns failure.
   This fucntion is used to avoid false testsuite failures.  */

int write (int fd, char *data, int nbytes)
{
  return nbytes;
}
