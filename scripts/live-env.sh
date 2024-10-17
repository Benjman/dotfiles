#!/usr/bin/env bash

#
# This scripts assumes the drive partitions have been formatted, and mounted. It
# expects at least an `ext4` partition to be present, and will be used to help
# configure `systemd-boot` in the `chroot.sh` script.
#

# TODO: - Display a `gum` prompt asking if the drive has been partitioned by tue user yet. This will need to have the option to `--quiet`.
#       - Detect if an `ext4` is present, and warn the user if it isn't found.

echo ":: Beginning configuration from an Arch live environment"

echo ":: Configuring pacman"
sed -i "/#Color/cColor" /etc/pacman.conf
echo ":: Pacman :: Enabled color"

parallelDownloads=50
sed -i "/#ParallelDownloads/cParallelDownloads = $parallelDownloads" /etc/pacman.conf
echo ":: Pacman :: Set ParallelDownloads to $parallelDownloads"

reflector \
  --save /etc/pacman.d/mirrorlist \
  --ipv4 \
  --ipv6 \
  --protocol https \
  --latest $parallelDownloads \
  --sort rate \
  --country US \
  --verbose

  echo ":: Updating mirror links with reflector..."
  systemctl enable --now reflector
fi

echo ":: Updating pacman database"
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

# Download chroot.sh
echo "" >>/mnt/root/.bashrc # Intentional blank line
# TODO: Ask the user if they want to download chroot.sh
save_path=/tmp/chroot.sh
echo "curl -o $save_path https://raw.githubusercontent.com/Benjman/dotfiles/main/scripts/chroot.sh"
echo "echo \":: Downloaded $save_path\""
# TODO: Ask the uesr if they want to run /tmp/chroot.sh

echo ":: Script complete. Run \"arch-chroot /mnt\" to continue."
