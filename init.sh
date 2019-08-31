#nstall instant-markdown=t!/bin/sh

# Create some directories
mkdir ~/.config/ ~/wip

case "$(uname -s)" in
    (Linux)
        ./init-linux.sh
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

# Install tmux config
ln -s "$(git rev-parse --show-toplevel)"/tmux.conf "$HOME"/.tmux.conf

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



sudo chsh "$(whoami)" -s "$(command -v zsh)"
