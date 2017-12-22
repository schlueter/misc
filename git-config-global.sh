#!/bin/sh
# remember that this needs to be an email address registered with your account on GitHub
git config --global user.email b@schlueter.blue

# for continuity of history it helps to always use an identical name here
git config --global user.name Schlueter

# I guess this is a default, I don't recall setting it
git config --global color.ui auto

# this automatically pushes branches to a new remote branch of the same name
git config --global push.default current

# setting the commentchar to something other than the default #
# allows for markdown in pull requests created using hub
# TODO make vim syntax highlighting respect this
git config --global core.commentchar %

# This is one of the default values according to the git-config man page
#
# git config --global core.excludesFile ~/.config/git/ignore
mkdir ~/.config/git
cp gitignore-global ~/.config/git/ignore

# To avoid those ugly merge commits on pull
git config --global pull.rebase true
