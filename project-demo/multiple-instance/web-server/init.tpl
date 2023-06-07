#!/bin/bash

sudo su -
yum update -y

#=========================================== Time
yum install chrony nginx -y 
echo "server kr.pool.ntp.org" >> /etc/chrony.conf
echo "server time.bora.net" >> /etc/chrony.conf

systemctl restart chronyd
systemctl enable chronyd

systemctl restart nginx
systemctl enable nginx 

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sed -i 's/^TMOUT=900$/TMOUT=7200/' /etc/profile

echo "이 홈페이지 아이피는 $(curl 169.254.169.254/latest/meta-data/public-ipv4) 입니다." > /usr/share/nginx/html/index.html
#=========================================== Create Account
useradd demo 
echo 'demo:demo#@1!' | sudo chpasswd
usermod -aG wheel demo
echo "demo     ALL=(ALL)          NOPASSWD:ALL" >> /etc/sudoers
echo "create demo user complete!" > /home/demo/hello.txt

#=========================================== Port 
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^\#Port 22/Port 8022/' /etc/ssh/sshd_config
echo "port setup 8022" >> /home/demo/hello.txt

#=========================================== delete Root Account
sudo userdel -f centos
systemctl restart sshd

#=========================================== mount 
mkdir /nas
echo "${nfs_connect_info} /nas nfs defaults,nodev,noatime,nofail 1 2" >> /etc/fstab
mount -a 
echo "/nas mount complete!" >> /home/demo/hello.txt