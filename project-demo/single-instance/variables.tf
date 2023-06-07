variable "provider_openstack" {
  type        = map(string)
  description = "nhn cloud acccount access info"

  default = {
    region   = "KR2"
    auth_url = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  }
}


variable "image" {
  type    = string
  default = "Windows 2022 STD (2023.05.25) KO"
}


variable "machines" {
  type        = map(string)
  description = "nhn cloud virtual machine spec"
  default = {
    name              = "Windows"
    availability_zone = "kr2-pub-a"
    flavor_name       = "m2.c2m4"
    key_pair          = "hongjinhyeok"
    nic_ipv4          = "192.168.0.10"
  }
}

variable "network" {
  type = map(string)

  default = {
    vpc_name    = "Default Network"
    subnet_name = "Default Network"
  }
}
