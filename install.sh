#!/bin/bash

set -e

# requires uuidgen curl
sudo apt-get update
sudo apt-get install -y curl uuid-runtime jq inotify-tool gzip

#copy the service file
cp adsbexchange-stats.service /etc/systemd/system/adsbexchange-stats.service

#enable service
systemctl enable adsbexchange-stats.service
