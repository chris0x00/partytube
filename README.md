partytube
=========

A collaborative Youtube video powered party jukebox for the Raspberry Pi.  Intended to be used with a PN532 NFC/RFID controller breakout board (available from Adafruit.com)

![alt tag](http://ethertubes.com/wp-content/uploads/partytube_playlist_small.jpg)

For more information on setup and operation see http://ethertubes.com/partytube/

Basic setup instructions:

sudo apt-get install libqrencode3 qrencode bzr
sudo adduser youtube
sudo su - youtube
curl https://yt-dl.org/latest/youtube-dl -o youtube-dl
chmod a+x youtube-dl
mkdir input
mkdir output
mkdir archive
wget https://github.com/ethertubes/partytube/archive/master.zip
unzip master.zip
rm master.zip
mv ./partytube-master/* .
rmdir partytube-master/
qrencode -o url.png -t PNG "http://yoursite.example.org"
exit
cd /usr/local/src
sudo bzr branch lp:nfcpy
sudo adduser youtube dialout
# comment out getty line for ttyAMA0 in /etc/inittab
# comment out ttyAMA0 line in /boot/cmdline.txt
cd ~youtube
sudo ./run.sh
