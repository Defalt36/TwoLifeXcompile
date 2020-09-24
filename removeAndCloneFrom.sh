#!/bin/bash

defaultUser="twohoursonelife"

cd ..

read -p "remove existing now? " removeNow
if [ "$removeNow" = "yes" ]
then
	rm -rf OneLifeData7
	rm -rf minorGems
	rm -rf OneLife
	echo "Folders removed."
else
	echo "Not removed."
fi

echo
echo "Write anything to override all users. Press enter to continue."
read soloUserN

if [ -z "$soloUserN" ]
then
	echo "Enter github users to clone from. (let blank for default user)"
	read -p "OneLife user:" OneLifeU
	read -p "minorGems user:" minorGemsU
	read -p "OneLifeData7 user:" OneLifeData7U
else
	OneLifeU=$soloUserN
	minorGemsU=$soloUserN
	OneLifeData7U=$soloUserN
fi

if [ -z "$OneLifeU" ]; then OneLifeU=$defaultUser; fi
if [ -z "$minorGemsU" ]; then minorGemsU=$defaultUser; fi
if [ -z "$OneLifeData7U" ]; then OneLifeData7U=$defaultUser; fi

echo
echo "Enter repository variation name (let blank for default)."
read -p "$OneLifeU's OneLife repository name:" OneLifeN
read -p "$minorGemsU's minorGems repository name:" minorGemsN
read -p "$OneLifeData7U's OneLifeData7 repository name:" OneLifeData7N

if [ -z "$OneLifeN" ]; then OneLifeN="OneLife"; fi
if [ -z "$minorGemsN" ]; then minorGemsN="minorGems"; fi
if [ -z "$OneLifeDataN" ]; then OneLifeData7N="OneLifeData7"; fi

echo
echo "Will clone ${OneLifeU^^}'s $OneLifeN, ${minorGemsU^^}'s $minorGemsN and ${OneLifeData7U^^}'s $OneLifeData7N."
echo
echo "Press enter to start or ctrl c to cancel."
read userIn

git clone https://github.com/$OneLifeU/$OneLifeN.git OneLife
git clone https://github.com/$minorGemsU/$minorGemsN.git minorGems
git clone https://github.com/$OneLifeData7U/$OneLifeData7N.git OneLifeData7
