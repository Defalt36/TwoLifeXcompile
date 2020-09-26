#!/bin/sh

echo "This script was made to be run in wsl, some parts of it won't work on a pure linux enviroment."
echo "You may have to create the symlinks manually if you are not running wsl with admistrator privileges."
echo
sleep 3

if [ ! -e ../minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git ../minorGems
fi

if [ ! -e ../OneLife ]
then
	git clone https://github.com/twohoursonelife/OneLife.git ../OneLife
fi

if [ ! -e ../OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git ../OneLifeData7
fi


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

rm */cache.fcz

cd ..

cd TwoLifeXcompile
./applyLocalRequirements.sh
./fixStuff.sh
cd ..

latestVersion=$latestTaggedVersionB


if [ $latestTaggedVersionA -gt $latestTaggedVersionB ]
then
	latestVersion=$latestTaggedVersionA
fi

cp TwoLifeXcompile/exclude-dir/createSymlinksForGame.bat .
cmd.exe /c createSymlinksForGame.bat


cd OneLife
chmod u+x ./configure
./configure 5 || exit 1

cd gameSource

echo "Building OneLife..."
make || exit 1

cd ../..

echo "Making directories"
mkdir -p graphics
mkdir -p otherSounds
mkdir -p settings
mkdir -p languages
mkdir -p reverbCache
mkdir -p groundTileCache



echo "Copying items from build into directories"
cp OneLife/gameSource/OneLife.exe .
cp OneLife/documentation/Readme.txt .
cp OneLife/no_copyright.txt .
cp OneLife/gameSource/graphics/* ./graphics
cp OneLife/gameSource/otherSounds/* ./otherSounds
cp -u OneLife/gameSource/settings/* ./settings
cp OneLife/gameSource/languages/* ./languages
cp OneLife/gameSource/language.txt ./
cp OneLife/gameSource/us_english_60.txt ./
cp OneLife/gameSource/reverbImpulseResponse.aiff ./
cp OneLife/gameSource/wordList.txt ./
cp OneLife/build/win32/SDL.dll .

echo "Run OneLife to play."

echo
echo "Done building v$latestVersion"

