#!/usr/bin/env bash
a=5
b=6
if [ $b -eq 6 ]
then
    echo $a
    a=7
fi

function sa(){
   echo $a
}

sa
echo $a


