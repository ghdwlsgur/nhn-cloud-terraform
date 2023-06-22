
resource "openstack_compute_instance_v2" "vm" {
  name              = var.name
  availability_zone = var.availability_zone
  flavor_name       = var.flavor_name
  key_pair          = var.key_pair

  block_device {
    uuid                  = data.openstack_images_image_v2.os_image.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    boot_index            = 0
    volume_size           = 50
    volume_type           = "General SSD"
  }

  block_device {
    source_type           = "blank"
    destination_type      = "volume"
    boot_index            = 1
    volume_size           = 50
    volume_type           = "General HDD"
    delete_on_termination = true
  }

  security_groups = [
    var.sg_name,
  ]

  network {
    port = var.nic_id
  }
}

resource "openstack_compute_floatingip_v2" "fip_01" {
  pool = "Public Network"
}

resource "openstack_compute_floatingip_associate_v2" "fip_associate" {
  floating_ip = openstack_compute_floatingip_v2.fip_01.address
  instance_id = openstack_compute_instance_v2.vm.id
}
