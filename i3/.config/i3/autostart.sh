#!/usr/bin/sh

# Start process.

# Compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --backend xrender --config ~/.config/picom/picom.conf --vsync -b & # `picom` to reduce screen tearing. with `-b` daemonize flag. for kernel blur to work.

# Fit the VM Virtual Machine display to fullscreen

resolution="1024x768"
xrandr -s $resolution &

xmodmap ~/.Xmodmap &

wal -a 90 -i ~/Pictures/wallpapers/wallhaven-dp19wl.jpg & # -i (Set transparency)

# `dunst` notification daemon.
dunst -config ~/.config/dunst/dunstrc &

# Open predefined windows.
# Permanent windows (usually should stay opened).
# @source echasnovski/dotfiles.
i3-msg 'workspace "10:monitor"; layout splith' #sleep 1
i3-sensible-terminal -e btm #sleep 1

