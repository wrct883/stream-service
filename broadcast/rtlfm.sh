#!/usr/bin/env sh

mkdir -p wrct-broadcast && cd wrct-broadcast
if [ -p rtlfm ]; then
  rm rtlfm
fi
mkfifo rtlfm

rtl_fm -g 50 -f 88.3M -M wfm -s 180k -E deemp > rtlfm

exit 1
