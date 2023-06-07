data "openstack_images_image_v2" "windows" {
  name        = var.image
  tag         = "_AVAILABLE_"
  most_recent = true
}
