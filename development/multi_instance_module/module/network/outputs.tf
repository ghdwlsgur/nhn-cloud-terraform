output "nic_port_ids" {
  value = { for k, v in openstack_networking_port_v2.nic : k => v.id }
}

output "subnet_id" {
  value = data.openstack_networking_subnet_v2.subnet.id
}
