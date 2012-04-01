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

PLATFORM       := win-i686-debug
CC             := cl.exe
LD             := link.exe
CFLAGS         := -nologo -GR- -W3 -Zi -Od -MDd
DFLAGS         := -D_REENTRANT -D_MT -DBLD_FEATURE_PCRE=1
IFLAGS         := -I$(PLATFORM)/inc
LDFLAGS        := '-nologo' '-nodefaultlib' '-incremental:no' '-debug' '-machine:x86'
LIBPATHS       := -libpath:$(PLATFORM)/bin
LIBS           := ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib

all: prep \
        $(PLATFORM)/bin/libpcre.dll

.PHONY: prep

prep:
	@[ ! -x $(PLATFORM)/inc ] && mkdir -p $(PLATFORM)/inc $(PLATFORM)/obj $(PLATFORM)/lib $(PLATFORM)/bin ; true
	@[ ! -f $(PLATFORM)/inc/buildConfig.h ] && cp projects/buildConfig.$(PLATFORM) $(PLATFORM)/inc/buildConfig.h ; true
	@if ! diff $(PLATFORM)/inc/buildConfig.h projects/buildConfig.$(PLATFORM) >/dev/null ; then\
		echo cp projects/buildConfig.$(PLATFORM) $(PLATFORM)/inc/buildConfig.h  ; \
		cp projects/buildConfig.$(PLATFORM) $(PLATFORM)/inc/buildConfig.h  ; \
	fi; true

clean:
	rm -rf $(PLATFORM)/bin/libpcre.dll
	rm -rf $(PLATFORM)/obj/pcre_chartables.obj
	rm -rf $(PLATFORM)/obj/pcre_compile.obj
	rm -rf $(PLATFORM)/obj/pcre_exec.obj
	rm -rf $(PLATFORM)/obj/pcre_globals.obj
	rm -rf $(PLATFORM)/obj/pcre_newline.obj
	rm -rf $(PLATFORM)/obj/pcre_ord2utf8.obj
	rm -rf $(PLATFORM)/obj/pcre_tables.obj
	rm -rf $(PLATFORM)/obj/pcre_try_flipped.obj
	rm -rf $(PLATFORM)/obj/pcre_ucp_searchfuncs.obj
	rm -rf $(PLATFORM)/obj/pcre_valid_utf8.obj
	rm -rf $(PLATFORM)/obj/pcre_xclass.obj

clobber: clean
	rm -fr ./$(PLATFORM)

$(PLATFORM)/inc/config.h: 
	rm -fr win-i686-debug/inc/config.h
	cp -r src/config.h win-i686-debug/inc/config.h

$(PLATFORM)/inc/pcre.h: 
	rm -fr win-i686-debug/inc/pcre.h
	cp -r src/pcre.h win-i686-debug/inc/pcre.h

$(PLATFORM)/inc/pcre_internal.h: 
	rm -fr win-i686-debug/inc/pcre_internal.h
	cp -r src/pcre_internal.h win-i686-debug/inc/pcre_internal.h

$(PLATFORM)/inc/ucp.h: 
	rm -fr win-i686-debug/inc/ucp.h
	cp -r src/ucp.h win-i686-debug/inc/ucp.h

$(PLATFORM)/inc/ucpinternal.h: 
	rm -fr win-i686-debug/inc/ucpinternal.h
	cp -r src/ucpinternal.h win-i686-debug/inc/ucpinternal.h

$(PLATFORM)/inc/ucptable.h: 
	rm -fr win-i686-debug/inc/ucptable.h
	cp -r src/ucptable.h win-i686-debug/inc/ucptable.h

$(PLATFORM)/obj/pcre_chartables.obj: \
        src/pcre_chartables.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_chartables.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_chartables.c

$(PLATFORM)/obj/pcre_compile.obj: \
        src/pcre_compile.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_compile.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_compile.c

$(PLATFORM)/obj/pcre_exec.obj: \
        src/pcre_exec.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_exec.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_exec.c

$(PLATFORM)/obj/pcre_globals.obj: \
        src/pcre_globals.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_globals.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_globals.c

$(PLATFORM)/obj/pcre_newline.obj: \
        src/pcre_newline.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_newline.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_newline.c

$(PLATFORM)/obj/pcre_ord2utf8.obj: \
        src/pcre_ord2utf8.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_ord2utf8.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_ord2utf8.c

$(PLATFORM)/obj/pcre_tables.obj: \
        src/pcre_tables.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_tables.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_tables.c

$(PLATFORM)/obj/pcre_try_flipped.obj: \
        src/pcre_try_flipped.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_try_flipped.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_try_flipped.c

$(PLATFORM)/obj/pcre_ucp_searchfuncs.obj: \
        src/pcre_ucp_searchfuncs.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_ucp_searchfuncs.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_ucp_searchfuncs.c

$(PLATFORM)/obj/pcre_valid_utf8.obj: \
        src/pcre_valid_utf8.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_valid_utf8.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_valid_utf8.c

$(PLATFORM)/obj/pcre_xclass.obj: \
        src/pcre_xclass.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre_xclass.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc src/pcre_xclass.c

$(PLATFORM)/bin/libpcre.dll:  \
        $(PLATFORM)/inc/config.h \
        $(PLATFORM)/inc/pcre.h \
        $(PLATFORM)/inc/pcre_internal.h \
        $(PLATFORM)/inc/ucp.h \
        $(PLATFORM)/inc/ucpinternal.h \
        $(PLATFORM)/inc/ucptable.h \
        $(PLATFORM)/obj/pcre_chartables.obj \
        $(PLATFORM)/obj/pcre_compile.obj \
        $(PLATFORM)/obj/pcre_exec.obj \
        $(PLATFORM)/obj/pcre_globals.obj \
        $(PLATFORM)/obj/pcre_newline.obj \
        $(PLATFORM)/obj/pcre_ord2utf8.obj \
        $(PLATFORM)/obj/pcre_tables.obj \
        $(PLATFORM)/obj/pcre_try_flipped.obj \
        $(PLATFORM)/obj/pcre_ucp_searchfuncs.obj \
        $(PLATFORM)/obj/pcre_valid_utf8.obj \
        $(PLATFORM)/obj/pcre_xclass.obj
	"$(LD)" -dll -out:$(PLATFORM)/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libpcre.def $(LDFLAGS) $(LIBPATHS) $(PLATFORM)/obj/pcre_chartables.obj $(PLATFORM)/obj/pcre_compile.obj $(PLATFORM)/obj/pcre_exec.obj $(PLATFORM)/obj/pcre_globals.obj $(PLATFORM)/obj/pcre_newline.obj $(PLATFORM)/obj/pcre_ord2utf8.obj $(PLATFORM)/obj/pcre_tables.obj $(PLATFORM)/obj/pcre_try_flipped.obj $(PLATFORM)/obj/pcre_ucp_searchfuncs.obj $(PLATFORM)/obj/pcre_valid_utf8.obj $(PLATFORM)/obj/pcre_xclass.obj $(LIBS)

