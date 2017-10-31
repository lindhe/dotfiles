#!/bin/bash

# If the dock ethernet interface is available, we are probably docked.
ip link show eth0 2> /dev/null > /dev/null;

if [ $? -eq 0 ]; then
    ~/scripts/dock/monman.py -a \
        && echo 'Docking successful!' || echo 'Docking failed!'
else
    ~/scripts/dock/monman.py -d \
        && echo 'Undocked!' || echo 'Failed to undock!'
fi

# Resource .xprofile
~/.xprofile

