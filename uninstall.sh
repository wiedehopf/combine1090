#!/bin/bash

systemctl stop combine1090-dump combine1090
systemctl disable combine1090-dump combine1090

rm /etc/systemd/system/combine1090.service
rm /etc/systemd/system/combine1090-dump.service
rm /usr/local/bin/combine1090.sh
lighty-disable-mod combine1090

systemctl daemon-reload
systemctl restart lighttpd
