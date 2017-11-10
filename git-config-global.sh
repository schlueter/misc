#!/bin/sh
# remember that this needs to be an email address registered with your account on GitHub
git config --global user.email b@schlueter.blue

# for continuity of history it helps to always use an identical name here
git config --global user.name Schlueter

# I guess this is a default, I don't recall setting it
git config --global color.ui auto

# this keeps git quiet because it really wants this to be set, despite the fact that it says something about a default
git config --global push.default simple

# setting the commentchar to something other than the default #
# allows for markdown in pull requests created using hub
# TODO make vim syntax highlighting respect this
git config --global core.commentchar %

# This is one of the default values according to the git-config man page
#
# git config --global core.excludesFile ~/.config/git/ignore
cat >~/.config/git/ignore <<EOF
*.pyc
__pycache__/
.vagrant/
EOF
