#!/usr/bin/sh

# Fit the VM Virtual Machine display to fullscreen

#resolution="1920x800"
#resolution="800x600"
resolution="1024x768"

xrandr -s $resolution &
echo "resolution set to ${resolution}" &

#setxkbmap -layout us
#setxkbmap -option 'grp:alt_shift_toggle'

xmodmap ~/.Xmodmap &

## Start process.
# `picom` to reduce screen tearing. with `-b` daemonize flag.
picom --backend xrender --config ~/.config/picom/picom.conf -b

# `dunst` notification daemon.
dunst -config ~/.config/dunst/dunstrc &

# Open predefined windows.
# Permanent windows (usually should stay opened).
# @source echasnovski/dotfiles.
i3-msg 'workspace "10:monitor"; layout splith'
sleep 1

i3-sensible-terminal -e btm &
sleep 1
