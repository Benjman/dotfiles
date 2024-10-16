#!/bin/sh

echo
echo ":: set root password"
passwd

# TODO: Prompt for username
echo
username="ben"
useradd -m -g wheel,users -s /usr/bin/bash $username
echo ":: user $username created"
echo ":: set $username password"
passwd $username

# TODO: As the root user, couldn't se just `sed` permissions to our needs?
echo
echo ":: preparing to set visudo"
sleep 2
visual=nvim visudo
echo ":: visudo complete"

# TODO: Prompt for zone info. Maybe query directory and files, with a default.
echo ":: configuring system clock"
ln -sf /usr/share/zoneinfo/america/denver /etc/localtime
hwclock --systohc 1&> /dev/null

# TODO: Prompt for locale
echo ":: generating locale"
echo "lang=en_us.utf-8" > /etc/locale.conf
echo "en_us.utf-8 utf-8" > /etc/locale.gen
locale-gen 1&> /dev/null

# TODO: Prompt for hostname
hostname="ncase"
echo $hostname > /etc/hostname
echo ":: set hostname to \"$hostname\""

echo ":: updating pacman.conf"
sed -i '/#Color/cColor' /etc/pacman.conf
sed -i '/#ParallelDownloads/cParallelDownloads = 15' /etc/pacman.conf

echo ":: updated reflector country"
echo "--country us" >> /etc/xdg/reflector/reflector.conf

echo ":: configuring bootloader"
bootctl install 1&> /dev/null
echo "default arch.conf" > /boot/loader/loader.conf
echo "timeout 0" >> /boot/loader/loader.conf
echo "timeout-key space" >> /boot/loader/loader.conf
echo "console-mode max" >> /boot/loader/loader.conf
echo "editor no" >> /boot/loader/loader.conf

echo ":: configuring bootloader"
touch /boot/loader/entries/arch.conf
echo "title arch linux" > /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "options root=$(grep "ext4" /etc/fstab | awk '{print $1}') rw" >> /boot/loader/entries/arch.conf

