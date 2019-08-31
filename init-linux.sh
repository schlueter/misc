#!/bin/sh


############################################
# Initialize specific distributions
############################################

DISTRO="$(sed -n 's/^NAME="\?\([^"]*\)"\?/\1/p' /etc/os-release)"

case "$DISTRO" in
    (Ubuntu|Arch\ Linux) echo "Detected $DISTRO, running distribution initialization script:" >&2;;
    *)
        echo 'Could not detect a known linux distribution, skipping distribution init...' >&2
        exit 5
        ;;
esac

normalized_distro="$(echo "$DISTRO" | sed 's/ /-/g')"
distro_init_script=init-linux-distro-"$normalized_distro".sh

[ -f "$distro_init_script" ] && "./$distro_init_script"

############################################
# Setup for specific init systems
############################################

init_system="$(ps -p 1 -o comm=)"
init_system_script=setup-for-"$init_system".sh

[ -f "$init_system_script" ] && "$init_system_script"


############################################
# Setup for specific init systems
############################################

mkdir -p "$HOME"/.local/share/applications
ln -s "$(git rev-parse --show-toplevel)"/transmission-oneoff.desktop "$HOME"/.local/share/applications/transmission-oneoff.desktop
ln -s "$(git rev-parse --show-toplevel)"/xprofile "$HOME"/.xprofile
