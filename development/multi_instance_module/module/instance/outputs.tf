output "floating_ip" {
  value       = { for k, v in openstack_compute_floatingip_v2.fip : k => v.address }
  description = "The floating IPs for each machine."
}

output "access_ipv4" {
  value = {
    waf_server   = openstack_compute_instance_v2.vm["waf-server"].access_ip_v4
    web_server_1 = openstack_compute_instance_v2.vm["web-server-1"].access_ip_v4
    web_server_2 = openstack_compute_instance_v2.vm["web-server-2"].access_ip_v4
    was_server_1 = openstack_compute_instance_v2.vm["was-server-1"].access_ip_v4
    was_server_2 = openstack_compute_instance_v2.vm["was-server-2"].access_ip_v4
  }
}

