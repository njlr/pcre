#
#   pcre-freebsd-static.mk -- Makefile to build PCRE Library for freebsd
#

PRODUCT            := pcre
VERSION            := 1.0.1
BUILD_NUMBER       := 0
PROFILE            := static
ARCH               := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH            := $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                 := freebsd
CC                 := gcc
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin


ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif

BIT_PACK_COMPILER_PATH    := gcc
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link

CFLAGS             += -fPIC -w
DFLAGS             += -D_REENTRANT -DPIC $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) 
IFLAGS             += "-I$(CONFIG)/inc"
LDFLAGS            += 
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -ldl -lpthread -lm

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := 
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local
BIT_DATA_PREFIX    := $(BIT_ROOT_PREFIX)/
BIT_STATE_PREFIX   := $(BIT_ROOT_PREFIX)/var
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)/lib/$(PRODUCT)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)/$(VERSION)
BIT_BIN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/bin
BIT_INC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/include
BIT_LIB_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/lib
BIT_MAN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/share/man
BIT_SBIN_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local/sbin
BIT_ETC_PREFIX     := $(BIT_ROOT_PREFIX)/etc/$(PRODUCT)
BIT_WEB_PREFIX     := $(BIT_ROOT_PREFIX)/var/www/$(PRODUCT)-default
BIT_LOG_PREFIX     := $(BIT_ROOT_PREFIX)/var/log/$(PRODUCT)
BIT_SPOOL_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)
BIT_CACHE_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)/cache
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libpcre.a

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/pcre-freebsd-static-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/pcre-freebsd-static-bit.h >/dev/null ; then\
		cp projects/pcre-freebsd-static-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libpcre.a"
	rm -f "$(CONFIG)/obj/pcre_chartables.o"
	rm -f "$(CONFIG)/obj/pcre_compile.o"
	rm -f "$(CONFIG)/obj/pcre_exec.o"
	rm -f "$(CONFIG)/obj/pcre_globals.o"
	rm -f "$(CONFIG)/obj/pcre_newline.o"
	rm -f "$(CONFIG)/obj/pcre_ord2utf8.o"
	rm -f "$(CONFIG)/obj/pcre_tables.o"
	rm -f "$(CONFIG)/obj/pcre_try_flipped.o"
	rm -f "$(CONFIG)/obj/pcre_ucp_searchfuncs.o"
	rm -f "$(CONFIG)/obj/pcre_valid_utf8.o"
	rm -f "$(CONFIG)/obj/pcre_xclass.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	echo 1.0.1-0

#
#   config.h
#
$(CONFIG)/inc/config.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/config.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/config.h $(CONFIG)/inc/config.h

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre_internal.h
#
$(CONFIG)/inc/pcre_internal.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/pcre_internal.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/pcre_internal.h $(CONFIG)/inc/pcre_internal.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_5)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   ucp.h
#
DEPS_6 += $(CONFIG)/inc/bit.h

$(CONFIG)/inc/ucp.h: $(DEPS_6)
	@echo '      [Copy] $(CONFIG)/inc/ucp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ucp.h $(CONFIG)/inc/ucp.h

#
#   ucpinternal.h
#
$(CONFIG)/inc/ucpinternal.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/ucpinternal.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ucpinternal.h $(CONFIG)/inc/ucpinternal.h

#
#   ucptable.h
#
$(CONFIG)/inc/ucptable.h: $(DEPS_8)
	@echo '      [Copy] $(CONFIG)/inc/ucptable.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ucptable.h $(CONFIG)/inc/ucptable.h

#
#   pcre_chartables.o
#
DEPS_9 += $(CONFIG)/inc/bit.h
DEPS_9 += $(CONFIG)/inc/config.h
DEPS_9 += $(CONFIG)/inc/pcre_internal.h
DEPS_9 += $(CONFIG)/inc/pcre.h
DEPS_9 += $(CONFIG)/inc/ucp.h

$(CONFIG)/obj/pcre_chartables.o: \
    src/pcre_chartables.c $(DEPS_9)
	@echo '   [Compile] $(CONFIG)/obj/pcre_chartables.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_chartables.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_chartables.c

#
#   pcre_compile.o
#
DEPS_10 += $(CONFIG)/inc/bit.h
DEPS_10 += $(CONFIG)/inc/config.h
DEPS_10 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_compile.o: \
    src/pcre_compile.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/pcre_compile.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_compile.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_compile.c

#
#   pcre_exec.o
#
DEPS_11 += $(CONFIG)/inc/bit.h
DEPS_11 += $(CONFIG)/inc/config.h
DEPS_11 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_exec.o: \
    src/pcre_exec.c $(DEPS_11)
	@echo '   [Compile] $(CONFIG)/obj/pcre_exec.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_exec.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_exec.c

#
#   pcre_globals.o
#
DEPS_12 += $(CONFIG)/inc/bit.h
DEPS_12 += $(CONFIG)/inc/config.h
DEPS_12 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_globals.o: \
    src/pcre_globals.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/pcre_globals.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_globals.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_globals.c

