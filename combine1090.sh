#!/bin/bash

opts="-T 90 -d"
retry=15

echo -n "Starting data redirection with socat for combine1090:    "
date


trap "kill 0" SIGINT
trap "kill -2 0" SIGTERM

for j in $TARGET
do
	for i in $SOURCES
	do
		for p in $PORTS
		do
			sleep .2
			while true
			do
				echo "Redirecting: SOURCE: $i:$p TARGET: $j"
				socat $opts -u TCP:$i:$p TCP:$j
				echo "Lost Connection: SOURCE: $i:$p TARGET: $j"
				sleep $retry
				sleep $(($RANDOM%10)).$(($RANDOM%10))
			done &
		done
	done
	for i in $CUSTOM
	do
		sleep .2
		while true
		do
			echo "Redirecting: SOURCE: $i TARGET: $j"
			socat $opts -u TCP:$i TCP:$j
			echo "Lost connection: SOURCE: $i TARGET: $j"
			sleep $retry
			sleep $(($RANDOM%10)).$(($RANDOM%10))
		done &
	done
done

while true
do
	sleep 1024
done &

wait
exit 0

