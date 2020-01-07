#!/bin/bash

#checking for updates
sudo yum check-update
sudo yum -y update

#installing nginx and enabled it on reboot
sudo yum install -y nginx
sudo chkconfig nginx on

#install git and clone my site repo
sudo yum install -y git
sudo mkdir /var/www/
sudo git clone https://github.com/alangley345/fortuneCookie/ /fortuneCookie
sudo mv /fortuneCookie/website /var/www/

#delete default config 
sudo rm /etc/nginx/conf.d/default.conf
sudo mv /fortuneCookie/default.conf /etc/conf.d

#start nginx
sudo systemctl start nginix