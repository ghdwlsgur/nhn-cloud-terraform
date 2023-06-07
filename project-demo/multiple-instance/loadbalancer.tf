resource "openstack_compute_floatingip_v2" "lb_fip" {
  pool = "Public Network"
}

resource "openstack_lb_loadbalancer_v2" "loadbalancer" {
  name           = "DemoLoadBalancer"
  description    = "created by terraform."
  vip_subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  vip_address    = "192.168.0.10"
  admin_state_up = true
}

