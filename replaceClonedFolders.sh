#!/bin/bash

workdir=".."
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
fi

cd $workdir

rm -rf minorGems
git clone https://github.com/twohoursonelife/minorGems.git

rm -rf OneLife
git clone https://github.com/twohoursonelife/OneLife.git

rm -rf OneLifeData7
git clone https://github.com/twohoursonelife/OneLifeData7.git
