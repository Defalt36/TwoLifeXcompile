@echo off
echo
echo Creating symbolic links for the server...

cd /d %~dp0

rmdir animations
rmdir categories
rmdir objects
rmdir transitions
rmdir tutorialMaps
del dataVersionNumber.txt
del testMap.txt

mklink /J animations ..\animations
mklink /J categories ..\..\OneLifeData7\categories
mklink /J objects ..\..\OneLifeData7\objects
mklink /J transitions ..\..\OneLifeData7\transitions
mklink /J tutorialMaps ..\..\OneLifeData7\tutorialMaps
mklink /H dataVersionNumber.txt ..\..\OneLifeData7\dataVersionNumber.txt
copy sampleTestMap.txt ..\gameSource\testMap.txt
mklink /H testMap.txt ..\gameSource\testMap.txt

timeout 3
