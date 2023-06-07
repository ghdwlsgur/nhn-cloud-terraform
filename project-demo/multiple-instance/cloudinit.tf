data "template_file" "cloudinit-web" {
  template = file("${path.module}/web-server/init.tpl")

  vars = {
    nfs_connect_info = var.nfs_connect_info
  }
}


