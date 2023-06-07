
resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "DEMO-SG"
  description = "RDP 원격 접속"
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3389
  port_range_max    = 3389
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}


data "http" "myip" {
  url    = "http://ipv4.icanhazip.com"
  method = "GET"
}
