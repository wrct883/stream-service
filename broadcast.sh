#!/usr/bin/env bash

set -eo pipefail

rtl_fm -f 88.3M -M wfm -s 160k -E deemp -F 9 \
| sox -t raw -r 160k -e signed -b 16 -c 1 -V1 - -t mp3 -r 48000 -c 2 - remix 1 lowpass 16k \
| ezstream -c /home/wrct/stream/configs/ezstream-broadcast.xml


exit 1
