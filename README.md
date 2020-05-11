# adsbexchange-stats
ADSBexchange.com Statistics Beta

This installer is meant only for an RPi running ADSBexchange.com script install.

You must be running ADSBexchange feeder.

Stats only.  Be sure to install ADSBexchange.com feeder package first.

### STEP 1: FEEDER PACKAGE

```
sudo bash -c "$(wget -nv -O - https://raw.githubusercontent.com/adsbxchange/adsb-exchange/master/install.sh)"
```

### STEP 2: STATS

```
cd /home/pi
git clone https://github.com/adsbxchange/adsbexchange-stats.git
cd adsbexchange-stats
sudo bash install.sh
```


### Systemd Status

```
sudo systemctl status adsbexchange-stats
```


### Restart

```
sudo systemctl restart adsbexchange-stats
```

BETA URL:

Replace your-uuid with adsbx stats generated uuid.

https://www.adsbexchange.com/api/feeders/?feed=your-uuid

--adsbx-git-discord

### Uninstall

```
sudo bash /usr/local/share/adsbexchange-stats/uninstall.sh
```

For early versions just disable the service:
```
sudo systemctl disable --now adsbexchange-stats
```
