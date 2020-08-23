#!/bin/bash
#set -x

#run scripts with sudo
if [[ `id -u` -ne 0 ]] ; then echo "Please run this script as root" ; exit 1 ; fi

echo "Install software dependencies"
apt-get --yes install imagemagick tree lftp

echo "Configure Service"
cp survillancecam.service /etc/systemd/system/

echo "Enable Service at System Start"
echo 
echo sudo systemctl enable survillancecam.service
echo
echo "Star" Service"
echo
echo "sudo systemctl start survillancecam.service"
echo 


