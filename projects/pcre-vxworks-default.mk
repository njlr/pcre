#
#   pcre-vxworks-default.mk -- Makefile to build PCRE Library for vxworks
#

NAME                  := pcre
VERSION               := 1.0.3
PROFILE               ?= default
ARCH                  ?= $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                   ?= $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                    ?= vxworks
CC                    ?= cc$(subst x86,pentium,$(ARCH))
LD                    ?= ld
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
LBIN                  ?= $(CONFIG)/bin
PATH                  := $(LBIN):$(PATH)


ME_EXT_COMPILER_PATH  ?= cc$(subst x86,pentium,$(ARCH))
ME_EXT_LIB_PATH       ?= ar
ME_EXT_LINK_PATH      ?= ld
ME_EXT_VXWORKS_PATH   ?= $(WIND_BASE)

export WIND_HOME      ?= $(WIND_BASE)/..
export PATH           := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS                += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS                += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) 
IFLAGS                += "-I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS               += '-Wl,-r'
LIBPATHS              += -L$(CONFIG)/bin
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


TARGETS               += $(CONFIG)/bin/libpcre.out

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
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/me.h ] && cp projects/pcre-vxworks-default-me.h $(CONFIG)/inc/me.h ; true
	@if ! diff $(CONFIG)/inc/me.h projects/pcre-vxworks-default-me.h >/dev/null ; then\
		cp projects/pcre-vxworks-default-me.h $(CONFIG)/inc/me.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libpcre.out"
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
	echo 1.0.3

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
#   me.h
#
$(CONFIG)/inc/me.h: $(DEPS_5)
	@echo '      [Copy] $(CONFIG)/inc/me.h'

#
#   ucp.h
#
DEPS_6 += $(CONFIG)/inc/me.h

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
DEPS_9 += $(CONFIG)/inc/me.h
DEPS_9 += $(CONFIG)/inc/config.h
DEPS_9 += $(CONFIG)/inc/pcre_internal.h
DEPS_9 += $(CONFIG)/inc/pcre.h
DEPS_9 += $(CONFIG)/inc/ucp.h

$(CONFIG)/obj/pcre_chartables.o: \
    src/pcre_chartables.c $(DEPS_9)
	@echo '   [Compile] $(CONFIG)/obj/pcre_chartables.o'
	 -c -o $(CONFIG)/obj/pcre_chartables.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_chartables.c

#
#   pcre_compile.o
#
DEPS_10 += $(CONFIG)/inc/me.h
DEPS_10 += $(CONFIG)/inc/config.h
DEPS_10 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_compile.o: \
    src/pcre_compile.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/pcre_compile.o'
	 -c -o $(CONFIG)/obj/pcre_compile.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_compile.c

#
#   pcre_exec.o
#
DEPS_11 += $(CONFIG)/inc/me.h
DEPS_11 += $(CONFIG)/inc/config.h
DEPS_11 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_exec.o: \
    src/pcre_exec.c $(DEPS_11)
	@echo '   [Compile] $(CONFIG)/obj/pcre_exec.o'
	 -c -o $(CONFIG)/obj/pcre_exec.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_exec.c

#
#   pcre_globals.o
#
DEPS_12 += $(CONFIG)/inc/me.h
DEPS_12 += $(CONFIG)/inc/config.h
DEPS_12 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_globals.o: \
    src/pcre_globals.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/pcre_globals.o'
	 -c -o $(CONFIG)/obj/pcre_globals.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_globals.c

#
#   pcre_newline.o
#
DEPS_13 += $(CONFIG)/inc/me.h
DEPS_13 += $(CONFIG)/inc/config.h
DEPS_13 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_newline.o: \
    src/pcre_newline.c $(DEPS_13)
	@echo '   [Compile] $(CONFIG)/obj/pcre_newline.o'
	 -c -o $(CONFIG)/obj/pcre_newline.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_newline.c

