#!/usr/bin/env bash
set e

echo "Installing OpenSSH..."
sudo apt install -y openssh-client openssh-server 1> /dev/null

ssh-keygen -q -t ed25519 -a 4096 -P "" -f $HOME/.ssh/id_ed25519

echo "\nPublic SSH Key:"
cat ~/.ssh/id_ed25519.pub
echo "\nWaiting to allow uploading to required sites like Github and Gitlab."
read -p "Press any key to continue..." ignore
