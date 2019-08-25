#!/usr/bin/env zsh

PYTHON_VERSION=3.7.4

echo 'Initializing vim config...' >&2
git clone git@github.com:schlueter/dot-vim "$HOME/.vim" >&2
vim -c 'PlugInstall|qa'

echo 'Setting up environment for YouCompleteMe...' >&2
PYTHON_CONFIGURE_OPTS=--enable-shared \
    pyenv install "$PYTHON_VERSION"

pyenv shell "$PYTHON_VERSION"
pip install virtualenv

pushd "$HOME/.vim"
    virtualenv venv
    source venv/bin/activate
    pushd plugged/YouCompleteMe
        ./install.py
    popd
popd