#
#   pcre_ord2utf8.o
#
DEPS_14 += $(CONFIG)/inc/me.h
DEPS_14 += $(CONFIG)/inc/config.h
DEPS_14 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_ord2utf8.o: \
    src/pcre_ord2utf8.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/pcre_ord2utf8.o'
	 -c -o $(CONFIG)/obj/pcre_ord2utf8.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_ord2utf8.c

#
#   pcre_tables.o
#
DEPS_15 += $(CONFIG)/inc/me.h
DEPS_15 += $(CONFIG)/inc/config.h
DEPS_15 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_tables.o: \
    src/pcre_tables.c $(DEPS_15)
	@echo '   [Compile] $(CONFIG)/obj/pcre_tables.o'
	 -c -o $(CONFIG)/obj/pcre_tables.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_tables.c

#
#   pcre_try_flipped.o
#
DEPS_16 += $(CONFIG)/inc/me.h
DEPS_16 += $(CONFIG)/inc/config.h
DEPS_16 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_try_flipped.o: \
    src/pcre_try_flipped.c $(DEPS_16)
	@echo '   [Compile] $(CONFIG)/obj/pcre_try_flipped.o'
	 -c -o $(CONFIG)/obj/pcre_try_flipped.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_try_flipped.c

#
#   pcre_ucp_searchfuncs.o
#
DEPS_17 += $(CONFIG)/inc/me.h
DEPS_17 += $(CONFIG)/inc/config.h
DEPS_17 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_ucp_searchfuncs.o: \
    src/pcre_ucp_searchfuncs.c $(DEPS_17)
	@echo '   [Compile] $(CONFIG)/obj/pcre_ucp_searchfuncs.o'
	 -c -o $(CONFIG)/obj/pcre_ucp_searchfuncs.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_ucp_searchfuncs.c

#
#   pcre_valid_utf8.o
#
DEPS_18 += $(CONFIG)/inc/me.h
DEPS_18 += $(CONFIG)/inc/config.h
DEPS_18 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_valid_utf8.o: \
    src/pcre_valid_utf8.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre_valid_utf8.o'
	 -c -o $(CONFIG)/obj/pcre_valid_utf8.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_valid_utf8.c

#
#   pcre_xclass.o
#
DEPS_19 += $(CONFIG)/inc/me.h
DEPS_19 += $(CONFIG)/inc/config.h
DEPS_19 += $(CONFIG)/inc/pcre_internal.h

$(CONFIG)/obj/pcre_xclass.o: \
    src/pcre_xclass.c $(DEPS_19)
	@echo '   [Compile] $(CONFIG)/obj/pcre_xclass.o'
	 -c -o $(CONFIG)/obj/pcre_xclass.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/pcre_xclass.c

#
#   libpcre
#
DEPS_20 += $(CONFIG)/inc/config.h
DEPS_20 += $(CONFIG)/inc/pcre.h
DEPS_20 += $(CONFIG)/inc/pcre_internal.h
DEPS_20 += $(CONFIG)/inc/me.h
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

$(CONFIG)/bin/libpcre.out: $(DEPS_20)
	@echo '      [Link] $(CONFIG)/bin/libpcre.out'
	 -r -o $(CONFIG)/bin/libpcre.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/pcre_chartables.o" "$(CONFIG)/obj/pcre_compile.o" "$(CONFIG)/obj/pcre_exec.o" "$(CONFIG)/obj/pcre_globals.o" "$(CONFIG)/obj/pcre_newline.o" "$(CONFIG)/obj/pcre_ord2utf8.o" "$(CONFIG)/obj/pcre_tables.o" "$(CONFIG)/obj/pcre_try_flipped.o" "$(CONFIG)/obj/pcre_ucp_searchfuncs.o" "$(CONFIG)/obj/pcre_valid_utf8.o" "$(CONFIG)/obj/pcre_xclass.o" $(LIBS) 

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

