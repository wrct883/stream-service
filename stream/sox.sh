#!/usr/bin/env bash

if [ -f sox ]; then
  rm sox
fi
mkfifo sox

sox -q -c 2 -r 48000 -b 24 -e signed-integer -B -t raw rtpdump -t mp3 - gain 5 > sox

exit 1
