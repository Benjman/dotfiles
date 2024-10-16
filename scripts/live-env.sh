#!/bin/sh

echo ":: set root passwod (needed to ssh"
passwd

echo ":: enabling pacman: color"
sed -i '/#Color/cColor' /etc/pacman.conf

echo ":: enabling pacman: paralleldownloads = 15"
sed -i '/#ParallelDownloads/cParallelDownloads = 15' /etc/pacman.conf

echo ":: updating mirror links..."
echo "--save /etc/pacman.d/mirrorlist" >/etc/xdg/reflector/reflector.conf
echo "--ipv4" >>/etc/xdg/reflector/reflector.conf
echo "--ipv6" >>/etc/xdg/reflector/reflector.conf
echo "--protocol https" >>/etc/xdg/reflector/reflector.conf
echo "--latest 20" >>/etc/xdg/reflector/reflector.conf
echo "--sort rate" >>/etc/xdg/reflector/reflector.conf
echo "--country US" >>/etc/xdg/reflector/reflector.conf
systemctl start reflector

echo ":: refreshing pacman database"
pacman -Syy

echo "echo \":: Installing initial packages\"" >>~/install.sh
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
echo ":: installing initial packages"
pacstrap -K /mnt ${PACKAGES[@]}

echo ":: generated fstab entries"
genfstab -U /mnt >> /mnt/etc/fstab

echo ":: changing to /mnt"
arch-chroot /mnt

echo
echo ":: umounting /mnt recursively..."
umount -R /mnt

echo ":: completed live environment setup complete -- please reboot the pc"
