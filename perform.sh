#!/bin/bash

################ARGUMENTS
#first arg: ./perform.sh -'letters'
#b = build, c = clean, r = run
#
#second arg: ./perform.sh -'letters' 'letters'
#g=game, e=editor, s=server
#
#letters in any order are accepted


############CONFIGURATION
workdir=".."
toClean=('LivingLifePage' 'server')


GAME=false;EDITOR=false;SERVER=false;BUILD=false;CLEAN=false;RUN=false
if [ $# -lt 1 ] || [ $# -gt 2 ]
then
	echo "You must use one or two arguments. Open this file in a file editor for more info."
	exit
else
	arguments1=($(echo $1 | fold -w1))
	arguments2=($(echo $2 | fold -w1))
	if [ ! ${arguments1[0]} == "-" ] ; then
		exit
	fi
	echo
	#check specified arguments
	for arg in ${arguments1[@]}
	do
		case $arg in
			c)
			echo "Cleaning yes"
			CLEAN=true
			;;
			b)
			echo "Building yes"
			BUILD=true
			;;
			r)
			echo "Running yes"
			RUN=true
			;;
			-)
			;;
			*)
			echo "$arg character unrecognized."
			exit
			;;
		esac
	done
	echo
	#check -b or -r sub arguments
	if $BUILD || $RUN
	then
		#check specified arguments
		for arg in ${arguments2[@]}
		do
			case $arg in
				g)
				echo "Game yes"
				GAME=true
				;;
				e)
				echo "Editor yes"
				EDITOR=true
				;;
				s)
				echo "Server yes"
				SERVER=true
				;;
				*)
				echo "$arg character unrecognized."
				exit
				;;
			esac
		done
	else
		echo "Second argument ignored."
	fi
	echo
fi

cd $workdir

if $CLEAN
then
	#clean some build files
	if [ ! -z "$toClean" ] ; then
		for filename in ${toClean[@]}
		do
			if [ -z $filename ]; then 
				exit
			fi
			
			find . -type f -name $filename.o -exec rm -vf {} +
			find . -type f -name $filename.dep -exec rm -vf {} +
			find . -type f -name $filename.dep2 -exec rm -vf {} +
		done
	fi
fi

if $BUILD
then
	if $GAME
	then
		echo
		echo "Building game..."
		cd OneLife
		./configure 5
		cd gameSource
		make
		cd ../..
	fi

	if $EDITOR
	then
		echo
		echo "Building editor..."
		cd OneLife
		./configure 5
		cd gameSource
		./makeEditorFixed.sh
		cd ../..
	fi

	if $SERVER
	then
		echo
		echo "Building server..."
		cd OneLife/server
		./configure 5
		make
		cd ../..
	fi
fi

if $RUN
then
	echo
	echo "Opening binaries..."
	rm -f openBinaries.bat
	echo "@echo off" > openBinaries.bat
	if $GAME; then
		echo "cd OneLife\gameSource"
		echo "start OneLife.exe"
		echo "cd ..\.."
	fi >> openBinaries.bat
	if $EDITOR; then
		echo "cd OneLife\gameSource"
		echo "start EditOneLife.exe"
		echo "cd ..\.."
	fi >> openBinaries.bat
	if $SERVER; then
		echo "cd OneLife\server"
		echo "start OneLifeServer.exe"
		echo "cd ..\.."
	fi >> openBinaries.bat

	cmd.exe /c openBinaries.bat
	rm -f openBinaries.bat
fi
