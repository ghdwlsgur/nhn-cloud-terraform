
resource "openstack_compute_floatingip_v2" "fip_01" {
  pool = "Public Network"
}

resource "openstack_compute_floatingip_associate_v2" "fip_associate" {
  floating_ip = openstack_compute_floatingip_v2.fip_01.address
  instance_id = openstack_compute_instance_v2.vm.id
}


