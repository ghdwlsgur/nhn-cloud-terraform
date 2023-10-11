resource "openstack_compute_floatingip_v2" "lb_fip" {
  pool = "Public Network"
}

resource "openstack_lb_loadbalancer_v2" "loadbalancer" {
  name           = "LoadBalancer"
  description    = "created by terraform."
  vip_subnet_id  = var.subnet_id
  vip_address    = var.lb_local_ipv4
  admin_state_up = true
}
