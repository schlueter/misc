#!/bin/sh

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
