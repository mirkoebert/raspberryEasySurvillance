# raspberryEasySurvillance
Easy Survillance Camera Software for Raspberry Pi Zero W with only Open Source Linux Onboard Software. 

## Features
* Runs on every Raspberry Pi
* 1 MP resolution
* No hidden backdoors, using only Linux standard software
* No Spyware: Alexa, Siri, ...
* Resistant against **Deauth WIFI attac**
* Run as system deamon
* Motion Detection
* Uploading images to FTP server
* Http: show last snapshot http://raspberrypiCam1.local/snapshot.jpg


## Hardware
* Rsaperry Pi 
  * Zero W or
  * Raspberry Pi 4
* Cam Module (without IR filter)
* Power supply
* Case

## Costs
* Raspberry Zero W:    10 Euro
* Raspberry Cam Modul  16 Euro
* Micro SD Card 16GB:   4 Euro
* USB Power Adapeter:   5 Euro 
* Case:                12 Euro
* **Total:               47 Euro**


## Prepare
* Get latest Imager: **https://www.raspberrypi.org/software/**
* Flash image: **Raspberry Pi OS lite**
* Configure:
  * there you can change the computer name
  * enable ssh
  * cofigure ssh
  * configure WIFI
* start the raspberry and login via ssh
* upgrade all software
* install git
* Enable rasperyy cam: **sudo raspi-config**
* disable energy saving
  * vi **/etc/network/interfaces**
pre-up iw dev wlan0 set power_save off
post-down iw dev wlan0 set power_save on


## Install
* Clone this GIT repo `git clone https://github.com/mirkoebert/raspberryEasySurvillance.git`
* `cd raspberryEasySurvillance`
* Run `sudo ./install.sh` to install all needed software
* Activate Raspberry Cam running in terminal: `sudo raspi-config`
* Configure this software `./config.sh`
* Check `sudo systemctl status survillancecam.service`


## Manuell Setup
* configure FTP credentials in ~/.netrc
* configure config file
  * set working dir
  * set FTP server name

## Check
* try to get a picutre from the cam: http://your-cam-name/snapshot.jpg

## Troubleshooting
* Ensure that the camera is active
  * https://raspberrypi.stackexchange.com/questions/81753/camera-module-not-getting-detected/116338#116338


## Run 
### Run Manually
### Run Automatically
Run as deamon:
* `sudo systemctl start survillancecam.service`
 
## How it works
* Take a Photo
* Normaize Image
* Compare last two normalized images
* If motion is detected, Upload image to FTP server

## Performance
#### Raspberry Zero W
* Better take a Raspberry Pi 4 or better
* Take a photo and process it:  8.4 sec

### History 
* Set time out to 1: 9 sec / image
* Reducing blur: 14 sec / image
* Optimize normalization, reduce colorspace, use faster image format: 23 seconds / image
* Reduce Image size, One complete run takes 23 seconds / image. This mean 2 images per minute.
* Some optimizations: 75 seconds /image
* First try, full image resolution: 90 sec / image

### Details
#### Raspberry Zero W
* take photo: ~~5.8 sec~~ 0.7 sec
* normalize: ~~14.7 sec~~ 5.4 sec
* detect motion: 2.8 sec 

## Links
* [Creator Blog](https://programming-2.blogspot.com/2019/12/einfache-bewegungserkennung-auf-dem.html)
* [Achieving high frame rate with a Raspberry Pi camera system](https://chriscarey.com/blog/2017/04/30/achieving-high-frame-rate-with-a-raspberry-pi-camera-system/comment-page-1/)
* [Curl netrc](https://ec.haxx.se/usingcurl/usingcurl-netrc)


