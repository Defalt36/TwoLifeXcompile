#!/bin/sh

echo "This script was made to be run in wsl, some parts of it won't work on a pure linux enviroment."
echo
echo "Warning: Make sure you are running wsl with administrator privileges before proceeding."
echo "Cancel with ctrl+c. Proceed with enter."

read userIn

cd ..
if [ ! -e minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git	
fi

if [ ! -e OneLife ]
then
	git clone https://github.com/twohoursonelife/OneLife.git
fi

if [ ! -e OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git	
fi

cd OneLifeData7

rm */cache.fcz
rm */bin_*cache.fcz

cd ../OneLife

./configure 5

cd gameSource

echo
echo "Building game..."
make

echo 1 > settings/useCustomServer.ini
echo localhost > settings/CustomServerAddress.ini
echo 8005 > settings/customServerPort.ini

echo
echo "Building editor..."
sh ./makeEditor.sh

#This won't work if you didn't open wsl from a cmd with administrator privileges
echo
cmd.exe /c createSymlinksForEditor.bat

cd ../server
./configure 5
echo
echo "Building server..."
make

#This won't work if you didn't open wsl from a cmd with administrator privileges
echo
cmd.exe /c createSymlinksForServer.bat

echo 0 > settings/requireTicketServerCheck.ini
echo 1 > settings/forceEveLocation.ini

echo
echo "done :)"