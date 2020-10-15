#!/bin/bash

rmbinaries=false
selectiveRemoval=false

for arg in "$@"
do
    case $arg in
        --rmbinaries)
		rmbinaries=true
		shift
        ;;
		--selective)
		selectiveRemoval=true
		shift
		;;
        *)
		echo "Unrecognised flag"
		exit 1
		shift
        ;;
    esac
done

cd ..

if $selectiveRemoval
then
	echo
	echo "Write filenames to clean. Write nothing to proceed."
	while read line
	do
		if [ -z "$line" ]
		then
			break
		fi
		toclean=("${toclean[@]}" $line)
	done
	
	echo
	echo "Cleaning..."
	
	for filename in "${toclean[@]}"
		do
			if [ -z "$filename" ]; then 
				exit
			fi
			
			find . -type f -name $filename.o -exec rm -vf {} +
			find . -type f -name $filename.dep -exec rm -vf {} +
			find . -type f -name $filename.dep2 -exec rm -vf {} +
			
			echo "Cleaned $filename."
	done
else
	echo
	echo "Cleaning all..."
	find . -type f -name '*.o' -exec rm {} +
	find . -type f -name '*.dep' -exec rm {} +
	find . -type f -name '*.dep2' -exec rm {} +
fi

echo "All clean."

if $rmbinaries
then
	cd OneLife
	echo
	echo "Cleaning binaries..."
	rm -vf gameSource/OneLife.exe
	rm -vf gameSource/OneLifeApp
	rm -vf gameSource/EditOneLife.exe
	rm -vf gameSource/EditOneLife
	rm -vf server/OneLifeServer.exe
	rm -vf server/OneLifeServer
	echo "Binaries cleaned."
fi

echo 
echo "Projects cleaned. Ready for compilation."
