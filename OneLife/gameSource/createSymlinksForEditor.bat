@echo off
echo
echo Creating symbolic links for the editor...

mklink /D animations ..\..\OneLifeData7\animations
mklink /D categories ..\..\OneLifeData7\categories
mklink /D ground ..\..\OneLifeData7\ground
mklink /D music ..\..\OneLifeData7\music
mklink /D objects ..\..\OneLifeData7\objects
mklink /D overlays ..\..\OneLifeData7\overlays
mklink /D scenes ..\..\OneLifeData7\scenes
mklink /D sounds ..\..\OneLifeData7\sounds
mklink /D sprites ..\..\OneLifeData7\sprites
mklink /D transitions ..\..\OneLifeData7\transitions
mklink /H dataVersionNumber.txt ..\..\OneLifeData7\dataVersionNumber.txt
