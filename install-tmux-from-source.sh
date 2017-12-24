#!/usr/bin/env bash

TMUX_VER="${TMUX_VER:-master}"
LIBEVENT_VER="${LIBEVENT_VER:-2.1.8-stable}"
TEMP_COMPILE=~/tmux-temp-compile
COMMON_INSTALL_PREFIX=/opt

set -e
((DEBUG)) && set -x

printf "\n>>> Creating and using temporary dir %s for downloading and compiling libevent and tmux ...\n" \
    ${TEMP_COMPILE}

mkdir ${TEMP_COMPILE}
cd ${TEMP_COMPILE}

printf "\n>>> Downloading the releases ...\n"

curl -OL https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VER}/libevent-${LIBEVENT_VER}.tar.gz

printf "\n>>> Extracting libevent %s ...\n" ${LIBEVENT_VER}
tar xzf libevent-${LIBEVENT_VER}.tar.gz

(
    printf "\n>>> Compiling libevent ...\n"
    cd libevent-${LIBEVENT_VER}
    ./configure --prefix=${COMMON_INSTALL_PREFIX}
    make
    sudo make install
)

if [ "$TMUX_VER" = "master" ]
then
    git clone https://github.com/tmux/tmux.git
    TMUX_BUILD_DIR=tmux
    (
        cd "$TMUX_BUILD_DIR"
        ./autogen.sh
    )
else
    if ! curl -L https://api.github.com/repos/tmux/tmux/releases | jq -r '.[] | .tag_name' | grep -Fx "$TMUX_VER"
    then
        printf '!!!!!!!Invalid tmux version %s!!!!!!!' "$TMUX_VER" >&2
        exit 2
    fi
    curl -OL https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz
    printf "\n>>> Extracting tmux %s...\n" ${TMUX_VER}
    tar xzf tmux-${TMUX_VER}.tar.gz
    TMUX_BUILD_DIR=tmux-$TMUX_VER
fi
(
    printf "\n>>> Compiling tmux ...\n"
    cd $TMUX_BUILD_DIR

    LDFLAGS="-L${COMMON_INSTALL_PREFIX}/lib" CPPFLAGS="-I${COMMON_INSTALL_PREFIX}/include" LIBS="-lresolv" ./configure --prefix=${COMMON_INSTALL_PREFIX}
    make
    sudo make install

    printf "\n>>> Installing tmux in %s/bin ...\n" ${COMMON_INSTALL_PREFIX}

    # link common install prefix tmux to default tmux install location
    sudo ln -s ${COMMON_INSTALL_PREFIX}/bin/tmux /usr/local/bin/tmux

    printf "\n>>> Cleaning up by removing the temporary dir %s ...\n" ${TEMP_COMPILE}
) || exit

rm -rf ${TEMP_COMPILE}