#TODO: Prompt for repos_path path
repos_path=/home/$username/.local/share/repos
echo "#" > /home/$username/.bashrc
echo "# ~/.bashrc" >> /home/$username/.bashrc
echo "#" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "# if not running interactively, don't do anything" >> /home/$username/.bashrc
echo "[[ \$- != *i* ]] && return" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "alias ls='ls --color=auto'" >> /home/$username/.bashrc
echo "alias grep='grep --color=auto'" >> /home/$username/.bashrc
echo "alias lg='lazygit'" >> /home/$username/.bashrc
echo "alias wget='wget --hsts-file=\"\$XDG_CACHE_HOME/wget-hsts\"'" >> /home/$username/.bashrc
echo "alias make='make -j${nproc}'" >> /home/$username/.bashrc
echo "ps1='[\u@\h \w]\\$ '" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "export XDG_CONFIG_HOME=\"\$HOME/.config\"" >> /home/$username/.bashrc
echo "export XDG_CACHE_HOME=\"\$HOME/.cache\"" >> /home/$username/.bashrc
echo "export XDG_DATA_HOME=\"\$HOME/.local/share\"" >> /home/$username/.bashrc
echo "export XDG_STATE_HOME=\"\$HOME/.local/state\"" >> /home/$username/.bashrc
echo "export XDG_DATA_DIRS=\"\$XDG_DATA_HOME:\$XDG_DATA_DIRS\"" >> /home/$username/.BASHRC
echo "" >> /home/$username/.bashrc
echo "export CARGO_HOME=\$XDG_DATA_HOME/CARGO" >> /home/$username/.BASHRC
echo "export GNUPGHOME=\$XDG_CONFIG_HOME/GNUPG" >> /home/$username/.BASHRC
echo "export REPOS=\"$REPOS\"" >> /home/$username/.BASHRC
echo "export PASSWORD_STORE_DIR=\"$REPOS\"/password-store" >> /home/$username/.bashrc
echo "export NPM_CONFIG_USERCONFIG=\$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.bashrc
echo "export WGETRC=\"\$XDG_CONFIG_HOME/WGETRC\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
# TODO: The below can be done inline as the root. Folder creation. Changed ownership to user, etc.
echo "if [ ! -d ~/.config ]; then" >> /home/$username/.bashrc
echo "  mkdir ~/.config" >> /home/$username/.bashrc
echo "  mkdir -p \$REPOS" >> /home/$username/.bashrc
echo "  echo \":: created directory \$REPOS\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  mkdir -p \$GNUPGHOME" >> /home/$username/.bashrc
echo "  echo \":: created directory \$GNUPGHOME\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  chmod 700 \$GNUPGHOME" >> /home/$username/.bashrc
echo "  echo \":: set 700 permissions for \$GNUPGHOME\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  mkdir -p \$XDG_CONFIG_HOME/NPM" >> /home/$username/.BASHRC
echo "  touch \$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.BASHRC
echo "  echo \"prefix=\${XDG_DATA_HOME}/npm\" >> \$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.BASHRC
echo "  echo \"cache=\${XDG_CACHE_HOME}/npm\" >> \$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.BASHRC
echo "  echo \"init-module=\${XDG_CONFIG_HOME}/npm/config/npm-init.js\" >> \$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.BASHRC
echo "  echo \"logs-dir=\${XDG_STATE_HOME}/npm/logs\" >> \$XDG_CONFIG_HOME/NPM/NPMRC" >> /home/$username/.BASHRC
echo "  echo \":: configured npm" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  echo hsts-file \= \"\$XDG_CACHE_HOME\"/WGET-HSTS >> \"\$XDG_CONFIG_HOME/WGETRC\"" >> /home/$username/.BASHRC
echo "  echo \":: set hsts-file\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  mkdir \$XDG_CONFIG_HOME/GIT" >> /home/$username/.BASHRC
echo "  touch \$XDG_CONFIG_HOME/GIT/CONFIG" >> /home/$username/.BASHRC
echo "  echo \"[user]\" >> \$XDG_CONFIG_HOME/GIT/CONFIG" >> /home/$username/.BASHRC
#TODO: Prompt for git info
user_email="benjamin.s.record@gmail.com"
user_name="Ben Record"
echo "  echo \"  email = $user_email\" >> \$XDG_CONFIG_HOME/GIT/CONFIG" >> /home/$username/.BASHRC
echo "  echo \"  name = $user_name\" >> \$XDG_CONFIG_HOME/GIT/CONFIG" >> /home/$username/.BASHRC
echo "  echo \":: configured ~/.config/git\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  clone_base=https://github.com/" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  if [ ! -d ~/.ssh ]; then" >> /home/$username/.bashrc
echo "    echo \":: ~/.ssh not found. transfer keys and/or press enter to continue...\"" >> /home/$username/.bashrc
echo "    read" >> /home/$username/.bashrc
echo "  fi" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  if [ -d ~/.ssh ]; then" >> /home/$username/.bashrc
echo "    clone_base=git@github.com:" >> /home/$username/.bashrc
echo "  fi" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  git clone \${clone_base}benjman/ml4w-dotfiles \$REPOS/ml4w-dotfiles" >> /home/$username/.bashrc
echo "  git clone \${clone_base}benjman/dotfiles \$REPOS/dotfiles" >> /home/$username/.bashrc
echo "fi" >> /home/$username/.bashrc
echo ":: populated .bashrc for user $username"

echo
echo ":: enabling dhcpcd.service"
systemctl enable dhcpcd.service
echo ":: enabling networkmanager.service"
systemctl enable networkmanager.service
echo ":: enabling reflector.service"
systemctl enable reflector.service
echo ":: enabling sshd.service"
systemctl enable sshd.service

# TODO: Prompt asking to wait for SSH keys to be installed, then attempt to clone needed repositories.
# echo
# echo ":: cloining needed repositories"
# clone_base="https://github.com/"
# if [ ! -d /home/$username/.ssh ]; then
#   "clonse_base=git@github.com:"
# fi

if [ -z $clone_base ]; then
  git clone ${clone_base}/Benjman/dotfiles $repos_path/dotfiles
  chown $username:$username $repos_path/dotfiles

  git clone ${clone_base}/Benjman/ml4w-dotfiles $repos_path/ml4w-dotfiles
  chown $username:$username $repos_path/ml4w-dotfiles

  ln -sf $repos_path/dotfiles/.config/nvim /home/$username/.config/nvim
  chown $username:$username /home/$username/.config/nvim

  mkdir /home/$username/.ml4w-hyprland
  ln -s $repos_path/dotfiles/.ml4w-hyprland/post.sh /home/$username/.ml4w-hyprland/post.sh
  chmod +x /home/$username/.ml4w-hyprland/post.sh
fi

echo
echo ":: configuration complete. exit, umount partitions, and reboot."
