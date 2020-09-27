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

mklink /J animations ..\animations
mklink /J categories ..\categories
mklink /J objects ..\objects
mklink /J transitions ..\transitions
mklink /J tutorialMaps ..\tutorialMaps
mklink /H dataVersionNumber.txt ..\dataVersionNumber.txt

if not exist ..\testMap.txt copy sampleTestMap.txt ..\testMap.txt
mklink /H testMap.txt ..\testMap.txt

timeout 10
