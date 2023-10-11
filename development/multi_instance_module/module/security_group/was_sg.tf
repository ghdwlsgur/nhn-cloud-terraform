
resource "openstack_networking_secgroup_v2" "was_security_group" {
  name        = "was-sg"
  description = "Security group for WAS"
}

resource "openstack_networking_secgroup_rule_v2" "was_security_group_rules" {
  for_each = { for key, rule in var.was_security_group_rules : key => rule }

  description       = each.value.description
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  remote_ip_prefix  = each.value.remote_ip_prefix
  security_group_id = openstack_networking_secgroup_v2.was_security_group.id
}
