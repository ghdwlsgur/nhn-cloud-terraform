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
  name = "grafana-instance-sg"
}


// 개인 이미지 
data "openstack_images_image_v2" "grafana" {
  name        = "grafana.speedycdn.net" // 이미지 이름    
  owner       = var.provider_openstack.tenant_id
  most_recent = true
}


