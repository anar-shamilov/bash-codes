#!/usr/bin/env bash

ping -q -c1 google.com > /dev/null
 
if [ $? -eq 0 ]
then
	echo "host el catandir"
fi
