#!/bin/bash

# Get a selection of hardware system information
# rehanj@etherzine.com

echo "CPU Speeds"
for src in arm core h264 isp v3d uart pwm emmc pixel vec hdmi dpi; do
	echo -e "$src:\t$(vcgencmd measure_clock $src)" | while read cpu speed; do 
		freq=`echo $speed | cut -d = -f1`
		Hz=`echo $speed | cut -d = -f2`
		MHz=$(($Hz/1000000))
		echo -e "$cpu\t$freq\t$Hz Hz ($MHz MHz)"
	done
done


echo
echo "Voltage"
for id in core sdram_c sdram_i sdram_p ; do
	if [ "$id" = "core" ]; then
		TABS="\t\t"
	else
		TABS="\t"
	fi
	echo -e "$id:$TABS$(vcgencmd measure_volts $id)"
done

echo
echo "Temperature"
vcgencmd measure_temp

echo
echo "Hardware Codecs"
for codec in H264 MPG2 WVC1 MPG4 MJPG WMV9; do 
	echo -e "$codec:\t$(vcgencmd codec_enabled $codec)"; 
done

echo
echo "Memory"
vcgencmd get_mem arm 
vcgencmd get_mem gpu
free -m
