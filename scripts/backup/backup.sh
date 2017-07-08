#!/bin/bash
# Checks for authorized Wi-Fi SSID or connected Ethernet before performing
# backup.

RUN=false;
AUTHFILE=authorized_networks.txt;
WIFI=$(iwgetid --raw);
ETH_IF=enp0s31f6;
ETH=$(ip link show $ETH_IF | perl -n -e'/state (\w+)/ && print $1');

if [ "$ETH" = "UP" ]; then
    echo "Performing backup over Ethernet";
    RUN=true;
elif [ -f $AUTHFILE ]; then
    if [ ! -z "$WIFI" ]; then
        if [ ! -z $(grep -e "^$WIFI$" "$AUTHFILE") ]; then
            echo "Performing backup over Wi-fi: $WIFI";
            RUN=true;
        else
            echo "Prohibited backup due to unauthorized Wi-fi: $WIFI";
        fi
    else
        echo "Not connected to a network."
        exit 1;
    fi
else
    echo "No AUTHFILE found!";
    exit 1;
fi

if $RUN; then
    echo "Starting backup at $(date +'%F_%T')";
    rsync -azAX --partial --delete --exclude-from=exclude.txt \
        --delete-excluded \
        / \
        backup:/ \
        && echo "Backup finnished $(date +'%F_%T')" || echo "Backup failed $(date +'%F_%T')"
fi

exit 0;
