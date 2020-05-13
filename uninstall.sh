#!/bin/bash
set -x
IPATH=/usr/local/share/adsbexchange-stats/

systemctl disable --now adsbexchange-stats.service

rm -f /etc/systemd/system/adsbexchange-stats.service
rm -rf $IPATH

rm /usr/local/bin/adsbexchange-showurl

set +x

echo -----
echo "adsbexchange-stats have been uninstalled!"
