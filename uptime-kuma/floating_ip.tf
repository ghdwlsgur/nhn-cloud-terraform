
// Floating IP 생성 (퍼블릭 IP)
resource "openstack_compute_floatingip_v2" "fip_01" {
  pool = "Public Network" // 인터넷 게이트웨이 외부 네트워크 이름
}

resource "openstack_compute_floatingip_associate_v2" "fip_associate" {
  floating_ip = openstack_compute_floatingip_v2.fip_01.address // 생성된 Floating IP
  instance_id = openstack_compute_instance_v2.vm.id            // 가상머신 ID
}


