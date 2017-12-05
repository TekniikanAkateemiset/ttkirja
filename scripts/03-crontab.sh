#!/bin/bash

FILES=conf/crontab/*

for f in $FILES
do
  cp $f /etc/periodic/15min
  echo "Copied $f to /etc/periodic/15min"
done
