## Process this file with automake to generate Makefile.in

AUTOMAKE_OPTIONS = cygnus

INCLUDES = $(NEWLIB_CFLAGS) $(CROSS_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(INCLUDES)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = \
	memccpy.S \
	memchr.S \
	memcmp.S \
	memcpy.S \
	memmove.S \
	mempcpy.S \
	memrchr.S \
	memset.S \
	rawmemchr.S \
	setjmp.S \
	stpcpy.S \
	stpncpy.S \
	strchr.S \
	strcmp.S \
	strcpy.S \
	strlen.S \
	strncmp.S \
	strncpy.S
lib_a_CCASFLAGS=$(AM_CCASFLAGS)
lib_a_CFLAGS=$(AM_CFLAGS)

ACLOCAL_AMFLAGS = -I ../../..
CONFIG_STATUS_DEPENDENCIES = $(newlib_basedir)/configure.host
