#!/bin/bash

workdir=".."
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
fi

workdir=$(sed '1!d' $locationsfile)
workdir="${workdir:8}"

cd $workdir
wget https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz -O- | tar xfz -
rm ._SDL-1.2.15
