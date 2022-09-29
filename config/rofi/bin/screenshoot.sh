#!/bin/bash


#file name auto generated with date
FILENAME="`date +%m-%d-%Y%H%M%S`.png"
#this path is not used for clipping ! :)
FILE_PATH="/home/$USER/Pictures/screenshots"

FULL_PATH="$FILE_PATH/$FILENAME"

# WOFI OPTIONS 
CROP_TO_CLIPBOARD=" Crop and clip"
FULL_CAPTURE=" Capture and save"
FULL_CAPTURE_CLIPPED=" Capture and clip"

OPTION=$(printf "$CROP_TO_CLIPBOARD\n$FULL_CAPTURE_CLIPPED\n$FULL_CAPTURE\n" | rofi --width 230 --height 150 -dmenu)

if [[ $OPTION == $CROP_TO_CLIPBOARD ]]; then
    wayshot -s "$(slurp -f '%x %y %w %h')" --stdout | xclip -se clip -t image/png
    sleep 1.3
    dunstify "copied to clipboard" 

elif [[ $OPTION == $FULL_CAPTURE ]]; then
     sleep 1 
     wayshot -f "$FULL_PATH"
     sleep 1.3
     dunstify "$FILENAME saved" -I $FULL_PATH

elif [[ $OPTION == $FULL_CAPTURE_CLIPPED ]]; then
  sleep 1 
  wayshot --stdout | xclip -se clip -t image/png
  sleep 1.3
  dunstify "full capture copied"
fi
  
  

