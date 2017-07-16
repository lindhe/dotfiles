#!/bin/bash
xrandr --output eDP-1 --auto --primary \
    --output HDMI-1 --off --output DP-1 --off --output DP-2 --off \
    && echo 'Monitors off';
~/.xprofile
