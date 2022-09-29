#!/bin/bash


# this saves the current brightness
light -O 

#this command set a new brightness value
light -S 15

gtklock -s ~/.config/gtklock/style.css


# this command  restore the previous brightness value
light -I
