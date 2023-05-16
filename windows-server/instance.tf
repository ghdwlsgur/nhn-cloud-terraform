

resource "openstack_compute_instance_v2" "vm" {
  name              = var.machines.name
  availability_zone = var.machines.availability_zone
  flavor_name       = var.machines.flavor_name
  key_pair          = var.machines.key_pair

  block_device {
    uuid                  = data.openstack_images_image_v2.windows_2012_en.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = false
    boot_index            = 0
    volume_size           = 100           // 윈도우 이미지 최소 블록 스토리지 50GB
    volume_type           = "General SSD" // 블록 스토리지 타입
  }


  // 추가 블록 스토리지 
  block_device {
    source_type           = "blank"
    destination_type      = "volume"
    boot_index            = 1
    volume_size           = 500
    volume_type           = "General HDD"
    delete_on_termination = false
  }

  security_groups = [
    openstack_networking_secgroup_v2.security_group.name,
  ]

  network {
    port = openstack_networking_port_v2.nic.id
  }
}
