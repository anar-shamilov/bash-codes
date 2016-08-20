#!/usr/local/bin/bash

file=`cat /root/dnsname/names`

for i in $file
    do
	echo sayt: $i
	dig A $i | egrep -v ';|^$' | awk '{ print $5 }'
	echo -e '\n'
    done
