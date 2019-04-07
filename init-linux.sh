#!/bin/sh


############################################
# Initialize specific distributions
############################################

declare DISTRO

if sed -n 's/^NAME=\(.*\)/\1/p' /etc/os-release | grep Ubuntu >/dev/null
then
    DISTRO=Ubuntu
elif sed -n 's/^NAME=\(.*\)/\1/p' /etc/os-release | grep 'Arch Linux' >/dev/null
then
    DISTRO='Arch Linux'
else
    DISTRO=unsupported
fi

case "$DISTRO" in
    Ubuntu) echo "Detected $DISTRO, running distribution initialization script:" >&2;;
    Arch\ Linux) echo "Detected $DISTRO, running distribution initialization script:" >&2;;
    unsupported)
        echo 'Could not detect a known linux distribution, skipping distribution init...' >&2
        exit 5
        ;;
esac

normalized_distro="${DISTRO// /-}"
distro_init_script=init-linux-distro-"$normalized_distro".sh

[ -f "$distro_init_script" ] && "$distro_init_script"

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
