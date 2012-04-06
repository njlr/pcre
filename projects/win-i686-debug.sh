#
#   win-i686-debug.sh -- Build It Shell Script to build PCRE Library
#

VS="${VSINSTALLDIR}"
: ${VS:="$(VS)"}
SDK="${WindowsSDKDir}"
: ${SDK:="$(SDK)"}

export SDK VS
export PATH="$(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)"
export INCLUDE="$(INCLUDE);$(SDK)/INCLUDE:$(VS)/VC/INCLUDE"
export LIB="$(LIB);$(SDK)/lib:$(VS)/VC/lib"

CONFIG="win-i686-debug"
CC="cl.exe"
LD="link.exe"
CFLAGS="-nologo -GR- -W3 -Zi -Od -MDd -Zi -Od -MDd"
DFLAGS="-D_REENTRANT -D_MT -DBLD_FEATURE_PCRE=1"
IFLAGS="-Iwin-i686-debug/inc -Iwin-i686-debug/inc"
LDFLAGS="-nologo -nodefaultlib -incremental:no -machine:x86 -machine:x86"
LIBPATHS="-libpath:${CONFIG}/bin -libpath:${CONFIG}/bin"
LIBS="ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin
cp projects/buildConfig.${CONFIG} ${CONFIG}/inc/buildConfig.h

rm -rf win-i686-debug/inc/config.h
cp -r src/config.h win-i686-debug/inc/config.h

rm -rf win-i686-debug/inc/pcre.h
cp -r src/pcre.h win-i686-debug/inc/pcre.h

rm -rf win-i686-debug/inc/pcre_internal.h
cp -r src/pcre_internal.h win-i686-debug/inc/pcre_internal.h

rm -rf win-i686-debug/inc/ucp.h
cp -r src/ucp.h win-i686-debug/inc/ucp.h

rm -rf win-i686-debug/inc/ucpinternal.h
cp -r src/ucpinternal.h win-i686-debug/inc/ucpinternal.h

rm -rf win-i686-debug/inc/ucptable.h
cp -r src/ucptable.h win-i686-debug/inc/ucptable.h

"${CC}" -c -Fo${CONFIG}/obj/pcre_chartables.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_chartables.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_compile.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_compile.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_exec.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_exec.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_globals.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_globals.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_newline.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_newline.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_ord2utf8.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ord2utf8.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_tables.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_tables.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_try_flipped.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_try_flipped.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_ucp_searchfuncs.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_valid_utf8.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_valid_utf8.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_xclass.obj -Fd${CONFIG}/obj ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -I${CONFIG}/inc src/pcre_xclass.c

"${LD}" -dll -out:${CONFIG}/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:${CONFIG}/bin/libpcre.def ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/pcre_chartables.obj ${CONFIG}/obj/pcre_compile.obj ${CONFIG}/obj/pcre_exec.obj ${CONFIG}/obj/pcre_globals.obj ${CONFIG}/obj/pcre_newline.obj ${CONFIG}/obj/pcre_ord2utf8.obj ${CONFIG}/obj/pcre_tables.obj ${CONFIG}/obj/pcre_try_flipped.obj ${CONFIG}/obj/pcre_ucp_searchfuncs.obj ${CONFIG}/obj/pcre_valid_utf8.obj ${CONFIG}/obj/pcre_xclass.obj ${LIBS}

