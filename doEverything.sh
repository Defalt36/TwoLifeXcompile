#!/bin/bash

#
# Original by risvh
#

echo "This is going to take some time."
sleep 3

cdir="${PWD: -8}"
if [ "$cdir" = "Xcompile" ]
then
	echo
	echo "Don't run this from TwoLifeXcompile repository. This is meant to be executed in your workdir."
	exit
fi

sudo apt-get install git

git clone https://github.com/Defalt36/TwoLifeXcompile.git

cd TwoLifeXcompile

./getBasics.sh
./installMingw.sh
./installMissingLibraries.sh
./getSDLforMingw.sh
./removeAndCloneAgain.sh
./fixStuff.sh
./applyLocalRequirements.sh
./buildTestSystem.sh
./compileForWindowsWithoutEOLChanges.sh
