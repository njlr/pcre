#
#   solaris-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

CONFIG="solaris-i686-debug"
CC="cc"
LD="ld"
CFLAGS="-Wall -fPIC -O3 -mcpu=i686 -fPIC -O3 -mcpu=i686"
DFLAGS="-D_REENTRANT -DCPU=${ARCH} -DBLD_FEATURE_PCRE=1 -DPIC -DPIC"
IFLAGS="-Isolaris-i686-debug/inc -Isolaris-i686-debug/inc"
LDFLAGS=""
LIBPATHS="-L${CONFIG}/lib -L${CONFIG}/lib"
LIBS="-llxnet -lrt -lsocket -lpthread -lm -lpthread -lm"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin
cp projects/buildConfig.${CONFIG} ${CONFIG}/inc/buildConfig.h

rm -rf solaris-i686-debug/inc/config.h
cp -r src/config.h solaris-i686-debug/inc/config.h

rm -rf solaris-i686-debug/inc/pcre.h
cp -r src/pcre.h solaris-i686-debug/inc/pcre.h

rm -rf solaris-i686-debug/inc/pcre_internal.h
cp -r src/pcre_internal.h solaris-i686-debug/inc/pcre_internal.h

rm -rf solaris-i686-debug/inc/ucp.h
cp -r src/ucp.h solaris-i686-debug/inc/ucp.h

rm -rf solaris-i686-debug/inc/ucpinternal.h
cp -r src/ucpinternal.h solaris-i686-debug/inc/ucpinternal.h

rm -rf solaris-i686-debug/inc/ucptable.h
cp -r src/ucptable.h solaris-i686-debug/inc/ucptable.h

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_chartables.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_chartables.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_compile.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_compile.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_exec.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_exec.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_globals.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_globals.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_newline.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_newline.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_ord2utf8.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ord2utf8.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_tables.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_tables.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_try_flipped.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_try_flipped.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_valid_utf8.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_valid_utf8.c

${LDFLAGS}${LDFLAGS}${CC} -c -o ${CONFIG}/obj/pcre_xclass.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_xclass.c

${LDFLAGS}${LDFLAGS}${CC} -shared -o ${CONFIG}/lib/libpcre.so ${LIBPATHS} ${CONFIG}/obj/pcre_chartables.o ${CONFIG}/obj/pcre_compile.o ${CONFIG}/obj/pcre_exec.o ${CONFIG}/obj/pcre_globals.o ${CONFIG}/obj/pcre_newline.o ${CONFIG}/obj/pcre_ord2utf8.o ${CONFIG}/obj/pcre_tables.o ${CONFIG}/obj/pcre_try_flipped.o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CONFIG}/obj/pcre_valid_utf8.o ${CONFIG}/obj/pcre_xclass.o ${LIBS}

