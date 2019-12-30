#!/bin/bash

echo `date` Test 1: 
rm -f cam/*.jpg
rm -f blur/*.jpg

cp testPic/image.jpg cam
./normaize.sh
cp testPic/image2.jpg cam

./normaize.sh
result=$(./detectMotion.sh)
echo `date` Result: $result

