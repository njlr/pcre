#
#   linux-i686-debug.mk -- Build It Makefile to build PCRE Library for linux on i686
#

CONFIG   := linux-i686-debug
CC       := cc
LD       := ld
CFLAGS   := -Wall -fPIC -O3 -Wno-unused-result -mtune=i686 -fPIC -O3 -Wno-unused-result -mtune=i686
DFLAGS   := -D_REENTRANT -DCPU=${ARCH} -DBLD_FEATURE_PCRE=1 -DPIC -DPIC
IFLAGS   := -I$(CONFIG)/inc -I$(CONFIG)/inc
LDFLAGS  := '-Wl,--enable-new-dtags' '-Wl,-rpath,$$ORIGIN/' '-Wl,-rpath,$$ORIGIN/../lib'
LIBPATHS := -L$(CONFIG)/lib -L$(CONFIG)/lib
LIBS     := -lpthread -lm -ldl -lpthread -lm -ldl

all: prep \
        $(CONFIG)/lib/libpcre.so

.PHONY: prep

prep:
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/buildConfig.h ] && cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h ; true
	@if ! diff $(CONFIG)/inc/buildConfig.h projects/buildConfig.$(CONFIG) >/dev/null ; then\
		echo cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
		cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
	fi; true

clean:
	rm -rf $(CONFIG)/lib/libpcre.so
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
	rm -fr linux-i686-debug/inc/config.h
	cp -r src/config.h linux-i686-debug/inc/config.h

$(CONFIG)/inc/pcre.h: 
	rm -fr linux-i686-debug/inc/pcre.h
	cp -r src/pcre.h linux-i686-debug/inc/pcre.h

$(CONFIG)/inc/pcre_internal.h: 
	rm -fr linux-i686-debug/inc/pcre_internal.h
	cp -r src/pcre_internal.h linux-i686-debug/inc/pcre_internal.h

$(CONFIG)/inc/ucp.h: 
	rm -fr linux-i686-debug/inc/ucp.h
	cp -r src/ucp.h linux-i686-debug/inc/ucp.h

$(CONFIG)/inc/ucpinternal.h: 
	rm -fr linux-i686-debug/inc/ucpinternal.h
	cp -r src/ucpinternal.h linux-i686-debug/inc/ucpinternal.h

$(CONFIG)/inc/ucptable.h: 
	rm -fr linux-i686-debug/inc/ucptable.h
	cp -r src/ucptable.h linux-i686-debug/inc/ucptable.h

$(CONFIG)/obj/pcre_chartables.o: \
        src/pcre_chartables.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_chartables.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_chartables.c

$(CONFIG)/obj/pcre_compile.o: \
        src/pcre_compile.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_compile.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_compile.c

$(CONFIG)/obj/pcre_exec.o: \
        src/pcre_exec.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_exec.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_exec.c

$(CONFIG)/obj/pcre_globals.o: \
        src/pcre_globals.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_globals.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_globals.c

$(CONFIG)/obj/pcre_newline.o: \
        src/pcre_newline.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_newline.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_newline.c

$(CONFIG)/obj/pcre_ord2utf8.o: \
        src/pcre_ord2utf8.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ord2utf8.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ord2utf8.c

$(CONFIG)/obj/pcre_tables.o: \
        src/pcre_tables.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_tables.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_tables.c

$(CONFIG)/obj/pcre_try_flipped.o: \
        src/pcre_try_flipped.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_try_flipped.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_try_flipped.c

$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
        src/pcre_ucp_searchfuncs.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ucp_searchfuncs.c

$(CONFIG)/obj/pcre_valid_utf8.o: \
        src/pcre_valid_utf8.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_valid_utf8.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_valid_utf8.c

$(CONFIG)/obj/pcre_xclass.o: \
        src/pcre_xclass.c \
        $(CONFIG)/inc/buildConfig.h
	$(CC) -c -o $(CONFIG)/obj/pcre_xclass.o $(CFLAGS) -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_xclass.c

$(CONFIG)/lib/libpcre.so:  \
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
	$(CC) -shared -o $(CONFIG)/lib/libpcre.so $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/pcre_chartables.o $(CONFIG)/obj/pcre_compile.o $(CONFIG)/obj/pcre_exec.o $(CONFIG)/obj/pcre_globals.o $(CONFIG)/obj/pcre_newline.o $(CONFIG)/obj/pcre_ord2utf8.o $(CONFIG)/obj/pcre_tables.o $(CONFIG)/obj/pcre_try_flipped.o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CONFIG)/obj/pcre_valid_utf8.o $(CONFIG)/obj/pcre_xclass.o $(LIBS)

