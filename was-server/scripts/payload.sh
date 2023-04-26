#!/usr/bin/env bash 

set -e -o pipefail

sudo yum update -y
sudo yum install -y yum-utils git

git clone https://github.com/ghdwlsgur/nginx-upstream.git

# ps -ef | grep node

# node v16 설치
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum clean all && sudo yum makecache fast
sudo yum install -y gcc-c++ make
sudo yum install -y nodejs

# yarn 설치
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install -y yarn


# nohup node server.js > app.log &
nohup yarn start > ~/app.log &