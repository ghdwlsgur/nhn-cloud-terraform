data "template_file" "cloudinit-web" {
  template = file("scripts/web-server/init.tpl")

  vars = {
    nfs_connect_info = var.nfs_connect_info
  }
}

data "template_file" "cloudinit-was" {
  template = file("scripts/was-server/init.tpl")

  vars = {
    nfs_connect_info = var.nfs_connect_info
  }
}

data "template_file" "cloudinit-waf" {
  template = file("scripts/waf-server/init.tpl")
}
