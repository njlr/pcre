#
#	Makefile to build the regular expression support
#
#	Copyright (c) Embedthis Software LLC, 2003-2009. All Rights Reserved.
#

include 		.makedep

ifneq ($(BLD_FEATURE_PCRE),)
	IMPORTS 	+= $(BLD_PCRE) $(BLD_MATRIXSSL_IMPORTS)
	IMPORTED	+= $(patsubst %,$(BLD_LIB_DIR)/%, $(notdir $(IMPORTS)))
endif

TARGETS			+= $(BLD_LIB_DIR)/libpcre$(BLD_LIB)

compileExtra:	$(IMPORTS) $(TARGETS)

$(BLD_LIB_DIR)/libpcre$(BLD_LIB): $(PCRE_OBJECTS)
	bld --library $(BLD_LIB_DIR)/libpcre --search "$(BLD_PCRE_LIBPATHS)" --libs "$(BLD_PCRE_WITHLIBS)" $(OBJECTS)

$(IMPORTED): $(IMPORTS)
	getlib $<

#
#   Local variables:
#   tab-width: 4
#   c-basic-offset: 4
#   End:
#   vim: sw=4 ts=4 noexpandtab
#
