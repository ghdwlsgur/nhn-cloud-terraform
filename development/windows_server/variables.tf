variable "provider_openstack" {
  type        = map(string)
  description = "nhn cloud acccount access info"

  default = {
    region   = "KR2"
    auth_url = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  }
}

// 이미지 이름
variable "image-name" {
  type    = string
  default = "Ubuntu Server 20.04.6 LTS (2023.05.25)"
}


variable "machines" {
  type        = map(string)
  description = "nhn cloud virtual machine spec"
  default = {
    name              = ""             // 머신 이름
    availability_zone = "kr2-pub-a"    // 가용성 영역 (평촌)
    flavor_name       = "m2.c2m4"      // 인스턴스 타입
    key_pair          = "hongjinhyeok" // 키페어 명
  }
}
