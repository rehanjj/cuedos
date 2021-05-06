#!/bin/bash

# Get CPU clock speed
# rehan.janjua@cuedos.io

for src in arm core h264 isp v3d uart pwm emmc pixel vec hdmi dpi; do

	echo -e "$src:\t$(vcgencmd measure_clock $src)"

done
