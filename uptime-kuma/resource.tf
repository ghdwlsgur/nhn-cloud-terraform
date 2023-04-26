resource "openstack_networking_port_v2" "nic" {
  network_id = data.openstack_networking_network_v2.vpc.id
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }
  security_group_ids = [
    data.openstack_networking_secgroup_v2.sg.id
  ]
}


resource "openstack_compute_instance_v2" "vm" {
  name              = var.machines.name
  availability_zone = var.machines.availability_zone
  flavor_name       = var.machines.flavor_name
  key_pair          = var.machines.key_pair
  # user_data         = data.template_file.user_data.rendered
  user_data = <<EOF
		#! /bin/bash
    set -e -x
    sudo yum update -y
    sudo yum install -y yum-utils git
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum-config-manager --enable docker-ce-nightly
    sudo yum -y install docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    git clone https://github.com/ghdwlsgur/uptime-kuma.git && cd uptime-kuma
    sudo docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1
	EOF

  # connection {
  #   type        = "ssh"
  #   user        = "centos"
  #   host        = openstack_compute_floatingip_v2.fip_01.address
  #   private_key = file("~/Documents/Speedy/KeyPair/centos-keypair.pem")
  #   timeout     = "2m"
  # }

  # provisioner "remote-exec" {
  #   script = "${path.module}/scripts/payload.sh"
  # }

  block_device {
    uuid                  = data.openstack_images_image_v2.img_debian10.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "General HDD"
  }

  network {
    port = openstack_networking_port_v2.nic.id
  }
}



