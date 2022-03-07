#!/bin/bash

set -e
trap 'echo "[ERROR] Error in line $LINENO when executing: $BASH_COMMAND"' ERR
renice 10 $$

IPATH=/usr/local/share/combine1090

function aptInstall() {
    if ! apt install -y --no-install-recommends --no-install-suggests "$@"; then
        apt update
        apt install -y --no-install-recommends --no-install-suggests "$@"
    fi
}

aptInstall wget socat

if [[ -z "$1" ]] || [[ "$1" != "test" ]]; then
	cd /tmp
	if ! wget -q -O master.zip https://github.com/wiedehopf/combine1090/archive/master.zip || ! unzip -q -o master.zip
	then
		echo "Unable to download files, exiting!"
		exit 1
	fi
	cd combine1090-master
elif [[ "$1" == "test" ]]; then
    tmpdir=/tmp/combine1090-test
    mkdir -p $tmpdir
    cp -r ./* $tmpdir
    cd $tmpdir
fi

if ! id -u combine1090 &>/dev/null
then
    adduser --system --home $IPATH --no-create-home --quiet combine1090
fi

# if you are reading this and trying to install using manual commands, use these instead of the block above
# cd /tmp
# wget -q -O master.zip https://github.com/wiedehopf/combine1090/archive/master.zip
# unzip -o master.zip
# cd combine1090-master

# remove old webinterface
rm -f /etc/lighttpd/conf-enabled/89-combine1090.conf

cp -n combine1090.default /etc/default/combine1090
cp combine1090.service /lib/systemd/system
#unmask or get rid of old versions of the service files
rm -f /etc/systemd/system/combine1090-dump.service /etc/systemd/system/combine1090.service
cp combine1090.sh /usr/local/bin
chmod +x /usr/local/bin/combine1090.sh

# compile readsb
bash readsb-nopackage.sh "$IPATH/bin"

systemctl enable combine1090

if [[ $1 == "redirect-only" ]]; then
    systemctl restart combine1090
	echo --------------
	echo "All done, don't forget to configure (sudo nano /etc/default/combine1090)"
	echo "After you are done with configuration don't forget"
	echo "to apply the new settings (sudo systemctl restart combine1090)"
	echo --------------
	exit 0
fi

cp combine1090-dump.service /lib/systemd/system
systemctl enable combine1090-dump
systemctl restart combine1090-dump
systemctl restart combine1090

wget -O tar1090-install.sh https://raw.githubusercontent.com/wiedehopf/tar1090/master/install.sh
bash tar1090-install.sh /run/combine1090 combine1090


echo --------------
echo "All done, don't forget to configure (sudo nano /etc/default/combine1090)"
echo "After you are done with configuration don't forget"
echo "to apply the new settings (sudo systemctl restart combine1090)"
echo "Webinterface available at $(ip route | grep -m1 -o -P 'src \K[0-9,.]*')/combine1090"
echo --------------


cd /tmp
rm -rf /tmp/combine1090-master /tmp/combine1090-test
