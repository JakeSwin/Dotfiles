#!/bin/sh
feh --bg-scale ~/.config/qtile/Background4.jpg &
picom -b --config ~/.config/picom/picom.conf --experimental-backends --backend glx &
setxkbmap -layout gb &
