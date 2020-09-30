#!/bin/bash

rmbinaries=false

for arg in "$@"
do
    case $arg in
        --rmbinaries)
		rmbinaries=true
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
find . -type f -name '*.o' -exec rm {} +
find . -type f -name '*.dep' -exec rm {} +
find . -type f -name '*.dep2' -exec rm {} +

if [ "$rmbinaries" = true ]
then
	cd OneLife
	rm -vf gameSource/OneLife.exe
	rm -vf gameSource/OneLifeApp
	rm -vf gameSource/EditOneLife.exe
	rm -vf gameSource/EditOneLife
	rm -vf server/OneLifeServer.exe
	rm -vf server/OneLifeServer
fi

echo 
echo "Projects cleaned. Ready for compilation."
