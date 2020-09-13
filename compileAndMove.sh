cd ../OneLife/build

NOW=$(date '+(%F,%H%M)')
./compileAndPackWindows.sh "$NOW"

cd ../../

if [ ! -e windows_builds ]
then
	mkdir windows_builds
fi

mv "OneLife/build/windows_builds/2hol_$NOW" "windows_builds/"
rmdir --ignore-fail-on-non-empty OneLife/build/windows_builds

