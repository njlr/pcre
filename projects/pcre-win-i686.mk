#
#   win-i686-debug.mk -- Build It Makefile to build PCRE Library for win on i686
#

VS             := $(VSINSTALLDIR)
VS             ?= \Users\mob\git\pcre\$(VS)
SDK            := $(WindowsSDKDir)
SDK            ?= $(SDK)

export         SDK VS
export PATH    := $(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)
export INCLUDE := $(INCLUDE);$(SDK)/INCLUDE:$(VS)/VC/INCLUDE
export LIB     := $(LIB);$(SDK)/lib:$(VS)/VC/lib

OS       := win
CONFIG   := $(OS)-i686-debug
CC       := cl.exe
LD       := link.exe
CFLAGS   := -nologo -GR- -W3 -Zi -Od -MDd
DFLAGS   := -D_REENTRANT -D_MT -DBLD_FEATURE_PCRE=1
IFLAGS   := -I$(CONFIG)/inc
LDFLAGS  := '-nologo' '-nodefaultlib' '-incremental:no' '-debug' '-machine:x86'
LIBPATHS := -libpath:$(CONFIG)/bin
LIBS     := ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib

all: prep \
        $(CONFIG)/bin/libpcre.dll

.PHONY: prep

prep:
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/pcre-$(OS)-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/pcre-$(OS)-bit.h >/dev/null ; then\
		echo cp projects/pcre-$(OS)-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/pcre-$(OS)-bit.h $(CONFIG)/inc/bit.h  ; \
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
	rm -fr $(CONFIG)/inc/config.h
	cp -r src/config.h $(CONFIG)/inc/config.h

$(CONFIG)/inc/pcre.h: 
	rm -fr $(CONFIG)/inc/pcre.h
	cp -r src/pcre.h $(CONFIG)/inc/pcre.h

$(CONFIG)/inc/pcre_internal.h: 
	rm -fr $(CONFIG)/inc/pcre_internal.h
	cp -r src/pcre_internal.h $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/inc/ucp.h: 
	rm -fr $(CONFIG)/inc/ucp.h
	cp -r src/ucp.h $(CONFIG)/inc/ucp.h

$(CONFIG)/inc/ucpinternal.h: 
	rm -fr $(CONFIG)/inc/ucpinternal.h
	cp -r src/ucpinternal.h $(CONFIG)/inc/ucpinternal.h

$(CONFIG)/inc/ucptable.h: 
	rm -fr $(CONFIG)/inc/ucptable.h
	cp -r src/ucptable.h $(CONFIG)/inc/ucptable.h

$(CONFIG)/obj/pcre_chartables.obj: \
        src/pcre_chartables.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_chartables.obj -Fd$(CONFIG)/obj/pcre_chartables.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_chartables.c

$(CONFIG)/obj/pcre_compile.obj: \
        src/pcre_compile.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_compile.obj -Fd$(CONFIG)/obj/pcre_compile.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_compile.c

$(CONFIG)/obj/pcre_exec.obj: \
        src/pcre_exec.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_exec.obj -Fd$(CONFIG)/obj/pcre_exec.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_exec.c

$(CONFIG)/obj/pcre_globals.obj: \
        src/pcre_globals.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_globals.obj -Fd$(CONFIG)/obj/pcre_globals.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_globals.c

$(CONFIG)/obj/pcre_newline.obj: \
        src/pcre_newline.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_newline.obj -Fd$(CONFIG)/obj/pcre_newline.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_newline.c

$(CONFIG)/obj/pcre_ord2utf8.obj: \
        src/pcre_ord2utf8.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_ord2utf8.obj -Fd$(CONFIG)/obj/pcre_ord2utf8.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_ord2utf8.c

$(CONFIG)/obj/pcre_tables.obj: \
        src/pcre_tables.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_tables.obj -Fd$(CONFIG)/obj/pcre_tables.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_tables.c

$(CONFIG)/obj/pcre_try_flipped.obj: \
        src/pcre_try_flipped.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_try_flipped.obj -Fd$(CONFIG)/obj/pcre_try_flipped.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_try_flipped.c

$(CONFIG)/obj/pcre_ucp_searchfuncs.obj: \
        src/pcre_ucp_searchfuncs.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_ucp_searchfuncs.obj -Fd$(CONFIG)/obj/pcre_ucp_searchfuncs.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_ucp_searchfuncs.c

$(CONFIG)/obj/pcre_valid_utf8.obj: \
        src/pcre_valid_utf8.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_valid_utf8.obj -Fd$(CONFIG)/obj/pcre_valid_utf8.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_valid_utf8.c

$(CONFIG)/obj/pcre_xclass.obj: \
        src/pcre_xclass.c \
        $(CONFIG)/inc/bit.h
	"$(CC)" -c -Fo$(CONFIG)/obj/pcre_xclass.obj -Fd$(CONFIG)/obj/pcre_xclass.pdb $(CFLAGS) -I$(CONFIG)/inc src/pcre_xclass.c

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
	"$(LD)" -dll -out:$(CONFIG)/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:$(CONFIG)/bin/libpcre.def $(LIBPATHS) $(CONFIG)/obj/pcre_chartables.obj $(CONFIG)/obj/pcre_compile.obj $(CONFIG)/obj/pcre_exec.obj $(CONFIG)/obj/pcre_globals.obj $(CONFIG)/obj/pcre_newline.obj $(CONFIG)/obj/pcre_ord2utf8.obj $(CONFIG)/obj/pcre_tables.obj $(CONFIG)/obj/pcre_try_flipped.obj $(CONFIG)/obj/pcre_ucp_searchfuncs.obj $(CONFIG)/obj/pcre_valid_utf8.obj $(CONFIG)/obj/pcre_xclass.obj $(LIBS)

