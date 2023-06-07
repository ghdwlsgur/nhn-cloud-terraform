data "openstack_images_image_v2" "CentOS_7_9" {
  name        = "CentOS 7.9 (2023.05.25)"
  tag         = "_AVAILABLE_"
  most_recent = true
}

