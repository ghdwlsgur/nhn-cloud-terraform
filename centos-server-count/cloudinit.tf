data "cloudinit_config" "cloudinit-web" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = file("scripts/web-server/init.cfg")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("scripts/web-server/payload.sh")
  }
}

data "cloudinit_config" "cloudinit-was" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = file("scripts/was-server/init.cfg")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("scripts/was-server/payload.sh")
  }
}
