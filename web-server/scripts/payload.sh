#!/usr/bin/env bash 

set -e -o pipefail

sudo yum update -y

sudo -i
cat > "/etc/yum.repos.d/nginx.repo" <<-EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx
systemctl enable nginx
systemctl start nginx