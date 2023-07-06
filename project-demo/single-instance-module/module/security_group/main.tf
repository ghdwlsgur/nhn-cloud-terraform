
resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "DEMO-SG"
  description = "SSH 원격 접속"
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rules" {
  for_each = { for key, rule in var.security_group_rules : key => rule }

  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  remote_ip_prefix  = each.value.remote_ip_prefix
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}
