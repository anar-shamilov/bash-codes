#!/usr/bin/env bash
#mutleq qarshi mashinlarda shell muhutu bash olmalidi

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
    $(ssh-keyscan $ip >> .ssh/known_host 2>/dev/null)
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
FSh="sshpass -p $pass ssh root@$F"
Fbsd () {
$FSh "pkg install -y apache24"
$FSh "pkg install -y mysql55-server-5.5.49"
$FSh "pkg install -y php56-5.6.23 mod_php56-5.6.23 php56-extensions-1.0 php56-mysql-5.6.23"
$FSh "sysrc mysql_enable="YES" apache24_enable="YES""
cat baza/host | sed -e "s/ip/$F/Ig" > baza/hosts
sshpass -p $pass scp baza/hosts root@$F:/etc/hosts
$FSh "hostname server.com"
$FSh "mkdir /usr/local/domen/"
cat baza/80.name | sed -e "s/site/$site/Ig" > baza/$site
sshpass -p $pass scp baza/$site root@$F:/usr/local/domen/
$FSh "mkdir -p /usr/local/www/$site /var/log/httpd/"
$FSh "echo '<html><h1><center>Bu $site  saytidir</center></h1></html>' > /usr/local/www/$si    te/index.html"
$FSh "touch /var/log/httpd/"$site"_access.log /var/log/httpd/"$site"_error.log"
sleep 1
sed -e "s/dbnm/$dbnm/Ig" -e "s/dbusr/$dbusr/Ig" -e "s/wpass/$wpass/Ig" /root/baza/indext.php > /root/baza/index.php
sshpass -p $pass scp /root/baza/index.php root@$F:/usr/local/www/$site/
$FSh "/usr/local/etc/rc.d/apache24 start"
sleep 5
$FSh "/usr/local/etc/rc.d/mysql-server start"
sleep 5
$FSh "echo -e '\n\n$wpass\n$wpass\n\n\n\n\n' | mysql_secure_installation" 2>/dev/null
sed -e "s/dbnm/$dbnm/Ig" -e "s/dbusr/$dbusr/Ig" -e "s/wpass/$wpass/Ig" /root/baza/mysql > /root/baza/mysqldb
chmod +x /root/baza/mysqldb
sshpass -p $pass scp /root/baza/mysqldb root@$F:/root/
sleep 1
$FSh "./mysqldb"
sleep 1
$FSh "rm -rf mysqldb"
$FSh "/usr/local/etc/rc.d/apache24 restart ; /usr/local/etc/rc.d/mysql-server restart"
}
PS3='Yukleme hansi mashina olacaq onun ip unvanini secin: '
select word in "$C6" "$C7" "$F" "$U"
do
    if  [ $word = $F ] 
    then 
Fbsd () {
sshpass -p $pass ssh root@$F "pkg install -y apache24"
sshpass -p $pass ssh root@$F "pkg install -y mysql55-server-5.5.49" 
sshpass -p $pass ssh root@$F "pkg install -y php56-5.6.23 mod_php56-5.6.23 php56-extensions-1.0 php56-mysql-5.6.23"
sshpass -p $pass ssh root@$F "sysrc mysql_enable="YES" apache24_enable="YES""
cat baza/host | sed -e "s/ip/$F/Ig" > baza/hosts
sshpass -p $pass scp baza/hosts root@$F:/etc/hosts
sshpass -p $pass ssh root@$F "hostname server.com"
sshpass -p $pass ssh root@$F "mkdir /usr/local/domen/"
cat baza/80.name | sed -e "s/site/$site/Ig" > baza/$site
sshpass -p $pass scp baza/$site root@$F:/usr/local/domen/
sshpass -p $pass ssh root@$F "mkdir -p /usr/local/www/$site /var/log/httpd/"
sshpass -p $pass ssh root@$F "echo '<html><h1><center>Bu $site  saytidir</center></h1></html>' > /usr/local/www/$site/index.html"
sshpass -p $pass ssh root@$F "touch /var/log/httpd/"$site"_access.log /var/log/httpd/"$site"_error.log"
sleep 1 
sed -e "s/dbnm/$dbnm/Ig" -e "s/dbusr/$dbusr/Ig" -e "s/wpass/$wpass/Ig" /root/baza/indext.php > /root/baza/index.php
sshpass -p $pass scp /root/baza/index.php root@$F:/usr/local/www/$site/
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/apache24 start"
sleep 5
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/mysql-server start"
sleep 5
sshpass -p $pass ssh root@$F "echo -e '\n\n$wpass\n$wpass\n\n\n\n\n' | mysql_secure_installation" 2>/dev/null
sed -e "s/dbnm/$dbnm/Ig" -e "s/dbusr/$dbusr/Ig" -e "s/wpass/$wpass/Ig" /root/baza/mysql > /root/baza/mysqldb
chmod +x /root/baza/mysqldb 
sshpass -p $pass scp /root/baza/mysqldb root@$F:/root/
sleep 1
sshpass -p $pass ssh root@$F "./mysqldb"
sleep 1
sshpass -p $pass ssh root@$F "rm -rf mysqldb"
sshpass -p $pass ssh root@$F "/usr/local/etc/rc.d/apache24 restart ; /usr/local/etc/rc.d/mysql-server restart"
}
Fbsd
 else
     exit
 fi
       done

