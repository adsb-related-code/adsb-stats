#!/bin/bash

set -e

# requires uuidgen curl
apt-get update
apt-get install -y curl uuid-runtime jq inotify-tools gzip

#copy to /usr/bin
cp json-status /usr/bin/json-status

# create uuid
UUID_FILE="/boot/adsbx-uuid"
# look for uuid - if invalid or missing genrate one
if [ -s $UUID_FILE ]; then
        UUID=$(cat $UUID_FILE)
        if [[ $UUID =~ ^\{?[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}\}?$ ]]; then
                echo '1'
        else
                rm -f $UUID_FILE
                UUID=$(uuidgen -t)
                echo $UUID > $UUID_FILE
        fi
else
        UUID=$(uuidgen -t)
        echo $UUID > $UUID_FILE
fi

#copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

#enable service
systemctl enable adsbexchange-stats.service
