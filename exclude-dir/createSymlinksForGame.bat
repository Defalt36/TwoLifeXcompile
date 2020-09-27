@echo off
echo
echo Creating symbolic links for the game...

cd /d %~dp0

rmdir animations
rmdir categories
rmdir ground
rmdir music
rmdir objects
rmdir sounds
rmdir sprites
rmdir transitions
del dataVersionNumber.txt

mklink /J animations OneLifeData7\animations
mklink /J categories OneLifeData7\categories
mklink /J ground OneLifeData7\ground
mklink /J music OneLifeData7\music
mklink /J objects OneLifeData7\objects
mklink /J sounds OneLifeData7\sounds
mklink /J sprites OneLifeData7\sprites
mklink /J transitions OneLifeData7\transitions
mklink /H dataVersionNumber.txt OneLifeData7\dataVersionNumber.txt

timeout 3
