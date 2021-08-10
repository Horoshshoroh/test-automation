#!/bin/bash

sudo apt update; 
sudo DEBIAN_FRONTEND=noninteractive apt -y full-upgrade

sudo DEBIAN_FRONTEND=noninteractive apt -y install apache2 mysql-server php libapache2-mod-php php-mysql

sudo ufw allow in "Apache Full"
sudo chown -Rv www-data:www-data /var/www/
sudo chmod 2775 /var/www/
sudo a2enmod rewrite
sudo sed -i "s/AllowOverride None/AllowOverride All/" /etc/apache2/apache2.conf 
sudo systemctl restart apache2

sudo echo "<?php phpinfo();" > /var/www/html/info.php

exit
