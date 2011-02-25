#
#	Makefile for the pcre distributions
#
#	Copyright (c) Embedthis Software LLC, 2003-2009. All Rights Reserved.
#

include			.makedep

STAGE_DIR		:= $(BLD_OUT_DIR)/dist
REL_DIR			:= $(BLD_OUT_DIR)/releases
TDIR			:= $(STAGE_DIR)/pcre-$(BLD_VERSION)
VNAME			:= pcre-$(BLD_VERSION)
DIST_VER_NAME	:= $(VNAME)-dist.tgz
DIST_PERM_NAME	:= pcre-dist.tgz
DEST			:= $(TDIR)/src/deps/pcre
# INC_DEST		:= $(TDIR)/src/include
INC_DEST		:= $(DEST)
DOC_DEST		:= $(TDIR)/doc
TARGETS			+= $(patsubst %,$(INC_DEST)/%, pcre.h)
TARGETS			+= $(patsubst %,$(DEST)/%, pcre.c)

#
#	Order of headers matters
#
HEADERS			+= ../src/include/pcre.h
PCRE_SOURCES	+= $(patsubst %,../src/%, config.h pcre_internal.h ucp.h ucpinternal.h ucptable.h *.c)

dist packageExtra: clean prep $(TARGETS) $(REL_DIR)/$(DIST_VER_NAME) cleanup

prep:
	mkdir -p $(STAGE_DIR) $(REL_DIR) $(DEST) $(INC_DEST) $(DOC_DEST)

$(INC_DEST)/pcre.h: Makefile $(HEADERS)
	dist $(HEADERS) | egrep -v '#include.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >$(INC_DEST)/pcre.h

$(DEST)/pcre.c: Makefile $(HEADERS) $(PCRE_SOURCES)
	echo -e '#include "buildConfig.h"\n#include "pcre.h"' >$(DEST)/pcre.c
	dist $(PCRE_SOURCES) | egrep -v '#inc.*mpr|#inc.*config.h|#inc.*ucp.*\.h|#inc.*pcre' >>$(DEST)/pcre.c

$(REL_DIR)/$(DIST_VER_NAME): 
	$(call log) "[PACKAGE]" "Make pcre-dist.tgz"
	cp $(BLD_TOP)/doc/man/*.3 $(TDIR)/doc/man
	cp Makefile.dist $(DEST)/Makefile
	$(call log) "[Generate]" "tar cfz $(REL_DIR)/$(DIST_VER_NAME) -C $(STAGE_DIR) ."
	tar cfz $(REL_DIR)/$(DIST_VER_NAME) -C $(STAGE_DIR) .
	ln -s $(DIST_VER_NAME) $(REL_DIR)/$(DIST_PERM_NAME)

cleanExtra:
	rm -fr $(STAGE_DIR) $(REL_DIR)/$(DIST_VER_NAME) $(REL_DIR)/$(DIST_PERM_NAME)

cleanup:
	rm -fr $(STAGE_DIR)

#
#   Local variables:
#   tab-width: 4
#   c-basic-offset: 4
#   End:
#   vim: sw=4 ts=4 noexpandtab
#
