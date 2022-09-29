#!/bin/bash
# @MauroMontan

#This script copy the output of hyprpicker to clipboard.

COLOR=$(hyprpicker )

echo $COLOR | xclip -se clip 

NOTIFICATION="$COLOR"
notify-send "  $NOTIFICATION"
