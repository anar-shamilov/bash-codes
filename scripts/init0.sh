#!/usr/bin/env bash

ipler=`cat iplist`
for ip in $ipler 
do
    sshpass -p freebsd ssh $ip "init 0"
done
init 0

