
data "openstack_networking_network_v2" "vpc" {
  name = var.network.vpc_name
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = var.network.subnet_name
}


resource "openstack_networking_port_v2" "nic" {
  network_id = data.openstack_networking_network_v2.vpc.id


  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = var.machines.nic_ipv4
  }


  security_group_ids = [
    openstack_networking_secgroup_v2.security_group.id
  ]
}

