#!/usr/bin/env bash
set -e
pushd .

BRANCH='3.4'

sudo apt install -y \
  build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
  libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm

if [ -z '$BRANCH' ]; then
  BRANCH='master'
fi
echo $BRANCH

git clone --branch $BRANCH -- https://github.com/godotengine/godot.git ~/.local/lib/godot/$BRANCH

cd ~/.local/lib/godot/$BRANCH
scons -j32 platform=x11 use_llvm=yes

"[Desktop Entry]"                                                      > ~/.local/share/applications/godot.desktop
"Name=Godot Engine"                                                   >> ~/.local/share/applications/godot.desktop
"Exec=/home/ben/.local/lib/godot/$BRANCH/bin/godot.x11.tools.64.llvm" >> ~/.local/share/applications/godot.desktop
"Icon=/home/ben/.local/lib/godot/$BRANCH/icon.svg"                    >> ~/.local/share/applications/godot.desktop
"Terminal=false"                                                      >> ~/.local/share/applications/godot.desktop
"Type=Application"                                                    >> ~/.local/share/applications/godot.desktop
