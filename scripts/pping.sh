#!/usr/bin/env bash

echo -n "xahish olunur IP unvani daxil edesiniz: > "

read IP

ping -c1 "$IP" ;

if  [ $? == 0 ]

then
    echo "host elcatandir"

else 
ping -c3 -t1 "$IP" 
echo "host ishlemir"
    echo " BU ${HOST} BU"$IP" CATA BILMIR" | mail -s 'CATA BILMIR'  root@localhosti

fi

#break

#exit 0 
