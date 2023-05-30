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

# -s (Skip setting the terminal colors) to avoid pywal tampering with tmux opacity.
#wal -s -i ~/Pictures/wallpapers/default.png &

# -i (Set transparency)
#wal -a 80 -i ~/Pictures/wallpapers/default.png &

# Restore the previously genrated color scheme and wallpaper.
#wal -s -R &
wal -i 99 -R &

## Start process.
# `picom` to reduce screen tearing. with `-b` daemonize flag.
#for kernel blur to work.
picom --backend xrender --config ~/.config/picom/picom.conf -b
#for dual_kawase blur to work.
#picom --experimental-backend --config ~/.config/picom/picom.conf -b

# `dunst` notification daemon.
dunst -config ~/.config/dunst/dunstrc &

# Open predefined windows.
# Permanent windows (usually should stay opened).
# @source echasnovski/dotfiles.
i3-msg 'workspace "10:monitor"; layout splith'
sleep 1

i3-sensible-terminal -e btm &
sleep 1
