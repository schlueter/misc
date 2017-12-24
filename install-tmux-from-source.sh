#!/bin/sh

TMUX_VER=2.6
LIBEVENT_VER=2.1.8-stable
TEMP_COMPILE=~/tmux-temp-compile
COMMON_INSTALL_PREFIX=/opt
SYMLINK=/usr/local/bin/tmux

set -e
((DEBUG)) && set -x

printf "\n>>> Creating and using temporary dir %s for downloading and compiling libevent and tmux ...\n" \
    ${TEMP_COMPILE}

mkdir ${TEMP_COMPILE}
cd ${TEMP_COMPILE}

printf "\n>>> Downloading the releases ...\n"

curl -OL https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz
curl -OL https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VER}/libevent-${LIBEVENT_VER}.tar.gz

printf "\n>>> Extracting tmux %s and libevent %s ...\n" ${TMUX_VER} ${LIBEVENT_VER}

tar xzf tmux-${TMUX_VER}.tar.gz
tar xzf libevent-${LIBEVENT_VER}.tar.gz

printf "\n>>> Compiling libevent ...\n"

cd libevent-${LIBEVENT_VER}
./configure --prefix=${COMMON_INSTALL_PREFIX}
sudo make
sudo make install

printf "\n>>> Compiling tmux ...\n"

(
    cd ../tmux-${TMUX_VER}
    LDFLAGS="-L${COMMON_INSTALL_PREFIX}/lib" CPPFLAGS="-I${COMMON_INSTALL_PREFIX}/include" LIBS="-lresolv" ./configure --prefix=${COMMON_INSTALL_PREFIX}
    make

    printf "\n>>> Installing tmux in %s/bin ...\n" ${COMMON_INSTALL_PREFIX}

    sudo make install

    printf "\n>>> Symlink to it from %s ...\n" ${SYMLINK}

    sudo ln -s ${COMMON_INSTALL_PREFIX}/bin/tmux ${SYMLINK}

    printf "\n>>> Cleaning up by removing the temporary dir %s ...\n" ${TEMP_COMPILE}
) || exit

sudo rm -rf ${TEMP_COMPILE}
