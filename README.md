# raspberryEasySurvillance
Easy Survillance Camera Software for Raspberry Pi Zero W

## Hardware
* Raperry Pi Zero W
* Cam Module without IR filter
* Power supply: TODO
* Case: TODO

## Install
* Install all dependencies
  * `./install.sh`
  * Image Magic
  * BC

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
* Better take a Raspberry Pi 4 or better
* Reducing blur: 14 sec / image
* Optimize normalization, reduce colorspace, use faster image format: 23 seconds / image
* Reduce Image size, One complete run takes 23 seconds / image. This mean 2 images per minute.
* Some optimizations: 75 seconds /image
* First try, full image resolution: 90 sec / image

### Details
* take photo: 5.8 sec
* normalize: ~~14.7 sec~~ 5.4 sec
* detect motion: 2.8 sec 

## Links
* [Creator Blog](https://programming-2.blogspot.com/2019/12/einfache-bewegungserkennung-auf-dem.html)
* [Achieving high frame rate with a Raspberry Pi camera system](https://chriscarey.com/blog/2017/04/30/achieving-high-frame-rate-with-a-raspberry-pi-camera-system/comment-page-1/)
*


