#!/bin/bash

echo "#### userA website
<VirtualHost localhost:80>
ServerName  emanayafatmaamal.com
ServerAlias www.emanayafatmaamal.com
DocumentRoot /home/ahmed/public_html/
<Directory /home/ahmed/public_html/>
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>
</VirtualHost>" >  /etc/apache2/sites-enabled/000-default.conf

