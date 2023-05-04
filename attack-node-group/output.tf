// 생성된 Floating IP 주소
output "floating_ip-1" {
  value = openstack_compute_floatingip_v2.fip[0].address
}

output "floating_ip-2" {
  value = openstack_compute_floatingip_v2.fip[1].address
}

output "floating_ip-3" {
  value = openstack_compute_floatingip_v2.fip[2].address
}
