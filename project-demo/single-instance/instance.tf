

resource "openstack_compute_instance_v2" "vm" {
  name              = var.machines.name
  availability_zone = var.machines.availability_zone
  flavor_name       = var.machines.flavor_name
  key_pair          = var.machines.key_pair

  block_device {
    uuid                  = data.openstack_images_image_v2.windows.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    boot_index            = 0
    volume_size           = 100
    volume_type           = "General SSD"
  }

  block_device {
    source_type           = "blank"
    destination_type      = "volume"
    boot_index            = 1
    volume_size           = 100
    volume_type           = "General HDD"
    delete_on_termination = true
  }

  security_groups = [
    openstack_networking_secgroup_v2.security_group.name,
  ]

  network {
    port = openstack_networking_port_v2.nic.id
  }
}
