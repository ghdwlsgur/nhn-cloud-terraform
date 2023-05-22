

data "openstack_images_image_v2" "CentOS_7_9" {
  name        = "CentOS 7.9 (2022.11.22)" // 이미지 설명
  tag         = "_AVAILABLE_"
  most_recent = true
}
