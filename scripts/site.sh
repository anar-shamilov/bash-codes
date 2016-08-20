#!/usr/bin/env bash
sshpass -p freebsd ssh root@192.168.80.164 "echo '<VirtualHost *:80>' >> /root/tooo ; echo "ServerAdmin anar.slov@gmail.com" ; echo "ServerName elmar.az" >> /root/tooo"
     "ServerAlias www.elmar.az"
     AcceptPathInfo On
     "DocumentRoot /usr/local/www/elmar.az/"
     "CustomLog /var/log/httpd/elmar.az_access.log common"
     "ErrorLog /var/log/httpd/elmar.az_error.log"
     "<Directory /usr/local/www/elmar.az>"
     "Options +Indexes"
     AllowOverride All
    " Require all granted
'</Directory>'
'</VirtualHost>'"  >> /root/tooo"
