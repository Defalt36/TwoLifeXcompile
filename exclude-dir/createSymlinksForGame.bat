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

mklink /D animations OneLifeData7\animations
mklink /D categories OneLifeData7\categories
mklink /D ground OneLifeData7\ground
mklink /D music OneLifeData7\music
mklink /D objects OneLifeData7\objects
mklink /D sounds OneLifeData7\sounds
mklink /D sprites OneLifeData7\sprites
mklink /D transitions OneLifeData7\transitions
mklink /H dataVersionNumber.txt OneLifeData7\dataVersionNumber.txt

timeout 3
