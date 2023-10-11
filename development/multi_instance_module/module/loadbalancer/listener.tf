resource "openstack_lb_listener_v2" "listener_http" {
  name                   = var.lb_listener.http.name
  description            = var.lb_listener.http.description
  protocol               = var.lb_listener.http.protocol
  protocol_port          = var.lb_listener.http.protocol_port
  loadbalancer_id        = openstack_lb_loadbalancer_v2.loadbalancer.id
  default_pool_id        = ""
  connection_limit       = var.lb_listener.http.connection_limit
  timeout_client_data    = var.lb_listener.http.timeout_client_data
  timeout_member_connect = var.lb_listener.http.timeout_member_connect
  timeout_member_data    = var.lb_listener.http.timeout_member_data
  admin_state_up         = true
}
