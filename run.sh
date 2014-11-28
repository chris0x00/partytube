#!/bin/bash


URL="http://yoururl.example.com/party"

if [ "$(id -u)" != "0" ]; then
	echo "This script requires root" >&2
	exit 1
fi

cd "$(dirname "$0")"

script_startup() {
	sudo -u youtube bash -c "screen -mdS nfc_collect /home/youtube/get_songs_nfc.sh"
	sudo -u youtube bash -c "screen -mdS http_collect /home/youtube/get_songs_http.sh $URL"
}

script_shutdown() {
	sudo -u youtube bash -c "killall screen"
	killall omxplayer
}

if ! [ -f "./url.png" ]; then
	qrencode -o ./url.png -t PNG "$URL"
fi

trap "script_shutdown" EXIT SIGTERM
script_startup

echo "Starting"
./show_playlist.py

while [ 1 ]
do
	echo "Showing playlist"
	./show_playlist.py
	clear >/dev/tty0
	tput civis >/dev/tty0
	sleep 1
	filename="$(ls -u ./output/ |grep -vie '\.JPG'$ |grep -vie '\.TXT'$ |tail -n1)"
	if [ -n "$filename" ]; then
		echo "Playing $(cat "./output/${filename%'.'*}".txt)"
		omxplayer "./output/$filename" 2>/dev/null
		if [ -d "./archive" ]; then
			filename="${filename%'.'*}"
			ls ./output/ |grep "$filename" |xargs -n1 -i{} mv "./output/{}" "./archive"
			chown -R youtube: ./archive
		fi
	fi
	#tput cnorm
done

