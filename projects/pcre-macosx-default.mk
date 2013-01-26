#
#   pcre-macosx-default.mk -- Makefile to build PCRE Library for macosx
#

PRODUCT         ?= pcre
VERSION         ?= 1.0.0
BUILD_NUMBER    ?= 0
PROFILE         ?= default
ARCH            ?= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
OS              ?= macosx
CC              ?= /usr/bin/clang
LD              ?= /usr/bin/ld
CONFIG          ?= $(OS)-$(ARCH)-$(PROFILE)

CFLAGS          += -O3   -w
DFLAGS          += -DBIT_FEATURE_PCRE=1$(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS)))
IFLAGS          += -I$(CONFIG)/inc
LDFLAGS         += '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS        += -L$(CONFIG)/bin
LIBS            += -lpthread -lm -ldl

DEBUG           ?= release
CFLAGS-debug    := -g
CFLAGS-release  := -O2
DFLAGS-debug    := -DBIT_DEBUG
DFLAGS-release  := 
LDFLAGS-debug   := -g
LDFLAGS-release := 
CFLAGS          += $(CFLAGS-$(PROFILE))
DFLAGS          += $(DFLAGS-$(PROFILE))
LDFLAGS         += $(LDFLAGS-$(PROFILE))

all compile: prep \
        $(CONFIG)/bin/libpcre.dylib

.PHONY: prep

prep:
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/pcre-$(OS)-$(PROFILE)-bit.h $(CONFIG)/inc/bit.h ; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/pcre-$(OS)-$(PROFILE)-bit.h >/dev/null ; then\
		echo cp projects/pcre-$(OS)-$(PROFILE)-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/pcre-$(OS)-$(PROFILE)-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@echo $(DFLAGS) $(CFLAGS) >projects/.flags

clean:
	rm -rf $(CONFIG)/bin/libpcre.dylib
	rm -rf $(CONFIG)/obj/pcre_chartables.o
	rm -rf $(CONFIG)/obj/pcre_compile.o
	rm -rf $(CONFIG)/obj/pcre_exec.o
	rm -rf $(CONFIG)/obj/pcre_globals.o
	rm -rf $(CONFIG)/obj/pcre_newline.o
	rm -rf $(CONFIG)/obj/pcre_ord2utf8.o
	rm -rf $(CONFIG)/obj/pcre_tables.o
	rm -rf $(CONFIG)/obj/pcre_try_flipped.o
	rm -rf $(CONFIG)/obj/pcre_ucp_searchfuncs.o
	rm -rf $(CONFIG)/obj/pcre_valid_utf8.o
	rm -rf $(CONFIG)/obj/pcre_xclass.o

clobber: clean
	rm -fr ./$(CONFIG)

$(CONFIG)/inc/config.h:  \
        $(CONFIG)/inc/bit.h
	rm -fr $(CONFIG)/inc/config.h
	cp -r src/config.h $(CONFIG)/inc/config.h

$(CONFIG)/inc/pcre.h:  \
        $(CONFIG)/inc/bit.h
	rm -fr $(CONFIG)/inc/pcre.h
	cp -r src/pcre.h $(CONFIG)/inc/pcre.h

$(CONFIG)/inc/ucp.h:  \
        $(CONFIG)/inc/bit.h
	rm -fr $(CONFIG)/inc/ucp.h
	cp -r src/ucp.h $(CONFIG)/inc/ucp.h

$(CONFIG)/inc/pcre_internal.h:  \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre.h \
        $(CONFIG)/inc/ucp.h
	rm -fr $(CONFIG)/inc/pcre_internal.h
	cp -r src/pcre_internal.h $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/inc/ucpinternal.h: 
	rm -fr $(CONFIG)/inc/ucpinternal.h
	cp -r src/ucpinternal.h $(CONFIG)/inc/ucpinternal.h

$(CONFIG)/inc/ucptable.h: 
	rm -fr $(CONFIG)/inc/ucptable.h
	cp -r src/ucptable.h $(CONFIG)/inc/ucptable.h

$(CONFIG)/obj/pcre_chartables.o: \
        src/pcre_chartables.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_chartables.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_chartables.c

$(CONFIG)/obj/pcre_compile.o: \
        src/pcre_compile.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_compile.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_compile.c

$(CONFIG)/obj/pcre_exec.o: \
        src/pcre_exec.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_exec.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_exec.c

$(CONFIG)/obj/pcre_globals.o: \
        src/pcre_globals.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_globals.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_globals.c

$(CONFIG)/obj/pcre_newline.o: \
        src/pcre_newline.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_newline.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_newline.c

$(CONFIG)/obj/pcre_ord2utf8.o: \
        src/pcre_ord2utf8.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ord2utf8.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_ord2utf8.c

$(CONFIG)/obj/pcre_tables.o: \
        src/pcre_tables.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_tables.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_tables.c

$(CONFIG)/obj/pcre_try_flipped.o: \
        src/pcre_try_flipped.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_try_flipped.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_try_flipped.c

$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
        src/pcre_ucp_searchfuncs.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ucp_searchfuncs.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_ucp_searchfuncs.c

$(CONFIG)/obj/pcre_valid_utf8.o: \
        src/pcre_valid_utf8.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_valid_utf8.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_valid_utf8.c

$(CONFIG)/obj/pcre_xclass.o: \
        src/pcre_xclass.c \
        $(CONFIG)/inc/bit.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_xclass.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc src/pcre_xclass.c

$(CONFIG)/bin/libpcre.dylib:  \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre.h \
        $(CONFIG)/inc/pcre_internal.h \
        $(CONFIG)/inc/ucp.h \
        $(CONFIG)/inc/ucpinternal.h \
        $(CONFIG)/inc/ucptable.h \
        $(CONFIG)/obj/pcre_chartables.o \
        $(CONFIG)/obj/pcre_compile.o \
        $(CONFIG)/obj/pcre_exec.o \
        $(CONFIG)/obj/pcre_globals.o \
        $(CONFIG)/obj/pcre_newline.o \
        $(CONFIG)/obj/pcre_ord2utf8.o \
        $(CONFIG)/obj/pcre_tables.o \
        $(CONFIG)/obj/pcre_try_flipped.o \
        $(CONFIG)/obj/pcre_ucp_searchfuncs.o \
        $(CONFIG)/obj/pcre_valid_utf8.o \
        $(CONFIG)/obj/pcre_xclass.o
	$(CC) -dynamiclib -o $(CONFIG)/bin/libpcre.dylib -arch x86_64 $(LDFLAGS) -compatibility_version 1.0.0 -current_version 1.0.0 -compatibility_version 1.0.0 -current_version 1.0.0 $(LIBPATHS) -install_name @rpath/libpcre.dylib $(CONFIG)/obj/pcre_chartables.o $(CONFIG)/obj/pcre_compile.o $(CONFIG)/obj/pcre_exec.o $(CONFIG)/obj/pcre_globals.o $(CONFIG)/obj/pcre_newline.o $(CONFIG)/obj/pcre_ord2utf8.o $(CONFIG)/obj/pcre_tables.o $(CONFIG)/obj/pcre_try_flipped.o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CONFIG)/obj/pcre_valid_utf8.o $(CONFIG)/obj/pcre_xclass.o $(LIBS)

version: 
	@echo 1.0.0-0 

