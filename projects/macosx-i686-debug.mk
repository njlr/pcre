#
#   macosx-i686-debug.mk -- Build It Makefile to build PCRE Library for macosx on i686
#

PLATFORM       := macosx-i686-debug
CC             := cc
LD             := /usr/bin/ld
CFLAGS         := -fPIC -Wall -g
DFLAGS         := -DPIC -DBLD_FEATURE_PCRE=1 -DCPU=I686
IFLAGS         := -I$(PLATFORM)/inc
LDFLAGS        := -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L$(PLATFORM)/lib -g -ldl
LIBS           := -lpthread -lm

all: prep \
        $(PLATFORM)/lib/libpcre.dylib

.PHONY: prep

prep:
	@[ ! -x $(PLATFORM)/inc ] && mkdir -p $(PLATFORM)/inc $(PLATFORM)/obj $(PLATFORM)/lib $(PLATFORM)/bin ; true
	@[ ! -f $(PLATFORM)/inc/buildConfig.h ] && cp projects/buildConfig.$(PLATFORM) $(PLATFORM)/inc/buildConfig.h ; true

clean:
	rm -rf $(PLATFORM)/lib/libpcre.dylib
	rm -rf $(PLATFORM)/obj/pcre_chartables.o
	rm -rf $(PLATFORM)/obj/pcre_compile.o
	rm -rf $(PLATFORM)/obj/pcre_exec.o
	rm -rf $(PLATFORM)/obj/pcre_globals.o
	rm -rf $(PLATFORM)/obj/pcre_newline.o
	rm -rf $(PLATFORM)/obj/pcre_ord2utf8.o
	rm -rf $(PLATFORM)/obj/pcre_tables.o
	rm -rf $(PLATFORM)/obj/pcre_try_flipped.o
	rm -rf $(PLATFORM)/obj/pcre_ucp_searchfuncs.o
	rm -rf $(PLATFORM)/obj/pcre_valid_utf8.o
	rm -rf $(PLATFORM)/obj/pcre_xclass.o

clobber: clean
	rm -fr ./$(PLATFORM)

$(PLATFORM)/inc/config.h: 
	rm -fr macosx-i686-debug/inc/config.h
	cp -r src/config.h macosx-i686-debug/inc/config.h

$(PLATFORM)/inc/pcre.h: 
	rm -fr macosx-i686-debug/inc/pcre.h
	cp -r src/pcre.h macosx-i686-debug/inc/pcre.h

$(PLATFORM)/inc/pcre_internal.h: 
	rm -fr macosx-i686-debug/inc/pcre_internal.h
	cp -r src/pcre_internal.h macosx-i686-debug/inc/pcre_internal.h

$(PLATFORM)/inc/ucp.h: 
	rm -fr macosx-i686-debug/inc/ucp.h
	cp -r src/ucp.h macosx-i686-debug/inc/ucp.h

$(PLATFORM)/inc/ucpinternal.h: 
	rm -fr macosx-i686-debug/inc/ucpinternal.h
	cp -r src/ucpinternal.h macosx-i686-debug/inc/ucpinternal.h

$(PLATFORM)/inc/ucptable.h: 
	rm -fr macosx-i686-debug/inc/ucptable.h
	cp -r src/ucptable.h macosx-i686-debug/inc/ucptable.h

$(PLATFORM)/obj/pcre_chartables.o: \
        src/pcre_chartables.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_chartables.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_chartables.c

$(PLATFORM)/obj/pcre_compile.o: \
        src/pcre_compile.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_compile.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_compile.c

$(PLATFORM)/obj/pcre_exec.o: \
        src/pcre_exec.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_exec.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_exec.c

$(PLATFORM)/obj/pcre_globals.o: \
        src/pcre_globals.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_globals.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_globals.c

$(PLATFORM)/obj/pcre_newline.o: \
        src/pcre_newline.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_newline.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_newline.c

$(PLATFORM)/obj/pcre_ord2utf8.o: \
        src/pcre_ord2utf8.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_ord2utf8.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_ord2utf8.c

$(PLATFORM)/obj/pcre_tables.o: \
        src/pcre_tables.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_tables.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_tables.c

$(PLATFORM)/obj/pcre_try_flipped.o: \
        src/pcre_try_flipped.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_try_flipped.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_try_flipped.c

$(PLATFORM)/obj/pcre_ucp_searchfuncs.o: \
        src/pcre_ucp_searchfuncs.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_ucp_searchfuncs.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_ucp_searchfuncs.c

$(PLATFORM)/obj/pcre_valid_utf8.o: \
        src/pcre_valid_utf8.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_valid_utf8.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_valid_utf8.c

$(PLATFORM)/obj/pcre_xclass.o: \
        src/pcre_xclass.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre_xclass.o -arch i686 $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_xclass.c

$(PLATFORM)/lib/libpcre.dylib:  \
        $(PLATFORM)/inc/config.h \
        $(PLATFORM)/inc/pcre.h \
        $(PLATFORM)/inc/pcre_internal.h \
        $(PLATFORM)/inc/ucp.h \
        $(PLATFORM)/inc/ucpinternal.h \
        $(PLATFORM)/inc/ucptable.h \
        $(PLATFORM)/obj/pcre_chartables.o \
        $(PLATFORM)/obj/pcre_compile.o \
        $(PLATFORM)/obj/pcre_exec.o \
        $(PLATFORM)/obj/pcre_globals.o \
        $(PLATFORM)/obj/pcre_newline.o \
        $(PLATFORM)/obj/pcre_ord2utf8.o \
        $(PLATFORM)/obj/pcre_tables.o \
        $(PLATFORM)/obj/pcre_try_flipped.o \
        $(PLATFORM)/obj/pcre_ucp_searchfuncs.o \
        $(PLATFORM)/obj/pcre_valid_utf8.o \
        $(PLATFORM)/obj/pcre_xclass.o
	$(CC) -dynamiclib -o $(PLATFORM)/lib/libpcre.dylib -arch i686 $(LDFLAGS) -install_name @rpath/libpcre.dylib $(PLATFORM)/obj/pcre_chartables.o $(PLATFORM)/obj/pcre_compile.o $(PLATFORM)/obj/pcre_exec.o $(PLATFORM)/obj/pcre_globals.o $(PLATFORM)/obj/pcre_newline.o $(PLATFORM)/obj/pcre_ord2utf8.o $(PLATFORM)/obj/pcre_tables.o $(PLATFORM)/obj/pcre_try_flipped.o $(PLATFORM)/obj/pcre_ucp_searchfuncs.o $(PLATFORM)/obj/pcre_valid_utf8.o $(PLATFORM)/obj/pcre_xclass.o $(LIBS)

