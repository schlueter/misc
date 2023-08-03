#!/bin/sh
cur_dir="$(dirname $PWD)"

# For GitHub use, this must be registered there
git config --global user.email b@schlueter.blue

# for continuity of history it helps to always use an identical name here
git config --global user.name Schlueter

# I guess this is a default, I don't recall setting it
git config --global color.ui auto

# this automatically pushes branches to a new remote branch of the same name
git config --global push.default current

# editors
git config --global diff.tool vimdiff
git config --global core.editor vim

# setting the commentchar to something other than the default #
# allows for markdown in pull requests created using hub
# TODO make vim syntax highlighting respect this
git config --global core.commentchar %

# To avoid those ugly merge commits on pull
git config --global pull.rebase true

# reuse recorded resolution
git config --global rerere.enabled true

# Set default branch name for init
git config --global init.defaultBranch main

# This is a default
# git config --global core.excludesFile ~/.config/git/ignore
[ ! -d ~/.config/git ] && mkdir ~/.config/git
if [ ! -f ~/.config/git/ignore ] || ! diff "${cur_dir}/files/home/USER/.config/git/ignore" ~/.config/git/ignore
then
    echo "Installing global gitignore to $XDG_CONFIG_HOME/git/ignore" >&2
    ln -s "${cur_dir}/files/home/USER/.config/git/ignore" "$XDG_CONFIG_HOME/git/ignore"
fi

if command -v gpg >/dev/null
then
    secret_key="$(gpg -K | sed -n '/sec/{n;p}')"
    if [ -n "$secret_key" ]
    then
        git config --global gpg.program gpg
        git config --global user.signingkey "${secret_key// }"
    fi
fi
