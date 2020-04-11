#!/bin/bash
set -x
IPATH=/usr/local/share/adsbexchange-stats/

systemctl disable --now adsbexchange-stats.service

rm -f /etc/systemd/system/adsbexchange-stats.service
rm -rf $IPATH

set +x

echo -----
echo "adsbexchange-stats uninstalled"
