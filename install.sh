#!/bin/bash

cd /tmp
wget https://github.com/wiedehopf/combine1090/archive/master.zip
unzip master.zip
cd combine1090-master


cp combine1090.default /etc/default/combine1090
cp combine1090.service combine1090-dump.service /etc/systemd/system
cp combine1090.sh /usr/local/bin
chmod +x /usr/local/bin/combine1090.sh
cp 89-combine1090.conf /etc/lighttpd/conf-available
lighty-enable-mod combine1090


systemctl daemon-reload
systemctl enable combine1090-dump combine1090
systemctl restart combine1090-dump combine1090 lighttpd
