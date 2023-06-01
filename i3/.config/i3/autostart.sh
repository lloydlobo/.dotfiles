#!/usr/bin/sh

# Start process.

# Compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
#https://bbs.archlinux.org/viewtopic.php?id=268883
#GLX backend is broken because that config doesn't expand the module path properly. Remove that xorg.conf and reboot. If it still doesn't work, enable early KMS: https://wiki.archlinux.org/title/NVIDIA … de_setting
picom --config /home/lloyd/.config/picom/picom.conf --vsync -b & # `picom` to reduce screen tearing. with `-b` daemonize flag. for kernel blur to work.

# Fit the VM Virtual Machine display to fullscreen

resolution="1024x768"
xrandr -s $resolution &

xmodmap ~/.Xmodmap &

wal -a 90 -i ~/Pictures/wallpapers/wallhaven-dp19wl.jpg & # -i (Set transparency)
#wal -R &

# `dunst` notification daemon.
dunst -config ~/.config/dunst/dunstrc &

# Open predefined windows.
# Permanent windows (usually should stay opened).
# @source echasnovski/dotfiles.

i3-msg 'workspace "10:monitor"; layout splith' #sleep 1
i3-sensible-terminal -e btm #sleep 1

