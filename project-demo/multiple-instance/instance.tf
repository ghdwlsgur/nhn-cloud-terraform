
resource "openstack_compute_instance_v2" "vm" {
  for_each          = var.machines
  name              = each.value["name"]
  availability_zone = each.value["availability_zone"]
  flavor_name       = each.value["flavor_name"]
  key_pair          = each.value["key_pair"]

  user_data = data.template_file.cloudinit-web.rendered

  block_device {
    uuid                  = data.openstack_images_image_v2.CentOS_7_9.id
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
    delete_on_termination = true
    boot_index            = 1
    volume_size           = 100
    volume_type           = "General HDD"
  }

  security_groups = [
    openstack_networking_secgroup_v2.web_security_group.name
  ]

  network {
    port = openstack_networking_port_v2.nic[each.key].id
  }


}
