#
#   linux-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

PLATFORM="linux-i686-debug"
CC="cc"
LD="ld"
CFLAGS="-Wall -fPIC -g -Wno-unused-result -mtune=i686"
DFLAGS="-D_REENTRANT -DCPU=i686 -DBLD_FEATURE_PCRE=1 -DPIC"
IFLAGS="-Ilinux-i686-debug/inc"
LDFLAGS="-Wl,--enable-new-dtags -Wl,-rpath,\$ORIGIN/ -Wl,-rpath,\$ORIGIN/../lib -g"
LIBPATHS="-L${PLATFORM}/lib"
LIBS="-lpthread -lm -ldl"

[ ! -x ${PLATFORM}/inc ] && mkdir -p ${PLATFORM}/inc ${PLATFORM}/obj ${PLATFORM}/lib ${PLATFORM}/bin
[ ! -f ${PLATFORM}/inc/buildConfig.h ] && cp projects/buildConfig.${PLATFORM} ${PLATFORM}/inc/buildConfig.h

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

${CC} -shared -o ${PLATFORM}/lib/libpcre.so ${LDFLAGS} ${LIBPATHS} ${PLATFORM}/obj/pcre_chartables.o ${PLATFORM}/obj/pcre_compile.o ${PLATFORM}/obj/pcre_exec.o ${PLATFORM}/obj/pcre_globals.o ${PLATFORM}/obj/pcre_newline.o ${PLATFORM}/obj/pcre_ord2utf8.o ${PLATFORM}/obj/pcre_tables.o ${PLATFORM}/obj/pcre_try_flipped.o ${PLATFORM}/obj/pcre_ucp_searchfuncs.o ${PLATFORM}/obj/pcre_valid_utf8.o ${PLATFORM}/obj/pcre_xclass.o ${LIBS}

