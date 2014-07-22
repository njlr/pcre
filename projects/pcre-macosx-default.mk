#
#   pcre-macosx-default.mk -- Makefile to build PCRE Library for macosx
#

NAME                  := pcre
VERSION               := 1.0.3
PROFILE               ?= default
ARCH                  ?= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH               ?= $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                    ?= macosx
CC                    ?= clang
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
BUILD                 ?= build/$(CONFIG)
LBIN                  ?= $(BUILD)/bin
PATH                  := $(LBIN):$(PATH)

ME_COM_VXWORKS        ?= 0
ME_COM_WINSDK         ?= 1


ME_COM_COMPILER_PATH  ?= clang
ME_COM_LIB_PATH       ?= ar

CFLAGS                += -g -w
DFLAGS                +=  $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) -DME_COM_VXWORKS=$(ME_COM_VXWORKS) -DME_COM_WINSDK=$(ME_COM_WINSDK) 
IFLAGS                += "-Ibuild/$(CONFIG)/inc"
LDFLAGS               += '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS              += -Lbuild/$(CONFIG)/bin
LIBS                  += -ldl -lpthread -lm

DEBUG                 ?= debug
CFLAGS-debug          ?= -g
DFLAGS-debug          ?= -DME_DEBUG
LDFLAGS-debug         ?= -g
DFLAGS-release        ?= 
CFLAGS-release        ?= -O2
LDFLAGS-release       ?= 
CFLAGS                += $(CFLAGS-$(DEBUG))
DFLAGS                += $(DFLAGS-$(DEBUG))
LDFLAGS               += $(LDFLAGS-$(DEBUG))

ME_ROOT_PREFIX        ?= 
ME_BASE_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local
ME_DATA_PREFIX        ?= $(ME_ROOT_PREFIX)/
ME_STATE_PREFIX       ?= $(ME_ROOT_PREFIX)/var
ME_APP_PREFIX         ?= $(ME_BASE_PREFIX)/lib/$(NAME)
ME_VAPP_PREFIX        ?= $(ME_APP_PREFIX)/$(VERSION)
ME_BIN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/bin
ME_INC_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/include
ME_LIB_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/lib
ME_MAN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/share/man
ME_SBIN_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local/sbin
ME_ETC_PREFIX         ?= $(ME_ROOT_PREFIX)/etc/$(NAME)
ME_WEB_PREFIX         ?= $(ME_ROOT_PREFIX)/var/www/$(NAME)-default
ME_LOG_PREFIX         ?= $(ME_ROOT_PREFIX)/var/log/$(NAME)
ME_SPOOL_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)
ME_CACHE_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)/cache
ME_SRC_PREFIX         ?= $(ME_ROOT_PREFIX)$(NAME)-$(VERSION)


