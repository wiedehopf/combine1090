#!/bin/bash

opts="-d"
retry=40

echo -n "Starting data redirection with socat for combine1090:    "
date


trap "kill 0" SIGINT
trap "kill -2 0" SIGTERM

for i in $SOURCES
do
	
	for p in $PORTS
	do
		while true
		do
			socat $opts -u TCP:$i:$p TCP:$TARGET
			sleep $retry
		done &
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

wait
exit 0

