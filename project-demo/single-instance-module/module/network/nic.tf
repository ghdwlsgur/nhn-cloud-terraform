resource "openstack_networking_port_v2" "nic" {
  network_id = data.openstack_networking_network_v2.vpc.id


  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = var.nic_ipv4
  }


  security_group_ids = [
    var.sg_id
  ]
}

