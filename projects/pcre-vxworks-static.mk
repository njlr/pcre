#
#   pcre-vxworks-static.mk -- Makefile to build PCRE Library for vxworks
#

NAME                  := pcre
VERSION               := 1.0.3
PROFILE               ?= static
ARCH                  ?= $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                   ?= $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                    ?= vxworks
CC                    ?= cc$(subst x86,pentium,$(ARCH))
LD                    ?= ld
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
BUILD                 ?= build/$(CONFIG)
LBIN                  ?= $(BUILD)/bin
PATH                  := $(LBIN):$(PATH)

ME_COM_WINSDK         ?= 1


ME_COM_COMPILER_PATH  ?= cc$(subst x86,pentium,$(ARCH))
ME_COM_LIB_PATH       ?= ar
ME_COM_LINK_PATH      ?= ld
ME_COM_VXWORKS_PATH   ?= $(WIND_BASE)

export WIND_HOME      ?= $(WIND_BASE)/..
export PATH           := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS                += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS                += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) -DME_COM_WINSDK=$(ME_COM_WINSDK) 
IFLAGS                += "-Ibuild/$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS               += '-Wl,-r'
LIBPATHS              += -Lbuild/$(CONFIG)/bin
LIBS                  += -lgcc

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

ME_ROOT_PREFIX        ?= deploy
ME_BASE_PREFIX        ?= $(ME_ROOT_PREFIX)
ME_DATA_PREFIX        ?= $(ME_VAPP_PREFIX)
ME_STATE_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_BIN_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_INC_PREFIX         ?= $(ME_VAPP_PREFIX)/inc
ME_LIB_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_MAN_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_SBIN_PREFIX        ?= $(ME_VAPP_PREFIX)
ME_ETC_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_WEB_PREFIX         ?= $(ME_VAPP_PREFIX)/web
ME_LOG_PREFIX         ?= $(ME_VAPP_PREFIX)
ME_SPOOL_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_CACHE_PREFIX       ?= $(ME_VAPP_PREFIX)
ME_APP_PREFIX         ?= $(ME_BASE_PREFIX)
ME_VAPP_PREFIX        ?= $(ME_APP_PREFIX)
ME_SRC_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/src/$(NAME)-$(VERSION)


TARGETS               += build/$(CONFIG)/bin/libpcre.a

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
	@if [ "$(WIND_BASE)" = "" ] ; then echo WARNING: WIND_BASE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_HOST_TYPE)" = "" ] ; then echo WARNING: WIND_HOST_TYPE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_GNU_PATH)" = "" ] ; then echo WARNING: WIND_GNU_PATH not set. Run wrenv.sh. ; exit 255 ; fi
	@[ ! -x $(BUILD)/bin ] && mkdir -p $(BUILD)/bin; true
	@[ ! -x $(BUILD)/inc ] && mkdir -p $(BUILD)/inc; true
	@[ ! -x $(BUILD)/obj ] && mkdir -p $(BUILD)/obj; true
	@[ ! -f $(BUILD)/inc/me.h ] && cp projects/pcre-vxworks-static-me.h $(BUILD)/inc/me.h ; true
	@if ! diff $(BUILD)/inc/me.h projects/pcre-vxworks-static-me.h >/dev/null ; then\
		cp projects/pcre-vxworks-static-me.h $(BUILD)/inc/me.h  ; \
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
	rm -f "build/$(CONFIG)/bin/libpcre.a"

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
	$(CC) -c -o build/$(CONFIG)/obj/pcre_chartables.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_chartables.c

#
#   pcre_compile.o
#
DEPS_9 += build/$(CONFIG)/inc/me.h
DEPS_9 += build/$(CONFIG)/inc/config.h
DEPS_9 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_compile.o: \
    src/pcre_compile.c $(DEPS_9)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_compile.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_compile.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_compile.c

#
#   pcre_exec.o
#
DEPS_10 += build/$(CONFIG)/inc/me.h
DEPS_10 += build/$(CONFIG)/inc/config.h
DEPS_10 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_exec.o: \
    src/pcre_exec.c $(DEPS_10)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_exec.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_exec.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_exec.c

