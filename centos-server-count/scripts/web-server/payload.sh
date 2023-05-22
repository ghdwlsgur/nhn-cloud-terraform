#!/bin/bash

sudo su -
yum update -y

yum install chrony -y 
echo "server kr.pool.ntp.org" >> /etc/chrony.conf
echo "server time.bora.net" >> /etc/chrony.conf

systemctl restart chronyd
systemctl enable chronyd

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sed -i 's/^TMOUT=900$/TMOUT=7200/' /etc/profile

useradd witgames
echo 'witgames:1234' | sudo chpasswd
usermod -aG wheel witgames
echo "witgames     ALL=(ALL)          NOPASSWD:ALL" >> /etc/sudoers

echo "this is web-server" > /home/witgames/hello.txt
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^\#Port 22/Port 2222/' /etc/ssh/sshd_config

sudo -u witgames userdel -r centos
sudo -u witgames pkill -u centos


systemctl restart sshd

