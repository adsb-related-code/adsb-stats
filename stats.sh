#!/bin/bash
TMP=/tmp/adsbexchange-stats-git
if ! command -v git; then
    apt-get update
    apt-get install -y git
fi
rm -rf "$TMP"
set -e
git clone https://github.com/adsbexchange/adsbexchange-stats.git "$TMP"
cd "$TMP"
bash install.sh
