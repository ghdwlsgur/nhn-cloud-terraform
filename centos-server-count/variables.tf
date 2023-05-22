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
  default = 4
}

variable "machines" {
  # type        = map(map(string))
  description = "nhn cloud virtual machine spec"
  type = map(object({
    name              = string
    availability_zone = string
    flavor_name       = string
    key_pair          = string
    nic_ip            = string
    role              = string
  }))

  default = {
    "server-1" = {
      name              = "web-server-1"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.11"
      role              = "web-server"
    }

    "server-2" = {
      name              = "web-server-2"
      availability_zone = "kr2-pub-b"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.12"
      role              = "web-server"
    }

    "server-3" = {
      name              = "was-server-1"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.13"
      role              = "was-server"
    }

    "server-4" = {
      name              = "was-server-2"
      availability_zone = "kr2-pub-b"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.14"
      role              = "was-server"
    }
  }

}
