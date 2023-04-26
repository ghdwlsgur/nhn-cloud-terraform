// 생성된 Floating IP 주소
output "floating_ip" {
  value = openstack_compute_floatingip_v2.fip_01.address
}

// 키페어 이름
output "key_pair" {
  value = openstack_compute_instance_v2.vm.key_pair
}