#
#   pcre_globals.o
#
DEPS_11 += build/$(CONFIG)/inc/me.h
DEPS_11 += build/$(CONFIG)/inc/config.h
DEPS_11 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_globals.o: \
    src/pcre_globals.c $(DEPS_11)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_globals.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_globals.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_globals.c

#
#   pcre_newline.o
#
DEPS_12 += build/$(CONFIG)/inc/me.h
DEPS_12 += build/$(CONFIG)/inc/config.h
DEPS_12 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_newline.o: \
    src/pcre_newline.c $(DEPS_12)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_newline.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_newline.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_newline.c

#
#   pcre_ord2utf8.o
#
DEPS_13 += build/$(CONFIG)/inc/me.h
DEPS_13 += build/$(CONFIG)/inc/config.h
DEPS_13 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_ord2utf8.o: \
    src/pcre_ord2utf8.c $(DEPS_13)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_ord2utf8.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_ord2utf8.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_ord2utf8.c

#
#   pcre_tables.o
#
DEPS_14 += build/$(CONFIG)/inc/me.h
DEPS_14 += build/$(CONFIG)/inc/config.h
DEPS_14 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_tables.o: \
    src/pcre_tables.c $(DEPS_14)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_tables.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_tables.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_tables.c

#
#   pcre_try_flipped.o
#
DEPS_15 += build/$(CONFIG)/inc/me.h
DEPS_15 += build/$(CONFIG)/inc/config.h
DEPS_15 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_try_flipped.o: \
    src/pcre_try_flipped.c $(DEPS_15)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_try_flipped.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_try_flipped.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_try_flipped.c

#
#   pcre_ucp_searchfuncs.o
#
DEPS_16 += build/$(CONFIG)/inc/me.h
DEPS_16 += build/$(CONFIG)/inc/config.h
DEPS_16 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
    src/pcre_ucp_searchfuncs.c $(DEPS_16)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_ucp_searchfuncs.c

#
#   pcre_valid_utf8.o
#
DEPS_17 += build/$(CONFIG)/inc/me.h
DEPS_17 += build/$(CONFIG)/inc/config.h
DEPS_17 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_valid_utf8.o: \
    src/pcre_valid_utf8.c $(DEPS_17)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_valid_utf8.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_valid_utf8.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_valid_utf8.c

#
#   pcre_xclass.o
#
DEPS_18 += build/$(CONFIG)/inc/me.h
DEPS_18 += build/$(CONFIG)/inc/config.h
DEPS_18 += build/$(CONFIG)/inc/pcre_internal.h

build/$(CONFIG)/obj/pcre_xclass.o: \
    src/pcre_xclass.c $(DEPS_18)
	@echo '   [Compile] build/$(CONFIG)/obj/pcre_xclass.o'
	$(CC) -c -o build/$(CONFIG)/obj/pcre_xclass.o $(CFLAGS) $(DFLAGS) "-Ibuild/$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_xclass.c

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

build/$(CONFIG)/bin/libpcre.a: $(DEPS_19)
	@echo '      [Link] build/$(CONFIG)/bin/libpcre.a'
	ar -cr build/$(CONFIG)/bin/libpcre.a "build/$(CONFIG)/obj/pcre_chartables.o" "build/$(CONFIG)/obj/pcre_compile.o" "build/$(CONFIG)/obj/pcre_exec.o" "build/$(CONFIG)/obj/pcre_globals.o" "build/$(CONFIG)/obj/pcre_newline.o" "build/$(CONFIG)/obj/pcre_ord2utf8.o" "build/$(CONFIG)/obj/pcre_tables.o" "build/$(CONFIG)/obj/pcre_try_flipped.o" "build/$(CONFIG)/obj/pcre_ucp_searchfuncs.o" "build/$(CONFIG)/obj/pcre_valid_utf8.o" "build/$(CONFIG)/obj/pcre_xclass.o"

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

