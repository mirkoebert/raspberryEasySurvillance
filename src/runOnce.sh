#!/bin/bash
##################################################################
# This script execute the whole ceycle one time
# 
# 1 - read name from last imgae
# 2 - take a phote with raspberry cam
# 3 - normalize new image
# 4 - compare current image with the last image - motion detection
# 5 - handle motion detection
#
##################################################################


#set -x
. ./config

sendToFtpServer(){
	if [ -n "$FTP_SERVER_RECORDINGS" ]; then
		curl -q -sS --netrc-file /home/pi/.netrc -T "ftp/$DATE" "ftp://$FTP_SERVER_RECORDINGS"
	fi
}

exitIfBlackImage(){
	thresh=0.02 # (XX as fraction between 0 and 1)
	mean=$(convert "$(DATE)" -format "%[mean]" info:)
	meantest=$(convert xc: -format "%[fx:($mean/quantumrange)<$thresh?1:0]" info:)
	if [ "$meantest" -eq 1 ]; then
		exit
	fi
}


prevImage=$(ls -r cam/ | head -n 1)
camid=$(hostname)

DATE=$(date +"%Y-%m-%d_%H:%M:%S")_$camid.jpg
raspistill --rotation 270 --width 1296 --height 972 --timeout 1  --nopreview --quality 12  -o "cam/$DATE"
exitIfBlackImage
cp "cam/$DATE" /var/www/html/snapshot.jpg


latestNImage="blur/$DATE.mpc"
convert -colorspace LinearGray -normalize -blur 2x2  "cam/$DATE" "$latestNImage"

if [ -n "$prevImage" ]; then
	file2=$(ls -r blur/*.mpc | head -n 2 | tail -n 1)
	val=$(compare  -fuzz 10% -metric AE "$file2" "$latestNImage" null: 2>&1)
	val=$(printf '%.0f' "$val")
	file2Cache=$(ls -r blur/*.cache | head -n 2 | tail -n 1)
	rm -f "$file2" "$file2Cache"


	if [ "$val" -gt 1000 ]; then
		./src/reconnectWifi.sh
		cp "cam/$DATE" "ftp/"
		sendToFtpServer
		rm -f "ftp/$DATE"
	fi
	rm -f "cam/$prevImage"
fi


