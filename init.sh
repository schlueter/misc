#!/bin/sh

# Install tmux config
ln -s "$(git rev-parse --show-toplevel)"/tmux.conf "$HOME"/.tmux.conf

# Create some directories
mkdir ~/.config/ ~/wip

# Configure git
./git-config-global.sh

# Install tools from source
./install-tmux-from-source.sh
# TODO ./install-hub-from-source.sh
# TODO ./install-jq-from-source.sh
# TODO ./install-git-from-source.sh
# TODO ./install-vim-from-source.sh
# TODO ./install-zsh-from-source.sh

# Clone configuration repositories
git clone --recursive git@github.com:schlueter/zsh-config ~/.config/zsh
touch ~/.z

git clone git@github.com:schlueter/bin ~/bin

git clone git@github.com:altercation/solarized.git ~/wip/solarized
# TODO configure iterm to use solarized
# TODO install and configure vim config

# Install fonts
git clone git@github.com:powerline/fonts ~/wip/fonts
~/wip/fonts/install.sh
# TODO configure iterm to use some font

case "$(uname -s)" in
    (Linux)
        sudo apt update
        sudo apt install    \
            alsa-base       \
            dbus-x11        \
            feh             \
            gnome-keyring   \
            libbz2-dev      \
            libdbus-1-dev   \
            libdbus-glib-1-dev \
            libnotify-bin   \
            libreadline-dev \
            libsqlite3-dev  \
            libssl-dev      \
            parted          \
            pulseaudio      \
            python-dbus-dev \
            python-gtk2-dev \
            python-pip      \
            upower          \
            vlc-nox         \
            xscreensaver

        if xinput | grep 'Apple Inc. Apple Internal Keyboard / Trackpad'
        then
            sed '/key <LSGT>/a \ \ \ \ // MANUAL FIX BS\n\ \ \ \ key <LSGT> { [ grave, asciitilde, grave, asciitilde ] };' \
            /usr/share/X11/xkb/symbols/pc -i
        fi
        ;;
    (Darwin)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

        defaults write -g AppleShowAllFiles -bool true
        defaults write -g NSNavPanelExpandedStateForSaveMode -bool TRUE
        defaults write com.apple.finder CreateDesktop true
        # TODO configure dropbox first
        # defaults write com.apple.screencapture location ~/Dropbox/Screenshots
        killall Finder

        brew cask install \
            google-chrome \
            iterm2 \
            docker \
            minikube \
            transmission \
            vagrant \
            virtualbox

        brew install \
            cmake \
            expect \
            git \
            gnupg \
            openssl \
            pinentry \
            transmission \
            tree \
            vim \
            zsh

        open ~/wip/solarized/iterm2-colors-solarized/*
        ;;

esac

sudo chsh "$(whoami)" -s "$(which zsh)"
