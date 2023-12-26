#!/usr/bin/env bash

#-------------------------------
# Wallpaper
#-------------------------------
swww init &
swww img img /home/zain/config/wallpaper/VoltswagenGirl.png &


waybar &


dunst

./config/scripts/swayidle.sh

wl-paste --watch cliphist store
