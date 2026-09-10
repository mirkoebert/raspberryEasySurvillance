#!/bin/bash
##################################################################
# This scripts sends a file to the configured FTP server 
##################################################################


#set -x
. ./arc/install/config # TODO myabe move to better fitting dir

sendToFtpServer(){
	if [ -n "$FTP_SERVER_RECORDINGS" ]; then
		curl -q -sS --retry 3 --max-time 16 --netrc-file /home/pi/.netrc --upload-file "$1" "ftp://$FTP_SERVER_RECORDINGS"
	fi
}

