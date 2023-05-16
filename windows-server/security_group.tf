

resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "GAME-01-SG"
  description = "SSH, RDP 원격 접속"
}

// 내 IP 22번 포트 허용
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32" // 끝에 개행문자가 포함될 경우 제거
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

// 내 IP 3389번 포트 허용
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3389
  port_range_max    = 3389
  remote_ip_prefix  = "${chomp(data.http.myip.response_body)}/32" // 끝에 개행문자가 포함될 경우 제거
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}


data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
