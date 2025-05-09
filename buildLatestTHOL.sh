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

pushd .

cd $workdir

if [ ! -e minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git minorGems
fi

if [ ! -e OneLife ]
then
	git clone https://github.com/twohoursonelife/OneLife.git OneLife
fi

if [ ! -e OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git OneLifeData7
fi

NOW=$(date '+(%F,%H%M)')
outputFolder="2HOL_$NOW-latest"
mkdir $outputFolder
cd $outputFolder

echo
echo "Gathering game assets.."
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

cd minorGems
git fetch --tags
latestTaggedVersion=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/2HOL_v* | sed -e 's/2HOL_v//'`
git checkout -q 2HOL_v$latestTaggedVersion


cd ../OneLife
git fetch --tags
latestTaggedVersionA=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/2HOL_v* | sed -e 's/2HOL_v//'`
git checkout -q 2HOL_v$latestTaggedVersionA


cd ../OneLifeData7
git fetch --tags
latestTaggedVersionB=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/2HOL_v* | sed -e 's/2HOL_v//'`
git checkout -q 2HOL_v$latestTaggedVersionB

cd ..

popd
./applyLocalRequirements.sh
./fixStuff.sh

cd $workdir

latestVersion=$latestTaggedVersionB


if [ $latestTaggedVersionA -gt $latestTaggedVersionB ]
then
	latestVersion=$latestTaggedVersionA
fi

#cp TwoLifeXcompile/exclude-dir/createSymlinksForGame.bat .
#cmd.exe /c createSymlinksForGame.bat

cd OneLife
chmod u+x ./configure
./configure 5 || exit 1

cd gameSource

echo "Building OneLife..."
make || exit 1

cd ../..

echo
echo "Making directories"
mkdir -p $outputFolder/graphics
mkdir -p $outputFolder/otherSounds
mkdir -p $outputFolder/settings
mkdir -p $outputFolder/languages
mkdir -p $outputFolder/reverbCache
mkdir -p $outputFolder/groundTileCache

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

echo "Run OneLife.exe on $buildsdir to play."

echo
echo "Done building v$latestVersion"
