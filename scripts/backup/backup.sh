#!/usr/bin/env bash
# Checks for authorized Wi-Fi SSID or connected Ethernet before performing
# backup.

# Copyright 2017 Andreas Lindhé
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

BACKUP_SCRIPT_DIR='/etc/backup'

# Update alive file
date '+%s' > ${BACKUP_SCRIPT_DIR}/alive

HOST=$(hostname)
RUN=false;
AUTHFILE=${BACKUP_SCRIPT_DIR}/authorized_networks.txt;
CHARGING=$(acpi --ac-adapter | grep "on-line")
WIFI=$(iwgetid --raw);
ETH_IF0=eth0;
ETH_IF1=eth1;
ETH_IF0_UP=$(ip link show $ETH_IF0 | perl -n -e'/state (\w+)/ && print $1');
ETH_IF1_UP=$(ip link show $ETH_IF1 | perl -n -e'/state (\w+)/ && print $1');

if [ ! -z "$CHARGING" ]; then
    if [ "$ETH_IF0_UP" = "UP" ] || [ "$ETH_IF1_UP" = "UP" ]; then
        echo "Performing backup over Ethernet";
        RUN=true;
    elif [ -f $AUTHFILE ]; then
        if [ ! -z "$WIFI" ]; then
            if [ ! -z "$(grep -e "^$WIFI$" "$AUTHFILE")" ]; then
                echo "Performing backup over Wi-fi: $WIFI";
                RUN=true;
            else
                echo "Prohibited backup due to unauthorized Wi-fi: $WIFI";
            fi
        else
            echo "Not connected to a network."
        fi
    else
        echo 'No AUTHFILE found!';
    fi
else
    echo "Not charging."
fi

if $RUN; then
    echo "Backup of $HOST started at $(date +'%F_%T')";
    rsync -aAX --partial --delete --delete-excluded / \
        --exclude-from=${BACKUP_SCRIPT_DIR}/exclude.txt \
        backup:/ \
        && (echo "Backup of $HOST finished $(date +'%F_%T')"; \
            logger "Backup of $HOST finished $(date +'%F_%T')") \
        || (echo "Backup of $HOST failed $(date +'%F_%T')"; \
            logger -p syslog.err "Backup of $HOST failed $(date +'%F_%T')"; \
            notify-send --urgency=critical 'Backup failed!' 'Check journalctl for details.')
else
    echo "Backup of $HOST failed $(date +'%F_%T')";
    logger -p syslog.err "Backup of $HOST failed $(date +'%F_%T')";
    notify-send --urgency=critical 'Backup failed!' 'Check journalctl for details.';
    exit 1;
fi

exit 0;
