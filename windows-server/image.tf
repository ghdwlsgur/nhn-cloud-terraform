data "openstack_images_image_v2" "windows_2012_en" {
  name        = "Windows 2012 R2 STD (2023.02.21) EN" // 이미지 설명
  tag         = "_AVAILABLE_"
  most_recent = true
}
