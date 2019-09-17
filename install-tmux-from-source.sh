#!/usr/bin/sh

# I know that on ubuntu, if you install libevent-dev with apt,
#
#     git clone https://github.com/tmux/tmux.git && cd tmux && ./autogen && sudo make install
#
# will build and install tmux to /usr/local/bin
#
# This script works on Arch.

cleanup () {
    if [ -z "$CLEAN_TMUX_BUILD_DIR" ]
    then
        printf "\n>>> Cleaning up by removing the temporary dir %s ...\n" "${TEMP_COMPILE}" >&2
        rm -rf "${TEMP_COMPILE}"
    fi
}

trap cleanup EXIT

TMUX_VER="${TMUX_VER:-master}"
LIBEVENT_VER="${LIBEVENT_VER:-2.1.8-stable}"
TEMP_COMPILE="${TMPDIR:-/tmp}"/tmux-temp-compile
COMMON_INSTALL_PREFIX=/usr/local

set -e
[ "${debug:-false}" = 'true' ] && set -x

printf "\n>>> Creating and using temporary dir %s for downloading and compiling libevent and tmux ...\n" \
    "${TEMP_COMPILE}" >&2

rm -rf "${TEMP_COMPILE}"
mkdir "${TEMP_COMPILE}" || true
cd "${TEMP_COMPILE}"

printf "\n>>> Downloading the releases ...\n" >&2

curl -OL https://github.com/libevent/libevent/releases/download/release-"${LIBEVENT_VER}"/libevent-"${LIBEVENT_VER}".tar.gz

printf "\n>>> Extracting libevent %s ...\n" "${LIBEVENT_VER}" >&2
tar xzf libevent-"${LIBEVENT_VER}".tar.gz

printf "\n>>> Compiling libevent ...\n" >&2
cd libevent-"${LIBEVENT_VER}"
    ./configure --prefix="${COMMON_INSTALL_PREFIX}"
    make
    sudo make install
cd ..

if [ "$TMUX_VER" = 'master' ]
then
    git clone https://github.com/tmux/tmux.git
    TMUX_BUILD_DIR=tmux
    cd "$TMUX_BUILD_DIR"
        ./autogen.sh
    cd ..
else
    if ! curl -L https://api.github.com/repos/tmux/tmux/releases | jq -r '.[] | .tag_name' | grep -Fx "$TMUX_VER"
    then
        printf '!!!!!!!Invalid tmux version %s!!!!!!!' "$TMUX_VER" >&2
        exit 2
    fi
    curl -OL https://github.com/tmux/tmux/releases/download/"${TMUX_VER}"/tmux-"${TMUX_VER}".tar.gz
    printf "\n>>> Extracting tmux %s...\n" "${TMUX_VER}" >&2
    tar xzf tmux-"${TMUX_VER}".tar.gz
    TMUX_BUILD_DIR=tmux-"$TMUX_VER"
fi

printf "\n>>> Compiling tmux ...\n" >&2
cd "$TMUX_BUILD_DIR"
    LDFLAGS="-L${COMMON_INSTALL_PREFIX}/lib" \
        CPPFLAGS="-I${COMMON_INSTALL_PREFIX}/include" \
        LIBS="-lresolv" \
        ./configure --prefix="${COMMON_INSTALL_PREFIX}"
    make
    printf "\n>>> Installing tmux to %s/bin ...\n" "${COMMON_INSTALL_PREFIX}" >&2
    sudo make install

cd ..
