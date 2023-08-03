#!/usr/bin/env zsh

echo 'Initializing vim config...' >&2
git clone git@github.com:schlueter/dot-vim "$HOME/.vim" >&2

echo 'Installing vim-plug...' >&2
git clone git@github.com:junegunn/vim-plug /tmp/vim-plug/ >&2
cp /tmp/vim-plug/plug.vim "$HOME/.vim/autoload"
vim -c 'PlugInstall|qa'
