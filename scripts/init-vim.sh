#!/usr/bin/env zsh

cleanup () {
    rm -rf /tmp/vim-plug
}

trap cleanup EXIT

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo 'Initializing vim config...' >&2
git clone git@github.com:schlueter/dot-vim "$HOME/.vim" >&2

echo 'Installing vim-plug...' >&2
git clone git@github.com:junegunn/vim-plug /tmp/vim-plug/ >&2
cp /tmp/vim-plug/plug.vim "$HOME/.vim/autoload"
ln -s "$HOME/.vim" "$XDG_CONFIG_HOME/nvim"

vim -c 'PlugInstall|qa'
