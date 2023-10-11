
data "openstack_images_image_v2" "web" {
  name        = var.web_image
  tag         = "_AVAILABLE_"
  most_recent = true
}

data "openstack_images_image_v2" "was" {
  name        = var.was_image
  tag         = "_AVAILABLE_"
  most_recent = true
}

data "openstack_images_image_v2" "waf" {
  name        = var.waf_image
  tag         = "_AVAILABLE_"
  most_recent = true
}
