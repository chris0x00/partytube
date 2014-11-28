#!/bin/bash

today="$(date +%s)"
future=$((today + 86400))
for id in *.mp4
do
	id="${id%'.'*}"
	((++future))
	touch -d "$(date -d "1970-01-01 $future seconds GMT")" "$id.mp4"
        touch -d "$(date -d "1970-01-01 $future seconds GMT")" "$id.txt"
        touch -d "$(date -d "1970-01-01 $future seconds GMT")" "$id.jpg"
	echo "$future $id"
done

