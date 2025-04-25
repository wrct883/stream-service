#!/bin/bash
kill -9 $(ps -aux | grep stream.sh | grep -v grep | awk '{print $2}')
