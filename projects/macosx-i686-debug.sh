#
#   macosx-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

PLATFORM="macosx-i686-debug"
CC="cc"
LD="/usr/bin/ld"
CFLAGS="-fPIC -Wall -g"
DFLAGS="-DPIC -DBLD_FEATURE_PCRE=1 -DCPU=I686"
IFLAGS="-Imacosx-i686-debug/inc"
LDFLAGS="-Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl
LIBS="-lpthread -lm"

[ ! -x ${PLATFORM}/inc ] && mkdir -p ${PLATFORM}/inc ${PLATFORM}/obj ${PLATFORM}/lib ${PLATFORM}/bin
[ ! -f ${PLATFORM}/inc/buildConfig.h ] && cp projects/buildConfig.${PLATFORM} ${PLATFORM}/inc/buildConfig.h

rm -rf macosx-i686-debug/inc/config.h
cp -r src/config.h macosx-i686-debug/inc/config.h

rm -rf macosx-i686-debug/inc/pcre.h
cp -r src/pcre.h macosx-i686-debug/inc/pcre.h

rm -rf macosx-i686-debug/inc/pcre_internal.h
cp -r src/pcre_internal.h macosx-i686-debug/inc/pcre_internal.h

rm -rf macosx-i686-debug/inc/ucp.h
cp -r src/ucp.h macosx-i686-debug/inc/ucp.h

rm -rf macosx-i686-debug/inc/ucpinternal.h
cp -r src/ucpinternal.h macosx-i686-debug/inc/ucpinternal.h

rm -rf macosx-i686-debug/inc/ucptable.h
cp -r src/ucptable.h macosx-i686-debug/inc/ucptable.h

${CC} -c -o ${PLATFORM}/obj/pcre_chartables.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_chartables.c

${CC} -c -o ${PLATFORM}/obj/pcre_compile.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_compile.c

${CC} -c -o ${PLATFORM}/obj/pcre_exec.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_exec.c

${CC} -c -o ${PLATFORM}/obj/pcre_globals.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_globals.c

${CC} -c -o ${PLATFORM}/obj/pcre_newline.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_newline.c

${CC} -c -o ${PLATFORM}/obj/pcre_ord2utf8.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_ord2utf8.c

${CC} -c -o ${PLATFORM}/obj/pcre_tables.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_tables.c

${CC} -c -o ${PLATFORM}/obj/pcre_try_flipped.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_try_flipped.c

${CC} -c -o ${PLATFORM}/obj/pcre_ucp_searchfuncs.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${PLATFORM}/obj/pcre_valid_utf8.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_valid_utf8.c

${CC} -c -o ${PLATFORM}/obj/pcre_xclass.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_xclass.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libpcre.dylib -arch i686 ${LDFLAGS} -install_name @rpath/libpcre.dylib ${PLATFORM}/obj/pcre_chartables.o ${PLATFORM}/obj/pcre_compile.o ${PLATFORM}/obj/pcre_exec.o ${PLATFORM}/obj/pcre_globals.o ${PLATFORM}/obj/pcre_newline.o ${PLATFORM}/obj/pcre_ord2utf8.o ${PLATFORM}/obj/pcre_tables.o ${PLATFORM}/obj/pcre_try_flipped.o ${PLATFORM}/obj/pcre_ucp_searchfuncs.o ${PLATFORM}/obj/pcre_valid_utf8.o ${PLATFORM}/obj/pcre_xclass.o ${LIBS}

