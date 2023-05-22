

resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "centos-sg"
  description = "Allow ssh, http, https rules Created By Terraform"
}

// 내 IP 22번 포트 허용
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2222
  port_range_max    = 2222
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32" // 끝에 개행문자가 포함될 경우 제거
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

// HTTP 
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

// HTTPS 
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}



data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
