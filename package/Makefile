#
#	Makefile for the all-in-one pcre distribution
#
#	Copyright (c) Embedthis Software LLC, 2003-2009. All Rights Reserved.
#

STAGING			:= staging
DEST			:= $(STAGING)/src/deps/pcre
INC_DEST		:= $(STAGING)/src/include
DOC_DEST		:= $(STAGING)/doc
TARGETS			+= $(patsubst %,$(INC_DEST)/%, pcre.h)
TARGETS			+= $(patsubst %,$(DEST)/%, pcre.c)
ARCHIVE			+= $(BLD_TOP)/releases/pcre-all.tgz

include			.makedep

#
#	Order of headers matters
#
HEADERS			+= ../src/include/pcre.h
PCRE_SOURCES	+= $(patsubst %,../src/%, config.h pcre_internal.h ucp.h ucpinternal.h ucptable.h *.c)

packageExtra: 	prep $(TARGETS) $(ARCHIVE)

prep:
	rm -fr $(STAGING)
	mkdir -p ../releases
	mkdir -p $(DEST) $(INC_DEST) $(DOC_DEST)/man

$(INC_DEST)/pcre.h: Makefile $(HEADERS)
	all-in-one $(HEADERS) | egrep -v '#include.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >$(INC_DEST)/pcre.h

$(DEST)/pcre.c: Makefile $(HEADERS) $(PCRE_SOURCES)
	echo '#include "pcre.h"' >$(DEST)/pcre.c
	all-in-one $(HEADERS) $(PCRE_SOURCES) | egrep -v '#inc.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >>$(DEST)/pcre.c

$(ARCHIVE): Makefile $(TARGETS)
	cp $(BLD_TOP)/doc/man/*.3 $(STAGING)/doc/man
	cp Makefile.all $(DEST)/Makefile
	@$(call log) "[Generate]" "tar cfz $(ARCHIVE) -C $(STAGING) ."
	tar cfz $(ARCHIVE) -C $(STAGING) .
	rm -fr $(STAGING)

cleanExtra:
	rm -rf $(STAGING)
