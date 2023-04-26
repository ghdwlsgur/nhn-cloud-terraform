data "openstack_networking_network_v2" "vpc" {
  name = "Default Network"
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "Private_Network"
}

data "openstack_networking_secgroup_v2" "sg" {
  name = "Private_SG"
}

data "openstack_images_image_v2" "centos" {
  name        = "CentOS 7.9 (2022.11.22)"
  most_recent = true
}
