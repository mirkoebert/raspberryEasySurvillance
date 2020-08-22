# raspberryEasySurvillance
Easy Survillance Camera Software for Raspberry Pi Zero W

## Features
* Runs on every Raspberry Pi
* 1 MP resolution
* No hidden backdoors, using only standard software
* Resistant against Deauth WIFI attac

## Hardware
* Rsaperry Pi 
  * Zero W
  * Raspberry Pi 4
* Cam Module (without IR filter)
* Power supply: TODO
* Case: TODO

## Install
* Ensure that the camera is active
  * https://raspberrypi.stackexchange.com/questions/81753/camera-module-not-getting-detected/116338#116338
* Install all dependencies
  * `apt-get install -y imagemagic`
  * Image Magic
  * FTP for uploading images

## Run 
### Run Manually
### Run Automatically
* Add run.sh to cron
  * `crontab -e`
```
* * * * * /home/pi/raspberryEasySurvillance/run.sh 0
* * * * * /home/pi/raspberryEasySurvillance/run.sh 27 
```

## Who it works.
* Take a Photo
* Normaize Image
* Compare last two normalized imges

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
*


