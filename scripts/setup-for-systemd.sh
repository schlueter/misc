#!/bin/sh

# Add some custom services
user_control="${XDG_CONFIG_HOME:-$HOME/.config}"/systemd/user.control
mkdir -p "$user_control"
for service in systemd-user-services/*
do
    cp "$service" "$user_control"/
done
systemctl --user daemon-reload

# Start and enable all our services
for service in systemd-user-services/* dunst pulseaudio clipmenud
do
    systemctl --user start "$service"
    systemctl --user status "$service"
    systemctl --user enable "$service"
done
