data "openstack_networking_network_v2" "vpc" {
  name = var.network.vpc.name
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = var.network.subnet.name
}
