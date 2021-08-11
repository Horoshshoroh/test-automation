#!/bin/bash

# This script installs the Zabbix Agent for Ubuntu 20.04
# Don't forget to change Zabbix-server IP or DNSname and Hostname for Agent

sudo wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo apt update

sudo apt install git mc htop -y
sudo apt install zabbix-agent -y

sudo sed -i "s/Server=127.0.0.1/Server=Zabbix-server_IP_or_DNSname/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=Zabbix-server_IP_or_DNSname/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/Hostname=Zabbix server/Hostname=Some_Name_for_Agent/" /etc/zabbix/zabbix_agentd.conf

sudo apt install nginx -y

sudo systemctl restart zabbix-agent nginx
sudo systemctl enable zabbix-agent nginx

exit