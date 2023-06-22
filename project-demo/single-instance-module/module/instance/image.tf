data "openstack_images_image_v2" "os_image" {
  name        = var.image
  tag         = "_AVAILABLE_"
  most_recent = true
}
