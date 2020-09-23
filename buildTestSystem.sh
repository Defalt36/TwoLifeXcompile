#!/bin/sh

echo "This script was made to be run in wsl, some parts of it won't work on a pure linux enviroment."

#read userIn

if [ ! -e ../minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git ../minorGems
fi

if [ ! -e ../OneLife ]
then
	git clone ../https://github.com/twohoursonelife/OneLife.git ../OneLife
fi

if [ ! -e ../OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git ../OneLifeData7
fi

./applyLocalRequirements.sh
./fixStuff.sh

cd ..

cd OneLifeData7

rm */cache.fcz
rm */bin_*cache.fcz

cd ../OneLife

./configure 5

cd gameSource

echo
echo "Building game..."
make
echo "done compiling."

echo 1 > settings/useCustomServer.ini
echo localhost > settings/CustomServerAddress.ini
echo 8005 > settings/customServerPort.ini

echo
echo "Building editor..."
sh ./makeEditor.sh
echo "done compiling."

echo
cmd.exe /c createSymlinksForEditor.bat

cd ../server
./configure 5
echo
echo "Building server..."
make
echo "done compiling."

echo
cmd.exe /c createSymlinksForServer.bat

echo 0 > settings/requireTicketServerCheck.ini
echo 1 > settings/forceEveLocation.ini

echo
echo "done :)"
