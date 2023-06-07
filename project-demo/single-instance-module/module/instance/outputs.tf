output "floating_ip" {
  value = openstack_compute_floatingip_v2.fip_01.address
}
