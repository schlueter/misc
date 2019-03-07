#!/bin/sh

trap cleanup EXIT

function cleanup() {
    return_code="$?"
    if [ "$return_code" -eq 0 ]
    then
        echo 'Rbenv successfully setup'
    else
        echo 'Failed to setup rbenv'
        exit 5
    fi
}

set -e

[ ! -d ~/.config/rbenv ] && \
    git clone https://github.com/rbenv/rbenv.git ~/.config/rbenv

pushd ~/.config/rbenv
    src/configure
    make -C src
popd

eval "$(rbenv init -)"

RBENV_PLUGINS="$(rbenv root)"/plugins
RUBY_BUILD_PATH="$RBENV_PLUGINS"/ruby-build

mkdir -p "$RBENV_PLUGINS"
[ ! -d "$RUBY_BUILD_PATH" ] && \
    git clone https://github.com/rbenv/ruby-build.git "$RUBY_BUILD_PATH"

RBENV_INSTALLER_PATH=/tmp/rbenv-installer

[ ! -d "$RBENV_INSTALLER_PATH" ] && \
    git clone https://github.com/rbenv/rbenv-installer "$RBENV_INSTALLER_PATH"
/tmp/rbenv-installer/bin/rbenv-doctor
