#!/usr/bin/env bash
#
# Author: Anar Shamilov
# This srcipt requires IP adresses from "iplist" file/
# Then authomatically configure SSH token authentication for all IP addresses.

ipler=`cat /root/iplist`
read -sp "enter password for root: " pas
echo
mkdir /root/.ssh
for ip in $ipler
do
    $(ssh-keyscan $ip >> .ssh/known_hosts 2>/dev/null)
    sshpass -p $pas ssh root@$ip "ssh-keygen -q -N '' -f ~/.ssh/id_rsa"
    sshpass -p $pas ssh root@$ip "cat /root/.ssh/id_rsa.pub" >> /root/.ssh/authorized_keys
done
auk=.ssh/authorized_keys
nh=.ssh/known_hosts
for ip in $ipler
do
sshpass -p $pas scp -r $nh $auk root@$ip:/root/.ssh/
done
