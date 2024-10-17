#!/usr/bin/env /usr/bin/bash

echo
echo ":: Set root password"
passwd

# TODO: Prompt for username
echo
username="ben"
useradd -m -G wheel,users -s /usr/bin/bash $username
echo ":: User $username created"
echo ":: Set $username password"
passwd $username

# TODO: As the root user, couldn't se just `sed` permissions to our needs?
echo
sed -i "/^#\s\+%wheel ALL=(ALL:ALL) NOPASSWD: ALL/c%wheel ALL=(ALL:ALL) NOPASSWD: ALL" /etc/sudoers
echo ":: Enabled wheel sudo authority"

# TODO: Prompt for zone info. Maybe query directory and files, with a default.
echo ":: Configuring system clock"
ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
hwclock --systohc 1 &>/dev/null

# TODO: Prompt for locale
echo ":: Generating locale"
echo "lang=en_US.UTF-8" >/etc/locale.conf
echo "en_US.UTF-8 UTF-8" >/etc/locale.gen
locale-gen 1 &>/dev/null

# TODO: Prompt for hostname
hostname="ncase"
echo $hostname >/etc/hostname
echo ":: Set hostname to \"$hostname\""

echo ":: Updating pacman.conf"
sed -i '/#Color/cColor' /etc/pacman.conf
sed -i '/#ParallelDownloads/cParallelDownloads = 15' /etc/pacman.conf

echo ":: Updated reflector country"
sed -i "/^#\s--country/c--country US" /etc/xdg/reflector/reflector.conf

echo ":: Configuring bootloader"
bootctl install
echo "default arch.conf" >/boot/loader/loader.conf
echo "timeout 0" >>/boot/loader/loader.conf
echo "timeout-key space" >>/boot/loader/loader.conf
echo "console-mode max" >>/boot/loader/loader.conf
echo "editor no" >>/boot/loader/loader.conf

echo ":: Configuring bootloader"
touch /boot/loader/entries/arch.conf
echo "title arch linux" >/boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >>/boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >>/boot/loader/entries/arch.conf
echo "options root=$(grep "ext4" /etc/fstab | awk '{print $1}') rw" >>/boot/loader/entries/arch.conf

#TODO: Prompt for these:
repos_path=.local/share/repos
user_email="benjamin.s.record@gmail.com"
user_name="Ben Record"

cat <<EOF >/home/$username/.bashrc
#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias lg='lazygit'
alias wget='wget --hsts-file="\$XDG_CACHE_HOME/wget-hsts"'
alias make='make -j${nproc}'
ps1='[\u@\h \w]\$ '

export XDG_CONFIG_HOME="\$HOME/.config"
export XDG_CACHE_HOME="\$HOME/.cache"
export XDG_DATA_HOME="\$HOME/.local/share"
export XDG_STATE_HOME="\$HOME/.local/state"
export XDG_DATA_DIRS="\$XDG_DATA_HOME:\$XDG_DATA_DIRS"

export CARGO_HOME="\$XDG_DATA_HOME/cargo"
export GNUPGHOME="\$XDG_CONFIG_HOME/gnupg"
export REPOS="\$HOME/$repos_path"
export PASSWORD_STORE_DIR="\$REPOS/password-store"
export NPM_CONFIG_USERCONFIG="\$XDG_CONFIG_HOME/npm/npmrc"

if [ ! -d \$HOME/.config ]; then
  mkdir -p \$GNUPGHOME
  echo ":: Created directory \$GNUPGHOME"

  chmod 700 \$GNUPGHOME
  echo ":: Set 700 permissions for \$GNUPGHOME"

  mkdir -p \$XDG_CONFIG_HOME/npm
  touch \$XDG_CONFIG_HOME/npm/npmrc
  echo "prefix=\$XDG_DATA_HOME/npm" >> \$XDG_CONFIG_HOME/npm/npmrc
  echo "cache=\$XDG_CACHE_HOME/npm" >> \$XDG_CONFIG_HOME/npm/npmrc
  echo "init-module=\$XDG_CONFIG_HOME/npm/config/npm-init.js" >> \$XDG_CONFIG_HOME/npm/npmrc
  echo "logs-dir=\$XDG_STATE_HOME/npm/logs" >> \$XDG_CONFIG_HOME/npm/npmrc
  echo ":: Configured npm"

  mkdir \$XDG_CONFIG_HOME/git
  touch \$XDG_CONFIG_HOME/git/config
  echo "[init]" >> \$XDG_CONFIG_HOME/git/config
  echo "  defaultBranch = main" >> \$XDG_CONFIG_HOME/git/config
  echo "" >> \$XDG_CONFIG_HOME/git/config
  echo "[user]" >> \$XDG_CONFIG_HOME/git/config
  echo "  email = $user_email" >> \$XDG_CONFIG_HOME/git/config
  echo "  name = $user_name" >> \$XDG_CONFIG_HOME/git/config
  echo ":: Configured ~/.config/git"

  clone_base=https://github.com/

  if [ ! -d \$HOME/.ssh ]; then
    echo ":: ~/.ssh not found. transfer keys and/or press enter to continue..."
    read
  fi

  if [ -d \$HOME/.ssh ]; then
    clone_base=git@github.com:
  fi

  echo ":: Updating mirror database..."
  sudo pacman -Syy

  mkdir -p \$REPOS
  echo ":: Created directory \$REPOS"

  git clone ${clone_base}benjman/ml4w-dotfiles \$REPOS/ml4w-dotfiles
  git clone ${clone_base}benjman/dotfiles \$REPOS/dotfiles

  mkdir \$HOME/.ml4w-hyprland
  ln -s \$REPOS/dotfiles/.ml4w-hyprland/*.sh \$HOME/.ml4w-hyprland/
  cd \$REPOS/ml4w-dotfiles/bin
fi
EOF
echo ":: Populated .bashrc for user $username"

echo
echo ":: Enabling dhcpcd.service"
systemctl enable dhcpcd.service
echo ":: Enabling NetworkManager.service"
systemctl enable NetworkManager.service
echo ":: Enabling reflector.service"
systemctl enable reflector.service
echo ":: Enabling sshd.service"
systemctl enable sshd.service

echo
echo ":: Configuration complete. exit, umount partitions, and reboot."