#
#   pcre_newline.o
#
DEPS_13 += $(CONFIG)/inc/bit.h
DEPS_13 += $(CONFIG)/inc/config.h
DEPS_13 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_newline.o: \
    src/pcre_newline.c $(DEPS_13)
	@echo '   [Compile] $(CONFIG)/obj/pcre_newline.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_newline.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_newline.c

#
#   pcre_ord2utf8.o
#
DEPS_14 += $(CONFIG)/inc/bit.h
DEPS_14 += $(CONFIG)/inc/config.h
DEPS_14 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_ord2utf8.o: \
    src/pcre_ord2utf8.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/pcre_ord2utf8.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_ord2utf8.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_ord2utf8.c

#
#   pcre_tables.o
#
DEPS_15 += $(CONFIG)/inc/bit.h
DEPS_15 += $(CONFIG)/inc/config.h
DEPS_15 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_tables.o: \
    src/pcre_tables.c $(DEPS_15)
	@echo '   [Compile] $(CONFIG)/obj/pcre_tables.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_tables.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_tables.c

#
#   pcre_try_flipped.o
#
DEPS_16 += $(CONFIG)/inc/bit.h
DEPS_16 += $(CONFIG)/inc/config.h
DEPS_16 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_try_flipped.o: \
    src/pcre_try_flipped.c $(DEPS_16)
	@echo '   [Compile] $(CONFIG)/obj/pcre_try_flipped.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_try_flipped.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_try_flipped.c

#
#   pcre_ucp_searchfuncs.o
#
DEPS_17 += $(CONFIG)/inc/bit.h
DEPS_17 += $(CONFIG)/inc/config.h
DEPS_17 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
    src/pcre_ucp_searchfuncs.c $(DEPS_17)
	@echo '   [Compile] $(CONFIG)/obj/pcre_ucp_searchfuncs.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_ucp_searchfuncs.c

#
#   pcre_valid_utf8.o
#
DEPS_18 += $(CONFIG)/inc/bit.h
DEPS_18 += $(CONFIG)/inc/config.h
DEPS_18 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_valid_utf8.o: \
    src/pcre_valid_utf8.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre_valid_utf8.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_valid_utf8.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_valid_utf8.c

#
#   pcre_xclass.o
#
DEPS_19 += $(CONFIG)/inc/bit.h
DEPS_19 += $(CONFIG)/inc/config.h
DEPS_19 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_xclass.o: \
    src/pcre_xclass.c $(DEPS_19)
	@echo '   [Compile] $(CONFIG)/obj/pcre_xclass.o'
	$(CC) -c -o $(CONFIG)/obj/pcre_xclass.o $(CFLAGS) $(DFLAGS) $(IFLAGS) src/pcre_xclass.c

#
#   libpcre
#
DEPS_20 += $(CONFIG)/inc/config.h
DEPS_20 += $(CONFIG)/inc/pcre.h
DEPS_20 += $(CONFIG)/inc/pcre_internal.h
DEPS_20 += $(CONFIG)/inc/bit.h
DEPS_20 += $(CONFIG)/inc/ucp.h
DEPS_20 += $(CONFIG)/inc/ucpinternal.h
DEPS_20 += $(CONFIG)/inc/ucptable.h
DEPS_20 += $(CONFIG)/obj/pcre_chartables.o
DEPS_20 += $(CONFIG)/obj/pcre_compile.o
DEPS_20 += $(CONFIG)/obj/pcre_exec.o
DEPS_20 += $(CONFIG)/obj/pcre_globals.o
DEPS_20 += $(CONFIG)/obj/pcre_newline.o
DEPS_20 += $(CONFIG)/obj/pcre_ord2utf8.o
DEPS_20 += $(CONFIG)/obj/pcre_tables.o
DEPS_20 += $(CONFIG)/obj/pcre_try_flipped.o
DEPS_20 += $(CONFIG)/obj/pcre_ucp_searchfuncs.o
DEPS_20 += $(CONFIG)/obj/pcre_valid_utf8.o
DEPS_20 += $(CONFIG)/obj/pcre_xclass.o

$(CONFIG)/bin/libpcre.a: $(DEPS_20)
	@echo '      [Link] $(CONFIG)/bin/libpcre.a'
	ar -cr $(CONFIG)/bin/libpcre.a "$(CONFIG)/obj/pcre_chartables.o" "$(CONFIG)/obj/pcre_compile.o" "$(CONFIG)/obj/pcre_exec.o" "$(CONFIG)/obj/pcre_globals.o" "$(CONFIG)/obj/pcre_newline.o" "$(CONFIG)/obj/pcre_ord2utf8.o" "$(CONFIG)/obj/pcre_tables.o" "$(CONFIG)/obj/pcre_try_flipped.o" "$(CONFIG)/obj/pcre_ucp_searchfuncs.o" "$(CONFIG)/obj/pcre_valid_utf8.o" "$(CONFIG)/obj/pcre_xclass.o"

#
#   stop
#
stop: $(DEPS_21)

#
#   installBinary
#
installBinary: $(DEPS_22)

#
#   start
#
start: $(DEPS_23)

#
#   install
#
DEPS_24 += stop
DEPS_24 += installBinary
DEPS_24 += start

install: $(DEPS_24)

#
#   uninstall
#
DEPS_25 += stop

uninstall: $(DEPS_25)

