#!/bin/sh
feh --bg-scale ~/.config/qtile/background.jpg &
picom -b --config ~/.config/picom/picom.conf --experimental-backends --backend glx &
