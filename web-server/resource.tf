resource "openstack_networking_port_v2" "nic" {
  network_id = data.openstack_networking_network_v2.vpc.id
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }
  security_group_ids = [
    data.openstack_networking_secgroup_v2.sg.id
  ]
}


resource "openstack_compute_instance_v2" "vm" {

  name              = var.machines.name
  availability_zone = var.machines.availability_zone
  flavor_name       = var.machines.flavor_name
  key_pair          = var.machines.key_pair

  block_device {
    uuid                  = data.openstack_images_image_v2.img_debian10.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "General HDD"
  }

  network {
    port = openstack_networking_port_v2.nic.id
  }
}
