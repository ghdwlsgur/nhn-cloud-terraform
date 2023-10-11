data "openstack_images_image_v2" "windows_2012_en" {
  name        = var.image-name
  tag         = "_AVAILABLE_"
  most_recent = true
}
