// 기본 VPC
data "openstack_networking_network_v2" "vpc" {
  name = "Default Network"
}

// 기본 서브넷 
data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "Default Network"
}

// 보안 그룹
data "openstack_networking_secgroup_v2" "sg" {
  name = "attack-instance-sg"
}


// 개인 이미지 
data "openstack_images_image_v2" "attacker" {
  name        = "attacker" // 이미지 이름    
  owner       = data.aws_ssm_parameter.tenant_id.value
  most_recent = true
}


