#!/bin/bash
##################################################################
# This scripts sends a file to the configured FTP server 
##################################################################


#set -x
. ./config

sendToFtpServer(){
	if [ -n "$FTP_SERVER_RECORDINGS" ]; then
		curl -q -sS --netrc-file /home/pi/.netrc --upload-file "$1" "ftp://$FTP_SERVER_RECORDINGS"
	fi
}

