resource "openstack_networking_secgroup_v2" "web_security_group" {
  name        = "web-sg"
  description = "Security group for Web Server"
}

resource "openstack_networking_secgroup_rule_v2" "web_security_group_rule_1" {
  description       = "ALLOW 스피디 사무실"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8022
  port_range_max    = 8022
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32"
  security_group_id = openstack_networking_secgroup_v2.web_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "web_security_group_rule_2" {
  description       = "ALLOW 스피디 사무실"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32"
  security_group_id = openstack_networking_secgroup_v2.web_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "web_security_group_rule_3" {
  description       = "ALLOW 로드밸런서"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "${openstack_lb_loadbalancer_v2.loadbalancer.vip_address}/32"
  security_group_id = openstack_networking_secgroup_v2.web_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "web_security_group_rule_4" {
  description       = "ALLOW 스피디"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32"
  security_group_id = openstack_networking_secgroup_v2.web_security_group.id
}

data "http" "myip" {
  url    = "http://ipv4.icanhazip.com"
  method = "GET"
}
