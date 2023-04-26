// 기본 VPC
data "openstack_networking_network_v2" "vpc" {
  name = "Default Network" // VPC명
}

// 기본 서브넷
data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "Default Network" // 서브넷명
}

// 기본 보안그룹
data "openstack_networking_secgroup_v2" "sg" {
  name = "default" // 보안그룹명
}

// CentOS 이미지
data "openstack_images_image_v2" "img_debian10" {
  name        = "CentOS 7.9 (2022.11.22)" // 이미지명
  most_recent = true
}
