// 기본 VPC
data "openstack_networking_network_v2" "vpc" {
  name = "K8s_VPC" // VPC명
}

// 기본 서브넷
data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "K8s_Node_Subnet" // 서브넷명
}

// 기본 보안그룹
data "openstack_networking_secgroup_v2" "sg" {
  name = "worker_node_sg" // 보안그룹명
}

// CentOS 이미지
// 22.04.1 LTS (Jammy Jellyfish)로 업그레이드
data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu Server 20.04.5 LTS (2022.11.22)" // 이미지 설명
  most_recent = true
}

// 개인 이미지 
# data "openstack_images_image_v2" "ubuntu" {
#   name        = "k8s-worker-node1" // 이미지 이름    
#   owner       = var.provider_openstack.tenant_id
#   most_recent = true
# }
