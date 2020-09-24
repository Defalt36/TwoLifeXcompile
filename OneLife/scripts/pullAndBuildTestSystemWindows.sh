#!/bin/sh

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



cd minorGems
git pull --tags

cd ../OneLife
git pull --tags

cd ../OneLifeData7
git pull --tags

rm */cache.fcz
rm */bin_*cache.fcz


cd ../OneLife

./configure 5

cd gameSource

make

echo 1 > settings/useCustomServer.ini

sh ./makeEditor.sh

cmd.exe /c createSymlinksForEditor.bat


cd ../server
./configure 5
make


cmd.exe /c createSymlinksForServer.bat


git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/2HOL_v* | sed -e 's/2HOL_v//' > serverCodeVersionNumber.txt


echo 0 > settings/requireTicketServerCheck.ini
echo 1 > settings/forceEveLocation.ini
