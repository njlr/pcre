#
#   solaris-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

PLATFORM="solaris-i686-debug"
CC="cc"
LD="/usr/bin/ld"
CFLAGS="-Wall -fPIC -g -mcpu=i686"
DFLAGS="-D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC"
IFLAGS="-Isolaris-i686-debug/inc"
LDFLAGS="-L${PLATFORM}/lib -g
LIBS="-llxnet -lrt -lsocket -lpthread -lm"

[ ! -x ${PLATFORM}/inc ] && mkdir -p ${PLATFORM}/inc ${PLATFORM}/obj ${PLATFORM}/lib ${PLATFORM}/bin
[ ! -f ${PLATFORM}/inc/buildConfig.h ] && cp projects/buildConfig.${PLATFORM} ${PLATFORM}/inc/buildConfig.h

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

${CC} -c -o ${PLATFORM}/obj/pcre_chartables.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_chartables.c

${CC} -c -o ${PLATFORM}/obj/pcre_compile.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_compile.c

${CC} -c -o ${PLATFORM}/obj/pcre_exec.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_exec.c

${CC} -c -o ${PLATFORM}/obj/pcre_globals.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_globals.c

${CC} -c -o ${PLATFORM}/obj/pcre_newline.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_newline.c

${CC} -c -o ${PLATFORM}/obj/pcre_ord2utf8.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_ord2utf8.c

${CC} -c -o ${PLATFORM}/obj/pcre_tables.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_tables.c

${CC} -c -o ${PLATFORM}/obj/pcre_try_flipped.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_try_flipped.c

${CC} -c -o ${PLATFORM}/obj/pcre_ucp_searchfuncs.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${PLATFORM}/obj/pcre_valid_utf8.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_valid_utf8.c

${CC} -c -o ${PLATFORM}/obj/pcre_xclass.o ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/pcre_xclass.c

${CC} -shared -o ${PLATFORM}/lib/libpcre.so ${LDFLAGS} ${PLATFORM}/obj/pcre_chartables.o ${PLATFORM}/obj/pcre_compile.o ${PLATFORM}/obj/pcre_exec.o ${PLATFORM}/obj/pcre_globals.o ${PLATFORM}/obj/pcre_newline.o ${PLATFORM}/obj/pcre_ord2utf8.o ${PLATFORM}/obj/pcre_tables.o ${PLATFORM}/obj/pcre_try_flipped.o ${PLATFORM}/obj/pcre_ucp_searchfuncs.o ${PLATFORM}/obj/pcre_valid_utf8.o ${PLATFORM}/obj/pcre_xclass.o ${LIBS}

