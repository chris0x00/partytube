#!/bin/bash

get_songs() {
while read url
do
	if [ "${url//youtube}" != "$url" ]; then
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
}

while [ 1 ]
do
	curl -s "$1/get.php" |get_songs
	sleep 60
done
