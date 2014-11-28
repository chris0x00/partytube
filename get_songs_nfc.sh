#!/bin/bash

while [ 1 ]
do
	url="$(/usr/local/src/nfcpy/examples/beam.py --mode t --device tty:AMA0:pn53x recv print 2>/dev/null |grep youtube)"
	echo "$url"
	url="${url##*'youtube'}"
	url="${url%%\'*}"
	if [ -n "$url" ]; then
		url="http://www.youtube$url"
		./youtube-dl --restrict-filenames -o './input/%(id)s.%(ext)s' "$url"
		filename="$(ls -u ./input/ |head -n1)"
		if [ -n "$filename" ]; then
			if [ "${filename: -4}" == ".mp4" ]; then
				id="${filename%'.'*}"
				./youtube-title.sh "$id" >./output/$id.txt
				./youtube-thumb.sh "$id"
				mv "./input/$filename" "./output/$filename"
			else
				# Only dealing with mp4 files
				echo "Not an mp4 file" >&2
				rm "./input/$filename"
			fi
		fi
	fi
done
