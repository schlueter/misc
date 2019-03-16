#!/usr/bin/env zsh

echo 'Initializing vim config...' >&2
git clone git@github.com:schlueter/dot-vim "$HOME/.vim"
vim -c 'PlugInstall|qa'

echo 'Setting up environment for YouCompleteMe...' >&2
PYTHON_CONFIGURE_OPTS=--enable-shared \
    pyenv install 3.6.5

pyenv shell 3.6.5
pip install virtualenv

pushd "$HOME/.vim"
    virtualenv venv
    source venv/bin/activate
    pushd plugged/YouCompleteMe
        ./install.py
    popd
popd
