#!/bin/bash

systemctl stop combine1090-dump combine1090
systemctl disable combine1090-dump combine1090

rm -f /etc/systemd/system/combine1090.service
rm -f /etc/systemd/system/combine1090-dump.service
rm -f /lib/systemd/system/combine1090.service
rm -f /lib/systemd/system/combine1090-dump.service
rm /usr/local/bin/combine1090.sh
rm -f /etc/lighttpd/conf-enabled/89-combine1090.conf

/usr/local/share/tar1090/uninstall.sh combine1090


systemctl daemon-reload
systemctl restart lighttpd
