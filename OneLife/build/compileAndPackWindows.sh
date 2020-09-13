#!/bin/sh

#The pack part of 'compile and pack' is broken

if [ $# -lt 1 ] ; then
   echo "Usage: $0 new_release_number"
   echo "Example: $0 39"
   exit 1
fi

echo
echo "Make sure to git pull all the components"
echo
echo -n "Press ENTER when done."

read userIn


cd ../../minorGems

cd game/diffBundle
#./diffBundleCompile


cd ../../../OneLife

./configure 5
cd gameSource

echo
echo "Building game..."
make
echo "done compiling."

cd ../build

./makeDistributionWindows $1

cd windows_builds

echo
echo "Done."
