@echo off
echo
echo Creating symbolic links for the server...

cd /d %~dp0

rmdir animations
rmdir categories
rmdir objects
rmdir transitions
del dataVersionNumber.txt
del testMap.txt

mklink /D categories ..\..\OneLifeData7\categories
mklink /D objects ..\..\OneLifeData7\objects
mklink /D transitions ..\..\OneLifeData7\transitions
mklink /D tutorialMaps ..\..\OneLifeData7\tutorialMaps
mklink /H dataVersionNumber.txt ..\..\OneLifeData7\dataVersionNumber.txt
copy sampleTestMap.txt ..\gameSource\testMap.txt
mklink /H testMap.txt ..\gameSource\testMap.txt

timeout 3
