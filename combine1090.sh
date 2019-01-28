#!/bin/bash

opts="-d"

echo -n "Starting data redirection with socat for combine1090:    "
date


trap "kill 0" SIGINT
trap "kill -2 0" SIGTERM

for i in $SOURCES
do
	
	while true
	do
		socat $opts -u TCP:$i:30005 TCP:$TARGET
		sleep 30
	done &

	while true
	do
		socat $opts -u TCP:$i:30105 TCP:$TARGET
		sleep 30
	done &
done

for i in $CUSTOM
do
	
	while true
	do
		socat $opts -u TCP:$i TCP:$TARGET
		sleep 30
	done &
done

wait

