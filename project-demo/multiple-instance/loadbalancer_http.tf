resource "openstack_lb_listener_v2" "listener_http" {
  name        = "LB_Listen_HTTP"
  description = "CONNECT HTTP"

  protocol               = "HTTP"
  protocol_port          = 80
  loadbalancer_id        = openstack_lb_loadbalancer_v2.loadbalancer.id
  default_pool_id        = ""
  connection_limit       = 60000
  timeout_client_data    = 5400
  timeout_member_connect = 5000
  timeout_member_data    = 5000
  timeout_tcp_inspect    = 5000
  admin_state_up         = true
}

resource "openstack_lb_pool_v2" "lb_pool_http" {
  name        = "LB_HTTP_Pool"
  description = "craete pool by terraform."

  protocol    = "HTTP"
  listener_id = openstack_lb_listener_v2.listener_http.id

  lb_method = "ROUND_ROBIN"

  // 세션 지속성 없음 -> 데모: 콘솔에서 세션 지속성 없음으로 변경 후 
  // 아래 주석 처리 후 terraform refresh
  # persistence {
  #   type = "SOURCE_IP"
  # }

  admin_state_up = true
}

resource "openstack_lb_monitor_v2" "lb_monitor_http" {
  name    = "LB_HTTP_Monitor"
  pool_id = openstack_lb_pool_v2.lb_pool_http.id

  type        = "TCP"
  delay       = 30
  timeout     = 5
  max_retries = 2
  url_path    = "/"
  http_method = "GET"

  expected_codes = "200"
  admin_state_up = true
}

resource "openstack_lb_member_v2" "lb_instance_http" {
  for_each  = openstack_compute_instance_v2.vm
  pool_id   = openstack_lb_pool_v2.lb_pool_http.id
  subnet_id = data.openstack_networking_subnet_v2.subnet.id

  address        = each.value.access_ip_v4
  protocol_port  = 80
  weight         = 4
  admin_state_up = true
}
