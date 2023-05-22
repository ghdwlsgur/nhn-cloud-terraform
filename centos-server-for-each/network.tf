// 기본 VPC (192.168.0.0/16)
data "openstack_networking_network_v2" "vpc" {
  name = "Default Network"
}

// 기본 서브넷 (192.168.10.0/24)
data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "Default Network"
}



// 네트워크 인터페이스 카드
resource "openstack_networking_port_v2" "nic" {
  for_each   = var.machines
  network_id = data.openstack_networking_network_v2.vpc.id

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = each.value["nic_ip"]
  }

  // 보안그룹 부착
  security_group_ids = [
    openstack_networking_secgroup_v2.security_group.id
  ]
}


