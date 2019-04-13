# combine1090
Combine data from multiple dump1090 receivers (or other receivers providing beast protocol data) into one dump1090-fa

Does not interfere with an already configured dump1090-fa but instead creates another instance with its own map.

On how to install dump1090-fa please scroll down to the end of this page.

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



## Installing dump1090-fa

Install the repository, using commands listed in the first dark box of this page: https://flightaware.com/adsb/piaware/install
The commands should look like this, but the version may have changed, which is why you should check the mentioned web page.
```
wget http://flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_3.6.3_all.deb
sudo dpkg -i piaware-repository_3.6.3_all.deb
```

Then instead of installing piaware which is not needed for combine1090, use the following commands to install dump1090-fa

```
sudo apt update
sudo apt install dump1090-fa
```
