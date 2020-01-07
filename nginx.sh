#!/bin/bash
sudo yum check-update
sudo yum -y update
sudo yum install -y nginx
sudo chkconfig nginix on
sudo systemctl start nginx