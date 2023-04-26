#!/usr/bin/env bash 

set -e -o pipefail

# description =============================================================
# 첫 번째 인수로 key_pair 위치 지정 ex) ~/.ssh/sandbox/centos-keypair.pem
# 두 번째 인수로 os 유저명 전달 ex) centos, rocky, ...
# 사용자 스크립트로 사용할 폴더 위치 및 파일명은 ./scripts/payload.sh 로 고정
# =========================================================================
# terraform apply --auto-approve -lock=false
# bash scripts/apply.sh ~/.ssh/sandbox/centos-keypair.pem centos 

key_pair=$(echo "$1")
username=$(echo "$2")
public_ip=$(terraform output floating_ip | tr -d '"')


# 생성된 가상머신으로 사용자 스크립트 전송
send_user_script() {
  # rsync -avz -delete -partial -e "ssh -o StrictHostKeyChecking=no -i ~/.ssh/sandbox/centos-keypair.pem" ./scripts/payload.sh centos@125.6.36.55:~/payload.sh
  rsync -avz -delete -partial -e "ssh -o StrictHostKeyChecking=no -i $key_pair" ./scripts/payload.sh $username@$public_ip:~/payload.sh
}

# 가상머신에 SSH로 접속하여 전송받은 사용자 스크립트 실행 
execute_user_script() {
  # ssh -o StrictHostKeyChecking=no -i ~/.ssh/sandbox/centos-keypair.pem centos@125.6.36.55 bash payload.sh
  ssh -o StrictHostKeyChecking=no -i $key_pair $username@$public_ip bash payload.sh
}

execute() {
if [ -f "$key_pair" ]; then    
    # 키페어가 존재할 경우 
    send_user_script && execute_user_script
else 
    # 키페어가 존재하지 않을 경우
    echo "$key_pair does not exist."
    exit 
fi
}

execute
# main() {  
#   # 테라폼 프로비저닝 후 약간의 딜레이 필요 (약 20초간 딜레이 부여)
#   terraform apply --auto-approve -lock=false && execute
# }
# main

# sudo vi /etc/ssh/ssh_config > StrictHostKeyChecking no