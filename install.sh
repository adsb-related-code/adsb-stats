#!/bin/bash

IPATH=/usr/local/share/adsbexchange-stats/
set -e

mkdir -p $IPATH

if ! id -u adsbexchange &>/dev/null
then
    adduser --system --home $IPATH --no-create-home --quiet adsbexchange >/dev/null || adduser --system --home-dir $IPATH --no-create-home adsbexchange
fi

# commands used
COMMANDS="curl uuidgen jq inotifywait gzip host perl"
# corresponding packages
PACKAGES="curl uuid-runtime jq inotify-tools gzip dnsutils perl"

for CMD in $COMMANDS; do
    if ! command -v $CMD &>/dev/null; then
        if command -v apt-get &>/dev/null; then
            apt-get update
            apt-get install -y $PACKAGES
        elif command -v yum &>/dev/null; then
            yum install -y curl util-linux jq inotify-tools gzip bind-utils perl
        fi
    fi
done

mkdir -p /usr/local/bin
cp adsbexchange-showurl /usr/local/bin/adsbexchange-showurl

hash -r

cp json-status $IPATH
cp create-uuid.sh $IPATH
chmod +x $IPATH/json-status
chmod +x $IPATH/create-uuid.sh
cp uninstall.sh $IPATH

if [ -f /boot/adsb-config.txt ] && ! [ -d /run/adsbexchange-feed ] && ! [ -f /etc/default/adsbexchange-stats ]
then
    echo "USE_OLD_PATH=1" > /etc/default/adsbexchange-stats
fi

bash $IPATH/create-uuid.sh

# copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

# add adsbexchange user to video group for vcgencmd get_throttled if the system has that command and it works:
if vcgencmd get_throttled &>/dev/null; then
    adduser adsbexchange video
fi

# enable service
systemctl enable adsbexchange-stats.service

# start service
systemctl restart adsbexchange-stats.service

# output uuid
echo "#####################################"
cat /boot/adsbx-uuid
echo "#####################################"
sed -e 's$^$https://www.adsbexchange.com/api/feeders/?feed=$' /boot/adsbx-uuid
echo "#####################################"
