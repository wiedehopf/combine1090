#!/bin/bash

opts="-T 90 -d"
retry=15

echo -n "Starting data redirection with socat for combine1090:    "
date


trap "kill 0" SIGINT
trap "kill -2 0" SIGTERM

for i in $SOURCES
do
	for j in $TARGET
	do
		for p in $PORTS
		do
			sleep .2
			while true
			do
				echo "Connecting: $j"
				socat $opts -u TCP:$i:$p TCP:$j
				echo "Connection failed: $j"
				sleep $retry
				sleep $(($RANDOM%10)).$(($RANDOM%10))
			done &
		done
	done
done

for i in $CUSTOM
do
	
	while true
	do
		socat $opts -u TCP:$i TCP:$TARGET
		sleep $retry
	done &
done
while true
do
	sleep 1024
done &

wait
exit 0

