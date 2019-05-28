#!/bin/bash



if ! socat -h >/dev/null
then
	apt-get update
	apt-get install -y socat
fi


if [ -z $1 ] || [ $1 != "test" ]
then
	cd /tmp
	if ! wget -q -O master.zip https://github.com/wiedehopf/combine1090/archive/master.zip
	then
		echo "Unable to download files, exiting!"
		exit 1
	fi
	unzip -o master.zip
	cd combine1090-master
fi

# if you are reading this and trying to install using manual commands, use these instead of the block above
# cd /tmp
# wget -q -O master.zip https://github.com/wiedehopf/combine1090/archive/master.zip
# unzip -o master.zip
# cd combine1090-master


cp combine1090.default /etc/default/combine1090
cp combine1090.service /lib/systemd/system
#unmask or get rid of old versions of the service files
rm -f /etc/systemd/system/combine1090.service
cp combine1090.sh /usr/local/bin
chmod +x /usr/local/bin/combine1090.sh

systemctl daemon-reload
systemctl enable combine1090
systemctl restart combine1090

echo --------------
echo "All done, don't forget to configure (sudo nano /etc/default/combine1090)"
echo "After you are done with configuration don't forget"
echo "to apply the new settings (sudo systemctl restart combine1090)"
