#
#   macosx-x86_64-debug.sh -- Build It Shell Script to build PCRE Library
#

CONFIG="macosx-x86_64-debug"
CC="/usr/bin/cc"
LD="/usr/bin/ld"
CFLAGS="-fPIC -Wall -fast -Wshorten-64-to-32"
DFLAGS="-DPIC -DBLD_FEATURE_PCRE=1 -DCPU=X86_64"
IFLAGS="-Imacosx-x86_64-debug/inc -Imacosx-x86_64-debug/inc"
LDFLAGS="-Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/"
LIBPATHS="-L${CONFIG}/lib"
LIBS="-lpthread -lm -ldl"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin
cp projects/buildConfig.${CONFIG} ${CONFIG}/inc/buildConfig.h

rm -rf macosx-x86_64-debug/inc/config.h
cp -r src/config.h macosx-x86_64-debug/inc/config.h

rm -rf macosx-x86_64-debug/inc/pcre.h
cp -r src/pcre.h macosx-x86_64-debug/inc/pcre.h

rm -rf macosx-x86_64-debug/inc/pcre_internal.h
cp -r src/pcre_internal.h macosx-x86_64-debug/inc/pcre_internal.h

rm -rf macosx-x86_64-debug/inc/ucp.h
cp -r src/ucp.h macosx-x86_64-debug/inc/ucp.h

rm -rf macosx-x86_64-debug/inc/ucpinternal.h
cp -r src/ucpinternal.h macosx-x86_64-debug/inc/ucpinternal.h

rm -rf macosx-x86_64-debug/inc/ucptable.h
cp -r src/ucptable.h macosx-x86_64-debug/inc/ucptable.h

${CC} -c -o ${CONFIG}/obj/pcre_chartables.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_chartables.c

${CC} -c -o ${CONFIG}/obj/pcre_compile.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_compile.c

${CC} -c -o ${CONFIG}/obj/pcre_exec.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_exec.c

${CC} -c -o ${CONFIG}/obj/pcre_globals.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_globals.c

${CC} -c -o ${CONFIG}/obj/pcre_newline.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_newline.c

${CC} -c -o ${CONFIG}/obj/pcre_ord2utf8.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ord2utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_tables.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_tables.c

${CC} -c -o ${CONFIG}/obj/pcre_try_flipped.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_try_flipped.c

${CC} -c -o ${CONFIG}/obj/pcre_ucp_searchfuncs.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${CONFIG}/obj/pcre_valid_utf8.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_valid_utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_xclass.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_xclass.c

${CC} -dynamiclib -o ${CONFIG}/lib/libpcre.dylib -arch x86_64 ${LDFLAGS} ${LIBPATHS} -install_name @rpath/libpcre.dylib ${CONFIG}/obj/pcre_chartables.o ${CONFIG}/obj/pcre_compile.o ${CONFIG}/obj/pcre_exec.o ${CONFIG}/obj/pcre_globals.o ${CONFIG}/obj/pcre_newline.o ${CONFIG}/obj/pcre_ord2utf8.o ${CONFIG}/obj/pcre_tables.o ${CONFIG}/obj/pcre_try_flipped.o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CONFIG}/obj/pcre_valid_utf8.o ${CONFIG}/obj/pcre_xclass.o ${LIBS}

