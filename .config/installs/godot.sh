#!/usr/bin/env bash
set -e

BRANCH='3.4'
if [ -z '$BRANCH' ]; then
  BRANCH='master'
fi


sudo apt install -y \
  build-essential \
  scons \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu-dev \
  libasound2-dev \
  libpulse-dev \
  libudev-dev \
  libxi-dev \
  libxrandr-dev \
  yasm

pushd . > /dev/null

BRANCH='3.4'
[[ -z '$BRANCH' ]] && BRANCH='master'

sudo apt install -y \
  build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
  libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm

git clone --branch $BRANCH -- https://github.com/godotengine/godot.git ~/.local/lib/godot/$BRANCH

pushd . > /dev/null
cd ~/.local/lib/godot/$BRANCH
scons -j32 platform=x11 use_llvm=yes
popd > /dev/null

echo "[Desktop Entry]"                                                      > ~/.local/share/applications/godot.desktop
echo "Name=Godot Engine"                                                   >> ~/.local/share/applications/godot.desktop
echo "Exec=/home/ben/.local/lib/godot/$BRANCH/bin/godot.x11.tools.64.llvm" >> ~/.local/share/applications/godot.desktop
echo "Icon=/home/ben/.local/lib/godot/$BRANCH/icon.svg"                    >> ~/.local/share/applications/godot.desktop
echo "Terminal=false"                                                      >> ~/.local/share/applications/godot.desktop
echo "Type=Application"                                                    >> ~/.local/share/applications/godot.desktop
