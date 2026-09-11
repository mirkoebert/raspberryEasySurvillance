#!/bin/bash
##################################################################
# This script execute the whole cycle one time
# 
# 1 - read name from last image
# 2 - take a photo with raspberry's cam
# 3 - normalize new image
# 4 - compare current image with the last image - motion detection
# 5 - handle motion detection
#
##################################################################


#set -x
. ./src/main/send2FTP.sh


exitIfBlackImage(){
	thresh=0.02 # (XX as fraction between 0 and 1)
	mean=$(convert "cam/$newImageName" -format "%[mean]" info:)
	meantest=$(convert xc: -format "%[fx:($mean/quantumrange)<$thresh?1:0]" info:)
	if [ "$meantest" -eq 1 ]; then
		rm -f "cam/$newImageName"
		exit
	fi
}


camid=$(hostname)
# TODO use global vars for file names
prevImage=$(ls -r cam/ | head -n 1)

newImageName=$(date +"%Y-%m-%d_%H:%M:%S")_$camid.jpg
rpicam-still --rotation 270 --width 1296 --height 972 --timeout 1  --nopreview --quality 12  -o "cam/$newImageName"
exitIfBlackImage

# TODO check if this is the right dir
cp "cam/$newImageName" /var/www/html/snapshot.jpg


newImageNormalizedName="blur/$newImageName.mpc"
convert -colorspace LinearGray -normalize -blur 2x2  "cam/$newImageName" "$newImageNormalizedName"


if [ -n "$prevImage" ]; then
	file2=$(ls -r blur/*.mpc | head -n 2 | tail -n 1)
	val=$(compare  -fuzz 10% -metric AE "$file2" "$newImageNormalizedName" null: 2>&1)
	val=$(printf '%.0f' "$val")
	file2Cache=$(ls -r blur/*.cache | head -n 2 | tail -n 1)
	rm -f "$file2" "$file2Cache"


	if [ "$val" -gt 1000 ]; then
		./src/main/reconnectWifi.sh
		cp "cam/$newImageName" "ftp/"
		sendToFtpServer "ftp/$newImageName"
		rm -f "ftp/$newImageName"
	fi
	rm -f "cam/$prevImage"
else
  echo "No previous image exists. This is Ok after demon start.";
fi
