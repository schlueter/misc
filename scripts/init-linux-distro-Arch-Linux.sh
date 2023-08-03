#!/bin/sh

set -e

install_prerequisites() {
    sudo pacman --noconfirm --sync --refresh --sysupgrade
    sudo pacman --noconfirm --sync \
         binutils \
         fakeroot \
         file \
         gcc \
         git \
         make \
         procps \
         sudo
}

install_yay() {
    git clone https://aur.archlinux.org/yay.git "$HOME/wip/yay"
    cd "$HOME/wip/yay" || exit 3
        makepkg --noconfirm --syncdeps --install
    cd .. || exit 3
}

install_package_list() {
    yay --noconfirm --sync \
        acpi \
        alsa-utils \
        apfs-fuse-git \
        aur/spotify \
        aur/yegonesh \
        aur/zoom \
        autoconf \
        automake \
        base-devel \
        clipmenu \
        compton \
        coreutils \
        dmenu \
        docker \
        dunst \
        efibootmgr \
        exfat-utils \
        feh \
        firefox \
        gawk \
        hfsprogs \
        hub \
        lightdm \
        lightdm-webkit2-greeter \
        make \
        nmap \
        playerctl \
        pv \
        rclone \
        rsync \
        surf \
        tmux \
        transmission-cli \
        tree \
        upower \
        vagrant \
        vim \
        virtualbox \
        vlc \
        xmonad \
        xmonad-contrib \
        xsel \
        zsh
}

init_arch() {
    echo "Beginning init for Arch Linux..."
    install_prerequisites
    install_yay
    install_package_list
}

init_arch
