#!/bin/sh

install_yay() {
    git clone https://aur.archlinux.org/yay.git "$HOME/wip/yay"
    pushd "$HOME/wip/yay"
        makepkg --syncdeps --install
    popd
}

install_package_list() {
    packages=(
        acpi
        alsa-utils
        apfs-fuse-git
        aur/spotify
        aur/yegonesh
        aur/zoom
        autoconf
        automake
        clipmenu
        compton
        coreutils
        dmenu
        docker
        dunst
        efibootmgr
        exfat-utils
        feh
        firefox
        gawk
        hfsprogs
        hub
        lightdm
        lightdm-webkit2-greeter
        make
        nmap
        playerctl
        pv
        rclone
        rsync
        surf
        tmux
        transmission-cli
        tree
        upower
        vagrant
        vim
        virtualbox
        vlc
        which
        xmonad-contrib
        xsel
        zsh
    )
    yay --sync "${packages[@]}"
}

init_arch() {
    echo "Beginning init for Arch Linux..."
    install_yay
    install_package_list
}

init_arch
