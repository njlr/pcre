#
#   pcre-win.sh -- Build It Shell Script to build PCRE Library
#

export PATH="$(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)"
export INCLUDE="$(INCLUDE);$(SDK)/INCLUDE:$(VS)/VC/INCLUDE"
export LIB="$(LIB);$(SDK)/lib:$(VS)/VC/lib"

ARCH="x86"
ARCH="$(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/')"
OS="win"
PROFILE="debug"
CONFIG="${OS}-${ARCH}-${PROFILE}"
CC="cl.exe"
LD="link.exe"
CFLAGS="-nologo -GR- -W3 -Zi -Od -MDd"
DFLAGS="-D_REENTRANT -D_MT -DBIT_FEATURE_PCRE=1 -DBIT_DEBUG"
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-nologo -nodefaultlib -incremental:no -debug -machine:x86"
LIBPATHS="-libpath:${CONFIG}/bin"
LIBS="ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib"

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

"${CC}" -c -Fo${CONFIG}/obj/pcre_chartables.obj -Fd${CONFIG}/obj/pcre_chartables.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_chartables.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_compile.obj -Fd${CONFIG}/obj/pcre_compile.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_compile.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_exec.obj -Fd${CONFIG}/obj/pcre_exec.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_exec.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_globals.obj -Fd${CONFIG}/obj/pcre_globals.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_globals.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_newline.obj -Fd${CONFIG}/obj/pcre_newline.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_newline.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_ord2utf8.obj -Fd${CONFIG}/obj/pcre_ord2utf8.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ord2utf8.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_tables.obj -Fd${CONFIG}/obj/pcre_tables.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_tables.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_try_flipped.obj -Fd${CONFIG}/obj/pcre_try_flipped.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_try_flipped.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_ucp_searchfuncs.obj -Fd${CONFIG}/obj/pcre_ucp_searchfuncs.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_ucp_searchfuncs.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_valid_utf8.obj -Fd${CONFIG}/obj/pcre_valid_utf8.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_valid_utf8.c

"${CC}" -c -Fo${CONFIG}/obj/pcre_xclass.obj -Fd${CONFIG}/obj/pcre_xclass.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/pcre_xclass.c

"${LD}" -dll -out:${CONFIG}/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:${CONFIG}/bin/libpcre.def ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/pcre_chartables.obj ${CONFIG}/obj/pcre_compile.obj ${CONFIG}/obj/pcre_exec.obj ${CONFIG}/obj/pcre_globals.obj ${CONFIG}/obj/pcre_newline.obj ${CONFIG}/obj/pcre_ord2utf8.obj ${CONFIG}/obj/pcre_tables.obj ${CONFIG}/obj/pcre_try_flipped.obj ${CONFIG}/obj/pcre_ucp_searchfuncs.obj ${CONFIG}/obj/pcre_valid_utf8.obj ${CONFIG}/obj/pcre_xclass.obj ${LIBS}

