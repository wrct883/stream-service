#!/bin/bash
rtpdump -F payload 0xefc00431/5004 | sox -q -c 2 -r 48000 -b 24 -e signed-integer -B -t raw - -t mp3 - gain 5 | ezstream -c ../stream/ezstream-stdin.xml
