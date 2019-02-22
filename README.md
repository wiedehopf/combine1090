# combine1090
Combine data from multiple dump1090 receivers (or other receivers providing beast protocol data) into one dump1090-fa

## Installation:
```
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/wiedehopf/combine1090/master/install.sh)"
```
(or download install.sh and execute it with "bash install.sh")

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

