#!/bin/bash

cd ..
NOW=$(date '+(%F,%H%M)')
outputFolder="2HOL_$NOW-full"
mkdir $outputFolder
cd $outputFolder


#Gathering game assets
for f in animations categories faces ground music objects overlays scenes sounds sprites transitions tutorialMaps dataVersionNumber.txt; do
	#Copy from OneLifeData7 repo
	cp -RL -v ../OneLifeData7/$f .
done;

#missing dlls
cp ../OneLife/build/win32/*.dll .

#Remove caches
rm -f */*.fcz

cd ..


#copied from OneLife/build/source/runToBuild with path adjustment
cd OneLife
chmod u+x ./configure
./configure 5 || exit 1 #5 for cross-compiling for Windows on Linux

cd gameSource

echo; echo "Building OneLife..."
make; echo "done compiling.";

echo; echo "Building editor..."
./makeEditor.sh; echo "done compiling."

cd ../server
./configure 5

echo; echo "Building server..."
make; echo "done compiling."

cd ../..

echo
echo "Making directories"
mkdir -p $outputFolder/graphics
mkdir -p $outputFolder/otherSounds
mkdir -p $outputFolder/settings
mkdir -p $outputFolder/languages
mkdir -p $outputFolder/reverbCache
mkdir -p $outputFolder/groundTileCache
mkdir -p $outputFolder/server
mkdir -p $outputFolder/server/webViewer
mkdir -p $outputFolder/server/settings

echo
echo "Copying items from build into directories"

cp OneLife/gameSource/OneLife.exe $outputFolder/ #exe extension
cp OneLife/gameSource/EditOneLife.exe $outputFolder/ #exe extension
cp OneLife/documentation/Readme.txt $outputFolder/
cp OneLife/no_copyright.txt $outputFolder/
cp OneLife/gameSource/graphics/* $outputFolder/graphics/
cp OneLife/gameSource/otherSounds/* $outputFolder/otherSounds/
cp -u OneLife/gameSource/settings/* $outputFolder/settings/
cp OneLife/gameSource/languages/* $outputFolder/languages/
cp OneLife/gameSource/language.txt $outputFolder/
cp OneLife/gameSource/us_english_60.txt $outputFolder/
cp OneLife/gameSource/reverbImpulseResponse.aiff $outputFolder/
cp OneLife/gameSource/wordList.txt $outputFolder/

cp OneLife/server/OneLifeServer.exe $outputFolder/server/ #exe extension
cp OneLife/server/webViewer/* $outputFolder/server/webViewer/
cp -u OneLife/server/settings/* $outputFolder/server/settings/
cp OneLife/server/firstNames.txt $outputFolder/server/
cp OneLife/server/kissTest.txt $outputFolder/server/
cp OneLife/server/lastNames.txt $outputFolder/server/
cp OneLife/server/namesInfo.txt $outputFolder/server/
cp OneLife/server/protocol.txt $outputFolder/server/
cp OneLife/server/sampleTestMap.txt $outputFolder/server/
cp OneLife/server/protocol.txt $outputFolder/server/
cp OneLife/server/wordList.txt $outputFolder/server/

cp OneLife/server/*.sh $outputFolder/server/
cp TwoLifeXcompile/exclude-dir/initiateServer.bat
cp TwoLifeXcompile/exclude-dir/resetServer.bat

cd $outputFolder/server
sed -i 's+../gameSource/testMap.txt+../testMap.txt+' runServerTestMap.sh
cd ../..

if [ ! -e windows_builds ]
then
	mkdir windows_builds
fi

echo
echo "Moving build folder."

rm -rf windows_builds/$outputFolder
mv $outputFolder windows_builds/

echo
echo "Done."

echo "You shall find the compiled game at 'wherever your workdir'/windows_builds"
