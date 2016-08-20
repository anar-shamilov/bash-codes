<VirtualHost *:80>
    ServerAdmin anar.slov@gmail.com
    ServerName jamal.com
    ServerAlias www.jamal.com
    AcceptPathInfo On
    DocumentRoot /usr/local/www/jamal.com/
    CustomLog /var/log/httpd/jamal.com_access.log common
    ErrorLog /var/log/httpd/jamal.com_error.log
    <Directory /usr/local/www/jamal.com>
    Options +Indexes
    AllowOverride All
    Require all granted
</Directory>
</VirtualHost>
