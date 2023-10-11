resource "openstack_compute_instance_v2" "vm" {
  for_each          = var.machines
  name              = each.value["name"]
  availability_zone = each.value["availability_zone"]
  flavor_name       = each.value["flavor_name"]
  key_pair          = var.key_pair

  user_data = each.value["role"] == "web-server" ? data.template_file.cloudinit-web.rendered : each.value["role"] == "waf-server" ? data.template_file.cloudinit-waf.rendered : data.template_file.cloudinit-was.rendered

  block_device {
    uuid                  = each.value["role"] == "waf-server" ? data.openstack_images_image_v2.waf.id : (each.value["role"] == "web-server" ? data.openstack_images_image_v2.web.id : data.openstack_images_image_v2.was.id)
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = var.block_storage.delete_on_termination
    boot_index            = 0
    volume_size           = var.block_storage.volume_size
    volume_type           = var.block_storage.volume_type
  }

  security_groups = [
    each.value["role"] == "web-server" ? var.security_groups.web_name : (each.value["role"] == "waf-server" ? var.security_groups.waf_name : var.security_groups.was_name)
  ]

  network {
    port = var.nic_port_ids[each.key]
  }
}

resource "openstack_compute_floatingip_v2" "fip" {
  for_each = var.machines
  pool     = "Public Network"
}

resource "openstack_compute_floatingip_associate_v2" "fip_associate" {
  for_each    = var.machines
  floating_ip = openstack_compute_floatingip_v2.fip[each.key].address
  instance_id = openstack_compute_instance_v2.vm[each.key].id
}
