#
#   pcre-linux-static.sh -- Build It Shell Script to build PCRE Library
#

PRODUCT="pcre"
VERSION="1.0.0"
BUILD_NUMBER="0"
PROFILE="static"
ARCH="x86"
ARCH="`uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/'`"
OS="linux"
CONFIG="${OS}-${ARCH}-${PROFILE}"
CC="/usr/bin/gcc"
LD="/usr/bin/ld"
CFLAGS="-fPIC -O2  -w"
DFLAGS="-D_REENTRANT -DBIT_FEATURE_PCRE=1 -DPIC"
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-Wl,--enable-new-dtags -Wl,-rpath,\$ORIGIN/ -Wl,-rpath,\$ORIGIN/../bin -rdynamic"
LIBPATHS="-L${CONFIG}/bin"
LIBS="-lpthread -lm -lrt -ldl"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin

[ ! -f ${CONFIG}/inc/bit.h ] && cp projects/pcre-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
[ ! -f ${CONFIG}/inc/bitos.h ] && cp ${SRC}/src/bitos.h ${CONFIG}/inc/bitos.h
if ! diff ${CONFIG}/inc/bit.h projects/pcre-${OS}-${PROFILE}-bit.h >/dev/null ; then
	cp projects/pcre-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
fi

rm -rf ${CONFIG}/inc/config.h
cp -r src/config.h ${CONFIG}/inc/config.h

rm -rf ${CONFIG}/inc/pcre.h
cp -r src/pcre.h ${CONFIG}/inc/pcre.h

rm -rf ${CONFIG}/inc/ucp.h
cp -r src/ucp.h ${CONFIG}/inc/ucp.h

rm -rf ${CONFIG}/inc/pcre_internal.h
cp -r src/pcre_internal.h ${CONFIG}/inc/pcre_internal.h

rm -rf ${CONFIG}/inc/ucpinternal.h
cp -r src/ucpinternal.h ${CONFIG}/inc/ucpinternal.h

rm -rf ${CONFIG}/inc/ucptable.h
cp -r src/ucptable.h ${CONFIG}/inc/ucptable.h

${CC} -c -o ${CONFIG}/obj/pcre_chartables.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_chartables.c

${CC} -c -o ${CONFIG}/obj/pcre_compile.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_compile.c

${CC} -c -o ${CONFIG}/obj/pcre_exec.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_exec.c

${CC} -c -o ${CONFIG}/obj/pcre_globals.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_globals.c

${CC} -c -o ${CONFIG}/obj/pcre_newline.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_newline.c

${CC} -c -o ${CONFIG}/obj/pcre_ord2utf8.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ord2utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_tables.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_tables.c

${CC} -c -o ${CONFIG}/obj/pcre_try_flipped.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_try_flipped.c

${CC} -c -o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${CONFIG}/obj/pcre_valid_utf8.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_valid_utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_xclass.o ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_xclass.c

/usr/bin/ar -cr ${CONFIG}/bin/libpcre.a ${CONFIG}/obj/pcre_chartables.o ${CONFIG}/obj/pcre_compile.o ${CONFIG}/obj/pcre_exec.o ${CONFIG}/obj/pcre_globals.o ${CONFIG}/obj/pcre_newline.o ${CONFIG}/obj/pcre_ord2utf8.o ${CONFIG}/obj/pcre_tables.o ${CONFIG}/obj/pcre_try_flipped.o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CONFIG}/obj/pcre_valid_utf8.o ${CONFIG}/obj/pcre_xclass.o

#  Omit build script undefined
