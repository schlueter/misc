#!/bin/sh


############################################
# Do stuff for specific distributions
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

init-linux-distro-${DISTRO// /-}.sh

init_system="$(ps -p 1 -o comm=)"

setup-for-"${init_system}".sh
