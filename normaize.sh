#!/bin/bash


latestImage=`ls -r cam | head -n1`
convert -normalize -blur 0x8  cam/$latestImage blur/$latestImage


