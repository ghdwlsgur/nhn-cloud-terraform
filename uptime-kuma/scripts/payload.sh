#!/usr/bin/env bash 

set -e -x

# set up docker 
sudo yum update -y
sudo yum install -y yum-utils git

# docker repository 시스템에 추가
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-nightly

# 최신 버전의 docker 설치 (install docker engine)
sudo yum -y install docker-ce docker-ce-cli containerd.io

# Docker 데몬 시작 및 부팅 시 Docker 데몬 자동 시작
sudo systemctl start docker
sudo systemctl enable docker

# clone from git repository (uptime-kuma)
git clone https://github.com/ghdwlsgur/uptime-kuma.git && cd uptime-kuma

# docker 실행
sudo docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1