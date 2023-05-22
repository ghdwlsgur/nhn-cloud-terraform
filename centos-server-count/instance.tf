

resource "openstack_compute_instance_v2" "vm" {
  count             = var.machine_count
  name              = var.machines["server-${count.index + 1}"]["name"]
  availability_zone = var.machines["server-${count.index + 1}"]["availability_zone"]
  flavor_name       = var.machines["server-${count.index + 1}"]["flavor_name"]
  key_pair          = var.machines["server-${count.index + 1}"]["key_pair"]

  user_data = var.machines["server-${count.index + 1}"]["role"] == "web-server" ? data.cloudinit_config.cloudinit-web.rendered : data.cloudinit_config.cloudinit-was.rendered


  block_device {
    uuid                  = data.openstack_images_image_v2.CentOS_7_9.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    boot_index            = 0
    volume_size           = 20
    volume_type           = "General SSD" // 블록 스토리지 타입
  }

  // 추가 블록 스토리지 
  # block_device {
  #   source_type           = "blank"
  #   destination_type      = "volume"
  #   boot_index            = 1
  #   volume_size           = 500
  #   volume_type           = "General HDD"
  #   delete_on_termination = true
  # }

  security_groups = [
    openstack_networking_secgroup_v2.security_group.name,
  ]

  network {
    port = openstack_networking_port_v2.nic[count.index].id
  }
}
