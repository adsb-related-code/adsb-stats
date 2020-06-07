#!/bin/bash

IPATH=/usr/local/share/adsbexchange-stats/
set -e

mkdir -p $IPATH

if ! id -u adsbexchange &>/dev/null
then
    adduser --system --home $IPATH --no-create-home --quiet adsbexchange >/dev/null
fi

# requires uuidgen curl jq inotify-tools gzip
apt-get update
apt-get install -y curl uuid-runtime jq inotify-tools gzip

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

#copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

#wait (needed?)
sleep 2

#enable service
systemctl enable adsbexchange-stats.service

#start service
systemctl restart adsbexchange-stats.service

#output uuid
echo "#####################################"
cat /boot/adsbx-uuid
echo "#####################################"
sed -e 's$^$https://www.adsbexchange.com/api/feeders/?feed=$' /boot/adsbx-uuid
echo "#####################################"
