#!/usr/bin/env sh

mkdir -p wrct-stream && cd wrct-stream
if [ -p rtpdump ]; then
  rm rtpdump
fi
mkfifo rtpdump

rtpdump -F payload 0xefc01b59/5004 > rtpdump
exit 1
