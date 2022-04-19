#!/bin/bash

workdir=".."
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
fi

echo "This script was made to be run in wsl, some parts of it won't work on a pure linux enviroment."
echo "You may have to create the symlinks manually if you are not running wsl with admistrator privileges."
echo
sleep 3

if [ ! -e $workdir/minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git $workdir/minorGems
fi

if [ ! -e $workdir/OneLife ]
then
	git clone https://github.com/twohoursonelife/OneLife.git $workdir/OneLife
fi

if [ ! -e $workdir/OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git $workdir/OneLifeData7
fi

./applyLocalRequirements.sh
./fixStuff.sh

cd $workdir

cd OneLifeData7

rm */cache.fcz
rm */bin_*cache.fcz

cd ../OneLife

./configure 5

cd gameSource

echo;echo "Building game..."
make

echo "done compiling."

echo 1 > settings/useCustomServer.ini
echo localhost > settings/CustomServerAddress.ini
echo 8005 > settings/customServerPort.ini
echo 1 > settings/vogModeOn.ini

echo; echo "Building editor..."
sh ./makeEditorFixed.sh #fix for the original makeEditor.sh

echo "done compiling."

echo
cmd.exe /c createSymlinksForEditor.bat

cp ../build/win32/*.dll .

cd ../server
./configure 5

echo; echo "Building server..."
make

echo "done compiling."

echo
cmd.exe /c createSymlinksForServer.bat

echo 0 > settings/requireTicketServerCheck.ini
echo 1 > settings/forceEveLocation.ini
echo 1 > settings/useTestMap.ini
echo 1 > settings/allowVOGMode.ini
echo 1 > settings/allowMapRequests.ini

echo; echo "done :)"
