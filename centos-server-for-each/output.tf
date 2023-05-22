// 생성된 Floating IP 주소
output "floating_ip" {
  value       = { for k, v in openstack_compute_floatingip_v2.fip : k => v.address }
  description = "The floating IPs for each machine."
}

