#!/usr/bin/env bash
set -e

CCLS_HOME=~/.local/lib/ccls

git clone --depth=1 --recursive https://github.com/MaskRay/ccls $CCLS_HOME

cmake \
	-H$CCLS_HOME \
	-B$CCLS_HOME/Release \
	-DCMAKE_BUILD_TYPE=Release

echo "Ignore any \"fatal: No names found, cannot describe anything.\" from above, per ccls github build instructions."

cmake --build $CCLS_HOME/Release

if [ ! -x ccls ]
then
	echo "#!/bin/sh" >> ~/.local/lib/ccls.sh
	echo "exec \"$CCLS_HOME/Release/ccls\" \"\$0\"" >> ~/.local/lib/ccls.sh
	chmod +x ~/.local/lib/ccls.sh
	ln -s ~/.local/lib/ccls.sh ~/.local/bin/ccls
fi

