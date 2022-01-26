#!/bin/bash

IPATH=/usr/local/share/adsbexchange-stats/
set -e

mkdir -p $IPATH

if ! id -u adsbexchange &>/dev/null
then
    adduser --system --home $IPATH --no-create-home --quiet adsbexchange >/dev/null || adduser --system --home-dir $IPATH --no-create-home adsbexchange
fi

# commands used
COMMANDS="curl uuidgen jq gzip host perl"
# corresponding packages
PACKAGES="curl uuid-runtime jq gzip dnsutils perl"

for CMD in $COMMANDS; do
    if ! command -v $CMD &>/dev/null; then
        if command -v apt-get &>/dev/null; then
            apt-get update || true
            apt-get install --no-install-suggests --no-install-recommends -y $PACKAGES || true
        elif command -v yum &>/dev/null; then
            yum install -y curl util-linux jq inotify-tools gzip bind-utils perl || true
        fi
    fi
done
if ! [[ -f /usr/lib/bash/sleep ]];
then
    apt update || true
    apt install -y --no-install-suggests --no-install-recommends bash-builtins || true
fi

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

# copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

# add adsbexchange user to video group for vcgencmd get_throttled if the system has that command and it works:
if vcgencmd get_throttled &>/dev/null; then
    adduser adsbexchange video
fi

# enable service
systemctl enable adsbexchange-stats.service


# exit success for chroot
if ischroot; then
    exit 0
fi

bash $IPATH/create-uuid.sh

# start service
systemctl restart adsbexchange-stats.service

# output uuid
echo "#####################################"
cat /boot/adsbx-uuid
echo "#####################################"
sed -e 's$^$https://www.adsbexchange.com/api/feeders/?feed=$' /boot/adsbx-uuid
echo "#####################################"
