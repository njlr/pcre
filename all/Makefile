#
#	Makefile for the all-in-one pcre distribution
#
#	Copyright (c) Embedthis Software LLC, 2003-2009. All Rights Reserved.
#

include			.makedep

COMPILE			=
TARGETS			+= pcre.c pcre.h

compileExtra: 	$(TARGETS) dummy

#
#	Order of headers matters
#
HEADERS			+= ../src/include/pcre.h
PCRE_SOURCES	+= $(patsubst %,../src/%, config.h pcre_internal.h ucp.h ucpinternal.h ucptable.h *.c)

pcre.h: Makefile $(HEADERS)
	$(call log) "[Generate]" all/pcre.h
	all-in-one $(HEADERS) | egrep -v '#include.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >pcre.h

pcre.c: Makefile $(HEADERS) $(PCRE_SOURCES)
	$(call log) "[Generate]" all/pcre.c
	echo "#define BLD_ALL_IN_ONE 1" >pcre.c
	echo '#include "pcre.h"' >pcre.c
	all-in-one $(HEADERS) $(PCRE_SOURCES) | egrep -v '#inc.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >>pcre.c

cleanExtra:
	rm -f *.c *.h
