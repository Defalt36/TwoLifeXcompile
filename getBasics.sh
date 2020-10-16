cd ..
#you may need this before procceeding
sudo apt-get --assume-yes update

#actual basics
sudo apt-get --assume-yes install git g++ imagemagick xclip libsdl1.2-dev libglu1-mesa-dev libgl1-mesa-dev

#install mingw
sudo apt-get --assume-yes install mingw-w64

#mingw don't come with make command by default on ubuntu 20.04, so let's just install this
sudo apt-get --assume-yes install build-essential

#install 7zip in case you want to pack the game
sudo apt-get --assume-yes install p7zip-full
