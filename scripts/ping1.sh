#!/usr/bin/env bash

for i in $( cat $HOME/iplist )
do
ping -q -c1 $i > /dev/null

if [ $? -eq 0 ]
then
echo $i "host el catandir"
else
echo $i "host ishlemir"
fi
done
