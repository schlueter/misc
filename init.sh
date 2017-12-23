#!/bin/sh

# Install tmux config
cp tmux.conf ~/.tmux.conf

# Create some directories
mkdir ~/.config/ ~/workspace

# Configure git
./git-config-global.sh

# Install tools from source
./install-tmux-from-source.sh
# TODO ./install-hub-from-source.sh
# TODO ./install-git-from-source.sh
# TODO ./install-vim-from-source.sh
# TODO ./install-zsh-from-source.sh

# Clone configuration repositories
git clone --recursive git@github.com:schlueter/zsh-config ~/.config/zsh
# TODO ruby-build install
git clone git@github.com:schlueter/bin ~/bin
git clone git@github.com:schlueter/dot-vim ~/.vim
git clone git@github.com:powerline/fonts ~/workspace/fonts
git clone git@github.com:altercation/solarized.git ~/workspace/solarized

# Install fonts
~/workspace/fonts/install.sh

case "$(uname -s)" in
    (Linux)
        sudo apt update
        sudo apt install    \
            alsa-base       \
            dbus-x11        \
            feh             \
            gnome-keyring   \
            libnotify-bin   \
            libreadline-dev \
            libssl-dev      \
            parted          \
            pulseaudio      \
            python-dbus-dev \
            python-gtk2-dev \
            python-pip      \
            upower          \
            vlc-nox         \
            xscreensaver    \
        ;;
    (Darwin)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        for cask in \
            iterm2 \
            docker \
            minikube \
            transmission \
            vagrant \
            virtualbox
        do
            brew cask install $cask
        done

        for app in \
            git \
            gnupg \
            openssl \
            pinentry \
            pkg-config \
            transmission \
            tree \
            vim \
            zsh
        do
            brew install $app
        done

        open ~/workspace/solarized/iterm2-colors-solarized/*
        ;;

esac

# rbenv install 2.4.3
# pyenv install 2.7.14
# pyenv install 3.6.3
