#!/bin/sh
#
# Imported by TwoLifeXcompile
# Original by risvh

_OLD_PATH="${PATH}"; export PATH="/usr/i686-w64-mingw32/bin:${PATH}";
cp Makefile Makefile.bak;

sed -i '/^GXX =/s,$, -static `sdl-config --static-libs`,' Makefile;
sed -i -r '/^PLATFORM_LIBPNG_FLAG =/aPLATFORM_LIBPNG_FLAG = -lpng -lz' Makefile;

mv makeFileList makeFileList.bak
cp makeFileListEditor makeFileList

make

mv makeFileList.bak makeFileList

export PATH="${_OLD_PATH}"; unset _OLD_PATH;
mv Makefile.bak Makefile;
