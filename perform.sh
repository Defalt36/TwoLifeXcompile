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
buildsdir="../builds"
toclean=('LivingLifePage' 'server' 'game')
gamedir="../OneLife/gameSource"
if [ -f "settings.txt" ] ; then
	settingsfile="settings.txt"
	workdir=$(sed '1!d' $settingsfile)
	workdir="${workdir:8}"

	buildsdir=$(sed '2!d' $settingsfile)
	buildsdir="${buildsdir:10}"

	gamedir=$(sed '3!d' $settingsfile)
	gamedir=(${gamedir:8})

	toclean=$(sed '4!d' $settingsfile)
	toclean=(${toclean:8})
fi

GAME=false;EDITOR=false;SERVER=false;BUILD=false;CLEAN=false;RUN=false;STDOUT=false;CLEANALL=false;REMOVEBINARIES=false;COLLECT=false;TRANSLATE=false
if [ $# -lt 1 ] || [ $# -gt 2 ] ; then
	echo "You must use one or two arguments. Open this file in a file editor for more info."
	exit
else
	SMALLFLAGS=true

	for arg in "$@" ; do
		case $arg in
			--stdout)
			echo "Override behavior, opening stdout.txt..."
			STDOUT=true
			break
			;;
			--removebinaries)
			echo "Removing Binaries - yes"
			REMOVEBINARIES=true
			;;
			--cleanall)
			echo "Cleaning All - yes"
			CLEANALL=true
			break
			;;
			--collect)
			echo "Collecting - yes"
			COLLECT=true
			;;
			--translate)
			echo "Translating - yes"
			TRANSLATE=true
			;;
		esac
	done

	if $STDOUT || $REMOVEBINARIES || $CLEANALL || $COLLECT || $TRANSLATE ; then
		SMALLFLAGS=false
	fi

	if $SMALLFLAGS ; then
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
				b)
				echo "Building - yes"
				BUILD=true
				;;
				r)
				echo "Running - yes"
				RUN=true
				;;
				c)
				echo "Cleaning - yes"
				CLEAN=true
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
		if $BUILD || $RUN ; then
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
			echo "Second argument missing or ignored."
		fi
		echo
	fi
fi

cd $workdir

if $REMOVEBINARIES
then
	cd OneLife
	echo
	echo "Cleaning binaries..."
	rm -f gameSource/OneLife
	rm -f gameSource/OneLife.exe
	rm -f gameSource/OneLifeApp
	rm -f gameSource/EditOneLife.exe
	rm -f gameSource/EditOneLife
	rm -f server/OneLifeServer.exe
	rm -f server/OneLifeServer
	echo "Binaries cleaned."
	cd ..
fi

if $CLEANALL
then
	echo "Cleaning all..."
	find . -type f -name '*.o' -not -path "./installed_libraries/*" -exec rm -vf {} +
	find . -type f -name '*.dep' -not -path "./installed_libraries/*" -exec rm -vf {} +
	find . -type f -name '*.dep2' -not -path "./installed_libraries/*" -exec rm -vf {} +
	CLEAN=false
fi

if $CLEAN
then
	echo "Files to clean:" ${toclean[@]}
	echo
	#clean some build files
	if [ ! -z "$toclean" ] ; then
		for filename in ${toclean[@]}
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
		make || exit 1
		cd ../..
	fi

	if $EDITOR
	then
		echo
		echo "Building editor..."
		cd OneLife
		./configure 5
		cd gameSource
		./makeEditorFixed.sh || exit 1
		cd ../..
	fi

	if $SERVER
	then
		echo
		echo "Building server..."
		cd OneLife/server
		./configure 5
		make || exit 1
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

if $STDOUT
then
	cd $gamedir
	cat stdout.txt || echo; echo "missing stdout.txt"
	cd $workdir
	exit
fi

if $COLLECT ; then
	cd $gamedir/objects
	echo "Collecting strings to collected.txt..."
	for file in *
	do
		filename="${file:-8}"
		filename="${filename%.txt}"

		if [ "${#filename}" -lt 5 ] ; then
			oName=$(sed '2!d' $file)
			echo "$file;$oName"
		fi
	done > ../collected.txt
	cp ../collected.txt ../collected-backup.txt
fi

if $TRANSLATE ; then
	cd $gamedir/objects
	echo "Pushing input.txt strings to objects..."
	while read line
	do
		IFS=';' read ADDR1 ADDR2 <<< $line
		filename=$ADDR1
		content=$ADDR2

		echo $ADDR1
		echo $ADDR2

		sed -i "2 c $content" $filename
	done < ../input.txt
	cd $workdir
fi
