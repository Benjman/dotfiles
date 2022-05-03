#!/usr/bin/env bash
set -e

sudo apt install -y git cmake xorg-dev libglu1-mesa-dev \
  ffmpeg libavcodec-dev libavcodec-extra libavfilter-dev libavfilter-extra libavdevice-dev libavformat-dev libavutil-dev libswscale-dev libv4l-dev libjpeg-dev libpng-dev libtiff-dev \

git clone https://github.com/patriciogonzalezvivo/glslViewer.git ~/.local/lib/glslViewer
cd ~/.local/lib/glslViewer
git submodule init
git submodule update
mkdir build && cd build
cmake ..
make -j 24
sudo make install

