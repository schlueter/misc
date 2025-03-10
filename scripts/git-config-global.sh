#!/bin/sh
misc_root="$(cd $(dirname $0)/.. && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# For GitHub use, this must be registered there
git config --global user.email &>/dev/null || git config --global user.email brandon@schlueter.dev

# for continuity of history it helps to always use an identical name here
git config --global user.name &>/dev/null || git config --global user.name Schlueter

# I guess this is a default, I don't recall setting it
git config --global color.ui auto

# this automatically pushes branches to a new remote branch of the same name
git config --global push.default current

# editors
git config --global diff.tool nvimdiff
git config --global difftool.prompt false
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

# When rebasing, skip commits that are already upstream
# hint: use --reapply-cherry-picks to include skipped commits
# hint: Disable this message with "git config advice.skippedCherryPicks false"
git config --global advice.skippedCherryPicks false

# This is the default expected location
if [ ! -f "$XDG_CONFIG_HOME/git/ignore" ] || ! diff "$misc_root/files/XDG_CONFIG_HOME/git/ignore" "$XDG_CONFIG_HOME/git/ignore"
then
    echo "Installing global gitignore to $XDG_CONFIG_HOME/git/ignore" >&2
    [ -d "$XDG_CONFIG_HOME/git" ] || mkdir "$XDG_CONFIG_HOME/git"
    ln -s "$misc_root/files/XDG_CONFIG_HOME/git/ignore" "$XDG_CONFIG_HOME/git/ignore"
fi

if command -v gpg >/dev/null
then
    secret_key="$(gpg --list-secret-keys --with-colons \
                 | awk -F: '/^sec/{print $5;exit}')"
    if [ -n "$secret_key" ]
    then
        git config --global gpg.program gpg
        git config --global user.signingkey "${secret_key// }"
    fi
else
    echo 'Go setup gpg!' >&2
fi
