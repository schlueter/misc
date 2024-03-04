#!/bin/sh
misc_root="$(cd $(dirname $0)/.. && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# For GitHub use, this must be registered there
if ! git config --global user.email &>/dev/null
then
    git config --global user.email b@schlueter.blue
fi

# for continuity of history it helps to always use an identical name here
if ! git config --global user.name &>/dev/null
then
    git config --global user.name Schlueter
fi

# I guess this is a default, I don't recall setting it
git config --global color.ui auto

# this automatically pushes branches to a new remote branch of the same name
git config --global push.default current

# editors
git config --global diff.tool 'nvim -d'
git config --global core.editor nvim

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
if [ ! -f "$XDG_CONFIG_HOME/git/ignore" ] || ! diff "$misc_root/files/XDG_CONFIG_HOME/git/ignore" "$XDG_CONFIG_HOME/git/ignore"
then
    echo "Installing global gitignore to $XDG_CONFIG_HOME/git/ignore" >&2
    ln -s "$misc_root/files/XDG_CONFIG_HOME/git/ignore" "$XDG_CONFIG_HOME/git/ignore"
fi

if ! git config --global user.signingkey &>/dev/null
then
    if command -v gpg >/dev/null
    then
        secret_key="$(gpg --list-secret-keys --with-colons \
                     | awk -F: '/^sec/{print $5;exit}')"
        if [ -n "$secret_key" ]
        then
            git config --global gpg.program gpg
            git config --global user.signingkey "${secret_key// }"
        fi
    fi
fi
