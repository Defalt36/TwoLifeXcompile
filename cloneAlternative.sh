#!/bin/bash

workdir=".."
buildsdir="../builds"
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"
	
	shallowclone=$(sed '5!d' $settingsfile)
	shallowclone=(${shallowclone:13})
fi


defaultUser="twohoursonelife"

cd $workdir
echo; echo "Remove existing repositories now? "

select yn in "Yes" "No"; do
    case $yn in
        Yes ) rm -rf OneLifeData7; rm -rf minorGems; rm -rf OneLife; echo "Folders removed."; break;;
        No ) echo "Not removed."; break;;
    esac
done

echo; echo "Write anything to override all users. Press enter to continue."

read soloUserN

if [ -z "$soloUserN" ]
then
	echo "Enter github users to clone from. (let blank for default user)"
	read -p "OneLife user:" OLU
	read -p "minorGems user:" MGU
	read -p "OneLifeData7 user:" OLD7U
else
	OLU=$soloUserN
	MGU=$soloUserN
	OLD7U=$soloUserN
fi

if [ -z "$OLU" ]; then OLU=$defaultUser; fi
if [ -z "$MGU" ]; then MGU=$defaultUser; fi
if [ -z "$OLD7U" ]; then OLD7U=$defaultUser; fi

echo; echo "Get repositories with different..."

select nyn in "Names" "Branches" "Both" "None"; do
    case $nyn in
		Names ) askForVarNames=true; askForBranchNames=false; break;;
		Branches ) askForBranchNames=true; askForVarNames=false; break;;
		Both ) askForVarNames=true; askForBranchNames=true; break;;
		None ) askForVarNames=false; askForBranchNames=false; echo "Assuming default names and branches."; break;;
    esac
done

if $askForVarNames
then
	echo; echo "Enter the name of the repository (let blank for default)."
	read -p "${OLU^^}'s OneLife repository name:" OLN
	read -p "${MGU^^}'s minorGems repository name:" MGN
	read -p "${OLD7U^^}'s OneLifeData7 repository name:" OLD7N
fi

if [ -z "$OLN" ]; then OLN="OneLife"; fi
if [ -z "$MGN" ]; then MGN="minorGems"; fi
if [ -z "$OLD7N" ]; then OLD7N="OneLifeData7"; fi

if $askForBranchNames
then
	echo; echo "Enter alternative branch name (let blank for master)."
	read -p "${OLU^^}'s OneLife alternative branch:" OLB
	read -p "${MGU^^}'s minorGems alternative branch:" MGB
	read -p "${OLD7U^^}'s OneLifeData7 alternative branch:" OLDB
fi

if [ -z "$OLB" ]; then OLB="master"; fi
if [ -z "$MGB" ]; then MGB="master"; fi
if [ -z "$OLD7B" ]; then OLD7B="master"; fi

echo; echo "Will clone ${OLU^^}'s $OLN, ${MGU^^}'s $MGN and ${OLD7U^^}'s $OLD7N."

echo; echo "PRESS ENTER TO START OR CTRL-C TO CANCEL."

read userIn

if [ $shallowclone == "yes" ]
then
	echo; echo "Shallow Cloning:"
	git clone --depth=1 https://github.com/$OLU/$OLN.git -b $OLB --single-branch OneLife
	git clone --depth=1 https://github.com/$MGU/$MGN.git -b $MGB --single-branch minorGems
	git clone --depth=1 https://github.com/$OLD7U/$OLD7N.git -b $OLD7B --single-branch OneLifeData7
else
	echo; echo "Normal Cloning:"
	git clone https://github.com/$OLU/$OLN.git -b $OLB --single-branch OneLife
	git clone https://github.com/$MGU/$MGN.git -b $MGB --single-branch minorGems
	git clone https://github.com/$OLD7U/$OLD7N.git -b $OLD7B --single-branch OneLifeData7
fi
