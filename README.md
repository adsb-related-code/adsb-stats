# adsbexchange-stats
ADSBexchange.com Statistics Beta

You must be running ADSBexchange feeder.

Stats only.  Be sure to install ADSBexchange.com feeder package first.

### STEP 1: FEEDER PACKAGE

```
wget -O /tmp/axfeed.sh https://raw.githubusercontent.com/adsbxchange/adsb-exchange/master/install.sh
sudo bash /tmp/axfeed.sh
```

### STEP 2: STATS

```
wget -O /tmp/axstats.sh https://raw.githubusercontent.com/adsbxchange/adsbexchange-stats/master/stats.sh
sudo bash /tmp/axstats.sh
```

### Show stats URL on console
```
adsbexchange-showurl
```


### Systemd Status

```
sudo systemctl status adsbexchange-stats
```

### Restart

```
sudo systemctl restart adsbexchange-stats
```

### Figure the URL out yourself

Replace UUID with the adsbx stats generated uuid:

https://www.adsbexchange.com/api/feeders/?feed=UUID

--adsbx-git-discord

### Uninstall

```
sudo bash /usr/local/share/adsbexchange-stats/uninstall.sh
```

For early versions just disable the service:
```
sudo systemctl disable --now adsbexchange-stats
```
