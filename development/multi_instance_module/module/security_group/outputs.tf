output "security_groups" {
  value = {
    web_name = openstack_networking_secgroup_v2.web_security_group.name
    was_name = openstack_networking_secgroup_v2.was_security_group.name
    waf_name = openstack_networking_secgroup_v2.waf_security_group.name
    web_id   = openstack_networking_secgroup_v2.web_security_group.id
    was_id   = openstack_networking_secgroup_v2.was_security_group.id
    waf_id   = openstack_networking_secgroup_v2.waf_security_group.id
  }
}
