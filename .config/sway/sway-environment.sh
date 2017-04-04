#!/bin/sh
# Make /usr/share/wayland-sessions/sway.desktop run this file.
export XKB_DEFAULT_LAYOUT=se-A5;
export XKB_REPEAT_DELAY=75;
export XKB_REPEAT_RATE=330;
export GDK_BACKEND=wayland;
export CLUTTER_BACKEND=wayland;
sway
