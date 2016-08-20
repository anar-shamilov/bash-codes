#!/bin/sh

/bin/sleep 2

d=`dmesg | tail -n 13 | grep umass-sim | grep da | tail -n 1 | awk '{ print $1 }'`

/usr/bin/true > /dev/$d

/usr/local/bin/ntfs-3g /dev/"$d"s1 /media
