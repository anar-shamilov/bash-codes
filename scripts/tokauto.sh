#!/usr/bin/env bash
ipler=`cat /root/iplist`
read -sp "enter password for root: " pas
echo
mkdir /root/.ssh
$(ssh-keygen -q -N '' -f ~/.ssh/id_rsa)
$(cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys)
iz=$(ifconfig em0 | grep 'inet '| cut -d: -f2 | cut -d" " -f2)
$(ssh-keyscan $iz > .ssh/known_hosts 2>/dev/null)
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
