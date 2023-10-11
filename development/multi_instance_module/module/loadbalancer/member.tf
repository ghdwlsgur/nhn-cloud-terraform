resource "openstack_lb_member_v2" "lb_instance_http" {
  pool_id        = openstack_lb_pool_v2.lb_pool_http.id
  subnet_id      = var.subnet_id
  address        = var.access_ipv4["waf_server"] // 로드밸런서에서 트래픽을 수신할 인스턴스의 IP 주소
  protocol_port  = var.lb_member.http.protocol_port
  weight         = var.lb_member.http.weight
  admin_state_up = true
}


