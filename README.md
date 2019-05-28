# combine1090
Combine data from multiple dump1090 receivers (or other receivers providing beast protocol data) into one dump1090-fa

Does not interfere with an already configured dump1090-fa but instead creates another instance with its own map.

On how to install dump1090-fa please scroll down to the end of this page.

## Installation:
```
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/wiedehopf/combine1090/master/install.sh)"
```
(or download install.sh and execute it with "bash install.sh")
## Installation data redirection only:
```
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/wiedehopf/combine1090/master/redirect_only.sh)"
```
(dump1090-fa config settings in /etc/default/combine1090 have no effect, you need to provide a target to feed the data into yoursefl)

## Configuration:

Edit /etc/default/combine1090 to configure which IP addresses this script should get the ADS-B data from
```
sudo nano /etc/default/combine1090
```
Ctrl-x to exit, y (yes) to save when asked.
Then restart combine1090:
```
sudo systemctl restart combine1090
```

## View the map:

Click the following URL and replace the IP address with the IP address of the Raspberry Pi you installed combine1090 on.

http://192.168.2.33/combine1090


### Deinstallation:
```
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/wiedehopf/combine1090/master/uninstall.sh)"
```



## Installing dump1090-fa

In case you are using fr24feed, you need to first change the fr24feed settings:
```
sudo nano /etc/fr24feed.ini
```
Change the first line and the 3rd to 5th line to the following, leave the fr24key as it is.
```
receiver="beast-tcp"
fr24key="xxxxxxxxxxxxxxxx"
host="127.0.0.1:30005"
bs="no"
raw="no"
```
Ctrl-o and enter to save, Ctrl-X to exit

To activate the settings, restart fr24feed:
```
sudo systemctl restart fr24feed
```

Use the following commands to install dump1090-fa
(piaware will not be installed, the piaware-repository is where apt install will get the dump1090-fa package from)

```
wget http://flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_3.7.1_all.deb
sudo dpkg -i piaware-repository_3.7.1_all.deb
sudo apt update
sudo apt upgrade -y
sudo apt remove -y dump1090-mutability
sudo apt remove -y dump1090
sudo rm /etc/lighttpd/conf-enabled/89-dump1090.conf
sudo apt install -y dump1090-fa
```
