#
#   macosx-x86_64-debug.sh -- Build It Shell Script to build PCRE Library
#

OS="macosx"
CONFIG="${OS}-x86_64-debug"
CC="/usr/bin/clang"
LD="/usr/bin/ld"
CFLAGS="-Wall -g -Wno-unused-result -Wshorten-64-to-32"
DFLAGS="-DBLD_FEATURE_PCRE=1 -DBLD_DEBUG"
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -g"
LIBPATHS="-L${CONFIG}/lib"
LIBS="-lpthread -lm -ldl"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin

[ ! -f ${CONFIG}/inc/bit.h ] && cp projects/pcre-${OS}-bit.h ${CONFIG}/inc/bit.h
if ! diff ${CONFIG}/inc/bit.h projects/pcre-${OS}-bit.h >/dev/null ; then
	cp projects/pcre-${OS}-bit.h ${CONFIG}/inc/bit.h
fi

rm -rf ${CONFIG}/inc/config.h
cp -r src/config.h ${CONFIG}/inc/config.h

rm -rf ${CONFIG}/inc/pcre.h
cp -r src/pcre.h ${CONFIG}/inc/pcre.h

rm -rf ${CONFIG}/inc/pcre_internal.h
cp -r src/pcre_internal.h ${CONFIG}/inc/pcre_internal.h

rm -rf ${CONFIG}/inc/ucp.h
cp -r src/ucp.h ${CONFIG}/inc/ucp.h

rm -rf ${CONFIG}/inc/ucpinternal.h
cp -r src/ucpinternal.h ${CONFIG}/inc/ucpinternal.h

rm -rf ${CONFIG}/inc/ucptable.h
cp -r src/ucptable.h ${CONFIG}/inc/ucptable.h

${CC} -c -o ${CONFIG}/obj/pcre_chartables.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_chartables.c

${CC} -c -o ${CONFIG}/obj/pcre_compile.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_compile.c

${CC} -c -o ${CONFIG}/obj/pcre_exec.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_exec.c

${CC} -c -o ${CONFIG}/obj/pcre_globals.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_globals.c

${CC} -c -o ${CONFIG}/obj/pcre_newline.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_newline.c

${CC} -c -o ${CONFIG}/obj/pcre_ord2utf8.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ord2utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_tables.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_tables.c

${CC} -c -o ${CONFIG}/obj/pcre_try_flipped.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_try_flipped.c

${CC} -c -o ${CONFIG}/obj/pcre_ucp_searchfuncs.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${CONFIG}/obj/pcre_valid_utf8.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_valid_utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_xclass.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_xclass.c

${CC} -dynamiclib -o ${CONFIG}/lib/libpcre.dylib -arch x86_64 ${LDFLAGS} ${LIBPATHS} -install_name @rpath/libpcre.dylib ${CONFIG}/obj/pcre_chartables.o ${CONFIG}/obj/pcre_compile.o ${CONFIG}/obj/pcre_exec.o ${CONFIG}/obj/pcre_globals.o ${CONFIG}/obj/pcre_newline.o ${CONFIG}/obj/pcre_ord2utf8.o ${CONFIG}/obj/pcre_tables.o ${CONFIG}/obj/pcre_try_flipped.o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CONFIG}/obj/pcre_valid_utf8.o ${CONFIG}/obj/pcre_xclass.o ${LIBS}

