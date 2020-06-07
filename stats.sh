#!/bin/bash
TMP=/tmp/adsbexchange-stats-git
if ! command -v git; then
    apt-get update
    apt-get install -y git
fi
rm -rf "$TMP"
git clone https://github.com/adsbxchange/adsbexchange-stats.git "$TMP"
cd "$TMP"
bash install.sh
