resource "openstack_compute_floatingip_v2" "fip" {
  for_each = var.machines
  pool     = "Public Network"
}

resource "openstack_compute_floatingip_associate_v2" "fip_associate" {
  for_each    = var.machines
  floating_ip = openstack_compute_floatingip_v2.fip[each.key].address
  instance_id = openstack_compute_instance_v2.vm[each.key].id
}


