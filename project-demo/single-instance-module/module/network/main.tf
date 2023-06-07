data "openstack_networking_network_v2" "vpc" {
  name = var.vpc_name
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = var.subnet_name
}

