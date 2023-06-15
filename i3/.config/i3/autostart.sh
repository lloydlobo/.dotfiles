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
#i3-msg 'workspace "10:monitor"; layout splith'
#sleep 1
#i3-sensible-terminal -e btm
#sleep 1
#i3-msg 'workspace "1";'

"$HOME"/.config/polybar/launch.sh

# xmodmap ~/.Xmodmap  # Disabled custom key remaps, now using `-option`
#setxkbmap # activate dvorak from localectl.
setxkbmap -layout us -variant colemak_dh
setxkbmap -option ctrl:nocaps # Remap Capslock as Control.

dunst -config ~/.config/dunst/dunstrc &

# -a (Sets transparency)
#wal -a 99 --saturate 0.20 -i ~/Pictures/wallpapers/alena-aenami-15step-AEE71.png &
#wal -a 99 --saturate 0.35 -i ~/Pictures/wallpapers/wallhaven-dp19wl.jpg &
wal -a 99 --saturate 0.35 -i ~/Pictures/wallpapers/wallhaven-jx16pm.jpg # sepia zebra crossing.
#wal -a 99 --saturate 0.15 -i ~/Pictures/wallpapers/wallhaven-lazo2l.jpg # lady feeding dog.
#wal -R
