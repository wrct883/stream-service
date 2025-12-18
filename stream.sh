#!/usr/bin/env bash

set -eo pipefail

rtpdump -F payload 0xefc007da/5004 | sox -V2 -c 2 -r 48000 -b 24 -e signed-integer -B -t raw - -t mp3 -C 128 - gain 5 | ezstream -v -c /home/wrct/stream/configs/ezstream-stdin.xml

exit 1
