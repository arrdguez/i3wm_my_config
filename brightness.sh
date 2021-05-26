#!/bin/bash

# Script to change the brightness via Software and Hardware.
# 
# Software. You should run: xrandr | grep " connected" | cut -f1 -d " " 
# to know who your display name. In this script is "eDP-1" for example and for one display.
# Hardware. You should install before "xdotool" as: sudo apt install xdotool
#
# to run this script just call: ./brightness.sh - or ./brightness.sh + for software and
#./brightness.sh -- or ./brightness.sh ++ for hardware.
#



currentBrightness=`xrandr --verbose | grep "Brightness" | awk '{print $2}'`


highestB=1.0
lowestB=0.2


action=$1



if [[ $(echo "$currentBrightness"| bc) != $(echo "$highestB"| bc)  ]]; then
  if [[ $action = "+" ]]; then
    xrandr --output eDP-1 --brightness $(echo "$currentBrightness + 0.1" | bc)
  fi
fi

if [[ $(echo "$currentBrightness"| bc | awk '{printf "%f", $0}') != $(echo "$lowestB"| bc | awk '{printf "%f", $0}') ]]; then
  if [[ $action = "-" ]]; then
    xrandr --output eDP-1 --brightness $(echo "$currentBrightness - 0.1" | bc)
  fi
fi

if [[ $action = "++" ]]; then
  xdotool key XF86MonBrightnessUp
elif [[ $action = "--" ]]; then
  xdotool key XF86MonBrightnessDown
fi

