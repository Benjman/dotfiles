#!/usr/bin/bash
set -e

INSTALL_DIR=~/.local/lib/postman

#wget -O /tmp/postman.tar.gz -- https://dl.pstmn.io/download/latest/linux64

[ -d $INSTALL_DIR ] && rm -r $INSTALL_DIR
mkdir -p $INSTALL_DIR

tar -xf /tmp/postman.tar.gz -C $INSTALL_DIR

[ -f ~/.local/bin/postman ] && rm ~/.local/bin/postman
ln -s $INSTALL_DIR/Postman/Postman ~/.local/bin/postman

echo "[Desktop Entry]"                                                          > ~/.local/share/applications/postman.desktop
echo "Name=Postman"                                                            >> ~/.local/share/applications/postman.desktop
echo "Exec=$(echo ~)/.local/bin/postman"                                       >> ~/.local/share/applications/postman.desktop
echo "Icon=$(echo ~)/.local/lib/postman/Postman/app/icons/icon_128x128.png"    >> ~/.local/share/applications/postman.desktop
echo "Terminal=false"                                                          >> ~/.local/share/applications/postman.desktop
echo "Type=Application"                                                        >> ~/.local/share/applications/postman.desktop
