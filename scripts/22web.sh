#!/usr/bin/env bash
ipler=`cat /root/iplist`
read -sp "Please enter root password for all servers: " pass
echo
read -p "Please enter site name: " site
read -p "Please enter name of database: " dbnm
read -p "Please enter name of user for database: " dbusr
read -sp "Please enter password website: " wpass
echo
for ip in $ipler
do
ssh-keyscan $ip >> .ssh/known_hosts
Utype=$(sshpass -p $pass ssh root@$ip "cat /etc/issue | cut -f1 -d' '" 2>/dev/null)
Ftype=$(sshpass -p $pass ssh root@$ip "uname -o" 2>/dev/null)
ltype=$(sshpass -p $pass ssh root@$ip "cat /etc/centos-release | cut -f1 -d' '" 2>/dev/null)
c6vers=$(sshpass -p $pass ssh root@$ip "cat /etc/centos-release | cut -f3 -d' '" 2>/dev/null)
c7vers=$(sshpass -p $pass ssh root@$ip "cat /etc/centos-release | cut -f4 -d' ' | cut -f1,2 -d'.'" 2>/dev/null)
if [[ $ltype == "CentOS" ]] && [[ $c6vers == "6.7" ]]
    then
        echo "This is CentOS 6.7 server " $ip
        C6=$ip
    elif [[ $ltype == "CentOS" ]] && [[ $c7vers == "7.2" ]]
    then
        echo "This is CentOS 7.2 server " $ip
        C7=$ip
elif [[ $Ftype == "FreeBSD" ]] 
    then
        echo "This is FreeBSD server " $ip
        F=$ip
elif [[ $Utype == "Ubuntu" ]]
    then
        echo "This is Ubuntu server " $ip
        U=$ip
else
    echo "Script cannot determine type of any Linux or UNIX sevrer!!!"
fi
done
#ssh-keyscan $F $C7 $C6 $U >> .ssh/known_hosts
sshpass -p $pass ssh root@$F "pkg install -y apache24 mysql55-server-5.5.49 php56-5.6.23 mod_php56-5.6.23 php56-extensions-1.0 php56-mysql-5.6.23"
sshpass -p $pass scp baza/rc.conf root@$F:/etc/rc.conf
sshpass -p $pass scp baza/httpd.conf root@$F:/usr/local/etc/apache24/httpd.conf
cat baza/host | sed -e "s/ip/$F/Ig" > baza/hosts
sshpass -p $pass scp baza/hosts root@$F:/etc/hosts
#sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/apache24 start"
sshpass -p $pass ssh root@$F "mkdir /usr/local/domen/"
cat baza/80.name | sed -e "s/site/$site/Ig" > baza/$site
sshpass -p $pass scp baza/$site root@$F:/usr/local/domen/
sleep 1
sshpass -p $pass ssh root@$F "mkdir -p /usr/local/www/$site /var/log/httpd/"
sshpass -p $pass ssh root@$F "echo '<html><h1><center>Bu $site  saytidir</center></h1></html>' > /usr/local/www/$site/index.html"
#sshpass -p $pass scp baza/index.php root@$F:/usr/local/www/$site/
sshpass -p $pass ssh root@$F "touch /var/log/httpd/"$site"_access.log /var/log/httpd/"$site"_error.log"
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/apache24 start"
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/mysql-server start"
sshpass -p $pass ssh root@$F "/usr/local/bin/mysql_secure_installation"
sshpass -p $pass ssh root@$F "mysql -uroot -pfreebsd -e 'create database $dbnm;'"
sshpass -p $pass ssh root@$F "mysql -uroot -pfreebsd -e 'GRANT ALL PRIVILEGES ON $dbnm.* TO $dbusr@localhost IDENTIFIED BY $wpass WITH GRANT OPTION;'"
sshpass -p $pass ssh root@$F "mysql -uroot -pfreebsd -e 'FLUSH PRIVILEGES;'"
sleep 1
sed -e "s/dbnm/$dbnm/Ig" -e "s/dbusr/$dbusr/Ig" -e "s/wpass/$wpass/Ig" /root/baza/indext.php > /root/baza/index.php
sshpass -p $pass scp /root/baza/index.php root@$F:/usr/local/www/$site/
sshpass -p $pass ssh root@$F "/usr/local/bin/mysql_secure_installation"
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/apache24 restart ; /usr/local/etc/rc.d/mysql-server restart"

