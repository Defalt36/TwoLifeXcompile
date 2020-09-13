#!/bin/bash

if [ $# -gt 1 ] ; then
   echo "Too many arguments."
   exit 1
fi

install_instead=false

case $1 in
	--install-instead)
	install_instead=true
	shift
    ;;
    *)
esac

if [ "$install_instead" = true ]
then
	./installMissingLibraries.sh --sdlonly
	echo "Remember to modify the file 'Makefile.MinGWCross'."
	exit
fi

cd ..
wget https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz -O- | tar xfz -
rm ._SDL-1.2.15