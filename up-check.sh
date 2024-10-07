#!/bin/bash

URL="https://streamalt.wrct.org/wrct-hi.mp3"

EXPECTED_HEADERS=(
    "HTTP/1.1 200 OK"
    "Content-Type: audio/mpeg"
    "icy-name: WRCT"
)

RESTART="systemctl restart wrct@stream.service"

ATTEMPTS=3
FAIL=0

for try in $(seq 1 $ATTEMPTS); do
    RESPONSE=$(curl -D - -s -o /dev/null --max-time 1 "$URL")

    IN_FAIL=false
    for HEADER in "${EXPECTED_HEADERS[@]}"; do
        if echo "$RESPONSE" | grep -q "$HEADER"; then
            echo "Matched: $HEADER"
        else
	    IN_FAIL=true
        fi
    done

    if [ "$IN_FAIL" = true ]; then
        ((FAIL++))
    fi

done

if [ $FAIL = $ATTEMPTS ]; then
    echo "$(date): Restarting"
    $RESTART
    exit 0
else
    echo "$(date): All Good"
fi
