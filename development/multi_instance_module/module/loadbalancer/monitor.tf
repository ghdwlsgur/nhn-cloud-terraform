resource "openstack_lb_monitor_v2" "lb_monitor_http" {
  name           = var.lb_monitor.http.name
  pool_id        = openstack_lb_pool_v2.lb_pool_http.id
  type           = var.lb_monitor.http.type
  delay          = var.lb_monitor.http.delay
  timeout        = var.lb_monitor.http.timeout
  max_retries    = var.lb_monitor.http.max_retries
  url_path       = var.lb_monitor.http.url_path
  http_method    = var.lb_monitor.http.http_method
  expected_codes = var.lb_monitor.http.expected_codes
  admin_state_up = true
}
