// 키페어 이름
output "key_pair" {
  value = openstack_compute_instance_v2.vm.key_pair
}
