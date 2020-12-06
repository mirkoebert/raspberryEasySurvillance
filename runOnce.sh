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
		ftpCompatibleFileNAme=$(echo "$prevImage" | sed -e 's/:/\\:/g')
		curl -q -sS --netrc-file /home/pi/.netrc -T "ftp/$ftpCompatibleFileNAme" "ftp://$FTP_SERVER_RECORDINGS"
	fi
}



prevImage=$(ls -r cam/ | head -n 1)
camid=$(hostname)

DATE=$(date +"%Y-%m-%d_%H:%M:%S")_$camid.jpg
raspistill --rotation 270 --width 1296 --height 972 --timeout 1  --nopreview --quality 12  -o "cam/$DATE"
cp "cam/$DATE" /var/www/html/snapshot.jpg


latestNImage="blur/$DATE.mpc"
convert -colorspace LinearGray -normalize -blur 2x2  "cam/$DATE" "$latestNImage"

if [ -n "$prevImage" ]; then
	file2=$(ls -r blur/*.mpc | head -n 2 | tail -n 1)
	val=$(compare  -fuzz 10% -metric AE "$file2" "$latestNImage" null: 2>&1)
        val=$(printf '%.0f' "$val")
	file2Cache=$(ls -r blur/*.cache | head -n 2 | tail -n 1)
	rm "$file2" "$file2Cache"


	if [ "$val" -gt 1000 ]; then
		FILE=stateMotionDected
		if test -f "$FILE"; then
			rm "$FILE"
		else
			touch $FILE 
			cp "cam/$DATE" "ftp/"
			mv "cam/$prevImage" "ftp/"
			sendToFtpServer
			rm "ftp/$prevImage"
			exit;
		fi
	fi
	rm "cam/$prevImage"
fi


