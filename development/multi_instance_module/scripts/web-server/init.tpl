#!/bin/bash

sudo su -
yum update -y

#=========================================== Time
yum install chrony -y 
echo "server kr.pool.ntp.org" >> /etc/chrony.conf
echo "server time.bora.net" >> /etc/chrony.conf

systemctl restart chronyd
systemctl enable chronyd

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sed -i 's/^TMOUT=900$/TMOUT=7200/' /etc/profile

#=========================================== Create Account
useradd test
echo 'test:test1234' | sudo chpasswd
usermod -aG wheel test
echo "test     ALL=(ALL)          NOPASSWD:ALL" >> /etc/sudoers
echo "create test user complete!" > /home/test/hello.txt

#=========================================== Port 
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^\#Port 22/Port 8022/' /etc/ssh/sshd_config
echo "port setup 8022" >> /home/test/hello.txt

#=========================================== delete Root Account
sudo userdel -f centos
systemctl restart sshd

#=========================================== mount 
mkdir /nas
echo "${nfs_connect_info} /nas nfs defaults,nodev,noatime,nofail 1 2" >> /etc/fstab
mount -a 
echo "/nas mount complete!" >> /home/test/hello.txt