#
#   linux-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

CONFIG="linux-i686-debug"
CC="cc"
LD="ld"
CFLAGS="-Wall -fPIC -O3 -Wno-unused-result -mtune=i686 -fPIC -O3 -Wno-unused-result -mtune=i686"
DFLAGS="-D_REENTRANT -DCPU=${ARCH} -DBLD_FEATURE_PCRE=1 -DPIC -DPIC"
IFLAGS="-Ilinux-i686-debug/inc -Ilinux-i686-debug/inc"
LDFLAGS="-Wl,--enable-new-dtags -Wl,-rpath,\$ORIGIN/ -Wl,-rpath,\$ORIGIN/../lib"
LIBPATHS="-L${CONFIG}/lib -L${CONFIG}/lib"
LIBS="-lpthread -lm -ldl -lpthread -lm -ldl"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin
cp projects/buildConfig.${CONFIG} ${CONFIG}/inc/buildConfig.h

rm -rf linux-i686-debug/inc/config.h
cp -r src/config.h linux-i686-debug/inc/config.h

rm -rf linux-i686-debug/inc/pcre.h
cp -r src/pcre.h linux-i686-debug/inc/pcre.h

rm -rf linux-i686-debug/inc/pcre_internal.h
cp -r src/pcre_internal.h linux-i686-debug/inc/pcre_internal.h

rm -rf linux-i686-debug/inc/ucp.h
cp -r src/ucp.h linux-i686-debug/inc/ucp.h

rm -rf linux-i686-debug/inc/ucpinternal.h
cp -r src/ucpinternal.h linux-i686-debug/inc/ucpinternal.h

rm -rf linux-i686-debug/inc/ucptable.h
cp -r src/ucptable.h linux-i686-debug/inc/ucptable.h

${CC} -c -o ${CONFIG}/obj/pcre_chartables.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_chartables.c

${CC} -c -o ${CONFIG}/obj/pcre_compile.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_compile.c

${CC} -c -o ${CONFIG}/obj/pcre_exec.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_exec.c

${CC} -c -o ${CONFIG}/obj/pcre_globals.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_globals.c

${CC} -c -o ${CONFIG}/obj/pcre_newline.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_newline.c

${CC} -c -o ${CONFIG}/obj/pcre_ord2utf8.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ord2utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_tables.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_tables.c

${CC} -c -o ${CONFIG}/obj/pcre_try_flipped.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_try_flipped.c

${CC} -c -o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

${CC} -c -o ${CONFIG}/obj/pcre_valid_utf8.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_valid_utf8.c

${CC} -c -o ${CONFIG}/obj/pcre_xclass.o ${CFLAGS} -D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC -DPIC -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_xclass.c

${CC} -shared -o ${CONFIG}/lib/libpcre.so ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/pcre_chartables.o ${CONFIG}/obj/pcre_compile.o ${CONFIG}/obj/pcre_exec.o ${CONFIG}/obj/pcre_globals.o ${CONFIG}/obj/pcre_newline.o ${CONFIG}/obj/pcre_ord2utf8.o ${CONFIG}/obj/pcre_tables.o ${CONFIG}/obj/pcre_try_flipped.o ${CONFIG}/obj/pcre_ucp_searchfuncs.o ${CONFIG}/obj/pcre_valid_utf8.o ${CONFIG}/obj/pcre_xclass.o ${LIBS}

