#
#	Makefile for the pcre distributions
#
#	Copyright (c) Embedthis Software LLC, 2003-2009. All Rights Reserved.
#

include			.makedep

STAGING			:= $(PWD)/staging
TDIR			:= $(STAGING)/pcre-$(BLD_VERSION)
REL_DIR			:= $(BLD_OUT_DIR)/releases
DIST_VER_NAME	:= pcre-$(BLD_VERSION)-dist.tgz
DIST_PERM_NAME	:= pcre-dist.tgz
DIST_VER		:= $(REL_DIR)/$(DIST_VER_NAME)
DIST_PERM		:= $(REL_DIR)/$(DIST_PERM_NAME)
DEST			:= $(TDIR)/src/deps/pcre
INC_DEST		:= $(TDIR)/src/include
DOC_DEST		:= $(TDIR)/doc
TARGETS			+= $(patsubst %,$(INC_DEST)/%, pcre.h)
TARGETS			+= $(patsubst %,$(DEST)/%, pcre.c)

#
#	Order of headers matters
#
HEADERS			+= ../src/include/pcre.h
PCRE_SOURCES	+= $(patsubst %,../src/%, config.h pcre_internal.h ucp.h ucpinternal.h ucptable.h *.c)

dist packageExtra: prep $(TARGETS) $(DIST_VER) cleanup

prep:
	rm -fr $(STAGING) $(DIST_VER) $(DIST_PERM)
	rm -fr $(STAGING) $(DIST_VER) $(DIST_PERM)
	mkdir -p $(REL_DIR) $(DEST) $(INC_DEST) $(DOC_DEST)/man

$(INC_DEST)/pcre.h: Makefile $(HEADERS)
	dist $(HEADERS) | egrep -v '#include.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >$(INC_DEST)/pcre.h

$(DEST)/pcre.c: Makefile $(HEADERS) $(PCRE_SOURCES)
	echo -e '#include "buildConfig.h"\n#include "pcre.h"' >$(DEST)/pcre.c
	dist $(PCRE_SOURCES) | egrep -v '#inc.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >>$(DEST)/pcre.c

$(DIST_VER): 
	@$(call log) "[PACKAGE]" "Make pcre-dist.tgz"
	cp $(BLD_TOP)/doc/man/*.3 $(TDIR)/doc/man
	cp Makefile.dist $(DEST)/Makefile
	@$(call log) "[Generate]" "tar cfz $(DIST_VER) -C $(STAGING) ."
	tar cfz $(DIST_VER) -C $(STAGING) .
	cd $(REL_DIR) ; ln -s $(DIST_VER_NAME) $(DIST_PERM_NAME)

cleanup:
	rm -rf $(STAGING)

cleanExtra:
	rm -rf $(STAGING) $(REL_DIR)/*.tgz
