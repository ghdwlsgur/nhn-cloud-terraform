#!/bin/bash

sudo su -
yum update -y

# #=========================================== Time
yum install chrony -y 
echo "server kr.pool.ntp.org" >> /etc/chrony.conf
echo "server time.bora.net" >> /etc/chrony.conf

systemctl restart chronyd
systemctl enable chronyd

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sed -i 's/^TMOUT=900$/TMOUT=7200/' /etc/profile

# #=========================================== Create Account
useradd test
echo 'test:test1234' | sudo chpasswd
usermod -aG wheel test
echo "test     ALL=(ALL)          NOPASSWD:ALL" >> /etc/sudoers
echo "this is test-server" > /home/test/hello.txt

# #=========================================== Port 
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^\#Port 22/Port 8022/' /etc/ssh/sshd_config

# #=========================================== delete Root Account
systemctl restart sshd

