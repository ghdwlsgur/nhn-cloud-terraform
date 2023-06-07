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


variable "network" {
  type = map(string)

  default = {
    vpc_name    = "Default Network"
    subnet_name = "Default Network"
  }
}

variable "machines" {
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
    "web-server-1" = {
      name              = "DEMO-WEB-01"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.21"
      role              = "web-server"
    }

    "web-server-2" = {
      name              = "DEMO-WEB-02"
      availability_zone = "kr2-pub-b"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.22"
      role              = "web-server"
    }

    "web-server-3" = {
      name              = "DEMO-WEB-03"
      availability_zone = "kr2-pub-a"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.23"
      role              = "web-server"
    }

    "web-server-4" = {
      name              = "DEMO-WEB-04"
      availability_zone = "kr2-pub-b"
      flavor_name       = "m2.c2m4"
      key_pair          = "hongjinhyeok"
      nic_ip            = "192.168.0.24"
      role              = "web-server"
    }
  }

}

variable "nfs_connect_info" {
  type        = string
  description = "NAS 연결정보"
  default     = "192.168.0.100:/DEMO-NAS"
}
