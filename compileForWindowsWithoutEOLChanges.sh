#
# Original by risvh
#

set -e

cd ..
NOW=$(date '+(%F,%H%M)')
outputFolder="2hol_$(date '+(%dth,%h-%H:%M)')-nocnv"
mkdir $outputFolder
cd $outputFolder


#Gathering game assets
for f in animations categories ground music objects sounds sprites transitions dataVersionNumber.txt; do
    
	#Create sym link only
	# ln -s ../OneLifeData7/$f .
	
	#Copy from OneLifeData7 repo
	cp -RL -v ../OneLifeData7/$f .
	
done;

#missing SDL.dll
cp ../OneLife/build/win32/SDL.dll .

#Remove caches
rm -f */*.fcz




cd ..


#copied from OneLife/build/source/runToBuild with path adjuectment
cd OneLife
chmod u+x ./configure
./configure 5 || exit 1 #5 for cross-compiling for Windows on Linux

cd gameSource

echo
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

echo
echo "Moving build folder."
mv $outputFolder windows_builds

echo
echo "Done."

#automatically run the game 
cd windows_builds/$outputFolder
# cmd.exe /c OneLife.exe









