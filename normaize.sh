#!/bin/dash

latestImage=`ls -r cam | head -n1`
convert -colorspace LinearGray -normalize -blur 2x2  cam/$latestImage blur/$latestImage.mpc


