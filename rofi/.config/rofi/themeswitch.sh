#!/bin/sh
### Created by ilsenatorov https://github.com/ilsenatorov/dotfiles/blob/big/rofi/themeswitch.sh
### Change WALLPAPERDIR to the directory where you store wallpapers

WALLPAPERDIR=~/Pictures/wallpapers/

if [ -z $@ ]
then
function get_themes()
{
    ls $WALLPAPERDIR
}
echo current; get_themes
else
    THEMES=$@
    if [ x"current" = x"${THEMES}" ]
    then
        exit 0
        #wal -i `cat ~/.cache/wal/wal` > /dev/null
    elif [ -n "${THEMES}" ]
    then
        wal -o ~/.dotfiles/bin/.local/scripts/colorchange.sh -i $WALLPAPERDIR${THEMES} > /dev/null
    fi
fi
