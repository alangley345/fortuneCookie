#!/bin/bash

#checking for updates
sudo yum check-update
sudo yum -y update

#installing nginx and git and enabled it on reboot
sudo yum install -y git
sudo amazon-linux-extras nginx1.12


#install git and clone my site repo
sudo mkdir /var/www/
sudo mkdir /fortunecookie
sudo git clone https://github.com/alangley345/fortuneCookie.git /fortuneCookie
sudo mv /fortuneCookie/website /var/www/

#start nginx
service start nginx