TARGETS               += build/$(CONFIG)/bin/libpcre.dylib

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(ME_APP_PREFIX)" = "" ] ; then echo WARNING: ME_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(BUILD)/bin ] && mkdir -p $(BUILD)/bin; true
	@[ ! -x $(BUILD)/inc ] && mkdir -p $(BUILD)/inc; true
	@[ ! -x $(BUILD)/obj ] && mkdir -p $(BUILD)/obj; true
	@[ ! -f $(BUILD)/inc/me.h ] && cp projects/pcre-macosx-default-me.h $(BUILD)/inc/me.h ; true
	@if ! diff $(BUILD)/inc/me.h projects/pcre-macosx-default-me.h >/dev/null ; then\
		cp projects/pcre-macosx-default-me.h $(BUILD)/inc/me.h  ; \
	fi; true
	@if [ -f "$(BUILD)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != "`cat $(BUILD)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(BUILD)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(BUILD)/.makeflags

clean:
	rm -f "build/$(CONFIG)/obj/pcre_chartables.o"
	rm -f "build/$(CONFIG)/obj/pcre_compile.o"
	rm -f "build/$(CONFIG)/obj/pcre_exec.o"
	rm -f "build/$(CONFIG)/obj/pcre_globals.o"
	rm -f "build/$(CONFIG)/obj/pcre_newline.o"
	rm -f "build/$(CONFIG)/obj/pcre_ord2utf8.o"
	rm -f "build/$(CONFIG)/obj/pcre_tables.o"
	rm -f "build/$(CONFIG)/obj/pcre_try_flipped.o"
	rm -f "build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o"
	rm -f "build/$(CONFIG)/obj/pcre_valid_utf8.o"
	rm -f "build/$(CONFIG)/obj/pcre_xclass.o"
	rm -f "build/$(CONFIG)/bin/libpcre.dylib"

clobber: clean
	rm -fr ./$(BUILD)



#
#   config.h
#
build/$(CONFIG)/inc/config.h: $(DEPS_1)
	@echo '      [Copy] build/$(CONFIG)/inc/config.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/config.h build/$(CONFIG)/inc/config.h

#
#   pcre.h
#
build/$(CONFIG)/inc/pcre.h: $(DEPS_2)
	@echo '      [Copy] build/$(CONFIG)/inc/pcre.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/pcre.h build/$(CONFIG)/inc/pcre.h

#
#   pcre_internal.h
#
build/$(CONFIG)/inc/pcre_internal.h: $(DEPS_3)
	@echo '      [Copy] build/$(CONFIG)/inc/pcre_internal.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/pcre_internal.h build/$(CONFIG)/inc/pcre_internal.h

#
#   me.h
#
build/$(CONFIG)/inc/me.h: $(DEPS_4)
	@echo '      [Copy] build/$(CONFIG)/inc/me.h'

#
#   ucp.h
#
DEPS_5 += build/$(CONFIG)/inc/me.h

build/$(CONFIG)/inc/ucp.h: $(DEPS_5)
	@echo '      [Copy] build/$(CONFIG)/inc/ucp.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/ucp.h build/$(CONFIG)/inc/ucp.h

#
#   ucpinternal.h
#
build/$(CONFIG)/inc/ucpinternal.h: $(DEPS_6)
	@echo '      [Copy] build/$(CONFIG)/inc/ucpinternal.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/ucpinternal.h build/$(CONFIG)/inc/ucpinternal.h

#
#   ucptable.h
#
build/$(CONFIG)/inc/ucptable.h: $(DEPS_7)
	@echo '      [Copy] build/$(CONFIG)/inc/ucptable.h'
	mkdir -p "build/$(CONFIG)/inc"
	cp src/ucptable.h build/$(CONFIG)/inc/ucptable.h

#
#   pcre_chartables.o
#
DEPS_8 += build/$(CONFIG)/inc/me.h
DEPS_8 += build/$(CONFIG)/inc/config.h
DEPS_8 += build/$(CONFIG)/inc/pcre_internal.h
DEPS_8 += build/$(CONFIG)/inc/pcre.h
DEPS_8 += build/$(CONFIG)/inc/ucp.h

build/$(CONFIG)/obj/pcre_chartables.o: \
    src/pcre_chartables.c $(DEPS_8)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_chartables.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_chartables.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_chartables.c

#
#   pcre_compile.o
#
DEPS_9 += build/$(CONFIG)/inc/me.h
DEPS_9 += build/$(CONFIG)/inc/config.h
DEPS_9 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_compile.o: \
    src/pcre_compile.c $(DEPS_9)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_compile.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_compile.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_compile.c

#
#   pcre_exec.o
#
DEPS_10 += build/$(CONFIG)/inc/me.h
DEPS_10 += build/$(CONFIG)/inc/config.h
DEPS_10 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_exec.o: \
    src/pcre_exec.c $(DEPS_10)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_exec.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_exec.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_exec.c

#
#   pcre_globals.o
#
DEPS_11 += build/$(CONFIG)/inc/me.h
DEPS_11 += build/$(CONFIG)/inc/config.h
DEPS_11 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_globals.o: \
    src/pcre_globals.c $(DEPS_11)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_globals.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_globals.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_globals.c

#
#   pcre_newline.o
#
DEPS_12 += build/$(CONFIG)/inc/me.h
DEPS_12 += build/$(CONFIG)/inc/config.h
DEPS_12 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_newline.o: \
    src/pcre_newline.c $(DEPS_12)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_newline.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_newline.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_newline.c

#
#   pcre_ord2utf8.o
#
DEPS_13 += build/$(CONFIG)/inc/me.h
DEPS_13 += build/$(CONFIG)/inc/config.h
DEPS_13 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_ord2utf8.o: \
    src/pcre_ord2utf8.c $(DEPS_13)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_ord2utf8.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_ord2utf8.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_ord2utf8.c

#
#   pcre_tables.o
#
DEPS_14 += build/$(CONFIG)/inc/me.h
DEPS_14 += build/$(CONFIG)/inc/config.h
DEPS_14 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_tables.o: \
    src/pcre_tables.c $(DEPS_14)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_tables.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_tables.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_tables.c

#
#   pcre_try_flipped.o
#
DEPS_15 += build/$(CONFIG)/inc/me.h
DEPS_15 += build/$(CONFIG)/inc/config.h
DEPS_15 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_try_flipped.o: \
    src/pcre_try_flipped.c $(DEPS_15)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_try_flipped.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_try_flipped.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_try_flipped.c

#
#   pcre_ucp_searchfuncs.o
#
DEPS_16 += build/$(CONFIG)/inc/me.h
DEPS_16 += build/$(CONFIG)/inc/config.h
DEPS_16 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
    src/pcre_ucp_searchfuncs.c $(DEPS_16)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_ucp_searchfuncs.c

#
#   pcre_valid_utf8.o
#
DEPS_17 += build/$(CONFIG)/inc/me.h
DEPS_17 += build/$(CONFIG)/inc/config.h
DEPS_17 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_valid_utf8.o: \
    src/pcre_valid_utf8.c $(DEPS_17)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_valid_utf8.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_valid_utf8.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_valid_utf8.c

#
#   pcre_xclass.o
#
DEPS_18 += build/$(CONFIG)/inc/me.h
DEPS_18 += build/$(CONFIG)/inc/config.h
DEPS_18 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_xclass.o: \
    src/pcre_xclass.c $(DEPS_18)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_xclass.o'
	$(CC) -c $(DFLAGS) -o build/$(CONFIG)/obj/pcre_xclass.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre_xclass.c

#
#   libpcre
#
DEPS_19 += build/$(CONFIG)/inc/config.h
DEPS_19 += build/$(CONFIG)/inc/pcre.h
DEPS_19 += build/$(CONFIG)/inc/pcre_internal.h
DEPS_19 += build/$(CONFIG)/inc/me.h
DEPS_19 += build/$(CONFIG)/inc/ucp.h
DEPS_19 += build/$(CONFIG)/inc/ucpinternal.h
DEPS_19 += build/$(CONFIG)/inc/ucptable.h
DEPS_19 += build/$(CONFIG)/obj/pcre_chartables.o
DEPS_19 += build/$(CONFIG)/obj/pcre_compile.o
DEPS_19 += build/$(CONFIG)/obj/pcre_exec.o
DEPS_19 += build/$(CONFIG)/obj/pcre_globals.o
DEPS_19 += build/$(CONFIG)/obj/pcre_newline.o
DEPS_19 += build/$(CONFIG)/obj/pcre_ord2utf8.o
DEPS_19 += build/$(CONFIG)/obj/pcre_tables.o
DEPS_19 += build/$(CONFIG)/obj/pcre_try_flipped.o
DEPS_19 += build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o
DEPS_19 += build/$(CONFIG)/obj/pcre_valid_utf8.o
DEPS_19 += build/$(CONFIG)/obj/pcre_xclass.o

build/$(CONFIG)/bin/libpcre.dylib: $(DEPS_19)
	@echo '      [Link] build/$(CONFIG)/bin/libpcre.dylib'
	$(CC) -dynamiclib -o build/$(CONFIG)/bin/libpcre.dylib -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libpcre.dylib -compatibility_version 1.0 -current_version 1.0 "build/$(CONFIG)/obj/pcre_chartables.o" "build/$(CONFIG)/obj/pcre_compile.o" "build/$(CONFIG)/obj/pcre_exec.o" "build/$(CONFIG)/obj/pcre_globals.o" "build/$(CONFIG)/obj/pcre_newline.o" "build/$(CONFIG)/obj/pcre_ord2utf8.o" "build/$(CONFIG)/obj/pcre_tables.o" "build/$(CONFIG)/obj/pcre_try_flipped.o" "build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o" "build/$(CONFIG)/obj/pcre_valid_utf8.o" "build/$(CONFIG)/obj/pcre_xclass.o" $(LIBS) 

#
#   stop
#
stop: $(DEPS_20)

#
#   installBinary
#
installBinary: $(DEPS_21)

#
#   start
#
start: $(DEPS_22)

#
#   install
#
DEPS_23 += stop
DEPS_23 += installBinary
DEPS_23 += start

install: $(DEPS_23)

#
#   uninstall
#
DEPS_24 += stop

uninstall: $(DEPS_24)

#
#   version
#
version: $(DEPS_25)
	echo 1.0.3

