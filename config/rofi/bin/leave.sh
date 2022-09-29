#!/bin/bash

LOCK=' Lock'
POWER_OFF='⏻ Shutdown'
LOGOUT=' Logout'
REBOOT='勒 Reboot'
SUSPEND='鈴 Suspend'

OPTION=$(printf "$LOCK\n$LOGOUT\n$SUSPEND\n$REBOOT\n$POWER_OFF" | rofi -dmenu)


if [[ $OPTION == $LOCK ]];then
  sh ~/.config/gtklock/bin/lock.sh
elif [[ $OPTION == $LOGOUT ]];then
    pkill -KILL -u "$USER"
elif [[ $OPTION == $SUSPEND ]];then
    systemctl suspend
elif [[ $OPTION == $REBOOT ]];then
    systemctl reboot
elif [[ $OPTION == $POWER_OFF ]];then
    systemctl poweroff
fi
