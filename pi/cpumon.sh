#!/bin/bash

# Script to monitor CPU usage at a configurable interval
# rehan.janjua@cuedos.io

SN=$(basename $0)
DEFAULT_INTERVAL=60

usage() {
	echo
	echo "$SN <interval> (s)"
	echo
}

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	usage
	exit 0
fi

# Set Interval
if [ -z "$1" ]; then
	INTERVAL=$DEFAULT_INTERVAL
else
	INTERVAL=$1
fi

# If ARG1 an Integer?
if ! [[ $INTERVAL =~ ^[0-9]+$ ]]; then
	usage
	exit 1
fi


echo "Checking clock speed and temperature at $INTERVAL second intervals..."
while test [1]; do

	CLOCK=$((`vcgencmd measure_clock arm | awk -F '=' '{print $2}'` / 1000000))
	TEMP=$(vcgencmd measure_temp)

	echo -e "$(date +%Y-%m-%d-%H_%M) speed=$CLOCK  Mhz   $TEMP"
	sleep $INTERVAL
done


