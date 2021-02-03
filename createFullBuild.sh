#!/bin/bash

workdir=".."
buildsdir="../builds"
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"

	buildsdir=$(sed '2!d' $settingsfile)
	buildsdir="${buildsdir:10}"
fi

pack=false
for arg in "$@"
do
    case $arg in
        --pack)
		pack=true
		shift
        ;;
        *)
		echo "Unrecognised flag"
		exit 1
		shift
        ;;
    esac
done

cd $workdir

NOW=$(date '+(%F,%H%M)')
outputFolder="2HOL_$NOW-full"
mkdir $outputFolder
cd $outputFolder

echo
echo "Gathering game assets..."
for f in animations categories faces ground music objects overlays scenes sounds sprites transitions tutorialMaps dataVersionNumber.txt; do
	#Copy from OneLifeData7 repo
	cp -RL -v ../OneLifeData7/$f .
done
echo "done."

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
./makeEditorFixed.sh; echo "done compiling."

cd ../server
./configure 5

echo; echo "Building server..."
make; echo "done compiling."

cd ../..

echo
echo "Making directories..."
mkdir -p $outputFolder/graphics
mkdir -p $outputFolder/otherSounds
mkdir -p $outputFolder/settings
mkdir -p $outputFolder/languages
mkdir -p $outputFolder/reverbCache
mkdir -p $outputFolder/groundTileCache
mkdir -p $outputFolder/webViewer
echo "done."

echo
echo "Copying items from build into directories..."
cp OneLife/gameSource/OneLife.exe $outputFolder/ #exe extension
cp OneLife/gameSource/EditOneLife.exe $outputFolder/ #exe extension
cp OneLife/documentation/Readme.txt $outputFolder/
cp OneLife/no_copyright.txt $outputFolder/
cp OneLife/gameSource/graphics/* $outputFolder/graphics/
cp OneLife/gameSource/otherSounds/* $outputFolder/otherSounds/
cp -u OneLife/gameSource/settings/* $outputFolder/settings/ #some overwriting will happen
cp OneLife/gameSource/languages/* $outputFolder/languages/
cp OneLife/gameSource/language.txt $outputFolder/
cp OneLife/gameSource/us_english_60.txt $outputFolder/
cp OneLife/gameSource/reverbImpulseResponse.aiff $outputFolder/
#cp OneLife/gameSource/wordList.txt $outputFolder/ #use of server instead

echo default.png > $outputFolder/settings/editorImportPath.ini

cp OneLife/server/OneLifeServer.exe $outputFolder/ #exe extension
cp OneLife/server/webViewer/* $outputFolder/webViewer/
cp -u OneLife/server/settings/* $outputFolder/settings/ #some overwriting will happen
cp OneLife/server/firstNames.txt $outputFolder/
cp OneLife/server/kissTest.txt $outputFolder/
cp OneLife/server/lastNames.txt $outputFolder/
#cp OneLife/server/namesInfo.txt $outputFolder/
cp OneLife/server/protocol.txt $outputFolder/
#cp OneLife/server/sampleTestMap.txt $outputFolder/
cp OneLife/server/protocol.txt $outputFolder/
cp OneLife/server/wordList.txt $outputFolder/

#cp OneLife/server/*.sh $outputFolder/server/
cp TwoLifeXcompile/exclude-dir/resetServer.bat $outputFolder/
echo "done."

#cd $outputFolder/server
#sed -i 's+../gameSource/testMap.txt+../testMap.txt+' runServerTestMap.sh

#cd ../..

if [ ! -e $buildsdir ]
then
	mkdir $buildsdir
fi

echo
echo "Moving build folder."
rm -rf $buildsdir/$outputFolder
mv $outputFolder $buildsdir/
echo "done."

cd $buildsdir
if $pack
then
	echo
	echo "Packing game..."
	7z a $outputFolder.zip $outputFolder
	echo "done."
fi

echo
echo "You shall find the compiled game at $buildsdir"
