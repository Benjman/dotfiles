#!/bin/sh

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
ln -sf /usr/share/zoneinfo/america/denver /etc/localtime
hwclock --systohc 1&> /dev/null

# TODO: Prompt for locale
echo ":: Generating locale"
echo "lang=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen 1&> /dev/null

# TODO: Prompt for hostname
hostname="ncase"
echo $hostname > /etc/hostname
echo ":: Set hostname to \"$hostname\""

echo ":: Updating pacman.conf"
sed -i '/#Color/cColor' /etc/pacman.conf
sed -i '/#ParallelDownloads/cParallelDownloads = 15' /etc/pacman.conf

echo ":: Updated reflector country"
sed -i "/^#\s--country/c--country US" /etc/pacman.conf

echo ":: Configuring bootloader"
bootctl install
echo "default arch.conf" > /boot/loader/loader.conf
echo "timeout 0" >> /boot/loader/loader.conf
echo "timeout-key space" >> /boot/loader/loader.conf
echo "console-mode max" >> /boot/loader/loader.conf
echo "editor no" >> /boot/loader/loader.conf

echo ":: Configuring bootloader"
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
echo "export XDG_DATA_DIRS=\"\$XDG_DATA_HOME:\$XDG_DATA_DIRS\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "export CARGO_HOME=\$XDG_DATA_HOME/cargo" >> /home/$username/.bashrc
echo "export GNUPGHOME=\$XDG_CONFIG_HOME/gnupg" >> /home/$username/.bashrc
echo "export REPOS=\"$repos_path\"" >> /home/$username/.bashrc
echo "export PASSWORD_STORE_DIR=\"$repos_path\"/password-store" >> /home/$username/.bashrc
echo "export NPM_CONFIG_USERCONFIG=\$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "export WGETRC=\"\$XDG_CONFIG_HOME/wgetrc\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
# TODO: The below can be done inline as the root. Folder creation. Changed ownership to user, etc.
echo "if [ ! -d ~/.config ]; then" >> /home/$username/.bashrc
echo "  mkdir -p \$REPOS" >> /home/$username/.bashrc
echo "  echo \":: Created directory \$REPOS\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  mkdir -p \$GNUPGHOME" >> /home/$username/.bashrc
echo "  echo \":: Created directory \$GNUPGHOME\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  chmod 700 \$GNUPGHOME" >> /home/$username/.bashrc
echo "  echo \":: Set 700 permissions for \$GNUPGHOME\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  mkdir -p \$XDG_CONFIG_HOME/npm" >> /home/$username/.bashrc
echo "  touch \$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "  echo \"prefix=\${XDG_DATA_HOME}/npm\" >> \$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "  echo \"cache=\${XDG_CACHE_HOME}/npm\" >> \$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "  echo \"init-module=\${XDG_CONFIG_HOME}/npm/config/npm-init.js\" >> \$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "  echo \"logs-dir=\${XDG_STATE_HOME}/npm/logs\" >> \$XDG_CONFIG_HOME/npm/npmrc" >> /home/$username/.bashrc
echo "  echo \":: Configured npm\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
echo "  echo hsts-file \= \"\$XDG_CACHE_HOME\"/WGET-HSTS >> \"\$XDG_CONFIG_HOME/wgetrc\"" >> /home/$username/.bashrc
echo "  echo \":: Set hsts-file\"" >> /home/$username/.bashrc
echo "" >> /home/$username/.bashrc
#TODO: Prompt for git info
user_email="benjamin.s.record@gmail.com"
user_name="Ben Record"
echo "  mkdir \$XDG_CONFIG_HOME/git" >> /home/$username/.bashrc
echo "  touch \$XDG_CONFIG_HOME/git/config" >> /home/$username/.bashrc
echo "  echo \"[user]\" >> \$XDG_CONFIG_HOME/git/config" >> /home/$username/.bashrc
echo "  echo \"  email = $user_email\" >> \$XDG_CONFIG_HOME/git/config" >> /home/$username/.bashrc
echo "  echo \"  name = $user_name\" >> \$XDG_CONFIG_HOME/git/config" >> /home/$username/.bashrc
echo "  echo \":: Configured ~/.config/git\"" >> /home/$username/.bashrc
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
echo "" >> /home/$username/.bashrc
echo "  mkdir /home/$username/.ml4w-hyprland" >> /home/$username/.bashrc
echo "  ln -s $repos_path/dotfiles/.ml4w-hyprland/*.sh /home/$username/.ml4w-hyprland/" >> /home/$username/.bashrc
echo "fi" >> /home/$username/.bashrc
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

# TODO: Prompt asking to wait for SSH keys to be installed, then attempt to clone needed repositories.
# echo
# echo ":: Cloining needed repositories"
# clone_base="https://github.com/"
# if [ ! -d /home/$username/.ssh ]; then
#   "clonse_base=git@github.com:"
# fi

if [ ! -z $clone_base ]; then
  [[ ! -d /home/$username/.config ]] && mkdir /home/$username/.config
  repos_to_clone=(
    dotfiles
    ml4w-dotfiles
  )

  for repo in "${symlinks[@]}"; do
    git clone ${clone_base}/Benjman/dotfiles $repos_path/$repo
    chown -R $username:$username $repos_path/$repo
  done

  ln -sf $repos_path/dotfiles/.config/nvim /home/$username/.config/nvim
  chown -R $username:$username /home/$username/.config/nvim

  mkdir /home/$username/.ml4w-hyprland
  if [ -f $repos_path/dotfiles/.ml4w-hyprland/post.sh ]; then
    if [ -f $repos_path/dotfiles/.ml4w-hyprland/post.sh ]; then
      ln -s $repos_path/dotfiles/.ml4w-hyprland/post.sh /home/$username/.ml4w-hyprland/post.sh
      chmod +x /home/$username/.ml4w-hyprland/post.sh
    fi
    if [ -f $repos_path/dotfiles/.ml4w-hyprland/hook.sh ]; then
      ln -s $repos_path/dotfiles/.ml4w-hyprland/hook.sh /home/$username/.ml4w-hyprland/hook.sh
      chmod +x /home/$username/.ml4w-hyprland/hook.sh
    fi
  fi
  chown -R $username:$username /home/$username/.ml4w-hyprland
fi

echo
echo ":: Configuration complete. exit, umount partitions, and reboot."
