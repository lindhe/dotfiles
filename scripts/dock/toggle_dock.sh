#!/bin/bash

RES=''

# If the dock ethernet interface is available, we are probably docked.
ip link show eth0 2> /dev/null > /dev/null;

if [ $? -eq 0 ]; then
    ~/scripts/dock/monman.py -a \
        && $RES='Docking successful!' || $RES='Docking failed!';
else
    ~/scripts/dock/monman.py -d \
        && $RES='Undocking sucessful!' || $RES='Undocking failed!';
fi

logger $RES;

# Resource .xprofile
~/.xprofile

