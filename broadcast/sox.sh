#!/usr/bin/env sh

if [ -f sox ]; then
  rm sox
fi
mkfifo sox

sox -t raw -r 180k -e signed -b 16 -c 1 rtlfm -t mp3 - remix 1 lowpass 16k > sox

exit 1
