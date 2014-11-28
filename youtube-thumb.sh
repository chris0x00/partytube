#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <Youtube ID>" >&2
	exit 1
fi
url="https://www.youtube.com/watch?v=$1"

curl -s "$url" |while read line
do
	if [ "${line//'thumbnailUrl'}" != "$line" ]; then
		line="${line##*'href="'}"
		line="${line%%'">'*}"
		echo "$line"
		if [ "${line:0:4}" == "http" ]; then
			curl -s -o "./output/$1.jpg" "$line"
			break
		fi
	fi
done
