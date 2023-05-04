// 생성된 Floating IP 주소
output "floating_ip" {
  value = [openstack_compute_floatingip_v2.fip[*].address]
}
