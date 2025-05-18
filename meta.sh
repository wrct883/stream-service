#!/bin/bash

get_metadata() {
    show=$(curl --silent -H 'Authorization: Bearer NOPE' 'https://spinitron.com/api/shows?count=1' | jq -r '.items[0] | "\(.title)"' | iconv -t utf-8)
    song_artist=$(curl --silent -H 'Authorization: Bearer NOPE' 'https://spinitron.com/api/spins?count=1' | jq -r '.items[0] | "\(.song) - \(.artist)"' | iconv -t utf-8)
    echo "$show: $song_artist"
}

case "$1" in
    "")
        get_metadata
        ;;
    *)
	echo ""
        ;;
esac

exit 0
