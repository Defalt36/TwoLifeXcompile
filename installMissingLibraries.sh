#!/bin/bash

workdir=".."
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
fi

skipdefault=false
freetype=false

for arg in "$@"
do
    case $arg in
		--freetype)
		freetype=true
		skipdefault=true
		shift
        ;;
        *)
		echo "Unrecognised flag"
		exit 1
		shift
        ;;
    esac
done

#no "libpng.a", "libz.a" or "libSDL.a" in 32-bit mingw folder
#check with $ sudo find /usr/i686-w64-mingw32/lib/ -name "lib*.a"

cd $workdir

build="x86_64-linux-gnu"
host="i686-w64-mingw32"
prefixdir="/usr/i686-w64-mingw32"

#keep the libraries in case you want to uninstall them later
if [ ! -e installed_libraries ]
then
	mkdir -v installed_libraries
fi

if [ "$skipdefault" = false ]
then
	echo
	echo "Preparing LibZ..."
	wget https://zlib.net/zlib-1.2.11.tar.gz -O- | tar xfz -
	cd zlib*
	sudo make -f win32/Makefile.gcc BINARY_PATH=$prefixdir/bin INCLUDE_PATH=$prefixdir/include LIBRARY_PATH=$prefixdir/lib SHARED_MODE=1 PREFIX=$host- install
	cd ..
	mv zlib-1.2.11 installed_libraries/zlib-1.2.11_source
fi


if [ "$skipdefault" = false ]
then
	#LibPng won't install propely if Zlib isn't installed fist
	#Compiling libPng prompt my antivirus a lot, but it don't seem to interfere with anything
	echo
	echo "Preparing LibPng..."
	wget https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.gz -O- | tar xfz -
	cd libpng*
	./configure \
		--host=$host \
		--prefix=$prefixdir \
		CPPFLAGS="-I$prefixdir/include" \
		LDFLAGS="-L$prefixdir/lib"
	make
	sudo make install
	cd ..
	mv libpng-1.6.37 installed_libraries/libpng-1.6.37_source
fi

if [ "$skipdefault" = false ]
then
	echo
	echo "Preparing LibSDL..."
	rm -rf SDL-1.2.15
	wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz -O- | tar xfz -
	cd SDL*
	./configure \
		--bindir=$prefixdir/bin \
		--libdir=$prefixdir/lib \
		--includedir=$prefixdir/include \
		--host=i686-w64-mingw32 \
		--prefix=$prefixdir \
		CPPFLAGS="-I$prefixdir/include" \
		LDFLAGS="-L$prefixdir/lib"
	make
	sudo make install
	cd ..
	mv SDL-1.2.15 installed_libraries/SDL-1.2.15_source
fi

if [ "$freetype" = true ]
then
	echo
	echo "Preparing LibFreeType2..."
	wget https://downloads.sourceforge.net/project/freetype/freetype2/2.11.1/freetype-2.11.1.tar.gz -O- | tar xfz -
	cd freetype*
	./configure \
		--prefix=$prefixdir \
		--build=$build \
		--host=$host \
		CPPFLAGS="-I$prefixdir/include" \
		LDFLAGS="-L$prefixdir/lib" \
		PKG_CONFIG_LIBDIR=$prefixdir/lib/pkgconfig
	make
	sudo make install
	cd ..
	mv freetype-2.11.1 installed_libraries/freetype-2.11.1_source
fi
