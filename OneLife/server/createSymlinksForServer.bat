@echo off
echo
echo Creating symbolic links for the server...

mklink /D categories ..\..\OneLifeData7\categories
mklink /D objects ..\..\OneLifeData7\objects
mklink /D transitions ..\..\OneLifeData7\transitions
mklink /D tutorialMaps ..\..\OneLifeData7\tutorialMaps
mklink /H dataVersionNumber.txt ..\..\OneLifeData7\dataVersionNumber.txt
copy sampleTestMap.txt ..\gameSource\testMap.txt
mklink /H testMap.txt ..\gameSource\testMap.txt
