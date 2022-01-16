#!/bin/bash
#
# Original by risvh

workdir=".."
buildsdir="builds"
toclean=('LivingLifePage' 'server' 'game')
gamedir="../OneLife/gameSource"
if [ -f "settings.txt" ] ; then
	echo lol
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
outputFolder="2HOL_$NOW-nocnv"
mkdir $outputFolder
cd $outputFolder

echo
echo "Gathering game assets..."
for f in animations categories ground music objects sounds sprites transitions dataVersionNumber.txt; do

	#Create sym link only
	# ln -s ../OneLifeData7/$f .

	#Copy from OneLifeData7 repo
	cp -RL -v ../OneLifeData7/$f .

done
echo "done."

#missing SDL.dll
cp ../OneLife/build/win32/SDL.dll .

#Remove caches
rm -f */*.fcz

cd ..


#copied from OneLife/build/source/runToBuild with path adjustment
cd OneLife
chmod u+x ./configure
./configure 5 || exit 1 #5 for cross-compiling for Windows on Linux

cd gameSource

echo
echo "Building OneLife..."
make || exit 1
echo "done compiling."

cd ../..

echo
echo "Making directories"
mkdir -p $outputFolder/graphics
mkdir -p $outputFolder/otherSounds
mkdir -p $outputFolder/settings
mkdir -p $outputFolder/languages
mkdir -p $outputFolder/reverbCache
mkdir -p $outputFolder/groundTileCache
echo "done."

echo
echo "Copying items from build into directories"
cp OneLife/gameSource/OneLife.exe $outputFolder/ #exe extension
cp OneLife/documentation/Readme.txt $outputFolder/
cp OneLife/no_copyright.txt $outputFolder/
cp OneLife/gameSource/graphics/* $outputFolder/graphics
cp OneLife/gameSource/otherSounds/* $outputFolder/otherSounds
cp -u OneLife/gameSource/settings/* $outputFolder/settings
cp OneLife/gameSource/languages/* $outputFolder/languages
cp OneLife/gameSource/language.txt $outputFolder/
cp OneLife/gameSource/us_english_60.txt $outputFolder/
cp OneLife/gameSource/reverbImpulseResponse.aiff $outputFolder/
cp OneLife/gameSource/wordList.txt $outputFolder/
echo "done."

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
