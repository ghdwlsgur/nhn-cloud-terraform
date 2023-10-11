resource "openstack_lb_pool_v2" "lb_pool_http" {
  name        = var.lb_pool.http.name
  description = var.lb_pool.http.description
  protocol    = var.lb_pool.http.protocol
  listener_id = openstack_lb_listener_v2.listener_http.id
  lb_method   = var.lb_pool.http.lb_method

  persistence {
    type = var.lb_pool.http.type
  }

  admin_state_up = true
}
