#!/bin/bash

opts="-d"
retry=15
tcpopts="keepalive,keepidle=30,keepintvl=30,keepcnt=2,connect-timeout=30,retry=2,interval=15"

echo -n "Starting data redirection with socat for combine1090:    "
date

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
				socat $opts -u TCP:$i:$p,$tcpopts TCP:$j,$tcpopts
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

for pair in $SOTA
do
	pair=(${pair//\// })
	i=${pair[0]}
	j=${pair[1]}
	sleep .2
	while true
	do
		echo "Redirecting: SOURCE: $i TARGET: $j"
		socat $opts -u TCP:$i,$tcpopts TCP:$j,$tcpopts
		echo "Lost connection: SOURCE: $i TARGET: $j"
		sleep $retry
		sleep $(($RANDOM%10)).$(($RANDOM%10))
	done &
done


while true
do
	sleep 1024
done &

wait
exit 0

