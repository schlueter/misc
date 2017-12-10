#!/bin/sh

# Install tmux config
cp tmux.conf ~/.tmux.conf

# Create some directories
mkdir ~/.config/ ~/workspace

# Configure git
source git-config-global.sh

# Install tools from source
./install-tmux-from-source.sh
# TODO ./install-hub-from-source.sh
# TODO ./install-git-from-source.sh
# TODO ./install-vim-from-source.sh
# TODO ./install-zsh-from-source.sh

# Clone configuration repositories
git clone git@github.com:schlueter/zsh-config ~/.config/zsh
git clone git@github.com:schlueter/bin ~/bin
git clone git@github.com:schlueter/dot-vim ~/.vim
git clone git@github.com:powerline/fonts ~/workspace/fonts
git clone git@github.com:altercation/solarized.git ~/workspace/solarized

# Install fonts
~/workspace/fonts/install.sh

# Run system init
./$(uname -s)-init
