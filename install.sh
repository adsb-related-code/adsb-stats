#!/bin/bash

set -e

# requires uuidgen
apt-get -y install uuid-runtime

#copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

#enable service
systemctl enable adsbexchange-stats.service
