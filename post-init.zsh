#!/usr/bin/env zsh
pyenv install 2.7.15
PYTHON_CONFIGURE_OPTS=--enable-shared pyenv install 3.6.5
pip install virtualenv
git clone git@github.com:schlueter/dot-vim ~/.vim
cd ~/.vim
virtualenv venv
source venv/bin/activate
cd plugged/YouCompleteMe
./install.py

