#!/bin/bash
#set -x

cat /proc/cpuinfo | grep Model

#run scripts with sudo
if [[ `id -u` -ne 0 ]] ; then echo "Please run this script as root" ; exit 1 ; fi

echo "Install software dependencies"
apt-get update
apt-get --yes install imagemagick tree lftp lighttpd  boxes dialog unattended-upgrades 

echo "Enable automatic installation of security updates"
sudo dpkg-reconfigure -plow unattended-upgrades

echo "Setup lighttpd"
groupadd www-data
usermod -G www-data -a pi
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html
service lighttpd force-reload

echo "Server Mode Setup: Disable WIFI Power Saving"
iwconfig wlan0 power off
echo "wireless-power off"  >> /etc/network/interfaces

echo "Disable unneeded components"
/opt/vc/bin/tvservice -o

echo "Configure Service" | boxes -d boy -ac
cp ./src/config/survillancecam.service /etc/systemd/system/

echo "Enable Service at System Start"
echo 
systemctl enable survillancecam.service
echo
echo "Start Service at System Start"
systemctl start survillancecam.service
echo
echo "Check Service is running"
systemctl status survillancecam.service
echo
echo "Run ./config.sh to configure the software"
echo

