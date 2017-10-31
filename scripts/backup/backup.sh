#!/bin/bash
# Checks for authorized Wi-Fi SSID or connected Ethernet before performing
# backup.

HOST=$(hostname)
RUN=false;
AUTHFILE=authorized_networks.txt;
WIFI=$(iwgetid --raw);
ETH_IF1=enp0s31f6;
ETH_IF2=enp13s0u1;
ETH1=$(ip link show $ETH_IF1 | perl -n -e'/state (\w+)/ && print $1');
ETH2=$(ip link show $ETH_IF2 | perl -n -e'/state (\w+)/ && print $1');

if [ "$ETH1" = "UP" ] || [ "$ETH2" = "UP" ]; then
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
    fi
else
    echo "No AUTHFILE found!";
fi

if $RUN; then
    echo "Starting backup of $HOST at $(date +'%F_%T')";
    rsync -aAX --partial --delete --exclude-from=exclude.txt \
        --delete-excluded \
        / \
        backup:/ \
        && (echo "Backup finished $(date +'%F_%T')"; \
            logger "backup finished $(date +'%F_%T')") \
        || (echo "Backup failed $(date +'%F_%T')"; \
            logger "backup failed $(date +'%F_%T')")
else
    echo "Backup failed $(date +'%F_%T')";
    logger "Backup failed $(date +'%F_%T')";
    exit 1;
fi

exit 0;
