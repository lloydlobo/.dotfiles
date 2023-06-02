#!/usr/bin/env bash

# Start process.

# Fit the VM Virtual Machine display to fullscreen
resolution="1024x768"
xrandr -s $resolution

# Compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config /home/lloyd/.config/picom/picom.conf --vsync -b # `picom` to reduce screen tearing. with `-b` daemonize flag. for kernel blur to work.
#https://bbs.archlinux.org/viewtopic.php?id=268883
#GLX backend is broken because that config doesn't expand the module path properly. Remove that xorg.conf and reboot. If it still doesn't work, enable early KMS: https://wiki.archlinux.org/title/NVIDIA … de_setting

# Open predefined windows. @source echasnovski/dotfiles.
# Permanent windows (usually should stay opened).
# TODO: close i3-sensible-terminal with btm, and open it.
i3-msg 'workspace "10:monitor"; layout splith'
sleep 1
i3-sensible-terminal -e btm
sleep 1
i3-msg 'workspace "1";'

$HOME/.config/polybar/launch.sh

xmodmap ~/.Xmodmap

#dunst -config ~/.config/dunst/dunstrc &

#wal -a 99 --saturate 0.25 -i ~/Pictures/wallpapers/wallhaven-dp19wl.jpg & # -i (Set transparency)
# -i (Set transparency)
#wal -a 99 --saturate 0.20 -i ~/Pictures/wallpapers/wallhaven-dp19wl.jpg &
wal -R
