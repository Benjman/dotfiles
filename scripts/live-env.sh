#!/usr/bin/env /usr/bin/bash

echo ":: Enabling pacman: Color"
sed -i '/#Color/cColor' /etc/pacman.conf

echo ":: Enabling pacman: ParallelDownloads = 15"
sed -i '/#ParallelDownloads/cParallelDownloads = 15' /etc/pacman.conf

echo ":: Updating mirror links..."
echo "--save /etc/pacman.d/mirrorlist" >/etc/xdg/reflector/reflector.conf
echo "--ipv4" >>/etc/xdg/reflector/reflector.conf
echo "--ipv6" >>/etc/xdg/reflector/reflector.conf
echo "--protocol https" >>/etc/xdg/reflector/reflector.conf
echo "--latest 20" >>/etc/xdg/reflector/reflector.conf
echo "--sort rate" >>/etc/xdg/reflector/reflector.conf
echo "--country US" >>/etc/xdg/reflector/reflector.conf
systemctl start reflector

echo ":: Refreshing pacman database"
pacman -Syy

# TODO: Detect CPU and auto install ucodes? Else prompt for selection.
ucode=amd-ucode
PACKAGES=(
  $ucode
  base
  base-devel
  dhcpcd
  git
  lazygit
  linux
  linux-firmware
  neovim
  networkmanager
  nvidia
  nvidia-utils
  openssh
  reflector
)
echo ":: Installing initial packages"
pacstrap -K /mnt ${PACKAGES[@]}

echo ":: Generated fstab entries"
genfstab -U /mnt >>/mnt/etc/fstab

echo ":: Ready to arch-chroot /mnt"
echo ":: Script complete"
