# Dotfiles

## Getting started

### Install Arch

1. `git` needs to be installed on the live environment: `pacman -Syy git`
2. Clone the repository: `git clone https://github.com/Benjman/dotfiles`
3. Either [install Arch according to the installation guide.](https://wiki.archlinux.org/title/Installation_guide), or;
    1. Format the partitions (`mkfs.ext4 /dev/nvme... && mkfs.fat -F 32 /dev/nvme...`)
    2. Mount the partitions.
    3. Execute the [./scripts/live-env.sh](https://github.com/Benjman/dotfiles/blob/main/scripts/live-env.sh) script.
4. Once in an `arch-chroot` environment, run the script [./scripts/chroot.sh](https://github.com/Benjman/dotfiles/blob/main/scripts/chroot.sh) script
    - This should clone a few repositories. Notably [my fork of ML4W's Dotfiles](https://github.com/Benjman/ml4w-dotfiles).
5. Navigate to this cloned repository (Probably in `~/.local/share/repos/ml4w-dotfiles`), and run the setup script:

```sh
cd /path/to/ml4w-dotfiles
cd ./bin
./ml4w-hyprland-setup
```

This setup script should install everything needed for ML4W's flavor of Hyprland.

At the end of the setup script, it should automatically detect the symbolic link [~/.ml4w-hyprland/post.sh](https://github.com/Benjman/dotfiles/blob/main/.ml4w-hyprland/post.sh).

This is my minimum environment for development.
