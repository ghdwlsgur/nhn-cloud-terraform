resource "openstack_networking_port_v2" "nic" {
  count      = var.machine_count
  network_id = data.openstack_networking_network_v2.vpc.id

  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }

  security_group_ids = [
    data.openstack_networking_secgroup_v2.sg.id
  ]
}

resource "openstack_compute_instance_v2" "vm" {
  count             = var.machine_count
  name              = var.machines["node${count.index + 1}"]["name"]
  availability_zone = var.machines["node${count.index + 1}"]["availability_zone"]
  flavor_name       = var.machines["node${count.index + 1}"]["flavor_name"]
  key_pair          = var.machines["node${count.index + 1}"]["key_pair"]



  block_device {
    uuid                  = data.openstack_images_image_v2.attacker.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "General SSD"
  }

  network {
    port = openstack_networking_port_v2.nic[count.index].id
  }
}

