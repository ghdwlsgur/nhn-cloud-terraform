NHN-Cloud Resources 지원

VPC 생성 (콘솔) -> 서브넷 생성 (콘솔) -> 보안그룹 생성 (콘솔) -> 인터넷 게이트웨이 생성 -> 라우팅 테이블 연결

### Compute

- openstack_compute_instance_v2
- openstack_compute_volume_attach_v2

### Network

- openstack_lb_loadbalancer_v2
- openstack_lb_listener_v2
- openstack_lb_pool_v2
- openstack_lb_member_v2
- openstack_lb_monitor_v2
- openstack_compute_floatingip_v2
- openstack_compute_floatingip_associate_v2
- openstack_networking_port_v2

### Storage

- openstack_blockstorage_volume_v2

### Data sources 지원

- openstack_images_image_v2
- openstack_blockstorage_volume_v2
- openstack_compute_flavor_v2
- openstack_blockstorage_snapshot_v2
- openstack_networking_network_v2
- openstack_networking_subnet_v2

https://docs.nhncloud.com/ko/Compute/Instance/ko/terraform-guide/
