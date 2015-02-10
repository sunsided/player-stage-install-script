#!/bin/bash

#version variables
stage_version="4.1.1"
stage_tag="v4.1.1"
player_version="3.0.2"
player_revision="9142"

#load data
cmakelists=`cat CMakeLists.txt`
patch_file=`cat readlog_patch.cc`

#install dependencies - unattended
echo "Installing dependencies in unattended mode..."
sudo apt-get -y install g++ pkg-config cmake libfltk1.1 libfltk1.1-dev freeglut3 freeglut3-dev libpng12-0 libpng12-dev libtool libltdl7 libltdl-dev libboost-thread-dev libboost-signals-dev libdb5.1-stl

# source the library paths
source paths.txt

#memorize directory
pushd .

#make a directory to keep the source files
echo "Preparing install directory..."
mkdir src 2> /dev/null
rm src/*.tar.gz 2> /dev/null
rm src/*.tar.gz.* 2> /dev/null
cd src

#get player and stage
echo "Getting player source files..."
if [ -x "$(command -v svn)" ]; then
	echo "- selected subversion strategy for player"
	rm -rf player-$player_version 2> /dev/null
	svn co https://svn.code.sf.net/p/playerstage/svn/code/player/trunk/@$player_revision player-$player_version
else
	echo "- selected wget strategy for player"
	wget http://sourceforge.net/projects/playerstage/files/Player/$player_version/player-$player_version.tar.gz
	tar xvf player-$player_version.tar.gz
fi

#get stage
echo "Getting stage source files..."
if [ -x "$(command -v git)" ]; then
	echo "- selected git strategy for stage"
	rm -rf Stage-$stage_version 2> /dev/null
	git clone --depth 1 https://github.com/rtv/Stage.git Stage-$stage_version
	cd v$stage_version
	git checkout tags/$stage_tag
	cd ..
else
	echo "- selected wget strategy for stage"
	wget https://github.com/rtv/Stage/archive/v$stage_version.tar.gz
	tar xvf v$stage_version.tar.gz
fi

#Patching Player
echo "$patch_file" > player-$player_version/server/drivers/shell/readlog.cc

#make player
echo "Building player..."
cd player-$player_version
mkdir build
cd build
cmake ..
sudo make install

#switch to Stage directory
cd ../..
cd Stage-$stage_version

#copy updated make file to Stage 4.*
echo "Preparing stage for install..."
echo "$cmakelists" > libstage/CMakeLists.txt

#make stage
echo "Building stage..."
mkdir build
cd build
cmake ..
sudo make install

#go back to the home directory
popd