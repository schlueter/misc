#!/bin/sh

cp .tmux.conf ~
mkdir -p ~/.config/ ~/workspace
./install-tmux-from-source.sh
source git-config-global.sh
# TODO ./install-hub-from-source.sh
# TODO ./install-git-from-source.sh
# TODO ./install-vim-from-source.sh
# TODO ./install-zsh-from-source.sh
git clone git@github.com:schlueter/bin ~/bin
git clone git@github.com:schlueter/zsh-config ~/.config/zsh
git clone git@github.com:schlueter/dot-vim ~/.vim
git clone git@github.com:powerline/fonts ~/workspace/fonts
~/workspace/fonts/install.sh
git clone git://github.com/altercation/solarized.git ~/workspace/solarized

./$(uname -s)-init
