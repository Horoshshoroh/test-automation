#!/bin/bash

sudo wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo apt update

sudo apt install zabbix-server-mysql -y
sudo apt install zabbix-frontend-php -y
sudo apt install zabbix-apache-conf -y
sudo apt install zabbix-sql-scripts -y
sudo apt install zabbix-agent -y
sudo apt install git curl php-curl mc htop -y

sudo mysql -uroot -e "create database zabbix character set utf8 collate utf8_bin;"
sudo mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'My_Password_For_SQL_zabbix';"
sudo mysql -uroot -e "FLUSH PRIVILEGES;"
sudo mysql -uroot -e "quit"

sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/create.sql.gz | sudo mysql -uzabbix zabbix -pMy_Password_For_SQL_zabbix

sudo sed -i "s/# DBPassword=/DBPassword=My_Password_For_SQL_zabbix/" /etc/zabbix/zabbix_server.conf
sudo sed -i "s/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/"/etc/locale.gen

sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent

exit
