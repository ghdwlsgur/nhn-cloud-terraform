resource "openstack_networking_port_v2" "nic" {
  for_each   = var.machines
  network_id = data.openstack_networking_network_v2.vpc.id

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = each.value["nic_ip"]
  }

  security_group_ids = [
    each.value["role"] == "web-server" ? var.security_groups.web_id : (each.value["role"] == "waf-server" ? var.security_groups.waf_id : var.security_groups.was_id)
  ]
}
