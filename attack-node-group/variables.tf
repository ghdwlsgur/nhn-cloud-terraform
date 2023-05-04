variable "provider_openstack" {
  type        = map(string)
  description = "nhn cloud acccount access info"

  default = {
    region   = "KR2"
    auth_url = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  }
}


variable "machine_count" {
  type    = number
  default = 3
}

variable "machines" {
  type        = map(map(string))
  description = "nhn cloud virtual machine spec"
  default = {
    "node1" = {
      name              = "node1"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
    }
    "node2" = {
      name              = "node2"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
    }
    "node3" = {
      name              = "node3"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
    }
  }
}

