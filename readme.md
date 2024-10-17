# Development Environment Setup

Follow these steps to configure your Arch Linux development environment:

1. Start by following the [Arch Linux installation guide](https://wiki.archlinux.org/title/Installation_guide) until reach the live environment.
2. Partition your hard drive according to your needs.
3. [Mount the partitions](https://wiki.archlinux.org/title/Installation_guide#Mount_the_file_systems).
4. Download and run the live environment install script:

```sh
curl -O https://raw.githubusercontent.com/Benjman/dotfiles/main/scripts/live-env.sh && /bin/bash live-env.sh
```

5. Once in the `/mnt` environment, download and execute the chroot install script: `curl -O https://raw.githubusercontent.com/Benjman/dotfiles/main/scripts/chroot.sh && /bin/bash chroot.sh`
6. Exit the chroot environment, and unmount the partitions: `umount -R /mnt`
7. Reboot
8. Log in as your user. During the first login, user-specific configurations will be executed, which includes:
    - Cloning repositories for further setup of [Hyprland](https://github.com/hyprwm/Hyprland), [ML4W Dotfiles](https://github.com/Benjman/ml4w-dotfiles), and [your personal Dotfiles](https://github.com/Benjman/dotfiles).
    - Preparing the hook scripts for ML4W Dotfiles
9. Run the ML4W setup script:

```sh
cd ~/.local/share/repos/ml4w-dotfiles/bin
./ml4w-hyprland-setup
```

10. During the setup execution, it should detect the hook files:

    - [~/.ml4w-hyprland/post.sh](https://github.com/Benjman/dotfiles/blob/main/.ml4w-hyprland/post.sh)
    - [~/.ml4w-hyprland/hook.sh](https://github.com/Benjman/dotfiles/blob/main/.ml4w-hyprland/hook.sh)

Once the setup is complete, you should be all set!
