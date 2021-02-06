#!/bin/bash
#set -x

#run scripts with sudo
if [[ `id -u` -ne 0 ]] ; then echo "Please run this script as root" ; exit 1 ; fi

echo "Install software dependencies"
apt-get --yes install imagemagick tree lftp lighttpd  boxes dialog


echo "Setup lighttpd"
sudo groupadd www-data
sudo usermod -G www-data -a pi
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 775 /var/www/html
sudo service lighttpd force-reload

echo "Server Mode Setup: Disable WIFI Power Saving"
sudo iwconfig wlan0 power off
sudo echo "wireless-power off"  >> /etc/network/interfaces

echo "Configure Service" | boxes -d boy -ac
cp survillancecam.service /etc/systemd/system/

echo "Enable Service at System Start"
echo 
sudo systemctl enable survillancecam.service
echo
echo "Start Service at System Start"
sudo systemctl start survillancecam.service
echo
echo "Check Service is running"
sudo systemctl status survillancecam.service
echo
echo "Run ./config.sh to configure the software"
echo

