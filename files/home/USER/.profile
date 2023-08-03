#!/bin/sh

if [ ! -d "$TMPDIR" ]
then
    TMPDIR="/tmp/$LOGNAME"
    [ ! -d "TMPDIR" ] && mkdir -p "$TMPDIR"
    chmod 700 "$TMPDIR"
fi

if command -v surf >/dev/null
then
    BROWSER=surf
elif [ "$(uname -s)" = Darwin ]
then
    BROWSER=open
else
    BROWSER=firefox
fi

XDG_CONFIG_HOME="$HOME/.config"
CLASSPATH="$HOME/workspace/libs"
EDITOR='vim'
GOPATH="$HOME/go"
LANG='en_US.UTF-8'
LESS='-g -i -M -R -w -z-4 -F -X'
LESSOPEN='|lesspreprocess %s'
N_PREFIX="$HOME/.local"
PAGER='less'
PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
PYTHONSTARTUP=~/.pythonrc
RBENV_ROOT="$XDG_CONFIG_HOME/rbenv"
TMPPREFIX="$TMPDIR/zsh"
VAGRANT_HOME="$XDG_CONFIG_HOME/.vagrant.d"
VISUAL="$EDITOR"
Z_DIR="$XDG_CONFIG_HOME/z"
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
ANSIBLE_STDOUT_CALLBACK=yaml
ANSIBLE_CALLBACK_WHITELIST=profile_tasks
ANSIBLE_FORCE_COLOR=true
ANSIBLE_LOAD_CALLBACK_PLUGINS=1

PATH="$HOME/bin:$HOME/.local/bin:$PYENV_ROOT/bin:$HOME/.radicle/bin:$HOME/go/bin:$HOME/.tfenv/bin:$HOME/.cargo/bin:$RBENV_ROOT/bin:/usr/local/sbin:$PATH"

export \
    BROWSER \
    CLASSPATH \
    EDITOR \
    GOPATH \
    LANG \
    LESS \
    LESSOPEN \
    N_PREFIX \
    PAGER \
    PATH \
    PYENV_ROOT \
    PYTHONSTARTUP \
    RBENV_ROOT \
    TMPDIR \
    TMPPREFIX \
    VAGRANT_HOME \
    VISUAL \
    XDG_CONFIG_HOME \
    ZDOTDIR \
    Z_DIR \
    ANSIBLE_STDOUT_CALLBACK \
    ANSIBLE_CALLBACK_WHITELIST \
    ANSIBLE_FORCE_COLOR \
    ANSIBLE_LOAD_CALLBACK_PLUGINS \
