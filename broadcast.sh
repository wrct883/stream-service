#!/usr/bin/env bash

set -eo pipefail

rtl_fm -g 50 -f 88.3M -M wfm -s 180k -E deemp | sox -t raw -r 180k -e signed -b 16 -c 1 -V1 - -t mp3 - remix 1 lowpass 16k | ezstream -c /home/wrct/stream/configs/ezstream-broadcast.xml

exit 1
