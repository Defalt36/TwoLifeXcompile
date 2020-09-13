cd ..
find . -type f -name '*.o' -exec rm {} +
find . -type f -name '*.dep' -exec rm {} +
find . -type f -name '*.dep2' -exec rm {} +
echo 
echo "Projects cleaned. Ready for compilation."