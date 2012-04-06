#
#   macosx-x86_64-debug.mk -- Build It Makefile to build PCRE Library for macosx on x86_64
#

CONFIG   := macosx-x86_64-debug
CC       := /usr/bin/cc
LD       := /usr/bin/ld
CFLAGS   := -fPIC -Wall -fast -Wshorten-64-to-32
DFLAGS   := -DPIC -DBLD_FEATURE_PCRE=1 -DCPU=X86_64
IFLAGS   := -I$(CONFIG)/inc -I$(CONFIG)/inc
LDFLAGS  := '-Wl,-rpath,@executable_path/../lib' '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS := -L$(CONFIG)/lib
LIBS     := -lpthread -lm -ldl

all: prep \
        $(CONFIG)/lib/libpcre.dylib

.PHONY: prep

prep:
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/buildConfig.h ] && cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h ; true
	@if ! diff $(CONFIG)/inc/buildConfig.h projects/buildConfig.$(CONFIG) >/dev/null ; then\
		echo cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
		cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
	fi; true

clean:
	rm -rf $(CONFIG)/lib/libpcre.dylib
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

$(CONFIG)/inc/config.h: 
	rm -fr macosx-x86_64-debug/inc/config.h
	cp -r src/config.h macosx-x86_64-debug/inc/config.h

$(CONFIG)/inc/pcre.h: 
	rm -fr macosx-x86_64-debug/inc/pcre.h
	cp -r src/pcre.h macosx-x86_64-debug/inc/pcre.h

$(CONFIG)/inc/pcre_internal.h: 
	rm -fr macosx-x86_64-debug/inc/pcre_internal.h
	cp -r src/pcre_internal.h macosx-x86_64-debug/inc/pcre_internal.h

$(CONFIG)/inc/ucp.h: 
	rm -fr macosx-x86_64-debug/inc/ucp.h
	cp -r src/ucp.h macosx-x86_64-debug/inc/ucp.h

$(CONFIG)/inc/ucpinternal.h: 
	rm -fr macosx-x86_64-debug/inc/ucpinternal.h
	cp -r src/ucpinternal.h macosx-x86_64-debug/inc/ucpinternal.h

$(CONFIG)/inc/ucptable.h: 
	rm -fr macosx-x86_64-debug/inc/ucptable.h
	cp -r src/ucptable.h macosx-x86_64-debug/inc/ucptable.h

$(CONFIG)/obj/pcre_chartables.o: \
        src/pcre_chartables.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_chartables.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_chartables.c

$(CONFIG)/obj/pcre_compile.o: \
        src/pcre_compile.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_compile.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_compile.c

$(CONFIG)/obj/pcre_exec.o: \
        src/pcre_exec.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_exec.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_exec.c

$(CONFIG)/obj/pcre_globals.o: \
        src/pcre_globals.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_globals.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_globals.c

$(CONFIG)/obj/pcre_newline.o: \
        src/pcre_newline.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_newline.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_newline.c

$(CONFIG)/obj/pcre_ord2utf8.o: \
        src/pcre_ord2utf8.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ord2utf8.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ord2utf8.c

$(CONFIG)/obj/pcre_tables.o: \
        src/pcre_tables.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_tables.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_tables.c

$(CONFIG)/obj/pcre_try_flipped.o: \
        src/pcre_try_flipped.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_try_flipped.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_try_flipped.c

$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
        src/pcre_ucp_searchfuncs.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ucp_searchfuncs.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ucp_searchfuncs.c

$(CONFIG)/obj/pcre_valid_utf8.o: \
        src/pcre_valid_utf8.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_valid_utf8.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_valid_utf8.c

$(CONFIG)/obj/pcre_xclass.o: \
        src/pcre_xclass.c \
        $(CONFIG)/inc/buildConfig.h \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre_internal.h
	$(CC) -c -o $(CONFIG)/obj/pcre_xclass.o -arch x86_64 $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_xclass.c

$(CONFIG)/lib/libpcre.dylib:  \
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
	$(CC) -dynamiclib -o $(CONFIG)/lib/libpcre.dylib -arch x86_64 $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libpcre.dylib $(CONFIG)/obj/pcre_chartables.o $(CONFIG)/obj/pcre_compile.o $(CONFIG)/obj/pcre_exec.o $(CONFIG)/obj/pcre_globals.o $(CONFIG)/obj/pcre_newline.o $(CONFIG)/obj/pcre_ord2utf8.o $(CONFIG)/obj/pcre_tables.o $(CONFIG)/obj/pcre_try_flipped.o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CONFIG)/obj/pcre_valid_utf8.o $(CONFIG)/obj/pcre_xclass.o $(LIBS)

