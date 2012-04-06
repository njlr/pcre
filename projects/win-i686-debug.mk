#
#   win-i686-debug.mk -- Build It Makefile to build PCRE Library for win on i686
#

VS             := $(VSINSTALLDIR)
VS             ?= $(VS)
SDK            := $(WindowsSDKDir)
SDK            ?= $(SDK)

export         SDK VS
export PATH    := $(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)
export INCLUDE := $(INCLUDE);$(SDK)/INCLUDE:$(VS)/VC/INCLUDE
export LIB     := $(LIB);$(SDK)/lib:$(VS)/VC/lib

CONFIG   := win-i686-debug
CC       := cl.exe
LD       := link.exe
CFLAGS   := -nologo -GR- -W3 -Zi -Od -MDd -Zi -Od -MDd
DFLAGS   := -D_REENTRANT -D_MT -DBLD_FEATURE_PCRE=1
IFLAGS   := -I$(CONFIG)/inc -I$(CONFIG)/inc
LDFLAGS  := '-nologo' '-nodefaultlib' '-incremental:no' '-machine:x86' '-machine:x86'
LIBPATHS := -libpath:$(CONFIG)/bin -libpath:$(CONFIG)/bin
LIBS     := ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib

all: prep \
        $(CONFIG)/bin/libpcre.dll

.PHONY: prep

prep:
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/buildConfig.h ] && cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h ; true
	@if ! diff $(CONFIG)/inc/buildConfig.h projects/buildConfig.$(CONFIG) >/dev/null ; then\
		echo cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
		cp projects/buildConfig.$(CONFIG) $(CONFIG)/inc/buildConfig.h  ; \
	fi; true

clean:
	rm -rf $(CONFIG)/bin/libpcre.dll
	rm -rf $(CONFIG)/obj/pcre_chartables.obj
	rm -rf $(CONFIG)/obj/pcre_compile.obj
	rm -rf $(CONFIG)/obj/pcre_exec.obj
	rm -rf $(CONFIG)/obj/pcre_globals.obj
	rm -rf $(CONFIG)/obj/pcre_newline.obj
	rm -rf $(CONFIG)/obj/pcre_ord2utf8.obj
	rm -rf $(CONFIG)/obj/pcre_tables.obj
	rm -rf $(CONFIG)/obj/pcre_try_flipped.obj
	rm -rf $(CONFIG)/obj/pcre_ucp_searchfuncs.obj
	rm -rf $(CONFIG)/obj/pcre_valid_utf8.obj
	rm -rf $(CONFIG)/obj/pcre_xclass.obj

clobber: clean
	rm -fr ./$(CONFIG)

$(CONFIG)/inc/config.h: 
	rm -fr win-i686-debug/inc/config.h
	cp -r src/config.h win-i686-debug/inc/config.h

$(CONFIG)/inc/pcre.h: 
	rm -fr win-i686-debug/inc/pcre.h
	cp -r src/pcre.h win-i686-debug/inc/pcre.h

$(CONFIG)/inc/pcre_internal.h: 
	rm -fr win-i686-debug/inc/pcre_internal.h
	cp -r src/pcre_internal.h win-i686-debug/inc/pcre_internal.h

$(CONFIG)/inc/ucp.h: 
	rm -fr win-i686-debug/inc/ucp.h
	cp -r src/ucp.h win-i686-debug/inc/ucp.h

$(CONFIG)/inc/ucpinternal.h: 
	rm -fr win-i686-debug/inc/ucpinternal.h
	cp -r src/ucpinternal.h win-i686-debug/inc/ucpinternal.h

$(CONFIG)/inc/ucptable.h: 
	rm -fr win-i686-debug/inc/ucptable.h
	cp -r src/ucptable.h win-i686-debug/inc/ucptable.h

$(CONFIG)/obj/pcre_chartables.obj: \
        src/pcre_chartables.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_chartables.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_chartables.c

$(CONFIG)/obj/pcre_compile.obj: \
        src/pcre_compile.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_compile.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_compile.c

$(CONFIG)/obj/pcre_exec.obj: \
        src/pcre_exec.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_exec.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_exec.c

$(CONFIG)/obj/pcre_globals.obj: \
        src/pcre_globals.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_globals.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_globals.c

$(CONFIG)/obj/pcre_newline.obj: \
        src/pcre_newline.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_newline.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_newline.c

$(CONFIG)/obj/pcre_ord2utf8.obj: \
        src/pcre_ord2utf8.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_ord2utf8.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ord2utf8.c

$(CONFIG)/obj/pcre_tables.obj: \
        src/pcre_tables.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_tables.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_tables.c

$(CONFIG)/obj/pcre_try_flipped.obj: \
        src/pcre_try_flipped.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_try_flipped.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_try_flipped.c

$(CONFIG)/obj/pcre_ucp_searchfuncs.obj: \
        src/pcre_ucp_searchfuncs.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_ucp_searchfuncs.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_ucp_searchfuncs.c

$(CONFIG)/obj/pcre_valid_utf8.obj: \
        src/pcre_valid_utf8.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_valid_utf8.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_valid_utf8.c

$(CONFIG)/obj/pcre_xclass.obj: \
        src/pcre_xclass.c \
        $(CONFIG)/inc/buildConfig.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_xclass.obj -Fd$(CONFIG)/obj $(CFLAGS) $(DFLAGS) -I$(CONFIG)/inc -I$(CONFIG)/inc src/pcre_xclass.c

$(CONFIG)/bin/libpcre.dll:  \
        $(CONFIG)/inc/config.h \
        $(CONFIG)/inc/pcre.h \
        $(CONFIG)/inc/pcre_internal.h \
        $(CONFIG)/inc/ucp.h \
        $(CONFIG)/inc/ucpinternal.h \
        $(CONFIG)/inc/ucptable.h \
        $(CONFIG)/obj/pcre_chartables.obj \
        $(CONFIG)/obj/pcre_compile.obj \
        $(CONFIG)/obj/pcre_exec.obj \
        $(CONFIG)/obj/pcre_globals.obj \
        $(CONFIG)/obj/pcre_newline.obj \
        $(CONFIG)/obj/pcre_ord2utf8.obj \
        $(CONFIG)/obj/pcre_tables.obj \
        $(CONFIG)/obj/pcre_try_flipped.obj \
        $(CONFIG)/obj/pcre_ucp_searchfuncs.obj \
        $(CONFIG)/obj/pcre_valid_utf8.obj \
        $(CONFIG)/obj/pcre_xclass.obj
	"$(LD)" -dll -out:$(CONFIG)/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:$(CONFIG)/bin/libpcre.def $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/pcre_chartables.obj $(CONFIG)/obj/pcre_compile.obj $(CONFIG)/obj/pcre_exec.obj $(CONFIG)/obj/pcre_globals.obj $(CONFIG)/obj/pcre_newline.obj $(CONFIG)/obj/pcre_ord2utf8.obj $(CONFIG)/obj/pcre_tables.obj $(CONFIG)/obj/pcre_try_flipped.obj $(CONFIG)/obj/pcre_ucp_searchfuncs.obj $(CONFIG)/obj/pcre_valid_utf8.obj $(CONFIG)/obj/pcre_xclass.obj $(LIBS)

